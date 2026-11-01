SELECT   gid, vparam
                 FROM GROUPS
                WHERE LOWER (vparam) LIKE 'баланс%'
             ORDER BY NAME, gid
             
select t.name,t.dat,t.sld,t.lim,t.sld-t.lim dif,t.gid from 
(select g.gid,g.name,dd.dt+1/24 dat, util_pg.get_saldo (g.gid, dd.dt, dd.dt+1/24) sld,util_pg.get_grouplimit (g.gid, dd.dt+1/24) lim
 from groups g,
	(SELECT TRUNC(SYSDATE)+d.dat/24-1/24 dt FROM maxhours m, (select rownum dat from dual connect by level<=24) d
WHERE  m.DATE_TIME=(SELECT MIN(DATE_TIME) FROM   maxhours WHERE  date_time <= TRUNC(SYSDATE))
and ((d.dat>to_char(m.MORNING_START,'HH24') and d.dat<=to_char(m.MORNING_END,'HH24')) or (d.dat>to_char(m.EVENING_START,'HH24') and d.dat<=to_char(m.EVENING_END,'HH24')))) dd	
where g.gid in (SELECT DISTINCT gid FROM grouplimit WHERE dstart <= trunc(sysdate)) ) t
where t.sld>t.lim 
order by t.name,t.gid,t.dat

select * from 



   ln_fact := (60 / ln_typever) * util_pg.get_saldo (lc.gid, ld_date, ld_date + ln_typever / 1440);
   ln_limit := util_pg.get_grouplimit (lc.gid, ld_date + ln_typever / 1440)             
