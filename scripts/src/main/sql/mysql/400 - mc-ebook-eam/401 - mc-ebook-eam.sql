/*
-------------------------------------------------
-- Drop all the tables
-------------------------------------------------
*/
DROP TABLE IF EXISTS TBL_MC_EAM_TEST_QUESTION;
DROP TABLE IF EXISTS TBL_MC_EAM_TEST_PAPER;

/*
---------------------------------------------
-- Creation of TBL_MC_EAM_TEST_PAPER
---------------------------------------------
*/

CREATE TABLE TBL_MC_EAM_TEST_PAPER (
    TEST_SESSION_ID                VARCHAR(32)      NOT NULL,
    TEST_SESSION_VERSION           VARCHAR(5)       NOT NULL,
    TEST_PAPER_ID                  VARCHAR(32)      NOT NULL,
    TEST_PAPER_NAME                VARCHAR(255)     NOT NULL,
    PUBLISHER_USER_ID              VARCHAR(32)      NOT NULL,
    PUBLISHER_TENANT_ID            VARCHAR(32)      NOT NULL,
    PUBLISHER_OU_ID                VARCHAR(32)      NOT NULL,
    TEST_DATE_FROM                 DATETIME         NOT NULL,
    TEST_DATE_TO                   DATETIME         NOT NULL,
    TEST_DURATION                  INTEGER          NOT NULL,
    PUBLICATION_ID                 VARCHAR(32)      NOT NULL,
    PUBLICATION_REVISION           INTEGER          NOT NULL,
    CREATED_DT                     DATETIME         NOT NULL
) ENGINE=INNODB;

ALTER TABLE TBL_MC_EAM_TEST_PAPER ADD CONSTRAINT
    PK_MC_EAM_TEST_PAPER           PRIMARY KEY (TEST_SESSION_ID, TEST_SESSION_VERSION);

/*
---------------------------------------------
-- Creation of TBL_MC_EAM_TEST_QUESTION
---------------------------------------------
*/

CREATE TABLE TBL_MC_EAM_TEST_QUESTION (
    QUESTION_ID                    VARCHAR(32)      NOT NULL,
    TEST_SESSION_ID                VARCHAR(32)      NOT NULL,
    TEST_SESSION_VERSION           VARCHAR(5)       NOT NULL,
    QUESTION_NO                    INTEGER          NOT NULL,
    BLANK_ID                       CHAR(32),
    QUESTION_TYPE                  VARCHAR(5)       NOT NULL,
    CREATED_DT                     DATETIME         NOT NULL
) ENGINE=INNODB;

ALTER TABLE TBL_MC_EAM_TEST_QUESTION ADD CONSTRAINT
    PK_MC_EAM_TEST_QUESTION        PRIMARY KEY (QUESTION_ID);

ALTER TABLE `TBL_MC_HOTSPOT_ESSAY_QUESTION` CHANGE COLUMN `ANSWER_TEXT` `ANSWER_TEXT` TEXT NOT NULL;
