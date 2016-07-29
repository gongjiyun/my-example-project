/*
-----------------------------------------------
-- Insert of TBL_MT_TENANT_PROTOCOL
-----------------------------------------------
*/
INSERT INTO TBL_MT_AUTH_PROTOCOL
(`PROTOCOL_ID`, `PROTOCOL_NAME`, `PROTOCOL_DESC`, `PROTOCOL_TYPE`, `URL`, `CREATED_BY`, `CREATED_DT`, `UPDATED_BY`, `UPDATED_DT`, `VERSION`, `DN`, `PRINCIPAL`)
VALUES
('DEF-protocol-ntu-intvsuite', 'tester AD', 'tester AD', 'AD', 'ldap://192.168.171.222', 'DEF-user-superadmin', NOW(), 'DEF-user-superadmin', NOW(), 1,'DC=ilabs,DC=com,DC=sg', 'ILABS\\?');

/*
-----------------------------------------------
-- Insert of TBL_MT_TENANT
-----------------------------------------------
*/
INSERT INTO TBL_MT_TENANT
(`TENANT_ID`, `TENANT_NAME`, `TENANT_DESC`, `PROTOCOL_ID`, `DEFAULT_OU`, `GROUP_ID`, `REFERENCE_ID`, `CREATED_BY`, `CREATED_DT`, `UPDATED_BY`, `UPDATED_DT`, `VERSION`) 
VALUES 
('DEF-tenant-ntu-intvsuite', 'NTU InterviewSuite Tenant', 'NTU InterviewSuite Tenant', 'DEF-protocol-ntu-intvsuite','DEF-ou-ntu-intvsuite', 'DEF-group-ntu-intvsuite', 'DEF-store-ntu-intvsuite', 'DEF-user-superadmin', NOW(), 'DEF-user-superadmin', NOW(), 1);

/*
-----------------------------------------------
-- Insert of TBL_MT_TENANT_PROTOCOL
-----------------------------------------------
*/
INSERT INTO TBL_MT_TENANT_PROTOCOL
(`TENANT_ID`, `PROTOCOL_ID`, `CREATE_USER`, `UPDATE_USER`, `CREATED_BY`, `CREATED_DT`, `UPDATED_BY`, `UPDATED_DT`, `VERSION`)
VALUES
('DEF-tenant-ntu-intvsuite','DEF-protocol-ntu-intvsuite','Y', 'Y','DEF-user-superadmin', NOW(), 'DEF-user-superadmin',NOW(),1);

/*
-----------------------------------------------
-- Insert of TBL_AA_GROUP
-----------------------------------------------
*/
INSERT INTO TBL_AA_GROUP 
(`GROUP_ID`, `DOMAIN_NAME`, `GROUP_NAME`, `CREATED_DT`, `CREATED_BY`, `UPDATED_DT`, `UPDATED_BY`, `GROUP_PARENT_ID`, `VERSION`, `GROUP_TYPE`, `GROUP_LABEL`, `LEFT_INDEX`, `RIGHT_INDEX`)
VALUES
('DEF-group-ntu-intvsuite', 'NA', 'NTU InterviewSuite GROUP', NOW(), 'DEF-user-superadmin', NOW(), 'DEF-user-superadmin', 'REQ-group-extranet', 1, '', '', NULL, NULL);

/*
-----------------------------------------------
-- Insert of TBL_MC_STORE
-----------------------------------------------
*/
INSERT INTO TBL_MC_STORE
(`STORE_ID`, `STORE_NAME`, `STORE_DESC`, `TENANT_ID`, `CREATED_BY`, `CREATED_DT`, `UPDATED_BY`, `UPDATED_DT`, `VERSION`)
VALUES
('DEF-store-ntu-intvsuite', 'NTU InterviewSuite Store', 'NTU InterviewSuite Store', 'DEF-tenant-ntu-intvsuite', 'DEF-user-superadmin', NOW(), 'DEF-user-superadmin', NOW(), 1);

/*
-----------------------------------------------
-- Insert of TBL_MT_OU
-----------------------------------------------
*/
INSERT INTO TBL_MT_OU
(`OU_ID`, `OU_NAME`, `OU_DESC`, `OU_PARENT_ID`, `TENANT_ID`, `GROUP_ID`, `CREATED_BY`, `CREATED_DT`, `UPDATED_BY`, `UPDATED_DT`, `VERSION`) 
VALUES 
('DEF-ou-ntu-intvsuite', 'NTU InterviewSuite OU', 'NTU InterviewSuite Organisation Unit', NULL, 'DEF-tenant-ntu-intvsuite', 'DEF-group-ntu-intvsuite', 'DEF-user-superadmin', NOW(), 'DEF-user-superadmin', NOW(), 1);

/*
 * Beginning of Stored Procedure.
 * Copy the custom label value from "NTU InterviewSuite Tenant" to "Prime Tenant" 
 * so the subsequent tenant will inherit the custom label value from "Prime Tenant".
 */
DELIMITER $$
DROP PROCEDURE IF EXISTS SP_COPY_CUSTOM_LABEL_VALUE$$
CREATE PROCEDURE SP_COPY_CUSTOM_LABEL_VALUE()
BEGIN
    UPDATE tbl_mc_custom_label A, tbl_mc_custom_label B 
    SET A.`LABEL_VALUE` = B.`LABEL_VALUE`
    WHERE
        A.`TENANT_ID` = 'DEF-tenant-prime' 
        AND B.`TENANT_ID` = 'DEF-tenant-ntu-intvsuite'
        AND A.`LABEL_KEY` = B.`LABEL_KEY`;
END$$

DELIMITER ;
/* End of proceure */

/*
 * Beginning of Stored Procedure.
 * Synchronism all the tenant's custom_label_key and value
 * Suggest:
 *   1.always call "SP_COPY_CUSTOM_LABEL_VALUE" procedure before call "SP_SYNCHRO_TENANT_CUSTOM_LABEL_KEY" procedure.
 *   2.put this call command at the last row
 * 
 */
DELIMITER $$
DROP PROCEDURE IF EXISTS SP_SYNCHRO_TENANT_CUSTOM_LABEL_KEY$$
CREATE PROCEDURE SP_SYNCHRO_TENANT_CUSTOM_LABEL_KEY(in srcTenantId varchar(32))
BEGIN

    declare perTenantId varchar(32);
    declare perLabelKey varchar(100);
    declare perLabelValue varchar(500);
    declare perLabelType varchar(500);
    declare perLabelId varchar(128);

    declare fetchTenantOk boolean;
    declare fetchTenantIdCursor cursor for (select tenant_id from tbl_mt_tenant where tenant_id <> srcTenantId);
    declare exit handler for NOT FOUND set fetchTenantOk = true;
     
    set fetchTenantOk = false;

    -- delete custom label key
    drop temporary table if exists tmp_tbl_mc_custom_label;
    create temporary table tmp_tbl_mc_custom_label as(
        select * from tbl_mc_custom_label
    );
    delete from tbl_mc_custom_label
    where label_key not in (
        select a.label_key 
        from tmp_tbl_mc_custom_label a
        where a.tenant_id = srcTenantId
    ) and tenant_id != srcTenantId;


    -- update all custom label key's value
    update tbl_mc_custom_label a, tbl_mc_custom_label b
    set a.label_value = b.label_value
    where 
        b.tenant_id = srcTenantId
        and a.label_key = b.label_key
        and a.tenant_id != srcTenantId;

    -- Add custom label key
    open fetchTenantIdCursor;
    tenantLoop:Loop    -- Loop Tenant
        set perTenantId = 'NOT FOUND';
        if fetchTenantOk then
            leave tenantLoop;
        else
            fetch fetchTenantIdCursor into perTenantId;
            begin
                declare fetchLabelOk boolean;
                declare fetchLabelKeyCursor cursor for (select label_key from tbl_mc_custom_label where tenant_id = srcTenantId);
                declare exit handler for NOT FOUND set fetchLabelOk = true;

                set fetchLabelOk = false;

                open fetchLabelKeyCursor;
                customLabelKey:Loop    -- Loop Custom Label
                    set perLabelValue = 'NOT FOUND';
                    set perLabelType = 'NOT FOUND';
                    set perLabelId = 'NOT FOUND';
                    set perLabelKey = 'NOT FOUND';

                    if fetchLabelOk then
                        leave customLabelKey;
                    else
                        fetch fetchLabelKeyCursor into perLabelKey;
                        select label_value into perLabelValue from tbl_mc_custom_label  where label_key = perLabelKey and tenant_id = srcTenantId;
                        select label_type into perLabelType from tbl_mc_custom_label where label_key = perLabelKey and tenant_id = srcTenantId;
                        if (select count(label_id) from tbl_mc_custom_label where label_key = perLabelKey and label_type = perLabelType and tenant_id = perTenantId) = 0 then
                            set perLabelId = (select uuid());
                            set perLabelId = concat(DATE_FORMAT(NOW(),'%y%m%d%h%i%s'), left(replace(perLabelId, '-', ''), 20));
                            insert into `tbl_mc_custom_label`(`LABEL_ID`,`TENANT_ID`,`LABEL_KEY`,`LABEL_VALUE`,`LABEL_TYPE`,`CREATED_DT`,`CREATED_BY`,`UPDATED_DT`,`UPDATED_BY`,`VERSION`) 
                            values (perLabelId, perTenantId, perLabelKey, perLabelValue, perLabelType,now(),'DEF-user-superadmin',now(),'DEF-user-superadmin',1);
                        end if;
                    end if;
                end Loop;
                close fetchLabelKeyCursor;
            end;
        end if;
    end Loop;
    close fetchTenantIdCursor;
    drop temporary table if exists tmp_tbl_mc_custom_label;

END$$
DELIMITER ;

INSERT INTO `tbl_mc_custom_label`
(`LABEL_ID`,`TENANT_ID`,`LABEL_KEY`,`LABEL_VALUE`,`LABEL_TYPE`,`CREATED_DT`,`CREATED_BY`,`UPDATED_DT`,`UPDATED_BY`,`VERSION`) 
VALUES
('4','DEF-tenant-ntu-intvsuite','SVHDR_PUBLICATIONS','View Candidate','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('6','DEF-tenant-ntu-intvsuite','CLBL_TITLE','Candidate','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('9','DEF-tenant-ntu-intvsuite','SLST_BOOK','Resume','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('11','DEF-tenant-ntu-intvsuite','SSHDR_PUBLICATIONS','Search Candidate','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('12','DEF-tenant-ntu-intvsuite','CBTN_PUBLICATION','Listing','C','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('13','DEF-tenant-ntu-intvsuite','CHDR_RATE_BOOK','Rate Candidate','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('14','DEF-tenant-ntu-intvsuite','CHDR_CONTENT_RATE','Rating','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('16','DEF-tenant-ntu-intvsuite','CLBL_RATE','Rate','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('17','DEF-tenant-ntu-intvsuite','CLBL_PUBLISHER','Source','C','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('18','DEF-tenant-ntu-intvsuite','CLBL_RATE_BOOK','Rate Candidate','C','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('19','DEF-tenant-ntu-intvsuite','CHDR_BOOK_STORE','Resumes','C','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('20','DEF-tenant-ntu-intvsuite','CBTN_BOOK_STORE','Resumes','C','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('22','DEF-tenant-ntu-intvsuite','CMSG_LOAD_BOOK','Loading Resume','C','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('23','DEF-tenant-ntu-intvsuite','CMSG_NO_BOOK','No Resume Available','C','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('24','DEF-tenant-ntu-intvsuite','CMSG_DOWNLOAD_BOOK','Please start by browsing the CVs by clicking on the \"Resumes\" button from the right hand corner','C','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('25','DEF-tenant-ntu-intvsuite','CTXT_SEARCH_BOOK_DESC','Search Resumes','C','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('26','DEF-tenant-ntu-intvsuite','CMSG_DELETE_BOOK_TITLE','Delete Resume','C','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('27','DEF-tenant-ntu-intvsuite','CMSG_DELETE_BOOK','Are you sure you wish to delete this resume?','C','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('28','DEF-tenant-ntu-intvsuite','SHDR_NEW_PUB','New Resume','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('29','DEF-tenant-ntu-intvsuite','SHDR_EDIT_PUB','Configure and setup','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('30','DEF-tenant-ntu-intvsuite','SLBL_PUBLICATION','Resume Name','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('31','DEF-tenant-ntu-intvsuite','SMENU_PUBLICATIONS','Candidates','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('32','DEF-tenant-ntu-intvsuite','SMENU_ARC_PUBLICATION','Archive/Delete Candidate','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('33','DEF-tenant-ntu-intvsuite','SMENU_RES_PUBLICATION','Restore Candidate','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('34','DEF-tenant-ntu-intvsuite','SBTN_DELETE_PUBLICATION','Delete Resume','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('35','DEF-tenant-ntu-intvsuite','SVHDR_PUB_DETAILS','Resume Details','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('36','DEF-tenant-ntu-intvsuite','SSHDR_ARCHIVED','Search Candidate For Archive/Delete','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('37','DEF-tenant-ntu-intvsuite','SSHDR_RESTORE','Search Candidate For Restore','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('38','DEF-tenant-ntu-intvsuite','SMENU_ASS_MARK','Candidate Assessment','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('39','DEF-tenant-ntu-intvsuite','SMENU_BK_DET_RPT','Resume Download Report','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('40','DEF-tenant-ntu-intvsuite','SRHDR_BOOK_DET','Resume Download Report','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('41','DEF-tenant-ntu-intvsuite','SRHDR_ISBN','Ref. No','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('42','DEF-tenant-ntu-intvsuite','SSHDR_ASS_MARK','Candidate Assessment Submission','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('43','DEF-tenant-ntu-intvsuite','SLBL_ASS_SUBMIT_USER','Submitted Interviewer','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('44','DEF-tenant-ntu-intvsuite','SBTN_ANNOUNCE','Close Position','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('45','DEF-tenant-ntu-intvsuite','SVHDR_ASS_MARK','Candidate Assessment Submission:View','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('46','DEF-tenant-ntu-intvsuite','SVHDR_ASS_MARK1','View Submitted Candidate Appraisal Form','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('47','DEF-tenant-ntu-intvsuite','SVHDR_ASS_MARK2','Candidate Appraisal Result','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('48','DEF-tenant-ntu-intvsuite','SLBL_ASS_SUBMIT_USER_NAME','Interviewer User Name','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('49','DEF-tenant-ntu-intvsuite','SLBL_ASS_SUBMIT_USER_FULLNAME','Interviewer Name','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('50','DEF-tenant-ntu-intvsuite','SVHDR_ASS_MARK_READ_ONLY','Candidate Assessment Submission:Read Only','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('75','DEF-tenant-ntu-intvsuite','SMSG_ADD_OU','User group has been successfully added.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('80','DEF-tenant-ntu-intvsuite','SLST_TENANT_NAME_SELECT_LBL','-- Select Department --','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('81','DEF-tenant-ntu-intvsuite','button.category.add','Add New {0}','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('82','DEF-tenant-ntu-intvsuite','button.category.delete','Delete {0}','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('83','DEF-tenant-ntu-intvsuite','button.category.edit','Edit {0}','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('84','DEF-tenant-ntu-intvsuite','button.publication.edit.category.mapping','Edit Job Position/Interview Timeslot Mappings','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('85','DEF-tenant-ntu-intvsuite','button.search.category','Job Position/Interview Timeslot','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('86','DEF-tenant-ntu-intvsuite','label.category.details','{0} Details','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('87','DEF-tenant-ntu-intvsuite','label.category.first','Add As First Job Position/Interview Timeslot','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('88','DEF-tenant-ntu-intvsuite','label.category.image','{0} Image','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('89','DEF-tenant-ntu-intvsuite','label.category.new.image','New {0} Image','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('90','DEF-tenant-ntu-intvsuite','label.category.no.parent.category','No parent Job Position/Interview Timeslot','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('91','DEF-tenant-ntu-intvsuite','label.category.parent','Parent Job Position/Interview Timeslot','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('92','DEF-tenant-ntu-intvsuite','label.publication.categories','Job Position/Interview Timeslot','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('93','DEF-tenant-ntu-intvsuite','label.select.category.add.after','- Select Job Position/Interview Timeslot -','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('94','DEF-tenant-ntu-intvsuite','label.select.parent.category','- Select Parent Job Position/Interview Timeslot -','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('95','DEF-tenant-ntu-intvsuite','msg.category.added.successfully','{0} added successfully','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('96','DEF-tenant-ntu-intvsuite','msg.category.deleted.successfully','{0} deleted successfully','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('97','DEF-tenant-ntu-intvsuite','msg.category.not.found','{0} not found','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('98','DEF-tenant-ntu-intvsuite','msg.category.saved.successfully','{0} saved successfully','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('99','DEF-tenant-ntu-intvsuite','msg.content.category.mapping.updated.successfully','Resume\'s job position/interview timeslot updated successfully','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('100','DEF-tenant-ntu-intvsuite','msg.err.category.not.found','{0} not found','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('101','DEF-tenant-ntu-intvsuite','msg.publication.no.categories.mapped','No Job Position/Interview Timeslot mapped to this resume','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('102','DEF-tenant-ntu-intvsuite','title.mc.ebook.admin.category.add','Add {0}','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('103','DEF-tenant-ntu-intvsuite','title.mc.ebook.admin.category.edit','Edit {0}','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('104','DEF-tenant-ntu-intvsuite','title.mc.ebook.admin.category.search','Job Position/Interview Timeslot','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('105','DEF-tenant-ntu-intvsuite','title.mc.ebook.admin.category.view','View {0}','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('106','DEF-tenant-ntu-intvsuite','title.mc.ebook.admin.publication.edit.category.mapping','Edit Job Position/Interview Timeslot Mappings','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('107','DEF-tenant-ntu-intvsuite','title.mc.ebook.menu.categories','Job Position/Interview Timeslot','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('108','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M02-E001','Error encountered when retrieving {0} image. {0} image not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('109','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M02-E002','Error encountered when retrieving {0} image. Invalid {0}.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('110','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M02-E003','Error encountered when retrieving {0} image. {0} not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('111','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M20-E001','Error updating {0}. Invalid {0}.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('112','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M20-E002','Error updating {0}. You need to be logged in to perform this action.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('113','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M20-E003','Error updating {0}. Invalid {0}.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('114','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M20-E004','Error updating {0}. {0} not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('115','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M20-E005','Unexpected error encountered when updating {0}. Please try again later.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('116','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M20-E006','Error updating {0}. Cyclic parent relationship detected.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('117','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M20-E007','Error updating {0}. Error saving image file for {0}.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('118','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M20-E008','Error updating {0}. {0} has been modified elsewhere.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('119','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M20-E009','Error updating {0). Invalid {0} image file.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('120','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M21-E001','Error adding {0}. Invalid {0}.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('121','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M21-E002','Error adding {0}. You need to be logged in to perform this action.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('122','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M21-E003','Error adding {0}. Parent {1} not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('123','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M21-E004','Unexpected error encountered when adding {0}. Please try again later.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('124','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M21-E005','Error adding {0}. Error saving image file for {0}.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('125','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M21-E006','Error adding {0}. Invalid image file for {0}.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('126','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M21-E007','Error adding {0}. Invalid {0}.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('127','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M21-E008','Error adding {0}. Invalid {1}.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('128','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M21-E009','Error adding {0}. Invalid image file for {0}.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('129','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M21-E010','Error adding {0}. Error when adding {0} and User Group mapping.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('130','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M22-E001','Error deleting {0}. Invalid {0}.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('131','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M22-E002','Error deleting {0}. You need to be logged in to perform this action.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('132','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M22-E003','Error deleting {0}. {0} not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('133','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M22-E004','Error deleting {0}. There are still resumes mapped to this {0}. Please remove these mappings first.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('134','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M22-E005','Unexpected error encountered when deleting {0}. Please try again later.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('135','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M22-E006','Error deleting {0}. Invalid {0}.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('136','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M22-E007','Error deleting {0}. {0} has been modified elsewhere.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('137','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M22-E008','Error deleting {0}. {0} is parents to other {0}.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('138','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M23-E001','Error updating resume job position/interview timeslot. Invalid resume.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('139','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M23-E002','Error updating resume job position/interview timeslot. Invalid job position/interview timeslot.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('140','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M23-E003','Error updating resume job position/interview timeslot. You need to be logged in to perform this action.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('141','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M23-E004','Error updating resume job position/interview timeslot. Resume not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('142','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M23-E005','Error updating resume job position/interview timeslot. Invalid job position/interview timeslot.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('143','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M23-E006','Error updating resume job position/interview timeslot. Job Position/Interview Timeslot not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('144','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M23-E007','Unexpected error encountered when updating resume job position/interview timeslot. Please try again later.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('145','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M23-E008','Unexpected error encountered when updating resume job position/interview timeslot. Please try again later.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('146','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M40-E001','Error retrieving all children of {0}. Invalid {0}.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('147','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M40-E002','Error retrieving all children of {0}. {0} not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('148','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M43-E001','Error retrieving all non-children {0}. Invalid {0}.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('149','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M43-E002','Error retrieving all non-children {0}. {0} not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('150','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M44-E001','Error retrieving {0}. Invalid {0}.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('151','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M44-E002','Error retrieving {0}. Invalid {0}.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('152','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M45-E001','Error retrieving {0}. Invalid {0} title.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('153','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M46-E001','Error retrieving job position/interview timeslot resumes. Invalid job position/interview timeslot.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('154','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M46-E002','Error retrieving job position/interview timeslot resumes. Job Position/Interview Timeslot not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('155','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M47-E001','Error retrieving children of {0}. Invalid {0}.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('156','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M49-E001','Error retrieving resume job position/interview timeslot. Invalid resume.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('157','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M49-E002','Error retrieving resume job position/interview timeslot. Resume not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('158','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M57-E001','Error mapping resume to job position/interview timeslot. Invalid resume.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('159','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M57-E002','Error mapping resume to job position/interview timeslot. Invalid job position/interview timeslot.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('160','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M57-E003','Error mapping resume to job position/interview timeslot. You need to be logged in to perform this action.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('161','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M57-E004','Error mapping resume to job position/interview timeslot. Resume not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('162','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M57-E005','Error mapping resume to job position/interview timeslot. Job position/Interview Timeslot not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('163','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M57-E006','Unexpected error encountered when mapping resume to job position/interview timeslot. Please try again later.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('167','DEF-tenant-ntu-intvsuite','button.tenant.add','Add School/Department','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('168','DEF-tenant-ntu-intvsuite','button.tenant.delete','Delete School/Department','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('169','DEF-tenant-ntu-intvsuite','label.administrator.tenant','School/Department','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('170','DEF-tenant-ntu-intvsuite','label.tenant.tenantname','School/Department Name','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('171','DEF-tenant-ntu-intvsuite','label.tenant.tenantdesc','School/Department Description','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('172','DEF-tenant-ntu-intvsuite','label.tenant.addtenant','Add School/Department','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('173','DEF-tenant-ntu-intvsuite','label.tenant.update','Edit School/Department','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('174','DEF-tenant-ntu-intvsuite','label.select.notenant','No School/Department','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('175','DEF-tenant-ntu-intvsuite','label.select.anytenant','- Any School/Department -','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('176','DEF-tenant-ntu-intvsuite','label.select.tenant','-- Select School/Department --','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('177','DEF-tenant-ntu-intvsuite','label.mc.ebook.admin.custom.label.any.tenant','Any School/Department','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('178','DEF-tenant-ntu-intvsuite','msg.tenant.aad.successfully','School/Department has been successfully added','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('179','DEF-tenant-ntu-intvsuite','msg.tenant.updated.successfully','School/Department information updated successfully','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('180','DEF-tenant-ntu-intvsuite','msg.tenant.deleted.successfully','School/Department has been successfully deleted','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('181','DEF-tenant-ntu-intvsuite','msg.err.updating.tenant','Error in updating school/department','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('182','DEF-tenant-ntu-intvsuite','msg.err.deleting.tenant','Error in delete school/department','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('183','DEF-tenant-ntu-intvsuite','msg.err.aad.tenant','Error in add school/department','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('184','DEF-tenant-ntu-intvsuite','title.mc.ebook.admin.tenant.search','Search School/Department','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('185','DEF-tenant-ntu-intvsuite','title.mc.ebook.admin.tenant.add','Add School/Department','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('186','DEF-tenant-ntu-intvsuite','title.mc.ebook.admin.tenant.update','Edit School/Department','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('187','DEF-tenant-ntu-intvsuite','title.mc.ebook.menu.tenants','School/Department','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('188','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S03-M02-E005','The login name entered has already been used by someone from this School/Department or another. Please try again.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('189','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S03-M02-E006','The email address entered has already been used by someone from this School/Department or another. Please try again.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('190','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S03-M10-E001','Error add school/department. Invalid school/department. ','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('191','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S03-M10-E002','Error when adding school/department: Duplicated school/department name.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('192','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S03-M13-E013','The account number entered has already been used by someone from this School/Department or another. Please try again. ','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('193','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S04-M04-E001','The School/Department Id you provided is incorrect.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('194','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S04-M05-E003','The School/Department Id you provided is incorrect.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('195','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S04-M06-E002','The School/Department Id you provided is incorrect.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('196','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S04-M07-E002','The School/Department Id you provided is incorrect.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('197','DEF-tenant-ntu-intvsuite','errors.cloud.annotation.tenant.id.empty','School/Department Id is empty.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('198','DEF-tenant-ntu-intvsuite','button.mtuser.delete.from.ou','Delete User From User Group','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('199','DEF-tenant-ntu-intvsuite','button.mtuser.add','Add User To User Group','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('200','DEF-tenant-ntu-intvsuite','button.ou.add','Add New User Group','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('201','DEF-tenant-ntu-intvsuite','button.ou.edit','Edit User Group','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('202','DEF-tenant-ntu-intvsuite','button.ou.delete','Delete User Group','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('203','DEF-tenant-ntu-intvsuite','label.category.view.ou','Viewable User Group(s)','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('204','DEF-tenant-ntu-intvsuite','label.category.create.ou','Publishable User Group(s)','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('205','DEF-tenant-ntu-intvsuite','label.user.ou','User Group','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('206','DEF-tenant-ntu-intvsuite','label.administrator.ou','User Group','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('207','DEF-tenant-ntu-intvsuite','label.select.parents.ou','- Select User Group Parents -','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('208','DEF-tenant-ntu-intvsuite','label.select.noparent.ou','No Parent User Group','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('209','DEF-tenant-ntu-intvsuite','label.ou.addou','Add User Group','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('210','DEF-tenant-ntu-intvsuite','label.ou.editou','Edit User Group','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('211','DEF-tenant-ntu-intvsuite','label.ou.delete','Delete User Group','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('212','DEF-tenant-ntu-intvsuite','label.ou.users','Users in User Group','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('213','DEF-tenant-ntu-intvsuite','label.select.anyous','- Any User Group -','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('214','DEF-tenant-ntu-intvsuite','label.publisher.ouname','User Group Name','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('215','DEF-tenant-ntu-intvsuite','label.select.publisher.ouname','- Select Publisher User Group Name -','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('216','DEF-tenant-ntu-intvsuite','msg.ou.added.successfully','User Group added successfully','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('217','DEF-tenant-ntu-intvsuite','msg.ou.updated.successfully','User Group updated successfully','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('218','DEF-tenant-ntu-intvsuite','msg.ou.deleted.successfully','User Group has been successfully deleted','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('219','DEF-tenant-ntu-intvsuite','msg.err.deleting.ou','Error in deleting User Group. One or more of them may currently being used.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('220','DEF-tenant-ntu-intvsuite','title.mc.ebook.admin.ou.view','View User Group','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('221','DEF-tenant-ntu-intvsuite','title.mc.ebook.admin.ou.add','Add User Group','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('222','DEF-tenant-ntu-intvsuite','title.mc.ebook.admin.ou.edit','Edit User Group','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('223','DEF-tenant-ntu-intvsuite','title.mc.ebook.admin.ou.search','Search User Group','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('224','DEF-tenant-ntu-intvsuite','title.mc.ebook.admin.ou.delete','Delete User Group','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('225','DEF-tenant-ntu-intvsuite','title.mc.ebook.menu.ous','User Group','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('226','DEF-tenant-ntu-intvsuite','title.mc.ebook.menu.ou.administration','User Group Administration','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('227','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M66-E009','Error adding annotation package. User Group list is null.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('228','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M80-E001','Error while retrieving Preview User Group. Preview is null.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('229','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M80-E002','Error while retrieving Preview User Group. Preview Id is not available.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('230','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M80-E003','Error while retrieving Preview User Group. Preview not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('231','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M83-E001','Error in updating Preview User Groups. Preview Id not available.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('232','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M83-E002','Error in updating Preview User Groups. Preview User Groups is null.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('233','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M83-E003','Error in updating Preview User Groups. Actor Id is null.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('234','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M83-E004','Error in updating Preview User Groups. Unexpected when adding Preview User Group.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('235','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M83-E005','Error in updating Preview User Groups. Unexpected when deleting Preview User Group.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('236','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M91-E001','Error when retrieving all User Group and its descendants job position/interview timeslot. User Group Id is null.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('237','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M92-E001','Error when retrieving all User Group and its descendants job position/interview timeslot. Job Position/Interview Timeslot Id is null.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('238','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M92-E002','Error when retrieving all User Group and its descendants job position/interview timeslot that are non children. User Group Id is null.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('239','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M94-E004','Error when deleting publication preview. Failure to delete Preview User Group.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('240','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S03-M09-E001','Error get users by User Group Id. Invalid User Group Id.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('241','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S04-M02-E001','Error while creating group. User Group is null.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('242','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S04-M02-E002','Error while creating group. User Group not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('243','DEF-tenant-ntu-intvsuite','label.publication.preview.ous','Preview User Group','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('244','DEF-tenant-ntu-intvsuite','label.ou.ouname','User Group Name','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('245','DEF-tenant-ntu-intvsuite','label.ou.ouparents','User Group Parents','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('246','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S04-M01-E001','Error while adding User Group. User Group is null.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('247','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S04-M01-E002','Error while adding User Group. User Group Name is null.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('248','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S04-M01-E003','Error while adding User Group. User Group exists.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('249','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S04-M01-E004','Error while adding User Group. Unexpected Exception.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('250','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S04-M01-E005','Error while adding User Group. Unexpected Exception.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('251','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S04-M01-E006','Error while adding User Group. Unexpected Exception.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('252','DEF-tenant-ntu-intvsuite','label.ou.oudesc','User Group Description','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('253','DEF-tenant-ntu-intvsuite','CLBL_LST_ALL_BOOK','ALL Resumes','C','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('254','DEF-tenant-ntu-intvsuite','CBTN_IN_BOOK_SEARCH','In-Resume Search','C','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('255','DEF-tenant-ntu-intvsuite','CLBL_END_PAGE','End of Resume','C','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('256','DEF-tenant-ntu-intvsuite','CBTN_VIEW_BOOK','VIEW RESUME','C','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('257','DEF-tenant-ntu-intvsuite','CMSG_ADD_RATE','Rating added successfully. Thank you for rating this resume.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('258','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M83-E006','Error in deleting School/Department. One or more of them may currently being used.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('259','DEF-tenant-ntu-intvsuite','label.category.root','{0}','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('260','DEF-tenant-ntu-intvsuite','label.setting.category.depth.max','Maximum Job Position/Interview Timeslot Depth Level','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('261','DEF-tenant-ntu-intvsuite','CATEGORY_LEVEL_1','Job Position','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('262','DEF-tenant-ntu-intvsuite','CATEGORY_LEVEL_2','Interview Timeslot','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('263','DEF-tenant-ntu-intvsuite','label.category.title','{0}','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('264','DEF-tenant-ntu-intvsuite','button.content.add','Add New Resume','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('265','DEF-tenant-ntu-intvsuite','button.content.append','Append Resume','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('266','DEF-tenant-ntu-intvsuite','button.return.view.content','Return to View Resume','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('267','DEF-tenant-ntu-intvsuite','button.content.create','Create Resume','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('268','DEF-tenant-ntu-intvsuite','button.content.edit','Edit Resume','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('269','DEF-tenant-ntu-intvsuite','button.content.import','Import Resume','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('270','DEF-tenant-ntu-intvsuite','button.content.publish','Publish Resume','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('271','DEF-tenant-ntu-intvsuite','button.content.unpublish','Unpublish Resume','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('272','DEF-tenant-ntu-intvsuite','button.content.view','View Resume','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('273','DEF-tenant-ntu-intvsuite','button.content.delete','Delete Resume','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('274','DEF-tenant-ntu-intvsuite','button.content.recovery','Recover Resume','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('275','DEF-tenant-ntu-intvsuite','button.publication.create.from.content','Create Publication from Resume','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('276','DEF-tenant-ntu-intvsuite','label.content.additional.append','Append to Existing Resume','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('277','DEF-tenant-ntu-intvsuite','label.content.additional.new','New Resume','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('278','DEF-tenant-ntu-intvsuite','label.content.additional.options','Resume Additional Options','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('279','DEF-tenant-ntu-intvsuite','label.content.append','Append Existing Resume','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('280','DEF-tenant-ntu-intvsuite','label.content.author','Creator','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('281','DEF-tenant-ntu-intvsuite','label.content.details','Resume Bibliography','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('282','DEF-tenant-ntu-intvsuite','label.content.import','Import Resume','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('283','DEF-tenant-ntu-intvsuite','label.content.isbn','Reference No','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('284','DEF-tenant-ntu-intvsuite','label.content.new','New Resume','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('285','DEF-tenant-ntu-intvsuite','label.content.package.file','Resume file','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('286','DEF-tenant-ntu-intvsuite','label.content.publisher','Source * (Eg \"Jobstreet, Email, etc\")','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('287','DEF-tenant-ntu-intvsuite','label.content.options.append','Append to Existing Resume','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('288','DEF-tenant-ntu-intvsuite','label.content.options.new','New Resume','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('289','DEF-tenant-ntu-intvsuite','label.content.rating','Resume Rating','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('290','DEF-tenant-ntu-intvsuite','label.content.title','Candidate','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('291','DEF-tenant-ntu-intvsuite','label.contents','Resumes','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('292','DEF-tenant-ntu-intvsuite','label.select.content','- Select Resume -','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('293','DEF-tenant-ntu-intvsuite','label.thread.content','Resume','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('294','DEF-tenant-ntu-intvsuite','label.wizard.upload.content','Upload Resume','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('295','DEF-tenant-ntu-intvsuite','label.wizard.modify.content','Modify Resume','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('296','DEF-tenant-ntu-intvsuite','msg.content.cloned.successfully','Resume cloned successfully','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('297','DEF-tenant-ntu-intvsuite','msg.content.deleted.successfully','Resume deleted successfully','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('298','DEF-tenant-ntu-intvsuite','msg.content.published.successfully','Resume published succesfully','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('299','DEF-tenant-ntu-intvsuite','msg.content.saved.successfully','Resume saved successfully','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('300','DEF-tenant-ntu-intvsuite','msg.content.unpublished.successfully','Resume unpublished successfully','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('301','DEF-tenant-ntu-intvsuite','msg.content.uploaded','Resume uploaded successfully','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('302','DEF-tenant-ntu-intvsuite','title.mc.ebook.admin.content.add','Add Resume','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('303','DEF-tenant-ntu-intvsuite','title.mc.ebook.admin.content.edit','Edit Resume','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('304','DEF-tenant-ntu-intvsuite','title.mc.ebook.admin.content.import','Import Resume','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('305','DEF-tenant-ntu-intvsuite','title.mc.ebook.admin.content.page.edit','Resume Editor','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('306','DEF-tenant-ntu-intvsuite','title.mc.ebook.admin.content.publish','Publish Resume','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('307','DEF-tenant-ntu-intvsuite','title.mc.ebook.admin.content.search','Search Resumes','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('308','DEF-tenant-ntu-intvsuite','title.mc.ebook.admin.replace.content.search','Search Replace Resumes','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('309','DEF-tenant-ntu-intvsuite','title.mc.ebook.admin.append.content.search','Search Append Resumes','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('310','DEF-tenant-ntu-intvsuite','title.mc.ebook.admin.resume.content.search','Search Continue Resumes','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('311','DEF-tenant-ntu-intvsuite','title.mc.ebook.admin.edit.content.search','Search Edit Resumes','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('312','DEF-tenant-ntu-intvsuite','title.mc.ebook.admin.content.deleted.search','Search Deleted Resume','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('313','DEF-tenant-ntu-intvsuite','title.mc.ebook.admin.content.view','View Resume','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('314','DEF-tenant-ntu-intvsuite','title.mc.ebook.admin.express.wizard.upload.content','Express Wizard: Upload Resume','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('315','DEF-tenant-ntu-intvsuite','title.mc.ebook.admin.publish.wizard.upload.content','Create New Resume: Upload Resume','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('316','DEF-tenant-ntu-intvsuite','title.mc.ebook.admin.replace.wizard.search','Replace Wizard: Search Resume','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('317','DEF-tenant-ntu-intvsuite','title.mc.ebook.admin.replace.wizard.upload.content','Replace Wizard: Upload Resume','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('318','DEF-tenant-ntu-intvsuite','title.mc.ebook.admin.append.publish.wizard','Append Wizard: Search Resume','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('319','DEF-tenant-ntu-intvsuite','title.mc.ebook.admin.append.wizard.upload.content','Append Wizard: Upload Resume','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('320','DEF-tenant-ntu-intvsuite','title.mc.ebook.admin.resume.publish.wizard','Edit Unpublished Resume: Search Resume','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('321','DEF-tenant-ntu-intvsuite','title.mc.ebook.admin.edit.publish.wizard','Edit Published Resume: Search Resume','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('322','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M01-E001','Error encountered when adding resume. Invalid resume.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('323','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M01-E002','Error encountered when adding resume. Error encountered when saving resume.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('324','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M01-E003','Error encountered when adding resume. Error encountered when saving resume.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('325','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M01-E004','Error encountered when adding resume. Error encountered when saving pages.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('326','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M01-E005','Error encountered when adding resume. Error encountered when saving table of content entries.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('327','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M01-E006','Error encountered when adding resume. You need to be logged in to perform this action.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('328','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M01-E007','Error encountered when adding resume. Invalid resume.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('329','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M01-E008','Error encountered when adding resume. Invalid resume.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('330','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M03-E001','Error encountered when retrieving resume package. Resume not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('331','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M03-E002','Error encountered when retrieving resume package. Resume not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('332','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M03-E003','Error encountered when retrieving resume package. Invalid resume.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('333','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M04-E001','Error encountered when retrieving resume cover page. Cover page not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('334','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M04-E002','Error encountered when retrieving resume cover page. Resume not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('335','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M04-E003','Error encountered when retrieving resume cover page. Invalid resume.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('336','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M05-E001','Error encountered when retrieving resume summary package. Resume summary package not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('337','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M05-E002','Error encountered when retrieving resume summary package. Resume not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('338','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M05-E003','Error encountered when retrieving resume summary package. Invalid resume.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('339','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M06-E002','Error encountered when retrieving thumbnails package. Resume not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('340','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M06-E003','Error encountered when retrieving thumbnails package. Invalid resume.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('341','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M07-E002','Error encountered when retrieving page. Resume not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('342','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M07-E004','Error encountered when retrieving page. Invalid resume page.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('343','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M07-E005','Error encountered when retrieving page. Invalid resume.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('344','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M08-E001','Error encountered when updating resume. Invalid resume.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('345','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M08-E002','Error encountered when updating resume. You need to be logged in to perform this action.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('346','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M08-E003','Error encountered when updating resume. Resume not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('347','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M08-E004','Error encountered when updating resume. Resume already published.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('348','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M08-E005','Error encountered when updating resume. Resume has been modified elsewhere.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('349','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M08-E006','Unexpected error encountered when updating resume. Please try again later.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('350','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M08-E007','Error encountered when updating resume. Invalid resume.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('351','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M09-E001','Error encountered when publishing resume. Invalid resume.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('352','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M09-E002','Error encountered when publishing resume. You need to be logged in to perform this action.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('353','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M09-E003','Error encountered when publishing resume. Resume not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('354','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M09-E004','Error encountered when publishing resume. Resume already published.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('355','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M09-E005','Unexpected error encountered when publishing resume. Please try again later.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('356','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M09-E006','Error encountered when publishing resume. Resume has been modified elsewhere.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('357','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M09-E007','Error encountered when publishing resume. Invalid resume.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('358','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M09-E008','Error encountered when publishing resume. Invalid publication.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('359','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M09-E009','Error encountered when publishing resume. Publication not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('360','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M09-E010','Error encountered when publishing resume. Resume has been modified elsewhere.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('361','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M09-E011','Error encountered when publishing resume. Resume package null.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('362','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M10-E001','Error encountered when unpublishing resume. Invalid resume.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('363','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M10-E002','Error encountered when unpublishing resume. You need to be logged in to perform this action.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('364','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M10-E003','Error encountered when unpublishing resume. Resume not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('365','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M10-E004','Error encountered when unpublishing resume. Resume is not published.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('366','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M10-E005','Unexpected error encountered when unpublishing resume. Please try again later.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('367','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M10-E006','Error encountered when unpublishing resume. Invalid resume.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('368','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M10-E007','Error encountered when unpublishing resume. Publication not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('369','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M10-E008','Error encountered when unpublishing resume. Resume has been modified elsewhere.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('370','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M11-E002','Error encountered when retrieving image file for page. Resume not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('371','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M11-E005','Error encountered when retrieving image file for page. Invalid resume.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('372','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M12-E004','Error adding table of content entry. Invalid resume.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('373','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M12-E006','Error adding table of content entry. Resume not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('374','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M12-E008','Error adding table of content entry. Invalid start page for resume.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('375','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M12-E009','Error adding table of content entry. Resume already published.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('376','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M13-E005','Error deleting table of content entry. Resume already published.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('377','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M14-E004','Error updating table of content entry. Invalid resume.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('378','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M14-E006','Error updating table of content entry. Resume not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('379','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M14-E008','Error updating table of content entry. Invalid start page for resume.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('380','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M14-E009','Error updating table of content entry. Resume already published.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('381','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M16-E001','Error generating resume metadata file.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('382','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M16-E002','Error writing resume metadata file.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('383','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M17-E001','Error writing resume summary package.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('384','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M18-E001','Error writing resume package.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('385','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M24-E001','Error uploading resume. Invalid resume.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('386','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M24-E002','Error uploading resume. Invalid resume package.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('387','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M24-E003','Error uploading resume. Invalid resume file.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('388','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M24-E004','Error uploading resume. Invalid resume file.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('389','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M24-E005','Error uploading resume. Invalid resume file.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('390','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M24-E006','Error uploading resume. Cannot retrieve height and width.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('391','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M25-E001','Error processing resume. Error encountered when processing pages.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('392','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M25-E002','Error processing resume. Error encountered when optimizing pages.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('393','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M25-E003','Error processing resume. Error encountered when merging pages.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('394','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M25-E004','Error processing resume. Error encountered when writing cover page.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('395','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M25-E005','Error processing resume. Invalid resume.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('396','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M25-E006','Error processing resume. You need to be logged in to perform this action.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('397','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M25-E007','Error processing resume. Resume not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('398','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M25-E008','Error processing resume. Resume not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('399','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M25-E009','Unexpected error encountered when processing resume. Please try again later.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('400','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M25-E010','Unexpected error encountered when processing resume. Please try again later.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('401','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M26-E006','Error adding hotspot. Resume not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('402','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M26-E008','Error adding hotspot. Invalid resume.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('403','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M27-E006','Error deleting hotspot. Resume not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('404','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M29-E006','Error updating hotspot. Resume not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('405','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M30-E003','Error getting hotspots of page. Invalid resume.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('406','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M31-E004','Error retrieving hotspot\'s media file. Resume page not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('407','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M31-E005','Error retrieving hotspot\'s media file. Resume not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('408','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M36-E002','Error retrieving media file. Resume not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('409','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M36-E004','Error retrieving media file. Invalid resume.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('410','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M37-E005','Error adding media. Invalid resume.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('411','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M37-E006','Error adding media. Resume not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('412','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M38-E005','Error updating media. Resume not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('413','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M38-E008','Error updating media. Resume modified elsewhere.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('414','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M39-E005','Error deleting media. Resume not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('415','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M41-E001','Error retrieving all resume media. Invalid resume.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('416','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M41-E002','Error retrieving all resume media. Resume not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('417','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M42-E001','Error retrieving resume table of content. Invalid resume.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('418','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M42-E002','Error retrieving resume table of content. Invalid resume.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('419','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M42-E003','Error retrieving resume table of content. Resume not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('420','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M48-E001','Error retrieving resume. Invalid resume.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('421','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M48-E002','Error retrieving resume. Invalid resume.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('422','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M50-E001','Error retrieving resume details. Invalid resume.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('423','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M50-E002','Error retrieving resume details. Invalid resume.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('424','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M50-E003','Error retrieving resume details. Resume not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('425','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M50-E004','Error retrieving resume details. Resume not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('426','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M51-E001','Error retrieving resume media. Invalid resume media.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('427','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M51-E002','Error retrieving resume media. Invalid resume media.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('428','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M52-E001','Error retrieving resume page. Invalid resume page.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('429','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M52-E002','Error retrieving resume page. Invalid resume page.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('430','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M52-E003','Error retrieving resume page. Invalid resume.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('431','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M53-E001','Error retrieving resume page. Invalid resume page.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('432','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M53-E002','Error retrieving resume page. Invalid page number.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('433','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M55-E001','Error retrieving table of content entry. Invalid resume page.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('434','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M55-E002','Error retrieving table of content entry. Resume page not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('435','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M55-E003','Error retrieving table of content entry. Invalid resume.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('436','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M56-E001','Error retrieving number of pages. Invalid resume.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('437','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M56-E002','Error retrieving number of pages. Resume not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('438','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M58-E001','Error cloning resume. Invalid resume.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('439','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M58-E002','Error cloning resume. Invalid resume.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('440','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M58-E003','Error cloning resume. Resume not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('441','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M58-E004','Error cloning resume. Resume package not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('442','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M58-E005','Error cloning resume. Resume directory not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('443','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M58-E006','Unexpected error encountered when cloning resume. Please try again later.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('444','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M58-E007','Unexpected error encountered when cloning resume. Please try again later.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('445','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M58-E008','Unexpected error encountered when cloning resume. Please try again later.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('446','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M58-E009','Unexpected error encountered when cloning resume. Please try again later.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('447','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M58-E010','Unexpected error encountered when cloning resume. Please try again later.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('448','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M58-E011','Unexpected error encountered when cloning resume. Please try again later.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('449','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M58-E012','Unexpected error encountered when cloning resume. Please try again later.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('450','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M58-E013','Unexpected error encountered when cloning resume. Please try again later.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('451','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M58-E014','Unexpected error encountered when cloning resume. Please try again later.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('452','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M58-E015','Unexpected error encountered when cloning resume. Please try again later.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('453','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M60-E001','Error adding page. Invalid resume.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('454','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M60-E002','Error adding page. Invalid resume.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('455','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M60-E005','Error adding page. Resume not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('456','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M61-E002','Error deleting page. Invalid resume.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('457','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M61-E005','Error deleting page. Resume not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('458','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M70-E006','Error adding annotation. Resume page not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('459','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M76-E001','Error encountered when retrieving resume hotspot. Resume Id is null.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('460','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M76-E002','Error encountered when retrieving resume hotspot. Resume is null.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('461','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M77-E001','Source resume is not available.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('462','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M77-E002','Source resume is not available.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('463','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M77-E003','Appending resume is not available.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('464','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M77-E004','Appending resume is not available.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('465','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M77-E005','Appending resume is not available.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('466','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M77-E006','Appending resume is not available.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('467','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M77-E007','Source resume does not existing.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('468','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M77-E008','Source resume package does not existing.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('469','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M77-E009','Error while appending resume. Cannot write resume.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('470','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M77-E010','Error while appending resume. Cannot copy directory.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('471','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M77-E011','Error while appending resume. Error writing packages.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('472','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M77-E012','Error while appending resume. Error writing pages.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('473','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M77-E013','Error while appending resume. Error writing medias.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('474','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M77-E014','Error while appending resume. Error writing TOCs.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('475','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M77-E015','Error while appending resume. Error writing hotspots.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('476','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M77-E016','Error while appending resume. Error writing questions.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('477','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M77-E017','Error while appending resume. Error writing mapping.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('478','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M77-E018','Error while appending resume. Error while unzipping.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('479','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M77-E019','Error while appending resume. Error while splitting PDF.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('480','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M77-E020','Error while appending resume. Error while Meta Datas.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('481','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M77-E021','Error while appending resume. Error while content2assignment.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('482','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M90-E001','Error when updating publication device images. Resume Id is null.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('483','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M90-E002','Error when updating publication device images. Resume not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('484','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M90-E003','Error when updating publication device images. Resume package not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('485','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M95-E001','Error processing resume. Resume not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('486','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M95-E002','Error processing resume. Source resume not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('487','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M95-E003','Error processing resume. You need to be logged in to perform this action.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('488','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M95-E004','Error processing resume. Resume not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('489','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M95-E005','Error processing resume. Source Resume not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('490','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M95-E006','Error processing resume. Resume not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('491','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M95-E007','Error processing resume. Source Resume not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('492','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M95-E008','Error processing resume. Error encountered when processing pages.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('493','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M95-E009','Error processing resume. Error encountered when optimizing pages.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('494','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M95-E010','Error processing resume. Error encountered when writing cover page.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('495','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M95-E011','Unexpected error encountered when processing resume. Please try again later.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('496','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M95-E012','Unexpected error encountered when processing resume. Please try again later.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('497','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M95-E013','Unexpected error encountered when processing resume. Please try again later.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('498','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M95-E014','Unexpected error encountered when processing resume. Please try again later.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('499','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M96-E001','Error while complete publication. Resume is null.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('500','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M96-E004','Error while complete publication. Resume Id not available.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('501','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M96-E005','Error while complete publication. Resume not found.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('502','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M96-E006','Error while complete publication. Resume already published.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('503','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S01-M96-E007','Error while complete publication. Resume already previewing.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('504','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S02-M10-E001','Error mapping resume to offer. Invalid resume.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('505','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S02-M10-E002','Error mapping resume to offer. Invalid offer code.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('506','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S02-M10-E003','Error mapping resume to offer. Invalid resume.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('507','DEF-tenant-ntu-intvsuite','MSG.ERR.MCEBOOK-S02-M10-E004','Unexpected error encountered when mapping resume to offer. Please try again later.','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('508','DEF-tenant-ntu-intvsuite','title.mc.ebook.admin.edit.publish.wizard.moidfy.content','Edit Published Resume: Modify Resume','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('509','DEF-tenant-ntu-intvsuite','title.mc.ebook.menu.contents','Resumes','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('510','DEF-tenant-ntu-intvsuite','label.content.publication.dt','Date of Submission','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('511','DEF-tenant-ntu-intvsuite','CMSG_NO_CATEGORY','No Job Position/Interview Timeslot Available','C','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('512','DEF-tenant-ntu-intvsuite','title.mc.ebook.menu.wizard.publish','Create New Resume','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('513','DEF-tenant-ntu-intvsuite','title.mc.ebook.menu.wizard.append','Append Wizard','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('514','DEF-tenant-ntu-intvsuite','title.mc.ebook.menu.wizard.express','Express Wizard','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('515','DEF-tenant-ntu-intvsuite','title.mc.ebook.menu.wizard.replace','Replace Wizard','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('516','DEF-tenant-ntu-intvsuite','title.mc.ebook.menu.wizard.resume','Edit Unpublished Resume','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('517','DEF-tenant-ntu-intvsuite','title.mc.content.hotspot.header.mcq.add','Add Rating Form (the value for choice must be numeric)','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('518','DEF-tenant-ntu-intvsuite','title.mc.content.hotspot.header.essay.add','Add Feedback Form','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('519','DEF-tenant-ntu-intvsuite','title.mc.content.hotspot.header.mcq.edit','Edit Rating Form (the value for choice must be numeric)','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('520','DEF-tenant-ntu-intvsuite','title.mc.content.hotspot.header.essay.edit','Edit Feedback Form','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('521','DEF-tenant-ntu-intvsuite','title.mc.content.hotspot.mcq','Add Rating Form','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('522','DEF-tenant-ntu-intvsuite','title.mc.content.hotspot.essay','Add Feedback Form','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('523','DEF-tenant-ntu-intvsuite','label.wizard.publish.or.preview','Publish','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('524','DEF-tenant-ntu-intvsuite','title.mc.ebook.admin.publish.wizard.publish.preview','Create New Resume: Publish','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('525','DEF-tenant-ntu-intvsuite','title.mc.ebook.admin.replace.wizard.publish.preview','Replace Wizard: Publish','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('526','DEF-tenant-ntu-intvsuite','title.mc.ebook.admin.append.wizard.publish.preview','Append Wizard: Publish','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('527','DEF-tenant-ntu-intvsuite','title.mc.ebook.admin.resume.publish.wizard.publish.preview','Edit Unpublished Resume: Publish','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('528','DEF-tenant-ntu-intvsuite','title.mc.ebook.admin.edit.publish.wizard.publish.preview','Edit Published Resume: Publish','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('529','DEF-tenant-ntu-intvsuite','label.wizard.store.preference','Assign Interview Timeslot','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('530','DEF-tenant-ntu-intvsuite','title.mc.ebook.admin.publish.wizard.store.preference','Create New Resume: Assign Interview Timeslot','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('531','DEF-tenant-ntu-intvsuite','title.mc.ebook.admin.replace.wizard.store.preference','Replace Wizard: Assign Interview Timeslot','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('532','DEF-tenant-ntu-intvsuite','title.mc.ebook.admin.append.wizard.store.preference','Append Wizard: Assign Interview Timeslot','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('533','DEF-tenant-ntu-intvsuite','title.mc.ebook.admin.resume.publish.wizard.store.preference','Edit Unpublished Resume: Assign Interview Timeslot','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('534','DEF-tenant-ntu-intvsuite','title.mc.ebook.admin.edit.publish.wizard.store.preference','Edit Published Resume: Assign Interview Timeslot','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('535','DEF-tenant-ntu-intvsuite','title.mc.ebook.menu.wizard.edit','Edit Published Resume','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('536','DEF-tenant-ntu-intvsuite','title.mc.ebook.admin.publish.wizard.edit.publication','Create New Resume: Configure and setup','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('537','DEF-tenant-ntu-intvsuite','title.mc.ebook.admin.publish.wizard.confirmation','Create New Resume: Confirmation','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('538','DEF-tenant-ntu-intvsuite','title.mc.ebook.admin.resume.publish.wizard.edit.publication','Edit Unpublished Resume: Configure and setup','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('539','DEF-tenant-ntu-intvsuite','title.mc.ebook.admin.resume.publish.wizard.confirmation','Edit Unpublished Resume: Confirmation','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('540','DEF-tenant-ntu-intvsuite','title.mc.ebook.admin.edit.publish.wizard.edit.publication','Edit Published Resume: Configure and setup','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('541','DEF-tenant-ntu-intvsuite','title.mc.ebook.admin.edit.publish.confirmation','Edit Published Resume: Confirmation','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('542','DEF-tenant-ntu-intvsuite','label.wizard.edit.publication','Configure and setup','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('543','DEF-tenant-ntu-intvsuite','title.mc.ebook.menu.wizard','Manage Resume','S','2013-01-21','DEF-user-superadmin','2013-01-21','DEF-user-superadmin',1),
('544','DEF-tenant-ntu-intvsuite','menu.repository.id','MC-EBOOK-MENU-INTERVIEWSUITE','S',NOW(),'DEF-user-superadmin',NOW(),'DEF-user-superadmin',1),
('545','DEF-tenant-ntu-intvsuite','label.book.details.report.select','-- Select Interview --','S',NOW(),'DEF-user-superadmin',NOW(),'DEF-user-superadmin',1),
('546','DEF-tenant-ntu-intvsuite','label.book.details.report.select.all','-- All Interview --','S',NOW(),'DEF-user-superadmin',NOW(),'DEF-user-superadmin',1),
('547','DEF-tenant-ntu-intvsuite','title.mc.ebook.admin.publication.search','Search Resume','S',NOW(),'DEF-user-superadmin',NOW(),'DEF-user-superadmin',1),
('548','DEF-tenant-ntu-intvsuite','title.mc.ebook.menu.publications','Reschedule Interview Timeslot','S',NOW(),'DEF-user-superadmin',NOW(),'DEF-user-superadmin',1),
('549','DEF-tenant-ntu-intvsuite','title.mc.ebook.menu.publication.archiveOrDelete','Archive/Delete Resume','S',NOW(),'DEF-user-superadmin',NOW(),'DEF-user-superadmin',1),
('550','DEF-tenant-ntu-intvsuite','title.mc.ebook.menu.publication.restore','Restore Resume','S',NOW(),'DEF-user-superadmin',NOW(),'DEF-user-superadmin',1),
('551','DEF-tenant-ntu-intvsuite','title.mc.ebook.menu.reports.bookDetail','Resume Download Report','S',NOW(),'DEF-user-superadmin',NOW(),'DEF-user-superadmin',1),
('552','DEF-tenant-ntu-intvsuite','title.mc.ebook.menu.essay.question','View Candidate Appraisal','S',NOW(),'DEF-user-superadmin',NOW(),'DEF-user-superadmin',1),
('553','DEF-tenant-ntu-intvsuite','title.mc.ebook.admin.publication.view','View Resume','S',now(),'DEF-user-superadmin',now(),'DEF-user-superadmin',1),
('554','DEF-tenant-ntu-intvsuite','title.mc.ebook.menu.essay.question.search','View Candidate Appraisal','S',now(),'DEF-user-superadmin',now(),'DEF-user-superadmin',1),
('555','DEF-tenant-ntu-intvsuite','title.mc.ebook.admin.publication.achiveOrDelete','Search Resume For Archive/Delete','S',now(),'DEF-user-superadmin',now(),'DEF-user-superadmin',1),
('556','DEF-tenant-ntu-intvsuite','title.mc.ebook.admin.publication.restore','Search Resume For Restore','S',now(),'DEF-user-superadmin',now(),'DEF-user-superadmin',1),
('557','DEF-tenant-ntu-intvsuite','msg.contenttype.ia.mcqoressay.hotspot.mandatory','Please create Rating Form/Feedback Form hotspots before proceed to the next step.','S',now(),'DEF-user-superadmin',now(),'DEF-user-superadmin',1),
('558','DEF-tenant-ntu-intvsuite','label.setting.hide.date.publication','Hide "Date of Submission" option','S',now(),'DEF-user-superadmin',now(),'DEF-user-superadmin',1),
('559','DEF-tenant-ntu-intvsuite','CMSG_ANSWER_SUBMITTED_TITLE','Rating Submitted','C',now(),'DEF-user-superadmin',now(),'DEF-user-superadmin',1),
('560','DEF-tenant-ntu-intvsuite','CMSG_ANSWER_SUBMITTED_CONTENT','Your ratings have been submitted.','C',now(),'DEF-user-superadmin',now(),'DEF-user-superadmin',1),
('561','DEF-tenant-ntu-intvsuite','server.welcome','Welcome to NTU Interview Suite Server.','S',now(),'DEF-user-superadmin',now(),'DEF-user-superadmin',1),
('562','DEF-tenant-ntu-intvsuite','title.mc.ebook.menu.edit.essay.question','Candidate Appraisal Form','S',now(),'DEF-user-superadmin',now(),'DEF-user-superadmin',1),
('563','DEF-tenant-ntu-intvsuite','title.mc.ebook.menu.read.only.essay.question','Candidate Appraisal Form:Read Only','S',now(),'DEF-user-superadmin',now(),'DEF-user-superadmin',1),
('564','DEF-tenant-ntu-intvsuite','msg.announce.marks','Do you want to close the position(s)?','S',now(),'DEF-user-superadmin',now(),'DEF-user-superadmin',1),
('565','DEF-tenant-ntu-intvsuite','msg.announce.marks.select.invalid','Please select the marked submission to close.','S',now(),'DEF-user-superadmin',now(),'DEF-user-superadmin',1),
('566','DEF-tenant-ntu-intvsuite','msg.submission.announced.successfully','Position(s) closed successfully.','S',now(),'DEF-user-superadmin',now(),'DEF-user-superadmin',1),
('567','DEF-tenant-ntu-intvsuite','label.content.hotspot.mcq.choice.1.description','Value for Choice #1','S',now(),'DEF-user-superadmin',now(),'DEF-user-superadmin',1),
('568','DEF-tenant-ntu-intvsuite','label.content.hotspot.mcq.choice.2.description','Value for Choice #2','S',now(),'DEF-user-superadmin',now(),'DEF-user-superadmin',1),
('569','DEF-tenant-ntu-intvsuite','label.content.hotspot.mcq.choice.3.description','Value for Choice #3','S',now(),'DEF-user-superadmin',now(),'DEF-user-superadmin',1),
('570','DEF-tenant-ntu-intvsuite','label.content.hotspot.mcq.choice.4.description','Value for Choice #4','S',now(),'DEF-user-superadmin',now(),'DEF-user-superadmin',1),
('571','DEF-tenant-ntu-intvsuite','label.content.hotspot.mcq.choice.5.description','Value for Choice #5','S',now(),'DEF-user-superadmin',now(),'DEF-user-superadmin',1),
('572','DEF-tenant-ntu-intvsuite','label.content.hotspot.mcq.choice.6.description','Value for Choice #6','S',now(),'DEF-user-superadmin',now(),'DEF-user-superadmin',1),
('573','DEF-tenant-ntu-intvsuite','label.content.hotspot.mcq.choice.hotspot.name','Hotspot Name<br />(Eg. Q1 )','S',now(),'DEF-user-superadmin',now(),'DEF-user-superadmin',1),
('574','DEF-tenant-ntu-intvsuite','label.content.hotspot.mcq.question.desc','Question Description<br />(Eg. Presentation)','S',now(),'DEF-user-superadmin',now(),'DEF-user-superadmin',1),
('575','DEF-tenant-ntu-intvsuite','CMSG_SUBMIT_ASSESS','Submitting the rating(s)/feedback(s).','C',now(),'DEF-user-superadmin',now(),'DEF-user-superadmin',1),
('576','DEF-tenant-ntu-intvsuite','CMSG_SUBMIT_ASSESS_OK','Rating(s)/Feedback(s)Submitted@@Your rating(s)/feedback(s) have been submitted to server.','C',now(),'DEF-user-superadmin',now(),'DEF-user-superadmin',1),
('577','DEF-tenant-ntu-intvsuite','CMSG_SUBMIT_ASSESS_CLOSED','The job position has been closed. Rating(s)/Feedback(s) submission are not allowed.','C',now(),'DEF-user-superadmin',now(),'DEF-user-superadmin',1),
('578','DEF-tenant-ntu-intvsuite','label.setting.choice.number','Number of Rating Form choices','S',NOW(),'DEF-user-superadmin',NOW(),'DEF-user-superadmin',1),
('579','DEF-tenant-ntu-intvsuite','label.publications','Resumes','S',NOW(),'DEF-user-superadmin',NOW(),'DEF-user-superadmin',1),
('580','DEF-tenant-ntu-intvsuite','msg.no.publication','No Resumes Found','S',NOW(),'DEF-user-superadmin',NOW(),'DEF-user-superadmin',1),
('581','DEF-tenant-ntu-intvsuite','label.setting.hide.category.subscription','Hide "Job Position/Interview Timeslot Subscription" Option','S',NOW(),'DEF-user-superadmin',NOW(),'DEF-user-superadmin',1),
('582','DEF-tenant-ntu-intvsuite','label.category.subscription','Job Position/Interview Timeslot Subscription','S',NOW(),'DEF-user-superadmin',NOW(),'DEF-user-superadmin',1),
('583','DEF-tenant-ntu-intvsuite','msg.publication.deleted.successfully','Resume(s) deleted successfully','S',NOW(),'DEF-user-superadmin',NOW(),'DEF-user-superadmin',1),
('584','DEF-tenant-ntu-intvsuite','msg.publication.archive.successfully','Achived resume(s) successfully','S',NOW(),'DEF-user-superadmin',NOW(),'DEF-user-superadmin',1),
('585','DEF-tenant-ntu-intvsuite','msg.publication.restore.successfully','Restore resume(s) successfully','S',NOW(),'DEF-user-superadmin',NOW(),'DEF-user-superadmin',1),
('586','DEF-tenant-ntu-intvsuite','msg.publication.delete.successfully','Delete resume(s) successfully','S',NOW(),'DEF-user-superadmin',NOW(),'DEF-user-superadmin',1),
('587','DEF-tenant-ntu-intvsuite','label.content.owner.ous','Owner User Group(s)','S',NOW(),'DEF-user-superadmin',NOW(),'DEF-user-superadmin',1),
('588','DEF-tenant-ntu-intvsuite','label.content.owner.ou','Owner User Group','S',NOW(),'DEF-user-superadmin',NOW(),'DEF-user-superadmin',1),
('589','DEF-tenant-ntu-intvsuite','label.publication.publish.ous','Owner User Group(s)','S',NOW(),'DEF-user-superadmin',NOW(),'DEF-user-superadmin',1),
('590','DEF-tenant-ntu-intvsuite','msg.err.publication.not.belongs.owner.ou','Not belongs to the owner user group.','S',NOW(),'DEF-user-superadmin',NOW(),'DEF-user-superadmin',1),
('591','DEF-tenant-ntu-intvsuite','label.select.content.owner.ous','- Any User Group -','S',NOW(),'DEF-user-superadmin',NOW(),'DEF-user-superadmin',1),
('592','DEF-tenant-ntu-intvsuite','msg.book.details.report.publication.select','Please select the candidate .','S',NOW(),'DEF-user-superadmin',NOW(),'DEF-user-superadmin',1),
('593','DEF-tenant-ntu-intvsuite','label.content.publication.revision','Resume Revision','S',NOW(),'DEF-user-superadmin',NOW(),'DEF-user-superadmin',1),
('594','DEF-tenant-ntu-intvsuite','title.mc.ebook.admin.top.rated.publications','Top Rated Resumes','S',NOW(),'DEF-user-superadmin',NOW(),'DEF-user-superadmin',1),
('595','DEF-tenant-ntu-intvsuite','label.top.rated.publications','Top Rated Resumes','S',NOW(),'DEF-user-superadmin',NOW(),'DEF-user-superadmin',1),
('596','DEF-tenant-ntu-intvsuite','label.download.log.publication.name','Resume Name','S',NOW(),'DEF-user-superadmin',NOW(),'DEF-user-superadmin',1);

/* Comments. The custom display logic changed
call SP_COPY_CUSTOM_LABEL_VALUE();
*/

DELETE FROM TBL_CODE_INT WHERE CODETYPE_ID = 'EBOOK-CONTENT-TYPE' AND CODE_ID != 'BK';
DELETE FROM TBL_CODE_INT WHERE CODE_ID = 'PASSWORD';
DELETE FROM tbl_code_int WHERE CODETYPE_ID = 'EBOOK-ASSIGNMENT_MARK_TYPE' AND CODE_ID = 'M';
UPDATE TBL_CODE_INT SET CODE_DESC = 'Resume' WHERE CODETYPE_ID = 'EBOOK-CONTENT-TYPE' AND CODE_ID = 'BK';
UPDATE TBL_CODE_INT SET CODE_DESC = 'Hired' WHERE CODETYPE_ID = 'EBOOK-ASSIGNMENT_MARK_TYPE' AND CODE_ID = 'A';
UPDATE TBL_CODE_INT SET CODE_DESC = 'Close Position' where CODETYPE_ID = 'EBOOK-ASSIGNMENT_MARK_TYPE' and CODE_ID = 'A';
UPDATE TBL_CODE_INT SET CODE_DESC = 'Rating Form' where CODETYPE_ID = 'EBOOK-HOTSPOT-TYPE' and CODE_ID = '06';
UPDATE TBL_CODE_INT SET CODE_DESC = 'Feedback Form' where CODETYPE_ID = 'EBOOK-HOTSPOT-TYPE' and CODE_ID = '08';
INSERT INTO TBL_CODE_INT
(`CODETYPE_ID`, `CODE_ID`, `CODE_DESC`, `CODE_SEQ`, `STATUS`, `EFFECTIVE_DT`, `EXPIRY_DT`, `UPDATED_BY`, `UPDATED_DT`, `LOCALE`)
VALUES
('EBOOK-CONTENT-TYPE', 'IA', 'Resume with form', 4, 'A', NULL, NULL, NULL, NULL, 'en');

/*
-----------------------------------------------
-- Insert of TBL_AA_RES2RES
-----------------------------------------------
*/
INSERT INTO TBL_AA_RES2RES
(`RESOURCES_ID`, `PARENT_RES_ID`, `CREATE_ACCESS`, `READ_ACCESS`, `UPDATE_ACCESS`, `DELETE_ACCESS`, `EFFECTIVE_DT`, `EXPIRY_DT`, `CREATED_DT`, `CREATED_BY`, `UPDATED_DT`, `UPDATED_BY`, `VERSION`, `REF_GROUP_ID`)
VALUES
('MCEBOOK-ADMIN-RES-REPORT-016', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-017', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-016', 'DEF-role-portaladmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-017', 'DEF-role-portaladmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-016', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-017', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-016', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-017', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-016', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-017', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-016', 'DEF-role-siteadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-017', 'DEF-role-siteadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-012', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-021', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-021', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-021', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal');

/* 
 * Maintain 3 administrator rol(System Administrator, Tenant Admin A and Content Admin Role) for intvsuite.
 */
UPDATE `TBL_AA_RESOURCES` SET RESOURCE_NAME = 'System Administrator' WHERE RESOURCES_ID = 'DEF-role-superadmin' AND RESOURCE_NAME = 'Super Admin Role' AND RESOURCE_TYPE = 'LOG_ROLE';
UPDATE `TBL_AA_RESOURCES` SET RESOURCE_NAME = 'School/Department Administrator' WHERE RESOURCES_ID = 'DEF-role-tenantadmina' AND RESOURCE_NAME = 'Tenant Admin A Role' AND RESOURCE_TYPE = 'LOG_ROLE';
UPDATE `TBL_AA_RESOURCES` SET RESOURCE_NAME = 'Interviewer' WHERE RESOURCES_ID = 'DEF-role-contentadmin' AND RESOURCE_NAME = 'Content Admin Role' AND RESOURCE_TYPE = 'LOG_ROLE';

DELETE FROM `TBL_AA_RES2RES`
WHERE PARENT_RES_ID IN (
    SELECT RESOURCES_ID 
    FROM `TBL_AA_RESOURCES`
    WHERE `RESOURCES_ID` NOT IN (
        'DEF-role-contentadmin',
        'DEF-role-superadmin',
        'DEF-role-tenantadmina'
    ) AND RESOURCE_TYPE = 'LOG_ROLE'
);

DELETE FROM `TBL_AA_GROUP2RES`
WHERE RESOURCES_ID IN (
    SELECT RESOURCES_ID 
    FROM `TBL_AA_RESOURCES`
    WHERE `RESOURCES_ID` NOT IN (
        'DEF-role-contentadmin',
        'DEF-role-superadmin',
        'DEF-role-tenantadmina'
    ) AND RESOURCE_TYPE = 'LOG_ROLE'
);


DELETE FROM `TBL_AA_SUBJECT2RES` 
WHERE RESOURCES_ID IN (
    SELECT RESOURCES_ID 
    FROM `TBL_AA_RESOURCES`
    WHERE `RESOURCES_ID` NOT IN (
        'DEF-role-contentadmin',
        'DEF-role-superadmin',
        'DEF-role-tenantadmina'
    ) AND RESOURCE_TYPE = 'LOG_ROLE'
);

DELETE FROM `TBL_AA_RESOURCES` 
WHERE `RESOURCES_ID` NOT IN (
    'DEF-role-contentadmin',
    'DEF-role-superadmin',
    'DEF-role-tenantadmina'
) AND RESOURCE_TYPE = 'LOG_ROLE';


/*
 * Hide those unnecessary module from the side menu for InterviewSuite project
 */
DELETE FROM TBL_AA_RES2RES
WHERE RESOURCES_ID IN (
    SELECT RESOURCES_ID 
    FROM TBL_AA_RESOURCES 
    WHERE RESOURCE_PATH IN (
        -- Express Wizard
        '/mc-ebook-server/mc-ebook-wizard/addSimplePublishContent.do',
        -- Replace Wizard
        '/mc-ebook-server/mc-ebook-wizard/searchReplaceContents.do',
        -- Append Wizard
        '/mc-ebook-server/mc-ebook-wizard/searchAppendContents.do',
        -- Offers
        '/mc-ebook-server/mc-ebook-admin/searchOffers.do',
        -- Publishers
        '/mc-ebook-server/mc-ebook-admin/searchPublishers.do',
        -- Change Password
        '/mc-ebook-server/mc-ebook-admin/changeAdminPassword.do',
        -- Contents
        '/mc-ebook-server/mc-ebook-admin/searchContents.do',
        -- Import
        '/mc-ebook-server/mc-ebook-admin/importContent.do', 
        -- Assignment Report
        '/mc-ebook-server/mc-ebook-admin/assignmentSubmissionReport.do'
    )
);

DELETE FROM TBL_AA_SUBJECT2RES
WHERE RESOURCES_ID IN (
    SELECT RESOURCES_ID 
    FROM TBL_AA_RESOURCES 
    WHERE RESOURCE_PATH IN (
        -- Express Wizard
        '/mc-ebook-server/mc-ebook-wizard/addSimplePublishContent.do',
        -- Replace Wizard
        '/mc-ebook-server/mc-ebook-wizard/searchReplaceContents.do',
        -- Append Wizard
        '/mc-ebook-server/mc-ebook-wizard/searchAppendContents.do',
        -- Offers
        '/mc-ebook-server/mc-ebook-admin/searchOffers.do',
        -- Publishers
        '/mc-ebook-server/mc-ebook-admin/searchPublishers.do',
        -- Change Password
        '/mc-ebook-server/mc-ebook-admin/changeAdminPassword.do',
        -- Contents
        '/mc-ebook-server/mc-ebook-admin/searchContents.do',
        -- Import
        '/mc-ebook-server/mc-ebook-admin/importContent.do',
        -- Assignment Report
        '/mc-ebook-server/mc-ebook-admin/assignmentSubmissionReport.do'
    )
);

DELETE FROM TBL_AA_GROUP2RES
WHERE RESOURCES_ID IN (
    SELECT RESOURCES_ID 
    FROM TBL_AA_RESOURCES 
    WHERE RESOURCE_PATH IN (
        -- Express Wizard
        '/mc-ebook-server/mc-ebook-wizard/addSimplePublishContent.do',
        -- Replace Wizard
        '/mc-ebook-server/mc-ebook-wizard/searchReplaceContents.do',
        -- Append Wizard
        '/mc-ebook-server/mc-ebook-wizard/searchAppendContents.do',
        -- Offers
        '/mc-ebook-server/mc-ebook-admin/searchOffers.do',
        -- Publishers
        '/mc-ebook-server/mc-ebook-admin/searchPublishers.do',
        -- Change Password
        '/mc-ebook-server/mc-ebook-admin/changeAdminPassword.do',
        -- Contents
        '/mc-ebook-server/mc-ebook-admin/searchContents.do',
        -- Import
        '/mc-ebook-server/mc-ebook-admin/importContent.do',
        -- Assignment Report
        '/mc-ebook-server/mc-ebook-admin/assignmentSubmissionReport.do'
    )
);

/* Hide "Archive", "Restore" and "Candidate Assessment" menu from side menu for "Interviewer" role */
delete from tbl_aa_res2res 
where resources_id in (
    select resources_id
    from tbl_aa_resources 
    where resource_path in (
        -- Archive/Delete Candidate 
        '/mc-ebook-server/mc-ebook-admin/archiveOrDeletePublications.do',
        -- Restore Candidate 
        '/mc-ebook-server/mc-ebook-admin/restorePublications.do',
        -- Candidate Assessment 
        '/mc-ebook-server/mc-ebook-admin/searchBookForEssayQuestion.do'
    )
) and parent_res_id = 'DEF-role-contentadmin';

/* Add one default serverSetting to ntu interviewsuite */
insert into TBL_MC_SETTING
(`SETTING_ID`, `STORE_ID`, `VIDEO_SIZE`, `AUDIO_SIZE`, `IMAGE_SIZE`, `HIDE_PRICE`, `HIDE_EXAM`, `MAX_CATEGORY_DEPTH`, `HIDE_DISTRIBUTION_MODES`, `HIDE_META_DATA`, `HIDE_MARKABLE`, `HIDE_MUTUALLY_EXCLUSIVE`, `HIDE_SUPPORTED_DEVICES`, `HIDE_DATE_OF_PUBLICATION`, `HIDE_NOTIFICATION`, `HIDE_CATEGORY_SUBSCRIPTION`, `CHOICE_NUMBER`, `CREATED_BY`, `CREATED_DT`, `UPDATED_DT`,`UPDATED_BY`,`VERSION`)
VALUES
('DEF-ntu-intvsuite-setting', 'DEF-store-ntu-intvsuite', '30', '30', '30', '0', '0', 2, '1', '0', '0', '0', '0', '0', '0', '0', 5, 'DEF-user-superadmin', now(), now(), 'DEF-user-superadmin', 1);

update `tbl_mc_setting` set 
HIDE_PRICE = '0', HIDE_EXAM = '0', HIDE_MARKABLE = '0', 
HIDE_MUTUALLY_EXCLUSIVE = '0', HIDE_NOTIFICATION = '0', 
HIDE_CATEGORY_SUBSCRIPTION = '0', HIDE_SUPPORTED_DEVICES = '0', 
HIDE_META_DATA = '0', CHOICE_NUMBER = 5, 
HIDE_DATE_OF_PUBLICATION = '0', `MAX_CATEGORY_DEPTH` = 2 
where `SETTING_ID` = 'DEF-default-setting';

/*
 * Beginning of Stored Procedure
 */
DELIMITER $$

DROP PROCEDURE IF EXISTS `SP_GET_INTERVIEW_ITEM`$$

CREATE PROCEDURE `SP_GET_INTERVIEW_ITEM`(IN CATEGORYID TEXT, IN INTERVIEWERID TEXT, IN CHOICE INT)
BEGIN
    DECLARE IDS TEXT;
    DECLARE IDS_NUM INT;
    DROP TEMPORARY TABLE IF EXISTS TMP_TBL_CATEGORY_IDS;
    CREATE TEMPORARY TABLE TMP_TBL_CATEGORY_IDS(TMP_ID CHAR(32) NOT NULL) DEFAULT CHARSET=utf8; 

    SET IDS = TRIM(CATEGORYID);
    SET IDS_NUM = LENGTH(IDS) - LENGTH(REPLACE(IDS, ',', '')) + 1;
    SET IDS = REPLACE(REPLACE(IDS, ",", ''), "'", '');

    WHILE IDS_NUM > 0 DO
        INSERT INTO TMP_TBL_CATEGORY_IDS VALUES(LEFT(IDS, 32));
        SET IDS = SUBSTRING(ids, 33);
        SET IDS_NUM = IDS_NUM - 1;
    END WHILE;
    DROP TEMPORARY TABLE IF EXISTS TMP_TBL_CATEGORY_IDS2;
    CREATE TEMPORARY TABLE TMP_TBL_CATEGORY_IDS2 
        SELECT * FROM TMP_TBL_CATEGORY_IDS; 



    DROP TEMPORARY TABLE IF EXISTS TMP_TBL_TOP_PUBLICATION;
    IF INTERVIEWERID = NULL OR INTERVIEWERID = '' THEN
        CREATE TEMPORARY TABLE TMP_TBL_TOP_PUBLICATION
        SELECT B.PUBLICATION_ID, B.REVISION, B.PUBLICATION_NAME, B.CONTENT_ID
        FROM TBL_MC_PUBLICATION2CATEGORY A, TBL_MC_PUBLICATION B, 
            TBL_MC_CONTENT2ASSIGNMENT C, TBL_MC_ASSIGNMENT_SUBMISSION D, TBL_MC_CONTENT E
        WHERE A.CATEGORY_ID IN (SELECT TMP_ID FROM TMP_TBL_CATEGORY_IDS)
        AND A.PUBLICATION_ID = B.PUBLICATION_ID
        AND D.USER_ID IN (
            SELECT DD.USER_ID
            FROM TBL_MC_PUBLICATION2CATEGORY AA, TBL_MC_PUBLICATION BB, TBL_MC_CONTENT2ASSIGNMENT CC,
                TBL_MC_ASSIGNMENT_SUBMISSION DD, TBL_MT_USER EE, TBL_AA_SUBJECT FF, TBL_MC_CONTENT HH
            WHERE
                AA.CATEGORY_ID IN (SELECT TMP_ID FROM TMP_TBL_CATEGORY_IDS2)
                AND AA.PUBLICATION_ID = BB.PUBLICATION_ID
                AND BB.CONTENT_ID = CC.CONTENT_ID
                AND CC.ASSIGNMENT_ID = DD.ASSIGNMENT_ID
                AND DD.USER_ID = EE.USER_ID
                AND EE.SUBJECT_ID = FF.SUBJECT_ID
                AND BB.CONTENT_ID = HH.CONTENT_ID 
                AND HH.DELETEDFLAG = 1
            GROUP BY DD.USER_ID
            ORDER BY FF.FIRST_NAME ASC, FF.LAST_NAME ASC
        )
        AND B.CONTENT_ID = C.CONTENT_ID
        AND C.ASSIGNMENT_ID = D.ASSIGNMENT_ID
        AND B.CONTENT_ID = E.CONTENT_ID
        AND E.DELETEDFLAG = 1
        GROUP BY B.PUBLICATION_ID
        ORDER BY B.PUBLICATION_NAME ASC
        LIMIT 5;
    ELSE
        CREATE TEMPORARY TABLE TMP_TBL_TOP_PUBLICATION 
        SELECT B.PUBLICATION_ID, B.REVISION, B.PUBLICATION_NAME, B.CONTENT_ID
        FROM TBL_MC_PUBLICATION2CATEGORY A, TBL_MC_PUBLICATION B, 
            TBL_MC_CONTENT2ASSIGNMENT C, TBL_MC_ASSIGNMENT_SUBMISSION D, TBL_MC_CONTENT E
        WHERE A.CATEGORY_ID IN (SELECT TMP_ID FROM TMP_TBL_CATEGORY_IDS)
        AND A.PUBLICATION_ID = B.PUBLICATION_ID
        AND D.USER_ID = INTERVIEWERID
        AND B.CONTENT_ID = C.CONTENT_ID
        AND C.ASSIGNMENT_ID = D.ASSIGNMENT_ID
        AND B.CONTENT_ID = E.CONTENT_ID
        AND E.DELETEDFLAG = 1
        GROUP BY B.PUBLICATION_ID
        ORDER BY B.PUBLICATION_NAME ASC
        LIMIT 5;
    END IF;

    ALTER TABLE TMP_TBL_TOP_PUBLICATION ADD RATING VARCHAR(10);

    UPDATE TMP_TBL_TOP_PUBLICATION A
    SET A.RATING = (
        SELECT ROUND(AVG(CAST(B.RATING AS DECIMAL(3,1)))/2,1)
        FROM TBL_MC_PUBLICATION_RATING B
        WHERE A.PUBLICATION_ID = B.PUBLICATION_ID
        AND A.REVISION = B.REVISION
        GROUP BY B.PUBLICATION_ID
    );


    ALTER TABLE TBL_MC_ASSIGNMENT_SUBMISSION ORDER BY SUBMITTED_DATE DESC;


    DROP TEMPORARY TABLE IF EXISTS TMP_TBL_INTERVIEW_REPORT;
    CREATE TEMPORARY TABLE TMP_TBL_INTERVIEW_REPORT (
        PUBLICATION_ID VARCHAR(32) NOT NULL,
        PUBLICATION_NAME VARCHAR(255),
        USER_ID VARCHAR(32),
        USER_NAME VARCHAR(255),
        QUESTION_ID VARCHAR(32),
        QUESTION_DESC VARCHAR(255),
        QUESTION_TYPE CHAR(1),
        ANSWER DOUBLE DEFAULT 0,
        LONG_ANSWER VARCHAR(1000),
        AVG_SCORE DOUBLE DEFAULT 0
    )ENGINE=INNODB;


    INSERT INTO TMP_TBL_INTERVIEW_REPORT
    SELECT A.PUBLICATION_ID, A.PUBLICATION_NAME, C.USER_ID, 
           NULL AS USER_NAME, D.QUESTION_ID, NULL AS QUESTION_DESC, 
           NULL AS QUESTION_TYPE, E.ANSWER, E.LONG_ANSWER, 0 AS AVG_SCORE  
    FROM TMP_TBL_TOP_PUBLICATION A, 
         TBL_MC_CONTENT2ASSIGNMENT B, 
         TBL_MC_ASSIGNMENT_SUBMISSION C, 
         TBL_MC_ASSIGNMENT_SUBMISSION_QUESTION D,
         TBL_MC_ASSIGNMENT_SUBMISSION_ANSWER E
    WHERE A.CONTENT_ID = B.CONTENT_ID
    AND B.ASSIGNMENT_ID = C.ASSIGNMENT_ID
    AND C.SUBMISSION_ID = D.SUBMISSION_ID
    AND D.SUBMISSION_QUESTION_ID = E.SUBMISSION_QUESTION_ID
    GROUP BY A.PUBLICATION_ID, C.USER_ID, D.QUESTION_ID;



    UPDATE TMP_TBL_INTERVIEW_REPORT A, TBL_MC_HOTSPOT_MCQ_QUESTION B
    SET A.QUESTION_DESC = B.QUESTION_DESC, A.QUESTION_TYPE = "M"
    WHERE A.QUESTION_ID = B.QUESTION_ID;


    UPDATE TMP_TBL_INTERVIEW_REPORT A, TBL_MC_HOTSPOT_ESSAY_QUESTION B
    SET A.QUESTION_DESC = B.QUESTION_DESC, A.QUESTION_TYPE = "S"
    WHERE A.QUESTION_ID = B.HOTSPOT_ID;


    DROP TEMPORARY TABLE IF EXISTS TMP_TBL_INTERVIEW_REPORT2;
    CREATE TEMPORARY TABLE TMP_TBL_INTERVIEW_REPORT2
    SELECT * FROM TMP_TBL_INTERVIEW_REPORT;
    UPDATE TMP_TBL_INTERVIEW_REPORT A
    SET A.AVG_SCORE = (
        SELECT ROUND(AVG(B.ANSWER), 2) AS AVG_SCORE
        FROM TMP_TBL_INTERVIEW_REPORT2 B
        WHERE A.PUBLICATION_ID = B.PUBLICATION_ID
        AND A.QUESTION_ID = B.QUESTION_ID
    );


    IF INTERVIEWERID IS NOT NULL AND INTERVIEWERID != '' THEN
        DELETE FROM TMP_TBL_INTERVIEW_REPORT WHERE USER_ID != INTERVIEWERID;
    END IF;    


    UPDATE TMP_TBL_INTERVIEW_REPORT A, TBL_MT_USER B, TBL_AA_SUBJECT C
    SET A.USER_NAME = CONCAT_WS(' ', C.FIRST_NAME, C.LAST_NAME)
    WHERE A.USER_ID = B.USER_ID
    AND B.SUBJECT_ID = C.SUBJECT_ID;


    INSERT INTO TMP_TBL_INTERVIEW_REPORT
    SELECT A.PUBLICATION_ID, A.PUBLICATION_NAME, NULL AS USER_ID, 
           NULL AS USER_NAME, NULL AS QUESTION_ID, NULL AS QUESTION_DESC, 
           'A' AS QUESTION_TYPE, A.RATING AS ANSWER, NULL AS LONG_ANSWER, 0 AS AVG_SCORE
    FROM TMP_TBL_TOP_PUBLICATION A;


    IF CHOICE=0 THEN
        UPDATE TMP_TBL_INTERVIEW_REPORT A
        SET A.AVG_SCORE = (
        SELECT ROUND(AVG(B.ANSWER), 2) AS AVG_SCORE
        FROM TMP_TBL_INTERVIEW_REPORT2 B
        WHERE A.PUBLICATION_ID = B.PUBLICATION_ID
        AND B.QUESTION_TYPE = 'M');

        SELECT PUBLICATION_ID, PUBLICATION_NAME, QUESTION_ID, QUESTION_DESC, QUESTION_TYPE, AVG(ANSWER) AS ANSWER, AVG_SCORE
        FROM TMP_TBL_INTERVIEW_REPORT
        WHERE QUESTION_TYPE <> 'E'
        GROUP BY PUBLICATION_ID, QUESTION_ID
        ORDER BY QUESTION_TYPE ASC, QUESTION_DESC ASC, QUESTION_ID ASC, ANSWER DESC, PUBLICATION_NAME ASC;
    ELSE
        SELECT * 
        FROM TMP_TBL_INTERVIEW_REPORT
        WHERE QUESTION_TYPE<>'A'
        ORDER BY QUESTION_TYPE ASC, QUESTION_DESC ASC, QUESTION_ID ASC, PUBLICATION_NAME ASC, PUBLICATION_ID ASC, USER_NAME ASC, USER_ID ASC;
    END IF;


    DROP TEMPORARY TABLE IF EXISTS TMP_TBL_INTERVIEW_REPORT;
    DROP TEMPORARY TABLE IF EXISTS TMP_TBL_INTERVIEW_REPORT2;
    DROP TEMPORARY TABLE IF EXISTS TMP_TBL_CATEGORY_IDS;
    DROP TEMPORARY TABLE IF EXISTS TMP_TBL_CATEGORY_IDS2;

END$$

DELIMITER ;
/*
 * End of Stored Procedure
 */

/* =========================Keep below code at bottom always.[Begin]========================= */
/* Suggest:
   1.always call "SP_COPY_CUSTOM_LABEL_VALUE" procedure before call "SP_SYNCHRO_TENANT_CUSTOM_LABEL_KEY" procedure.
   2.put this call command at the last row
*/
/* Comment because of the logic of custom_label changes.*
-- call SP_COPY_CUSTOM_LABEL_VALUE();
-- call SP_SYNCHRO_TENANT_CUSTOM_LABEL_KEY('DEF-tenant-prime');
/* =========================Keep below code at bottom always.[End]========================= */
