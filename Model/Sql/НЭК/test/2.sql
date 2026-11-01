--delete from tmp_vil
--select * from tmp_vil
select 1/24 from dual
select decode(grouping( util_pg.get_num_dt (util_pg.to_unlocaltime (P.date_time-1/86400,nsource),nsource, 1/24 ,0,1/24,0) ),1,0, util_pg.get_num_dt (util_pg.to_unlocaltime (P.date_time-1/86400,nsource),nsource, 1/24 ,0,1/24,0) ) BGroup ,
     sum( -util_pg.sld( P.mid, P.er   , P.ed   ) *DECODE(  'n'  ,'y',1,-1)   )/1000  AParam ,
      decode(grouping( util_pg.get_num_dt (util_pg.to_unlocaltime (P.date_time-1/86400,nsource),nsource, 1/24 ,0,1/24,0) ),1  ,decode(sign(48-count(*)),1,qm_pg.sumqm(nvl(SUMQM(nvl(p.vqm,qm_pg.defqm)),qm_pg.defqm),qm_pg.nodataqm),nvl(SUMQM(nvl(p.vqm,qm_pg.defqm)),qm_pg.defqm))  ,decode(sign(2-count(*)),1,qm_pg.sumqm(nvl(SUMQM(nvl(p.vqm,qm_pg.defqm)),qm_pg.defqm),qm_pg.nodataqm),nvl(SUMQM(nvl(p.vqm,qm_pg.defqm)),qm_pg.defqm)) ) decnsour  from   points   G,  halfhour  P where G.mid=P.mid
    and  date_time>= (to_date('01.10.2013 00:00:01','dd.mm.yyyy hh24:mi:ss') + 1/24 - DECODE(1/24,0,0,3/24))
                    and   date_time <=(to_date('02.10.2013 00:00:00','dd.mm.yyyy hh24:mi:ss') + 1/24 + DECODE(1/24,0,0,3/24))
                    AND   util_pg.to_unlocaltime (P.date_time, nsource) >= to_date('01.10.2013 00:00:01','dd.mm.yyyy hh24:mi:ss') + 1/24
                    AND   util_pg.to_unlocaltime (P.date_time, nsource) <= to_date('02.10.2013 00:00:00','dd.mm.yyyy hh24:mi:ss') + 1/24
   and  G.mid=66333  group by rollup( util_pg.get_num_dt (util_pg.to_unlocaltime (P.date_time-1/86400,nsource),nsource, 1/24 ,0,1/24,0) )
     ORDER BY 1 


select pp.dat,sum(decode(pp.dat,25,nvl(dd.AParam,0),dd.AParam)) aparam,SUMQM(dd.decnsour) vqm FROM
 (select decode(grouping(util_pg.get_num_dt (P.date_time-1/86400,nsource, 1/24,1,1/24,0)),1,0, util_pg.get_num_dt (P.date_time-1/86400,nsource, 1/24,1,1/24,0) ) BGroup ,
  sum( -util_pg.sld( P.mid, P.er  *decode(g.NPARTLY,2,0,1) * abs(nvl(g.NKC,1))   , P.ed   *decode(g.NPARTLY,1,0,1) * abs(nvl(g.NKC,1))  ) *DECODE( G.inverted  ,'y',1,-1)   )/1000   AParam ,
      decode(grouping( util_pg.get_num_dt (P.date_time-1/86400,nsource, 1/24,1,1/24,0) ),1 , qm_pg.sumqm(nvl(SUMQM(nvl(p.vqm,qm_pg.defqm)),qm_pg.defqm),qm_pg.nodataqm),nvl(SUMQM(nvl(p.vqm,qm_pg.defqm)),qm_pg.defqm) ) decnsour 
     from    groups    G,  halfhour  P where G.mid=P.mid
     and  date_time>= (:par1 + 1/24 - DECODE(1/24,0,0,3/24))
                    and   date_time <=(:par2 + 1/24 + DECODE(1/24,0,0,3/24))
                    AND   util_pg.to_unlocaltime (P.date_time, nsource) >= :par1 + 1/24
                    AND   util_pg.to_unlocaltime (P.date_time, nsource) <= :par2 + 1/24
     AND G.gid IN (select gr.gid from groups gr connect by prior gr.gid=gr.parent  
                       start with gr.gid=36011) 
     group by rollup( util_pg.get_num_dt (P.date_time-1/86400,nsource, 1/24,1,1/24,0) ))dd,
     (SELECT ROWNUM dat FROM dict WHERE ROWNUM<=25
      union all
      SELECT 0 dat FROM dual)pp
      WHERE pp.dat=dd.BGroup(+)
                GROUP BY pp.dat
                 ORDER BY 1  









 select pp.dat,sum(decode(pp.dat,25,nvl(dd.AParam,0),dd.AParam)) aparam,SUMQM(dd.decnsour) vqm,sum(nvl(dd.AParam,0)) saaaparam FROM
 (select decode(grouping(util_pg.get_num_dt (P.date_time-1/86400,nsource, 1/24,1,0,1)),1,0, util_pg.get_num_dt (P.date_time-1/86400,nsource, 1/24,1,0,1) ) BGroup ,
  sum( -util_pg.sld( P.mid, P.er  *decode(g.NPARTLY,2,0,1) * abs(nvl(g.NKC,1))   , P.ed   *decode(g.NPARTLY,1,0,1) * abs(nvl(g.NKC,1))  ) *DECODE( G.inverted  ,'y',1,-1)   )/1000   AParam ,
      decode(grouping( util_pg.get_num_dt (P.date_time-1/86400,nsource, 1/24,1,0,1) ),1 , qm_pg.sumqm(nvl(SUMQM(nvl(p.vqm,qm_pg.defqm)),qm_pg.defqm),qm_pg.nodataqm),nvl(SUMQM(nvl(p.vqm,qm_pg.defqm)),qm_pg.defqm) ) decnsour 
     from    groups    G,  halfhour  P where G.mid=P.mid
     AND   P.date_time >= to_date('01.10.2013 00:00:01','dd.mm.yyyy hh24:mi:ss') + 0
      AND   P.date_time <= to_date('02.10.2013 00:00:01','dd.mm.yyyy hh24:mi:ss') + 0
     AND G.gid IN (select gr.gid from groups gr connect by prior gr.gid=gr.parent  
                       start with gr.gid=36010) 
     group by rollup( util_pg.get_num_dt (P.date_time-1/86400,nsource, 1/24,1,0,1) ))dd,
     (SELECT ROWNUM dat FROM dict WHERE ROWNUM<=25
      union all
      SELECT 0 dat FROM dual)pp
      WHERE pp.dat=dd.BGroup(+)
                GROUP BY pp.dat
                 ORDER BY 1   


















