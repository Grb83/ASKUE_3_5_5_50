CREATE USER REMUSR IDENTIFIED  BY REMUSR DEFAULT TABLESPACE USERS TEMPORARY TABLESPACE TEMP PROFILE DEFAULT;
GRANT CREATE SESSION TO REMUSR;
GRANT ALTER SESSION TO REMUSR;
grant execute on comsrvdll_pg to REMUSR;
grant execute on common_pg to REMUSR;


-- Start of DDL Script for Package RYDA.COMSRVDLL_PG
-- Generated 7-ноя-2011 15:34:46 from RYDA@tavr

CREATE OR REPLACE 
PACKAGE comsrvdll_pg IS
------------------------------------------------------------------------------------------------------------------------
   -- Интерфейс взаимодействия БД с Носиком А.В. для DLL plugin'ов счетчиков
   -- дата создания 07/12/2007
------------------------------------------------------------------------------------------------------------------------
 cn_idnoswitch   CONSTANT NUMBER := 1000;
 cn_idpriority   CONSTANT NUMBER := 999;   --Фиктивный Ид для претягивания приоритетов
 cd_transnull    CONSTANT DATE   := TO_DATE ('300101', 'YYYYMM');

------------------------------------------------------------------------------------------------------------------------
 FUNCTION cd_transmin
  RETURN DATE;

 PRAGMA RESTRICT_REFERENCES (cd_transmin, WNDS, WNPS);

------------------------------------------------------------------------------------------------------------------------
 -- Интерфейс поддерживает следующие типы счетчиков (параметр an_type):
 --   0 - эмулятор DLL
 --   1 - эмулятор DLL
 --   2 - CE-304
 --   3 - DB Link Oracle Khartep
 --   4 - DCOM Energy Vision 2
 --   5 - DB Link Oracle INET
 --   6 - Satec
 --   7 - Energy-9
 --   8 - Mercury-200
 --   9 - Energy-9 v.42
 --  10 - Элвин
 --  11 - Alpha A1140
 --  12 - ICCP
 --  13 - Energy-9 v.29
 --  14 - SEB-2A.07
 ------------------------------------------------------------------------------------------------------------------------
 --******************************          DLL METER           *******************************************************--
------------------------------------------------------------------------------------------------------------------------
 PROCEDURE set_curr_power_dllmtr (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_freq NUMBER,
 an_cos_fi NUMBER, an_volt1 NUMBER, an_volt2 NUMBER, an_volt3 NUMBER, an_curr1 NUMBER, an_curr2 NUMBER, an_curr3 NUMBER, an_fiu1i1 NUMBER, an_fiu2i2 NUMBER,
 an_fiu3i3 NUMBER, an_fiu1u2 NUMBER, an_fiu1u3 NUMBER, an_fiu2u3 NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER,
 an_type NUMBER, ad_date DATE
 );

-----------------------------------------------------------------------------------------------------------------------
 PROCEDURE set_halfhour_dllmtr (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, an_erm NUMBER, an_edm NUMBER,
 an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_status NUMBER, an_type NUMBER, an_metertype NUMBER, av_qm VARCHAR2, ad_date DATE
 );

 PROCEDURE set_halfhour_dllmtr (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, an_erm NUMBER, an_edm NUMBER,
 an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_status NUMBER, an_type NUMBER, ad_date DATE
 );

-----------------------------------------------------------------------------------------------------------------------
 PROCEDURE set_bill_dllmtr (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, an_aer NUMBER, an_aed NUMBER,
 an_aq1 NUMBER, an_aq3 NUMBER, an_aq2 NUMBER, an_aq4 NUMBER, an_ber NUMBER, an_bed NUMBER, an_bq1 NUMBER, an_bq3 NUMBER, an_bq2 NUMBER, an_bq4 NUMBER,
 an_cer NUMBER, an_ced NUMBER, an_cq1 NUMBER, an_cq3 NUMBER, an_cq2 NUMBER, an_cq4 NUMBER, an_der NUMBER, an_ded NUMBER, an_dq1 NUMBER, an_dq3 NUMBER,
 an_dq2 NUMBER, an_dq4 NUMBER, av_mtrsn VARCHAR2, an_type NUMBER, ad_date DATE
 );

-----------------------------------------------------------------------------------------------------------------------
 PROCEDURE set_bill_dllmtr_m (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_aerm NUMBER,
 an_aedm NUMBER, an_aq1m NUMBER, an_aq3m NUMBER, an_aq2m NUMBER, an_aq4m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_bq2m NUMBER,
 an_bq4m NUMBER, an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_cq2m NUMBER, an_cq4m NUMBER, an_derm NUMBER, an_dedm NUMBER, an_dq1m NUMBER,
 an_dq3m NUMBER, an_dq2m NUMBER, an_dq4m NUMBER, an_type NUMBER, ad_date DATE
 );

-----------------------------------------------------------------------------------------------------------------------
 PROCEDURE set_months_dllmtr (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, an_aer NUMBER, an_aed NUMBER,
 an_aq1 NUMBER, an_aq3 NUMBER, an_aq2 NUMBER, an_aq4 NUMBER, an_ber NUMBER, an_bed NUMBER, an_bq1 NUMBER, an_bq3 NUMBER, an_bq2 NUMBER, an_bq4 NUMBER,
 an_cer NUMBER, an_ced NUMBER, an_cq1 NUMBER, an_cq3 NUMBER, an_cq2 NUMBER, an_cq4 NUMBER, an_der NUMBER, an_ded NUMBER, an_dq1 NUMBER, an_dq3 NUMBER,
 an_dq2 NUMBER, an_dq4 NUMBER, av_mtrsn VARCHAR2, an_type NUMBER, ad_date DATE
 );

-----------------------------------------------------------------------------------------------------------------------
 PROCEDURE set_months_dllmtr_m (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_aerm NUMBER,
 an_aedm NUMBER, an_aq1m NUMBER, an_aq3m NUMBER, an_aq2m NUMBER, an_aq4m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_bq2m NUMBER,
 an_bq4m NUMBER, an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_cq2m NUMBER, an_cq4m NUMBER, an_derm NUMBER, an_dedm NUMBER, an_dq1m NUMBER,
 an_dq3m NUMBER, an_dq2m NUMBER, an_dq4m NUMBER, an_type NUMBER, ad_date DATE
 );

-----------------------------------------------------------------------------------------------------------------------
    -- Ввод поправок. at_type(i) =1 - Поправка, иначе просто расход с разбивкой на ГН
 PROCEDURE dblink_set_correction (an_mid NUMBER, at_datefrom common_pg.tt_varchar2, at_dateto common_pg.tt_varchar2, at_er common_pg.tt_number,
 at_ed common_pg.tt_number, at_q1 common_pg.tt_number, at_q3 common_pg.tt_number, at_type common_pg.tt_number
 );

-----------------------------------------------------------------------------------------------------------------------
 PROCEDURE mark_dllmtrevent (newmid NUMBER, newev_date DATE, newtype NUMBER, FOUND OUT NUMBER, newstate NUMBER);

-----------------------------------------------------------------------------------------------------------------------
 --Запись журнала
 PROCEDURE set_journal_dllmtr (an_mid NUMBER, an_state_cod NUMBER, av_state_descr VARCHAR2, an_event NUMBER, av_code VARCHAR2, ad_date DATE);

------------------------------------------------------------------------------------------------------------------------
--Запись обводников
 PROCEDURE dblink_set_ov (an_switch NUMBER, at_datefrom common_pg.tt_varchar2, at_dateto common_pg.tt_varchar2, at_mid common_pg.tt_number);

------------------------------------------------------------------------------------------------------------------------
  --Запись остальных показаний
 PROCEDURE dblink_set_othersbill (an_mid NUMBER, ad_cdatetime common_pg.tt_varchar2, an_type common_pg.tt_number, an_er common_pg.tt_number,
 an_ed common_pg.tt_number, an_q1 common_pg.tt_number, an_q3 common_pg.tt_number, an_q2 common_pg.tt_number, an_q4 common_pg.tt_number, an_erm common_pg.tt_number,
 an_edm common_pg.tt_number, an_q1m common_pg.tt_number, an_q3m common_pg.tt_number, an_q2m common_pg.tt_number, an_q4m common_pg.tt_number
 );

------------------------------------------------------------------------------------------------------------------------

 --******************************           DB Link            *******************************************************--
------------------------------------------------------------------------------------------------------------------------

 -- "Открытие доступа" к счетчику (Если возвращает 0 -- счетчик отсутствует в БД)
 FUNCTION dblink_openmtraccs (an_mid NUMBER)   --Ид счетчика в БД
  RETURN NUMBER;

------------------------------------------------------------------------------------------------------------------------
--Запрос серийного номера счетчика
 FUNCTION dblink_get_mtr_serno (an_mid NUMBER,   --Ид счетчика в БД
                                              av_serno OUT VARCHAR2   --Серийный номер
                                                                   )
  RETURN NUMBER;

------------------------------------------------------------------------------------------------------------------------
--Чтение текущих
 PROCEDURE dblink_get_curr_power (an_mid NUMBER,   --Ид счетчика
                                                an_erm OUT NUMBER,   --Показания A+
                                                                  an_edm OUT NUMBER,   --Показания A-
                                                                                    an_q1m OUT NUMBER,   --Показания R+ или Q1
                                                                                                      an_q3m OUT NUMBER,   --Показания R- или Q3
                                                                                                                        an_q2m OUT NUMBER,   --Показания Q2
 an_q4m OUT NUMBER,   --Показания Q4
                   an_freq OUT NUMBER,   --Частота
                                      an_cos_fi OUT NUMBER,   --cosF
                                                           an_volt1 OUT NUMBER,   --Напряжение A
                                                                               an_volt2 OUT NUMBER,   --Напряжение B
                                                                                                   an_volt3 OUT NUMBER,   --Напряжение C
                                                                                                                       an_curr1 OUT NUMBER,   --Ток фаза A
 an_curr2 OUT NUMBER,   --Ток фаза B
                     an_curr3 OUT NUMBER,   --Ток фаза C
                                         an_fiu1i1 OUT NUMBER,   --Абс значение угла тока A
                                                              an_fiu2i2 OUT NUMBER,   --Абс значение угла тока A
                                                                                   an_fiu3i3 OUT NUMBER,   --Абс значение угла тока A
                                                                                                        an_fiu1u2 OUT NUMBER,   --Абс значение угла напряжения A
 an_fiu1u3 OUT NUMBER,   --Абс значение угла напряжения A
                      an_fiu2u3 OUT NUMBER,   --Абс значение угла напряжения A
                                           an_er OUT NUMBER,   --Тек мощность A+
                                                            an_ed OUT NUMBER,   --Тек мощность A+
                                                                             an_q1 OUT NUMBER,   --Тек мощность R+ или Q1
                                                                                              an_q3 OUT NUMBER,   --Тек мощность R- или Q3
                                                                                                               an_q2 OUT NUMBER,   --Тек мощность Q2
                                                                                                                                an_q4 OUT NUMBER,   --Тек мощность Q4
 ad_date OUT VARCHAR2   --Дата фиксации
 );

------------------------------------------------------------------------------------------------------------------------
--Чтение ГН
 PROCEDURE dblink_get_halfhour (an_mid NUMBER,   --Ид счетчика
                                              ad_cdatetime OUT common_pg.tt_varchar2,   --массив дат в формате 'dd.mm.yyyy hh24:mi' (всегда зимнее время)
                                                                                     an_er OUT common_pg.tt_number,   --массив расходов A+ за интеграционный период
 an_ed OUT common_pg.tt_number,   --массив расходов A- за интеграционный период
                               an_q1 OUT common_pg.tt_number,   --массив расходов R+ или Q1 за интеграционный период
                                                             an_q3 OUT common_pg.tt_number,   --массив расходов R- или Q3 за интеграционный период
 an_q2 OUT common_pg.tt_number,   --массив расходов Q2 за интеграционный период
                               an_q4 OUT common_pg.tt_number,   --массив расходов Q4 за интеграционный период
                                                             an_erm OUT common_pg.tt_number,   --массив показаний A+ за интеграционный период
 an_edm OUT common_pg.tt_number,   --массив показаний A- за интеграционный период
                                an_q1m OUT common_pg.tt_number,   --массив показаний R+ или Q1 за интеграционный период
                                                               an_q3m OUT common_pg.tt_number,   --массив показаний R- или Q3 за интеграционный период
 an_q2m OUT common_pg.tt_number,   --массив показаний Q2 за интеграционный период
                                an_q4m OUT common_pg.tt_number,   --массив показаний Q4 за интеграционный период
                                                               an_status OUT common_pg.tt_number,   --массив статусов (статусные байты счетчика)
 ad_date DATE   --Дата больше которой нобходимо выдать данные (всегда зимнее время)
 );

------------------------------------------------------------------------------------------------------------------------
--Чтение ГН
 PROCEDURE dblink_get_halfhour (an_mid NUMBER,   --Ид счетчика
                                              ad_cdatetime OUT common_pg.tt_varchar2,   --массив дат в формате 'dd.mm.yyyy hh24:mi' (всегда зимнее время)
                                                                                     an_er OUT common_pg.tt_number,   --массив расходов A+ за интеграционный период
 an_ed OUT common_pg.tt_number,   --массив расходов A- за интеграционный период
                               an_q1 OUT common_pg.tt_number,   --массив расходов R+ или Q1 за интеграционный период
                                                             an_q3 OUT common_pg.tt_number,   --массив расходов R- или Q3 за интеграционный период
 an_q2 OUT common_pg.tt_number,   --массив расходов Q2 за интеграционный период
                               an_q4 OUT common_pg.tt_number,   --массив расходов Q4 за интеграционный период
                                                             an_erm OUT common_pg.tt_number,   --массив показаний A+ за интеграционный период
 an_edm OUT common_pg.tt_number,   --массив показаний A- за интеграционный период
                                an_q1m OUT common_pg.tt_number,   --массив показаний R+ или Q1 за интеграционный период
                                                               an_q3m OUT common_pg.tt_number,   --массив показаний R- или Q3 за интеграционный период
 an_q2m OUT common_pg.tt_number,   --массив показаний Q2 за интеграционный период
                                an_q4m OUT common_pg.tt_number,   --массив показаний Q4 за интеграционный период
                                                               an_status OUT common_pg.tt_number,   --массив статусов (статусные байты счетчика)
 an_metertype OUT common_pg.tt_number,   --массив типов счетчика
                                      av_qm OUT common_pg.tt_varchar2,   --массив меток качества
                                                                      ad_date DATE   --Дата больше которой нобходимо выдать данные (всегда зимнее время)
 );

------------------------------------------------------------------------------------------------------------------------
--Чтение ГН
 PROCEDURE dblink_get_halfhour (an_mid NUMBER, ad_cdatetime OUT common_pg.tt_varchar2, an_er OUT common_pg.tt_number, an_ed OUT common_pg.tt_number,
 an_q1 OUT common_pg.tt_number, an_q3 OUT common_pg.tt_number, an_q2 OUT common_pg.tt_number, an_q4 OUT common_pg.tt_number, an_erm OUT common_pg.tt_number,
 an_edm OUT common_pg.tt_number, an_q1m OUT common_pg.tt_number, an_q3m OUT common_pg.tt_number, an_q2m OUT common_pg.tt_number, an_q4m OUT common_pg.tt_number,
 an_status OUT common_pg.tt_number, an_metertype OUT common_pg.tt_number, av_qm OUT common_pg.tt_varchar2, ad_date DATE,   --Дата, больше которой нобходимо выдать данные
 ad_change DATE   --Дата ввода, больше которой нобходимо выдать данные (допускает NULL иначе работает как union с ad_date)
 );

------------------------------------------------------------------------------------------------------------------------
  --Чтение суточных данных
 PROCEDURE dblink_get_bill (an_mid NUMBER,   --Ид счетчика
                                          ad_cdatetime OUT common_pg.tt_varchar2,   --массив дат в формате 'dd.mm.yyyy hh24:mi'
                                                                                 an_er OUT common_pg.tt_number,   --массив расходов A+ за интеграционный период (сутки или с момента предидущего съемча)
 an_ed OUT common_pg.tt_number,   --массив расходов A- за интеграционный период (сутки или с момента предидущего съемча)
                               an_q1 OUT common_pg.tt_number,   --массив расходов R+ или Q1 за интеграционный период (сутки или с момента предидущего съемча)
 an_q3 OUT common_pg.tt_number,   --массив расходов R- или Q3 за интеграционный период (сутки или с момента предидущего съемча)
                               an_q2 OUT common_pg.tt_number,   --массив расходов Q2 за интеграционный период (сутки или с момента предидущего съемча)
 an_q4 OUT common_pg.tt_number,   --массив расходов Q4 за интеграционный период (сутки или с момента предидущего съемча)
                               an_aer OUT common_pg.tt_number,   -- ... зона 1 (Пик)
                                                              an_aed OUT common_pg.tt_number, an_aq1 OUT common_pg.tt_number, an_aq3 OUT common_pg.tt_number,
 an_aq2 OUT common_pg.tt_number, an_aq4 OUT common_pg.tt_number, an_ber OUT common_pg.tt_number,   -- ... зона 2 (День)
                                                                                                an_bed OUT common_pg.tt_number, an_bq1 OUT common_pg.tt_number,
 an_bq3 OUT common_pg.tt_number, an_bq2 OUT common_pg.tt_number, an_bq4 OUT common_pg.tt_number, an_cer OUT common_pg.tt_number,   -- ... зона 3 (Ночь)
 an_ced OUT common_pg.tt_number, an_cq1 OUT common_pg.tt_number, an_cq3 OUT common_pg.tt_number, an_cq2 OUT common_pg.tt_number, an_cq4 OUT common_pg.tt_number,
 an_der OUT common_pg.tt_number,   -- ... зона 4 (Резерв)
                                an_ded OUT common_pg.tt_number, an_dq1 OUT common_pg.tt_number, an_dq3 OUT common_pg.tt_number, an_dq2 OUT common_pg.tt_number,
 an_dq4 OUT common_pg.tt_number, an_erm OUT common_pg.tt_number,   --массив показаний A+
                                                                an_edm OUT common_pg.tt_number, an_q1m OUT common_pg.tt_number, an_q3m OUT common_pg.tt_number,
 an_q2m OUT common_pg.tt_number, an_q4m OUT common_pg.tt_number, an_aerm OUT common_pg.tt_number, an_aedm OUT common_pg.tt_number, an_aq1m OUT common_pg.tt_number,
 an_aq3m OUT common_pg.tt_number, an_aq2m OUT common_pg.tt_number, an_aq4m OUT common_pg.tt_number, an_berm OUT common_pg.tt_number,
 an_bedm OUT common_pg.tt_number, an_bq1m OUT common_pg.tt_number, an_bq3m OUT common_pg.tt_number, an_bq2m OUT common_pg.tt_number,
 an_bq4m OUT common_pg.tt_number, an_cerm OUT common_pg.tt_number, an_cedm OUT common_pg.tt_number, an_cq1m OUT common_pg.tt_number,
 an_cq3m OUT common_pg.tt_number, an_cq2m OUT common_pg.tt_number, an_cq4m OUT common_pg.tt_number, an_derm OUT common_pg.tt_number,
 an_dedm OUT common_pg.tt_number, an_dq1m OUT common_pg.tt_number, an_dq3m OUT common_pg.tt_number, an_dq2m OUT common_pg.tt_number,
 an_dq4m OUT common_pg.tt_number, ad_date DATE   --Дата больше которой нобходимо выдать данные
 );

------------------------------------------------------------------------------------------------------------------------
  --Чтение месячных данных (описание параметров по анологии с dblink_get_bill)
 PROCEDURE dblink_get_month (an_mid NUMBER, ad_cdatetime OUT common_pg.tt_varchar2, an_er OUT common_pg.tt_number, an_ed OUT common_pg.tt_number,
 an_q1 OUT common_pg.tt_number, an_q3 OUT common_pg.tt_number, an_q2 OUT common_pg.tt_number, an_q4 OUT common_pg.tt_number, an_aer OUT common_pg.tt_number,
 an_aed OUT common_pg.tt_number, an_aq1 OUT common_pg.tt_number, an_aq3 OUT common_pg.tt_number, an_aq2 OUT common_pg.tt_number, an_aq4 OUT common_pg.tt_number,
 an_ber OUT common_pg.tt_number, an_bed OUT common_pg.tt_number, an_bq1 OUT common_pg.tt_number, an_bq3 OUT common_pg.tt_number, an_bq2 OUT common_pg.tt_number,
 an_bq4 OUT common_pg.tt_number, an_cer OUT common_pg.tt_number, an_ced OUT common_pg.tt_number, an_cq1 OUT common_pg.tt_number, an_cq3 OUT common_pg.tt_number,
 an_cq2 OUT common_pg.tt_number, an_cq4 OUT common_pg.tt_number, an_der OUT common_pg.tt_number, an_ded OUT common_pg.tt_number, an_dq1 OUT common_pg.tt_number,
 an_dq3 OUT common_pg.tt_number, an_dq2 OUT common_pg.tt_number, an_dq4 OUT common_pg.tt_number, an_erm OUT common_pg.tt_number, an_edm OUT common_pg.tt_number,
 an_q1m OUT common_pg.tt_number, an_q3m OUT common_pg.tt_number, an_q2m OUT common_pg.tt_number, an_q4m OUT common_pg.tt_number, an_aerm OUT common_pg.tt_number,
 an_aedm OUT common_pg.tt_number, an_aq1m OUT common_pg.tt_number, an_aq3m OUT common_pg.tt_number, an_aq2m OUT common_pg.tt_number,
 an_aq4m OUT common_pg.tt_number, an_berm OUT common_pg.tt_number, an_bedm OUT common_pg.tt_number, an_bq1m OUT common_pg.tt_number,
 an_bq3m OUT common_pg.tt_number, an_bq2m OUT common_pg.tt_number, an_bq4m OUT common_pg.tt_number, an_cerm OUT common_pg.tt_number,
 an_cedm OUT common_pg.tt_number, an_cq1m OUT common_pg.tt_number, an_cq3m OUT common_pg.tt_number, an_cq2m OUT common_pg.tt_number,
 an_cq4m OUT common_pg.tt_number, an_derm OUT common_pg.tt_number, an_dedm OUT common_pg.tt_number, an_dq1m OUT common_pg.tt_number,
 an_dq3m OUT common_pg.tt_number, an_dq2m OUT common_pg.tt_number, an_dq4m OUT common_pg.tt_number, ad_date DATE
 );

-----------------------------------------------------------------------------------------------------------------------
 --Чтение журнала
 PROCEDURE dblink_get_journal (an_mid NUMBER,   --Ид счетчика в БД
                                             at_datetime OUT common_pg.tt_varchar2,   --массив дат в формате 'dd.mm.yyyy hh24:mi:ss'
 at_state_cod OUT common_pg.tt_number,   --массив кодов событий
                                      at_state_descr OUT common_pg.tt_varchar2,   --Массив описания событий
                                                                               at_event OUT common_pg.tt_number,   --Массив Ид событий (Использовать только для БД Хартхэп)
 at_code OUT common_pg.tt_varchar2,   --массив оригинальных кодов (коды счетчиков)
                                   ad_date DATE   --Дата больше которой нобходимо выдать данные
 );

------------------------------------------------------------------------------------------------------------------------
 --Чтение обводников
 PROCEDURE dblink_get_ov (an_switch NUMBER, at_datefrom OUT common_pg.tt_varchar2, at_dateto OUT common_pg.tt_varchar2, at_mid OUT common_pg.tt_number);

------------------------------------------------------------------------------------------------------------------------
  --Чтение остальных показаний
  --an_type 0 -нет данных; 1-ОВ - начало; 2-ОВ - конец; 3-замена сч снятие; 4-замена сч установка
 PROCEDURE dblink_get_othersbill (an_mid NUMBER, ad_cdatetime OUT common_pg.tt_varchar2, an_type OUT common_pg.tt_number, an_er OUT common_pg.tt_number,
 an_ed OUT common_pg.tt_number, an_q1 OUT common_pg.tt_number, an_q3 OUT common_pg.tt_number, an_q2 OUT common_pg.tt_number, an_q4 OUT common_pg.tt_number,
 an_erm OUT common_pg.tt_number, an_edm OUT common_pg.tt_number, an_q1m OUT common_pg.tt_number, an_q3m OUT common_pg.tt_number, an_q2m OUT common_pg.tt_number,
 an_q4m OUT common_pg.tt_number
 );
------------------------------------------------------------------------------------------------------------------------
END;   -- Package Specification COMSRVDLL_PG
/


-- End of DDL Script for Package RYDA.COMSRVDLL_PG

