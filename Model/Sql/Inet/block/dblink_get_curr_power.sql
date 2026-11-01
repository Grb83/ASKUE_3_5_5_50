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
 BEGIN
  FOR lc IN (SELECT SUM(DECODE(m.key, cn_mt_erm, m.val, NULL)) erm, SUM(DECODE(m.key, cn_mt_edm, m.val, NULL)) edm,
                    SUM(DECODE(m.key, cn_mt_eq1m, m.val, NULL)) q1m, SUM(DECODE(m.key, cn_mt_eq2m, m.val, NULL)) q2m,
                    SUM(DECODE(m.key, cn_mt_eq3m, m.val, NULL)) q3m, SUM(DECODE(m.key, cn_mt_eq4m, m.val, NULL)) q4m,
                    SUM(DECODE(m.key, cn_mt_er, m.val, NULL)) er, SUM(DECODE(m.key, cn_mt_ed, m.val, NULL)) ed,
                    SUM(DECODE(m.key, cn_mt_eq1, m.val, NULL)) q1, SUM(DECODE(m.key, cn_mt_eq2, m.val, NULL)) q2,
                    SUM(DECODE(m.key, cn_mt_eq3, m.val, NULL)) q3, SUM(DECODE(m.key, cn_mt_eq4, m.val, NULL)) q4,
                    SUM(DECODE(m.key, cn_mt_freq, m.val, NULL)) freq, SUM(DECODE(m.key, cn_mt_cosf, m.val, NULL)) cosf,
                    SUM(DECODE(m.key, cn_mt_volt1, m.val, NULL)) volt, SUM(DECODE(m.key, cn_mt_volt2, m.val, NULL)) volt2,
                    SUM(DECODE(m.key, cn_mt_volt3, m.val, NULL)) volt3,
                    SUM(DECODE(m.key, cn_mt_curr1, m.val, NULL)) currento,
                    SUM(DECODE(m.key, cn_mt_curr2, m.val, NULL)) curr2,
                    SUM(DECODE(m.key, cn_mt_curr3, m.val, NULL)) curr3,
                    SUM(DECODE(m.key, cn_mt_nfiu1, m.val, NULL)) nfiu1,
                    SUM(DECODE(m.key, cn_mt_nfiu2, m.val, NULL)) nfiu2,
                    SUM(DECODE(m.key, cn_mt_nfiu3, m.val, NULL)) nfiu3,
                    SUM(DECODE(m.key, cn_mt_nfii1, m.val, NULL)) nfii1,
                    SUM(DECODE(m.key, cn_mt_nfii2, m.val, NULL)) nfii2,
                    SUM(DECODE(m.key, cn_mt_nfii3, m.val, NULL)) nfii3, MAX(m.ts) ts, MAX(m.rcode) rcode
               FROM multim m
              WHERE m.obj_id = :1 AND m.ts = (SELECT MAX(ts)
                                                    FROM multim
                                                   WHERE obj_id = :1)) LOOP
   :2 := lc.erm;
   :3 := lc.edm;
   :4 := lc.q1m;
   :5 := lc.q3m;
   :6 := lc.q2m;
   :7 := lc.q4m;
   :8 := lc.freq;
   :9 := lc.cosf;
   :10 := lc.volt;
   :11 := lc.volt2;
   :12 := lc.volt3;
   :13 := lc.currento;
   :14 := lc.curr2;
   :15 := lc.curr3;
   :16 := lc.er;
   :17 := lc.ed;
   :18 := lc.q1;
   :19 := lc.q3;
   :20 := lc.q2;
   :21 := lc.q4;
   :22 := lc.nfiu1;
   :23 := lc.nfiu2;
   :24 := lc.nfiu3;
   :25 := lc.nfii1;
   :26 := lc.nfii2;
   :27 := lc.nfii3;
   :28 := TO_CHAR(lc.ts, 'dd.mm.yyyy hh24:mi');
   EXIT;
  END LOOP;
EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'khartep_inet_pg.dblink_get_curr_power: ' || SQLERRM(SQLCODE));
END;