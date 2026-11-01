
-- Start of DDL script for BILLEVID
-- Generated 16-дек-02  10:17:08 am
-- from oe-RYDA:4

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

-- Start of DDL script for BILL_FOR_TERM
-- Generated 16-дек-02  10:17:09 am
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
   er_mtrsn )
AS
select
      date_time
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
        bill b, points p1, points p2, points p3, passive_dvs d
        ,
        feeders f
      where
        ( p2.mid = b.mid )
        and
        (
          --счётчик
          (
            ( p2.ind = 3 )
            and
            ( p2.parent = d.mid )
            and
            ( d.mid = p1.mid )
            and
            --фикт
            ( p3.mid = p2.mid )
            --e фикт
          )
          --e счётчик
          or
          --индукционник
          (
            --инд-ник
            ( p2.ind = 3 )
            --e инд-ник
            and
            --родитель - счетчик
            ( p2.parent = p3.mid )
            and
            ( p3.ind = 3 )
            --e родитель - счетчик
            and
            --группа учёта
            ( p3.parent = d.mid )
            and
            ( d.mid = p1.mid )
            --e группа учёта
          )
          --e индукционник
        )
        and
        ( f.mid=b.mid )
/

-- End of DDL script for BILL_FOR_TERM

-- Start of DDL script for HALFHOUR
-- Generated 16-дек-02  10:17:09 am
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
 FROM RYDA.HALFHOUROLD WHERE NEXCEPTCALC IS NULL
/

-- End of DDL script for HALFHOUR

-- Start of DDL script for HALFHOUREVID
-- Generated 16-дек-02  10:17:10 am
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
 FROM RYDA.HALFHOURTMP
/

-- End of DDL script for HALFHOUREVID

-- Start of DDL script for MONTHS
-- Generated 16-дек-02  10:17:10 am
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

-- Start of DDL script for MONTHSEVID
-- Generated 16-дек-02  10:17:10 am
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

-- Start of DDL script for MONTH_FOR_TERM
-- Generated 16-дек-02  10:17:10 am
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
   er_mtrsn )
AS
select
      date_time
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
        months b, points p1, points p2, points p3, passive_dvs d
        ,
        feeders f
      where
        ( p2.mid = b.mid )
        and
        (
          --счётчик
          (
            ( p2.ind = 3 )
            and
            ( p2.parent = d.mid )
            and
            ( d.mid = p1.mid )
            and
            --фикт
            ( p3.mid = p2.mid )
            --e фикт
          )
          --e счётчик
          or
          --индукционник
          (
            --инд-ник
            ( p2.ind = 3 )
            --e инд-ник
            and
            --родитель - счетчик
            ( p2.parent = p3.mid )
            and
            ( p3.ind = 3 )
            --e родитель - счетчик
            and
            --группа учёта
            ( p3.parent = d.mid )
            and
            ( d.mid = p1.mid )
            --e группа учёта
          )
          --e индукционник
        )
        and
        ( f.mid=b.mid )
/

-- End of DDL script for MONTH_FOR_TERM

-- Start of DDL script for PROFILEEVID
-- Generated 16-дек-02  10:17:11 am
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
