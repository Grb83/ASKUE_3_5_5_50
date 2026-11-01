-------------------------------------------
-----*********  АСКУЭ    ************------
-------------------------------------------


--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     14.10.101  18:41
-- ============================================================

-- ============================================================
--   Table: PARAMETER
-- ============================================================
create table PARAMETER
(
    NPID          NUMBER                 not null,
    VVALUE        VARCHAR2(50)           null    ,
    VDESCRIPTION  VARCHAR2(100)          not null,
    constraint PARAMETER_PK primary key (NPID)
)
/

comment on table PARAMETER is 'Параметры системы'
/

comment on column PARAMETER.NPID is 'Идентификатор параметра'
/

comment on column PARAMETER.VVALUE is 'Значение параметра'
/

comment on column PARAMETER.VDESCRIPTION is 'Комментарий'
/

-- ============================================================
--   Table: DEPARTMENTS
-- ============================================================
create table DEPARTMENTS
(
    NDEPARTMENT  NUMBER(10)             not null,
    VNAME        VARCHAR2(128)          not null,
    NSORT        NUMBER(10)             default 99999 not null,
    constraint DEPARTMENTS_PK primary key (NDEPARTMENT)
)
/

comment on table DEPARTMENTS is 'Подразделения'
/

comment on column DEPARTMENTS.NDEPARTMENT is 'Ид подразделения'
/

comment on column DEPARTMENTS.VNAME is 'Название'
/

comment on column DEPARTMENTS.NSORT is 'Сортировка'
/


-- ============================================================
--   Index: DEPARTMENTS_IDX1
-- ============================================================
create unique index DEPARTMENTS_IDX1 on DEPARTMENTS (VNAME asc)
/



-- ============================================================
--   Table: GROUPTYPES
-- ============================================================
create table GROUPTYPES
(
    NGROUPTYPE    NUMBER(10)             not null,
    VNAME         VARCHAR2(64)           not null,
    constraint GROUPTYPES_PK primary key (NGROUPTYPE)
)
/

comment on table GROUPTYPES is 'Типы групп'
/

comment on column GROUPTYPES.NGROUPTYPE is 'Ид типа группы'
/

comment on column GROUPTYPES.VNAME is 'Название'
/


-- ============================================================
--   Index: GROUPTYPES_IDX1
-- ============================================================
create unique index GROUPTYPES_IDX1 on GROUPTYPES (VNAME asc)
/

-- ============================================================
--   Table: PROCEDURES
-- ============================================================
create table PROCEDURES
(
    NPROCEDURE    NUMBER(10)             not null,
    VPROCDURE     VARCHAR2(32)           not null,
    VNAME         VARCHAR2(128)          not null,
    NORDER        NUMBER(10)             not null,
    constraint PROCEDURES_PK primary key (NPROCEDURE)
)
/

comment on table PROCEDURES is 'Отчетные процедуры'
/

comment on column PROCEDURES.NPROCEDURE is 'Ид процедуры'
/

comment on column PROCEDURES.VPROCDURE is 'Процедура'
/

comment on column PROCEDURES.VNAME is 'Название'
/

comment on column PROCEDURES.NORDER is 'Порядок выполнения'
/


-- ============================================================
--   Index: PROCEDURES_IDX1
-- ============================================================
create unique index PROCEDURES_IDX1 on PROCEDURES (VNAME asc)
/

-- ============================================================
--   Index: PROCEDURES_IDX2
-- ============================================================
create unique index PROCEDURES_IDX2 on PROCEDURES (NORDER asc)
/

-- ============================================================
--   Table: REPORTGROUPS
-- ============================================================
create table REPORTGROUPS
(
    NREPORTGROUP  NUMBER(10)             not null,
    NPARENT       NUMBER(10)             null    ,
    VNAME         VARCHAR2(150)          not null,
    NGROUPTYPE    NUMBER(10)             null    ,
    VGROUPKIND    VARCHAR2(1)            null
        constraint CKC_VGROUPKIND_REPORTGR check (VGROUPKIND is null or (VGROUPKIND in ('G','S'))),
    NPROCEDURE    NUMBER(10)             null    ,
    NDEPARTMENT   NUMBER(10)             null    ,
    MID           NUMBER                 null    ,
    NCOEF         NUMBER                 null
        constraint CKC_NCOEF_REPORTGR check (NCOEF is null or (NCOEF between -1 and 1)),
    constraint REPORTGROUPS_PK primary key (NREPORTGROUP)
)
/

comment on table REPORTGROUPS is 'Отчетные группы'
/

comment on column REPORTGROUPS.NREPORTGROUP is 'Ид группы'
/

comment on column REPORTGROUPS.NPARENT is 'Ид родителя'
/

comment on column REPORTGROUPS.VNAME is 'Название'
/

comment on column REPORTGROUPS.NGROUPTYPE is 'Ид типа группы'
/

comment on column REPORTGROUPS.VGROUPKIND is 'Вид группы Главная или Состовляющая'
/

comment on column REPORTGROUPS.NPROCEDURE is 'Ид процедуры'
/

comment on column REPORTGROUPS.NDEPARTMENT is 'Ид подразделения'
/

comment on column REPORTGROUPS.MID is 'Ид точки'
/

comment on column REPORTGROUPS.NCOEF is 'Коэф вхождения точки'
/


-- ============================================================
--   Index: REPORTGROUPS_IDX1
-- ============================================================
create unique index REPORTGROUPS_IDX1 on REPORTGROUPS (NPARENT asc, VNAME asc)
/

-- ============================================================
--   Index: REPORTGROUPS_IDX2
-- ============================================================
create index REPORTGROUPS_IDX2 on REPORTGROUPS (NDEPARTMENT asc)
/

-- ============================================================
--   Index: REPORTGROUPS_IDX3
-- ============================================================
create index REPORTGROUPS_IDX3 on REPORTGROUPS (NPROCEDURE asc)
/

-- ============================================================
--   Index: REPORTGROUPS_IDX4
-- ============================================================
create index REPORTGROUPS_IDX4 on REPORTGROUPS (NPARENT asc)
/

-- ============================================================
--   Index: REPORTGROUPS_IDX5
-- ============================================================
create index REPORTGROUPS_IDX5 on REPORTGROUPS (NGROUPTYPE asc)
/

-- ============================================================
--   Index: REPORTGROUPS_IDX6
-- ============================================================
create index REPORTGROUPS_IDX6 on REPORTGROUPS (MID asc)
/

-- ============================================================
--   Table: REPORTS
-- ============================================================
create table REPORTS
(
    NREPORTGROUP  NUMBER(10)             not null,
    NPERIOD       NUMBER(6)              not null
        constraint CKC_NPERIOD_REPORTS check (
            (nPeriod between 190000 and 210000) and  (mod(nPeriod,100) between 1 and 12)),
    NORDER        NUMBER(10)             not null,
    VF1           VARCHAR2(2000)         null    ,
    VF2           VARCHAR2(2000)         null    ,
    VF3           VARCHAR2(2000)         null    ,
    VF4           VARCHAR2(2000)         null    ,
    VF5           VARCHAR2(2000)         null    ,
    VF6           VARCHAR2(2000)         null    ,
    VF7           VARCHAR2(2000)         null    ,
    VF8           VARCHAR2(2000)         null    ,
    VF9           VARCHAR2(2000)         null    ,
    VF10          VARCHAR2(2000)         null    ,
    VF11          VARCHAR2(2000)         null    ,
    VF12          VARCHAR2(2000)         null    ,
    constraint REPORTS_PK primary key (NREPORTGROUP, NPERIOD, NORDER)
)
/

comment on table REPORTS is 'Отчеты'
/

comment on column REPORTS.NREPORTGROUP is 'Ид группы'
/

comment on column REPORTS.NPERIOD is 'Период'
/

comment on column REPORTS.NORDER is 'Сортировка'
/

comment on column REPORTS.VF1 is 'Поле 1'
/

comment on column REPORTS.VF2 is 'Поле 2'
/

comment on column REPORTS.VF3 is 'Поле 3'
/

comment on column REPORTS.VF4 is 'Поле 4'
/

comment on column REPORTS.VF5 is 'Поле 5'
/

comment on column REPORTS.VF6 is 'Поле 6'
/

comment on column REPORTS.VF7 is 'Поле 7'
/

comment on column REPORTS.VF8 is 'Поле 8'
/

comment on column REPORTS.VF9 is 'Поле 9'
/

comment on column REPORTS.VF10 is 'Поле 10'
/

comment on column REPORTS.VF11 is 'Поле 11'
/

comment on column REPORTS.VF12 is 'Поле 12'
/


-- ============================================================
--   Table: DETTURNOVER
-- ============================================================
create table DETTURNOVER
(
    NDEPARTMENT   NUMBER(10)             not null,
    NPERIOD       NUMBER(6)              not null
        constraint CKC_NPERIOD_DETTURNO check (
            (nPeriod between 190000 and 210000) and  (mod(nPeriod,100) between 1 and 12)),
    NAMOUNTER     NUMBER(10)             null    ,
    NAMOUNTQ1     NUMBER(10)             null    ,
    NAMOUNTED     NUMBER(10)             null    ,
    NAMOUNTQ3     NUMBER(10)             null    ,
    constraint DETTURNOVER_PK primary key (NDEPARTMENT, NPERIOD)
)
/

comment on table DETTURNOVER is 'Расчет по подразделениям'
/

comment on column DETTURNOVER.NDEPARTMENT is 'Ид подразделения'
/

comment on column DETTURNOVER.NPERIOD is 'Период'
/

comment on column DETTURNOVER.NAMOUNTER is 'Расход Акт пр'
/

comment on column DETTURNOVER.NAMOUNTQ1 is 'Расход Реакт пр'
/

comment on column DETTURNOVER.NAMOUNTED is 'Расход Акт отд'
/

comment on column DETTURNOVER.NAMOUNTQ3 is 'Расход Реактив ген'
/


-- ============================================================
--   Index: DETTURNOVER_IDX1
-- ============================================================
create index DETTURNOVER_IDX1 on DETTURNOVER (NPERIOD asc)
/

alter table REPORTGROUPS
    add constraint REPORTGROUPS_F1 foreign key  (NDEPARTMENT)
       references DEPARTMENTS (NDEPARTMENT) on delete cascade
/

alter table REPORTGROUPS
    add constraint REPORTGROUPS_F2 foreign key  (NGROUPTYPE)
       references GROUPTYPES (NGROUPTYPE)
/

alter table REPORTGROUPS
    add constraint REPORTGROUPS_F3 foreign key  (NPROCEDURE)
       references PROCEDURES (NPROCEDURE)
/

alter table REPORTGROUPS
    add constraint REPORTGROUPS_F4 foreign key  (MID)
       references POINTS (MID) on delete cascade
/

alter table REPORTGROUPS
    add constraint REPORTGROUPS_F5 foreign key  (NPARENT)
       references REPORTGROUPS (NREPORTGROUP) on delete cascade
/

alter table REPORTS
    add constraint REPORTS_F1 foreign key  (NREPORTGROUP)
       references REPORTGROUPS (NREPORTGROUP) on delete cascade
/

alter table DETTURNOVER
    add constraint DETTURNOVER_F1 foreign key  (NDEPARTMENT)
       references DEPARTMENTS (NDEPARTMENT) on delete cascade
/


ALTER TABLE RYDA.PROFILE ADD
(
   ERM                        NUMBER,
   Q1M                        NUMBER,
   EDM                        NUMBER,
   Q3M                        NUMBER,
   Q2M                        NUMBER,
   Q4M                        NUMBER)
/
ALTER TABLE RYDA.HALFHOUR ADD
(
   ERM                        NUMBER,
   Q1M                        NUMBER,
   EDM                        NUMBER,
   Q3M                        NUMBER,
   Q2M                        NUMBER,
   Q4M                        NUMBER)
/
CREATE SEQUENCE REPORT_S
 INCREMENT BY  1
 START WITH  1001
 CACHE 20
/
update meters m set kc=(select kc from feeders where mid=m.mid)
/
commit
/



ALTER TABLE manual_pts ADD
(
nmonth_calc                NUMBER DEFAULT 0
)
/

-- End of DDL script for MANUAL_PTS
---------------------------------------------------------------------------
--- Создание таблицы с часами включения наружного освещения
---------------------------------------------------------------------------
CREATE TABLE ryda.manual_light_limit(
  nmonth                      NUMBER NOT NULL,
  nlimit                      NUMBER NOT NULL,
  CONSTRAINT manual_light_limit_pk PRIMARY KEY (nmonth)
 )
/
COMMENT ON TABLE ryda.manual_light_limit IS 'Часы горения наружного освещения (по месяцам)'
/
COMMENT ON COLUMN ryda.manual_light_limit.nmonth IS 'Месяц по порядку'
/
COMMENT ON COLUMN ryda.manual_light_limit.nlimit IS 'Число часов горения наружного освещения'
/

-- Вставка значений
INSERT INTO ryda.manual_light_limit (nmonth, nlimit) VALUES(1,435)
/
INSERT INTO ryda.manual_light_limit (nmonth, nlimit) VALUES(2,358)
/
INSERT INTO ryda.manual_light_limit (nmonth, nlimit) VALUES(3,347)
/
INSERT INTO ryda.manual_light_limit (nmonth, nlimit) VALUES(4,281)
/
INSERT INTO ryda.manual_light_limit (nmonth, nlimit) VALUES(5,238)
/
INSERT INTO ryda.manual_light_limit (nmonth, nlimit) VALUES(6,200)
/
INSERT INTO ryda.manual_light_limit (nmonth, nlimit) VALUES(7,218)
/
INSERT INTO ryda.manual_light_limit (nmonth, nlimit) VALUES(8,264)
/
INSERT INTO ryda.manual_light_limit (nmonth, nlimit) VALUES(9,308)
/
INSERT INTO ryda.manual_light_limit (nmonth, nlimit) VALUES(10,372)
/
INSERT INTO ryda.manual_light_limit (nmonth, nlimit) VALUES(11,402)
/
INSERT INTO ryda.manual_light_limit (nmonth, nlimit) VALUES(12,444)
/
COMMIT
/



create index GROUPS_IDX1 on GROUPS (MID asc)
/
delete from groups where gid not in (select gid from groups connect by prior gid=parent start with parent is null) and parent is not null
/
alter table GROUPS
    add constraint GROUPS_F2 foreign key  (PARENT)
       references GROUPS (GID) on delete cascade
/

create index FORM_GROUP_IDX1 on FORM_GROUP (GID asc)
/
delete from form_group where rowid not in (select max(rowid) from form_group group by fid,gid)
/
alter table FORM_GROUP
    add constraint FORM_GROUP_PK primary key (FID, GID)
/
create index FORMS_IDX1 on FORMS (PARENT asc)
/
delete from FORMS where FID not in (select FID from FORMS connect by prior FID=parent start with parent is null) and parent is not null
/
alter table FORMS
    add constraint FORMS_F1 foreign key  (PARENT)
       references FORMS (FID) on delete cascade
/










-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     11.12.101  18:02
-- ============================================================

drop table EXPORT_PROF cascade constraints
/

drop table EXPORT_HOUR cascade constraints
/

drop table EXPORT_BILL cascade constraints
/

-- ============================================================
--   Table: EXPORT_BILL
-- ============================================================
create table EXPORT_BILL
(
    MID        NUMBER                 not null,
    DATE_TIME  DATE                   not null,
    constraint EXPORT_BILL_PK primary key (MID, DATE_TIME)
)
/

comment on table EXPORT_BILL is 'Экспорт суточных'
/

comment on column EXPORT_BILL.MID is 'Ид точки'
/

comment on column EXPORT_BILL.DATE_TIME is 'Дата'
/


-- ============================================================
--   Table: EXPORT_HOUR
-- ============================================================
create table EXPORT_HOUR
(
    MID        NUMBER                 not null,
    DATE_TIME  DATE                   not null,
    constraint EXPORT_HOUR_PK primary key (MID, DATE_TIME)
)
/

comment on table EXPORT_HOUR is 'Экспорт получасовок'
/

comment on column EXPORT_HOUR.MID is 'Ид точки'
/

comment on column EXPORT_HOUR.DATE_TIME is 'Дата'
/


-- ============================================================
--   Table: EXPORT_PROF
-- ============================================================
create table EXPORT_PROF
(
    MID        NUMBER                 not null,
    DATE_TIME  DATE                   not null,
    constraint EXPORT_PROF_PK primary key (MID, DATE_TIME)
)
/

comment on table EXPORT_PROF is 'Экспорт профиля'
/

comment on column EXPORT_PROF.MID is 'Ид точки'
/

comment on column EXPORT_PROF.DATE_TIME is 'Дата'
/


alter table EXPORT_BILL
    add constraint EXPORT_BILL_REF foreign key  (MID)
       references POINTS (MID) on delete cascade
/

alter table EXPORT_HOUR
    add constraint EXPORT_HOUR_REF foreign key  (MID)
       references POINTS (MID) on delete cascade
/

alter table EXPORT_PROF
    add constraint EXPORT_PROF_REF foreign key  (MID)
       references POINTS (MID) on delete cascade
/
-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     11.12.101  18:37
-- ============================================================

drop table EXPORT_GROUPS cascade constraints
/

-- ============================================================
--   Table: EXPORT_GROUPS
-- ============================================================
create table EXPORT_GROUPS
(
    GID          NUMBER                 not null,
    PARENT       NUMBER                 null    ,
    NAME         VARCHAR2(150)          not null,
    SHORT_NAME   VARCHAR2(50)           null    ,
    MID          NUMBER                 null    ,
    INVERTED     VARCHAR2(1)            null    ,
    GROUP_TOTAL  VARCHAR2(1)            null    ,
    ISBILL       NUMBER                 null    ,
    BILLSZ       NUMBER                 null    ,
    ISHOUR       NUMBER                 null    ,
    HOURSZ       NUMBER                 null    ,
    ISPROF       NUMBER                 null    ,
    PROFSZ       NUMBER                 null    ,
    ISJOURNAL    NUMBER                 null    ,
    JOURNALSZ    NUMBER                 null    ,
    constraint EXPORT_GROUPS_PK primary key (GID)
)
/

comment on table EXPORT_GROUPS is 'Экспортирование данных'
/

comment on column EXPORT_GROUPS.GID is 'Ид группы'
/

comment on column EXPORT_GROUPS.PARENT is 'Ид родителя'
/

comment on column EXPORT_GROUPS.NAME is 'Название'
/

comment on column EXPORT_GROUPS.SHORT_NAME is 'Краткое название'
/

comment on column EXPORT_GROUPS.MID is 'Ид точки'
/

comment on column EXPORT_GROUPS.INVERTED is 'Признак инверсии'
/

comment on column EXPORT_GROUPS.GROUP_TOTAL is 'Признак суммирования'
/

comment on column EXPORT_GROUPS.ISBILL is 'Экспорт суток'
/

comment on column EXPORT_GROUPS.BILLSZ is 'Экспорт суток (размер)'
/

comment on column EXPORT_GROUPS.ISHOUR is 'Экспорт получасовок'
/

comment on column EXPORT_GROUPS.HOURSZ is 'Экспорт получасовок (размер)'
/

comment on column EXPORT_GROUPS.ISPROF is 'Экспорт профиля'
/

comment on column EXPORT_GROUPS.PROFSZ is 'Экспорт профиля (размер)'
/

comment on column EXPORT_GROUPS.ISJOURNAL is 'Экспорт журнала'
/

comment on column EXPORT_GROUPS.JOURNALSZ is 'Экспорт журнала (размер)'
/


-- ============================================================
--   Index: EXPORT_GROUPS_IDX1
-- ============================================================
create unique index EXPORT_GROUPS_IDX1 on EXPORT_GROUPS (PARENT asc, NAME asc)
/

-- ============================================================
--   Index: EXPORT_GROUPS_IDX2
-- ============================================================
create index EXPORT_GROUPS_IDX2 on EXPORT_GROUPS (MID asc)
/

alter table EXPORT_GROUPS
    add constraint EXPORT_GROUPS_F2 foreign key  (MID)
       references POINTS (MID) on delete cascade
/

alter table EXPORT_GROUPS
    add constraint EXPORT_GROUPS_F1 foreign key  (PARENT)
       references EXPORT_GROUPS (GID) on delete cascade
/

drop table EXPORT_PROF_C cascade constraints
/

drop table EXPORT_HOUR_C cascade constraints
/

drop table EXPORT_BILL_C cascade constraints
/
-- ============================================================
--   Table: LAST_EXPORT
-- ============================================================
create table LAST_EXPORT
(
    MID       NUMBER                 not null,
    BILL      DATE                   not null,
    HALFHOUR  DATE                   not null,
    PROFILE   DATE                   not null,
    MONTHS    DATE                   not null,
    constraint LAST_EXPORT_PK primary key (MID)
)
/

comment on table LAST_EXPORT is 'Последние экспортированные данные'
/

comment on column LAST_EXPORT.MID is 'Ид точки'
/

comment on column LAST_EXPORT.BILL is 'Экспорт суток'
/

comment on column LAST_EXPORT.HALFHOUR is 'Экспорт получасовок'
/

comment on column LAST_EXPORT.PROFILE is 'Экспорт профиля'
/

comment on column LAST_EXPORT.MONTHS is 'Экспорт месячных'
/


alter table LAST_EXPORT
    add constraint LAST_EXPORT_F1 foreign key  (MID)
       references POINTS (MID) on delete cascade
/





-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     03.01.2002  18:37
-- ============================================================
alter table POINTS
    drop constraint FK_POINTS_RE526633_POINTS
/

delete from points where parent>0 and parent not in (select mid from points)
/
alter table POINTS
    add constraint FK_POINTS_RE526633_POINTS foreign key  (PARENT)
       references POINTS (MID) on delete cascade
/

----28.05.2002
ALTER TABLE RYDA.feeders ADD
(
   nCRA                        NUMBER,
   nCRB                        NUMBER,
   nCRC                        NUMBER,
   nCRD                        NUMBER,
   nCDA                        NUMBER,
   nCDB                        NUMBER,
   nCDC                        NUMBER,
   nCDD                        NUMBER,
   nCQ1A                       NUMBER,
   nCQ1B                       NUMBER,
   nCQ1C                       NUMBER,
   nCQ1D                       NUMBER,
   nCQ3A                       NUMBER,
   nCQ3B                       NUMBER,
   nCQ3C                       NUMBER,
   nCQ3D                       NUMBER)
/
COMMENT ON COLUMN RYDA.feeders.nCRA IS 'Коэфф. тарифа А по активу для тарификации по режимным суткам'
/
COMMENT ON COLUMN RYDA.feeders.nCRB IS 'Коэфф. тарифа В по активу для тарификации по режимным суткам'
/
COMMENT ON COLUMN RYDA.feeders.nCRC IS 'Коэфф. тарифа С по активу для тарификации по режимным суткам'
/
COMMENT ON COLUMN RYDA.feeders.nCRD IS 'Коэфф. тарифа D по активу для тарификации по режимным суткам'
/
COMMENT ON COLUMN RYDA.feeders.nCDA IS 'Коэфф. тарифа А по ген. актива для тарификации по режимным суткам'
/
COMMENT ON COLUMN RYDA.feeders.nCDB IS 'Коэфф. тарифа В по ген. актива для тарификации по режимным суткам'
/
COMMENT ON COLUMN RYDA.feeders.nCDC IS 'Коэфф. тарифа С по ген. актива для тарификации по режимным суткам'
/
COMMENT ON COLUMN RYDA.feeders.nCDD IS 'Коэфф. тарифа D по ген. актива для тарификации по режимным суткам'
/
COMMENT ON COLUMN RYDA.feeders.nCQ1A IS 'Коэфф. тарифа А по реактиву для тарификации по режимным суткам'
/
COMMENT ON COLUMN RYDA.feeders.nCQ1B IS 'Коэфф. тарифа В по реактиву для тарификации по режимным суткам'
/
COMMENT ON COLUMN RYDA.feeders.nCQ1C IS 'Коэфф. тарифа С по реактиву для тарификации по режимным суткам'
/
COMMENT ON COLUMN RYDA.feeders.nCQ1D IS 'Коэфф. тарифа D по реактиву для тарификации по режимным суткам'
/
COMMENT ON COLUMN RYDA.feeders.nCQ3A IS 'Коэфф. тарифа А по ген. реактива для тарификации по режимным суткам'
/
COMMENT ON COLUMN RYDA.feeders.nCQ3B IS 'Коэфф. тарифа В по ген. реактива для тарификации по режимным суткам'
/
COMMENT ON COLUMN RYDA.feeders.nCQ3C IS 'Коэфф. тарифа С по ген. реактива для тарификации по режимным суткам'
/
COMMENT ON COLUMN RYDA.feeders.nCQ3D IS 'Коэфф. тарифа D по ген. реактива для тарификации по режимным суткам'
/







-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     12.07.2002  17:34
-- ============================================================

-- ============================================================
--   Table: CHANNELS
-- ============================================================
create table CHANNELS
(
    CID             NUMBER(10)             not null,
    VNAME           VARCHAR2(128)          not null,
    VNOTE           VARCHAR2(2000)         null    ,
    PROTOCOL_ID     NUMBER                 null    ,
    COM_ID          NUMBER                 null    ,
    INIT_STR        VARCHAR2(200)          null    ,
    ADDR            VARCHAR2(100)          null    ,
    CYCLE_TOUT      NUMBER                 null    ,
    RETRIES         NUMBER                 null    ,
    RETRIES_TOUT    NUMBER                 null    ,
    BLOCKING        NUMBER(1)              default 1 not null
        constraint CKC_BLOCKING_CHANNELS check (BLOCKING in (0,1)),
    CALLER_NAME     VARCHAR2(200)          null    ,
    NBILLDATA       NUMBER(1)              default 0 not null
        constraint CKC_NBILLDATA_CHANNELS check (NBILLDATA in (0,1)),
    NBILLDATADEPTH  NUMBER(10)             null    ,
    NCURRDATA       NUMBER(1)              default 0 not null
        constraint CKC_NCURRDATA_CHANNELS check (NCURRDATA in (0,1)),
    NCURRDATADEPTH  NUMBER(10)             null    ,
    NNETPARAM       NUMBER(1)              default 1 not null
        constraint CKC_NNETPARAM_CHANNELS check (NNETPARAM in (0,1)),
    NJOURNAL        NUMBER(1)              default 0 not null
        constraint CKC_NJOURNAL_CHANNELS check (NJOURNAL in (0,1)),
    DSTART          DATE                   null    ,
    DEND            DATE                   null    ,
    NDAY            NUMBER(10)             null    ,
    NPARENT         NUMBER(10)             null    ,
    IS_DEAD         DATE                   null    ,
    WAS_DEAD        DATE                   null    ,
    NREADY          NUMBER(10)             null    ,
    constraint CHANNELS_PK primary key (CID)
)
/

comment on table CHANNELS is 'КаналыNew'
/

comment on column CHANNELS.CID is 'Ид канала'
/

comment on column CHANNELS.VNAME is 'Название'
/

comment on column CHANNELS.VNOTE is 'Примечание'
/

comment on column CHANNELS.PROTOCOL_ID is 'Ид протокола'
/

comment on column CHANNELS.COM_ID is 'Ид компорта'
/

comment on column CHANNELS.INIT_STR is 'Строка инициализации'
/

comment on column CHANNELS.ADDR is 'Коммуникационый адресс'
/

comment on column CHANNELS.CYCLE_TOUT is 'Пауза между циклами'
/

comment on column CHANNELS.RETRIES is 'Кол попыток соединения'
/

comment on column CHANNELS.RETRIES_TOUT is 'Пауза между попытками'
/

comment on column CHANNELS.BLOCKING is 'Блокировка'
/

comment on column CHANNELS.CALLER_NAME is 'Название опросчика'
/

comment on column CHANNELS.NBILLDATA is 'Коммерческие'
/

comment on column CHANNELS.NBILLDATADEPTH is 'Коммерческие глубина'
/

comment on column CHANNELS.NCURRDATA is 'Текущие'
/

comment on column CHANNELS.NCURRDATADEPTH is 'Текущие глубина'
/

comment on column CHANNELS.NNETPARAM is 'Параметры сети'
/

comment on column CHANNELS.NJOURNAL is 'Журнал событий'
/

comment on column CHANNELS.DSTART is 'Начало опроса'
/

comment on column CHANNELS.DEND is 'Окончание'
/

comment on column CHANNELS.NDAY is 'День'
/

comment on column CHANNELS.NPARENT is 'Главный канал'
/

comment on column CHANNELS.IS_DEAD is 'Служебная 1'
/

comment on column CHANNELS.WAS_DEAD is 'Служебная 2'
/

comment on column CHANNELS.NREADY is 'Служебная 3'
/


-- ============================================================
--   Index: CHANNELS_IDX1
-- ============================================================
create index CHANNELS_IDX1 on CHANNELS (PROTOCOL_ID asc)
/

-- ============================================================
--   Index: CHANNELS_IDX2
-- ============================================================
create index CHANNELS_IDX2 on CHANNELS (COM_ID asc)
/

-- ============================================================
--   Index: CHANNELS_IDX3
-- ============================================================
create index CHANNELS_IDX3 on CHANNELS (NPARENT asc)
/

-- ============================================================
--   Index: CHANNELS_IDX4
-- ============================================================
create unique index CHANNELS_IDX4 on CHANNELS (VNAME asc)
/

-- ============================================================
--   Table: CHANPOINT
-- ============================================================
create table CHANPOINT
(
    MID             NUMBER                 not null,
    CID             NUMBER(10)             not null,
    constraint CHANPOINT_PK primary key (MID, CID)
)
/

comment on table CHANPOINT is 'Точки каналов'
/

comment on column CHANPOINT.MID is 'Ид точки'
/

comment on column CHANPOINT.CID is 'Ид канала'
/


-- ============================================================
--   Index: CHANPOINT_IDX1
-- ============================================================
create index CHANPOINT_IDX1 on CHANPOINT (CID asc)
/

alter table CHANNELS
    add constraint FK_CHANNELS_REF_7043_PROTOCOL foreign key  (PROTOCOL_ID)
       references PROTOCOLS (PROTOCOL_ID)
/

alter table CHANNELS
    add constraint FK_CHANNELS_REF_7046_COMPORTS foreign key  (COM_ID)
       references COMPORTS (COM_ID)
/

alter table CHANNELS
    add constraint FK_CHANNELS_REF_7049_CHANNELS foreign key  (NPARENT)
       references CHANNELS (CID)
/

alter table CHANPOINT
    add constraint CHANPOINT_F1 foreign key  (CID)
       references CHANNELS (CID) on delete cascade
/

alter table CHANPOINT
    add constraint CHANPOINT_F2 foreign key  (MID)
       references POINTS (MID) on delete cascade
/

ALTER TABLE RYDA.GROUPS ADD
(
   NGROUP                     NUMBER(10))
/

 COMMENT ON COLUMN RYDA.GROUPS.NGROUP IS
'Ид группы прома'
/

CREATE UNIQUE INDEX RYDA.GROUPS_IDX2
ON RYDA.GROUPS
 (  NGROUP
 )
/



-- Start of DDL script for POINTS
-- Generated 16-июл-02  3:38:42 pm
-- from ems-RYDA:2

-- Table POINTS

alter TABLE points add
 (
  npoint                     NUMBER(10)
 )
/

-- Comments for POINTS

COMMENT ON COLUMN points.npoint IS 'Ид точки прома'
/
-- Indexes for POINTS

CREATE UNIQUE INDEX points_idx1
 ON points
  ( npoint  )
/






---18.07.2002
ALTER TABLE RYDA.FEEDERS ADD
(
   VINFO                      VARCHAR2(256))
/
 COMMENT ON COLUMN RYDA.FEEDERS.VINFO IS
'Доп информация'
/

-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     19.07.2002  10:21
-- ============================================================


-- ============================================================
--   Table: TRAFFIC
-- ============================================================
create table TRAFFIC
(
    CID        NUMBER(10)             not null,
    DSTART     DATE                   not null,
    DEND       DATE                   null    ,
    NSEND      NUMBER                 null    ,
    NRECEIVED  NUMBER                 null    ,
    constraint TRAFFIC_PK primary key (CID, DSTART)
)
/

comment on table TRAFFIC is 'Трафик'
/

comment on column TRAFFIC.CID is 'Ид канала'
/

comment on column TRAFFIC.DSTART is 'Дата начала'
/

comment on column TRAFFIC.DEND is 'Дата окончания'
/

comment on column TRAFFIC.NSEND is 'Отпущено байт'
/

comment on column TRAFFIC.NRECEIVED is 'Получено байт'
/


alter table TRAFFIC
    add constraint TRAFFIC_F1 foreign key  (CID)
       references CHANNELS (CID) on delete cascade
/

alter table groups add(
    NLIMITCONS   NUMBER                 null    ,
    NLIMITMCAPM  NUMBER                 null    ,
    NLIMITMCAPE  NUMBER                 null
)
/
comment on column GROUPS.NLIMITCONS is 'Лимит потребления'
/

comment on column GROUPS.NLIMITMCAPM is 'Лимит мощности утро'
/

comment on column GROUPS.NLIMITMCAPE is 'Лимит мощности вечер'
/
-- ============================================================
--   Table: FEEDERS
-- ============================================================
alter table FEEDERS add
(
    POWER2       NUMBER                 null    ,
    METKC        NUMBER                 default 1
)
/

comment on column FEEDERS.POWER is 'Мощность первич кВ'
/

comment on column FEEDERS.POWER2 is 'Мощность вторич кВ'
/

comment on column FEEDERS.METKC is 'Коеф прошитый в счет'
/

-- ============================================================
--   Table: LGSTATUS
-- ============================================================
create table LGSTATUS
(
    MID        NUMBER                 not null,
    DATE_TIME  DATE                   not null,
    T          NUMBER(1)              not null
        constraint CKC_T_LGSTATUS check (T in (0,1)),
    U          NUMBER(1)              not null
        constraint CKC_U_LGSTATUS check (U in (0,1)),
    S          NUMBER(1)              not null
        constraint CKC_S_LGSTATUS check (S in (0,1)),
    M          NUMBER(1)              not null
        constraint CKC_M_LGSTATUS check (M in (0,1)),
    KT         NUMBER(1)              not null
        constraint CKC_KT_LGSTATUS check (KT in (0,1)),
    L1         NUMBER(1)              not null
        constraint CKC_L1_LGSTATUS check (L1 in (0,1)),
    L2         NUMBER(1)              not null
        constraint CKC_L2_LGSTATUS check (L2 in (0,1)),
    L3         NUMBER(1)              not null
        constraint CKC_L3_LGSTATUS check (L3 in (0,1)),
    constraint LGSTATUS_PK primary key (MID)
)
/

comment on table LGSTATUS is 'Статус счетчиков типа LG'
/

comment on column LGSTATUS.MID is 'Ид точки'
/

comment on column LGSTATUS.DATE_TIME is 'Дата'
/

comment on column LGSTATUS.T is 'Коррекция часов'
/

comment on column LGSTATUS.U is 'Пропадание питания'
/

comment on column LGSTATUS.S is 'Смена сезона'
/

comment on column LGSTATUS.M is 'Параметризация'
/

comment on column LGSTATUS.KT is 'Смена зоны'
/

comment on column LGSTATUS.L1 is 'Фаза A'
/

comment on column LGSTATUS.L2 is 'Фаза B'
/

comment on column LGSTATUS.L3 is 'Фаза C'
/


alter table LGSTATUS
    add constraint LGStatus_F1 foreign key  (MID)
       references POINTS (MID) on delete cascade
/

-- ============================================================
--   Table: CURR_POWER_ARCH
-- ============================================================
create table CURR_POWER_ARCH
(
    MID        NUMBER                 not null,
    DATE_TIME  DATE                   not null,
    ER         NUMBER                 null    ,
    Q1         NUMBER                 null    ,
    ED         NUMBER                 null    ,
    Q3         NUMBER                 null    ,
    FREQ       NUMBER                 null    ,
    COSF       NUMBER                 null    ,
    VOLT       NUMBER                 null    ,
    CURRENTO   NUMBER                 null    ,
    VOLT2      NUMBER                 null    ,
    VOLT3      NUMBER                 null    ,
    CURR2      NUMBER                 null    ,
    CURR3      NUMBER                 null    ,
    constraint CURR_POWER_ARCH_PK primary key (MID, DATE_TIME)
)
/

comment on table CURR_POWER_ARCH is 'Архив параметров сети'
/

comment on column CURR_POWER_ARCH.MID is 'Ид точки'
/

comment on column CURR_POWER_ARCH.DATE_TIME is 'Дата'
/

comment on column CURR_POWER_ARCH.ER is 'Мощность актив'
/

comment on column CURR_POWER_ARCH.Q1 is 'Мощность реактив'
/

comment on column CURR_POWER_ARCH.ED is 'Мощность актив отд'
/

comment on column CURR_POWER_ARCH.Q3 is 'Мощность реактив отд'
/

comment on column CURR_POWER_ARCH.FREQ is 'Частота'
/

comment on column CURR_POWER_ARCH.COSF is 'COSF'
/

comment on column CURR_POWER_ARCH.VOLT is 'Напряжение A'
/

comment on column CURR_POWER_ARCH.CURRENTO is 'Ток A'
/

comment on column CURR_POWER_ARCH.VOLT2 is 'Напряжение B'
/

comment on column CURR_POWER_ARCH.VOLT3 is 'Напряжение C'
/

comment on column CURR_POWER_ARCH.CURR2 is 'Ток B'
/

comment on column CURR_POWER_ARCH.CURR3 is 'Ток C'
/


-- ============================================================
--   Index: CURR_POWER_ARCH_IDX1
-- ============================================================
create index CURR_POWER_ARCH_IDX1 on CURR_POWER_ARCH (DATE_TIME asc)
/

alter table CURR_POWER_ARCH
    add constraint CURR_POWER_ARCH_F1 foreign key  (MID)
       references POINTS (MID) on delete cascade
/

alter table HALFHOUR add
(
    STATUS     NUMBER                 null
)
/

comment on column HALFHOUR.STATUS is 'Статус'
/

ALTER TABLE RYDA.PARAMETER MODIFY
(
   VVALUE                     VARCHAR2(1000))
/








-------------------26.07.2002
CREATE SEQUENCE DEPORTATION_SEQ
 INCREMENT BY  1
 START WITH  1001
/
-- ============================================================
--   Table: DEPORTPROCEDURES
-- ============================================================
create table DEPORTPROCEDURES
(
    NPROCEDURE     NUMBER(10)             not null,
    VNAME          VARCHAR2(256)          not null,
    VPROCEDURE     VARCHAR2(128)          not null,
    NPERIOD        NUMBER(10)             not null
        constraint CKC_NPERIOD_DEPORTPR check (NPERIOD in (1,2,3,4,5)),
    NSHIFT         NUMBER                 not null,
    NCYCLE         NUMBER(1)              default 0 not null
        constraint CKC_NCYCLE_DEPORTPR check (NCYCLE in (0,1)),
    NBLOCK         NUMBER(1)              default 1 not null
        constraint CKC_NBLOCK_DEPORTPR check (NBLOCK in (0,1)),
    DOLDCREATED    DATE                   null    ,
    VERROR         VARCHAR2(2000)         null    ,
    constraint DEPORTPROCEDURES_PK primary key (NPROCEDURE)
)
/

comment on table DEPORTPROCEDURES is 'Процедуры рассылки'
/

comment on column DEPORTPROCEDURES.NPROCEDURE is 'Ид процедуры'
/

comment on column DEPORTPROCEDURES.VNAME is 'Примечание'
/

comment on column DEPORTPROCEDURES.VPROCEDURE is 'Процедура'
/

comment on column DEPORTPROCEDURES.NPERIOD is 'Периодичность формирования'
/

comment on column DEPORTPROCEDURES.NSHIFT is 'Сдвиг старта формирования мин'
/

comment on column DEPORTPROCEDURES.NCYCLE is 'Выполнять невыполненые вовремя'
/

comment on column DEPORTPROCEDURES.NBLOCK is 'Блокировка'
/

comment on column DEPORTPROCEDURES.DOLDCREATED is 'Дата последнего создания'
/

comment on column DEPORTPROCEDURES.VERROR is 'Ошибка'
/


-- ============================================================
--   Index: DEPORTPROCEDURES_UNI
-- ============================================================
create unique index DEPORTPROCEDURES_UNI on DEPORTPROCEDURES (VPROCEDURE asc)
/

-- ============================================================
--   Table: DEPORTATION
-- ============================================================
create table DEPORTATION
(
    NDEPORTATION   NUMBER(10)             not null,
    VNAME          VARCHAR2(128)          not null,
    VNOTE          VARCHAR2(256)          null    ,
    NPROCEDURE     NUMBER(10)             null    ,
    NTYPE          NUMBER(10)             not null
        constraint CKC_NTYPE_DEPORTAT check (NTYPE in (0,1,2)),
    VADDRESS       VARCHAR2(2000)         not null,
    NPARENT        NUMBER(10)             null    ,
    DFROM          DATE                   null    ,
    DTILL          DATE                   null    ,
    NBLOCK         NUMBER(1)              default 1 not null
        constraint CKC_NBLOCK_DEPORTAT check (NBLOCK in (0,1)),
    NRETRIES_TOUT  NUMBER                 not null,
    NRETRIES       NUMBER(10)             not null,
    constraint DEPORTATION_PK primary key (NDEPORTATION)
)
/

comment on table DEPORTATION is 'Каналы рассылки'
/

comment on column DEPORTATION.NDEPORTATION is 'Ид канала'
/

comment on column DEPORTATION.VNAME is 'Название'
/

comment on column DEPORTATION.VNOTE is 'Примечание'
/

comment on column DEPORTATION.NPROCEDURE is 'Ид процедуры'
/

comment on column DEPORTATION.NTYPE is 'Тип отсылки'
/

comment on column DEPORTATION.VADDRESS is 'Адрес'
/

comment on column DEPORTATION.NPARENT is 'Ид основного канала'
/

comment on column DEPORTATION.DFROM is 'Отсылать с'
/

comment on column DEPORTATION.DTILL is 'Отсылать по'
/

comment on column DEPORTATION.NBLOCK is 'Блокировка'
/

comment on column DEPORTATION.NRETRIES_TOUT is 'Пауза между попытками мин'
/

comment on column DEPORTATION.NRETRIES is 'Количество попыток'
/


-- ============================================================
--   Index: DEPORTATION_UNI
-- ============================================================
create unique index DEPORTATION_UNI on DEPORTATION (VNAME asc)
/

-- ============================================================
--   Index: DEPORTATION_IDX1
-- ============================================================
create index DEPORTATION_IDX1 on DEPORTATION (NPARENT asc)
/

-- ============================================================
--   Index: DEPORTATION_IDX2
-- ============================================================
create index DEPORTATION_IDX2 on DEPORTATION (NPROCEDURE asc)
/

-- ============================================================
--   Table: DEPORTFILES
-- ============================================================
create table DEPORTFILES
(
    NDEPORTATION   NUMBER(10)             not null,
    DDATE          DATE                   not null,
    VFILE          VARCHAR2(32)           not null,
    VFILENAME      VARCHAR2(128)          null    ,
    NSTATE         NUMBER(1)              default 0 not null
        constraint CKC_NSTATE_DEPORTFI check (NSTATE in (0,1,2)),
    VERROR         VARCHAR2(2000)         null    ,
    constraint DEPORTFILES_PK primary key (NDEPORTATION, DDATE)
)
/

comment on table DEPORTFILES is 'Файлы рассылки'
/

comment on column DEPORTFILES.NDEPORTATION is 'Ид канала'
/

comment on column DEPORTFILES.DDATE is 'Дата'
/

comment on column DEPORTFILES.VFILE is 'Файл'
/

comment on column DEPORTFILES.VFILENAME is 'Название файла'
/

comment on column DEPORTFILES.NSTATE is 'Состояние'
/

comment on column DEPORTFILES.VERROR is 'Ошибка'
/


-- ============================================================
--   Index: DEPORTATIONFILES_IDX1
-- ============================================================
create index DEPORTATIONFILES_IDX1 on DEPORTFILES (NSTATE asc)
/

alter table DEPORTATION
    add constraint DEPORTATION_F1 foreign key  (NPARENT)
       references DEPORTATION (NDEPORTATION)
/

alter table DEPORTATION
    add constraint DEPORTATION_F2 foreign key  (NPROCEDURE)
       references DEPORTPROCEDURES (NPROCEDURE)
/

alter table DEPORTFILES
    add constraint DEPORTATIONFILES_F1 foreign key  (NDEPORTATION)
       references DEPORTATION (NDEPORTATION) on delete cascade
/


-- ============================================================
--   Table: JOBS
-- ============================================================
rename JOBS to JOBS_OLD
/

alter table JOBS_OLD drop constraint JOBS_PK
/

create table JOBS
(
    NJOB       NUMBER(10)             not null,
    DATE_TIME  DATE                   not null,
    ERRORTEXT  VARCHAR2(2000)         null    ,
    constraint JOBS_PK primary key (NJOB, DATE_TIME)
)
/

comment on table JOBS is 'Фоновые работы (JOB)'
/

comment on column JOBS.NJOB is 'NJOB'
/

comment on column JOBS.DATE_TIME is 'DATE_TIME'
/

comment on column JOBS.ERRORTEXT is 'ERRORTEXT'
/

insert into jobs(NJOB,DATE_TIME,ERRORTEXT)
select 1,DATE_TIME,ERRORTEXT from JOBS_OLD
/

drop table JOBS_OLD cascade constraints
/

ALTER TABLE RYDA.MAXHOURS MODIFY
(
   DATE_TIME                  NOT NULL,
   MORNING_START              NOT NULL,
   MORNING_END                NOT NULL,
   EVENING_START              NOT NULL,
   EVENING_END                NOT NULL)
/

comment on table MAXHOURS is 'Часы максимальной нагрузки'
/

comment on column MAXHOURS.MAXHOUR_ID is 'Ид'
/

comment on column MAXHOURS.DATE_TIME is 'Дата ввода в действие'
/

comment on column MAXHOURS.MORNING_START is 'Утро нач'
/

comment on column MAXHOURS.MORNING_END is 'Утро кон'
/

comment on column MAXHOURS.EVENING_START is 'Вечер нач'
/

comment on column MAXHOURS.EVENING_END is 'Вечер кон'
/



-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     01.08.2002  10:32
-- ============================================================
-- ============================================================
--   Table: GROUPLIMIT
-- ============================================================
create table GROUPLIMIT
(
    GID         NUMBER                 not null,
    DSTART      DATE                   not null,
    NLIMITCONS  NUMBER                 null    ,
    NLIMITCAPM  NUMBER                 null    ,
    NLIMITCAPE  NUMBER                 null    ,
    constraint GROUPLIMIT_PK primary key (GID, DSTART)
)
/

comment on table GROUPLIMIT is 'Лимиты групп'
/

comment on column GROUPLIMIT.GID is 'Ид группы'
/

comment on column GROUPLIMIT.DSTART is 'Дата ввода в действие'
/

comment on column GROUPLIMIT.NLIMITCONS is 'Лимит потребления кВтч'
/

comment on column GROUPLIMIT.NLIMITCAPM is 'Лимит мощности утро кВт'
/

comment on column GROUPLIMIT.NLIMITCAPE is 'Лимит мощности вечер кВт'
/

-- ============================================================
--   Index: GROUPLIMIT_IDX1
-- ============================================================
create index GROUPLIMIT_IDX1 on GROUPLIMIT (DSTART asc)
/

alter table GROUPLIMIT
    add constraint GROUPLIMIT_F1 foreign key  (GID)
       references GROUPS (GID) on delete cascade
/

-------------------------PGOK
ALTER TABLE RYDA.GROUPS drop
(
   NLIMITCONS,
   NLIMITMCAPM,
   NLIMITMCAPE)
/

-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     01.08.2002  18:31
-- ============================================================
alter table FEEDERS add
(
    NABC                NUMBER(1) default 0  not null
        constraint CKC_NABC_FEEDERS check (NABC in (0,1))
)
/

comment on column FEEDERS.NABC is 'Заземленная нейтраль'
/

alter table GROUPS add
(
    NEMERGENCYRESERVE   NUMBER                 null    ,
    NTECHNOLOGYRESERVE  NUMBER                 null
)
/

comment on column GROUPS.NEMERGENCYRESERVE is 'Аварийная бронь'
/

comment on column GROUPS.NTECHNOLOGYRESERVE is 'Технологическая бронь'
/



-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     07.08.2002  10:23
-- ============================================================
-- ============================================================
--   Table: VERSION
-- ============================================================
create table VERSION
(
    VFILENAME  VARCHAR2(64)           not null,
    NFILESIZE  NUMBER                 not null,
    VVERSION   VARCHAR2(64)           not null,
    FILEBODY   LONG RAW               not null,
    constraint VERSION_PK primary key (VFILENAME)
)
/

comment on table VERSION is 'Версия приложения'
/

comment on column VERSION.VFILENAME is 'Название файла'
/

comment on column VERSION.NFILESIZE is 'Размер файла'
/

comment on column VERSION.VVERSION is 'Версия'
/

comment on column VERSION.FILEBODY is 'Тело'
/




-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     15.08.2002  11:52
-- ============================================================
-- ============================================================
--   Table: USPD
-- ============================================================
create table USPD
(
    mid        NUMBER                 not null,
    MTRSN      VARCHAR2(20)           null    ,
    DATE_TIME  DATE                   null    ,
    MTYPE      VARCHAR2(50)           null    ,
    CANAL      NUMBER                 not null,
    VPASSWORD  VARCHAR2(128)          null    ,
    constraint USPD_PK primary key (mid)
)
/

comment on table USPD is 'УСПД'
/

comment on column USPD.mid is 'Ид УСПД'
/

comment on column USPD.MTRSN is 'Номер'
/

comment on column USPD.DATE_TIME is 'Дата установки'
/

comment on column USPD.MTYPE is 'Тип'
/

comment on column USPD.CANAL is 'Ком адрес'
/

comment on column USPD.VPASSWORD is 'Пароль'
/


-- ============================================================
--   Table: USPDMATRIX
-- ============================================================
create table USPDMATRIX
(
    mid        NUMBER                 not null,
    LID        NUMBER                 not null,
    NPOS       NUMBER(10)             not null,
    constraint USPDMATRIX_PK primary key (mid, LID)
)
/

comment on table USPDMATRIX is 'Матрица УСПД'
/

comment on column USPDMATRIX.mid is 'Ид УСПД'
/

comment on column USPDMATRIX.LID is 'Ид измерения'
/

comment on column USPDMATRIX.NPOS is 'Позиция'
/


-- ============================================================
--   Index: USPDMATRIX_IDX1
-- ============================================================
create index USPDMATRIX_IDX1 on USPDMATRIX (LID asc)
/

alter table USPD
    add constraint USPD_F1 foreign key  (mid)
       references POINTS (MID) on delete cascade
/

alter table USPDMATRIX
    add constraint USPDMATRIX_F2 foreign key  (mid)
       references USPD (mid) on delete cascade
/

alter table USPDMATRIX
    add constraint USPDMATRIX_F1 foreign key  (LID)
       references LAST_INPUT (LID) on delete cascade
/


-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     19.08.2002  12:30
-- ============================================================
alter table CHANNELS add
(
    NNOTREADCURR    NUMBER(1)      default 0  not null
        constraint CKC_NNOTREADCURR_CHANNELS check (NNOTREADCURR in (0,1))
)
/
comment on column CHANNELS.NNOTREADCURR is 'Не читать тек сутки'
/

grant select on version to askuever
/
-- Table JOURNAL

ALTER TABLE journal add
 (
  submit                     NUMBER
 )
/

COMMENT ON COLUMN journal.submit IS 'Служебный'
/




-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     05.09.2002
-- ============================================================

ALTER TABLE RYDA.CHANPOINT ADD
(
   NSKIP                      NUMBER)
/

 COMMENT ON COLUMN RYDA.CHANPOINT.NSKIP IS
'Пропускать'
/

ALTER TABLE RYDA.LAST_SAVE ADD
(
   TRIAL                      DATE)
/

 COMMENT ON COLUMN RYDA.LAST_SAVE.TRIAL IS
'Попытка'
/


-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     06.09.2002  18:24
-- ============================================================
alter table CURR_POWER add
(
    Q2         NUMBER                 null    ,
    Q4         NUMBER                 null    ,
    Q2M        NUMBER                 null    ,
    Q4M        NUMBER                 null
)
/

comment on table CURR_POWER is 'Текущие'
/

comment on column CURR_POWER.MID is 'Ид точки'
/

comment on column CURR_POWER.DATE_TIME is 'Дата'
/

comment on column CURR_POWER.OBSOLETE is 'Достоверность'
/

comment on column CURR_POWER.ER is 'Мощность А'
/

comment on column CURR_POWER.Q1 is 'Мощность Р'
/

comment on column CURR_POWER.ED is 'Мощность А отд'
/

comment on column CURR_POWER.Q3 is 'Мощность Р отд'
/

comment on column CURR_POWER.FREQ is 'Частота'
/

comment on column CURR_POWER.COSF is 'COSF'
/

comment on column CURR_POWER.VOLT is 'Напряжение A'
/

comment on column CURR_POWER.CURRENTO is 'Ток A'
/

comment on column CURR_POWER.VOLT2 is 'Напряжение B'
/

comment on column CURR_POWER.VOLT3 is 'Напряжение C'
/

comment on column CURR_POWER.CURR2 is 'Ток B'
/

comment on column CURR_POWER.CURR3 is 'Ток C'
/

comment on column CURR_POWER.ERM is 'Показания А'
/

comment on column CURR_POWER.EDM is 'Показания А отд'
/

comment on column CURR_POWER.Q1M is 'Показания Р'
/

comment on column CURR_POWER.Q3M is 'Показания Р отд'
/

comment on column CURR_POWER.Q2 is 'Мощность Р 2'
/

comment on column CURR_POWER.Q4 is 'Мощность Р 4'
/

comment on column CURR_POWER.Q2M is 'Показания Р 2'
/

comment on column CURR_POWER.Q4M is 'Показания Р 4'
/

--------- 18.09.2002
ALTER TABLE RYDA.CHANNELS
 ADD CONSTRAINT CHANNELS_F3 FOREIGN KEY (CID)
  REFERENCES RYDA.POINTS (MID) ON DELETE CASCADE
/





--------10.10.2002-----
create table EA_EVENTS
(
    mid     NUMBER                 not null,
    evdate  DATE                   not null,
    evtype  NUMBER                 not null,
    constraint EA_EVENTS_PK primary key (mid, evdate, evtype)
)
/

comment on table EA_EVENTS is 'Событие по счетчику'
/

comment on column EA_EVENTS.mid is 'Ид точки'
/

comment on column EA_EVENTS.evdate is 'Дата события'
/

comment on column EA_EVENTS.evtype is 'Тип события'
/


alter table EA_EVENTS
    add constraint ea_event_ref foreign key  (mid)
       references POINTS (MID) on delete cascade
/



-- ============================================================      PGOK 05.01.2003
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     10.10.2002  15:06
-- ============================================================
alter table FEEDERS add
(
    NCALCBILL    NUMBER(1)              default 0 not null
        constraint CKC_NCALCBILL_FEEDERS check (NCALCBILL in (0,1)),
    NCALCMONTHS  NUMBER(1)              default 0 not null
        constraint CKC_NCALCMONTHS_FEEDERS check (NCALCMONTHS in (0,1))
)
/

comment on column FEEDERS.NCALCBILL is 'Вычислять суточные'
/

comment on column FEEDERS.NCALCMONTHS is 'Вычислять месячные'
/





-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     23.10.2002  11:51
-- ============================================================


drop table DEPORTFILES cascade constraints
/

drop table DEPORTATION cascade constraints
/

drop table DEPORTPROCEDURES cascade constraints
/

-- ============================================================
--   Table: DEPORTPROCEDURES
-- ============================================================
create table DEPORTPROCEDURES
(
    NPROCEDURE     NUMBER(10)             not null,
    VNAME          VARCHAR2(256)          not null,
    VPROCEDURE     VARCHAR2(128)          not null,
    NPERIOD        NUMBER(10)             not null
        constraint CKC_NPERIOD_DEPORTPR check (NPERIOD in (1,2,3,4,5)),
    NSHIFT         NUMBER                 not null,
    constraint DEPORTPROCEDURES_PK primary key (NPROCEDURE)
)
/

comment on table DEPORTPROCEDURES is 'Процедуры рассылки'
/

comment on column DEPORTPROCEDURES.NPROCEDURE is 'Ид процедуры'
/

comment on column DEPORTPROCEDURES.VNAME is 'Примечание'
/

comment on column DEPORTPROCEDURES.VPROCEDURE is 'Процедура'
/

comment on column DEPORTPROCEDURES.NPERIOD is 'Периодичность формирования'
/

comment on column DEPORTPROCEDURES.NSHIFT is 'Сдвиг старта формирования мин'
/


-- ============================================================
--   Index: DEPORTPROCEDURES_UNI
-- ============================================================
create unique index DEPORTPROCEDURES_UNI on DEPORTPROCEDURES (VPROCEDURE asc)
/

-- ============================================================
--   Table: MAKETS
-- ============================================================
create table MAKETS
(
    NMAKET         NUMBER(10)             not null,
    NPROCEDURE     NUMBER(10)             not null,
    VNAME          VARCHAR2(128)          not null,
    VNOTE          VARCHAR2(256)          null    ,
    NBLOCK         NUMBER(1)              default 1 not null
        constraint CKC_NBLOCK_MAKETS check (NBLOCK in (0,1)),
    NCYCLE         NUMBER(1)              default 0 not null
        constraint CKC_NCYCLE_MAKETS check (NCYCLE in (0,1)),
    DOLDCREATED    DATE                   null    ,
    VERROR         VARCHAR2(2000)         null    ,
    constraint MAKETS primary key (NMAKET)
)
/

comment on table MAKETS is 'Макеты'
/

comment on column MAKETS.NMAKET is 'Ид макета'
/

comment on column MAKETS.NPROCEDURE is 'Ид процедуры'
/

comment on column MAKETS.VNAME is 'Название'
/

comment on column MAKETS.VNOTE is 'Примечание'
/

comment on column MAKETS.NBLOCK is 'Блокировка'
/

comment on column MAKETS.NCYCLE is 'Выполнять невыполненые вовремя'
/

comment on column MAKETS.DOLDCREATED is 'Дата последнего создания'
/

comment on column MAKETS.VERROR is 'Ошибка'
/


-- ============================================================
--   Index: MAKETS_IDX1
-- ============================================================
create unique index MAKETS_IDX1 on MAKETS (VNAME asc)
/

-- ============================================================
--   Index: MAKETS_IDX2
-- ============================================================
create index MAKETS_IDX2 on MAKETS (NPROCEDURE asc)
/

-- ============================================================
--   Table: MAKETGROUPS
-- ============================================================
create table MAKETGROUPS
(
    NGROUP         NUMBER(10)             not null,
    NMAKET         NUMBER(10)             not null,
    VCODE          VARCHAR2(2000)         null    ,
    VNAME          VARCHAR2(128)          not null,
    VNOTE          VARCHAR2(256)          null    ,
    constraint MAKETSGROUP_PK primary key (NGROUP)
)
/

comment on table MAKETGROUPS is 'Группы макетов'
/

comment on column MAKETGROUPS.NGROUP is 'Ид группы'
/

comment on column MAKETGROUPS.NMAKET is 'Ид макета'
/

comment on column MAKETGROUPS.VCODE is 'Код строки в макете'
/

comment on column MAKETGROUPS.VNAME is 'Название'
/

comment on column MAKETGROUPS.VNOTE is 'Примечание'
/


-- ============================================================
--   Index: MAKETGROUPS_IDX1
-- ============================================================
create unique index MAKETGROUPS_IDX1 on MAKETGROUPS (VNAME asc)
/

-- ============================================================
--   Index: MAKETGROUPS
-- ============================================================
create index MAKETGROUPS on MAKETGROUPS (NMAKET asc)
/

-- ============================================================
--   Table: DEPORTATION
-- ============================================================
create table DEPORTATION
(
    NDEPORTATION   NUMBER(10)             not null,
    VNAME          VARCHAR2(128)          not null,
    VNOTE          VARCHAR2(256)          null    ,
    NMAKET         NUMBER(10)             null    ,
    NTYPE          NUMBER(10)             not null
        constraint CKC_NTYPE_DEPORTAT check (NTYPE in (0,1,2)),
    VADDRESS       VARCHAR2(2000)         not null,
    NPARENT        NUMBER(10)             null    ,
    DFROM          DATE                   null    ,
    DTILL          DATE                   null    ,
    NBLOCK         NUMBER(1)              default 1 not null
        constraint CKC_NBLOCK_DEPORTAT check (NBLOCK in (0,1)),
    NRETRIES_TOUT  NUMBER                 not null,
    NRETRIES       NUMBER(10)             not null,
    constraint DEPORTATION_PK primary key (NDEPORTATION)
)
/

comment on table DEPORTATION is 'Каналы рассылки'
/

comment on column DEPORTATION.NDEPORTATION is 'Ид канала'
/

comment on column DEPORTATION.VNAME is 'Название'
/

comment on column DEPORTATION.VNOTE is 'Примечание'
/

comment on column DEPORTATION.NMAKET is 'Ид макета'
/

comment on column DEPORTATION.NTYPE is 'Тип отсылки'
/

comment on column DEPORTATION.VADDRESS is 'Адрес'
/

comment on column DEPORTATION.NPARENT is 'Ид основного канала'
/

comment on column DEPORTATION.DFROM is 'Отсылать с'
/

comment on column DEPORTATION.DTILL is 'Отсылать по'
/

comment on column DEPORTATION.NBLOCK is 'Блокировка'
/

comment on column DEPORTATION.NRETRIES_TOUT is 'Пауза между попытками мин'
/

comment on column DEPORTATION.NRETRIES is 'Количество попыток'
/


-- ============================================================
--   Index: DEPORTATION_UNI
-- ============================================================
create unique index DEPORTATION_UNI on DEPORTATION (VNAME asc)
/

-- ============================================================
--   Index: DEPORTATION_IDX1
-- ============================================================
create index DEPORTATION_IDX1 on DEPORTATION (NPARENT asc)
/

-- ============================================================
--   Index: DEPORTATION_IDX2
-- ============================================================
create index DEPORTATION_IDX2 on DEPORTATION (NMAKET asc)
/

-- ============================================================
--   Table: DEPORTFILES
-- ============================================================
create table DEPORTFILES
(
    NDEPORTATION   NUMBER(10)             not null,
    DDATE          DATE                   not null,
    VFILE          VARCHAR2(32)           not null,
    VFILENAME      VARCHAR2(128)          null    ,
    NSTATE         NUMBER(1)              default 0 not null
        constraint CKC_NSTATE_DEPORTFI check (NSTATE in (0,1,2)),
    VERROR         VARCHAR2(2000)         null    ,
    constraint DEPORTFILES_PK primary key (NDEPORTATION, DDATE)
)
/

comment on table DEPORTFILES is 'Файлы рассылки'
/

comment on column DEPORTFILES.NDEPORTATION is 'Ид канала'
/

comment on column DEPORTFILES.DDATE is 'Дата'
/

comment on column DEPORTFILES.VFILE is 'Файл'
/

comment on column DEPORTFILES.VFILENAME is 'Название файла'
/

comment on column DEPORTFILES.NSTATE is 'Состояние'
/

comment on column DEPORTFILES.VERROR is 'Ошибка'
/


-- ============================================================
--   Index: DEPORTATIONFILES_IDX1
-- ============================================================
create index DEPORTATIONFILES_IDX1 on DEPORTFILES (NSTATE asc)
/

-- ============================================================
--   Table: MAKETPOINTS
-- ============================================================
create table MAKETPOINTS
(
    NGROUP         NUMBER(10)             not null,
    MID            NUMBER                 not null,
    NKC            NUMBER(1)              not null,
    NTYPE          NUMBER(2)              not null
        constraint CKC_NTYPE_MAKETPOI check (NTYPE in (1,2,3,4,5,6)),
    constraint PK_MAKETPOINTS primary key (NGROUP, MID)
)
/

comment on table MAKETPOINTS is 'Точки макетов'
/

comment on column MAKETPOINTS.NGROUP is 'Ид группы'
/

comment on column MAKETPOINTS.MID is 'Ид точки'
/

comment on column MAKETPOINTS.NKC is 'Коеф вхождения'
/

comment on column MAKETPOINTS.NTYPE is 'Тип измерения'
/


-- ============================================================
--   Index: MAKETPOINTS_IDX1
-- ============================================================
create index MAKETPOINTS_IDX1 on MAKETPOINTS (MID asc)
/

alter table MAKETS
    add constraint MAKETS_F1 foreign key  (NPROCEDURE)
       references DEPORTPROCEDURES (NPROCEDURE) on delete cascade
/

alter table MAKETGROUPS
    add constraint MAKETGROUPS_F1 foreign key  (NMAKET)
       references MAKETS (NMAKET) on delete cascade
/

alter table DEPORTATION
    add constraint DEPORTATION_F1 foreign key  (NPARENT)
       references DEPORTATION (NDEPORTATION)
/

alter table DEPORTATION
    add constraint DEPORTATION_F2 foreign key  (NMAKET)
       references MAKETS (NMAKET) on delete cascade
/

alter table DEPORTFILES
    add constraint DEPORTATIONFILES_F1 foreign key  (NDEPORTATION)
       references DEPORTATION (NDEPORTATION) on delete cascade
/

alter table MAKETPOINTS
    add constraint MAKETPOINTS_F1 foreign key  (NGROUP)
       references MAKETGROUPS (NGROUP) on delete cascade
/

alter table MAKETPOINTS
    add constraint MAKETPOINTS_F2 foreign key  (MID)
       references POINTS (MID) on delete cascade
/



-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     24.10.2002  18:34
-- ============================================================
-- ============================================================
--   Table: LG_READOUT
-- ============================================================
create table LG_READOUT
(
    MID        NUMBER                 not null,
    DATE_TIME  DATE                   not null,
    VDATA      LONG                   null    ,
    constraint LG_READOUT_PK primary key (MID)
)
/

comment on table LG_READOUT is 'Файл LG'
/

comment on column LG_READOUT.MID is 'Ид точки'
/

comment on column LG_READOUT.DATE_TIME is 'Дата считывания'
/

comment on column LG_READOUT.VDATA is 'Данные считывания'
/


alter table LG_READOUT
    add constraint LG_READOUT_F1 foreign key  (MID)
       references POINTS (MID) on delete cascade
/




-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     12.11.2002  10:56
-- ============================================================
-- ============================================================
--   Table: man_inp_hhour
-- ============================================================
create table man_inp_hhour
(
    MID        NUMBER                 not null,
    DATE_TIME  DATE                   not null,
    ER         NUMBER                 null    ,
    Q1         NUMBER                 null    ,
    ED         NUMBER                 null    ,
    Q3         NUMBER                 null    ,
    Q2         NUMBER                 null    ,
    Q4         NUMBER                 null    ,
    ERM        NUMBER                 null    ,
    Q1M        NUMBER                 null    ,
    EDM        NUMBER                 null    ,
    Q3M        NUMBER                 null    ,
    Q2M        NUMBER                 null    ,
    Q4M        NUMBER                 null    ,
    constraint man_inp_hhour_PK primary key (MID)
)
/

comment on table man_inp_hhour is 'Показания индукционников'
/

comment on column man_inp_hhour.MID is 'Ид точки'
/

comment on column man_inp_hhour.DATE_TIME is 'DATE_TIME'
/

comment on column man_inp_hhour.ER is 'ER'
/

comment on column man_inp_hhour.Q1 is 'Q1'
/

comment on column man_inp_hhour.ED is 'ED'
/

comment on column man_inp_hhour.Q3 is 'Q3'
/

comment on column man_inp_hhour.Q2 is 'Q2'
/

comment on column man_inp_hhour.Q4 is 'Q4'
/

comment on column man_inp_hhour.ERM is 'ERM'
/

comment on column man_inp_hhour.Q1M is 'Q1M'
/

comment on column man_inp_hhour.EDM is 'EDM'
/

comment on column man_inp_hhour.Q3M is 'Q3M'
/

comment on column man_inp_hhour.Q2M is 'Q2M'
/

comment on column man_inp_hhour.Q4M is 'Q4M'
/


alter table man_inp_hhour
    add constraint FK_MAN_INP__REF_24505_POINTS foreign key  (MID)
       references POINTS (MID)
/



-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     12.11.2002  15:52
-- ============================================================
-- ============================================================
--   Table: LG_LOADPROF
-- ============================================================
create table LG_LOADPROF
(
    MID        NUMBER                 not null,
    DATE_TIME  DATE                   not null,
    VDATA      LONG                   null    ,
    constraint LG_LOADPROF_PK primary key (MID)
)
/

comment on table LG_LOADPROF is 'Файл ГН LG'
/

comment on column LG_LOADPROF.MID is 'Ид точки'
/

comment on column LG_LOADPROF.DATE_TIME is 'Дата считывания ГН'
/

comment on column LG_LOADPROF.VDATA is 'Данные считывания ГН'
/


alter table LG_LOADPROF
    add constraint LG_LOADPROF_F1 foreign key  (MID)
       references POINTS (MID) on delete cascade
/

CREATE SEQUENCE makets_seq MINVALUE 1 MAXVALUE 999999999999999999999999999
  INCREMENT BY 1 START WITH 1000 CACHE 20 NOORDER NOCYCLE
/

CREATE SEQUENCE maketgroups_seq MINVALUE 1 MAXVALUE 999999999999999999999999999
  INCREMENT BY 1 START WITH 1000 CACHE 20 NOORDER NOCYCLE
/

ALTER TABLE RYDA.TRAFFIC ADD
(
   DOPEN                      DATE)
/

 COMMENT ON COLUMN RYDA.TRAFFIC.DOPEN IS
'Дата открытия порта'
/



-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     12.11.2002  17:31
-- ============================================================

rename TRAFFIC to TRAFFIC1
/

alter table TRAFFIC1 drop constraint TRAFFIC_PK
/

-- ============================================================
--   Table: TRAFFIC
-- ============================================================
create table TRAFFIC
(
    CID        NUMBER(10)             not null,
    DOPEN      DATE                   not null,
    DSTART     DATE                   null    ,
    DEND       DATE                   null    ,
    NSEND      NUMBER                 null    ,
    NRECEIVED  NUMBER                 null    ,
    constraint TRAFFIC_PK primary key (CID, DOPEN)
)
/

insert into TRAFFIC select cid,dstart,dstart,DEND,NSEND,NRECEIVED from TRAFFIC1
/

drop table TRAFFIC1 cascade constraints
/

comment on table TRAFFIC is 'Трафик'
/

comment on column TRAFFIC.CID is 'Ид канала'
/

comment on column TRAFFIC.DOPEN is 'Дата открытия порта'
/

comment on column TRAFFIC.DSTART is 'Дата начала'
/

comment on column TRAFFIC.DEND is 'Дата окончания'
/

comment on column TRAFFIC.NSEND is 'Отпущено байт'
/

comment on column TRAFFIC.NRECEIVED is 'Получено байт'
/


alter table TRAFFIC
    add constraint TRAFFIC_F1 foreign key  (CID)
       references CHANNELS (CID) on delete cascade
/






-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     15.11.2002  14:25
-- ============================================================
-- ============================================================
--   Table: OPERSCANSCHEMAS
-- ============================================================
create table OPERSCANSCHEMAS
(
    NOPERSCANSCHEMAS  NUMBER(10)             not null,
    VNAME             VARCHAR2(128)          not null,
    constraint OPERSCANSCHEMAS_PK primary key (NOPERSCANSCHEMAS)
)
/

comment on table OPERSCANSCHEMAS is 'Схемы оперативного опроса'
/

comment on column OPERSCANSCHEMAS.NOPERSCANSCHEMAS is 'Ид схемы опер опроса'
/

comment on column OPERSCANSCHEMAS.VNAME is 'Название'
/


-- ============================================================
--   Index: OPERSCANSCHEMAS_IDX1
-- ============================================================
create unique index OPERSCANSCHEMAS_IDX1 on OPERSCANSCHEMAS (VNAME asc)
/

-- ============================================================
--   Table: ROLES
-- ============================================================
alter table ROLES add
(
    NOPERSCANSCHEMAS  NUMBER(10)             null
)
/

comment on table ROLES is 'Роли'
/

comment on column ROLES.ROLE_ID is 'Ид роли'
/

comment on column ROLES.NAME is 'Название'
/

comment on column ROLES.MONITOR is 'Ид схемы просмотра'
/

comment on column ROLES.NOPERSCANSCHEMAS is 'Ид схемы опер опроса'
/

-- ============================================================
--   Index: ROLES_IDX2
-- ============================================================
create index ROLES_IDX2 on ROLES (NOPERSCANSCHEMAS asc)
/

-- ============================================================
--   Table: SCHEMCHANNELS
-- ============================================================
create table SCHEMCHANNELS
(
    NOPERSCANSCHEMAS  NUMBER(10)             not null,
    CID               NUMBER(10)             not null,
    constraint SCHEMCHANNELS_PK primary key (NOPERSCANSCHEMAS, CID)
)
/

comment on table SCHEMCHANNELS is 'Схемы Каналы'
/

comment on column SCHEMCHANNELS.NOPERSCANSCHEMAS is 'Ид схемы опер опроса'
/

comment on column SCHEMCHANNELS.CID is 'Ид канала'
/


-- ============================================================
--   Index: SCHEMCHANNELS_IDX1
-- ============================================================
create index SCHEMCHANNELS_IDX1 on SCHEMCHANNELS (CID asc)
/

alter table ROLES
    add constraint ROLES_F1 foreign key  (NOPERSCANSCHEMAS)
       references OPERSCANSCHEMAS (NOPERSCANSCHEMAS)
/

alter table SCHEMCHANNELS
    add constraint SCHEMCHANNELS_F2 foreign key  (NOPERSCANSCHEMAS)
       references OPERSCANSCHEMAS (NOPERSCANSCHEMAS) on delete cascade
/

alter table SCHEMCHANNELS
    add constraint SCHEMCHANNELS_F1 foreign key  (CID)
       references CHANNELS (CID) on delete cascade
/


-- ============================================================
--   Table: CHANNELS
-- ============================================================
alter table CHANNELS add
(
    VUSER           VARCHAR2(128)          null    ,
    CYCLE_TOUT2     NUMBER                 null    ,
    BLOCKING2       NUMBER(1)              default 1 not null
        constraint CKC_BLOCKING2_CHANNELS check (BLOCKING2 in (0,1)),
    DSTART2         DATE                   null    ,
    DEND2           DATE                   null    ,
    NPARENT2        NUMBER(10)             null    ,
    NNOTREADCURR2   NUMBER(1)              default 0 not null
        constraint CKC_NNOTREADCURR2_CHANNELS check (NNOTREADCURR2 in (0,1)),
    NKIND     NUMBER                 null
)
/

comment on table CHANNELS is 'Каналы опроса приборов учета'
/

comment on column CHANNELS.VUSER is 'Пользователь'
/

comment on column CHANNELS.CYCLE_TOUT2 is 'Пауза между циклами 2'
/

comment on column CHANNELS.BLOCKING2 is 'Блокировка 2'
/

comment on column CHANNELS.DSTART2 is 'Начало опроса2'
/

comment on column CHANNELS.DEND2 is 'Окончание2'
/

comment on column CHANNELS.NPARENT2 is 'Главный канал2'
/

comment on column CHANNELS.NNOTREADCURR2 is 'Не читать тек сутки2'
/

comment on column CHANNELS.NKIND is 'Режим работы канала'
/

-- ============================================================
--   Index: CHANNELS_IDX5
-- ============================================================
create index CHANNELS_IDX5 on CHANNELS (NPARENT2 asc)
/

alter table CHANNELS
    add constraint CHANNELS_F4 foreign key  (NPARENT2)
       references CHANNELS (CID)
/



-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     18.11.2002  10:51
-- ============================================================
-- ============================================================
--   Table: GROUPS
-- ============================================================
alter table GROUPS drop column ngroup
/

alter table GROUPS drop column NEMERGENCYRESERVE
/

alter table GROUPS drop column NTECHNOLOGYRESERVE
/

alter table GROUPS add
(
    NROOT1              NUMBER(10)             null    ,
    NROOT2              NUMBER(10)             null    ,
    NEMERGENCYRESERVE   NUMBER                 null    ,
    NTECHNOLOGYRESERVE  NUMBER                 null
)
/

comment on column GROUPS.NROOT1 is 'Служебная 1'
/

comment on column GROUPS.NROOT2 is 'Служебная 2'
/

comment on column GROUPS.NEMERGENCYRESERVE is 'Аварийная бронь'
/

comment on column GROUPS.NTECHNOLOGYRESERVE is 'Технологическая бронь'
/


-- ============================================================
--   Index: GROUPS_IDX2
-- ============================================================
create unique index GROUPS_IDX2 on GROUPS (NROOT1 asc, NROOT2 asc)
/

-- ============================================================
--   Index: GROUPS_IDX3
-- ============================================================
create index GROUPS_IDX3 on GROUPS (NROOT2 asc)
/


-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     19.11.2002  12:53
-- ============================================================
-- ============================================================
--   Table: BILL_CALC
-- ============================================================
create table BILL_CALC
(
    MID        NUMBER                 not null,
    DATE_TIME  DATE                   not null,
    constraint BILL_CALC_PK primary key (MID, DATE_TIME)
)
/

comment on table BILL_CALC is 'Расчет суточных'
/

comment on column BILL_CALC.MID is 'Ид точки'
/

comment on column BILL_CALC.DATE_TIME is 'Дата'
/


alter table BILL_CALC
    add constraint BILL_CALC_F1 foreign key  (MID)
       references POINTS (MID) on delete cascade
/


-- ============================================================
--   Table: RATES
-- ============================================================
alter table RATES add
(
    ENDTIME   DATE                   null
)
/


comment on column RATES.ENDTIME is 'Дата окончания'
/




-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     23.11.2002  16:28
-- ============================================================
-- ============================================================
--   Table: FEEDERS
-- ============================================================

ALTER TABLE RYDA.FORMS ADD
(
   VPROCNAME                  VARCHAR2(128))
/

 COMMENT ON COLUMN RYDA.FORMS.VPROCNAME IS
'Хранимая процедура'
/

alter table FEEDERS add
(
    NINVERTED    NUMBER(1)              default 0 not null
        constraint CKC_NINVERTED_FEEDERS check (NINVERTED in (0,1))
)
/

comment on column FEEDERS.NCALCBILL is 'Верифицировать суточные'
/

comment on column FEEDERS.NCALCMONTHS is 'Верифицировать месячные'
/

comment on column FEEDERS.NINVERTED is 'Инверсия'
/

-- ============================================================
--   Table: TRAFFIC
-- ============================================================
alter table TRAFFIC add
(
    VUSER      VARCHAR2(128)          null
)
/

comment on column TRAFFIC.VUSER is 'Пользователь'
/


CREATE SEQUENCE comport_seq MINVALUE 1 MAXVALUE 999999999999999999999999999
  INCREMENT BY 1 START WITH 1000 CACHE 20 NOORDER NOCYCLE
/

-- ============================================================
--   Table: COMPORTS
-- ============================================================
alter table COMPORTS add
(
    DLASTEVENT  DATE                   null    ,
    VLASTEVENT  VARCHAR2(2000)         null
)
/

comment on table COMPORTS is 'Ком порты'
/

comment on column COMPORTS.COM_ID is 'Ид компорта'
/

comment on column COMPORTS.NAME is 'Название'
/

comment on column COMPORTS.BAUDRATE is 'Скорость'
/

comment on column COMPORTS.BYTESIZE is 'Разрядность'
/

comment on column COMPORTS.PARITY is 'Контроль четности'
/

comment on column COMPORTS.STOPBITS is 'Кол стоповых бит'
/

comment on column COMPORTS.DLASTEVENT is 'Дата посл события'
/

comment on column COMPORTS.VLASTEVENT is 'Последнее событие'
/

-- ============================================================
--   Table: COMPORTEVENTS
-- ============================================================
create table COMPORTEVENTS
(
    NORDER      NUMBER                 not null,
    COM_ID      NUMBER                 not null,
    DLASTEVENT  DATE                   not null,
    VLASTEVENT  VARCHAR2(2000)         null    ,
    constraint COMPORTEVENTS_PK primary key (NORDER)
)
/

comment on table COMPORTEVENTS is 'События по компорту (журнал)'
/

comment on column COMPORTEVENTS.NORDER is 'Ид события'
/

comment on column COMPORTEVENTS.COM_ID is 'Ид компорта'
/

comment on column COMPORTEVENTS.DLASTEVENT is 'Дата cобытия'
/

comment on column COMPORTEVENTS.VLASTEVENT is 'Cобытие'
/


-- ============================================================
--   Index: COMPORTEVENTS_IDX1
-- ============================================================
create index COMPORTEVENTS_IDX1 on COMPORTEVENTS (COM_ID asc, DLASTEVENT asc)
/

-- ============================================================
--   Index: COMPORTEVENTS_IDX2
-- ============================================================
create index COMPORTEVENTS_IDX2 on COMPORTEVENTS (DLASTEVENT asc)
/

alter table COMPORTEVENTS
    add constraint COMPORTEVENTS_F1 foreign key  (COM_ID)
       references COMPORTS (COM_ID) on delete cascade
/

-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     24.11.2002  14:11
-- ============================================================
-- ============================================================
--   Table: MONITORS
-- ============================================================
alter table MONITORS add
(
    NPARENT     NUMBER                 null
)
/

comment on table MONITORS is 'Мониторы'
/

comment on column MONITORS.MONITOR_ID is 'Ид монитора'
/

comment on column MONITORS.NPARENT is 'Родитель'
/

comment on column MONITORS.MSCHEMA is 'Схема'
/

comment on column MONITORS.NAME is 'Название'
/

comment on column MONITORS.DSIZE is 'Размер'
/

comment on column MONITORS.DFILE is 'Сам монитор'
/

comment on column MONITORS.IS_DEFAULT is 'По умолчанию'
/


ALTER TABLE MONITORS MODIFY
(
   MSCHEMA                    NOT NULL,
   DSIZE                      NOT NULL)
/

-- ============================================================
--   Index: MONITORS_IDX3
-- ============================================================
create index MONITORS_IDX3 on MONITORS (NPARENT asc)
/

alter table MONITORS
    add constraint MONITORS_F1 foreign key  (NPARENT)
       references MONITORS (MONITOR_ID) on delete cascade
/

-- ============================================================
--   Index: MONITORS_IDX1
-- ============================================================
drop index MONITORS_IDX1
/

create unique index MONITORS_IDX1 on MONITORS (NAME asc, MSCHEMA asc, NPARENT asc)
/

-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     25.11.2002  11:39
-- ============================================================
alter table GROUPS add
(
    NDEB                NUMBER(16,2)           null    ,
    NDEBRESTR           NUMBER(16,2)           null
)
/

comment on column GROUPS.NDEB is 'Долг'
/

comment on column GROUPS.NDEBRESTR is 'Долг с реструкторизацией'
/

-- ============================================================
--   Table: BILLORG
-- ============================================================
create table BILLORG
(
    MID        NUMBER                 not null,
    DATE_TIME  DATE                   not null,
    VALID      VARCHAR2(1)            null    ,
    SOURCE     VARCHAR2(50)           null    ,
    REMARK     VARCHAR2(200)          null    ,
    ER_MTRSN   VARCHAR2(20)           null    ,
    ER_KC      NUMBER                 null    ,
    ERM        NUMBER                 null    ,
    ER         NUMBER                 null    ,
    AERM       NUMBER                 null    ,
    AER        NUMBER                 null    ,
    BERM       NUMBER                 null    ,
    BER        NUMBER                 null    ,
    CERM       NUMBER                 null    ,
    CER        NUMBER                 null    ,
    DERM       NUMBER                 null    ,
    DER        NUMBER                 null    ,
    Q1_MTRSN   VARCHAR2(20)           null    ,
    Q1_KC      NUMBER                 null    ,
    Q1M        NUMBER                 null    ,
    Q1         NUMBER                 null    ,
    AQ1M       NUMBER                 null    ,
    AQ1        NUMBER                 null    ,
    BQ1M       NUMBER                 null    ,
    BQ1        NUMBER                 null    ,
    CQ1M       NUMBER                 null    ,
    CQ1        NUMBER                 null    ,
    DQ1M       NUMBER                 null    ,
    DQ1        NUMBER                 null    ,
    ED_MTRSN   VARCHAR2(20)           null    ,
    ED_KC      NUMBER                 null    ,
    EDM        NUMBER                 null    ,
    ED         NUMBER                 null    ,
    AEDM       NUMBER                 null    ,
    AED        NUMBER                 null    ,
    BEDM       NUMBER                 null    ,
    BED        NUMBER                 null    ,
    CEDM       NUMBER                 null    ,
    CED        NUMBER                 null    ,
    DEDM       NUMBER                 null    ,
    DED        NUMBER                 null    ,
    Q3_MTRSN   VARCHAR2(20)           null    ,
    Q3_KC      NUMBER                 null    ,
    Q3M        NUMBER                 null    ,
    Q3         NUMBER                 null    ,
    AQ3M       NUMBER                 null    ,
    AQ3        NUMBER                 null    ,
    BQ3M       NUMBER                 null    ,
    BQ3        NUMBER                 null    ,
    CQ3M       NUMBER                 null    ,
    CQ3        NUMBER                 null    ,
    DQ3M       NUMBER                 null    ,
    DQ3        NUMBER                 null    ,
    Q2_MTRSN   VARCHAR2(20)           null    ,
    Q2_KC      NUMBER                 null    ,
    Q2M        NUMBER                 null    ,
    Q2         NUMBER                 null    ,
    AQ2M       NUMBER                 null    ,
    AQ2        NUMBER                 null    ,
    BQ2M       NUMBER                 null    ,
    BQ2        NUMBER                 null    ,
    CQ2M       NUMBER                 null    ,
    CQ2        NUMBER                 null    ,
    DQ2M       NUMBER                 null    ,
    DQ2        NUMBER                 null    ,
    Q4_MTRSN   VARCHAR2(20)           null    ,
    Q4_KC      NUMBER                 null    ,
    Q4M        NUMBER                 null    ,
    Q4         NUMBER                 null    ,
    AQ4M       NUMBER                 null    ,
    AQ4        NUMBER                 null    ,
    BQ4M       NUMBER                 null    ,
    BQ4        NUMBER                 null    ,
    CQ4M       NUMBER                 null    ,
    CQ4        NUMBER                 null    ,
    DQ4M       NUMBER                 null    ,
    DQ4        NUMBER                 null    ,
    NWASTEABS  NUMBER(1)              default 0 not null,
    constraint BILL2_PK primary key (MID, DATE_TIME)
)
/

comment on table BILLORG is 'Суточные первичка'
/

comment on column BILLORG.MID is 'Ид точки'
/

comment on column BILLORG.DATE_TIME is 'DATE_TIME'
/

comment on column BILLORG.VALID is 'VALID'
/

comment on column BILLORG.SOURCE is 'SOURCE'
/

comment on column BILLORG.REMARK is 'REMARK'
/

comment on column BILLORG.ER_MTRSN is 'ER_MTRSN'
/

comment on column BILLORG.ER_KC is 'ER_KC'
/

comment on column BILLORG.ERM is 'ERM'
/

comment on column BILLORG.ER is 'ER'
/

comment on column BILLORG.AERM is 'AERM'
/

comment on column BILLORG.AER is 'AER'
/

comment on column BILLORG.BERM is 'BERM'
/

comment on column BILLORG.BER is 'BER'
/

comment on column BILLORG.CERM is 'CERM'
/

comment on column BILLORG.CER is 'CER'
/

comment on column BILLORG.DERM is 'DERM'
/

comment on column BILLORG.DER is 'DER'
/

comment on column BILLORG.Q1_MTRSN is 'Q1_MTRSN'
/

comment on column BILLORG.Q1_KC is 'Q1_KC'
/

comment on column BILLORG.Q1M is 'Q1M'
/

comment on column BILLORG.Q1 is 'Q1'
/

comment on column BILLORG.AQ1M is 'AQ1M'
/

comment on column BILLORG.AQ1 is 'AQ1'
/

comment on column BILLORG.BQ1M is 'BQ1M'
/

comment on column BILLORG.BQ1 is 'BQ1'
/

comment on column BILLORG.CQ1M is 'CQ1M'
/

comment on column BILLORG.CQ1 is 'CQ1'
/

comment on column BILLORG.DQ1M is 'DQ1M'
/

comment on column BILLORG.DQ1 is 'DQ1'
/

comment on column BILLORG.ED_MTRSN is 'ED_MTRSN'
/

comment on column BILLORG.ED_KC is 'ED_KC'
/

comment on column BILLORG.EDM is 'EDM'
/

comment on column BILLORG.ED is 'ED'
/

comment on column BILLORG.AEDM is 'AEDM'
/

comment on column BILLORG.AED is 'AED'
/

comment on column BILLORG.BEDM is 'BEDM'
/

comment on column BILLORG.BED is 'BED'
/

comment on column BILLORG.CEDM is 'CEDM'
/

comment on column BILLORG.CED is 'CED'
/

comment on column BILLORG.DEDM is 'DEDM'
/

comment on column BILLORG.DED is 'DED'
/

comment on column BILLORG.Q3_MTRSN is 'Q3_MTRSN'
/

comment on column BILLORG.Q3_KC is 'Q3_KC'
/

comment on column BILLORG.Q3M is 'Q3M'
/

comment on column BILLORG.Q3 is 'Q3'
/

comment on column BILLORG.AQ3M is 'AQ3M'
/

comment on column BILLORG.AQ3 is 'AQ3'
/

comment on column BILLORG.BQ3M is 'BQ3M'
/

comment on column BILLORG.BQ3 is 'BQ3'
/

comment on column BILLORG.CQ3M is 'CQ3M'
/

comment on column BILLORG.CQ3 is 'CQ3'
/

comment on column BILLORG.DQ3M is 'DQ3M'
/

comment on column BILLORG.DQ3 is 'DQ3'
/

comment on column BILLORG.Q2_MTRSN is 'Q2_MTRSN'
/

comment on column BILLORG.Q2_KC is 'Q2_KC'
/

comment on column BILLORG.Q2M is 'Q2M'
/

comment on column BILLORG.Q2 is 'Q2'
/

comment on column BILLORG.AQ2M is 'AQ2M'
/

comment on column BILLORG.AQ2 is 'AQ2'
/

comment on column BILLORG.BQ2M is 'BQ2M'
/

comment on column BILLORG.BQ2 is 'BQ2'
/

comment on column BILLORG.CQ2M is 'CQ2M'
/

comment on column BILLORG.CQ2 is 'CQ2'
/

comment on column BILLORG.DQ2M is 'DQ2M'
/

comment on column BILLORG.DQ2 is 'DQ2'
/

comment on column BILLORG.Q4_MTRSN is 'Q4_MTRSN'
/

comment on column BILLORG.Q4_KC is 'Q4_KC'
/

comment on column BILLORG.Q4M is 'Q4M'
/

comment on column BILLORG.Q4 is 'Q4'
/

comment on column BILLORG.AQ4M is 'AQ4M'
/

comment on column BILLORG.AQ4 is 'AQ4'
/

comment on column BILLORG.BQ4M is 'BQ4M'
/

comment on column BILLORG.BQ4 is 'BQ4'
/

comment on column BILLORG.CQ4M is 'CQ4M'
/

comment on column BILLORG.CQ4 is 'CQ4'
/

comment on column BILLORG.DQ4M is 'DQ4M'
/

comment on column BILLORG.DQ4 is 'DQ4'
/

comment on column BILLORG.NWASTEABS is 'Служебный1'
/

-- ============================================================
--   Index: BILL_IDX12
-- ============================================================
create index BILL_IDX12 on BILLORG (DATE_TIME asc)
/

alter table BILLORG
    add constraint BILLORG_F1 foreign key  (MID)
       references POINTS (MID) on delete cascade
/


/*
drop table halfhourorg
/
drop table curr_powerorg
/
drop table profileorg
/
drop table monthsorg
/

alter table lg_readout drop constraint LG_READOUT_PK
/
alter table lg_readout drop constraint LG_READOUT_F1
/
drop index LG_READOUT_IDX1
/
rename lg_readout to tmp_lg_readout
/

alter table lg_loadprof drop constraint lg_loadprof_PK
/
alter table lg_loadprof drop constraint lg_loadprof_F1
/
drop index lg_loadprof_IDX1
/
rename lg_loadprof to tmp_lg_loadprof
/
*/



-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     28.11.2002  10:06
-- ============================================================
alter table LG_LOADPROF drop constraint  LG_LOADPROF_PK
/

alter table LG_READOUT drop constraint LG_READOUT_PK
/

alter table LG_READOUT add constraint LG_READOUT_PK primary key (MID, DATE_TIME)
/

create index LG_READOUT_IDX1 on LG_READOUT (DATE_TIME asc)
/

alter table LG_LOADPROF add constraint LG_LOADPROF_PK primary key (MID, DATE_TIME)
/

create index LG_LOADPROF_IDX1 on LG_LOADPROF (DATE_TIME asc)
/

CREATE GLOBAL TEMPORARY TABLE TEXTREPORT
  (
  norder                       NUMBER,--ид. объекта
  vtext                   VARCHAR2(4000)
 )
 ON COMMIT PRESERVE ROWS
 ORGANIZATION HEAP
 CACHE
/
COMMENT ON TABLE TEXTREPORT IS 'Отчеты PL-Sql'
/
COMMENT ON COLUMN TEXTREPORT.norder IS 'Строка'
/
COMMENT ON COLUMN TEXTREPORT.vtext IS 'Текст'
/


-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     30.11.2002  18:56
-- ============================================================
alter table DEPORTPROCEDURES add
(
    NTYPE       NUMBER(10)             default 0 not null,
    VPARAM      VARCHAR2(2000)         null    ,
    VMEMO       VARCHAR2(2000)         null
)
/

comment on column DEPORTPROCEDURES.NTYPE is 'Тип процедуры'
/

comment on column DEPORTPROCEDURES.VPARAM is 'Параметр'
/

comment on column DEPORTPROCEDURES.VMEMO is 'Описание'
/


-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     01.12.2002  14:59
-- ============================================================
alter table FEEDERS add
(
    NSWITCH      NUMBER(1)              default 0 not null
        constraint CKC_NSWITCH_FEEDERS check (NSWITCH in (0,1))
)
/

comment on column FEEDERS.NSWITCH is 'Признак обводника'
/

rename HALFHOUR to HALFHOUROLD
/

alter table HALFHOUROLD drop constraint HALFHOUR_PK
/

alter table HALFHOUROLD add
(
    NSOURCE      NUMBER(10)             default 50 not null,
    NSWITCH      NUMBER                 null    ,
    NEXCEPTCALC  NUMBER(1)              null
        constraint CKC_NEXCEPTCALC_HALFHOUR check (
            NEXCEPTCALC is null or (NEXCEPTCALC in (1))),
    constraint HALFHOUR_PK primary key (MID, DATE_TIME, NSOURCE)
)
/

comment on column HALFHOUROLD.NSOURCE is 'Код источника'
/

comment on column HALFHOUROLD.NSWITCH is 'Ид обводника'
/

comment on column HALFHOUROLD.NEXCEPTCALC is 'Исключен из расчета'
/

-- ============================================================
--   Index: HALFHOUR_IDX2
-- ============================================================
create index HALFHOUR_IDX2 on HALFHOUROLD (NSWITCH asc)
/

create index HALFHOUR_IDX3 on HALFHOUROLD (NEXCEPTCALC asc)
/

rename months to monthsorg
/

-- End of DDL script for HALFHOUR
CREATE OR REPLACE VIEW months (
   mid,
   date_time,
   valid,
   source,
   remark,
   er_mtrsn,
   er_kc,
   erm,
   er,
   aerm,
   aer,
   berm,
   ber,
   cerm,
   cer,
   derm,
   der,
   q1_mtrsn,
   q1_kc,
   q1m,
   q1,
   aq1m,
   aq1,
   bq1m,
   bq1,
   cq1m,
   cq1,
   dq1m,
   dq1,
   ed_mtrsn,
   ed_kc,
   edm,
   ed,
   aedm,
   aed,
   bedm,
   bed,
   cedm,
   ced,
   dedm,
   ded,
   q3_mtrsn,
   q3_kc,
   q3m,
   q3,
   aq3m,
   aq3,
   bq3m,
   bq3,
   cq3m,
   cq3,
   dq3m,
   dq3,
   q2_mtrsn,
   q2_kc,
   q2m,
   q2,
   aq2m,
   aq2,
   bq2m,
   bq2,
   cq2m,
   cq2,
   dq2m,
   dq2,
   q4_mtrsn,
   q4_kc,
   q4m,
   q4,
   aq4m,
   aq4,
   bq4m,
   bq4,
   cq4m,
   cq4,
   dq4m,
   dq4,
   nwasteabs )
AS
SELECT
    MID,
    DATE_TIME,
    VALID,
    SOURCE,
    REMARK,
    ER_MTRSN,
    ER_KC,
    ERM,
    ER,
    AERM,
    AER,
    BERM,
    BER,
    CERM,
    CER,
    DERM,
    DER,
    Q1_MTRSN,
    Q1_KC,
    Q1M,
    Q1,
    AQ1M,
    AQ1,
    BQ1M,
    BQ1,
    CQ1M,
    CQ1,
    DQ1M,
    DQ1,
    ED_MTRSN,
    ED_KC,
    EDM,
    ED,
    AEDM,
    AED,
    BEDM,
    BED,
    CEDM,
    CED,
    DEDM,
    DED,
    Q3_MTRSN,
    Q3_KC,
    Q3M,
    Q3,
    AQ3M,
    AQ3,
    BQ3M,
    BQ3,
    CQ3M,
    CQ3,
    DQ3M,
    DQ3,
    Q2_MTRSN,
    Q2_KC,
    Q2M,
    Q2,
    AQ2M,
    AQ2,
    BQ2M,
    BQ2,
    CQ2M,
    CQ2,
    DQ2M,
    DQ2,
    Q4_MTRSN,
    Q4_KC,
    Q4M,
    Q4,
    AQ4M,
    AQ4,
    BQ4M,
    BQ4,
    CQ4M,
    CQ4,
    DQ4M,
    DQ4,
    NWASTEABS
 FROM MONTHSORG
/

-- ============================================================
--   Table: SWITCHES
-- ============================================================
create table SWITCHES
(
    ID       NUMBER(10)             not null,
    NSWITCH  NUMBER                 not null,
    DSWITCH  DATE                   not null,
    MID      NUMBER                 null    ,
    ERM      NUMBER                 null    ,
    DENTER   DATE                   not null,
    USER_ID  NUMBER                 not null,
    constraint SWITCHES_PK primary key (ID)
)
/

comment on table SWITCHES is 'Переключение обводвых'
/

comment on column SWITCHES.ID is 'Ид строки'
/

comment on column SWITCHES.NSWITCH is 'Ид обводника'
/

comment on column SWITCHES.DSWITCH is 'Дата переключения'
/

comment on column SWITCHES.MID is 'Ид точки'
/

comment on column SWITCHES.ERM is 'Показание'
/

comment on column SWITCHES.DENTER is 'Дата ввода'
/

comment on column SWITCHES.USER_ID is 'Ид пользователя'
/


-- ============================================================
--   Index: SWITCHES_IDX1
-- ============================================================
create index SWITCHES_IDX1 on SWITCHES (MID asc)
/

-- ============================================================
--   Index: SWITCHES_IDX2
-- ============================================================
create index SWITCHES_IDX2 on SWITCHES (USER_ID asc)
/

-- ============================================================
--   Index: SWITCHES_IDX3
-- ============================================================
create index SWITCHES_IDX3 on SWITCHES (DSWITCH asc)
/

-- ============================================================
--   Index: SWITCHES_IDX4
-- ============================================================
create index SWITCHES_IDX4 on SWITCHES (NSWITCH asc, DSWITCH asc)
/

alter table SWITCHES
    add constraint SWITCHES_F1 foreign key  (USER_ID)
       references USERS (USER_ID)
/

alter table SWITCHES
    add constraint SWITCHES_F3 foreign key  (NSWITCH)
       references POINTS (MID)
/

alter table SWITCHES
    add constraint SWITCHES_F2 foreign key  (MID)
       references POINTS (MID)
/


alter table HALFHOUROLD
    add constraint FK_HALFHOUR_REF_30564_POINTS foreign key  (NSWITCH)
       references POINTS (MID) on delete cascade
/

CREATE OR REPLACE VIEW halfhour (
   mid,
   date_time,
   er,
   q1,
   ed,
   q3,
   q2,
   q4,
   erm,
   q1m,
   edm,
   q3m,
   q2m,
   q4m,
   status)
AS
SELECT
    MID,
    DATE_TIME,
    ER,
    Q1,
    ED,
    Q3,
    Q2,
    Q4,
    ERM,
    Q1M,
    EDM,
    Q3M,
    Q2M,
    Q4M,
    STATUS
 FROM RYDA.HALFHOUROLD WHERE NEXCEPTCALC IS NULL
/

comment on column DEPORTPROCEDURES.VNAME is 'Название'
/

create unique index DEPORTPROCEDURES_UNI2 on DEPORTPROCEDURES (VNAME asc)
/






-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     05.12.2002  16:01
-- ============================================================

drop table SWITCHES cascade constraints
/

drop table LG_LOADPROF cascade constraints
/

drop table LG_READOUT cascade constraints
/

-- ============================================================
--   Table: LG_READOUT
-- ============================================================
create table LG_READOUT
(
    MID        NUMBER                 not null,
    DATE_TIME  DATE                   not null,
    NSORT      NUMBER(10)             not null,
    VDATA      VARCHAR2(2000)         null    ,
    constraint LG_READOUT_PK primary key (MID, DATE_TIME, NSORT)
)
/

comment on table LG_READOUT is 'Файл LG'
/

comment on column LG_READOUT.MID is 'Ид точки'
/

comment on column LG_READOUT.DATE_TIME is 'Дата считывания'
/

comment on column LG_READOUT.NSORT is 'Строка'
/

comment on column LG_READOUT.VDATA is 'Данные считывания'
/


-- ============================================================
--   Index: LG_READOUT_IDX1
-- ============================================================
create index LG_READOUT_IDX1 on LG_READOUT (DATE_TIME asc, NSORT asc)
/

-- ============================================================
--   Table: LG_LOADPROF
-- ============================================================
create table LG_LOADPROF
(
    MID        NUMBER                 not null,
    DATE_TIME  DATE                   not null,
    NSORT      NUMBER(10)             not null,
    VDATA      VARCHAR2(2000)         null    ,
    constraint LG_LOADPROF_PK primary key (MID, DATE_TIME, NSORT)
)
/

comment on table LG_LOADPROF is 'Файл ГН LG'
/

comment on column LG_LOADPROF.MID is 'Ид точки'
/

comment on column LG_LOADPROF.DATE_TIME is 'Дата считывания ГН'
/

comment on column LG_LOADPROF.NSORT is 'Строка'
/

comment on column LG_LOADPROF.VDATA is 'Данные считывания ГН'
/


-- ============================================================
--   Index: LG_LOADPROF_IDX1
-- ============================================================
create index LG_LOADPROF_IDX1 on LG_LOADPROF (DATE_TIME asc, NSORT asc)
/

-- ============================================================
--   Table: SWITCHES
-- ============================================================
create table SWITCHES
(
    ID         NUMBER(10)             not null,
    NSWITCH    NUMBER                 not null,
    DSWITCH    DATE                   not null,
    DESCAPE    DATE                   not null,
    MID        NUMBER                 null    ,
    DENTER     DATE                   not null,
    USER_ID    NUMBER                 not null,
    ERM        NUMBER                 null    ,
    EDM        NUMBER                 null    ,
    Q1M        NUMBER                 null    ,
    Q2M        NUMBER                 null    ,
    Q3M        NUMBER                 null    ,
    Q4M        NUMBER                 null    ,
    NSTATE     NUMBER(1)              default 0 not null
        constraint CKC_NSTATE_SWITCHES check (NSTATE in (0,1,2)),
    VERROR     VARCHAR2(256)          null    ,
    constraint SWITCHES_PK primary key (ID)
)
/

comment on table SWITCHES is 'Переключение обводвых'
/

comment on column SWITCHES.ID is 'Ид строки'
/

comment on column SWITCHES.NSWITCH is 'Ид обводника'
/

comment on column SWITCHES.DSWITCH is 'Дата переключения'
/

comment on column SWITCHES.DESCAPE is 'Дата окончания'
/

comment on column SWITCHES.MID is 'Ид точки'
/

comment on column SWITCHES.DENTER is 'Дата ввода'
/

comment on column SWITCHES.USER_ID is 'Ид пользователя'
/

comment on column SWITCHES.ERM is 'Показание A пр'
/

comment on column SWITCHES.EDM is 'Показание A от'
/

comment on column SWITCHES.Q1M is 'Показание Q1'
/

comment on column SWITCHES.Q2M is 'Показание Q2'
/

comment on column SWITCHES.Q3M is 'Показание Q3'
/

comment on column SWITCHES.Q4M is 'Показание Q4'
/

comment on column SWITCHES.NSTATE is 'Состояние расчета'
/

comment on column SWITCHES.VERROR is 'Текст ошибки'
/


-- ============================================================
--   Index: SWITCHES_IDX1
-- ============================================================
create index SWITCHES_IDX1 on SWITCHES (MID asc)
/

-- ============================================================
--   Index: SWITCHES_IDX2
-- ============================================================
create index SWITCHES_IDX2 on SWITCHES (USER_ID asc)
/

-- ============================================================
--   Index: SWITCHES_IDX3
-- ============================================================
create index SWITCHES_IDX3 on SWITCHES (DSWITCH asc)
/

-- ============================================================
--   Index: SWITCHES_IDX4
-- ============================================================
create unique index SWITCHES_IDX4 on SWITCHES (NSWITCH asc, DSWITCH asc)
/

alter table LG_READOUT
    add constraint LG_READOUT_F1 foreign key  (MID)
       references POINTS (MID) on delete cascade
/

alter table LG_LOADPROF
    add constraint LG_LOADPROF_F1 foreign key  (MID)
       references POINTS (MID) on delete cascade
/

alter table SWITCHES
    add constraint SWITCHES_F1 foreign key  (USER_ID)
       references USERS (USER_ID)
/

alter table SWITCHES
    add constraint SWITCHES_F3 foreign key  (NSWITCH)
       references POINTS (MID)
/

alter table SWITCHES
    add constraint SWITCHES_F2 foreign key  (MID)
       references POINTS (MID)
/




-- ============================================================
--   Table: AVERRATE
-- ============================================================
create table AVERRATE
(
    NHH        NUMBER(2)              not null,
    NER        NUMBER                 null    ,
    NED        NUMBER                 null    ,
    NQ1        NUMBER                 null    ,
    NQ2        NUMBER                 null    ,
    NQ3        NUMBER                 null    ,
    NQ4        NUMBER                 null    ,
    constraint AVERRATE_PK primary key (NHH)
)
/

comment on table AVERRATE is 'Долевые коеффициенты'
/

comment on column AVERRATE.NHH is 'Сдвиг часа'
/

comment on column AVERRATE.NER is 'Коеф А пр'
/

comment on column AVERRATE.NED is 'Коеф А отд'
/

comment on column AVERRATE.NQ1 is 'Коеф Q1'
/

comment on column AVERRATE.NQ2 is 'Коеф Q2'
/

comment on column AVERRATE.NQ3 is 'Коеф Q3'
/

comment on column AVERRATE.NQ4 is 'Коеф Q4'
/


-- ============================================================
--   Table: HALFHOURTMP
-- ============================================================
create table HALFHOURTMP
(
    MID        NUMBER                 not null,
    DATE_TIME  DATE                   not null,
    NSOURCE    NUMBER(10)             not null,
    ER         NUMBER                 null    ,
    Q1         NUMBER                 null    ,
    ED         NUMBER                 null    ,
    Q3         NUMBER                 null    ,
    Q2         NUMBER                 null    ,
    Q4         NUMBER                 null    ,
    ERM        NUMBER                 null    ,
    Q1M        NUMBER                 null    ,
    EDM        NUMBER                 null    ,
    Q3M        NUMBER                 null    ,
    Q2M        NUMBER                 null    ,
    Q4M        NUMBER                 null    ,
    STATUS     NUMBER                 null    ,
    constraint HALFHOURTMP_PK primary key (MID, DATE_TIME, NSOURCE)
)
/

comment on table HALFHOURTMP is 'Получасовки временные'
/

comment on column HALFHOURTMP.MID is 'Ид точки'
/

comment on column HALFHOURTMP.DATE_TIME is 'Дата показаний'
/

comment on column HALFHOURTMP.NSOURCE is 'Код источника'
/

comment on column HALFHOURTMP.ER is 'Расход А пр'
/

comment on column HALFHOURTMP.Q1 is 'Расход Q1'
/

comment on column HALFHOURTMP.ED is 'Расход А от'
/

comment on column HALFHOURTMP.Q3 is 'Расход Q3'
/

comment on column HALFHOURTMP.Q2 is 'Расход Q2'
/

comment on column HALFHOURTMP.Q4 is 'Расход Q4'
/

comment on column HALFHOURTMP.ERM is 'Показания А пр'
/

comment on column HALFHOURTMP.Q1M is 'Показания Q1'
/

comment on column HALFHOURTMP.EDM is 'Показания А от'
/

comment on column HALFHOURTMP.Q3M is 'Показания Q3'
/

comment on column HALFHOURTMP.Q2M is 'Показания Q2'
/

comment on column HALFHOURTMP.Q4M is 'Показания Q4'
/

comment on column HALFHOURTMP.STATUS is 'Статус'
/


-- ============================================================
--   Index: HALFHOUR_IDX12
-- ============================================================
create index HALFHOUR_IDX12 on HALFHOURTMP (DATE_TIME asc)
/

alter table HALFHOURTMP
    add constraint HALFHOURTMP_F1 foreign key  (MID)
       references POINTS (MID) on delete cascade
/



--07.12.2002
alter table bill add
(
    NSOURCE      NUMBER(10)
)
/
comment on column HALFHOUROLD.NSOURCE is 'Код источника'
/

alter table MONTHSORG drop constraint MONTHS_PK
/
alter table MONTHSORG add
(
    NSOURCE      NUMBER(10)             default 50 not null,
    constraint MONTHS_PK primary key (MID, DATE_TIME, NSOURCE)
)
/
comment on column MONTHSORG.NSOURCE is 'Код источника'
/


alter table BILLORG drop constraint BILL2_PK
/

alter table BILLORG add
(
    NSOURCE      NUMBER(10)             default 50 not null,
    constraint BILL2_PK primary key (MID, DATE_TIME, NSOURCE)
)
/
comment on column BILLORG.NSOURCE is 'Код источника'
/


/*
alter table MAKETS drop column DOPERSTART
/
alter table MAKETS drop column VOPERERROR
/

*/

-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     12.12.2002  12:16
-- ============================================================
-- ============================================================
--   Table: DEPORTPROCEDURES
-- ============================================================
alter table DEPORTPROCEDURES drop column NSHIFT
/
alter table DEPORTPROCEDURES drop column VPARAM
/

comment on table DEPORTPROCEDURES is 'Фоновые процедуры'
/

comment on column DEPORTPROCEDURES.NPROCEDURE is 'Ид процедуры'
/

comment on column DEPORTPROCEDURES.VNAME is 'Название'
/

comment on column DEPORTPROCEDURES.VPROCEDURE is 'Процедура'
/

comment on column DEPORTPROCEDURES.NPERIOD is 'Периодичность формирования'
/

comment on column DEPORTPROCEDURES.NTYPE is 'Тип процедуры'
/

comment on column DEPORTPROCEDURES.VMEMO is 'Описание'
/

-- ============================================================
--   Table: MAKETS
-- ============================================================
alter table MAKETS drop column DOLDCREATED
/
alter table MAKETS drop column VERROR
/

alter table MAKETS add
(
    NSHIFT       NUMBER                default 0 not null,
    VPARAM       VARCHAR2(2000)         null    ,
    DOLDCREATED  DATE                   null    ,
    VERROR       VARCHAR2(2000)         null
)
/

comment on table MAKETS is 'Задания'
/

comment on column MAKETS.NMAKET is 'Ид макета'
/

comment on column MAKETS.NPROCEDURE is 'Ид процедуры'
/

comment on column MAKETS.VNAME is 'Название'
/

comment on column MAKETS.VNOTE is 'Примечание'
/

comment on column MAKETS.NBLOCK is 'Блокировка'
/

comment on column MAKETS.NCYCLE is 'Выполнять невыполненые вовремя'
/

comment on column MAKETS.NSHIFT is 'Сдвиг старта формирования мин'
/

comment on column MAKETS.VPARAM is 'Параметр'
/

comment on column MAKETS.DOLDCREATED is 'Дата последнего создания'
/

comment on column MAKETS.VERROR is 'Ошибка'
/


-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     14.12.2002  12:06
-- ============================================================
alter table ROLE_TASK add
(
    NACC     NUMBER(1)              default 1 not null
        constraint CKC_NACC_ROLE_TAS check (NACC in (0,1))
)
/

comment on table ROLE_TASK is 'Доступные задачи'
/

comment on column ROLE_TASK.ROLE_ID is 'Ид роли'
/

comment on column ROLE_TASK.TASK_ID is 'Ид задачи'
/

comment on column ROLE_TASK.NACC is 'Полный доступ'
/

-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     16.12.2002  09:39
-- ============================================================

-- ============================================================
--   Table: ITEKCOEFF
-- ============================================================
create table ITEKCOEFF
(
    MID        NUMBER                 not null,
    DATE_TIME  DATE                   null    ,
    KER        NUMBER                 null    ,
    KED        NUMBER                 null    ,
    KQ1        NUMBER                 null    ,
    KQ3        NUMBER                 null    ,
    constraint ITEKCOEFF_PK primary key (MID)
)
/

comment on table ITEKCOEFF is 'Коефициенты ИТЭК'
/

comment on column ITEKCOEFF.MID is 'Ид точки'
/

comment on column ITEKCOEFF.DATE_TIME is 'Дата'
/

comment on column ITEKCOEFF.KER is 'KER'
/

comment on column ITEKCOEFF.KED is 'KED'
/

comment on column ITEKCOEFF.KQ1 is 'KQ1'
/

comment on column ITEKCOEFF.KQ3 is 'KQ3'
/


alter table ITEKCOEFF
    add constraint ITEKCOEFF_F1 foreign key  (MID)
       references POINTS (MID) on delete cascade
/

--29.12.2002
ALTER USER RYDA IDENTIFIED BY ORACLE81634
/



-- Start of DDL script for BILLEVID
-- Generated 5-янв-03  2:11:28 pm
-- from oe-RYDA:1

-- View BILLEVID

CREATE OR REPLACE VIEW billevid (
   mid,
   date_time,
   valid,
   source,
   remark,
   er_mtrsn,
   er_kc,
   erm,
   er,
   aerm,
   aer,
   berm,
   ber,
   cerm,
   cer,
   derm,
   der,
   q1_mtrsn,
   q1_kc,
   q1m,
   q1,
   aq1m,
   aq1,
   bq1m,
   bq1,
   cq1m,
   cq1,
   dq1m,
   dq1,
   ed_mtrsn,
   ed_kc,
   edm,
   ed,
   aedm,
   aed,
   bedm,
   bed,
   cedm,
   ced,
   dedm,
   ded,
   q3_mtrsn,
   q3_kc,
   q3m,
   q3,
   aq3m,
   aq3,
   bq3m,
   bq3,
   cq3m,
   cq3,
   dq3m,
   dq3,
   q2_mtrsn,
   q2_kc,
   q2m,
   q2,
   aq2m,
   aq2,
   bq2m,
   bq2,
   cq2m,
   cq2,
   dq2m,
   dq2,
   q4_mtrsn,
   q4_kc,
   q4m,
   q4,
   aq4m,
   aq4,
   bq4m,
   bq4,
   cq4m,
   cq4,
   dq4m,
   dq4 )
AS
SELECT
    MID,
    DATE_TIME,
    VALID,
    SOURCE,
    REMARK,
    ER_MTRSN,
    ER_KC,
    ERM,
    ER,
    AERM,
    AER,
    BERM,
    BER,
    CERM,
    CER,
    DERM,
    DER,
    Q1_MTRSN,
    Q1_KC,
    Q1M,
    Q1,
    AQ1M,
    AQ1,
    BQ1M,
    BQ1,
    CQ1M,
    CQ1,
    DQ1M,
    DQ1,
    ED_MTRSN,
    ED_KC,
    EDM,
    ED,
    AEDM,
    AED,
    BEDM,
    BED,
    CEDM,
    CED,
    DEDM,
    DED,
    Q3_MTRSN,
    Q3_KC,
    Q3M,
    Q3,
    AQ3M,
    AQ3,
    BQ3M,
    BQ3,
    CQ3M,
    CQ3,
    DQ3M,
    DQ3,
    Q2_MTRSN,
    Q2_KC,
    Q2M,
    Q2,
    AQ2M,
    AQ2,
    BQ2M,
    BQ2,
    CQ2M,
    CQ2,
    DQ2M,
    DQ2,
    Q4_MTRSN,
    Q4_KC,
    Q4M,
    Q4,
    AQ4M,
    AQ4,
    BQ4M,
    BQ4,
    CQ4M,
    CQ4,
    DQ4M,
    DQ4
 FROM RYDA.BILLORG
/

-- End of DDL script for BILLEVID

-- Start of DDL script for HALFHOUREVID
-- Generated 5-янв-03  2:11:35 pm
-- from oe-RYDA:1

-- View HALFHOUREVID

CREATE OR REPLACE VIEW halfhourevid (
   mid,
   date_time,
   er,
   q1,
   ed,
   q3,
   q2,
   q4,
   erm,
   q1m,
   edm,
   q3m,
   q2m,
   q4m,
   status )
AS
SELECT
    MID,
    DATE_TIME,
    ER,
    Q1,
    ED,
    Q3,
    Q2,
    Q4,
    ERM,
    Q1M,
    EDM,
    Q3M,
    Q2M,
    Q4M,
    STATUS
 FROM RYDA.HALFHOURold
/

-- End of DDL script for HALFHOUREVID

-- Start of DDL script for MONTHSEVID
-- Generated 5-янв-03  2:11:40 pm
-- from oe-RYDA:1

-- View MONTHSEVID

CREATE OR REPLACE VIEW monthsevid (
   mid,
   date_time,
   valid,
   source,
   remark,
   er_mtrsn,
   er_kc,
   erm,
   er,
   aerm,
   aer,
   berm,
   ber,
   cerm,
   cer,
   derm,
   der,
   q1_mtrsn,
   q1_kc,
   q1m,
   q1,
   aq1m,
   aq1,
   bq1m,
   bq1,
   cq1m,
   cq1,
   dq1m,
   dq1,
   ed_mtrsn,
   ed_kc,
   edm,
   ed,
   aedm,
   aed,
   bedm,
   bed,
   cedm,
   ced,
   dedm,
   ded,
   q3_mtrsn,
   q3_kc,
   q3m,
   q3,
   aq3m,
   aq3,
   bq3m,
   bq3,
   cq3m,
   cq3,
   dq3m,
   dq3,
   q2_mtrsn,
   q2_kc,
   q2m,
   q2,
   aq2m,
   aq2,
   bq2m,
   bq2,
   cq2m,
   cq2,
   dq2m,
   dq2,
   q4_mtrsn,
   q4_kc,
   q4m,
   q4,
   aq4m,
   aq4,
   bq4m,
   bq4,
   cq4m,
   cq4,
   dq4m,
   dq4 )
AS
SELECT
    MID,
    DATE_TIME,
    VALID,
    SOURCE,
    REMARK,
    ER_MTRSN,
    ER_KC,
    ERM,
    ER,
    AERM,
    AER,
    BERM,
    BER,
    CERM,
    CER,
    DERM,
    DER,
    Q1_MTRSN,
    Q1_KC,
    Q1M,
    Q1,
    AQ1M,
    AQ1,
    BQ1M,
    BQ1,
    CQ1M,
    CQ1,
    DQ1M,
    DQ1,
    ED_MTRSN,
    ED_KC,
    EDM,
    ED,
    AEDM,
    AED,
    BEDM,
    BED,
    CEDM,
    CED,
    DEDM,
    DED,
    Q3_MTRSN,
    Q3_KC,
    Q3M,
    Q3,
    AQ3M,
    AQ3,
    BQ3M,
    BQ3,
    CQ3M,
    CQ3,
    DQ3M,
    DQ3,
    Q2_MTRSN,
    Q2_KC,
    Q2M,
    Q2,
    AQ2M,
    AQ2,
    BQ2M,
    BQ2,
    CQ2M,
    CQ2,
    DQ2M,
    DQ2,
    Q4_MTRSN,
    Q4_KC,
    Q4M,
    Q4,
    AQ4M,
    AQ4,
    BQ4M,
    BQ4,
    CQ4M,
    CQ4,
    DQ4M,
    DQ4
 FROM RYDA.MONTHSORG
/

-- End of DDL script for MONTHSEVID

-- Start of DDL script for PROFILEEVID
-- Generated 5-янв-03  2:11:45 pm
-- from oe-RYDA:1

-- View PROFILEEVID

CREATE OR REPLACE VIEW profileevid (
   mid,
   date_time,
   er,
   q1,
   ed,
   q3,
   q2,
   q4,
   freq,
   cosf,
   volt,
   currento,
   volt2,
   volt3,
   curr2,
   curr3,
   erm,
   q1m,
   edm,
   q3m,
   q2m,
   q4m )
AS
SELECT
    MID,
    DATE_TIME,
    ER,
    Q1,
    ED,
    Q3,
    Q2,
    Q4,
    FREQ,
    COSF,
    VOLT,
    CURRENTO,
    VOLT2,
    VOLT3,
    CURR2,
    CURR3,
    ERM,
    Q1M,
    EDM,
    Q3M,
    Q2M,
    Q4M
 FROM RYDA.PROFILE
/

-- End of DDL script for PROFILEEVID




-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     08.01.2003  14:17
-- ============================================================
/* --Только ХЭС
rename MAKETFORMULAS to MAKETFORMULAS_TMP
/
*/
-- ============================================================
--   Table: MAKETFORMULAS
-- ============================================================
create table MAKETFORMULAS
(
    NGROUP     NUMBER(10)             not null,
    NSUBGROUP  NUMBER(10)             not null,
    NSIGN      NUMBER(1)              default 1 not null,
    constraint MAKETFORMULAS_PK primary key (NGROUP, NSUBGROUP)
)
/

comment on table MAKETFORMULAS is 'Вычисляемые группы в макете'
/

comment on column MAKETFORMULAS.NGROUP is 'Ид группы'
/

comment on column MAKETFORMULAS.NSUBGROUP is 'Ид подгруппы'
/

comment on column MAKETFORMULAS.NSIGN is 'Знак'
/

/* --Только ХЭС
insert into MAKETFORMULAS
select g1.ngroup,g2.ngroup,f.NSIGN from MAKETFORMULAS_TMP f,maketgroups g1,maketgroups g2
where f.NMAKET=1060 and g1.NMAKET=1060 and g2.NMAKET=1060 and f.GROUPCODE=g1.vcode and f.SUBGROUPCODE=g2.vcode
/

drop table MAKETFORMULAS_TMP
/
*/

-- ============================================================
--   Index: MAKETFORMULAS_IDX1
-- ============================================================
create index MAKETFORMULAS_IDX1 on MAKETFORMULAS (NSUBGROUP asc)
/

alter table MAKETFORMULAS
    add constraint MAKETFORMULAS_F1 foreign key  (NGROUP)
       references MAKETGROUPS (NGROUP) on delete cascade
/

alter table MAKETFORMULAS
    add constraint MAKETFORMULAS_F2 foreign key  (NSUBGROUP)
       references MAKETGROUPS (NGROUP) on delete cascade
/

CREATE GLOBAL TEMPORARY TABLE makettemp
 (
  ngroup                  NUMBER(10),
  nsubgroup               NUMBER(10),
  nsign                   NUMBER default 1 NOT NULL ,
  constraint makettemp_PK primary key (ngroup, nsubgroup)
 )
 ON COMMIT PRESERVE ROWS
 ORGANIZATION HEAP
 CACHE
/
create index makettemp_IDX1 on makettemp(NSUBGROUP asc)
/
COMMENT ON TABLE makettemp IS 'Вспомогательная для 30817 1'
/
COMMENT ON COLUMN makettemp.ngroup IS 'Группа суммирующая'
/
COMMENT ON COLUMN makettemp.nsubgroup IS 'Подгруппа'
/
COMMENT ON COLUMN makettemp.nsign IS 'Коеф вхождения'
/

CREATE GLOBAL TEMPORARY TABLE m30817
 (
  ngroup                     NUMBER,
  hour                       NUMBER,
  kwh                        NUMBER,
  err                        NUMBER,
  constraint m30817_PK primary key (ngroup, hour)
 )
 ON COMMIT PRESERVE ROWS
 ORGANIZATION HEAP
 CACHE
/
COMMENT ON TABLE m30817 IS 'Вспомогательная для 30817 2'
/
COMMENT ON COLUMN m30817.ngroup IS 'Группа'
/
COMMENT ON COLUMN m30817.hour IS 'Час'
/
COMMENT ON COLUMN m30817.kwh IS 'Расход'
/
COMMENT ON COLUMN m30817.err IS 'Ошибка округления'
/

-- End of DDL script for M30817





-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     10.01.2003  11:42
-- ============================================================

-- ============================================================
--   Table: PARALLELCONNECTION
-- ============================================================
create table PARALLELCONNECTION
(
    NPARALLELCONNECTION  NUMBER(10)             not null,
    VUSETYPE             VARCHAR2(1)            default 'С' not null
        constraint CKC_VUSETYPE_SSPARALL check (
            VUSETYPE in ('C','W')),
    constraint PK_PARALLELCONNECTION primary key (NPARALLELCONNECTION)
)
/

comment on table PARALLELCONNECTION is 'Параллельное присоединение'
/

comment on column PARALLELCONNECTION.NPARALLELCONNECTION is 'NPARALLELCONNECTION'
/

comment on column PARALLELCONNECTION.VUSETYPE is 'VUSETYPE'
/


-- ============================================================
--   Table: CONNECTIONPARAM
-- ============================================================
create table CONNECTIONPARAM
(
    NCONNECTIONPARAM     NUMBER(10)             not null,
    MID                  NUMBER                 not null,
    VNAME                VARCHAR2(128)          null    ,
    NSN                  NUMBER                 null    ,
    NSH                  NUMBER                 null    ,
    NDELTAPIDLING        NUMBER                 null    ,
    NDELTAPSC            NUMBER                 null    ,
    NIIDLING             NUMBER                 null    ,
    NUSC                 NUMBER                 null    ,
    NRO                  NUMBER                 null    ,
    NXO                  NUMBER                 null    ,
    NL                   NUMBER                 null    ,
    NUN                  NUMBER                 null    ,
    NENERGYPERCENT       NUMBER(3)              default 100 null
        constraint CKC_NENERGYPERCENT_SSCONNEC check (
            NENERGYPERCENT is null or (NENERGYPERCENT between -100 and 100)),
    NWORKINGHOURS        NUMBER(3)              null
        constraint CKC_NWORKINGHOURS_SSCONNEC check (
            NWORKINGHOURS is null or (NWORKINGHOURS between 0 and 744)),
    NFULLHOURS           NUMBER(3)              null
        constraint CKC_NFULLHOURS_SSCONNEC check (
            NFULLHOURS is null or (NFULLHOURS between 0 and 744)),
    NNOTINCLUDECONSUMP   NUMBER(1)              default 0 not null
        constraint CKC_NNOTINCLUDECONSUM_SSCONNEC check (
            NNOTINCLUDECONSUMP in (1,0)),
    NPARALLELCONNECTION  NUMBER(10)             null    ,
    constraint PK_CONNECTIONPARAM primary key (NCONNECTIONPARAM)
)
/

comment on table     CONNECTIONPARAM                 is 'Парам присоединения'
/

comment on column     CONNECTIONPARAM                .NCONNECTIONPARAM is 'NCONNECTIONPARAM'
/

comment on column     CONNECTIONPARAM                .MID is 'Ид точки'
/

comment on column     CONNECTIONPARAM                .VNAME is 'VNAME'
/

comment on column     CONNECTIONPARAM                .NSN is 'NSN'
/

comment on column     CONNECTIONPARAM                .NSH is 'NSH'
/

comment on column     CONNECTIONPARAM                .NDELTAPIDLING is 'NDELTAPIDLING'
/

comment on column     CONNECTIONPARAM                .NDELTAPSC is 'NDELTAPSC'
/

comment on column     CONNECTIONPARAM                .NIIDLING is 'NIIDLING'
/

comment on column     CONNECTIONPARAM                .NUSC is 'Uкз% /'
/

comment on column     CONNECTIONPARAM                .NRO is 'NRO'
/

comment on column     CONNECTIONPARAM                .NXO is 'NXO'
/

comment on column     CONNECTIONPARAM                .NL is 'NL'
/

comment on column     CONNECTIONPARAM                .NUN is 'NUN'
/

comment on column     CONNECTIONPARAM                .NENERGYPERCENT is 'NENERGYPERCENT'
/

comment on column     CONNECTIONPARAM                .NWORKINGHOURS is 'NWORKINGHOURS'
/

comment on column     CONNECTIONPARAM                .NFULLHOURS is 'NFULLHOURS'
/

comment on column     CONNECTIONPARAM                .NNOTINCLUDECONSUMP is 'NNOTINCLUDECONSUMP'
/

comment on column     CONNECTIONPARAM                .NPARALLELCONNECTION is 'NPARALLELCONNECTION'
/


-- ============================================================
--   Index: CONNECTIONPARAM_IDX1
-- ============================================================
create index CONNECTIONPARAM_IDX1 on CONNECTIONPARAM (NPARALLELCONNECTION asc)
/

-- ============================================================
--   Table: FEEDERS
-- ============================================================
alter table FEEDERS add
(
    NWORKINGHOURS        NUMBER(3)              null    ,
    NFULLHOURS           NUMBER(3)              null
)
/

comment on column FEEDERS.NWORKINGHOURS is 'Часы работы'
/

comment on column FEEDERS.NFULLHOURS is 'Полные часы работы'
/


-- ============================================================
--   Table: POINTFULLHOURS
-- ============================================================
create table POINTFULLHOURS
(
    MID                  NUMBER                 not null,
    NACCPERIOD           NUMBER(6)              not null,
    NFULLHOURS           NUMBER(3)              null    ,
    NWORKINGHOURS        NUMBER(3)              null    ,
    constraint PK_SSPOINTFULLHOURS primary key (MID, NACCPERIOD),
    constraint SSPOINTFULLHOURS_CK check (
            (NFULLHOURS IS NULL OR NFULLHOURS BETWEEN 0 AND (LAST_DAY(TO_DATE(NACCPERIOD,'YYYYMM'))-TO_DATE(NACCPERIOD,'YYYYMM')+1)*24) AND (NWORKINGHOURS IS NULL OR NWORKINGHOURS BETWEEN 0 AND (LAST_DAY(TO_DATE(NACCPERIOD,'YYYYMM'))-TO_DATE(NACCPERIOD,'YYYYMM')+1)*24) AND NWORKINGHOURS <= NFULLHOURS)
)
/

comment on table     POINTFULLHOURS                  is 'Время работы точки учета'
/

comment on column     POINTFULLHOURS                 .MID is 'Ид точки'
/

comment on column     POINTFULLHOURS                 .NACCPERIOD is 'NACCPERIOD'
/

comment on column     POINTFULLHOURS                 .NFULLHOURS is 'NFULLHOURS'
/

comment on column     POINTFULLHOURS                 .NWORKINGHOURS is 'NWORKINGHOURS'
/


-- ============================================================
--   Table: CONNECTIONPARAMFULLHOURS
-- ============================================================
create table CONNECTIONPARAMFULLHOURS
(
    NCONNECTIONPARAM     NUMBER(10)             not null,
    NACCPERIOD           NUMBER(6)              not null,
    NFULLHOURS           NUMBER(3)              null    ,
    NWORKINGHOURS        NUMBER(3)              null    ,
    constraint PK_CONNECTIONPARAMFULLHOURS primary key (NCONNECTIONPARAM, NACCPERIOD),
    constraint SSCONNECTIONPARAMFULLHOURS_CK check (
            (NFULLHOURS IS NULL OR NFULLHOURS BETWEEN 0 AND (LAST_DAY(TO_DATE(NACCPERIOD,'YYYYMM'))-TO_DATE(NACCPERIOD,'YYYYMM')+1)*24) AND (NWORKINGHOURS IS NULL OR NWORKINGHOURS BETWEEN 0 AND (LAST_DAY(TO_DATE(NACCPERIOD,'YYYYMM'))-TO_DATE(NACCPERIOD,'YYYYMM')+1)*24) AND NWORKINGHOURS <= NFULLHOURS)
)
/

comment on table     CONNECTIONPARAMFULLHOURS        is 'Время работы присоединения'
/

comment on column     CONNECTIONPARAMFULLHOURS       .NCONNECTIONPARAM is 'NCONNECTIONPARAM'
/

comment on column     CONNECTIONPARAMFULLHOURS       .NACCPERIOD is 'NACCPERIOD'
/

comment on column     CONNECTIONPARAMFULLHOURS       .NFULLHOURS is 'NFULLHOURS'
/

comment on column     CONNECTIONPARAMFULLHOURS       .NWORKINGHOURS is 'Кол часов работы в месяц /'
/


-- ============================================================
--   Table: SHAREDCONNECTIONPARAM
-- ============================================================
create table SHAREDCONNECTIONPARAM
(
    NCONNECTIONPARAM     NUMBER(10)             not null,
    MID                  NUMBER                 not null,
    NNOTINCLUDECONSUMP   NUMBER(1)              default 0 not null
        constraint CKC_NNOTINCLUDECONSUM_SSSHARED check (
            NNOTINCLUDECONSUMP in (1,0)),
    constraint PK_SHAREDCONNECTIONPARAM primary key (NCONNECTIONPARAM, MID)
)
/

comment on table     SHAREDCONNECTIONPARAM           is 'Парам присоединения долев потерь'
/

comment on column     SHAREDCONNECTIONPARAM          .NCONNECTIONPARAM is 'NCONNECTIONPARAM'
/

comment on column     SHAREDCONNECTIONPARAM          .MID is 'Ид точки'
/

comment on column     SHAREDCONNECTIONPARAM          .NNOTINCLUDECONSUMP is 'NNOTINCLUDECONSUMP'
/


-- ============================================================
--   Index: SHAREDCONNECTIONPARAM_IDX1
-- ============================================================
create index SHAREDCONNECTIONPARAM_IDX1 on SHAREDCONNECTIONPARAM (MID asc)
/

alter table CONNECTIONPARAM
    add constraint CONNECTIONPARAM_F2 foreign key  (NPARALLELCONNECTION)
       references PARALLELCONNECTION (NPARALLELCONNECTION)
/

alter table CONNECTIONPARAM
    add constraint CONNECTIONPARAM_F1 foreign key  (MID)
       references POINTS (MID) on delete cascade
/

alter table POINTFULLHOURS
    add constraint POINTFULLHOURS_F1 foreign key  (MID)
       references POINTS (MID) on delete cascade
/

alter table CONNECTIONPARAMFULLHOURS
    add constraint FK_SSCONNEC_R181060_SSCONNEC foreign key  (NCONNECTIONPARAM)
       references CONNECTIONPARAM (NCONNECTIONPARAM) on delete cascade
/

alter table SHAREDCONNECTIONPARAM
    add constraint FK_SSSHARED_R82801_SSCONNEC foreign key  (NCONNECTIONPARAM)
       references CONNECTIONPARAM (NCONNECTIONPARAM) on delete cascade
/

alter table SHAREDCONNECTIONPARAM
    add constraint SHAREDCONNECTIONPARAM_F1 foreign key  (MID)
       references POINTS (MID) on delete cascade
/

alter table FEEDERS add
(
    NWASTEPERCENTCALC  NUMBER(1)              default 0 not null
        constraint CKC_NWASTEPERCENTCALC_FEEDERS check (NWASTEPERCENTCALC in (0,1,2,3,4))
)
/

comment on column FEEDERS.NWASTEPERCENTCALC is 'Тип потерь'
/



-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     11.01.2003  18:07
-- ============================================================

-- ============================================================
--   Table: CHECK_RESULTS
-- ============================================================
create table CHECK_RESULTS
(
    NPROCEDURE  NUMBER(10)             not null,
    DDATE       DATE                   not null,
    MID         NUMBER                 not null,
    VPARAM      VARCHAR2(2000)         null    ,
    NMUSTBE     NUMBER                 null    ,
    NINDEED     NUMBER                 null    ,
    constraint CHECK_RESULTS_PK primary key (NPROCEDURE, DDATE, MID)
)
/

comment on table CHECK_RESULTS is 'Результаты верификации'
/

comment on column CHECK_RESULTS.NPROCEDURE is 'Ид процедуры'
/

comment on column CHECK_RESULTS.DDATE is 'Дата'
/

comment on column CHECK_RESULTS.MID is 'Точка учета'
/

comment on column CHECK_RESULTS.VPARAM is 'Параметр'
/

comment on column CHECK_RESULTS.NMUSTBE is 'Первое значение'
/

comment on column CHECK_RESULTS.NINDEED is 'Второе значение'
/


-- ============================================================
--   Index: CHECK_RESULTS_IDX1
-- ============================================================
create index CHECK_RESULTS_IDX1 on CHECK_RESULTS (DDATE asc)
/

-- ============================================================
--   Index: CHECK_RESULTS_IDX2
-- ============================================================
create index CHECK_RESULTS_IDX2 on CHECK_RESULTS (MID asc)
/

alter table CHECK_RESULTS
    add constraint CHECK_RESULTS_F1 foreign key  (NPROCEDURE)
       references DEPORTPROCEDURES (NPROCEDURE) on delete cascade
/

alter table CHECK_RESULTS
    add constraint CHECK_RESULTS_F2 foreign key  (MID)
       references POINTS (MID) on delete cascade
/






-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     26.01.2003  18:43
-- ============================================================

-- ============================================================
--   Table: HALFHOUROLD
-- ============================================================
alter table HALFHOUROLD add
(
    DCLOSED      DATE                   null
)
/

comment on column HALFHOUROLD.DCLOSED is 'Дата закрытия суток'
/

-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     27.01.2003  10:36
-- ============================================================

-- ============================================================
--   Table: CHECK_STATUS
-- ============================================================
create table CHECK_STATUS
(
    NPROCEDURE  NUMBER(10)             not null,
    DDATE       DATE                   not null,
    VTEXT       VARCHAR2(500)          not null,
    constraint CHECK_STATUS_PK primary key (NPROCEDURE, DDATE)
)
/

comment on table CHECK_STATUS is 'Результаты несостоявшихся верификаций'
/

comment on column CHECK_STATUS.NPROCEDURE is 'Ид процедуры'
/

comment on column CHECK_STATUS.DDATE is 'Период верификации'
/

comment on column CHECK_STATUS.VTEXT is 'Результат верификации'
/


-- ============================================================
--   Index: CHECK_STATUS_IDX1
-- ============================================================
create index CHECK_STATUS_IDX1 on CHECK_STATUS (DDATE asc)
/

alter table CHECK_STATUS
    add constraint CHECK_STATUS_F1 foreign key  (NPROCEDURE)
       references DEPORTPROCEDURES (NPROCEDURE) on delete cascade
/



----29/01/2003
drop INDEX maketgroups_idx1
/
CREATE  UNIQUE INDEX maketgroups_idx1
 ON maketgroups
  ( vname,
    nmaket)
/


-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     10.02.2003  12:01
-- ============================================================
alter table DB_TERM add
(
    NARCHIVED      NUMBER(1)              default 0 not null
        constraint CKC_NARCHIVED_DB_TERM check (NARCHIVED in (0,1)),
    VINDIC_COLUMN  VARCHAR2(50)           default 'date_time' not null,
    VEXTENTION     VARCHAR2(20)           default '000' not null
)
/

comment on table DB_TERM is 'Контроль объема БД'
/

comment on column DB_TERM.TABLE_NAME is 'Название таблицы'
/

comment on column DB_TERM.DATA_NAME is 'Комментарий'
/

comment on column DB_TERM.TERM is 'Срок хранения'
/

comment on column DB_TERM.NARCHIVED is 'Признак архивации'
/

comment on column DB_TERM.VINDIC_COLUMN is 'Определяющая колонка'
/

comment on column DB_TERM.VEXTENTION is 'Расширение файла'
/
-- ============================================================
--   Index: DB_TERM_IDX1
-- ============================================================
create unique index DB_TERM_IDX1 on DB_TERM (VEXTENTION asc)
/
-- ============================================================
--   Index: TRAFFIC_IDX1
-- ============================================================
create index TRAFFIC_IDX1 on TRAFFIC (DOPEN asc)
/





-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     12.02.2003  18:47
-- ============================================================

-- ============================================================
--   Table: TARIFF
-- ============================================================
create table TARIFF
(
    DSTART  DATE                   not null,
    NVALUE  NUMBER                 not null,
    constraint TARIFF_PK primary key (DSTART)
)
/

comment on table TARIFF is 'Тарифы UMS'
/

comment on column TARIFF.DSTART is 'Дата начала'
/

comment on column TARIFF.NVALUE is 'Значение'
/


-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     12.02.2003  19:29
-- ============================================================

-- ============================================================
--   Table: COMPORTTYPE
-- ============================================================
create table COMPORTTYPE
(
    NCOMTYPE    NUMBER(10)             not null,
    VNAME       VARCHAR2(128)          not null,
    constraint COMPORTTYPE_PK primary key (NCOMTYPE)
)
/

comment on table COMPORTTYPE is 'Типы соединения'
/

comment on column COMPORTTYPE.NCOMTYPE is 'Ид типа соединения'
/

comment on column COMPORTTYPE.VNAME is 'Название типа'
/


-- ============================================================
--   Index: COMPORTTYPE_IDX1
-- ============================================================
create unique index COMPORTTYPE_IDX1 on COMPORTTYPE (VNAME asc)
/



INSERT INTO COMPORTTYPE
(NCOMTYPE,VNAME)
VALUES
(1,'Стандартное соединение')
/
INSERT INTO COMPORTTYPE
(NCOMTYPE,VNAME)
VALUES
(2,'Соединение по каналам связи телемеханики')
/
INSERT INTO COMPORTTYPE
(NCOMTYPE,VNAME)
VALUES
(3,'Стандартный коммутируемый модем')
/
INSERT INTO COMPORTTYPE
(NCOMTYPE,VNAME)
VALUES
(4,'GSM терминал')
/
INSERT INTO COMPORTTYPE
(NCOMTYPE,VNAME)
VALUES
(5,'GSM терминал с управлением питанием')
/
INSERT INTO COMPORTTYPE
(NCOMTYPE,VNAME)
VALUES
(6,'Радиостанция типа LG')
/
INSERT INTO COMPORTTYPE
(NCOMTYPE,VNAME)
VALUES
(7,'Соединение по спутниковому каналу ')
/

-- ============================================================
--   Table: COMPORTS
-- ============================================================
alter table COMPORTS add
(
    NCOMTYPE    NUMBER(10) DEFAULT 1 NOT NULL
)
/

comment on table COMPORTS is 'Ком порты'
/

comment on column COMPORTS.COM_ID is 'Ид компорта'
/

comment on column COMPORTS.NAME is 'Название'
/

comment on column COMPORTS.BAUDRATE is 'Скорость'
/

comment on column COMPORTS.BYTESIZE is 'Разрядность'
/

comment on column COMPORTS.PARITY is 'Контроль четности'
/

comment on column COMPORTS.STOPBITS is 'Кол стоповых бит'
/

comment on column COMPORTS.DLASTEVENT is 'Дата посл события'
/

comment on column COMPORTS.VLASTEVENT is 'Последнее событие'
/

comment on column COMPORTS.NCOMTYPE is 'Ид типа соединения'
/


-- ============================================================
--   Index: COMPORTS_IDX1
-- ============================================================
create index COMPORTS_IDX1 on COMPORTS (NCOMTYPE asc)
/

alter table COMPORTS
    add constraint COMPORTS_F1 foreign key  (NCOMTYPE)
       references COMPORTTYPE (NCOMTYPE)
/






---24.02.2003
comment on table CONNECTIONPARAM is 'Парам присоединения'
/

comment on column CONNECTIONPARAM.NCONNECTIONPARAM is 'Ид параметра'
/

comment on column CONNECTIONPARAM.MID is 'Ид точки'
/

comment on column CONNECTIONPARAM.VNAME is 'Название'
/

comment on column CONNECTIONPARAM.NSN is 'NSN'
/

comment on column CONNECTIONPARAM.NSH is 'NSH'
/

comment on column CONNECTIONPARAM.NDELTAPIDLING is 'NDELTAPIDLING'
/

comment on column CONNECTIONPARAM.NDELTAPSC is 'NDELTAPSC'
/

comment on column CONNECTIONPARAM.NIIDLING is 'NIIDLING'
/

comment on column CONNECTIONPARAM.NUSC is 'Uкз% /'
/

comment on column CONNECTIONPARAM.NRO is 'NRO'
/

comment on column CONNECTIONPARAM.NXO is 'NXO'
/

comment on column CONNECTIONPARAM.NL is 'NL'
/

comment on column CONNECTIONPARAM.NUN is 'NUN'
/

comment on column CONNECTIONPARAM.NENERGYPERCENT is 'Процент вхождения'
/

comment on column CONNECTIONPARAM.NWORKINGHOURS is 'Время работы'
/

comment on column CONNECTIONPARAM.NFULLHOURS is 'Полное время'
/

comment on column CONNECTIONPARAM.NNOTINCLUDECONSUMP is 'Расход не учитывать'
/

comment on column CONNECTIONPARAM.NPARALLELCONNECTION is 'Паралельное соединение'
/





-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     25.02.2003  12:19
-- ============================================================
alter table DEPORTFILES add
(
    NATTACH       NUMBER(1)              default 0 not null
        constraint CKC_NATTACH_DEPORTFI check (NATTACH in (0,1))
)
/

comment on column DEPORTFILES.NATTACH is 'Отсылка отдельным файлом'
/

alter table DEPORTATION add
(
    VPARAM         VARCHAR2(2000)         null
)
/

comment on column DEPORTATION.VPARAM is 'Параметры отсылки'
/








-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     26.02.2003  11:19
-- ============================================================
alter table MAN_INP_HHOUR
    drop constraint FK_MAN_INP__REF_24505_POINTS
/

alter table MAN_INP_HHOUR
    add constraint FK_MAN_INP__REF_24505_POINTS foreign key  (MID)
       references POINTS (MID) on delete cascade
/






-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     27.02.2003  10:25
-- ============================================================
create table RECOMPENS
(
    NRECOMPENS         NUMBER(10)             not null,
    VNAME              VARCHAR2(64)           not null,
    NRATIO             NUMBER                 not null,
    constraint RECOMPENS_PK primary key (NRECOMPENS)
)
/

comment on table RECOMPENS is 'Расчет реактива для потерь'
/

comment on column RECOMPENS.NRECOMPENS is 'Ид типа расч реакт'
/

comment on column RECOMPENS.VNAME is 'Название'
/

comment on column RECOMPENS.NRATIO is 'Значение'
/

INSERT INTO RECOMPENS
(NRECOMPENS,VNAME,NRATIO)
VALUES
(1,'Пром потребители ',to_number('0.8','9.9'))
/
INSERT INTO RECOMPENS
(NRECOMPENS,VNAME,NRATIO)
VALUES
(2,'Тяг п/ст ж/д пер тока',1)
/
INSERT INTO RECOMPENS
(NRECOMPENS,VNAME,NRATIO)
VALUES
(3,'Тяг п/ст ж/д пост тока',to_number('0.5','9.9'))
/
INSERT INTO RECOMPENS
(NRECOMPENS,VNAME,NRATIO)
VALUES
(4,'Непром потребители',to_number('0.6','9.9'))
/

alter table FEEDERS add
(
    NRECOMPENS         NUMBER(10)
)
/

comment on column FEEDERS.NRECOMPENS is 'Ид типа расч реакт'
/

create index FEEDERS_IDX1 on FEEDERS (NRECOMPENS asc)
/

alter table FEEDERS
    add constraint FEEDERS_F1 foreign key  (NRECOMPENS)
       references RECOMPENS (NRECOMPENS)
/




-- Start of DDL Script for Table RYDA.ROUND_ERRORS
-- Generated 14-мар-2003 16:06:26 from RYDA@ems
CREATE TABLE round_errors
    (mid                            NUMBER NOT NULL,
    nsource                        NUMBER NOT NULL,
    er                             NUMBER,
    ed                             NUMBER,
    q1                             NUMBER,
    q2                             NUMBER,
    q3                             NUMBER,
    q4                             NUMBER
  ,
  CONSTRAINT PK_ROUND_ERRORS
  PRIMARY KEY (mid, nsource))
  ORGANIZATION INDEX
/

alter table round_errors
    add constraint round_errors_F1 foreign key  (MID)
       references POINTS (MID) on delete cascade
/

-- End of DDL Script for Table RYDA.ROUND_ERRORS




-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     29.03.2003  14:16
-- ============================================================

-- ============================================================
--   Table: MAKET30817
-- ============================================================
create table MAKET30817
(
    DDATE   DATE                   not null,
    NGROUP  NUMBER(10)             not null,
    HOUR    NUMBER(2)              not null,
    KWH     NUMBER                 null    ,
    ERR     NUMBER                 null    ,
    constraint MAKET30817_PK primary key (DDATE, NGROUP, HOUR)
)
/

comment on table MAKET30817 is 'Результаты расчетов М30817'
/

comment on column MAKET30817.DDATE is 'Отчетная дата'
/

comment on column MAKET30817.NGROUP is 'Группа'
/

comment on column MAKET30817.HOUR is 'Час'
/

comment on column MAKET30817.KWH is 'Расход'
/

comment on column MAKET30817.ERR is 'Ошибка округления'
/


-- ============================================================
--   Index: MAKET30817_IDX1
-- ============================================================
create index MAKET30817_IDX1 on MAKET30817 (ERR asc)
/

alter table MAKET30817
    add constraint MAKET30817_F1 foreign key  (NGROUP)
       references MAKETGROUPS (NGROUP) on delete cascade
/




--12.03.2003
grant execute on POINTCALC_PG to askuerep
/



-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     14.04.2003  19:34
-- ============================================================
-- ============================================================
--   Index: FORM_TEMPLATES_IDX2
-- ============================================================
create unique index FORM_TEMPLATES_IDX2 on FORM_TEMPLATES (CODETEMPLATE asc)
/



-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     17.04.2003  11:16
-- ============================================================
alter table HALFHOUROLD add
(
    NKC        NUMBER                 null
)
/
update HALFHOUROLD h set nkc=(select KC from feeders where mid=h.mid)
/
comment on column HALFHOUROLD.NKC is 'Коеф счетчика'
/
begin
for lc in (select mid,KC from feeders) loop
update bill set er_kc=lc.kc,ed_kc=lc.kc,q1_kc=lc.kc,q3_kc=lc.kc where mid=lc.mid;
commit;
end loop;
end;
/
drop PROCEDURE addindic_p
/
drop  PROCEDURE gethalfhour_p
/
drop  PROCEDURE cleantables
/
drop  PROCEDURE ov_switching
/
drop  PROCEDURE reteit
/
drop  PROCEDURE reteher
/
drop  PROCEDURE replicator
/
drop  PROCEDURE arround_m3017
/

update form_templates set COMMENTFORM='Активная мощность [МВт]' where CODETEMPLATE=10;
update form_templates set COMMENTFORM='Реактивная мощность [МВАр]' where CODETEMPLATE=20;
update form_templates set COMMENTFORM='Мощность, лимит, отклонение [МВт]' where CODETEMPLATE=30;
update form_templates set COMMENTFORM='Мощность, лимит, отклонение [МВАр]' where CODETEMPLATE=40;
update form_templates set COMMENTFORM='Текущая нагрузка [МВт/МВАр]' where CODETEMPLATE=50;
update form_templates set COMMENTFORM='Контроль лимитов' where CODETEMPLATE=51;
update form_templates set COMMENTFORM='Текущая нагрузка [МВт/МВАр]' where CODETEMPLATE=52;
update form_templates set COMMENTFORM='Контроль лимитов' where CODETEMPLATE=53;
update form_templates set COMMENTFORM='Контроль потребителей' where CODETEMPLATE=54;
update form_templates set COMMENTFORM='Контроль потребителей' where CODETEMPLATE=55;
update form_templates set COMMENTFORM='Контроль потребителей-должников' where CODETEMPLATE=56;
update form_templates set COMMENTFORM='Контроль потребителей-должников' where CODETEMPLATE=57;
update form_templates set COMMENTFORM='Контроль потребителей-перерасходчиков' where CODETEMPLATE=58;
update form_templates set COMMENTFORM='Контроль потребителей-перерасходчиков' where CODETEMPLATE=59;
update form_templates set COMMENTFORM='Контроль не поступления данных' where CODETEMPLATE=60;
update form_templates set COMMENTFORM='Контроль не поступления данных (Ч\Б)' where CODETEMPLATE=61;
update form_templates set COMMENTFORM='Контроль потребителей' where CODETEMPLATE=62;
update form_templates set COMMENTFORM='Небалансы энергобъектов' where CODETEMPLATE=63;
update form_templates set COMMENTFORM='Небалансы энергобъектов' where CODETEMPLATE=64;
update form_templates set COMMENTFORM='Переток Активной ; Реактивной энергии [тыс.кВтч/тыс.кВАрч]' where CODETEMPLATE=100;
update form_templates set COMMENTFORM='Переток Активной ; Реактивной энергии [тыс.кВтч/тыс.кВАрч]' where CODETEMPLATE=101;
update form_templates set COMMENTFORM='Переток Активной ; Реактивной энергии [тыс.кВтч/тыс.кВАрч]' where CODETEMPLATE=102;
update form_templates set COMMENTFORM='Приём ; Отдача Активной энергии [тыс.кВтч]' where CODETEMPLATE=200;
update form_templates set COMMENTFORM='Приём ; Отдача Активной энергии [тыс.кВтч]' where CODETEMPLATE=201;
update form_templates set COMMENTFORM='Приём ; Отдача Активной энергии [тыс.кВтч]' where CODETEMPLATE=202;
update form_templates set COMMENTFORM='Приём ; Отдача Реактивной энергии [тыс.кВАрч]' where CODETEMPLATE=300;
update form_templates set COMMENTFORM='Приём ; Отдача Реактивной энергии [тыс.кВАрч]' where CODETEMPLATE=301;
update form_templates set COMMENTFORM='Приём ; Отдача Реактивной энергии [тыс.кВАрч]' where CODETEMPLATE=302;
update form_templates set COMMENTFORM='Приём ; Отдача Реактивной энергии при импорте активной энергии [тыс.кВАрч]' where CODETEMPLATE=310;
update form_templates set COMMENTFORM='Приём ; Отдача Реактивной энергии при импорте активной энергии[тыс.кВАрч]' where CODETEMPLATE=311;
update form_templates set COMMENTFORM='Приём ; Отдача Реактивной энергии при экспорте активной энергии [тыс.кВАрч]' where CODETEMPLATE=320;
update form_templates set COMMENTFORM='Приём ; Отдача Реактивной энергии при экспорте активной энергии [тыс.кВАрч]' where CODETEMPLATE=321;
update form_templates set COMMENTFORM='Переток Активной энергии [тыс.кВтч]' where CODETEMPLATE=400;
update form_templates set COMMENTFORM='Переток Активной энергии [тыс.кВтч]' where CODETEMPLATE=401;
update form_templates set COMMENTFORM='Переток Активной энергии [тыс.кВтч]' where CODETEMPLATE=402;
update form_templates set COMMENTFORM='Приём Активной энергии [тыс.кВтч]' where CODETEMPLATE=500;
update form_templates set COMMENTFORM='Приём Активной энергии [тыс.кВтч]' where CODETEMPLATE=501;
update form_templates set COMMENTFORM='Приём Активной энергии [тыс.кВтч]' where CODETEMPLATE=502;
update form_templates set COMMENTFORM='Отдача Активной энергии [тыс.кВтч]' where CODETEMPLATE=600;
update form_templates set COMMENTFORM='Отдача Активной энергии [тыс.кВтч]' where CODETEMPLATE=601;
update form_templates set COMMENTFORM='Отдача Активной энергии [тыс.кВтч]' where CODETEMPLATE=602;
update form_templates set COMMENTFORM='Переток Реактивной энергии [тыс.кВАрч]' where CODETEMPLATE=700;
update form_templates set COMMENTFORM='Переток Реактивной энергии [тыс.кВАрч]' where CODETEMPLATE=701;
update form_templates set COMMENTFORM='Переток Реактивной энергии [тыс.кВАрч]' where CODETEMPLATE=702;
update form_templates set COMMENTFORM='Приём Реактивной энергии [тыс.кВАрч]' where CODETEMPLATE=800;
update form_templates set COMMENTFORM='Приём Реактивной энергии [тыс.кВАрч]' where CODETEMPLATE=801;
update form_templates set COMMENTFORM='Приём Реактивной энергии [тыс.кВАрч]' where CODETEMPLATE=802;
update form_templates set COMMENTFORM='Отдача реактивной энергии [тыс.кВАрч]' where CODETEMPLATE=900;
update form_templates set COMMENTFORM='Отдача реактивной энергии [тыс.кВАрч]' where CODETEMPLATE=901;
update form_templates set COMMENTFORM='Отдача реактивной энергии [тыс.кВАрч]' where CODETEMPLATE=902;
update form_templates set COMMENTFORM='Активная принятая общая и по тарифам [тыс.кВтч]' where CODETEMPLATE=910;
update form_templates set COMMENTFORM='Активная отданная общая и по тарифам [тыс.кВтч]' where CODETEMPLATE=920;
update form_templates set COMMENTFORM='Переток активной э/э (общая и по тарифам) [тыс.кВтч]' where CODETEMPLATE=921;
update form_templates set COMMENTFORM='Реактивная принятая общая и по тарифам [тыс.кВАрч]' where CODETEMPLATE=930;
update form_templates set COMMENTFORM='Реактивная отданная общая и по тарифам [тыс.кВАрч]' where CODETEMPLATE=940;
update form_templates set COMMENTFORM='Переток реактивной э/э (общая и по тарифам) [тыс.кВарч]' where CODETEMPLATE=941;
update form_templates set COMMENTFORM='Активная принятая по тарифам [тыс.кВтч]' where CODETEMPLATE=950;
update form_templates set COMMENTFORM='Активная отданная по тарифам [тыс.кВтч]' where CODETEMPLATE=960;
update form_templates set COMMENTFORM='Реактивная принятая по тарифам [тыс.кВАрч]' where CODETEMPLATE=970;
update form_templates set COMMENTFORM='Реактивная отданная по тарифам [тыс.кВАрч]' where CODETEMPLATE=980;
update form_templates set COMMENTFORM='Журнал действий оператора' where CODETEMPLATE=1000;
update form_templates set COMMENTFORM='Журнал сообщений системы' where CODETEMPLATE=1100;
update form_templates set COMMENTFORM=' ' where CODETEMPLATE=1200;
update form_templates set COMMENTFORM=' ' where CODETEMPLATE=1201;
update form_templates set COMMENTFORM=' ' where CODETEMPLATE=1202;
update form_templates set COMMENTFORM='' where CODETEMPLATE=1203;
update form_templates set COMMENTFORM='Приём Активной энергии [тыс.кВтч]' where CODETEMPLATE=1400;
update form_templates set COMMENTFORM='Переток Активной энергии [тыс.кВтч]' where CODETEMPLATE=1410;
commit;
update forms f set COMMENTFORM=(select max(COMMENTFORM) from form_templates where CODETEMPLATE=f.CODETEMPLATE);
commit;
-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     20.04.2003  11:41
-- ============================================================
-- ============================================================
--   Index: ROLES_IDX3
-- ============================================================
create unique index ROLES_IDX3 on ROLES (NAME asc)
/



--21.04.2003
grant execute on sys.dbms_lock to ryda
/

GRANT CREATE ANY TRIGGER TO ASKUEREP;
/
/*
CREATE OR REPLACE TRIGGER on_logon_to_work_schema
 AFTER
  LOGON
 ON SCHEMA
begin
    ryda.COMMON_PG.begin_p;
        EXCEPTION
           WHEN OTHERS THEN
           null;
end;
/
*/


-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     22.04.2003  16:38
-- ============================================================
ALTER TABLE RYDA.LGSTATUS MODIFY
(
   T                          DEFAULT 0,
   U                          DEFAULT 0,
   S                          DEFAULT 0,
   M                          DEFAULT 0,
   KT                         DEFAULT 0,
   L1                         DEFAULT 0,
   L2                         DEFAULT 0,
   L3                         DEFAULT 0)
/

alter table LGSTATUS add
(
    BT         NUMBER(1)              default 0 not null
        constraint CKC_BT_LGSTATUS check (BT in (0,1)),
    FE         NUMBER(1)              default 0 not null
        constraint CKC_FE_LGSTATUS check (FE in (0,1))
)
/

comment on column LGSTATUS.BT is 'Резерв питания'
/

comment on column LGSTATUS.FE is 'Фатальная ошибка'
/

 COMMENT ON COLUMN RYDA.LGSTATUS.BT IS
'Резерв питания календарных часов исчерпан'
/

 COMMENT ON COLUMN RYDA.LGSTATUS.FE IS
'Регистрация фатальной ошибки'
/



-------23/03/2003

update BILL set NWASTEABS=NULL
/

ALTER TABLE RYDA.BILL MODIFY
(
   NWASTEABS                  NULL)
/


update BILLorg set NWASTEABS=NULL
/

ALTER TABLE RYDA.BILLorg MODIFY
(
   NWASTEABS                  NULL)
/


update RYDA.monthsorg set NWASTEABS=NULL
/

ALTER TABLE RYDA.monthsorg MODIFY
(
   NWASTEABS                  NULL)
/


commit
/



------------------------------02.05.2003
 insert into deportprocedures (nprocedure, vname, vprocedure, nperiod, ntype, vmemo)
 values (22, 'Смена отчетного периода','ryda.das_pg.closeperiod', 2, 1, 'Расчет потерь, суточных, закрытие периода')
 /
 insert into deportprocedures (nprocedure, vname, vprocedure, nperiod, ntype, vmemo)
 values (23, 'Откат отчетного периода','ryda.das_pg.rollbackperiod', 2, 1, 'Откат на один период назад')
 /
 insert into makets (nmaket, nprocedure, vname, nblock, ncycle, nshift)
 values (900, 22, 'Смена отчетного периода', 1, 0, 480)
 /
 insert into makets (nmaket, nprocedure, vname, nblock, ncycle, nshift)
 values (901, 23, 'Откат отчетного периода', 1, 0, 0)
 /
commit
/


-- Start of DDL script for CALCPERIOD
-- Generated 27-май-03  11:38:26 am
-- from ems-RYDA:1

-- Table CALCPERIOD

CREATE TABLE calcperiod
 (
  ddate                      DATE
 )
/

COMMENT ON TABLE calcperiod IS 'Расчетные сутки'
/
COMMENT ON COLUMN calcperiod.ddate IS 'Текущие расчетные сутки. Только одна запись!'
/
insert into calcperiod (ddate) values (trunc(sysdate))
/


CREATE TABLE lagging_records
 (
  mid                        NUMBER NOT NULL,
  ddate                      DATE NOT NULL
 )
/
COMMENT ON TABLE lagging_records IS 'Журнал оставших получасовок'
/
COMMENT ON COLUMN lagging_records.mid IS 'Ид точки'
/
COMMENT ON COLUMN lagging_records.ddate IS 'Сутки, к которым относятся получасовки'
/
-- Constraints for LAGGING_RECORDS

ALTER TABLE lagging_records
 ADD CONSTRAINT lagging_records_pk PRIMARY KEY (mid,ddate)
/
ALTER TABLE RYDA.LAGGING_RECORDS
 ADD CONSTRAINT LAGGING_RECORD_FK
 FOREIGN KEY
 (MID
 )
 REFERENCES RYDA.POINTS
  (MID
 )
 ON DELETE CASCADE
/

DROP INDEX halfhour_idx3
/
drop snapshot log on ryda.bill
/
rename bill to billold
/
alter table billold add dclosed date
/
alter table billold add nexceptcalc number
/
COMMENT ON COLUMN billold.dclosed IS 'Дата отчетных суток, включивших запись'
/
COMMENT ON COLUMN billold.nexceptcalc IS 'Признак включения в расчет'
/

alter table billold drop constraint bill_pk
/
update billold set nsource = 50
/
alter table billold add constraint billold_pk primary key (mid, date_time, nsource)
/
create index billold_idx2 on billold (dclosed)
/
CREATE  INDEX halfhourold_idx4
 ON halfhourold
  ( dclosed  )
/





-- Start of DDL script for SLSTATUS
-- Generated 2-июн-03  12:22:33 pm
-- from ems-RYDA:1

-- Table SLSTATUS

CREATE TABLE slstatus
 (
  mid                        NUMBER NOT NULL,
  ddate                      DATE,
  status                     NUMBER
 )
/

-- Comments for SLSTATUS

COMMENT ON TABLE slstatus IS 'Текущий статус счетчиков SL'
/

-- Column Comments for SLSTATUS

COMMENT ON COLUMN slstatus.status IS 'Отрицательный код обозначает критическую ошибку, положительный - предупреждение, нулевой - OK'
/

-- Constraints for SLSTATUS

ALTER TABLE slstatus
 ADD CONSTRAINT slstatus_pk PRIMARY KEY (mid)
/



------------25.06.2003
alter table channels add nreread number
/
comment on column channels.nreread is 'Номер попытки пересчитывания Итека при расхождении данных'
/


ALTER TABLE RYDA.BILLOLD MODIFY
(
   NSOURCE                    DEFAULT 50)
/



-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     18.07.2003  09:54
-- ============================================================
alter table CHANNELS add
(
    NWAIT           NUMBER                 default 40 not null
)
/

comment on column CHANNELS.NWAIT is 'Время ожид уст соед сек'
/

-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     19.07.2003  12:37
-- ============================================================
alter table FEEDERS add
(
    NUSD               NUMBER                 null
)
/

comment on column FEEDERS.NUSD is 'УСД'
/

create index FEEDERS_IDX2 on FEEDERS (NUSD asc)
/

alter table FEEDERS
    add constraint FEEDERS_F3 foreign key  (NUSD)
       references FEEDERS (MID)
/

INSERT INTO db_term (DATA_NAME,TABLE_NAME,TERM,VINDIC_COLUMN,VEXTENTION) VALUES ('Протокол запуска фоновых процессов','JOBS',10,'DATE_TIME','jbs')
/

COMMIT
/

--21.07.2003
/*
-- Для КОЭ
INSERT INTO TASKS (TASK_ID,PARENT,TASK_COD,NAME,NUM_ARG,CHAR_ARG,REMARK)
VALUES (74,42,619,'1.9 Загрузка файлов данных счетчиков LG.',NULL,'','Загрузка файлов данных счетчиков LG')
/
*/


-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     06.08.2003  13:32
-- ============================================================

-- ============================================================
--   Table: CURR_POWER_ARCH
-- ============================================================
alter table CURR_POWER_ARCH add
(
    ERM        NUMBER                 null    ,
    EDM        NUMBER                 null    ,
    Q1M        NUMBER                 null    ,
    Q3M        NUMBER                 null    ,
    Q2         NUMBER                 null    ,
    Q4         NUMBER                 null    ,
    Q2M        NUMBER                 null    ,
    Q4M        NUMBER                 null
)
/

comment on table CURR_POWER_ARCH is 'Архив параметров сети'
/

comment on column CURR_POWER_ARCH.MID is 'Ид точки'
/

comment on column CURR_POWER_ARCH.DATE_TIME is 'Дата'
/

comment on column CURR_POWER_ARCH.ER is 'Мощность A'
/

comment on column CURR_POWER_ARCH.Q1 is 'Мощность R'
/

comment on column CURR_POWER_ARCH.ED is 'Мощность A отд'
/

comment on column CURR_POWER_ARCH.Q3 is 'Мощность R отд'
/

comment on column CURR_POWER_ARCH.FREQ is 'Частота'
/

comment on column CURR_POWER_ARCH.COSF is 'COSF'
/

comment on column CURR_POWER_ARCH.VOLT is 'Напряжение A'
/

comment on column CURR_POWER_ARCH.CURRENTO is 'Ток A'
/

comment on column CURR_POWER_ARCH.VOLT2 is 'Напряжение B'
/

comment on column CURR_POWER_ARCH.VOLT3 is 'Напряжение C'
/

comment on column CURR_POWER_ARCH.CURR2 is 'Ток B'
/

comment on column CURR_POWER_ARCH.CURR3 is 'Ток C'
/

comment on column CURR_POWER_ARCH.ERM is 'Показания А'
/

comment on column CURR_POWER_ARCH.EDM is 'Показания А отд'
/

comment on column CURR_POWER_ARCH.Q1M is 'Показания Р'
/

comment on column CURR_POWER_ARCH.Q3M is 'Показания Р отд'
/

comment on column CURR_POWER_ARCH.Q2 is 'Мощность Р 2'
/

comment on column CURR_POWER_ARCH.Q4 is 'Мощность Р 4'
/

comment on column CURR_POWER_ARCH.Q2M is 'Показания Р 2'
/

comment on column CURR_POWER_ARCH.Q4M is 'Показания Р 4'
/


-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     25.09.2003  13:32
-- ============================================================

/*
--Для Одессы

INSERT INTO deportprocedures
(NPROCEDURE,VNAME,VPROCEDURE,NPERIOD,NTYPE,VMEMO)
VALUES
(14,'Проверка полноты заполнения БД','ryda.check_pg.BY_FULLNESS',2,1,
'Проверка полноты заполнения БД по каналам опроса точек учёта')
/
INSERT INTO points
(mid, name, parent, ind)
VALUES
(14,'Проверка заполнения БД',2,1)
/

INSERT INTO deportprocedures
(NPROCEDURE,VNAME,VPROCEDURE,NPERIOD,NTYPE,VMEMO)
VALUES
(15,'Проверка переключения ОВ','ryda.CHECK_PG.by_switchov',2,1,'Проверка переключения ОВ')
/

INSERT INTO points
(mid, name, parent, ind)
VALUES
(15,'Проверка переключения ОВ',2,1)
/

commit
/

*/


/*
--Для ПГОК

INSERT INTO points
(mid, name, parent, ind)
VALUES
(2,'Процедуры',NULL,1)
/
INSERT INTO points
(mid, name, parent, ind)
VALUES
(16,'Контроль времени Fag-12',2,1)
/
INSERT INTO deportprocedures
(NPROCEDURE,VNAME,VPROCEDURE,NPERIOD,NTYPE,VMEMO)
VALUES
(16,'Контроль времени Fag-12','NULL',2,1,
'Контроль времени Fag-12')
/

commit
/

*/

/*
--Устаревшее
INSERT INTO deportprocedures
(NPROCEDURE,VNAME,VPROCEDURE,NPERIOD,NTYPE,VMEMO)
VALUES
(24,'Тарификация по режимным суткам','rates_pg.calcratescoef',2,1,
'Тарификация по режимным суткам')
/
INSERT INTO points
(mid, name, parent, ind)
VALUES
(24,'Тарификация по режимным суткам',2,1)
/
commit
/
*/

-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     06.10.2003  15:43
-- ============================================================
ALTER TABLE CURR_POWER drop column NWASTEABS
/

alter table GROUPS add
(
    VPARAM              VARCHAR2(256)          null
)
/

comment on column GROUPS.VPARAM is 'Параметр'
/

alter table HALFHOUROLD add
(
    ER_MTRSN            VARCHAR2(20)           null
)
/

comment on column HALFHOUROLD.ER_MTRSN is 'Номер счетчика'
/

alter table HALFHOURTMP add
(
    ER_MTRSN            VARCHAR2(20)           null
)
/

comment on column HALFHOURTMP.ER_MTRSN is 'Номер счетчика'
/


--08/10/2003
insert into recompens(nrecompens,vname,nratio) values(5,'Без учета реактива',0)
/
commit
/





-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     20.10.2003  11:06
-- ============================================================

-- ============================================================
--   Table: MAN_INP_HHOUR
-- ============================================================
alter table MAN_INP_HHOUR add
(
    AER        NUMBER                 null    ,
    AQ1        NUMBER                 null    ,
    AED        NUMBER                 null    ,
    AQ3        NUMBER                 null    ,
    AQ2        NUMBER                 null    ,
    AQ4        NUMBER                 null    ,
    AERM       NUMBER                 null    ,
    AQ1M       NUMBER                 null    ,
    AEDM       NUMBER                 null    ,
    AQ3M       NUMBER                 null    ,
    AQ2M       NUMBER                 null    ,
    AQ4M       NUMBER                 null    ,
    BER        NUMBER                 null    ,
    BQ1        NUMBER                 null    ,
    BED        NUMBER                 null    ,
    BQ3        NUMBER                 null    ,
    BQ2        NUMBER                 null    ,
    BQ4        NUMBER                 null    ,
    BERM       NUMBER                 null    ,
    BQ1M       NUMBER                 null    ,
    BEDM       NUMBER                 null    ,
    BQ3M       NUMBER                 null    ,
    BQ2M       NUMBER                 null    ,
    BQ4M       NUMBER                 null    ,
    CER        NUMBER                 null    ,
    CQ1        NUMBER                 null    ,
    CED        NUMBER                 null    ,
    CQ3        NUMBER                 null    ,
    CQ2        NUMBER                 null    ,
    CQ4        NUMBER                 null    ,
    CERM       NUMBER                 null    ,
    CQ1M       NUMBER                 null    ,
    CEDM       NUMBER                 null    ,
    CQ3M       NUMBER                 null    ,
    CQ2M       NUMBER                 null    ,
    CQ4M       NUMBER                 null    ,
    DER        NUMBER                 null    ,
    DQ1        NUMBER                 null    ,
    DED        NUMBER                 null    ,
    DQ3        NUMBER                 null    ,
    DQ2        NUMBER                 null    ,
    DQ4        NUMBER                 null    ,
    DERM       NUMBER                 null    ,
    DQ1M       NUMBER                 null    ,
    DEDM       NUMBER                 null    ,
    DQ3M       NUMBER                 null    ,
    DQ2M       NUMBER                 null    ,
    DQ4M       NUMBER                 null
)
/

comment on column MAN_INP_HHOUR.AER is 'AER'
/

comment on column MAN_INP_HHOUR.AQ1 is 'AQ1'
/

comment on column MAN_INP_HHOUR.AED is 'AED'
/

comment on column MAN_INP_HHOUR.AQ3 is 'AQ3'
/

comment on column MAN_INP_HHOUR.AQ2 is 'AQ2'
/

comment on column MAN_INP_HHOUR.AQ4 is 'AQ4'
/

comment on column MAN_INP_HHOUR.AERM is 'AERM'
/

comment on column MAN_INP_HHOUR.AQ1M is 'AQ1M'
/

comment on column MAN_INP_HHOUR.AEDM is 'AEDM'
/

comment on column MAN_INP_HHOUR.AQ3M is 'AQ3M'
/

comment on column MAN_INP_HHOUR.AQ2M is 'AQ2M'
/

comment on column MAN_INP_HHOUR.AQ4M is 'AQ4M'
/

comment on column MAN_INP_HHOUR.BER is 'BER'
/

comment on column MAN_INP_HHOUR.BQ1 is 'BQ1'
/

comment on column MAN_INP_HHOUR.BED is 'BED'
/

comment on column MAN_INP_HHOUR.BQ3 is 'BQ3'
/

comment on column MAN_INP_HHOUR.BQ2 is 'BQ2'
/

comment on column MAN_INP_HHOUR.BQ4 is 'BQ4'
/

comment on column MAN_INP_HHOUR.BERM is 'BERM'
/

comment on column MAN_INP_HHOUR.BQ1M is 'BQ1M'
/

comment on column MAN_INP_HHOUR.BEDM is 'BEDM'
/

comment on column MAN_INP_HHOUR.BQ3M is 'BQ3M'
/

comment on column MAN_INP_HHOUR.BQ2M is 'BQ2M'
/

comment on column MAN_INP_HHOUR.BQ4M is 'BQ4M'
/

comment on column MAN_INP_HHOUR.CER is 'CER'
/

comment on column MAN_INP_HHOUR.CQ1 is 'CQ1'
/

comment on column MAN_INP_HHOUR.CED is 'CED'
/

comment on column MAN_INP_HHOUR.CQ3 is 'CQ3'
/

comment on column MAN_INP_HHOUR.CQ2 is 'CQ2'
/

comment on column MAN_INP_HHOUR.CQ4 is 'CQ4'
/

comment on column MAN_INP_HHOUR.CERM is 'CERM'
/

comment on column MAN_INP_HHOUR.CQ1M is 'CQ1M'
/

comment on column MAN_INP_HHOUR.CEDM is 'CEDM'
/

comment on column MAN_INP_HHOUR.CQ3M is 'CQ3M'
/

comment on column MAN_INP_HHOUR.CQ2M is 'CQ2M'
/

comment on column MAN_INP_HHOUR.CQ4M is 'CQ4M'
/

comment on column MAN_INP_HHOUR.DER is 'DER'
/

comment on column MAN_INP_HHOUR.DQ1 is 'DQ1'
/

comment on column MAN_INP_HHOUR.DED is 'DED'
/

comment on column MAN_INP_HHOUR.DQ3 is 'DQ3'
/

comment on column MAN_INP_HHOUR.DQ2 is 'DQ2'
/

comment on column MAN_INP_HHOUR.DQ4 is 'DQ4'
/

comment on column MAN_INP_HHOUR.DERM is 'DERM'
/

comment on column MAN_INP_HHOUR.DQ1M is 'DQ1M'
/

comment on column MAN_INP_HHOUR.DEDM is 'DEDM'
/

comment on column MAN_INP_HHOUR.DQ3M is 'DQ3M'
/

comment on column MAN_INP_HHOUR.DQ2M is 'DQ2M'
/

comment on column MAN_INP_HHOUR.DQ4M is 'DQ4M'
/





-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     24.10.2003  18:56
-- ============================================================

-- ============================================================
--   Table: TARIFFTYPE
-- ============================================================
create table TARIFFTYPE
(
    NTARIFFTYPE  NUMBER(10)             not null,
    VNAME        VARCHAR2(128)          not null,
    constraint TARIFFTYPE_PK primary key (NTARIFFTYPE)
)
/
insert into TARIFFTYPE(NTARIFFTYPE,VNAME) values(1,'Услуги UMS')
/

insert into TARIFFTYPE(NTARIFFTYPE,VNAME) values(2,'Услуги KYIVSTAR')
/

insert into TARIFFTYPE(NTARIFFTYPE,VNAME) values(3,'Услуги THURYA')
/

comment on table TARIFFTYPE is 'Тип тарифа'
/

comment on column TARIFFTYPE.NTARIFFTYPE is 'Ид типа тарифа'
/

comment on column TARIFFTYPE.VNAME is 'Название'
/


-- ============================================================
--   Index: TARIFFTYPE_IDX1
-- ============================================================
create unique index TARIFFTYPE_IDX1 on TARIFFTYPE (VNAME asc)
/

-- ============================================================
--   Table: COMPORTS
-- ============================================================
alter table COMPORTS add
(
    NONLYONE     NUMBER(1)              default 0 not null
        constraint CKC_NONLYONE_COMPORTS check (NONLYONE in (0,1)),
    NTARIFFTYPE  NUMBER(10)             null
)
/

comment on column COMPORTS.NONLYONE is 'Только один канал'
/

comment on column COMPORTS.NTARIFFTYPE is 'Ид типа тарифа'
/

create index COMPORTS_IDX2 on COMPORTS (NTARIFFTYPE asc)
/

rename TARIFF to TARIFF1
/

create table TARIFF
(
    NTARIFFTYPE  NUMBER(10)             not null,
    DSTART       DATE                   not null,
    NVALUE       NUMBER                 not null,
    constraint TARIFFS_PK primary key (NTARIFFTYPE, DSTART)
)
/

insert into TARIFF(NTARIFFTYPE,DSTART,NVALUE) select 1,DSTART,NVALUE from TARIFF1
/

drop table TARIFF1
/

comment on table TARIFF is 'Тарифы'
/

comment on column TARIFF.NTARIFFTYPE is 'Ид типа тарифа'
/

comment on column TARIFF.DSTART is 'Дата начала'
/

comment on column TARIFF.NVALUE is 'Значение'
/


-- ============================================================
--   Index: TARIFF_IDX1
-- ============================================================
create index TARIFF_IDX1 on TARIFF (DSTART asc)
/

alter table COMPORTS
    add constraint COMPORTS_F2 foreign key  (NTARIFFTYPE)
       references TARIFFTYPE (NTARIFFTYPE)
/

alter table TARIFF
    add constraint TARIFF_F1 foreign key  (NTARIFFTYPE)
       references TARIFFTYPE (NTARIFFTYPE) on delete cascade
/

alter table CHANNELS add
(
    NDELIVERED      NUMBER(1)              default 0 not null
        constraint CKC_NDELIVERED_CHANNELS check (NDELIVERED in (0,1))
)
/

comment on column CHANNELS.NDELIVERED is 'Прочитан'
/


declare
ln_tmp NUMBER;
begin
select nvl(max(COM_ID),0)+1 into ln_tmp from comports;
for i in ln_tmp..128 loop
insert into comports (COM_ID,NAME,BAUDRATE,BYTESIZE,PARITY,STOPBITS,NCOMTYPE)
values (i,'COM'||i,9600,8,0,1,1);
end loop;
commit;
end;
/


-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     31.10.2003  17:27
-- ============================================================

-- ============================================================
--   Table: RELATEDPARAM
-- ============================================================
create table RELATEDPARAM
(
    NCONNECTIONPARAM  NUMBER(10)             not null,
    NFIRSTPARAM       NUMBER(10)             not null,
    NKC               NUMBER(1)              default 1 not null
        constraint CKC_NKC_RELATEDP check (NKC between -1 and 1),
    constraint RELATEDPARAM_PK primary key (NCONNECTIONPARAM, NFIRSTPARAM)
)
/

comment on table RELATEDPARAM is 'Зависимые параметры'
/

comment on column RELATEDPARAM.NCONNECTIONPARAM is 'Ид параметра'
/

comment on column RELATEDPARAM.NFIRSTPARAM is 'Первичный параметр'
/

comment on column RELATEDPARAM.NKC is 'Коэф зввисимости'
/


-- ============================================================
--   Index: RELATEDPARAM
-- ============================================================
create index RELATEDPARAM on RELATEDPARAM (NFIRSTPARAM asc)
/

alter table RELATEDPARAM
    add constraint RELATEDPARAM_F2 foreign key  (NFIRSTPARAM)
       references CONNECTIONPARAM (NCONNECTIONPARAM) on delete cascade
/

alter table RELATEDPARAM
    add constraint RELATEDPARAM_F1 foreign key  (NCONNECTIONPARAM)
       references CONNECTIONPARAM (NCONNECTIONPARAM) on delete cascade
/



-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     10.11.2003  16:45
-- ============================================================

-- ============================================================
--   Table: METERSHISTORY
-- ============================================================
create table METERSHISTORY
(
    MID        NUMBER                 not null,
    DATE_TIME  DATE                   not null,
    ENTYPE     NUMBER                 not null,
    MTRSN      VARCHAR2(20)           null    ,
    DIGITS     NUMBER                 null    ,
    MTYPE      VARCHAR2(50)           null    ,
    MCURRENT   NUMBER                 null    ,
    MPOWER     NUMBER                 null    ,
    MCONST     NUMBER                 null    ,
    MCLASS     NUMBER                 null    ,
    MYEAR      NUMBER                 null    ,
    MQUARTER   NUMBER                 null    ,
    KC         NUMBER                 null    ,
    constraint METERSHISTORY_PK primary key (MID, DATE_TIME, ENTYPE)
)
/

comment on table METERSHISTORY is 'Замены счетчиков'
/

comment on column METERSHISTORY.MID is 'Ид точки'
/

comment on column METERSHISTORY.DATE_TIME is 'Дата установки'
/

comment on column METERSHISTORY.ENTYPE is 'Тип измерения'
/

comment on column METERSHISTORY.MTRSN is 'Номер'
/

comment on column METERSHISTORY.DIGITS is 'Значность'
/

comment on column METERSHISTORY.MTYPE is 'Тип'
/

comment on column METERSHISTORY.MCURRENT is 'Ток'
/

comment on column METERSHISTORY.MPOWER is 'Напряжение'
/

comment on column METERSHISTORY.MCONST is 'Кол импульсов'
/

comment on column METERSHISTORY.MCLASS is 'Класс'
/

comment on column METERSHISTORY.MYEAR is 'Пломба год'
/

comment on column METERSHISTORY.MQUARTER is 'Пломба квартал'
/

comment on column METERSHISTORY.KC is 'Коеф'
/


-- ============================================================
--   Index: METERS_DATE_TIME_IDX2
-- ============================================================
create index METERS_DATE_TIME_IDX2 on METERSHISTORY (DATE_TIME asc)
/

alter table METERSHISTORY
    add constraint METERSHI_F1 foreign key  (MID)
       references POINTS (MID) on delete cascade
/

-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     14.11.2003  11:00
-- ============================================================
truncate table METERSHISTORY
/

alter table METERSHISTORY add
(
    DEND       DATE not null
)
/

comment on column METERSHISTORY.DEND is 'Дата снятия'
/


----------------------21.11.2003
-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     21.11.2003  18:07
-- ============================================================
create table connectionparamtmp as select NCONNECTIONPARAM,NENERGYPERCENT from connectionparam where nvl(nenergypercent,0)<>100
/

ALTER TABLE RYDA.CONNECTIONPARAM drop column NENERGYPERCENT
/

alter table CONNECTIONPARAM add
(
    NENERGYPERCENT       NUMBER                 default 100 null
        constraint CKC_NENERGYPERCENT_SSCONNEC check (
            NENERGYPERCENT is null or (NENERGYPERCENT between -100 and 100)),
    NRENERGYPERCENT      NUMBER                 default 100 null
        constraint CKC_NRENERGYPERCENT_CONNECTI check (NRENERGYPERCENT is null or (NRENERGYPERCENT between -100 and 100)),
    NPROCENT             NUMBER(1)              default 0 not null
        constraint CKC_NPROCENT_CONNECTI check (NPROCENT in (1,0))
)
/

comment on column CONNECTIONPARAM.NENERGYPERCENT is 'Процент потерь Актив'
/

comment on column CONNECTIONPARAM.NRENERGYPERCENT is 'Процент потерь Реактив'
/

comment on column CONNECTIONPARAM.NPROCENT is 'Потери в процентах'
/

-- ============================================================
--   Index: CONNECTIONPARAM_IDX2
-- ============================================================
create index CONNECTIONPARAM_IDX2 on CONNECTIONPARAM (MID asc)
/

declare
cursor lcur_sel is select NCONNECTIONPARAM,NENERGYPERCENT from connectionparamtmp;
begin
for lc in lcur_sel loop
update connectionparam set NENERGYPERCENT=lc.NENERGYPERCENT where NCONNECTIONPARAM=lc.NCONNECTIONPARAM;
end loop;
commit;
end;
/

update connectionparam set nprocent=1 where NENERGYPERCENT<>100
/

drop table connectionparamtmp
/


---------04.12.2003
update form_templates set ENABLECONTROLS=substr(ENABLECONTROLS,1,6)||'1' where CODETEMPLATE in (910,920,921,930,940,941,950,960,970,980,500,501,502,600,601,602,400,401,402,800,801,802,900,901,902,700,701,702,200,201,202,300,301,302,100,101,102,310,311,320,321,1400,1410)
/
update form_templates set ENABLECONTROLS=rpad(ENABLECONTROLS,7,'0')
/
update forms set ENABLECONTROLS=rpad(ENABLECONTROLS,7,'0')
/
update forms set ENABLECONTROLS=substr(ENABLECONTROLS,1,6)||'1' where CODETEMPLATE in (910,920,921,930,940,941,950,960,970,980,500,501,502,600,601,602,400,401,402,800,801,802,900,901,902,700,701,702,200,201,202,300,301,302,100,101,102,310,311,320,321,1400,1410)
/
commit
/


delete from tasks where TASK_COD in (15,12,14,16,41,20,31,32,44,45,50,61,62,70,73,75,100,507,30)
/
commit
/


---------04.12.2003
drop table AVERRATE
/
drop table RATE_EDIT_DATE
/

insert into parameter (NPID,VVALUE,VDESCRIPTION) values(19,to_char(sysdate,'dd.mm.yyyy'),'Расчетные сутки')
/
update parameter set VVALUE=(select to_char(nvl(max(ddate),sysdate),'dd.mm.yyyy') from calcperiod) where NPID=19
/
drop table calcperiod
/
drop table CYCLIC_DATES
/
drop table SPECIAL_DATES
/
delete from form_templates where CODETEMPLATE in (51,53,60,61)
/
delete from forms where CODETEMPLATE in (51,53,60,61)
/
commit
/
drop table PLANS
/
drop table LIMITS
/
drop table MANUAL_DVS
/
drop table DAY_TYPES
/
drop table USPDMATRIX
/
drop table USPD
/
drop table MANUAL_PTS_C
/
drop table ALTER_PTS
/

drop package EDITCANALS_PG
/

alter table RATE_LIST drop column name
/
alter table RATES drop column DAY_TYPE
/
alter table RATES add
(
    constraint PK_RATES primary key (RID, TIME)
)
/

comment on table RATES is 'Расписание тар зон'
/

comment on column RATES.RID is 'Ид'
/

comment on column RATES.TIME is 'Время начала'
/

comment on column RATES.RATE is 'Зона'
/

comment on column RATES.ENDTIME is 'Время окончания'
/



/*
--ХОЭ
-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     08.12.2003  14:21
-- ============================================================

-- ============================================================
--   Table: REALPOINT
-- ============================================================
create table REALPOINT
(
    mid         NUMBER                 not null,
    NREALPOINT  NUMBER                 not null,
    NRATIO      NUMBER                 default 1 not null,
    ER          VARCHAR2(64)           null    ,
    Q1          VARCHAR2(64)           null    ,
    Q2          VARCHAR2(64)           null    ,
    ED          VARCHAR2(64)           null    ,
    Q3          VARCHAR2(64)           null    ,
    Q4          VARCHAR2(64)           null    ,
    constraint REALPOINT_PK primary key (mid,NREALPOINT)
)
/

comment on table REALPOINT is 'Расчетные точки ПРОМА'
/

comment on column REALPOINT.mid is 'Ид точки'
/

comment on column REALPOINT.NREALPOINT is 'Ид наст точки'
/

comment on column REALPOINT.NRATIO is 'Коэф'
/

comment on column REALPOINT.ER is 'Ф Апрн'
/

comment on column REALPOINT.Q1 is 'Ф Q1'
/

comment on column REALPOINT.Q2 is 'Ф Q2'
/

comment on column REALPOINT.ED is 'Ф Аотд'
/

comment on column REALPOINT.Q3 is 'Ф Q3'
/

comment on column REALPOINT.Q4 is 'Ф Q4'
/


-- ============================================================
--   Index: REALPOINT_IDX1
-- ============================================================
create index REALPOINT_IDX1 on REALPOINT (NREALPOINT asc)
/

alter table REALPOINT
    add constraint REALPOINT_F1 foreign key  (mid)
       references POINTS (MID) on delete cascade
/

alter table REALPOINT
    add constraint REALPOINT_F2 foreign key  (NREALPOINT)
       references POINTS (MID) on delete cascade
/

 insert into deportprocedures (nprocedure, vname, vprocedure, nperiod, ntype, vmemo)
 values (25, 'Копирование данных на расчетные точки','background01_pg.setdataunrealpoints', 2, 1, 'Копирование данных на расчетные точки')
 /

INSERT INTO points
(mid, name, parent, ind)
VALUES
(25,'Копирование данных на расчетные точки',2,1)
/

commit
/
*/

drop table BILL_C
/
drop table HALFHOUR_C
/
drop table PROFILE_C
/
drop table CURR_POWER_C
/
drop table FISCAL_C
/
drop table JOURNAL_C
/

-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     12.12.2003  16:15
-- ============================================================
alter table CHANPOINT add
(
    NBLOCK  NUMBER(1)              default 0 not null
        constraint CKC_NBLOCK_CHANPOIN check (NBLOCK in (0,1))
)
/

comment on column CHANPOINT.NBLOCK is 'Блокировка'
/



----------11/01/2004
INSERT INTO deportprocedures
(NPROCEDURE,VNAME,VPROCEDURE,NPERIOD,NTYPE,VMEMO)
VALUES
(26,'Расчет ручных точек','ryda.background01_pg.replicator',2,1,
'Расчет ручных точек')
/
commit


-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     15.01.2004  12:11
-- ============================================================

-- ============================================================
--   Table: USEDCONSUMPT
-- ============================================================
create table USEDCONSUMPT
(
    NCONNECTIONPARAM  NUMBER(10)             not null,
    MID               NUMBER                 not null,
    NTYPE             NUMBER(2)              default 0 not null
        constraint CKC_NTYPE_USEDCONS check (NTYPE in (0,1,2)),
    NKC               NUMBER                 default 1 not null,
    NRECOMPENS        NUMBER(10)             null    ,
    constraint USEDCONSUMPT_PK primary key (NCONNECTIONPARAM, MID)
)
/

comment on table USEDCONSUMPT is 'Используемые расходы'
/

comment on column USEDCONSUMPT.NCONNECTIONPARAM is 'Ид параметра'
/

comment on column USEDCONSUMPT.MID is 'Ид точки'
/

comment on column USEDCONSUMPT.NTYPE is 'Тип измерения'
/

comment on column USEDCONSUMPT.NKC is 'Коеф вхождения'
/

comment on column USEDCONSUMPT.NRECOMPENS is 'Ид типа расч реакт'
/


-- ============================================================
--   Index: USEDCONSUMPT_IDX1
-- ============================================================
create index USEDCONSUMPT_IDX1 on USEDCONSUMPT (MID asc)
/

-- ============================================================
--   Index: USEDCONSUMPT_IDX2
-- ============================================================
create index USEDCONSUMPT_IDX2 on USEDCONSUMPT (NRECOMPENS asc)
/

alter table USEDCONSUMPT
    add constraint USEDCONSUMPT_F1 foreign key  (NCONNECTIONPARAM)
       references CONNECTIONPARAM (NCONNECTIONPARAM) on delete cascade
/

alter table USEDCONSUMPT
    add constraint USEDCONSUMPT_F2 foreign key  (MID)
       references POINTS (MID) on delete cascade
/

alter table USEDCONSUMPT
    add constraint USEDCONSUMPT_F3 foreign key  (NRECOMPENS)
       references RECOMPENS (NRECOMPENS)
/




----------26/01/2004
alter table USEDCONSUMPT drop constraint USEDCONSUMPT_PK
/

alter table USEDCONSUMPT
 add constraint USEDCONSUMPT_PK primary key (NCONNECTIONPARAM, MID, NTYPE)
/



-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     02.02.2004  17:13
-- ============================================================
alter table FEEDERS add
(
    NBLOCK             NUMBER(1)              default 0 not null
        constraint CKC_NBLOCK_FEEDERS check (NBLOCK in (0,1))
)
/

comment on column FEEDERS.NBLOCK is 'Блокировка авт опроса'
/

update feeders set nblock=1 where mid in (select mid from chanpoint where nblock=1)
/

alter table CHANPOINT drop column nblock
/

----------03/02/2004
update deportprocedures set VPROCEDURE='RYDA.REPORTS1_PG.ARROUND_M30817'
where upper(VPROCEDURE) like '%ARROUND_M30817' and upper(VPROCEDURE) not like '%PG.ARROUND_M30817'
/
drop package OLDPROCEDURES_PG
/
drop procedure CHECKHALFHOUR
/
drop procedure ARROUND_M30817
/
drop procedure mark_lgstatus
/
drop procedure MARK_CHANNELS
/
drop procedure MARK_EAEVENT
/
drop procedure MARK_MESSAGES
/

------------06/02/2004
-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     06.02.2004  14:11
-- ============================================================

-- ============================================================
--   Table: MEASURES
-- ============================================================
create table MEASURES
(
    nmeasure  NUMBER                 not null,
    VNAME   VARCHAR2(32)           not null,
    constraint MEASURES_PK primary key (nmeasure)
)
/

comment on table MEASURES is 'Измерения'
/

comment on column MEASURES.NMEASURE is 'Ид измерения'
/

comment on column MEASURES.VNAME is 'Название измерения'
/

-- ============================================================
--   Index: MEASURES_IDX1
-- ============================================================
create unique index MEASURES_IDX1 on MEASURES (VNAME asc)
/


INSERT INTO measures
(nmeasure,VNAME)
VALUES
(1,'Актив, прием')
/
INSERT INTO measures
(nmeasure,VNAME)
VALUES
(2,'Актив, отдача')
/
INSERT INTO measures
(nmeasure,VNAME)
VALUES
(3,'Q1 (Реактив, прием)')
/
INSERT INTO measures
(nmeasure,VNAME)
VALUES
(5,'Q3 (Реактив, генерц)')
/
INSERT INTO measures
(nmeasure,VNAME)
VALUES
(4,'Q2')
/
INSERT INTO measures
(nmeasure,VNAME)
VALUES
(6,'Q4')
/
commit
/
drop table last_input
/




-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     11.02.2004  12:51
-- ============================================================
create table CALCPOINTTYPE
(
    NCALCPOINTTYPE  NUMBER(10)             not null,
    VNAME           VARCHAR2(64)           not null,
    constraint CALCPOINTTYPE_PK primary key (NCALCPOINTTYPE)
)
/

comment on table CALCPOINTTYPE is 'Типы ручников'
/

comment on column CALCPOINTTYPE.NCALCPOINTTYPE is 'Ид типа ручника'
/

comment on column CALCPOINTTYPE.VNAME is 'Название'
/
create unique index CALCPOINTTYPE_IDX1 on CALCPOINTTYPE (VNAME asc)
/

INSERT INTO calcpointtype
(NCALCPOINTTYPE,VNAME)
VALUES
(1,'Расчет по установленной мощности')
/
INSERT INTO calcpointtype
(NCALCPOINTTYPE,VNAME)
VALUES
(2,'Расчет по среднемесячному расходу')
/
commit
/
drop table MANUAL_LIGHT_LIMIT
/

alter table FEEDERS add
(
    NCALCPOINTTYPE     NUMBER(10)             null
)
/

comment on column FEEDERS.NCALCPOINTTYPE is 'Ид типа ручника'
/

create index FEEDERS_IDX3 on FEEDERS (NCALCPOINTTYPE asc)
/

alter table FEEDERS
    add constraint FEEDERS_F2 foreign key  (NCALCPOINTTYPE)
       references CALCPOINTTYPE (NCALCPOINTTYPE)
/

drop table MANUAL_PTS
/

-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     12.02.2004  14:48
-- ============================================================
create table POINTSPARAM
(
    MID             NUMBER                 not null,
    DDATE           DATE                   not null,
    NCURRPOWER      NUMBER                 null    ,
    NMONTHCONSUMPT  NUMBER                 null    ,
    constraint POINTSPARAM_PK primary key (MID, DDATE)
)
/

comment on table POINTSPARAM is 'Изменяемые параметры присоединений'
/

comment on column POINTSPARAM.MID is 'Ид точки'
/

comment on column POINTSPARAM.DDATE is 'Дата ввода'
/

comment on column POINTSPARAM.NCURRPOWER is 'Уст мощность'
/

comment on column POINTSPARAM.NMONTHCONSUMPT is 'Среднемес расход'
/


-- ============================================================
--   Index: POINTSPARAM_IDX1
-- ============================================================
create index POINTSPARAM_IDX1 on POINTSPARAM (DDATE asc)
/

alter table POINTSPARAM
    add constraint POINTSPARAM_F1 foreign key  (MID)
       references FEEDERS (MID) on delete cascade
/

delete from tasks where TASK_COD in(500,501)
/
drop package EDITMANUAL_PG
/





----------18.02.2004
ALTER TABLE FISCAL MODIFY
(
   DATE_TIME  DATE                   not null,
   MESSAGE    VARCHAR2(512)
)
/
comment on table FISCAL is 'Фискальный журнал'
/

comment on column FISCAL.DATE_TIME is 'Дата'
/

comment on column FISCAL.TASK_COD is 'Код задачи'
/

comment on column FISCAL.TASK_JOB is 'Задача'
/

comment on column FISCAL.NAME is 'Пользователь'
/

comment on column FISCAL.MESSAGE is 'Сообщение'
/
create index FISCAL_IDX1 on FISCAL (DATE_TIME asc)
/

ALTER TABLE JOURNAL MODIFY
(
   STATE_DESCR  VARCHAR2(512)
)
/

alter table FEEDERS add
(
    NTECHCONTROL       NUMBER                 null    ,
    NCOMMCONTROL       NUMBER                 null
)
/

comment on column FEEDERS.NTECHCONTROL is 'Тех контр опроса (мин)'
/

comment on column FEEDERS.NCOMMCONTROL is 'Ком контр опроса (мин)'
/

create table ROLE_GROUPS
(
    ROLE_ID  NUMBER                 not null,
    GID      NUMBER                 not null,
    constraint ROLE_GROUPS_PK primary key (ROLE_ID, GID)
)
/

comment on table ROLE_GROUPS is 'Доступные группы роли'
/

comment on column ROLE_GROUPS.ROLE_ID is 'Ид роли'
/

comment on column ROLE_GROUPS.GID is 'Ид группы'
/

create index ROLE_GROUPS_IDX1 on ROLE_GROUPS (GID asc)
/

alter table ROLE_GROUPS
    add constraint ROLE_GROUPS_F1 foreign key  (ROLE_ID)
       references ROLES (ROLE_ID) on delete cascade
/

alter table ROLE_GROUPS
    add constraint ROLE_GROUPS_F2 foreign key  (GID)
       references GROUPS (GID) on delete cascade
/

ALTER TABLE RYDA.PARALLELCONNECTION MODIFY
(
   VUSETYPE                   DEFAULT 'C' )
/


-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     26.02.2004  16:40
-- ============================================================

alter table FEEDERS add
(
    NDATAABSENCE       NUMBER(1)              default 0 not null
        constraint CKC_NDATAABSENCE_FEEDERS check (NDATAABSENCE in (0,1))
)
/

comment on column FEEDERS.NDATAABSENCE is 'Сигнализировать об отсутствии'
/
---------27/02/2004
drop package POINTCALC_PG_OLD
/

-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     27.02.2004  17:21
-- ============================================================

-- ============================================================
--   Table: FEEDERS
-- ============================================================
alter table FEEDERS add
(
    NDATAABSENCEC      NUMBER(1)              default 0 not null
        constraint CKC_NDATAABSENCEC_FEEDERS check (NDATAABSENCEC in (0,1)),
    NDATAABSENCECT     NUMBER(1)              default 0 not null
        constraint CKC_NDATAABSENCECT_FEEDERS check (NDATAABSENCECT in (0,1)),
    DDATAABSENCEC      DATE                   null
)
/


comment on column FEEDERS.NDATAABSENCEC is 'Отсутствие ком данных'
/

comment on column FEEDERS.NDATAABSENCECT is 'Отсутствие тех данных'
/

comment on column FEEDERS.DDATAABSENCEC is 'Даата контроля ком данных'
/



-----------02/03/2004
insert into parameter (NPID,VVALUE,VDESCRIPTION) values(20,'0','Разбивать долевые потери реактива по реактиву')
--Для ПЖД 1
/


INSERT INTO RYDA.PROTOCOLS
VALUES
(33,'Энергия_9-2003')
/
INSERT INTO RYDA.PROTOCOLS
VALUES
(34,'KM --> Энергия_9-2003')
/
INSERT INTO RYDA.PROTOCOLS
VALUES
(35,'SL-7000')
/
INSERT INTO RYDA.PROTOCOLS
VALUES
(36,'KM --> SL-7000')
/
INSERT INTO RYDA.PROTOCOLS
VALUES
(37,'Файл (импорт)')
/
INSERT INTO RYDA.PROTOCOLS
VALUES
(38,'KM --> Файл (импорт)')
/

commit
/
comment on column FEEDERS.NDATAABSENCE is 'Сигнализировать об отсутствии'
/


----------19/03/2004
INSERT INTO tasks
(TASK_ID,PARENT,TASK_COD,NAME,NUM_ARG,CHAR_ARG,REMARK)
VALUES
(75,NULL,0,'5. Мониторинг системы',NULL,'','')
/
INSERT INTO tasks
(TASK_ID,PARENT,TASK_COD,NAME,NUM_ARG,CHAR_ARG,REMARK)
VALUES
(76,75,620,'5.01 Мониторинг опроса',NULL,'','Мониторинг опроса')
/
INSERT INTO deportprocedures
(NPROCEDURE,VNAME,VPROCEDURE,NPERIOD,NTYPE,VMEMO)
VALUES
(27,'Мониторинг опроса','check_pg.RequestMonitoring_p',1,1,'Мониторинг опроса')
/

commit
/

INSERT INTO makets
(NMAKET,NPROCEDURE,VNAME,VNOTE,NBLOCK,NCYCLE,NSHIFT,VPARAM,DOLDCREATED,VERROR)
VALUES
(1063,27,'Мониторинг опроса','',0,0,5,'','','')
/
commit
/



---------------23/03/2004
insert into parameter (NPID,VVALUE,VDESCRIPTION) values(21,'0','Ведение ГН по абсолютному времени')
/
commit
/


/*
--Формы мониторинга опроса
INSERT INTO forms
(FID,PARENT,MONITOR,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT,VPROCNAME)
VALUES
(1365,1060,1,1203,'08. Каналы опросившиеся по GSM','','1111110',2,'','plsql3_pg.report12_p')
/
INSERT INTO forms
(FID,PARENT,MONITOR,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT,VPROCNAME)
VALUES
(1384,1060,1,1203,'09. Отчет об отсутствии получасовых данных','','1101110',2,'',
'plsql3_pg.report13_p')
/
INSERT INTO forms
(FID,PARENT,MONITOR,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT,VPROCNAME)
VALUES
(1386,1060,1,1203,'10. Статистика работы каналов','','1111110',2,'','plsql3_pg.report121_p')
/
commit
/

*/



-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     01.04.2004  18:49
-- ============================================================

alter table HALFHOUROLD add
(
    DENTER       DATE                   default sysdate not null
)
/

comment on column HALFHOUROLD.DENTER is 'Дата попадания'
/

alter table billorg add
(
    DENTER       DATE                   default sysdate not null
)
/

comment on column billorg.DENTER is 'Дата попадания'
/

alter table MONTHSORG add
(
    DENTER       DATE                   default sysdate not null
)
/

comment on column MONTHSORG.DENTER is 'Дата попадания'
/


create index halfhourold_idx5 on HALFHOUROLD (DENTER asc)
/

create index MONTHSORG_IDX2 on MONTHSORG (DENTER asc)
/

create index BILL_IDX13 on BILLORG (DENTER asc)
/


-------------02.04.2004
alter table tasks drop column CHAR_ARG
/
alter table tasks drop column NUM_ARG
/

alter table TASKS add
(
    NSHOW     NUMBER(1)              default 1 not null
        constraint CKC_NSHOW_TASKS check (NSHOW in (0,1))
)
/

comment on column TASKS.NSHOW is 'Показывать в списке'
/

INSERT INTO tasks
(TASK_ID,PARENT,TASK_COD,NAME,REMARK,nshow)
VALUES
(77,NULL,0,'6. Инструментарий',NULL,0)
/
INSERT INTO tasks
(TASK_ID,PARENT,TASK_COD,NAME,REMARK,nshow)
VALUES
(78,77,630,'6. Терминал показаний','Терминал показаний',0)
/

insert into role_task
select ROLE_ID,78,decode(ROLE_ID,1,1,0) from roles
/

insert into role_task
select ROLE_ID,77,decode(ROLE_ID,1,1,0) from roles
/
commit
/


ALTER TABLE RYDA.POINTS MODIFY
(
   NAME                       NOT NULL)
/

----------------------06/04/2004
ALTER TABLE RYDA.DEPORTPROCEDURES
 DROP CONSTRAINT CKC_NPERIOD_DEPORTPR
/
ALTER TABLE RYDA.DEPORTPROCEDURES
 ADD CONSTRAINT CKC_NPERIOD_DEPORTPR
 CHECK (
NPERIOD in (1,2,3,4,5,6)
 )
/
-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     06.04.2004  12:22
-- ============================================================

-- ============================================================
--   Table: CHECK_RESULTSG
-- ============================================================
create table CHECK_RESULTSG
(
    NPROCEDURE  NUMBER(10)             not null,
    DDATE       DATE                   not null,
    GID         NUMBER                 not null,
    VPARAM      VARCHAR2(2000)         null    ,
    NMUSTBE     NUMBER                 null    ,
    NINDEED     NUMBER                 null    ,
    constraint CHECK_RESULTSG_PK primary key (NPROCEDURE, DDATE, GID)
)
/

comment on table CHECK_RESULTSG is 'Результаты верификации по группам'
/

comment on column CHECK_RESULTSG.NPROCEDURE is 'Ид процедуры'
/

comment on column CHECK_RESULTSG.DDATE is 'Дата'
/

comment on column CHECK_RESULTSG.GID is 'Группа учета'
/

comment on column CHECK_RESULTSG.VPARAM is 'Параметр'
/

comment on column CHECK_RESULTSG.NMUSTBE is 'Первое значение'
/

comment on column CHECK_RESULTSG.NINDEED is 'Второе значение'
/


-- ============================================================
--   Index: CHECK_RESULTSG_IDX12
-- ============================================================
create index CHECK_RESULTSG_IDX12 on CHECK_RESULTSG (DDATE asc)
/

-- ============================================================
--   Index: CHECK_RESULTSG_IDX22
-- ============================================================
create index CHECK_RESULTSG_IDX22 on CHECK_RESULTSG (GID asc)
/

alter table CHECK_RESULTSG
    add constraint CHECK_RESULTSG_F1 foreign key  (NPROCEDURE)
       references DEPORTPROCEDURES (NPROCEDURE) on delete cascade
/

alter table CHECK_RESULTSG
    add constraint CHECK_RESULTSG_F2 foreign key  (GID)
       references GROUPS (GID) on delete cascade
/





-- Start of DDL script for BRANCH_SEQ
-- Generated 7-апр-04  12:29:13 pm
-- from oe-RYDA:4

-- Drop the old instance of BRANCH_SEQ

DROP SEQUENCE branch_seq
/

DROP SEQUENCE KNOT_SEQ
/

DROP SEQUENCE TASKS_SEQ
/

DROP SEQUENCE PIPE_TASKS_SEQ
/

alter table groups drop column ratio
/

alter table groups drop column cid
/

alter table points drop column min3
/

alter table points drop column min30
/

alter table points drop column CALC_COUNT
/

alter table points drop column OVV_COUNT
/

alter table points drop column ORDER_DATE
/


-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     07.04.2004  16:02
-- ============================================================

-- ============================================================
--   Table: FEEDERS
-- ============================================================
alter table FEEDERS add
(
    NMAINPOINT         NUMBER                 null
)
/

comment on column FEEDERS.NMAINPOINT is 'Основной учет'
/

create index FEEDERS_IDX4 on FEEDERS (NMAINPOINT asc)
/

alter table FEEDERS
    add constraint FEEDERS_F4 foreign key  (NMAINPOINT)
       references FEEDERS (MID) on delete set null
/



---------------------22.04.2004
ALTER TABLE COMPORTS MODIFY
(
   NAME                       NOT NULL,
   BAUDRATE                   NOT NULL,
   BYTESIZE                   NOT NULL,
   PARITY                     NOT NULL,
   STOPBITS                   NOT NULL)
/




---------------------24.05.2004
-- ============================================================
--   Index: USERS_IDX3
-- ============================================================
create unique index USERS_IDX3 on USERS (NAME asc)
/


---------------------25.05.2004

INSERT INTO form_templates
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(80,20,65,'3.06. Контроль значений и параметров качества электроэнергии',
'Контроль значений и параметров качества электроэнергии','0111011',3,'')
/
commit
/



----------------------09/06/2004
insert into parameter (NPID,VVALUE,VDESCRIPTION) values(22,5,'Интервал интеграции профиля (мин)')
/
insert into parameter (NPID,VVALUE,VDESCRIPTION) values(23,24,'Длина шага профиля (час)')
/
commit
/


-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     10.06.2004  14:28
-- ============================================================
ALTER table CURR_POWER ADD
(
    NFIU1      NUMBER                 null    ,
    NFIU2      NUMBER                 null    ,
    NFIU3      NUMBER                 null    ,
    NFII1      NUMBER                 null    ,
    NFII2      NUMBER                 null    ,
    NFII3      NUMBER                 null
)
/

comment on column CURR_POWER.NFIU1 is 'Угол напр 1'
/

comment on column CURR_POWER.NFIU2 is 'Угол напр 2'
/

comment on column CURR_POWER.NFIU3 is 'Угол напр 3'
/

comment on column CURR_POWER.NFII1 is 'Угол тока 1'
/

comment on column CURR_POWER.NFII2 is 'Угол тока 2'
/

comment on column CURR_POWER.NFII3 is 'Угол тока 3'
/

ALTER table curr_power_arch ADD
(
    NFIU1      NUMBER                 null    ,
    NFIU2      NUMBER                 null    ,
    NFIU3      NUMBER                 null    ,
    NFII1      NUMBER                 null    ,
    NFII2      NUMBER                 null    ,
    NFII3      NUMBER                 null
)
/

comment on column curr_power_arch.NFIU1 is 'Угол напр 1'
/

comment on column curr_power_arch.NFIU2 is 'Угол напр 2'
/

comment on column curr_power_arch.NFIU3 is 'Угол напр 3'
/

comment on column curr_power_arch.NFII1 is 'Угол тока 1'
/

comment on column curr_power_arch.NFII2 is 'Угол тока 2'
/

comment on column curr_power_arch.NFII3 is 'Угол тока 3'
/

---------12/06/2004
INSERT INTO form_templates
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(81,40,1204,'5.03. Схема сети','Схема электрической сети','0000000',2,'-1')
/
commit
/


---------21/06/2004
ALTER TABLE RYDA.DEPORTPROCEDURES
 DROP CONSTRAINT CKC_NPERIOD_DEPORTPR
/
ALTER TABLE RYDA.DEPORTPROCEDURES
 ADD CONSTRAINT CKC_NPERIOD_DEPORTPR
 CHECK (
NPERIOD in (0,1,2,3,4,5)
 )
/
update deportprocedures set nperiod=0 where NPROCEDURE=27
/
commit
/


---------24/06/2004
INSERT INTO calcpointtype
(NCALCPOINTTYPE,VNAME)
VALUES
(3,'Расчет по дифтарифным актам')
/
commit
/


-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     24.06.2004  11:18
-- ============================================================

-- ============================================================
--   Table: DIFTARIFF
-- ============================================================
create table DIFTARIFF
(
    MID        NUMBER                 not null,
    DATE_TIME  DATE                   not null,
    AER        NUMBER                 null    ,
    BER        NUMBER                 null    ,
    CER        NUMBER                 null    ,
    DER        NUMBER                 null    ,
    AED        NUMBER                 null    ,
    BED        NUMBER                 null    ,
    CED        NUMBER                 null    ,
    DED        NUMBER                 null    ,
    AQ1        NUMBER                 null    ,
    BQ1        NUMBER                 null    ,
    CQ1        NUMBER                 null    ,
    DQ1        NUMBER                 null    ,
    AQ2        NUMBER                 null    ,
    BQ2        NUMBER                 null    ,
    CQ2        NUMBER                 null    ,
    DQ2        NUMBER                 null    ,
    AQ3        NUMBER                 null    ,
    BQ3        NUMBER                 null    ,
    CQ3        NUMBER                 null    ,
    DQ3        NUMBER                 null    ,
    AQ4        NUMBER                 null    ,
    BQ4        NUMBER                 null    ,
    CQ4        NUMBER                 null    ,
    DQ4        NUMBER                 null    ,
    constraint DIFTARIFF_PK primary key (MID, DATE_TIME)
)
/

comment on table DIFTARIFF is 'Дифтарифный акт'
/

comment on column DIFTARIFF.MID is 'Ид точки'
/

comment on column DIFTARIFF.DATE_TIME is 'Дата ввода'
/

comment on column DIFTARIFF.AER is 'Процент AER'
/

comment on column DIFTARIFF.BER is 'Процент BER'
/

comment on column DIFTARIFF.CER is 'Процент CER'
/

comment on column DIFTARIFF.DER is 'Процент DER'
/

comment on column DIFTARIFF.AED is 'Процент AED'
/

comment on column DIFTARIFF.BED is 'Процент BED'
/

comment on column DIFTARIFF.CED is 'Процент CED'
/

comment on column DIFTARIFF.DED is 'Процент DED'
/

comment on column DIFTARIFF.AQ1 is 'Процент AQ1'
/

comment on column DIFTARIFF.BQ1 is 'Процент BQ1'
/

comment on column DIFTARIFF.CQ1 is 'Процент CQ1'
/

comment on column DIFTARIFF.DQ1 is 'Процент DQ1'
/

comment on column DIFTARIFF.AQ2 is 'Процент AQ2'
/

comment on column DIFTARIFF.BQ2 is 'Процент BQ2'
/

comment on column DIFTARIFF.CQ2 is 'Процент CQ2'
/

comment on column DIFTARIFF.DQ2 is 'Процент DQ2'
/

comment on column DIFTARIFF.AQ3 is 'Процент AQ3'
/

comment on column DIFTARIFF.BQ3 is 'Процент BQ3'
/

comment on column DIFTARIFF.CQ3 is 'Процент CQ3'
/

comment on column DIFTARIFF.DQ3 is 'Процент DQ3'
/

comment on column DIFTARIFF.AQ4 is 'Процент AQ4'
/

comment on column DIFTARIFF.BQ4 is 'Процент BQ4'
/

comment on column DIFTARIFF.CQ4 is 'Процент CQ4'
/

comment on column DIFTARIFF.DQ4 is 'Процент DQ4'
/


-- ============================================================
--   Index: DIFTARIFF_IDX1
-- ============================================================
create index DIFTARIFF_IDX1 on DIFTARIFF (DATE_TIME asc)
/

alter table DIFTARIFF
    add constraint DIFTARIFF_F1 foreign key  (MID)
       references POINTS (MID) on delete cascade
/

/*
GRANT CREATE ANY TYPE TO RYDA
/
*/
---------26/06/2004   XOEXOEXOE
create or replace type vt_number as table of number
/


-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     06.07.2004  11:08
-- ============================================================
alter table HALFHOUROLD add
(
    QM           NUMBER                 null
)
/

comment on column HALFHOUROLD.QM is 'Метка качества'
/



/*
Только в ХЭС
INSERT INTO tasks
(TASK_ID,PARENT,TASK_COD,NAME,REMARK,NSHOW)
VALUES
(79,16,1000,'2.7 Настройка верификации','2.7 Настройка верификации',1)
/
commit
/
*/

-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     07.07.2004  18:09
-- ============================================================

-- ============================================================
--   Table: BILLOLD
-- ============================================================
alter table BILLOLD add
(
    QM           NUMBER                 null
)
/

comment on column BILLOLD.QM is 'Метка качества'
/

UPDATE DEPORTPROCEDURES SET VPROCEDURE='ryda.SWITCHES_PG.by_switchov' WHERE NPROCEDURE=15
/
commit
/


----------13/07/2004
delete from deportprocedures where NPROCEDURE in (28,29)
/
INSERT INTO deportprocedures
(NPROCEDURE,VNAME,VPROCEDURE,NPERIOD,NTYPE,VMEMO)
VALUES
(28,'Макет 30818','reports1_pg.m30818_p',2,0,'Макет 30818 (показания счетчиков)')
/
INSERT INTO deportprocedures
(NPROCEDURE,VNAME,VPROCEDURE,NPERIOD,NTYPE,VMEMO)
VALUES
(29,'Макет 30917','reports1_pg.m30917_p',2,0,'Макет 30917 (получасовые расходы эл. энергии)')
/
commit
/

-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     14.07.2004  16:27
-- ============================================================

-- ============================================================
--   Table: FEEDERS
-- ============================================================
alter table FEEDERS add
(
    VERIFYPARAM        VARCHAR2(256)          null
)
/

comment on column FEEDERS.VERIFYPARAM is 'Парам верификации'
/

update deportprocedures set VNAME='Верификация по дублирующим каналам измерения',vprocedure='ryda.check_pg.by_duplicatechannel' where nprocedure=6
/
insert into deportprocedures (nprocedure, vname, vprocedure, nperiod, ntype, vmemo)
values (30, 'Верификация по дублирующим счетчикам','ryda.check_pg.by_duplicatemeter', 2, 1, 'Процедура верификации по дублирующим счетчикам')
/
INSERT INTO points
(mid, name, parent, ind)
VALUES
(26,'Расчет ручных точек',2,1)
/
INSERT INTO points
(mid, name, parent, ind)
VALUES
(27,'Мониторинг опроса',2,1)
/
INSERT INTO points
(mid, name, parent, ind)
VALUES
(30,'Верификация по дублирующим счетчикам',2,1)
/
commit
/

drop package DEPORTPROCS_PG
/

insert into deportprocedures (nprocedure, vname, vprocedure, nperiod, ntype, vmemo)
values (31, 'Обновление мониторов','ryda.background01_pg.refreshmonitor', 0, 1, 'Процедура посылает широковещательный сигнал на обновление мониторов')
/
commit
/


delete from SLSTATUS where mid not in (select mid from points )
/
--------28.07.2004
alter table SLSTATUS
    add constraint SLSTATUS_FK foreign key  (MID)
       references POINTS (MID) on delete cascade
/


---------02.08.2004
alter table meters drop column ARIC_POS
/
alter table meters drop column ARIC_INV
/
alter table meters drop column DSHOW
/
alter table meters drop column NTRANSFORMER
/


-- Start of DDL Script for Trigger RYDA.ON_LOGOFF_FROM_SCHEMA
-- Generated 5-авг-2004 10:58:34 from RYDA@oe

CREATE OR REPLACE TRIGGER on_logoff_from_schema
 BEFORE
  LOGOFF
 ON SCHEMA
begin
if common_pg.username_f is not null then
admin_pg.fiscal_p(NULL, 3, 'Произведен выход из системы с компьютера: '||USERENV('TERMINAL'));
end if;
end;
/

alter table groups drop column LIMIT_ID
/
----------- 12.08.2004
insert into parameter (NPID,VVALUE,VDESCRIPTION) values(24,0,'Посылка сигнала на обновление мониторов после опроса канала')
/
commit
/

update CURR_POWER set date_time=trunc(sysdate)-1 where date_time is null
/

ALTER TABLE RYDA.CURR_POWER MODIFY
(
   DATE_TIME                  NOT NULL)
/



-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     13.08.2004  10:25
-- ============================================================

-- ============================================================
--   Table: TRANSFORMER
-- ============================================================
create table TRANSFORMER
(
    NTRANSFORMER       NUMBER(10)             not null,
    MID                NUMBER                 not null,
    VNAME              VARCHAR2(32)           not null,
    NTYPE              NUMBER(1)              not null
        constraint CKC_NTYPE_TRANSFOR check (NTYPE in (1,2)),
    DINSTALL           DATE                   not null,
    NVALUE1            NUMBER                 not null,
    NVALUE2            NUMBER                 not null,
    constraint TRANSFORMER_PK primary key (NTRANSFORMER)
)
/

comment on table TRANSFORMER is 'Трансформаторы'
/

comment on column TRANSFORMER.NTRANSFORMER is 'Ид трансформатора'
/

comment on column TRANSFORMER.MID is 'Ид подстанции'
/

comment on column TRANSFORMER.VNAME is 'Наименование'
/

comment on column TRANSFORMER.NTYPE is 'Тип'
/

comment on column TRANSFORMER.DINSTALL is 'Дата установки'
/

comment on column TRANSFORMER.NVALUE1 is 'Перв сторона'
/

comment on column TRANSFORMER.NVALUE2 is 'Втор сторона'
/


-- ============================================================
--   Index: TRANSFORMER_IDX1
-- ============================================================
create unique index TRANSFORMER_IDX1 on TRANSFORMER (MID asc, VNAME asc)
/

-- ============================================================
--   Table: FEEDERS
-- ============================================================
alter table FEEDERS add
(
    NTCURRENT          NUMBER(10)             null    ,
    NTPOWER            NUMBER(10)             null
)
/

comment on column FEEDERS.NTCURRENT is 'Трансформатор тока'
/

comment on column FEEDERS.NTPOWER is 'Трансформатор напряжения'
/

-- ============================================================
--   Index: FEEDERS_IDX5
-- ============================================================
create index FEEDERS_IDX5 on FEEDERS (NTCURRENT asc)
/

-- ============================================================
--   Index: FEEDERS_IDX6
-- ============================================================
create index FEEDERS_IDX6 on FEEDERS (NTPOWER asc)
/

-- ============================================================
--   Table: TRANSFORMERHISTORY
-- ============================================================
create table TRANSFORMERHISTORY
(
    NTRANSFORMER       NUMBER(10)             not null,
    DINSTALL           DATE                   not null,
    DEND               DATE                   not null,
    NVALUE1            NUMBER                 not null,
    NVALUE2            NUMBER                 not null,
    constraint TRANSFORMERHISTORY_PK primary key (NTRANSFORMER, DINSTALL)
)
/

comment on table TRANSFORMERHISTORY is 'История трансформаторов'
/

comment on column TRANSFORMERHISTORY.NTRANSFORMER is 'Ид трансформатора'
/

comment on column TRANSFORMERHISTORY.DINSTALL is 'Дата установки'
/

comment on column TRANSFORMERHISTORY.DEND is 'Дата снятия'
/

comment on column TRANSFORMERHISTORY.NVALUE1 is 'Перв сторона'
/

comment on column TRANSFORMERHISTORY.NVALUE2 is 'Втор сторона'
/


-- ============================================================
--   Index: TRANSFORMERHISTORY_IDX1
-- ============================================================
create index TRANSFORMERHISTORY_IDX1 on TRANSFORMERHISTORY (DINSTALL asc)
/

alter table TRANSFORMER
    add constraint TRANSFORMER_F1 foreign key  (MID)
       references POINTS (MID) on delete cascade
/


alter table FEEDERS
    add constraint FEEDERS_F5 foreign key  (NTCURRENT)
       references TRANSFORMER (NTRANSFORMER)
/

alter table FEEDERS
    add constraint FEEDERS_F6 foreign key  (NTPOWER)
       references TRANSFORMER (NTRANSFORMER)
/

alter table TRANSFORMERHISTORY
    add constraint TRANSFORMERHISTORY_F1 foreign key  (NTRANSFORMER)
       references TRANSFORMER (NTRANSFORMER) on delete cascade
/



--------10.09.2004

ALTER TABLE RYDA.curr_power MODIFY
(
   DATE_TIME                  DEFAULT sysdate)
/

INSERT INTO RYDA.PROTOCOLS
VALUES
(39,'УСД КМ1')
/
INSERT INTO RYDA.PROTOCOLS
VALUES
(40,'KM --> УСД КМ1')
/
INSERT INTO RYDA.PROTOCOLS
VALUES
(41,'LG_ZxD (IEC+echo)')
/

commit
/


-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     16.09.2004  12:23
-- ============================================================

alter table TRANSFORMER    add
(
    VTYPE         VARCHAR2(32)           null    ,
    NCLASS        NUMBER                 null
)
/

alter table TRANSFORMERHISTORY add
(
    VTYPE         VARCHAR2(32)           null    ,
    NCLASS        NUMBER                 null
)
/

comment on column TRANSFORMER.VTYPE is 'Тип трансформатора'
/

comment on column TRANSFORMER.NCLASS is 'Класс точности'
/

comment on column TRANSFORMERHISTORY.VTYPE is 'Тип трансформатора'
/

comment on column TRANSFORMERHISTORY.NCLASS is 'Класс точности'
/



----------22/10/2004
ALTER TABLE RYDA.CHANNELS MODIFY
(
   PROTOCOL_ID                NOT NULL,
   COM_ID                     NOT NULL)
/

insert into parameter (NPID,VVALUE,VDESCRIPTION) values(25,'1','Вести архив параметров сети 0-нет, 1-да, 2 при условии привышения')
/
-----Для метро харьков 2 -- для ЖОЭ и Киев ГАЭС и ТЕЦ-5

INSERT INTO db_term(TABLE_NAME,DATA_NAME,TERM,NARCHIVED,VINDIC_COLUMN,VEXTENTION)
VALUES('CURR_POWER_ARCH','Архив параметров сети',10000,0,'date_time','car')
/
commit
/

CREATE OR REPLACE TRIGGER curr_power_arch
AFTER UPDATE
ON curr_power
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
BEGIN
 admin_pg.curr_power_arch_ins_p(
  :NEW.mid, :NEW.date_time, :NEW.er, :NEW.q1, :NEW.q2, :NEW.ed, :NEW.q3, :NEW.q4, :NEW.erm, :NEW.q1m, :NEW.q2m, :NEW.edm,
  :NEW.q3m, :NEW.q4m, :NEW.freq, :NEW.cosf, :NEW.volt, :NEW.currento, :NEW.volt2, :NEW.volt3, :NEW.curr2, :NEW.curr3,
  :NEW.nfiu1, :NEW.nfiu2, :NEW.nfiu3, :NEW.nfii1, :NEW.nfii2, :NEW.nfii3);
END;
/





----------18/12/2004
-- ============================================================
--   Index: DEPORTATIONFILES_IDX2
-- ============================================================
create index DEPORTATIONFILES_IDX2 on DEPORTFILES (DDATE asc)
/


---------28/12/2004
INSERT INTO db_term
(TABLE_NAME,DATA_NAME,TERM,NARCHIVED,VINDIC_COLUMN,VEXTENTION)
VALUES
('TRAFFIC','Трафик сеансов связи',10000,0,'dopen','trf')
/

update db_term set table_name='BILLOLD' where table_name='BILL'
/

commit
/


-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     05.01.2005  11:33
-- ============================================================

alter table CHANNELS add
(
    VACCUSER        VARCHAR2(128)          null    ,
    VACCPASSWORD    VARCHAR2(128)          null
)
/

comment on column CHANNELS.VACCUSER is 'Пользователь доступа'
/

comment on column CHANNELS.VACCPASSWORD is 'Пароль доступа'
/






CREATE OR REPLACE VIEW bill_for_term (
   date_time,
   p1name,
   p2name,
   mid,
   er,
   q1,
   ed,
   q3,
   q2,
   q4,
   erm,
   q1m,
   edm,
   q3m,
   q2m,
   q4m,
   aer,
   aq1,
   aed,
   aq3,
   aq2,
   aq4,
   aerm,
   aq1m,
   aedm,
   aq3m,
   aq2m,
   aq4m,
   ber,
   bq1,
   bed,
   bq3,
   bq2,
   bq4,
   berm,
   bq1m,
   bedm,
   bq3m,
   bq2m,
   bq4m,
   cer,
   cq1,
   ced,
   cq3,
   cq2,
   cq4,
   cerm,
   cq1m,
   cedm,
   cq3m,
   cq2m,
   cq4m,
   der,
   dq1,
   ded,
   dq3,
   dq2,
   dq4,
   derm,
   dq1m,
   dedm,
   dq3m,
   dq2m,
   dq4m,
   kc,
   er_mtrsn )
AS
select
      b.date_time
  		,
      p1.Name p1Name, p2.Name p2Name, b.mid
      ,
      b.er, b.q1, b.ed, b.q3, b.q2, b.q4, b.erm, b.q1m, b.edm, b.q3m, b.q2m, b.q4m
      ,
      b.aer, b.aq1, b.aed, b.aq3, b.aq2, b.aq4, b.aerm, b.aq1m, b.aedm, b.aq3m, b.aq2m, b.aq4m
      ,
      b.ber, b.bq1, b.bed, b.bq3, b.bq2, b.bq4, b.berm, b.bq1m, b.bedm, b.bq3m, b.bq2m, b.bq4m
      ,
      b.cer, b.cq1, b.ced, b.cq3, b.cq2, b.cq4, b.cerm, b.cq1m, b.cedm, b.cq3m, b.cq2m, b.cq4m
      ,
      b.der, b.dq1, b.ded, b.dq3, b.dq2, b.dq4, b.derm, b.dq1m, b.dedm, b.dq3m, b.dq2m, b.dq4m
      ,
      f.kc, b.er_mtrsn
      from
        billevid b, points p1, points p2, feeders f
      where
      f.mid=p2.mid(+) and p2.parent=p1.mid(+) and f.mid=b.mid
/




CREATE OR REPLACE VIEW month_for_term (
   date_time,
   p1name,
   p2name,
   mid,
   er,
   q1,
   ed,
   q3,
   q2,
   q4,
   erm,
   q1m,
   edm,
   q3m,
   q2m,
   q4m,
   aer,
   aq1,
   aed,
   aq3,
   aq2,
   aq4,
   aerm,
   aq1m,
   aedm,
   aq3m,
   aq2m,
   aq4m,
   ber,
   bq1,
   bed,
   bq3,
   bq2,
   bq4,
   berm,
   bq1m,
   bedm,
   bq3m,
   bq2m,
   bq4m,
   cer,
   cq1,
   ced,
   cq3,
   cq2,
   cq4,
   cerm,
   cq1m,
   cedm,
   cq3m,
   cq2m,
   cq4m,
   der,
   dq1,
   ded,
   dq3,
   dq2,
   dq4,
   derm,
   dq1m,
   dedm,
   dq3m,
   dq2m,
   dq4m,
   kc,
   er_mtrsn )
AS
select
      b.date_time
  		,
      p1.Name p1Name, p2.Name p2Name, b.mid
      ,
      b.er, b.q1, b.ed, b.q3, b.q2, b.q4, b.erm, b.q1m, b.edm, b.q3m, b.q2m, b.q4m
      ,
      b.aer, b.aq1, b.aed, b.aq3, b.aq2, b.aq4, b.aerm, b.aq1m, b.aedm, b.aq3m, b.aq2m, b.aq4m
      ,
      b.ber, b.bq1, b.bed, b.bq3, b.bq2, b.bq4, b.berm, b.bq1m, b.bedm, b.bq3m, b.bq2m, b.bq4m
      ,
      b.cer, b.cq1, b.ced, b.cq3, b.cq2, b.cq4, b.cerm, b.cq1m, b.cedm, b.cq3m, b.cq2m, b.cq4m
      ,
      b.der, b.dq1, b.ded, b.dq3, b.dq2, b.dq4, b.derm, b.dq1m, b.dedm, b.dq3m, b.dq2m, b.dq4m
      ,
      f.kc, b.er_mtrsn
      from
        monthsevid b, points p1, points p2, feeders f
      where
      f.mid=p2.mid(+) and p2.parent=p1.mid(+) and f.mid=b.mid
/



------------- 08.02.2005
alter table GROUPS add
(
    NPARTLY             NUMBER(1)              null
        constraint CKC_NPARTLY_GROUPS check (NPARTLY is null or (NPARTLY in (1,2)))
)
/

comment on column GROUPS.NPARTLY is 'Признак частичного вхожд'
/


------------- 09.02.2005
INSERT INTO form_templates
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(82,40,1205,'5.04. Схема сети (Модус)','Схема электрической сети (Модус)','0000000',2,'-1')
/
commit
/



-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     21.02.2005  11:26
-- ============================================================
alter table METERSHISTORY add
(
    VMEMO      VARCHAR2(256)          null
)
/

comment on column METERSHISTORY.VMEMO is 'Примечание'
/

-------24.02.2005
begin
INSERT INTO deportprocedures(NPROCEDURE,VNAME,VPROCEDURE,NPERIOD,NTYPE,VMEMO)
select 5,'Макет 30817 с переносом остатков округлений','ryda.reports1_pg.arround_m30817',2,0,'' from dual
where not exists (select * from deportprocedures where NPROCEDURE=5);

update maketgroups set VCODE=replace(replace(VCODE,'('),')') where nmaket in
(select nmaket from makets where nprocedure in
(select nprocedure from deportprocedures where trim(upper(VPROCEDURE)) like '%REPORTS1_PG.M30817_P'));

update makets set nprocedure=5,vparam='1' where nprocedure in
(select nprocedure from deportprocedures where trim(upper(VPROCEDURE)) like '%REPORTS1_PG.M30817_P');

delete from deportprocedures where trim(upper(VPROCEDURE)) like '%REPORTS1_PG.M30817_P';
commit;
end;
/

--------------25.02.2005
INSERT INTO RYDA.PROTOCOLS
VALUES
(43,'ЕвроАльфа (упрощенный)')
/
INSERT INTO RYDA.PROTOCOLS
VALUES
(44,'KM --> ЕвроАльфа (упрощенный)')
/
INSERT INTO RYDA.PROTOCOLS
VALUES
(45,'АРГО')
/
INSERT INTO RYDA.PROTOCOLS
VALUES
(46,'KM --> АРГО')
/
commit
/

create table FULLJOURNAL
(
    DSYS        DATE                   null    ,
    VUSER       VARCHAR2(32)           null    ,
    VTYPE       VARCHAR2(1)            null    ,
    VTERMINAL   VARCHAR2(32)           null    ,
    NOPERATION  NUMBER(20)             null    ,
    VTABLE      VARCHAR2(32)           null    ,
    VCOLUMN     VARCHAR2(32)           null    ,
    VOLD        VARCHAR2(2000)         null    ,
    VNEW        VARCHAR2(2000)         null    ,
    VPK         VARCHAR2(2000)         null
)
/

comment on table FULLJOURNAL is 'Полный журнал'
/

comment on column FULLJOURNAL.DSYS is 'Дата'
/

comment on column FULLJOURNAL.VUSER is 'Пользователь'
/

comment on column FULLJOURNAL.VTYPE is 'Тип изменения'
/

comment on column FULLJOURNAL.VTERMINAL is 'Терминал'
/

comment on column FULLJOURNAL.NOPERATION is 'Операция'
/

comment on column FULLJOURNAL.VTABLE is 'Таблица'
/

comment on column FULLJOURNAL.VCOLUMN is 'Колонка'
/

comment on column FULLJOURNAL.VOLD is 'Старое'
/

comment on column FULLJOURNAL.VNEW is 'Новое'
/

comment on column FULLJOURNAL.VPK is 'Первичный ключ'
/


INSERT INTO db_term
(TABLE_NAME,DATA_NAME,TERM,NARCHIVED,VINDIC_COLUMN,VEXTENTION)
VALUES
('FULLJOURNAL','Журнал изменений БД',100,0,'dsys','dbj')
/

insert into parameter (NPID,VVALUE,VDESCRIPTION) values(26,0,'Признак ведения полного журнала действий')
/

commit
/

CREATE SEQUENCE journal_seq MINVALUE 1 MAXVALUE 999999999999999999999999999
  INCREMENT BY 1 START WITH 1000 CACHE 20 NOORDER NOCYCLE
/



begin
delete from form_templates where TEMPLATE_ID in (21,22,26,30,32,34);
commit;
end;
/

--------------09/03/2005
/*delete from form_templates where TEMPLATE_ID=41
/
*/

INSERT INTO form_templates
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(41,NULL,NULL,'6. Макеты','Макеты','0000000',0,NULL)
/

INSERT INTO form_templates
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(83,41,1450,'6.1. Отосланные макеты 30817','Отосланные макеты 30817','1001010',0,NULL)
/

commit
/

---------------21/03/2005
--delete from tasks where TASK_ID in (80,81)
INSERT INTO tasks
(TASK_ID,PARENT,TASK_COD,NAME,REMARK,NSHOW)
VALUES
(80,NULL,0,'9. Операции','9. Операции, доступные для выбранной роли',0)
/

INSERT INTO tasks
(TASK_ID,PARENT,TASK_COD,NAME,REMARK,NSHOW)
VALUES
(81,80,650,'9.01 Сохранение и редактирование мониторов','9.01 Сохранение и редактирование мониторов',0)
/

insert into role_task
select distinct ROLE_ID,81,1 from users where ADMIN='*'
/

insert into role_task
select distinct ROLE_ID,80,1 from users where ADMIN='*'
/

commit
/

-- ============================================================
--   Index: TASKS_IDX1
-- ============================================================
create index TASKS_IDX1 on TASKS (PARENT asc)
/

alter table TASKS
    add constraint TASKS_F1 foreign key  (PARENT)
       references TASKS (TASK_ID) on delete cascade
/


-----------23/03/2005
declare
ln_nmaket NUMBER;
begin
 insert into deportprocedures (nprocedure, vname, vprocedure, nperiod, ntype, vmemo)
 values (32, 'Перерасчет суточных расходов','ryda.das_pg.recalcperiod', 2, 1, 'Перерасчет суточных расходов');
makets_pg.ins_m(32,'Перерасчет суточных расходов','',1,0,0,'',ln_nmaket);
commit;
end;
/


-----------01/04/2005
update protocols set NAME='УСПД КМ-64' where PROTOCOL_ID=39
/

update protocols set NAME='KM --> УСПД КМ-64' where PROTOCOL_ID=40
/

commit
/


-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     05.04.2005  10:31
-- ============================================================

-- ============================================================
--   Table: FEEDERS
-- ============================================================
alter table FEEDERS add
(
    VADDPARAMS         VARCHAR2(512)          null
)
/


comment on column FEEDERS.VADDPARAMS is 'Дополнительные параметры'
/




----------20/04/2005
INSERT INTO tasks
(TASK_ID,PARENT,TASK_COD,NAME,REMARK,NSHOW)
VALUES
(82,80,651,'9.02 Переход на резервный сервер','9.02 Переход на резервный сервер',0)
/

insert into role_task
select distinct ROLE_ID,82,1 from users where ADMIN='*'
/

commit
/


----13/05/2005
INSERT INTO RYDA.PROTOCOLS
VALUES
(47,'Элвин')
/
INSERT INTO RYDA.PROTOCOLS
VALUES
(48,'KM --> Элвин')
/
INSERT INTO RYDA.PROTOCOLS
VALUES
(49,'SL-7000 (dlms)')
/
INSERT INTO RYDA.PROTOCOLS
VALUES
(50,'KM --> SL-7000 (dlms)')
/
commit
/


-----------------------------------
--07/06/2005
update protocols set NAME='УСПД КМ-64 (эхо)' where PROTOCOL_ID=39
/

update protocols set NAME='KM --> УСПД КМ-64 (эхо)' where PROTOCOL_ID=40
/

update protocols set NAME='УСПД КМ-64' where PROTOCOL_ID=14
/

update protocols set NAME='KM --> УСПД КМ-64' where PROTOCOL_ID=15
/

commit
/



-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     08.06.2005  15:36
-- ============================================================

-- ============================================================
--   Table: COPYFILES
-- ============================================================
create table COPYFILES
(
    CID        NUMBER(10)             not null,
    VFILENAME  VARCHAR2(64)           not null,
    DENTER     DATE                   default sysdate not null,
    DFILEDATE  DATE                   not null,
    constraint COPYFILES_PK primary key (CID, VFILENAME)
)
/

comment on table COPYFILES is 'Скопированые файлы'
/

comment on column COPYFILES.CID is 'Ид канала'
/

comment on column COPYFILES.VFILENAME is 'Название файла'
/

comment on column COPYFILES.DENTER is 'Дата копирования'
/

comment on column COPYFILES.DFILEDATE is 'Дата файла'
/


alter table COPYFILES
    add constraint COPYFILES_F1 foreign key  (CID)
       references CHANNELS (CID) on delete cascade
/


---------- 14/06/2005
-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     14.06.2005  15:14
-- ============================================================
alter table CONNECTIONPARAM add
(
    NWINDING             NUMBER(1)              default 0 not null
        constraint CKC_NWINDING_CONNECTI check (NWINDING in (0,1,2,3))
)
/

comment on column CONNECTIONPARAM.NWINDING is 'Номер обмотки'
/

update points set ind=1 where ind is null
/

create index POINTS_IDX2 on POINTS (IND asc)
/

-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     14.06.2005  10:33
-- ============================================================

-- ============================================================
--   Table: DICT_OBJ_TYPES
-- ============================================================
create table DICT_OBJ_TYPES
(
    IND    NUMBER(10)             not null,
    VNAME  VARCHAR2(128)          not null,
    constraint DICT_OBJ_TYPES_PK1 primary key (IND)
)
/

comment on table DICT_OBJ_TYPES is 'Типы объектов'
/

comment on column DICT_OBJ_TYPES.IND is 'Ид типа объекта'
/

comment on column DICT_OBJ_TYPES.VNAME is 'Название типа объекта'
/

insert into DICT_OBJ_TYPES(ind,vname) values(1,'Обобщенный объект 1-го уровня')
/

insert into DICT_OBJ_TYPES(ind,vname) values(2,'Обобщенный объект 2-го уровня')
/

insert into DICT_OBJ_TYPES(ind,vname) values(3,'Точка учета')
/

insert into DICT_OBJ_TYPES(ind,vname) values(600,'Силовой трансформатор (двухобмлточный)')
/

insert into DICT_OBJ_TYPES(ind,vname) values(610,'Силовой трансформатор (трехобмлточный)')
/

insert into DICT_OBJ_TYPES(ind,vname) values(500,'Линия')
/

alter table POINTS
    add constraint POINTS_F1 foreign key  (IND)
       references DICT_OBJ_TYPES (IND)
/


comment on column CONNECTIONPARAM.NCONNECTIONPARAM is 'Ид параметра'
/

comment on column CONNECTIONPARAM.MID is 'Ид точки'
/

comment on column CONNECTIONPARAM.VNAME is 'Название'
/

comment on column CONNECTIONPARAM.NSN is 'Номинальная мощность кВА (Sn)'
/

comment on column CONNECTIONPARAM.NSH is 'Номинальная мощность кВА обмотки (Sh)'
/

comment on column CONNECTIONPARAM.NDELTAPIDLING is 'Потери холостого хода кВт (Pxx)'
/

comment on column CONNECTIONPARAM.NDELTAPSC is 'Потери короткого замыкания кВт (Pкз)'
/

comment on column CONNECTIONPARAM.NIIDLING is 'Ток холостого хода (Ixx)'
/

comment on column CONNECTIONPARAM.NUSC is 'Напряжение короткого замыкания (Uкz)'
/

comment on column CONNECTIONPARAM.NRO is 'Активное сопротивление (Ro)'
/

comment on column CONNECTIONPARAM.NXO is 'Реактивное сопротивление (Xo)'
/

comment on column CONNECTIONPARAM.NL is 'Длина линии км (L)'
/

comment on column CONNECTIONPARAM.NUN is 'Номинальное напряжение В (Un)'
/

comment on column CONNECTIONPARAM.NWORKINGHOURS is 'Номинальное время работы'
/

comment on column CONNECTIONPARAM.NFULLHOURS is 'Номинальное полное время'
/

comment on column CONNECTIONPARAM.NNOTINCLUDECONSUMP is 'Расход не учитывать'
/

comment on column CONNECTIONPARAM.NPARALLELCONNECTION is 'Паралельное соединение'
/

comment on column CONNECTIONPARAM.NENERGYPERCENT is 'Процент потерь Актив'
/

comment on column CONNECTIONPARAM.NRENERGYPERCENT is 'Процент потерь Реактив'
/

comment on column CONNECTIONPARAM.NPROCENT is 'Потери в процентах'
/

comment on column CONNECTIONPARAM.NWINDING is 'Номер обмотки'
/



-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     14.06.2005  16:02
-- ============================================================

-- ============================================================
--   Table: JOURNALLAST
-- ============================================================
create table JOURNALLAST
(
    DATE_TIME    DATE                   null    ,
    MID          NUMBER                 null    ,
    STATE_COD    NUMBER                 null    ,
    STATE_DESCR  VARCHAR2(512)          null
)
/

comment on table JOURNALLAST is 'Системный журнал (оперативный)'
/

comment on column JOURNALLAST.DATE_TIME is 'Дата'
/

comment on column JOURNALLAST.MID is 'Ид точки'
/

comment on column JOURNALLAST.STATE_COD is 'Код сообщения'
/

comment on column JOURNALLAST.STATE_DESCR is 'Сообщение'
/


/*insert into JOURNALLAST(DATE_TIME,MID,STATE_COD,STATE_DESCR)
select DATE_TIME,MID,STATE_COD,STATE_DESCR from journal where submit is null
/
*/
-- ============================================================
--   Index: JOURNALLAST_IDX12
-- ============================================================
create index JOURNALLAST_IDX12 on JOURNALLAST (MID asc)
/

-- ============================================================
--   Index: JOURNALLAST_IDX22
-- ============================================================
create index JOURNALLAST_IDX22 on JOURNALLAST (DATE_TIME asc)
/

alter table JOURNALLAST
    add constraint JOURNALLAST_REF foreign key  (MID)
       references POINTS (MID) on delete cascade
/

alter table JOURNAL drop column submit
/

ALTER TABLE JOURNAL MODIFY
(
   DATE_TIME                  DEFAULT sysdate NOT NULL,
   MID                        DEFAULT 1000 NOT NULL)
/

ALTER TABLE JOURNALLAST MODIFY
(
   DATE_TIME                  DEFAULT sysdate NOT NULL,
   MID                        DEFAULT 1000 NOT NULL)
/

-- Trigger JOURNAL_TR1

CREATE OR REPLACE TRIGGER journal_tr1
AFTER INSERT
ON journal
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
BEGIN
 INSERT INTO journallast
             (mid, date_time, state_cod, state_descr)
      VALUES (:NEW.mid, :NEW.date_time, :NEW.state_cod, :NEW.state_descr);
END;
/

/*DROP PACKAGE TRANSFORMER_PG
/
DROP PACKAGE EDITTRANSFORMER_PG
/
*/


-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     25.06.2005  12:36
-- ============================================================

-- ============================================================
--   Table: CALCBYDUPLICATION
-- ============================================================
create table CALCBYDUPLICATION
(
    MID      NUMBER                 not null,
    DSTART   DATE                   not null,
    DEND     DATE                   null    ,
    VMEMO    VARCHAR2(512)          null    ,
    USER_ID  NUMBER                 not null,
    DENTER   DATE                   default SYSDATE not null,
    constraint CALCBYDUPLICATION_PK primary key (MID, DSTART)
)
/

comment on table CALCBYDUPLICATION is 'Расчет по дублирующему сч'
/

comment on column CALCBYDUPLICATION.MID is 'Ид дублирующего сч'
/

comment on column CALCBYDUPLICATION.DSTART is 'Дата начала учета'
/

comment on column CALCBYDUPLICATION.DEND is 'Дата окончпния учета'
/

comment on column CALCBYDUPLICATION.VMEMO is 'Основание'
/

comment on column CALCBYDUPLICATION.USER_ID is 'Ид пользователя'
/

comment on column CALCBYDUPLICATION.DENTER is 'Дата ввода'
/


-- ============================================================
--   Index: CALCBYDUPLICATION_IDX1
-- ============================================================
create index CALCBYDUPLICATION_IDX1 on CALCBYDUPLICATION (DSTART asc)
/

-- ============================================================
--   Index: CALCBYDUPLICATION_IDX2
-- ============================================================
create index CALCBYDUPLICATION_IDX2 on CALCBYDUPLICATION (USER_ID asc)
/

alter table CALCBYDUPLICATION
    add constraint CALCBYDUPLICATION_F1 foreign key  (MID)
       references POINTS (MID)
/

alter table CALCBYDUPLICATION
    add constraint CALCBYDUPLICATION_F2 foreign key  (USER_ID)
       references USERS (USER_ID)
/

INSERT INTO tasks
(TASK_ID,PARENT,TASK_COD,NAME,REMARK)
VALUES
(91,16,73,'2.81 Учет электроэнергии по дублирующим счетчикам',NULL)
/
commit
/


----------11/07/2005
INSERT INTO form_templates
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(84,40,1206,'5.2.1 Форма отчета (Excel - внешний)','5.2.1 Форма отчета (Excel - внешний)','1100010',1,NULL)
/
commit
/


grant execute on waste_pg to askuerep
/

------19/07/2005
-- ============================================================
--   Index: FULLJOURNAL_IDX1
-- ============================================================
create index FULLJOURNAL_IDX1 on FULLJOURNAL (DSYS asc)
/


------25/07/2005
INSERT INTO RYDA.PROTOCOLS
VALUES
(51,'Тест MOXA NPort')
/
commit
/


--------------14/09/2005
  INSERT INTO dict_obj_types
VALUES
(4,'Расчетная точка (для копирования данных с основного или дублирующего счетчиков)')
/

INSERT INTO tasks
(TASK_ID,PARENT,TASK_COD,NAME,REMARK,NSHOW)
VALUES
(77,NULL,0,'6. Инструментарий',NULL,0)
/

/*
INSERT INTO tasks
(TASK_ID,PARENT,TASK_COD,NAME,REMARK,NSHOW)
VALUES
(78,77,630,'6.01 Терминал показаний','Терминал показаний',0)
/
*/

INSERT INTO tasks
(TASK_ID,PARENT,TASK_COD,NAME,REMARK,NSHOW)
VALUES
(83,77,631,'6.02 Терминал опроса','Терминал опроса',0)
/

CREATE GLOBAL TEMPORARY TABLE rep_classic
    (gid                            NUMBER,
    objtype                        NUMBER,
    nlevel                         NUMBER,
    name                           VARCHAR2(300),
    etype                          VARCHAR2(10),
    mtype                          VARCHAR2(20),
    mtrsn                          VARCHAR2(20),
    edate                          DATE,
    em                             VARCHAR2(20),
    sdate                          DATE,
    sm                             VARCHAR2(20),
    dif                            NUMBER,
    kc                             NUMBER,
    cons                           NUMBER,
    waste                          NUMBER,
    nall                           NUMBER,
    norder                         NUMBER)
ON COMMIT PRESERVE ROWS
/

COMMENT ON COLUMN rep_classic.cons IS 'расход'
/
COMMENT ON COLUMN rep_classic.dif IS 'разность показаний'
/
COMMENT ON COLUMN rep_classic.edate IS 'Дата конечных показаний'
/
COMMENT ON COLUMN rep_classic.em IS 'конечные показания'
/
COMMENT ON COLUMN rep_classic.etype IS 'тип измерения'
/
COMMENT ON COLUMN rep_classic.gid IS 'ИД группы'
/
COMMENT ON COLUMN rep_classic.kc IS 'коэффициент'
/
COMMENT ON COLUMN rep_classic.mtrsn IS 'номер счетчика'
/
COMMENT ON COLUMN rep_classic.mtype IS 'тип счетчика'
/
COMMENT ON COLUMN rep_classic.nall IS 'расход +  потери'
/
COMMENT ON COLUMN rep_classic.name IS 'название присоед.'
/
COMMENT ON COLUMN rep_classic.nlevel IS 'уровень в дереве'
/
COMMENT ON COLUMN rep_classic.norder IS 'сортировка'
/
COMMENT ON COLUMN rep_classic.objtype IS 'признак группы 0 - группа 1-точка'
/
COMMENT ON COLUMN rep_classic.sdate IS 'Дата начальных показаний'
/
COMMENT ON COLUMN rep_classic.sm IS 'начальные показания'
/
COMMENT ON COLUMN rep_classic.waste IS 'протери'
/

grant execute on reports3_pg to askuerep
/

CREATE SEQUENCE rep_seq
  INCREMENT BY 1
  START WITH 1862
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  CYCLE
  NOORDER
  CACHE 20
/
-----------------------19.09.2005




CREATE GLOBAL TEMPORARY TABLE rep_receiv_deliv
    (gid                            NUMBER,
    objtype                        NUMBER,
    nlevel                         NUMBER,
    name                           VARCHAR2(300),
    ermtype                          VARCHAR2(20),
    ermtrsn                          VARCHAR2(20),
    eredate                          DATE,
    erem                             VARCHAR2(20),
    ersdate                          DATE,
    ersm                             VARCHAR2(20),
    erdif                            NUMBER,
    erkc                             NUMBER,
    ercons                           NUMBER,
    edmtype                          VARCHAR2(20),
    edmtrsn                          VARCHAR2(20),
    ededate                          DATE,
    edem                             VARCHAR2(20),
    edsdate                          DATE,
    edsm                             VARCHAR2(20),
    eddif                            NUMBER,
    edkc                             NUMBER,
    edcons                           NUMBER,
    norder                         NUMBER
    )
ON COMMIT PRESERVE ROWS
/




-- Comments for rep_receiv_deliv

COMMENT ON COLUMN rep_receiv_deliv.gid IS 'ИД группы'
/
COMMENT ON COLUMN rep_receiv_deliv.objtype IS 'признак группы 0 - группа 1-точка'
/
COMMENT ON COLUMN rep_receiv_deliv.nlevel IS 'уровень в дереве'
/
COMMENT ON COLUMN rep_receiv_deliv.name IS 'название присоед.'
/
COMMENT ON COLUMN rep_receiv_deliv.ermtype IS 'тип счетчика приема'
/
COMMENT ON COLUMN rep_receiv_deliv.ermtrsn IS 'номер счетчика приема'
/
COMMENT ON COLUMN rep_receiv_deliv.eredate IS 'Дата конечных показаний приема'
/
COMMENT ON COLUMN rep_receiv_deliv.erem IS 'конечные показания приема'
/
COMMENT ON COLUMN rep_receiv_deliv.ersdate IS 'Дата начальных показаний приема'
/
COMMENT ON COLUMN rep_receiv_deliv.ersm IS 'начальные показания приема'
/
COMMENT ON COLUMN rep_receiv_deliv.erdif IS 'разность показаний приема'
/
COMMENT ON COLUMN rep_receiv_deliv.erkc IS 'коэффициент'
/
COMMENT ON COLUMN rep_receiv_deliv.ercons IS 'расход приема'
/
COMMENT ON COLUMN rep_receiv_deliv.edmtype IS 'тип счетчика отдачи'
/
COMMENT ON COLUMN rep_receiv_deliv.edmtrsn IS 'номер счетчика отдачи'
/
COMMENT ON COLUMN rep_receiv_deliv.ededate IS 'Дата конечных показаний отдачи'
/
COMMENT ON COLUMN rep_receiv_deliv.edem IS 'конечные показания отдачи'
/
COMMENT ON COLUMN rep_receiv_deliv.edsdate IS 'Дата начальных показаний отдачи'
/
COMMENT ON COLUMN rep_receiv_deliv.edsm IS 'начальные показания отдачи'
/
COMMENT ON COLUMN rep_receiv_deliv.eddif IS 'разность показаний отдачи'
/
COMMENT ON COLUMN rep_receiv_deliv.edkc IS 'коэффициент'
/
COMMENT ON COLUMN rep_receiv_deliv.edcons IS 'расход отдачи'
/
COMMENT ON COLUMN rep_receiv_deliv.norder IS 'сортировка'
/

-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     29.09.2005  15:52
-- ============================================================
INSERT INTO calcpointtype
(NCALCPOINTTYPE,VNAME)
VALUES
(4,'Ручной ввод расхода')
/
commit
/
-- ============================================================
--   Table: FEEDERS
-- ============================================================
alter table FEEDERS add
(

    VIMPORTCODE        VARCHAR2(64)           null
)
/


comment on column FEEDERS.VIMPORTCODE is 'Связной код импорта'
/

update feeders set VIMPORTCODE=decode(canal,0,'',canal)
where mid in (select cp.mid from chanpoint cp,channels c where c.cid=cp.cid and c.PROTOCOL_ID in (37,38))
/

commit
/


-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     04.10.2005  15:37
-- ============================================================

alter table LAST_SAVE add
(
    FAIL         DATE                   null
)
/
comment on column LAST_SAVE.FAIL is 'Последняя неудача'
/




CREATE OR REPLACE VIEW billevid (
   mid,
   date_time,
   valid,
   source,
   remark,
   er_mtrsn,
   er_kc,
   erm,
   er,
   aerm,
   aer,
   berm,
   ber,
   cerm,
   cer,
   derm,
   der,
   q1_mtrsn,
   q1_kc,
   q1m,
   q1,
   aq1m,
   aq1,
   bq1m,
   bq1,
   cq1m,
   cq1,
   dq1m,
   dq1,
   ed_mtrsn,
   ed_kc,
   edm,
   ed,
   aedm,
   aed,
   bedm,
   bed,
   cedm,
   ced,
   dedm,
   ded,
   q3_mtrsn,
   q3_kc,
   q3m,
   q3,
   aq3m,
   aq3,
   bq3m,
   bq3,
   cq3m,
   cq3,
   dq3m,
   dq3,
   q2_mtrsn,
   q2_kc,
   q2m,
   q2,
   aq2m,
   aq2,
   bq2m,
   bq2,
   cq2m,
   cq2,
   dq2m,
   dq2,
   q4_mtrsn,
   q4_kc,
   q4m,
   q4,
   aq4m,
   aq4,
   bq4m,
   bq4,
   cq4m,
   cq4,
   dq4m,
   dq4,
   denter )
AS
SELECT
    MID,
    DATE_TIME,
    VALID,
    SOURCE,
    REMARK,
    ER_MTRSN,
    ER_KC,
    ERM,
    ER,
    AERM,
    AER,
    BERM,
    BER,
    CERM,
    CER,
    DERM,
    DER,
    Q1_MTRSN,
    Q1_KC,
    Q1M,
    Q1,
    AQ1M,
    AQ1,
    BQ1M,
    BQ1,
    CQ1M,
    CQ1,
    DQ1M,
    DQ1,
    ED_MTRSN,
    ED_KC,
    EDM,
    ED,
    AEDM,
    AED,
    BEDM,
    BED,
    CEDM,
    CED,
    DEDM,
    DED,
    Q3_MTRSN,
    Q3_KC,
    Q3M,
    Q3,
    AQ3M,
    AQ3,
    BQ3M,
    BQ3,
    CQ3M,
    CQ3,
    DQ3M,
    DQ3,
    Q2_MTRSN,
    Q2_KC,
    Q2M,
    Q2,
    AQ2M,
    AQ2,
    BQ2M,
    BQ2,
    CQ2M,
    CQ2,
    DQ2M,
    DQ2,
    Q4_MTRSN,
    Q4_KC,
    Q4M,
    Q4,
    AQ4M,
    AQ4,
    BQ4M,
    BQ4,
    CQ4M,
    CQ4,
    DQ4M,
    DQ4,
    denter
 FROM RYDA.BILLORG
/

-- End of DDL script for BILLEVID

-- Start of DDL script for BILL_FOR_TERM
-- Generated 4-окт-05  5:54:07 pm
-- from oe-RYDA:4

-- View BILL_FOR_TERM

CREATE OR REPLACE VIEW bill_for_term (
   date_time,
   p1name,
   p2name,
   mid,
   er,
   q1,
   ed,
   q3,
   q2,
   q4,
   erm,
   q1m,
   edm,
   q3m,
   q2m,
   q4m,
   aer,
   aq1,
   aed,
   aq3,
   aq2,
   aq4,
   aerm,
   aq1m,
   aedm,
   aq3m,
   aq2m,
   aq4m,
   ber,
   bq1,
   bed,
   bq3,
   bq2,
   bq4,
   berm,
   bq1m,
   bedm,
   bq3m,
   bq2m,
   bq4m,
   cer,
   cq1,
   ced,
   cq3,
   cq2,
   cq4,
   cerm,
   cq1m,
   cedm,
   cq3m,
   cq2m,
   cq4m,
   der,
   dq1,
   ded,
   dq3,
   dq2,
   dq4,
   derm,
   dq1m,
   dedm,
   dq3m,
   dq2m,
   dq4m,
   kc,
   er_mtrsn,
   denter )
AS
select
      b.date_time
  		,
      p1.Name p1Name, p2.Name p2Name, b.mid
      ,
      b.er, b.q1, b.ed, b.q3, b.q2, b.q4, b.erm, b.q1m, b.edm, b.q3m, b.q2m, b.q4m
      ,
      b.aer, b.aq1, b.aed, b.aq3, b.aq2, b.aq4, b.aerm, b.aq1m, b.aedm, b.aq3m, b.aq2m, b.aq4m
      ,
      b.ber, b.bq1, b.bed, b.bq3, b.bq2, b.bq4, b.berm, b.bq1m, b.bedm, b.bq3m, b.bq2m, b.bq4m
      ,
      b.cer, b.cq1, b.ced, b.cq3, b.cq2, b.cq4, b.cerm, b.cq1m, b.cedm, b.cq3m, b.cq2m, b.cq4m
      ,
      b.der, b.dq1, b.ded, b.dq3, b.dq2, b.dq4, b.derm, b.dq1m, b.dedm, b.dq3m, b.dq2m, b.dq4m
      ,
      f.kc, b.er_mtrsn,b.denter
      from
        billevid b, points p1, points p2, feeders f
      where
      f.mid=p2.mid(+) and p2.parent=p1.mid(+) and f.mid=b.mid
/

-- End of DDL script for BILL_FOR_TERM

-- Start of DDL script for HALFHOUR
-- Generated 4-окт-05  5:54:08 pm
-- from oe-RYDA:4

-- View HALFHOUR

CREATE OR REPLACE VIEW halfhour (
   mid,
   date_time,
   er,
   q1,
   ed,
   q3,
   q2,
   q4,
   erm,
   q1m,
   edm,
   q3m,
   q2m,
   q4m,
   status,
   nkc,
   nsource,
   er_mtrsn,
   nswitch,
   denter )
AS
SELECT
    MID,
    DATE_TIME,
    ER,
    Q1,
    ED,
    Q3,
    Q2,
    Q4,
    ERM,
    Q1M,
    EDM,
    Q3M,
    Q2M,
    Q4M,
    STATUS,
    NKC,
    NSOURCE,
    ER_MTRSN,
    NSWITCH,
    DENTER
 FROM RYDA.HALFHOUROLD WHERE NEXCEPTCALC IS NULL and nsource>0
/

COMMENT ON TABLE halfhour IS 'График нагрузки'
/

-- End of DDL script for HALFHOUR

-- Start of DDL script for HALFHOUREVID
-- Generated 4-окт-05  5:54:08 pm
-- from oe-RYDA:4

-- View HALFHOUREVID

CREATE OR REPLACE VIEW halfhourevid (
   mid,
   date_time,
   er,
   q1,
   ed,
   q3,
   q2,
   q4,
   erm,
   q1m,
   edm,
   q3m,
   q2m,
   q4m,
   status,
   nkc,
   denter )
AS
SELECT
    MID,
    DATE_TIME,
    ER,
    Q1,
    ED,
    Q3,
    Q2,
    Q4,
    ERM,
    Q1M,
    EDM,
    Q3M,
    Q2M,
    Q4M,
    STATUS,
    NKC,
    denter
 FROM RYDA.HALFHOURold
/

-- Start of DDL script for MONTHS
-- Generated 4-окт-05  5:54:08 pm
-- from oe-RYDA:4

-- View MONTHS

CREATE OR REPLACE VIEW months (
   mid,
   date_time,
   valid,
   source,
   remark,
   er_mtrsn,
   er_kc,
   erm,
   er,
   aerm,
   aer,
   berm,
   ber,
   cerm,
   cer,
   derm,
   der,
   q1_mtrsn,
   q1_kc,
   q1m,
   q1,
   aq1m,
   aq1,
   bq1m,
   bq1,
   cq1m,
   cq1,
   dq1m,
   dq1,
   ed_mtrsn,
   ed_kc,
   edm,
   ed,
   aedm,
   aed,
   bedm,
   bed,
   cedm,
   ced,
   dedm,
   ded,
   q3_mtrsn,
   q3_kc,
   q3m,
   q3,
   aq3m,
   aq3,
   bq3m,
   bq3,
   cq3m,
   cq3,
   dq3m,
   dq3,
   q2_mtrsn,
   q2_kc,
   q2m,
   q2,
   aq2m,
   aq2,
   bq2m,
   bq2,
   cq2m,
   cq2,
   dq2m,
   dq2,
   q4_mtrsn,
   q4_kc,
   q4m,
   q4,
   aq4m,
   aq4,
   bq4m,
   bq4,
   cq4m,
   cq4,
   dq4m,
   dq4,
   nwasteabs,
   nsource,
   denter )
AS
SELECT
    MID,
    DATE_TIME,
    VALID,
    SOURCE,
    REMARK,
    ER_MTRSN,
    ER_KC,
    ERM,
    ER,
    AERM,
    AER,
    BERM,
    BER,
    CERM,
    CER,
    DERM,
    DER,
    Q1_MTRSN,
    Q1_KC,
    Q1M,
    Q1,
    AQ1M,
    AQ1,
    BQ1M,
    BQ1,
    CQ1M,
    CQ1,
    DQ1M,
    DQ1,
    ED_MTRSN,
    ED_KC,
    EDM,
    ED,
    AEDM,
    AED,
    BEDM,
    BED,
    CEDM,
    CED,
    DEDM,
    DED,
    Q3_MTRSN,
    Q3_KC,
    Q3M,
    Q3,
    AQ3M,
    AQ3,
    BQ3M,
    BQ3,
    CQ3M,
    CQ3,
    DQ3M,
    DQ3,
    Q2_MTRSN,
    Q2_KC,
    Q2M,
    Q2,
    AQ2M,
    AQ2,
    BQ2M,
    BQ2,
    CQ2M,
    CQ2,
    DQ2M,
    DQ2,
    Q4_MTRSN,
    Q4_KC,
    Q4M,
    Q4,
    AQ4M,
    AQ4,
    BQ4M,
    BQ4,
    CQ4M,
    CQ4,
    DQ4M,
    DQ4,
    NWASTEABS,
    nsource,
    DENTER
 FROM MONTHSORG
/

-- End of DDL script for MONTHS

-- Start of DDL script for MONTHSEVID
-- Generated 4-окт-05  5:54:08 pm
-- from oe-RYDA:4

-- View MONTHSEVID

CREATE OR REPLACE VIEW monthsevid (
   mid,
   date_time,
   valid,
   source,
   remark,
   er_mtrsn,
   er_kc,
   erm,
   er,
   aerm,
   aer,
   berm,
   ber,
   cerm,
   cer,
   derm,
   der,
   q1_mtrsn,
   q1_kc,
   q1m,
   q1,
   aq1m,
   aq1,
   bq1m,
   bq1,
   cq1m,
   cq1,
   dq1m,
   dq1,
   ed_mtrsn,
   ed_kc,
   edm,
   ed,
   aedm,
   aed,
   bedm,
   bed,
   cedm,
   ced,
   dedm,
   ded,
   q3_mtrsn,
   q3_kc,
   q3m,
   q3,
   aq3m,
   aq3,
   bq3m,
   bq3,
   cq3m,
   cq3,
   dq3m,
   dq3,
   q2_mtrsn,
   q2_kc,
   q2m,
   q2,
   aq2m,
   aq2,
   bq2m,
   bq2,
   cq2m,
   cq2,
   dq2m,
   dq2,
   q4_mtrsn,
   q4_kc,
   q4m,
   q4,
   aq4m,
   aq4,
   bq4m,
   bq4,
   cq4m,
   cq4,
   dq4m,
   dq4,
   denter )
AS
SELECT
    MID,
    DATE_TIME,
    VALID,
    SOURCE,
    REMARK,
    ER_MTRSN,
    ER_KC,
    ERM,
    ER,
    AERM,
    AER,
    BERM,
    BER,
    CERM,
    CER,
    DERM,
    DER,
    Q1_MTRSN,
    Q1_KC,
    Q1M,
    Q1,
    AQ1M,
    AQ1,
    BQ1M,
    BQ1,
    CQ1M,
    CQ1,
    DQ1M,
    DQ1,
    ED_MTRSN,
    ED_KC,
    EDM,
    ED,
    AEDM,
    AED,
    BEDM,
    BED,
    CEDM,
    CED,
    DEDM,
    DED,
    Q3_MTRSN,
    Q3_KC,
    Q3M,
    Q3,
    AQ3M,
    AQ3,
    BQ3M,
    BQ3,
    CQ3M,
    CQ3,
    DQ3M,
    DQ3,
    Q2_MTRSN,
    Q2_KC,
    Q2M,
    Q2,
    AQ2M,
    AQ2,
    BQ2M,
    BQ2,
    CQ2M,
    CQ2,
    DQ2M,
    DQ2,
    Q4_MTRSN,
    Q4_KC,
    Q4M,
    Q4,
    AQ4M,
    AQ4,
    BQ4M,
    BQ4,
    CQ4M,
    CQ4,
    DQ4M,
    DQ4,
    denter
 FROM RYDA.MONTHSORG
/


-- End of DDL script for HALFHOUREVID

-- Start of DDL script for MONTH_FOR_TERM
-- Generated 4-окт-05  5:54:08 pm
-- from oe-RYDA:4

-- View MONTH_FOR_TERM

CREATE OR REPLACE VIEW month_for_term (
   date_time,
   p1name,
   p2name,
   mid,
   er,
   q1,
   ed,
   q3,
   q2,
   q4,
   erm,
   q1m,
   edm,
   q3m,
   q2m,
   q4m,
   aer,
   aq1,
   aed,
   aq3,
   aq2,
   aq4,
   aerm,
   aq1m,
   aedm,
   aq3m,
   aq2m,
   aq4m,
   ber,
   bq1,
   bed,
   bq3,
   bq2,
   bq4,
   berm,
   bq1m,
   bedm,
   bq3m,
   bq2m,
   bq4m,
   cer,
   cq1,
   ced,
   cq3,
   cq2,
   cq4,
   cerm,
   cq1m,
   cedm,
   cq3m,
   cq2m,
   cq4m,
   der,
   dq1,
   ded,
   dq3,
   dq2,
   dq4,
   derm,
   dq1m,
   dedm,
   dq3m,
   dq2m,
   dq4m,
   kc,
   er_mtrsn,
   denter )
AS
select
      b.date_time
  		,
      p1.Name p1Name, p2.Name p2Name, b.mid
      ,
      b.er, b.q1, b.ed, b.q3, b.q2, b.q4, b.erm, b.q1m, b.edm, b.q3m, b.q2m, b.q4m
      ,
      b.aer, b.aq1, b.aed, b.aq3, b.aq2, b.aq4, b.aerm, b.aq1m, b.aedm, b.aq3m, b.aq2m, b.aq4m
      ,
      b.ber, b.bq1, b.bed, b.bq3, b.bq2, b.bq4, b.berm, b.bq1m, b.bedm, b.bq3m, b.bq2m, b.bq4m
      ,
      b.cer, b.cq1, b.ced, b.cq3, b.cq2, b.cq4, b.cerm, b.cq1m, b.cedm, b.cq3m, b.cq2m, b.cq4m
      ,
      b.der, b.dq1, b.ded, b.dq3, b.dq2, b.dq4, b.derm, b.dq1m, b.dedm, b.dq3m, b.dq2m, b.dq4m
      ,
      f.kc, b.er_mtrsn, b.denter
      from
        monthsevid b, points p1, points p2, feeders f
      where
      f.mid=p2.mid(+) and p2.parent=p1.mid(+) and f.mid=b.mid
/

-- End of DDL script for MONTH_FOR_TERM
alter table PROFILE add
(
    DENTER     DATE                   default sysdate not null
)
/


comment on column PROFILE.DENTER is 'Дата ввода'
/



-- Start of DDL script for PROFILEEVID
-- Generated 4-окт-05  6:02:24 pm
-- from oe-RYDA:4

-- View PROFILEEVID

CREATE OR REPLACE VIEW profileevid (
   mid,
   date_time,
   er,
   q1,
   ed,
   q3,
   q2,
   q4,
   freq,
   cosf,
   volt,
   currento,
   volt2,
   volt3,
   curr2,
   curr3,
   erm,
   q1m,
   edm,
   q3m,
   q2m,
   q4m,
   denter )
AS
SELECT
    MID,
    DATE_TIME,
    ER,
    Q1,
    ED,
    Q3,
    Q2,
    Q4,
    FREQ,
    COSF,
    VOLT,
    CURRENTO,
    VOLT2,
    VOLT3,
    CURR2,
    CURR3,
    ERM,
    Q1M,
    EDM,
    Q3M,
    Q2M,
    Q4M,
    denter
 FROM RYDA.PROFILE
/

-- End of DDL script for PROFILEEVID


-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     06.10.2005  16:49
-- ============================================================
create unique index METERSHIST_IDX1 on METERSHISTORY (DEND asc, MID asc, ENTYPE asc)
/


-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     19.10.2005  09:50
-- ============================================================

-- ============================================================
--   Table: PROFILE
-- ============================================================
alter table PROFILE add
(
    NSOURCE    NUMBER                 default 10 not null
)
/

comment on column PROFILE.NSOURCE is 'Код источника'
/

alter table PROFILE drop constraint PROFILE_PK
/

alter table PROFILE
    add constraint PROFILE_PK primary key (MID, DATE_TIME, NSOURCE)
/

CREATE OR REPLACE VIEW profileevid (
   mid,
   date_time,
   er,
   q1,
   ed,
   q3,
   q2,
   q4,
   freq,
   cosf,
   volt,
   currento,
   volt2,
   volt3,
   curr2,
   curr3,
   erm,
   q1m,
   edm,
   q3m,
   q2m,
   q4m,
   denter,
   nsource )
AS
SELECT
    MID,
    DATE_TIME,
    ER,
    Q1,
    ED,
    Q3,
    Q2,
    Q4,
    FREQ,
    COSF,
    VOLT,
    CURRENTO,
    VOLT2,
    VOLT3,
    CURR2,
    CURR3,
    ERM,
    Q1M,
    EDM,
    Q3M,
    Q2M,
    Q4M,
    denter,
    nsource
 FROM RYDA.PROFILE
/

declare
begin
for lc in
(select 'ALTER PACKAGE '||OBJECT_NAME||' COMPILE PACKAGE' c from user_objects where OBJECT_TYPE = 'PACKAGE'AND STATUS = 'INVALID'
union all select 'ALTER VIEW '||OBJECT_NAME||' COMPILE' c from user_objects where OBJECT_TYPE = 'VIEW'AND STATUS = 'INVALID'
union all select 'ALTER PROCEDURE '||OBJECT_NAME||' COMPILE' c from user_objects where OBJECT_TYPE = 'PROCEDURE'AND STATUS = 'INVALID'
union all select 'ALTER FUNCTION ' ||OBJECT_NAME||' COMPILE' c from user_objects where OBJECT_TYPE = 'FUNCTION' AND STATUS = 'INVALID'
union all select 'ALTER PACKAGE '||OBJECT_NAME||' COMPILE BODY' c from user_objects where OBJECT_TYPE = 'PACKAGE BODY' AND STATUS = 'INVALID'
union all select 'ALTER TRIGGER ' ||OBJECT_NAME||' COMPILE' c from user_objects where OBJECT_TYPE = 'TRIGGER' AND STATUS = 'INVALID') loop
begin
execute immediate lc.c;
exception
 when others then null;
end;
end loop;
end;

/


-------------22/10/2005
insert into role_task
select ROLE_ID,83,1 from roles where ROLE_ID not in (select ROLE_ID from role_task where TASK_ID=83)
/

commit
/

-------------28/10/2005
INSERT INTO deportprocedures
(NPROCEDURE,VNAME,VPROCEDURE,NPERIOD,NTYPE,VMEMO)
VALUES
(34,'Макет (ЦЭС)','ryda.Reports1_pg.m1010ces_p',2,0,'')
/

update makets set nprocedure=34 where NPROCEDURE=33 and exists (select * from parameter where NPID=12 and VVALUE='12')
/

delete from deportprocedures where NPROCEDURE=33 and exists (select * from parameter where NPID=12 and VVALUE='12')
/

INSERT INTO deportprocedures
(NPROCEDURE,VNAME,VPROCEDURE,NPERIOD,NTYPE,VMEMO)
select 33,'Макет 1010 с показаниями','ryda.reports1_pg.m1010met_p',2,0,'' from dual where not exists (select * from deportprocedures where NPROCEDURE=33)
/

update deportprocedures set VNAME='Макет 1010 с показаниями',VPROCEDURE='ryda.reports1_pg.m1010met_p' where NPROCEDURE=33
/

update makets set VPARAM='1' where NPROCEDURE in (1,33,34)
/

INSERT INTO deportprocedures
(NPROCEDURE,VNAME,VPROCEDURE,NPERIOD,NTYPE,VMEMO)
VALUES
(35,'Копирование данных с основных и дублирующих счетчиков',
'ryda.calcdublicate_pg.copy_points_data_backgr_p',2,1,
'Копирование данных с основных и дублирующих счетчиков')
/

commit
/

drop table rep_classic
/

CREATE GLOBAL TEMPORARY TABLE rep_classic
    (gid                            NUMBER,
    objtype                        NUMBER,
    nlevel                         NUMBER,
    name                           VARCHAR2(300),
    zone                           VARCHAR2(10),
    etype                          VARCHAR2(10),
    mtype                          VARCHAR2(20),
    mtrsn                          VARCHAR2(20),
    edate                          DATE,
    em                             VARCHAR2(20),
    sdate                          DATE,
    sm                             VARCHAR2(20),
    dif                            NUMBER,
    kc                             NUMBER,
    cons                           NUMBER,
    waste                          NUMBER,
    nall                           NUMBER,
    norder                         NUMBER)
ON COMMIT PRESERVE ROWS
/

COMMENT ON COLUMN rep_classic.cons IS 'расход'
/
COMMENT ON COLUMN rep_classic.dif IS 'разность показаний'
/
COMMENT ON COLUMN rep_classic.edate IS 'Дата конечных показаний'
/
COMMENT ON COLUMN rep_classic.em IS 'конечные показания'
/
COMMENT ON COLUMN rep_classic.zone IS 'тип зоны'
/
COMMENT ON COLUMN rep_classic.etype IS 'тип измерения'
/
COMMENT ON COLUMN rep_classic.gid IS 'ИД группы'
/
COMMENT ON COLUMN rep_classic.kc IS 'коэффициент'
/
COMMENT ON COLUMN rep_classic.mtrsn IS 'номер счетчика'
/
COMMENT ON COLUMN rep_classic.mtype IS 'тип счетчика'
/
COMMENT ON COLUMN rep_classic.nall IS 'расход +  потери'
/
COMMENT ON COLUMN rep_classic.name IS 'название присоед.'
/
COMMENT ON COLUMN rep_classic.nlevel IS 'уровень в дереве'
/
COMMENT ON COLUMN rep_classic.norder IS 'сортировка'
/
COMMENT ON COLUMN rep_classic.objtype IS 'признак группы 0 - группа 1-точка'
/
COMMENT ON COLUMN rep_classic.sdate IS 'Дата начальных показаний'
/
COMMENT ON COLUMN rep_classic.sm IS 'начальные показания'
/
COMMENT ON COLUMN rep_classic.waste IS 'протери'
/

--------------------------------- 04/11/2005
insert into deportprocedures (nprocedure, vname, vprocedure, nperiod, ntype, vmemo)
values (36, 'Пересоздание макетов','ryda.background01_pg.recreatemakets', 0, 1, 'Процедура повторно создает макеты после поступления данных')
/
commit
/

alter table DEPORTFILES add
(
    DENTER        DATE                   default sysdate not null
)
/

comment on column DEPORTFILES.DENTER is 'Дата создания или изменения'
/


---------------------------------- 24/11/2005
INSERT INTO protocols
(PROTOCOL_ID,NAME)
VALUES
(52,'УППД')
/
INSERT INTO protocols
(PROTOCOL_ID,NAME)
VALUES
(53,'Элвин - ARC')
/
INSERT INTO protocols
(PROTOCOL_ID,NAME)
VALUES
(54,'Metcom - ZxB')
/
commit
/


-------------15/12/2005
declare
l NUMBER;
begin
select nvl(max(decode(vvalue,'11',5,0)),0) into l from parameter where NPID=12;
insert into parameter (NPID,VVALUE,VDESCRIPTION) values(27,l,'Коэффициент сглаживания интервала синхронизации пакетов');
commit;
end;
/


-- Start of DDL script for HALFHOUR
-- Generated 15-дек-05  4:35:32 pm
-- from oe-RYDA:12

-- View HALFHOUR

CREATE OR REPLACE VIEW halfhour_l (
   mid,
   date_time,
   er,
   q1,
   ed,
   q3,
   q2,
   q4,
   erm,
   q1m,
   edm,
   q3m,
   q2m,
   q4m,
   status,
   nkc,
   nsource,
   er_mtrsn,
   nswitch,
   denter )
AS
SELECT
    MID,
    DATE_TIME,
    ER,
    Q1,
    ED,
    Q3,
    Q2,
    Q4,
    ERM,
    Q1M,
    EDM,
    Q3M,
    Q2M,
    Q4M,
    STATUS,
    NKC,
    NSOURCE,
    ER_MTRSN,
    NSWITCH,
    DENTER
 FROM RYDA.HALFHOUROLD WHERE NEXCEPTCALC IS NULL and nsource>0
/

COMMENT ON TABLE halfhour_l IS 'График нагрузки с потерями'
/

-- End of DDL script for HALFHOUR

-- Start of DDL script for BILL
-- Generated 15-дек-05  4:35:41 pm
-- from oe-RYDA:12

-- View BILL

CREATE OR REPLACE VIEW bill_l (
   mid,
   date_time,
   valid,
   source,
   remark,
   er_mtrsn,
   er_kc,
   erm,
   er,
   aerm,
   aer,
   berm,
   ber,
   cerm,
   cer,
   derm,
   der,
   q1_mtrsn,
   q1_kc,
   q1m,
   q1,
   aq1m,
   aq1,
   bq1m,
   bq1,
   cq1m,
   cq1,
   dq1m,
   dq1,
   ed_mtrsn,
   ed_kc,
   edm,
   ed,
   aedm,
   aed,
   bedm,
   bed,
   cedm,
   ced,
   dedm,
   ded,
   q3_mtrsn,
   q3_kc,
   q3m,
   q3,
   aq3m,
   aq3,
   bq3m,
   bq3,
   cq3m,
   cq3,
   dq3m,
   dq3,
   q2_mtrsn,
   q2_kc,
   q2m,
   q2,
   aq2m,
   aq2,
   bq2m,
   bq2,
   cq2m,
   cq2,
   dq2m,
   dq2,
   q4_mtrsn,
   q4_kc,
   q4m,
   q4,
   aq4m,
   aq4,
   bq4m,
   bq4,
   cq4m,
   cq4,
   dq4m,
   dq4,
   nwasteabs,
   nsource,
   qm )
AS
SELECT
    MID,
    DATE_TIME,
    VALID,
    SOURCE,
    REMARK,
    ER_MTRSN,
    ER_KC,
    ERM,
    ER,
    AERM,
    AER,
    BERM,
    BER,
    CERM,
    CER,
    DERM,
    DER,
    Q1_MTRSN,
    Q1_KC,
    Q1M,
    Q1,
    AQ1M,
    AQ1,
    BQ1M,
    BQ1,
    CQ1M,
    CQ1,
    DQ1M,
    DQ1,
    ED_MTRSN,
    ED_KC,
    EDM,
    ED,
    AEDM,
    AED,
    BEDM,
    BED,
    CEDM,
    CED,
    DEDM,
    DED,
    Q3_MTRSN,
    Q3_KC,
    Q3M,
    Q3,
    AQ3M,
    AQ3,
    BQ3M,
    BQ3,
    CQ3M,
    CQ3,
    DQ3M,
    DQ3,
    Q2_MTRSN,
    Q2_KC,
    Q2M,
    Q2,
    AQ2M,
    AQ2,
    BQ2M,
    BQ2,
    CQ2M,
    CQ2,
    DQ2M,
    DQ2,
    Q4_MTRSN,
    Q4_KC,
    Q4M,
    Q4,
    AQ4M,
    AQ4,
    BQ4M,
    BQ4,
    CQ4M,
    CQ4,
    DQ4M,
    DQ4,
    NWASTEABS,
    NSOURCE,
    QM
 FROM RYDA.BILLOLD WHERE NEXCEPTCALC IS NULL and nsource>0
/

COMMENT ON TABLE bill_l IS 'Реальные суточные измерения с потерями'
/

-- End of DDL script for BILL

-- Start of DDL script for HALFHOUR
-- Generated 15-дек-05  4:35:32 pm
-- from oe-RYDA:12

-- View HALFHOUR

CREATE OR REPLACE VIEW halfhour_ol (
   mid,
   date_time,
   er,
   q1,
   ed,
   q3,
   q2,
   q4,
   erm,
   q1m,
   edm,
   q3m,
   q2m,
   q4m,
   status,
   nkc,
   nsource,
   er_mtrsn,
   nswitch,
   denter )
AS
SELECT
    MID,
    DATE_TIME,
    ER,
    Q1,
    ED,
    Q3,
    Q2,
    Q4,
    ERM,
    Q1M,
    EDM,
    Q3M,
    Q2M,
    Q4M,
    STATUS,
    NKC,
    NSOURCE,
    ER_MTRSN,
    NSWITCH,
    DENTER
 FROM RYDA.HALFHOUROLD WHERE NEXCEPTCALC IS NULL and nsource>0
/

COMMENT ON TABLE halfhour_ol IS 'График нагрузки только потери'
/

-- End of DDL script for HALFHOUR

-- Start of DDL script for BILL
-- Generated 15-дек-05  4:35:41 pm
-- from oe-RYDA:12

-- View BILL

CREATE OR REPLACE VIEW bill_ol (
   mid,
   date_time,
   valid,
   source,
   remark,
   er_mtrsn,
   er_kc,
   erm,
   er,
   aerm,
   aer,
   berm,
   ber,
   cerm,
   cer,
   derm,
   der,
   q1_mtrsn,
   q1_kc,
   q1m,
   q1,
   aq1m,
   aq1,
   bq1m,
   bq1,
   cq1m,
   cq1,
   dq1m,
   dq1,
   ed_mtrsn,
   ed_kc,
   edm,
   ed,
   aedm,
   aed,
   bedm,
   bed,
   cedm,
   ced,
   dedm,
   ded,
   q3_mtrsn,
   q3_kc,
   q3m,
   q3,
   aq3m,
   aq3,
   bq3m,
   bq3,
   cq3m,
   cq3,
   dq3m,
   dq3,
   q2_mtrsn,
   q2_kc,
   q2m,
   q2,
   aq2m,
   aq2,
   bq2m,
   bq2,
   cq2m,
   cq2,
   dq2m,
   dq2,
   q4_mtrsn,
   q4_kc,
   q4m,
   q4,
   aq4m,
   aq4,
   bq4m,
   bq4,
   cq4m,
   cq4,
   dq4m,
   dq4,
   nwasteabs,
   nsource,
   qm )
AS
SELECT
    MID,
    DATE_TIME,
    VALID,
    SOURCE,
    REMARK,
    ER_MTRSN,
    ER_KC,
    ERM,
    ER,
    AERM,
    AER,
    BERM,
    BER,
    CERM,
    CER,
    DERM,
    DER,
    Q1_MTRSN,
    Q1_KC,
    Q1M,
    Q1,
    AQ1M,
    AQ1,
    BQ1M,
    BQ1,
    CQ1M,
    CQ1,
    DQ1M,
    DQ1,
    ED_MTRSN,
    ED_KC,
    EDM,
    ED,
    AEDM,
    AED,
    BEDM,
    BED,
    CEDM,
    CED,
    DEDM,
    DED,
    Q3_MTRSN,
    Q3_KC,
    Q3M,
    Q3,
    AQ3M,
    AQ3,
    BQ3M,
    BQ3,
    CQ3M,
    CQ3,
    DQ3M,
    DQ3,
    Q2_MTRSN,
    Q2_KC,
    Q2M,
    Q2,
    AQ2M,
    AQ2,
    BQ2M,
    BQ2,
    CQ2M,
    CQ2,
    DQ2M,
    DQ2,
    Q4_MTRSN,
    Q4_KC,
    Q4M,
    Q4,
    AQ4M,
    AQ4,
    BQ4M,
    BQ4,
    CQ4M,
    CQ4,
    DQ4M,
    DQ4,
    NWASTEABS,
    NSOURCE,
    QM
 FROM RYDA.BILLOLD WHERE NEXCEPTCALC IS NULL and nsource>0
/

COMMENT ON TABLE bill_ol IS 'Реальные суточные измерения только потери'
/



-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     23.12.2005  15:20
-- ============================================================
comment on column MAKETS.DOLDCREATED is 'Дата предыдущего системного формирования'
/

alter table MAKETS add
(
    DLASTCREATED  DATE                   null
)
/

comment on column MAKETS.DLASTCREATED is 'Дата последнего формирования'
/

begin
update makets set DLASTCREATED=doldcreated+1+nshift/1440;
commit;
end;
/


--------------------26/12/2006
INSERT INTO protocols
(PROTOCOL_ID,NAME)
VALUES
(55,'Энергия_9-2005')
/
INSERT INTO protocols
(PROTOCOL_ID,NAME)
VALUES
(56,'KM --> Энергия_9-2005')
/
commit
/

--------------19/01/2006
declare
ln_customer_id NUMBER;
begin
SELECT NVL(SUM(DECODE(vvalue, '', 0, vvalue)), 0)   INTO ln_customer_id   FROM parameter  WHERE npid = 12;
if ln_customer_id in (17,26) then
 update feeders set Q1234='*';
else
 update feeders set Q1234=NULL;
end if;
commit;
end;
/
---------------20/01/2006
ALTER TABLE DEPORTPROCEDURES drop CONSTRAINT CKC_NPERIOD_DEPORTPR
/

ALTER TABLE RYDA.DEPORTPROCEDURES
 ADD CONSTRAINT CKC_NPERIOD_DEPORTPR
 CHECK (
NPERIOD in (0,1,2,3,4,5,6)
 )
/
declare
ln_customer_id NUMBER;
begin
SELECT NVL(SUM(DECODE(vvalue, '', 0, vvalue)), 0)   INTO ln_customer_id   FROM parameter  WHERE npid = 12;
if ln_customer_id in (0,26) then
 insert into deportprocedures (nprocedure, vname, vprocedure, nperiod, ntype, vmemo)
 values (37, 'Коммерческие данные КГОК','reports1_pg.mkazah_p', 6, 0, 'Макет передачи 15 минутных данных КГОК');
 insert into deportprocedures (nprocedure, vname, vprocedure, nperiod, ntype, vmemo)
 values (38, 'Журнал событий счетчиков','reports1_pg.jourkazah_p', 0, 0, 'Макет передачи Журнала событий счетчиков');
 end if;
commit;
end;
/
------------------25/01/2006
INSERT INTO points
(MID,PARENT,COD,IND,NAME,SHORT_NAME,PTYPE,IMPLEMENT_DATE,TAG,NPOINT)
VALUES
(3,NULL,NULL,1,'Каналы рассылки','',NULL,'',NULL,NULL)
/
INSERT INTO points(mid, parent, cod, ind, name, short_name, ptype, implement_date)
select ndeportation, 3, 0, 2, vname, '', 1, SYSDATE from deportation
/
commit
/
alter table DEPORTATION
    add constraint DEPORTATION_F3 foreign key  (NDEPORTATION)
       references POINTS (MID) on delete cascade
/

INSERT INTO parameter
(NPID,VVALUE,VDESCRIPTION)
VALUES
(28,'30','Интервал интеграции ГН (мин)')
/
INSERT INTO parameter
(NPID,VVALUE,VDESCRIPTION)
VALUES
(29,'0','Блокировка перехода на летнее время (Для стран, где перевода нет)')
/
commit
/



-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     30.01.2006  18:54
-- ============================================================

alter table EA_EVENTS add
(
    DENTER  DATE                   default sysdate not null
)
/

comment on column EA_EVENTS.DENTER is 'Дата попадания'
/

-- ============================================================
--   Index: EA_EVENTS_IDX1
-- ============================================================
create index EA_EVENTS_IDX1 on EA_EVENTS (mid asc, DENTER asc)
/


---------------------02/02/2006
INSERT INTO form_templates
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(85,1,203,'1.15. Баланс Активной энергии','Баланс Активной энергии [тыс.кВтч]',
'11110111',2,'')
/
INSERT INTO form_templates
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(87,1,204,'1.15.1. Баланс Активной энергии (ГН, Тех.проф. - мощность)',
'Баланс Активной энергии [тыс.кВтч]','11110111',2,'')
/
INSERT INTO form_templates
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(89,1,205,'1.15.2. Баланс Активной энергии (Суммируется по наростающей)',
'Баланс Активной энергии [тыс.кВтч]','11110111',2,'')
/
INSERT INTO form_templates
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(86,1,303,'1.16. Баланс Реактивной энергии','Баланс Реактивной энергии [тыс.кВАрч]',
'11110111',2,'')
/
INSERT INTO form_templates
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(88,1,304,'1.16.1. Баланс Реактивной энергии (ГН, Тех.проф. - мощность)',
'Баланс Реактивной энергии [тыс.кВАрч]','11110111',2,'')
/
INSERT INTO form_templates
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(90,1,305,'1.16.2. Баланс Реактивной энергии (Суммируется по наростающей)',
'Баланс Реактивной энергии [тыс.кВАрч]','11110111',2,'')
/
commit
/

-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     16.02.2006  15:58
-- ============================================================

alter table GROUPLIMIT add
(
    MORNING_START  DATE                   null    ,
    MORNING_END    DATE                   null    ,
    EVENING_START  DATE                   null    ,
    EVENING_END    DATE                   null
)
/

comment on column GROUPLIMIT.MORNING_START is 'Утро нач'
/

comment on column GROUPLIMIT.MORNING_END is 'Утро кон'
/

comment on column GROUPLIMIT.EVENING_START is 'Вечер нач'
/

comment on column GROUPLIMIT.EVENING_END is 'Вечер кон'
/



----------------------------------------------------------------------------------------------
--         VER 2.18  (Для обновления версии 2.18 до текущей скрипт запускать отсюда)        --
----------------------------------------------------------------------------------------------


--------------------------06/03/2006
declare
ln_psex NUMBER;
ln_msex NUMBER;
lv_1 VARCHAR2(1024);
ln_maket NUMBER;
begin
for i in 1..2000 loop
 select points_seq.nextval into ln_psex from dual;
end loop;
select points_seq.nextval into ln_psex from dual;
select makets_seq.nextval into ln_msex from dual;
while ln_psex<=ln_msex loop
select points_seq.nextval into ln_psex from dual;
end loop;
execute immediate 'alter table DEPORTATION disable constraint DEPORTATION_F2';
execute immediate 'alter table MAKETGROUPS disable constraint MAKETGROUPS_F1';
for lc in (select points_seq.nextval seq,m.nmaket from makets m) loop
 --Меняем сылки на макеты для фоновых процессов которые контролируют другие макеты
 for lc1 in (select * from makets where NPROCEDURE=36) loop
  if trim(lc1.VPARAM) is not null then
   lv_1:=util_pg.allnumber_f(util_pg.get_param(lc1.VPARAM, 1));
   FOR i IN 2 .. LENGTH(lc1.VPARAM) LOOP
    ln_maket := util_pg.allnumber_f(util_pg.get_param(lc1.VPARAM, i));
    if ln_maket=lc.nmaket then
     lv_1:=lv_1||';'||lc.seq;
    elsif ln_maket>0 then
     lv_1:=lv_1||';'||ln_maket;
    end if;
   end loop;
   update makets set VPARAM=lv_1 where nmaket=lc1.nmaket;
  end if;
 end loop;
 --Меняем сылки на макеты для каналов опроса УППД
 for lc1 in (select * from channels where protocol_id=52 and trim(util_pg.get_param(INIT_STR,5))=to_char(lc.nmaket)) loop
  update channels set INIT_STR=substr(INIT_STR,1,instr(INIT_STR,';',1,4))||lc.seq where cid=lc1.cid;
 end loop;
  update makets set nmaket=lc.seq where nmaket=lc.nmaket;
 update DEPORTATION set nmaket=lc.seq where nmaket=lc.nmaket;
 update MAKETGROUPS set nmaket=lc.seq where nmaket=lc.nmaket;
end loop;
execute immediate 'alter table DEPORTATION enable constraint DEPORTATION_F2';
execute immediate 'alter table MAKETGROUPS enable constraint MAKETGROUPS_F1';
commit;
end;
/

INSERT INTO points
(MID,PARENT,COD,IND,NAME,SHORT_NAME,PTYPE,IMPLEMENT_DATE,TAG,NPOINT)
VALUES
(4,NULL,NULL,1,'Макеты','',NULL,'',NULL,NULL)
/
INSERT INTO points(mid, parent, cod, ind, name, short_name, ptype, implement_date)
select nmaket, 4, 0, 2, vname, '', 1, SYSDATE from makets
/
commit
/

alter table MAKETS
    add constraint MAKETS_F2 foreign key  (NMAKET)
       references POINTS (MID) on delete cascade
/

drop sequence makets_seq
/

-------------------09/03/2006
INSERT INTO tasks
(TASK_ID,PARENT,TASK_COD,NAME,REMARK,nshow)
VALUES
(85,77,632,'6.03 Монитор полноты и своевременности поступления данных','Монитор полноты и своевременности поступления данных',0)
/
commit
/

-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     15.03.2006  11:37
-- ============================================================
alter table FORMS add
(
    MID             NUMBER                 null
)
/

comment on column FORMS.MID is 'Ид точки'
/

alter table FORMS
    add constraint FORMS_F2 foreign key  (MID)
       references POINTS (MID)
/


-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     21.03.2006  15:34
-- ============================================================
alter table DEPORTFILES add
(
    DSEND         DATE                   null
)
/

comment on column DEPORTFILES.DSEND is 'Дата отсылки'
/

----------------------------------------------------------------------------------------------
--         VER 2.19  (Для обновления версии 2.19 до текущей скрипт запускать отсюда)        --
----------------------------------------------------------------------------------------------
INSERT INTO parameter
(NPID,VVALUE,VDESCRIPTION)
VALUES
(30,'1','Ежесуточный расчет потерь')
/
commit
/

--------------04.04.2006
/*
INSERT INTO tasks
(TASK_ID,PARENT,TASK_COD,NAME,REMARK,NSHOW)
VALUES
(22,16,49,'2.8 Редактирование трансформаторов','',1)
/
commit
/
*/
------------10/04/2006
INSERT INTO tasks
(TASK_ID,PARENT,TASK_COD,NAME,REMARK,NSHOW)
VALUES
(92,NULL,0,'6. Потери','',1)
/
INSERT INTO tasks
(TASK_ID,PARENT,TASK_COD,NAME,REMARK,NSHOW)
VALUES
(93,92,652,'6.1 Ведение коммутации','',1)
/
INSERT INTO tasks
(TASK_ID,PARENT,TASK_COD,NAME,REMARK,NSHOW)
VALUES
(94,92,653,'6.2 Просмотр начислений и разноски потерь','',1)
/
INSERT INTO tasks
(TASK_ID,PARENT,TASK_COD,NAME,REMARK,NSHOW)
VALUES
(95,27,654,'4.4 Просмотр сформированных макетов','',1)
/
insert into role_task
select distinct ROLE_ID,95,1 from users where ADMIN='*'
/
commit
/
----------------------------19/04/2006
INSERT INTO protocols
(PROTOCOL_ID,NAME)
VALUES
(57,'УСПД КМ-64_v2')
/
INSERT INTO protocols
(PROTOCOL_ID,NAME)
VALUES
(58,'KM->УСПД КМ-64_v2')
/
INSERT INTO protocols
(PROTOCOL_ID,NAME)
VALUES
(59,'УСПД КМ-64(эхо)_v2')
/
INSERT INTO protocols
(PROTOCOL_ID,NAME)
VALUES
(60,'KM->УСПД КМ-64(эхо)_v2')
/
update protocols set NAME=replace(NAME,' --> ','->')
/
update protocols set NAME='УСПД КМ-64_v1' where PROTOCOL_ID=14
/
update protocols set NAME='KM->УСПД КМ-64_v1' where PROTOCOL_ID=15
/
update protocols set NAME='УСПД КМ-64(эхо)_v1' where PROTOCOL_ID=39
/
update protocols set NAME='KM->УСПД КМ-64(эхо)_v1' where PROTOCOL_ID=40
/
commit
/


-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     21.04.2006  12:40
-- ============================================================
alter table DEPORTFILES add
(
    USER_ID       NUMBER                 null
)
/
comment on column DEPORTFILES.USER_ID is 'Ид пользователя'
/
create index DEPORTATIONFILES_IDX3 on DEPORTFILES (USER_ID asc)
/
alter table DEPORTFILES
    add constraint DEPORTATIONFILES_F2 foreign key  (USER_ID)
       references USERS (USER_ID)
/

-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     25.04.2006  09:42
-- ============================================================
alter table FEEDERS add
(
    NLOCKCORRECTTIME   NUMBER(1)              default 0 not null
        constraint CKC_NLOCKCORRECTTIME_FEEDERS check (NLOCKCORRECTTIME in (0,1))
)
/

comment on column FEEDERS.NLOCKCORRECTTIME is 'Блокировка коррекции времени'
/

alter table CHANNELS add
(
    NLOCKCORRECTTIME   NUMBER(1)              default 0 not null
        constraint CKC_NLOCKCORRECTTIME_CHANNELS check (NLOCKCORRECTTIME in (0,1))
)
/

comment on column CHANNELS.NLOCKCORRECTTIME is 'Блокировка коррекции времени'
/

----15/05/2006 (Потери)
---- **********************************************************************
----
alter table POINTS disable constraint POINTS_F1
/

delete from DICT_OBJ_TYPES
/

alter table DICT_OBJ_TYPES add
(
    RT_TYPE  NUMBER                 not null
)
/

comment on column DICT_OBJ_TYPES.RT_TYPE is 'Код типа для Редактора схем'
/

create unique index VNAME_IDX1 on DICT_OBJ_TYPES (VNAME asc)
/

INSERT INTO dict_obj_types
VALUES
(4,'Расчетная точка (для копирования данных с основного или дублирующего счетчиков)',4)
/
INSERT INTO dict_obj_types
VALUES
(1,'Обобщенный объект 1-го уровня',1)
/
INSERT INTO dict_obj_types
VALUES
(2,'Обобщенный объект 2-го уровня',2)
/
INSERT INTO dict_obj_types
VALUES
(3,'Точка учета',3)
/
INSERT INTO dict_obj_types
VALUES
(600,'Силовой трансформатор (двухобмлточный)',600)
/
INSERT INTO dict_obj_types
VALUES
(610,'Силовой трансформатор (трехобмлточный)',610)
/
INSERT INTO dict_obj_types
VALUES
(500,'Линия',500)
/
INSERT INTO dict_obj_types
VALUES
(800,'Счетчики',800)
/
INSERT INTO dict_obj_types
VALUES
(200,'Разъединители',200)
/
INSERT INTO dict_obj_types
VALUES
(100,'Заземляющие ножи',100)
/
INSERT INTO dict_obj_types
VALUES
(-1,'Фиктивное присоединение',-1)
/
INSERT INTO dict_obj_types
VALUES
(0,'Секции шин',0)
/
INSERT INTO dict_obj_types
VALUES
(300,'Выключатели',300)
/
INSERT INTO dict_obj_types
VALUES
(400,'Отпайки',400)
/
INSERT INTO dict_obj_types
VALUES
(900,'Присоединение',900)
/
INSERT INTO dict_obj_types
VALUES
(950,'Класс напряжения',950)
/
INSERT INTO dict_obj_types
VALUES
(1000,'Подстанция',1000)
/
commit
/
alter table POINTS enable constraint POINTS_F1
/
CREATE SEQUENCE calc_seq
  INCREMENT BY 1
  START WITH 1
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  NOCYCLE
  NOORDER
  CACHE 20
/


-------------------Сюда
CREATE GLOBAL TEMPORARY TABLE calc_tmp
    (dt                             DATE)
ON COMMIT DELETE ROWS
/
COMMENT ON TABLE calc_tmp IS 'Сугубо вспомогательная таблица для облегчения группировки подпериодов изменения направления тока'
/
COMMENT ON COLUMN calc_tmp.dt IS 'Дата изменения направления перетока'
/
CREATE TABLE calc_hours
    (oid                            NUMBER,
    cpid                           NUMBER,
    common                         NUMBER,
    work                           NUMBER,
    rt_type                        NUMBER)
/
COMMENT ON TABLE calc_hours IS 'Результаты расчета часов работы трансформаторов и линий'
/
COMMENT ON COLUMN calc_hours.common IS 'Общие часы работы'
/
COMMENT ON COLUMN calc_hours.cpid IS 'Ссылка на подпериод'
/
COMMENT ON COLUMN calc_hours.oid IS 'Ссылка на тр-р, линию'
/
COMMENT ON COLUMN calc_hours.rt_type IS 'Тип объекта. Исп. как признак необсчитанной ветви'
/
COMMENT ON COLUMN calc_hours.work IS 'Рабочие часы'
/
CREATE TABLE calc_links
    (cpid                           NUMBER NOT NULL,
    outfit                         NUMBER NOT NULL,
    feeder                         NUMBER NOT NULL,
    switch                         NUMBER NOT NULL
  ,
  CONSTRAINT PK_CALC_LINKS
  PRIMARY KEY (cpid, outfit, feeder, switch))
/

-- Comments for CALC_LINKS

COMMENT ON TABLE calc_links IS 'Рабочая таблица связей для расчета потерь'
/
COMMENT ON COLUMN calc_links.cpid IS 'Ссылка на подпериод'
/
COMMENT ON COLUMN calc_links.feeder IS 'Ид присоединения'
/
COMMENT ON COLUMN calc_links.outfit IS 'Ид оборудования (Секция, транс., линия)'
/
COMMENT ON COLUMN calc_links.switch IS 'Ид выключателя'
/
CREATE TABLE calc_periods
    (cpid                           NUMBER NOT NULL,
    sdate                          DATE,
    edate                          DATE,
    period                         NUMBER
  ,
  CONSTRAINT PK_CALC_PERIODS
  PRIMARY KEY (cpid)
)
/

-- Comments for CALC_PERIODS

COMMENT ON TABLE calc_periods IS 'Расчетные периоды'
/
COMMENT ON COLUMN calc_periods.cpid IS 'Ид подпериода'
/
COMMENT ON COLUMN calc_periods.edate IS 'Дата окончания подпериода'
/
COMMENT ON COLUMN calc_periods.period IS 'Расчетный период'
/
COMMENT ON COLUMN calc_periods.sdate IS 'Дата начала подпериода'
/
CREATE GLOBAL TEMPORARY TABLE calc_protocol
    (sid                            NUMBER,
    period                         NUMBER,
    sdate			   DATE,
    ord                            NUMBER,
    lvl                            NUMBER,
    line                           VARCHAR2(2000))
ON COMMIT PRESERVE ROWS
/
-- Comments for CALC_PROTOCOL

COMMENT ON COLUMN calc_protocol.line IS 'Строка'
/
COMMENT ON COLUMN calc_protocol.lvl IS 'Отступ строки'
/
COMMENT ON COLUMN calc_protocol.ord IS 'Порядковый номер строки'
/
COMMENT ON COLUMN calc_protocol.period IS 'Расчетный период'
/
COMMENT ON COLUMN calc_protocol.sid IS 'Ссылка на схему'
/
CREATE TABLE calc_results
    (oid                            NUMBER NOT NULL,
    cpid                           NUMBER NOT NULL,
    src                            NUMBER NOT NULL,
    wh                             NUMBER(16,2),
    varh                           NUMBER(16,2),
    lossed_wh                      NUMBER(16,2),
    lossed_varh                    NUMBER(16,2),
    qm                             NUMBER
  ,
  CONSTRAINT PK_CALC_RESULTS
  PRIMARY KEY (oid, cpid))
/
-- Comments for CALC_RESULTS

COMMENT ON TABLE calc_results IS 'Результаты расчетов и разноски потерь'
/
COMMENT ON COLUMN calc_results.cpid IS 'Ссылка на подпериод'
/
COMMENT ON COLUMN calc_results.lossed_varh IS 'Потери реактивной э/э'
/
COMMENT ON COLUMN calc_results.lossed_wh IS 'Потери активной э/э'
/
COMMENT ON COLUMN calc_results.oid IS 'Ссылка на фидер'
/
COMMENT ON COLUMN calc_results.qm IS '0 - ОК, 1 - нет данных, -1 - фидер был выключен, -2 - свернут, -3 - навернут'
/
COMMENT ON COLUMN calc_results.src IS 'Код источника: 10 - измерения, 20 - нб узла, 30 - нб линии, 40 - нб тр'
/
COMMENT ON COLUMN calc_results.varh IS 'Переток реактивной э/э'
/
COMMENT ON COLUMN calc_results.wh IS 'Переток активной э/э'
/
CREATE TABLE osm_switchings
    (oid                            NUMBER NOT NULL,
    sdate                          DATE NOT NULL,
    ldate                          DATE,
    state                          NUMBER
  ,
  CONSTRAINT PK_OSM_SWITCHINGS
  PRIMARY KEY (oid, sdate))
/
COMMENT ON TABLE osm_switchings IS 'История переключений коммутационных аппаратов'
/
COMMENT ON COLUMN osm_switchings.ldate IS 'Дата по'
/
COMMENT ON COLUMN osm_switchings.oid IS 'Ид выключателя'
/
COMMENT ON COLUMN osm_switchings.sdate IS 'Дата с'
/
COMMENT ON COLUMN osm_switchings.state IS 'Состояние: 1 - Вкл, 0 - Выкл'
/
CREATE TABLE rt_feeders
    (oid                            NUMBER NOT NULL,
    owner                          NUMBER NOT NULL,
    linker                         NUMBER,
    cell_num                       VARCHAR2(50),
    ratio                          NUMBER DEFAULT 1,
    vt_s1                          NUMBER,
    vt_s2                          NUMBER,
    vt_a_rating                    NUMBER,
    ct_s1                          NUMBER,
    ct_s2                          NUMBER,
    ct_a_rating                    NUMBER,
    line_r                         NUMBER,
    line_x                         NUMBER,
    line_l                         NUMBER,
    line_loss_part                 NUMBER,
    groundn                        NUMBER(1,0),
    isov                           NUMBER(1,0),
    er_tcid                        NUMBER,
    ed_tcid                        NUMBER,
    distrib_lc                     NUMBER,
    commerce                       NUMBER(1,0),
    sdate                          DATE,
    active_data                    NUMBER(1,0)
  ,
  CONSTRAINT PK_RT_FEEDERS
  PRIMARY KEY (oid))
/
ALTER TABLE rt_feeders
ADD CONSTRAINT ckc_rtfeeders_commerce CHECK (COMMERCE is null or ( COMMERCE in (1) ))
/
ALTER TABLE rt_feeders
ADD CONSTRAINT ckc_rtfeeders_groundn CHECK (GROUNDN is null or ( GROUNDN in (1) ))
/
ALTER TABLE rt_feeders
ADD CONSTRAINT ckc_rtfeeders_isov CHECK (ISOV is null or ( ISOV in (1) ))
/
ALTER TABLE rt_feeders
ADD CONSTRAINT ckc_rtfeeder_activedata CHECK (ACTIVE_DATA is null or ( ACTIVE_DATA in (1) ))
/
COMMENT ON TABLE rt_feeders IS 'Параметры присоединений'
/
COMMENT ON COLUMN rt_feeders.active_data IS 'Последние параметры которые участвуют в расчетах (1-участвуют; NULL-история)'
/
COMMENT ON COLUMN rt_feeders.cell_num IS 'Номер ячейки'
/
COMMENT ON COLUMN rt_feeders.commerce IS 'Признак коммерческого присоединения - 1. (Учитывается при дорассчете)'
/
COMMENT ON COLUMN rt_feeders.ct_a_rating IS 'Класс точности трансформатора тока'
/
COMMENT ON COLUMN rt_feeders.ct_s1 IS 'Ток первичной обмотки трансформатора тока А'
/
COMMENT ON COLUMN rt_feeders.ct_s2 IS 'Ток вторичной обмотки трансформатора тока А'
/
COMMENT ON COLUMN rt_feeders.distrib_lc IS 'Методика разноски графика нагрузки по расходу за период'
/
COMMENT ON COLUMN rt_feeders.ed_tcid IS 'Ид тарифной категории для активной отданой эниргии'
/
COMMENT ON COLUMN rt_feeders.er_tcid IS 'Ид тарифной категории для активной принятой эниргии'
/
COMMENT ON COLUMN rt_feeders.groundn IS 'Признак заземненной нейтрали'
/
COMMENT ON COLUMN rt_feeders.isov IS 'Признак обводного выключателя'
/
COMMENT ON COLUMN rt_feeders.line_l IS 'Длина линни в км'
/
COMMENT ON COLUMN rt_feeders.line_loss_part IS 'Процент потерь в линии относящихся к данному фидеру %'
/
COMMENT ON COLUMN rt_feeders.line_r IS 'Активное сотротивление линии Ом*км'
/
COMMENT ON COLUMN rt_feeders.line_x IS 'Реактивное сотротивление линии Ом*км'
/
COMMENT ON COLUMN rt_feeders.linker IS 'Ид субабонента питающегося от данного фидера'
/
COMMENT ON COLUMN rt_feeders.oid IS 'Ид фидера'
/
COMMENT ON COLUMN rt_feeders.owner IS 'Ид владельца фидера'
/
COMMENT ON COLUMN rt_feeders.ratio IS 'Расчетный коэффициент'
/
COMMENT ON COLUMN rt_feeders.sdate IS 'Дата ввода строки (Используется для ведения истории изменения параметров)'
/
COMMENT ON COLUMN rt_feeders.vt_a_rating IS 'Класс точности трансформатора напряжения'
/
COMMENT ON COLUMN rt_feeders.vt_s1 IS 'Напряжение первичной обмотки трансформатора напряжения  В'
/
COMMENT ON COLUMN rt_feeders.vt_s2 IS 'Напряжение вторичной обмотки трансформатора напряжения  В'
/
CREATE TABLE rt_line
    (oid                            NUMBER NOT NULL,
    length                         NUMBER,
    ares                           NUMBER,
    rres                           NUMBER,
  CONSTRAINT PK_RT_LINE
  PRIMARY KEY (oid))
/


-- Comments for RT_LINE

COMMENT ON TABLE rt_line IS 'Параметры линий'
/
COMMENT ON COLUMN rt_line.ares IS 'Активное сопротивление линии на Ом на километр'
/
COMMENT ON COLUMN rt_line.length IS 'Длина линии в километрах'
/
COMMENT ON COLUMN rt_line.oid IS 'Ид объекта'
/
COMMENT ON COLUMN rt_line.rres IS 'Реактивное сопротивление линии на Ом на километр'
/
CREATE TABLE rt_links
    (outfit                         NUMBER NOT NULL,
    feeder                         NUMBER NOT NULL,
    switch                         NUMBER)
/
ALTER TABLE rt_links
ADD CONSTRAINT uk_rt_links UNIQUE (outfit, feeder, switch)
/

-- Comments for RT_LINKS

COMMENT ON TABLE rt_links IS 'Связи между обектами, используется для расчета потерь'
/
COMMENT ON COLUMN rt_links.feeder IS 'Ид присоединения'
/
COMMENT ON COLUMN rt_links.outfit IS 'Ид оборудования (Секция, транс., линия)'
/
COMMENT ON COLUMN rt_links.switch IS 'Ид выключателя'
/
CREATE TABLE rt_objects
    (oid                            NUMBER NOT NULL,
    parent                         NUMBER,
    rt_type                        NUMBER NOT NULL,
    name                           VARCHAR2(200),
    short_name                     VARCHAR2(150),
    code                           VARCHAR2(50),
    voltage                        NUMBER,
    mid                            NUMBER
  ,
  CONSTRAINT PK_RTOBJECTS
  PRIMARY KEY (oid)  )
/


-- Comments for RT_OBJECTS

COMMENT ON TABLE rt_objects IS 'Дерево обектов для расчета'
/
COMMENT ON COLUMN rt_objects.code IS 'Код объекта для диспетчеров'
/
COMMENT ON COLUMN rt_objects.name IS 'Наименование'
/
COMMENT ON COLUMN rt_objects.oid IS 'ID объекта'
/
COMMENT ON COLUMN rt_objects.parent IS 'ID родителя'
/
COMMENT ON COLUMN rt_objects.rt_type IS 'Тип объекта в дереве объектов'
/
COMMENT ON COLUMN rt_objects.short_name IS 'Краткое наименование'
/
COMMENT ON COLUMN rt_objects.voltage IS 'Уровень напряжения'
/
CREATE TABLE rt_seq
    (val                            NUMBER NOT NULL)
/
COMMENT ON TABLE rt_seq IS 'Имитатор последовательности для объектов АСКУЭ'
/
COMMENT ON COLUMN rt_seq.val IS 'Используется в rt_objects'
/
CREATE TABLE rt_transform2
    (oid                            NUMBER NOT NULL,
    sn                             NUMBER,
    dpxx                           NUMBER,
    dpkz                           NUMBER,
    ixx                            NUMBER,
    ukz                            NUMBER
  ,
  CONSTRAINT PK_RT_TRANSFORM2
  PRIMARY KEY (oid))
/


-- Comments for RT_TRANSFORM2

COMMENT ON TABLE rt_transform2 IS 'Параметры 2-х обмоточных трансформаторов'
/
COMMENT ON COLUMN rt_transform2.dpkz IS 'Потери короткого замыкания кВт'
/
COMMENT ON COLUMN rt_transform2.dpxx IS 'Потери холостого хода кВт'
/
COMMENT ON COLUMN rt_transform2.ixx IS 'Ток холостого хода %'
/
COMMENT ON COLUMN rt_transform2.oid IS 'Ид объекта'
/
COMMENT ON COLUMN rt_transform2.sn IS 'Номинальная мощность кВА'
/
COMMENT ON COLUMN rt_transform2.ukz IS 'Напряжение короткого замыкания %'
/
CREATE TABLE rt_transform3
    (oid                            NUMBER NOT NULL,
    sn                             NUMBER,
    su                             NUMBER,
    sm                             NUMBER,
    sd                             NUMBER,
    dpxx                           NUMBER,
    dpkzu                          NUMBER,
    dpkzm                          NUMBER,
    dpkzd                          NUMBER,
    ixx                            NUMBER,
    ukzu                           NUMBER,
    ukzm                           NUMBER,
    ukzd                           NUMBER
  ,
  CONSTRAINT PK_RT_TRANSFORM3
  PRIMARY KEY (oid))
/
COMMENT ON TABLE rt_transform3 IS 'Параметры 3-х обмоточных трансформаторов'
/
COMMENT ON COLUMN rt_transform3.dpkzd IS 'Потери короткого замыкания нижней обмотки кВт'
/
COMMENT ON COLUMN rt_transform3.dpkzm IS 'Потери короткого замыкания средней обмотки кВт'
/
COMMENT ON COLUMN rt_transform3.dpkzu IS 'Потери короткого замыкания верхней обмотки кВт'
/
COMMENT ON COLUMN rt_transform3.dpxx IS 'Потери холостого хода кВт'
/
COMMENT ON COLUMN rt_transform3.ixx IS 'Ток холостого хода %'
/
COMMENT ON COLUMN rt_transform3.oid IS 'Ид объекта'
/
COMMENT ON COLUMN rt_transform3.sd IS 'Номинальная мощность нижней обмотки кВА'
/
COMMENT ON COLUMN rt_transform3.sm IS 'Номинальная мощность средней обмотки кВА'
/
COMMENT ON COLUMN rt_transform3.sn IS 'Номинальная мощность кВА'
/
COMMENT ON COLUMN rt_transform3.su IS 'Номинальная мощность верхней обмотки кВА'
/
COMMENT ON COLUMN rt_transform3.ukzd IS 'Напряжение короткого замыкания нижней обмотки %'
/
COMMENT ON COLUMN rt_transform3.ukzm IS 'Напряжение короткого замыкания средней обмотки %'
/
COMMENT ON COLUMN rt_transform3.ukzu IS 'Напряжение короткого замыкания верхней обмотки %'
/

CREATE TABLE se_colors
    (classu                         NUMBER NOT NULL,
    color                          NUMBER NOT NULL
  ,
  CONSTRAINT PK_SE_COLORS
  PRIMARY KEY (classu))
/


-- Comments for SE_COLORS

COMMENT ON TABLE se_colors IS 'Раскраска объектов по классам напряжения'
/
COMMENT ON COLUMN se_colors.classu IS 'Класс напряжения'
/
COMMENT ON COLUMN se_colors.color IS 'Код цвета'
/

CREATE TABLE se_layers
    (sid                            NUMBER NOT NULL,
    layer                          NUMBER NOT NULL,
    name                           VARCHAR2(100),
    is_visible                     NUMBER DEFAULT 1

  ,
  CONSTRAINT PK_SE_LAYERS
  PRIMARY KEY (sid, layer))
/

COMMENT ON TABLE se_layers IS 'Перечень и видимость слоев схем'
/
COMMENT ON COLUMN se_layers.is_visible IS 'Видимость. 1 - видимый'
/
COMMENT ON COLUMN se_layers.layer IS 'Номер слоя'
/
COMMENT ON COLUMN se_layers.name IS 'Название слоя'
/
COMMENT ON COLUMN se_layers.sid IS 'Код схемы'
/


CREATE TABLE se_links
    (sid                            NUMBER NOT NULL,
    ord                            NUMBER NOT NULL,
    line_ord                       NUMBER NOT NULL,
    x                              NUMBER,
    y                              NUMBER,
    link_ord                       NUMBER NOT NULL
  ,
  CONSTRAINT PK_SE_LINKS
  PRIMARY KEY (sid, ord, line_ord))
/

COMMENT ON TABLE se_links IS 'Связи объектов схем графического редактора'
/
COMMENT ON COLUMN se_links.line_ord IS 'Ид линии'
/
COMMENT ON COLUMN se_links.link_ord IS 'Номер связи'
/
COMMENT ON COLUMN se_links.ord IS 'Порядковый номер обьекта в схеме'
/
COMMENT ON COLUMN se_links.sid IS 'Ид схемы'
/
CREATE TABLE se_objects
    (sid                            NUMBER NOT NULL,
    ord                            NUMBER NOT NULL,
    se_type                        NUMBER NOT NULL,
    oid                            NUMBER,
    name                           VARCHAR2(100),
    x1                             NUMBER NOT NULL,
    x2                             NUMBER NOT NULL,
    y1                             NUMBER NOT NULL,
    y2                             NUMBER NOT NULL,
    layer                          NUMBER,
    link_cnt                       NUMBER,
    linked                         NUMBER,
    classu                         NUMBER,
    subst                          NUMBER,
    feeder                         NUMBER,
    buses                          NUMBER,
    marked                         NUMBER,
    is_new                         NUMBER
  ,
  CONSTRAINT CODE_ORD_PK
  PRIMARY KEY (sid, ord))
/


-- Comments for SE_OBJECTS

COMMENT ON TABLE se_objects IS 'Объекты схем графического редактора'
/
COMMENT ON COLUMN se_objects.buses IS 'ID СШ'
/
COMMENT ON COLUMN se_objects.classu IS 'Класс напряжения'
/
COMMENT ON COLUMN se_objects.feeder IS 'Присоединение'
/
COMMENT ON COLUMN se_objects.is_new IS 'Признак нового объекта'
/
COMMENT ON COLUMN se_objects.layer IS 'Номер слоя'
/
COMMENT ON COLUMN se_objects.link_cnt IS 'Количество связей'
/
COMMENT ON COLUMN se_objects.linked IS 'Признак привязки. 1 - привязан'
/
COMMENT ON COLUMN se_objects.marked IS 'Используется при приязке к БД'
/
COMMENT ON COLUMN se_objects.name IS 'Название объекта'
/
COMMENT ON COLUMN se_objects.oid IS 'Ид объекта для связи с RT_OBJECTS'
/
COMMENT ON COLUMN se_objects.ord IS 'Порядковый номер обьекта в схеме'
/
COMMENT ON COLUMN se_objects.se_type IS 'Код типа объекта'
/
COMMENT ON COLUMN se_objects.sid IS 'Код схемы'
/
COMMENT ON COLUMN se_objects.subst IS 'Подстанция'
/
COMMENT ON COLUMN se_objects.x1 IS 'X1,Y1 - координаты левого верхнего угла объекта'
/
COMMENT ON COLUMN se_objects.x2 IS 'X2,Y2 - координаты правого нижнего угла'
/

CREATE TABLE se_properties
    (pid                            NUMBER NOT NULL,
    name                           VARCHAR2(100) NOT NULL,
    descr                          VARCHAR2(2000)
  ,
  CONSTRAINT PK_SE_PROPERTIES
  PRIMARY KEY (pid))
/

COMMENT ON TABLE se_properties IS 'Перечень свойств объектов'
/
COMMENT ON COLUMN se_properties.descr IS 'Описание'
/
COMMENT ON COLUMN se_properties.name IS 'Название свойства'
/
COMMENT ON COLUMN se_properties.pid IS 'Код свойства'
/

-- End of DDL Script for Table RYDA.SE_PROPERTIES

-- Start of DDL Script for Table RYDA.SE_SEQ
-- Generated 4-апр-2006 15:57:06 from RYDA@askue1

CREATE TABLE se_seq
    (val                            NUMBER NOT NULL)
/


-- Comments for SE_SEQ

COMMENT ON TABLE se_seq IS 'Имитатор последовательности для объектов редактора схем'
/
COMMENT ON COLUMN se_seq.val IS 'Текущее значение последовательности'
/

-- End of DDL Script for Table RYDA.SE_SEQ

-- Start of DDL Script for Table RYDA.SE_SHEETS
-- Generated 4-апр-2006 15:57:06 from RYDA@askue1

CREATE TABLE se_sheets
    (sid                            NUMBER NOT NULL,
    kind                           NUMBER DEFAULT 0,
    name                           VARCHAR2(100) NOT NULL,
    width                          NUMBER NOT NULL,
    height                         NUMBER NOT NULL,
    scale                          NUMBER DEFAULT 1,
    descr                          VARCHAR2(2000)
  ,
  CONSTRAINT PK_SE_SHEETS
  PRIMARY KEY (sid))
/


-- Comments for SE_SHEETS

COMMENT ON TABLE se_sheets IS 'Список схем графического редактора'
/
COMMENT ON COLUMN se_sheets.descr IS 'Комментарий'
/
COMMENT ON COLUMN se_sheets.height IS 'Высота в пикселах'
/
COMMENT ON COLUMN se_sheets.kind IS 'Тип: 0 - подстанция, 10 - схема сети'
/
COMMENT ON COLUMN se_sheets.name IS 'Название схемы'
/
COMMENT ON COLUMN se_sheets.scale IS 'Масштаб'
/
COMMENT ON COLUMN se_sheets.sid IS 'Ид схемы'
/
COMMENT ON COLUMN se_sheets.width IS 'Ширина в пикселах'
/

-- End of DDL Script for Table RYDA.SE_SHEETS

-- Start of DDL Script for Table RYDA.SE_TYPE_MAP
-- Generated 4-апр-2006 15:57:06 from RYDA@askue1

CREATE TABLE se_type_map
    (se_type                        NUMBER NOT NULL,
    name                           VARCHAR2(100),
    rt_type                        NUMBER NOT NULL,
    in_subst                       NUMBER,
    in_classu                      NUMBER,
    in_feeder                      NUMBER,
    in_line                        NUMBER,
    is_rtobj                       NUMBER
  ,
  CONSTRAINT PK_SE_TYPE_MAP
  PRIMARY KEY (se_type))
/


-- Comments for SE_TYPE_MAP

COMMENT ON TABLE se_type_map IS 'Таблица соответствия типов объектов в редакторе схем и дереве объектов'
/
COMMENT ON COLUMN se_type_map.in_classu IS 'присутствует в групп. по U'
/
COMMENT ON COLUMN se_type_map.in_feeder IS 'присутствует в групп. по фидеру'
/
COMMENT ON COLUMN se_type_map.in_line IS 'присутствует в групп. по линии'
/
COMMENT ON COLUMN se_type_map.in_subst IS 'присутствует в групп. по ПС'
/
COMMENT ON COLUMN se_type_map.is_rtobj IS 'входит в состав эл.-тех. оборудования'
/
COMMENT ON COLUMN se_type_map.name IS 'Название типа обекта'
/
COMMENT ON COLUMN se_type_map.rt_type IS 'Тип объекта в дереве объектов'
/
COMMENT ON COLUMN se_type_map.se_type IS 'Номер типа объекта в редакторе схем'
/

-- End of DDL Script for Table RYDA.SE_TYPE_MAP

-- Start of DDL Script for Table RYDA.SE_TYPE_PROPERTIES
-- Generated 4-апр-2006 15:57:06 from RYDA@askue1

CREATE TABLE se_type_properties
    (se_type                        NUMBER NOT NULL,
    pid                            NUMBER NOT NULL,
    parent                         NUMBER
  ,
  CONSTRAINT PK_SE_TYPE_PROPERTIES
  PRIMARY KEY (se_type, pid))
/


-- Comments for SE_TYPE_PROPERTIES

COMMENT ON TABLE se_type_properties IS 'Привязка набора свойств к типам объектов'
/
COMMENT ON COLUMN se_type_properties.parent IS 'Ссылка на включающий тип'
/
COMMENT ON COLUMN se_type_properties.pid IS 'Код свойства'
/
COMMENT ON COLUMN se_type_properties.se_type IS 'Ид типа объекта в редакторе схем'
/

-- End of DDL Script for Table RYDA.SE_TYPE_PROPERTIES

-- Start of DDL Script for Table RYDA.SE_VALUES
-- Generated 4-апр-2006 15:57:06 from RYDA@askue1

CREATE TABLE se_values
    (sid                            NUMBER NOT NULL,
    ord                            NUMBER NOT NULL,
    pid                            NUMBER DEFAULT 21

   NOT NULL,
    value                          VARCHAR2(500)
  ,
  CONSTRAINT PK_SE_VALUES
  PRIMARY KEY (sid, ord, pid))
/


-- Comments for SE_VALUES

COMMENT ON TABLE se_values IS 'Значения свойств объектов графического редактора'
/
COMMENT ON COLUMN se_values.ord IS 'Порядковый номер обьекта в схеме'
/
COMMENT ON COLUMN se_values.pid IS 'Код свойства'
/
COMMENT ON COLUMN se_values.sid IS 'Код схемы'
/
COMMENT ON COLUMN se_values.value IS 'Значение'
/

-- End of DDL Script for Table RYDA.SE_VALUES
-- Foreign Key
ALTER TABLE calc_hours
ADD CONSTRAINT calc_hours FOREIGN KEY (cpid)
REFERENCES calc_periods (cpid) ON DELETE CASCADE
/
-- Foreign Key
ALTER TABLE calc_links
ADD CONSTRAINT fk_calc_links_periods FOREIGN KEY (cpid)
REFERENCES calc_periods (cpid) ON DELETE CASCADE
/
-- Foreign Key
ALTER TABLE calc_results
ADD CONSTRAINT fk_calc_results_periods FOREIGN KEY (cpid)
REFERENCES calc_periods (cpid) ON DELETE CASCADE
/
-- Foreign Key
ALTER TABLE osm_switchings
ADD CONSTRAINT fk_osm_switchings_objects FOREIGN KEY (oid)
REFERENCES rt_objects (oid) ON DELETE CASCADE
/
-- Foreign Key

ALTER TABLE rt_feeders
ADD CONSTRAINT fk_rtfeeders_rtobjects FOREIGN KEY (oid)
REFERENCES rt_objects (oid) ON DELETE CASCADE
/
-- Foreign Key
ALTER TABLE rt_line
ADD CONSTRAINT fk_rtline_rtobjects FOREIGN KEY (oid)
REFERENCES rt_objects (oid) ON DELETE CASCADE
/
-- Foreign Key
ALTER TABLE rt_links
ADD CONSTRAINT fk_rt_links_rt_objects FOREIGN KEY (outfit)
REFERENCES rt_objects (oid) ON DELETE CASCADE
/
ALTER TABLE rt_links
ADD CONSTRAINT fk_rt_links_rt_objects1 FOREIGN KEY (feeder)
REFERENCES rt_objects (oid) ON DELETE CASCADE
/
ALTER TABLE rt_links
ADD CONSTRAINT fk_rt_links_rt_objects2 FOREIGN KEY (switch)
REFERENCES rt_objects (oid) ON DELETE CASCADE
/
-- Foreign Key
-- Foreign Key
ALTER TABLE rt_transform2
ADD CONSTRAINT fk_rttrans2_rtobjects FOREIGN KEY (oid)
REFERENCES rt_objects (oid) ON DELETE CASCADE
/
-- Foreign Key
ALTER TABLE rt_transform3
ADD CONSTRAINT fk_rttrans3_rtobjects FOREIGN KEY (oid)
REFERENCES rt_objects (oid) ON DELETE CASCADE
/
-- Foreign Key
ALTER TABLE se_links
ADD CONSTRAINT fk_selinks_seobj FOREIGN KEY (sid, ord)
REFERENCES se_objects (sid,ord) ON DELETE CASCADE
/
-- Foreign Key
ALTER TABLE se_objects
ADD CONSTRAINT fk_se_objects_se_sheets FOREIGN KEY (sid)
REFERENCES se_sheets (sid) ON DELETE CASCADE
/
ALTER TABLE se_objects
ADD CONSTRAINT fk_se_objects_se_type_map FOREIGN KEY (se_type)
REFERENCES se_type_map (se_type)
/
ALTER TABLE se_type_properties
ADD CONSTRAINT fk_setypeprop_setypemap FOREIGN KEY (se_type)
REFERENCES se_type_map (se_type) ON DELETE CASCADE
/
ALTER TABLE se_type_properties
ADD CONSTRAINT fk_se_type_prop_se_prop FOREIGN KEY (pid)
REFERENCES se_properties (pid) ON DELETE CASCADE
/
-- Foreign Key
ALTER TABLE se_values
ADD CONSTRAINT fk_se_values_se_objects FOREIGN KEY (sid, ord)
REFERENCES se_objects (sid,ord) ON DELETE CASCADE
/
ALTER TABLE se_values
ADD CONSTRAINT fk_se_values_se_properties FOREIGN KEY (pid)
REFERENCES se_properties (pid) ON DELETE CASCADE
/
-- End of DDL script for Foreign Key(s)


insert into rt_seq values(100000000)
/
insert into se_seq values(1)
/

INSERT INTO se_colors
VALUES
(.23,6184448)
/
INSERT INTO se_colors
VALUES
(.4,5459274)
/
INSERT INTO se_colors
VALUES
(3.5,14145280)
/
INSERT INTO se_colors
VALUES
(6,3368448)
/
INSERT INTO se_colors
VALUES
(10,8060928)
/
INSERT INTO se_colors
VALUES
(27.5,11534336)
/
INSERT INTO se_colors
VALUES
(35,7667829)
/
INSERT INTO se_colors
VALUES
(110,225)
/
INSERT INTO se_colors
VALUES
(150,43520)
/
INSERT INTO se_colors
VALUES
(220,299760)
/
INSERT INTO se_colors
VALUES
(330,16730184)
/
INSERT INTO se_colors
VALUES
(400,21414)
/
INSERT INTO se_colors
VALUES
(500,14943114)
/
INSERT INTO se_colors
VALUES
(750,159)
/
INSERT INTO se_colors
VALUES
(800,8421504)
/
INSERT INTO se_colors
VALUES
(1150,13238474)
/
INSERT INTO se_colors
VALUES
(1500,8513283)
/


INSERT INTO se_properties
VALUES
(20,'код данных',NULL)
/
INSERT INTO se_properties
VALUES
(21,'размер',NULL)
/
INSERT INTO se_properties
VALUES
(22,'переток',NULL)
/
INSERT INTO se_properties
VALUES
(9,'идентификатор',NULL)
/
INSERT INTO se_properties
VALUES
(1,'положение при нормальной схеме',NULL)
/
INSERT INTO se_properties
VALUES
(2,'уровень напряжения U2',NULL)
/
INSERT INTO se_properties
VALUES
(10,'Масштаб',NULL)
/
INSERT INTO se_properties
VALUES
(11,'Угол',NULL)
/
INSERT INTO se_properties
VALUES
(12,'Выравнивание',NULL)
/
INSERT INTO se_properties
VALUES
(13,'Наименование шрифта',NULL)
/
INSERT INTO se_properties
VALUES
(14,'Цвет',NULL)
/
INSERT INTO se_properties
VALUES
(15,'Алфавит',NULL)
/
INSERT INTO se_properties
VALUES
(3,'признак вертикальности',NULL)
/
INSERT INTO se_properties
VALUES
(4,'текст',NULL)
/
INSERT INTO se_properties
VALUES
(5,'положение стрелки',NULL)
/
INSERT INTO se_properties
VALUES
(6,'ширина линии',NULL)
/
INSERT INTO se_properties
VALUES
(16,'Размер шрифта',NULL)
/
INSERT INTO se_properties
VALUES
(17,'Жирный',NULL)
/
INSERT INTO se_properties
VALUES
(18,'Italic',NULL)
/
INSERT INTO se_properties
VALUES
(19,'Подчеркнутый',NULL)
/
INSERT INTO se_properties
VALUES
(7,'уровень напряжения U3',NULL)
/
INSERT INTO se_properties
VALUES
(8,'текст2',NULL)
/


INSERT INTO se_type_map
VALUES
(200,'Счетчик A',-1,NULL,NULL,NULL,NULL,NULL)
/
INSERT INTO se_type_map
VALUES
(210,'Счетчик R',-1,NULL,NULL,NULL,NULL,NULL)
/
INSERT INTO se_type_map
VALUES
(10,'Линия',500,NULL,NULL,NULL,1,1)
/
INSERT INTO se_type_map
VALUES
(20,'Секция шин (горизонтальная)',0,1,1,NULL,NULL,1)
/
INSERT INTO se_type_map
VALUES
(30,'МВ горизонтальный',300,1,1,1,NULL,1)
/
INSERT INTO se_type_map
VALUES
(50,'МВ вертикальный',300,1,1,1,NULL,1)
/
INSERT INTO se_type_map
VALUES
(40,'Трансформатор (двухобмоточный)',600,1,NULL,NULL,NULL,1)
/
INSERT INTO se_type_map
VALUES
(110,'Силовой трансформатор',610,1,NULL,NULL,NULL,1)
/
INSERT INTO se_type_map
VALUES
(60,'Ошиновка',-1,1,1,1,NULL,NULL)
/
INSERT INTO se_type_map
VALUES
(80,'Стрелочка',-1,1,1,1,NULL,NULL)
/
INSERT INTO se_type_map
VALUES
(90,'Отпайка',400,NULL,NULL,NULL,1,1)
/
INSERT INTO se_type_map
VALUES
(100,'Генератор',600,1,NULL,NULL,NULL,1)
/
INSERT INTO se_type_map
VALUES
(120,'Трансформатор СН',610,1,1,1,NULL,1)
/
INSERT INTO se_type_map
VALUES
(1000,'Подстанция',1000,NULL,NULL,NULL,NULL,1)
/
INSERT INTO se_type_map
VALUES
(950,'Класс напряжения',950,NULL,NULL,NULL,NULL,1)
/
INSERT INTO se_type_map
VALUES
(900,'Присоединение',900,NULL,NULL,NULL,NULL,1)
/
INSERT INTO se_type_map
VALUES
(500,'ВЛ',500,NULL,NULL,NULL,NULL,1)
/
INSERT INTO se_type_map
VALUES
(130,'Трансформатор тока',-1,1,1,1,NULL,NULL)
/
INSERT INTO se_type_map
VALUES
(160,'Счетчик MW',-1,NULL,NULL,NULL,NULL,NULL)
/
INSERT INTO se_type_map
VALUES
(170,'Счетчик MVAR',-1,NULL,NULL,NULL,NULL,NULL)
/
INSERT INTO se_type_map
VALUES
(180,'Счетчик MW',-1,NULL,NULL,NULL,NULL,NULL)
/
INSERT INTO se_type_map
VALUES
(190,'Счетчик MVAR',-1,NULL,NULL,NULL,NULL,NULL)
/
INSERT INTO se_type_map
VALUES
(70,'Текстовая метка',-1,NULL,NULL,NULL,NULL,NULL)
/
INSERT INTO se_type_map
VALUES
(140,'Прерывистая линия',-1,NULL,NULL,NULL,NULL,NULL)
/


INSERT INTO se_type_properties
VALUES
(200,4,NULL)
/
INSERT INTO se_type_properties
VALUES
(200,9,NULL)
/
INSERT INTO se_type_properties
VALUES
(200,20,NULL)
/
INSERT INTO se_type_properties
VALUES
(210,4,NULL)
/
INSERT INTO se_type_properties
VALUES
(210,9,NULL)
/
INSERT INTO se_type_properties
VALUES
(210,20,NULL)
/
INSERT INTO se_type_properties
VALUES
(200,21,NULL)
/
INSERT INTO se_type_properties
VALUES
(210,21,NULL)
/
INSERT INTO se_type_properties
VALUES
(160,4,NULL)
/
INSERT INTO se_type_properties
VALUES
(170,4,NULL)
/
INSERT INTO se_type_properties
VALUES
(170,9,NULL)
/
INSERT INTO se_type_properties
VALUES
(160,9,NULL)
/
INSERT INTO se_type_properties
VALUES
(50,1,NULL)
/
INSERT INTO se_type_properties
VALUES
(30,1,NULL)
/
INSERT INTO se_type_properties
VALUES
(180,9,NULL)
/
INSERT INTO se_type_properties
VALUES
(190,4,NULL)
/
INSERT INTO se_type_properties
VALUES
(190,9,NULL)
/
INSERT INTO se_type_properties
VALUES
(70,10,NULL)
/
INSERT INTO se_type_properties
VALUES
(70,11,NULL)
/
INSERT INTO se_type_properties
VALUES
(70,12,NULL)
/
INSERT INTO se_type_properties
VALUES
(70,13,NULL)
/
INSERT INTO se_type_properties
VALUES
(70,14,NULL)
/
INSERT INTO se_type_properties
VALUES
(40,2,NULL)
/
INSERT INTO se_type_properties
VALUES
(20,3,NULL)
/
INSERT INTO se_type_properties
VALUES
(60,3,NULL)
/
INSERT INTO se_type_properties
VALUES
(70,4,NULL)
/
INSERT INTO se_type_properties
VALUES
(80,5,NULL)
/
INSERT INTO se_type_properties
VALUES
(20,6,NULL)
/
INSERT INTO se_type_properties
VALUES
(180,4,NULL)
/
INSERT INTO se_type_properties
VALUES
(70,15,NULL)
/
INSERT INTO se_type_properties
VALUES
(70,16,NULL)
/
INSERT INTO se_type_properties
VALUES
(70,17,NULL)
/
INSERT INTO se_type_properties
VALUES
(70,18,NULL)
/
INSERT INTO se_type_properties
VALUES
(70,19,NULL)
/
INSERT INTO se_type_properties
VALUES
(1000,4,NULL)
/
INSERT INTO se_type_properties
VALUES
(1000,10,NULL)
/
INSERT INTO se_type_properties
VALUES
(1000,11,NULL)
/
INSERT INTO se_type_properties
VALUES
(1000,12,NULL)
/
INSERT INTO se_type_properties
VALUES
(1000,13,NULL)
/
INSERT INTO se_type_properties
VALUES
(1000,14,NULL)
/
INSERT INTO se_type_properties
VALUES
(1000,15,NULL)
/
INSERT INTO se_type_properties
VALUES
(1000,16,NULL)
/
INSERT INTO se_type_properties
VALUES
(1000,17,NULL)
/
INSERT INTO se_type_properties
VALUES
(1000,18,NULL)
/
INSERT INTO se_type_properties
VALUES
(1000,19,NULL)
/
INSERT INTO se_type_properties
VALUES
(950,4,NULL)
/
INSERT INTO se_type_properties
VALUES
(950,10,NULL)
/
INSERT INTO se_type_properties
VALUES
(950,11,NULL)
/
INSERT INTO se_type_properties
VALUES
(950,12,NULL)
/
INSERT INTO se_type_properties
VALUES
(950,13,NULL)
/
INSERT INTO se_type_properties
VALUES
(950,14,NULL)
/
INSERT INTO se_type_properties
VALUES
(950,15,NULL)
/
INSERT INTO se_type_properties
VALUES
(950,16,NULL)
/
INSERT INTO se_type_properties
VALUES
(950,17,NULL)
/
INSERT INTO se_type_properties
VALUES
(950,18,NULL)
/
INSERT INTO se_type_properties
VALUES
(950,19,NULL)
/
INSERT INTO se_type_properties
VALUES
(900,4,NULL)
/
INSERT INTO se_type_properties
VALUES
(900,10,NULL)
/
INSERT INTO se_type_properties
VALUES
(900,11,NULL)
/
INSERT INTO se_type_properties
VALUES
(900,12,NULL)
/
INSERT INTO se_type_properties
VALUES
(900,13,NULL)
/
INSERT INTO se_type_properties
VALUES
(900,14,NULL)
/
INSERT INTO se_type_properties
VALUES
(900,15,NULL)
/
INSERT INTO se_type_properties
VALUES
(900,16,NULL)
/
INSERT INTO se_type_properties
VALUES
(900,17,NULL)
/
INSERT INTO se_type_properties
VALUES
(900,18,NULL)
/
INSERT INTO se_type_properties
VALUES
(900,19,NULL)
/
INSERT INTO se_type_properties
VALUES
(500,4,NULL)
/
INSERT INTO se_type_properties
VALUES
(500,10,NULL)
/
INSERT INTO se_type_properties
VALUES
(500,11,NULL)
/
INSERT INTO se_type_properties
VALUES
(500,12,NULL)
/
INSERT INTO se_type_properties
VALUES
(500,13,NULL)
/
INSERT INTO se_type_properties
VALUES
(500,14,NULL)
/
INSERT INTO se_type_properties
VALUES
(500,15,NULL)
/
INSERT INTO se_type_properties
VALUES
(500,16,NULL)
/
INSERT INTO se_type_properties
VALUES
(500,17,NULL)
/
INSERT INTO se_type_properties
VALUES
(500,18,NULL)
/
INSERT INTO se_type_properties
VALUES
(500,19,NULL)
/
INSERT INTO se_type_properties
VALUES
(110,2,NULL)
/
INSERT INTO se_type_properties
VALUES
(110,7,NULL)
/
INSERT INTO se_type_properties
VALUES
(120,2,NULL)
/
INSERT INTO se_type_properties
VALUES
(120,7,NULL)
/
INSERT INTO se_type_properties
VALUES
(140,3,NULL)
/
INSERT INTO se_type_properties
VALUES
(160,22,NULL)
/
INSERT INTO se_type_properties
VALUES
(170,22,NULL)
/
INSERT INTO se_type_properties
VALUES
(180,22,NULL)
/
INSERT INTO se_type_properties
VALUES
(190,22,NULL)
/
INSERT INTO se_type_properties
VALUES
(200,22,NULL)
/
INSERT INTO se_type_properties
VALUES
(210,22,NULL)
/
commit
/

ALTER TABLE dict_obj_types
ADD CONSTRAINT uni_dict_obj_types1 UNIQUE (rt_type)
/
-- Foreign Key
ALTER TABLE se_type_map
ADD CONSTRAINT fk_setypemap_dictobjtype FOREIGN KEY (rt_type)
REFERENCES dict_obj_types (rt_type) ON DELETE CASCADE
/
-- Foreign Key
ALTER TABLE rt_objects
ADD CONSTRAINT fk_rtobj_dictobjtype FOREIGN KEY (rt_type)
REFERENCES dict_obj_types (rt_type)
/

CREATE OR REPLACE VIEW bill_l (
   mid,
   date_time,
   valid,
   source,
   remark,
   er_mtrsn,
   er_kc,
   erm,
   er,
   aerm,
   aer,
   berm,
   ber,
   cerm,
   cer,
   derm,
   der,
   q1_mtrsn,
   q1_kc,
   q1m,
   q1,
   aq1m,
   aq1,
   bq1m,
   bq1,
   cq1m,
   cq1,
   dq1m,
   dq1,
   ed_mtrsn,
   ed_kc,
   edm,
   ed,
   aedm,
   aed,
   bedm,
   bed,
   cedm,
   ced,
   dedm,
   ded,
   q3_mtrsn,
   q3_kc,
   q3m,
   q3,
   aq3m,
   aq3,
   bq3m,
   bq3,
   cq3m,
   cq3,
   dq3m,
   dq3,
   q2_mtrsn,
   q2_kc,
   q2m,
   q2,
   aq2m,
   aq2,
   bq2m,
   bq2,
   cq2m,
   cq2,
   dq2m,
   dq2,
   q4_mtrsn,
   q4_kc,
   q4m,
   q4,
   aq4m,
   aq4,
   bq4m,
   bq4,
   cq4m,
   cq4,
   dq4m,
   dq4,
   nwasteabs,
   nsource,
   qm )
AS
SELECT
    MID,
    DATE_TIME,
    VALID,
    SOURCE,
    REMARK,
    ER_MTRSN,
    ER_KC,
    ERM,
    ER,
    AERM,
    AER,
    BERM,
    BER,
    CERM,
    CER,
    DERM,
    DER,
    Q1_MTRSN,
    Q1_KC,
    Q1M,
    Q1,
    AQ1M,
    AQ1,
    BQ1M,
    BQ1,
    CQ1M,
    CQ1,
    DQ1M,
    DQ1,
    ED_MTRSN,
    ED_KC,
    EDM,
    ED,
    AEDM,
    AED,
    BEDM,
    BED,
    CEDM,
    CED,
    DEDM,
    DED,
    Q3_MTRSN,
    Q3_KC,
    Q3M,
    Q3,
    AQ3M,
    AQ3,
    BQ3M,
    BQ3,
    CQ3M,
    CQ3,
    DQ3M,
    DQ3,
    Q2_MTRSN,
    Q2_KC,
    Q2M,
    Q2,
    AQ2M,
    AQ2,
    BQ2M,
    BQ2,
    CQ2M,
    CQ2,
    DQ2M,
    DQ2,
    Q4_MTRSN,
    Q4_KC,
    Q4M,
    Q4,
    AQ4M,
    AQ4,
    BQ4M,
    BQ4,
    CQ4M,
    CQ4,
    DQ4M,
    DQ4,
    NWASTEABS,
    NSOURCE,
    QM
 FROM RYDA.BILLOLD WHERE NEXCEPTCALC IS NULL
/

COMMENT ON TABLE bill_l IS 'Реальные суточные измерения с потерями'
/

-- End of DDL script for BILL_L

-- Start of DDL script for BILL_OL
-- Generated 16-май-06  11:12:34 am
-- from oe-RYDA:8

-- View BILL_OL

CREATE OR REPLACE VIEW bill_ol (
   mid,
   date_time,
   valid,
   source,
   remark,
   er_mtrsn,
   er_kc,
   erm,
   er,
   aerm,
   aer,
   berm,
   ber,
   cerm,
   cer,
   derm,
   der,
   q1_mtrsn,
   q1_kc,
   q1m,
   q1,
   aq1m,
   aq1,
   bq1m,
   bq1,
   cq1m,
   cq1,
   dq1m,
   dq1,
   ed_mtrsn,
   ed_kc,
   edm,
   ed,
   aedm,
   aed,
   bedm,
   bed,
   cedm,
   ced,
   dedm,
   ded,
   q3_mtrsn,
   q3_kc,
   q3m,
   q3,
   aq3m,
   aq3,
   bq3m,
   bq3,
   cq3m,
   cq3,
   dq3m,
   dq3,
   q2_mtrsn,
   q2_kc,
   q2m,
   q2,
   aq2m,
   aq2,
   bq2m,
   bq2,
   cq2m,
   cq2,
   dq2m,
   dq2,
   q4_mtrsn,
   q4_kc,
   q4m,
   q4,
   aq4m,
   aq4,
   bq4m,
   bq4,
   cq4m,
   cq4,
   dq4m,
   dq4,
   nwasteabs,
   nsource,
   qm )
AS
SELECT
    MID,
    DATE_TIME,
    VALID,
    SOURCE,
    REMARK,
    ER_MTRSN,
    ER_KC,
    ERM,
    ER,
    AERM,
    AER,
    BERM,
    BER,
    CERM,
    CER,
    DERM,
    DER,
    Q1_MTRSN,
    Q1_KC,
    Q1M,
    Q1,
    AQ1M,
    AQ1,
    BQ1M,
    BQ1,
    CQ1M,
    CQ1,
    DQ1M,
    DQ1,
    ED_MTRSN,
    ED_KC,
    EDM,
    ED,
    AEDM,
    AED,
    BEDM,
    BED,
    CEDM,
    CED,
    DEDM,
    DED,
    Q3_MTRSN,
    Q3_KC,
    Q3M,
    Q3,
    AQ3M,
    AQ3,
    BQ3M,
    BQ3,
    CQ3M,
    CQ3,
    DQ3M,
    DQ3,
    Q2_MTRSN,
    Q2_KC,
    Q2M,
    Q2,
    AQ2M,
    AQ2,
    BQ2M,
    BQ2,
    CQ2M,
    CQ2,
    DQ2M,
    DQ2,
    Q4_MTRSN,
    Q4_KC,
    Q4M,
    Q4,
    AQ4M,
    AQ4,
    BQ4M,
    BQ4,
    CQ4M,
    CQ4,
    DQ4M,
    DQ4,
    NWASTEABS,
    NSOURCE,
    QM
 FROM RYDA.BILLOLD WHERE NEXCEPTCALC IS NULL and nsource<0
/

COMMENT ON TABLE bill_ol IS 'Реальные суточные измерения только потери'
/

-- End of DDL script for BILL_OL

-- Start of DDL script for HALFHOUR_L
-- Generated 16-май-06  11:12:44 am
-- from oe-RYDA:8

-- View HALFHOUR_L

CREATE OR REPLACE VIEW halfhour_l (
   mid,
   date_time,
   er,
   q1,
   ed,
   q3,
   q2,
   q4,
   erm,
   q1m,
   edm,
   q3m,
   q2m,
   q4m,
   status,
   nkc,
   nsource,
   er_mtrsn,
   nswitch,
   denter )
AS
SELECT
    MID,
    DATE_TIME,
    ER,
    Q1,
    ED,
    Q3,
    Q2,
    Q4,
    ERM,
    Q1M,
    EDM,
    Q3M,
    Q2M,
    Q4M,
    STATUS,
    NKC,
    NSOURCE,
    ER_MTRSN,
    NSWITCH,
    DENTER
 FROM RYDA.HALFHOUROLD WHERE NEXCEPTCALC IS NULL
/

COMMENT ON TABLE halfhour_l IS 'График нагрузки с потерями'
/

-- End of DDL script for HALFHOUR_L

-- Start of DDL script for HALFHOUR_OL
-- Generated 16-май-06  11:12:51 am
-- from oe-RYDA:8

-- View HALFHOUR_OL

CREATE OR REPLACE VIEW halfhour_ol (
   mid,
   date_time,
   er,
   q1,
   ed,
   q3,
   q2,
   q4,
   erm,
   q1m,
   edm,
   q3m,
   q2m,
   q4m,
   status,
   nkc,
   nsource,
   er_mtrsn,
   nswitch,
   denter )
AS
SELECT
    MID,
    DATE_TIME,
    ER,
    Q1,
    ED,
    Q3,
    Q2,
    Q4,
    ERM,
    Q1M,
    EDM,
    Q3M,
    Q2M,
    Q4M,
    STATUS,
    NKC,
    NSOURCE,
    ER_MTRSN,
    NSWITCH,
    DENTER
 FROM RYDA.HALFHOUROLD WHERE NEXCEPTCALC IS NULL and nsource<0
/

COMMENT ON TABLE halfhour_ol IS 'График нагрузки только потери'
/
-------18/05/2006
INSERT INTO RYDA.PROTOCOLS
VALUES
(61,'УППД - Сервер')
/
update protocols set NAME='УППД - Клиент' where PROTOCOL_ID=52
/
update form_templates set ENABLECONTROLS=ENABLECONTROLS||'1' where parent in (1,11,20) and length(ENABLECONTROLS)<8
/
commit
/

----------------------------------------------------------------------------------------------
--         VER 2.20  (Для обновления версии 2.20 до текущей скрипт запускать отсюда)        --
----------------------------------------------------------------------------------------------

ALTER TABLE calc_hours
ADD CONSTRAINT pk_half_hours PRIMARY KEY (cpid, oid)
/

--06/06/2006
create index calc_periods_idx1 on CALC_PERIODS (PERIOD asc)
/

create index calc_results_idx1 on CALC_RESULTS (CPID asc)
/

create index calc_hours_idx1 on CALC_HOURS (OID asc)
/

create index SE_TYPE_PROPERTIES_IDX1 on SE_TYPE_PROPERTIES (PID asc)
/

create index RT_LINKS_IDX1 on RT_LINKS (FEEDER asc)
/

create index RT_LINKS_IDX2 on RT_LINKS (SWITCH asc)
/

create index CALC_LINKS_IDX1 on CALC_LINKS (SWITCH asc)
/


-------------15/06/2006
declare
ln_customer_id NUMBER;
begin
SELECT NVL(SUM(DECODE(vvalue, '', 0, vvalue)), 0)   INTO ln_customer_id   FROM parameter  WHERE npid = 12;
if ln_customer_id=2 then
insert into parameter (NPID,VVALUE,VDESCRIPTION) values(31,1,'Контролировать суточные по РТУ');
else
insert into parameter (NPID,VVALUE,VDESCRIPTION) values(31,0,'Контролировать суточные по РТУ');
end if;
commit;
end;
/

declare
ln_customer_id NUMBER;
begin
SELECT NVL(SUM(DECODE(vvalue, '', 0, vvalue)), 0)   INTO ln_customer_id   FROM parameter  WHERE npid = 12;
if ln_customer_id in (3,10,11,27,28) then
insert into parameter (NPID,VVALUE,VDESCRIPTION) values(32,1,'Блокировка разноски суточных расходов на ГН');
else
insert into parameter (NPID,VVALUE,VDESCRIPTION) values(32,0,'Блокировка разноски суточных расходов на ГН');
end if;
commit;
end;
/
-------------16/06/2006
begin
execute immediate 'drop PACKAGE updt';
exception
 when others then null;
end;
/

begin
execute immediate 'drop PACKAGE UPDTC';
exception
 when others then null;
end;
/
/*
update parameter set VDESCRIPTION='Блокировка разноски суточных расходов на ГН при невозможности разноски' where npid=32
/
commit
/
*/
declare
ln_customer_id NUMBER;
begin
SELECT NVL(SUM(DECODE(vvalue, '', 0, vvalue)), 0)   INTO ln_customer_id   FROM parameter  WHERE npid = 12;
if ln_customer_id in (26,27,28) then
 for lc in (select mid from chanpoint where cid in (select cid from channels where protocol_id in(35,36,49,50))
            --union select mid from points where tag in (4,5) and mid in (select mid from chanpoint where cid in (select cid from channels where protocol_id in(14,15,39,40)))
            ) loop
 update curr_power set NFIU3=NFIU3+NFIU2, NFIi3=NFIi3+NFIU2 where mid=lc.mid;
 update curr_power_arch set NFIU3=NFIU3+NFIU2, NFIi3=NFIi3+NFIU2 where mid=lc.mid;
 commit;
 end loop;
end if;
end;
/

update curr_power set NFIU1=mod(NFIU1,360),NFIU2=mod(NFIU2,360),NFIU3=mod(NFIU3,360),
NFIi1=mod(NFIi1,360),NFIi2=mod(NFIi2,360),NFIi3=mod(NFIi3,360)
/
update curr_power_arch set NFIU1=mod(NFIU1,360),NFIU2=mod(NFIU2,360),NFIU3=mod(NFIU3,360),
NFIi1=mod(NFIi1,360),NFIi2=mod(NFIi2,360),NFIi3=mod(NFIi3,360)
/
commit
/
update curr_power set NFIU1=decode(sign(NFIU1),-1,360+NFIU1,NFIU1),NFIU2=decode(sign(NFIU2),-1,360+NFIU2,NFIU2),NFIU3=decode(sign(NFIU3),-1,360+NFIU3,NFIU3),
NFIi1=decode(sign(NFIi1),-1,360+NFIi1,NFIi1),NFIi2=decode(sign(NFIi2),-1,360+NFIi2,NFIi2),NFIi3=decode(sign(NFIi3),-1,360+NFIi3,NFIi3)
/
update curr_power_arch set NFIU1=decode(sign(NFIU1),-1,360+NFIU1,NFIU1),NFIU2=decode(sign(NFIU2),-1,360+NFIU2,NFIU2),NFIU3=decode(sign(NFIU3),-1,360+NFIU3,NFIU3),
NFIi1=decode(sign(NFIi1),-1,360+NFIi1,NFIi1),NFIi2=decode(sign(NFIi2),-1,360+NFIi2,NFIi2),NFIi3=decode(sign(NFIi3),-1,360+NFIi3,NFIi3)
/
commit
/

----------------------------------------------------------------------------------------------
--         VER 2.20.3  (Для обновления версии 2.20.3 до текущей скрипт запускать отсюда)        --
----------------------------------------------------------------------------------------------
---08/11/2006
declare
ln_customer_id NUMBER;
begin
SELECT NVL(SUM(DECODE(vvalue, '', 0, vvalue)), 0)   INTO ln_customer_id   FROM parameter  WHERE npid = 12;
if ln_customer_id in (0,11) then
INSERT INTO tasks
(TASK_ID,PARENT,TASK_COD,NAME,REMARK,nshow)
VALUES
(96,42,621,'1.21 Заполнение пропусков ГН','Ввод расхода с равномерной разбивкой на график нагрузки на тек сутки по дыркам',1);

insert into role_task
select ROLE_ID,96,decode(ROLE_ID,1,1,0) from roles;

commit;
end if;
end;
/

---14/11/2006
begin
INSERT INTO tasks
(TASK_ID,PARENT,TASK_COD,NAME,REMARK,nshow)
VALUES
(97,80,655,'9.03 Блокировка ввода показаний при вводе ОВ','9.03 Блокировка ввода показаний при вводе ОВ',1);

commit;
end;
/
-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     13.11.2006  14:27
-- ============================================================

-- ============================================================
--   Table: TCPARAMS
-- ============================================================
create table TCPARAMS
(
    NPARAM      NUMBER                 not null,
    VNAME       VARCHAR2(150)          not null,
    constraint TCPARAMS_PK primary key (NPARAM)
)
/

comment on table TCPARAMS is 'Условия'
/

comment on column TCPARAMS.NPARAM is 'Ид условия'
/

comment on column TCPARAMS.VNAME is 'Наименование'
/


-- ============================================================
--   Index: TCPARAMS_IDX1
-- ============================================================
create unique index TCPARAMS_IDX1 on TCPARAMS (VNAME asc)
/

-- ============================================================
--   Table: TCCONDITIONS
-- ============================================================
create table TCCONDITIONS
(
    NPARAM      NUMBER                 not null,
    DSTART      DATE                   not null,
    VCONDITION  VARCHAR2(2000)         null    ,
    constraint TCCONDITIONS_PK primary key (NPARAM, DSTART)
)
/

comment on table TCCONDITIONS is 'Условия выдачи ТУ'
/

comment on column TCCONDITIONS.NPARAM is 'Ид условия'
/

comment on column TCCONDITIONS.DSTART is 'Дата ввода в действие'
/

comment on column TCCONDITIONS.VCONDITION is 'Условие'
/


-- ============================================================
--   Table: TCSIGNALS
-- ============================================================
create table TCSIGNALS
(
    MID         NUMBER                 not null,
    CLAMP       NUMBER(10)             not null,
    NPARAM      NUMBER                 not null,
    VVALUE      VARCHAR2(512)          null    ,
    constraint TCSIGNALS_PK primary key (MID, CLAMP, NPARAM)
)
/

comment on table TCSIGNALS is 'Привязка сигналов ТУ'
/

comment on column TCSIGNALS.MID is 'Ид точки'
/

comment on column TCSIGNALS.CLAMP is 'Клема'
/

comment on column TCSIGNALS.NPARAM is 'Ид условия'
/

comment on column TCSIGNALS.VVALUE is 'Сигнал'
/


-- ============================================================
--   Index: TCSIGNALS_IDX1
-- ============================================================
create index TCSIGNALS_IDX1 on TCSIGNALS (NPARAM asc)
/

alter table TCPARAMS
    add constraint FK_TCPARAMS_REF_13332_POINTS foreign key  (NPARAM)
       references POINTS (MID) on delete cascade
/

alter table TCCONDITIONS
    add constraint FK_TCCONDIT_REF_13333_TCPARAMS foreign key  (NPARAM)
       references TCPARAMS (NPARAM) on delete cascade
/

alter table TCSIGNALS
    add constraint TCSIGNALS_F1 foreign key  (NPARAM)
       references TCPARAMS (NPARAM) on delete cascade
/

alter table TCSIGNALS
    add constraint TCSIGNALS_F2 foreign key  (MID)
       references POINTS (MID) on delete cascade
/


begin
INSERT INTO tasks
(TASK_ID,PARENT,TASK_COD,NAME,REMARK,nshow)
VALUES
(97,80,655,'9.03 Блокировка ввода показаний при вводе ОВ','9.03 Блокировка ввода показаний при вводе ОВ',1);

commit;
end;
/

/*
--Для ПХЗ
INSERT INTO tasks
(TASK_ID,PARENT,TASK_COD,NAME,REMARK,NSHOW)
VALUES
(101,27,1001,'6.12 Условия выдачи телеуправления','Условия выдачи телеуправления',1)
/
*/

update tasks set NAME='1.21 Заполнение пропусков ГН',
REMARK='Ввод расхода с равномерной разбивкой на график нагрузки на тек сутки по дыркам' where task_id=96
/

commit
/

----------------------------------------------------------------------------------------------
--         VER 2.20.5  (Для обновления версии 2.20.5 до текущей скрипт запускать отсюда)        --
----------------------------------------------------------------------------------------------

insert into parameter (NPID,VVALUE,VDESCRIPTION) values(33,0,'Блокировка ведения системных журналов')
/
commit
/

INSERT INTO deportprocedures
(NPROCEDURE,VNAME,VPROCEDURE,NPERIOD,NTYPE,VMEMO)
VALUES
(39,'Макет 30917 (почасовое формирование)','reports1_pg.m30917h_p',2,0,'Макет 30917 (получасовые расходы эл. энергии с почасовым формированием)')
/
commit
/


-----------12/07/2007 (Для СЭС)

INSERT INTO deportprocedures
(NPROCEDURE,VNAME,VPROCEDURE,NPERIOD,NTYPE,VMEMO)
VALUES
(40,'Северная. ЭС (ГН)','REPORTSSES_PG.mhour_p',2,0,'Северная ЭС (График нагрузки)')
/
INSERT INTO deportprocedures
(NPROCEDURE,VNAME,VPROCEDURE,NPERIOD,NTYPE,VMEMO)
VALUES
(41,'Северная. ЭС (Макет 20020)','REPORTSSES_PG.m20020_p',2,0,'Северная ЭС (Суточные показания)')
/
commit
/


-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     09.08.2007  9:46
-- ============================================================
alter table FEEDERS add
(
    VCODE              VARCHAR2(32)           null
)
/

comment on column FEEDERS.VCODE is 'Код точки'
/

create unique index FEEDERS_IDX7 on FEEDERS (VCODE asc)
/


------------15/08/2007
alter table DEPORTPROCEDURES drop constraint CKC_NPERIOD_DEPORTPR
/

alter table DEPORTPROCEDURES add (
        constraint CKC_NPERIOD_DEPORTPR check (NPERIOD in (1,2,3,4,5,0,6,7)))

/


INSERT INTO deportprocedures
(NPROCEDURE,VNAME,VPROCEDURE,NPERIOD,NTYPE,VMEMO)
VALUES
(42,'Донбасская ЭС (Макет 30817)','reports1_pg.des_m30817',2,0,'Донбасская ЭС (Макет 30817)')
/

INSERT INTO deportprocedures
(NPROCEDURE,VNAME,VPROCEDURE,NPERIOD,NTYPE,VMEMO)
VALUES
(43,'Северная. ЭС (Макет 20030)','REPORTSSES_PG.m20030_p',7,0,'Северная ЭС (Макет 20030 начало работы обходного)')
/
INSERT INTO deportprocedures
(NPROCEDURE,VNAME,VPROCEDURE,NPERIOD,NTYPE,VMEMO)
VALUES
(44,'Северная. ЭС (Макет 20031)','REPORTSSES_PG.m20031_p',7,0,'Северная ЭС (Макет 20031 окончания работы обходного)')
/
INSERT INTO deportprocedures
(NPROCEDURE,VNAME,VPROCEDURE,NPERIOD,NTYPE,VMEMO)
VALUES
(45,'Северная. ЭС (Макет 20040)','REPORTSSES_PG.m20040_p',7,0,'Северная ЭС (Макет 20040 замены счетчика)')
/
INSERT INTO deportprocedures
(NPROCEDURE,VNAME,VPROCEDURE,NPERIOD,NTYPE,VMEMO)
VALUES
(46,'Северная. ЭС (Макет 20120)','REPORTSSES_PG.m20120_p',7,0,'Северная ЭС (Макет 20120 замены коеф счетчика)')
/
INSERT INTO deportprocedures
(NPROCEDURE,VNAME,VPROCEDURE,NPERIOD,NTYPE,VMEMO)
VALUES
(47,'Северная. ЭС (Макет 20161)','REPORTSSES_PG.m20161_p',7,0,'Северная ЭС (Макет 20161 введения поправок)')
/
commit
/


-----13/10/07
alter table DEPORTPROCEDURES drop constraint CKC_NPERIOD_DEPORTPR
/

alter table DEPORTPROCEDURES add constraint CKC_NPERIOD_DEPORTPR check (NPERIOD in (1,2,3,4,5,0,6,7,8))
/


INSERT INTO deportprocedures
(NPROCEDURE,VNAME,VPROCEDURE,NPERIOD,NTYPE,VMEMO)
VALUES
(48,'Нарушение работы системы','FILE_PG.mEvents_p',7,0,'Универсальный макет посылки сообщений')
/
commit
/



INSERT INTO deportprocedures
(NPROCEDURE,VNAME,VPROCEDURE,NPERIOD,NTYPE,VMEMO)
VALUES
(49,'Контроль мощности','ryda.check_pg.checkpower',8,1,'Контроль мощности')
/
INSERT INTO deportprocedures
(NPROCEDURE,VNAME,VPROCEDURE,NPERIOD,NTYPE,VMEMO)
VALUES
(50,'Контроль суточных по сумме ГН','ryda.check_pg.by_day_and_hour',2,1,'Контроль суточных показаний по сумме ГН')
/
INSERT INTO deportprocedures
(NPROCEDURE,VNAME,VPROCEDURE,NPERIOD,NTYPE,VMEMO)
VALUES
(51,'Контроль номера устройства с НСИ','ryda.check_pg.checkmtrsn',2,1,'Контроль номера устройства с НСИ')
/
INSERT INTO deportprocedures
(NPROCEDURE,VNAME,VPROCEDURE,NPERIOD,NTYPE,VMEMO)
VALUES
(52,'Контроль полноты данных','ryda.check_pg.checkcomplete',2,1,'Контроль полноты данных')
/
commit
/

-------13/10/07
begin
insert into points (mid,parent,ind,name) select NPROCEDURE,2,1,VNAME from deportprocedures where NPROCEDURE in (49,50,51,52);
commit;
end;
/

-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     16.10.2007  17:19
-- ============================================================
alter table FEEDERS add
(
    VERIFYDAY          VARCHAR2(32)           null
)
/

comment on column FEEDERS.VERIFYPARAM is 'Парам верификации дубл'
/

comment on column FEEDERS.VERIFYDAY is 'Парам верификации суточных'
/



----------------------------------------------------------------------------------------------
--         VER 2.21  (Для обновления версии 2.21 до текущей скрипт запускать отсюда)        --
----------------------------------------------------------------------------------------------
--01/11/2007
declare
ln_customer_id NUMBER;
begin
SELECT NVL(SUM(DECODE(vvalue, '', 0, vvalue)), 0)   INTO ln_customer_id   FROM parameter  WHERE npid = 12;
 if ln_customer_id in (16) then
  update feeders set VADDPARAMS=';;'||VADDPARAMS where vaddparams is not null and substr(vaddparams,1,2)<>';;';
 elsif ln_customer_id in (14) then
  update feeders set VADDPARAMS=TRIM(util_pg.get_param(vinfo, 1))||';'||TRIM(util_pg.get_param(vinfo, 2))||';'||VADDPARAMS
  where (vaddparams is not null or vinfo is not null) and vaddparams not like '%;%;%' ;
 else
  update feeders set vaddparams=TRIM(util_pg.get_param(vinfo, 1))||';'||TRIM(util_pg.get_param(vinfo, 2))
  where vinfo is not null and (TRIM(util_pg.get_param(vinfo, 1))='1' or TRIM(util_pg.get_param(vinfo, 2)) in ('1','2'));
 end if;
 commit;
end;
/


----20/11/2007
INSERT INTO RYDA.PROTOCOLS
VALUES
(62,'СЭТ-4')
/
INSERT INTO RYDA.PROTOCOLS
VALUES
(63,'KM --> СЭТ-4')
/
INSERT INTO RYDA.PROTOCOLS
VALUES
(64,'ЦТ-5000')
/
INSERT INTO RYDA.PROTOCOLS
VALUES
(65,'KM --> ЦТ-5000')
/
INSERT INTO RYDA.PROTOCOLS
VALUES
(66,'Меркурий_230')
/
INSERT INTO RYDA.PROTOCOLS
VALUES
(67,'KM --> Меркурий_230')
/
INSERT INTO RYDA.PROTOCOLS
VALUES
(68,'LZQM')
/
INSERT INTO RYDA.PROTOCOLS
VALUES
(69,'KM --> LZQM')
/
INSERT INTO RYDA.PROTOCOLS
VALUES
(70,'ZxD (dlms)')
/
INSERT INTO RYDA.PROTOCOLS
VALUES
(71,'KM --> ZxD (dlms)')
/
commit
/

----21/11/2007
BEGIN
EXECUTE IMMEDIATE 'ALTER TRIGGER feeders_ins DISABLE';
EXECUTE IMMEDIATE 'ALTER TRIGGER feeders_UPD DISABLE';
EXECUTE IMMEDIATE 'ALTER TRIGGER feeders_DEL DISABLE';
EXCEPTION
WHEN OTHERS THEN NULL;
END;
/

alter TABLE feeders drop column  ncra
/
alter TABLE feeders drop column  ncrb
/
alter TABLE feeders drop column  ncrc
/
alter TABLE feeders drop column  ncrd
/
alter TABLE feeders drop column  ncda
/
alter TABLE feeders drop column  ncdb
/
alter TABLE feeders drop column  ncdc
/
alter TABLE feeders drop column  ncdd
/
alter TABLE feeders drop column  ncq1a
/
alter TABLE feeders drop column  ncq1b
/
alter TABLE feeders drop column  ncq1c
/
alter TABLE feeders drop column  ncq1d
/
alter TABLE feeders drop column  ncq3a
/
alter TABLE feeders drop column  ncq3b
/
alter TABLE feeders drop column  ncq3c
/
alter TABLE feeders drop column  ncq3d
/

alter table FEEDERS add
(
    NCLASSTN           NUMBER                 default 1/2 not null,
    NCLASSTT           NUMBER                 default 1/2 not null
)
/

comment on column FEEDERS.NTCURRENT is 'Трансформатор тока силовой'
/

comment on column FEEDERS.NTPOWER is 'Трансформатор напряжения силовой'
/

comment on column FEEDERS.NCLASSTT is 'Класс точности ТТ'
/

comment on column FEEDERS.NCLASSTN is 'Класс точности ТН'
/

INSERT INTO RYDA.PROTOCOLS
VALUES
(72,'ZxD (dlms+echo)')
/
INSERT INTO RYDA.PROTOCOLS
VALUES
(73,'KM --> ZxD (dlms+echo)')
/

commit
/



----------------------------------------------------------------------------------------------
--         VER 2.22  (Для обновления версии 2.22 до текущей скрипт запускать отсюда)        --
----------------------------------------------------------------------------------------------
--   Created on:     29.11.2007  9:32
-- ============================================================
create table OPERATINGDAY
(
    NOWNER   NUMBER                 not null,
    DSTART   DATE                   not null,
    MID      NUMBER                 null    ,
    GID      NUMBER                 null    ,
    DREGIME  DATE                   null    ,
    NSHIFT   NUMBER(10)             default 0 not null,
    constraint OPERATINGDAY_PK primary key (NOWNER, DSTART)
)
/

comment on table OPERATINGDAY is 'Режимные дни'
/

comment on column OPERATINGDAY.NOWNER is 'Ид точки вершины'
/

comment on column OPERATINGDAY.DSTART is 'Дата ввода в действие'
/

comment on column OPERATINGDAY.MID is 'Ид точки шаблона'
/

comment on column OPERATINGDAY.GID is 'Ид группы шаблона'
/

comment on column OPERATINGDAY.DREGIME is 'Режимный день'
/

comment on column OPERATINGDAY.NSHIFT is 'Сдвиг'
/


-- ============================================================
--   Index: OPERATINGDAY_IDX1
-- ============================================================
create index OPERATINGDAY_IDX1 on OPERATINGDAY (GID asc)
/

-- ============================================================
--   Index: OPERATINGDAY_IDX2
-- ============================================================
create index OPERATINGDAY_IDX2 on OPERATINGDAY (MID asc)
/

alter table OPERATINGDAY
    add constraint OPERATINGDAY_F1 foreign key  (NOWNER)
       references POINTS (MID) on delete cascade
/

alter table OPERATINGDAY
    add constraint OPERATINGDAY_F2 foreign key  (MID)
       references POINTS (MID)
/

alter table OPERATINGDAY
    add constraint OPERATINGDAY_F3 foreign key  (GID)
       references GROUPS (GID)
/



INSERT INTO form_templates
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(91,40,1207,'5.06. Универсальная таблица','','11111100',2,'')
/

commit
/

--21/12/2007
alter table PROTOCOLS add
(
    DLL_NAME     VARCHAR2(100)          null
)
/

comment on column PROTOCOLS.DLL_NAME is 'Наименование библиотеки'
/

--26/12/2007
INSERT INTO RYDA.PROTOCOLS
VALUES
(74,'FAG --> ZxU','')
/

commit
/

----------------------------------------------------------------------------------------------
--         VER 2.23  (Для обновления версии 2.23 до текущей скрипт запускать отсюда)        --
----------------------------------------------------------------------------------------------

-- ============================================================
--   Database name:  Model_2
--   DBMS name:      ORACLE Version 7.3
--   Created on:     23.01.2008  16:11
-- ============================================================

alter table VERSION add
(
    VPATH      VARCHAR2(256)          null
)
/


comment on column VERSION.VPATH is 'Путь для распаковки'
/


INSERT INTO deportprocedures
(NPROCEDURE,VNAME,VPROCEDURE,NPERIOD,NTYPE,VMEMO)
VALUES
(53,'Северная ЭС (ГН) - почасово','REPORTSSES_PG.MHOUR_P',1,0,'Северная ЭС (График нагрузки) - почасово')
/
commit
/


--------------12/02/2008
INSERT INTO protocols
(PROTOCOL_ID,NAME,DLL_NAME)
VALUES
(75,'CE-304','')
/
INSERT INTO protocols
(PROTOCOL_ID,NAME,DLL_NAME)
VALUES
(76,'KM --> CE-304','')
/
INSERT INTO protocols
(PROTOCOL_ID,NAME,DLL_NAME)
VALUES
(1002,'АСКУЭ Хартэп (DLL)','DbLink_OraKh.dll')
/
commit
/

---------13.02.2008
alter table GROUPS  add(
   NFROMPERIOD          NUMBER(6)
      constraint CKC_NFROMPERIOD_GROUPS check (NFROMPERIOD is null or (mod(NFROMPERIOD,100) between 1 and 12)),
   NTILLPERIOD          NUMBER(6)
      constraint CKC_NTILLPERIOD_GROUPS check (NTILLPERIOD is null or (mod(NTILLPERIOD,100) between 1 and 12))
)
/

comment on column GROUPS.NFROMPERIOD is 'Период с'
/

comment on column GROUPS.NTILLPERIOD is 'Период по'
/

--14/02/2008
begin
execute immediate 'grant execute on COMSRVDLL_PG to askuerep';
exception
when others then null;
end;
/


---15/02/2008
/*==============================================================*/
/* Table: ICCPMEASURMENT                                        */
/*==============================================================*/
create global temporary table ICCPMEASURMENT  (
   ID                   NUMBER(10)                      not null,
   DDATETIME            DATE                            not null,
   VALUE                NUMBER                          not null,
   VALIDITY             NUMBER(1)                      default 0 not null
      constraint CKC_VALIDITY_ICCPMEAS check (VALIDITY in (0,1,2)),
   QUALITY              NUMBER(10)                      not null,
   SOURCE               NUMBER(1)                      default 0 not null
      constraint CKC_SOURCE_ICCPMEAS check (SOURCE in (0,1,2)),
   constraint PK_ICCPMEASURMENT primary key (ID, DDATETIME)
)
 ON COMMIT DELETE ROWS
 ORGANIZATION HEAP
 CACHE
/

comment on table ICCPMEASURMENT is
'ICCP измерения'
/

comment on column ICCPMEASURMENT.ID is
'Ид измерения'
/

comment on column ICCPMEASURMENT.DDATETIME is
'Дата'
/

comment on column ICCPMEASURMENT.VALUE is
'Значение'
/

comment on column ICCPMEASURMENT.VALIDITY is
'Достоверность'
/

comment on column ICCPMEASURMENT.QUALITY is
'Метка качества'
/

comment on column ICCPMEASURMENT.SOURCE is
'Источник'
/


------26/02/2008
INSERT INTO RYDA.PROTOCOLS
VALUES
(77,'ICCP - клиент', null)
/
INSERT INTO RYDA.PROTOCOLS
VALUES
(78,'CE-6850', null)
/
INSERT INTO RYDA.PROTOCOLS
VALUES
(79,'KM --> CE-6850', null)
/
INSERT INTO RYDA.PROTOCOLS
VALUES
(80,'CE-303', null)
/
INSERT INTO RYDA.PROTOCOLS
VALUES
(81,'KM --> CE-303', null)
/
INSERT INTO RYDA.PROTOCOLS
VALUES
(82,'ЕвроАльфа (коммерч)', null)
/
INSERT INTO RYDA.PROTOCOLS
VALUES
(83,'KM --> ЕвроАльфа (коммерч)', null)
/
INSERT INTO RYDA.PROTOCOLS
VALUES
(84,'EA10 Альфа (коммерч)', null)
/
INSERT INTO RYDA.PROTOCOLS
VALUES
(85,'KM --> EA10 Альфа (коммерч)', null)
/
commit
/

----------------------------------------------------------------------------------------------
--         VER 2.24  (Для обновления версии 2.24 до текущей скрипт запускать отсюда)        --
----------------------------------------------------------------------------------------------
--DROP ROLE ASKUE_WORK;
begin
execute immediate 'CREATE ROLE askue_work';
exception
 when others then null;
end;
/
GRANT CREATE SESSION TO askue_work
/
GRANT ALTER SESSION TO askue_work
/
GRANT INSERT ON forms_ex TO askue_work
/
GRANT UPDATE ON forms_ex TO askue_work
/
DECLARE
BEGIN
 FOR lc IN (SELECT 'grant select on ' || table_name || ' to ASKUE_WORK' c
              FROM user_tables WHERE table_name NOT IN ('USERPASS')
            UNION ALL
            SELECT 'grant select on ' || view_name || ' to ASKUE_WORK' c
              FROM user_views
            UNION ALL
            SELECT 'grant execute on ' || object_name || ' to ASKUE_WORK' c
              FROM user_objects
             WHERE object_type = 'PROCEDURE'
            UNION ALL
            SELECT 'grant execute on ' || object_name || ' to ASKUE_WORK' c
              FROM user_objects
             WHERE object_type = 'FUNCTION'
            UNION ALL
            SELECT 'grant execute on ' || object_name || ' to ASKUE_WORK' c
              FROM user_objects
             WHERE object_type = 'PACKAGE') LOOP
  BEGIN
   EXECUTE IMMEDIATE lc.c;
  EXCEPTION
   WHEN OTHERS THEN
    NULL;
  END;
 END LOOP;
END;
/


------04/03/2008
INSERT INTO parameter
(NPID,VVALUE,VDESCRIPTION)
VALUES
(34,'USERS','Табличное пространство по умолчанию')
/
INSERT INTO parameter
(NPID,VVALUE,VDESCRIPTION)
VALUES
(35,'TEMP','Временное табличное пространство')
/
commit
/

declare
lv_deftablespace varchar2(256) default 'USERS';---Табл пространство (если такого нет, то нужно заменить на существующее)
lv_tmptablespace varchar2(256) default 'TEMP';---Табл пространство (если такого нет, то нужно заменить на существующее)
ln_count NUMBER;
begin
 select count(*) into ln_count from USER_TABLESPACES where TABLESPACE_NAME in (lv_deftablespace,lv_tmptablespace);
 if ln_count<>2 then
  raise_application_error(-20001, 'укажите правильное табл пространство 5-ю и 6-ю строками выше');
 end if;
 for lc in (select 'KHARTEPADM' USR,'KHARTEPADM' PASSWORD,'KHARTEPADM' NAME,'*'ADMIN,min(ROLE_ID) ROLE_ID from users
            having not exists (select * from users where upper(USR)='KHARTEPADM')) loop
   insert into users(USER_ID,USR,PASSWORD,NAME,ADMIN,ROLE_ID) values(users_seq.nextval,lc.USR,lc.PASSWORD,lc.NAME,lc.ADMIN,lc.ROLE_ID);
 end loop;
 commit;
 for lc in (select USER_ID,USR,trim(PASSWORD) PASSWORD from users where USR not in (select username from all_users)) loop
  begin
   update users set USR=replace(upper(trim(USR)),' ','') where USER_ID=lc.USER_ID;
   EXECUTE IMMEDIATE 'CREATE USER ' || replace(upper(trim(lc.USR)),' ','') || ' IDENTIFIED BY ' || lc.PASSWORD || ' DEFAULT TABLESPACE ' ||
                     lv_deftablespace || ' TEMPORARY TABLESPACE ' || lv_tmptablespace;
   EXECUTE IMMEDIATE 'GRANT ASKUE_WORK TO ' || lc.USR;
   EXECUTE IMMEDIATE 'ALTER USER ' || lc.USR || ' DEFAULT ROLE ASKUE_WORK';
  exception
   when others then
    NULL;--delete from users where USER_ID=lc.USER_ID;
  end;
  commit;
 end loop;
end;
/

------04/03/2008
/*==============================================================*/
/* Table: USERS                                                 */
/*==============================================================*/
alter table USERS  modify(
   USR                  VARCHAR2(50)                    not null,
   ROLE_ID              NUMBER                          not null
)
/


----11.03.2007
/*==============================================================*/
/* Table: POINTSPARAM                                           */
/*==============================================================*/
alter table POINTSPARAM  add(
   NKC                  NUMBER                         default 1 not null
)
/

comment on column POINTSPARAM.NKC is
'Коеф пересчета'
/

INSERT INTO calcpointtype
(NCALCPOINTTYPE,VNAME)
VALUES
(5,'Расчетная точка (как сумма по группе)')
/

commit
/


/*==============================================================*/
/* Table: CALCPOINTBYGROUP                                      */
/*==============================================================*/
create table CALCPOINTBYGROUP  (
   MID                  NUMBER                          not null,
   GID                  NUMBER                          not null,
   constraint PK_CALCPOINTBYGROUP primary key (MID)
);

comment on table CALCPOINTBYGROUP is
'Расчетные точки по группе';

comment on column CALCPOINTBYGROUP.MID is
'Ид точки';

comment on column CALCPOINTBYGROUP.GID is
'Ид группы';

/*==============================================================*/
/* Index: CALCPOINTBYGROUP_IDX1                                 */
/*==============================================================*/
create index CALCPOINTBYGROUP_IDX1 on CALCPOINTBYGROUP (
   GID ASC
);

alter table CALCPOINTBYGROUP
   add constraint CALCPOINTBYGROUP_F1 foreign key (MID)
      references FEEDERS (MID)
      on delete cascade;

alter table CALCPOINTBYGROUP
   add constraint CALCPOINTBYGROUP_F2 foreign key (GID)
      references GROUPS (GID)
      on delete cascade;


----14/03/2007
drop table ICCPMEASURMENT
/


--19/03/2008
INSERT INTO RYDA.PROTOCOLS
VALUES
(1003,'EVision2 (DLL)', 'EVision.dll')
/
INSERT INTO RYDA.PROTOCOLS
VALUES
(1004,'АСУЭ Инэт (DLL)', 'DbLink_OraInet.dll')
/
commit
/


--------25/03/2008
/*==============================================================*/
/* Table: METERPARAMETER                                        */
/*==============================================================*/
create table METERPARAMETER  (
   MID                  NUMBER                          not null,
   DDATE                DATE                            not null,
   VFILENAME            VARCHAR2(128),
   BFILE                BLOB,
   VNOTE                VARCHAR2(2000),
   constraint PK_METERPARAMETER primary key (MID, DDATE)
);

comment on table METERPARAMETER is
'Параметризация счетчиков';

comment on column METERPARAMETER.MID is
'Ид точки';

comment on column METERPARAMETER.DDATE is
'Дата параметризации';

comment on column METERPARAMETER.VFILENAME is
'Имя файла';

comment on column METERPARAMETER.BFILE is
'Файл';

comment on column METERPARAMETER.VNOTE is
'Примечание';

alter table METERPARAMETER
   add constraint METERPARAMETER_F1 foreign key (MID)
      references POINTS (MID)
      on delete cascade;

grant update on meterparameter to askue_work
/

begin
delete from points where mid in (select nmaket from makets where nprocedure=26);
delete from points where mid=26;
delete from deportprocedures where nprocedure=26;
commit;
end;
/

--31/01/2008
INSERT INTO protocols
(PROTOCOL_ID,NAME,DLL_NAME)
VALUES
(86,'Satec','')
/
INSERT INTO protocols
(PROTOCOL_ID,NAME,DLL_NAME)
VALUES
(87,'KM --> Satec','')
/

commit
/
----------------------------------------------------------------------------------------------
--         VER 2.25  (Для обновления версии 2.25 до текущей скрипт запускать отсюда)        --
----------------------------------------------------------------------------------------------
--02/04/2007
begin
INSERT INTO tasks
(TASK_ID,PARENT,TASK_COD,NAME,REMARK,NSHOW)
VALUES
(98,80,656,'9.04 Квитирование сообщений','9.04 Квитирование сообщений',0);


insert into role_task
select distinct ROLE_ID,98,1 from users;


INSERT INTO deportprocedures
(NPROCEDURE,VNAME,VPROCEDURE,NPERIOD,NTYPE,VMEMO)
VALUES
(54,'Макет 4024','reports1_pg.m4024_p',2,0,'Макет 4024');

commit;
exception
 when others then null;
end;
/

--08/04/2008
/*==============================================================*/
/* Table: SRV                                                   */
/*==============================================================*/
create table SRV  (
   NSRV                 NUMBER(10)                      not null,
   VNAME                VARCHAR2(32)                    not null,
   MID                  NUMBER                          not null,
   constraint PK_SRV primary key (NSRV)
);

comment on table SRV is
'Сервера сбора данных';

comment on column SRV.NSRV is
'Ид ССД';

comment on column SRV.VNAME is
'Наименование сервера';

comment on column SRV.MID is
'Ид вершины каналов';

/*==============================================================*/
/* Index: SRV_IDX1                                              */
/*==============================================================*/
create unique index SRV_IDX1 on SRV (
   VNAME ASC
);

/*==============================================================*/
/* Index: SRV_IDX2                                              */
/*==============================================================*/
create unique index SRV_IDX2 on SRV (
   MID ASC
);

alter table SRV
   add constraint SRV_F1 foreign key (MID)
      references POINTS (MID)
      on delete cascade;

insert into SRV(NSRV,VNAME,mid) values(1,'Главный ССД',1)
/

commit
/

/*==============================================================*/
/* Table: COMPORTS                                              */
/*==============================================================*/
alter table COMPORTS  add(
   NSRV                 NUMBER(10)                     default 1 not null,
   COM_NUM              NUMBER(10)                     default 1 not null
);

update COMPORTS set COM_NUM=COM_ID where NSRV=1
/

commit
/

alter table COMPORTS  add(
      constraint CKC_COM_NUM_COMPORTS check (COM_NUM between 1 and 128)
);

comment on column COMPORTS.NSRV is
'Ид ССД';

comment on column COMPORTS.COM_NUM is
'Номер компорта';

/*==============================================================*/
/* Index: COMPORTS_IDX3                                         */
/*==============================================================*/
create unique index COMPORTS_IDX3 on COMPORTS (
   NSRV ASC,
   COM_NUM ASC
);

alter table COMPORTS
   add constraint COMPORTS_F3 foreign key (NSRV)
      references SRV (NSRV)
      on delete cascade;


--------------09.04.2008
/*==============================================================*/
/* Table: ICCPTMPMEAS                                           */
/*==============================================================*/
create table ICCPTMPMEAS  (
   MID                  NUMBER                          not null,
   DATE_TIME            DATE                           default sysdate not null,
   ER                   NUMBER,
   Q1                   NUMBER,
   ED                   NUMBER,
   Q3                   NUMBER,
   Q2                   NUMBER,
   Q4                   NUMBER,
   ERM                  NUMBER,
   EDM                  NUMBER,
   Q1M                  NUMBER,
   Q3M                  NUMBER,
   Q2M                  NUMBER,
   Q4M                  NUMBER,
   constraint PK_ICCPTMPMEAS primary key (MID)
);

comment on table ICCPTMPMEAS is
'Измерения ICCP';

comment on column ICCPTMPMEAS.MID is
'Ид точки';

comment on column ICCPTMPMEAS.DATE_TIME is
'Дата';

comment on column ICCPTMPMEAS.ER is
'Мощность А';

comment on column ICCPTMPMEAS.Q1 is
'Мощность Р';

comment on column ICCPTMPMEAS.ED is
'Мощность А отд';

comment on column ICCPTMPMEAS.Q3 is
'Мощность Р отд';

comment on column ICCPTMPMEAS.Q2 is
'Мощность Р 2';

comment on column ICCPTMPMEAS.Q4 is
'Мощность Р 4';

comment on column ICCPTMPMEAS.ERM is
'Показания А';

comment on column ICCPTMPMEAS.EDM is
'Показания А отд';

comment on column ICCPTMPMEAS.Q1M is
'Показания Р';

comment on column ICCPTMPMEAS.Q3M is
'Показания Р отд';

comment on column ICCPTMPMEAS.Q2M is
'Показания Р 2';

comment on column ICCPTMPMEAS.Q4M is
'Показания Р 4';

alter table ICCPTMPMEAS
   add constraint ICCPTMPMEAS_F1 foreign key (MID)
      references POINTS (MID)
      on delete cascade;

/*
---Только по разрешению ХАРТЭП (Сечин А.А.)
declare
ln_srv NUMBER default 2;
begin
 begin
  INSERT INTO points(MID,PARENT,COD,IND,NAME,SHORT_NAME,PTYPE,IMPLEMENT_DATE,TAG,NPOINT)
  VALUES(101,1,NULL,1,'Главный ССД','',NULL,'',NULL,NULL);
  update points set parent=101 where parent=1 and mid<>101;
  update SRV set mid=101 where NSRV=1;
 exception
 when others then
  NULL;
 end;
 INSERT INTO points(MID,PARENT,COD,IND,NAME,SHORT_NAME,PTYPE,IMPLEMENT_DATE,TAG,NPOINT)
 VALUES(100+ln_srv,1,NULL,1,'ССД в Купянске','',NULL,'',NULL,NULL);
 insert into SRV(NSRV,VNAME,mid) values(ln_srv,'ССД в Купянске',100+ln_srv);
 for i in 1..128 loop
  insert into comports(COM_ID,    NAME,    BAUDRATE,    BYTESIZE,    PARITY,    STOPBITS,    DLASTEVENT,    NCOMTYPE,    NONLYONE,NSRV,COM_NUM)
  values((ln_srv-1)*1000+i,'COM'||i,9600,8,0,1,sysdate,1,0,ln_srv,i);
 end loop;
 commit;
end;
/
*/

----10/04/2008
/*==============================================================*/
/* Table: FEEDERS                                               */
/*==============================================================*/
alter table FEEDERS  add(
   NTIMEZONEW           NUMBER(2)                      default 2 not null
      constraint CKC_NTIMEZONEW_FEEDERS check (NTIMEZONEW between -14 and 14),
   NTIMEZONES           NUMBER(2)                      default 3 not null
      constraint CKC_NTIMEZONES_FEEDERS check (NTIMEZONES between -14 and 14)
);

comment on column FEEDERS.NTIMEZONEW is
'Веменная зона зимой';

comment on column FEEDERS.NTIMEZONES is
'Веменная зона летом';

INSERT INTO RYDA.PROTOCOLS
VALUES
(1005,'EVision2-BSS (DLL)', 'EVBSS.dll')
/

commit
/

BEGIN
delete from version where VFILENAME='ASKUE.GID';
COMMIT;
END;
/

----------23/04/2008
declare
l NUMBER;
begin
select nvl(max(decode(vvalue,'11',2,'1',1,0)),0) into l from parameter where NPID=12;
insert into parameter (NPID,VVALUE,VDESCRIPTION) values(36,l,'Тип расчета потерь 1-старый 2-Схемы, иначе деньги собирай');
commit;
end;
/

-----------24.04.2008
declare
l NUMBER;
begin
select nvl(max(decode(vvalue,'1',1,0)),0) into l from parameter where NPID=12;
insert into parameter (NPID,VVALUE,VDESCRIPTION) values(37,l,'Использование новой схемы администрирования.');
commit;
end;
/

/*==============================================================*/
/* Table: USERPASS                                              */
/*==============================================================*/
create table USERPASS  (
   USER_ID              NUMBER                          not null,
   PASSWORD             VARCHAR2(50)                    not null,
   constraint PK_USERPASS primary key (USER_ID)
);

comment on table USERPASS is
'Пароли пользователей';

comment on column USERPASS.USER_ID is
'Ид пользователя';

comment on column USERPASS.PASSWORD is
'Пароль';

alter table USERPASS
   add constraint USERPASS_F1 foreign key (USER_ID)
      references USERS (USER_ID)
      on delete cascade;

insert into USERPASS(USER_ID,PASSWORD)
select USER_ID,nvl(PASSWORD,USR) from users;

commit;

----------------------------------------------------------------------------------------------
--         VER 2.26  (Для обновления версии 2.26 до текущей скрипт запускать отсюда)        --
----------------------------------------------------------------------------------------------
---------06/05/2008
insert into parameter (NPID,VVALUE,VDESCRIPTION) values(38,0,'Учитывать часовой пояс счетчика.');

commit;

--20/05/2008
begin
begin
execute immediate 'drop index POINTS_PARENT_X';
exception
when others then null;
end;
begin
execute immediate 'create unique index POINTS_UNI on POINTS (PARENT ASC,NAME ASC)';
exception
when others then null;
end;
end;
/

alter table POINTS  add(
   NROOT                NUMBER(10)
);

comment on column POINTS.NROOT is
'Ид точки в родительской БД';

create index POINTS_IDX3 on POINTS (
   NROOT ASC
);


----21/05/2008
/*==============================================================*/
/* Table: METEREVENTSDICT                                       */
/*==============================================================*/
create table METEREVENTSDICT  (
   NMETERTYPE           NUMBER(10)                      not null,
   NEVENTCLASS          NUMBER(10)                      not null,
   NEVENTCODE           NUMBER(10)                      not null,
   VEVENTTEXT           VARCHAR2(256),
   NLOCK                NUMBER(1)                      default 0 not null
      constraint CKC_NLOCK_METEREVE check (NLOCK in (0,1)),
   constraint PK_METEREVENTSDICT primary key (NMETERTYPE, NEVENTCLASS, NEVENTCODE)
);

comment on table METEREVENTSDICT is
'Сообщения счетчиков';

comment on column METEREVENTSDICT.NMETERTYPE is
'Тип счетчика или УСД';

comment on column METEREVENTSDICT.NEVENTCLASS is
'Класс сообщения';

comment on column METEREVENTSDICT.NEVENTCODE is
'Код сообщения';

comment on column METEREVENTSDICT.VEVENTTEXT is
'Тескст сообщения';

comment on column METEREVENTSDICT.NLOCK is
'Блокировка вывода';

begin
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,1,1,'Периодический ОПИ');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,1,2,'Асинхронный ОПИ');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,1,3,'Периодический ОРП');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,1,4,'Программируемый ОРП');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,1,5,'Асинхронный ОРП');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,1,6,'Индекс DPM');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,1,7,'Восстановлен внутренний индекс');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,1,8,'Индекс _управляющий ввод');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,1,9,'Суточный график_ЛУ');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,1,10,'Восстановлен внутренний сут. график');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,1,11,'Суточный график_управляющий ввод');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,1,12,'Сезон_SM');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,1,13,'Восстановлен внутренний сезон');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,1,14,'Сезон_управляющий ввод');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,1,15,'Переход на З/Л (ПЗЛ) время с сезоном');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,1,16,'Внешняя синхр-ия и ПЗЛ с сезоном');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,1,17,'IР цепь включена');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,1,18,'IР цепь выключена');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,1,19,'Ассоциация_LN_программирования');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,1,20,'Потребл. энергии выше лимита_регистр энергии');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,1,21,'Потребл. энергии ниже лимита_регистр энергии');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,1,22,'Потребл. энергии выше лимита_график нагрузки');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,1,23,'Потребл. энергии ниже лимита_график нагрузки');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,1,24,'Обнаружена нефатальная ошибка');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,1,25,'Нефатальная ошибка исчезла');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,1,26,'Обнаружена фатальная ошибка');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,1,27,'Сохранение параметров');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,1,28,'Нефатальные ошибки сквитированы');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,1,29,'Фатальные ошибки сквитированы');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,1,30,'Внутренняя синхронизация часов');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,1,31,'Внешняя синхронизация часов');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,1,32,'Установка часов');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,1,33,'Внешняя синхр. и переход З/Л время без сезона');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,1,34,'Переход на З/Л время без сезона');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,1,35,'Обнаружено исчезновение перем.тока');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,1,36,'Восстановление перем.тока');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,1,37,'Исчезло напряжение питания');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,1,38,'Появилось напряжение питания');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,1,39,'ПРОГРАММНЫЙ_СМ');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,1,40,'ПРОГРАММНЫЙ_DI');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,1,41,'Отмена _ ПРОГРАММНЫЙ_DI');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,1,42,'Сброс данных измерений');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,1,43,'Начало измерений');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,1,44,'Остановка измерений');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,1,45,'Начало тестов');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,1,46,'Остановка тестов');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,1,47,'Окончание сохранения текущих данных');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,1,48,'Сброс графика нагрузки');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,1,49,'Восстановление пароля');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,1,50,'Индекс остановки часов');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,1,51,'Успешная коммуникация');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,2,1,'Внутренняя ошибка RAM');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,2,2,'Внешняя ошибка RAM');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,2,3,'Внутр. ошибка программ. памяти');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,2,4,'Внешн. ошибка программ. памяти');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,2,5,'Фатальная ошибка NOVRAM');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,2,6,'Многократная несинхронизация часов');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,2,7,'Работа функции "Wathdog"');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,2,8,'Рассоглас. часов с внешн. источником');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,2,9,'Несоответствие конфигурации');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,2,10,'Нефатальная ошибка NOVRAM');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,2,11,'Ошибка связи');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,2,12,'Программная несовместимость');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,2,13,'Открытие крышки счетчика');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,2,14,'Небаланс токов в фазах 1и 2');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,2,15,'Небаланс токов в фазах 2и 3');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,2,16,'Небаланс токов в фазах 1и 3');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,2,17,'Контроль напряжения фазы 1');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,2,18,'Контроль напряжения фазы 2');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,2,19,'Контроль напряжения фазы 3');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,2,20,'Обрыв нейтрали');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,2,21,'Нет внутр. метрологических имп-ов');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,2,22,'Нет импульсов от внешних приборов');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,2,23,'Последовательность нулей напряжения');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,2,24,'Последовательность нулей тока');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,2,25,'Остановка (неверный ход) часов');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,2,26,'"Тревога" от внешн. устройства');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,2,27,'Изменение направления тока фазы 1');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,2,28,'Изменение направления тока фазы 2');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,2,29,'Изменение направления тока фазы 3');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,2,30,'Повышение температуры');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,2,31,'Исчезновение напряжения фазы 1');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,2,32,'Исчезновение напряжения фазы 2');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,2,33,'Исчезновение напряжения фазы 3');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,2,34,'Понижение напряжения фазы 1');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,2,35,'Понижение напряжения фазы 2');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,2,36,'Понижение напряжения фазы 3');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,2,37,'Повышение напряжения фазы 1');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,2,38,'Повышение напряжения фазы 2');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,2,39,'Повышение напряжения фазы 3');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,2,40,'Батарея');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (1,2,41,'Превышение нагрузки');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (2,1,0,'Норма');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (2,1,1,'К каналу подключен счетчик с нулевым или недопустимым сетевым адресом');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (2,1,2,'Открытие доступа к счетчику');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (2,1,3,'Проверка пароля счетчиком');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (2,1,4,'Установка таймаута обмена со счетчиком');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (2,1,5,'Запрос времени счетчика');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (2,1,6,'Коррекция времени счетчика');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (2,1,7,'Чтение параметров счетчика');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (2,1,8,'Чтение текущих значений счетчика и параметров сети');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (2,1,9,'Чтение ГН счетчика');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (2,1,10,'Чтение суточных показаний счетчика');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (2,1,11,'Чтение месячных показаний счетчика');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (2,1,12,'Очистка ГН счетчика');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (2,1,13,'Очистка журнала событий счетчика');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (2,1,14,'Окончание опроса счетчика');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (2,1,15,'Закрытие доступа к счетчику');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (2,1,16,'Перевод счетчика в Program mode');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (2,1,17,'Перевод счетчика в Readout mode');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (2,1,18,'Чтение журнала событий счетчика');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (2,1,19,'Закрытие доступа к счетчику (COSEM/DLMS)');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (2,1,20,'Чтение параметров сети (EA)');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (2,1,255,'Канал не инициализирован');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (2,2,0,'Норма');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (2,2,2,'Таймаут при выполнении запроса к или получении ответа от счетчика');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (2,2,3,'Ошибка в контрольной сумме пакета ответа от счетчика');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (2,2,4,'Ошибочный запрос к или ответ от счетчика');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (2,2,5,'Рассогласование времени между УСД и счетчиком превышает максимально допустимое');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (2,2,6,'Граница получаса при чтении ГН или граница суток/месяца при чтении суточных/месячных данных счетчика');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (2,2,7,'Ответ от счетчика не помещается в буфер приема УСД');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (2,2,8,'Ошибка инициализации API COSEM');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (2,2,9,'Ошибка открытия СОМ порта API COSEM');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (2,2,10,'Ошибка создания контекста COSEM');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (2,2,11,'Ошибка COSEM открытия доступа к счетчику');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (2,2,12,'Ошибка COSEM закрытия доступа к счетчику');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (2,2,13,'Ошибка удаления контекста COSEM');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (2,2,14,'Ошибка закрытия СОМ порта API COSEM');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (2,2,15,'Ошибка деинициализации API COSEM');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (2,2,16,'Ошибка COSEM чтения данных счетчика');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (2,2,17,'Ошибка чтения файла');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (2,2,18,'Ошибка COSEM установки времени счетчика');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (2,2,19,'Отсутствие данных авточтения счетчика');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (2,2,20,'Программное исключение при опросе счетчика');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (2,2,21,'Ошибка в параметрах ГН счетчика');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (2,2,22,'Недопустимый сетевой адрес счетчика');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (2,2,23,'Недопустимый номер блока биллинговых данных');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (2,2,24,'Отсутствует файл системы безопасности');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (2,2,25,'Ошибка создания файла системы безопасности');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (2,2,26,'Неверная длина класса памяти Альфы');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (2,2,129,'Нет необходимости в получении данных');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (2,2,130,'Контекст устройства не подерживантся');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (2,2,139,'Тип идентификации не поддерживается');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (2,2,140,'Название типа идентификации обязательно');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (2,2,141,'Неверное имя/пароль доступа к счетчику');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (2,2,142,'Пароль доступа к счетчику не может быть пустым');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (2,2,201,'Нет связи со счетчиком');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (2,2,209,'Неверный пароль доступа');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,0,'Событие счетчика: 0');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,1,'1: Параметризация или изменение конфигурации');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,2,'2: Обнуление тарифных регистров');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,3,'3: Обнуление памяти профиля данных');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,4,'4: Выполнен сброс');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,5,'5: Батарея разряжена');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,6,'6: Батарея заменена');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,7,'7: Напряжение батареи в норме ');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,8,'Событие счетчика: 8');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,9,'9: Переход лето/зима');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,10,'10: Изменение времени/даты (старое значение)');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,11,'11: Изменение времени/даты (новое значение)');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,12,'Событие счетчика: 12');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,13,'13: Изменение статуса управляющих входов');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,14,'Событие счетчика: 14');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,15,'Событие счетчика: 15');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,16,'Событие счетчика: 16');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,17,'17: Снижение напряжение ниже допустимого по фазе L1');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,18,'18: Снижение напряжение ниже допустимого по фазе L2');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,19,'19: Снижение напряжение ниже допустимого по фазе L3');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,20,'20: Перенапряжение по фазе L1');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,21,'21: Перенапряжение по фазе L2');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,22,'22: Перенапряжение по фазе L3');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,23,'23: Провал напряжения');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,24,'24: Восстановление напряжения');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,25,'25: Перегрузка по току фаза L1');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,26,'26: Перегрузка по току фаза L2');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,27,'27: Перегрузка по току фаза L3');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,28,'28: Перегрузка по току в нейтрали');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,29,'29: Сигналы событий коэффициента мощности ');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,30,'30: Сигналы событий коэффициента мощности ');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,31,'31: Сигналы событий коэффициента мощности ');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,32,'32: Сигналы событий коэффициента мощности ');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,33,'33: Сигналы событий значения усредненной мощности Pтекущее');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,34,'34: Сигналы событий значения усредненной мощности Pтекущее');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,35,'35: Сигналы событий значения усредненной мощности Pтекущее');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,36,'36: Сигналы событий значения усредненной мощности Pтекущее');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,37,'37: Сигналы событий значения усредненной мощности Pтекущее');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,38,'38: Сигналы событий значения усредненной мощности Pтекущее');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,39,'39: Сигналы событий значения усредненной мощности Pтекущее');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,40,'40: Сигналы событий значения усредненной мощности Pтекущее');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,41,'Событие счетчика: 41');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,42,'Событие счетчика: 42');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,43,'Событие счетчика: 43');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,44,'Событие счетчика: 44');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,45,'45: Ошибка самотестирования (4)');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,46,'46: Ошибка самотестирования (4)');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,47,'47: Ошибка самотестирования (4)');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,48,'48: Ошибка самотестирования (4)');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,49,'Событие счетчика: 49');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,50,'Событие счетчика: 50');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,51,'Событие счетчика: 51');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,52,'Событие счетчика: 52');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,53,'Событие счетчика: 53');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,54,'Событие счетчика: 54');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,55,'Событие счетчика: 55');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,56,'Событие счетчика: 56');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,57,'Событие счетчика: 57');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,58,'Событие счетчика: 58');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,59,'Событие счетчика: 59');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,60,'Событие счетчика: 60');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,61,'Событие счетчика: 61');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,62,'Событие счетчика: 62');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,63,'Событие счетчика: 63');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,64,'Событие счетчика: 64');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,65,'65: Ошибка "Батарея разряжена "');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,66,'66: Ошибка "Некорректное время/дата"');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,67,'Событие счетчика: 67');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,68,'Событие счетчика: 68');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,69,'Событие счетчика: 69');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,70,'Событие счетчика: 70');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,71,'Событие счетчика: 71');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,72,'Событие счетчика: 72');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,73,'73: Ошибка "Доступ к основной памяти"');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,74,'74: Ошибка "Доступ к памяти параметров"');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,75,'75: Ошибка "Доступ к памяти системы измерений"');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,76,'76: Ошибка "Базы времени"');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,77,'77: Ошибка "Доступ к памяти профиля данных"');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,78,'78: Ошибка "Приемник сигналов управления"');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,79,'79: Ошибка "Коммуникационный модуль"');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,80,'80: Ошибка "Дисплей и панель управления"');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,81,'81: Ошибка "Контрольная сумма кода программы"');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,82,'82: Ошибка "Контрольная сумма данных резервного копирования"');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,83,'83: Ошибка "Контрольная сумма данных параметризации"');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,84,'84: Ошибка "Контрольная сумма данных профиля данных "');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,85,'85: Ошибка "Контрольная сумма данных списка событий"');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,86,'Событие счетчика: 86');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,87,'Событие счетчика: 87');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,88,'Событие счетчика: 88');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,89,'Событие счетчика: 89');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,90,'90: Ошибка "Измерительная система"');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,91,'91: Ошибка "Перепрограммирование"');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,92,'92: Ошибка "Режим установки"');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,93,'93: Ошибка "Система"');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,94,'94: Ошибка "Связь заблокирована"');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,95,'95: Ошибка "Некорр. идентификация EEPROM"');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,96,'96: Ошибка "Некорр. функционирование длительная идентификация"');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,97,'Событие счетчика: 97');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,98,'Событие счетчика: 98');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,99,'Событие счетчика: 99');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,100,'Событие счетчика: 100');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,101,'Событие счетчика: 101');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,102,'Событие счетчика: 102');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,103,'Событие счетчика: 103');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,104,'Событие счетчика: 104');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,105,'Событие счетчика: 105');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,106,'Событие счетчика: 106');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,107,'Событие счетчика: 107');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,108,'Событие счетчика: 108');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,109,'Событие счетчика: 109');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,110,'Событие счетчика: 110');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,111,'Событие счетчика: 111');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,112,'Событие счетчика: 112');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,113,'Событие счетчика: 113');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,114,'Событие счетчика: 114');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,115,'Событие счетчика: 115');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,116,'Событие счетчика: 116');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,117,'Событие счетчика: 117');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,118,'Событие счетчика: 118');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,119,'Событие счетчика: 119');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,120,'Событие счетчика: 120');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,121,'Событие счетчика: 121');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,122,'Событие счетчика: 122');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,123,'Событие счетчика: 123');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,124,'Событие счетчика: 124');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,125,'Событие счетчика: 125');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,126,'Событие счетчика: 126');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,127,'Событие счетчика: 127');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,128,'Событие счетчика: 128');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,129,'Событие счетчика: 129');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,130,'Событие счетчика: 130');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,131,'Событие счетчика: 131');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,132,'Событие счетчика: 132');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,133,'Событие счетчика: 133');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,134,'Событие счетчика: 134');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,135,'Событие счетчика: 135');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,136,'Событие счетчика: 136');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,137,'Событие счетчика: 137');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,138,'Событие счетчика: 138');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,139,'Событие счетчика: 139');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,140,'Событие счетчика: 140');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,141,'Событие счетчика: 141');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,142,'Событие счетчика: 142');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,143,'Событие счетчика: 143');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,144,'Событие счетчика: 144');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,145,'Событие счетчика: 145');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,146,'Событие счетчика: 146');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,147,'Событие счетчика: 147');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,148,'Событие счетчика: 148');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,149,'Событие счетчика: 149');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,150,'Событие счетчика: 150');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,151,'Событие счетчика: 151');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,152,'Событие счетчика: 152');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,153,'Событие счетчика: 153');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,154,'Событие счетчика: 154');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,155,'Событие счетчика: 155');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,156,'Событие счетчика: 156');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,157,'Событие счетчика: 157');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,158,'Событие счетчика: 158');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,159,'Событие счетчика: 159');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,160,'Событие счетчика: 160');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,161,'Событие счетчика: 161');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,162,'Событие счетчика: 162');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,163,'Событие счетчика: 163');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,164,'Событие счетчика: 164');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,165,'Событие счетчика: 165');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,166,'Событие счетчика: 166');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,167,'Событие счетчика: 167');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,168,'Событие счетчика: 168');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,169,'Событие счетчика: 169');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,170,'Событие счетчика: 170');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,171,'Событие счетчика: 171');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,172,'Событие счетчика: 172');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,173,'Событие счетчика: 173');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,174,'Событие счетчика: 174');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,175,'Событие счетчика: 175');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,176,'Событие счетчика: 176');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,177,'Событие счетчика: 177');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,178,'Событие счетчика: 178');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,179,'Событие счетчика: 179');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,180,'Событие счетчика: 180');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,181,'Событие счетчика: 181');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,182,'Событие счетчика: 182');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,183,'Событие счетчика: 183');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,184,'Событие счетчика: 184');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,185,'Событие счетчика: 185');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,186,'Событие счетчика: 186');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,187,'Событие счетчика: 187');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,188,'Событие счетчика: 188');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,189,'Событие счетчика: 189');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,190,'Событие счетчика: 190');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,191,'Событие счетчика: 191');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,192,'Событие счетчика: 192');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,193,'Событие счетчика: 193');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,194,'Событие счетчика: 194');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,195,'Событие счетчика: 195');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,196,'Событие счетчика: 196');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,197,'Событие счетчика: 197');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,198,'Событие счетчика: 198');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,199,'Событие счетчика: 199');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,200,'Событие счетчика: 200');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,201,'Событие счетчика: 201');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,202,'Событие счетчика: 202');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,203,'Событие счетчика: 203');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,204,'Событие счетчика: 204');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,205,'Событие счетчика: 205');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,206,'Событие счетчика: 206');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,207,'Событие счетчика: 207');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,208,'Событие счетчика: 208');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,209,'Событие счетчика: 209');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,210,'Событие счетчика: 210');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,211,'Событие счетчика: 211');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,212,'Событие счетчика: 212');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,213,'Событие счетчика: 213');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,214,'Событие счетчика: 214');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,215,'Событие счетчика: 215');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,216,'Событие счетчика: 216');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,217,'Событие счетчика: 217');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,218,'Событие счетчика: 218');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,219,'Событие счетчика: 219');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,220,'Событие счетчика: 220');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,221,'Событие счетчика: 221');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,222,'Событие счетчика: 222');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,223,'Событие счетчика: 223');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,224,'Событие счетчика: 224');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,225,'Событие счетчика: 225');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,226,'Событие счетчика: 226');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,227,'Событие счетчика: 227');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,228,'Событие счетчика: 228');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,229,'Событие счетчика: 229');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,230,'Событие счетчика: 230');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,231,'Событие счетчика: 231');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,232,'Событие счетчика: 232');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,233,'Событие счетчика: 233');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,234,'Событие счетчика: 234');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,235,'Событие счетчика: 235');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,236,'Событие счетчика: 236');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,237,'Событие счетчика: 237');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,238,'Событие счетчика: 238');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,239,'Событие счетчика: 239');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,240,'Событие счетчика: 240');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,241,'Событие счетчика: 241');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,242,'Событие счетчика: 242');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,243,'Событие счетчика: 243');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,244,'Событие счетчика: 244');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,245,'Событие счетчика: 245');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,246,'Событие счетчика: 246');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,247,'Событие счетчика: 247');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,248,'Событие счетчика: 248');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,249,'Событие счетчика: 249');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,250,'Событие счетчика: 250');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,251,'Событие счетчика: 251');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,252,'Событие счетчика: 252');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,253,'Событие счетчика: 253');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,254,'Событие счетчика: 254');
INSERT INTO METEREVENTSDICT (NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT) VALUES (3,1,255,'Событие счетчика: 255');
commit;
end;
/

alter table GROUPS  drop constraint GROUPS_UNI;

update groups set NFROMPERIOD= 190001 where NFROMPERIOD is null;

/*==============================================================*/
/* Table: GROUPS                                                */
/*==============================================================*/
 alter table GROUPS  modify (
   NFROMPERIOD          NUMBER(6)                      default 190001 not null
);

/*==============================================================*/
/* Index: GROUPS_UNI                                            */
/*==============================================================*/
begin
execute immediate 'drop index GROUPS_UNI';
exception when others then null;
end;
/

create unique index GROUPS_UNI on GROUPS (
   PARENT ASC,
   NAME ASC,
   NFROMPERIOD ASC
);


/*==============================================================*/
/* Table: ADDPOINTPARAM                                         */
/*==============================================================*/
create table ADDPOINTPARAM  (
   NSORT                NUMBER(10)                      not null,
   VDESCR               VARCHAR2(128)                   not null,
   NTYPE                NUMBER(10)                     default 0 not null
      constraint CKC_NTYPE_ADDPOINT check (NTYPE in (0,1,2,3,4,5)),
   constraint PK_ADDPOINTPARAM primary key (NSORT)
);

comment on table ADDPOINTPARAM is
'Доп параметры ТУ';

comment on column ADDPOINTPARAM.NSORT is
'Номер аттрибута';

comment on column ADDPOINTPARAM.VDESCR is
'Описание';

comment on column ADDPOINTPARAM.NTYPE is
'Тип аттрибута';

/*==============================================================*/
/* Index: ADDPOINTPARAM_IDX1                                    */
/*==============================================================*/
create unique index ADDPOINTPARAM_IDX1 on ADDPOINTPARAM (
   VDESCR ASC
);

/*==============================================================*/
/* Table: ADDPOINTPARAMVAL                                      */
/*==============================================================*/
create table ADDPOINTPARAMVAL  (
   MID                  NUMBER                          not null,
   NSORT                NUMBER(10)                      not null,
   VVALUE               VARCHAR2(2000)                  not null,
   constraint PK_ADDPOINTPARAMVAL primary key (MID, NSORT)
);

comment on table ADDPOINTPARAMVAL is
'Значения доп пар ТУ';

comment on column ADDPOINTPARAMVAL.MID is
'Ид точки';

comment on column ADDPOINTPARAMVAL.NSORT is
'Номер аттрибута';

comment on column ADDPOINTPARAMVAL.VVALUE is
'Значение';

/*==============================================================*/
/* Index: ADDPOINTPARAMVAL_IDX1                                 */
/*==============================================================*/
create index ADDPOINTPARAMVAL_IDX1 on ADDPOINTPARAMVAL (
   NSORT ASC
);

alter table ADDPOINTPARAMVAL
   add constraint ADDPOINTPARAMVAL_F1 foreign key (NSORT)
      references ADDPOINTPARAM (NSORT)
      on delete cascade;

alter table ADDPOINTPARAMVAL
   add constraint ADDPOINTPARAMVAL_F2 foreign key (MID)
      references FEEDERS (MID)
      on delete cascade;


begin
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (44,'Схема включения счетчика',0);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (45,'Количество тарифов счетчика',1);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (31,'Тип ТН (Фаза C)',0);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (32,'Зав № ТН (Фаза C)',0);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (1,'Тип ТТ (Фаза A)',0);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (2,'Зав № ТТ(Фаза A)',0);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (3,'Клас точности обмотки ТТ (Фаза A)',2);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (4,'Допустимая нагрузка втор. обмотки ТТ, Ом (Фаза A)',2);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (5,'Фактическая нагрузка втор. обмотки ТТ, Ом (Фаза A)',2);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (6,'Примечание ТТ (Фаза A)',0);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (7,'Тип ТТ (Фаза B)',0);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (8,'Зав № ТТ (Фаза B)',0);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (9,'Клас точности обмотки ТТ (Фаза B)',2);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (10,'Допустимая нагрузка втор. обмотки ТТ, Ом (Фаза B)',2);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (11,'Фактическая нагрузка втор. обмотки ТТ, Ом (Фаза B)',2);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (13,'Тип ТТ (Фаза C)',0);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (14,'Зав № ТТ (Фаза C)',0);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (15,'Клас точности обмотки ТТ (Фаза C)',2);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (16,'Допустимая нагрузка втор. обмотки ТТ, Ом (Фаза C)',2);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (17,'Фактическая нагрузка втор. обмотки ТТ, Ом (Фаза C)',2);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (18,'Примечание ТТ (Фаза C)',0);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (19,'Тип ТН (Фаза A)',0);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (20,'Зав № ТН(Фаза A)',0);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (21,'Клас точности обмотки ТН (Фаза A)',2);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (22,'Допустимая нагрузка втор. обмотки ТН, ВА (Фаза A)',2);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (23,'Фактическая нагрузка втор. обмотки ТН, ВА (Фаза A)',2);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (24,'Примечание ТН (Фаза A)',0);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (25,'Тип ТН (Фаза B)',0);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (26,'Зав № ТН (Фаза B)',0);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (27,'Клас точности обмотки ТН (Фаза B)',2);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (28,'Допустимая нагрузка втор. обмотки ТН, ВА (Фаза B)',2);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (29,'Фактическая нагрузка втор. обмотки ТН, ВА (Фаза B)',2);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (30,'Примечание ТН (Фаза B)',0);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (33,'Клас точности обмотки ТН (Фаза C)',2);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (34,'Допустимая нагрузка втор. обмотки ТН, ВА (Фаза C)',2);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (35,'Фактическая нагрузка втор. обмотки ТН, ВА (Фаза C)',2);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (36,'Примечание ТН (Фаза C)',0);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (37,'Схема соединения обмоток',0);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (38,'Допустимые потери от ТН до счетчика, В',2);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (39,'Фактические потери от ТН до счетчика, В (Фаза A)',2);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (40,'Фактические потери от ТН до счетчика, В (Фаза B)',2);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (41,'Фактические потери от ТН до счетчика, В (Фаза C)',2);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (42,'Дата протокола поверки элементов комплекса',3);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (43,'Номер протокола поверки элементов комплекса',0);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (12,'Примечание ТТ (Фаза B)',0);
commit;
end;
/


----------------------------------------------------------------------------------------------
--         VER 2.26  (Для обновления версии 2.26 до текущей скрипт запускать отсюда)        --
----------------------------------------------------------------------------------------------
begin
update ADDPOINTPARAM set NTYPE=0 where NSORT=45;
commit;
end;
/

drop table PASSIVE_DVS
/


alter table METERS  modify(
   NAME                 VARCHAR2(150)
);


---28/07/2008
/*==============================================================*/
/* Table: MAKETERR                                              */
/*==============================================================*/
create table MAKETERR  (
   NGROUP               NUMBER(10)                      not null,
   DDATE                DATE                            not null,
   ERR                  NUMBER,
   constraint PK_MAKETERR primary key (NGROUP, DDATE)
);

comment on table MAKETERR is
'Ошибки округления 30817';

comment on column MAKETERR.NGROUP is
'Группа';

comment on column MAKETERR.DDATE is
'Отчетная дата';

comment on column MAKETERR.ERR is
'Ошибка округления';

/*==============================================================*/
/* Index: MAKETERR_IDX1                                         */
/*==============================================================*/
create index MAKETERR_IDX1 on MAKETERR (
   DDATE ASC
);

alter table MAKETERR
   add constraint MAKETERR_F1 foreign key (NGROUP)
      references MAKETGROUPS (NGROUP)
      on delete cascade;


declare
l NUMBER;
begin
select nvl(max(decode(vvalue,'10',1,0)),0) into l from parameter where NPID=12;
insert into parameter (NPID,VVALUE,VDESCRIPTION) values(39,l,'Переносить остатки при расчете 30817 на след сутки.');
commit;
end;
/


----------------------------------------------------------------------------------------------
--         VER 2.26.4  (Для обновления версии 2.26.3 до текущей скрипт запускать отсюда)        --
----------------------------------------------------------------------------------------------
begin
insert into parameter (NPID,VVALUE,VDESCRIPTION) values(40,'UA.KHARTEP_','Глобальный префикс системы.');
commit;
end;
/

----------------------------------------------------------------------------------------------
--         VER 2.26.5  (Для обновления версии 2.26.4 до текущей скрипт запускать отсюда)        --
----------------------------------------------------------------------------------------------
INSERT INTO form_templates
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(92,1,206,'1.17. Небаланс активной энергии',
'Небаланс активной энергии [тыс.кВтч]','11110111',2,'')
/
commit
/

begin
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (-1,'Предупредительная нижняя граница (A+), кВт',2);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (-2,'Предупредительная верхня граница (A+, кВт',2);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (-3,'Аварийная нижняя граница (A+), кВт',2);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (-4,'Аварийная верхня граница (A+), кВт',2);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (-5,'Физическая нижняя граница (A+), кВт',2);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (-6,'Физическая верхня граница (A+), кВт',2);

INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (-7,'Предупредительная нижняя граница (A-), кВт',2);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (-8,'Предупредительная верхня граница (A-), кВт',2);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (-9,'Аварийная нижняя граница (A-), кВт',2);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (-10,'Аварийная верхня граница (A-), кВт',2);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (-11,'Физическая нижняя граница (A-), кВт',2);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (-12,'Физическая верхня граница (A-), кВт',2);

INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (-13,'Предупредительная нижняя граница (R+), кВАр',2);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (-14,'Предупредительная верхня граница (R+), кВАр',2);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (-15,'Аварийная нижняя граница (R+), кВАр',2);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (-16,'Аварийная верхня граница (R+), кВАр',2);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (-17,'Физическая нижняя граница (R+), кВАр',2);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (-18,'Физическая верхня граница (R+), кВАр',2);

INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (-19,'Предупредительная нижняя граница (R-), кВАр',2);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (-20,'Предупредительная верхня граница (R-), кВАр',2);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (-21,'Аварийная нижняя граница (R-), кВАр',2);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (-22,'Аварийная верхня граница (R-), кВАр',2);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (-23,'Физическая нижняя граница (R-), кВАр',2);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (-24,'Физическая верхня граница (R-), кВАр',2);
commit;
end;
/


/*==============================================================*/
/* Table: FEEDERS                                               */
/*==============================================================*/
alter table FEEDERS  add(
   NOPPOSITE            NUMBER
);
comment on column FEEDERS.NOPPOSITE is
'Противоположный учет';

/*==============================================================*/
/* Index: FEEDERS_IDX8                                          */
/*==============================================================*/
create index FEEDERS_IDX8 on FEEDERS (
   NOPPOSITE ASC
);


alter table FEEDERS
   add constraint FEEDERS_F7 foreign key (NOPPOSITE)
      references FEEDERS (MID);



alter table POINTS  add(
   NORDER               NUMBER(10)                     default 0 not null
);

comment on column POINTS.NORDER is
'Сортировка';

------------------------
INSERT INTO RYDA.PROTOCOLS
VALUES
(88,'Облик-2005', null)
/
INSERT INTO RYDA.PROTOCOLS
VALUES
(89,'KM --> Облик-2005', null)
/
commit
/

----------------------------------------------------------------------------------------------
--         VER 2.26.6  (Для обновления версии 2.26.5 до текущей скрипт запускать отсюда)        --
----------------------------------------------------------------------------------------------
---17/09/2008

/*==============================================================*/
/* Table: METERTYPE                                             */
/*==============================================================*/
create table METERTYPE  (
   NMETERTYPE           NUMBER(10)                      not null,
   VEVENTTEXT           VARCHAR2(256),
   constraint PK_METERTYPE primary key (NMETERTYPE)
);

comment on table METERTYPE is
'Типы счетчиков и УСД';

comment on column METERTYPE.NMETERTYPE is
'Тип счетчика или УСД';

comment on column METERTYPE.VEVENTTEXT is
'Наименование';

/*==============================================================*/
/* Index: METERTYPE_IDX1                                        */
/*==============================================================*/
create unique index METERTYPE_IDX1 on METERTYPE (
   VEVENTTEXT ASC
);

insert into METERTYPE(NMETERTYPE,VEVENTTEXT) values(1,'SL-7000');
insert into METERTYPE(NMETERTYPE,VEVENTTEXT) values(2,'УСПД КМ-64');
insert into METERTYPE(NMETERTYPE,VEVENTTEXT) values(3,'LG ZxD');
commit;

alter table METEREVENTSDICT drop constraint PK_METEREVENTSDICT;
rename METEREVENTSDICT to METEREVENTSDICTold;
alter table METEREVENTSDICTold drop constraint CKC_NLOCK_METEREVE
/

begin
execute immediate 'drop index PK_METEREVENTSDICT';
exception when others then null;
end;
/

/*==============================================================*/
/* Table: METEREVENTSDICT                                       */
/*==============================================================*/
create table METEREVENTSDICT  (
   NEVENT               NUMBER(10)                      not null,
   NMETERTYPE           NUMBER(10)                      not null,
   NEVENTCLASS          NUMBER(10)                      not null,
   NEVENTCODE           NUMBER(10)                      not null,
   VEVENTTEXT           VARCHAR2(256),
   NLOCK                NUMBER(1)                      default 0 not null
      constraint CKC_NLOCK_METEREVE check (NLOCK in (0,1)),
   NVALIDITY            NUMBER,
   constraint PK_METEREVENTSDICT primary key (NEVENT)
);

comment on table METEREVENTSDICT is
'Сообщения счетчиков';

comment on column METEREVENTSDICT.NEVENT is
'Ид события';

comment on column METEREVENTSDICT.NMETERTYPE is
'Тип счетчика или УСД';

comment on column METEREVENTSDICT.NEVENTCLASS is
'Класс сообщения';

comment on column METEREVENTSDICT.NEVENTCODE is
'Код сообщения';

comment on column METEREVENTSDICT.VEVENTTEXT is
'Тескст сообщения';

comment on column METEREVENTSDICT.NLOCK is
'Блокировка вывода';

comment on column METEREVENTSDICT.NVALIDITY is
'Достовеерность';

/*==============================================================*/
/* Index: METEREVENTSDICT_IDX1                                  */
/*==============================================================*/
create unique index METEREVENTSDICT_IDX1 on METEREVENTSDICT (
   NMETERTYPE ASC,
   NEVENTCLASS ASC,
   NEVENTCODE ASC
);

alter table METEREVENTSDICT
   add constraint METEREVENTSDICT_F1 foreign key (NMETERTYPE)
      references METERTYPE (NMETERTYPE)
      on delete cascade;

insert into METEREVENTSDICT(NEVENT,NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT,NLOCK)
select rownum,NMETERTYPE,NEVENTCLASS,NEVENTCODE,VEVENTTEXT,NLOCK from METEREVENTSDICTold;

drop table METEREVENTSDICTold;

alter table METERTYPE rename column VEVENTTEXT to VNAME;

/*==============================================================*/
/* Table: METERSTATUSBITDICT                                    */
/*==============================================================*/
create table METERSTATUSBITDICT  (
   NMETERTYPE           NUMBER(10)                      not null,
   NBIT                 NUMBER(10)                      not null,
   VEVENTTEXT           VARCHAR2(256),
   NEVENT0              NUMBER(10),
   NEVENT1              NUMBER(10),
   constraint PK_METERSTATUSBITDICT primary key (NMETERTYPE, NBIT)
);

comment on table METERSTATUSBITDICT is
'Биты статуса счетчика';

comment on column METERSTATUSBITDICT.NMETERTYPE is
'Тип счетчика или УСД';

comment on column METERSTATUSBITDICT.NBIT is
'Номер бита';

comment on column METERSTATUSBITDICT.VEVENTTEXT is
'Наименование';

comment on column METERSTATUSBITDICT.NEVENT0 is
'Событие при изменении в 0';

comment on column METERSTATUSBITDICT.NEVENT1 is
'Событие при изменении в 1';

/*==============================================================*/
/* Index: METERSTATUSBITDICT_IDX1                               */
/*==============================================================*/
create index METERSTATUSBITDICT_IDX1 on METERSTATUSBITDICT (
   NEVENT0 ASC
);

/*==============================================================*/
/* Index: METERSTATUSBITDICT_IDX2                               */
/*==============================================================*/
create index METERSTATUSBITDICT_IDX2 on METERSTATUSBITDICT (
   NEVENT1 ASC   
);

alter table METERSTATUSBITDICT
   add constraint METERSTATUSBITDICT_F1 foreign key (NEVENT0)
      references METEREVENTSDICT (NEVENT);

alter table METERSTATUSBITDICT
   add constraint METERSTATUSBITDICT_F2 foreign key (NEVENT1)
      references METEREVENTSDICT (NEVENT);

alter table METERSTATUSBITDICT
   add constraint METERSTATUSBITDICT_F3 foreign key (NMETERTYPE)
      references METERTYPE (NMETERTYPE)
      on delete cascade;


alter table JOURNAL  add(
   NEVENT               NUMBER(10),
   VCODE                VARCHAR2(128)
);

comment on column JOURNAL.NEVENT is
'Ид события';

comment on column JOURNAL.VCODE is
'Оригинальный код';

create index JOURNAL_IDX3 on JOURNAL (
   NEVENT ASC
);

alter table JOURNAL
   add constraint JOURNAL_F1 foreign key (NEVENT)
      references METEREVENTSDICT (NEVENT);


alter table JOURNALLAST  add(
   NEVENT               NUMBER(10),
   VCODE                VARCHAR2(128)
);

comment on column JOURNALLAST.NEVENT is
'Ид события';

comment on column JOURNALLAST.VCODE is
'Оригинальный код';

create index JOURNALLAST_IDX3 on JOURNALLAST (
   NEVENT ASC
);

alter table JOURNALLAST
   add constraint JOURNALLAST_F1 foreign key (NEVENT)
      references METEREVENTSDICT (NEVENT);



insert into METERTYPE(NMETERTYPE,VNAME) values(4,'Арго');
commit;

begin
update channels set PROTOCOL_ID=decode(PROTOCOL_ID,14,57,15,58,39,59,40,60) where PROTOCOL_ID in (14,15,39,40);
delete from protocols where PROTOCOL_ID in (14,15,39,40);
commit;
end;
/

drop table SLSTATUS;

INSERT INTO METERTYPE("NMETERTYPE","VNAME")VALUES(5,'ЕвроАльфа');
INSERT INTO METERTYPE("NMETERTYPE","VNAME")VALUES(6,'Энергия 9');
INSERT INTO METERTYPE("NMETERTYPE","VNAME")VALUES(7,'Элвин');
INSERT INTO METERTYPE("NMETERTYPE","VNAME")VALUES(8,'СЭТ-4');
INSERT INTO METERTYPE("NMETERTYPE","VNAME")VALUES(9,'LZQM');
INSERT INTO METERTYPE("NMETERTYPE","VNAME")VALUES(10,'CE-304');
INSERT INTO METERTYPE("NMETERTYPE","VNAME")VALUES(11,'CE-6850');
INSERT INTO METERTYPE("NMETERTYPE","VNAME")VALUES(12,'CE-303');
commit;



drop index JOURNAL_IDX2;
/*==============================================================*/
/* Index: JOURNAL_IDX2                                          */
/*==============================================================*/
create index JOURNAL_IDX2 on JOURNAL (
   DATE_TIME ASC,
   MID ASC
);

begin
delete from METERSTATUSBITDICT;
delete from METEREVENTSDICT;
INSERT INTO METEREVENTSDICT("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")VALUES(520,2,0,0,'Неопределенное событие',0,NULL);
INSERT INTO METEREVENTSDICT("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")VALUES(1,1,2,29,'Изменение направления тока фазы 3',0,NULL);
INSERT INTO METEREVENTSDICT("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")VALUES(2,1,2,30,'Повышение температуры',0,NULL);
INSERT INTO METEREVENTSDICT("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")VALUES(3,1,2,31,'Исчезновение напряжения фазы 1',0,NULL);
INSERT INTO METEREVENTSDICT("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")VALUES(4,1,2,32,'Исчезновение напряжения фазы 2',0,NULL);
INSERT INTO METEREVENTSDICT("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")VALUES(5,1,2,33,'Исчезновение напряжения фазы 3',0,NULL);
INSERT INTO METEREVENTSDICT("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")VALUES(6,1,2,34,'Понижение напряжения фазы 1',0,NULL);
INSERT INTO METEREVENTSDICT("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")VALUES(7,1,2,35,'Понижение напряжения фазы 2',0,NULL);
INSERT INTO METEREVENTSDICT("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")VALUES(8,1,2,36,'Понижение напряжения фазы 3',1,NULL);
INSERT INTO METEREVENTSDICT("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")VALUES(9,1,2,37,'Повышение напряжения фазы 1',0,NULL);
INSERT INTO METEREVENTSDICT("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")VALUES(10,1,2,38,'Повышение напряжения фазы 2',0,NULL);
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(11,1,2,39,'Повышение напряжения фазы 3',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(12,1,2,40,'Батарея',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(13,1,2,41,'Превышение нагрузки',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(14,2,1,0,'Норма',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(15,2,1,1,'К каналу подключен счетчик с нулевым или недопустимым сетевым адресом',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(16,2,1,2,'Открытие доступа к счетчику',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(17,2,1,3,'Проверка пароля счетчиком',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(18,2,1,4,'Установка таймаута обмена со счетчиком',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(19,2,1,5,'Запрос времени счетчика',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(20,2,1,6,'Коррекция времени счетчика',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(21,2,1,7,'Чтение параметров счетчика',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(22,2,1,8,'Чтение текущих значений счетчика и параметров сети',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(23,2,1,9,'Чтение ГН счетчика',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(24,2,1,10,'Чтение суточных показаний счетчика',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(25,2,1,11,'Чтение месячных показаний счетчика',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(26,2,1,12,'Очистка ГН счетчика',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(27,2,1,13,'Очистка журнала событий счетчика',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(28,2,1,14,'Окончание опроса счетчика',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(29,2,1,15,'Закрытие доступа к счетчику',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(30,2,1,16,'Перевод счетчика в Program mode',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(31,2,1,17,'Перевод счетчика в Readout mode',1,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(32,2,1,18,'Чтение журнала событий счетчика',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(33,2,1,19,'Закрытие доступа к счетчику (COSEM;DLMS)',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(34,2,1,20,'Чтение параметров сети (EA)',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(35,2,1,255,'Канал не инициализирован',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(36,2,2,0,'Норма',1,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(37,2,2,2,'Таймаут при выполнении запроса к или получении ответа от счетчика',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(38,2,2,3,'Ошибка в контрольной сумме пакета ответа от счетчика',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(39,2,2,4,'Ошибочный запрос к или ответ от счетчика',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(40,2,2,5,'Рассогласование времени между УСД и счетчиком превышает максимально допустимое',1,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(41,2,2,6,'Граница получаса при чтении ГН или граница суток;месяца при чтении суточных;месячных данных счетчика',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(42,2,2,7,'Ответ от счетчика не помещается в буфер приема УСД',1,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(43,2,2,8,'Ошибка инициализации API COSEM',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(44,2,2,9,'Ошибка открытия СОМ порта API COSEM',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(45,2,2,10,'Ошибка создания контекста COSEM',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(46,2,2,11,'Ошибка COSEM открытия доступа к счетчику',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(47,2,2,12,'Ошибка COSEM закрытия доступа к счетчику',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(48,2,2,13,'Ошибка удаления контекста COSEM',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(49,2,2,14,'Ошибка закрытия СОМ порта API COSEM',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(50,2,2,15,'Ошибка деинициализации API COSEM',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(51,2,2,16,'Ошибка COSEM чтения данных счетчика',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(52,1,1,1,'Периодический ОПИ',1,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(53,1,1,2,'Асинхронный ОПИ',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(54,1,1,3,'Периодический ОРП',1,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(55,1,1,4,'Программируемый ОРП',1,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(56,1,1,5,'Асинхронный ОРП',1,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(57,1,1,6,'Индекс DPM',1,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(58,1,1,7,'Восстановлен внутренний индекс',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(59,1,1,8,'Индекс _управляющий ввод',1,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(60,1,1,9,'Суточный график_ЛУ',1,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(61,1,1,10,'Восстановлен внутренний сут. график',1,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(62,1,1,11,'Суточный график_управляющий ввод',1,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(63,1,1,12,'Сезон_SM',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(64,1,1,13,'Восстановлен внутренний сезон',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(65,1,1,14,'Сезон_управляющий ввод',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(66,1,1,15,'Переход на З;Л (ПЗЛ) время с сезоном',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(67,1,1,16,'Внешняя синхр-ия и ПЗЛ с сезоном',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(68,1,1,17,'IР цепь включена',1,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(69,1,1,18,'IР цепь выключена',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(70,1,1,19,'Ассоциация_LN_программирования',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(71,1,1,20,'Потребл. энергии выше лимита_регистр энергии',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(72,1,1,21,'Потребл. энергии ниже лимита_регистр энергии',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(73,1,1,22,'Потребл. энергии выше лимита_график нагрузки',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(74,1,1,23,'Потребл. энергии ниже лимита_график нагрузки',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(75,1,1,24,'Обнаружена нефатальная ошибка',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(76,1,1,25,'Нефатальная ошибка исчезла',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(77,1,1,26,'Обнаружена фатальная ошибка',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(78,1,1,27,'Сохранение параметров',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(79,1,1,28,'Нефатальные ошибки сквитированы',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(80,1,1,29,'Фатальные ошибки сквитированы',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(81,1,1,30,'Внутренняя синхронизация часов',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(82,1,1,31,'Внешняя синхронизация часов',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(83,1,1,32,'Установка часов',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(84,1,1,33,'Внешняя синхр. и переход З;Л время без сезона',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(85,1,1,34,'Переход на З;Л время без сезона',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(86,1,1,35,'Обнаружено исчезновение перем.тока',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(87,1,1,36,'Восстановление перем.тока',1,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(88,1,1,37,'Исчезло напряжение питания',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(89,1,1,38,'Появилось напряжение питания',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(90,1,1,39,'ПРОГРАММНЫЙ_СМ',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(91,1,1,40,'ПРОГРАММНЫЙ_DI',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(92,1,1,41,'Отмена _ ПРОГРАММНЫЙ_DI',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(93,1,1,42,'Сброс данных измерений',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(94,1,1,43,'Начало измерений',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(95,1,1,44,'Остановка измерений',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(96,1,1,45,'Начало тестов',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(97,1,1,46,'Остановка тестов',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(98,1,1,47,'Окончание сохранения текущих данных',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(99,1,1,48,'Сброс графика нагрузки',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(100,1,1,49,'Восстановление пароля',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(101,1,1,50,'Индекс остановки часов',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(102,1,1,51,'Успешная коммуникация',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(103,1,2,1,'Внутренняя ошибка RAM',1,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(104,1,2,2,'Внешняя ошибка RAM',1,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(105,1,2,3,'Внутр. ошибка программ. памяти',1,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(106,1,2,4,'Внешн. ошибка программ. памяти',1,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(107,1,2,5,'Фатальная ошибка NOVRAM',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(108,1,2,6,'Многократная несинхронизация часов',1,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(109,1,2,7,'Работа функции "Wathdog"',1,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(110,1,2,8,'Рассоглас. часов с внешн. источником',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(111,1,2,9,'Несоответствие конфигурации',1,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(112,1,2,10,'Нефатальная ошибка NOVRAM',1,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(113,1,2,11,'Ошибка связи',1,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(114,1,2,12,'Программная несовместимость',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(115,1,2,13,'Открытие крышки счетчика',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(116,1,2,14,'Небаланс токов в фазах 1и 2',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(117,1,2,15,'Небаланс токов в фазах 2и 3',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(118,1,2,16,'Небаланс токов в фазах 1и 3',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(119,1,2,17,'Контроль напряжения фазы 1',1,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(120,1,2,18,'Контроль напряжения фазы 2',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(121,1,2,19,'Контроль напряжения фазы 3',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(122,1,2,20,'Обрыв нейтрали',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(123,1,2,21,'Нет внутр. метрологических имп-ов',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(124,1,2,22,'Нет импульсов от внешних приборов',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(125,1,2,23,'Последовательность нулей напряжения',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(126,1,2,24,'Последовательность нулей тока',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(127,1,2,25,'Остановка (неверный ход) часов',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(128,1,2,26,'"Тревога" от внешн. устройства',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(129,1,2,27,'Изменение направления тока фазы 1',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(130,1,2,28,'Изменение направления тока фазы 2',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(131,2,2,17,'Ошибка чтения файла',1,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(132,2,2,18,'Ошибка COSEM установки времени счетчика',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(133,2,2,19,'Отсутствие данных авточтения счетчика',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(134,2,2,20,'Программное исключение при опросе счетчика',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(135,2,2,21,'Ошибка в параметрах ГН счетчика',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(136,2,2,22,'Недопустимый сетевой адрес счетчика',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(137,2,2,23,'Недопустимый номер блока биллинговых данных',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(138,2,2,24,'Отсутствует файл системы безопасности',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(139,2,2,25,'Ошибка создания файла системы безопасности',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(140,2,2,26,'Неверная длина класса памяти Альфы',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(141,2,2,129,'Нет необходимости в получении данных',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(142,2,2,130,'Контекст устройства не подерживантся',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(143,2,2,139,'Тип идентификации не поддерживается',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(144,2,2,140,'Название типа идентификации обязательно',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(145,2,2,141,'Неверное имя;пароль доступа к счетчику',1,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(146,2,2,142,'Пароль доступа к счетчику не может быть пустым',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(147,2,2,201,'Нет связи со счетчиком',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(148,2,2,209,'Неверный пароль доступа',1,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(149,3,1,0,'Событие счетчика: 0',1,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(150,3,1,1,'1: Параметризация или изменение конфигурации',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(151,3,1,75,'75: Ошибка "Доступ к памяти системы измерений"',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(152,3,1,76,'76: Ошибка "Базы времени"',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(153,3,1,77,'77: Ошибка "Доступ к памяти профиля данных"',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(154,3,1,78,'78: Ошибка "Приемник сигналов управления"',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(155,3,1,79,'79: Ошибка "Коммуникационный модуль"',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(156,3,1,80,'80: Ошибка "Дисплей и панель управления"',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(157,3,1,81,'81: Ошибка "Контрольная сумма кода программы"',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(158,3,1,82,'82: Ошибка "Контрольная сумма данных резервного копирования"',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(159,3,1,83,'83: Ошибка "Контрольная сумма данных параметризации"',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(160,3,1,84,'84: Ошибка "Контрольная сумма данных профиля данных "',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(161,3,1,85,'85: Ошибка "Контрольная сумма данных списка событий"',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(162,3,1,86,'Событие счетчика: 86',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(163,3,1,87,'Событие счетчика: 87',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(164,3,1,88,'Событие счетчика: 88',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(165,3,1,89,'Событие счетчика: 89',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(166,3,1,90,'90: Ошибка "Измерительная система"',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(167,3,1,91,'91: Ошибка "Перепрограммирование"',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(168,3,1,92,'92: Ошибка "Режим установки"',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(169,3,1,93,'93: Ошибка "Система"',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(170,3,1,94,'94: Ошибка "Связь заблокирована"',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(171,3,1,95,'95: Ошибка "Некорр. идентификация EEPROM"',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(172,3,1,96,'96: Ошибка "Некорр. функционирование длительная идентификация"',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(173,3,1,97,'Событие счетчика: 97',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(174,3,1,98,'Событие счетчика: 98',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(175,3,1,99,'Событие счетчика: 99',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(176,3,1,100,'Событие счетчика: 100',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(177,3,1,101,'Событие счетчика: 101',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(178,3,1,102,'Событие счетчика: 102',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(179,3,1,103,'Событие счетчика: 103',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(180,3,1,104,'Событие счетчика: 104',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(181,3,1,105,'Событие счетчика: 105',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(182,3,1,106,'Событие счетчика: 106',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(183,3,1,107,'Событие счетчика: 107',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(184,3,1,108,'Событие счетчика: 108',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(185,3,1,109,'Событие счетчика: 109',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(186,3,1,110,'Событие счетчика: 110',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(187,3,1,111,'Событие счетчика: 111',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(188,3,1,112,'Событие счетчика: 112',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(189,3,1,113,'Событие счетчика: 113',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(190,3,1,114,'Событие счетчика: 114',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(191,3,1,115,'Событие счетчика: 115',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(192,3,1,2,'2: Обнуление тарифных регистров',1,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(193,3,1,3,'3: Обнуление памяти профиля данных',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(194,3,1,4,'4: Выполнен сброс',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(195,3,1,5,'5: Батарея разряжена',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(196,3,1,6,'6: Батарея заменена',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(197,3,1,7,'7: Напряжение батареи в норме ',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(198,3,1,8,'Событие счетчика: 8',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(199,3,1,9,'9: Переход лето;зима',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(200,3,1,10,'10: Изменение времени;даты (старое значение)',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(201,3,1,11,'11: Изменение времени;даты (новое значение)',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(202,3,1,12,'Событие счетчика: 12',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(203,3,1,13,'13: Изменение статуса управляющих входов',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(204,3,1,14,'Событие счетчика: 14',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(205,3,1,15,'Событие счетчика: 15',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(206,3,1,16,'Событие счетчика: 16',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(207,3,1,17,'17: Снижение напряжение ниже допустимого по фазе L1',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(208,3,1,18,'18: Снижение напряжение ниже допустимого по фазе L2',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(209,3,1,19,'19: Снижение напряжение ниже допустимого по фазе L3',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(210,3,1,20,'20: Перенапряжение по фазе L1',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(211,3,1,21,'21: Перенапряжение по фазе L2',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(212,3,1,22,'22: Перенапряжение по фазе L3',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(213,3,1,23,'23: Провал напряжения',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(214,3,1,24,'24: Восстановление напряжения',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(215,3,1,25,'25: Перегрузка по току фаза L1',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(216,3,1,26,'26: Перегрузка по току фаза L2',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(217,3,1,27,'27: Перегрузка по току фаза L3',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(218,3,1,28,'28: Перегрузка по току в нейтрали',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(219,3,1,29,'29: Сигналы событий коэффициента мощности ',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(220,3,1,30,'30: Сигналы событий коэффициента мощности ',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(221,3,1,31,'31: Сигналы событий коэффициента мощности ',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(222,3,1,32,'32: Сигналы событий коэффициента мощности ',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(223,3,1,33,'33: Сигналы событий значения усредненной мощности Pтекущее',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(224,3,1,34,'34: Сигналы событий значения усредненной мощности Pтекущее',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(225,3,1,35,'35: Сигналы событий значения усредненной мощности Pтекущее',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(226,3,1,36,'36: Сигналы событий значения усредненной мощности Pтекущее',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(227,3,1,37,'37: Сигналы событий значения усредненной мощности Pтекущее',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(228,3,1,38,'38: Сигналы событий значения усредненной мощности Pтекущее',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(229,3,1,39,'39: Сигналы событий значения усредненной мощности Pтекущее',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(230,3,1,40,'40: Сигналы событий значения усредненной мощности Pтекущее',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(231,3,1,41,'Событие счетчика: 41',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(232,3,1,42,'Событие счетчика: 42',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(233,3,1,43,'Событие счетчика: 43',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(234,3,1,44,'Событие счетчика: 44',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(235,3,1,45,'45: Ошибка самотестирования (4)',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(236,3,1,46,'46: Ошибка самотестирования (4)',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(237,3,1,47,'47: Ошибка самотестирования (4)',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(238,3,1,48,'48: Ошибка самотестирования (4)',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(239,3,1,49,'Событие счетчика: 49',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(240,3,1,50,'Событие счетчика: 50',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(241,3,1,51,'Событие счетчика: 51',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(242,3,1,52,'Событие счетчика: 52',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(243,3,1,53,'Событие счетчика: 53',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(244,3,1,54,'Событие счетчика: 54',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(245,3,1,55,'Событие счетчика: 55',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(246,3,1,56,'Событие счетчика: 56',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(247,3,1,57,'Событие счетчика: 57',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(248,3,1,58,'Событие счетчика: 58',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(249,3,1,59,'Событие счетчика: 59',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(250,3,1,60,'Событие счетчика: 60',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(251,3,1,61,'Событие счетчика: 61',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(252,3,1,62,'Событие счетчика: 62',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(253,3,1,63,'Событие счетчика: 63',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(254,3,1,64,'Событие счетчика: 64',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(255,3,1,65,'65: Ошибка "Батарея разряжена "',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(256,3,1,66,'66: Ошибка "Некорректное время;дата"',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(257,3,1,67,'Событие счетчика: 67',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(258,3,1,68,'Событие счетчика: 68',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(259,3,1,69,'Событие счетчика: 69',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(260,3,1,70,'Событие счетчика: 70',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(261,3,1,71,'Событие счетчика: 71',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(262,3,1,72,'Событие счетчика: 72',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(263,3,1,73,'73: Ошибка "Доступ к основной памяти"',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(264,3,1,74,'74: Ошибка "Доступ к памяти параметров"',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(265,3,1,116,'Событие счетчика: 116',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(266,3,1,117,'Событие счетчика: 117',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(267,3,1,118,'Событие счетчика: 118',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(268,3,1,119,'Событие счетчика: 119',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(269,3,1,120,'Событие счетчика: 120',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(270,3,1,121,'Событие счетчика: 121',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(271,3,1,122,'Событие счетчика: 122',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(272,3,1,123,'Событие счетчика: 123',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(273,3,1,124,'Событие счетчика: 124',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(274,3,1,125,'Событие счетчика: 125',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(275,3,1,126,'Событие счетчика: 126',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(276,3,1,127,'Событие счетчика: 127',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(277,3,1,128,'Событие счетчика: 128',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(278,3,1,129,'Событие счетчика: 129',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(279,3,1,130,'Событие счетчика: 130',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(280,3,1,131,'Событие счетчика: 131',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(281,3,1,132,'Событие счетчика: 132',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(282,3,1,133,'Событие счетчика: 133',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(283,3,1,134,'Событие счетчика: 134',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(284,3,1,135,'Событие счетчика: 135',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(285,3,1,136,'Событие счетчика: 136',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(286,3,1,137,'Событие счетчика: 137',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(287,3,1,138,'Событие счетчика: 138',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(288,3,1,139,'Событие счетчика: 139',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(289,3,1,140,'Событие счетчика: 140',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(290,3,1,141,'Событие счетчика: 141',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(291,3,1,142,'Событие счетчика: 142',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(292,3,1,143,'Событие счетчика: 143',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(293,3,1,144,'Событие счетчика: 144',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(294,3,1,145,'Событие счетчика: 145',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(295,3,1,146,'Событие счетчика: 146',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(296,3,1,147,'Событие счетчика: 147',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(297,3,1,148,'Событие счетчика: 148',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(298,3,1,149,'Событие счетчика: 149',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(299,3,1,150,'Событие счетчика: 150',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(300,3,1,151,'Событие счетчика: 151',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(301,3,1,152,'Событие счетчика: 152',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(302,3,1,153,'Событие счетчика: 153',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(303,3,1,154,'Событие счетчика: 154',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(304,3,1,155,'Событие счетчика: 155',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(305,3,1,156,'Событие счетчика: 156',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(306,3,1,157,'Событие счетчика: 157',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(307,3,1,158,'Событие счетчика: 158',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(308,3,1,159,'Событие счетчика: 159',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(309,3,1,160,'Событие счетчика: 160',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(310,3,1,161,'Событие счетчика: 161',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(311,3,1,162,'Событие счетчика: 162',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(312,3,1,163,'Событие счетчика: 163',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(313,3,1,164,'Событие счетчика: 164',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(314,3,1,165,'Событие счетчика: 165',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(315,3,1,166,'Событие счетчика: 166',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(316,3,1,167,'Событие счетчика: 167',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(317,3,1,168,'Событие счетчика: 168',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(318,3,1,169,'Событие счетчика: 169',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(319,3,1,170,'Событие счетчика: 170',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(320,3,1,171,'Событие счетчика: 171',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(321,3,1,172,'Событие счетчика: 172',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(322,3,1,173,'Событие счетчика: 173',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(323,3,1,174,'Событие счетчика: 174',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(324,3,1,175,'Событие счетчика: 175',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(325,3,1,176,'Событие счетчика: 176',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(326,3,1,177,'Событие счетчика: 177',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(327,3,1,178,'Событие счетчика: 178',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(328,3,1,179,'Событие счетчика: 179',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(329,3,1,180,'Событие счетчика: 180',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(330,3,1,181,'Событие счетчика: 181',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(331,3,1,182,'Событие счетчика: 182',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(332,3,1,183,'Событие счетчика: 183',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(333,3,1,184,'Событие счетчика: 184',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(334,3,1,185,'Событие счетчика: 185',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(335,3,1,186,'Событие счетчика: 186',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(336,3,1,187,'Событие счетчика: 187',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(337,3,1,188,'Событие счетчика: 188',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(338,3,1,189,'Событие счетчика: 189',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(339,3,1,190,'Событие счетчика: 190',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(340,3,1,191,'Событие счетчика: 191',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(341,3,1,192,'Событие счетчика: 192',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(342,3,1,193,'Событие счетчика: 193',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(343,3,1,194,'Событие счетчика: 194',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(344,3,1,195,'Событие счетчика: 195',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(345,3,1,196,'Событие счетчика: 196',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(346,3,1,197,'Событие счетчика: 197',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(347,3,1,198,'Событие счетчика: 198',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(348,3,1,199,'Событие счетчика: 199',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(349,3,1,200,'Событие счетчика: 200',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(350,3,1,201,'Событие счетчика: 201',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(351,3,1,202,'Событие счетчика: 202',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(352,3,1,203,'Событие счетчика: 203',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(353,3,1,204,'Событие счетчика: 204',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(354,3,1,205,'Событие счетчика: 205',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(355,3,1,206,'Событие счетчика: 206',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(356,3,1,207,'Событие счетчика: 207',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(357,3,1,208,'Событие счетчика: 208',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(358,3,1,209,'Событие счетчика: 209',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(359,3,1,210,'Событие счетчика: 210',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(360,3,1,211,'Событие счетчика: 211',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(361,3,1,212,'Событие счетчика: 212',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(362,3,1,213,'Событие счетчика: 213',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(363,3,1,214,'Событие счетчика: 214',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(364,3,1,215,'Событие счетчика: 215',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(365,3,1,216,'Событие счетчика: 216',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(366,3,1,217,'Событие счетчика: 217',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(367,3,1,218,'Событие счетчика: 218',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(368,3,1,219,'Событие счетчика: 219',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(369,3,1,220,'Событие счетчика: 220',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(370,3,1,221,'Событие счетчика: 221',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(371,3,1,222,'Событие счетчика: 222',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(372,3,1,223,'Событие счетчика: 223',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(373,3,1,224,'Событие счетчика: 224',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(374,3,1,225,'Событие счетчика: 225',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(375,3,1,226,'Событие счетчика: 226',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(376,3,1,227,'Событие счетчика: 227',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(377,3,1,228,'Событие счетчика: 228',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(378,3,1,229,'Событие счетчика: 229',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(379,3,1,230,'Событие счетчика: 230',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(380,3,1,231,'Событие счетчика: 231',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(381,3,1,232,'Событие счетчика: 232',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(382,3,1,233,'Событие счетчика: 233',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(383,3,1,234,'Событие счетчика: 234',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(384,3,1,235,'Событие счетчика: 235',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(385,3,1,236,'Событие счетчика: 236',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(386,3,1,237,'Событие счетчика: 237',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(387,3,1,238,'Событие счетчика: 238',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(388,3,1,239,'Событие счетчика: 239',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(389,3,1,240,'Событие счетчика: 240',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(390,3,1,241,'Событие счетчика: 241',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(391,3,1,242,'Событие счетчика: 242',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(392,3,1,243,'Событие счетчика: 243',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(393,3,1,244,'Событие счетчика: 244',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(394,3,1,245,'Событие счетчика: 245',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(395,3,1,246,'Событие счетчика: 246',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(396,3,1,247,'Событие счетчика: 247',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(397,3,1,248,'Событие счетчика: 248',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(398,3,1,249,'Событие счетчика: 249',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(399,3,1,250,'Событие счетчика: 250',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(400,3,1,251,'Событие счетчика: 251',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(401,3,1,252,'Событие счетчика: 252',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(402,3,1,253,'Событие счетчика: 253',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(403,3,1,254,'Событие счетчика: 254',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(404,3,1,255,'Событие счетчика: 255',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(405,4,1,0,'Включение напряжения',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(406,4,1,1,'Отключение напряжения',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(407,4,1,2,'Есть фаза: A',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(408,4,1,258,'Есть фаза: B',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(409,4,1,514,'Есть фаза: C',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(410,4,1,3,'Нет фазы: A',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(411,4,1,259,'Нет фазы: B',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(412,4,1,515,'Нет фазы: C',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(413,4,1,4,'Переход системного времени через 0 часов',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(414,4,1,263,'Смена параметров: Коррекция времени',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(415,4,1,519,'Смена параметров: Настройки устройства (сетевой адрес и период графика нагрузки)',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(416,4,1,775,'Смена параметров: Пароль пользователя (уровень 1)',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(417,4,1,1031,'Смена параметров: Пароль энергокомпании (уровень 2)',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(418,4,1,1287,'Смена параметров: Настройки лога данных',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(419,4,1,1543,'Смена параметров: Настройки меню',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(420,4,1,1799,'Смена параметров: Карта сезонов',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(421,4,1,2055,'Смена параметров: Карта тарифных зон ',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(422,5,1,273,'Отключение напряжения.',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(423,5,1,274,'Включение напряжения.',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(424,5,1,275,'Коррекция часов. Время до коррекции.',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(425,5,1,276,'Коррекция часов. Время после коррекции.',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(426,5,1,277,'Начало режима тестирования счетчика.',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(427,5,1,278,'Окончание режима тестирования счетчика.',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(428,5,1,279,'Сброс максимальной мощности.',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(429,5,1,280,'Сброс журнала событий.',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(430,6,1,281,'Есть фаза А.',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(431,6,1,282,'Нет фазы А.',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(432,6,1,283,'Есть фаза B.',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(433,6,1,284,'Нет фазы B.',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(434,6,1,285,'Есть фаза C.',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(435,6,1,286,'Нет фазы C.',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(436,7,1,287,'Отключение счетчика.',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(437,7,1,288,'Включение счетчика. Нет напряжения на фазах.',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(438,7,1,289,'Включение фазы C.',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(439,7,1,290,'Включение фазы B.',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(440,7,1,291,'Включение фазы A.',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(441,8,1,292,'Отключение счетчика.',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(442,8,1,293,'Включение счетчика.',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(443,8,1,294,'Коррекция часов. Время до коррекции.',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(444,8,1,295,'Коррекция часов. Время после коррекции.',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(445,8,1,296,'Коррекция расписания праздничных дней.',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(446,8,1,297,'Коррекция тарифного расписания.',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(447,8,1,298,'Сброс показаний энергии.',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(448,8,1,299,'Инициализация массива профиля мощности.',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(449,8,1,300,'Выключение фазы 1 счетчика.',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(450,8,1,301,'Включение фазы 1 счетчика.',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(451,8,1,302,'Выключение фазы 2 счетчика.',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(452,8,1,303,'Включение фазы 2 счетчика.',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(453,8,1,304,'Выключение фазы 3 счетчика.',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(454,8,1,305,'Включение фазы 3 счетчика.',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(455,8,1,306,'Открытие защитной крышки.',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(456,8,1,307,'Закрытие защитной крышки.',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(457,9,1,308,'Отключение счетчика.',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(458,9,1,309,'Включение счетчика.',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(459,9,1,310,'Изменение состояния фаз:',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(460,10,1,311,'Проблем счетчика не обнаружено',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(461,10,1,312,'Сбой часов реального времени (невозможна тарификация)',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(462,10,1,313,'Проблемы группы системного времени (может быть неучтена энергия последнего измерения)',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(463,10,1,314,'Проблемы группы технологической (нет учета энергии)',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(464,10,1,315,'Проблемы группы параметров измерителя (нет учета энергии)',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(465,10,1,316,'Проблемы группы интерфейсного обмена (недостоверны параметры обмена)',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(466,10,1,317,'Проблемы группы тарификации (нет учета по тарифам)',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(467,10,1,318,'Проблемы накопленных основных данных (недостоверна группа накопления энергий активного тарифа)',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(468,10,1,319,'Проблемы накопленных дополнительных данных (недостоверны максимумы средней мощности и активные записи профилей)',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(469,10,1,320,'Проблемы группы журналов (недостоверна информация в журналах)',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(470,10,1,321,'Неожиданный аппаратный сброс',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(471,10,1,322,'Проблемы накопителя данных профиля.',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(472,10,1,323,'Все параметры счетчика в норме',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(473,10,1,324,'Фаза А выключена (напряжение фазы меньше 5% номинального)',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(474,10,1,325,'Фаза B выключена (напряжение фазы меньше 5% номинального)',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(475,10,1,326,'Фаза C выключена (напряжение фазы меньше 5% номинального)',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(476,10,1,327,'Напряжение фазы А меньше заданного параметром LEVDN',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(477,10,1,328,'Напряжение фазы B меньше заданного параметром LEVDN',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(478,10,1,329,'Напряжение фазы C меньше заданного параметром LEVDN',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(479,10,1,330,'Напряжение фазы А больше заданного параметром LEVUP',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(480,10,1,331,'Напряжение фазы B больше заданного параметром LEVUP',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(481,10,1,332,'Напряжение фазы C больше заданного параметром LEVUP',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(482,10,1,333,'Частота сети вне диапазона от 47,5 до 52,5 Гц',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(483,10,1,334,'Очистка накопленных данных каналов вычислителя',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(484,10,1,335,'Неожиданный аппаратный сброс',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(485,10,1,336,'Выключение счетчика',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(486,10,1,337,'Включение счетчика',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(487,11,1,338,'Фазы счетчика в норме',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(488,11,1,339,'Превышение напряжения фазы А',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(489,11,1,340,'Превышение напряжения фазы B',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(490,11,1,341,'Превышение напряжения фазы C',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(491,11,1,342,'Понижение напряжения фазы А',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(492,11,1,343,'Понижение напряжения фазы B',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(493,11,1,344,'Понижение напряжения фазы C',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(494,11,1,345,'Нет напряжения фазы А',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(495,11,1,346,'Нет напряжения фазы B',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(496,11,1,347,'Нет напряжения фазы C',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(497,11,1,348,'Выключение счетчика',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(498,11,1,349,'Состояние счетчика в норме',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(499,11,1,350,'Ошибка контрольной суммы калибровочных коэффициентов',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(500,11,1,351,'Ошибка накопления энергии (суммарная)',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(501,11,1,352,'Ошибка EEPROM',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(502,11,1,353,'Состояние (резерв)',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(503,11,1,354,'Ошибка массива <Исключительные дни>',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(504,11,1,355,'Ошибка массива <Сезонные графики>',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(505,11,1,356,'Ошибка массива <Тарифные графики>',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(506,11,1,357,'Ошибка массива <Графики дней>',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(507,11,1,358,'Авария питания',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(508,11,1,359,'Разряд батарейки',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(509,11,1,360,'Ошибка чтения часов',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(510,11,1,361,'Последнее воскресенье месяца',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(511,11,1,362,'Летнее время',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(512,11,1,363,'Была корректировка часов',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(513,11,1,364,'Ошибка записи энергий нарастающим итогом',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(514,12,1,365,'Фаза А-(1)',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(515,12,1,366,'Фаза А-(0)',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(516,12,1,367,'Фаза B-(1)',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(517,12,1,368,'Фаза B-(0)',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(518,12,1,369,'Фаза C-(1)',0,NULL)
;
INSERT INTO METEREVENTSDICT
("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")
VALUES
(519,12,1,370,'Фаза C-(0)',0,NULL)
;
INSERT INTO METERSTATUSBITDICT
("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1")
VALUES
(3,0,'Регистрация фатальной ошибки',NULL,NULL)
;
INSERT INTO METERSTATUSBITDICT
("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1")
VALUES
(3,1,'Резерв питания календарных часов исчерпан (некорр. время)',NULL,NULL)
;
INSERT INTO METERSTATUSBITDICT
("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1")
VALUES
(3,2,'Неполное измерение, интеграционный период слишком мал',NULL,NULL)
;
INSERT INTO METERSTATUSBITDICT
("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1")
VALUES
(3,3,'Лето или зима (1 = лето, 0 = зима)',149,155)
;
INSERT INTO METERSTATUSBITDICT
("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1")
VALUES
(3,4,'Выполнен сброс',162,150)
;
INSERT INTO METERSTATUSBITDICT
("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1")
VALUES
(3,5,'Изменено время;дата',NULL,NULL)
;
INSERT INTO METERSTATUSBITDICT
("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1")
VALUES
(3,6,'Восстановление напряжения',NULL,NULL)
;
INSERT INTO METERSTATUSBITDICT
("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1")
VALUES
(3,7,'Провал напряжения (по 3 фазам)',NULL,NULL)
;
INSERT INTO METERSTATUSBITDICT
("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1")
VALUES
(3,8,'не используется',NULL,NULL)
;
INSERT INTO METERSTATUSBITDICT
("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1")
VALUES
(3,9,'не используется',NULL,NULL)
;
INSERT INTO METERSTATUSBITDICT
("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1")
VALUES
(3,10,'не используется',NULL,NULL)
;
INSERT INTO METERSTATUSBITDICT
("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1")
VALUES
(3,11,'не используется',NULL,NULL)
;
INSERT INTO METERSTATUSBITDICT
("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1")
VALUES
(3,12,'не используется',NULL,NULL)
;
INSERT INTO METERSTATUSBITDICT
("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1")
VALUES
(3,13,'Список событий полностью удален',NULL,NULL)
;
INSERT INTO METERSTATUSBITDICT
("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1")
VALUES
(3,14,'Память профиля данных полностью обнулена',NULL,NULL)
;
INSERT INTO METERSTATUSBITDICT
("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1")
VALUES
(3,15,'Запись статусного сообщения перед последним изменением времени',NULL,NULL)
;
INSERT INTO METERSTATUSBITDICT
("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1")
VALUES
(3,16,'зарезервировано',NULL,NULL)
;
INSERT INTO METERSTATUSBITDICT
("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1")
VALUES
(3,17,'зарезервировано',NULL,NULL)
;
INSERT INTO METERSTATUSBITDICT
("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1")
VALUES
(3,18,'зарезервировано',NULL,NULL)
;
INSERT INTO METERSTATUSBITDICT
("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1")
VALUES
(3,19,'Старт интеграционного периода (SOI - начало интервала)',NULL,NULL)
;
INSERT INTO METERSTATUSBITDICT
("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1")
VALUES
(3,20,'Конец интеграционного периода при изменении тарифа (EOI - окончание интервала)',NULL,NULL)
;
INSERT INTO METERSTATUSBITDICT
("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1")
VALUES
(3,21,'Преждевременное окончание интеграционного периода (например, при изменении времени)',NULL,NULL)
;
INSERT INTO METERSTATUSBITDICT
("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1")
VALUES
(3,22,'Интеграционный период окончен по внешнему управляющему сигналу',NULL,NULL)
;
INSERT INTO METERSTATUSBITDICT
("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1")
VALUES
(3,23,'Интеграционный период окончен по внутреннему управляющему сигналу',NULL,NULL)
;
INSERT INTO METERSTATUSBITDICT
("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1")
VALUES
(1,5,'Watch dog reset',NULL,NULL)
;
INSERT INTO METERSTATUSBITDICT
("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1")
VALUES
(1,4,'DST',NULL,NULL)
;
INSERT INTO METERSTATUSBITDICT
("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1")
VALUES
(1,3,'External Clock Synchro',NULL,NULL)
;
INSERT INTO METERSTATUSBITDICT
("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1")
VALUES
(1,2,'Clock Setting',NULL,NULL)
;
INSERT INTO METERSTATUSBITDICT
("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1")
VALUES
(1,1,'Power failure',NULL,NULL)
;
INSERT INTO METERSTATUSBITDICT
("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1")
VALUES
(1,0,'Start of measurement ',NULL,NULL)
;
commit
;
end;
/


/*==============================================================*/
/* Table: FILTERS                                               */
/*==============================================================*/
create table FILTERS  (
   NID                  NUMBER(10)                      not null,
   NPARENT              NUMBER(10),
   VNAME                VARCHAR2(128),
   NEVENT               NUMBER(10),
   constraint PK_FILTERS primary key (NID)
);

comment on table FILTERS is
'Фильтр';

comment on column FILTERS.NID is
'Ид папки';

comment on column FILTERS.NPARENT is
'Родитель';

comment on column FILTERS.VNAME is
'Наименование';

comment on column FILTERS.NEVENT is
'Событие';

/*==============================================================*/
/* Index: FILTERS_IDX1                                          */
/*==============================================================*/
create unique index FILTERS_IDX1 on FILTERS (
   NPARENT ASC,
   VNAME ASC
);

/*==============================================================*/
/* Index: FILTERS_IDX2                                          */
/*==============================================================*/
create index FILTERS_IDX2 on FILTERS (
   NEVENT ASC
);

alter table FILTERS
   add constraint FILTERS_F2 foreign key (NEVENT)
      references METEREVENTSDICT (NEVENT)
      on delete cascade;

alter table FILTERS
   add constraint FILTERS_F1 foreign key (NPARENT)
      references FILTERS (NID)
      on delete cascade;


/*==============================================================*/
/* Table: TIMEZONES                                             */
/*==============================================================*/
create table TIMEZONES  (
   NID                  NUMBER(10)                      not null,
   VNAME                VARCHAR2(128)                   not null,
   NSHIFT               NUMBER                          not null,
   DSUMMER              DATE,
   constraint PK_TIMEZONES primary key (NID)
);

comment on table TIMEZONES is
'Часовые пояса';

comment on column TIMEZONES.NID is
'Ид часового пояса';

comment on column TIMEZONES.VNAME is
'Наименование';

comment on column TIMEZONES.NSHIFT is
'Сдвиг относ Украины';

comment on column TIMEZONES.DSUMMER is
'Переход на лето';

begin
insert into TIMEZONES  (NID,VNAME,NSHIFT,DSUMMER) values(1,'(GMT+02:00) Украина',0,to_date('29.03.2008 03:00','dd.mm.yyyy hh24:mi'));
insert into TIMEZONES  (NID,VNAME,NSHIFT,DSUMMER) values(2,'(GMT+01:00) Среднеевропейское время',-1,to_date('29.03.2008 02:00','dd.mm.yyyy hh24:mi'));
insert into TIMEZONES  (NID,VNAME,NSHIFT,DSUMMER) values(3,'(GMT+03:00) Россия',1,to_date('29.03.2008 02:00','dd.mm.yyyy hh24:mi'));
commit;
end;
/


begin
INSERT INTO points(MID,PARENT,COD,IND,NAME,SHORT_NAME,PTYPE,IMPLEMENT_DATE,TAG,NPOINT) VALUES(5,NULL,NULL,1,'Подсистема единого времени','',NULL,'',NULL,NULL);
commit;
end;
/


begin
INSERT INTO tasks
(TASK_ID,PARENT,TASK_COD,NAME,REMARK,NSHOW)
VALUES
(99,80,657,'9.05 Настройка фильтров сообщений','9.05 Настройка фильтров сообщений',0);
insert into role_task
select distinct ROLE_ID,99,1 from users;
commit;
exception
 when others then null;
end;
/

------03/10/2008
begin
update METEREVENTSDICT set VEVENTTEXT=VEVENTTEXT||'_'||nevent 
where (nmetertype,VEVENTTEXT) in
(select nmetertype,VEVENTTEXT from METEREVENTSDICT
group by nmetertype,VEVENTTEXT
having count(*)>1);
commit;
end;
/
/*==============================================================*/
/* Index: METEREVENTSDICT_IDX2                                  */
/*==============================================================*/
create unique index METEREVENTSDICT_IDX2 on METEREVENTSDICT (
   NMETERTYPE ASC,
   VEVENTTEXT ASC
);


alter table ADDPOINTPARAM drop constraint CKC_NTYPE_ADDPOINT;

alter table ADDPOINTPARAM add constraint CKC_NTYPE_ADDPOINT check (NTYPE in (0,1,2,3,4,5,6,7));

alter table LAST_SAVE  add(
   JOURNAL              DATE
);

comment on column LAST_SAVE.JOURNAL is
'Журнал событий';

update last_save set JOURNAL=sysdate-370 where JOURNAL is null;

commit;


ALTER TABLE ADDPOINTPARAMVAL MODIFY (VVALUE NULL);

alter table ADDPOINTPARAMVAL  add(   BVALUE               BLOB);

comment on column ADDPOINTPARAMVAL.BVALUE is
'Значение BLOB';


/*==============================================================*/
/* Table: ADDFORMPARAM                                          */
/*==============================================================*/
create table ADDFORMPARAM  (
   NSORT                NUMBER(10)                      not null,
   VDESCR               VARCHAR2(128)                   not null,
   NTYPE                NUMBER(10)                     default 0 not null
      constraint CKC_NTYPE_ADDFORMP check (NTYPE in (0,1,2,3,4,5,6,7)),
   constraint PK_ADDFORMPARAM primary key (NSORT)
);

comment on table ADDFORMPARAM is
'Доп параметры формы';

comment on column ADDFORMPARAM.NSORT is
'Номер аттрибута';

comment on column ADDFORMPARAM.VDESCR is
'Описание';

comment on column ADDFORMPARAM.NTYPE is
'Тип аттрибута';

/*==============================================================*/
/* Index: ADDPOINTPARAM_IDX2                                    */
/*==============================================================*/
create unique index ADDPOINTPARAM_IDX2 on ADDFORMPARAM (
   VDESCR ASC
);


/*==============================================================*/
/* Table: ADDFORMPARAMVAL                                       */
/*==============================================================*/
create table ADDFORMPARAMVAL  (
   MID                  NUMBER                          not null,
   NSORT                NUMBER(10)                      not null,
   VVALUE               VARCHAR2(2000),
   BVALUE               BLOB,
   constraint PK_ADDFORMPARAMVAL primary key (MID, NSORT)
);

comment on table ADDFORMPARAMVAL is
'Значения доп пар формы';

comment on column ADDFORMPARAMVAL.MID is
'Ид формы';

comment on column ADDFORMPARAMVAL.NSORT is
'Номер аттрибута';

comment on column ADDFORMPARAMVAL.VVALUE is
'Значение';

comment on column ADDFORMPARAMVAL.BVALUE is
'Значение BLOB';

/*==============================================================*/
/* Index: ADDFORMPARAMVAL_IDX2                                  */
/*==============================================================*/
create index ADDFORMPARAMVAL_IDX2 on ADDFORMPARAMVAL (
   NSORT ASC
);

alter table ADDFORMPARAMVAL
   add constraint ADDFORMPARAMVAL_F2 foreign key (MID)
      references FORMS (FID)
      on delete cascade;

alter table ADDFORMPARAMVAL
   add constraint ADDFORMPARAMVAL_F1 foreign key (NSORT)
      references ADDFORMPARAM (NSORT)
      on delete cascade;



begin
insert into ADDFORMPARAM(NSORT,VDESCR,NTYPE) values(-1,'Блокировать вывод заголовка таблицы',1);
insert into ADDFORMPARAM(NSORT,VDESCR,NTYPE) values(-2,'Блокировать вывод даты флрмирования',1);
insert into ADDFORMPARAM(NSORT,VDESCR,NTYPE) values(-3,'Шаблон заголовка отчета (rtf-файл)',7);
insert into ADDFORMPARAM(NSORT,VDESCR,NTYPE) values(-4,'Шаблон итогов отчета (rtf-файл)',7);
commit;
end;
/



/*==============================================================*/
/* Table: BASEFORMULA                                           */
/*==============================================================*/
create table BASEFORMULA  (
   NID                  NUMBER(10)                      not null,
   VNAME                VARCHAR2(128)                   not null,
   VVALUE               VARCHAR2(2000)                  not null,
   constraint PK_BASEFORMULA primary key (NID)
);

comment on table BASEFORMULA is
'Базовые формулы';

comment on column BASEFORMULA.NID is
'Ид формулы';

comment on column BASEFORMULA.VNAME is
'Название';

comment on column BASEFORMULA.VVALUE is
'Формула';

/*==============================================================*/
/* Index: BASEFORMULA_IDX1                                      */
/*==============================================================*/
create unique index BASEFORMULA_IDX1 on BASEFORMULA (
   VNAME ASC
);

/*==============================================================*/
/* Table: BASEFUNCTION                                          */
/*==============================================================*/
create table BASEFUNCTION  (
   NID                  NUMBER(10)                      not null,
   VNAME                VARCHAR2(128)                   not null,
   VVALUE               VARCHAR2(2000)                  not null,
   constraint PK_BASEFUNCTION primary key (NID)
);

comment on table BASEFUNCTION is
'Базовые функции';

comment on column BASEFUNCTION.NID is
'Ид функции';

comment on column BASEFUNCTION.VNAME is
'Название';

comment on column BASEFUNCTION.VVALUE is
'Функция';

/*==============================================================*/
/* Index: BASEFUNCTION_IDX1                                     */
/*==============================================================*/
create unique index BASEFUNCTION_IDX1 on BASEFUNCTION (
   VNAME ASC
);


--08/10/2007
ALTER TABLE HALFHOUROLD  MODIFY (QM VARCHAR2 (32) );
ALTER TABLE HALFHOUROLD RENAME COLUMN QM TO VQM;
update BILLOLD set qm=null where qm is not null;
ALTER TABLE BILLOLD  MODIFY (QM VARCHAR2 (32) );
ALTER TABLE BILLOLD RENAME COLUMN QM TO VQM;

-- Start of DDL Script for View RYDA.BILL
-- Generated 08.10.2008 11:33:19 from RYDA@oe

CREATE OR REPLACE VIEW bill (   mid,   date_time,   valid,   source,   remark,   
er_mtrsn,   er_kc,   erm,   er,   aerm,   aer,   berm,   ber,   cerm,   cer,   derm,   der,   q1_mtrsn,   q1_kc,   q1m,   q1,   aq1m,   aq1,   bq1m,   bq1,   cq1m,
   cq1,   dq1m,   dq1,   ed_mtrsn,   ed_kc,   edm,   ed,   aedm,   aed,   bedm,   bed,   cedm,   ced,   dedm,   ded,   q3_mtrsn,   q3_kc,   q3m,   q3,   aq3m,   aq3,
   bq3m,   bq3,   cq3m,   cq3,   dq3m,   dq3,   q2_mtrsn,   q2_kc,   q2m,   q2,   aq2m,   aq2,   bq2m,   bq2,   cq2m,   cq2,   dq2m,   dq2,   q4_mtrsn,   q4_kc,   q4m,
   q4,   aq4m,   aq4,   bq4m,   bq4,   cq4m,   cq4,   dq4m,   dq4,   nwasteabs,   nsource,   vqm )
AS
SELECT    MID,    DATE_TIME,    VALID,    SOURCE,    REMARK,    
ER_MTRSN,    ER_KC,    ERM,    ER,    AERM,    AER,    BERM,    BER,    CERM,    CER,    DERM,    DER,    Q1_MTRSN,    Q1_KC,    Q1M,    Q1,    AQ1M,    AQ1,    BQ1M,
   BQ1,    CQ1M,    CQ1,    DQ1M,    DQ1,    ED_MTRSN,    ED_KC,    EDM,    ED,    AEDM,    AED,    BEDM,    BED,    CEDM,    CED,    DEDM,    DED,    Q3_MTRSN,    Q3_KC,
    Q3M,    Q3,    AQ3M,    AQ3,    BQ3M,    BQ3,    CQ3M,    CQ3,    DQ3M,    DQ3,    Q2_MTRSN,    Q2_KC,    Q2M,    Q2,    AQ2M,    AQ2,    BQ2M,    BQ2,    CQ2M,    CQ2,
    DQ2M,    DQ2,    Q4_MTRSN,    Q4_KC,    Q4M,    Q4,    AQ4M,    AQ4,    BQ4M,    BQ4,    CQ4M,    CQ4,    DQ4M,    DQ4,    NWASTEABS,    NSOURCE,    VQM
 FROM RYDA.BILLOLD WHERE NEXCEPTCALC IS NULL and nsource>0
/

COMMENT ON TABLE bill IS 'Реальные суточные измерения'
/

CREATE OR REPLACE VIEW bill_for_term (   date_time,   p1name,   p2name,   mid,   er,   q1,   ed,   q3,   q2,   q4,   erm,   q1m,   edm,   q3m,   q2m,   q4m,
   aer,   aq1,   aed,   aq3,   aq2,   aq4,   aerm,   aq1m,   aedm,   aq3m,   aq2m,   aq4m,   ber,   bq1,   bed,   bq3,   bq2,   bq4,   berm,   bq1m,   bedm,
   bq3m,   bq2m,   bq4m,   cer,   cq1,   ced,   cq3,   cq2,   cq4,   cerm,   cq1m,   cedm,   cq3m,   cq2m,   cq4m,   der,   dq1,   ded,   dq3,   dq2,   dq4,
   derm,   dq1m,   dedm,   dq3m,   dq2m,   dq4m,   kc,   er_mtrsn,   denter )
AS
select      b.date_time  		,      p1.Name p1Name, p2.Name p2Name, b.mid, b.er, b.q1, b.ed, b.q3, b.q2, b.q4, b.erm, b.q1m, b.edm, b.q3m, b.q2m, b.q4m      ,
      b.aer, b.aq1, b.aed, b.aq3, b.aq2, b.aq4, b.aerm, b.aq1m, b.aedm, b.aq3m, b.aq2m, b.aq4m ,b.ber, b.bq1, b.bed, b.bq3, b.bq2, b.bq4, b.berm, b.bq1m, b.bedm, b.bq3m, b.bq2m, b.bq4m ,
      b.cer, b.cq1, b.ced, b.cq3, b.cq2, b.cq4, b.cerm, b.cq1m, b.cedm, b.cq3m, b.cq2m, b.cq4m, b.der, b.dq1, b.ded, b.dq3, b.dq2, b.dq4, b.derm, b.dq1m, b.dedm, b.dq3m, b.dq2m, b.dq4m ,      
      f.kc, b.er_mtrsn,b.denter      from
      billevid b, points p1, points p2, feeders f    where   f.mid=p2.mid(+) and p2.parent=p1.mid(+) and f.mid=b.mid
/

CREATE OR REPLACE VIEW bill_l (   mid,   date_time,   valid,   source,   remark,
   er_mtrsn,   er_kc,   erm,   er,   aerm,   aer,   berm,   ber,   cerm,   cer,   derm,   der,   q1_mtrsn,   q1_kc,   q1m,   q1,   aq1m,   aq1,   bq1m,   bq1,   cq1m,   cq1,
   dq1m,   dq1,   ed_mtrsn,   ed_kc,   edm,   ed,   aedm,   aed,   bedm,   bed,   cedm,   ced,   dedm,   ded,   q3_mtrsn,   q3_kc,   q3m,   q3,   aq3m,   aq3,   bq3m,   bq3,
   cq3m,   cq3,   dq3m,   dq3,   q2_mtrsn,   q2_kc,   q2m,   q2,   aq2m,   aq2,   bq2m,   bq2,   cq2m,   cq2,   dq2m,   dq2,   q4_mtrsn,   q4_kc,   q4m,   q4,   aq4m,   aq4,
   bq4m,   bq4,   cq4m,   cq4,   dq4m,   dq4,   nwasteabs,   nsource,   vqm )
AS
SELECT    MID,    DATE_TIME,    VALID,    SOURCE,    REMARK,    
ER_MTRSN,    ER_KC,    ERM,    ER,    AERM,    AER,    BERM,    BER,    CERM,    CER,    DERM,    DER,    Q1_MTRSN,    Q1_KC,    Q1M,    Q1,    AQ1M,    AQ1,    BQ1M,    BQ1,
    CQ1M,    CQ1,    DQ1M,    DQ1,    ED_MTRSN,    ED_KC,    EDM,    ED,    AEDM,    AED,    BEDM,    BED,    CEDM,    CED,    DEDM,    DED,    Q3_MTRSN,    Q3_KC,    Q3M,
    Q3,    AQ3M,    AQ3,    BQ3M,    BQ3,    CQ3M,    CQ3,    DQ3M,    DQ3,    Q2_MTRSN,    Q2_KC,    Q2M,    Q2,    AQ2M,    AQ2,    BQ2M,    BQ2,    CQ2M,    CQ2,    DQ2M,    DQ2,
    Q4_MTRSN,    Q4_KC,    Q4M,    Q4,    AQ4M,    AQ4,    BQ4M,    BQ4,    CQ4M,    CQ4,    DQ4M,    DQ4,    NWASTEABS,    NSOURCE,    VQM
 FROM RYDA.BILLOLD WHERE NEXCEPTCALC IS NULL
/

CREATE OR REPLACE VIEW bill_ol (   mid,   date_time,   valid,   source,   remark,   
er_mtrsn,   er_kc,   erm,   er,   aerm,   aer,   berm,   ber,   cerm,   cer,  derm,   der,   q1_mtrsn,   q1_kc,   q1m,   q1,   aq1m,   aq1,   bq1m,   bq1,   cq1m,   cq1,   dq1m,
   dq1,   ed_mtrsn,   ed_kc,   edm,   ed,   aedm,   aed,   bedm,   bed,   cedm,   ced,   dedm,   ded,   q3_mtrsn,   q3_kc,   q3m,   q3,   aq3m,   aq3,   bq3m,   bq3,   cq3m,   cq3,   dq3m,   dq3,
   q2_mtrsn,   q2_kc,   q2m,   q2,   aq2m,   aq2,   bq2m,   bq2,   cq2m,   cq2,   dq2m,   dq2,   q4_mtrsn,   q4_kc,   q4m,   q4,   aq4m,   aq4,   bq4m,   bq4,   cq4m,   cq4,   dq4m,   dq4,   nwasteabs,   nsource,   vqm )
AS 
SELECT    MID,    DATE_TIME,    VALID,    SOURCE,    REMARK,    
ER_MTRSN,    ER_KC,    ERM,    ER,    AERM,    AER,    BERM,    BER,    CERM,    CER,    DERM,    DER,    Q1_MTRSN,    Q1_KC,    Q1M,    Q1,    AQ1M,    AQ1,    BQ1M,    BQ1,    CQ1M,    CQ1,
    DQ1M,    DQ1,    ED_MTRSN,    ED_KC,    EDM,    ED,    AEDM,    AED,    BEDM,    BED,    CEDM,    CED,    DEDM,    DED,    Q3_MTRSN,    Q3_KC,    Q3M,    Q3,    AQ3M,    AQ3,
    BQ3M,    BQ3,    CQ3M,    CQ3,    DQ3M,    DQ3,    Q2_MTRSN,    Q2_KC,    Q2M,    Q2,    AQ2M,    AQ2,    BQ2M,    BQ2,    CQ2M,    CQ2,    DQ2M,    DQ2,    Q4_MTRSN,    Q4_KC,
    Q4M,    Q4,    AQ4M,    AQ4,    BQ4M,    BQ4,    CQ4M,    CQ4,    DQ4M,    DQ4,    NWASTEABS,    NSOURCE,    VQM
 FROM RYDA.BILLOLD WHERE NEXCEPTCALC IS NULL and nsource<0
/

COMMENT ON TABLE bill_ol IS 'Реальные суточные измерения только потери'
/

CREATE OR REPLACE VIEW billevid (   mid,   date_time,   valid,   source,   remark,   
er_mtrsn,   er_kc,   erm,   er,   aerm,   aer,   berm,   ber,   cerm,   cer,   derm,   der,   q1_mtrsn,   q1_kc,   q1m,   q1,   aq1m,   aq1,   bq1m,   bq1,   cq1m,   cq1,   dq1m,
   dq1,   ed_mtrsn,   ed_kc,   edm,   ed,   aedm,   aed,   bedm,   bed,   cedm,   ced,   dedm,   ded,   q3_mtrsn,   q3_kc,   q3m,   q3,   aq3m,   aq3,   bq3m,   bq3,   cq3m,   cq3,
   dq3m,   dq3,   q2_mtrsn,   q2_kc,   q2m,   q2,   aq2m,   aq2,   bq2m,   bq2,   cq2m,   cq2,   dq2m,   dq2,   q4_mtrsn,   q4_kc,   q4m,   q4,   aq4m,   aq4,   bq4m,   bq4,   cq4m,
   cq4,   dq4m,   dq4,   denter )
   AS    SELECT    MID,    DATE_TIME,    VALID,    SOURCE,    REMARK,    
   ER_MTRSN,    ER_KC,    ERM,    ER,    AERM,    AER,    BERM,    BER,    CERM,    CER,    DERM,    DER,    Q1_MTRSN,    Q1_KC,    Q1M,    Q1,    AQ1M,    AQ1,    BQ1M,    BQ1,
    CQ1M,    CQ1,    DQ1M,    DQ1,    ED_MTRSN,    ED_KC,    EDM,    ED,    AEDM,    AED,    BEDM,    BED,    CEDM,    CED,    DEDM,    DED,    Q3_MTRSN,    Q3_KC,    Q3M,    Q3,
    AQ3M,    AQ3,    BQ3M,    BQ3,    CQ3M,    CQ3,    DQ3M,    DQ3,    Q2_MTRSN,    Q2_KC,    Q2M,    Q2,    AQ2M,    AQ2,    BQ2M,    BQ2,    CQ2M,    CQ2,    DQ2M,    DQ2,
    Q4_MTRSN,    Q4_KC,    Q4M,    Q4,    AQ4M,    AQ4,    BQ4M,    BQ4,    CQ4M,    CQ4,    DQ4M,    DQ4,    denter FROM RYDA.BILLORG
/    

CREATE OR REPLACE VIEW halfhour (   mid,   date_time,   er,   q1,   ed,   q3,   q2,   q4,   erm,   q1m,   edm,   q3m,   q2m,   q4m,   status,   nkc,   nsource,   er_mtrsn,   nswitch,   denter,   vqm )
AS
SELECT    MID,    DATE_TIME,    ER,    Q1,    ED,    Q3,    Q2,    Q4,    ERM,    Q1M,    EDM,    Q3M,    Q2M,    Q4M,    STATUS,    NKC,    NSOURCE,    ER_MTRSN,    NSWITCH,    DENTER,    VQM
 FROM RYDA.HALFHOUROLD WHERE NEXCEPTCALC IS NULL and nsource>0
/

CREATE OR REPLACE VIEW halfhour_l (   mid,   date_time,   er,   q1,   ed,   q3,   q2,   q4,   erm,   q1m,   edm,   q3m,   q2m,   q4m,   status,   nkc,   nsource,   er_mtrsn,   nswitch,   denter,   vqm )
AS SELECT    MID,    DATE_TIME,    ER,    Q1,    ED,    Q3,    Q2,    Q4,    ERM,    Q1M,    EDM,    Q3M,    Q2M,    Q4M,    STATUS,    NKC,   NSOURCE,    ER_MTRSN,    NSWITCH,    DENTER,    VQM
 FROM RYDA.HALFHOUROLD WHERE NEXCEPTCALC IS NULL
/

CREATE OR REPLACE VIEW halfhour_ol (   mid,   date_time,   er,   q1,   ed,   q3,   q2,   q4,   erm,   q1m,   edm,  q3m,   q2m,   q4m,   status,   nkc,   nsource,   er_mtrsn,   nswitch,   denter,   vqm )
AS SELECT    MID,    DATE_TIME,    ER,    Q1,    ED,    Q3,    Q2,    Q4,    ERM,    Q1M,    EDM,    Q3M,    Q2M,    Q4M,    STATUS,    NKC,    NSOURCE,    ER_MTRSN,    NSWITCH,    DENTER,    VQM
 FROM RYDA.HALFHOUROLD WHERE NEXCEPTCALC IS NULL and nsource<0
/

CREATE OR REPLACE VIEW halfhourevid (   mid,   date_time,   er,   q1,   ed,   q3,   q2,   q4,   erm,   q1m,   edm,   q3m,   q2m,   q4m,   status,   nkc,   denter,   vqm )
AS SELECT    MID,    DATE_TIME,    ER,    Q1,    ED,    Q3,    Q2,    Q4,    ERM,    Q1M,    EDM,    Q3M,    Q2M,    Q4M,    STATUS,    NKC,    denter,    VQM
 FROM RYDA.HALFHOURold
/

CREATE OR REPLACE VIEW month_for_term (   date_time,   p1name,   p2name,   mid,   er,   q1,   ed,   q3,   q2,   q4,   erm,   q1m,   edm,   q3m,   q2m,   q4m,   aer,   aq1,   aed,   aq3,
   aq2,   aq4,   aerm,   aq1m,   aedm,   aq3m,   aq2m,   aq4m,   ber,   bq1,   bed,   bq3,   bq2,   bq4,   berm,   bq1m,   bedm,   bq3m,   bq2m,   bq4m,   cer,   cq1,   ced,   cq3,   cq2,
   cq4,   cerm,   cq1m,   cedm,   cq3m,   cq2m,   cq4m,   der,   dq1,   ded,   dq3,   dq2,   dq4,   derm,   dq1m,   dedm,   dq3m,   dq2m,   dq4m,   kc,   er_mtrsn,   denter )
   AS select      b.date_time  		,      p1.Name p1Name, p2.Name p2Name, b.mid,b.er, b.q1, b.ed, b.q3, b.q2, b.q4, b.erm, b.q1m, b.edm, b.q3m, b.q2m, b.q4m,
  b.aer, b.aq1, b.aed, b.aq3, b.aq2, b.aq4, b.aerm, b.aq1m, b.aedm, b.aq3m, b.aq2m, b.aq4m,b.ber, b.bq1, b.bed, b.bq3, b.bq2, b.bq4, b.berm, b.bq1m, b.bedm, b.bq3m, b.bq2m, b.bq4m,
  b.cer, b.cq1, b.ced, b.cq3, b.cq2, b.cq4, b.cerm, b.cq1m, b.cedm, b.cq3m, b.cq2m, b.cq4m,b.der, b.dq1, b.ded, b.dq3, b.dq2, b.dq4, b.derm, b.dq1m, b.dedm, b.dq3m, b.dq2m, b.dq4m ,  f.kc, b.er_mtrsn, b.denter
 from monthsevid b, points p1, points p2, feeders f   where      f.mid=p2.mid(+) and p2.parent=p1.mid(+) and f.mid=b.mid
/

CREATE OR REPLACE VIEW months (   mid,   date_time,   valid,   source,   remark,   
er_mtrsn,   er_kc,   erm,   er,   aerm,   aer,   berm,   ber,   cerm,   cer,   derm,   der,   q1_mtrsn,   q1_kc,   q1m,   q1,   aq1m,   aq1,   bq1m,   bq1,   cq1m,   cq1,   dq1m,   dq1,
   ed_mtrsn,   ed_kc,   edm,   ed,   aedm,   aed,   bedm,   bed,   cedm,   ced,   dedm,   ded,   q3_mtrsn,   q3_kc,   q3m,   q3,   aq3m,   aq3,   bq3m,   bq3,   cq3m,   cq3,   dq3m,   dq3,
   q2_mtrsn,   q2_kc,   q2m,   q2,   aq2m,   aq2,   bq2m,   bq2,   cq2m,   cq2,   dq2m,   dq2,   q4_mtrsn,   q4_kc,   q4m,   q4,   aq4m,   aq4,   bq4m,   bq4,   cq4m,   cq4,   dq4m,   dq4,   nwasteabs,   nsource,   denter )
AS SELECT    MID,    DATE_TIME,    VALID,    SOURCE,    REMARK,    
   ER_MTRSN,    ER_KC,    ERM,    ER,    AERM,    AER,    BERM,    BER,    CERM,    CER,    DERM,    DER,    Q1_MTRSN,    Q1_KC,    Q1M,    Q1,    AQ1M,    AQ1,    BQ1M,    BQ1,
   CQ1M,    CQ1,    DQ1M,    DQ1,    ED_MTRSN,    ED_KC,    EDM,    ED,    AEDM,    AED,    BEDM,    BED,    CEDM,    CED,    DEDM,    DED,    Q3_MTRSN,    Q3_KC,    Q3M,    Q3,
   AQ3M,    AQ3,    BQ3M,    BQ3,    CQ3M,    CQ3,    DQ3M,    DQ3,    Q2_MTRSN,    Q2_KC,    Q2M,    Q2,    AQ2M,    AQ2,    BQ2M,    BQ2,    CQ2M,    CQ2,    DQ2M,    DQ2,    Q4_MTRSN,
    Q4_KC,    Q4M,    Q4,    AQ4M,    AQ4,    BQ4M,    BQ4,    CQ4M,    CQ4,    DQ4M,    DQ4,    NWASTEABS,    nsource,    DENTER
 FROM MONTHSORG
/

CREATE OR REPLACE VIEW monthsevid (   mid,   date_time,   valid,   source,   remark,   
er_mtrsn,   er_kc,   erm,   er,   aerm,   aer,   berm,   ber,   cerm,   cer,   derm,   der,   q1_mtrsn,   q1_kc,   q1m,   q1,   aq1m,   aq1,   bq1m,   bq1,   cq1m,   cq1,   dq1m,   dq1,
   ed_mtrsn,   ed_kc,   edm,   ed,   aedm,   aed,   bedm,   bed,   cedm,   ced,   dedm,   ded,   q3_mtrsn,   q3_kc,   q3m,   q3,   aq3m,   aq3,   bq3m,   bq3,   cq3m,   cq3,   dq3m,   dq3,
   q2_mtrsn,   q2_kc,   q2m,   q2,   aq2m,   aq2,   bq2m,   bq2,   cq2m,   cq2,   dq2m,   dq2,   q4_mtrsn,   q4_kc,   q4m,   q4,   aq4m,   aq4,   bq4m,   bq4,   cq4m,   cq4,   dq4m,   dq4,   denter )
AS SELECT    MID,    DATE_TIME,    VALID,    SOURCE,    REMARK,
    ER_MTRSN,    ER_KC,    ERM,    ER,    AERM,    AER,    BERM,    BER,    CERM,    CER,    DERM,    DER,    Q1_MTRSN,    Q1_KC,    Q1M,    Q1,    AQ1M,    AQ1,    BQ1M,    BQ1,    CQ1M,    CQ1,    
    DQ1M,    DQ1,    ED_MTRSN,    ED_KC,    EDM,    ED,    AEDM,    AED,    BEDM,    BED,    CEDM,    CED,    DEDM,    DED,    Q3_MTRSN,    Q3_KC,    Q3M,    Q3,    AQ3M,    AQ3,    BQ3M,    BQ3,    
    CQ3M,    CQ3,    DQ3M,    DQ3,    Q2_MTRSN,    Q2_KC,    Q2M,    Q2,    AQ2M,    AQ2,    BQ2M,    BQ2,    CQ2M,    CQ2,    DQ2M,    DQ2,    Q4_MTRSN,    Q4_KC,    Q4M,    Q4,    AQ4M,    AQ4,
    BQ4M,    BQ4,    CQ4M,    CQ4,    DQ4M,    DQ4,    denter
 FROM RYDA.MONTHSORG
/

alter table PROFILE  add(
   VQM                  VARCHAR2(32)
);

comment on column PROFILE.VQM is
'Метка качества';

CREATE OR REPLACE VIEW profileevid (   mid,   date_time,   er,   q1,   ed,  q3,   q2,   q4,   freq,   cosf,   volt,   currento,   volt2,   volt3,   curr2,   curr3,   erm,   q1m,   edm,   q3m,   q2m,   q4m,   denter,   nsource,vqm )
AS 
SELECT    MID,    DATE_TIME,    ER,    Q1,    ED,    Q3,    Q2,    Q4,    FREQ,    COSF,    VOLT,    CURRENTO,    VOLT2,    VOLT3,    CURR2,    CURR3,    ERM,    Q1M,    EDM,    Q3M,    Q2M,    Q4M,    denter, nsource ,vqm
FROM RYDA.PROFILE
/

insert into ADDFORMPARAM(NSORT,VDESCR,NTYPE) values(-5,'Блокировать вывод итоговых строк',1);
commit;

grant update on addpointparamval to askue_work;
grant update on addformparamval to askue_work;

------13/10/2008
alter table HALFHOURTMP  add(
   VQM                  VARCHAR2(32),
   NMETERTYPE           NUMBER(10)
);

comment on column HALFHOURTMP.VQM is
'Метка качества';

comment on column HALFHOURTMP.NMETERTYPE is
'Тип счетчика';

create index HALFHOURTMP_IDX1 on HALFHOURTMP (
   NMETERTYPE ASC
);


alter table HALFHOURTMP
   add constraint HALFHOURTMP_F2 foreign key (NMETERTYPE)
      references METERTYPE (NMETERTYPE);



alter table HALFHOUROLD  add(
   NMETERTYPE           NUMBER(10)
);

comment on column HALFHOUROLD.NMETERTYPE is
'Тип счетчика';

create index HALFHOUROLD_IDX3 on HALFHOUROLD (
   NMETERTYPE ASC   
);

alter table HALFHOUROLD
   add constraint HALFHOUROLD_F2 foreign key (NMETERTYPE)
      references METERTYPE (NMETERTYPE);

/*
---------18/04/2007
alter table BILLORG drop column TS;
alter table BILLORG drop column Q61850;

alter table PROFILE drop column TS;
alter table PROFILE drop column Q61850;

alter table MAN_INP_HHOUR drop column TS;
alter table MAN_INP_HHOUR drop column Q61850;

alter table MONTHSORG drop column TS;
alter table MONTHSORG drop column Q61850;

alter table HALFHOUROLD drop column TS;
alter table HALFHOUROLD drop column Q61850;

alter table BILLOLD drop column TS;
alter table BILLOLD drop column Q61850;

alter table CURR_POWER drop column TS;
alter table CURR_POWER drop column Q61850;

alter table HALFHOURTMP drop column TS;
alter table HALFHOURTMP drop column Q61850;
*/

begin
INSERT INTO metertype("NMETERTYPE","VNAME")VALUES(20,'ИТЕК-210');
commit;
end;
/


begin
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (0,'Примечание о работе счетчика',0);
commit;
exception
    when others then null;
end;
/



-----14/10/2008
-- Start of DDL Script for Type RYDA.TSUMQM
-- Generated 14.10.2008 12:52:33 from RYDA@oe

CREATE OR REPLACE 
type tsumqm as object
(
  resultstr VARCHAR2(4000), -- highest value seen so far 
  secmax NUMBER, -- second highest value seen so far
  static function ODCIAggregateInitialize(sctx IN OUT TSUMQM) return number,
  member function ODCIAggregateIterate(self IN OUT TSUMQM,value IN varchar2) return number,
  member function ODCIAggregateTerminate(self IN TSUMQM,returnValue OUT varchar2, flags IN number) return number,
  member function ODCIAggregateMerge(self IN OUT TSUMQM,ctx2 IN TSUMQM) return number
);
/


-- End of DDL Script for Type RYDA.TSUMQM

-- Start of DDL Script for Type Body RYDA.TSUMQM
-- Generated 14.10.2008 12:52:39 from RYDA@oe

CREATE OR REPLACE 
TYPE BODY tsumqm is 
static function ODCIAggregateInitialize(sctx IN OUT TSUMQM) 
return number is 
begin
  sctx := TSUMQM('', 0);
  return ODCIConst.Success;
end;

member function ODCIAggregateIterate(self IN OUT TSUMQM, value IN varchar2) return number is
begin
  IF self.resultstr IS NULL THEN  
  self.resultstr := value;
  ELSE
  self.resultstr := QM_PG.sumqm(self.resultstr,value);
  END IF;
  return ODCIConst.Success;
end;

member function ODCIAggregateTerminate(self IN TSUMQM,returnValue OUT varchar2, flags IN number) return number is
begin
  returnValue := self.resultstr ;
  return ODCIConst.Success;
end;

member function ODCIAggregateMerge(self IN OUT TSUMQM, ctx2 IN TSUMQM) return number is
begin
  IF self.resultstr IS NULL THEN  
  self.resultstr := ctx2.resultstr;
  ELSE
  self.resultstr := QM_PG.sumqm(self.resultstr,ctx2.resultstr);
  END IF;
  return ODCIConst.Success;
end;
end;
/


-- End of DDL Script for Type Body RYDA.TSUMQM

-- Start of DDL Script for Function RYDA.SUMQM
-- Generated 14.10.2008 12:52:43 from RYDA@oe

CREATE OR REPLACE 
FUNCTION sumqm(input VARCHAR2) RETURN VARCHAR2 PARALLEL_ENABLE AGGREGATE USING TSUMQM;
/



CREATE OR REPLACE VIEW bill (
mid,date_time,valid,source,remark,er_mtrsn,er_kc,erm,er,aerm,aer,berm,ber,cerm,cer,derm,der,q1_mtrsn,q1_kc,q1m,q1,aq1m,aq1,bq1m,bq1,cq1m,cq1,dq1m,dq1,ed_mtrsn,ed_kc,
edm,ed,aedm,aed,bedm,bed,cedm,ced,dedm,ded,q3_mtrsn,q3_kc,q3m,q3,aq3m,aq3,bq3m,bq3,cq3m,cq3,dq3m,dq3,q2_mtrsn,q2_kc,q2m,q2,aq2m,aq2,bq2m,bq2,cq2m,cq2,dq2m,dq2,q4_mtrsn,
q4_kc,q4m,q4,aq4m,aq4,bq4m,bq4,cq4m,cq4,dq4m,dq4,nwasteabs,nsource,vqm )
AS
SELECT MID, DATE_TIME, VALID, SOURCE, REMARK, ER_MTRSN, ER_KC, ERM, ER, AERM, AER, BERM, BER, CERM, CER, DERM, DER, Q1_MTRSN, Q1_KC, Q1M, Q1, AQ1M, AQ1, BQ1M, BQ1, CQ1M,
 CQ1, DQ1M, DQ1, ED_MTRSN, ED_KC, EDM, ED, AEDM, AED, BEDM, BED, CEDM, CED, DEDM, DED, Q3_MTRSN, Q3_KC, Q3M, Q3, AQ3M, AQ3, BQ3M, BQ3, CQ3M, CQ3, DQ3M, DQ3, Q2_MTRSN, Q2_KC,
 Q2M, Q2, AQ2M, AQ2, BQ2M, BQ2, CQ2M, CQ2, DQ2M, DQ2, Q4_MTRSN, Q4_KC, Q4M, Q4, AQ4M, AQ4, BQ4M, BQ4, CQ4M, CQ4, DQ4M, DQ4, NWASTEABS, NSOURCE, VQM
 FROM RYDA.BILLOLD WHERE NEXCEPTCALC IS NULL and nsource>0
/


CREATE OR REPLACE VIEW bill_l (mid,date_time,valid,source,remark,er_mtrsn,er_kc,erm,er,aerm,aer,berm,ber,cerm,cer,derm,der,q1_mtrsn,q1_kc,q1m,q1,aq1m,aq1,bq1m,bq1,
cq1m,cq1,dq1m,dq1,ed_mtrsn,ed_kc,edm,ed,aedm,aed,bedm,bed,cedm,ced,dedm,ded,q3_mtrsn,q3_kc,q3m,q3,aq3m,aq3,bq3m,bq3,cq3m,cq3,dq3m,dq3,q2_mtrsn,q2_kc,q2m,q2,aq2m,aq2,
bq2m,bq2,cq2m,cq2,dq2m,dq2,q4_mtrsn,q4_kc,q4m,q4,aq4m,aq4,bq4m,bq4,cq4m,cq4,dq4m,dq4,nwasteabs,nsource,vqm )
AS
SELECT MID, DATE_TIME, VALID, SOURCE, REMARK, ER_MTRSN, ER_KC, ERM, ER, AERM, AER, BERM, BER, CERM, CER, DERM, DER, Q1_MTRSN, Q1_KC, Q1M, Q1, AQ1M, AQ1, BQ1M, BQ1, CQ1M,
 CQ1, DQ1M, DQ1, ED_MTRSN, ED_KC, EDM, ED, AEDM, AED, BEDM, BED, CEDM, CED, DEDM, DED, Q3_MTRSN, Q3_KC, Q3M, Q3, AQ3M, AQ3, BQ3M, BQ3, CQ3M, CQ3, DQ3M, DQ3, Q2_MTRSN, Q2_KC, Q2M, Q2, AQ2M,
 AQ2, BQ2M, BQ2, CQ2M, CQ2, DQ2M, DQ2, Q4_MTRSN, Q4_KC, Q4M, Q4, AQ4M, AQ4, BQ4M, BQ4, CQ4M, CQ4, DQ4M, DQ4, NWASTEABS, NSOURCE, VQM FROM RYDA.BILLOLD WHERE NEXCEPTCALC IS NULL
/

CREATE OR REPLACE VIEW bill_ol (mid,date_time,valid,source,remark,er_mtrsn,er_kc,erm,er,aerm,aer,berm,ber,cerm,cer,derm,der,q1_mtrsn,q1_kc,q1m,q1,aq1m,aq1,bq1m,bq1,cq1m,cq1,dq1m,
dq1,ed_mtrsn,ed_kc,edm,ed,aedm,aed,bedm,bed,cedm,ced,dedm,ded,q3_mtrsn,q3_kc,q3m,q3,aq3m,aq3,bq3m,bq3,cq3m,cq3,dq3m,dq3,q2_mtrsn,q2_kc,q2m,q2,aq2m,aq2,bq2m,bq2,cq2m,cq2,dq2m,dq2,
q4_mtrsn,q4_kc,q4m,q4,aq4m,aq4,bq4m,bq4,cq4m,cq4,dq4m,dq4,nwasteabs,nsource,vqm )
AS
SELECT MID, DATE_TIME, VALID, SOURCE, REMARK, ER_MTRSN, ER_KC, ERM, ER, AERM, AER, BERM, BER, CERM, CER, DERM, DER, Q1_MTRSN, Q1_KC, Q1M, Q1, AQ1M, AQ1, BQ1M, BQ1, CQ1M, CQ1,
 DQ1M, DQ1, ED_MTRSN, ED_KC, EDM, ED, AEDM, AED, BEDM, BED, CEDM, CED, DEDM, DED, Q3_MTRSN, Q3_KC, Q3M, Q3, AQ3M, AQ3, BQ3M, BQ3, CQ3M, CQ3, DQ3M, DQ3, Q2_MTRSN, Q2_KC, Q2M, Q2, AQ2M,
 AQ2, BQ2M, BQ2, CQ2M, CQ2, DQ2M, DQ2, Q4_MTRSN, Q4_KC, Q4M, Q4, AQ4M, AQ4, BQ4M, BQ4, CQ4M, CQ4, DQ4M, DQ4, NWASTEABS, NSOURCE, VQM
 FROM RYDA.BILLOLD WHERE NEXCEPTCALC IS NULL and nsource<0
/
CREATE OR REPLACE VIEW billevid (mid,date_time,valid,source,remark,er_mtrsn,er_kc,erm,er,aerm,aer,berm,ber,cerm,cer,derm,der,q1_mtrsn,q1_kc,q1m,q1,aq1m,aq1,bq1m,bq1,cq1m,cq1,dq1m,
dq1,ed_mtrsn,ed_kc,edm,ed,aedm,aed,bedm,bed,cedm,ced,dedm,ded,q3_mtrsn,q3_kc,q3m,q3,aq3m,aq3,bq3m,bq3,cq3m,cq3,dq3m,dq3,q2_mtrsn,q2_kc,q2m,q2,aq2m,aq2,bq2m,bq2,cq2m,cq2,dq2m,dq2,
q4_mtrsn,q4_kc,q4m,q4,aq4m,aq4,bq4m,bq4,cq4m,cq4,dq4m,dq4,denter )
AS
SELECT MID, DATE_TIME, VALID, SOURCE, REMARK, ER_MTRSN, ER_KC, ERM, ER, AERM, AER, BERM, BER, CERM, CER, DERM, DER, Q1_MTRSN, Q1_KC, Q1M, Q1, AQ1M, AQ1, BQ1M, BQ1, CQ1M, CQ1, DQ1M,
 DQ1, ED_MTRSN, ED_KC, EDM, ED, AEDM, AED, BEDM, BED, CEDM, CED, DEDM, DED, Q3_MTRSN, Q3_KC, Q3M, Q3, AQ3M, AQ3, BQ3M, BQ3, CQ3M, CQ3, DQ3M, DQ3, Q2_MTRSN, Q2_KC, Q2M, Q2, AQ2M, AQ2, 
 BQ2M, BQ2, CQ2M, CQ2, DQ2M, DQ2, Q4_MTRSN, Q4_KC, Q4M, Q4, AQ4M, AQ4, BQ4M, BQ4, CQ4M, CQ4, DQ4M, DQ4, denter FROM RYDA.BILLORG
/

CREATE OR REPLACE VIEW halfhour (mid,date_time,er,q1,ed,q3,q2,q4,erm,q1m,edm,q3m,q2m,q4m,status,nkc,nsource,er_mtrsn,nswitch,denter,vqm,nmetertype )
AS
SELECT MID, DATE_TIME, ER, Q1, ED, Q3, Q2, Q4, ERM, Q1M, EDM, Q3M, Q2M, Q4M, STATUS, NKC, NSOURCE, ER_MTRSN, NSWITCH, DENTER, VQM, nmetertype 
FROM RYDA.HALFHOUROLD WHERE NEXCEPTCALC IS NULL and nsource>0
/

CREATE OR REPLACE VIEW halfhour_l (mid,date_time,er,q1,ed,q3,q2,q4,erm,q1m,edm,q3m,q2m,q4m,status,nkc,nsource,er_mtrsn,nswitch,denter,vqm,nmetertype )
AS
SELECT MID, DATE_TIME, ER, Q1, ED, Q3, Q2, Q4, ERM, Q1M, EDM, Q3M, Q2M, Q4M, STATUS, NKC, NSOURCE, ER_MTRSN, NSWITCH, DENTER, VQM,nmetertype FROM RYDA.HALFHOUROLD WHERE NEXCEPTCALC IS NULL
/

CREATE OR REPLACE VIEW halfhour_ol (mid,date_time,er,q1,ed,q3,q2,q4,erm,q1m,edm,q3m,q2m,q4m,status,nkc,nsource,er_mtrsn,nswitch,denter,vqm,nmetertype )
AS
SELECT MID, DATE_TIME, ER, Q1, ED, Q3, Q2, Q4, ERM, Q1M, EDM, Q3M, Q2M, Q4M, STATUS, NKC, NSOURCE, ER_MTRSN, NSWITCH, DENTER, VQM,nmetertype 
FROM RYDA.HALFHOUROLD WHERE NEXCEPTCALC IS NULL and nsource<0
/

CREATE OR REPLACE VIEW halfhourevid (mid,date_time,er,q1,ed,q3,q2,q4,erm,q1m,edm,q3m,q2m,q4m,status,nkc,denter,vqm )
AS
SELECT MID, DATE_TIME, ER, Q1, ED, Q3, Q2, Q4, ERM, Q1M, EDM, Q3M, Q2M, Q4M, STATUS, NKC, denter, VQM FROM RYDA.HALFHOURold
/


CREATE OR REPLACE VIEW months (mid,date_time,valid,source,remark,er_mtrsn,er_kc,erm,er,aerm,aer,berm,ber,cerm,cer,derm,der,q1_mtrsn,q1_kc,q1m,q1,aq1m,aq1,bq1m,bq1,cq1m,cq1,
dq1m,dq1,ed_mtrsn,ed_kc,edm,ed,aedm,aed,bedm,bed,cedm,ced,dedm,ded,q3_mtrsn,q3_kc,q3m,q3,aq3m,aq3,bq3m,bq3,cq3m,cq3,dq3m,dq3,q2_mtrsn,q2_kc,q2m,q2,aq2m,aq2,bq2m,bq2,cq2m,cq2,
dq2m,dq2,q4_mtrsn,q4_kc,q4m,q4,aq4m,aq4,bq4m,bq4,cq4m,cq4,dq4m,dq4,nwasteabs,nsource,denter )
AS
SELECT MID, DATE_TIME, VALID, SOURCE, REMARK, ER_MTRSN, ER_KC, ERM, ER, AERM, AER, BERM, BER, CERM, CER, DERM, DER, Q1_MTRSN, Q1_KC, Q1M, Q1, AQ1M, AQ1, BQ1M, BQ1, CQ1M, CQ1,
 DQ1M, DQ1, ED_MTRSN, ED_KC, EDM, ED, AEDM, AED, BEDM, BED, CEDM, CED, DEDM, DED, Q3_MTRSN, Q3_KC, Q3M, Q3, AQ3M, AQ3, BQ3M, BQ3, CQ3M, CQ3, DQ3M, DQ3, Q2_MTRSN, Q2_KC, Q2M,
 Q2, AQ2M, AQ2, BQ2M, BQ2, CQ2M, CQ2, DQ2M, DQ2, Q4_MTRSN, Q4_KC, Q4M, Q4, AQ4M, AQ4, BQ4M, BQ4, CQ4M, CQ4, DQ4M, DQ4, NWASTEABS, nsource, DENTER FROM MONTHSORG
/

CREATE OR REPLACE VIEW monthsevid (mid,date_time,valid,source,remark,er_mtrsn,er_kc,erm,er,aerm,aer,berm,ber,cerm,cer,derm,der,q1_mtrsn,q1_kc,q1m,q1,aq1m,aq1,bq1m,bq1,cq1m,cq1,dq1m,dq1,ed_mtrsn,
ed_kc,edm,ed,aedm,aed,bedm,bed,cedm,ced,dedm,ded,q3_mtrsn,q3_kc,q3m,q3,aq3m,aq3,bq3m,bq3,cq3m,cq3,dq3m,dq3,q2_mtrsn,q2_kc,q2m,q2,aq2m,aq2,bq2m,bq2,cq2m,cq2,dq2m,dq2,q4_mtrsn,q4_kc,
q4m,q4,aq4m,aq4,bq4m,bq4,cq4m,cq4,dq4m,dq4,denter )
AS SELECT MID, DATE_TIME, VALID, SOURCE, REMARK, ER_MTRSN, ER_KC, ERM, ER, AERM, AER, BERM, BER, CERM, CER, DERM, DER, Q1_MTRSN,
 Q1_KC, Q1M, Q1, AQ1M, AQ1, BQ1M, BQ1, CQ1M, CQ1, DQ1M, DQ1, ED_MTRSN, ED_KC, EDM, ED, AEDM, AED, BEDM, BED, CEDM, CED, DEDM, DED, Q3_MTRSN, Q3_KC, Q3M, Q3, AQ3M, AQ3, BQ3M, BQ3,
 CQ3M, CQ3, DQ3M, DQ3, Q2_MTRSN, Q2_KC, Q2M, Q2, AQ2M, AQ2, BQ2M, BQ2, CQ2M, CQ2, DQ2M, DQ2, Q4_MTRSN, Q4_KC, Q4M, Q4, AQ4M, AQ4, BQ4M, BQ4, CQ4M, CQ4, DQ4M, DQ4, denter FROM RYDA.MONTHSORG
/

CREATE OR REPLACE VIEW profileevid (mid,date_time,er,q1,ed,q3,q2,q4,freq,cosf,volt,currento,volt2,volt3,curr2,curr3,erm,q1m,edm,q3m,q2m,q4m,denter,nsource,vqm )
AS
SELECT MID, DATE_TIME, ER, Q1, ED, Q3, Q2, Q4, FREQ, COSF, VOLT, CURRENTO, VOLT2, VOLT3, CURR2, CURR3, ERM, Q1M, EDM, Q3M, Q2M, Q4M, denter, nsource ,vqm
FROM RYDA.PROFILE
/

CREATE OR REPLACE VIEW bill_for_term (date_time,p1name,p2name,mid,er,q1,ed,q3,q2,q4,erm,q1m,edm,q3m,q2m,q4m,aer,aq1,aed,aq3,aq2,aq4,aerm,aq1m,aedm,aq3m,aq2m,aq4m,
ber,bq1,bed,bq3,bq2,bq4,berm,bq1m,bedm,bq3m,bq2m,bq4m,cer,cq1,ced,cq3,cq2,cq4,cerm,cq1m,cedm,cq3m,cq2m,cq4m,der,dq1,ded,dq3,dq2,dq4,derm,dq1m,dedm,dq3m,dq2m,dq4m,kc,er_mtrsn,denter )
AS
select b.date_time  		,p1.Name p1Name, p2.Name p2Name, b.mid,b.er, b.q1, b.ed, b.q3, b.q2, b.q4, b.erm, b.q1m, b.edm, b.q3m, b.q2m, b.q4m,
b.aer, b.aq1, b.aed, b.aq3, b.aq2, b.aq4, b.aerm, b.aq1m, b.aedm, b.aq3m, b.aq2m, b.aq4m,b.ber, b.bq1, b.bed, b.bq3, b.bq2, b.bq4, b.berm, b.bq1m, b.bedm, b.bq3m, b.bq2m, b.bq4m
,b.cer, b.cq1, b.ced, b.cq3, b.cq2, b.cq4, b.cerm, b.cq1m, b.cedm, b.cq3m, b.cq2m, b.cq4m,b.der, b.dq1, b.ded, b.dq3, b.dq2, b.dq4, b.derm, b.dq1m, b.dedm, b.dq3m, b.dq2m, b.dq4m
,f.kc, b.er_mtrsn,b.denter
from
  billevid b, points p1, points p2, feeders f
where f.mid=p2.mid(+) and p2.parent=p1.mid(+) and f.mid=b.mid
/

CREATE OR REPLACE VIEW month_for_term (date_time,p1name,p2name,mid,er,q1,ed,q3,q2,q4,erm,q1m,edm,q3m,q2m,q4m,aer,aq1,aed,aq3,aq2,aq4,aerm,aq1m,aedm,aq3m,aq2m,aq4m,ber,bq1,
bed,bq3,bq2,bq4,berm,bq1m,bedm,bq3m,bq2m,bq4m,cer,cq1,ced,cq3,cq2,cq4,cerm,cq1m,cedm,cq3m,cq2m,cq4m,der,dq1,ded,dq3,dq2,dq4,derm,dq1m,dedm,dq3m,dq2m,dq4m,kc,er_mtrsn,denter )
AS
select
b.date_time  		,p1.Name p1Name, p2.Name p2Name, b.mid,b.er, b.q1, b.ed, b.q3, b.q2, b.q4, b.erm, b.q1m, b.edm, b.q3m, b.q2m, b.q4m,b.aer, b.aq1, b.aed, b.aq3, 
b.aq2, b.aq4, b.aerm, b.aq1m, b.aedm, b.aq3m, b.aq2m, b.aq4m,b.ber, b.bq1, b.bed, b.bq3, b.bq2, b.bq4, b.berm, b.bq1m, b.bedm, b.bq3m, b.bq2m, b.bq4m,
b.cer, b.cq1, b.ced, b.cq3, b.cq2, b.cq4, b.cerm, b.cq1m, b.cedm, b.cq3m, b.cq2m, b.cq4m,b.der, b.dq1, b.ded, b.dq3, b.dq2, b.dq4, b.derm, b.dq1m, b.dedm, b.dq3m, b.dq2m, b.dq4m,
f.kc, b.er_mtrsn, b.denter
from
  monthsevid b, points p1, points p2, feeders f
where f.mid=p2.mid(+) and p2.parent=p1.mid(+) and f.mid=b.mid
/

-- Grants for Function
GRANT EXECUTE ON sumqm TO askue_work
/

DECLARE
BEGIN
 FOR lc IN (SELECT 'grant select on ' || table_name || ' to ASKUE_WORK' c
              FROM user_tables WHERE table_name NOT IN ('USERPASS')
            UNION ALL
            SELECT 'grant select on ' || view_name || ' to ASKUE_WORK' c
              FROM user_views
            UNION ALL
            SELECT 'grant execute on ' || object_name || ' to ASKUE_WORK' c
              FROM user_objects
             WHERE object_type = 'PROCEDURE'
            UNION ALL
            SELECT 'grant execute on ' || object_name || ' to ASKUE_WORK' c
              FROM user_objects
             WHERE object_type = 'FUNCTION'
            UNION ALL
            SELECT 'grant execute on ' || object_name || ' to ASKUE_WORK' c
              FROM user_objects
             WHERE object_type = 'PACKAGE') LOOP
  BEGIN
   EXECUTE IMMEDIATE lc.c;
  EXCEPTION
   WHEN OTHERS THEN
    NULL;
  END;
 END LOOP;
END;
/
----------------------------------------------------------------------------------------------
--         VER 2.27.1  (Для обновления версии 2.27 до текущей скрипт запускать отсюда)        --
----------------------------------------------------------------------------------------------
--16.10.2008

CREATE OR REPLACE TRIGGER journal_tr1
 AFTER
  INSERT
 ON journal
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
BEGIN
 INSERT INTO journallast
             (mid, date_time, state_cod, state_descr,nevent,vcode)
      VALUES (:NEW.mid, :NEW.date_time, :NEW.state_cod, :NEW.state_descr,:NEW.nevent,:NEW.vcode);
END;
/

begin
INSERT INTO metertype("NMETERTYPE","VNAME")VALUES(14,'LG ZxB');
INSERT INTO metertype("NMETERTYPE","VNAME")VALUES(15,'Энергия  упрощенная');
INSERT INTO metertype("NMETERTYPE","VNAME")VALUES(16,'Макет');
INSERT INTO metertype("NMETERTYPE","VNAME")VALUES(17,'Альфа');
INSERT INTO metertype("NMETERTYPE","VNAME")VALUES(18,'Метком');
INSERT INTO metertype("NMETERTYPE","VNAME")VALUES(19,'RTU');
INSERT INTO metertype("NMETERTYPE","VNAME")VALUES(21,'Облик');
INSERT INTO metertype("NMETERTYPE","VNAME")VALUES(22,'Меркурий');
commit;
exception when others then null;
end;
/


begin
update METEREVENTSDICT set VEVENTTEXT=VEVENTTEXT||'_'||nevent 
where (nmetertype,VEVENTTEXT) in
(select nmetertype,VEVENTTEXT from METEREVENTSDICT
group by nmetertype,VEVENTTEXT
having count(*)>1);
commit;
end;
/

begin
execute immediate 'create unique index METEREVENTSDICT_IDX2 on METEREVENTSDICT ( NMETERTYPE ASC, VEVENTTEXT ASC)';
exception
when others then null;
end;
/


/*==============================================================*/
/* Table: BASEFORMULA                                           */
/*==============================================================*/
drop table BASEFORMULA;
drop table BASEFUNCTION;
/*==============================================================*/
/* Table: BASEFORMULA                                           */
/*==============================================================*/
create table BASEFORMULA  (
   NID                  NUMBER(10)                      not null,
   NPARENT              NUMBER(10),
   NTYPE                NUMBER(1)                      default 0 not null
      constraint CKC_NTYPE_BASEFORM check (NTYPE in (0,1,2)),
   VNAME                VARCHAR2(128)                   not null,
   VFORMULA             VARCHAR2(2000),
   VMEMO                VARCHAR2(2000),
   constraint PK_BASEFORMULA primary key (NID)
);

comment on table BASEFORMULA is
'Базовые формулы';

comment on column BASEFORMULA.NID is
'Ид формулы';

comment on column BASEFORMULA.NPARENT is
'Ид родителя';

comment on column BASEFORMULA.NTYPE is
'Тип';

comment on column BASEFORMULA.VNAME is
'Название';

comment on column BASEFORMULA.VFORMULA is
'Формула';

comment on column BASEFORMULA.VMEMO is
'Примечание';

/*==============================================================*/
/* Index: BASEFORMULA_IDX1                                      */
/*==============================================================*/
create unique index BASEFORMULA_IDX1 on BASEFORMULA (
   NPARENT ASC,
   VNAME ASC
);

alter table BASEFORMULA
   add constraint BASEFORMULA_F2 foreign key (NPARENT)
      references BASEFORMULA (NID)
      on delete cascade;

/*==============================================================*/
/* Table: BASEFORMULPARAMS                                      */
/*==============================================================*/
create table BASEFORMULPARAMS  (
   NID                  NUMBER(10)                      not null,
   NORDER               NUMBER(10)                      not null,
   VNAME                VARCHAR2(16)                    not null,
   VPARAM               VARCHAR2(32)                    not null,
   VMEMO                VARCHAR2(128),
   constraint PK_BASEFORMULPARAMS primary key (NID, NORDER)
);

comment on table BASEFORMULPARAMS is
'Параметры базовой формулы';

comment on column BASEFORMULPARAMS.NID is
'Ид формулы';

comment on column BASEFORMULPARAMS.NORDER is
'Порядок';

comment on column BASEFORMULPARAMS.VNAME is
'Обозначение';

comment on column BASEFORMULPARAMS.VPARAM is
'Параметр';

comment on column BASEFORMULPARAMS.VMEMO is
'Назначение';

alter table BASEFORMULPARAMS
   add constraint BASEFORMULPARAMS_F1 foreign key (NID)
      references BASEFORMULA (NID)
      on delete cascade;


/*==============================================================*/
/* Table: POINTFORMULA                                          */
/*==============================================================*/
create table POINTFORMULA  (
   NID                  NUMBER(10)                      not null,
   MID                  NUMBER                          not null,
   NMEAS                NUMBER(1)                      default 0 not null
      constraint CKC_NMEAS_POINTFOR check (NMEAS in (0,1,2,3,4,5,6)),
   VFORMULA             VARCHAR2(2000)                  not null,
   VMEMO                VARCHAR2(2000),
   NORDER               NUMBER(10),
   constraint PK_POINTFORMULA primary key (NID)
);

comment on table POINTFORMULA is
'Дорасчетные формулы';

comment on column POINTFORMULA.NID is
'Ид формулы';

comment on column POINTFORMULA.MID is
'Ид точки';

comment on column POINTFORMULA.NMEAS is
'Тип измерения';

comment on column POINTFORMULA.VFORMULA is
'Формула';

comment on column POINTFORMULA.VMEMO is
'Примечание';

comment on column POINTFORMULA.NORDER is
'Порядок';

/*==============================================================*/
/* Index: POINTFORMULA_IDX1                                     */
/*==============================================================*/
create unique index POINTFORMULA_IDX1 on POINTFORMULA (
   MID ASC,
   NMEAS ASC
);

/*==============================================================*/
/* Index: POINTFORMULA_IDX2                                     */
/*==============================================================*/
create index POINTFORMULA_IDX2 on POINTFORMULA (
   NORDER ASC
);

alter table POINTFORMULA
   add constraint POINTFORMULA_F1 foreign key (MID)
      references POINTS (MID)
      on delete cascade;
/*==============================================================*/
/* Table: FORMULPARAMS                                          */
/*==============================================================*/
create table FORMULPARAMS  (
   NID                  NUMBER(10)                      not null,
   NORDER               NUMBER(10)                      not null,
   VNAME                VARCHAR2(16)                    not null,
   VPARAM               VARCHAR2(32)                    not null,
   VMEMO                VARCHAR2(128),
   constraint PK_FORMULPARAMS primary key (NID, NORDER)
);

comment on table FORMULPARAMS is
'Параметры формулы';

comment on column FORMULPARAMS.NID is
'Ид формулы';

comment on column FORMULPARAMS.NORDER is
'Порядок';

comment on column FORMULPARAMS.VNAME is
'Обозначение';

comment on column FORMULPARAMS.VPARAM is
'Параметр';

comment on column FORMULPARAMS.VMEMO is
'Назначение';

alter table FORMULPARAMS
   add constraint FORMULPARAMS_F1 foreign key (NID)
      references POINTFORMULA (NID)
      on delete cascade
/      

declare
ln_1 NUMBER;
ln_2 NUMBER;
begin
select points_seq.NEXTVAL into ln_1 from dual;
select points_seq.NEXTVAL into ln_2 from dual;
insert into BASEFORMULA(nid,nparent,ntype,vname,vformula,vmemo) values(ln_1,NULL,0,'Базовые формулы','','В данной папке содержатся базовые формулы');
insert into BASEFORMULA(nid,nparent,ntype,vname,vformula,vmemo) values(points_seq.NEXTVAL,ln_1,0,'Расчет потерь в двухобмоточном тр-ре','if(Pf>Pxx, (sqrt(Pf^2+Qf^2)/Sn)^2*Pkz, if ((Pf>0)&(Pf<=Pxx), Pxx, 0))','Формула расчета потерь в двухобмоточном тр-ре');
insert into BASEFORMULA(nid,nparent,ntype,vname,vformula,vmemo) values(ln_2,NULL,0,'Базовые функции','','В данной папке содержатся базовые функции');
insert into BASEFORMULA(nid,nparent,ntype,vname,vformula,vmemo) values(points_seq.NEXTVAL,ln_2,0,'модуль (абсолютное значение)','abs','');
insert into BASEFORMULA(nid,nparent,ntype,vname,vformula,vmemo) values(points_seq.NEXTVAL,ln_2,0,'арккосинус','acos','');
insert into BASEFORMULA(nid,nparent,ntype,vname,vformula,vmemo) values(points_seq.NEXTVAL,ln_2,0,'арксинус','asin','');
insert into BASEFORMULA(nid,nparent,ntype,vname,vformula,vmemo) values(points_seq.NEXTVAL,ln_2,0,'арктангенс','atan','');
insert into BASEFORMULA(nid,nparent,ntype,vname,vformula,vmemo) values(points_seq.NEXTVAL,ln_2,0,'среднее','avg','');
insert into BASEFORMULA(nid,nparent,ntype,vname,vformula,vmemo) values(points_seq.NEXTVAL,ln_2,0,'преобразование двоичного формата в десятичный','bin','');
insert into BASEFORMULA(nid,nparent,ntype,vname,vformula,vmemo) values(points_seq.NEXTVAL,ln_2,0,'округление в бОльшую сторону','ceil','');
insert into BASEFORMULA(nid,nparent,ntype,vname,vformula,vmemo) values(points_seq.NEXTVAL,ln_2,0,'косинус','cos','');
insert into BASEFORMULA(nid,nparent,ntype,vname,vformula,vmemo) values(points_seq.NEXTVAL,ln_2,0,'гиперболический косинус','cosh','');
insert into BASEFORMULA(nid,nparent,ntype,vname,vformula,vmemo) values(points_seq.NEXTVAL,ln_2,0,'дата date(y,m,d)','date','');
insert into BASEFORMULA(nid,nparent,ntype,vname,vformula,vmemo) values(points_seq.NEXTVAL,ln_2,0,'преобразование текстового представления даты в численное','datevalue','');
insert into BASEFORMULA(nid,nparent,ntype,vname,vformula,vmemo) values(points_seq.NEXTVAL,ln_2,0,'факториал','fact','');
insert into BASEFORMULA(nid,nparent,ntype,vname,vformula,vmemo) values(points_seq.NEXTVAL,ln_2,0,'округление в меньшую сторону','floor','');
insert into BASEFORMULA(nid,nparent,ntype,vname,vformula,vmemo) values(points_seq.NEXTVAL,ln_2,0,'преобразование 16-ричного числа в десятиричное','hex','');
insert into BASEFORMULA(nid,nparent,ntype,vname,vformula,vmemo) values(points_seq.NEXTVAL,ln_2,0,'условие if(условие, выраж_истина, выраж_ложь) )','if','');
insert into BASEFORMULA(nid,nparent,ntype,vname,vformula,vmemo) values(points_seq.NEXTVAL,ln_2,0,'возвращает 1 если число определено, если число NaN, то возвращает 0','isFinite','');
insert into BASEFORMULA(nid,nparent,ntype,vname,vformula,vmemo) values(points_seq.NEXTVAL,ln_2,0,'возвращает 1 если число равно NaN, иначе 0','isNaN','');
insert into BASEFORMULA(nid,nparent,ntype,vname,vformula,vmemo) values(points_seq.NEXTVAL,ln_2,0,'натуральный логарифм','log','');
insert into BASEFORMULA(nid,nparent,ntype,vname,vformula,vmemo) values(points_seq.NEXTVAL,ln_2,0,'десятичный логарифм','log10','');
insert into BASEFORMULA(nid,nparent,ntype,vname,vformula,vmemo) values(points_seq.NEXTVAL,ln_2,0,'максимум','max','');
insert into BASEFORMULA(nid,nparent,ntype,vname,vformula,vmemo) values(points_seq.NEXTVAL,ln_2,0,'минимум','min','');
insert into BASEFORMULA(nid,nparent,ntype,vname,vformula,vmemo) values(points_seq.NEXTVAL,ln_2,0,'возвращает сегдняшнюю дату','nowdate','');
insert into BASEFORMULA(nid,nparent,ntype,vname,vformula,vmemo) values(points_seq.NEXTVAL,ln_2,0,'возвращает текущее время','nowtime','');
insert into BASEFORMULA(nid,nparent,ntype,vname,vformula,vmemo) values(points_seq.NEXTVAL,ln_2,0,'случайное число rand(min, max)','rand','');
insert into BASEFORMULA(nid,nparent,ntype,vname,vformula,vmemo) values(points_seq.NEXTVAL,ln_2,0,'синус','sin','');
insert into BASEFORMULA(nid,nparent,ntype,vname,vformula,vmemo) values(points_seq.NEXTVAL,ln_2,0,'гиперболический синус','sinh','');
insert into BASEFORMULA(nid,nparent,ntype,vname,vformula,vmemo) values(points_seq.NEXTVAL,ln_2,0,'вычисление выражения','solve','');
insert into BASEFORMULA(nid,nparent,ntype,vname,vformula,vmemo) values(points_seq.NEXTVAL,ln_2,0,'квадратный корень','sqrt','');
insert into BASEFORMULA(nid,nparent,ntype,vname,vformula,vmemo) values(points_seq.NEXTVAL,ln_2,0,'сумма аргументов функции','sum','');
insert into BASEFORMULA(nid,nparent,ntype,vname,vformula,vmemo) values(points_seq.NEXTVAL,ln_2,0,'тангенс','tan','');
insert into BASEFORMULA(nid,nparent,ntype,vname,vformula,vmemo) values(points_seq.NEXTVAL,ln_2,0,'время time(h,m,s)','time','');
insert into BASEFORMULA(nid,nparent,ntype,vname,vformula,vmemo) values(points_seq.NEXTVAL,ln_2,0,'преобразование текстового представления времени в численное','timevalue','');
insert into BASEFORMULA(nid,nparent,ntype,vname,vformula,vmemo) values(points_seq.NEXTVAL,ln_2,0,'возвращает номер дня недели weekday(date_value) 1..7','weekday','');
insert into BASEFORMULA(nid,nparent,ntype,vname,vformula,vmemo) values(points_seq.NEXTVAL,ln_2,0,'возвращает номер дня в году','yearday','');
commit;
end;
/

update baseformula set VMEMO=vname where vmemo is null;
update baseformula set ntype=1 where nparent=(select max(nid) from baseformula where vname='Базовые формулы');
update baseformula set ntype=2 where nparent=(select max(nid) from baseformula where vname='Базовые функции');
commit;

insert into CALCPOINTTYPE(NCALCPOINTTYPE,VNAME) values(6,'Расчет по формуле');
commit;


----------------------------------------------------------------------------------------------
--         VER 2.27.2  (Для обновления версии 2.27 до текущей скрипт запускать отсюда)        --
----------------------------------------------------------------------------------------------

begin
INSERT INTO metertype("NMETERTYPE","VNAME")VALUES(23,'Результат расчета');
INSERT INTO metertype("NMETERTYPE","VNAME")VALUES(24,'АСКУЭ ИНЭТ');
INSERT INTO metertype("NMETERTYPE","VNAME")VALUES(25,'АСКУЭ Energovision');
INSERT INTO metertype("NMETERTYPE","VNAME")VALUES(26,'ICCP');
INSERT INTO metertype("NMETERTYPE","VNAME")VALUES(27,'УППД (энергорынок)');
commit;
exception when others then null;
end;
/

drop view BILLEVID;
drop view HALFHOUREVID;
drop view MONTHSEVID;
drop view PROFILEEVID;
drop view MONTH_FOR_TERM;
drop view BILL_FOR_TERM;

CREATE OR REPLACE LIBRARY PARSER
 IS 'Parser.dll'
/


declare
l NUMBER;
begin
select nvl(max(decode(vvalue,'1',2,'10',1,0)),0) into l from parameter where NPID=12;
insert into parameter (NPID,VVALUE,VDESCRIPTION) values(42,l,'Тип учета инверсии на точке учета. 1-условная, 2-всегда инвертировать, иначе никогда');
commit;
end;
/

ALTER table MEASURES  ADD(
   VCODE                VARCHAR2(16)                    
);
comment on column MEASURES.VCODE is
'Код измерения';

insert into measures(nmeasure, vname) values(0,'Автоматически определяемое');
update MEASURES set vcode='ER' where NMEASURE=1;
update MEASURES set vcode='ED' where NMEASURE=2;
update MEASURES set vcode='Q1' where NMEASURE=3;
update MEASURES set vcode='Q2' where NMEASURE=4;
update MEASURES set vcode='Q3' where NMEASURE=5;
update MEASURES set vcode='Q4' where NMEASURE=6;
update MEASURES set vcode='A' where NMEASURE=0;

ALTER table MEASURES  MODIFY(VCODE not null);

update METEREVENTSDICT set NVALIDITY=0;
alter table METEREVENTSDICT  modify(   NVALIDITY            NUMBER                         default 0 not null);

----------------------------------------------------------------------------------------------
--         VER 2.27.3  (Для обновления версии 2.27.2 до текущей скрипт запускать отсюда)        --
----------------------------------------------------------------------------------------------
ALTER TABLE MEASURES 
 MODIFY (
  VNAME VARCHAR2 (64)

 )
/

BEGIN
DELETE FROM MEASURES;
INSERT INTO MEASURES("NMEASURE","VNAME","VCODE")VALUES(1,'ER (Актив, прием)','ER');
INSERT INTO MEASURES("NMEASURE","VNAME","VCODE")VALUES(2,'ED (Актив, отдача)','ED');
INSERT INTO MEASURES("NMEASURE","VNAME","VCODE")VALUES(3,'Q1 (Реактив, прием)','Q1');
INSERT INTO MEASURES("NMEASURE","VNAME","VCODE")VALUES(5,'Q3 (Реактив, генерц)','Q3');
INSERT INTO MEASURES("NMEASURE","VNAME","VCODE")VALUES(4,'Q2','Q2');
INSERT INTO MEASURES("NMEASURE","VNAME","VCODE")VALUES(6,'Q4','Q4');
INSERT INTO MEASURES("NMEASURE","VNAME","VCODE")VALUES(7,'R+ (Q1+Q2)','Q12');
INSERT INTO MEASURES("NMEASURE","VNAME","VCODE")VALUES(0,'Автоматически определяемое','A');
INSERT INTO MEASURES("NMEASURE","VNAME","VCODE")VALUES(8,'R- (Q3+Q4)','Q34');
INSERT INTO MEASURES("NMEASURE","VNAME","VCODE")VALUES(9,'E (ER-ED) Факт. небаланс','E');
INSERT INTO MEASURES("NMEASURE","VNAME","VCODE")VALUES(10,'Q (Q1-Q3)+(Q2-Q4)','Q');
INSERT INTO MEASURES("NMEASURE","VNAME","VCODE")VALUES(16,'Номинальная мощность трансф-ра','Sn');
INSERT INTO MEASURES("NMEASURE","VNAME","VCODE")VALUES(17,'DPxx - Потери актив мощн в стали тр','DPxx');
INSERT INTO MEASURES("NMEASURE","VNAME","VCODE")VALUES(18,'DPkz - Потери актив мощн в меди обмоток','DPkz');
INSERT INTO MEASURES("NMEASURE","VNAME","VCODE")VALUES(19,'Ixx - Ток холостого хода трансф','Ixx');
INSERT INTO MEASURES("NMEASURE","VNAME","VCODE")VALUES(20,'Ukz - Напр короткого замыкания','Ukz');
INSERT INTO MEASURES("NMEASURE","VNAME","VCODE")VALUES(21,'Tn - Кол-во часов работы трансф','Tn');
INSERT INTO MEASURES("NMEASURE","VNAME","VCODE")VALUES(22,'Tp - Кол-во часов работы тр под нагр','Tp');
INSERT INTO MEASURES("NMEASURE","VNAME","VCODE")VALUES(23,'SBH - Мощность обмотки ВН','SBH');
INSERT INTO MEASURES("NMEASURE","VNAME","VCODE")VALUES(24,'SCH - Мощность обмотки СН','SCH');
INSERT INTO MEASURES("NMEASURE","VNAME","VCODE")VALUES(25,'SHH - Мощность обмотки НН','SHH');
INSERT INTO MEASURES("NMEASURE","VNAME","VCODE")VALUES(26,'DPBH - Потери мощн в меди обм ВН','DPBH');
INSERT INTO MEASURES("NMEASURE","VNAME","VCODE")VALUES(27,'DPCH - Потери мощн в меди обм СН','DPCH');
INSERT INTO MEASURES("NMEASURE","VNAME","VCODE")VALUES(28,'DPHH - Потери мощн в меди обм НН','DPHH');
INSERT INTO MEASURES("NMEASURE","VNAME","VCODE")VALUES(29,'UBH_CH - Напр-е обмотки ВН-СН','UBH_CH');
INSERT INTO MEASURES("NMEASURE","VNAME","VCODE")VALUES(30,'UCH_HH - Напр-е обмотки СН-НН','UCH_HH');
INSERT INTO MEASURES("NMEASURE","VNAME","VCODE")VALUES(31,'UBH_HH - Напр-е обмотки ВН-НН','UBH_HH');
INSERT INTO MEASURES("NMEASURE","VNAME","VCODE")VALUES(32,'L - Длина линии','L');
INSERT INTO MEASURES("NMEASURE","VNAME","VCODE")VALUES(33,'r0 - Удельное актив сопрот-е линии','r0');
INSERT INTO MEASURES("NMEASURE","VNAME","VCODE")VALUES(34,'x0 - Удельное реактив сопрот-е линии','x0');
INSERT INTO MEASURES("NMEASURE","VNAME","VCODE")VALUES(35,'Un - Номинальное напряжение линии','Un');
INSERT INTO MEASURES("NMEASURE","VNAME","VCODE")VALUES(12,'Допустимый небаланс','ADBALANCE');
INSERT INTO MEASURES("NMEASURE","VNAME","VCODE")VALUES(11,'Фактический небаланс %','BALANCEP');
INSERT INTO MEASURES("NMEASURE","VNAME","VCODE")VALUES(13,'Допустимый небаланс %','ADBALANCEP');
INSERT INTO MEASURES("NMEASURE","VNAME","VCODE")VALUES(14,'Доп небал - Факт небал','BALANCEDIF');
INSERT INTO MEASURES("NMEASURE","VNAME","VCODE")VALUES(15,'Доп небал - Факт небал %','BALANCEDIFP');
COMMIT;
END;
/


----------27.10.2008
begin
INSERT INTO points(MID,PARENT,COD,IND,NAME,SHORT_NAME,PTYPE,IMPLEMENT_DATE,TAG,NPOINT) VALUES(53,NULL,NULL,1,'Подсистема диагностики','',NULL,'',NULL,NULL);
commit;
end;
/

alter table JOURNAL  add(
   DENTER               DATE                           
);

alter table JOURNAL  modify(
   DENTER               default SYSDATE
);


drop index CONNECTIONPARAM_IDX2;

create index CONNECTIONPARAM_IDX2 on CONNECTIONPARAM (
   MID ASC,
   NWINDING ASC
);


begin
delete from tasks where task_cod=11;
commit;
end;
/

drop table EXPORT_GROUPS;
drop table EXPORT_BILL;
drop table EXPORT_HOUR;
drop table EXPORT_PROF;
drop package EDITEXPORTGROUP_PG;
drop package EXPORT_PG;

begin
execute immediate 'drop package WEBCLIENT2_PG'; 
exception when others then null;
end;
/


declare
ln_1 NUMBER;
begin
select max(nid) into ln_1 from BASEFORMULA where vname='Базовые формулы';
INSERT INTO baseformula("NID","NPARENT","NTYPE","VNAME","VFORMULA","VMEMO")VALUES(points_seq.NEXTVAL,ln_1,1,'Расчет потерь реактивное электроенергии в двухобмоточном тр-ре','if(WQf>(Sn*(Ixx/100))*0.5, (Sn*(Ixx/100))*0.5+(sqrt((WPf/0.5)^2+(WQf/0.5)^2)/Sn)^2*(Sn*(Ukz/100))*0.5, if ((WQf>0)&(WQf<=(Sn*(Ixx/100))*0.5), (Sn*(Ixx/100))*0.5, 0))','Формула расчета потерь реактивное электроенергии в двухобмоточном тр-ре');
INSERT INTO baseformula("NID","NPARENT","NTYPE","VNAME","VFORMULA","VMEMO")VALUES(points_seq.NEXTVAL,ln_1,1,'Расчет потерь активной электроэнергии в трехобмоточном тр-ре','if(WPf>DPxx*0.5, DPxx*0.5+(DPBH*((sqrt(((WPCH+WPHH)/0.5)^2+((WQCH+WQHH)/0.5)^2)/SBH)^2)+DPCH*((sqrt((WPCH/0.5)^2+(WQCH/0.5)^2)/SCH)^2)+DPHH*((sqrt((WPHH/0.5)^2+(WQHH/0.5)^2)/SHH)^2))*0.5, if ((WPf>0)&(WPf<=DPxx*0.5), DPxx*0.5, 0))','Формула расчета потерь активной электроэнергии в трехобмоточном тр-ре');
INSERT INTO baseformula("NID","NPARENT","NTYPE","VNAME","VFORMULA","VMEMO")VALUES(points_seq.NEXTVAL,ln_1,1,'Расчет потерь реактивной электроэнергии в трехобмоточном тр-ре','if(WQf>(Sn*(Ixx/100))*0.5, (Sn*(Ixx/100))*0.5+((SBH*0.5*(UBH_CH+UBH_HH-UCH_HH)/100)*((sqrt(((WPCH+WPHH)/0.5)^2+((WQCH+WQHH)/0.5)^2)/SBH)^2)+(SCH*0.5*(UBH_CH+UCH_HH-UBH_HH)/100)*((sqrt((WPCH/0.5)^2+(WQCH/0.5)^2)/SCH)^2)+(SHH*0.5*(UBH_HH+UCH_HH-UBH_CH)/100)*((sqrt((WPHH/0.5)^2+(WQHH/0.5)^2)/SHH)^2))*0.5, if ((WQf>0)&(WQf<=(Sn*(Ixx/100))*0.5), (Sn*(Ixx/100))*0.5, 0))','Формула расчета потерь реактивной электроэнергии в трехобмоточном тр-ре');
INSERT INTO baseformula("NID","NPARENT","NTYPE","VNAME","VFORMULA","VMEMO")VALUES(points_seq.NEXTVAL,ln_1,1,'Расчет потерь активной электроенергии в линии','(WP^2+WQ^2)/(Un^2*0.5)*r0*L*10^-3','Формула расчета потерь активной электроенергии в линии');
INSERT INTO baseformula("NID","NPARENT","NTYPE","VNAME","VFORMULA","VMEMO")VALUES(points_seq.NEXTVAL,ln_1,1,'Расчет потерь реактивной электроенергии в линии','(WP^2+WQ^2)/(Un^2*0.5)*x0*L*10^-3','Формула расчета потерь реактивной электроенергии в линии');
INSERT INTO baseformula("NID","NPARENT","NTYPE","VNAME","VFORMULA","VMEMO")VALUES(points_seq.NEXTVAL,ln_1,1,'Расчет потерь активное электроенергии в двухобмоточном тр-ре','if(WPf>DPxx*0.5, DPxx*0.5+(sqrt((WPf/0.5)^2+(WQf/0.5)^2)/Sn)^2*DPkz*0.5, if ((WPf>0)&(WPf<=DPxx*0.5), DPxx*0.5, 0))','Формула расчета потерь в двухобмоточном тр-ре');
commit;
end;
/

begin
INSERT INTO tasks("TASK_ID","PARENT","TASK_COD","NAME","REMARK","NSHOW")VALUES(22,16,49,'2.5 Редактирование трансформаторов','Редактирование трансформаторов',1);
insert into role_task select distinct ROLE_ID,22,1 from users where ADMIN='*';
commit;
exception
when others then null;
END;
/

--06/11/2008
----------------------------------------------------------------------------------------------
--         VER 2.27.3  (Для обновления версии 2.27.1 до текущей скрипт запускать отсюда)        --
----------------------------------------------------------------------------------------------
drop table measures;

create table MEASURES  (
   NMEASURE             NUMBER(10)                      not null,
   VNAME                VARCHAR2(64)                    not null,
   VCODE                VARCHAR2(16)                    not null,
   constraint MEASURES_PK primary key (NMEASURE)
);

comment on table MEASURES is
'Измерения';

comment on column MEASURES.NMEASURE is
'Ид измерения';

comment on column MEASURES.VNAME is
'Название измерения';

comment on column MEASURES.VCODE is
'Код измерения';

/*==============================================================*/
/* Index: MEASURES_IDX1                                         */
/*==============================================================*/
create unique index MEASURES_IDX1 on MEASURES (
   VNAME ASC
);

begin
INSERT INTO measures("NMEASURE","VNAME","VCODE")VALUES(1,'ER (Актив, прием)','ER');
INSERT INTO measures("NMEASURE","VNAME","VCODE")VALUES(2,'ED (Актив, отдача)','ED');
INSERT INTO measures("NMEASURE","VNAME","VCODE")VALUES(3,'Q1 (Реактив, прием)','Q1');
INSERT INTO measures("NMEASURE","VNAME","VCODE")VALUES(5,'Q3 (Реактив, генерц)','Q3');
INSERT INTO measures("NMEASURE","VNAME","VCODE")VALUES(4,'Q2','Q2');
INSERT INTO measures("NMEASURE","VNAME","VCODE")VALUES(6,'Q4','Q4');
INSERT INTO measures("NMEASURE","VNAME","VCODE")VALUES(7,'R+ (Q1+Q2)','Q12');
INSERT INTO measures("NMEASURE","VNAME","VCODE")VALUES(0,'Автоматически определяемое','A');
INSERT INTO measures("NMEASURE","VNAME","VCODE")VALUES(8,'R- (Q3+Q4)','Q34');
INSERT INTO measures("NMEASURE","VNAME","VCODE")VALUES(9,'E (ER-ED) Факт. небаланс','E');
INSERT INTO measures("NMEASURE","VNAME","VCODE")VALUES(10,'Q (Q1-Q3)+(Q2-Q4)','Q');
INSERT INTO measures("NMEASURE","VNAME","VCODE")VALUES(16,'Номинальная мощность трансф-ра','Sn');
INSERT INTO measures("NMEASURE","VNAME","VCODE")VALUES(17,'DPxx - Потери актив мощн в стали тр','DPxx');
INSERT INTO measures("NMEASURE","VNAME","VCODE")VALUES(18,'DPkz - Потери актив мощн в меди обмоток','DPkz');
INSERT INTO measures("NMEASURE","VNAME","VCODE")VALUES(19,'Ixx - Ток холостого хода трансф','Ixx');
INSERT INTO measures("NMEASURE","VNAME","VCODE")VALUES(20,'Ukz - Напр короткого замыкания','Ukz');
INSERT INTO measures("NMEASURE","VNAME","VCODE")VALUES(21,'Tn - Кол-во часов работы трансф','Tn');
INSERT INTO measures("NMEASURE","VNAME","VCODE")VALUES(22,'Tp - Кол-во часов работы тр под нагр','Tp');
INSERT INTO measures("NMEASURE","VNAME","VCODE")VALUES(23,'SBH - Мощность обмотки ВН','SBH');
INSERT INTO measures("NMEASURE","VNAME","VCODE")VALUES(24,'SCH - Мощность обмотки СН','SCH');
INSERT INTO measures("NMEASURE","VNAME","VCODE")VALUES(25,'SHH - Мощность обмотки НН','SHH');
INSERT INTO measures("NMEASURE","VNAME","VCODE")VALUES(26,'DPBH - Потери мощн в меди обм ВН','DPBH');
INSERT INTO measures("NMEASURE","VNAME","VCODE")VALUES(27,'DPCH - Потери мощн в меди обм СН','DPCH');
INSERT INTO measures("NMEASURE","VNAME","VCODE")VALUES(28,'DPHH - Потери мощн в меди обм НН','DPHH');
INSERT INTO measures("NMEASURE","VNAME","VCODE")VALUES(29,'UBH_CH - Напр-е обмотки ВН-СН','UBH_CH');
INSERT INTO measures("NMEASURE","VNAME","VCODE")VALUES(30,'UCH_HH - Напр-е обмотки СН-НН','UCH_HH');
INSERT INTO measures("NMEASURE","VNAME","VCODE")VALUES(31,'UBH_HH - Напр-е обмотки ВН-НН','UBH_HH');
INSERT INTO measures("NMEASURE","VNAME","VCODE")VALUES(32,'L - Длина линии','L');
INSERT INTO measures("NMEASURE","VNAME","VCODE")VALUES(33,'r0 - Удельное актив сопрот-е линии','r0');
INSERT INTO measures("NMEASURE","VNAME","VCODE")VALUES(34,'x0 - Удельное реактив сопрот-е линии','x0');
INSERT INTO measures("NMEASURE","VNAME","VCODE")VALUES(35,'Un - Номинальное напряжение линии','Un');
INSERT INTO measures("NMEASURE","VNAME","VCODE")VALUES(12,'Допустимый небаланс','ADBALANCE');
INSERT INTO measures("NMEASURE","VNAME","VCODE")VALUES(11,'Фактический небаланс %','BALANCEP');
INSERT INTO measures("NMEASURE","VNAME","VCODE")VALUES(13,'Допустимый небаланс %','ADBALANCEP');
INSERT INTO measures("NMEASURE","VNAME","VCODE")VALUES(14,'Доп небал - Факт небал','BALANCEDIF');
INSERT INTO measures("NMEASURE","VNAME","VCODE")VALUES(15,'Доп небал - Факт небал %','BALANCEDIFP');
commit;
end;
/

/*==============================================================*/
/* Table: OBJTYPEMEAS                                           */
/*==============================================================*/
create table OBJTYPEMEAS  (
   IND                  NUMBER(10)                      not null,
   NMEASURE             NUMBER(10)                      not null,
   constraint PK_OBJTYPEMEAS primary key (IND, NMEASURE)
);

comment on table OBJTYPEMEAS is
'Измерения типов объектов';

comment on column OBJTYPEMEAS.IND is
'Ид типа объекта';

comment on column OBJTYPEMEAS.NMEASURE is
'Ид измерения';

/*==============================================================*/
/* Index: OBJTYPEMEAS_IDX1                                      */
/*==============================================================*/
create index OBJTYPEMEAS_IDX1 on OBJTYPEMEAS (
   NMEASURE ASC
);

alter table OBJTYPEMEAS
   add constraint OBJTYPEMEAS_F1 foreign key (IND)
      references DICT_OBJ_TYPES (IND)
      on delete cascade;

alter table OBJTYPEMEAS
   add constraint OBJTYPEMEAS_F2 foreign key (NMEASURE)
      references MEASURES (NMEASURE)
      on delete cascade;

begin
INSERT INTO DICT_OBJ_TYPES("IND","VNAME","RT_TYPE")VALUES(11,'Группа учета',11);
INSERT INTO DICT_OBJ_TYPES("IND","VNAME","RT_TYPE")VALUES(12,'Точка в группе учета',12);
commit;
end;
/

begin
insert into OBJTYPEMEAS(ind,nmeasure) values(1,0);
insert into OBJTYPEMEAS(ind,nmeasure) values(1,1);
insert into OBJTYPEMEAS(ind,nmeasure) values(1,2);
insert into OBJTYPEMEAS(ind,nmeasure) values(1,3);
insert into OBJTYPEMEAS(ind,nmeasure) values(1,4);
insert into OBJTYPEMEAS(ind,nmeasure) values(1,5);
insert into OBJTYPEMEAS(ind,nmeasure) values(1,6);
insert into OBJTYPEMEAS(ind,nmeasure) values(1,7);
insert into OBJTYPEMEAS(ind,nmeasure) values(1,8);
insert into OBJTYPEMEAS(ind,nmeasure) values(1,9);
insert into OBJTYPEMEAS(ind,nmeasure) values(1,10);
insert into OBJTYPEMEAS(ind,nmeasure) values(2,0);
insert into OBJTYPEMEAS(ind,nmeasure) values(2,1);
insert into OBJTYPEMEAS(ind,nmeasure) values(2,2);
insert into OBJTYPEMEAS(ind,nmeasure) values(2,3);
insert into OBJTYPEMEAS(ind,nmeasure) values(2,4);
insert into OBJTYPEMEAS(ind,nmeasure) values(2,5);
insert into OBJTYPEMEAS(ind,nmeasure) values(2,6);
insert into OBJTYPEMEAS(ind,nmeasure) values(2,7);
insert into OBJTYPEMEAS(ind,nmeasure) values(2,8);
insert into OBJTYPEMEAS(ind,nmeasure) values(2,9);
insert into OBJTYPEMEAS(ind,nmeasure) values(2,10);
insert into OBJTYPEMEAS(ind,nmeasure) values(3,0);
insert into OBJTYPEMEAS(ind,nmeasure) values(3,1);
insert into OBJTYPEMEAS(ind,nmeasure) values(3,2);
insert into OBJTYPEMEAS(ind,nmeasure) values(3,3);
insert into OBJTYPEMEAS(ind,nmeasure) values(3,4);
insert into OBJTYPEMEAS(ind,nmeasure) values(3,5);
insert into OBJTYPEMEAS(ind,nmeasure) values(3,6);
insert into OBJTYPEMEAS(ind,nmeasure) values(3,7);
insert into OBJTYPEMEAS(ind,nmeasure) values(3,8);
insert into OBJTYPEMEAS(ind,nmeasure) values(3,9);
insert into OBJTYPEMEAS(ind,nmeasure) values(3,10);
insert into OBJTYPEMEAS(ind,nmeasure) values(4,0);
insert into OBJTYPEMEAS(ind,nmeasure) values(4,1);
insert into OBJTYPEMEAS(ind,nmeasure) values(4,2);
insert into OBJTYPEMEAS(ind,nmeasure) values(4,3);
insert into OBJTYPEMEAS(ind,nmeasure) values(4,4);
insert into OBJTYPEMEAS(ind,nmeasure) values(4,5);
insert into OBJTYPEMEAS(ind,nmeasure) values(4,6);
insert into OBJTYPEMEAS(ind,nmeasure) values(4,7);
insert into OBJTYPEMEAS(ind,nmeasure) values(4,8);
insert into OBJTYPEMEAS(ind,nmeasure) values(4,9);
insert into OBJTYPEMEAS(ind,nmeasure) values(4,10);
insert into OBJTYPEMEAS(ind,nmeasure) values(11,0);
insert into OBJTYPEMEAS(ind,nmeasure) values(11,1);
insert into OBJTYPEMEAS(ind,nmeasure) values(11,2);
insert into OBJTYPEMEAS(ind,nmeasure) values(11,3);
insert into OBJTYPEMEAS(ind,nmeasure) values(11,4);
insert into OBJTYPEMEAS(ind,nmeasure) values(11,5);
insert into OBJTYPEMEAS(ind,nmeasure) values(11,6);
insert into OBJTYPEMEAS(ind,nmeasure) values(11,7);
insert into OBJTYPEMEAS(ind,nmeasure) values(11,8);
insert into OBJTYPEMEAS(ind,nmeasure) values(11,9);
insert into OBJTYPEMEAS(ind,nmeasure) values(11,10);
insert into OBJTYPEMEAS(ind,nmeasure) values(11,11);
insert into OBJTYPEMEAS(ind,nmeasure) values(11,12);
insert into OBJTYPEMEAS(ind,nmeasure) values(11,13);
insert into OBJTYPEMEAS(ind,nmeasure) values(11,14);
insert into OBJTYPEMEAS(ind,nmeasure) values(11,15);
insert into OBJTYPEMEAS(ind,nmeasure) values(12,0);
insert into OBJTYPEMEAS(ind,nmeasure) values(12,1);
insert into OBJTYPEMEAS(ind,nmeasure) values(12,2);
insert into OBJTYPEMEAS(ind,nmeasure) values(12,3);
insert into OBJTYPEMEAS(ind,nmeasure) values(12,4);
insert into OBJTYPEMEAS(ind,nmeasure) values(12,5);
insert into OBJTYPEMEAS(ind,nmeasure) values(12,6);
insert into OBJTYPEMEAS(ind,nmeasure) values(12,7);
insert into OBJTYPEMEAS(ind,nmeasure) values(12,8);
insert into OBJTYPEMEAS(ind,nmeasure) values(12,9);
insert into OBJTYPEMEAS(ind,nmeasure) values(12,10);
insert into OBJTYPEMEAS(ind,nmeasure) values(500,32);
insert into OBJTYPEMEAS(ind,nmeasure) values(500,33);
insert into OBJTYPEMEAS(ind,nmeasure) values(500,34);
insert into OBJTYPEMEAS(ind,nmeasure) values(500,35);
insert into OBJTYPEMEAS(ind,nmeasure) values(600,16);
insert into OBJTYPEMEAS(ind,nmeasure) values(600,17);
insert into OBJTYPEMEAS(ind,nmeasure) values(600,18);
insert into OBJTYPEMEAS(ind,nmeasure) values(600,19);
insert into OBJTYPEMEAS(ind,nmeasure) values(600,20);
insert into OBJTYPEMEAS(ind,nmeasure) values(600,21);
insert into OBJTYPEMEAS(ind,nmeasure) values(600,22);
insert into OBJTYPEMEAS(ind,nmeasure) values(610,16);
insert into OBJTYPEMEAS(ind,nmeasure) values(610,17);
insert into OBJTYPEMEAS(ind,nmeasure) values(610,19);
insert into OBJTYPEMEAS(ind,nmeasure) values(610,21);
insert into OBJTYPEMEAS(ind,nmeasure) values(610,22);
insert into OBJTYPEMEAS(ind,nmeasure) values(610,23);
insert into OBJTYPEMEAS(ind,nmeasure) values(610,24);
insert into OBJTYPEMEAS(ind,nmeasure) values(610,25);
insert into OBJTYPEMEAS(ind,nmeasure) values(610,26);
insert into OBJTYPEMEAS(ind,nmeasure) values(610,27);
insert into OBJTYPEMEAS(ind,nmeasure) values(610,28);
insert into OBJTYPEMEAS(ind,nmeasure) values(610,29);
insert into OBJTYPEMEAS(ind,nmeasure) values(610,30);
insert into OBJTYPEMEAS(ind,nmeasure) values(610,31);
commit;
end;
/

/*==============================================================*/
/* Table: SWITCHESSRV                                           */
/*==============================================================*/
create table SWITCHESSRV  (
   NSWITCH              NUMBER                          not null,
   DSWITCH              DATE                            not null,
   DESCAPE              DATE                            not null,
   MID                  NUMBER                          not null,
   constraint PK_SWITCHESSRV primary key (NSWITCH, DSWITCH)
);

comment on table SWITCHESSRV is
'Перекл обводвых опрос';

comment on column SWITCHESSRV.NSWITCH is
'Ид обводника';

comment on column SWITCHESSRV.DSWITCH is
'Дата переключения';

comment on column SWITCHESSRV.DESCAPE is
'Дата окончания';

comment on column SWITCHESSRV.MID is
'Ид точки';

/*==============================================================*/
/* Index: SWITCHESSRV_IDX1                                      */
/*==============================================================*/
create index SWITCHESSRV_IDX1 on SWITCHESSRV (
   MID ASC
);

alter table SWITCHESSRV
   add constraint SWITCHESSRV_F1 foreign key (MID)
      references POINTS (MID)
      on delete cascade;

alter table SWITCHESSRV
   add constraint SWITCHESSRV_F2 foreign key (NSWITCH)
      references POINTS (MID)
      on delete cascade;



---------------------------- 07/11/2008
begin
update tasks set nshow=0 where task_cod=655;
commit;
end;
/

begin
INSERT INTO measures("NMEASURE","VNAME","VCODE")VALUES(36,'EE (ER+ED) Суммарная активная','EE');
INSERT INTO measures("NMEASURE","VNAME","VCODE")VALUES(37,'QQ (Q1+Q3)+(Q2+Q4)','QQ');
commit;
end;
/


-------------------- 12/10/2008
/*==============================================================*/
/* Table: MRIDS                                                 */
/*==============================================================*/
create table MRIDS  (
   MID                  NUMBER                          not null,
   NMEASURE             NUMBER(10)                      not null,
   MRID                 VARCHAR2(64)                    not null,
   constraint PK_MRIDS primary key (MID, NMEASURE)
);

comment on table MRIDS is
'Глобальные идентификаторы';

comment on column MRIDS.MID is
'Ид точки';

comment on column MRIDS.NMEASURE is
'Ид измерения';

comment on column MRIDS.MRID is
'Глобальный идент';

/*==============================================================*/
/* Index: MRIDS_IDX1                                            */
/*==============================================================*/
create unique index MRIDS_IDX1 on MRIDS (
   MRID ASC
);

/*==============================================================*/
/* Index: MRIDS_IDX2                                            */
/*==============================================================*/
create index MRIDS_IDX2 on MRIDS (
   NMEASURE ASC
);

alter table MRIDS
   add constraint MRIDS_F1 foreign key (MID)
      references POINTS (MID)
      on delete cascade;

alter table MRIDS
   add constraint MRIDS_F2 foreign key (NMEASURE)
      references MEASURES (NMEASURE)
      on delete cascade;

----------------------------------------------------------------------------------------------
--         VER 2.27.5  (Для обновления версии 2.27.4 до текущей скрипт запускать отсюда)        --
----------------------------------------------------------------------------------------------
alter table SWITCHESSRV drop constraint SWITCHESSRV_F1;
alter table SWITCHESSRV drop constraint SWITCHESSRV_F2;

begin
delete from deportprocedures where nprocedure=15;
commit;
end;
/

ALTER TABLE SWITCHES  MODIFY (  USER_ID NULL );



begin
INSERT INTO OBJTYPEMEAS("IND","NMEASURE")VALUES(1,36);
INSERT INTO OBJTYPEMEAS("IND","NMEASURE")VALUES(1,37);
INSERT INTO OBJTYPEMEAS("IND","NMEASURE")VALUES(2,36);
INSERT INTO OBJTYPEMEAS("IND","NMEASURE")VALUES(2,37);
INSERT INTO OBJTYPEMEAS("IND","NMEASURE")VALUES(3,36);
INSERT INTO OBJTYPEMEAS("IND","NMEASURE")VALUES(3,37);
INSERT INTO OBJTYPEMEAS("IND","NMEASURE")VALUES(4,36);
INSERT INTO OBJTYPEMEAS("IND","NMEASURE")VALUES(4,37);
INSERT INTO OBJTYPEMEAS("IND","NMEASURE")VALUES(11,36);
INSERT INTO OBJTYPEMEAS("IND","NMEASURE")VALUES(11,37);
INSERT INTO OBJTYPEMEAS("IND","NMEASURE")VALUES(12,36);
INSERT INTO OBJTYPEMEAS("IND","NMEASURE")VALUES(12,37);
commit;
exception
when others then null;
end;
/

--20.11.2008
update parameter set vdescription='Ид уполномоченного субъекта' where npid=40;
commit;



INSERT INTO deportprocedures(NPROCEDURE,VNAME,VPROCEDURE,NPERIOD,NTYPE,VMEMO)
VALUES(15,'Анализ журнала ОВ структурных подразделений','ryda.BACKGROUND01_PG.copyswitches',0,1,'Анализ журнала ОВ структурных подразделений')
/
commit
/


-------20/11/08
begin
delete from points where mid=15;
insert into points (mid,parent,ind,name) select NPROCEDURE,2,1,VNAME from deportprocedures where NPROCEDURE=15;
commit;
end;
/

INSERT INTO deportprocedures
(NPROCEDURE,VNAME,VPROCEDURE,NPERIOD,NTYPE,VMEMO)
VALUES
(55,'КППД (RDF-макет)','reports2_pg.mrdf_p',2,0,'КППД (RDF-макет) в XML - формате')
/
commit
/

---------------28.11.2008
/*==============================================================*/
/* Table: POINTFORMULA                                          */
/*==============================================================*/
alter table POINTFORMULA  add(
   NOPTTYPE             NUMBER(1)
);

comment on column POINTFORMULA.NOPTTYPE is
'Тип орптимизации';


/*==============================================================*/
/* Table: FORMULPARAMS                                          */
/*==============================================================*/
alter table FORMULPARAMS  add (
   NSIGN                NUMBER
);

comment on column FORMULPARAMS.NSIGN is
'Знак';

-------01/12/2008
begin
INSERT INTO measures("NMEASURE","VNAME","VCODE")VALUES(38,'Автоматически определяемое (инверсия)','AI');
commit;
end;
/



begin
INSERT INTO OBJTYPEMEAS("IND","NMEASURE")VALUES(1,38);
INSERT INTO OBJTYPEMEAS("IND","NMEASURE")VALUES(2,38);
INSERT INTO OBJTYPEMEAS("IND","NMEASURE")VALUES(3,38);
INSERT INTO OBJTYPEMEAS("IND","NMEASURE")VALUES(4,38);
INSERT INTO OBJTYPEMEAS("IND","NMEASURE")VALUES(11,38);
INSERT INTO OBJTYPEMEAS("IND","NMEASURE")VALUES(12,38);
commit;
exception
when others then null;
end;
/


declare
ln_1 NUMBER;
ln_2 NUMBER;
begin
select max(nid) into ln_1 from BASEFORMULA where vname='Базовые формулы';
if ln_1 is null then 
return;
end if;
delete from baseformula where nparent=ln_1;
select points_seq.NEXTVAL into ln_2 from dual;
INSERT INTO BASEFORMULA("NID","NPARENT","NTYPE","VNAME","VFORMULA","VMEMO")VALUES(ln_2,ln_1,1,'Разница счетчиков актив (для потерь в линиях по разн. сч)','abs(a-b)',NULL);
INSERT INTO BASEFORMULPARAMS("NID","NORDER","VNAME","VPARAM","VMEMO")VALUES(ln_2,1,'a','MID.1000.EE','EE (ER+ED) Суммарная активная');
INSERT INTO BASEFORMULPARAMS("NID","NORDER","VNAME","VPARAM","VMEMO")VALUES(ln_2,2,'b','MID.1000.EE','EE (ER+ED) Суммарная активная');

select points_seq.NEXTVAL into ln_2 from dual;
INSERT INTO BASEFORMULA("NID","NPARENT","NTYPE","VNAME","VFORMULA","VMEMO")VALUES(ln_2,ln_1,1,'Разница счетчиков реактив (для потерь в линиях по разн. сч)','abs(a-b)',NULL);
INSERT INTO BASEFORMULPARAMS("NID","NORDER","VNAME","VPARAM","VMEMO")VALUES(ln_2,1,'a','MID.1000.QQ','QQ (Q1+Q3)+(Q2+Q4)');
INSERT INTO BASEFORMULPARAMS("NID","NORDER","VNAME","VPARAM","VMEMO")VALUES(ln_2,2,'b','MID.1000.QQ','QQ (Q1+Q3)+(Q2+Q4)');

select points_seq.NEXTVAL into ln_2 from dual;
INSERT INTO BASEFORMULA("NID","NPARENT","NTYPE","VNAME","VFORMULA","VMEMO")VALUES(ln_2,ln_1,1,'Расчет потерь активной электроэнергии в двухобмоточном тр-ре','if(WPf>DPxx*0.5, DPxx*0.5+(sqrt((WPf/0.5)^2+(WQf/0.5)^2)/Sn)^2*DPkz*0.5, if ((WPf>0)&(WPf<=DPxx*0.5), DPxx*0.5, 0))',NULL);
INSERT INTO BASEFORMULPARAMS("NID","NORDER","VNAME","VPARAM","VMEMO")VALUES(ln_2,1,'WPf','MID.1000.EE','EE (ER+ED) Суммарная активная');
INSERT INTO BASEFORMULPARAMS("NID","NORDER","VNAME","VPARAM","VMEMO")VALUES(ln_2,2,'DPxx','MID.1000.DPxx','DPxx - Потери актив мощн в стали тр');
INSERT INTO BASEFORMULPARAMS("NID","NORDER","VNAME","VPARAM","VMEMO")VALUES(ln_2,3,'WQf','MID.1000.QQ','QQ (Q1+Q3)+(Q2+Q4)');
INSERT INTO BASEFORMULPARAMS("NID","NORDER","VNAME","VPARAM","VMEMO")VALUES(ln_2,4,'Sn','MID.1000.Sn','Номинальная мощность трансф-ра');
INSERT INTO BASEFORMULPARAMS("NID","NORDER","VNAME","VPARAM","VMEMO")VALUES(ln_2,5,'DPkz','MID.1000.DPkz','DPkz - Потери актив мощн в меди обмоток');

select points_seq.NEXTVAL into ln_2 from dual;
INSERT INTO BASEFORMULA("NID","NPARENT","NTYPE","VNAME","VFORMULA","VMEMO")VALUES(ln_2,ln_1,1,'Расчет потерь активной электроэнергии в линии','((WP^2+WQ^2)/(Un^2*0.5))*((r0*L)/100)*0.001',NULL);
INSERT INTO BASEFORMULPARAMS("NID","NORDER","VNAME","VPARAM","VMEMO")VALUES(ln_2,1,'WP','MID.1000.EE','EE (ER+ED) Суммарная активная');
INSERT INTO BASEFORMULPARAMS("NID","NORDER","VNAME","VPARAM","VMEMO")VALUES(ln_2,2,'WQ','MID.1000.QQ','QQ (Q1+Q3)+(Q2+Q4)');
INSERT INTO BASEFORMULPARAMS("NID","NORDER","VNAME","VPARAM","VMEMO")VALUES(ln_2,3,'Un','MID.1000.Un','Un - Номинальное напряжение линии');
INSERT INTO BASEFORMULPARAMS("NID","NORDER","VNAME","VPARAM","VMEMO")VALUES(ln_2,4,'r0','MID.1000.r0','r0 - Удельное актив сопрот-е линии');
INSERT INTO BASEFORMULPARAMS("NID","NORDER","VNAME","VPARAM","VMEMO")VALUES(ln_2,5,'L','MID.1000.L','L - Длина линии');

select points_seq.NEXTVAL into ln_2 from dual;
INSERT INTO BASEFORMULA("NID","NPARENT","NTYPE","VNAME","VFORMULA","VMEMO")VALUES(ln_2,ln_1,1,'Расчет потерь активной электроэнергии в трехобмоточном тр-ре','if((WPCH+WPHH)>DPxx*0.5, DPxx*0.5+(DPBH*((sqrt(((WPCH+WPHH)/0.5)^2+((WQCH+WQHH)/0.5)^2)/SBH)^2)+DPCH*((sqrt((WPCH/0.5)^2+(WQCH/0.5)^2)/SCH)^2)+DPHH*((sqrt((WPHH/0.5)^2+(WQHH/0.5)^2)/SHH)^2))*0.5, if (((WPCH+WPHH)>0)&((WPCH+WPHH)<=DPxx*0.5), DPxx*0.5, 0))',NULL);
INSERT INTO BASEFORMULPARAMS("NID","NORDER","VNAME","VPARAM","VMEMO")VALUES(ln_2,1,'WPCH','MID.1000.EE','EE (ER+ED) Суммарная активная');
INSERT INTO BASEFORMULPARAMS("NID","NORDER","VNAME","VPARAM","VMEMO")VALUES(ln_2,2,'WPHH','MID.1000.EE','EE (ER+ED) Суммарная активная');
INSERT INTO BASEFORMULPARAMS("NID","NORDER","VNAME","VPARAM","VMEMO")VALUES(ln_2,3,'DPxx','MID.53092.DPxx','DPxx - Потери актив мощн в стали тр');
INSERT INTO BASEFORMULPARAMS("NID","NORDER","VNAME","VPARAM","VMEMO")VALUES(ln_2,4,'DPBH','MID.53092.DPBH','DPBH - Потери мощн в меди обм ВН');
INSERT INTO BASEFORMULPARAMS("NID","NORDER","VNAME","VPARAM","VMEMO")VALUES(ln_2,5,'WQCH','MID.1000.QQ','QQ (Q1+Q3)+(Q2+Q4)');
INSERT INTO BASEFORMULPARAMS("NID","NORDER","VNAME","VPARAM","VMEMO")VALUES(ln_2,6,'WQHH','MID.1000.QQ','QQ (Q1+Q3)+(Q2+Q4)');
INSERT INTO BASEFORMULPARAMS("NID","NORDER","VNAME","VPARAM","VMEMO")VALUES(ln_2,7,'SBH','MID.53092.SBH','SBH - Мощность обмотки ВН');
INSERT INTO BASEFORMULPARAMS("NID","NORDER","VNAME","VPARAM","VMEMO")VALUES(ln_2,8,'DPCH','MID.53092.DPCH','DPCH - Потери мощн в меди обм СН');
INSERT INTO BASEFORMULPARAMS("NID","NORDER","VNAME","VPARAM","VMEMO")VALUES(ln_2,9,'SCH','MID.53092.SCH','SCH - Мощность обмотки СН');
INSERT INTO BASEFORMULPARAMS("NID","NORDER","VNAME","VPARAM","VMEMO")VALUES(ln_2,10,'DPHH','MID.53092.DPHH','DPHH - Потери мощн в меди обм НН');
INSERT INTO BASEFORMULPARAMS("NID","NORDER","VNAME","VPARAM","VMEMO")VALUES(ln_2,11,'SHH','MID.53092.SHH','SHH - Мощность обмотки НН');

select points_seq.NEXTVAL into ln_2 from dual;
INSERT INTO BASEFORMULA("NID","NPARENT","NTYPE","VNAME","VFORMULA","VMEMO")VALUES(ln_2,ln_1,1,'Расчет потерь реактивной электроэнергии в двухобмоточном тр-ре','if(WQf>(Sn*(Ixx/100))*0.5, (Sn*(Ixx/100))*0.5+(sqrt((WPf/0.5)^2+(WQf/0.5)^2)/Sn)^2*(Sn*(Ukz/100))*0.5, if ((WQf>0)&(WQf<=(Sn*(Ixx/100))*0.5), (Sn*(Ixx/100))*0.5, 0))',NULL);
INSERT INTO BASEFORMULPARAMS("NID","NORDER","VNAME","VPARAM","VMEMO")VALUES(ln_2,1,'WQf','MID.1000.QQ','QQ (Q1+Q3)+(Q2+Q4)');
INSERT INTO BASEFORMULPARAMS("NID","NORDER","VNAME","VPARAM","VMEMO")VALUES(ln_2,2,'Sn','MID.1000.Sn','Номинальная мощность трансф-ра');
INSERT INTO BASEFORMULPARAMS("NID","NORDER","VNAME","VPARAM","VMEMO")VALUES(ln_2,3,'Ixx','MID.1000.Ixx','Ixx - Ток холостого хода трансф');
INSERT INTO BASEFORMULPARAMS("NID","NORDER","VNAME","VPARAM","VMEMO")VALUES(ln_2,4,'WPf','MID.1000.EE','EE (ER+ED) Суммарная активная');
INSERT INTO BASEFORMULPARAMS("NID","NORDER","VNAME","VPARAM","VMEMO")VALUES(ln_2,5,'Ukz','MID.1000.Ukz','Ukz - Напр короткого замыкания');

select points_seq.NEXTVAL into ln_2 from dual;
INSERT INTO BASEFORMULA("NID","NPARENT","NTYPE","VNAME","VFORMULA","VMEMO")VALUES(ln_2,ln_1,1,'Расчет потерь реактивной электроэнергии в линии','((WP^2+WQ^2)/(Un^2*0.5))*((x0*L)/100)*0.001',NULL);
INSERT INTO BASEFORMULPARAMS("NID","NORDER","VNAME","VPARAM","VMEMO")VALUES(ln_2,1,'WP','MID.1000.EE','EE (ER+ED) Суммарная активная');
INSERT INTO BASEFORMULPARAMS("NID","NORDER","VNAME","VPARAM","VMEMO")VALUES(ln_2,2,'WQ','MID.1000.QQ','QQ (Q1+Q3)+(Q2+Q4)');
INSERT INTO BASEFORMULPARAMS("NID","NORDER","VNAME","VPARAM","VMEMO")VALUES(ln_2,3,'Un','MID.1000.Un','Un - Номинальное напряжение линии');
INSERT INTO BASEFORMULPARAMS("NID","NORDER","VNAME","VPARAM","VMEMO")VALUES(ln_2,4,'x0','MID.1000.x0','x0 - Удельное реактив сопрот-е линии');
INSERT INTO BASEFORMULPARAMS("NID","NORDER","VNAME","VPARAM","VMEMO")VALUES(ln_2,5,'L','MID.1000.L','L - Длина линии');

select points_seq.NEXTVAL into ln_2 from dual;
INSERT INTO BASEFORMULA("NID","NPARENT","NTYPE","VNAME","VFORMULA","VMEMO")VALUES(ln_2,ln_1,1,'Расчет потерь реактивной электроэнергии в трехобмоточном тр-ре ','if((WQCH+WQHH)>(Sn*(Ixx/100))*0.5, (Sn*(Ixx/100))*0.5+((SBH*0.5*(UBH_CH+UBH_HH-UCH_HH)/100)*((sqrt(((WPCH+WPHH)/0.5)^2+((WQCH+WQHH)/0.5)^2)/SBH)^2)+(SCH*0.5*(UBH_CH+UCH_HH-UBH_HH)/100)*((sqrt((WPCH/0.5)^2+(WQCH/0.5)^2)/SCH)^2)+(SHH*0.5*(UBH_HH+UCH_HH-UBH_CH)/100)*((sqrt((WPHH/0.5)^2+(WQHH/0.5)^2)/SHH)^2))*0.5, if (((WQCH+WQHH)>0)&((WQCH+WQHH)<=(Sn*(Ixx/100))*0.5), (Sn*(Ixx/100))*0.5, 0))',NULL);
INSERT INTO BASEFORMULPARAMS("NID","NORDER","VNAME","VPARAM","VMEMO")VALUES(ln_2,1,'WQCH','MID.1000.QQ','QQ (Q1+Q3)+(Q2+Q4)');
INSERT INTO BASEFORMULPARAMS("NID","NORDER","VNAME","VPARAM","VMEMO")VALUES(ln_2,2,'WQHH','MID.1000.QQ','QQ (Q1+Q3)+(Q2+Q4)');
INSERT INTO BASEFORMULPARAMS("NID","NORDER","VNAME","VPARAM","VMEMO")VALUES(ln_2,3,'Sn','MID.1000.Sn','Номинальная мощность трансф-ра');
INSERT INTO BASEFORMULPARAMS("NID","NORDER","VNAME","VPARAM","VMEMO")VALUES(ln_2,4,'Ixx','MID.1000.Ixx','Ixx - Ток холостого хода трансф');
INSERT INTO BASEFORMULPARAMS("NID","NORDER","VNAME","VPARAM","VMEMO")VALUES(ln_2,5,'SBH','MID.1000.SBH','SBH - Мощность обмотки ВН');
INSERT INTO BASEFORMULPARAMS("NID","NORDER","VNAME","VPARAM","VMEMO")VALUES(ln_2,6,'UBH_CH','MID.1000.UBH_CH','UBH_CH - Напр-е обмотки ВН-СН');
INSERT INTO BASEFORMULPARAMS("NID","NORDER","VNAME","VPARAM","VMEMO")VALUES(ln_2,7,'UBH_HH','MID.1000.UBH_HH','UBH_HH - Напр-е обмотки ВН-НН');
INSERT INTO BASEFORMULPARAMS("NID","NORDER","VNAME","VPARAM","VMEMO")VALUES(ln_2,8,'UCH_HH','MID.1000.UCH_HH','UCH_HH - Напр-е обмотки СН-НН');
INSERT INTO BASEFORMULPARAMS("NID","NORDER","VNAME","VPARAM","VMEMO")VALUES(ln_2,9,'WPCH','MID.1000.EE','EE (ER+ED) Суммарная активная');
INSERT INTO BASEFORMULPARAMS("NID","NORDER","VNAME","VPARAM","VMEMO")VALUES(ln_2,10,'WPHH','MID.1000.EE','EE (ER+ED) Суммарная активная');
INSERT INTO BASEFORMULPARAMS("NID","NORDER","VNAME","VPARAM","VMEMO")VALUES(ln_2,11,'SCH','MID.1000.SCH','SCH - Мощность обмотки СН');
INSERT INTO BASEFORMULPARAMS("NID","NORDER","VNAME","VPARAM","VMEMO")VALUES(ln_2,12,'SHH','MID.1000.SHH','SHH - Мощность обмотки НН');

commit;
exception
when others then rollback;
end;
/

----------------------------------------------------------------------------------------------
--         VER 2.28.2  (Для обновления версии 2.28 до текущей скрипт запускать отсюда)        --
----------------------------------------------------------------------------------------------
INSERT INTO deportprocedures
(NPROCEDURE,VNAME,VPROCEDURE,NPERIOD,NTYPE,VMEMO)
VALUES
(56,'Макет 817-818','reports1_pg.817_818p',2,0,'Макет 817-818')
/
commit
/

update deportprocedures set VPROCEDURE='reports1_pg.m817_818_p' where NPROCEDURE=56;
commit;


begin
INSERT INTO protocols("PROTOCOL_ID","NAME","DLL_NAME")VALUES(1006,'Меркурий-200 (DLL)','Mercury_200_02.dll');
INSERT INTO protocols("PROTOCOL_ID","NAME","DLL_NAME")VALUES(1007,'Энергия-9 v.42 (DLL)','en942.dll');
commit;
end;
/

begin
insert into metertype(nmetertype,vname) values(28,'ОИК Хартэп');
commit;
end;
/

--23.12.2008
begin
insert into metertype(nmetertype,vname) values(29,'ОИК Донбас ЭС (Старый)');
commit;
end;
/


----------------------------------------------------------------------------------------------
--         VER 2.29  (Для обновления версии 2.28.2 до текущей скрипт запускать отсюда)        --
----------------------------------------------------------------------------------------------
--30/12/2008

alter table ADDPOINTPARAMVAL
   drop constraint ADDPOINTPARAMVAL_F2;
   
alter table ADDPOINTPARAMVAL
   add constraint ADDPOINTPARAMVAL_F2 foreign key (MID)
      references POINTS (MID)
      on delete cascade;
      

----14.01.2009
INSERT INTO tasks
(TASK_ID,PARENT,TASK_COD,NAME,REMARK,NSHOW)
VALUES
(102,27,658,'4.5 АРМ оператора приема мкетов','',1)
/
insert into role_task
select distinct ROLE_ID,102,1 from users where ADMIN='*'
/
commit
/
      
      



/*select *from form_templates  where commentform is  null
select * from form_templates  where commentform is not null */ 

---15/01/2009    --изменение комментария мониторов убирем размерность
BEGIN
    FOR lc IN (select replace(replace(replace(replace(replace(replace('update forms set  commentform='''||commentform||'''  
            where codetemplate='||codetemplate||' and fid='||fid||' ','[тыс.кВтч]'),'[тыс.кВАрч]'),'[тыс.кВтч/тыс.кВАрч]'),'[МВт]'),'[МВАрч]'),'[МВт/МВАр]') c
                from forms  where commentform is not null and commentform<>' ' and codetemplate>0)loop
        EXECUTE IMMEDIATE lc.c;
    END LOOP;
  
   for lc in
    (select replace(replace(replace(replace(replace(replace('update form_templates set  commentform='''||commentform||'''  where codetemplate='||codetemplate||' 
    and template_id='||template_id||' ','[тыс.кВтч]'),'[тыс.кВАрч]'),'[тыс.кВтч/тыс.кВАрч]'),'[МВт]'),'[МВАрч]'),'[МВт/МВАр]')l 
    from form_templates where commentform is not null and commentform<>' '  and codetemplate>0)loop

    EXECUTE IMMEDIATE lc.l;
   END LOOP;

   COMMIT;
EXCEPTION
    WHEN OTHERS THEN
     rollback;
     raise;
END;
/

      
---- 20/01/2009
declare
a integer;
b integer;
begin
select max(nmeasure) into a from measures;
select count(*) into b from measures where VCODE='A.D';
if b=0 then
insert into measures (nmeasure, vname, vcode) 
select  row_number() OVER(ORDER BY nmeasure)+a, vname||' - суточные', vcode||'.D' 
from measures where NMEASURE between 0 AND 10 OR NMEASURE between 36 AND 38;

select max(nmeasure) into a from measures;
insert into measures (nmeasure, vname, vcode) 
select  row_number() OVER(ORDER BY nmeasure)+a, vname||' - месячные', vcode||'.M' 
from measures where NMEASURE between 0 AND 10 OR NMEASURE between 36 AND 38;

insert into objtypemeas
select distinct a.ind, b.nmeasure from objtypemeas a, measures b where b.nmeasure between 39 and 66 AND a.ind in 
(select distinct ind from objtypemeas where NMEASURE between 0 AND 10 OR NMEASURE between 36 AND 38);
end if;
commit;
end;
/      

--21/01/2009
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (46,'Тип параметризации углов (4 - Токи-относительные, иначе - по умолчанию)',1);
commit;

---------------29/01/2009
begin
INSERT INTO points(MID,PARENT,COD,IND,NAME,SHORT_NAME,PTYPE,IMPLEMENT_DATE,TAG,NPOINT) VALUES(54,NULL,NULL,1,'Кластер АСКУЭ','',NULL,'',NULL,NULL);
commit;
end;
/

INSERT INTO RYDA.PROTOCOLS VALUES(90,'УППД - ИНЭТ','');
INSERT INTO RYDA.PROTOCOLS VALUES(91,'ZxQ (dlms)','');
INSERT INTO RYDA.PROTOCOLS VALUES(92,'KM --> ZxQ (dlms)','');
commit;


grant update on forms_ex to askue_work;  


INSERT INTO deportprocedures("NPROCEDURE","VNAME","VPROCEDURE","NPERIOD","NTYPE","VMEMO") VALUES(57,'Расчет текущих суток','BACKGROUND01_PG.calccurrentformula',1,1,'Расчет текущих суток');
commit;


create table RMAKETS  (
   NOPERATION           NUMBER(10)                      not null,
   NDEPORTATION         NUMBER(10)                      not null,
   DCREATE              DATE                            not null,
   VFILENAME            VARCHAR2(128)                   not null,
   DFILE                DATE                            not null,
   NSTATE               NUMBER(1)                      default 0 not null
      constraint CKC_NSTATE_RMAKETS check (NSTATE in (0,1,2,3,4,5,6,7)),
   VERROR               VARCHAR2(2000),
   VMAKET               CLOB,
   NMAKET               NUMBER(10),
   DDATE                DATE,
   NTYPE                NUMBER,
   DLOAD                DATE,
   NUID                 NUMBER,
   constraint PK_RMAKETS primary key (NOPERATION)
);

comment on table RMAKETS is
'Принятые макеты';

comment on column RMAKETS.NOPERATION is
'Ид операции';

comment on column RMAKETS.NDEPORTATION is
'Ид канала';

comment on column RMAKETS.DCREATE is
'Дата приема';

comment on column RMAKETS.VFILENAME is
'Название файла';

comment on column RMAKETS.DFILE is
'Дата файла';

comment on column RMAKETS.NSTATE is
'Состояние';

comment on column RMAKETS.VERROR is
'Ошибка';

comment on column RMAKETS.VMAKET is
'Текст макета';

comment on column RMAKETS.NMAKET is
'Ид макета';

comment on column RMAKETS.DDATE is
'Дата информации';

comment on column RMAKETS.NTYPE is
'Тип макета';

comment on column RMAKETS.DLOAD is
'Дата загрузки';

comment on column RMAKETS.NUID is
'идентификатор';

/*==============================================================*/
/* Index: RMAKETS_IDX1                                          */
/*==============================================================*/
create index RMAKETS_IDX1 on RMAKETS (
   DCREATE ASC
);

/*==============================================================*/
/* Index: RMAKETS_IDX2                                          */
/*==============================================================*/
create index RMAKETS_IDX2 on RMAKETS (
   NDEPORTATION ASC,
   VFILENAME ASC
);

/*==============================================================*/
/* Index: RMAKETS_IDX3                                          */
/*==============================================================*/
create index RMAKETS_IDX3 on RMAKETS (
   DDATE ASC
);

/*==============================================================*/
/* Index: RMAKETS_IDX4                                          */
/*==============================================================*/
create index RMAKETS_IDX4 on RMAKETS (
   NSTATE ASC,
   NOPERATION ASC
);

/*==============================================================*/
/* Index: RMAKETS_IDX5                                          */
/*==============================================================*/
create index RMAKETS_IDX5 on RMAKETS (
   NMAKET ASC
);

/*==============================================================*/
/* Index: RMAKETS_IDX6                                          */
/*==============================================================*/
create index RMAKETS_IDX6 on RMAKETS (
   NUID ASC
);

alter table RMAKETS
   add constraint FK_RMAKETS_REFERENCE_DEPORTAT foreign key (NDEPORTATION)
      references DEPORTATION (NDEPORTATION)
      on delete cascade;

alter table RMAKETS
   add constraint FK_RMAKETS_REFERENCE_MAKETS foreign key (NMAKET)
      references MAKETS (NMAKET)
      on delete cascade;
/*==============================================================*/
/* Table: MAKDEPORT                                             */
/*==============================================================*/
create table MAKDEPORT  (
   NMAKET               NUMBER(10)                      not null,
   NDEPORTATION         NUMBER(10)                      not null,
   constraint PK_MAKDEPORT primary key (NMAKET, NDEPORTATION)
);

comment on table MAKDEPORT is
'МакетКанал';

comment on column MAKDEPORT.NMAKET is
'Ид макета';

comment on column MAKDEPORT.NDEPORTATION is
'Ид канала';

/*==============================================================*/
/* Index: MAKDEPORT_IDX1                                        */
/*==============================================================*/
create index MAKDEPORT_IDX1 on MAKDEPORT (
   NDEPORTATION ASC
);

alter table MAKDEPORT
   add constraint MAKDEPORT_F1 foreign key (NDEPORTATION)
      references DEPORTATION (NDEPORTATION)
      on delete cascade;

alter table MAKDEPORT
   add constraint MAKDEPORT_F2 foreign key (NMAKET)
      references MAKETS (NMAKET)
      on delete cascade;



--28.01.2009
CREATE SEQUENCE makets_seq
  INCREMENT BY 1
  START WITH 1000
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  NOCYCLE
  NOORDER
  NOCACHE
/
grant update on rmakets to askue_work;  






----------------------------------------------------------------------------------------------
--         VER 2.29.1  (Для обновления версии 2.28.2 до текущей скрипт запускать отсюда)        ---------------09/02/2009
----------------------------------------------------------------------------------------------

/*==============================================================*/
/* Table: SWITCHES                                               */
/*==============================================================*/
--11/02/2009
alter table SWITCHES  add(
   ERME                 NUMBER,
   EDME                 NUMBER,
   Q1ME                 NUMBER,
   Q2ME                 NUMBER,
   Q3ME                 NUMBER,
   Q4ME                 NUMBER
);

comment on table SWITCHES is
'Переключение обводвых';

comment on column SWITCHES.ID is
'Ид строки';

comment on column SWITCHES.NSWITCH is
'Ид обводника';

comment on column SWITCHES.DSWITCH is
'Дата переключения';

comment on column SWITCHES.DESCAPE is
'Дата окончания';

comment on column SWITCHES.MID is
'Ид точки';

comment on column SWITCHES.DENTER is
'Дата ввода';

comment on column SWITCHES.USER_ID is
'Ид пользователя';

comment on column SWITCHES.ERM is
'Показание A пр';

comment on column SWITCHES.EDM is
'Показание A от';

comment on column SWITCHES.Q1M is
'Показание Q1';

comment on column SWITCHES.Q2M is
'Показание Q2';

comment on column SWITCHES.Q3M is
'Показание Q3';

comment on column SWITCHES.Q4M is
'Показание Q4';

comment on column SWITCHES.NSTATE is
'Состояние расчета';

comment on column SWITCHES.VERROR is
'Текст ошибки';

comment on column SWITCHES.ERME is
'Показание A пр кон';

comment on column SWITCHES.EDME is
'Показание A от кон';

comment on column SWITCHES.Q1ME is
'Показание Q1 кон';

comment on column SWITCHES.Q2ME is
'Показание Q2 кон';

comment on column SWITCHES.Q3ME is
'Показание Q3 кон';

comment on column SWITCHES.Q4ME is
'Показание Q4 кон';

-------------------16/02/2009
alter table OPERATINGDAY  drop constraint OPERATINGDAY_PK;

drop index OPERATINGDAY_PK;

alter table OPERATINGDAY  add (
   NMEAS                NUMBER(1)                      default 0 not null
      constraint CKC_NMEAS_OPERATIN check (NMEAS in (0,1,2,3,4,5,6)),
   constraint OPERATINGDAY_PK primary key (NOWNER, DSTART, NMEAS)
);

comment on column OPERATINGDAY.NMEAS is
'Тип измерения';

alter table OPERATINGDAY  add(
   NTYPE                NUMBER(1)                      default 0 not null
      constraint CKC_NTYPE_OPERATIN check (NTYPE in (0,1,2,3,4))
);


comment on column OPERATINGDAY.NTYPE is
'Тип разноски (разносить по)';


----------------------------------------------------------------------------------------------
--         VER 2.29.2  (Для обновления версии 2.29.1 до текущей скрипт запускать отсюда)        -----------------24/02/2009
----------------------------------------------------------------------------------------------
/*==============================================================*/
/* Table: FEEDERSCOEF                                           */
/*==============================================================*/
create table FEEDERSCOEF  (
   MID                  NUMBER                          not null,
   DSTART               DATE                            not null,
   DEND                 DATE,
   KC                   NUMBER                         default 1 not null,
   constraint PK_FEEDERSCOEF primary key (MID, DSTART)
);

comment on table FEEDERSCOEF is
'Коефициентты точек';

comment on column FEEDERSCOEF.MID is
'Ид точки';

comment on column FEEDERSCOEF.DSTART is
'Дата с';

comment on column FEEDERSCOEF.DEND is
'Дата по';

comment on column FEEDERSCOEF.KC is
'Коеф';

alter table FEEDERSCOEF
   add constraint FEEDERSCOEF_F1 foreign key (MID)
      references FEEDERS (MID)
      on delete cascade;

-------01/03/2009
alter table METERSTATUSBITDICT  add(
   NVALIDITY            NUMBER                         default 0 not null
);

comment on column METERSTATUSBITDICT.NVALIDITY is
'Достовеерность';



------02/03/2009
/*==============================================================*/
/* Table: PRIORITY                                              */
/*==============================================================*/
create table PRIORITY  (
   MID                  NUMBER                          not null,
   DSTART               DATE                            not null,
   DEND                 DATE                            not null,
   NORDER               NUMBER(10)                     default 1 not null,
   constraint PK_PRIORITY primary key (MID, DSTART)
);

comment on table PRIORITY is
'Приоритеты восстановления';

comment on column PRIORITY.MID is
'Ид точки';

comment on column PRIORITY.DSTART is
'Дата с';

comment on column PRIORITY.DEND is
'Дата по';

comment on column PRIORITY.NORDER is
'Приоритет';

alter table METEREVENTSDICT  drop column NVALIDITY;
alter table METEREVENTSDICT  add(
   NVALIDITY            NUMBER(1)                      default 0 not null
      constraint CKC_NVALIDITY_METEREVE check (NVALIDITY in (0,1,2))
);

comment on column METEREVENTSDICT.NVALIDITY is
'Достовеерность';

alter table METERSTATUSBITDICT  drop column NVALIDITY;
alter table METERSTATUSBITDICT  add(
   NVALIDITY            NUMBER(1)                      default 0 not null
      constraint CKC_NVALIDITY_METERSTA check (NVALIDITY in (0,1,2))
);

comment on column METERSTATUSBITDICT.NVALIDITY is
'Достовеерность';

--------04/03/2009
begin
delete from meterstatusbitdict;
INSERT INTO meterstatusbitdict("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1","NVALIDITY")VALUES(1,0,'Start of measurement ',NULL,NULL,0);
INSERT INTO meterstatusbitdict("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1","NVALIDITY")VALUES(3,0,'Регистрация фатальной ошибки',NULL,NULL,0);
INSERT INTO meterstatusbitdict("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1","NVALIDITY")VALUES(3,1,'Резерв питания календарных часов исчерпан (некорр. время)',NULL,NULL,0);
INSERT INTO meterstatusbitdict("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1","NVALIDITY")VALUES(1,1,'Power failure',NULL,NULL,1);
INSERT INTO meterstatusbitdict("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1","NVALIDITY")VALUES(3,2,'Неполное измерение, интеграционный период слишком мал',NULL,NULL,0);
INSERT INTO meterstatusbitdict("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1","NVALIDITY")VALUES(1,2,'Clock Setting',NULL,NULL,0);
INSERT INTO meterstatusbitdict("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1","NVALIDITY")VALUES(1,3,'External Clock Synchro',NULL,NULL,0);
INSERT INTO meterstatusbitdict("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1","NVALIDITY")VALUES(3,3,'Лето или зима (1 = лето, 0 = зима)',NULL,NULL,0);
INSERT INTO meterstatusbitdict("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1","NVALIDITY")VALUES(1,4,'DST',NULL,NULL,0);
INSERT INTO meterstatusbitdict("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1","NVALIDITY")VALUES(3,4,'Выполнен сброс',NULL,NULL,0);
INSERT INTO meterstatusbitdict("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1","NVALIDITY")VALUES(3,5,'Изменено время;дата',NULL,NULL,0);
INSERT INTO meterstatusbitdict("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1","NVALIDITY")VALUES(1,5,'Watch dog reset',NULL,NULL,0);
INSERT INTO meterstatusbitdict("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1","NVALIDITY")VALUES(3,6,'Восстановление напряжения',NULL,NULL,0);
INSERT INTO meterstatusbitdict("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1","NVALIDITY")VALUES(3,7,'Провал напряжения (по 3 фазам)',NULL,NULL,1);
INSERT INTO meterstatusbitdict("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1","NVALIDITY")VALUES(3,8,'не используется',NULL,NULL,0);
INSERT INTO meterstatusbitdict("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1","NVALIDITY")VALUES(1,8,'Start of measurement ',NULL,NULL,0);
INSERT INTO meterstatusbitdict("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1","NVALIDITY")VALUES(1,9,'Power failure',NULL,NULL,1);
INSERT INTO meterstatusbitdict("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1","NVALIDITY")VALUES(3,9,'не используется',NULL,NULL,0);
INSERT INTO meterstatusbitdict("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1","NVALIDITY")VALUES(1,10,'Clock Setting',NULL,NULL,0);
INSERT INTO meterstatusbitdict("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1","NVALIDITY")VALUES(3,10,'не используется',NULL,NULL,0);
INSERT INTO meterstatusbitdict("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1","NVALIDITY")VALUES(1,11,'External Clock Synchro',NULL,NULL,0);
INSERT INTO meterstatusbitdict("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1","NVALIDITY")VALUES(3,11,'не используется',NULL,NULL,0);
INSERT INTO meterstatusbitdict("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1","NVALIDITY")VALUES(3,12,'не используется',NULL,NULL,0);
INSERT INTO meterstatusbitdict("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1","NVALIDITY")VALUES(1,12,'DST',NULL,NULL,0);
INSERT INTO meterstatusbitdict("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1","NVALIDITY")VALUES(1,13,'Watch dog reset',NULL,NULL,0);
INSERT INTO meterstatusbitdict("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1","NVALIDITY")VALUES(3,13,'Список событий полностью удален',NULL,NULL,0);
INSERT INTO meterstatusbitdict("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1","NVALIDITY")VALUES(3,14,'Память профиля данных полностью обнулена',NULL,NULL,0);
INSERT INTO meterstatusbitdict("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1","NVALIDITY")VALUES(3,15,'Запись статусного сообщения перед последним изменением времени',NULL,NULL,0);
INSERT INTO meterstatusbitdict("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1","NVALIDITY")VALUES(1,16,'Start of measurement ',NULL,NULL,0);
INSERT INTO meterstatusbitdict("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1","NVALIDITY")VALUES(3,16,'зарезервировано',NULL,NULL,0);
INSERT INTO meterstatusbitdict("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1","NVALIDITY")VALUES(1,17,'Power failure',NULL,NULL,1);
INSERT INTO meterstatusbitdict("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1","NVALIDITY")VALUES(3,17,'зарезервировано',NULL,NULL,0);
INSERT INTO meterstatusbitdict("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1","NVALIDITY")VALUES(3,18,'зарезервировано',NULL,NULL,0);
INSERT INTO meterstatusbitdict("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1","NVALIDITY")VALUES(1,18,'Clock Setting',NULL,NULL,0);
INSERT INTO meterstatusbitdict("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1","NVALIDITY")VALUES(3,19,'Старт интеграционного периода (SOI - начало интервала)',NULL,NULL,0);
INSERT INTO meterstatusbitdict("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1","NVALIDITY")VALUES(1,19,'External Clock Synchro',NULL,NULL,0);
INSERT INTO meterstatusbitdict("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1","NVALIDITY")VALUES(3,20,'Конец интеграционного периода при изменении тарифа (EOI - окончание интервала)',NULL,NULL,0);
INSERT INTO meterstatusbitdict("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1","NVALIDITY")VALUES(1,20,'DST',NULL,NULL,0);
INSERT INTO meterstatusbitdict("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1","NVALIDITY")VALUES(1,21,'Watch dog reset',NULL,NULL,0);
INSERT INTO meterstatusbitdict("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1","NVALIDITY")VALUES(3,21,'Преждевременное окончание интеграционного периода (например, при изменении времени)',NULL,NULL,0);
INSERT INTO meterstatusbitdict("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1","NVALIDITY")VALUES(3,22,'Интеграционный период окончен по внешнему управляющему сигналу',NULL,NULL,0);
INSERT INTO meterstatusbitdict("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1","NVALIDITY")VALUES(3,23,'Интеграционный период окончен по внутреннему управляющему сигналу',NULL,NULL,0);
INSERT INTO meterstatusbitdict("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1","NVALIDITY")VALUES(1,24,'Start of measurement ',NULL,NULL,0);
INSERT INTO meterstatusbitdict("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1","NVALIDITY")VALUES(1,25,'Power failure',NULL,NULL,1);
INSERT INTO meterstatusbitdict("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1","NVALIDITY")VALUES(1,26,'Clock Setting',NULL,NULL,0);
INSERT INTO meterstatusbitdict("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1","NVALIDITY")VALUES(1,27,'External Clock Synchro',NULL,NULL,0);
INSERT INTO meterstatusbitdict("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1","NVALIDITY")VALUES(1,28,'DST',NULL,NULL,0);
INSERT INTO meterstatusbitdict("NMETERTYPE","NBIT","VEVENTTEXT","NEVENT0","NEVENT1","NVALIDITY")VALUES(1,29,'Watch dog reset',NULL,NULL,0);
commit;
end;
/


----------------------------------------------------------------------------------------------
--         VER 2.29.3  (Для обновления версии 2.29.2 до текущей скрипт запускать отсюда)        -----------------06/03/2009
----------------------------------------------------------------------------------------------

-----------04.03.2009
begin
update  meterstatusbitdict set nbit=8*(trunc(nbit/8))+(8*(1+trunc(nbit/8))-1)-nbit where     NMETERTYPE=1 and exists (select * from meterstatusbitdict where NMETERTYPE=1 and nbit=0 and VEVENTTEXT='Start of measurement ');
commit;
end;
/

-------10/03/2008
begin
INSERT INTO measures("NMEASURE","VNAME","VCODE")VALUES(67,'Класс ТН','CTN');
INSERT INTO measures("NMEASURE","VNAME","VCODE")VALUES(68,'Класс ТТ','CTT');
INSERT INTO measures("NMEASURE","VNAME","VCODE")VALUES(69,'Класс счетчика','CM');
commit;
end;
/


begin
for i in 67..69 loop
delete from OBJTYPEMEAS where NMEASURE=i;
INSERT INTO OBJTYPEMEAS("IND","NMEASURE")VALUES(3,i);
INSERT INTO OBJTYPEMEAS("IND","NMEASURE")VALUES(4,i);
end loop;
commit;
exception
when others then null;
end;
/

----------------------------------------------------------------------------------------------
--         VER 2.29.4  (Для обновления версии 2.29.3 до текущей скрипт запускать отсюда)        -----------------10/03/2009
----------------------------------------------------------------------------------------------

INSERT INTO dict_obj_types("IND","VNAME","RT_TYPE")VALUES(620,'Реактор',620);

commit;


declare
l NUMBER;
begin
insert into parameter (NPID,VVALUE,VDESCRIPTION) values(43,0,'Вычислять паузу между циклами опроса канала от старта');
commit;
end;
/


--15/05/2009
alter table SWITCHES  drop column NSTATE;
alter table SWITCHES  drop column VERROR;


create table switches1 as SELECT * FROM switches s;
ALTER TABLE SWITCHES  MODIFY (  descape NULL );

begin
delete from switches;
insert into switches(id, nswitch, dswitch, descape, mid, denter,       user_id, erm, edm, q1m, q2m, q3m, q4m, erme,       edme, q1me, q2me, q3me, q4me)
SELECT   s0.id,s0.nswitch,s0.dswitch,decode(s0.descape,TO_DATE ('300101', 'YYYYMM'),decode(1,2,sysdate),s0.descape) descape, s0.mid,s0.DENTER,s0.USER_ID,
s0.erm, s0.edm, s0.q1m, s0.q2m, s0.q3m, s0.q4m ,s3.erm, s3.edm, s3.q1m, s3.q2m, s3.q3m, s3.q4m
FROM switches1 s0,
(SELECT   s.id,s1.erm, s1.edm, s1.q1m, s1.q2m, s1.q3m, s1.q4m 
FROM switches1 s,switches1 s1 
WHERE s.mid>0 and s.nswitch=s1.nswitch and s1.dswitch = 
(select min(sw.DSWITCH) from switches1 sw where sw.nswitch=s.nswitch and sw.dswitch>s.dswitch and sw.mid is null)) s3 
WHERE s0.mid>0 and s0.id=s3.id(+);
commit;
exception
when others then
 rollback;
 raise;
end;
/

drop table switches1;
ALTER TABLE SWITCHES  MODIFY (  MID NOT NULL );

update measures set VNAME='Un - Номинальное напряжение' where NMEASURE=35;
update measures set VNAME='Sn - Номинальная мощность' where NMEASURE=16;
update measures set VNAME='DPkz - Потери актив мощности' where NMEASURE=18;
update measures set VNAME='Tn - Полное время работы' where NMEASURE=21;
update measures set VNAME='Tp - Время работы под нагрузкой' where NMEASURE=22;

INSERT INTO OBJTYPEMEAS("IND","NMEASURE")VALUES(620,35);
INSERT INTO OBJTYPEMEAS("IND","NMEASURE")VALUES(620,16);
INSERT INTO OBJTYPEMEAS("IND","NMEASURE")VALUES(620,18);
INSERT INTO OBJTYPEMEAS("IND","NMEASURE")VALUES(620,21);
INSERT INTO OBJTYPEMEAS("IND","NMEASURE")VALUES(620,22);
commit;


----------------------------------------------------------------------------------------------
--  18/03/2009    VER 2.30. (Для обновления версии 2.29.4 до текущей скрипт запускать отсюда)      
----------------------------------------------------------------------------------------------
begin
execute immediate 'drop table ICCPTMPMEAS';
exception
when others then null;
end;
/

begin
for lc in
(select 'drop table '||table_NAME||' cascade constraints' c from user_tables where table_name like 'UPDT_%' ) loop
execute immediate lc.c;
end loop;
commit;
end;
/

/*==============================================================*/
/* Table: ICCPSTAT                                              */
/*==============================================================*/
create table ICCPSTAT  (
   CID                  NUMBER(10)                      not null,
   DDATE                DATE                            not null,
   NREASON              NUMBER(10)                      not null,
   NSEND                NUMBER(10),
   NRECEIVED            NUMBER(10),
   NLOSS                NUMBER(10),
   NCORRECTION          NUMBER(10),
   NERROR               NUMBER(10),
   NDURATION            NUMBER(10),
   NMINDELAY            NUMBER(10),
   NMAXDELAY            NUMBER(10),
   NAVGDELAY            NUMBER(10),
   constraint PK_ICCPSTAT primary key (CID, DDATE)
);

comment on table ICCPSTAT is
'Статистика ICCP';

comment on column ICCPSTAT.CID is
'Ид канала';

comment on column ICCPSTAT.DDATE is
'Дата';

comment on column ICCPSTAT.NREASON is
'Причина';

comment on column ICCPSTAT.NSEND is
'Запрсов';

comment on column ICCPSTAT.NRECEIVED is
'Ответов';

comment on column ICCPSTAT.NLOSS is
'Потерь';

comment on column ICCPSTAT.NCORRECTION is
'Коррекций';

comment on column ICCPSTAT.NERROR is
'Ошибок';

comment on column ICCPSTAT.NDURATION is
'Длительность';

comment on column ICCPSTAT.NMINDELAY is
'Мин задержка';

comment on column ICCPSTAT.NMAXDELAY is
'Макс задержка';

comment on column ICCPSTAT.NAVGDELAY is
'Средн задержка';

alter table ICCPSTAT
   add constraint ICCPSTAT_F1 foreign key (CID)
      references CHANNELS (CID)
      on delete cascade;

------------20/03/2009
alter table ICCPSTAT  drop constraint PK_ICCPSTAT;
alter table ICCPSTAT  add(
   constraint PK_ICCPSTAT primary key (CID, DDATE, NREASON)
);


--23/03/2009
truncate table SWITCHESSRV;
ALTER TABLE SWITCHESSRV  MODIFY (  DESCAPE NULL );


--26/03/2009
delete from switches where nswitch=mid;
delete  from switches s where exists 
(select * from switches where nswitch=s.nswitch and DSWITCH>s.DSWITCH 
and DSWITCH<nvl(s.DESCAPE,to_date('209901','YYYYMM')));
commit;

alter table ICCPSTAT  add(
   NCONNECT             NUMBER(10),
   NDISCONNECT          NUMBER(10)
);


comment on column ICCPSTAT.NCONNECT is
'Соединений';

comment on column ICCPSTAT.NDISCONNECT is
'Обрывы связи';


----27/03/2009
/*==============================================================*/
/* Table: SWITCHESSRVCALCP                                      */
/*==============================================================*/
create global temporary table SWITCHESSRVP  (
   DSWITCH              DATE,
   DESCAPE              DATE,
   MID                  NUMBER
)    ON COMMIT DELETE ROWS;


----14.01.2009
declare
l NUMBER;
begin
select nvl(max(decode(vvalue,'0',1,'42',1,'43',1,'44',1,'45',1,'46',1,0)),0) into l from parameter where NPID=12;
if l=1 then
INSERT INTO tasks(TASK_ID,PARENT,TASK_COD,NAME,REMARK,NSHOW) VALUES (103,56,659,'3.4 Статистика ICCP','',1);
insert into role_task select ROLE_ID,103,decode(ROLE_ID,1,1,0) from roles;
commit;
end if;
exception when others then null;
end; 
/


----31/03/2009
alter table DEPORTFILES  add(
   NNOTFULL             NUMBER(1)                      default 0 not null
      constraint CKC_NNOTFULL_DEPORTFI check (NNOTFULL in (0,1))
);

comment on column DEPORTFILES.NNOTFULL is
'Неполные данные';


----06/04/2009
drop table SWITCHESSRVP;

/*==============================================================*/
/* Table: SWITCHESSRVP                                          */
/*==============================================================*/
create global temporary table SWITCHESSRVP  (
   DSWITCH              DATE,
   DESCAPE              DATE,
   MID                  NUMBER
)
ON COMMIT  PRESERVE ROWS
;

comment on table SWITCHESSRVP is
'Перекл обводвых опрос обработка';

comment on column SWITCHESSRVP.DSWITCH is
'Дата переключения';

comment on column SWITCHESSRVP.DESCAPE is
'Дата окончания';

comment on column SWITCHESSRVP.MID is
'Ид точки';

INSERT INTO RYDA.PROTOCOLS VALUES (1008,'Альфа А1140 (DLL)','Alpha1140.dll');

commit;


----------------------------------------------------------------------------------------------
--  14/04/2009    VER 2.30.4 (Для обновления версии 2.30.3 до текущей скрипт запускать отсюда)      
----------------------------------------------------------------------------------------------
create table SCHEDULELIST  (
   NSCHEDULELIST        NUMBER(10)                      not null,
   VNAME                VARCHAR2(128)                    not null,
   NCOUNT               NUMBER(10)                     default 4 not null,
   constraint PK_SCHEDULELIST primary key (NSCHEDULELIST)
);

comment on table SCHEDULELIST is
'Виды расписаний тар зон';

comment on column SCHEDULELIST.NSCHEDULELIST is
'Ид расписания';

comment on column SCHEDULELIST.VNAME is
'Наименование расписания';

comment on column SCHEDULELIST.NCOUNT is
'Макс количество зон';

create unique index SCHEDULELIST_IDX1 on SCHEDULELIST (
   VNAME ASC
);

alter table RATE_LIST drop constraint RATE_LIST_UNI;
drop index RATE_LIST_UNI;


insert into SCHEDULELIST(NSCHEDULELIST,VNAME,NCOUNT) values(1,'Тарифные зоны Украины (время украинское)',3);
/*==============================================================*/
/* Table: RATE_LIST                                             */
/*==============================================================*/
alter table RATE_LIST add (
   NSCHEDULELIST        NUMBER(10)                       default 1 not null
);


comment on column RATE_LIST.NSCHEDULELIST is
'Ид расписания';

create unique index RATE_LIST_IDX1 on RATE_LIST (
   NSCHEDULELIST ASC,
   SWITCH_DATE ASC
);

alter table RATE_LIST
   add constraint RATE_LIST_F1 foreign key (NSCHEDULELIST)
      references SCHEDULELIST (NSCHEDULELIST);

/*
--Только для АСКУЭ ПГОК
 insert into deportprocedures (nprocedure, vname, vprocedure, nperiod, ntype, vmemo)
 values (59, 'Загрузка данных выработки','ryda.pgok_pg.copy_pgok_data', 1, 1, 'Загрузка данных выработки')
 /
 commit
 /
*/

drop index HALFHOUROLD_IDX5;

create index HALFHOUROLD_IDX5 on HALFHOUROLD (
   MID ASC,
   DENTER ASC
);

drop index JOURNAL_IDX1;

create index JOURNAL_IDX1 on JOURNAL (
   DATE_TIME ASC
);

drop index JOURNAL_IDX2;
/*==============================================================*/
/* Index: JOURNAL_IDX2                                          */
/*==============================================================*/
create index JOURNAL_IDX2 on JOURNAL (
   MID ASC,
   DATE_TIME ASC
);

---15/04/2009-----------------------------
update timezones set dsummer=null where nid=2;
commit;

--23.04.2009
INSERT INTO form_templates
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(93,1,330,'1.18. Полнота и своевременность данных',
'Полнота и своевременность данных','11111111',2,'')
/
commit
/


--INSERT INTO RYDA.PROTOCOLS VALUES (1009,'Энергия-9 v.29 (DLL)','Energy9v29.dll'); будет дальше
commit;

----------------------------------------------------------------------------------------------
--  23/04/2009    VER 2.31 (Для обновления версии 2.30.4 до текущей скрипт запускать отсюда)      
----------------------------------------------------------------------------------------------

alter table SWITCHES  add(
   DENTERRET            DATE,
   USER_IDRET           NUMBER
);

comment on column SWITCHES.DENTER is
'Дата ввода перевода';

comment on column SWITCHES.USER_ID is
'Ид пользователя перевода';

comment on column SWITCHES.DENTERRET is
'Дата ввода возврата';

comment on column SWITCHES.USER_IDRET is
'Ид пользователя возврата';

create index SWITCHES_IDX5 on SWITCHES (
   USER_IDRET ASC
);

alter table SWITCHES
   add constraint SWITCHES_F4 foreign key (USER_IDRET)
      references USERS (USER_ID);



--24/04/2009
alter table SCHEDULELIST  add(
   NID                  NUMBER(10)                      default 1 not null
);

comment on column SCHEDULELIST.NID is
'Ид часового пояса';

create index SCHEDULELIST_IDX2 on SCHEDULELIST (
   NID ASC
);

alter table SCHEDULELIST   add constraint SCHEDULELIST_F1 foreign key (NID)      references TIMEZONES (NID);

update switches set DENTERRET=DENTER,USER_IDRET=USER_ID where descape is not null;
commit;

begin
INSERT INTO RYDA.PROTOCOLS VALUES (1009,'Энергия-9 v.29 (DLL)','Energy9v29.dll');
commit;
exception
when others then null;
end;
/


----------------------------------------------------------------------------------------------
--  07/05/2009    VER 2.31.2 (Для обновления версии 2.30.4 до текущей скрипт запускать отсюда)      
----------------------------------------------------------------------------------------------

alter table METERSTATUSBITDICT  add(
   NQM                  NUMBER(1)                      default 0 not null
      constraint CKC_NQM_METERSTA check (NQM in (0,2,3,4,5,6,7,8,9))
);

comment on column METERSTATUSBITDICT.NQM is
'Биты метки качества';

begin
update meterstatusbitdict set nvalidity =2, nqm =9 where nmetertype=1and nbit=7;
update meterstatusbitdict set nvalidity =1, nqm =6 where nmetertype=3and nbit=0;
update meterstatusbitdict set nvalidity =2, nqm =4 where nmetertype=3and nbit=1;
update meterstatusbitdict set nvalidity =1, nqm =6 where nmetertype=1and nbit=6;
update meterstatusbitdict set nvalidity =2, nqm =9 where nmetertype=3and nbit=2;
update meterstatusbitdict set nvalidity =2, nqm =4 where nmetertype=1and nbit=5;
update meterstatusbitdict set nvalidity =2, nqm =9 where nmetertype=1and nbit=4;
update meterstatusbitdict set nvalidity =0, nqm =0 where nmetertype=3and nbit=3;
update meterstatusbitdict set nvalidity =2, nqm =9 where nmetertype=1and nbit=3;
update meterstatusbitdict set nvalidity =1, nqm =6 where nmetertype=3and nbit=4;
update meterstatusbitdict set nvalidity =2, nqm =4 where nmetertype=3and nbit=5;
update meterstatusbitdict set nvalidity =1, nqm =6 where nmetertype=1and nbit=2;
update meterstatusbitdict set nvalidity =2, nqm =9 where nmetertype=3and nbit=6;
update meterstatusbitdict set nvalidity =2, nqm =9 where nmetertype=3and nbit=7;
update meterstatusbitdict set nvalidity =0, nqm =0 where nmetertype=3and nbit=8;
update meterstatusbitdict set nvalidity =2, nqm =9 where nmetertype=1and nbit=15;
update meterstatusbitdict set nvalidity =1, nqm =6 where nmetertype=1and nbit=14;
update meterstatusbitdict set nvalidity =0, nqm =0 where nmetertype=3and nbit=9;
update meterstatusbitdict set nvalidity =2, nqm =4 where nmetertype=1and nbit=13;
update meterstatusbitdict set nvalidity =0, nqm =0 where nmetertype=3and nbit=10;
update meterstatusbitdict set nvalidity =2, nqm =9 where nmetertype=1and nbit=12;
update meterstatusbitdict set nvalidity =0, nqm =0 where nmetertype=3and nbit=11;
update meterstatusbitdict set nvalidity =0, nqm =0 where nmetertype=3and nbit=12;
update meterstatusbitdict set nvalidity =2, nqm =9 where nmetertype=1and nbit=11;
update meterstatusbitdict set nvalidity =1, nqm =6 where nmetertype=1and nbit=10;
update meterstatusbitdict set nvalidity =2, nqm =8 where nmetertype=3and nbit=13;
update meterstatusbitdict set nvalidity =1, nqm =6 where nmetertype=3and nbit=14;
update meterstatusbitdict set nvalidity =0, nqm =0 where nmetertype=3and nbit=15;
update meterstatusbitdict set nvalidity =2, nqm =9 where nmetertype=1and nbit=23;
update meterstatusbitdict set nvalidity =0, nqm =0 where nmetertype=3and nbit=16;
update meterstatusbitdict set nvalidity =1, nqm =6 where nmetertype=1and nbit=22;
update meterstatusbitdict set nvalidity =0, nqm =0 where nmetertype=3and nbit=17;
update meterstatusbitdict set nvalidity =0, nqm =0 where nmetertype=3and nbit=18;
update meterstatusbitdict set nvalidity =2, nqm =4 where nmetertype=1and nbit=21;
update meterstatusbitdict set nvalidity =0, nqm =0 where nmetertype=3and nbit=19;
update meterstatusbitdict set nvalidity =2, nqm =9 where nmetertype=1and nbit=20;
update meterstatusbitdict set nvalidity =0, nqm =0 where nmetertype=3and nbit=20;
update meterstatusbitdict set nvalidity =2, nqm =9 where nmetertype=1and nbit=19;
update meterstatusbitdict set nvalidity =1, nqm =6 where nmetertype=1and nbit=18;
update meterstatusbitdict set nvalidity =2, nqm =8 where nmetertype=3and nbit=21;
update meterstatusbitdict set nvalidity =2, nqm =9 where nmetertype=3and nbit=22;
update meterstatusbitdict set nvalidity =2, nqm =9 where nmetertype=3and nbit=23;
update meterstatusbitdict set nvalidity =2, nqm =9 where nmetertype=1and nbit=31;
update meterstatusbitdict set nvalidity =1, nqm =6 where nmetertype=1and nbit=30;
update meterstatusbitdict set nvalidity =2, nqm =4 where nmetertype=1and nbit=29;
update meterstatusbitdict set nvalidity =2, nqm =9 where nmetertype=1and nbit=28;
update meterstatusbitdict set nvalidity =2, nqm =9 where nmetertype=1and nbit=27;
update meterstatusbitdict set nvalidity =1, nqm =6 where nmetertype=1and nbit=26;
commit;
end;
/


----------------------------------------------------------------------------------------------
--  18/05/2009    VER 2.32 (Для обновления версии 2.31.2 до текущей скрипт запускать отсюда)      
----------------------------------------------------------------------------------------------
begin
INSERT INTO measures("NMEASURE","VNAME","VCODE")VALUES(70,'Допустимые потери от ТН до счетчика, В','APP38');
INSERT INTO OBJTYPEMEAS("IND","NMEASURE")VALUES(3,70);
INSERT INTO OBJTYPEMEAS("IND","NMEASURE")VALUES(4,70);
commit;
exception
when others then rollback;
end;
/


--  25/05/2009    
alter table FORMULPARAMS  add(
   NSHIFT               NUMBER                         default 0 not null);

comment on column FORMULPARAMS.NSHIFT is
'Сдвиг';

--27/05/2009

begin
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (-31,'Код канала  A+',0);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (-32,'Код канала  A-',0);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (-33,'Код канала  R+ (Q1 + Q2)',0);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (-34,'Код канала  R- (Q3 + Q4)',0);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (-35,'Код канала  A  (A+ - A-)',0);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (-36,'Код канала  R  (R+ - R-)',0);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (-37,'Код канала  Q1',0);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (-38,'Код канала  Q2',0);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (-39,'Код канала  Q3',0);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (-40,'Код канала  Q4',0);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (-41,'Код объекта A+',0);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (-42,'Код объекта A-',0);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (-43,'Код объекта R+ (Q1 + Q2)',0);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (-44,'Код объекта R- (Q3 + Q4)',0);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (-45,'Код объекта A  (A+ - A-)',0);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (-46,'Код объекта R  (R+ - R-)',0);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (-47,'Код объекта Q1',0);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (-48,'Код объекта Q2',0);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (-49,'Код объекта Q3',0);
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (-50,'Код объекта Q4',0);
commit;
end;
/

----------02/06/2009
INSERT INTO RYDA.PROTOCOLS
VALUES
(93,'ЕвроАльфа - Link','')
/
INSERT INTO RYDA.PROTOCOLS
VALUES
(94,'KM --> ЕвроАльфа - Link','')
/
INSERT INTO RYDA.PROTOCOLS
VALUES
(95,'FAG --> ZxU (Logem)','')
/
INSERT INTO RYDA.PROTOCOLS
VALUES
(96,'SL-7000 (dlms+echo)','')
/
commit
/


----------------------------------------------------------------------------------------------
--  02/06/2009    VER 2.32.2 (Для обновления версии 2.32 до текущей скрипт запускать отсюда)      
----------------------------------------------------------------------------------------------
begin
update timezones set nshift=-1,dsummer=null where nid=2;
commit;
end;
/


----11.06.2009
alter table LAST_SAVE  add(
   HALFHOURCHANGE       DATE                           default SYSDATE not null
);


comment on column LAST_SAVE.HALFHOURCHANGE is
'Последняя запись ГН';

--12.06.2009
begin
insert into ADDFORMPARAM(NSORT,VDESCR,NTYPE) values(-6,'Вывод форматированного заголовка отчета',1);
commit;
end;
/


--24.06.2009
delete from RYDA.PROTOCOLS where protocol_id  in (9, 22, 23, 24, 25, 30, 35, 36, 38, 46, 48, 50, 63, 65, 67, 69, 71, 73, 76, 79, 81, 87, 92, 94, 1003);
commit;

begin
INSERT INTO ADDPOINTPARAM(NSORT,VDESCR,NTYPE)VALUES (47,'Тип параметризации при подключении к Fag-12 (1 - автосохранение показаний, иначе - автосохранение ГН)',1);
commit;
exception
when others then null;
end;
/


--26.06.2009
begin
update meterstatusbitdict set nvalidity =1, nqm =9 where nmetertype=1and nbit=7;
update meterstatusbitdict set nvalidity =2, nqm =6 where nmetertype=3and nbit=0;
update meterstatusbitdict set nvalidity =1, nqm =4 where nmetertype=3and nbit=1;
update meterstatusbitdict set nvalidity =2, nqm =6 where nmetertype=1and nbit=6;
update meterstatusbitdict set nvalidity =1, nqm =9 where nmetertype=3and nbit=2;
update meterstatusbitdict set nvalidity =1, nqm =4 where nmetertype=1and nbit=5;
update meterstatusbitdict set nvalidity =1, nqm =9 where nmetertype=1and nbit=4;
update meterstatusbitdict set nvalidity =0, nqm =0 where nmetertype=3and nbit=3;
update meterstatusbitdict set nvalidity =1, nqm =9 where nmetertype=1and nbit=3;
update meterstatusbitdict set nvalidity =2, nqm =6 where nmetertype=3and nbit=4;
update meterstatusbitdict set nvalidity =1, nqm =4 where nmetertype=3and nbit=5;
update meterstatusbitdict set nvalidity =2, nqm =6 where nmetertype=1and nbit=2;
update meterstatusbitdict set nvalidity =1, nqm =9 where nmetertype=3and nbit=6;
update meterstatusbitdict set nvalidity =1, nqm =9 where nmetertype=3and nbit=7;
update meterstatusbitdict set nvalidity =0, nqm =0 where nmetertype=3and nbit=8;
update meterstatusbitdict set nvalidity =1, nqm =9 where nmetertype=1and nbit=15;
update meterstatusbitdict set nvalidity =2, nqm =6 where nmetertype=1and nbit=14;
update meterstatusbitdict set nvalidity =0, nqm =0 where nmetertype=3and nbit=9;
update meterstatusbitdict set nvalidity =1, nqm =4 where nmetertype=1and nbit=13;
update meterstatusbitdict set nvalidity =0, nqm =0 where nmetertype=3and nbit=10;
update meterstatusbitdict set nvalidity =1, nqm =9 where nmetertype=1and nbit=12;
update meterstatusbitdict set nvalidity =0, nqm =0 where nmetertype=3and nbit=11;
update meterstatusbitdict set nvalidity =0, nqm =0 where nmetertype=3and nbit=12;
update meterstatusbitdict set nvalidity =1, nqm =9 where nmetertype=1and nbit=11;
update meterstatusbitdict set nvalidity =2, nqm =6 where nmetertype=1and nbit=10;
update meterstatusbitdict set nvalidity =1, nqm =8 where nmetertype=3and nbit=13;
update meterstatusbitdict set nvalidity =2, nqm =6 where nmetertype=3and nbit=14;
update meterstatusbitdict set nvalidity =0, nqm =0 where nmetertype=3and nbit=15;
update meterstatusbitdict set nvalidity =1, nqm =9 where nmetertype=1and nbit=23;
update meterstatusbitdict set nvalidity =0, nqm =0 where nmetertype=3and nbit=16;
update meterstatusbitdict set nvalidity =2, nqm =6 where nmetertype=1and nbit=22;
update meterstatusbitdict set nvalidity =0, nqm =0 where nmetertype=3and nbit=17;
update meterstatusbitdict set nvalidity =0, nqm =0 where nmetertype=3and nbit=18;
update meterstatusbitdict set nvalidity =1, nqm =4 where nmetertype=1and nbit=21;
update meterstatusbitdict set nvalidity =0, nqm =0 where nmetertype=3and nbit=19;
update meterstatusbitdict set nvalidity =1, nqm =9 where nmetertype=1and nbit=20;
update meterstatusbitdict set nvalidity =0, nqm =0 where nmetertype=3and nbit=20;
update meterstatusbitdict set nvalidity =1, nqm =9 where nmetertype=1and nbit=19;
update meterstatusbitdict set nvalidity =2, nqm =6 where nmetertype=1and nbit=18;
update meterstatusbitdict set nvalidity =1, nqm =8 where nmetertype=3and nbit=21;
update meterstatusbitdict set nvalidity =1, nqm =9 where nmetertype=3and nbit=22;
update meterstatusbitdict set nvalidity =1, nqm =9 where nmetertype=3and nbit=23;
update meterstatusbitdict set nvalidity =1, nqm =9 where nmetertype=1and nbit=31;
update meterstatusbitdict set nvalidity =2, nqm =6 where nmetertype=1and nbit=30;
update meterstatusbitdict set nvalidity =1, nqm =4 where nmetertype=1and nbit=29;
update meterstatusbitdict set nvalidity =1, nqm =9 where nmetertype=1and nbit=28;
update meterstatusbitdict set nvalidity =1, nqm =9 where nmetertype=1and nbit=27;
update meterstatusbitdict set nvalidity =2, nqm =6 where nmetertype=1and nbit=26;
commit;
end;
/

--02/07/2009
update ADDPOINTPARAM set NSORT=72 where NSORT=47 and VDESCR='Тип параметризации при подключении к Fag-12 (1 - автосохранение показаний, иначе - автосохранение ГН)';
commit;



----------------------------------------------------------------------------------------------
--  02/06/2009    VER 2.32.3 (Для обновления версии 2.32.2 до текущей скрипт запускать отсюда)      
----------------------------------------------------------------------------------------------

begin
INSERT INTO measures(nmeasure,VNAME,vcode)VALUES(71,'Показания Актив, прием','ERM');
INSERT INTO measures(nmeasure,VNAME,vcode)VALUES(72,'Показания Актив, отдача','EDM');
INSERT INTO measures(nmeasure,VNAME,vcode)VALUES(73,'Показания Q1 (Реактив, прием)','Q1M');
INSERT INTO measures(nmeasure,VNAME,vcode)VALUES(75,'Показания Q3 (Реактив, генерц)','Q3M');
commit;
exception
when others then rollback;
end;
/


alter table MEASURES  add(
   NMRID                NUMBER(1)                      default 0 not null
      constraint CKC_NMRID_MEASURES check (NMRID in (0,1))
);

comment on column MEASURES.NMRID is
'Наличае MRID';



begin
INSERT INTO measures(nmeasure,VNAME,vcode)VALUES(77,'События','EVENT');
commit;
exception
when others then rollback;
end;
/

update measures set NMRID=1 where (NMEASURE between 1 and 10) or (NMEASURE between 71 and 77);
update measures set NMRID=0 where not ((NMEASURE between 1 and 10) or (NMEASURE between 71 and 77));
commit;


----------------------------------------------------------------------------------------------
--  10/07/2009    VER 2.32.4 (Для обновления версии 2.32.3 до текущей скрипт запускать отсюда)      
----------------------------------------------------------------------------------------------
begin
insert into ADDFORMPARAM(NSORT,VDESCR,NTYPE) values(-7,'Вывод метки качества',1);
insert into ADDFORMPARAM(NSORT,VDESCR,NTYPE) values(-8,'Вывод тарифной зоны',1);
commit;
end;
/

begin
begin execute immediate 'drop package ICCP_PG'; exception when others then null; end;
begin execute immediate 'drop package INTERIOR_R_PG'; exception when others then null; end;
begin execute immediate 'drop package LOSS_REPLACEMENT_PG'; exception when others then null; end;
end;
/

---13/07/2009
INSERT INTO deportprocedures("NPROCEDURE","VNAME","VPROCEDURE","NPERIOD","NTYPE","VMEMO")VALUES(60,'Макет 30817 с меткой качества','ryda.reports1_pg.m30817qm_p',2,0,'Макет 30817 с меткой качества');
commit;

INSERT INTO deportprocedures("NPROCEDURE","VNAME","VPROCEDURE","NPERIOD","NTYPE","VMEMO")VALUES(61,'Макет Отчет','ryda.reports4_pg.report_p',2,0,'Макет Отчет');
commit;

--14/07/2009
begin
update meterstatusbitdict set NVALIDITY=2, NQM=6 where NMETERTYPE=1 and NBIT=2;
update meterstatusbitdict set NVALIDITY=1, NQM=9 where NMETERTYPE=1 and NBIT=3;
update meterstatusbitdict set NVALIDITY=1, NQM=9 where NMETERTYPE=1 and NBIT=4;
update meterstatusbitdict set NVALIDITY=0, NQM=0 where NMETERTYPE=1 and NBIT=5;
update meterstatusbitdict set NVALIDITY=2, NQM=6 where NMETERTYPE=1 and NBIT=6;
update meterstatusbitdict set NVALIDITY=1, NQM=9 where NMETERTYPE=1 and NBIT=7;
update meterstatusbitdict set NVALIDITY=2, NQM=6 where NMETERTYPE=1 and NBIT=10;
update meterstatusbitdict set NVALIDITY=1, NQM=9 where NMETERTYPE=1 and NBIT=11;
update meterstatusbitdict set NVALIDITY=1, NQM=9 where NMETERTYPE=1 and NBIT=12;
update meterstatusbitdict set NVALIDITY=0, NQM=0 where NMETERTYPE=1 and NBIT=13;
update meterstatusbitdict set NVALIDITY=2, NQM=6 where NMETERTYPE=1 and NBIT=14;
update meterstatusbitdict set NVALIDITY=1, NQM=9 where NMETERTYPE=1 and NBIT=15;
update meterstatusbitdict set NVALIDITY=2, NQM=6 where NMETERTYPE=1 and NBIT=18;
update meterstatusbitdict set NVALIDITY=1, NQM=9 where NMETERTYPE=1 and NBIT=19;
update meterstatusbitdict set NVALIDITY=1, NQM=9 where NMETERTYPE=1 and NBIT=20;
update meterstatusbitdict set NVALIDITY=0, NQM=0 where NMETERTYPE=1 and NBIT=21;
update meterstatusbitdict set NVALIDITY=2, NQM=6 where NMETERTYPE=1 and NBIT=22;
update meterstatusbitdict set NVALIDITY=1, NQM=9 where NMETERTYPE=1 and NBIT=23;
update meterstatusbitdict set NVALIDITY=2, NQM=6 where NMETERTYPE=1 and NBIT=26;
update meterstatusbitdict set NVALIDITY=1, NQM=9 where NMETERTYPE=1 and NBIT=27;
update meterstatusbitdict set NVALIDITY=1, NQM=9 where NMETERTYPE=1 and NBIT=28;
update meterstatusbitdict set NVALIDITY=0, NQM=0 where NMETERTYPE=1 and NBIT=29;
update meterstatusbitdict set NVALIDITY=2, NQM=6 where NMETERTYPE=1 and NBIT=30;
update meterstatusbitdict set NVALIDITY=1, NQM=9 where NMETERTYPE=1 and NBIT=31;
update meterstatusbitdict set NVALIDITY=2, NQM=6 where NMETERTYPE=3 and NBIT=0;
update meterstatusbitdict set NVALIDITY=1, NQM=4 where NMETERTYPE=3 and NBIT=1;
update meterstatusbitdict set NVALIDITY=1, NQM=9 where NMETERTYPE=3 and NBIT=2;
update meterstatusbitdict set NVALIDITY=0, NQM=0 where NMETERTYPE=3 and NBIT=3;
update meterstatusbitdict set NVALIDITY=0, NQM=0 where NMETERTYPE=3 and NBIT=4;
update meterstatusbitdict set NVALIDITY=0, NQM=0 where NMETERTYPE=3 and NBIT=5;
update meterstatusbitdict set NVALIDITY=1, NQM=9 where NMETERTYPE=3 and NBIT=6;
update meterstatusbitdict set NVALIDITY=1, NQM=9 where NMETERTYPE=3 and NBIT=7;
update meterstatusbitdict set NVALIDITY=0, NQM=0 where NMETERTYPE=3 and NBIT=8;
update meterstatusbitdict set NVALIDITY=0, NQM=0 where NMETERTYPE=3 and NBIT=9;
update meterstatusbitdict set NVALIDITY=0, NQM=0 where NMETERTYPE=3 and NBIT=10;
update meterstatusbitdict set NVALIDITY=0, NQM=0 where NMETERTYPE=3 and NBIT=11;
update meterstatusbitdict set NVALIDITY=0, NQM=0 where NMETERTYPE=3 and NBIT=12;
update meterstatusbitdict set NVALIDITY=1, NQM=8 where NMETERTYPE=3 and NBIT=13;
update meterstatusbitdict set NVALIDITY=2, NQM=6 where NMETERTYPE=3 and NBIT=14;
update meterstatusbitdict set NVALIDITY=0, NQM=0 where NMETERTYPE=3 and NBIT=15;
update meterstatusbitdict set NVALIDITY=0, NQM=0 where NMETERTYPE=3 and NBIT=16;
update meterstatusbitdict set NVALIDITY=0, NQM=0 where NMETERTYPE=3 and NBIT=17;
update meterstatusbitdict set NVALIDITY=0, NQM=0 where NMETERTYPE=3 and NBIT=18;
update meterstatusbitdict set NVALIDITY=0, NQM=0 where NMETERTYPE=3 and NBIT=19;
update meterstatusbitdict set NVALIDITY=0, NQM=0 where NMETERTYPE=3 and NBIT=20;
update meterstatusbitdict set NVALIDITY=1, NQM=8 where NMETERTYPE=3 and NBIT=21;
update meterstatusbitdict set NVALIDITY=1, NQM=9 where NMETERTYPE=3 and NBIT=22;
update meterstatusbitdict set NVALIDITY=1, NQM=9 where NMETERTYPE=3 and NBIT=23;
commit;
end;
/

CREATE SEQUENCE uppdoperation_seq
  INCREMENT BY 1
  START WITH 1000
  MAXVALUE 999999999999999999999999999
  NOCYCLE
  NOORDER
  CACHE 20
/

/*==============================================================*/
/* Table: UPPDSTAT                                              */
/*==============================================================*/
create table UPPDSTAT  (
   NOPERATION           NUMBER(10)                      not null,
   CID                  NUMBER(10)                      not null,
   DDATE                DATE                            not null,
   DENTER               DATE                           default sysdate not null,
   NSTATE               NUMBER(1)                      default 0 not null
      constraint CKC_NSTATE_UPPDSTAT check (NSTATE in (0,1,2)),
   DSEND                DATE,
   VERROR               VARCHAR2(2000),
   USER_ID              NUMBER,
   NNOTFULL             NUMBER(1)                      default 0 not null
      constraint CKC_NNOTFULL_UPPDSTAT check (NNOTFULL in (0,1)),
   constraint PK_UPPDSTAT primary key (NOPERATION)
);

comment on table UPPDSTAT is
'Статистика УППД';

comment on column UPPDSTAT.NOPERATION is
'Ид операции';

comment on column UPPDSTAT.CID is
'Ид канала';

comment on column UPPDSTAT.DDATE is
'Дата данных';

comment on column UPPDSTAT.DENTER is
'Дата создания';

comment on column UPPDSTAT.NSTATE is
'Состояние';

comment on column UPPDSTAT.DSEND is
'Дата отсылки или ошибки';

comment on column UPPDSTAT.VERROR is
'Доп инфо при отсылке';

comment on column UPPDSTAT.USER_ID is
'Ид пользователя';

comment on column UPPDSTAT.NNOTFULL is
'Неполные данные';

/*==============================================================*/
/* Index: UPPDSTAT_IDX1                                         */
/*==============================================================*/
create index UPPDSTAT_IDX1 on UPPDSTAT (
   CID ASC,
   DDATE ASC
);

/*==============================================================*/
/* Index: UPPDSTAT_IDX2                                         */
/*==============================================================*/
create index UPPDSTAT_IDX2 on UPPDSTAT (
   USER_ID ASC
);

alter table UPPDSTAT
   add constraint UPPDSTAT_F1 foreign key (CID)
      references CHANNELS (CID)
      on delete cascade;

/*==============================================================*/
/* Table: UPPDDATA                                              */
/*==============================================================*/
create table UPPDDATA  (
   NOPERATION           NUMBER(10)                      not null,
   NGROUP               NUMBER(10)                      not null,
   NORDER               NUMBER(10)                      not null,
   NVALUE               NUMBER,
   constraint PK_UPPDDATA primary key (NOPERATION, NGROUP, NORDER)
);

comment on table UPPDDATA is
'Данные УППД';

comment on column UPPDDATA.NOPERATION is
'Ид операции';

comment on column UPPDDATA.NGROUP is
'Ид группы';

comment on column UPPDDATA.NORDER is
'Номер данных (час 0 это сутки)';

comment on column UPPDDATA.NVALUE is
'Значение';

/*==============================================================*/
/* Index: UPPDDATA_IDX1                                         */
/*==============================================================*/
create index UPPDDATA_IDX1 on UPPDDATA (
   NGROUP ASC
);

alter table UPPDDATA
   add constraint UPPDDATA_F1 foreign key (NOPERATION)
      references UPPDSTAT (NOPERATION)
      on delete cascade;

alter table UPPDDATA
   add constraint UPPDDATA_F2 foreign key (NGROUP)
      references MAKETGROUPS (NGROUP)
      on delete cascade;


--15/07/2009
/*==============================================================*/
/* Index: MRIDS_IDX1                                            */
/*==============================================================*/
drop index MRIDS_IDX1;

create index MRIDS_IDX1 on MRIDS (
   MRID ASC
);

begin
update meterstatusbitdict set NVALIDITY=2,NQM=6 where NMETERTYPE=1 and NBIT=2;
update meterstatusbitdict set NVALIDITY=0,NQM=0 where NMETERTYPE=1 and NBIT=3;
update meterstatusbitdict set NVALIDITY=0,NQM=0 where NMETERTYPE=1 and NBIT=4;
update meterstatusbitdict set NVALIDITY=0,NQM=0 where NMETERTYPE=1 and NBIT=5;
update meterstatusbitdict set NVALIDITY=2,NQM=6 where NMETERTYPE=1 and NBIT=6;
update meterstatusbitdict set NVALIDITY=0,NQM=0 where NMETERTYPE=1 and NBIT=7;
update meterstatusbitdict set NVALIDITY=2,NQM=6 where NMETERTYPE=1 and NBIT=10;
update meterstatusbitdict set NVALIDITY=0,NQM=0 where NMETERTYPE=1 and NBIT=11;
update meterstatusbitdict set NVALIDITY=0,NQM=0 where NMETERTYPE=1 and NBIT=12;
update meterstatusbitdict set NVALIDITY=0,NQM=0 where NMETERTYPE=1 and NBIT=13;
update meterstatusbitdict set NVALIDITY=2,NQM=6 where NMETERTYPE=1 and NBIT=14;
update meterstatusbitdict set NVALIDITY=0,NQM=0 where NMETERTYPE=1 and NBIT=15;
update meterstatusbitdict set NVALIDITY=2,NQM=6 where NMETERTYPE=1 and NBIT=18;
update meterstatusbitdict set NVALIDITY=0,NQM=0 where NMETERTYPE=1 and NBIT=19;
update meterstatusbitdict set NVALIDITY=0,NQM=0 where NMETERTYPE=1 and NBIT=20;
update meterstatusbitdict set NVALIDITY=0,NQM=0 where NMETERTYPE=1 and NBIT=21;
update meterstatusbitdict set NVALIDITY=2,NQM=6 where NMETERTYPE=1 and NBIT=22;
update meterstatusbitdict set NVALIDITY=0,NQM=0 where NMETERTYPE=1 and NBIT=23;
update meterstatusbitdict set NVALIDITY=2,NQM=6 where NMETERTYPE=1 and NBIT=26;
update meterstatusbitdict set NVALIDITY=0,NQM=0 where NMETERTYPE=1 and NBIT=27;
update meterstatusbitdict set NVALIDITY=0,NQM=0 where NMETERTYPE=1 and NBIT=28;
update meterstatusbitdict set NVALIDITY=0,NQM=0 where NMETERTYPE=1 and NBIT=29;
update meterstatusbitdict set NVALIDITY=2,NQM=6 where NMETERTYPE=1 and NBIT=30;
update meterstatusbitdict set NVALIDITY=0,NQM=0 where NMETERTYPE=1 and NBIT=31;
update meterstatusbitdict set NVALIDITY=2,NQM=6 where NMETERTYPE=3 and NBIT=0;
update meterstatusbitdict set NVALIDITY=1,NQM=4 where NMETERTYPE=3 and NBIT=1;
update meterstatusbitdict set NVALIDITY=1,NQM=9 where NMETERTYPE=3 and NBIT=2;
update meterstatusbitdict set NVALIDITY=0,NQM=0 where NMETERTYPE=3 and NBIT=3;
update meterstatusbitdict set NVALIDITY=0,NQM=0 where NMETERTYPE=3 and NBIT=4;
update meterstatusbitdict set NVALIDITY=0,NQM=0 where NMETERTYPE=3 and NBIT=5;
update meterstatusbitdict set NVALIDITY=1,NQM=9 where NMETERTYPE=3 and NBIT=6;
update meterstatusbitdict set NVALIDITY=1,NQM=9 where NMETERTYPE=3 and NBIT=7;
update meterstatusbitdict set NVALIDITY=0,NQM=0 where NMETERTYPE=3 and NBIT=8;
update meterstatusbitdict set NVALIDITY=0,NQM=0 where NMETERTYPE=3 and NBIT=9;
update meterstatusbitdict set NVALIDITY=0,NQM=0 where NMETERTYPE=3 and NBIT=10;
update meterstatusbitdict set NVALIDITY=0,NQM=0 where NMETERTYPE=3 and NBIT=11;
update meterstatusbitdict set NVALIDITY=0,NQM=0 where NMETERTYPE=3 and NBIT=12;
update meterstatusbitdict set NVALIDITY=1,NQM=8 where NMETERTYPE=3 and NBIT=13;
update meterstatusbitdict set NVALIDITY=2,NQM=6 where NMETERTYPE=3 and NBIT=14;
update meterstatusbitdict set NVALIDITY=0,NQM=0 where NMETERTYPE=3 and NBIT=15;
update meterstatusbitdict set NVALIDITY=0,NQM=0 where NMETERTYPE=3 and NBIT=16;
update meterstatusbitdict set NVALIDITY=0,NQM=0 where NMETERTYPE=3 and NBIT=17;
update meterstatusbitdict set NVALIDITY=0,NQM=0 where NMETERTYPE=3 and NBIT=18;
update meterstatusbitdict set NVALIDITY=0,NQM=0 where NMETERTYPE=3 and NBIT=19;
update meterstatusbitdict set NVALIDITY=0,NQM=0 where NMETERTYPE=3 and NBIT=20;
update meterstatusbitdict set NVALIDITY=1,NQM=8 where NMETERTYPE=3 and NBIT=21;
update meterstatusbitdict set NVALIDITY=1,NQM=9 where NMETERTYPE=3 and NBIT=22;
update meterstatusbitdict set NVALIDITY=1,NQM=9 where NMETERTYPE=3 and NBIT=23;
commit;
end;
/

--17.07.2009
INSERT INTO deportprocedures("NPROCEDURE","VNAME","VPROCEDURE","NPERIOD","NTYPE","VMEMO")VALUES(62,'Макет Отчет месячный','ryda.reports4_pg.reportm_p',5,0,'Макет Отчет месячный');
update deportprocedures set VNAME='Макет Отчет суточный',VMEMO='Макет Отчет суточный' where NPROCEDURE=61;
commit;


----------------------------------------------------------------------------------------------
--  22/07/2009    VER 2.32.6 (Для обновления версии 2.32.5 до текущей скрипт запускать отсюда)      
----------------------------------------------------------------------------------------------
begin
insert into ADDFORMPARAM(NSORT,VDESCR,NTYPE) values(-9,'Вывод часового пояса',1);
commit;
end;
/

INSERT INTO deportprocedures
("NPROCEDURE","VNAME","VPROCEDURE","NPERIOD","NTYPE","VMEMO")
VALUES
(63,'Макет АСКП','reports1_pg.mASKP_p',2,0,'Макет АСКП')
/
INSERT INTO deportprocedures
("NPROCEDURE","VNAME","VPROCEDURE","NPERIOD","NTYPE","VMEMO")
VALUES
(64,'Макет LG','ryda.reports1_pg.mLG_p',2,0,'Макет LG')
/

----------------------------------------------------------------------------------------------
--  29/07/2009    VER 2.32.8 (Для обновления версии 2.32.7 до текущей скрипт запускать отсюда)      
----------------------------------------------------------------------------------------------
declare
l NUMBER;
begin
insert into parameter (NPID,VVALUE,VDESCRIPTION) values(44,0,'УППД - всегда 25 значений');
commit;
end;
/

alter table UPPDDATA  add(
   NQM                  NUMBER
);

comment on column UPPDDATA.NQM is
'Достоверность';

INSERT INTO RYDA.PROTOCOLS VALUES(100,'УППД - Клиент (v.2)','');
commit;

declare
l NUMBER;
begin
insert into parameter (NPID,VVALUE,VDESCRIPTION) values(45,0,'Блокировка перерасчета после удаления данных');
commit;
end;
/


----------------------------------------------------------------------------------------------
--  26/08/2009    VER 2.33.2 (Для обновления версии 2.31.8 до текущей скрипт запускать отсюда)      
----------------------------------------------------------------------------------------------
begin
execute immediate 'grant execute on POINTCALC_PG to askuerep';
exception when others then null;
end ;
/


--09/09/2009
alter table LAST_SAVE  add(
   DPARAMETRIZATION     DATE
);

comment on column LAST_SAVE.DPARAMETRIZATION is
'Дата параметризации';


------------------29/09/2009
INSERT INTO RYDA.PROTOCOLS
VALUES
(101,'EMH LZQJ','')
/
INSERT INTO RYDA.PROTOCOLS
VALUES
(102,'A1R Альфа (коммерч)','')
/
COMMIT;

----------------------------------------------------------------------------------------------
--  26/08/2009    VER 2.34. (Для обновления версии 2.32.3 до текущей скрипт запускать отсюда)      
----------------------------------------------------------------------------------------------
INSERT INTO RYDA.PROTOCOLS VALUES(1010,'СЭБ-2А.07 (DLL)','Seb_2a_07.dll');
COMMIT;
                                  	 	
declare
l NUMBER;
begin
insert into parameter (NPID,VVALUE,VDESCRIPTION) values(46,1,'Коррекция времени только внутри интеграционного периода');
commit;
end;
/



----20/10/2009
alter table LAST_SAVE  add(
   DMETERCORRECT        DATE
);


comment on column LAST_SAVE.DMETERCORRECT is
'Дата последней коррекции времени';




---  20/11/2009 

INSERT INTO deportprocedures("NPROCEDURE","VNAME","VPROCEDURE","NPERIOD","NTYPE","VMEMO")VALUES(65,'Макет 30902','ryda.reports1_pg.m30902_p',5,0,'Макет 30902');
commit;


----23.12.2009
insert into deportprocedures values (66, 'Макет Отчет суточный с нарастающим итогом', 'ryda.reports4_pg.report_mon',2,0,'Макет Отчет суточный с нарастающим итогом');
commit;


--28.12.2009
alter table FEEDERS  add(
   NINTEGRALPERIOD      NUMBER                         default 30 not null
);

comment on column FEEDERS.NINTEGRALPERIOD is
'Базовый период интеграции';
----------------------------------------------------------------------------------------------
--  28/12/2009    VER 2.35 (Для обновления версии 2.34.2 до текущей скрипт запускать отсюда)      
----------------------------------------------------------------------------------------------
INSERT INTO addformparam("NSORT","VDESCR","NTYPE")VALUES(-10,'Вывод даты формирования',1);
commit;

--  04/01/2010
update points set ptype=null;
commit;

/*==============================================================*/
/* Table: SOURCETYPES                                           */
/*==============================================================*/
create table SOURCETYPES  (
   PTYPE                NUMBER                          not null,
   VNAME                VARCHAR2(32)                    not null,
   constraint PK_SOURCETYPES primary key (PTYPE)
);

comment on table SOURCETYPES is
'Виды источников';

comment on column SOURCETYPES.PTYPE is
'Ид источника';

comment on column SOURCETYPES.VNAME is
'Наименование источника';

/*==============================================================*/
/* Index: SOURCETYPES_IDX1                                      */
/*==============================================================*/
create unique index SOURCETYPES_IDX1 on SOURCETYPES (
   VNAME ASC
);

alter table POINTS
   add constraint POINTS_F2 foreign key (PTYPE)
      references SOURCETYPES (PTYPE);

insert into SOURCETYPES(PTYPE,VNAME) values(1,'Счетчик');
insert into SOURCETYPES(PTYPE,VNAME) values(2,'Макет');
insert into SOURCETYPES(PTYPE,VNAME) values(3,'Импульс');
insert into SOURCETYPES(PTYPE,VNAME) values(4,'Notebook');
insert into SOURCETYPES(PTYPE,VNAME) values(5,'Ручник');
commit;

----05.01.2010
CREATE OR REPLACE type numarray as table of number
/
CREATE OR REPLACE type strarray as table of VARCHAR2(4000)
/

comment on column POINTS.PTYPE is 'Источник данных';

----------------------------------------------------------------------------------------------
--12.01.2010      VER 2.35.3 (Для обновления версии 2.35.2 до текущей скрипт запускать отсюда)      
----------------------------------------------------------------------------------------------
INSERT INTO RYDA.PROTOCOLS VALUES(103,'A1R Альфа - Link','');
commit;


--13/01/2010
DECLARE
    at_paramname    common_pg.tt_varchar2;
    lv_ret          VARCHAR2(256);
    lv_formula      VARCHAR2(256);
    ln_varcount     NUMBER;
    ln_idexpr       NUMBER;
    ln_err          NUMBER;
    ln_nid          NUMBER;
    ln_cnt          NUMBER;
    ln_tmp          NUMBER DEFAULT 0;
    ln_ispar        NUMBER DEFAULT 0;
    error           EXCEPTION;
    error1           EXCEPTION;
    
BEGIN  
    FOR lc IN (SELECT nid, vformula FROM pointformula)
    LOOP
       ln_idexpr := parser_pg.newexpression (lc.vformula);
        IF ln_idexpr < 0 THEN
            ln_nid := lc.nid;
            lv_formula := lc.vformula;
            RAISE error;
        ELSE
            ln_varcount := parser_pg.getnbusedvars (ln_idexpr);
            IF ln_varcount >= 0  THEN
                SELECT count(*) INTO ln_cnt FROM formulparams f WHERE f.nid = lc.nid;
                UPDATE formulparams f SET f.norder = f.norder+ln_cnt WHERE f.nid = lc.nid;
                at_paramname.delete;
                FOR i IN 1 .. ln_varcount LOOP
                    lv_ret := '';
                    ln_err := parser_pg.getusedvar (ln_idexpr, i - 1, lv_ret, 256);
                    at_paramname (i) := lv_ret;
                END LOOP;
                IF at_paramname.count < ln_cnt THEN
                    FOR z IN (SELECT vname FROM formulparams f WHERE f.nid = lc.nid) LOOP
                        ln_tmp := 0;
                        FOR ii IN 1..at_paramname.count LOOP
                            IF z.vname = at_paramname (ii)THEN 
                                ln_tmp := 1;
                            END IF;
                        END LOOP;     
                        IF ln_tmp = 0  THEN
                        				DELETE FROM  formulparams ff WHERE ff.nid=lc.nid AND ff.vname = z.vname;
                        END IF;
                    END LOOP;
                END IF;
                FOR k IN 1 .. at_paramname.count LOOP
                    ln_ispar := 0;
                    select count(*) into ln_ispar from formulparams t WHERE t.nid = lc.nid AND t.vname = at_paramname(k);
                    IF ln_ispar = 0 THEN
                        ln_nid := lc.nid;
                        lv_formula := lc.vformula;
                        RAISE error1;
                    END IF;
                    UPDATE formulparams f SET f.norder = k WHERE f.nid = lc.nid 
                    AND f.vname = at_paramname(k);
                END LOOP; 
            END IF;
        END IF;
    END LOOP;
    COMMIT;
    EXCEPTION
    WHEN error THEN 
        ROLLBACK;
        raise_application_error (-20001, 'Ошибка в формуле '||lv_formula||' ИД формулы:' || ln_nid);
    WHEN error1 THEN 
        ROLLBACK;
        raise_application_error (-20001, 'В формуле '||lv_formula||' ИД формулы:' || ln_nid||' кол-во параметров неверно');
    WHEN OTHERS THEN 
        ROLLBACK;
        raise_application_error (-20001, 'PARSER_PG: ' || SQLERRM (SQLCODE));
END;
/

------------15/01/2010
/*==============================================================*/
/* Table: USERFORUM                                             */
/*==============================================================*/
create table USERFORUM  (
   NMESSAGE             NUMBER(10)                      not null,
   DDATE                DATE                           default sysdate not null,
   USER_ID              NUMBER                          not null,
   VSUBJECT             VARCHAR2(128)                   not null,
   VMESSAGE             VARCHAR2(2000),
   constraint PK_USERFORUM primary key (NMESSAGE)
);

comment on table USERFORUM is
'Форум пользователей';

comment on column USERFORUM.NMESSAGE is
'Ид сообщения';

comment on column USERFORUM.DDATE is
'Дата сообщения';

comment on column USERFORUM.USER_ID is
'Ид пользователя';

comment on column USERFORUM.VSUBJECT is
'Тема сообщения';

comment on column USERFORUM.VMESSAGE is
'Текст сообщения';

/*==============================================================*/
/* Index: USERSFORUM_IDX2                                       */
/*==============================================================*/
create index USERSFORUM_IDX2 on USERFORUM (
   DDATE ASC
);

/*==============================================================*/
/* Index: USERSFORUM_IDX1                                       */
/*==============================================================*/
create index USERSFORUM_IDX1 on USERFORUM (
   USER_ID ASC,
   DDATE ASC
);

alter table USERFORUM
   add constraint USERFORUM_F1 foreign key (USER_ID)
      references USERS (USER_ID)
      on delete cascade;

/*==============================================================*/
/* Table: USERFORUMDET                                          */
/*==============================================================*/
create table USERFORUMDET  (
   NMESSAGE             NUMBER(10)                      not null,
   DDATE                DATE                           default sysdate not null,
   USER_ID              NUMBER                          not null,
   VMESSAGE             VARCHAR2(2000)                  not null,
   constraint PK_USERFORUMDET primary key (NMESSAGE, DDATE, USER_ID)
);

comment on table USERFORUMDET is
'Форум детализация';

comment on column USERFORUMDET.NMESSAGE is
'Ид сообщения';

comment on column USERFORUMDET.DDATE is
'Дата ответа';

comment on column USERFORUMDET.USER_ID is
'Ид пользователя';

comment on column USERFORUMDET.VMESSAGE is
'Текст ответа';

/*==============================================================*/
/* Index: USERSFORUMDET_IDX1                                    */
/*==============================================================*/
create index USERSFORUMDET_IDX1 on USERFORUMDET (
   DDATE ASC
);

/*==============================================================*/
/* Index: USERSFORUMDET_IDX2                                    */
/*==============================================================*/
create index USERSFORUMDET_IDX2 on USERFORUMDET (
   USER_ID ASC
);

alter table USERFORUMDET
   add constraint USERFORUMDET_F1 foreign key (NMESSAGE)
      references USERFORUM (NMESSAGE)
      on delete cascade;

alter table USERFORUMDET
   add constraint USERFORUMDET_F2 foreign key (USER_ID)
      references USERS (USER_ID);

---18/01/2010
CREATE SEQUENCE USERFORUM_SEQ INCREMENT BY  1 START WITH  1001 CACHE 20;


----------------------------------------------------------------------------------------------
--18.01.2010      VER 2.34.4 (Для обновления версии 2.34.3 до текущей скрипт запускать отсюда)      
----------------------------------------------------------------------------------------------

-----
---08/11/2006
declare
ln_customer_id NUMBER;
begin
SELECT NVL(SUM(DECODE(vvalue, '', 0, vvalue)), 0)   INTO ln_customer_id   FROM parameter  WHERE npid = 12;
if ln_customer_id in (1) then
INSERT INTO tasks
(TASK_ID,PARENT,TASK_COD,NAME,REMARK,nshow)
VALUES
(104,80,660,'9.06 Форум пользователей','9.06 Форум пользователей',0);

insert into role_task
select ROLE_ID,104,decode(ROLE_ID,1,1,0) from roles;

commit;
end if;
end;
/

--09.02.2010
alter table DB_TERM  add(
   INDEX_NAME           VARCHAR2(50)
);

comment on column DB_TERM.INDEX_NAME is
'Наименование индекса для hint';

--11.02.2010
declare
l NUMBER;
begin
select count(*) into l from parameter where NPID=12 and vvalue='1';
IF l>0 THEN --для ХОЭ
    update parameter set VVALUE=3,VDESCRIPTION='Тип инверсии на т. учета. 1-условная, 2-всегда,3-условная обратная (ХОЭ), иначе никогда' where NPID=42;
else
    update parameter set VDESCRIPTION='Тип инверсии на т. учета 1-условная, 2-всегда,3-условная обратная (ХОЭ), иначе никогда' where NPID=42;
END IF;
commit;
end;
/

----------------------------------------------------------------------------------------------
--17.03.2010      VER 2.34.5 (Для обновления версии 2.34.4 до текущей скрипт запускать отсюда)      
----------------------------------------------------------------------------------------------
begin
insert into parameter (NPID,VVALUE,VDESCRIPTION) values(47,'','Наименование родительской БД');
commit;
end;
/

INSERT INTO deportprocedures("NPROCEDURE","VNAME","VPROCEDURE","NPERIOD","NTYPE","VMEMO")VALUES(67,'Синхронизация с главной БД','SYNHRON_PG.synhrondb',0,1,'Синхронизация с главной БД');
commit;

--18/02/2010
drop view BILL_L;
drop view BILL_OL;
drop view HALFHOUR_L;
drop view HALFHOUR_OL;

CREATE OR REPLACE VIEW halfhour(mid,date_time,er,q1,ed,q3,q2,q4,erm,q1m,edm,q3m,q2m,q4m,status,nkc,nsource,er_mtrsn,nswitch,denter,vqm,nmetertype)
AS SELECT MID,DATE_TIME,ER,Q1,ED,Q3,Q2,Q4,ERM,Q1M,EDM,Q3M,Q2M,Q4M,STATUS,NKC,NSOURCE,ER_MTRSN,NSWITCH,DENTER,VQM,nmetertype FROM HALFHOUROLD WHERE NEXCEPTCALC IS NULL;


-- Start of DDL Script for View RYDA.BILL
-- Generated 18.02.2010 9:39:40 from RYDA@oe

CREATE OR REPLACE VIEW bill (mid,date_time,valid,source,remark,
er_mtrsn,er_kc,erm,er,aerm,aer,berm,ber,cerm,cer,derm,der,q1_mtrsn,q1_kc,q1m,q1,aq1m,aq1,bq1m,bq1,cq1m,cq1,dq1m,dq1,ed_mtrsn,ed_kc,edm,ed,aedm,aed,bedm,bed,cedm,
ced,dedm,ded,q3_mtrsn,q3_kc,q3m,q3,aq3m,aq3,bq3m,bq3,cq3m,cq3,dq3m,dq3,q2_mtrsn,q2_kc,q2m,q2,aq2m,aq2,bq2m,bq2,cq2m,cq2,dq2m,dq2,q4_mtrsn,q4_kc,q4m,q4,aq4m,aq4,
bq4m,bq4,cq4m,cq4,dq4m,dq4,nwasteabs,nsource,vqm)
AS SELECT MID, DATE_TIME, VALID, SOURCE, REMARK, ER_MTRSN, ER_KC, ERM, ER, AERM, AER, BERM, BER, CERM, CER, DERM, DER, Q1_MTRSN, Q1_KC, Q1M, Q1, AQ1M, AQ1, BQ1M, BQ1, CQ1M,
 CQ1, DQ1M, DQ1, ED_MTRSN, ED_KC, EDM, ED, AEDM, AED, BEDM, BED, CEDM, CED, DEDM, DED, Q3_MTRSN, Q3_KC, Q3M, Q3, AQ3M, AQ3, BQ3M, BQ3, CQ3M, CQ3, DQ3M, DQ3, Q2_MTRSN, Q2_KC,
 Q2M, Q2, AQ2M, AQ2, BQ2M, BQ2, CQ2M, CQ2, DQ2M, DQ2, Q4_MTRSN, Q4_KC, Q4M, Q4, AQ4M, AQ4, BQ4M, BQ4, CQ4M, CQ4, DQ4M, DQ4, NWASTEABS, NSOURCE, VQM
 FROM BILLOLD;


--18.02.2010
declare
l NUMBER;
begin
select count(*) into l from parameter where NPID=12 and vvalue='1';
insert into parameter (NPID,VVALUE,VDESCRIPTION) values(50,l,'Оптимизатор +ordered для мониторов и расчета');
commit;
end;
/

--19/02/2010
declare
l NUMBER;
begin
select nvl(max(decode(vvalue,'0',1,'41',1,'42',1,'43',1,'44',1,'45',1,'46',1,0)),0) into l from parameter where NPID=12;
if l=1 then
INSERT INTO tasks(TASK_ID,PARENT,TASK_COD,NAME,REMARK,NSHOW) VALUES (105,56,661,'3.5 Мониторинг ICCP','',1);
insert into role_task select ROLE_ID,103,decode(ROLE_ID,1,1,0) from roles;
commit;
end if;
exception when others then null;
end; 
/


/*==============================================================*/
/* Table: DBMAIN                                                */
/*==============================================================*/
create table DBMAIN  (
   NID                  NUMBER                          not null,
   NTYPE                NUMBER(1)                      default 0 not null
      constraint CKC_NTYPE_DBMAIN check (NTYPE in (0,1)),
   constraint PK_DBMAIN primary key (NID, NTYPE)
);

comment on table DBMAIN is
'Главная БД';

comment on column DBMAIN.NID is
'Ид параметра';

comment on column DBMAIN.NTYPE is
'Тип параметра';

/*==============================================================*/
/* Index: DBMAIN_IDX1                                           */
/*==============================================================*/
create unique index DBMAIN_IDX1 on DBMAIN (
   NID ASC
);

begin
INSERT INTO points(MID,PARENT,COD,IND,NAME,SHORT_NAME,PTYPE,IMPLEMENT_DATE,TAG,NPOINT) VALUES(55,NULL,NULL,1,'Службы ICCP','',NULL,'',NULL,NULL);
commit;
end;
/

--23/02/2010
--begin INSERT INTO RYDA.PROTOCOLS VALUES (104,'A1800 Альфа',''); commit; end;
--/

INSERT INTO RYDA.METERTYPE VALUES(30,'A1800'); 
commit;





----------------------------------------------------------------------------------------------
--26.01.2010      VER 2.34.7 (Для обновления версии 2.34.6 до текущей скрипт запускать отсюда)      
----------------------------------------------------------------------------------------------
create table HALFHOURARCH  (
   NID                  NUMBER(10)                      not null,
   DID                  DATE                           default sysdate not null,
   MID                  NUMBER                          not null,
   DATE_TIME            DATE                            not null,
   NSOURCE              NUMBER(10)                      not null,
   ER                   NUMBER,
   Q1                   NUMBER,
   ED                   NUMBER,
   Q3                   NUMBER,
   Q2                   NUMBER,
   Q4                   NUMBER,
   ERM                  NUMBER,
   Q1M                  NUMBER,
   EDM                  NUMBER,
   Q3M                  NUMBER,
   Q2M                  NUMBER,
   Q4M                  NUMBER,
   STATUS               NUMBER,
   NSWITCH              NUMBER,
   NEXCEPTCALC          NUMBER(1),
   DCLOSED              DATE,
   NKC                  NUMBER,
   ER_MTRSN             VARCHAR2(20),
   DENTER               DATE                            not null,
   VQM                  VARCHAR2(32),
   NMETERTYPE           NUMBER(10),
   constraint PK_HALFHOURARCH primary key (NID)
);

comment on table HALFHOURARCH is
'Получасовки архив';

comment on column HALFHOURARCH.NID is
'Ид записи';

comment on column HALFHOURARCH.DID is
'Дата фиксации';

comment on column HALFHOURARCH.MID is
'Ид точки';

comment on column HALFHOURARCH.DATE_TIME is
'Дата показаний';

comment on column HALFHOURARCH.NSOURCE is
'Код источника';

comment on column HALFHOURARCH.ER is
'Расход А пр';

comment on column HALFHOURARCH.Q1 is
'Расход Q1';

comment on column HALFHOURARCH.ED is
'Расход А от';

comment on column HALFHOURARCH.Q3 is
'Расход Q3';

comment on column HALFHOURARCH.Q2 is
'Расход Q2';

comment on column HALFHOURARCH.Q4 is
'Расход Q4';

comment on column HALFHOURARCH.ERM is
'Показания А пр';

comment on column HALFHOURARCH.Q1M is
'Показания Q1';

comment on column HALFHOURARCH.EDM is
'Показания А от';

comment on column HALFHOURARCH.Q3M is
'Показания Q3';

comment on column HALFHOURARCH.Q2M is
'Показания Q2';

comment on column HALFHOURARCH.Q4M is
'Показания Q4';

comment on column HALFHOURARCH.STATUS is
'Статус';

comment on column HALFHOURARCH.NSWITCH is
'Ид обводника';

comment on column HALFHOURARCH.NEXCEPTCALC is
'Исключен из расчета';

comment on column HALFHOURARCH.DCLOSED is
'Дата закрытия суток';

comment on column HALFHOURARCH.NKC is
'Коеф счетчика';

comment on column HALFHOURARCH.ER_MTRSN is
'Номер счетчика';

comment on column HALFHOURARCH.DENTER is
'Дата попадания';

comment on column HALFHOURARCH.VQM is
'Метка качества';

comment on column HALFHOURARCH.NMETERTYPE is
'Тип счетчика';

/*==============================================================*/
/* Index: HALFHOURARCH_IDX1                                     */
/*==============================================================*/
create index HALFHOURARCH_IDX1 on HALFHOURARCH (
   MID ASC,
   DATE_TIME ASC
);

alter table HALFHOURARCH
   add constraint HALFHOURARCH_F1 foreign key (MID)
      references POINTS (MID)
      on delete cascade;

create sequence HALFHOURARCH_SEQ increment by 1 start with 1000;


/*
Только для ХОЭ

-- Start of DDL Script for Trigger RYDA.HALFHOUROLD_UPD
-- Generated 2-ia?-2010 11:18:54 from RYDA@ASKUE

CREATE OR REPLACE TRIGGER halfhourold_upd
 AFTER
  DELETE OR UPDATE
 ON halfhourold
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
declare
ln_ind NUMBER;
BEGIN
 select nvl(max(ind),0) into ln_ind from points where mid=:NEW.mid;
 if ln_ind<>3 then
 return;
 end if;
 IF :OLD.mid <> :NEW.mid OR (:OLD.mid IS NULL AND :NEW.mid IS NOT NULL) OR (:OLD.mid IS NOT NULL AND :NEW.mid IS NULL) OR :OLD.date_time <> :NEW.date_time
    OR (:OLD.date_time IS NULL AND :NEW.date_time IS NOT NULL) OR (:OLD.date_time IS NOT NULL AND :NEW.date_time IS NULL) OR :OLD.er <> :NEW.er
    OR (:OLD.er IS NULL AND :NEW.er IS NOT NULL) OR (:OLD.er IS NOT NULL AND :NEW.er IS NULL) OR :OLD.q1 <> :NEW.q1 OR (:OLD.q1 IS NULL AND :NEW.q1 IS NOT NULL)
    OR (:OLD.q1 IS NOT NULL AND :NEW.q1 IS NULL) OR :OLD.ed <> :NEW.ed OR (:OLD.ed IS NULL AND :NEW.ed IS NOT NULL) OR (:OLD.ed IS NOT NULL AND :NEW.ed IS NULL)
    OR :OLD.q3 <> :NEW.q3 OR (:OLD.q3 IS NULL AND :NEW.q3 IS NOT NULL) OR (:OLD.q3 IS NOT NULL AND :NEW.q3 IS NULL) OR :OLD.q2 <> :NEW.q2
    OR (:OLD.q2 IS NULL AND :NEW.q2 IS NOT NULL) OR (:OLD.q2 IS NOT NULL AND :NEW.q2 IS NULL) OR :OLD.q4 <> :NEW.q4 OR (:OLD.q4 IS NULL AND :NEW.q4 IS NOT NULL)
    OR (:OLD.q4 IS NOT NULL AND :NEW.q4 IS NULL) OR :OLD.erm <> :NEW.erm OR (:OLD.erm IS NULL AND :NEW.erm IS NOT NULL)
    OR (:OLD.erm IS NOT NULL AND :NEW.erm IS NULL) OR :OLD.q1m <> :NEW.q1m OR (:OLD.q1m IS NULL AND :NEW.q1m IS NOT NULL)
    OR (:OLD.q1m IS NOT NULL AND :NEW.q1m IS NULL) OR :OLD.edm <> :NEW.edm OR (:OLD.edm IS NULL AND :NEW.edm IS NOT NULL)
    OR (:OLD.edm IS NOT NULL AND :NEW.edm IS NULL) OR :OLD.q3m <> :NEW.q3m OR (:OLD.q3m IS NULL AND :NEW.q3m IS NOT NULL)
    OR (:OLD.q3m IS NOT NULL AND :NEW.q3m IS NULL) OR :OLD.q2m <> :NEW.q2m OR (:OLD.q2m IS NULL AND :NEW.q2m IS NOT NULL)
    OR (:OLD.q2m IS NOT NULL AND :NEW.q2m IS NULL) OR :OLD.q4m <> :NEW.q4m OR (:OLD.q4m IS NULL AND :NEW.q4m IS NOT NULL)
    OR (:OLD.q4m IS NOT NULL AND :NEW.q4m IS NULL) OR :OLD.status <> :NEW.status OR (:OLD.status IS NULL AND :NEW.status IS NOT NULL)
    OR (:OLD.status IS NOT NULL AND :NEW.status IS NULL) OR :OLD.nsource <> :NEW.nsource OR (:OLD.nsource IS NULL AND :NEW.nsource IS NOT NULL)
    OR (:OLD.nsource IS NOT NULL AND :NEW.nsource IS NULL) OR :OLD.nswitch <> :NEW.nswitch OR (:OLD.nswitch IS NULL AND :NEW.nswitch IS NOT NULL)
    OR (:OLD.nswitch IS NOT NULL AND :NEW.nswitch IS NULL) OR :OLD.nexceptcalc <> :NEW.nexceptcalc OR (:OLD.nexceptcalc IS NULL AND :NEW.nexceptcalc IS NOT NULL)
    OR (:OLD.nexceptcalc IS NOT NULL AND :NEW.nexceptcalc IS NULL) OR :OLD.dclosed <> :NEW.dclosed OR (:OLD.dclosed IS NULL AND :NEW.dclosed IS NOT NULL)
    OR (:OLD.dclosed IS NOT NULL AND :NEW.dclosed IS NULL) OR :OLD.nkc <> :NEW.nkc OR (:OLD.nkc IS NULL AND :NEW.nkc IS NOT NULL)
    OR (:OLD.nkc IS NOT NULL AND :NEW.nkc IS NULL) OR :OLD.er_mtrsn <> :NEW.er_mtrsn OR (:OLD.er_mtrsn IS NULL AND :NEW.er_mtrsn IS NOT NULL)
    OR (:OLD.er_mtrsn IS NOT NULL AND :NEW.er_mtrsn IS NULL) OR :OLD.denter <> :NEW.denter OR (:OLD.denter IS NULL AND :NEW.denter IS NOT NULL)
    OR (:OLD.denter IS NOT NULL AND :NEW.denter IS NULL) OR :OLD.vqm <> :NEW.vqm OR (:OLD.vqm IS NULL AND :NEW.vqm IS NOT NULL)
    OR (:OLD.vqm IS NOT NULL AND :NEW.vqm IS NULL) OR :OLD.nmetertype <> :NEW.nmetertype OR (:OLD.nmetertype IS NULL AND :NEW.nmetertype IS NOT NULL)
    OR (:OLD.nmetertype IS NOT NULL AND :NEW.nmetertype IS NULL) THEN
  INSERT INTO halfhourarch
              (nid, did, mid, date_time, nsource, er, q1, ed, q3, q2, q4, erm, q1m,
               edm, q3m, q2m, q4m, status, nswitch, nexceptcalc, dclosed, nkc, er_mtrsn, denter, vqm,
               nmetertype
              )
       VALUES (halfhourarch_seq.NEXTVAL, SYSDATE, :OLD.mid, :OLD.date_time, :OLD.nsource, :OLD.er, :OLD.q1, :OLD.ed, :OLD.q3, :OLD.q2, :OLD.q4, :OLD.erm, :OLD.q1m,
               :OLD.edm, :OLD.q3m, :OLD.q2m, :OLD.q4m, :OLD.status, :OLD.nswitch, :OLD.nexceptcalc, :OLD.dclosed, :OLD.nkc, :OLD.er_mtrsn, :OLD.denter, :OLD.vqm,
               :OLD.nmetertype
              );
 END IF;
END;
/
-- End of DDL Script for Trigger RYDA.HALFHOUROLD_UPD
*/

---------02/03/2010
/*==============================================================*/
/* Table: MONTHSORGARCH                                         */
/*==============================================================*/
create table MONTHSORGARCH  (
   NID                  NUMBER(10)                      not null,
   DID                  DATE                           default sysdate not null,
   MID                  NUMBER                          not null,
   DATE_TIME            DATE                            not null,
   NSOURCE              NUMBER(10)                      not null,
   VALID                VARCHAR2(1),
   SOURCE               VARCHAR2(50),
   REMARK               VARCHAR2(200),
   ER_MTRSN             VARCHAR2(20),
   ER_KC                NUMBER,
   ERM                  NUMBER,
   ER                   NUMBER,
   AERM                 NUMBER,
   AER                  NUMBER,
   BERM                 NUMBER,
   BER                  NUMBER,
   CERM                 NUMBER,
   CER                  NUMBER,
   DERM                 NUMBER,
   DER                  NUMBER,
   Q1_MTRSN             VARCHAR2(20),
   Q1_KC                NUMBER,
   Q1M                  NUMBER,
   Q1                   NUMBER,
   AQ1M                 NUMBER,
   AQ1                  NUMBER,
   BQ1M                 NUMBER,
   BQ1                  NUMBER,
   CQ1M                 NUMBER,
   CQ1                  NUMBER,
   DQ1M                 NUMBER,
   DQ1                  NUMBER,
   ED_MTRSN             VARCHAR2(20),
   ED_KC                NUMBER,
   EDM                  NUMBER,
   ED                   NUMBER,
   AEDM                 NUMBER,
   AED                  NUMBER,
   BEDM                 NUMBER,
   BED                  NUMBER,
   CEDM                 NUMBER,
   CED                  NUMBER,
   DEDM                 NUMBER,
   DED                  NUMBER,
   Q3_MTRSN             VARCHAR2(20),
   Q3_KC                NUMBER,
   Q3M                  NUMBER,
   Q3                   NUMBER,
   AQ3M                 NUMBER,
   AQ3                  NUMBER,
   BQ3M                 NUMBER,
   BQ3                  NUMBER,
   CQ3M                 NUMBER,
   CQ3                  NUMBER,
   DQ3M                 NUMBER,
   DQ3                  NUMBER,
   Q2_MTRSN             VARCHAR2(20),
   Q2_KC                NUMBER,
   Q2M                  NUMBER,
   Q2                   NUMBER,
   AQ2M                 NUMBER,
   AQ2                  NUMBER,
   BQ2M                 NUMBER,
   BQ2                  NUMBER,
   CQ2M                 NUMBER,
   CQ2                  NUMBER,
   DQ2M                 NUMBER,
   DQ2                  NUMBER,
   Q4_MTRSN             VARCHAR2(20),
   Q4_KC                NUMBER,
   Q4M                  NUMBER,
   Q4                   NUMBER,
   AQ4M                 NUMBER,
   AQ4                  NUMBER,
   BQ4M                 NUMBER,
   BQ4                  NUMBER,
   CQ4M                 NUMBER,
   CQ4                  NUMBER,
   DQ4M                 NUMBER,
   DQ4                  NUMBER,
   NWASTEABS            NUMBER(1),
   DENTER               DATE,
   constraint PK_MONTHSORGARCH primary key (NID)
);

comment on table MONTHSORGARCH is
'Месячные архив';

comment on column MONTHSORGARCH.NID is
'Ид записи';

comment on column MONTHSORGARCH.DID is
'Дата фиксации';

comment on column MONTHSORGARCH.MID is
'Ид точки';

comment on column MONTHSORGARCH.DATE_TIME is
'Дата';

comment on column MONTHSORGARCH.NSOURCE is
'Код источника';

comment on column MONTHSORGARCH.VALID is
'Приз качества';

comment on column MONTHSORGARCH.SOURCE is
'Источник ввода';

comment on column MONTHSORGARCH.REMARK is
'Примечание';

comment on column MONTHSORGARCH.ER_MTRSN is
'Номер сч Ап';

comment on column MONTHSORGARCH.ER_KC is
'Коэф Ап';

comment on column MONTHSORGARCH.ERM is
'Пок Ап';

comment on column MONTHSORGARCH.ER is
'Рас Ап';

comment on column MONTHSORGARCH.AERM is
'Пок Ап A';

comment on column MONTHSORGARCH.AER is
'Рас Ап A';

comment on column MONTHSORGARCH.BERM is
'Пок Ап B';

comment on column MONTHSORGARCH.BER is
'Рас Ап B';

comment on column MONTHSORGARCH.CERM is
'Пок Ап C';

comment on column MONTHSORGARCH.CER is
'Рас Ап C';

comment on column MONTHSORGARCH.DERM is
'Пок Ап D';

comment on column MONTHSORGARCH.DER is
'Рас Ап D';

comment on column MONTHSORGARCH.Q1_MTRSN is
'Номер сч Рп';

comment on column MONTHSORGARCH.Q1_KC is
'Коэф Рп';

comment on column MONTHSORGARCH.Q1M is
'Пок Рп';

comment on column MONTHSORGARCH.Q1 is
'Рас Рп';

comment on column MONTHSORGARCH.AQ1M is
'Пок Рп A';

comment on column MONTHSORGARCH.AQ1 is
'Рас Рп A';

comment on column MONTHSORGARCH.BQ1M is
'Пок Рп B';

comment on column MONTHSORGARCH.BQ1 is
'Рас Рп B';

comment on column MONTHSORGARCH.CQ1M is
'Пок Рп C';

comment on column MONTHSORGARCH.CQ1 is
'Рас Рп C';

comment on column MONTHSORGARCH.DQ1M is
'Пок Рп D';

comment on column MONTHSORGARCH.DQ1 is
'Рас Рп D';

comment on column MONTHSORGARCH.ED_MTRSN is
'Номер сч А отд';

comment on column MONTHSORGARCH.ED_KC is
'Коэф Аотд';

comment on column MONTHSORGARCH.EDM is
'Пок Аотд';

comment on column MONTHSORGARCH.ED is
'Рас Аотд';

comment on column MONTHSORGARCH.AEDM is
'Пок Аотд А';

comment on column MONTHSORGARCH.AED is
'Рас Аотд А';

comment on column MONTHSORGARCH.BEDM is
'Пок Аотд В';

comment on column MONTHSORGARCH.BED is
'Рас Аотд В';

comment on column MONTHSORGARCH.CEDM is
'Пок Аотд С';

comment on column MONTHSORGARCH.CED is
'Рас Аотд С';

comment on column MONTHSORGARCH.DEDM is
'Пок Аотд D';

comment on column MONTHSORGARCH.DED is
'Рас Аотд D';

comment on column MONTHSORGARCH.Q3_MTRSN is
'Номер сч Q1';

comment on column MONTHSORGARCH.Q3_KC is
'Коэф Q1';

comment on column MONTHSORGARCH.Q3M is
'Пок Q1';

comment on column MONTHSORGARCH.Q3 is
'Рас Q1';

comment on column MONTHSORGARCH.AQ3M is
'Пок Q1 A';

comment on column MONTHSORGARCH.AQ3 is
'Рас Q1 A';

comment on column MONTHSORGARCH.BQ3M is
'Пок Q1 B';

comment on column MONTHSORGARCH.BQ3 is
'Рас Q1 B';

comment on column MONTHSORGARCH.CQ3M is
'Пок Q1 C';

comment on column MONTHSORGARCH.CQ3 is
'Рас Q1 C';

comment on column MONTHSORGARCH.DQ3M is
'Пок Q1 D';

comment on column MONTHSORGARCH.DQ3 is
'Рас Q1 D';

comment on column MONTHSORGARCH.Q2_MTRSN is
'Номер сч Q2';

comment on column MONTHSORGARCH.Q2_KC is
'Коэф Q2';

comment on column MONTHSORGARCH.Q2M is
'Пок Q2';

comment on column MONTHSORGARCH.Q2 is
'Рас Q2';

comment on column MONTHSORGARCH.AQ2M is
'Пок Q2 A';

comment on column MONTHSORGARCH.AQ2 is
'Рас Q2 A';

comment on column MONTHSORGARCH.BQ2M is
'Пок Q2 B';

comment on column MONTHSORGARCH.BQ2 is
'Рас Q2 B';

comment on column MONTHSORGARCH.CQ2M is
'Пок Q2 C';

comment on column MONTHSORGARCH.CQ2 is
'Рас Q2 C';

comment on column MONTHSORGARCH.DQ2M is
'Пок Q2 D';

comment on column MONTHSORGARCH.DQ2 is
'Рас Q2 D';

comment on column MONTHSORGARCH.Q4_MTRSN is
'Номер сч Q4';

comment on column MONTHSORGARCH.Q4_KC is
'Коэф Q4';

comment on column MONTHSORGARCH.Q4M is
'Пок Q4';

comment on column MONTHSORGARCH.Q4 is
'Рас Q4';

comment on column MONTHSORGARCH.AQ4M is
'Пок Q4 A';

comment on column MONTHSORGARCH.AQ4 is
'Рас Q4 A';

comment on column MONTHSORGARCH.BQ4M is
'Пок Q4 B';

comment on column MONTHSORGARCH.BQ4 is
'Рас Q4 B';

comment on column MONTHSORGARCH.CQ4M is
'Пок Q4 C';

comment on column MONTHSORGARCH.CQ4 is
'Рас Q4 C';

comment on column MONTHSORGARCH.DQ4M is
'Пок Q4 D';

comment on column MONTHSORGARCH.DQ4 is
'Рас Q4 D';

comment on column MONTHSORGARCH.NWASTEABS is
'Служебный1';

comment on column MONTHSORGARCH.DENTER is
'Дата попадания';

/*==============================================================*/
/* Index: MONTHSORGARCH_IDX1                                    */
/*==============================================================*/
create index MONTHSORGARCH_IDX1 on MONTHSORGARCH (
   MID ASC,
   DATE_TIME ASC
);

/*==============================================================*/
/* Table: BILLORGARCH                                           */
/*==============================================================*/
create table BILLORGARCH  (
   NID                  NUMBER(10)                      not null,
   DID                  DATE                           default sysdate not null,
   MID                  NUMBER                          not null,
   DATE_TIME            DATE                            not null,
   NSOURCE              NUMBER(10)                      not null,
   VALID                VARCHAR2(1),
   SOURCE               VARCHAR2(50),
   REMARK               VARCHAR2(200),
   ER_MTRSN             VARCHAR2(20),
   ER_KC                NUMBER,
   ERM                  NUMBER,
   ER                   NUMBER,
   AERM                 NUMBER,
   AER                  NUMBER,
   BERM                 NUMBER,
   BER                  NUMBER,
   CERM                 NUMBER,
   CER                  NUMBER,
   DERM                 NUMBER,
   DER                  NUMBER,
   Q1_MTRSN             VARCHAR2(20),
   Q1_KC                NUMBER,
   Q1M                  NUMBER,
   Q1                   NUMBER,
   AQ1M                 NUMBER,
   AQ1                  NUMBER,
   BQ1M                 NUMBER,
   BQ1                  NUMBER,
   CQ1M                 NUMBER,
   CQ1                  NUMBER,
   DQ1M                 NUMBER,
   DQ1                  NUMBER,
   ED_MTRSN             VARCHAR2(20),
   ED_KC                NUMBER,
   EDM                  NUMBER,
   ED                   NUMBER,
   AEDM                 NUMBER,
   AED                  NUMBER,
   BEDM                 NUMBER,
   BED                  NUMBER,
   CEDM                 NUMBER,
   CED                  NUMBER,
   DEDM                 NUMBER,
   DED                  NUMBER,
   Q3_MTRSN             VARCHAR2(20),
   Q3_KC                NUMBER,
   Q3M                  NUMBER,
   Q3                   NUMBER,
   AQ3M                 NUMBER,
   AQ3                  NUMBER,
   BQ3M                 NUMBER,
   BQ3                  NUMBER,
   CQ3M                 NUMBER,
   CQ3                  NUMBER,
   DQ3M                 NUMBER,
   DQ3                  NUMBER,
   Q2_MTRSN             VARCHAR2(20),
   Q2_KC                NUMBER,
   Q2M                  NUMBER,
   Q2                   NUMBER,
   AQ2M                 NUMBER,
   AQ2                  NUMBER,
   BQ2M                 NUMBER,
   BQ2                  NUMBER,
   CQ2M                 NUMBER,
   CQ2                  NUMBER,
   DQ2M                 NUMBER,
   DQ2                  NUMBER,
   Q4_MTRSN             VARCHAR2(20),
   Q4_KC                NUMBER,
   Q4M                  NUMBER,
   Q4                   NUMBER,
   AQ4M                 NUMBER,
   AQ4                  NUMBER,
   BQ4M                 NUMBER,
   BQ4                  NUMBER,
   CQ4M                 NUMBER,
   CQ4                  NUMBER,
   DQ4M                 NUMBER,
   DQ4                  NUMBER,
   NWASTEABS            NUMBER(1),
   DENTER               DATE,
   constraint PK_BILLORGARCH primary key (NID)
);

comment on table BILLORGARCH is
'Суточные первичка архив';

comment on column BILLORGARCH.NID is
'Ид записи';

comment on column BILLORGARCH.DID is
'Дата фиксации';

comment on column BILLORGARCH.MID is
'Ид точки';

comment on column BILLORGARCH.DATE_TIME is
'Метка времени';

comment on column BILLORGARCH.NSOURCE is
'Код источника';

comment on column BILLORGARCH.VALID is
'VALID';

comment on column BILLORGARCH.SOURCE is
'SOURCE';

comment on column BILLORGARCH.REMARK is
'REMARK';

comment on column BILLORGARCH.ER_MTRSN is
'ER_MTRSN';

comment on column BILLORGARCH.ER_KC is
'ER_KC';

comment on column BILLORGARCH.ERM is
'ERM';

comment on column BILLORGARCH.ER is
'ER';

comment on column BILLORGARCH.AERM is
'AERM';

comment on column BILLORGARCH.AER is
'AER';

comment on column BILLORGARCH.BERM is
'BERM';

comment on column BILLORGARCH.BER is
'BER';

comment on column BILLORGARCH.CERM is
'CERM';

comment on column BILLORGARCH.CER is
'CER';

comment on column BILLORGARCH.DERM is
'DERM';

comment on column BILLORGARCH.DER is
'DER';

comment on column BILLORGARCH.Q1_MTRSN is
'Q1_MTRSN';

comment on column BILLORGARCH.Q1_KC is
'Q1_KC';

comment on column BILLORGARCH.Q1M is
'Q1M';

comment on column BILLORGARCH.Q1 is
'Q1';

comment on column BILLORGARCH.AQ1M is
'AQ1M';

comment on column BILLORGARCH.AQ1 is
'AQ1';

comment on column BILLORGARCH.BQ1M is
'BQ1M';

comment on column BILLORGARCH.BQ1 is
'BQ1';

comment on column BILLORGARCH.CQ1M is
'CQ1M';

comment on column BILLORGARCH.CQ1 is
'CQ1';

comment on column BILLORGARCH.DQ1M is
'DQ1M';

comment on column BILLORGARCH.DQ1 is
'DQ1';

comment on column BILLORGARCH.ED_MTRSN is
'ED_MTRSN';

comment on column BILLORGARCH.ED_KC is
'ED_KC';

comment on column BILLORGARCH.EDM is
'EDM';

comment on column BILLORGARCH.ED is
'ED';

comment on column BILLORGARCH.AEDM is
'AEDM';

comment on column BILLORGARCH.AED is
'AED';

comment on column BILLORGARCH.BEDM is
'BEDM';

comment on column BILLORGARCH.BED is
'BED';

comment on column BILLORGARCH.CEDM is
'CEDM';

comment on column BILLORGARCH.CED is
'CED';

comment on column BILLORGARCH.DEDM is
'DEDM';

comment on column BILLORGARCH.DED is
'DED';

comment on column BILLORGARCH.Q3_MTRSN is
'Q3_MTRSN';

comment on column BILLORGARCH.Q3_KC is
'Q3_KC';

comment on column BILLORGARCH.Q3M is
'Q3M';

comment on column BILLORGARCH.Q3 is
'Q3';

comment on column BILLORGARCH.AQ3M is
'AQ3M';

comment on column BILLORGARCH.AQ3 is
'AQ3';

comment on column BILLORGARCH.BQ3M is
'BQ3M';

comment on column BILLORGARCH.BQ3 is
'BQ3';

comment on column BILLORGARCH.CQ3M is
'CQ3M';

comment on column BILLORGARCH.CQ3 is
'CQ3';

comment on column BILLORGARCH.DQ3M is
'DQ3M';

comment on column BILLORGARCH.DQ3 is
'DQ3';

comment on column BILLORGARCH.Q2_MTRSN is
'Q2_MTRSN';

comment on column BILLORGARCH.Q2_KC is
'Q2_KC';

comment on column BILLORGARCH.Q2M is
'Q2M';

comment on column BILLORGARCH.Q2 is
'Q2';

comment on column BILLORGARCH.AQ2M is
'AQ2M';

comment on column BILLORGARCH.AQ2 is
'AQ2';

comment on column BILLORGARCH.BQ2M is
'BQ2M';

comment on column BILLORGARCH.BQ2 is
'BQ2';

comment on column BILLORGARCH.CQ2M is
'CQ2M';

comment on column BILLORGARCH.CQ2 is
'CQ2';

comment on column BILLORGARCH.DQ2M is
'DQ2M';

comment on column BILLORGARCH.DQ2 is
'DQ2';

comment on column BILLORGARCH.Q4_MTRSN is
'Q4_MTRSN';

comment on column BILLORGARCH.Q4_KC is
'Q4_KC';

comment on column BILLORGARCH.Q4M is
'Q4M';

comment on column BILLORGARCH.Q4 is
'Q4';

comment on column BILLORGARCH.AQ4M is
'AQ4M';

comment on column BILLORGARCH.AQ4 is
'AQ4';

comment on column BILLORGARCH.BQ4M is
'BQ4M';

comment on column BILLORGARCH.BQ4 is
'BQ4';

comment on column BILLORGARCH.CQ4M is
'CQ4M';

comment on column BILLORGARCH.CQ4 is
'CQ4';

comment on column BILLORGARCH.DQ4M is
'DQ4M';

comment on column BILLORGARCH.DQ4 is
'DQ4';

comment on column BILLORGARCH.NWASTEABS is
'Служебный1';

comment on column BILLORGARCH.DENTER is
'Дата попадания';

/*==============================================================*/
/* Index: BILLORGARCH_IDX1                                      */
/*==============================================================*/
create index BILLORGARCH_IDX1 on BILLORGARCH (
   MID ASC,
   DATE_TIME ASC
);

alter table BILLORGARCH
   add constraint BILLORGARCH_F1 foreign key (MID)
      references POINTS (MID)
      on delete cascade;

alter table MONTHSORGARCH
   add constraint MONTHSORGARCH_F1 foreign key (MID)
      references POINTS (MID)
      on delete cascade;



-----------03/03/2010
alter table SOURCETYPES  add(
   NVALIDITY            NUMBER(1)                      
      constraint CKC_NVALIDITY_SOURCETY check (NVALIDITY is null or (NVALIDITY in (0,1,2,3))),
   NSOURCE              NUMBER(1)                      
      constraint CKC_NSOURCE_SOURCETY check (NSOURCE is null or (NSOURCE in (0,1,2,3,4,5,6,7,8)))
);

comment on column SOURCETYPES.NVALIDITY is
'Достоверность МК';

comment on column SOURCETYPES.NSOURCE is
'Источник МК';


begin
INSERT INTO tasks
(TASK_ID,PARENT,TASK_COD,NAME,REMARK,NSHOW)
VALUES
(106,80,662,'9.06 Сохранение файлов параметризации счетчиков','9.06 Сохранение файлов параметризации счетчиков',0);

commit;
exception
 when others then null;
end;
/

/*
Только для ХОЭ

CREATE OR REPLACE TRIGGER billorg_upd
 AFTER
  DELETE OR UPDATE
 ON billorg
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
declare
ln_ind NUMBER;
BEGIN
 select nvl(max(ind),0) into ln_ind from points where mid=:NEW.mid;
 if ln_ind<>3 then
 return;
 end if;
 IF :OLD.mid <> :NEW.mid OR (:OLD.mid IS NULL AND :NEW.mid IS NOT NULL) OR (:OLD.mid IS NOT NULL AND :NEW.mid IS NULL) 
    OR :OLD.DATE_TIME <> :NEW.DATE_TIME OR (:OLD.DATE_TIME IS NULL AND :NEW.DATE_TIME IS NOT NULL) OR (:OLD.DATE_TIME IS NOT NULL AND :NEW.DATE_TIME IS NULL)
    OR :OLD.VALID <> :NEW.VALID OR (:OLD.VALID IS NULL AND :NEW.VALID IS NOT NULL) OR (:OLD.VALID IS NOT NULL AND :NEW.VALID IS NULL) 
    OR :OLD.SOURCE <> :NEW.SOURCE OR (:OLD.SOURCE IS NULL AND :NEW.SOURCE IS NOT NULL) OR (:OLD.SOURCE IS NOT NULL AND :NEW.SOURCE IS NULL)
    OR :OLD.REMARK <> :NEW.REMARK OR (:OLD.REMARK IS NULL AND :NEW.REMARK IS NOT NULL) OR (:OLD.REMARK IS NOT NULL AND :NEW.REMARK IS NULL)
    OR :OLD.ER_MTRSN <> :NEW.ER_MTRSN OR (:OLD.ER_MTRSN IS NULL AND :NEW.ER_MTRSN IS NOT NULL) OR (:OLD.ER_MTRSN IS NOT NULL AND :NEW.ER_MTRSN IS NULL)
    OR :OLD.ER_KC <> :NEW.ER_KC OR (:OLD.ER_KC IS NULL AND :NEW.ER_KC IS NOT NULL) OR (:OLD.ER_KC IS NOT NULL AND :NEW.ER_KC IS NULL)
    OR :OLD.ERM <> :NEW.ERM OR (:OLD.ERM IS NULL AND :NEW.ERM IS NOT NULL) OR (:OLD.ERM IS NOT NULL AND :NEW.ERM IS NULL)
    OR :OLD.ER <> :NEW.ER OR (:OLD.ER IS NULL AND :NEW.ER IS NOT NULL) OR (:OLD.ER IS NOT NULL AND :NEW.ER IS NULL)
    OR :OLD.AERM <> :NEW.AERM OR (:OLD.AERM IS NULL AND :NEW.AERM IS NOT NULL) OR (:OLD.AERM IS NOT NULL AND :NEW.AERM IS NULL)
    OR :OLD.AER <> :NEW.AER OR (:OLD.AER IS NULL AND :NEW.AER IS NOT NULL) OR (:OLD.AER IS NOT NULL AND :NEW.AER IS NULL)
    OR :OLD.BERM <> :NEW.BERM OR (:OLD.BERM IS NULL AND :NEW.BERM IS NOT NULL) OR (:OLD.BERM IS NOT NULL AND :NEW.BERM IS NULL)
    OR :OLD.BER <> :NEW.BER OR (:OLD.BER IS NULL AND :NEW.BER IS NOT NULL) OR (:OLD.BER IS NOT NULL AND :NEW.BER IS NULL)
    OR :OLD.CERM <> :NEW.CERM OR (:OLD.CERM IS NULL AND :NEW.CERM IS NOT NULL) OR (:OLD.CERM IS NOT NULL AND :NEW.CERM IS NULL)
    OR :OLD.CER <> :NEW.CER OR (:OLD.CER IS NULL AND :NEW.CER IS NOT NULL) OR (:OLD.CER IS NOT NULL AND :NEW.CER IS NULL)
    OR :OLD.DERM <> :NEW.DERM OR (:OLD.DERM IS NULL AND :NEW.DERM IS NOT NULL) OR (:OLD.DERM IS NOT NULL AND :NEW.DERM IS NULL)
    OR :OLD.DER <> :NEW.DER OR (:OLD.DER IS NULL AND :NEW.DER IS NOT NULL) OR (:OLD.DER IS NOT NULL AND :NEW.DER IS NULL)
    OR :OLD.Q1_MTRSN <> :NEW.Q1_MTRSN OR (:OLD.Q1_MTRSN IS NULL AND :NEW.Q1_MTRSN IS NOT NULL) OR (:OLD.Q1_MTRSN IS NOT NULL AND :NEW.Q1_MTRSN IS NULL)
    OR :OLD.Q1_KC <> :NEW.Q1_KC OR (:OLD.Q1_KC IS NULL AND :NEW.Q1_KC IS NOT NULL) OR (:OLD.Q1_KC IS NOT NULL AND :NEW.Q1_KC IS NULL)
    OR :OLD.Q1M <> :NEW.Q1M OR (:OLD.Q1M IS NULL AND :NEW.Q1M IS NOT NULL) OR (:OLD.Q1M IS NOT NULL AND :NEW.Q1M IS NULL)
    OR :OLD.Q1 <> :NEW.Q1 OR (:OLD.Q1 IS NULL AND :NEW.Q1 IS NOT NULL) OR (:OLD.Q1 IS NOT NULL AND :NEW.Q1 IS NULL)
    OR :OLD.AQ1M <> :NEW.AQ1M OR (:OLD.AQ1M IS NULL AND :NEW.AQ1M IS NOT NULL) OR (:OLD.AQ1M IS NOT NULL AND :NEW.AQ1M IS NULL)
    OR :OLD.AQ1 <> :NEW.AQ1 OR (:OLD.AQ1 IS NULL AND :NEW.AQ1 IS NOT NULL) OR (:OLD.AQ1 IS NOT NULL AND :NEW.AQ1 IS NULL)
    OR :OLD.BQ1M <> :NEW.BQ1M OR (:OLD.BQ1M IS NULL AND :NEW.BQ1M IS NOT NULL) OR (:OLD.BQ1M IS NOT NULL AND :NEW.BQ1M IS NULL)
    OR :OLD.Bq1 <> :NEW.Bq1 OR (:OLD.Bq1 IS NULL AND :NEW.Bq1 IS NOT NULL) OR (:OLD.Bq1 IS NOT NULL AND :NEW.Bq1 IS NULL)
    OR :OLD.CQ1M <> :NEW.CQ1M OR (:OLD.CQ1M IS NULL AND :NEW.CQ1M IS NOT NULL) OR (:OLD.CQ1M IS NOT NULL AND :NEW.CQ1M IS NULL)
    OR :OLD.CQ1 <> :NEW.CQ1 OR (:OLD.CQ1 IS NULL AND :NEW.CQ1 IS NOT NULL) OR (:OLD.CQ1 IS NOT NULL AND :NEW.CQ1 IS NULL)
    OR :OLD.DQ1M <> :NEW.DQ1M OR (:OLD.DQ1M IS NULL AND :NEW.DQ1M IS NOT NULL) OR (:OLD.DQ1M IS NOT NULL AND :NEW.DQ1M IS NULL)
    OR :OLD.DQ1 <> :NEW.DQ1 OR (:OLD.DQ1 IS NULL AND :NEW.DQ1 IS NOT NULL) OR (:OLD.DQ1 IS NOT NULL AND :NEW.DQ1 IS NULL)
    OR :OLD.ED_MTRSN <> :NEW.ED_MTRSN OR (:OLD.ED_MTRSN IS NULL AND :NEW.ED_MTRSN IS NOT NULL) OR (:OLD.ED_MTRSN IS NOT NULL AND :NEW.ED_MTRSN IS NULL)
    OR :OLD.ED_KC <> :NEW.ED_KC OR (:OLD.ED_KC IS NULL AND :NEW.ED_KC IS NOT NULL) OR (:OLD.ED_KC IS NOT NULL AND :NEW.ED_KC IS NULL)
    OR :OLD.EDM <> :NEW.EDM OR (:OLD.EDM IS NULL AND :NEW.EDM IS NOT NULL) OR (:OLD.EDM IS NOT NULL AND :NEW.EDM IS NULL)
    OR :OLD.ED <> :NEW.ED OR (:OLD.ED IS NULL AND :NEW.ED IS NOT NULL) OR (:OLD.ED IS NOT NULL AND :NEW.ED IS NULL)
    OR :OLD.AEDM <> :NEW.AEDM OR (:OLD.AEDM IS NULL AND :NEW.AEDM IS NOT NULL) OR (:OLD.AEDM IS NOT NULL AND :NEW.AEDM IS NULL)
    OR :OLD.AED <> :NEW.AED OR (:OLD.AED IS NULL AND :NEW.AED IS NOT NULL) OR (:OLD.AED IS NOT NULL AND :NEW.AED IS NULL)
    OR :OLD.BEDM <> :NEW.BEDM OR (:OLD.BEDM IS NULL AND :NEW.BEDM IS NOT NULL) OR (:OLD.BEDM IS NOT NULL AND :NEW.BEDM IS NULL)
    OR :OLD.BED <> :NEW.BED OR (:OLD.BED IS NULL AND :NEW.BED IS NOT NULL) OR (:OLD.BED IS NOT NULL AND :NEW.BED IS NULL)
    OR :OLD.CEDM <> :NEW.CEDM OR (:OLD.CEDM IS NULL AND :NEW.CEDM IS NOT NULL) OR (:OLD.CEDM IS NOT NULL AND :NEW.CEDM IS NULL)
    OR :OLD.CED <> :NEW.CED OR (:OLD.CED IS NULL AND :NEW.CED IS NOT NULL) OR (:OLD.CED IS NOT NULL AND :NEW.CED IS NULL)
    OR :OLD.DEDM <> :NEW.DEDM OR (:OLD.DEDM IS NULL AND :NEW.DEDM IS NOT NULL) OR (:OLD.DEDM IS NOT NULL AND :NEW.DEDM IS NULL)
    OR :OLD.DED <> :NEW.DED OR (:OLD.DED IS NULL AND :NEW.DED IS NOT NULL) OR (:OLD.DED IS NOT NULL AND :NEW.DED IS NULL)
    OR :OLD.Q3_MTRSN <> :NEW.Q3_MTRSN OR (:OLD.Q3_MTRSN IS NULL AND :NEW.Q3_MTRSN IS NOT NULL) OR (:OLD.Q3_MTRSN IS NOT NULL AND :NEW.Q3_MTRSN IS NULL)
    OR :OLD.Q3_KC <> :NEW.Q3_KC OR (:OLD.Q3_KC IS NULL AND :NEW.Q3_KC IS NOT NULL) OR (:OLD.Q3_KC IS NOT NULL AND :NEW.Q3_KC IS NULL)
    OR :OLD.Q3M <> :NEW.Q3M OR (:OLD.Q3M IS NULL AND :NEW.Q3M IS NOT NULL) OR (:OLD.Q3M IS NOT NULL AND :NEW.Q3M IS NULL)
    OR :OLD.Q3 <> :NEW.Q3 OR (:OLD.Q3 IS NULL AND :NEW.Q3 IS NOT NULL) OR (:OLD.Q3 IS NOT NULL AND :NEW.Q3 IS NULL)
    OR :OLD.AQ3M <> :NEW.AQ3M OR (:OLD.AQ3M IS NULL AND :NEW.AQ3M IS NOT NULL) OR (:OLD.AQ3M IS NOT NULL AND :NEW.AQ3M IS NULL)
    OR :OLD.AQ3 <> :NEW.AQ3 OR (:OLD.AQ3 IS NULL AND :NEW.AQ3 IS NOT NULL) OR (:OLD.AQ3 IS NOT NULL AND :NEW.AQ3 IS NULL)
    OR :OLD.BQ3M <> :NEW.BQ3M OR (:OLD.BQ3M IS NULL AND :NEW.BQ3M IS NOT NULL) OR (:OLD.BQ3M IS NOT NULL AND :NEW.BQ3M IS NULL)
    OR :OLD.BQ3 <> :NEW.BQ3 OR (:OLD.BQ3 IS NULL AND :NEW.BQ3 IS NOT NULL) OR (:OLD.BQ3 IS NOT NULL AND :NEW.BQ3 IS NULL)
    OR :OLD.CQ3M <> :NEW.CQ3M OR (:OLD.CQ3M IS NULL AND :NEW.CQ3M IS NOT NULL) OR (:OLD.CQ3M IS NOT NULL AND :NEW.CQ3M IS NULL)
    OR :OLD.CQ3 <> :NEW.CQ3 OR (:OLD.CQ3 IS NULL AND :NEW.CQ3 IS NOT NULL) OR (:OLD.CQ3 IS NOT NULL AND :NEW.CQ3 IS NULL)
    OR :OLD.DQ3M <> :NEW.DQ3M OR (:OLD.DQ3M IS NULL AND :NEW.DQ3M IS NOT NULL) OR (:OLD.DQ3M IS NOT NULL AND :NEW.DQ3M IS NULL)
    OR :OLD.DQ3 <> :NEW.DQ3 OR (:OLD.DQ3 IS NULL AND :NEW.DQ3 IS NOT NULL) OR (:OLD.DQ3 IS NOT NULL AND :NEW.DQ3 IS NULL)
    OR :OLD.Q2_MTRSN <> :NEW.Q2_MTRSN OR (:OLD.Q2_MTRSN IS NULL AND :NEW.Q2_MTRSN IS NOT NULL) OR (:OLD.Q2_MTRSN IS NOT NULL AND :NEW.Q2_MTRSN IS NULL)
    OR :OLD.Q2_KC <> :NEW.Q2_KC OR (:OLD.Q2_KC IS NULL AND :NEW.Q2_KC IS NOT NULL) OR (:OLD.Q2_KC IS NOT NULL AND :NEW.Q2_KC IS NULL)
    OR :OLD.Q2M <> :NEW.Q2M OR (:OLD.Q2M IS NULL AND :NEW.Q2M IS NOT NULL) OR (:OLD.Q2M IS NOT NULL AND :NEW.Q2M IS NULL)
    OR :OLD.Q2 <> :NEW.Q2 OR (:OLD.Q2 IS NULL AND :NEW.Q2 IS NOT NULL) OR (:OLD.Q2 IS NOT NULL AND :NEW.Q2 IS NULL)
    OR :OLD.AQ2M <> :NEW.AQ2M OR (:OLD.AQ2M IS NULL AND :NEW.AQ2M IS NOT NULL) OR (:OLD.AQ2M IS NOT NULL AND :NEW.AQ2M IS NULL)
    OR :OLD.AQ2 <> :NEW.AQ2 OR (:OLD.AQ2 IS NULL AND :NEW.AQ2 IS NOT NULL) OR (:OLD.AQ2 IS NOT NULL AND :NEW.AQ2 IS NULL)
    OR :OLD.BQ2M <> :NEW.BQ2M OR (:OLD.BQ2M IS NULL AND :NEW.BQ2M IS NOT NULL) OR (:OLD.BQ2M IS NOT NULL AND :NEW.BQ2M IS NULL)
    OR :OLD.BQ2 <> :NEW.BQ2 OR (:OLD.BQ2 IS NULL AND :NEW.BQ2 IS NOT NULL) OR (:OLD.BQ2 IS NOT NULL AND :NEW.BQ2 IS NULL)
    OR :OLD.CQ2M <> :NEW.CQ2M OR (:OLD.CQ2M IS NULL AND :NEW.CQ2M IS NOT NULL) OR (:OLD.CQ2M IS NOT NULL AND :NEW.CQ2M IS NULL)
    OR :OLD.CQ2 <> :NEW.CQ2 OR (:OLD.CQ2 IS NULL AND :NEW.CQ2 IS NOT NULL) OR (:OLD.CQ2 IS NOT NULL AND :NEW.CQ2 IS NULL)
    OR :OLD.DQ2M <> :NEW.DQ2M OR (:OLD.DQ2M IS NULL AND :NEW.DQ2M IS NOT NULL) OR (:OLD.DQ2M IS NOT NULL AND :NEW.DQ2M IS NULL)
    OR :OLD.DQ2 <> :NEW.DQ2 OR (:OLD.DQ2 IS NULL AND :NEW.DQ2 IS NOT NULL) OR (:OLD.DQ2 IS NOT NULL AND :NEW.DQ2 IS NULL)
    OR :OLD.Q4_MTRSN <> :NEW.Q4_MTRSN OR (:OLD.Q4_MTRSN IS NULL AND :NEW.Q4_MTRSN IS NOT NULL) OR (:OLD.Q4_MTRSN IS NOT NULL AND :NEW.Q4_MTRSN IS NULL)
    OR :OLD.Q4_KC <> :NEW.Q4_KC OR (:OLD.Q4_KC IS NULL AND :NEW.Q4_KC IS NOT NULL) OR (:OLD.Q4_KC IS NOT NULL AND :NEW.Q4_KC IS NULL)
    OR :OLD.Q4M <> :NEW.Q4M OR (:OLD.Q4M IS NULL AND :NEW.Q4M IS NOT NULL) OR (:OLD.Q4M IS NOT NULL AND :NEW.Q4M IS NULL)
    OR :OLD.Q4 <> :NEW.Q4 OR (:OLD.Q4 IS NULL AND :NEW.Q4 IS NOT NULL) OR (:OLD.Q4 IS NOT NULL AND :NEW.Q4 IS NULL)
    OR :OLD.AQ4M <> :NEW.AQ4M OR (:OLD.AQ4M IS NULL AND :NEW.AQ4M IS NOT NULL) OR (:OLD.AQ4M IS NOT NULL AND :NEW.AQ4M IS NULL)
    OR :OLD.AQ4 <> :NEW.AQ4 OR (:OLD.AQ4 IS NULL AND :NEW.AQ4 IS NOT NULL) OR (:OLD.AQ4 IS NOT NULL AND :NEW.AQ4 IS NULL)
    OR :OLD.BQ4M <> :NEW.BQ4M OR (:OLD.BQ4M IS NULL AND :NEW.BQ4M IS NOT NULL) OR (:OLD.BQ4M IS NOT NULL AND :NEW.BQ4M IS NULL)
    OR :OLD.BQ4 <> :NEW.BQ4 OR (:OLD.BQ4 IS NULL AND :NEW.BQ4 IS NOT NULL) OR (:OLD.BQ4 IS NOT NULL AND :NEW.BQ4 IS NULL)
    OR :OLD.CQ4M <> :NEW.CQ4M OR (:OLD.CQ4M IS NULL AND :NEW.CQ4M IS NOT NULL) OR (:OLD.CQ4M IS NOT NULL AND :NEW.CQ4M IS NULL)
    OR :OLD.CQ4 <> :NEW.CQ4 OR (:OLD.CQ4 IS NULL AND :NEW.CQ4 IS NOT NULL) OR (:OLD.CQ4 IS NOT NULL AND :NEW.CQ4 IS NULL)
    OR :OLD.DQ4M <> :NEW.DQ4M OR (:OLD.DQ4M IS NULL AND :NEW.DQ4M IS NOT NULL) OR (:OLD.DQ4M IS NOT NULL AND :NEW.DQ4M IS NULL)
    OR :OLD.DQ4 <> :NEW.DQ4 OR (:OLD.DQ4 IS NULL AND :NEW.DQ4 IS NOT NULL) OR (:OLD.DQ4 IS NOT NULL AND :NEW.DQ4 IS NULL)
    OR :OLD.NWASTEABS <> :NEW.NWASTEABS OR (:OLD.NWASTEABS IS NULL AND :NEW.NWASTEABS IS NOT NULL) OR (:OLD.NWASTEABS IS NOT NULL AND :NEW.NWASTEABS IS NULL)
    OR :OLD.NSOURCE <> :NEW.NSOURCE OR (:OLD.NSOURCE IS NULL AND :NEW.NSOURCE IS NOT NULL) OR (:OLD.NSOURCE IS NOT NULL AND :NEW.NSOURCE IS NULL)
    OR :OLD.DENTER <> :NEW.DENTER OR (:OLD.DENTER IS NULL AND :NEW.DENTER IS NOT NULL) OR (:OLD.DENTER IS NOT NULL AND :NEW.DENTER IS NULL)
     
 
  THEN
  INSERT INTO BILLORGARCH
              (nid, did, MID, DATE_TIME, VALID, SOURCE, REMARK, ER_MTRSN, ER_KC, ERM, ER, 
               AERM, AER, BERM, BER, CERM, CER, DERM, DER, Q1_MTRSN, Q1_KC, Q1M, 
               Q1, AQ1M, AQ1, BQ1M, BQ1, CQ1M, CQ1, DQ1M, DQ1, ED_MTRSN, ED_KC, EDM, ED,
               AEDM, AED, BEDM, BED, CEDM, CED, DEDM, DED, Q3_MTRSN, Q3_KC, Q3M, Q3, 
               AQ3M, AQ3, BQ3M, BQ3, CQ3M, CQ3, DQ3M, DQ3, Q2_MTRSN, Q2_KC, Q2M, Q2, 
               AQ2M, AQ2, BQ2M, BQ2, CQ2M, CQ2, DQ2M, DQ2, Q4_MTRSN, Q4_KC, Q4M, Q4, 
               AQ4M, AQ4, BQ4M, BQ4, CQ4M, CQ4, DQ4M, DQ4, NWASTEABS, NSOURCE, DENTER
              )
       VALUES (halfhourarch_seq.NEXTVAL, SYSDATE,:OLD.MID,:OLD.DATE_TIME, :OLD.VALID, :OLD.SOURCE, :OLD.REMARK, 
               :OLD.ER_MTRSN, :OLD.ER_KC, :OLD.ERM, :OLD.ER, :OLD.AERM, :OLD.AER, :OLD.BERM, :OLD.BER,
               :OLD.CERM, :OLD.CER, :OLD.DERM, :OLD.DER, :OLD.Q1_MTRSN, :OLD.Q1_KC, :OLD.Q1M, :OLD.Q1, 
               :OLD.AQ1M, :OLD.AQ1, :OLD.BQ1M, :OLD.BQ1, :OLD.CQ1M, :OLD.CQ1, :OLD.DQ1M, :OLD.DQ1, 
               :OLD.ED_MTRSN, :OLD.ED_KC, :OLD.EDM, :OLD.ED, :OLD.AEDM, :OLD.AED, :OLD.BEDM,:OLD.BED,
               :OLD.CEDM, :OLD.CED, :OLD.DEDM, :OLD.DED, :OLD.Q3_MTRSN, :OLD.Q3_KC, :OLD.Q3M, :OLD.Q3, 
               :OLD.AQ3M, :OLD.AQ3, :OLD.BQ3M, :OLD.BQ3, :OLD.CQ3M, :OLD.CQ3, :OLD.DQ3M, :OLD.DQ3, 
               
               :OLD.Q2_MTRSN, :OLD.Q2_KC, :OLD.Q2M, :OLD.Q2, 
               :OLD.AQ2M, :OLD.AQ2, :OLD.BQ2M, :OLD.BQ2, :OLD.CQ2M, :OLD.CQ2, :OLD.DQ2M, :OLD.DQ2,
               
               :OLD.Q4_MTRSN, :OLD.Q4_KC, :OLD.Q4M, :OLD.Q4, 
               :OLD.AQ4M, :OLD.AQ4, :OLD.BQ4M, :OLD.BQ4, :OLD.CQ4M, :OLD.CQ4, :OLD.DQ4M, :OLD.DQ4,
               :OLD.NWASTEABS, :OLD.NSOURCE, :OLD.DENTER  
              );
 END IF;
END;
/


CREATE OR REPLACE TRIGGER monthorg_upd
 AFTER
  DELETE OR UPDATE
 ON monthsorg
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
declare
ln_ind NUMBER;
BEGIN
 select nvl(max(ind),0) into ln_ind from points where mid=:NEW.mid;
 if ln_ind<>3 then
 return;
 end if;
 IF :OLD.mid <> :NEW.mid OR (:OLD.mid IS NULL AND :NEW.mid IS NOT NULL) OR (:OLD.mid IS NOT NULL AND :NEW.mid IS NULL) 
    OR :OLD.DATE_TIME <> :NEW.DATE_TIME OR (:OLD.DATE_TIME IS NULL AND :NEW.DATE_TIME IS NOT NULL) OR (:OLD.DATE_TIME IS NOT NULL AND :NEW.DATE_TIME IS NULL)
    OR :OLD.VALID <> :NEW.VALID OR (:OLD.VALID IS NULL AND :NEW.VALID IS NOT NULL) OR (:OLD.VALID IS NOT NULL AND :NEW.VALID IS NULL) 
    OR :OLD.SOURCE <> :NEW.SOURCE OR (:OLD.SOURCE IS NULL AND :NEW.SOURCE IS NOT NULL) OR (:OLD.SOURCE IS NOT NULL AND :NEW.SOURCE IS NULL)
    OR :OLD.REMARK <> :NEW.REMARK OR (:OLD.REMARK IS NULL AND :NEW.REMARK IS NOT NULL) OR (:OLD.REMARK IS NOT NULL AND :NEW.REMARK IS NULL)
    OR :OLD.ER_MTRSN <> :NEW.ER_MTRSN OR (:OLD.ER_MTRSN IS NULL AND :NEW.ER_MTRSN IS NOT NULL) OR (:OLD.ER_MTRSN IS NOT NULL AND :NEW.ER_MTRSN IS NULL)
    OR :OLD.ER_KC <> :NEW.ER_KC OR (:OLD.ER_KC IS NULL AND :NEW.ER_KC IS NOT NULL) OR (:OLD.ER_KC IS NOT NULL AND :NEW.ER_KC IS NULL)
    OR :OLD.ERM <> :NEW.ERM OR (:OLD.ERM IS NULL AND :NEW.ERM IS NOT NULL) OR (:OLD.ERM IS NOT NULL AND :NEW.ERM IS NULL)
    OR :OLD.ER <> :NEW.ER OR (:OLD.ER IS NULL AND :NEW.ER IS NOT NULL) OR (:OLD.ER IS NOT NULL AND :NEW.ER IS NULL)
    OR :OLD.AERM <> :NEW.AERM OR (:OLD.AERM IS NULL AND :NEW.AERM IS NOT NULL) OR (:OLD.AERM IS NOT NULL AND :NEW.AERM IS NULL)
    OR :OLD.AER <> :NEW.AER OR (:OLD.AER IS NULL AND :NEW.AER IS NOT NULL) OR (:OLD.AER IS NOT NULL AND :NEW.AER IS NULL)
    OR :OLD.BERM <> :NEW.BERM OR (:OLD.BERM IS NULL AND :NEW.BERM IS NOT NULL) OR (:OLD.BERM IS NOT NULL AND :NEW.BERM IS NULL)
    OR :OLD.BER <> :NEW.BER OR (:OLD.BER IS NULL AND :NEW.BER IS NOT NULL) OR (:OLD.BER IS NOT NULL AND :NEW.BER IS NULL)
    OR :OLD.CERM <> :NEW.CERM OR (:OLD.CERM IS NULL AND :NEW.CERM IS NOT NULL) OR (:OLD.CERM IS NOT NULL AND :NEW.CERM IS NULL)
    OR :OLD.CER <> :NEW.CER OR (:OLD.CER IS NULL AND :NEW.CER IS NOT NULL) OR (:OLD.CER IS NOT NULL AND :NEW.CER IS NULL)
    OR :OLD.DERM <> :NEW.DERM OR (:OLD.DERM IS NULL AND :NEW.DERM IS NOT NULL) OR (:OLD.DERM IS NOT NULL AND :NEW.DERM IS NULL)
    OR :OLD.DER <> :NEW.DER OR (:OLD.DER IS NULL AND :NEW.DER IS NOT NULL) OR (:OLD.DER IS NOT NULL AND :NEW.DER IS NULL)
    OR :OLD.Q1_MTRSN <> :NEW.Q1_MTRSN OR (:OLD.Q1_MTRSN IS NULL AND :NEW.Q1_MTRSN IS NOT NULL) OR (:OLD.Q1_MTRSN IS NOT NULL AND :NEW.Q1_MTRSN IS NULL)
    OR :OLD.Q1_KC <> :NEW.Q1_KC OR (:OLD.Q1_KC IS NULL AND :NEW.Q1_KC IS NOT NULL) OR (:OLD.Q1_KC IS NOT NULL AND :NEW.Q1_KC IS NULL)
    OR :OLD.Q1M <> :NEW.Q1M OR (:OLD.Q1M IS NULL AND :NEW.Q1M IS NOT NULL) OR (:OLD.Q1M IS NOT NULL AND :NEW.Q1M IS NULL)
    OR :OLD.Q1 <> :NEW.Q1 OR (:OLD.Q1 IS NULL AND :NEW.Q1 IS NOT NULL) OR (:OLD.Q1 IS NOT NULL AND :NEW.Q1 IS NULL)
    OR :OLD.AQ1M <> :NEW.AQ1M OR (:OLD.AQ1M IS NULL AND :NEW.AQ1M IS NOT NULL) OR (:OLD.AQ1M IS NOT NULL AND :NEW.AQ1M IS NULL)
    OR :OLD.AQ1 <> :NEW.AQ1 OR (:OLD.AQ1 IS NULL AND :NEW.AQ1 IS NOT NULL) OR (:OLD.AQ1 IS NOT NULL AND :NEW.AQ1 IS NULL)
    OR :OLD.BQ1M <> :NEW.BQ1M OR (:OLD.BQ1M IS NULL AND :NEW.BQ1M IS NOT NULL) OR (:OLD.BQ1M IS NOT NULL AND :NEW.BQ1M IS NULL)
    OR :OLD.Bq1 <> :NEW.Bq1 OR (:OLD.Bq1 IS NULL AND :NEW.Bq1 IS NOT NULL) OR (:OLD.Bq1 IS NOT NULL AND :NEW.Bq1 IS NULL)
    OR :OLD.CQ1M <> :NEW.CQ1M OR (:OLD.CQ1M IS NULL AND :NEW.CQ1M IS NOT NULL) OR (:OLD.CQ1M IS NOT NULL AND :NEW.CQ1M IS NULL)
    OR :OLD.CQ1 <> :NEW.CQ1 OR (:OLD.CQ1 IS NULL AND :NEW.CQ1 IS NOT NULL) OR (:OLD.CQ1 IS NOT NULL AND :NEW.CQ1 IS NULL)
    OR :OLD.DQ1M <> :NEW.DQ1M OR (:OLD.DQ1M IS NULL AND :NEW.DQ1M IS NOT NULL) OR (:OLD.DQ1M IS NOT NULL AND :NEW.DQ1M IS NULL)
    OR :OLD.DQ1 <> :NEW.DQ1 OR (:OLD.DQ1 IS NULL AND :NEW.DQ1 IS NOT NULL) OR (:OLD.DQ1 IS NOT NULL AND :NEW.DQ1 IS NULL)
    OR :OLD.ED_MTRSN <> :NEW.ED_MTRSN OR (:OLD.ED_MTRSN IS NULL AND :NEW.ED_MTRSN IS NOT NULL) OR (:OLD.ED_MTRSN IS NOT NULL AND :NEW.ED_MTRSN IS NULL)
    OR :OLD.ED_KC <> :NEW.ED_KC OR (:OLD.ED_KC IS NULL AND :NEW.ED_KC IS NOT NULL) OR (:OLD.ED_KC IS NOT NULL AND :NEW.ED_KC IS NULL)
    OR :OLD.EDM <> :NEW.EDM OR (:OLD.EDM IS NULL AND :NEW.EDM IS NOT NULL) OR (:OLD.EDM IS NOT NULL AND :NEW.EDM IS NULL)
    OR :OLD.ED <> :NEW.ED OR (:OLD.ED IS NULL AND :NEW.ED IS NOT NULL) OR (:OLD.ED IS NOT NULL AND :NEW.ED IS NULL)
    OR :OLD.AEDM <> :NEW.AEDM OR (:OLD.AEDM IS NULL AND :NEW.AEDM IS NOT NULL) OR (:OLD.AEDM IS NOT NULL AND :NEW.AEDM IS NULL)
    OR :OLD.AED <> :NEW.AED OR (:OLD.AED IS NULL AND :NEW.AED IS NOT NULL) OR (:OLD.AED IS NOT NULL AND :NEW.AED IS NULL)
    OR :OLD.BEDM <> :NEW.BEDM OR (:OLD.BEDM IS NULL AND :NEW.BEDM IS NOT NULL) OR (:OLD.BEDM IS NOT NULL AND :NEW.BEDM IS NULL)
    OR :OLD.BED <> :NEW.BED OR (:OLD.BED IS NULL AND :NEW.BED IS NOT NULL) OR (:OLD.BED IS NOT NULL AND :NEW.BED IS NULL)
    OR :OLD.CEDM <> :NEW.CEDM OR (:OLD.CEDM IS NULL AND :NEW.CEDM IS NOT NULL) OR (:OLD.CEDM IS NOT NULL AND :NEW.CEDM IS NULL)
    OR :OLD.CED <> :NEW.CED OR (:OLD.CED IS NULL AND :NEW.CED IS NOT NULL) OR (:OLD.CED IS NOT NULL AND :NEW.CED IS NULL)
    OR :OLD.DEDM <> :NEW.DEDM OR (:OLD.DEDM IS NULL AND :NEW.DEDM IS NOT NULL) OR (:OLD.DEDM IS NOT NULL AND :NEW.DEDM IS NULL)
    OR :OLD.DED <> :NEW.DED OR (:OLD.DED IS NULL AND :NEW.DED IS NOT NULL) OR (:OLD.DED IS NOT NULL AND :NEW.DED IS NULL)
    OR :OLD.Q3_MTRSN <> :NEW.Q3_MTRSN OR (:OLD.Q3_MTRSN IS NULL AND :NEW.Q3_MTRSN IS NOT NULL) OR (:OLD.Q3_MTRSN IS NOT NULL AND :NEW.Q3_MTRSN IS NULL)
    OR :OLD.Q3_KC <> :NEW.Q3_KC OR (:OLD.Q3_KC IS NULL AND :NEW.Q3_KC IS NOT NULL) OR (:OLD.Q3_KC IS NOT NULL AND :NEW.Q3_KC IS NULL)
    OR :OLD.Q3M <> :NEW.Q3M OR (:OLD.Q3M IS NULL AND :NEW.Q3M IS NOT NULL) OR (:OLD.Q3M IS NOT NULL AND :NEW.Q3M IS NULL)
    OR :OLD.Q3 <> :NEW.Q3 OR (:OLD.Q3 IS NULL AND :NEW.Q3 IS NOT NULL) OR (:OLD.Q3 IS NOT NULL AND :NEW.Q3 IS NULL)
    OR :OLD.AQ3M <> :NEW.AQ3M OR (:OLD.AQ3M IS NULL AND :NEW.AQ3M IS NOT NULL) OR (:OLD.AQ3M IS NOT NULL AND :NEW.AQ3M IS NULL)
    OR :OLD.AQ3 <> :NEW.AQ3 OR (:OLD.AQ3 IS NULL AND :NEW.AQ3 IS NOT NULL) OR (:OLD.AQ3 IS NOT NULL AND :NEW.AQ3 IS NULL)
    OR :OLD.BQ3M <> :NEW.BQ3M OR (:OLD.BQ3M IS NULL AND :NEW.BQ3M IS NOT NULL) OR (:OLD.BQ3M IS NOT NULL AND :NEW.BQ3M IS NULL)
    OR :OLD.BQ3 <> :NEW.BQ3 OR (:OLD.BQ3 IS NULL AND :NEW.BQ3 IS NOT NULL) OR (:OLD.BQ3 IS NOT NULL AND :NEW.BQ3 IS NULL)
    OR :OLD.CQ3M <> :NEW.CQ3M OR (:OLD.CQ3M IS NULL AND :NEW.CQ3M IS NOT NULL) OR (:OLD.CQ3M IS NOT NULL AND :NEW.CQ3M IS NULL)
    OR :OLD.CQ3 <> :NEW.CQ3 OR (:OLD.CQ3 IS NULL AND :NEW.CQ3 IS NOT NULL) OR (:OLD.CQ3 IS NOT NULL AND :NEW.CQ3 IS NULL)
    OR :OLD.DQ3M <> :NEW.DQ3M OR (:OLD.DQ3M IS NULL AND :NEW.DQ3M IS NOT NULL) OR (:OLD.DQ3M IS NOT NULL AND :NEW.DQ3M IS NULL)
    OR :OLD.DQ3 <> :NEW.DQ3 OR (:OLD.DQ3 IS NULL AND :NEW.DQ3 IS NOT NULL) OR (:OLD.DQ3 IS NOT NULL AND :NEW.DQ3 IS NULL)
    OR :OLD.Q2_MTRSN <> :NEW.Q2_MTRSN OR (:OLD.Q2_MTRSN IS NULL AND :NEW.Q2_MTRSN IS NOT NULL) OR (:OLD.Q2_MTRSN IS NOT NULL AND :NEW.Q2_MTRSN IS NULL)
    OR :OLD.Q2_KC <> :NEW.Q2_KC OR (:OLD.Q2_KC IS NULL AND :NEW.Q2_KC IS NOT NULL) OR (:OLD.Q2_KC IS NOT NULL AND :NEW.Q2_KC IS NULL)
    OR :OLD.Q2M <> :NEW.Q2M OR (:OLD.Q2M IS NULL AND :NEW.Q2M IS NOT NULL) OR (:OLD.Q2M IS NOT NULL AND :NEW.Q2M IS NULL)
    OR :OLD.Q2 <> :NEW.Q2 OR (:OLD.Q2 IS NULL AND :NEW.Q2 IS NOT NULL) OR (:OLD.Q2 IS NOT NULL AND :NEW.Q2 IS NULL)
    OR :OLD.AQ2M <> :NEW.AQ2M OR (:OLD.AQ2M IS NULL AND :NEW.AQ2M IS NOT NULL) OR (:OLD.AQ2M IS NOT NULL AND :NEW.AQ2M IS NULL)
    OR :OLD.AQ2 <> :NEW.AQ2 OR (:OLD.AQ2 IS NULL AND :NEW.AQ2 IS NOT NULL) OR (:OLD.AQ2 IS NOT NULL AND :NEW.AQ2 IS NULL)
    OR :OLD.BQ2M <> :NEW.BQ2M OR (:OLD.BQ2M IS NULL AND :NEW.BQ2M IS NOT NULL) OR (:OLD.BQ2M IS NOT NULL AND :NEW.BQ2M IS NULL)
    OR :OLD.BQ2 <> :NEW.BQ2 OR (:OLD.BQ2 IS NULL AND :NEW.BQ2 IS NOT NULL) OR (:OLD.BQ2 IS NOT NULL AND :NEW.BQ2 IS NULL)
    OR :OLD.CQ2M <> :NEW.CQ2M OR (:OLD.CQ2M IS NULL AND :NEW.CQ2M IS NOT NULL) OR (:OLD.CQ2M IS NOT NULL AND :NEW.CQ2M IS NULL)
    OR :OLD.CQ2 <> :NEW.CQ2 OR (:OLD.CQ2 IS NULL AND :NEW.CQ2 IS NOT NULL) OR (:OLD.CQ2 IS NOT NULL AND :NEW.CQ2 IS NULL)
    OR :OLD.DQ2M <> :NEW.DQ2M OR (:OLD.DQ2M IS NULL AND :NEW.DQ2M IS NOT NULL) OR (:OLD.DQ2M IS NOT NULL AND :NEW.DQ2M IS NULL)
    OR :OLD.DQ2 <> :NEW.DQ2 OR (:OLD.DQ2 IS NULL AND :NEW.DQ2 IS NOT NULL) OR (:OLD.DQ2 IS NOT NULL AND :NEW.DQ2 IS NULL)
    OR :OLD.Q4_MTRSN <> :NEW.Q4_MTRSN OR (:OLD.Q4_MTRSN IS NULL AND :NEW.Q4_MTRSN IS NOT NULL) OR (:OLD.Q4_MTRSN IS NOT NULL AND :NEW.Q4_MTRSN IS NULL)
    OR :OLD.Q4_KC <> :NEW.Q4_KC OR (:OLD.Q4_KC IS NULL AND :NEW.Q4_KC IS NOT NULL) OR (:OLD.Q4_KC IS NOT NULL AND :NEW.Q4_KC IS NULL)
    OR :OLD.Q4M <> :NEW.Q4M OR (:OLD.Q4M IS NULL AND :NEW.Q4M IS NOT NULL) OR (:OLD.Q4M IS NOT NULL AND :NEW.Q4M IS NULL)
    OR :OLD.Q4 <> :NEW.Q4 OR (:OLD.Q4 IS NULL AND :NEW.Q4 IS NOT NULL) OR (:OLD.Q4 IS NOT NULL AND :NEW.Q4 IS NULL)
    OR :OLD.AQ4M <> :NEW.AQ4M OR (:OLD.AQ4M IS NULL AND :NEW.AQ4M IS NOT NULL) OR (:OLD.AQ4M IS NOT NULL AND :NEW.AQ4M IS NULL)
    OR :OLD.AQ4 <> :NEW.AQ4 OR (:OLD.AQ4 IS NULL AND :NEW.AQ4 IS NOT NULL) OR (:OLD.AQ4 IS NOT NULL AND :NEW.AQ4 IS NULL)
    OR :OLD.BQ4M <> :NEW.BQ4M OR (:OLD.BQ4M IS NULL AND :NEW.BQ4M IS NOT NULL) OR (:OLD.BQ4M IS NOT NULL AND :NEW.BQ4M IS NULL)
    OR :OLD.BQ4 <> :NEW.BQ4 OR (:OLD.BQ4 IS NULL AND :NEW.BQ4 IS NOT NULL) OR (:OLD.BQ4 IS NOT NULL AND :NEW.BQ4 IS NULL)
    OR :OLD.CQ4M <> :NEW.CQ4M OR (:OLD.CQ4M IS NULL AND :NEW.CQ4M IS NOT NULL) OR (:OLD.CQ4M IS NOT NULL AND :NEW.CQ4M IS NULL)
    OR :OLD.CQ4 <> :NEW.CQ4 OR (:OLD.CQ4 IS NULL AND :NEW.CQ4 IS NOT NULL) OR (:OLD.CQ4 IS NOT NULL AND :NEW.CQ4 IS NULL)
    OR :OLD.DQ4M <> :NEW.DQ4M OR (:OLD.DQ4M IS NULL AND :NEW.DQ4M IS NOT NULL) OR (:OLD.DQ4M IS NOT NULL AND :NEW.DQ4M IS NULL)
    OR :OLD.DQ4 <> :NEW.DQ4 OR (:OLD.DQ4 IS NULL AND :NEW.DQ4 IS NOT NULL) OR (:OLD.DQ4 IS NOT NULL AND :NEW.DQ4 IS NULL)
    OR :OLD.NWASTEABS <> :NEW.NWASTEABS OR (:OLD.NWASTEABS IS NULL AND :NEW.NWASTEABS IS NOT NULL) OR (:OLD.NWASTEABS IS NOT NULL AND :NEW.NWASTEABS IS NULL)
    OR :OLD.NSOURCE <> :NEW.NSOURCE OR (:OLD.NSOURCE IS NULL AND :NEW.NSOURCE IS NOT NULL) OR (:OLD.NSOURCE IS NOT NULL AND :NEW.NSOURCE IS NULL)
    OR :OLD.DENTER <> :NEW.DENTER OR (:OLD.DENTER IS NULL AND :NEW.DENTER IS NOT NULL) OR (:OLD.DENTER IS NOT NULL AND :NEW.DENTER IS NULL)
     
 
  THEN
  INSERT INTO MONTHSORGARCH
              (nid, did, MID, DATE_TIME, VALID, SOURCE, REMARK, ER_MTRSN, ER_KC, ERM, ER, 
               AERM, AER, BERM, BER, CERM, CER, DERM, DER, Q1_MTRSN, Q1_KC, Q1M, 
               Q1, AQ1M, AQ1, BQ1M, BQ1, CQ1M, CQ1, DQ1M, DQ1, ED_MTRSN, ED_KC, EDM, ED,
               AEDM, AED, BEDM, BED, CEDM, CED, DEDM, DED, Q3_MTRSN, Q3_KC, Q3M, Q3, 
               AQ3M, AQ3, BQ3M, BQ3, CQ3M, CQ3, DQ3M, DQ3, Q2_MTRSN, Q2_KC, Q2M, Q2, 
               AQ2M, AQ2, BQ2M, BQ2, CQ2M, CQ2, DQ2M, DQ2, Q4_MTRSN, Q4_KC, Q4M, Q4, 
               AQ4M, AQ4, BQ4M, BQ4, CQ4M, CQ4, DQ4M, DQ4, NWASTEABS, NSOURCE, DENTER
              )
       VALUES (halfhourarch_seq.NEXTVAL, SYSDATE,:OLD.MID,:OLD.DATE_TIME, :OLD.VALID, :OLD.SOURCE, :OLD.REMARK, 
               :OLD.ER_MTRSN, :OLD.ER_KC, :OLD.ERM, :OLD.ER, :OLD.AERM, :OLD.AER, :OLD.BERM, :OLD.BER,
               :OLD.CERM, :OLD.CER, :OLD.DERM, :OLD.DER, :OLD.Q1_MTRSN, :OLD.Q1_KC, :OLD.Q1M, :OLD.Q1, 
               :OLD.AQ1M, :OLD.AQ1, :OLD.BQ1M, :OLD.BQ1, :OLD.CQ1M, :OLD.CQ1, :OLD.DQ1M, :OLD.DQ1, 
               :OLD.ED_MTRSN, :OLD.ED_KC, :OLD.EDM, :OLD.ED, :OLD.AEDM, :OLD.AED, :OLD.BEDM,:OLD.BED,
               :OLD.CEDM, :OLD.CED, :OLD.DEDM, :OLD.DED, :OLD.Q3_MTRSN, :OLD.Q3_KC, :OLD.Q3M, :OLD.Q3, 
               :OLD.AQ3M, :OLD.AQ3, :OLD.BQ3M, :OLD.BQ3, :OLD.CQ3M, :OLD.CQ3, :OLD.DQ3M, :OLD.DQ3, 
               
               :OLD.Q2_MTRSN, :OLD.Q2_KC, :OLD.Q2M, :OLD.Q2, 
               :OLD.AQ2M, :OLD.AQ2, :OLD.BQ2M, :OLD.BQ2, :OLD.CQ2M, :OLD.CQ2, :OLD.DQ2M, :OLD.DQ2,
               
               :OLD.Q4_MTRSN, :OLD.Q4_KC, :OLD.Q4M, :OLD.Q4, 
               :OLD.AQ4M, :OLD.AQ4, :OLD.BQ4M, :OLD.BQ4, :OLD.CQ4M, :OLD.CQ4, :OLD.DQ4M, :OLD.DQ4,
               :OLD.NWASTEABS, :OLD.NSOURCE, :OLD.DENTER  
              );
 END IF;
END;
/
*/


--09/03/2010
/*==============================================================*/
/* Table: ICCPEVENTS                                            */
/*==============================================================*/
create table ICCPEVENTS  (
   NORDER               NUMBER                          not null,
   MID                  NUMBER                          not null,
   DLASTEVENT           DATE                            not null,
   VLASTEVENT           VARCHAR2(2000),
   constraint PK_ICCPEVENTS primary key (NORDER)
);

comment on table ICCPEVENTS is
'События по ICCP';

comment on column ICCPEVENTS.NORDER is
'Ид события';

comment on column ICCPEVENTS.MID is
'Ид ассоциации';

comment on column ICCPEVENTS.DLASTEVENT is
'Дата cобытия';

comment on column ICCPEVENTS.VLASTEVENT is
'Cобытие';

/*==============================================================*/
/* Index: ICCPEVENTS_IDX1                                       */
/*==============================================================*/
create index ICCPEVENTS_IDX1 on ICCPEVENTS (
   MID ASC,
   DLASTEVENT ASC
);

/*==============================================================*/
/* Index: ICCPEVENTS_IDX2                                       */
/*==============================================================*/
create index ICCPEVENTS_IDX2 on ICCPEVENTS (
   DLASTEVENT ASC
);

alter table ICCPEVENTS
   add constraint ICCPEVENTS_F1 foreign key (MID)
      references POINTS (MID)
      on delete cascade;

INSERT INTO db_term
("TABLE_NAME","DATA_NAME","TERM","NARCHIVED","VINDIC_COLUMN","VEXTENTION","INDEX_NAME")
VALUES
('ICCPEVENTS','Протокол работы ICCP',2,0,'dlastevent','icc','')
/

CREATE SEQUENCE iccp_seq MINVALUE 1 MAXVALUE 999999999999999999999999999
  INCREMENT BY 1 START WITH 1000 CACHE 20 NOORDER NOCYCLE
/


--16/03/2010
INSERT INTO protocols("PROTOCOL_ID","NAME","DLL_NAME") VALUES(98,'ACE6000 (dlms)',NULL);
commit;

INSERT INTO PROTOCOLS("PROTOCOL_ID","NAME","DLL_NAME") VALUES(105,'EMS','');
commit;

----------------------------------------------------------------------------------------------
--17.03.2010      VER 2.35.3 (Для обновления версии 2.35.2 до текущей скрипт запускать отсюда)      
----------------------------------------------------------------------------------------------
INSERT INTO RYDA.METERTYPE VALUES(31,'АСКУЭ Хартэп'); 
INSERT INTO METEREVENTSDICT("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")VALUES(521,31,0,1,'Процесс опроса:',0,0);
INSERT INTO METEREVENTSDICT("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")VALUES(522,31,0,2,'Изменение даты параметризации:',0,0);
INSERT INTO METEREVENTSDICT("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")VALUES(523,31,0,3,'Загрузчик файлов:',0,0);
INSERT INTO METEREVENTSDICT("NEVENT","NMETERTYPE","NEVENTCLASS","NEVENTCODE","VEVENTTEXT","NLOCK","NVALIDITY")VALUES(524,31,0,4,'Подсистема верификации:',0,0);
commit;

----22/03/2010
alter table FEEDERS  add(
  NLOCKSWITCH          NUMBER(1)                      default 0 not null
      constraint CKC_NLOCKSWITCH_FEEDERS check (NLOCKSWITCH in (0,1))
);

comment on column FEEDERS.NLOCKSWITCH is
'Блокировка перехода на ОВ';


declare
l NUMBER;
begin
select count(*) into l from parameter where NPID=12 and vvalue='1';
insert into parameter (NPID,VVALUE,VDESCRIPTION) values(48,l,'Расширенная область видимости в задаче выбора ОВ');
commit;
end;
/

--24/03/2010
update db_term set INDEX_NAME='PROFILE_IDX1' where TABLE_NAME='PROFILE';
update db_term set INDEX_NAME='JOURNAL_IDX1' where TABLE_NAME='JOURNAL';
update db_term set INDEX_NAME='COMPORTEVENTS_IDX1' where TABLE_NAME='COMPORTEVENTS';
update db_term set INDEX_NAME='ICCPEVENTS_IDX2' where TABLE_NAME='ICCPEVENTS';
commit;

create global temporary table ARCHSTAT  (
   MID                  NUMBER                          not null,
   CNH                  NUMBER(10)                      not null,
   CNB                  NUMBER(10)                      not null,
   CNM                  NUMBER(10)                      not null,
   constraint PK_ARCHSTAT primary key (MID)
)
 ON COMMIT PRESERVE ROWS
 ORGANIZATION HEAP
 CACHE
;

comment on table ARCHSTAT is
'Статистика архивов';

comment on column ARCHSTAT.MID is
'Ид точки';

comment on column ARCHSTAT.CNH is
'Количество ГН';

comment on column ARCHSTAT.CNB is
'Количество Суточных';

comment on column ARCHSTAT.CNM is
'Количество Месячных';




----------------------------------------------------------------------------------------------
--08.04.2010      VER 2.35.4 (Для обновления версии 2.35.3 до текущей скрипт запускать отсюда)      
----------------------------------------------------------------------------------------------
alter table GROUPS  add (
   NROOT3               NUMBER(10)
);

comment on column GROUPS.NROOT3 is
'Служебная 3';

create index GROUPS_IDX4 on GROUPS (
   NROOT3 ASC
);

begin
update groups set NROOT3=NROOT2,NROOT2=NULL where exists(select * from parameter where npid=47 and trim(vvalue) is not null) and NROOT3 is NULL;
commit;
end;
/

--------09.04.2010
alter table CURR_POWER  add(   NI0                  NUMBER);

comment on column CURR_POWER.NI0 is 'Ток в нуле';

alter table CURR_POWER_ARCH  add(   NI0                  NUMBER);

comment on column CURR_POWER_ARCH.NI0 is 'Ток в нуле';

-- Start of DDL Script for Trigger RYDA.CURR_POWER_ARCH
-- Generated 9.04.2010 15:23:49 from RYDA@OE

CREATE OR REPLACE TRIGGER curr_power_arch
 AFTER
   UPDATE OF ni0
 ON curr_power
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
BEGIN
 admin_pg.curr_power_arch_ins_p(
  :NEW.mid, :NEW.date_time, :NEW.er, :NEW.q1, :NEW.q2, :NEW.ed, :NEW.q3, :NEW.q4, :NEW.erm, :NEW.q1m, :NEW.q2m, :NEW.edm,
  :NEW.q3m, :NEW.q4m, :NEW.freq, :NEW.cosf, :NEW.volt, :NEW.currento, :NEW.volt2, :NEW.volt3, :NEW.curr2, :NEW.curr3,
  :NEW.nfiu1, :NEW.nfiu2, :NEW.nfiu3, :NEW.nfii1, :NEW.nfii2, :NEW.nfii3,:NEW.NI0);
END;
/
-- End of DDL Script for Trigger RYDA.CURR_POWER_ARCH


create index POINTS_IDX4 on POINTS (   PTYPE ASC);

----------------------------------------------------------------------------------------------
--14/04/2010     VER 2.35.6 (Для обновления версии 2.35.3 до текущей скрипт запускать отсюда)      
----------------------------------------------------------------------------------------------

drop index MAKET30817_IDX1;
create index MAKET30817_IDX1 on MAKET30817 (   NGROUP ASC);

alter table GROUPS  add(
   NKC                  NUMBER
);

comment on column GROUPS.NKC is
'Коеф вхождения для ХОЭ';

----15/04/2010
alter table M30817  add(
   VQM                  VARCHAR2(32)
);

comment on column M30817.VQM is
'Метка качества';




----------------------------------------------------------------------------------------------
--19/04/2010     VER 2.36.1 (Для обновления версии 2.35.6 до текущей скрипт запускать отсюда)      
----------------------------------------------------------------------------------------------
INSERT INTO deportprocedures("NPROCEDURE","VNAME","VPROCEDURE","NPERIOD","NTYPE","VMEMO")
VALUES(68,'Макет 30816','reports1_pg.m30816_p',2,0,'Макет 30816 (Текущие значения)');
commit;

----29.04.2010
update deportprocedures set NPERIOD=0 where NPROCEDURE=68;
commit;


----11.05.2010
alter table USERS  add(
   NLOCK                NUMBER(1)                      default 0 not null
      constraint CKC_NLOCK_USERS check (NLOCK in (0,1))
);


comment on column USERS.NLOCK is
'Блокировка';

--13/05/2010  
INSERT INTO deportprocedures("NPROCEDURE","VNAME","VPROCEDURE","NPERIOD","NTYPE","VMEMO")
VALUES(69,'CIM/RDF','reports5_pg.mRDF_p',2,0,'CIM/RDF');
commit;

----17/05/2010
/*==============================================================*/
/* Table: CURR_QUALITY_ARCH                                     */
/*==============================================================*/
create table CURR_QUALITY_ARCH  (
   MID                  NUMBER                          not null,
   DATE_TIME            DATE                            not null,
   NVOLTVAR             NUMBER,
   NVOLTCHANMOD         NUMBER,
   NFLICKERSEV          NUMBER,
   NTHD                 NUMBER,
   NNHARMKOEF           NUMBER,
   NOBRUNBKOEF          NUMBER,
   NZERUNBKOEF          NUMBER,
   NPOWFREQ             NUMBER,
   NVOLTDIPTIME         NUMBER,
   NTEMPVOLTKOEF        NUMBER,
   NQUICKCHAN           NUMBER,
   NUNBALVOLT           NUMBER,
   NVOLTINTERHARM       NUMBER,
   NVOLTDIP             NUMBER,
   NSHORTINTERRUPT      NUMBER,
   NLONGINTERRUPT       NUMBER,
   NTEMPOVERVOLT        NUMBER,
   NTRANSOVERVOLT       NUMBER,
   constraint PK_CURR_QUALITY_ARCH primary key (MID, DATE_TIME)
);

comment on table CURR_QUALITY_ARCH is
'Архив параметров качества';

comment on column CURR_QUALITY_ARCH.MID is
'Ид точки';

comment on column CURR_QUALITY_ARCH.DATE_TIME is
'Дата';

comment on column CURR_QUALITY_ARCH.NVOLTVAR is
'Отклонение напряжения';

comment on column CURR_QUALITY_ARCH.NVOLTCHANMOD is
'Размах изменения напряжения';

comment on column CURR_QUALITY_ARCH.NFLICKERSEV is
'Доза фликера';

comment on column CURR_QUALITY_ARCH.NTHD is
'Коэфф иск синус кривой напр';

comment on column CURR_QUALITY_ARCH.NNHARMKOEF is
'Коэфф Nой гарм сост напр';

comment on column CURR_QUALITY_ARCH.NOBRUNBKOEF is
'Коэфф несимметрии по обр посл';

comment on column CURR_QUALITY_ARCH.NZERUNBKOEF is
'Коэфф несимметрии по нулевой посл';

comment on column CURR_QUALITY_ARCH.NPOWFREQ is
'Отклонение частоты';

comment on column CURR_QUALITY_ARCH.NVOLTDIPTIME is
'Длительность провала напряж';

comment on column CURR_QUALITY_ARCH.NTEMPVOLTKOEF is
'Коэффициент временного напряж';

comment on column CURR_QUALITY_ARCH.NQUICKCHAN is
'Быстрые изменения напр';

comment on column CURR_QUALITY_ARCH.NUNBALVOLT is
'Несимметрия напряжений';

comment on column CURR_QUALITY_ARCH.NVOLTINTERHARM is
'Напряжение интергармоник';

comment on column CURR_QUALITY_ARCH.NVOLTDIP is
'Провалы напряжения';

comment on column CURR_QUALITY_ARCH.NSHORTINTERRUPT is
'Короткие отключения напряжения';

comment on column CURR_QUALITY_ARCH.NLONGINTERRUPT is
'Длинные отключения напряжения';

comment on column CURR_QUALITY_ARCH.NTEMPOVERVOLT is
'Временные напряжения';

comment on column CURR_QUALITY_ARCH.NTRANSOVERVOLT is
'Импульсные напряжения';

/*==============================================================*/
/* Index: CURR_QUALITY_ARCH_IDX1                                */
/*==============================================================*/
create index CURR_QUALITY_ARCH_IDX1 on CURR_QUALITY_ARCH (
   DATE_TIME ASC
);

alter table CURR_QUALITY_ARCH
   add constraint CURR_QUALITY_ARCH_F1 foreign key (MID)
      references POINTS (MID)
      on delete cascade;

/*==============================================================*/
/* Table: CURR_QUALITY                                          */
/*==============================================================*/
create table CURR_QUALITY  (
   MID                  NUMBER                          not null,
   DATE_TIME            DATE,
   NVOLTVAR             NUMBER,
   NVOLTCHANMOD         NUMBER,
   NFLICKERSEV          NUMBER,
   NTHD                 NUMBER,
   NNHARMKOEF           NUMBER,
   NOBRUNBKOEF          NUMBER,
   NZERUNBKOEF          NUMBER,
   NPOWFREQ             NUMBER,
   NVOLTDIPTIME         NUMBER,
   NTEMPVOLTKOEF        NUMBER,
   NQUICKCHAN           NUMBER,
   NUNBALVOLT           NUMBER,
   NVOLTINTERHARM       NUMBER,
   NVOLTDIP             NUMBER,
   NSHORTINTERRUPT      NUMBER,
   NLONGINTERRUPT       NUMBER,
   NTEMPOVERVOLT        NUMBER,
   NTRANSOVERVOLT       NUMBER,
   constraint PK_CURR_QUALITY primary key (MID)
);

comment on table CURR_QUALITY is
'Параметры качества';

comment on column CURR_QUALITY.MID is
'Ид точки';

comment on column CURR_QUALITY.DATE_TIME is
'Дата';

comment on column CURR_QUALITY.NVOLTVAR is
'Отклонение напряжения';

comment on column CURR_QUALITY.NVOLTCHANMOD is
'Размах изменения напряжения';

comment on column CURR_QUALITY.NFLICKERSEV is
'Доза фликера';

comment on column CURR_QUALITY.NTHD is
'Коэфф иск синус кривой напр';

comment on column CURR_QUALITY.NNHARMKOEF is
'Коэфф Nой гарм сост напр';

comment on column CURR_QUALITY.NOBRUNBKOEF is
'Коэфф несимметрии по обр посл';

comment on column CURR_QUALITY.NZERUNBKOEF is
'Коэфф несимметрии по нулевой посл';

comment on column CURR_QUALITY.NPOWFREQ is
'Отклонение частоты';

comment on column CURR_QUALITY.NVOLTDIPTIME is
'Длительность провала напряж';

comment on column CURR_QUALITY.NTEMPVOLTKOEF is
'Коэффициент временного напряж';

comment on column CURR_QUALITY.NQUICKCHAN is
'Быстрые изменения напр';

comment on column CURR_QUALITY.NUNBALVOLT is
'Несимметрия напряжений';

comment on column CURR_QUALITY.NVOLTINTERHARM is
'Напряжение интергармоник';

comment on column CURR_QUALITY.NVOLTDIP is
'Провалы напряжения';

comment on column CURR_QUALITY.NSHORTINTERRUPT is
'Короткие отключения напряжения';

comment on column CURR_QUALITY.NLONGINTERRUPT is
'Длинные отключения напряжения';

comment on column CURR_QUALITY.NTEMPOVERVOLT is
'Временные напряжения';

comment on column CURR_QUALITY.NTRANSOVERVOLT is
'Импульсные напряжения';

alter table CURR_QUALITY
   add constraint CURR_QUALITY_F1 foreign key (MID)
      references POINTS (MID)
      on delete cascade;

-----28/05/2010
insert into parameter (NPID,VVALUE,VDESCRIPTION) values(49,0,'Передача ГН с учетом в ОВ по Хартэп - dbLink');
commit;




---01/06/2010
/*==============================================================*/
/* Table: HALFHOURHOLES                                         */
/*==============================================================*/
create table HALFHOURHOLES  (
   MID                  NUMBER                          not null,
   DATE_TIME            DATE                            not null,
   NSTAT                NUMBER(10)                     default 0 not null,
   constraint PK_HALFHOURHOLES primary key (MID, DATE_TIME)
);

comment on table HALFHOURHOLES is
'Получасовки дырки';

comment on column HALFHOURHOLES.MID is
'Ид точки';

comment on column HALFHOURHOLES.DATE_TIME is
'Дата показаний';

comment on column HALFHOURHOLES.NSTAT is
'Кол попыток перезапроса';

alter table HALFHOURHOLES
   add constraint HALFHOURHOLES_F1 foreign key (MID)
      references POINTS (MID)
      on delete cascade;


alter table LAST_SAVE  add(
   NREPEATICCP          NUMBER(10)                     default 0 not null
);

comment on column LAST_SAVE.NREPEATICCP is
'Номер повтора перезапроса данных';


----------------------------------------------------------------------------------------------
--11/05/2010     VER 2.36.1 (Для обновления версии 2.36.0.1 до текущей скрипт запускать отсюда)      
----------------------------------------------------------------------------------------------

/*==============================================================*/
/* Index: HALFHOURHOLES_IDX1                                    */
/*==============================================================*/
create index HALFHOURHOLES_IDX1 on HALFHOURHOLES ( DATE_TIME ASC);

INSERT INTO db_term("TABLE_NAME","DATA_NAME","TERM","NARCHIVED","VINDIC_COLUMN","VEXTENTION","INDEX_NAME")
VALUES('HALFHOURHOLES','Пропуски в архивах (служебная)',40,0,'DATE_TIME','hhh',NULL);
commit;

declare
l NUMBER;
begin
select nvl(max(decode(vvalue,'0',1,'41',1,'42',1,'43',1,'44',1,'45',1,'46',1,0)),0) into l from parameter where NPID=12;
if l=1 then
INSERT INTO deportprocedures("NPROCEDURE","VNAME","VPROCEDURE","NPERIOD","NTYPE","VMEMO")
VALUES(70,'Поиск пропусков в архивах ГН','TSDA_PG.GET_NOTDATA',2,1,'Поиск пропусков в архивах ГН');
commit;
end if;
end;
/


---16.06.2010
-- Start of DDL Script for Trigger RYDA.CURR_QUALITY_ARCH
-- Generated 16.06.2010 12:08:28 from RYDA@oe

CREATE OR REPLACE TRIGGER curr_quality_arch
 AFTER
  UPDATE
 ON curr_quality
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
BEGIN
 INSERT INTO curr_quality_arch
             (mid, date_time, nvoltvar, nvoltchanmod, nflickersev, nthd, nnharmkoef, nobrunbkoef, nzerunbkoef,
              npowfreq, nvoltdiptime, ntempvoltkoef, nquickchan, nunbalvolt, nvoltinterharm, nvoltdip, nshortinterrupt,
              nlonginterrupt, ntempovervolt, ntransovervolt
             )
      VALUES (:NEW.mid, :NEW.date_time, :NEW.nvoltvar, :NEW.nvoltchanmod, :NEW.nflickersev, :NEW.nthd, :NEW.nnharmkoef, :NEW.nobrunbkoef, :NEW.nzerunbkoef,
              :NEW.npowfreq, :NEW.nvoltdiptime, :NEW.ntempvoltkoef, :NEW.nquickchan, :NEW.nunbalvolt, :NEW.nvoltinterharm, :NEW.nvoltdip, :NEW.nshortinterrupt,
              :NEW.nlonginterrupt, :NEW.ntempovervolt, :NEW.ntransovervolt
             );
EXCEPTION
 WHEN DUP_VAL_ON_INDEX THEN
  UPDATE curr_quality_arch
     SET nvoltvar = :NEW.nvoltvar,
     nvoltchanmod = :NEW.nvoltchanmod,
     nflickersev = :NEW.nflickersev,
     nthd = :NEW.nthd,
     nnharmkoef = :NEW.nnharmkoef,
     nobrunbkoef = :NEW.nobrunbkoef,
     nzerunbkoef = :NEW.nzerunbkoef,
     npowfreq = :NEW.npowfreq,
     nvoltdiptime = :NEW.nvoltdiptime,
     ntempvoltkoef = :NEW.ntempvoltkoef,
     nquickchan = :NEW.nquickchan,
     nunbalvolt = :NEW.nunbalvolt,
     nvoltinterharm = :NEW.nvoltinterharm,
     nvoltdip = :NEW.nvoltdip,
     nshortinterrupt = :NEW.nshortinterrupt,
     nlonginterrupt = :NEW.nlonginterrupt,
     ntempovervolt = :NEW.ntempovervolt,
     ntransovervolt = :NEW.ntransovervolt
   WHERE mid = :NEW.mid AND date_time = :NEW.date_time;
 WHEN OTHERS THEN
  RAISE;
END;
/

----18.06.2010
INSERT INTO RYDA.PROTOCOLS VALUES(107,'Satec - Качество_ЭЭ','');
INSERT INTO RYDA.PROTOCOLS VALUES(108,'УСД LG_ZxB (ИдЭхо)','');
INSERT INTO RYDA.PROTOCOLS VALUES(109,'УСД LG_ZxD (IEC+ИдЭхо)','');
commit;

--22.06.2010
insert into parameter (NPID,VVALUE,VDESCRIPTION) values(51,0,'Выполнять расчет формул при поступлении данных');
commit;

----------------------------------------------------------------------------------------------
-- 2010.07.13     VER 2.36.2 (Для обновления версии 2.36.1.1 до текущей скрипт запускать отсюда)      
----------------------------------------------------------------------------------------------
alter table BILLOLD  add(   NQE                  NUMBER);
alter table PROFILE  add(   NQE                  NUMBER);
alter table HALFHOUROLD  add(   NQE                  NUMBER);



--2010/07/14
-- Start of DDL Script for Type RYDA.TBITOR
-- Generated 14.07.2010 9:18:00 from RYDA@oe

CREATE OR REPLACE 
TYPE tbitor as object
(
  result number, -- highest value seen so far 
  secmax number, -- second highest value seen so far
  static function ODCIAggregateInitialize(sctx IN OUT Tbitor) return number,
  member function ODCIAggregateIterate(self IN OUT Tbitor,value IN number) return number,
  member function ODCIAggregateTerminate(self IN Tbitor,returnValue OUT number, flags IN number) return number,
  member function ODCIAggregateMerge(self IN OUT Tbitor,ctx2 IN Tbitor) return number
);
/


-- End of DDL Script for Type RYDA.TBITOR

-- Start of DDL Script for Type Body RYDA.TBITOR
-- Generated 14.07.2010 9:18:09 from RYDA@oe

CREATE OR REPLACE 
TYPE BODY tbitor is 
static function ODCIAggregateInitialize(sctx IN OUT Tbitor) 
return number is 
begin
  sctx := Tbitor('', 0);
  return ODCIConst.Success;
end;
member function ODCIAggregateIterate(self IN OUT Tbitor, value IN number) return number is
begin
  IF self.result IS NULL THEN  
  self.result := value;
  ELSE
  self.result :=util_pg.bitor(self.result,value);
  END IF;
  return ODCIConst.Success;
end;

member function ODCIAggregateTerminate(self IN Tbitor,returnValue OUT number, flags IN number) return number is
begin
  returnValue := self.result ;
  return ODCIConst.Success;
end;

member function ODCIAggregateMerge(self IN OUT Tbitor, ctx2 IN Tbitor) return number is
begin
  IF self.result IS NULL THEN  
  self.result := ctx2.result;
  ELSE
  self.result :=util_pg.bitor(self.result,ctx2.result);
  END IF;
  return ODCIConst.Success;
end;
end;
/

-- End of DDL Script for Type Body RYDA.TBITOR

CREATE OR REPLACE 
FUNCTION bitor(input number) RETURN number PARALLEL_ENABLE AGGREGATE USING Tbitor;
/


----------14/07/2010
drop table MAKDEPORT;
drop table RMAKETS;


begin execute immediate 'alter table DEPORTATION drop column VERROR'; exception when others then null; end;
/
begin execute immediate 'alter table DEPORTATION drop column VFILENAME'; exception when others then null; end;
/
begin execute immediate 'alter table DEPORTATION drop column VMAILSUBJECT'; exception when others then null; end;
/
begin execute immediate 'alter table DEPORTATION drop column VMAILTEXT'; exception when others then null; end;
/
begin execute immediate 'alter table DEPORTATION drop column NATTACH'; exception when others then null; end;
/
begin execute immediate 'alter table DEPORTATION drop column NDELETE'; exception when others then null; end;
/
begin execute immediate 'alter table DEPORTATION drop column NUNIQNAME'; exception when others then null; end;
/
begin execute immediate 'alter table DEPORTATION drop column NINDEPORT'; exception when others then null; end;
/
begin execute immediate 'drop package DEPORTATION_NEW_PG'; exception when others then null; end;
/


/*==============================================================*/
/* Table: RMAKETS                                               */
/*==============================================================*/
create table RMAKETS  (
   NOPERATION           NUMBER(10)                      not null,
   CID                  NUMBER(10)                      not null,
   DCREATE              DATE                            not null,
   VFILENAME            VARCHAR2(128)                   not null,
   DFILE                DATE                            not null,
   NSTATE               NUMBER(1)                      default 0 not null
      constraint CKC_NSTATE_RMAKETS check (NSTATE in (0,1,2,3,4,5,6,7)),
   VERROR               VARCHAR2(2000),
   VMAKET               CLOB,
   DDATE                DATE,
   NTYPE                NUMBER,
   DLOAD                DATE,
   USER_ID              NUMBER,
   constraint PK_RMAKETS primary key (NOPERATION)
);

comment on table RMAKETS is
'Принятые макеты';

comment on column RMAKETS.NOPERATION is
'Ид операции';

comment on column RMAKETS.CID is
'Ид канала';

comment on column RMAKETS.DCREATE is
'Дата приема';

comment on column RMAKETS.VFILENAME is
'Название файла';

comment on column RMAKETS.DFILE is
'Дата файла';

comment on column RMAKETS.NSTATE is
'Состояние';

comment on column RMAKETS.VERROR is
'Ошибка';

comment on column RMAKETS.VMAKET is
'Текст макета';

comment on column RMAKETS.DDATE is
'Дата информации';

comment on column RMAKETS.NTYPE is
'Тип макета';

comment on column RMAKETS.DLOAD is
'Дата загрузки';

comment on column RMAKETS.USER_ID is
'идентификатор';

/*==============================================================*/
/* Index: RMAKETS_IDX1                                          */
/*==============================================================*/
create index RMAKETS_IDX1 on RMAKETS (
   DCREATE ASC
);

/*==============================================================*/
/* Index: RMAKETS_IDX2                                          */
/*==============================================================*/
create index RMAKETS_IDX2 on RMAKETS (
   CID ASC,
   VFILENAME ASC
);

/*==============================================================*/
/* Index: RMAKETS_IDX3                                          */
/*==============================================================*/
create index RMAKETS_IDX3 on RMAKETS (
   DDATE ASC
);

/*==============================================================*/
/* Index: RMAKETS_IDX4                                          */
/*==============================================================*/
create index RMAKETS_IDX4 on RMAKETS (
   USER_ID ASC
);

alter table RMAKETS
   add constraint RMAKETS_F1 foreign key (CID)
      references CHANNELS (CID)
      on delete cascade;

alter table RMAKETS
   add constraint RMAKETS_F2 foreign key (USER_ID)
      references USERS (USER_ID);

grant update on rmakets to askue_work;  

------------15/07/2010
CREATE OR REPLACE VIEW bill (
   mid,   date_time,   valid,   source,   remark,   er_mtrsn,   er_kc,   erm,   er,   aerm,   aer,   berm,   ber,   cerm,   cer,
   derm,   der,   q1_mtrsn,   q1_kc,   q1m,   q1,   aq1m,   aq1,   bq1m,   bq1,   cq1m,   cq1,   dq1m,   dq1,   ed_mtrsn,   ed_kc,
   edm,   ed,   aedm,   aed,   bedm,   bed,   cedm,   ced,   dedm,   ded,   q3_mtrsn,   q3_kc,   q3m,   q3,   aq3m,   aq3,   bq3m,
   bq3,   cq3m,   cq3,   dq3m,   dq3,   q2_mtrsn,   q2_kc,   q2m,   q2,   aq2m,   aq2,   bq2m,   bq2,   cq2m,   cq2,   dq2m,   dq2,
   q4_mtrsn,   q4_kc,   q4m,   q4,   aq4m,   aq4,   bq4m,   bq4,   cq4m,   cq4,   dq4m,   dq4,   nwasteabs,   nsource,   vqm,   nqe )
AS
SELECT MID, DATE_TIME, VALID, SOURCE, REMARK, ER_MTRSN, ER_KC, ERM, ER, AERM, AER, BERM, BER, CERM, CER, DERM, DER, Q1_MTRSN, Q1_KC, Q1M, Q1, AQ1M, AQ1, BQ1M, BQ1, CQ1M,
 CQ1, DQ1M, DQ1, ED_MTRSN, ED_KC, EDM, ED, AEDM, AED, BEDM, BED, CEDM, CED, DEDM, DED, Q3_MTRSN, Q3_KC, Q3M, Q3, AQ3M, AQ3, BQ3M, BQ3, CQ3M, CQ3, DQ3M, DQ3, Q2_MTRSN, Q2_KC,
 Q2M, Q2, AQ2M, AQ2, BQ2M, BQ2, CQ2M, CQ2, DQ2M, DQ2, Q4_MTRSN, Q4_KC, Q4M, Q4, AQ4M, AQ4, BQ4M, BQ4, CQ4M, CQ4, DQ4M, DQ4, NWASTEABS, NSOURCE, VQM,NQE
 FROM BILLOLD
/


CREATE OR REPLACE VIEW halfhour (
   mid,   date_time,   er,   q1,   ed,   q3,   q2,   q4,   erm,   q1m,   edm,   q3m,   q2m,   q4m,   status,   nkc,   nsource,   er_mtrsn,
   nswitch,   denter,   vqm,   nmetertype,   nqe )
AS
SELECT MID,DATE_TIME,ER,Q1,ED,Q3,Q2,Q4,ERM,Q1M,EDM,Q3M,Q2M,Q4M,STATUS,NKC,NSOURCE,ER_MTRSN,NSWITCH,DENTER,VQM, nmetertype ,NQE FROM HALFHOUROLD WHERE NEXCEPTCALC IS NULL
/

drop table CURR_QUALITY;
drop table CURR_QUALITY_ARCH;


/*==============================================================*/
/* Table: PQLOG                                                 */
/*==============================================================*/
create table PQLOG  (
   MID                  NUMBER                          not null,
   DSTART               DATE                            not null,
   NSEQUENCE            NUMBER(10)                      not null,
   VPHASE               VARCHAR2(32)                    not null,
   NBEVENTTYPE          NUMBER(10)                      not null,
   NMCSTIMESTART        NUMBER(10)                      not null,
   DEND                 DATE                            not null,
   NMCSTIMEEND          NUMBER(10)                      not null,
   NREFERENCE           NUMBER                          not null,
   NBEVENTSEQ           NUMBER(10)                      not null,
   NMAGNITUDE           NUMBER                          not null,
   VPU                  NUMBER,
   VDURATION            VARCHAR2(32),
   VEVENT               VARCHAR2(32),
   VCATEGORY            VARCHAR2(64),
   constraint PK_PQLOG primary key (MID, DSTART, NSEQUENCE, VPHASE)
);

comment on table PQLOG is
'Журнал качества энергии';

comment on column PQLOG.MID is
'Ид точки';

comment on column PQLOG.DSTART is
'Дата начала события';

comment on column PQLOG.NSEQUENCE is
'Номер записи';

comment on column PQLOG.VPHASE is
'Фаза';

comment on column PQLOG.NBEVENTTYPE is
'Тип события';

comment on column PQLOG.NMCSTIMESTART is
'Микросекунды начала события';

comment on column PQLOG.DEND is
'Дата окончания события';

comment on column PQLOG.NMCSTIMEEND is
'Микросекунды окончания события';

comment on column PQLOG.NREFERENCE is
'Номинальное значение';

comment on column PQLOG.NBEVENTSEQ is
'Номер события';

comment on column PQLOG.NMAGNITUDE is
'Измеренное значение';

comment on column PQLOG.VPU is
'Относительное отклонение';

comment on column PQLOG.VDURATION is
'Длительность сек';

comment on column PQLOG.VEVENT is
'Код события';

comment on column PQLOG.VCATEGORY is
'Категория нарушения';

alter table PQLOG
   add constraint PQLOG_F1 foreign key (MID)
      references POINTS (MID)
      on delete cascade;

--------28/07/2010
/*==============================================================*/
/* Table: TIMETYPES                                             */
/*==============================================================*/
create table TIMETYPES  (
   NTIMETYPE            NUMBER(10)                      not null,
   VTIMETYPE            VARCHAR2(256)                   not null,
   constraint PK_TIMETYPES primary key (NTIMETYPE)
);

comment on table TIMETYPES is
'Типы временного среза';

comment on column TIMETYPES.NTIMETYPE is
'Ид типа временного среза';

comment on column TIMETYPES.VTIMETYPE is
'Наименование';

/*==============================================================*/
/* Index: TIMETYPES_IDX1                                        */
/*==============================================================*/
create unique index TIMETYPES_IDX1 on TIMETYPES (
   VTIMETYPE ASC
);

/*==============================================================*/
/* Table: PARSINGMAKETS                                         */
/*==============================================================*/
create global temporary table PARSINGMAKETS  (
   NOPERATION           NUMBER(10)                      not null,
   NROW                 NUMBER(10)                      not null,
   NCOL                 NUMBER(10)                      not null,
   VCODE                VARCHAR2(2000),
   MID                  NUMBER,
   NMEASURE             NUMBER(10),
   NTIMETYPE            NUMBER(10),
   RATE                 NUMBER(1),
   DDATETIME            DATE,
   NVALUE               NUMBER,
   constraint PK_PARSINGMAKETS primary key (NOPERATION, NROW, NCOL)
)
on commit preserve rows
/

comment on table PARSINGMAKETS is
'Разобранные макеты';

comment on column PARSINGMAKETS.NOPERATION is
'Ид операции';

comment on column PARSINGMAKETS.NROW is
'Строка';

comment on column PARSINGMAKETS.NCOL is
'Столбец';

comment on column PARSINGMAKETS.VCODE is
'Код строки в макете';

comment on column PARSINGMAKETS.MID is
'ИД точки';

comment on column PARSINGMAKETS.NMEASURE is
'Ид типа информации';

comment on column PARSINGMAKETS.NTIMETYPE is
'Ид типа временного среза';

comment on column PARSINGMAKETS.RATE is
'Зона';

comment on column PARSINGMAKETS.DDATETIME is
'Дата время';

comment on column PARSINGMAKETS.NVALUE is
'Значение';

/*==============================================================*/
/* Index: PARSINGMAKETS_IDX1                                    */
/*==============================================================*/
create index PARSINGMAKETS_IDX1 on PARSINGMAKETS (
   NMEASURE ASC
);

/*==============================================================*/
/* Index: PARSINGMAKETS_IDX2                                    */
/*==============================================================*/
create index PARSINGMAKETS_IDX2 on PARSINGMAKETS (
   NTIMETYPE ASC
);

/*==============================================================*/
/* Index: PARSINGMAKETS_IDX3                                    */
/*==============================================================*/
create index PARSINGMAKETS_IDX3 on PARSINGMAKETS (
   MID ASC
);

INSERT INTO TIMETYPES ("NTIMETYPE","VTIMETYPE") VALUES(1,'Месячный срез (MONTHSORG)');
INSERT INTO TIMETYPES("NTIMETYPE","VTIMETYPE")VALUES(2,'Дневной срез (BILLORG)');
INSERT INTO TIMETYPES("NTIMETYPE","VTIMETYPE")VALUES(3,'Часовой срез (HALFHOUROLD)');
INSERT INTO TIMETYPES("NTIMETYPE","VTIMETYPE")VALUES(4,'Минутный срез (PROFILE)');
INSERT INTO TIMETYPES("NTIMETYPE","VTIMETYPE")VALUES(5,'Текущий срез (CURR_POWER)');


--29/07/2010
begin
INSERT INTO measures(nmeasure,VNAME,vcode)VALUES(74,'Показания Q2 (Реактив, Q2)','Q2M');
INSERT INTO measures(nmeasure,VNAME,vcode)VALUES(76,'Показания Q4 (Реактив, Q4)','Q4M');
commit;
exception
when others then rollback;
end;
/

--30/07/2010
INSERT INTO PROTOCOLS(protocol_id, name, dll_name) VALUES (1011,'МСТ-04 (DLL)','mst.dll');
commit;

INSERT INTO TIMETYPES("NTIMETYPE","VTIMETYPE")VALUES(6,'Часовой срез сумма (без таблицы)');
commit;


----06.08.2010
INSERT INTO RYDA.PROTOCOLS VALUES(110,'Satec - Качество_ЭЭ (файл)','');
commit;


---01.09.2010
begin execute immediate 'drop package MAKETLOADER_PG'; exception when others then null; end;
/

----------------------------------------------------------------------------------------------
-- 2010.09.17     VER 2.37.1 (Для обновления версии 2.37.0.1 до текущей скрипт запускать отсюда)      
----------------------------------------------------------------------------------------------
alter table FORMULPARAMS add(
   MID                  NUMBER
);

/*==============================================================*/
/* Index: FORMULPARAMS_IDX1                                     */
/*==============================================================*/
create index FORMULPARAMS_IDX1 on FORMULPARAMS (
   MID ASC
);

alter table FORMULPARAMS
   add constraint FORMULPARAMS_F2 foreign key (MID)
      references POINTS (MID);

update FORMULPARAMS set mid=util_pg.get_param(VPARAM,2,'.') where util_pg.get_param(VPARAM,1,'.')='MID' 
and util_pg.allnumber_f(util_pg.get_param(VPARAM,2,'.')) in (select mid from points);

commit;

----------------18/10/2010
INSERT INTO measures("NMEASURE","VNAME","VCODE","NMRID")VALUES(78,'Номер получасовки','DATNUM',0);
INSERT INTO OBJTYPEMEAS("IND","NMEASURE")VALUES(3,78);
INSERT INTO OBJTYPEMEAS("IND","NMEASURE")VALUES(4,78);
commit;


----------------04/11/2010
alter table POINTFORMULA  add(
   NHOURERIOD           NUMBER(1)                      default 0 not null
      constraint CKC_NHOURERIOD_POINTFOR check (NHOURERIOD in (0,1)),
   NDIVTYPE             NUMBER(1)                      default 0 not null
      constraint CKC_NDIVTYPE_POINTFOR check (NDIVTYPE in (0,1))
);

comment on column POINTFORMULA.NHOURERIOD is
'Часовой период интеграции при расчете';

comment on column POINTFORMULA.NDIVTYPE is
'Тип деления данных при часовом расчете';

-------------08/11/2010
drop table bill_calc;

------12/11/2010
update parameter set VVALUE=to_char(trunc(sysdate),'dd.mm.yyyy hh24:mi:ss'),VDESCRIPTION='Дата последнего анализа измененных данных' where npid=4;
commit;

------16/11/2010
drop table CALC_TMP;


/*==============================================================*/
/* Table: LASTREC                                               */
/*==============================================================*/
create global temporary table LASTREC  (
   MID                  NUMBER                          not null,
   DDATE                DATE                            not null,
   constraint PK_LASTREC primary key (MID, DDATE)
)
on commit preserve rows
 organization heap;

comment on table LASTREC is
'Последние получасовки';

comment on column LASTREC.MID is
'Ид точки';

comment on column LASTREC.DDATE is
'Дата';

/*==============================================================*/
/* Index: LASTREC_IDX1                                          */
/*==============================================================*/
create index LASTREC_IDX1 on LASTREC (
   DDATE ASC
);

/*==============================================================*/
/* Table: LASTRECFORRECALC                                      */
/*==============================================================*/
create global temporary table LASTRECFORRECALC  (
   MID                  NUMBER                          not null,
   DDATE                DATE                            not null,
   NTYPE                NUMBER(1),
   constraint PK_LASTRECFORRECALC primary key (MID, DDATE)
)
on commit preserve rows
 organization heap;

comment on table LASTRECFORRECALC is
'Последние получасовки для пересчета';

comment on column LASTRECFORRECALC.MID is
'Ид точки';

comment on column LASTRECFORRECALC.DDATE is
'Дата';

comment on column LASTRECFORRECALC.NTYPE is
'Тип';

/*==============================================================*/
/* Index: LASTRECFORRECALC_IDX1                                 */
/*==============================================================*/
create index LASTRECFORRECALC_IDX1 on LASTRECFORRECALC (
   DDATE ASC
);

---18/10/2010
drop table LAGGING_RECORDS;

INSERT INTO deportprocedures("NPROCEDURE","VNAME","VPROCEDURE","NPERIOD","NTYPE","VMEMO")
VALUES(72,'Расчет зависимых данных','CALCFORMULA_PG.CALC_LAGGING_JOB',0,1,'Расчет зависимых данных');
commit;

INSERT INTO PROTOCOLS(protocol_id, name, dll_name) VALUES (112,'НИК-2303','');
commit;

------19/11/2010
update parameter set VVALUE=0,VDESCRIPTION='Строка семафора диспетчера ССД' where npid=6;
commit;

update channels set NLOCKCORRECTTIME=0 where PROTOCOL_ID=37;
commit;

------26/11/2010
update formulparams set NSHIFT=NSHIFT*24 where not exists(select * from formulparams where abs(NSHIFT)=24);
commit;



----------------------------------------------------------------------------------------------
-- 2010.11.26     VER 2.38.2 (Для обновления версии 2.38.1.1 до текущей скрипт запускать отсюда)      
----------------------------------------------------------------------------------------------
--drop table ROUND30817;
create table ROUND30817  (
   MID                  NUMBER                          not null,
   DATE_TIME            DATE                           default sysdate not null,
   ER                   NUMBER,
   ED                   NUMBER,
   Q1                   NUMBER,
   Q3                   NUMBER,
   Q2                   NUMBER,
   Q4                   NUMBER,
   constraint PK_ROUND30817 primary key (MID, DATE_TIME)
);

comment on table ROUND30817 is
'Остатки округления 30817';

comment on column ROUND30817.MID is
'Ид точки';

comment on column ROUND30817.DATE_TIME is
'Дата';

comment on column ROUND30817.ER is
'Расход А пр';

comment on column ROUND30817.ED is
'Расход А отд';

comment on column ROUND30817.Q1 is
'Расход R пр';

comment on column ROUND30817.Q3 is
'Расход R отд';

comment on column ROUND30817.Q2 is
'Расход Q2';

comment on column ROUND30817.Q4 is
'Расход Q4';

alter table ROUND30817
   add constraint ROUND30817_F1 foreign key (MID)
      references POINTS (MID)
      on delete cascade;

----30/11/2010
alter table FEEDERS  add(
   NWITHSWITCH          NUMBER(1)                      default 0 not null
      constraint CKC_NWITHSWITCH_FEEDERS check (NWITHSWITCH in (0,1))
);

comment on column FEEDERS.NWITHSWITCH is 'Данные с учетом ОВ';

-----01/12/2010
create library utils_lib as '$ORACLE_HOME\bin\orawpcom10.dll'
/
create TYPE OAArgTable AS TABLE OF VARCHAR2(32767)
/
create TYPE OAArgTypeTable AS TABLE OF VARCHAR2(32)
/


--02.12.2010
insert into parameter (NPID,VVALUE,VDESCRIPTION) values(52,10,'Сдвиг времени (мин) привыдачи последней получасовки (мощности) на мнемосхему.');
commit;


declare
ln_1 NUMBER;
ln_2 NUMBER;
begin
select max(nid) into ln_1 from BASEFORMULA where vname='Базовые функции';
if ln_1 is null then 
return;
end if;
select points_seq.NEXTVAL into ln_2 from dual;
INSERT INTO BASEFORMULA("NID","NPARENT","NTYPE","VNAME","VFORMULA","VMEMO")VALUES(ln_2,ln_1,1,'Округление ГН с переносом остатков','round30817(a,1)',NULL);
select points_seq.NEXTVAL into ln_2 from dual;
INSERT INTO BASEFORMULA("NID","NPARENT","NTYPE","VNAME","VFORMULA","VMEMO")VALUES(ln_2,ln_1,1,'Приведение ГН к разнице показаний','round30817(a,2)',NULL);
commit;
exception
when others then rollback;
end;
/

----------------------------------------------------------------------------------------------
-- 2010.12.08     VER 2.38.4 (Для обновления версии 2.38.3.1 до текущей скрипт запускать отсюда)      
----------------------------------------------------------------------------------------------


/*==============================================================*/
/* Table: METERTYPEDICT                                         */
/*==============================================================*/
create table METERTYPEDICT  (
   NMETERTYPE           NUMBER(10)                      not null,
   VNAME                VARCHAR2(256),
   DIGITS               NUMBER,
   MCURRENT             NUMBER,
   MPOWER               NUMBER,
   MCONST               NUMBER,
   MCLASS               NUMBER,
   constraint PK_METERTYPEDICT primary key (NMETERTYPE)
);

comment on table METERTYPEDICT is
'Справочник типов счетчиков';

comment on column METERTYPEDICT.NMETERTYPE is
'Ид тиа счетчика';

comment on column METERTYPEDICT.VNAME is
'Наименование типа';

comment on column METERTYPEDICT.DIGITS is
'Значность';

comment on column METERTYPEDICT.MCURRENT is
'Ток';

comment on column METERTYPEDICT.MPOWER is
'Напряжение';

comment on column METERTYPEDICT.MCONST is
'Кол импульсов';

comment on column METERTYPEDICT.MCLASS is
'Класс';

/*==============================================================*/
/* Index: METERTYPEDICT_IDX1                                    */
/*==============================================================*/
create unique index METERTYPEDICT_IDX1 on METERTYPEDICT (
   VNAME ASC
);


---08/12/2010
CREATE SEQUENCE DICT_SEQ INCREMENT BY  1 START WITH  1001 CACHE 20;

-----------------------------------------------------------------
---09/12/2010
/*==============================================================*/
/* Table: PASFILES                                              */
/*==============================================================*/
create table PASFILES  (
   MID                  NUMBER                          not null,
   DENTER               DATE                           default sysdate not null,
   VFILENAME            VARCHAR2(64)                    not null,
   DFILEDATE            DATE                            not null,
   BFILEBODY            BLOB,
   constraint PK_PASFILES primary key (MID)
);

comment on table PASFILES is
'Файлы PAS';

comment on column PASFILES.MID is
'Ид точки';

comment on column PASFILES.DENTER is
'Дата изменения';

comment on column PASFILES.VFILENAME is
'Название файла';

comment on column PASFILES.DFILEDATE is
'Дата файла';

comment on column PASFILES.BFILEBODY is
'Файл';


alter table PASFILES
   add constraint PASFILES_F1 foreign key (MID)
      references POINTS (MID)
      on delete cascade;

/*
-- Только СЭС
INSERT INTO tasks(TASK_ID,PARENT,TASK_COD,NAME,REMARK,nshow)
VALUES(107,77,663,'6.04 Обновление БД качества электроэнергии','Обновление БД качества электроэнергии',0);
commit;
*/



----------------------------------------------------------------------------------------------
-- 2010.12.15     VER 2.38.5 (Для обновления версии 2.38.4.1 до текущей скрипт запускать отсюда)      
----------------------------------------------------------------------------------------------
INSERT INTO protocols("PROTOCOL_ID","NAME","DLL_NAME")VALUES(111,'Satec - v2m',NULL);
commit;

update protocols set PROTOCOL_ID=112, NAME='НИК-2303',DLL_NAME='' where PROTOCOL_ID=1012;
commit;

/*
--Для НЭК
INSERT INTO protocols("PROTOCOL_ID","NAME","DLL_NAME")VALUES(113,'Файл (XLS-Молдова)',NULL);
commit;
*/


alter table RMAKETS  add(
   BMAKET               BLOB
);

comment on column RMAKETS.BMAKET is
'Файл макета';

----22/12/2010
 insert into addpointparam
 select -25,'Допустимая разница показаний и ГН (A+)кВт',NTYPE from addpointparam where nsort=-24;
 insert into addpointparam
 select -26,'Допустимая разница показаний и ГН (A-)кВт',NTYPE from addpointparam where nsort=-24;
 insert into addpointparam
 select -27,'Допустимая разница показаний и ГН (Q1)кВт',NTYPE from addpointparam where nsort=-24;
 insert into addpointparam
 select -28,'Допустимая разница показаний и ГН (Q2)кВт',NTYPE from addpointparam where nsort=-24;
 insert into addpointparam
 select -29,'Допустимая разница показаний и ГН (Q3)кВт',NTYPE from addpointparam where nsort=-24;
 insert into addpointparam
 select -30,'Допустимая разница показаний и ГН (Q4)кВт',NTYPE from addpointparam where nsort=-24;

 update addpointparam set VDESCR='Допустимая разница показаний и ГН (A+), кВт' where nsort=-25; 
 update addpointparam set VDESCR='Допустимая разница показаний и ГН (A-), кВт' where nsort=-26; 
 update addpointparam set VDESCR='Допустимая разница показаний и ГН (R+ или Q1), кВАр'where nsort=-27; 
 update addpointparam set VDESCR='Допустимая разница показаний и ГН (Q2), кВАр' where nsort=-28; 
 update addpointparam set VDESCR='Допустимая разница показаний и ГН (R- или Q3), кВАр' where nsort=-29; 
 update addpointparam set VDESCR='Допустимая разница показаний и ГН (Q4), кВАр'where nsort=-30; 
 commit;


----------------------------------------------------------------------------------------------
-- 2010.12.27     VER 2.39.0 (Для обновления версии 2.38.6 до текущей скрипт запускать отсюда)      
----------------------------------------------------------------------------------------------
begin 
insert into parameter (NPID,VVALUE,VDESCRIPTION) values(53,0,'Режим опроса с постоянным интервалом между циклами (не зависимо от ошибки соединения).');
commit;
exception
when others then null;
end;
/


declare
ln_1 NUMBER;
ln_2 NUMBER;
begin
select max(nid) into ln_1 from BASEFORMULA where vname='Базовые функции';
if ln_1 is null then 
return;
end if;
select points_seq.NEXTVAL into ln_2 from dual;
INSERT INTO BASEFORMULA("NID","NPARENT","NTYPE","VNAME","VFORMULA","VMEMO") VALUES(ln_2,ln_1,2,'округление','round(a)',NULL);
commit;
exception
when others then rollback;
end;
/

---26/01/2011
drop sequence CALC_SEQ;

--03.02.2010
insert into METERTYPE(NMETERTYPE,VNAME) values(32,'НИК-2303');
commit;


----------------------------------------------------------------------------------------------
-- 2010.02.14     VER 2.39.2 (Для обновления версии 2.39.0 до текущей скрипт запускать отсюда)      
----------------------------------------------------------------------------------------------
/*==============================================================*/
/* Table: GREENPOINT                                            */
/*==============================================================*/
create table GREENPOINT  (
   MID                  NUMBER                          not null,
   NORDER               NUMBER                         default 0 not null,
   constraint PK_GREENPOINT primary key (MID)
);

comment on table GREENPOINT is
'Зеленые точки подъема';

comment on column GREENPOINT.MID is
'Ид точки';

comment on column GREENPOINT.NORDER is
'Сортровка';

alter table GREENPOINT
   add constraint FK_GREENPOI_GREENPOIN_POINTS foreign key (MID)
      references POINTS (MID)
      on delete cascade;

----------------------------------------------------------------------------------------------
--15/02/2011
declare
  ln_id        NUMBER;
  lv_objtype   VARCHAR2(128);
  ln_res       NUMBER;
BEGIN
 begin lv_objtype:=util_pg.get_param('MID.1', 1, '.'); exception when others then null; end;

 for lc in (select NID,NORDER,trim(UPPER(VPARAM)) VPARAM from FORMULPARAMS) loop
  ln_res:=NULL;
  lv_objtype:=TRIM(util_pg.get_param(lc.VPARAM, 1, '.'));
  ln_id:=util_pg.allnumber_f(TRIM(util_pg.get_param(lc.VPARAM, 2, '.')));
  IF lv_objtype = 'GID' THEN
   SELECT MAX(mid)
     INTO ln_res
     FROM GROUPS
    WHERE gid = ln_id;
  ELSIF lv_objtype = 'MID' THEN
   ln_res := ln_id;
  END IF;
  update FORMULPARAMS set mid=ln_res where nid=lc.nid and norder=lc.norder;
 end loop;
 commit;
end; 
/

/*
--Только вручную убираем GID.
update formulparams set vparam='MID.'||EDITFORMULA_PG.get_mid(vparam)||substr(vparam,instr(VPARAM,'.',1,2)) where VPARAM like 'GID.%' and EDITFORMULA_PG.get_mid(vparam) is not null;
--select * from  formulparams where VPARAM like 'GID.%' and EDITFORMULA_PG.get_mid(vparam) is null
*/


---22/02/2011
alter table GREENPOINT  add(
   NTYPE                NUMBER(1) default 1 not null
      constraint CKC_NTYPE_GREENPOI check (NTYPE in (1,2))
);

comment on column GREENPOINT.NTYPE is
'Тип точки';




declare
ln_1 NUMBER;
ln_2 NUMBER;
begin
update BASEFORMULA set VNAME='Округление ГН (тыс. кВт*ч) с переносом остатков' where vname='Округление ГН с переносом остатков';
update BASEFORMULA set VNAME='Приведение ГН (тыс. кВт*ч) к разнице показаний' where vname='Приведение ГН к разнице показаний';

select max(nid) into ln_1 from BASEFORMULA where vname='Базовые функции';
if ln_1 is null then 
return;
end if;
select points_seq.NEXTVAL into ln_2 from dual;
INSERT INTO BASEFORMULA("NID","NPARENT","NTYPE","VNAME","VFORMULA","VMEMO")VALUES(ln_2,ln_1,1,'Округление ГН (кВт*ч) с переносом остатков','round30817(a,3)',NULL);
select points_seq.NEXTVAL into ln_2 from dual;
INSERT INTO BASEFORMULA("NID","NPARENT","NTYPE","VNAME","VFORMULA","VMEMO")VALUES(ln_2,ln_1,1,'Приведение ГН (кВт*ч) к разнице показаний','round30817(a,4)',NULL);
commit;
exception
when others then rollback;
end;
/

----------------------------------------------------------------------------------------------
-- 2010.03.10     VER 2.39.3 (Для обновления версии 2.39.2 до текущей скрипт запускать отсюда)      
----------------------------------------------------------------------------------------------
INSERT INTO deportprocedures VALUES (73,'Проверка переключения ОВ','check_pg.checkSwitchOV',2,1,'Проверкапереключения ОВ в АСКУЭ');
INSERT INTO deportprocedures VALUES (74,'Проверка изменения номера счетчика','check_pg.checkmeters',2,1,'Проверяет факт отображения в АСКУЭ реальной замены счетчика');
commit;


----------------------------------------------------------------------------------------------
-- 2010.03.21     VER 2.39.4 (Для обновления версии 2.39.3 до текущей скрипт запускать отсюда)      
----------------------------------------------------------------------------------------------
declare
 ln_nn NUMBER;
begin
 SELECT MAX(a.template_id)+1
 INTO ln_nn
 FROM form_templates a;
 
insert into form_templates(template_id, parent, codetemplate, nameform, commentform, enablecontrols, stepprofile, namealert)
SELECT ln_nn, a.parent, 207,'1.19. Небаланс активной энергии нарастающий','Небаланс активной энергии нарастающий', a.enablecontrols, a.stepprofile, a.namealert
  FROM form_templates a  where CODETEMPLATE=206;
  commit;
end;
/

----------------------------------------------------------------------------------------------
-- 2010.04.01     VER 2.40 (Для обновления версии 2.40 до текущей скрипт запускать отсюда)      
----------------------------------------------------------------------------------------------

begin
update points set parent=3 where parent is  null and mid in (select ndeportation from deportation);
commit;
end;
/


----------------------------------------------------------------------------------------------

-- 2010.04.27     VER 2.40 (Для обновления версии 2.40 до текущей скрипт запускать отсюда)      
 
 declare
 ln_nn NUMBER:=78;
 begin
--  select max(nmeasure)into ln_nn from measures;
  insert into measures (nmeasure, vname, vcode, nmrid)
  values (ln_nn+1,'ER_C (Актив,прием) -нараст.итог с начала суток','ER_C.CD',0);
  insert into objtypemeas (ind,NMEASURE)values(3,ln_nn+1);
  insert into objtypemeas (ind,NMEASURE)values(4,ln_nn+1);
  insert into measures (nmeasure, vname, vcode, nmrid)
  values (ln_nn+2,'ER_C (Актив,прием) -нараст.итог с начала месяца','ER_C.CM',0);
   insert into objtypemeas (ind,NMEASURE)values(3,ln_nn+2);
  insert into objtypemeas (ind,NMEASURE)values(4,ln_nn+2);
 /* insert into measures (nmeasure, vname, vcode, nmrid)
  values (ln_nn+3,'ER_C (Актив,прием) -нараст.итог с начала года','ER_C.CY',0);
   insert into objtypemeas (ind,NMEASURE)values(3,ln_nn+3);
  insert into objtypemeas (ind,NMEASURE)values(4,ln_nn+3);*/
  commit;
   insert into measures (nmeasure, vname, vcode, nmrid)
  values (ln_nn+4,'ED_C (Актив,отдача) -нараст.итог с начала суток','ED_C.CD',0);
   insert into objtypemeas (ind,NMEASURE)values(3,ln_nn+4);
  insert into objtypemeas (ind,NMEASURE)values(4,ln_nn+4);
  insert into measures (nmeasure, vname, vcode, nmrid)
  values (ln_nn+5,'ED_C (Актив,отдача) -нараст.итог с начала месяца','ED_C.CM',0);
   insert into objtypemeas (ind,NMEASURE)values(3,ln_nn+5);
  insert into objtypemeas (ind,NMEASURE)values(4,ln_nn+5);
/*  insert into measures (nmeasure, vname, vcode, nmrid)
  values (ln_nn+6,'ED_C (Актив,отдача) -нараст.итог с начала года','ED_C.CY',0);
   insert into objtypemeas (ind,NMEASURE)values(3,ln_nn+6);
  insert into objtypemeas (ind,NMEASURE)values(4,ln_nn+6);*/
  commit;
 end;
 /  

----------------------------------------------------------------------------------------------
--2011.09.01 ИНТЭП ИНТЭП ИНТЭП ИНТЭП ИНТЭП     VER 3.0 (Для обновления версии 2.40 до текущей скрипт запускать отсюда)      
----------------------------------------------------------------------------------------------
   
alter table FEEDERS  add(
   NPOWERPRIM           NUMBER
);

comment on column FEEDERS.NWITHSWITCH is
'Данные с учетом ОВ';

comment on column FEEDERS.NPOWERPRIM is
'Напряжение на ГБР';
   

--21/09/2011
alter table PROTOCOLS  add(
   NCODE                NUMBER(10)
);

comment on column PROTOCOLS.NCODE is
'Обобщеный код протокола';

create index PROTOCOLS_IDX1 on PROTOCOLS (
   NCODE ASC
);

create table COMMONPROTOCOLS  (
   NCODE                NUMBER(10)                      not null,
   VNAME                VARCHAR2(256)                   not null,
   constraint PK_COMMONPROTOCOLS primary key (NCODE)
);

comment on table COMMONPROTOCOLS is
'Обобщенные протоколы';

comment on column COMMONPROTOCOLS.NCODE is
'Ид протокола';

comment on column COMMONPROTOCOLS.VNAME is
'Наименование протокола';

create unique index COMMONPROTOCOLS_IDX1 on COMMONPROTOCOLS (
   VNAME ASC
);

alter table PROTOCOLS
   add constraint PROTOCOLS_F1 foreign key (NCODE)
      references COMMONPROTOCOLS (NCODE);

begin
insert into COMMONPROTOCOLS values(0,'ACE6000');
insert into COMMONPROTOCOLS values(1,'SL-7000');
insert into COMMONPROTOCOLS values(2,'A1R Альфа');
insert into COMMONPROTOCOLS values(3,'ЕвроАльфа');
insert into COMMONPROTOCOLS values(4,'А1140 Альфа ');
insert into COMMONPROTOCOLS values(5,'A1800 Альфа');
insert into COMMONPROTOCOLS values(6,'RTU_ABB');
insert into COMMONPROTOCOLS values(7,'LG ZxB');
insert into COMMONPROTOCOLS values(8,'LG ZxD');
insert into COMMONPROTOCOLS values(9,'ZxQ');
insert into COMMONPROTOCOLS values(10,'Metcom');
insert into COMMONPROTOCOLS values(11,'FAG');
insert into COMMONPROTOCOLS values(12,'EMH');
insert into COMMONPROTOCOLS values(13,'УСПД КМ-64 Хартэп');
insert into COMMONPROTOCOLS values(14,'КМ Хартэп');
insert into COMMONPROTOCOLS values(15,'АСКУЭ Хартэп');
insert into COMMONPROTOCOLS values(16,'Oracle Database');
insert into COMMONPROTOCOLS values(17,'Загрузка файлов');
insert into COMMONPROTOCOLS values(18,'EVision');
insert into COMMONPROTOCOLS values(19,'LZQM');
insert into COMMONPROTOCOLS values(20,'EMS');
insert into COMMONPROTOCOLS values(21,'Элвин');
insert into COMMONPROTOCOLS values(22,'Облик');
insert into COMMONPROTOCOLS values(23,'Меркурий');
insert into COMMONPROTOCOLS values(24,'АРГО');
insert into COMMONPROTOCOLS values(25,'МСТ-04');
insert into COMMONPROTOCOLS values(26,'НИК-2303');
insert into COMMONPROTOCOLS values(27,'СЭБ-2А');
insert into COMMONPROTOCOLS values(28,'СЭТ-4');
insert into COMMONPROTOCOLS values(29,'Энергия 9');
insert into COMMONPROTOCOLS values(30,'CE-301');
insert into COMMONPROTOCOLS values(31,'CE-303');
insert into COMMONPROTOCOLS values(32,'CE-304');
insert into COMMONPROTOCOLS values(33,'CE-6850');
insert into COMMONPROTOCOLS values(34,'Satec');
insert into COMMONPROTOCOLS values(35,'Итек');
insert into COMMONPROTOCOLS values(36,'ЦТ-5000');
insert into COMMONPROTOCOLS values(37,'УППД');
insert into COMMONPROTOCOLS values(38,'ICCP');

update protocols set NCODE=0 where PROTOCOL_ID=98;
update protocols set NCODE=1 where PROTOCOL_ID=35;
update protocols set NCODE=1 where PROTOCOL_ID=36;
update protocols set NCODE=1 where PROTOCOL_ID=96;
update protocols set NCODE=1 where PROTOCOL_ID=49;
update protocols set NCODE=1 where PROTOCOL_ID=50;
update protocols set NCODE=2 where PROTOCOL_ID=11;
update protocols set NCODE=2 where PROTOCOL_ID=12;
update protocols set NCODE=2 where PROTOCOL_ID=102;
update protocols set NCODE=2 where PROTOCOL_ID=103;
update protocols set NCODE=3 where PROTOCOL_ID=1;
update protocols set NCODE=3 where PROTOCOL_ID=6;
update protocols set NCODE=3 where PROTOCOL_ID=93;
update protocols set NCODE=3 where PROTOCOL_ID=94;
update protocols set NCODE=3 where PROTOCOL_ID=43;
update protocols set NCODE=3 where PROTOCOL_ID=44;
update protocols set NCODE=3 where PROTOCOL_ID=82;
update protocols set NCODE=3 where PROTOCOL_ID=83;
update protocols set NCODE=3 where PROTOCOL_ID=84;
update protocols set NCODE=3 where PROTOCOL_ID=85;
update protocols set NCODE=4 where PROTOCOL_ID=1008;
update protocols set NCODE=5 where PROTOCOL_ID=104;
update protocols set NCODE=6 where PROTOCOL_ID=29;
update protocols set NCODE=6 where PROTOCOL_ID=30;
update protocols set NCODE=7 where PROTOCOL_ID=18;
update protocols set NCODE=7 where PROTOCOL_ID=19;
update protocols set NCODE=8 where PROTOCOL_ID=20;
update protocols set NCODE=8 where PROTOCOL_ID=21;
update protocols set NCODE=8 where PROTOCOL_ID=41;
update protocols set NCODE=8 where PROTOCOL_ID=70;
update protocols set NCODE=8 where PROTOCOL_ID=71;
update protocols set NCODE=8 where PROTOCOL_ID=72;
update protocols set NCODE=8 where PROTOCOL_ID=73;
update protocols set NCODE=9 where PROTOCOL_ID=91;
update protocols set NCODE=9 where PROTOCOL_ID=92;
update protocols set NCODE=10 where PROTOCOL_ID=23;
update protocols set NCODE=10 where PROTOCOL_ID=22;
update protocols set NCODE=10 where PROTOCOL_ID=54;
update protocols set NCODE=11 where PROTOCOL_ID=24;
update protocols set NCODE=11 where PROTOCOL_ID=25;
update protocols set NCODE=11 where PROTOCOL_ID=95;
update protocols set NCODE=11 where PROTOCOL_ID=74;
update protocols set NCODE=12 where PROTOCOL_ID=101;
update protocols set NCODE=13 where PROTOCOL_ID=27;
update protocols set NCODE=13 where PROTOCOL_ID=28;
update protocols set NCODE=13 where PROTOCOL_ID=31;
update protocols set NCODE=13 where PROTOCOL_ID=32;
update protocols set NCODE=13 where PROTOCOL_ID=57;
update protocols set NCODE=13 where PROTOCOL_ID=58;
update protocols set NCODE=13 where PROTOCOL_ID=59;
update protocols set NCODE=13 where PROTOCOL_ID=60;
update protocols set NCODE=13 where PROTOCOL_ID=108;
update protocols set NCODE=13 where PROTOCOL_ID=109;
update protocols set NCODE=15 where PROTOCOL_ID=1002;
update protocols set NCODE=16 where PROTOCOL_ID=1004;
update protocols set NCODE=17 where PROTOCOL_ID=113;
update protocols set NCODE=17 where PROTOCOL_ID=37;
update protocols set NCODE=17 where PROTOCOL_ID=38;
update protocols set NCODE=18 where PROTOCOL_ID=1003;
update protocols set NCODE=18 where PROTOCOL_ID=1005;
update protocols set NCODE=19 where PROTOCOL_ID=68;
update protocols set NCODE=19 where PROTOCOL_ID=69;
update protocols set NCODE=20 where PROTOCOL_ID=105;
update protocols set NCODE=21 where PROTOCOL_ID=53;
update protocols set NCODE=21 where PROTOCOL_ID=47;
update protocols set NCODE=21 where PROTOCOL_ID=48;
update protocols set NCODE=22 where PROTOCOL_ID=4;
update protocols set NCODE=22 where PROTOCOL_ID=7;
update protocols set NCODE=22 where PROTOCOL_ID=16;
update protocols set NCODE=22 where PROTOCOL_ID=17;
update protocols set NCODE=22 where PROTOCOL_ID=88;
update protocols set NCODE=22 where PROTOCOL_ID=89;
update protocols set NCODE=23 where PROTOCOL_ID=66;
update protocols set NCODE=23 where PROTOCOL_ID=67;
update protocols set NCODE=23 where PROTOCOL_ID=1006;
update protocols set NCODE=24 where PROTOCOL_ID=45;
update protocols set NCODE=24 where PROTOCOL_ID=46;
update protocols set NCODE=25 where PROTOCOL_ID=1011;
update protocols set NCODE=26 where PROTOCOL_ID=112;
update protocols set NCODE=27 where PROTOCOL_ID=1010;
update protocols set NCODE=28 where PROTOCOL_ID=62;
update protocols set NCODE=28 where PROTOCOL_ID=63;
update protocols set NCODE=29 where PROTOCOL_ID=5;
update protocols set NCODE=29 where PROTOCOL_ID=8;
update protocols set NCODE=29 where PROTOCOL_ID=33;
update protocols set NCODE=29 where PROTOCOL_ID=34;
update protocols set NCODE=29 where PROTOCOL_ID=55;
update protocols set NCODE=29 where PROTOCOL_ID=56;
update protocols set NCODE=29 where PROTOCOL_ID=1009;
update protocols set NCODE=29 where PROTOCOL_ID=1007;
update protocols set NCODE=31 where PROTOCOL_ID=80;
update protocols set NCODE=31 where PROTOCOL_ID=81;
update protocols set NCODE=32 where PROTOCOL_ID=75;
update protocols set NCODE=32 where PROTOCOL_ID=76;
update protocols set NCODE=33 where PROTOCOL_ID=78;
update protocols set NCODE=33 where PROTOCOL_ID=79;
update protocols set NCODE=34 where PROTOCOL_ID=111;
update protocols set NCODE=34 where PROTOCOL_ID=86;
update protocols set NCODE=34 where PROTOCOL_ID=87;
update protocols set NCODE=34 where PROTOCOL_ID=107;
update protocols set NCODE=34 where PROTOCOL_ID=110;
update protocols set NCODE=35 where PROTOCOL_ID=2;
update protocols set NCODE=35 where PROTOCOL_ID=3;
update protocols set NCODE=36 where PROTOCOL_ID=64;
update protocols set NCODE=36 where PROTOCOL_ID=65;
update protocols set NCODE=37 where PROTOCOL_ID=52;
update protocols set NCODE=37 where PROTOCOL_ID=100;
update protocols set NCODE=37 where PROTOCOL_ID=90;
update protocols set NCODE=38 where PROTOCOL_ID=77;

commit;
end;
/

update protocols set name='Oracle Database' where protocol_id=1004;
commit;

----------------------------------------------------------------------------------------------
-- 2011.09.14     VER 3.2 (Для обновления версии 3.1 до текущей скрипт запускать отсюда)      
----------------------------------------------------------------------------------------------
alter table TIMEZONES  add(
   DSUMMERESC           DATE
);

comment on column TIMEZONES.DSUMMERESC is 'Отмена переход на лето';


update timezones set DSUMMERESC=to_date('01.04.2111 00:00:00','dd.mm.yyyy hh24:mi:ss') where nid=1;
update timezones set DSUMMERESC=to_date('01.11.1900 00:00:00','dd.mm.yyyy hh24:mi:ss') where nid=4;
update timezones set DSUMMERESC=to_date('01.11.2110 00:00:00','dd.mm.yyyy hh24:mi:ss') where nid=3;
commit;

--2011/10/18
INSERT INTO protocols(PROTOCOL_ID,NAME,DLL_NAME,NCODE) VALUES (114,'CE-301',NULL,30);
commit;


----------------------------------------------------------------------------------------------
-- 2011.11.16     VER 3.2.3 (Для обновления версии 3.2 до текущей скрипт запускать отсюда)      
----------------------------------------------------------------------------------------------
begin 
insert into parameter (NPID,VVALUE,VDESCRIPTION) values(54,0,'Режим передачи текущих данных (углов) по протоколу comsrvdll_pg. 1-отно углы, иначе абс.');
commit;
exception
when others then null;
end;
/

begin 
insert into parameter (NPID,VVALUE,VDESCRIPTION) values(55,0,'Режим передачи ГН без КС по протоколу comsrvdll_pg.');
commit;
exception
when others then null;
end;
/

---01/12/2011
begin 
INSERT INTO db_term VALUES('RMAKETS','Принятые макеты',1000,0,'DCREATE','rmk','RMAKETS_IDX1');
commit;
exception
when others then null;
end;
/

begin 
INSERT INTO db_term VALUES('LG_LOADPROF','Мониторинг каналов (loadprof)',100,0,'DATE_TIME','lgp',NULL);
commit;
exception
when others then null;
end;
/

begin 
INSERT INTO db_term VALUES('LG_READOUT','Мониторинг каналов (readout)',100,0,'DATE_TIME','lgo',NULL);
commit;
exception
when others then null;
end;
/



----01/12/2011
INSERT INTO protocols VALUES (2001,'KM --> Альфа А1140 (DLL)','Alpha1140.dll',4);
commit;

--01/02/2012
update ADDPOINTPARAM set VDESCR='Тип парам. углов (1-SL,2-ARGO,3 или 0-все углы абсолютные,4 - Токи-относительные, иначе автоопределение)' where NSORT=46;
commit;

--08/02/2012
declare
ln_ret NUMBER;
ln_proc number:=72;
begin                   
select count(*) into ln_ret from dual where exists(select * from makets where nprocedure=ln_proc);
if ln_ret=0 then
RYDA.makets_pg.ins_m(ln_proc,'Расчет зависимых данных',NULL,0,0,1,NULL,ln_ret);
end if;
commit;
exception
when others then
rollback;
end;
/


----------------------------------------------------------------------------------------------
-- 2012.02.08     VER 3.2.4 (Для обновления версии 3.2.3 до текущей скрипт запускать отсюда)      
----------------------------------------------------------------------------------------------
INSERT INTO protocols VALUES (115,'УППД - Клиент (v.3)',NULL,37);
commit;


--29/02/2012
insert into COMMONPROTOCOLS values(39,'MTX-Router');
commit;
	
INSERT INTO protocols VALUES (116,'MTX-Router',NULL,39);
commit;


----------------------------------------------------------------------------------------------
-- 2012.03.27     VER 3.2.5 (Для обновления версии 3.2.4 до текущей скрипт запускать отсюда)      
----------------------------------------------------------------------------------------------
declare
ln_customer_id NUMBER;
begin
SELECT NVL(SUM(DECODE(vvalue, '', 0, vvalue)), 0)   INTO ln_customer_id   FROM parameter  WHERE npid = 12;
if ln_customer_id in (0,1,6,51) then
insert into parameter (NPID,VVALUE,VDESCRIPTION) values(56,1,'Разрешен оперативный опрос точки');
else
insert into parameter (NPID,VVALUE,VDESCRIPTION) values(56,0,'Разрешен оперативный опрос точки');
end if;
commit;
end;
/



----------------------------------------------------------------------------------------------
-- 2012.03.27     VER 3.2.5.2 (Для обновления версии 3.2.5.1 до текущей скрипт запускать отсюда)      
----------------------------------------------------------------------------------------------
insert into metertype(nmetertype,vname) values(33,'MTX Router') ;
commit;

begin 
insert into parameter (NPID,VVALUE,VDESCRIPTION) values(57,0,'IP порт MTX router');
commit;
exception
when others then null;
end;
/

begin 
insert into parameter (NPID,VVALUE,VDESCRIPTION) values(58,16,'MAX количество одновременно работающих MTX router');
commit;
exception
when others then null;
end;
/

declare
 ln_nn NUMBER:=84;
 begin
  insert into measures (nmeasure, vname, vcode, nmrid)
  values (ln_nn+1,'RK (Коеф пересчета)','RK',0);
  insert into objtypemeas (ind,NMEASURE)values(3,ln_nn+1);
  insert into objtypemeas (ind,NMEASURE)values(4,ln_nn+1);
  commit;
 end;
/  


--2012.04.24
update metertype set vname='TeleTec MTX RT' where nmetertype=33 ;
update COMMONPROTOCOLS set vname='TeleTec MTX RT' where ncode=39;
update protocols set name='TeleTec MTX RT' where protocol_id=116;

--Молдавские счетчики NP
insert into metertype(nmetertype,vname) values(34,'TeleTec RTR56') ;
insert into COMMONPROTOCOLS values(40,'TeleTec RTR56');
INSERT INTO protocols VALUES (117,'TeleTec RTR56',NULL,40);
commit;


BEGIN
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	631	,	1	,SUBSTR(REPLACE('	Значения накопительных регистров тарифа 1 потеряны	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	525	,	2	,SUBSTR(REPLACE('	Значения накопительных регистров тарифа 2 потеряны	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	526	,	3	,SUBSTR(REPLACE('	Значения накопительных регистров тарифа 3 потеряны	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	527	,	4	,SUBSTR(REPLACE('	Значения накопительных регистров тарифа 4 потеряны	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	528	,	17	,SUBSTR(REPLACE('	Доступ закрыт до конца суток из-за ошибок ключа доступа	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	529	,	18	,SUBSTR(REPLACE('	Доступ открыт',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	530	,	19	,SUBSTR(REPLACE('	Неверный ключ доступа	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	531	,	20	,SUBSTR(REPLACE('	Корпус счётчика открыт	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	532	,	21	,SUBSTR(REPLACE('	Корпус счётчика закрыт	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	533	,	22	,SUBSTR(REPLACE('	Обнаружено наличие электромагнитного влияния	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	534	,	23	,SUBSTR(REPLACE('	Обнаружено прекращение электромагнитного влияния	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	535	,	32	,SUBSTR(REPLACE('	Ключ доступа уровня 0 изменён	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	536	,	33	,SUBSTR(REPLACE('	Ключ доступа уровня 1 изменён	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	537	,	34	,SUBSTR(REPLACE('	Ключ доступа уровня 2 изменён	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	538	,	35	,SUBSTR(REPLACE('	Ключ доступа уровня 3 изменён	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	539	,	36	,SUBSTR(REPLACE('	Параметры изменены локально	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	540	,	37	,SUBSTR(REPLACE('	Параметры изменены удаленно	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	541	,	38	,SUBSTR(REPLACE('	Получена команда установки времени. Время установлено	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	542	,	39	,SUBSTR(REPLACE('	Получена команда включения реле	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	543	,	40	,SUBSTR(REPLACE('	Получена команда выключения реле	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	544	,	49	,SUBSTR(REPLACE('	Переполнение накопительного регистра энергии	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	545	,	50	,SUBSTR(REPLACE('	Тарифный план изменён	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	546	,	51	,SUBSTR(REPLACE('	Получен новый тарифный план	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	547	,	52	,SUBSTR(REPLACE('	Переход на летнее время	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	548	,	53	,SUBSTR(REPLACE('	Переход на зимнее время	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	549	,	54	,SUBSTR(REPLACE('	Реле включено	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	550	,	55	,SUBSTR(REPLACE('	Реле выключено	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	551	,	56	,SUBSTR(REPLACE('	Рестарт программы микроконтроллера	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	552	,	57	,SUBSTR(REPLACE('	Рестарт по WATCHDOG	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	553	,	64	,SUBSTR(REPLACE('	Восстановление нормального напряжения фазы A после повышенного	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	554	,	65	,SUBSTR(REPLACE('	Напряжение фазы A выше порога максимального напряжения	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	555	,	66	,SUBSTR(REPLACE('	Восстановление нормального напряжения фазы A после пониженного	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	556	,	67	,SUBSTR(REPLACE('	Напряжение фазы A ниже порога минимального напряжения	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	557	,	68	,SUBSTR(REPLACE('	Восстановление нормального напряжения фазы B после повышенного	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	558	,	69	,SUBSTR(REPLACE('	Напряжение фазы B выше порога максимального напряжения	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	559	,	70	,SUBSTR(REPLACE('	Восстановление нормального напряжения фазы B после пониженного	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	560	,	71	,SUBSTR(REPLACE('	Напряжение фазы B ниже порога минимального напряжения	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	561	,	72	,SUBSTR(REPLACE('	Восстановление нормального напряжения фазы C после повышенного	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	562	,	73	,SUBSTR(REPLACE('	Напряжение фазы C выше порога максимального напряжения	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	563	,	74	,SUBSTR(REPLACE('	Восстановление нормального напряжения фазы C после пониженного	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	564	,	75	,SUBSTR(REPLACE('	Напряжение фазы C ниже порога минимального напряжения	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	565	,	76	,SUBSTR(REPLACE('	Восстановление нормальной частоты после повышенной	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	566	,	77	,SUBSTR(REPLACE('	Частота выше порога максимальной частоты сети	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	567	,	78	,SUBSTR(REPLACE('	Восстановление нормальной частоты после пониженной	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	568	,	79	,SUBSTR(REPLACE('	Частота ниже порога минимальной частоты сети	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	569	,	80	,SUBSTR(REPLACE('	Восстановление нормальной температуры после повышенной	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	570	,	81	,SUBSTR(REPLACE('	Температура выше порога максимальной температуры	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	571	,	82	,SUBSTR(REPLACE('	Восстановление нормальной температуры после пониженной	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	572	,	83	,SUBSTR(REPLACE('	Температура нижее порога минимальной температуры	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	573	,	84	,SUBSTR(REPLACE('	Восстановление допустимого тока фазы A после повышенного	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	574	,	85	,SUBSTR(REPLACE('	Ток фазы A выше порога максимального тока	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	575	,	86	,SUBSTR(REPLACE('	Восстановление допустимого тока фазы B после повышенного	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	576	,	87	,SUBSTR(REPLACE('	Ток фазы B выше порога максимального тока	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	577	,	88	,SUBSTR(REPLACE('	Восстановление допустимого тока фазы C после повышенного	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	578	,	89	,SUBSTR(REPLACE('	Ток фазы C выше порога максимального тока	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	579	,	90	,SUBSTR(REPLACE('	Восстановление допустимой активной потребляемой мощности после повышенной	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	580	,	91	,SUBSTR(REPLACE('	Активная потребляемая мощность выше максимальной	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	581	,	92	,SUBSTR(REPLACE('	Восстановление допустимой реактивной потребляемой мощности после повышенной	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	582	,	93	,SUBSTR(REPLACE('	Реактивная потребляемая мощность выше максимальной	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	583	,	94	,SUBSTR(REPLACE('	Восстановление допустимого дифференциального тока после повышенного	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	584	,	95	,SUBSTR(REPLACE('	Превышение допустимого дифференциального тока	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	585	,	96	,SUBSTR(REPLACE('	Нормальное состояние часов реального времени восстановлено	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	586	,	97	,SUBSTR(REPLACE('	Часы реального времени не установлены	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	587	,	98	,SUBSTR(REPLACE('	Включение напряжения фазы C	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	588	,	99	,SUBSTR(REPLACE('	Выключение напряжения фазы C	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	589	,	100	,SUBSTR(REPLACE('	Включение напряжения фазы B	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	590	,	101	,SUBSTR(REPLACE('	Выключение напряжения фазы B	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	591	,	102	,SUBSTR(REPLACE('	Включение напряжения фазы A	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	592	,	103	,SUBSTR(REPLACE('	Выключение напряжения фазы A	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	593	,	104	,SUBSTR(REPLACE('	Восстановление нормального напряжения батареи	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	594	,	105	,SUBSTR(REPLACE('	Пониженное напряжения батареи	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	595	,	106	,SUBSTR(REPLACE('	Параметров калибровки установлены	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	596	,	107	,SUBSTR(REPLACE('	Калибровочные параметры потеряны	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	597	,	108	,SUBSTR(REPLACE('	Заводские параметры установлены	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	598	,	109	,SUBSTR(REPLACE('	Заводские параметры потеряны	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	599	,	110	,SUBSTR(REPLACE('	Параметры установлены	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	600	,	111	,SUBSTR(REPLACE('	Параметры потеряны	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	601	,	112	,SUBSTR(REPLACE('	Изменены параметры перехода на летнее время	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	602	,	113	,SUBSTR(REPLACE('	Включение второго реле	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	603	,	114	,SUBSTR(REPLACE('	Выключение второго реле	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	604	,	115	,SUBSTR(REPLACE('	Переход через 0 счетчика активной энергии по тарифу 1 при достижения 100000,000 кВт для счетчиков транф. включения (и счетчиков прямого включ. версии ниже 1.55). Переход через 0 счетчика активной энергии по тарифу 1 при достижения 1000000,00 кВт для счетчиков прямого включения	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	605	,	116	,SUBSTR(REPLACE('	Переход через 0 счетчика активной энергии по тарифу 2 при достижения 100000,000 кВт для счетчиков транф. включения (и счетчиков прямого включ. версии ниже 1.55) . Переход через 0 счетчика активной энергии по тарифу 2 при достижения 1000000,00 кВт для счетчиков прямого включения	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	606	,	117	,SUBSTR(REPLACE('	Переход через 0 счетчика активной энергии по тарифу 3 при достижения 100000,000 кВт для счетчиков транф. включения (и счетчиков прямого включ. версии ниже 1.55) . Переход через 0 счетчика активной энергии по тарифу 3 при достижения 1000000,00 кВт для счетчиков прямого включения	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	607	,	118	,SUBSTR(REPLACE('	Переход через 0 счетчика активной энергии по тарифу 4 при достижения 100000,000 кВт для счетчиков транф. включения (и счетчиков прямого включ. версии ниже 1.55) . Переход через 0 счетчика активной энергии по тарифу 4 при достижения 1000000,00 кВт для счетчиков прямого включения	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	608	,	119	,SUBSTR(REPLACE('	Переход через 0 счетчика реактивной положительной энергии по тарифу 1 при достижения 100000,000 кВар для счетчиков транф. включения (и счетчиков прямого включ. версии ниже 1.55) . Переход через 0 счетчика реактивной положительной энергии по тарифу 1 при достижения 1000000,00 кВар для счетчиков прямого включения	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	609	,	120	,SUBSTR(REPLACE('	Переход через 0 счетчика реактивной положительной энергии по тарифу 2 при достижения 100000,000 кВар для счетчиков транф. включения (и счетчиков прямого включ. версии ниже 1.55) . Переход через 0 счетчика реактивной положительной энергии по тарифу 2 при достижения 1000000,00 кВар для счетчиков прямого включения	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	610	,	121	,SUBSTR(REPLACE('	Переход через 0 счетчика реактивной положительной энергии по тарифу 3 при достижения 100000,000 кВар для счетчиков транф. включения (и счетчиков прямого включ. версии ниже 1.55) . Переход через 0 счетчика реактивной положительной энергии по тарифу 3 при достижения 1000000,00 кВар для счетчиков прямого включения	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	611	,	122	,SUBSTR(REPLACE('	Переход через 0 счетчика реактивной положительной энергии по тарифу 4 при достижения 100000,000 кВар для счетчиков транф. включения (и счетчиков прямого включ. версии ниже 1.55) . Переход через 0 счетчика реактивной положительной энергии по тарифу 4 при достижения 1000000,00 кВар для счетчиков прямого включения	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	612	,	123	,SUBSTR(REPLACE('	Переход через 0 счетчика реактивной отрицательной энергии по тарифу 1 при достижения 100000,000 кВар для счетчиков транф. включения (и счетчиков прямого включ. версии ниже 1.55) . Переход через 0 счетчика реактивной отрицательной энергии по тарифу 1 при достижения 1000000,00 кВар для счетчиков прямого включения	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	613	,	124	,SUBSTR(REPLACE('	Переход через 0 счетчика реактивной отрицательной энергии по тарифу 2 при достижения 100000,000 кВар для счетчиков транф. включения (и счетчиков прямого включ. версии ниже 1.55) . Переход через 0 счетчика реактивной отрицательной энергии по тарифу 2 при достижения 1000000,00 кВар для счетчиков прямого включения	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	614	,	125	,SUBSTR(REPLACE('	Переход через 0 счетчика реактивной отрицательной энергии по тарифу 3 при достижения 100000,000 кВар для счетчиков транф. включения (и счетчиков прямого включ. версии ниже 1.55) . Переход через 0 счетчика реактивной отрицательной энергии по тарифу 3 при достижения 1000000,00 кВар для счетчиков прямого включения	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	615	,	126	,SUBSTR(REPLACE('	Переход через 0 счетчика реактивной отрицательной энергии по тарифу 4 при достижения 100000,000 кВар для счетчиков транф. включения (и счетчиков прямого включ. версии ниже 1.55) . Переход через 0 счетчика реактивной отрицательной энергии по тарифу 4 при достижения 1000000,00 кВар для счетчиков прямого включения	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	616	,	127	,SUBSTR(REPLACE('	Калибровочный флаг установлен	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	617	,	128	,SUBSTR(REPLACE('	Калибровочный флаг сброшен	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	618	,	129	,SUBSTR(REPLACE('	Тест ЕЕPROM не прошел	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	619	,	130	,SUBSTR(REPLACE('	Тест FRAM не прошел	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	620	,	131	,SUBSTR(REPLACE('	Получена новая предоплата	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	621	,	132	,SUBSTR(REPLACE('	Параметры сальдо потеряны	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	622	,	133	,SUBSTR(REPLACE('	Аккумуляционные параметры потеряны	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	623	,	134	,SUBSTR(REPLACE('	Дополнительные аккумуляционные параметры потеряны	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	624	,	135	,SUBSTR(REPLACE('	Данные расчетных периодов потеряны	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	625	,	136	,SUBSTR(REPLACE('	Параметры блочных тарифов потеряны	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	626	,	137	,SUBSTR(REPLACE('	Значение калибровочных параметров потеряны	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	627	,	138	,SUBSTR(REPLACE('	Значение параметров перехода на зимнее/летнее время потеряны	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	628	,	139	,SUBSTR(REPLACE('	Операторские параметры потеряны	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	629	,	140	,SUBSTR(REPLACE('	Операторские параметры 2 потеряны	',CHR(9)),1,255),33,1,0,0);
COMMIT;
END;
/

INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	630	,	0	,'Событие счетчика',33,1,0,0);
commit;

---03/05/2012
declare
ln_customer_id NUMBER;
begin
SELECT NVL(SUM(DECODE(vvalue, '', 0, vvalue)), 0)   INTO ln_customer_id   FROM parameter  WHERE npid = 12;
if ln_customer_id in (7, 41, 42, 44, 49) then
insert into parameter (NPID,VVALUE,VDESCRIPTION) values(59,1,'Разрешена запись отрицательных значений при расчете формул (1-Да)');
else
insert into parameter (NPID,VVALUE,VDESCRIPTION) values(59,0,'Разрешена запись отрицательных значений при расчете формул');
end if;
commit;
exception when others then rollback;
end;
/

--14/05/2012 --Молдавские счетчики NP вторая нить (чтение SMS)
INSERT INTO protocols VALUES (118,'TeleTec RTR56 (SMS)',NULL,40);
commit;




----------------------------------------------------------------------------------------------
-- 2012.05.21     VER 3.3 (Для обновления версии 3.2.5.2 до текущей скрипт запускать отсюда)      
----------------------------------------------------------------------------------------------
insert into COMMONPROTOCOLS values(41,'TeleTec meters');
INSERT INTO protocols VALUES (119,'TeleTec MTX (dlms)',NULL,41);
INSERT INTO protocols VALUES (120,'TeleTec MTX (native)',NULL,41);
commit;

--23/05/2012
/*==============================================================*/
/* Table: MTXCONF                                               */
/*==============================================================*/
create table MTXCONF  (
   CID                  NUMBER(10)                      not null,
   DENTER               DATE                            default sysdate not null,
   ADDR                 VARCHAR2(64)                    not null,
   constraint PK_MTXCONF primary key (CID)
);

comment on table MTXCONF is
'Кофигурация MTX RT';

comment on column MTXCONF.CID is
'Ид канала';

comment on column MTXCONF.DENTER is
'Дата чтения';

comment on column MTXCONF.ADDR is
'Номер router';

alter table MTXCONF
   add constraint MTXCONF_F1 foreign key (CID)
      references CHANNELS (CID)
      on delete cascade;


--drop table MTXCONFDET;
/*==============================================================*/
/* Table: MTXCONFDET                                            */
/*==============================================================*/
create table MTXCONFDET  (
   CID                  NUMBER(10)                      not null,
   NORDER               NUMBER(10)                      not null,
   VMAC                 VARCHAR2(64)                    not null,
   NTYPE                NUMBER(10)                      not null,
   DPRODUCTION          DATE                            not null,
   NMTRSN               NUMBER(10)                      not null,
   constraint PK_MTXCONFDET primary key (CID, NORDER)
);

comment on table MTXCONFDET is
'Кофигурация MTX RT детализация';

comment on column MTXCONFDET.CID is
'Ид канала';

comment on column MTXCONFDET.NORDER is
'Номер по порядку';

comment on column MTXCONFDET.VMAC is
'Mac адрес';

comment on column MTXCONFDET.NTYPE is
'Тип устройства';

comment on column MTXCONFDET.DPRODUCTION is
'Год выпуска';

comment on column MTXCONFDET.NMTRSN is
'Номер счетчика';

alter table MTXCONFDET
   add constraint MTXCONFDET_F1 foreign key (CID)
      references MTXCONF (CID)
      on delete cascade;



--drop table RTRSMSDET;
--drop table RTRSMS;
/*==============================================================*/
/* Table: RTRSMS                                                */
/*==============================================================*/
create table RTRSMS  (
   NOPERATION           NUMBER(10)                      not null,
   COM_ID               NUMBER                          not null,
   VNUMBER              VARCHAR2(32)                    not null,
   NPACKID              NUMBER(10)                      not null,
   NFRAMECNT            NUMBER(10)                      not null,
   NSTATE               NUMBER(1)                      default 0 not null
      constraint CKC_NSTATE_RTRSMS check (NSTATE in (0,1,2)),
   constraint PK_RTRSMS primary key (NOPERATION)
);

comment on table RTRSMS is
'Сообщения от счетчика';

comment on column RTRSMS.NOPERATION is
'Ид записи';

comment on column RTRSMS.COM_ID is
'Ид компорта';

comment on column RTRSMS.VNUMBER is
'Номер телефона';

comment on column RTRSMS.NPACKID is
'Номер запроса';

comment on column RTRSMS.NFRAMECNT is
'Общее количество SMS';

comment on column RTRSMS.NSTATE is
'Состояние';

/*==============================================================*/
/* Index: RTRSMS_IDX1                                           */
/*==============================================================*/
create index RTRSMS_IDX1 on RTRSMS (
   COM_ID ASC
);

alter table RTRSMS
   add constraint RTRSMS_F1 foreign key (COM_ID)
      references COMPORTS (COM_ID)
      on delete cascade;

/*==============================================================*/
/* Table: RTRSMSDET                                             */
/*==============================================================*/
create table RTRSMSDET  (
   NOPERATION           NUMBER(10)                      not null,
   NFRAMENUM            NUMBER(10)                      not null,
   DENTER               DATE                           default sysdate not null,
   VFRAME               VARCHAR2(2000),
   constraint PK_RTRSMSDET primary key (NOPERATION, NFRAMENUM)
);

comment on table RTRSMSDET is
'RTRSMSDET';

comment on column RTRSMSDET.NOPERATION is
'Ид записи';

comment on column RTRSMSDET.NFRAMENUM is
'Номер SMS ответа';

comment on column RTRSMSDET.DENTER is
'Дата получения';

comment on column RTRSMSDET.VFRAME is
'Текст SMS';

alter table RTRSMSDET
   add constraint FK_RTRSMSDE_REFERENCE_RTRSMS foreign key (NOPERATION)
      references RTRSMS (NOPERATION);

--25/05/2012
delete from MTXCONF;

alter table MTXCONFDET  add(
   VID                  VARCHAR2(128)                   not null
);

comment on column MTXCONFDET.VID is
'Ид счетчика';


CREATE SEQUENCE SMS_SEQ
 INCREMENT BY  1
 START WITH  1001
/


--29/05/2012
begin
INSERT INTO points(MID,PARENT,COD,IND,NAME,SHORT_NAME,PTYPE,IMPLEMENT_DATE,TAG,NPOINT) VALUES(56,NULL,NULL,1,'Устройства MTX RT','',NULL,'',NULL,NULL);
commit;
end;
/

drop table MTXCONFDET;
drop table MTXCONF;


/*==============================================================*/
/* Table: MTXCONF                                               */
/*==============================================================*/
create table MTXCONF  (
   MID                  NUMBER(10)                      not null,
   ADDR                 VARCHAR2(64)                    not null,
   NMTRSN               NUMBER(10)                      not null,
   DENTER               DATE                           default sysdate not null,
   NSTATE               NUMBER(1)                      default 0 not null,
   DSTATE               DATE                           default sysdate not null,
   constraint PK_MTXCONF primary key (MID)
);

comment on table MTXCONF is
'Устройства MTX RT';

comment on column MTXCONF.MID is
'Ид устройства';

comment on column MTXCONF.ADDR is
'Номер router';

comment on column MTXCONF.NMTRSN is
'Заводской номер устройства';

comment on column MTXCONF.DENTER is
'Дата ввода';

comment on column MTXCONF.NSTATE is
'Состояние';

comment on column MTXCONF.DSTATE is
'Дата изменения состояния';

/*==============================================================*/
/* Index: MTXCONF_IDX1                                          */
/*==============================================================*/
create unique index MTXCONF_IDX1 on MTXCONF (
   ADDR ASC
);

/*==============================================================*/
/* Index: MTXCONF_IDX2                                          */
/*==============================================================*/
create unique index MTXCONF_IDX2 on MTXCONF (
   NMTRSN ASC
);

alter table MTXCONF
   add constraint MTXCONF_F1 foreign key (MID)
      references POINTS (MID)
      on delete cascade;


/*==============================================================*/
/* Table: MTXCONFDET                                            */
/*==============================================================*/
create table MTXCONFDET  (
   MID                  NUMBER(10)                      not null,
   NORDER               NUMBER(10)                      not null,
   VMAC                 VARCHAR2(64)                    not null,
   NTYPE                NUMBER(10)                      not null,
   DPRODUCTION          DATE                            not null,
   NMTRSN               NUMBER(10)                      not null,
   VID                  VARCHAR2(128)                   not null,
   constraint PK_MTXCONFDET primary key (MID, NORDER)
);

comment on table MTXCONFDET is
'Кофигурация MTX RT детализация';

comment on column MTXCONFDET.MID is
'Ид устройства';

comment on column MTXCONFDET.NORDER is
'Номер по порядку';

comment on column MTXCONFDET.VMAC is
'Mac адрес';

comment on column MTXCONFDET.NTYPE is
'Тип устройства';

comment on column MTXCONFDET.DPRODUCTION is
'Год выпуска';

comment on column MTXCONFDET.NMTRSN is
'Номер счетчика';

comment on column MTXCONFDET.VID is
'Ид счетчика';

alter table MTXCONFDET
   add constraint MTXCONFDET_F1 foreign key (MID)
      references MTXCONF (MID)
      on delete cascade;

---01/06/2012

alter table RTRSMSDET drop constraint FK_RTRSMSDE_REFERENCE_RTRSMS;

alter table RTRSMSDET   add constraint RTRSMSDET_F1 foreign key (NOPERATION)      references RTRSMS (NOPERATION)      on delete cascade;


update metereventsdict d set d.neventclass=3 where d.nmetertype=33 and not exists (select * from metereventsdict where nmetertype=33 and neventclass=3);
commit;

--06/06/2012
drop index METEREVENTSDICT_IDX2;
create unique index METEREVENTSDICT_IDX2 on METEREVENTSDICT (   NMETERTYPE ASC,   VEVENTTEXT ASC,   NEVENTCLASS ASC);

begin
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	632	,	1	,SUBSTR(REPLACE('	Значения накопительных регистров потеряны	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	633	,	2	,SUBSTR(REPLACE('	Значение заводских параметров потеряны	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	634	,	3	,SUBSTR(REPLACE('	Значения операторских параметров потеряны	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	635	,	16	,SUBSTR(REPLACE('	Доступ закрыт до конца суток из-за ошибок ключа доступа	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	636	,	17	,SUBSTR(REPLACE('	Неверный ключ доступа	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	637	,	18	,SUBSTR(REPLACE('	Корпус счётчика открыт	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	638	,	19	,SUBSTR(REPLACE('	Корпус счётчика закрыт	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	639	,	20	,SUBSTR(REPLACE('	Обнаружено наличие электромагнитного влияния	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	640	,	21	,SUBSTR(REPLACE('	Обнаружено прекращение электромагнитного влияния	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	641	,	32	,SUBSTR(REPLACE('	Ключ доступа уровня 0 изменён	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	642	,	33	,SUBSTR(REPLACE('	Ключ доступа уровня 1 изменён	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	643	,	34	,SUBSTR(REPLACE('	Ключ доступа уровня 2 изменён	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	644	,	35	,SUBSTR(REPLACE('	Ключ доступа уровня 3 изменён	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	645	,	36	,SUBSTR(REPLACE('	Параметры изменены локально	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	646	,	37	,SUBSTR(REPLACE('	Параметры изменены удаленно	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	647	,	38	,SUBSTR(REPLACE('	Время изменено	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	648	,	39	,SUBSTR(REPLACE('	Получена команда включения реле	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	649	,	40	,SUBSTR(REPLACE('	Получена команда выключения реле	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	650	,	41	,SUBSTR(REPLACE('	Изменены параметры перехода на летнее время	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	651	,	49	,SUBSTR(REPLACE('	Переполнение накопительного регистра энергии	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	652	,	50	,SUBSTR(REPLACE('	Тарифный план изменён	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	653	,	51	,SUBSTR(REPLACE('	Получен новый тарифный план	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	654	,	52	,SUBSTR(REPLACE('	Переход на летнее время	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	655	,	53	,SUBSTR(REPLACE('	Переход на зимнее время	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	656	,	54	,SUBSTR(REPLACE('	Релев ключено	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	657	,	55	,SUBSTR(REPLACE('	Реле выключено	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	658	,	56	,SUBSTR(REPLACE('	Рестарт программы микроконтроллера	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	659	,	57	,SUBSTR(REPLACE('	Рестарт по WATCHDOG	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	660	,	58	,SUBSTR(REPLACE('	Включение напряжения фазы A	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	661	,	59	,SUBSTR(REPLACE('	Выключение напряжения фазы A	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	662	,	60	,SUBSTR(REPLACE('	Включение напряжения фазы B	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	663	,	61	,SUBSTR(REPLACE('	Выключение напряжения фазы B	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	664	,	62	,SUBSTR(REPLACE('	Включение напряжения фазы C	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	665	,	63	,SUBSTR(REPLACE('	Выключение напряжения фазы C	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	666	,	64	,SUBSTR(REPLACE('	Восстановление нормального напряжения после повышенного	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	667	,	65	,SUBSTR(REPLACE('	Напряжение выше порога максимального напряжения	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	668	,	66	,SUBSTR(REPLACE('	Восстановление нормального напряжения после пониженного	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	669	,	67	,SUBSTR(REPLACE('	Напряжение ниже порога минимального напряжения	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	670	,	68	,SUBSTR(REPLACE('	Восстановление нормальной температуры после повышенной	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	671	,	69	,SUBSTR(REPLACE('	Температура выше порога максимальной температуры	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	672	,	70	,SUBSTR(REPLACE('	Восстановление нормальной температуры после пониженной	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	673	,	71	,SUBSTR(REPLACE('	Температура нижее порога минимальной температуры	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	674	,	72	,SUBSTR(REPLACE('	Восстановление нормальной частоты после повышенной	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	675	,	73	,SUBSTR(REPLACE('	Частота выше порога максимальной частоты сети	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	676	,	74	,SUBSTR(REPLACE('	Восстановление нормальной частоты после пониженной	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	677	,	75	,SUBSTR(REPLACE('	Частота ниже порога минимальной частоты сети	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	678	,	76	,SUBSTR(REPLACE('	Восстановление допустимого тока после повышенного	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	679	,	77	,SUBSTR(REPLACE('	Ток выше порога максимального тока	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	680	,	78	,SUBSTR(REPLACE('	Восстановление допустимой потребляемой мощности после повышенной	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	681	,	79	,SUBSTR(REPLACE('	Потребляемая мощность выше порога максимальной мощности	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	682	,	80	,SUBSTR(REPLACE('	Восстановление допустимого дифференциального тока после повышенного	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	683	,	81	,SUBSTR(REPLACE('	Превышение допустимого дифференциального тока	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	684	,	82	,SUBSTR(REPLACE('	Восстановление нормального напряжения батареи	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	685	,	83	,SUBSTR(REPLACE('	Пониженное напряжения батареи	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	686	,	84	,SUBSTR(REPLACE('	Сохранение параметров калибровки	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	687	,	85	,SUBSTR(REPLACE('	Калибровочные параметры потеряны	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	688	,	86	,SUBSTR(REPLACE('	Восстановление нормального состояния часов реального времени	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	689	,	87	,SUBSTR(REPLACE('	Часы реального времени не установлены	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	690	,	88	,SUBSTR(REPLACE('	Выключение напряжения фазы ABC	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	691	,	89	,SUBSTR(REPLACE('	Включение напряжения фазы ABC	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	692	,	96	,SUBSTR(REPLACE('	Включение второго реле	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	693	,	97	,SUBSTR(REPLACE('	Выключение второго реле	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	694	,	98	,SUBSTR(REPLACE('	Переход через 0 счетчика активной энергии по тарифу 1 при достижения 1 000 000 000 Вт	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	695	,	99	,SUBSTR(REPLACE('	Переход через 0 счетчика активной энергии по тарифу 2 при достижения 1 000 000 000 Вт	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	696	,	100	,SUBSTR(REPLACE('	Переход через 0 счетчика активной энергии по тарифу 3 при достижения 1 000 000 000 Вт	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	697	,	101	,SUBSTR(REPLACE('	Переход через 0 счетчика активной энергии по тарифу 4 при достижения 1 000 000 000 Вт	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	698	,	102	,SUBSTR(REPLACE('	Калибровочный флаг установлен	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	699	,	103	,SUBSTR(REPLACE('	Калибровочный флаг сброшен	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	700	,	104	,SUBSTR(REPLACE('	Тест ЕЕPROM не прошел	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	701	,	105	,SUBSTR(REPLACE('	Тест FRAM не прошел	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	702	,	112	,SUBSTR(REPLACE('	Получена новая предоплата	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	703	,	113	,SUBSTR(REPLACE('	Параметры сальдо потеряны	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	704	,	114	,SUBSTR(REPLACE('	Аккумуляционные параметры потеряны	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	705	,	115	,SUBSTR(REPLACE('	Дополнительные аккумуляционные параметры потеряны	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	706	,	116	,SUBSTR(REPLACE('	Данные расчетных периодов потеряны	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	707	,	117	,SUBSTR(REPLACE('	Параметры блочных тарифов потеряны	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	708	,	118	,SUBSTR(REPLACE('	Значение калибровочных параметров потеряны	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	709	,	119	,SUBSTR(REPLACE('	Значение параметров перехода на зимнее/летнее время потеряны	',CHR(9)),1,255),33,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	710	,	120	,SUBSTR(REPLACE('	Значения энергий для расчета сальдо потеряны	',CHR(9)),1,255),33,1,0,0);
commit;
end;
/


---15/06/2012
drop table RTRSMSDET;
drop table RTRSMS;
/*==============================================================*/
/* Table: RTRSMS                                                */
/*==============================================================*/
create table RTRSMS  (
   NOPERATION           NUMBER(10)                      not null,
   NPACKID              NUMBER(10)                      not null,
   NID                  NUMBER(10)                      not null,
   NFRAMECNT            NUMBER(10)                      not null,
   NSTATE               NUMBER(1)                      default 0 not null
      constraint CKC_NSTATE_RTRSMS check (NSTATE in (0,1,2)),
   VSOURCE              VARCHAR2(32),
   constraint PK_RTRSMS primary key (NOPERATION)
);

comment on table RTRSMS is
'Сообщения от счетчика';

comment on column RTRSMS.NOPERATION is
'Ид записи';

comment on column RTRSMS.NPACKID is
'Номер запроса';

comment on column RTRSMS.NID is
'Номер счетчика';

comment on column RTRSMS.NFRAMECNT is
'Общее количество SMS';

comment on column RTRSMS.NSTATE is
'Состояние';

comment on column RTRSMS.VSOURCE is
'Источник';

/*==============================================================*/
/* Index: RTRSMS_IDX1                                           */
/*==============================================================*/
create index RTRSMS_IDX1 on RTRSMS (
   NID ASC
);

/*==============================================================*/
/* Table: RTRSMSDET                                             */
/*==============================================================*/
create table RTRSMSDET  (
   NOPERATION           NUMBER(10)                      not null,
   NFRAMENUM            NUMBER(10)                      not null,
   DENTER               DATE                           default sysdate not null,
   VFRAME               VARCHAR2(2000),
   constraint PK_RTRSMSDET primary key (NOPERATION, NFRAMENUM)
);

comment on table RTRSMSDET is
'RTRSMSDET';

comment on column RTRSMSDET.NOPERATION is
'Ид записи';

comment on column RTRSMSDET.NFRAMENUM is
'Номер SMS ответа';

comment on column RTRSMSDET.DENTER is
'Дата получения';

comment on column RTRSMSDET.VFRAME is
'Текст SMS';

alter table RTRSMSDET
   add constraint RTRSMSDET_F1 foreign key (NOPERATION)
      references RTRSMS (NOPERATION)
      on delete cascade;


----------------------------------------------------------------------------------------------
-- 17/07/2012     VER 3.3.2 (Для обновления версии 3.3.1 до текущей скрипт запускать отсюда)      
----------------------------------------------------------------------------------------------
INSERT INTO protocols VALUES (121,'TeleTec MTX (dlms)+Эхо',NULL,41);
commit;


-- 01/08/2012     
insert into COMMONPROTOCOLS values(42,'LG_ZCF');
INSERT INTO protocols(protocol_id, name, dll_name, ncode) VALUES (122,'LG_ZCF',NULL,42);
commit;




----------------------------------------------------------------------------------------------
-- 26/09/2012     VER 3.3.3 (Для обновления версии 3.3.2 до текущей скрипт запускать отсюда)      
----------------------------------------------------------------------------------------------

alter table FEEDERS  add(
   RESCANAL             NUMBER,
   VNOTE                VARCHAR2(256)
);

comment on column FEEDERS.CANAL is
'Связной номер';

comment on column FEEDERS.RESCANAL is
'Связной номер дополнительный';


alter table CHANPOINT  add(
   NUSERESCANAL         NUMBER                         default 0 not null
      constraint CKC_NUSERESCANAL_CHANPOIN check (NUSERESCANAL in (0,1))
);

comment on column CHANPOINT.NUSERESCANAL is
'Использовать второй связной номер';



alter table CHANNELS  add(
   VADDPARAM            VARCHAR2(128)
);

comment on column CHANNELS.VADDPARAM is
'Доп параметр канала';

----------------------------------------------------------------------------------------------
-- 23/10/2012     VER 3.3.4 (Для обновления версии 3.3.3 до текущей скрипт запускать отсюда)      
----------------------------------------------------------------------------------------------
INSERT INTO addformparam a( a.nsort, a.vdescr, a.ntype)
VALUES (-11,'Вывод формата представления данных',1); 
COMMIT;


--09/11/2012
INSERT INTO protocols(protocol_id, name, dll_name, ncode) VALUES (123,'EPQS',NULL,20);
commit;


--26/11/2012
insert into metertype(nmetertype,vname) values(35,'EPQS') ;
commit;


--27/11/2012
INSERT INTO deportprocedures("NPROCEDURE","VNAME","VPROCEDURE","NPERIOD","NTYPE","VMEMO")VALUES(75,'Архивирование БД НСИ','ryda.DB_DUMP_PG.EXP_DB',2,1,'Архивирование БД НСИ для НЭК');
INSERT INTO deportprocedures("NPROCEDURE","VNAME","VPROCEDURE","NPERIOD","NTYPE","VMEMO")VALUES(76,'Восстановление архива БД НСИ','ryda.DB_DUMP_PG.IMP_DB',2,1,'Восстановление архива БД НСИ для НЭК');
commit;


--28/11/2012
/*==============================================================*/
/* Table: DBNRI                                                 */
/*==============================================================*/
create table DBNRI  (
   VTABLENAME           VARCHAR2(50)                    not null,
   constraint PK_DBNRI primary key (VTABLENAME)
);

comment on table DBNRI is
'Таблицы НСИ';

comment on column DBNRI.VTABLENAME is
'Название таблицы';


---03/11/2012
begin
update forms set ENABLECONTROLS='0000000000000000000' where ENABLECONTROLS='00000000000000000000';
commit;
end;
/


--04/11/2012
begin
delete from dbnri;
INSERT INTO dbnri(VTABLENAME) values('ADDFORMPARAM');
INSERT INTO dbnri(VTABLENAME) values('ADDFORMPARAMVAL');
INSERT INTO dbnri(VTABLENAME) values('ADDPOINTPARAM');
INSERT INTO dbnri(VTABLENAME) values('ADDPOINTPARAMVAL');
INSERT INTO dbnri(VTABLENAME) values('ARC_BALANCES');
INSERT INTO dbnri(VTABLENAME) values('BASEFORMULA');
INSERT INTO dbnri(VTABLENAME) values('BASEFORMULPARAMS');
INSERT INTO dbnri(VTABLENAME) values('CALCARGUMENTS');
INSERT INTO dbnri(VTABLENAME) values('CALCBYDUPLICATION');
INSERT INTO dbnri(VTABLENAME) values('CALCPOINTBYGROUP');
INSERT INTO dbnri(VTABLENAME) values('CALCPOINTS');
INSERT INTO dbnri(VTABLENAME) values('CALCPOINTTYPE');
INSERT INTO dbnri(VTABLENAME) values('CALC_HOURS');
INSERT INTO dbnri(VTABLENAME) values('CALC_LINKS');
INSERT INTO dbnri(VTABLENAME) values('CALC_RESULTS');
INSERT INTO dbnri(VTABLENAME) values('CHANNELS');
INSERT INTO dbnri(VTABLENAME) values('CHANPOINT');
INSERT INTO dbnri(VTABLENAME) values('CHECK_STATUS');
INSERT INTO dbnri(VTABLENAME) values('COMMONPROTOCOLS');
INSERT INTO dbnri(VTABLENAME) values('COMPORTS');
INSERT INTO dbnri(VTABLENAME) values('COMPORTTYPE');
INSERT INTO dbnri(VTABLENAME) values('CONNECTIONPARAM');
INSERT INTO dbnri(VTABLENAME) values('CONNECTIONPARAMFULLHOURS');
INSERT INTO dbnri(VTABLENAME) values('CS_PROFILE');
INSERT INTO dbnri(VTABLENAME) values('DBMAIN');
INSERT INTO dbnri(VTABLENAME) values('DB_TERM');
INSERT INTO dbnri(VTABLENAME) values('DEPARTMENTS');
INSERT INTO dbnri(VTABLENAME) values('DEPORTATION');
INSERT INTO dbnri(VTABLENAME) values('DEPORTFILES');
INSERT INTO dbnri(VTABLENAME) values('DEPORTPROCEDURES');
INSERT INTO dbnri(VTABLENAME) values('DICT_OBJ_TYPES');
INSERT INTO dbnri(VTABLENAME) values('DIFTARIFF');
INSERT INTO dbnri(VTABLENAME) values('ENTERPRISE');
INSERT INTO dbnri(VTABLENAME) values('FEEDERS');
INSERT INTO dbnri(VTABLENAME) values('FEEDERSCOEF');
INSERT INTO dbnri(VTABLENAME) values('FILTERS');
INSERT INTO dbnri(VTABLENAME) values('FORMS');
INSERT INTO dbnri(VTABLENAME) values('FORMS_EX');
INSERT INTO dbnri(VTABLENAME) values('FORMULPARAMS');
INSERT INTO dbnri(VTABLENAME) values('FORM_GROUP');
INSERT INTO dbnri(VTABLENAME) values('FORM_TEMPLATES');
INSERT INTO dbnri(VTABLENAME) values('GREENPOINT');
INSERT INTO dbnri(VTABLENAME) values('GROUPLIMIT');
INSERT INTO dbnri(VTABLENAME) values('GROUPS');
INSERT INTO dbnri(VTABLENAME) values('GROUPTYPES');
INSERT INTO dbnri(VTABLENAME) values('ITEKCOEFF');
INSERT INTO dbnri(VTABLENAME) values('LAST_EXPORT');
INSERT INTO dbnri(VTABLENAME) values('LAST_SAVE');
INSERT INTO dbnri(VTABLENAME) values('MAKETFORMULAS');
INSERT INTO dbnri(VTABLENAME) values('MAKETGROUPS');
INSERT INTO dbnri(VTABLENAME) values('MAKETPOINTS');
INSERT INTO dbnri(VTABLENAME) values('MAKETS');
INSERT INTO dbnri(VTABLENAME) values('MAN_INP_HHOUR');
INSERT INTO dbnri(VTABLENAME) values('MAXHOURS');
INSERT INTO dbnri(VTABLENAME) values('MEASURES');
INSERT INTO dbnri(VTABLENAME) values('METEREVENTSDICT');
INSERT INTO dbnri(VTABLENAME) values('METERPARAMETER');
INSERT INTO dbnri(VTABLENAME) values('METERS');
INSERT INTO dbnri(VTABLENAME) values('METERSHISTORY');
INSERT INTO dbnri(VTABLENAME) values('METERSTATUSBITDICT');
INSERT INTO dbnri(VTABLENAME) values('METERTYPE');
INSERT INTO dbnri(VTABLENAME) values('METERTYPEDICT');
INSERT INTO dbnri(VTABLENAME) values('MONITORS');
INSERT INTO dbnri(VTABLENAME) values('MONITOR_SCHEMES');
INSERT INTO dbnri(VTABLENAME) values('MRIDS');
INSERT INTO dbnri(VTABLENAME) values('MTXCONF');
INSERT INTO dbnri(VTABLENAME) values('MTXCONFDET');
INSERT INTO dbnri(VTABLENAME) values('OBJTYPEMEAS');
INSERT INTO dbnri(VTABLENAME) values('OPERATINGDAY');
INSERT INTO dbnri(VTABLENAME) values('OPERSCANSCHEMAS');
INSERT INTO dbnri(VTABLENAME) values('OSM_SWITCHINGS');
INSERT INTO dbnri(VTABLENAME) values('PARALLELCONNECTION');
INSERT INTO dbnri(VTABLENAME) values('PARAMETER');
INSERT INTO dbnri(VTABLENAME) values('POINTFORMULA');
INSERT INTO dbnri(VTABLENAME) values('POINTFULLHOURS');
INSERT INTO dbnri(VTABLENAME) values('POINTS');
INSERT INTO dbnri(VTABLENAME) values('POINTSPARAM');
INSERT INTO dbnri(VTABLENAME) values('PRIORITY');
INSERT INTO dbnri(VTABLENAME) values('PROCEDURES');
INSERT INTO dbnri(VTABLENAME) values('PROTOCOLS');
INSERT INTO dbnri(VTABLENAME) values('RATES');
INSERT INTO dbnri(VTABLENAME) values('RATE_LIST');
INSERT INTO dbnri(VTABLENAME) values('REALPOINT');
INSERT INTO dbnri(VTABLENAME) values('RECOMPENS');
INSERT INTO dbnri(VTABLENAME) values('RELATEDPARAM');
INSERT INTO dbnri(VTABLENAME) values('REPORTGROUPS');
INSERT INTO dbnri(VTABLENAME) values('REPORTS');
INSERT INTO dbnri(VTABLENAME) values('ROLES');
INSERT INTO dbnri(VTABLENAME) values('ROLE_GROUPS');
INSERT INTO dbnri(VTABLENAME) values('ROLE_TASK');
INSERT INTO dbnri(VTABLENAME) values('SCHEDULELIST');
INSERT INTO dbnri(VTABLENAME) values('SCHEMCHANNELS');
INSERT INTO dbnri(VTABLENAME) values('SHAREDCONNECTIONPARAM');
INSERT INTO dbnri(VTABLENAME) values('SOURCETYPES');
INSERT INTO dbnri(VTABLENAME) values('SRV');
INSERT INTO dbnri(VTABLENAME) values('SWITCHES');
INSERT INTO dbnri(VTABLENAME) values('SWITCHESSRV');
INSERT INTO dbnri(VTABLENAME) values('TARIFF');
INSERT INTO dbnri(VTABLENAME) values('TARIFFTYPE');
INSERT INTO dbnri(VTABLENAME) values('TASKS');
INSERT INTO dbnri(VTABLENAME) values('TCCONDITIONS');
INSERT INTO dbnri(VTABLENAME) values('TCPARAMS');
INSERT INTO dbnri(VTABLENAME) values('TCSIGNALS');
INSERT INTO dbnri(VTABLENAME) values('TIMETYPES');
INSERT INTO dbnri(VTABLENAME) values('TIMEZONES');
INSERT INTO dbnri(VTABLENAME) values('TRANSFORMER');
INSERT INTO dbnri(VTABLENAME) values('TRANSFORMERHISTORY');
INSERT INTO dbnri(VTABLENAME) values('USEDCONSUMPT');
INSERT INTO dbnri(VTABLENAME) values('USERFORUM');
INSERT INTO dbnri(VTABLENAME) values('USERPASS');
INSERT INTO dbnri(VTABLENAME) values('USERS');
commit;
end;
/


--14/01/2013

declare
ln_customer_id NUMBER;
begin
SELECT NVL(SUM(DECODE(vvalue, '', 0, vvalue)), 0)   INTO ln_customer_id   FROM parameter  WHERE npid = 12;
 if ln_customer_id <> 39 then
  for lc1 in (select mid,MAX(vvalue)vvalue from addpointparamval where nsort in (-26,-25) and vvalue is not null group by mid)loop
   update addpointparamval set vvalue=lc1.vvalue where mid=lc1.mid and nsort=-25;
  end loop;

  for lc in (select mid, MAX(vvalue)vvalue from addpointparamval where nsort in (-30,-29,-28,-27) and vvalue is not null group by mid)loop
   update addpointparamval set vvalue=lc.vvalue where mid=lc.mid and nsort=-26;
  end loop;
end if;
 
 update addpointparam set VDESCR='М30817. Править ГН кВтч, если не пусто и разница меньше чем:' where nsort=-25;  
	update addpointparam set VDESCR='М30817. Править ГН кВАрч, если не пусто и разница меньше чем:' where nsort=-26;  
	update addpointparam set VDESCR='М30817. Кол-во разрядов дробной части при корректировке:' where nsort=-27;  
	update addpointparam set VDESCR='М30817. Если не пусто - не округлять до целого:' where nsort=-28;  
	delete addpointparam where nsort=-29;  
	delete addpointparam where nsort=-30;
 
end;
/



----------------------------------------------------------------------------------------------
-- 13/02/2013     VER 3.3.5 (Для обновления версии 3.3.4 до текущей скрипт запускать отсюда)      
----------------------------------------------------------------------------------------------
/*==============================================================*/
/* Table: CHANINTERVAL                                          */
/*==============================================================*/
create table CHANINTERVAL  (
   CID                  NUMBER(10)                      not null,
   DSTART               DATE                            not null,
   DEND                 DATE                            not null,
   constraint PK_CHANINTERVAL primary key (CID, DSTART)
);

comment on table CHANINTERVAL is
'Интервалы работы канала';

comment on column CHANINTERVAL.CID is
'Ид канала';

comment on column CHANINTERVAL.DSTART is
'Начало опроса';

comment on column CHANINTERVAL.DEND is
'Окончание';

alter table CHANINTERVAL
   add constraint CHANINTERVAL_F1 foreign key (CID)
      references CHANNELS (CID)
      on delete cascade;

-- 27/02/2013     

/*==============================================================*/
/* Table: CHANINTERVAL                                          */
/*==============================================================*/
alter table CHANINTERVAL  add(
   NNETPARAM            NUMBER(1)                      default 0 not null
      constraint CKC_NNETPARAM_CHANINTE check (NNETPARAM in (0,1)),
   NJOURNAL             NUMBER(1)                      default 0 not null
      constraint CKC_NJOURNAL_CHANINTE check (NJOURNAL in (0,1)),
   NNOTREADCURR         NUMBER(1)                      default 0 not null
      constraint CKC_NNOTREADCURR_CHANINTE check (NNOTREADCURR in (0,1))
);

comment on column CHANINTERVAL.NNETPARAM is
'Параметры сети';

comment on column CHANINTERVAL.NJOURNAL is
'Журнал событий';

comment on column CHANINTERVAL.NNOTREADCURR is
'Не читать тек сутки';



begin
insert into parameter (NPID,VVALUE,VDESCRIPTION) values(60,0,'Блокировка переноса остатков округлений в Round30817 на следующие сутки.');
commit;
exception when others then rollback;
end;
/


--28/02/2013

create or replace 
 FUNCTION tmp_substr_cnt(av_str VARCHAR2, av_substr VARCHAR2)
  RETURN NUMBER IS
  ln_tmp              NUMBER := INSTR(av_str, av_substr);
 BEGIN
  IF ln_tmp > 0 THEN
   RETURN 1 + tmp_substr_cnt(SUBSTR(av_str, ln_tmp + LENGTH(av_substr)), av_substr);
  ELSE
   RETURN 0;
  END IF;
 END;
/

begin
for lc in (
 SELECT   f.nid, COUNT(p.nid) cn
                       FROM     pointformula f, formulparams p
                WHERE f.nmeas = 0 AND p.nid = f.nid 
                and substr(UPPER(TRIM(p.vparam)),1,4)='GID.' 
  AND INSTR(f.vformula, '*') + INSTR(f.vformula, '/') + INSTR(f.vformula, '(') + INSTR(f.vformula, ')') 
  + tmp_substr_cnt(f.vformula, '+') + tmp_substr_cnt(f.vformula, '-')  = 0
             GROUP BY f.nid) loop             
             if (lc.cn=1) then
                 UPDATE pointformula
                SET nopttype = 6
                 WHERE nid = lc.nid;
             end if;
             end loop;
    commit;
end;
/

drop FUNCTION tmp_substr_cnt;


--12/03/2013
INSERT INTO protocols(protocol_id, name, dll_name, ncode) VALUES (124,'EMH LZQJ +Эхо',NULL,12);
commit;


--14/03/2013
INSERT INTO protocols(protocol_id, name, dll_name, ncode) VALUES (125,'ACE6000 (dlms) +Эхо',NULL,0);
commit;

----------------------------------------------------------------------------------------------
-- 14/03/2013     VER 3.4 (Для обновления версии 3.3.5 до текущей скрипт запускать отсюда)      
----------------------------------------------------------------------------------------------
alter table TRAFFIC  add(
   VINITSTR             VARCHAR2(256)
);

comment on column TRAFFIC.VINITSTR is
'Порт и строка инициализации';



---------------------------------------------------------------
--        26/03/2013   Новая схема администрирования
---------------------------------------------------------------
begin
insert into parameter (NPID,VVALUE,VDESCRIPTION) values(61,0,'Использование администрирования с горизонтальным разделением прав.');
commit;
exception when others then rollback;
end;
/

--drop table ROLEGROUP;
--drop table ROLEPOINT

/*==============================================================*/
/* Table: ROLEPOINT                                             */
/*==============================================================*/
create table ROLEPOINT  (
   ROLE_ID              NUMBER                          not null,
   MID                  NUMBER                          not null,
   NACC                 NUMBER(10)                     default 0 not null,
   constraint PK_ROLEPOINT primary key (ROLE_ID, MID)
);

comment on table ROLEPOINT is
'Права роли на точки';

comment on column ROLEPOINT.ROLE_ID is
'Ид роли';

comment on column ROLEPOINT.MID is
'Ид точки';

comment on column ROLEPOINT.NACC is
'Права (битовая маска 0 чтение 1 р в 2 редакт 3 редакт и рв )';

/*==============================================================*/
/* Index: ROLEPOINT_IDX1                                        */
/*==============================================================*/
create index ROLEPOINT_IDX1 on ROLEPOINT (
   MID ASC
);

alter table ROLEPOINT
   add constraint ROLEPOINT_F1 foreign key (ROLE_ID)
      references ROLES (ROLE_ID)
      on delete cascade;

alter table ROLEPOINT
   add constraint ROLEPOINT_F2 foreign key (MID)
      references POINTS (MID)
      on delete cascade;

/*==============================================================*/
/* Table: ROLEGROUP                                             */
/*==============================================================*/
create table ROLEGROUP  (
   ROLE_ID              NUMBER                          not null,
   GID                  NUMBER                          not null,
   NACC                 NUMBER(10)                     default 0 not null,
   constraint PK_ROLEGROUP primary key (ROLE_ID, GID)
);

comment on table ROLEGROUP is
'Права роли на группы';

comment on column ROLEGROUP.ROLE_ID is
'Ид роли';

comment on column ROLEGROUP.GID is
'Ид группы';

comment on column ROLEGROUP.NACC is
'Права (битовая маска 0 чтение 1 р в 2 редакт 3 редакт и рв )';

/*==============================================================*/
/* Index: ROLEGROUP_IDX1                                        */
/*==============================================================*/
create index ROLEGROUP_IDX1 on ROLEGROUP (
   GID ASC
);

alter table ROLEGROUP
   add constraint ROLEGROUP_F1 foreign key (ROLE_ID)
      references ROLES (ROLE_ID)
      on delete cascade;

alter table ROLEGROUP
   add constraint ROLEGROUP_F2 foreign key (GID)
      references GROUPS (GID)
      on delete cascade;

----------------  29/03/2013
drop package TRANSFORMER_PG;
drop package EDITTRANSFORMER_PG;


--        05/04/2013   
insert into COMMONPROTOCOLS values(43,'НИК КС-02');
INSERT INTO protocols(PROTOCOL_ID,NAME,DLL_NAME,NCODE) VALUES (126,'НИК КС-02',NULL,43);
commit;


--16/04/2013   
insert into metertype(nmetertype,vname) values(36,'НИК КС-02') ;
commit;


----17/04/2013
begin
--Флаги состояний
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	711	,	0	,'Есть фазное напряжение L1',35,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	712	,	1	,'Есть фазное напряжение L2',35,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	713	,	2	,'Есть фазное напряжение L3',35,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	714	,	3	,'Влияние магнитным полем',35,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	715	,	4	,'Неблагоприятная температура',35,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	716	,	5	,'Связь блокирована (четыре неверных пароля)',35,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	717	,	6	,'Разрешена заводская параметризация (нажата кнопка)',35,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	718	,	7	,'Обратная последовательность фаз',35,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	719	,	8	,'Отказ часов',35,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	720	,	9	,'Проблемы «железа» («fatal  error»)',35,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	722	,	10	,'Состояние реле 1',35,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	723	,	11	,'Состояние реле 2',35,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	724	,	12	,'Превышение заявленной мощности',35,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	725	,	13	,'Не использован',35,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	726	,	14	,'Низкое напряжение батареи',35,1,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	727	,	15	,'Летнее время',35,1,0,0);
--Флаги событий
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	728	,	0	,'Открытия корпуса',35,2,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	729	,	1	,'Старое время перед  установкой  или коррекции часов',35,2,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	730	,	2	,'Установка часов (новое время)',35,2,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	731	,	3	,'Кумуляция + обнуление',35,2,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	732	,	4	,'Параметризация из сети',35,2,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	733	,	5	,'Локальная параметризация',35,2,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	734	,	6	,'Обнуление суточных максимальных мощностей',35,2,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	735	,	7	,'Обнуление месячных максимальных мощностей',35,2,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	736	,	8	,'Обнуление суточной энергии',35,2,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	737	,	9	,'Обнуление месячной энергии',35,2,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	738	,	10	,'Коррекция часов на несколько секунд вперёд',35,2,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	739	,	11	,'Ошибка без «reset» программы',35,2,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	740	,	12	,'Ошибочная ситуация требующая «reset» программы',35,2,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	741	,	13	,'«Watchdog reset»',35,2,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	742	,	14	,'«Illegal operation»',35,2,0,0);
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	743	,	15	,'Коррекция часов на несколько секунд назад',35,2,0,0);
--От нас добавка (Изменение состояния)
INSERT INTO metereventsdict(nevent, neventcode,veventtext, nmetertype, neventclass, nlock, nvalidity) VALUES(	744	,	0	,'Изменение состояния',35,0,0,0);
commit;
end;
/

--22/04/2013
INSERT INTO protocols(PROTOCOL_ID,NAME,DLL_NAME,NCODE) VALUES (1012,'НИК КС-02(dll)','NIKRouter.dll',43);
commit;


--17/05/2013   
insert into metertype(nmetertype,vname) values(37,'Induc through MTX master') ;
commit;

--28/05/2013
declare
ln_1 NUMBER;
ln_2 NUMBER;
begin
update BASEFORMULA set VNAME='Округление ГН (тыс. кВт*ч) с переносом остатков (в течение месяца)' where  VFORMULA='round30817(a,1)';
update BASEFORMULA set VNAME='Округление ГН (кВт*ч) с переносом остатков (в течение месяца)' where  VFORMULA='round30817(a,3)';

select max(nid) into ln_1 from BASEFORMULA where vname='Базовые функции';
if ln_1 is null then 
return;
end if;
select points_seq.NEXTVAL into ln_2 from dual;
INSERT INTO BASEFORMULA("NID","NPARENT","NTYPE","VNAME","VFORMULA","VMEMO")VALUES(ln_2,ln_1,1,'Округление ГН (тыс. кВт*ч) с переносом остатков (в течение суток)','round30817(a,5)',NULL);
select points_seq.NEXTVAL into ln_2 from dual;
INSERT INTO BASEFORMULA("NID","NPARENT","NTYPE","VNAME","VFORMULA","VMEMO")VALUES(ln_2,ln_1,1,'Округление ГН (кВт*ч) с переносом остатков (в течение суток)','round30817(a,6)',NULL);
commit;
exception
when others then rollback;
end;
/

delete from BASEFORMULA where  VFORMULA='round30817(a,2)';
update BASEFORMULA set VNAME='Приведение ГН к разнице показаний' where  VFORMULA='round30817(a,4)';
commit;

UPDATE POINTFORMULA SET NOPTTYPE=5 WHERE NOPTTYPE=3;
COMMIT;


-- 26/07/2013     
/*
--Только в Интэп для разработки ПО
begin
insert into COMMONPROTOCOLS values(44,'Интэп Тест');
INSERT INTO protocols(protocol_id, name, dll_name, ncode) VALUES (127,'Интэп Тест',NULL,44);
commit;
end;
/
*/



----------------------------------------------------------------------------------------------
-- 14/07/2013     VER 3.4.1 (Для обновления версии 3.4.0.2 до текущей скрипт запускать отсюда)      
----------------------------------------------------------------------------------------------
CREATE OR REPLACE type datarray as table of date
/



-- 01/08/2013

begin
insert into ADDFORMPARAM(NSORT,VDESCR,NTYPE) values(-12,'Отобрашать наименование родителя уровня 1 под',0);
insert into ADDFORMPARAM(NSORT,VDESCR,NTYPE) values(-13,'Отобрашать наименование родителя уровня 2 под',0);
commit;
end;
/




/*
--Только для ООЭ и прочих платежеспособных
begin 
INSERT INTO tasks ("TASK_ID","PARENT","TASK_COD","NAME","REMARK","NSHOW") VALUES(108,42,664,'1.9 Ввод стартовых показаний счетчика',NULL,1); 
insert into role_task select 1,108,1 from dual;
commit; 
end;
/
*/





----------------------------------------------------------------------------------------------
-- 02/09/2013     VER 3.4.3.0 (Для обновления версии 3.4.2.1 до текущей скрипт запускать отсюда)      
----------------------------------------------------------------------------------------------
/*==============================================================*/
/* Table: NIKRTCONF                                             */
/*==============================================================*/
create table NIKRTCONF  (
   CID                  NUMBER(10)                      not null,
   NID                  NUMBER(10)                      not null,
   NMODEL               NUMBER(10),
   NADDRH               NUMBER(10),
   NADDRL               NUMBER(10),
   NSERIAL              NUMBER(10),
   NCID                 NUMBER(10),
   DENERGY              DATE,
   DSTATE               DATE,
   NSTATE               NUMBER(10),
   constraint PK_NIKRTCONF primary key (CID, NID)
);

comment on table NIKRTCONF is
'Конфигурация маршрутизаторов NIK';

comment on column NIKRTCONF.CID is
'Ид канала';

comment on column NIKRTCONF.NID is
'Ид счетчика в маршрутизаторе';

comment on column NIKRTCONF.NMODEL is
'Ид модели';

comment on column NIKRTCONF.NADDRH is
'АдресHi';

comment on column NIKRTCONF.NADDRL is
'АдресLo';

comment on column NIKRTCONF.NSERIAL is
'Номер счетчика';

comment on column NIKRTCONF.NCID is
'Ид канала в маршрутизаторе';

comment on column NIKRTCONF.DENERGY is
'Дата данных в маршрутизаторе';

comment on column NIKRTCONF.DSTATE is
'Дата состояния';

comment on column NIKRTCONF.NSTATE is
'Состояние';

alter table NIKRTCONF
   add constraint NIKRTCONF_F1 foreign key (CID)
      references CHANNELS (CID)
      on delete cascade;

---05/09/2013
alter table NIKRTCONF  add(
   NOFF                 NUMBER(1)                      default 0 not null
      constraint CKC_NOFF_NIKRTCON check (NOFF in (0,1))
);

comment on column NIKRTCONF.NOFF is
'Отключен';

----------------------------------------------------------------------------------------------
-- 02/09/2013
----------------------------------------------------------------------------------------------
insert into COMMONPROTOCOLS values(45,'Indigo+');
commit;
	
INSERT INTO protocols VALUES (128,'Indigo+',NULL,45);
commit;

----------------------------------------------------------------------------------------------
-- 25/09/2013
----------------------------------------------------------------------------------------------
alter table FEEDERS  add(
   VACCOUNT             VARCHAR2(32)
);


comment on column FEEDERS.VACCOUNT is
'Лицевой счет';


/*==============================================================*/
/* Index: FEEDERS_IDX9                                          */
/*==============================================================*/
create index FEEDERS_IDX9 on FEEDERS (
   VACCOUNT ASC
);


----------------------------------------------------------------------------------------------
-- 27/09/2013
----------------------------------------------------------------------------------------------
insert into COMMONPROTOCOLS values(46,'TeleTec HTTP');
commit;
	
INSERT INTO protocols VALUES (1013,'TeleTec HTTP',NULL,46);
commit;

insert into metertype(nmetertype,vname) values(38,'TeleTec DB uses of HTTP') ;
commit;

----------------------------------------------------------------------------------------------
-- 02/10/2013
----------------------------------------------------------------------------------------------
INSERT INTO deportprocedures("NPROCEDURE","VNAME","VPROCEDURE","NPERIOD","NTYPE","VMEMO") VALUES(77,'Перерасчет данных по группе точек за период','ryda.BACKGROUND01_PG.recalcpoints',2,1,'Перерасчет данных по группе точек за период');
commit;


----------------------------------------------------------------------------------------------
-- 03/10/2013     VER 3.4.3.1 (Для обновления версии 3.4.3.0 до текущей скрипт запускать отсюда)      
----------------------------------------------------------------------------------------------
update protocols set DLL_NAME='TeletecHTTP.dll' where protocol_id=1013;
commit;



----------------------------------------------------------------------------------------------
-- 09/10/2013
----------------------------------------------------------------------------------------------
declare
a NUMBER;
ln_customer_id NUMBER;
begin
SELECT NVL(SUM(DECODE(vvalue, '', 0, vvalue)), 0)   INTO ln_customer_id   FROM parameter  WHERE npid = 12;
 if ln_customer_id in (0,7) then --ОДЕССА ОЭ
		INSERT INTO deportprocedures("NPROCEDURE","VNAME","VPROCEDURE","NPERIOD","NTYPE","VMEMO") VALUES(78,'Выгрузка суточных показаний в расчетную систему','ryda.reports1_pg.export_to_billing',2,0,'Выгрузка суточных показаний в расчетную систему');
		commit;
	END IF;	
end;
/



----------------------------------------------------------------------------------------------
-- 22/10/2013     VER 3.5.0.1 (Для обновления версии 3.4.3.1 до текущей скрипт запускать отсюда)      
----------------------------------------------------------------------------------------------

/*
--Только с разрешения Интэп

--drop table ROLEGROUP;
--drop table ROLEPOINT

begin
update parameter set vvalue=1 where npid=61;
insert into rolepoint(role_id,mid,nacc)
select r.role_id,p.mid,255 from roles r,points p where p.parent is null;
insert into rolegroup(role_id,gid,nacc)
select r.role_id,p.gid,255 from roles r,groups p where p.parent is null;
commit;
exception when others then rollback; raise;
end;
/

*/


----------------------------------------------------------------------------------------------
-- 15/11/2013
----------------------------------------------------------------------------------------------

begin
update ADDFORMPARAM set VDESCR='Отображать наименование родителя уровня 1 под' where NSORT=-12;
update ADDFORMPARAM set VDESCR='Отображать наименование родителя уровня 2 под' where NSORT=-13;
insert into ADDFORMPARAM(NSORT,VDESCR,NTYPE) values(-14,'Отображение доп. параметров окна диалога',0);
update ADDFORMPARAM set VDESCR='Отображение доп. параметров окна диалога' where NSORT=-14;
commit;
end;
/


----------------------------------------------------------------------------------------------
-- 22/11/2013
----------------------------------------------------------------------------------------------


/*==============================================================*/
/* Table: SRVINI                                                */
/*==============================================================*/
create table SRVINI  (
   NSRV                 NUMBER(10)                      not null,
   NORDER               NUMBER(10)                      not null,
   VTEXT                VARCHAR2(2000),
   constraint PK_SRVINI primary key (NSRV, NORDER)
);

comment on table SRVINI is
'INI файл ССД';

comment on column SRVINI.NSRV is
'Ид ССД';

comment on column SRVINI.NORDER is
'Номер строки';

comment on column SRVINI.VTEXT is
'Строка';

alter table SRVINI
   add constraint SRVINI_F1 foreign key (NSRV)
      references SRV (NSRV)
      on delete cascade;

/*==============================================================*/
/* Table: SRVLOG                                                */
/*==============================================================*/
create table SRVLOG  (
   NSRV                 NUMBER(10)                      not null,
   NORDER               NUMBER(10)                      not null,
   VTEXT                VARCHAR2(2000),
   constraint PK_SRVLOG primary key (NSRV, NORDER)
);

comment on table SRVLOG is
'INI файл ССД2';

comment on column SRVLOG.NSRV is
'Ид ССД';

comment on column SRVLOG.NORDER is
'Номер строки';

comment on column SRVLOG.VTEXT is
'Строка';

alter table SRVLOG
   add constraint SRVLOG_F1 foreign key (NSRV)
      references SRV (NSRV)
      on delete cascade;


----Структура для хранения информации по отключению

alter table CURR_POWER_ARCH  add(
   NOFF                 NUMBER(1),
   DOFF                 DATE,
   NSTATUS              NUMBER
);

comment on column CURR_POWER_ARCH.NOFF is
'Признак отключения';

comment on column CURR_POWER_ARCH.DOFF is
'Дата изменения состояния отключения';

comment on column CURR_POWER_ARCH.NSTATUS is
'Статусный байт счетчика';



alter table CURR_POWER  add(
   NOFF                 NUMBER(1),
   DOFF                 DATE,
   NSTATUS              NUMBER
);

comment on column CURR_POWER.NOFF is
'Признак отключения';

comment on column CURR_POWER.DOFF is
'Дата изменения состояния отключения';

comment on column CURR_POWER.NSTATUS is
'Статусный байт счетчика';


--alter table LAST_SAVE  drop column DEXECMDOFF;
--alter table LAST_SAVE  drop column NCMDOFF;
--alter table LAST_SAVE  drop column DCMDOFF;

alter table LAST_SAVE  add(
   DCMDOFF              DATE,
   NCMDOFF              NUMBER(1)                      default 0 not null
      constraint CKC_NCMDOFF_LAST_SAV check (NCMDOFF in (0,1,2)),
   DEXECMDOFF           DATE
);


comment on column LAST_SAVE.PROFILE is
'Профиль';

comment on column LAST_SAVE.HALFHOUR is
'График';

comment on column LAST_SAVE.BILL is
'Сутки';

comment on column LAST_SAVE.RATE is
'Тарифы';

comment on column LAST_SAVE.CLOCK is
'Расхождение t';

comment on column LAST_SAVE.STATE_DATE is
'Дата состояния';

comment on column LAST_SAVE.STATE_COD is
'Код состояние';

comment on column LAST_SAVE.STATE_DESCR is
'Описание состояния';

comment on column LAST_SAVE.LUCK is
'Последняя удача';

comment on column LAST_SAVE.RATES is
'Тариф';

comment on column LAST_SAVE.MONTHS is
'Месячные';

comment on column LAST_SAVE.TRIAL is
'Попытка';

comment on column LAST_SAVE.FAIL is
'Последняя неудача';


begin
insert into parameter (NPID,VVALUE,VDESCRIPTION) values(62,5000,'Максимальная глубина хранения файла журнала опросчика.');
commit;
exception when others then rollback;
end;
/




alter table  CURR_POWER  add (
   NTEMP                NUMBER
);

alter table CURR_POWER_ARCH  add (
   NTEMP                NUMBER
);


----25/11/2013
INSERT INTO tasks
(TASK_ID,PARENT,TASK_COD,NAME,REMARK,NSHOW)
VALUES
(109,80,665,'9.07 Отключение нагрузки на счетчике','9.07 Отключение нагрузки на счетчике',0)
/
commit;


--26/11/2013
alter table CURR_POWER  add(
constraint CKC_NOFF_CURR_POW check (NOFF is null or (NOFF in (0,1))));

alter table CURR_POWER_ARCH  add(
constraint CKC_NOFF_CURR_POW1 check (NOFF is null or (NOFF in (0,1))));


begin
insert into role_task select distinct ROLE_ID,109,1 from users where ADMIN='*';
commit;
end;
/


--27/11/2013
CREATE OR REPLACE TRIGGER curr_power_arch
 AFTER
   UPDATE OF ni0
 ON curr_power
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
BEGIN
 admin_pg.curr_power_arch_ins_p(
  :NEW.mid, :NEW.date_time, :NEW.er, :NEW.q1, :NEW.q2, :NEW.ed, :NEW.q3, :NEW.q4, :NEW.erm, :NEW.q1m, :NEW.q2m, :NEW.edm,
  :NEW.q3m, :NEW.q4m, :NEW.freq, :NEW.cosf, :NEW.volt, :NEW.currento, :NEW.volt2, :NEW.volt3, :NEW.curr2, :NEW.curr3,
  :NEW.nfiu1, :NEW.nfiu2, :NEW.nfiu3, :NEW.nfii1, :NEW.nfii2, :NEW.nfii3,:NEW.NI0,:NEW.NOFF,:NEW.DOFF,:NEW.NSTATUS,:NEW.NTEMP);
END;
/


-- End of DDL Script for Trigger RYDA.CURR_POWER_ARCH


--18/12/2013
	
INSERT INTO protocols VALUES (129,'LG_ZxB (MT-2.65)',NULL,7);
commit;

insert into metertype(nmetertype,vname) values(39,'Indigo') ;
commit;


-------23/01/2014
update feeders set nintegralperiod=30 where nintegralperiod<=0;
alter table feeders add constraint CKC_NINTEGRALPERIOD_FEEDERS check (NINTEGRALPERIOD>0);


--03/02/2014
INSERT INTO protocols VALUES (130,'TeleTec HTTP(v2)',NULL,46);
commit;





--------------12/02/2014
begin
insert into parameter (NPID,VVALUE,VDESCRIPTION) values(63,0,'Уровень строгости проверки синтаксиса входящих макетов [0..10] (0-полное, 1-допускается отклонение).');
commit;
exception when others then rollback;
end;
/



--25/02/2014
INSERT INTO protocols VALUES (131,'Управление портом',NULL,NULL);
commit;

--19/03/2014
drop INDEX halfhourold_idx4
/
drop INDEX billold_idx2
/

--25/04/2014
drop INDEX HALFHOUROLD_IDX3
/


---26.04.2014
alter table SRV  add(
   VVERSION             VARCHAR2(128)
);


comment on column SRV.VVERSION is
'Версия';

--27/04/2014
update db_term set INDEX_NAME='COMPORTEVENTS_IDX2' where TABLE_NAME='COMPORTEVENTS';
commit;

--28/04/2014
alter table COMPORTEVENTS drop constraint COMPORTEVENTS_PK;
drop index COMPORTEVENTS_PK;
drop index COMPORTEVENTS_IDX1;
alter table COMPORTEVENTS drop constraint COMPORTEVENTS_F1;


--08/05/2014

-- Start of DDL Script for Constraint RYDA.FK_MONITOR_MONITORS
-- Generated 08.05.2014 10:39:59 from RYDA@oe
ALTER TABLE monitors drop CONSTRAINT fk_monitor_monitors;

ALTER TABLE monitors
ADD CONSTRAINT fk_monitor_monitors FOREIGN KEY (mschema)
REFERENCES monitor_schemes (monitor) on delete cascade
/
-- End of DDL script for Foreign Key(s)
