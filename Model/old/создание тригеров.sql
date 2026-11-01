DECLARE
-----------------
 CURSOR cr_del IS --для удаления
  SELECT object_name
    FROM user_objects
   WHERE object_type = 'TRIGGER' AND (object_name LIKE '%INS' OR object_name LIKE '%UPD' OR object_name LIKE '%DEL');
-----------------
/*
select ''''||TABLE_NAME||''',' from user_tables
where TABLE_NAME not in ('COMPORTEVENTS','CURR_POWER_ARCH','M30817','MAKETTEMP','ROUND_ERRORS','TEXTREPORT','CHANNELSLOG',
'FORMS_EX','JOBS','LG_LOADPROF','LG_READOUT','MONITORS','PLAN_TABLE','SQLN_EXPLAIN_PLAN','VERSION','FISCAL','PROFILE','EA_EVENTS',
'JOURNAL','FULLJOURNAL','LAGGING_RECORDS','PROTOCOLS','EXPORT_BILL','EXPORT_GROUPS','EXPORT_HOUR','EXPORT_PROF','FORM_TEMPLATES','PROCEDURES',
'TRAFFIC','MEASURES','DEPORTPROCEDURES','ITEKCOEFF','PASSIVE_DVS','TASKS')
and TABLE_NAME not like 'UPDT%'
order by 1
*/
 CURSOR cr IS --общие таблицы
  SELECT table_name
    FROM user_tables
   WHERE TEMPORARY='N' and table_name IN (
'BILL_CALC',
'CALCARGUMENTS',
'CALCPOINTS',
'CALCPOINTTYPE',
'CHANNELS',
'CHANPOINT',
'CHECK_RESULTS',
'CHECK_RESULTSG',
'CHECK_STATUS',
'COMPORTS',
'COMPORTTYPE',
'CONNECTIONPARAM',
'CONNECTIONPARAMFULLHOURS',
'CS_PROFILE',
'CURR_POWER',
'DB_TERM',
'DEPARTMENTS',
'DEPORTATION',
'DEPORTFILES',
'DETTURNOVER',
'DIFTARIFF',
'ENTERPRISE',
'FEEDERS',
'FORMS',
'FORM_GROUP',
'GROUPLIMIT',
'GROUPS',
'GROUPTYPES',
'LAST_EXPORT',
'LAST_SAVE',
'MAKETFORMULAS',
'MAKETGROUPS',
'MAKETPOINTS',
'MAKETS',
'MAN_INP_HHOUR',
'MAXHOURS',
'METERS',
'METERSHISTORY',
'MONITOR_SCHEMES',
'MONTHSORG',
'OPERSCANSCHEMAS',
'PARALLELCONNECTION',
'PARAMETER',
'POINTFULLHOURS',
'POINTS',
'POINTSPARAM',
'RATES',
'RATE_LIST',
'RATE_SHEDULE',
'REALPOINT',
'RECOMPENS',
'RELATEDPARAM',
'REPORTGROUPS',
'REPORTS',
'ROLES',
'ROLE_GROUPS',
'ROLE_TASK',
'SCHEMCHANNELS',
'SHAREDCONNECTIONPARAM',
'SLSTATUS',
'SWITCHES',
'TARIFF',
'TARIFFTYPE',
'TRANSFORMER',
'TRANSFORMERHISTORY',
'USEDCONSUMPT',
'USERS',
'ADDFORMPARAM',
'ADDFORMPARAMVAL',
'ADDPOINTPARAM',
'ADDPOINTPARAMVAL',
'BASEFORMULA',
'BASEFORMULPARAMS'
,'CHANINTERVAL'
,'FORMULPARAMS'
,'POINTFORMULA'
,'PRIORITY'
,'USERFORUM'
,'USERFORUMDET'
,'FILTERS'
,'MONITORS'
,'MRIDS'
,'OPERATINGDAY'
,'VERSION'
) order by 1;
-----------------,
/* CURSOR cr2 IS --таблицы администрирования
  SELECT table_name
    FROM user_tables
   WHERE table_name IN ('PAR_LIST', 'REP_PARAM', 'ROLES', 'ROLREPORT', 'ROLTASK', 'TASKS', 'USERS');*/
-----------------
 CURSOR cr1(av_table_name IN VARCHAR2) IS
  SELECT column_name, data_type
    FROM user_tab_columns
   WHERE table_name = av_table_name
   and data_type not in ('LONG RAW','LONG','CLOB','BLOB');
-----------------
 CURSOR cr3(av_table_name IN VARCHAR2) IS
  SELECT   DECODE(tc.data_type, 'DATE', 'to_char(:new.' || cc.column_name || ', ''dd.mm.yyyy hh24:mi:ss'')', ':new.' || cc.column_name) cname
      FROM user_constraints c, user_cons_columns cc, user_tab_columns tc
     WHERE c.table_name = av_table_name
       AND c.constraint_type = 'P'
       AND c.constraint_name = cc.constraint_name
       AND cc.column_name = tc.column_name
       AND tc.table_name = av_table_name
  ORDER BY cc.position;
 ------------------------------
 zxc   sys.UTL_FILE.file_type;
 lv    VARCHAR2(2000);
 lv_pk VARCHAR2(2000);
 i     NUMBER;
------------------------------
BEGIN
 zxc := sys.UTL_FILE.fopen('c:\', 'Triggers.sql', 'w'); --????????
 ------------------------------удаление всех тригеров---------------------------------------
 IF FALSE THEN
   FOR LN IN cr_del LOOP
    lv := 'DROP TRIGGER ' || LN.object_name || ';';
    sys.UTL_FILE.put_line(zxc, lv);
   END LOOP;
   sys.UTL_FILE.fclose(zxc);
   return;
 END IF;
 ------------------------------общие таблицы------------------------------------------------
 FOR LN IN cr LOOP
  lv_pk := 'NULL';
  i := 0;
  FOR lc IN cr3(LN.table_name) LOOP
   IF i = 0 THEN
    i := 1;
    lv_pk := '';
   END IF;
   lv_pk := lv_pk || '||'',''||' || lc.cname;
  END LOOP;
  IF lv_pk <> 'NULL' THEN
   lv_pk := SUBSTR(lv_pk, 8);
  END IF;
  --************************** del ***************************************--
  lv := 'CREATE OR REPLACE TRIGGER ' || LN.table_name || '_del' || CHR(10) ||
        'AFTER  DELETE' || CHR(10) ||
        'ON ' || LN.table_name || CHR(10) ||
        'REFERENCING NEW AS NEW OLD AS OLD' || CHR(10) ||
        'FOR EACH ROW' || CHR(10) ||
        'declare' || CHR(10) ||
        'lv_Error     VARCHAR2(2000);' || CHR(10) ||
        'ln_Operation NUMBER;';
  sys.UTL_FILE.put_line(zxc, lv);
  lv := 'Begin' || CHR(10) ||
        ' IF util_pg.get_isarch = 1 THEN';
  sys.UTL_FILE.put_line(zxc, lv);
  lv := '   SELECT JOURNAL_SEQ.NextVal INTO ln_Operation FROM dual;';
  sys.UTL_FILE.put_line(zxc, lv);
  FOR lc IN cr1(LN.table_name) LOOP
   IF lc.data_type = 'DATE' THEN
    lv := '   Admin_PG.DelLog(ln_Operation, ''' ||
              LN.table_name || ''', ''' ||
              lc.column_name || ''', to_char(:old.' ||
              lc.column_name || ',''dd.mm.yyyy hh24:mi:ss''));';
    sys.UTL_FILE.put_line(zxc, lv);
   ELSE
    lv := '   Admin_PG.DelLog(ln_Operation, ''' ||
              LN.table_name || ''', ''' ||
              lc.column_name || ''', :old.' ||
              lc.column_name || ');';
    sys.UTL_FILE.put_line(zxc, lv);
   END IF;
  END LOOP;
  lv := ' END IF;' || CHR(10) ||
        'End;' || CHR(10) || '/' || CHR(10);
  sys.UTL_FILE.put_line(zxc, lv);
  --*************************** ins ********************************--
  lv := 'CREATE OR REPLACE TRIGGER ' || LN.table_name || '_ins' || CHR(10) ||
        'AFTER  INSERT' || CHR(10) ||
        'ON ' || LN.table_name || CHR(10) ||
        'REFERENCING NEW AS NEW OLD AS OLD' || CHR(10) ||
        'FOR EACH ROW' || CHR(10) ||
        'declare' || CHR(10) ||
        'lv_Error     VARCHAR2(2000);' || CHR(10) ||
        'ln_Operation NUMBER;';
  sys.UTL_FILE.put_line(zxc, lv);
  lv := 'Begin' || CHR(10) ||
        ' IF util_pg.get_isarch = 1 THEN';
  sys.UTL_FILE.put_line(zxc, lv);
  lv := '   SELECT JOURNAL_SEQ.NextVal INTO ln_Operation FROM dual;';
  sys.UTL_FILE.put_line(zxc, lv);
  FOR lc IN cr1(LN.table_name) LOOP
   IF lc.data_type = 'DATE' THEN
    lv := '   Admin_PG.InsLog(ln_Operation, ''' ||
              LN.table_name || ''', ''' ||
              lc.column_name || ''', to_char(:new.' ||
              lc.column_name || ',''dd.mm.yyyy hh24:mi:ss''));';
    sys.UTL_FILE.put_line(zxc, lv);
   ELSE
    lv := '   Admin_PG.InsLog(ln_Operation, ''' ||
              LN.table_name || ''', ''' ||
              lc.column_name || ''', :new.' ||
              lc.column_name || ');';
    sys.UTL_FILE.put_line(zxc, lv);
   END IF;
  END LOOP;
  lv := ' END IF;' || CHR(10) ||
        'End;' || CHR(10) || '/' || CHR(10);
  sys.UTL_FILE.put_line(zxc, lv);
  --******************************* upd **************************************--
  lv := 'CREATE OR REPLACE TRIGGER ' || LN.table_name || '_upd' || CHR(10) ||
        'AFTER  UPDATE' || CHR(10) ||
        'ON ' || LN.table_name || CHR(10) ||
        'REFERENCING NEW AS NEW OLD AS OLD' || CHR(10) ||
        'FOR EACH ROW' || CHR(10) ||
        'declare' || CHR(10) ||
        'lv_Error     VARCHAR2(2000);' || CHR(10) ||
        'ln_Operation NUMBER;' || CHR(10) ||
        'i            NUMBER := -20102;';
  sys.UTL_FILE.put_line(zxc, lv);
  lv := 'Begin' || CHR(10) ||
        ' IF util_pg.get_isarch = 1 THEN';
  sys.UTL_FILE.put_line(zxc, lv);
  lv := '   SELECT JOURNAL_SEQ.NextVal INTO ln_Operation FROM dual;';
  sys.UTL_FILE.put_line(zxc, lv);
  FOR lc IN cr1(LN.table_name) LOOP
   if lc.data_type = 'NUMBER' then
   lv := '   if nvl(:new.' || lc.column_name || ' ,-999999999999)<> nvl(:old.' || lc.column_name || ',-999999999999) then';
   elsif lc.data_type = 'VARCHAR2' then
   lv := '   if nvl(:new.' || lc.column_name || ' ,'' '')<> nvl(:old.' || lc.column_name || ','' '') then';
   elsif lc.data_type = 'DATE' then
    lv := '   if nvl(:new.' || lc.column_name || ',to_date(''01.01.1900'',''dd.mm.yyyy'')) <> nvl(:old.' || lc.column_name || ',to_date(''01.01.1900'',''dd.mm.yyyy'')) then';
   else
    lv := '   if :new.' || lc.column_name || ' <> :old.' || lc.column_name || ' then';
   end if;
   sys.UTL_FILE.put_line(zxc, lv);
   IF lc.data_type = 'DATE' THEN
    lv := '   Admin_PG.UpdLog(ln_Operation, ''' ||
              LN.table_name || ''', ''' || lc.column_name || ''', to_char(:old.' ||
              lc.column_name || ',''dd.mm.yyyy hh24:mi:ss'')' || ', to_char(:new.' ||
              lc.column_name || ',''dd.mm.yyyy hh24:mi:ss''), ' || lv_pk || ');';
    sys.UTL_FILE.put_line(zxc, lv);
   ELSE
    lv := '   Admin_PG.UpdLog(ln_Operation, ''' ||
              LN.table_name || ''', ''' || lc.column_name || ''', :old.' ||
              lc.column_name || ', :new.' || lc.column_name || ', ' || lv_pk || ');';
    sys.UTL_FILE.put_line(zxc, lv);
   END IF;
   lv := '   end if;';
   sys.UTL_FILE.put_line(zxc, lv);
  END LOOP;
  lv := ' END IF;' || CHR(10) || 'End;' || CHR(10) || '/' || CHR(10);
  sys.UTL_FILE.put_line(zxc, lv);
 END LOOP;
 --------------------------таблицы администрирования---------------------------------------
/* FOR LN IN cr2 LOOP
  lv_pk := 'NULL';
  i := 0;
  FOR lc IN cr3(LN.table_name) LOOP
   IF i = 0 THEN
    i := 1;
    lv_pk := '';
   END IF;
   lv_pk := lv_pk || '||'',''||' || lc.cname;
  END LOOP;
  IF lv_pk <> 'NULL' THEN
   lv_pk := SUBSTR(lv_pk, 8);
  END IF;
  --del--
  lv := 'CREATE OR REPLACE TRIGGER ' || LN.table_name || '_del' || CHR(10) ||
        'AFTER  DELETE' || CHR(10) ||
        'ON ' || LN.table_name || CHR(10) ||
        'REFERENCING NEW AS NEW OLD AS OLD' || CHR(10) ||
        'FOR EACH ROW' || CHR(10) ||
        'declare' || CHR(10) ||
        'ln_Operation NUMBER;';
  sys.UTL_FILE.put_line(zxc, lv);
  lv := 'Begin' || CHR(10) || '   SELECT JOURNAL_ADM_SEQ.NextVal INTO ln_Operation FROM dual;';
  sys.UTL_FILE.put_line(zxc, lv);
  FOR lc IN cr1(LN.table_name) LOOP
   IF lc.data_type = 'DATE' THEN
    lv := '   Admin_PG.DelLog(1, ln_Operation, ''' ||
              LN.table_name || ''', ''' || lc.column_name || ''', to_char(:old.' ||
              lc.column_name || ',''dd.mm.yyyy hh24:mi:ss''));';
    sys.UTL_FILE.put_line(zxc, lv);
   ELSE
    lv := '   Admin_PG.DelLog(1, ln_Operation, ''' ||
              LN.table_name || ''', ''' || lc.column_name || ''', :old.' ||
              lc.column_name || ');';
    sys.UTL_FILE.put_line(zxc, lv);
   END IF;
  END LOOP;
  lv := 'End;' || CHR(10) || '/' || CHR(10);
  sys.UTL_FILE.put_line(zxc, lv);
  --ins--
  lv := 'CREATE OR REPLACE TRIGGER ' || LN.table_name || '_ins' || CHR(10) ||
        'AFTER  INSERT' || CHR(10) ||
        'ON ' || LN.table_name || CHR(10) ||
        'REFERENCING NEW AS NEW OLD AS OLD' || CHR(10) ||
        'FOR EACH ROW' || CHR(10) ||
        'declare' || CHR(10) ||
        'ln_Operation NUMBER;';
  sys.UTL_FILE.put_line(zxc, lv);
  lv := 'Begin' || CHR(10) || '   SELECT JOURNAL_ADM_SEQ.NextVal INTO ln_Operation FROM dual;';
  sys.UTL_FILE.put_line(zxc, lv);
  FOR lc IN cr1(LN.table_name) LOOP
   IF lc.data_type = 'DATE' THEN
    lv := '   Admin_PG.InsLog(1, ln_Operation, ''' ||
              LN.table_name || ''', ''' || lc.column_name || ''', to_char(:new.' ||
              lc.column_name || ',''dd.mm.yyyy hh24:mi:ss''));';
    sys.UTL_FILE.put_line(zxc, lv);
   ELSE
    lv := '   Admin_PG.InsLog(1, ln_Operation, ''' ||
              LN.table_name || ''', ''' || lc.column_name || ''', :new.' ||
              lc.column_name || ');';
    sys.UTL_FILE.put_line(zxc, lv);
   END IF;
  END LOOP;
  lv := 'End;' || CHR(10) || '/' || CHR(10);
  sys.UTL_FILE.put_line(zxc, lv);
  --upd--
  lv := 'CREATE OR REPLACE TRIGGER ' || LN.table_name || '_upd' || CHR(10) ||
        'AFTER  UPDATE' || CHR(10) ||
        'ON ' || LN.table_name || CHR(10) ||
        'REFERENCING NEW AS NEW OLD AS OLD' || CHR(10) ||
        'FOR EACH ROW' || CHR(10) ||
        'declare' || CHR(10) ||
        'ln_Operation NUMBER;';
  sys.UTL_FILE.put_line(zxc, lv);
  lv := 'Begin' || CHR(10) ||
        '   SELECT JOURNAL_ADM_SEQ.NextVal INTO ln_Operation FROM dual;';
  sys.UTL_FILE.put_line(zxc, lv);
  FOR lc IN cr1(LN.table_name) LOOP
   lv := '   if :new.' || lc.column_name || ' <> :old.' || lc.column_name || ' then';
   sys.UTL_FILE.put_line(zxc, lv);
   IF lc.data_type = 'DATE' THEN
    lv := '   Admin_PG.UpdLog(1, ln_Operation, ''' ||
              LN.table_name || ''', ''' || lc.column_name || ''', to_char(:old.' ||
              lc.column_name || ',''dd.mm.yyyy hh24:mi:ss'')' || ', to_char(:new.' ||
              lc.column_name || ',''dd.mm.yyyy hh24:mi:ss''), ' || lv_pk || ');';
    sys.UTL_FILE.put_line(zxc, lv);
   ELSE
    lv := '   Admin_PG.UpdLog(1, ln_Operation, ''' ||
              LN.table_name || ''', ''' || lc.column_name || ''', :old.' ||
              lc.column_name || ', :new.' || lc.column_name || ', ' || lv_pk || ');';
    sys.UTL_FILE.put_line(zxc, lv);
   END IF;
   lv := '   end if;';
   sys.UTL_FILE.put_line(zxc, lv);
  END LOOP;
  lv := 'End;' || CHR(10) || '/' || CHR(10);
  sys.UTL_FILE.put_line(zxc, lv);
 END LOOP;
 lv := 'CREATE OR REPLACE TRIGGER conf_after_update_rep_path'; sys.UTL_FILE.put_line(zxc, lv);
 lv := 'AFTER UPDATE'; sys.UTL_FILE.put_line(zxc, lv);
 lv := '  OF rep_path'; sys.UTL_FILE.put_line(zxc, lv);
 lv := 'ON conf'; sys.UTL_FILE.put_line(zxc, lv);
 lv := 'REFERENCING NEW AS NEW OLD AS OLD'; sys.UTL_FILE.put_line(zxc, lv);
 lv := 'FOR EACH ROW'; sys.UTL_FILE.put_line(zxc, lv);
 lv := 'Begin'; sys.UTL_FILE.put_line(zxc, lv);
 lv := '  UPDATE USERS SET REP_PATH = REPLACE(REP_PATH,:OLD.REP_PATH,:NEW.REP_PATH);'; sys.UTL_FILE.put_line(zxc, lv);
 lv := 'End;'; sys.UTL_FILE.put_line(zxc, lv);
 lv := '/'; sys.UTL_FILE.put_line(zxc, lv);*/
 -------------------------------------------------------------------------------------------
 sys.UTL_FILE.fclose(zxc);
 DBMS_OUTPUT.put_line('OK');
EXCEPTION
 WHEN sys.UTL_FILE.invalid_path THEN
  DBMS_OUTPUT.put_line('invalid_path');
  sys.UTL_FILE.fclose_all;
 WHEN sys.UTL_FILE.invalid_mode THEN
  DBMS_OUTPUT.put_line('invalid_mode');
  sys.UTL_FILE.fclose_all;
 WHEN sys.UTL_FILE.invalid_filehandle THEN
  DBMS_OUTPUT.put_line('invalid_filehandle');
  sys.UTL_FILE.fclose_all;
 WHEN sys.UTL_FILE.invalid_operation THEN
  DBMS_OUTPUT.put_line('invalid_operation');
  sys.UTL_FILE.fclose_all;
 WHEN sys.UTL_FILE.read_error THEN
  DBMS_OUTPUT.put_line('read_error');
  sys.UTL_FILE.fclose_all;
 WHEN sys.UTL_FILE.write_error THEN
  DBMS_OUTPUT.put_line('write_error');
  sys.UTL_FILE.fclose_all;
 WHEN sys.UTL_FILE.internal_error THEN
  DBMS_OUTPUT.put_line('internal_error');
  sys.UTL_FILE.fclose_all;
 WHEN OTHERS THEN
  DBMS_OUTPUT.put_line('zzzzz');
  sys.UTL_FILE.fclose_all;
END;
