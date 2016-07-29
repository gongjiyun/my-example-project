/* MySQL Scripts for i.Frame v3.13 (iConnect v3.13)*/
/*
-------------------------------------------------
-- Drop the relevant tables
-------------------------------------------------
*/

DROP TABLE IF EXISTS TBL_CONFIG_PROP;
DROP TABLE IF EXISTS TBL_PROFILE_RES2PROFILE;
DROP TABLE IF EXISTS TBL_CODE_INT;
DROP TABLE IF EXISTS TBL_CODETYPE_PARENT;
DROP TABLE IF EXISTS TBL_CODETYPE;

DROP TABLE IF EXISTS TBL_MENU_DISPLAYER;
DROP TABLE IF EXISTS TBL_MENU_ITEM;
DROP TABLE IF EXISTS TBL_MENU_REPOSITORY;

DROP TABLE IF EXISTS TBL_PROFILE_ITEM;
DROP TABLE IF EXISTS TBL_PROFILE_PROFILE2REPOSITORY;

DROP TABLE IF EXISTS TBL_MODULE_PREF;

DROP TABLE IF EXISTS TBL_LOG;
DROP TABLE IF EXISTS TBL_LOG_DELTA;

DROP TABLE IF EXISTS TBL_ARCHIVE_DEL;
DROP TABLE IF EXISTS TBL_ASYNC_CLIENT;
DROP TABLE IF EXISTS TBL_ASYNC_SERVER;
DROP TABLE IF EXISTS TBL_ASYNC_MAIL;


/*
---------------------------------------------
-- Creation of TBL_PROFILE_RES2PROFILE
---------------------------------------------
*/
CREATE TABLE TBL_PROFILE_RES2PROFILE (
    RES_ID                          VARCHAR(32)                 NOT NULL,
    PROFILE_ID                      VARCHAR(32)                 NOT NULL,
    RES_TYPE                        VARCHAR(50),
    CREATED_BY                      VARCHAR(50),
    CREATED_DT                      TIMESTAMP,
    UPDATED_BY                      VARCHAR(50),
    UPDATED_DT                      TIMESTAMP,
    VERSION                         INTEGER
);
ALTER TABLE TBL_PROFILE_RES2PROFILE ADD CONSTRAINT
    PK_TBL_PROFILE_RES2PROFILE PRIMARY KEY (RES_ID, PROFILE_ID);

/*
---------------------------------------------
-- Creation of TBL_CONFIG_PROP 
---------------------------------------------
*/
CREATE TABLE TBL_CONFIG_PROP (
    PROP_ID                         VARCHAR(32)                 NOT NULL,
    FILE_NAME                       VARCHAR(100)                NULL,
    PROP_KEY                        VARCHAR(100)                NULL,
    PROP_DESC                       VARCHAR(100)                NULL,
    PROP_VALUE                      VARCHAR(100)                NULL,
    CREATED_BY                      VARCHAR(32)                 NULL,
    CREATED_DT                      DATETIME                    NULL,
    UPDATED_BY                      VARCHAR(32)                 NULL,
    UPDATED_DT                      DATETIME                    NULL,
    VERSION                         INTEGER                     NULL
);
ALTER TABLE TBL_CONFIG_PROP ADD CONSTRAINT
    PK_TBL_CONFIG_PROP             PRIMARY KEY (PROP_ID);


/*
---------------------------------------------
-- Creation of TBL_CODETYPE
---------------------------------------------
*/
CREATE TABLE TBL_CODETYPE (
    CODETYPE_ID                     VARCHAR(66)                 NOT NULL,
    CODETYPE_DESC                   VARCHAR(66)                 NULL,
    CODETYPE_TABLE                  VARCHAR(66)                 NULL,
    READ_ONLY                       CHAR(1)                     NULL,
    COL_CODETYPE_ID                 VARCHAR(66)                 NULL,
    COL_CODE_ID                     VARCHAR(66)                 NULL,
    COL_CODE_DESC                   VARCHAR(66)                 NULL,
    COL_CODE_SEQ                    VARCHAR(66)                 NULL,
    COL_STATUS                      VARCHAR(66)                 NULL,
    COL_EFFECTIVE_DT                VARCHAR(66)                 NULL,
    COL_EXPIRY_DT                   VARCHAR(66)                 NULL,
    EDIT_URL                        VARCHAR(120)                NULL,
    ADD_URL                         VARCHAR(120)                NULL,
    OWNER_GROUP                     VARCHAR(200)                NULL,
    UPDATED_BY                      VARCHAR(32)                 NULL,
    UPDATED_DT                      DATETIME                    NULL,
    COL_CODE_LOCALE                 VARCHAR(20)                 NULL
);

ALTER TABLE TBL_CODETYPE ADD CONSTRAINT
    PK_TBL_CODETYPE                PRIMARY KEY (CODETYPE_ID);

/*
---------------------------------------------
-- Creation of TBL_CODETYPE_PARENT
---------------------------------------------
*/
CREATE TABLE TBL_CODETYPE_PARENT (
    CODETYPE_ID                    VARCHAR(20)      NOT NULL,
    CODETYPE_PARENT_ID             VARCHAR(100)     NOT NULL,
    CODE_ID                        VARCHAR(100)     NOT NULL
);

ALTER TABLE TBL_CODETYPE_PARENT ADD CONSTRAINT
    PK_TBL_CODETYPE_PARENT         PRIMARY KEY (CODETYPE_ID, CODETYPE_PARENT_ID, CODE_ID);
ALTER TABLE TBL_CODETYPE_PARENT ADD CONSTRAINT
    FK_CODETYPE_PARENT_CODETYPE_ID FOREIGN KEY (CODETYPE_ID) REFERENCES TBL_CODETYPE (CODETYPE_ID);

/*
---------------------------------------------
-- Creation of TBL_CODE_INT
---------------------------------------------
*/
CREATE TABLE TBL_CODE_INT (
    CODETYPE_ID                     VARCHAR(66)                 NOT NULL,
    CODE_ID                         VARCHAR(66)                 NOT NULL,
    CODE_DESC                       VARCHAR(66)                 NULL,
    CODE_SEQ                        INTEGER                     NULL,
    STATUS                          CHAR(1)                     NOT NULL,
    EFFECTIVE_DT                    DATE                        NULL,
    EXPIRY_DT                       DATE                        NULL,
    UPDATED_BY                      VARCHAR(32)                 NULL,
    UPDATED_DT                      DATETIME                    NULL,
    LOCALE                          VARCHAR(2)                  NOT NULL
);

ALTER TABLE TBL_CODE_INT ADD CONSTRAINT
    PK_TBL_CODE_INT                 PRIMARY KEY (CODETYPE_ID, CODE_ID, LOCALE);
ALTER TABLE TBL_CODE_INT ADD CONSTRAINT
    FK_TBL_CODE_INT_CODETYPE_ID FOREIGN KEY (CODETYPE_ID) REFERENCES tbl_codetype (CODETYPE_ID) ON UPDATE RESTRICT ON DELETE RESTRICT;

/*
---------------------------------------------
-- Creation of TBL_MENU_DISPLAYER
---------------------------------------------
*/
CREATE TABLE TBL_MENU_DISPLAYER (
    REPOSITORY_ID                   VARCHAR(32)                 NOT NULL,
    NAME                            VARCHAR(120)                NOT NULL,
    TYPE                            VARCHAR(120)                NULL,
    CONFIG                          VARCHAR(120)                NULL
);

ALTER TABLE TBL_MENU_DISPLAYER ADD CONSTRAINT
    PK_TBL_MENU_DISPLAYER           PRIMARY KEY (REPOSITORY_ID, NAME);

/*
---------------------------------------------
-- Creation of TBL_MENU_ITEM
---------------------------------------------
*/
CREATE TABLE TBL_MENU_ITEM (
    REPOSITORY_ID                   VARCHAR(32)                 NOT NULL,
    ITEM_ID                         VARCHAR(32)                 NOT NULL,
    PARENT_ITEM_ID                  VARCHAR(32)                 NULL,
    ITEM_SEQ                        INTEGER                     NULL,
    NAME                            VARCHAR(120)                NOT NULL,
    TITLE                           VARCHAR(120)                NULL,
    LOCATION                        VARCHAR(120)                NULL,
    TARGET                          VARCHAR(120)                NULL,
    DESCRIPTION                     VARCHAR(120)                NULL,
    ON_CLICK                        VARCHAR(120)                NULL,
    ON_MOUSE_OVER                   VARCHAR(120)                NULL,
    ON_MOUSE_OUT                    VARCHAR(120)                NULL,
    IMAGE                           VARCHAR(120)                NULL,
    ALT_IMAGE                       VARCHAR(120)                NULL,
    TOOL_TIP                        VARCHAR(120)                NULL,
    ROLES                           VARCHAR(120)                NULL,
    PAGE                            VARCHAR(120)                NULL,
    CATEGORY                        VARCHAR(120)                NULL,
    VERSION                         INTEGER                     NULL
);

ALTER TABLE TBL_MENU_ITEM ADD CONSTRAINT
    PK_TBL_MENU_ITEM               PRIMARY KEY (REPOSITORY_ID, NAME);

/*
---------------------------------------------
-- Creation of TBL_MENU_REPOSITORY
---------------------------------------------
*/
CREATE TABLE TBL_MENU_REPOSITORY (
    REPOSITORY_ID                   VARCHAR(32)                 NOT NULL,
    REPOSITORY_DESC                 VARCHAR(50)                 NULL
);

ALTER TABLE TBL_MENU_REPOSITORY ADD CONSTRAINT
    PK_TBL_MENU_REPOSITORY         PRIMARY KEY (REPOSITORY_ID);

/*
---------------------------------------------
-- Creation of TBL_PROFILE_ITEM
---------------------------------------------
*/
CREATE TABLE TBL_PROFILE_ITEM (
    PROFILE_ID                      VARCHAR(32)                 NOT NULL,
    PROFILE_NAME                    VARCHAR(50)                 NOT NULL,
    IS_SYS_PROFILE                  VARCHAR(6)                  NOT NULL,
    CREATED_DT                      DATETIME                    NULL,
    CREATED_BY                      VARCHAR(50)                 NULL,
    UPDATED_DT                      DATETIME                    NULL,
    UPDATED_BY                      VARCHAR(50)                 NULL,
    VERSION                         INTEGER                     NULL
);

ALTER TABLE TBL_PROFILE_ITEM ADD CONSTRAINT
    PK_TBL_PROFILE_ITEM            PRIMARY KEY (PROFILE_ID);

/*
---------------------------------------------
-- Creation of TBL_PROFILE_PROFILE2REPOSITORY
---------------------------------------------
*/
CREATE TABLE TBL_PROFILE_PROFILE2REPOSITORY (
    PROFILE_ID                      VARCHAR(32)                 NOT NULL,
    REPOSITORY_ID                   VARCHAR(32)                 NOT NULL,
    REPO_ORDER                      INTEGER                     NULL,
    CREATED_DT                      DATETIME                    NULL,
    CREATED_BY                      VARCHAR(50)                 NULL,
    UPDATED_DT                      DATETIME                    NULL,
    UPDATED_BY                      VARCHAR(50)                 NULL,
    VERSION                         INTEGER                     NULL
);

ALTER TABLE TBL_PROFILE_PROFILE2REPOSITORY ADD CONSTRAINT
    PK_PROFILE_PROFILE2REPOSITORY  PRIMARY KEY (PROFILE_ID, REPOSITORY_ID);

/*
---------------------------------------------
-- Creation of TBL_ARCHIVE_DEL
---------------------------------------------
*/
CREATE TABLE TBL_ARCHIVE_DEL (
    TBL_NAM                         VARCHAR(32)                 NOT NULL,
    ARCHIVE_JOBNO                   VARCHAR(32)                 NOT NULL,
    DEL_VALUE_TXT                   VARCHAR(2000)               NOT NULL
);

/*
---------------------------------------------
-- Creation of TBL_ASYNC_CLIENT
---------------------------------------------
*/

CREATE TABLE TBL_ASYNC_CLIENT (
    CLIENT_KEY_ID                   VARCHAR(32)                 NOT NULL,
    URL_WSDL                        VARCHAR(100)                NULL,
    OPERATION_NAME                  VARCHAR(100)                NULL,
    PARAM_HASHMAP                   VARCHAR(4000)               NULL,
    RETURN_RESULT                   BLOB                        NULL,
    RESULT_GENERATED                INTEGER                     NOT NULL,
    GENERATED_DT                    TIMESTAMP                   NULL,
    VERSION                         INTEGER                     NOT NULL
);

ALTER TABLE TBL_ASYNC_CLIENT ADD CONSTRAINT
    PK_TBL_ASYNC_CLIENT            PRIMARY KEY (CLIENT_KEY_ID);

/*
---------------------------------------------
-- Creation of TBL_ASYNC_SERVER
---------------------------------------------
*/
CREATE TABLE TBL_ASYNC_SERVER (
    SERVER_KEY_ID                   VARCHAR(32)                 NOT NULL,
    ASYNC_TYPE                      VARCHAR(4)                  NULL,
    CLIENT_KEY_ID                   VARCHAR(32)                 NULL,
    CLIENT_IP_ADDR                  VARCHAR(32)                 NULL,
    URL_WSDL                        VARCHAR(100)                NULL,
    OPERATION_NAME                  VARCHAR(100)                NULL,
    PARAM_HASHMAP                   VARCHAR(4000)               NULL,
    RETURN_RESULT                   BLOB                        NULL,
    RESULT_GENERATED                INTEGER                     NOT NULL,
    GENERATED_DT                    TIMESTAMP                   NULL,
    PUSH_URL_WSDL                   VARCHAR(100)                NULL,
    PUSH_OPERATION_NAME             VARCHAR(100)                NULL,
    PUSH_RESULT_SENT                INTEGER                     NOT NULL,
    VERSION                         INTEGER                     NOT NULL
);

ALTER TABLE TBL_ASYNC_SERVER ADD CONSTRAINT
    PK_TBL_ASYNC_SERVER            PRIMARY KEY (SERVER_KEY_ID);

/*
---------------------------------------------
-- Creation of TBL_LOG_DELTA
---------------------------------------------
*/
CREATE TABLE TBL_LOG_DELTA (
    DELTA_ID                        VARCHAR(32)                 NOT NULL,
    TRANSACTION_ID                  VARCHAR(32)                 NOT NULL,
    TRANSACTION_TYPE                VARCHAR(32)                 NOT NULL,
    TABLE_NAME                      VARCHAR(32)                 NOT NULL,
    PRIMARY_KEY                     VARCHAR(255)                NOT NULL,
    CREATED_BY                      VARCHAR(32)                 NOT NULL,
    CREATED_DATE                    DATETIME                    NOT NULL,
    TRANSACTION_DETAILS             BLOB                        NOT NULL,
    LOG_ACTION                      VARCHAR(255)                NOT NULL
);

ALTER TABLE TBL_LOG_DELTA ADD CONSTRAINT
    PK_TBL_LOG_DELTA               PRIMARY KEY (DELTA_ID, TRANSACTION_ID);

/*
---------------------------------------------
-- Creation of TBL_ASYNC_MAIL
---------------------------------------------
*/
CREATE TABLE TBL_ASYNC_MAIL (
    MAIL_ID                         VARCHAR(32)                 NOT NULL,
    MAIL_CONTENT                    BLOB                        NULL,
    MAIL_STATUS                     VARCHAR(1)                  NULL,
    IS_HTML_MAIL                    VARCHAR(1)                  NULL,
    CREATED_DT                      TIMESTAMP                   NULL,
    VERSION                         INTEGER                     NOT NULL
);

ALTER TABLE TBL_ASYNC_MAIL ADD CONSTRAINT
    PK_TBL_ASYNC_MAIL              PRIMARY KEY (MAIL_ID);

/*
---------------------------------------------
-- Creation of TBL_LOG
---------------------------------------------
*/
CREATE TABLE TBL_LOG (
    CLASS                           VARCHAR(255)                NULL,
    MESSAGE                         VARCHAR(255)                NULL,
    LOG_LEVEL                       VARCHAR(50)                 NULL,
    CLASSNAME                       VARCHAR(150)                NULL,
    AUDIT_DATE                      DATETIME                    NULL
);

/*
---------------------------------------------
-- Creation of TBL_MODULE_PREF
---------------------------------------------
*/
CREATE TABLE TBL_MODULE_PREF (
    REF_ID                          VARCHAR(32)                 NOT NULL,
    PREF_NAME                       VARCHAR(255)                NOT NULL,
    PREF_VALUE                      VARCHAR(1000)               NULL
);

ALTER TABLE TBL_MODULE_PREF ADD CONSTRAINT
    PK_TBL_MODULE_PREF              PRIMARY KEY (REF_ID, PREF_NAME);