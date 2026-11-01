-- Start of DDL Script for Package RYDA.BACKGROUNDGOK_PG
-- Generated 04.02.2011 10:22:00 from RYDA@OE

CREATE OR REPLACE 
PACKAGE backgroundgok_pg
  IS
 ------------------------------------------------------------------------------------------------------------------------
   -- пакет по созданию отчетов в файл
   -- дата создания 11/02/2003 Сечин А.А.
------------------------------------------------------------------------------------------------------------------------
 PROCEDURE copydata (an_maket NUMBER, ad_date DATE);

END; -- Package spec
/

-- Start of DDL Script for Package Body RYDA.BACKGROUNDGOK_PG
-- Generated 04.02.2011 10:22:50 from RYDA@OE

CREATE OR REPLACE 
PACKAGE BODY backgroundgok_pg
IS
 ------------------------------------------------------------------------------------------------------------------------
   -- пакет по созданию отчетов в файл
   -- дата создания 11/02/2003 Сечин А.А.
------------------------------------------------------------------------------------------------------------------------
 PROCEDURE copydata (an_maket NUMBER, ad_date DATE) IS
  ln_gid   NUMBER;
  ld_from  DATE := trunc(ad_date)-1;
  ld_till  DATE := trunc(ad_date,'hh24');
  ln_tmpmid NUMBER;
 BEGIN
   SELECT util_pg.get_param(vparam,1)
     INTO ln_gid
     FROM makets WHERE nmaket = an_maket;

   IF ln_gid IS NULL THEN
     raise_application_error(-20001,'Не задана группа для копирования точек');
   END IF;

   FOR lc IN (SELECT mid from_mid, util_pg.get_param(vparam,1) to_mid
                FROM GROUPS@askuetmp.REGRESS.RDBMS.DEV.US.ORACLE.COM
               WHERE parent = ln_gid AND mid IS NOT NULL) LOOP
     SELECT max(mid) INTO ln_tmpmid FROM points WHERE mid = lc.to_mid;
     IF ln_tmpmid IS NULL THEN
       raise_application_error(-20001,'В старой базе не найдена точка '||lc.to_mid);
     END IF;

     DELETE FROM halfhourold
      WHERE mid = lc.to_mid AND date_time > ld_from AND date_time <= ld_till;
     INSERT INTO halfhour (mid,date_time, er,ed,q1,q3)
       SELECT lc.to_mid, date_time, er,ed,q1,q3
         FROM halfhour@askuetmp.REGRESS.RDBMS.DEV.US.ORACLE.COM
        WHERE mid = lc.from_mid AND date_time > ld_from AND date_time <= ld_till;
     COMMIT;
     /*
     for lc1 in (select date_time, er,ed,q1,q3 from halfhour@askuetmp.REGRESS.RDBMS.DEV.US.ORACLE.COM 
                 where mid = lc.from_mid AND date_time > ld_from AND date_time <= ld_till ) loop
        update halfhour 
           set er=lc1.er, ed=lc1.ed, q1=lc1.q1, q3=lc1.q3
         where mid=lc.to_mid and date_time=lc1.date_time;
               --and (er<>lc1.er or ed<>lc1.ed or q1<>lc1.q1 or q3<>lc1.q3);
        if sql%rowcount = 0 then
          insert into halfhour (mid,date_time,er,ed,q1,q3)
          values (lc.to_mid,lc1.date_time,lc.er,lc.ed,lc.q1,lc.q3);
        end if;  
     end loop; 
     */

     DELETE FROM billorg
      WHERE mid = lc.to_mid AND date_time = trunc(ld_till);
     INSERT INTO billorg (mid,date_time, er,ed,q1,q3, erm,edm,q1m,q3m)
       SELECT lc.to_mid, date_time, er,ed,q1,q3,erm,edm,q1m,q3m
         FROM billorg@askuetmp.REGRESS.RDBMS.DEV.US.ORACLE.COM
        WHERE mid = lc.from_mid AND date_time = trunc(ld_till);
     COMMIT;
   END LOOP;

 EXCEPTION
  WHEN OTHERS THEN
   ROLLBACK;
   raise_application_error (-20001, 'BACKGROUNDGOK_PG.copydata: ' || SQLERRM (SQLCODE));
 END;
------------------------------------------------------------------------------------------------------------------------
END;                                          -- Package Body BACKGROUNDGOK_PG
------------------------------------------------------------------------------------------------------------------------
/



-- End of DDL Script for Package Body RYDA.BACKGROUNDGOK_PG



