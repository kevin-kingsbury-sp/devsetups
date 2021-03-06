--
-- This script is a SAMPLE and can be modified as appropriate by the
-- customer as long as the equivalent tables and indexes are created.
-- The database name, user, and password must match those defined in
-- iiq.properties in the IdentityIQ installation.
--

CREATE DATABASE identityiq
GO

--create a sql server login with which to connect
CREATE LOGIN [identityiq] WITH PASSWORD='sup3rPass',
DEFAULT_DATABASE=identityiq
GO

USE identityiq
GO

--create a user in our db associated with our server login and our schema
CREATE USER identityiq FOR LOGIN identityiq WITH DEFAULT_SCHEMA =
identityiq
GO

-- create a schema
CREATE SCHEMA identityiq AUTHORIZATION identityiq
GO

--grant permissions
grant select,insert,update,delete to identityiq
GO

--this makes our default user the db owner, so it can be
--used to run upgrade scripts.  This is a convenience for
--non-production environments and is not necessary for
--normal IdentityIQ operation.  It is recommended to remove
--this in production environments and run the upgrade scripts
--as another user with db_owner rights.
EXEC sp_addrolemember 'db_owner', 'identityiq'
GO

-- Enable automatic snapshot isolation

ALTER DATABASE identityiq SET ALLOW_SNAPSHOT_ISOLATION ON
GO
ALTER DATABASE identityiq SET READ_COMMITTED_SNAPSHOT ON
GO

CREATE DATABASE identityiqPlugin
GO

--create a sql server login with which to connect
CREATE LOGIN [identityiqPlugin] WITH PASSWORD='sup3rPass',
DEFAULT_DATABASE=identityiqPlugin
GO

USE identityiqPlugin
GO

--create a user in our db associated with our server login and our schema
CREATE USER identityiqPlugin FOR LOGIN identityiqPlugin WITH DEFAULT_SCHEMA =
identityiqPlugin
GO

-- create a schema
CREATE SCHEMA identityiqPlugin AUTHORIZATION identityiqPlugin
GO

--grant permissions
grant select,insert,update,delete,create table to identityiqPlugin
GO

--this makes our default user the db owner, so it can be
--used to run scripts.
EXEC sp_addrolemember 'db_owner', 'identityiqPlugin'
GO

-- Enable automatic snapshot isolation

ALTER DATABASE identityiqPlugin SET ALLOW_SNAPSHOT_ISOLATION ON
GO
ALTER DATABASE identityiqPlugin SET READ_COMMITTED_SNAPSHOT ON
GO

USE identityiq
GO
-- From the Quartz 1.5.2 Distribution
--
-- IdentityIQ NOTES:
--
-- Since things like Application names can make their way into TaskSchedule
-- object names, we are forced to modify the Quartz schema in places where
-- the original column size is insufficient. Thus JOB_NAME and TRIGGER_NAME
-- have been increased from NVARCHAR(80) to NVARCHAR(338).
--
-- Future upgrades to Quartz will have to carry forward these changes.
--
--

CREATE TABLE identityiq.QRTZ221_CALENDARS (
  [SCHED_NAME] [VARCHAR] (120)  NOT NULL ,
  [CALENDAR_NAME] [NVARCHAR] (80)  NOT NULL ,
  [CALENDAR] [IMAGE] NOT NULL
) ON [PRIMARY]
GO

CREATE TABLE identityiq.QRTZ221_CRON_TRIGGERS (
  [SCHED_NAME] [VARCHAR] (120)  NOT NULL ,
  [TRIGGER_NAME] [NVARCHAR] (338)  NOT NULL ,
  [TRIGGER_GROUP] [NVARCHAR] (32)  NOT NULL ,
  [CRON_EXPRESSION] [NVARCHAR] (80)  NOT NULL ,
  [TIME_ZONE_ID] [NVARCHAR] (80)
) ON [PRIMARY]
GO

CREATE TABLE identityiq.QRTZ221_FIRED_TRIGGERS (
  [SCHED_NAME] [VARCHAR] (120)  NOT NULL ,
  [ENTRY_ID] [NVARCHAR] (95)  NOT NULL ,
  [TRIGGER_NAME] [NVARCHAR] (338)  NOT NULL ,
  [TRIGGER_GROUP] [NVARCHAR] (32)  NOT NULL ,
  [INSTANCE_NAME] [NVARCHAR] (80)  NOT NULL ,
  [FIRED_TIME] [BIGINT] NOT NULL ,
  [SCHED_TIME] [BIGINT] NOT NULL ,
  [PRIORITY] [INTEGER] NOT NULL ,
  [STATE] [NVARCHAR] (16)  NOT NULL,
  [JOB_NAME] [NVARCHAR] (338)  NULL ,
  [JOB_GROUP] [NVARCHAR] (32)  NULL ,
  [IS_NONCONCURRENT] [NVARCHAR] (1)  NULL ,
  [REQUESTS_RECOVERY] [NVARCHAR] (1)  NULL
) ON [PRIMARY]
GO

CREATE TABLE identityiq.QRTZ221_PAUSED_TRIGGER_GRPS (
  [SCHED_NAME] [VARCHAR] (120)  NOT NULL ,
  [TRIGGER_GROUP] [NVARCHAR] (32)  NOT NULL
) ON [PRIMARY]
GO

CREATE TABLE identityiq.QRTZ221_SCHEDULER_STATE (
  [SCHED_NAME] [VARCHAR] (120)  NOT NULL ,
  [INSTANCE_NAME] [NVARCHAR] (80)  NOT NULL ,
  [LAST_CHECKIN_TIME] [BIGINT] NOT NULL ,
  [CHECKIN_INTERVAL] [BIGINT] NOT NULL
) ON [PRIMARY]
GO

CREATE TABLE identityiq.QRTZ221_LOCKS (
  [SCHED_NAME] [VARCHAR] (120)  NOT NULL ,
  [LOCK_NAME] [NVARCHAR] (40)  NOT NULL
) ON [PRIMARY]
GO

CREATE TABLE identityiq.QRTZ221_JOB_DETAILS (
  [SCHED_NAME] [VARCHAR] (120)  NOT NULL ,
  [JOB_NAME] [NVARCHAR] (338)  NOT NULL ,
  [JOB_GROUP] [NVARCHAR] (32)  NOT NULL ,
  [DESCRIPTION] [NVARCHAR] (120) NULL ,
  [JOB_CLASS_NAME] [NVARCHAR] (128)  NOT NULL ,
  [IS_DURABLE] [NVARCHAR] (1)  NOT NULL ,
  [IS_NONCONCURRENT] [NVARCHAR] (1)  NOT NULL ,
  [IS_UPDATE_DATA] [NVARCHAR] (1)  NOT NULL ,
  [REQUESTS_RECOVERY] [NVARCHAR] (1)  NOT NULL ,
  [JOB_DATA] [IMAGE] NULL
) ON [PRIMARY]
GO

CREATE TABLE identityiq.QRTZ221_SIMPLE_TRIGGERS (
  [SCHED_NAME] [VARCHAR] (120)  NOT NULL ,
  [TRIGGER_NAME] [NVARCHAR] (338)  NOT NULL ,
  [TRIGGER_GROUP] [NVARCHAR] (32)  NOT NULL ,
  [REPEAT_COUNT] [BIGINT] NOT NULL ,
  [REPEAT_INTERVAL] [BIGINT] NOT NULL ,
  [TIMES_TRIGGERED] [BIGINT] NOT NULL
) ON [PRIMARY]
GO

CREATE TABLE identityiq.[QRTZ221_SIMPROP_TRIGGERS] (
  [SCHED_NAME] [VARCHAR] (120)  NOT NULL ,
  [TRIGGER_NAME] [NVARCHAR] (338)  NOT NULL ,
  [TRIGGER_GROUP] [NVARCHAR] (32)  NOT NULL ,
  [STR_PROP_1] [VARCHAR] (512) NULL,
  [STR_PROP_2] [VARCHAR] (512) NULL,
  [STR_PROP_3] [VARCHAR] (512) NULL,
  [INT_PROP_1] [INT] NULL,
  [INT_PROP_2] [INT] NULL,
  [LONG_PROP_1] [BIGINT] NULL,
  [LONG_PROP_2] [BIGINT] NULL,
  [DEC_PROP_1] [NUMERIC] (13,4) NULL,
  [DEC_PROP_2] [NUMERIC] (13,4) NULL,
  [BOOL_PROP_1] [VARCHAR] (1) NULL,
  [BOOL_PROP_2] [VARCHAR] (1) NULL,
) ON [PRIMARY]
GO

CREATE TABLE identityiq.QRTZ221_BLOB_TRIGGERS (
  [SCHED_NAME] [VARCHAR] (120)  NOT NULL ,
  [TRIGGER_NAME] [NVARCHAR] (338)  NOT NULL ,
  [TRIGGER_GROUP] [NVARCHAR] (32)  NOT NULL ,
  [BLOB_DATA] [IMAGE] NULL
) ON [PRIMARY]
GO

CREATE TABLE identityiq.QRTZ221_TRIGGERS (
  [SCHED_NAME] [VARCHAR] (120)  NOT NULL ,
  [TRIGGER_NAME] [NVARCHAR] (338)  NOT NULL ,
  [TRIGGER_GROUP] [NVARCHAR] (32)  NOT NULL ,
  [JOB_NAME] [NVARCHAR] (338)  NOT NULL ,
  [JOB_GROUP] [NVARCHAR] (32)  NOT NULL ,
  [DESCRIPTION] [VARCHAR] (250) NULL ,
  [NEXT_FIRE_TIME] [BIGINT] NULL ,
  [PREV_FIRE_TIME] [BIGINT] NULL ,
  [PRIORITY] [INTEGER] NULL ,
  [TRIGGER_STATE] [VARCHAR] (16)  NOT NULL ,
  [TRIGGER_TYPE] [VARCHAR] (8)  NOT NULL ,
  [START_TIME] [BIGINT] NOT NULL ,
  [END_TIME] [BIGINT] NULL ,
  [CALENDAR_NAME] [VARCHAR] (200)  NULL ,
  [MISFIRE_INSTR] [SMALLINT] NULL ,
  [JOB_DATA] [IMAGE] NULL
) ON [PRIMARY]
GO

ALTER TABLE identityiq.QRTZ221_CALENDARS WITH NOCHECK ADD
  CONSTRAINT [PK_QRTZ221_CALENDARS] PRIMARY KEY  CLUSTERED
  (
    [SCHED_NAME],
    [CALENDAR_NAME]
  )  ON [PRIMARY]
GO

ALTER TABLE identityiq.QRTZ221_CRON_TRIGGERS WITH NOCHECK ADD
  CONSTRAINT [PK_QRTZ221_CRON_TRIGGERS] PRIMARY KEY  CLUSTERED
  (
    [SCHED_NAME],
    [TRIGGER_NAME],
    [TRIGGER_GROUP]
  )  ON [PRIMARY]
GO

ALTER TABLE identityiq.QRTZ221_FIRED_TRIGGERS WITH NOCHECK ADD
  CONSTRAINT [PK_QRTZ221_FIRED_TRIGGERS] PRIMARY KEY  CLUSTERED
  (
    [SCHED_NAME],
    [ENTRY_ID]
  )  ON [PRIMARY]
GO

ALTER TABLE identityiq.QRTZ221_PAUSED_TRIGGER_GRPS WITH NOCHECK ADD
  CONSTRAINT [PK_QRTZ221_PAUSED_TRIGGER_GRPS] PRIMARY KEY  CLUSTERED
  (
    [SCHED_NAME],
    [TRIGGER_GROUP]
  )  ON [PRIMARY]
GO

ALTER TABLE identityiq.QRTZ221_SCHEDULER_STATE WITH NOCHECK ADD
  CONSTRAINT [PK_QRTZ221_SCHEDULER_STATE] PRIMARY KEY  CLUSTERED
  (
    [SCHED_NAME],
    [INSTANCE_NAME]
  )  ON [PRIMARY]
GO

ALTER TABLE identityiq.QRTZ221_LOCKS WITH NOCHECK ADD
  CONSTRAINT [PK_QRTZ221_LOCKS] PRIMARY KEY  CLUSTERED
  (
    [SCHED_NAME],
    [LOCK_NAME]
  )  ON [PRIMARY]
GO

ALTER TABLE identityiq.QRTZ221_JOB_DETAILS WITH NOCHECK ADD
  CONSTRAINT [PK_QRTZ221_JOB_DETAILS] PRIMARY KEY  CLUSTERED
  (
    [SCHED_NAME],
    [JOB_NAME],
    [JOB_GROUP]
  )  ON [PRIMARY]
GO

ALTER TABLE identityiq.QRTZ221_SIMPLE_TRIGGERS WITH NOCHECK ADD
  CONSTRAINT [PK_QRTZ221_SIMPLE_TRIGGERS] PRIMARY KEY  CLUSTERED
  (
    [SCHED_NAME],
    [TRIGGER_NAME],
    [TRIGGER_GROUP]
  )  ON [PRIMARY]
GO

ALTER TABLE identityiq.QRTZ221_TRIGGERS WITH NOCHECK ADD
  CONSTRAINT [PK_QRTZ221_TRIGGERS] PRIMARY KEY  CLUSTERED
  (
    [SCHED_NAME],
    [TRIGGER_NAME],
    [TRIGGER_GROUP]
  )  ON [PRIMARY]
GO

ALTER TABLE identityiq.QRTZ221_CRON_TRIGGERS ADD
  CONSTRAINT [FK_QRTZ221_CRON_TRIGGERS_QRTZ221_TRIGGERS] FOREIGN KEY
  (
    [SCHED_NAME],
    [TRIGGER_NAME],
    [TRIGGER_GROUP]
  ) REFERENCES identityiq.QRTZ221_TRIGGERS (
    [SCHED_NAME],
    [TRIGGER_NAME],
    [TRIGGER_GROUP]
  ) ON DELETE CASCADE
GO

ALTER TABLE identityiq.QRTZ221_SIMPLE_TRIGGERS ADD
  CONSTRAINT [FK_QRTZ221_SIMPLE_TRIGGERS_QRTZ221_TRIGGERS] FOREIGN KEY
  (
    [SCHED_NAME],
    [TRIGGER_NAME],
    [TRIGGER_GROUP]
  ) REFERENCES identityiq.QRTZ221_TRIGGERS (
    [SCHED_NAME],
    [TRIGGER_NAME],
    [TRIGGER_GROUP]
  ) ON DELETE CASCADE
GO

ALTER TABLE identityiq.QRTZ221_TRIGGERS ADD
  CONSTRAINT [FK_QRTZ221_TRIGGERS_QRTZ221_JOB_DETAILS] FOREIGN KEY
  (
    [SCHED_NAME],
    [JOB_NAME],
    [JOB_GROUP]
  ) REFERENCES identityiq.QRTZ221_JOB_DETAILS (
    [SCHED_NAME],
    [JOB_NAME],
    [JOB_GROUP]
  )
GO

INSERT INTO identityiq.QRTZ221_LOCKS VALUES('QuartzScheduler', 'TRIGGER_ACCESS');
GO
INSERT INTO identityiq.QRTZ221_LOCKS VALUES('QuartzScheduler', 'JOB_ACCESS');
GO
INSERT INTO identityiq.QRTZ221_LOCKS VALUES('QuartzScheduler', 'CALENDAR_ACCESS');
GO
INSERT INTO identityiq.QRTZ221_LOCKS VALUES('QuartzScheduler', 'STATE_ACCESS');
GO
INSERT INTO identityiq.QRTZ221_LOCKS VALUES('QuartzScheduler', 'MISFIRE_ACCESS');
GO

create index idx_qrtz_j_req_recovery on identityiq.QRTZ221_JOB_DETAILS(SCHED_NAME,REQUESTS_RECOVERY);
GO

create index idx_qrtz_j_grp on identityiq.QRTZ221_JOB_DETAILS(SCHED_NAME,JOB_GROUP);
GO

create index idx_qrtz_t_j on identityiq.QRTZ221_TRIGGERS(SCHED_NAME,JOB_NAME,JOB_GROUP);
GO

create index idx_qrtz_t_jg on identityiq.QRTZ221_TRIGGERS(SCHED_NAME,JOB_GROUP);
GO

create index idx_qrtz_t_c on identityiq.QRTZ221_TRIGGERS(SCHED_NAME,CALENDAR_NAME);
GO

create index idx_qrtz_t_g on identityiq.QRTZ221_TRIGGERS(SCHED_NAME,TRIGGER_GROUP);
GO

create index idx_qrtz_t_state on identityiq.QRTZ221_TRIGGERS(SCHED_NAME,TRIGGER_STATE);
GO

create index idx_qrtz_t_n_state on identityiq.QRTZ221_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP,TRIGGER_STATE);
GO

create index idx_qrtz_t_n_g_state on identityiq.QRTZ221_TRIGGERS(SCHED_NAME,TRIGGER_GROUP,TRIGGER_STATE);
GO

create index idx_qrtz_t_next_fire_time on identityiq.QRTZ221_TRIGGERS(SCHED_NAME,NEXT_FIRE_TIME);
GO

create index idx_qrtz_t_nft_st on identityiq.QRTZ221_TRIGGERS(SCHED_NAME,TRIGGER_STATE,NEXT_FIRE_TIME);
GO

create index idx_qrtz_t_nft_misfire on identityiq.QRTZ221_TRIGGERS(SCHED_NAME,MISFIRE_INSTR,NEXT_FIRE_TIME);
GO

create index idx_qrtz_t_nft_st_misfire on identityiq.QRTZ221_TRIGGERS(SCHED_NAME,MISFIRE_INSTR,NEXT_FIRE_TIME,TRIGGER_STATE);
GO

create index idx_qrtz_t_nft_st_misfire_grp on identityiq.QRTZ221_TRIGGERS(SCHED_NAME,MISFIRE_INSTR,NEXT_FIRE_TIME,TRIGGER_GROUP,TRIGGER_STATE);
GO

create index idx_qrtz_ft_trig_inst_name on identityiq.QRTZ221_FIRED_TRIGGERS(SCHED_NAME,INSTANCE_NAME);
GO

create index idx_qrtz_ft_inst_job_req_rcvry on identityiq.QRTZ221_FIRED_TRIGGERS(SCHED_NAME,INSTANCE_NAME,REQUESTS_RECOVERY);
GO

create index idx_qrtz_ft_j_g on identityiq.QRTZ221_FIRED_TRIGGERS(SCHED_NAME,JOB_NAME,JOB_GROUP);
GO

create index idx_qrtz_ft_jg on identityiq.QRTZ221_FIRED_TRIGGERS(SCHED_NAME,JOB_GROUP);
GO

create index idx_qrtz_ft_t_g on identityiq.QRTZ221_FIRED_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP);
GO

create index idx_qrtz_ft_tg on identityiq.QRTZ221_FIRED_TRIGGERS(SCHED_NAME,TRIGGER_GROUP);
GO

-- End Quartz configuration

    create table identityiq.spt_account_group (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(128) null,
        description nvarchar(1024) null,
        native_identity nvarchar(322) null,
        reference_attribute nvarchar(128) null,
        member_attribute nvarchar(128) null,
        last_refresh numeric(19,0) null,
        last_target_aggregation numeric(19,0) null,
        uncorrelated tinyint null,
        application nvarchar(32) null,
        attributes nvarchar(max) null,
        key1 nvarchar(128) null,
        key2 nvarchar(128) null,
        key3 nvarchar(128) null,
        key4 nvarchar(128) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_account_group_inheritance (
        account_group nvarchar(32) not null,
        inherits_from nvarchar(32) not null,
        idx int not null,
        primary key (account_group, idx)
    );
    GO

    create table identityiq.spt_account_group_perms (
        accountgroup nvarchar(32) not null,
        target nvarchar(255) null,
        rights nvarchar(4000) null,
        annotation nvarchar(255) null,
        idx int not null,
        primary key (accountgroup, idx)
    );
    GO

    create table identityiq.spt_account_group_target_perms (
        accountgroup nvarchar(32) not null,
        target nvarchar(255) null,
        rights nvarchar(4000) null,
        annotation nvarchar(255) null,
        idx int not null,
        primary key (accountgroup, idx)
    );
    GO

    create table identityiq.spt_activity_constraint (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(2000) null,
        description nvarchar(4000) null,
        policy nvarchar(32) null,
        violation_owner_type nvarchar(255) null,
        violation_owner nvarchar(32) null,
        violation_owner_rule nvarchar(32) null,
        compensating_control nvarchar(max) null,
        disabled tinyint null,
        weight int null,
        remediation_advice nvarchar(max) null,
        violation_summary nvarchar(max) null,
        identity_filters nvarchar(max) null,
        activity_filters nvarchar(max) null,
        time_periods nvarchar(max) null,
        idx int null,
        primary key (id)
    );
    GO

    create table identityiq.spt_activity_data_source (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(128) not null,
        description nvarchar(1024) null,
        collector nvarchar(255) null,
        type nvarchar(255) null,
        configuration nvarchar(max) null,
        last_refresh numeric(19,0) null,
        targets nvarchar(max) null,
        correlation_rule nvarchar(32) null,
        transformation_rule nvarchar(32) null,
        application nvarchar(32) null,
        idx int null,
        primary key (id)
    );
    GO

    create table identityiq.spt_activity_time_periods (
        application_activity nvarchar(32) not null,
        time_period nvarchar(32) not null,
        idx int not null,
        primary key (application_activity, idx)
    );
    GO

    create table identityiq.spt_alert (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        extended1 nvarchar(255) null,
        attributes nvarchar(max) null,
        source nvarchar(32) null,
        alert_date numeric(19,0) null,
        native_id nvarchar(255) null,
        target_id nvarchar(255) null,
        target_type nvarchar(255) null,
        target_display_name nvarchar(255) null,
        last_processed numeric(19,0) null,
        display_name nvarchar(128) null,
        name nvarchar(255) null,
        type nvarchar(255) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_alert_action (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        alert_def nvarchar(max) null,
        action_type nvarchar(255) null,
        result_id nvarchar(255) null,
        result nvarchar(max) null,
        alert nvarchar(32) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_alert_definition (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        match_config nvarchar(max) null,
        disabled tinyint null,
        name nvarchar(128) not null unique,
        description nvarchar(1024) null,
        display_name nvarchar(128) null,
        action_config nvarchar(max) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_app_dependencies (
        application nvarchar(32) not null,
        dependency nvarchar(32) not null,
        idx int not null,
        primary key (application, idx)
    );
    GO

    create table identityiq.spt_app_secondary_owners (
        application nvarchar(32) not null,
        elt nvarchar(32) not null,
        idx int not null,
        primary key (application, idx)
    );
    GO

    create table identityiq.spt_application (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        extended1 nvarchar(450) null,
        extended2 nvarchar(450) null,
        extended3 nvarchar(450) null,
        extended4 nvarchar(450) null,
        name nvarchar(128) not null unique,
        proxied_name nvarchar(128) null,
        app_cluster nvarchar(255) null,
        icon nvarchar(255) null,
        connector nvarchar(255) null,
        type nvarchar(255) null,
        features_string nvarchar(512) null,
        aggregation_types nvarchar(128) null,
        profile_class nvarchar(255) null,
        authentication_resource tinyint null,
        case_insensitive tinyint null,
        authoritative tinyint null,
        maintenance_expiration numeric(19,0) null,
        logical tinyint null,
        supports_provisioning tinyint null,
        supports_authenticate tinyint null,
        supports_account_only tinyint null,
        supports_additional_accounts tinyint null,
        no_aggregation tinyint null,
        sync_provisioning tinyint null,
        attributes nvarchar(max) null,
        templates nvarchar(max) null,
        provisioning_forms nvarchar(max) null,
        provisioning_config nvarchar(max) null,
        manages_other_apps tinyint not null,
        proxy nvarchar(32) null,
        correlation_rule nvarchar(32) null,
        creation_rule nvarchar(32) null,
        manager_correlation_rule nvarchar(32) null,
        customization_rule nvarchar(32) null,
        managed_attr_customize_rule nvarchar(32) null,
        account_correlation_config nvarchar(32) null,
        scorecard nvarchar(32) null,
        target_source nvarchar(32) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_application_activity (
        id nvarchar(32) not null,
        time_stamp numeric(19,0) null,
        source_application nvarchar(128) null,
        action nvarchar(255) null,
        result nvarchar(255) null,
        data_source nvarchar(128) null,
        instance nvarchar(128) null,
        username nvarchar(128) null,
        target nvarchar(128) null,
        info nvarchar(512) null,
        identity_id nvarchar(128) null,
        identity_name nvarchar(128) null,
        assigned_scope nvarchar(32) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_application_remediators (
        application nvarchar(32) not null,
        elt nvarchar(32) not null,
        idx int not null,
        primary key (application, idx)
    );
    GO

    create table identityiq.spt_application_schema (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(128) null,
        object_type nvarchar(255) null,
        aggregation_type nvarchar(128) null,
        native_object_type nvarchar(255) null,
        identity_attribute nvarchar(255) null,
        display_attribute nvarchar(255) null,
        instance_attribute nvarchar(255) null,
        group_attribute nvarchar(255) null,
        hierarchy_attribute nvarchar(255) null,
        reference_attribute nvarchar(255) null,
        include_permissions tinyint null,
        index_permissions tinyint null,
        child_hierarchy tinyint null,
        perm_remed_mod_type nvarchar(255) null,
        config nvarchar(max) null,
        features_string nvarchar(512) null,
        association_schema_name nvarchar(255) null,
        creation_rule nvarchar(32) null,
        customization_rule nvarchar(32) null,
        correlation_rule nvarchar(32) null,
        refresh_rule nvarchar(32) null,
        application nvarchar(32) null,
        idx int null,
        primary key (id)
    );
    GO

    create table identityiq.spt_application_scorecard (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        incomplete tinyint null,
        composite_score int null,
        attributes nvarchar(max) null,
        items nvarchar(max) null,
        application_id nvarchar(32) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_arch_cert_item_apps (
        arch_cert_item_id nvarchar(32) not null,
        application_name nvarchar(255) null,
        idx int not null,
        primary key (arch_cert_item_id, idx)
    );
    GO

    create table identityiq.spt_archived_cert_entity (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        entity nvarchar(max) null,
        reason nvarchar(255) null,
        explanation nvarchar(max) null,
        certification_id nvarchar(32) null,
        target_name nvarchar(255) null,
        identity_name nvarchar(450) null,
        account_group nvarchar(450) null,
        application nvarchar(255) null,
        native_identity nvarchar(322) null,
        reference_attribute nvarchar(255) null,
        schema_object_type nvarchar(255) null,
        target_id nvarchar(255) null,
        target_display_name nvarchar(255) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_archived_cert_item (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        type nvarchar(255) null,
        sub_type nvarchar(255) null,
        item_id nvarchar(128) null,
        exception_application nvarchar(128) null,
        exception_attribute_name nvarchar(255) null,
        exception_attribute_value nvarchar(2048) null,
        exception_permission_target nvarchar(255) null,
        exception_permission_right nvarchar(255) null,
        exception_native_identity nvarchar(322) null,
        constraint_name nvarchar(2000) null,
        policy nvarchar(256) null,
        bundle nvarchar(255) null,
        violation_summary nvarchar(256) null,
        entitlements nvarchar(max) null,
        parent_id nvarchar(32) null,
        target_display_name nvarchar(255) null,
        target_name nvarchar(255) null,
        target_id nvarchar(255) null,
        idx int null,
        primary key (id)
    );
    GO

    create table identityiq.spt_audit_config (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(128) not null unique,
        disabled tinyint null,
        classes nvarchar(max) null,
        resources nvarchar(max) null,
        attributes nvarchar(max) null,
        actions nvarchar(max) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_audit_event (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        interface nvarchar(128) null,
        source nvarchar(128) null,
        action nvarchar(128) null,
        target nvarchar(255) null,
        application nvarchar(128) null,
        account_name nvarchar(256) null,
        instance nvarchar(128) null,
        attribute_name nvarchar(128) null,
        attribute_value nvarchar(450) null,
        tracking_id nvarchar(128) null,
        attributes nvarchar(max) null,
        string1 nvarchar(450) null,
        string2 nvarchar(450) null,
        string3 nvarchar(450) null,
        string4 nvarchar(450) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_authentication_answer (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        identity_id nvarchar(32) null,
        question_id nvarchar(32) null,
        answer nvarchar(512) null,
        idx int null,
        primary key (id)
    );
    GO

    create table identityiq.spt_authentication_question (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        question nvarchar(1024) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_batch_request (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        file_name nvarchar(255) null,
        header nvarchar(4000) null,
        run_date numeric(19,0) null,
        completed_date numeric(19,0) null,
        record_count int null,
        completed_count int null,
        error_count int null,
        invalid_count int null,
        message nvarchar(4000) null,
        error_message nvarchar(max) null,
        file_contents nvarchar(max) null,
        status nvarchar(255) null,
        run_config nvarchar(max) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_batch_request_item (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        request_data nvarchar(4000) null,
        status nvarchar(255) null,
        message nvarchar(4000) null,
        error_message nvarchar(max) null,
        result nvarchar(255) null,
        identity_request_id nvarchar(255) null,
        target_identity_id nvarchar(255) null,
        batch_request_id nvarchar(32) null,
        idx int null,
        primary key (id)
    );
    GO

    create table identityiq.spt_bundle (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        extended1 nvarchar(450) null,
        extended2 nvarchar(450) null,
        extended3 nvarchar(450) null,
        extended4 nvarchar(450) null,
        name nvarchar(128) not null unique,
        display_name nvarchar(128) null,
        displayable_name nvarchar(128) null,
        disabled tinyint null,
        risk_score_weight int null,
        activity_config nvarchar(max) null,
        mining_statistics nvarchar(max) null,
        attributes nvarchar(max) null,
        type nvarchar(128) null,
        join_rule nvarchar(32) null,
        pending_workflow nvarchar(32) null,
        role_index nvarchar(32) null,
        selector nvarchar(max) null,
        provisioning_plan nvarchar(max) null,
        templates nvarchar(max) null,
        provisioning_forms nvarchar(max) null,
        or_profiles tinyint null,
        activation_date numeric(19,0) null,
        deactivation_date numeric(19,0) null,
        scorecard nvarchar(32) null,
        pending_delete tinyint null,
        primary key (id)
    );
    GO

    create table identityiq.spt_bundle_archive (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(128) null,
        source_id nvarchar(128) null,
        version int null,
        creator nvarchar(128) null,
        archive nvarchar(max) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_bundle_children (
        bundle nvarchar(32) not null,
        child nvarchar(32) not null,
        idx int not null,
        primary key (bundle, idx)
    );
    GO

    create table identityiq.spt_bundle_permits (
        bundle nvarchar(32) not null,
        child nvarchar(32) not null,
        idx int not null,
        primary key (bundle, idx)
    );
    GO

    create table identityiq.spt_bundle_requirements (
        bundle nvarchar(32) not null,
        child nvarchar(32) not null,
        idx int not null,
        primary key (bundle, idx)
    );
    GO

    create table identityiq.spt_capability (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(128) not null unique,
        description nvarchar(1024) null,
        display_name nvarchar(128) null,
        applies_to_analyzer tinyint null,
        primary key (id)
    );
    GO

    create table identityiq.spt_capability_children (
        capability_id nvarchar(32) not null,
        child_id nvarchar(32) not null,
        idx int not null,
        primary key (capability_id, idx)
    );
    GO

    create table identityiq.spt_capability_rights (
        capability_id nvarchar(32) not null,
        right_id nvarchar(32) not null,
        idx int not null,
        primary key (capability_id, idx)
    );
    GO

    create table identityiq.spt_category (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(128) not null unique,
        targets nvarchar(max) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_cert_action_assoc (
        parent_id nvarchar(32) not null,
        child_id nvarchar(32) not null,
        idx int not null,
        primary key (parent_id, idx)
    );
    GO

    create table identityiq.spt_cert_item_applications (
        certification_item_id nvarchar(32) not null,
        application_name nvarchar(255) null,
        idx int not null,
        primary key (certification_item_id, idx)
    );
    GO

    create table identityiq.spt_certification (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        attributes nvarchar(max) null,
        iiqlock nvarchar(128) null,
        name nvarchar(256) null,
        short_name nvarchar(255) null,
        description nvarchar(1024) null,
        creator nvarchar(255) null,
        complete tinyint null,
        complete_hierarchy tinyint null,
        signed numeric(19,0) null,
        approver_rule nvarchar(512) null,
        finished numeric(19,0) null,
        expiration numeric(19,0) null,
        automatic_closing_date numeric(19,0) null,
        application_id nvarchar(255) null,
        manager nvarchar(255) null,
        group_definition nvarchar(512) null,
        group_definition_id nvarchar(128) null,
        group_definition_name nvarchar(255) null,
        comments nvarchar(max) null,
        error nvarchar(max) null,
        entities_to_refresh nvarchar(max) null,
        commands nvarchar(max) null,
        activated numeric(19,0) null,
        total_entities int null,
        excluded_entities int null,
        completed_entities int null,
        delegated_entities int null,
        percent_complete int null,
        certified_entities int null,
        cert_req_entities int null,
        overdue_entities int null,
        total_items int null,
        excluded_items int null,
        completed_items int null,
        delegated_items int null,
        item_percent_complete int null,
        certified_items int null,
        cert_req_items int null,
        overdue_items int null,
        remediations_kicked_off int null,
        remediations_completed int null,
        total_violations int not null,
        violations_allowed int not null,
        violations_remediated int not null,
        violations_acknowledged int not null,
        total_roles int not null,
        roles_approved int not null,
        roles_allowed int not null,
        roles_remediated int not null,
        total_exceptions int not null,
        exceptions_approved int not null,
        exceptions_allowed int not null,
        exceptions_remediated int not null,
        total_grp_perms int not null,
        grp_perms_approved int not null,
        grp_perms_remediated int not null,
        total_grp_memberships int not null,
        grp_memberships_approved int not null,
        grp_memberships_remediated int not null,
        total_accounts int not null,
        accounts_approved int not null,
        accounts_allowed int not null,
        accounts_remediated int not null,
        total_profiles int not null,
        profiles_approved int not null,
        profiles_remediated int not null,
        total_scopes int not null,
        scopes_approved int not null,
        scopes_remediated int not null,
        total_capabilities int not null,
        capabilities_approved int not null,
        capabilities_remediated int not null,
        total_permits int not null,
        permits_approved int not null,
        permits_remediated int not null,
        total_requirements int not null,
        requirements_approved int not null,
        requirements_remediated int not null,
        total_hierarchies int not null,
        hierarchies_approved int not null,
        hierarchies_remediated int not null,
        type nvarchar(255) null,
        task_schedule_id nvarchar(255) null,
        trigger_id nvarchar(128) null,
        certification_definition_id nvarchar(128) null,
        phase nvarchar(255) null,
        next_phase_transition numeric(19,0) null,
        phase_config nvarchar(max) null,
        process_revokes_immediately tinyint null,
        next_remediation_scan numeric(19,0) null,
        entitlement_granularity nvarchar(255) null,
        bulk_reassignment tinyint null,
        continuous tinyint null,
        continuous_config nvarchar(max) null,
        next_cert_required_scan numeric(19,0) null,
        next_overdue_scan numeric(19,0) null,
        exclude_inactive tinyint null,
        parent nvarchar(32) null,
        immutable tinyint null,
        electronically_signed tinyint null,
        self_cert_reassignment tinyint null,
        idx int null,
        primary key (id)
    );
    GO

    create table identityiq.spt_certification_action (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        owner_name nvarchar(255) null,
        email_template nvarchar(255) null,
        comments nvarchar(max) null,
        expiration datetime null,
        work_item nvarchar(255) null,
        completion_state nvarchar(255) null,
        completion_comments nvarchar(max) null,
        completion_user nvarchar(128) null,
        actor_name nvarchar(128) null,
        actor_display_name nvarchar(128) null,
        acting_work_item nvarchar(255) null,
        description nvarchar(1024) null,
        status nvarchar(255) null,
        decision_date numeric(19,0) null,
        decision_certification_id nvarchar(128) null,
        reviewed tinyint null,
        bulk_certified tinyint null,
        mitigation_expiration numeric(19,0) null,
        remediation_action nvarchar(255) null,
        remediation_details nvarchar(max) null,
        additional_actions nvarchar(max) null,
        revoke_account tinyint null,
        ready_for_remediation tinyint null,
        remediation_kicked_off tinyint null,
        remediation_completed tinyint null,
        source_action nvarchar(32) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_certification_archive (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(256) null,
        certification_id nvarchar(255) null,
        certification_group_id nvarchar(255) null,
        signed numeric(19,0) null,
        expiration numeric(19,0) null,
        creator nvarchar(128) null,
        comments nvarchar(max) null,
        archive nvarchar(max) null,
        immutable tinyint null,
        primary key (id)
    );
    GO

    create table identityiq.spt_certification_challenge (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        owner_name nvarchar(255) null,
        email_template nvarchar(255) null,
        comments nvarchar(max) null,
        expiration datetime null,
        work_item nvarchar(255) null,
        completion_state nvarchar(255) null,
        completion_comments nvarchar(max) null,
        completion_user nvarchar(128) null,
        actor_name nvarchar(128) null,
        actor_display_name nvarchar(128) null,
        acting_work_item nvarchar(255) null,
        description nvarchar(1024) null,
        challenged tinyint null,
        decision nvarchar(255) null,
        decision_comments nvarchar(max) null,
        decider_name nvarchar(255) null,
        challenge_decision_expired tinyint null,
        primary key (id)
    );
    GO

    create table identityiq.spt_certification_def_tags (
        cert_def_id nvarchar(32) not null,
        elt nvarchar(32) not null,
        idx int not null,
        primary key (cert_def_id, idx)
    );
    GO

    create table identityiq.spt_certification_definition (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(255) not null unique,
        description nvarchar(1024) null,
        attributes nvarchar(max) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_certification_delegation (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        owner_name nvarchar(255) null,
        email_template nvarchar(255) null,
        comments nvarchar(max) null,
        expiration datetime null,
        work_item nvarchar(255) null,
        completion_state nvarchar(255) null,
        completion_comments nvarchar(max) null,
        completion_user nvarchar(128) null,
        actor_name nvarchar(128) null,
        actor_display_name nvarchar(128) null,
        acting_work_item nvarchar(255) null,
        description nvarchar(1024) null,
        review_required tinyint null,
        revoked tinyint null,
        primary key (id)
    );
    GO

    create table identityiq.spt_certification_entity (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        action nvarchar(32) null,
        delegation nvarchar(32) null,
        completed numeric(19,0) null,
        summary_status nvarchar(255) null,
        continuous_state nvarchar(255) null,
        last_decision numeric(19,0) null,
        next_continuous_state_change numeric(19,0) null,
        overdue_date numeric(19,0) null,
        has_differences tinyint null,
        action_required tinyint null,
        target_display_name nvarchar(255) null,
        target_name nvarchar(255) null,
        target_id nvarchar(255) null,
        custom1 nvarchar(450) null,
        custom2 nvarchar(450) null,
        custom_map nvarchar(max) null,
        type nvarchar(255) null,
        bulk_certified tinyint null,
        attributes nvarchar(max) null,
        identity_id nvarchar(450) null,
        firstname nvarchar(255) null,
        lastname nvarchar(255) null,
        composite_score int null,
        snapshot_id nvarchar(255) null,
        differences nvarchar(max) null,
        new_user tinyint null,
        account_group nvarchar(450) null,
        application nvarchar(255) null,
        native_identity nvarchar(322) null,
        reference_attribute nvarchar(255) null,
        schema_object_type nvarchar(255) null,
        certification_id nvarchar(32) null,
        pending_certification nvarchar(32) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_certification_group (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(256) null,
        type nvarchar(255) null,
        status nvarchar(255) null,
        attributes nvarchar(max) null,
        total_certifications int null,
        percent_complete int null,
        completed_certifications int null,
        certification_definition nvarchar(32) null,
        messages nvarchar(max) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_certification_groups (
        certification_id nvarchar(32) not null,
        group_id nvarchar(32) not null,
        idx int not null,
        primary key (certification_id, idx)
    );
    GO

    create table identityiq.spt_certification_item (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        action nvarchar(32) null,
        delegation nvarchar(32) null,
        completed numeric(19,0) null,
        summary_status nvarchar(255) null,
        continuous_state nvarchar(255) null,
        last_decision numeric(19,0) null,
        next_continuous_state_change numeric(19,0) null,
        overdue_date numeric(19,0) null,
        has_differences tinyint null,
        action_required tinyint null,
        target_display_name nvarchar(255) null,
        target_name nvarchar(255) null,
        target_id nvarchar(255) null,
        custom1 nvarchar(450) null,
        custom2 nvarchar(450) null,
        custom_map nvarchar(max) null,
        bundle nvarchar(255) null,
        type nvarchar(255) null,
        sub_type nvarchar(255) null,
        bundle_assignment_id nvarchar(128) null,
        certification_entity_id nvarchar(32) null,
        exception_entitlements nvarchar(32) null,
        needs_refresh tinyint null,
        exception_application nvarchar(128) null,
        exception_attribute_name nvarchar(255) null,
        exception_attribute_value nvarchar(2048) null,
        exception_permission_target nvarchar(255) null,
        exception_permission_right nvarchar(255) null,
        policy_violation nvarchar(max) null,
        violation_summary nvarchar(256) null,
        challenge nvarchar(32) null,
        wake_up_date numeric(19,0) null,
        reminders_sent int null,
        needs_continuous_flush tinyint null,
        phase nvarchar(255) null,
        next_phase_transition numeric(19,0) null,
        finished_date numeric(19,0) null,
        recommend_value nvarchar(100) null,
        attributes nvarchar(max) null,
        extended1 nvarchar(450) null,
        extended2 nvarchar(450) null,
        extended3 nvarchar(450) null,
        extended4 nvarchar(450) null,
        extended5 nvarchar(450) null,
        idx int null,
        primary key (id)
    );
    GO

    create table identityiq.spt_certification_tags (
        certification_id nvarchar(32) not null,
        elt nvarchar(32) not null,
        idx int not null,
        primary key (certification_id, idx)
    );
    GO

    create table identityiq.spt_certifiers (
        certification_id nvarchar(32) not null,
        certifier nvarchar(255) null,
        idx int not null,
        primary key (certification_id, idx)
    );
    GO

    create table identityiq.spt_child_certification_ids (
        certification_archive_id nvarchar(32) not null,
        child_id nvarchar(255) null,
        idx int not null,
        primary key (certification_archive_id, idx)
    );
    GO

    create table identityiq.spt_configuration (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(128) not null unique,
        description nvarchar(1024) null,
        attributes nvarchar(max) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_correlation_config (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(128) not null unique,
        description nvarchar(256) null,
        attribute_assignments nvarchar(max) null,
        direct_assignments nvarchar(max) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_custom (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(128) null,
        description nvarchar(1024) null,
        attributes nvarchar(max) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_dashboard_content (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(128) not null unique,
        description nvarchar(1024) null,
        title nvarchar(255) null,
        source nvarchar(255) null,
        required tinyint null,
        region_size nvarchar(255) null,
        source_task_id nvarchar(128) null,
        type nvarchar(255) null,
        parent nvarchar(32) null,
        arguments nvarchar(max) null,
        enabling_attributes nvarchar(max) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_dashboard_content_rights (
        dashboard_content_id nvarchar(32) not null,
        right_id nvarchar(32) not null,
        idx int not null,
        primary key (dashboard_content_id, idx)
    );
    GO

    create table identityiq.spt_dashboard_layout (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(128) not null unique,
        type nvarchar(255) null,
        regions nvarchar(max) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_dashboard_reference (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        identity_dashboard_id nvarchar(32) null,
        content_id nvarchar(32) null,
        region nvarchar(128) null,
        order_id int null,
        minimized tinyint null,
        arguments nvarchar(max) null,
        idx int null,
        primary key (id)
    );
    GO

    create table identityiq.spt_database_version (
        name nvarchar(255) not null,
        system_version nvarchar(128) null,
        schema_version nvarchar(128) null,
        primary key (name)
    );
    GO

    create table identityiq.spt_deleted_object (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        uuid nvarchar(128) null,
        name nvarchar(128) null,
        native_identity nvarchar(322) not null,
        last_refresh numeric(19,0) null,
        object_type nvarchar(128) null,
        application nvarchar(32) null,
        attributes nvarchar(max) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_dictionary (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(128) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_dictionary_term (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        value nvarchar(128) not null unique,
        dictionary_id nvarchar(32) null,
        idx int null,
        primary key (id)
    );
    GO

    create table identityiq.spt_dynamic_scope (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(128) not null unique,
        description nvarchar(1024) null,
        selector nvarchar(max) null,
        allow_all tinyint null,
        population_request_authority nvarchar(max) null,
        role_request_control nvarchar(32) null,
        application_request_control nvarchar(32) null,
        managed_attr_request_control nvarchar(32) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_dynamic_scope_exclusions (
        dynamic_scope_id nvarchar(32) not null,
        identity_id nvarchar(32) not null,
        idx int not null,
        primary key (dynamic_scope_id, idx)
    );
    GO

    create table identityiq.spt_dynamic_scope_inclusions (
        dynamic_scope_id nvarchar(32) not null,
        identity_id nvarchar(32) not null,
        idx int not null,
        primary key (dynamic_scope_id, idx)
    );
    GO

    create table identityiq.spt_email_template (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(128) not null unique,
        description nvarchar(1024) null,
        from_address nvarchar(255) null,
        to_address nvarchar(255) null,
        cc_address nvarchar(255) null,
        bcc_address nvarchar(255) null,
        subject nvarchar(255) null,
        body nvarchar(max) null,
        signature nvarchar(max) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_email_template_properties (
        id nvarchar(32) not null,
        value nvarchar(255) null,
        name nvarchar(78) not null,
        primary key (id, name)
    );
    GO

    create table identityiq.spt_entitlement_group (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(128) null,
        application nvarchar(32) null,
        instance nvarchar(128) null,
        native_identity nvarchar(322) null,
        display_name nvarchar(128) null,
        account_only tinyint not null,
        attributes nvarchar(max) null,
        identity_id nvarchar(32) null,
        idx int null,
        primary key (id)
    );
    GO

    create table identityiq.spt_entitlement_snapshot (
        id nvarchar(32) not null,
        application nvarchar(255) null,
        instance nvarchar(128) null,
        native_identity nvarchar(322) null,
        display_name nvarchar(450) null,
        account_only tinyint not null,
        attributes nvarchar(max) null,
        certification_item_id nvarchar(32) null,
        idx int null,
        primary key (id)
    );
    GO

    create table identityiq.spt_file_bucket (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        file_index int null,
        parent_id nvarchar(32) null,
        data image null,
        primary key (id)
    );
    GO

    create table identityiq.spt_form (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(128) not null unique,
        description nvarchar(4000) null,
        hidden tinyint null,
        type nvarchar(255) null,
        application nvarchar(32) null,
        sections nvarchar(max) null,
        buttons nvarchar(max) null,
        attributes nvarchar(max) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_full_text_index (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        name nvarchar(128) not null unique,
        description nvarchar(1024) null,
        iiqlock nvarchar(128) null,
        last_refresh numeric(19,0) null,
        attributes nvarchar(max) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_generic_constraint (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(2000) null,
        description nvarchar(4000) null,
        policy nvarchar(32) null,
        violation_owner_type nvarchar(255) null,
        violation_owner nvarchar(32) null,
        violation_owner_rule nvarchar(32) null,
        compensating_control nvarchar(max) null,
        disabled tinyint null,
        weight int null,
        remediation_advice nvarchar(max) null,
        violation_summary nvarchar(max) null,
        arguments nvarchar(max) null,
        selectors nvarchar(max) null,
        idx int null,
        primary key (id)
    );
    GO

    create table identityiq.spt_group_definition (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(255) null,
        description nvarchar(1024) null,
        filter nvarchar(max) null,
        last_refresh numeric(19,0) null,
        null_group tinyint null,
        indexed tinyint null,
        private tinyint null,
        factory nvarchar(32) null,
        group_index nvarchar(32) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_group_factory (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(255) null,
        description nvarchar(1024) null,
        factory_attribute nvarchar(255) null,
        enabled tinyint null,
        last_refresh numeric(19,0) null,
        group_owner_rule nvarchar(32) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_group_index (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        incomplete tinyint null,
        composite_score int null,
        attributes nvarchar(max) null,
        items nvarchar(max) null,
        business_role_score int null,
        raw_business_role_score int null,
        entitlement_score int null,
        raw_entitlement_score int null,
        policy_score int null,
        raw_policy_score int null,
        certification_score int null,
        total_violations int null,
        total_remediations int null,
        total_delegations int null,
        total_mitigations int null,
        total_approvals int null,
        definition nvarchar(32) null,
        name nvarchar(255) null,
        member_count int null,
        band_count int null,
        band1 int null,
        band2 int null,
        band3 int null,
        band4 int null,
        band5 int null,
        band6 int null,
        band7 int null,
        band8 int null,
        band9 int null,
        band10 int null,
        certifications_due int null,
        certifications_on_time int null,
        primary key (id)
    );
    GO

    create table identityiq.spt_group_permissions (
        entitlement_group_id nvarchar(32) not null,
        target nvarchar(255) null,
        annotation nvarchar(255) null,
        rights nvarchar(4000) null,
        attributes nvarchar(max) null,
        idx int not null,
        primary key (entitlement_group_id, idx)
    );
    GO

    create table identityiq.spt_identity (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        extended1 nvarchar(450) null,
        extended2 nvarchar(450) null,
        extended3 nvarchar(450) null,
        extended4 nvarchar(450) null,
        extended5 nvarchar(450) null,
        extended6 nvarchar(450) null,
        extended7 nvarchar(450) null,
        extended8 nvarchar(450) null,
        extended9 nvarchar(450) null,
        extended10 nvarchar(450) null,
        extended_identity1 nvarchar(32) null,
        extended_identity2 nvarchar(32) null,
        extended_identity3 nvarchar(32) null,
        extended_identity4 nvarchar(32) null,
        extended_identity5 nvarchar(32) null,
        name nvarchar(128) not null unique,
        description nvarchar(1024) null,
        protected tinyint null,
        needs_refresh tinyint null,
        iiqlock nvarchar(128) null,
        attributes nvarchar(max) null,
        manager nvarchar(32) null,
        display_name nvarchar(128) null,
        firstname nvarchar(128) null,
        lastname nvarchar(128) null,
        email nvarchar(128) null,
        manager_status tinyint null,
        inactive tinyint null,
        last_login numeric(19,0) null,
        last_refresh numeric(19,0) null,
        password nvarchar(450) null,
        password_expiration numeric(19,0) null,
        password_history nvarchar(2000) null,
        bundle_summary nvarchar(2000) null,
        assigned_role_summary nvarchar(2000) null,
        correlated tinyint null,
        correlated_overridden tinyint null,
        type nvarchar(128) null,
        software_version nvarchar(128) null,
        administrator nvarchar(32) null,
        auth_lock_start numeric(19,0) null,
        failed_auth_question_attempts int null,
        failed_login_attempts int null,
        controls_assigned_scope tinyint null,
        certifications nvarchar(max) null,
        activity_config nvarchar(max) null,
        preferences nvarchar(max) null,
        scorecard nvarchar(32) null,
        uipreferences nvarchar(32) null,
        attribute_meta_data nvarchar(max) null,
        workgroup tinyint null,
        primary key (id)
    );
    GO

    create table identityiq.spt_identity_archive (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(128) null,
        source_id nvarchar(128) null,
        version int null,
        creator nvarchar(128) null,
        archive nvarchar(max) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_identity_assigned_roles (
        identity_id nvarchar(32) not null,
        bundle nvarchar(32) not null,
        idx int not null,
        primary key (identity_id, idx)
    );
    GO

    create table identityiq.spt_identity_bundles (
        identity_id nvarchar(32) not null,
        bundle nvarchar(32) not null,
        idx int not null,
        primary key (identity_id, idx)
    );
    GO

    create table identityiq.spt_identity_capabilities (
        identity_id nvarchar(32) not null,
        capability_id nvarchar(32) not null,
        idx int not null,
        primary key (identity_id, idx)
    );
    GO

    create table identityiq.spt_identity_controlled_scopes (
        identity_id nvarchar(32) not null,
        scope_id nvarchar(32) not null,
        idx int not null,
        primary key (identity_id, idx)
    );
    GO

    create table identityiq.spt_identity_dashboard (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(128) null,
        description nvarchar(1024) null,
        identity_id nvarchar(32) null,
        type nvarchar(255) null,
        layout nvarchar(32) null,
        arguments nvarchar(max) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_identity_entitlement (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        start_date numeric(19,0) null,
        end_date numeric(19,0) null,
        attributes nvarchar(max) null,
        name nvarchar(255) null,
        value nvarchar(450) null,
        annotation nvarchar(450) null,
        display_name nvarchar(255) null,
        native_identity nvarchar(450) null,
        instance nvarchar(128) null,
        application nvarchar(32) null,
        identity_id nvarchar(32) not null,
        aggregation_state nvarchar(255) null,
        source nvarchar(64) null,
        assigned tinyint null,
        allowed tinyint null,
        granted_by_role tinyint null,
        assigner nvarchar(128) null,
        assignment_id nvarchar(64) null,
        assignment_note nvarchar(1024) null,
        type nvarchar(255) null,
        request_item nvarchar(32) null,
        pending_request_item nvarchar(32) null,
        certification_item nvarchar(32) null,
        pending_certification_item nvarchar(32) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_identity_external_attr (
        id nvarchar(32) not null,
        object_id nvarchar(64) null,
        attribute_name nvarchar(64) null,
        value nvarchar(322) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_identity_history_item (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        identity_id nvarchar(32) null,
        type nvarchar(255) null,
        certifiable_descriptor nvarchar(max) null,
        action nvarchar(max) null,
        certification_link nvarchar(max) null,
        comments nvarchar(max) null,
        certification_type nvarchar(255) null,
        status nvarchar(255) null,
        actor nvarchar(128) null,
        entry_date numeric(19,0) null,
        application nvarchar(128) null,
        instance nvarchar(128) null,
        account nvarchar(128) null,
        native_identity nvarchar(322) null,
        attribute nvarchar(450) null,
        value nvarchar(450) null,
        policy nvarchar(255) null,
        constraint_name nvarchar(2000) null,
        role nvarchar(255) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_identity_request (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(255) null,
        state nvarchar(255) null,
        type nvarchar(255) null,
        source nvarchar(255) null,
        target_id nvarchar(128) null,
        target_display_name nvarchar(255) null,
        target_class nvarchar(255) null,
        requester_display_name nvarchar(255) null,
        requester_id nvarchar(128) null,
        end_date numeric(19,0) null,
        verified numeric(19,0) null,
        priority nvarchar(128) null,
        completion_status nvarchar(128) null,
        execution_status nvarchar(128) null,
        has_messages tinyint not null,
        external_ticket_id nvarchar(128) null,
        attributes nvarchar(max) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_identity_request_item (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        start_date numeric(19,0) null,
        end_date numeric(19,0) null,
        attributes nvarchar(max) null,
        name nvarchar(255) null,
        value nvarchar(450) null,
        annotation nvarchar(450) null,
        display_name nvarchar(255) null,
        native_identity nvarchar(450) null,
        instance nvarchar(128) null,
        application nvarchar(255) null,
        owner_name nvarchar(128) null,
        approver_name nvarchar(128) null,
        operation nvarchar(128) null,
        retries int null,
        provisioning_engine nvarchar(255) null,
        approval_state nvarchar(128) null,
        provisioning_state nvarchar(128) null,
        compilation_status nvarchar(128) null,
        expansion_cause nvarchar(128) null,
        identity_request_id nvarchar(32) null,
        idx int null,
        primary key (id)
    );
    GO

    create table identityiq.spt_identity_role_metadata (
        identity_id nvarchar(32) not null,
        role_metadata_id nvarchar(32) not null,
        idx int not null,
        primary key (identity_id, idx)
    );
    GO

    create table identityiq.spt_identity_snapshot (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(128) null,
        identity_id nvarchar(255) null,
        identity_name nvarchar(255) null,
        summary nvarchar(2000) null,
        differences nvarchar(2000) null,
        applications nvarchar(2000) null,
        scorecard nvarchar(max) null,
        attributes nvarchar(max) null,
        bundles nvarchar(max) null,
        exceptions nvarchar(max) null,
        links nvarchar(max) null,
        violations nvarchar(max) null,
        assigned_roles nvarchar(max) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_identity_trigger (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(256) null,
        description nvarchar(1024) null,
        disabled tinyint null,
        type nvarchar(255) null,
        rule_id nvarchar(32) null,
        attribute_name nvarchar(256) null,
        old_value_filter nvarchar(256) null,
        new_value_filter nvarchar(256) null,
        selector nvarchar(max) null,
        handler nvarchar(256) null,
        parameters nvarchar(max) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_identity_workgroups (
        identity_id nvarchar(32) not null,
        workgroup nvarchar(32) not null,
        idx int not null,
        primary key (identity_id, idx)
    );
    GO

    create table identityiq.spt_integration_config (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(128) not null unique,
        description nvarchar(4000) null,
        executor nvarchar(255) null,
        exec_style nvarchar(255) null,
        role_sync_style nvarchar(255) null,
        template tinyint null,
        signature nvarchar(max) null,
        attributes nvarchar(max) null,
        plan_initializer nvarchar(32) null,
        resources nvarchar(max) null,
        application_id nvarchar(32) null,
        role_sync_filter nvarchar(max) null,
        container_id nvarchar(32) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_jasper_files (
        result nvarchar(32) not null,
        elt nvarchar(32) not null,
        idx int not null,
        primary key (result, idx)
    );
    GO

    create table identityiq.spt_jasper_page_bucket (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        bucket_number int null,
        handler_id nvarchar(128) null,
        xml nvarchar(max) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_jasper_result (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        handler_id nvarchar(128) null,
        print_xml nvarchar(max) null,
        page_count int null,
        pages_per_bucket int null,
        handler_page_count int null,
        attributes nvarchar(max) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_jasper_template (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(128) not null unique,
        design_xml nvarchar(max) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_link (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        key1 nvarchar(450) null,
        key2 nvarchar(255) null,
        key3 nvarchar(255) null,
        key4 nvarchar(255) null,
        extended1 nvarchar(450) null,
        extended2 nvarchar(450) null,
        extended3 nvarchar(450) null,
        extended4 nvarchar(450) null,
        extended5 nvarchar(450) null,
        uuid nvarchar(128) null,
        display_name nvarchar(128) null,
        instance nvarchar(128) null,
        native_identity nvarchar(322) not null,
        last_refresh numeric(19,0) null,
        last_target_aggregation numeric(19,0) null,
        manually_correlated tinyint null,
        entitlements tinyint not null,
        identity_id nvarchar(32) null,
        application nvarchar(32) null,
        attributes nvarchar(max) null,
        password_history nvarchar(2000) null,
        component_ids nvarchar(256) null,
        attribute_meta_data nvarchar(max) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_link_external_attr (
        id nvarchar(32) not null,
        object_id nvarchar(64) null,
        attribute_name nvarchar(64) null,
        value nvarchar(322) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_localized_attribute (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        name nvarchar(255) null,
        locale nvarchar(128) null,
        attribute nvarchar(128) null,
        value nvarchar(1024) null,
        target_class nvarchar(255) null,
        target_name nvarchar(255) null,
        target_id nvarchar(255) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_managed_attr_inheritance (
        managedattribute nvarchar(32) not null,
        inherits_from nvarchar(32) not null,
        idx int not null,
        primary key (managedattribute, idx)
    );
    GO

    create table identityiq.spt_managed_attr_perms (
        managedattribute nvarchar(32) not null,
        target nvarchar(255) null,
        rights nvarchar(4000) null,
        annotation nvarchar(255) null,
        attributes nvarchar(max) null,
        idx int not null,
        primary key (managedattribute, idx)
    );
    GO

    create table identityiq.spt_managed_attr_target_perms (
        managedattribute nvarchar(32) not null,
        target nvarchar(255) null,
        rights nvarchar(4000) null,
        annotation nvarchar(255) null,
        attributes nvarchar(max) null,
        idx int not null,
        primary key (managedattribute, idx)
    );
    GO

    create table identityiq.spt_managed_attribute (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        extended1 nvarchar(450) null,
        extended2 nvarchar(450) null,
        extended3 nvarchar(450) null,
        purview nvarchar(128) null,
        application nvarchar(32) null,
        type nvarchar(255) null,
        aggregated tinyint null,
        attribute nvarchar(322) null,
        value nvarchar(450) null,
        hash nvarchar(128) not null unique,
        display_name nvarchar(450) null,
        displayable_name nvarchar(450) null,
        uuid nvarchar(128) null,
        attributes nvarchar(max) null,
        requestable tinyint null,
        uncorrelated tinyint null,
        last_refresh numeric(19,0) null,
        last_target_aggregation numeric(19,0) null,
        key1 nvarchar(128) null,
        key2 nvarchar(128) null,
        key3 nvarchar(128) null,
        key4 nvarchar(128) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_message_template (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(128) not null unique,
        description nvarchar(1024) null,
        text nvarchar(max) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_mining_config (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(128) not null unique,
        description nvarchar(1024) null,
        arguments nvarchar(max) null,
        app_constraints nvarchar(max) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_mitigation_expiration (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        expiration numeric(19,0) not null,
        mitigator nvarchar(32) not null,
        comments nvarchar(max) null,
        identity_id nvarchar(32) null,
        certification_link nvarchar(max) null,
        certifiable_descriptor nvarchar(max) null,
        action nvarchar(255) null,
        action_parameters nvarchar(max) null,
        last_action_date numeric(19,0) null,
        role_name nvarchar(128) null,
        policy nvarchar(128) null,
        constraint_name nvarchar(2000) null,
        application nvarchar(128) null,
        instance nvarchar(128) null,
        native_identity nvarchar(322) null,
        account_display_name nvarchar(128) null,
        attribute_name nvarchar(450) null,
        attribute_value nvarchar(450) null,
        permission tinyint null,
        idx int null,
        primary key (id)
    );
    GO

    create table identityiq.spt_module (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        name nvarchar(128) not null unique,
        description nvarchar(512) null,
        attributes nvarchar(max) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_monitoring_statistic (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(128) not null unique,
        display_name nvarchar(128) null,
        description nvarchar(1024) null,
        value nvarchar(4000) null,
        value_type nvarchar(128) null,
        type nvarchar(128) null,
        attributes nvarchar(max) null,
        template tinyint null,
        primary key (id)
    );
    GO

    create table identityiq.spt_monitoring_statistic_tags (
        statistic_id nvarchar(32) not null,
        elt nvarchar(32) not null
    );
    GO

    create table identityiq.spt_object_config (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(128) not null unique,
        object_attributes nvarchar(max) null,
        config_attributes nvarchar(max) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_partition_result (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        stack nvarchar(max) null,
        attributes nvarchar(max) null,
        launcher nvarchar(255) null,
        host nvarchar(255) null,
        launched numeric(19,0) null,
        progress nvarchar(255) null,
        percent_complete int null,
        type nvarchar(255) null,
        messages nvarchar(max) null,
        completed numeric(19,0) null,
        task_result nvarchar(32) null,
        name nvarchar(255) not null unique,
        task_terminated tinyint null,
        completion_status nvarchar(255) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_password_policy (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        name nvarchar(128) not null unique,
        description nvarchar(512) null,
        password_constraints nvarchar(max) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_password_policy_holder (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        policy nvarchar(32) null,
        selector nvarchar(max) null,
        application nvarchar(32) null,
        idx int null,
        primary key (id)
    );
    GO

    create table identityiq.spt_persisted_file (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(256) null,
        description nvarchar(1024) null,
        content_type nvarchar(128) null,
        content_length numeric(19,0) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_plugin (
        id nvarchar(32) not null,
        name nvarchar(255) null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        install_date numeric(19,0) null,
        display_name nvarchar(255) null,
        version nvarchar(255) null,
        disabled tinyint null,
        right_required nvarchar(255) null,
        min_system_version nvarchar(255) null,
        max_system_version nvarchar(255) null,
        attributes nvarchar(max) null,
        position int null,
        certification_level nvarchar(255) null,
        file_id nvarchar(32) null unique,
        primary key (id)
    );
    GO

    create table identityiq.spt_policy (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(128) not null unique,
        template tinyint null,
        type nvarchar(255) null,
        type_key nvarchar(255) null,
        executor nvarchar(255) null,
        config_page nvarchar(255) null,
        certification_actions nvarchar(255) null,
        violation_owner_type nvarchar(255) null,
        violation_owner nvarchar(32) null,
        violation_owner_rule nvarchar(32) null,
        state nvarchar(255) null,
        arguments nvarchar(max) null,
        signature nvarchar(max) null,
        alert nvarchar(max) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_policy_violation (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(2000) null,
        description nvarchar(4000) null,
        identity_id nvarchar(32) null,
        pending_workflow nvarchar(32) null,
        renderer nvarchar(255) null,
        active tinyint null,
        policy_id nvarchar(255) null,
        policy_name nvarchar(255) null,
        constraint_id nvarchar(255) null,
        status nvarchar(255) null,
        constraint_name nvarchar(2000) null,
        left_bundles nvarchar(max) null,
        right_bundles nvarchar(max) null,
        activity_id nvarchar(255) null,
        bundles_marked_for_remediation nvarchar(max) null,
        entitlements_marked_for_remed nvarchar(max) null,
        mitigator nvarchar(255) null,
        arguments nvarchar(max) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_process_log (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        process_name nvarchar(128) null,
        case_id nvarchar(128) null,
        workflow_case_name nvarchar(450) null,
        launcher nvarchar(128) null,
        case_status nvarchar(128) null,
        step_name nvarchar(128) null,
        approval_name nvarchar(128) null,
        owner_name nvarchar(128) null,
        start_time numeric(19,0) null,
        end_time numeric(19,0) null,
        step_duration int null,
        escalations int null,
        primary key (id)
    );
    GO

    create table identityiq.spt_profile (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(128) null,
        description nvarchar(1024) null,
        bundle_id nvarchar(32) null,
        disabled tinyint null,
        account_type nvarchar(128) null,
        application nvarchar(32) null,
        attributes nvarchar(max) null,
        idx int null,
        primary key (id)
    );
    GO

    create table identityiq.spt_profile_constraints (
        profile nvarchar(32) not null,
        elt nvarchar(max) null,
        idx int not null,
        primary key (profile, idx)
    );
    GO

    create table identityiq.spt_profile_permissions (
        profile nvarchar(32) not null,
        target nvarchar(255) null,
        rights nvarchar(4000) null,
        attributes nvarchar(max) null,
        idx int not null,
        primary key (profile, idx)
    );
    GO

    create table identityiq.spt_provisioning_request (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        identity_id nvarchar(32) null,
        target nvarchar(128) null,
        requester nvarchar(128) null,
        expiration numeric(19,0) null,
        provisioning_plan nvarchar(max) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_provisioning_transaction (
        id nvarchar(32) not null,
        name nvarchar(255) null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        operation nvarchar(255) null,
        source nvarchar(255) null,
        application_name nvarchar(255) null,
        identity_name nvarchar(255) null,
        identity_display_name nvarchar(255) null,
        native_identity nvarchar(322) null,
        account_display_name nvarchar(322) null,
        attributes nvarchar(max) null,
        integration nvarchar(255) null,
        certification_id nvarchar(32) null,
        forced tinyint null,
        type nvarchar(255) null,
        status nvarchar(255) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_quick_link (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(128) not null unique,
        message_key nvarchar(128) null,
        description nvarchar(1024) null,
        action nvarchar(128) null,
        css_class nvarchar(128) null,
        hidden tinyint null,
        category nvarchar(128) null,
        ordering int null,
        arguments nvarchar(max) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_quick_link_options (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        allow_bulk tinyint null,
        allow_other tinyint null,
        allow_self tinyint null,
        options nvarchar(max) null,
        dynamic_scope nvarchar(32) not null,
        quick_link nvarchar(32) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_recommender_definition (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        name nvarchar(128) not null unique,
        attributes nvarchar(max) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_remediation_item (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        description nvarchar(1024) null,
        remediation_entity_type nvarchar(255) null,
        work_item_id nvarchar(32) null,
        certification_item nvarchar(255) null,
        assignee nvarchar(32) null,
        remediation_identity nvarchar(255) null,
        remediation_details nvarchar(max) null,
        completion_comments nvarchar(max) null,
        completion_date numeric(19,0) null,
        assimilated tinyint null,
        comments nvarchar(max) null,
        attributes nvarchar(max) null,
        idx int null,
        primary key (id)
    );
    GO

    create table identityiq.spt_remote_login_token (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(128) not null,
        creator nvarchar(128) not null,
        remote_host nvarchar(128) null,
        expiration numeric(19,0) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_request (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        stack nvarchar(max) null,
        attributes nvarchar(max) null,
        launcher nvarchar(255) null,
        host nvarchar(255) null,
        launched numeric(19,0) null,
        progress nvarchar(255) null,
        percent_complete int null,
        type nvarchar(255) null,
        messages nvarchar(max) null,
        completed numeric(19,0) null,
        expiration numeric(19,0) null,
        name nvarchar(450) null,
        definition nvarchar(32) null,
        task_result nvarchar(32) null,
        phase int null,
        dependent_phase int null,
        next_launch numeric(19,0) null,
        retry_count int null,
        retry_interval int null,
        string1 nvarchar(2048) null,
        live tinyint null,
        completion_status nvarchar(255) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_request_arguments (
        signature nvarchar(32) not null,
        name nvarchar(255) null,
        type nvarchar(255) null,
        filter_string nvarchar(255) null,
        description nvarchar(max) null,
        prompt nvarchar(max) null,
        multi tinyint null,
        required tinyint null,
        idx int not null,
        primary key (signature, idx)
    );
    GO

    create table identityiq.spt_request_definition (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(128) not null unique,
        description nvarchar(4000) null,
        executor nvarchar(255) null,
        form_path nvarchar(128) null,
        template tinyint null,
        hidden tinyint null,
        result_expiration int null,
        progress_interval int null,
        sub_type nvarchar(128) null,
        type nvarchar(255) null,
        progress_mode nvarchar(255) null,
        arguments nvarchar(max) null,
        parent nvarchar(32) null,
        retry_max int null,
        retry_interval int null,
        sig_description nvarchar(max) null,
        return_type nvarchar(255) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_request_definition_rights (
        request_definition_id nvarchar(32) not null,
        right_id nvarchar(32) not null,
        idx int not null,
        primary key (request_definition_id, idx)
    );
    GO

    create table identityiq.spt_request_returns (
        signature nvarchar(32) not null,
        name nvarchar(255) null,
        type nvarchar(255) null,
        filter_string nvarchar(255) null,
        description nvarchar(max) null,
        prompt nvarchar(max) null,
        multi tinyint null,
        idx int not null,
        primary key (signature, idx)
    );
    GO

    create table identityiq.spt_request_state (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        name nvarchar(450) null,
        attributes nvarchar(max) null,
        request_id nvarchar(32) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_resource_event (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        application nvarchar(32) null,
        provisioning_plan nvarchar(max) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_right (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(128) not null unique,
        description nvarchar(1024) null,
        display_name nvarchar(128) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_right_config (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(128) not null unique,
        rights nvarchar(max) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_role_change_event (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        bundle_id nvarchar(128) null,
        bundle_name nvarchar(128) null,
        provisioning_plan nvarchar(max) null,
        bundle_deleted tinyint null,
        primary key (id)
    );
    GO

    create table identityiq.spt_role_index (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        incomplete tinyint null,
        composite_score int null,
        attributes nvarchar(max) null,
        items nvarchar(max) null,
        bundle nvarchar(32) null,
        assigned_count int null,
        detected_count int null,
        associated_to_role tinyint null,
        last_certified_membership numeric(19,0) null,
        last_certified_composition numeric(19,0) null,
        last_assigned numeric(19,0) null,
        entitlement_count int null,
        entitlement_count_inheritance int null,
        primary key (id)
    );
    GO

    create table identityiq.spt_role_metadata (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        role nvarchar(32) null,
        name nvarchar(255) null,
        additional_entitlements tinyint null,
        missing_required tinyint null,
        assigned tinyint null,
        detected tinyint null,
        detected_exception tinyint null,
        primary key (id)
    );
    GO

    create table identityiq.spt_role_mining_result (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(128) null,
        pending tinyint null,
        config nvarchar(max) null,
        roles nvarchar(max) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_role_scorecard (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        role_id nvarchar(32) null,
        members int null,
        members_extra_ent int null,
        members_missing_req int null,
        detected int null,
        detected_exc int null,
        provisioned_ent int null,
        permitted_ent int null,
        primary key (id)
    );
    GO

    create table identityiq.spt_rule (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(128) not null unique,
        description nvarchar(1024) null,
        language nvarchar(255) null,
        source nvarchar(max) null,
        type nvarchar(255) null,
        attributes nvarchar(max) null,
        sig_description nvarchar(max) null,
        return_type nvarchar(255) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_rule_dependencies (
        rule_id nvarchar(32) not null,
        dependency nvarchar(32) not null,
        idx int not null,
        primary key (rule_id, idx)
    );
    GO

    create table identityiq.spt_rule_registry (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(128) not null unique,
        templates nvarchar(max) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_rule_registry_callouts (
        rule_registry_id nvarchar(32) not null,
        rule_id nvarchar(32) not null,
        callout nvarchar(78) not null,
        primary key (rule_registry_id, callout)
    );
    GO

    create table identityiq.spt_rule_signature_arguments (
        signature nvarchar(32) not null,
        name nvarchar(255) null,
        type nvarchar(255) null,
        filter_string nvarchar(255) null,
        description nvarchar(max) null,
        prompt nvarchar(max) null,
        multi tinyint null,
        idx int not null,
        primary key (signature, idx)
    );
    GO

    create table identityiq.spt_rule_signature_returns (
        signature nvarchar(32) not null,
        name nvarchar(255) null,
        type nvarchar(255) null,
        filter_string nvarchar(255) null,
        description nvarchar(max) null,
        prompt nvarchar(max) null,
        multi tinyint null,
        idx int not null,
        primary key (signature, idx)
    );
    GO

    create table identityiq.spt_schema_attributes (
        applicationschema nvarchar(32) not null,
        name nvarchar(255) null,
        type nvarchar(255) null,
        description nvarchar(max) null,
        required tinyint null,
        entitlement tinyint null,
        is_group tinyint null,
        managed tinyint null,
        multi_valued tinyint null,
        minable tinyint null,
        indexed tinyint null,
        correlation_key int null,
        source nvarchar(255) null,
        internal_name nvarchar(255) null,
        default_value nvarchar(255) null,
        remed_mod_type nvarchar(255) null,
        schema_object_type nvarchar(255) null,
        object_mapping nvarchar(255) null,
        idx int not null,
        primary key (applicationschema, idx)
    );
    GO

    create table identityiq.spt_scope (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(128) not null,
        display_name nvarchar(128) null,
        parent_id nvarchar(32) null,
        manually_created tinyint null,
        dormant tinyint null,
        path nvarchar(450) null,
        dirty tinyint null,
        idx int null,
        primary key (id)
    );
    GO

    create table identityiq.spt_score_config (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(128) not null unique,
        maximum_score int null,
        maximum_number_of_bands int null,
        application_configs nvarchar(max) null,
        identity_scores nvarchar(max) null,
        application_scores nvarchar(max) null,
        bands nvarchar(max) null,
        right_config nvarchar(32) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_scorecard (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        incomplete tinyint null,
        composite_score int null,
        attributes nvarchar(max) null,
        items nvarchar(max) null,
        business_role_score int null,
        raw_business_role_score int null,
        entitlement_score int null,
        raw_entitlement_score int null,
        policy_score int null,
        raw_policy_score int null,
        certification_score int null,
        total_violations int null,
        total_remediations int null,
        total_delegations int null,
        total_mitigations int null,
        total_approvals int null,
        identity_id nvarchar(32) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_server (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        extended1 nvarchar(255) null,
        name nvarchar(128) not null unique,
        heartbeat numeric(19,0) null,
        inactive tinyint null,
        attributes nvarchar(max) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_server_statistic (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        name nvarchar(128) not null,
        snapshot_name nvarchar(128) null,
        value nvarchar(4000) null,
        value_type nvarchar(128) null,
        host nvarchar(32) null,
        attributes nvarchar(max) null,
        target nvarchar(128) null,
        target_type nvarchar(128) null,
        monitoring_statistic nvarchar(32) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_service_definition (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        name nvarchar(128) not null unique,
        description nvarchar(1024) null,
        executor nvarchar(255) null,
        exec_interval int null,
        hosts nvarchar(1024) null,
        attributes nvarchar(max) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_service_status (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        name nvarchar(128) not null unique,
        description nvarchar(1024) null,
        definition nvarchar(32) null,
        host nvarchar(255) null,
        last_start numeric(19,0) null,
        last_end numeric(19,0) null,
        attributes nvarchar(max) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_sign_off_history (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        sign_date numeric(19,0) null,
        signer_id nvarchar(128) null,
        signer_name nvarchar(128) null,
        signer_display_name nvarchar(128) null,
        application nvarchar(128) null,
        account nvarchar(128) null,
        text nvarchar(max) null,
        electronic_sign tinyint null,
        certification_id nvarchar(32) null,
        idx int null,
        primary key (id)
    );
    GO

    create table identityiq.spt_snapshot_permissions (
        snapshot nvarchar(32) not null,
        target nvarchar(255) null,
        rights nvarchar(4000) null,
        attributes nvarchar(max) null,
        idx int not null,
        primary key (snapshot, idx)
    );
    GO

    create table identityiq.spt_sodconstraint (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(2000) null,
        description nvarchar(4000) null,
        policy nvarchar(32) null,
        violation_owner_type nvarchar(255) null,
        violation_owner nvarchar(32) null,
        violation_owner_rule nvarchar(32) null,
        compensating_control nvarchar(max) null,
        disabled tinyint null,
        weight int null,
        remediation_advice nvarchar(max) null,
        violation_summary nvarchar(max) null,
        arguments nvarchar(max) null,
        idx int null,
        primary key (id)
    );
    GO

    create table identityiq.spt_sodconstraint_left (
        sodconstraint nvarchar(32) not null,
        businessrole nvarchar(32) not null,
        idx int not null,
        primary key (sodconstraint, idx)
    );
    GO

    create table identityiq.spt_sodconstraint_right (
        sodconstraint nvarchar(32) not null,
        businessrole nvarchar(32) not null,
        idx int not null,
        primary key (sodconstraint, idx)
    );
    GO

    create table identityiq.spt_sync_roles (
        config nvarchar(32) not null,
        bundle nvarchar(32) not null,
        idx int not null,
        primary key (config, idx)
    );
    GO

    create table identityiq.spt_syslog_event (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        quick_key nvarchar(12) null,
        event_level nvarchar(6) null,
        classname nvarchar(128) null,
        line_number nvarchar(6) null,
        message nvarchar(450) null,
        thread nvarchar(128) null,
        server nvarchar(128) null,
        username nvarchar(128) null,
        stacktrace nvarchar(max) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_tag (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(128) not null unique,
        primary key (id)
    );
    GO

    create table identityiq.spt_target (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        extended1 nvarchar(255) null,
        name nvarchar(512) null,
        native_owner_id nvarchar(128) null,
        target_source nvarchar(32) null,
        application nvarchar(32) null,
        target_host nvarchar(1024) null,
        display_name nvarchar(400) null,
        full_path nvarchar(max) null,
        unique_name_hash nvarchar(128) null,
        attributes nvarchar(max) null,
        native_object_id nvarchar(322) null,
        parent nvarchar(32) null,
        target_size numeric(19,0) null,
        last_aggregation numeric(19,0) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_target_association (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        object_id nvarchar(32) null,
        type nvarchar(8) null,
        hierarchy nvarchar(512) null,
        flattened tinyint null,
        application_name nvarchar(128) null,
        target_type nvarchar(128) null,
        target_name nvarchar(255) null,
        target_id nvarchar(32) null,
        rights nvarchar(512) null,
        inherited tinyint null,
        effective int null,
        deny_permission tinyint null,
        last_aggregation numeric(19,0) null,
        attributes nvarchar(max) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_target_source (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(128) null,
        description nvarchar(1024) null,
        collector nvarchar(255) null,
        last_refresh numeric(19,0) null,
        configuration nvarchar(max) null,
        correlation_rule nvarchar(32) null,
        creation_rule nvarchar(32) null,
        refresh_rule nvarchar(32) null,
        transformation_rule nvarchar(32) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_target_sources (
        application nvarchar(32) not null,
        elt nvarchar(32) not null,
        idx int not null,
        primary key (application, idx)
    );
    GO

    create table identityiq.spt_task_definition (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(128) not null unique,
        description nvarchar(4000) null,
        executor nvarchar(255) null,
        form_path nvarchar(128) null,
        template tinyint null,
        hidden tinyint null,
        result_expiration int null,
        progress_interval int null,
        sub_type nvarchar(128) null,
        type nvarchar(255) null,
        progress_mode nvarchar(255) null,
        arguments nvarchar(max) null,
        parent nvarchar(32) null,
        result_renderer nvarchar(255) null,
        concurrent tinyint null,
        deprecated tinyint not null,
        result_action nvarchar(255) null,
        signoff_config nvarchar(32) null,
        sig_description nvarchar(max) null,
        return_type nvarchar(255) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_task_definition_rights (
        task_definition_id nvarchar(32) not null,
        right_id nvarchar(32) not null,
        idx int not null,
        primary key (task_definition_id, idx)
    );
    GO

    create table identityiq.spt_task_event (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        phase nvarchar(128) null,
        task_result nvarchar(32) null,
        rule_id nvarchar(32) null,
        attributes nvarchar(max) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_task_result (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        stack nvarchar(max) null,
        attributes nvarchar(max) null,
        launcher nvarchar(255) null,
        host nvarchar(255) null,
        launched numeric(19,0) null,
        progress nvarchar(255) null,
        percent_complete int null,
        type nvarchar(255) null,
        messages nvarchar(max) null,
        completed numeric(19,0) null,
        expiration numeric(19,0) null,
        verified numeric(19,0) null,
        name nvarchar(255) not null unique,
        definition nvarchar(32) null,
        schedule nvarchar(255) null,
        pending_signoffs int null,
        signoff nvarchar(max) null,
        report nvarchar(32) null,
        target_class nvarchar(255) null,
        target_id nvarchar(255) null,
        target_name nvarchar(255) null,
        task_terminated tinyint null,
        partitioned tinyint null,
        completion_status nvarchar(255) null,
        run_length int null,
        run_length_average int null,
        run_length_deviation int null,
        primary key (id)
    );
    GO

    create table identityiq.spt_task_signature_arguments (
        signature nvarchar(32) not null,
        name nvarchar(255) null,
        type nvarchar(255) null,
        filter_string nvarchar(255) null,
        help_key nvarchar(255) null,
        input_template nvarchar(255) null,
        description nvarchar(max) null,
        prompt nvarchar(max) null,
        multi tinyint null,
        required tinyint null,
        default_value nvarchar(255) null,
        idx int not null,
        primary key (signature, idx)
    );
    GO

    create table identityiq.spt_task_signature_returns (
        signature nvarchar(32) not null,
        name nvarchar(255) null,
        type nvarchar(255) null,
        filter_string nvarchar(255) null,
        description nvarchar(max) null,
        prompt nvarchar(max) null,
        multi tinyint null,
        idx int not null,
        primary key (signature, idx)
    );
    GO

    create table identityiq.spt_time_period (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(128) null,
        classifier nvarchar(255) null,
        init_parameters nvarchar(max) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_uiconfig (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(128) not null unique,
        attributes nvarchar(max) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_uipreferences (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        preferences nvarchar(max) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_widget (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(128) not null unique,
        title nvarchar(128) null,
        selector nvarchar(max) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_work_item (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(255) null,
        description nvarchar(1024) null,
        handler nvarchar(255) null,
        renderer nvarchar(255) null,
        target_class nvarchar(255) null,
        target_id nvarchar(255) null,
        target_name nvarchar(255) null,
        type nvarchar(255) null,
        state nvarchar(255) null,
        severity nvarchar(255) null,
        requester nvarchar(32) null,
        completion_comments nvarchar(max) null,
        notification numeric(19,0) null,
        expiration numeric(19,0) null,
        wake_up_date numeric(19,0) null,
        reminders int null,
        escalation_count int null,
        notification_config nvarchar(max) null,
        workflow_case nvarchar(32) null,
        attributes nvarchar(max) null,
        owner_history nvarchar(max) null,
        certification nvarchar(255) null,
        certification_entity nvarchar(255) null,
        certification_item nvarchar(255) null,
        identity_request_id nvarchar(128) null,
        assignee nvarchar(32) null,
        iiqlock nvarchar(128) null,
        certification_ref_id nvarchar(32) null,
        idx int null,
        primary key (id)
    );
    GO

    create table identityiq.spt_work_item_archive (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        work_item_id nvarchar(128) null,
        name nvarchar(255) null,
        owner_name nvarchar(255) null,
        identity_request_id nvarchar(128) null,
        assignee nvarchar(255) null,
        requester nvarchar(255) null,
        description nvarchar(1024) null,
        handler nvarchar(255) null,
        renderer nvarchar(255) null,
        target_class nvarchar(255) null,
        target_id nvarchar(255) null,
        target_name nvarchar(255) null,
        archived numeric(19,0) null,
        type nvarchar(255) null,
        state nvarchar(255) null,
        severity nvarchar(255) null,
        attributes nvarchar(max) null,
        system_attributes nvarchar(max) null,
        immutable tinyint null,
        signed tinyint null,
        completer nvarchar(255) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_work_item_comments (
        work_item nvarchar(32) not null,
        author nvarchar(255) null,
        comments nvarchar(max) null,
        comment_date numeric(19,0) null,
        idx int not null,
        primary key (work_item, idx)
    );
    GO

    create table identityiq.spt_work_item_config (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(128) null,
        description_template nvarchar(1024) null,
        disabled tinyint null,
        no_work_item tinyint null,
        parent nvarchar(32) null,
        owner_rule nvarchar(32) null,
        hours_till_escalation int null,
        hours_between_reminders int null,
        max_reminders int null,
        notification_email nvarchar(32) null,
        reminder_email nvarchar(32) null,
        escalation_email nvarchar(32) null,
        escalation_rule nvarchar(32) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_work_item_owners (
        config nvarchar(32) not null,
        elt nvarchar(32) not null,
        idx int not null,
        primary key (config, idx)
    );
    GO

    create table identityiq.spt_workflow (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(128) not null unique,
        description nvarchar(4000) null,
        type nvarchar(128) null,
        task_type nvarchar(255) null,
        template tinyint null,
        explicit_transitions tinyint null,
        monitored tinyint null,
        result_expiration int null,
        complete tinyint null,
        handler nvarchar(128) null,
        work_item_renderer nvarchar(128) null,
        variable_definitions nvarchar(max) null,
        config_form nvarchar(128) null,
        steps nvarchar(max) null,
        work_item_config nvarchar(max) null,
        variables nvarchar(max) null,
        libraries nvarchar(128) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_workflow_case (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        stack nvarchar(max) null,
        attributes nvarchar(max) null,
        launcher nvarchar(255) null,
        host nvarchar(255) null,
        launched numeric(19,0) null,
        progress nvarchar(255) null,
        percent_complete int null,
        type nvarchar(255) null,
        messages nvarchar(max) null,
        completed numeric(19,0) null,
        name nvarchar(450) null,
        description nvarchar(1024) null,
        complete tinyint null,
        target_class nvarchar(255) null,
        target_id nvarchar(255) null,
        target_name nvarchar(255) null,
        workflow nvarchar(max) null,
        iiqlock nvarchar(128) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_workflow_registry (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(128) not null unique,
        types nvarchar(max) null,
        templates nvarchar(max) null,
        callables nvarchar(max) null,
        attributes nvarchar(max) null,
        primary key (id)
    );
    GO

    create table identityiq.spt_workflow_rule_libraries (
        rule_id nvarchar(32) not null,
        dependency nvarchar(32) not null,
        idx int not null,
        primary key (rule_id, idx)
    );
    GO

    create table identityiq.spt_workflow_target (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        owner nvarchar(32) null,
        assigned_scope nvarchar(32) null,
        assigned_scope_path nvarchar(450) null,
        name nvarchar(128) null,
        description nvarchar(1024) null,
        class_name nvarchar(255) null,
        object_id nvarchar(255) null,
        object_name nvarchar(255) null,
        workflow_case_id nvarchar(32) not null,
        idx int null,
        primary key (id)
    );
    GO

    create table identityiq.spt_workflow_test_suite (
        id nvarchar(32) not null,
        created numeric(19,0) null,
        modified numeric(19,0) null,
        name nvarchar(128) not null unique,
        description nvarchar(4000) null,
        replicated tinyint null,
        case_name nvarchar(255) null,
        tests nvarchar(max) null,
        responses nvarchar(max) null,
        attributes nvarchar(max) null,
        primary key (id)
    );
    GO

    create index spt_actgroup_name_csi on identityiq.spt_account_group (name);
    GO

    create index spt_actgroup_key4_ci on identityiq.spt_account_group (key4);
    GO

    create index spt_actgroup_key3_ci on identityiq.spt_account_group (key3);
    GO

    create index spt_actgroup_native_ci on identityiq.spt_account_group (native_identity);
    GO

    create index spt_actgroup_lastAggregation on identityiq.spt_account_group (last_target_aggregation);
    GO

    create index spt_actgroup_attr on identityiq.spt_account_group (reference_attribute);
    GO

    create index spt_actgroup_key1_ci on identityiq.spt_account_group (key1);
    GO

    create index spt_actgroup_key2_ci on identityiq.spt_account_group (key2);
    GO

    alter table identityiq.spt_account_group
        add constraint FK54D39165A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK54D39165A5FB1B1 on identityiq.spt_account_group (owner);
    GO

    alter table identityiq.spt_account_group
        add constraint FK54D3916539D71460
        foreign key (application)
        references identityiq.spt_application;
    GO

    create index FK54D3916539D71460 on identityiq.spt_account_group (application);
    GO

    alter table identityiq.spt_account_group
        add constraint FK54D39165486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK54D39165486634B7 on identityiq.spt_account_group (assigned_scope);
    GO

    alter table identityiq.spt_account_group_inheritance
        add constraint FK64E35CF0B106CC7F
        foreign key (account_group)
        references identityiq.spt_account_group;
    GO

    create index FK64E35CF0B106CC7F on identityiq.spt_account_group_inheritance (account_group);
    GO

    alter table identityiq.spt_account_group_inheritance
        add constraint FK64E35CF034D1C743
        foreign key (inherits_from)
        references identityiq.spt_account_group;
    GO

    create index FK64E35CF034D1C743 on identityiq.spt_account_group_inheritance (inherits_from);
    GO

    alter table identityiq.spt_account_group_perms
        add constraint FK196E8029128ABF04
        foreign key (accountgroup)
        references identityiq.spt_account_group;
    GO

    create index FK196E8029128ABF04 on identityiq.spt_account_group_perms (accountgroup);
    GO

    alter table identityiq.spt_account_group_target_perms
        add constraint FK8C6393EF128ABF04
        foreign key (accountgroup)
        references identityiq.spt_account_group;
    GO

    create index FK8C6393EF128ABF04 on identityiq.spt_account_group_target_perms (accountgroup);
    GO

    alter table identityiq.spt_activity_constraint
        add constraint FKD7E39285A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FKD7E39285A5FB1B1 on identityiq.spt_activity_constraint (owner);
    GO

    alter table identityiq.spt_activity_constraint
        add constraint FKD7E3928516E8C617
        foreign key (violation_owner)
        references identityiq.spt_identity;
    GO

    create index FKD7E3928516E8C617 on identityiq.spt_activity_constraint (violation_owner);
    GO

    alter table identityiq.spt_activity_constraint
        add constraint FKD7E39285486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FKD7E39285486634B7 on identityiq.spt_activity_constraint (assigned_scope);
    GO

    alter table identityiq.spt_activity_constraint
        add constraint FKD7E392852E02D59E
        foreign key (violation_owner_rule)
        references identityiq.spt_rule;
    GO

    create index FKD7E392852E02D59E on identityiq.spt_activity_constraint (violation_owner_rule);
    GO

    alter table identityiq.spt_activity_constraint
        add constraint FKD7E3928557FD28A4
        foreign key (policy)
        references identityiq.spt_policy;
    GO

    create index FKD7E3928557FD28A4 on identityiq.spt_activity_constraint (policy);
    GO

    alter table identityiq.spt_activity_data_source
        add constraint FK34D17AA8A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK34D17AA8A5FB1B1 on identityiq.spt_activity_data_source (owner);
    GO

    alter table identityiq.spt_activity_data_source
        add constraint FK34D17AA839D71460
        foreign key (application)
        references identityiq.spt_application;
    GO

    create index FK34D17AA839D71460 on identityiq.spt_activity_data_source (application);
    GO

    alter table identityiq.spt_activity_data_source
        add constraint FK34D17AA8B854BFAE
        foreign key (transformation_rule)
        references identityiq.spt_rule;
    GO

    create index FK34D17AA8B854BFAE on identityiq.spt_activity_data_source (transformation_rule);
    GO

    alter table identityiq.spt_activity_data_source
        add constraint FK34D17AA8486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK34D17AA8486634B7 on identityiq.spt_activity_data_source (assigned_scope);
    GO

    alter table identityiq.spt_activity_data_source
        add constraint FK34D17AA8BE1EE0D5
        foreign key (correlation_rule)
        references identityiq.spt_rule;
    GO

    create index FK34D17AA8BE1EE0D5 on identityiq.spt_activity_data_source (correlation_rule);
    GO

    alter table identityiq.spt_activity_time_periods
        add constraint FK7ABC1208E6D76F5D
        foreign key (application_activity)
        references identityiq.spt_application_activity;
    GO

    create index FK7ABC1208E6D76F5D on identityiq.spt_activity_time_periods (application_activity);
    GO

    alter table identityiq.spt_activity_time_periods
        add constraint FK7ABC1208E6ED34A1
        foreign key (time_period)
        references identityiq.spt_time_period;
    GO

    create index FK7ABC1208E6ED34A1 on identityiq.spt_activity_time_periods (time_period);
    GO

    create index spt_alert_last_processed on identityiq.spt_alert (last_processed);
    GO

    create index spt_alert_name on identityiq.spt_alert (name);
    GO

    create index spt_alert_extended1_ci on identityiq.spt_alert (extended1);
    GO

    alter table identityiq.spt_alert
        add constraint FKAD3A44D4A7C3772B
        foreign key (source)
        references identityiq.spt_application;
    GO

    create index FKAD3A44D4A7C3772B on identityiq.spt_alert (source);
    GO

    alter table identityiq.spt_alert_action
        add constraint FK89E001BF1C6C78
        foreign key (alert)
        references identityiq.spt_alert;
    GO

    create index FK89E001BF1C6C78 on identityiq.spt_alert_action (alert);
    GO

    alter table identityiq.spt_alert_definition
        add constraint FK3DF7B99EA5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK3DF7B99EA5FB1B1 on identityiq.spt_alert_definition (owner);
    GO

    alter table identityiq.spt_alert_definition
        add constraint FK3DF7B99E486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK3DF7B99E486634B7 on identityiq.spt_alert_definition (assigned_scope);
    GO

    alter table identityiq.spt_app_dependencies
        add constraint FK4354140F39D71460
        foreign key (application)
        references identityiq.spt_application;
    GO

    create index FK4354140F39D71460 on identityiq.spt_app_dependencies (application);
    GO

    alter table identityiq.spt_app_dependencies
        add constraint FK4354140FDBA1E25B
        foreign key (dependency)
        references identityiq.spt_application;
    GO

    create index FK4354140FDBA1E25B on identityiq.spt_app_dependencies (dependency);
    GO

    alter table identityiq.spt_app_secondary_owners
        add constraint FK1228593139D71460
        foreign key (application)
        references identityiq.spt_application;
    GO

    create index FK1228593139D71460 on identityiq.spt_app_secondary_owners (application);
    GO

    alter table identityiq.spt_app_secondary_owners
        add constraint FK1228593140D47AB
        foreign key (elt)
        references identityiq.spt_identity;
    GO

    create index FK1228593140D47AB on identityiq.spt_app_secondary_owners (elt);
    GO

    create index spt_application_cluster on identityiq.spt_application (app_cluster);
    GO

    create index spt_application_acct_only on identityiq.spt_application (supports_account_only);
    GO

    create index spt_application_logical on identityiq.spt_application (logical);
    GO

    create index spt_application_provisioning on identityiq.spt_application (supports_provisioning);
    GO

    create index spt_app_extended1_ci on identityiq.spt_application (extended1);
    GO

    create index spt_application_authoritative on identityiq.spt_application (authoritative);
    GO

    create index spt_app_sync_provisioning on identityiq.spt_application (sync_provisioning);
    GO

    create index spt_application_mgd_apps on identityiq.spt_application (manages_other_apps);
    GO

    create index spt_application_authenticate on identityiq.spt_application (supports_authenticate);
    GO

    create index spt_application_addt_acct on identityiq.spt_application (supports_additional_accounts);
    GO

    create index spt_app_proxied_name on identityiq.spt_application (proxied_name);
    GO

    create index spt_application_no_agg on identityiq.spt_application (no_aggregation);
    GO

    alter table identityiq.spt_application
        add constraint FK798846C8A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK798846C8A5FB1B1 on identityiq.spt_application (owner);
    GO

    alter table identityiq.spt_application
        add constraint FK798846C84FE65998
        foreign key (creation_rule)
        references identityiq.spt_rule;
    GO

    create index FK798846C84FE65998 on identityiq.spt_application (creation_rule);
    GO

    alter table identityiq.spt_application
        add constraint FK798846C86FB29924
        foreign key (customization_rule)
        references identityiq.spt_rule;
    GO

    create index FK798846C86FB29924 on identityiq.spt_application (customization_rule);
    GO

    alter table identityiq.spt_application
        add constraint FK798846C8E392D97E
        foreign key (proxy)
        references identityiq.spt_application;
    GO

    create index FK798846C8E392D97E on identityiq.spt_application (proxy);
    GO

    alter table identityiq.spt_application
        add constraint FK798846C88954E327
        foreign key (manager_correlation_rule)
        references identityiq.spt_rule;
    GO

    create index FK798846C88954E327 on identityiq.spt_application (manager_correlation_rule);
    GO

    alter table identityiq.spt_application
        add constraint FK798846C82F001D5
        foreign key (target_source)
        references identityiq.spt_target_source;
    GO

    create index FK798846C82F001D5 on identityiq.spt_application (target_source);
    GO

    alter table identityiq.spt_application
        add constraint FK798846C8198B5515
        foreign key (account_correlation_config)
        references identityiq.spt_correlation_config;
    GO

    create index FK798846C8198B5515 on identityiq.spt_application (account_correlation_config);
    GO

    alter table identityiq.spt_application
        add constraint FK798846C8486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK798846C8486634B7 on identityiq.spt_application (assigned_scope);
    GO

    alter table identityiq.spt_application
        add constraint FK798846C8BE1EE0D5
        foreign key (correlation_rule)
        references identityiq.spt_rule;
    GO

    create index FK798846C8BE1EE0D5 on identityiq.spt_application (correlation_rule);
    GO

    alter table identityiq.spt_application
        add constraint FK798846C83D65E622
        foreign key (managed_attr_customize_rule)
        references identityiq.spt_rule;
    GO

    create index FK798846C83D65E622 on identityiq.spt_application (managed_attr_customize_rule);
    GO

    alter table identityiq.spt_application
        add constraint FK798846C853AF4414
        foreign key (scorecard)
        references identityiq.spt_application_scorecard;
    GO

    create index FK798846C853AF4414 on identityiq.spt_application (scorecard);
    GO

    alter table identityiq.spt_application_activity
        add constraint FK5077FEA6486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK5077FEA6486634B7 on identityiq.spt_application_activity (assigned_scope);
    GO

    alter table identityiq.spt_application_remediators
        add constraint FKA10D3C1639D71460
        foreign key (application)
        references identityiq.spt_application;
    GO

    create index FKA10D3C1639D71460 on identityiq.spt_application_remediators (application);
    GO

    alter table identityiq.spt_application_remediators
        add constraint FKA10D3C1640D47AB
        foreign key (elt)
        references identityiq.spt_identity;
    GO

    create index FKA10D3C1640D47AB on identityiq.spt_application_remediators (elt);
    GO

    alter table identityiq.spt_application_schema
        add constraint FK62F93AF8A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK62F93AF8A5FB1B1 on identityiq.spt_application_schema (owner);
    GO

    alter table identityiq.spt_application_schema
        add constraint FK62F93AF84FE65998
        foreign key (creation_rule)
        references identityiq.spt_rule;
    GO

    create index FK62F93AF84FE65998 on identityiq.spt_application_schema (creation_rule);
    GO

    alter table identityiq.spt_application_schema
        add constraint FK62F93AF86FB29924
        foreign key (customization_rule)
        references identityiq.spt_rule;
    GO

    create index FK62F93AF86FB29924 on identityiq.spt_application_schema (customization_rule);
    GO

    alter table identityiq.spt_application_schema
        add constraint FK62F93AF839D71460
        foreign key (application)
        references identityiq.spt_application;
    GO

    create index FK62F93AF839D71460 on identityiq.spt_application_schema (application);
    GO

    alter table identityiq.spt_application_schema
        add constraint FK62F93AF8486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK62F93AF8486634B7 on identityiq.spt_application_schema (assigned_scope);
    GO

    alter table identityiq.spt_application_schema
        add constraint FK62F93AF8BE1EE0D5
        foreign key (correlation_rule)
        references identityiq.spt_rule;
    GO

    create index FK62F93AF8BE1EE0D5 on identityiq.spt_application_schema (correlation_rule);
    GO

    alter table identityiq.spt_application_schema
        add constraint FK62F93AF8D9F8531C
        foreign key (refresh_rule)
        references identityiq.spt_rule;
    GO

    create index FK62F93AF8D9F8531C on identityiq.spt_application_schema (refresh_rule);
    GO

    create index app_scorecard_cscore on identityiq.spt_application_scorecard (composite_score);
    GO

    alter table identityiq.spt_application_scorecard
        add constraint FK314187EBA5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK314187EBA5FB1B1 on identityiq.spt_application_scorecard (owner);
    GO

    alter table identityiq.spt_application_scorecard
        add constraint FK314187EB486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK314187EB486634B7 on identityiq.spt_application_scorecard (assigned_scope);
    GO

    alter table identityiq.spt_application_scorecard
        add constraint FK314187EB907AB97A
        foreign key (application_id)
        references identityiq.spt_application;
    GO

    create index FK314187EB907AB97A on identityiq.spt_application_scorecard (application_id);
    GO

    alter table identityiq.spt_arch_cert_item_apps
        add constraint FKFBD89444D6D1B4E0
        foreign key (arch_cert_item_id)
        references identityiq.spt_archived_cert_item;
    GO

    create index FKFBD89444D6D1B4E0 on identityiq.spt_arch_cert_item_apps (arch_cert_item_id);
    GO

    create index spt_arch_entity_ref_attr on identityiq.spt_archived_cert_entity (reference_attribute);
    GO

    create index spt_arch_entity_target_id on identityiq.spt_archived_cert_entity (target_id);
    GO

    create index spt_arch_entity_identity_csi on identityiq.spt_archived_cert_entity (identity_name);
    GO

    create index spt_arch_entity_app on identityiq.spt_archived_cert_entity (application);
    GO

    create index spt_arch_entity_tgt_name_csi on identityiq.spt_archived_cert_entity (target_name);
    GO

    create index spt_arch_entity_tgt_display on identityiq.spt_archived_cert_entity (target_display_name);
    GO

    create index spt_arch_entity_acct_grp_csi on identityiq.spt_archived_cert_entity (account_group);
    GO

    create index spt_arch_entity_native_id on identityiq.spt_archived_cert_entity (native_identity);
    GO

    alter table identityiq.spt_archived_cert_entity
        add constraint FKE3ED1F09A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FKE3ED1F09A5FB1B1 on identityiq.spt_archived_cert_entity (owner);
    GO

    alter table identityiq.spt_archived_cert_entity
        add constraint FKE3ED1F09DB59193A
        foreign key (certification_id)
        references identityiq.spt_certification;
    GO

    create index FKE3ED1F09DB59193A on identityiq.spt_archived_cert_entity (certification_id);
    GO

    alter table identityiq.spt_archived_cert_entity
        add constraint FKE3ED1F09486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FKE3ED1F09486634B7 on identityiq.spt_archived_cert_entity (assigned_scope);
    GO

    create index spt_arch_item_bundle on identityiq.spt_archived_cert_item (bundle);
    GO

    create index spt_arch_item_policy on identityiq.spt_archived_cert_item (policy);
    GO

    create index spt_arch_cert_item_tname on identityiq.spt_archived_cert_item (target_name);
    GO

    create index spt_arch_item_native_id on identityiq.spt_archived_cert_item (exception_native_identity);
    GO

    create index spt_arch_cert_item_tdisplay on identityiq.spt_archived_cert_item (target_display_name);
    GO

    create index spt_arch_cert_item_type on identityiq.spt_archived_cert_item (type);
    GO

    create index spt_arch_item_app on identityiq.spt_archived_cert_item (exception_application);
    GO

    alter table identityiq.spt_archived_cert_item
        add constraint FK764147B9A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK764147B9A5FB1B1 on identityiq.spt_archived_cert_item (owner);
    GO

    alter table identityiq.spt_archived_cert_item
        add constraint FK764147B9BAC8DC8B
        foreign key (parent_id)
        references identityiq.spt_archived_cert_entity;
    GO

    create index FK764147B9BAC8DC8B on identityiq.spt_archived_cert_item (parent_id);
    GO

    alter table identityiq.spt_archived_cert_item
        add constraint FK764147B9486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK764147B9486634B7 on identityiq.spt_archived_cert_item (assigned_scope);
    GO

    alter table identityiq.spt_audit_config
        add constraint FK15F2D5AEA5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK15F2D5AEA5FB1B1 on identityiq.spt_audit_config (owner);
    GO

    alter table identityiq.spt_audit_config
        add constraint FK15F2D5AE486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK15F2D5AE486634B7 on identityiq.spt_audit_config (assigned_scope);
    GO

    create index spt_audit_action_ci on identityiq.spt_audit_event (action);
    GO

    create index spt_audit_instance_ci on identityiq.spt_audit_event (instance);
    GO

    create index spt_audit_attr_ci on identityiq.spt_audit_event (attribute_name);
    GO

    create index spt_audit_source_ci on identityiq.spt_audit_event (source);
    GO

    create index spt_audit_application_ci on identityiq.spt_audit_event (application);
    GO

    create index spt_audit_trackingid_ci on identityiq.spt_audit_event (tracking_id);
    GO

    create index spt_audit_interface_ci on identityiq.spt_audit_event (interface);
    GO

    create index spt_audit_attrVal_ci on identityiq.spt_audit_event (attribute_value);
    GO

    create index spt_audit_accountname_ci on identityiq.spt_audit_event (account_name);
    GO

    create index spt_audit_target_ci on identityiq.spt_audit_event (target);
    GO

    alter table identityiq.spt_audit_event
        add constraint FK536922AEA5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK536922AEA5FB1B1 on identityiq.spt_audit_event (owner);
    GO

    alter table identityiq.spt_audit_event
        add constraint FK536922AE486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK536922AE486634B7 on identityiq.spt_audit_event (assigned_scope);
    GO

    alter table identityiq.spt_authentication_answer
        add constraint FK157EEDDA5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK157EEDDA5FB1B1 on identityiq.spt_authentication_answer (owner);
    GO

    alter table identityiq.spt_authentication_answer
        add constraint FK157EEDD56651F3A
        foreign key (identity_id)
        references identityiq.spt_identity;
    GO

    create index FK157EEDD56651F3A on identityiq.spt_authentication_answer (identity_id);
    GO

    alter table identityiq.spt_authentication_answer
        add constraint FK157EEDD48ADCCD2
        foreign key (question_id)
        references identityiq.spt_authentication_question;
    GO

    create index FK157EEDD48ADCCD2 on identityiq.spt_authentication_answer (question_id);
    GO

    alter table identityiq.spt_authentication_question
        add constraint FKE3609F45A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FKE3609F45A5FB1B1 on identityiq.spt_authentication_question (owner);
    GO

    alter table identityiq.spt_authentication_question
        add constraint FKE3609F45486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FKE3609F45486634B7 on identityiq.spt_authentication_question (assigned_scope);
    GO

    alter table identityiq.spt_batch_request
        add constraint FKA7055A02A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FKA7055A02A5FB1B1 on identityiq.spt_batch_request (owner);
    GO

    alter table identityiq.spt_batch_request
        add constraint FKA7055A02486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FKA7055A02486634B7 on identityiq.spt_batch_request (assigned_scope);
    GO

    alter table identityiq.spt_batch_request_item
        add constraint FK9118CB30A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK9118CB30A5FB1B1 on identityiq.spt_batch_request_item (owner);
    GO

    alter table identityiq.spt_batch_request_item
        add constraint FK9118CB302C200325
        foreign key (batch_request_id)
        references identityiq.spt_batch_request;
    GO

    create index FK9118CB302C200325 on identityiq.spt_batch_request_item (batch_request_id);
    GO

    alter table identityiq.spt_batch_request_item
        add constraint FK9118CB30486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK9118CB30486634B7 on identityiq.spt_batch_request_item (assigned_scope);
    GO

    create index spt_bundle_disabled on identityiq.spt_bundle (disabled);
    GO

    create index spt_bundle_type on identityiq.spt_bundle (type);
    GO

    create index spt_bundle_dispname_ci on identityiq.spt_bundle (displayable_name);
    GO

    create index spt_bundle_extended1_ci on identityiq.spt_bundle (extended1);
    GO

    alter table identityiq.spt_bundle
        add constraint FKFC45E40AA5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FKFC45E40AA5FB1B1 on identityiq.spt_bundle (owner);
    GO

    alter table identityiq.spt_bundle
        add constraint FKFC45E40AF7616785
        foreign key (role_index)
        references identityiq.spt_role_index;
    GO

    create index FKFC45E40AF7616785 on identityiq.spt_bundle (role_index);
    GO

    alter table identityiq.spt_bundle
        add constraint FKFC45E40A486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FKFC45E40A486634B7 on identityiq.spt_bundle (assigned_scope);
    GO

    alter table identityiq.spt_bundle
        add constraint FKFC45E40ABD5A5736
        foreign key (pending_workflow)
        references identityiq.spt_workflow_case;
    GO

    create index FKFC45E40ABD5A5736 on identityiq.spt_bundle (pending_workflow);
    GO

    alter table identityiq.spt_bundle
        add constraint FKFC45E40ABF46222D
        foreign key (join_rule)
        references identityiq.spt_rule;
    GO

    create index FKFC45E40ABF46222D on identityiq.spt_bundle (join_rule);
    GO

    alter table identityiq.spt_bundle
        add constraint FKFC45E40ACC129F2E
        foreign key (scorecard)
        references identityiq.spt_role_scorecard;
    GO

    create index FKFC45E40ACC129F2E on identityiq.spt_bundle (scorecard);
    GO

    create index spt_bundle_archive_source on identityiq.spt_bundle_archive (source_id);
    GO

    alter table identityiq.spt_bundle_archive
        add constraint FK4C6C18DA5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK4C6C18DA5FB1B1 on identityiq.spt_bundle_archive (owner);
    GO

    alter table identityiq.spt_bundle_archive
        add constraint FK4C6C18D486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK4C6C18D486634B7 on identityiq.spt_bundle_archive (assigned_scope);
    GO

    alter table identityiq.spt_bundle_children
        add constraint FK5D48969428E03F44
        foreign key (bundle)
        references identityiq.spt_bundle;
    GO

    create index FK5D48969428E03F44 on identityiq.spt_bundle_children (bundle);
    GO

    alter table identityiq.spt_bundle_children
        add constraint FK5D48969480A503DE
        foreign key (child)
        references identityiq.spt_bundle;
    GO

    create index FK5D48969480A503DE on identityiq.spt_bundle_children (child);
    GO

    alter table identityiq.spt_bundle_permits
        add constraint FK8EAE08328E03F44
        foreign key (bundle)
        references identityiq.spt_bundle;
    GO

    create index FK8EAE08328E03F44 on identityiq.spt_bundle_permits (bundle);
    GO

    alter table identityiq.spt_bundle_permits
        add constraint FK8EAE08380A503DE
        foreign key (child)
        references identityiq.spt_bundle;
    GO

    create index FK8EAE08380A503DE on identityiq.spt_bundle_permits (child);
    GO

    alter table identityiq.spt_bundle_requirements
        add constraint FK582892A528E03F44
        foreign key (bundle)
        references identityiq.spt_bundle;
    GO

    create index FK582892A528E03F44 on identityiq.spt_bundle_requirements (bundle);
    GO

    alter table identityiq.spt_bundle_requirements
        add constraint FK582892A580A503DE
        foreign key (child)
        references identityiq.spt_bundle;
    GO

    create index FK582892A580A503DE on identityiq.spt_bundle_requirements (child);
    GO

    alter table identityiq.spt_capability
        add constraint FK5E9BD4A0A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK5E9BD4A0A5FB1B1 on identityiq.spt_capability (owner);
    GO

    alter table identityiq.spt_capability
        add constraint FK5E9BD4A0486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK5E9BD4A0486634B7 on identityiq.spt_capability (assigned_scope);
    GO

    alter table identityiq.spt_capability_children
        add constraint FKC7A8EEBEC4BCFA76
        foreign key (child_id)
        references identityiq.spt_capability;
    GO

    create index FKC7A8EEBEC4BCFA76 on identityiq.spt_capability_children (child_id);
    GO

    alter table identityiq.spt_capability_children
        add constraint FKC7A8EEBEA526F8FA
        foreign key (capability_id)
        references identityiq.spt_capability;
    GO

    create index FKC7A8EEBEA526F8FA on identityiq.spt_capability_children (capability_id);
    GO

    alter table identityiq.spt_capability_rights
        add constraint FKDCDA3656A526F8FA
        foreign key (capability_id)
        references identityiq.spt_capability;
    GO

    create index FKDCDA3656A526F8FA on identityiq.spt_capability_rights (capability_id);
    GO

    alter table identityiq.spt_capability_rights
        add constraint FKDCDA3656D22635BD
        foreign key (right_id)
        references identityiq.spt_right;
    GO

    create index FKDCDA3656D22635BD on identityiq.spt_capability_rights (right_id);
    GO

    alter table identityiq.spt_category
        add constraint FK528AAE86A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK528AAE86A5FB1B1 on identityiq.spt_category (owner);
    GO

    alter table identityiq.spt_category
        add constraint FK528AAE86486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK528AAE86486634B7 on identityiq.spt_category (assigned_scope);
    GO

    alter table identityiq.spt_cert_action_assoc
        add constraint FK9F3F8E7F84D52C6E
        foreign key (child_id)
        references identityiq.spt_certification_action;
    GO

    create index FK9F3F8E7F84D52C6E on identityiq.spt_cert_action_assoc (child_id);
    GO

    alter table identityiq.spt_cert_action_assoc
        add constraint FK9F3F8E7F9D51C620
        foreign key (parent_id)
        references identityiq.spt_certification_action;
    GO

    create index FK9F3F8E7F9D51C620 on identityiq.spt_cert_action_assoc (parent_id);
    GO

    alter table identityiq.spt_cert_item_applications
        add constraint FK4F97C0FCBCA86BEF
        foreign key (certification_item_id)
        references identityiq.spt_certification_item;
    GO

    create index FK4F97C0FCBCA86BEF on identityiq.spt_cert_item_applications (certification_item_id);
    GO

    create index spt_cert_group_id on identityiq.spt_certification (group_definition_id);
    GO

    create index spt_cert_type on identityiq.spt_certification (type);
    GO

    create index spt_certification_phase on identityiq.spt_certification (phase);
    GO

    create index spt_cert_nextRemediationScan on identityiq.spt_certification (next_remediation_scan);
    GO

    create index spt_cert_group_name on identityiq.spt_certification (group_definition_name);
    GO

    create index spt_cert_nxt_phs_tran on identityiq.spt_certification (next_phase_transition);
    GO

    create index spt_certification_short_name on identityiq.spt_certification (short_name);
    GO

    create index spt_cert_exclude_inactive on identityiq.spt_certification (exclude_inactive);
    GO

    create index spt_certification_signed on identityiq.spt_certification (signed);
    GO

    create index spt_cert_auto_close_date on identityiq.spt_certification (automatic_closing_date);
    GO

    create index spt_cert_application on identityiq.spt_certification (application_id);
    GO

    create index nxt_overdue_scan on identityiq.spt_certification (next_overdue_scan);
    GO

    create index spt_cert_electronic_signed on identityiq.spt_certification (electronically_signed);
    GO

    create index spt_cert_cert_def_id on identityiq.spt_certification (certification_definition_id);
    GO

    create index spt_certification_name on identityiq.spt_certification (name);
    GO

    create index spt_cert_trigger_id on identityiq.spt_certification (trigger_id);
    GO

    create index nxt_cert_req_scan on identityiq.spt_certification (next_cert_required_scan);
    GO

    create index spt_cert_manager on identityiq.spt_certification (manager);
    GO

    create index spt_cert_percent_complete on identityiq.spt_certification (percent_complete);
    GO

    create index spt_certification_finished on identityiq.spt_certification (finished);
    GO

    create index spt_cert_task_sched_id on identityiq.spt_certification (task_schedule_id);
    GO

    alter table identityiq.spt_certification
        add constraint FK4E6F1832A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK4E6F1832A5FB1B1 on identityiq.spt_certification (owner);
    GO

    alter table identityiq.spt_certification
        add constraint FK4E6F18323733F724
        foreign key (parent)
        references identityiq.spt_certification;
    GO

    create index FK4E6F18323733F724 on identityiq.spt_certification (parent);
    GO

    alter table identityiq.spt_certification
        add constraint FK4E6F1832486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK4E6F1832486634B7 on identityiq.spt_certification (assigned_scope);
    GO

    create index spt_item_ready_for_remed on identityiq.spt_certification_action (ready_for_remediation);
    GO

    alter table identityiq.spt_certification_action
        add constraint FK198026E3A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK198026E3A5FB1B1 on identityiq.spt_certification_action (owner);
    GO

    alter table identityiq.spt_certification_action
        add constraint FK198026E310F4E42A
        foreign key (source_action)
        references identityiq.spt_certification_action;
    GO

    create index FK198026E310F4E42A on identityiq.spt_certification_action (source_action);
    GO

    alter table identityiq.spt_certification_action
        add constraint FK198026E3486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK198026E3486634B7 on identityiq.spt_certification_action (assigned_scope);
    GO

    create index spt_cert_archive_grp_id on identityiq.spt_certification_archive (certification_group_id);
    GO

    create index spt_cert_archive_id on identityiq.spt_certification_archive (certification_id);
    GO

    create index spt_cert_archive_creator on identityiq.spt_certification_archive (creator);
    GO

    alter table identityiq.spt_certification_archive
        add constraint FK2F2D4DB5A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK2F2D4DB5A5FB1B1 on identityiq.spt_certification_archive (owner);
    GO

    alter table identityiq.spt_certification_archive
        add constraint FK2F2D4DB5486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK2F2D4DB5486634B7 on identityiq.spt_certification_archive (assigned_scope);
    GO

    alter table identityiq.spt_certification_challenge
        add constraint FKCFF77896A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FKCFF77896A5FB1B1 on identityiq.spt_certification_challenge (owner);
    GO

    alter table identityiq.spt_certification_challenge
        add constraint FKCFF77896486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FKCFF77896486634B7 on identityiq.spt_certification_challenge (assigned_scope);
    GO

    alter table identityiq.spt_certification_def_tags
        add constraint FK4313558015CFE57D
        foreign key (cert_def_id)
        references identityiq.spt_certification_definition;
    GO

    create index FK4313558015CFE57D on identityiq.spt_certification_def_tags (cert_def_id);
    GO

    alter table identityiq.spt_certification_def_tags
        add constraint FK43135580E6181207
        foreign key (elt)
        references identityiq.spt_tag;
    GO

    create index FK43135580E6181207 on identityiq.spt_certification_def_tags (elt);
    GO

    alter table identityiq.spt_certification_definition
        add constraint FKD2CBBF80A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FKD2CBBF80A5FB1B1 on identityiq.spt_certification_definition (owner);
    GO

    alter table identityiq.spt_certification_definition
        add constraint FKD2CBBF80486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FKD2CBBF80486634B7 on identityiq.spt_certification_definition (assigned_scope);
    GO

    alter table identityiq.spt_certification_delegation
        add constraint FK62173755A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK62173755A5FB1B1 on identityiq.spt_certification_delegation (owner);
    GO

    alter table identityiq.spt_certification_delegation
        add constraint FK62173755486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK62173755486634B7 on identityiq.spt_certification_delegation (assigned_scope);
    GO

    create index spt_certification_entity_diffs on identityiq.spt_certification_entity (has_differences);
    GO

    create index spt_certification_entity_stat on identityiq.spt_certification_entity (summary_status);
    GO

    create index spt_certification_entity_nsc on identityiq.spt_certification_entity (next_continuous_state_change);
    GO

    create index spt_certification_entity_state on identityiq.spt_certification_entity (continuous_state);
    GO

    create index spt_certification_entity_ld on identityiq.spt_certification_entity (last_decision);
    GO

    create index spt_certification_entity_tn on identityiq.spt_certification_entity (target_name);
    GO

    create index spt_certification_entity_due on identityiq.spt_certification_entity (overdue_date);
    GO

    create index spt_cert_entity_firstname_ci on identityiq.spt_certification_entity (firstname);
    GO

    create index spt_cert_entity_pending on identityiq.spt_certification_entity (pending_certification);
    GO

    create index spt_cert_entity_lastname_ci on identityiq.spt_certification_entity (lastname);
    GO

    create index spt_cert_entity_identity on identityiq.spt_certification_entity (identity_id);
    GO

    create index spt_cert_entity_new_user on identityiq.spt_certification_entity (new_user);
    GO

    create index spt_cert_entity_cscore on identityiq.spt_certification_entity (composite_score);
    GO

    alter table identityiq.spt_certification_entity
        add constraint FK20EE8C90DB59193A
        foreign key (certification_id)
        references identityiq.spt_certification;
    GO

    create index FK20EE8C90DB59193A on identityiq.spt_certification_entity (certification_id);
    GO

    alter table identityiq.spt_certification_entity
        add constraint FK641BE42DA5FB1B120ee8c90
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK641BE42DA5FB1B120ee8c90 on identityiq.spt_certification_entity (owner);
    GO

    alter table identityiq.spt_certification_entity
        add constraint FK641BE42DCD1A938620ee8c90
        foreign key (action)
        references identityiq.spt_certification_action;
    GO

    create index FK641BE42DCD1A938620ee8c90 on identityiq.spt_certification_entity (action);
    GO

    alter table identityiq.spt_certification_entity
        add constraint FK641BE42D486634B720ee8c90
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK641BE42D486634B720ee8c90 on identityiq.spt_certification_entity (assigned_scope);
    GO

    alter table identityiq.spt_certification_entity
        add constraint FK641BE42D982FD46A20ee8c90
        foreign key (delegation)
        references identityiq.spt_certification_delegation;
    GO

    create index FK641BE42D982FD46A20ee8c90 on identityiq.spt_certification_entity (delegation);
    GO

    create index spt_cert_group_type on identityiq.spt_certification_group (type);
    GO

    create index spt_cert_group_status on identityiq.spt_certification_group (status);
    GO

    create index spt_cert_grp_perc_comp on identityiq.spt_certification_group (percent_complete);
    GO

    alter table identityiq.spt_certification_group
        add constraint FK11B20432A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK11B20432A5FB1B1 on identityiq.spt_certification_group (owner);
    GO

    alter table identityiq.spt_certification_group
        add constraint FK11B20432486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK11B20432486634B7 on identityiq.spt_certification_group (assigned_scope);
    GO

    alter table identityiq.spt_certification_group
        add constraint FK11B2043263178D65
        foreign key (certification_definition)
        references identityiq.spt_certification_definition;
    GO

    create index FK11B2043263178D65 on identityiq.spt_certification_group (certification_definition);
    GO

    alter table identityiq.spt_certification_groups
        add constraint FK248E8281DB59193A
        foreign key (certification_id)
        references identityiq.spt_certification;
    GO

    create index FK248E8281DB59193A on identityiq.spt_certification_groups (certification_id);
    GO

    alter table identityiq.spt_certification_groups
        add constraint FK248E8281F6578B00
        foreign key (group_id)
        references identityiq.spt_certification_group;
    GO

    create index FK248E8281F6578B00 on identityiq.spt_certification_groups (group_id);
    GO

    create index spt_certification_item_diffs on identityiq.spt_certification_item (has_differences);
    GO

    create index spt_certification_item_stat on identityiq.spt_certification_item (summary_status);
    GO

    create index spt_certification_item_nsc on identityiq.spt_certification_item (next_continuous_state_change);
    GO

    create index spt_certification_item_state on identityiq.spt_certification_item (continuous_state);
    GO

    create index spt_certification_item_ld on identityiq.spt_certification_item (last_decision);
    GO

    create index spt_certification_item_tn on identityiq.spt_certification_item (target_name);
    GO

    create index spt_certification_item_due on identityiq.spt_certification_item (overdue_date);
    GO

    create index spt_cert_item_type on identityiq.spt_certification_item (type);
    GO

    create index spt_certitem_extended1_ci on identityiq.spt_certification_item (extended1);
    GO

    create index spt_cert_item_perm_target on identityiq.spt_certification_item (exception_permission_target);
    GO

    create index spt_cert_item_perm_right on identityiq.spt_certification_item (exception_permission_right);
    GO

    create index spt_cert_item_bundle on identityiq.spt_certification_item (bundle);
    GO

    create index spt_needs_refresh on identityiq.spt_certification_item (needs_refresh);
    GO

    create index spt_cert_item_nxt_phs_tran on identityiq.spt_certification_item (next_phase_transition);
    GO

    create index spt_cert_item_phase on identityiq.spt_certification_item (phase);
    GO

    create index spt_cert_item_exception_app on identityiq.spt_certification_item (exception_application);
    GO

    create index spt_cert_item_wk_up on identityiq.spt_certification_item (wake_up_date);
    GO

    alter table identityiq.spt_certification_item
        add constraint FK641BE42DA5FB1B1adfe6b00
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK641BE42DA5FB1B1adfe6b00 on identityiq.spt_certification_item (owner);
    GO

    alter table identityiq.spt_certification_item
        add constraint FKADFE6B00809C88AF
        foreign key (certification_entity_id)
        references identityiq.spt_certification_entity;
    GO

    create index FKADFE6B00809C88AF on identityiq.spt_certification_item (certification_entity_id);
    GO

    alter table identityiq.spt_certification_item
        add constraint FKADFE6B00B749D36C
        foreign key (challenge)
        references identityiq.spt_certification_challenge;
    GO

    create index FKADFE6B00B749D36C on identityiq.spt_certification_item (challenge);
    GO

    alter table identityiq.spt_certification_item
        add constraint FK641BE42DCD1A9386adfe6b00
        foreign key (action)
        references identityiq.spt_certification_action;
    GO

    create index FK641BE42DCD1A9386adfe6b00 on identityiq.spt_certification_item (action);
    GO

    alter table identityiq.spt_certification_item
        add constraint FK641BE42D486634B7adfe6b00
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK641BE42D486634B7adfe6b00 on identityiq.spt_certification_item (assigned_scope);
    GO

    alter table identityiq.spt_certification_item
        add constraint FK641BE42D982FD46Aadfe6b00
        foreign key (delegation)
        references identityiq.spt_certification_delegation;
    GO

    create index FK641BE42D982FD46Aadfe6b00 on identityiq.spt_certification_item (delegation);
    GO

    alter table identityiq.spt_certification_item
        add constraint FKADFE6B008C97EA7
        foreign key (exception_entitlements)
        references identityiq.spt_entitlement_snapshot;
    GO

    create index FKADFE6B008C97EA7 on identityiq.spt_certification_item (exception_entitlements);
    GO

    alter table identityiq.spt_certification_tags
        add constraint FKAE032406DB59193A
        foreign key (certification_id)
        references identityiq.spt_certification;
    GO

    create index FKAE032406DB59193A on identityiq.spt_certification_tags (certification_id);
    GO

    alter table identityiq.spt_certification_tags
        add constraint FKAE032406E6181207
        foreign key (elt)
        references identityiq.spt_tag;
    GO

    create index FKAE032406E6181207 on identityiq.spt_certification_tags (elt);
    GO

    alter table identityiq.spt_certifiers
        add constraint FK784C89A6DB59193A
        foreign key (certification_id)
        references identityiq.spt_certification;
    GO

    create index FK784C89A6DB59193A on identityiq.spt_certifiers (certification_id);
    GO

    alter table identityiq.spt_child_certification_ids
        add constraint FK2D614AC817639745
        foreign key (certification_archive_id)
        references identityiq.spt_certification_archive;
    GO

    create index FK2D614AC817639745 on identityiq.spt_child_certification_ids (certification_archive_id);
    GO

    alter table identityiq.spt_configuration
        add constraint FKE80D386EA5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FKE80D386EA5FB1B1 on identityiq.spt_configuration (owner);
    GO

    alter table identityiq.spt_configuration
        add constraint FKE80D386E486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FKE80D386E486634B7 on identityiq.spt_configuration (assigned_scope);
    GO

    alter table identityiq.spt_correlation_config
        add constraint FK3A3DBC27A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK3A3DBC27A5FB1B1 on identityiq.spt_correlation_config (owner);
    GO

    alter table identityiq.spt_correlation_config
        add constraint FK3A3DBC27486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK3A3DBC27486634B7 on identityiq.spt_correlation_config (assigned_scope);
    GO

    create index spt_custom_name_csi on identityiq.spt_custom (name);
    GO

    alter table identityiq.spt_custom
        add constraint FKFDFD3EF9A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FKFDFD3EF9A5FB1B1 on identityiq.spt_custom (owner);
    GO

    alter table identityiq.spt_custom
        add constraint FKFDFD3EF9486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FKFDFD3EF9486634B7 on identityiq.spt_custom (assigned_scope);
    GO

    create index spt_dashboard_content_task on identityiq.spt_dashboard_content (source_task_id);
    GO

    create index spt_dashboard_type on identityiq.spt_dashboard_content (type);
    GO

    alter table identityiq.spt_dashboard_content
        add constraint FKC4B33946A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FKC4B33946A5FB1B1 on identityiq.spt_dashboard_content (owner);
    GO

    alter table identityiq.spt_dashboard_content
        add constraint FKC4B33946B513AA2F
        foreign key (parent)
        references identityiq.spt_dashboard_content;
    GO

    create index FKC4B33946B513AA2F on identityiq.spt_dashboard_content (parent);
    GO

    alter table identityiq.spt_dashboard_content
        add constraint FKC4B33946486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FKC4B33946486634B7 on identityiq.spt_dashboard_content (assigned_scope);
    GO

    alter table identityiq.spt_dashboard_content_rights
        add constraint FK106D6AF0D22635BD
        foreign key (right_id)
        references identityiq.spt_right;
    GO

    create index FK106D6AF0D22635BD on identityiq.spt_dashboard_content_rights (right_id);
    GO

    alter table identityiq.spt_dashboard_content_rights
        add constraint FK106D6AF0D91E26B1
        foreign key (dashboard_content_id)
        references identityiq.spt_dashboard_content;
    GO

    create index FK106D6AF0D91E26B1 on identityiq.spt_dashboard_content_rights (dashboard_content_id);
    GO

    alter table identityiq.spt_dashboard_layout
        add constraint FK9914A8BDA5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK9914A8BDA5FB1B1 on identityiq.spt_dashboard_layout (owner);
    GO

    alter table identityiq.spt_dashboard_layout
        add constraint FK9914A8BD486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK9914A8BD486634B7 on identityiq.spt_dashboard_layout (assigned_scope);
    GO

    alter table identityiq.spt_dashboard_reference
        add constraint FK45E944D8A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK45E944D8A5FB1B1 on identityiq.spt_dashboard_reference (owner);
    GO

    alter table identityiq.spt_dashboard_reference
        add constraint FK45E944D8878775BD
        foreign key (identity_dashboard_id)
        references identityiq.spt_identity_dashboard;
    GO

    create index FK45E944D8878775BD on identityiq.spt_dashboard_reference (identity_dashboard_id);
    GO

    alter table identityiq.spt_dashboard_reference
        add constraint FK45E944D82D6026
        foreign key (content_id)
        references identityiq.spt_dashboard_content;
    GO

    create index FK45E944D82D6026 on identityiq.spt_dashboard_reference (content_id);
    GO

    alter table identityiq.spt_dashboard_reference
        add constraint FK45E944D8486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK45E944D8486634B7 on identityiq.spt_dashboard_reference (assigned_scope);
    GO

    create index spt_delObj_name_ci on identityiq.spt_deleted_object (name);
    GO

    create index spt_delObj_nativeIdentity_ci on identityiq.spt_deleted_object (native_identity);
    GO

    create index spt_delObj_objectType_ci on identityiq.spt_deleted_object (object_type);
    GO

    create index spt_delObj_lastRefresh on identityiq.spt_deleted_object (last_refresh);
    GO

    alter table identityiq.spt_deleted_object
        add constraint FKA08C7DADA5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FKA08C7DADA5FB1B1 on identityiq.spt_deleted_object (owner);
    GO

    alter table identityiq.spt_deleted_object
        add constraint FKA08C7DAD39D71460
        foreign key (application)
        references identityiq.spt_application;
    GO

    create index FKA08C7DAD39D71460 on identityiq.spt_deleted_object (application);
    GO

    alter table identityiq.spt_deleted_object
        add constraint FKA08C7DAD486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FKA08C7DAD486634B7 on identityiq.spt_deleted_object (assigned_scope);
    GO

    alter table identityiq.spt_dictionary
        add constraint FKA7F7201EA5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FKA7F7201EA5FB1B1 on identityiq.spt_dictionary (owner);
    GO

    alter table identityiq.spt_dictionary
        add constraint FKA7F7201E486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FKA7F7201E486634B7 on identityiq.spt_dictionary (assigned_scope);
    GO

    alter table identityiq.spt_dictionary_term
        add constraint FK8E1F3FEDA5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK8E1F3FEDA5FB1B1 on identityiq.spt_dictionary_term (owner);
    GO

    alter table identityiq.spt_dictionary_term
        add constraint FK8E1F3FED486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK8E1F3FED486634B7 on identityiq.spt_dictionary_term (assigned_scope);
    GO

    alter table identityiq.spt_dictionary_term
        add constraint FK8E1F3FED8598603A
        foreign key (dictionary_id)
        references identityiq.spt_dictionary;
    GO

    create index FK8E1F3FED8598603A on identityiq.spt_dictionary_term (dictionary_id);
    GO

    alter table identityiq.spt_dynamic_scope
        add constraint FKA73F59CCA5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FKA73F59CCA5FB1B1 on identityiq.spt_dynamic_scope (owner);
    GO

    alter table identityiq.spt_dynamic_scope
        add constraint FKA73F59CC8A8BFFA
        foreign key (application_request_control)
        references identityiq.spt_rule;
    GO

    create index FKA73F59CC8A8BFFA on identityiq.spt_dynamic_scope (application_request_control);
    GO

    alter table identityiq.spt_dynamic_scope
        add constraint FKA73F59CCE677873B
        foreign key (managed_attr_request_control)
        references identityiq.spt_rule;
    GO

    create index FKA73F59CCE677873B on identityiq.spt_dynamic_scope (managed_attr_request_control);
    GO

    alter table identityiq.spt_dynamic_scope
        add constraint FKA73F59CC11B2F20
        foreign key (role_request_control)
        references identityiq.spt_rule;
    GO

    create index FKA73F59CC11B2F20 on identityiq.spt_dynamic_scope (role_request_control);
    GO

    alter table identityiq.spt_dynamic_scope
        add constraint FKA73F59CC486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FKA73F59CC486634B7 on identityiq.spt_dynamic_scope (assigned_scope);
    GO

    alter table identityiq.spt_dynamic_scope_exclusions
        add constraint FKFCBD20B86F1CB67B
        foreign key (dynamic_scope_id)
        references identityiq.spt_dynamic_scope;
    GO

    create index FKFCBD20B86F1CB67B on identityiq.spt_dynamic_scope_exclusions (dynamic_scope_id);
    GO

    alter table identityiq.spt_dynamic_scope_exclusions
        add constraint FKFCBD20B856651F3A
        foreign key (identity_id)
        references identityiq.spt_identity;
    GO

    create index FKFCBD20B856651F3A on identityiq.spt_dynamic_scope_exclusions (identity_id);
    GO

    alter table identityiq.spt_dynamic_scope_inclusions
        add constraint FK3368F2A6F1CB67B
        foreign key (dynamic_scope_id)
        references identityiq.spt_dynamic_scope;
    GO

    create index FK3368F2A6F1CB67B on identityiq.spt_dynamic_scope_inclusions (dynamic_scope_id);
    GO

    alter table identityiq.spt_dynamic_scope_inclusions
        add constraint FK3368F2A56651F3A
        foreign key (identity_id)
        references identityiq.spt_identity;
    GO

    create index FK3368F2A56651F3A on identityiq.spt_dynamic_scope_inclusions (identity_id);
    GO

    alter table identityiq.spt_email_template
        add constraint FK9261AD45A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK9261AD45A5FB1B1 on identityiq.spt_email_template (owner);
    GO

    alter table identityiq.spt_email_template
        add constraint FK9261AD45486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK9261AD45486634B7 on identityiq.spt_email_template (assigned_scope);
    GO

    alter table identityiq.spt_email_template_properties
        add constraint emailtemplateproperties
        foreign key (id)
        references identityiq.spt_email_template;
    GO

    create index emailtemplateproperties on identityiq.spt_email_template_properties (id);
    GO

    alter table identityiq.spt_entitlement_group
        add constraint FK13D2B865A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK13D2B865A5FB1B1 on identityiq.spt_entitlement_group (owner);
    GO

    alter table identityiq.spt_entitlement_group
        add constraint FK13D2B86539D71460
        foreign key (application)
        references identityiq.spt_application;
    GO

    create index FK13D2B86539D71460 on identityiq.spt_entitlement_group (application);
    GO

    alter table identityiq.spt_entitlement_group
        add constraint FK13D2B86556651F3A
        foreign key (identity_id)
        references identityiq.spt_identity;
    GO

    create index FK13D2B86556651F3A on identityiq.spt_entitlement_group (identity_id);
    GO

    alter table identityiq.spt_entitlement_group
        add constraint FK13D2B865486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK13D2B865486634B7 on identityiq.spt_entitlement_group (assigned_scope);
    GO

    create index spt_ent_snap_application_ci on identityiq.spt_entitlement_snapshot (application);
    GO

    create index spt_ent_snap_nativeIdentity_ci on identityiq.spt_entitlement_snapshot (native_identity);
    GO

    create index spt_ent_snap_displayName_ci on identityiq.spt_entitlement_snapshot (display_name);
    GO

    alter table identityiq.spt_entitlement_snapshot
        add constraint FKC98E021EBCA86BEF
        foreign key (certification_item_id)
        references identityiq.spt_certification_item;
    GO

    create index FKC98E021EBCA86BEF on identityiq.spt_entitlement_snapshot (certification_item_id);
    GO

    create index file_bucketNumber on identityiq.spt_file_bucket (file_index);
    GO

    alter table identityiq.spt_file_bucket
        add constraint FK7A22AF85A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK7A22AF85A5FB1B1 on identityiq.spt_file_bucket (owner);
    GO

    alter table identityiq.spt_file_bucket
        add constraint FK7A22AF85A620641F
        foreign key (parent_id)
        references identityiq.spt_persisted_file;
    GO

    create index FK7A22AF85A620641F on identityiq.spt_file_bucket (parent_id);
    GO

    alter table identityiq.spt_file_bucket
        add constraint FK7A22AF85486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK7A22AF85486634B7 on identityiq.spt_file_bucket (assigned_scope);
    GO

    alter table identityiq.spt_form
        add constraint FK9A3E024CA5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK9A3E024CA5FB1B1 on identityiq.spt_form (owner);
    GO

    alter table identityiq.spt_form
        add constraint FK9A3E024C39D71460
        foreign key (application)
        references identityiq.spt_application;
    GO

    create index FK9A3E024C39D71460 on identityiq.spt_form (application);
    GO

    alter table identityiq.spt_form
        add constraint FK9A3E024C486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK9A3E024C486634B7 on identityiq.spt_form (assigned_scope);
    GO

    alter table identityiq.spt_generic_constraint
        add constraint FK1A3C4CCDA5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK1A3C4CCDA5FB1B1 on identityiq.spt_generic_constraint (owner);
    GO

    alter table identityiq.spt_generic_constraint
        add constraint FK1A3C4CCD16E8C617
        foreign key (violation_owner)
        references identityiq.spt_identity;
    GO

    create index FK1A3C4CCD16E8C617 on identityiq.spt_generic_constraint (violation_owner);
    GO

    alter table identityiq.spt_generic_constraint
        add constraint FK1A3C4CCD486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK1A3C4CCD486634B7 on identityiq.spt_generic_constraint (assigned_scope);
    GO

    alter table identityiq.spt_generic_constraint
        add constraint FK1A3C4CCD2E02D59E
        foreign key (violation_owner_rule)
        references identityiq.spt_rule;
    GO

    create index FK1A3C4CCD2E02D59E on identityiq.spt_generic_constraint (violation_owner_rule);
    GO

    alter table identityiq.spt_generic_constraint
        add constraint FK1A3C4CCD57FD28A4
        foreign key (policy)
        references identityiq.spt_policy;
    GO

    create index FK1A3C4CCD57FD28A4 on identityiq.spt_generic_constraint (policy);
    GO

    alter table identityiq.spt_group_definition
        add constraint FK21F3C89BA5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK21F3C89BA5FB1B1 on identityiq.spt_group_definition (owner);
    GO

    alter table identityiq.spt_group_definition
        add constraint FK21F3C89BFA54B4D5
        foreign key (factory)
        references identityiq.spt_group_factory;
    GO

    create index FK21F3C89BFA54B4D5 on identityiq.spt_group_definition (factory);
    GO

    alter table identityiq.spt_group_definition
        add constraint FK21F3C89B486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK21F3C89B486634B7 on identityiq.spt_group_definition (assigned_scope);
    GO

    alter table identityiq.spt_group_definition
        add constraint FK21F3C89B1CE09EE5
        foreign key (group_index)
        references identityiq.spt_group_index;
    GO

    create index FK21F3C89B1CE09EE5 on identityiq.spt_group_definition (group_index);
    GO

    alter table identityiq.spt_group_factory
        add constraint FK36D2A2C2A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK36D2A2C2A5FB1B1 on identityiq.spt_group_factory (owner);
    GO

    alter table identityiq.spt_group_factory
        add constraint FK36D2A2C252F9C404
        foreign key (group_owner_rule)
        references identityiq.spt_rule;
    GO

    create index FK36D2A2C252F9C404 on identityiq.spt_group_factory (group_owner_rule);
    GO

    alter table identityiq.spt_group_factory
        add constraint FK36D2A2C2486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK36D2A2C2486634B7 on identityiq.spt_group_factory (assigned_scope);
    GO

    create index group_index_cscore on identityiq.spt_group_index (composite_score);
    GO

    alter table identityiq.spt_group_index
        add constraint FK5E03A88AA5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK5E03A88AA5FB1B1 on identityiq.spt_group_index (owner);
    GO

    alter table identityiq.spt_group_index
        add constraint FK5E03A88A486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK5E03A88A486634B7 on identityiq.spt_group_index (assigned_scope);
    GO

    alter table identityiq.spt_group_index
        add constraint FK5E03A88AF7729445
        foreign key (definition)
        references identityiq.spt_group_definition;
    GO

    create index FK5E03A88AF7729445 on identityiq.spt_group_index (definition);
    GO

    alter table identityiq.spt_group_permissions
        add constraint FKB27ACA3CC60D993F
        foreign key (entitlement_group_id)
        references identityiq.spt_entitlement_group;
    GO

    create index FKB27ACA3CC60D993F on identityiq.spt_group_permissions (entitlement_group_id);
    GO

    create index spt_identity_lastRefresh on identityiq.spt_identity (last_refresh);
    GO

    create index spt_identity_isworkgroup on identityiq.spt_identity (workgroup);
    GO

    create index spt_identity_type_ci on identityiq.spt_identity (type);
    GO

    create index spt_identity_displayName_ci on identityiq.spt_identity (display_name);
    GO

    create index spt_identity_lastname_ci on identityiq.spt_identity (lastname);
    GO

    create index spt_identity_sw_version_ci on identityiq.spt_identity (software_version);
    GO

    create index spt_identity_extended1_ci on identityiq.spt_identity (extended1);
    GO

    create index spt_identity_extended2_ci on identityiq.spt_identity (extended2);
    GO

    create index spt_identity_manager_status on identityiq.spt_identity (manager_status);
    GO

    create index spt_identity_email_ci on identityiq.spt_identity (email);
    GO

    create index spt_identity_inactive on identityiq.spt_identity (inactive);
    GO

    create index spt_identity_firstname_ci on identityiq.spt_identity (firstname);
    GO

    create index spt_identity_correlated on identityiq.spt_identity (correlated);
    GO

    create index spt_identity_needs_refresh on identityiq.spt_identity (needs_refresh);
    GO

    create index spt_identity_extended4_ci on identityiq.spt_identity (extended4);
    GO

    create index spt_identity_extended5_ci on identityiq.spt_identity (extended5);
    GO

    create index spt_identity_extended3_ci on identityiq.spt_identity (extended3);
    GO

    alter table identityiq.spt_identity
        add constraint FK47706246A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK47706246A5FB1B1 on identityiq.spt_identity (owner);
    GO

    alter table identityiq.spt_identity
        add constraint FK47706246DD2B81CB
        foreign key (administrator)
        references identityiq.spt_identity;
    GO

    create index FK47706246DD2B81CB on identityiq.spt_identity (administrator);
    GO

    alter table identityiq.spt_identity
        add constraint FK4770624622315AAF
        foreign key (extended_identity5)
        references identityiq.spt_identity;
    GO

    create index FK4770624622315AAF on identityiq.spt_identity (extended_identity5);
    GO

    alter table identityiq.spt_identity
        add constraint FK4770624635D4CEAB
        foreign key (manager)
        references identityiq.spt_identity;
    GO

    create index FK4770624635D4CEAB on identityiq.spt_identity (manager);
    GO

    alter table identityiq.spt_identity
        add constraint FK4770624622315AAE
        foreign key (extended_identity4)
        references identityiq.spt_identity;
    GO

    create index FK4770624622315AAE on identityiq.spt_identity (extended_identity4);
    GO

    alter table identityiq.spt_identity
        add constraint FK4770624622315AAB
        foreign key (extended_identity1)
        references identityiq.spt_identity;
    GO

    create index FK4770624622315AAB on identityiq.spt_identity (extended_identity1);
    GO

    alter table identityiq.spt_identity
        add constraint FK47706246486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK47706246486634B7 on identityiq.spt_identity (assigned_scope);
    GO

    alter table identityiq.spt_identity
        add constraint FK4770624622315AAD
        foreign key (extended_identity3)
        references identityiq.spt_identity;
    GO

    create index FK4770624622315AAD on identityiq.spt_identity (extended_identity3);
    GO

    alter table identityiq.spt_identity
        add constraint FK4770624622315AAC
        foreign key (extended_identity2)
        references identityiq.spt_identity;
    GO

    create index FK4770624622315AAC on identityiq.spt_identity (extended_identity2);
    GO

    alter table identityiq.spt_identity
        add constraint FK4770624646DBED88
        foreign key (uipreferences)
        references identityiq.spt_uipreferences;
    GO

    create index FK4770624646DBED88 on identityiq.spt_identity (uipreferences);
    GO

    alter table identityiq.spt_identity
        add constraint FK47706246761EBB04
        foreign key (scorecard)
        references identityiq.spt_scorecard;
    GO

    create index FK47706246761EBB04 on identityiq.spt_identity (scorecard);
    GO

    create index spt_identity_archive_source on identityiq.spt_identity_archive (source_id);
    GO

    alter table identityiq.spt_identity_archive
        add constraint FKF49D43C9A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FKF49D43C9A5FB1B1 on identityiq.spt_identity_archive (owner);
    GO

    alter table identityiq.spt_identity_archive
        add constraint FKF49D43C9486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FKF49D43C9486634B7 on identityiq.spt_identity_archive (assigned_scope);
    GO

    alter table identityiq.spt_identity_assigned_roles
        add constraint FK559F642556651F3A
        foreign key (identity_id)
        references identityiq.spt_identity;
    GO

    create index FK559F642556651F3A on identityiq.spt_identity_assigned_roles (identity_id);
    GO

    alter table identityiq.spt_identity_assigned_roles
        add constraint FK559F642528E03F44
        foreign key (bundle)
        references identityiq.spt_bundle;
    GO

    create index FK559F642528E03F44 on identityiq.spt_identity_assigned_roles (bundle);
    GO

    alter table identityiq.spt_identity_bundles
        add constraint FK2F3B433856651F3A
        foreign key (identity_id)
        references identityiq.spt_identity;
    GO

    create index FK2F3B433856651F3A on identityiq.spt_identity_bundles (identity_id);
    GO

    alter table identityiq.spt_identity_bundles
        add constraint FK2F3B433828E03F44
        foreign key (bundle)
        references identityiq.spt_bundle;
    GO

    create index FK2F3B433828E03F44 on identityiq.spt_identity_bundles (bundle);
    GO

    alter table identityiq.spt_identity_capabilities
        add constraint FK2258790F56651F3A
        foreign key (identity_id)
        references identityiq.spt_identity;
    GO

    create index FK2258790F56651F3A on identityiq.spt_identity_capabilities (identity_id);
    GO

    alter table identityiq.spt_identity_capabilities
        add constraint FK2258790FA526F8FA
        foreign key (capability_id)
        references identityiq.spt_capability;
    GO

    create index FK2258790FA526F8FA on identityiq.spt_identity_capabilities (capability_id);
    GO

    alter table identityiq.spt_identity_controlled_scopes
        add constraint FK926D30B79D803AFA
        foreign key (scope_id)
        references identityiq.spt_scope;
    GO

    create index FK926D30B79D803AFA on identityiq.spt_identity_controlled_scopes (scope_id);
    GO

    alter table identityiq.spt_identity_controlled_scopes
        add constraint FK926D30B756651F3A
        foreign key (identity_id)
        references identityiq.spt_identity;
    GO

    create index FK926D30B756651F3A on identityiq.spt_identity_controlled_scopes (identity_id);
    GO

    create index spt_identity_dashboard_type on identityiq.spt_identity_dashboard (type);
    GO

    alter table identityiq.spt_identity_dashboard
        add constraint FK6732A7DBA5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK6732A7DBA5FB1B1 on identityiq.spt_identity_dashboard (owner);
    GO

    alter table identityiq.spt_identity_dashboard
        add constraint FK6732A7DB68DCB7C8
        foreign key (layout)
        references identityiq.spt_dashboard_layout;
    GO

    create index FK6732A7DB68DCB7C8 on identityiq.spt_identity_dashboard (layout);
    GO

    alter table identityiq.spt_identity_dashboard
        add constraint FK6732A7DB56651F3A
        foreign key (identity_id)
        references identityiq.spt_identity;
    GO

    create index FK6732A7DB56651F3A on identityiq.spt_identity_dashboard (identity_id);
    GO

    alter table identityiq.spt_identity_dashboard
        add constraint FK6732A7DB486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK6732A7DB486634B7 on identityiq.spt_identity_dashboard (assigned_scope);
    GO

    create index spt_identity_ent_ag_state on identityiq.spt_identity_entitlement (aggregation_state);
    GO

    create index spt_identity_ent_assgnid on identityiq.spt_identity_entitlement (assignment_id);
    GO

    create index spt_identity_ent_assigned on identityiq.spt_identity_entitlement (assigned);
    GO

    create index spt_identity_ent_name_ci on identityiq.spt_identity_entitlement (name);
    GO

    create index spt_identity_ent_nativeid_ci on identityiq.spt_identity_entitlement (native_identity);
    GO

    create index spt_identity_ent_type on identityiq.spt_identity_entitlement (type);
    GO

    create index spt_identity_ent_role_granted on identityiq.spt_identity_entitlement (granted_by_role);
    GO

    create index spt_identity_ent_source_ci on identityiq.spt_identity_entitlement (source);
    GO

    create index spt_identity_ent_value_ci on identityiq.spt_identity_entitlement (value);
    GO

    create index spt_identity_ent_instance_ci on identityiq.spt_identity_entitlement (instance);
    GO

    create index spt_identity_ent_allowed on identityiq.spt_identity_entitlement (allowed);
    GO

    alter table identityiq.spt_identity_entitlement
        add constraint FK1134F4B4A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK1134F4B4A5FB1B1 on identityiq.spt_identity_entitlement (owner);
    GO

    alter table identityiq.spt_identity_entitlement
        add constraint FK1134F4B439D71460
        foreign key (application)
        references identityiq.spt_application;
    GO

    create index FK1134F4B439D71460 on identityiq.spt_identity_entitlement (application);
    GO

    alter table identityiq.spt_identity_entitlement
        add constraint FK1134F4B456651F3A
        foreign key (identity_id)
        references identityiq.spt_identity;
    GO

    create index FK1134F4B456651F3A on identityiq.spt_identity_entitlement (identity_id);
    GO

    alter table identityiq.spt_identity_entitlement
        add constraint FK1134F4B484ACD425
        foreign key (certification_item)
        references identityiq.spt_certification_item;
    GO

    create index FK1134F4B484ACD425 on identityiq.spt_identity_entitlement (certification_item);
    GO

    alter table identityiq.spt_identity_entitlement
        add constraint FK1134F4B4D9C563CD
        foreign key (pending_certification_item)
        references identityiq.spt_certification_item;
    GO

    create index FK1134F4B4D9C563CD on identityiq.spt_identity_entitlement (pending_certification_item);
    GO

    alter table identityiq.spt_identity_entitlement
        add constraint FK1134F4B47AEC327
        foreign key (request_item)
        references identityiq.spt_identity_request_item;
    GO

    create index FK1134F4B47AEC327 on identityiq.spt_identity_entitlement (request_item);
    GO

    alter table identityiq.spt_identity_entitlement
        add constraint FK1134F4B4FFB630CF
        foreign key (pending_request_item)
        references identityiq.spt_identity_request_item;
    GO

    create index FK1134F4B4FFB630CF on identityiq.spt_identity_entitlement (pending_request_item);
    GO

    create index spt_id_hist_item_entry_date on identityiq.spt_identity_history_item (entry_date);
    GO

    create index spt_id_hist_item_application on identityiq.spt_identity_history_item (application);
    GO

    create index spt_id_hist_item_value_ci on identityiq.spt_identity_history_item (value);
    GO

    create index spt_id_hist_item_instance on identityiq.spt_identity_history_item (instance);
    GO

    create index spt_id_hist_item_status on identityiq.spt_identity_history_item (status);
    GO

    create index spt_id_hist_item_account_ci on identityiq.spt_identity_history_item (account);
    GO

    create index spt_id_hist_item_policy on identityiq.spt_identity_history_item (policy);
    GO

    create index spt_id_hist_item_role on identityiq.spt_identity_history_item (role);
    GO

    create index spt_id_hist_item_attribute_ci on identityiq.spt_identity_history_item (attribute);
    GO

    create index spt_id_hist_item_cert_type on identityiq.spt_identity_history_item (certification_type);
    GO

    create index spt_id_hist_item_ntv_id_ci on identityiq.spt_identity_history_item (native_identity);
    GO

    create index spt_id_hist_item_actor on identityiq.spt_identity_history_item (actor);
    GO

    alter table identityiq.spt_identity_history_item
        add constraint FK60B7537A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK60B7537A5FB1B1 on identityiq.spt_identity_history_item (owner);
    GO

    alter table identityiq.spt_identity_history_item
        add constraint FK60B753756651F3A
        foreign key (identity_id)
        references identityiq.spt_identity;
    GO

    create index FK60B753756651F3A on identityiq.spt_identity_history_item (identity_id);
    GO

    create index spt_idrequest_endDate on identityiq.spt_identity_request (end_date);
    GO

    create index spt_idrequest_target_id on identityiq.spt_identity_request (target_id);
    GO

    create index spt_idrequest_priority on identityiq.spt_identity_request (priority);
    GO

    create index spt_idrequest_ext_ticket_ci on identityiq.spt_identity_request (external_ticket_id);
    GO

    create index spt_idrequest_name on identityiq.spt_identity_request (name);
    GO

    create index spt_idrequest_requestor_id on identityiq.spt_identity_request (requester_id);
    GO

    create index spt_idrequest_verified on identityiq.spt_identity_request (verified);
    GO

    create index spt_idrequest_requestor_ci on identityiq.spt_identity_request (requester_display_name);
    GO

    create index spt_idrequest_target_ci on identityiq.spt_identity_request (target_display_name);
    GO

    create index spt_idrequest_compl_status on identityiq.spt_identity_request (completion_status);
    GO

    create index spt_idrequest_exec_status on identityiq.spt_identity_request (execution_status);
    GO

    create index spt_idrequest_has_messages on identityiq.spt_identity_request (has_messages);
    GO

    create index spt_idrequest_state on identityiq.spt_identity_request (state);
    GO

    create index spt_idrequest_type on identityiq.spt_identity_request (type);
    GO

    alter table identityiq.spt_identity_request
        add constraint FK62835596A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK62835596A5FB1B1 on identityiq.spt_identity_request (owner);
    GO

    alter table identityiq.spt_identity_request
        add constraint FK62835596486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK62835596486634B7 on identityiq.spt_identity_request (assigned_scope);
    GO

    create index spt_reqitem_nativeid_ci on identityiq.spt_identity_request_item (native_identity);
    GO

    create index spt_reqitem_approvername on identityiq.spt_identity_request_item (approver_name);
    GO

    create index spt_reqitem_provisioning_state on identityiq.spt_identity_request_item (provisioning_state);
    GO

    create index spt_reqitem_ownername on identityiq.spt_identity_request_item (owner_name);
    GO

    create index spt_reqitem_instance_ci on identityiq.spt_identity_request_item (instance);
    GO

    create index spt_reqitem_comp_status on identityiq.spt_identity_request_item (compilation_status);
    GO

    create index spt_reqitem_exp_cause on identityiq.spt_identity_request_item (expansion_cause);
    GO

    create index spt_reqitem_name_ci on identityiq.spt_identity_request_item (name);
    GO

    create index spt_reqitem_value_ci on identityiq.spt_identity_request_item (value);
    GO

    create index spt_reqitem_approval_state on identityiq.spt_identity_request_item (approval_state);
    GO

    alter table identityiq.spt_identity_request_item
        add constraint FKC8ACEC1CA5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FKC8ACEC1CA5FB1B1 on identityiq.spt_identity_request_item (owner);
    GO

    alter table identityiq.spt_identity_request_item
        add constraint FKC8ACEC1C7733749D
        foreign key (identity_request_id)
        references identityiq.spt_identity_request;
    GO

    create index FKC8ACEC1C7733749D on identityiq.spt_identity_request_item (identity_request_id);
    GO

    alter table identityiq.spt_identity_role_metadata
        add constraint FK8DD1129F56651F3A
        foreign key (identity_id)
        references identityiq.spt_identity;
    GO

    create index FK8DD1129F56651F3A on identityiq.spt_identity_role_metadata (identity_id);
    GO

    alter table identityiq.spt_identity_role_metadata
        add constraint FK8DD1129F539509E7
        foreign key (role_metadata_id)
        references identityiq.spt_role_metadata;
    GO

    create index FK8DD1129F539509E7 on identityiq.spt_identity_role_metadata (role_metadata_id);
    GO

    create index spt_idsnap_id_name on identityiq.spt_identity_snapshot (identity_name);
    GO

    create index spt_identity_id on identityiq.spt_identity_snapshot (identity_id);
    GO

    alter table identityiq.spt_identity_snapshot
        add constraint FK1652D39DA5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK1652D39DA5FB1B1 on identityiq.spt_identity_snapshot (owner);
    GO

    alter table identityiq.spt_identity_snapshot
        add constraint FK1652D39D486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK1652D39D486634B7 on identityiq.spt_identity_snapshot (assigned_scope);
    GO

    alter table identityiq.spt_identity_trigger
        add constraint FKE207B8BFA5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FKE207B8BFA5FB1B1 on identityiq.spt_identity_trigger (owner);
    GO

    alter table identityiq.spt_identity_trigger
        add constraint FKE207B8BF3908AE7A
        foreign key (rule_id)
        references identityiq.spt_rule;
    GO

    create index FKE207B8BF3908AE7A on identityiq.spt_identity_trigger (rule_id);
    GO

    alter table identityiq.spt_identity_trigger
        add constraint FKE207B8BF486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FKE207B8BF486634B7 on identityiq.spt_identity_trigger (assigned_scope);
    GO

    alter table identityiq.spt_identity_workgroups
        add constraint FKFBDE3BBE457BB10C
        foreign key (workgroup)
        references identityiq.spt_identity;
    GO

    create index FKFBDE3BBE457BB10C on identityiq.spt_identity_workgroups (workgroup);
    GO

    alter table identityiq.spt_identity_workgroups
        add constraint FKFBDE3BBE56651F3A
        foreign key (identity_id)
        references identityiq.spt_identity;
    GO

    create index FKFBDE3BBE56651F3A on identityiq.spt_identity_workgroups (identity_id);
    GO

    alter table identityiq.spt_integration_config
        add constraint FK12CC3B95A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK12CC3B95A5FB1B1 on identityiq.spt_integration_config (owner);
    GO

    alter table identityiq.spt_integration_config
        add constraint FK12CC3B95486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK12CC3B95486634B7 on identityiq.spt_integration_config (assigned_scope);
    GO

    alter table identityiq.spt_integration_config
        add constraint FK12CC3B95907AB97A
        foreign key (application_id)
        references identityiq.spt_application;
    GO

    create index FK12CC3B95907AB97A on identityiq.spt_integration_config (application_id);
    GO

    alter table identityiq.spt_integration_config
        add constraint FK12CC3B95AAEC2008
        foreign key (plan_initializer)
        references identityiq.spt_rule;
    GO

    create index FK12CC3B95AAEC2008 on identityiq.spt_integration_config (plan_initializer);
    GO

    alter table identityiq.spt_integration_config
        add constraint FK12CC3B95FAA8585B
        foreign key (container_id)
        references identityiq.spt_bundle;
    GO

    create index FK12CC3B95FAA8585B on identityiq.spt_integration_config (container_id);
    GO

    alter table identityiq.spt_jasper_files
        add constraint FKE710B7C1AAD4575B
        foreign key (result)
        references identityiq.spt_jasper_result;
    GO

    create index FKE710B7C1AAD4575B on identityiq.spt_jasper_files (result);
    GO

    alter table identityiq.spt_jasper_files
        add constraint FKE710B7C12ABB3BFC
        foreign key (elt)
        references identityiq.spt_persisted_file;
    GO

    create index FKE710B7C12ABB3BFC on identityiq.spt_jasper_files (elt);
    GO

    create index handlerId on identityiq.spt_jasper_page_bucket (handler_id);
    GO

    create index bucketNumber on identityiq.spt_jasper_page_bucket (bucket_number);
    GO

    alter table identityiq.spt_jasper_page_bucket
        add constraint FKA6291364A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FKA6291364A5FB1B1 on identityiq.spt_jasper_page_bucket (owner);
    GO

    alter table identityiq.spt_jasper_page_bucket
        add constraint FKA6291364486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FKA6291364486634B7 on identityiq.spt_jasper_page_bucket (assigned_scope);
    GO

    alter table identityiq.spt_jasper_result
        add constraint FKF4B7413A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FKF4B7413A5FB1B1 on identityiq.spt_jasper_result (owner);
    GO

    alter table identityiq.spt_jasper_result
        add constraint FKF4B7413486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FKF4B7413486634B7 on identityiq.spt_jasper_result (assigned_scope);
    GO

    alter table identityiq.spt_jasper_template
        add constraint FK2F7D52F0A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK2F7D52F0A5FB1B1 on identityiq.spt_jasper_template (owner);
    GO

    alter table identityiq.spt_jasper_template
        add constraint FK2F7D52F0486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK2F7D52F0486634B7 on identityiq.spt_jasper_template (assigned_scope);
    GO

    create index spt_link_key1_ci on identityiq.spt_link (key1);
    GO

    create index spt_link_entitlements on identityiq.spt_link (entitlements);
    GO

    create index spt_link_dispname_ci on identityiq.spt_link (display_name);
    GO

    create index spt_link_extended1_ci on identityiq.spt_link (extended1);
    GO

    create index spt_link_nativeIdentity_ci on identityiq.spt_link (native_identity);
    GO

    create index spt_link_lastAggregation on identityiq.spt_link (last_target_aggregation);
    GO

    create index spt_link_lastRefresh on identityiq.spt_link (last_refresh);
    GO

    alter table identityiq.spt_link
        add constraint FK9A40A582A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK9A40A582A5FB1B1 on identityiq.spt_link (owner);
    GO

    alter table identityiq.spt_link
        add constraint FK9A40A58239D71460
        foreign key (application)
        references identityiq.spt_application;
    GO

    create index FK9A40A58239D71460 on identityiq.spt_link (application);
    GO

    alter table identityiq.spt_link
        add constraint FK9A40A58256651F3A
        foreign key (identity_id)
        references identityiq.spt_identity;
    GO

    create index FK9A40A58256651F3A on identityiq.spt_link (identity_id);
    GO

    alter table identityiq.spt_link
        add constraint FK9A40A582486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK9A40A582486634B7 on identityiq.spt_link (assigned_scope);
    GO

    create index spt_localized_attr_locale on identityiq.spt_localized_attribute (locale);
    GO

    create index spt_localized_attr_attr on identityiq.spt_localized_attribute (attribute);
    GO

    create index spt_localized_attr_targetname on identityiq.spt_localized_attribute (target_name);
    GO

    create index spt_localized_attr_targetid on identityiq.spt_localized_attribute (target_id);
    GO

    create index spt_localized_attr_name on identityiq.spt_localized_attribute (name);
    GO

    alter table identityiq.spt_localized_attribute
        add constraint FK93ADD450A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK93ADD450A5FB1B1 on identityiq.spt_localized_attribute (owner);
    GO

    alter table identityiq.spt_managed_attr_inheritance
        add constraint FK53B8B9A42C3CA9DA
        foreign key (managedattribute)
        references identityiq.spt_managed_attribute;
    GO

    create index FK53B8B9A42C3CA9DA on identityiq.spt_managed_attr_inheritance (managedattribute);
    GO

    alter table identityiq.spt_managed_attr_inheritance
        add constraint FK53B8B9A4C7A4B4AE
        foreign key (inherits_from)
        references identityiq.spt_managed_attribute;
    GO

    create index FK53B8B9A4C7A4B4AE on identityiq.spt_managed_attr_inheritance (inherits_from);
    GO

    alter table identityiq.spt_managed_attr_perms
        add constraint FKB7E473DD2C3CA9DA
        foreign key (managedattribute)
        references identityiq.spt_managed_attribute;
    GO

    create index FKB7E473DD2C3CA9DA on identityiq.spt_managed_attr_perms (managedattribute);
    GO

    alter table identityiq.spt_managed_attr_target_perms
        add constraint FK7839CDBB2C3CA9DA
        foreign key (managedattribute)
        references identityiq.spt_managed_attribute;
    GO

    create index FK7839CDBB2C3CA9DA on identityiq.spt_managed_attr_target_perms (managedattribute);
    GO

    create index spt_managed_attr_uuid_ci on identityiq.spt_managed_attribute (uuid);
    GO

    create index spt_managed_attr_last_tgt_agg on identityiq.spt_managed_attribute (last_target_aggregation);
    GO

    create index spt_ma_key3_ci on identityiq.spt_managed_attribute (key3);
    GO

    create index spt_ma_key2_ci on identityiq.spt_managed_attribute (key2);
    GO

    create index spt_managed_attr_aggregated on identityiq.spt_managed_attribute (aggregated);
    GO

    create index spt_ma_key4_ci on identityiq.spt_managed_attribute (key4);
    GO

    create index spt_managed_attr_requestable on identityiq.spt_managed_attribute (requestable);
    GO

    create index spt_managed_attr_type on identityiq.spt_managed_attribute (type);
    GO

    create index spt_managed_attr_extended2_ci on identityiq.spt_managed_attribute (extended2);
    GO

    create index spt_managed_attr_extended1_ci on identityiq.spt_managed_attribute (extended1);
    GO

    create index spt_managed_attr_value_ci on identityiq.spt_managed_attribute (value);
    GO

    create index spt_ma_key1_ci on identityiq.spt_managed_attribute (key1);
    GO

    create index spt_managed_attr_extended3_ci on identityiq.spt_managed_attribute (extended3);
    GO

    create index spt_managed_attr_dispname_ci on identityiq.spt_managed_attribute (displayable_name);
    GO

    create index spt_managed_attr_attr_ci on identityiq.spt_managed_attribute (attribute);
    GO

    alter table identityiq.spt_managed_attribute
        add constraint FKF5F14174A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FKF5F14174A5FB1B1 on identityiq.spt_managed_attribute (owner);
    GO

    alter table identityiq.spt_managed_attribute
        add constraint FKF5F1417439D71460
        foreign key (application)
        references identityiq.spt_application;
    GO

    create index FKF5F1417439D71460 on identityiq.spt_managed_attribute (application);
    GO

    alter table identityiq.spt_managed_attribute
        add constraint FKF5F14174486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FKF5F14174486634B7 on identityiq.spt_managed_attribute (assigned_scope);
    GO

    alter table identityiq.spt_message_template
        add constraint FKD78FF3AA5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FKD78FF3AA5FB1B1 on identityiq.spt_message_template (owner);
    GO

    alter table identityiq.spt_message_template
        add constraint FKD78FF3A486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FKD78FF3A486634B7 on identityiq.spt_message_template (assigned_scope);
    GO

    alter table identityiq.spt_mining_config
        add constraint FK2894D189A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK2894D189A5FB1B1 on identityiq.spt_mining_config (owner);
    GO

    alter table identityiq.spt_mining_config
        add constraint FK2894D189486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK2894D189486634B7 on identityiq.spt_mining_config (assigned_scope);
    GO

    create index spt_mitigation_policy on identityiq.spt_mitigation_expiration (policy);
    GO

    create index spt_mitigation_attr_val_ci on identityiq.spt_mitigation_expiration (attribute_value);
    GO

    create index spt_mitigation_app on identityiq.spt_mitigation_expiration (application);
    GO

    create index spt_mitigation_attr_name_ci on identityiq.spt_mitigation_expiration (attribute_name);
    GO

    create index spt_mitigation_permission on identityiq.spt_mitigation_expiration (permission);
    GO

    create index spt_mitigation_account_ci on identityiq.spt_mitigation_expiration (native_identity);
    GO

    create index spt_mitigation_role on identityiq.spt_mitigation_expiration (role_name);
    GO

    create index spt_mitigation_instance on identityiq.spt_mitigation_expiration (instance);
    GO

    alter table identityiq.spt_mitigation_expiration
        add constraint FK6C200727A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK6C200727A5FB1B1 on identityiq.spt_mitigation_expiration (owner);
    GO

    alter table identityiq.spt_mitigation_expiration
        add constraint FK6C20072756651F3A
        foreign key (identity_id)
        references identityiq.spt_identity;
    GO

    create index FK6C20072756651F3A on identityiq.spt_mitigation_expiration (identity_id);
    GO

    alter table identityiq.spt_mitigation_expiration
        add constraint FK6C200727486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK6C200727486634B7 on identityiq.spt_mitigation_expiration (assigned_scope);
    GO

    alter table identityiq.spt_mitigation_expiration
        add constraint FK6C20072771E36ACA
        foreign key (mitigator)
        references identityiq.spt_identity;
    GO

    create index FK6C20072771E36ACA on identityiq.spt_mitigation_expiration (mitigator);
    GO

    alter table identityiq.spt_monitoring_statistic
        add constraint FK9B2F43A1A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK9B2F43A1A5FB1B1 on identityiq.spt_monitoring_statistic (owner);
    GO

    alter table identityiq.spt_monitoring_statistic
        add constraint FK9B2F43A1486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK9B2F43A1486634B7 on identityiq.spt_monitoring_statistic (assigned_scope);
    GO

    alter table identityiq.spt_monitoring_statistic_tags
        add constraint FK770FC5F7E6181207
        foreign key (elt)
        references identityiq.spt_tag;
    GO

    create index FK770FC5F7E6181207 on identityiq.spt_monitoring_statistic_tags (elt);
    GO

    alter table identityiq.spt_monitoring_statistic_tags
        add constraint FK770FC5F7315E4612
        foreign key (statistic_id)
        references identityiq.spt_monitoring_statistic;
    GO

    create index FK770FC5F7315E4612 on identityiq.spt_monitoring_statistic_tags (statistic_id);
    GO

    alter table identityiq.spt_object_config
        add constraint FK92854BBAA5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK92854BBAA5FB1B1 on identityiq.spt_object_config (owner);
    GO

    alter table identityiq.spt_object_config
        add constraint FK92854BBA486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK92854BBA486634B7 on identityiq.spt_object_config (assigned_scope);
    GO

    create index spt_partition_status on identityiq.spt_partition_result (completion_status);
    GO

    alter table identityiq.spt_partition_result
        add constraint FK9541609AA5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK9541609AA5FB1B1 on identityiq.spt_partition_result (owner);
    GO

    alter table identityiq.spt_partition_result
        add constraint FK9541609A3EE0F059
        foreign key (task_result)
        references identityiq.spt_task_result;
    GO

    create index FK9541609A3EE0F059 on identityiq.spt_partition_result (task_result);
    GO

    alter table identityiq.spt_partition_result
        add constraint FK9541609A486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK9541609A486634B7 on identityiq.spt_partition_result (assigned_scope);
    GO

    alter table identityiq.spt_password_policy
        add constraint FK479B98CEA5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK479B98CEA5FB1B1 on identityiq.spt_password_policy (owner);
    GO

    alter table identityiq.spt_password_policy_holder
        add constraint FKA7124E3DA5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FKA7124E3DA5FB1B1 on identityiq.spt_password_policy_holder (owner);
    GO

    alter table identityiq.spt_password_policy_holder
        add constraint FKA7124E3D39D71460
        foreign key (application)
        references identityiq.spt_application;
    GO

    create index FKA7124E3D39D71460 on identityiq.spt_password_policy_holder (application);
    GO

    alter table identityiq.spt_password_policy_holder
        add constraint FKA7124E3D25FBEF1F
        foreign key (policy)
        references identityiq.spt_password_policy;
    GO

    create index FKA7124E3D25FBEF1F on identityiq.spt_password_policy_holder (policy);
    GO

    alter table identityiq.spt_persisted_file
        add constraint FKCEBAA850A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FKCEBAA850A5FB1B1 on identityiq.spt_persisted_file (owner);
    GO

    alter table identityiq.spt_persisted_file
        add constraint FKCEBAA850486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FKCEBAA850486634B7 on identityiq.spt_persisted_file (assigned_scope);
    GO

    create index spt_plugin_name_ci on identityiq.spt_plugin (name);
    GO

    create index spt_plugin_dn_ci on identityiq.spt_plugin (display_name);
    GO

    alter table identityiq.spt_plugin
        add constraint FK13AE22BBF7C36E0D
        foreign key (file_id)
        references identityiq.spt_persisted_file;
    GO

    create index FK13AE22BBF7C36E0D on identityiq.spt_plugin (file_id);
    GO

    alter table identityiq.spt_policy
        add constraint FK13D458BAA5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK13D458BAA5FB1B1 on identityiq.spt_policy (owner);
    GO

    alter table identityiq.spt_policy
        add constraint FK13D458BA16E8C617
        foreign key (violation_owner)
        references identityiq.spt_identity;
    GO

    create index FK13D458BA16E8C617 on identityiq.spt_policy (violation_owner);
    GO

    alter table identityiq.spt_policy
        add constraint FK13D458BA486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK13D458BA486634B7 on identityiq.spt_policy (assigned_scope);
    GO

    alter table identityiq.spt_policy
        add constraint FK13D458BA2E02D59E
        foreign key (violation_owner_rule)
        references identityiq.spt_rule;
    GO

    create index FK13D458BA2E02D59E on identityiq.spt_policy (violation_owner_rule);
    GO

    create index spt_policy_violation_active on identityiq.spt_policy_violation (active);
    GO

    alter table identityiq.spt_policy_violation
        add constraint FK6E4413E0A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK6E4413E0A5FB1B1 on identityiq.spt_policy_violation (owner);
    GO

    alter table identityiq.spt_policy_violation
        add constraint FK6E4413E056651F3A
        foreign key (identity_id)
        references identityiq.spt_identity;
    GO

    create index FK6E4413E056651F3A on identityiq.spt_policy_violation (identity_id);
    GO

    alter table identityiq.spt_policy_violation
        add constraint FK6E4413E0486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK6E4413E0486634B7 on identityiq.spt_policy_violation (assigned_scope);
    GO

    alter table identityiq.spt_policy_violation
        add constraint FK6E4413E0BD5A5736
        foreign key (pending_workflow)
        references identityiq.spt_workflow_case;
    GO

    create index FK6E4413E0BD5A5736 on identityiq.spt_policy_violation (pending_workflow);
    GO

    create index spt_process_log_owner_name on identityiq.spt_process_log (owner_name);
    GO

    create index spt_process_log_case_id on identityiq.spt_process_log (case_id);
    GO

    create index spt_process_log_wf_case_name on identityiq.spt_process_log (workflow_case_name);
    GO

    create index spt_process_log_process_name on identityiq.spt_process_log (process_name);
    GO

    create index spt_process_log_case_status on identityiq.spt_process_log (case_status);
    GO

    create index spt_process_log_step_name on identityiq.spt_process_log (step_name);
    GO

    create index spt_process_log_approval_name on identityiq.spt_process_log (approval_name);
    GO

    alter table identityiq.spt_process_log
        add constraint FK28FB62ECA5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK28FB62ECA5FB1B1 on identityiq.spt_process_log (owner);
    GO

    alter table identityiq.spt_process_log
        add constraint FK28FB62EC486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK28FB62EC486634B7 on identityiq.spt_process_log (assigned_scope);
    GO

    alter table identityiq.spt_profile
        add constraint FK6BFE4721A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK6BFE4721A5FB1B1 on identityiq.spt_profile (owner);
    GO

    alter table identityiq.spt_profile
        add constraint FK6BFE472139D71460
        foreign key (application)
        references identityiq.spt_application;
    GO

    create index FK6BFE472139D71460 on identityiq.spt_profile (application);
    GO

    alter table identityiq.spt_profile
        add constraint FK6BFE472122D068BA
        foreign key (bundle_id)
        references identityiq.spt_bundle;
    GO

    create index FK6BFE472122D068BA on identityiq.spt_profile (bundle_id);
    GO

    alter table identityiq.spt_profile
        add constraint FK6BFE4721486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK6BFE4721486634B7 on identityiq.spt_profile (assigned_scope);
    GO

    alter table identityiq.spt_profile_constraints
        add constraint FKEFD7A218B236FD12
        foreign key (profile)
        references identityiq.spt_profile;
    GO

    create index FKEFD7A218B236FD12 on identityiq.spt_profile_constraints (profile);
    GO

    alter table identityiq.spt_profile_permissions
        add constraint FK932EF066B236FD12
        foreign key (profile)
        references identityiq.spt_profile;
    GO

    create index FK932EF066B236FD12 on identityiq.spt_profile_permissions (profile);
    GO

    create index spt_provreq_expiration on identityiq.spt_provisioning_request (expiration);
    GO

    alter table identityiq.spt_provisioning_request
        add constraint FK604114C5A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK604114C5A5FB1B1 on identityiq.spt_provisioning_request (owner);
    GO

    alter table identityiq.spt_provisioning_request
        add constraint FK604114C556651F3A
        foreign key (identity_id)
        references identityiq.spt_identity;
    GO

    create index FK604114C556651F3A on identityiq.spt_provisioning_request (identity_id);
    GO

    alter table identityiq.spt_provisioning_request
        add constraint FK604114C5486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK604114C5486634B7 on identityiq.spt_provisioning_request (assigned_scope);
    GO

    create index spt_prvtrans_name on identityiq.spt_provisioning_transaction (name);
    GO

    create index spt_prvtrans_status on identityiq.spt_provisioning_transaction (status);
    GO

    create index spt_prvtrans_iddn_ci on identityiq.spt_provisioning_transaction (identity_display_name);
    GO

    create index spt_prvtrans_src on identityiq.spt_provisioning_transaction (source);
    GO

    create index spt_prvtrans_integ_ci on identityiq.spt_provisioning_transaction (integration);
    GO

    create index spt_prvtrans_forced on identityiq.spt_provisioning_transaction (forced);
    GO

    create index spt_prvtrans_app_ci on identityiq.spt_provisioning_transaction (application_name);
    GO

    create index spt_prvtrans_adn_ci on identityiq.spt_provisioning_transaction (account_display_name);
    GO

    create index spt_prvtrans_type on identityiq.spt_provisioning_transaction (type);
    GO

    create index spt_prvtrans_idn_ci on identityiq.spt_provisioning_transaction (identity_name);
    GO

    create index spt_prvtrans_nid_ci on identityiq.spt_provisioning_transaction (native_identity);
    GO

    create index spt_prvtrans_op on identityiq.spt_provisioning_transaction (operation);
    GO

    alter table identityiq.spt_quick_link
        add constraint FKF16B9E94A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FKF16B9E94A5FB1B1 on identityiq.spt_quick_link (owner);
    GO

    alter table identityiq.spt_quick_link
        add constraint FKF16B9E94486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FKF16B9E94486634B7 on identityiq.spt_quick_link (assigned_scope);
    GO

    alter table identityiq.spt_quick_link_options
        add constraint FK8C93F7F3A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK8C93F7F3A5FB1B1 on identityiq.spt_quick_link_options (owner);
    GO

    alter table identityiq.spt_quick_link_options
        add constraint FK8C93F7F3E5B001E9
        foreign key (dynamic_scope)
        references identityiq.spt_dynamic_scope;
    GO

    create index FK8C93F7F3E5B001E9 on identityiq.spt_quick_link_options (dynamic_scope);
    GO

    alter table identityiq.spt_quick_link_options
        add constraint FK8C93F7F329E4F453
        foreign key (quick_link)
        references identityiq.spt_quick_link;
    GO

    create index FK8C93F7F329E4F453 on identityiq.spt_quick_link_options (quick_link);
    GO

    alter table identityiq.spt_remediation_item
        add constraint FK53608075A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK53608075A5FB1B1 on identityiq.spt_remediation_item (owner);
    GO

    alter table identityiq.spt_remediation_item
        add constraint FK53608075FCF09A9D
        foreign key (work_item_id)
        references identityiq.spt_work_item;
    GO

    create index FK53608075FCF09A9D on identityiq.spt_remediation_item (work_item_id);
    GO

    alter table identityiq.spt_remediation_item
        add constraint FK53608075486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK53608075486634B7 on identityiq.spt_remediation_item (assigned_scope);
    GO

    alter table identityiq.spt_remediation_item
        add constraint FK53608075EDFFCCCD
        foreign key (assignee)
        references identityiq.spt_identity;
    GO

    create index FK53608075EDFFCCCD on identityiq.spt_remediation_item (assignee);
    GO

    create index spt_remote_login_expiration on identityiq.spt_remote_login_token (expiration);
    GO

    alter table identityiq.spt_remote_login_token
        add constraint FK45BCDEB2A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK45BCDEB2A5FB1B1 on identityiq.spt_remote_login_token (owner);
    GO

    alter table identityiq.spt_remote_login_token
        add constraint FK45BCDEB2486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK45BCDEB2486634B7 on identityiq.spt_remote_login_token (assigned_scope);
    GO

    create index spt_request_compl_status on identityiq.spt_request (completion_status);
    GO

    create index spt_request_depPhase on identityiq.spt_request (dependent_phase);
    GO

    create index spt_request_expiration on identityiq.spt_request (expiration);
    GO

    create index spt_request_nextLaunch on identityiq.spt_request (next_launch);
    GO

    create index spt_request_name on identityiq.spt_request (name);
    GO

    create index spt_request_phase on identityiq.spt_request (phase);
    GO

    alter table identityiq.spt_request
        add constraint FKBFBEB007A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FKBFBEB007A5FB1B1 on identityiq.spt_request (owner);
    GO

    alter table identityiq.spt_request
        add constraint FKBFBEB0073EE0F059
        foreign key (task_result)
        references identityiq.spt_task_result;
    GO

    create index FKBFBEB0073EE0F059 on identityiq.spt_request (task_result);
    GO

    alter table identityiq.spt_request
        add constraint FKBFBEB007486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FKBFBEB007486634B7 on identityiq.spt_request (assigned_scope);
    GO

    alter table identityiq.spt_request
        add constraint FKBFBEB007307D4C55
        foreign key (definition)
        references identityiq.spt_request_definition;
    GO

    create index FKBFBEB007307D4C55 on identityiq.spt_request (definition);
    GO

    alter table identityiq.spt_request_arguments
        add constraint FK2551071EACF1AFBA
        foreign key (signature)
        references identityiq.spt_request_definition;
    GO

    create index FK2551071EACF1AFBA on identityiq.spt_request_arguments (signature);
    GO

    alter table identityiq.spt_request_definition
        add constraint FKF976608BA5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FKF976608BA5FB1B1 on identityiq.spt_request_definition (owner);
    GO

    alter table identityiq.spt_request_definition
        add constraint FKF976608B319F1FAC
        foreign key (parent)
        references identityiq.spt_request_definition;
    GO

    create index FKF976608B319F1FAC on identityiq.spt_request_definition (parent);
    GO

    alter table identityiq.spt_request_definition
        add constraint FKF976608B486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FKF976608B486634B7 on identityiq.spt_request_definition (assigned_scope);
    GO

    alter table identityiq.spt_request_definition_rights
        add constraint FKD7D17C0B77278CD9
        foreign key (request_definition_id)
        references identityiq.spt_request_definition;
    GO

    create index FKD7D17C0B77278CD9 on identityiq.spt_request_definition_rights (request_definition_id);
    GO

    alter table identityiq.spt_request_definition_rights
        add constraint FKD7D17C0BD22635BD
        foreign key (right_id)
        references identityiq.spt_right;
    GO

    create index FKD7D17C0BD22635BD on identityiq.spt_request_definition_rights (right_id);
    GO

    alter table identityiq.spt_request_returns
        add constraint FK9F6C90BACF1AFBA
        foreign key (signature)
        references identityiq.spt_request_definition;
    GO

    create index FK9F6C90BACF1AFBA on identityiq.spt_request_returns (signature);
    GO

    alter table identityiq.spt_request_state
        add constraint FKDCED76591A9F1D1A
        foreign key (request_id)
        references identityiq.spt_request;
    GO

    create index FKDCED76591A9F1D1A on identityiq.spt_request_state (request_id);
    GO

    alter table identityiq.spt_resource_event
        add constraint FK37A182B139D71460
        foreign key (application)
        references identityiq.spt_application;
    GO

    create index FK37A182B139D71460 on identityiq.spt_resource_event (application);
    GO

    alter table identityiq.spt_right
        add constraint FKAE287D94A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FKAE287D94A5FB1B1 on identityiq.spt_right (owner);
    GO

    alter table identityiq.spt_right
        add constraint FKAE287D94486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FKAE287D94486634B7 on identityiq.spt_right (assigned_scope);
    GO

    alter table identityiq.spt_right_config
        add constraint FKE69E544DA5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FKE69E544DA5FB1B1 on identityiq.spt_right_config (owner);
    GO

    alter table identityiq.spt_right_config
        add constraint FKE69E544D486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FKE69E544D486634B7 on identityiq.spt_right_config (assigned_scope);
    GO

    create index role_index_cscore on identityiq.spt_role_index (composite_score);
    GO

    alter table identityiq.spt_role_index
        add constraint FKF99E0B51A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FKF99E0B51A5FB1B1 on identityiq.spt_role_index (owner);
    GO

    alter table identityiq.spt_role_index
        add constraint FKF99E0B51486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FKF99E0B51486634B7 on identityiq.spt_role_index (assigned_scope);
    GO

    alter table identityiq.spt_role_index
        add constraint FKF99E0B5128E03F44
        foreign key (bundle)
        references identityiq.spt_bundle;
    GO

    create index FKF99E0B5128E03F44 on identityiq.spt_role_index (bundle);
    GO

    alter table identityiq.spt_role_metadata
        add constraint FK1D411450A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK1D411450A5FB1B1 on identityiq.spt_role_metadata (owner);
    GO

    alter table identityiq.spt_role_metadata
        add constraint FK1D4114507B368F38
        foreign key (role)
        references identityiq.spt_bundle;
    GO

    create index FK1D4114507B368F38 on identityiq.spt_role_metadata (role);
    GO

    alter table identityiq.spt_role_metadata
        add constraint FK1D411450486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK1D411450486634B7 on identityiq.spt_role_metadata (assigned_scope);
    GO

    alter table identityiq.spt_role_mining_result
        add constraint FKF65D466BA5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FKF65D466BA5FB1B1 on identityiq.spt_role_mining_result (owner);
    GO

    alter table identityiq.spt_role_mining_result
        add constraint FKF65D466B486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FKF65D466B486634B7 on identityiq.spt_role_mining_result (assigned_scope);
    GO

    alter table identityiq.spt_role_scorecard
        add constraint FK494BABA1A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK494BABA1A5FB1B1 on identityiq.spt_role_scorecard (owner);
    GO

    alter table identityiq.spt_role_scorecard
        add constraint FK494BABA1CD12A446
        foreign key (role_id)
        references identityiq.spt_bundle;
    GO

    create index FK494BABA1CD12A446 on identityiq.spt_role_scorecard (role_id);
    GO

    alter table identityiq.spt_role_scorecard
        add constraint FK494BABA1486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK494BABA1486634B7 on identityiq.spt_role_scorecard (assigned_scope);
    GO

    alter table identityiq.spt_rule
        add constraint FK9A438C84A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK9A438C84A5FB1B1 on identityiq.spt_rule (owner);
    GO

    alter table identityiq.spt_rule
        add constraint FK9A438C84486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK9A438C84486634B7 on identityiq.spt_rule (assigned_scope);
    GO

    alter table identityiq.spt_rule_dependencies
        add constraint FKCBE251043908AE7A
        foreign key (rule_id)
        references identityiq.spt_rule;
    GO

    create index FKCBE251043908AE7A on identityiq.spt_rule_dependencies (rule_id);
    GO

    alter table identityiq.spt_rule_dependencies
        add constraint FKCBE25104DB28D887
        foreign key (dependency)
        references identityiq.spt_rule;
    GO

    create index FKCBE25104DB28D887 on identityiq.spt_rule_dependencies (dependency);
    GO

    alter table identityiq.spt_rule_registry
        add constraint FK3D19A998A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK3D19A998A5FB1B1 on identityiq.spt_rule_registry (owner);
    GO

    alter table identityiq.spt_rule_registry
        add constraint FK3D19A998486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK3D19A998486634B7 on identityiq.spt_rule_registry (assigned_scope);
    GO

    alter table identityiq.spt_rule_registry_callouts
        add constraint FKF177290A3908AE7A
        foreign key (rule_id)
        references identityiq.spt_rule;
    GO

    create index FKF177290A3908AE7A on identityiq.spt_rule_registry_callouts (rule_id);
    GO

    alter table identityiq.spt_rule_registry_callouts
        add constraint FKF177290AB7A3F533
        foreign key (rule_registry_id)
        references identityiq.spt_rule_registry;
    GO

    create index FKF177290AB7A3F533 on identityiq.spt_rule_registry_callouts (rule_registry_id);
    GO

    alter table identityiq.spt_rule_signature_arguments
        add constraint FK192036541CB79DF4
        foreign key (signature)
        references identityiq.spt_rule;
    GO

    create index FK192036541CB79DF4 on identityiq.spt_rule_signature_arguments (signature);
    GO

    alter table identityiq.spt_rule_signature_returns
        add constraint FKCF144DC11CB79DF4
        foreign key (signature)
        references identityiq.spt_rule;
    GO

    create index FKCF144DC11CB79DF4 on identityiq.spt_rule_signature_returns (signature);
    GO

    create index spt_app_attr_mod on identityiq.spt_schema_attributes (remed_mod_type);
    GO

    alter table identityiq.spt_schema_attributes
        add constraint FK95BF22DB9A312D2
        foreign key (applicationschema)
        references identityiq.spt_application_schema;
    GO

    create index FK95BF22DB9A312D2 on identityiq.spt_schema_attributes (applicationschema);
    GO

    create index scope_dirty on identityiq.spt_scope (dirty);
    GO

    create index scope_disp_name_ci on identityiq.spt_scope (display_name);
    GO

    create index scope_name_ci on identityiq.spt_scope (name);
    GO

    create index scope_path on identityiq.spt_scope (path);
    GO

    alter table identityiq.spt_scope
        add constraint FKAE33F9CCA5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FKAE33F9CCA5FB1B1 on identityiq.spt_scope (owner);
    GO

    alter table identityiq.spt_scope
        add constraint FKAE33F9CC35F348E4
        foreign key (parent_id)
        references identityiq.spt_scope;
    GO

    create index FKAE33F9CC35F348E4 on identityiq.spt_scope (parent_id);
    GO

    alter table identityiq.spt_scope
        add constraint FKAE33F9CC486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FKAE33F9CC486634B7 on identityiq.spt_scope (assigned_scope);
    GO

    alter table identityiq.spt_score_config
        add constraint FKC7BA0717A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FKC7BA0717A5FB1B1 on identityiq.spt_score_config (owner);
    GO

    alter table identityiq.spt_score_config
        add constraint FKC7BA0717486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FKC7BA0717486634B7 on identityiq.spt_score_config (assigned_scope);
    GO

    alter table identityiq.spt_score_config
        add constraint FKC7BA0717B37A9D03
        foreign key (right_config)
        references identityiq.spt_right_config;
    GO

    create index FKC7BA0717B37A9D03 on identityiq.spt_score_config (right_config);
    GO

    create index identity_scorecard_cscore on identityiq.spt_scorecard (composite_score);
    GO

    alter table identityiq.spt_scorecard
        add constraint FK2062601AA5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK2062601AA5FB1B1 on identityiq.spt_scorecard (owner);
    GO

    alter table identityiq.spt_scorecard
        add constraint FK2062601A56651F3A
        foreign key (identity_id)
        references identityiq.spt_identity;
    GO

    create index FK2062601A56651F3A on identityiq.spt_scorecard (identity_id);
    GO

    alter table identityiq.spt_scorecard
        add constraint FK2062601A486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK2062601A486634B7 on identityiq.spt_scorecard (assigned_scope);
    GO

    create index spt_server_extended1_ci on identityiq.spt_server (extended1);
    GO

    create index server_stat_snapshot on identityiq.spt_server_statistic (snapshot_name);
    GO

    alter table identityiq.spt_server_statistic
        add constraint FKD8C394DCAAD6EDC1
        foreign key (monitoring_statistic)
        references identityiq.spt_monitoring_statistic;
    GO

    create index FKD8C394DCAAD6EDC1 on identityiq.spt_server_statistic (monitoring_statistic);
    GO

    alter table identityiq.spt_server_statistic
        add constraint FKD8C394DC9755032B
        foreign key (host)
        references identityiq.spt_server;
    GO

    create index FKD8C394DC9755032B on identityiq.spt_server_statistic (host);
    GO

    alter table identityiq.spt_service_status
        add constraint FKB5E2AC44426BA8FB
        foreign key (definition)
        references identityiq.spt_service_definition;
    GO

    create index FKB5E2AC44426BA8FB on identityiq.spt_service_status (definition);
    GO

    create index spt_sign_off_history_esig on identityiq.spt_sign_off_history (electronic_sign);
    GO

    create index sign_off_history_signer_id on identityiq.spt_sign_off_history (signer_id);
    GO

    alter table identityiq.spt_sign_off_history
        add constraint FK2BDCCBCAA5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK2BDCCBCAA5FB1B1 on identityiq.spt_sign_off_history (owner);
    GO

    alter table identityiq.spt_sign_off_history
        add constraint FK2BDCCBCADB59193A
        foreign key (certification_id)
        references identityiq.spt_certification;
    GO

    create index FK2BDCCBCADB59193A on identityiq.spt_sign_off_history (certification_id);
    GO

    alter table identityiq.spt_sign_off_history
        add constraint FK2BDCCBCA486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK2BDCCBCA486634B7 on identityiq.spt_sign_off_history (assigned_scope);
    GO

    alter table identityiq.spt_snapshot_permissions
        add constraint FK74F58811356B4995
        foreign key (snapshot)
        references identityiq.spt_entitlement_snapshot;
    GO

    create index FK74F58811356B4995 on identityiq.spt_snapshot_permissions (snapshot);
    GO

    alter table identityiq.spt_sodconstraint
        add constraint FKDB94CDDA5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FKDB94CDDA5FB1B1 on identityiq.spt_sodconstraint (owner);
    GO

    alter table identityiq.spt_sodconstraint
        add constraint FKDB94CDD16E8C617
        foreign key (violation_owner)
        references identityiq.spt_identity;
    GO

    create index FKDB94CDD16E8C617 on identityiq.spt_sodconstraint (violation_owner);
    GO

    alter table identityiq.spt_sodconstraint
        add constraint FKDB94CDD486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FKDB94CDD486634B7 on identityiq.spt_sodconstraint (assigned_scope);
    GO

    alter table identityiq.spt_sodconstraint
        add constraint FKDB94CDD2E02D59E
        foreign key (violation_owner_rule)
        references identityiq.spt_rule;
    GO

    create index FKDB94CDD2E02D59E on identityiq.spt_sodconstraint (violation_owner_rule);
    GO

    alter table identityiq.spt_sodconstraint
        add constraint FKDB94CDD57FD28A4
        foreign key (policy)
        references identityiq.spt_policy;
    GO

    create index FKDB94CDD57FD28A4 on identityiq.spt_sodconstraint (policy);
    GO

    alter table identityiq.spt_sodconstraint_left
        add constraint FKCCC28E2952F56EF8
        foreign key (businessrole)
        references identityiq.spt_bundle;
    GO

    create index FKCCC28E2952F56EF8 on identityiq.spt_sodconstraint_left (businessrole);
    GO

    alter table identityiq.spt_sodconstraint_left
        add constraint FKCCC28E29AEB984AA
        foreign key (sodconstraint)
        references identityiq.spt_sodconstraint;
    GO

    create index FKCCC28E29AEB984AA on identityiq.spt_sodconstraint_left (sodconstraint);
    GO

    alter table identityiq.spt_sodconstraint_right
        add constraint FKCBE5983A52F56EF8
        foreign key (businessrole)
        references identityiq.spt_bundle;
    GO

    create index FKCBE5983A52F56EF8 on identityiq.spt_sodconstraint_right (businessrole);
    GO

    alter table identityiq.spt_sodconstraint_right
        add constraint FKCBE5983AAEB984AA
        foreign key (sodconstraint)
        references identityiq.spt_sodconstraint;
    GO

    create index FKCBE5983AAEB984AA on identityiq.spt_sodconstraint_right (sodconstraint);
    GO

    alter table identityiq.spt_sync_roles
        add constraint FK1F091BA128E03F44
        foreign key (bundle)
        references identityiq.spt_bundle;
    GO

    create index FK1F091BA128E03F44 on identityiq.spt_sync_roles (bundle);
    GO

    alter table identityiq.spt_sync_roles
        add constraint FK1F091BA1719E7338
        foreign key (config)
        references identityiq.spt_integration_config;
    GO

    create index FK1F091BA1719E7338 on identityiq.spt_sync_roles (config);
    GO

    create index spt_syslog_event_level on identityiq.spt_syslog_event (event_level);
    GO

    create index spt_syslog_message on identityiq.spt_syslog_event (message);
    GO

    create index spt_syslog_quickKey on identityiq.spt_syslog_event (quick_key);
    GO

    create index spt_syslog_username on identityiq.spt_syslog_event (username);
    GO

    create index spt_syslog_classname on identityiq.spt_syslog_event (classname);
    GO

    create index spt_syslog_created on identityiq.spt_syslog_event (created);
    GO

    create index spt_syslog_server on identityiq.spt_syslog_event (server);
    GO

    alter table identityiq.spt_tag
        add constraint FK891AF912A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK891AF912A5FB1B1 on identityiq.spt_tag (owner);
    GO

    alter table identityiq.spt_tag
        add constraint FK891AF912486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK891AF912486634B7 on identityiq.spt_tag (assigned_scope);
    GO

    create index spt_target_last_agg on identityiq.spt_target (last_aggregation);
    GO

    create index spt_target_extended1_ci on identityiq.spt_target (extended1);
    GO

    create index spt_target_unique_name_hash on identityiq.spt_target (unique_name_hash);
    GO

    create index spt_target_native_obj_id on identityiq.spt_target (native_object_id);
    GO

    alter table identityiq.spt_target
        add constraint FK19E52519A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK19E52519A5FB1B1 on identityiq.spt_target (owner);
    GO

    alter table identityiq.spt_target
        add constraint FK19E525195D4B587B
        foreign key (parent)
        references identityiq.spt_target;
    GO

    create index FK19E525195D4B587B on identityiq.spt_target (parent);
    GO

    alter table identityiq.spt_target
        add constraint FK19E525192F001D5
        foreign key (target_source)
        references identityiq.spt_target_source;
    GO

    create index FK19E525192F001D5 on identityiq.spt_target (target_source);
    GO

    alter table identityiq.spt_target
        add constraint FK19E5251939D71460
        foreign key (application)
        references identityiq.spt_application;
    GO

    create index FK19E5251939D71460 on identityiq.spt_target (application);
    GO

    alter table identityiq.spt_target
        add constraint FK19E52519486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK19E52519486634B7 on identityiq.spt_target (assigned_scope);
    GO

    create index spt_target_assoc_targ_name_ci on identityiq.spt_target_association (target_name);
    GO

    create index spt_target_assoc_id on identityiq.spt_target_association (object_id);
    GO

    create index spt_target_assoc_last_agg on identityiq.spt_target_association (last_aggregation);
    GO

    alter table identityiq.spt_target_association
        add constraint FK7AD6825BA5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK7AD6825BA5FB1B1 on identityiq.spt_target_association (owner);
    GO

    alter table identityiq.spt_target_association
        add constraint FK7AD6825B486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK7AD6825B486634B7 on identityiq.spt_target_association (assigned_scope);
    GO

    alter table identityiq.spt_target_association
        add constraint FK7AD6825B68039A5A
        foreign key (target_id)
        references identityiq.spt_target;
    GO

    create index FK7AD6825B68039A5A on identityiq.spt_target_association (target_id);
    GO

    alter table identityiq.spt_target_source
        add constraint FK6F50201A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK6F50201A5FB1B1 on identityiq.spt_target_source (owner);
    GO

    alter table identityiq.spt_target_source
        add constraint FK6F502014FE65998
        foreign key (creation_rule)
        references identityiq.spt_rule;
    GO

    create index FK6F502014FE65998 on identityiq.spt_target_source (creation_rule);
    GO

    alter table identityiq.spt_target_source
        add constraint FK6F50201B854BFAE
        foreign key (transformation_rule)
        references identityiq.spt_rule;
    GO

    create index FK6F50201B854BFAE on identityiq.spt_target_source (transformation_rule);
    GO

    alter table identityiq.spt_target_source
        add constraint FK6F50201486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK6F50201486634B7 on identityiq.spt_target_source (assigned_scope);
    GO

    alter table identityiq.spt_target_source
        add constraint FK6F50201BE1EE0D5
        foreign key (correlation_rule)
        references identityiq.spt_rule;
    GO

    create index FK6F50201BE1EE0D5 on identityiq.spt_target_source (correlation_rule);
    GO

    alter table identityiq.spt_target_source
        add constraint FK6F50201D9F8531C
        foreign key (refresh_rule)
        references identityiq.spt_rule;
    GO

    create index FK6F50201D9F8531C on identityiq.spt_target_source (refresh_rule);
    GO

    alter table identityiq.spt_target_sources
        add constraint FKD7AB3E9239D71460
        foreign key (application)
        references identityiq.spt_application;
    GO

    create index FKD7AB3E9239D71460 on identityiq.spt_target_sources (application);
    GO

    alter table identityiq.spt_target_sources
        add constraint FKD7AB3E9270D64BF9
        foreign key (elt)
        references identityiq.spt_target_source;
    GO

    create index FKD7AB3E9270D64BF9 on identityiq.spt_target_sources (elt);
    GO

    create index spt_task_deprecated on identityiq.spt_task_definition (deprecated);
    GO

    alter table identityiq.spt_task_definition
        add constraint FK526FE5C5A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK526FE5C5A5FB1B1 on identityiq.spt_task_definition (owner);
    GO

    alter table identityiq.spt_task_definition
        add constraint FK526FE5C5ED0E8BA2
        foreign key (parent)
        references identityiq.spt_task_definition;
    GO

    create index FK526FE5C5ED0E8BA2 on identityiq.spt_task_definition (parent);
    GO

    alter table identityiq.spt_task_definition
        add constraint FK526FE5C5486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK526FE5C5486634B7 on identityiq.spt_task_definition (assigned_scope);
    GO

    alter table identityiq.spt_task_definition
        add constraint FK526FE5C57A31ADF5
        foreign key (signoff_config)
        references identityiq.spt_work_item_config;
    GO

    create index FK526FE5C57A31ADF5 on identityiq.spt_task_definition (signoff_config);
    GO

    alter table identityiq.spt_task_definition_rights
        add constraint FKAA0C8191D22635BD
        foreign key (right_id)
        references identityiq.spt_right;
    GO

    create index FKAA0C8191D22635BD on identityiq.spt_task_definition_rights (right_id);
    GO

    alter table identityiq.spt_task_definition_rights
        add constraint FKAA0C81913B7AD545
        foreign key (task_definition_id)
        references identityiq.spt_task_definition;
    GO

    create index FKAA0C81913B7AD545 on identityiq.spt_task_definition_rights (task_definition_id);
    GO

    create index spt_task_event_phase on identityiq.spt_task_event (phase);
    GO

    alter table identityiq.spt_task_event
        add constraint FKDACBC2E8A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FKDACBC2E8A5FB1B1 on identityiq.spt_task_event (owner);
    GO

    alter table identityiq.spt_task_event
        add constraint FKDACBC2E83908AE7A
        foreign key (rule_id)
        references identityiq.spt_rule;
    GO

    create index FKDACBC2E83908AE7A on identityiq.spt_task_event (rule_id);
    GO

    alter table identityiq.spt_task_event
        add constraint FKDACBC2E83EE0F059
        foreign key (task_result)
        references identityiq.spt_task_result;
    GO

    create index FKDACBC2E83EE0F059 on identityiq.spt_task_event (task_result);
    GO

    alter table identityiq.spt_task_event
        add constraint FKDACBC2E8486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FKDACBC2E8486634B7 on identityiq.spt_task_event (assigned_scope);
    GO

    create index spt_taskres_completed on identityiq.spt_task_result (completed);
    GO

    create index spt_taskresult_schedule on identityiq.spt_task_result (schedule);
    GO

    create index spt_taskres_verified on identityiq.spt_task_result (verified);
    GO

    create index spt_taskresult_target on identityiq.spt_task_result (target_id);
    GO

    create index spt_taskres_expiration on identityiq.spt_task_result (expiration);
    GO

    create index spt_task_compl_status on identityiq.spt_task_result (completion_status);
    GO

    create index spt_taskresult_targetname_ci on identityiq.spt_task_result (target_name);
    GO

    alter table identityiq.spt_task_result
        add constraint FK93F2818FA5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK93F2818FA5FB1B1 on identityiq.spt_task_result (owner);
    GO

    alter table identityiq.spt_task_result
        add constraint FK93F2818FAAD2E472
        foreign key (report)
        references identityiq.spt_jasper_result;
    GO

    create index FK93F2818FAAD2E472 on identityiq.spt_task_result (report);
    GO

    alter table identityiq.spt_task_result
        add constraint FK93F2818F486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK93F2818F486634B7 on identityiq.spt_task_result (assigned_scope);
    GO

    alter table identityiq.spt_task_result
        add constraint FK93F2818FEBECB84B
        foreign key (definition)
        references identityiq.spt_task_definition;
    GO

    create index FK93F2818FEBECB84B on identityiq.spt_task_result (definition);
    GO

    alter table identityiq.spt_task_signature_arguments
        add constraint FK3E81365D68611BB0
        foreign key (signature)
        references identityiq.spt_task_definition;
    GO

    create index FK3E81365D68611BB0 on identityiq.spt_task_signature_arguments (signature);
    GO

    alter table identityiq.spt_task_signature_returns
        add constraint FK797BC0A68611BB0
        foreign key (signature)
        references identityiq.spt_task_definition;
    GO

    create index FK797BC0A68611BB0 on identityiq.spt_task_signature_returns (signature);
    GO

    alter table identityiq.spt_time_period
        add constraint FK49F210EBA5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK49F210EBA5FB1B1 on identityiq.spt_time_period (owner);
    GO

    alter table identityiq.spt_time_period
        add constraint FK49F210EB486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK49F210EB486634B7 on identityiq.spt_time_period (assigned_scope);
    GO

    alter table identityiq.spt_uiconfig
        add constraint FK2B1F445EA5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK2B1F445EA5FB1B1 on identityiq.spt_uiconfig (owner);
    GO

    alter table identityiq.spt_uiconfig
        add constraint FK2B1F445E486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK2B1F445E486634B7 on identityiq.spt_uiconfig (assigned_scope);
    GO

    alter table identityiq.spt_uipreferences
        add constraint FK15336F5CA5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK15336F5CA5FB1B1 on identityiq.spt_uipreferences (owner);
    GO

    alter table identityiq.spt_widget
        add constraint FK1F6E0DCCA5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK1F6E0DCCA5FB1B1 on identityiq.spt_widget (owner);
    GO

    alter table identityiq.spt_widget
        add constraint FK1F6E0DCC486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK1F6E0DCC486634B7 on identityiq.spt_widget (assigned_scope);
    GO

    create index spt_work_item_ident_req_id on identityiq.spt_work_item (identity_request_id);
    GO

    create index spt_work_item_name on identityiq.spt_work_item (name);
    GO

    create index spt_work_item_type on identityiq.spt_work_item (type);
    GO

    create index spt_work_item_target on identityiq.spt_work_item (target_id);
    GO

    alter table identityiq.spt_work_item
        add constraint FKE2716EF9A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FKE2716EF9A5FB1B1 on identityiq.spt_work_item (owner);
    GO

    alter table identityiq.spt_work_item
        add constraint FKE2716EF92D68567A
        foreign key (requester)
        references identityiq.spt_identity;
    GO

    create index FKE2716EF92D68567A on identityiq.spt_work_item (requester);
    GO

    alter table identityiq.spt_work_item
        add constraint FKE2716EF93257597F
        foreign key (workflow_case)
        references identityiq.spt_workflow_case;
    GO

    create index FKE2716EF93257597F on identityiq.spt_work_item (workflow_case);
    GO

    alter table identityiq.spt_work_item
        add constraint FKE2716EF9486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FKE2716EF9486634B7 on identityiq.spt_work_item (assigned_scope);
    GO

    alter table identityiq.spt_work_item
        add constraint FKE2716EF95D5F3DE6
        foreign key (certification_ref_id)
        references identityiq.spt_certification;
    GO

    create index FKE2716EF95D5F3DE6 on identityiq.spt_work_item (certification_ref_id);
    GO

    alter table identityiq.spt_work_item
        add constraint FKE2716EF9EDFFCCCD
        foreign key (assignee)
        references identityiq.spt_identity;
    GO

    create index FKE2716EF9EDFFCCCD on identityiq.spt_work_item (assignee);
    GO

    create index spt_item_archive_name on identityiq.spt_work_item_archive (name);
    GO

    create index spt_item_archive_assignee_ci on identityiq.spt_work_item_archive (assignee);
    GO

    create index spt_item_archive_requester_ci on identityiq.spt_work_item_archive (requester);
    GO

    create index spt_item_archive_type on identityiq.spt_work_item_archive (type);
    GO

    create index spt_item_archive_severity on identityiq.spt_work_item_archive (severity);
    GO

    create index spt_item_archive_completer on identityiq.spt_work_item_archive (completer);
    GO

    create index spt_item_archive_workItemId on identityiq.spt_work_item_archive (work_item_id);
    GO

    create index spt_item_archive_owner_ci on identityiq.spt_work_item_archive (owner_name);
    GO

    create index spt_item_archive_ident_req on identityiq.spt_work_item_archive (identity_request_id);
    GO

    create index spt_item_archive_target on identityiq.spt_work_item_archive (target_id);
    GO

    alter table identityiq.spt_work_item_archive
        add constraint FKDFABED7CA5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FKDFABED7CA5FB1B1 on identityiq.spt_work_item_archive (owner);
    GO

    alter table identityiq.spt_work_item_archive
        add constraint FKDFABED7C486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FKDFABED7C486634B7 on identityiq.spt_work_item_archive (assigned_scope);
    GO

    alter table identityiq.spt_work_item_comments
        add constraint FK5836687A4F2D4385
        foreign key (work_item)
        references identityiq.spt_work_item;
    GO

    create index FK5836687A4F2D4385 on identityiq.spt_work_item_comments (work_item);
    GO

    alter table identityiq.spt_work_item_config
        add constraint FKC86AF748A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FKC86AF748A5FB1B1 on identityiq.spt_work_item_config (owner);
    GO

    alter table identityiq.spt_work_item_config
        add constraint FKC86AF7482E3B7910
        foreign key (parent)
        references identityiq.spt_work_item_config;
    GO

    create index FKC86AF7482E3B7910 on identityiq.spt_work_item_config (parent);
    GO

    alter table identityiq.spt_work_item_config
        add constraint FKC86AF7487EAF553E
        foreign key (notification_email)
        references identityiq.spt_email_template;
    GO

    create index FKC86AF7487EAF553E on identityiq.spt_work_item_config (notification_email);
    GO

    alter table identityiq.spt_work_item_config
        add constraint FKC86AF748F36F8B85
        foreign key (reminder_email)
        references identityiq.spt_email_template;
    GO

    create index FKC86AF748F36F8B85 on identityiq.spt_work_item_config (reminder_email);
    GO

    alter table identityiq.spt_work_item_config
        add constraint FKC86AF748C98DBFA2
        foreign key (escalation_rule)
        references identityiq.spt_rule;
    GO

    create index FKC86AF748C98DBFA2 on identityiq.spt_work_item_config (escalation_rule);
    GO

    alter table identityiq.spt_work_item_config
        add constraint FKC86AF748486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FKC86AF748486634B7 on identityiq.spt_work_item_config (assigned_scope);
    GO

    alter table identityiq.spt_work_item_config
        add constraint FKC86AF74884EC4F68
        foreign key (escalation_email)
        references identityiq.spt_email_template;
    GO

    create index FKC86AF74884EC4F68 on identityiq.spt_work_item_config (escalation_email);
    GO

    alter table identityiq.spt_work_item_config
        add constraint FKC86AF748FDF11A44
        foreign key (owner_rule)
        references identityiq.spt_rule;
    GO

    create index FKC86AF748FDF11A44 on identityiq.spt_work_item_config (owner_rule);
    GO

    alter table identityiq.spt_work_item_owners
        add constraint FKDD55D82640D47AB
        foreign key (elt)
        references identityiq.spt_identity;
    GO

    create index FKDD55D82640D47AB on identityiq.spt_work_item_owners (elt);
    GO

    alter table identityiq.spt_work_item_owners
        add constraint FKDD55D82618CFF3A8
        foreign key (config)
        references identityiq.spt_work_item_config;
    GO

    create index FKDD55D82618CFF3A8 on identityiq.spt_work_item_owners (config);
    GO

    alter table identityiq.spt_workflow
        add constraint FK51A3C947A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK51A3C947A5FB1B1 on identityiq.spt_workflow (owner);
    GO

    alter table identityiq.spt_workflow
        add constraint FK51A3C947486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK51A3C947486634B7 on identityiq.spt_workflow (assigned_scope);
    GO

    create index spt_workflowcase_target on identityiq.spt_workflow_case (target_id);
    GO

    alter table identityiq.spt_workflow_case
        add constraint FKB8E31F28A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FKB8E31F28A5FB1B1 on identityiq.spt_workflow_case (owner);
    GO

    alter table identityiq.spt_workflow_case
        add constraint FKB8E31F28486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FKB8E31F28486634B7 on identityiq.spt_workflow_case (assigned_scope);
    GO

    alter table identityiq.spt_workflow_registry
        add constraint FK1C2E1835A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK1C2E1835A5FB1B1 on identityiq.spt_workflow_registry (owner);
    GO

    alter table identityiq.spt_workflow_registry
        add constraint FK1C2E1835486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK1C2E1835486634B7 on identityiq.spt_workflow_registry (assigned_scope);
    GO

    alter table identityiq.spt_workflow_rule_libraries
        add constraint FKAE96C70E6A8DCF3D
        foreign key (rule_id)
        references identityiq.spt_workflow;
    GO

    create index FKAE96C70E6A8DCF3D on identityiq.spt_workflow_rule_libraries (rule_id);
    GO

    alter table identityiq.spt_workflow_rule_libraries
        add constraint FKAE96C70EDB28D887
        foreign key (dependency)
        references identityiq.spt_rule;
    GO

    create index FKAE96C70EDB28D887 on identityiq.spt_workflow_rule_libraries (dependency);
    GO

    alter table identityiq.spt_workflow_target
        add constraint FK2999F789A5FB1B1
        foreign key (owner)
        references identityiq.spt_identity;
    GO

    create index FK2999F789A5FB1B1 on identityiq.spt_workflow_target (owner);
    GO

    alter table identityiq.spt_workflow_target
        add constraint FK2999F789486634B7
        foreign key (assigned_scope)
        references identityiq.spt_scope;
    GO

    create index FK2999F789486634B7 on identityiq.spt_workflow_target (assigned_scope);
    GO

    alter table identityiq.spt_workflow_target
        add constraint FK2999F7896B5435D9
        foreign key (workflow_case_id)
        references identityiq.spt_workflow_case;
    GO

    create index FK2999F7896B5435D9 on identityiq.spt_workflow_target (workflow_case_id);
    GO

    create index spt_managed_modified on identityiq.spt_managed_attribute (modified);
    GO

    create index spt_managed_created on identityiq.spt_managed_attribute (created);
    GO

    create index spt_managed_comp on identityiq.spt_managed_attribute (application, type, attribute, value);
    GO

    create index spt_application_created on identityiq.spt_application (created);
    GO

    create index spt_application_modified on identityiq.spt_application (modified);
    GO

    create index spt_request_completed on identityiq.spt_request (completed);
    GO

    create index spt_request_host on identityiq.spt_request (host);
    GO

    create index spt_request_launched on identityiq.spt_request (launched);
    GO

    create index spt_request_id_composite on identityiq.spt_request (completed, next_launch, launched);
    GO

    create index spt_workitem_owner_type on identityiq.spt_work_item (owner, type);
    GO

    create index spt_role_change_event_created on identityiq.spt_role_change_event (created);
    GO

    create index spt_audit_event_created on identityiq.spt_audit_event (created);
    GO

    create index spt_audit_event_targ_act_comp on identityiq.spt_audit_event (target, action);
    GO

    create index spt_ident_entit_comp_name on identityiq.spt_identity_entitlement (identity_id, name);
    GO

    create index spt_identity_entitlement_comp on identityiq.spt_identity_entitlement (identity_id, application, native_identity, instance);
    GO

    create index spt_idrequest_created on identityiq.spt_identity_request (created);
    GO

    create index spt_arch_cert_item_apps_name on identityiq.spt_arch_cert_item_apps (application_name);
    GO

    create index spt_appidcomposite on identityiq.spt_link (application, native_identity);
    GO

    create index spt_uuidcomposite on identityiq.spt_link (application, uuid);
    GO

    create index spt_task_result_host on identityiq.spt_task_result (host);
    GO

    create index spt_task_result_launcher on identityiq.spt_task_result (launcher);
    GO

    create index spt_task_result_created on identityiq.spt_task_result (created);
    GO

    create index spt_cert_item_apps_name on identityiq.spt_cert_item_applications (application_name);
    GO

    create index spt_cert_item_att_name_ci on identityiq.spt_certification_item (exception_attribute_name);
    GO

    create index spt_certification_item_tdn_ci on identityiq.spt_certification_item (target_display_name);
    GO

    create index spt_appidcompositedelobj on identityiq.spt_deleted_object (application, native_identity);
    GO

    create index spt_uuidcompositedelobj on identityiq.spt_deleted_object (application, uuid);
    GO

    create index spt_cert_entity_tdn_ci on identityiq.spt_certification_entity (target_display_name);
    GO

    create index spt_integration_conf_modified on identityiq.spt_integration_config (modified);
    GO

    create index spt_integration_conf_created on identityiq.spt_integration_config (created);
    GO

    create index spt_bundle_modified on identityiq.spt_bundle (modified);
    GO

    create index spt_bundle_created on identityiq.spt_bundle (created);
    GO

    create index SPT_IDXE5D0EE5E14FE3C13 on identityiq.spt_certification_archive (created);
    GO

    create index spt_identity_snapshot_created on identityiq.spt_identity_snapshot (created);
    GO

    create index spt_certification_certifiers on identityiq.spt_certifiers (certifier);
    GO

    create index spt_identity_modified on identityiq.spt_identity (modified);
    GO

    create index spt_identity_created on identityiq.spt_identity (created);
    GO

    create index spt_externaloidnamecomposite on identityiq.spt_identity_external_attr (object_id, attribute_name);
    GO

    create index SPT_IDX5B44307DE376B265 on identityiq.spt_link_external_attr (object_id, attribute_name);
    GO

    create index spt_externalobjectid on identityiq.spt_identity_external_attr (object_id);
    GO

    create index SPT_IDX1CE9A5A5A51C278D on identityiq.spt_link_external_attr (object_id);
    GO

    create index spt_externalnamevalcomposite on identityiq.spt_identity_external_attr (attribute_name, value);
    GO

    create index SPT_IDX6810487CF042CA64 on identityiq.spt_link_external_attr (attribute_name, value);
    GO

    create index SPT_IDXC8BAE6DCF83839CC on identityiq.spt_jasper_template (assigned_scope_path);
    GO

    create index spt_custom_assignedscopepath on identityiq.spt_custom (assigned_scope_path);
    GO

    create index SPT_IDX52403791F605046 on identityiq.spt_generic_constraint (assigned_scope_path);
    GO

    create index SPT_IDX352BB37529C8F73E on identityiq.spt_identity_archive (assigned_scope_path);
    GO

    create index SPT_IDXD9728B9EEB248FD0 on identityiq.spt_certification_group (assigned_scope_path);
    GO

    create index SPT_IDXECB4C9F64AB87280 on identityiq.spt_group_index (assigned_scope_path);
    GO

    create index SPT_IDX10AAF70777DD9EE2 on identityiq.spt_identity_dashboard (assigned_scope_path);
    GO

    create index spt_category_assignedscopepath on identityiq.spt_category (assigned_scope_path);
    GO

    create index SPT_IDXCA5C5C012C739356 on identityiq.spt_certification_delegation (assigned_scope_path);
    GO

    create index SPT_IDX892D67C7AB213062 on identityiq.spt_group_definition (assigned_scope_path);
    GO

    create index spt_right_assignedscopepath on identityiq.spt_right (assigned_scope_path);
    GO

    create index SPT_IDX6B29BC60611AFDD4 on identityiq.spt_managed_attribute (assigned_scope_path);
    GO

    create index SPT_IDXA6D194B42059DB7C on identityiq.spt_application (assigned_scope_path);
    GO

    create index SPT_IDXE2B6FD83726D2C4 on identityiq.spt_process_log (assigned_scope_path);
    GO

    create index spt_request_assignedscopepath on identityiq.spt_request (assigned_scope_path);
    GO

    create index SPT_IDX6BA77F433361865A on identityiq.spt_score_config (assigned_scope_path);
    GO

    create index SPT_IDX1647668E11063E4 on identityiq.spt_work_item_archive (assigned_scope_path);
    GO

    create index SPT_IDX2AE3D4A6385CD3E0 on identityiq.spt_message_template (assigned_scope_path);
    GO

    create index SPT_IDX749C6E992BBAE86 on identityiq.spt_dictionary_term (assigned_scope_path);
    GO

    create index SPT_IDX836C2831FD8ED7B6 on identityiq.spt_file_bucket (assigned_scope_path);
    GO

    create index SPT_IDX45D72A5E6CEE19E on identityiq.spt_work_item (assigned_scope_path);
    GO

    create index SPT_IDX9542C8399A0989C6 on identityiq.spt_bundle_archive (assigned_scope_path);
    GO

    create index SPT_IDX5BFDE38499178D1C on identityiq.spt_rule_registry (assigned_scope_path);
    GO

    create index SPT_IDXBB0D4BCC29515FAC on identityiq.spt_policy_violation (assigned_scope_path);
    GO

    create index SPT_IDXC1811197B7DE5802 on identityiq.spt_role_mining_result (assigned_scope_path);
    GO

    create index SPT_IDX5165831AA4CEA5C8 on identityiq.spt_audit_event (assigned_scope_path);
    GO

    create index spt_tag_assignedscopepath on identityiq.spt_tag (assigned_scope_path);
    GO

    create index spt_uiconfig_assignedscopepath on identityiq.spt_uiconfig (assigned_scope_path);
    GO

    create index SPT_IDX8F4ABD86AFAD1DA0 on identityiq.spt_scorecard (assigned_scope_path);
    GO

    create index SPT_IDX8DFD31878D3B3E2 on identityiq.spt_target_association (assigned_scope_path);
    GO

    create index SPT_IDX686990949D3B0B3C on identityiq.spt_activity_data_source (assigned_scope_path);
    GO

    create index SPT_IDX59D4F6CD8690EEC on identityiq.spt_certification_definition (assigned_scope_path);
    GO

    create index SPT_IDX377FCC029A032198 on identityiq.spt_identity_request (assigned_scope_path);
    GO

    create index SPT_IDXA6919D21F9F21D96 on identityiq.spt_remediation_item (assigned_scope_path);
    GO

    create index SPT_IDX608761A1BFB4BC8 on identityiq.spt_audit_config (assigned_scope_path);
    GO

    create index spt_target_assignedscopepath on identityiq.spt_target (assigned_scope_path);
    GO

    create index SPT_IDX99FA48D474C60BBC on identityiq.spt_task_event (assigned_scope_path);
    GO

    create index SPT_IDXB52E1053EF6BCC7A on identityiq.spt_correlation_config (assigned_scope_path);
    GO

    create index SPT_IDX7590C4E191BEDD16 on identityiq.spt_workflow_registry (assigned_scope_path);
    GO

    create index SPT_IDX99763E0AD76DF7A8 on identityiq.spt_alert_definition (assigned_scope_path);
    GO

    create index SPT_IDXE4B09B655AF1E31E on identityiq.spt_archived_cert_item (assigned_scope_path);
    GO

    create index SPT_IDX321B16EB1422CFAA on identityiq.spt_identity_trigger (assigned_scope_path);
    GO

    create index SPT_IDX660B15141EEE343C on identityiq.spt_workflow_case (assigned_scope_path);
    GO

    create index spt_rule_assignedscopepath on identityiq.spt_rule (assigned_scope_path);
    GO

    create index SPT_IDXECBE5C8C4B5A312C on identityiq.spt_capability (assigned_scope_path);
    GO

    create index SPT_IDXD6F31180C85EB014 on identityiq.spt_quick_link (assigned_scope_path);
    GO

    create index SPT_IDX4875A7F12BD64736 on identityiq.spt_authentication_question (assigned_scope_path);
    GO

    create index spt_link_assignedscopepath on identityiq.spt_link (assigned_scope_path);
    GO

    create index SPT_IDX8CEA0D6E33EF6770 on identityiq.spt_batch_request (assigned_scope_path);
    GO

    create index SPT_IDX34534BBBC845CD4A on identityiq.spt_task_result (assigned_scope_path);
    GO

    create index SPT_IDXDCCC1AEC8ACA85EC on identityiq.spt_certification_item (assigned_scope_path);
    GO

    create index SPT_IDXBED7A8DAA6E4E148 on identityiq.spt_configuration (assigned_scope_path);
    GO

    create index SPT_IDX5DA4B31DDBDDDB6 on identityiq.spt_activity_constraint (assigned_scope_path);
    GO

    create index SPT_IDX11035135399822BE on identityiq.spt_mining_config (assigned_scope_path);
    GO

    create index spt_scope_assignedscopepath on identityiq.spt_scope (assigned_scope_path);
    GO

    create index SPT_IDX719553AD788A55AE on identityiq.spt_target_source (assigned_scope_path);
    GO

    create index SPT_IDX1DB04E7170203436 on identityiq.spt_task_definition (assigned_scope_path);
    GO

    create index SPT_IDXCE071F89DBC06C66 on identityiq.spt_sodconstraint (assigned_scope_path);
    GO

    create index SPT_IDXC71C52111BEFE376 on identityiq.spt_account_group (assigned_scope_path);
    GO

    create index SPT_IDXDE774369778BEC26 on identityiq.spt_dashboard_layout (assigned_scope_path);
    GO

    create index SPT_IDX593FB9116D127176 on identityiq.spt_entitlement_group (assigned_scope_path);
    GO

    create index SPT_IDX7F55103C9C96248C on identityiq.spt_role_metadata (assigned_scope_path);
    GO

    create index SPT_IDXCEBEA62E59148F0 on identityiq.spt_group_factory (assigned_scope_path);
    GO

    create index SPT_IDX7EDDBC591F6A3A06 on identityiq.spt_deleted_object (assigned_scope_path);
    GO

    create index SPT_IDX1A2CF87C3B1B850C on identityiq.spt_certification_entity (assigned_scope_path);
    GO

    create index SPT_IDXFB512F02CB48A798 on identityiq.spt_certification_challenge (assigned_scope_path);
    GO

    create index SPT_IDXABF0D041BEBD0BD6 on identityiq.spt_integration_config (assigned_scope_path);
    GO

    create index SPT_IDXAEACA8FDA84AB44E on identityiq.spt_role_index (assigned_scope_path);
    GO

    create index SPT_IDXF70D54D58BC80EE on identityiq.spt_role_scorecard (assigned_scope_path);
    GO

    create index spt_widget_assignedscopepath on identityiq.spt_widget (assigned_scope_path);
    GO

    create index SPT_IDXCB6BC61E1128A4D0 on identityiq.spt_remote_login_token (assigned_scope_path);
    GO

    create index spt_form_assignedscopepath on identityiq.spt_form (assigned_scope_path);
    GO

    create index SPT_IDXA367F317D4A97B02 on identityiq.spt_application_scorecard (assigned_scope_path);
    GO

    create index SPT_IDX2D52EC448BE739C on identityiq.spt_dashboard_reference (assigned_scope_path);
    GO

    create index SPT_IDX54AF7352EE4EEBE on identityiq.spt_workflow_target (assigned_scope_path);
    GO

    create index SPT_IDXA5EE253FB5399952 on identityiq.spt_jasper_result (assigned_scope_path);
    GO

    create index SPT_IDXC439D3638206900 on identityiq.spt_sign_off_history (assigned_scope_path);
    GO

    create index SPT_IDX6200CF1CF3199A4C on identityiq.spt_batch_request_item (assigned_scope_path);
    GO

    create index SPT_IDXDD339B534953A27A on identityiq.spt_mitigation_expiration (assigned_scope_path);
    GO

    create index SPT_IDX9D89C40FB709EAF2 on identityiq.spt_certification_action (assigned_scope_path);
    GO

    create index SPT_IDXBAE32AF9A1817F46 on identityiq.spt_right_config (assigned_scope_path);
    GO

    create index spt_workflow_assignedscopepath on identityiq.spt_workflow (assigned_scope_path);
    GO

    create index SPT_IDXF89E6D4D93CDB0EE on identityiq.spt_monitoring_statistic (assigned_scope_path);
    GO

    create index spt_profile_assignedscopepath on identityiq.spt_profile (assigned_scope_path);
    GO

    create index spt_bundle_assignedscopepath on identityiq.spt_bundle (assigned_scope_path);
    GO

    create index SPT_IDX823D9A61B16AE816 on identityiq.spt_certification_archive (assigned_scope_path);
    GO

    create index SPT_IDXB1547649C7A749E6 on identityiq.spt_identity_snapshot (assigned_scope_path);
    GO

    create index SPT_IDXBAF33EB59EE05DBE on identityiq.spt_archived_cert_entity (assigned_scope_path);
    GO

    create index SPT_IDXFF9A9E0694DBFEA0 on identityiq.spt_partition_result (assigned_scope_path);
    GO

    create index SPT_IDX133BD716174D236 on identityiq.spt_provisioning_request (assigned_scope_path);
    GO

    create index SPT_IDX50B36EB8F7F2C884 on identityiq.spt_dynamic_scope (assigned_scope_path);
    GO

    create index SPT_IDX95FDCE46C5917DC on identityiq.spt_application_schema (assigned_scope_path);
    GO

    create index SPT_IDX85C023B24A735CF8 on identityiq.spt_dashboard_content (assigned_scope_path);
    GO

    create index SPT_IDX52AF250AB5405B4 on identityiq.spt_jasper_page_bucket (assigned_scope_path);
    GO

    create index SPT_IDX1E683C17685A4D02 on identityiq.spt_time_period (assigned_scope_path);
    GO

    create index SPT_IDX90929F9EDF01B7D0 on identityiq.spt_certification (assigned_scope_path);
    GO

    create index SPT_IDXEA8F35F17CF0E336 on identityiq.spt_email_template (assigned_scope_path);
    GO

    create index spt_identity_assignedscopepath on identityiq.spt_identity (assigned_scope_path);
    GO

    create index SPT_IDXA511A43C73CC4C8C on identityiq.spt_persisted_file (assigned_scope_path);
    GO

    create index SPT_IDX9393E3B78D0A4442 on identityiq.spt_request_definition (assigned_scope_path);
    GO

    create index SPT_IDXB999253482041C7C on identityiq.spt_work_item_config (assigned_scope_path);
    GO

    create index SPT_IDXD9D9048A81D024A8 on identityiq.spt_dictionary (assigned_scope_path);
    GO

    create index SPT_IDX6F2601261AB4CE0 on identityiq.spt_object_config (assigned_scope_path);
    GO

    create index spt_policy_assignedscopepath on identityiq.spt_policy (assigned_scope_path);
    GO

    create table identityiq.spt_syslog_event_sequence ( next_val numeric(19,0) );
    GO

    insert into identityiq.spt_syslog_event_sequence values ( 1 );
    GO

    create table identityiq.spt_identity_request_sequence ( next_val numeric(19,0) );
    GO

    insert into identityiq.spt_identity_request_sequence values ( 1 );
    GO

    create table identityiq.spt_work_item_sequence ( next_val numeric(19,0) );
    GO

    insert into identityiq.spt_work_item_sequence values ( 1 );
    GO

    create table identityiq.spt_alert_sequence ( next_val numeric(19,0) );
    GO

    insert into identityiq.spt_alert_sequence values ( 1 );
    GO

    create table identityiq.spt_prv_trans_sequence ( next_val numeric(19,0) );
    GO

    insert into identityiq.spt_prv_trans_sequence values ( 1 );
    GO
