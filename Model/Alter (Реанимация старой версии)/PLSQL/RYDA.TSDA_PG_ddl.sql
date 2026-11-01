-- Start of DDL Script for Package Body RYDA.TSDA_PG
-- Generated 20.04.2010 15:08:42 from RYDA@TEST1

CREATE OR REPLACE 
PACKAGE BODY tsda_pg IS
 ------------------------------------------------------------------------------------------------------------------------
   -- пакет обмена по tsda
   -- дата создания 11/02/2008 Сечин А.А.
------------------------------------------------------------------------------------------------------------------------
 cn_hh_shift      CONSTANT NUMBER        DEFAULT 1 / 48;
 cv_enter_shift   CONSTANT VARCHAR2 (10) DEFAULT '1 / 480';
 cn_rndend        CONSTANT NUMBER        DEFAULT -456456;   --Признак, что необходимые данные для передачи по ICCP не поместились в пакет
 gt_last_save              ttitemvalue;
 gt_read_raw               ttitemvalue;

------------------------------------------------------------------------------------------------------------------------
/*
declare
at_names common_pg.tt_varchar2;
at_ids common_pg.tt_number;
an_paramcount NUMBER:=1;
an_typeofquery NUMBER:=tsda_pg.cn_qt_minutedata;-- cn_qt_minutedata cn_qt_hourdata cn_qt_daydata cn_qt_monthdata cn_qt_instantdata cn_qt_journal
ad_timebegin DATE :=to_date('19.04.2004','dd.mm.yyyy');
ad_timeend DATE :=to_date('21.04.2004','dd.mm.yyyy');
ad_change DATE:=null;
an_beginfrom NUMBER:=1;
an_count NUMBER:=100;
at_id  common_pg.tt_number;
at_datetime common_pg.tt_date;
at_er common_pg.tt_number;
at_ed common_pg.tt_number;
at_q1 common_pg.tt_number;
at_q3 common_pg.tt_number;
at_qm common_pg.tt_varchar2;
ln_ret NUMBER;
begin
for i in 1..an_paramcount loop
at_names(i):='';
at_ids(i):=45195;
end loop;
ln_ret:=TSDA_PG.sync_read_raw (at_names,at_ids,an_paramcount,an_typeofquery,ad_timebegin,ad_timeend,ad_change,an_beginfrom,an_count,at_id,at_datetime,at_er,at_ed,at_q1,at_q3,at_qm);
DBMS_OUTPUT.Put_Line('ln_ret='||ln_ret);
dbms_output.put_line('an_count='||an_count);
for i in 1..an_count loop
DBMS_OUTPUT.Put_Line( 'at_id='||at_id(i)||' at_datetime='''||to_char(at_datetime(i),'dd.mm.yyyy hh24:mi:ss')||''' at_er='||at_er(i)||' at_ed='||at_ed(i) );
end loop;
end;*/
------------------------------------------------------------------------------------------------------------------------
    -- Вставка (замена) данных
 FUNCTION sync_insert_replace_base (an_typeoffunc NUMBER,   -- 1- sync_insert 2 - sync_replace, иначе sync_insert_replace
                                                         an_typeofquery NUMBER,   -- 0-NOTUSED, 1-CURRENTDATA, 2-MINUTEDATA, 3-HOURDATA, 4-DAYDATA, 5-MONTHDATA, 6-INSTANTDATA
 an_cid NUMBER,   -- Объект , с которого дадо получить информацию (channels.cid)
               an_size NUMBER,   -- размер at_id
                              at_id common_pg.tt_number,   -- массив id
                                                        at_datetime common_pg.tt_date,   -- массив меток времени
                                                                                      at_er common_pg.tt_number,   --массив значений
                                                                                                                at_ed common_pg.tt_number,   --массив значений
 at_q1 common_pg.tt_number,   --массив значений
                           at_q3 common_pg.tt_number,   --массив значений
                                                     at_qm common_pg.tt_varchar2   --массив меток качества
 )
  RETURN NUMBER;

------------------------------------------------------------------------------------------------------------------------
--Преобразование метки качества
 FUNCTION create_qm_from_old_format (an_validity NUMBER, an_quality NUMBER, an_source NUMBER)
  RETURN VARCHAR2;

------------------------------------------------------------------------------------------------------------------------
 -- Чтение данных
 FUNCTION sync_read_raw (at_names common_pg.tt_varchar2,   -- массив mRid запрашиваемых параметров, которых надо найти
                                                        at_ids common_pg.tt_number,   -- массив id запрашиваемых параметров
                                                                                   an_paramcount NUMBER,   -- кол. входных и выходных параметров
                                                                                                        an_typeofquery NUMBER,   -- 0-NOTUSED, 1-CURRENTDATA, 2-MINUTEDATA, 3-HOURDATA, 4-DAYDATA, 5-MONTHDATA, 6-INSTANTDATA
 ad_timebegin DATE,   --дата с
                   ad_timeend DATE,   --дата по
                                   ad_change DATE,   -- дата последних изменений (показания появившиеся с)
                                                  an_beginfrom NUMBER,   --Стартовать с такого
                                                                      an_count IN OUT NUMBER,   -- макс количество возвращ значений (ДАТ)
 at_id OUT common_pg.tt_number,   -- массив id
                               at_datetime OUT common_pg.tt_date,   -- массив меток времени
                                                                 at_er OUT common_pg.tt_number,   --массив значений
                                                                                               at_ed OUT common_pg.tt_number,   --массив значений
 at_q1 OUT common_pg.tt_number,   --массив значений
                               at_q3 OUT common_pg.tt_number,   --массив значений
                                                             at_validity OUT common_pg.tt_number,   --массив достовернрости
                                                                                                 at_quality OUT common_pg.tt_number,   --массив меток качества
 at_source OUT common_pg.tt_number,   --массив источников
                                   at_qm OUT common_pg.tt_varchar2   --массив меток качества
 )
  RETURN NUMBER;

------------------------------------------------------------------------------------------------------------------------
 --Возвращает default типа titemdvalue
 FUNCTION get_def_titemvalue
  RETURN titemvalue IS
  lr_tmp   titemvalue;
 BEGIN
  lr_tmp.ID := NULL;
  lr_tmp.dat := NULL;
  lr_tmp.er := NULL;
  lr_tmp.ed := NULL;
  lr_tmp.q1 := NULL;
  lr_tmp.q3 := NULL;
  lr_tmp.q2 := NULL;
  lr_tmp.q4 := NULL;
  lr_tmp.aer := NULL;
  lr_tmp.aed := NULL;
  lr_tmp.aq1 := NULL;
  lr_tmp.aq3 := NULL;
  lr_tmp.aq2 := NULL;
  lr_tmp.aq4 := NULL;
  lr_tmp.ber := NULL;
  lr_tmp.bed := NULL;
  lr_tmp.bq1 := NULL;
  lr_tmp.bq3 := NULL;
  lr_tmp.bq2 := NULL;
  lr_tmp.bq4 := NULL;
  lr_tmp.cer := NULL;
  lr_tmp.ced := NULL;
  lr_tmp.cq1 := NULL;
  lr_tmp.cq3 := NULL;
  lr_tmp.cq2 := NULL;
  lr_tmp.cq4 := NULL;
  lr_tmp.der := NULL;
  lr_tmp.ded := NULL;
  lr_tmp.dq1 := NULL;
  lr_tmp.dq3 := NULL;
  lr_tmp.dq2 := NULL;
  lr_tmp.dq4 := NULL;
  lr_tmp.erm := NULL;
  lr_tmp.edm := NULL;
  lr_tmp.q1m := NULL;
  lr_tmp.q3m := NULL;
  lr_tmp.q2m := NULL;
  lr_tmp.q4m := NULL;
  lr_tmp.aerm := NULL;
  lr_tmp.aedm := NULL;
  lr_tmp.aq1m := NULL;
  lr_tmp.aq3m := NULL;
  lr_tmp.aq2m := NULL;
  lr_tmp.aq4m := NULL;
  lr_tmp.berm := NULL;
  lr_tmp.bedm := NULL;
  lr_tmp.bq1m := NULL;
  lr_tmp.bq3m := NULL;
  lr_tmp.bq2m := NULL;
  lr_tmp.bq4m := NULL;
  lr_tmp.cerm := NULL;
  lr_tmp.cedm := NULL;
  lr_tmp.cq1m := NULL;
  lr_tmp.cq3m := NULL;
  lr_tmp.cq2m := NULL;
  lr_tmp.cq4m := NULL;
  lr_tmp.derm := NULL;
  lr_tmp.dedm := NULL;
  lr_tmp.dq1m := NULL;
  lr_tmp.dq3m := NULL;
  lr_tmp.dq2m := NULL;
  lr_tmp.dq4m := NULL;
  lr_tmp.mtrsn := NULL;
  lr_tmp.v := cn_vd_questionable;   --cn_vd_good
  lr_tmp.q := 3;   --0
  lr_tmp.s := cn_sr_substituted;   --cn_sr_process
  lr_tmp.dchange := NULL;
  lr_tmp.qm := qm_pg.okqm;
  lr_tmp.st_cod := NULL;
  lr_tmp.st_descr := NULL;
  lr_tmp.code := NULL;
  RETURN lr_tmp;
 END;

------------------------------------------------------------------------------------------------------------------------
--Возвращает следующее ид типа измерения для запроса an_typeofquery, начиная с ln_mestype
 FUNCTION get_nextmestype (an_typeofquery NUMBER, ln_mestype NUMBER)
  RETURN NUMBER IS
 BEGIN
  IF an_typeofquery = cn_qt_hourdata THEN
   IF ln_mestype IN (0, 1, 5, 6, 7) THEN
    RETURN ln_mestype + 1;
   ELSIF ln_mestype = 2 THEN
    RETURN 5;
   END IF;
  END IF;

  RETURN 0;
 END;

------------------------------------------------------------------------------------------------------------------------
 -- Поиск элемента по наименованию
 FUNCTION find (av_name VARCHAR2,   -- Наименование элемента
                                 an_id OUT NUMBER   -- Ид элемента
                                                 )
  RETURN NUMBER IS
 BEGIN
  SELECT NVL (MAX (mid), 0)
    INTO an_id
    FROM feeders
   WHERE vcode = UPPER (av_name);

  IF an_id = 0 THEN
   RETURN cn_err_dbnotfound;
  END IF;

  RETURN cn_err_ok;
 END;

------------------------------------------------------------------------------------------------------------------------
 -- Поиск группы узлов
 FUNCTION find_each (at_names IN OUT common_pg.tt_varchar2,   -- массив mRid параметров, которых надо найти
                                                           at_ids OUT common_pg.tt_number,   -- массив id найденных параметров
 an_count IN OUT NUMBER   --кол. входных и выходных параметров
 )
  RETURN NUMBER IS
  an_id   NUMBER;
 BEGIN
  at_ids.DELETE;

  FOR i IN 1 .. an_count LOOP
   SELECT NVL (MAX (mid), 0)
     INTO an_id
     FROM feeders
    WHERE vcode = UPPER (at_names (i));

   IF an_id > 0 THEN
    at_ids (at_ids.COUNT + 1) := an_id;
   END IF;
  END LOOP;

  an_count := at_ids.COUNT;

  IF an_count = 0 THEN
   RETURN cn_err_dbnotfound;
  END IF;

  RETURN cn_err_ok;
 END;

------------------------------------------------------------------------------------------------------------------------
 -- Поиск по типу запроса
 FUNCTION find_by_type (an_typeofquery NUMBER, av_name VARCHAR2, an_beginfrom NUMBER, an_count IN OUT NUMBER, at_names OUT common_pg.tt_varchar2,   -- массив mRid параметров, которых надо найти
 at_ids OUT common_pg.tt_number   -- массив id найденных параметров
 )
  RETURN NUMBER IS
  ln_size   NUMBER DEFAULT an_count;
 BEGIN
  an_count := 0;
  RETURN cn_err_ok;
 END;

------------------------------------------------------------------------------------------------------------------------
--Преобразование метки качества
 FUNCTION create_qm_from_old_format (an_validity NUMBER, an_quality NUMBER, an_source NUMBER)
  RETURN VARCHAR2 IS
  lv_qm   VARCHAR2 (32) := qm_pg.okqm;
 BEGIN
  IF an_validity BETWEEN 0 AND 3 THEN
   lv_qm := qm_pg.sbt (lv_qm, 1, an_validity);
  END IF;

  IF an_source BETWEEN 0 AND 1 THEN
   lv_qm := qm_pg.sbt (lv_qm, 10, an_source);

   IF an_source = 1 THEN
    lv_qm := qm_pg.sbt (lv_qm, 22, qm_pg.cn_manual);
   END IF;
  END IF;

  IF an_quality BETWEEN 0 AND POWER (2, 8) - 1 THEN
   FOR i IN 0 .. 7 LOOP
    IF BITAND (an_quality, POWER (2, i)) = POWER (2, i) THEN
     lv_qm := qm_pg.sbt (lv_qm, 2 + i, qm_pg.cn_yes);
    END IF;
   END LOOP;
  END IF;

  RETURN lv_qm;
 END;

------------------------------------------------------------------------------------------------------------------------
--------------  Клиент (Киев) ------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
  -- Получение массива ID и меток времени последних сохраненных данных
 FUNCTION get_last_save (an_typeofquery NUMBER,   -- 0-NOTUSED, 1-CURRENTDATA, 2-MINUTEDATA, 3-HOURDATA, 4-DAYDATA, 5-MONTHDATA, 6-INSTANTDATA
                                               an_cid NUMBER,   -- Объект , с которого дадо получить информацию (channels.cid)
                                                             an_beginfrom NUMBER,   --Стартовать с такого
                                                                                 an_count IN OUT NUMBER,   --Требуемый и возвращаемый объем щбъем выборки
 at_ids OUT common_pg.tt_number,   -- массив id найденных параметров
                                at_lastdate OUT common_pg.tt_date   -- массив дат найденных параметров
 )
  RETURN NUMBER IS
  lt_lastchange   common_pg.tt_date;
 BEGIN
  RETURN get_last_save (an_typeofquery, an_cid, an_beginfrom, an_count, at_ids, at_lastdate, lt_lastchange);
 END;

------------------------------------------------------------------------------------------------------------------------

 -- Получение массива ID и меток времени последних сохраненных данных
 FUNCTION get_last_save (an_typeofquery NUMBER,   -- 0-NOTUSED, 1-CURRENTDATA, 2-MINUTEDATA, 3-HOURDATA, 4-DAYDATA, 5-MONTHDATA, 6-INSTANTDATA
                                               an_cid NUMBER,   -- Объект , с которого дадо получить информацию (channels.cid)
                                                             an_beginfrom NUMBER,   --Стартовать с такого
                                                                                 an_count IN OUT NUMBER,   --Требуемый и возвращаемый объем выборки
 at_ids OUT common_pg.tt_number,   -- массив id найденных параметров
                                at_lastdate OUT common_pg.tt_date,   -- массив дат найденных параметров
 at_lastchange OUT common_pg.tt_date   -- массив дат найденных параметров
 )
  RETURN NUMBER IS
  ld_sys       DATE       DEFAULT SYSDATE;
  ln_cnt       NUMBER     DEFAULT 1;
  lr_tmp       titemvalue DEFAULT get_def_titemvalue;
  ln_size      NUMBER     DEFAULT an_count;
  ln_mestype   NUMBER;
 BEGIN
  an_count := 0;

  IF NVL (an_beginfrom, 0) < 1 OR NVL (ln_size, 0) < 1 THEN
   RETURN cn_err_badarg;
  END IF;

  IF an_beginfrom = 1 THEN
   gt_last_save.DELETE;

   FOR lc IN (SELECT   f.mid, f.canal,
                       DECODE (an_typeofquery,
                               cn_qt_hourdata, NVL (l.halfhour, ld_sys - 370),
                               cn_qt_daydata, NVL (l.bill, ld_sys - 370),
                               cn_qt_monthdata, NVL (l.months, ld_sys - 370),
                               cn_qt_journal, NVL (l.journal, ld_sys - 370),
                               NVL (l.PROFILE, ld_sys - 10)
                              ) dat,
                       NVL (l.state_date, ld_sys - 370) dchange
                  FROM chanpoint p, feeders f, last_save l, channels c
                 WHERE c.cid = an_cid AND channels_pg.is_block (c.cid, c.blocking, c.nkind) = 0
                       AND TO_CHAR (NVL (c.dstart, ld_sys), 'sssss') <= TO_CHAR (ld_sys, 'sssss')
                       AND TO_CHAR (NVL (c.dend, ld_sys), 'sssss') >= TO_CHAR (ld_sys, 'sssss')
                       AND (NVL (c.nkind, 0) = 100 OR NVL (c.nday, TO_CHAR (ld_sys, 'dd')) = TO_CHAR (ld_sys, 'dd')) AND p.cid = an_cid AND p.mid = f.mid
                       AND f.canal > 0 AND p.mid = l.mid(+)
                       AND DECODE (an_typeofquery, cn_qt_daydata, c.nbilldata, cn_qt_journal, c.njournal, cn_qt_hourdata, NVL (c.nbilldatadepth, 1), 1) > 0
              ORDER BY p.mid) LOOP
    lr_tmp.ID := lc.canal;
    lr_tmp.dat := lc.dat;
    lr_tmp.dchange := lc.dchange;
    gt_last_save (ln_cnt) := lr_tmp;
    ln_cnt := ln_cnt + 1;
   END LOOP;
  END IF;

  WHILE an_count + 1 <= ln_size AND an_count + an_beginfrom <= gt_last_save.COUNT LOOP
   an_count := an_count + 1;
   at_ids (an_count) := gt_last_save (an_count + an_beginfrom - 1).ID;
   at_lastdate (an_count) := gt_last_save (an_count + an_beginfrom - 1).dat;
   at_lastchange (an_count) := gt_last_save (an_count + an_beginfrom - 1).dchange;
  END LOOP;

  IF an_count < ln_size THEN   --Очистка памяти
   gt_last_save.DELETE;
  END IF;

  RETURN cn_err_ok;
 END;

-----------------------------------------------------------------------------------------------------------------------
    -- Вставка (замена) данных
 FUNCTION sync_insert_replace_base (an_typeoffunc NUMBER,   -- 1- sync_insert 2 - sync_replace, иначе sync_insert_replace
                                                         an_typeofquery NUMBER,   -- 0-NOTUSED, 1-CURRENTDATA, 2-MINUTEDATA, 3-HOURDATA, 4-DAYDATA, 5-MONTHDATA, 6-INSTANTDATA
 an_cid NUMBER,   -- Объект , с которого дадо получить информацию (channels.cid)
               an_size NUMBER,   -- размер at_id
                              at_id common_pg.tt_number,   -- массив id
                                                        at_datetime common_pg.tt_date,   -- массив меток времени
                                                                                      at_er common_pg.tt_number,   --массив значений
                                                                                                                at_ed common_pg.tt_number,   --массив значений
 at_q1 common_pg.tt_number,   --массив значений
                           at_q3 common_pg.tt_number,   --массив значений
                                                     at_qm common_pg.tt_varchar2   --массив меток качества
 )
  RETURN NUMBER IS
  cn_rn   CONSTANT NUMBER := 3;
  ld_sys           DATE   DEFAULT SYSDATE;
  ln_mid           NUMBER DEFAULT 0;
  ln_null          NUMBER;
  ln_type          NUMBER;
  ln_exists        NUMBER;
  ln_er            NUMBER;
  ln_ed            NUMBER;
  ln_q1            NUMBER;
  ln_q3            NUMBER;
 BEGIN
  IF an_typeofquery = cn_qt_hourdata THEN
   FOR i IN 1 .. an_size LOOP
    FOR lc IN (SELECT c.mid
                 FROM chanpoint c, feeders f
                WHERE c.cid = an_cid AND c.mid = f.mid(+) AND f.canal = at_id (i)
               UNION ALL
               SELECT at_id (i) mid
                 FROM DUAL
                WHERE an_cid = 0) LOOP
     IF nvl(at_er (i),0) <> cn_rndend THEN   --Если признак неполноты пакета
      IF an_typeoffunc IN (cn_tf_ins, cn_tf_rep) THEN
       SELECT COUNT (*)
         INTO ln_exists
         FROM DUAL
        WHERE EXISTS (
               SELECT mid
                 FROM halfhourtmp
                WHERE mid = lc.mid AND date_time = at_datetime (i)
               UNION ALL
               SELECT mid
                 FROM halfhour
                WHERE mid = lc.mid AND date_time >= at_datetime (i) - 1 / 24 AND date_time <= at_datetime (i) + 1 / 24
                      AND util_pg.to_unlocaltime (date_time, nsource) = at_datetime (i) AND NOT (nsource BETWEEN 30 AND 49));

       IF ln_exists = 1 THEN
        IF an_typeoffunc = cn_tf_ins THEN
         ROLLBACK;
         RETURN cn_err_dataaccess;
        ELSIF an_typeoffunc = cn_tf_rep THEN
         GOTO to_continue;
        END IF;
       END IF;

       ln_er := ROUND (at_er (i), cn_rn);
       ln_ed := ROUND (at_ed (i), cn_rn);
       ln_q1 := ROUND (at_q1 (i), cn_rn);
       ln_q3 := ROUND (at_q3 (i), cn_rn);
       util_pg.chdr (lc.mid, ln_er, ln_ed, ln_q1, ln_q3);
       das_pg.ins_halfhourtmp (lc.mid, at_datetime (i), NULL, ln_er, ln_ed, ln_q1, ln_q3, NULL, NULL, NULL, comsrv_pg.cn_iccp, at_qm (i));
      END IF;
     END IF;

     IF ln_mid <> lc.mid THEN
      ln_mid := lc.mid;
      admin_pg.ins_last_save (lc.mid);
     END IF;

     --Если неполнота пакета (at_er (i)=cn_rndend) мы обновляем last_save.halfhour всегда
     UPDATE last_save
        SET halfhour =
             DECODE (at_er (i),
                     cn_rndend, LEAST (NVL (halfhour, at_datetime (i) - 1 / 48), at_datetime (i) - 1 / 48),
                     GREATEST (NVL (halfhour, at_datetime (i)), at_datetime (i))
                    ),
            state_date = ld_sys,
            state_cod = 0,
            clock = 0
      WHERE mid = lc.mid;

     <<to_continue>>
     NULL;
    END LOOP;
   END LOOP;
  ELSIF an_typeofquery = cn_qt_currentdata THEN   --Текущие
   FOR i IN 1 .. an_size LOOP
    ln_mid := TRUNC (at_id (i) / cn_id_shift);
    ln_type := MOD (at_id (i), cn_id_shift);

    FOR lc IN (SELECT c.mid, f.nswitch
                 FROM chanpoint c, feeders f
                WHERE c.cid = an_cid AND c.mid = f.mid(+) AND f.canal = ln_mid
               UNION ALL
               SELECT at_id (i) mid, 0 nswitch
                 FROM DUAL
                WHERE an_cid = 0) LOOP
     admin_pg.ins_last_save (lc.mid);

     IF nvl(at_er (i),0) <> cn_rndend THEN   --Если признак неполноты пакета
--На вход Метка времени зима ()
      FOR lc1 IN (SELECT DECODE (ln_type, cn_mt_er, at_er (i), util_pg.cn_random) er, DECODE (ln_type, cn_mt_ed, at_er (i), util_pg.cn_random) ed,
                         DECODE (ln_type, cn_mt_rr, at_er (i), util_pg.cn_random) q1, DECODE (ln_type, cn_mt_rd, at_er (i), util_pg.cn_random) q3
                    FROM DUAL) LOOP
       ln_er := lc1.er;
       ln_ed := lc1.ed;
       ln_q1 := lc1.q1;
       ln_q3 := lc1.q3;
       util_pg.chdr (lc.mid, ln_er, ln_ed, ln_q1, ln_q3);
       calcformula_pg.ins_halfhouroldw (lc.mid, at_datetime (i), ln_er, ln_ed, ln_q1, ln_q3, NULL, NULL, NULL, comsrv_pg.cn_iccp, at_qm (i), lc.nswitch, NULL, NULL,
                                        1);
      END LOOP;
     END IF;

     UPDATE last_save
        SET halfhour =
             DECODE (at_er (i),
                     cn_rndend, LEAST (NVL (halfhour, at_datetime (i) - 1 / 48), at_datetime (i) - 1 / 48),
                     GREATEST (NVL (halfhour, at_datetime (i)), at_datetime (i))
                    ),
            state_date = SYSDATE,
            state_cod = 0,
            clock = 0
      WHERE mid = lc.mid;
    END LOOP;
   END LOOP;
  ELSIF an_typeofquery = cn_qt_xmldayvalues THEN   --Суточные
   FOR i IN 1 .. an_size LOOP
    FOR lc IN (SELECT c.mid
                 FROM chanpoint c, feeders f
                WHERE c.cid = an_cid AND c.mid = f.mid(+) AND f.canal = at_id (i)
               UNION ALL
               SELECT at_id (i) mid
                 FROM DUAL
                WHERE an_cid = 0) LOOP
     IF an_typeoffunc IN (cn_tf_ins, cn_tf_rep) THEN
      SELECT COUNT (*)
        INTO ln_exists
        FROM DUAL
       WHERE EXISTS (SELECT mid
                       FROM billorg
                      WHERE mid = lc.mid AND date_time = at_datetime (i));

      IF ln_exists = 1 THEN
       IF an_typeoffunc = cn_tf_ins THEN
        ROLLBACK;
        RETURN cn_err_dataaccess;
       ELSIF an_typeoffunc = cn_tf_rep THEN
        GOTO to_continue;
       END IF;
      END IF;
     END IF;

     comsrv_pg.set_bill_meter (lc.mid, at_er (i), at_ed (i), at_q1 (i), at_q3 (i), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
                               NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ICCP', NULL, at_datetime (i));

     IF ln_mid <> lc.mid THEN
      ln_mid := lc.mid;
      admin_pg.ins_last_save (lc.mid);
     END IF;

     UPDATE last_save
        SET bill = GREATEST (NVL (bill, at_datetime (i)), at_datetime (i))
      WHERE mid = lc.mid;

     <<to_continue>>
     NULL;
    END LOOP;
   END LOOP;
  ELSE
   RETURN cn_err_badarg;
  END IF;

  COMMIT;

  IF an_typeofquery IN (cn_qt_hourdata, cn_qt_currentdata) THEN
   das_pg.checkhalfhour_without_err;
   COMMIT;
  END IF;

  RETURN cn_err_ok;
 EXCEPTION
  WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
 END;

------------------------------------------------------------------------------------------------------------------------
 -- Вставка (замена) данных
 FUNCTION sync_insert_replace (an_typeofquery NUMBER,   -- 0-NOTUSED, 1-CURRENTDATA, 2-MINUTEDATA, 3-HOURDATA, 4-DAYDATA, 5-MONTHDATA, 6-INSTANTDATA
                                                     an_cid NUMBER,   -- Объект , с которого дадо получить информацию (channels.cid)
                                                                   an_size NUMBER,   -- размер at_id
                                                                                  at_id common_pg.tt_number,   -- массив id
                                                                                                            at_datetime common_pg.tt_date,   -- массив меток времени
 at_er common_pg.tt_number,   --массив значений
                           at_ed common_pg.tt_number,   --массив значений
                                                     at_q1 common_pg.tt_number,   --массив значений
                                                                               at_q3 common_pg.tt_number,   --массив значений
                                                                                                         at_validity common_pg.tt_number,   --массив достовернрости
 at_quality common_pg.tt_number,   --массив меток качества
                                at_source common_pg.tt_number
 )
  RETURN NUMBER IS
  lt_qm   common_pg.tt_varchar2;
 BEGIN
  FOR i IN 1 .. an_size LOOP
   lt_qm (i) := create_qm_from_old_format (at_validity (i), at_quality (i), at_source (i));
  END LOOP;

  RETURN sync_insert_replace (an_typeofquery, an_cid, an_size, at_id, at_datetime, at_er, at_ed, at_q1, at_q3, lt_qm);
 END;

------------------------------------------------------------------------------------------------------------------------
 -- Вставка (замена) данных
 FUNCTION sync_insert_replace (an_typeofquery NUMBER,   -- 0-NOTUSED, 1-CURRENTDATA, 2-MINUTEDATA, 3-HOURDATA, 4-DAYDATA, 5-MONTHDATA, 6-INSTANTDATA
                                                     an_cid NUMBER,   -- Объект , с которого дадо получить информацию (channels.cid)
                                                                   an_size NUMBER,   -- размер at_id
                                                                                  at_id common_pg.tt_number,   -- массив id
                                                                                                            at_datetime common_pg.tt_date,   -- массив меток времени
 at_er common_pg.tt_number,   --массив значений
                           at_ed common_pg.tt_number,   --массив значений
                                                     at_q1 common_pg.tt_number,   --массив значений
                                                                               at_q3 common_pg.tt_number,   --массив значений
 at_qm common_pg.tt_varchar2   --массив меток качества
 )
  RETURN NUMBER IS
 BEGIN
  RETURN sync_insert_replace_base (cn_tf_insrep, an_typeofquery, an_cid, an_size, at_id, at_datetime, at_er, at_ed, at_q1, at_q3, at_qm);
 END;

------------------------------------------------------------------------------------------------------------------------
   -- Вставка данных
 FUNCTION sync_insert (an_typeofquery NUMBER,   -- 0-NOTUSED, 1-CURRENTDATA, 2-MINUTEDATA, 3-HOURDATA, 4-DAYDATA, 5-MONTHDATA, 6-INSTANTDATA
                                             an_cid NUMBER,   -- Объект , с которого дадо получить информацию (channels.cid)
                                                           an_size NUMBER,   -- размер at_id
                                                                          at_id common_pg.tt_number,   -- массив id
                                                                                                    at_datetime common_pg.tt_date,   -- массив меток времени
 at_er common_pg.tt_number,   --массив значений
                           at_ed common_pg.tt_number,   --массив значений
                                                     at_q1 common_pg.tt_number,   --массив значений
                                                                               at_q3 common_pg.tt_number,   --массив значений
                                                                                                         at_validity common_pg.tt_number,   --массив достовернрости
 at_quality common_pg.tt_number,   --массив меток качества
                                at_source common_pg.tt_number
 )   --массив источников
  RETURN NUMBER IS
  lt_qm   common_pg.tt_varchar2;
 BEGIN
  FOR i IN 1 .. an_size LOOP
   lt_qm (i) := create_qm_from_old_format (at_validity (i), at_quality (i), at_source (i));
  END LOOP;

  RETURN sync_insert (an_typeofquery, an_cid, an_size, at_id, at_datetime, at_er, at_ed, at_q1, at_q3, lt_qm);
 END;

------------------------------------------------------------------------------------------------------------------------
   -- Вставка данных
 FUNCTION sync_insert (an_typeofquery NUMBER,   -- 0-NOTUSED, 1-CURRENTDATA, 2-MINUTEDATA, 3-HOURDATA, 4-DAYDATA, 5-MONTHDATA, 6-INSTANTDATA
                                             an_cid NUMBER,   -- Объект , с которого дадо получить информацию (channels.cid)
                                                           an_size NUMBER,   -- размер at_id
                                                                          at_id common_pg.tt_number,   -- массив id
                                                                                                    at_datetime common_pg.tt_date,   -- массив меток времени
 at_er common_pg.tt_number,   --массив значений
                           at_ed common_pg.tt_number,   --массив значений
                                                     at_q1 common_pg.tt_number,   --массив значений
                                                                               at_q3 common_pg.tt_number,   --массив значений
 at_qm common_pg.tt_varchar2   --массив меток качества
 )   --массив источников
  RETURN NUMBER IS
 BEGIN
  RETURN sync_insert_replace_base (cn_tf_ins, an_typeofquery, an_cid, an_size, at_id, at_datetime, at_er, at_ed, at_q1, at_q3, at_qm);
 END;

------------------------------------------------------------------------------------------------------------------------
    -- Замена данных
 FUNCTION sync_replace (an_typeofquery NUMBER,   -- 0-NOTUSED, 1-CURRENTDATA, 2-MINUTEDATA, 3-HOURDATA, 4-DAYDATA, 5-MONTHDATA, 6-INSTANTDATA
                                              an_cid NUMBER,   -- Объект , на который дадо получить информацию (channels.cid)
                                                            an_size NUMBER,   -- размер at_id
                                                                           at_id common_pg.tt_number,   -- массив id
                                                                                                     at_datetime common_pg.tt_date,   -- массив меток времени
 at_er common_pg.tt_number,   --массив значений
                           at_ed common_pg.tt_number,   --массив значений
                                                     at_q1 common_pg.tt_number,   --массив значений
                                                                               at_q3 common_pg.tt_number,   --массив значений
                                                                                                         at_validity common_pg.tt_number,   --массив достовернрости
 at_quality common_pg.tt_number,   --массив меток качества
                                at_source common_pg.tt_number
 )   --массив источников
  RETURN NUMBER IS
  lt_qm   common_pg.tt_varchar2;
 BEGIN
  FOR i IN 1 .. an_size LOOP
   lt_qm (i) := create_qm_from_old_format (at_validity (i), at_quality (i), at_source (i));
  END LOOP;

  RETURN sync_replace (an_typeofquery, an_cid, an_size, at_id, at_datetime, at_er, at_ed, at_q1, at_q3, lt_qm);
 END;

------------------------------------------------------------------------------------------------------------------------
    -- Замена данных
 FUNCTION sync_replace (an_typeofquery NUMBER,   -- 0-NOTUSED, 1-CURRENTDATA, 2-MINUTEDATA, 3-HOURDATA, 4-DAYDATA, 5-MONTHDATA, 6-INSTANTDATA
                                              an_cid NUMBER,   -- Объект , на который дадо получить информацию (channels.cid)
                                                            an_size NUMBER,   -- размер at_id
                                                                           at_id common_pg.tt_number,   -- массив id
                                                                                                     at_datetime common_pg.tt_date,   -- массив меток времени
 at_er common_pg.tt_number,   --массив значений
                           at_ed common_pg.tt_number,   --массив значений
                                                     at_q1 common_pg.tt_number,   --массив значений
                                                                               at_q3 common_pg.tt_number,   --массив значений
 at_qm common_pg.tt_varchar2   --массив меток качества
 )   --массив источников
  RETURN NUMBER IS
 BEGIN
  RETURN sync_insert_replace_base (cn_tf_rep, an_typeofquery, an_cid, an_size, at_id, at_datetime, at_er, at_ed, at_q1, at_q3, at_qm);
 END;

------------------------------------------------------------------------------------------------------------------------
      -- Удаление данных
 FUNCTION sync_delete_raw (an_typeofquery NUMBER,   -- 0-NOTUSED, 1-CURRENTDATA, 2-MINUTEDATA, 3-HOURDATA, 4-DAYDATA, 5-MONTHDATA, 6-INSTANTDATA
                                                 an_cid NUMBER,   -- Объект , с которого дадо получить информацию (channels.cid)
                                                               an_size NUMBER,   -- размер at_id
                                                                              at_id common_pg.tt_number,   -- массив id
 at_datetime common_pg.tt_date   -- массив меток времени
 )
  RETURN NUMBER IS
  ln_id        NUMBER;
  ln_mestype   NUMBER;
 BEGIN
  IF an_typeofquery = cn_qt_hourdata THEN
   FOR i IN 1 .. an_size LOOP
    DELETE FROM halfhour
          WHERE mid = (SELECT MAX (c.mid)
                         FROM chanpoint c, feeders f
                        WHERE c.cid = an_cid AND c.mid = f.mid AND f.canal = at_id (i)) AND date_time >= at_datetime (i) - 1 / 24
                AND date_time <= at_datetime (i) + 1 / 24 AND util_pg.to_unlocaltime (date_time, nsource) = at_datetime (i);
   END LOOP;
  END IF;

  RETURN cn_err_ok;
 END;

------------------------------------------------------------------------------------------------------------------------
--------------  Сервер (Львов)  ----------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
   -- Чтение данных
 FUNCTION sync_read_raw (at_names common_pg.tt_varchar2,   -- массив mRid запрашиваемых параметров, которых надо найти
                                                        at_ids common_pg.tt_number,   -- массив id запрашиваемых параметров
                                                                                   an_paramcount NUMBER,   -- кол. входных и выходных параметров
                                                                                                        an_typeofquery NUMBER,   -- 0-NOTUSED, 1-CURRENTDATA, 2-MINUTEDATA, 3-HOURDATA, 4-DAYDATA, 5-MONTHDATA, 6-INSTANTDATA
 ad_timebegin DATE,   --дата с
                   ad_timeend DATE,   --дата по
                                   an_beginfrom NUMBER,   --Стартовать с такого
                                                       an_count IN OUT NUMBER,   -- макс количество возвращ значений (ДАТ)
                                                                              at_id OUT common_pg.tt_number,   -- массив id
                                                                                                            at_datetime OUT common_pg.tt_date,   -- массив меток времени
 at_er OUT common_pg.tt_number,   --массив значений
                               at_ed OUT common_pg.tt_number,   --массив значений
                                                             at_q1 OUT common_pg.tt_number,   --массив значений
                                                                                           at_q3 OUT common_pg.tt_number,   --массив значений
 at_validity OUT common_pg.tt_number,   --массив достовернрости
                                     at_quality OUT common_pg.tt_number,   --массив меток качества
                                                                        at_source OUT common_pg.tt_number
 )   --массив источников
  RETURN NUMBER IS
  lt_qm   common_pg.tt_varchar2;
 BEGIN
  RETURN sync_read_raw (at_names, at_ids, an_paramcount, an_typeofquery, ad_timebegin, ad_timeend, NULL, an_beginfrom, an_count, at_id, at_datetime, at_er, at_ed,
                        at_q1, at_q3, at_validity, at_quality, at_source, lt_qm);
 END;

------------------------------------------------------------------------------------------------------------------------
   -- Чтение данных
 FUNCTION sync_read_raw (at_names common_pg.tt_varchar2,   -- массив mRid запрашиваемых параметров, которых надо найти
                                                        at_ids common_pg.tt_number,   -- массив id запрашиваемых параметров
                                                                                   an_paramcount NUMBER,   -- кол. входных и выходных параметров
                                                                                                        an_typeofquery NUMBER,   -- 0-NOTUSED, 1-CURRENTDATA, 2-MINUTEDATA, 3-HOURDATA, 4-DAYDATA, 5-MONTHDATA, 6-INSTANTDATA
 ad_timebegin DATE,   --дата с
                   ad_timeend DATE,   --дата по
                                   ad_change DATE,   -- дата последних изменений (показания появившиеся с)
                                                  an_beginfrom NUMBER,   --Стартовать с такого
                                                                      an_count IN OUT NUMBER,   -- макс количество возвращ значений (ДАТ)
                                                                                             at_id OUT common_pg.tt_number,   -- массив id
 at_datetime OUT common_pg.tt_date,   -- массив меток времени
                                   at_er OUT common_pg.tt_number,   --массив значений
                                                                 at_ed OUT common_pg.tt_number,   --массив значений
                                                                                               at_q1 OUT common_pg.tt_number,   --массив значений
 at_q3 OUT common_pg.tt_number,   --массив значений
                               at_qm OUT common_pg.tt_varchar2   --массив меток качества
 )
  RETURN NUMBER IS
  at_validity   common_pg.tt_number;
  at_quality    common_pg.tt_number;
  at_source     common_pg.tt_number;
 BEGIN
  RETURN sync_read_raw (at_names, at_ids, an_paramcount, an_typeofquery, ad_timebegin, ad_timeend, ad_change, an_beginfrom, an_count, at_id, at_datetime, at_er,
                        at_ed, at_q1, at_q3, at_validity, at_quality, at_source, at_qm);
 END;

------------------------------------------------------------------------------------------------------------------------
   -- Чтение данных
 FUNCTION sync_read_raw (at_names common_pg.tt_varchar2,   -- массив mRid запрашиваемых параметров, которых надо найти
                                                        at_ids common_pg.tt_number,   -- массив id запрашиваемых параметров
                                                                                   an_paramcount NUMBER,   -- кол. входных параметров
                                                                                                        an_typeofquery NUMBER,   -- 0-NOTUSED, 1-CURRENTDATA, 2-MINUTEDATA, 3-HOURDATA, 4-DAYDATA, 5-MONTHDATA, 6-INSTANTDATA
 ad_timebegin DATE,   --дата с
                   ad_timeend DATE,   --дата по
                                   ad_change DATE,   -- дата последних изменений (показания появившиеся с)
                                                  an_beginfrom NUMBER,   --Стартовать с такого
                                                                      an_count IN OUT NUMBER,   -- макс количество массива at_id
                                                                                             at_id OUT common_pg.tt_number,   -- массив id
 at_datetime OUT common_pg.tt_date,   -- массив меток времени
                                   at_er OUT common_pg.tt_number,   --массив значений
                                                                 at_ed OUT common_pg.tt_number,   --массив значений
                                                                                               at_q1 OUT common_pg.tt_number,   --массив значений
 at_q3 OUT common_pg.tt_number,   --массив достовернрости
                               at_validity OUT common_pg.tt_number,   --массив значений
                                                                   at_quality OUT common_pg.tt_number,   --массив меток качества
                                                                                                      at_source OUT common_pg.tt_number,   --массив источников
 at_qm OUT common_pg.tt_varchar2   --массив меток качества
 )
  RETURN NUMBER IS
  cr_sel                 common_pg.tcur;
  cn_max        CONSTANT NUMBER         DEFAULT 266;
  cn_wd_shift   CONSTANT NUMBER         DEFAULT 4 / 24;
  ln_cnt                 NUMBER         DEFAULT 0;
  lr_tmp                 titemvalue;
  lr_tmp1                titemvalue;
  ln_size                NUMBER         DEFAULT an_count;
  ld_sys                 DATE;
  ld_tmp                 DATE;
  ln_mid                 NUMBER;
  ln_measure             NUMBER;
  ld_change              DATE           DEFAULT ad_change;
  lb_exit                BOOLEAN;
  lv_timebegin           VARCHAR2 (32)  := TO_CHAR (ad_timebegin, 'dd.mm.yyyy hh24:mi:ss');
  lv_timeend             VARCHAR2 (32)  := TO_CHAR (ad_timeend, 'dd.mm.yyyy hh24:mi:ss');
 BEGIN
  an_count := 0;

  IF TO_CHAR (ld_change, 'YYYY') < 2001 THEN
   ld_change := NULL;
  END IF;

  IF NVL (an_beginfrom, 0) < 1 OR NVL (ln_size, 0) < 1 THEN
   RETURN cn_err_badarg;
  END IF;

  IF an_beginfrom = 1 THEN
   gt_read_raw.DELETE;

   IF an_typeofquery IN (cn_qt_hourdata, cn_qt_minutedata, cn_qt_daydata, cn_qt_monthdata, cn_qt_instantdata) THEN   --30 минутки
    FOR i IN 1 .. an_paramcount LOOP
     IF at_ids (1) > 0 THEN   --Работаем по ИД (проверка по перврму элементу)
      ln_mid := at_ids (i);
      ln_measure := 0;
     ELSE
      SELECT MAX (mid), MAX (nmeasure)
        INTO ln_mid, ln_measure
        FROM mrids
       WHERE mrid = TRIM (util_pg.get_param (at_names (i), 1));
     END IF;

     lr_tmp := get_def_titemvalue;
     lb_exit := FALSE;

     IF an_typeofquery = cn_qt_hourdata AND ln_measure <= 10 THEN
      IF ld_change IS NULL THEN   --Если ld_change IS NULL THEN   Работаем по старому без подтяжки вновь поступивших данных
       OPEN cr_sel FOR 'SELECT   util_pg.to_unlocaltime (date_time, nsource) dat, er, ed, util_pg.sumn (q1, q2) q1, util_pg.sumn (q3, q4) q3, vqm FROM halfhour WHERE mid ='
                       || ln_mid || ' AND date_time > to_date(''' || lv_timebegin
                       || ''',''dd.mm.yyyy hh24:mi:ss'') - 1 / 24 AND util_pg.to_unlocaltime (date_time, nsource) > to_date(''' || lv_timebegin
                       || ''',''dd.mm.yyyy hh24:mi:ss'') AND date_time <= to_date(''' || lv_timeend
                       || ''',''dd.mm.yyyy hh24:mi:ss'') + 1 / 24 AND util_pg.to_unlocaltime (date_time, nsource) <= to_date(''' || lv_timeend
                       || ''',''dd.mm.yyyy hh24:mi:ss'') ORDER BY 1';
      ELSE
       OPEN cr_sel FOR 'SELECT   util_pg.to_unlocaltime (date_time, nsource) dat, er, ed, util_pg.sumn (q1, q2) q1, util_pg.sumn (q3, q4) q3, vqm FROM halfhour WHERE mid = '
                       || ln_mid || ' AND date_time IN (SELECT date_time FROM halfhourold WHERE mid = ' || ln_mid || ' AND date_time > to_date(''' || lv_timebegin
                       || ''',''dd.mm.yyyy hh24:mi:ss'') - 1 / 24 AND util_pg.to_unlocaltime (date_time, nsource) > to_date(''' || lv_timebegin
                       || ''',''dd.mm.yyyy hh24:mi:ss'') AND date_time <= to_date(''' || lv_timeend
                       || ''',''dd.mm.yyyy hh24:mi:ss'') + 1 / 24 AND util_pg.to_unlocaltime (date_time, nsource) <= to_date(''' || lv_timeend
                       || ''',''dd.mm.yyyy hh24:mi:ss'')
                              UNION ALL
                              SELECT date_time FROM halfhourold WHERE mid = '
                       || ln_mid || ' AND denter > to_date(''' || TO_CHAR (ld_change, 'dd.mm.yyyy hh24:mi:ss') || ''',''dd.mm.yyyy hh24:mi:ss'') - '
                       || cv_enter_shift || ') ORDER BY 1';
      END IF;
     ELSIF an_typeofquery = cn_qt_hourdata AND ln_measure BETWEEN 71 AND 76 THEN
      OPEN cr_sel FOR 'SELECT   date_time dat, erm er, edm ed, util_pg.sumn (q1m, q2m) q1, util_pg.sumn (q3m, q4m) q3, qm_pg.okqm vqm FROM billorg WHERE mid ='
                      || ln_mid || ' AND date_time > to_date(''' || lv_timebegin || ''',''dd.mm.yyyy hh24:mi:ss'') AND date_time <= to_date(''' || lv_timeend
                      || ''',''dd.mm.yyyy hh24:mi:ss'') ORDER BY 1';
     ELSIF an_typeofquery = cn_qt_minutedata THEN
      OPEN cr_sel FOR 'SELECT   util_pg.to_unlocaltime (date_time, nsource) dat, er, ed, util_pg.sumn (q1, q2) q1, util_pg.sumn (q3, q4) q3, vqm FROM profile WHERE mid ='
                      || ln_mid || ' AND date_time > to_date(''' || lv_timebegin
                      || ''',''dd.mm.yyyy hh24:mi:ss'') - 1 / 24 AND util_pg.to_unlocaltime (date_time, nsource) > to_date(''' || lv_timebegin
                      || ''',''dd.mm.yyyy hh24:mi:ss'') AND date_time <= to_date(''' || lv_timeend
                      || ''',''dd.mm.yyyy hh24:mi:ss'') + 1 / 24 AND util_pg.to_unlocaltime (date_time, nsource) <= to_date(''' || lv_timeend
                      || ''',''dd.mm.yyyy hh24:mi:ss'') ORDER BY 1';
     ELSIF an_typeofquery = cn_qt_daydata THEN
      OPEN cr_sel FOR 'SELECT   date_time dat, er, ed, util_pg.sumn (q1, q2) q1, util_pg.sumn (q3, q4) q3, vqm FROM bill WHERE mid =' || ln_mid
                      || ' AND date_time > trunc(to_date(''' || lv_timebegin || ''',''dd.mm.yyyy hh24:mi:ss'')) AND date_time <= trunc(to_date(''' || lv_timeend
                      || ''',''dd.mm.yyyy hh24:mi:ss'')-1/86400)+1 ORDER BY 1';
     ELSIF an_typeofquery = cn_qt_monthdata THEN
      OPEN cr_sel FOR 'SELECT   add_months(trunc(date_time-1/86400,''month''),1) dat, sum(er) er, sum(ed) ed, sum(util_pg.sumn (q1, q2)) q1, sum(util_pg.sumn (q3, q4)) q3, sumqm(vqm) vqm FROM bill WHERE mid ='
                      || ln_mid || ' AND date_time > trunc(to_date(''' || lv_timebegin
                      || ''',''dd.mm.yyyy hh24:mi:ss''),''month'') AND date_time <= add_months(trunc(to_date(''' || lv_timeend
                      || ''',''dd.mm.yyyy hh24:mi:ss'')-1/86400,''month''),1) group by trunc(date_time-1/86400,''month'') ORDER BY 1';
     ELSIF an_typeofquery = cn_qt_instantdata THEN
      OPEN cr_sel FOR 'SELECT   date_time dat, er, ed, util_pg.sumn (q1, q2) q1, util_pg.sumn (q3, q4) q3,qm_pg.okqm vqm FROM curr_power_arch WHERE mid =' || ln_mid
                      || ' AND date_time > to_date(''' || lv_timebegin || ''',''dd.mm.yyyy hh24:mi:ss'') AND date_time <= to_date(''' || lv_timeend
                      || ''',''dd.mm.yyyy hh24:mi:ss'') ORDER BY 1';
     ELSE
      RETURN cn_err_badarg;
     END IF;

     LOOP
      FETCH cr_sel
       INTO lr_tmp1.dat, lr_tmp1.er, lr_tmp1.ed, lr_tmp1.q1, lr_tmp1.q3, lr_tmp1.qm;

      EXIT WHEN cr_sel%NOTFOUND;

      IF lr_tmp.dat = lr_tmp1.dat AND lr_tmp.ID = ln_mid THEN   --Для одной метки времени складываем (например ОВ)
       lr_tmp.er := util_pg.sumn (lr_tmp.er, lr_tmp1.er);
       lr_tmp.ed := util_pg.sumn (lr_tmp.ed, lr_tmp1.ed);
       lr_tmp.q1 := util_pg.sumn (lr_tmp.q1, lr_tmp1.q1);
       lr_tmp.q3 := util_pg.sumn (lr_tmp.q3, lr_tmp1.q3);
       lr_tmp.qm := qm_pg.sumqm (lr_tmp.qm, lr_tmp1.qm);
       gt_read_raw (ln_cnt) := lr_tmp;
      ELSE
       IF lb_exit THEN
        EXIT;
       END IF;

       ln_cnt := ln_cnt + 1;
       lr_tmp.ID := ln_mid;
       lr_tmp.dat := lr_tmp1.dat;
       lr_tmp.er := lr_tmp1.er;
       lr_tmp.ed := lr_tmp1.ed;
       lr_tmp.q1 := lr_tmp1.q1;
       lr_tmp.q3 := lr_tmp1.q3;
       lr_tmp.qm := lr_tmp1.qm;
       gt_read_raw (ln_cnt) := lr_tmp;

       IF ln_cnt >= cn_max THEN
        lb_exit := TRUE;
       END IF;
      END IF;
     END LOOP;

     CLOSE cr_sel;

     IF ln_cnt >= cn_max THEN
      EXIT;
     END IF;
    END LOOP;
   ELSIF an_typeofquery = cn_qt_currentdata THEN   --Текущие
    ld_sys := util_pg.trunc_d (SYSDATE, cn_hh_shift);

    FOR i IN 1 .. an_paramcount LOOP
     ln_mid := TRUNC (at_ids (i) / cn_id_shift);

     SELECT util_pg.trunc_d (MAX (util_pg.to_unlocaltime (date_time, nsource)), cn_hh_shift)
       INTO ld_tmp
       FROM halfhour
      WHERE mid = ln_mid AND date_time > ld_sys - cn_wd_shift AND date_time <= ld_sys + 1 / 24
            AND (er IS NOT NULL OR ed IS NOT NULL OR q1 IS NOT NULL OR q2 IS NOT NULL OR q3 IS NOT NULL OR q4 IS NOT NULL);

     IF ld_tmp IS NOT NULL THEN
      lr_tmp := get_def_titemvalue;
      lr_tmp.ID := at_ids (i);
      lr_tmp.dat := ld_tmp;

      SELECT SUM (DECODE (MOD (at_ids (i), cn_id_shift), cn_mt_er, er, cn_mt_ed, ed, cn_mt_rr, util_pg.sumn (q1, q2), cn_mt_rd, util_pg.sumn (q3, q4))), sumqm (vqm)
        INTO lr_tmp.er, lr_tmp.qm
        FROM halfhour
       WHERE mid = ln_mid AND date_time > (ld_tmp - 1 / 24) - cn_hh_shift AND date_time <= ld_tmp + 1 / 24
             AND util_pg.to_unlocaltime (date_time, nsource) > ld_tmp - cn_hh_shift AND util_pg.to_unlocaltime (date_time, nsource) <= ld_tmp;

      ln_cnt := ln_cnt + 1;
      gt_read_raw (ln_cnt) := lr_tmp;
     END IF;
    END LOOP;
   ELSE   --Не написали
    RETURN cn_err_badarg;
   END IF;
  END IF;

  WHILE an_count + 1 <= ln_size AND an_beginfrom + an_count <= gt_read_raw.COUNT LOOP
   an_count := an_count + 1;
   lr_tmp := gt_read_raw (an_beginfrom + an_count - 1);
   at_id (an_count) := lr_tmp.ID;
   at_datetime (an_count) := lr_tmp.dat;
   at_er (an_count) := lr_tmp.er;
   at_ed (an_count) := lr_tmp.ed;
   at_q1 (an_count) := lr_tmp.q1;
   at_q3 (an_count) := lr_tmp.q3;
   at_validity (an_count) := lr_tmp.v;
   at_quality (an_count) := lr_tmp.q;
   at_source (an_count) := lr_tmp.s;
   at_qm (an_count) := NVL (lr_tmp.qm, qm_pg.defqm);
  END LOOP;

  COMMIT;

  IF an_count < ln_size THEN   --Очистка памяти
   gt_read_raw.DELETE;
  END IF;

  RETURN cn_err_ok;
 END;

------------------------------------------------------------------------------------------------------------------------
  -- Получение массива ID и меток времени последних сохраненных данных ГН
 FUNCTION get_clnt_last_save_hh (an_cid NUMBER,   -- Объект , с которого дадо получить информацию (channels.cid)
                                               an_beginfrom NUMBER,   --Стартовать с такого
                                                                   an_count IN OUT NUMBER,   --Требуемый и возвращаемый объем щбъем выборки
 at_ids OUT common_pg.tt_number,   -- массив id найденных параметров
                                at_lastdate OUT common_pg.tt_date,   -- массив дат найденных параметров
 at_lastchange OUT common_pg.tt_date   -- массив дат найденных параметров
 )
  RETURN NUMBER IS
 BEGIN
  RETURN get_last_save (cn_qt_hourdata, an_cid, an_beginfrom, an_count, at_ids, at_lastdate, at_lastchange);
 END;

------------------------------------------------------------------------------------------------------------------------
  -- Получение массива ID и меток времени последних сохраненных данных Показаний
 FUNCTION get_clnt_last_save_d (an_cid NUMBER,   -- Объект , с которого дадо получить информацию (channels.cid)
                                              an_beginfrom NUMBER,   --Стартовать с такого
                                                                  an_count IN OUT NUMBER,   --Требуемый и возвращаемый объем щбъем выборки
 at_ids OUT common_pg.tt_number,   -- массив id найденных параметров
                                at_lastdate OUT common_pg.tt_date   -- массив дат найденных параметров
 )
  RETURN NUMBER IS
  lt_lastchange   common_pg.tt_date;
 BEGIN
  RETURN get_last_save (cn_qt_daydata, an_cid, an_beginfrom, an_count, at_ids, at_lastdate, lt_lastchange);
 END;

------------------------------------------------------------------------------------------------------------------------
  -- Получение массива ID и меток времени последних сохраненных данных Журнала
 FUNCTION get_clnt_last_save_j (an_cid NUMBER,   -- Объект , с которого дадо получить информацию (channels.cid)
                                              an_beginfrom NUMBER,   --Стартовать с такого
                                                                  an_count IN OUT NUMBER,   --Требуемый и возвращаемый объем щбъем выборки
 at_ids OUT common_pg.tt_number,   -- массив id найденных параметров
                                at_lastdate OUT common_pg.tt_date   -- массив дат найденных параметров
 )
  RETURN NUMBER IS
  lt_lastchange   common_pg.tt_date;
 BEGIN
  RETURN get_last_save (cn_qt_journal, an_cid, an_beginfrom, an_count, at_ids, at_lastdate, lt_lastchange);
 END;

------------------------------------------------------------------------------------------------------------------------
    -- Вставка (замена) данных ГН
 FUNCTION set_clnt_hh (an_cid NUMBER,   -- Объект , с которого дадо получить информацию (channels.cid)
                                     an_size NUMBER,   --Кол элеменотов массивов
                                                    at_id common_pg.tt_number,   -- массив id
                                                                              at_datetime common_pg.tt_date,   -- массив меток времени
                                                                                                            at_er common_pg.tt_number,   --массив значений
 at_ed common_pg.tt_number,   --массив значений
                           at_q1 common_pg.tt_number,   --массив значений
                                                     at_q3 common_pg.tt_number,   --массив значений
                                                                               at_qm common_pg.tt_varchar2   --массив меток качества
 )
  RETURN NUMBER IS
 BEGIN
  RETURN sync_insert_replace (cn_qt_hourdata, an_cid, an_size, at_id, at_datetime, at_er, at_ed, at_q1, at_q3, at_qm);
 END;

------------------------------------------------------------------------------------------------------------------------
     -- Вставка (замена) данных Суточные
 FUNCTION set_clnt_day (an_cid NUMBER,   -- Объект , с которого дадо получить информацию (channels.cid)
                                      an_size NUMBER,   --Кол элеменотов массивов
                                                     at_id common_pg.tt_number,   -- массив id
                                                                               at_datetime common_pg.tt_date,   -- массив меток времени
                                                                                                             at_er common_pg.tt_number, at_ed common_pg.tt_number,
 at_q1 common_pg.tt_number, at_q3 common_pg.tt_number, at_q2 common_pg.tt_number, at_q4 common_pg.tt_number, at_aer common_pg.tt_number, at_aed common_pg.tt_number,
 at_aq1 common_pg.tt_number, at_aq3 common_pg.tt_number, at_aq2 common_pg.tt_number, at_aq4 common_pg.tt_number, at_ber common_pg.tt_number,
 at_bed common_pg.tt_number, at_bq1 common_pg.tt_number, at_bq3 common_pg.tt_number, at_bq2 common_pg.tt_number, at_bq4 common_pg.tt_number,
 at_cer common_pg.tt_number, at_ced common_pg.tt_number, at_cq1 common_pg.tt_number, at_cq3 common_pg.tt_number, at_cq2 common_pg.tt_number,
 at_cq4 common_pg.tt_number, at_der common_pg.tt_number, at_ded common_pg.tt_number, at_dq1 common_pg.tt_number, at_dq3 common_pg.tt_number,
 at_dq2 common_pg.tt_number, at_dq4 common_pg.tt_number, at_erm common_pg.tt_number, at_edm common_pg.tt_number, at_q1m common_pg.tt_number,
 at_q3m common_pg.tt_number, at_q2m common_pg.tt_number, at_q4m common_pg.tt_number, at_aerm common_pg.tt_number, at_aedm common_pg.tt_number,
 at_aq1m common_pg.tt_number, at_aq3m common_pg.tt_number, at_aq2m common_pg.tt_number, at_aq4m common_pg.tt_number, at_berm common_pg.tt_number,
 at_bedm common_pg.tt_number, at_bq1m common_pg.tt_number, at_bq3m common_pg.tt_number, at_bq2m common_pg.tt_number, at_bq4m common_pg.tt_number,
 at_cerm common_pg.tt_number, at_cedm common_pg.tt_number, at_cq1m common_pg.tt_number, at_cq3m common_pg.tt_number, at_cq2m common_pg.tt_number,
 at_cq4m common_pg.tt_number, at_derm common_pg.tt_number, at_dedm common_pg.tt_number, at_dq1m common_pg.tt_number, at_dq3m common_pg.tt_number,
 at_dq2m common_pg.tt_number, at_dq4m common_pg.tt_number, at_mtrsn common_pg.tt_varchar2
 )
  RETURN NUMBER IS
  ln_mid   NUMBER DEFAULT 0;
  ln_tmp   NUMBER;
 BEGIN
  FOR i IN 1 .. an_size LOOP
   FOR lc IN (SELECT c.mid
                FROM chanpoint c, feeders f
               WHERE c.cid = an_cid AND c.mid = f.mid(+) AND f.canal = at_id (i)
              UNION ALL
              SELECT at_id (i) mid
                FROM DUAL
               WHERE an_cid = 0) LOOP
    comsrvdll_pg.set_bill_dllmtr (lc.mid, at_er (i), at_ed (i), at_q1 (i), at_q3 (i), at_q2 (i), at_q4 (i), at_aer (i), at_aed (i), at_aq1 (i), at_aq3 (i),
                                  at_aq2 (i), at_aq4 (i), at_ber (i), at_bed (i), at_bq1 (i), at_bq3 (i), at_bq2 (i), at_bq4 (i), at_cer (i), at_ced (i),
                                  at_cq1 (i), at_cq3 (i), at_cq2 (i), at_cq4 (i), at_der (i), at_ded (i), at_dq1 (i), at_dq3 (i), at_dq2 (i), at_dq4 (i),
                                  at_mtrsn (i), 12, at_datetime (i));
    comsrvdll_pg.set_bill_dllmtr_m (lc.mid, at_erm (i), at_edm (i), at_q1m (i), at_q3m (i), at_q2m (i), at_q4m (i), at_aerm (i), at_aedm (i), at_aq1m (i),
                                    at_aq3m (i), at_aq2m (i), at_aq4m (i), at_berm (i), at_bedm (i), at_bq1m (i), at_bq3m (i), at_bq2m (i), at_bq4m (i),
                                    at_cerm (i), at_cedm (i), at_cq1m (i), at_cq3m (i), at_cq2m (i), at_cq4m (i), at_derm (i), at_dedm (i), at_dq1m (i),
                                    at_dq3m (i), at_dq2m (i), at_dq4m (i), 12, at_datetime (i));

    IF ln_mid <> lc.mid THEN
     ln_mid := lc.mid;
     admin_pg.ins_last_save (lc.mid);
    END IF;

    UPDATE last_save
       SET bill = GREATEST (NVL (bill, at_datetime (i)), at_datetime (i))
     WHERE mid = lc.mid;
   END LOOP;
  END LOOP;

  COMMIT;
  RETURN cn_err_ok;
 EXCEPTION
  WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
 END;

------------------------------------------------------------------------------------------------------------------------
    -- Вставка (замена) данных Журнал
 FUNCTION set_clnt_journal (an_cid NUMBER,   -- Объект , с которого дадо получить информацию (channels.cid)
                                          an_size NUMBER,   --Кол элеменотов массивов
                                                         at_id common_pg.tt_number,   -- массив id
                                                                                   at_datetime common_pg.tt_date,   -- массив меток времени
 at_state_cod common_pg.tt_number,   --Массив типов событий
                                  at_state_descr common_pg.tt_varchar2,   --Массив событий
                                                                       at_code common_pg.tt_varchar2   --массив оригинальных кодов событий
 )
  RETURN NUMBER IS
  ln_mid   NUMBER DEFAULT 0;
  ln_tmp   NUMBER;
 BEGIN
  FOR i IN 1 .. an_size LOOP
   FOR lc IN (SELECT c.mid
                FROM chanpoint c, feeders f
               WHERE c.cid = an_cid AND c.mid = f.mid(+) AND f.canal = at_id (i)
              UNION ALL
              SELECT at_id (i) mid
                FROM DUAL
               WHERE an_cid = 0) LOOP
    ln_tmp := admin_pg.ins_journal_p (at_datetime (i), lc.mid, at_state_cod (i), at_state_descr (i), NULL, at_code (i));

    IF ln_tmp > 0 THEN
     IF ln_mid <> lc.mid THEN
      ln_mid := lc.mid;
      admin_pg.ins_last_save (lc.mid);
     END IF;

     UPDATE last_save
        SET journal = GREATEST (NVL (journal, at_datetime (i)), at_datetime (i))
      WHERE mid = lc.mid;
    END IF;
   END LOOP;
  END LOOP;

  COMMIT;
  RETURN cn_err_ok;
 EXCEPTION
  WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
 END;

------------------------------------------------------------------------------------------------------------------------
   -- Чтение данных ГН
 FUNCTION get_srv_hh (an_pointcnt NUMBER,   --Кол запрашиваемых точек
                                         at_ids common_pg.tt_number,   -- массив id запрашиваемых параметров
                                                                    at_date common_pg.tt_date,   --дата с
                                                                                              at_change common_pg.tt_date,   -- дата последних изменений (показания появившиеся с)
 an_count IN OUT NUMBER,   -- Длина масcива (На вход макс кол-во)
                        at_id OUT common_pg.tt_number,   -- массив id
                                                      at_datetime OUT common_pg.tt_date,   -- массив меток времени
                                                                                        at_er OUT common_pg.tt_number,   --массив значений
 at_ed OUT common_pg.tt_number,   --массив значений
                               at_q1 OUT common_pg.tt_number,   --массив значений
                                                             at_q3 OUT common_pg.tt_number,   --массив значений
                                                                                           at_qm OUT common_pg.tt_varchar2   --массив меток качества
 )
  RETURN NUMBER IS
  cr_sel          common_pg.tcur;
  lt_length       common_pg.tt_number;   --Количество строк данных, которые нужно передать
  lt_reallength   common_pg.tt_number;   --Реальное количество, которые можно передать
  lt_numlast      common_pg.tt_number;   --Номер последней записи
  lt_ret          ttitemvalue;
  lr_tmp1         titemvalue;
  lr_tmp          titemvalue;
  ln_max          NUMBER;
  lb_exit         BOOLEAN;
  ln_count        NUMBER;
 BEGIN
  IF NVL (an_pointcnt, 0) < 1 THEN
   RETURN cn_err_badarg;
  END IF;

  ln_max := TRUNC (an_count / an_pointcnt) * an_pointcnt;
  an_count := 0;

/*Тянем не более чем an_count для каждой точки а потом по одному значению из каждого массива будем забрасывать в at_id,at_datetime и.т.д */
  FOR i IN 1 .. an_pointcnt LOOP
   lt_length (i) := 0;
   lt_reallength (i) := 0;
   lt_numlast (i) := 0;
   lr_tmp := get_def_titemvalue;
   lb_exit := FALSE;

   IF at_change (i) IS NULL THEN
    OPEN cr_sel FOR 'SELECT   util_pg.to_unlocaltime (date_time, nsource) dat, er, ed, util_pg.sumn (q1, q2) q1, util_pg.sumn (q3, q4) q3, vqm
                   FROM halfhour WHERE mid ='
                    || at_ids (i) || ' AND date_time > to_date(''' || TO_CHAR (at_date (i), 'dd.mm.yyyy hh24:mi:ss')
                    || ''',''dd.mm.yyyy hh24:mi:ss'') - 1 / 24 AND util_pg.to_unlocaltime (date_time, nsource) > to_date('''
                    || TO_CHAR (at_date (i), 'dd.mm.yyyy hh24:mi:ss') || ''',''dd.mm.yyyy hh24:mi:ss'') ORDER BY 1';
   ELSE
    OPEN cr_sel FOR 'SELECT   util_pg.to_unlocaltime (date_time, nsource) dat, er, ed, util_pg.sumn (q1, q2) q1, util_pg.sumn (q3, q4) q3, vqm FROM halfhour WHERE mid = '
                    || at_ids (i) || ' AND date_time IN (
                    SELECT date_time FROM halfhourold WHERE mid = ' || at_ids (i) || ' AND date_time > to_date(''' || TO_CHAR (at_date (i), 'dd.mm.yyyy hh24:mi:ss')
                    || ''',''dd.mm.yyyy hh24:mi:ss'') - 1 / 24 AND util_pg.to_unlocaltime (date_time, nsource) > to_date('''
                    || TO_CHAR (at_date (i), 'dd.mm.yyyy hh24:mi:ss')
                    || ''',''dd.mm.yyyy hh24:mi:ss'')
                     UNION ALL
                    SELECT date_time FROM halfhourold WHERE mid = ' || at_ids (i) || ' AND denter > to_date(''' || TO_CHAR (at_change (i), 'dd.mm.yyyy hh24:mi:ss')
                    || ''',''dd.mm.yyyy hh24:mi:ss'') - ' || cv_enter_shift || ') ORDER BY 1';
   END IF;

   LOOP
    FETCH cr_sel
     INTO lr_tmp1.dat, lr_tmp1.er, lr_tmp1.ed, lr_tmp1.q1, lr_tmp1.q3, lr_tmp1.qm;

    EXIT WHEN cr_sel%NOTFOUND;

    IF lr_tmp.dat = lr_tmp1.dat AND lr_tmp.ID = at_ids (i) THEN   --Для одной метки времени складываем (например ОВ)
     lr_tmp.er := util_pg.sumn (lr_tmp.er, lr_tmp1.er);
     lr_tmp.ed := util_pg.sumn (lr_tmp.ed, lr_tmp1.ed);
     lr_tmp.q1 := util_pg.sumn (lr_tmp.q1, lr_tmp1.q1);
     lr_tmp.q3 := util_pg.sumn (lr_tmp.q3, lr_tmp1.q3);
     lr_tmp.qm := qm_pg.sumqm (lr_tmp.qm, lr_tmp1.qm);
     lt_ret (ln_max * (i - 1) + lt_length (i)) := lr_tmp;
    ELSE
     IF lb_exit THEN
      IF lr_tmp1.dat <= at_date (i) THEN   --Не поместилось в один пакет (<= т.к эта строка не попадает в пакет)
       lt_ret (ln_max * (i - 1) + lt_length (i)).er := cn_rndend;
      END IF;

      EXIT;
     END IF;

     lt_length (i) := lt_length (i) + 1;
     lr_tmp := get_def_titemvalue;
     lr_tmp.ID := at_ids (i);
     lr_tmp.dat := lr_tmp1.dat;
     lr_tmp.er := lr_tmp1.er;
     lr_tmp.ed := lr_tmp1.ed;
     lr_tmp.q1 := lr_tmp1.q1;
     lr_tmp.q3 := lr_tmp1.q3;
     lr_tmp.qm := lr_tmp1.qm;

     IF lt_length (i) >= ln_max THEN
      lb_exit := TRUE;
     END IF;

     lt_ret (ln_max * (i - 1) + lt_length (i)) := lr_tmp;
    END IF;
   END LOOP;
  END LOOP;

  ---Метим те, которые не поместились
  FOR j IN 1 .. ln_max LOOP
   FOR i IN 1 .. an_pointcnt LOOP
    IF j <= lt_length (i) THEN
     an_count := an_count + 1;
     lt_numlast (i) := an_count;
     lt_reallength (i) := lt_reallength (i) + 1;
     lr_tmp := lt_ret (ln_max * (i - 1) + j);
     at_id (an_count) := lr_tmp.ID;
     at_datetime (an_count) := lr_tmp.dat;
     at_er (an_count) := lr_tmp.er;
     at_ed (an_count) := lr_tmp.ed;
     at_q1 (an_count) := lr_tmp.q1;
     at_q3 (an_count) := lr_tmp.q3;
     at_qm (an_count) := NVL (lr_tmp.qm, qm_pg.defqm);
    END IF;

    IF an_count >= ln_max THEN
     EXIT;
    END IF;
   END LOOP;

   IF an_count >= ln_max THEN
    EXIT;
   END IF;
  END LOOP;

  ---Метим те, которые не поместились в один пакет
  FOR i IN 1 .. an_pointcnt LOOP
   IF lt_reallength (i) < lt_length (i) AND lt_numlast (i) > 0 THEN
    IF at_datetime (lt_numlast (i)) < at_date (i) THEN
     at_er (lt_numlast (i)) := cn_rndend;
    END IF;
   END IF;
  END LOOP;

  RETURN cn_err_ok;
 END;

------------------------------------------------------------------------------------------------------------------------
   -- Чтение данных журнал
 FUNCTION get_srv_jounal (an_pointcnt NUMBER,   --Кол запрашиваемых точек
                                             at_ids common_pg.tt_number,   -- массив id запрашиваемых параметров
                                                                        at_date common_pg.tt_date,   --дата с
                                                                                                  an_count IN OUT NUMBER,   -- Длина масcива (На вход макс кол-во)
 at_id OUT common_pg.tt_number,   -- массив id
                               at_datetime OUT common_pg.tt_date,   -- массив меток времени
                                                                 at_state_cod OUT common_pg.tt_number,   --Массив типов событий
 at_state_descr OUT common_pg.tt_varchar2,   --Массив событий
                                          at_code OUT common_pg.tt_varchar2   --массив оригинальных кодов событий
 )
  RETURN NUMBER IS
  lt_length   common_pg.tt_number;   --Для хранения
  lt_ret      ttitemvalue;
  lr_tmp      titemvalue;
  ln_max      NUMBER;
 BEGIN
  IF NVL (an_pointcnt, 0) < 1 THEN
   RETURN cn_err_badarg;
  END IF;

  ln_max := TRUNC (an_count / an_pointcnt) * an_pointcnt;
  an_count := 0;

/*Тянем не более чем an_count для каждой точки а потом по одному значению из каждого массива будем забрасывать в at_id,at_datetime и.т.д */
  FOR i IN 1 .. an_pointcnt LOOP
   lt_length (i) := 0;

   FOR lc IN (SELECT   j.date_time dat, j.state_cod st_cod, d.veventtext || j.state_descr st_descr, j.vcode code, j.nevent
                  FROM journal j, metereventsdict d
                 WHERE j.mid = at_ids (i) AND j.date_time > at_date (i) AND j.nevent = d.nevent(+)
              ORDER BY j.mid, j.date_time) LOOP
    lt_length (i) := lt_length (i) + 1;
    lr_tmp := get_def_titemvalue;
    lr_tmp.ID := at_ids (i);
    lr_tmp.dat := lc.dat;
    lr_tmp.st_cod := lc.st_cod;
    lr_tmp.st_descr := SUBSTR (lc.st_descr, 1, 128 - 1);
    lr_tmp.code := SUBSTR (lc.code, 1, 32 - 1);
    lt_ret (ln_max * (i - 1) + lt_length (i)) := lr_tmp;

    IF lt_length (i) >= ln_max THEN
     EXIT;
    END IF;
   END LOOP;
  END LOOP;

  FOR j IN 1 .. ln_max LOOP
   FOR i IN 1 .. an_pointcnt LOOP
    IF j <= lt_length (i) THEN
     an_count := an_count + 1;
     lr_tmp := lt_ret (ln_max * (i - 1) + j);
     at_id (an_count) := lr_tmp.ID;
     at_datetime (an_count) := lr_tmp.dat;
     at_state_cod (an_count) := lr_tmp.st_cod;
     at_state_descr (an_count) := lr_tmp.st_descr;
     at_code (an_count) := lr_tmp.code;
    END IF;

    IF an_count >= ln_max THEN
     RETURN cn_err_ok;
    END IF;
   END LOOP;
  END LOOP;

  RETURN cn_err_ok;
 END;

------------------------------------------------------------------------------------------------------------------------
    -- Чтение суточных данных
 FUNCTION get_srv_day (an_pointcnt NUMBER,   --Кол запрашиваемых точек
                                          at_ids common_pg.tt_number,   -- массив id запрашиваемых параметров
                                                                     at_date common_pg.tt_date,   --дата с
                                                                                               an_count IN OUT NUMBER,   -- Длина масcива (На вход макс кол-во)
 at_id OUT common_pg.tt_number,   -- массив id
                               at_datetime OUT common_pg.tt_date,   -- массив меток времени
                                                                 at_er OUT common_pg.tt_number, at_ed OUT common_pg.tt_number, at_q1 OUT common_pg.tt_number,
 at_q3 OUT common_pg.tt_number, at_q2 OUT common_pg.tt_number, at_q4 OUT common_pg.tt_number, at_aer OUT common_pg.tt_number, at_aed OUT common_pg.tt_number,
 at_aq1 OUT common_pg.tt_number, at_aq3 OUT common_pg.tt_number, at_aq2 OUT common_pg.tt_number, at_aq4 OUT common_pg.tt_number, at_ber OUT common_pg.tt_number,
 at_bed OUT common_pg.tt_number, at_bq1 OUT common_pg.tt_number, at_bq3 OUT common_pg.tt_number, at_bq2 OUT common_pg.tt_number, at_bq4 OUT common_pg.tt_number,
 at_cer OUT common_pg.tt_number, at_ced OUT common_pg.tt_number, at_cq1 OUT common_pg.tt_number, at_cq3 OUT common_pg.tt_number, at_cq2 OUT common_pg.tt_number,
 at_cq4 OUT common_pg.tt_number, at_der OUT common_pg.tt_number, at_ded OUT common_pg.tt_number, at_dq1 OUT common_pg.tt_number, at_dq3 OUT common_pg.tt_number,
 at_dq2 OUT common_pg.tt_number, at_dq4 OUT common_pg.tt_number, at_erm OUT common_pg.tt_number, at_edm OUT common_pg.tt_number, at_q1m OUT common_pg.tt_number,
 at_q3m OUT common_pg.tt_number, at_q2m OUT common_pg.tt_number, at_q4m OUT common_pg.tt_number, at_aerm OUT common_pg.tt_number, at_aedm OUT common_pg.tt_number,
 at_aq1m OUT common_pg.tt_number, at_aq3m OUT common_pg.tt_number, at_aq2m OUT common_pg.tt_number, at_aq4m OUT common_pg.tt_number, at_berm OUT common_pg.tt_number,
 at_bedm OUT common_pg.tt_number, at_bq1m OUT common_pg.tt_number, at_bq3m OUT common_pg.tt_number, at_bq2m OUT common_pg.tt_number, at_bq4m OUT common_pg.tt_number,
 at_cerm OUT common_pg.tt_number, at_cedm OUT common_pg.tt_number, at_cq1m OUT common_pg.tt_number, at_cq3m OUT common_pg.tt_number, at_cq2m OUT common_pg.tt_number,
 at_cq4m OUT common_pg.tt_number, at_derm OUT common_pg.tt_number, at_dedm OUT common_pg.tt_number, at_dq1m OUT common_pg.tt_number, at_dq3m OUT common_pg.tt_number,
 at_dq2m OUT common_pg.tt_number, at_dq4m OUT common_pg.tt_number, at_mtrsn OUT common_pg.tt_varchar2
 )
  RETURN NUMBER IS
  lt_length   common_pg.tt_number;   --Для хранения
  lt_ret      ttitemvalue;
  lr_tmp      titemvalue;
  ln_max      NUMBER;
 BEGIN
  IF NVL (an_pointcnt, 0) < 1 THEN
   RETURN cn_err_badarg;
  END IF;

  ln_max := TRUNC (an_count / an_pointcnt) * an_pointcnt;
  an_count := 0;

/*Тянем не более чем an_count для каждой точки а потом по одному значению из каждого массива будем забрасывать в at_id,at_datetime и.т.д */
  FOR i IN 1 .. an_pointcnt LOOP
   lt_length (i) := 0;

   FOR lc IN (SELECT   date_time dat, er, ed, q1, q3, q2, q4, aer, aed, aq1, aq3, aq2, aq4, ber, bed, bq1, bq3, bq2, bq4, cer, ced, cq1, cq3, cq2, cq4, der, ded,
                       dq1, dq3, dq2, dq4, erm, edm, q1m, q3m, q2m, q4m, aerm, aedm, aq1m, aq3m, aq2m, aq4m, berm, bedm, bq1m, bq3m, bq2m, bq4m, cerm, cedm, cq1m,
                       cq3m, cq2m, cq4m, derm, dedm, dq1m, dq3m, dq2m, dq4m, er_mtrsn
                  FROM billorg
                 WHERE mid = at_ids (i) AND date_time > at_date (i)
              ORDER BY mid, date_time) LOOP
    lt_length (i) := lt_length (i) + 1;
    lr_tmp := get_def_titemvalue;
    lr_tmp.ID := at_ids (i);
    lr_tmp.dat := lc.dat;
    lr_tmp.er := lc.er;
    lr_tmp.ed := lc.ed;
    lr_tmp.q1 := lc.q1;
    lr_tmp.q3 := lc.q3;
    lr_tmp.q2 := lc.q2;
    lr_tmp.q4 := lc.q4;
    lr_tmp.aer := lc.aer;
    lr_tmp.aed := lc.aed;
    lr_tmp.aq1 := lc.aq1;
    lr_tmp.aq3 := lc.aq3;
    lr_tmp.aq2 := lc.aq2;
    lr_tmp.aq4 := lc.aq4;
    lr_tmp.ber := lc.ber;
    lr_tmp.bed := lc.bed;
    lr_tmp.bq1 := lc.bq1;
    lr_tmp.bq3 := lc.bq3;
    lr_tmp.bq2 := lc.bq2;
    lr_tmp.bq4 := lc.bq4;
    lr_tmp.cer := lc.cer;
    lr_tmp.ced := lc.ced;
    lr_tmp.cq1 := lc.cq1;
    lr_tmp.cq3 := lc.cq3;
    lr_tmp.cq2 := lc.cq2;
    lr_tmp.cq4 := lc.cq4;
    lr_tmp.der := lc.der;
    lr_tmp.ded := lc.ded;
    lr_tmp.dq1 := lc.dq1;
    lr_tmp.dq3 := lc.dq3;
    lr_tmp.dq2 := lc.dq2;
    lr_tmp.dq4 := lc.dq4;
    lr_tmp.erm := lc.erm;
    lr_tmp.edm := lc.edm;
    lr_tmp.q1m := lc.q1m;
    lr_tmp.q3m := lc.q3m;
    lr_tmp.q2m := lc.q2m;
    lr_tmp.q4m := lc.q4m;
    lr_tmp.aerm := lc.aerm;
    lr_tmp.aedm := lc.aedm;
    lr_tmp.aq1m := lc.aq1m;
    lr_tmp.aq3m := lc.aq3m;
    lr_tmp.aq2m := lc.aq2m;
    lr_tmp.aq4m := lc.aq4m;
    lr_tmp.berm := lc.berm;
    lr_tmp.bedm := lc.bedm;
    lr_tmp.bq1m := lc.bq1m;
    lr_tmp.bq3m := lc.bq3m;
    lr_tmp.bq2m := lc.bq2m;
    lr_tmp.bq4m := lc.bq4m;
    lr_tmp.cerm := lc.cerm;
    lr_tmp.cedm := lc.cedm;
    lr_tmp.cq1m := lc.cq1m;
    lr_tmp.cq3m := lc.cq3m;
    lr_tmp.cq2m := lc.cq2m;
    lr_tmp.cq4m := lc.cq4m;
    lr_tmp.derm := lc.derm;
    lr_tmp.dedm := lc.dedm;
    lr_tmp.dq1m := lc.dq1m;
    lr_tmp.dq3m := lc.dq3m;
    lr_tmp.dq2m := lc.dq2m;
    lr_tmp.dq4m := lc.dq4m;
    lr_tmp.mtrsn := lc.er_mtrsn;
    lt_ret (ln_max * (i - 1) + lt_length (i)) := lr_tmp;

    IF lt_length (i) >= ln_max THEN
     EXIT;
    END IF;
   END LOOP;
  END LOOP;

  FOR j IN 1 .. ln_max LOOP
   FOR i IN 1 .. an_pointcnt LOOP
    IF j <= lt_length (i) THEN
     an_count := an_count + 1;
     lr_tmp := lt_ret (ln_max * (i - 1) + j);
     at_id (an_count) := lr_tmp.ID;
     at_datetime (an_count) := lr_tmp.dat;
     at_er (an_count) := lr_tmp.er;
     at_ed (an_count) := lr_tmp.ed;
     at_q1 (an_count) := lr_tmp.q1;
     at_q3 (an_count) := lr_tmp.q3;
     at_q2 (an_count) := lr_tmp.q2;
     at_q4 (an_count) := lr_tmp.q4;
     at_aer (an_count) := lr_tmp.aer;
     at_aed (an_count) := lr_tmp.aed;
     at_aq1 (an_count) := lr_tmp.aq1;
     at_aq3 (an_count) := lr_tmp.aq3;
     at_aq2 (an_count) := lr_tmp.aq2;
     at_aq4 (an_count) := lr_tmp.aq4;
     at_ber (an_count) := lr_tmp.ber;
     at_bed (an_count) := lr_tmp.bed;
     at_bq1 (an_count) := lr_tmp.bq1;
     at_bq3 (an_count) := lr_tmp.bq3;
     at_bq2 (an_count) := lr_tmp.bq2;
     at_bq4 (an_count) := lr_tmp.bq4;
     at_cer (an_count) := lr_tmp.cer;
     at_ced (an_count) := lr_tmp.ced;
     at_cq1 (an_count) := lr_tmp.cq1;
     at_cq3 (an_count) := lr_tmp.cq3;
     at_cq2 (an_count) := lr_tmp.cq2;
     at_cq4 (an_count) := lr_tmp.cq4;
     at_der (an_count) := lr_tmp.der;
     at_ded (an_count) := lr_tmp.ded;
     at_dq1 (an_count) := lr_tmp.dq1;
     at_dq3 (an_count) := lr_tmp.dq3;
     at_dq2 (an_count) := lr_tmp.dq2;
     at_dq4 (an_count) := lr_tmp.dq4;
     at_erm (an_count) := lr_tmp.erm;
     at_edm (an_count) := lr_tmp.edm;
     at_q1m (an_count) := lr_tmp.q1m;
     at_q3m (an_count) := lr_tmp.q3m;
     at_q2m (an_count) := lr_tmp.q2m;
     at_q4m (an_count) := lr_tmp.q4m;
     at_aerm (an_count) := lr_tmp.aerm;
     at_aedm (an_count) := lr_tmp.aedm;
     at_aq1m (an_count) := lr_tmp.aq1m;
     at_aq3m (an_count) := lr_tmp.aq3m;
     at_aq2m (an_count) := lr_tmp.aq2m;
     at_aq4m (an_count) := lr_tmp.aq4m;
     at_berm (an_count) := lr_tmp.berm;
     at_bedm (an_count) := lr_tmp.bedm;
     at_bq1m (an_count) := lr_tmp.bq1m;
     at_bq3m (an_count) := lr_tmp.bq3m;
     at_bq2m (an_count) := lr_tmp.bq2m;
     at_bq4m (an_count) := lr_tmp.bq4m;
     at_cerm (an_count) := lr_tmp.cerm;
     at_cedm (an_count) := lr_tmp.cedm;
     at_cq1m (an_count) := lr_tmp.cq1m;
     at_cq3m (an_count) := lr_tmp.cq3m;
     at_cq2m (an_count) := lr_tmp.cq2m;
     at_cq4m (an_count) := lr_tmp.cq4m;
     at_derm (an_count) := lr_tmp.derm;
     at_dedm (an_count) := lr_tmp.dedm;
     at_dq1m (an_count) := lr_tmp.dq1m;
     at_dq3m (an_count) := lr_tmp.dq3m;
     at_dq2m (an_count) := lr_tmp.dq2m;
     at_dq4m (an_count) := lr_tmp.dq4m;
     at_mtrsn (an_count) := lr_tmp.mtrsn;
    END IF;

    IF an_count >= ln_max THEN
     RETURN cn_err_ok;
    END IF;
   END LOOP;
  END LOOP;

  RETURN cn_err_ok;
 END;

------------------------------------------------------------------------------------------------------------------------
 --Возвращает guid по каналу и связному номеру (из feeders.vinfo)
 FUNCTION get_guid (an_cid NUMBER, an_canal NUMBER, an_type NUMBER)
  RETURN VARCHAR2 IS
  lv_ret            VARCHAR2 (256);
  lv_def   CONSTANT VARCHAR2 (256) := 'UA.EMPTY_00000000-0000-0000-0000-000000000000';
 BEGIN
  SELECT MAX (f.vinfo)
    INTO lv_ret
    FROM feeders f, chanpoint c
   WHERE c.cid = an_cid AND c.mid = f.mid AND f.canal = an_canal;

  IF an_type > 0 THEN
   lv_ret := util_pg.get_param (lv_ret, an_type);
  END IF;

  RETURN NVL (lv_ret, lv_def);
 END;

------------------------------------------------------------------------------------------------------------------------
 --Возвращает guid по каналу и связному номеру (из addpointparam.vvalue)
 FUNCTION get_guidm (an_cid NUMBER, an_canal NUMBER, an_type NUMBER)
  RETURN VARCHAR2 IS
  lv_ret            VARCHAR2 (256);
  lv_def   CONSTANT VARCHAR2 (256) := 'UA.EMPTY_00000000-0000-0000-0000-000000000000';
 BEGIN
  SELECT MAX (m.mrid)
    INTO lv_ret
    FROM chanpoint c, feeders f, mrids m
   WHERE c.cid = an_cid AND c.mid = f.mid AND f.mid = m.mid AND f.canal = an_canal
         AND DECODE (an_type, 1, 1, 2, 2, 3, 7, 4, 8, 5, 71, 6, 72, 7, 73, 8, 75, 9, 77) = m.nmeasure;

  RETURN NVL (lv_ret, lv_def);
 END;

------------------------------------------------------------------------------------------------------------------------
 FUNCTION get_val_opc (an_mid NUMBER, ad_date DATE, an_meastype NUMBER DEFAULT 9, an_step NUMBER DEFAULT 1)
  RETURN NUMBER IS
  ld_start       DATE            DEFAULT util_pg.trunc_d (ad_date, an_step);
  ld_end         DATE            DEFAULT util_pg.trunc_d (ad_date, an_step) + an_step;
  ln_ret         NUMBER;
  lv_what        VARCHAR2 (2000);
  lv_datatable   VARCHAR2 (2000);
  lv_sql         VARCHAR2 (2000);
 BEGIN
  IF an_meastype = 1 THEN   --ER
   lv_what := 'sum(nvl(P.er,0))';
  ELSIF an_meastype = 2 THEN   --ED
   lv_what := 'sum(nvl(P.ed,0))';
  ELSIF an_meastype = 3 THEN   --Q1
   lv_what := 'sum(nvl(P.q1,0))';
  ELSIF an_meastype = 4 THEN   --Q2
   lv_what := 'sum(nvl(P.q2,0))';
  ELSIF an_meastype = 5 THEN   --Q3
   lv_what := 'sum(nvl(P.q3,0))';
  ELSIF an_meastype = 6 THEN   --Q4
   lv_what := 'sum(nvl(P.q4,0))';
  ELSIF an_meastype = 7 THEN   --Свернутые Q1+Q2
   lv_what := 'sum(nvl(P.q1,0))+sum(nvl(P.q2,0))';
  ELSIF an_meastype = 8 THEN   --Свернутые Q3+Q4
   lv_what := 'sum(nvl(P.q3,0))+sum(nvl(P.q3,0))';
  ELSIF an_meastype = 9 THEN   --Переток ER-ED
   lv_what := 'sum(util_pg.sld(P.mid,nvl(P.er,0),nvl(P.ed,0)))';
  ELSIF an_meastype = 10 THEN   --Переток (Q1-Q3)+(Q2-Q4)
   lv_what := 'sum(util_pg.sld(P.mid,nvl(P.q1,0),nvl(P.q3,0)))+
                sum(util_pg.sld(P.mid,nvl(P.q2,0),nvl(P.q4,0)))';
  ELSIF an_meastype = 36 THEN   --Переток ER-ED
   lv_what := 'sum(nvl(P.er,0)+nvl(P.ed,0))';
  ELSIF an_meastype = 37 THEN   --Переток (Q1-Q3)+(Q2-Q4)
   lv_what := 'sum(nvl(P.q1,0)+nvl(P.q3,0)+nvl(P.q2,0)+nvl(P.q4,0))';
  END IF;

  IF an_step > 1 THEN
   lv_datatable := 'bill';
   ld_start := TRUNC (ad_date, 'MONTH');
   ld_end := ADD_MONTHS (ld_start, 1);
  ELSE
   lv_datatable := 'halfhour';
  END IF;

  lv_sql := ' SELECT ' || lv_what || ' FROM ' || lv_datatable || ' P ' || ' WHERE P.mid = ' || an_mid || ' AND P.date_time > :d_start AND P.date_time <= :d_end ';

  EXECUTE IMMEDIATE lv_sql
               INTO ln_ret
              USING ld_start, ld_end;

  RETURN ln_ret;
 END;

------------------------------------------------------------------------------------------------------------------------
--Сбор статистики ICCP
 PROCEDURE iccpstat_ins (an_cid NUMBER, ad_date DATE, an_reason NUMBER, an_send NUMBER, an_received NUMBER, an_loss NUMBER, an_correction NUMBER, an_error NUMBER,
 an_connect NUMBER, an_disconnect NUMBER, an_duration NUMBER, an_mindelay NUMBER, an_maxdelay NUMBER, an_avgdelay NUMBER
 ) IS
 BEGIN
  INSERT INTO iccpstat
              (cid, ddate, nreason, nsend, nreceived, nloss, ncorrection, nerror, nconnect, ndisconnect, nduration, nmindelay,
               nmaxdelay, navgdelay
              )
       VALUES (an_cid, ad_date, an_reason, an_send, an_received, an_loss, an_correction, an_error, an_connect, an_disconnect, an_duration, an_mindelay,
               an_maxdelay, an_avgdelay
              );
 END;

------------------------------------------------------------------------------------------------------------------------
--Возвращает ид точки по MDID
 FUNCTION get_point_id_for_event_mrid (av_mrid VARCHAR2)
  RETURN NUMBER IS
  ln_ret   NUMBER;
 BEGIN
  SELECT MAX (mid)
    INTO ln_ret
    FROM mrids m
   WHERE mrid = av_mrid AND nmeasure = 77;

  RETURN NVL (ln_ret, 0);
 END;
------------------------------------------------------------------------------------------------------------------------
END;   -- Package Body tsda_pg
/


-- End of DDL Script for Package Body RYDA.TSDA_PG

