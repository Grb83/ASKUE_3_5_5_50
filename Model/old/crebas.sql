/*==============================================================*/
/* Database name:  Model_2                                      */
/* DBMS name:      ORACLE Version 7                             */
/* Created on:     04.01.2006 10:23:31                          */
/*==============================================================*/


/*==============================================================*/
/* Table: UPDTC_CHANNELS                                        */
/*==============================================================*/

create table UPDTC_CHANNELS (
   QID                  NUMBER                          not null,
   CHAN                 NUMBER                          not null,
   constraint UPDTC_CHANNELS_PK primary key (QID, CHAN)
)
/


/*==============================================================*/
/* Index: UPDTC_CHANNELS_PK                                     */
/*==============================================================*/
create unique index UPDTC_CHANNELS_PK
on UPDTC_CHANNELS (
   CHAN ASC,
   QID ASC
)
/


/*==============================================================*/
/* Table: UPDTC_MAP                                             */
/*==============================================================*/

create table UPDTC_MAP (
   OBJ_ID               NUMBER                          not null,
   CHAN                 NUMBER                          not null,
   NAME                 VARCHAR2(100),
   MEASURE              NUMBER,
   SID                  NUMBER,
   constraint UPDTC_MAP_PK primary key (CHAN)
)
/


/*==============================================================*/
/* Index: UPDTC_MAP_PK                                          */
/*==============================================================*/
create unique index UPDTC_MAP_PK
on UPDTC_MAP (
   CHAN ASC
)
/


/*==============================================================*/
/* Table: UPDTC_QUERIES                                         */
/*==============================================================*/

create table UPDTC_QUERIES (
   QID                  NUMBER                          not null,
   OBJ_ID               NUMBER                          not null,
   PAR_ID               NUMBER                          not null,
   SDATE                CHAR(19)                        not null,
   LDATE                CHAR(19)                        not null,
   FRACT                NUMBER,
   INT_CNT              NUMBER                          not null,
   CHAN_CNT             NUMBER                          not null,
   TZ_CNT               NUMBER                          not null,
   INFLAGS              NUMBER,
   OUTFLAGS             NUMBER,
   LIFETIME             NUMBER                          not null,
   TTL                  NUMBER                          not null,
   PRIO                 NUMBER                          not null,
   D1                   CHAR(19),
   D2                   CHAR(19),
   D3                   CHAR(19),
   constraint UPDTC_QUERIES_PK primary key (QID)
)
/


/*==============================================================*/
/* Index: UPDTC_QUERIES_PK                                      */
/*==============================================================*/
create unique index UPDTC_QUERIES_PK
on UPDTC_QUERIES (
   QID ASC
)
/


/*==============================================================*/
/* Table: UPDTC_RESULTS                                         */
/*==============================================================*/

create table UPDTC_RESULTS (
   QID                  NUMBER                          not null,
   CHAN                 NUMBER                          not null,
   TZ                   NUMBER                          not null,
   ORD                  NUMBER                          not null,
   VALUE                NUMBER,
   RC                   NUMBER,
   PAR_ID               NUMBER                          not null,
   CVALUE               VARCHAR2(100),
   TS                   CHAR(19),
   constraint UPDTC_RESULTS_PK primary key (QID, CHAN, TZ, ORD, PAR_ID)
)
/


/*==============================================================*/
/* Index: UPDTC_RESULTS_PK                                      */
/*==============================================================*/
create unique index UPDTC_RESULTS_PK
on UPDTC_RESULTS (
   QID ASC,
   CHAN ASC,
   ORD ASC,
   TZ ASC,
   PAR_ID ASC
)
/


/*==============================================================*/
/* Table: UPDTC_SRVS                                            */
/*==============================================================*/

create table UPDTC_SRVS (
   OBJ_ID               NUMBER                          not null,
   ADDRESS              CHAR(16)                        not null,
   PORT                 NUMBER                          not null,
   ISUSED               NUMBER(1),
   NAME                 VARCHAR2(100),
   SID                  NUMBER,
   constraint UPDTC_SRVS_PK primary key (OBJ_ID)
)
/


/*==============================================================*/
/* Index: UPDTC_SRVS_PK                                         */
/*==============================================================*/
create unique index UPDTC_SRVS_PK
on UPDTC_SRVS (
   OBJ_ID ASC
)
/


/*==============================================================*/
/* Table: UPDTC_ZONES                                           */
/*==============================================================*/

create table UPDTC_ZONES (
   QID                  NUMBER                          not null,
   TZ                   NUMBER                          not null,
   constraint UPDTC_ZONES_PK primary key (QID, TZ)
)
/


/*==============================================================*/
/* Index: UPDTC_ZONES_PK                                        */
/*==============================================================*/
create unique index UPDTC_ZONES_PK
on UPDTC_ZONES (
   TZ ASC,
   QID ASC
)
/


/*==============================================================*/
/* Table: UPDT_CHANNELS                                         */
/*==============================================================*/

create table UPDT_CHANNELS (
   QID                  NUMBER                          not null,
   CHAN                 NUMBER                          not null,
   constraint UPDT_CHANNELS_PK primary key (QID, CHAN)
)
/


/*==============================================================*/
/* Index: UPDT_CHANNELS_PK                                      */
/*==============================================================*/
create unique index UPDT_CHANNELS_PK
on UPDT_CHANNELS (
   QID ASC,
   CHAN ASC
)
/


/*==============================================================*/
/* Table: UPDT_FRACTIONS                                        */
/*==============================================================*/

create table UPDT_FRACTIONS (
   FRACT                NUMBER                          not null,
   NAME                 VARCHAR2(100),
   constraint UPDT_FRACT_PK primary key (FRACT)
)
/


/*==============================================================*/
/* Index: UPDT_FRACT_PK                                         */
/*==============================================================*/
create unique index UPDT_FRACT_PK
on UPDT_FRACTIONS (
   FRACT ASC
)
/


/*==============================================================*/
/* Table: UPDT_MAP                                              */
/*==============================================================*/

create table UPDT_MAP (
   CHAN                 NUMBER                          not null,
   ID                   NUMBER                          not null,
   MEASURE              NUMBER                          not null,
   constraint UPDT_MAP_PK primary key (CHAN)
)
/


/*==============================================================*/
/* Index: UPDT_MAP_PK                                           */
/*==============================================================*/
create unique index UPDT_MAP_PK
on UPDT_MAP (
   CHAN ASC
)
/


/*==============================================================*/
/* Table: UPDT_PARAMETERS                                       */
/*==============================================================*/

create table UPDT_PARAMETERS (
   PAR_ID               NUMBER                          not null,
   NAME                 VARCHAR2(100),
   constraint UPDT_PARAM_PK primary key (PAR_ID)
)
/


/*==============================================================*/
/* Index: UPDT_PARAM_PK                                         */
/*==============================================================*/
create unique index UPDT_PARAM_PK
on UPDT_PARAMETERS (
   PAR_ID ASC
)
/


/*==============================================================*/
/* Table: UPDT_QUERIES                                          */
/*==============================================================*/

create table UPDT_QUERIES (
   QID                  NUMBER                          not null,
   GROUP_ID             NUMBER,
   PAR_ID               NUMBER                          not null,
   SDATE                CHAR(19)                        not null,
   LDATE                CHAR(19)                        not null,
   FRACT                NUMBER,
   INT_CNT              NUMBER                          not null,
   CHAN_CNT             NUMBER                          not null,
   TZ_CNT               NUMBER                          not null,
   INFLAGS              NUMBER,
   OUTFLAGS             NUMBER,
   constraint UPDT_QUERIES_PK primary key (QID)
)
/


/*==============================================================*/
/* Index: UPDT_QUERIES_PK                                       */
/*==============================================================*/
create unique index UPDT_QUERIES_PK
on UPDT_QUERIES (
   QID ASC
)
/


/*==============================================================*/
/* Table: UPDT_RESULTS                                          */
/*==============================================================*/

create table UPDT_RESULTS (
   QID                  NUMBER                          not null,
   CHAN                 NUMBER                          not null,
   TZ                   NUMBER                          not null,
   ORD                  NUMBER                          not null,
   VALUE                NUMBER,
   RC                   NUMBER,
   PAR_ID               NUMBER                          not null,
   CVALUE               VARCHAR2(100),
   constraint UPDT_RESULTS_PK primary key (QID, CHAN, PAR_ID)
)
/


/*==============================================================*/
/* Index: UPDT_RESULTS_PK                                       */
/*==============================================================*/
create unique index UPDT_RESULTS_PK
on UPDT_RESULTS (
   PAR_ID ASC,
   CHAN ASC,
   QID ASC
)
/


/*==============================================================*/
/* Table: UPDT_SUBSCRIBERS                                      */
/*==============================================================*/

create table UPDT_SUBSCRIBERS (
   GROUP_ID             NUMBER                          not null,
   ADDRESS              CHAR(16)                        not null,
   PORT                 NUMBER                          not null,
   constraint UPDT_SUBSCRIBERS_PK primary key (GROUP_ID)
)
/


/*==============================================================*/
/* Index: UPDT_SUBSCRIBERS_PK                                   */
/*==============================================================*/
create unique index UPDT_SUBSCRIBERS_PK
on UPDT_SUBSCRIBERS (
   GROUP_ID ASC
)
/


/*==============================================================*/
/* Table: UPDT_ZONES                                            */
/*==============================================================*/

create table UPDT_ZONES (
   QID                  NUMBER                          not null,
   TZ                   NUMBER                          not null,
   constraint UPDT_ZONES_PK primary key (QID, TZ)
)
/


/*==============================================================*/
/* Index: UPDT_ZONES_PK                                         */
/*==============================================================*/
create unique index UPDT_ZONES_PK
on UPDT_ZONES (
   QID ASC,
   TZ ASC
)
/


alter table UPDTC_CHANNELS
   add constraint UPDTC_CHANNELS_FK foreign key (QID)
      references UPDTC_QUERIES (QID)
      on delete cascade
/


alter table UPDTC_QUERIES
   add constraint UPDTC_QUERIES_FK1 foreign key (OBJ_ID)
      references UPDTC_SRVS (OBJ_ID)
      on delete cascade
/


alter table UPDTC_QUERIES
   add constraint UPDTC_QUERIES_FK2 foreign key (PAR_ID)
      references UPDT_PARAMETERS (PAR_ID)
      on delete cascade
/


alter table UPDTC_QUERIES
   add constraint UPDTC_QUERIES_FK3 foreign key (FRACT)
      references UPDT_FRACTIONS (FRACT)
      on delete cascade
/


alter table UPDTC_ZONES
   add constraint UPDTC_ZONES_FK foreign key (QID)
      references UPDTC_QUERIES (QID)
      on delete cascade
/


alter table UPDT_CHANNELS
   add constraint UPDT_CHANNELS_FK foreign key (QID)
      references UPDT_QUERIES (QID)
      on delete cascade
/


alter table UPDT_ZONES
   add constraint UPDT_ZONES_FK foreign key (QID)
      references UPDT_QUERIES (QID)
      on delete cascade
/


