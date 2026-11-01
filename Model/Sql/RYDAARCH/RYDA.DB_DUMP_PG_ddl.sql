-- Start of DDL Script for Package RYDA.DB_DUMP_PG
-- Generated 4-дек-2012 16:12:40 from RYDA@OE

CREATE OR REPLACE 
PACKAGE db_dump_pg
  IS
-----------------------------------------------------------------------------------
PROCEDURE EXP_DB(an_maket NUMBER, ad_date DATE);
-----------------------------------------------------------------------------------
PROCEDURE IMP_DB(an_maket NUMBER, ad_date DATE);
-----------------------------------------------------------------------------------
END; -- Package spec
/



-- End of DDL Script for Package RYDA.DB_DUMP_PG

-- Start of DDL Script for Package Body RYDA.DB_DUMP_PG
-- Generated 4-дек-2012 16:12:59 from RYDA@OE

CREATE OR REPLACE 
PACKAGE BODY db_dump_pg
IS
-----------------------------------------------------------------------------------------------------------------------

PROCEDURE EXP_DB(an_maket NUMBER, ad_date DATE) IS
lv_FN VARCHAR2(256);  
lv_TN VARCHAR2(4000);

BEGIN
-- lv_FN:= NVL(file_pg.gv_param,to_char(TRUNC(sysdate),'ddmmyyyy')||'_EXP_DMP');

 lv_FN:= NVL(file_pg.gv_param,to_char(TRUNC(sysdate),'dd')||'_EXP_DMP');
 
 FOR lc IN (SELECT ''''||vtablename||'''' vtab FROM dbnri)
   LOOP
      IF lv_TN IS NULL THEN
        lv_TN:=lc.vtab;
      ELSE
        lv_TN := lv_TN || ',' || lc.vtab;
      END IF;
   END LOOP;

-- select LISTAGG(''''||vtablename||'''',', ') WITHIN GROUP (ORDER BY vtablename) INTO lv_TN  from dbnri;
 
 /* select LISTAGG(''''||TABLE_NAME||'''',', ') WITHIN GROUP (ORDER BY TABLE_NAME) INTO lv_TN  from(
     select TABLE_NAME from user_tables where num_rows<100000 and TABLE_NAME NOT LIKE '%TMP%' and  TABLE_NAME NOT LIKE 'VERSION'
      minus
     select TABLE_NAME from db_term) ;*/

  execute immediate  'begin RYDAARCH.EXEC_DUMP_PG.EXP_DUMP_P(:1,:2);end;'
  USING             lv_TN,lv_FN;
END;
-----------------------------------------------------------------------------------------------------------------------------------
PROCEDURE IMP_DB(an_maket NUMBER, ad_date DATE) IS
  
lv_FN VARCHAR2(256);
 begin
 
   -- lv_FN:= NVL(file_pg.gv_param,to_char(TRUNC(sysdate-1),'ddmmyyyy')||'_EXP_DMP.DMP');
    lv_FN:= NVL(file_pg.gv_param,to_char(TRUNC(sysdate-1),'dd')||'_EXP_DMP.DMP');
   --lv_FN:= util_pg.getparamvaluev_f(60);
   execute immediate 'begin RYDAARCH.EXEC_DUMP_PG.IMP_DUMP_P(:1);end;'
   USING             lv_FN;
 end;
-----------------------------------------------------------------------------------------------------------------------------------
END;
/



-- End of DDL Script for Package Body RYDA.DB_DUMP_PG

