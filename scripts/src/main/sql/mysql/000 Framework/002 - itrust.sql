/* MySQL Scripts for i.Trust v3.13 (within iConnect v3.13) */

DROP TABLE IF EXISTS TBL_AA_DELEGATED_RESOURCES;
DROP TABLE IF EXISTS TBL_AA_SUBJECT2DELEGATOR;
DROP TABLE IF EXISTS TBL_AA_ASSIGNABLE_RES;
DROP TABLE IF EXISTS TBL_AA_GROUP_ADMIN;
DROP TABLE IF EXISTS TBL_AA_USER_SESSION_INFO;
DROP TABLE IF EXISTS TBL_AA_SUBJECT2GROUP;
DROP TABLE IF EXISTS TBL_AA_SUBJECT2RES;
DROP TABLE IF EXISTS TBL_AA_GROUP2RES;
DROP TABLE IF EXISTS TBL_AA_AUTH2GROUP;
DROP TABLE IF EXISTS TBL_AA_AUTHORITY;
DROP TABLE IF EXISTS TBL_AA_RES2RES;
DROP TABLE IF EXISTS TBL_AA_RESOURCES;
DROP TABLE IF EXISTS TBL_AA_GROUP;
DROP TABLE IF EXISTS TBL_AA_SUBJECT_LOGIN;
DROP TABLE IF EXISTS TBL_AA_SUBJECT_PWD_HISTORY;
DROP TABLE IF EXISTS TBL_IPORTAL_SUBJECT_THEME;
DROP TABLE IF EXISTS TBL_AA_SUBJECT ;
DROP TABLE IF EXISTS TBL_AA_LOGIN_LOG;
DROP TABLE IF EXISTS TBL_AA_ASSIGNABLE_RES;
DROP TABLE IF EXISTS TBL_AA_AUDIT_LOG;
DROP TABLE IF EXISTS TBL_AA_PUBLIC_REG;
DROP TABLE IF EXISTS TBL_AA_DOMAIN;
DROP TABLE IF EXISTS TBL_AA_SIGN_LOG;

/*
---------------------------------------------
-- Creation of TBL_AA_SUBJECT
---------------------------------------------
*/
CREATE TABLE TBL_AA_SUBJECT (
    SUBJECT_ID                      VARCHAR(32)                 NOT NULL,
    DOMAIN_NAME	                    VARCHAR(32)                 NOT NULL,
    FIRST_NAME                      VARCHAR(100)                NOT NULL,
    LAST_NAME                       VARCHAR(100),
    EMAIL                           VARCHAR(200),
    PHONE_NUM                       VARCHAR(20),
    EFFECTIVE_DT                    DATE,
    EXPIRY_DT                       DATE,
    STATUS                          VARCHAR(1)                  NOT NULL,
    LAST_LOGIN_DT                   DATETIME,
    LAST_LOGIN_IP                   VARCHAR(20),
    CREATED_DT                      DATETIME,
    CREATED_BY                      VARCHAR(32),
    UPDATED_DT                      DATETIME,
    UPDATED_BY                      VARCHAR(32),
    ALLOWED_LOGIN_LEVEL             INTEGER,
    LOGICAL_DEL                     INTEGER,
    VERSION                         INTEGER                     NOT NULL
);
ALTER TABLE TBL_AA_SUBJECT
    ADD PRIMARY KEY ( SUBJECT_ID );
create index index_1_tbl_aa_subject on tbl_aa_subject (subject_id);

/*
---------------------------------------------
-- Creation of TBL_AA_SUBJECT_LOGIN
---------------------------------------------
*/
CREATE TABLE TBL_AA_SUBJECT_LOGIN (
    SUBJECT_ID                      VARCHAR(32)                 NOT NULL,
    LOGIN_MECHANISM                 VARCHAR(32)                 NOT NULL,
    DOMAIN_NAME                     VARCHAR(32)                 NOT NULL,
    LOGIN_NAME                      VARCHAR(100)                NOT NULL,
    PASSWORD                        VARCHAR(2000)               NOT NULL,
    RECALL_QUESTION                 VARCHAR(100),
    RECALL_ANS                      VARCHAR(500),
    PASSWORD_CHANGED_DATE           DATETIME,
    ATTEMPTS_MADE                   INTEGER,
    CREATED_DT                      DATETIME,
    CREATED_BY                      VARCHAR(32),
    UPDATED_DT                      DATETIME,
    UPDATED_BY                      VARCHAR(32),
    VERSION                         INTEGER                     NOT NULL,
    FOREIGN KEY (SUBJECT_ID) REFERENCES TBL_AA_SUBJECT (SUBJECT_ID)
);
ALTER TABLE TBL_AA_SUBJECT_LOGIN
    ADD PRIMARY KEY ( SUBJECT_ID, LOGIN_MECHANISM );
create index index_1_tbl_aa_subject_login on tbl_aa_subject_login (subject_id);
create index index_2_tbl_aa_subject_login on tbl_aa_subject_login (login_name);

/*
---------------------------------------------
-- Creation of TBL_AA_LOGIN_LOG
---------------------------------------------
*/
CREATE TABLE TBL_AA_LOGIN_LOG (
    LOGIN_LOG_ID                    VARCHAR(32)                 NOT NULL,
    LOGIN_ID                        VARCHAR(100),
    DOMAIN_NAME                     VARCHAR(32) NOT NULL,
    LOGIN_TYPE                      VARCHAR(20),
    LOGIN_STATUS                    VARCHAR(100),
    CREATED_DT                      DATETIME,
    LOGIN_IP                        VARCHAR(20)
);
ALTER TABLE TBL_AA_LOGIN_LOG
    ADD PRIMARY KEY ( LOGIN_LOG_ID );
create index index_1_tbl_aa_login_log on tbl_aa_login_log (login_id);

/*
---------------------------------------------
-- Creation of TBL_AA_SUBJECT_PWD_HISTORY
---------------------------------------------
*/
CREATE TABLE TBL_AA_SUBJECT_PWD_HISTORY (
    OLD_PASSWORD_ID                 VARCHAR(32)                 NOT NULL,
    SUBJECT_ID                      VARCHAR(32)                 NOT NULL,
    OLD_PASSWORD                    VARCHAR(2000)               NOT NULL,
    CREATED_DT                      DATETIME,
    FOREIGN KEY (SUBJECT_ID) REFERENCES TBL_AA_SUBJECT (SUBJECT_ID)
);
ALTER TABLE TBL_AA_SUBJECT_PWD_HISTORY
    ADD PRIMARY KEY ( OLD_PASSWORD_ID );

/*
---------------------------------------------
-- Creation of TBL_AA_GROUP
---------------------------------------------
*/
CREATE TABLE TBL_AA_GROUP (
    GROUP_ID                        VARCHAR(32)                 NOT NULL,
    DOMAIN_NAME                     VARCHAR(32)                 NOT NULL,
    GROUP_NAME                      VARCHAR(50)                 NOT NULL,
    CREATED_DT                      DATETIME,
    CREATED_BY                      VARCHAR(32),
    UPDATED_DT                      DATETIME,
    UPDATED_BY                      VARCHAR(32),
    GROUP_PARENT_ID                 VARCHAR(32),
    VERSION                         INTEGER                     NOT NULL,
    GROUP_TYPE                      VARCHAR(32),
    GROUP_LABEL                     VARCHAR(50),
    LEFT_INDEX                      INTEGER(11)                 DEFAULT NULL,
    RIGHT_INDEX                     INTEGER(11)                 DEFAULT NULL
);

ALTER TABLE TBL_AA_GROUP
    ADD PRIMARY KEY ( GROUP_ID );
ALTER TABLE TBL_AA_GROUP
    ADD FOREIGN KEY (GROUP_PARENT_ID) REFERENCES TBL_AA_GROUP (GROUP_ID);

/*
---------------------------------------------
-- Creation of TBL_AA_RESOURCES
---------------------------------------------
*/
CREATE TABLE TBL_AA_RESOURCES (
    RESOURCES_ID                    VARCHAR(32)                 NOT NULL,
    RESOURCE_NAME                   VARCHAR(100)                NOT NULL,
    RESOURCE_PATH                   VARCHAR(100),
    RESOURCE_TYPE                   VARCHAR(50)                 NOT NULL,
    DOMAIN_NAME                     VARCHAR(32)                 NOT NULL,
    EFFECTIVE_FROM                  Date,
    EFFECTIVE_TO                    Date,
    CREATED_DT                      DATETIME,
    CREATED_BY                      VARCHAR(32),
    UPDATED_DT                      DATETIME,
    UPDATED_BY                      VARCHAR(32),
    REQ_LOGIN_LEVEL                 INTEGER,
    VERSION                         INTEGER                     NOT NULL,
    BELONG_TO                       VARCHAR(32)                 NOT NULL,
    LOG_ENABLED                     INTEGER                     NOT NULL                        DEFAULT '0',
    LOG_TRANSACTION	                INTEGER                     NOT NULL                        DEFAULT '0'
);

ALTER TABLE TBL_AA_RESOURCES
    ADD PRIMARY KEY ( RESOURCES_ID );

/*
---------------------------------------------
-- Creation of TBL_AA_USER_SESSION_INFO
---------------------------------------------
*/
CREATE TABLE TBL_AA_USER_SESSION_INFO (
    JSESSIONID                      VARCHAR(128)                NOT NULL,
    SUBJECT_ID                      VARCHAR(32),
    DOMAIN_NAME                     VARCHAR(32)                 NOT NULL,
    LOGIN_ID                        VARCHAR(100),
    LOGIN_TYPE                      VARCHAR(40),
    FIRST_NAME                      VARCHAR(30),
    LAST_NAME                       VARCHAR(50),
    IP_ADDRESS                      VARCHAR(20),
    UPDATED_DT                      DATETIME
);

ALTER TABLE TBL_AA_USER_SESSION_INFO
    ADD PRIMARY KEY ( JSESSIONID );

/*
---------------------------------------------
-- Creation of TBL_AA_AUTHORITY
---------------------------------------------
*/
/* HERE ARE THE MAPPING TABLES */
CREATE TABLE TBL_AA_AUTHORITY (
    AUTHORITY_ID                    VARCHAR(32)                 NOT NULL,
    AUTHORITY                       VARCHAR(50)                 NOT NULL,
    CREATED_DT                      DATETIME,
    CREATED_BY                      VARCHAR(32),
    UPDATED_DT                      DATETIME,
    UPDATED_BY                      VARCHAR(32),
    VERSION                         INTEGER,
    PRIMARY KEY (AUTHORITY_ID)
);

/*
---------------------------------------------
-- Creation of TBL_AA_AUTH2GROUP
---------------------------------------------
*/
CREATE TABLE TBL_AA_AUTH2GROUP (
    AUTHORITY_ID                    VARCHAR(32)                 NOT NULL,
    GROUP_ID                        VARCHAR(32)                 NOT NULL,
    CREATED_DT                      DATETIME,
    CREATED_BY                      VARCHAR(32),
    PRIMARY KEY (AUTHORITY_ID, GROUP_ID),
    FOREIGN KEY (AUTHORITY_ID) REFERENCES TBL_AA_AUTHORITY (AUTHORITY_ID),
    FOREIGN KEY (GROUP_ID) REFERENCES TBL_AA_GROUP (GROUP_ID)
);

/*
---------------------------------------------
-- Creation of TBL_AA_SUBJECT2GROUP
---------------------------------------------
*/
CREATE TABLE TBL_AA_SUBJECT2GROUP (
    SUBJECT_ID                      VARCHAR(32)                 NOT NULL,
    GROUP_ID                        VARCHAR(32)                 NOT NULL,
    AUTHORITY_ID                    VARCHAR(32)                 NOT NULL,
    CREATED_DT                      DATETIME,
    CREATED_BY                      VARCHAR(32),
    UPDATED_DT                      DATETIME,
    UPDATED_BY                      VARCHAR(32),
    VERSION                         INTEGER,
    PRIMARY KEY (SUBJECT_ID, GROUP_ID,AUTHORITY_ID),
    FOREIGN KEY (SUBJECT_ID) REFERENCES TBL_AA_SUBJECT (SUBJECT_ID),
    FOREIGN KEY (GROUP_ID) REFERENCES TBL_AA_GROUP (GROUP_ID)
);

/*
---------------------------------------------
-- Creation of TBL_AA_GROUP2RES
---------------------------------------------
*/
CREATE TABLE TBL_AA_GROUP2RES (
    GROUP_ID                        VARCHAR(32)                 NOT NULL,
    RESOURCES_ID                    VARCHAR(32)                 NOT NULL,
    AUTHORITY_ID                    VARCHAR(32)                 NOT NULL,
    READ_ACCESS                     VARCHAR(1),
    CREATE_ACCESS                   VARCHAR(1),
    UPDATE_ACCESS                   VARCHAR(1),
    DELETE_ACCESS                   VARCHAR(1),
    EFFECTIVE_DT                    DATE,
    EXPIRY_DT                       DATE,
    CREATED_DT                      DATETIME,
    CREATED_BY                      VARCHAR(32),
    UPDATED_DT                      DATETIME,
    UPDATED_BY                      VARCHAR(32),
    VERSION                         INTEGER,
    REF_GROUP_ID                    VARCHAR(32)                 NOT NULL,
    PRIMARY KEY (GROUP_ID, RESOURCES_ID, REF_GROUP_ID,AUTHORITY_ID),
    FOREIGN KEY (GROUP_ID) REFERENCES TBL_AA_GROUP (GROUP_ID) ,
    FOREIGN KEY (RESOURCES_ID) REFERENCES TBL_AA_RESOURCES (RESOURCES_ID)
);

/*
---------------------------------------------
-- Creation of TBL_AA_SUBJECT2RES
---------------------------------------------
*/
CREATE TABLE TBL_AA_SUBJECT2RES (
    SUBJECT_ID                      VARCHAR(32)                 NOT NULL,
    RESOURCES_ID                    VARCHAR(32)                 NOT NULL,
    READ_ACCESS                     VARCHAR(1),
    CREATE_ACCESS                   VARCHAR(1),
    UPDATE_ACCESS                   VARCHAR(1),
    DELETE_ACCESS                   VARCHAR(1),
    EFFECTIVE_DT                    DATE,
    EXPIRY_DT                       DATE,
    CREATED_DT                      DATETIME,
    CREATED_BY                      VARCHAR(32),
    UPDATED_DT                      DATETIME,
    UPDATED_BY                      VARCHAR(32),
    VERSION                         INTEGER,
    REF_GROUP_ID                    VARCHAR(32)                 NOT NULL,
    PRIMARY KEY (SUBJECT_ID, RESOURCES_ID, REF_GROUP_ID),
    FOREIGN KEY (SUBJECT_ID) REFERENCES TBL_AA_SUBJECT (SUBJECT_ID) ,
    FOREIGN KEY (RESOURCES_ID) REFERENCES TBL_AA_RESOURCES (RESOURCES_ID)
);

/*
---------------------------------------------
-- Creation of TBL_AA_ASSIGNABLE_RES
---------------------------------------------
*/
CREATE TABLE TBL_AA_ASSIGNABLE_RES (
    SUBJECT_ID                      VARCHAR(32)                 NOT NULL,
    RESOURCES_ID                    VARCHAR(32)                 NOT NULL,
    EFFECTIVE_DT                    DATE,
    EXPIRY_DT                       DATE,
    CREATED_DT                      DATETIME,
    CREATED_BY                      VARCHAR(32),
    UPDATED_DT                      DATETIME,
    UPDATED_BY                      VARCHAR(32),
    VERSION                         INTEGER,
    PRIMARY KEY (SUBJECT_ID, RESOURCES_ID),
    FOREIGN KEY (SUBJECT_ID) REFERENCES TBL_AA_SUBJECT (SUBJECT_ID) ,
    FOREIGN KEY (RESOURCES_ID) REFERENCES TBL_AA_RESOURCES (RESOURCES_ID)
);

/*
---------------------------------------------
-- Creation of TBL_AA_RES2RES
---------------------------------------------
*/
CREATE TABLE TBL_AA_RES2RES (
    RESOURCES_ID                    VARCHAR(32)                 NOT NULL,
    PARENT_RES_ID                   VARCHAR(32)                 NOT NULL,
    CREATE_ACCESS                   VARCHAR(1),
    READ_ACCESS                     VARCHAR(1),
    UPDATE_ACCESS                   VARCHAR(1),
    DELETE_ACCESS                   VARCHAR(1),
    EFFECTIVE_DT                    DATETIME,
    EXPIRY_DT                       DATETIME,
    CREATED_DT                      DATETIME,
    CREATED_BY                      VARCHAR(32),
    UPDATED_DT                      DATETIME,
    UPDATED_BY                      VARCHAR(32),
    VERSION                         INTEGER,
    REF_GROUP_ID                    VARCHAR(32),
    PRIMARY KEY (RESOURCES_ID, PARENT_RES_ID),
    FOREIGN KEY (RESOURCES_ID) REFERENCES TBL_AA_RESOURCES (RESOURCES_ID)
);

/*
---------------------------------------------
-- Creation of TBL_AA_GROUP_ADMIN
---------------------------------------------
*/
CREATE TABLE TBL_AA_GROUP_ADMIN (
    GROUP_ID                        VARCHAR(32)                 NOT NULL,
    ADMIN_TYPE                      VARCHAR(1)                  NOT NULL,
    ADMIN_ID                        VARCHAR(32)                 NOT NULL,
    DELEGATOR_ID                    VARCHAR(32),
    PRECEDENCE                      INTEGER,
    CREATED_DT                      DATETIME,
    CREATED_BY                      VARCHAR(32),
    UPDATED_DT                      DATETIME,
    UPDATED_BY                      VARCHAR(32),
    VERSION                         INTEGER NOT NULL,
    FOREIGN KEY (GROUP_ID) REFERENCES TBL_AA_GROUP (GROUP_ID),
    PRIMARY KEY (GROUP_ID, ADMIN_TYPE, ADMIN_ID)
);

/*
---------------------------------------------
-- Creation of TBL_AA_SUBJECT2DELEGATOR
---------------------------------------------
*/
CREATE TABLE TBL_AA_SUBJECT2DELEGATOR (
    SUBJECT2DELEGATOR_PK            VARCHAR(32)                 NOT NULL,
    SUBJECT_ID                      VARCHAR(32)                 NOT NULL,
    DELEGATOR_ID                    VARCHAR(32)                 NOT NULL,
    CREATED_DT                      DATETIME,
    CREATED_BY                      VARCHAR(32),
    VERSION                         INTEGER NOT NULL,
    PRIMARY KEY (SUBJECT2DELEGATOR_PK),
    FOREIGN KEY (SUBJECT_ID) REFERENCES TBL_AA_SUBJECT (SUBJECT_ID),
    FOREIGN KEY (DELEGATOR_ID) REFERENCES TBL_AA_SUBJECT (SUBJECT_ID)
);

/*
---------------------------------------------
-- Creation of TBL_AA_DELEGATED_RESOURCES
---------------------------------------------
*/
CREATE TABLE TBL_AA_DELEGATED_RESOURCES (
    SUBJECT2DELEGATOR_PK            VARCHAR(32)                 NOT NULL,
    RESOURCES_ID                    VARCHAR(32)                 NOT NULL,
    READ_ACCESS                     VARCHAR(1),
    CREATE_ACCESS                   VARCHAR(1),
    UPDATE_ACCESS                   VARCHAR(1),
    DELETE_ACCESS                   VARCHAR(1),
    EFFECTIVE_DT                    DATE,
    EXPIRY_DT                       DATE,
    CREATED_DT                      DATETIME,
    CREATED_BY                      VARCHAR(32),
    UPDATED_DT                      DATETIME,
    UPDATED_BY                      VARCHAR(32),
    VERSION                         INTEGER,
    REF_GROUP_ID                    VARCHAR(32)                 NOT NULL,
    PRIMARY KEY (SUBJECT2DELEGATOR_PK, RESOURCES_ID, REF_GROUP_ID),
    FOREIGN KEY (SUBJECT2DELEGATOR_PK) REFERENCES TBL_AA_SUBJECT2DELEGATOR (SUBJECT2DELEGATOR_PK) ,
    FOREIGN KEY (RESOURCES_ID) REFERENCES TBL_AA_RESOURCES (RESOURCES_ID)
);

/*
---------------------------------------------
-- Creation of TBL_AA_AUDIT_LOG
---------------------------------------------
*/
create table TBL_AA_AUDIT_LOG(
    CLASS                           VARCHAR(255),
    MESSAGE                         VARCHAR(255),
    AUDIT_LEVEL                     VARCHAR(50),
    AUDIT_DATE                      DATETIME
);

/*
---------------------------------------------
-- Creation of TBL_AA_PUBLIC_REG
---------------------------------------------
*/
CREATE TABLE TBL_AA_PUBLIC_REG(
    SUBJECT_ID                      VARCHAR(32)                 NOT NULL,
    LOGIN_MECHANISM                 VARCHAR(32)                 NOT NULL,
    PUBLIC_ACTIVATION_KEY           VARCHAR(32),
    REASON                          VARCHAR(200),
    UPDATED_DT                      DATETIME
);

ALTER TABLE TBL_AA_PUBLIC_REG
	ADD PRIMARY KEY (SUBJECT_ID, LOGIN_MECHANISM);

/*
---------------------------------------------
-- Creation of TBL_AA_DOMAIN
---------------------------------------------
*/
CREATE TABLE TBL_AA_DOMAIN(
    DOMAIN_NAME	                    VARCHAR(32)                 NOT NULL,
    PRIMARY KEY(DOMAIN_NAME)
);

/*
---------------------------------------------
-- Creation of TBL_AA_SIGN_LOG
---------------------------------------------
*/
CREATE TABLE TBL_AA_SIGN_LOG(
    REQUEST_URI                     VARCHAR(255)                NOT NULL,
    IP_ADDRESS                      VARCHAR(40)                 NOT NULL,
    DETAILS                         BLOB                        NOT NULL,
    CREATED_DT                      DATETIME                    NOT NULL,
    CREATED_BY                      VARCHAR(32)                 NOT NULL,
    VALID                           CHAR(1)                     NOT NULL
);

DELETE FROM TBL_MENU_DISPLAYER WHERE REPOSITORY_ID = 'ACM-MENU';
DELETE FROM TBL_MENU_ITEM WHERE REPOSITORY_ID = 'ACM-MENU';
DELETE FROM TBL_MENU_REPOSITORY WHERE REPOSITORY_ID = 'ACM-MENU';

INSERT INTO TBL_MENU_DISPLAYER
(`REPOSITORY_ID`, `NAME`, `TYPE`, `CONFIG`)
VALUES
('ACM-MENU', 'CoolMenu', 'com.ncs.iframe.extensions.menu.displayer.CoolMenuDisplayer', '' ),
('ACM-MENU', 'ListMenu', 'com.ncs.iframe.extensions.menu.displayer.ListMenuDisplayer', '' ),
('ACM-MENU', 'SimpleMenu', 'com.ncs.iframe.extensions.menu.displayer.SimpleMenuDisplayer', '' );

INSERT INTO TBL_MENU_ITEM
(`REPOSITORY_ID`, `ITEM_ID`, `PARENT_ITEM_ID`, `ITEM_SEQ`, `NAME`, `TITLE`, `LOCATION`, `TARGET`, `DESCRIPTION`, `ON_CLICK`, `ON_MOUSE_OVER`, `ON_MOUSE_OUT`, `IMAGE`, `ALT_IMAGE`, `TOOL_TIP`, `ROLES`, `PAGE`, `CATEGORY`, `VERSION`)
VALUES
( 'ACM-MENU', '1', null, 1, 'UA', 'title.userAdmin', null, '', 'User Administration', '', '', '', '', '', '', '', null, null, 1 ),
( 'ACM-MENU', '2', '1', 1, 'Add User Account', 'title.addUserAccount', '/acm/ua/adduser.do', 'msg_main', 'Add User Account', '', '', '', '', '', '', '', null, null, 11 ),
( 'ACM-MENU', '3', '1', 2, 'Search User', 'title.searchUser', '/acm/ua/searchuser.do', 'msg_main', 'Search User', '', '', '', '', '', '', '', null, null, 11 ),
( 'ACM-MENU', '4', '1', 3, 'Search Group', 'title.searchGroup', '/acm/ua/searchgroup.do', 'msg_main', 'Search Group', '', '', '', '', '', '', '', null, null, 11 ),
( 'ACM-MENU', '5', '1', 4, 'Create Group', 'title.createGroup', '/acm/ua/addgroup.do', 'msg_main', 'Create Group', '', '', '', '', '', '', '', null, null, 11 ),
( 'ACM-MENU', '6', null, 2, 'RA', 'title.roleAdmin', null, '', 'Role Administration', '', '', '', '', '', '', '', null, null, 1 ),
( 'ACM-MENU', '7', '6', 1, 'Search Role', 'title.searchRole', '/acm/ra/searchrole.do', 'msg_main', 'Search Role', '', '', '', '', '', '', '', null, null, 11 ),
( 'ACM-MENU', '8', '6', 2, 'Create Role', 'title.createRole', '/acm/ra/addrole.do', 'msg_main', 'Create Role', '', '', '', '', '', '', '', null, null, 11 ),
( 'ACM-MENU', '9', '6', 3, 'Search Permission', 'title.searchPermission', '/acm/ra/searchpermission.do', 'msg_main', 'Search Permission', '', '', '', '', '', '', '', null, null, 11 ),
( 'ACM-MENU', '10', '6', 4, 'Create Permission', 'title.createPermission', '/acm/ra/addpermission.do', 'msg_main', 'Create Permission', '', '', '', '', '', '', '', null, null, 11 ),
( 'ACM-MENU', '11', '6', 5, 'Search Resources', 'title.searchResources', '/acm/ra/searchresources.do', 'msg_main', 'Search Resources', '', '', '', '', '', '', '', null, null, 11 ),
( 'ACM-MENU', '12', '6', 6, 'Create Resources', 'title.createResources', '/acm/ra/addresources.do', 'msg_main', 'Create Resources', '', '', '', '', '', '', '', null, null, 11 ),
( 'ACM-MENU', '13', '1', 5, 'Delegate Duties', 'title.delegateDuties', '/acm/ua/vieweditdelegation.do', 'msg_main', 'Delegate Duties', '', '', '', '', '', '', '', null, null, 11 ),
( 'ACM-MENU', '14', '1', 6, 'Clone User', 'title.cloneUser', '/acm/ua/cloneuser.do', 'msg_main', 'Clone User', '', '', '', '', '', '', '', null, null, 1 );

INSERT INTO TBL_MENU_REPOSITORY
(`REPOSITORY_ID`, `REPOSITORY_DESC`)
VALUES
( 'ACM-MENU', '' );