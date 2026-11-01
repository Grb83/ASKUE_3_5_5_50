
-- Start of DDL script for IMPORTINASKUE_PG
-- Generated 17-мар-03  11:58:47 am
-- from ea-ASKUE:10

-- Package IMPORTINASKUE_PG

CREATE OR REPLACE
PACKAGE importinaskue_pg IS
 ---------------------------------------------------------------------------------------------
 PROCEDURE importobjects_p; --Импорт объектов
 PROCEDURE importlimit_p; --Импорт лимитов
 PROCEDURE importdebt_p; --Импорт долгов
---------------------------------------------------------------------------------------------
 PROCEDURE importimmediate_p(an_type NUMBER);
 --an_type =1  группы,an_type =2  лимиты,an_type =3  долги
---------------------------------------------------------------------------------------------
END; -- Package spec
/

-- End of DDL script for IMPORTINASKUE_PG

CREATE OR REPLACE
PACKAGE BODY importinaskue_pg IS
 -------------------------------------------------------------------------------------------
 --****                         Interface                                             ****--
 -------------------------------------------------------------------------------------------
 TYPE tr_id IS RECORD(
  mid                           NUMBER,
  npoint                        NUMBER);
 TYPE tt_id IS TABLE OF tr_id
  INDEX BY BINARY_INTEGER;
 -------------------------------------------------------------------------------------------
 TYPE tr_idg IS RECORD(
  gid                           NUMBER,
  ngroup                        NUMBER,
  npoint                        NUMBER,
  mid                           NUMBER);
 TYPE tt_idg IS TABLE OF tr_idg
  INDEX BY BINARY_INTEGER;
 -------------------------------------------------------------------------------------------
 gd_now    DATE; -- Текущее время (sysdate)
 gn_now    NUMBER; -- Текущее время (sysdate)
 gn_mid    NUMBER;
 gn_gid    NUMBER;
 gn_gidp   NUMBER;
 gn_gidl   NUMBER;
 gn_order  NUMBER;
 gn_offset NUMBER DEFAULT  1 / 288;
 -------------------------------------------------------------------------------------------
 PROCEDURE initglobalvar_p;
 PROCEDURE createimportinfo_p;
 PROCEDURE importpoint_p;
 PROCEDURE importpoint_p(an_point NUMBER);
 PROCEDURE importparallelconn;
 PROCEDURE importworktimeinfo_p(an_point NUMBER, an_mid NUMBER);
 PROCEDURE importconnparam(an_point NUMBER, an_mid NUMBER);
 PROCEDURE importworktimeinfo_c(an_connparam NUMBER);
 PROCEDURE importsharedconnparam;
 PROCEDURE importgroup_p;
 PROCEDURE importgroup_p(an_group NUMBER);
 PROCEDURE importlist_p;
 PROCEDURE delete_p;
 PROCEDURE adddopinfo_p(an_group NUMBER, an_gid NUMBER);
 PROCEDURE createruninfo(an_job NUMBER, an_error NUMBER, av_errortext VARCHAR2);
 FUNCTION getavbron_f(an_consumer NUMBER, an_period NUMBER)
  RETURN NUMBER;
 PROCEDURE importimmediate_p(an_type NUMBER, an_immediate NUMBER, ad_date DATE);
 FUNCTION gettypereact_f(an_point NUMBER, an_period NUMBER)
  RETURN NUMBER;
 FUNCTION gettypepot_f(an_point NUMBER, an_period NUMBER)
  RETURN NUMBER;
 -------------------------------------------------------------------------------------------
 --****                       Implementation                                          ****--
 -------------------------------------------------------------------------------------------
 PROCEDURE initglobalvar_p IS
 BEGIN
  SELECT importinaskue_s.NEXTVAL
    INTO gn_order
    FROM DUAL;
  SELECT mid
    INTO gn_mid
    FROM points@askue
   WHERE parent IS NULL AND cod = 0;
  SELECT MAX(gid)
    INTO gn_gid
    FROM groups@askue
   WHERE parent IS NULL AND name = 'Группы АСРПП';
  SELECT MAX(gid)
    INTO gn_gidp
    FROM groups@askue
   WHERE parent IS NULL AND name = 'Точки АСРПП';
  SELECT MAX(gid)
    INTO gn_gidl
    FROM groups@askue
   WHERE parent IS NULL AND name = 'Списки АСРПП';
  gd_now := SYSDATE;
  gn_now := TO_CHAR(gd_now, 'YYYYMM');
 END;
 -------------------------------------------------------------------------------------------
 FUNCTION getavbron_f(an_consumer NUMBER, an_period NUMBER)
  RETURN NUMBER IS
  ln_ret NUMBER;
 BEGIN
  SELECT SUM(av_bron)
    INTO ln_ret
    FROM orik.koeffzagr
   WHERE nconsumer = an_consumer AND an_period BETWEEN NVL(nachalo, 1) AND NVL(konec, 299912);
  RETURN ln_ret;
 END;
 ---------------------------------------------------------------------------------------------
 PROCEDURE createruninfo(an_job NUMBER, an_error NUMBER, av_errortext VARCHAR2) IS
 BEGIN
  INSERT INTO jobs
              (njob, ddate, nerror, verrortext)
       VALUES (an_job, SYSDATE, an_error, av_errortext);
  UPDATE lastjobs
     SET ddate = SYSDATE,
         nerror = an_error,
         verrortext = av_errortext
   WHERE njob = an_job;
  IF SQL%ROWCOUNT = 0 THEN
   INSERT INTO lastjobs
               (njob, ddate, nerror, verrortext)
        VALUES (an_job, SYSDATE, an_error, av_errortext);
  END IF;
 END;
 -------------------------------------------------------------------------------------------
 PROCEDURE createimportinfo_p IS
  CURSOR lcur_sellog IS
   SELECT ROWID rw, nroot, nclass
     FROM askuelog;
  ln_isaskue NUMBER;
  ln_cn      NUMBER;
 BEGIN
  -------------------------------- Удаляем лишнее
  DELETE FROM pointimportinaskue
        WHERE npoint IN (SELECT npoint
                           FROM pointimportinaskue
                         MINUS
                         SELECT     npoint
                               FROM ss.sspointi
                         CONNECT BY PRIOR npoint = nparent AND gn_now BETWEEN nfromperiod AND NVL(ntillperiod, 299912)
                         START WITH nisaskue = 1 AND gn_now BETWEEN NVL(nfromperiod, 0) AND NVL(ntillperiod, 299912));
  DELETE FROM groupimportinaskue
        WHERE ngroup IN (SELECT ngroup
                           FROM groupimportinaskue
                         MINUS
                         SELECT     ngroup
                               FROM ss.ssgroup
                         CONNECT BY PRIOR ngroup = nparent
                                AND gn_now BETWEEN nfromperiod AND NVL(ntillperiod, 299912)
                                AND NVL(vgroupchar, ' ') NOT IN ('D', 'S')
                         START WITH ngroup IN (SELECT ngroup
                                                 FROM ss.ssgroupi
                                                WHERE nisaskue = 1
                                                  AND gn_now BETWEEN nfromperiod AND NVL(ntillperiod, 299912))
                                AND gn_now BETWEEN NVL(nfromperiod, 0) AND NVL(ntillperiod, 299912)
                                AND NVL(vgroupchar, ' ') NOT IN ('D', 'S'));
  ------------------------------- По точкам
  FOR lc IN lcur_sellog LOOP
   IF lc.nclass = 6 THEN --точки
    SELECT MAX(nisaskue)
      INTO ln_isaskue
      FROM ss.sspointi pi, ss.sspoint p
     WHERE lc.nroot IN (SELECT     npoint
                              FROM ss.sspointi
                        CONNECT BY PRIOR npoint = nparent AND gn_now BETWEEN nfromperiod AND NVL(ntillperiod, 299912)
                        START WITH nisaskue = 1 AND gn_now BETWEEN NVL(nfromperiod, 0) AND NVL(ntillperiod, 299912))
       AND p.npoint = lc.nroot
       AND p.npoint = pi.npoint(+)
       AND gn_now BETWEEN p.nfromperiod AND NVL(p.ntillperiod, 299912)
       AND gn_now BETWEEN pi.nfromperiod AND NVL(pi.ntillperiod, 299912);
    IF ln_isaskue = 1 THEN
     SELECT COUNT(*)
       INTO ln_cn
       FROM DUAL
      WHERE EXISTS( SELECT *
                      FROM points@askue
                     WHERE npoint = lc.nroot);
     IF ln_cn = 0 THEN
      INSERT INTO pointimportinaskue
                  (npoint, norder)
       (SELECT     npoint, gn_order
              FROM ss.sspointi
        CONNECT BY PRIOR npoint = nparent AND gn_now BETWEEN nfromperiod AND NVL(ntillperiod, 299912)
        START WITH npoint = lc.nroot AND gn_now BETWEEN NVL(nfromperiod, 0) AND NVL(ntillperiod, 299912)
        MINUS
        SELECT npoint, gn_order
          FROM pointimportinaskue);
     ELSE
      INSERT INTO pointimportinaskue
                  (npoint, norder)
       (SELECT npoint, gn_order
          FROM ss.sspoint
         WHERE npoint = lc.nroot AND gn_now BETWEEN NVL(nfromperiod, 0) AND NVL(ntillperiod, 299912)
        MINUS
        SELECT npoint, gn_order
          FROM pointimportinaskue);
     END IF;
    ELSIF ln_isaskue = 0 THEN
     INSERT INTO pointimportinaskue
                 (npoint, norder)
      (SELECT npoint, gn_order
         FROM ss.sspoint
        WHERE npoint = lc.nroot AND gn_now BETWEEN NVL(nfromperiod, 0) AND NVL(ntillperiod, 299912)
       MINUS
       SELECT npoint, gn_order
         FROM pointimportinaskue);
    END IF;
   ELSIF lc.nclass = 1 THEN ------------------------------- По группам
    SELECT MAX(nisaskue)
      INTO ln_isaskue
      FROM ss.ssgroupi g
     WHERE lc.nroot IN (SELECT     ngroup
                              FROM ss.ssgroup
                        CONNECT BY PRIOR ngroup = nparent
                               AND gn_now BETWEEN nfromperiod AND NVL(ntillperiod, 299912)
                               AND NVL(vgroupchar, ' ') NOT IN ('D', 'S')
                        START WITH ngroup IN (SELECT ngroup
                                                FROM ss.ssgroupi
                                               WHERE nisaskue = 1
                                                 AND gn_now BETWEEN nfromperiod AND NVL(ntillperiod, 299912))
                               AND gn_now BETWEEN NVL(nfromperiod, 0) AND NVL(ntillperiod, 299912)
                               AND NVL(vgroupchar, ' ') NOT IN ('D', 'S'))
       AND g.ngroup = lc.nroot
       AND gn_now BETWEEN g.nfromperiod AND NVL(g.ntillperiod, 299912);
    IF ln_isaskue = 1 THEN
     SELECT COUNT(*)
       INTO ln_cn
       FROM DUAL
      WHERE EXISTS( SELECT *
                      FROM groups@askue
                     WHERE nroot2 = lc.nroot AND nroot1 IS NULL);
     IF ln_cn = 0 THEN
      INSERT INTO groupimportinaskue
                  (ngroup)
       (SELECT     ngroup
              FROM ss.ssgroup
        CONNECT BY PRIOR ngroup = nparent
               AND gn_now BETWEEN nfromperiod AND NVL(ntillperiod, 299912)
               AND NVL(vgroupchar, ' ') NOT IN ('D', 'S')
        START WITH ngroup = lc.nroot
               AND gn_now BETWEEN NVL(nfromperiod, 0) AND NVL(ntillperiod, 299912)
               AND NVL(vgroupchar, ' ') NOT IN ('D', 'S')
        MINUS
        SELECT ngroup
          FROM groupimportinaskue);
     ELSE
      INSERT INTO groupimportinaskue
                  (ngroup)
       (SELECT ngroup
          FROM ss.ssgroup
         WHERE ngroup = lc.nroot
           AND gn_now BETWEEN NVL(nfromperiod, 0) AND NVL(ntillperiod, 299912)
           AND NVL(vgroupchar, ' ') NOT IN ('D', 'S')
        MINUS
        SELECT ngroup
          FROM groupimportinaskue);
     END IF;
    ELSIF ln_isaskue = 0 THEN
     INSERT INTO groupimportinaskue
                 (ngroup)
      (SELECT ngroup
         FROM ss.ssgroup
        WHERE ngroup = lc.nroot
          AND gn_now BETWEEN NVL(nfromperiod, 0) AND NVL(ntillperiod, 299912)
          AND NVL(vgroupchar, ' ') NOT IN ('D', 'S')
       MINUS
       SELECT ngroup
         FROM groupimportinaskue);
    ELSIF ln_isaskue IS NULL THEN
     SELECT MAX(npoint)
       INTO ln_isaskue
       FROM ss.ssgroup g
      WHERE lc.nroot IN (SELECT     ngroup
                               FROM ss.ssgroup
                         CONNECT BY PRIOR ngroup = nparent
                                AND gn_now BETWEEN nfromperiod AND NVL(ntillperiod, 299912)
                                AND NVL(vgroupchar, ' ') NOT IN ('D', 'S')
                         START WITH ngroup IN (SELECT ngroup
                                                 FROM ss.ssgroupi
                                                WHERE nisaskue = 1
                                                  AND gn_now BETWEEN nfromperiod AND NVL(ntillperiod, 299912))
                                AND gn_now BETWEEN NVL(nfromperiod, 0) AND NVL(ntillperiod, 299912)
                                AND NVL(vgroupchar, ' ') NOT IN ('D', 'S'))
        AND g.ngroup = lc.nroot
        AND gn_now BETWEEN g.nfromperiod AND NVL(g.ntillperiod, 299912);
     IF ln_isaskue IS NOT NULL THEN
      INSERT INTO groupimportinaskue
                  (ngroup)
       (SELECT lc.nroot
          FROM DUAL
        MINUS
        SELECT ngroup
          FROM groupimportinaskue);
     END IF;
    END IF;
   END IF;
   DELETE FROM askuelog
         WHERE ROWID = lc.rw;
  END LOOP;
  INSERT INTO pointimportinaskue
              (npoint, norder)
   (SELECT     npoint, gn_order
          FROM ss.sspointi
    CONNECT BY PRIOR npoint = nparent AND gn_now BETWEEN nfromperiod AND NVL(ntillperiod, 299912)
    START WITH nisaskue = 1 AND gn_now BETWEEN NVL(nfromperiod, 0) AND NVL(ntillperiod, 299912)
    MINUS
    SELECT npoint, gn_order
      FROM pointimportinaskue
    MINUS
    SELECT npoint, gn_order
      FROM points@askue
     WHERE npoint IS NOT NULL);
  ----------------------А теперь изменения по точке записали в группы
  INSERT INTO groupimportinaskue
              (ngroup)
   (SELECT g.ngroup
      FROM pointimportinaskue p, ss.ssgroup g
     WHERE p.norder = gn_order
       AND p.npoint = g.npoint
       AND g.ngroup IN (SELECT     ngroup
                              FROM ss.ssgroup
                        CONNECT BY PRIOR ngroup = nparent
                               AND gn_now BETWEEN nfromperiod AND NVL(ntillperiod, 299912)
                               AND NVL(vgroupchar, ' ') NOT IN ('D', 'S')
                        START WITH ngroup IN (SELECT ngroup
                                                FROM ss.ssgroupi
                                               WHERE nisaskue = 1
                                                 AND gn_now BETWEEN nfromperiod AND NVL(ntillperiod, 299912))
                               AND NVL(vgroupchar, ' ') NOT IN ('D', 'S')
                               AND gn_now BETWEEN nfromperiod AND NVL(ntillperiod, 299912))
    MINUS
    SELECT ngroup
      FROM groupimportinaskue);
 END;
 --------------------------------------------------------------------------------------------
 PROCEDURE importparallelconn IS
  CURSOR lcur_sel IS
   SELECT p.nparallelconnection, p.vusetype
     FROM ss.ssparallelconnection p, parallelconnection@askue a
    WHERE -a.nparallelconnection = p.nparallelconnection(+) AND p.vusetype <> a.vusetype;
 BEGIN
  INSERT INTO parallelconnection@askue
              (nparallelconnection, vusetype)
   SELECT -nparallelconnection, vusetype
     FROM ss.ssparallelconnection
    WHERE -nparallelconnection IN (SELECT -nparallelconnection
                                     FROM ss.ssparallelconnection
                                   MINUS
                                   SELECT nparallelconnection
                                     FROM parallelconnection@askue);
  FOR lc IN lcur_sel LOOP
   UPDATE parallelconnection@askue a
      SET vusetype = lc.vusetype
    WHERE nparallelconnection = -lc.nparallelconnection;
  END LOOP;
 END;
 --------------------------------------------------------------------------------------------
 PROCEDURE importconnparam(an_point NUMBER, an_mid NUMBER) IS
  CURSOR lcur_sel IS
   SELECT 0 nnew, c.nconnectionparam, c.vname, c.nsn, c.nsh, c.ndeltapidling, c.ndeltapsc, c.niidling, c.nusc, c.nro,
          c.nxo, c.nl, c.nun, c.nenergypercent,
          NVL(c.nworkinghours, DECODE(c.nshifts, 3, 700, 1, 200, 2, 450, NULL)) nworkinghours, c.nfullhours,
          c.nnotincludeconsump, c.nparallelconnection
     FROM ss.ssconnectionparam c
    WHERE npoint = an_point
      AND gn_now BETWEEN nfromperiod AND NVL(ntillperiod, 299912)
      AND EXISTS( SELECT *
                    FROM connectionparam@askue
                   WHERE -nconnectionparam = c.nconnectionparam AND mid = an_mid)
   UNION ALL
   SELECT 1 nnew, c.nconnectionparam, c.vname, c.nsn, c.nsh, c.ndeltapidling, c.ndeltapsc, c.niidling, c.nusc, c.nro,
          c.nxo, c.nl, c.nun, c.nenergypercent,
          NVL(c.nworkinghours, DECODE(c.nshifts, 3, 700, 1, 200, 2, 450, NULL)) nworkinghours, c.nfullhours,
          c.nnotincludeconsump, c.nparallelconnection
     FROM ss.ssconnectionparam c
    WHERE npoint = an_point
      AND gn_now BETWEEN nfromperiod AND NVL(ntillperiod, 299912)
      AND NOT EXISTS(
                     SELECT *
                       FROM connectionparam@askue
                      WHERE -nconnectionparam = c.nconnectionparam AND mid = an_mid);
 BEGIN
  FOR lc IN lcur_sel LOOP
   IF lc.nnew = 1 THEN
    loss_pg.ins_p_a@askue(
     -lc.nconnectionparam, an_mid, lc.vname, lc.nsn, lc.nsh, lc.ndeltapidling, lc.ndeltapsc, lc.niidling, lc.nusc,
     lc.nro, lc.nxo, lc.nl, lc.nun, lc.nenergypercent, lc.nworkinghours, lc.nfullhours, lc.nnotincludeconsump,
     -lc.nparallelconnection);
   ELSE
    loss_pg.upd_p_a@askue(
     -lc.nconnectionparam, an_mid, lc.vname, lc.nsn, lc.nsh, lc.ndeltapidling, lc.ndeltapsc, lc.niidling, lc.nusc,
     lc.nro, lc.nxo, lc.nl, lc.nun, lc.nenergypercent, lc.nworkinghours, lc.nfullhours, lc.nnotincludeconsump,
     -lc.nparallelconnection);
   END IF;
   importworktimeinfo_c(lc.nconnectionparam);
  END LOOP;
  DELETE FROM connectionparam@askue c
        WHERE mid = an_mid
          AND NOT EXISTS( SELECT *
                            FROM ss.ssconnectionparam
                           WHERE nconnectionparam = -c.nconnectionparam
                             AND gn_now BETWEEN nfromperiod AND NVL(ntillperiod, 299912));
 END;
 --------------------------------------------------------------------------------------------
 PROCEDURE importworktimeinfo_p(an_point NUMBER, an_mid NUMBER) IS
  ln_old NUMBER DEFAULT TO_CHAR(ADD_MONTHS(TO_DATE(gn_now, 'YYYYMM'), -24), 'YYYYMM');
 BEGIN
  DELETE FROM pointfullhours@askue
        WHERE mid = an_mid AND naccperiod >= ln_old;
  INSERT INTO pointfullhours@askue
              (mid, naccperiod, nfullhours, nworkinghours)
   SELECT an_mid, naccperiod, nfullhours, nworkinghours
     FROM ss.sspointfullhours p
    WHERE npoint = an_point AND naccperiod >= ln_old;
 END;
 --------------------------------------------------------------------------------------------
 PROCEDURE importworktimeinfo_c(an_connparam NUMBER) IS
  ln_old NUMBER DEFAULT TO_CHAR(ADD_MONTHS(TO_DATE(gn_now, 'YYYYMM'), -24), 'YYYYMM');
 BEGIN
  DELETE FROM CONNECTIONPARAMFULLHOURS@askue
        WHERE NCONNECTIONPARAM = -an_connparam AND naccperiod >= ln_old;
  INSERT INTO CONNECTIONPARAMFULLHOURS@askue
              (NCONNECTIONPARAM, naccperiod, nfullhours, nworkinghours)
   SELECT -an_connparam, naccperiod, nfullhours, nworkinghours
     FROM ss.ssCONNECTIONPARAMFULLHOURS p
    WHERE NCONNECTIONPARAM = an_connparam AND naccperiod >= ln_old;
END;
 --------------------------------------------------------------------------------------------
 PROCEDURE importsharedconnparam IS
 BEGIN
  DELETE FROM sharedconnectionparam@askue;
  INSERT INTO sharedconnectionparam@askue
              (nconnectionparam, mid, nnotincludeconsump)
   SELECT c.nconnectionparam, p.mid, s.nnotincludeconsump
     FROM points@askue p, connectionparam@askue c, ss.sssharedconnectionparam s
    WHERE s.npoint = p.npoint
      AND c.nconnectionparam = -s.nconnectionparam
      AND gn_now BETWEEN s.nfromperiod AND NVL(s.ntillperiod, 299912);
 END;
 --------------------------------------------------------------------------------------------
 PROCEDURE importpoint_p IS
  ln_cn    NUMBER;
  ln_point NUMBER         DEFAULT -1;
  lv_error VARCHAR2(2000);
  ln_code  NUMBER;
 BEGIN
  importparallelconn;
  COMMIT;
  LOOP
   BEGIN
    SELECT MIN(npoint)
      INTO ln_point
      FROM pointimportinaskue
     WHERE npoint > ln_point;
    IF ln_point IS NULL THEN
     EXIT;
    END IF;
    SELECT COUNT(*)
      INTO ln_cn
      FROM DUAL
     WHERE EXISTS( SELECT *
                     FROM ss.sspoint p, ss.sspointi pi
                    WHERE p.npoint = ln_point
                      AND gn_now BETWEEN p.nfromperiod AND NVL(p.ntillperiod, 299912)
                      AND p.npoint = pi.npoint(+)
                      AND gn_now BETWEEN pi.nfromperiod AND NVL(pi.ntillperiod, 299912));
    IF ln_cn = 1 THEN
     importpoint_p(ln_point);
    END IF;
    DELETE FROM pointimportinaskue
          WHERE npoint = ln_point;
   EXCEPTION
    WHEN OTHERS THEN
     ROLLBACK;
     ln_code := SQLCODE;
     IF ln_code = -28 OR ln_code = -1089 THEN
      RAISE;
     END IF;
     lv_error := SUBSTR(SQLERRM, 1, 2000);
     UPDATE pointimportinaskue
        SET nerror = -1,
            verror = lv_error
      WHERE npoint = ln_point;
   END;
   COMMIT;
  END LOOP;
  importsharedconnparam;
  COMMIT;
 END;
 --------------------------------------------------------------------------------------------
 PROCEDURE importpoint_p(an_point NUMBER) IS
  ln_daycount          NUMBER        DEFAULT TO_NUMBER(TO_CHAR(LAST_DAY(TO_DATE(gn_now, 'YYYYMM')), 'DD')); --Кол-во дней в месяце
  CURSOR lcur_sel IS
   SELECT     npoint, nparent
         FROM ss.sspointi
        WHERE gn_now BETWEEN nfromperiod AND NVL(ntillperiod, 299912)
   CONNECT BY PRIOR nparent = npoint AND gn_now BETWEEN PRIOR nfromperiod AND NVL(PRIOR ntillperiod, 299912)
   START WITH npoint = an_point AND gn_now BETWEEN nfromperiod AND NVL(ntillperiod, 299912);
  CURSOR lcur_met(lc_point NUMBER, lc_smart NUMBER) IS
   SELECT entype, mtrsn, date_time, digits, mtype, mcurrent, mpower, mconst, mclass, myear, mquarter
     FROM ryda.meters m
    WHERE m.mid = lc_point
      AND m.date_time = (SELECT MAX(date_time)
                           FROM ryda.meters
                          WHERE mid = lc_point
                            AND date_time < gd_now
                            AND DECODE(smart, '*', 1, 0) = lc_smart
                            AND entype = m.entype)
      AND DECODE(m.smart, '*', 1, 0) = lc_smart;
  lt_id                tt_id;
  b                    BOOLEAN       DEFAULT TRUE;
  cn                   NUMBER        DEFAULT 0;
  ln_folder            NUMBER;
  ----------------------
  lv_name              VARCHAR2(256);
  lv_short_name        VARCHAR2(256);
  ln_mid               NUMBER;
  ----------------------
  ln_er_position       NUMBER;
  ln_q1_position       NUMBER;
  ln_ed_position       NUMBER;
  ln_q3_position       NUMBER;
  ln_smart             NUMBER; --Интеллектуал
  ln_q1234             NUMBER; --Квадранты
  lv_cellnum           VARCHAR2(256); --Номер ячейки
  ln_power             NUMBER; --Мощность
  ln_power2            NUMBER; --Мощность
  ln_current1          NUMBER; --Напряжение перв
  ln_current2          NUMBER; --Напряжение вторич
  ln_kc                NUMBER; --Коэфф
  lv_smart             VARCHAR2(32);
  ln_linewastepercent  NUMBER; --Потери в линии
  ln_actwastepercent   NUMBER; --Потери акт в тр-ре
  ln_reactwastepercent NUMBER; --Потери реакт в тр-ре
  ln_workinghours      NUMBER; --время работы
  ln_fullhours         NUMBER; --полное время
 ----------------------
 BEGIN
  FOR lc IN lcur_sel LOOP
   cn := cn + 1;
   lt_id(cn).npoint := lc.npoint;
   SELECT MAX(mid)
     INTO lt_id(cn).mid
     FROM points@askue
    WHERE npoint = lc.npoint;
   IF lc.nparent IS NULL THEN
    b := FALSE;
   END IF;
  END LOOP;
  IF b THEN
   raise_application_error(-20009, 'Ошибка рекурсивного поднятия до первого уровня', TRUE);
  END IF;
  lt_id(cn + 1).mid := gn_mid;
  SELECT DECODE(npoint_folder, 3, 0, 1)
    INTO ln_folder
    FROM ss.sspoint
   WHERE npoint = an_point;
  FOR i IN REVERSE 1 .. cn LOOP
   IF  i = 1 AND ln_folder = 0 THEN --Точка
    SELECT pi.vname, pi.vshortname, DECODE(SUBSTR(TO_CHAR(pi.nmeasurables, '0000'), 2, 1), '1', 1, 0) er,
           DECODE(SUBSTR(TO_CHAR(pi.nmeasurables, '0000'), 3, 1), '1', 1, 0) q1,
           DECODE(SUBSTR(TO_CHAR(pi.nmeasurables, '0000'), 4, 1), '1', 1, 0) ed,
           DECODE(SUBSTR(TO_CHAR(pi.nmeasurables, '0000'), 5, 1), '1', 1, 0) q3, pi.nsmart, pi.nsmartq1234, pi.vcell,
           t.nvalue, pi.nthroughratio, DECODE(pi.nsmart, 1, '*', NULL) vsmart, pi.nlinewastepercent,
           pi.nactwastepercent, pi.nreactwastepercent, NVL(pi.nworkinghours, pi.ndayhours * ln_daycount) nworkinghours,
           pi.nfullhours
      INTO lv_name, lv_short_name, ln_er_position,
           ln_q1_position,
           ln_ed_position,
           ln_q3_position, ln_smart, ln_q1234, lv_cellnum,
           ln_power, ln_kc, lv_smart, ln_linewastepercent,
           ln_actwastepercent, ln_reactwastepercent, ln_workinghours,
           ln_fullhours
      FROM ss.sspointi pi, ss.sspointpowertype t
     WHERE pi.npoint = lt_id(i).npoint
       AND gn_now BETWEEN pi.nfromperiod AND NVL(pi.ntillperiod, 299912)
       AND pi.npointpowertype = t.npointpowertype(+);
    SELECT MAX(t.ncurrent1) current1, MAX(t.ncurrent2) current2
      INTO ln_current1, ln_current2
      FROM ryda.meters m, ryda.rdtransformer t
     WHERE m.mid = lt_id(i).npoint
       AND m.date_time = (SELECT MAX(date_time)
                            FROM ryda.meters
                           WHERE mid = lt_id(i).npoint
                             AND date_time < gd_now
                             AND DECODE(smart, '*', 1, 0) = ln_smart
                             AND entype = m.entype)
       AND m.ntransformer IS NOT NULL
       AND m.ntransformer = t.ntransformer(+);
    IF ln_power > 0.4 THEN
     ln_power2 := 0.1;
    ELSIF ln_power <= 0.4 THEN
     ln_power2 := ln_power;
    ELSE
     ln_power2 := NULL;
    END IF;
    IF lt_id(i).mid IS NULL THEN --Ins
     editfeeders_pg.ins_p_a@askue(
      lt_id(i + 1).mid, 3, lv_name, lv_short_name, ln_er_position, ln_q1_position, ln_ed_position, ln_q3_position,
      ln_smart, ln_q1234, lv_cellnum, ln_power, ln_current1, ln_current2, ln_kc, lt_id(i).npoint, ln_power2,
      lt_id(i).mid);
     FOR lc IN lcur_met(lt_id(i).npoint, ln_smart) LOOP
      editfeeders_pg.upd_meters_a@askue(
       lt_id(i).mid, lc.entype, lv_smart, lc.mtrsn, lc.date_time, lc.digits, lc.mtype, lc.mcurrent, lc.mpower,
       lc.mconst, lc.mclass, lc.myear, lc.mquarter);
     END LOOP;
    ELSE --Upd
     editfeeders_pg.upd_p_a@askue(
      lt_id(i).mid, lt_id(i + 1).mid, 3, lv_name, lv_short_name, ln_er_position, ln_q1_position, ln_ed_position,
      ln_q3_position, ln_smart, ln_q1234, lv_cellnum, ln_power, ln_current1, ln_current2, ln_kc, ln_power2);
     FOR lc IN lcur_met(lt_id(i).npoint, ln_smart) LOOP
      editfeeders_pg.upd_meters_a@askue(
       lt_id(i).mid, lc.entype, lv_smart, lc.mtrsn, lc.date_time, lc.digits, lc.mtype, lc.mcurrent, lc.mpower,
       lc.mconst, lc.mclass, lc.myear, lc.mquarter);
     END LOOP;
    END IF;
    editfeeders_pg.setpoterinfo@askue(
     lt_id(i).mid, gettypepot_f(lt_id(i).npoint, gn_now), ln_workinghours, ln_fullhours, ln_linewastepercent,
     ln_actwastepercent, ln_reactwastepercent, gettypereact_f(lt_id(i).npoint, gn_now));
    importworktimeinfo_p(lt_id(i).npoint, lt_id(i).mid);
    importconnparam(lt_id(i).npoint, lt_id(i).mid);
   ELSE --Папка
    IF lt_id(i).mid IS NULL THEN --Ins
     SELECT vname, vshortname
       INTO lv_name, lv_short_name
       FROM ss.sspointi
      WHERE npoint = lt_id(i).npoint AND gn_now BETWEEN nfromperiod AND NVL(ntillperiod, 299912);
     editfeedergroup_pg.ins_p_a@askue(lt_id(i + 1).mid, lv_name, lv_short_name, lt_id(i).npoint, lt_id(i).mid);
     IF i <> 1 THEN
      DELETE FROM pointimportinaskue
            WHERE npoint = lt_id(i).npoint;
     END IF;
    ELSIF i = 1 THEN --Upd
     SELECT vname, vshortname
       INTO lv_name, lv_short_name
       FROM ss.sspointi
      WHERE npoint = lt_id(i).npoint AND gn_now BETWEEN nfromperiod AND NVL(ntillperiod, 299912);
     editfeedergroup_pg.upd_p_a@askue(lt_id(i).mid, lt_id(i + 1).mid, lv_name, lv_short_name);
    END IF;
   END IF;
  END LOOP;
 END;
 --------------------------------------------------------------------------------------------
 PROCEDURE importgroup_p IS
  ln_cn    NUMBER;
  ln_group NUMBER         DEFAULT -1;
  lv_error VARCHAR2(2000);
  ln_code  NUMBER;
 BEGIN
  LOOP
   BEGIN
    SELECT MIN(ngroup)
      INTO ln_group
      FROM groupimportinaskue
     WHERE ngroup > ln_group;
    IF ln_group IS NULL THEN
     EXIT;
    END IF;
    SELECT COUNT(*)
      INTO ln_cn
      FROM DUAL
     WHERE EXISTS( SELECT *
                     FROM ss.ssgroup g
                    WHERE g.ngroup = ln_group
                      AND gn_now BETWEEN g.nfromperiod AND NVL(g.ntillperiod, 299912)
                      AND (   (    g.npoint IS NULL
                               AND EXISTS( SELECT *
                                             FROM ss.ssgroupi
                                            WHERE ngroup = ln_group
                                              AND gn_now BETWEEN nfromperiod AND NVL(ntillperiod, 299912)))
                           OR (    g.npoint IS NOT NULL
                               AND EXISTS( SELECT *
                                             FROM ss.sspointi
                                            WHERE npoint = g.npoint
                                              AND gn_now BETWEEN nfromperiod AND NVL(ntillperiod, 299912)))));
    IF ln_cn = 1 THEN
     importgroup_p(ln_group);
    END IF;
    DELETE FROM groupimportinaskue
          WHERE ngroup = ln_group;
   EXCEPTION
    WHEN OTHERS THEN
     ROLLBACK;
     ln_code := SQLCODE;
     IF ln_code = -28 OR ln_code = -1089 THEN
      RAISE;
     END IF;
     lv_error := SUBSTR(SQLERRM, 1, 2000);
     UPDATE groupimportinaskue
        SET nerror = -1,
            verror = lv_error
      WHERE ngroup = ln_group;
   END;
   COMMIT;
  END LOOP;
 END;
 --------------------------------------------------------------------------------------------
 PROCEDURE importgroup_p(an_group NUMBER) IS
  CURSOR lcur_sel IS
   SELECT     ngroup, nparent, npoint
         FROM ss.ssgroup
        WHERE gn_now BETWEEN nfromperiod AND NVL(ntillperiod, 299912) AND NVL(vgroupchar, ' ') NOT IN ('D', 'S')
   CONNECT BY PRIOR nparent = ngroup
          AND gn_now BETWEEN PRIOR nfromperiod AND NVL(PRIOR ntillperiod, 299912)
          AND NVL(PRIOR vgroupchar, ' ') NOT IN ('D', 'S')
   START WITH ngroup = an_group
          AND gn_now BETWEEN nfromperiod AND NVL(ntillperiod, 299912)
          AND NVL(vgroupchar, ' ') NOT IN ('D', 'S');
  lt_id                tt_idg;
  b                    BOOLEAN       DEFAULT TRUE;
  cn                   NUMBER        DEFAULT 0;
  ----------------------------
  lv_name              VARCHAR2(256);
  lv_short_name        VARCHAR2(256);
  ln_mid               NUMBER;
  ln_inverted          NUMBER;
  ln_emergencyreserve  NUMBER;
  ln_technologyreserve NUMBER;
  ln_cons              NUMBER;
 ----------------------------
 BEGIN
  FOR lc IN lcur_sel LOOP
   cn := cn + 1;
   lt_id(cn).ngroup := lc.ngroup;
   lt_id(cn).npoint := lc.npoint;
   SELECT MAX(gid)
     INTO lt_id(cn).gid
     FROM groups@askue
    WHERE nroot2 = lc.ngroup AND nroot1 IS NULL;
   IF  cn = 1 AND lc.npoint IS NULL AND lt_id(cn).gid IS NULL THEN
    RETURN;
   END IF;
   IF lc.npoint IS NOT NULL THEN
    SELECT MAX(mid)
      INTO lt_id(cn).mid
      FROM points@askue
     WHERE npoint = lc.npoint;
    IF lt_id(cn).mid IS NULL THEN
     RETURN;
    --     raise_application_error(-20009, 'Ошибка получения ид точки в БД АСКУЭ по ngroup=' || lc.ngroup || '.', TRUE);
    END IF;
   ELSE
    lt_id(cn).mid := NULL;
   END IF;
   IF lc.nparent IS NULL THEN
    b := FALSE;
   END IF;
  END LOOP;
  IF b THEN
   RETURN;
  --   raise_application_error(-20009, 'Ошибка рекурсивного поднятия до первого уровня', TRUE);
  END IF;
  lt_id(cn + 1).gid := gn_gid;
  FOR i IN REVERSE 1 .. cn LOOP
   IF lt_id(i).gid IS NULL OR i = 1 THEN
    IF lt_id(i).npoint IS NULL THEN --Группа
     SELECT NVL(gi.vname, g.vname), NVL(gi.vshortname, g.vshortname), 0, gi.nemergencyreserve, gi.ntechnologyreserve,
            DECODE(g.vgroupkind, 'C', 1, 0) ncons
       INTO lv_name, lv_short_name, ln_inverted, ln_emergencyreserve, ln_technologyreserve,
            ln_cons
       FROM ss.ssgroup g, ss.ssgroupi gi
      WHERE g.ngroup = lt_id(i).ngroup
        AND g.ngroup = gi.ngroup(+)
        AND gn_now BETWEEN gi.nfromperiod (+) AND NVL(gi.ntillperiod(+), 299912);
    ELSE --Точка
     SELECT NVL(g.vname, pi.vname), NVL(g.vshortname, pi.vshortname), DECODE(SIGN(g.ndirection), -1, 1, 0),
            DECODE(1, 2, 1, NULL), DECODE(1, 2, 1, NULL), 0
       INTO lv_name, lv_short_name, ln_inverted,
            ln_emergencyreserve, ln_technologyreserve, ln_cons
       FROM ss.ssgroup g, ss.sspointi pi
      WHERE g.ngroup = lt_id(i).ngroup
        AND g.npoint = pi.npoint(+)
        AND gn_now BETWEEN pi.nfromperiod AND NVL(pi.ntillperiod, 299912);
    END IF;
    IF lt_id(i).gid IS NULL THEN --Ins
     editgroups_pg.ins_p_a@askue(
      lt_id(i + 1).gid, lv_name, lv_short_name, lt_id(i).mid, ln_inverted, NULL, lt_id(i).ngroup, ln_emergencyreserve,
      ln_technologyreserve, lt_id(i).gid);
     IF ln_cons = 1 THEN
      adddopinfo_p(lt_id(i).ngroup, lt_id(i).gid);
     END IF;
     IF i <> 1 THEN
      NULL;
      DELETE FROM groupimportinaskue
            WHERE ngroup = lt_id(i).ngroup;
     END IF;
    ELSE --Upd
     editgroups_pg.upd_p_a@askue(
      lt_id(i).gid, lt_id(i + 1).gid, lv_name, lv_short_name, ln_inverted, ln_emergencyreserve, ln_technologyreserve);
    END IF;
    COMMIT;
   END IF;
  END LOOP;
 END;
 --------------------------------------------------------------------------------------------
 PROCEDURE importlist_p IS
  ln_groupid NUMBER;
  ln_gid     NUMBER;
  ln_gid1    NUMBER;
  lv_name    VARCHAR2(256);
  CURSOR lcur_del(lc_list NUMBER) IS
   SELECT nroot2
     FROM groups@askue
    WHERE nroot1 = lc_list AND nroot2 > 0
   MINUS
   SELECT nconsumer
     FROM ss.ssconsumerinlist
    WHERE nconsumerlist = lc_list
      AND gn_now BETWEEN NVL(nfromperiod, 0) AND NVL(ntillperiod, 299912)
      AND nconsumer IN (SELECT     ngroup
                              FROM ss.ssgroup
                        CONNECT BY PRIOR ngroup = nparent AND gn_now BETWEEN nfromperiod AND NVL(ntillperiod, 299912)
                        START WITH ngroup IN (SELECT ngroup
                                                FROM ss.ssgroupi
                                               WHERE nisaskue = 1
                                                 AND gn_now BETWEEN nfromperiod AND NVL(ntillperiod, 299912))
                               AND gn_now BETWEEN NVL(nfromperiod, 0) AND NVL(ntillperiod, 299912));
  CURSOR lcur_sel IS
   SELECT l.nconsumerlist, l.vname
     FROM ss.sslistusergroup g, ss.ssconsumerlist l
    WHERE g.nusergroup = ln_groupid
      AND g.nconsumerlist = l.nconsumerlist
      AND gn_now BETWEEN NVL(l.nfromperiod, 0) AND NVL(l.ntillperiod, 299912);
  CURSOR lcur_sel1(lc_list NUMBER) IS
   SELECT gi.ngroup, DECODE(l.vtext, '', gi.vname, l.vtext || '.' || gi.vname) vname
     FROM ss.ssgroupi gi, ss.ssconsumerinlist l, groups@askue g
    WHERE l.nconsumerlist = lc_list
      AND gi.ngroup = l.nconsumer
      AND gn_now BETWEEN NVL(gi.nfromperiod, 0) AND NVL(gi.ntillperiod, 299912)
      AND gi.ngroup = g.nroot2
      AND g.nroot1 IS NULL;
 BEGIN
  SELECT MAX(nusergroup)
    INTO ln_groupid
    FROM rs.rsusergroup
   WHERE vrole = 'AMSASKUE';
  IF ln_groupid IS NULL THEN
   RETURN;
  END IF;
  DELETE FROM groups@askue
        WHERE nroot1 > 10
          AND nroot1 NOT IN (SELECT g.nconsumerlist
                               FROM ss.sslistusergroup g, ss.ssconsumerlist l
                              WHERE g.nusergroup = ln_groupid
                                AND g.nconsumerlist = l.nconsumerlist
                                AND gn_now BETWEEN NVL(l.nfromperiod, 0) AND NVL(l.ntillperiod, 299912));
  FOR lc IN lcur_sel LOOP
   SELECT MAX(gid), MAX(name)
     INTO ln_gid, lv_name
     FROM groups@askue
    WHERE nroot1 = lc.nconsumerlist AND nroot2 IS NULL;
   IF ln_gid IS NULL THEN
    editgroups_pg.ins_p_a@askue(gn_gidl, lc.vname, NULL, NULL, 0, lc.nconsumerlist, NULL, NULL, NULL, ln_gid);
   ELSE
    IF lv_name <> lc.vname THEN
     UPDATE groups@askue
        SET name = lc.vname
      WHERE nroot1 = lc.nconsumerlist AND nroot2 IS NULL;
    END IF;
   END IF;
   FOR lc1 IN lcur_del(lc.nconsumerlist) LOOP
    DELETE FROM groups@askue
          WHERE nroot1 = lc.nconsumerlist AND nroot2 = lc1.nroot2;
   END LOOP;
   FOR lc1 IN lcur_sel1(lc.nconsumerlist) LOOP
    SELECT MAX(gid), MAX(name)
      INTO ln_gid1, lv_name
      FROM groups@askue
     WHERE nroot1 = lc.nconsumerlist AND nroot2 = lc1.ngroup;
    IF ln_gid1 IS NULL THEN
     editgroups_pg.ins_p_a@askue(ln_gid, lc1.vname, NULL, NULL, 0, lc.nconsumerlist, lc1.ngroup, NULL, NULL, ln_gid1);
     adddopinfo_p(lc1.ngroup, ln_gid1);
    ELSE
     IF lv_name <> lc1.vname THEN
      UPDATE groups@askue
         SET name = lc1.vname
       WHERE nroot1 = lc.nconsumerlist AND nroot2 = lc1.ngroup;
     END IF;
    END IF;
   END LOOP;
  END LOOP;
 END;
 --------------------------------------------------------------------------------------------
 PROCEDURE delete_p IS
  ln_mid NUMBER;
  CURSOR lcur_selp IS
   SELECT     p.npoint
         FROM points@askue p
        WHERE p.npoint > 0
   CONNECT BY PRIOR p.mid = p.parent
   START WITH p.mid = gn_mid
   MINUS
   (SELECT     npoint
          FROM ss.sspointi
    CONNECT BY PRIOR npoint = nparent AND gn_now BETWEEN nfromperiod AND NVL(ntillperiod, 299912)
    START WITH nisaskue = 1 AND gn_now BETWEEN nfromperiod AND NVL(ntillperiod, 299912)
    UNION
    SELECT     npoint
          FROM ss.sspointi
         WHERE gn_now BETWEEN nfromperiod AND NVL(ntillperiod, 299912)
    CONNECT BY PRIOR nparent = npoint AND gn_now BETWEEN PRIOR nfromperiod AND NVL(PRIOR ntillperiod, 299912)
    START WITH nisaskue = 1 AND gn_now BETWEEN nfromperiod AND NVL(ntillperiod, 299912));
  CURSOR lcur_selg IS
   SELECT     g.nroot2 ngroup
         FROM groups@askue g
        WHERE g.nroot2 > 0 AND g.nroot1 IS NULL
   CONNECT BY PRIOR g.gid = g.parent
   START WITH g.gid = gn_gid
   MINUS
   (SELECT     ngroup
          FROM ss.ssgroup
    CONNECT BY PRIOR ngroup = nparent AND gn_now BETWEEN nfromperiod AND NVL(ntillperiod, 299912)
    START WITH ngroup IN (SELECT ngroup
                            FROM ss.ssgroupi
                           WHERE nisaskue = 1 AND gn_now BETWEEN nfromperiod AND NVL(ntillperiod, 299912))
           AND gn_now BETWEEN nfromperiod AND NVL(ntillperiod, 299912)
    UNION
    SELECT     ngroup
          FROM ss.ssgroup
    CONNECT BY PRIOR nparent = ngroup AND gn_now BETWEEN nfromperiod AND NVL(ntillperiod, 299912)
    START WITH ngroup IN (SELECT ngroup
                            FROM ss.ssgroupi
                           WHERE nisaskue = 1 AND gn_now BETWEEN nfromperiod AND NVL(ntillperiod, 299912))
           AND gn_now BETWEEN nfromperiod AND NVL(ntillperiod, 299912));
  CURSOR lcur_selg1 IS
   SELECT g.nroot2 ngroup
     FROM groups@askue g
    WHERE g.nroot2 > 0 AND g.nroot1 IS NULL
   MINUS
   SELECT     g.nroot2 ngroup
         FROM groups@askue g
        WHERE g.nroot2 > 0 AND g.nroot1 IS NULL
   CONNECT BY PRIOR g.parent = g.gid
   START WITH g.mid > 0 AND g.nroot2 > 0 AND g.nroot1 IS NULL;
 BEGIN
  FOR lc IN lcur_selp LOOP
   SELECT MAX(mid)
     INTO ln_mid
     FROM points@askue
    WHERE npoint = lc.npoint;
   IF util_pg.is_point_have_data@askue(ln_mid) = 0 THEN
    NULL;
   --editfeeders_pg.del_p@askue(ln_mid);
   ELSE
    DELETE FROM groups@askue
          WHERE mid = ln_mid AND nroot2 > 0 AND nroot1 IS NULL;
   END IF;
  END LOOP;
  FOR lc IN lcur_selg LOOP
   DELETE FROM groups@askue
         WHERE nroot2 = lc.ngroup AND nroot1 IS NULL;
  END LOOP;
  COMMIT;
  FOR lc IN lcur_selg1 LOOP
   DELETE FROM groups@askue
         WHERE nroot2 = lc.ngroup AND nroot1 IS NULL;
  END LOOP;
  COMMIT;
 END;
 --------------------------------------------------------------------------------------------
 PROCEDURE adddopinfo_p(an_group NUMBER, an_gid NUMBER) IS
  ln_deb               NUMBER;
  ln_debrestr          NUMBER;
  ln_emergencyreserve  NUMBER;
  ln_technologyreserve NUMBER;
  ln_code              NUMBER;
  ln_flag              NUMBER;
 BEGIN
    ln_deb := ss.ssutilsgaek.n_currdedt_f(an_group, gd_now);
    ln_debrestr := ss.ssutilsgaek.n_restrcurrdedt_f(an_group, gd_now);
    ln_debrestr:=nvl(ln_debrestr,ln_deb);
    ln_emergencyreserve := getavbron_f(an_group, gn_now);
    ln_technologyreserve := NULL;
    UPDATE groups@askue
       SET ndeb = ln_deb,
           ndebrestr = ln_debrestr,
           nemergencyreserve = ln_emergencyreserve,
           ntechnologyreserve = ln_technologyreserve
     WHERE gid = an_gid;
    select nvl(max(vgetplan),1) into ln_flag from deb.TFLAG@oracle.world@askue;
    IF ln_flag=0 THEN
     INSERT INTO grouplimit@askue
                 (gid, dstart, nlimitcons, nlimitcapm, nlimitcape)
      SELECT an_gid, TO_DATE(p.nperiod, 'YYYYMM'), p.nenergy, p.npowerm, p.npowere
        FROM deb.tplan@oracle.world@askue p, deb.tconsumer@oracle.world@askue c
       WHERE c.nconsumer = p.nconsumer AND NVL(c.nout, 0) = 0 AND c.nconsumerss = an_group;
    END IF;
   EXCEPTION
    WHEN OTHERS THEN
     ln_code := SQLCODE;
     IF ln_code = -28 OR ln_code = -1089 THEN
      RAISE;
     END IF;
  NULL;
 END;
 ---------------------------------------------------------------------------------------------
 PROCEDURE importobjects_p --Импорт объектов
                           IS
  lv_err VARCHAR2(2000);
  ln_job NUMBER         DEFAULT 1;
 BEGIN
  initglobalvar_p;
  createimportinfo_p;
  COMMIT;
  importpoint_p;
  IF gn_gid IS NOT NULL THEN
   importgroup_p;
  END IF;
  IF gn_gidl IS NOT NULL THEN
   importlist_p;
  END IF;
  delete_p;
  COMMIT;
  createruninfo(ln_job, 1, NULL);
  COMMIT;
 EXCEPTION
  WHEN OTHERS THEN
   lv_err := SUBSTR(SQLERRM, 1, 2000);
   ROLLBACK;
   createruninfo(ln_job, -1, lv_err);
   importimmediate_p(ln_job, 1, SYSDATE + gn_offset);
   COMMIT;
 END;
 ---------------------------------------------------------------------------------------------
 PROCEDURE importlimit_p --Импорт лимитов
                         IS
  lv_err  VARCHAR2(2000);
  ln_flag NUMBER;
  ln_job  NUMBER         DEFAULT 2;
 BEGIN
    initglobalvar_p;
    select nvl(max(vgetplan),1) into ln_flag from deb.TFLAG@oracle.world@askue;
    IF ln_flag=0 THEN
      DELETE FROM grouplimit@askue
            WHERE dstart >= ADD_MONTHS(TRUNC(gd_now, 'MONTH'), -1);
      INSERT INTO grouplimit@askue
                  (gid, dstart, nlimitcons, nlimitcapm, nlimitcape)
       SELECT g.gid, TO_DATE(p.nperiod, 'YYYYMM'), p.nenergy, p.npowerm, p.npowere
         FROM deb.tplan@oracle.world@askue p, deb.tconsumer@oracle.world@askue c, groups@askue g
        WHERE c.nconsumer = p.nconsumer
          AND NVL(c.nout, 0) = 0
          AND c.nconsumerss = g.nroot2
          AND NVL(g.nroot1, 0) <> 1
          AND p.nperiod >= TO_NUMBER(TO_CHAR(ADD_MONTHS(TRUNC(gd_now, 'MONTH'), -1), 'YYYYMM'));
      createruninfo(ln_job, 1, NULL);
    END IF;
    COMMIT;
   EXCEPTION
      WHEN OTHERS THEN
       lv_err := SUBSTR(SQLERRM, 1, 2000);
       ROLLBACK;
       createruninfo(ln_job, -1, lv_err);
       importimmediate_p(ln_job,1,sysdate+gn_offset);
       COMMIT;
  NULL;
 END;
 ---------------------------------------------------------------------------------------------
 PROCEDURE importdebt_p --Импорт долгов
                        IS
  lv_err               VARCHAR2(2000);
  ln_deb               NUMBER;
  ln_debrestr          NUMBER;
  ln_emergencyreserve  NUMBER;
  ln_technologyreserve NUMBER;
  ln_job               NUMBER         DEFAULT 3;
  CURSOR lcur_sel IS
   SELECT c.nconsumer, g.gid
     FROM ss.ssconsumeri c, groups@askue g
    WHERE gn_now BETWEEN nfromperiod AND NVL(ntillperiod, 299912) AND c.nconsumer = g.nroot2 AND NVL(g.nroot1, 0) <> 1;
 BEGIN
  initglobalvar_p;
  FOR lc IN lcur_sel LOOP
   ln_deb := ss.ssutilsgaek.n_currdedt_f(lc.nconsumer, gd_now);
   ln_debrestr := ss.ssutilsgaek.n_restrcurrdedt_f(lc.nconsumer, gd_now);
   ln_debrestr := NVL(ln_debrestr, ln_deb);
   ln_emergencyreserve := getavbron_f(lc.nconsumer, gn_now);
   ln_technologyreserve := NULL;
   UPDATE groups@askue
      SET ndeb = ln_deb,
          ndebrestr = ln_debrestr,
          nemergencyreserve = ln_emergencyreserve,
          ntechnologyreserve = ln_technologyreserve
    WHERE gid = lc.gid;
  END LOOP;
  DELETE      maxhours@askue;
  INSERT INTO maxhours@askue
              (maxhour_id, date_time, morning_start, morning_end, evening_start, evening_end)
   SELECT nfromperiod maxhour_id, TO_DATE(nfromperiod, 'YYYYMM') date_time,
          TO_DATE(nfromperiod || '.' || vstartmorningcheck, 'YYYYMM.HH24:MI') morning_start,
          TO_DATE(nfromperiod || '.' || vendmorningcheck, 'YYYYMM.HH24:MI') morning_end,
          TO_DATE(nfromperiod || '.' || vstarteveningcheck, 'YYYYMM.HH24:MI') evening_start,
          TO_DATE(nfromperiod || '.' || vendeevningcheck, 'YYYYMM.HH24:MI') evening_end
     FROM ryda.capacitycheck c;
  createruninfo(ln_job, 1, NULL);
  COMMIT;
 EXCEPTION
  WHEN OTHERS THEN
   lv_err := SUBSTR(SQLERRM, 1, 2000);
   ROLLBACK;
   createruninfo(ln_job, -1, lv_err);
   importimmediate_p(ln_job, 1, SYSDATE + gn_offset);
   COMMIT;
 END;
 ---------------------------------------------------------------------------------------------
 PROCEDURE importimmediate_p(an_type NUMBER) IS
 BEGIN
  importimmediate_p(an_type, 0, SYSDATE);
 END;
 ---------------------------------------------------------------------------------------------
 PROCEDURE importimmediate_p(an_type NUMBER, an_immediate NUMBER, ad_date DATE) IS
  jobno   NUMBER;
  lv_what VARCHAR2(256);
  ln_cn   NUMBER        DEFAULT 0;
 --------------------------
 BEGIN
  IF an_type = 1 THEN
   lv_what := 'ASKUE.IMPORTINASKUE_PG.IMPORTOBJECTS_P;';
  ELSIF an_type = 2 THEN
   lv_what := 'ASKUE.IMPORTINASKUE_PG.IMPORTLIMIT_P;';
  ELSIF an_type = 3 THEN
   lv_what := 'ASKUE.IMPORTINASKUE_PG.IMPORTDEBT_P;';
  ELSE
   RETURN;
  END IF;
  IF NVL(an_immediate, 0) <> 1 THEN
   SELECT COUNT(*)
     INTO ln_cn
     FROM DUAL
    WHERE EXISTS( SELECT *
                    FROM user_jobs
                   WHERE what = lv_what);
  END IF;
  IF ln_cn = 0 THEN
   DBMS_JOB.submit(jobno, lv_what, ad_date, NULL);
  END IF;
 END;
 ---------------------------------------------------------------------------------------------
 FUNCTION gettypereact_f(an_point NUMBER, an_period NUMBER)
  RETURN NUMBER IS
  ln_ret         NUMBER DEFAULT 0;
  ln_ratio       NUMBER;
  ln_measurables NUMBER;
 BEGIN
  SELECT NVL(re.nratio, 0) nratio, DECODE(SUBSTR(TO_CHAR(pi.nmeasurables, '9999'), 3, 1), '1', 1, 0) nmeasurables
    INTO ln_ratio, ln_measurables
    FROM ss.sspointi pi, ss.ssrecompens re
   WHERE pi.npoint = an_point
     AND an_period BETWEEN pi.nfromperiod AND NVL(pi.ntillperiod, 299912)
     AND pi.nrecompens = re.nrecompenstype(+);
  IF ln_measurables = 0 THEN
   SELECT MIN(nrecompens)
     INTO ln_ret
     FROM recompens@askue
    WHERE nratio = ln_ratio;
  END IF;
  RETURN ln_ret;
 END;
 ---------------------------------------------------------------------------------------------
 FUNCTION gettypepot_f(an_point NUMBER, an_period NUMBER)
  RETURN NUMBER IS
  lv_ret VARCHAR2(32);
 BEGIN
  lv_ret := ss.sspointcalc_pg.f_gettypepot(an_point, an_period);
  IF lv_ret = '%' THEN
   RETURN 1;
  ELSIF lv_ret = 'Фп' THEN
   RETURN 2;
  ELSIF lv_ret = '%2' THEN
   RETURN 3;
  ELSIF lv_ret = 'Ф' THEN
   RETURN 4;
  END IF;
  RETURN 0;
 END;
---------------------------------------------------------------------------------------------
END;
/
