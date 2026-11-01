SET ECHO OFF
SET TERMOUT OFF
SET ECHO OFF
SET PAGESIZE 999
SET HEADING OFF
SET FEEDBACK OFF
begin
for lc in (select 'drop '||OBJECT_TYPE||' '||object_name||'' c from user_objects  where OBJECT_TYPE in ('TRIGGER')) loop
execute immediate lc.c;
end loop;
for lc in
(select 'drop table '||table_NAME||' cascade constraints' c from user_tables --order by table_NAME
union all
select 'drop view '||view_NAME||' cascade constraints' c from user_views --order by view_NAME
union all
select 'drop '||OBJECT_TYPE||' '||object_name||'' c from user_objects  where OBJECT_TYPE in ('PACKAGE','SEQUENCE','PROCEDURE','FUNCTION','DATABASE LINK','TYPE')) loop
execute immediate lc.c;
end loop;
for lc in (select JOB from user_jobs) loop
    dbms_job.remove(lc.JOB);
end loop;
commit;
end;
/

begin
execute immediate 'CREATE ROLE askue_work';
exception
 when others then null;
end;
/
GRANT CREATE SESSION TO askue_work
/
GRANT ALTER SESSION TO askue_work
/

EXIT;