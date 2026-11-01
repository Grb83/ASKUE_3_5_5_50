-- Start of DDL Script for Package Body RYDA.EDITGROUPSPARAM_PG
-- Generated 14-апр-2008 15:02:45 from RYDA@askue

CREATE OR REPLACE 
PACKAGE editgroupsparam_pg IS
   -- Процедура вставки АСРПП
 PROCEDURE ins_p_a(
  an_gid               NUMBER, -- Ид группы
  an_fromperiod        NUMBER, --Период с
  an_tillperiod        NUMBER, --Период по
  an_class             NUMBER -- Класс напряжения
                                 );
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура обновления данных АСРПП
 PROCEDURE upd_p_a(
  an_gid               NUMBER, -- Ид группы
  an_fromperiod        NUMBER, --Период с
  an_tillperiod        NUMBER, --Период по
  an_class             NUMBER -- Класс напряжения
                             );
END;
/

-- Grants for Package
GRANT EXECUTE ON editgroupsparam_pg TO askue_work
/

CREATE OR REPLACE 
PACKAGE BODY editgroupsparam_pg IS
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура обновления данных (общая)
 PROCEDURE upd_p_a(
  an_gid               NUMBER, -- Ид группы
  an_fromperiod        NUMBER, --Период с
  an_tillperiod        NUMBER, --Период по
  an_class             NUMBER -- Класс напряжения
                             ) IS
 BEGIN
   UPDATE groupsparam
      SET nclass = an_class
    WHERE gid = an_gid;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'editgroupsparam_pg.upd_p_a: Ошибка обновления доп.информации по группе ' || CHR(10) || SQLERRM(SQLCODE));
 END;

 PROCEDURE ins_p_a(
  an_gid               NUMBER, -- Ид группы
  an_fromperiod        NUMBER, --Период с
  an_tillperiod        NUMBER, --Период по
  an_class             NUMBER -- Класс напряжения
                             ) IS
 BEGIN
   INSERT INTO groupsparam VALUES (an_gid, an_fromperiod, an_tillperiod, an_class);
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'editgroupsparam_pg.ins_p_a: Ошибка вставки доп.информации по группе ' || CHR(10) || SQLERRM(SQLCODE));
 END;
 
END;  -- Package body
/


-- End of DDL Script for Package Body RYDA.EDITGROUPSPARAM_PG
