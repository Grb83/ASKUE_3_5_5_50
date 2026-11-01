-- Start of DDL Script for Package RYDAARCH.EXEC_DUMP_PG
-- Generated 4-дек-2012 16:03:32 from RYDAARCH@OE

CREATE OR REPLACE 
PACKAGE exec_dump_pg
  IS
  -------------------------------------------------------
PROCEDURE EXP_DUMP_P(av_tables VARCHAR2,av_fname VARCHAR2);
-------------------------------------------------------------
PROCEDURE IMP_DUMP_P(av_filename VARCHAR2);
--------------------------------------------------------------
PROCEDURE DROP_TABLE;
---------------------------------------------------------------
END; -- Package spec
/

-- Grants for Package
GRANT EXECUTE ON exec_dump_pg TO ryda
/


-- End of DDL Script for Package RYDAARCH.EXEC_DUMP_PG

-- Start of DDL Script for Package Body RYDAARCH.EXEC_DUMP_PG
-- Generated 4-дек-2012 16:03:39 from RYDAARCH@OE

CREATE OR REPLACE 
PACKAGE BODY exec_dump_pg
IS
-----------------------------------------------------------------------------------------------------------------------------------
--процедура для выгрузки мини дампа базы
PROCEDURE EXP_DUMP_P(av_tables VARCHAR2,av_fname VARCHAR2) IS

  l_dp_handle       NUMBER;
  err_code VARCHAR2(256);
  err_msg VARCHAR2(1000);
  lv_fpath VARCHAR2(256); 
  lv_fname VARCHAR2(256);
  lv_fpathlog VARCHAR2(256);
  dmp NUMBER;
  log NUMBER;
BEGIN
  lv_fname:=av_fname||'.dmp';
  lv_fpathlog:=av_fname||'.log';

 SELECT MAX(directory_path) INTO lv_fpath FROM all_directories WHERE directory_name = 'DATA_PUMP_DIR_RYDAARCH';
 SELECT DBMS_LOB.FILEEXISTS(BFILENAME ('DATA_PUMP_DIR_RYDAARCH', lv_fname)) INTO dmp FROM DUAL; 
 IF dmp>0 THEN   
  EXECUTE IMMEDIATE 'begin sys.UTL_FILE.fremove(:1,:2); end;'
  USING             lv_fpath, lv_fname;   
 END IF;
 
 SELECT DBMS_LOB.FILEEXISTS(BFILENAME ('DATA_PUMP_DIR_RYDAARCH', lv_fpathlog)) INTO log FROM DUAL; 
 IF log>0 THEN 
  EXECUTE IMMEDIATE 'begin sys.UTL_FILE.fremove(:1,:2); end;'
  USING             lv_fpath, lv_fpathlog;  

 END IF;

    l_dp_handle := DBMS_DATAPUMP.open(
    operation =>'EXPORT',
    job_mode =>  'SCHEMA',
   -- job_mode =>  'TABLE',
    job_name =>  'EMP_EXPORT'||to_char(trunc(sysdate),'yyyymmdd')

  );
   
   

   
     

     
 
    DBMS_DATAPUMP.add_file(
    handle => l_dp_handle,
  --  filename => 'EXP_DMP_'||to_char(trunc(sysdate),'yyyymmdd')||'.dmp',
    filename => av_fname||'.dmp',
    directory => 'DATA_PUMP_DIR_RYDAARCH',
    filetype =>1
    );
    
     
    DBMS_DATAPUMP.add_file(
     handle => l_dp_handle,
   -- filename =>'EXP_LOG_'||to_char(trunc(sysdate),'yyyymmdd')||'.log',
    filename =>av_fname||'.log',
    directory => 'DATA_PUMP_DIR_RYDAARCH',
    filetype =>3
    );
    
     dbms_datapump.metadata_filter (
		handle		=> l_dp_handle,
		name		=> 'SCHEMA_EXPR',
		value		=> 'IN (''RYDA'')'
	
	); 
	dbms_datapump.metadata_filter 
    (handle => l_dp_handle,
     name => 'INCLUDE_PATH_EXPR', 
     value => 'IN (''TABLE'')'); 

    
   DBMS_DATAPUMP.metadata_filter(
     handle =>l_dp_handle,
     name =>'NAME_EXPR',
     value=>'in ( '||av_tables||')',
   	object_type	=> 'TABLE'
 
     );
     
 
  
    
    
  DBMS_DATAPUMP.start_job(l_dp_handle);
  DBMS_DATAPUMP.detach(l_dp_handle);

  EXCEPTION
  WHEN OTHERS 
  THEN
   
      DBMS_DATAPUMP.stop_job(l_dp_handle);
      DBMS_DATAPUMP.detach(l_dp_handle);

END;
----------------------------------------------------------------------------------------------------------------------------
PROCEDURE IMP_DUMP_P(av_filename VARCHAR2) IS
--процедура для загрузки мини дампа базы


  l_dp_handle       NUMBER;
  err_code VARCHAR2(256);
  err_msg VARCHAR2(1000);
 
BEGIN

    DROP_TABLE();

--— using a network link


  l_dp_handle := DBMS_DATAPUMP.open(
    operation =>'IMPORT',
    job_mode =>  'TABLE',
    job_name =>  'IMP_IMPORTS'||to_char(trunc(sysdate),'yyyymmdd')

  );
  
   DBMS_DATAPUMP.set_parameter(
    handle => l_dp_handle,
    name => 'TABLE_EXISTS_ACTION',
    value => 'TRUNCATE');

    DBMS_DATAPUMP.add_file (handle => l_dp_handle,
    filename => av_filename,
    directory => 'DATA_PUMP_DIR_RYDAARCH',
    filetype => 1);
 
    DBMS_DATAPUMP.add_file (handle => l_dp_handle,
    directory => 'DATA_PUMP_DIR_RYDAARCH',
    filename => 'RIMPORT_'||to_char(trunc(sysdate),'yyyymmdd')||'.log',
    filetype => 3);
 
 
  /*  DBMS_DATAPUMP.metadata_filter(
     handle =>l_dp_handle,
     name =>'INCLUDE_NAME_EXPR',
     value =>'in (''RYDA.POINTS'') '
     );*/
 
 -- Remap schema objects from source named RYDA to target RYDAARCH.
 
   DBMS_DATAPUMP.METADATA_REMAP (
   handle=>l_dp_handle,
   name=>   'REMAP_SCHEMA',
   old_value=>   'RYDA',
   value=>   'RYDAARCH');


  

     
  /* DBMS_DATAPUMP.data_filter (
   handle => l_dp_handle, 
   name => 'INCLUDE_ROWS', 
   value => 0); */
  
    
    
  DBMS_DATAPUMP.start_job(l_dp_handle);
  DBMS_DATAPUMP.detach(l_dp_handle);

 
  for c in (select table_name from user_tables )
  loop
       execute immediate
              'GRANT SELECT  ON RYDAARCH.' || c.table_name || ' to RYDA';
   end loop;

  

  EXCEPTION
  WHEN OTHERS 
  THEN
   /*    err_code := SQLCODE;
 
      err_msg := substr(SQLERRM, 1, 200);
 
      INSERT INTO tmp_vil  VALUES (err_code||' '||err_msg);commit;*/

      DBMS_DATAPUMP.stop_job(l_dp_handle);
      DBMS_DATAPUMP.detach(l_dp_handle);
      
      


END; -- Procedure
---------------------------------------------------------------------------------------------------------------------------
PROCEDURE DROP_TABLE IS
BEGIN
    for lc in
      (select 'drop table '||table_NAME||'  cascade constraints PURGE' c from user_tables where table_NAME not like 'SYS_IOT_OVER%' --order by table_NAME
      ) loop
     begin
      execute immediate lc.c;
      exception when others then null;
     end;
    end loop;
 commit;



--PURGE RECYCLEBIN;



for lc in
   (select 'drop table '||table_NAME||' cascade constraints PURGE' c from user_tables where table_NAME not like 'SYS_IOT_OVER%' --order by table_NAME
    ) loop
     begin
      execute immediate lc.c;
      exception when others then null;
      end;
      end loop;
      commit;



--PURGE RECYCLEBIN;


END;
---------------------------------------------------------------------------------------------------------------------------------
END;
/

-- Grants for Package Body
GRANT EXECUTE ON exec_dump_pg TO ryda
/


-- End of DDL Script for Package Body RYDAARCH.EXEC_DUMP_PG

