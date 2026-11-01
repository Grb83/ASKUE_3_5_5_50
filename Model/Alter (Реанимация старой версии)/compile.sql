declare
begin
for lc in
(select 'ALTER PACKAGE '||OBJECT_NAME||' COMPILE PACKAGE' c from user_objects where OBJECT_TYPE = 'PACKAGE'AND STATUS = 'INVALID'
union all select 'ALTER VIEW '||OBJECT_NAME||' COMPILE' c from user_objects where OBJECT_TYPE = 'VIEW'AND STATUS = 'INVALID'
union all select 'ALTER PROCEDURE '||OBJECT_NAME||' COMPILE' c from user_objects where OBJECT_TYPE = 'PROCEDURE'AND STATUS = 'INVALID'
union all select 'ALTER FUNCTION ' ||OBJECT_NAME||' COMPILE' c from user_objects where OBJECT_TYPE = 'FUNCTION' AND STATUS = 'INVALID'
union all select 'ALTER PACKAGE '||OBJECT_NAME||' COMPILE BODY' c from user_objects where OBJECT_TYPE = 'PACKAGE BODY' AND STATUS = 'INVALID'
union all select 'ALTER TRIGGER ' ||OBJECT_NAME||' COMPILE' c from user_objects where OBJECT_TYPE = 'TRIGGER' AND STATUS = 'INVALID') loop
begin
execute immediate lc.c;
exception
 when others then null;
end;
end loop;
end;
/


