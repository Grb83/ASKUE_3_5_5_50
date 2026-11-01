-------------------------- ПОСЛЕДОВАТЕЛЬНОСТИ ------------------------------------
CREATE SEQUENCE KNOT_SEQ MINVALUE 1 MAXVALUE 999999999999999999999999999
  INCREMENT BY 1 START WITH 1000 CACHE 20 NOORDER NOCYCLE;
CREATE SEQUENCE TASKS_SEQ MINVALUE 1 MAXVALUE 999999999999999999999999999
  INCREMENT BY 1 START WITH 1000 CACHE 20 NOORDER NOCYCLE;
CREATE SEQUENCE USERS_SEQ MINVALUE 1 MAXVALUE 999999999999999999999999999
  INCREMENT BY 1 START WITH 1000 CACHE 20 NOORDER NOCYCLE;
CREATE SEQUENCE BRANCH_SEQ MINVALUE 1 MAXVALUE 999999999999999999999999999
  INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER NOCYCLE;
CREATE SEQUENCE ROLES_SEQ MINVALUE 1 MAXVALUE 999999999999999999999999999
  INCREMENT BY 1 START WITH 1000 CACHE 20 NOORDER NOCYCLE;
CREATE SEQUENCE POINTS_SEQ MINVALUE 1 MAXVALUE 999999999999999999999999999
  INCREMENT BY 1 START WITH 1000 CACHE 20 NOORDER NOCYCLE;
CREATE SEQUENCE PIPE_TASKS_SEQ MINVALUE 1 MAXVALUE 999999999999999999999999999
  INCREMENT BY 1 START WITH 1000 CACHE 20 NOORDER NOCYCLE;
CREATE SEQUENCE LIMITS_SEQ MINVALUE 1 MAXVALUE 999999999999999999999999999
  INCREMENT BY 1 START WITH 1000 CACHE 20 NOORDER NOCYCLE;
CREATE SEQUENCE GROUPS_SEQ MINVALUE 1 MAXVALUE 999999999999999999999999999
  INCREMENT BY 1 START WITH 1000 CACHE 20 NOORDER NOCYCLE;
CREATE SEQUENCE FORMS_SEQ MINVALUE 1 MAXVALUE 999999999999999999999999999
  INCREMENT BY 1 START WITH 1000 CACHE 20 NOORDER NOCYCLE;
CREATE SEQUENCE EXPORT_SEQ MINVALUE 1 MAXVALUE 999999999999999999999999999
  INCREMENT BY 1 START WITH 1000 CACHE 20 NOORDER NOCYCLE;

CREATE SEQUENCE REPORT_S
 INCREMENT BY  1
 START WITH  1001
 CACHE 20
/

CREATE SEQUENCE DEPORTATION_SEQ
 INCREMENT BY  1
 START WITH  1001
/

CREATE SEQUENCE makets_seq MINVALUE 1 MAXVALUE 999999999999999999999999999
  INCREMENT BY 1 START WITH 1000 CACHE 20 NOORDER NOCYCLE
/

CREATE SEQUENCE maketgroups_seq MINVALUE 1 MAXVALUE 999999999999999999999999999
  INCREMENT BY 1 START WITH 1000 CACHE 20 NOORDER NOCYCLE
/

CREATE SEQUENCE comport_seq MINVALUE 1 MAXVALUE 999999999999999999999999999
  INCREMENT BY 1 START WITH 1000 CACHE 20 NOORDER NOCYCLE
/

CREATE SEQUENCE journal_seq MINVALUE 1 MAXVALUE 999999999999999999999999999
  INCREMENT BY 1 START WITH 1000 CACHE 20 NOORDER NOCYCLE
/
-------------------------- ТАБЛИЦЫ -----------------------------------------------
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


-- Start of DDL script for HALFHOUR
-- Generated 1-дек-02  2:56:32 pm
-- from oe-RYDA:11

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

-- End of DDL script for MONTHS


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

-------------------------- ПЕРВИЧНЫЕ И УНИКАЛЬНЫЕ --------------------------------

-------------------------- ИНДЕКСЫ -----------------------------------------------
-------------------------- ВТОРИЧНЫЕ ---------------------------------------------
-------------------------- КОММЕНТАРИИ ------------------------------------
-------------------------- РОЛИ ------------------------------------
-------------------------- ПРАВА ------------------------------------


