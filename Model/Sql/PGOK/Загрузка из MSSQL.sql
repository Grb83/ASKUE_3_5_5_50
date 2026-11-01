CREATE USER KONCENTRAT IDENTIFIED  BY KONCENTRAT DEFAULT TABLESPACE USERS TEMPORARY TABLESPACE TEMP PROFILE DEFAULT;
GRANT CREATE SESSION TO KONCENTRAT;
GRANT ALTER SESSION TO KONCENTRAT;


/*==============================================================*/
/* Table: RYDA_OF1                                              */
/*==============================================================*/
create table RYDA_OF1  (
   ORDERNO              NUMBER(10)                      not null,
   ORDERDATE            DATE,
   ORDERSM              NUMBER(6),
   NUMCHASSM            NUMBER(6),
   TEKCHASSM            NUMBER(6),
   M_1                  NUMBER,
   M_2                  NUMBER,
   M_3                  NUMBER,
   M_4                  NUMBER,
   M_5                  NUMBER,
   M_6                  NUMBER,
   M_7                  NUMBER,
   M_8                  NUMBER,
   DP_WATER             NUMBER,
   constraint PK_RYDA_OF1 primary key (ORDERNO)
);

comment on table RYDA_OF1 is
'RYDA_OF1_ПГОК';

comment on column RYDA_OF1.ORDERNO is
'Порядковый номер записи';

comment on column RYDA_OF1.ORDERDATE is
'Дата записи';

comment on column RYDA_OF1.ORDERSM is
'Номер смены';

comment on column RYDA_OF1.NUMCHASSM is
'Номер часа в смене';

comment on column RYDA_OF1.TEKCHASSM is
'Час записи';

comment on column RYDA_OF1.M_1 is
'Секкция 1';

comment on column RYDA_OF1.M_2 is
'Секкция 2';

comment on column RYDA_OF1.M_3 is
'Секкция 3';

comment on column RYDA_OF1.M_4 is
'Секкция 4';

comment on column RYDA_OF1.M_5 is
'Секкция 5';

comment on column RYDA_OF1.M_6 is
'Секкция 6';

comment on column RYDA_OF1.M_7 is
'Секкция 7';

comment on column RYDA_OF1.M_8 is
'Секкция 8';

comment on column RYDA_OF1.DP_WATER is
'Вода';

/*==============================================================*/
/* Index: RYDA_OF1_IDX1                                         */
/*==============================================================*/
create index RYDA_OF1_IDX1 on RYDA_OF1 (
   ORDERDATE ASC
);

/*==============================================================*/
/* Table: RYDA_OF2                                              */
/*==============================================================*/
create table RYDA_OF2  (
   ORDERNO              NUMBER(10)                      not null,
   ORDERDATE            DATE,
   ORDERSM              NUMBER(6),
   NUMCHASSM            NUMBER(6),
   TEKCHASSM            NUMBER(6),
   M_10                 NUMBER,
   M_11                 NUMBER,
   M_12                 NUMBER,
   M_13                 NUMBER,
   M_14                 NUMBER,
   M_15                 NUMBER,
   DP_WATER             NUMBER,
   constraint PK_RYDA_OF2 primary key (ORDERNO)
);

comment on table RYDA_OF2 is
'RYDA_OF2_ПГОК';

comment on column RYDA_OF2.ORDERNO is
'Порядковый номер записи';

comment on column RYDA_OF2.ORDERDATE is
'Дата записи';

comment on column RYDA_OF2.ORDERSM is
'Номер смены';

comment on column RYDA_OF2.NUMCHASSM is
'Номер часа в смене';

comment on column RYDA_OF2.TEKCHASSM is
'Час записи';

comment on column RYDA_OF2.M_10 is
'Секкция 10';

comment on column RYDA_OF2.M_11 is
'Секкция 11';

comment on column RYDA_OF2.M_12 is
'Секкция 12';

comment on column RYDA_OF2.M_13 is
'Секкция 13';

comment on column RYDA_OF2.M_14 is
'Секкция 14';

comment on column RYDA_OF2.M_15 is
'Секкция 15';

comment on column RYDA_OF2.DP_WATER is
'Вода';

/*==============================================================*/
/* Index: RYDA_OF2_IDX1                                         */
/*==============================================================*/
create index RYDA_OF2_IDX1 on RYDA_OF2 (
   ORDERDATE ASC
);

grant select,insert,update,delete on RYDA_OF1 to KONCENTRAT;
grant select,insert,update,delete on RYDA_OF2 to KONCENTRAT;
