/* MySQL Scripts for i.Scheduler v3.13 (iConnect v3.13)*/
/*
-------------------------------------------------
-- Drop the relevant tables
-------------------------------------------------
*/
DROP TABLE IF EXISTS TBL_TIMER_JOB_LISTENERS;
DROP TABLE IF EXISTS TBL_TIMER_TRIGGER_LISTENERS;
DROP TABLE IF EXISTS TBL_TIMER_FIRED_TRIGGERS;
DROP TABLE IF EXISTS TBL_TIMER_SIMPLE_TRIGGERS;
DROP TABLE IF EXISTS TBL_TIMER_CRON_TRIGGERS;
DROP TABLE IF EXISTS TBL_TIMER_BLOB_TRIGGERS;
DROP TABLE IF EXISTS TBL_TIMER_TRIGGERS;
DROP TABLE IF EXISTS TBL_TIMER_JOB_DETAILS;
DROP TABLE IF EXISTS TBL_TIMER_CALENDARS;
DROP TABLE IF EXISTS TBL_TIMER_PAUSED_TRIGGER_GRPS;
DROP TABLE IF EXISTS TBL_TIMER_LOCKS;
DROP TABLE IF EXISTS TBL_TIMER_SCHEDULER_STATE;
DROP TABLE IF EXISTS TBL_TIMER_HISTORY;
DROP TABLE IF EXISTS TBL_TIMER_PRIORITY;
/*
---------------------------------------------
-- Creation of TBL_TIMER_JOB_DETAILS
---------------------------------------------
*/
CREATE TABLE TBL_TIMER_JOB_DETAILS (
    JOB_NAME                        VARCHAR(200)                NOT NULL,
    JOB_GROUP                       VARCHAR(200)                NOT NULL,
    DESCRIPTION                     VARCHAR(250)                NULL,
    JOB_CLASS_NAME                  VARCHAR(250)                NOT NULL,
    IS_DURABLE                      VARCHAR(1)                  NOT NULL,
    IS_VOLATILE                     VARCHAR(1)                  NOT NULL,
    IS_STATEFUL                     VARCHAR(1)                  NOT NULL,
    REQUESTS_RECOVERY               VARCHAR(1)                  NOT NULL,
    JOB_DATA                        MEDIUMBLOB                  NULL
);

ALTER TABLE TBL_TIMER_JOB_DETAILS ADD CONSTRAINT
    PK_TBL_TIMER_JOB_DETAILS       PRIMARY KEY (JOB_NAME, JOB_GROUP);

/*
---------------------------------------------
-- Creation of TBL_TIMER_JOB_LISTENERS
---------------------------------------------
*/
CREATE TABLE TBL_TIMER_JOB_LISTENERS (
    JOB_NAME                        VARCHAR(200)                NOT NULL,
    JOB_GROUP                       VARCHAR(200)                NOT NULL,
    JOB_LISTENER                    VARCHAR(200)                NOT NULL
);

ALTER TABLE TBL_TIMER_JOB_LISTENERS ADD CONSTRAINT
    PK_TBL_TIMER_JOB_LISTENERS     PRIMARY KEY (JOB_NAME, JOB_GROUP, JOB_LISTENER);
ALTER TABLE TBL_TIMER_JOB_LISTENERS ADD CONSTRAINT
    FK_TIMER_JL_JOB_NAME_GROUP     FOREIGN KEY (JOB_NAME, JOB_GROUP) REFERENCES TBL_TIMER_JOB_DETAILS(JOB_NAME, JOB_GROUP);

/*
---------------------------------------------
-- Creation of TBL_TIMER_TRIGGERS
---------------------------------------------
*/
CREATE TABLE TBL_TIMER_TRIGGERS (
    TRIGGER_NAME                    VARCHAR(200)                NOT NULL,
    TRIGGER_GROUP                   VARCHAR(200)                NOT NULL,
    JOB_NAME                        VARCHAR(200)                NOT NULL,
    JOB_GROUP                       VARCHAR(200)                NOT NULL,
    IS_VOLATILE                     VARCHAR(1)                  NOT NULL,
    DESCRIPTION                     VARCHAR(250)                NULL,
    NEXT_FIRE_TIME                  BIGINT(13)                  NULL,
    PREV_FIRE_TIME                  BIGINT(13)                  NULL,
    PRIORITY                        INTEGER                     NULL,
    TRIGGER_STATE                   VARCHAR(16)                 NOT NULL,
    TRIGGER_TYPE                    VARCHAR(8)                  NOT NULL,
    START_TIME                      BIGINT(13)                  NOT NULL,
    END_TIME                        BIGINT(13)                  NULL,
    CALENDAR_NAME                   VARCHAR(200)                NULL,
    MISFIRE_INSTR                   SMALLINT(2)                 NULL,
    JOB_DATA                        BLOB                        NULL
);

ALTER TABLE TBL_TIMER_TRIGGERS ADD CONSTRAINT
    PK_TBL_TIMER_TRIGGERS          PRIMARY KEY (TRIGGER_NAME, TRIGGER_GROUP);
ALTER TABLE TBL_TIMER_TRIGGERS ADD CONSTRAINT
    FK_TIMER_TRIG_JOB_NAME_GROUP   FOREIGN KEY (JOB_NAME, JOB_GROUP) REFERENCES TBL_TIMER_JOB_DETAILS(JOB_NAME, JOB_GROUP);

/*
---------------------------------------------
-- Creation of TBL_TIMER_SIMPLE_TRIGGERS
---------------------------------------------
*/
CREATE TABLE TBL_TIMER_SIMPLE_TRIGGERS (
    TRIGGER_NAME                    VARCHAR(200)                NOT NULL,
    TRIGGER_GROUP                   VARCHAR(200)                NOT NULL,
    REPEAT_COUNT                    BIGINT(7)                   NOT NULL,
    REPEAT_INTERVAL                 BIGINT(12)                  NOT NULL,
    TIMES_TRIGGERED                 BIGINT(10)                  NOT NULL
);

ALTER TABLE TBL_TIMER_SIMPLE_TRIGGERS ADD CONSTRAINT
    PK_TBL_TIMER_SIMPLE_TRIGGERS   PRIMARY KEY (TRIGGER_NAME, TRIGGER_GROUP);
ALTER TABLE TBL_TIMER_SIMPLE_TRIGGERS ADD CONSTRAINT
    FK_TIMER_ST_TRIGGER_NAME_GROUP FOREIGN KEY (TRIGGER_NAME, TRIGGER_GROUP) REFERENCES TBL_TIMER_TRIGGERS(TRIGGER_NAME, TRIGGER_GROUP);

/*
---------------------------------------------
-- Creation of TBL_TIMER_CRON_TRIGGERS
---------------------------------------------
*/
CREATE TABLE TBL_TIMER_CRON_TRIGGERS (
    TRIGGER_NAME                    VARCHAR(200)                NOT NULL,
    TRIGGER_GROUP                   VARCHAR(200)                NOT NULL,
    CRON_EXPRESSION                 VARCHAR(200)                NOT NULL,
    TIME_ZONE_ID                    VARCHAR(80)                 NULL
);

ALTER TABLE TBL_TIMER_CRON_TRIGGERS ADD CONSTRAINT
    PK_TBL_TIMER_CRON_TRIGGERS   PRIMARY KEY (TRIGGER_NAME, TRIGGER_GROUP);
ALTER TABLE TBL_TIMER_CRON_TRIGGERS ADD CONSTRAINT
    FK_TIMER_CT_TRIGGER_NAME_GROUP FOREIGN KEY (TRIGGER_NAME, TRIGGER_GROUP) REFERENCES TBL_TIMER_TRIGGERS(TRIGGER_NAME, TRIGGER_GROUP);

/*
---------------------------------------------
-- Creation of TBL_TIMER_BLOB_TRIGGERS
---------------------------------------------
*/
CREATE TABLE TBL_TIMER_BLOB_TRIGGERS (
    TRIGGER_NAME                    VARCHAR(200)                NOT NULL,
    TRIGGER_GROUP                   VARCHAR(200)                NOT NULL,
    BLOB_DATA                       BLOB                        NULL
);

ALTER TABLE TBL_TIMER_BLOB_TRIGGERS ADD CONSTRAINT
    PK_TBL_TIMER_BLOB_TRIGGERS   PRIMARY KEY (TRIGGER_NAME, TRIGGER_GROUP);
ALTER TABLE TBL_TIMER_BLOB_TRIGGERS ADD CONSTRAINT
    FK_TIMER_BT_TRIGGER_NAME_GROUP FOREIGN KEY (TRIGGER_NAME, TRIGGER_GROUP) REFERENCES TBL_TIMER_TRIGGERS(TRIGGER_NAME,TRIGGER_GROUP);

/*
---------------------------------------------
-- Creation of TBL_TIMER_TRIGGER_LISTENERS
---------------------------------------------
*/
CREATE TABLE TBL_TIMER_TRIGGER_LISTENERS (
    TRIGGER_NAME                    VARCHAR(200)                NOT NULL,
    TRIGGER_GROUP                   VARCHAR(200)                NOT NULL,
    TRIGGER_LISTENER                VARCHAR(200)                NOT NULL
);

ALTER TABLE TBL_TIMER_TRIGGER_LISTENERS ADD CONSTRAINT
    PK_TBL_TIMER_TRIGGER_LISTENERS PRIMARY KEY (TRIGGER_NAME, TRIGGER_GROUP, TRIGGER_LISTENER);
ALTER TABLE TBL_TIMER_TRIGGER_LISTENERS ADD CONSTRAINT
    FK_TIMER_TL_TRIGGER_NAME_GROUP FOREIGN KEY (TRIGGER_NAME, TRIGGER_GROUP) REFERENCES TBL_TIMER_TRIGGERS(TRIGGER_NAME, TRIGGER_GROUP);

/*
---------------------------------------------
-- Creation of TBL_TIMER_CALENDARS
---------------------------------------------
*/
CREATE TABLE TBL_TIMER_CALENDARS (
    CALENDAR_NAME                   VARCHAR(200)                NOT NULL,
    CALENDAR                        BLOB                        NOT NULL
);

ALTER TABLE TBL_TIMER_CALENDARS ADD CONSTRAINT
    PK_TBL_TIMER_CALENDARS         PRIMARY KEY (CALENDAR_NAME);

/*
---------------------------------------------
-- Creation of TBL_TIMER_PAUSED_TRIGGER_GRPS
---------------------------------------------
*/
CREATE TABLE TBL_TIMER_PAUSED_TRIGGER_GRPS (
    TRIGGER_GROUP                   VARCHAR(200)                NOT NULL
);

ALTER TABLE TBL_TIMER_PAUSED_TRIGGER_GRPS ADD CONSTRAINT
    PK_TIMER_PAUSED_TRIGGER_GRPS   PRIMARY KEY (TRIGGER_GROUP);

/*
---------------------------------------------
-- Creation of TBL_TIMER_FIRED_TRIGGERS
---------------------------------------------
*/
CREATE TABLE TBL_TIMER_FIRED_TRIGGERS (
    ENTRY_ID                        VARCHAR(95)                 NOT NULL,
    TRIGGER_NAME                    VARCHAR(200)                NOT NULL,
    TRIGGER_GROUP                   VARCHAR(200)                NOT NULL,
    IS_VOLATILE                     VARCHAR(1)                  NOT NULL,
    INSTANCE_NAME                   VARCHAR(200)                NOT NULL,
    FIRED_TIME                      BIGINT(13)                  NOT NULL,
    PRIORITY                        INTEGER                     NULL,
    STATE                           VARCHAR(16)                 NOT NULL,
    JOB_NAME                        VARCHAR(200)                NULL,
    JOB_GROUP                       VARCHAR(200)                NULL,
    IS_STATEFUL                     VARCHAR(1)                  NULL,
    REQUESTS_RECOVERY               VARCHAR(1)                  NULL
);

ALTER TABLE TBL_TIMER_FIRED_TRIGGERS ADD CONSTRAINT
    PK_TBL_TIMER_FIRED_TRIGGERS    PRIMARY KEY (ENTRY_ID);

/*
---------------------------------------------
-- Creation of TBL_TIMER_SCHEDULER_STATE
---------------------------------------------
*/
CREATE TABLE TBL_TIMER_SCHEDULER_STATE (
    INSTANCE_NAME                   VARCHAR(200)                NOT NULL,
    LAST_CHECKIN_TIME               BIGINT(13)                  NOT NULL,
    CHECKIN_INTERVAL                BIGINT(13)                  NOT NULL
);

ALTER TABLE TBL_TIMER_SCHEDULER_STATE ADD CONSTRAINT
    PK_TBL_TIMER_SCHEDULER_STATE   PRIMARY KEY (INSTANCE_NAME);

/*
---------------------------------------------
-- Creation of TBL_TIMER_LOCKS
---------------------------------------------
*/
CREATE TABLE TBL_TIMER_LOCKS (
    LOCK_NAME                       VARCHAR(40)                 NOT NULL
);

ALTER TABLE TBL_TIMER_LOCKS ADD CONSTRAINT
    PK_TBL_TIMER_LOCKS             PRIMARY KEY (LOCK_NAME);

/*
---------------------------------------------
-- Creation of TBL_TIMER_HISTORY
---------------------------------------------
*/
CREATE TABLE TBL_TIMER_HISTORY (
    FIRE_INSTANCE_ID                VARCHAR(100)                NOT NULL,
    JOBSTATE                        VARCHAR(10)                 NULL,
    JOB_GROUP                       VARCHAR(100)                NULL,
    JOB_NAME                        VARCHAR(100)                NULL,
    DESCRIPTION                     VARCHAR(100)                NULL,
    START_TIME                      VARCHAR(100)                NULL,
    RUN_TIME                        VARCHAR(100)                NULL,
    JOB_CLASS                       VARCHAR(100)                NULL,
    CREATE_DATE                     DATE
);
ALTER TABLE TBL_TIMER_HISTORY ADD CONSTRAINT
    PK_FIRE_INSTANCE_ID        PRIMARY KEY (FIRE_INSTANCE_ID);
CREATE INDEX historyCreatedate ON TBL_TIMER_HISTORY(CREATE_DATE);
/*
---------------------------------------------
-- Creation of TBL_TIMER_PRIORITY
---------------------------------------------
*/
CREATE TABLE TBL_TIMER_PRIORITY 
(
  SERVER_NAME                       VARCHAR(100),
  SCHEDULER_NAME                    VARCHAR(100)                NOT NULL,
  VERSION                           INT ,
  PRIMARY KEY (SCHEDULER_NAME)
) ;

/* Different types of timer locks */
INSERT INTO TBL_TIMER_LOCKS
(`LOCK_NAME`)
values
('TRIGGER_ACCESS'),
('JOB_ACCESS'),
('CALENDAR_ACCESS'),
('STATE_ACCESS'),
('MISFIRE_ACCESS');
