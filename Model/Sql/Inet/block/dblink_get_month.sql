DECLARE
 cn_mt_erm   CONSTANT NUMBER DEFAULT -1;
 cn_mt_edm   CONSTANT NUMBER DEFAULT -1;
 cn_mt_eq1m  CONSTANT NUMBER DEFAULT -1;
 cn_mt_eq2m  CONSTANT NUMBER DEFAULT -1;
 cn_mt_eq3m  CONSTANT NUMBER DEFAULT -1;
 cn_mt_eq4m  CONSTANT NUMBER DEFAULT -1;
 cn_mt_er    CONSTANT NUMBER DEFAULT 49;
 cn_mt_ed    CONSTANT NUMBER DEFAULT 61;
 cn_mt_eq1   CONSTANT NUMBER DEFAULT 57;
 cn_mt_eq2   CONSTANT NUMBER DEFAULT 58;
 cn_mt_eq3   CONSTANT NUMBER DEFAULT 59;
 cn_mt_eq4   CONSTANT NUMBER DEFAULT 60;
 cn_mt_freq  CONSTANT NUMBER DEFAULT 52;
 cn_mt_cosf  CONSTANT NUMBER DEFAULT 53;
 cn_mt_volt1 CONSTANT NUMBER DEFAULT 1;
 cn_mt_volt2 CONSTANT NUMBER DEFAULT 13;
 cn_mt_volt3 CONSTANT NUMBER DEFAULT 25;
 cn_mt_curr1 CONSTANT NUMBER DEFAULT 5;
 cn_mt_curr2 CONSTANT NUMBER DEFAULT 17;
 cn_mt_curr3 CONSTANT NUMBER DEFAULT 29;
 cn_mt_nfiu1 CONSTANT NUMBER DEFAULT 54;
 cn_mt_nfiu2 CONSTANT NUMBER DEFAULT 55;
 cn_mt_nfiu3 CONSTANT NUMBER DEFAULT 56;
 cn_mt_nfii1 CONSTANT NUMBER DEFAULT 7;
 cn_mt_nfii2 CONSTANT NUMBER DEFAULT 19;
 cn_mt_nfii3 CONSTANT NUMBER DEFAULT 31;
 ------------------------------------------------------------------------------------------------------------------------
 cn_vt_er    CONSTANT NUMBER DEFAULT 1;
 cn_vt_ed    CONSTANT NUMBER DEFAULT 2;
 cn_vt_q1    CONSTANT NUMBER DEFAULT 3;
 cn_vt_q3    CONSTANT NUMBER DEFAULT 4;
 cn_vt_q2    CONSTANT NUMBER DEFAULT -1;
 cn_vt_q4    CONSTANT NUMBER DEFAULT -1;
 ------------------------------------------------------------------------------------------------------------------------
 cn_tz_s     CONSTANT NUMBER DEFAULT 0;
 cn_tz_a     CONSTANT NUMBER DEFAULT 1;
 cn_tz_b     CONSTANT NUMBER DEFAULT 2;
 cn_tz_c     CONSTANT NUMBER DEFAULT 3;
 cn_tz_d     CONSTANT NUMBER DEFAULT 4;
 ------------------------------------------------------------------------------------------------------------------------
  i       NUMBER DEFAULT 1;
  ln_null NUMBER;
 BEGIN
  FOR lc IN (SELECT   TO_CHAR(t.ts, 'dd.mm.yyyy hh24:mi') cdt, SUM(t.er) er, SUM(t.ed) ed, SUM(t.q1) q1, SUM(t.q3) q3,
                      SUM(t.q2) q2, SUM(t.q4) q4, SUM(t.aer) aer, SUM(t.aed) aed, SUM(t.aq1) aq1, SUM(t.aq3) aq3,
                      SUM(t.aq2) aq2, SUM(t.aq4) aq4, SUM(t.ber) ber, SUM(t.bed) bed, SUM(t.bq1) bq1, SUM(t.bq3) bq3,
                      SUM(t.bq2) bq2, SUM(t.bq4) bq4, SUM(t.cer) cer, SUM(t.ced) ced, SUM(t.cq1) cq1, SUM(t.cq3) cq3,
                      SUM(t.cq2) cq2, SUM(t.cq4) cq4, SUM(t.der) der, SUM(t.ded) ded, SUM(t.dq1) dq1, SUM(t.dq3) dq3,
                      SUM(t.dq2) dq2, SUM(t.dq4) dq4, SUM(t.erm) erm, SUM(t.edm) edm, SUM(t.q1m) q1m, SUM(t.q3m) q3m,
                      SUM(t.q2m) q2m, SUM(t.q4m) q4m, SUM(t.aerm) aerm, SUM(t.aedm) aedm, SUM(t.aq1m) aq1m, SUM(t.aq3m)
                        aq3m,
                      SUM(t.aq2m) aq2m, SUM(t.aq4m) aq4m, SUM(t.berm) berm, SUM(t.bedm) bedm, SUM(t.bq1m) bq1m,
                      SUM(t.bq3m) bq3m, SUM(t.bq2m) bq2m, SUM(t.bq4m) bq4m, SUM(t.cerm) cerm, SUM(t.cedm) cedm,
                      SUM(t.cq1m) cq1m, SUM(t.cq3m) cq3m, SUM(t.cq2m) cq2m, SUM(t.cq4m) cq4m, SUM(t.derm) derm,
                      SUM(t.dedm) dedm, SUM(t.dq1m) dq1m, SUM(t.dq3m) dq3m, SUM(t.dq2m) dq2m, SUM(t.dq4m) dq4m, 0
                        status
                 FROM (SELECT ADD_MONTHS(s.ts, 1) ts, DECODE(s.tz, cn_tz_s, DECODE(p.valtype_id, cn_vt_er, s.cval)) er,
                              DECODE(s.tz, cn_tz_s, DECODE(p.valtype_id, cn_vt_ed, s.cval)) ed,
                              DECODE(s.tz, cn_tz_s, DECODE(p.valtype_id, cn_vt_q1, s.cval)) q1,
                              DECODE(s.tz, cn_tz_s, DECODE(p.valtype_id, cn_vt_q3, s.cval)) q3,
                              DECODE(s.tz, cn_tz_s, DECODE(p.valtype_id, cn_vt_q2, s.cval)) q2,
                              DECODE(s.tz, cn_tz_s, DECODE(p.valtype_id, cn_vt_q4, s.cval)) q4,
                              DECODE(s.tz, cn_tz_a, DECODE(p.valtype_id, cn_vt_er, s.cval)) aer,
                              DECODE(s.tz, cn_tz_a, DECODE(p.valtype_id, cn_vt_ed, s.cval)) aed,
                              DECODE(s.tz, cn_tz_a, DECODE(p.valtype_id, cn_vt_q1, s.cval)) aq1,
                              DECODE(s.tz, cn_tz_a, DECODE(p.valtype_id, cn_vt_q3, s.cval)) aq3,
                              DECODE(s.tz, cn_tz_a, DECODE(p.valtype_id, cn_vt_q2, s.cval)) aq2,
                              DECODE(s.tz, cn_tz_a, DECODE(p.valtype_id, cn_vt_q4, s.cval)) aq4,
                              DECODE(s.tz, cn_tz_b, DECODE(p.valtype_id, cn_vt_er, s.cval)) ber,
                              DECODE(s.tz, cn_tz_b, DECODE(p.valtype_id, cn_vt_ed, s.cval)) bed,
                              DECODE(s.tz, cn_tz_b, DECODE(p.valtype_id, cn_vt_q1, s.cval)) bq1,
                              DECODE(s.tz, cn_tz_b, DECODE(p.valtype_id, cn_vt_q3, s.cval)) bq3,
                              DECODE(s.tz, cn_tz_b, DECODE(p.valtype_id, cn_vt_q2, s.cval)) bq2,
                              DECODE(s.tz, cn_tz_b, DECODE(p.valtype_id, cn_vt_q4, s.cval)) bq4,
                              DECODE(s.tz, cn_tz_c, DECODE(p.valtype_id, cn_vt_er, s.cval)) cer,
                              DECODE(s.tz, cn_tz_c, DECODE(p.valtype_id, cn_vt_ed, s.cval)) ced,
                              DECODE(s.tz, cn_tz_c, DECODE(p.valtype_id, cn_vt_q1, s.cval)) cq1,
                              DECODE(s.tz, cn_tz_c, DECODE(p.valtype_id, cn_vt_q3, s.cval)) cq3,
                              DECODE(s.tz, cn_tz_c, DECODE(p.valtype_id, cn_vt_q2, s.cval)) cq2,
                              DECODE(s.tz, cn_tz_c, DECODE(p.valtype_id, cn_vt_q4, s.cval)) cq4,
                              DECODE(s.tz, cn_tz_d, DECODE(p.valtype_id, cn_vt_er, s.cval)) der,
                              DECODE(s.tz, cn_tz_d, DECODE(p.valtype_id, cn_vt_ed, s.cval)) ded,
                              DECODE(s.tz, cn_tz_d, DECODE(p.valtype_id, cn_vt_q1, s.cval)) dq1,
                              DECODE(s.tz, cn_tz_d, DECODE(p.valtype_id, cn_vt_q3, s.cval)) dq3,
                              DECODE(s.tz, cn_tz_d, DECODE(p.valtype_id, cn_vt_q2, s.cval)) dq2,
                              DECODE(s.tz, cn_tz_d, DECODE(p.valtype_id, cn_vt_q4, s.cval)) dq4, ln_null erm,
                              ln_null edm, ln_null q1m, ln_null q3m, ln_null q2m, ln_null q4m, ln_null aerm,
                              ln_null aedm, ln_null aq1m, ln_null aq3m, ln_null aq2m, ln_null aq4m, ln_null berm,
                              ln_null bedm, ln_null bq1m, ln_null bq3m, ln_null bq2m, ln_null bq4m, ln_null cerm,
                              ln_null cedm, ln_null cq1m, ln_null cq3m, ln_null cq2m, ln_null cq4m, ln_null derm,
                              ln_null dedm, ln_null dq1m, ln_null dq3m, ln_null dq2m, ln_null dq4m
                         FROM s_1mon s, points p
                        WHERE s.obj_id = :1
                          AND s.ts > ADD_MONTHS(:63, -1)
                          AND s.obj_id = p.obj_id(+)
                          AND s.point_id = p.point_id(+)
                       UNION ALL
                       SELECT s.ts, ln_null er, ln_null ed, ln_null q1, ln_null q3, ln_null q2, ln_null q4, ln_null aer,
                              ln_null aed, ln_null aq1, ln_null aq3, ln_null aq2, ln_null aq4, ln_null ber, ln_null bed,
                              ln_null bq1, ln_null bq3, ln_null bq2, ln_null bq4, ln_null cer, ln_null ced, ln_null cq1,
                              ln_null cq3, ln_null cq2, ln_null cq4, ln_null der, ln_null ded, ln_null dq1, ln_null dq3,
                              ln_null dq2, ln_null dq4, DECODE(s.tz, cn_tz_s, DECODE(p.valtype_id, cn_vt_er, s.val)) erm,
                              DECODE(s.tz, cn_tz_s, DECODE(p.valtype_id, cn_vt_ed, s.val)) edm,
                              DECODE(s.tz, cn_tz_s, DECODE(p.valtype_id, cn_vt_q1, s.val)) q1m,
                              DECODE(s.tz, cn_tz_s, DECODE(p.valtype_id, cn_vt_q3, s.val)) q3m,
                              DECODE(s.tz, cn_tz_s, DECODE(p.valtype_id, cn_vt_q2, s.val)) q2m,
                              DECODE(s.tz, cn_tz_s, DECODE(p.valtype_id, cn_vt_q4, s.val)) q4m,
                              DECODE(s.tz, cn_tz_a, DECODE(p.valtype_id, cn_vt_er, s.val)) aerm,
                              DECODE(s.tz, cn_tz_a, DECODE(p.valtype_id, cn_vt_ed, s.val)) aedm,
                              DECODE(s.tz, cn_tz_a, DECODE(p.valtype_id, cn_vt_q1, s.val)) aq1m,
                              DECODE(s.tz, cn_tz_a, DECODE(p.valtype_id, cn_vt_q3, s.val)) aq3m,
                              DECODE(s.tz, cn_tz_a, DECODE(p.valtype_id, cn_vt_q2, s.val)) aq2m,
                              DECODE(s.tz, cn_tz_a, DECODE(p.valtype_id, cn_vt_q4, s.val)) aq4m,
                              DECODE(s.tz, cn_tz_b, DECODE(p.valtype_id, cn_vt_er, s.val)) berm,
                              DECODE(s.tz, cn_tz_b, DECODE(p.valtype_id, cn_vt_ed, s.val)) bedm,
                              DECODE(s.tz, cn_tz_b, DECODE(p.valtype_id, cn_vt_q1, s.val)) bq1m,
                              DECODE(s.tz, cn_tz_b, DECODE(p.valtype_id, cn_vt_q3, s.val)) bq3m,
                              DECODE(s.tz, cn_tz_b, DECODE(p.valtype_id, cn_vt_q2, s.val)) bq2m,
                              DECODE(s.tz, cn_tz_b, DECODE(p.valtype_id, cn_vt_q4, s.val)) bq4m,
                              DECODE(s.tz, cn_tz_c, DECODE(p.valtype_id, cn_vt_er, s.val)) cerm,
                              DECODE(s.tz, cn_tz_c, DECODE(p.valtype_id, cn_vt_ed, s.val)) cedm,
                              DECODE(s.tz, cn_tz_c, DECODE(p.valtype_id, cn_vt_q1, s.val)) cq1m,
                              DECODE(s.tz, cn_tz_c, DECODE(p.valtype_id, cn_vt_q3, s.val)) cq3m,
                              DECODE(s.tz, cn_tz_c, DECODE(p.valtype_id, cn_vt_q2, s.val)) cq2m,
                              DECODE(s.tz, cn_tz_c, DECODE(p.valtype_id, cn_vt_q4, s.val)) cq4m,
                              DECODE(s.tz, cn_tz_d, DECODE(p.valtype_id, cn_vt_er, s.val)) derm,
                              DECODE(s.tz, cn_tz_d, DECODE(p.valtype_id, cn_vt_ed, s.val)) dedm,
                              DECODE(s.tz, cn_tz_d, DECODE(p.valtype_id, cn_vt_q1, s.val)) dq1m,
                              DECODE(s.tz, cn_tz_d, DECODE(p.valtype_id, cn_vt_q3, s.val)) dq3m,
                              DECODE(s.tz, cn_tz_d, DECODE(p.valtype_id, cn_vt_q2, s.val)) dq2m,
                              DECODE(s.tz, cn_tz_d, DECODE(p.valtype_id, cn_vt_q4, s.val)) dq4m
                         FROM s_1day_mv s, points p
                        WHERE s.obj_id = :1
                          AND s.ts > :63
                          AND s.ts = TRUNC(s.ts, 'MONTH')
                          AND s.obj_id = p.obj_id(+)
                          AND s.point_id = p.point_id(+)) t
             GROUP BY t.ts
             ORDER BY t.ts) LOOP
   :3(i) := lc.er;
   :4(i) := lc.ed;
   :5(i) := lc.q1;
   :6(i) := lc.q3;
   :7(i) := lc.q2;
   :8(i) := lc.q4;
   :9(i) := lc.aer;
   :10(i) := lc.aed;
   :11(i) := lc.aq1;
   :12(i) := lc.aq3;
   :13(i) := lc.aq2;
   :14(i) := lc.aq4;
   :15(i) := lc.ber;
   :16(i) := lc.bed;
   :17(i) := lc.bq1;
   :18(i) := lc.bq3;
   :19(i) := lc.bq2;
   :20(i) := lc.bq4;
   :21(i) := lc.cer;
   :22(i) := lc.ced;
   :23(i) := lc.cq1;
   :24(i) := lc.cq3;
   :25(i) := lc.cq2;
   :26(i) := lc.cq4;
   :27(i) := lc.der;
   :28(i) := lc.ded;
   :29(i) := lc.dq1;
   :30(i) := lc.dq3;
   :31(i) := lc.dq2;
   :32(i) := lc.dq4;
   :33(i) := lc.erm;
   :34(i) := lc.edm;
   :35(i) := lc.q1m;
   :36(i) := lc.q3m;
   :37(i) := lc.q2m;
   :38(i) := lc.q4m;
   :39(i) := lc.aerm;
   :40(i) := lc.aedm;
   :41(i) := lc.aq1m;
   :42(i) := lc.aq3m;
   :43(i) := lc.aq2m;
   :44(i) := lc.aq4m;
   :45(i) := lc.berm;
   :46(i) := lc.bedm;
   :47(i) := lc.bq1m;
   :48(i) := lc.bq3m;
   :49(i) := lc.bq2m;
   :50(i) := lc.bq4m;
   :51(i) := lc.cerm;
   :52(i) := lc.cedm;
   :53(i) := lc.cq1m;
   :54(i) := lc.cq3m;
   :55(i) := lc.cq2m;
   :56(i) := lc.cq4m;
   :57(i) := lc.derm;
   :58(i) := lc.dedm;
   :59(i) := lc.dq1m;
   :60(i) := lc.dq3m;
   :61(i) := lc.dq2m;
   :62(i) := lc.dq4m;
   :2(i) := lc.cdt;
   i := i + 1;
   IF i > 40 THEN
    EXIT;
   END IF;
  END LOOP;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'khartep_inet_pg.dblink_get_month: ' || SQLERRM(SQLCODE));
 END;
