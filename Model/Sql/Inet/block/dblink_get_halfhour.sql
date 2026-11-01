declare
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
   i        NUMBER DEFAULT 1;
  ln_null  NUMBER;
  cn_hh_kc NUMBER DEFAULT  1 / 2;
 BEGIN
  FOR lc IN (SELECT   TO_CHAR(t.ts, 'dd.mm.yyyy hh24:mi') cdt, SUM(t.er) er, SUM(t.ed) ed, SUM(t.q1) q1, SUM(t.q3) q3,
                      SUM(t.q2) q2, SUM(t.q4) q4, SUM(t.erm) erm, SUM(t.edm) edm, SUM(t.q1m) q1m, SUM(t.q3m) q3m,
                      SUM(t.q2m) q2m, SUM(t.q4m) q4m, 0 status
                 FROM (SELECT s.ts + 1 / 48 ts,
                              DECODE(p.valtype_id, cn_vt_er, s.cval * cn_hh_kc, NULL) / 2 er,
                              DECODE(p.valtype_id, cn_vt_ed, s.cval * cn_hh_kc, NULL) ed,
                              DECODE(p.valtype_id, cn_vt_q1, s.cval * cn_hh_kc, NULL) q1,
                              DECODE(p.valtype_id, cn_vt_q3, s.cval * cn_hh_kc, NULL) q3,
                              DECODE(p.valtype_id, cn_vt_q2, s.cval * cn_hh_kc, NULL) q2,
                              DECODE(p.valtype_id, cn_vt_q4, s.cval * cn_hh_kc, NULL) q4, ln_null erm,
                              ln_null edm, ln_null q1m, ln_null q3m, ln_null q2m, ln_null q4m
                         FROM s_30min s, points p
                        WHERE s.obj_id = :1
                          AND s.ts > :16 - 1 / 48
                          AND s.obj_id = p.obj_id(+)
                          AND s.point_id = p.point_id(+)
                       UNION ALL
                       SELECT s.ts, ln_null er, ln_null ed, ln_null q1, ln_null q3, ln_null q2, ln_null q4,
                              DECODE(p.valtype_id, cn_vt_er, s.val, NULL) erm,
                              DECODE(p.valtype_id, cn_vt_ed, s.val, NULL) edm,
                              DECODE(p.valtype_id, cn_vt_q1, s.val, NULL) q1m,
                              DECODE(p.valtype_id, cn_vt_q3, s.val, NULL) q3m,
                              DECODE(p.valtype_id, cn_vt_q2, s.val, NULL) q2m,
                              DECODE(p.valtype_id, cn_vt_q4, s.val, NULL) q4m
                         FROM s_30min_mv s, points p
                        WHERE s.obj_id = :1
                          AND s.ts > :16
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
   :9(i) := lc.erm;
   :10(i) := lc.edm;
   :11(i) := lc.q1m;
   :12(i) := lc.q3m;
   :13(i) := lc.q2m;
   :14(i) := lc.q4m;
   :15(i) := lc.status;
   :2(i) := lc.cdt;
   i := i + 1;
   IF i > 2150 THEN
    EXIT;
   END IF;
  END LOOP;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'khartep_inet_pg.dblink_get_halfhour: ' || SQLERRM(SQLCODE));
end;
