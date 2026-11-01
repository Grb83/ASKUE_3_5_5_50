select t.dat,sum(util_pg.sld(t.mid,t.er,t.ed)) e,
sum(util_pg.sld(t.mid,t.aer,t.aed)) ae,
sum(util_pg.sld(t.mid,t.ber,t.bed)) be,
sum(util_pg.sld(t.mid,t.cer,t.ced)) ce, 
sum(util_pg.sld(t.mid,t.aer,t.aed)) +nvl(sum(util_pg.sld(t.mid,t.ber,t.bed)),0) +sum(util_pg.sld(t.mid,t.cer,t.ced)) se 
from
(select h.mid,trunc(h.date_time-1/86400) dat,
sum(h.er*decode(g.NPARTLY,2,0,1)*DECODE(G.inverted,'y',1,-1)) er,sum(h.ed*decode(g.NPARTLY,2,0,1)*DECODE(G.inverted,'y',1,-1)) ed ,
sum(DECODE(r.rate,0,h.er*decode(g.NPARTLY,2,0,1)*DECODE(G.inverted,'y',1,-1))) aer,sum(DECODE(r.rate,0,h.ed*decode(g.NPARTLY,2,0,1)*DECODE(G.inverted,'y',1,-1))) aed, 
sum(DECODE(r.rate,1,h.er*decode(g.NPARTLY,2,0,1)*DECODE(G.inverted,'y',1,-1))) ber,sum(DECODE(r.rate,1,h.ed*decode(g.NPARTLY,2,0,1)*DECODE(G.inverted,'y',1,-1))) bed, 
sum(DECODE(r.rate,2,h.er*decode(g.NPARTLY,2,0,1)*DECODE(G.inverted,'y',1,-1))) cer,sum(DECODE(r.rate,2,h.ed*decode(g.NPARTLY,2,0,1)*DECODE(G.inverted,'y',1,-1))) ced 
from halfhour h,groups g,rates r
where h.mid=g.mid and g.gid in (select gid from groups connect by prior gid=parent start with gid=37659) 
and h.date_time>to_date('01.10.2008','dd.mm.yyyy') and h.date_time<=to_date('01.11.2008','dd.mm.yyyy')
and r.rid=(select rid from rate_list where nschedulelist=1 and SWITCH_DATE=(select max(SWITCH_DATE) from rate_list where SWITCH_DATE<=trunc(h.date_time-1/86400) and nschedulelist=1))
AND TO_CHAR (h.date_time - 1 / 1440, 'sssss') >= TO_CHAR (r.TIME, 'sssss') AND TO_CHAR (h.date_time - 1 / 1440, 'sssss') < TO_CHAR (r.endtime, 'sssss')
group by h.mid,trunc(h.date_time-1/86400)) t
group by rollup(t.dat)
order by 1



select t.dat,sum(util_pg.sld(t.mid,t.er,t.ed)) e,
sum(util_pg.sld(t.mid,t.aer,t.aed)) ae,
sum(util_pg.sld(t.mid,t.ber,t.bed)) be,
sum(util_pg.sld(t.mid,t.cer,t.ced)) ce, 
sum(util_pg.sld(t.mid,t.aer,t.aed)) +nvl(sum(util_pg.sld(t.mid,t.ber,t.bed)),0) +sum(util_pg.sld(t.mid,t.cer,t.ced)) se 
from
(select h.mid,trunc(h.date_time-1/86400) dat,
sum(h.er*decode(g.NPARTLY,2,0,1)*DECODE(G.inverted,'y',1,-1)) er,sum(h.ed*decode(g.NPARTLY,2,0,1)*DECODE(G.inverted,'y',1,-1)) ed ,
sum(DECODE(r.rate,0,h.er*decode(g.NPARTLY,2,0,1)*DECODE(G.inverted,'y',1,-1))) aer,sum(DECODE(r.rate,0,h.ed*decode(g.NPARTLY,2,0,1)*DECODE(G.inverted,'y',1,-1))) aed, 
sum(DECODE(r.rate,1,h.er*decode(g.NPARTLY,2,0,1)*DECODE(G.inverted,'y',1,-1))) ber,sum(DECODE(r.rate,1,h.ed*decode(g.NPARTLY,2,0,1)*DECODE(G.inverted,'y',1,-1))) bed, 
sum(DECODE(r.rate,2,h.er*decode(g.NPARTLY,2,0,1)*DECODE(G.inverted,'y',1,-1))) cer,sum(DECODE(r.rate,2,h.ed*decode(g.NPARTLY,2,0,1)*DECODE(G.inverted,'y',1,-1))) ced 
from halfhour h,groups g,rates r
where h.mid=g.mid and g.gid in (select gid from groups connect by prior gid=parent start with gid=37779) 
and h.date_time>to_date('01.10.2008','dd.mm.yyyy') and h.date_time<=to_date('01.11.2008','dd.mm.yyyy')
and r.rid=(select rid from rate_list where nschedulelist=1 and SWITCH_DATE=(select max(SWITCH_DATE) from rate_list where SWITCH_DATE<=trunc(h.date_time-1/86400) and nschedulelist=1))
AND TO_CHAR (h.date_time - 1 / 1440, 'sssss') >= TO_CHAR (r.TIME, 'sssss') AND TO_CHAR (h.date_time - 1 / 1440, 'sssss') < TO_CHAR (r.endtime, 'sssss')
group by h.mid,trunc(h.date_time-1/86400)) t
group by rollup(t.dat)
order by 1

--select * from rate_list r order by 2
--select * from rates where rid=1025
