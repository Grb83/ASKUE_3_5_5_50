--DROP ROLE ASKUE_WORK;
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
GRANT INSERT ON forms_ex TO askue_work
/
GRANT UPDATE ON forms_ex TO askue_work
/
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

