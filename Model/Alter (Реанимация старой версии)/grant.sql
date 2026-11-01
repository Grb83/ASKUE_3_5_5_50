DECLARE
lv_role varchar2(256):='ASKUE_WORK';
BEGIN
 IF user='OIK' THEN
  lv_role:='OIK_WORK';
 END IF;

 FOR lc IN (SELECT 'grant select on ' || table_name || ' to '||lv_role c
              FROM user_tables WHERE table_name NOT IN ('USERPASS')
            UNION ALL
            SELECT 'grant select on ' || view_name || ' to '||lv_role c
              FROM user_views
            UNION ALL
            SELECT 'grant execute on ' || object_name || ' to '||lv_role c
              FROM user_objects
             WHERE object_type in ('PROCEDURE','FUNCTION','PACKAGE')) LOOP
  BEGIN
   EXECUTE IMMEDIATE lc.c;
  EXCEPTION
   WHEN OTHERS THEN
    NULL;
  END;
 END LOOP;
END;
/

