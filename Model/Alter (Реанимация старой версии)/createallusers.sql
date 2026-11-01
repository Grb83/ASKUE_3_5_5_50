declare
lv_deftablespace varchar2(256) default 'USERS';---Табл пространство (если такого нет, то нужно заменить на существующее)
lv_tmptablespace varchar2(256) default 'TEMP';---Табл пространство (если такого нет, то нужно заменить на существующее)
ln_count NUMBER;
begin
 for lc in (select 1 ntype,u.USR,p.PASSWORD from users u,userpass p where u.user_id=p.user_id and upper(u.USR) not in (select username from all_users)
            union all
            select 2 ntype,u.USR,p.PASSWORD from users u,userpass p where u.user_id=p.user_id and upper(u.USR) in (select username from all_users)) loop
  begin
   if lc.ntype=1 then          
    EXECUTE IMMEDIATE 'CREATE USER ' || lc.USR || ' IDENTIFIED BY ' || lc.PASSWORD || ' DEFAULT TABLESPACE ' ||
                      lv_deftablespace || ' TEMPORARY TABLESPACE ' || lv_tmptablespace;
    EXECUTE IMMEDIATE 'GRANT ASKUE_WORK TO ' || lc.USR;
    EXECUTE IMMEDIATE 'ALTER USER ' || lc.USR || ' DEFAULT ROLE ASKUE_WORK';
   else
    EXECUTE IMMEDIATE 'ALTER USER ' || lc.USR|| ' IDENTIFIED BY ' || lc.PASSWORD;
   end if; 
  exception
   when others then
    NULL;
  end;
  begin
    EXECUTE IMMEDIATE 'GRANT ASKUE_WORK TO ' || lc.USR;
    EXECUTE IMMEDIATE 'ALTER USER ' || lc.USR || ' DEFAULT ROLE ASKUE_WORK';
  exception
   when others then
    NULL;
  end;
 end loop;
end;
/

exit;