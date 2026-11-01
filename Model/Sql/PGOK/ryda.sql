-- Start of DDL Script for Package RYDA.PGOK_PG
-- Generated 14.04.2009 14:26:09 from RYDA@OE

CREATE OR REPLACE 
PACKAGE pgok_pg IS
 ------------------------------------------------------------------------------------------------------------------------
 --Копирование данных из таблиц с ПГОК в получасовки
 PROCEDURE copy_pgok_data(an_maket NUMBER, ad_date DATE);
 ------------------------------------------------------------------------------------------------------------------------ 

END; -- Package spec PGOK_PG
/


-- End of DDL Script for Package RYDA.PGOK_PG

-- Start of DDL Script for Package Body RYDA.PGOK_PG
-- Generated 14.04.2009 14:26:40 from RYDA@OE

CREATE OR REPLACE 
PACKAGE BODY pgok_pg IS
 ------------------------------------------------------------------------------------------------------------------------
 --Копирование данных из таблиц с ПГОК в получасовки
 PROCEDURE copy_pgok_data(an_maket NUMBER, ad_date DATE) IS
  cn_step   CONSTANT NUMBER              := 1 / 48;
  ld_date            DATE                DEFAULT TRUNC(ad_date);
  ln_rn              NUMBER DEFAULT 3;
  lc0                common_pg.tcur;
  lc1                common_pg.tcur;
  ln_val_k           NUMBER;    -- значение выхода в тоннах
  ln_val_u           NUMBER;    -- значение удельного выхода
  ln_val_r           NUMBER;    -- значение расхода в кВт
  ln_mid_k           NUMBER;    -- mid точки с выходом (kонцентратом)
  ln_mid_u           NUMBER;    -- mid соответствующей точки с уд. выходом
  ln_ras_gid         NUMBER;    -- gid секции с расходом, из которой берутся данные
  ln_section         NUMBER;
  ln_section_u       NUMBER;
  lv_table           VARCHAR2 (256);
  lv_sql             VARCHAR2 (2000);
  ln_temp            NUMBER;
      
 BEGIN

  OPEN lc0 FOR  SELECT konc.mid k_mid, konc.vcode k_vcode, ud.mid u_mid, ud.vcode u_vcode, ud.ras_gid ras_gid
                FROM
                (SELECT mid, util_pg.allnumber_f(util_pg.get_param(trim(vcode),2,'_')) vcode
                  FROM feeders
                 WHERE UPPER(vcode) LIKE 'KONC/_%' ESCAPE '/'
                       AND util_pg.allnumber_f(util_pg.get_param(trim(vcode),2,'_')) BETWEEN 1 AND 15) konc,
                (SELECT mid, util_pg.allnumber_f(util_pg.get_param(trim(vcode),2,'_')) vcode, util_pg.allnumber_f(util_pg.get_param(trim(vcode),3,'_')) ras_gid
                   FROM feeders
                  WHERE UPPER(vcode) LIKE 'UD/_%' ESCAPE '/'
                        AND util_pg.allnumber_f(util_pg.get_param(trim(vcode),2,'_')) BETWEEN 1 AND 15) ud
                WHERE konc.vcode=ud.vcode(+)
                ORDER BY k_vcode;
  LOOP
   FETCH lc0
    INTO ln_mid_k, ln_section, ln_mid_u, ln_section_u, ln_ras_gid;

   EXIT WHEN lc0%NOTFOUND;

   DELETE FROM halfhourold
         WHERE mid = ln_mid_k AND date_time > ad_date;
   IF ln_mid_u IS NOT NULL THEN
      DELETE FROM halfhourold
         WHERE mid = ln_mid_u AND date_time > ad_date;
   END IF;               

--dbms_output.put_line(chr(13)||'ln_section='||ln_section);   
   IF ln_section IS NULL THEN
     raise_application_error(-20001,'Не найден номер секции в коде точки '||ln_mid_k);
   END IF;
   
   IF ln_section BETWEEN 1 AND 8 THEN
      lv_table := ' RYDA_OF1 ';  
   ELSIF ln_section BETWEEN 10 AND 15 THEN
      lv_table := ' RYDA_OF2 ';
   ELSE   
      raise_application_error(-20001,'Номер секции в коде точки '||ln_mid_k||' выходит за границы возможных.'); 
   END IF; 
--dbms_output.put_line('----------------- '||lv_table);
   BEGIN
     lv_sql := 'SELECT konc.k_date, konc.k_val, rashod.r_val
                FROM
                (SELECT SUM(util_pg.sld(h.mid,NVL(h.er*DECODE(g.NPARTLY,2,0,1),0),NVL(h.ed*DECODE(g.NPARTLY,1,0,1),0))*DECODE(G.INVERTED,''y'',-1,1)) r_val,
                        trunc(h.date_time-1/86400,''hh24'')+1/24 r_date
                  FROM halfhour h, GROUPS g 
                 WHERE :ln_ras_gid IS NOT NULL AND :ln_mid_u IS NOT NULL
                       AND g.gid IN (SELECT gid FROM GROUPS WHERE mid>0 CONNECT BY PRIOR gid=parent START WITH parent=:ln_ras_gid)
                       AND h.mid=g.mid
                       AND h.date_time > :ad_date
                 GROUP BY trunc(h.date_time-1/86400,''hh24'')+1/24
                 ORDER BY r_date DESC) rashod,
                (SELECT orderdate+tekchassm/24 k_date, m_'||ln_section||' k_val FROM '||lv_table||' WHERE orderdate > :ad_date) konc
                WHERE konc.k_date=rashod.r_date(+)';
     OPEN lc1 FOR lv_sql USING ln_ras_gid,ln_mid_u,ln_ras_gid,ad_date,ad_date;
     LOOP
       FETCH lc1
        INTO ld_date, ln_val_k, ln_val_r;
 
       EXIT WHEN lc1%NOTFOUND;
--dbms_output.put_line('ld_date='||to_char(ld_date,'dd.mm.yy hh24:mi:ss')||chr(13)||' ln_val_k='||ln_val_k||' ln_val_r='||ln_val_r);
       -- вставка выхода в тоннах
       IF (ln_val_k IS NOT NULL) THEN
          ln_temp := TRUNC (ln_val_k/2, 0);          
--dbms_output.put_line('вставка первой половины '||ln_temp||'_точки '||ln_mid_k);       
          das_pg.ins_halfhourtmp (ln_mid_k, util_pg.to_unlocaltime_if_new (ld_date-1/48), NULL, ln_temp, NULL, NULL, NULL, NULL, NULL,NULL, NULL, NULL);
          ln_temp := ln_val_k - ln_temp;
--dbms_output.put_line('вставка второй половины '||ln_temp||'_точки '||ln_mid_k);       
          das_pg.ins_halfhourtmp (ln_mid_k, util_pg.to_unlocaltime_if_new (ld_date), NULL, ln_temp, NULL, NULL, NULL, NULL, NULL,NULL, NULL, NULL);
--dbms_output.put_line('конец вставки ВЫВОДА'); 
       END IF;
      
       -- подсчет удельного расхода в кВтч/т
       IF ln_val_k IS NOT NULL AND ln_val_r IS NOT NULL AND ln_val_k<>0 THEN
         ln_val_u := trunc(ln_val_r/ln_val_k,ln_rn);
       ELSE  
         ln_val_u := NULL;   
       END IF;
--dbms_output.put_line(' ln_val_u='||ln_val_u);       
       -- вставка выхода в тоннах
       IF (ln_val_u IS NOT NULL) THEN
          ln_temp := TRUNC (ln_val_u/2, 0);  
--dbms_output.put_line('_вставка первой половины '||ln_temp||'_точки '||ln_mid_u);         
          das_pg.ins_halfhourtmp (ln_mid_u, util_pg.to_unlocaltime_if_new (ld_date-1/48), NULL, ln_temp, NULL, NULL, NULL, NULL, NULL,NULL, NULL, NULL);
          ln_temp := ln_val_u - ln_temp;
--dbms_output.put_line('_вставка второй половины '||ln_temp||'_точки '||ln_mid_u);         
          das_pg.ins_halfhourtmp (ln_mid_u, util_pg.to_unlocaltime_if_new (ld_date), NULL, ln_temp, NULL, NULL, NULL, NULL, NULL,NULL, NULL, NULL);          
--dbms_output.put_line('конец вставки УДЕЛЬНЫХ'); 
       END IF;
    
     END LOOP;

     CLOSE lc1;
    EXCEPTION
     WHEN OTHERS THEN
      IF lc1%ISOPEN THEN
       CLOSE lc1;
      END IF;
--dbms_output.put_line('---------------------------- ЗАЛЕТ! ');      
   END;
 
  END LOOP;

  CLOSE lc0;

  COMMIT;
  das_pg.checkhalfhour;
  COMMIT;
 EXCEPTION
  WHEN OTHERS THEN
   ROLLBACK;
   raise_application_error (-20001, 'PGOK_PG.copy_pgok_data: ' || SQLERRM (SQLCODE));
 END;   
 ------------------------------------------------------------------------------------------------------------------------ 

   -- Enter further code below as specified in the Package spec.
END;
/


-- End of DDL Script for Package Body RYDA.PGOK_PG
--Только для АСКУЭ ПГОК
 insert into deportprocedures (nprocedure, vname, vprocedure, nperiod, ntype, vmemo)
 values (59, 'Загрузка данных выработки','ryda.pgok_pg.copy_pgok_data', 1, 1, 'Загрузка данных выработки')
 /
 commit
 /

-- Start of DDL Script for Package Body RYDA.UNIINTERIOR_PG
-- Generated 14.04.2009 14:27:08 from RYDA@OE

CREATE OR REPLACE 
PACKAGE BODY uniinterior_pg IS
------------------------------------------------------------------------------------------------------------------------
  -- пакет по представленипю данных макетов в сетке
  -- дата создания 09/10/2006 Сечин А.А.
------------------------------------------------------------------------------------------------------------------------
 FUNCTION f_gettypeproc (an_fid NUMBER)
  RETURN VARCHAR2 IS
  lv_proc   VARCHAR2 (256);
 BEGIN
  SELECT UPPER (TRIM (MAX (vprocname)))
    INTO lv_proc
    FROM forms
   WHERE fid = an_fid;

  RETURN lv_proc;
 END;

------------------------------------------------------------------------------------------------------------------------
--Цвет по типу параметра
 FUNCTION f_color (an_paramtype NUMBER)
  RETURN NUMBER IS
 BEGIN
  RETURN cn_white;
 END;

 ------------------------------------------------------------------------------------------------------------------------
--Блокировка вывода итоговых цифр
 FUNCTION f_locksum (an_fid NUMBER)
  RETURN NUMBER IS
  ln_ret   NUMBER;
 BEGIN
  SELECT NVL (DECODE (MAX (vvalue), '1', 1, 0), 0)   -- 0 значит не блокировать
    INTO ln_ret
    FROM addformparamval
   WHERE mid = an_fid AND nsort = -5;

  RETURN ln_ret;
 END;

------------------------------------------------------------------------------------------------------------------------
  -- Возвращает информацию по колонкам таблицы для макета
 PROCEDURE getmaketinfo (an_fid NUMBER, an_ispoint NUMBER, an_id NUMBER, ad_from DATE, ad_till DATE, an_cnfixcol OUT NUMBER, an_cntitle OUT NUMBER,
 an_cnfooter OUT NUMBER, col_t OUT common_pg.tcur, row_t OUT common_pg.tcur
 ) IS
   /*
  an_fid         - Ид формы
  an_ispoint      - Признак точки
  an_id           - Ид (точки или группы)
  ad_from         - Дата с
  ad_till         - Дата по
  an_cnfixcol --количество фикс колонок
  an_cntitle --количество строк в заголовке
  col_t -- информация по колонкам таблицы - курсор, строка которого есть
   id - идентификатор колонки
   Title1, Title2, ... (=an_cntitle) - наименование
   TitleCl - цвет заголовка
   TitleAl - выравнивание заголовка
   DataCl - цвет данных
   DataAl - выравнивание данных
   nlock - блокировка редактирования
   nwidth - ширина колонки (если<=0 то auto)
   vmasks - маска колонки (может быть NULL)
  row_t -- информация по строкам таблицы - курсор, строка которого есть
   id - идентификатор сторки
   Title1, Title2, ... (=an_cnfixcol) - наименование
   DataCl - цвет данных
   nlock - блокировка редактирования
   vmasks - маска строки (может быть NULL)
   */
  lv_proc      VARCHAR2 (256);
  ln_locksum   NUMBER         DEFAULT f_locksum (an_fid);
  lv_lev       NUMBER         DEFAULT 0;
  interv       NUMBER;
  smena        DATE;

 BEGIN
  lv_proc := f_gettypeproc (an_fid);

  IF lv_proc = cv_proc1 THEN
   an_cnfixcol := 3;
   an_cntitle := 2;
   an_cnfooter := 1;

   OPEN col_t FOR
    SELECT -1 ID, 'Наименование присоединения' title1, '' title2, cn_btnface titlecl, cn_left titleal, cn_btnface datacl, cn_left dataal, 1 nlock, 200 nwidth,
           '' vmasks
      FROM DUAL
    UNION ALL
    SELECT -2 ID, '№ счетчика' title1, '' title2, cn_btnface titlecl, cn_left titleal, cn_btnface datacl, cn_right dataal, 1 nlock, 70 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT -2 ID, 'Коеф.' title1, '' title2, cn_btnface titlecl, cn_left titleal, cn_btnface datacl, cn_right dataal, 1 nlock, 50 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 1 ID, 'Актив (+)' title1, 'Конечные показания' title2, cn_btnface titlecl, cn_left titleal, cn_white datacl, cn_right dataal, 1 nlock, 70 nwidth,
           '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 2 ID, 'Актив (+)' title1, 'Начальные показания' title2, cn_btnface titlecl, cn_left titleal, cn_white datacl, cn_right dataal, 1 nlock, 70 nwidth,
           '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 3 ID, 'Актив (+)' title1, 'Разность' title2, cn_btnface titlecl, cn_left titleal, cn_white datacl, cn_right dataal, 1 nlock, 70 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 4 ID, 'Актив (+)' title1, 'Расход энергии' title2, cn_btnface titlecl, cn_left titleal, cn_aqua datacl, cn_right dataal, 1 nlock, 70 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 21 ID, 'Актив (-)' title1, 'Конечные показания' title2, cn_btnface titlecl, cn_left titleal, cn_white datacl, cn_right dataal, 1 nlock, 70 nwidth,
           '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 22 ID, 'Актив (-)' title1, 'Начальные показания' title2, cn_btnface titlecl, cn_left titleal, cn_white datacl, cn_right dataal, 1 nlock, 70 nwidth,
           '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 23 ID, 'Актив (-)' title1, 'Разность' title2, cn_btnface titlecl, cn_left titleal, cn_white datacl, cn_right dataal, 1 nlock, 70 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 24 ID, 'Актив (-)' title1, 'Расход энергии' title2, cn_btnface titlecl, cn_left titleal, cn_aqua datacl, cn_right dataal, 1 nlock, 70 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 31 ID, 'Реактив (+)' title1, 'Конечные показания' title2, cn_btnface titlecl, cn_left titleal, cn_white datacl, cn_right dataal, 1 nlock, 70 nwidth,
           '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 32 ID, 'Реактив (+)' title1, 'Начальные показания' title2, cn_btnface titlecl, cn_left titleal, cn_white datacl, cn_right dataal, 1 nlock, 70 nwidth,
           '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 33 ID, 'Реактив (+)' title1, 'Разность' title2, cn_btnface titlecl, cn_left titleal, cn_white datacl, cn_right dataal, 1 nlock, 70 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 34 ID, 'Реактив (+)' title1, 'Расход энергии' title2, cn_btnface titlecl, cn_left titleal, cn_aqua datacl, cn_right dataal, 1 nlock, 70 nwidth,
           '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 41 ID, 'Реактив (-)' title1, 'Конечные показания' title2, cn_btnface titlecl, cn_left titleal, cn_white datacl, cn_right dataal, 1 nlock, 70 nwidth,
           '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 42 ID, 'Реактив (-)' title1, 'Начальные показания' title2, cn_btnface titlecl, cn_left titleal, cn_white datacl, cn_right dataal, 1 nlock, 70 nwidth,
           '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 43 ID, 'Реактив (-)' title1, 'Разность' title2, cn_btnface titlecl, cn_left titleal, cn_white datacl, cn_right dataal, 1 nlock, 70 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 44 ID, 'Реактив (-)' title1, 'Расход энергии' title2, cn_btnface titlecl, cn_left titleal, cn_aqua datacl, cn_right dataal, 1 nlock, 70 nwidth,
           '' vmasks
      FROM DUAL;

   IF an_ispoint = 1 THEN
    OPEN row_t FOR
     SELECT *
       FROM (SELECT   p.mid ID, DECODE (f.vcode, '', '', f.vcode || '.') || pa.NAME || ' / ' || p.NAME title1, m.mtrsn title2, TO_CHAR (DECODE(SIGN(NVL (f.metkc, 1)-1),1,NVL (f.metkc, 1),NVL (f.kc, 1))) title3,
                      cn_white datacl, cn_right dataal, 0 nlock, '' vmasks
                 FROM feeders f, meters m, points p, points pa
                WHERE f.mid IN (SELECT     mid
                                      FROM points
                                CONNECT BY PRIOR mid = PARENT
                                START WITH mid = an_id) AND f.mid = m.mid(+) AND m.entype(+) = 7 AND f.mid = p.mid(+) AND p.PARENT = pa.mid(+)
             ORDER BY pa.NAME, pa.mid, p.NAME, p.mid)
     UNION ALL
     SELECT -1 ID, 'Итого расход:' title1, '' title2, '' title3, cn_yellow datacl, cn_right dataal, 0 nlock, '' vmasks
       FROM DUAL;
   ELSE
    OPEN row_t FOR
     SELECT *
       FROM (SELECT   p.mid ID, NVL (util_pg.get_param (g.vparam, 2), DECODE (f.vcode, '', '', f.vcode || '.') || pa.NAME || '/' || p.NAME) title1, m.mtrsn title2,
                      TO_CHAR (DECODE(SIGN(NVL (f.metkc, 1)-1),1,NVL (f.metkc, 1),NVL (f.kc, 1)) ) title3, cn_white datacl, cn_right dataal, 0 nlock, '' vmasks
                 FROM GROUPS g, feeders f, meters m, points p, points pa
                WHERE g.gid IN (
                       SELECT     gid
                             FROM GROUPS
                       CONNECT BY PRIOR gid = PARENT
                                  AND (TO_CHAR (ad_from, 'yyyymm') <= NVL (ntillperiod, 299912) AND TO_CHAR (ad_till, 'yyyymm') >= NVL (nfromperiod, 160501))
                       START WITH gid = an_id
                                  AND (TO_CHAR (ad_from, 'yyyymm') <= NVL (ntillperiod, 299912) AND TO_CHAR (ad_till, 'yyyymm') >= NVL (nfromperiod, 160501)))
                      AND g.mid = f.mid AND f.mid = m.mid(+) AND m.entype(+) = 7 AND f.mid = p.mid(+) AND p.PARENT = pa.mid(+)
             ORDER BY util_pg.allnumber_f (util_pg.get_param (g.vparam, 1, ';')), pa.NAME, pa.mid, p.NAME, p.mid)
     UNION ALL
     SELECT -1 ID, 'Итого расход:' title1, '' title2, '' title3, cn_yellow datacl, cn_right dataal, 0 nlock, '' vmasks
       FROM DUAL;
   END IF;
  ------------------------------- addded by Kondakov A.G. 07.10.2008
  ELSIF lv_proc = cv_proc2 THEN
   an_cnfixcol := 4;
   an_cntitle := 2;

   SELECT DECODE (ln_locksum, 0, 3, 0)
     INTO an_cnfooter
     FROM DUAL;

   OPEN col_t FOR
    SELECT -1 ID, '№ п/п' title1, '' title2, cn_btnface titlecl, cn_left titleal, cn_btnface datacl, cn_center dataal, 1 nlock, 30 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT -2 ID, 'Назва л_н_ї' title1, '' title2, cn_btnface titlecl, cn_left titleal, cn_btnface datacl, cn_left dataal, 1 nlock, 300 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT -2 ID, '№ л_чильника' title1, '' title2, cn_btnface titlecl, cn_left titleal, cn_btnface datacl, cn_right dataal, 1 nlock, 90 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT -2 ID, 'Напрямок перетоку' title1, '' title2, cn_btnface titlecl, cn_right titleal, cn_btnface datacl, cn_right dataal, 1 nlock, 55 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 1 ID, 'Показання л_чильника' title1, 'на 0 г. 1-го числа зв_тного м_сяця' title2, cn_btnface titlecl, cn_left titleal, cn_white datacl, cn_right dataal,
           1 nlock, 100 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 2 ID, 'Показання л_чильника' title1, 'на 24 г. останнього числа зв_тного м_сяця' title2, cn_btnface titlecl, cn_left titleal, cn_white datacl,
           cn_right dataal, 1 nlock, 100 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 3 ID, 'Р_зниця показник_в л_чильник_в' title1, '' title2, cn_btnface titlecl, cn_left titleal, cn_white datacl, cn_right dataal, 1 nlock, 100 nwidth,
           '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 4 ID, 'Коеф_ц_єнт л_чильника' title1, '' title2, cn_btnface titlecl, cn_left titleal, cn_white datacl, cn_right dataal, 1 nlock, 85 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 5 ID, 'К_л-ть електроенерг_ї обл_кованої л_чильником кВт/г.' title1, '' title2, cn_btnface titlecl, cn_left titleal, cn_white datacl, cn_right dataal,
           1 nlock, 120 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 6 ID, 'Прим_тка' title1, '' title2, cn_btnface titlecl, cn_left titleal, cn_white datacl, cn_right dataal, 0 nlock, 120 nwidth, '' vmasks
      FROM DUAL;

   IF an_ispoint = 1 THEN
    OPEN row_t FOR
     SELECT TO_CHAR (ROWNUM) title1, t.ID, t.title2, t.title3, t.title4, t.datacl, t.dataal, t.nlock, t.vmasks
       FROM (SELECT   p.mid ID, DECODE (f.vcode, '', '', f.vcode || '.') || pa.NAME || ' / ' || p.NAME title2, m.mtrsn title3, d.t title4, cn_white datacl,
                      cn_right dataal, 0 nlock, '' vmasks
                 FROM feeders f,
                      meters m,
                      points p,
                      points pa,
                      (SELECT ROWNUM r, DECODE (ROWNUM, 1, 'прийом', 'в_ддача') t
                         FROM dict
                        WHERE ROWNUM <= 2) d
                WHERE f.mid IN (SELECT     mid
                                      FROM points
                                CONNECT BY PRIOR mid = PARENT
                                START WITH mid = an_id) AND f.mid = m.mid(+) AND m.entype(+) = 7 AND f.mid = p.mid(+) AND p.PARENT = pa.mid(+)
             ORDER BY pa.NAME, pa.mid, p.NAME, p.mid, d.t) t   -- сортировка по d.t значит - сначала отдача, потом прием
     UNION ALL
     SELECT '' title1, -1 ID, '' title2, 'Разом:' title3, 'в_ддача' title4, cn_yellow datacl, cn_right dataal, 0 nlock, '' vmasks
       FROM DUAL
      WHERE ln_locksum = 0
     UNION ALL
     SELECT '' title1, -1 ID, '' title2, '' title3, 'прийом' title4, cn_yellow datacl, cn_right dataal, 0 nlock, '' vmasks
       FROM DUAL
      WHERE ln_locksum = 0
     UNION ALL
     SELECT '' title1, -1 ID, '' title2, '' title3, 'сальдо' title4, cn_yellow datacl, cn_right dataal, 0 nlock, '' vmasks
       FROM DUAL
      WHERE ln_locksum = 0;
   ELSE
    OPEN row_t FOR
     SELECT TO_CHAR (ROWNUM) title1, t.ID, t.title2, t.title3, t.title4, t.datacl, t.dataal, t.nlock, t.vmasks
       FROM (SELECT   p.mid ID, NVL (util_pg.get_param (g.vparam, 2), DECODE (f.vcode, '', '', f.vcode || '.') || pa.NAME || '/' || p.NAME) title2, m.mtrsn title3,
                      d.t title4, cn_white datacl, cn_right dataal, 0 nlock, '' vmasks
                 FROM GROUPS g,
                      feeders f,
                      meters m,
                      points p,
                      points pa,
                      (SELECT ROWNUM r, DECODE (ROWNUM, 1, 'прийом', 'в_ддача') t
                         FROM dict
                        WHERE ROWNUM <= 2) d
                WHERE g.gid IN (
                       SELECT     gid
                             FROM GROUPS
                       CONNECT BY PRIOR gid = PARENT
                                  AND (TO_CHAR (ad_from, 'yyyymm') <= NVL (ntillperiod, 299912) AND TO_CHAR (ad_till, 'yyyymm') >= NVL (nfromperiod, 160501))
                       START WITH gid = an_id
                                  AND (TO_CHAR (ad_from, 'yyyymm') <= NVL (ntillperiod, 299912) AND TO_CHAR (ad_till, 'yyyymm') >= NVL (nfromperiod, 160501)))
                      AND g.mid = f.mid AND f.mid = m.mid(+) AND m.entype(+) = 7 AND f.mid = p.mid(+) AND p.PARENT = pa.mid(+)
             ORDER BY util_pg.allnumber_f (util_pg.get_param (g.vparam, 1, ';')), pa.NAME, pa.mid, p.NAME, p.mid, d.t) t   -- сортировка по d.t значит - сначала отдача, потом прием
     UNION ALL
     SELECT '' title1, -1 ID, '' title2, 'Разом:' title3, 'в_ддача' title4, cn_yellow datacl, cn_right dataal, 0 nlock, '' vmasks
       FROM DUAL
      WHERE ln_locksum = 0
     UNION ALL
     SELECT '' title1, -1 ID, '' title2, '' title3, 'прийом' title4, cn_yellow datacl, cn_right dataal, 0 nlock, '' vmasks
       FROM DUAL
      WHERE ln_locksum = 0
     UNION ALL
     SELECT '' title1, -1 ID, '' title2, '' title3, 'сальдо' title4, cn_yellow datacl, cn_right dataal, 0 nlock, '' vmasks
       FROM DUAL
      WHERE ln_locksum = 0;
   END IF;
  ------------------------------- addded by Kondakov A.G. 08.10.2008
  ELSIF lv_proc = cv_proc3 THEN
   an_cnfixcol := 3;
   an_cntitle := 3;

   IF ln_locksum = 0 THEN
    an_cnfooter := 4;
   ELSE
    an_cnfooter := 0;
   END IF;

   OPEN col_t FOR
    SELECT -3 ID, 'Наименование ПС' title1, '' title2, '1' title3, cn_btnface titlecl, cn_right titleal, cn_btnface datacl, cn_left dataal, 1 nlock, 200 nwidth,
           '' vmasks
      FROM DUAL
    UNION ALL
    SELECT -2 ID, 'Присоединение' title1, '' title2, '2' title3, cn_btnface titlecl, cn_right titleal, cn_btnface datacl, cn_left dataal, 1 nlock, 180 nwidth,
           '' vmasks
      FROM DUAL
    UNION ALL
    SELECT -1 ID, '№ счетчика' title1, '' title2, '3' title3, cn_btnface titlecl, cn_right titleal, cn_btnface datacl, cn_right dataal, 1 nlock, 70 nwidth,
           '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 1 ID, 'Показания счетчика' title1, '24-00 час. последнего дня отчетного месяца' title2, '4' title3, cn_btnface titlecl, cn_left titleal, cn_white datacl,
           cn_right dataal, 1 nlock, 95 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 2 ID, 'Показания счетчика' title1, '00-00 час. первого дня отчетного месяца' title2, '5' title3, cn_btnface titlecl, cn_left titleal, cn_white datacl,
           cn_right dataal, 1 nlock, 95 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 3 ID, 'Разность' title1, '' title2, '6' title3, cn_btnface titlecl, cn_left titleal, cn_white datacl, cn_right dataal, 1 nlock, 95 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 4 ID, 'Коэффициент' title1, '' title2, '7' title3, cn_btnface titlecl, cn_left titleal, cn_white datacl, cn_right dataal, 1 nlock, 75 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 5 ID, 'Поступление' title1, '' title2, '8' title3, cn_btnface titlecl, cn_left titleal, cn_white datacl, cn_right dataal, 1 nlock, 95 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 6 ID, 'Отдача' title1, '' title2, '9' title3, cn_btnface titlecl, cn_left titleal, cn_white datacl, cn_right dataal, 1 nlock, 95 nwidth, '' vmasks
      FROM DUAL;

   IF an_ispoint = 1 THEN
    OPEN row_t FOR
     SELECT t.ID, t.title1, t.title2, t.title3, t.datacl, t.dataal, t.nlock, t.vmasks
       FROM (SELECT   p.mid ID, DECODE (f.vcode, '', '', f.vcode || '.') || pa.NAME title1, p.NAME title2, m.mtrsn title3, d.r, cn_white datacl, cn_right dataal,
                      0 nlock, '' vmasks
                 FROM feeders f,
                      meters m,
                      points p,
                      points pa,
                      (SELECT ROWNUM r
                         FROM dict
                        WHERE ROWNUM <= 2) d
                WHERE f.mid IN (SELECT     mid
                                      FROM points
                                CONNECT BY PRIOR mid = PARENT
                                START WITH mid = an_id) AND f.mid = m.mid(+) AND m.entype(+) = 7 AND f.mid = p.mid(+) AND p.PARENT = pa.mid(+)
             ORDER BY pa.NAME, pa.mid, p.NAME, p.mid, d.r) t   -- сортировка по d.r значит - сначала прием, потом отдача
     UNION ALL
     SELECT -1 ID, 'Итого расход:' title1, 'за период' title2, 'кВт*ч' title3, cn_yellow datacl, cn_right dataal, 0 nlock, '' vmasks
       FROM DUAL
     UNION ALL
     SELECT -1 ID, '' title1, '' title2, 'т.кВт*ч' title3, cn_yellow datacl, cn_right dataal, 0 nlock, '' vmasks
       FROM DUAL
     UNION ALL
     SELECT -1 ID, '' title1, 'сальдо переток' title2, 'кВт*ч' title3, cn_yellow datacl, cn_right dataal, 0 nlock, '' vmasks
       FROM DUAL
     UNION ALL
     SELECT -1 ID, '' title1, '' title2, 'т.кВт*ч' title3, cn_yellow datacl, cn_right dataal, 0 nlock, '' vmasks
       FROM DUAL;
   ELSE
    OPEN row_t FOR
     SELECT t.ID, t.title1, t.title2, t.title3, t.datacl, t.dataal, t.nlock, t.vmasks
       FROM (SELECT   p.mid ID, NVL (util_pg.get_param (g2.vparam, 2), DECODE (f.vcode, '', '', f.vcode || '.') || /*pa*/ g2.NAME) title1,
                      NVL (util_pg.get_param (g.vparam, 2), p.NAME) title2, m.mtrsn title3, d.r, cn_white datacl, cn_right dataal, 0 nlock, '' vmasks
                 FROM GROUPS g,
                      feeders f,
                      meters m,
                      points p,
                      /*points pa,*/
                      GROUPS g2,
                      (SELECT ROWNUM r
                         FROM dict
                        WHERE ROWNUM <= 2) d
                WHERE g.gid IN (
                       SELECT     gid
                             FROM GROUPS
                       CONNECT BY PRIOR gid = PARENT
                                  AND (TO_CHAR (ad_from, 'yyyymm') <= NVL (ntillperiod, 299912) AND TO_CHAR (ad_till, 'yyyymm') >= NVL (nfromperiod, 160501))
                       START WITH gid = an_id
                                  AND (TO_CHAR (ad_from, 'yyyymm') <= NVL (ntillperiod, 299912) AND TO_CHAR (ad_till, 'yyyymm') >= NVL (nfromperiod, 160501)))
                      AND g.mid = f.mid AND f.mid = m.mid(+) AND m.entype(+) = 7 AND f.mid = p.mid(+)   /*AND p.PARENT = pa.mid(+)*/
                                                                                                     AND g.PARENT(+) = g2.gid
             --ORDER BY util_pg.allnumber_f(util_pg.get_param(g.VPARAM,1,';')), pa.NAME, pa.mid, p.NAME, p.mid, d.r
             ORDER BY util_pg.allnumber_f (util_pg.get_param (g2.vparam, 1, ';')),
                      util_pg.get_param (g2.vparam, 2),
                      g2.NAME,
                      g2.gid,
                      util_pg.allnumber_f (util_pg.get_param (g.vparam, 1, ';')),
                      util_pg.get_param (g.vparam, 2),
                      g.NAME,
                      g.mid,
                      d.r) t   -- сортировка по d.r значит - сначала прием, потом отдача
     UNION ALL
     SELECT -1 ID, 'Итого расход:' title1, 'за период' title2, 'кВт*ч' title3, cn_yellow datacl, cn_right dataal, 0 nlock, '' vmasks
       FROM DUAL
     UNION ALL
     SELECT -1 ID, '' title1, '' title2, 'т.кВт*ч' title3, cn_yellow datacl, cn_right dataal, 0 nlock, '' vmasks
       FROM DUAL
     UNION ALL
     SELECT -1 ID, '' title1, 'сальдо переток' title2, 'кВт*ч' title3, cn_yellow datacl, cn_right dataal, 0 nlock, '' vmasks
       FROM DUAL
     UNION ALL
     SELECT -1 ID, '' title1, '' title2, 'т.кВт*ч' title3, cn_yellow datacl, cn_right dataal, 0 nlock, '' vmasks
       FROM DUAL;
   END IF;
  ------------------------------- addded by Kondakov A.G. 08.10.2008
  ELSIF lv_proc = cv_proc4 THEN
   an_cnfixcol := 2;
   an_cntitle := 3;

   IF ln_locksum = 0 THEN
    an_cnfooter := 1;
   ELSE
    an_cnfooter := 0;
   END IF;

   OPEN col_t FOR
    SELECT -2 ID, 'Найм. ПС' title1, '' title2, '' title3, cn_btnface titlecl, cn_right titleal, cn_btnface datacl, cn_left dataal, 1 nlock, 180 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT -1 ID, 'Клас напруги' title1, '' title2, 'кВ' title3, cn_btnface titlecl, cn_right titleal, cn_btnface datacl, cn_center dataal, 1 nlock, 50 nwidth,
           '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 0 ID, 'Баланс по меж_ балансової належност_ ПС' title1, 'Прийом' title2, 'тис.кВт.г' title3, cn_btnface titlecl, cn_right titleal, cn_white datacl,
           cn_right dataal, 1 nlock, 90 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 1 ID, 'Баланс по меж_ балансової належност_ ПС' title1, 'В_ддача' title2, 'тис.кВт.г' title3, cn_btnface titlecl, cn_right titleal, cn_white datacl,
           cn_right dataal, 1 nlock, 90 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 2 ID, 'Баланс по меж_ балансової належност_ ПС' title1, 'Нбфакт.' title2, 'тис.кВт.г' title3, cn_btnface titlecl, cn_right titleal, cn_white datacl,
           cn_right dataal, 1 nlock, 70 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 2 ID, 'Баланс по меж_ балансової належност_ ПС' title1, 'Нбфакт.' title2, '%' title3, cn_btnface titlecl, cn_right titleal, cn_white datacl,
           cn_right dataal, 1 nlock, 60 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 3 ID, 'Баланс по меж_ балансової належност_ ПС' title1, 'Нбдоп.' title2, '%' title3, cn_btnface titlecl, cn_right titleal, cn_white datacl,
           cn_right dataal, 1 nlock, 60 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 0 ID, 'СН---->ПЛ 110(150 кВ)' title1, 'Прийом' title2, 'тис.кВт.г' title3, cn_btnface titlecl, cn_right titleal, cn_white datacl, cn_right dataal,
           1 nlock, 90 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 1 ID, 'СН---->ПЛ 110(150 кВ)' title1, 'В_ддача' title2, 'тис.кВт.г' title3, cn_btnface titlecl, cn_right titleal, cn_white datacl, cn_right dataal,
           1 nlock, 90 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 2 ID, 'СН---->ПЛ 110(150 кВ)' title1, 'Нбфакт.' title2, 'тис.кВт.г' title3, cn_btnface titlecl, cn_right titleal, cn_white datacl, cn_right dataal,
           1 nlock, 70 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 3 ID, 'СН---->ПЛ 110(150 кВ)' title1, 'Нбфакт.' title2, '%' title3, cn_btnface titlecl, cn_right titleal, cn_white datacl, cn_right dataal, 1 nlock,
           60 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 3 ID, 'СН---->ПЛ 110(150 кВ)' title1, 'Нбдоп.' title2, '%' title3, cn_btnface titlecl, cn_right titleal, cn_white datacl, cn_right dataal, 1 nlock,
           60 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 5 ID, 'ВП' title1, '' title2, 'тис.кВт.г' title3, cn_btnface titlecl, cn_left titleal, cn_white datacl, cn_right dataal, 1 nlock, 90 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 6 ID, 'ГП' title1, '' title2, 'тис.кВт.г' title3, cn_btnface titlecl, cn_left titleal, cn_white datacl, cn_right dataal, 1 nlock, 90 nwidth, '' vmasks
      FROM DUAL;

   IF an_ispoint <> 1 THEN
    OPEN row_t FOR
     SELECT t.ID, t.title1, t.title2, t.datacl, t.dataal, t.nlock, t.vmasks
       FROM (SELECT   g2.gid ID, NVL (util_pg.get_param (g1.vparam, 2), g1.NAME) title1, NVL (util_pg.get_param (g2.vparam, 2), g2.NAME) title2, cn_white datacl,
                      cn_right dataal, 0 nlock, '' vmasks
                 FROM GROUPS g1, GROUPS g2
                WHERE g1.PARENT = an_id AND g2.PARENT = g1.gid
                      AND (TO_CHAR (ad_from, 'yyyymm') <= NVL (g1.ntillperiod, 299912) AND TO_CHAR (ad_till, 'yyyymm') >= NVL (g1.nfromperiod, 160501))
                      AND (TO_CHAR (ad_from, 'yyyymm') <= NVL (g2.ntillperiod, 299912) AND TO_CHAR (ad_till, 'yyyymm') >= NVL (g2.nfromperiod, 160501))
             ORDER BY util_pg.allnumber_f (util_pg.get_param (g1.vparam, 1, ';')),
                      g1.NAME,
                      util_pg.allnumber_f (util_pg.get_param (g2.vparam, 1, ';')),
                      g2.NAME,
                      g2.gid) t   -- сортировка по d.r значит - сначала прием, потом отдача
     UNION ALL
     SELECT -1 ID, 'Итого:' title1, '' title2, cn_yellow datacl, cn_right dataal, 0 nlock, '' vmasks
       FROM DUAL
      WHERE ln_locksum = 0;
   END IF;
  ------------------------------- addded by Kondakov A.G. 08.10.2008
  ELSIF lv_proc = cv_proc5 THEN
   an_cnfixcol := 3;
   an_cntitle := 2;

   IF ln_locksum = 0 THEN
    an_cnfooter := 3;
   ELSE
    an_cnfooter := 0;
   END IF;

   OPEN col_t FOR
    SELECT 0 ID, 'Наименование фидера' title1, '' title2, cn_btnface titlecl, cn_center titleal, cn_btnface datacl, cn_left dataal, 1 nlock, 220 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 0 ID, '' title1, '' title2, cn_btnface titlecl, cn_center titleal, cn_btnface datacl, cn_center dataal, 1 nlock, 15 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT -2 ID, '№ счетчика' title1, '' title2, cn_btnface titlecl, cn_right titleal, cn_btnface datacl, cn_right dataal, 1 nlock, 75 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 1 ID, 'Показания счетчиков' title1, 'конец периода' title2, cn_btnface titlecl, cn_center titleal, cn_white datacl, cn_right dataal, 1 nlock, 95 nwidth,
           '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 2 ID, 'Показания счетчиков' title1, 'начало периода' title2, cn_btnface titlecl, cn_center titleal, cn_white datacl, cn_right dataal, 1 nlock, 95 nwidth,
           '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 3 ID, 'Разница показаний' title1, '' title2, cn_btnface titlecl, cn_center titleal, cn_white datacl, cn_right dataal, 1 nlock, 95 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 4 ID, 'Расчетный коэф-т' title1, '' title2, cn_btnface titlecl, cn_center titleal, cn_white datacl, cn_right dataal, 1 nlock, 75 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 5 ID, 'Выработка без недоучета, кВт*час' title1, '' title2, cn_btnface titlecl, cn_center titleal, cn_white datacl, cn_right dataal, 1 nlock, 95 nwidth,
           '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 6 ID, 'Недоучет' title1, '' title2, cn_btnface titlecl, cn_center titleal, cn_white datacl, cn_right dataal, 0 nlock, 95 nwidth, '' vmasks
      FROM DUAL;

   IF an_ispoint = 1 THEN
    OPEN row_t FOR
     SELECT *
       FROM (SELECT   p.mid ID, p.NAME title1, d.t title2, m.mtrsn title3, cn_white datacl, cn_right dataal, 0 nlock, '' vmasks
                 FROM feeders f,
                      meters m,
                      points p,
                      points pa,
                      (SELECT ROWNUM r, DECODE (ROWNUM, 1, '+', '-') t
                         FROM dict
                        WHERE ROWNUM <= 2) d
                WHERE f.mid IN (SELECT     mid
                                      FROM points
                                CONNECT BY PRIOR mid = PARENT
                                START WITH mid = an_id) AND f.mid = m.mid(+) AND m.entype(+) = 7 AND f.mid = p.mid(+) AND p.PARENT = pa.mid(+)
             ORDER BY pa.NAME, pa.mid, p.NAME, p.mid, d.t)   -- сортировка по d.t значит - сначала прием, потом отдача
     UNION ALL
     SELECT -1 ID, 'Итого:' title1, '' title2, 'прием' title3, cn_yellow datacl, cn_right dataal, 0 nlock, '' vmasks
       FROM DUAL
      WHERE ln_locksum = 0
     UNION ALL
     SELECT -1 ID, '' title1, '' title2, 'отдача' title3, cn_yellow datacl, cn_right dataal, 0 nlock, '' vmasks
       FROM DUAL
      WHERE ln_locksum = 0
     UNION ALL
     SELECT -1 ID, '' title1, '' title2, 'сальдо' title3, cn_yellow datacl, cn_right dataal, 0 nlock, '' vmasks
       FROM DUAL
      WHERE ln_locksum = 0;
   ELSE
    OPEN row_t FOR
     SELECT *
       FROM (SELECT   p.mid ID, NVL (util_pg.get_param (g.vparam, 2), p.NAME) title1, d.t title2, m.mtrsn title3, cn_white datacl, cn_right dataal, 0 nlock,
                      '' vmasks
                 FROM GROUPS g,
                      feeders f,
                      meters m,
                      points p,
                      points pa,
                      (SELECT ROWNUM r, DECODE (ROWNUM, 1, '+', '-') t
                         FROM dict
                        WHERE ROWNUM <= 2) d
                WHERE g.gid IN (
                       SELECT     gid
                             FROM GROUPS
                       CONNECT BY PRIOR gid = PARENT
                                  AND (TO_CHAR (ad_from, 'yyyymm') <= NVL (ntillperiod, 299912) AND TO_CHAR (ad_till, 'yyyymm') >= NVL (nfromperiod, 160501))
                       START WITH gid = an_id
                                  AND (TO_CHAR (ad_from, 'yyyymm') <= NVL (ntillperiod, 299912) AND TO_CHAR (ad_till, 'yyyymm') >= NVL (nfromperiod, 160501)))
                      AND g.mid = f.mid AND f.mid = m.mid(+) AND m.entype(+) = 7 AND f.mid = p.mid(+) AND p.PARENT = pa.mid(+)
             --AND (g.npartly IS NULL OR d.r = DECODE (g.npartly, 1, DECODE (g.inverted, 'y', 2, 1), DECODE (g.inverted, 'y', 1, 2)))
             ORDER BY util_pg.allnumber_f (util_pg.get_param (g.vparam, 1, ';')), pa.NAME, pa.mid, p.NAME, p.mid, d.t)   -- сортировка по d.t значит - сначала прием, потом отдача
     UNION ALL
     SELECT -1 ID, 'Итого:' title1, '' title2, 'прием' title3, cn_yellow datacl, cn_right dataal, 0 nlock, '' vmasks
       FROM DUAL
      WHERE ln_locksum = 0
     UNION ALL
     SELECT -1 ID, '' title1, '' title2, 'отдача' title3, cn_yellow datacl, cn_right dataal, 0 nlock, '' vmasks
       FROM DUAL
      WHERE ln_locksum = 0
     UNION ALL
     SELECT -1 ID, '' title1, '' title2, 'сальдо' title3, cn_yellow datacl, cn_right dataal, 0 nlock, '' vmasks
       FROM DUAL
      WHERE ln_locksum = 0;
   END IF;
  ------------------------------- addded by Kondakov A.G. 13.10.2008
  ELSIF lv_proc = cv_proc6 THEN
   an_cnfixcol := 2;
   an_cntitle := 2;

   IF ln_locksum = 0 THEN
    an_cnfooter := 3;
   ELSE
    an_cnfooter := 0;
   END IF;

   OPEN col_t FOR
    SELECT 0 ID, 'Присоединение' title1, '' title2, cn_btnface titlecl, cn_right titleal, cn_btnface datacl, cn_left dataal, 1 nlock, 220 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 0 ID, '' title1, '' title2, cn_btnface titlecl, cn_center titleal, cn_btnface datacl, cn_center dataal, 1 nlock, 15 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT -2 ID, 'Серийный № осн. счетчика' title1, '' title2, cn_btnface titlecl, cn_right titleal, cn_white datacl, cn_right dataal, 1 nlock, 75 nwidth,
           '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 1 ID, 'Расход, кВт*ч' title1, '' title2, cn_btnface titlecl, cn_center titleal, cn_white datacl, cn_right dataal, 1 nlock, 95 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 2 ID, '' title1, '' title2, cn_btnface titlecl, cn_center titleal, cn_white datacl, cn_right dataal, 1 nlock, 10 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 3 ID, 'Серийный № дубл. счетчика' title1, '' title2, cn_btnface titlecl, cn_center titleal, cn_white datacl, cn_right dataal, 1 nlock, 75 nwidth,
           '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 4 ID, 'Расход, кВт*ч' title1, '' title2, cn_btnface titlecl, cn_center titleal, cn_white datacl, cn_right dataal, 1 nlock, 95 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 5 ID, 'Разница' title1, 'кВт*ч' title2, cn_btnface titlecl, cn_center titleal, cn_white datacl, cn_right dataal, 1 nlock, 95 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 6 ID, 'Разница' title1, '%' title2, cn_btnface titlecl, cn_center titleal, cn_white datacl, cn_right dataal, 0 nlock, 95 nwidth, '' vmasks
      FROM DUAL;

   IF an_ispoint = 1 THEN
    OPEN row_t FOR
     SELECT *
       FROM (SELECT   p.mid ID, p.NAME title1, d.t title2, cn_white datacl, cn_right dataal, 0 nlock, '' vmasks
                 FROM points p,
                      feeders f,
                      meters m,
                      points pa,   --------
                      feeders fd,
                      meters md,
                      (SELECT ROWNUM r, DECODE (ROWNUM, 1, '+', '-') t
                         FROM dict
                        WHERE ROWNUM <= 2) d
                WHERE f.mid IN (SELECT     mid   ---- p.mid->f.mid
                                      FROM points
                                CONNECT BY PRIOR mid = PARENT
                                START WITH mid = an_id) AND p.mid = f.mid AND f.mid = m.mid(+) AND m.entype(+) = 7 AND p.PARENT = pa.mid(+)   -------
                      AND p.mid = fd.nmainpoint AND fd.mid = md.mid(+) AND md.entype(+) = 7
             ORDER BY pa.mid, p.NAME, p.mid, d.t)   -- сортировка по d.t значит - сначала прием, потом отдача
     UNION ALL
     SELECT -1 ID, 'Итого:  прием' title1, '' title2, cn_yellow datacl, cn_right dataal, 0 nlock, '' vmasks
       FROM DUAL
      WHERE ln_locksum = 0
     UNION ALL
     SELECT -1 ID, 'отдача' title1, '' title2, cn_yellow datacl, cn_right dataal, 0 nlock, '' vmasks
       FROM DUAL
      WHERE ln_locksum = 0
     UNION ALL
     SELECT -1 ID, 'сальдо' title1, '' title2, cn_yellow datacl, cn_right dataal, 0 nlock, '' vmasks
       FROM DUAL
      WHERE ln_locksum = 0;
   ELSE
    OPEN row_t FOR
     SELECT *
       FROM (SELECT   p.mid ID, NVL (util_pg.get_param (g.vparam, 2), p.NAME) title1, d.t title2, cn_white datacl, cn_right dataal, 0 nlock, '' vmasks
                 FROM GROUPS g,
                      feeders f,
                      meters m,
                      points p,
                      points pa,
                      feeders fd,
                      meters md,
                      (SELECT ROWNUM r, DECODE (ROWNUM, 1, '+', '-') t
                         FROM dict
                        WHERE ROWNUM <= 2) d
                WHERE g.gid IN (
                       SELECT     gid
                             FROM GROUPS
                       CONNECT BY PRIOR gid = PARENT
                                  AND (TO_CHAR (ad_from, 'yyyymm') <= NVL (ntillperiod, 299912) AND TO_CHAR (ad_till, 'yyyymm') >= NVL (nfromperiod, 160501))
                       START WITH gid = an_id
                                  AND (TO_CHAR (ad_from, 'yyyymm') <= NVL (ntillperiod, 299912) AND TO_CHAR (ad_till, 'yyyymm') >= NVL (nfromperiod, 160501)))
                      AND g.mid = f.mid AND f.mid = p.mid /*(+)*/ AND p.PARENT = pa.mid(+) AND f.mid = m.mid(+) AND m.entype(+) = 7 AND p.mid = fd.nmainpoint
                      AND fd.mid = md.mid(+) AND md.entype(+) = 7
             --AND (g.npartly IS NULL OR d.r = DECODE (g.npartly, 1, DECODE (g.inverted, 'y', 2, 1), DECODE (g.inverted, 'y', 1, 2)))
             ORDER BY util_pg.allnumber_f (util_pg.get_param (g.vparam, 1, ';')), pa.NAME, pa.mid, p.NAME, p.mid, d.t)   -- сортировка по d.t значит - сначала прием, потом отдача
     UNION ALL
     SELECT -1 ID, 'Итого:  прием' title1, '' title2, cn_yellow datacl, cn_right dataal, 0 nlock, '' vmasks
       FROM DUAL
      WHERE ln_locksum = 0
     UNION ALL
     SELECT -1 ID, 'отдача' title1, '' title2, cn_yellow datacl, cn_right dataal, 0 nlock, '' vmasks
       FROM DUAL
      WHERE ln_locksum = 0
     UNION ALL
     SELECT -1 ID, 'сальдо' title1, '' title2, cn_yellow datacl, cn_right dataal, 0 nlock, '' vmasks
       FROM DUAL
      WHERE ln_locksum = 0;
   END IF;
  ------------------------------- addded by Kondakov A.G. 13.10.2008
  ELSIF lv_proc = cv_proc7 THEN
   an_cnfixcol := 3;
   an_cntitle := 2;

   IF ln_locksum = 0 THEN
    an_cnfooter := 1;
   ELSE
    an_cnfooter := 0;
   END IF;

   OPEN col_t FOR
    SELECT 0 ID, '№ п/п' title1, '' title2, cn_btnface titlecl, cn_center titleal, cn_btnface datacl, cn_left dataal, 1 nlock, 30 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT -1 ID, 'Объект' title1, '' title2, cn_btnface titlecl, cn_right titleal, cn_btnface datacl, cn_left dataal, 1 nlock, 200 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT -2 ID, 'Параметр суточный' title1, '' title2, cn_btnface titlecl, cn_right titleal, cn_btnface datacl, cn_left dataal, 1 nlock, 200 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 1 ID, 'Факт. зн.' title1, '' title2, cn_btnface titlecl, cn_right titleal, cn_white datacl, cn_right dataal, 1 nlock, 105 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 2 ID, 'Инт.зн.' title1, '' title2, cn_btnface titlecl, cn_right titleal, cn_white datacl, cn_right dataal, 1 nlock, 105 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 3 ID, 'Откл.' title1, '' title2, cn_btnface titlecl, cn_center titleal, cn_white datacl, cn_left dataal, 1 nlock, 60 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 3 ID, 'Откл. %' title1, '' title2, cn_btnface titlecl, cn_center titleal, cn_white datacl, cn_left dataal, 1 nlock, 60 nwidth, '' vmasks
      FROM DUAL;

   IF an_ispoint <> 1 THEN
    OPEN row_t FOR
     SELECT t.ID, ROWNUM || '.' title1, t.title2, t.title3, t.datacl, t.dataal, t.nlock, t.vmasks
       FROM (SELECT   NVL (util_pg.get_param (g2.vparam, 2), g2.NAME) title2, NVL (util_pg.get_param (g1.vparam, 2), g1.NAME) title3, g1.gid ID, cn_white datacl,
                      cn_right dataal, 0 nlock, '' vmasks
                 FROM (SELECT     g.gid, g.PARENT, g.NAME, g.vparam
                             FROM GROUPS g
                            WHERE EXISTS (SELECT *
                                            FROM GROUPS
                                           WHERE PARENT = g.gid AND mid IS NOT NULL)
                       CONNECT BY PRIOR gid = PARENT
                                  AND (TO_CHAR (ad_from, 'yyyymm') <= NVL (ntillperiod, 299912) AND TO_CHAR (ad_till, 'yyyymm') >= NVL (nfromperiod, 160501))
                       START WITH gid = an_id
                                  AND (TO_CHAR (ad_from, 'yyyymm') <= NVL (ntillperiod, 299912) AND TO_CHAR (ad_till, 'yyyymm') >= NVL (nfromperiod, 160501))) g1,
                      GROUPS g2
                WHERE g1.PARENT = g2.gid
             ORDER BY util_pg.allnumber_f (util_pg.get_param (g2.vparam, 1, ';')),
                      NVL (util_pg.get_param (g2.vparam, 2), g2.NAME),
                      util_pg.allnumber_f (util_pg.get_param (g1.vparam, 1, ';')),
                      NVL (util_pg.get_param (g1.vparam, 2), g1.NAME),
                      g1.gid) t
     UNION ALL
     SELECT -1 ID, '' title1, '' title2, 'Итого:' title3, cn_yellow datacl, cn_left dataal, 0 nlock, '' vmasks
       FROM DUAL;
   END IF;
  ------------------------------- addded by Kondakov A.G. 14.10.2008
  ELSIF lv_proc = cv_proc8 THEN
   an_cnfixcol := 2;
   an_cntitle := 2;

   IF ln_locksum = 0 THEN
    an_cnfooter := 1;
   ELSE
    an_cnfooter := 0;
   END IF;

   OPEN col_t FOR
    SELECT 0 ID, '№' title1, '' title2, cn_btnface titlecl, cn_center titleal, cn_btnface datacl, cn_left dataal, 1 nlock, 20 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT -2 ID, 'Наменование перетока' title1, '' title2, cn_btnface titlecl, cn_right titleal, cn_btnface datacl, cn_left dataal, 1 nlock, 235 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 1 ID, 'Прием' title1, 'тыс.кВтч' title2, cn_btnface titlecl, cn_center titleal, cn_white datacl, cn_right dataal, 1 nlock, 95 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 2 ID, 'Отдача' title1, 'тыс.кВтч' title2, cn_btnface titlecl, cn_center titleal, cn_white datacl, cn_right dataal, 1 nlock, 95 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 3 ID, 'Сальдо' title1, 'тыс.кВтч' title2, cn_btnface titlecl, cn_center titleal, cn_white datacl, cn_right dataal, 1 nlock, 95 nwidth, '' vmasks
      FROM DUAL;

   IF an_ispoint <> 1 THEN
    OPEN row_t FOR
     SELECT t.ID, ROWNUM || '.' title1, t.title2, t.datacl, t.dataal, t.nlock, t.vmasks
       FROM (SELECT   g.gid ID, NVL (util_pg.get_param (g.vparam, 2), g.NAME) title2, cn_white datacl, cn_right dataal, 0 nlock, '' vmasks
                 FROM GROUPS g
                WHERE g.mid > 0
                      AND g.gid IN (
                          SELECT     gid
                                FROM GROUPS
                          CONNECT BY PRIOR gid = PARENT
                                     AND (TO_CHAR (ad_from, 'yyyymm') <= NVL (ntillperiod, 299912) AND TO_CHAR (ad_till, 'yyyymm') >= NVL (nfromperiod, 160501))
                          START WITH gid = an_id
                                     AND (TO_CHAR (ad_from, 'yyyymm') <= NVL (ntillperiod, 299912) AND TO_CHAR (ad_till, 'yyyymm') >= NVL (nfromperiod, 160501)))
             ORDER BY util_pg.allnumber_f (util_pg.get_param (g.vparam, 1, ';')), g.PARENT, g.NAME, g.gid) t
     UNION ALL
     SELECT -1 ID, '' title1, 'Итого:' title2, cn_yellow datacl, cn_left dataal, 0 nlock, '' vmasks
       FROM DUAL;
   END IF;
  ------------------------------- addded by Круглова 13.10.2008
  ELSIF lv_proc = cv_proc9 THEN
   an_cnfixcol := 2;
   an_cntitle := 1;
   an_cnfooter := 2;

   OPEN col_t FOR
    SELECT 0 ID, '№' title1, cn_btnface titlecl, cn_center titleal, cn_btnface datacl, cn_left dataal, 1 nlock, 45 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT -2 ID, 'Составляющие баланса' title1, cn_btnface titlecl, cn_right titleal, cn_btnface datacl, cn_left dataal, 1 nlock, 260 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 1 ID, 'Поступление в сеть' title1, cn_btnface titlecl, cn_center titleal, cn_white datacl, cn_right dataal, 1 nlock, 120 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 2 ID, 'Отпуск в сети' title1, cn_btnface titlecl, cn_center titleal, cn_white datacl, cn_right dataal, 1 nlock, 120 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 3 ID, 'Сальдо' title1, cn_btnface titlecl, cn_center titleal, cn_white datacl, cn_right dataal, 1 nlock, 120 nwidth, '' vmasks
      FROM DUAL;

   utilrep_pg.f_preparesortbyl_n;   --У нас особая сортировка

   OPEN row_t FOR
    SELECT     gid ID, DECODE (LEVEL, 1, '1.' || TO_CHAR (utilrep_pg.f_makeindex (ROWNUM, gid, an_id)), '') title1, LPAD (' ', 2 * (LEVEL - 1)) || NAME title2,
               DECODE (LEVEL, 1, cn_sumtec, cn_white) datacl, cn_right dataal, 0 nlock, '' vmasks, utilrep_pg.f_sortbyl_n (ROWNUM, gid, an_id) srt
          FROM GROUPS
    CONNECT BY PRIOR gid = PARENT
    START WITH PARENT = an_id
    UNION ALL
    SELECT   -1 ID, '' title1, 'Итого' title2, cn_yellow datacl, cn_left dataal, 0 nlock, '' vmasks, 1000000000 srt
        FROM DUAL
    UNION ALL
    SELECT   -2 ID, '' title1, 'Потери, %' title2, cn_yellow datacl, cn_left dataal, 0 nlock, '' vmasks, 1000000001 srt
        FROM DUAL
    ORDER BY 8;
--------------------------------- VNB 5.02.2009
  ELSIF lv_proc = cv_proc10 THEN
   an_cnfixcol := 2;
   an_cntitle := 2;

   
   OPEN col_t FOR
     SELECT   1 ID, 'Наименование' title1, '' title2, cn_btnface titlecl, cn_center titleal, cn_btnface datacl, cn_left dataal, 1 nlock, 240 nwidth, '' vmasks
        FROM DUAL
    UNION ALL
    SELECT   2 ID, ' Прием / Отдача Сальдо ' title1, '' title2, cn_btnface titlecl, cn_center titleal, cn_btnface datacl, cn_left dataal, 1 nlock, 50 nwidth, '' vmasks
        FROM DUAL
    UNION ALL
    SELECT   3 ID, 'Сумма' title1, '' title2, cn_btnface titlecl, cn_center titleal, cn_yellow datacl, cn_right dataal, 1 nlock, 90 nwidth, '' vmasks
        FROM DUAL
    UNION ALL
    SELECT   t.ID + 4, 'Показания за' || ' ' || TO_CHAR (ad_from, 'dd.mm.yyyy') title1, DECODE(t.ID,25,'25:00',TO_CHAR (TO_DATE (DECODE (t.ID, 24, 0, t.ID), 'hh24'), 'hh24:mi')) title2,
             cn_btnface titlecl, cn_center titleal, cn_white datacl, cn_right dataal, 1 nlock, 60 nwidth, '' vmasks
        FROM (SELECT ROWNUM ID
                FROM dict
               WHERE ROWNUM <= 25
                                  
             ) t
    ORDER BY 1;

  
   OPEN row_t FOR
    SELECT tt.gid ID, decode(nvl(tt.npartly,0),1,tt.name,2,tt.name,decode(tt.sort,1,tt.name,' ')) title1, tt.title2, tt.datacl, 0 nlock, '' vmasks
 
      FROM (
          SELECT   NVL (mid, 0) mid, PARENT, nvl(util_pg.get_shortname_f(short_name,mid),util_pg.get_name_f(name,mid))name, ' Прием ' title2, 1 sort, (gid * 10 + 1) gid, npartly, cn_white datacl
          --  SELECT   NVL (mid, 0) mid, PARENT, NAME, ' Прием ' title2, 1 sort, (gid * 10 + 1) gid, npartly, cn_white datacl
                FROM GROUPS g
               WHERE gid IN (SELECT     gid
                                   FROM GROUPS
                             CONNECT BY PRIOR gid = PARENT
                             START WITH PARENT = an_id) AND mid > 0 AND (g.npartly IS NULL OR g.npartly = 1)
            UNION ALL
           -- SELECT   NVL (mid, 0) mid, PARENT, DECODE (NVL (mid, 0), 0, '', NAME) NAME, ' Отдача ' title2, 2 sort, (gid * 10 + 2) gid, npartly, cn_white datacl
           SELECT   NVL (mid, 0) mid, PARENT, nvl(util_pg.get_shortname_f(short_name,mid),util_pg.get_name_f(name,mid)) NAME, ' Отдача ' title2, 2 sort, (gid * 10 + 2) gid, npartly, cn_white datacl
                FROM GROUPS g
               WHERE gid IN (SELECT     gid
                                   FROM GROUPS
                             CONNECT BY PRIOR gid = PARENT
                             START WITH PARENT = an_id) AND mid > 0 AND (g.npartly IS NULL OR g.npartly = 2)
            UNION ALL
         --   SELECT   NVL (mid, 0) mid, PARENT, DECODE (NVL (mid, 0), 0, '',  NAME) NAME, ' Сальдо' title2, 3 sort, (gid * 10) gid, npartly, cn_aqua datacl
            SELECT   NVL (mid, 0) mid, PARENT,nvl(util_pg.get_shortname_f(short_name,mid),util_pg.get_name_f(name,mid)) NAME, ' Сальдо' title2, 3 sort, (gid * 10) gid, npartly, cn_aqua datacl
                FROM GROUPS g
               WHERE gid IN (SELECT     gid
                                   FROM GROUPS
                             CONNECT BY PRIOR gid = PARENT
                             START WITH PARENT = an_id) AND mid > 0 AND (npartly IS NULL)
            ORDER BY 2, 3, 5) tt;
 ------------------------------- added by Круглова 24.02.2009------------------
------------------------------- eddited by Круглова 10.03.2009------------------            
  ELSIF lv_proc = cv_proc11 THEN
   an_cnfixcol := 3;
   an_cntitle := 2;
   an_cnfooter := 0;

   OPEN col_t FOR
    SELECT -1 ID, 'Наименование объекта' title1, '' title2, cn_btnface titlecl, cn_center titleal, cn_btnface datacl, cn_left dataal, 1 nlock, 150 nwidth, '' vmasks
      FROM DUAL
      UNION ALL
    SELECT 0 ID, 'Наименование точки' title1, '' title2, cn_btnface titlecl, cn_center titleal, cn_btnface datacl, cn_left dataal, 1 nlock, 180 nwidth, '' vmasks
      FROM DUAL
      UNION ALL
    SELECT 0 ID, 'Дата' title1, '' title2, cn_btnface titlecl, cn_center titleal, cn_white datacl, cn_center dataal, 1 nlock, 108 nwidth, '' vmasks
      FROM DUAL
      UNION ALL
    SELECT 1 ID, 'Линейное напряжение, В' title1, 'Ua' title2, cn_btnface titlecl, cn_center titleal, cn_white datacl, cn_center dataal, 1 nlock, 80 nwidth, '' vmasks
      FROM DUAL
      UNION ALL
    SELECT 2 ID, 'Линейное напряжение, В' title1, 'Ub' title2, cn_btnface titlecl, cn_center titleal, cn_white datacl, cn_center dataal, 1 nlock, 80 nwidth, '' vmasks
      FROM DUAL
      UNION ALL
    SELECT 3 ID, 'Линейное напряжение, В' title1, 'Uc' title2, cn_btnface titlecl, cn_center titleal, cn_white datacl, cn_center dataal, 1 nlock, 80 nwidth, '' vmasks
      FROM DUAL
      UNION ALL
    SELECT 4 ID, 'Ток, А' title1, 'Ia' title2, cn_btnface titlecl, cn_center titleal, cn_white datacl, cn_center dataal, 1 nlock, 50 nwidth, '' vmasks
      FROM DUAL
      UNION ALL
    SELECT 5 ID, 'Ток, А' title1, 'Ib' title2, cn_btnface titlecl, cn_center titleal, cn_white datacl, cn_center dataal, 1 nlock, 50 nwidth, '' vmasks
      FROM DUAL
      UNION ALL
    SELECT 6 ID, 'Ток, А' title1, 'Ic' title2, cn_btnface titlecl, cn_center titleal, cn_white datacl, cn_center dataal, 1 nlock, 50 nwidth, '' vmasks
      FROM DUAL
      UNION ALL
    SELECT 7 ID, 'Частота напряжения сети, Гц' title1, '' title2, cn_btnface titlecl, cn_center titleal, cn_white datacl, cn_center dataal, 1 nlock, 150 nwidth, '' vmasks
      FROM DUAL
      UNION ALL
    SELECT 8 ID, 'Фазовый сдвиг' title1, '' title2, cn_btnface titlecl, cn_center titleal, cn_white datacl, cn_center dataal, 1 nlock, 80 nwidth, '' vmasks
      FROM DUAL;
   OPEN row_t FOR

 SELECT -1 ID, parent title1,name title2, TO_CHAR(dt,'DD.MM.YYYY HH24:MI:SS') title3, cn_white datacl, 0 nlock, '' vmasks, 1000000000 srt FROM
 (SELECT g1.name parent,g.name name, g.mid, TO_DATE(tt.dt,'DD.MM.YYYY HH24:MI:SS') dt FROM
 (SELECT name,parent,mid FROM groups
    WHERE mid>0 CONNECT BY PRIOR gid=parent START WITH parent=an_id) g,
    groups g1, (SELECT mid, TO_CHAR(max(date_time),'DD.MM.YYYY HH24:MI:SS') dt from curr_power_arch where date_time<=ad_from
    AND mid IN(SELECT g.mid FROM
 (SELECT name,parent,mid FROM groups
    WHERE mid>0 CONNECT BY PRIOR gid=parent START WITH parent=an_id) g,
    groups g1
    WHERE g1.gid=g.parent) GROUP by mid)tt
    WHERE g1.gid=g.parent AND g.mid=tt.mid
    UNION ALL
 SELECT g1.name parent,g.name name, g.mid, TO_DATE('','DD.MM.YYYY HH24:MI:SS') dt FROM
(SELECT name,parent,mid FROM groups
    WHERE mid>0 CONNECT BY PRIOR gid=parent START WITH parent=an_id) g,
    groups g1
    WHERE g1.gid=g.parent
    MINUS
SELECT g1.name parent,g.name name, g.mid, TO_DATE('','DD.MM.YYYY HH24:MI:SS') dt FROM
(SELECT name,parent,mid FROM groups
    WHERE mid>0 CONNECT BY PRIOR gid=parent START WITH parent=an_id) g,
    groups g1
    WHERE g1.gid=g.parent AND g.mid IN((SELECT g.mid FROM
(SELECT name,parent,mid FROM groups
    WHERE mid>0 CONNECT BY PRIOR gid=parent START WITH parent=an_id) g,
    groups g1, (SELECT mid, TO_CHAR(max(date_time),'DD.MM.YYYY HH24:MI:SS') dt from curr_power_arch where date_time<=ad_from AND
    mid IN(SELECT g.mid FROM
(SELECT name,parent,mid FROM groups
    WHERE mid>0 CONNECT BY PRIOR gid=parent START WITH parent=an_id) g,
    groups g1
    WHERE g1.gid=g.parent) GROUP by mid)tt
    WHERE g1.gid=g.parent AND g.mid=tt.mid))    
    ORDER BY 1,2);
   
 /*   SELECT -1 ID, g1.name title1,g.name title2, ''title3, cn_white datacl, 0 nlock, '' vmasks, 1000000000 srt FROM 
    (SELECT name,parent,mid FROM groups
    WHERE mid>0 CONNECT BY PRIOR gid=parent START WITH parent=an_id) g,
    groups g1
    WHERE g1.gid=g.parent 
    ORDER BY 1,2;*/
 ------------------------------- added by Круглова 24.02.2009------------------
------------------------------- edite by Круглова 10.03.2009------------------
  ELSIF lv_proc = cv_proc12 THEN
   an_cnfixcol := 3;
   an_cntitle := 2;
   an_cnfooter := 0;

   OPEN col_t FOR
    SELECT -2 ID, 'Наименование объекта' title1, '' title2, cn_btnface titlecl, cn_center titleal, cn_btnface datacl, cn_left dataal, 1 nlock, 150 nwidth, '' vmasks
      FROM DUAL
      UNION ALL
    SELECT -1 ID, 'Наименование точки' title1, '' title2, cn_btnface titlecl, cn_center titleal, cn_btnface datacl, cn_left dataal, 1 nlock, 200 nwidth, '' vmasks
      FROM DUAL
      UNION ALL
    SELECT 0 ID, '№ устр. учета' title1, '' title2, cn_btnface titlecl, cn_center titleal, cn_white datacl, cn_center dataal, 1 nlock, 130 nwidth, '' vmasks
      FROM DUAL
      UNION ALL
    SELECT 1 ID, 'Показания' title1, 'Активная энергия, кВтч' title2, cn_btnface titlecl, cn_center titleal, cn_white datacl, cn_left dataal, 1 nlock, 120 nwidth, '' vmasks
      FROM DUAL
      UNION ALL
    SELECT 2 ID, 'Показания' title1, 'Реактивная энергия, кВАрч' title2, cn_btnface titlecl, cn_center titleal, cn_white datacl, cn_left dataal, 1 nlock, 120 nwidth, '' vmasks
      FROM DUAL
      UNION ALL
    SELECT 3 ID, 'Показания' title1, 'Генерация, кВАрч' title2, cn_btnface titlecl, cn_center titleal, cn_white datacl, cn_left dataal, 1 nlock, 120 nwidth, '' vmasks
      FROM DUAL;

   OPEN row_t FOR
     
    SELECT -1 ID, pname title1,name title2, meter title3, 
    cn_white datacl, 0 nlock, '' vmasks, 1000000000 srt FROM
    (SELECT g1.name pname, g.name name, m.mtrsn meter FROM 
     (SELECT name,parent,mid FROM groups
        WHERE mid>0 CONNECT BY PRIOR gid=parent START WITH parent=an_id) g,groups g1, meters m
        WHERE g1.gid=g.parent AND m.mid=g.mid
        ORDER BY 1,2);
------------------------------- added by Круглова 24.02.2009--------------------
  ELSIF lv_proc = cv_proc13 THEN
   an_cnfixcol := 2;
   an_cntitle := 1;
   an_cnfooter := 0;

   OPEN col_t FOR
    SELECT -1 ID, 'Наименование объекта' title1,  cn_btnface titlecl, cn_center titleal, cn_btnface datacl, cn_left dataal, 1 nlock, 150 nwidth, '' vmasks
      FROM DUAL
      UNION ALL
    SELECT 0 ID, 'Наименование точки' title1,  cn_btnface titlecl, cn_center titleal, cn_btnface datacl, cn_left dataal, 1 nlock, 200 nwidth, '' vmasks
      FROM DUAL
      UNION ALL
    SELECT 1 ID, 'Расход по точке, кВтч' title1,  cn_btnface titlecl, cn_center titleal, cn_white datacl, cn_center dataal, 1 nlock, 130 nwidth, '' vmasks
      FROM DUAL
      UNION ALL
    SELECT 2 ID, 'Расход по группе, кВтч' title1,  cn_btnface titlecl, cn_center titleal, cn_white datacl, cn_center dataal, 1 nlock, 120 nwidth, '' vmasks
      FROM DUAL;
      
    OPEN row_t FOR
     
    SELECT -1 ID, g1.name title1,g.name title2, cn_white datacl, 0 nlock, '' vmasks, 1000000000 srt FROM
     (SELECT name,parent,mid FROM groups
        WHERE mid>0 CONNECT BY PRIOR gid=parent START WITH parent=an_id) g,groups g1
        WHERE g1.gid=g.parent 
        ORDER BY 1,2;
        
-------------------------- added by Круглова 24.02.2009--------------------
  ELSIF lv_proc = cv_proc14 THEN
   an_cnfixcol := 4;
   an_cntitle := 2;
   an_cnfooter := 0;

   OPEN col_t FOR
    SELECT -1 ID, '№ п/п' title1, '' title2,  cn_btnface titlecl, cn_center titleal, cn_btnface datacl, cn_center dataal, 1 nlock, 25 nwidth, '' vmasks
      FROM DUAL
      UNION ALL
    SELECT 0 ID, 'Название точки' title1, '' title2,  cn_btnface titlecl, cn_center titleal, cn_btnface datacl, cn_left dataal, 1 nlock, 200 nwidth, '' vmasks
      FROM DUAL
      UNION ALL
    SELECT 1 ID, '№ устр. учета' title1, '' title2,  cn_btnface titlecl, cn_center titleal, cn_white datacl, cn_center dataal, 1 nlock, 130 nwidth, '' vmasks
      FROM DUAL
      UNION ALL
    SELECT 2 ID, 'Вид э/э' title1, '' title2, cn_btnface titlecl, cn_center titleal, cn_white datacl, cn_center dataal, 1 nlock, 60 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 3 ID, 'Показания счетчика' title1, 'наст.' title2, cn_btnface titlecl, cn_center titleal, cn_white datacl, cn_center dataal, 1 nlock, 100 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 4 ID, 'Показания счетчика' title1, 'пред.' title2, cn_btnface titlecl, cn_center titleal, cn_white datacl, cn_center dataal, 1 nlock, 100 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 5 ID, 'Разность' title1, '' title2,  cn_btnface titlecl, cn_center titleal, cn_white datacl, cn_center dataal, 1 nlock, 100 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 6 ID, 'К-т' title1, '' title2, cn_btnface titlecl, cn_center titleal, cn_white datacl, cn_center dataal, 1 nlock, 100 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 7 ID, 'Расход э/э по т.у.' title1, '' title2, cn_btnface titlecl, cn_center titleal, cn_white datacl, cn_center dataal, 1 nlock, 120 nwidth, '' vmasks
      FROM DUAL;
      
    OPEN row_t FOR
         
    SELECT -1 ID, TO_CHAR (ROWNUM) title1,name title2, mtrsn title3, AR title4, cn_white datacl, 0 nlock, '' vmasks, 1000000000 srt FROM 
    
   (SELECT DISTINCT tt.name, tt.gID, tt.AR, m.mtrsn FROM
    (((SELECT name, gID, 'A' AR, mid FROM  
    (SELECT name, gID, mid FROM groups
        WHERE mid>0 CONNECT BY PRIOR gid=parent START WITH parent=an_id)t 
        
        UNION ALL
    SELECT name, gID, 'R' AR, mid FROM  
    (SELECT name, gID, mid FROM groups
        WHERE mid>0 CONNECT BY PRIOR gid=parent START WITH parent=an_id)t2)  
        
        ))tt, meters m WHERE m.mid=tt.mid ORDER BY 1, 2, 3);

-------------------------- added by Круглова 24.02.2009--------------------
------------------------------- edited by Круглова 04.03.2009------------------
  ELSIF lv_proc = cv_proc15 THEN
   an_cnfixcol := 2;
   an_cntitle := 2;
   an_cnfooter := 0;

   SELECT ABS(TO_DATE(ad_till,'DD.MM.YYYY') - TO_DATE(ad_from,'DD.MM.YYYY')) INTO interv from DUAL;
   interv:=interv+1;
   OPEN col_t FOR
    SELECT -2 ID, '' title1,'' title2, cn_btnface titlecl, cn_center titleal, cn_btnface datacl, cn_center dataal, 1 nlock, 25 nwidth, '' vmasks
      FROM DUAL
      UNION ALL
    SELECT -1 ID, 'ДАТА' title1,'' title2, cn_btnface titlecl, cn_center titleal, cn_white datacl, cn_center dataal, 1 nlock, 70 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 0 ID, parent title1,name title2, cn_btnface titlecl, cn_center titleal, cn_white datacl, cn_left dataal, 1 nlock, 70 nwidth, '' vmasks FROM
     (SELECT g1.name parent,g.name name, g.mid, g.g FROM 
     (SELECT name ||' Показ.сч.' name,parent, mid,1 g FROM groups
        WHERE mid>0 CONNECT BY PRIOR gid=parent START WITH parent=an_id
        UNION ALL
SELECT 'Расход' name, parent,mid, 2 g FROM groups
        WHERE mid>0 CONNECT BY PRIOR gid=parent START WITH parent=an_id
        
        ORDER BY 3,4) g,groups g1
        WHERE g1.gid=g.parent 
        
        ORDER BY 1,3,4);
     /*(SELECT g1.name parent,g.name name FROM 
     (SELECT name,parent,mid FROM groups
        WHERE mid>0 CONNECT BY PRIOR gid=parent START WITH parent=an_id) g,groups g1
        WHERE g1.gid=g.parent 
        ORDER BY 1,2);*/
        /*UNION ALL
        SELECT  ''name,'ИТОГО' parent FROM dual;*/


   OPEN row_t FOR
   SELECT ROWNUM ID, TO_CHAR (ROWNUM) title1, TO_CHAR((ad_from+ROWNUM-1),'DD.MM.YYYY') title2, cn_white datacl, 0 nlock, '' vmasks, 1000000000 srt FROM dual CONNECT BY ROWNUM <= interv;
------------------------------- added by Круглова 30.03.2009------------------
------------------------------- edited by Круглова 31.03.2009------------------
  ELSIF lv_proc = cv_proc16 THEN
   an_cnfixcol := 2;
   an_cntitle := 2;
   an_cnfooter := 0;
   
   IF (TO_CHAR(ad_from,'HH24'))<20 AND(TO_CHAR(ad_from,'HH24'))>=8 THEN
        smena:=TO_DATE('01-янв-2009 08:00','DD-MON-YYYY HH24:MI');
   ELSE 
        smena:=TO_DATE('01-янв-2009 20:00','DD-MON-YYYY HH24:MI');
   END IF;
 
    
   OPEN col_t FOR
    SELECT -1 ID, '№ п/п' title1, '' title2,  cn_btnface titlecl, cn_center titleal, cn_btnface datacl, cn_center dataal, 1 nlock, 50 nwidth, '' vmasks
      FROM DUAL
      UNION ALL
    SELECT 0 ID, 'Наименование показателя' title1, '' title2,  cn_btnface titlecl, cn_center titleal, cn_btnface datacl, cn_left dataal, 1 nlock, 200 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 1 ID, 'Час смены' title1, TO_CHAR(smena+0.042,'HH24')||':00' title2,  cn_btnface titlecl, cn_center titleal, cn_white datacl, cn_left dataal, 1 nlock, 50 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 1 ID, 'Час смены' title1, TO_CHAR(smena+(0.042*2),'HH24')||':00' title2,  cn_btnface titlecl, cn_center titleal, cn_white datacl, cn_left dataal, 1 nlock, 50 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 1 ID, 'Час смены' title1, TO_CHAR(smena+(0.042*3),'HH24')||':00' title2,  cn_btnface titlecl, cn_center titleal, cn_white datacl, cn_left dataal, 1 nlock, 50 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 1 ID, 'Час смены' title1, TO_CHAR(smena+(0.042*4),'HH24')||':00' title2,  cn_btnface titlecl, cn_center titleal, cn_white datacl, cn_left dataal, 1 nlock, 50 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 1 ID, 'Час смены' title1, TO_CHAR(smena+(0.042*5),'HH24')||':00' title2,  cn_btnface titlecl, cn_center titleal, cn_white datacl, cn_left dataal, 1 nlock, 50 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 1 ID, 'Час смены' title1, TO_CHAR(smena+(0.042*6),'HH24')||':00' title2,  cn_btnface titlecl, cn_center titleal, cn_white datacl, cn_left dataal, 1 nlock, 50 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 1 ID, 'Час смены' title1, TO_CHAR(smena+(0.042*7),'HH24')||':00' title2,  cn_btnface titlecl, cn_center titleal, cn_white datacl, cn_left dataal, 1 nlock, 50 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 1 ID, 'Час смены' title1, TO_CHAR(smena+(0.042*8),'HH24')||':00' title2,  cn_btnface titlecl, cn_center titleal, cn_white datacl, cn_left dataal, 1 nlock, 50 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 1 ID, 'Час смены' title1, TO_CHAR(smena+(0.042*9),'HH24')||':00' title2,  cn_btnface titlecl, cn_center titleal, cn_white datacl, cn_left dataal, 1 nlock, 50 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 1 ID, 'Час смены' title1, TO_CHAR(smena+(0.042*10),'HH24')||':00' title2,  cn_btnface titlecl, cn_center titleal, cn_white datacl, cn_left dataal, 1 nlock, 50 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 1 ID, 'Час смены' title1, TO_CHAR(smena+(0.042*11),'HH24')||':00' title2,  cn_btnface titlecl, cn_center titleal, cn_white datacl, cn_left dataal, 1 nlock, 50 nwidth, '' vmasks
      FROM DUAL
    UNION ALL
    SELECT 1 ID, 'Час смены' title1, TO_CHAR(smena+(0.042*12),'HH24')||':00' title2,  cn_btnface titlecl, cn_center titleal, cn_white datacl, cn_left dataal, 1 nlock, 50 nwidth, '' vmasks
      FROM DUAL
    UNION ALL  
    SELECT 2 ID, 'Всего за смену' title1, '' title2,  cn_btnface titlecl, cn_center titleal, cn_white datacl, cn_left dataal, 1 nlock, 60 nwidth, '' vmasks
      FROM DUAL;
    
    OPEN row_t FOR    
     SELECT  gid ID, 
        DECODE(LEVEL, 1, LPAD ('.', 2 * (LEVEL-1),TO_CHAR(get_number(gid, NULL))||'.') || TO_CHAR (get_number(gid,parent)),
                      2, LPAD ('.', 2 * (LEVEL-1),TO_CHAR(get_number(gid, NULL))||'.') || TO_CHAR (get_number(gid,parent)),
                      '')
        --DECODE (LEVEL, 1, TO_CHAR (get_number(gid,an_id)),  '') 
        title1, LPAD (' ', 2 * (LEVEL - 1)) || NAME title2,
        cn_white datacl, cn_right dataal, 0 nlock, '' vmasks, --utilrep_pg.f_sortbyl_n (ROWNUM, gid, an_id) srt
        1000000000 srt
     FROM GROUPS 
     WHERE LEVEL IN (1,2)--GID IN (SELECT PARENT FROM GROUPS)
           CONNECT BY PRIOR gid = PARENT 
           START WITH PARENT = an_id 
     ORDER SIBLINGS BY NVL(util_pg.get_param (vparam, 1), NAME);
    
    
  ELSE   --***********  Заглушка ****************
   an_cnfixcol := 0;
   an_cntitle := 1;
   an_cnfooter := 0;

   OPEN col_t FOR
    SELECT -1 ID, 'Назва показникa' title1, cn_btnface titlecl, cn_left titleal, cn_btnface datacl, cn_left dataal, 1 nlock, 150 nwidth, '' vmasks
      FROM DUAL;

   OPEN row_t FOR
    SELECT 0 ID, cn_white datacl, 0 nlock, '' vmasks
      FROM DUAL
     WHERE 1 = 2;
  END IF;
 END;

----------------------------------------------------------------
-- Возвращает содержимое макета
 PROCEDURE getmaketvalue (an_fid NUMBER, an_ispoint NUMBER, an_id NUMBER, ad_from DATE, ad_till DATE, data_t OUT common_pg.tt_number) IS
  ln_col            NUMBER;
  ln_row            NUMBER;
  lt_tmp            common_pg.tt_number;
  lv_proc           VARCHAR2 (256);
  temp_i            NUMBER;
  temp_k            NUMBER;
  temp_data_t_cnt   NUMBER;
  temp_summ         common_pg.tt_number;
  ln_locksum        NUMBER              DEFAULT f_locksum (an_fid);
  ln_flag           NUMBER;
  pr_par            NUMBER              DEFAULT -1;
  tmp_date1          DATE;
  tmp_date2          DATE;
  interv            NUMBER;
 BEGIN
  data_t.DELETE;
  temp_summ.DELETE;
  lv_proc := f_gettypeproc (an_fid);

  IF lv_proc = cv_proc1 THEN
   IF an_ispoint = 1 THEN
    FOR lc IN (SELECT   p.mid, DECODE(SIGN(NVL (f.metkc, 1)-1),1,NVL (f.metkc, 1),NVL (f.kc, 1)) kc
                   FROM feeders f, points p, points pa
                  WHERE f.mid IN (SELECT     mid
                                        FROM points
                                  CONNECT BY PRIOR mid = PARENT
                                  START WITH mid = an_id) AND f.mid = p.mid(+) AND p.PARENT = pa.mid(+)
               ORDER BY pa.NAME, pa.mid, p.NAME, p.mid) LOOP
     FOR i IN 1 .. 6 LOOP
      IF i IN (1, 2, 3, 5) THEN
       data_t (data_t.COUNT + 1) := util_pg.get_meterage_vch2 (lc.mid, ad_till, i, 0);
       data_t (data_t.COUNT + 1) := util_pg.get_meterage_vch2 (lc.mid, ad_from, i, 0);
       data_t (data_t.COUNT + 1) := util_pg.indicoverturn (data_t (data_t.COUNT - 1) - data_t (data_t.COUNT), NULL);
       data_t (data_t.COUNT + 1) := data_t (data_t.COUNT) * lc.kc;
      END IF;
     END LOOP;
    END LOOP;
   ELSE
    FOR lc IN (SELECT   p.mid, DECODE(SIGN(NVL (f.metkc, 1)-1),1,NVL (f.metkc, 1),NVL (f.kc, 1)) kc, g.inverted, g.npartly
                   FROM GROUPS g, feeders f, points p, points pa
                  WHERE g.gid IN (
                         SELECT     gid
                               FROM GROUPS
                         CONNECT BY PRIOR gid = PARENT
                                    AND (TO_CHAR (ad_from, 'yyyymm') <= NVL (ntillperiod, 299912) AND TO_CHAR (ad_till, 'yyyymm') >= NVL (nfromperiod, 160501))
                         START WITH gid = an_id
                                    AND (TO_CHAR (ad_from, 'yyyymm') <= NVL (ntillperiod, 299912) AND TO_CHAR (ad_till, 'yyyymm') >= NVL (nfromperiod, 160501)))
                        AND g.mid = f.mid AND f.mid = p.mid(+) AND p.PARENT = pa.mid(+)
               ORDER BY util_pg.allnumber_f (util_pg.get_param (g.vparam, 1, ';')), pa.NAME, pa.mid, p.NAME, p.mid) LOOP
     FOR i IN 1 .. 6 LOOP
      IF i IN (1, 2, 3, 5) THEN
       IF lc.inverted = 'y' THEN
        IF i = 1 THEN
         temp_i := 2;
        ELSIF i = 2 THEN
         temp_i := 1;
        ELSIF i = 3 THEN
         temp_i := 5;
        ELSIF i = 5 THEN
         temp_i := 3;
        END IF;

        temp_k := get_koef_npartly (lc.npartly, i, lc.inverted);
        data_t (data_t.COUNT + 1) := temp_k * util_pg.get_meterage_vch2 (lc.mid, ad_till, temp_i, 0);
        data_t (data_t.COUNT + 1) := temp_k * util_pg.get_meterage_vch2 (lc.mid, ad_from, temp_i, 0);
       ELSIF lc.inverted = 'n' THEN
        temp_k := get_koef_npartly (lc.npartly, i, lc.inverted);
        data_t (data_t.COUNT + 1) := temp_k * util_pg.get_meterage_vch2 (lc.mid, ad_till, i, 0);
        data_t (data_t.COUNT + 1) := temp_k * util_pg.get_meterage_vch2 (lc.mid, ad_from, i, 0);
       END IF;

       data_t (data_t.COUNT + 1) := util_pg.indicoverturn (data_t (data_t.COUNT - 1) - data_t (data_t.COUNT), NULL);
       data_t (data_t.COUNT + 1) := data_t (data_t.COUNT) * lc.kc;
      END IF;
     END LOOP;
    END LOOP;
   END IF;

   temp_data_t_cnt := data_t.COUNT / 16;

   FOR i IN 1 .. 4 LOOP
    temp_summ (i - 1) := 0;
    temp_k := 0;

    FOR j IN 1 .. temp_data_t_cnt LOOP
     IF data_t (4 * i + 16 * (j - 1)) IS NOT NULL THEN
      temp_k := 1;
     END IF;

     temp_summ (i - 1) := temp_summ (i - 1) + NVL (data_t (4 * i + 16 * (j - 1)), 0);
    END LOOP;

    data_t (data_t.COUNT + 1) := NULL;
    data_t (data_t.COUNT + 1) := NULL;
    data_t (data_t.COUNT + 1) := NULL;

    IF temp_k = 0 THEN
     data_t (data_t.COUNT + 1) := NULL;
    ELSE
     data_t (data_t.COUNT + 1) := temp_summ (i - 1);
    END IF;
   END LOOP;
  ------------------------------- addded by Kondakov A.G. 07.10.2008
  ELSIF lv_proc = cv_proc2 THEN
   lt_tmp (0) := 0;
   lt_tmp (1) := 0;

   IF an_ispoint = 1 THEN
    FOR lc IN (SELECT   p.mid, DECODE(SIGN(NVL (f.metkc, 1)-1),1,NVL (f.metkc, 1),NVL (f.kc, 1)) kc
                   FROM feeders f, points p, points pa
                  WHERE f.mid IN (SELECT     mid
                                        FROM points
                                  CONNECT BY PRIOR mid = PARENT
                                  START WITH mid = an_id) AND f.mid = p.mid(+) AND p.PARENT = pa.mid(+)
               ORDER BY pa.NAME, pa.mid, p.NAME, p.mid) LOOP
     -- отдача A-  -- согласно сортировке по d.t в getmaketinfo - сначала отдача, потом прием
     data_t (data_t.COUNT + 1) := util_pg.get_meterage_vch2 (lc.mid, ad_from, 2, 0);
     data_t (data_t.COUNT + 1) := util_pg.get_meterage_vch2 (lc.mid, ad_till, 2, 0);
     data_t (data_t.COUNT + 1) := util_pg.indicoverturn (data_t (data_t.COUNT) - data_t (data_t.COUNT - 1), NULL);
     data_t (data_t.COUNT + 1) := lc.kc;
     data_t (data_t.COUNT + 1) := data_t (data_t.COUNT - 1) * lc.kc;
     lt_tmp (1) := lt_tmp (1) + NVL (data_t (data_t.COUNT), 0);   -- суммируем отдачу
     data_t (data_t.COUNT + 1) := NULL;   -- прымитка
     -- прием А+
     data_t (data_t.COUNT + 1) := util_pg.get_meterage_vch2 (lc.mid, ad_from, 1, 0);
     data_t (data_t.COUNT + 1) := util_pg.get_meterage_vch2 (lc.mid, ad_till, 1, 0);
     data_t (data_t.COUNT + 1) := util_pg.indicoverturn (data_t (data_t.COUNT) - data_t (data_t.COUNT - 1), NULL);
     data_t (data_t.COUNT + 1) := lc.kc;
     data_t (data_t.COUNT + 1) := data_t (data_t.COUNT - 1) * lc.kc;
     lt_tmp (0) := lt_tmp (0) + NVL (data_t (data_t.COUNT), 0);   -- суммируем прием
     data_t (data_t.COUNT + 1) := NULL;   -- прымитка
    END LOOP;
   ELSE
    FOR lc IN (SELECT   p.mid, DECODE(SIGN(NVL (f.metkc, 1)-1),1,NVL (f.metkc, 1),NVL (f.kc, 1)) kc, g.inverted, g.npartly
                   FROM GROUPS g, feeders f, points p, points pa
                  WHERE g.gid IN (
                         SELECT     gid
                               FROM GROUPS
                         CONNECT BY PRIOR gid = PARENT
                                    AND (TO_CHAR (ad_from, 'yyyymm') <= NVL (ntillperiod, 299912) AND TO_CHAR (ad_till, 'yyyymm') >= NVL (nfromperiod, 160501))
                         START WITH gid = an_id
                                    AND (TO_CHAR (ad_from, 'yyyymm') <= NVL (ntillperiod, 299912) AND TO_CHAR (ad_till, 'yyyymm') >= NVL (nfromperiod, 160501)))
                        AND g.mid = f.mid AND f.mid = p.mid(+) AND p.PARENT = pa.mid(+)
               ORDER BY util_pg.allnumber_f (util_pg.get_param (g.vparam, 1, ';')), pa.NAME, pa.mid, p.NAME, p.mid) LOOP
     FOR i IN REVERSE 1 .. 2 LOOP   -- здесь задается порядок отдачи/приема
      IF lc.inverted = 'y' THEN
       IF i = 1 THEN
        temp_i := 2;
       ELSIF i = 2 THEN
        temp_i := 1;
       END IF;

       temp_k := get_koef_npartly (lc.npartly, i, lc.inverted);
       data_t (data_t.COUNT + 1) := temp_k * util_pg.get_meterage_vch2 (lc.mid, ad_from, temp_i, 0);
       data_t (data_t.COUNT + 1) := temp_k * util_pg.get_meterage_vch2 (lc.mid, ad_till, temp_i, 0);
      ELSIF lc.inverted = 'n' THEN
       temp_k := get_koef_npartly (lc.npartly, i, lc.inverted);
       data_t (data_t.COUNT + 1) := temp_k * util_pg.get_meterage_vch2 (lc.mid, ad_from, i, 0);
       data_t (data_t.COUNT + 1) := temp_k * util_pg.get_meterage_vch2 (lc.mid, ad_till, i, 0);
      END IF;

      data_t (data_t.COUNT + 1) := util_pg.indicoverturn (data_t (data_t.COUNT) - data_t (data_t.COUNT - 1), NULL);
      data_t (data_t.COUNT + 1) := lc.kc;
      data_t (data_t.COUNT + 1) := data_t (data_t.COUNT - 1) * lc.kc;
      lt_tmp (i - 1) := lt_tmp (i - 1) + NVL (data_t (data_t.COUNT), 0);   -- суммируем отдачу или прием
      data_t (data_t.COUNT + 1) := NULL;   -- прымитка
     END LOOP;
    END LOOP;
   END IF;

   IF ln_locksum = 0 THEN   -- вывод итоговых показателей
    data_t (data_t.COUNT + 5) := lt_tmp (1);
    data_t (data_t.COUNT + 10) := lt_tmp (0);
    data_t (data_t.COUNT + 15) := lt_tmp (0) - lt_tmp (1);   -- прием - отдача
   END IF;
  ------------------------------- addded by Kondakov A.G. 08.10.2008
  ELSIF lv_proc = cv_proc3 THEN
   IF an_ispoint = 1 THEN
    FOR lc IN (SELECT   p.mid, DECODE(SIGN(NVL (f.metkc, 1)-1),1,NVL (f.metkc, 1),NVL (f.kc, 1)) kc
                   FROM feeders f, points p, points pa
                  WHERE f.mid IN (SELECT     mid
                                        FROM points
                                  CONNECT BY PRIOR mid = PARENT
                                  START WITH mid = an_id) AND f.mid = p.mid(+) AND p.PARENT = pa.mid(+)
               ORDER BY pa.NAME, pa.mid, p.NAME, p.mid) LOOP
     -- прием А+ -- согласно сортировке по d.t в getmaketinfo - сначала прием, потом отдача
     data_t (data_t.COUNT + 1) := util_pg.get_meterage_vch2 (lc.mid, ad_till, 1, 0);
     data_t (data_t.COUNT + 1) := util_pg.get_meterage_vch2 (lc.mid, ad_from, 1, 0);
     data_t (data_t.COUNT + 1) := util_pg.indicoverturn (data_t (data_t.COUNT-1) - data_t (data_t.COUNT), NULL);
     data_t (data_t.COUNT + 1) := lc.kc;
     data_t (data_t.COUNT + 1) := data_t (data_t.COUNT - 1) * lc.kc;
     data_t (data_t.COUNT + 1) := NULL;   -- тут отдачи нет
     -- отдача A-
     data_t (data_t.COUNT + 1) := util_pg.get_meterage_vch2 (lc.mid, ad_till, 2, 0);
     data_t (data_t.COUNT + 1) := util_pg.get_meterage_vch2 (lc.mid, ad_from, 2, 0);
     data_t (data_t.COUNT + 1) := util_pg.indicoverturn (data_t (data_t.COUNT-1) - data_t (data_t.COUNT), NULL);
     data_t (data_t.COUNT + 1) := lc.kc;
     data_t (data_t.COUNT + 1) := NULL;   -- тут приема нет
     data_t (data_t.COUNT + 1) := data_t (data_t.COUNT - 2) * lc.kc;
    END LOOP;
   ELSE
    FOR lc IN (SELECT   p.mid, DECODE(SIGN(NVL (f.metkc, 1)-1),1,NVL (f.metkc, 1),NVL (f.kc, 1)) kc, g.inverted, g.npartly
                   FROM GROUPS g, feeders f, points p, /*points pa*/ GROUPS g2
                  WHERE g.gid IN (
                         SELECT     gid
                               FROM GROUPS
                         CONNECT BY PRIOR gid = PARENT
                                    AND (TO_CHAR (ad_from, 'yyyymm') <= NVL (ntillperiod, 299912) AND TO_CHAR (ad_till, 'yyyymm') >= NVL (nfromperiod, 160501))
                         START WITH gid = an_id
                                    AND (TO_CHAR (ad_from, 'yyyymm') <= NVL (ntillperiod, 299912) AND TO_CHAR (ad_till, 'yyyymm') >= NVL (nfromperiod, 160501)))
                        AND g.mid = f.mid AND f.mid = p.mid(+) AND /*p.PARENT = pa.mid(+)*/ g.PARENT(+) = g2.gid
               --ORDER BY util_pg.allnumber_f(util_pg.get_param(g.VPARAM,1,';')), pa.NAME, pa.mid, p.NAME, p.mid
               ORDER BY util_pg.allnumber_f (util_pg.get_param (g2.vparam, 1, ';')),
                        util_pg.get_param (g2.vparam, 2),
                        g2.NAME,
                        g2.gid,
                        util_pg.allnumber_f (util_pg.get_param (g.vparam, 1, ';')),
                        util_pg.get_param (g.vparam, 2),
                        g.NAME,
                        g.mid) LOOP
     FOR i IN 1 .. 2 LOOP   -- согласно сортировке по d.t в getmaketinfo - сначала прием, потом отдача
      IF lc.inverted = 'y' THEN
       IF i = 1 THEN
        temp_i := 2;
       ELSIF i = 2 THEN
        temp_i := 1;
       END IF;

       temp_k := get_koef_npartly (lc.npartly, i, lc.inverted);
       data_t (data_t.COUNT + 1) := temp_k * util_pg.get_meterage_vch2 (lc.mid, ad_till, temp_i, 0);
       data_t (data_t.COUNT + 1) := temp_k * util_pg.get_meterage_vch2 (lc.mid, ad_from, temp_i, 0);
      ELSIF lc.inverted = 'n' THEN
       temp_k := get_koef_npartly (lc.npartly, i, lc.inverted);
       data_t (data_t.COUNT + 1) := temp_k * util_pg.get_meterage_vch2 (lc.mid, ad_till, i, 0);
       data_t (data_t.COUNT + 1) := temp_k * util_pg.get_meterage_vch2 (lc.mid, ad_from, i, 0);
      END IF;

      data_t (data_t.COUNT + 1) := util_pg.indicoverturn (data_t (data_t.COUNT-1) - data_t (data_t.COUNT), NULL);
      data_t (data_t.COUNT + 1) := lc.kc;

      IF i = 1 THEN
       data_t (data_t.COUNT + 1) := data_t (data_t.COUNT - 1) * lc.kc;
       data_t (data_t.COUNT + 1) := NULL;   -- тут отдачи нет
      ELSE
       data_t (data_t.COUNT + 1) := NULL;   -- тут приема нет
       data_t (data_t.COUNT + 1) := data_t (data_t.COUNT - 2) * lc.kc;
      END IF;
     END LOOP;
    END LOOP;
   END IF;

   -- добавление сумм внизу
   temp_i := 6;   -- число значений в строке
   temp_data_t_cnt := data_t.COUNT / temp_i;   -- число суммируемых строк

   FOR s IN 1 .. 4 LOOP   --  число итоговых строк
    data_t (data_t.COUNT + 1) := NULL;
    data_t (data_t.COUNT + 1) := NULL;
    data_t (data_t.COUNT + 1) := NULL;
    data_t (data_t.COUNT + 1) := NULL;

    IF s = 1 THEN
     FOR i IN 1 .. 2 LOOP   -- 1 - прием  2 - отдача
      temp_summ (i - 1) := 0;
      temp_k := 0;

      FOR j IN 1 .. temp_data_t_cnt LOOP
       IF data_t (temp_i * (j - 1) + 4 + i) IS NOT NULL THEN
        temp_k := 1;
       END IF;

       temp_summ (i - 1) := temp_summ (i - 1) + NVL (data_t (temp_i * (j - 1) + 4 + i), 0);
      END LOOP;

      IF temp_k = 1 THEN
       data_t (data_t.COUNT + 1) := temp_summ (i - 1);   -- кВт*ч
      ELSE
       data_t (data_t.COUNT + 1) := NULL;   -- суммировать было нечего
      END IF;
     END LOOP;
    ELSIF s = 2 THEN
     data_t (data_t.COUNT + 1) := data_t (data_t.COUNT - temp_i + 1) / 1000;   -- т.кВт*ч прием
     data_t (data_t.COUNT + 1) := data_t (data_t.COUNT - temp_i + 1) / 1000;   -- т.кВт*ч отдача
    ELSIF s = 3 THEN
     temp_k := data_t (data_t.COUNT - 2 * temp_i + 1) - data_t (data_t.COUNT - 2 * temp_i + 2);

     IF temp_k < 0 THEN   -- сальдо переток кВт*ч
      data_t (data_t.COUNT + 1) := NULL;
      data_t (data_t.COUNT + 1) := (-1) * temp_k;
     ELSE
      data_t (data_t.COUNT + 1) := temp_k;
      data_t (data_t.COUNT + 1) := NULL;
     END IF;
    ELSIF s = 4 THEN   -- сальдо переток т.кВт*ч
     data_t (data_t.COUNT + 1) := data_t (data_t.COUNT - temp_i + 1) / 1000;
     data_t (data_t.COUNT + 1) := data_t (data_t.COUNT - temp_i + 1) / 1000;
    END IF;
   END LOOP;
  ------------------------------- addded by Kondakov A.G. 15.10.2008
  ELSIF lv_proc = cv_proc4 THEN
   IF an_ispoint <> 1 THEN
    temp_i := 0;
    lt_tmp (0) := 0;
    lt_tmp (1) := 0;

    FOR lc IN (SELECT   g2.gid, NVL (util_pg.get_param (g1.vparam, 2), g1.NAME) title1, NVL (util_pg.get_param (g2.vparam, 2), g2.NAME) title2, cn_white datacl,
                        cn_right dataal, 0 nlock, '' vmasks
                   FROM GROUPS g1, GROUPS g2
                  WHERE g1.PARENT = an_id AND g2.PARENT = g1.gid
                        AND (TO_CHAR (ad_from, 'yyyymm') <= NVL (g1.ntillperiod, 299912) AND TO_CHAR (ad_till, 'yyyymm') >= NVL (g1.nfromperiod, 160501))
                        AND (TO_CHAR (ad_from, 'yyyymm') <= NVL (g2.ntillperiod, 299912) AND TO_CHAR (ad_till, 'yyyymm') >= NVL (g2.nfromperiod, 160501))
               ORDER BY util_pg.allnumber_f (util_pg.get_param (g1.vparam, 1, ';')),
                        g1.NAME,
                        util_pg.allnumber_f (util_pg.get_param (g2.vparam, 1, ';')),
                        g2.NAME,
                        g2.gid) LOOP
     /*FOR lc1 IN (SELECT TO_NUMBER (util_pg.get_param (vparam, 1)) cln, gid
                   FROM GROUPS
                  WHERE PARENT = lc.gid AND TO_NUMBER (util_pg.get_param (vparam, 1)) BETWEEN 1 AND 12) LOOP
      SELECT e
        INTO data_t (temp_i * 12 + lc1.cln)
        FROM (SELECT ROUND (NVL (SUM (DECODE (g.inverted, 'y', h.ed * DECODE (g.npartly, 1, 0, 1), h.er * DECODE (g.npartly, 2, 0, 1))), 0), 3) er,
                     ROUND (NVL (SUM (DECODE (g.inverted, 'y', h.er * DECODE (g.npartly, 2, 0, 1), h.ed * DECODE (g.npartly, 1, 0, 1))), 0), 3) ed,
                     ROUND (NVL (SUM (util_pg.sld (h.mid, h.er * DECODE (g.npartly, 2, 0, 1), h.ed * DECODE (g.npartly, 1, 0, 1)) * DECODE (g.inverted,
                                                                                                                                            'y', -1,
                                                                                                                                            1
                                                                                                                                           )),
                                 0),
                            3) e
                FROM halfhour h, GROUPS g
               WHERE g.gid IN (SELECT     gid
                                     FROM GROUPS
                                    WHERE mid IS NOT NULL
                               CONNECT BY PRIOR gid = PARENT
                               START WITH gid = lc1.gid) AND g.mid = h.mid AND h.date_time > ad_from AND h.date_time <= ad_till);

      IF lc1.cln = 11 OR lc1.cln = 12 THEN
       lt_tmp (lc1.cln - 11) := lt_tmp (lc1.cln - 11) + data_t (temp_i * 12 + lc1.cln);   -- суммируем
      END IF;
     END LOOP;*/
     FOR lc1 IN (SELECT TO_NUMBER (util_pg.get_param (vparam, 1)) cln, gid
                   FROM GROUPS
                  WHERE PARENT = lc.gid AND TO_NUMBER (util_pg.get_param (vparam, 1)) BETWEEN 1 AND 4) LOOP
      IF lc1.cln=1 OR lc1.cln=2 THEN
        SELECT er, ed, e, decode(er,0,0,round(e/er*100,2)), ROUND(nvl(util_pg.get_ad_balance(lc1.gid,ad_from,ad_till,1,'halfhour'),0),2)
        INTO data_t(temp_i*12 + (lc1.cln-1)*5 + 1), data_t(temp_i*12 + (lc1.cln-1)*5 + 2), data_t(temp_i*12 + (lc1.cln-1)*5 + 3), 
             data_t(temp_i*12 + (lc1.cln-1)*5 + 4), data_t(temp_i*12 + (lc1.cln-1)*5 + 5)
        FROM (SELECT ROUND (NVL (SUM (DECODE (g.inverted, 'y', h.ed * DECODE (g.npartly, 1, 0, 1), h.er * DECODE (g.npartly, 2, 0, 1))), 0), 3) er,
                     ROUND (NVL (SUM (DECODE (g.inverted, 'y', h.er * DECODE (g.npartly, 2, 0, 1), h.ed * DECODE (g.npartly, 1, 0, 1))), 0), 3) ed,
                     ROUND (NVL (SUM (util_pg.sld (h.mid, h.er * DECODE (g.npartly, 2, 0, 1), 
                                                          h.ed * DECODE (g.npartly, 1, 0, 1)) * DECODE (g.inverted,'y', -1,1)),0),3) e
                FROM halfhour h, GROUPS g
               WHERE g.gid IN (SELECT     gid
                                     FROM GROUPS
                                    WHERE mid IS NOT NULL
                               CONNECT BY PRIOR gid = PARENT
                               START WITH gid = lc1.gid) AND g.mid = h.mid AND h.date_time > ad_from AND h.date_time <= ad_till);
      ELSIF lc1.cln=3 OR lc1.cln=4 THEN
        SELECT decode(lc1.cln,3,er_,4,er) 
        INTO data_t(temp_i*12 + lc1.cln + 8)
        FROM (SELECT ROUND (NVL (SUM (DECODE (g.inverted, 'y', -h.ed * DECODE (g.npartly, 1, 0, 1), h.er * DECODE (g.npartly, 2, 0, 1))), 0), 3) er_,
                     ROUND (NVL (SUM (DECODE (g.inverted, 'y', h.ed * DECODE (g.npartly, 1, 0, 1), h.er * DECODE (g.npartly, 2, 0, 1))), 0), 3) er
                     --ROUND (NVL (SUM (DECODE (g.inverted, 'y', h.er * DECODE (g.npartly, 2, 0, 1), h.ed * DECODE (g.npartly, 1, 0, 1))), 0), 3) ed,
                     --ROUND (NVL (SUM (util_pg.sld (h.mid, h.er * DECODE (g.npartly, 2, 0, 1), h.ed * DECODE (g.npartly, 1, 0, 1)) * DECODE (g.inverted,'y', -1,1)),0),3) e
                FROM halfhour h, GROUPS g
               WHERE g.gid IN (SELECT     gid
                                     FROM GROUPS
                                    WHERE mid IS NOT NULL
                               CONNECT BY PRIOR gid = PARENT
                               START WITH gid = lc1.gid) AND g.mid = h.mid AND h.date_time > ad_from AND h.date_time <= ad_till);
        lt_tmp (lc1.cln - 3) := lt_tmp (lc1.cln - 3) + data_t (temp_i * 12 + lc1.cln + 8);   -- суммируем
      END IF; 
     END LOOP;

     temp_i := temp_i + 1;
    END LOOP;

    IF ln_locksum = 0 THEN   -- вывод итоговых показателей
     temp_i := temp_i + 1;
     data_t (temp_i * 12 - 1) := lt_tmp (0);
     data_t (temp_i * 12) := lt_tmp (1);
    END IF;
   END IF;
  ------------------------------- addded by Kondakov A.G. 08.10.2008
  ELSIF lv_proc = cv_proc5 THEN
   lt_tmp (0) := 0;
   lt_tmp (1) := 0;

   IF an_ispoint = 1 THEN
    FOR lc IN (SELECT   p.mid, DECODE(SIGN(NVL (f.metkc, 1)-1),1,NVL (f.metkc, 1),NVL (f.kc, 1)) kc
                   FROM feeders f, points p, points pa
                  WHERE f.mid IN (SELECT     mid
                                        FROM points
                                  CONNECT BY PRIOR mid = PARENT
                                  START WITH mid = an_id) AND f.mid = p.mid(+) AND p.PARENT = pa.mid(+)
               ORDER BY pa.NAME, pa.mid, p.NAME, p.mid) LOOP
     -- прием A+  -- согласно сортировке по d.t в getmaketinfo - сначала прием, потом отдача
     data_t (data_t.COUNT + 1) := util_pg.get_meterage_vch2 (lc.mid, ad_till, 1, 0);
     data_t (data_t.COUNT + 1) := util_pg.get_meterage_vch2 (lc.mid, ad_from, 1, 0);
     data_t (data_t.COUNT + 1) := util_pg.indicoverturn (data_t (data_t.COUNT - 1) - data_t (data_t.COUNT), NULL);
     data_t (data_t.COUNT + 1) := lc.kc;
     data_t (data_t.COUNT + 1) := data_t (data_t.COUNT - 1) * lc.kc;
     lt_tmp (0) := lt_tmp (0) + NVL (data_t (data_t.COUNT), 0);   -- суммируем прием
     data_t (data_t.COUNT + 1) := 0;   -- недоучет
     -- отдача А-
     data_t (data_t.COUNT + 1) := util_pg.get_meterage_vch2 (lc.mid, ad_till, 2, 0);
     data_t (data_t.COUNT + 1) := util_pg.get_meterage_vch2 (lc.mid, ad_from, 2, 0);
     data_t (data_t.COUNT + 1) := util_pg.indicoverturn (data_t (data_t.COUNT - 1) - data_t (data_t.COUNT), NULL);
     data_t (data_t.COUNT + 1) := lc.kc;
     data_t (data_t.COUNT + 1) := data_t (data_t.COUNT - 1) * lc.kc;
     lt_tmp (1) := lt_tmp (1) + NVL (data_t (data_t.COUNT), 0);   -- суммируем отдачу
     data_t (data_t.COUNT + 1) := 0;   -- недоучет
    END LOOP;
   ELSE
    FOR lc IN (SELECT   p.mid, DECODE(SIGN(NVL (f.metkc, 1)-1),1,NVL (f.metkc, 1),NVL (f.kc, 1)) kc, g.inverted, g.npartly
                   FROM GROUPS g, feeders f, points p, points pa
                  WHERE g.gid IN (
                         SELECT     gid
                               FROM GROUPS
                         CONNECT BY PRIOR gid = PARENT
                                    AND (TO_CHAR (ad_from, 'yyyymm') <= NVL (ntillperiod, 299912) AND TO_CHAR (ad_till, 'yyyymm') >= NVL (nfromperiod, 160501))
                         START WITH gid = an_id
                                    AND (TO_CHAR (ad_from, 'yyyymm') <= NVL (ntillperiod, 299912) AND TO_CHAR (ad_till, 'yyyymm') >= NVL (nfromperiod, 160501)))
                        AND g.mid = f.mid AND f.mid = p.mid(+) AND p.PARENT = pa.mid(+)
               ORDER BY util_pg.allnumber_f (util_pg.get_param (g.vparam, 1, ';')), pa.NAME, pa.mid, p.NAME, p.mid) LOOP
     FOR i IN 1 .. 2 LOOP   -- согласно сортировке по d.t в getmaketinfo - сначала прием, потом отдача (без реверса)
      IF lc.inverted = 'y' THEN
       IF i = 1 THEN
        temp_i := 2;
       ELSIF i = 2 THEN
        temp_i := 1;
       END IF;

       temp_k := get_koef_npartly (lc.npartly, i, lc.inverted);
       data_t (data_t.COUNT + 1) := temp_k * util_pg.get_meterage_vch2 (lc.mid, ad_till, temp_i, 0);
       data_t (data_t.COUNT + 1) := temp_k * util_pg.get_meterage_vch2 (lc.mid, ad_from, temp_i, 0);
      ELSIF lc.inverted = 'n' THEN
       temp_k := get_koef_npartly (lc.npartly, i, lc.inverted);
       data_t (data_t.COUNT + 1) := temp_k * util_pg.get_meterage_vch2 (lc.mid, ad_till, i, 0);
       data_t (data_t.COUNT + 1) := temp_k * util_pg.get_meterage_vch2 (lc.mid, ad_from, i, 0);
      END IF;

      data_t (data_t.COUNT + 1) := util_pg.indicoverturn (data_t (data_t.COUNT - 1) - data_t (data_t.COUNT), NULL);
      data_t (data_t.COUNT + 1) := lc.kc;
      data_t (data_t.COUNT + 1) := data_t (data_t.COUNT - 1) * lc.kc;
      lt_tmp (i - 1) := lt_tmp (i - 1) + NVL (data_t (data_t.COUNT), 0);   -- суммируем прием или отдачу
      data_t (data_t.COUNT + 1) := 0;   -- недоучет
     END LOOP;
    END LOOP;
   END IF;

   IF ln_locksum = 0 THEN   -- вывод итоговых показателей
    data_t (data_t.COUNT + 5) := lt_tmp (0);
    data_t (data_t.COUNT + 10) := lt_tmp (1);
    data_t (data_t.COUNT + 15) := lt_tmp (0) - lt_tmp (1);   -- прием - отдача
   END IF;
  ------------------------------- addded by Kondakov A.G. 13.10.2008
  ELSIF lv_proc = cv_proc6 THEN
   lt_tmp (0) := 0;   -- A+ осн
   lt_tmp (1) := 0;   -- А- осн
   lt_tmp (2) := 0;   -- А+ дубл
   lt_tmp (3) := 0;   -- А- дубл

   IF an_ispoint = 1 THEN
    FOR lc IN (SELECT   p.mid, d.r, d.t, util_pg.allnumber_f(m.mtrsn) mtrsn, NVL (f.kc, 1) kc, h.er, h.ed, util_pg.allnumber_f(md.mtrsn) mtrsn_d, NVL (fd.kc, 1) kc_d, hd.er er_d,
                        hd.ed ed_d
                   FROM feeders f,
                        points p,
                        points pa,
                        feeders fd,
                        meters m,
                        meters md,
                        (SELECT ROWNUM r, DECODE (ROWNUM, 1, '+', '-') t
                           FROM dict
                          WHERE ROWNUM <= 2) d,
                        (SELECT   mid, SUM (er) er, SUM (ed) ed
                             FROM halfhour
                            WHERE date_time > ad_from AND date_time <= ad_till
                         GROUP BY mid) h,
                        (SELECT   mid, SUM (er) er, SUM (ed) ed
                             FROM halfhour
                            WHERE date_time > ad_from AND date_time <= ad_till
                         GROUP BY mid) hd
                  WHERE f.mid IN (SELECT     mid
                                        FROM points
                                  CONNECT BY PRIOR mid = PARENT
                                  START WITH mid = an_id) AND f.mid = p.mid AND f.mid = m.mid(+) AND m.entype(+) = 7 AND p.PARENT = pa.mid(+)
                        AND p.mid = fd.nmainpoint AND fd.mid = md.mid(+) AND md.entype(+) = 7 AND f.mid = h.mid(+) AND fd.mid = hd.mid(+)
               ORDER BY pa.mid, p.NAME, p.mid, d.t) LOOP
     data_t (data_t.COUNT + 1) := lc.mtrsn;

     IF lc.r = 1 THEN
      data_t (data_t.COUNT + 1) := NVL (lc.er, 0) * lc.kc;
      lt_tmp (0) := lt_tmp (0) + data_t (data_t.COUNT);
     ELSE
      data_t (data_t.COUNT + 1) := NVL (lc.ed, 0) * lc.kc;
      lt_tmp (1) := lt_tmp (1) + data_t (data_t.COUNT);
     END IF;

     data_t (data_t.COUNT + 1) := NULL;
     data_t (data_t.COUNT + 1) := lc.mtrsn_d;

     IF lc.r = 1 THEN
      data_t (data_t.COUNT + 1) := NVL (lc.er_d, 0) * lc.kc_d;
      lt_tmp (2) := lt_tmp (2) + data_t (data_t.COUNT);
     ELSE
      data_t (data_t.COUNT + 1) := NVL (lc.ed_d, 0) * lc.kc_d;
      lt_tmp (3) := lt_tmp (3) + data_t (data_t.COUNT);
     END IF;

     data_t (data_t.COUNT + 1) := data_t (data_t.COUNT - 3) - data_t (data_t.COUNT);

     IF data_t (data_t.COUNT - 4) = 0 THEN
      IF data_t (data_t.COUNT - 1) = 0 THEN
       data_t (data_t.COUNT + 1) := 0;
      ELSE
       data_t (data_t.COUNT + 1) := ROUND ((data_t (data_t.COUNT) / data_t (data_t.COUNT - 1)) * 100, 2);
      END IF;
     ELSE
      data_t (data_t.COUNT + 1) := ROUND ((data_t (data_t.COUNT) / data_t (data_t.COUNT - 4)) * 100, 2);
     END IF;
    END LOOP;
   ELSE
    FOR lc IN (SELECT   p.mid, d.r, p.NAME, d.t, g.inverted, g.npartly, f.mid m, util_pg.allnumber_f(m.mtrsn) mtrsn, NVL (f.kc, 1) kc, h.er, h.ed, fd.mid m_d,
                        util_pg.allnumber_f(md.mtrsn) mtrsn_d, NVL (fd.kc, 1) kc_d, hd.er er_d, hd.ed ed_d
                   FROM GROUPS g,
                        feeders f,
                        points p,
                        points pa,
                        feeders fd,
                        meters m,
                        meters md,
                        (SELECT ROWNUM r, DECODE (ROWNUM, 1, '+', '-') t
                           FROM dict
                          WHERE ROWNUM <= 2) d,
                        (SELECT   mid, SUM (er) er, SUM (ed) ed
                             FROM halfhour
                            WHERE date_time > ad_from AND date_time <= ad_till
                         GROUP BY mid) h,
                        (SELECT   mid, SUM (er) er, SUM (ed) ed
                             FROM halfhour
                            WHERE date_time > ad_from AND date_time <= ad_till
                         GROUP BY mid) hd
                  WHERE g.gid IN (
                         SELECT     gid
                               FROM GROUPS
                         CONNECT BY PRIOR gid = PARENT
                                    AND (TO_CHAR (ad_from, 'yyyymm') <= NVL (ntillperiod, 299912) AND TO_CHAR (ad_till, 'yyyymm') >= NVL (nfromperiod, 160501))
                         START WITH gid = an_id
                                    AND (TO_CHAR (ad_from, 'yyyymm') <= NVL (ntillperiod, 299912) AND TO_CHAR (ad_till, 'yyyymm') >= NVL (nfromperiod, 160501)))
                        AND g.mid = f.mid AND f.mid = p.mid AND p.PARENT = pa.mid(+) AND f.mid = m.mid(+) AND m.entype(+) = 7 AND p.mid = fd.nmainpoint
                        AND fd.mid = md.mid(+) AND md.entype(+) = 7 AND f.mid = h.mid(+) AND fd.mid = hd.mid(+)
               ORDER BY util_pg.allnumber_f (util_pg.get_param (g.vparam, 1, ';')), pa.NAME, pa.mid, p.NAME, p.mid, d.t) LOOP
     IF lc.inverted = 'y' THEN
      IF lc.r = 1 THEN
       temp_i := 2;
      ELSIF lc.r = 2 THEN
       temp_i := 1;
      END IF;
     ELSIF lc.inverted = 'n' THEN
      temp_i := lc.r;
     END IF;

     temp_k := get_koef_npartly (lc.npartly, lc.r, lc.inverted);
     data_t (data_t.COUNT + 1) := lc.mtrsn;

     IF lc.r = 1 THEN
      data_t (data_t.COUNT + 1) := temp_k * NVL (lc.er, 0) * lc.kc;
      lt_tmp (0) := lt_tmp (0) + data_t (data_t.COUNT);
     ELSE
      data_t (data_t.COUNT + 1) := temp_k * NVL (lc.ed, 0) * lc.kc;
      lt_tmp (1) := lt_tmp (1) + data_t (data_t.COUNT);
     END IF;

     data_t (data_t.COUNT + 1) := NULL;
     data_t (data_t.COUNT + 1) := lc.mtrsn_d;

     IF lc.r = 1 THEN
      data_t (data_t.COUNT + 1) := temp_k * NVL (lc.er_d, 0) * lc.kc_d;
      lt_tmp (2) := lt_tmp (2) + data_t (data_t.COUNT);
     ELSE
      data_t (data_t.COUNT + 1) := temp_k * NVL (lc.ed_d, 0) * lc.kc_d;
      lt_tmp (3) := lt_tmp (3) + data_t (data_t.COUNT);
     END IF;

     data_t (data_t.COUNT + 1) := data_t (data_t.COUNT - 3) - data_t (data_t.COUNT);

     IF data_t (data_t.COUNT - 4) = 0 THEN
      IF data_t (data_t.COUNT - 1) = 0 THEN
       data_t (data_t.COUNT + 1) := 0;
      ELSE
       data_t (data_t.COUNT + 1) := ROUND ((data_t (data_t.COUNT) / data_t (data_t.COUNT - 1)) * 100, 2);
      END IF;
     ELSE
      data_t (data_t.COUNT + 1) := ROUND ((data_t (data_t.COUNT) / data_t (data_t.COUNT - 4)) * 100, 2);
     END IF;
    END LOOP;
   END IF;

   IF ln_locksum = 0 THEN   -- вывод итоговых показателей
    data_t (data_t.COUNT + 2) := lt_tmp (0);
    data_t (data_t.COUNT + 4) := lt_tmp (2);
    data_t (data_t.COUNT + 7) := lt_tmp (1);
    data_t (data_t.COUNT + 9) := lt_tmp (3);
    data_t (data_t.COUNT + 12) := lt_tmp (0) - lt_tmp (1);   -- прием - отдача
    data_t (data_t.COUNT + 14) := lt_tmp (2) - lt_tmp (3);   -- прием - отдача
   END IF;
  ------------------------------- addded by Kondakov A.G. 14.10.2008
  ELSIF lv_proc = cv_proc7 THEN
   lt_tmp (0) := 0;
   lt_tmp (1) := 0;

   IF an_ispoint <> 1 THEN
    FOR lc IN (SELECT   NVL (util_pg.get_param (g2.vparam, 2), g2.NAME) title2, NVL (util_pg.get_param (g1.vparam, 2), g1.NAME) title3, g1.gid, cn_white datacl,
                        cn_right dataal, 0 nlock, '' vmasks
                   FROM (SELECT     g.gid, g.PARENT, g.NAME, g.vparam
                               FROM GROUPS g
                              WHERE EXISTS (SELECT *
                                              FROM GROUPS
                                             WHERE PARENT = g.gid AND mid IS NOT NULL)
                         CONNECT BY PRIOR gid = PARENT
                                    AND (TO_CHAR (ad_from, 'yyyymm') <= NVL (ntillperiod, 299912) AND TO_CHAR (ad_till, 'yyyymm') >= NVL (nfromperiod, 160501))
                         START WITH gid = an_id
                                    AND (TO_CHAR (ad_from, 'yyyymm') <= NVL (ntillperiod, 299912) AND TO_CHAR (ad_till, 'yyyymm') >= NVL (nfromperiod, 160501))) g1,
                        GROUPS g2
                  WHERE g1.PARENT = g2.gid
               ORDER BY util_pg.allnumber_f (util_pg.get_param (g2.vparam, 1, ';')),
                        NVL (util_pg.get_param (g2.vparam, 2), g2.NAME),
                        util_pg.allnumber_f (util_pg.get_param (g1.vparam, 1, ';')),
                        NVL (util_pg.get_param (g1.vparam, 2), g1.NAME),
                        g1.gid) LOOP
     data_t (data_t.COUNT + 1) := 0;
     data_t (data_t.COUNT + 1) := 0;
     data_t (data_t.COUNT + 1) := 0;
     data_t (data_t.COUNT + 1) := 0;

     SELECT ROUND (NVL (SUM (DECODE (g.inverted, 'y', h.ed * DECODE (g.npartly, 1, 0, 1), h.er * DECODE (g.npartly, 2, 0, 1))), 0), 3) er,
            ROUND (NVL (SUM (DECODE (g.inverted, 'y', h.er * DECODE (g.npartly, 2, 0, 1), h.ed * DECODE (g.npartly, 1, 0, 1))), 0), 3) ed,
            ROUND (NVL (SUM (util_pg.sld (h.mid, h.er * DECODE (g.npartly, 2, 0, 1), h.ed * DECODE (g.npartly, 1, 0, 1)) * DECODE (g.inverted, 'y', -1, 1)), 0), 3)
                                                                                                                                                                   e
       INTO data_t (data_t.COUNT - 3),
            data_t (data_t.COUNT - 2),
            data_t (data_t.COUNT - 1)
       FROM halfhour h, GROUPS g
      WHERE g.PARENT = lc.gid AND g.mid = h.mid AND h.date_time > ad_from AND h.date_time <= ad_till;

     lt_tmp (0) := lt_tmp (0) + data_t (data_t.COUNT - 3);
     lt_tmp (1) := lt_tmp (1) + data_t (data_t.COUNT - 2);

     IF data_t (data_t.COUNT - 3) = 0 THEN
      IF data_t (data_t.COUNT - 2) = 0 THEN
       data_t (data_t.COUNT) := 0;
      ELSE
       data_t (data_t.COUNT) := ROUND ((data_t (data_t.COUNT - 1) / data_t (data_t.COUNT - 2)) * 100, 2);
      END IF;
     ELSE
      data_t (data_t.COUNT) := ROUND ((data_t (data_t.COUNT - 1) / data_t (data_t.COUNT - 3)) * 100, 2);
     END IF;
    END LOOP;
   END IF;

   IF ln_locksum = 0 THEN   -- вывод итоговых показателей
    data_t (data_t.COUNT + 1) := lt_tmp (0);
    data_t (data_t.COUNT + 1) := lt_tmp (1);
   END IF;
  ------------------------------- addded by Kondakov A.G. 14.10.2008
  ELSIF lv_proc = cv_proc8 THEN
   lt_tmp (0) := 0;
   lt_tmp (1) := 0;

   IF an_ispoint <> 1 THEN
    FOR lc IN (SELECT   g.gid, g.NAME
                   FROM GROUPS g
                  WHERE g.mid > 0
                        AND g.gid IN (
                            SELECT     gid
                                  FROM GROUPS
                            CONNECT BY PRIOR gid = PARENT
                                       AND (TO_CHAR (ad_from, 'yyyymm') <= NVL (ntillperiod, 299912) AND TO_CHAR (ad_till, 'yyyymm') >= NVL (nfromperiod, 160501))
                            START WITH gid = an_id
                                       AND (TO_CHAR (ad_from, 'yyyymm') <= NVL (ntillperiod, 299912) AND TO_CHAR (ad_till, 'yyyymm') >= NVL (nfromperiod, 160501)))
               ORDER BY util_pg.allnumber_f (util_pg.get_param (g.vparam, 1, ';')), g.PARENT, g.NAME, g.gid) LOOP
     data_t (data_t.COUNT + 1) := 0;
     data_t (data_t.COUNT + 1) := 0;
     data_t (data_t.COUNT + 1) := 0;

     SELECT ROUND (NVL (SUM (DECODE (g.inverted, 'y', h.ed * DECODE (g.npartly, 1, 0, 1), h.er * DECODE (g.npartly, 2, 0, 1))), 0), 3) er,
            ROUND (NVL (SUM (DECODE (g.inverted, 'y', h.er * DECODE (g.npartly, 2, 0, 1), h.ed * DECODE (g.npartly, 1, 0, 1))), 0), 3) ed,
            ROUND (NVL (SUM (util_pg.sld (h.mid, h.er * DECODE (g.npartly, 2, 0, 1), h.ed * DECODE (g.npartly, 1, 0, 1)) * DECODE (g.inverted, 'y', -1, 1)), 0), 3)
                                                                                                                                                                   e
       INTO data_t (data_t.COUNT - 2),
            data_t (data_t.COUNT - 1),
            data_t (data_t.COUNT)
       FROM halfhour h, GROUPS g
      WHERE g.gid = lc.gid AND g.mid = h.mid AND h.date_time > ad_from AND h.date_time <= ad_till;

     lt_tmp (0) := lt_tmp (0) + data_t (data_t.COUNT - 2);
     lt_tmp (1) := lt_tmp (1) + data_t (data_t.COUNT - 1);
    END LOOP;
   END IF;

   IF ln_locksum = 0 THEN   -- вывод итоговых показателей
    data_t (data_t.COUNT + 1) := lt_tmp (0);
    data_t (data_t.COUNT + 1) := lt_tmp (1);
   END IF;
  ------------------------------- added by Круглова 13.11.2008
  ELSIF lv_proc = cv_proc9 THEN
   FOR i IN 1 .. 3 LOOP
    temp_summ (i) := 0;
   END LOOP;

   FOR lc IN (SELECT     gid, utilrep_pg.f_sortbyl_n (ROWNUM, gid, an_id) srt, LEVEL lv
                    FROM GROUPS
              CONNECT BY PRIOR gid = PARENT
              START WITH PARENT = an_id
                ORDER BY 2) LOOP
    temp_i := data_t.COUNT;

    SELECT ROUND (NVL (SUM (DECODE (g.inverted, 'y', h.ed * DECODE (g.npartly, 1, 0, 1), h.er * DECODE (g.npartly, 2, 0, 1))), 0), 3) er,
           ROUND (NVL (SUM (DECODE (g.inverted, 'y', h.er * DECODE (g.npartly, 2, 0, 1), h.ed * DECODE (g.npartly, 1, 0, 1))), 0), 3) ed,
           ROUND (NVL (SUM (util_pg.sld (h.mid, h.er * DECODE (g.npartly, 2, 0, 1), h.ed * DECODE (g.npartly, 1, 0, 1)) * DECODE (g.inverted, 'y', -1, 1)), 0), 3) e
      INTO data_t (temp_i + 1),
           data_t (temp_i + 2),
           data_t (temp_i + 3)
      FROM halfhour h, GROUPS g
     WHERE g.gid IN (SELECT     gid
                           FROM GROUPS
                          WHERE mid IS NOT NULL
                     CONNECT BY PRIOR gid = PARENT
                     START WITH gid = lc.gid) AND g.mid = h.mid AND h.date_time > ad_from AND h.date_time <= ad_till;

    IF lc.lv = 1 THEN
     FOR i IN 1 .. 3 LOOP
      temp_summ (i) := temp_summ (i) + data_t (temp_i + i);
     END LOOP;
    END IF;
   END LOOP;

   data_t (data_t.COUNT + 1) := temp_summ (1);
   data_t (data_t.COUNT + 1) := temp_summ (2);
   data_t (data_t.COUNT + 1) := temp_summ (3);

   IF temp_summ (1) = 0 THEN
    data_t (data_t.COUNT + 1) := 0;
   ELSE
    data_t (data_t.COUNT + 1) := temp_summ (3) / temp_summ (1) * 100;
   END IF;

   data_t (data_t.COUNT + 1) := NULL;
   data_t (data_t.COUNT + 1) := NULL;
   RETURN;
----------------------------------------------------------------
  ELSIF lv_proc = cv_proc10 THEN
  --nvl(util_pg.get_shortname_f(short_name,mid),util_pg.get_name_f(name,mid))
  -- FOR lc IN (SELECT   NVL (mid, 0) mid, PARENT, NAME, 1 sort, gid
  FOR lc IN (SELECT   NVL (mid, 0) mid, PARENT,nvl(util_pg.get_shortname_f(short_name,mid),util_pg.get_name_f(name,mid)) NAME, 1 sort, gid
                  FROM GROUPS
                 WHERE gid IN (SELECT     gid
                                     FROM GROUPS
                               CONNECT BY PRIOR gid = PARENT
                               START WITH PARENT = an_id) AND mid > 0
              ORDER BY 2, 3, 4) LOOP
    temp_k := data_t.COUNT;

    temp_i := data_t.COUNT;
    ln_flag:=0;
 
    FOR lc2 IN (SELECT round (DECODE (NVL (tt.npartly, 0), 2, NULL, tt.aparam), 3) aparam,bgroup
                  FROM (SELECT   DECODE (GROUPING (util_pg.get_num_dt (date_time - 1 / 86400, nsource, 1 / 24, 1, interior_pg.get_hourtimezone)),
                                         1, 0,
                                         util_pg.get_num_dt (date_time - 1 / 86400, nsource, 1 / 24, 1, interior_pg.get_hourtimezone)
                                        ) bgroup,
                                 SUM (DECODE (g.inverted, 'y', NVL (p.ed * DECODE (g.npartly, 1, 0, 1), 0), NVL (p.er * DECODE (g.npartly, 2, 0, 1), 0))
                                      * DECODE (SIGN (TO_NUMBER (TO_CHAR (date_time - 1 / 86400, 'yyyymm')) - NVL (g.nfromperiod, 0)), -1, NULL, 1)
                                      * DECODE (SIGN (NVL (ntillperiod, 299912) - TO_NUMBER (TO_CHAR (date_time - 1 / 86400, 'yyyymm'))), -1, NULL, 1))
                                 / 1000 aparam,
                                 MIN (g.npartly) npartly
                            FROM halfhour p, GROUPS g
                         WHERE p.mid = g.mid AND (npartly IS NULL OR g.npartly = 1) AND p.date_time > ad_from + 1 / 86400 AND p.date_time <= ad_from + 1
                         AND gid = lc.gid AND (200902 BETWEEN NVL (nfromperiod, 0) AND NVL (ntillperiod, 299912))
                         GROUP BY ROLLUP (util_pg.get_num_dt (date_time - 1 / 86400, nsource, 1 / 24, 1, interior_pg.get_hourtimezone))
                        ORDER BY 1) tt) LOOP
    IF(ln_flag=0) THEN
      for z in 1..26 loop
      data_t (temp_i + z):=NULL;
      end loop;
      ln_flag:=1;
    END IF;
     IF (lc2.aparam IS NOT NULL) THEN
      data_t (temp_i +1+ lc2.bgroup) := lc2.aparam;
     ELSE
      data_t (temp_i +1+ lc2.bgroup) := 0;
     END IF;
  
    END LOOP;

    temp_i := data_t.COUNT;
    ln_flag:=0;

    FOR lc3 IN (SELECT round (DECODE (NVL (tt.npartly, 0), 1, NULL, tt.bparam), 3) bparam,bgroup
                  FROM (SELECT   DECODE (GROUPING (util_pg.get_num_dt (date_time - 1 / 86400, nsource, 1 / 24, 0, interior_pg.get_hourtimezone)),
                                         1, 0,
                                         util_pg.get_num_dt (date_time - 1 / 86400, nsource, 1 / 24, 0, interior_pg.get_hourtimezone)
                                        ) bgroup,
                                 SUM (DECODE (g.inverted, 'y', NVL (p.er * DECODE (g.npartly, 2, 0, 1), 0), NVL (p.ed * DECODE (g.npartly, 1, 0, 1), 0))
                                      * DECODE (SIGN (TO_NUMBER (TO_CHAR (date_time - 1 / 86400, 'yyyymm')) - NVL (g.nfromperiod, 0)), -1, NULL, 1)
                                      * DECODE (SIGN (NVL (ntillperiod, 299912) - TO_NUMBER (TO_CHAR (date_time - 1 / 86400, 'yyyymm'))), -1, NULL, 1))
                                 / 1000 bparam,
                                 MIN (g.npartly) npartly
                            FROM halfhour p, GROUPS g
                           WHERE p.mid = g.mid AND (npartly IS NULL OR g.npartly = 2) AND p.date_time > ad_from + 1 / 86400 AND p.date_time <= ad_from + 1

                                 AND gid = lc.gid AND (200902 BETWEEN NVL (nfromperiod, 0) AND NVL (ntillperiod, 299912))
                    
                        GROUP BY ROLLUP (util_pg.get_num_dt (date_time - 1 / 86400, nsource, 1 / 24, 0, interior_pg.get_hourtimezone))
                        ORDER BY 1) tt) LOOP
   
    IF(ln_flag=0) THEN
      for z in 1..26 loop
      data_t (temp_i + z):=NULL;
      end loop;
      ln_flag:=1;
    END IF;
     IF (lc3.bparam IS NOT NULL) THEN
      data_t (temp_i +1+ lc3.bgroup) := lc3.bparam;
     ELSE
      data_t (temp_i +1+ lc3.bgroup) := 0;
     END IF;
    END LOOP;

    temp_i := data_t.COUNT;
    ln_flag:=0;
  
    FOR lc1 IN (SELECT round (DECODE (NVL (tt.npartly, 0), 0, tt.cparam, NULL), 3) cparam, NVL (tt.npartly, 0) npartly,bgroup
                  --,
                     -- decode(nvl(tt.NPARTLY,0),2,NULL,tt.AParam) AParam,
                     -- decode(nvl(tt.NPARTLY,0),1,NULL,tt.BParam) BParam
                FROM   (SELECT   DECODE (GROUPING (util_pg.get_num_dt (date_time - 1 / 86400, nsource, 1 / 24, 0, interior_pg.get_hourtimezone)),
                                         1, 0,
                                         util_pg.get_num_dt (date_time - 1 / 86400, nsource, 1 / 24, 0, interior_pg.get_hourtimezone)
                                        ) bgroup,
                                 SUM (-util_pg.sld (p.mid, NVL (p.er * DECODE (g.npartly, 2, 0, 1), 0), (NVL (p.ed * DECODE (g.npartly, 1, 0, 1), 0)))
                                      * DECODE (g.inverted, 'y', 1, -1)
                                      * DECODE (SIGN (TO_NUMBER (TO_CHAR (date_time - 1 / 86400, 'yyyymm')) - NVL (g.nfromperiod, 0)), -1, NULL, 1)
                                      * DECODE (SIGN (NVL (ntillperiod, 299912) - TO_NUMBER (TO_CHAR (date_time - 1 / 86400, 'yyyymm'))), -1, NULL, 1))
                                 / 1000 cparam,
                                 
                                 /*  sum(DECODE( G.inverted ,'y',nvl(P.ed   *decode(g.NPARTLY,1,0,1) ,0),
                                   nvl(P.er   *decode(g.NPARTLY,2,0,1)  ,0))
                                  *DECODE(sign( to_number(to_char(date_time-1/86400, 'yyyymm' ))-nvl(G.nfromperiod,0)),-1,NULL,1)
                                  *DECODE(sign(nvl(ntillperiod,299912)- to_number(to_char(date_time-1/86400, 'yyyymm' ))),-1,NULL,1)  )/1000 AParam,
                                   sum(DECODE( G.inverted ,'y',nvl(P.er   *decode(g.NPARTLY,2,0,1)  ,0),
                                   nvl(P.ed   *decode(g.NPARTLY,1,0,1)  ,0))
                                   *DECODE(sign( to_number(to_char(date_time-1/86400, 'yyyymm' ))-nvl(G.nfromperiod,0)),-1,NULL,1)
                                  *DECODE(sign(nvl(ntillperiod,299912)- to_number(to_char(date_time-1/86400, 'yyyymm' ))),-1,NULL,1)  )/1000 BParam  ,*/
                                 MIN (g.npartly) npartly
                       FROM halfhour p, GROUPS g
                        WHERE p.mid = g.mid AND (g.npartly IS NULL) AND p.date_time > ad_from + 1 / 86400 AND p.date_time <= ad_from + 1
                        AND gid = lc.gid AND (200902 BETWEEN NVL (nfromperiod, 0) AND NVL (ntillperiod, 299912))
                        GROUP BY ROLLUP (util_pg.get_num_dt (date_time - 1 / 86400, nsource, 1 / 24, 0, interior_pg.get_hourtimezone))
                        ORDER BY 1) tt) LOOP
     IF(ln_flag=0) THEN
      for z in 1..26 loop
      data_t (temp_i + z):=NULL;
      end loop;
      ln_flag:=1;
    END IF;
     IF (lc1.cparam IS NOT NULL) THEN
      data_t (temp_i +1+ lc1.bgroup) := lc1.cparam;
     ELSE
      data_t (temp_i +1+ lc1.bgroup) := 0;
     END IF;
    
     
  
    END LOOP;

    temp_i := data_t.COUNT;
    ln_flag:=0;
    IF (temp_i = temp_k) THEN
     SELECT NVL (npartly, 0)
       INTO temp_k
       FROM GROUPS
      WHERE gid = lc.gid AND mid = lc.mid;

     IF temp_k = 0 THEN
      FOR i IN 1 .. 78 LOOP
       temp_i := data_t.COUNT;
       data_t (temp_i + 1) := NULL;
      END LOOP;
     ELSE
      FOR i IN 1 .. 26 LOOP
       temp_i := data_t.COUNT;
       data_t (temp_i + 1) := NULL;
      END LOOP;
     END IF;
    END IF;
   END LOOP;
------------------------------- added by Круглова 24.02.2009------------------
------------------------------- eddited by Круглова 10.03.2009------------------
  ELSIF lv_proc = cv_proc11 THEN  
  
  FOR lc IN 
  
  (SELECT g1.name pname,g.name name, g.mid mid FROM 
    (SELECT name,parent,mid FROM groups
    WHERE mid>0 CONNECT BY PRIOR gid=parent START WITH parent=an_id) g,groups g1
    WHERE g1.gid=g.parent 
    ORDER BY 1,2)
  
  LOOP
  temp_i:=0;
  tmp_date1:='01-янв-1900';
  
  SELECT max(date_time) into tmp_date1 from curr_power_arch WHERE mid=lc.mid AND date_time<=ad_from;
 
  SELECT count(c.volt) INTO temp_i FROM CURR_POWER_ARCH c
  WHERE lc.mid=c.mid AND c.date_time=tmp_date1;
  
  IF temp_i=0 THEN
  data_t(data_t.count+1):=0;
  ELSE
  SELECT c.volt INTO data_t(data_t.count+1) FROM CURR_POWER_ARCH c
  WHERE lc.mid=c.mid AND c.date_time=tmp_date1;
  END IF;
  
  SELECT count(c.volt2) INTO temp_i FROM CURR_POWER_ARCH c
  WHERE lc.mid=c.mid AND c.date_time=tmp_date1;
  
  IF temp_i=0 THEN
  data_t(data_t.count+1):=0;
  ELSE
  SELECT c.volt2 INTO data_t(data_t.count+1) FROM CURR_POWER_ARCH c
  WHERE lc.mid=c.mid AND c.date_time=tmp_date1;
  END IF;
  
  SELECT count(c.volt3) INTO temp_i FROM CURR_POWER_ARCH c
  WHERE lc.mid=c.mid AND c.date_time=tmp_date1;
  
  IF temp_i=0 THEN
  data_t(data_t.count+1):=0;
  ELSE
  SELECT c.volt3 INTO data_t(data_t.count+1) FROM CURR_POWER_ARCH c
  WHERE lc.mid=c.mid AND c.date_time=tmp_date1;
  END IF;
  
  SELECT count(c.currento) INTO temp_i FROM CURR_POWER_ARCH c
  WHERE lc.mid=c.mid AND c.date_time=tmp_date1;
  
  IF temp_i=0 THEN
  data_t(data_t.count+1):=0;
  ELSE
  SELECT c.currento INTO data_t(data_t.count+1) FROM CURR_POWER_ARCH c
  WHERE lc.mid=c.mid AND c.date_time=tmp_date1;
  END IF;
  
  SELECT count(c.curr2) INTO temp_i FROM CURR_POWER_ARCH c
  WHERE lc.mid=c.mid AND c.date_time=tmp_date1;
  
  IF temp_i=0 THEN
  data_t(data_t.count+1):=0;
  ELSE
  SELECT c.curr2 INTO data_t(data_t.count+1) FROM CURR_POWER_ARCH c
  WHERE lc.mid=c.mid AND c.date_time=tmp_date1;
  END IF;
  
  SELECT count(c.curr3) INTO temp_i FROM CURR_POWER_ARCH c
  WHERE lc.mid=c.mid AND c.date_time=tmp_date1;
  
  IF temp_i=0 THEN
  data_t(data_t.count+1):=0;
  ELSE
  SELECT c.curr3 INTO data_t(data_t.count+1) FROM CURR_POWER_ARCH c
  WHERE lc.mid=c.mid AND c.date_time=tmp_date1;
  END IF;
  
  SELECT count(c.freq) INTO temp_i FROM CURR_POWER_ARCH c
  WHERE lc.mid=c.mid AND c.date_time=tmp_date1;
  
  IF temp_i=0 THEN
  data_t(data_t.count+1):=0;
  ELSE
  SELECT c.freq INTO data_t(data_t.count+1) FROM CURR_POWER_ARCH c
  WHERE lc.mid=c.mid AND c.date_time=tmp_date1;
  END IF;
  
  SELECT count(c.cosf) INTO temp_i FROM CURR_POWER_ARCH c
  WHERE lc.mid=c.mid AND c.date_time=tmp_date1;
  
  IF temp_i=0 THEN
  data_t(data_t.count+1):=0;
  ELSE
  SELECT c.cosf INTO data_t(data_t.count+1) FROM CURR_POWER_ARCH c
  WHERE lc.mid=c.mid AND c.date_time=tmp_date1;
  END IF;
 /* data_t(data_t.count+1):=TO_CHAR(tmp_date1,'DD.MM');
  data_t(data_t.count+1):=TO_CHAR(tmp_date1,'YYYY');
  data_t(data_t.count+1):=TO_CHAR(tmp_date1,'HH24.MI');*/
  END LOOP;
 RETURN;
------------------------------- added by Круглова 24.02.2009------------------
------------------------------- edited by Круглова 10.03.2009------------------
ELSIF lv_proc = cv_proc12 THEN
  FOR lc IN (SELECT g1.name pname, g.name name,g.mid, m.mtrsn meter FROM 
     (SELECT name,parent,mid FROM groups
        WHERE mid>0 CONNECT BY PRIOR gid=parent START WITH parent=an_id) g,groups g1, meters m
        WHERE g1.gid=g.parent AND m.mid=g.mid
        ORDER BY 1,2) LOOP
  temp_i:=data_t.COUNT;
  temp_k:=0;
  tmp_date1:='01-янв-1900';
  
  SELECT max(date_time) into tmp_date1 from profile WHERE mid=lc.mid AND TO_DATE(date_time,'DD.MM.YYYY HH24:MI:SS')<=TO_DATE(ad_from,'DD.MM.YYYY HH24:MI:SS') AND TO_DATE(date_time,'DD.MM.YYYY HH24:MI:SS')>=TO_DATE((ad_from-0.02083),'DD.MM.YYYY HH24:MI:SS');
  
  SELECT count(erm) into temp_k
  FROM profile WHERE date_time=tmp_date1 AND mid=lc.mid;
  
  IF temp_k=0 THEN
  data_t(data_t.count+1):=0;
  ELSE 
  SELECT erm into data_t(data_t.count+1)
  FROM profile WHERE date_time=tmp_date1 AND mid=lc.mid;
  END IF;
  
  temp_k:=0;
  SELECT count(q1m) into temp_k
  FROM profile WHERE date_time=tmp_date1 AND mid=lc.mid;
  
  IF temp_k=0 THEN
  data_t(data_t.count+1):=0;
  ELSE 
  SELECT q1m into data_t(data_t.count+1)
  FROM profile WHERE date_time=tmp_date1 AND mid=lc.mid;
  END IF;
  
  temp_k:=0;
  SELECT count(q3m) into temp_k
  FROM profile WHERE date_time=tmp_date1 AND mid=lc.mid;
  
  IF temp_k=0 THEN
  data_t(data_t.count+1):=0;
  ELSE 
  SELECT q3m into data_t(data_t.count+1)
  FROM profile WHERE date_time=tmp_date1 AND mid=lc.mid;
  END IF;
END LOOP;
RETURN;
  ------------------------------- added by Круглова 24.02.2009------------------
ELSIF lv_proc = cv_proc13 THEN
temp_k:=0;

FOR lc IN (SELECT g1.name pname,g.name, g.gid, g.parent parent FROM
     (SELECT name,parent,mid, gid FROM groups
        WHERE mid>0 CONNECT BY PRIOR gid=parent START WITH parent=an_id) g,groups g1
        WHERE g1.gid=g.parent 
        ORDER BY 1,2)

        
        LOOP
        temp_i := data_t.COUNT; 

SELECT ROUND (NVL (SUM (util_pg.sld (h.mid, h.er * DECODE (g.npartly, 2, 0, 1), h.ed * DECODE (g.npartly, 1, 0, 1)) * DECODE (g.inverted,'y', -1, 1)),0),3) e, 
''f                
                INTO data_t(temp_i+1),
                 data_t(temp_i+2)
                FROM halfhour h, GROUPS g   
                WHERE g.gid = lc.gid AND g.mid = h.mid 
                     AND h.date_time > ad_from AND h.date_time <= ad_till;
    
        IF (pr_par<>-1) THEN
        data_t(temp_i):='';
        END IF;
        
        IF ((pr_par <> lc.parent) AND (pr_par<>-1))
         THEN    
        
        data_t(temp_i):=temp_k;
        temp_k := data_t(temp_i+1);
        ELSE 
        temp_k:=temp_k+data_t(temp_i+1);
        END IF; 
    
        data_t(temp_i+2):=temp_k;
                   
    pr_par:=lc.parent;                 
    END LOOP;
RETURN;
  ------------------------------- added by Круглова 24.02.2009------------------
  -------------------------------edited by Kruglova 18.03.2009------------------
ELSIF lv_proc = cv_proc14 THEN
  
FOR lc IN  (SELECT DISTINCT t.name, t.gID, m.mtrsn, m.mid FROM  
    (SELECT name, gID, mid FROM groups
        WHERE mid>0 CONNECT BY PRIOR gid=parent START WITH parent=an_id)                 
        t, meters m WHERE m.mid=t.mid ORDER BY 1, 2, 3)
        
        LOOP
        
        select max(date_time) INTO tmp_date1
        FROM halfhour WHERE mid=lc.mid AND date_time<=ad_from;
        
        select max(date_time) INTO tmp_date2
        FROM halfhour WHERE mid=lc.mid AND date_time<=ad_till;
        --актив
        SELECT COUNT (ERM) INTO temp_i FROM halfhour WHERE mid=lc.mid AND date_time=tmp_date2;
        IF temp_i=0 THEN
        data_t(data_t.count+1):=0;
        ELSE
        SELECT ERM INTO data_t(data_t.count+1) FROM halfhour WHERE mid=lc.mid AND date_time=tmp_date2;
        END IF;
        
        SELECT COUNT (ERM) INTO temp_i FROM halfhour WHERE mid=lc.mid AND date_time=tmp_date1;
        IF temp_i=0 THEN
        data_t(data_t.count+1):=0;
        ELSE
        SELECT ERM INTO data_t(data_t.count+1) FROM halfhour WHERE mid=lc.mid AND date_time=tmp_date1;
        END IF;
        
        
        
        data_t(data_t.count+1):=data_t(data_t.count-1)-data_t(data_t.count);
        
        
        SELECT COUNT (NKC) INTO temp_i FROM halfhour WHERE mid=lc.mid AND date_time=tmp_date2;
        IF temp_i=0 THEN
        data_t(data_t.count+1):=0;
        ELSE
        SELECT NKC INTO data_t(data_t.count+1) FROM halfhour WHERE mid=lc.mid AND date_time=tmp_date2;
        END IF;
        
        data_t(data_t.count+1):=data_t(data_t.count)*data_t(data_t.count-1);
        
        --реактив
        SELECT COUNT (q1M) INTO temp_i FROM halfhour WHERE mid=lc.mid AND date_time=tmp_date2;
        IF temp_i=0 THEN
        data_t(data_t.count+1):=0;
        ELSE
        SELECT q1M INTO data_t(data_t.count+1) FROM halfhour WHERE mid=lc.mid AND date_time=tmp_date2;
        END IF;
        SELECT COUNT (q1M) INTO temp_i FROM halfhour WHERE mid=lc.mid AND date_time=tmp_date1;
        IF temp_i=0 THEN
        data_t(data_t.count+1):=0;
        ELSE
        SELECT q1M INTO data_t(data_t.count+1) FROM halfhour WHERE mid=lc.mid AND date_time=tmp_date1;
        END IF;
        
        data_t(data_t.count+1):=data_t(data_t.count-1)-data_t(data_t.count);
        
        SELECT COUNT (NKC) INTO temp_i FROM halfhour WHERE mid=lc.mid AND date_time=tmp_date2;
        IF temp_i=0 THEN
        data_t(data_t.count+1):=0;
        ELSE
        SELECT NKC INTO data_t(data_t.count+1) FROM halfhour WHERE mid=lc.mid AND date_time=tmp_date2;
        END IF;
        
        data_t(data_t.count+1):=data_t(data_t.count)*data_t(data_t.count-1);

        END LOOP;
RETURN;
------------------------------- added by Круглова 24.02.2009------------------
------------------------------- edited by Круглова 04.03.2009------------------
ELSIF lv_proc = cv_proc15 THEN
SELECT ABS(TO_DATE(ad_till,'DD.MM.YYYY HH24:MI:SS') - TO_DATE(ad_from,'DD.MM.YYYY HH24:MI:SS')) INTO interv from DUAL;
   interv:=interv+1;
   temp_i:=0;
   tmp_date1:=TO_DATE('01.01.1900 00:00:00','DD.MM.YYYY HH24:MI:SS');
 FOR lc IN (SELECT TO_DATE(ad_from,'DD.MM.YYYY HH24:MI:SS')+ROWNUM-1 dt FROM dual CONNECT BY ROWNUM <= interv)
 LOOP
   FOR lc1 IN (SELECT g1.name parent,g.name name, g.mid mid FROM 
     (SELECT name,parent, mid,1 g FROM groups
        WHERE mid>0 CONNECT BY PRIOR gid=parent START WITH parent=an_id) g,groups g1
        WHERE g1.gid=g.parent         
        ORDER BY 1,3)
     LOOP
     
      SELECT TO_DATE(TO_CHAR(max(date_time), 'DD-MM-YYYY HH24-MI-SS'),'DD-MM-YYYY HH24:MI:SS') into tmp_date1 from halfhour WHERE mid=lc1.mid AND TO_DATE(date_time,'DD.MM.YYYY HH24:MI:SS')<TO_DATE(lc.dt+1,'DD.MM.YYYY HH24:MI:SS');
        
        SELECT COUNT (erm) INTO temp_i  
        FROM halfhour h where h.mid=lc1.mid AND h.date_time=tmp_date1;
        
        IF temp_i=0 THEN
        data_t(data_t.count+1):=0;
        ELSE
        SELECT erm INTO data_t(data_t.count+1)  
        FROM halfhour h where h.mid=lc1.mid AND h.date_time=tmp_date1;
        END IF;
        
        SELECT COUNT (er) INTO temp_i  
        FROM halfhour h where h.mid=lc1.mid AND h.date_time=tmp_date1;
        
        IF temp_i=0 THEN
        data_t(data_t.count+1):=0;
        ELSE
        SELECT er INTO data_t(data_t.count+1)  
        FROM halfhour h where h.mid=lc1.mid AND h.date_time=tmp_date1;
        END IF;
                
     END LOOP; 
 END LOOP;
RETURN;
------------------------------- added by Круглова 30.03.2009------------------
------------------------------- edited by Круглова 31.03.2009------------------
ELSIF lv_proc = cv_proc16 THEN

   IF (TO_CHAR(ad_from,'HH24'))>=8 AND (TO_CHAR(ad_from,'HH24'))<20 THEN
      tmp_date1:=TRUNC(ad_from)+8/24;
   ELSIF (TO_CHAR(ad_from,'HH24'))>=20 THEN 
      tmp_date1:=TRUNC(ad_from)+20/24;
   ELSE
      tmp_date1:=TRUNC(ad_from)-1 + 20/24;   
   END IF;
   
FOR lc IN (SELECT gid, NAME
             FROM GROUPS 
            WHERE LEVEL IN (1,2)--GID IN (SELECT PARENT FROM GROUPS)
                  CONNECT BY PRIOR gid = PARENT 
                  START WITH PARENT = an_id 
                  ORDER SIBLINGS BY NVL(util_pg.get_param (vparam, 1), NAME))
        LOOP
            FOR i IN 1..12
            LOOP
                SELECT 
                    --SUM (DECODE (g.inverted, 'y', h.ed * DECODE (g.npartly, 1, 0, 1), h.er * DECODE (g.npartly, 2, 0, 1)))
                    SUM(util_pg.sld(h.mid,NVL(h.er*DECODE(g.NPARTLY,2,0,1),0),NVL(h.ed*DECODE(g.NPARTLY,1,0,1),0))*DECODE(G.INVERTED,'y',-1,1))
                    INTO data_t(data_t.count+1) 
                    FROM HALFHOUR h, GROUPS g 
                    WHERE g.gid IN (SELECT gid FROM groups
                                     WHERE mid>0 CONNECT BY PRIOR gid=parent START WITH parent=lc.gid)
                    AND h.mid=g.mid
                    AND h.DATE_TIME > tmp_date1 + (i-1)/24
                    AND h.DATE_TIME <= tmp_date1 + i/24;
            END LOOP; 
            -- находим сумму за сутки (по строчке)
            data_t(data_t.count+1):=data_t(data_t.count);            
            FOR i IN 2..12
            LOOP
               IF data_t(data_t.count) IS NULL AND data_t(data_t.count-i) IS NOT NULL THEN 
                 data_t(data_t.count):=0+data_t(data_t.count-i);
               ELSIF data_t(data_t.count) IS NOT NULL AND data_t(data_t.count-i) IS NULL THEN   
                 data_t(data_t.count):=data_t(data_t.count)+0;
               ELSE  
                 data_t(data_t.count):=data_t(data_t.count)+data_t(data_t.count-i);
               END IF;  
            END LOOP;
        END LOOP;
RETURN;
-------------------------------------------------------------------------------

  ELSE   --***********  Заглушка ****************
   RETURN;
  END IF;
 END;

----------------------------------------------------------------
-- Возвращает данные для графического представления состава макета (если график не поддерхивается возвращает 0)
 FUNCTION getmaketgrafvalue (an_fid NUMBER, an_ispoint NUMBER, an_id NUMBER, ad_from DATE, ad_till DATE, an_col NUMBER, an_row NUMBER, av_title OUT VARCHAR2,
 av_xtitle OUT VARCHAR2, av_ytitle OUT VARCHAR2, x_t OUT common_pg.tt_number, y_t OUT common_pg.tt_number
 )
  RETURN NUMBER IS
  lv_proc   VARCHAR2 (256);
  temp_i    NUMBER;
  ln_gid    NUMBER;
  ln_sort   NUMBER;
  ln_flag   NUMBER;
 BEGIN
  x_t.DELETE;
  y_t.DELETE;
  lv_proc := f_gettypeproc (an_fid);

  IF lv_proc = cv_proc1 THEN
   RETURN 0;
----------------------------------------------------------VNB 7.02.2009
  ELSIF lv_proc = cv_proc10 THEN
   ln_gid := TRUNC (an_row / 10);
   ln_sort := MOD (an_row, 10);
   ln_flag:=0;
   SELECT nvl(util_pg.get_shortname_f(short_name,mid),util_pg.get_name_f(name,mid))NAME
     INTO av_title
     FROM GROUPS
    WHERE gid = ln_gid;

   av_xtitle := 'Час.';
   av_ytitle := 'тКВтч.';

------------------------------------------------------
   IF (ln_sort = 0) THEN   --Сальдо
   temp_i := y_t.COUNT;
    FOR lc1 IN (SELECT DECODE (NVL (tt.npartly, 0), 0, tt.cparam, NULL) cparam, NVL (tt.npartly, 0) npartly,tt.bgroup
                  FROM (SELECT   util_pg.get_num_dt (date_time - 1 / 86400, nsource, 1 / 24, 0, interior_pg.get_hourtimezone) bgroup,
                                 SUM (-util_pg.sld (p.mid, NVL (p.er * DECODE (g.npartly, 2, 0, 1), 0), (NVL (p.ed * DECODE (g.npartly, 1, 0, 1), 0)))
                                      * DECODE (g.inverted, 'y', 1, -1)
                                      * DECODE (SIGN (TO_NUMBER (TO_CHAR (date_time - 1 / 86400, 'yyyymm')) - NVL (g.nfromperiod, 0)), -1, NULL, 1)
                                      * DECODE (SIGN (NVL (ntillperiod, 299912) - TO_NUMBER (TO_CHAR (date_time - 1 / 86400, 'yyyymm'))), -1, NULL, 1))
                                 / 1000 cparam,
                                 MIN (g.npartly) npartly
                            FROM halfhour p, GROUPS g
                           WHERE p.mid = g.mid AND (g.npartly IS NULL) AND p.date_time > ad_from + 1 / 86400 AND p.date_time <= ad_from + 1 AND g.gid = ln_gid
                        GROUP BY (util_pg.get_num_dt (date_time - 1 / 86400, nsource, 1 / 24, 0, interior_pg.get_hourtimezone))
                        ORDER BY 1) tt) LOOP
    
    IF(ln_flag=0) THEN
       for z in 1..26 loop
       y_t (temp_i + z):=NULL;
       end loop;
      ln_flag:=1;
    END IF;
  
      y_t (temp_i + lc1.bgroup) := lc1.cparam;
  
    END LOOP;
  
  
    FOR lc2 IN (SELECT ROWNUM ID
                          FROM dict
                         WHERE ROWNUM <= 25)  LOOP
     temp_i := x_t.COUNT;
     x_t (temp_i + 1) := lc2.ID;
    END LOOP;
    ln_flag:=0;
    av_title := 'Сальдо за' || ' ' || TO_CHAR (ad_from, 'dd.mm.yyyy') || ' по ' || av_title || '.';
    RETURN y_t.COUNT;
    
----------------------------------------------

   ELSIF (ln_sort = 1) THEN   --прием
   temp_i := y_t.COUNT;
    FOR lc1 IN (SELECT DECODE (NVL (tt.npartly, 0), 2, NULL, tt.aparam) aparam,tt.bgroup
                  FROM (SELECT   util_pg.get_num_dt (date_time - 1 / 86400, nsource, 1 / 24, 0, interior_pg.get_hourtimezone) bgroup,
                                 SUM (DECODE (g.inverted, 'y', NVL (p.ed * DECODE (g.npartly, 1, 0, 1), 0), NVL (p.er * DECODE (g.npartly, 2, 0, 1), 0))
                                      * DECODE (SIGN (TO_NUMBER (TO_CHAR (date_time - 1 / 86400, 'yyyymm')) - NVL (g.nfromperiod, 0)), -1, NULL, 1)
                                      * DECODE (SIGN (NVL (ntillperiod, 299912) - TO_NUMBER (TO_CHAR (date_time - 1 / 86400, 'yyyymm'))), -1, NULL, 1))
                                 / 1000 aparam,
                                 MIN (g.npartly) npartly
                            FROM halfhour p, GROUPS g
                           WHERE p.mid = g.mid AND (npartly IS NULL OR g.npartly = 1) AND p.date_time > ad_from + 1 / 86400 AND p.date_time <= ad_from + 1
                                 AND g.gid = ln_gid
                        GROUP BY (util_pg.get_num_dt (date_time - 1 / 86400, nsource, 1 / 24, 0, interior_pg.get_hourtimezone))
                        ORDER BY 1) tt) LOOP
   
  IF(ln_flag=0) THEN
       for z in 1..26 loop
       y_t (temp_i + z):=NULL;
       end loop;
      ln_flag:=1;
    END IF;
     
      y_t (temp_i + lc1.bgroup) := lc1.aparam;
   
    END LOOP;
  FOR lc2 IN (SELECT ROWNUM ID
                          FROM dict
                         WHERE ROWNUM <= 25)  LOOP
     temp_i := x_t.COUNT;
     x_t (temp_i + 1) := lc2.ID;
      END LOOP;
  
   ln_flag:=0;
    av_title := 'Прием за' || ' ' || TO_CHAR (ad_from, 'dd.mm.yyyy') || ' по ' || av_title || '.';
    RETURN y_t.COUNT;
-----------------------------------------------------------------
 
   ELSIF (ln_sort = 2) THEN   --отдача
    temp_i := y_t.COUNT;
    FOR lc1 IN (SELECT DECODE (NVL (tt.npartly, 0), 1, NULL, tt.bparam) bparam,tt.bgroup
                  FROM (SELECT   util_pg.get_num_dt (date_time - 1 / 86400, nsource, 1 / 24, 0, interior_pg.get_hourtimezone) bgroup,
                                 SUM (DECODE (g.inverted, 'y', NVL (p.er * DECODE (g.npartly, 2, 0, 1), 0), NVL (p.ed * DECODE (g.npartly, 1, 0, 1), 0))
                                      * DECODE (SIGN (TO_NUMBER (TO_CHAR (date_time - 1 / 86400, 'yyyymm')) - NVL (g.nfromperiod, 0)), -1, NULL, 1)
                                      * DECODE (SIGN (NVL (ntillperiod, 299912) - TO_NUMBER (TO_CHAR (date_time - 1 / 86400, 'yyyymm'))), -1, NULL, 1))
                                 / 1000 bparam,
                                 MIN (g.npartly) npartly
                            FROM halfhour p, GROUPS g
                           WHERE p.mid = g.mid AND (npartly IS NULL OR g.npartly = 2) AND p.date_time > ad_from + 1 / 86400 AND p.date_time <= ad_from + 1
                                 AND p.date_time > ad_from + 1 / 86400 AND p.date_time <= ad_from + 1 AND g.gid = ln_gid
                        GROUP BY (util_pg.get_num_dt (date_time - 1 / 86400, nsource, 1 / 24, 0, interior_pg.get_hourtimezone))
                        ORDER BY 1) tt) LOOP
   
    IF(ln_flag=0) THEN
       for z in 1..26 loop
       y_t (temp_i + z):=NULL;
       end loop;
      ln_flag:=1;
    END IF;
   
      y_t (temp_i + lc1.bgroup) := lc1.bparam;
 
    END LOOP;
     FOR lc2 IN (SELECT ROWNUM ID
                          FROM dict
                         WHERE ROWNUM <= 25)  LOOP
      temp_i := x_t.COUNT;
      x_t (temp_i + 1) := lc2.ID;
      END LOOP;

    ln_flag:=0;
    av_title := 'Отдача за' || ' ' || TO_CHAR (ad_from, 'dd.mm.yyyy') || ' по ' || av_title || '.';
    RETURN y_t.COUNT;
-----------------------------------------------------------------
   END IF;
--------------------------------------------------------------END VNB
  ELSE   --***********  Заглушка ****************
   RETURN 0;
  END IF;
 END;

----------------------------------------------------------------
-- Сохраняет содержимое макета
 PROCEDURE savemaketvalue (an_fid NUMBER, an_ispoint NUMBER, an_id NUMBER, ad_from DATE, ad_till DATE, an_col NUMBER, an_row NUMBER, an_value NUMBER) IS
  lv_proc   VARCHAR2 (256);
 BEGIN
  lv_proc := f_gettypeproc (an_fid);

  IF lv_proc = cv_proc1 THEN
   NULL;
  ELSE   --***********  Заглушка ****************
   NULL;
  END IF;
 END;

------------------------------------------------------------------------------------------------------------------------
 PROCEDURE getcolorinfo (an_fid NUMBER, an_ispoint NUMBER, an_id NUMBER, ad_from DATE, ad_till DATE, ret_t OUT common_pg.tcur) IS
  lv_proc   VARCHAR2 (256);
 BEGIN
  lv_proc := f_gettypeproc (an_fid);

  IF lv_proc = cv_proc1 THEN
   OPEN ret_t FOR
    SELECT 0 ncol, 0 nrow, 0 ncolor, '' vinfo
      FROM DUAL
     WHERE 1 = 2;
  ELSE   --***********  Заглушка ****************
   OPEN ret_t FOR
    SELECT 0 ncol, 0 nrow, 0 ncolor, '' vinfo
      FROM DUAL
     WHERE 1 = 2;
  END IF;
 END;

----------------------------------------------------------------
-- Возвращает множитель 1 или 0 при учете признака частичного вхождения
 FUNCTION get_koef_npartly (an_npartly NUMBER, an_i NUMBER, an_inverted VARCHAR2)
  RETURN NUMBER IS
 BEGIN
  IF an_npartly IS NULL THEN
   RETURN 1;
  ELSIF an_npartly = 1 THEN
   IF an_inverted = 'y' THEN
    IF an_i = 1 THEN
     RETURN NULL;
    ELSIF an_i = 2 THEN
     RETURN 1;
    ELSIF an_i = 3 THEN
     RETURN NULL;
    ELSIF an_i = 5 THEN
     RETURN 1;
    END IF;
   ELSIF an_inverted = 'n' THEN
    IF an_i = 1 THEN
     RETURN 1;
    ELSIF an_i = 2 THEN
     RETURN NULL;
    ELSIF an_i = 3 THEN
     RETURN 1;
    ELSIF an_i = 5 THEN
     RETURN NULL;
    END IF;
   END IF;
  ELSIF an_npartly = 2 THEN
   IF an_inverted = 'y' THEN
    IF an_i = 1 THEN
     RETURN 1;
    ELSIF an_i = 2 THEN
     RETURN NULL;
    ELSIF an_i = 3 THEN
     RETURN 1;
    ELSIF an_i = 5 THEN
     RETURN NULL;
    END IF;
   ELSIF an_inverted = 'n' THEN
    IF an_i = 1 THEN
     RETURN NULL;
    ELSIF an_i = 2 THEN
     RETURN 1;
    ELSIF an_i = 3 THEN
     RETURN NULL;
    ELSIF an_i = 5 THEN
     RETURN 1;
    END IF;
   END IF;
  END IF;
 END;

--------------------------------------------------------------------------------------------------------------------------------
--Что печатать в заголовках
 PROCEDURE get_reportinfo (an_fid NUMBER, an_usedeftitle OUT NUMBER, an_usedefphr OUT NUMBER, ab_before IN OUT BLOB, ab_after IN OUT BLOB) IS
 BEGIN
  ab_before := NULL;
  ab_after := NULL;

  SELECT NVL (DECODE (MAX (vvalue), '1', 0, 1), 1)
    INTO an_usedeftitle
    FROM addformparamval
   WHERE mid = an_fid AND nsort = -1;

  SELECT NVL (DECODE (MAX (vvalue), '1', 0, 1), 1)
    INTO an_usedefphr
    FROM addformparamval
   WHERE mid = an_fid AND nsort = -2;

  FOR lc IN (SELECT bvalue
               FROM addformparamval
              WHERE mid = an_fid AND nsort = -3) LOOP
   ab_before := lc.bvalue;
  END LOOP;

  FOR lc IN (SELECT bvalue
               FROM addformparamval
              WHERE mid = an_fid AND nsort = -4) LOOP
   ab_after := lc.bvalue;
  END LOOP;
 END;

-------------------------------------------------------------------------------
FUNCTION get_number (an_id NUMBER, an_parent NUMBER)--функция возвращает номер п/п (cv_proc 16)
  RETURN NUMBER IS
--Определяет номер текущей строки, если PARENT не NULL, и определяет номер родителя, если PARENT NULL  
  NUM NUMBER DEFAULT 0;
  PAR NUMBER;
  PAR2 NUMBER;
  temp NUMBER;
  BEGIN
  
  IF an_parent IS NULL THEN
    SELECT PARENT INTO PAR FROM GROUPS WHERE GID=an_id;
    SELECT PARENT INTO PAR2 FROM GROUPS WHERE GID=PAR;
    
    SELECT s.gid, s.rnum INTO temp, NUM 
    FROM (SELECT  ROWNUM rnum, g.gid, g.name
          FROM GROUPS g WHERE LEVEL=1 AND g.GID IN (SELECT PARENT FROM GROUPS)
          CONNECT BY PRIOR gid = PARENT 
          START WITH PARENT = PAR2 ORDER SIBLINGS BY NVL(util_pg.get_param (g.vparam, 1), g.NAME)) s 
          
    WHERE s.gid=PAR;
    
  ELSE 
    SELECT s.gid, s.rnum INTO temp, NUM  
    FROM (SELECT  ROWNUM rnum, g.gid, g.name
          FROM GROUPS g WHERE LEVEL=1 --AND g.GID IN (SELECT PARENT FROM GROUPS)
          CONNECT BY PRIOR gid = PARENT 
          START WITH PARENT = an_parent ORDER SIBLINGS BY NVL(util_pg.get_param (g.vparam, 1), g.NAME)) s 
          
    WHERE s.gid=an_id;
   END IF; 
    RETURN NUM;

  END;
-----------------------------------------------------------------------------
END;   -- Package Body uniinterior_pg
/


-- End of DDL Script for Package Body RYDA.UNIINTERIOR_PG

-- Start of DDL Script for Package Body RYDA.DIAGRAM_PG
-- Generated 14.04.2009 14:33:42 from RYDA@OE

CREATE OR REPLACE 
PACKAGE BODY diagram_pg IS
 ------------------------------------------------------------------------------------------------------------------------
   -- пакет для работы с диаграмами и схемами сети
   -- дата создания 12/06/2004 Сечин А.А.
 ------------------------------------------------------------------------------------------------------------------------
 -- Процедура используется для схемы сети (Modus) Возвращает значение цвет и направление по ид объекта
 /*
declare
an_value NUMBER;
an_arrow NUMBER;
an_color NUMBER;
lv_par VARCHAR2(4000) default 'MID.45199.R';
begin
diagram_pg.get_modusinfo_byid(lv_par,an_value,an_arrow,an_color);
dbms_output.put_line('an_value='||an_value||'; an_arrow='||an_arrow||'; an_color='||an_color);
dbms_output.put_line(lv_par);
end;
*/
 PROCEDURE get_modusinfo_byid (av_id VARCHAR2, ad_date DATE, an_value OUT NUMBER, an_arrow OUT NUMBER, an_color OUT NUMBER, an_type OUT NUMBER) IS
  cv_halfhour     CONSTANT VARCHAR2 (32)   := 'HALFHOUR';
  cv_curr_power   CONSTANT VARCHAR2 (32)   := 'CURR_POWER';
  lv_type                  VARCHAR2 (32);
  ln_id                    NUMBER;
  lv_prop                  VARCHAR2 (32);
  lv_objtable              VARCHAR2 (32);   --Таблица ограничения по объектам
  lv_datatable             VARCHAR2 (32);   --Таблица с данными
  lv_inverted              VARCHAR2 (32);   --Признак инверсии
  lv_partly_er             VARCHAR2 (32);   --Частичное вхождение A+
  lv_partly_ed             VARCHAR2 (32);   --Частичное вхождение A-
  lv_objsubsel             VARCHAR2 (512);   --Ограничение по объектам
  lv_datsubsel             VARCHAR2 (512);   --Ограничение по дате
  lv_what                  VARCHAR2 (512);   --Что тянем
  lv_sql                   VARCHAR2 (4000);   --Конечный SQL
  lv_obsolescence          VARCHAR2 (512);   --Устаревание данных
  ln_ret                   NUMBER;
  ln_ret1                  NUMBER;
  lv_dat                   VARCHAR2 (32);   --Устаревание данных
  ld_date                  DATE;   --Дата показа (NULL когда текущие)
  ln_arrow                 NUMBER;
 BEGIN
  --Занулили от греха подальше
  an_value := 0;
  an_arrow := cn_modus_arrow_null;
  an_color := cn_cl_green;
  an_type := 0;
  --Разобрали входную строку
  lv_type := TRIM (UPPER (util_pg.get_param (av_id, 1, '.')));
  ln_id := TRIM (util_pg.get_param (av_id, 2, '.'));
  lv_prop := TRIM (UPPER (util_pg.get_param (av_id, 3, '.')));

  --Сейчас умеем не только тек мощность
  IF SUBSTR (lv_prop, LENGTH (lv_prop), 1) = '_' THEN
   lv_datatable := cv_halfhour;
   ld_date := util_pg.trunchh24_2 (NVL (ad_date, SYSDATE - 10 / 1440));
   lv_datsubsel := ' and p.date_time=to_date(''' || TO_CHAR (ld_date, 'dd.mm.yyyy hh24:mi:ss') || ''',''dd.mm.yyyy hh24:mi:ss'') ';
   lv_dat := '_';
   lv_prop := SUBSTR (lv_prop, 1, LENGTH (lv_prop) - 1);
  ELSIF lv_prop = 'EB' THEN   --С начала смены
   lv_datatable := cv_halfhour;
   ld_date := NVL (ad_date, SYSDATE);

   IF (TO_CHAR (ld_date, 'HH24')) >= 8 AND (TO_CHAR (ld_date, 'HH24')) < 20 THEN
    ld_date := TRUNC (ld_date) + 8 / 24;
   ELSIF (TO_CHAR (ld_date, 'HH24')) >= 20 THEN
    ld_date := TRUNC (ld_date) + 20 / 24;
   ELSE
    ld_date := TRUNC (ld_date) - 1 + 20 / 24;
   END IF;

   lv_datsubsel :=
    ' and p.date_time>to_date(''' || TO_CHAR (ld_date, 'dd.mm.yyyy hh24:mi:ss') || ''',''dd.mm.yyyy hh24:mi:ss'') AND ' || ' p.date_time<=to_date('''
    || TO_CHAR (ld_date + 1 / 2, 'dd.mm.yyyy hh24:mi:ss') || ''',''dd.mm.yyyy hh24:mi:ss'') ';
  ELSE
   lv_datatable := cv_curr_power;
  END IF;

  IF lv_datatable = cv_curr_power THEN
   lv_obsolescence := 'decode(sign(' || util_pg.obsolescence_f || '/1440-abs(sysdate-p.date_time)),1,1,NULL)*';
  END IF;

  IF lv_type = 'GID' THEN
   lv_objtable := 'GROUPS';
   lv_inverted := 'G.INVERTED';
   lv_partly_er := '*decode(g.NPARTLY,2,0,1)';
   lv_partly_ed := '*decode(g.NPARTLY,1,0,1)';

   IF util_pg.get_customer_id = 1 THEN
    lv_objsubsel :=
     'and G.gid in (select gid from groups connect by ((prior gid=parent) or (prior NROOT2=NROOT2 and prior nroot1>0 and nroot1 is null)) start with gid=' || ln_id
     || ')';
   ELSE
    lv_objsubsel := 'and G.gid in (select gid from groups connect by (prior gid=parent) start with gid=' || ln_id || ')';
   END IF;
  ELSIF lv_type = 'MID' THEN
   lv_objtable := 'POINTS';
   lv_inverted := '''N''';
   lv_partly_er := '';
   lv_partly_ed := '';

   IF util_pg.isfolder (ln_id) = 1 THEN
    lv_objsubsel := 'and G.mid in (select mid from points connect by prior mid=parent start with mid=' || ln_id || ')';
   ELSE
    lv_objsubsel := 'and G.mid = ' || ln_id || ' ';
   END IF;
  ELSIF lv_type = 'DATE' THEN   --Дата
   an_value := util_pg.trunchh24_2 (NVL (ad_date, SYSDATE - 10 / 1440)) - TO_DATE ('18991230', 'YYYYMMDD');
   an_type := 1;
   RETURN;
  ELSIF lv_type = 'SYSDATE' THEN   --Дата
   an_value := SYSDATE - TO_DATE ('18991230', 'YYYYMMDD');
   an_type := 1;
   RETURN;
  END IF;

  --Выясняем что нам нужно
  IF lv_prop = 'ER' THEN
   lv_what := 'sum(' || lv_obsolescence || '(DECODE(' || lv_inverted || ',''y'',nvl(P.ed' || lv_partly_ed || ',0),nvl(P.er' || lv_partly_er || ',0))))';
  ELSIF lv_prop = 'ED' THEN
   lv_what := 'sum(' || lv_obsolescence || '(DECODE(' || lv_inverted || ',''y'',nvl(P.er' || lv_partly_er || ',0),nvl(P.ed' || lv_partly_ed || ',0))))';
  ELSIF lv_prop = 'Q1' THEN
   lv_what := 'sum(' || lv_obsolescence || '(DECODE(' || lv_inverted || ',''y'',nvl(P.q3,0),nvl(P.q1,0))))';
  ELSIF lv_prop = 'Q3' THEN
   lv_what := 'sum(' || lv_obsolescence || '(DECODE(' || lv_inverted || ',''y'',nvl(P.q1,0),nvl(P.q3,0))))';
  ELSIF lv_prop = 'Q2' THEN
   lv_what := 'sum(' || lv_obsolescence || '(DECODE(' || lv_inverted || ',''y'',nvl(P.q4,0),nvl(P.q2,0))))';
  ELSIF lv_prop = 'Q4' THEN
   lv_what := 'sum(' || lv_obsolescence || '(DECODE(' || lv_inverted || ',''y'',nvl(P.q2,0),nvl(P.q4,0))))';
  ELSIF lv_prop = 'Q12' THEN   --Свернутые Q1+Q2
   lv_what :=
    'sum(' || lv_obsolescence || '(DECODE(' || lv_inverted || ',''y'',nvl(P.q3,0),nvl(P.q1,0))))+sum(' || lv_obsolescence || '(DECODE(' || lv_inverted
    || ',''y'',nvl(P.q4,0),nvl(P.q2,0))))';
  ELSIF lv_prop = 'Q34' THEN   --Свернутые Q3+Q4
   lv_what :=
    'sum(' || lv_obsolescence || '(DECODE(' || lv_inverted || ',''y'',nvl(P.q1,0),nvl(P.q3,0))))+sum(' || lv_obsolescence || '(DECODE(' || lv_inverted
    || ',''y'',nvl(P.q2,0),nvl(P.q4,0))))';
  ELSIF lv_prop = 'E' THEN   --Переток ER-ED
   lv_what :=
    'sum(' || lv_obsolescence || '(-util_pg.sld(P.mid,nvl(P.er' || lv_partly_er || ',0),nvl(P.ed' || lv_partly_ed || ',0))*DECODE(' || lv_inverted
    || ',''y'',1,-1)))';
  ELSIF lv_prop = 'EB' THEN   --Переток ER-ED (с начала смены)
   lv_what :=
    'sum(' || lv_obsolescence || '(-util_pg.sld(P.mid,nvl(P.er' || lv_partly_er || ',0),nvl(P.ed' || lv_partly_ed || ',0))*DECODE(' || lv_inverted
    || ',''y'',1,-1)))';
  ELSIF lv_prop = 'Q' THEN   --Переток (Q1-Q3)+(Q2-Q4)
   lv_what :=
    'sum(' || lv_obsolescence || '(-util_pg.sld(P.mid,nvl(P.q1,0),nvl(P.q3,0))*DECODE(' || lv_inverted || ',''y'',1,-1)))+sum(' || lv_obsolescence
    || '(-util_pg.sld(P.mid,nvl(P.q2,0),nvl(P.q4,0))*DECODE(' || lv_inverted || ',''y'',1,-1)))';
  ELSIF lv_prop IN ('PROC', 'BALANCEP') THEN   --Небаланс в%
   ln_ret := get_modusinfo_byid (lv_type || '.' || ln_id || '.' || 'ER' || lv_dat);
   ln_ret1 := get_modusinfo_byid (lv_type || '.' || ln_id || '.' || 'ED' || lv_dat);

   IF GREATEST (ln_ret, ln_ret1) <> 0 THEN
    ln_ret := 100 * (ln_ret - ln_ret1) / GREATEST (ln_ret, ln_ret1);
   ELSE
    ln_ret := GREATEST (ln_ret, ln_ret1);
   END IF;
  ELSIF lv_type = 'GID' AND lv_prop = 'ADBALANCE' THEN   --Допустимый небаланс
   an_value := ROUND (util_pg.get_ad_balance (ln_id, ld_date - 1 / 48, ld_date, NULL) / 1000, 3);
   RETURN;
  ELSIF lv_type = 'GID' AND lv_prop = 'ADBALANCEP' THEN   --Допустимый небаланс в%
   an_value := util_pg.get_ad_balance (ln_id, ld_date - 1 / 48, ld_date, 1);
   RETURN;
  ELSIF lv_type = 'GID' AND lv_prop = 'BALANCEDIF' THEN   --Разность факт небаланса и допустим небаланса
   ln_ret := get_modusinfo_byid (lv_type || '.' || ln_id || '.' || 'E' || lv_dat);
   ln_ret1 := get_modusinfo_byid (lv_type || '.' || ln_id || '.' || 'ADBALANCE' || lv_dat);
   ln_ret := SIGN (ln_ret) * GREATEST (ABS (ln_ret) - ln_ret1, 0);
  ELSIF lv_type = 'GID' AND lv_prop = 'BALANCEDIFP' THEN   --Разность факт небаланса и допустим небаланса в %
   ln_ret := get_modusinfo_byid (lv_type || '.' || ln_id || '.' || 'BALANCEP' || lv_dat);
   ln_ret1 := get_modusinfo_byid (lv_type || '.' || ln_id || '.' || 'ADBALANCEP' || lv_dat);
   ln_ret := SIGN (ln_ret) * GREATEST (ABS (ln_ret) - ln_ret1, 0);
  END IF;

  IF lv_datatable IS NOT NULL AND lv_objtable IS NOT NULL AND lv_what IS NOT NULL THEN
   lv_sql := 'select ' || lv_what || ' from ' || lv_datatable || ' P,' || lv_objtable || ' G where p.mid=g.mid ' || ' ' || lv_datsubsel || ' ' || lv_objsubsel;

   EXECUTE IMMEDIATE lv_sql
                INTO ln_ret;

   ln_ret := ROUND (ln_ret / 1000, 3);
  END IF;

  ln_ret := NVL (ln_ret, 0);

  IF ln_ret < 0 THEN
   ln_ret := -ln_ret;
   an_arrow := NVL (ln_arrow, cn_modus_arrow_down);
   an_color := cn_cl_green;
  ELSIF ln_ret > 0 THEN
   an_arrow := NVL (ln_arrow, cn_modus_arrow_up);
   an_color := cn_cl_red;
  END IF;

  an_value := ln_ret;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error (-20001, 'diagram_pg.get_modusinfo_byid: ИД=''' || av_id || ''' ' || CHR (10) || SQLERRM);
 END;

------------------------------------------------------------------------------------------------------------------------
  -- Процедура используется для схемы сети (Modus) Возвращает значение цвет и направление по ид объекта
 FUNCTION get_modusinfo_byid (av_id VARCHAR2)
  RETURN NUMBER IS
  ln_value   NUMBER;
  ln_arrow   NUMBER;
  ln_color   NUMBER;
  ln_type    NUMBER;
 BEGIN
  get_modusinfo_byid (av_id, ln_value, ln_arrow, ln_color, ln_type);
  RETURN ln_value;
 END;

------------------------------------------------------------------------------------------------------------------------
   -- Используется для автоопределения даты (последняя получасовка)
 PROCEDURE get_modusinfo_byid (av_id VARCHAR2, an_value OUT NUMBER, an_arrow OUT NUMBER, an_color OUT NUMBER, an_type OUT NUMBER) IS
  ln_value   NUMBER;
  ln_arrow   NUMBER;
  ln_color   NUMBER;
  ln_type    NUMBER;
 BEGIN
  get_modusinfo_byid (av_id, NULL, ln_value, ln_arrow, ln_color, ln_type);
  an_value := ln_value;
  an_arrow := ln_arrow;
  an_color := ln_color;
  an_type := ln_type;
 END;
------------------------------------------------------------------------------------------------------------------------
END;   -- Package Body diagram_pg
/


-- Start of DDL Script for Package Body RYDA.PGOK_PG
-- Generated 14.04.2009 15:56:16 from RYDA@OE

CREATE OR REPLACE 
PACKAGE BODY pgok_pg IS
 ------------------------------------------------------------------------------------------------------------------------
 --Копирование данных из таблиц с ПГОК в получасовки
 PROCEDURE copy_pgok_data(an_maket NUMBER, ad_date DATE) IS
  cn_step   CONSTANT NUMBER              := 1 / 48;
  ld_date            DATE                DEFAULT TRUNC(ad_date-1);
  ld_tmp DATE;
  ln_rn              NUMBER DEFAULT 3;
  lc0                common_pg.tcur;
  lc1                common_pg.tcur;
  ln_val_k           NUMBER;    -- значение выхода в тоннах
  ln_val_u           NUMBER;    -- значение удельного выхода
  ln_val_r           NUMBER;    -- значение расхода в кВт
  ln_mid_k           NUMBER;    -- mid точки с выходом (kонцентратом)
  ln_mid_u           NUMBER;    -- mid соответствующей точки с уд. выходом
  ln_ras_gid         NUMBER;    -- gid секции с расходом, из которой берутся данные
  ln_section         NUMBER;
  ln_section_u       NUMBER;
  lv_table           VARCHAR2 (256);
  lv_sql             VARCHAR2 (2000);
  ln_temp            NUMBER;
      
 BEGIN

  OPEN lc0 FOR  SELECT konc.mid k_mid, konc.vcode k_vcode, ud.mid u_mid, ud.vcode u_vcode, ud.ras_gid ras_gid
                FROM
                (SELECT mid, util_pg.allnumber_f(util_pg.get_param(trim(vcode),2,'_')) vcode
                  FROM feeders
                 WHERE UPPER(vcode) LIKE 'KONC/_%' ESCAPE '/'
                       AND util_pg.allnumber_f(util_pg.get_param(trim(vcode),2,'_')) BETWEEN 1 AND 15) konc,
                (SELECT mid, util_pg.allnumber_f(util_pg.get_param(trim(vcode),2,'_')) vcode, util_pg.allnumber_f(util_pg.get_param(trim(vcode),3,'_')) ras_gid
                   FROM feeders
                  WHERE UPPER(vcode) LIKE 'UD/_%' ESCAPE '/'
                        AND util_pg.allnumber_f(util_pg.get_param(trim(vcode),2,'_')) BETWEEN 1 AND 15) ud
                WHERE konc.vcode=ud.vcode(+)
                ORDER BY k_vcode;
  LOOP
   FETCH lc0
    INTO ln_mid_k, ln_section, ln_mid_u, ln_section_u, ln_ras_gid;

   EXIT WHEN lc0%NOTFOUND;

   DELETE FROM halfhourold
         WHERE mid = ln_mid_k AND date_time > ld_date;
   IF ln_mid_u IS NOT NULL THEN
      DELETE FROM halfhourold
         WHERE mid = ln_mid_u AND date_time > ld_date;
   END IF;               

--dbms_output.put_line(chr(13)||'ln_section='||ln_section);   
   IF ln_section IS NULL THEN
     raise_application_error(-20001,'Не найден номер секции в коде точки '||ln_mid_k);
   END IF;
   
   IF ln_section BETWEEN 1 AND 8 THEN
      lv_table := ' RYDA_OF1 ';  
   ELSIF ln_section BETWEEN 10 AND 15 THEN
      lv_table := ' RYDA_OF2 ';
   ELSE   
      raise_application_error(-20001,'Номер секции в коде точки '||ln_mid_k||' выходит за границы возможных.'); 
   END IF; 
--dbms_output.put_line('----------------- '||lv_table);
   BEGIN
     lv_sql := 'SELECT konc.k_date, konc.k_val, rashod.r_val
                FROM
                (SELECT SUM(util_pg.sld(h.mid,NVL(h.er*DECODE(g.NPARTLY,2,0,1),0),NVL(h.ed*DECODE(g.NPARTLY,1,0,1),0))*DECODE(G.INVERTED,''y'',-1,1)) r_val,
                        trunc(h.date_time-1/86400,''hh24'')+1/24 r_date
                  FROM halfhour h, GROUPS g 
                 WHERE :ln_ras_gid IS NOT NULL AND :ln_mid_u IS NOT NULL
                       AND g.gid IN (SELECT gid FROM GROUPS WHERE mid>0 CONNECT BY PRIOR gid=parent START WITH parent=:ln_ras_gid)
                       AND h.mid=g.mid
                       AND h.date_time > :ld_date
                 GROUP BY trunc(h.date_time-1/86400,''hh24'')+1/24
                 ORDER BY r_date DESC) rashod,
                (SELECT orderdate+tekchassm/24 k_date, m_'||ln_section||' k_val FROM '||lv_table||' WHERE orderdate > :ld_date) konc
                WHERE konc.k_date=rashod.r_date(+)';
     OPEN lc1 FOR lv_sql USING ln_ras_gid,ln_mid_u,ln_ras_gid,ld_date,ld_date;
     LOOP
       FETCH lc1
        INTO ld_tmp, ln_val_k, ln_val_r;
 
       EXIT WHEN lc1%NOTFOUND;
--dbms_output.put_line('ld_date='||to_char(ld_date,'dd.mm.yy hh24:mi:ss')||chr(13)||' ln_val_k='||ln_val_k||' ln_val_r='||ln_val_r);
       -- вставка выхода в тоннах
       IF (ln_val_k IS NOT NULL) THEN
          ln_temp := TRUNC (ln_val_k/2, 0);          
--dbms_output.put_line('вставка первой половины '||ln_temp||'_точки '||ln_mid_k);       
          das_pg.ins_halfhourtmp (ln_mid_k, util_pg.to_unlocaltime_if_new (ld_tmp-1/48), NULL, ln_temp, NULL, NULL, NULL, NULL, NULL,NULL, NULL, NULL);
          ln_temp := ln_val_k - ln_temp;
--dbms_output.put_line('вставка второй половины '||ln_temp||'_точки '||ln_mid_k);       
          das_pg.ins_halfhourtmp (ln_mid_k, util_pg.to_unlocaltime_if_new (ld_tmp), NULL, ln_temp, NULL, NULL, NULL, NULL, NULL,NULL, NULL, NULL);
--dbms_output.put_line('конец вставки ВЫВОДА'); 
       END IF;
      
       -- подсчет удельного расхода в кВтч/т
       IF ln_val_k IS NOT NULL AND ln_val_r IS NOT NULL AND ln_val_k<>0 THEN
         ln_val_u := trunc(ln_val_r/ln_val_k,ln_rn);
       ELSE  
         ln_val_u := NULL;   
       END IF;
--dbms_output.put_line(' ln_val_u='||ln_val_u);       
       -- вставка выхода в тоннах
       IF (ln_val_u IS NOT NULL) THEN
          ln_temp := TRUNC (ln_val_u/2, 0);  
--dbms_output.put_line('_вставка первой половины '||ln_temp||'_точки '||ln_mid_u);         
          das_pg.ins_halfhourtmp (ln_mid_u, util_pg.to_unlocaltime_if_new (ld_tmp-1/48), NULL, ln_temp, NULL, NULL, NULL, NULL, NULL,NULL, NULL, NULL);
          ln_temp := ln_val_u - ln_temp;
--dbms_output.put_line('_вставка второй половины '||ln_temp||'_точки '||ln_mid_u);         
          das_pg.ins_halfhourtmp (ln_mid_u, util_pg.to_unlocaltime_if_new (ld_tmp), NULL, ln_temp, NULL, NULL, NULL, NULL, NULL,NULL, NULL, NULL);          
--dbms_output.put_line('конец вставки УДЕЛЬНЫХ'); 
       END IF;
    
     END LOOP;

     CLOSE lc1;
    EXCEPTION
     WHEN OTHERS THEN
      IF lc1%ISOPEN THEN
       CLOSE lc1;
      END IF;
--dbms_output.put_line('---------------------------- ЗАЛЕТ! ');      
   END;
 
  END LOOP;

  CLOSE lc0;

  COMMIT;
  das_pg.checkhalfhour;
  COMMIT;
 EXCEPTION
  WHEN OTHERS THEN
   ROLLBACK;
   raise_application_error (-20001, 'PGOK_PG.copy_pgok_data: ' || SQLERRM (SQLCODE));
 END;   
 ------------------------------------------------------------------------------------------------------------------------ 

   -- Enter further code below as specified in the Package spec.
END;
/


-- End of DDL Script for Package Body RYDA.PGOK_PG
-- End of DDL Script for Package Body RYDA.DIAGRAM_PG

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

