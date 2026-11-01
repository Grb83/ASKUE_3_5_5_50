


CREATE OR REPLACE
PACKAGE khartep_inet_pg IS
 ------------------------------------------------------------------------------------------------------------------------
 TYPE tt_number IS TABLE OF NUMBER
  INDEX BY BINARY_INTEGER;
 TYPE tt_varchar2 IS TABLE OF VARCHAR2(4000)
  INDEX BY BINARY_INTEGER;
 TYPE tt_date IS TABLE OF DATE
  INDEX BY BINARY_INTEGER;
 ------------------------------------------------------------------------------------------------------------------------
  --******************************           DB Link            *******************************************************--
 ------------------------------------------------------------------------------------------------------------------------
 -- "Открытие доступа" к счетчику (Если возвращает 0 -- счетчик отсутствует в БД)
 FUNCTION dblink_openmtraccs(an_mid NUMBER)
  RETURN NUMBER;
 ------------------------------------------------------------------------------------------------------------------------
 --Запрос серийного номера счетчика
 FUNCTION dblink_get_mtr_serno(an_mid NUMBER, av_serno OUT VARCHAR2)
  RETURN NUMBER;
 ------------------------------------------------------------------------------------------------------------------------
 --Чтение текущих
 PROCEDURE dblink_get_curr_power(
  an_mid        NUMBER,
  an_erm    OUT NUMBER,
  an_edm    OUT NUMBER,
  an_q1m    OUT NUMBER,
  an_q3m    OUT NUMBER,
  an_q2m    OUT NUMBER,
  an_q4m    OUT NUMBER,
  an_freq   OUT NUMBER,
  an_cos_fi OUT NUMBER,
  an_volt1  OUT NUMBER,
  an_volt2  OUT NUMBER,
  an_volt3  OUT NUMBER,
  an_curr1  OUT NUMBER,
  an_curr2  OUT NUMBER,
  an_curr3  OUT NUMBER,
  an_fiu1i1 OUT NUMBER,
  an_fiu2i2 OUT NUMBER,
  an_fiu3i3 OUT NUMBER,
  an_fiu1u2 OUT NUMBER,
  an_fiu1u3 OUT NUMBER,
  an_fiu2u3 OUT NUMBER,
  an_er     OUT NUMBER,
  an_ed     OUT NUMBER,
  an_q1     OUT NUMBER,
  an_q3     OUT NUMBER,
  an_q2     OUT NUMBER,
  an_q4     OUT NUMBER,
  ad_date   OUT VARCHAR2);
 ------------------------------------------------------------------------------------------------------------------------
 --Чтение ГН
 PROCEDURE dblink_get_halfhour(
  an_mid           NUMBER,
  ad_cdatetime OUT tt_varchar2,
  an_er        OUT tt_number,
  an_ed        OUT tt_number,
  an_q1        OUT tt_number,
  an_q3        OUT tt_number,
  an_q2        OUT tt_number,
  an_q4        OUT tt_number,
  an_erm       OUT tt_number,
  an_edm       OUT tt_number,
  an_q1m       OUT tt_number,
  an_q3m       OUT tt_number,
  an_q2m       OUT tt_number,
  an_q4m       OUT tt_number,
  an_status    OUT tt_number,
  ad_date          DATE);
 ------------------------------------------------------------------------------------------------------------------------
   --Чтение суточных данных
 PROCEDURE dblink_get_bill(
  an_mid           NUMBER,
  ad_cdatetime OUT tt_varchar2,
  an_er        OUT tt_number,
  an_ed        OUT tt_number,
  an_q1        OUT tt_number,
  an_q3        OUT tt_number,
  an_q2        OUT tt_number,
  an_q4        OUT tt_number,
  an_aer       OUT tt_number,
  an_aed       OUT tt_number,
  an_aq1       OUT tt_number,
  an_aq3       OUT tt_number,
  an_aq2       OUT tt_number,
  an_aq4       OUT tt_number,
  an_ber       OUT tt_number,
  an_bed       OUT tt_number,
  an_bq1       OUT tt_number,
  an_bq3       OUT tt_number,
  an_bq2       OUT tt_number,
  an_bq4       OUT tt_number,
  an_cer       OUT tt_number,
  an_ced       OUT tt_number,
  an_cq1       OUT tt_number,
  an_cq3       OUT tt_number,
  an_cq2       OUT tt_number,
  an_cq4       OUT tt_number,
  an_der       OUT tt_number,
  an_ded       OUT tt_number,
  an_dq1       OUT tt_number,
  an_dq3       OUT tt_number,
  an_dq2       OUT tt_number,
  an_dq4       OUT tt_number,
  an_erm       OUT tt_number,
  an_edm       OUT tt_number,
  an_q1m       OUT tt_number,
  an_q3m       OUT tt_number,
  an_q2m       OUT tt_number,
  an_q4m       OUT tt_number,
  an_aerm      OUT tt_number,
  an_aedm      OUT tt_number,
  an_aq1m      OUT tt_number,
  an_aq3m      OUT tt_number,
  an_aq2m      OUT tt_number,
  an_aq4m      OUT tt_number,
  an_berm      OUT tt_number,
  an_bedm      OUT tt_number,
  an_bq1m      OUT tt_number,
  an_bq3m      OUT tt_number,
  an_bq2m      OUT tt_number,
  an_bq4m      OUT tt_number,
  an_cerm      OUT tt_number,
  an_cedm      OUT tt_number,
  an_cq1m      OUT tt_number,
  an_cq3m      OUT tt_number,
  an_cq2m      OUT tt_number,
  an_cq4m      OUT tt_number,
  an_derm      OUT tt_number,
  an_dedm      OUT tt_number,
  an_dq1m      OUT tt_number,
  an_dq3m      OUT tt_number,
  an_dq2m      OUT tt_number,
  an_dq4m      OUT tt_number,
  ad_date          DATE);
 ------------------------------------------------------------------------------------------------------------------------
   --Чтение месячных данных
 PROCEDURE dblink_get_month(
  an_mid           NUMBER,
  ad_cdatetime OUT tt_varchar2,
  an_er        OUT tt_number,
  an_ed        OUT tt_number,
  an_q1        OUT tt_number,
  an_q3        OUT tt_number,
  an_q2        OUT tt_number,
  an_q4        OUT tt_number,
  an_aer       OUT tt_number,
  an_aed       OUT tt_number,
  an_aq1       OUT tt_number,
  an_aq3       OUT tt_number,
  an_aq2       OUT tt_number,
  an_aq4       OUT tt_number,
  an_ber       OUT tt_number,
  an_bed       OUT tt_number,
  an_bq1       OUT tt_number,
  an_bq3       OUT tt_number,
  an_bq2       OUT tt_number,
  an_bq4       OUT tt_number,
  an_cer       OUT tt_number,
  an_ced       OUT tt_number,
  an_cq1       OUT tt_number,
  an_cq3       OUT tt_number,
  an_cq2       OUT tt_number,
  an_cq4       OUT tt_number,
  an_der       OUT tt_number,
  an_ded       OUT tt_number,
  an_dq1       OUT tt_number,
  an_dq3       OUT tt_number,
  an_dq2       OUT tt_number,
  an_dq4       OUT tt_number,
  an_erm       OUT tt_number,
  an_edm       OUT tt_number,
  an_q1m       OUT tt_number,
  an_q3m       OUT tt_number,
  an_q2m       OUT tt_number,
  an_q4m       OUT tt_number,
  an_aerm      OUT tt_number,
  an_aedm      OUT tt_number,
  an_aq1m      OUT tt_number,
  an_aq3m      OUT tt_number,
  an_aq2m      OUT tt_number,
  an_aq4m      OUT tt_number,
  an_berm      OUT tt_number,
  an_bedm      OUT tt_number,
  an_bq1m      OUT tt_number,
  an_bq3m      OUT tt_number,
  an_bq2m      OUT tt_number,
  an_bq4m      OUT tt_number,
  an_cerm      OUT tt_number,
  an_cedm      OUT tt_number,
  an_cq1m      OUT tt_number,
  an_cq3m      OUT tt_number,
  an_cq2m      OUT tt_number,
  an_cq4m      OUT tt_number,
  an_derm      OUT tt_number,
  an_dedm      OUT tt_number,
  an_dq1m      OUT tt_number,
  an_dq3m      OUT tt_number,
  an_dq2m      OUT tt_number,
  an_dq4m      OUT tt_number,
  ad_date          DATE);
-----------------------------------------------------------------------------------------------------------------------
END; -- Package Specification khartep_inet_pg
/




CREATE OR REPLACE
PACKAGE BODY khartep_inet_pg IS
 ------------------------------------------------------------------------------------------------------------------------
    -- Интерфейс взаимодействия БД с Носиком А.В. для DLL plugin'ов счетчиков
    -- дата создания 07/12/2007
 ------------------------------------------------------------------------------------------------------------------------
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
  --******************************          DLL METER           *******************************************************--
 ------------------------------------------------------------------------------------------------------------------------
 -- "Открытие доступа" к счетчику (Если возвращает 0 -- счетчик отсутствует в БД)
 FUNCTION dblink_openmtraccs(an_mid NUMBER)
  RETURN NUMBER IS
  ln_tmp NUMBER;
 BEGIN
  SELECT COUNT(*)
    INTO ln_tmp
    FROM DUAL
   WHERE EXISTS( SELECT *
                   FROM objects
                  WHERE obj_id = an_mid);
  RETURN ln_tmp;
 END;
 ------------------------------------------------------------------------------------------------------------------------
 --Запрос серийного номера счетчика
 FUNCTION dblink_get_mtr_serno(an_mid NUMBER, av_serno OUT VARCHAR2)
  RETURN NUMBER IS
  lv_serno VARCHAR2(256);
 BEGIN
  SELECT TRIM(MAX(serial))
    INTO lv_serno
    FROM dev_install
   WHERE obj_id = an_mid AND inst_date = (SELECT MAX(inst_date)
                                            FROM dev_install
                                           WHERE obj_id = an_mid);
  av_serno := NVL(lv_serno, ' ');
  IF lv_serno IS NULL THEN
   RETURN 0;
  END IF;
  RETURN 1;
 END;
 ------------------------------------------------------------------------------------------------------------------------
 --Чтение текущих
 PROCEDURE dblink_get_curr_power(
  an_mid        NUMBER,
  an_erm    OUT NUMBER,
  an_edm    OUT NUMBER,
  an_q1m    OUT NUMBER,
  an_q3m    OUT NUMBER,
  an_q2m    OUT NUMBER,
  an_q4m    OUT NUMBER,
  an_freq   OUT NUMBER,
  an_cos_fi OUT NUMBER,
  an_volt1  OUT NUMBER,
  an_volt2  OUT NUMBER,
  an_volt3  OUT NUMBER,
  an_curr1  OUT NUMBER,
  an_curr2  OUT NUMBER,
  an_curr3  OUT NUMBER,
  an_fiu1i1 OUT NUMBER,
  an_fiu2i2 OUT NUMBER,
  an_fiu3i3 OUT NUMBER,
  an_fiu1u2 OUT NUMBER,
  an_fiu1u3 OUT NUMBER,
  an_fiu2u3 OUT NUMBER,
  an_er     OUT NUMBER,
  an_ed     OUT NUMBER,
  an_q1     OUT NUMBER,
  an_q3     OUT NUMBER,
  an_q2     OUT NUMBER,
  an_q4     OUT NUMBER,
  ad_date   OUT VARCHAR2) IS
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
              WHERE m.obj_id = an_mid AND m.ts = (SELECT MAX(ts)
                                                    FROM multim
                                                   WHERE obj_id = an_mid)) LOOP
   an_erm := lc.erm;
   an_edm := lc.edm;
   an_q1m := lc.q1m;
   an_q3m := lc.q3m;
   an_q2m := lc.q2m;
   an_q4m := lc.q4m;
   an_freq := lc.freq;
   an_cos_fi := lc.cosf;
   an_volt1 := lc.volt;
   an_volt2 := lc.volt2;
   an_volt3 := lc.volt3;
   an_curr1 := lc.currento;
   an_curr2 := lc.curr2;
   an_curr3 := lc.curr3;
   an_er := lc.er;
   an_ed := lc.ed;
   an_q1 := lc.q1;
   an_q3 := lc.q3;
   an_q2 := lc.q2;
   an_q4 := lc.q4;
   an_fiu1u2 := lc.nfiu1;
   an_fiu1u3 := lc.nfiu2;
   an_fiu2u3 := lc.nfiu3;
   an_fiu1i1 := lc.nfii1;
   an_fiu2i2 := lc.nfii2;
   an_fiu3i3 := lc.nfii3;
   ad_date := TO_CHAR(lc.ts, 'dd.mm.yyyy hh24:mi');
   EXIT;
  END LOOP;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'khartep_inet_pg.dblink_get_curr_power: ' || SQLERRM(SQLCODE));
 END;
 ------------------------------------------------------------------------------------------------------------------------
 --Чтение ГН
 PROCEDURE dblink_get_halfhour(
  an_mid           NUMBER,
  ad_cdatetime OUT tt_varchar2,
  an_er        OUT tt_number,
  an_ed        OUT tt_number,
  an_q1        OUT tt_number,
  an_q3        OUT tt_number,
  an_q2        OUT tt_number,
  an_q4        OUT tt_number,
  an_erm       OUT tt_number,
  an_edm       OUT tt_number,
  an_q1m       OUT tt_number,
  an_q3m       OUT tt_number,
  an_q2m       OUT tt_number,
  an_q4m       OUT tt_number,
  an_status    OUT tt_number,
  ad_date          DATE) IS
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
                        WHERE s.obj_id = an_mid
                          AND s.ts > ad_date - 1 / 48
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
                        WHERE s.obj_id = an_mid
                          AND s.ts > ad_date
                          AND s.obj_id = p.obj_id(+)
                          AND s.point_id = p.point_id(+)) t
             GROUP BY t.ts
             ORDER BY t.ts) LOOP
   an_er(i) := lc.er;
   an_ed(i) := lc.ed;
   an_q1(i) := lc.q1;
   an_q3(i) := lc.q3;
   an_q2(i) := lc.q2;
   an_q4(i) := lc.q4;
   an_erm(i) := lc.erm;
   an_edm(i) := lc.edm;
   an_q1m(i) := lc.q1m;
   an_q3m(i) := lc.q3m;
   an_q2m(i) := lc.q2m;
   an_q4m(i) := lc.q4m;
   an_status(i) := lc.status;
   ad_cdatetime(i) := lc.cdt;
   i := i + 1;
   IF i > 2150 THEN
    EXIT;
   END IF;
  END LOOP;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'khartep_inet_pg.dblink_get_halfhour: ' || SQLERRM(SQLCODE));
 END;
 ------------------------------------------------------------------------------------------------------------------------
   --Чтение суточных данных
 PROCEDURE dblink_get_bill(
  an_mid           NUMBER,
  ad_cdatetime OUT tt_varchar2,
  an_er        OUT tt_number,
  an_ed        OUT tt_number,
  an_q1        OUT tt_number,
  an_q3        OUT tt_number,
  an_q2        OUT tt_number,
  an_q4        OUT tt_number,
  an_aer       OUT tt_number,
  an_aed       OUT tt_number,
  an_aq1       OUT tt_number,
  an_aq3       OUT tt_number,
  an_aq2       OUT tt_number,
  an_aq4       OUT tt_number,
  an_ber       OUT tt_number,
  an_bed       OUT tt_number,
  an_bq1       OUT tt_number,
  an_bq3       OUT tt_number,
  an_bq2       OUT tt_number,
  an_bq4       OUT tt_number,
  an_cer       OUT tt_number,
  an_ced       OUT tt_number,
  an_cq1       OUT tt_number,
  an_cq3       OUT tt_number,
  an_cq2       OUT tt_number,
  an_cq4       OUT tt_number,
  an_der       OUT tt_number,
  an_ded       OUT tt_number,
  an_dq1       OUT tt_number,
  an_dq3       OUT tt_number,
  an_dq2       OUT tt_number,
  an_dq4       OUT tt_number,
  an_erm       OUT tt_number,
  an_edm       OUT tt_number,
  an_q1m       OUT tt_number,
  an_q3m       OUT tt_number,
  an_q2m       OUT tt_number,
  an_q4m       OUT tt_number,
  an_aerm      OUT tt_number,
  an_aedm      OUT tt_number,
  an_aq1m      OUT tt_number,
  an_aq3m      OUT tt_number,
  an_aq2m      OUT tt_number,
  an_aq4m      OUT tt_number,
  an_berm      OUT tt_number,
  an_bedm      OUT tt_number,
  an_bq1m      OUT tt_number,
  an_bq3m      OUT tt_number,
  an_bq2m      OUT tt_number,
  an_bq4m      OUT tt_number,
  an_cerm      OUT tt_number,
  an_cedm      OUT tt_number,
  an_cq1m      OUT tt_number,
  an_cq3m      OUT tt_number,
  an_cq2m      OUT tt_number,
  an_cq4m      OUT tt_number,
  an_derm      OUT tt_number,
  an_dedm      OUT tt_number,
  an_dq1m      OUT tt_number,
  an_dq3m      OUT tt_number,
  an_dq2m      OUT tt_number,
  an_dq4m      OUT tt_number,
  ad_date          DATE) IS
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
                 FROM (SELECT s.ts + 1 ts, DECODE(s.tz, cn_tz_s, DECODE(p.valtype_id, cn_vt_er, s.cval)) er,
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
                         FROM s_1day s, points p
                        WHERE s.obj_id = an_mid
                          AND s.ts > ad_date - 1
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
                        WHERE s.obj_id = an_mid
                          AND s.ts > ad_date
                          AND s.obj_id = p.obj_id(+)
                          AND s.point_id = p.point_id(+)) t
             GROUP BY t.ts
             ORDER BY t.ts) LOOP
   an_er(i) := lc.er;
   an_ed(i) := lc.ed;
   an_q1(i) := lc.q1;
   an_q3(i) := lc.q3;
   an_q2(i) := lc.q2;
   an_q4(i) := lc.q4;
   an_aer(i) := lc.aer;
   an_aed(i) := lc.aed;
   an_aq1(i) := lc.aq1;
   an_aq3(i) := lc.aq3;
   an_aq2(i) := lc.aq2;
   an_aq4(i) := lc.aq4;
   an_ber(i) := lc.ber;
   an_bed(i) := lc.bed;
   an_bq1(i) := lc.bq1;
   an_bq3(i) := lc.bq3;
   an_bq2(i) := lc.bq2;
   an_bq4(i) := lc.bq4;
   an_cer(i) := lc.cer;
   an_ced(i) := lc.ced;
   an_cq1(i) := lc.cq1;
   an_cq3(i) := lc.cq3;
   an_cq2(i) := lc.cq2;
   an_cq4(i) := lc.cq4;
   an_der(i) := lc.der;
   an_ded(i) := lc.ded;
   an_dq1(i) := lc.dq1;
   an_dq3(i) := lc.dq3;
   an_dq2(i) := lc.dq2;
   an_dq4(i) := lc.dq4;
   an_erm(i) := lc.erm;
   an_edm(i) := lc.edm;
   an_q1m(i) := lc.q1m;
   an_q3m(i) := lc.q3m;
   an_q2m(i) := lc.q2m;
   an_q4m(i) := lc.q4m;
   an_aerm(i) := lc.aerm;
   an_aedm(i) := lc.aedm;
   an_aq1m(i) := lc.aq1m;
   an_aq3m(i) := lc.aq3m;
   an_aq2m(i) := lc.aq2m;
   an_aq4m(i) := lc.aq4m;
   an_berm(i) := lc.berm;
   an_bedm(i) := lc.bedm;
   an_bq1m(i) := lc.bq1m;
   an_bq3m(i) := lc.bq3m;
   an_bq2m(i) := lc.bq2m;
   an_bq4m(i) := lc.bq4m;
   an_cerm(i) := lc.cerm;
   an_cedm(i) := lc.cedm;
   an_cq1m(i) := lc.cq1m;
   an_cq3m(i) := lc.cq3m;
   an_cq2m(i) := lc.cq2m;
   an_cq4m(i) := lc.cq4m;
   an_derm(i) := lc.derm;
   an_dedm(i) := lc.dedm;
   an_dq1m(i) := lc.dq1m;
   an_dq3m(i) := lc.dq3m;
   an_dq2m(i) := lc.dq2m;
   an_dq4m(i) := lc.dq4m;
   ad_cdatetime(i) := lc.cdt;
   i := i + 1;
   IF i > 40 THEN
    EXIT;
   END IF;
  END LOOP;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'khartep_inet_pg.dblink_get_bill: ' || SQLERRM(SQLCODE));
 END;
 ------------------------------------------------------------------------------------------------------------------------
   --Чтение месячных данных
 PROCEDURE dblink_get_month(
  an_mid           NUMBER,
  ad_cdatetime OUT tt_varchar2,
  an_er        OUT tt_number,
  an_ed        OUT tt_number,
  an_q1        OUT tt_number,
  an_q3        OUT tt_number,
  an_q2        OUT tt_number,
  an_q4        OUT tt_number,
  an_aer       OUT tt_number,
  an_aed       OUT tt_number,
  an_aq1       OUT tt_number,
  an_aq3       OUT tt_number,
  an_aq2       OUT tt_number,
  an_aq4       OUT tt_number,
  an_ber       OUT tt_number,
  an_bed       OUT tt_number,
  an_bq1       OUT tt_number,
  an_bq3       OUT tt_number,
  an_bq2       OUT tt_number,
  an_bq4       OUT tt_number,
  an_cer       OUT tt_number,
  an_ced       OUT tt_number,
  an_cq1       OUT tt_number,
  an_cq3       OUT tt_number,
  an_cq2       OUT tt_number,
  an_cq4       OUT tt_number,
  an_der       OUT tt_number,
  an_ded       OUT tt_number,
  an_dq1       OUT tt_number,
  an_dq3       OUT tt_number,
  an_dq2       OUT tt_number,
  an_dq4       OUT tt_number,
  an_erm       OUT tt_number,
  an_edm       OUT tt_number,
  an_q1m       OUT tt_number,
  an_q3m       OUT tt_number,
  an_q2m       OUT tt_number,
  an_q4m       OUT tt_number,
  an_aerm      OUT tt_number,
  an_aedm      OUT tt_number,
  an_aq1m      OUT tt_number,
  an_aq3m      OUT tt_number,
  an_aq2m      OUT tt_number,
  an_aq4m      OUT tt_number,
  an_berm      OUT tt_number,
  an_bedm      OUT tt_number,
  an_bq1m      OUT tt_number,
  an_bq3m      OUT tt_number,
  an_bq2m      OUT tt_number,
  an_bq4m      OUT tt_number,
  an_cerm      OUT tt_number,
  an_cedm      OUT tt_number,
  an_cq1m      OUT tt_number,
  an_cq3m      OUT tt_number,
  an_cq2m      OUT tt_number,
  an_cq4m      OUT tt_number,
  an_derm      OUT tt_number,
  an_dedm      OUT tt_number,
  an_dq1m      OUT tt_number,
  an_dq3m      OUT tt_number,
  an_dq2m      OUT tt_number,
  an_dq4m      OUT tt_number,
  ad_date          DATE) IS
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
                        WHERE s.obj_id = an_mid
                          AND s.ts > ADD_MONTHS(ad_date, -1)
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
                        WHERE s.obj_id = an_mid
                          AND s.ts > ad_date
                          AND s.ts = TRUNC(s.ts, 'MONTH')
                          AND s.obj_id = p.obj_id(+)
                          AND s.point_id = p.point_id(+)) t
             GROUP BY t.ts
             ORDER BY t.ts) LOOP
   an_er(i) := lc.er;
   an_ed(i) := lc.ed;
   an_q1(i) := lc.q1;
   an_q3(i) := lc.q3;
   an_q2(i) := lc.q2;
   an_q4(i) := lc.q4;
   an_aer(i) := lc.aer;
   an_aed(i) := lc.aed;
   an_aq1(i) := lc.aq1;
   an_aq3(i) := lc.aq3;
   an_aq2(i) := lc.aq2;
   an_aq4(i) := lc.aq4;
   an_ber(i) := lc.ber;
   an_bed(i) := lc.bed;
   an_bq1(i) := lc.bq1;
   an_bq3(i) := lc.bq3;
   an_bq2(i) := lc.bq2;
   an_bq4(i) := lc.bq4;
   an_cer(i) := lc.cer;
   an_ced(i) := lc.ced;
   an_cq1(i) := lc.cq1;
   an_cq3(i) := lc.cq3;
   an_cq2(i) := lc.cq2;
   an_cq4(i) := lc.cq4;
   an_der(i) := lc.der;
   an_ded(i) := lc.ded;
   an_dq1(i) := lc.dq1;
   an_dq3(i) := lc.dq3;
   an_dq2(i) := lc.dq2;
   an_dq4(i) := lc.dq4;
   an_erm(i) := lc.erm;
   an_edm(i) := lc.edm;
   an_q1m(i) := lc.q1m;
   an_q3m(i) := lc.q3m;
   an_q2m(i) := lc.q2m;
   an_q4m(i) := lc.q4m;
   an_aerm(i) := lc.aerm;
   an_aedm(i) := lc.aedm;
   an_aq1m(i) := lc.aq1m;
   an_aq3m(i) := lc.aq3m;
   an_aq2m(i) := lc.aq2m;
   an_aq4m(i) := lc.aq4m;
   an_berm(i) := lc.berm;
   an_bedm(i) := lc.bedm;
   an_bq1m(i) := lc.bq1m;
   an_bq3m(i) := lc.bq3m;
   an_bq2m(i) := lc.bq2m;
   an_bq4m(i) := lc.bq4m;
   an_cerm(i) := lc.cerm;
   an_cedm(i) := lc.cedm;
   an_cq1m(i) := lc.cq1m;
   an_cq3m(i) := lc.cq3m;
   an_cq2m(i) := lc.cq2m;
   an_cq4m(i) := lc.cq4m;
   an_derm(i) := lc.derm;
   an_dedm(i) := lc.dedm;
   an_dq1m(i) := lc.dq1m;
   an_dq3m(i) := lc.dq3m;
   an_dq2m(i) := lc.dq2m;
   an_dq4m(i) := lc.dq4m;
   ad_cdatetime(i) := lc.cdt;
   i := i + 1;
   IF i > 40 THEN
    EXIT;
   END IF;
  END LOOP;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'khartep_inet_pg.dblink_get_month: ' || SQLERRM(SQLCODE));
 END;
------------------------------------------------------------------------------------------------------------------------
END; -- Package Body khartep_inet_pg
/

