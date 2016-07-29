drop table if exists `tbl_mt_ad_user_tmp`;

CREATE TABLE `tbl_mt_ad_user_tmp` (
  `AD_USER_ID` varchar(32) NOT NULL DEFAULT '',
  `USER_NAME` varchar(100) DEFAULT NULL,
  `USER_ID` varchar(10) DEFAULT NULL,
  `FIRST_NAME` varchar(100) DEFAULT NULL,
  `LAST_NAME` varchar(100) DEFAULT NULL,
  `EMAIL` varchar(255) DEFAULT NULL,
  `PHOTO` mediumblob,
  `STATUS` char(1) DEFAULT NULL COMMENT 'P – Pending activated  A – Activated\\r',
  `CREATED_DT` datetime DEFAULT NULL,
  `CREATED_BY` varchar(32) DEFAULT NULL,
  `UPDATED_DT` datetime DEFAULT NULL,
  `UPDATED_BY` varchar(32) DEFAULT NULL,
  `TENANT_NAME` varchar(100) DEFAULT NULL,
  `STUDENT_ID` varchar(50) DEFAULT NULL,
  `STUDENT_STATUS_ICODE` char(1) DEFAULT NULL,
  `SCHOOL_CODE` varchar(10) DEFAULT NULL,
  `ACADEMIC_YEAR` char(4) DEFAULT NULL,
  `LEVEL_XCODE` char(4) DEFAULT NULL,
  `CLASS_XCODE` char(10) DEFAULT NULL,
  `PASSWORD` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`AD_USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;