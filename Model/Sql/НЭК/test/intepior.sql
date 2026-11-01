select decode(grouping( util_pg.get_num_dt (P.date_time-1/86400,nsource, 1/24 ,0,0,1) ),1,0, util_pg.get_num_dt (P.date_time-1/86400,nsource, 1/24 ,0,0,1) ) BGroup ,
     sum( -util_pg.sld( P.mid, P.er   , P.ed   ) *DECODE(  'n'  ,'y',1,-1)   )/1000  AParam ,
      decode(grouping( util_pg.get_num_dt (P.date_time-1/86400,nsource, 1/24 ,0,0,1) ),1  ,decode(sign(48-count(*)),1,qm_pg.sumqm(nvl(SUMQM(nvl(p.vqm,qm_pg.defqm)),qm_pg.defqm),qm_pg.nodataqm),nvl(SUMQM(nvl(p.vqm,qm_pg.defqm)),qm_pg.defqm))  ,decode(sign(2-count(*)),1,qm_pg.sumqm(nvl(SUMQM(nvl(p.vqm,qm_pg.defqm)),qm_pg.defqm),qm_pg.nodataqm),nvl(SUMQM(nvl(p.vqm,qm_pg.defqm)),qm_pg.defqm)) ) decnsour  from   points   G,  halfhour  P where G.mid=P.mid
    AND   P.date_time >= to_date('01.10.2013 00:00:01','dd.mm.yyyy hh24:mi:ss') + 0
      AND   P.date_time <= to_date('02.10.2013 00:00:00','dd.mm.yyyy hh24:mi:ss') + 0
   and  G.mid=66333  group by rollup( util_pg.get_num_dt (P.date_time-1/86400,nsource, 1/24 ,0,0,1) )
     ORDER BY 1 
