/* MySQL Scripts for MobileConnect eBook Server */

/*
-------------------------------------------------
-- Drop the relevant tables
-------------------------------------------------
*/
DROP TABLE IF EXISTS TBL_MC_RECEIPT;
DROP TABLE IF EXISTS TBL_MC_RECEIPT_DATA;
DROP TABLE IF EXISTS TBL_MC_SUBSCRIPTION;

DROP TABLE IF EXISTS TBL_MT_USER_NOTIFICATION_LOG;
DROP TABLE IF EXISTS TBL_MT_USER_LOGIN_LOG;
DROP TABLE IF EXISTS TBL_MC_REQUEST_LOG;
DROP TABLE IF EXISTS TBL_MC_PAYMENT_LOG;
DROP TABLE IF EXISTS TBL_MC_DOWNLOAD_LOG;

DROP TABLE IF EXISTS TBL_MC_BOOKSTORE_VIEW_CATEGORY;
DROP TABLE IF EXISTS TBL_MC_BOOKSTORE_CONSUMER;
DROP TABLE IF EXISTS TBL_MC_BOOKSTORE_REMOTE;

DROP TABLE IF EXISTS TBL_MC_ASSIGNMENT_SUBMISSION_MARK;
DROP TABLE IF EXISTS TBL_MC_ASSIGNMENT_SUBMISSION_ANSWER;
DROP TABLE IF EXISTS TBL_MC_ASSIGNMENT_SUBMISSION_QUESTION;
DROP TABLE IF EXISTS TBL_MC_ASSIGNMENT_SUBMISSION;

DROP TABLE IF EXISTS TBL_MC_HOTSPOT_ESSAY_QUESTION;
DROP TABLE IF EXISTS TBL_MC_HOTSPOT_MCQ_CHOICE;
DROP TABLE IF EXISTS TBL_MC_HOTSPOT_MCQ_QUESTION;
DROP TABLE IF EXISTS TBL_MC_HOTSPOT_HYPERLINK;
DROP TABLE IF EXISTS TBL_MC_HOTSPOT_TEXT;
DROP TABLE IF EXISTS TBL_MC_HOTSPOT_MEDIA;
DROP TABLE IF EXISTS TBL_MC_HOTSPOT;

DROP TABLE IF EXISTS TBL_MC_USER_ANNOTATION_QUOTA;
DROP TABLE IF EXISTS TBL_MC_CLOUD_ANNOTATION_PACKAGE;
DROP TABLE IF EXISTS TBL_MC_CLOUD_ANNOTATION;
DROP TABLE IF EXISTS TBL_MC_ANNOTATION_LIKE;
DROP TABLE IF EXISTS TBL_MC_ANNOTATION_COMMENT;
DROP TABLE IF EXISTS TBL_MC_ANNOTATION_PACKAGE2OU;
DROP TABLE IF EXISTS TBL_MC_ANNOTATION_PACKAGE;
DROP TABLE IF EXISTS TBL_MC_ANNOTATION;

DROP VIEW IF EXISTS TBL_MC_LATEST_PUBLICATION;

DROP TABLE IF EXISTS TBL_MT_PUB_BANK_DTL;
DROP TABLE IF EXISTS TBL_MT_PUBLISHER;
DROP TABLE IF EXISTS TBL_MT_PUB_CONTACTS;

DROP TABLE IF EXISTS TBL_MT_AUTH_CACHE;
DROP TABLE IF EXISTS TBL_MT_TENANT_PROTOCOL;
DROP TABLE IF EXISTS TBL_MT_AUTH_PROTOCOL;
DROP TABLE IF EXISTS TBL_MT_USER_NOTIFICATION_PARAM;
DROP TABLE IF EXISTS TBL_MT_USER_NOTIFICATION;
DROP TABLE IF EXISTS TBL_MT_USER_DEVICE;
DROP TABLE IF EXISTS TBL_MC_USER2PROFILE;
DROP TABLE IF EXISTS TBL_MC_USER2MGROUP;
DROP TABLE IF EXISTS TBL_MT_USER2OU;
DROP TABLE IF EXISTS TBL_MT_USER2TENANT;
DROP TABLE IF EXISTS TBL_MT_USER;

DROP TABLE IF EXISTS TBL_MC_PUBLICATION_PREVIEW_OU;
DROP TABLE IF EXISTS TBL_MC_PUBLICATION_PREVIEW;
DROP TABLE IF EXISTS TBL_MC_DEVICE2PUBLICATION;
DROP TABLE IF EXISTS TBL_MC_PUBLICATION_RATING;
DROP TABLE IF EXISTS TBL_MC_PUBLICATION2OFFER;
DROP TABLE IF EXISTS TBL_MC_PUBLICATION2CATEGORY;
DROP TABLE IF EXISTS TBL_MC_PUBLICATION2OU;
DROP TABLE IF EXISTS TBL_MC_PUBLICATION;

DROP TABLE IF EXISTS TBL_MC_CONTENT_ATTACHMENT;
DROP TABLE IF EXISTS TBL_MC_CONTENT_METADATA;
DROP TABLE IF EXISTS TBL_MC_CONTENT2ASSIGNMENT;
DROP TABLE IF EXISTS TBL_MC_CONTENT_REMARKS;
DROP TABLE IF EXISTS TBL_MC_CONTENT_TOC;
DROP TABLE IF EXISTS TBL_MC_CONTENT_PAGE2QUESTION;
DROP TABLE IF EXISTS TBL_MC_CONTENT_PAGE;
DROP TABLE IF EXISTS TBL_MC_CONTENT_PACKAGE;
DROP TABLE IF EXISTS TBL_MC_CONTENT_MEDIA;
DROP TABLE IF EXISTS TBL_MC_CONTENT2OU;
DROP TABLE IF EXISTS TBL_MC_CONTENT;

DROP TABLE IF EXISTS TBL_MC_ACCOUNT_SOURCE;
DROP TABLE IF EXISTS TBL_MC_WEBSITE_SEARCH_SETTING;
DROP TABLE IF EXISTS TBL_MC_RESET_PWD_REQUEST;
DROP TABLE IF EXISTS TBL_MC_MGROUP;
DROP TABLE IF EXISTS TBL_MC_MFRIENDS;
DROP TABLE IF EXISTS TBL_MC_INVITATION;
DROP TABLE IF EXISTS TBL_MC_ACCOUNTPROFILE2USER;
DROP TABLE IF EXISTS TBL_MC_GROUP_PROFILE_DTL;
DROP TABLE IF EXISTS TBL_MC_GROUP_PROFILE;
DROP TABLE IF EXISTS TBL_MC_PROFILE2STORE;
DROP TABLE IF EXISTS TBL_MC_PROFILE;
DROP TABLE IF EXISTS TBL_MC_CUSTOM_LABEL;
DROP TABLE IF EXISTS TBL_MC_SETTING;
DROP TABLE IF EXISTS TBL_MC_CATEGORY_SUBSCRIBERS;
DROP TABLE IF EXISTS TBL_MC_CATEGORY2VIEW_OU;
DROP TABLE IF EXISTS TBL_MC_CATEGORY2CREATE_OU;
DROP TABLE IF EXISTS TBL_MC_CATEGORY2OU;
DROP TABLE IF EXISTS TBL_MC_CATEGORY;
DROP TABLE IF EXISTS TBL_MC_OFFER2OU;
DROP TABLE IF EXISTS TBL_MC_OFFER;
DROP TABLE IF EXISTS TBL_MC_DEVICE;
DROP TABLE IF EXISTS TBL_MC_STORE;

DROP TABLE IF EXISTS TBL_MT_OU;
DROP TABLE IF EXISTS TBL_MT_TENANT;

/*
-----------------------------------------------
-- Creation of TBL_MT_TENANT
-----------------------------------------------
*/
CREATE TABLE TBL_MT_TENANT (
    TENANT_ID                       VARCHAR(32)                 NOT NULL,
    TENANT_NAME                     VARCHAR(50)                 NOT NULL,
    TENANT_DESC                     VARCHAR(255),
    PROTOCOL_ID                     VARCHAR(32),
    DEFAULT_OU                      VARCHAR(32),
    GROUP_ID                        VARCHAR(32),
    REFERENCE_ID                    VARCHAR(32),
    CREATED_BY                      VARCHAR(32)                 NOT NULL,
    CREATED_DT                      DATETIME                    NOT NULL,
    UPDATED_BY                      VARCHAR(32)                 NOT NULL,
    UPDATED_DT                      DATETIME                    NOT NULL,
    VERSION                         INTEGER                     NOT NULL,
    PRIMARY KEY (TENANT_ID)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;
create index index_1_tbl_mt_tenant on tbl_mt_tenant (tenant_id);

/*
-----------------------------------------------
-- Creation of TBL_MT_OU
-----------------------------------------------
*/
CREATE TABLE TBL_MT_OU (
    OU_ID                           VARCHAR(32)                 NOT NULL,
    OU_NAME                         VARCHAR(100)                NOT NULL,
    OU_DESC                         VARCHAR(255),
    OU_PARENT_ID                    VARCHAR(32),
    TENANT_ID                       VARCHAR(32)                 NOT NULL,
    GROUP_ID                        VARCHAR(32),
    CREATED_BY                      VARCHAR(32)                 NOT NULL,
    CREATED_DT                      DATETIME                    NOT NULL,
    UPDATED_BY                      VARCHAR(32)                 NOT NULL,
    UPDATED_DT                      DATETIME                    NOT NULL,
    VERSION                         INTEGER                     NOT NULL,
    PRIMARY KEY (OU_ID)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;

/*
-----------------------------------------------
-- Creation of TBL_MC_STORE
-----------------------------------------------
*/
CREATE TABLE TBL_MC_STORE (
    STORE_ID                        VARCHAR(32)                 NOT NULL,
    STORE_NAME                      VARCHAR(100)                NOT NULL,
    STORE_DESC                      VARCHAR(255),
    TENANT_ID                       VARCHAR(32)                 NOT NULL,
    CREATED_BY                      VARCHAR(32)                 NOT NULL,
    CREATED_DT                      DATETIME                    NOT NULL,
    UPDATED_BY                      VARCHAR(32)                 NOT NULL,
    UPDATED_DT                      DATETIME                    NOT NULL,
    VERSION                         INTEGER                     NOT NULL,
    PRIMARY KEY (STORE_ID)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;
create index index_1_tbl_mc_store on tbl_mc_store (store_id);

/*
-----------------------------------------------
-- Creation of TBL_MC_DEVICE
-----------------------------------------------
*/
CREATE TABLE TBL_MC_DEVICE (
    DEVICE_ID                       VARCHAR(32)                 NOT NULL,
    DEVICE_OS                       VARCHAR(100)                NOT NULL,
    DESCRIPTION                     VARCHAR(255),
    WIDTH                           INTEGER,
    HEIGHT                          INTEGER,
    STORE_ID                        VARCHAR(32)                 NOT NULL,
    CREATED_BY                      VARCHAR(32)                 NOT NULL,
    CREATED_DT                      DATETIME                    NOT NULL,
    UPDATED_BY                      VARCHAR(32)                 NOT NULL,
    UPDATED_DT                      DATETIME                    NOT NULL,
    VERSION                         INTEGER                     NOT NULL,
    PRIMARY KEY PK_MC_DEVICE (DEVICE_ID)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;

/*
-----------------------------------------------
-- Creation of TBL_MC_OFFER
-----------------------------------------------
*/
CREATE TABLE TBL_MC_OFFER (
    OFFER_ID                        VARCHAR(32)                 NOT NULL,
    OFFER_CODE                      VARCHAR(100)                NOT NULL,
    OFFER_DESC                      VARCHAR(255)                NOT NULL,
    OFFER_LABEL                     VARCHAR(50)                 NOT NULL,
    IS_FREE                         CHAR(1)                     NOT NULL,
    PRODUCT_IDENTIFIER              VARCHAR(255)                NOT NULL,
    PRICE_CENTS                     INTEGER                     NOT NULL,
    VALID_FROM                      DATETIME,
    VALID_TO                        DATETIME,
    SUBS_PERIOD_HRS                 INTEGER                     NOT NULL,
    PRECEDENCE                      INTEGER                     NOT NULL,
    STORE_ID                        VARCHAR(32)                 NOT NULL,
    CREATED_BY                      VARCHAR(32)                 NOT NULL,
    CREATED_DT                      DATETIME                    NOT NULL,
    UPDATED_BY                      VARCHAR(32)                 NOT NULL,
    UPDATED_DT                      DATETIME                    NOT NULL,
    VERSION                         INTEGER                     NOT NULL,
    PRIMARY KEY PK_MC_OFFER (OFFER_ID),
    INDEX IDX_MC_OFFER_01 (OFFER_CODE)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;

/*
-----------------------------------------------
-- Creation of TBL_MC_OFFER2OU
-----------------------------------------------
*/
CREATE TABLE TBL_MC_OFFER2OU (
    OFFER_ID                        VARCHAR(32)                 NOT NULL,
    OU_ID                           VARCHAR(32)                 NOT NULL,
    CREATED_BY                      VARCHAR(32)                 NOT NULL,
    CREATED_DT                      DATETIME                    NOT NULL,
    UPDATED_BY                      VARCHAR(32)                 NOT NULL,
    UPDATED_DT                      DATETIME                    NOT NULL,
    VERSION                         INTEGER                     NOT NULL,
    PRIMARY KEY (OFFER_ID, OU_ID)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;

/*
-----------------------------------------------
-- Creation of TBL_MC_CATEGORY
-----------------------------------------------
*/
CREATE TABLE TBL_MC_CATEGORY (
    CATEGORY_ID                     VARCHAR(32)                 NOT NULL,
    TITLE                           VARCHAR(255)                NOT NULL,
    PARENT_ID                       VARCHAR(32)                 NOT NULL,
    SEQUENCE                        INTEGER                     NOT NULL,
    IMAGE_PATH                      VARCHAR(255),
    STORE_ID                        VARCHAR(32)                NOT NULL,
    FULL_CATEGORY_PATH              TEXT,
    CREATED_BY                      VARCHAR(32)                 NOT NULL,
    CREATED_DT                      DATETIME                    NOT NULL,
    UPDATED_BY                      VARCHAR(32)                 NOT NULL,
    UPDATED_DT                      DATETIME                    NOT NULL,
    VERSION                         INTEGER                     NOT NULL,
    PRIMARY KEY PK_MC_CATEGORY (CATEGORY_ID)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;

/*
-----------------------------------------------
-- Creation of TBL_MC_CATEGORY2OU
-----------------------------------------------
*/
CREATE TABLE `TBL_MC_CATEGORY2OU` (
    `CATEGORY_ID`                   VARCHAR(32)                 NOT NULL,
    `OU_ID`                         VARCHAR(32)                 NOT NULL,
    `CREATED_BY`                    VARCHAR(32)                 NOT NULL,
    `CREATED_DT`                    DATETIME                    NOT NULL,
    `UPDATED_BY`                    VARCHAR(32)                 NOT NULL,
    `UPDATED_DT`                    DATETIME                    NOT NULL,
    `VERSION`                       INT(11)                     NOT NULL,
    PRIMARY KEY (`CATEGORY_ID`, `OU_ID`),
    FOREIGN KEY FK_TBL_MC_CATEGORY2OU_1 (OU_ID) REFERENCES TBL_MT_OU (OU_ID)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;

/*
-----------------------------------------------
-- Creation of TBL_MC_CATEGORY2CREATE_OU
-----------------------------------------------
*/
CREATE TABLE TBL_MC_CATEGORY2CREATE_OU (
    CATEGORY_ID                     VARCHAR(32)                 NOT NULL,
    OU_ID                           VARCHAR(32)                 NOT NULL,
    CREATED_BY                      VARCHAR(32)                 NOT NULL,
    CREATED_DT                      DATETIME                    NOT NULL,
    PRIMARY KEY (CATEGORY_ID, OU_ID),
    FOREIGN KEY FK_TBL_MC_CATEGORY2CREATE_OU_1 (OU_ID) REFERENCES TBL_MT_OU (OU_ID)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;

/*
-----------------------------------------------
-- Creation of TBL_MC_CATEGORY2VIEW_OU
-----------------------------------------------
*/
CREATE TABLE TBL_MC_CATEGORY2VIEW_OU (
    CATEGORY_ID                     VARCHAR(32)                 NOT NULL,
    OU_ID                           VARCHAR(32)                 NOT NULL,
    CREATED_BY                      VARCHAR(32)                 NOT NULL,
    CREATED_DT                      DATETIME                    NOT NULL,
    PRIMARY KEY (CATEGORY_ID, OU_ID),
    FOREIGN KEY FK_TBL_MC_CATEGORY2VIEW_OU_1 (OU_ID) REFERENCES TBL_MT_OU (OU_ID)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;

/*
-----------------------------------------------
-- Creation of TBL_MC_CATEGORY_SUBSCRIBERS
-----------------------------------------------
*/
CREATE TABLE TBL_MC_CATEGORY_SUBSCRIBERS(
    SUBSCRIBERS_ID                  VARCHAR(32)                 NOT NULL,
    CATEGORY_ID                     VARCHAR(32)                 NOT NULL,
    USER_ID                         VARCHAR(32)                 NOT NULL,
    SUB_START_DT                    DATETIME                    NULL,
    SUB_END_DT                      DATETIME                    NULL,
    STATUS                          CHAR(1)                     NULL,
    CREATED_BY                      VARCHAR(32)                 NOT NULL,
    CREATED_DT                      DATETIME                    NOT NULL,
    UPDATED_BY                      VARCHAR(32)                 NOT NULL,
    UPDATED_DT                      DATETIME                    NOT NULL
) ENGINE=INNODB DEFAULT CHARSET=UTF8;
ALTER TABLE TBL_MC_CATEGORY_SUBSCRIBERS ADD CONSTRAINT PK_TBL_MC_CATEGORY_SUBSCRIBERS  PRIMARY KEY (SUBSCRIBERS_ID);

/*
-----------------------------------------------
-- TBL_MC_SETTING
-----------------------------------------------
*/
CREATE TABLE TBL_MC_SETTING (
    SETTING_ID                      VARCHAR(32)                 NOT NULL,
    STORE_ID                        VARCHAR(32)                 NOT NULL                        UNIQUE,
    VIDEO_SIZE                      FLOAT                       NOT NULL,
    AUDIO_SIZE                      FLOAT                       NOT NULL,
    IMAGE_SIZE                      FLOAT                       NOT NULL,
    HIDE_PRICE                      VARCHAR(2)                  DEFAULT '0',
    HIDE_EXAM                       VARCHAR(2)                  DEFAULT '0',
    MAX_CATEGORY_DEPTH              int(2)                      DEFAULT '0',
    HIDE_MARKABLE                   VARCHAR(2)                  DEFAULT '0',
    HIDE_SUPPORTED_DEVICES          VARCHAR(2)                  DEFAULT '0',
    HIDE_META_DATA                  VARCHAR(2)                  DEFAULT '0',
    HIDE_DISTRIBUTION_MODES         VARCHAR(2)                  DEFAULT '0',
    HIDE_MUTUALLY_EXCLUSIVE         VARCHAR(2)                  DEFAULT '0',
    HIDE_DATE_OF_PUBLICATION        VARCHAR(2)                  DEFAULT '0',
    HIDE_NOTIFICATION               VARCHAR(2)                  DEFAULT '0',
    HIDE_CATEGORY_SUBSCRIPTION      VARCHAR(2)                  DEFAULT '0',
    CHOICE_NUMBER                   int(2)                      DEFAULT 6,
    CREATED_BY                      VARCHAR(32),
    CREATED_DT                      DATETIME,
    UPDATED_BY                      VARCHAR(32),
    UPDATED_DT                      DATETIME,
    VERSION                         INTEGER,
    PRIMARY KEY (SETTING_ID),
    FOREIGN KEY FK_MC_SETTING_01 (STORE_ID) REFERENCES TBL_MC_STORE (STORE_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*
-----------------------------------------------
-- TBL_MC_CUSTOM_LABEL
-----------------------------------------------
*/
CREATE TABLE `TBL_MC_CUSTOM_LABEL` (
    `LABEL_ID`                      VARCHAR(32)                 PRIMARY KEY,
    `TENANT_ID`                     VARCHAR(32)                 NOT NULL,
    `LABEL_KEY`                     VARCHAR(100)                NOT NULL,
    `LABEL_VALUE`                   VARCHAR(500)                NOT NULL,
    `LABEL_TYPE`                    CHAR(2)                     NOT NULL,
    `CREATED_DT`                    DATE                        DEFAULT NULL,
    `CREATED_BY`                    VARCHAR(32)                 DEFAULT NULL,
    `UPDATED_DT`                    DATE                        DEFAULT NULL,
    `UPDATED_BY`                    VARCHAR(32)                 DEFAULT NULL,
    `VERSION`                       INT(11)                     NOT NULL                        DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*
-----------------------------------------------
-- Creation of TBL_MC_PROFILE
-----------------------------------------------
*/
CREATE TABLE TBL_MC_PROFILE (
    PROFILE_ID                      VARCHAR(32)                 NOT NULL,
    `KEY`                           VARCHAR(50)                 NOT NULL,
    DEFAULT_VALUE                   VARCHAR(20),
    DESCRIPTION                     VARCHAR(255)                NOT NULL,
    `TYPE`                          CHAR(2)                     NOT NULL,
    PRIMARY KEY PK_MC_PROFILE (PROFILE_ID)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;

/*
-----------------------------------------------
-- Creation of TBL_MC_PROFILE2STORE
-----------------------------------------------
*/
CREATE TABLE TBL_MC_PROFILE2STORE (
    STORE_ID                        VARCHAR(32)                 NOT NULL, 
    PROFILE_ID                      VARCHAR(32)                 NOT NULL,
    `VALUE`                         VARCHAR(20)                 NOT NULL,
    CREATED_BY                      VARCHAR(32)                 NOT NULL,
    CREATED_DT                      DATETIME                    NOT NULL,
    UPDATED_BY                      VARCHAR(32)                 NOT NULL,
    UPDATED_DT                      DATETIME                    NOT NULL,
    VERSION                         INTEGER                     NOT NULL,
    PRIMARY KEY PK_MC_PROFILE (PROFILE_ID, STORE_ID)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;

/*
-----------------------------------------------
-- Creation of TBL_MC_GROUP_PROFILE
-----------------------------------------------
*/
CREATE TABLE TBL_MC_GROUP_PROFILE(
    GROUP_PROFILE_ID                VARCHAR(32)                 NOT NULL,
    GROUP_NAME                      VARCHAR(32)                 NOT NULL,
    TENANT_ID                       VARCHAR(32)                 NOT NULL,
    TYPE                            CHAR(2)                     NOT NULL,
    CREATED_BY                      VARCHAR(32),
    CREATED_DT                      DATETIME,
    UPDATED_BY                      VARCHAR(32),
    UPDATED_DT                      DATETIME,
    VERSION                         INTEGER,
    PRIMARY KEY PK_TBL_MC_GROUP_PROFILE (GROUP_PROFILE_ID)
) ENGINE = INNODB DEFAULT CHARSET = UTF8;

/*
-----------------------------------------------
-- Creation of TBL_MC_GROUP_PROFILE_DTL
-----------------------------------------------
*/
CREATE TABLE TBL_MC_GROUP_PROFILE_DTL(
    GROUP_PROFILE_DTL_ID            VARCHAR(32)                 NOT NULL,
    GROUP_PROFILE_ID                VARCHAR(32)                 NOT NULL,
    PROFILE_ID                      VARCHAR(32)                 NOT NULL,
    VALUE                           VARCHAR(20),
    CREATED_BY                      VARCHAR(32),
    CREATED_DT                      DATETIME,
    UPDATED_BY                      VARCHAR(32),
    UPDATED_DT                      DATETIME,
    VERSION                         INTEGER,
    PRIMARY KEY PK_TBL_MC_GROUP_PROFILE_DTL (GROUP_PROFILE_DTL_ID)
) ENGINE = INNODB DEFAULT CHARSET = UTF8;

/*
-----------------------------------------------
-- Creation of TBL_MC_ACCOUNTPROFILE2USER
-----------------------------------------------
*/
CREATE TABLE TBL_MC_ACCOUNTPROFILE2USER(
    SUBJECT_ID                      VARCHAR(32)                 NOT NULL,
    GROUP_PROFILE_ID                VARCHAR(32)                 NOT NULL,
    CREATED_BY                      VARCHAR(32),
    CREATED_DT                      DATETIME,
    UPDATED_BY                      VARCHAR(32),
    UPDATED_DT                      DATETIME,
    VERSION                         INTEGER,
    PRIMARY KEY PK_TBL_MC_ACCOUNTPROFILE2USER (SUBJECT_ID)
) ENGINE = INNODB DEFAULT CHARSET = UTF8;

/*
-----------------------------------------------
-- Creation of TBL_MC_INVITATION
-----------------------------------------------
*/
CREATE TABLE IF NOT EXISTS `TBL_MC_INVITATION` (
    `INVITE_ID`                     VARCHAR(32)                 NOT NULL,
    `USER_FROM`                     VARCHAR(32)                 NULL,
    `USER_TO`                       VARCHAR(32)                 NULL,
    `TITLE`                         VARCHAR(500)                NULL,
    `STATUS`                        INT                         NULL,
    `CREATED_BY`                    VARCHAR(32)                 NULL,
    `CREATED_DT`                    DATETIME                    NULL,
    `UPDATED_BY`                    VARCHAR(32)                 NULL,
    `UPDATED_DT`                    DATETIME                    NULL,
    `VERSION`                       INT                         NULL,
    PRIMARY KEY (`INVITE_ID`)
) ENGINE = InnoDB DEFAULT CHARSET=UTF8;

/*
-----------------------------------------------
-- Creation of TBL_MC_MFRIENDS
-----------------------------------------------
*/
CREATE TABLE IF NOT EXISTS `TBL_MC_MFRIENDS` (
    `FRIEND_ID`                     VARCHAR(32)                 NOT NULL,
    `USER1_ID`                      VARCHAR(32)                 NULL,
    `USER2_ID`                      VARCHAR(32)                 NULL,
    `STATUS`                        INT                         NULL,
    `CREATED_BY`                    VARCHAR(32)                 NULL,
    `CREATED_DT`                    DATETIME                    NULL,
    `UPDATED_BY`                    VARCHAR(32)                 NULL,
    `UPDATED_DT`                    DATETIME                    NULL,
    `VERSION`                       INT                         NULL,
    PRIMARY KEY (`FRIEND_ID`)
) ENGINE = InnoDB DEFAULT CHARSET=UTF8;

/*
-----------------------------------------------
-- Creation of TBL_MC_MGROUP
-----------------------------------------------
*/
CREATE TABLE IF NOT EXISTS `TBL_MC_MGROUP` (
    `MGROUP_ID`                     VARCHAR(32)                 NOT NULL,
    `GROUP_NAME`                    VARCHAR(32)                 NOT NULL,
    `DESCRIPTION`                   VARCHAR(255)                DEFAULT NULL,
    `CREATED_BY`                    VARCHAR(32)                 DEFAULT NULL,
    `CREATED_DT`                    DATETIME                    DEFAULT NULL,
    `UPDATED_BY`                    VARCHAR(32)                 DEFAULT NULL,
    `UPDATED_DT`                    DATETIME                    DEFAULT NULL,
    PRIMARY KEY  (`MGROUP_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

/*
-----------------------------------------------
-- Creation of TBL_MC_RESET_PWD_REQUEST
-----------------------------------------------
*/
CREATE TABLE TBL_MC_RESET_PWD_REQUEST (
    REQUEST_ID                      VARCHAR(32)                 NOT NULL,
    SUBJECT_ID                      VARCHAR(32)                 NOT NULL,
    EMAIL                           VARCHAR(200)                NOT NULL,
    STATUS                          VARCHAR(1)                  NOT NULL,
    CREATED_DT                      DATETIME                    NOT NULL,
    PRIMARY KEY TBL_MC_RESET_PWD_REQUEST (REQUEST_ID)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;

/*
-----------------------------------------------
-- TBL_MC_WEBSITE_SEARCH_SETTING
-----------------------------------------------
*/
CREATE TABLE `TBL_MC_WEBSITE_SEARCH_SETTING` (
    `WEBSITE_SEARCH_ID`             VARCHAR(32)                 NOT NULL,
    `WEBSITE_NAME`                  VARCHAR(50)                 NOT NULL,
    `WEBSITE_URL`                   VARCHAR(500)                NOT NULL,
    `DESCRIPTION`                   VARCHAR(255)                DEFAULT NULL,
    `STORE_ID`                      VARCHAR(50)                 NOT NULL,
    `WEBSITE_IMG`                   MEDIUMBLOB,
    PRIMARY KEY (`WEBSITE_SEARCH_ID`)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;

/*
-----------------------------------------------
-- Creation of TBL_MC_ACCOUNT_SOURCE
-----------------------------------------------
*/
CREATE TABLE TBL_MC_ACCOUNT_SOURCE (
    SOURCE_ID                       VARCHAR(32)                 NOT NULL,
    SOURCE_NAME                     VARCHAR(100)                NOT NULL,
    SOURCE_DESC                     VARCHAR(255),
    STATUS                          VARCHAR(1),
    CREATED_BY                      VARCHAR(32)                 NOT NULL,
    CREATED_DT                      DATETIME                    NOT NULL,
    UPDATED_BY                      VARCHAR(32)                 NOT NULL,
    UPDATED_DT                      DATETIME                    NOT NULL,
    VERSION                         INTEGER                     NOT NULL,
    PRIMARY KEY (SOURCE_ID)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;

/*
-----------------------------------------------
-- Creation of TBL_MC_CONTENT
-----------------------------------------------
*/
CREATE TABLE TBL_MC_CONTENT (
    CONTENT_ID                      VARCHAR(32)                 NOT NULL,
    TITLE                           VARCHAR(255)                NOT NULL,
    AUTHOR                          VARCHAR(255),
    PUBLISHER                       VARCHAR(255),
    ISBN                            VARCHAR(20),
    PUBLISHED_DT                    DATETIME,
    PUBLICATION_DT                  DATETIME,
    CONTENT_TYPE                    CHAR(5)                     NOT NULL,
    REVISION                        VARCHAR(20),
    FORMAT                          CHAR(1)                     NOT NULL,
    STATUS                          CHAR(3)                     NOT NULL,
    CONTENT_VIDEO_ID                VARCHAR(32), 
    DELETEDFLAG                     INT                         NOT NULL                        DEFAULT '1',
    DESTRUCTION_DT                  DATETIME,
    STORE_ID                        VARCHAR(32)                 NOT NULL,
    CREATED_BY                      VARCHAR(32)                 NOT NULL,
    CREATED_DT                      DATETIME                    NOT NULL,
    UPDATED_BY                      VARCHAR(32)                 NOT NULL,
    UPDATED_DT                      DATETIME                    NOT NULL,
    VERSION                         INTEGER                     NOT NULL,
    PRIMARY KEY PK_MC_CONTENT (CONTENT_ID)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;
create index index_1_tbl_mc_content on tbl_mc_content (content_id);

/*
-----------------------------------------------
-- Creation of TBL_MC_CONTENT2OU
-----------------------------------------------
*/
CREATE TABLE TBL_MC_CONTENT2OU (
    CONTENT_ID                      VARCHAR(32)                 NOT NULL,
    OU_ID                           VARCHAR(32)                 NOT NULL,
    CREATED_BY                      VARCHAR(32)                 NOT NULL,
    CREATED_DT                      DATETIME                    NOT NULL,
    UPDATED_BY                      VARCHAR(32)                 NOT NULL,
    UPDATED_DT                      DATETIME                    NOT NULL,
    VERSION                         INTEGER                     NOT NULL,
    PRIMARY KEY (CONTENT_ID, OU_ID),
    FOREIGN KEY FK_TBL_MC_CONTENT2OU_1 (OU_ID) REFERENCES TBL_MT_OU (OU_ID)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;

/*
-----------------------------------------------
-- Creation of TBL_MC_CONTENT_MEDIA
-----------------------------------------------
*/
CREATE TABLE TBL_MC_CONTENT_MEDIA (
    MEDIA_ID                        VARCHAR(32)                 NOT NULL,
    CONTENT_ID                      VARCHAR(32)                 NOT NULL,
    MEDIA_NAME                      VARCHAR(255)                NOT NULL,
    MEDIA_TYPE                      CHAR(2)                     NOT NULL,
    MEDIA_REL_PATH                  VARCHAR(255)                NOT NULL,
    VIDEO_CAPTURE_PATH              VARCHAR(255),
    CREATED_BY                      VARCHAR(32)                 NOT NULL,
    CREATED_DT                      DATETIME                    NOT NULL,
    UPDATED_BY                      VARCHAR(32)                 NOT NULL,
    UPDATED_DT                      DATETIME                    NOT NULL,
    VERSION                         INTEGER                     NOT NULL,
    PRIMARY KEY PK_MC_CONTENT_MEDIA (MEDIA_ID),
    FOREIGN KEY FK_MC_CONTENT_MEDIA_01 (CONTENT_ID) REFERENCES TBL_MC_CONTENT (CONTENT_ID) ON UPDATE RESTRICT ON DELETE RESTRICT
) ENGINE=INNODB DEFAULT CHARSET=UTF8;

/*
-----------------------------------------------
-- Creation of TBL_MC_CONTENT_PACKAGE
-----------------------------------------------
*/
CREATE TABLE TBL_MC_CONTENT_PACKAGE (
    CONTENT_ID                      VARCHAR(32)                 NOT NULL,
    TOC_ENABLED                     CHAR(1)                     NOT NULL,
    ROOT_PATH                       VARCHAR(255)                NOT NULL,
    CONTENT_REL_PATH                VARCHAR(255),
    FULL_CONTENT_REL_PATH           VARCHAR(255),
    IMAGE_REL_PATH                  VARCHAR(255),
    THUMBNAIL_REL_PATH              VARCHAR(255),
    TEXT_REL_PATH                   VARCHAR(255),
    COVERPAGE_REL_PATH              VARCHAR(255),
    PLIST_METADATA_REL_PATH         VARCHAR(255),
    MEDIA_REL_PATH                  VARCHAR(255),
    TIMEMAP_REL_PATH                VARCHAR(255), 
    HTML_REL_PATH                   VARCHAR(255),
    HTML_FILE_REL_PATH              VARCHAR(255),
    TEMP_HTML_FULL_PATH             VARCHAR(255),
    CSS_FILE_REL_PATH               VARCHAR(255), 
    TEMP_CSS_FULL_PATH              VARCHAR(255),
    PRIMARY KEY PK_MC_CONTENT_PACKAGE (CONTENT_ID),
    FOREIGN KEY FK_MC_CONTENT_PACKAGE_01 (CONTENT_ID) REFERENCES TBL_MC_CONTENT(CONTENT_ID)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;

/*
-----------------------------------------------
-- Creation of TBL_MC_CONTENT_PAGE
-----------------------------------------------
*/
CREATE TABLE TBL_MC_CONTENT_PAGE (
    CONTENT_PAGE_ID                 VARCHAR(32)                 NOT NULL,
    CONTENT_ID                      VARCHAR(32)                 NOT NULL,
    PAGE_CONTENT_REL_PATH           VARCHAR(255)                NOT NULL,
    PAGE_IMAGE_REL_PATH             VARCHAR(255)                NOT NULL,
    PAGE_THUMBNAIL_REL_PATH         VARCHAR(255)                NOT NULL,
    PAGE_TEXT_REL_PATH              VARCHAR(255)                NOT NULL,
    PAGE_HTML_REL_PATH              VARCHAR(255),
    PAGE_TYPE                       VARCHAR(255),
    CONTENT_PAGE_NO                 INTEGER                     NOT NULL,
    CONTENT_SUB_PAGE_NO             INTEGER                     NOT NULL,
    TIMEMAP_SECONDS                 INTEGER,
    CREATED_BY                      VARCHAR(32)                 NOT NULL,
    CREATED_DT                      DATETIME                    NOT NULL,
    UPDATED_BY                      VARCHAR(32)                 NOT NULL,
    UPDATED_DT                      DATETIME                    NOT NULL,
    VERSION                         INTEGER                     NOT NULL,
    PRIMARY KEY PK_MC_CONTENT_PAGE (CONTENT_ID, CONTENT_PAGE_ID),
    FOREIGN KEY FK_MC_CONTENT_PAGE_01 (CONTENT_ID) REFERENCES TBL_MC_CONTENT(CONTENT_ID)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;

/*
-----------------------------------------------
-- CREATION OF TBL_MC_CONTENT_PAGE2QUESTION
-----------------------------------------------
*/
CREATE TABLE TBL_MC_CONTENT_PAGE2QUESTION (
    CONTENT_PAGE_ID                 VARCHAR(32)                 NOT NULL,
    QUESTION_ID                     VARCHAR(32)                 NOT NULL,
    TEST_PAPER_ID                   VARCHAR(32)                 NOT NULL,
    CREATED_BY                      VARCHAR(32)                 NOT NULL,
    CREATED_DT                      DATETIME                    NOT NULL,
    UPDATED_BY                      VARCHAR(32)                 NOT NULL,
    UPDATED_DT                      DATETIME                    NOT NULL,
    VERSION                         INTEGER                     NOT NULL,
    PRIMARY KEY PK_MC_CONTENT_PAGE2QUESTION (CONTENT_PAGE_ID, QUESTION_ID)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;

/*
-----------------------------------------------
-- Creation of TBL_MC_CONTENT_TOC
-----------------------------------------------
*/
CREATE TABLE TBL_MC_CONTENT_TOC (
    CONTENT_TOC_ID                  VARCHAR(32)                 NOT NULL,
    CONTENT_ID                      VARCHAR(32)                 NOT NULL,
    HEADER                          VARCHAR(20),
    TITLE                           VARCHAR(255)                NOT NULL,
    TOC_TYPE                        CHAR(1)                     NOT NULL,
    PARENT_ID                       VARCHAR(32)                 NOT NULL,
    START_PAGE_ID                   VARCHAR(32)                 NOT NULL,
    CREATED_BY                      VARCHAR(32)                 NOT NULL,
    CREATED_DT                      DATETIME                    NOT NULL,
    UPDATED_BY                      VARCHAR(32)                 NOT NULL,
    UPDATED_DT                      DATETIME                    NOT NULL,
    VERSION                         INTEGER                     NOT NULL,
    PRIMARY KEY PK_MC_CONTENT_TOC (CONTENT_TOC_ID),
    FOREIGN KEY FK_MC_CONTENT_TOC_01 (CONTENT_ID) REFERENCES TBL_MC_CONTENT(CONTENT_ID),
    FOREIGN KEY FK_MC_CONTENT_TOC_02 (CONTENT_ID, START_PAGE_ID) REFERENCES TBL_MC_CONTENT_PAGE(CONTENT_ID, CONTENT_PAGE_ID)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;

/*
-----------------------------------------------
-- Creation of TBL_MC_CONTENT_REMARKS
-----------------------------------------------
*/
CREATE TABLE TBL_MC_CONTENT_REMARKS (
    REMARKS_ID                      VARCHAR(32)                 NOT NULL,
    CONTENT_ID                      VARCHAR(32)                 NOT NULL,
    REMARKS_TYPE                    CHAR(1)                     NOT NULL,
    REMARKS                         TEXT                        NOT NULL,
    CREATED_BY                      VARCHAR(32)                 NOT NULL,
    CREATED_DT                      DATETIME                    NOT NULL,
    UPDATED_BY                      VARCHAR(32)                 NOT NULL,
    UPDATED_DT                      DATETIME                    NOT NULL,
    VERSION                         INTEGER                     NOT NULL,
    PRIMARY KEY PK_MC_CONTENT_REMARKS (REMARKS_ID),
    FOREIGN KEY FK_MC_CONTENT_REMARKS_01 (CONTENT_ID) REFERENCES TBL_MC_CONTENT(CONTENT_ID)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;

/*
-----------------------------------------------
-- Creation of TBL_MC_CONTENT2ASSIGNMENT
-----------------------------------------------
*/
CREATE TABLE TBL_MC_CONTENT2ASSIGNMENT (
    ASSIGNMENT_ID                   VARCHAR(32)                 NOT NULL,
    CONTENT_ID                      VARCHAR(32)                 NOT NULL,
    DURATION                        INTEGER                     NOT NULL,
    EXAM_MODE                       INT(1)                      NOT NULL                        DEFAULT '0',
    MULTIPLE_ANSWER_SUBMISSION      INTEGER(1)                  DEFAULT 0,
    GET_MARKING_ANSWER              INTEGER(1)                  DEFAULT 0,
    CREATED_BY                      VARCHAR(32)                 NOT NULL,
    CREATED_DT                      DATETIME                    NOT NULL,
    UPDATED_BY                      VARCHAR(32)                 NOT NULL,
    UPDATED_DT                      DATETIME                    NOT NULL,
    VERSION                         INTEGER                     NOT NULL,
    PRIMARY KEY PK_MC_CONTENT2ASSIGNMENT (CONTENT_ID, ASSIGNMENT_ID)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;

/*
-----------------------------------------------
-- Creation of TBL_MC_CONTENT_METADATA
-----------------------------------------------
*/
CREATE TABLE TBL_MC_CONTENT_METADATA (
    METADATA_ID                     VARCHAR(32)                 NOT NULL,
    CONTENT_ID                      VARCHAR(32)                 NOT NULL,
    META_DATA_NAME                  VARCHAR(255)                NOT NULL,
    CREATED_DT                      DATE,
    CREATED_BY                      VARCHAR(32),
    UPDATED_BY                      VARCHAR(32),
    UPDATED_DT                      DATE,
    VERSION                         INT,
    PRIMARY KEY (METADATA_ID)
) ENGINE = InnoDB ROW_FORMAT = DEFAULT;

/*
-----------------------------------------------
-- Creation of TBL_MC_CONTENT_ATTACHMENT
-----------------------------------------------
*/
CREATE TABLE TBL_MC_CONTENT_ATTACHMENT (
    ATTACHMENT_ID                   VARCHAR(32)                 NOT NULL,
    HOTSPOT_ID                      VARCHAR(32)                 NOT NULL,
    CONTENT_ID                      VARCHAR(32)                 NOT NULL,
    ATTACHMENT_NAME                 VARCHAR(255)                NOT NULL,
    ATTACHMENT_TYPE                 CHAR(2)                     NOT NULL,
    ATTACHMENT_REL_PATH             VARCHAR(255)                NOT NULL,
    SYNOPSIS                        TEXT,
    CREATED_BY                      VARCHAR(32)                 NOT NULL,
    CREATED_DT                      DATETIME                    NOT NULL,
    UPDATED_BY                      VARCHAR(32)                 NOT NULL,
    UPDATED_DT                      DATETIME                    NOT NULL,
    VERSION                         INTEGER                     NOT NULL,
    PRIMARY KEY PK_MC_CONTENT_ATTACHMENT (ATTACHMENT_ID)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;

/*
-----------------------------------------------
-- Creation of TBL_MC_PUBLICATION
-----------------------------------------------
*/
CREATE TABLE TBL_MC_PUBLICATION (
    PUBLICATION_ID                  VARCHAR(32)                 NOT NULL,
    REVISION                        INTEGER                     NOT NULL,
    PUBLICATION_NAME                VARCHAR(255)                NOT NULL,
    STORE_ID                        VARCHAR(32)                 NOT NULL,
    CONTENT_ID                      VARCHAR(32)                 NOT NULL,
    AVAILABLE_DT                    DATETIME                    NOT NULL,
    CREATED_BY                      VARCHAR(32)                 NOT NULL,
    CREATED_DT                      DATETIME                    NOT NULL,
    UPDATED_BY                      VARCHAR(32)                 NOT NULL,
    UPDATED_DT                      DATETIME                    NOT NULL,
    VERSION                         INTEGER                     NOT NULL,
    PRIMARY KEY PK_MC_PUBLICATION (PUBLICATION_ID, REVISION),
    FOREIGN KEY FK_MC_PUBLICATION_01 (CONTENT_ID) REFERENCES TBL_MC_CONTENT (CONTENT_ID)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;
create index index_1_tbl_mc_publication on tbl_mc_publication (content_id);
create index index_2_tbl_mc_publication on tbl_mc_publication (publication_id);
create index index_3_tbl_mc_publication on tbl_mc_publication (store_id);

/*
-----------------------------------------------
-- Creation of TBL_MC_PUBLICATION2OU
-----------------------------------------------
*/
CREATE TABLE TBL_MC_PUBLICATION2OU (
    PUBLICATION_ID                  VARCHAR(32)                 NOT NULL,
    REVISION                        INTEGER                     NOT NULL,
    OU_ID                           VARCHAR(32)                 NOT NULL,
    CREATED_BY                      VARCHAR(32)                 NOT NULL,
    CREATED_DT                      DATETIME                    NOT NULL,
    UPDATED_BY                      VARCHAR(32)                 NOT NULL,
    UPDATED_DT                      DATETIME                    NOT NULL,
    VERSION                         INTEGER                     NOT NULL,
    PRIMARY KEY (PUBLICATION_ID, REVISION, OU_ID),
    FOREIGN KEY FK_TBL_MC_PUBLICATION2OU_1 (OU_ID) REFERENCES TBL_MT_OU (OU_ID)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;

/*
-----------------------------------------------
-- Creation of TBL_MC_PUBLICATION2CATEGORY
-----------------------------------------------
*/
CREATE TABLE TBL_MC_PUBLICATION2CATEGORY (
    PUBLICATION_ID                  VARCHAR(32)                 NOT NULL,
    CATEGORY_ID                     VARCHAR(32)                 NOT NULL,
    CREATED_BY                      VARCHAR(32)                 NOT NULL,
    CREATED_DT                      DATETIME                    NOT NULL,
    PRIMARY KEY PK_MC_TBL_MC_PUBLICATION2CATEGORY (PUBLICATION_ID, CATEGORY_ID),
    FOREIGN KEY FK_MC_TBL_MC_PUBLICATION2CATEGORY_01 (PUBLICATION_ID) REFERENCES TBL_MC_PUBLICATION(PUBLICATION_ID),
    FOREIGN KEY FK_MC_TBL_MC_PUBLICATION2CATEGORY_02 (CATEGORY_ID) REFERENCES TBL_MC_CATEGORY(CATEGORY_ID)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;

/*
-----------------------------------------------
-- Creation of TBL_MC_PUBLICATION2OFFER
-----------------------------------------------
*/
CREATE TABLE TBL_MC_PUBLICATION2OFFER (
    PUBLICATION_ID                  VARCHAR(32)                 NOT NULL,
    OFFER_CODE                      VARCHAR(100)                NOT NULL,
    OFFER_EFFECTIVE_DT              DATETIME,
    OFFER_EXPIRY_DT                 DATETIME,
    VIEW_EFFECTIVE_DT               DATETIME,
    VIEW_EXPIRY_DT                  DATETIME,
    CREATED_BY                      VARCHAR(32)                 NOT NULL,
    CREATED_DT                      DATETIME                    NOT NULL,
    UPDATED_BY                      VARCHAR(32)                 NOT NULL,
    UPDATED_DT                      DATETIME                    NOT NULL,
    VERSION                         INTEGER                     NOT NULL,
    PRIMARY KEY PK_MC_PUBLICATION2OFFER (PUBLICATION_ID, OFFER_CODE),
    FOREIGN KEY FK_MC_PUBLICATION2OFFER_01 (PUBLICATION_ID) REFERENCES TBL_MC_PUBLICATION(PUBLICATION_ID),
    INDEX IDX_MC_PUBLICATION2OFFER_01 (OFFER_CODE)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;

/*
-----------------------------------------------
-- Creation of TBL_MC_PUBLICATION_RATING
-----------------------------------------------
*/
CREATE TABLE TBL_MC_PUBLICATION_RATING (
    RATING_ID                       VARCHAR(32)                 NOT NULL,
    PUBLICATION_ID                  VARCHAR(32)                 NOT NULL,
    REVISION                        INTEGER                     NOT NULL,
    RATED_BY                        VARCHAR(32)                 NOT NULL,
    RATED_DT                        DATETIME                    NOT NULL,
    RATING                          INTEGER                     NOT NULL,
    HAS_REVIEW                      CHAR(1)                     NOT NULL,
    TITLE                           VARCHAR(100),
    COMMENTS                        TEXT,
    PRIMARY KEY PK_MC_PUBLICATION_RATING (RATING_ID)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;
CREATE INDEX INDEX_1_TBL_MC_PUBLICATION_RATING ON TBL_MC_PUBLICATION_RATING (PUBLICATION_ID);
CREATE INDEX INDEX_2_TBL_MC_PUBLICATION_RATING ON TBL_MC_PUBLICATION_RATING (HAS_REVIEW);

/*
-----------------------------------------------
-- Creation of TBL_MC_DEVICE2PUBLICATION
-----------------------------------------------
*/
CREATE TABLE TBL_MC_DEVICE2PUBLICATION (
    DEVICE_ID                       VARCHAR(32)                 NOT NULL,
    PUBLICATION_ID                  VARCHAR(32)                 NOT NULL,
    REVISION                        INTEGER                     NOT NULL,
    CREATED_BY                      VARCHAR(32)                 NOT NULL,
    CREATED_DT                      DATETIME                    NOT NULL,
    PRIMARY KEY PK_MC_DEVICE2PUBLICATION (DEVICE_ID, PUBLICATION_ID, REVISION)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;

/*
-----------------------------------------------
-- TBL_MC_PUBLICATION_PREVIEW
-----------------------------------------------
*/
CREATE TABLE `TBL_MC_PUBLICATION_PREVIEW` (
    `PREVIEW_ID`                    VARCHAR(32)                 NOT NULL,
    `PUBLICATION_ID`                VARCHAR(32)                 NOT NULL,
    `REVISION`                      INT(11)                     NOT NULL,
    `START_DT`                      DATETIME,
    `END_DT`                        DATETIME,
    `CREATED_BY`                    VARCHAR(32)                 NOT NULL,
    `CREATED_DT`                    DATETIME                    NOT NULL,
    `UPDATED_BY`                    VARCHAR(32)                 NOT NULL,
    `UPDATED_DT`                    DATETIME                    NOT NULL,
    `VERSION`                       INT(11)                     NOT NULL,
    PRIMARY KEY (`PREVIEW_ID`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

/*
-----------------------------------------------
-- TBL_MC_PUBLICATION_PREVIEW_OU
-----------------------------------------------
*/
CREATE TABLE `TBL_MC_PUBLICATION_PREVIEW_OU` (
    `PREVIEW_ID`                    VARCHAR(32)                 NOT NULL,
    `OU_ID`                         VARCHAR(32)                 NOT NULL,
    `CREATED_BY`                    VARCHAR(32)                 NOT NULL,
    `CREATED_DT`                    DATETIME                    NOT NULL,
    `UPDATED_BY`                    VARCHAR(32)                 NOT NULL,
    `UPDATED_DT`                    DATETIME                    NOT NULL,
    `VERSION`                       INT(11)                     NOT NULL,
    PRIMARY KEY (`PREVIEW_ID`, `OU_ID`),
    FOREIGN KEY FK_TBL_MC_PUBLICATION_PREVIEW_OU_01 (PREVIEW_ID) REFERENCES TBL_MC_PUBLICATION_PREVIEW (PREVIEW_ID) ON UPDATE RESTRICT ON DELETE CASCADE,
    FOREIGN KEY FK_TBL_MC_PUBLICATION_PREVIEW_OU_02 (OU_ID) REFERENCES TBL_MT_OU (OU_ID)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

/*
-----------------------------------------------
-- Creation of TBL_MT_USER
-----------------------------------------------
*/
CREATE TABLE TBL_MT_USER (
    USER_ID                         VARCHAR(32)                 NOT NULL,
    SUBJECT_ID                      VARCHAR(32)                 NOT NULL,
    PHOTO                           MEDIUMBLOB,
    ACCOUNT_FROM                    INT,
    SESSION_KEY                     varchar(32),
    DEFAULT_AD_SERVER               varchar(32),
    CREATED_BY                      VARCHAR(32)                 NOT NULL,
    CREATED_DT                      DATETIME                    NOT NULL,
    UPDATED_BY                      VARCHAR(32)                 NOT NULL,
    UPDATED_DT                      DATETIME                    NOT NULL,
    VERSION                         INTEGER                     NOT NULL,
    PRIMARY KEY (USER_ID)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;
create index index_1_tbl_mt_user on TBL_Mt_USER (user_id);
create index index_2_tbl_mt_user on TBL_Mt_USER (subject_id);

/*
-----------------------------------------------
-- Creation of TBL_MT_USER2TENANT
-----------------------------------------------
*/
CREATE TABLE TBL_MT_USER2TENANT(
    USER_ID                         VARCHAR(32)                 NOT NULL,
    TENANT_ID                       VARCHAR(32)                 NOT NULL,
    CREATED_BY                      VARCHAR(32)                 NOT NULL,
    CREATED_DT                      DATETIME                    NOT NULL,
    PRIMARY KEY (USER_ID, TENANT_ID)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;
create index index_1_tbl_mt_user2tenant on tbl_mt_user2tenant (user_id);
create index index_2_tbl_mt_user2tenant on tbl_mt_user2tenant (tenant_id);

/*
-----------------------------------------------
-- Creation of TBL_MT_USER2OU
-----------------------------------------------
*/
CREATE TABLE TBL_MT_USER2OU
(
    USER_ID                         VARCHAR(32)                 NOT NULL,
    OU_ID                           VARCHAR(32)                 NOT NULL,
    CREATED_BY                      VARCHAR(32)                 NOT NULL,
    CREATED_DT                      DATETIME                    NOT NULL,
    PRIMARY KEY (USER_ID, OU_ID),
    FOREIGN KEY FK_TBL_MT_PUBLICATION2OU_1 (OU_ID) REFERENCES TBL_MT_OU (OU_ID)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;

/*
-----------------------------------------------
-- Creation of TBL_MC_USER2MGROUP
-----------------------------------------------
*/
CREATE TABLE IF NOT EXISTS TBL_MC_USER2MGROUP (
    USER_ID                         VARCHAR(32)                 NOT NULL,
    MGROUP_ID                       VARCHAR(32)                 NOT NULL,
    PRIMARY KEY (USER_ID, MGROUP_ID)
) ENGINE = InnoDB ROW_FORMAT = DEFAULT CHARSET=UTF8;

/*
-----------------------------------------------
-- Creation of TBL_MC_USER2PROFILE
-----------------------------------------------
*/
CREATE TABLE TBL_MC_USER2PROFILE (
    SUBJECT_ID                      VARCHAR(32)                 NOT NULL,
    PROFILE_FILE_ID                 VARCHAR(32)                 NOT NULL,
    CREATED_DT                      DATE,
    CREATED_BY                      VARCHAR(32),
    UPDATED_DT                      DATE,
    UPDATED_BY                      VARCHAR(32),
    VERSION                         INT(10),
    PRIMARY KEY (SUBJECT_ID, PROFILE_FILE_ID)
) ENGINE = InnoDB ROW_FORMAT = DEFAULT CHARACTER SET utf8;

/*
-----------------------------------------------
-- Creation of TBL_MT_USER_DEVICE
-----------------------------------------------
*/
CREATE TABLE TBL_MT_USER_DEVICE (
    DEVICE_ID                       VARCHAR(32)                 NOT NULL,
    USER_ID                         VARCHAR(32)                 NOT NULL,
    DEVICE_TYPE                     CHAR(1)                     NOT NULL,
    DEVICE_TOKEN                    VARCHAR(100)                NOT NULL,
    TENANT_ID                       VARCHAR(32)                 NOT NULL,
    REGISTER_DT                     DATETIME                    NOT NULL,
    STATUS                          CHAR(1)                     NOT NULL,
    CREATED_BY                      VARCHAR(32)                 NOT NULL,
    CREATED_DT                      DATETIME                    NOT NULL,
    UPDATED_BY                      VARCHAR(32)                 NOT NULL,
    UPDATED_DT                      DATETIME                    NOT NULL,
    VERSION                         INTEGER                     NOT NULL
) ENGINE = InnoDB ROW_FORMAT = DEFAULT CHARACTER SET utf8;
ALTER TABLE TBL_MT_USER_DEVICE ADD CONSTRAINT PK_MT_USER_DEVICE  PRIMARY KEY (DEVICE_ID);

/*
-----------------------------------------------
-- Creation of TBL_MT_USER_NOTIFICATION
-----------------------------------------------
*/
CREATE TABLE TBL_MT_USER_NOTIFICATION (
    NOTIFICATION_ID                 VARCHAR(32)                 NOT NULL,
    USER_ID                         VARCHAR(32)                 NOT NULL,
    DEVICE_ID                       VARCHAR(32)                 NULL,
    MESSAGE_TYPE                    CHAR(4)                     NOT NULL,
    MESSAGE_CODE                    VARCHAR(20)                 NULL,
    MESSAGE_TITLE                   VARCHAR(100)                NULL,
    MESSAGE_BODY                    VARCHAR(1000)               NULL,
    STATUS                          CHAR(1)                     NULL,
    DELETE_FLAG                     CHAR(1)                     NULL,
    SENT_DT                         DATETIME                    NULL,
    CREATED_BY                      VARCHAR(32)                 NOT NULL,
    CREATED_DT                      DATETIME                    NOT NULL,
    UPDATED_BY                      VARCHAR(32)                 NOT NULL,
    UPDATED_DT                      DATETIME                    NOT NULL,
    VERSION                         INTEGER                     NOT NULL
) ENGINE = InnoDB ROW_FORMAT = DEFAULT CHARACTER SET utf8;
ALTER TABLE TBL_MT_USER_NOTIFICATION ADD CONSTRAINT PK_MT_USER_NOTIFICATION  PRIMARY KEY (NOTIFICATION_ID);

/*
-----------------------------------------------
-- Creation of TBL_MT_USER_NOTIFICATION_PARAM
-----------------------------------------------
*/
CREATE TABLE TBL_MT_USER_NOTIFICATION_PARAM (
    NOTIFICATION_ID                 VARCHAR(32)                 NOT NULL,
    PARAM_KEY                       VARCHAR(50)                 NOT NULL,
    PARAM_VALUE                     VARCHAR(100)                NOT NULL
) ENGINE = InnoDB ROW_FORMAT = DEFAULT CHARACTER SET utf8;
ALTER TABLE TBL_MT_USER_NOTIFICATION_PARAM ADD CONSTRAINT PK_MT_USER_NOTIFICATION_PARAM  PRIMARY KEY (NOTIFICATION_ID, PARAM_KEY);

/*
-----------------------------------------------
-- Creation of TBL_MT_AUTH_PROTOCOL
-----------------------------------------------
*/
CREATE TABLE TBL_MT_AUTH_PROTOCOL (
    PROTOCOL_ID                     VARCHAR(32)                 NOT NULL,
    PROTOCOL_NAME                   VARCHAR(100)                NOT NULL,
    PROTOCOL_DESC                   VARCHAR(255),
    PROTOCOL_TYPE                   VARCHAR(100),
    URL                             VARCHAR(32),
    DN                              varchar(500),
    PRINCIPAL                       VARCHAR(100),
    CREATED_BY                      VARCHAR(32)                 NOT NULL,
    CREATED_DT                      DATETIME                    NOT NULL,
    UPDATED_BY                      VARCHAR(32)                 NOT NULL,
    UPDATED_DT                      DATETIME                    NOT NULL,
    VERSION                         INTEGER                     NOT NULL,
    PRIMARY KEY (PROTOCOL_ID)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;

/*
-----------------------------------------------
-- Creation of TBL_MT_TENANT_PROTOCOL
-----------------------------------------------
*/
CREATE TABLE TBL_MT_TENANT_PROTOCOL (
    TENANT_ID                       VARCHAR(32)                 NOT NULL,
    PROTOCOL_ID                     VARCHAR(32)                 NOT NULL,
    CREATE_USER                     CHAR(1)                     NOT NULL                        DEFAULT 'N',
    UPDATE_USER                     CHAR(1)                     NOT NULL                        DEFAULT 'N',
    CREATED_BY                      VARCHAR(32)                 NOT NULL,
    CREATED_DT                      DATETIME                    NOT NULL,
    UPDATED_BY                      VARCHAR(32)                 NOT NULL,
    UPDATED_DT                      DATETIME                    NOT NULL,
    VERSION                         INTEGER                     NOT NULL,
    PRIMARY KEY (TENANT_ID, PROTOCOL_ID)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;

/*
-----------------------------------------------
-- Creation of TBL_MT_AUTH_USER_CACHE
-----------------------------------------------
*/
CREATE TABLE TBL_MT_AUTH_CACHE (
    LOGIN_NAME                      VARCHAR(100)                 NOT NULL,
    TENANT_ID                       VARCHAR(32)                 NOT NULL,
    SESSION_KEY                     VARCHAR(32)                 NOT NULL,
    EXPIRY_DT                       DATETIME                    NOT NULL,
    PRIMARY KEY (LOGIN_NAME, TENANT_ID)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;

/*
-----------------------------------------------
-- Creation of TBL_MT_PUB_CONTACTS
-----------------------------------------------
*/
CREATE TABLE TBL_MT_PUB_CONTACTS (
    PUB_CONTACT_ID                  VARCHAR(32)                 NOT NULL,
    PUB_ID                          VARCHAR(32)                 NOT NULL,
    FULL_NAME                       VARCHAR(100)                NOT NULL,
    DESIGNATION                     VARCHAR(100)                NOT NULL,
    EMAIL                           VARCHAR(100)                NOT NULL,
    CONTACT_NO                      VARCHAR(32)                 NOT NULL,
    FAX_NO                          VARCHAR(32)                 DEFAULT NULL,
    CONTACT_TYPE                    int(11)                     NOT NULL,
    CREATED_BY                      VARCHAR(32)                 NOT NULL,
    CREATED_DT                      DATETIME                    NOT NULL,
    UPDATED_BY                      VARCHAR(32)                 NOT NULL,
    UPDATED_DT                      DATETIME                    NOT NULL,
    VERSION                         int(11)                     NOT NULL,
    PRIMARY KEY (PUB_CONTACT_ID)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;

/*
-----------------------------------------------
-- Creation of TBL_MT_PUBLISHER
-----------------------------------------------
*/
CREATE TABLE TBL_MT_PUBLISHER (
    PUB_ID                          VARCHAR(32)                 NOT NULL,
    OU_ID                           VARCHAR(32)                 NOT NULL,
    CO_NAME                         VARCHAR(100)                NOT NULL,
    CO_ADDRESS                      VARCHAR(255)                DEFAULT NULL,
    CO_DEPT                         VARCHAR(100)                DEFAULT NULL,
    CO_REGNO                        VARCHAR(50)                 NOT NULL,
    REV_SHARE_ST                    int(23)                     NOT NULL,
    REV_SHARE_CP                    int(23)                     NOT NULL,
    REV_SHARE_DT                    DATETIME                    NOT NULL,
    REMARKS                         VARCHAR(255)                NOT NULL,
    CREATED_BY                      VARCHAR(32)                 NOT NULL,
    CREATED_DT                      DATETIME                    NOT NULL,
    UPDATED_BY                      VARCHAR(32)                 NOT NULL,
    UPDATED_DT                      DATETIME                    NOT NULL,
    VERSION                         int(11)                     NOT NULL,
    PRIMARY KEY (PUB_ID)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;

/*
-----------------------------------------------
-- Creation of TBL_MT_PUB_BANK_DTL
-----------------------------------------------
*/
CREATE TABLE TBL_MT_PUB_BANK_DTL (
    PUB_BANK_DTL_ID                 VARCHAR(32)                 NOT NULL,
    PUB_ID                          VARCHAR(32)                 NOT NULL,
    BANK_NAME                       VARCHAR(255)                NOT NULL,
    BANK_COUNTRY                    CHAR(2)                     CHARACTER SET LATIN1            NOT NULL,
    BANK_CITY                       VARCHAR(100)                NOT NULL,
    ADDRESS_UNIT                    VARCHAR(10)                 NOT NULL,
    ADDRESS_STREET                  VARCHAR(50)                 NOT NULL,
    ADDRESS_STATE                   VARCHAR(50)                 NOT NULL,
    ADDRESS_POSTAL                  VARCHAR(10)                 NOT NULL,
    ACCOUNT_NO                      VARCHAR(32)                 NOT NULL,
    ACCOUNT_NAME                    VARCHAR(100)                NOT NULL,
    CURRENCY_TYPE                   CHAR(3)                     CHARACTER SET LATIN1            NOT NULL,
    BRANCH_NAME                     VARCHAR(100)                DEFAULT NULL,
    BRANCH_CODE                     VARCHAR(32)                 DEFAULT NULL,
    REFERENCE_CODE                  VARCHAR(32)                 DEFAULT NULL,
    SWIFT_CODE                      VARCHAR(32)                 DEFAULT NULL,
    RESIDENT_STATUS                 CHAR(1)                     CHARACTER SET LATIN1            DEFAULT NULL,
    CITIZEN_STATUS                  CHAR(1)                     CHARACTER SET LATIN1            DEFAULT NULL,
    CREATED_BY                      VARCHAR(32)                 NOT NULL,
    CREATED_DT                      DATETIME                    NOT NULL,
    UPDATED_BY                      VARCHAR(32)                 NOT NULL,
    UPDATED_DT                      DATETIME                    NOT NULL,
    VERSION                         int(11)                     NOT NULL,
    PRIMARY KEY (PUB_BANK_DTL_ID)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;

/*
-----------------------------------------------
-- Creation of TBL_MC_LATEST_PUBLICATION
-----------------------------------------------
*/
DELIMITER $$

DROP VIEW IF EXISTS `TBL_MC_LATEST_PUBLICATION`$$

CREATE SQL SECURITY DEFINER VIEW `TBL_MC_LATEST_PUBLICATION` AS 
SELECT
    A.PUBLICATION_ID                AS PUBLICATION_ID,
    A.REVISION                      AS REVISION,
    A.PUBLICATION_NAME              AS PUBLICATION_NAME,
    A.CONTENT_ID                    AS CONTENT_ID,
    A.CREATED_BY                    AS CREATED_BY,
    A.CREATED_DT                    AS CREATED_DT,
    A.UPDATED_BY                    AS UPDATED_BY,
    A.UPDATED_DT                    AS UPDATED_DT,
    A.VERSION                       AS VERSION,
    A.STORE_ID                      AS STORE_ID,
    A.AVAILABLE_DT                  AS AVAILABLE_DT
FROM 
    TBL_MC_PUBLICATION A
WHERE 
    (A.PUBLICATION_ID, A.REVISION) IN 
        (SELECT 
            B.PUBLICATION_ID, MAX(B.REVISION) AS REVISION
        FROM 
            TBL_MC_PUBLICATION B, TBL_MC_CONTENT C
        WHERE
            B.CONTENT_ID = C.CONTENT_ID AND
            (C.STATUS = 'P' OR C.STATUS = 'W')
        GROUP BY 
            B.PUBLICATION_ID
    )$$

DELIMITER ;

/*
-----------------------------------------------
-- Creation of TBL_MC_ANNOTATION
-----------------------------------------------
*/
CREATE TABLE TBL_MC_ANNOTATION (
    ANNOTATION_ID                   VARCHAR(32)                 NOT NULL,
    PUBLICATION_ID                  VARCHAR(32)                 NOT NULL,
    REVISION                        INTEGER                     NOT NULL,
    CONTENT_PAGE_ID                 VARCHAR(32),
    HYPERLINK_URL                   VARCHAR(200),
    TITLE                           VARCHAR(200)                NOT NULL,
    COMMENTS                        TEXT                        NOT NULL,
    FOLDER_REL_PATH                 VARCHAR(255)                NOT NULL,
    IMAGE_REL_PATH                  VARCHAR(255)                NOT NULL,
    AUDIO_REL_PATH                  VARCHAR(255),
    OWNER_ID                        VARCHAR(32)                 NOT NULL,
    CREATED_BY                      VARCHAR(32)                 NOT NULL,
    CREATED_DT                      DATETIME                    NOT NULL,
    UPDATED_BY                      VARCHAR(32)                 NOT NULL,
    UPDATED_DT                      DATETIME                    NOT NULL,
    VERSION                         INTEGER                     NOT NULL,
    PRIMARY KEY PK_MC_ANNOTATION (ANNOTATION_ID),
    FOREIGN KEY FK_MC_ANNOTATION_01 (PUBLICATION_ID, REVISION) REFERENCES TBL_MC_PUBLICATION(PUBLICATION_ID, REVISION),
    FOREIGN KEY FK_MC_ANNOTATION_02 (OWNER_ID) REFERENCES TBL_MT_USER(USER_ID)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;
CREATE INDEX INDEX_1_TBL_MC_ANNOTATION ON TBL_MC_ANNOTATION (PUBLICATION_ID);
CREATE INDEX INDEX_2_TBL_MC_ANNOTATION ON TBL_MC_ANNOTATION (OWNER_ID);

/*
-----------------------------------------------
-- Creation of TBL_MC_ANNOTATION_PACKAGE
-----------------------------------------------
*/
CREATE TABLE TBL_MC_ANNOTATION_PACKAGE (
    ANNOTATION_PKG_ID               VARCHAR(32)                 NOT NULL,
    ANNOTATION_PKG_REVISION         INTEGER                     NOT NULL,
    PUBLICATION_ID                  VARCHAR(32)                 NOT NULL,
    REVISION                        INTEGER                     NOT NULL,
    TITLE                           VARCHAR(200)                NOT NULL,
    COMMENTS                        VARCHAR(255)                NOT NULL,
    ANNOTATION_PACKAGE_REL_PATH     VARCHAR(255)                NOT NULL,
    OWNER_ID                        VARCHAR(32)                 NOT NULL,
    CREATED_BY                      VARCHAR(32)                 NOT NULL,
    CREATED_DT                      DATETIME                    NOT NULL,
    UPDATED_BY                      VARCHAR(32)                 NOT NULL,
    UPDATED_DT                      DATETIME                    NOT NULL,
    VERSION                         INTEGER                     NOT NULL,
    PRIMARY KEY PK_MC_ANNOTATION_PACKAGE (ANNOTATION_PKG_ID, ANNOTATION_PKG_REVISION),
    FOREIGN KEY FK_MC_ANNOTATION_PACKAGE_01 (PUBLICATION_ID, REVISION) REFERENCES TBL_MC_PUBLICATION(PUBLICATION_ID, REVISION),
    FOREIGN KEY FK_MC_ANNOTATION_PACKAGE_02 (OWNER_ID) REFERENCES TBL_MT_USER(USER_ID)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;
CREATE INDEX INDEX_1_TBL_MC_ANNOTATION_PACKAGE ON TBL_MC_ANNOTATION_PACKAGE (REVISION);
CREATE INDEX INDEX_2_TBL_MC_ANNOTATION_PACKAGE ON TBL_MC_ANNOTATION_PACKAGE (PUBLICATION_ID);

/*
-----------------------------------------------
-- TBL_MC_ANNOTATION_PACKAGE2OU
-----------------------------------------------
*/
CREATE TABLE TBL_MC_ANNOTATION_PACKAGE2OU
(
    ANNOTATION_PKG_ID               VARCHAR(32)                 NOT NULL,
    ANNOTATION_PKG_REVISION         INT(11)                     NOT NULL,
    OU_ID                           VARCHAR(32)                 NOT NULL,
    CREATED_BY                      VARCHAR(32)                 NOT NULL,
    CREATED_DT                      DATETIME                    NOT NULL,
    UPDATED_BY                      VARCHAR(32)                 NOT NULL,
    UPDATED_DT                      DATETIME                    NOT NULL,
    VERSION                         INTEGER                     NOT NULL,
    PRIMARY KEY (ANNOTATION_PKG_ID, ANNOTATION_PKG_REVISION, OU_ID),
    FOREIGN KEY FK_TBL_MC_ANNOTATION_PACKAGE2OU_1 (OU_ID) REFERENCES TBL_MT_OU (OU_ID)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;

/*
-----------------------------------------------
-- Creation of TBL_MC_ANNOTATION_COMMENT
-----------------------------------------------
*/
CREATE TABLE TBL_MC_ANNOTATION_COMMENT (
    COMMENT_ID                      VARCHAR(32)                 NOT NULL,
    ANNOTATION_ID                   VARCHAR(32)                 NOT NULL,
    COMMENTS                        TEXT                        NOT NULL,
    OWNER_ID                        VARCHAR(32)                 NOT NULL,
    CREATED_DT                      DATETIME                    NOT NULL,
    PRIMARY KEY PK_MC_ANNOTATION_COMMENT (COMMENT_ID),
    FOREIGN KEY FK_MC_ANNOTATION_COMMENT_01 (ANNOTATION_ID) REFERENCES TBL_MC_ANNOTATION(ANNOTATION_ID)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;

/*
-----------------------------------------------
-- TBL_MC_ANNOTATION_LIKE
-----------------------------------------------
*/
CREATE TABLE TBL_MC_ANNOTATION_LIKE (
    ANNOTATION_ID                   VARCHAR(32)                 NOT NULL,
    ANNOTATION_TYPE                 VARCHAR(1)                  NOT NULL,
    SUBJECT_ID                      VARCHAR(32)                 NOT NULL,
    CREATED_BY                      VARCHAR(32),
    CREATED_DT                      DATETIME,
    UPDATED_BY                      VARCHAR(32),
    UPDATED_DT                      DATETIME,
    VERSION                         INTEGER,
    PRIMARY KEY (ANNOTATION_ID, ANNOTATION_TYPE, SUBJECT_ID)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;

/*
-----------------------------------------------
-- Creation of TBL_MC_CLOUD_ANNOTATION
-----------------------------------------------
*/
CREATE TABLE TBL_MC_CLOUD_ANNOTATION (
    ANNOTATION_ID                   VARCHAR(32)                 NOT NULL,
    PACKAGE_ID                      VARCHAR(32)                 NOT NULL,
    BOOK_ID                         VARCHAR(32)                 NOT NULL,
    STATUS                          VARCHAR(1)                  NOT NULL,
    FILE_PATH                       VARCHAR(255)                NOT NULL,
    CREATED_BY                      VARCHAR(32)                 NOT NULL,
    CREATED_DT                      DATETIME                    NOT NULL,
    UPDATED_BY                      VARCHAR(32)                 NOT NULL,
    UPDATED_DT                      DATETIME                    NOT NULL,
    VERSION                         INTEGER                     NOT NULL,
    PRIMARY KEY (ANNOTATION_ID)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

/*
-----------------------------------------------
-- Creation of TBL_MC_CLOUD_ANNOTATION_PACKAGE
-----------------------------------------------
*/
CREATE TABLE TBL_MC_CLOUD_ANNOTATION_PACKAGE (
    PACKAGE_ID                      VARCHAR(32)                 NOT NULL,
    TENANT_ID                       VARCHAR(32)                 NOT NULL,
    USER_ID                         VARCHAR(32)                 NOT NULL,
    CREATED_BY                      VARCHAR(32)                 NOT NULL,
    CREATED_DT                      DATETIME                    NOT NULL,
    UPDATED_BY                      VARCHAR(32)                 NOT NULL,
    UPDATED_DT                      DATETIME                    NOT NULL,
    VERSION                         INTEGER                     NOT NULL,
    PRIMARY KEY (PACKAGE_ID)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

/*
-----------------------------------------------
-- Creation of TBL_MC_USER_ANNOTATION_QUOTA
-----------------------------------------------
*/
CREATE TABLE TBL_MC_USER_ANNOTATION_QUOTA (
    SUBJECT_ID                      VARCHAR(32)                 NOT NULL,
    UPLOADED_SIZE                   VARCHAR(10),
    QUOTA_SIZE                      VARCHAR(10),
    CREATED_BY                      VARCHAR(32),
    CREATED_DT                      DATE,
    UPDATED_BY                      VARCHAR(32),
    UPDATED_DT                      DATE,
    VERSION                         INT(10),
    PRIMARY KEY (SUBJECT_ID)
) ENGINE = InnoDB ROW_FORMAT = DEFAULT CHARACTER SET utf8;

/*
-----------------------------------------------
-- Creation of TBL_MC_HOTSPOT
-----------------------------------------------
*/
CREATE TABLE TBL_MC_HOTSPOT (
    HOTSPOT_ID                      VARCHAR(32)                 NOT NULL,
    CONTENT_ID                      VARCHAR(32)                 NOT NULL,
    CONTENT_PAGE_ID                 VARCHAR(32)                 NOT NULL,
    NAME                            VARCHAR(200)                NOT NULL,
    TYPE                            CHAR(2)                     NOT NULL,
    POINT_X                         INTEGER                     NOT NULL,
    POINT_Y                         INTEGER                     NOT NULL,
    WIDTH                           INTEGER                     NOT NULL,
    HEIGHT                          INTEGER                     NOT NULL,
    DISPLAY                         CHAR(1)                     NOT NULL                        DEFAULT 'N',
    CREATED_BY                      VARCHAR(32)                 NOT NULL,
    CREATED_DT                      DATETIME                    NOT NULL,
    UPDATED_BY                      VARCHAR(32)                 NOT NULL,
    UPDATED_DT                      DATETIME                    NOT NULL,
    VERSION                         INTEGER                     NOT NULL,
    PRIMARY KEY PK_MC_HOTSPOT (HOTSPOT_ID),
    FOREIGN KEY FK_MC_HOTSPOT_01 (CONTENT_ID, CONTENT_PAGE_ID) REFERENCES TBL_MC_CONTENT_PAGE (CONTENT_ID, CONTENT_PAGE_ID)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;

/*
-----------------------------------------------
-- Creation of TBL_MC_HOTSPOT_MEDIA
-----------------------------------------------
*/
CREATE TABLE TBL_MC_HOTSPOT_MEDIA (
    HOTSPOT_ID                      VARCHAR(32)                 NOT NULL,
    MEDIA_ID                        VARCHAR(32)                 NOT NULL,
    SYNOPSIS                        TEXT,
    TYPE                            VARCHAR(20),
    PRIMARY KEY PK_MC_HOTSPOT_MEDIA (HOTSPOT_ID),
    FOREIGN KEY FK_MC_HOTSPOT_MEDIA_01 (HOTSPOT_ID) REFERENCES TBL_MC_HOTSPOT (HOTSPOT_ID) ON UPDATE RESTRICT ON DELETE RESTRICT,
    FOREIGN KEY FK_MC_HOTSPOT_MEDIA_02 (MEDIA_ID) REFERENCES TBL_MC_CONTENT_MEDIA (MEDIA_ID) ON UPDATE RESTRICT ON DELETE RESTRICT
) ENGINE=INNODB DEFAULT CHARSET=UTF8;

/*
-----------------------------------------------
-- Creation of TBL_MC_HOTSPOT_TEXT
-----------------------------------------------
*/
CREATE TABLE TBL_MC_HOTSPOT_TEXT (
    HOTSPOT_ID                     VARCHAR(32)                  NOT NULL,
    TEXT_CONTENT                   TEXT                         NOT NULL,
    PRIMARY KEY PK_MC_HOTSPOT_TEXT (HOTSPOT_ID),
    FOREIGN KEY FK_MC_HOTSPOT_TEXT_01 (HOTSPOT_ID) REFERENCES TBL_MC_HOTSPOT (HOTSPOT_ID)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;


/*
-----------------------------------------------
-- Creation of TBL_MC_HOTSPOT_HYPERLINK
-----------------------------------------------
*/
CREATE TABLE TBL_MC_HOTSPOT_HYPERLINK (
    HOTSPOT_ID                      VARCHAR(32)                 NOT NULL,
    URI                             VARCHAR(255)                NOT NULL,
    TYPE                            char(10),
    PRIMARY KEY PK_MC_HOTSPOT_HYPERLINK (HOTSPOT_ID),
    FOREIGN KEY FK_MC_HOTSPOT_HYPERLINK_01 (HOTSPOT_ID) REFERENCES TBL_MC_HOTSPOT (HOTSPOT_ID)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;

/*
-----------------------------------------------
-- Creation of TBL_MC_HOTSPOT_MCQ_QUESTION
-----------------------------------------------
*/
CREATE TABLE TBL_MC_HOTSPOT_MCQ_QUESTION (
    QUESTION_ID                     VARCHAR(32)                 NOT NULL,
    OLD_QUESTION_ID                 VARCHAR(32),
    QUESTION_DESC                   VARCHAR(255)                NOT NULL,
    MUTUALLY_EXCLUSIVE              CHAR(1)                     NOT NULL,
    CHOICE_HOTSPOT_ID               VARCHAR(32)                 NOT NULL,
    ANS_HOTSPOT_ID                  VARCHAR(32)                 NOT NULL,
    MARKABLE                        CHAR(1)                     NOT NULL,
    MEDIA_ID                        VARCHAR(32),
    PRIMARY KEY PK_MC_HOTSPOT_MCQ_QUESTION (QUESTION_ID),
    FOREIGN KEY FK_MC_HOTSPOT_MCQ_QUESTION_01 (CHOICE_HOTSPOT_ID) REFERENCES TBL_MC_HOTSPOT (HOTSPOT_ID),
    FOREIGN KEY FK_MC_HOTSPOT_MCQ_QUESTION_02 (ANS_HOTSPOT_ID) REFERENCES TBL_MC_HOTSPOT (HOTSPOT_ID)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;

/*
-----------------------------------------------
-- Creation of TBL_MC_HOTSPOT_MCQ_CHOICE
-----------------------------------------------
*/
CREATE TABLE TBL_MC_HOTSPOT_MCQ_CHOICE (
    CHOICE_ID                       VARCHAR(32)                 NOT NULL,
    QUESTION_ID                     VARCHAR(32)                 NOT NULL,
    SEQUENCE                        INTEGER                     NOT NULL,
    CHOICE_DESC                     VARCHAR(255),
    ANS_DESC                        VARCHAR(255),
    IS_CORRECT                      CHAR(1)                     NOT NULL,
    MEDIA_ID                        VARCHAR(32),
    PRIMARY KEY PK_MC_HOTSPOT_MCQ_CHOICE (CHOICE_ID),
    FOREIGN KEY FK_MC_HOTSPOT_MCQ_CHOICE_01 (QUESTION_ID) REFERENCES TBL_MC_HOTSPOT_MCQ_QUESTION (QUESTION_ID)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;

/*
-----------------------------------------------
-- Creation of TBL_MC_HOTSPOT_ESSAY_QUESTION
-----------------------------------------------
*/
CREATE TABLE TBL_MC_HOTSPOT_ESSAY_QUESTION (
    HOTSPOT_ID                      VARCHAR(32)                 NOT NULL,
    OLD_HOTSPOT_ID                  VARCHAR(32),
    QUESTION_DESC                   VARCHAR(255)                NOT NULL,
    ANSWER_TEXT                     VARCHAR(255)                NOT NULL,
    MARKABLE                        CHAR(1)                     NOT NULL,
    COMPONENT_TYPE                  VARCHAR(11)                 NOT NULL                        DEFAULT 'Popup',
    MEDIA_ID                        VARCHAR(32),
    ENABLE_RICH_TEXT                CHAR(1)                     NOT NULL                        DEFAULT 'Y',
    PRIMARY KEY PK_MC_HOTSPOT_ESSAY_QUESTION (HOTSPOT_ID),
    FOREIGN KEY FK_MC_HOTSPOT_ESSAY_QUESTION_01 (HOTSPOT_ID) REFERENCES TBL_MC_HOTSPOT (HOTSPOT_ID)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;

/*
-----------------------------------------------
-- Creation of TBL_MC_ASSIGNMENT_SUBMISSION
-----------------------------------------------
*/
CREATE TABLE TBL_MC_ASSIGNMENT_SUBMISSION(
    SUBMISSION_ID                   VARCHAR(32)                 NOT NULL,
    ASSIGNMENT_ID                   VARCHAR(32)                 NOT NULL,
    USER_ID                         VARCHAR(32)                 NOT NULL,
    SUBMITTED_DATE                  DATETIME                    DEFAULT NULL,
    STATUS                          CHAR(1)                     DEFAULT NULL,
    ACHIEVED_POINTS                 VARCHAR(10)                 DEFAULT NULL,
    USEDTIME                        VARCHAR(8)                  DEFAULT NULL,
    TOTAL_QUESTIONS                 INT(4)                      NULL                            DEFAULT 0,
    CORRECT_ANSWERS                 INT(4)                      NULL                            DEFAULT 0,
    WRONG_ANSWERS                   INT(4)                      NULL                            DEFAULT 0,
    SCORE                           VARCHAR(10)                 NULL                            DEFAULT 0,
    CREATED_BY                      VARCHAR(32)                 NOT NULL,
    CREATED_DT                      DATETIME                    NOT NULL,
    UPDATED_BY                      VARCHAR(32)                 NOT NULL,
    UPDATED_DT                      DATETIME                    NOT NULL,
    VERSION                         int(11)                     NOT NULL,
    PRIMARY KEY  (SUBMISSION_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*
-----------------------------------------------
-- Creation of TBL_MC_ASSIGNMENT_SUBMISSION_QUESTION
-----------------------------------------------
*/
CREATE TABLE TBL_MC_ASSIGNMENT_SUBMISSION_QUESTION (
    SUBMISSION_QUESTION_ID          VARCHAR(32)                 NOT NULL,
    SUBMISSION_ID                   VARCHAR(32)                 NOT NULL,
    QUESTION_ID                     VARCHAR(32)                 NOT NULL,
    QUESTION_TYPE                   char(1)                     NOT NULL,
    CREATED_BY                      VARCHAR(32)                 DEFAULT NULL,
    CREATED_DT                      DATETIME                    DEFAULT NULL,
    UPDATED_BY                      VARCHAR(32)                 DEFAULT NULL,
    UPDATED_DT                      DATETIME                    DEFAULT NULL,
    VERSION                         int(11)                     DEFAULT NULL,
    PRIMARY KEY (SUBMISSION_QUESTION_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*
-----------------------------------------------
-- Creation of TBL_MC_ASSIGNMENT_SUBMISSION_ANSWER
-----------------------------------------------
*/
CREATE TABLE TBL_MC_ASSIGNMENT_SUBMISSION_ANSWER(
    SUBMISSION_ANSWER_ID            VARCHAR(32)                 NOT NULL,
    SUBMISSION_QUESTION_ID          VARCHAR(32)                 NOT NULL,
    ANSWER                          VARCHAR(255)                DEFAULT NULL,
    LONG_ANSWER                     VARCHAR(1000)               DEFAULT NULL,
    CREATED_BY                      VARCHAR(32)                 NOT NULL,
    CREATED_DT                      DATETIME                    NOT NULL,
    UPDATED_BY                      VARCHAR(32)                 NOT NULL,
    UPDATED_DT                      DATETIME                    NOT NULL,
    VERSION                         INT(11)                     NOT NULL,
    PRIMARY KEY  (SUBMISSION_ANSWER_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*
-----------------------------------------------
-- Creation of TBL_MC_ASSIGNMENT_SUBMISSION_MARK
-----------------------------------------------
*/
CREATE TABLE TBL_MC_ASSIGNMENT_SUBMISSION_MARK (
    SUBMISSION_MARK_ID              VARCHAR(32)                 NOT NULL                        DEFAULT '',
    SUBMISSION_QUESTION_ID          VARCHAR(32)                 DEFAULT NULL,
    `COMMENT`                       VARCHAR(1000)               DEFAULT NULL,
    SCORE                           INT(11)                     DEFAULT NULL,
    CREATED_BY                      VARCHAR(32)                 DEFAULT NULL,
    CREATED_DT                      DATETIME                    DEFAULT NULL,
    UPDATED_BY                      VARCHAR(32)                 DEFAULT NULL,
    UPDATED_DT                      DATETIME                    DEFAULT NULL,
    VERSION                         INT(11)                     DEFAULT NULL,
    PRIMARY KEY  (SUBMISSION_MARK_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*
-----------------------------------------------
-- Creation of TBL_MC_BOOKSTORE_REMOTE
-----------------------------------------------
*/
CREATE TABLE TBL_MC_BOOKSTORE_REMOTE(
    TENANT_ID                       VARCHAR(32)                 NOT NULL,
    REMOTE_BOOKSTORE_NAME           VARCHAR(100)                NOT NULL,
    REMOTE_BOOKSTORE_TYPE           VARCHAR(10)                 NOT NULL,
    REMOTE_BOOKSTORE_SERVER_NAME    VARCHAR(255)                NOT NULL,
    REMOTE_TENANT_ID                VARCHAR(32)                 NOT NULL,
    REMOTE_TENANT_NAME              VARCHAR(255)                NULL,
    STATUS                          VARCHAR(32)                 NOT NULL,
    DELETE_FLAG                     CHAR(1)                     NULL,
    CONSUMER_ID                     VARCHAR(32)                 NOT NULL,
    CONSUMER_KEY                    VARCHAR(32)                 NULL,
    PROVIDER_ID                     VARCHAR(32)                 NOT NULL,
    PROVIDER_KEY                    VARCHAR(32)                 NULL,
    REMARKS                         VARCHAR(32)                 NULL,
    CREATED_BY                      VARCHAR(32)                 NOT NULL,
    CREATED_DT                      DATETIME                    NOT NULL,
    UPDATED_BY                      VARCHAR(32)                 NOT NULL,
    UPDATED_DT                      DATETIME                    NOT NULL,
    PRIMARY KEY (CONSUMER_ID)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;

/*
-----------------------------------------------
-- Creation of TBL_MC_BOOKSTORE_CONSUMER
-----------------------------------------------
*/
CREATE TABLE TBL_MC_BOOKSTORE_CONSUMER(
    TENANT_ID                       VARCHAR(32)                 NOT NULL,
    CONSUMER_NAME                   VARCHAR(255)                NOT NULL,
    CONSUMER_SERVER_TYPE            VARCHAR(32)                 NOT NULL,
    CONSUMER_SERVER_NAME            VARCHAR(255)                NOT NULL,
    CONSUMER_TENANT_ID              VARCHAR(32)                 NOT NULL,
    CONSUMER_TENANT_NAME            VARCHAR(255)                NULL,
    CONSUMER_OU_ID                  VARCHAR(32)                 NULL,
    STATUS                          VARCHAR(32)                 NULL,
    CONSUMER_ID                     VARCHAR(32)                 NOT NULL,
    DELETE_FLAG                     CHAR(1)                     NULL,
    CONSUMER_KEY                    VARCHAR(32)                 NULL,
    PROVIDER_ID                     VARCHAR(32)                 NOT NULL,
    PROVIDER_KEY                    VARCHAR(32)                 NULL,
    REMARKS                         VARCHAR(32)                 NULL,
    CREATED_BY                      VARCHAR(32)                 NOT NULL,
    CREATED_DT                      DATETIME                    NOT NULL,
    UPDATED_BY                      VARCHAR(32)                 NOT NULL,
    UPDATED_DT                      DATETIME                    NOT NULL,
    PRIMARY KEY (PROVIDER_ID)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;

/*
-----------------------------------------------
-- Creation of TBL_MC_BOOKSTORE_VIEW_CATEGORY
-----------------------------------------------
*/
CREATE TABLE TBL_MC_BOOKSTORE_VIEW_CATEGORY(
    CONSUMER_ID                     VARCHAR(32)                 NOT NULL,
    CATEGORY_ID                     VARCHAR(32)                 NOT NULL,
    STATUS                          CHAR(1)                     NULL,
    CREATED_BY                      VARCHAR(32)                 NOT NULL,
    CREATED_DT                      DATETIME                    NOT NULL,
    UPDATED_BY                      VARCHAR(32)                 NOT NULL,
    UPDATED_DT                      DATETIME                    NOT NULL,
    PRIMARY KEY (CONSUMER_ID, CATEGORY_ID)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;

/*
-----------------------------------------------
-- Creation of TBL_MC_DOWNLOAD_LOG
-----------------------------------------------
*/
CREATE TABLE TBL_MC_DOWNLOAD_LOG (
    DOWNLOAD_ID                     VARCHAR(32)                 NOT NULL,
    DOWNLOAD_TYPE                   CHAR(2),
    SUBSCRIPTION_ID                 VARCHAR(32),
    PUBLICATION_ID                  VARCHAR(32),
    REVISION                        INTEGER,
    CONTENT_PAGE_ID                 VARCHAR(32),
    REMOTE_USER_ID                  VARCHAR(32),
    REMOTE_IP                       VARCHAR(64),
    REQUEST_DT                      DATETIME,
    RESPONSE_DT                     DATETIME,
    RETURN_STATUS                   VARCHAR(20),
    RESPONSE_CODE                   INTEGER,
    RESPONSE_TIME                   INTEGER,
    DOWNLOAD_SIZE                   INTEGER UNSIGNED,
    PRIMARY KEY PK_MC_DOWNLOAD_LOG (DOWNLOAD_ID)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;
create index index_1_tbl_mc_download_log on tbl_mc_download_log (publication_id);
create index index_2_tbl_mc_download_log on tbl_mc_download_log (remote_user_id);

/*
-----------------------------------------------
-- Creation of TBL_MC_PAYMENT_LOG
-----------------------------------------------
*/
CREATE TABLE `TBL_MC_PAYMENT_LOG` (
    `PAYMENT_LOG_ID`                VARCHAR(32)                 CHARACTER SET latin1            NOT NULL,
    `USER_ID`                       VARCHAR(32)                 CHARACTER SET latin1            DEFAULT NULL,
    `LOGIN_NAME`                    VARCHAR(100)                DEFAULT NULL,
    `FIRST_NAME`                    VARCHAR(100)                CHARACTER SET latin1            DEFAULT NULL,
    `LAST_NAME`                     VARCHAR(100)                CHARACTER SET latin1            DEFAULT NULL,
    `EMAIL_ADDRESS`                 VARCHAR(255)                CHARACTER SET latin1            DEFAULT NULL,
    `BOOK_TITLE`                    VARCHAR(255)                CHARACTER SET latin1            DEFAULT NULL,
    `BOOK_AUTHOR`                   VARCHAR(255)                CHARACTER SET latin1            DEFAULT NULL,
    `BOOK_PUBLISHER`                VARCHAR(255)                CHARACTER SET latin1            DEFAULT NULL,
    `BOOK_ISBN`                     VARCHAR(20)                 CHARACTER SET latin1            DEFAULT NULL,
    `BOOK_PUBLISHED_DT`             DATETIME                    DEFAULT NULL,
    `BOOK_PUBLICATION_DT`           DATETIME                    DEFAULT NULL,
    `BOOK_REVISION`                 VARCHAR(20)                 CHARACTER SET latin1            DEFAULT NULL,
    `BOOK_FORMAT`                   CHAR(1)                     CHARACTER SET latin1            DEFAULT NULL,
    `BOOK_VERSION`                  INT(11)                     DEFAULT NULL,
    `BOOK_CONTENT_TYPE`             CHAR(5)                     CHARACTER SET latin1            DEFAULT NULL,
    `BOOK_CONTENT_VIDEO_ID`         VARCHAR(32)                 CHARACTER SET latin1            DEFAULT NULL,
    `BOOK_STORE_ID`                 VARCHAR(32)                 CHARACTER SET latin1            DEFAULT NULL,
    `BOOK_STORE_NAME`               VARCHAR(100)                CHARACTER SET latin1            DEFAULT NULL,
    `BOOK_STORE_DESC`               VARCHAR(255)                CHARACTER SET latin1            DEFAULT NULL,
    `TENANT_ID`                     VARCHAR(32)                 CHARACTER SET latin1            DEFAULT NULL,
    `TENANT_NAME`                   VARCHAR(100)                CHARACTER SET latin1            DEFAULT NULL,
    `OFFER_ID`                      VARCHAR(32)                 CHARACTER SET latin1            DEFAULT NULL,
    `OFFER_CODE`                    VARCHAR(100)                CHARACTER SET latin1            DEFAULT NULL,
    `OFFER_DESC`                    VARCHAR(255)                CHARACTER SET latin1            DEFAULT NULL,
    `OFFER_LABEL`                   VARCHAR(50)                 CHARACTER SET latin1            DEFAULT NULL,
    `IS_FREE`                       CHAR(1)                     CHARACTER SET latin1            DEFAULT NULL,
    `PRODUCT_IDENTIFIER`            VARCHAR(255)                CHARACTER SET latin1            DEFAULT NULL,
    `PRICE_CENTS`                   INT(11)                     DEFAULT NULL,
    `VALID_FROM`                    DATETIME                    DEFAULT NULL,
    `VALID_TO`                      DATETIME                    DEFAULT NULL,
    `SUBS_PERIODS_HRS`              INT(11)                     DEFAULT NULL,
    `PRECEDENCE`                    INT(11)                     DEFAULT NULL,
    `SUBSCRIPTION_ID`               VARCHAR(32)                 CHARACTER SET latin1            DEFAULT NULL,
    `SUBS_START_DT`                 DATETIME                    DEFAULT NULL,
    `SUBS_END_DT`                   DATETIME                    DEFAULT NULL,
    `TERMINATION_DT`                DATETIME                    DEFAULT NULL,
    `CREATED_BY`                    VARCHAR(32)                 CHARACTER SET latin1            DEFAULT NULL,
    `CREATED_DT`                    DATETIME                    DEFAULT NULL,
    `UPDATED_BY`                    VARCHAR(20)                 CHARACTER SET latin1            DEFAULT NULL,
    `UPDATED_DT`                    DATETIME                    DEFAULT NULL,
    `VERSION`                       INT(11)                     DEFAULT NULL,
    PRIMARY KEY  (`PAYMENT_LOG_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*
-----------------------------------------------
-- Creation of TBL_MC_REQUEST_LOG
-----------------------------------------------
*/
CREATE TABLE TBL_MC_REQUEST_LOG (
    ID                              VARCHAR(32)                 NOT NULL,
    LOG_TYPE                        VARCHAR(32),
    REF_ID                          VARCHAR(32),
    REMOTE_USER_ID                  VARCHAR(32),
    REMOTE_IP                       VARCHAR(64),
    REQUEST_DT                      DATETIME,
    RESPONSE_DT                     DATETIME,
    RESPONSE_TIME                   INTEGER,
    REQUEST_DATA                    TEXT,
    RESPONSE_DATA                   TEXT,
    RETURN_STATUS                   VARCHAR(20),
    RESPONSE_CODE                   INTEGER,
    PRIMARY KEY PK_MC_REQUEST_LOG (ID)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;

/*
-----------------------------------------------
-- Creation of TBL_MT_USER_LOGIN_LOG
-----------------------------------------------
*/
CREATE TABLE TBL_MT_USER_LOGIN_LOG (
    LOG_ID                          VARCHAR(32)                 NOT NULL,
    DEVICE_ID                       VARCHAR(100)                NOT NULL,
    APP_SOURCE                      VARCHAR(20),
    APP_VERSION                     VARCHAR(32),
    APP_TYPE                        VARCHAR(20),
    OS_VERSION                      VARCHAR(32),
    USER_ID                         VARCHAR(32),
    TENANT_ID                       VARCHAR(32),
    LOGIN_TIME                      DATETIME,
    LOGIN_IP                        VARCHAR(32),
    LOGIN_RESULT                    VARCHAR(32),
    LOGIN_MESSAGE                   VARCHAR(1000),
    VERSION                         INT(11),
    PRIMARY KEY (LOG_ID)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

/*
-----------------------------------------------
-- Creation of TBL_MT_USER_NOTIFICATION_LOG
-----------------------------------------------
*/
CREATE TABLE TBL_MT_USER_NOTIFICATION_LOG (
    LOG_ID                          VARCHAR(32)                 NOT NULL,
    NOTIFICATION_ID                 VARCHAR(32)                 NOT NULL,
    SEND_DT                         DATETIME                    NOT NULL,
    STATUS                          CHAR(1)                     NOT NULL,
    ERROR_CODE                      VARCHAR(32)                 NULL,
    ERROR_MSG                       VARCHAR(255)                NULL
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;
ALTER TABLE TBL_MT_USER_NOTIFICATION_LOG ADD CONSTRAINT PK_MT_USER_DEVICE_NOTIFICATION_LOG  PRIMARY KEY (LOG_ID);

/*
-----------------------------------------------
-- Creation of TBL_MC_SUBSCRIPTION
-----------------------------------------------
*/
CREATE TABLE TBL_MC_SUBSCRIPTION (
    SUBSCRIPTION_ID                 VARCHAR(32)                 NOT NULL,
    OFFER_ID                        VARCHAR(32)                 NOT NULL,
    SUBSCRIBER_ID                   VARCHAR(255)                NOT NULL,
    STATUS                          CHAR(1)                     NOT NULL,
    SUBS_START_DT                   DATETIME                    NOT NULL,
    SUBS_END_DT                     DATETIME,
    TERMINATION_DT                  DATETIME,
    CREATED_BY                      VARCHAR(32)                 NOT NULL,
    CREATED_DT                      DATETIME                    NOT NULL,
    UPDATED_BY                      VARCHAR(32)                 NOT NULL,
    UPDATED_DT                      DATETIME                    NOT NULL,
    VERSION                         INTEGER                     NOT NULL,
    PRIMARY KEY PK_MC_SUBSCRIPTION (SUBSCRIPTION_ID),
    FOREIGN KEY FK_MC_SUBSCRIPTION_01 (OFFER_ID) REFERENCES TBL_MC_OFFER(OFFER_ID)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;

/*
-----------------------------------------------
-- Creation of TBL_MC_RECEIPT_DATA
-----------------------------------------------
*/
CREATE TABLE TBL_MC_RECEIPT_DATA (
    RECEIPT_ID                      VARCHAR(32)                 NOT NULL,
    SUBSCRIPTION_ID                 VARCHAR(32)                 NOT NULL,
    STATUS                          CHAR(1)                     NOT NULL,
    RECEIPT_DATA                    BLOB                        NOT NULL,
    CREATED_BY                      VARCHAR(32)                 NOT NULL,
    CREATED_DT                      DATETIME                    NOT NULL,
    UPDATED_BY                      VARCHAR(32)                 NOT NULL,
    UPDATED_DT                      DATETIME                    NOT NULL,
    VERSION                         INTEGER                     NOT NULL,
    PRIMARY KEY PK_MC_RECEIPT_DATA (RECEIPT_ID),
    FOREIGN KEY FK_MC_RECEIPT_DATA_01 (SUBSCRIPTION_ID) REFERENCES TBL_MC_SUBSCRIPTION(SUBSCRIPTION_ID)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;

/*
-----------------------------------------------
-- Creation of TBL_MC_RECEIPT
-----------------------------------------------
*/
CREATE TABLE TBL_MC_RECEIPT (
    RECEIPT_ID                      VARCHAR(32)                 NOT NULL,
    SUBSCRIPTION_ID                 VARCHAR(32)                 NOT NULL,
    TRANSACTION_ID                  VARCHAR(255)                NOT NULL,
    PRODUCT_ID                      VARCHAR(255)                NOT NULL,
    PURCHASE_DATE                   DATETIME                    NOT NULL,
    QUANTITY                        INTEGER,
    ORIGINAL_TRANSACTION_ID         VARCHAR(255),
    ORIGINAL_PURCHASE_DATE          DATETIME,
    APP_ITEM_ID                     VARCHAR(255),
    VERSION_EXTERNAL_ID             INTEGER,
    BID                             VARCHAR(255),
    BVRS                            VARCHAR(10),
    CREATED_BY                      VARCHAR(32)                 NOT NULL,
    CREATED_DT                      DATETIME                    NOT NULL,
    UPDATED_BY                      VARCHAR(32)                 NOT NULL,
    UPDATED_DT                      DATETIME                    NOT NULL,
    VERSION                         INTEGER                     NOT NULL,
    PRIMARY KEY PK_MC_RECEIPT (RECEIPT_ID),
    FOREIGN KEY FK_MC_RECEIPT_01 (SUBSCRIPTION_ID) REFERENCES TBL_MC_SUBSCRIPTION(SUBSCRIPTION_ID),
    FOREIGN KEY FK_MC_RECEIPT_02 (RECEIPT_ID) REFERENCES TBL_MC_RECEIPT_DATA(RECEIPT_ID)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;

/*
-----------------------------------------------
-- Insert of TBL_AA_GROUP
-----------------------------------------------
*/
INSERT INTO TBL_AA_GROUP 
(`GROUP_ID`, `DOMAIN_NAME`, `GROUP_NAME`, `CREATED_DT`, `CREATED_BY`, `UPDATED_DT`, `UPDATED_BY`, `GROUP_PARENT_ID`, `VERSION`, `GROUP_TYPE`, `GROUP_LABEL`, `LEFT_INDEX`, `RIGHT_INDEX`)
VALUES
('REQ-group-universal', 'NA', 'UNIVERSAL_GROUP', '2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin', NULL, 1, '', '', null, null),
('REQ-group-extranet', 'NA', 'EXTRANET_GROUP', '2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin', 'REQ-group-universal', 1, '', '', null, null),
('SAM-group-partner1', 'NA', 'PARTNER A', '2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin', 'REQ-group-extranet', 1, '', '', null, null),
('SAM-group-partner2', 'NA', 'PARTNER B', '2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin', 'REQ-group-extranet', 1, '', '', null, null),
('REQ-group-internet', 'NA', 'INTERNET_GROUP', '2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin', 'REQ-group-universal', 1, '', '', null, null),
('REQ-group-intranet', 'NA', 'INTRANET_GROUP', '2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin', 'REQ-group-universal', 1, '', '', null, null),
('DEF-group-organization', 'NA', 'ORGANIZATION_GROUP', '2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin', 'REQ-group-intranet', 1, '', '', null, null),
('DEF-group-groupA', 'NA', 'GROUP A', '2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin', 'DEF-group-organization', 1, '', '', null, null),
('SAM-group-groupA1', 'NA', 'GROUP A1', '2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin', 'DEF-group-groupA', 1, '', '', null, null),
('SAM-group-groupA2', 'NA', 'GROUP A2', '2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin', 'DEF-group-groupA', 1, '', '', null, null),
('SAM-group-groupB', 'NA', 'GROUP B', '2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin', 'DEF-group-organization', 1, '', '', null, null),
('SAM-group-groupB1', 'NA', 'GROUP B1', '2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin', 'SAM-group-groupB', 1, '', '', null, null),
('SAM-group-groupB2', 'NA', 'GROUP B2', '2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin', 'SAM-group-groupB', 1, '', '', null, null),
('DEF-group-prime', 'NA', 'PRIME GROUP', NOW(), 'DEF-user-superadmin', NOW(), 'DEF-user-superadmin', 'REQ-group-universal', 1, '', '', NULL, NULL),
('DEF-group-unitA', 'NA', 'UNIT A', NOW(), 'DEF-user-superadmin', NOW(), 'DEF-user-superadmin', 'DEF-group-prime', 1, '', '', NULL, NULL),
('DEF-group-unitB', 'NA', 'UNIT B', NOW(), 'DEF-user-superadmin', NOW(), 'DEF-user-superadmin', 'DEF-group-prime', 1, '', '', NULL, NULL),
('DEF-group-test', 'NA', 'TEST GROUP', NOW(), 'DEF-user-superadmin', NOW(), 'DEF-user-superadmin', 'DEF-group-prime', 1, '', '', NULL, NULL);

/*
-----------------------------------------------
-- Insert of TBL_AA_GROUP_ADMIN
-----------------------------------------------
*/
INSERT INTO TBL_AA_GROUP_ADMIN
(`GROUP_ID`, `ADMIN_TYPE`, `ADMIN_ID`, `DELEGATOR_ID`, `PRECEDENCE`, `CREATED_DT`, `CREATED_BY`, `UPDATED_DT`, `UPDATED_BY`, `VERSION`)
VALUES
('REQ-group-universal', 'S', 'DEF-user-roleadmin', null, null, '2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin', 1),
('REQ-group-universal', 'S', 'DEF-user-useradmin', null, null, '2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin', 1),
('DEF-group-groupA'   , 'S', 'SAM-user-user1'    , null, null, '2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin', 1),
('SAM-group-groupB'   , 'S', 'SAM-user-user2'    , null, null, '2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin', 1),
('SAM-group-groupA1'  , 'S', 'SAM-user-userA1'   , null, null, '2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin', 1),
('SAM-group-groupA2'  , 'S', 'SAM-user-userA2'   , null, null, '2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin', 1),
('SAM-group-groupB1'  , 'S', 'SAM-user-userB1'   , null, null, '2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin', 1),
('SAM-group-groupB2'  , 'S', 'SAM-user-userB2'   , null, null, '2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin', 1);

/*
-----------------------------------------------
-- Insert of TBL_AA_SUBJECT
-----------------------------------------------
*/
INSERT INTO TBL_AA_SUBJECT
(`SUBJECT_ID`, `DOMAIN_NAME`, `FIRST_NAME`, `LAST_NAME`, `EMAIL`, `PHONE_NUM`, `EFFECTIVE_DT`, `EXPIRY_DT`, `STATUS`, `LAST_LOGIN_DT`, `LAST_LOGIN_IP`, `CREATED_DT`, `CREATED_BY`, `UPDATED_DT`, `UPDATED_BY`, `ALLOWED_LOGIN_LEVEL`, `LOGICAL_DEL`, `VERSION`)
VALUES
('DEF-user-useradmin', 'NA', 'User', 'Admin', 'useradmin@ncs.com.sg',null, null, null, 'A' ,'2004-01-01', null, '2004-01-01', 'DEF-user-useradmin','2004-01-01', 'DEF-user-useradmin' , 1, 0,1),
('DEF-user-roleadmin', 'NA', 'Role', 'Admin', 'roleadmin@ncs.com.sg',null, null, null, 'A' ,'2004-01-01', null, '2004-01-01', '3a1f170dc0a8ab6c00191e4c976e2264','2004-01-01', '3a1f170dc0a8ab6c00191e4c976e2264' , 1,0,1),
('DEF-user-siteadmin', 'NA', 'Site', 'Admin', 'siteadmin@ncs.com.sg',null, null, null, 'A' ,'2004-01-01', null, '2004-01-01', '3a1f170dc0a8ab6c00191e4c976e2264','2004-01-01', '3a1f170dc0a8ab6c00191e4c976e2264' , 1,0,1),
('SAM-user-user1', 'NA', 'User', '1', 'user1@ncs.com.sg',null, null, null, 'A' ,null, null, '2004-01-01', 'DEF-user-useradmin','2004-01-01', 'DEF-user-useradmin' , 1,0,1),
('SAM-user-user2', 'NA', 'User', '2', 'user2@ncs.com.sg', null,null, null, 'A' ,'2004-01-01', null, '2004-01-01', 'DEF-user-useradmin','2004-01-01', 'DEF-user-useradmin' , 1,0,1),
('SAM-user-userA1', 'NA', 'User', 'A1', 'userA1@ncs.com.sg',null, null, null, 'A' , null, null, '2004-01-01', 'DEF-user-useradmin','2004-01-01', 'DEF-user-useradmin' , 1,0,1),
('SAM-user-userA2', 'NA', 'User', 'A2', 'userA2@ncs.com.sg',null, null, null, 'A' , null, null, '2004-01-01', 'DEF-user-useradmin','2004-01-01', 'DEF-user-useradmin' , 1,0,1),
('SAM-user-userB1', 'NA', 'User', 'B1', 'userB1@ncs.com.sg', null,null, null, 'A' , null, null, '2004-01-01', 'DEF-user-useradmin','2004-01-01', 'DEF-user-useradmin' , 1,0,1),
('SAM-user-userB2', 'NA', 'User', 'B2', 'userB2@ncs.com.sg', null,null, null, 'A' , null, null, '2004-01-01', 'DEF-user-useradmin','2004-01-01', 'DEF-user-useradmin' , 1,0,1),
('SAM-user-internet1', 'NA', 'Internet User', '1', 'internetUser1@ncs.com.sg',null, null, null, 'A' ,null, null, '2004-01-01', 'DEF-user-useradmin','2004-01-01', 'DEF-user-useradmin' , 1,0,1),
('SAM-user-internet2', 'NA', 'Internet User', '2', 'internetUser2@ncs.com.sg',null, null, null, 'A' ,null, null, '2004-01-01', 'DEF-user-useradmin','2004-01-01', 'DEF-user-useradmin' , 1,0,1),
('SAM-user-extranet1', 'NA', 'Extranet User', '1', 'extranetUser1@ncs.com.sg',null, null, null, 'A' ,null, null, '2004-01-01', 'DEF-user-useradmin','2004-01-01', 'DEF-user-useradmin' , 1, 0,1),
('SAM-user-extranet2', 'NA', 'Extranet User', '2', 'extranetUser2@ncs.com.sg',null, null, null, 'A' ,null, null, '2004-01-01', 'DEF-user-useradmin','2004-01-01', 'DEF-user-useradmin' , 1,0,1),
('DEF-user-superadmin', 'NA', 'Super', 'Admin', 'superadmin@ncs.com.sg', NULL, NULL, NULL, 'A' ,'2004-01-01', NULL, '2004-01-01', 'DEF-user-superadmin','2004-01-01', 'DEF-user-superadmin' , 1, 0,1),
('DEF-user-portaladmin', 'NA', 'Portal', 'Admin', 'portaladmin@ncs.com.sg', NULL, NULL, NULL, 'A' ,'2004-01-01', NULL, '2004-01-01', 'DEF-user-superadmin','2004-01-01', 'DEF-user-superadmin' , 1, 0,1),
('DEF-user-tenantadmina', 'NA', 'Tenant', 'Admin', 'tenantadmin@ncs.com.sg', NULL, NULL, NULL, 'A' ,'2004-01-01', NULL, '2004-01-01', 'DEF-user-superadmin','2004-01-01', 'DEF-user-superadmin' , 1, 0,1),
('DEF-user-tenantadminb', 'NA', 'Tenant', 'Admin', 'tenantadmin@ncs.com.sg', NULL, NULL, NULL, 'A' ,'2004-01-01', NULL, '2004-01-01', 'DEF-user-superadmin','2004-01-01', 'DEF-user-superadmin' , 1, 0,1),
('DEF-user-contentadmin', 'NA', 'Content', 'Admin', 'contentadmin@ncs.com.sg', NULL, NULL, NULL, 'A' ,'2004-01-01', NULL, '2004-01-01', 'DEF-user-superadmin','2004-01-01', 'DEF-user-superadmin' , 1, 0,1),
('DEF-user-contentcreator', 'NA', 'Content', 'Creator', 'contentcreator@ncs.com.sg', NULL, NULL, NULL, 'A' ,'2004-01-01', NULL, '2004-01-01', 'DEF-user-superadmin','2004-01-01', 'DEF-user-superadmin' , 1, 0,1),
('DEF-user-contentpublisher', 'NA', 'Content', 'Publisher', 'contentpublisher@ncs.com.sg', NULL, NULL, NULL, 'A' ,'2004-01-01', NULL, '2004-01-01', 'DEF-user-superadmin','2004-01-01', 'DEF-user-superadmin' , 1, 0,1),
('DEF-user-one', 'NA', 'User', 'One', 'userone@ncs.com.sg', NULL, NULL, NULL, 'A' ,'2004-01-01', NULL, '2004-01-01', 'DEF-user-superadmin','2004-01-01', 'DEF-user-superadmin' , 1, 0,1),
('DEF-user-two', 'NA', 'User', 'Two', 'usertwo@ncs.com.sg', NULL, NULL, NULL, 'A' ,'2004-01-01', NULL, '2004-01-01', 'DEF-user-superadmin','2004-01-01', 'DEF-user-superadmin' , 1, 0,1),
('DEF-user-three', 'NA', 'User', 'Three', 'userthree@ncs.com.sg', NULL, NULL, NULL, 'A' ,'2004-01-01', NULL, '2004-01-01', 'DEF-user-superadmin','2004-01-01', 'DEF-user-superadmin' , 1, 0,1);

/*
-----------------------------------------------
-- Insert of TBL_AA_SUBJECT_LOGIN
-----------------------------------------------
*/
INSERT INTO TBL_AA_SUBJECT_LOGIN 
(`SUBJECT_ID`, `LOGIN_MECHANISM`, `DOMAIN_NAME`, `LOGIN_NAME`, `PASSWORD`, `RECALL_QUESTION`, `RECALL_ANS`, `PASSWORD_CHANGED_DATE`, `ATTEMPTS_MADE`, `CREATED_DT`, `CREATED_BY`, `UPDATED_DT`, `UPDATED_BY`, `VERSION`)
VALUES
/* all password is the hashed version of the value : password1 */
/*SHA-512 : vFR3ULknl/lVs2ESzJvdXN330IYhUdA6FnraiZWqJKmtJGELNqaLwC2iQUHuUWcK6hPtZGkJmkRT8zXLI5212g== */
/*SHA : 44rSFJQ9qtHWTBAvrsKd5K/p2j0= */
('DEF-user-siteadmin','PASSWORD', 'NA', 'siteadmin', 'vFR3ULknl/lVs2ESzJvdXN330IYhUdA6FnraiZWqJKmtJGELNqaLwC2iQUHuUWcK6hPtZGkJmkRT8zXLI5212g==', null, null, null, 0, '2004-01-01', 'DEF-user-useradmin','2004-01-01', 'DEF-user-useradmin', 1),
('DEF-user-roleadmin','PASSWORD', 'NA', 'roleadmin', 'vFR3ULknl/lVs2ESzJvdXN330IYhUdA6FnraiZWqJKmtJGELNqaLwC2iQUHuUWcK6hPtZGkJmkRT8zXLI5212g==', null, null, null, 0, '2004-01-01', 'DEF-user-useradmin','2004-01-01', 'DEF-user-useradmin', 1),
('DEF-user-useradmin','PASSWORD', 'NA', 'useradmin', 'vFR3ULknl/lVs2ESzJvdXN330IYhUdA6FnraiZWqJKmtJGELNqaLwC2iQUHuUWcK6hPtZGkJmkRT8zXLI5212g==', null, null, null, 0, '2004-01-01', 'DEF-user-useradmin','2004-01-01', 'DEF-user-useradmin', 1),
('SAM-user-user1','PASSWORD', 'NA', 'manager', 'vFR3ULknl/lVs2ESzJvdXN330IYhUdA6FnraiZWqJKmtJGELNqaLwC2iQUHuUWcK6hPtZGkJmkRT8zXLI5212g==', null, null, null,0, '2004-01-01', 'DEF-user-useradmin','2004-01-01', 'DEF-user-useradmin', 1),
('SAM-user-user2','PASSWORD', 'NA', 'user2', 'vFR3ULknl/lVs2ESzJvdXN330IYhUdA6FnraiZWqJKmtJGELNqaLwC2iQUHuUWcK6hPtZGkJmkRT8zXLI5212g==', null, null, null,0, '2004-01-01', 'DEF-user-useradmin','2004-01-01', 'DEF-user-useradmin', 1),
('SAM-user-userA1','PASSWORD', 'NA', 'userA1', 'vFR3ULknl/lVs2ESzJvdXN330IYhUdA6FnraiZWqJKmtJGELNqaLwC2iQUHuUWcK6hPtZGkJmkRT8zXLI5212g==', null, null, null,0, '2004-01-01', 'DEF-user-useradmin','2004-01-01', 'DEF-user-useradmin', 1),
('SAM-user-userA2','PASSWORD', 'NA', 'userA2', 'vFR3ULknl/lVs2ESzJvdXN330IYhUdA6FnraiZWqJKmtJGELNqaLwC2iQUHuUWcK6hPtZGkJmkRT8zXLI5212g==', null, null, null,0, '2004-01-01', 'DEF-user-useradmin','2004-01-01', 'DEF-user-useradmin', 1),
('SAM-user-userB1','PASSWORD', 'NA', 'userB1', 'vFR3ULknl/lVs2ESzJvdXN330IYhUdA6FnraiZWqJKmtJGELNqaLwC2iQUHuUWcK6hPtZGkJmkRT8zXLI5212g==', null, null, null,0, '2004-01-01', 'DEF-user-useradmin','2004-01-01', 'DEF-user-useradmin', 1),
('SAM-user-userB2','PASSWORD', 'NA', 'userB2', 'vFR3ULknl/lVs2ESzJvdXN330IYhUdA6FnraiZWqJKmtJGELNqaLwC2iQUHuUWcK6hPtZGkJmkRT8zXLI5212g==', null, null, null,0, '2004-01-01', 'DEF-user-useradmin','2004-01-01', 'DEF-user-useradmin', 1),
('SAM-user-internet1','PASSWORD', 'NA', 'internet1', 'vFR3ULknl/lVs2ESzJvdXN330IYhUdA6FnraiZWqJKmtJGELNqaLwC2iQUHuUWcK6hPtZGkJmkRT8zXLI5212g==', null, null, null,0, '2004-01-01', 'DEF-user-useradmin','2004-01-01', 'DEF-user-useradmin', 1),
('SAM-user-internet2','PASSWORD', 'NA', 'internet2', 'vFR3ULknl/lVs2ESzJvdXN330IYhUdA6FnraiZWqJKmtJGELNqaLwC2iQUHuUWcK6hPtZGkJmkRT8zXLI5212g==', null, null, null,0, '2004-01-01', 'DEF-user-useradmin','2004-01-01', 'DEF-user-useradmin', 1),
('SAM-user-extranet1','PASSWORD', 'NA', 'extranet1', 'vFR3ULknl/lVs2ESzJvdXN330IYhUdA6FnraiZWqJKmtJGELNqaLwC2iQUHuUWcK6hPtZGkJmkRT8zXLI5212g==', null, null, null,0, '2004-01-01', 'DEF-user-useradmin','2004-01-01', 'DEF-user-useradmin', 1),
('SAM-user-extranet2','PASSWORD', 'NA', 'extranet2', 'vFR3ULknl/lVs2ESzJvdXN330IYhUdA6FnraiZWqJKmtJGELNqaLwC2iQUHuUWcK6hPtZGkJmkRT8zXLI5212g==', null, null, null,0, '2004-01-01', 'DEF-user-useradmin','2004-01-01', 'DEF-user-useradmin', 1),
('DEF-user-superadmin', 'PASSWORD', 'NA', 'superadmin', 'vFR3ULknl/lVs2ESzJvdXN330IYhUdA6FnraiZWqJKmtJGELNqaLwC2iQUHuUWcK6hPtZGkJmkRT8zXLI5212g==', NULL, NULL, NULL, 0, '2004-01-01', 'DEF-user-superadmin','2004-01-01', 'DEF-user-superadmin', 1),
('DEF-user-portaladmin', 'PASSWORD', 'NA', 'portaladmin', 'vFR3ULknl/lVs2ESzJvdXN330IYhUdA6FnraiZWqJKmtJGELNqaLwC2iQUHuUWcK6hPtZGkJmkRT8zXLI5212g==', NULL, NULL, NULL, 0, '2004-01-01', 'DEF-user-superadmin','2004-01-01', 'DEF-user-superadmin', 1),
('DEF-user-tenantadmina', 'PASSWORD', 'NA', 'tenantadmina', 'vFR3ULknl/lVs2ESzJvdXN330IYhUdA6FnraiZWqJKmtJGELNqaLwC2iQUHuUWcK6hPtZGkJmkRT8zXLI5212g==', NULL, NULL, NULL, 0, '2004-01-01', 'DEF-user-superadmin','2004-01-01', 'DEF-user-superadmin', 1),
('DEF-user-tenantadminb', 'PASSWORD', 'NA', 'tenantadminb', 'vFR3ULknl/lVs2ESzJvdXN330IYhUdA6FnraiZWqJKmtJGELNqaLwC2iQUHuUWcK6hPtZGkJmkRT8zXLI5212g==', NULL, NULL, NULL, 0, '2004-01-01', 'DEF-user-superadmin','2004-01-01', 'DEF-user-superadmin', 1),
('DEF-user-contentadmin', 'PASSWORD', 'NA', 'contentadmin', 'vFR3ULknl/lVs2ESzJvdXN330IYhUdA6FnraiZWqJKmtJGELNqaLwC2iQUHuUWcK6hPtZGkJmkRT8zXLI5212g==', NULL, NULL, NULL, 0, '2004-01-01', 'DEF-user-superadmin','2004-01-01', 'DEF-user-superadmin', 1),
('DEF-user-contentcreator', 'PASSWORD', 'NA', 'creator', 'vFR3ULknl/lVs2ESzJvdXN330IYhUdA6FnraiZWqJKmtJGELNqaLwC2iQUHuUWcK6hPtZGkJmkRT8zXLI5212g==', NULL, NULL, NULL, 0, '2004-01-01', 'DEF-user-superadmin','2004-01-01', 'DEF-user-superadmin', 1),
('DEF-user-contentpublisher', 'PASSWORD', 'NA', 'publisher', 'vFR3ULknl/lVs2ESzJvdXN330IYhUdA6FnraiZWqJKmtJGELNqaLwC2iQUHuUWcK6hPtZGkJmkRT8zXLI5212g==', NULL, NULL, NULL, 0, '2004-01-01', 'DEF-user-superadmin','2004-01-01', 'DEF-user-superadmin', 1),
('DEF-user-one', 'PASSWORD', 'NA', 'user1', 'vFR3ULknl/lVs2ESzJvdXN330IYhUdA6FnraiZWqJKmtJGELNqaLwC2iQUHuUWcK6hPtZGkJmkRT8zXLI5212g==', NULL, NULL, NULL, 0, '2004-01-01', 'DEF-user-superadmin','2004-01-01', 'DEF-user-superadmin', 1),
('DEF-user-two', 'PASSWORD', 'NA', 'user2', 'vFR3ULknl/lVs2ESzJvdXN330IYhUdA6FnraiZWqJKmtJGELNqaLwC2iQUHuUWcK6hPtZGkJmkRT8zXLI5212g==', NULL, NULL, NULL, 0, '2004-01-01', 'DEF-user-superadmin','2004-01-01', 'DEF-user-superadmin', 1),
('DEF-user-three', 'PASSWORD', 'NA', 'user3', 'vFR3ULknl/lVs2ESzJvdXN330IYhUdA6FnraiZWqJKmtJGELNqaLwC2iQUHuUWcK6hPtZGkJmkRT8zXLI5212g==', NULL, NULL, NULL, 0, '2004-01-01', 'DEF-user-superadmin','2004-01-01', 'DEF-user-superadmin', 1);

/*
-----------------------------------------------
-- Insert of TBL_AA_RESOURCES
-----------------------------------------------
*/
INSERT INTO TBL_AA_RESOURCES
(`RESOURCES_ID`, `RESOURCE_NAME`, `RESOURCE_PATH`, `RESOURCE_TYPE`, `DOMAIN_NAME`, `EFFECTIVE_FROM`, `EFFECTIVE_TO`, `CREATED_DT`, `CREATED_BY`, `UPDATED_DT`, `UPDATED_BY`, `REQ_LOGIN_LEVEL`, `VERSION`, `BELONG_TO`, `LOG_ENABLED`, `LOG_TRANSACTION`)
VALUES
('DEF-role-useradmin', 'User Admin Role' ,'-', 'LOG_ROLE', 'NA',null,null, '2004-01-01','DEF-user-useradmin','2004-01-01','DEF-user-useradmin',1,1, 'REQ-group-universal',0,0),
('SAM-res-sample-addcust1', 'Sample Add User','/sample/custdir/add.do', 'URI','NA', null,null,'2004-01-01','DEF-user-useradmin','2004-01-01','DEF-user-useradmin',1, 1, 'DEF-group-groupA',1,1),
('SAM-res-sample-addcust2', 'Sample Add User Processing','/sample/custdir/addprocess.do', 'URI','NA',null,null, '2004-01-01','DEF-user-useradmin','2004-01-01','DEF-user-useradmin',1, 1, 'DEF-group-groupA',1,1),
('SAM-res-sample-delcust', 'Sample Delete User','/sample/custdir/delete.do', 'URI','NA',null,null, '2004-01-01','DEF-user-useradmin','2004-01-01','DEF-user-useradmin',1, 1, 'DEF-group-groupA',1,1),
('DEF-res-menu-addmenu', 'MA Add Menu (MenuAdmin Webapp)','/menuadmin/menuadmin/addMenu.do', 'URI','NA',null,null, '2004-01-01','DEF-user-useradmin','2004-01-01','DEF-user-useradmin',1,1, 'SAM-group-groupB',0,0),
('DEF-res-menu-deletemenu', 'MA Delete Menu (MenuAdmin Webapp)','/menuadmin/menuadmin/deleteMenu.do', 'URI','NA',null,null, '2004-01-01','DEF-user-useradmin','2004-01-01','DEF-user-useradmin',1,1, 'SAM-group-groupB',0,0),
('DEF-res-menu-adddisplayer', 'MA Add Displayer (CodeAdmin Webapp)','/menuadmin/menuadmin/addDisplayer.do', 'URI','NA',null,null, '2004-01-01','DEF-user-useradmin','2004-01-01','DEF-user-useradmin',1,1, 'SAM-group-groupB',0,0),
('DEF-res-profile-initProfile', 'Init Create Profile (ProfileAdmin Webapp)', '/profileadmin/profileadmin/initProfile.do', 'URI','NA',null,null, '2005-01-01', 'DEF-user-useradmin', '2005-01-01', 'DEF-user-useradmin', 1,1, 'SAM-group-groupA1',0,0),
('DEF-res-profile-searchProfiles', 'Search Profile (ProfileAdmin Webapp)', '/profileadmin/profileadmin/searchProfiles.do', 'URI','NA',null,null, '2005-01-01', 'DEF-user-useradmin', '2005-01-01', 'DEF-user-useradmin', 1,1, 'SAM-group-groupA1',0,0),
('DEF-res-code-add', 'CA Add Code (CodeAdmin Webapp)','/codeadmin/codeadmin/addselect.do', 'URI','NA',null,null, '2004-01-01','DEF-user-useradmin','2004-01-01','DEF-user-useradmin',1,1, 'SAM-group-groupA2',0,0),
('DEF-res-code-importdata', 'Import Data (CodeAdmin Webapp)', '/codeadmin/codeadmin/importdata.do', 'URI','NA',null,null, '2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin',1, 1, 'SAM-group-groupA2',0,0),
('DEF-res-code-exportdata', 'Export Data (CodeAdmin Webapp)', '/codeadmin/codeadmin/exportdata.do', 'URI','NA', null,null,'2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin', 1,1, 'SAM-group-groupA2',0,0),
('DEF-res-code-codeType', 'Code Type (CodeAdmin Webapp)', '/codeadmin/codeadmin/codeTypeSelect.do', 'URI','NA',null,null, '2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin', 1,1, 'SAM-group-groupA2',0,0),
('DEF-res-profile-deletesystem', 'Delete System Profile (ProfileAdmin Webapp)', '/profileadmin/profileadmin/deleteSysProfile.do', 'URI','NA',null,null, '2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin',1, 1, 'SAM-group-groupA1',0,0),
('DEF-res-profile-addsystem', 'Add System Profile (ProfileAdmin Webapp)', '/profileadmin/profileadmin/addSysProfile.do', 'URI','NA', null,null,'2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin', 1,1, 'SAM-group-groupA1',0,0),
('DEF-res-profile-viewsystem', 'View System Profile (ProfileAdmin Webapp)', '/profileadmin/profileadmin/viewSysProfile.do', 'URI','NA', null,null,'2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin',1, 1, 'SAM-group-groupA1',0,0),
('DEF-res-profile-viewdisplayer', 'View Displayer (ProfileAdmin Webapp)', '/profileadmin/profileadmin/viewDisplayer.do', 'URI','NA',null,null, '2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin', 1,1, 'SAM-group-groupA1',0,0),
('DEF-res-profile-adddisplayer', 'Add Displayer (ProfileAdmin Webapp)', '/profileadmin/profileadmin/addDisplayer.do', 'URI','NA',null,null, '2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin', 1,1, 'SAM-group-groupA1',0,0),
('DEF-res-profile-deletemenu', 'Delete Menu (ProfileAdmin Webapp)', '/profileadmin/profileadmin/deleteMenu.do', 'URI','NA',null,null, '2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin', 1,1, 'SAM-group-groupA1',0,0),
('DEF-res-profile-addmenu', 'Add New Menu (ProfileAdmin Webapp)', '/profileadmin/profileadmin/addMenuRepository.do', 'URI','NA',null,null, '2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin',1, 1, 'SAM-group-groupA1',0,0),
('DEF-res-profile-viewmenu', 'View Current Menu (ProfileAdmin Webapp)', '/profileadmin/profileadmin/viewMenu.do', 'URI','NA',null,null, '2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin',1, 1, 'SAM-group-groupA1',0,0),
('DEF-res-ua-full', 'Full UA Right (ACM Webapp)', '/acm/ua', 'URI','NA', null,null,'2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin',1, 1, 'REQ-group-universal',0,0),
('DEF-res-ra-full', 'Full RA Right (ACM Webapp)', '/acm/ra', 'URI','NA',null,null,'2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin',1, 1, 'REQ-group-universal',0,0),
('DEF-res-acm-initexplorer', 'ACM Init explorer view', '/acm/ua/explorerview.do', 'URI','NA',null,null, '2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin', 1,1, 'REQ-group-universal',0,0),
('DEF-res-acm-loadexplorer', 'ACM Load explorer view', '/acm/ua/LoadExplorerView.do', 'URI','NA', null,null,'2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin', 1,1, 'REQ-group-universal',0,0),
('DEF-res-acm-adminlog', 'ACM view admin log', '/acm/ua/viewadminlog.do', 'URI','NA',null,null, '2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin', 1,1, 'REQ-group-universal',0,0),
('DEF-res-acm-adminlogpro', 'ACM view admin log process', '/acm/ua/viewadminlogprocess.do', 'URI','NA',null,null, '2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin', 1,1, 'REQ-group-universal',0,0),
('DEF-res-acm-loginlog', 'ACM view login log', '/acm/ua/viewloginlog.do', 'URI','NA',null,null, '2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin', 1,1, 'REQ-group-universal',0,0),
('DEF-res-acm-loginlogpro', 'ACM view login log process', '/acm/ua/viewloginlogprocess.do', 'URI','NA',null,null, '2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin', 1,1, 'REQ-group-universal',0,0),
('DEF-res-acm-encrypt', 'ACM encrypt decrypt', '/acm/ua/encryptdecrypt.do', 'URI','NA',null,null, '2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin', 1,1, 'REQ-group-universal',0,0),
('DEF-res-acm-encryptpro', 'ACM encrypt decrypt process', '/acm/ua/encryptdecryptprocess.do', 'URI','NA',null,null, '2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin', 1,1, 'REQ-group-universal',0,0),
('SAM-res-changepwd', 'Change Password (Sample Webapp)', '/sample/jsp/itrust/userchangepassword.jsp', 'URI','NA',null,null, '2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin',1, 1, 'DEF-group-groupA',0,0),
('DEF-res-acm-adduser', 'ACM Add User', '/acm/ua/adduserprocess.do', 'URI','NA',null,null, '2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin',1, 1, 'REQ-group-universal', 1, 1),
('DEF-res-acm-edituser', 'ACM Edit User', '/acm/ua/viewedituserprocess.do', 'URI','NA',null,null, '2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin',1, 1, 'REQ-group-universal', 1, 1),
('DEF-res-acm-deleteuser', 'ACM Delete User', '/acm/ua/deleteuser.do', 'URI','NA',null,null, '2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin',1, 1, 'REQ-group-universal', 1, 1),
('SAM-res-command-addcust', 'Add Customer Command','/custdir/addprocess', 'COMMAND','NA', null,null,'2004-01-01','DEF-user-useradmin','2004-01-01','DEF-user-useradmin',1, 1, 'DEF-group-groupA',1,1),
('SAM-res-command-updcust', 'Update Customer Command','/custdir/vieweditprocess', 'COMMAND','NA',null,null, '2004-01-01','DEF-user-useradmin','2004-01-01','DEF-user-useradmin',1, 1, 'DEF-group-groupA',1,1),
('SAM-res-command-delcust', 'Delete Customer Command','/sample/custdir/delete', 'COMMAND','NA',null,null, '2004-01-01','DEF-user-useradmin','2004-01-01','DEF-user-useradmin',1, 1, 'DEF-group-groupA',1,1),
('MCEBOOK-ADMIN-RES-CREATE-001', 'Add Content', '/mc-ebook-server/mc-ebook-admin/addContent.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-CREATE-002', 'Add Content Process', '/mc-ebook-server/mc-ebook-admin/addContentProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-CREATE-003', 'Add Content Media', '/mc-ebook-server/mc-ebook-admin/addContentMedia.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-CREATE-004', 'Add Content Media Process', '/mc-ebook-server/mc-ebook-admin/addContentMediaProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-CREATE-005', 'Add Content Page', '/mc-ebook-server/mc-ebook-admin/addContentPage.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-CREATE-006', 'Add Content Page Process', '/mc-ebook-server/mc-ebook-admin/addContentPageProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-CREATE-007', 'Add Content Process', '/mc-ebook-server/mc-ebook-admin/addContentProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-CREATE-008', 'Add Content TOC', '/mc-ebook-server/mc-ebook-admin/addContentTOC.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-CREATE-009', 'Add Content TOC Process', '/mc-ebook-server/mc-ebook-admin/addContentTOCProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-CREATE-010', 'Add Essay Hotspot', '/mc-ebook-server/mc-ebook-admin/addEssayHotspot.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-CREATE-011', 'Add Essay Hotspot Process', '/mc-ebook-server/mc-ebook-admin/addEssayHotspotProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-CREATE-012', 'Add Hyperlink Hotspot', '/mc-ebook-server/mc-ebook-admin/addHyperlinkHotspot.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-CREATE-013', 'Add Hyperlink Hotspot Process', '/mc-ebook-server/mc-ebook-admin/addHyperlinkHotspotProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-CREATE-014', 'Add MCQ Hotspot', '/mc-ebook-server/mc-ebook-admin/addMCQHotspot.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-CREATE-015', 'Add MCQ Hotspot Process', '/mc-ebook-server/mc-ebook-admin/addMCQHotspotProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-CREATE-016', 'Add Media Hotspot', '/mc-ebook-server/mc-ebook-admin/addMediaHotspot.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-CREATE-017', 'Add Media Hotspot Process', '/mc-ebook-server/mc-ebook-admin/addMediaHotspotProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-CREATE-018', 'Add Text Hotspot', '/mc-ebook-server/mc-ebook-admin/addTextHotspot.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-CREATE-019', 'Add Text Hotspot Process', '/mc-ebook-server/mc-ebook-admin/addTextHotspotProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-CREATE-020', 'Clone Content', '/mc-ebook-server/mc-ebook-admin/cloneContent.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-CREATE-021', 'Create Publication Content', '/mc-ebook-server/mc-ebook-admin/createPublicationContent.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-CREATE-022', 'Create Publication Content Process', '/mc-ebook-server/mc-ebook-admin/createPublicationContentProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-CREATE-023', 'Delete Content Media', '/mc-ebook-server/mc-ebook-admin/deleteContentMedia.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-CREATE-024', 'Delete Content Page', '/mc-ebook-server/mc-ebook-admin/deleteContentPage.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-CREATE-025', 'Delete Content TOC', '/mc-ebook-server/mc-ebook-admin/deleteContentTOC.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-CREATE-026', 'Delete Hotspot', '/mc-ebook-server/mc-ebook-admin/deleteHotspot.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-CREATE-027', 'Edit Content', '/mc-ebook-server/mc-ebook-admin/editContent.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-CREATE-028', 'Edit Content Media', '/mc-ebook-server/mc-ebook-admin/editContentMedia.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-CREATE-029', 'Edit Content Media Process', '/mc-ebook-server/mc-ebook-admin/editContentMediaProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-CREATE-030', 'Edit Content Process', '/mc-ebook-server/mc-ebook-admin/editContentProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-CREATE-031', 'Edit Content TOC', '/mc-ebook-server/mc-ebook-admin/editContentTOC.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-CREATE-032', 'Edit Content TOC Process', '/mc-ebook-server/mc-ebook-admin/editContentTOCProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-CREATE-033', 'Edit Essay Hotspot', '/mc-ebook-server/mc-ebook-admin/editEssayHotspot.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-CREATE-034', 'Edit Essay Hotspot Process', '/mc-ebook-server/mc-ebook-admin/editEssayHotspotProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-CREATE-035', 'Edit Hotspot', '/mc-ebook-server/mc-ebook-admin/editHotspot.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-CREATE-036', 'Edit Hyperlink Hotspot', '/mc-ebook-server/mc-ebook-admin/editHyperlinkHotspot.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-CREATE-037', 'Edit Hyperlink Hotspot Process', '/mc-ebook-server/mc-ebook-admin/editHyperlinkHotspotProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-CREATE-038', 'Edit MCQ Hotspot', '/mc-ebook-server/mc-ebook-admin/editMCQHotspot.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-CREATE-039', 'Edit MCQ Hotspot Process', '/mc-ebook-server/mc-ebook-admin/editMCQHotspotProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-CREATE-040', 'Edit Media Hotspot', '/mc-ebook-server/mc-ebook-admin/editMediaHotspot.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-CREATE-041', 'Edit Media Hotspot Process', '/mc-ebook-server/mc-ebook-admin/editMediaHotspotProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-CREATE-042', 'Edit Text Hotspot', '/mc-ebook-server/mc-ebook-admin/editTextHotspot.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-CREATE-043', 'Edit Text Hotspot Process', '/mc-ebook-server/mc-ebook-admin/editTextHotspotProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-CREATE-044', 'Export Content', '/mc-ebook-server/mc-ebook-admin/exportContent.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-CREATE-045', 'Import Content', '/mc-ebook-server/mc-ebook-admin/importContent.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-CREATE-046', 'Import Content Process', '/mc-ebook-server/mc-ebook-admin/importContentProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-CREATE-047', 'Replace Content Page', '/mc-ebook-server/mc-ebook-admin/replaceContentPage.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-CREATE-048', 'Replace Content Page Process', '/mc-ebook-server/mc-ebook-admin/replaceContentPageProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-CREATE-049', 'Search Contents', '/mc-ebook-server/mc-ebook-admin/searchContents.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-CREATE-050', 'Search Contents Process', '/mc-ebook-server/mc-ebook-admin/searchContentsProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-CREATE-051', 'View Content', '/mc-ebook-server/mc-ebook-admin/viewContent.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-CREATE-052', 'View Content Page', '/mc-ebook-server/mc-ebook-admin/viewContentPage.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-CREATE-053', 'View Content Page Process', '/mc-ebook-server/mc-ebook-admin/viewContentPageProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-CREATE-054', 'View Essay Hotspot', '/mc-ebook-server/mc-ebook-admin/viewEssayHotspot.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-CREATE-055', 'View Hotspot', '/mc-ebook-server/mc-ebook-admin/viewHotspot.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-CREATE-056', 'View Hyperlink Hotspot', '/mc-ebook-server/mc-ebook-admin/viewHyperlinkHotspot.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-CREATE-057', 'View MCQ Hotspot', '/mc-ebook-server/mc-ebook-admin/viewMCQHotspot.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-CREATE-058', 'View Media Hotspot', '/mc-ebook-server/mc-ebook-admin/viewMediaHotspot.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-CREATE-059', 'View Text Hotspot', '/mc-ebook-server/mc-ebook-admin/viewTextHotspot.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-PUBLISH-001', 'Add Category', '/mc-ebook-server/mc-ebook-admin/addCategory.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-PUBLISH-002', 'Add Category Process', '/mc-ebook-server/mc-ebook-admin/addCategoryProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-PUBLISH-003', 'Add Offer', '/mc-ebook-server/mc-ebook-admin/addOffer.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-PUBLISH-004', 'Add Offer Process', '/mc-ebook-server/mc-ebook-admin/addOfferProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-PUBLISH-005', 'Add Publication Offer', '/mc-ebook-server/mc-ebook-admin/addPublicationOffer.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-PUBLISH-006', 'Add Publication Offer Process', '/mc-ebook-server/mc-ebook-admin/addPublicationOfferProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-PUBLISH-007', 'Delete Category', '/mc-ebook-server/mc-ebook-admin/deleteCategory.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-PUBLISH-008', 'Delete Offer', '/mc-ebook-server/mc-ebook-admin/deleteOffer.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-PUBLISH-009', 'Delete Publication Offer', '/mc-ebook-server/mc-ebook-admin/deletePublicationOffer.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-PUBLISH-010', 'Edit Category', '/mc-ebook-server/mc-ebook-admin/editCategory.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-PUBLISH-011', 'Edit Category Process', '/mc-ebook-server/mc-ebook-admin/editCategoryProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-PUBLISH-012', 'Edit Offer', '/mc-ebook-server/mc-ebook-admin/editOffer.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-PUBLISH-013', 'Edit Offer Process', '/mc-ebook-server/mc-ebook-admin/editOfferProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-PUBLISH-014', 'Edit Publication Categories', '/mc-ebook-server/mc-ebook-admin/editPublicationCategories.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-PUBLISH-015', 'Edit Publication Categories Process', '/mc-ebook-server/mc-ebook-admin/editPublicationCategoriesProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-PUBLISH-016', 'Edit Publication Device', '/mc-ebook-server/mc-ebook-admin/editPublicationDevice.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-PUBLISH-017', 'Edit Publication Device Process', '/mc-ebook-server/mc-ebook-admin/editPublicationDeviceProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-PUBLISH-018', 'Edit Publication Offer', '/mc-ebook-server/mc-ebook-admin/editPublicationOffer.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-PUBLISH-019', 'Edit Publication Offer Process', '/mc-ebook-server/mc-ebook-admin/editPublicationOfferProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-PUBLISH-020', 'Preview Publication', '/mc-ebook-server/mc-ebook-admin/previewPublication.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-PUBLISH-021', 'Preview Publication Process', '/mc-ebook-server/mc-ebook-admin/previewPublicationProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-PUBLISH-022', 'Publish Publication', '/mc-ebook-server/mc-ebook-admin/publishPublication.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-PUBLISH-023', 'Publish Publication Process', '/mc-ebook-server/mc-ebook-admin/publishPublicationProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-PUBLISH-024', 'Search Categories', '/mc-ebook-server/mc-ebook-admin/searchCategories.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-PUBLISH-025', 'Search Categories Process', '/mc-ebook-server/mc-ebook-admin/searchCategoriesProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-PUBLISH-026', 'Search Offers', '/mc-ebook-server/mc-ebook-admin/searchOffers.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-PUBLISH-027', 'Search Offers Process', '/mc-ebook-server/mc-ebook-admin/searchOffersProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-PUBLISH-028', 'Search Publication', '/mc-ebook-server/mc-ebook-admin/searchPublications.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-PUBLISH-029', 'Search Publication Process', '/mc-ebook-server/mc-ebook-admin/searchPublicationsProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-PUBLISH-030', 'View Category', '/mc-ebook-server/mc-ebook-admin/viewCategory.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-PUBLISH-031', 'View Offer', '/mc-ebook-server/mc-ebook-admin/viewOffer.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-PUBLISH-032', 'View Publication', '/mc-ebook-server/mc-ebook-admin/viewPublication.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-MANAGE-001', 'Add Administrator', '/mc-ebook-server/mc-ebook-admin/addAdministrator.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-MANAGE-002', 'Add Administrator Process', '/mc-ebook-server/mc-ebook-admin/addAdministratorProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-MANAGE-003', 'Add Bank Information', '/mc-ebook-server/mc-ebook-admin/addBankInfo.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-MANAGE-004', 'Add Bank Information Process', '/mc-ebook-server/mc-ebook-admin/addBankInfoProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-MANAGE-005', 'Add Contact', '/mc-ebook-server/mc-ebook-admin/addContact.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-MANAGE-006', 'Add Contact Process', '/mc-ebook-server/mc-ebook-admin/addContactProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-MANAGE-007', 'Add MT Users', '/mc-ebook-server/mc-ebook-admin/addMTUser.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-MANAGE-008', 'Add MT Users Process', '/mc-ebook-server/mc-ebook-admin/addMTUserProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-MANAGE-009', 'Add Publisher', '/mc-ebook-server/mc-ebook-admin/addPublisher.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-MANAGE-010', 'Add Publisher Process', '/mc-ebook-server/mc-ebook-admin/addPublishersProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-MANAGE-011', 'Add OU', '/mc-ebook-server/mc-ebook-admin/addOu.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-MANAGE-012', 'Add OU Process', '/mc-ebook-server/mc-ebook-admin/addOuProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-MANAGE-013', 'Add Tenant', '/mc-ebook-server/mc-ebook-admin/addTenant.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-MANAGE-014', 'Add Tenant Process', '/mc-ebook-server/mc-ebook-admin/addTenantProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-MANAGE-015', 'Delete Bank Information', '/mc-ebook-server/mc-ebook-admin/deleteBankInfo.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-MANAGE-016', 'Delete Contact', '/mc-ebook-server/mc-ebook-admin/deleteContact.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-MANAGE-017', 'Delete MT User', '/mc-ebook-server/mc-ebook-admin/deleteMTUsers.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-MANAGE-018', 'Edit Administrator', '/mc-ebook-server/mc-ebook-admin/editAdministrator.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-MANAGE-019', 'Edit Administrator Process', '/mc-ebook-server/mc-ebook-admin/editAdministratorProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-MANAGE-020', 'Edit Bank Information', '/mc-ebook-server/mc-ebook-admin/editBankInfo.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-MANAGE-021', 'Edit Bank Information Process', '/mc-ebook-server/mc-ebook-admin/editBankInfoProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-MANAGE-022', 'Edit Contact', '/mc-ebook-server/mc-ebook-admin/editContact.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-MANAGE-023', 'Edit Contact Process', '/mc-ebook-server/mc-ebook-admin/editContactProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-MANAGE-024', 'Edit MT User', '/mc-ebook-server/mc-ebook-admin/editMTUser.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-MANAGE-025', 'Edit MT User Process', '/mc-ebook-server/mc-ebook-admin/editMTUserProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-MANAGE-026', 'Edit OU', '/mc-ebook-server/mc-ebook-admin/editOu.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-MANAGE-027', 'Edit OU Process', '/mc-ebook-server/mc-ebook-admin/editOuProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-MANAGE-028', 'Edit Publisher', '/mc-ebook-server/mc-ebook-admin/editPublisher.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-MANAGE-029', 'Edit Publihser Process', '/mc-ebook-server/mc-ebook-admin/editPublisherProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-MANAGE-030', 'Mass MT User Creation', '/mc-ebook-server/mc-ebook-admin/massMTUserCreation.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-MANAGE-031', 'Mass MT User Creation Process', '/mc-ebook-server/mc-ebook-admin/massMTUserCreationProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-MANAGE-032', 'Search Administrators', '/mc-ebook-server/mc-ebook-admin/searchAdministrators.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-MANAGE-033', 'Search Administrators Process', '/mc-ebook-server/mc-ebook-admin/searchAdministratorsProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-MANAGE-034', 'Search MT Users', '/mc-ebook-server/mc-ebook-admin/searchMTUsers.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-MANAGE-035', 'Search MT Users Process', '/mc-ebook-server/mc-ebook-admin/searchMTUsersProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-MANAGE-036', 'Search OUs', '/mc-ebook-server/mc-ebook-admin/searchOus.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-MANAGE-037', 'Search OUs Process', '/mc-ebook-server/mc-ebook-admin/searchOusProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-MANAGE-038', 'Search Publishers', '/mc-ebook-server/mc-ebook-admin/searchPublishers.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-MANAGE-039', 'Search Publishers Process', '/mc-ebook-server/mc-ebook-admin/searchPublishersProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-MANAGE-040', 'Search Tenants', '/mc-ebook-server/mc-ebook-admin/searchTenants.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-MANAGE-041', 'Search Tenants Process', '/mc-ebook-server/mc-ebook-admin/searchTenantsProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-MANAGE-044', 'View Thread Comments', '/mc-ebook-server/mc-ebook-admin/viewThreadComments.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-MANAGE-045', 'View Thread Comments Process', '/mc-ebook-server/mc-ebook-admin/viewThreadCommentsProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-MANAGE-046', 'Delete Thread Process', '/mc-ebook-server/mc-ebook-admin/deleteThreadProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-MANAGE-047', 'Delete Thread Comments Process', '/mc-ebook-server/mc-ebook-admin/deleteThreadCommentsProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-MANAGE-048', 'Search Threads', '/mc-ebook-server/mc-ebook-admin/searchThreads.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-MANAGE-049', 'Search Threads Process', '/mc-ebook-server/mc-ebook-admin/searchThreadsProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-MANAGE-050', 'Archive Or Delete Publication', '/mc-ebook-server/mc-ebook-admin/archiveOrDeletePublications.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-MANAGE-051', 'Restore Publication', '/mc-ebook-server/mc-ebook-admin/restorePublications.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-MANAGE-052', 'Custom Labels', '/mc-ebook-server/mc-ebook-admin/searchCustomLabels.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-MANAGE-053', 'Replace Wizard', '/mc-ebook-server/mc-ebook-wizard/searchReplaceContents.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-MANAGE-054', 'Append Wizard', '/mc-ebook-server/mc-ebook-wizard/searchAppendContents.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-MANAGE-055', 'Edit Wizard', '/mc-ebook-server/mc-ebook-wizard/searchEditContents.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-MANAGE-056', 'Account Profile', '/mc-ebook-server/mc-ebook-admin/searchProfiles.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-MANAGE-058', 'Remote Bookstore','/mc-ebook-server/mc-ebook-admin/searchRemoteBookstore.do','URI','NA',NULL,NULL,NOW(),'DEF-user-useradmin',NOW(),'DEF-user-useradmin',1,1,'REQ-group-universal',1,1),
('MCEBOOK-ADMIN-RES-MANAGE-059', 'Remote Consumer','/mc-ebook-server/mc-ebook-admin/searchRemoteConsumer.do','URI','NA',NULL,NULL,NOW(),'DEF-user-useradmin',NOW(),'DEF-user-useradmin',1,1,'REQ-group-universal',1,1),
('MCEBOOK-ADMIN-RES-SETTING-001', 'Configure Settings', '/mc-ebook-server/mc-ebook-admin/configSettings.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-SETTING-002', 'Configure Settings Process', '/mc-ebook-server/mc-ebook-admin/configSettingsProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-SETTING-003', 'Search Website Search Setting', '/mc-ebook-server/mc-ebook-admin/searchWebsiteSearchSetting.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-SETTING-004', 'Search Website Search Setting Process', '/mc-ebook-server/mc-ebook-admin/searchWebsiteSearchSettingProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-SETTING-005', 'Add Website Search Setting', '/mc-ebook-server/mc-ebook-admin/addWebsiteSearchSetting.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-SETTING-006', 'Add Website Search Setting Process', '/mc-ebook-server/mc-ebook-admin/addWebsiteSearchSettingProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-SETTING-007', 'Edit Website Search Setting', '/mc-ebook-server/mc-ebook-admin/editWebsiteSearchSetting.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-SETTING-008', 'Edit Website Search Setting Process', '/mc-ebook-server/mc-ebook-admin/editWebsiteSearchSettingProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-SETTING-009', 'Delete Website Search Setting', '/mc-ebook-server/mc-ebook-admin/deleteWebsiteSearchSetting.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-WIZARD-001', 'Express Wizard', '/mc-ebook-server/mc-ebook-wizard/addSimplePublishContent.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-WIZARD-002', 'Publish Wizard', '/mc-ebook-server/mc-ebook-wizard/addPublishContent.do', 'URI', 'NA', NULL, NULL, NOW(), 'DEF-user-useradmin', NOW(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-WIZARD-003', 'Replace Wizard', '/mc-ebook-server/mc-ebook-wizard/searchReplaceContents.do', 'URI', 'NA', NULL, NULL, NOW(), 'DEF-user-useradmin', NOW(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-WIZARD-004', 'Append Wizard', '/mc-ebook-server/mc-ebook-wizard/searchAppendContents.do', 'URI', 'NA', NULL, NULL, NOW(), 'DEF-user-useradmin', NOW(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-WIZARD-005', 'Search Incomplete Contents', '/mc-ebook-server/mc-ebook-wizard/searchIncompleteContents.do', 'URI', 'NA', NULL, NULL, NOW(), 'DEF-user-useradmin', NOW(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-REPORT-001', 'Download Assignment Report', '/mc-ebook-server/mc-ebook-admin/downloadAssignmentReport.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-REPORT-002', 'Download Assignment Report Process', '/mc-ebook-server/mc-ebook-admin/downloadAssignmentReportProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-REPORT-003', 'Login Report', '/mc-ebook-server/mc-ebook-admin/loginReport.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-REPORT-004', 'Search Download Logs', '/mc-ebook-server/mc-ebook-admin/searchDownloadLogs.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-REPORT-005', 'Search Download Logs Process', '/mc-ebook-server/mc-ebook-admin/searchDownloadLogsProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-REPORT-006', 'Search Request Logs', '/mc-ebook-server/mc-ebook-admin/searchRequestLogs.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-REPORT-007', 'Search Request Logs Process', '/mc-ebook-server/mc-ebook-admin/searchRequestLogsProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-REPORT-008', 'View Download Logs', '/mc-ebook-server/mc-ebook-admin/viewDownloadLog.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-REPORT-009', 'View Request Logs', '/mc-ebook-server/mc-ebook-admin/viewRequestLog.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-REPORT-010', 'View Top Downloads', '/mc-ebook-server/mc-ebook-admin/viewTopDownloads.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-REPORT-011', 'View Top Rated Publications', '/mc-ebook-server/mc-ebook-admin/viewTopRatedPublications.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-REPORT-012', 'Search Book For Essay Questions', '/mc-ebook-server/mc-ebook-admin/searchBookForEssayQuestion.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-REPORT-013', 'Login User Report', '/mc-ebook-server/mc-ebook-admin/loginReport.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-REPORT-014', 'Books Detail Report', '/mc-ebook-server/mc-ebook-admin/bookDetailReport.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-REPORT-015', 'Assignment Submission Download', '/mc-ebook-server/mc-ebook-admin/assignmentSubmissionReport.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-REPORT-016', 'Interview Summary Report', '/mc-ebook-server/mc-ebook-admin/interviewSummaryReport.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-REPORT-017', 'Interview Details Report', '/mc-ebook-server/mc-ebook-admin/interviewDetailsReport.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-REPORT-018', 'Client Login User Report', '/mc-ebook-server/mc-ebook-admin/clientLoginReport.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-REPORT-019','Search Notification Logs','/mc-ebook-server/mc-ebook-admin/searchNotificationLogs.do','URI','NA',NULL,NULL,now(),'DEF-user-useradmin',now(),'DEF-user-useradmin',1,1,'REQ-group-universal',1,1),
('MCEBOOK-ADMIN-RES-REPORT-020','Disk Usage Report','/mc-ebook-server/mc-ebook-admin/diskUsageReport.do','URI','NA',NULL,NULL,NOW(),'DEF-user-useradmin',NOW(),'DEF-user-useradmin',1,1,'REQ-group-universal',1,1),
('MCEBOOK-ADMIN-RES-REPORT-021', 'Interview Rating Report', '/mc-ebook-server/mc-ebook-admin/interviewRatingReport.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-MFRIENDS-001', 'Search mFriends', '/mc-ebook-server/mc-ebook-admin/searchMFriends.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-MFRIENDS-002', 'View mGroups', '/mc-ebook-server/mc-ebook-admin/viewmGroups.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-CLIENT-RES-001', 'Get Category Contents', '/mc-ebook-server/mc-ebook-server/getCategoryContents.do', 'MCEBOOKA', 'NA', NULL, NULL, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-CLIENT-RES-002', 'Get Category Image', '/mc-ebook-server/mc-ebook-server/getCategoryImage.do', 'MCEBOOKA', 'NA', NULL, NULL, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-CLIENT-RES-003', 'Get Child Categories', '/mc-ebook-server/mc-ebook-server/getChildCategories.do', 'MCEBOOKA', 'NA', NULL, NULL, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-CLIENT-RES-004', 'Get Content Cover Page', '/mc-ebook-server/mc-ebook-server/getContentCoverPage.do', 'MCEBOOKA', 'NA', NULL, NULL, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-CLIENT-RES-005', 'Get Content Media', '/mc-ebook-server/mc-ebook-server/getContentMedia.do', 'MCEBOOKA', 'NA', NULL, NULL, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-CLIENT-RES-006', 'Get Content Package', '/mc-ebook-server/mc-ebook-server/getContentPackage.do', 'MCEBOOKA', 'NA', NULL, NULL, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-CLIENT-RES-007', 'Get Content Page', '/mc-ebook-server/mc-ebook-server/getContentPage.do', 'MCEBOOKA', 'NA', NULL, NULL, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-CLIENT-RES-008', 'Get Content Page Image', '/mc-ebook-server/mc-ebook-server/getContentPageImage.do', 'MCEBOOKA', 'NA', NULL, NULL, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-CLIENT-RES-009', 'Get Contents on Offer', '/mc-ebook-server/mc-ebook-server/getContentsOnOffer.do', 'MCEBOOKA', 'NA', NULL, NULL, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-CLIENT-RES-010', 'Get Content Summary Package', '/mc-ebook-server/mc-ebook-server/getContentSummaryPackage.do', 'MCEBOOKA', 'NA', NULL, NULL, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-CLIENT-RES-011', 'Get Hotspot Media', '/mc-ebook-server/mc-ebook-server/getHotspotMedia.do', 'MCEBOOKA', 'NA', NULL, NULL, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-CLIENT-RES-012', 'Get Root Categories', '/mc-ebook-server/mc-ebook-server/getRootCategories.do', 'MCEBOOK', 'NA', NULL, NULL, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-CLIENT-RES-013', 'Get Section Thumbnail', '/mc-ebook-server/mc-ebook-server/getSectionThumbnails.do', 'MCEBOOKA', 'NA', NULL, NULL, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-CLIENT-RES-014', 'Get Subscribed Content Page', '/mc-ebook-server/mc-ebook-server/getSubscribedContentPage.do', 'MCEBOOK', 'NA', NULL, NULL, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-CLIENT-RES-015', 'Make Payment', '/mc-ebook-server/mc-ebook-server/makePayment.do', 'MCEBOOK', 'NA', NULL, NULL, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-CLIENT-RES-016', 'Subscribe', '/mc-ebook-server/mc-ebook-server/subscribe.do', 'MCEBOOK', 'NA', NULL, NULL, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-CLIENT-RES-017', 'Login', '/mc-ebook-server/mc-ebook-server/login.do', 'MCEBOOKA', 'NA', NULL, NULL, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-CLIENT-RES-018', 'Get Subscribed Content Summary Package', '/mc-ebook-server/mc-ebook-server/getSubscribedContentSummaryPackage.do', 'MCEBOOK', 'NA', NULL, NULL, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-CLIENT-RES-019', 'Get Subscribed Content Package', '/mc-ebook-server/mc-ebook-server/getSubscribedContentPackage.do', 'MCEBOOK', 'NA', NULL, NULL, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-CLIENT-RES-020', 'Get Subscribed Content Page Image', '/mc-ebook-server/mc-ebook-server/getSubscribedContentPageImage.do', 'MCEBOOK', 'NA', NULL, NULL, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-CLIENT-RES-021', 'Upload Annotation Package', '/mc-ebook-server/mc-ebook-server/uploadAnnotationPackage.do', 'MCEBOOK', 'NA', NULL, NULL, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-CLIENT-RES-022', 'Add Annotation', '/mc-ebook-server/mc-ebook-server/addAnnotation.do', 'MCEBOOK', 'NA', NULL, NULL, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-CLIENT-RES-023', 'List Annotations', '/mc-ebook-server/mc-ebook-server/listAnnotations.do', 'MCEBOOK', 'NA', NULL, NULL, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-CLIENT-RES-024', 'Add Annotation Comment', '/mc-ebook-server/mc-ebook-server/addAnnotationComment.do', 'MCEBOOK', 'NA', NULL, NULL, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-CLIENT-RES-025', 'Add Rating', '/mc-ebook-server/mc-ebook-admin/addRating.do', 'MCEBOOK', 'NA', NULL, NULL, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-CLIENT-RES-026', 'Submit Assignment', '/mc-ebook-server/mc-ebook-server/submitAssignment.do', 'MCEBOOK', 'NA', NULL, NULL, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-CLIENT-RES-027', 'Result Retrieval', '/mc-ebook-server/mc-ebook-server/resultRetrieval.do', 'MCEBOOK', 'NA', NULL, NULL, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-CLIENT-RES-028', 'Search Books', '/mc-ebook-server/mc-ebook-server/getSearchBooks.do', 'MCEBOOK', 'NA', NULL, NULL, NOW(), 'DEF-user-useradmin', NOW(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-CLIENT-RES-029', 'Get Self Details', '/mc-ebook-server/mc-ebook-server/getSelfDetails.do', 'MCEBOOK', 'NA', NULL, NULL, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-CLIENT-RES-030', 'Get Self OUs', '/mc-ebook-server/mc-ebook-server/getSelfOu.do', 'MCEBOOK', 'NA', NULL, NULL, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-CLIENT-RES-031', 'Get Self Photo', '/mc-ebook-server/mc-ebook-server/getSelfPhoto.do', 'MCEBOOK', 'NA', NULL, NULL, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-CLIENT-RES-032', 'Get Publication Annotation Packages', '/mc-ebook-server/mc-ebook-server/getPublicationAnnotationPackages.do', 'MCEBOOK', 'NA', NULL, NULL, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-CLIENT-RES-033', 'Upload Publication Annotation Package', '/mc-ebook-server/mc-ebook-server/uploadPublicationAnnotationPackage.do', 'MCEBOOK', 'NA', NULL, NULL, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-CLIENT-RES-034', 'Get Available Category Publications', '/mc-ebook-server/mc-ebook-server/getContentsOnOffer.do', 'MCEBOOK', 'NA', NULL, NULL, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-CLIENT-RES-035', 'Check Latest Publication Annotation Packages', '/mc-ebook-server/mc-ebook-server/checkLatestPublicationAnnotationPackages.do', 'MCEBOOK', 'NA', NULL, NULL, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-CLIENT-RES-036', 'Get all sub categories', '/mc-ebook-server/mc-ebook-admin/searchAllSubCategories.do', 'MCEBOOK', 'NA', NULL, NULL, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-CLIENT-RES-037', 'Get Cloud Annotation List', '/mc-ebook-server/mc-ebook-server/getCloudAnnotations.do', 'MCEBOOK', 'NA', NULL, NULL, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-CLIENT-RES-038', 'Upload Cloud Annotation', '/mc-ebook-server/mc-ebook-server/uploadCloudAnnotation.do', 'MCEBOOK', 'NA', NULL, NULL, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-CLIENT-RES-039', 'Get Cloud Annotation', '/mc-ebook-server/mc-ebook-server/getCloudAnnotation.do', 'MCEBOOK', 'NA', NULL, NULL, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-CLIENT-RES-040', 'Update Annotation Like', '/mc-ebook-server/mc-ebook-server/updateAnnotationLike.do', 'MCEBOOK', 'NA', NULL, NULL, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-ACCOUNT-001', 'Change Password', '/mc-ebook-server/mc-ebook-admin/changeAdminPassword.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-ACCOUNT-002', 'Change Password Process', '/mc-ebook-server/mc-ebook-admin/changeAdminPasswordProcess.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-CONFIG-001', 'Server Settings', '/mc-ebook-server/mc-ebook-admin/setServerSetting.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('MCEBOOK-ADMIN-RES-CONFIG-002', 'Client Settings', '/mc-ebook-server/mc-ebook-admin/setClientSetting.do', 'URI', 'NA', null, null, now(), 'DEF-user-useradmin', now(), 'DEF-user-useradmin', 1, 1, 'REQ-group-universal', 1, 1),
('DEF-role-normaluser', 'Normal User Role' ,'-', 'LOG_ROLE', 'NA',null,null, now(),'DEF-user-superadmin',now(),'DEF-user-superadmin',1,1, 'DEF-group-prime',0,0),
('DEF-role-superadmin', 'Super Admin Role' ,'-', 'LOG_ROLE', 'NA',null,null, '2004-01-01','DEF-user-superadmin','2004-01-01','DEF-user-superadmin',1,1, 'DEF-group-prime',0,0),
('DEF-role-tenantadmina', 'Tenant Admin A Role' ,'-', 'LOG_ROLE', 'NA',null,null, '2004-01-01','DEF-user-superadmin','2004-01-01','DEF-user-superadmin',1,1, 'DEF-group-prime',0,0),
('DEF-role-tenantadminb', 'Tenant Admin B Role' ,'-', 'LOG_ROLE', 'NA',null,null, '2004-01-01','DEF-user-superadmin','2004-01-01','DEF-user-superadmin',1,1, 'DEF-group-prime',0,0),
('DEF-role-contentadmin', 'Content Admin Role' ,'-', 'LOG_ROLE', 'NA',null,null, '2004-01-01','DEF-user-superadmin','2004-01-01','DEF-user-superadmin',1,1, 'DEF-group-prime',0,0),
('DEF-role-contentcreator', 'Content Creator Role' ,'-', 'LOG_ROLE', 'NA',null,null, '2004-01-01','DEF-user-superadmin','2004-01-01','DEF-user-superadmin',1,1, 'DEF-group-prime',0,0),
('DEF-role-contentpublisher', 'Content Publisher Role' ,'-', 'LOG_ROLE', 'NA',null,null, '2004-01-01','DEF-user-superadmin','2004-01-01','DEF-user-superadmin',1,1, 'DEF-group-prime',0,0),
('DEF-role-moderator', 'Moderator Role' ,'-', 'LOG_ROLE', 'NA',null, null, '2004-01-01','DEF-user-superadmin','2004-01-01','DEF-user-superadmin',1,1, 'DEF-group-prime',0,0),
('DEF-role-facilitator', 'Facilitator Role' ,'-', 'LOG_ROLE', 'NA',null, null, '2004-01-01','DEF-user-superadmin','2004-01-01','DEF-user-superadmin',1,1, 'DEF-group-prime',0,0);

/*
-----------------------------------------------
-- Insert of TBL_MC_STORE
-----------------------------------------------
*/
INSERT INTO TBL_MC_STORE
(`STORE_ID`, `STORE_NAME`, `STORE_DESC`, `TENANT_ID`, `CREATED_BY`, `CREATED_DT`, `UPDATED_BY`, `UPDATED_DT`, `VERSION`)
VALUES
('DEF-store-prime', 'Prime Store', 'Prime Store', 'DEF-tenant-prime', 'DEF-user-superadmin', NOW(), 'DEF-user-superadmin', NOW(), 1);

/*
-----------------------------------------------
-- Insert of TBL_AA_GROUP2RES
-----------------------------------------------
*/
INSERT INTO TBL_AA_GROUP2RES
(`GROUP_ID`, `RESOURCES_ID`, `AUTHORITY_ID`, `READ_ACCESS`, `CREATE_ACCESS`, `UPDATE_ACCESS`, `DELETE_ACCESS`, `EFFECTIVE_DT`, `EXPIRY_DT`, `CREATED_DT`, `CREATED_BY`, `UPDATED_DT`, `UPDATED_BY`, `VERSION`, `REF_GROUP_ID`)
VALUES
( 'REQ-group-universal', 'DEF-res-code-add', 'NA','1', '1', '1', '1', null, null, '2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin', 1, 'REQ-group-universal'),
( 'REQ-group-universal', 'DEF-res-code-codeType', 'NA','1', '1', '1', '1', null, null, '2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin', 1, 'REQ-group-universal');

/*
-----------------------------------------------
-- Insert of TBL_AA_RES2RES
-----------------------------------------------
*/
INSERT INTO TBL_AA_RES2RES
(`RESOURCES_ID`, `PARENT_RES_ID`, `CREATE_ACCESS`, `READ_ACCESS`, `UPDATE_ACCESS`, `DELETE_ACCESS`, `EFFECTIVE_DT`, `EXPIRY_DT`, `CREATED_DT`, `CREATED_BY`, `UPDATED_DT`, `UPDATED_BY`, `VERSION`, `REF_GROUP_ID`)
VALUES
('MCEBOOK-ADMIN-RES-REPORT-001', 'DEF-role-moderator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-002', 'DEF-role-moderator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-012', 'DEF-role-moderator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-015', 'DEF-role-moderator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-ACCOUNT-001', 'DEF-role-moderator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-ACCOUNT-002', 'DEF-role-moderator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-WIZARD-001', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-WIZARD-002', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-WIZARD-003', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-WIZARD-004', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-WIZARD-005', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-055', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-053', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-054', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-049', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-045', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-024', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-026', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-028', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-050', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-051', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-038', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-ACCOUNT-001', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-048', 'DEF-role-facilitator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-ACCOUNT-001', 'DEF-role-facilitator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-WIZARD-001', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-WIZARD-002', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-WIZARD-003', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-WIZARD-004', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-WIZARD-005', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-055', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-053', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-054', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-049', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-045', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-024', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-026', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-028', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-050', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-051', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CONFIG-001', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CONFIG-002', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-056', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-052', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-013', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-014', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-015', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-012', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-040', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-036', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-038', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-032', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-034', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-048', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-010', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-011', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-004', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-006', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-ACCOUNT-001', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-WIZARD-001', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-WIZARD-002', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-WIZARD-003', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-WIZARD-004', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-WIZARD-005', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-055', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-053', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-054', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-049', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-045', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-024', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-026', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-028', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-050', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-051', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CONFIG-001', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CONFIG-002', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-056', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-052', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-013', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-014', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-015', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-012', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-036', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-038', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-032', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-034', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-048', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-010', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-011', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-004', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-006', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-ACCOUNT-001', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-034', 'DEF-role-useradmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-ACCOUNT-001', 'DEF-role-useradmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-ACCOUNT-001', 'DEF-role-normaluser', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-049', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-045', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-ACCOUNT-001', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-024', 'DEF-role-contentpublisher', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-026', 'DEF-role-contentpublisher', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-028', 'DEF-role-contentpublisher', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-050', 'DEF-role-contentpublisher', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-051', 'DEF-role-contentpublisher', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-038', 'DEF-role-contentpublisher', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-ACCOUNT-001', 'DEF-role-contentpublisher', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CONFIG-001', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CONFIG-002', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-056', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-052', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-013', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-014', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-015', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-012', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-040', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-036', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-038', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-032', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-034', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-048', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-010', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-011', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-004', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-006', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-ACCOUNT-001', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-001', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-002', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-003', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-004', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-005', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-006', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-007', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-008', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-009', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-010', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-011', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-012', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-013', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-014', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-015', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-016', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-017', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-018', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-019', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-020', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-021', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-022', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-023', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-024', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-025', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-026', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-027', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-028', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-029', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-030', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-031', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-032', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-033', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-034', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-035', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-036', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-037', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-038', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-039', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-040', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-041', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-042', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-043', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-044', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-046', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-047', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-048', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-050', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-051', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-052', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-053', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-054', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-055', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-056', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-057', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-058', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-059', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-001', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-002', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-003', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-004', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-005', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-006', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-007', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-008', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-009', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-010', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-011', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-012', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-013', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-014', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-015', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-016', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-017', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-018', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-019', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-020', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-021', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-022', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-023', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-025', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-027', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-029', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-030', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-031', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-032', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-001', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-002', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-003', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-004', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-005', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-006', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-007', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-008', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-009', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-010', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-011', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-012', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-013', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-014', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-015', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-016', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-017', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-018', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-019', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-020', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-021', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-022', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-023', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-024', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-025', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-026', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-027', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-028', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-029', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-030', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-031', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-033', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-035', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-037', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-039', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-041', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-044', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-045', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-046', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-047', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-049', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-SETTING-001', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-SETTING-002', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-SETTING-003', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-SETTING-004', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-SETTING-005', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-SETTING-006', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-SETTING-007', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-SETTING-008', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-SETTING-009', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-001', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-002', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-003', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-005', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-007', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-008', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-009', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-ACCOUNT-002', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-001', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-002', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-003', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-004', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-005', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-006', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-007', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-008', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-009', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-010', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-011', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-012', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-013', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-014', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-015', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-016', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-017', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-018', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-019', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-020', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-021', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-022', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-023', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-024', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-025', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-026', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-027', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-028', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-029', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-030', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-031', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-032', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-033', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-034', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-035', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-036', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-037', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-038', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-039', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-040', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-041', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-042', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-043', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-044', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-046', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-047', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-048', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-050', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-051', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-052', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-053', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-054', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-055', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-056', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-057', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-058', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-059', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-001', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-002', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-003', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-004', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-005', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-006', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-007', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-008', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-009', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-010', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-011', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-012', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-013', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-014', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-015', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-016', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-017', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-018', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-019', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-020', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-021', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-022', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-023', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-025', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-027', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-029', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-030', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-031', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-032', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-ACCOUNT-002', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-001', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-002', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-003', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-004', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-005', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-006', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-007', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-008', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-009', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-010', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-011', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-012', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-013', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-014', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-015', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-016', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-017', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-018', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-019', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-020', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-021', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-022', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-023', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-024', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-025', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-026', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-027', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-028', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-029', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-030', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-031', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-032', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-033', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-034', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-035', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-036', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-037', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-038', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-039', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-040', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-041', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-042', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-043', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-044', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-046', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-047', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-048', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-050', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-051', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-052', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-053', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-054', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-055', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-056', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-057', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-058', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-059', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-001', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-002', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-003', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-004', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-005', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-006', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-007', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-008', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-009', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-010', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-011', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-012', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-013', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-014', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-015', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-016', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-017', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-018', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-019', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-020', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-021', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-022', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-023', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-025', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-027', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-029', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-030', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-031', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-032', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-001', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-002', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-003', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-004', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-005', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-006', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-007', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-008', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-009', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-010', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-011', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-012', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-013', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-014', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-015', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-016', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-017', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-018', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-019', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-020', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-021', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-022', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-023', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-024', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-025', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-026', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-027', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-028', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-029', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-030', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-031', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-033', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-035', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-037', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-039', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-044', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-045', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-046', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-047', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-049', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-SETTING-001', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-SETTING-002', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-SETTING-003', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-SETTING-004', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-SETTING-005', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-SETTING-006', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-SETTING-007', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-SETTING-008', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-SETTING-009', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-001', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-002', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-003', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-005', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-007', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-008', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-009', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-ACCOUNT-002', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-044', 'DEF-role-facilitator', '1', '1', '1', '1', NULL, NULL, NOW(), 'DEF-user-superadmin', NOW(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-045', 'DEF-role-facilitator', '1', '1', '1', '1', NULL, NULL, NOW(), 'DEF-user-superadmin', NOW(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-046', 'DEF-role-facilitator', '1', '1', '1', '1', NULL, NULL, NOW(), 'DEF-user-superadmin', NOW(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-047', 'DEF-role-facilitator', '1', '1', '1', '1', NULL, NULL, NOW(), 'DEF-user-superadmin', NOW(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-049', 'DEF-role-facilitator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-ACCOUNT-002', 'DEF-role-facilitator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-001', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-002', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-003', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-004', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-005', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-006', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-007', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-008', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-009', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-010', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-011', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-012', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-013', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-014', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-015', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-016', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-017', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-018', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-019', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-020', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-021', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-022', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-023', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-024', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-025', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-026', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-027', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-028', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-029', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-030', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-031', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-032', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-033', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-034', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-035', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-036', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-037', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-038', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-039', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-040', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-041', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-042', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-043', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-044', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-046', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-047', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-048', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-050', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-051', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-052', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-053', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-054', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-055', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-056', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-057', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-058', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-059', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-WIZARD-003', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, NOW(), 'DEF-user-superadmin', NOW(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-WIZARD-004', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, NOW(), 'DEF-user-superadmin', NOW(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-WIZARD-005', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, NOW(), 'DEF-user-superadmin', NOW(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-ACCOUNT-002', 'DEF-role-contentcreator ', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-001', 'DEF-role-contentpublisher', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-002', 'DEF-role-contentpublisher', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-003', 'DEF-role-contentpublisher', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-004', 'DEF-role-contentpublisher', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-005', 'DEF-role-contentpublisher', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-006', 'DEF-role-contentpublisher', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-007', 'DEF-role-contentpublisher', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-008', 'DEF-role-contentpublisher', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-009', 'DEF-role-contentpublisher', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-010', 'DEF-role-contentpublisher', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-011', 'DEF-role-contentpublisher', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-012', 'DEF-role-contentpublisher', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-013', 'DEF-role-contentpublisher', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-014', 'DEF-role-contentpublisher', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-015', 'DEF-role-contentpublisher', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-016', 'DEF-role-contentpublisher', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-017', 'DEF-role-contentpublisher', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-018', 'DEF-role-contentpublisher', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-019', 'DEF-role-contentpublisher', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-020', 'DEF-role-contentpublisher', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-021', 'DEF-role-contentpublisher', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-022', 'DEF-role-contentpublisher', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-023', 'DEF-role-contentpublisher', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-025', 'DEF-role-contentpublisher', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-027', 'DEF-role-contentpublisher', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-029', 'DEF-role-contentpublisher', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-030', 'DEF-role-contentpublisher', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-031', 'DEF-role-contentpublisher', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-032', 'DEF-role-contentpublisher', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-WIZARD-003', 'DEF-role-contentpublisher', '1', '1', '1', '1', NULL, NULL, NOW(), 'DEF-user-superadmin', NOW(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-WIZARD-004', 'DEF-role-contentpublisher', '1', '1', '1', '1', NULL, NULL, NOW(), 'DEF-user-superadmin', NOW(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-WIZARD-005', 'DEF-role-contentpublisher', '1', '1', '1', '1', NULL, NULL, NOW(), 'DEF-user-superadmin', NOW(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-ACCOUNT-002', 'DEF-role-contentpublisher', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-001', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-002', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-003', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-004', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-005', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-006', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-007', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-008', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-009', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-010', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-011', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-012', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-013', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-014', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-015', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-016', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-017', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-018', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-019', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-020', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-021', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-022', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-023', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-024', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-025', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-026', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-027', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-028', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-029', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-030', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-031', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-032', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-033', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-034', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-035', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-036', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-037', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-038', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-039', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-040', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-041', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-042', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-043', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-044', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-046', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-047', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-048', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-050', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-051', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-052', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-053', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-054', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-055', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-056', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-057', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-058', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-CREATE-059', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-001', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-002', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-003', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-004', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-005', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-006', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-007', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-008', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-009', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-010', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-011', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-012', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-013', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-014', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-015', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-016', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-017', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-018', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-019', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-020', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-021', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-022', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-023', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-025', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-027', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-029', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-030', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-031', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-PUBLISH-032', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-001', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-002', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-003', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-004', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-005', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-006', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-007', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-008', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-009', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-010', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-011', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-012', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-013', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-014', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-015', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-016', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-017', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-018', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-019', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-020', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-021', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-022', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-023', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-024', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-025', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-026', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-027', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-028', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-029', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-030', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-031', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-033', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-035', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-037', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-039', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-044', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-045', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-046', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-047', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-049', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-SETTING-001', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-SETTING-002', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-SETTING-003', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-SETTING-004', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-SETTING-005', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-SETTING-006', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-SETTING-007', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-SETTING-008', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-SETTING-009', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-001', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-002', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-003', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-005', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-007', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-008', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-009', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-ACCOUNT-002', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-035', 'DEF-role-useradmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-007', 'DEF-role-useradmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-030', 'DEF-role-useradmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-ACCOUNT-002', 'DEF-role-useradmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-008', 'DEF-role-useradmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-024', 'DEF-role-useradmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-ACCOUNT-002', 'DEF-role-normaluser', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-018', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-018', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-018', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, now(), 'DEF-user-superadmin', now(), 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-019','DEF-role-tenantadmina','1','1','1','1',NULL,NULL,now(),'DEF-user-superadmin',now(),'DEF-user-superadmin','1','REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-019','DEF-role-tenantadminb','1','1','1','1',NULL,NULL,now(),'DEF-user-superadmin',now(),'DEF-user-superadmin','1','REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-019','DEF-role-superadmin','1','1','1','1',NULL,NULL,now(),'DEF-user-superadmin',now(),'DEF-user-superadmin','1','REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-058','DEF-role-superadmin','1','1','1','1',NULL,NULL,NOW(),'DEF-user-superadmin',NOW(),'DEF-user-superadmin','1','REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-058','DEF-role-tenantadmina','1','1','1','1',NULL,NULL,NOW(),'DEF-user-superadmin',NOW(),'DEF-user-superadmin','1','REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-058','DEF-role-tenantadminb','1','1','1','1',NULL,NULL,NOW(),'DEF-user-superadmin',NOW(),'DEF-user-superadmin','1','REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-059','DEF-role-superadmin','1','1','1','1',NULL,NULL,NOW(),'DEF-user-superadmin',NOW(),'DEF-user-superadmin','1','REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-059','DEF-role-tenantadmina','1','1','1','1',NULL,NULL,NOW(),'DEF-user-superadmin',NOW(),'DEF-user-superadmin','1','REQ-group-universal'),
('MCEBOOK-ADMIN-RES-MANAGE-059','DEF-role-tenantadminb','1','1','1','1',NULL,NULL,NOW(),'DEF-user-superadmin',NOW(),'DEF-user-superadmin','1','REQ-group-universal'),
('MCEBOOK-ADMIN-RES-REPORT-020','DEF-role-superadmin','1','1','1','1',NULL,NULL,NOW(),'DEF-user-superadmin',NOW(),'DEF-user-superadmin','1','REQ-group-universal');

/*
-----------------------------------------------
-- Insert of TBL_CODETYPE
-----------------------------------------------
*/
INSERT INTO TBL_CODETYPE
(`CODETYPE_ID`, `CODETYPE_DESC`, `CODETYPE_TABLE`, `READ_ONLY`, `COL_CODETYPE_ID`, `COL_CODE_ID`, `COL_CODE_DESC`, `COL_CODE_SEQ`, `COL_STATUS`, `COL_EFFECTIVE_DT`, `COL_EXPIRY_DT`, `EDIT_URL`, `ADD_URL`, `OWNER_GROUP`, `UPDATED_BY`, `UPDATED_DT`, `COL_CODE_LOCALE`)
VALUES
('acm_res', 'ACM Resources Type', 'TBL_CODE_INT', 'Y', 'CODETYPE_ID', 'CODE_ID', 'CODE_DESC', 'CODE_SEQ', '', '', '', '/codeadmin/viewedit_int.do', '', 'DEF-group-groupA', '', now(), 'LOCALE'),
('loginType', 'loginType', 'TBL_CODE_INT', 'Y', 'CODETYPE_ID', 'CODE_ID', 'CODE_DESC', 'CODE_SEQ', '', '', '', '/codeadmin/viewedit_int.do', '', 'DEF-group-groupA', '', now(), 'LOCALE'),
('PageSize', 'PageSize', 'TBL_CODE_INT', 'N', 'CODETYPE_ID', 'CODE_ID', 'CODE_DESC', 'CODE_SEQ', '', '', '', '', '', '', '', now(), 'LOCALE'),
('EBOOK-CONTENT-STATUS', 'EBOOK-CONTENT-STATUS', 'TBL_CODE_INT', 'N', 'CODETYPE_ID', 'CODE_ID', 'CODE_DESC', 'CODE_SEQ', '', '', '', '', '', '', '', now(), 'LOCALE'),
('EBOOK-CONTENT-FORMAT', 'EBOOK-CONTENT-FORMAT', 'TBL_CODE_INT', 'N', 'CODETYPE_ID', 'CODE_ID', 'CODE_DESC', 'CODE_SEQ', '', '', '', '', '', '', '', now(), 'LOCALE'),
('EBOOK-CONTENT-TYPE', 'EBOOK-CONTENT-TYPE', 'TBL_CODE_INT', 'N', 'CODETYPE_ID', 'CODE_ID', 'CODE_DESC', 'CODE_SEQ', '', '', '', '', '', '', '', now(), 'LOCALE'),
('EBOOK-TOC-TYPE', 'EBOOK-TOC-TYPE', 'TBL_CODE_INT', 'N', 'CODETYPE_ID', 'CODE_ID', 'CODE_DESC', 'CODE_SEQ', '', '', '', '', '', '', '', now(), 'LOCALE'),
('EBOOK-HOTSPOT-TYPE', 'EBOOK-HOTSPOT-TYPE', 'TBL_CODE_INT', 'N', 'CODETYPE_ID', 'CODE_ID', 'CODE_DESC', 'CODE_SEQ', '', '', '', '', '', '', '', now(), 'LOCALE'),
('EBOOK-HSTYPE-MEDIA', 'EBOOK-HSTYPE-MEDIA', 'TBL_CODE_INT', 'N', 'CODETYPE_ID', 'CODE_ID', 'CODE_DESC', 'CODE_SEQ', '', '', '', '', '', '', '', now(), 'LOCALE'),
('EBOOK-USER-STATUS', 'EBOOK-USER-STATUS', 'TBL_CODE_INT', 'N', 'CODETYPE_ID', 'CODE_ID', 'CODE_DESC', 'CODE_SEQ', '', '', '', '', '', '', '', now(), 'LOCALE'),
('EBOOK-USER-ACTIVATED', 'EBOOK-USER-ACTIVATED', 'TBL_CODE_INT', 'N', 'CODETYPE_ID', 'CODE_ID', 'CODE_DESC', 'CODE_SEQ', '', '', '', '', '', '', '', now(), 'LOCALE'),
('EBOOK-REQ-LOG-TYPE', 'EBOOK-REQ-LOG-TYPE', 'TBL_CODE_INT', 'N', 'CODETYPE_ID', 'CODE_ID', 'CODE_DESC', 'CODE_SEQ', '', '', '', '', '', '', '', now(), 'LOCALE'),
('EBOOK-REQ-DL-TYPE', 'EBOOK-REQ-DL-TYPE', 'TBL_CODE_INT', 'N', 'CODETYPE_ID', 'CODE_ID', 'CODE_DESC', 'CODE_SEQ', '', '', '', '', '', '', '', now(), 'LOCALE'),
('EBOOK-DL-RET-STATUS', 'EBOOK-DL-RET-STATUS', 'TBL_CODE_INT', 'N', 'CODETYPE_ID', 'CODE_ID', 'CODE_DESC', 'CODE_SEQ', '', '', '', '', '', '', '', now(), 'LOCALE'),
('EBOOK-DISPLAY-TYPE', 'EBOOK-HOTSPOT-TYPE', 'TBL_CODE_INT', 'N', 'CODETYPE_ID', 'CODE_ID', 'CODE_DESC', 'CODE_SEQ','', '', '', '', '', '', '', NOW(), 'LOCALE'),
('EBOOK-HYPERLINK-TYPE', 'EBOOK-HYPERLINK-TYPE', 'TBL_CODE_INT', 'Y', 'CODETYPE_ID', 'CODE_ID', 'CODE_DESC', 'CODE_SEQ', '', '', '', '', '', '', '', now(), 'LOCALE'),
('EBOOK-VIDEO-AUTOPALY-TYPE','EBOOK-VIDEO-AUTOPALY-TYPE','TBL_CODE_INT','Y','CODETYPE_ID','CODE_ID','CODE_DESC','CODE_SEQ',null,null,null,null,null,null,null,null,null),
('EBOOK-ASSIGNMENT_MARK_TYPE', 'Assignment Marking Type', 'TBL_CODE_INT', 'N', 'CODETYPE_ID', 'CODE_ID', 'CODE_DESC', 'CODE_SEQ', '', '', '', '', '', '', '', now(), 'LOCALE'),
('EBOOK-ATTACHMENT-TYPE', 'EBOOK-ATTACHMENT-TYPE', 'TBL_CODE_INT', 'Y', 'CODETYPE_ID', 'CODE_ID', 'CODE_DESC', 'CODE_SEQ', '', '', '', '', '', '', '', now(), 'LOCALE'),
('EBOOK-BOOKSTORE-STATUS','EBOOK-BOOKSTORE-STATUS','TBL_CODE_INT','N','CODETYPE_ID','CODE_ID','CODE_DESC','CODE_SEQ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NOW(),'LOCALE'),
('EBOOK-NOTIFICATION-LOG-STATUS','EBOOK-NOTIFICATION-LOG-STATUS','TBL_CODE_INT','N','CODETYPE_ID','CODE_ID','CODE_DESC','CODE_SEQ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NOW(),'LOCALE'),
('EBOOK-NOTIFICATION-MSG-TP','EBOOK-NOTIFICATION-MSG-TP','TBL_CODE_INT','N','CODETYPE_ID','CODE_ID','CODE_DESC','CODE_SEQ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NOW(),'LOCALE');

/*
-----------------------------------------------
-- Insert of TBL_CODE_INT
-----------------------------------------------
*/
INSERT INTO TBL_CODE_INT
(`CODETYPE_ID`, `CODE_ID`, `CODE_DESC`, `CODE_SEQ`, `STATUS`, `EFFECTIVE_DT`, `EXPIRY_DT`, `UPDATED_BY`, `UPDATED_DT`, `LOCALE`)
VALUES
('PageSize', '10', '10 items per page', 2, 'A', NULL, NULL, NULL, NULL, 'en'),
('PageSize', '15', '15 items per page', 3, 'A', NULL, NULL, NULL, NULL, 'en'),
('PageSize', '5', '5 items per Page', 1, 'A', NULL, NULL, NULL, NULL, 'en'),
( 'acm_res', 'URI', 'URI', 1, 'A', now(), '2008-1-1', '', now(), 'en' ),
( 'acm_res', 'JSP_TAG', 'Jsp Tag', 2, 'A', now(), '2008-1-1', '', now(), 'en' ),
( 'acm_res', 'iPortal', 'iPortal Page ID', 3, 'A', now(), '2008-1-1', '', now(), 'en' ),
( 'acm_res', 'LOG_ROLE', 'Logical Roles', 4, 'A', now(), '2008-1-1', '', now(), 'en' ),
( 'acm_res', 'LOG_NAME', 'Collection', 5, 'A', now(), '2008-1-1', '', now(), 'en' ),
( 'acm_res', 'DOC_TYPE', 'Document Type', 6, 'A', now(), '2008-1-1', '', now(), 'en' ),
( 'acm_res', 'SEC_ROLE', 'Security Roles', 7, 'A', now(), '2008-1-1', '', now(), 'en' ),
( 'loginType', 'PASSWORD', 'Password Login', 1, 'A', now(), '2008-1-1', '', now(), 'en' ),
( 'loginType', 'SINGPASS', 'Singpass Login', 2, 'A', now(), '2008-1-1', '', now(), 'en' ),
( 'loginType', 'SINGPASS_EASY', 'Singpass With Easy Login', 3, 'A', now(), '2008-1-1', '', now(), 'en' ),
( 'loginType', 'NETRUST', 'Netrust Login', 4, 'A', now(), '2008-1-1', '', now(), 'en' ),
( 'loginType', 'KERBEROS', 'Kerberos Login', 5, 'A', now(), '2008-1-1', '', now(), 'en' ),
( 'loginType', 'CONTAINER', 'Container Login', 6, 'A', now(), '2008-1-1', '', now(), 'en' ),
( 'loginType', 'LDAP', 'LDAP Login', 7, 'A', now(), '2008-1-1', '', now(), 'en' ),
( 'loginType', 'OPENSSO', 'OPENSSO Login', 8, 'A', now(), '2008-1-1', '', now(), 'en' ),
('EBOOK-CONTENT-STATUS', 'U', 'Uploaded', 1, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-CONTENT-STATUS', 'C', 'Processing', 2, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-CONTENT-STATUS', 'R', 'Draft', 3, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-CONTENT-STATUS', 'REV', 'In Review', 4, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-CONTENT-STATUS', 'V', 'Pending Release', 5, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-CONTENT-STATUS', 'CPV', 'Preview Confirmation', 6, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-CONTENT-STATUS', 'CPB', 'Publish Confirmation', 7, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-CONTENT-STATUS', 'W', 'Previewing', 8, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-CONTENT-STATUS', 'P', 'Published', 9, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-CONTENT-FORMAT', 'P', 'PDF', 1, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-CONTENT-FORMAT', 'H', 'HTML', 2, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-CONTENT-FORMAT', 'G', 'PNG', 3, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-CONTENT-TYPE', 'BK', 'Book', 1, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-CONTENT-TYPE', 'PS', 'Presentation', 2, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-CONTENT-TYPE', 'VBK', 'Video Presentation', 3, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-CONTENT-TYPE', 'IA', 'Individual Assignment', 4, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-CONTENT-TYPE', 'ABK', 'Audio Presentation', 5, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-TOC-TYPE', 'C', 'Chapter', 1, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-TOC-TYPE', 'S', 'Section', 1, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-HOTSPOT-TYPE', '01', 'Video', 1, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-HOTSPOT-TYPE', '02', 'Audio', 2, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-HOTSPOT-TYPE', '03', 'Image', 3, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-HOTSPOT-TYPE', '04', 'Text', 4, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-HOTSPOT-TYPE', '05', 'Hyperlink', 5, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-HOTSPOT-TYPE', '06', 'MCQ Choice', 6, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-HOTSPOT-TYPE', '07', 'MCQ Answer', 7, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-HOTSPOT-TYPE', '08', 'Essay Question', 8, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-HOTSPOT-TYPE', '09', 'Html5', 9, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-HSTYPE-MEDIA', '01', 'Video', 1, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-HSTYPE-MEDIA', '02', 'Audio', 2, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-HSTYPE-MEDIA', '03', 'Image', 3, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-USER-STATUS', 'A', 'Active', 1, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-USER-STATUS', 'D', 'Disabled', 2, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-USER-STATUS', 'P', 'Pending Activation', 1, '3', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-USER-ACTIVATED', 'Y', 'Activated', 1, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-USER-ACTIVATED', 'N', 'Not Activated', 2, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-REQ-LOG-TYPE', 'PAYMENT', 'Payment', 1, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-REQ-LOG-TYPE', 'SUBSCRIBE', 'Subscribe', 2, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-REQ-LOG-TYPE', 'VERIFY_RECEIPT', 'Verify Receipt', 3, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-REQ-DL-TYPE', '01', 'Content Package', 1, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-REQ-DL-TYPE', '02', 'Content Summary Package', 2, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-REQ-DL-TYPE', '03', 'Content Page', 3, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-REQ-DL-TYPE', '04', 'Content Page Image', 4, 'A', NULL, NULL, NULL, NULL, 'en'), 
('EBOOK-DL-RET-STATUS', '100', 'Success', 1, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-DL-RET-STATUS', '201', 'Invalid arguments', 2, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-DL-RET-STATUS', '202', 'Invalid subscription', 3, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-DL-RET-STATUS', '203', 'Invalid offer', 4, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-DL-RET-STATUS', '204', 'Invalid publication to offer mapping', 5, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-DL-RET-STATUS', '205', 'Publication not available for viewing yet under subscribed offer', 6, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-DL-RET-STATUS', '206', 'Publication no longer available for viewing under subscribed offer', 7, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-DL-RET-STATUS', '207', 'Subscription start date is after offer end date', 8, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-DL-RET-STATUS', '208', 'Subscription end date is before offer start date', 9, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-DL-RET-STATUS', '209', 'Wrong subscriber', 10, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-DL-RET-STATUS', '210', 'Publication not found', 11, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-DL-RET-STATUS', '211', 'Access denied', 12, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-DL-RET-STATUS', '999', 'General error', 13, 'A', NULL, NULL, NULL, NULL, 'en'), 
('EBOOK-DISPLAY-TYPE', 'N', 'Normal', 1, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-DISPLAY-TYPE', 'I', 'Inline', 2, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-HYPERLINK-TYPE', 'DEFAULT', 'Default', 1, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-HYPERLINK-TYPE', 'YOUTUBE', 'YouTube', 2, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-HYPERLINK-TYPE', 'FACEBOOK', 'FaceBook', 3, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-HYPERLINK-TYPE', 'TWITTER', 'Twitter', 4, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-ASSIGNMENT_MARK_TYPE', 'S', 'Submitted', 1, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-ASSIGNMENT_MARK_TYPE', 'M', 'Marked', 2, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-ASSIGNMENT_MARK_TYPE', 'A', 'Announced', 3, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-ATTACHMENT-TYPE', '01', 'HTML5', 1, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-ATTACHMENT-TYPE', '02', 'Flash', 2, 'A', NULL, NULL, NULL, NULL, 'en'),
('EBOOK-NOTIFICATION-LOG-STATUS','A','Pending','1','A',NULL,NULL,NULL,NULL,'en'),
('EBOOK-NOTIFICATION-LOG-STATUS','D','Delivered','2','A',NULL,NULL,NULL,NULL,'en'),
('EBOOK-NOTIFICATION-LOG-STATUS','F','Failed','1','A',NULL,NULL,NULL,NULL,'en'),
('EBOOK-NOTIFICATION-MSG-TP','01','Publication new','1','A',NULL,NULL,NULL,NULL,'en'),
('EBOOK-NOTIFICATION-MSG-TP','02','Publication revision','2','A',NULL,NULL,NULL,NULL,'en'),
('EBOOK-NOTIFICATION-MSG-TP','03','Schedule publication new','1','A',NULL,NULL,NULL,NULL,'en'),
('EBOOK-NOTIFICATION-MSG-TP','04','Schedule publication revision','2','A',NULL,NULL,NULL,NULL,'en'),
('EBOOK-BOOKSTORE-STATUS','ALL','Any','1','A',NULL,NULL,NULL,NULL,'en'),
('EBOOK-BOOKSTORE-STATUS','PA','Pending Remote Approval','2','A',NULL,NULL,NULL,NULL,'en'),
('EBOOK-BOOKSTORE-STATUS','PC','Pending Home Confirmation','3','A',NULL,NULL,NULL,NULL,'en'),
('EBOOK-BOOKSTORE-STATUS','ACT','Activated','4','A',NULL,NULL,NULL,NULL,'en'),
('EBOOK-BOOKSTORE-STATUS','REJ','Rejected','5','A',NULL,NULL,NULL,NULL,'en'),
('EBOOK-VIDEO-AUTOPALY-TYPE','DEFAULT','Default',1,'A',null,null,'',null,'en'),
('EBOOK-VIDEO-AUTOPALY-TYPE','AUTO_PLAY','Auto Play',2,'A',null,null,'',null,'en');

/*
-----------------------------------------------
-- Insert of TBL_AA_SUBJECT2GROUP
-----------------------------------------------
*/
INSERT INTO TBL_AA_SUBJECT2GROUP
(`SUBJECT_ID`, `GROUP_ID`, `AUTHORITY_ID`, `CREATED_DT`, `CREATED_BY`, `UPDATED_DT`, `UPDATED_BY`, `VERSION`)
VALUES
('DEF-user-roleadmin', 'REQ-group-universal','NA','2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin', 1),
('DEF-user-useradmin', 'REQ-group-universal', 'NA','2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin', 1),
('DEF-user-siteadmin', 'DEF-group-groupA','NA', '2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin', 1),
('SAM-user-user1', 'DEF-group-groupA','NA', '2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin', 1),
('SAM-user-user2', 'SAM-group-groupB', 'NA','2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin', 1),
('SAM-user-userA1', 'SAM-group-groupA1','NA', '2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin', 1),
('SAM-user-userA2', 'SAM-group-groupA2','NA', '2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin', 1),
('SAM-user-userB1', 'SAM-group-groupB1', 'NA','2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin', 1),
('SAM-user-userB2', 'SAM-group-groupB2', 'NA','2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin', 1),
('SAM-user-internet1', 'REQ-group-internet','NA', '2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin', 1),
('SAM-user-internet2', 'REQ-group-internet', 'NA','2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin', 1),
('SAM-user-extranet1', 'SAM-group-partner1', 'NA','2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin', 1),
('SAM-user-extranet2', 'SAM-group-partner2', 'NA','2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin', 1),
('DEF-user-superadmin', 'REQ-group-universal', 'NA','2004-01-01', 'DEF-user-superadmin', '2004-01-01', 'DEF-user-superadmin', 1),
('DEF-user-portaladmin', 'REQ-group-universal', 'NA','2004-01-01', 'DEF-user-superadmin', '2004-01-01', 'DEF-user-superadmin', 1),
('DEF-user-tenantadmina', 'DEF-group-prime', 'NA','2004-01-01', 'DEF-user-superadmin', '2004-01-01', 'DEF-user-superadmin', 1),
('DEF-user-tenantadminb', 'DEF-group-prime', 'NA','2004-01-01', 'DEF-user-superadmin', '2004-01-01', 'DEF-user-superadmin', 1),
('DEF-user-contentadmin', 'DEF-group-test', 'NA','2004-01-01', 'DEF-user-superadmin', '2004-01-01', 'DEF-user-superadmin', 1),
('DEF-user-contentcreator', 'DEF-group-test', 'NA','2004-01-01', 'DEF-user-superadmin', '2004-01-01', 'DEF-user-superadmin', 1),
('DEF-user-contentpublisher', 'DEF-group-test', 'NA','2004-01-01', 'DEF-user-superadmin', '2004-01-01', 'DEF-user-superadmin', 1),
('DEF-user-one', 'DEF-group-test', 'NA','2004-01-01', 'DEF-user-superadmin', '2004-01-01', 'DEF-user-superadmin', 1),
('DEF-user-two', 'DEF-group-test', 'NA','2004-01-01', 'DEF-user-superadmin', '2004-01-01', 'DEF-user-superadmin', 1),
('DEF-user-three', 'DEF-group-test', 'NA','2004-01-01', 'DEF-user-superadmin', '2004-01-01', 'DEF-user-superadmin', 1);

/*
-----------------------------------------------
-- Insert of TBL_AA_SUBJECT2RES
-----------------------------------------------
*/
INSERT INTO TBL_AA_SUBJECT2RES
(`SUBJECT_ID`, `RESOURCES_ID`, `READ_ACCESS`, `CREATE_ACCESS`, `UPDATE_ACCESS`, `DELETE_ACCESS`, `EFFECTIVE_DT`, `EXPIRY_DT`, `CREATED_DT`, `CREATED_BY`, `UPDATED_DT`, `UPDATED_BY`, `VERSION`, `REF_GROUP_ID`)
VALUES
('SAM-user-user1', 'DEF-role-useradmin'   , '1', '1', '1', '1', null, null, '2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin', 1, 'REQ-group-universal' ),
('SAM-user-userA1', 'DEF-role-useradmin'   , '1', '1', '1', '1', null, null, '2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin', 1, 'REQ-group-universal' ),
('SAM-user-userA2', 'DEF-role-useradmin'   , '1', '1', '1', '1', null, null, '2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin', 1, 'REQ-group-universal' ),
('DEF-user-superadmin', 'DEF-role-superadmin', '1', '1', '1', '1', NULL, NULL, '2004-01-01', 'DEF-user-superadmin', '2004-01-01', 'DEF-user-superadmin', 1, 'REQ-group-universal'),
('DEF-user-tenantadmina', 'DEF-role-tenantadmina', '1', '1', '1', '1', NULL, NULL, '2004-01-01', 'DEF-user-superadmin', '2004-01-01', 'DEF-user-superadmin', 1, 'DEF-group-universal'),
('DEF-user-tenantadminb', 'DEF-role-tenantadminb', '1', '1', '1', '1', NULL, NULL, '2004-01-01', 'DEF-user-superadmin', '2004-01-01', 'DEF-user-superadmin', 1, 'DEF-group-universal'),
('DEF-user-contentadmin', 'DEF-role-contentadmin', '1', '1', '1', '1', NULL, NULL, '2004-01-01', 'DEF-user-superadmin', '2004-01-01', 'DEF-user-superadmin', 1, 'DEF-group-universal'),
('DEF-user-contentcreator', 'DEF-role-contentcreator', '1', '1', '1', '1', NULL, NULL, '2004-01-01', 'DEF-user-superadmin', '2004-01-01', 'DEF-user-superadmin', 1, 'DEF-group-universal'),
('DEF-user-contentpublisher', 'DEF-role-contentpublisher', '1', '1', '1', '1', NULL, NULL, '2004-01-01', 'DEF-user-superadmin', '2004-01-01', 'DEF-user-superadmin', 1, 'DEF-group-universal'),
('DEF-user-siteadmin', 'DEF-role-superadmin'   , '1', '1', '1', '1', null, null, '2004-01-01', 'DEF-user-useradmin', '2004-01-01', 'DEF-user-useradmin', 1, 'REQ-group-universal');

/*
-----------------------------------------------
-- Insert of TBL_MC_DEVICE
-----------------------------------------------
*/
INSERT INTO TBL_MC_DEVICE
(`DEVICE_ID`, `DEVICE_OS`, `DESCRIPTION`, `WIDTH`, `HEIGHT`, `STORE_ID`, `CREATED_BY`, `CREATED_DT`, `UPDATED_BY`, `UPDATED_DT`, `VERSION`)
VALUES
('DEF-device-ios-1', 'iOS', 'iPad, iPad2 / (1536 x 2048) - New iPad', 768, 1024, 'DEF-store-prime', 'DEF-user-siteadmin', NOW(), 'DEF-user-siteadmin', NOW(), 1),
('DEF-device-android-1', 'Android', 'Samsung Galaxy Tab, HTC Flyer', 600, 1024, 'DEF-store-prime', 'DEF-user-siteadmin', NOW(), 'DEF-user-siteadmin', NOW(), 1),
('DEF-device-android-2', 'Android', 'Samsung Galaxy Tab 10.1, Motorola Xoom', 800, 1280, 'DEF-store-prime', 'DEF-user-siteadmin', NOW(), 'DEF-user-siteadmin', NOW(), 1);

/*
-----------------------------------------------
-- Insert of TBL_MC_PROFILE
-----------------------------------------------
*/
INSERT INTO TBL_MC_PROFILE
(`PROFILE_ID`,`KEY`,`DEFAULT_VALUE`,`DESCRIPTION`,`TYPE`)
VALUES
('DEF-profile-show-answer','SHOW_ANSWER','0','Show Answer','A'),
('DEF-profile-share-annotation','SHARE_ANNOTATION','0','Share Annotation','A'),
('DEF-profile-reset-password','ENABLE_RESET_PASSWORD','1','Enable reset password','A'),
('DEF-profile-create-user-account','ENABLE_CREATE_USER_ACCOUNT','0','Enable create user account','A'),
('DEF-profile-twitter','ENABLE_TWITTER','0','Enable Twitter','A'),
('DEF-profile-change-password','ENABLE_CHANGE_PASSWORD','1','Enable change password','A'),
('DEF-profile-facebook','ENABLE_FACEBOOK','1','Enable Facebook','A'),
('DEF-profile-max-failed-login','MAX_FAILED_LOGIN_ATTEMPTS','5','Maximum failed login attempts','A'),
('DEF-profile-login-expiry-days','LOGIN_EXPIRY_DAYS','30','Login expiry days','A'),
('DEF-profile-email','ENABLE_EMAIL','1','Enable Email','A'),
('DEF-profile-mcloub','ENABLE_MCLOUD','1','Enable mCloud','A'),
('DEF-profile-text-speech','ENABLE_TEXT_SPEECH','1','Enable text speech','A'),
('DEF-profile-notification','ENABLE_NOTIFICATION','1','Enable Notification','A'),
('DEF-profile-category-subscripe','ENABLE_CATEGORY_SUBSCRIPTION','1','Enable category subscription','A'),
('DEF-profile-remote-bookstore','ENABLE_REMOTE_BOOKSTORE','1','Enable remote bookstore','A'),
('DEF-profile-annotation-quota', 'ANNOTATION_QUOTA', '30', 'Annotation Quota', 'A');

/*
-----------------------------------------------
-- Insert into TBL_MC_PROFILE2STORE
-----------------------------------------------
*/
INSERT INTO TBL_MC_PROFILE2STORE
(`STORE_ID`, `PROFILE_ID`, `VALUE`, `CREATED_BY`, `CREATED_DT`, `UPDATED_BY`, `UPDATED_DT`, `VERSION`)
VALUES
('DEF-store-prime', 'DEF-profile-show-answer', '0', 'SYSTEM', NOW(), 'SYSTEM', NOW(), 1),
('DEF-store-prime', 'DEF-profile-share-annotation', '0', 'SYSTEM', NOW(), 'SYSTEM', NOW(), 1),
('DEF-store-prime', 'DEF-profile-reset-password', '1', 'SYSTEM', NOW(), 'SYSTEM', NOW(), 1),
('DEF-store-prime', 'DEF-profile-create-user-account', '0', 'SYSTEM', NOW(), 'SYSTEM', NOW(), 1),
('DEF-store-prime', 'DEF-profile-twitter', '0', 'SYSTEM', NOW(), 'SYSTEM', NOW(), 1),
('DEF-store-prime', 'DEF-profile-change-password', '1', 'SYSTEM', NOW(), 'SYSTEM', NOW(), 1),
('DEF-store-prime', 'DEF-profile-facebook', '1', 'SYSTEM',  NOW(), 'SYSTEM', NOW(), 1),
('DEF-store-prime', 'DEF-profile-max-failed-login', '5', 'SYSTEM',  NOW(), 'SYSTEM', NOW(), 1),
('DEF-store-prime', 'DEF-profile-login-expiry-days', '30', 'SYSTEM',  NOW(), 'SYSTEM', NOW(), 1),
('DEF-store-prime', 'DEF-profile-email', '1', 'SYSTEM',  NOW(), 'SYSTEM', NOW(), 1),
('DEF-store-prime', 'DEF-profile-mcloub', '1', 'SYSTEM',  NOW(), 'SYSTEM', NOW(), 1),
('DEF-store-prime', 'DEF-profile-text-speech', '1', 'SYSTEM',  NOW(), 'SYSTEM', NOW(), 1),
('DEF-store-prime', 'DEF-profile-notification', '1', 'SYSTEM',  NOW(), 'SYSTEM', NOW(), 1),
('DEF-store-prime', 'DEF-profile-category-subscripe', '1', 'SYSTEM',  NOW(), 'SYSTEM', NOW(), 1),
('DEF-store-prime', 'DEF-profile-remote-bookstore', '1', 'SYSTEM',  NOW(), 'SYSTEM', NOW(), 1),
('DEF-store-prime', 'DEF-profile-annotation-quota', '30', 'SYSTEM',  NOW(), 'SYSTEM', NOW(), 1);

/*
-----------------------------------------------
-- Insert of TBL_MT_AUTH_PROTOCOL
-----------------------------------------------
*/
INSERT INTO TBL_MT_AUTH_PROTOCOL
(`PROTOCOL_ID`, `PROTOCOL_NAME`, `PROTOCOL_DESC`, `PROTOCOL_TYPE`, `URL`, `CREATED_BY`, `CREATED_DT`, `UPDATED_BY`, `UPDATED_DT`, `VERSION`, `DN`, `PRINCIPAL`)
VALUES
('DEF-protocol-ncs-gravity', 'NCS Gravity SSO', 'NCS Gravity SSO', 'OpenAM', 'https://sso.ncs.com.sg/sso/', 'DEF-user-superadmin', NOW(), 'DEF-user-superadmin', NOW(), 1, NULL, NULL);

/*
-----------------------------------------------
-- Insert of TBL_MC_ACCOUNT_SOURCE
-----------------------------------------------
*/
INSERT INTO TBL_MC_ACCOUNT_SOURCE
(`SOURCE_ID`, `SOURCE_NAME`, `SOURCE_DESC`, `STATUS`, `CREATED_BY`, `CREATED_DT`, `UPDATED_BY`, `UPDATED_DT`, `VERSION`)
VALUES
('00-APP-0001', 'Apple App Store', 'Apple App Store', 'A', 'DEF-user-superadmin', NOW(), 'DEF-user-superadmin', NOW(), 1),
('00-WIN-0001', 'Windows 8', 'Windows 8', 'A', 'DEF-user-superadmin', NOW(), 'DEF-user-superadmin', NOW(), 1);

/*
-----------------------------------------------
-- Insert of TBL_MT_TENANT_PROTOCOL
-----------------------------------------------
*/
INSERT INTO TBL_MT_TENANT_PROTOCOL
(`TENANT_ID`, `PROTOCOL_ID`, `CREATE_USER`, `UPDATE_USER`, `CREATED_BY`, `CREATED_DT`, `UPDATED_BY`, `UPDATED_DT`, `VERSION`)
VALUES
('DEF-tenant-prime', 'DEF-protocol-ncs-gravity', 'Y', 'Y', 'DEF-user-superadmin', NOW(), 'DEF-user-superadmin', NOW(), 1);

/*
-----------------------------------------------
-- Insert of TBL_MC_SETTING
-----------------------------------------------
*/
insert into TBL_MC_SETTING
(`SETTING_ID`, `STORE_ID`, `VIDEO_SIZE`, `AUDIO_SIZE`, `IMAGE_SIZE`, `HIDE_PRICE`, `HIDE_EXAM`, `MAX_CATEGORY_DEPTH`, `HIDE_DISTRIBUTION_MODES`, `HIDE_META_DATA`, `HIDE_MARKABLE`, `HIDE_MUTUALLY_EXCLUSIVE`, `HIDE_SUPPORTED_DEVICES`, `HIDE_DATE_OF_PUBLICATION`, `HIDE_NOTIFICATION`, `HIDE_CATEGORY_SUBSCRIPTION`, `CHOICE_NUMBER`, `CREATED_BY`, `CREATED_DT`, `UPDATED_DT`,`UPDATED_BY`,`VERSION`)
VALUES
('DEF-default-setting', 'DEF-store-prime', '30', '30', '30', '1', '1', 5, '1', '1', '1', '1', '1', '1', '1', '1', 6, 'DEF-user-superadmin', now(), now(), 'DEF-user-superadmin', 1);

/*
-----------------------------------------------
-- Insert of TBL_MT_TENANT
-----------------------------------------------
*/
INSERT INTO TBL_MT_TENANT
(`TENANT_ID`, `TENANT_NAME`, `TENANT_DESC`, `PROTOCOL_ID`, `DEFAULT_OU`, `GROUP_ID`, `REFERENCE_ID`, `CREATED_BY`, `CREATED_DT`, `UPDATED_BY`, `UPDATED_DT`, `VERSION`) 
VALUES 
('DEF-tenant-prime', 'Prime Tenant', 'Prime Tenant', NULL, NULL, 'DEF-group-prime', 'DEF-store-prime', 'DEF-user-superadmin', NOW(), 'DEF-user-superadmin', NOW(), 1);

/*
-----------------------------------------------
-- Insert of TBL_MT_OU
-----------------------------------------------
*/
INSERT INTO TBL_MT_OU
(`OU_ID`, `OU_NAME`, `OU_DESC`, `OU_PARENT_ID`, `TENANT_ID`, `GROUP_ID`, `CREATED_BY`, `CREATED_DT`, `UPDATED_BY`, `UPDATED_DT`, `VERSION`) 
VALUES 
('DEF-ou-prime', 'PRIME OU', 'Prime Organisation Unit', NULL, 'DEF-tenant-prime', 'DEF-group-prime', 'DEF-user-superadmin', NOW(), 'DEF-user-superadmin', NOW(), 1),
('DEF-ou-unitA', 'UNIT A', 'Organisation Unit A', 'DEF-ou-prime', 'DEF-tenant-prime', 'DEF-group-unitA', 'DEF-user-superadmin', NOW(), 'DEF-user-superadmin', NOW(), 1),
('DEF-ou-unitB', 'UNIT B', 'Organisation Unit B', 'DEF-ou-prime', 'DEF-tenant-prime', 'DEF-group-unitB', 'DEF-user-superadmin', NOW(), 'DEF-user-superadmin', NOW(), 1),
('DEF-ou-test', 'TEST OU', 'Test Unit', 'DEF-ou-prime', 'DEF-tenant-prime', 'DEF-group-test', 'DEF-user-superadmin', NOW(), 'DEF-user-superadmin', NOW(), 1);

/*
-----------------------------------------------
-- Insert of TBL_MT_USER
-----------------------------------------------
*/
INSERT INTO TBL_MT_USER 
(`USER_ID`, `SUBJECT_ID`, `PHOTO`, `ACCOUNT_FROM`, `SESSION_KEY`, `DEFAULT_AD_SERVER`, `CREATED_BY`, `CREATED_DT`, `UPDATED_BY`, `UPDATED_DT`, `VERSION`)
VALUES 
('DEF-subject-superadmin', 'DEF-user-superadmin', NULL, 0, NULL, NULL, 'DEF-user-superadmin', NOW(), 'DEF-user-superadmin', NOW(), 1),
('DEF-subject-portaladmin', 'DEF-user-portaladmin', NULL, 0, NULL, NULL, 'DEF-user-superadmin', NOW(), 'DEF-user-superadmin', NOW(), 1), 
('DEF-subject-tenantadmina', 'DEF-user-tenantadmina', NULL, 0, NULL, NULL, 'DEF-user-superadmin', NOW(), 'DEF-user-superadmin', NOW(), 1),
('DEF-subject-tenantadminb', 'DEF-user-tenantadminb', NULL, 0, NULL, NULL, 'DEF-user-superadmin', NOW(), 'DEF-user-superadmin', NOW(), 1),
('DEF-subject-contentadmin', 'DEF-user-contentadmin', NULL, 0, NULL, NULL, 'DEF-user-superadmin', NOW(), 'DEF-user-superadmin', NOW(), 1),
('DEF-subject-contentcreator', 'DEF-user-contentcreator', NULL, 0, NULL, NULL, 'DEF-user-superadmin', NOW(), 'DEF-user-superadmin', NOW(), 1), 
('DEF-subject-contentpublisher', 'DEF-user-contentpublisher', NULL, 0, NULL, NULL, 'DEF-user-superadmin', NOW(), 'DEF-user-superadmin', NOW(), 1), 
('DEF-subject-one', 'DEF-user-one', NULL, 0, NULL, NULL, 'DEF-user-superadmin', NOW(), 'DEF-user-superadmin', NOW(), 1), 
('DEF-subject-two', 'DEF-user-two', NULL, 0, NULL, NULL, 'DEF-user-superadmin', NOW(), 'DEF-user-superadmin', NOW(), 1), 
('DEF-subject-three', 'DEF-user-three', NULL, 0, NULL, NULL,'DEF-user-superadmin', NOW(), 'DEF-user-superadmin', NOW(), 1); 

/*
-----------------------------------------------
-- Insert of TBL_MT_USER2TENANT
-----------------------------------------------
*/
INSERT INTO TBL_MT_USER2TENANT 
(`USER_ID`, `TENANT_ID`, `CREATED_BY`, `CREATED_DT`)
VALUES 
('DEF-subject-superadmin', 'DEF-tenant-prime', 'DEF-user-superadmin', NOW()),
('DEF-subject-portaladmin', 'DEF-tenant-prime', 'DEF-user-superadmin', NOW()), 
('DEF-subject-tenantadmina', 'DEF-tenant-prime', 'DEF-user-superadmin', NOW()),
('DEF-subject-tenantadminb', 'DEF-tenant-prime', 'DEF-user-superadmin', NOW()),
('DEF-subject-contentadmin', 'DEF-tenant-prime', 'DEF-user-superadmin', NOW()),
('DEF-subject-contentcreator', 'DEF-tenant-prime', 'DEF-user-superadmin', NOW()), 
('DEF-subject-contentpublisher', 'DEF-tenant-prime', 'DEF-user-superadmin', NOW()), 
('DEF-subject-one', 'DEF-tenant-prime', 'DEF-user-superadmin', NOW()), 
('DEF-subject-two', 'DEF-tenant-prime', 'DEF-user-superadmin', NOW()), 
('DEF-subject-three', 'DEF-tenant-prime', 'DEF-user-superadmin', NOW()); 

/*
-----------------------------------------------
-- Insert of TBL_MT_USER2OU
-----------------------------------------------
*/
INSERT INTO TBL_MT_USER2OU 
(`USER_ID`, `OU_ID`, `CREATED_BY`, `CREATED_DT`)
VALUES 
('DEF-subject-superadmin', 'DEF-ou-prime', 'DEF-user-superadmin', NOW()),
('DEF-subject-portaladmin', 'DEF-ou-prime', 'DEF-user-superadmin', NOW()), 
('DEF-subject-tenantadmina', 'DEF-ou-prime', 'DEF-user-superadmin', NOW()),
('DEF-subject-tenantadminb', 'DEF-ou-prime', 'DEF-user-superadmin', NOW()),
('DEF-subject-contentadmin', 'DEF-ou-test', 'DEF-user-superadmin', NOW()),
('DEF-subject-contentcreator', 'DEF-ou-test', 'DEF-user-superadmin', NOW()), 
('DEF-subject-contentpublisher', 'DEF-ou-test', 'DEF-user-superadmin', NOW()), 
('DEF-subject-one', 'DEF-ou-test', 'DEF-user-superadmin', NOW()), 
('DEF-subject-two', 'DEF-ou-test', 'DEF-user-superadmin', NOW()), 
('DEF-subject-three', 'DEF-ou-test', 'DEF-user-superadmin', NOW()); 
