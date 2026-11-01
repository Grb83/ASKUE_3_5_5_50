
-- Start of DDL script for ADMIN_PG
-- Generated 27-янв-03  11:33:14 am
-- from oe-RYDA:1

-- Package ADMIN_PG

CREATE OR REPLACE
PACKAGE admin_pg
IS
  -- пакет по администрированию АСКУЭ
  -- дата создания 12/10/2001 Сечин А.А.
------------------------------------------------------------------------------------------------------------------------
  -- Процедура установки параметров сессии
 PROCEDURE begin_p;

------------------------------------------------------------------------------------------------------------------------
--процедура смены периода
 PROCEDURE changeperiod_p;

------------------------------------------------------------------------------------------------------------------------
--процедура смены дня расчета
 PROCEDURE changecalcday_p(
  an_day NUMBER);

------------------------------------------------------------------------------------------------------------------------
  -- Проверка проведения расчета возвращает 1- Проведен, иначе нет
 FUNCTION provcalc_f
  RETURN NUMBER;
 PRAGMA restrict_references(provcalc_f, WNDS, WNPS);

------------------------------------------------------------------------------------------------------------------------
--Запись в журнал
 PROCEDURE fiscal_p(
  an_task    NUMBER,
  an_job     NUMBER,
  av_name    VARCHAR2,
  av_message VARCHAR2);

------------------------------------------------------------------------------------------------------------------------
-- Управление процессами Запуск Останов Состояние
 FUNCTION AscueProc_Start_Stop_State_f(
  an_IDProcess NUMBER,
  an_TypeOperation NUMBER)
  RETURN NUMBER;

------------------------------------------------------------------------------------------------------------------------
-- Управление процессами Параметры архивации
 PROCEDURE AscueArchParam_p(
  av_ProfileFlag  IN OUT  VARCHAR2,
  av_ProfileDir  IN OUT  VARCHAR2,
  av_HalfhourFlag  IN OUT  VARCHAR2,
  av_HalfhourDir  IN OUT  VARCHAR2,
  av_BillFlag  IN OUT  VARCHAR2,
  av_BillDir  IN OUT  VARCHAR2,
  an_Flag_in_out NUMBER -- 0-Возвращает значения 1-Записывает
 );
------------------------------------------------------------------------------------------------------------------------
--Запись текущих данных в архив
 PROCEDURE curr_power_arch_ins_p(
an_MID      NUMBER,
ad_DATE_TIME      DATE,
an_ER      NUMBER,
an_Q1      NUMBER,
an_ED      NUMBER,
an_Q3      NUMBER,
an_FREQ      NUMBER,
an_COSF      NUMBER,
an_VOLT      NUMBER,
an_CURRENTO      NUMBER,
an_VOLT2      NUMBER,
an_VOLT3      NUMBER,
an_CURR2      NUMBER,
an_CURR3      NUMBER);
------------------------------------------------------------------------------------------------------------------------
--Запись события по компорту в log
 PROCEDURE set_comport_event_p(
an_com      NUMBER,
av_event    VARCHAR2);
------------------------------------------------------------------------------------------------------------------------
END; -- Package Specification ADMIN_PG
/

-- End of DDL script for ADMIN_PG

-- Start of DDL script for ALPHA_IMP_PG
-- Generated 27-янв-03  11:33:14 am
-- from oe-RYDA:1

-- Package ALPHA_IMP_PG

CREATE OR REPLACE
PACKAGE ALPHA_IMP_PG IS
 ------------------------------------------------------------------------------------------------------------------------
    -- Интерфейс взаимодействия БД с ПО AlphaImport
    -- дата создания 10/01/2003 Чудаков И.В.
 ------------------------------------------------------------------------------------------------------------------------

 ------------------------------------------------------------------------------------------------------------------------
 --******************************          Alpha                *******************************************************--
 ------------------------------------------------------------------------------------------------------------------------
  --Вставка графика нагрузки. Изначально была скопирована как соответствующая в пакете comserv_pg
 PROCEDURE set_halfhour_Alpha_AImp
 (
   an_mid NUMBER,
   ad_date DATE,
   an_er NUMBER,
   an_ed NUMBER,
   an_q1 NUMBER,
   an_q3 NUMBER,
   av_res OUT varchar2
 );
 -----------------------------------------------------------------------------------------------------------------------
   --Вставка суточных. Изначально была скопирована как соответствующая в пакете comserv_pg
 PROCEDURE set_bill_Alpha_AImp(
  an_mid    NUMBER,
  ad_date   DATE,
  an_erm    NUMBER,
  an_edm    NUMBER,
  an_q1m    NUMBER,
  an_q3m    NUMBER,
  an_aerm   NUMBER,
  an_aedm   NUMBER,
  an_aq1m   NUMBER,
  an_aq3m   NUMBER,
  an_berm   NUMBER,
  an_bedm   NUMBER,
  an_bq1m   NUMBER,
  an_bq3m   NUMBER,
  an_cerm   NUMBER,
  an_cedm   NUMBER,
  an_cq1m   NUMBER,
  an_cq3m   NUMBER,
  an_derm   NUMBER,
  an_dedm   NUMBER,
  an_dq1m   NUMBER,
  an_dq3m   NUMBER,
--  av_mtrsn  VARCHAR2,
  av_res OUT VARCHAR2
  );
------------------------------------------------------------------------------------------------------------------------
END; -- Package Specification ALPHA_IMP_PG
/

-- End of DDL script for ALPHA_IMP_PG

-- Start of DDL script for AVERRATE_PG
-- Generated 27-янв-03  11:33:14 am
-- from oe-RYDA:1

-- Package AVERRATE_PG

CREATE OR REPLACE
PACKAGE averrate_pg IS
   -- пакет вычисления весовых коэффициентов для получасовок в пределах суток
   -- дата создания 03/12/2002 (Чудаков И.В.)
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура вычисления весовых коэффициентов для получасовок в пределах суток
 PROCEDURE averrate(ad_start DATE);
 ------------------------------------------------------------------------------------------------------------------------
    -- Функция вычисления весовых коэффициентов для получасовок в любой период
 FUNCTION averrate_f(an_mid NUMBER, an_type NUMBER, ad_start DATE, ad_end DATE)
  RETURN common_pg.tt_number;
------------------------------------------------------------------------------------------------------------------------
END; -- Package spec
/

-- End of DDL script for AVERRATE_PG

-- Start of DDL script for CALCPTS_PG
-- Generated 27-янв-03  11:33:14 am
-- from oe-RYDA:1

-- Package CALCPTS_PG

CREATE OR REPLACE
PACKAGE calcpts_pg
IS
----------------------------------------------------------------------------------------------------------------------
  --возвращает запрос для проверки формулы
 FUNCTION checkformula(
  an_calcmid IN NUMBER                                                                             --ид.расчетной точки
                      ) RETURN VARCHAR2;
-----------------------------------------------------------------------------------------------------------------------
 --процедура расчета расчетной точки
 PROCEDURE calcpts(
  an_calcmid   IN NUMBER,                                                                         --ид. расчетной точки
  ad_date_time IN DATE,                                                                            --дата/время расчета
  an_timetype  IN NUMBER                                                                --1-трехмин, 2-получас, 3-сутки
                        );
-----------------------------------------------------------------------------------------------------------------------
 --запуск расчета по всем расчетным точкам
 PROCEDURE StartCalc (
  ad_date_time IN DATE,                                                                            --дата/время расчета
  an_timetype  IN NUMBER                                                                --1-трехмин, 2-получас, 3-сутки
                        );
-----------------------------------------------------------------------------------------------------------------------
END;                                                                                 -- Package Specification calcpts_pg
/

-- End of DDL script for CALCPTS_PG

-- Start of DDL script for CALC_PG
-- Generated 27-янв-03  11:33:14 am
-- from oe-RYDA:1

-- Package CALC_PG

CREATE OR REPLACE
Package      CALC_PG
  IS

-- Основная процедура расчета, вызывающая остальные процедуры
PROCEDURE Calc_main_p;

------------------------------------------------------------------------------
----------- Процедура формирования первой ведомости --------------------------
------------------------------------------------------------------------------
PROCEDURE Calc_report_p (an_group    IN NUMBER,
                         an_period   IN NUMBER);
------------------------------------------------------------------------------
---- Процедура второго отчета-------------------------------------------------
------------------------------------------------------------------------------
PROCEDURE Report_Debt_p (an_group    IN NUMBER,
                         an_period   IN NUMBER);


END; -- Package Specification CALC_PG
/

-- End of DDL script for CALC_PG

-- Start of DDL script for CHANNELS_PG
-- Generated 27-янв-03  11:33:14 am
-- from oe-RYDA:1

-- Package CHANNELS_PG

CREATE OR REPLACE
PACKAGE channels_pg IS
   -- пакет работы с каналами
   -- дата создания 15/07/2002 (Сечин А.А.)
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура вставки
 PROCEDURE ins_p(
  av_name              VARCHAR2, --Название
  av_note              VARCHAR2, --Примечание
  an_protocol_id       NUMBER, --Ид протокола
  an_com_id            NUMBER, --Ид компорта
  av_init_str          VARCHAR2, --Строка инициализации
  av_addr              VARCHAR2, --Коммуникационый адресс
  an_cycle_tout        NUMBER, --Пауза между циклами
  an_retries           NUMBER, --Кол попыток соединения
  an_retries_tout      NUMBER, --Пауза между попытками
  an_blocking          NUMBER, --Блокировка
  av_caller_name       VARCHAR2, --Название опросчика
  an_billdata          NUMBER, --Коммерческие
  an_billdatadepth     NUMBER, --Коммерческие глубина
  an_currdata          NUMBER, --Текущие
  an_currdatadepth     NUMBER, --Текущие глубина
  an_netparam          NUMBER, --Параметры сети
  an_journal           NUMBER, --Журнал событий
  ad_start             DATE, --Начало опроса
  ad_end               DATE, --Окончание
  an_day               NUMBER, --День
  an_parent            NUMBER, --Главный канал
  an_nnotreadcurr      NUMBER, --Не читать текущие сутки
  an_mid           OUT NUMBER --Ид канала
                             );
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура обновления данных
 PROCEDURE upd_p(
  an_mid           NUMBER, --Ид канала
  av_name          VARCHAR2, --Название
  av_note          VARCHAR2, --Примечание
  an_protocol_id   NUMBER, --Ид протокола
  an_com_id        NUMBER, --Ид компорта
  av_init_str      VARCHAR2, --Строка инициализации
  av_addr          VARCHAR2, --Коммуникационый адресс
  an_cycle_tout    NUMBER, --Пауза между циклами
  an_retries       NUMBER, --Кол попыток соединения
  an_retries_tout  NUMBER, --Пауза между попытками
  an_blocking      NUMBER, --Блокировка
  av_caller_name   VARCHAR2, --Название опросчика
  an_billdata      NUMBER, --Коммерческие
  an_billdatadepth NUMBER, --Коммерческие глубина
  an_currdata      NUMBER, --Текущие
  an_currdatadepth NUMBER, --Текущие глубина
  an_netparam      NUMBER, --Параметры сети
  an_journal       NUMBER, --Журнал событий
  ad_start         DATE, --Начало опроса
  ad_end           DATE, --Окончание
  an_day           NUMBER, --День
  an_parent        NUMBER, --Главный канал
  an_nnotreadcurr      NUMBER --Не читать текущие сутки
                         );
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура удаления данных
 PROCEDURE del_p(an_mid NUMBER --Ид точки
                              );
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура привязки точек
 PROCEDURE setpoint_p(an_cid NUMBER, --Ид канала
                                    at_mid COMMON_PG.tt_number --Мас ид точек
                                                    );
------------------------------------------------------------------------------------------------------------------------
  -- Процедура определения временного канала для опроса отдельной точки учета
  -- И. Вештак, 20.11.02
  Procedure tempChannels(
  cid_       number,    -- id канала
  mid_       number,    -- id точки
  retries_    number,    -- кол-во попыток
  retries_tout_ number,    -- пауза м/у попытками
  vuser_      varchar2); -- user
------------------------------------------------------------------------------------------------------------------------

END; -- Package Specification editcanals_pg
/

-- End of DDL script for CHANNELS_PG

-- Start of DDL script for CHECK_PG
-- Generated 27-янв-03  11:33:14 am
-- from oe-RYDA:1

-- Package CHECK_PG

CREATE OR REPLACE
Package      CHECK_PG
  IS
--
-- Purpose: Процедуры верификации
--
-- MODIFICATION HISTORY
-- Person      Date    Comments
-- ---------   ------  ------------------------------------------
-- Вештак      09.01.03 Создан

  PROCEDURE by_duplicate
     (an_maket IN number, ddate_ IN date);

  PROCEDURE by_itekcoeff
     (an_maket IN number, ddate_ IN date);

  PROCEDURE by_mtrsn
     (an_maket IN number, ddate_ IN date);

  PROCEDURE by_day_expense
     (an_maket IN number, ddate_ IN date);

  PROCEDURE by_month_expense
     (an_maket IN number, ddate1_ IN date);

  PROCEDURE by_balance
     (an_maket IN number, ddate_ IN date);

  PROCEDURE by_OV
     (an_maket IN number, ddate_ IN date);


END; -- Package Specification CHECK_PG
/

-- End of DDL script for CHECK_PG

-- Start of DDL script for COMMON_PG
-- Generated 27-янв-03  11:33:14 am
-- from oe-RYDA:1

-- Package COMMON_PG

CREATE OR REPLACE
PACKAGE common_pg IS
 ------------------------------------------------------------------------------------------------------------------------
   -- пакет для всех АСКУЭ
   -- дата создания 10/12/2002 Сечин А.А.
  ------------------------------------------------------------------------------------------------------------------------
 TYPE tt_number IS TABLE OF NUMBER
  INDEX BY BINARY_INTEGER;
 TYPE tt_varchar2 IS TABLE OF VARCHAR2(4000)
  INDEX BY BINARY_INTEGER;
 TYPE tt_date IS TABLE OF DATE
  INDEX BY BINARY_INTEGER;
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура установки параметров сессии
 PROCEDURE begin_p;
------------------------------------------------------------------------------------------------------------------------
 FUNCTION geterrtext(an_err IN NUMBER)
  RETURN VARCHAR2;
------------------------------------------------------------------------------------------------------------------------
END; -- Package Specification COMMON_PG
/

-- End of DDL script for COMMON_PG

-- Start of DDL script for COMSRV_PG
-- Generated 27-янв-03  11:33:14 am
-- from oe-RYDA:1

-- Package COMSRV_PG

CREATE OR REPLACE
PACKAGE COMSRV_PG IS
 ------------------------------------------------------------------------------------------------------------------------
    -- Интерфейс взаимодействия БД с Носиком А.В.
    -- дата создания 30/11/2001 Сечин А.А.
 ------------------------------------------------------------------------------------------------------------------------
 cn_itek   CONSTANT NUMBER := 20;
 cn_lg     CONSTANT NUMBER := 10;
 cn_a1r    CONSTANT NUMBER := 10;
 cn_alpha  CONSTANT NUMBER := 10;
 cn_metkom CONSTANT NUMBER := 10;
 cn_oblik  CONSTANT NUMBER := 104;
 cn_energy CONSTANT NUMBER := 105;
 ------------------------------------------------------------------------------------------------------------------------
 --******************************          Itek 210             *******************************************************--
 ------------------------------------------------------------------------------------------------------------------------
 --Вставка коэффициентов
 PROCEDURE set_coeffic_itek(an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER);
 ------------------------------------------------------------------------------------------------------------------------
 --Вставка 3-х минуток
 PROCEDURE set_profile_itek(an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, ad_date DATE);
 ------------------------------------------------------------------------------------------------------------------------
  --Вставка графика нагрузки
 PROCEDURE set_halfhour_itek(an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, ad_date DATE);
 ------------------------------------------------------------------------------------------------------------------------
  --Вставка суточных
 PROCEDURE set_bill_itek(
  an_mid  NUMBER,
  an_er   NUMBER,
  an_ed   NUMBER,
  an_q1   NUMBER,
  an_q3   NUMBER,
  an_zone NUMBER, --1-A, 2-B, 3-C,4-D. иначе общий
  ad_date DATE);
 ------------------------------------------------------------------------------------------------------------------------
  --Вставка месячных
 PROCEDURE set_months_itek(
  an_mid  NUMBER,
  an_er   NUMBER,
  an_ed   NUMBER,
  an_q1   NUMBER,
  an_q3   NUMBER,
  an_zone NUMBER, --1-A, 2-B, 3-C,4-D. иначе общий
  ad_date DATE);
 ------------------------------------------------------------------------------------------------------------------------
 --******************************          L                  *******************************************************--
 ------------------------------------------------------------------------------------------------------------------------
  --Статус LG
 PROCEDURE mark_lgstatus(
  newmid       IN     NUMBER,
  newdate_time IN     DATE,
  newt         IN     NUMBER,
  newu         IN     NUMBER,
  news         IN     NUMBER,
  newm         IN     NUMBER,
  newkt        IN     NUMBER,
  newl1        IN OUT NUMBER,
  newl2        IN OUT NUMBER,
  newl3        IN OUT NUMBER);
 ------------------------------------------------------------------------------------------------------------------------
  --Вставка графика нагрузки
 PROCEDURE set_halfhour_zxb(
  an_mid    NUMBER,
  an_er     NUMBER,
  an_ed     NUMBER,
  an_q1     NUMBER,
  an_q3     NUMBER,
  an_status NUMBER,
  ad_date   DATE);
 ------------------------------------------------------------------------------------------------------------------------
  --Вставка листинга показаний
 PROCEDURE set_readout_zxb(an_mid NUMBER, at_data common_pg.tt_varchar2);
 ------------------------------------------------------------------------------------------------------------------------
  --Вставка листинга графика нагрузки
 PROCEDURE set_loadprof_zxb(an_mid NUMBER, at_data common_pg.tt_varchar2);
 ------------------------------------------------------------------------------------------------------------------------
  --Вставка суточных
 PROCEDURE set_bill_zxb(
  an_mid    NUMBER,
  an_erm    NUMBER,
  an_edm    NUMBER,
  an_q1m    NUMBER,
  an_q3m    NUMBER,
  an_aerm   NUMBER,
  an_aedm   NUMBER,
  an_aq1m   NUMBER,
  an_aq3m   NUMBER,
  an_berm   NUMBER,
  an_bedm   NUMBER,
  an_bq1m   NUMBER,
  an_bq3m   NUMBER,
  an_cerm   NUMBER,
  an_cedm   NUMBER,
  an_cq1m   NUMBER,
  an_cq3m   NUMBER,
  an_derm   NUMBER,
  an_dedm   NUMBER,
  an_dq1m   NUMBER,
  an_dq3m   NUMBER,
  av_mtrsn  VARCHAR2,
  an_digits NUMBER, --Значность счетчика
  ad_date   DATE);
 ------------------------------------------------------------------------------------------------------------------------
  --Вставка месячных
 PROCEDURE set_months_zxb(
  an_mid    NUMBER,
  an_erm    NUMBER,
  an_edm    NUMBER,
  an_q1m    NUMBER,
  an_q3m    NUMBER,
  an_aerm   NUMBER,
  an_aedm   NUMBER,
  an_aq1m   NUMBER,
  an_aq3m   NUMBER,
  an_berm   NUMBER,
  an_bedm   NUMBER,
  an_bq1m   NUMBER,
  an_bq3m   NUMBER,
  an_cerm   NUMBER,
  an_cedm   NUMBER,
  an_cq1m   NUMBER,
  an_cq3m   NUMBER,
  an_derm   NUMBER,
  an_dedm   NUMBER,
  an_dq1m   NUMBER,
  an_dq3m   NUMBER,
  av_mtrsn  VARCHAR2,
  an_digits NUMBER, --Значность счетчика
  ad_date   DATE);
 ------------------------------------------------------------------------------------------------------------------------
 --******************************          A1R                  *******************************************************--
 ------------------------------------------------------------------------------------------------------------------------
  --Вставка текущих
 PROCEDURE set_curr_power_a1r(an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, ad_date DATE);
 -----------------------------------------------------------------------------------------------------------------------
  --Вставка графика нагрузки
 PROCEDURE set_halfhour_a1r(an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, ad_date DATE);
 -----------------------------------------------------------------------------------------------------------------------
   --Вставка суточных
 PROCEDURE set_bill_a1r(
  an_mid    NUMBER,
  an_erm    NUMBER,
  an_edm    NUMBER,
  an_q1m    NUMBER,
  an_q3m    NUMBER,
  an_q2m    NUMBER,
  an_q4m    NUMBER,
  an_aerm   NUMBER,
  an_aedm   NUMBER,
  an_aq1m   NUMBER,
  an_aq3m   NUMBER,
  an_aq2m   NUMBER,
  an_aq4m   NUMBER,
  an_berm   NUMBER,
  an_bedm   NUMBER,
  an_bq1m   NUMBER,
  an_bq3m   NUMBER,
  an_bq2m   NUMBER,
  an_bq4m   NUMBER,
  an_cerm   NUMBER,
  an_cedm   NUMBER,
  an_cq1m   NUMBER,
  an_cq3m   NUMBER,
  an_cq2m   NUMBER,
  an_cq4m   NUMBER,
  an_derm   NUMBER,
  an_dedm   NUMBER,
  an_dq1m   NUMBER,
  an_dq3m   NUMBER,
  an_dq2m   NUMBER,
  an_dq4m   NUMBER,
  av_mtrsn  VARCHAR2,
  an_digits NUMBER, --Значность счетчика, необходимо передать 6 - A1R_ParamCalc.DPLocE
  ad_date   DATE);
 -----------------------------------------------------------------------------------------------------------------------
   --Вставка месячных
 PROCEDURE set_months_a1r(
  an_mid    NUMBER,
  an_erm    NUMBER,
  an_edm    NUMBER,
  an_q1m    NUMBER,
  an_q3m    NUMBER,
  an_q2m    NUMBER,
  an_q4m    NUMBER,
  an_aerm   NUMBER,
  an_aedm   NUMBER,
  an_aq1m   NUMBER,
  an_aq3m   NUMBER,
  an_aq2m   NUMBER,
  an_aq4m   NUMBER,
  an_berm   NUMBER,
  an_bedm   NUMBER,
  an_bq1m   NUMBER,
  an_bq3m   NUMBER,
  an_bq2m   NUMBER,
  an_bq4m   NUMBER,
  an_cerm   NUMBER,
  an_cedm   NUMBER,
  an_cq1m   NUMBER,
  an_cq3m   NUMBER,
  an_cq2m   NUMBER,
  an_cq4m   NUMBER,
  an_derm   NUMBER,
  an_dedm   NUMBER,
  an_dq1m   NUMBER,
  an_dq3m   NUMBER,
  an_dq2m   NUMBER,
  an_dq4m   NUMBER,
  av_mtrsn  VARCHAR2,
  an_digits NUMBER, --Значность счетчика, необходимо передать 6 - A1R_ParamCalc.DPLocE
  ad_date   DATE);
 ------------------------------------------------------------------------------------------------------------------------
 --******************************          Alpha                *******************************************************--
 ------------------------------------------------------------------------------------------------------------------------
  --Вставка текущих
 PROCEDURE set_curr_power_alpha(an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, ad_date DATE);
 -----------------------------------------------------------------------------------------------------------------------
  --Вставка графика нагрузки
 PROCEDURE set_halfhour_alpha(an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, ad_date DATE);
 -----------------------------------------------------------------------------------------------------------------------
   --Вставка суточных
 PROCEDURE set_bill_alpha(
  an_mid    NUMBER,
  an_erm    NUMBER,
  an_edm    NUMBER,
  an_q1m    NUMBER,
  an_q3m    NUMBER,
  an_aerm   NUMBER,
  an_aedm   NUMBER,
  an_aq1m   NUMBER,
  an_aq3m   NUMBER,
  an_berm   NUMBER,
  an_bedm   NUMBER,
  an_bq1m   NUMBER,
  an_bq3m   NUMBER,
  an_cerm   NUMBER,
  an_cedm   NUMBER,
  an_cq1m   NUMBER,
  an_cq3m   NUMBER,
  an_derm   NUMBER,
  an_dedm   NUMBER,
  an_dq1m   NUMBER,
  an_dq3m   NUMBER,
  av_mtrsn  VARCHAR2,
  an_digits NUMBER, --Значность счетчика, необходимо передать 6 - Alpha_ParamCalc.DPLocE
  ad_date   DATE);
 -----------------------------------------------------------------------------------------------------------------------
   --Вставка месячных
 PROCEDURE set_months_alpha(
  an_mid    NUMBER,
  an_erm    NUMBER,
  an_edm    NUMBER,
  an_q1m    NUMBER,
  an_q3m    NUMBER,
  an_aerm   NUMBER,
  an_aedm   NUMBER,
  an_aq1m   NUMBER,
  an_aq3m   NUMBER,
  an_berm   NUMBER,
  an_bedm   NUMBER,
  an_bq1m   NUMBER,
  an_bq3m   NUMBER,
  an_cerm   NUMBER,
  an_cedm   NUMBER,
  an_cq1m   NUMBER,
  an_cq3m   NUMBER,
  an_derm   NUMBER,
  an_dedm   NUMBER,
  an_dq1m   NUMBER,
  an_dq3m   NUMBER,
  av_mtrsn  VARCHAR2,
  an_digits NUMBER, --Значность счетчика, необходимо передать 6 - Alpha_ParamCalc.DPLocE
  ad_date   DATE);
------------------------------------------------------------------------------------------------------------------------
 --******************************          Metkom              *******************************************************--
 ------------------------------------------------------------------------------------------------------------------------
  --Вставка графика нагрузки
 PROCEDURE set_halfhour_metcom(an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, ad_date DATE);
 ------------------------------------------------------------------------------------------------------------------------
END; -- Package Specification INDIC_PG
/

-- End of DDL script for COMSRV_PG

-- Start of DDL script for DAS_PG
-- Generated 27-янв-03  11:33:15 am
-- from oe-RYDA:1

-- Package DAS_PG

CREATE OR REPLACE
Package      DAS_PG
  IS
-- Пакет Сервера сбора данных.
--
-- MODIFICATION HISTORY
-- Person      Date     Comments
-- ---------   -------- ------------------------------------------
-- Вештак      24.11.02 Создан
  PROCEDURE CalcDay4Bill;
  PROCEDURE CalcOneDay4Bill (an_maket NUMBER, dday DATE);
  PROCEDURE CalcPeriod4Bill (dstart date, dend date);
  PROCEDURE CalcPoint4Bill (nmid number, dstart date, dend date);
  PROCEDURE ProcessBillCalc;



END; -- Package spec
/

-- End of DDL script for DAS_PG

-- Start of DDL script for DEPARTMENTS_PG
-- Generated 27-янв-03  11:33:15 am
-- from oe-RYDA:1

-- Package DEPARTMENTS_PG

CREATE OR REPLACE
PACKAGE DEPARTMENTS_PG IS
  -- пакет работы с подразделениями
  -- дата создания 14/10/2001 (Сечин А.А.)
------------------------------------------------------------------------------------------------------------------------
  -- Процедура вставки
 PROCEDURE ins_p(
  av_name           VARCHAR2, --Название
  an_sort           NUMBER,   --Сортировка
  an_department OUT NUMBER --Ид подразделения
                          );

------------------------------------------------------------------------------------------------------------------------
  -- Процедура обновления данных
 PROCEDURE upd_p(
  an_department NUMBER, --Ид подразделения
  av_name       VARCHAR2, --Название
  an_sort       NUMBER   --Сортировка
                        );

------------------------------------------------------------------------------------------------------------------------
  -- Процедура удаления данных
 PROCEDURE del_p(
  an_department NUMBER --Ид подразделения
                      );
------------------------------------------------------------------------------------------------------------------------
END; -- Package Specification DEPARTMENTS_PG
/

-- End of DDL script for DEPARTMENTS_PG

-- Start of DDL script for DEPORTATION_PG
-- Generated 27-янв-03  11:33:15 am
-- from oe-RYDA:1

-- Package DEPORTATION_PG

CREATE OR REPLACE
PACKAGE deportation_pg IS
   -- пакет работы с каналами экспорта данных
   -- дата создания 26/07/2002 (Сечин А.А.)
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура вставки
 PROCEDURE ins_p(
  av_name             VARCHAR2, --Название
  av_note             VARCHAR2, --Примечание
  an_maket            NUMBER, --Ид макета
  an_type             NUMBER, --Тип отсылки
  av_address          VARCHAR2, --Адрес
  an_parent           NUMBER, --Ид основного канала
  ad_from             DATE, --Отсылать с
  ad_till             DATE, --Отсылать по
  an_block            NUMBER, --Блокировка
  an_retries_tout     NUMBER, --Пауза между попытками мин
  an_retries          NUMBER, --Количество попыток
  an_deportation  OUT NUMBER --Ид канала
                            );
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура обновления данных
 PROCEDURE upd_p(
  an_deportation  NUMBER, --Ид канала
  av_name         VARCHAR2, --Название
  av_note         VARCHAR2, --Примечание
  an_maket        NUMBER, --Ид макета
  an_type         NUMBER, --Тип отсылки
  av_address      VARCHAR2, --Адрес
  an_parent       NUMBER, --Ид основного канала
  ad_from         DATE, --Отсылать с
  ad_till         DATE, --Отсылать по
  an_block        NUMBER, --Блокировка
  an_retries_tout NUMBER, --Пауза между попытками мин
  an_retries      NUMBER --Количество попыток
                        );
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура удаления данных
 PROCEDURE del_p(an_deportation NUMBER --Ид канала
                                      );
------------------------------------------------------------------------------------------------------------------------
END; -- Package Specification DEPORTATION_pg
/

-- End of DDL script for DEPORTATION_PG

-- Start of DDL script for DEPORTPROCS_PG
-- Generated 27-янв-03  11:33:15 am
-- from oe-RYDA:1

-- Package DEPORTPROCS_PG

CREATE OR REPLACE
PACKAGE DEPORTPROCS_PG IS
   -- пакет работы с таблицей DEPORTPROCEDURES
   -- дата создания 01/12/2002 (Чудаков И.В.)
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура вставки
 PROCEDURE ins_p(
    av_vname                          VARCHAR2,
    av_vprocedure                     VARCHAR2,
    an_nperiod                        NUMBER,
    an_nshift                         NUMBER,
    an_ntype                          NUMBER,
    av_vparam                         VARCHAR2,
    av_vmemo                          VARCHAR2,
    an_nprocedure   OUT               NUMBER
                );
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура обновления данных
 PROCEDURE upd_p(
    an_nprocedure                     NUMBER,
    av_vname                          VARCHAR2,
    av_vprocedure                     VARCHAR2,
    an_nperiod                        NUMBER,
    an_nshift                         NUMBER,
    an_ntype                          NUMBER,
    av_vparam                         VARCHAR2,
    av_vmemo                          VARCHAR2
                         );
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура удаления данных
 PROCEDURE del_p(an_nprocedure NUMBER --Ид точки
                              );
 ------------------------------------------------------------------------------------------------------------------------
END; -- Package Specification editcanals_pg
/

-- End of DDL script for DEPORTPROCS_PG

-- Start of DDL script for EDITCANALS_PG
-- Generated 27-янв-03  11:33:15 am
-- from oe-RYDA:1

-- Package EDITCANALS_PG

CREATE OR REPLACE
PACKAGE editcanals_pg
IS
  -- пакет работы с каналами
  -- дата создания 27/12/2001 (Сечин А.А.)
------------------------------------------------------------------------------------------------------------------------
  -- Процедура вставки
 PROCEDURE ins_p(
  an_parent           NUMBER, --Родитель
  av_name             VARCHAR2, --Название
  av_short_name       VARCHAR2, --Краткое название
  an_protocol_id      NUMBER, --
  an_com_id           NUMBER, --
  av_init_str         VARCHAR2, --
  av_addr             VARCHAR2, --
  an_cycle_tout       NUMBER, --
  an_retries          NUMBER, --
  an_retries_tout     NUMBER, --
  an_blocking         NUMBER, --
  av_caller_name      VARCHAR2, --
  an_mid          OUT NUMBER --Ид точки
                            );

------------------------------------------------------------------------------------------------------------------------
  -- Процедура обновления данных
 PROCEDURE upd_p(
  an_mid          NUMBER, --Ид точки
  an_parent       NUMBER, --Родитель
  av_name         VARCHAR2, --Название
  av_short_name   VARCHAR2, --Краткое название
  an_protocol_id  NUMBER, --
  an_com_id       NUMBER, --
  av_init_str     VARCHAR2, --
  av_addr         VARCHAR2, --
  an_cycle_tout   NUMBER, --
  an_retries      NUMBER, --
  an_retries_tout NUMBER, --
  an_blocking     NUMBER, --
  av_caller_name  VARCHAR2 --
                          );

------------------------------------------------------------------------------------------------------------------------
  -- Процедура удаления данных
 PROCEDURE del_p(
  an_mid NUMBER --Ид точки
               );
------------------------------------------------------------------------------------------------------------------------
END; -- Package Specification editcanals_pg
/

-- End of DDL script for EDITCANALS_PG

-- Start of DDL script for EDITEXPORTGROUP_PG
-- Generated 27-янв-03  11:33:15 am
-- from oe-RYDA:1

-- Package EDITEXPORTGROUP_PG

CREATE OR REPLACE
PACKAGE editexportgroup_pg
IS
  -- пакет работы с экспортируемыми группами
  -- дата создания 26/12/2001 (Сечин А.А.)
------------------------------------------------------------------------------------------------------------------------
  -- Процедура вставки
 PROCEDURE ins_p(
  an_parent          NUMBER, --Родитель
  av_name            VARCHAR2, --Название
  av_short_name      VARCHAR2, --Краткое название
  an_mid             NUMBER, --Ид точки
  an_inverted        NUMBER, --Признак инвертирования
  an_group_total     NUMBER, --Признак суммирования по группе
  an_isbill          NUMBER, --Экспорт суток
  an_billsz          NUMBER, --Экспорт суток (размер)
  an_ishour          NUMBER, --Экспорт получасовок
  an_hoursz          NUMBER, --Экспорт получасовок (размер)
  an_isprof          NUMBER, --Экспорт профиля
  an_profsz          NUMBER, --Экспорт профиля (размер)
  an_isjournal       NUMBER, --Экспорт журнала
  an_journalsz       NUMBER, --Экспорт журнала (размер)
  an_gid         OUT NUMBER --Ид группы
                           );

------------------------------------------------------------------------------------------------------------------------
  -- Процедура обновления данных
 PROCEDURE upd_p(
  an_gid         NUMBER, --Ид группы
  an_parent      NUMBER, --Родитель
  av_name        VARCHAR2, --Название
  av_short_name  VARCHAR2, --Краткое название
  an_mid         NUMBER, --Ид точки
  an_inverted    NUMBER, --Признак инвертирования
  an_group_total NUMBER, --Признак суммирования по группе
  an_isbill      NUMBER, --Экспорт суток
  an_billsz      NUMBER, --Экспорт суток (размер)
  an_ishour      NUMBER, --Экспорт получасовок
  an_hoursz      NUMBER, --Экспорт получасовок (размер)
  an_isprof      NUMBER, --Экспорт профиля
  an_profsz      NUMBER, --Экспорт профиля (размер)
  an_isjournal   NUMBER, --Экспорт журнала
  an_journalsz   NUMBER --Экспорт журнала (размер)
                       );

------------------------------------------------------------------------------------------------------------------------
  -- Процедура удаления данных
 PROCEDURE del_p(
  an_gid NUMBER --Ид группы
               );
------------------------------------------------------------------------------------------------------------------------
END; -- Package Specification editexportgroup_pg
/

-- End of DDL script for EDITEXPORTGROUP_PG

-- Start of DDL script for EDITFEEDERGROUP_PG
-- Generated 27-янв-03  11:33:15 am
-- from oe-RYDA:1

-- Package EDITFEEDERGROUP_PG

CREATE OR REPLACE
PACKAGE editfeedergroup_pg IS
   -- пакет работы с группами присоединений
   -- дата создания 28/12/2001 (Сечин А.А.)
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура вставки
 PROCEDURE ins_p(
  an_parent         NUMBER, --Родитель
  av_name           VARCHAR2, --Название
  av_short_name     VARCHAR2, --Краткое название
  an_mid        OUT NUMBER --Ид точки
                          );
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура обновления данных
 PROCEDURE upd_p(
  an_mid        NUMBER, --Ид точки
  an_parent     NUMBER, --Родитель
  av_name       VARCHAR2, --Название
  av_short_name VARCHAR2 --Краткое название
                        );
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура вставки для АСРПБ
 PROCEDURE ins_p_a(
  an_parent         NUMBER, --Родитель
  av_name           VARCHAR2, --Название
  av_short_name     VARCHAR2, --Краткое название
  an_point          NUMBER, --Ид прома
  an_mid        OUT NUMBER --Ид точки
                          );
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура обновления данных для АСРПБ
 PROCEDURE upd_p_a(
  an_mid        NUMBER, --Ид точки
  an_parent     NUMBER, --Родитель
  av_name       VARCHAR2, --Название
  av_short_name VARCHAR2 --Краткое название
                        );
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура удаления данных
 PROCEDURE del_p(an_mid NUMBER --Ид точки
                              );
------------------------------------------------------------------------------------------------------------------------
END; -- Package Specification editfeedergroup_pg
/

-- End of DDL script for EDITFEEDERGROUP_PG

-- Start of DDL script for EDITFEEDERS_PG
-- Generated 27-янв-03  11:33:15 am
-- from oe-RYDA:1

-- Package EDITFEEDERS_PG

CREATE OR REPLACE
PACKAGE editfeeders_pg IS
   -- пакет работы с точками
   -- дата создания 19/10/2001 (Сечин А.А.)
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура вставки
 PROCEDURE ins_p(
  an_parent          NUMBER, --Родитель
  an_type            NUMBER, --Тип точки
  av_name            VARCHAR2, --Название
  av_short_name      VARCHAR2, --Краткое название
  an_er_position     NUMBER,
  an_q1_position     NUMBER,
  an_ed_position     NUMBER,
  an_q3_position     NUMBER,
  an_smart           NUMBER, --Интеллектуал
  an_q1234           NUMBER, --Квадранты
  an_canal           NUMBER, --Номер канала
  av_cellnum         VARCHAR2, --Номер ячейки
  an_power           NUMBER, --Мощность перв кВ
  an_current1        NUMBER, --Напряжение перв
  an_current2        NUMBER, --Напряжение вторич
  an_kc              NUMBER, --Коэфф
  an_tag             NUMBER, --Тег связи
  av_info            VARCHAR2, --Доп информация
  an_power2          NUMBER, --Мощность вторич кВ
  an_metkc           NUMBER, --Коэф прошитый в счетчике
  an_abc             NUMBER, --Заземленная нейтраль
  an_calcbill        NUMBER, --Верифицировать суточные
  an_calcmonths      NUMBER, --Верифицировать месячные
  an_inverted        NUMBER, --Инверсия
  an_switch          NUMBER, --Признак обводника
  an_mid         OUT NUMBER --Ид точки
                           );
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура обновления данных
 PROCEDURE upd_p(
  an_mid         NUMBER, --Ид точки
  an_parent      NUMBER, --Родитель
  an_type        NUMBER, --Тип точки
  av_name        VARCHAR2, --Название
  av_short_name  VARCHAR2, --Краткое название
  an_er_position NUMBER,
  an_q1_position NUMBER,
  an_ed_position NUMBER,
  an_q3_position NUMBER,
  an_smart       NUMBER, --Интеллектуал
  an_q1234       NUMBER, --Квадранты
  an_canal       NUMBER, --Номер канала
  av_cellnum     VARCHAR2, --Номер ячейки
  an_power       NUMBER, --Мощность
  an_current1    NUMBER, --Напряжение перв
  an_current2    NUMBER, --Напряжение вторич
  an_kc          NUMBER, --Коэфф
  an_tag         NUMBER, --Тег связи
  av_info        VARCHAR2, --Доп информация
  an_power2      NUMBER, --Мощность вторич кВ
  an_metkc       NUMBER, --Коэф прошитый в счетчике
  an_abc         NUMBER, --Заземленная нейтраль
  an_calcbill    NUMBER, --Верифицировать суточные
  an_calcmonths  NUMBER, --Верифицировать месячные
  an_inverted    NUMBER, --Инверсия
  an_switch      NUMBER --Признак обводника
                       );
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура вставки АСКУЭ
 PROCEDURE ins_p_a(
  an_parent          NUMBER, --Родитель
  an_type            NUMBER, --Тип точки
  av_name            VARCHAR2, --Название
  av_short_name      VARCHAR2, --Краткое название
  an_er_position     NUMBER,
  an_q1_position     NUMBER,
  an_ed_position     NUMBER,
  an_q3_position     NUMBER,
  an_smart           NUMBER, --Интеллектуал
  an_q1234           NUMBER, --Квадранты
  av_cellnum         VARCHAR2, --Номер ячейки
  an_power           NUMBER, --Мощность
  an_current1        NUMBER, --Напряжение перв
  an_current2        NUMBER, --Напряжение вторич
  an_kc              NUMBER, --Коэфф
  an_point           NUMBER, --Ид точки АСРПП
  an_power2          NUMBER, --Мощность вторич кВ
  an_mid         OUT NUMBER --Ид точки
                           );
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура обновления данных АСКУЭ
 PROCEDURE upd_p_a(
  an_mid         NUMBER, --Ид точки
  an_parent      NUMBER, --Родитель
  an_type        NUMBER, --Тип точки
  av_name        VARCHAR2, --Название
  av_short_name  VARCHAR2, --Краткое название
  an_er_position NUMBER,
  an_q1_position NUMBER,
  an_ed_position NUMBER,
  an_q3_position NUMBER,
  an_smart       NUMBER, --Интеллектуал
  an_q1234       NUMBER, --Квадранты
  av_cellnum     VARCHAR2, --Номер ячейки
  an_power       NUMBER, --Мощность
  an_current1    NUMBER, --Напряжение перв
  an_current2    NUMBER, --Напряжение вторич
  an_kc          NUMBER, --Коэфф
  an_power2      NUMBER --Мощность вторич кВ
                       --  an_metkc       NUMBER --Коэф прошитый в счетчике
                       );
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура удаления данных
 PROCEDURE del_p(an_mid NUMBER --Ид точки
                              );
 ------------------------------------------------------------------------------------------------------------------------
 --Процедура обновления счетчика АСКУЭ
 PROCEDURE upd_meters_a(
  an_mid       NUMBER, --Ид точки
  an_entype    NUMBER, --ENTYPE
  av_smart     VARCHAR2, --SMART
  av_mtrsn     VARCHAR2, --MTRSN
  ad_date_time DATE, --DATE_TIME
  an_digits    NUMBER, --DIGITS
  av_mtype     VARCHAR2, --MTYPE
  an_mcurrent  NUMBER, --MCURRENT
  an_mpower    NUMBER, --MPOWER
  an_mconst    NUMBER, --MCONST
  an_mclass    NUMBER, --MCLASS
  an_myear     NUMBER, --MYEAR
  an_mquarter  NUMBER --MQUARTER
                     );
 ------------------------------------------------------------------------------------------------------------------------
 FUNCTION insgroup(an_mid NUMBER)
  RETURN NUMBER;
 ------------------------------------------------------------------------------------------------------------------------
 --Устанавливает параметры простых потерь
 PROCEDURE setpoterinfo(
  an_mid              NUMBER, --Ид точки
  an_wastepercentcalc NUMBER, --Тип потерь
  an_workinghours     NUMBER, --Часы работы
  an_fullhours        NUMBER, --Полные часы работы
  an_line_loss         NUMBER, --Портери в линии
  an_act_loss          NUMBER, --Потери акт транс
  an_react_loss        NUMBER --Потери реакт транс
                            );
------------------------------------------------------------------------------------------------------------------------
END; -- Package Specification EDITFEEDERS_PG
/

-- End of DDL script for EDITFEEDERS_PG

-- Start of DDL script for EDITFORMS_PG
-- Generated 27-янв-03  11:33:15 am
-- from oe-RYDA:1

-- Package EDITFORMS_PG

CREATE OR REPLACE
PACKAGE editforms_pg
IS
  -- пакет работы с формами
  -- дата создания 19/12/2001 (Сечин А.А.)
------------------------------------------------------------------------------------------------------------------------
  -- Процедура вставки
 PROCEDURE ins_p(
  an_parent             NUMBER, --
  an_monitor            NUMBER, --
  an_codetemplate       NUMBER, --
  av_nameform           VARCHAR2, --
  av_commentform        VARCHAR2, --
  av_enablecontrols     VARCHAR2, --
  an_stepprofile        NUMBER, --
  av_namealert          VARCHAR2, --
  av_procname        VARCHAR2, --
  at_gid                COMMON_PG.tt_number, --
  an_fid            OUT NUMBER --
                              );

------------------------------------------------------------------------------------------------------------------------
  -- Процедура обновления данных
 PROCEDURE upd_p(
  an_fid            NUMBER, --
  an_parent         NUMBER, --
  an_monitor        NUMBER, --
  an_codetemplate   NUMBER, --
  av_nameform       VARCHAR2, --
  av_commentform    VARCHAR2, --
  av_enablecontrols VARCHAR2, --
  an_stepprofile    NUMBER, --
  av_namealert      VARCHAR2, --
  av_procname        VARCHAR2, --
  at_gid            COMMON_PG.tt_number --
                             );

------------------------------------------------------------------------------------------------------------------------
  -- Процедура удаления данных
 PROCEDURE del_p(
  an_fid NUMBER --
               );
------------------------------------------------------------------------------------------------------------------------
END; -- Package Specification editforms_pg
/

-- End of DDL script for EDITFORMS_PG

-- Start of DDL script for EDITGROUPS_PG
-- Generated 27-янв-03  11:33:15 am
-- from oe-RYDA:1

-- Package EDITGROUPS_PG

CREATE OR REPLACE
PACKAGE editgroups_pg IS
 ------------------------------------------------------------------------------------------------------------------------
    -- пакет работы с группами
    -- дата создания 29/10/2001 (Сечин А.А.)
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура вставки
 PROCEDURE ins_p(
  an_parent                NUMBER, --Родитель
  av_name                  VARCHAR2, --Название
  av_short_name            VARCHAR2, --Краткое название
  an_mid                   NUMBER, --Ид точки
  an_limit_id              NUMBER, --Ид лимита
  an_inverted              NUMBER, --Признак инвертирования
  an_group_total           NUMBER, --Признак суммирования по группе
  an_emergencyreserve      NUMBER, --Аварийная бронь
  an_technologyreserve     NUMBER, --Технологическая бронь
  an_gid               OUT NUMBER --Ид группы
                                 );
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура обновления данных
 PROCEDURE upd_p(
  an_gid               NUMBER, --Ид группы
  an_parent            NUMBER, --Родитель
  av_name              VARCHAR2, --Название
  av_short_name        VARCHAR2, --Краткое название
  an_mid               NUMBER, --Ид точки
  an_limit_id          NUMBER, --Ид лимита
  an_inverted          NUMBER, --Признак инвертирования
  an_group_total       NUMBER, --Признак суммирования по группе
  an_emergencyreserve  NUMBER, --Аварийная бронь
  an_technologyreserve NUMBER --Технологическая бронь
                             );
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура вставки АСРПП
 PROCEDURE ins_p_a(
  an_parent                NUMBER, --Родитель
  av_name                  VARCHAR2, --Название
  av_short_name            VARCHAR2, --Краткое название
  an_mid                   NUMBER, --Ид точки
  an_inverted              NUMBER, --Признак инвертирования
  an_root1                NUMBER, --Ид группы прома
  an_root2                NUMBER, --Ид группы прома
  an_emergencyreserve      NUMBER, --Аварийная бронь
  an_technologyreserve     NUMBER, --Технологическая бронь
  an_gid               OUT NUMBER --Ид группы
                                 );
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура обновления данных АСРПП
 PROCEDURE upd_p_a(
  an_gid               NUMBER, --Ид группы
  an_parent            NUMBER, --Родитель
  av_name              VARCHAR2, --Название
  av_short_name        VARCHAR2, --Краткое название
  an_inverted          NUMBER, --Признак инвертирования
  an_emergencyreserve  NUMBER, --Аварийная бронь
  an_technologyreserve NUMBER --Технологическая бронь
                             );
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура удаления данных
 PROCEDURE del_p(an_gid NUMBER --Ид группы
                              );
 ------------------------------------------------------------------------------------------------------------------------
    -- Процедура изменения лимитов по группе
 PROCEDURE updlimit_p(
  an_gid       NUMBER, --Ид группы
  at_start     COMMON_PG.tt_varchar2, --Дата ввода в действие
  at_limitcons COMMON_PG.tt_number, --Потребление
  at_limitcapm COMMON_PG.tt_number, --Нагрузка утро
  at_limitcape COMMON_PG.tt_number --Нагрузка вечер
                        );
------------------------------------------------------------------------------------------------------------------------
END; -- Package Specification editgroups_pg
/

-- End of DDL script for EDITGROUPS_PG

-- Start of DDL script for EDITMANUAL_PG
-- Generated 27-янв-03  11:33:15 am
-- from oe-RYDA:1

-- Package EDITMANUAL_PG

CREATE OR REPLACE
PACKAGE editmanual_pg
IS
  -- пакет работы с ручниками
  -- дата создания 25/12/2001 (Сечин А.А.)
------------------------------------------------------------------------------------------------------------------------
  -- Процедура редактирования значений
 PROCEDURE updvalue_p(
  an_mid  NUMBER, --Ид точки
  an_curr NUMBER, --тек значение
  ad_next DATE, --След дата
  an_next NUMBER --  След значение
                );
------------------------------------------------------------------------------------------------------------------------
END; -- Package Specification editmanual_pg
/

-- End of DDL script for EDITMANUAL_PG

-- Start of DDL script for EDITMONITORS_PG
-- Generated 27-янв-03  11:33:15 am
-- from oe-RYDA:1

-- Package EDITMONITORS_PG

CREATE OR REPLACE
Package      editmonitors_pg
  IS
    -- пакет работы с мониторами
    -- дата создания 05/12/2002 (Коваленко А.С)
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура вставки
 PROCEDURE ins_p(
  an_nparent         NUMBER,--Ид родителя
  an_mschema         NUMBER,--Ид схемы
  av_name            VARCHAR2,--Название монитора
  an_dsize           NUMBER,--Размер описания
  alr_dfile          LONG RAW,--Описание монитора
  an_is_default      NUMBER,--Признак монитора по умолчанию
  an_monitor_id  OUT NUMBER --Ид монитора
                                 );
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура обновления данных
 PROCEDURE upd_p(
  an_monitor_id      NUMBER, --Ид монитора
  an_nparent         NUMBER,--Ид родителя
  an_mschema         NUMBER,--Ид схемы
  av_name            VARCHAR2,--Название монитора
  an_dsize           NUMBER,--Размер описания
  alr_dfile          LONG RAW,--Описание монитора
  an_is_default      NUMBER--Признак монитора по умолчанию
                             );
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура удаления данных
 PROCEDURE del_p(  an_monitor_id NUMBER --Ид монитора
                              );

END; -- Package Specification EDITMONITORS_PG
/

-- End of DDL script for EDITMONITORS_PG

-- Start of DDL script for EXPORT_PG
-- Generated 27-янв-03  11:33:15 am
-- from oe-RYDA:1

-- Package EXPORT_PG

CREATE OR REPLACE
PACKAGE export_pg
IS
  -- пакет работы системы экспорта данных
  -- дата создания 12/12/2001 Сечин А.А.
------------------------------------------------------------------------------------------------------------------------
--Готовим данные для экспорта
 PROCEDURE setexport(
  an_mid   NUMBER,
  ad_date  DATE,
  an_table NUMBER -- an_table =1 BILL,=2 HALFHOUR,=3 PROFILE,=4 MONTHS,=5 JOURNAL (4 и 5 не реализовано)
                 );
------------------------------------------------------------------------------------------------------------------------
--Готовим данные для экспорта (по сигналу)
 PROCEDURE setgroupexport(
  an_table NUMBER -- an_table =1 BILL,=2 HALFHOUR,=3 PROFILE,=4 MONTHS,=5 JOURNAL (4 и 5 не реализовано)
                 );

------------------------------------------------------------------------------------------------------------------------
--Сигнал для экспорта
 PROCEDURE signal(
  an_signal NUMBER -- an_signal =1 BILL,=2 HALFHOUR,=3 PROFILE,=4 MONTHS,=5 JOURNAL
                  );
------------------------------------------------------------------------------------------------------------------------
END; -- Package Specification INDIC_PG
/

-- End of DDL script for EXPORT_PG

-- Start of DDL script for FILEREPORT_PG
-- Generated 27-янв-03  11:33:15 am
-- from oe-RYDA:1

-- Package FILEREPORT_PG

CREATE OR REPLACE
PACKAGE filereport_pg IS
  ------------------------------------------------------------------------------------------------------------------------
    -- пакет по созданию отчетов в файл
    -- дата создания 28/11/2002 Сечин А.А.
 ------------------------------------------------------------------------------------------------------------------------
 FUNCTION gn_group
  RETURN NUMBER;
 PRAGMA restrict_references(gn_group, WNDS, WNPS);
 FUNCTION gd_from
  RETURN DATE;
 PRAGMA restrict_references(gd_from, WNDS, WNPS);
 FUNCTION gd_till
  RETURN DATE;
 PRAGMA restrict_references(gd_till, WNDS, WNPS);
 FUNCTION gv_name
  RETURN VARCHAR2;
 PRAGMA restrict_references(gv_name, WNDS, WNPS);
 ------------------------------------------------------------------------------------------------------------------------
 PROCEDURE main_p(an_form NUMBER, an_group NUMBER, ad_from DATE, ad_till DATE);
 PROCEDURE put_p(av_text VARCHAR2);
------------------------------------------------------------------------------------------------------------------------
END; -- Package Specification REPORTS1_PG
/

-- End of DDL script for FILEREPORT_PG

-- Start of DDL script for FILE_PG
-- Generated 27-янв-03  11:33:15 am
-- from oe-RYDA:1

-- Package FILE_PG

CREATE OR REPLACE
PACKAGE file_pg IS
 ------------------------------------------------------------------------------------------------------------------------
   -- пакет по созданию файлов рассылки
   -- дата создания 27/07/2002 Сечин А.А.
 ------------------------------------------------------------------------------------------------------------------------
 PROCEDURE main_p;
  /*Главная процедура запуска умеет запускать процедуры из таблицы DEPORTPROCERURES
  их спецификация должна быть
  PROCEDURE p(ad_date DATE,av_fname IN OUT varchar2);*/
 ------------------------------------------------------------------------------------------------------------------------
 PROCEDURE startimmediate_p(an_maket NUMBER,ad_date DATE,av_param VARCHAR2);
  /*Главная процедура запуска умеет запускать процедуры из таблицы DEPORTPROCERURES
  их спецификация должна быть
  PROCEDURE p(ad_date DATE,av_fname IN OUT varchar2);*/
 ------------------------------------------------------------------------------------------------------------------------
 FUNCTION gv_param return VARCHAR2;
 ------------------------------------------------------------------------------------------------------------------------
 --Печать в файл
 PROCEDURE out_p(av_str IN VARCHAR2);
------------------------------------------------------------------------------------------------------------------------
END; -- Package Specification file_pg
/

-- End of DDL script for FILE_PG

-- Start of DDL script for INDIC_PG
-- Generated 27-янв-03  11:33:15 am
-- from oe-RYDA:1

-- Package INDIC_PG

CREATE OR REPLACE
PACKAGE indic_pg IS
   -- пакет работы с показаниями
   -- дата создания 13/10/2001 Сечин А.А.
 ------------------------------------------------------------------------------------------------------------------------
 cn_manualinput    CONSTANT NUMBER := 50;
 ------------------------------------------------------------------------------------------------------------------------
   -- Дата последних (показаний an_kind=1 или расхода an_kind=2 иначе записи)
 FUNCTION getlastdate(
  an_mid   NUMBER,
  ad_date  DATE,
  an_ntype NUMBER,
  an_zone  NUMBER,
  an_table NUMBER, -- an_table =1 BILL,=2 HALFHOUR,=3 PROFILE,=5 BILLORG иначе MONTHS
  an_kind  NUMBER)
  RETURN DATE;
 PRAGMA restrict_references(getlastdate, WNDS, WNPS);
 ------------------------------------------------------------------------------------------------------------------------
   -- Дата следующих (показаний an_kind=1 или расхода an_kind=2 иначе записи)
 FUNCTION getnextdate(
  an_mid   NUMBER,
  ad_date  DATE,
  an_ntype NUMBER,
  an_zone  NUMBER,
  an_table NUMBER, -- an_table =1 BILL,=2 HALFHOUR,=3 PROFILE,=5 BILLORG иначе MONTHS
  an_kind  NUMBER)
  RETURN DATE;
 PRAGMA restrict_references(getnextdate, WNDS, WNPS);
 ------------------------------------------------------------------------------------------------------------------------
   -- Последние показания
 FUNCTION getlastindic(an_mid NUMBER, ad_date DATE, an_ntype NUMBER, an_zone NUMBER, an_table NUMBER) -- an_table =1 BILL,=2 HALFHOUR,=3 PROFILE,=5 BILLORG иначе MONTHS
  RETURN NUMBER;
 PRAGMA restrict_references(getlastindic, WNDS, WNPS);
 ------------------------------------------------------------------------------------------------------------------------
   -- Последний расход
 FUNCTION getlastdebit(an_mid NUMBER, ad_date DATE, an_ntype NUMBER, an_zone NUMBER, an_table NUMBER) -- an_table =1 BILL,=2 HALFHOUR,=3 PROFILE,=5 BILLORG иначе MONTHS
  RETURN NUMBER;
 PRAGMA restrict_references(getlastdebit, WNDS, WNPS);
 ------------------------------------------------------------------------------------------------------------------------
   -- Расход по дате
 FUNCTION getdebit(an_mid NUMBER, ad_date DATE, an_ntype NUMBER, an_zone NUMBER, an_table NUMBER) -- an_table =1 BILL,=2 HALFHOUR,=3 PROFILE,=5 BILLORG иначе MONTHS
  RETURN NUMBER;
 PRAGMA restrict_references(getlastdebit, WNDS, WNPS);
 ------------------------------------------------------------------------------------------------------------------------
 --Ins Upd Del показаний короткая
 PROCEDURE setindic(
  an_mid         NUMBER,
  ad_date        DATE,
  an_ntype       NUMBER,
  an_table       NUMBER, -- an_table =1 BILL,=2 HALFHOUR,=3 PROFILE,=5 BILLORG иначе MONTHS
  an_needupdlast NUMBER, -- needupdlast=1, если в случае Upd производит Upd следующего расхода
  av_source      VARCHAR2,
  av_remark      VARCHAR2,
  av_mtrsn       VARCHAR2,
  an_kc          NUMBER,
  an_rm          NUMBER, --показания
  an_r           NUMBER --расход
                       );
 ------------------------------------------------------------------------------------------------------------------------
 --Ins Upd Del показаний длинная (зоны)
 PROCEDURE setindic(
  an_mid         NUMBER,
  ad_date        DATE,
  an_ntype       NUMBER,
  an_table       NUMBER, -- an_table =1 BILL,=2 HALFHOUR,=3 PROFILE,=5 BILLORG иначе MONTHS
  an_needupdlast NUMBER, -- needupdlast=1, если в случае Upd производит Upd следующего расхода
  av_source      VARCHAR2,
  av_remark      VARCHAR2,
  av_mtrsn       VARCHAR2,
  an_kc          NUMBER,
  an_rm          NUMBER, --показания
  an_arm         NUMBER, --показания 1 зона
  an_brm         NUMBER,
  an_crm         NUMBER,
  an_drm         NUMBER,
  an_r           NUMBER, --расход
  an_ar          NUMBER, --расход 1 зона
  an_br          NUMBER,
  an_cr          NUMBER,
  an_dr          NUMBER);
 ------------------------------------------------------------------------------------------------------------------------
 --Ins Upd Del расхода короткая
 PROCEDURE setdebit(
  an_mid    NUMBER,
  ad_date   DATE,
  an_ntype  NUMBER,
  an_table  NUMBER, -- an_table =1 BILL,=2 HALFHOUR,=3 PROFILE,=5 BILLORG иначе MONTHS
  av_source VARCHAR2,
  av_remark VARCHAR2,
  av_mtrsn  VARCHAR2,
  an_kc     NUMBER,
  an_r      NUMBER --расход
                  );
 ------------------------------------------------------------------------------------------------------------------------
 --Ins Upd Del расхода длинная (зоны)
 PROCEDURE setdebit(
  an_mid    NUMBER,
  ad_date   DATE,
  an_ntype  NUMBER,
  an_table  NUMBER, -- an_table =1 BILL,=2 HALFHOUR,=3 PROFILE,=5 BILLORG иначе MONTHS
  av_source VARCHAR2,
  av_remark VARCHAR2,
  av_mtrsn  VARCHAR2,
  an_kc     NUMBER,
  an_r      NUMBER, --расход
  an_ar     NUMBER, --расход 1 зона
  an_br     NUMBER,
  an_cr     NUMBER,
  an_dr     NUMBER);
 ------------------------------------------------------------------------------------------------------------------------
 PROCEDURE setpower(an_mid NUMBER, ad_date DATE, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER);
 ------------------------------------------------------------------------------------------------------------------------
 --Возвращает ид группы точек с разбивкой графика поровну
 FUNCTION getoutputgroup
  RETURN NUMBER;
 PRAGMA restrict_references(getoutputgroup, WNDS, WNPS);
 ------------------------------------------------------------------------------------------------------------------------
END; -- Package Specification INDIC_PG
/

-- End of DDL script for INDIC_PG

-- Start of DDL script for LOADCT_PG
-- Generated 27-янв-03  11:33:15 am
-- from oe-RYDA:1

-- Package LOADCT_PG

CREATE OR REPLACE
PACKAGE loadct_pg IS
 ------------------------------------------------------------------------------------------------------------------------
    -- Интерфейс взаимодействия БД с загрузчиком CT
    -- дата создания 02/12/2001 Сечин А.А.
 ------------------------------------------------------------------------------------------------------------------------
  --Вставка 3-х минуток
 PROCEDURE set_profile(an_mid NUMBER, ad_date DATE, an_er NUMBER);
 ------------------------------------------------------------------------------------------------------------------------
  --Вставка графика нагрузки
 PROCEDURE set_halfhour(an_mid NUMBER, ad_date DATE, an_type NUMBER, an_val COMMON_PG.tt_number);
 --an_type - 1 ER, 2- Q1
 ------------------------------------------------------------------------------------------------------------------------
  --Вставка суточных
 PROCEDURE set_bill(an_mid NUMBER, ad_date DATE, an_er NUMBER, an_q1 NUMBER);
 ------------------------------------------------------------------------------------------------------------------------
  --Окончание загрузки
 -- 3-х , получасовки, сутиочные 0 или 1
 PROCEDURE set_signal(av_mask VARCHAR2);
------------------------------------------------------------------------------------------------------------------------
END; -- Package Specification LOADCT_PG
/

-- End of DDL script for LOADCT_PG

-- Start of DDL script for MAKETS_PG
-- Generated 27-янв-03  11:33:16 am
-- from oe-RYDA:1

-- Package MAKETS_PG

CREATE OR REPLACE
PACKAGE makets_pg IS
   -- пакет работы с макетами
   -- дата создания 31/10/2002 (Калак С. С.)
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура вставки макета
 PROCEDURE ins_m(
  an_nprocedure     NUMBER, --ид процедуры
  av_vname          VARCHAR2, --Имя макета
  av_vnote          VARCHAR2, --Коментарий
  an_nblock         NUMBER, --Блокировка
  an_ncycle         NUMBER, --Выполнять невыполненые вовремя
  an_shift          NUMBER, --Сдвиг старта формирования мин
  av_param          VARCHAR2, --Параметр
  an_nmaket     OUT NUMBER --Ид макета
                          );
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура вставки группы
 PROCEDURE ins_g(
  an_nmaket     NUMBER, --Ид макета
  av_vcode      VARCHAR2, --Код строки
  av_vname      VARCHAR2, --Имя грруппы
  av_vnote      VARCHAR2, --Коментарий
  an_ngroup OUT NUMBER --Ид группы
                      );
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура вставки точки
 PROCEDURE chg_p(
  an_ngroup NUMBER, --Ид группы
  an_mid    NUMBER, --Мид точки
  an_nkc    NUMBER, --Коэффициент вхождения
  an_ntype  NUMBER --Тип измерений
                  );
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура обновления макета
 PROCEDURE upd_m(
  an_nmaket     NUMBER, --Ид макета
  an_nprocedure NUMBER, --ид процедуры
  av_vname      VARCHAR2, --Имя макета
  av_vnote      VARCHAR2, --Коментарий
  an_nblock     NUMBER, --Блокировка
  an_ncycle     NUMBER, --Выполнять невыполненые вовремя
  an_shift      NUMBER, --Сдвиг старта формирования мин
  av_param      VARCHAR2 --Параметр
                        );
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура обновления группы
 PROCEDURE upd_g(
  an_ngroup NUMBER, --Ид группы
  an_nmaket NUMBER, --Ид макета
  av_vcode  VARCHAR2, --Код строки
  av_vname  VARCHAR2, --Имя грруппы
  av_vnote  VARCHAR2 --Коментарий
                    );
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура удаления макета
 PROCEDURE del_m(an_nmaket NUMBER --Ид макета
                                 );
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура удаления группы
 PROCEDURE del_g(an_ngroup NUMBER --Ид группы
                                 );
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура удаления точки
 PROCEDURE del_p(
    an_mid NUMBER, --Ид точки
    an_ngroup NUMBER --Ид группы
                );
------------------------------------------------------------------------------------------------------------------------
END; -- Package Specification MAKETS_PG
/

-- End of DDL script for MAKETS_PG

-- Start of DDL script for MAXHOURS_PG
-- Generated 27-янв-03  11:33:16 am
-- from oe-RYDA:1

-- Package MAXHOURS_PG

CREATE OR REPLACE
PACKAGE maxhours_pg IS
   -- пакет работы с часами макс нагрузки
   -- дата создания 30/07/2002 (Сечин А.А.)
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура вставки
 PROCEDURE ins_p(
  ad_date_time         DATE, --Дата ввода в действие
  ad_morning_start     DATE, --Утро нач
  ad_morning_end       DATE, --Утро кон
  ad_evening_start     DATE, --Вечер нач
  ad_evening_end       DATE, --Вечер кон
  an_maxhour_id    OUT NUMBER --Ид
                             );
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура обновления данных
 PROCEDURE upd_p(
  an_maxhour_id    NUMBER, --Ид
  ad_date_time     DATE, --Дата ввода в действие
  ad_morning_start DATE, --Утро нач
  ad_morning_end   DATE, --Утро кон
  ad_evening_start DATE, --Вечер нач
  ad_evening_end   DATE --Вечер кон
                       );
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура удаления данных
 PROCEDURE del_p(an_maxhour_id NUMBER --Ид
                                     );
------------------------------------------------------------------------------------------------------------------------
END; -- Package Specification MAXHOURS_PG
/

-- End of DDL script for MAXHOURS_PG

-- Start of DDL script for PLSQL1_PG
-- Generated 27-янв-03  11:33:16 am
-- from oe-RYDA:1

-- Package PLSQL1_PG

CREATE OR REPLACE
PACKAGE PLSQL1_PG IS
  ------------------------------------------------------------------------------------------------------------------------
    -- пакет по созданию отчетов на PL/SQL
    -- дата создания 29/11/2002 Сечин А.А.
 ------------------------------------------------------------------------------------------------------------------------
--Трехстолбцовый график нагрузки
 PROCEDURE report1_p;
--Трафик сеансов связи
 PROCEDURE report2_p;
--Отчет L (профиль) LG_LOADPROF
 PROCEDURE report3_p;
--Отчет L (листинг показаний) LG_READOUT
 PROCEDURE report4_p;
--Суточный график потребления активной и реактивной мощности
 PROCEDURE report5_p;
--Потребление группы
 PROCEDURE report6_p;
--Подекадный расход с нарастающим итогом
 PROCEDURE report7_p;
--Макет 30817
 PROCEDURE report8_p;
--Макет 1010
 PROCEDURE report9_p;
 --Типа 30817 за несколько дней
 PROCEDURE report10_p;
--Текущая мощность (KSS)
 PROCEDURE report11_p;
--Показания приборов учёта (KSS)
 PROCEDURE report12_p;
--Первичная информация УСД ИТЕК (получасовой расход) (KSS)  an_type = 1
--Первичная информация УСД ИТЕК (суточный расход) (KSS)     an_type = 2
--Первичная информация УСД ИТЕК (месячный расход) (KSS)     an_type = 3
 PROCEDURE report13_p(an_type NUMBER);
--Подекадный расход с нарастающим итогом (по группам)
 PROCEDURE report14_p;
--Недопустимые расхождения при верификации
 PROCEDURE report15_p;
------------------------------------------------------------------------------------------------------------------------
END; -- Package Specification PLSQL1_PG
/

-- End of DDL script for PLSQL1_PG

-- Start of DDL script for PLSQL2_PG
-- Generated 27-янв-03  11:33:16 am
-- from oe-RYDA:1

-- Package PLSQL2_PG

CREATE OR REPLACE
PACKAGE PLSQL2_PG
  IS
--
-- Purpose: Отчет. Почасовой расход активной энергии. Периметр АК "Харьковоблэнерго"
--
-- MODIFICATION HISTORY
-- SDM         6/12/02  Comments
-- ---------   -------  ------------------------------------------
gn_Amount NUMBER := 999999999; -- Чтобы увеличить размер ячейки, выводящей расход, небходимо добавить 9
gb_DBMS_output BOOLEAN := false;

FUNCTION vSortName_f(an_Gid IN NUMBER, an_StartGid IN NUMBER) RETURN VARCHAR2;
PRAGMA RESTRICT_REFERENCES (vSortName_f, WNDS, WNPS);

FUNCTION vName_f(an_Gid IN NUMBER, an_Mid IN NUMBER, av_Name IN VARCHAR2) RETURN VARCHAR2;
PRAGMA RESTRICT_REFERENCES (vName_f, WNDS, WNPS);

--type cur_t is ref cursor;

CURSOR gcur_Groups IS
    select * from
        (
        select
         level nlev,
         rowNum nRN,
         Name vNo,
         rpad(PLSQL2_PG.vName_f(gid, mid, Name),35) vName,
         mid,
         gn_Amount nTotal,
         gn_Amount n1,
         gn_Amount n2,
         gn_Amount n3,
         gn_Amount n4,
         gn_Amount n5,
         gn_Amount n6,
         gn_Amount n7,
         gn_Amount n8,
         gn_Amount n9,
         gn_Amount n10,
         gn_Amount n11,
         gn_Amount n12,
         gn_Amount n13,
         gn_Amount n14,
         gn_Amount n15,
         gn_Amount n16,
         gn_Amount n17,
         gn_Amount n18,
         gn_Amount n19,
         gn_Amount n20,
         gn_Amount n21,
         gn_Amount n22,
         gn_Amount n23,
         gn_Amount n24,
         100.00 nFullness,
         PLSQL2_PG.vSortName_f(gid, filereport_pg.gn_group) vSortName,
         inverted
        from groups
        connect by prior gid = parent-- and prior gid <> :an_StartGid
        start with gid = filereport_pg.gn_group --name = 'Харьковская область'----  --  --20477 --20696
        ) t,
        (select 1 vSort from dual union all select 2 from dual)
        order by vSort, vSortName;

TYPE TT_Groups IS TABLE OF gcur_Groups%ROWTYPE INDEX BY BINARY_INTEGER;

PROCEDURE rep1_p;

FUNCTION tmain_f RETURN TT_Groups;

END;
/

-- End of DDL script for PLSQL2_PG

-- Start of DDL script for PLSQL3_PG
-- Generated 27-янв-03  11:33:16 am
-- from oe-RYDA:1

-- Package PLSQL3_PG

CREATE OR REPLACE
PACKAGE PLSQL3_PG IS
  ------------------------------------------------------------------------------------------------------------------------
    -- пакет по созданию отчетов на PL/SQL
    -- дата создания 29/11/2002 Сечин А.А.
 ------------------------------------------------------------------------------------------------------------------------
--Верификация LG и ИТЕК
 PROCEDURE report1_p;
------------------------------------------------------------------------------------------------------------------------
END; -- Package Specification PLSQL3_PG
/

-- End of DDL script for PLSQL3_PG

-- Start of DDL script for POINTCALC_PG
-- Generated 27-янв-03  11:33:16 am
-- from oe-RYDA:1

-- Package POINTCALC_PG

CREATE OR REPLACE
Package POINTCALC_PG IS
/*В данном пакете сосредоточены функции вызываемые обычно либо клиентом, либо процедурами
  получения отчетов. В расчете (из значимых) используется лишь функция ss.POINTCALC_PG.F_Waste1
  Некоторые функции, в целях оптимизации используют глбальные переменные тела собственного пакета.
  Другие глобальные переменные не используются*/
---------------------------------------------------------------------------------------------
  TYPE TR_PoterCoef IS --Вспомогательный тип используется для укладки потерь либо расхода по точке
        RECORD (Z NUMBER, --незонная информация
                Z1 NUMBER, --информация по 1-й зоне
                Z2 NUMBER, --информация по 2-й зоне
                Z3 NUMBER, --информация по 3-й зоне
                H NUMBER,  --коэф отопительного сезона
                D NUMBER); --коэф вхождения точки в группу
---------------------------------------------------------------------------------------------
   FUNCTION F_GetTypePot(an_Point IN NUMBER) RETURN VARCHAR2;
   PRAGMA RESTRICT_REFERENCES (F_GetTypePot, WNDS,WNPS);
   --F_GetTypePot - возвращает тип потерь по точке an_Point в периоде an_Period ('%','Фп','%2','Ф','Н')
   PROCEDURE P_SetPoterCoef(an_RezNew IN OUT TR_PoterCoef,an_Coef IN NUMBER);
   PRAGMA RESTRICT_REFERENCES (P_SetPoterCoef, WNDS);
   /*P_SetPoterCoef - вспомогательная функция. Прописывает все поля в an_RezNew значениями an_Coef*/
   FUNCTION F_ProvVar1(an_PARALLELCONNECTION NUMBER) RETURN NUMBER;
   --F_ProvVar1 - Вспомогательная, используется при расчете потерь
   PRAGMA RESTRICT_REFERENCES (F_ProvVar1, WNDS, WNPS);
---------------------------------------------------------------------------------------------
   PROCEDURE P_GetSharesConsumption(an_ParallelConnection NUMBER,an_mid NUMBER,
                                 an_AccPeriod NUMBER,an_SA IN OUT NUMBER,an_SR IN OUT NUMBER);
   --P_GetSharesConsumption - Вспомогательная, используется при расчете потерь
   PRAGMA RESTRICT_REFERENCES (P_GetSharesConsumption, WNDS, WNPS);

   FUNCTION F_GetParallelProc(an_PARALLELCONNECTION NUMBER,an_AccPeriod NUMBER,an_CurrentT0 NUMBER) RETURN NUMBER;
   PRAGMA RESTRICT_REFERENCES (F_GetParallelProc, WNDS, WNPS);
   --F_GetParallelProc - Вспомогательная, используется при расчете потерь

   PROCEDURE F_GetPoterNew(lr_PoterTemp IN OUT TR_PoterCoef, an_mid IN NUMBER,an_Act IN NUMBER,
                            an_AccPeriod IN NUMBER,an_PotrebOnly IN NUMBER);
   PRAGMA RESTRICT_REFERENCES (F_GetPoterNew, WNDS);
   /*F_GetPoterNew - Вычисляет потери по формуле, либо считает расход по точке
     (в зависимости от an_PotrebOnly). Результат кладет в lr_PoterTemp. Функция вспомогательная
     и вызывается из POINTCALC_PG.F_Waste1
     Переменные:
       lr_PoterTemp IN OUT TR_PoterCoef - То, что ищем
       an_mid IN NUMBER - Ид. Точки
       an_Act IN NUMBER - (=1 - актив
                           иначе - реактив)
       an_AccPeriod IN NUMBER - Отчетный период
       an_PotrebOnly IN NUMBER - (=1 - считаем только расход
                                  иначе - считаем потери)*/
   FUNCTION F_Waste(an_AccPeriod IN NUMBER,an_mid IN NUMBER,av_Zone IN VARCHAR2,an_Act IN NUMBER) RETURN NUMBER;   --Потери самые новые
   PRAGMA RESTRICT_REFERENCES (F_Waste, WNDS);
   /*F_Waste - Является основной функцией получения потерь по точке в заданном периоде по заданному
                типу измерений по заданной зоне
     Переменные:
       an_AccPeriod IN NUMBER - Отчетный период YYYYMM
       an_mid IN NUMBER - Ид. Точки
       av_Zone IN VARCHAR2 - Зона ('A'-пик,'B'-день,'C'-ночь, иначе без зон)
       an_Act IN NUMBER - (=1 - актив
                           иначе - реактив)
        RETURN NUMBER - Потери по точке*/
---------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
   PROCEDURE P_DayGetSharesConsumption(an_ParallelConnection NUMBER,an_mid NUMBER,
                                 an_Day NUMBER,an_SA IN OUT NUMBER,an_SR IN OUT NUMBER);
   --P_DayGetSharesConsumption - Вспомогательная, используется при расчете потерь
   PRAGMA RESTRICT_REFERENCES (P_DayGetSharesConsumption, WNDS, WNPS);

   FUNCTION F_DayGetParallelProc(an_PARALLELCONNECTION NUMBER,an_Day NUMBER,an_CurrentT0 NUMBER) RETURN NUMBER;
   PRAGMA RESTRICT_REFERENCES (F_DayGetParallelProc, WNDS, WNPS);
   --F_DayGetParallelProc - Вспомогательная, используется при расчете потерь

   PROCEDURE F_DayGetPoterNew(lr_PoterTemp IN OUT TR_PoterCoef, an_mid IN NUMBER,an_Act IN NUMBER,
                            an_Day IN NUMBER,an_PotrebOnly IN NUMBER);
   PRAGMA RESTRICT_REFERENCES (F_DayGetPoterNew, WNDS);
   /*F_DayGetPoterNew - Вычисляет потери по формуле, либо считает расход по точке
     (в зависимости от an_PotrebOnly). Результат кладет в lr_PoterTemp. Функция вспомогательная
     и вызывается из POINTCALC_PG.F_Waste1
     Переменные:
       lr_PoterTemp IN OUT TR_PoterCoef - То, что ищем
       an_mid IN NUMBER - Ид. Точки
       an_Act IN NUMBER - (=1 - актив
                           иначе - реактив)
       an_AccPeriod IN NUMBER - Отчетный период
       an_PotrebOnly IN NUMBER - (=1 - считаем только расход
                                  иначе - считаем потери)*/
   FUNCTION F_DayWaste(an_Day IN NUMBER,an_mid IN NUMBER,av_Zone IN VARCHAR2,an_Act IN NUMBER) RETURN NUMBER;   --Потери самые новые
   PRAGMA RESTRICT_REFERENCES (F_DayWaste, WNDS);
   /*F_DayWaste - Является основной функцией получения потерь по точке в заданном периоде по заданному
                типу измерений по заданной зоне
     Переменные:
       an_Day IN NUMBER - День YYYYMMDD
       an_mid IN NUMBER - Ид. Точки
       av_Zone IN VARCHAR2 - Зона ('A'-пик,'B'-день,'C'-ночь, иначе без зон)
       an_Act IN NUMBER - (=1 - актив
                           иначе - реактив)
        RETURN NUMBER - Потери по точке*/
---------------------------------------------------------------------------------------------------
END; -- Package spec
/

-- End of DDL script for POINTCALC_PG

-- Start of DDL script for RANDOM
-- Generated 27-янв-03  11:33:16 am
-- from oe-RYDA:1

-- Package RANDOM

CREATE OR REPLACE
package random is
--
function rndint(r in number) return number;
pragma restrict_references (rndint, wnds);
--
function rndflt return number;
pragma restrict_references (rndflt, wnds);
--
end;
/

-- End of DDL script for RANDOM

-- Start of DDL script for RATES_PG
-- Generated 27-янв-03  11:33:16 am
-- from oe-RYDA:1

-- Package RATES_PG

CREATE OR REPLACE
Package RATES_PG
  IS
  -- тарификация по режимным суткам
  -- дата создания 23.04.2002 (Коваленко А.С.)
------------------------------------------------------------------------------------------------------------------------
  -- Процедура расчета коэффициентов тарифных зон по режимным суткам
PROCEDURE CalcRatesCoef(
 av_date VARCHAR2 --Дата режимных суток
 );
PROCEDURE SetEndTime;
  -- Расстановка значений EndTime в таблице Rates
  -- дата создания 18.11.2002 (Вештак)
END;
/

-- End of DDL script for RATES_PG

-- Start of DDL script for REPORTGROUPS_PG
-- Generated 27-янв-03  11:33:16 am
-- from oe-RYDA:1

-- Package REPORTGROUPS_PG

CREATE OR REPLACE
PACKAGE reportgroups_pg
IS
  -- пакет работы с отчетными группами
  -- дата создания 14/10/2001 (Сечин А.А.)
------------------------------------------------------------------------------------------------------------------------
  -- Процедура вставки
 PROCEDURE ins_p(
  an_parent          NUMBER,--Ид родителя
  av_name            VARCHAR2,--Название
  an_grouptype       NUMBER,--Ид типа группы
  av_groupkind       VARCHAR2,--Вид группы Главная или Состовляющая
  an_procedure       NUMBER,--Ид процедуры
  an_department      NUMBER,--Ид подразделения
  an_id              NUMBER,--Ид точки
  an_coef            NUMBER,--Коэф вхождения точки
  an_reportgroup OUT NUMBER--Ид группы
                           );
------------------------------------------------------------------------------------------------------------------------
  -- Процедура обновления данных
 PROCEDURE upd_p(
  an_reportgroup NUMBER,--Ид группы
  an_parent      NUMBER,--Ид родителя
  av_name        VARCHAR2,--Название
  an_grouptype   NUMBER,--Ид типа группы
  av_groupkind   VARCHAR2,--Вид группы Главная или Состовляющая
  an_procedure   NUMBER,--Ид процедуры
  an_department  NUMBER,--Ид подразделения
  an_id          NUMBER,--Ид точки
  an_coef        NUMBER--Коэф вхождения точки
                       );
------------------------------------------------------------------------------------------------------------------------
  -- Процедура удаления данных
 PROCEDURE del_p(
  an_reportgroup NUMBER--Ид группы
                       );
------------------------------------------------------------------------------------------------------------------------
END;-- Package Specification reportgroups_pg
/

-- End of DDL script for REPORTGROUPS_PG

-- Start of DDL script for REPORTS1_PG
-- Generated 27-янв-03  11:33:16 am
-- from oe-RYDA:1

-- Package REPORTS1_PG

CREATE OR REPLACE
PACKAGE reports1_pg IS
  ------------------------------------------------------------------------------------------------------------------------
    -- пакет по созданию отчетов в файл
    -- дата создания 27/07/2002 Сечин А.А.
 ------------------------------------------------------------------------------------------------------------------------
 --Макет 1010
 PROCEDURE m1010_p(an_maket NUMBER, ad_date DATE, av_fname IN OUT VARCHAR2);
------------------------------------------------------------------------------------------------------------------------
 --Макет 30817
 PROCEDURE m30817_p(an_maket NUMBER, ad_date DATE, av_fname IN OUT VARCHAR2);
------------------------------------------------------------------------------------------------------------------------
 --LastSave
 PROCEDURE LastSave_p(an_maket NUMBER, ad_date DATE, av_fname IN OUT VARCHAR2);
------------------------------------------------------------------------------------------------------------------------
END; -- Package Specification REPORTS1_PG
/

-- End of DDL script for REPORTS1_PG

-- Start of DDL script for SWITCHES_PG
-- Generated 27-янв-03  11:33:16 am
-- from oe-RYDA:1

-- Package SWITCHES_PG

CREATE OR REPLACE
Package switches_pg
  IS
    -- пакет работы с переключениями ов
    -- дата создания 02/12/2002 (Коваленко А.С)
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура вставки
 PROCEDURE ins_p(
  an_switch                NUMBER, --Ид ОВ
  ad_switch                DATE,   --Дата переключения
  an_mid                   NUMBER, --Ид точки
  an_erm                   NUMBER, --Показание ОВ
  an_edm                   NUMBER, --Показание ОВ
  an_q1m                   NUMBER, --Показание ОВ
  an_q2m                   NUMBER, --Показание ОВ
  an_q3m                   NUMBER, --Показание ОВ
  an_q4m                   NUMBER, --Показание ОВ
  an_user_id               NUMBER, --Ид пользователя
  an_id               OUT NUMBER --Ид строки
                                 );
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура обновления данных
 PROCEDURE upd_p(
  an_id                   NUMBER, --Ид строки
  an_switch                NUMBER, --Ид ОВ
  ad_switch                DATE,   --Дата переключения
  an_mid                   NUMBER, --Ид точки
  an_erm                   NUMBER, --Показание ОВ
  an_edm                   NUMBER, --Показание ОВ
  an_q1m                   NUMBER, --Показание ОВ
  an_q2m                   NUMBER, --Показание ОВ
  an_q3m                   NUMBER, --Показание ОВ
  an_q4m                   NUMBER, --Показание ОВ
  an_user_id               NUMBER --Ид пользователя
                             );
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура удаления данных
 PROCEDURE del_p(an_id NUMBER --Ид строки
                              );

 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура расчета
 PROCEDURE meterings (
an_switch   number,
ad_switch   date,
time1 out  varchar2,
er1 out     varchar2,
ed1 out     varchar2,
q11 out     varchar2,
q21 out     varchar2,
q31 out     varchar2,
q41 out     varchar2,
time2 out  varchar2,
er2 out     varchar2,
ed2 out     varchar2,
q12 out     varchar2,
q22 out     varchar2,
q32 out     varchar2,
q42 out     varchar2
 );

END; -- Package Specification SWITCHES_PG
/

-- End of DDL script for SWITCHES_PG

-- Start of DDL script for UTIL_PG
-- Generated 27-янв-03  11:33:16 am
-- from oe-RYDA:1

-- Package UTIL_PG

CREATE OR REPLACE
PACKAGE util_pg IS
 ------------------------------------------------------------------------------------------------------------------------
   -- пакет общего назначения
   -- дата создания 29/07/2002 Сечин А.А.
 ------------------------------------------------------------------------------------------------------------------------
 /*Работа с декадами*/
 --Отсечение даты до декады
 FUNCTION truncdec(d DATE)
  RETURN DATE;
 PRAGMA restrict_references(truncdec, WNDS, WNPS);
 --Вычисление декады
 FUNCTION getdec(d DATE)
  RETURN NUMBER;
 PRAGMA restrict_references(getdec, WNDS, WNPS);
 --Добавление декады
 FUNCTION add_dec(d DATE, i INTEGER)
  RETURN DATE;
 PRAGMA restrict_references(add_dec, WNDS, WNPS);
 ------------------------------------------------------------------------------------------------------------------------
 --Отсечение до получасовок
 FUNCTION trunchh24_2(d DATE)
  RETURN DATE;
 PRAGMA restrict_references(trunchh24_2, WNDS, WNPS);
 ------------------------------------------------------------------------------------------------------------------------
  --Возвращает Ид заказчика
 FUNCTION get_customer_id
  RETURN NUMBER;
 PRAGMA restrict_references(get_customer_id, WNDS, WNPS);
 ------------------------------------------------------------------------------------------------------------------------
  --Возвращает значение долга по группе
 FUNCTION get_group_debt(an_id NUMBER, an_restr NUMBER)
  RETURN NUMBER;
 PRAGMA restrict_references(get_group_debt, WNDS, WNPS);
 ------------------------------------------------------------------------------------------------------------------------
  --Возвращает 1, если есть данные по точке
 FUNCTION is_point_have_data(an_mid NUMBER)
  RETURN NUMBER;
 PRAGMA restrict_references(is_point_have_data, WNDS, WNPS);
 ------------------------------------------------------------------------------------------------------------------------
 --Оборачивает расход (для вычисления расхода по показаниям)
 FUNCTION indicoverturn(an_val NUMBER, an_len NUMBER)
  RETURN NUMBER;
 PRAGMA restrict_references(indicoverturn, WNDS, WNPS);
 ------------------------------------------------------------------------------------------------------------------------
 FUNCTION getpointid(an_point NUMBER)
  RETURN NUMBER;
 PRAGMA restrict_references(getpointid, WNDS, WNPS);
 ------------------------------------------------------------------------------------------------------------------------
 --Переворот прием отдача
 FUNCTION sld(an_mid NUMBER, an_1 NUMBER, an_2 NUMBER)
  RETURN NUMBER;
 PRAGMA restrict_references(sld, WNDS, WNPS);
 ------------------------------------------------------------------------------------------------------------------------
 --Необходимость переворота прием отдача
  FUNCTION needchdr_f(an_mid NUMBER) RETURN NUMBER;
 PRAGMA restrict_references(needchdr_f, WNDS, WNPS);
 ------------------------------------------------------------------------------------------------------------------------
 -- Процедуры обращения
 PROCEDURE chdr(an_mid NUMBER, a IN OUT NUMBER, b IN OUT NUMBER);
 PROCEDURE chdr(an_mid NUMBER, a IN OUT NUMBER, b IN OUT NUMBER, c IN OUT NUMBER, d IN OUT NUMBER);
 PROCEDURE chdr(
  an_mid        NUMBER,
  a      IN OUT NUMBER,
  b      IN OUT NUMBER,
  c      IN OUT NUMBER,
  d      IN OUT NUMBER,
  e      IN OUT NUMBER,
  f      IN OUT NUMBER);
 ------------------------------------------------------------------------------------------------------------------------
  --длиное название точки
 FUNCTION get_pointname(an_mid NUMBER, an_detal NUMBER) --0 только имя, 1 - имя и П.С., 2 - все
  RETURN VARCHAR2;
 PRAGMA restrict_references(get_pointname, WNDS, WNPS);
 ------------------------------------------------------------------------------------------------------------------------
 PROCEDURE f_preparesortbyl_n;
 ------------------------------------------------------------------------------------------------------------------------
    --F_SortGroupByL_N - Для задач возвращает порядок сортировки
 FUNCTION f_sorttaskbyl_n(an_needread NUMBER, an_id NUMBER,an_start NUMBER)
  RETURN NUMBER;
 PRAGMA restrict_references(f_sorttaskbyl_n, WNDS);
------------------------------------------------------------------------------------------------------------------------
-- Возвращает показания счетчика (рассчет показаний производится на основании
-- месячных или показаний занесенных в таблицу MAN_IMP_HHOUR показаний,
-- путем прибавление пролучасовых расходов)
-- параметр an_etype может принимать значения:
-- 1 - erm
-- 2 - edm
-- 3 - q1m
-- 4 - q2m
-- 5 - q3m
-- 6 - q4m
-- параметр an_meterage_table может принимать значения:
-- 1 - man_inp_hhour
-- 2 - months
-- 3 - billorg
 FUNCTION get_meterage(an_mid NUMBER, ad_date DATE, an_etype NUMBER, an_meterage_table NUMBER)
  RETURN NUMBER;
 PRAGMA restrict_references(get_meterage, WNDS, WNPS);
------------------------------------------------------------------------------------------------------------------------
END; -- Package Specification UTIL_PG
/

-- End of DDL script for UTIL_PG

-- Start of DDL script for ARROUND_M3017
-- Generated 27-янв-03  11:33:31 am
-- from oe-RYDA:1

-- Procedure ARROUND_M3017

CREATE OR REPLACE
Procedure      ARROUND_M3017 (nmaket_ number, repdate date, av_fname IN OUT VARCHAR2)
  IS
--
-- Purpose: Формирование М3081 с переносом остатков округлений
--
-- MODIFICATION HISTORY
-- Person      Date    Comments
-- ---------   ------  -------------------------------------------
-- Вештак      30.12.02
cursor lc_maketgroups is
  select ngroup, vcode from maketgroups where nmaket = nmaket_;
lv_str          varchar2(1000);
i               number;
nsign_          number;
groupcode_      number;
subgroupcode_   number;
ntemp           number;

BEGIN
  delete from makettemp;
  insert into makettemp (groupcode, subgroupcode, nsign)
    select groupcode, subgroupcode, nsign from maketformulas
    where nmaket = nmaket_;
  update makettemp m set groupcode = (select ngroup from maketgroups where nmaket = nmaket_ and vcode = m.groupcode);
  update makettemp m set subgroupcode = (select ngroup from maketgroups where nmaket = nmaket_ and vcode = m.subgroupcode);

  delete from M30817;
  insert into M30817 (ngroup, hour, kWh, err) select ngroup, 0, 0, 0 from maketgroups where nmaket = nmaket_
  and ngroup not in (select groupcode from makettemp);
  insert into M30817 (ngroup, hour, kWh)
    select p.ngroup, to_char(date_time-1/1440,'hh24')+1,  sum(nkc*(nvl(ed,0)-nvl(er,0))) from maketgroups g, maketpoints p, halfhour h
    where g.nmaket = nmaket_
    and g.ngroup not in (select groupcode from makettemp)
    and p.ngroup = g.ngroup and h.mid = p.mid
    and h.date_time > trunc(repdate)
    and h.date_time <= trunc(repdate)+1
    group by p.ngroup, to_char(date_time-1/1440,'hh24');

  for i in 1..24 loop
    insert into M30817 (ngroup, hour, kWh, err)
    (select ngroup, i, 0, 0 from M30817 where hour = 0
     minus
     select ngroup, i, 0, 0 from M30817 where hour = i);
  end loop;

  for i in 1..24 loop
    update M30817 m set (kWh, err) =
      (select round(a.kWh/1000 + b.err), a.kWh/1000+b.err-round(a.kWh/1000 + b.err) from M30817 a, M30817 b
       where a.ngroup = b.ngroup and a.hour = b.hour+1 and a.ngroup = m.ngroup and a.hour = i)
     where hour = i;
  end loop;

  for i in 0..24 loop
    insert into M30817 (ngroup, hour, kWh)
      select ngroup, i, 0 from maketgroups where nmaket = nmaket_
      and ngroup in (select groupcode from makettemp);
  end loop;

  loop
    begin
      select groupcode, subgroupcode, nsign into groupcode_, subgroupcode_, nsign_
      from makettemp where subgroupcode not in (select groupcode from makettemp)
      and rownum = 1;
      exception when no_data_found then exit;
    end;

    for i in 1..24 loop
      begin
        select nsign_ * kWh into ntemp from M30817 where ngroup = subgroupcode_ and hour = i;
        exception when no_data_found then ntemp := 0;
      end;
      update M30817 set kWh = kWh + ntemp where ngroup = groupcode_ and hour = i;
    end loop;
/*
    update M30817 m set kWh =
      (select m.kWh + nsign_ * nvl(kWh, 0) from M30817 mm
      where ngroup = subgroupcode_
      and hour = m.hour)
    where ngroup = groupcode_;
*/
    delete from makettemp where groupcode = groupcode_ and subgroupcode = subgroupcode_;
  end loop;

  update M30817 m set kWh = (select sum(kwh) from M30817 where ngroup = m.ngroup) where hour = 0;

  file_pg.out_p('((//30817:'|| TO_CHAR(repdate, 'MMDD') || ':000107:++');

  for lc in lc_maketgroups loop
    lv_str := lc.vcode || ':';
    for i in 0..24 loop
      begin
        select lv_str || kWh || ':' into lv_str from M30817 where ngroup = lc.ngroup and hour = i;
      exception when no_data_found then lv_str := lv_str || ':';
      end;
    end loop;
    file_pg.out_p(lv_str);
  end loop;

  file_pg.out_p('==))');




/*
  delete from M30817;
  insert into M30817 (ngroup, hour, kWh, err) select ngroup, 0, 0, 0 from maketgroups where nmaket = nmaket_;
  insert into M30817 (ngroup, hour, kWh)
    select p.ngroup, to_char(date_time-1/1440,'hh24')+1,  sum(nkc*(nvl(ed,0)-nvl(er,0))) from maketgroups g, maketpoints p, halfhour h
    where g.nmaket = nmaket_ and p.ngroup = g.ngroup and h.mid = p.mid
    and h.date_time > trunc(repdate)
    and h.date_time <= trunc(repdate)+1
    group by p.ngroup, to_char(date_time-1/1440,'hh24');

  for i in 1..24 loop
    update M30817 m set (kWh, err) =
      (select round(a.kWh/1000 + b.err), a.kWh/1000+b.err-round(a.kWh/1000 + b.err) from M30817 a, M30817 b
       where a.ngroup = b.ngroup and a.hour = b.hour+1 and a.ngroup = m.ngroup and a.hour = i)
     where hour = i;
  end loop;
  update M30817 m set kWh = (select sum(kwh) from M30817 where ngroup = m.ngroup) where hour = 0;
-- comment begin
  delete from makettemp;
  insert into makettemp (groupcode, subgroupcode, nsign)
    select groupcode, subgroupcode, nsign from maketformulas
    where nmaket = nmaket_;
  update makettemp m set groupcode = (select ngroup from maketgroups where nmaket = nmaket_ and vcode = m.groupcode);
  update makettemp m set subgroupcode = (select ngroup from maketgroups where nmaket = nmaket_ and vcode = m.subgroupcode);
  update M30817 m set kWh =
    (select sum(kWh*nsign) from M30817 mm, makettemp t
     where t.groupcode = m.ngroup and mm.ngroup = t.subgroupcode and mm.hour = m.hour), err = -1
  where ngroup in (select groupcode from makettemp);
-- comment end

  file_pg.out_p('((//30817:'|| TO_CHAR(repdate, 'MMDD') || ':000107:++');

  for lc in lc_maketgroups loop
    lv_str := lc.vcode || ':';
    for i in 0..24 loop
      begin
        select lv_str || kWh || ':' into lv_str from M30817 where ngroup = lc.ngroup and hour = i;
      exception when no_data_found then lv_str := lv_str || ':';
      end;
    end loop;
    file_pg.out_p(lv_str);
  end loop;

  file_pg.out_p('==))');
*/
  EXCEPTION
    WHEN OTHERS THEN
    RAISE;

END; -- Procedure ARROUND_M3017
/

-- End of DDL script for ARROUND_M3017

-- Start of DDL script for CHECKHALFHOUR
-- Generated 27-янв-03  11:33:31 am
-- from oe-RYDA:1

-- Procedure CHECKHALFHOUR

CREATE OR REPLACE
Procedure      CHECKHALFHOUR
      IS
-- Переносит получасоки из временной таблицы в Halfhour
-- попутно расставляя код источника данных (основной, дубль и т.п.)
-- дублируя записи ОВ на замещаемые точки
--
-- MODIFICATION HISTORY
-- Person      Date      Comments
-- ---------   --------  -------------------------------------------
-- Вештак      04.12.02

  destmid   number;
  canal_    number;
  src       number;
  prevsrc   number;
  sum1      number;
  rowid_    rowid;
  nexceptcalc_ number;

  shift     number;
  exchange_allowed number;
  alarm     number;

BEGIN
  shift := 7*60;
  for c in (select * from halfhourtmp) loop
    select  canal, nvl(nswitch, 0) into canal_, destmid from feeders
    where mid = c.mid;
    if c.nsource = 20 and canal_ > 50000000 then src := 20;
    else src := 10; end if;  -- по коду нити и связному номеру определяем дубль / не дубль
    if destmid <> 0 then
      begin
        select nvl(mid, 0) into destmid from switches
        where  nswitch = c.mid and dswitch <= c.date_time
        group by mid, dswitch having dswitch = max(dswitch);
      exception
        when others then destmid := 0;
      end;
    end if;  -- если это ОВ, то выбираем id точки переключения и 0, если ОВ сам на себя

    nexceptcalc_ := 0;  -- предполагаем включение в расчет
    if destmid <> 0 then
      nexceptcalc_ := 1;
    end if;  -- для переключенных ОВ включение в расчет не предполагается

    prevsrc := 0;
    begin
      select rowid, nsource, nvl(er,0)+nvl(ed,0)+nvl(q1,0)+nvl(q3,0)
      into rowid_, prevsrc, sum1 from halfhourold
      where mid = c.mid and date_time = c.date_time and nsource =
      (select min(nsource) from halfhourold where mid = c.mid and date_time = c.date_time
       and nexceptcalc is null);
    exception
      when others then
        prevsrc := 0;
    end;
/*
    exchange_allowed := 0;  -- запрещается подмена основными дублирующих, если время уже ушло
    if (c.date_time > trunc(sysdate) + shift * 1/1440)
    or ((c.date_time > trunc(sysdate) - 1) and (c.date_time <= trunc(sysdate) + shift * 1/1440)) then
      exchange_allowed := 1;
    end if;
*/  exchange_allowed := 1;

    -- проставляем метку включения в расчет для основного источника
    alarm := 0;
    if src = 10 then
      if prevsrc = 10 then   -- по основному уже есть запись
        src := 11;  nexceptcalc_ := 1;  alarm := 10000;  -- вставка двух точек ПН на одно время
      elsif  prevsrc = 20 then  -- уже есть дубль
        if exchange_allowed = 1 and nexceptcalc_ = 0 then
          update halfhourold set nexceptcalc = 1 where rowid = rowid_;
        end if;
      elsif  prevsrc = 30 or prevsrc = 40 then  -- ОВ
        if sum1 = 0 then nexceptcalc_ := 1;
        else nexceptcalc_ := 0; alarm := 10010;  end if; -- перехлест ПН по точке и ОВ
      elsif  prevsrc = 50 or prevsrc = 60 then  -- уже есть расчет по ручному
        if exchange_allowed = 1 and nexceptcalc_ = 0 then
          update halfhourold set nexceptcalc = 1 where rowid = rowid_;
        end if;
      end if;
    else     -- протаскиваем дублирующий
      if prevsrc = 10 then   -- по основному уже есть запись
        nexceptcalc_ := 1;
      elsif  prevsrc = 20 then  -- уже есть дубль
        src := 21;  nexceptcalc_ := 1;  alarm := 10000;  -- вставка двух точек ПН на одно время
      elsif  prevsrc = 30 or prevsrc = 40 then  -- ОВ
        if sum1 = 0 then nexceptcalc_ := 1;
        else nexceptcalc_ := 0; alarm := 10010;  end if; -- перехлест ПН по точке и ОВ
      elsif  prevsrc = 50 or prevsrc = 60 then  -- уже есть расчет по ручному
        if exchange_allowed = 1 and nexceptcalc_ = 0 then
          update halfhourold set nexceptcalc = 1 where rowid = rowid_;
        end if;
      end if;
    end if;

    if nexceptcalc_ = 0 then nexceptcalc_ := null; end if;
    insert into halfhourold (mid, date_time, nsource, er, ed, q1, q2, q3, q4, status, nexceptcalc)
    values (c.mid, c.date_time, src, c.er, c.ed, c.q1, c.q2, c.q3, c.q4, c.status, nexceptcalc_);

    if destmid <> 0 then -- дублируем данные по ОВ на точку
      if src = 10 then src := 30; else src := 40; end if;
      begin
        select rowid, nsource, nvl(er,0)+nvl(ed,0)+nvl(q1,0)+nvl(q3,0)
        into rowid_, prevsrc, sum1 from halfhourold
        where mid = destmid and date_time = c.date_time and nsource =
        (select min(nsource) from halfhourold where mid = destmid and date_time = c.date_time
         and nexceptcalc is null);
      exception
      when others then
        prevsrc := 0;
      end;
      nexceptcalc_ := 0;
      if src = 30 then
        if prevsrc = 10 then   -- по основному уже есть запись
          if sum1 <> 0 then alarm := 10010;  end if; -- перехлест ПН по точке и ОВ
        elsif  prevsrc = 20 then  -- уже есть дубль
          if sum1 <> 0 then alarm := 10010;  end if; -- перехлест ПН по точке и ОВ
        elsif  prevsrc = 30 then  -- ОВ
          src := 31;  nexceptcalc_ := 0;  alarm := 10000;  -- вставка двух точек ПН на одно время
        elsif  prevsrc = 40 then
          if exchange_allowed = 1 and nexceptcalc_ = 0 then
            update halfhourold set nexceptcalc = 1 where rowid = rowid_;
          end if;
        elsif  prevsrc = 50 then  -- уже есть расчет по ручному
          if exchange_allowed = 1 and nexceptcalc_ = 0 then
            update halfhourold set nexceptcalc = 1 where rowid = rowid_;
          end if;
        end if;
      else     -- протаскиваем дублирующий
        if prevsrc = 10 then   -- по основному уже есть запись
          if sum1 <> 0 then alarm := 10010;  end if; -- перехлест ПН по точке и ОВ
        elsif  prevsrc = 20 then  -- уже есть дубль
          if sum1 <> 0 then alarm := 10010;  end if; -- перехлест ПН по точке и ОВ
        elsif  prevsrc = 30 then  -- ОВ
          nexceptcalc_ := 1;  alarm := 10000;  -- вставка двух точек ПН на одно время
        elsif  prevsrc = 40 then
          src := 41;  nexceptcalc_ := 0;  alarm := 10000;  -- вставка двух точек ПН на одно время
        elsif  prevsrc = 50 then  -- уже есть расчет по ручному
          if exchange_allowed = 1 and nexceptcalc_ = 0 then
            update halfhourold set nexceptcalc = 1 where rowid = rowid_;
          end if;
        end if;
      end if;

      if nexceptcalc_ = 0 then nexceptcalc_ := null; end if;
      insert into halfhourold (mid, date_time, nsource, nswitch, er, ed, q1, q2, q3, q4, status, nexceptcalc)
      values (destmid, c.date_time, src, c.mid, c.er, c.ed, c.q1, c.q2, c.q3, c.q4, c.status, nexceptcalc_);

    end if;
  end loop;

  delete from halfhourtmp;

--EXCEPTION
  --  WHEN others THEN
    --  null;
END; -- Procedure CHECKHALFHOUR
/

-- End of DDL script for CHECKHALFHOUR

-- Start of DDL script for CLEANTABLES
-- Generated 27-янв-03  11:33:32 am
-- from oe-RYDA:1

-- Procedure CLEANTABLES

CREATE OR REPLACE
PROCEDURE CLEANTABLES
IS
-------------------------------------------------------------
 i      INTEGER;
 j      INTEGER;
 ld_min DATE;
 lv_sql VARCHAR2(10000);
 lv_err VARCHAR2(2000);
-------------------------------------------------------------

-------------------- Архивация -----------------------------------------
lv_ArchDir VARCHAR2(1000);
lv_ArchFlag VARCHAR2(1);
li_RowNum INTEGER;
lf_ArchFile UTL_FILE.FILE_TYPE;
lv_FileName VARCHAR2(20);
lv_empt VARCHAR(2);
CURSOR cr_profile
IS
SELECT MID, to_char(DATE_TIME,'dd.mm.yyyy hh24:mi:ss') dt, ER, Q1, ED, Q3, Q2, Q4, FREQ, COSF, VOLT, CURRENTO, VOLT2, VOLT3,
       CURR2, CURR3, ERM, Q1M, EDM, Q3M, Q2M, Q4M FROM PROFILE WHERE date_time < ld_min ORDER BY DATE_TIME;

CURSOR cr_halfhour
IS
SELECT MID, to_char(DATE_TIME,'dd.mm.yyyy hh24:mi:ss') dt, ER, Q1, ED, Q3, Q2, Q4, ERM, Q1M, EDM, Q3M, Q2M, Q4M
FROM HALFHOUR WHERE date_time < ld_min ORDER BY DATE_TIME;

CURSOR cr_bill
IS
SELECT MID, to_char(DATE_TIME,'dd.mm.yyyy hh24:mi:ss') dt, VALID, SOURCE, REMARK, ER_MTRSN,
       ER_KC, ERM, ER, AERM, AER, BERM, BER, CERM, CER, DERM, DER, Q1_MTRSN, Q1_KC, Q1M, Q1, AQ1M, AQ1, BQ1M, BQ1, CQ1M,
       CQ1, DQ1M, DQ1, ED_MTRSN, ED_KC, EDM, ED, AEDM, AED, BEDM, BED, CEDM, CED, DEDM, DED, Q3_MTRSN, Q3_KC, Q3M, Q3, AQ3M,
       AQ3, BQ3M, BQ3, CQ3M, CQ3, DQ3M, DQ3, Q2_MTRSN, Q2_KC, Q2M, Q2, AQ2M, AQ2, BQ2M, BQ2, CQ2M, CQ2, DQ2M, DQ2, Q4_MTRSN,
       Q4_KC, Q4M, Q4, AQ4M, AQ4, BQ4M, BQ4, CQ4M, CQ4, DQ4M, DQ4, NWASTEABS FROM BILL WHERE date_time < ld_min ORDER BY DATE_TIME;
-------------------------------------------------------------------------

 CURSOR cr_tables
 IS
  SELECT UPPER(table_name) name, trunc(sysdate) - term term
    FROM db_term
   ORDER BY 1;
-------------------------------------------------------------
 FUNCTION existtable(
  av_tablename VARCHAR2)
  RETURN BOOLEAN
 IS
  ln_count NUMBER;
 BEGIN
  SELECT count(*)
    INTO ln_count
    FROM dual
   WHERE EXISTS(SELECT *
                  FROM user_tables
                 WHERE table_name = av_tablename);
  IF ln_count > 0 THEN
   RETURN true;
  END IF;
  RETURN false;
 END;
-------------------------------------------------------------
BEGIN
 lv_empt := ''''||'''';
 i := sys.DBMS_SQL.open_cursor;
 IF i IS NULL THEN
  RAISE CURSOR_ALREADY_OPEN;
 END IF;
 sys.DBMS_SQL.parse(i, 'ALTER SESSION SET NLS_TERRITORY = CIS NLS_LANGUAGE = RUSSIAN NLS_NUMERIC_CHARACTERS = ''.,''',
                    sys.DBMS_SQL.native);
 j := sys.DBMS_SQL.execute(i);
 FOR lc IN cr_tables LOOP
  lv_err := lc.name;
  IF existtable(lc.name) THEN
   lv_sql := ' SELECT min(date_time) FROM ' || lc.name;
   sys.DBMS_SQL.parse(i, lv_sql, sys.DBMS_SQL.v7);
   sys.DBMS_SQL.define_column(i, 1, ld_min);
   j := sys.DBMS_SQL.execute(i);
   LOOP
    IF sys.DBMS_SQL.fetch_rows(i) = 0 THEN
     EXIT;
    END IF;
    DBMS_SQL.column_value(i, 1, ld_min);
    IF ld_min + 2 > lc.term THEN
     ld_min := lc.term;
    ELSE
     ld_min := ld_min + 2;
    END IF;
   END LOOP;
--------------------------------- Архивация -------------------------------
         li_RowNum := 1;
         lv_FileName := to_char(ld_min, 'hh24ddmmyyyy');
         IF UTL_FILE.IS_OPEN(lf_ArchFile) THEN
            UTL_FILE.FCLOSE(lf_ArchFile);
         END IF;
         IF lc.name = 'PROFILE' THEN
           SELECT VValue INTO lv_ArchFlag FROM parameter WHERE npid=4;
           SELECT VValue INTO lv_ArchDir FROM parameter WHERE npid=5;
           lv_FileName := lv_FileName||'.prf';
           IF lv_ArchFlag = 1 THEN
              FOR cr_p IN cr_profile LOOP
                IF li_RowNum = 1 THEN
                  lf_ArchFile := UTL_FILE.FOPEN(lv_ArchDir, lv_FileName, 'w');
                END IF;
                UTL_FILE.PUT_LINE(lf_ArchFile, cr_p.MID||', to_date('||''''||cr_p.dt||''''||','||''''||'dd.mm.yyyy hh24:mi:ss'||''''||'), '||
                                  nvl(to_char(cr_p.ER),lv_empt)||', '||nvl(to_char(cr_p.Q1),lv_empt)||', '||nvl(to_char(cr_p.ED),lv_empt)||', '||
                                  nvl(to_char(cr_p.Q3),lv_empt)||', '||nvl(to_char(cr_p.Q2),lv_empt)||', '||
                                  nvl(to_char(cr_p.Q4),lv_empt)||', '||nvl(to_char(cr_p.FREQ),lv_empt)||', '||nvl(to_char(cr_p.COSF),lv_empt)||', '||
                                  nvl(to_char(cr_p.VOLT),lv_empt)||', '||nvl(to_char(cr_p.CURRENTO),lv_empt)||', '||nvl(to_char(cr_p.VOLT2),lv_empt)||', '||
                                  nvl(to_char(cr_p.VOLT3),lv_empt)||', '||nvl(to_char(cr_p.CURR2),lv_empt)||', '||nvl(to_char(cr_p.CURR3),lv_empt)||', '||
                                  nvl(to_char(cr_p.ERM),lv_empt)||', '||nvl(to_char(cr_p.Q1M),lv_empt)||', '||nvl(to_char(cr_p.EDM),lv_empt)||', '||
                                  nvl(to_char(cr_p.Q3M),lv_empt)||', '||nvl(to_char(cr_p.Q2M),lv_empt)||', '||nvl(to_char(cr_p.Q4M),lv_empt));
                li_RowNum := li_RowNum+1;
              END LOOP;
              UTL_FILE.FCLOSE(lf_ArchFile);
           END IF;
         END IF;

         IF lc.name = 'HALFHOUR' THEN
           SELECT VValue INTO lv_ArchFlag FROM parameter WHERE npid=6;
           SELECT VValue INTO lv_ArchDir FROM parameter WHERE npid=7;
           lv_FileName := lv_FileName||'.hor';
           IF lv_ArchFlag = 1 THEN
              FOR cr_h IN cr_halfhour LOOP
                IF li_RowNum = 1 THEN
                  lf_ArchFile := UTL_FILE.FOPEN(lv_ArchDir, lv_FileName, 'w');
                END IF;
                UTL_FILE.PUT_LINE(lf_ArchFile, cr_h.MID||', to_date('||''''||cr_h.dt||''''||','||''''||'dd.mm.yyyy hh24:mi:ss'||''''||'), '||
                                  nvl(to_char(cr_h.ER),lv_empt)||', '||nvl(to_char(cr_h.Q1),lv_empt)||', '||nvl(to_char(cr_h.ED),lv_empt)||', '||
                                  nvl(to_char(cr_h.Q3),lv_empt)||', '||nvl(to_char(cr_h.Q2),lv_empt)||', '||nvl(to_char(cr_h.Q4),lv_empt)||', '||
                                  nvl(to_char(cr_h.ERM),lv_empt)||', '||nvl(to_char(cr_h.Q1M),lv_empt)||', '||nvl(to_char(cr_h.EDM),lv_empt)||', '||
                                  nvl(to_char(cr_h.Q3M),lv_empt)||', '||nvl(to_char(cr_h.Q2M),lv_empt)||', '||nvl(to_char(cr_h.Q4M),lv_empt));
                li_RowNum := li_RowNum+1;
              END LOOP;
              UTL_FILE.FCLOSE(lf_ArchFile);
           END IF;
         END IF;
         IF lc.name = 'BILL' THEN
           SELECT VValue INTO lv_ArchFlag FROM parameter WHERE npid=8;
           SELECT VValue INTO lv_ArchDir FROM parameter WHERE npid=9;
           lv_FileName := lv_FileName||'.bil';
           IF lv_ArchFlag = 1 THEN
              FOR cr_b IN cr_bill LOOP
                IF li_RowNum = 1 THEN
                  lf_ArchFile := UTL_FILE.FOPEN(lv_ArchDir, lv_FileName, 'w');
                END IF;
                UTL_FILE.PUT_LINE(lf_ArchFile, cr_b.MID||', to_date('||''''||cr_b.dt||''''||','||''''||'dd.mm.yyyy hh24:mi:ss'||''''||'), '||
                                  ''''||cr_b.VALID||''''||', '||''''||cr_b.SOURCE||''''||', '||''''||cr_b.REMARK||''''||', '||
                                  ''''||cr_b.ER_MTRSN||''''||', '||nvl(to_char(cr_b.ER_KC),lv_empt)||', '||nvl(to_char(cr_b.ERM),lv_empt)||', '||
                                  nvl(to_char(cr_b.ER),lv_empt)||', '||nvl(to_char(cr_b.AERM),lv_empt)||', '||nvl(to_char(cr_b.AER),lv_empt)||', '||
                                  nvl(to_char(cr_b.BERM),lv_empt)||', '||nvl(to_char(cr_b.BER),lv_empt)||', '||nvl(to_char(cr_b.CERM),lv_empt)||', '||
                                  nvl(to_char(cr_b.CER),lv_empt)||', '||nvl(to_char(cr_b.DERM),lv_empt)||', '||nvl(to_char(cr_b.DER),lv_empt)||', '||
                                  ''''||cr_b.Q1_MTRSN||''''||', '||nvl(to_char(cr_b.Q1_KC),lv_empt)||', '||nvl(to_char(cr_b.Q1M),lv_empt)||', '||
                                  nvl(to_char(cr_b.Q1),lv_empt)||', '||nvl(to_char(cr_b.AQ1M),lv_empt)||', '||nvl(to_char(cr_b.AQ1),lv_empt)||', '||
                                  nvl(to_char(cr_b.BQ1M),lv_empt)||', '||nvl(to_char(cr_b.BQ1),lv_empt)||', '||nvl(to_char(cr_b.CQ1M),lv_empt)||', '||
                                  nvl(to_char(cr_b.CQ1),lv_empt)||', '||nvl(to_char(cr_b.DQ1M),lv_empt)||', '||nvl(to_char(cr_b.DQ1),lv_empt)||', '||
                                  ''''||cr_b.ED_MTRSN||''''||', '||nvl(to_char(cr_b.ED_KC),lv_empt)||', '||nvl(to_char(cr_b.EDM),lv_empt)||', '||
                                  nvl(to_char(cr_b.ED),lv_empt)||', '||nvl(to_char(cr_b.AEDM),lv_empt)||', '||nvl(to_char(cr_b.AED),lv_empt)||', '||
                                  nvl(to_char(cr_b.BEDM),lv_empt)||', '||nvl(to_char(cr_b.BED),lv_empt)||', '||nvl(to_char(cr_b.CEDM),lv_empt)||', '||
                                  nvl(to_char(cr_b.CED),lv_empt)||', '||nvl(to_char(cr_b.DEDM),lv_empt)||', '||nvl(to_char(cr_b.DED),lv_empt)||', '||
                                  ''''||cr_b.Q3_MTRSN||''''||', '||nvl(to_char(cr_b.Q3_KC),lv_empt)||', '||nvl(to_char(cr_b.Q3M),lv_empt)||', '||
                                  nvl(to_char(cr_b.Q3),lv_empt)||', '||nvl(to_char(cr_b.AQ3M),lv_empt)||', '||nvl(to_char(cr_b.AQ3),lv_empt)||', '||
                                  nvl(to_char(cr_b.BQ3M),lv_empt)||', '||nvl(to_char(cr_b.BQ3),lv_empt)||', '||nvl(to_char(cr_b.CQ3M),lv_empt)||', '||
                                  nvl(to_char(cr_b.CQ3),lv_empt)||', '||nvl(to_char(cr_b.DQ3M),lv_empt)||', '||nvl(to_char(cr_b.DQ3),lv_empt)||', '||
                                  ''''||cr_b.Q2_MTRSN||''''||', '||nvl(to_char(cr_b.Q2_KC),lv_empt)||', '||nvl(to_char(cr_b.Q2M),lv_empt)||', '||
                                  nvl(to_char(cr_b.Q2),lv_empt)||', '||nvl(to_char(cr_b.AQ2M),lv_empt)||', '||nvl(to_char(cr_b.AQ2),lv_empt)||', '||
                                  nvl(to_char(cr_b.BQ2M),lv_empt)||', '||nvl(to_char(cr_b.BQ2),lv_empt)||', '||nvl(to_char(cr_b.CQ2M),lv_empt)||', '||
                                  nvl(to_char(cr_b.CQ2),lv_empt)||', '||nvl(to_char(cr_b.DQ2M),lv_empt)||', '||nvl(to_char(cr_b.DQ2),lv_empt)||', '||
                                  ''''||cr_b.Q4_MTRSN||''''||', '||nvl(to_char(cr_b.Q4_KC),lv_empt)||', '||nvl(to_char(cr_b.Q4M),lv_empt)||', '||
                                  nvl(to_char(cr_b.Q4),lv_empt)||', '||nvl(to_char(cr_b.AQ4M),lv_empt)||', '||nvl(to_char(cr_b.AQ4),lv_empt)||', '||
                                  nvl(to_char(cr_b.BQ4M),lv_empt)||', '||nvl(to_char(cr_b.BQ4),lv_empt)||', '||nvl(to_char(cr_b.CQ4M),lv_empt)||', '||
                                  nvl(to_char(cr_b.CQ4),lv_empt)||', '||nvl(to_char(cr_b.DQ4M),lv_empt)||', '||nvl(to_char(cr_b.DQ4),lv_empt)||', '||
                                  nvl(to_char(cr_b.NWASTEABS),lv_empt));
                li_RowNum := li_RowNum+1;
              END LOOP;
              UTL_FILE.FCLOSE(lf_ArchFile);
           END IF;
         END IF;
---------------------------------------------------------------------------
   lv_sql := 'DELETE FROM ' || lc.name || ' WHERE date_time < :ld_min ';
   sys.DBMS_SQL.parse(i, lv_sql, sys.DBMS_SQL.v7);
   sys.DBMS_SQL.bind_variable(i, ':ld_min', ld_min);
   j := sys.DBMS_SQL.execute(i);
  END IF;
 END LOOP;
 sys.DBMS_SQL.close_cursor(i);
 INSERT INTO jobs
             (njob,date_time)
      VALUES(1,sysdate);
 COMMIT;
EXCEPTION
 WHEN OTHERS THEN
  ROLLBACK;
  IF UTL_FILE.IS_OPEN(lf_ArchFile) THEN
      UTL_FILE.FCLOSE(lf_ArchFile);
  END IF;
  lv_err := lv_err || ': ' || SqlErrM;
  INSERT INTO jobs
              (njob,date_time, errortext)
       VALUES(1,sysdate, lv_err);
  COMMIT;
  IF sys.DBMS_SQL.is_open(i) THEN
   sys.DBMS_SQL.close_cursor(i);
  END IF;
END;
/

-- End of DDL script for CLEANTABLES

-- Start of DDL script for GETHALFHOUR_P
-- Generated 27-янв-03  11:33:32 am
-- from oe-RYDA:1

-- Procedure GETHALFHOUR_P

CREATE OR REPLACE
Procedure GETHALFHOUR_P IS
ln_count_day NUMBER default 5;
ld_start_date DATE default to_date('15.08.2001','DD.MM.YYYY');
cursor lcur_sel is
select * from bill where
mid in (1052,1053,1038,1039,1054,1055,1056,1057,1058,1059,1060,1201) and
date_time between ld_start_date-ln_count_day and ld_start_date;
ln_ser NUMBER;
ln_sq1 NUMBER;
ln_sq3 NUMBER;
ln_rer NUMBER;
ln_rq1 NUMBER;
ln_rq3 NUMBER;
BEGIN
 delete from halfhour
 where mid in (1052,1053,1038,1039,1054,1055,1056,1057,1058,1059,1060,1201)
 and date_time<=ld_start_date;
 FOR lc IN lcur_sel LOOP
  ln_ser:=0; ln_sq1:=0; ln_sq3:=0;
  FOR i IN 0..47 LOOP
   IF i=47 THEN
    ln_rer:=greatest(lc.er-ln_ser,0);
    ln_rQ1:=greatest(lc.Q1-ln_sQ1,0);
    ln_rQ3:=greatest(lc.Q3-ln_sQ3,0);
   ELSE
    ln_rer:=((4+2*random.rndflt)/5)*lc.er/48;
    ln_rq1:=((4+2*random.rndflt)/5)*lc.q1/48;
    ln_rq3:=((4+2*random.rndflt)/5)*lc.q3/48;
   END IF;
   IF ln_ser+ln_rer>lc.er THEN
    ln_rer:=greatest(lc.er-ln_ser,0);
   END IF;
   IF ln_sQ1+ln_rQ1>lc.Q1 THEN
    ln_rQ1:=greatest(lc.Q1-ln_sQ1,0);
   END IF;
   IF ln_sQ3+ln_rQ3>lc.Q3 THEN
    ln_rQ3:=greatest(lc.Q3-ln_sQ3,0);
   END IF;
   insert into halfhour(mid,date_time,er,q1,q3)
   values(lc.mid,lc.date_time-i/48,Round(ln_rer,11),Round(ln_rq1,11),Round(ln_rq3,11));
   ln_ser:=ln_ser+Round(ln_rer,11);
   ln_sq1:=ln_sq1+Round(ln_rq1,11);
   ln_sq3:=ln_sq3+Round(ln_rq3,11);
  END LOOP;
 END LOOP;
EXCEPTION
 WHEN OTHERS THEN
  ROLLBACK;
  RAISE;
END;
/

-- End of DDL script for GETHALFHOUR_P

-- Start of DDL script for MAKETTEMPSOLUTION
-- Generated 27-янв-03  11:33:32 am
-- from oe-RYDA:1

-- Procedure MAKETTEMPSOLUTION

CREATE OR REPLACE
Procedure      MAKETTEMPSOLUTION
   ( nmaket_ IN number)
   IS
--
-- Purpose: Временная реализация сборок макетных строк
--
-- MODIFICATION HISTORY
-- Person      Date    Comments
-- ---------   ------  -------------------------------------------
-- Вештак      28.12.02

groupcode_  varchar2(50);
subgroupcode_  varchar2(50);
nsign_      number;
ngroup_     number;
nsubgroup_  number;

BEGIN
  delete from makettemp;
  insert into makettemp (groupcode, subgroupcode, nsign)
    select groupcode, subgroupcode, nsign from maketformulas
    where nmaket = nmaket_;
  delete from maketpoints where ngroup in (select ngroup from maketgroups
    where nmaket = nmaket_ and vcode in (select groupcode from maketformulas
    where nmaket = nmaket_));
  loop
    begin
      select groupcode, subgroupcode, nsign into groupcode_, subgroupcode_, nsign_
      from makettemp where subgroupcode not in (select groupcode from makettemp)
      and rownum = 1;
      exception when no_data_found then exit;
    end;

    select ngroup into ngroup_ from maketgroups where vcode = groupcode_ and nmaket = nmaket_;
    select ngroup into nsubgroup_ from maketgroups where vcode = subgroupcode_ and nmaket = nmaket_;

    insert into maketpoints (ngroup, mid, nkc, ntype)
      select ngroup_, mid, nsign_*nkc, ntype from maketpoints
      where ngroup = nsubgroup_;

    delete from makettemp where groupcode = groupcode_ and subgroupcode = subgroupcode_;
  end loop;

END; -- Procedure MAKETTEMPSOLUTION
/

-- End of DDL script for MAKETTEMPSOLUTION

-- Start of DDL script for MARK_CHANNELS
-- Generated 27-янв-03  11:33:32 am
-- from oe-RYDA:1

-- Procedure MARK_CHANNELS

CREATE OR REPLACE
Procedure      MARK_CHANNELS
   ( caller IN varchar2,             -- имя опросчика
     stage IN number,                -- номер фазы
     marked OUT number)              -- количество отмеченных каналов
   IS

BEGIN
    if stage = 0 then                -- фаза опроса основных каналов
      update channels set nready = null where caller_name = caller;  -- сбрасываем признак готовности по всем каналам
      delete from points where mid in (select cid from channels      -- удаляем опрошенные временные каналы точек
        where nkind = 2);
      update channels set nkind = 2 where nkind = 1;                 -- помечаем для удаления врем. каналы в след. цикле

      update channels set nready = 0, is_dead = sysdate              -- приравниваем признак готовности номеру фазы
      where caller_name = caller                                     -- у основных назаблокированных каналах,
      and nparent is null                                            -- отвечающих ограничениям по времени и дате
      and nvl(blocking, 0) = 0
      and to_char(nvl(dstart, sysdate), 'sssss') <= to_char(sysdate, 'sssss')
      and to_char(nvl(dend, sysdate), 'sssss') >= to_char(sysdate, 'sssss')
      and nvl(nday, to_char(sysdate, 'dd')) = to_char(sysdate, 'dd');

      -- восстанавливаем штатные параметры каналов у которых закончился интервал оперативного опроса
      update channels set nkind = null, dstart = dstart2, dend = dend2, cycle_tout = cycle_tout2,
      blocking = blocking2, nparent = nparent2, nnotreadcurr = nnotreadcurr2, vuser = null
      where nkind = 100 and nready is null;
    else                             -- фаза резервных каналов
      update channels set nready = stage, is_dead = sysdate           -- помечаются резервные ...
      where caller_name = caller
      and nparent in
      (select cid from channels where caller_name = caller and is_dead is not null and nready = stage-1)
      and nvl(blocking, 0) = 0
      and to_char(nvl(dstart, sysdate), 'sssss') <= to_char(sysdate, 'sssss')
      and to_char(nvl(dend, sysdate), 'sssss') >= to_char(sysdate, 'sssss')
      and nvl(nday, to_char(sysdate, 'dd')) = to_char(sysdate, 'dd');
                                     -- сбрасываются отметки пред. цикла
      update channels set nready = null where caller_name = caller and nready = stage-1;
    end if;

    -- сбрасываются отметки каналов, у которых не истекла пауза м/у опросами
    update channels c set nready = null where cid in (select mid from last_save
    where floor((sysdate-nvl(trial,sysdate-1))*86400) < c.cycle_tout);

    -- сбрасываются блокировки всех точек учета
    update chanpoint set nskip = null;
    -- устанавливаются блокировки точек учета каналов по которым считаны данные за прошлые сутки
    --              и стоит отметка "не читать текущие сутки"
    update chanpoint set nskip = 1
    where cid in (select cid from channels where nready is not null and nnotreadcurr <> 0)
    and mid in (select mid from billorg group by mid having max(date_time) >= trunc(sysdate))
    and mid in (select mid from halfhour group by mid having max(date_time) >= trunc(sysdate));
    -- устанавливаются блокировки точек с нулевыми связными номерами
    update chanpoint set nskip = 1
    where cid in (select cid from channels where protocol_id = 19 and nready is not null and nnotreadcurr <> 0)
    and mid in (select mid from feeders where canal = 0);
    -- снимается пометка с каналов, по которым нечего опрашивать
    update channels c set nready = null
    where nready is not null
    and not exists (select cid from chanpoint where cid = c.cid and nskip is null);

    commit;

    select count(*) into marked from channels where caller_name = caller and nready is not null;
    if marked = 0 and stage = 0 then return; end if;
    SYS.DBMS_ALERT.SIGNAL('CHANNELS', 'CHANNELS');
    checkhalfhour;
END; -- Procedure
/

-- End of DDL script for MARK_CHANNELS

-- Start of DDL script for MARK_EAEVENT
-- Generated 27-янв-03  11:33:32 am
-- from oe-RYDA:1

-- Procedure MARK_EAEVENT

CREATE OR REPLACE
Procedure      MARK_EAEVENT
   ( newMid IN number,
     newEv_date in date,
     newType in number,
     found OUT number)
   IS

   EvType    number;
   code number;
   message  varchar2(2000);

BEGIN
    code := 0;
    message := null;
    if newType = 0 then
      code := 1010;
      message := ' Отключение напряжения.';
    end if;
    if newType = 1 then
      code := -1010;
      message := ' Включение напряжения.';
    end if;
    if newType = 2 then
      code := -1001;
      message := ' Коррекция часов. Время до коррекции.';
    end if;
    if newType = 3 then
      code := 1001;
      message := ' Коррекция часов. Время после коррекции.';
    end if;
    if newType = 4 then
      code := 1011;
      message := ' Начало режима тестирования счетчика.';
    end if;
    if newType = 5 then
      code := 1012;
      message := ' Окончание режима тестирования счетчика.';
    end if;
    if newType = 6 then
      code := 1013;
      message := ' Сброс максимальной мощности.';
    end if;
    if newType = 255 then
      code := 1014;
      message := ' Сброс журнала событий.';
    end if;

  select evtype into EvType from EA_EVENTS where mid = newMid and evdate = newEv_date and evtype = newType;
  found := 1;

EXCEPTION
  when NO_DATA_FOUND then
    insert into Journal (date_time, mid, state_cod, state_descr) values (newEv_date, newMid, code, message);
    insert into EA_EVENTS values (newMid, newEv_date, newType);
    found := 0;
END;
-- Procedure MARK_EAEVENT
/

-- End of DDL script for MARK_EAEVENT

-- Start of DDL script for MARK_LGSTATUS
-- Generated 27-янв-03  11:33:32 am
-- from oe-RYDA:1

-- Procedure MARK_LGSTATUS

CREATE OR REPLACE
PROCEDURE mark_lgstatus(
 newmid       IN     NUMBER,
 newdate_time IN     DATE,
 newt         IN     NUMBER,
 newu         IN     NUMBER,
 news         IN     NUMBER,
 newm         IN     NUMBER,
 newkt        IN     NUMBER,
 newl1        IN OUT NUMBER,
 newl2        IN OUT NUMBER,
 newl3        IN OUT NUMBER) IS
 ld_date DATE;
 t       NUMBER;
 u       NUMBER;
 s       NUMBER;
 m       NUMBER;
 kt      NUMBER;
 l1      NUMBER;
 l2      NUMBER;
 l3      NUMBER;
 ll      NUMBER;
 code    NUMBER;
 message VARCHAR2(2000);
BEGIN
 code := 0;
 message := NULL;
 SELECT NVL(MAX(date_time), SYSDATE - 365), NVL(MAX(t), 0), NVL(MAX(u), 0), NVL(MAX(s), 0), NVL(MAX(m), 0),
        NVL(MAX(l1), 0), NVL(MAX(l2), 0), NVL(MAX(l3), 0)
   INTO ld_date, t, u, s, m,
        l1, l2, l3
   FROM lgstatus
  WHERE mid = newmid;
 SELECT NVL(nabc, 0)
   INTO ll
   FROM feeders
  WHERE mid = newmid;
 IF ll = 0 THEN -- для двухэлементных счетчиков фаза В есть всегда
  l2 := 1;
  newl2 := 1;
 END IF;
 IF newu = 0 THEN
  newl1 := l1;
  newl2 := l2;
  newl3 := l3;
 END IF;
 IF news <> s THEN
  code := -1002;
  message := ' Смена сезона.';
  INSERT INTO journal
              (date_time, mid, state_cod, state_descr)
       VALUES (newdate_time, newmid, code, message);
 END IF;
 IF newt <> 0 THEN
  code := -1001;
  message := ' Коррекция часов.';
  INSERT INTO journal
              (date_time, mid, state_cod, state_descr)
       VALUES (newdate_time, newmid, code, message);
 END IF;
 IF newm <> 0 THEN
  code := -1003;
  message := ' Проведена параметризация счетчика.';
  INSERT INTO journal
              (date_time, mid, state_cod, state_descr)
       VALUES (newdate_time, newmid, code, message);
 END IF;
 IF  newu <> u AND newu = 1 THEN
  code := -1010;
  message := ' Включение напряжения. Время простоя: ' ||
             ROUND(TO_NUMBER(newdate_time - ld_date) * 24 * 60, 2) || ' мин.';
  INSERT INTO journal
              (date_time, mid, state_cod, state_descr)
       VALUES (newdate_time, newmid, code, message);
 END IF;
 IF  newl1 <> l1 AND newl1 <> 0 AND newu <> 0 THEN
  code := -1005;
  message := ' Есть фаза А.';
  INSERT INTO journal
              (date_time, mid, state_cod, state_descr)
       VALUES (newdate_time, newmid, code, message);
 END IF;
 IF  newl2 <> l2 AND newl2 <> 0 AND newu <> 0 THEN
  code := -1005;
  message := ' Есть фаза B.';
  INSERT INTO journal
              (date_time, mid, state_cod, state_descr)
       VALUES (newdate_time, newmid, code, message);
 END IF;
 IF  newl3 <> l3 AND newl3 <> 0 AND newu <> 0 THEN
  code := -1005;
  message := ' Есть фаза C.';
  INSERT INTO journal
              (date_time, mid, state_cod, state_descr)
       VALUES (newdate_time, newmid, code, message);
 END IF;
 IF  newl1 <> l1 AND newl1 = 0 AND newu <> 0 THEN
  code := 1005;
  message := ' Нет фазы А.';
  INSERT INTO journal
              (date_time, mid, state_cod, state_descr)
       VALUES (newdate_time, newmid, code, message);
 END IF;
 IF  newl2 <> l2 AND newl2 = 0 AND newu <> 0 THEN
  code := 1005;
  message := ' Нет фазы B.';
  INSERT INTO journal
              (date_time, mid, state_cod, state_descr)
       VALUES (newdate_time, newmid, code, message);
 END IF;
 IF  newl3 <> l3 AND newl3 = 0 AND newu <> 0 THEN
  code := 1005;
  message := ' Нет фазы C.';
  INSERT INTO journal
              (date_time, mid, state_cod, state_descr)
       VALUES (newdate_time, newmid, code, message);
 END IF;
 IF  newu <> u AND newu = 0 THEN
  code := 1010;
  message := ' Отключение напряжения.';
  INSERT INTO journal
              (date_time, mid, state_cod, state_descr)
       VALUES (newdate_time, newmid, code, message);
 END IF;
 IF code <> 0 THEN
  UPDATE lgstatus
     SET date_time = newdate_time,
         t = newt,
         u = newu,
         s = news,
         m = newm,
         kt = newkt,
         l1 = newl1,
         l2 = newl2,
         l3 = newl3
   WHERE mid = newmid;
 -- insert into Journal (date_time, mid, state_cod, state_descr) values (newdate_time, newmid, code, message);
 END IF;
 UPDATE journal_c
    SET date_time = SYSDATE;
END; -- Procedure
/

-- End of DDL script for MARK_LGSTATUS

-- Start of DDL script for MARK_MESSAGES
-- Generated 27-янв-03  11:33:32 am
-- from oe-RYDA:1

-- Procedure MARK_MESSAGES

CREATE OR REPLACE
Procedure      MARK_MESSAGES
   ( caller IN varchar2)

   IS
BEGIN
  insert into journal (date_time, mid, state_cod, state_descr, submit)
    select sysdate, 1000, 6,
    caller_name || ': нет связи по каналу ' || vname,
    null
    from channels where caller_name = caller
    and nready is not null
    and is_dead is not null and was_dead is null;

  insert into journal (date_time, mid, state_cod, state_descr, submit)
    select sysdate, 1000, -102,
    caller_name || ': восстановлена связь по каналу ' || vname,
    null
    from channels where caller_name = caller
    and nready is not null
    and is_dead is null and was_dead is not null;

  -- сбрасываем дату смерти резервных каналов, если основной заработал
  update channels set was_dead = null where caller_name = caller
    and nparent in (select cid from channels where nready is not null and is_dead is null and was_dead is not null);


   update channels set was_dead = is_dead
      where caller_name = caller and nready is not null;

update journal_c set date_time = sysdate;
   commit;
END; -- Procedure
/

-- End of DDL script for MARK_MESSAGES

-- Start of DDL script for OV_SWITCHING
-- Generated 27-янв-03  11:33:32 am
-- from oe-RYDA:1

-- Procedure OV_SWITCHING

CREATE OR REPLACE
Procedure      OV_switching  IS
mid_        number;
source_     number;
date_time_  date;
temp_mid    number;
state_message varchar2(200);

cursor c1 is
  select p.mid, source, order_date from points p, alter_pts a
  where a.mid = p.mid and p.order_date < sysdate order by order_date;

BEGIN
  open c1;
  loop
    fetch c1 into mid_,  source_, date_time_;
    exit when c1%notfound;
    update profile set mid = mid_ where date_time > date_time_ and mid in
      (select mid from alter_pts where source = source_);
    update halfhour set mid = mid_ where date_time > date_time_ and mid in
      (select mid from alter_pts where source = source_);
    delete from bill where mid in (select mid from alter_pts where source = source_)
      and date_time > date_time_ and to_char(date_time, 'hh24:mi') = '23:23';
    update bill set mid = mid_ where date_time > date_time_ and mid in
      (select mid from alter_pts where source = source_);

    insert into bill (mid, date_time, er,ed, q1, q3)
      select mid, to_date(substr(to_char(date_time_,'dd.mm.yyyyy hh24:mi'),1,11)||'23:23','dd.mm.yyyy hh24:mi'), sum(nvl(er,0)),
      sum(nvl(ed,0)), sum(nvl(q1,0)), sum(nvl(q3,0))
      from halfhour where date_time > trunc(date_time_)
      and date_time <= trunc(date_time_)+1
      and mid in (select mid from alter_pts where source = source_) and mid <> mid_
      group by mid;

    insert into bill (mid, date_time, er,ed, q1, q3)
      select mid_, to_date(substr(to_char(date_time_,'dd.mm.yyyyy hh24:mi'),1,11)||'23:23','dd.mm.yyyy hh24:mi'), -sum(nvl(er,0)),
      -sum(nvl(ed,0)), -sum(nvl(q1,0)), -sum(nvl(q3,0))
      from halfhour where date_time > trunc(date_time_)
      and date_time <= trunc(date_time_)+1
      and mid in (select mid from alter_pts where source = source_) and mid <> mid_;

    select p.mid into temp_mid from points p, alter_pts a
      where p.mid=a.mid and a.source=source_ and implement_date is not null and rownum=1;

    update feeders set ov_mid=mid_ where mid=source_;
    update points set implement_date=null where mid=temp_mid;
    update points set implement_date=date_time_,
      order_date=null where mid=mid_;

    select '(КС::Перевод ОВ) Переключение присоединения '||name||' '||date_time_
      into state_message from points where mid=temp_mid;

    insert into journal (date_time,mid,state_cod,state_descr)
      values (sysdate,mid_,0,state_message);
  end loop;
  commit;
  close c1;

END; -- Procedure
/

-- End of DDL script for OV_SWITCHING

-- Start of DDL script for REPLICATOR
-- Generated 27-янв-03  11:33:32 am
-- from oe-RYDA:1

-- Procedure REPLICATOR

CREATE OR REPLACE
Procedure Replicator is
prev_date date;
prev_day  number;
prev_hh   number;
prev_mi   number;
curr_date date;
curr_day  number;
curr_hh   number;
curr_mi   number;
-- add KAS 10.10.2001
nlight_limit  number;
-- end add KAS
ld_sys date default trunc(sysdate,'MI');
begin
  update manual_pts m set curr_val =
  (select next_val from manual_pts where mid = m.mid),
  next_date = null, next_val = null
  where  next_date <= ld_sys;

-- add KAS 10.10.2001
  SELECT nvl(add_months(to_date(vvalue,'dd.mm.yyyy'),1), trunc(ld_sys)), trunc(ld_sys) INTO prev_date, curr_date FROM parameter WHERE npid = 1;
  if prev_date <= curr_date then
    loop
        if to_number(to_char(prev_date,'dd'))>15 then
          SELECT nlimit INTO nlight_limit FROM manual_light_limit WHERE nmonth = to_number(to_char(prev_date,'mm'));
        else
          SELECT nlimit INTO nlight_limit FROM manual_light_limit WHERE nmonth = to_number(to_char(add_months(prev_date,-1),'mm'));
        end if;
        -- Наружное освещение
        insert into bill (mid, date_time, er)
        (select mid, prev_date, curr_val*nlight_limit from manual_pts where curr_val is not null AND nmonth_calc = 1);
        -- Установленный расход
        insert into bill (mid, date_time, er)
        (select mid, prev_date, curr_val from manual_pts where curr_val is not null AND nmonth_calc = 2);
         prev_date := add_months(prev_date,1);
      exit when prev_date > curr_date;
    end loop;
-- Обновляем дату
    UPDATE parameter SET vvalue = to_char(add_months(prev_date,-1),'dd.mm.yyyy') WHERE npid = 1;
    COMMIT;
  end if;
-- end add KAS

  select nvl(date_time, ld_sys), ld_sys into prev_date, curr_date from manual_pts_c;
  if prev_date >= trunc(curr_date,'MI') then
    return;
  end if;

  select to_char(ld_sys, 'J'),
  floor(to_char(ld_sys, 'sssss') / 3600),
  to_char(ld_sys, 'mi'),
  to_char(nvl(date_time, ld_sys), 'J'),
  floor(to_char(nvl(date_time, ld_sys), 'sssss') / 3600),
  to_char(nvl(date_time, ld_sys), 'mi')
  into curr_day, curr_hh, curr_mi, prev_day, prev_hh, prev_mi from manual_pts_c;

--  prev_day := curr_day;
--  prev_hh := curr_hh - 1;
--  prev_mi := curr_mi;

  loop
    prev_mi := prev_mi + 1;
    if prev_mi = 60 then
      prev_mi := 0;
      prev_hh := prev_hh + 1;
      if prev_hh = 24 then
        prev_hh := 0;
        prev_day := prev_day + 1;
        insert into bill (mid, date_time, er)
        (select mid,
        to_date(prev_day || ' ' || to_char(prev_hh * 3600 + prev_mi * 60), 'J sssss'),
        curr_val * 24 from manual_pts where curr_val is not null /*add Kas*/ AND nmonth_calc = 0);
      end if;
    end if;

    if (prev_mi = 0) or (prev_mi = 30) then
      insert into halfhour (mid, date_time, er)
      (select mid,
      to_date(prev_day || ' ' || to_char(prev_hh * 3600 + prev_mi * 60), 'J sssss'),
      curr_val / 2 from manual_pts where curr_val is not null  /*add Kas*/ AND nmonth_calc = 0);
    end if;
    insert into profile (mid, date_time, er)
    (select mid, to_date(prev_day || ' ' || to_char(prev_hh * 3600 + prev_mi * 60), 'J sssss'),
    curr_val / 60 from manual_pts where curr_val is not null and profile = 1  /*add Kas*/ AND nmonth_calc = 0);

    commit;
    exit when prev_mi = curr_mi and prev_hh = curr_hh and prev_day = curr_day;
  end loop;

  update manual_pts_c set date_time =
  to_date(prev_day || ' ' || to_char(prev_hh * 3600 + prev_mi * 60), 'J sssss');

  update curr_power c set (date_time, obsolete, er) =
    (select ld_sys, 0, curr_val from manual_pts where curr_val is not null
    and profile = 1 and mid = c.mid  /*add Kas*/ AND nmonth_calc = 0)
    where mid in (select mid from manual_pts);


--update profile_c set date_time = ld_sys;
update profile_c set date_time = to_date(prev_day || ' ' || to_char(prev_hh * 3600 + prev_mi * 60), 'J sssss');
commit;
end;
/

-- End of DDL script for REPLICATOR

-- Start of DDL script for RETEHER
-- Generated 27-янв-03  11:33:32 am
-- from oe-RYDA:1

-- Procedure RETEHER

CREATE OR REPLACE
Procedure      RETEHER(DATE1 IN DATE, DATE2 IN DATE)
   IS
/*
DECLARE
LD date;
BEGIN
LD:=TO_DATE(20021002,'YYYYMMDD');
WHILE LD<=TRUNC(SYSDATE)-1 LOOP
  RETEHER(LD, LD+1);
  COMMIT;
  LD:=LD+1;
END LOOP;
END;
/
*/



BEGIN

INSERT INTO BILL_CALC (MID, DATE_TIME)
  SELECT DISTINCT MID, TRUNC(DATE_TIME) FROM BILL
  WHERE DATE_TIME > DATE1
  AND DATE_TIME <= DATE2
  AND MID IN (SELECT DISTINCT MID FROM CHANPOINT);

DELETE FROM BILL
  WHERE DATE_TIME > DATE1
  AND DATE_TIME <= DATE2
  AND MID IN (SELECT DISTINCT MID FROM CHANPOINT);

RETEIT;


END; -- Procedure
/

-- End of DDL script for RETEHER

-- Start of DDL script for RETEIT
-- Generated 27-янв-03  11:33:32 am
-- from oe-RYDA:1

-- Procedure RETEIT

CREATE OR REPLACE
Procedure      RETEIT
   IS
  date_time_ date;
  rid_ number;
BEGIN
    delete from bill where (mid, date_time) in (select mid, date_time from bill_calc);
  date_time_ := trunc(sysdate, 'cc');
  for c in (select distinct date_time from bill_calc order by date_time) loop
    if date_time_ <> c.date_time then
      date_time_ := c.date_time;
      select distinct rid into rid_ from rates where to_char(time, 'mm') =
        (select max(to_char(time, 'mm')) from rates
        where to_char(time, 'mm') <= to_char(date_time_ - 1, 'mm'));
    end if;
--insert into bill_calc values(rid_, date_time_);
        insert into bill (mid, date_time, source, er, aer, ber, cer, der,
                                              ed, aed, bed, ced, ded,
                                              q1, aq1, bq1, cq1, dq1,
                                              q2, aq2, bq2, cq2, dq2,
                                              q3, aq3, bq3, cq3, dq3,
                                              q4, aq4, bq4, cq4, dq4)
        (select mids, dates, 'Расч', sum(ers), sum(aers), sum(bers), sum(cers), sum(ders),
                                              sum(eds), sum(aeds), sum(beds), sum(ceds), sum(deds),
                                              sum(q1s), sum(aq1s), sum(bq1s), sum(cq1s), sum(dq1s),
                                              sum(q2s), sum(aq2s), sum(bq2s), sum(cq2s), sum(dq2s),
                                              sum(q3s), sum(aq3s), sum(bq3s), sum(cq3s), sum(dq3s),
                                              sum(q4s), sum(aq4s), sum(bq4s), sum(cq4s), sum(dq4s)
        from (select b.mid mids, b.date_time dates,
         er ers, decode(rate, 0, er, 0) aers, decode(rate, 1, er, 0) bers, decode(rate, 2, er, 0) cers, decode(rate, 3, er, 0) ders,
         ed eds, decode(rate, 0, ed, 0) aeds, decode(rate, 1, ed, 0) beds, decode(rate, 2, ed, 0) ceds, decode(rate, 3, ed, 0) deds,
         q1 q1s, decode(rate, 0, q1, 0) aq1s, decode(rate, 1, q1, 0) bq1s, decode(rate, 2, q1, 0) cq1s, decode(rate, 3, q1, 0) dq1s,
         q2 q2s, decode(rate, 0, q2, 0) aq2s, decode(rate, 1, q2, 0) bq2s, decode(rate, 2, q2, 0) cq2s, decode(rate, 3, q2, 0) dq2s,
         q3 q3s, decode(rate, 0, q3, 0) aq3s, decode(rate, 1, q3, 0) bq3s, decode(rate, 2, q3, 0) cq3s, decode(rate, 3, q3, 0) dq3s,
         q4 q4s, decode(rate, 0, q4, 0) aq4s, decode(rate, 1, q4, 0) bq4s, decode(rate, 2, q4, 0) cq4s, decode(rate, 3, q4, 0) dq4s
         from halfhour h, bill_calc b, rates r
         where h.mid = b.mid and b.date_time = date_time_
         and h.date_time > b.date_time - 1
         and h.date_time <= b.date_time
         and r.rid = rid_
         and to_char(h.date_time-1/1440, 'sssss') >= to_char(r.time, 'sssss')
         and to_char(h.date_time-1/1440, 'sssss') < to_char(r.endtime, 'sssss')
         ) s
         group by s.mids, s.dates);
  end loop;
  delete from bill_calc;


END; -- Procedure
/

-- End of DDL script for RETEIT

-- Start of DDL script for BILL_T
-- Generated 27-янв-03  11:33:53 am
-- from oe-RYDA:1

-- Trigger BILL_T

CREATE OR REPLACE TRIGGER bill_t
AFTER INSERT  OR UPDATE
ON bill_c
REFERENCING NEW AS NEW OLD AS OLD
BEGIN
return;
  SYS.DBMS_ALERT.SIGNAL('BILL', 'BILL');
  export_pg.setgroupexport(1);
END;
/

-- End of DDL script for BILL_T

-- Start of DDL script for CALCPTS_T
-- Generated 27-янв-03  11:33:54 am
-- from oe-RYDA:1

-- Trigger CALCPTS_T

CREATE OR REPLACE TRIGGER calcpts_t
AFTER INSERT  OR UPDATE
ON profile_c
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
Begin
return;
  calcpts_pg.StartCalc (:NEW.DATE_TIME,1);

End;
/

-- End of DDL script for CALCPTS_T

-- Start of DDL script for CALC_BILL
-- Generated 27-янв-03  11:33:54 am
-- from oe-RYDA:1

-- Trigger CALC_BILL

CREATE OR REPLACE TRIGGER calc_bill
AFTER INSERT  OR UPDATE
ON halfhourold
REFERENCING NEW AS NEW OLD AS OLD
Declare
  date_time_ date;
  rid_ number;
Begin
return;
  delete from bill where (mid, date_time) in (select mid, date_time from bill_calc);
  date_time_ := trunc(sysdate, 'cc');
  for c in (select distinct date_time from bill_calc order by date_time) loop
    if date_time_ <> c.date_time then
      date_time_ := c.date_time;
      select distinct rid into rid_ from rates where to_char(time, 'mm') =
        (select max(to_char(time, 'mm')) from rates
        where to_char(time, 'mm') <= to_char(date_time_ - 1, 'mm'));
    end if;
--insert into bill_calc values(rid_, date_time_);
        insert into bill (mid, date_time, source, er, aer, ber, cer, der,
                                              ed, aed, bed, ced, ded,
                                              q1, aq1, bq1, cq1, dq1,
                                              q2, aq2, bq2, cq2, dq2,
                                              q3, aq3, bq3, cq3, dq3,
                                              q4, aq4, bq4, cq4, dq4)
        (select mids, dates, 'Расч', sum(ers), sum(aers), sum(bers), sum(cers), sum(ders),
                                              sum(eds), sum(aeds), sum(beds), sum(ceds), sum(deds),
                                              sum(q1s), sum(aq1s), sum(bq1s), sum(cq1s), sum(dq1s),
                                              sum(q2s), sum(aq2s), sum(bq2s), sum(cq2s), sum(dq2s),
                                              sum(q3s), sum(aq3s), sum(bq3s), sum(cq3s), sum(dq3s),
                                              sum(q4s), sum(aq4s), sum(bq4s), sum(cq4s), sum(dq4s)
        from (select b.mid mids, b.date_time dates,
         er ers, decode(rate, 0, er, 0) aers, decode(rate, 1, er, 0) bers, decode(rate, 2, er, 0) cers, decode(rate, 3, er, 0) ders,
         ed eds, decode(rate, 0, ed, 0) aeds, decode(rate, 1, ed, 0) beds, decode(rate, 2, ed, 0) ceds, decode(rate, 3, ed, 0) deds,
         q1 q1s, decode(rate, 0, q1, 0) aq1s, decode(rate, 1, q1, 0) bq1s, decode(rate, 2, q1, 0) cq1s, decode(rate, 3, q1, 0) dq1s,
         q2 q2s, decode(rate, 0, q2, 0) aq2s, decode(rate, 1, q2, 0) bq2s, decode(rate, 2, q2, 0) cq2s, decode(rate, 3, q2, 0) dq2s,
         q3 q3s, decode(rate, 0, q3, 0) aq3s, decode(rate, 1, q3, 0) bq3s, decode(rate, 2, q3, 0) cq3s, decode(rate, 3, q3, 0) dq3s,
         q4 q4s, decode(rate, 0, q4, 0) aq4s, decode(rate, 1, q4, 0) bq4s, decode(rate, 2, q4, 0) cq4s, decode(rate, 3, q4, 0) dq4s
         from halfhour h, bill_calc b, rates r
         where h.mid = b.mid and b.date_time = date_time_
         and h.date_time > b.date_time - 1
         and h.date_time <= b.date_time
         and r.rid = rid_
         and to_char(h.date_time-1/1440, 'sssss') >= to_char(r.time, 'sssss')
         and to_char(h.date_time-1/1440, 'sssss') < to_char(r.endtime, 'sssss')
         ) s
         group by s.mids, s.dates);
  end loop;
  delete from bill_calc;
  return;

End;
/

-- End of DDL script for CALC_BILL

-- Start of DDL script for CHECK4CALC_BILL
-- Generated 27-янв-03  11:33:54 am
-- from oe-RYDA:1

-- Trigger CHECK4CALC_BILL

CREATE OR REPLACE TRIGGER check4calc_bill
BEFORE INSERT  OR UPDATE
ON halfhourold
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
Begin
  --if util_pg.get_customer_id <> 1 then return; end if;
return;
/*
  if inserting then
    if :new.date_time = trunc(:new.date_time) then
      insert into bill_calc values(:new.mid, :new.date_time);
    end if;
  else
    begin
      insert into bill_calc values(:new.mid, trunc(:new.date_time)+1);
    exception
      WHEN DUP_VAL_ON_INDEX THEN
        NULL;
      when others then raise;
    end;
  end if;
 return;
*/
End;
/

-- End of DDL script for CHECK4CALC_BILL

-- Start of DDL script for CURR_POWER_ARCH
-- Generated 27-янв-03  11:33:54 am
-- from oe-RYDA:1

-- Trigger CURR_POWER_ARCH

CREATE OR REPLACE TRIGGER curr_power_arch
AFTER UPDATE
ON curr_power
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
Begin
  admin_pg.curr_power_arch_ins_p(:NEW.MID,:NEW.DATE_TIME,:NEW.ER,:NEW.Q1,
  :NEW.ED,:NEW.Q3,:NEW.FREQ,:NEW.COSF,:NEW.VOLT,:NEW.CURRENTO,:NEW.VOLT2,:NEW.VOLT3,:NEW.CURR2,:NEW.CURR3);
End;
/

-- End of DDL script for CURR_POWER_ARCH

-- Start of DDL script for CURR_POWER_T
-- Generated 27-янв-03  11:33:54 am
-- from oe-RYDA:1

-- Trigger CURR_POWER_T

CREATE OR REPLACE TRIGGER curr_power_t
AFTER INSERT  OR UPDATE
ON curr_power_c
REFERENCING NEW AS NEW OLD AS OLD
begin
/*  update curr_power c set obsolete = (select decode(implement_date, null, 0, 1)
from points where mid = c.mid),
er = null, ed = null, q1 = null, q3 = null
where sysdate - date_time > 2/240;
*/
sys.dbms_alert.signal('CURR_POWER', 'CURR_POWER');
end;
/

-- End of DDL script for CURR_POWER_T

-- Start of DDL script for FISCAL_T
-- Generated 27-янв-03  11:33:54 am
-- from oe-RYDA:1

-- Trigger FISCAL_T

CREATE OR REPLACE TRIGGER fiscal_t
AFTER INSERT  OR UPDATE
ON fiscal_c
REFERENCING NEW AS NEW OLD AS OLD
BEGIN
  SYS.DBMS_ALERT.SIGNAL('FISCAL', 'FISCAL');
END;
/

-- End of DDL script for FISCAL_T

-- Start of DDL script for HALFHOUR_T
-- Generated 27-янв-03  11:33:54 am
-- from oe-RYDA:1

-- Trigger HALFHOUR_T

CREATE OR REPLACE TRIGGER halfhour_t
AFTER INSERT  OR UPDATE
ON halfhour_c
REFERENCING NEW AS NEW OLD AS OLD
BEGIN
return;
  SYS.DBMS_ALERT.SIGNAL('HALFHOUR', 'HALFHOUR');
  export_pg.setgroupexport(2);
END;
/

-- End of DDL script for HALFHOUR_T

-- Start of DDL script for HALFHOUR_UPDCURR
-- Generated 27-янв-03  11:33:54 am
-- from oe-RYDA:1

-- Trigger HALFHOUR_UPDCURR

CREATE OR REPLACE TRIGGER halfhour_updcurr
AFTER INSERT  OR UPDATE
ON halfhourold
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
Begin
 return;
 indic_pg.setpower(:new.mid,:new.date_time,:new.er,:new.ed,:new.q1,:new.q3);
End;
/

-- End of DDL script for HALFHOUR_UPDCURR

-- Start of DDL script for JOURNAL_T
-- Generated 27-янв-03  11:33:55 am
-- from oe-RYDA:1

-- Trigger JOURNAL_T

CREATE OR REPLACE TRIGGER journal_t
AFTER INSERT  OR UPDATE
ON journal_c
REFERENCING NEW AS NEW OLD AS OLD
BEGIN
return;
  SYS.DBMS_ALERT.SIGNAL('JOURNAL', 'JOURNAL');
END;
/

-- End of DDL script for JOURNAL_T

-- Start of DDL script for PROFILE_T
-- Generated 27-янв-03  11:33:55 am
-- from oe-RYDA:1

-- Trigger PROFILE_T

CREATE OR REPLACE TRIGGER profile_t
AFTER INSERT  OR UPDATE
ON profile_c
REFERENCING NEW AS NEW OLD AS OLD
BEGIN
return;
  SYS.DBMS_ALERT.SIGNAL('PROFILE', 'PROFILE');
  export_pg.setgroupexport(3);
END;
/

-- End of DDL script for PROFILE_T

-- Start of DDL script for ADMIN_PG
-- Generated 27-янв-03  11:33:59 am
-- from oe-RYDA:1

-- Package body ADMIN_PG

CREATE OR REPLACE
PACKAGE BODY admin_pg
IS
  -- пакет по администрированию АСКУЭ
  -- дата создания 12/10/2001 Сечин А.А.
------------------------------------------------------------------------------------------------------------------------
  -- Процедура установки параметров сессии;
 PROCEDURE begin_p
 IS
  ln_handle INTEGER;
  ln_ret    NUMBER;
 BEGIN
  --установка параметров сессии
  ln_handle := sys.DBMS_SQL.open_cursor;
  sys.DBMS_SQL.parse(
   ln_handle, 'ALTER SESSION SET NLS_TERRITORY = CIS NLS_LANGUAGE = RUSSIAN NLS_NUMERIC_CHARACTERS = ''.,''',
   sys.DBMS_SQL.native);
  ln_ret := sys.DBMS_SQL.EXECUTE(ln_handle);
  sys.DBMS_SQL.close_cursor(ln_handle);
 END; -- begin_p

------------------------------------------------------------------------------------------------------------------------
--процедура смены периода
 PROCEDURE changeperiod_p
 IS

---------------------------------------------
  ld_1 DATE;
  ld_2 DATE;
  ld_3 DATE;

---------------------------------------------
 BEGIN
  BEGIN
   SELECT TO_DATE(vvalue, 'dd.mm.yyyy')
     INTO ld_1
     FROM parameter
    WHERE npid = 1;
   SELECT TO_DATE(vvalue, 'dd.mm.yyyy')
     INTO ld_2
     FROM parameter
    WHERE npid = 2;
   SELECT TO_DATE(vvalue, 'dd.mm.yyyy')
     INTO ld_3
     FROM parameter
    WHERE npid = 3;
  EXCEPTION
   WHEN OTHERS THEN
    raise_application_error(-20002, 'ADMIN_PG.changeperiod_p: Ошибка заполнения таблицы PARAMETER. ');
  END;
  IF NVL(provcalc_f, 1) != 1 THEN
   raise_application_error(
    -20002, 'ADMIN_PG.changeperiod_p: В данном месяце не проведен расчет. Смена переода расчета запрещена.');
  END IF;
  UPDATE parameter
     SET vvalue = TO_CHAR(ld_3, 'dd.mm.yyyy')
   WHERE npid = 2;
  UPDATE parameter
     SET vvalue = TO_CHAR(ADD_MONTHS(ld_3, 1), 'dd.mm.yyyy')
   WHERE npid = 3;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'ADMIN_PG.changeperiod_p: Ошибка изменения периода. ' ||
                                   CHR(10) ||
                                   SQLERRM(SQLCODE));
 END; --changeperiod_p

------------------------------------------------------------------------------------------------------------------------
--процедура смены дня расчета
 PROCEDURE changecalcday_p(
  an_day NUMBER)
 IS

---------------------------------------------
  ld_3 DATE;

---------------------------------------------
 BEGIN
  SAVEPOINT changecalcday_s;
  BEGIN
   SELECT TO_DATE(vvalue, 'dd.mm.yyyy')
     INTO ld_3
     FROM parameter
    WHERE npid = 3;
  EXCEPTION
   WHEN OTHERS THEN
    raise_application_error(-20002, 'ADMIN_PG.changeperiod_p: Ошибка заполнения таблицы PARAMETER. ');
  END;
  IF    an_day IS NULL
     OR NOT (TRUNC(an_day) BETWEEN 1 AND 31) THEN
   raise_application_error(-20002, 'ADMIN_PG.changeperiod_p: Входной параметр процедуры не допустим. ');
  END IF;
  IF TO_DATE(TO_CHAR(ld_3, 'YYYYMM') * 100 +
             TRUNC(an_day), 'YYYYMMDD') <= SYSDATE THEN
   raise_application_error(-20002, 'ADMIN_PG.changeperiod_p: Изменяемая дата не может быть меньше системной. ');
  END IF;
  UPDATE parameter
     SET vvalue = TO_CHAR(TO_DATE(TO_CHAR(ld_3, 'YYYYMM') * 100 +
                                  TRUNC(an_day), 'YYYYMMDD'), 'dd.mm.yyyy')
   WHERE npid IN (1, 3);
  DELETE FROM detturnover
        WHERE nperiod = TO_NUMBER(TO_CHAR(ld_3, 'YYYYMM'));
 EXCEPTION
  WHEN OTHERS THEN
   ROLLBACK TO SAVEPOINT changecalcday_s;
   raise_application_error(-20001, 'ADMIN_PG.changecalcday_p: Ошибка дня расчета. ' ||
                                   CHR(10) ||
                                   SQLERRM(SQLCODE));
 END; --changecalcday_p

------------------------------------------------------------------------------------------------------------------------
  -- Проверка проведения расчета возвращает 1- Проведен, иначе нет
 FUNCTION provcalc_f
  RETURN NUMBER
 IS
  ln_count NUMBER;
  ld_3     DATE;
 BEGIN
  SELECT TO_DATE(vvalue, 'dd.mm.yyyy')
    INTO ld_3
    FROM parameter
   WHERE npid = 3;
  SELECT COUNT(*)
    INTO ln_count
    FROM DUAL
   WHERE EXISTS( SELECT *
                   FROM detturnover
                  WHERE nperiod = TO_NUMBER(TO_CHAR(ld_3, 'YYYYMM')));
  RETURN ln_count;
 END;

------------------------------------------------------------------------------------------------------------------------
--Запись в журнал
 PROCEDURE fiscal_p(
  an_task    NUMBER,
  an_job     NUMBER,
  av_name    VARCHAR2,
  av_message VARCHAR2)
 IS
 BEGIN
  INSERT INTO fiscal
              (date_time, task_cod, task_job, name, message)
       VALUES (SYSDATE, an_task, an_job, av_name, av_message);
 END;
------------------------------------------------------------------------------------------------------------------------
-- Управление процессами
 FUNCTION AscueProc_Start_Stop_State_f(
   an_IDProcess NUMBER,
   an_TypeOperation NUMBER)
   -- an_IDProccess = 1 - Очистка базы
   -- an_IDProccess = 2 - Репликация ручников
   -- an_IDProcess = 3 - Переключение обводных присоединений
   -- an_TypeOperation = 1 - Запуск процесса
   -- an_TypeOperation = 2 - Останов процесса
   -- an_TypeOperation = 3 - Состояние (1-Запущен/0-Остановлен)
 RETURN NUMBER -- -1 Ошибка; -2 Операция не выполнена
 IS
 ln_JobID NUMBER;
 BEGIN
 -- an_IDProcess = 1 - Очистка базы
   IF an_IDProcess=1 THEN
       select COUNT(job) into ln_JobID from user_jobs where upper(what) = upper('CLEANTABLES;');
       IF an_TypeOperation=1 THEN
         IF ln_JobID=0 THEN
           dbms_job.submit(ln_JobID, upper('CLEANTABLES;'), TRUNC(sysdate+1), 'TRUNC(sysdate) + 1');
           COMMIT;
           RETURN 1;
         END IF;
       END IF;
       IF an_TypeOperation=2 THEN
         IF ln_JobID>0 THEN
           select job into ln_JobID from user_jobs where upper(what) = upper('CLEANTABLES;');
           dbms_job.remove(ln_JobID);
           COMMIT;
           RETURN 1;
         END IF;
       END IF;
       IF an_TypeOperation=3 THEN
         select COUNT(job) into ln_JobID from user_jobs where upper(what) = upper('CLEANTABLES;');
         IF ln_JobID>0 THEN
           RETURN 1;
         ELSE
           RETURN 0;
         END IF;
       END IF;
   END IF;
   -- an_IDProcess = 2 - Репликация ручников
   IF an_IDProcess=2 THEN
       select COUNT(job) into ln_JobID from user_jobs where upper(what) = upper('Replicator;');
       IF an_TypeOperation=1 THEN
         IF ln_JobID=0 THEN
           dbms_job.submit(ln_JobID, upper('Replicator;'), sysdate+1/1440, 'sysdate + 1/1440');
           COMMIT;
           RETURN 1;
         END IF;
       END IF;
       IF an_TypeOperation=2 THEN
         IF ln_JobID>0 THEN
           select job into ln_JobID from user_jobs where upper(what) = upper('Replicator;');
           dbms_job.remove(ln_JobID);
           COMMIT;
           RETURN 1;
         END IF;
       END IF;
       IF an_TypeOperation=3 THEN
         select COUNT(job) into ln_JobID from user_jobs where upper(what) = upper('Replicator;');
         IF ln_JobID>0 THEN
           RETURN 1;
         ELSE
           RETURN 0;
         END IF;
       END IF;
   END IF;
   -- an_IDProcess = 3 - Переключение обводных присоединений
   IF an_IDProcess=3 THEN
       select COUNT(job) into ln_JobID from user_jobs where upper(what) = upper('OV_switching;');
       IF an_TypeOperation=1 THEN
         IF ln_JobID=0 THEN
           dbms_job.submit(ln_JobID, upper('OV_switching;'), sysdate + 1/1440, 'sysdate + 1/1440');
           COMMIT;
           RETURN 1;
         END IF;
       END IF;
       IF an_TypeOperation=2 THEN
         IF ln_JobID>0 THEN
           select job into ln_JobID from user_jobs where upper(what) = upper('OV_switching;');
           dbms_job.remove(ln_JobID);
           COMMIT;
           RETURN 1;
         END IF;
       END IF;
       IF an_TypeOperation=3 THEN
         select COUNT(job) into ln_JobID from user_jobs where upper(what) = upper('OV_switching;');
         IF ln_JobID>0 THEN
           RETURN 1;
         ELSE
           RETURN 0;
         END IF;
       END IF;
   END IF;
   ROLLBACK;
   RETURN -2;
   EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      raise_application_error(-20001, 'ADMIN_PG.AscueProc_Start_Stop_State_f: Ошибка при работе с процессами АСКУЭ. ' ||
                                   CHR(10) ||
                                   SQLERRM(SQLCODE));
END;

------------------------------------------------------------------------------------------------------------------------
-- Управление процессами Параметры архивации
 PROCEDURE AscueArchParam_p(
  av_ProfileFlag  IN OUT  VARCHAR2,
  av_ProfileDir  IN OUT  VARCHAR2,
  av_HalfhourFlag  IN OUT  VARCHAR2,
  av_HalfhourDir  IN OUT  VARCHAR2,
  av_BillFlag  IN OUT  VARCHAR2,
  av_BillDir  IN OUT  VARCHAR2,
  an_Flag_in_out NUMBER -- 0-Возвращает значения 1-Записывает
 )
IS
BEGIN
  IF an_Flag_in_out = 0 THEN
      SELECT vvalue INTO av_ProfileFlag FROM parameter WHERE npid = 4;
      SELECT vvalue INTO av_ProfileDir FROM parameter WHERE npid = 5;
      SELECT vvalue INTO av_HalfhourFlag FROM parameter WHERE npid = 6;
      SELECT vvalue INTO av_HalfhourDir FROM parameter WHERE npid = 7;
      SELECT vvalue INTO av_BillFlag FROM parameter WHERE npid = 8;
      SELECT vvalue INTO av_BillDir FROM parameter WHERE npid = 9;
  END IF;
  IF an_Flag_in_out = 1 THEN
      UPDATE parameter SET vvalue=av_ProfileFlag WHERE npid = 4;
      UPDATE parameter SET vvalue=av_ProfileDir WHERE npid = 5;
      UPDATE parameter SET vvalue=av_HalfhourFlag WHERE npid = 6;
      UPDATE parameter SET vvalue=av_HalfhourDir WHERE npid = 7;
      UPDATE parameter SET vvalue=av_BillFlag WHERE npid = 8;
      UPDATE parameter SET vvalue=av_BillDir WHERE npid = 9;
      COMMIT;
  END IF;
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      raise_application_error(-20001, 'ADMIN_PG.AscueArchParam_p: Ошибка при обновлении параметров. Возможно в таблице parameter не найдено нужных параметров.' ||
                                   CHR(10) ||
                                   SQLERRM(SQLCODE));
END;
------------------------------------------------------------------------------------------------------------------------
--Запись текущих данных в архив
 PROCEDURE curr_power_arch_ins_p(
an_MID      NUMBER,
ad_DATE_TIME      DATE,
an_ER      NUMBER,
an_Q1      NUMBER,
an_ED      NUMBER,
an_Q3      NUMBER,
an_FREQ      NUMBER,
an_COSF      NUMBER,
an_VOLT      NUMBER,
an_CURRENTO      NUMBER,
an_VOLT2      NUMBER,
an_VOLT3      NUMBER,
an_CURR2      NUMBER,
an_CURR3      NUMBER)
IS
ln_MinVOLT NUMBER := 96.18;
ln_MaxVOLT NUMBER := 105.525;
BEGIN
 IF an_VOLT>ln_MaxVOLT or an_VOLT<ln_MinVOLT or an_VOLT3>ln_MaxVOLT or an_VOLT3<ln_MinVOLT THEN
    INSERT INTO curr_power_arch (MID,DATE_TIME,ER,Q1,ED,Q3,FREQ,COSF,VOLT,CURRENTO,VOLT2,VOLT3,CURR2,CURR3)
    VALUES(an_MID,ad_DATE_TIME,an_ER,an_Q1,an_ED,an_Q3,an_FREQ,an_COSF,an_VOLT,an_CURRENTO,an_VOLT2,an_VOLT3,an_CURR2,an_CURR3);
  END IF;
END;
------------------------------------------------------------------------------------------------------------------------
--Запись события по компорту в log
 PROCEDURE set_comport_event_p(
an_com      NUMBER,
av_event    VARCHAR2) IS
ld_sys DATE default sysdate;
BEGIN
insert into COMPORTEVENTS(NORDER,COM_ID,DLASTEVENT,VLASTEVENT)
values(comport_seq.nextval,an_com,ld_sys,av_event);
update comports set DLASTEVENT=ld_sys,VLASTEVENT=av_event where COM_ID=an_com;
END;
------------------------------------------------------------------------------------------------------------------------
END; -- Package Body ADMIN_PG
/

-- End of DDL script for ADMIN_PG

-- Start of DDL script for ALPHA_IMP_PG
-- Generated 27-янв-03  11:33:59 am
-- from oe-RYDA:1

-- Package body ALPHA_IMP_PG

CREATE OR REPLACE
PACKAGE BODY ALPHA_IMP_PG IS
 ------------------------------------------------------------------------------------------------------------------------
    -- Интерфейс взаимодействия БД с ПО AlphaImport
    -- дата создания 10/01/2003 Чудаков И.В.

 FUNCTION consump_count_f( anCurr NUMBER, anPred NUMBER, ln_digits NUMBER, an_kc NUMBER, an_rn NUMBER )
  RETURN NUMBER IS
  lnRes NUMBER;
 BEGIN
  if
    NULL = anCurr
    or
    NULL = anPred
  then
    lnRes := NULL;
  else
    lnRes
      :=
      ROUND(util_pg.indicoverturn(anCurr - anPred, ln_digits) * an_kc, an_rn);
  end if;
  RETURN lnRes;
 END;

  --Вставка графика нагрузки
 PROCEDURE set_halfhour_Alpha_AImp
 (
   an_mid NUMBER,
   ad_date DATE,
   an_er NUMBER,
   an_ed NUMBER,
   an_q1 NUMBER,
   an_q3 NUMBER,
   av_res OUT varchar2
 )
 IS
  ln_er NUMBER DEFAULT an_er;
  ln_ed NUMBER DEFAULT an_ed;
  ln_q1 NUMBER DEFAULT an_q1;
  ln_q3 NUMBER DEFAULT an_q3;
  ld_lastsave date;
 BEGIN
  av_res := '';
  --Проверка того, за данную дату еще нет
  SELECT nvl( MAX(date_time), to_date('01.01.1900 00:00','dd.mm.yyyy hh24:mi') )
    INTO ld_lastsave
    FROM halfhourtmp
    WHERE mid = an_mid;
  if ad_date > ld_lastsave then
  --e
    util_pg.chdr(an_mid, ln_er, ln_ed, ln_q1, ln_q3);
    INSERT INTO halfhourtmp
                (mid, date_time, nsource, er, ed, q1, q3)
         VALUES (an_mid, ad_date, 10, ln_er, ln_ed, ln_q1, ln_q3);
    IF trunc(ad_date)=ad_date THEN
        checkhalfhour;
        DAS_PG.CalcOneDay4Bill(-1,trunc(ad_date)-1);
    END IF;
  else
    av_res := 'существующие показания имеют более позднюю дату.';
  end if;
 EXCEPTION
  WHEN OTHERS THEN
   RAISE;
 END;
 ------------------------------------------------------------------------------------------------------------------------
   --Вставка суточных
 PROCEDURE set_bill_Alpha_AImp(
  an_mid    NUMBER,
  ad_date   DATE,
  an_erm    NUMBER,
  an_edm    NUMBER,
  an_q1m    NUMBER,
  an_q3m    NUMBER,
  an_aerm   NUMBER,
  an_aedm   NUMBER,
  an_aq1m   NUMBER,
  an_aq3m   NUMBER,
  an_berm   NUMBER,
  an_bedm   NUMBER,
  an_bq1m   NUMBER,
  an_bq3m   NUMBER,
  an_cerm   NUMBER,
  an_cedm   NUMBER,
  an_cq1m   NUMBER,
  an_cq3m   NUMBER,
  an_derm   NUMBER,
  an_dedm   NUMBER,
  an_dq1m   NUMBER,
  an_dq3m   NUMBER,
--  av_mtrsn  VARCHAR2,
  av_res OUT VARCHAR2
  ) IS
  av_mtrsn  VARCHAR2(100);
  CURSOR lcur_sel IS
   SELECT NVL(erm, 0) erm, NVL(edm, 0) edm, NVL(q1m, 0) q1m, NVL(q3m, 0) q3m, NVL(q2m, 0) q2m, NVL(q4m, 0) q4m,
          NVL(aerm, 0) aerm, NVL(aedm, 0) aedm, NVL(aq1m, 0) aq1m, NVL(aq3m, 0) aq3m, NVL(aq2m, 0) aq2m, NVL(aq4m, 0) aq4m,
          NVL(berm, 0) berm, NVL(bedm, 0) bedm, NVL(bq1m, 0) bq1m, NVL(bq3m, 0) bq3m, NVL(bq2m, 0) bq2m, NVL(bq4m, 0) bq4m,
          NVL(cerm, 0) cerm, NVL(cedm, 0) cedm, NVL(cq1m, 0) cq1m, NVL(cq3m, 0) cq3m, NVL(cq2m, 0) cq2m, NVL(cq4m, 0) cq4m,
          NVL(derm, 0) derm, NVL(dedm, 0) dedm, NVL(dq1m, 0) dq1m, NVL(dq3m, 0) dq3m, NVL(dq2m, 0) dq2m, NVL(dq4m, 0) dq4m,
          NVL(er_mtrsn, ' ')
     FROM billorg
     WHERE mid = an_mid
      AND date_time = (SELECT MAX(date_time)
                         FROM billorg
                        WHERE mid = an_mid AND date_time < ad_date)
      --т.к. пока серийный номер не считывается AND UPPER(TRIM(er_mtrsn)) = UPPER(TRIM(av_mtrsn))
      ;
  lc       lcur_sel%ROWTYPE;
  lb_found BOOLEAN;
  ln_kc    NUMBER;
  ln_rn    NUMBER             DEFAULT 10;
  ln_erm   NUMBER             DEFAULT an_erm;
  ln_edm   NUMBER             DEFAULT an_edm;
  ln_q1m   NUMBER             DEFAULT an_q1m;
  ln_q3m   NUMBER             DEFAULT an_q3m;
  ln_aerm  NUMBER             DEFAULT an_aerm;
  ln_aedm  NUMBER             DEFAULT an_aedm;
  ln_aq1m  NUMBER             DEFAULT an_aq1m;
  ln_aq3m  NUMBER             DEFAULT an_aq3m;
  ln_berm  NUMBER             DEFAULT an_berm;
  ln_bedm  NUMBER             DEFAULT an_bedm;
  ln_bq1m  NUMBER             DEFAULT an_bq1m;
  ln_bq3m  NUMBER             DEFAULT an_bq3m;
  ln_cerm  NUMBER             DEFAULT an_cerm;
  ln_cedm  NUMBER             DEFAULT an_cedm;
  ln_cq1m  NUMBER             DEFAULT an_cq1m;
  ln_cq3m  NUMBER             DEFAULT an_cq3m;
  ln_derm  NUMBER             DEFAULT an_derm;
  ln_dedm  NUMBER             DEFAULT an_dedm;
  ln_dq1m  NUMBER             DEFAULT an_dq1m;
  ln_dq3m  NUMBER             DEFAULT an_dq3m;
  ln_er    NUMBER;
  ln_ed    NUMBER;
  ln_q1    NUMBER;
  ln_q3    NUMBER;
  ln_aer   NUMBER;
  ln_aed   NUMBER;
  ln_aq1   NUMBER;
  ln_aq3   NUMBER;
  ln_ber   NUMBER;
  ln_bed   NUMBER;
  ln_bq1   NUMBER;
  ln_bq3   NUMBER;
  ln_cer   NUMBER;
  ln_ced   NUMBER;
  ln_cq1   NUMBER;
  ln_cq3   NUMBER;
  ln_der   NUMBER;
  ln_ded   NUMBER;
  ln_dq1   NUMBER;
  ln_dq3   NUMBER;
  ld_lastsave date;
  ln_digits NUMBER;
 BEGIN
  av_res := '';
  ln_digits := -1;
  av_mtrsn := '';
  --Проверка того, за данную дату еще нет
  SELECT nvl( MAX(date_time), to_date('01.01.1900 00:00','dd.mm.yyyy hh24:mi') )
    INTO ld_lastsave
    FROM billorg
    WHERE mid = an_mid;
  if ad_date > ld_lastsave then
  --e
    OPEN lcur_sel;
    FETCH lcur_sel INTO lc;
    lb_found := lcur_sel%FOUND;
    CLOSE lcur_sel;
    IF lb_found THEN
     SELECT NVL(MAX(kc), 1)
       INTO ln_kc
       FROM feeders
      WHERE mid = an_mid;
     util_pg.chdr(an_mid, ln_erm, ln_edm, ln_q1m, ln_q3m);
     util_pg.chdr(an_mid, ln_aerm, ln_aedm, ln_aq1m, ln_aq3m);
     util_pg.chdr(an_mid, ln_berm, ln_bedm, ln_bq1m, ln_bq3m);
     util_pg.chdr(an_mid, ln_cerm, ln_cedm, ln_cq1m, ln_cq3m);
     util_pg.chdr(an_mid, ln_derm, ln_dedm, ln_dq1m, ln_dq3m);

     ln_er := consump_count_f( ln_erm, lc.erm, ln_digits, ln_kc, ln_rn );
     ln_ed := consump_count_f( ln_edm, lc.edm, ln_digits, ln_kc, ln_rn );
     ln_q1 := consump_count_f( ln_q1m, lc.q1m, ln_digits, ln_kc, ln_rn );
     ln_q3 := consump_count_f( ln_q3m, lc.q3m, ln_digits, ln_kc, ln_rn );

     ln_aer := consump_count_f( ln_aerm, lc.aerm, ln_digits, ln_kc, ln_rn );
     ln_aed := consump_count_f( ln_aedm, lc.aedm, ln_digits, ln_kc, ln_rn );
     ln_aq1 := consump_count_f( ln_aq1m, lc.aq1m, ln_digits, ln_kc, ln_rn );
     ln_aq3 := consump_count_f( ln_aq3m, lc.aq3m, ln_digits, ln_kc, ln_rn );

     ln_ber := consump_count_f( ln_berm, lc.berm, ln_digits, ln_kc, ln_rn );
     ln_bed := consump_count_f( ln_bedm, lc.bedm, ln_digits, ln_kc, ln_rn );
     ln_bq1 := consump_count_f( ln_bq1m, lc.bq1m, ln_digits, ln_kc, ln_rn );
     ln_bq3 := consump_count_f( ln_bq3m, lc.bq3m, ln_digits, ln_kc, ln_rn );

     ln_cer := consump_count_f( ln_cerm, lc.cerm, ln_digits, ln_kc, ln_rn );
     ln_ced := consump_count_f( ln_cedm, lc.cedm, ln_digits, ln_kc, ln_rn );
     ln_cq1 := consump_count_f( ln_cq1m, lc.cq1m, ln_digits, ln_kc, ln_rn );
     ln_cq3 := consump_count_f( ln_cq3m, lc.cq3m, ln_digits, ln_kc, ln_rn );

     ln_der := consump_count_f( ln_derm, lc.derm, ln_digits, ln_kc, ln_rn );
     ln_ded := consump_count_f( ln_dedm, lc.dedm, ln_digits, ln_kc, ln_rn );
     ln_dq1 := consump_count_f( ln_dq1m, lc.dq1m, ln_digits, ln_kc, ln_rn );
     ln_dq3 := consump_count_f( ln_dq3m, lc.dq3m, ln_digits, ln_kc, ln_rn );

     INSERT INTO billorg
                 (mid, er, ed, q1, q3, q2, q4, aer, aed, aq1, aq3, aq2, aq4,
                  ber, bed, bq1, bq3, bq2, bq4, cer, ced, cq1, cq3, cq2, cq4, der,
                  ded, dq1, dq3, dq2, dq4, erm, edm, q1m, q3m, q2m, q4m, aerm,
                  aedm, aq1m, aq3m, aq2m, aq4m, berm, bedm, bq1m, bq3m, bq2m, bq4m,
                  cerm, cedm, cq1m, cq3m, cq2m, cq4m, derm, dedm, dq1m, dq3m, dq2m,
                  dq4m, er_mtrsn, ed_mtrsn, q1_mtrsn, q3_mtrsn, q2_mtrsn, q4_mtrsn, date_time, source, nsource)
          VALUES (an_mid, ln_er, ln_ed, ln_q1, ln_q3, NULL, NULL, ln_aer, ln_aed, ln_aq1, ln_aq3, NULL, NULL,
                  ln_ber, ln_bed, ln_bq1, ln_bq3, NULL, NULL, ln_cer, ln_ced, ln_cq1, ln_cq3, NULL, NULL, ln_der,
                  ln_ded, ln_dq1, ln_dq3, NULL, NULL, ln_erm, ln_edm, ln_q1m, ln_q3m, NULL, NULL, ln_aerm,
                  ln_aedm, ln_aq1m, ln_aq3m, NULL, NULL, ln_berm, ln_bedm, ln_bq1m, ln_bq3m, NULL, NULL,
                  ln_cerm, ln_cedm, ln_cq1m, ln_cq3m, NULL, NULL, ln_derm, ln_dedm, ln_dq1m, ln_dq3m, NULL,
                  NULL, av_mtrsn, av_mtrsn, av_mtrsn, av_mtrsn, NULL, NULL, ad_date, 'A-import', COMSRV_PG.cn_Alpha);
    ELSE
     util_pg.chdr(an_mid, ln_erm, ln_edm, ln_q1m, ln_q3m);
     util_pg.chdr(an_mid, ln_aerm, ln_aedm, ln_aq1m, ln_aq3m);
     util_pg.chdr(an_mid, ln_berm, ln_bedm, ln_bq1m, ln_bq3m);
     util_pg.chdr(an_mid, ln_cerm, ln_cedm, ln_cq1m, ln_cq3m);
     util_pg.chdr(an_mid, ln_derm, ln_dedm, ln_dq1m, ln_dq3m);
     INSERT INTO billorg
                 (mid, erm, edm, q1m, q3m, q2m, q4m, aerm, aedm, aq1m, aq3m, aq2m,
                  aq4m, berm, bedm, bq1m, bq3m, bq2m, bq4m, cerm, cedm, cq1m, cq3m,
                  cq2m, cq4m, derm, dedm, dq1m, dq3m, dq2m, dq4m, er_mtrsn, q1_mtrsn, ed_mtrsn,
                  q3_mtrsn, q2_mtrsn, q4_mtrsn, date_time, source, nsource)
          VALUES (an_mid, ln_erm, ln_edm, ln_q1m, ln_q3m, NULL, NULL, ln_aerm, ln_aedm, ln_aq1m, ln_aq3m, NULL,
                  NULL, ln_berm, ln_bedm, ln_bq1m, ln_bq3m, NULL, NULL, ln_cerm, ln_cedm, ln_cq1m, ln_cq3m,
                  NULL, NULL, ln_derm, ln_dedm, ln_dq1m, ln_dq3m, NULL, NULL, av_mtrsn, av_mtrsn, av_mtrsn,
                  av_mtrsn, NULL, NULL, ad_date, 'A-import', COMSRV_PG.cn_Alpha);
    END IF;
   else -- усл по дате
    av_res := 'существующие показания имеют более позднюю дату.';
   end if;
 END;
 ------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
END; -- Package Body ALPHA_IMP_PG
/

-- End of DDL script for ALPHA_IMP_PG

-- Start of DDL script for AVERRATE_PG
-- Generated 27-янв-03  11:33:59 am
-- from oe-RYDA:1

-- Package body AVERRATE_PG

CREATE OR REPLACE
PACKAGE BODY averrate_pg IS
 ------------------------------------------------------------------------------------------------------------------------
   -- пакет вычисления весовых коэффициентов для получасовок в пределах суток
   -- дата создания 03/12/2002 (Чудаков И.В.)
 ------------------------------------------------------------------------------------------------------------------------
 gn_gid   constant NUMBER :=20419;
 gn_mid  NUMBER;
 gd_start DATE;
 gd_end   DATE;
 gt_1     common_pg.tt_number;
 gt_2     common_pg.tt_number;
 gt_3     common_pg.tt_number;
 gt_4     common_pg.tt_number;
 gt_5     common_pg.tt_number;
 gt_6     common_pg.tt_number;
 PROCEDURE normal_p(at_1 IN OUT common_pg.tt_number);
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура вычисления весовых коэффициентов для получасовок в пределах суток
 PROCEDURE averrate(
                                  ad_start DATE --за какие сутки проводить вычисления
                                               ) IS
  ln_er    NUMBER;
  ln_ed    NUMBER;
  ln_q1    NUMBER;
  ln_q2    NUMBER;
  ln_q3    NUMBER;
  ln_q4    NUMBER;
  ld_start DATE   DEFAULT TRUNC(ad_start);
 BEGIN
  SELECT SUM(h.er), SUM(h.ed), SUM(h.q1), SUM(h.q2), SUM(h.q3), SUM(h.q4)
    INTO ln_er, ln_ed, ln_q1, ln_q2, ln_q3, ln_q4
    FROM halfhour h
   WHERE h.mid IN (SELECT     mid
                         FROM groups p
                   CONNECT BY PRIOR gid = parent
                   START WITH gid = gn_gid)
     AND h.date_time > ld_start
     AND h.date_time <= ld_start + 1;
  DELETE FROM averrate;
  INSERT INTO averrate
              (nhh, ner, ned, nq1, nq2, nq3, nq4)
   SELECT   DECODE(
             FLOOR(TO_CHAR(h.date_time, 'sssss') / 1800), 0, 48, FLOOR(
                                                                  TO_CHAR(h.date_time, 'sssss') / 1800)),
            DECODE(ln_er, 0, 0, SUM(h.er) / ln_er),
            DECODE(ln_ed, 0, 0, SUM(h.ed) / ln_ed),
            DECODE(ln_q1, 0, 0, SUM(h.q1) / ln_q1),
            DECODE(ln_q2, 0, 0, SUM(h.q2) / ln_q2),
            DECODE(ln_q3, 0, 0, SUM(h.q3) / ln_q3),
            DECODE(ln_q4, 0, 0, SUM(h.q4) / ln_q4)
       FROM halfhour h
      WHERE h.mid IN (SELECT     mid
                            FROM groups
                      CONNECT BY PRIOR gid = parent
                      START WITH gid = gn_gid)
        AND h.date_time > ld_start
        AND h.date_time <= ld_start + 1
   GROUP BY (FLOOR(TO_CHAR(h.date_time, 'sssss') / 1800));
  COMMIT;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'AVERRATE_PG.averrate: Ошибка. ' || CHR(10) || SQLERRM(SQLCODE));
 END;
 ------------------------------------------------------------------------------------------------------------------------
   -- Функция вычисления весовых коэффициентов для получасовок в любой период
 PROCEDURE averrate_p(an_mid NUMBER, ad_start DATE, ad_end DATE) IS
  CURSOR lcur_sel IS
   SELECT   util_pg.trunchh24_2(h.date_time - 1 / 86400) dt, NVL(SUM(h.er), 0) er, NVL(SUM(h.ed), 0) ed,
            NVL(SUM(h.q1), 0) q1, NVL(SUM(h.q2), 0) q2, NVL(SUM(h.q3), 0) q3, NVL(SUM(h.q4), 0) q4
       FROM halfhour h
      WHERE h.mid IN (SELECT     mid
                            FROM groups
                      CONNECT BY PRIOR gid = parent
                      START WITH gid = gn_gid)
                      and h.mid<>an_mid
        AND h.date_time > ad_start
        AND h.date_time <= ad_end
   GROUP BY util_pg.trunchh24_2(h.date_time - 1 / 86400);
  lc     lcur_sel%ROWTYPE;
  i      NUMBER             DEFAULT 1;
  ld_tmp DATE               DEFAULT ad_start;
 BEGIN
  gn_mid := an_mid;
  gd_start := ad_start;
  gd_end := ad_end;
  gt_1.DELETE;
  gt_2.DELETE;
  gt_3.DELETE;
  gt_4.DELETE;
  gt_5.DELETE;
  gt_6.DELETE;
  OPEN lcur_sel;
  FETCH lcur_sel INTO lc;
  WHILE ld_tmp <= ad_end LOOP
   IF ld_tmp=lc.dt THEN
       gt_1(i):=lc.er;
       gt_2(i):=lc.ed;
       gt_3(i):=lc.q1;
       gt_4(i):=lc.q2;
       gt_5(i):=lc.q3;
       gt_6(i):=lc.q4;
       IF lcur_sel%FOUND THEN
          FETCH lcur_sel INTO lc;
       END IF;
   ELSE
    gt_1(i):=0;
    gt_2(i):=0;
    gt_3(i):=0;
    gt_4(i):=0;
    gt_5(i):=0;
    gt_6(i):=0;
   END IF;
   ld_tmp := ld_tmp + 1 / 48;
   i:=i+1;
  END LOOP;
  close lcur_sel;
  normal_p(gt_1);
  normal_p(gt_2);
  normal_p(gt_3);
  normal_p(gt_4);
  normal_p(gt_5);
  normal_p(gt_6);
 END;
 ------------------------------------------------------------------------------------------------------------------------
 PROCEDURE normal_p(at_1 IN OUT common_pg.tt_number) IS
 ln_s number default 0;
 BEGIN
    for i in 1..at_1.count loop
        ln_s:=ln_s+at_1(i);
    end loop;
    IF ln_s=0 THEN
        for i in 1..at_1.count loop
            at_1(i):=0;
        end loop;
    ELSE
        for i in 1..at_1.count loop
            at_1(i):=at_1(i)/ln_s;
        end loop;
    END IF;
 END;
 ------------------------------------------------------------------------------------------------------------------------
   -- Функция вычисления весовых коэффициентов для получасовок в любой период
 FUNCTION averrate_f(an_mid NUMBER, an_type NUMBER, ad_start DATE, ad_end DATE)
  RETURN common_pg.tt_number IS
  ld_start DATE DEFAULT util_pg.trunchh24_2(ad_start);
  ld_end   DATE DEFAULT util_pg.trunchh24_2(ad_end)+1/48;
 BEGIN
  IF    NVL(an_mid, -1) <> NVL(gn_mid, -2)
     OR NVL(ld_start, TO_DATE('100001', 'YYYYMM')) <> NVL(gd_start, TO_DATE('100001', 'YYYYMM') - 1)
     OR NVL(ld_end, TO_DATE('100001', 'YYYYMM')) <> NVL(ld_end, TO_DATE('100001', 'YYYYMM') - 1) THEN
   averrate_p(an_mid, ld_start, ld_end);
  END IF;
  IF an_type = 2 THEN
   RETURN gt_2;
  ELSIF an_type = 3 THEN
   RETURN gt_3;
  ELSIF an_type = 4 THEN
   RETURN gt_4;
  ELSIF an_type = 5 THEN
   RETURN gt_5;
  ELSIF an_type = 6 THEN
   RETURN gt_6;
  ELSE
   RETURN gt_1;
  END IF;
 END;
------------------------------------------------------------------------------------------------------------------------
END; -- Package spec
/

-- End of DDL script for AVERRATE_PG

-- Start of DDL script for CALCPTS_PG
-- Generated 27-янв-03  11:34:00 am
-- from oe-RYDA:1

-- Package body CALCPTS_PG

CREATE OR REPLACE
PACKAGE BODY calcpts_pg
IS
-----------------------------------------------------------------------------------------------------------------------
  --функция, возвращающая расход по точке
 FUNCTION calcpoint(
  an_mid       IN NUMBER,                                                                                   --ид. точки
  ad_date_time IN DATE,                                                                                    --дата/время
  an_timetype  IN NUMBER,                                                               --1-трехмин, 2-получас, 3-сутки
  av_entype    IN VARCHAR2                                                                             --ER, ED, Q1, Q3
                          ) RETURN NUMBER
 IS
---------------------------
  ln_ret       NUMBER;
  ld_date_time DATE;
---------------------------
 BEGIN
  IF    an_timetype = 1 THEN
   IF    av_entype = 'ER' THEN SELECT nvl(sum(er), 0) INTO ln_ret FROM profile WHERE mid = an_mid AND date_time = ad_date_time;
   ELSIF av_entype = 'ED' THEN SELECT nvl(sum(ed), 0) INTO ln_ret FROM profile WHERE mid = an_mid AND date_time = ad_date_time;
   ELSIF av_entype = 'Q1' THEN SELECT nvl(sum(q1), 0) INTO ln_ret FROM profile WHERE mid = an_mid AND date_time = ad_date_time;
   ELSIF av_entype = 'Q3' THEN SELECT nvl(sum(q3), 0) INTO ln_ret FROM profile WHERE mid = an_mid AND date_time = ad_date_time;
   END IF;
  ELSIF an_timetype = 2 THEN
   IF    av_entype = 'ER' THEN SELECT nvl(sum(er), 0) INTO ln_ret FROM halfhour WHERE mid = an_mid AND date_time = ad_date_time;
   ELSIF av_entype = 'ED' THEN SELECT nvl(sum(ed), 0) INTO ln_ret FROM halfhour WHERE mid = an_mid AND date_time = ad_date_time;
   ELSIF av_entype = 'Q1' THEN SELECT nvl(sum(q1), 0) INTO ln_ret FROM halfhour WHERE mid = an_mid AND date_time = ad_date_time;
   ELSIF av_entype = 'Q3' THEN SELECT nvl(sum(q3), 0) INTO ln_ret FROM halfhour WHERE mid = an_mid AND date_time = ad_date_time;
   END IF;
  ELSIF an_timetype = 3 THEN
   IF    av_entype = 'ER' THEN SELECT nvl(sum(er), 0) INTO ln_ret FROM bill WHERE mid = an_mid AND date_time = ad_date_time;
   ELSIF av_entype = 'ED' THEN SELECT nvl(sum(ed), 0) INTO ln_ret FROM bill WHERE mid = an_mid AND date_time = ad_date_time;
   ELSIF av_entype = 'Q1' THEN SELECT nvl(sum(q1), 0) INTO ln_ret FROM bill WHERE mid = an_mid AND date_time = ad_date_time;
   ELSIF av_entype = 'Q3' THEN SELECT nvl(sum(q3), 0) INTO ln_ret FROM bill WHERE mid = an_mid AND date_time = ad_date_time;
   END IF;
  END IF;
  RETURN ln_ret;
 END;
-----------------------------------------------------------------------------------------------------------------------
  --возвращает запрос для проверки формулы
 FUNCTION checkformula(
  an_calcmid IN NUMBER                                                                              --ид.расчетной точки
                      ) RETURN VARCHAR2
 IS
-------------------------------
  CURSOR cr(an_mid IN NUMBER)
  IS
   SELECT *
     FROM calcarguments
    WHERE mid = an_mid
    ORDER BY name DESC;
-------------------------------
  lv_sql VARCHAR2(4000);
-------------------------------
 BEGIN
  BEGIN
   SELECT ltrim(rtrim(formula))
     INTO lv_sql
     FROM calcpoints
    WHERE mid = an_calcmid;
   IF lv_sql IS NULL THEN RETURN NULL; END IF;
  EXCEPTION
   WHEN no_data_found THEN RETURN null;
  END;
  FOR ln IN cr(an_calcmid) LOOP
   lv_sql := replace(lv_sql, ln.name, '(' || ln.mid || ')');
  END LOOP;
  lv_sql := 'SELECT ' || lv_sql || ' FROM DUAL ';
  RETURN lv_sql;
 END;
-----------------------------------------------------------------------------------------------------------------------
 --процедура расчета расчетной точки
 PROCEDURE calcpts(
  an_calcmid   IN NUMBER,                                                                          --ид. расчетной точки
  ad_date_time IN DATE,                                                                             --дата/время расчета
  an_timetype  IN NUMBER                                                                 --1-трехмин, 2-получас, 3-сутки
                        )
 IS
--------------------------------
  CURSOR cr(an_mid IN NUMBER)
  IS
   SELECT *
     FROM calcarguments
    WHERE mid = an_mid
    ORDER BY name DESC;
--------------------------------
  lv_er        VARCHAR2(10000);
  lv_ed        VARCHAR2(10000);
  lv_q1        VARCHAR2(10000);
  lv_q3        VARCHAR2(10000);
  lv_formula   VARCHAR2(2000);
  lv_sql       VARCHAR2(32000);
  lv_sql1      VARCHAR2(32000);
  lv_date_time VARCHAR2(50);
  i            INTEGER;
  j            INTEGER;
--------------------------------
 BEGIN
  lv_date_time := to_char(ad_date_time, 'dd.mm.yyyy hh24:mi:ss');
  --считывание формулы ид БД
  BEGIN
   SELECT ltrim(rtrim(formula))
     INTO lv_formula
     FROM calcpoints
    WHERE mid = an_calcmid;
   IF lv_formula IS NULL THEN RETURN; END IF;
  EXCEPTION
   WHEN no_data_found THEN RETURN;
  END;
  lv_er := lv_formula;
  lv_ed := lv_formula;
  lv_q1 := lv_formula;
  lv_q3 := lv_formula;
  IF an_timetype = 1 THEN
   FOR ln IN cr(an_calcmid) LOOP
    lv_er := replace(lv_er, ln.name, '('||nvl(calcpoint(ln.argmid, ad_date_time, 1, 'ER'), 0)||')');
    lv_ed := replace(lv_ed, ln.name, '('||nvl(calcpoint(ln.argmid, ad_date_time, 1, 'ED'), 0)||')');
    lv_q1 := replace(lv_q1, ln.name, '('||nvl(calcpoint(ln.argmid, ad_date_time, 1, 'Q1'), 0)||')');
    lv_q3 := replace(lv_q3, ln.name, '('||nvl(calcpoint(ln.argmid, ad_date_time, 1, 'Q3'), 0)||')');
   END LOOP;
   lv_sql :='INSERT INTO PROFILE (mid, date_time, er, ed, q1, q3) VALUES ('||
             an_calcmid||', to_date('''||lv_date_time||''',''dd.mm.yyyy hh24:mi:ss''), '||
             lv_er||', '||lv_ed||', '||lv_q1||', '||lv_q3||')';
   lv_sql1 :='UPDATE PROFILE SET ER = '||lv_er||', ED = '||lv_ed||', Q1 = '||lv_q1||', Q3 = '||lv_q3||
                              ' WHERE mid = '||an_calcmid||
                              ' AND DATE_TIME = to_date('''||lv_date_time||''',''dd.mm.yyyy hh24:mi:ss'')';
   BEGIN
    --вставка строки
    i := DBMS_SQL.open_cursor;
    DBMS_SQL.parse(i, lv_sql, DBMS_SQL.v7);
    j := DBMS_SQL.execute(i);
    DBMS_SQL.close_cursor(i);
   EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN --если есть запись по этой точке на это время - производим UPDATE
     DBMS_SQL.close_cursor(i);
     i := DBMS_SQL.open_cursor;
     DBMS_SQL.parse(i, lv_sql1, DBMS_SQL.v7);
     j := DBMS_SQL.execute(i);
     DBMS_SQL.close_cursor(i);
   WHEN others THEN
     RETURN;
   END;
  ELSIF an_timetype = 2 THEN
   FOR ln IN cr(an_calcmid) LOOP
    lv_er := replace(lv_er, ln.name, '('||nvl(calcpoint(ln.argmid, ad_date_time, 2, 'ER'), 0)||')');
    lv_ed := replace(lv_ed, ln.name, '('||nvl(calcpoint(ln.argmid, ad_date_time, 2, 'ED'), 0)||')');
    lv_q1 := replace(lv_q1, ln.name, '('||nvl(calcpoint(ln.argmid, ad_date_time, 2, 'Q1'), 0)||')');
    lv_q3 := replace(lv_q3, ln.name, '('||nvl(calcpoint(ln.argmid, ad_date_time, 2, 'Q3'), 0)||')');
   END LOOP;
   lv_sql :='INSERT INTO HALFHOUR (mid, date_time, er, ed, q1, q3) VALUES ('||
             an_calcmid||', to_date('''||lv_date_time||''',''dd.mm.yyyy hh24:mi:ss''), '||
             lv_er||', '||lv_ed||', '||lv_q1||', '||lv_q3||')';
   lv_sql1 :='UPDATE HALFHOUR SET ER = '||lv_er||', ED = '||lv_ed||', Q1 = '||lv_q1||', Q3 = '||lv_q3||
                              ' WHERE mid = '||an_calcmid||
                              ' AND DATE_TIME = to_date('''||lv_date_time||''',''dd.mm.yyyy hh24:mi:ss'')';
   BEGIN
    --вставка строки
    i := DBMS_SQL.open_cursor;
    DBMS_SQL.parse(i, lv_sql, DBMS_SQL.v7);
    j := DBMS_SQL.execute(i);
    DBMS_SQL.close_cursor(i);
   EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN --если есть запись по этой точке на это время - производим UPDATE
     DBMS_SQL.close_cursor(i);
     i := DBMS_SQL.open_cursor;
     DBMS_SQL.parse(i, lv_sql1, DBMS_SQL.v7);
     j := DBMS_SQL.execute(i);
     DBMS_SQL.close_cursor(i);
    WHEN others THEN
     RETURN;
   END;
  ELSIF an_timetype = 3 THEN
   FOR ln IN cr(an_calcmid) LOOP
    lv_er := replace(lv_er, ln.name, '('||nvl(calcpoint(ln.argmid, ad_date_time, 3, 'ER'), 0)||')');
    lv_ed := replace(lv_ed, ln.name, '('||nvl(calcpoint(ln.argmid, ad_date_time, 3, 'ED'), 0)||')');
    lv_q1 := replace(lv_q1, ln.name, '('||nvl(calcpoint(ln.argmid, ad_date_time, 3, 'Q1'), 0)||')');
    lv_q3 := replace(lv_q3, ln.name, '('||nvl(calcpoint(ln.argmid, ad_date_time, 3, 'Q3'), 0)||')');
   END LOOP;
   lv_sql :='INSERT INTO BILL (mid, date_time, er, ed, q1, q3) VALUES ('||
             an_calcmid||', to_date('''||lv_date_time||''',''dd.mm.yyyy hh24:mi:ss''), '||
             lv_er||', '||lv_ed||', '||lv_q1||', '||lv_q3||')';
   lv_sql1 :='UPDATE BILL SET ER = '||lv_er||', ED = '||lv_ed||', Q1 = '||lv_q1||', Q3 = '||lv_q3||
                              ' WHERE mid = '||an_calcmid||
                              ' AND DATE_TIME = to_date('''||lv_date_time||''',''dd.mm.yyyy hh24:mi:ss'')';
   BEGIN
    --вставка строки
    i := DBMS_SQL.open_cursor;
    DBMS_SQL.parse(i, lv_sql, DBMS_SQL.v7);
    j := DBMS_SQL.execute(i);
    DBMS_SQL.close_cursor(i);
   EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN --если есть запись по этой точке на это время - производим UPDATE
     DBMS_SQL.close_cursor(i);
     i := DBMS_SQL.open_cursor;
     DBMS_SQL.parse(i, lv_sql1, DBMS_SQL.v7);
     j := DBMS_SQL.execute(i);
     DBMS_SQL.close_cursor(i);
    WHEN others THEN
     RETURN;
   END;
  END IF;
  EXCEPTION
   WHEN others THEN
    NULL;
 END;
-----------------------------------------------------------------------------------------------------------------------
 --запуск расчета по всем расчетным точкам
PROCEDURE startcalc(
 ad_date_time IN DATE,                                                                              --дата/время расчета
 an_timetype  IN NUMBER                                                                  --1-трехмин, 2-получас, 3-сутки
                       )
IS
---------------------------
 CURSOR cr
 IS
  SELECT *
    FROM calcpoints
   WHERE state = 1 and formula is not null;
---------------------------
BEGIN
 FOR ln IN cr LOOP
  calcpts(ln.mid, ad_date_time, an_timetype);
 END LOOP;
END;
-----------------------------------------------------------------------------------------------------------------------
END;                                                                                          -- Package Body calcpts_pg
/

-- End of DDL script for CALCPTS_PG

-- Start of DDL script for CALC_PG
-- Generated 27-янв-03  11:34:00 am
-- from oe-RYDA:1

-- Package body CALC_PG

CREATE OR REPLACE
PACKAGE BODY CALC_PG IS
gn_order NUMBER := 1; -- счетчик строк
gn_group NUMBER; -- id - reportgroup
gn_period NUMBER; -- Период
gd_first DATE; -- Дата окончания прошлого отчетного периода
gd_last  DATE; -- Дата окончания текущего отчетного периода
type t_number is table of number index by BINARY_INTEGER;
gt_consump t_number; -- Сумма расхода подразделения
type t_varchar is table of Varchar2(32) index by BINARY_INTEGER;
gv_type t_varchar;
gv_typeSmall t_varchar;

--- Процедура вставки записей в таблицу REPORTS
PROCEDURE REPORT_INS_P( AN_REPORTGROUP  IN NUMBER,
                        AN_PERIOD       IN NUMBER,
                        AN_ORDER        IN NUMBER,
                        AV_F1           IN VARCHAR2,
                        AV_F2           IN VARCHAR2,
                        AV_F3           IN VARCHAR2,
                        AV_F4           IN VARCHAR2,
                        AV_F5           IN VARCHAR2,
                        AV_F6           IN VARCHAR2,
                        AV_F7           IN VARCHAR2,
                        AV_F8           IN VARCHAR2,
                        AV_F9           IN VARCHAR2,
                        AV_F10          IN VARCHAR2,
                        AV_F11          IN VARCHAR2,
                        AV_F12          IN VARCHAR2)
IS
BEGIN

INSERT INTO  RYDA.REPORTS
      ( NREPORTGROUP , NPERIOD , NORDER , VF1 , VF2
      , VF3 , VF4 , VF5 , VF6 , VF7
      , VF8 , VF9 , VF10 , VF11 , VF12 )
VALUES( AN_REPORTGROUP , AN_PERIOD , an_order , AV_F1 , AV_F2
      , AV_F3 , AV_F4 , AV_F5 , AV_F6 , AV_F7
      , AV_F8 , AV_F9 , AV_F10 , AV_F11 , AV_F12 );
gn_order := gn_order + 1;
END;
---------------------------------------------------------
---- Функция определения, является ли группа родителем---
---------------------------------------------------------

FUNCTION Isgroup_f
     ( an_group         IN NUMBER)
     RETURN  NUMBER
IS
ln_ret NUMBER;
Begin
    Select count(0) into ln_ret from dual
    Where exists (Select * from REPORTGROUPS Where nParent = an_group);
return ln_ret;
End;


-------------------------------------------------------
------- Процедура  записи данных по точкам ------------
-------------------------------------------------------
PROCEDURE INS_POINTS(an_parent IN NUMBER, -- Группа
                     av_title  IN VARCHAR2, -- Наименование
                     an_sign   IN NUMBER, -- Знак -- "-1" - отрицательные
                                                  --  "0" - положительные
                     an_include IN BOOLEAN ) -- Вхождение в группу: true - в том числе
IS
type r_meters is record  (mtrsn VARCHAR2(20), KC NUMBER, mtype VARCHAR2(50), digits NUMBER, date_time DATE);
type t_meters is table of r_meters index by BINARY_INTEGER;
ld_first DATE;
ld_last  DATE;
ln_ind t_number;
ln_newind t_number;
ln_type t_number;
lr_meters r_meters;
lt_meters t_meters;
ln_consump t_number;
ln_consump_all t_number; -- Расход по все точкам группы
ln_diff NUMBER;
ln_digits NUMBER;
lb_found BOOLEAN :=true ;
lb_title BOOLEAN := false;
ln_i BINARY_INTEGER;
lv_title VARCHAR2(128);

lb_inst BOOLEAN;
ln_first_ind NUMBER;
ln_consump_ins NUMBER;
ln_consump_sum NUMBER;
lv_DDD VARCHAR2(16);
CURSOR lcur_point(an_parent number) IS
SELECT R.NREPORTGROUP , R.NPARENT , R.VNAME , R.NGROUPTYPE , R.VGROUPKIND
     , R.NPROCEDURE , R.NDEPARTMENT , R.MID , nvl(R.NCOEF,1) NKOEF, NVL(F.KC,1) KC
FROM RYDA.REPORTGROUPS R, RYDA.FEEDERS F
WHERE R.MID = F.MID(+) and R.NPARENT = an_parent and
      r.mid > 0 and nvl(R.NCOEF,1) between an_sign and an_sign + 1
ORDER BY  R.VNAME;

Cursor lcur_Indication (an_mid NUMBER, ad_first DATE, ad_last DATE) IS
SELECT /*r.er_mtrsn,r.er_kc,r.erm,r.er,
       r.q1_mtrsn,r.q1_kc,r.q1m, r.q1,
       r.ed_mtrsn,r.ed_kc,r.edm, r.ed,
       r.q3_mtrsn, r.q3_kc, r.q3m, r.q3*/
       max(r.erm), max(r.q1m), max(r.edm), max(r.q3m)
FROM ryda.bill r
Where mid = an_mid and
      date_time = (Select min(date_time) from ryda.bill
                   Where mid = an_mid and
                         date_time between ad_first and ad_last);

Cursor lcur_consumption (an_mid NUMBER, ad_first DATE, ad_last DATE) IS
SELECT sum(nvl(r.er,0)) er, sum(nvl(r.q1,0)) q1, sum(nvl(r.ed,0)) ed, sum(nvl(r.q3,0)) q3
FROM ryda.bill r
Where mid = an_mid and
      date_time between ad_first+1 and ad_last;

Cursor lcur_Meters(an_mid NUMBER, an_type NUMBER) IS
Select substr(mtrsn,1,32) mtrsn, kc, mtype, digits, date_time from ryda.Meters
Where mid = an_mid and (entype in (an_type,7) or Smart = '*') and
date_time = (Select max(date_time) from ryda.Meters
              Where mid=an_mid and date_time <= ld_last
                    and (entype in (an_type,7) or Smart = '*'));
-- Нахождение снятых счетчиков
Cursor lcur_Bill_Del(an_mid NUMBER, an_type NUMBER,
                     ad_first DATE, ad_last DATE) IS
Select date_time, decode(an_type,1,r.er_mtrsn,2, r.q1_mtrsn, 3, r.ed_mtrsn,4,r.q3_mtrsn) mtrsn,
       substr(r.remark, instr(r.remark, '[') +1, instr(r.remark, ']')- instr(r.remark, '[')-1) type,
       decode(an_type,1,r.erm,2, r.q1m, 3, r.edm,4,r.q3m) ind,
       decode(an_type,1,r.er,2, r.q1, 3, r.ed,4,r.q3) diff
from ryda.Bill r
Where mid=an_mid and
      date_time between ad_first+1 and ad_last and
      r.source = 'Снт' and
      decode(an_type,1,r.er_mtrsn,2, r.q1_mtrsn, 3, r.ed_mtrsn,4,r.q3_mtrsn) is not null and
      decode(an_type,1,r.erm,2, r.q1m, 3, r.edm,4,r.q3m) is not null and
      decode(an_type,1,r.er,2, r.q1, 3, r.ed,4,r.q3) is not null
order by date_time;
-- Расход по счетчику (если были замены)
Cursor lcur_consumption_ins(an_mid NUMBER, an_type NUMBER, ad_first DATE, ad_last DATE, AV_MTRSN VARCHAR2) IS
SELECT sum(decode(an_type,1,r.er,2, r.q1, 3, r.ed,4,r.q3)) nConsump
FROM ryda.bill r
Where mid = an_mid and
      date_time between ad_first+1 and ad_last and
      decode(an_type,1,r.er_mtrsn,2, r.q1_mtrsn, 3, r.ed_mtrsn,4,r.q3_mtrsn) = av_mtrsn;
-- Начальные показания установленных счетчиков
Cursor lcur_Bill_Ins(an_mid NUMBER, an_type NUMBER,
                     ad_first DATE, ad_last DATE, AV_MTRSN VARCHAR2) IS
Select decode(an_type,1,r1.erm,2, r1.q1m, 3, r1.edm,4,r1.q3m) ind
from ryda.Bill r1
Where mid=an_mid and
      date_time = (Select min(date_time) from ryda.Bill r
                   Where date_time between ad_first and ad_last and
                         decode(an_type,1,r.er_mtrsn,2, r.q1_mtrsn, 3, r.ed_mtrsn,4,r.q3_mtrsn) = av_mtrsn and
                         decode(an_type,1,r.erm,2, r.q1m, 3, r.edm,4,r.q3m) is not null);

BEGIN
ld_first := gd_first;
ld_last := gd_last;
FOR ln_i in 1..4 LOOP
    ln_consump_all(ln_i) := 0;
END LOOP;
--------------------------------
-- Цикл по точкам---------------
--------------------------------
FOR lc_point in lcur_point(an_parent) LOOP

    -- Старые показания
    Open lcur_Indication(lc_point.mid, gd_first, gd_last);
    Fetch lcur_Indication into ln_ind(1), ln_ind(2), ln_ind(3), ln_ind(4);
    If lcur_Indication%NOTFOUND Then lb_found := false; End IF;
    Close lcur_Indication;
    -- Новые показания
    IF lb_found Then
        Open lcur_Indication(lc_point.mid, gd_last, gd_last);
        Fetch lcur_Indication into ln_newind(1), ln_newind(2), ln_newind(3), ln_newind(4);
--        If lcur_Indication%NOTFOUND Then lb_found := false; End IF;
        Close lcur_Indication;
    End IF;
    -- Расход
    IF lb_found Then
        Open lcur_consumption(lc_point.mid, gd_first, gd_last);
        Fetch lcur_consumption into ln_consump(1), ln_consump(2), ln_consump(3), ln_consump(4);
        Close lcur_consumption;
    End IF;

    -- Данные по счетчикам
    IF lb_found Then
        ln_type(1) := 1;ln_type(2) := 3;ln_type(3) := 2;ln_type(4) := 5;
        FOR ln_i in 1..4 LOOP
            Open lcur_Meters(lc_point.mid, ln_type(ln_i));
            Fetch lcur_Meters INTO lr_meters.mtrsn, lr_meters.KC, lr_meters.mtype, lr_meters.digits, lr_meters.date_time;
            If lcur_Meters%NOTFOUND Then
                lr_meters.mtrsn:=null;
                lr_meters.KC:= 1;
                lr_meters.mtype:= '';
                lr_meters.digits := 0;
            End IF;
            lt_meters(ln_i) := lr_meters;
            Close lcur_Meters;
        END LOOP;
    End IF;
    -- Заполнение таблицы
    IF lb_found Then
       -- Заголовок
       IF not lb_title and length(av_title) > 2 Then
            REPORT_INS_P(gn_group, gn_period , gn_order , av_title ,
                          '','','','','','','','','','','');
            lb_title := True;
       END IF;
        FOR ln_i in 1..4 LOOP
            IF (ln_ind(ln_i) is not NULL and ln_newind(ln_i) is not NULL)
               or ln_consump(ln_i) > 0  Then
               lr_meters := lt_meters(ln_i);
               ---------------------------------------------------------------
               --- Проверка на вновь установленные счетчики  -----------------
               ---------------------------------------------------------------
                   lb_inst := false;
                   ln_first_ind := ln_ind(ln_i);
                   ln_consump_sum := 0;
                   lv_DDD := '';
               FOR lc_Bill_Del in lcur_Bill_Del(lc_point.mid, ln_i, gd_first, gd_last) LOOP
                   if not lb_inst then
                         lv_DDD := ' Дем.';
                   else
                        lv_DDD := ' Уст. - Дем.';
                        Open lcur_Bill_Ins(lc_point.mid, ln_i, gd_first, gd_last, lc_Bill_Del.mtrsn);
                        Fetch lcur_Bill_Ins into ln_first_ind;
                        Close lcur_Bill_Ins;
                   end if;
                   Open lcur_consumption_ins(lc_point.mid, ln_i, ld_first, gd_last, lc_Bill_Del.mtrsn);
                   Fetch lcur_consumption_ins into ln_consump_ins;
                   Close lcur_consumption_ins;
                   ln_diff := ln_consump_ins/nvl(lr_meters.KC,1);
                      REPORT_INS_P(gn_group, gn_period , gn_order , lc_point.VNAME||lv_DDD, gv_typeSmall(ln_i),
                        lc_Bill_Del.type,lc_Bill_Del.mtrsn,to_char(lc_Bill_Del.Ind),to_char(ln_first_ind)
                        ,to_char(ln_diff),to_char(lc_point.kc),round(ln_consump_ins*ABS(lc_point.NKOEF))
                        ,'','','');
                   Open lcur_Bill_Ins(lc_point.mid, ln_i, ld_first, gd_last, lc_Bill_Del.mtrsn);
                   Fetch lcur_Bill_Ins into ln_first_ind;
                   Close lcur_Bill_Ins;
                   ln_consump_sum := ln_consump_sum + ln_consump_ins;
                   lb_inst := true;
                   lv_DDD := ' Уст.';
               END LOOP;
              ------------------------------------
              --- Проверяем была ли уже запись ---
              ------------------------------------
                   if lb_inst then
                        Open lcur_Bill_Ins(lc_point.mid, ln_i, gd_first, gd_last, lr_meters.mtrsn);
                        Fetch lcur_Bill_Ins into ln_first_ind;
                        Close lcur_Bill_Ins;
                   end if;
              ------------------------------------
              --- Запись по последнему счетчику---
              ------------------------------------
                     -- Проверка на NULL показаний
                     IF ln_first_ind is NULL  THEN
                        lr_meters.mtype:= 'Уст. мощн.';
                        ln_diff := NULL;
                     ELSE
                       -- Нахождение разности показаний
                       IF ln_newind(ln_i) >= ln_first_ind Then
                           ln_diff := ln_newind(ln_i) - ln_first_ind;
                       ELSE
                           IF  lr_meters.DIGITS > 0
                           Then ln_digits := round(lr_meters.DIGITS,-1);
                           Else ln_digits := to_number(rpad('1',length(ln_first_ind)+1,'0'));
                           End if;
                           ln_diff := (ln_newind(ln_i) - ln_first_ind) + ln_digits;
                       END IF;
                     END IF;
                      REPORT_INS_P(gn_group, gn_period , gn_order , lc_point.VNAME||lv_DDD,gv_typeSmall(ln_i),
                        lr_meters.mtype,lr_meters.mtrsn,to_char(ln_newind(ln_i)),to_char(ln_first_ind)
                        ,to_char(ln_diff),to_char(lc_point.kc)
                        ,round((ln_consump(ln_i)-ln_consump_sum)*ABS(lc_point.NKOEF))
                        ,'','','');
              IF not an_include Then
                  ln_consump_all(ln_i) := ln_consump_all(ln_i) + round(ln_consump(ln_i)*ABS(lc_point.NKOEF));
                  gt_consump(ln_i) := gt_consump(ln_i) + round(ln_consump(ln_i)*lc_point.NKOEF);
              END IF;
            END IF;
        END LOOP;
    End IF;
END LOOP;
-- Итого
lb_title := false;
FOR ln_i in 1..4 LOOP
    IF ln_consump_all(ln_i) <> 0 Then
       IF not lb_title Then lv_title := 'Итого '||lower(av_title);lb_title := True;
       ELSE  lv_title := ''; END IF;
            REPORT_INS_P(gn_group, gn_period , gn_order , lv_title ,
                          '','','','',gv_type(ln_i),'','',ln_consump_all(ln_i),'','','');
    END IF;
END LOOP;
EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001, 'calc_pg.INS_POINTS: Ошибка вставки точек. ' || chr(10) || SqlErrm(SqlCode));
END;
--------------------------------------------------------------------------------------------
---- Основная процедура расчета, вызывающая остальные процедуры    -------------------------
--------------------------------------------------------------------------------------------
PROCEDURE Calc_main_p
IS
ln_Rtn          INTEGER;
ln_Handle       INTEGER;
lv_sql          VARCHAR2(2000);
le_ErrOpenCursor EXCEPTION ;
ln_period   NUMBER;

Cursor lcur_procedure IS
SELECT P.NPROCEDURE , P.VPROCDURE , P.VNAME , P.NORDER, R.NREPORTGROUP
FROM RYDA.PROCEDURES P, RYDA.REPORTGROUPS R
WHERE (P.NPROCEDURE = R.NPROCEDURE)
ORDER BY P.NORDER;
BEGIN
-- Получение периода
Begin
SELECT to_number(substr(VVALUE,7,4)||substr(VVALUE,4,2)) INTO ln_period
 FROM RYDA.PARAMETER WHERE npid = 3;
EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001, 'calc_pg.main_p: Не введена дата расчета значений ручников с месячным профилем. ' || chr(10) || SqlErrm(SqlCode));
End;

SAVEPOINT calc_main_p;
-- Цикл по процедурам
FOR lc_proc in lcur_procedure LOOP
    lv_sql := 'Begin '||lc_proc.VPROCDURE || '('||to_char(lc_proc.NREPORTGROUP)||','||to_char(ln_period)||');  End;';
    ln_Handle := SYS.DBMS_SQL.Open_Cursor;
    SYS.DBMS_SQL.Parse(ln_Handle,lv_sql,SYS.DBMS_SQL.V7);
    ln_Rtn :=SYS.DBMS_SQL.Execute(ln_Handle);
    IF ln_Rtn < 0 THEN
        RAISE le_ErrOpenCursor;
    END IF;
    SYS.DBMS_SQL.Close_Cursor(ln_Handle);
END LOOP;
Commit;
EXCEPTION
WHEN le_ErrOpenCursor THEN
   ROLLBACK TO SAVEPOINT calc_main_p;
     raise_application_error(-20002, 'calc_pg.main_p: Ошибка при открытии курсора. ' || chr(10) || SqlErrm(SqlCode));
WHEN OTHERS THEN
   ROLLBACK TO SAVEPOINT calc_main_p;
   raise_application_error(-20001, 'calc_pg.main_p: Ошибка при генерации отчета. ' || chr(10) || SqlErrm(SqlCode));
END;

------------------------------------------------------------------------------
----------- Процедура формирования первой ведомости --------------------------
------------------------------------------------------------------------------
PROCEDURE Calc_report_p (an_group    IN NUMBER,
                         an_period   IN NUMBER)
IS
lv_title VARCHAR2(128);
lb_title BOOLEAN;

CURSOR lcur_main_group (an_parent number) IS
SELECT R.NREPORTGROUP , R.NPARENT , R.VNAME , R.NGROUPTYPE , R.VGROUPKIND
     , R.NPROCEDURE , R.NDEPARTMENT , R.MID , R.NCOEF
FROM RYDA.REPORTGROUPS R, RYDA.DEPARTMENTS DP
WHERE NPARENT = an_parent and R.NDEPARTMENT > 0
      AND R.NDEPARTMENT = DP.NDEPARTMENT(+)
ORDER BY DP.NSORT;

CURSOR lcur_group (an_parent number, an_type number) IS
SELECT R.NREPORTGROUP , R.NPARENT , R.VNAME , R.NGROUPTYPE , R.VGROUPKIND
     , R.NPROCEDURE , R.NDEPARTMENT , R.MID , R.NCOEF
FROM RYDA.REPORTGROUPS R
WHERE NPARENT = an_parent and DECODE(R.VGROUPKIND,'S',1,'G',2,0) = an_type
ORDER BY  DECODE(R.VGROUPKIND,'S',1,'G',2,0), R.NGROUPTYPE;

BEGIN
gn_order := 1;
gn_group := an_group;
gn_period := an_period;
gv_type(1) := 'актив';gv_type(2) := 'реактив';gv_type(3) := 'актив отдача';gv_type(4) := 'реактив отдача';
gv_typeSmall(1) := 'Апр';gv_typeSmall(2) := 'Рпр';gv_typeSmall(3) := 'Аотд';gv_typeSmall(4) := 'Рген';

-- Получение периода
Begin
SELECT to_date(VVALUE,'DD.MM.YYYY') INTO gd_first
 FROM RYDA.PARAMETER WHERE npid = 2;
SELECT to_date(VVALUE,'DD.MM.YYYY') INTO gd_last
 FROM RYDA.PARAMETER WHERE npid = 3;
EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001, 'calc_pg.Calc_report_p: Не введена дата расчета. ' || chr(10) || SqlErrm(SqlCode));
End;

----- Очистка таблицы ----------
    DELETE FROM REPORTS
    WHERE NREPORTGROUP =  AN_GROUP AND NPERIOD = AN_PERIOD;
FOR lc_main in lcur_main_group(an_group) LOOP
    REPORT_INS_P( AN_GROUP , AN_PERIOD , gn_order , lc_main.VNAME ,
                  '','','','','','','','','','','');
    -- Очистка таблицы суммарного расхода группы
    FOR ln_i in 1..4 LOOP
        gt_consump(ln_i) := 0;
    END LOOP;
    INS_POINTS(lc_main.NREPORTGROUP,':',0, False);
    -- Цикл по группам (в том числе)
     FOR lc_group in lcur_group(lc_main.NREPORTGROUP,1) LOOP
         Select DECODE(lc_group.NGROUPTYPE,1,'В том числе подстанции:',
                                           2,'В том числе потребители:','') into lv_title from dual;
         INS_POINTS(lc_group.NREPORTGROUP, lv_title, 0, True);
     END LOOP;
     -- Плюс подстанции, потребители
     FOR lc_group in lcur_group(lc_main.NREPORTGROUP,2) LOOP
         Select DECODE(lc_group.NGROUPTYPE,1,'Плюс(подстанции):',2,'Плюс(потребители):','') into lv_title from dual;
         INS_POINTS(lc_group.NREPORTGROUP, lv_title, 0, False);
     END LOOP;
     -- Минус подстанции, потребители
     FOR lc_group in lcur_group(lc_main.NREPORTGROUP,2) LOOP
         Select DECODE(lc_group.NGROUPTYPE,1,'Минус(подстанции):',2,'Минус(потребители):','') into lv_title from dual;
         INS_POINTS(lc_group.NREPORTGROUP, lv_title, -1, False);
     END LOOP;
  DELETE from DetTurnOver Where NDEPARTMENT = lc_main.NDEPARTMENT and NPERIOD = gn_period;
  Insert into DetTurnOver( NDEPARTMENT , NPERIOD , NAMOUNTER ,
                          NAMOUNTQ1 , NAMOUNTED, NAMOUNTQ3 )
   Values(lc_main.NDEPARTMENT, gn_period,gt_consump(1),
                          gt_consump(2),gt_consump(3),gt_consump(4));
   -- Итого
    lb_title := false;
    FOR ln_i in 1..4 LOOP
        IF gt_consump(ln_i) <> 0 Then
           IF not lb_title Then lv_title := 'Итого '||lower(lc_main.VNAME)||':';lb_title := True;
           ELSE  lv_title := ''; END IF;
                REPORT_INS_P(gn_group, gn_period , gn_order , lv_title ,
                              '','','','',gv_type(ln_i),'','',gt_consump(ln_i),'','','');
        END IF;
END LOOP;
END LOOP;
EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001, 'calc_pg.Calc_report_p: Ошибка формирования. ' || chr(10) || SqlErrm(SqlCode));
END;
------------------------------------------------------------------------------
---- Процедура второго отчета-------------------------------------------------
------------------------------------------------------------------------------
PROCEDURE Report_Debt_p (an_group    IN NUMBER,
                         an_period   IN NUMBER)
IS
lv_title VARCHAR2(128);
lt_consump t_number;
lt_consump_group t_number;
ln_order NUMBER;
ld_first DATE;
ld_last DATE;
lv_kind VARCHAR2(10);
ln_main_group NUMBER;
CURSOR lcur_main_group (an_parent number) IS
SELECT R.NREPORTGROUP , R.NPARENT , R.VNAME , R.NGROUPTYPE , R.VGROUPKIND
     , R.NPROCEDURE , R.NDEPARTMENT , R.MID , R.NCOEF
     , D.NAMOUNTER , D.NAMOUNTQ1 , D.NAMOUNTED, D.NAMOUNTQ3
FROM RYDA.REPORTGROUPS R, RYDA.DETTURNOVER D, RYDA.DEPARTMENTS DP
WHERE NPARENT = an_parent and R.NDEPARTMENT > 0
      AND R.NDEPARTMENT = D.NDEPARTMENT and D.NPERIOD = an_period
      AND R.NDEPARTMENT = DP.NDEPARTMENT(+)
ORDER BY DP.NSORT;

CURSOR lcur_group (an_parent number) IS
SELECT R.NREPORTGROUP , R.NPARENT , R.VNAME , R.NGROUPTYPE ,
       nvl(R.VGROUPKIND,'G') VGROUPKIND
     , R.NPROCEDURE , R.NDEPARTMENT , R.MID , R.NCOEF
FROM RYDA.REPORTGROUPS R
WHERE NPARENT = an_parent
ORDER BY  DECODE(R.VGROUPKIND,'S',1,'G',2,0), R.NGROUPTYPE;

Cursor lcur_consumption (an_group NUMBER, ad_first DATE, ad_last DATE) IS
SELECT sum(nvl(r.er,0)*nvl(g.NCOEF,1)) er, sum(nvl(r.q1,0)*nvl(g.NCOEF,1)) q1,
       sum(nvl(r.ed,0)*nvl(g.NCOEF,1)) ed, sum(nvl(r.q3,0)*nvl(g.NCOEF,1)) q3
FROM ryda.bill r, REPORTGROUPS g
Where r.mid = g.mid and (g.NPARENT = an_group or g.NREPORTGROUP = an_group)
      and r.date_time between ad_first+1 and ad_last;

BEGIN
gn_order := 1;
gn_group := an_group;
gn_period := an_period;

-- Получение периода
Begin
SELECT to_date(VVALUE,'DD.MM.YYYY') INTO ld_first
 FROM RYDA.PARAMETER WHERE npid = 2;
SELECT to_date(VVALUE,'DD.MM.YYYY') INTO ld_last
 FROM RYDA.PARAMETER WHERE npid = 3;
EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001, 'calc_pg.main_p: Не введена дата расчета. ' || chr(10) || SqlErrm(SqlCode));
End;
----------- Удаление записей из таблицы отчета -----------
    DELETE FROM REPORTS
    WHERE NREPORTGROUP =  AN_GROUP AND NPERIOD = AN_PERIOD;
FOR lc_main in lcur_main_group(an_group) LOOP
    IF IsGroup_f(lc_main.NREPORTGROUP) = 0 Then
       REPORT_INS_P( AN_GROUP , AN_PERIOD , gn_order , lc_main.VNAME
                    , lc_main.NAMOUNTER , lc_main.NAMOUNTQ1 , lc_main.NAMOUNTED, lc_main.NAMOUNTQ3
                    ,'','','','','','','');
    ELSE
      REPORT_INS_P( AN_GROUP , AN_PERIOD , gn_order , lc_main.VNAME ,
                   '','','','','','','','','','','');
      ln_order := gn_order;
      gn_order := gn_order + 1;
    -- Очистка таблицы суммарного расхода группы
     FOR ln_i in 1..4 LOOP
        lt_consump_group(ln_i) := 0;
     END LOOP;
     ln_main_group := 0;
    -- Цикл по группам
     FOR lc_group in lcur_group(lc_main.NREPORTGROUP) LOOP
         Open lcur_consumption (lc_group.NREPORTGROUP, ld_first, ld_last);
         Fetch lcur_consumption into lt_consump(1), lt_consump(2), lt_consump(3), lt_consump(4);
         Close lcur_consumption;
         IF lc_group.VGROUPKIND = 'G' THEN
             FOR ln_i in 1..4 LOOP
                lt_consump_group(ln_i) := lt_consump_group(ln_i) + lt_consump(ln_i);
             END LOOP;
             lv_kind := '';
             ln_main_group := 1;
          ELSE
             lv_kind := 'В.Т.Ч.';
         END IF;
          REPORT_INS_P( AN_GROUP , AN_PERIOD , gn_order , lv_kind||lc_group.VNAME ,
                       lt_consump(1),lt_consump(2),lt_consump(3),lt_consump(4),
                       '','','','','','','');
     END LOOP;
     ---------- Сумма по группе не равна общей сумме -----------------
       IF lc_main.NAMOUNTER <> lt_consump_group(1) and ln_main_group = 1 Then
          REPORT_INS_P( AN_GROUP , AN_PERIOD , ln_order , 'Электромеханизмы' ,
                       lc_main.NAMOUNTER - lt_consump_group(1),
                       lc_main.NAMOUNTQ1 - lt_consump_group(2) ,
                       lc_main.NAMOUNTED - lt_consump_group(3),
                       lc_main.NAMOUNTQ3 - lt_consump_group(4),
                       '','','','','','','');
          gn_order := gn_order - 1;
       END IF;
       REPORT_INS_P( AN_GROUP , AN_PERIOD , gn_order , 'ИТОГО'
                    , lc_main.NAMOUNTER , lc_main.NAMOUNTQ1 , lc_main.NAMOUNTED, lc_main.NAMOUNTQ3
                    ,'','','','','','','');
END IF;
END LOOP;

END;


END; -- Package Body CALC_PG
/

-- End of DDL script for CALC_PG

-- Start of DDL script for CHANNELS_PG
-- Generated 27-янв-03  11:34:00 am
-- from oe-RYDA:1

-- Package body CHANNELS_PG

CREATE OR REPLACE
PACKAGE BODY channels_pg IS
   -- пакет работы с каналами
   -- дата создания 15/07/2002 (Сечин А.А.)
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура вставки
 PROCEDURE ins_p(
  av_name              VARCHAR2, --Название
  av_note              VARCHAR2, --Примечание
  an_protocol_id       NUMBER, --Ид протокола
  an_com_id            NUMBER, --Ид компорта
  av_init_str          VARCHAR2, --Строка инициализации
  av_addr              VARCHAR2, --Коммуникационый адресс
  an_cycle_tout        NUMBER, --Пауза между циклами
  an_retries           NUMBER, --Кол попыток соединения
  an_retries_tout      NUMBER, --Пауза между попытками
  an_blocking          NUMBER, --Блокировка
  av_caller_name       VARCHAR2, --Название опросчика
  an_billdata          NUMBER, --Коммерческие
  an_billdatadepth     NUMBER, --Коммерческие глубина
  an_currdata          NUMBER, --Текущие
  an_currdatadepth     NUMBER, --Текущие глубина
  an_netparam          NUMBER, --Параметры сети
  an_journal           NUMBER, --Журнал событий
  ad_start             DATE, --Начало опроса
  ad_end               DATE, --Окончание
  an_day               NUMBER, --День
  an_parent            NUMBER, --Главный канал
  an_nnotreadcurr      NUMBER, --Не читать текущие сутки
  an_mid           OUT NUMBER --Ид канала
                             ) IS
  ln_mid NUMBER;
 BEGIN
  SAVEPOINT editcanals_ins;
  SELECT points_seq.NEXTVAL
    INTO ln_mid
    FROM DUAL;
  INSERT INTO points
              (mid, parent, cod, ind, name, short_name, calc_count, ovv_count, ptype, implement_date, min30, min3, tag)
       VALUES (ln_mid, 1, 0, 2, av_name, '', 0, 0, 1, SYSDATE, 0, 0, NULL);
  INSERT INTO channels
              (cid, vname, vnote, protocol_id, com_id, init_str, addr, cycle_tout, retries,
               retries_tout, blocking, caller_name, nbilldata, nbilldatadepth, ncurrdata,
               ncurrdatadepth, nnetparam, njournal, dstart, dend, nday, nparent, nnotreadcurr)
       VALUES (ln_mid, av_name, av_note, an_protocol_id, an_com_id, av_init_str, av_addr, an_cycle_tout, an_retries,
               an_retries_tout, an_blocking, av_caller_name, an_billdata, an_billdatadepth, an_currdata,
               an_currdatadepth, an_netparam, an_journal, ad_start, ad_end, an_day, an_parent, an_nnotreadcurr);
  INSERT INTO last_save
              (mid, PROFILE, halfhour, bill, state_date, state_cod, state_descr, clock, luck, rates, months)
   SELECT ln_mid, SYSDATE - 1, SYSDATE - 7, SYSDATE - 62, SYSDATE, 0, '(КС::Штатный режим)', 0, SYSDATE - 7,
          MAX(edit_date) - 1, SYSDATE - 370
     FROM rate_edit_date;
  an_mid := ln_mid;
 EXCEPTION
  WHEN OTHERS THEN
   ROLLBACK TO SAVEPOINT editcanals_ins;
   raise_application_error(-20001, 'channels_pg.ins_p: Ошибка вставки канала. ' || CHR(10) || SQLERRM(SQLCODE));
 END;
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура обновления данных
 PROCEDURE upd_p(
  an_mid           NUMBER, --Ид канала
  av_name          VARCHAR2, --Название
  av_note          VARCHAR2, --Примечание
  an_protocol_id   NUMBER, --Ид протокола
  an_com_id        NUMBER, --Ид компорта
  av_init_str      VARCHAR2, --Строка инициализации
  av_addr          VARCHAR2, --Коммуникационый адресс
  an_cycle_tout    NUMBER, --Пауза между циклами
  an_retries       NUMBER, --Кол попыток соединения
  an_retries_tout  NUMBER, --Пауза между попытками
  an_blocking      NUMBER, --Блокировка
  av_caller_name   VARCHAR2, --Название опросчика
  an_billdata      NUMBER, --Коммерческие
  an_billdatadepth NUMBER, --Коммерческие глубина
  an_currdata      NUMBER, --Текущие
  an_currdatadepth NUMBER, --Текущие глубина
  an_netparam      NUMBER, --Параметры сети
  an_journal       NUMBER, --Журнал событий
  ad_start         DATE, --Начало опроса
  ad_end           DATE, --Окончание
  an_day           NUMBER, --День
  an_parent        NUMBER, --Главный канал
  an_nnotreadcurr  NUMBER --Не читать текущие сутки
                         ) IS
 BEGIN
  SAVEPOINT editcanals_upd;
  UPDATE points
     SET name = av_name
   WHERE mid = an_mid;
  UPDATE channels
     SET vname = av_name,
         vnote = av_note,
         protocol_id = an_protocol_id,
         com_id = an_com_id,
         init_str = av_init_str,
         addr = av_addr,
         cycle_tout = an_cycle_tout,
         retries = an_retries,
         retries_tout = an_retries_tout,
         blocking = an_blocking,
         caller_name = av_caller_name,
         nbilldata = an_billdata,
         nbilldatadepth = an_billdatadepth,
         ncurrdata = an_currdata,
         ncurrdatadepth = an_currdatadepth,
         nnetparam = an_netparam,
         njournal = an_journal,
         dstart = ad_start,
         dend = ad_end,
         nday = an_day,
         nparent = an_parent,
         nnotreadcurr = an_nnotreadcurr
   WHERE cid = an_mid;
 EXCEPTION
  WHEN OTHERS THEN
   ROLLBACK TO SAVEPOINT editcanals_upd;
   raise_application_error(-20001, 'channels_pg.upd_p: Ошибка обновления канала. ' || CHR(10) || SQLERRM(SQLCODE));
 END;
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура удаления данных
 PROCEDURE del_p(an_mid NUMBER --Ид точки
                              ) IS
 BEGIN
  SAVEPOINT editcanals_del;
  UPDATE channels
     SET nparent = NULL,
         blocking = 1
   WHERE nparent = an_mid;
  DELETE FROM points
        WHERE mid = an_mid;
 EXCEPTION
  WHEN OTHERS THEN
   ROLLBACK TO SAVEPOINT editcanals_del;
   raise_application_error(-20001, 'channels_pg.del_p: Ошибка удаления канала. ' || CHR(10) || SQLERRM(SQLCODE));
 END;
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура привязки точек
 PROCEDURE setpoint_p(an_cid NUMBER, --Ид канала
                                    at_mid COMMON_PG.tt_number --Мас ид точек
                                                    ) IS
 BEGIN
  SAVEPOINT channels_set;
  DELETE FROM chanpoint
        WHERE cid = an_cid;
  FOR i IN 1 .. at_mid.COUNT LOOP
   INSERT INTO chanpoint
               (cid, mid)
        VALUES (an_cid, at_mid(i));
  END LOOP;
 EXCEPTION
  WHEN OTHERS THEN
   ROLLBACK TO SAVEPOINT channels_set;
   raise_application_error(
    -20001, 'channels_pg.setpoint_p: Ошибка привязки точек к каналам. ' || CHR(10) || SQLERRM(SQLCODE));
 END;
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура определения временного канала для опроса отдельной точки учета
   -- И. Вештак, 20.11.02
 PROCEDURE tempchannels(
  cid_          NUMBER, -- id канала
  mid_          NUMBER, -- id точки
  retries_      NUMBER, -- кол-во попыток
  retries_tout_ NUMBER, -- пауза м/у попытками
  vuser_        VARCHAR2) -- user
                          IS
  newcid NUMBER;
 BEGIN
  SELECT points_seq.NEXTVAL
    INTO newcid
    FROM DUAL;
  INSERT INTO points
              (mid, parent, name, cod, ind, calc_count, ovv_count, ptype, implement_date)
   (SELECT newcid, 1, p.name || '. ' || vname, 0, 2, 0, 0, 1, SYSDATE
      FROM channels c, points p
     WHERE c.cid = cid_ AND p.mid = mid_);
  INSERT INTO channels
              (cid, vname, protocol_id, com_id, init_str, addr, cycle_tout, retries, retries_tout, blocking, caller_name,
               nbilldata, nbilldatadepth, ncurrdata, ncurrdatadepth, nnotreadcurr, vuser, nkind, nparent)
   (SELECT newcid, p.name || '. ' || vname, protocol_id, com_id, init_str, addr, 86400, retries_, retries_tout_, 0,
           caller_name, 1, 199, 1, 39, 0, vuser_, 1, NULL
      FROM channels c, points p
     WHERE c.cid = cid_ AND p.mid = mid_);
  INSERT INTO chanpoint
              (cid, mid)
       VALUES (newcid, mid_);
  COMMIT;
 EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
   NULL;
  WHEN OTHERS THEN
   RAISE;
 END;
------------------------------------------------------------------------------------------------------------------------


END; -- Package Body
/

-- End of DDL script for CHANNELS_PG

-- Start of DDL script for CHECK_PG
-- Generated 27-янв-03  11:34:00 am
-- from oe-RYDA:1

-- Package body CHECK_PG

CREATE OR REPLACE
Package Body      CHECK_PG
IS
--
-- Purpose: Процедуры верификации
--
-- MODIFICATION HISTORY
-- Person      Date    Comments
-- ---------   ------  ------------------------------------------
-- Вештак      09.01.03 Создан


  PROCEDURE by_duplicate
    ( an_maket IN number, ddate_ IN date) is
    check_id number default 6;
    limit    number;
    str      varchar2(50);
    sgn      number default 1;
  begin
    limit := to_number(file_pg.gv_param) / 100;
    if limit < 0 then limit := -limit; sgn := -1; end if;
    delete from check_results where ddate = ddate_ and nprocedure = check_id;
    insert into check_results (ddate, mid, nprocedure, vparam, nmustbe, nindeed)
      select ddate_, a.mid, check_id, limit*100, sum(abs(nvl(a.er,0)-nvl(a.ed,0))), sum(abs(nvl(b.er,0)-nvl(b.ed,0)))
      from halfhourold a, halfhourold b
      where b.mid = a.mid and b.date_time = a.date_time and a.date_time > ddate_
      and a.date_time <= ddate_ + 1
      and a.nsource = 10 and b.nsource = 20
      group by a.mid
      having
      sgn *
      abs(sum(abs(nvl(a.er,0)-nvl(a.ed,0)))-sum(abs(nvl(b.er,0)-nvl(b.ed,0)))) >
      limit * sum(abs(nvl(a.er,0)-nvl(a.ed,0)));
    if sql%rowcount = 0 then
      delete from check_status where nprocedure = check_id and ddate = ddate_;
      if sql%rowcount <> 0 then
        insert into journal (date_time, mid, state_cod, state_descr, submit)
        values (sysdate, check_id, 0, to_char(ddate_,'dd.mm.yy')||' норма при допустимом отклонении '||limit*100||'%',null);
      end if;
    else
      if sql%rowcount = 1 then
        str := 'одной позиции.';
      else
        str := sql%rowcount||' позициям.';
      end if;
      begin
        insert into check_status (nprocedure, ddate, vtext)
        values (check_id, ddate_,
        'Сверка по дублям: превышено допустимое отклонение '||limit*100||'% по '||str);
        insert into journal (date_time, mid, state_cod, state_descr)
        values (sysdate, check_id, 1,
        to_char(ddate_,'dd.mm.yy')||' превышено допустимое отклонение '||limit*100||'% по '||str);
      exception when others then
        update check_status set
        vtext = 'Сверка по дублям: превышено допустимое отклонение '||limit*100||'% по '||str
        where nprocedure = check_id and ddate = ddate_;
      end;
    end if;
    UPDATE journal_c SET date_time = SYSDATE;
    commit;
  end;

  PROCEDURE by_itekcoeff
    ( an_maket IN number, ddate_ IN date) is
    check_id number default 7;
    limit    number;
    str      varchar2(50);
    n        number;
    sgn      number default 1;
  begin
    limit := to_number(file_pg.gv_param) / 100;
    if limit < 0 then limit := -limit; sgn := -1; end if;
    delete from check_results where nprocedure = check_id;
    insert into check_results (ddate, mid, nprocedure, vparam, nmustbe, nindeed)
      select ddate_, i.mid, check_id, limit*100, ker, f.kc/mconst from itekcoeff i, feeders f, meters m
      where f.mid = i.mid and m.mid = i.mid and m.entype = 1 and ker is not null
      and sgn*abs(ker - f.kc/mconst)/ker > limit;
    n := sql%rowcount;
    insert into check_results (ddate, mid, nprocedure, vparam, nmustbe, nindeed)
      select ddate_, i.mid, check_id, limit*100, ked, f.kc/mconst from itekcoeff i, feeders f, meters m
      where f.mid = i.mid and m.mid = i.mid and m.entype = 2 and ked is not null
      and sgn*abs(ked - f.kc/mconst)/ked > limit;
    n := n + sql%rowcount;
    if n = 0 then
      delete from check_status where nprocedure = check_id;
      if sql%rowcount <> 0 then
        insert into journal (date_time, mid, state_cod, state_descr, submit)
        values (sysdate, check_id, 0, 'Норма при допустимом отклонении '||limit*100||'%',null);
      end if;
    else
      if n = 1 then
        str := 'одной позиции.';
      else
        str := n||' позициям.';
      end if;
      begin
        insert into check_status (nprocedure, ddate, vtext)
        values (check_id, to_date('01.01.3000','dd.mm.yyyy'),
        'Сверка параметров УСД Итек: превышено допустимое отклонение '||limit*100||'% по '||str);
        insert into journal (date_time, mid, state_cod, state_descr)
        values (sysdate, check_id, 1,
        'Превышено допустимое отклонение '||limit*100||'% по '||str);
      exception when others then
        update check_status set
        vtext = 'Сверка параметров УСД Итек: превышено допустимое отклонение '||limit*100||'% по '||str
        where nprocedure = check_id and ddate = to_date('01.01.3000','dd.mm.yyyy');
      end;
    end if;
    UPDATE journal_c SET date_time = SYSDATE;
    commit;
  end;

  PROCEDURE by_mtrsn
    ( an_maket IN number, ddate_ IN date) is
    check_id number default 8;
    limit    number;
    str      varchar2(50);
  begin
    delete from check_results where nprocedure = check_id;
    insert into check_results (ddate, mid, nprocedure, vparam, nmustbe, nindeed)
      select ddate_, f.mid, check_id, 0, m.mtrsn, f.canal from feeders f, meters m
      where m.mid = f.mid and m.entype = 1 and f.canal > 50000000
      and f.canal <> to_number(m.mtrsn);
    if sql%rowcount = 0 then
      delete from check_status where nprocedure = check_id;
      if sql%rowcount <> 0 then
        insert into journal (date_time, mid, state_cod, state_descr, submit)
        values (sysdate, check_id, 0, 'Устранены несовпадения заводских и связных номеров.',null);
      end if;
    else
      if sql%rowcount = 1 then
        str := 'одной позиции.';
      else
        str := sql%rowcount||' позициям.';
      end if;
      begin
        insert into check_status (nprocedure, ddate, vtext)
        values (check_id, to_date('01.01.3000','dd.mm.yyyy'),
        'Сверка связных номеров: нет совпадения с з-д номерами по '||str);
        insert into journal (date_time, mid, state_cod, state_descr)
        values (sysdate, check_id, 1,
        ' Нет совпадения с з-д номерами по '||str);
      exception when others then
        update check_status set
        vtext = 'Сверка связных номеров: нет совпадения с з-д номерами по '||str
        where nprocedure = check_id and ddate = to_date('01.01.3000','dd.mm.yyyy');
      end;
    end if;
    UPDATE journal_c SET date_time = SYSDATE;
    commit;
  end;

  PROCEDURE by_day_expense
    (an_maket IN number, ddate_ IN date) is
    check_id number default 9;
    limit    number;
    str      varchar2(50);
    sgn      number default 1;
  begin
    limit := to_number(file_pg.gv_param) / 100;
    if limit < 0 then limit := -limit; sgn := -1; end if;
    delete from check_results where nprocedure = check_id and ddate = ddate_;
    insert into check_results (ddate, mid, nprocedure, vparam, nmustbe, nindeed)
      select ddate_, b.mid, check_id, limit*100, abs(nvl(o.er,0) - nvl(o.ed,0)), abs(nvl(b.er,0) - nvl(b.ed,0))
      from itekcoeff i, bill b, billorg o
      where b.mid = i.mid and o.mid = b.mid
      and b.date_time = ddate_+1 and o.date_time = b.date_time
      and
      sgn *
      abs(abs(nvl(b.er,0) - nvl(b.ed,0)) - abs(nvl(o.er,0) - nvl(o.ed,0))) >
      limit * abs(nvl(o.er,0) - nvl(o.ed,0));
    if sql%rowcount = 0 then
      delete from check_status where nprocedure = check_id and ddate = ddate_;
      if sql%rowcount <> 0 then
        insert into journal (date_time, mid, state_cod, state_descr, submit)
        values (sysdate, check_id, 0, to_char(ddate_,'dd.mm.yy')||' норма при допустимом отклонении '||limit*100||'%',null);
      end if;
    else
      if sql%rowcount = 1 then
        str := 'одной позиции.';
      else
        str := sql%rowcount||' позициям.';
      end if;
      begin
        insert into check_status (nprocedure, ddate, vtext)
        values (check_id, ddate_,
        'Сверка суточных расходов: превышено допустимое отклонение '||limit*100||'% по '||str);
        insert into journal (date_time, mid, state_cod, state_descr)
        values (sysdate, check_id, 1,
        to_char(ddate_,'dd.mm.yy')||' превышено допустимое отклонение '||limit*100||'% по '||str);
      exception when others then
        update check_status set
        vtext = 'Сверка суточных расходов: превышено допустимое отклонение '||limit*100||'% по '||str
        where nprocedure = check_id and ddate = ddate_;
      end;
    end if;
    UPDATE journal_c SET date_time = SYSDATE;
    commit;
  end;

  PROCEDURE by_month_expense
    (an_maket IN number, ddate1_ IN date) is
    check_id number default 10;
    limit    number;
    ddate_   date;
    str      varchar2(50);
    n        number;
    sgn      number default 1;
  begin
    select trunc(ddate1_,'mm') into ddate_ from dual;
    limit := to_number(file_pg.gv_param) / 100;
    if limit < 0 then limit := -limit; sgn := -1; end if;
    delete from check_results where nprocedure = check_id and ddate = ddate_;
    insert into check_results (ddate, mid, nprocedure, vparam, nmustbe, nindeed)
      select ddate_, m.mid, check_id, limit*100, abs(nvl(m.er, 0) - nvl(m.ed, 0)), bbb
      from monthsorg m,
      (select mid, nsource bsource, abs(sum(nvl(er, 0)) - sum(nvl(ed, 0))) bbb from halfhourold
      where date_time > ddate_
      and date_time <= add_months(ddate_, 1)
      and nsource in (10, 20)
      and mid < 100000000
      group by mid, nsource) b
      where b.mid = m.mid
      and ((m.nsource = 10 and bsource = 10)
      or (m.nsource = 20 and bsource = 20 and m.mid in (select mid from feeders where canal > 50000000))
      or (m.nsource = 20 and bsource = 10 and m.mid in (select mid from feeders where canal < 50000000)))
      and m.date_time = add_months(ddate_, 1)
      and
      sgn *
      abs(abs(nvl(m.er, 0) - nvl(m.ed, 0)) - bbb) >
      limit * abs(nvl(m.er, 0) - nvl(m.ed, 0));
    n := sql%rowcount;
    if n = 0 then
      delete from check_status where nprocedure = check_id and ddate = ddate_;
      if sql%rowcount <> 0 then
        insert into journal (date_time, mid, state_cod, state_descr, submit)
        values (sysdate, check_id, 0, to_char(ddate_,'mm.yyyy')||' норма при допустимом отклонении '||limit*100||'%',null);
      end if;
    else
      if n = 1 then
        str := 'одной позиции.';
      else
        str := n||' позициям.';
      end if;
      begin
        insert into check_status (nprocedure, ddate, vtext)
        values (check_id, ddate_,
        'Сверка месячных расходов: превышено допустимое отклонение '||limit*100||'% по '||str);
        insert into journal (date_time, mid, state_cod, state_descr)
        values (sysdate, check_id, 1,
        to_char(ddate_,'mm.yyyy')||' превышено допустимое отклонение '||limit*100||'% по '||str);
      exception when others then
        update check_status set
        vtext = 'Сверка месячных расходов: превышено допустимое отклонение '||limit*100||'% по '||str
        where nprocedure = check_id and ddate = ddate_;
      end;
    end if;
    UPDATE journal_c SET date_time = SYSDATE;
    commit;
  end;

  PROCEDURE by_balance
    (an_maket IN number, ddate_ IN date) is
    check_id number default 11;
    limit    number;
    str      varchar2(50);
    sgn      number default 1;
  begin
    limit := to_number(file_pg.gv_param) / 100;
    if limit < 0 then limit := -limit; sgn := -1; end if;
    delete from check_results where nprocedure = check_id and ddate = ddate_;
    insert into check_results (ddate, mid, nprocedure, vparam, nmustbe, nindeed)
      select ddate_, a.mid, check_id, limit*100, abs(sum(nvl(er, 0)) - sum(nvl(ed, 0))), bbb
      from halfhourold a,
      (select abs(sum(nvl(er, 0)) - sum(nvl(ed, 0))) bbb from halfhourold
      where nexceptcalc is null
      and mid in (select mid from points where parent = 32804 and mid not in (1155,1161))
      and date_time > ddate_
      and date_time <= ddate_+1) b
      where nexceptcalc is null
      and mid = 1155
      and date_time > ddate_
      and date_time <= ddate_+1
      group by mid, bbb
      having
      sgn *
      abs(abs(sum(nvl(er, 0)) - sum(nvl(ed, 0)))-bbb) >
      limit * abs(sum(nvl(er, 0)) - sum(nvl(ed, 0)));
    if sql%rowcount = 0 then
      delete from check_status where nprocedure = check_id and ddate = ddate_;
      if sql%rowcount <> 0 then
        insert into journal (date_time, mid, state_cod, state_descr, submit)
        values (sysdate, check_id, 0, to_char(ddate_,'dd.mm.yy')||' норма при допустимом отклонении '||limit*100||'%',null);
      end if;
    else
      if sql%rowcount = 1 then
        str := 'одной позиции.';
      else
        str := sql%rowcount||' позициям.';
      end if;
      begin
        insert into check_status (nprocedure, ddate, vtext)
        values (check_id, ddate_,
        'Сверка по балансам шин: превышено допустимое отклонение '||limit*100||'% по '||str);
        insert into journal (date_time, mid, state_cod, state_descr)
        values (sysdate, check_id, 1,
        to_char(ddate_,'dd.mm.yy')||' превышено допустимое отклонение '||limit*100||'% по '||str);
      exception when others then
        update check_status set
        vtext = 'Сверка по балансам шин: превышено допустимое отклонение '||limit*100||'% по '||str
        where nprocedure = check_id and ddate = ddate_;
      end;
    end if;
    UPDATE journal_c SET date_time = SYSDATE;
    commit;
  end;

  PROCEDURE by_OV
    (an_maket IN number, ddate_ IN date) is
    check_id number default 12;
    limit    number;
    str      varchar2(50);
    sgn      number default 1;
  begin
    limit := to_number(file_pg.gv_param) / 100;
    if limit < 0 then limit := -limit; sgn := -1; end if;
    delete from check_results where nprocedure = check_id and ddate = ddate_;
    insert into check_results (ddate, mid, nprocedure, vparam, nmustbe, nindeed)
      select ddate_, a.nswitch, check_id, limit*100, aaa, bbb
      from
      (select nswitch, abs(sum(nvl(er, 0)) - sum(nvl(ed, 0))) bbb
      from halfhourold where nswitch is not null
      and nexceptcalc is null
      and date_time > ddate_
      and date_time <= ddate_+1
      group by nswitch) a,
      (select mid, abs(sum(nvl(er, 0)) - sum(nvl(ed, 0))) aaa
      from halfhourold where
      nsource = 10 and nexceptcalc is not null
      and mid in (select mid from feeders where nswitch <> 0)
      and date_time > ddate_
      and date_time <= ddate_+1
      group by mid) b
      where a.nswitch = b.mid
      and sgn*abs(aaa - bbb) > limit * aaa;
    if sql%rowcount = 0 then
      delete from check_status where nprocedure = check_id and ddate = ddate_;
      if sql%rowcount <> 0 then
        insert into journal (date_time, mid, state_cod, state_descr, submit)
        values (sysdate, check_id, 0, to_char(ddate_,'dd.mm.yy')||' норма при допустимом отклонении '||limit*100||'%',null);
      end if;
    else
      if sql%rowcount = 1 then
        str := 'одной позиции.';
      else
        str := sql%rowcount||' позициям.';
      end if;
      begin
        insert into check_status (nprocedure, ddate, vtext)
        values (check_id, ddate_,
        'Сверка переключений ОВ: превышено допустимое отклонение '||limit*100||'% по '||str);
        insert into journal (date_time, mid, state_cod, state_descr)
        values (sysdate, check_id, 1,
        to_char(ddate_,'dd.mm.yy')||' превышено допустимое отклонение '||limit*100||'% по '||str);
      exception when others then
        update check_status set
        vtext = 'Сверка переключений ОВ: превышено допустимое отклонение '||limit*100||'% по '||str
        where nprocedure = check_id and ddate = ddate_;
      end;
    end if;
    UPDATE journal_c SET date_time = SYSDATE;
    commit;
  end;



END; -- Package Body CHECK_PG
/

-- End of DDL script for CHECK_PG

-- Start of DDL script for COMMON_PG
-- Generated 27-янв-03  11:34:00 am
-- from oe-RYDA:1

-- Package body COMMON_PG

CREATE OR REPLACE
PACKAGE BODY common_pg IS
 ------------------------------------------------------------------------------------------------------------------------
   -- пакет для всех АСКУЭ
   -- дата создания 10/12/2002 Сечин А.А.
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура установки параметров сессии;
 PROCEDURE begin_p IS
 BEGIN
  admin_pg.begin_p;
 END; -- begin_p
------------------------------------------------------------------------------------------------------------------------
 FUNCTION geterrtext(an_err IN NUMBER)
  RETURN VARCHAR2 IS
 BEGIN
  IF an_err = 1 THEN
   RETURN 'Неправильно указан путь или имя файла ';
  ELSIF an_err = 2 THEN
   RETURN 'Файл не может быть открыт ';
  ELSIF an_err = 3 THEN
   RETURN 'Файл не был открыт ';
  ELSIF an_err = 4 THEN
   RETURN 'Ошибка ОС при записи в файл ';
  ELSE
   RETURN 'Неизвестная ошибка при работе с файловой системой';
  END IF;
 END;
 -------------------------------------------------------------------------------------------------
END; -- Package Body COMMON_PG
/

-- End of DDL script for COMMON_PG

-- Start of DDL script for COMSRV_PG
-- Generated 27-янв-03  11:34:00 am
-- from oe-RYDA:1

-- Package body COMSRV_PG

CREATE OR REPLACE
PACKAGE BODY COMSRV_PG IS
 ------------------------------------------------------------------------------------------------------------------------
    -- Интерфейс взаимодействия БД с Носиком А.В.
    -- дата создания 30/11/2001 Сечин А.А.
 ------------------------------------------------------------------------------------------------------------------------
 --******************************          Itek 210             *******************************************************--
 ------------------------------------------------------------------------------------------------------------------------
  --Вставка коэффициентов
 PROCEDURE set_coeffic_itek(an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER) IS
  qqq NUMBER;
 BEGIN
  SELECT MAX(1)
    INTO qqq
    FROM itekcoeff
   WHERE mid = an_mid;
  IF qqq IS NULL THEN
   INSERT INTO itekcoeff
               (mid, date_time)
        VALUES (an_mid, SYSDATE);
  END IF;
  UPDATE itekcoeff
     SET date_time = SYSDATE,
         ker = an_er,
         ked = an_ed,
         kq1 = an_q1,
         kq3 = an_q3
   WHERE mid = an_mid;
 END;
 ------------------------------------------------------------------------------------------------------------------------
  --Вставка 3-х минуток
 PROCEDURE set_profile_itek(an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, ad_date DATE) IS
  ln_er NUMBER DEFAULT an_er;
  ln_ed NUMBER DEFAULT an_ed;
  ln_q1 NUMBER DEFAULT an_q1;
  ln_q3 NUMBER DEFAULT an_q3;
 BEGIN
  util_pg.chdr(an_mid, ln_er, ln_ed, ln_q1, ln_q3);
  UPDATE curr_power
     SET er = ln_er * 20,
         ed = ln_ed * 20,
         q1 = ln_q1 * 20,
         q3 = ln_q3 * 20,
         obsolete = 0,
         date_time = ad_date
   WHERE mid = an_mid;
  INSERT INTO PROFILE
              (mid, date_time, er, ed, q1, q3)
       VALUES (an_mid, ad_date, ln_er, ln_ed, ln_q1, ln_q3);
 EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
   UPDATE PROFILE
      SET er = ln_er,
          ed = ln_ed,
          q1 = ln_q1,
          q3 = ln_q3
    WHERE mid = an_mid AND date_time = ad_date;
  WHEN OTHERS THEN
   RAISE;
 END;
 ------------------------------------------------------------------------------------------------------------------------
  --Вставка графика нагрузки
 PROCEDURE set_halfhour_itek(an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, ad_date DATE) IS
  ln_er NUMBER DEFAULT an_er;
  ln_ed NUMBER DEFAULT an_ed;
  ln_q1 NUMBER DEFAULT an_q1;
  ln_q3 NUMBER DEFAULT an_q3;
 BEGIN
  util_pg.chdr(an_mid, ln_er, ln_ed, ln_q1, ln_q3);
  INSERT INTO halfhourtmp
              (mid, date_time, nsource, er, ed, q1, q3)
       VALUES (an_mid, ad_date, cn_itek, ln_er, ln_ed, ln_q1, ln_q3);
 EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
   UPDATE halfhourtmp
      SET er = ln_er,
          ed = ln_ed,
          q1 = ln_q1,
          q3 = ln_q3
    WHERE mid = an_mid AND date_time = ad_date AND nsource = cn_itek;
  WHEN OTHERS THEN
   RAISE;
 END;
 ------------------------------------------------------------------------------------------------------------------------
  --Вставка суточных
 PROCEDURE set_bill_itek(
  an_mid  NUMBER,
  an_er   NUMBER,
  an_ed   NUMBER,
  an_q1   NUMBER,
  an_q3   NUMBER,
  an_zone NUMBER, --1-A, 2-B, 3-C,4-D. иначе общий
  ad_date DATE) IS
  ln_er NUMBER DEFAULT an_er;
  ln_ed NUMBER DEFAULT an_ed;
  ln_q1 NUMBER DEFAULT an_q1;
  ln_q3 NUMBER DEFAULT an_q3;
 BEGIN
  util_pg.chdr(an_mid, ln_er, ln_ed, ln_q1, ln_q3);
  IF an_zone = 1 THEN
   UPDATE billorg
      SET aer = ln_er,
          aed = ln_ed,
          aq1 = ln_q1,
          aq3 = ln_q3
    WHERE mid = an_mid AND date_time = ad_date and nsource=cn_itek;
  ELSIF an_zone = 2 THEN
   UPDATE billorg
      SET ber = ln_er,
          bed = ln_ed,
          bq1 = ln_q1,
          bq3 = ln_q3
    WHERE mid = an_mid AND date_time = ad_date and nsource=cn_itek;
  ELSIF an_zone = 3 THEN
   UPDATE billorg
      SET cer = ln_er,
          ced = ln_ed,
          cq1 = ln_q1,
          cq3 = ln_q3
    WHERE mid = an_mid AND date_time = ad_date and nsource=cn_itek;
  ELSIF an_zone = 4 THEN
   UPDATE billorg
      SET der = ln_er,
          ded = ln_ed,
          dq1 = ln_q1,
          dq3 = ln_q3
    WHERE mid = an_mid AND date_time = ad_date and nsource=cn_itek;
  ELSE
   UPDATE billorg
      SET er = ln_er,
          ed = ln_ed,
          q1 = ln_q1,
          q3 = ln_q3
    WHERE mid = an_mid AND date_time = ad_date and nsource=cn_itek;
  END IF;
  IF SQL%ROWCOUNT = 0 THEN
   IF an_zone = 1 THEN
    INSERT INTO billorg
                (mid, date_time, aer, aed, aq1, aq3,nsource)
         VALUES (an_mid, ad_date, ln_er, ln_ed, ln_q1, ln_q3,cn_itek);
   ELSIF an_zone = 2 THEN
    INSERT INTO billorg
                (mid, date_time, ber, bed, bq1, bq3,nsource)
         VALUES (an_mid, ad_date, ln_er, ln_ed, ln_q1, ln_q3,cn_itek);
   ELSIF an_zone = 3 THEN
    INSERT INTO billorg
                (mid, date_time, cer, ced, cq1, cq3,nsource)
         VALUES (an_mid, ad_date, ln_er, ln_ed, ln_q1, ln_q3,cn_itek);
   ELSIF an_zone = 4 THEN
    INSERT INTO billorg
                (mid, date_time, der, ded, dq1, dq3,nsource)
         VALUES (an_mid, ad_date, ln_er, ln_ed, ln_q1, ln_q3,cn_itek);
   ELSE
    INSERT INTO billorg
                (mid, date_time, er, ed, q1, q3,nsource)
         VALUES (an_mid, ad_date, ln_er, ln_ed, ln_q1, ln_q3,cn_itek);
   END IF;
  END IF;
 END;
 ------------------------------------------------------------------------------------------------------------------------
  --Вставка месячных
 PROCEDURE set_months_itek(
  an_mid  NUMBER,
  an_er   NUMBER,
  an_ed   NUMBER,
  an_q1   NUMBER,
  an_q3   NUMBER,
  an_zone NUMBER, --1-A, 2-B, 3-C,4-D. иначе общий
  ad_date DATE) IS
  ln_er NUMBER DEFAULT an_er;
  ln_ed NUMBER DEFAULT an_ed;
  ln_q1 NUMBER DEFAULT an_q1;
  ln_q3 NUMBER DEFAULT an_q3;
 BEGIN
  util_pg.chdr(an_mid, ln_er, ln_ed, ln_q1, ln_q3);
  IF an_zone = 1 THEN
   UPDATE monthsorg
      SET aer = ln_er,
          aed = ln_ed,
          aq1 = ln_q1,
          aq3 = ln_q3
    WHERE mid = an_mid AND date_time = ad_date and nsource=cn_itek;
  ELSIF an_zone = 2 THEN
   UPDATE monthsorg
      SET ber = ln_er,
          bed = ln_ed,
          bq1 = ln_q1,
          bq3 = ln_q3
    WHERE mid = an_mid AND date_time = ad_date and nsource=cn_itek;
  ELSIF an_zone = 3 THEN
   UPDATE monthsorg
      SET cer = ln_er,
          ced = ln_ed,
          cq1 = ln_q1,
          cq3 = ln_q3
    WHERE mid = an_mid AND date_time = ad_date and nsource=cn_itek;
  ELSIF an_zone = 4 THEN
   UPDATE monthsorg
      SET der = ln_er,
          ded = ln_ed,
          dq1 = ln_q1,
          dq3 = ln_q3
    WHERE mid = an_mid AND date_time = ad_date and nsource=cn_itek;
  ELSE
   UPDATE monthsorg
      SET er = ln_er,
          ed = ln_ed,
          q1 = ln_q1,
          q3 = ln_q3
    WHERE mid = an_mid AND date_time = ad_date and nsource=cn_itek;
  END IF;
  IF SQL%ROWCOUNT = 0 THEN
   IF an_zone = 1 THEN
    INSERT INTO monthsorg
                (mid, date_time, aer, aed, aq1, aq3,nsource)
         VALUES (an_mid, ad_date, ln_er, ln_ed, ln_q1, ln_q3,cn_itek);
   ELSIF an_zone = 2 THEN
    INSERT INTO monthsorg
                (mid, date_time, ber, bed, bq1, bq3,nsource)
         VALUES (an_mid, ad_date, ln_er, ln_ed, ln_q1, ln_q3,cn_itek);
   ELSIF an_zone = 3 THEN
    INSERT INTO monthsorg
                (mid, date_time, cer, ced, cq1, cq3,nsource)
         VALUES (an_mid, ad_date, ln_er, ln_ed, ln_q1, ln_q3,cn_itek);
   ELSIF an_zone = 4 THEN
    INSERT INTO monthsorg
                (mid, date_time, der, ded, dq1, dq3,nsource)
         VALUES (an_mid, ad_date, ln_er, ln_ed, ln_q1, ln_q3,cn_itek);
   ELSE
    INSERT INTO monthsorg
                (mid, date_time, er, ed, q1, q3,nsource)
         VALUES (an_mid, ad_date, ln_er, ln_ed, ln_q1, ln_q3,cn_itek);
   END IF;
  END IF;
 END;
 ------------------------------------------------------------------------------------------------------------------------
 --******************************          L                  *******************************************************--
 ------------------------------------------------------------------------------------------------------------------------
   --Статус LG
 PROCEDURE mark_lgstatus(
  newmid       IN     NUMBER,
  newdate_time IN     DATE,
  newt         IN     NUMBER,
  newu         IN     NUMBER,
  news         IN     NUMBER,
  newm         IN     NUMBER,
  newkt        IN     NUMBER,
  newl1        IN OUT NUMBER,
  newl2        IN OUT NUMBER,
  newl3        IN OUT NUMBER) IS
  ld_date DATE;
  t       NUMBER;
  u       NUMBER;
  s       NUMBER;
  m       NUMBER;
  kt      NUMBER;
  l1      NUMBER;
  l2      NUMBER;
  l3      NUMBER;
  ll      NUMBER;
  code    NUMBER;
  message VARCHAR2(2000);
  qqq     NUMBER;
 BEGIN
  code := 0;
  message := NULL;
  SELECT NVL(MAX(date_time), SYSDATE - 365), NVL(MAX(t), 0), NVL(MAX(u), 0), NVL(MAX(s), 0), NVL(MAX(m), 0),
         NVL(MAX(l1), 0), NVL(MAX(l2), 0), NVL(MAX(l3), 0), MAX(1)
    INTO ld_date, t, u, s, m,
         l1, l2, l3, qqq
    FROM lgstatus
   WHERE mid = newmid;
  IF qqq IS NULL THEN
   INSERT INTO lgstatus
               (mid, date_time, t, u, s, m, kt, l1, l2, l3)
        VALUES (newmid, SYSDATE - 365, 0, 0, 0, 0, 0, 0, 0, 0);
  END IF;
  SELECT NVL(nabc, 0)
    INTO ll
    FROM feeders
   WHERE mid = newmid;
  IF ll = 0 THEN -- для двухэлементных счетчиков фаза В есть всегда
   l2 := 1;
   newl2 := 1;
  END IF;
  IF newu = 0 THEN
   newl1 := l1;
   newl2 := l2;
   newl3 := l3;
  END IF;
  IF news <> s THEN
   code := -1002;
   message := ' Смена сезона.';
   INSERT INTO journal
               (date_time, mid, state_cod, state_descr)
        VALUES (newdate_time, newmid, code, message);
  END IF;
  IF newt <> 0 THEN
   code := -1001;
   message := ' Коррекция часов.';
   INSERT INTO journal
               (date_time, mid, state_cod, state_descr)
        VALUES (newdate_time, newmid, code, message);
  END IF;
  IF newm <> 0 THEN
   code := -1003;
   message := ' Проведена параметризация счетчика.';
   INSERT INTO journal
               (date_time, mid, state_cod, state_descr)
        VALUES (newdate_time, newmid, code, message);
  END IF;
  IF  newu <> u AND newu = 1 THEN
   code := -1010;
   /*   message := ' Включение напряжения. Время простоя: ' ||
                 ROUND(TO_NUMBER(newdate_time - ld_date) * 24 * 60, 2) || ' мин.';*/
   message := ' Включение напряжения.';
   INSERT INTO journal
               (date_time, mid, state_cod, state_descr)
        VALUES (newdate_time, newmid, code, message);
  END IF;
  IF  newl1 <> l1 AND newl1 <> 0 AND newu <> 0 THEN
   code := -1005;
   message := ' Есть фаза А.';
   INSERT INTO journal
               (date_time, mid, state_cod, state_descr)
        VALUES (newdate_time, newmid, code, message);
  END IF;
  IF  newl2 <> l2 AND newl2 <> 0 AND newu <> 0 THEN
   code := -1005;
   message := ' Есть фаза B.';
   INSERT INTO journal
               (date_time, mid, state_cod, state_descr)
        VALUES (newdate_time, newmid, code, message);
  END IF;
  IF  newl3 <> l3 AND newl3 <> 0 AND newu <> 0 THEN
   code := -1005;
   message := ' Есть фаза C.';
   INSERT INTO journal
               (date_time, mid, state_cod, state_descr)
        VALUES (newdate_time, newmid, code, message);
  END IF;
  IF  newl1 <> l1 AND newl1 = 0 AND newu <> 0 THEN
   code := 1005;
   message := ' Нет фазы А.';
   INSERT INTO journal
               (date_time, mid, state_cod, state_descr)
        VALUES (newdate_time, newmid, code, message);
  END IF;
  IF  newl2 <> l2 AND newl2 = 0 AND newu <> 0 THEN
   code := 1005;
   message := ' Нет фазы B.';
   INSERT INTO journal
               (date_time, mid, state_cod, state_descr)
        VALUES (newdate_time, newmid, code, message);
  END IF;
  IF  newl3 <> l3 AND newl3 = 0 AND newu <> 0 THEN
   code := 1005;
   message := ' Нет фазы C.';
   INSERT INTO journal
               (date_time, mid, state_cod, state_descr)
        VALUES (newdate_time, newmid, code, message);
  END IF;
  IF  newu <> u AND newu = 0 THEN
   code := 1010;
   message := ' Включение счетчика после отключения напряжения.';
   INSERT INTO journal
               (date_time, mid, state_cod, state_descr)
        VALUES (newdate_time, newmid, code, message);
  END IF;
  IF code <> 0 THEN
   UPDATE lgstatus
      SET date_time = newdate_time,
          t = newt,
          u = newu,
          s = news,
          m = newm,
          kt = newkt,
          l1 = newl1,
          l2 = newl2,
          l3 = newl3
    WHERE mid = newmid;
  END IF;
  UPDATE journal_c
     SET date_time = SYSDATE;
 END;
 ------------------------------------------------------------------------------------------------------------------------
  --Вставка графика нагрузки
 PROCEDURE set_halfhour_zxb(
  an_mid    NUMBER,
  an_er     NUMBER,
  an_ed     NUMBER,
  an_q1     NUMBER,
  an_q3     NUMBER,
  an_status NUMBER,
  ad_date   DATE) IS
  ln_er NUMBER DEFAULT an_er;
  ln_ed NUMBER DEFAULT an_ed;
  ln_q1 NUMBER DEFAULT an_q1;
  ln_q3 NUMBER DEFAULT an_q3;
 BEGIN
  util_pg.chdr(an_mid, ln_er, ln_ed, ln_q1, ln_q3);
  INSERT INTO halfhourtmp
              (mid, date_time, nsource, er, ed, q1, q3, status)
       VALUES (an_mid, ad_date, cn_lg, ln_er, ln_ed, ln_q1, ln_q3, an_status);
 EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
   UPDATE halfhourtmp
      SET er = ln_er,
          ed = ln_ed,
          q1 = ln_q1,
          q3 = ln_q3,
          status = an_status
    WHERE mid = an_mid AND date_time = ad_date AND nsource = cn_lg;
  WHEN OTHERS THEN
   RAISE;
 END;
 ------------------------------------------------------------------------------------------------------------------------
   --Вставка листинга показаний
 PROCEDURE set_readout_zxb(an_mid NUMBER, at_data common_pg.tt_varchar2) IS
  ld_dat DATE DEFAULT SYSDATE;
 BEGIN
  SAVEPOINT set_readout_zxb_sp;
  FOR i IN 1 .. at_data.COUNT LOOP
   INSERT INTO lg_readout
               (mid, date_time, nsort, vdata)
        VALUES (an_mid, ld_dat, i, at_data(i));
  END LOOP;
 EXCEPTION
  WHEN OTHERS THEN
   ROLLBACK TO SAVEPOINT set_readout_zxb_sp;
   RAISE;
 END;
 ------------------------------------------------------------------------------------------------------------------------
  --Вставка листинга графика нвгрузки
 PROCEDURE set_loadprof_zxb(an_mid NUMBER, at_data common_pg.tt_varchar2) IS
  ld_dat DATE DEFAULT SYSDATE;
 BEGIN
  SAVEPOINT set_loadprof_zxb_sp;
  FOR i IN 1 .. at_data.COUNT LOOP
   INSERT INTO lg_loadprof
               (mid, date_time, nsort, vdata)
        VALUES (an_mid, ld_dat, i, at_data(i));
  END LOOP;
 EXCEPTION
  WHEN OTHERS THEN
   ROLLBACK TO SAVEPOINT set_loadprof_zxb_sp;
   RAISE;
 END;
 ------------------------------------------------------------------------------------------------------------------------
   --Вставка суточных
 PROCEDURE set_bill_zxb(
  an_mid    NUMBER,
  an_erm    NUMBER,
  an_edm    NUMBER,
  an_q1m    NUMBER,
  an_q3m    NUMBER,
  an_aerm   NUMBER,
  an_aedm   NUMBER,
  an_aq1m   NUMBER,
  an_aq3m   NUMBER,
  an_berm   NUMBER,
  an_bedm   NUMBER,
  an_bq1m   NUMBER,
  an_bq3m   NUMBER,
  an_cerm   NUMBER,
  an_cedm   NUMBER,
  an_cq1m   NUMBER,
  an_cq3m   NUMBER,
  an_derm   NUMBER,
  an_dedm   NUMBER,
  an_dq1m   NUMBER,
  an_dq3m   NUMBER,
  av_mtrsn  VARCHAR2,
  an_digits NUMBER, --Значность счетчика
  ad_date   DATE) IS
  CURSOR lcur_sel IS
   SELECT NVL(erm, 0) erm, NVL(edm, 0) edm, NVL(q1m, 0) q1m, NVL(q3m, 0) q3m, NVL(aerm, 0) aerm, NVL(aedm, 0) aedm,
          NVL(aq1m, 0) aq1m, NVL(aq3m, 0) aq3m, NVL(berm, 0) berm, NVL(bedm, 0) bedm, NVL(bq1m, 0) bq1m, NVL(bq3m, 0) bq3m,
          NVL(cerm, 0) cerm, NVL(cedm, 0) cedm, NVL(cq1m, 0) cq1m, NVL(cq3m, 0) cq3m, NVL(derm, 0) derm, NVL(dedm, 0) dedm,
          NVL(dq1m, 0) dq1m, NVL(dq3m, 0) dq3m
     FROM billorg
    WHERE mid = an_mid
      AND date_time = (SELECT MAX(date_time)
                         FROM billorg
                        WHERE mid = an_mid AND date_time < ad_date)
      AND UPPER(TRIM(er_mtrsn)) = UPPER(TRIM(av_mtrsn));
  lc       lcur_sel%ROWTYPE;
  lb_found BOOLEAN;
  ln_kc    NUMBER;
  ln_rn    NUMBER             DEFAULT 10;
  ln_erm   NUMBER             DEFAULT an_erm;
  ln_edm   NUMBER             DEFAULT an_edm;
  ln_q1m   NUMBER             DEFAULT an_q1m;
  ln_q3m   NUMBER             DEFAULT an_q3m;
  ln_aerm  NUMBER             DEFAULT an_aerm;
  ln_aedm  NUMBER             DEFAULT an_aedm;
  ln_aq1m  NUMBER             DEFAULT an_aq1m;
  ln_aq3m  NUMBER             DEFAULT an_aq3m;
  ln_berm  NUMBER             DEFAULT an_berm;
  ln_bedm  NUMBER             DEFAULT an_bedm;
  ln_bq1m  NUMBER             DEFAULT an_bq1m;
  ln_bq3m  NUMBER             DEFAULT an_bq3m;
  ln_cerm  NUMBER             DEFAULT an_cerm;
  ln_cedm  NUMBER             DEFAULT an_cedm;
  ln_cq1m  NUMBER             DEFAULT an_cq1m;
  ln_cq3m  NUMBER             DEFAULT an_cq3m;
  ln_derm  NUMBER             DEFAULT an_derm;
  ln_dedm  NUMBER             DEFAULT an_dedm;
  ln_dq1m  NUMBER             DEFAULT an_dq1m;
  ln_dq3m  NUMBER             DEFAULT an_dq3m;
  ln_er    NUMBER;
  ln_ed    NUMBER;
  ln_q1    NUMBER;
  ln_q3    NUMBER;
  ln_aer   NUMBER;
  ln_aed   NUMBER;
  ln_aq1   NUMBER;
  ln_aq3   NUMBER;
  ln_ber   NUMBER;
  ln_bed   NUMBER;
  ln_bq1   NUMBER;
  ln_bq3   NUMBER;
  ln_cer   NUMBER;
  ln_ced   NUMBER;
  ln_cq1   NUMBER;
  ln_cq3   NUMBER;
  ln_der   NUMBER;
  ln_ded   NUMBER;
  ln_dq1   NUMBER;
  ln_dq3   NUMBER;
 BEGIN
  OPEN lcur_sel;
  FETCH lcur_sel INTO lc;
  lb_found := lcur_sel%FOUND;
  CLOSE lcur_sel;
  IF lb_found THEN
   SELECT NVL(MAX(kc), 1)
     INTO ln_kc
     FROM feeders
    WHERE mid = an_mid;
   util_pg.chdr(an_mid, ln_erm, ln_edm, ln_q1m, ln_q3m);
   util_pg.chdr(an_mid, ln_aerm, ln_aedm, ln_aq1m, ln_aq3m);
   util_pg.chdr(an_mid, ln_berm, ln_bedm, ln_bq1m, ln_bq3m);
   util_pg.chdr(an_mid, ln_cerm, ln_cedm, ln_cq1m, ln_cq3m);
   util_pg.chdr(an_mid, ln_derm, ln_dedm, ln_dq1m, ln_dq3m);
   ln_er := ROUND(util_pg.indicoverturn(ln_erm - lc.erm, an_digits) * ln_kc, ln_rn);
   ln_ed := ROUND(util_pg.indicoverturn(ln_edm - lc.edm, an_digits) * ln_kc, ln_rn);
   ln_q1 := ROUND(util_pg.indicoverturn(ln_q1m - lc.q1m, an_digits) * ln_kc, ln_rn);
   ln_q3 := ROUND(util_pg.indicoverturn(ln_q3m - lc.q3m, an_digits) * ln_kc, ln_rn);
   ln_aer := ROUND(util_pg.indicoverturn(ln_aerm - lc.aerm, an_digits) * ln_kc, ln_rn);
   ln_aed := ROUND(util_pg.indicoverturn(ln_aedm - lc.aedm, an_digits) * ln_kc, ln_rn);
   ln_aq1 := ROUND(util_pg.indicoverturn(ln_aq1m - lc.aq1m, an_digits) * ln_kc, ln_rn);
   ln_aq3 := ROUND(util_pg.indicoverturn(ln_aq3m - lc.aq3m, an_digits) * ln_kc, ln_rn);
   ln_ber := ROUND(util_pg.indicoverturn(ln_berm - lc.berm, an_digits) * ln_kc, ln_rn);
   ln_bed := ROUND(util_pg.indicoverturn(ln_bedm - lc.bedm, an_digits) * ln_kc, ln_rn);
   ln_bq1 := ROUND(util_pg.indicoverturn(ln_bq1m - lc.bq1m, an_digits) * ln_kc, ln_rn);
   ln_bq3 := ROUND(util_pg.indicoverturn(ln_bq3m - lc.bq3m, an_digits) * ln_kc, ln_rn);
   ln_cer := ROUND(util_pg.indicoverturn(ln_cerm - lc.cerm, an_digits) * ln_kc, ln_rn);
   ln_ced := ROUND(util_pg.indicoverturn(ln_cedm - lc.cedm, an_digits) * ln_kc, ln_rn);
   ln_cq1 := ROUND(util_pg.indicoverturn(ln_cq1m - lc.cq1m, an_digits) * ln_kc, ln_rn);
   ln_cq3 := ROUND(util_pg.indicoverturn(ln_cq3m - lc.cq3m, an_digits) * ln_kc, ln_rn);
   ln_der := ROUND(util_pg.indicoverturn(ln_derm - lc.derm, an_digits) * ln_kc, ln_rn);
   ln_ded := ROUND(util_pg.indicoverturn(ln_dedm - lc.dedm, an_digits) * ln_kc, ln_rn);
   ln_dq1 := ROUND(util_pg.indicoverturn(ln_dq1m - lc.dq1m, an_digits) * ln_kc, ln_rn);
   ln_dq3 := ROUND(util_pg.indicoverturn(ln_dq3m - lc.dq3m, an_digits) * ln_kc, ln_rn);
   /*  util_pg.chdr(an_mid, ln_er, ln_ed, ln_q1, ln_q3);
     util_pg.chdr(an_mid, ln_aer, ln_aed, ln_aq1, ln_aq3);
     util_pg.chdr(an_mid, ln_ber, ln_bed, ln_bq1, ln_bq3);
     util_pg.chdr(an_mid, ln_cer, ln_ced, ln_cq1, ln_cq3);
     util_pg.chdr(an_mid, ln_der, ln_ded, ln_dq1, ln_dq3);*/
   INSERT INTO billorg
               (mid, er, ed, q1, q3, aer, aed, aq1, aq3, ber, bed, bq1, bq3,
                cer, ced, cq1, cq3, der, ded, dq1, dq3, erm, edm, q1m, q3m,
                aerm, aedm, aq1m, aq3m, berm, bedm, bq1m, bq3m, cerm, cedm, cq1m,
                cq3m, derm, dedm, dq1m, dq3m, er_mtrsn, q1_mtrsn, ed_mtrsn, q3_mtrsn, date_time, source)
        VALUES (an_mid, ln_er, ln_ed, ln_q1, ln_q3, ln_aer, ln_aed, ln_aq1, ln_aq3, ln_ber, ln_bed, ln_bq1, ln_bq3,
                ln_cer, ln_ced, ln_cq1, ln_cq3, ln_der, ln_ded, ln_dq1, ln_dq3, ln_erm, ln_edm, ln_q1m, ln_q3m,
                ln_aerm, ln_aedm, ln_aq1m, ln_aq3m, ln_berm, ln_bedm, ln_bq1m, ln_bq3m, ln_cerm, ln_cedm, ln_cq1m,
                ln_cq3m, ln_derm, ln_dedm, ln_dq1m, ln_dq3m, av_mtrsn, av_mtrsn, av_mtrsn, av_mtrsn, ad_date, 'КС');
  ELSE
   util_pg.chdr(an_mid, ln_erm, ln_edm, ln_q1m, ln_q3m);
   util_pg.chdr(an_mid, ln_aerm, ln_aedm, ln_aq1m, ln_aq3m);
   util_pg.chdr(an_mid, ln_berm, ln_bedm, ln_bq1m, ln_bq3m);
   util_pg.chdr(an_mid, ln_cerm, ln_cedm, ln_cq1m, ln_cq3m);
   util_pg.chdr(an_mid, ln_derm, ln_dedm, ln_dq1m, ln_dq3m);
   INSERT INTO billorg
               (mid, erm, edm, q1m, q3m, aerm, aedm, aq1m, aq3m, berm, bedm, bq1m,
                bq3m, cerm, cedm, cq1m, cq3m, derm, dedm, dq1m, dq3m, er_mtrsn, q1_mtrsn,
                ed_mtrsn, q3_mtrsn, date_time, source)
        VALUES (an_mid, ln_erm, ln_edm, ln_q1m, ln_q3m, ln_aerm, ln_aedm, ln_aq1m, ln_aq3m, ln_berm, ln_bedm, ln_bq1m,
                ln_bq3m, ln_cerm, ln_cedm, ln_cq1m, ln_cq3m, ln_derm, ln_dedm, ln_dq1m, ln_dq3m, av_mtrsn, av_mtrsn,
                av_mtrsn, av_mtrsn, ad_date, 'КС');
  END IF;
 END;
 ------------------------------------------------------------------------------------------------------------------------
   --Вставка месячных
 PROCEDURE set_months_zxb(
  an_mid    NUMBER,
  an_erm    NUMBER,
  an_edm    NUMBER,
  an_q1m    NUMBER,
  an_q3m    NUMBER,
  an_aerm   NUMBER,
  an_aedm   NUMBER,
  an_aq1m   NUMBER,
  an_aq3m   NUMBER,
  an_berm   NUMBER,
  an_bedm   NUMBER,
  an_bq1m   NUMBER,
  an_bq3m   NUMBER,
  an_cerm   NUMBER,
  an_cedm   NUMBER,
  an_cq1m   NUMBER,
  an_cq3m   NUMBER,
  an_derm   NUMBER,
  an_dedm   NUMBER,
  an_dq1m   NUMBER,
  an_dq3m   NUMBER,
  av_mtrsn  VARCHAR2,
  an_digits NUMBER, --Значность счетчика
  ad_date   DATE) IS
  CURSOR lcur_sel IS
   SELECT NVL(erm, 0) erm, NVL(edm, 0) edm, NVL(q1m, 0) q1m, NVL(q3m, 0) q3m, NVL(aerm, 0) aerm, NVL(aedm, 0) aedm,
          NVL(aq1m, 0) aq1m, NVL(aq3m, 0) aq3m, NVL(berm, 0) berm, NVL(bedm, 0) bedm, NVL(bq1m, 0) bq1m, NVL(bq3m, 0) bq3m,
          NVL(cerm, 0) cerm, NVL(cedm, 0) cedm, NVL(cq1m, 0) cq1m, NVL(cq3m, 0) cq3m, NVL(derm, 0) derm, NVL(dedm, 0) dedm,
          NVL(dq1m, 0) dq1m, NVL(dq3m, 0) dq3m
     FROM months
    WHERE mid = an_mid
      AND date_time = (SELECT MAX(date_time)
                         FROM months
                        WHERE mid = an_mid AND date_time < ad_date)
      AND UPPER(TRIM(er_mtrsn)) = UPPER(TRIM(av_mtrsn));
  lc       lcur_sel%ROWTYPE;
  lb_found BOOLEAN;
  ln_kc    NUMBER;
  ln_rn    NUMBER             DEFAULT 10;
  ln_erm   NUMBER             DEFAULT an_erm;
  ln_edm   NUMBER             DEFAULT an_edm;
  ln_q1m   NUMBER             DEFAULT an_q1m;
  ln_q3m   NUMBER             DEFAULT an_q3m;
  ln_aerm  NUMBER             DEFAULT an_aerm;
  ln_aedm  NUMBER             DEFAULT an_aedm;
  ln_aq1m  NUMBER             DEFAULT an_aq1m;
  ln_aq3m  NUMBER             DEFAULT an_aq3m;
  ln_berm  NUMBER             DEFAULT an_berm;
  ln_bedm  NUMBER             DEFAULT an_bedm;
  ln_bq1m  NUMBER             DEFAULT an_bq1m;
  ln_bq3m  NUMBER             DEFAULT an_bq3m;
  ln_cerm  NUMBER             DEFAULT an_cerm;
  ln_cedm  NUMBER             DEFAULT an_cedm;
  ln_cq1m  NUMBER             DEFAULT an_cq1m;
  ln_cq3m  NUMBER             DEFAULT an_cq3m;
  ln_derm  NUMBER             DEFAULT an_derm;
  ln_dedm  NUMBER             DEFAULT an_dedm;
  ln_dq1m  NUMBER             DEFAULT an_dq1m;
  ln_dq3m  NUMBER             DEFAULT an_dq3m;
  ln_er    NUMBER;
  ln_ed    NUMBER;
  ln_q1    NUMBER;
  ln_q3    NUMBER;
  ln_aer   NUMBER;
  ln_aed   NUMBER;
  ln_aq1   NUMBER;
  ln_aq3   NUMBER;
  ln_ber   NUMBER;
  ln_bed   NUMBER;
  ln_bq1   NUMBER;
  ln_bq3   NUMBER;
  ln_cer   NUMBER;
  ln_ced   NUMBER;
  ln_cq1   NUMBER;
  ln_cq3   NUMBER;
  ln_der   NUMBER;
  ln_ded   NUMBER;
  ln_dq1   NUMBER;
  ln_dq3   NUMBER;
 BEGIN
  OPEN lcur_sel;
  FETCH lcur_sel INTO lc;
  lb_found := lcur_sel%FOUND;
  CLOSE lcur_sel;
  IF lb_found THEN
   SELECT NVL(MAX(kc), 1)
     INTO ln_kc
     FROM feeders
    WHERE mid = an_mid;
   util_pg.chdr(an_mid, ln_erm, ln_edm, ln_q1m, ln_q3m);
   util_pg.chdr(an_mid, ln_aerm, ln_aedm, ln_aq1m, ln_aq3m);
   util_pg.chdr(an_mid, ln_berm, ln_bedm, ln_bq1m, ln_bq3m);
   util_pg.chdr(an_mid, ln_cerm, ln_cedm, ln_cq1m, ln_cq3m);
   util_pg.chdr(an_mid, ln_derm, ln_dedm, ln_dq1m, ln_dq3m);
   ln_er := ROUND(util_pg.indicoverturn(ln_erm - lc.erm, an_digits) * ln_kc, ln_rn);
   ln_ed := ROUND(util_pg.indicoverturn(ln_edm - lc.edm, an_digits) * ln_kc, ln_rn);
   ln_q1 := ROUND(util_pg.indicoverturn(ln_q1m - lc.q1m, an_digits) * ln_kc, ln_rn);
   ln_q3 := ROUND(util_pg.indicoverturn(ln_q3m - lc.q3m, an_digits) * ln_kc, ln_rn);
   ln_aer := ROUND(util_pg.indicoverturn(ln_aerm - lc.aerm, an_digits) * ln_kc, ln_rn);
   ln_aed := ROUND(util_pg.indicoverturn(ln_aedm - lc.aedm, an_digits) * ln_kc, ln_rn);
   ln_aq1 := ROUND(util_pg.indicoverturn(ln_aq1m - lc.aq1m, an_digits) * ln_kc, ln_rn);
   ln_aq3 := ROUND(util_pg.indicoverturn(ln_aq3m - lc.aq3m, an_digits) * ln_kc, ln_rn);
   ln_ber := ROUND(util_pg.indicoverturn(ln_berm - lc.berm, an_digits) * ln_kc, ln_rn);
   ln_bed := ROUND(util_pg.indicoverturn(ln_bedm - lc.bedm, an_digits) * ln_kc, ln_rn);
   ln_bq1 := ROUND(util_pg.indicoverturn(ln_bq1m - lc.bq1m, an_digits) * ln_kc, ln_rn);
   ln_bq3 := ROUND(util_pg.indicoverturn(ln_bq3m - lc.bq3m, an_digits) * ln_kc, ln_rn);
   ln_cer := ROUND(util_pg.indicoverturn(ln_cerm - lc.cerm, an_digits) * ln_kc, ln_rn);
   ln_ced := ROUND(util_pg.indicoverturn(ln_cedm - lc.cedm, an_digits) * ln_kc, ln_rn);
   ln_cq1 := ROUND(util_pg.indicoverturn(ln_cq1m - lc.cq1m, an_digits) * ln_kc, ln_rn);
   ln_cq3 := ROUND(util_pg.indicoverturn(ln_cq3m - lc.cq3m, an_digits) * ln_kc, ln_rn);
   ln_der := ROUND(util_pg.indicoverturn(ln_derm - lc.derm, an_digits) * ln_kc, ln_rn);
   ln_ded := ROUND(util_pg.indicoverturn(ln_dedm - lc.dedm, an_digits) * ln_kc, ln_rn);
   ln_dq1 := ROUND(util_pg.indicoverturn(ln_dq1m - lc.dq1m, an_digits) * ln_kc, ln_rn);
   ln_dq3 := ROUND(util_pg.indicoverturn(ln_dq3m - lc.dq3m, an_digits) * ln_kc, ln_rn);
   /*   util_pg.chdr(an_mid, ln_er, ln_ed, ln_q1, ln_q3);
      util_pg.chdr(an_mid, ln_aer, ln_aed, ln_aq1, ln_aq3);
      util_pg.chdr(an_mid, ln_ber, ln_bed, ln_bq1, ln_bq3);
      util_pg.chdr(an_mid, ln_cer, ln_ced, ln_cq1, ln_cq3);
      util_pg.chdr(an_mid, ln_der, ln_ded, ln_dq1, ln_dq3);*/
   INSERT INTO monthsorg
               (mid, er, ed, q1, q3, aer, aed, aq1, aq3, ber, bed, bq1, bq3,
                cer, ced, cq1, cq3, der, ded, dq1, dq3, erm, edm, q1m, q3m,
                aerm, aedm, aq1m, aq3m, berm, bedm, bq1m, bq3m, cerm, cedm, cq1m,
                cq3m, derm, dedm, dq1m, dq3m, er_mtrsn, q1_mtrsn, ed_mtrsn, q3_mtrsn, date_time, source)
        VALUES (an_mid, ln_er, ln_ed, ln_q1, ln_q3, ln_aer, ln_aed, ln_aq1, ln_aq3, ln_ber, ln_bed, ln_bq1, ln_bq3,
                ln_cer, ln_ced, ln_cq1, ln_cq3, ln_der, ln_ded, ln_dq1, ln_dq3, ln_erm, ln_edm, ln_q1m, ln_q3m,
                ln_aerm, ln_aedm, ln_aq1m, ln_aq3m, ln_berm, ln_bedm, ln_bq1m, ln_bq3m, ln_cerm, ln_cedm, ln_cq1m,
                ln_cq3m, ln_derm, ln_dedm, ln_dq1m, ln_dq3m, av_mtrsn, av_mtrsn, av_mtrsn, av_mtrsn, ad_date, 'КС');
  ELSE
   util_pg.chdr(an_mid, ln_erm, ln_edm, ln_q1m, ln_q3m);
   util_pg.chdr(an_mid, ln_aerm, ln_aedm, ln_aq1m, ln_aq3m);
   util_pg.chdr(an_mid, ln_berm, ln_bedm, ln_bq1m, ln_bq3m);
   util_pg.chdr(an_mid, ln_cerm, ln_cedm, ln_cq1m, ln_cq3m);
   util_pg.chdr(an_mid, ln_derm, ln_dedm, ln_dq1m, ln_dq3m);
   INSERT INTO monthsorg
               (mid, erm, edm, q1m, q3m, aerm, aedm, aq1m, aq3m, berm, bedm, bq1m,
                bq3m, cerm, cedm, cq1m, cq3m, derm, dedm, dq1m, dq3m, er_mtrsn, q1_mtrsn,
                ed_mtrsn, q3_mtrsn, date_time, source)
        VALUES (an_mid, ln_erm, ln_edm, ln_q1m, ln_q3m, ln_aerm, ln_aedm, ln_aq1m, ln_aq3m, ln_berm, ln_bedm, ln_bq1m,
                ln_bq3m, ln_cerm, ln_cedm, ln_cq1m, ln_cq3m, ln_derm, ln_dedm, ln_dq1m, ln_dq3m, av_mtrsn, av_mtrsn,
                av_mtrsn, av_mtrsn, ad_date, 'КС');
  END IF;
 END;
 ------------------------------------------------------------------------------------------------------------------------
 --******************************          A1R             *******************************************************--
 ------------------------------------------------------------------------------------------------------------------------
  --Вставка текущих
 PROCEDURE set_curr_power_a1r(an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, ad_date DATE)
 IS
 BEGIN
 update curr_power set erm=an_erm,edm=an_edm,q1m=an_q1m,q3m=an_q3m,q2m=an_q2m,q4m=an_q4m,obsolete=0,date_time=ad_date
 where mid=an_mid;
 END;
 -----------------------------------------------------------------------------------------------------------------------
  --Вставка графика нагрузки
 PROCEDURE set_halfhour_a1r(an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, ad_date DATE) IS
  ln_er NUMBER DEFAULT an_er;
  ln_ed NUMBER DEFAULT an_ed;
  ln_q1 NUMBER DEFAULT an_q1;
  ln_q3 NUMBER DEFAULT an_q3;
 BEGIN
  util_pg.chdr(an_mid, ln_er, ln_ed, ln_q1, ln_q3);
  INSERT INTO halfhourtmp
              (mid, date_time, nsource, er, ed, q1, q3)
       VALUES (an_mid, ad_date, cn_a1r, ln_er, ln_ed, ln_q1, ln_q3);
 EXCEPTION
  WHEN OTHERS THEN
   RAISE;
 END;
 ------------------------------------------------------------------------------------------------------------------------
   --Вставка суточных
 PROCEDURE set_bill_a1r(
  an_mid    NUMBER,
  an_erm    NUMBER,
  an_edm    NUMBER,
  an_q1m    NUMBER,
  an_q3m    NUMBER,
  an_q2m    NUMBER,
  an_q4m    NUMBER,
  an_aerm   NUMBER,
  an_aedm   NUMBER,
  an_aq1m   NUMBER,
  an_aq3m   NUMBER,
  an_aq2m   NUMBER,
  an_aq4m   NUMBER,
  an_berm   NUMBER,
  an_bedm   NUMBER,
  an_bq1m   NUMBER,
  an_bq3m   NUMBER,
  an_bq2m   NUMBER,
  an_bq4m   NUMBER,
  an_cerm   NUMBER,
  an_cedm   NUMBER,
  an_cq1m   NUMBER,
  an_cq3m   NUMBER,
  an_cq2m   NUMBER,
  an_cq4m   NUMBER,
  an_derm   NUMBER,
  an_dedm   NUMBER,
  an_dq1m   NUMBER,
  an_dq3m   NUMBER,
  an_dq2m   NUMBER,
  an_dq4m   NUMBER,
  av_mtrsn  VARCHAR2,
  an_digits NUMBER, --Значность счетчика, необходимо передать 6 - A1R_ParamCalc.DPLocE
  ad_date   DATE) IS
  CURSOR lcur_sel IS
   SELECT NVL(erm, 0) erm, NVL(edm, 0) edm, NVL(q1m, 0) q1m, NVL(q3m, 0) q3m, NVL(q2m, 0) q2m, NVL(q4m, 0) q4m,
          NVL(aerm, 0) aerm, NVL(aedm, 0) aedm, NVL(aq1m, 0) aq1m, NVL(aq3m, 0) aq3m, NVL(aq2m, 0) aq2m, NVL(aq4m, 0) aq4m,
          NVL(berm, 0) berm, NVL(bedm, 0) bedm, NVL(bq1m, 0) bq1m, NVL(bq3m, 0) bq3m, NVL(bq2m, 0) bq2m, NVL(bq4m, 0) bq4m,
          NVL(cerm, 0) cerm, NVL(cedm, 0) cedm, NVL(cq1m, 0) cq1m, NVL(cq3m, 0) cq3m, NVL(cq2m, 0) cq2m, NVL(cq4m, 0) cq4m,
          NVL(derm, 0) derm, NVL(dedm, 0) dedm, NVL(dq1m, 0) dq1m, NVL(dq3m, 0) dq3m, NVL(dq2m, 0) dq2m, NVL(dq4m, 0) dq4m,
          NVL(er_mtrsn, ' ')
     FROM billorg
    WHERE mid = an_mid
      AND date_time = (SELECT MAX(date_time)
                         FROM billorg
                        WHERE mid = an_mid AND date_time < ad_date)
      AND UPPER(TRIM(er_mtrsn)) = UPPER(TRIM(av_mtrsn));
  lc       lcur_sel%ROWTYPE;
  lb_found BOOLEAN;
  ln_kc    NUMBER;
  ln_rn    NUMBER             DEFAULT 10;
  ln_erm   NUMBER             DEFAULT an_erm;
  ln_edm   NUMBER             DEFAULT an_edm;
  ln_q1m   NUMBER             DEFAULT an_q1m;
  ln_q3m   NUMBER             DEFAULT an_q3m;
  ln_q2m   NUMBER             DEFAULT an_q2m;
  ln_q4m   NUMBER             DEFAULT an_q4m;
  ln_aerm  NUMBER             DEFAULT an_aerm;
  ln_aedm  NUMBER             DEFAULT an_aedm;
  ln_aq1m  NUMBER             DEFAULT an_aq1m;
  ln_aq3m  NUMBER             DEFAULT an_aq3m;
  ln_aq2m  NUMBER             DEFAULT an_aq2m;
  ln_aq4m  NUMBER             DEFAULT an_aq4m;
  ln_berm  NUMBER             DEFAULT an_berm;
  ln_bedm  NUMBER             DEFAULT an_bedm;
  ln_bq1m  NUMBER             DEFAULT an_bq1m;
  ln_bq3m  NUMBER             DEFAULT an_bq3m;
  ln_bq2m  NUMBER             DEFAULT an_bq2m;
  ln_bq4m  NUMBER             DEFAULT an_bq4m;
  ln_cerm  NUMBER             DEFAULT an_cerm;
  ln_cedm  NUMBER             DEFAULT an_cedm;
  ln_cq1m  NUMBER             DEFAULT an_cq1m;
  ln_cq3m  NUMBER             DEFAULT an_cq3m;
  ln_cq2m  NUMBER             DEFAULT an_cq2m;
  ln_cq4m  NUMBER             DEFAULT an_cq4m;
  ln_derm  NUMBER             DEFAULT an_derm;
  ln_dedm  NUMBER             DEFAULT an_dedm;
  ln_dq1m  NUMBER             DEFAULT an_dq1m;
  ln_dq3m  NUMBER             DEFAULT an_dq3m;
  ln_dq2m  NUMBER             DEFAULT an_dq2m;
  ln_dq4m  NUMBER             DEFAULT an_dq4m;
  ln_er    NUMBER;
  ln_ed    NUMBER;
  ln_q1    NUMBER;
  ln_q3    NUMBER;
  ln_q2    NUMBER;
  ln_q4    NUMBER;
  ln_aer   NUMBER;
  ln_aed   NUMBER;
  ln_aq1   NUMBER;
  ln_aq3   NUMBER;
  ln_aq2   NUMBER;
  ln_aq4   NUMBER;
  ln_ber   NUMBER;
  ln_bed   NUMBER;
  ln_bq1   NUMBER;
  ln_bq3   NUMBER;
  ln_bq2   NUMBER;
  ln_bq4   NUMBER;
  ln_cer   NUMBER;
  ln_ced   NUMBER;
  ln_cq1   NUMBER;
  ln_cq3   NUMBER;
  ln_cq2   NUMBER;
  ln_cq4   NUMBER;
  ln_der   NUMBER;
  ln_ded   NUMBER;
  ln_dq1   NUMBER;
  ln_dq3   NUMBER;
  ln_dq2   NUMBER;
  ln_dq4   NUMBER;
 BEGIN
  OPEN lcur_sel;
  FETCH lcur_sel INTO lc;
  lb_found := lcur_sel%FOUND;
  CLOSE lcur_sel;
  IF lb_found THEN
   SELECT NVL(MAX(kc), 1)
     INTO ln_kc
     FROM feeders
    WHERE mid = an_mid;
   util_pg.chdr(an_mid, ln_erm, ln_edm, ln_q1m, ln_q3m, ln_q2m, ln_q4m);
   util_pg.chdr(an_mid, ln_aerm, ln_aedm, ln_aq1m, ln_aq3m, ln_aq2m, ln_aq4m);
   util_pg.chdr(an_mid, ln_berm, ln_bedm, ln_bq1m, ln_bq3m, ln_bq2m, ln_bq4m);
   util_pg.chdr(an_mid, ln_cerm, ln_cedm, ln_cq1m, ln_cq3m, ln_cq2m, ln_cq4m);
   util_pg.chdr(an_mid, ln_derm, ln_dedm, ln_dq1m, ln_dq3m, ln_dq2m, ln_dq4m);
   ln_er := ROUND(util_pg.indicoverturn(ln_erm - lc.erm, an_digits) * ln_kc, ln_rn);
   ln_ed := ROUND(util_pg.indicoverturn(ln_edm - lc.edm, an_digits) * ln_kc, ln_rn);
   ln_q1 := ROUND(util_pg.indicoverturn(ln_q1m - lc.q1m, an_digits) * ln_kc, ln_rn);
   ln_q3 := ROUND(util_pg.indicoverturn(ln_q3m - lc.q3m, an_digits) * ln_kc, ln_rn);
   ln_q2 := ROUND(util_pg.indicoverturn(ln_q2m - lc.q2m, an_digits) * ln_kc, ln_rn);
   ln_q4 := ROUND(util_pg.indicoverturn(ln_q4m - lc.q4m, an_digits) * ln_kc, ln_rn);
   ln_aer := ROUND(util_pg.indicoverturn(ln_aerm - lc.aerm, an_digits) * ln_kc, ln_rn);
   ln_aed := ROUND(util_pg.indicoverturn(ln_aedm - lc.aedm, an_digits) * ln_kc, ln_rn);
   ln_aq1 := ROUND(util_pg.indicoverturn(ln_aq1m - lc.aq1m, an_digits) * ln_kc, ln_rn);
   ln_aq3 := ROUND(util_pg.indicoverturn(ln_aq3m - lc.aq3m, an_digits) * ln_kc, ln_rn);
   ln_aq2 := ROUND(util_pg.indicoverturn(ln_aq2m - lc.aq2m, an_digits) * ln_kc, ln_rn);
   ln_aq4 := ROUND(util_pg.indicoverturn(ln_aq4m - lc.aq4m, an_digits) * ln_kc, ln_rn);
   ln_ber := ROUND(util_pg.indicoverturn(ln_berm - lc.berm, an_digits) * ln_kc, ln_rn);
   ln_bed := ROUND(util_pg.indicoverturn(ln_bedm - lc.bedm, an_digits) * ln_kc, ln_rn);
   ln_bq1 := ROUND(util_pg.indicoverturn(ln_bq1m - lc.bq1m, an_digits) * ln_kc, ln_rn);
   ln_bq3 := ROUND(util_pg.indicoverturn(ln_bq3m - lc.bq3m, an_digits) * ln_kc, ln_rn);
   ln_bq2 := ROUND(util_pg.indicoverturn(ln_bq2m - lc.bq2m, an_digits) * ln_kc, ln_rn);
   ln_bq4 := ROUND(util_pg.indicoverturn(ln_bq4m - lc.bq4m, an_digits) * ln_kc, ln_rn);
   ln_cer := ROUND(util_pg.indicoverturn(ln_cerm - lc.cerm, an_digits) * ln_kc, ln_rn);
   ln_ced := ROUND(util_pg.indicoverturn(ln_cedm - lc.cedm, an_digits) * ln_kc, ln_rn);
   ln_cq1 := ROUND(util_pg.indicoverturn(ln_cq1m - lc.cq1m, an_digits) * ln_kc, ln_rn);
   ln_cq3 := ROUND(util_pg.indicoverturn(ln_cq3m - lc.cq3m, an_digits) * ln_kc, ln_rn);
   ln_cq2 := ROUND(util_pg.indicoverturn(ln_cq2m - lc.cq2m, an_digits) * ln_kc, ln_rn);
   ln_cq4 := ROUND(util_pg.indicoverturn(ln_cq4m - lc.cq4m, an_digits) * ln_kc, ln_rn);
   ln_der := ROUND(util_pg.indicoverturn(ln_derm - lc.derm, an_digits) * ln_kc, ln_rn);
   ln_ded := ROUND(util_pg.indicoverturn(ln_dedm - lc.dedm, an_digits) * ln_kc, ln_rn);
   ln_dq1 := ROUND(util_pg.indicoverturn(ln_dq1m - lc.dq1m, an_digits) * ln_kc, ln_rn);
   ln_dq3 := ROUND(util_pg.indicoverturn(ln_dq3m - lc.dq3m, an_digits) * ln_kc, ln_rn);
   ln_dq2 := ROUND(util_pg.indicoverturn(ln_dq2m - lc.dq2m, an_digits) * ln_kc, ln_rn);
   ln_dq4 := ROUND(util_pg.indicoverturn(ln_dq4m - lc.dq4m, an_digits) * ln_kc, ln_rn);
   /*   util_pg.chdr(an_mid, ln_er, ln_ed, ln_q1, ln_q3, ln_q2, ln_q4);
      util_pg.chdr(an_mid, ln_aer, ln_aed, ln_aq1, ln_aq3, ln_aq2, ln_aq4);
      util_pg.chdr(an_mid, ln_ber, ln_bed, ln_bq1, ln_bq3, ln_bq2, ln_bq4);
      util_pg.chdr(an_mid, ln_cer, ln_ced, ln_cq1, ln_cq3, ln_cq2, ln_cq4);
      util_pg.chdr(an_mid, ln_der, ln_ded, ln_dq1, ln_dq3, ln_dq2, ln_dq4);*/
   INSERT INTO billorg
               (mid, er, ed, q1, q3, q2, q4, aer, aed, aq1, aq3, aq2, aq4,
                ber, bed, bq1, bq3, bq2, bq4, cer, ced, cq1, cq3, cq2, cq4, der,
                ded, dq1, dq3, dq2, dq4, erm, edm, q1m, q3m, q2m, q4m, aerm,
                aedm, aq1m, aq3m, aq2m, aq4m, berm, bedm, bq1m, bq3m, bq2m, bq4m,
                cerm, cedm, cq1m, cq3m, cq2m, cq4m, derm, dedm, dq1m, dq3m, dq2m,
                dq4m, er_mtrsn, ed_mtrsn, q1_mtrsn, q3_mtrsn, q2_mtrsn, q4_mtrsn, date_time, source, nsource)
        VALUES (an_mid, ln_er, ln_ed, ln_q1, ln_q3, ln_q2, ln_q4, ln_aer, ln_aed, ln_aq1, ln_aq3, ln_aq2, ln_aq4,
                ln_ber, ln_bed, ln_bq1, ln_bq3, ln_bq2, ln_bq4, ln_cer, ln_ced, ln_cq1, ln_cq3, ln_cq2, ln_cq4, ln_der,
                ln_ded, ln_dq1, ln_dq3, ln_dq2, ln_dq4, ln_erm, ln_edm, ln_q1m, ln_q3m, ln_q2m, ln_q4m, ln_aerm,
                ln_aedm, ln_aq1m, ln_aq3m, ln_aq2m, ln_aq4m, ln_berm, ln_bedm, ln_bq1m, ln_bq3m, ln_bq2m, ln_bq4m,
                ln_cerm, ln_cedm, ln_cq1m, ln_cq3m, ln_cq2m, ln_cq4m, ln_derm, ln_dedm, ln_dq1m, ln_dq3m, ln_dq2m,
                ln_dq4m, av_mtrsn, av_mtrsn, av_mtrsn, av_mtrsn, av_mtrsn, av_mtrsn, ad_date, 'КС', cn_a1r);
  ELSE
   util_pg.chdr(an_mid, ln_erm, ln_edm, ln_q1m, ln_q3m, ln_q2m, ln_q4m);
   util_pg.chdr(an_mid, ln_aerm, ln_aedm, ln_aq1m, ln_aq3m, ln_aq2m, ln_aq4m);
   util_pg.chdr(an_mid, ln_berm, ln_bedm, ln_bq1m, ln_bq3m, ln_bq2m, ln_bq4m);
   util_pg.chdr(an_mid, ln_cerm, ln_cedm, ln_cq1m, ln_cq3m, ln_cq2m, ln_cq4m);
   util_pg.chdr(an_mid, ln_derm, ln_dedm, ln_dq1m, ln_dq3m, ln_dq2m, ln_dq4m);
   INSERT INTO billorg
               (mid, erm, edm, q1m, q3m, q2m, q4m, aerm, aedm, aq1m, aq3m, aq2m,
                aq4m, berm, bedm, bq1m, bq3m, bq2m, bq4m, cerm, cedm, cq1m, cq3m,
                cq2m, cq4m, derm, dedm, dq1m, dq3m, dq2m, dq4m, er_mtrsn, q1_mtrsn, ed_mtrsn,
                q3_mtrsn, q2_mtrsn, q4_mtrsn, date_time, source, nsource)
        VALUES (an_mid, ln_erm, ln_edm, ln_q1m, ln_q3m, ln_q2m, ln_q4m, ln_aerm, ln_aedm, ln_aq1m, ln_aq3m, ln_aq2m,
                ln_aq4m, ln_berm, ln_bedm, ln_bq1m, ln_bq3m, ln_bq2m, ln_bq4m, ln_cerm, ln_cedm, ln_cq1m, ln_cq3m,
                ln_cq2m, ln_cq4m, ln_derm, ln_dedm, ln_dq1m, ln_dq3m, ln_dq2m, ln_dq4m, av_mtrsn, av_mtrsn, av_mtrsn,
                av_mtrsn, av_mtrsn, av_mtrsn, ad_date, 'КС', cn_a1r);
  END IF;
 END;
 ------------------------------------------------------------------------------------------------------------------------
   --Вставка месячных
 PROCEDURE set_months_a1r(
  an_mid    NUMBER,
  an_erm    NUMBER,
  an_edm    NUMBER,
  an_q1m    NUMBER,
  an_q3m    NUMBER,
  an_q2m    NUMBER,
  an_q4m    NUMBER,
  an_aerm   NUMBER,
  an_aedm   NUMBER,
  an_aq1m   NUMBER,
  an_aq3m   NUMBER,
  an_aq2m   NUMBER,
  an_aq4m   NUMBER,
  an_berm   NUMBER,
  an_bedm   NUMBER,
  an_bq1m   NUMBER,
  an_bq3m   NUMBER,
  an_bq2m   NUMBER,
  an_bq4m   NUMBER,
  an_cerm   NUMBER,
  an_cedm   NUMBER,
  an_cq1m   NUMBER,
  an_cq3m   NUMBER,
  an_cq2m   NUMBER,
  an_cq4m   NUMBER,
  an_derm   NUMBER,
  an_dedm   NUMBER,
  an_dq1m   NUMBER,
  an_dq3m   NUMBER,
  an_dq2m   NUMBER,
  an_dq4m   NUMBER,
  av_mtrsn  VARCHAR2,
  an_digits NUMBER, --Значность счетчика, необходимо передать 6 - A1R_ParamCalc.DPLocE
  ad_date   DATE) IS
  CURSOR lcur_sel IS
   SELECT NVL(erm, 0) erm, NVL(edm, 0) edm, NVL(q1m, 0) q1m, NVL(q3m, 0) q3m, NVL(q2m, 0) q2m, NVL(q4m, 0) q4m,
          NVL(aerm, 0) aerm, NVL(aedm, 0) aedm, NVL(aq1m, 0) aq1m, NVL(aq3m, 0) aq3m, NVL(aq2m, 0) aq2m, NVL(aq4m, 0) aq4m,
          NVL(berm, 0) berm, NVL(bedm, 0) bedm, NVL(bq1m, 0) bq1m, NVL(bq3m, 0) bq3m, NVL(bq2m, 0) bq2m, NVL(bq4m, 0) bq4m,
          NVL(cerm, 0) cerm, NVL(cedm, 0) cedm, NVL(cq1m, 0) cq1m, NVL(cq3m, 0) cq3m, NVL(cq2m, 0) cq2m, NVL(cq4m, 0) cq4m,
          NVL(derm, 0) derm, NVL(dedm, 0) dedm, NVL(dq1m, 0) dq1m, NVL(dq3m, 0) dq3m, NVL(dq2m, 0) dq2m, NVL(dq4m, 0) dq4m,
          NVL(er_mtrsn, ' ')
     FROM monthsorg
    WHERE mid = an_mid
      AND date_time = (SELECT MAX(date_time)
                         FROM monthsorg
                        WHERE mid = an_mid AND date_time < ad_date)
      AND UPPER(TRIM(er_mtrsn)) = UPPER(TRIM(av_mtrsn));
  lc       lcur_sel%ROWTYPE;
  lb_found BOOLEAN;
  ln_kc    NUMBER;
  ln_rn    NUMBER             DEFAULT 10;
  ln_erm   NUMBER             DEFAULT an_erm;
  ln_edm   NUMBER             DEFAULT an_edm;
  ln_q1m   NUMBER             DEFAULT an_q1m;
  ln_q3m   NUMBER             DEFAULT an_q3m;
  ln_q2m   NUMBER             DEFAULT an_q2m;
  ln_q4m   NUMBER             DEFAULT an_q4m;
  ln_aerm  NUMBER             DEFAULT an_aerm;
  ln_aedm  NUMBER             DEFAULT an_aedm;
  ln_aq1m  NUMBER             DEFAULT an_aq1m;
  ln_aq3m  NUMBER             DEFAULT an_aq3m;
  ln_aq2m  NUMBER             DEFAULT an_aq2m;
  ln_aq4m  NUMBER             DEFAULT an_aq4m;
  ln_berm  NUMBER             DEFAULT an_berm;
  ln_bedm  NUMBER             DEFAULT an_bedm;
  ln_bq1m  NUMBER             DEFAULT an_bq1m;
  ln_bq3m  NUMBER             DEFAULT an_bq3m;
  ln_bq2m  NUMBER             DEFAULT an_bq2m;
  ln_bq4m  NUMBER             DEFAULT an_bq4m;
  ln_cerm  NUMBER             DEFAULT an_cerm;
  ln_cedm  NUMBER             DEFAULT an_cedm;
  ln_cq1m  NUMBER             DEFAULT an_cq1m;
  ln_cq3m  NUMBER             DEFAULT an_cq3m;
  ln_cq2m  NUMBER             DEFAULT an_cq2m;
  ln_cq4m  NUMBER             DEFAULT an_cq4m;
  ln_derm  NUMBER             DEFAULT an_derm;
  ln_dedm  NUMBER             DEFAULT an_dedm;
  ln_dq1m  NUMBER             DEFAULT an_dq1m;
  ln_dq3m  NUMBER             DEFAULT an_dq3m;
  ln_dq2m  NUMBER             DEFAULT an_dq2m;
  ln_dq4m  NUMBER             DEFAULT an_dq4m;
  ln_er    NUMBER;
  ln_ed    NUMBER;
  ln_q1    NUMBER;
  ln_q3    NUMBER;
  ln_q2    NUMBER;
  ln_q4    NUMBER;
  ln_aer   NUMBER;
  ln_aed   NUMBER;
  ln_aq1   NUMBER;
  ln_aq3   NUMBER;
  ln_aq2   NUMBER;
  ln_aq4   NUMBER;
  ln_ber   NUMBER;
  ln_bed   NUMBER;
  ln_bq1   NUMBER;
  ln_bq3   NUMBER;
  ln_bq2   NUMBER;
  ln_bq4   NUMBER;
  ln_cer   NUMBER;
  ln_ced   NUMBER;
  ln_cq1   NUMBER;
  ln_cq3   NUMBER;
  ln_cq2   NUMBER;
  ln_cq4   NUMBER;
  ln_der   NUMBER;
  ln_ded   NUMBER;
  ln_dq1   NUMBER;
  ln_dq3   NUMBER;
  ln_dq2   NUMBER;
  ln_dq4   NUMBER;
 BEGIN
  OPEN lcur_sel;
  FETCH lcur_sel INTO lc;
  lb_found := lcur_sel%FOUND;
  CLOSE lcur_sel;
  IF lb_found THEN
   SELECT NVL(MAX(kc), 1)
     INTO ln_kc
     FROM feeders
    WHERE mid = an_mid;
   util_pg.chdr(an_mid, ln_erm, ln_edm, ln_q1m, ln_q3m, ln_q2m, ln_q4m);
   util_pg.chdr(an_mid, ln_aerm, ln_aedm, ln_aq1m, ln_aq3m, ln_aq2m, ln_aq4m);
   util_pg.chdr(an_mid, ln_berm, ln_bedm, ln_bq1m, ln_bq3m, ln_bq2m, ln_bq4m);
   util_pg.chdr(an_mid, ln_cerm, ln_cedm, ln_cq1m, ln_cq3m, ln_cq2m, ln_cq4m);
   util_pg.chdr(an_mid, ln_derm, ln_dedm, ln_dq1m, ln_dq3m, ln_dq2m, ln_dq4m);
   ln_er := ROUND(util_pg.indicoverturn(ln_erm - lc.erm, an_digits) * ln_kc, ln_rn);
   ln_ed := ROUND(util_pg.indicoverturn(ln_edm - lc.edm, an_digits) * ln_kc, ln_rn);
   ln_q1 := ROUND(util_pg.indicoverturn(ln_q1m - lc.q1m, an_digits) * ln_kc, ln_rn);
   ln_q3 := ROUND(util_pg.indicoverturn(ln_q3m - lc.q3m, an_digits) * ln_kc, ln_rn);
   ln_q2 := ROUND(util_pg.indicoverturn(ln_q2m - lc.q2m, an_digits) * ln_kc, ln_rn);
   ln_q4 := ROUND(util_pg.indicoverturn(ln_q4m - lc.q4m, an_digits) * ln_kc, ln_rn);
   ln_aer := ROUND(util_pg.indicoverturn(ln_aerm - lc.aerm, an_digits) * ln_kc, ln_rn);
   ln_aed := ROUND(util_pg.indicoverturn(ln_aedm - lc.aedm, an_digits) * ln_kc, ln_rn);
   ln_aq1 := ROUND(util_pg.indicoverturn(ln_aq1m - lc.aq1m, an_digits) * ln_kc, ln_rn);
   ln_aq3 := ROUND(util_pg.indicoverturn(ln_aq3m - lc.aq3m, an_digits) * ln_kc, ln_rn);
   ln_aq2 := ROUND(util_pg.indicoverturn(ln_aq2m - lc.aq2m, an_digits) * ln_kc, ln_rn);
   ln_aq4 := ROUND(util_pg.indicoverturn(ln_aq4m - lc.aq4m, an_digits) * ln_kc, ln_rn);
   ln_ber := ROUND(util_pg.indicoverturn(ln_berm - lc.berm, an_digits) * ln_kc, ln_rn);
   ln_bed := ROUND(util_pg.indicoverturn(ln_bedm - lc.bedm, an_digits) * ln_kc, ln_rn);
   ln_bq1 := ROUND(util_pg.indicoverturn(ln_bq1m - lc.bq1m, an_digits) * ln_kc, ln_rn);
   ln_bq3 := ROUND(util_pg.indicoverturn(ln_bq3m - lc.bq3m, an_digits) * ln_kc, ln_rn);
   ln_bq2 := ROUND(util_pg.indicoverturn(ln_bq2m - lc.bq2m, an_digits) * ln_kc, ln_rn);
   ln_bq4 := ROUND(util_pg.indicoverturn(ln_bq4m - lc.bq4m, an_digits) * ln_kc, ln_rn);
   ln_cer := ROUND(util_pg.indicoverturn(ln_cerm - lc.cerm, an_digits) * ln_kc, ln_rn);
   ln_ced := ROUND(util_pg.indicoverturn(ln_cedm - lc.cedm, an_digits) * ln_kc, ln_rn);
   ln_cq1 := ROUND(util_pg.indicoverturn(ln_cq1m - lc.cq1m, an_digits) * ln_kc, ln_rn);
   ln_cq3 := ROUND(util_pg.indicoverturn(ln_cq3m - lc.cq3m, an_digits) * ln_kc, ln_rn);
   ln_cq2 := ROUND(util_pg.indicoverturn(ln_cq2m - lc.cq2m, an_digits) * ln_kc, ln_rn);
   ln_cq4 := ROUND(util_pg.indicoverturn(ln_cq4m - lc.cq4m, an_digits) * ln_kc, ln_rn);
   ln_der := ROUND(util_pg.indicoverturn(ln_derm - lc.derm, an_digits) * ln_kc, ln_rn);
   ln_ded := ROUND(util_pg.indicoverturn(ln_dedm - lc.dedm, an_digits) * ln_kc, ln_rn);
   ln_dq1 := ROUND(util_pg.indicoverturn(ln_dq1m - lc.dq1m, an_digits) * ln_kc, ln_rn);
   ln_dq3 := ROUND(util_pg.indicoverturn(ln_dq3m - lc.dq3m, an_digits) * ln_kc, ln_rn);
   ln_dq2 := ROUND(util_pg.indicoverturn(ln_dq2m - lc.dq2m, an_digits) * ln_kc, ln_rn);
   ln_dq4 := ROUND(util_pg.indicoverturn(ln_dq4m - lc.dq4m, an_digits) * ln_kc, ln_rn);
   /*   util_pg.chdr(an_mid, ln_er, ln_ed, ln_q1, ln_q3, ln_q2, ln_q4);
      util_pg.chdr(an_mid, ln_aer, ln_aed, ln_aq1, ln_aq3, ln_aq2, ln_aq4);
      util_pg.chdr(an_mid, ln_ber, ln_bed, ln_bq1, ln_bq3, ln_bq2, ln_bq4);
      util_pg.chdr(an_mid, ln_cer, ln_ced, ln_cq1, ln_cq3, ln_cq2, ln_cq4);
      util_pg.chdr(an_mid, ln_der, ln_ded, ln_dq1, ln_dq3, ln_dq2, ln_dq4);*/
   INSERT INTO monthsorg
               (mid, er, ed, q1, q3, q2, q4, aer, aed, aq1, aq3, aq2, aq4,
                ber, bed, bq1, bq3, bq2, bq4, cer, ced, cq1, cq3, cq2, cq4, der,
                ded, dq1, dq3, dq2, dq4, erm, edm, q1m, q3m, q2m, q4m, aerm,
                aedm, aq1m, aq3m, aq2m, aq4m, berm, bedm, bq1m, bq3m, bq2m, bq4m,
                cerm, cedm, cq1m, cq3m, cq2m, cq4m, derm, dedm, dq1m, dq3m, dq2m,
                dq4m, er_mtrsn, ed_mtrsn, q1_mtrsn, q3_mtrsn, q2_mtrsn, q4_mtrsn, date_time, source, nsource)
        VALUES (an_mid, ln_er, ln_ed, ln_q1, ln_q3, ln_q2, ln_q4, ln_aer, ln_aed, ln_aq1, ln_aq3, ln_aq2, ln_aq4,
                ln_ber, ln_bed, ln_bq1, ln_bq3, ln_bq2, ln_bq4, ln_cer, ln_ced, ln_cq1, ln_cq3, ln_cq2, ln_cq4, ln_der,
                ln_ded, ln_dq1, ln_dq3, ln_dq2, ln_dq4, ln_erm, ln_edm, ln_q1m, ln_q3m, ln_q2m, ln_q4m, ln_aerm,
                ln_aedm, ln_aq1m, ln_aq3m, ln_aq2m, ln_aq4m, ln_berm, ln_bedm, ln_bq1m, ln_bq3m, ln_bq2m, ln_bq4m,
                ln_cerm, ln_cedm, ln_cq1m, ln_cq3m, ln_cq2m, ln_cq4m, ln_derm, ln_dedm, ln_dq1m, ln_dq3m, ln_dq2m,
                ln_dq4m, av_mtrsn, av_mtrsn, av_mtrsn, av_mtrsn, av_mtrsn, av_mtrsn, ad_date, 'КС', cn_a1r);
  ELSE
   util_pg.chdr(an_mid, ln_erm, ln_edm, ln_q1m, ln_q3m, ln_q2m, ln_q4m);
   util_pg.chdr(an_mid, ln_aerm, ln_aedm, ln_aq1m, ln_aq3m, ln_aq2m, ln_aq4m);
   util_pg.chdr(an_mid, ln_berm, ln_bedm, ln_bq1m, ln_bq3m, ln_bq2m, ln_bq4m);
   util_pg.chdr(an_mid, ln_cerm, ln_cedm, ln_cq1m, ln_cq3m, ln_cq2m, ln_cq4m);
   util_pg.chdr(an_mid, ln_derm, ln_dedm, ln_dq1m, ln_dq3m, ln_dq2m, ln_dq4m);
   INSERT INTO monthsorg
               (mid, erm, edm, q1m, q3m, q2m, q4m, aerm, aedm, aq1m, aq3m, aq2m,
                aq4m, berm, bedm, bq1m, bq3m, bq2m, bq4m, cerm, cedm, cq1m, cq3m,
                cq2m, cq4m, derm, dedm, dq1m, dq3m, dq2m, dq4m, er_mtrsn, q1_mtrsn, ed_mtrsn,
                q3_mtrsn, q2_mtrsn, q4_mtrsn, date_time, source, nsource)
        VALUES (an_mid, ln_erm, ln_edm, ln_q1m, ln_q3m, ln_q2m, ln_q4m, ln_aerm, ln_aedm, ln_aq1m, ln_aq3m, ln_aq2m,
                ln_aq4m, ln_berm, ln_bedm, ln_bq1m, ln_bq3m, ln_bq2m, ln_bq4m, ln_cerm, ln_cedm, ln_cq1m, ln_cq3m,
                ln_cq2m, ln_cq4m, ln_derm, ln_dedm, ln_dq1m, ln_dq3m, ln_dq2m, ln_dq4m, av_mtrsn, av_mtrsn, av_mtrsn,
                av_mtrsn, av_mtrsn, av_mtrsn, ad_date, 'КС', cn_a1r);
  END IF;
 END;
 ------------------------------------------------------------------------------------------------------------------------
 --******************************          Alpha           *******************************************************--
 ------------------------------------------------------------------------------------------------------------------------
  --Вставка текущих
 PROCEDURE set_curr_power_alpha(an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER,ad_date DATE)
 IS
 BEGIN
 update curr_power set erm=an_erm,edm=an_edm,q1m=an_q1m,q3m=an_q3m,obsolete=0,date_time=ad_date
 where mid=an_mid;
 END;
 -----------------------------------------------------------------------------------------------------------------------
  --Вставка графика нагрузки
 PROCEDURE set_halfhour_alpha(an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, ad_date DATE) IS
  ln_er NUMBER DEFAULT an_er;
  ln_ed NUMBER DEFAULT an_ed;
  ln_q1 NUMBER DEFAULT an_q1;
  ln_q3 NUMBER DEFAULT an_q3;
 BEGIN
  util_pg.chdr(an_mid, ln_er, ln_ed, ln_q1, ln_q3);
  INSERT INTO halfhourtmp
              (mid, date_time, nsource, er, ed, q1, q3)
       VALUES (an_mid, ad_date, cn_alpha, ln_er, ln_ed, ln_q1, ln_q3);
 EXCEPTION
  WHEN OTHERS THEN
   RAISE;
 END;
 ------------------------------------------------------------------------------------------------------------------------
   --Вставка суточных
 PROCEDURE set_bill_alpha(
  an_mid    NUMBER,
  an_erm    NUMBER,
  an_edm    NUMBER,
  an_q1m    NUMBER,
  an_q3m    NUMBER,
  an_aerm   NUMBER,
  an_aedm   NUMBER,
  an_aq1m   NUMBER,
  an_aq3m   NUMBER,
  an_berm   NUMBER,
  an_bedm   NUMBER,
  an_bq1m   NUMBER,
  an_bq3m   NUMBER,
  an_cerm   NUMBER,
  an_cedm   NUMBER,
  an_cq1m   NUMBER,
  an_cq3m   NUMBER,
  an_derm   NUMBER,
  an_dedm   NUMBER,
  an_dq1m   NUMBER,
  an_dq3m   NUMBER,
  av_mtrsn  VARCHAR2,
  an_digits NUMBER, --Значность счетчика, необходимо передать 6 - Alpha_ParamCalc.DPLocE
  ad_date   DATE) IS
  CURSOR lcur_sel IS
   SELECT NVL(erm, 0) erm, NVL(edm, 0) edm, NVL(q1m, 0) q1m, NVL(q3m, 0) q3m, NVL(q2m, 0) q2m, NVL(q4m, 0) q4m,
          NVL(aerm, 0) aerm, NVL(aedm, 0) aedm, NVL(aq1m, 0) aq1m, NVL(aq3m, 0) aq3m, NVL(aq2m, 0) aq2m, NVL(aq4m, 0) aq4m,
          NVL(berm, 0) berm, NVL(bedm, 0) bedm, NVL(bq1m, 0) bq1m, NVL(bq3m, 0) bq3m, NVL(bq2m, 0) bq2m, NVL(bq4m, 0) bq4m,
          NVL(cerm, 0) cerm, NVL(cedm, 0) cedm, NVL(cq1m, 0) cq1m, NVL(cq3m, 0) cq3m, NVL(cq2m, 0) cq2m, NVL(cq4m, 0) cq4m,
          NVL(derm, 0) derm, NVL(dedm, 0) dedm, NVL(dq1m, 0) dq1m, NVL(dq3m, 0) dq3m, NVL(dq2m, 0) dq2m, NVL(dq4m, 0) dq4m,
          NVL(er_mtrsn, ' ')
     FROM billorg
    WHERE mid = an_mid
      AND date_time = (SELECT MAX(date_time)
                         FROM billorg
                        WHERE mid = an_mid AND date_time < ad_date)
      AND UPPER(TRIM(er_mtrsn)) = UPPER(TRIM(av_mtrsn));
  lc       lcur_sel%ROWTYPE;
  lb_found BOOLEAN;
  ln_kc    NUMBER;
  ln_rn    NUMBER             DEFAULT 10;
  ln_erm   NUMBER             DEFAULT an_erm;
  ln_edm   NUMBER             DEFAULT an_edm;
  ln_q1m   NUMBER             DEFAULT an_q1m;
  ln_q3m   NUMBER             DEFAULT an_q3m;
  ln_aerm  NUMBER             DEFAULT an_aerm;
  ln_aedm  NUMBER             DEFAULT an_aedm;
  ln_aq1m  NUMBER             DEFAULT an_aq1m;
  ln_aq3m  NUMBER             DEFAULT an_aq3m;
  ln_berm  NUMBER             DEFAULT an_berm;
  ln_bedm  NUMBER             DEFAULT an_bedm;
  ln_bq1m  NUMBER             DEFAULT an_bq1m;
  ln_bq3m  NUMBER             DEFAULT an_bq3m;
  ln_cerm  NUMBER             DEFAULT an_cerm;
  ln_cedm  NUMBER             DEFAULT an_cedm;
  ln_cq1m  NUMBER             DEFAULT an_cq1m;
  ln_cq3m  NUMBER             DEFAULT an_cq3m;
  ln_derm  NUMBER             DEFAULT an_derm;
  ln_dedm  NUMBER             DEFAULT an_dedm;
  ln_dq1m  NUMBER             DEFAULT an_dq1m;
  ln_dq3m  NUMBER             DEFAULT an_dq3m;
  ln_er    NUMBER;
  ln_ed    NUMBER;
  ln_q1    NUMBER;
  ln_q3    NUMBER;
  ln_aer   NUMBER;
  ln_aed   NUMBER;
  ln_aq1   NUMBER;
  ln_aq3   NUMBER;
  ln_ber   NUMBER;
  ln_bed   NUMBER;
  ln_bq1   NUMBER;
  ln_bq3   NUMBER;
  ln_cer   NUMBER;
  ln_ced   NUMBER;
  ln_cq1   NUMBER;
  ln_cq3   NUMBER;
  ln_der   NUMBER;
  ln_ded   NUMBER;
  ln_dq1   NUMBER;
  ln_dq3   NUMBER;
 BEGIN
  OPEN lcur_sel;
  FETCH lcur_sel INTO lc;
  lb_found := lcur_sel%FOUND;
  CLOSE lcur_sel;
  IF lb_found THEN
   SELECT NVL(MAX(kc), 1)
     INTO ln_kc
     FROM feeders
    WHERE mid = an_mid;
   util_pg.chdr(an_mid, ln_erm, ln_edm, ln_q1m, ln_q3m);
   util_pg.chdr(an_mid, ln_aerm, ln_aedm, ln_aq1m, ln_aq3m);
   util_pg.chdr(an_mid, ln_berm, ln_bedm, ln_bq1m, ln_bq3m);
   util_pg.chdr(an_mid, ln_cerm, ln_cedm, ln_cq1m, ln_cq3m);
   util_pg.chdr(an_mid, ln_derm, ln_dedm, ln_dq1m, ln_dq3m);
   ln_er := ROUND(util_pg.indicoverturn(ln_erm - lc.erm, an_digits) * ln_kc, ln_rn);
   ln_ed := ROUND(util_pg.indicoverturn(ln_edm - lc.edm, an_digits) * ln_kc, ln_rn);
   ln_q1 := ROUND(util_pg.indicoverturn(ln_q1m - lc.q1m, an_digits) * ln_kc, ln_rn);
   ln_q3 := ROUND(util_pg.indicoverturn(ln_q3m - lc.q3m, an_digits) * ln_kc, ln_rn);
   ln_aer := ROUND(util_pg.indicoverturn(ln_aerm - lc.aerm, an_digits) * ln_kc, ln_rn);
   ln_aed := ROUND(util_pg.indicoverturn(ln_aedm - lc.aedm, an_digits) * ln_kc, ln_rn);
   ln_aq1 := ROUND(util_pg.indicoverturn(ln_aq1m - lc.aq1m, an_digits) * ln_kc, ln_rn);
   ln_aq3 := ROUND(util_pg.indicoverturn(ln_aq3m - lc.aq3m, an_digits) * ln_kc, ln_rn);
   ln_ber := ROUND(util_pg.indicoverturn(ln_berm - lc.berm, an_digits) * ln_kc, ln_rn);
   ln_bed := ROUND(util_pg.indicoverturn(ln_bedm - lc.bedm, an_digits) * ln_kc, ln_rn);
   ln_bq1 := ROUND(util_pg.indicoverturn(ln_bq1m - lc.bq1m, an_digits) * ln_kc, ln_rn);
   ln_bq3 := ROUND(util_pg.indicoverturn(ln_bq3m - lc.bq3m, an_digits) * ln_kc, ln_rn);
   ln_cer := ROUND(util_pg.indicoverturn(ln_cerm - lc.cerm, an_digits) * ln_kc, ln_rn);
   ln_ced := ROUND(util_pg.indicoverturn(ln_cedm - lc.cedm, an_digits) * ln_kc, ln_rn);
   ln_cq1 := ROUND(util_pg.indicoverturn(ln_cq1m - lc.cq1m, an_digits) * ln_kc, ln_rn);
   ln_cq3 := ROUND(util_pg.indicoverturn(ln_cq3m - lc.cq3m, an_digits) * ln_kc, ln_rn);
   ln_der := ROUND(util_pg.indicoverturn(ln_derm - lc.derm, an_digits) * ln_kc, ln_rn);
   ln_ded := ROUND(util_pg.indicoverturn(ln_dedm - lc.dedm, an_digits) * ln_kc, ln_rn);
   ln_dq1 := ROUND(util_pg.indicoverturn(ln_dq1m - lc.dq1m, an_digits) * ln_kc, ln_rn);
   ln_dq3 := ROUND(util_pg.indicoverturn(ln_dq3m - lc.dq3m, an_digits) * ln_kc, ln_rn);
   /*   util_pg.chdr(an_mid, ln_er, ln_ed, ln_q1, ln_q3, ln_q2, ln_q4);
      util_pg.chdr(an_mid, ln_aer, ln_aed, ln_aq1, ln_aq3, ln_aq2, ln_aq4);
      util_pg.chdr(an_mid, ln_ber, ln_bed, ln_bq1, ln_bq3, ln_bq2, ln_bq4);
      util_pg.chdr(an_mid, ln_cer, ln_ced, ln_cq1, ln_cq3, ln_cq2, ln_cq4);
      util_pg.chdr(an_mid, ln_der, ln_ded, ln_dq1, ln_dq3, ln_dq2, ln_dq4);*/
   INSERT INTO billorg
               (mid, er, ed, q1, q3, q2, q4, aer, aed, aq1, aq3, aq2, aq4, ber,
                bed, bq1, bq3, bq2, bq4, cer, ced, cq1, cq3, cq2, cq4, der, ded, dq1,
                dq3, dq2, dq4, erm, edm, q1m, q3m, q2m, q4m, aerm, aedm, aq1m, aq3m,
                aq2m, aq4m, berm, bedm, bq1m, bq3m, bq2m, bq4m, cerm, cedm, cq1m, cq3m, cq2m,
                cq4m, derm, dedm, dq1m, dq3m, dq2m, dq4m, er_mtrsn, ed_mtrsn, q1_mtrsn, q3_mtrsn, q2_mtrsn,
                q4_mtrsn, date_time, source, nsource)
        VALUES (an_mid, ln_er, ln_ed, ln_q1, ln_q3, NULL, NULL, ln_aer, ln_aed, ln_aq1, ln_aq3, NULL, NULL, ln_ber,
                ln_bed, ln_bq1, ln_bq3, NULL, NULL, ln_cer, ln_ced, ln_cq1, ln_cq3, NULL, NULL, ln_der, ln_ded, ln_dq1,
                ln_dq3, NULL, NULL, ln_erm, ln_edm, ln_q1m, ln_q3m, NULL, NULL, ln_aerm, ln_aedm, ln_aq1m, ln_aq3m,
                NULL, NULL, ln_berm, ln_bedm, ln_bq1m, ln_bq3m, NULL, NULL, ln_cerm, ln_cedm, ln_cq1m, ln_cq3m, NULL,
                NULL, ln_derm, ln_dedm, ln_dq1m, ln_dq3m, NULL, NULL, av_mtrsn, av_mtrsn, av_mtrsn, av_mtrsn, NULL,
                NULL, ad_date, 'КС', cn_alpha);
  ELSE
   util_pg.chdr(an_mid, ln_erm, ln_edm, ln_q1m, ln_q3m);
   util_pg.chdr(an_mid, ln_aerm, ln_aedm, ln_aq1m, ln_aq3m);
   util_pg.chdr(an_mid, ln_berm, ln_bedm, ln_bq1m, ln_bq3m);
   util_pg.chdr(an_mid, ln_cerm, ln_cedm, ln_cq1m, ln_cq3m);
   util_pg.chdr(an_mid, ln_derm, ln_dedm, ln_dq1m, ln_dq3m);
   INSERT INTO billorg
               (mid, erm, edm, q1m, q3m, q2m, q4m, aerm, aedm, aq1m, aq3m, aq2m, aq4m,
                berm, bedm, bq1m, bq3m, bq2m, bq4m, cerm, cedm, cq1m, cq3m, cq2m, cq4m,
                derm, dedm, dq1m, dq3m, dq2m, dq4m, er_mtrsn, q1_mtrsn, ed_mtrsn, q3_mtrsn, q2_mtrsn, q4_mtrsn,
                date_time, source, nsource)
        VALUES (an_mid, ln_erm, ln_edm, ln_q1m, ln_q3m, NULL, NULL, ln_aerm, ln_aedm, ln_aq1m, ln_aq3m, NULL, NULL,
                ln_berm, ln_bedm, ln_bq1m, ln_bq3m, NULL, NULL, ln_cerm, ln_cedm, ln_cq1m, ln_cq3m, NULL, NULL,
                ln_derm, ln_dedm, ln_dq1m, ln_dq3m, NULL, NULL, av_mtrsn, av_mtrsn, av_mtrsn, av_mtrsn, NULL, NULL,
                ad_date, 'КС', cn_alpha);
  END IF;
 END;
 ------------------------------------------------------------------------------------------------------------------------
   --Вставка месячных
 PROCEDURE set_months_alpha(
  an_mid    NUMBER,
  an_erm    NUMBER,
  an_edm    NUMBER,
  an_q1m    NUMBER,
  an_q3m    NUMBER,
  an_aerm   NUMBER,
  an_aedm   NUMBER,
  an_aq1m   NUMBER,
  an_aq3m   NUMBER,
  an_berm   NUMBER,
  an_bedm   NUMBER,
  an_bq1m   NUMBER,
  an_bq3m   NUMBER,
  an_cerm   NUMBER,
  an_cedm   NUMBER,
  an_cq1m   NUMBER,
  an_cq3m   NUMBER,
  an_derm   NUMBER,
  an_dedm   NUMBER,
  an_dq1m   NUMBER,
  an_dq3m   NUMBER,
  av_mtrsn  VARCHAR2,
  an_digits NUMBER, --Значность счетчика, необходимо передать 6 - Alpha_ParamCalc.DPLocE
  ad_date   DATE) IS
  CURSOR lcur_sel IS
   SELECT NVL(erm, 0) erm, NVL(edm, 0) edm, NVL(q1m, 0) q1m, NVL(q3m, 0) q3m, NVL(q2m, 0) q2m, NVL(q4m, 0) q4m,
          NVL(aerm, 0) aerm, NVL(aedm, 0) aedm, NVL(aq1m, 0) aq1m, NVL(aq3m, 0) aq3m, NVL(aq2m, 0) aq2m, NVL(aq4m, 0) aq4m,
          NVL(berm, 0) berm, NVL(bedm, 0) bedm, NVL(bq1m, 0) bq1m, NVL(bq3m, 0) bq3m, NVL(bq2m, 0) bq2m, NVL(bq4m, 0) bq4m,
          NVL(cerm, 0) cerm, NVL(cedm, 0) cedm, NVL(cq1m, 0) cq1m, NVL(cq3m, 0) cq3m, NVL(cq2m, 0) cq2m, NVL(cq4m, 0) cq4m,
          NVL(derm, 0) derm, NVL(dedm, 0) dedm, NVL(dq1m, 0) dq1m, NVL(dq3m, 0) dq3m, NVL(dq2m, 0) dq2m, NVL(dq4m, 0) dq4m,
          NVL(er_mtrsn, ' ')
     FROM monthsorg
    WHERE mid = an_mid
      AND date_time = (SELECT MAX(date_time)
                         FROM monthsorg
                        WHERE mid = an_mid AND date_time < ad_date)
      AND UPPER(TRIM(er_mtrsn)) = UPPER(TRIM(av_mtrsn));
  lc       lcur_sel%ROWTYPE;
  lb_found BOOLEAN;
  ln_kc    NUMBER;
  ln_rn    NUMBER             DEFAULT 10;
  ln_erm   NUMBER             DEFAULT an_erm;
  ln_edm   NUMBER             DEFAULT an_edm;
  ln_q1m   NUMBER             DEFAULT an_q1m;
  ln_q3m   NUMBER             DEFAULT an_q3m;
  ln_aerm  NUMBER             DEFAULT an_aerm;
  ln_aedm  NUMBER             DEFAULT an_aedm;
  ln_aq1m  NUMBER             DEFAULT an_aq1m;
  ln_aq3m  NUMBER             DEFAULT an_aq3m;
  ln_berm  NUMBER             DEFAULT an_berm;
  ln_bedm  NUMBER             DEFAULT an_bedm;
  ln_bq1m  NUMBER             DEFAULT an_bq1m;
  ln_bq3m  NUMBER             DEFAULT an_bq3m;
  ln_cerm  NUMBER             DEFAULT an_cerm;
  ln_cedm  NUMBER             DEFAULT an_cedm;
  ln_cq1m  NUMBER             DEFAULT an_cq1m;
  ln_cq3m  NUMBER             DEFAULT an_cq3m;
  ln_derm  NUMBER             DEFAULT an_derm;
  ln_dedm  NUMBER             DEFAULT an_dedm;
  ln_dq1m  NUMBER             DEFAULT an_dq1m;
  ln_dq3m  NUMBER             DEFAULT an_dq3m;
  ln_er    NUMBER;
  ln_ed    NUMBER;
  ln_q1    NUMBER;
  ln_q3    NUMBER;
  ln_aer   NUMBER;
  ln_aed   NUMBER;
  ln_aq1   NUMBER;
  ln_aq3   NUMBER;
  ln_ber   NUMBER;
  ln_bed   NUMBER;
  ln_bq1   NUMBER;
  ln_bq3   NUMBER;
  ln_cer   NUMBER;
  ln_ced   NUMBER;
  ln_cq1   NUMBER;
  ln_cq3   NUMBER;
  ln_der   NUMBER;
  ln_ded   NUMBER;
  ln_dq1   NUMBER;
  ln_dq3   NUMBER;
 BEGIN
  OPEN lcur_sel;
  FETCH lcur_sel INTO lc;
  lb_found := lcur_sel%FOUND;
  CLOSE lcur_sel;
  IF lb_found THEN
   SELECT NVL(MAX(kc), 1)
     INTO ln_kc
     FROM feeders
    WHERE mid = an_mid;
   util_pg.chdr(an_mid, ln_erm, ln_edm, ln_q1m, ln_q3m);
   util_pg.chdr(an_mid, ln_aerm, ln_aedm, ln_aq1m, ln_aq3m);
   util_pg.chdr(an_mid, ln_berm, ln_bedm, ln_bq1m, ln_bq3m);
   util_pg.chdr(an_mid, ln_cerm, ln_cedm, ln_cq1m, ln_cq3m);
   util_pg.chdr(an_mid, ln_derm, ln_dedm, ln_dq1m, ln_dq3m);
   ln_er := ROUND(util_pg.indicoverturn(ln_erm - lc.erm, an_digits) * ln_kc, ln_rn);
   ln_ed := ROUND(util_pg.indicoverturn(ln_edm - lc.edm, an_digits) * ln_kc, ln_rn);
   ln_q1 := ROUND(util_pg.indicoverturn(ln_q1m - lc.q1m, an_digits) * ln_kc, ln_rn);
   ln_q3 := ROUND(util_pg.indicoverturn(ln_q3m - lc.q3m, an_digits) * ln_kc, ln_rn);
   ln_aer := ROUND(util_pg.indicoverturn(ln_aerm - lc.aerm, an_digits) * ln_kc, ln_rn);
   ln_aed := ROUND(util_pg.indicoverturn(ln_aedm - lc.aedm, an_digits) * ln_kc, ln_rn);
   ln_aq1 := ROUND(util_pg.indicoverturn(ln_aq1m - lc.aq1m, an_digits) * ln_kc, ln_rn);
   ln_aq3 := ROUND(util_pg.indicoverturn(ln_aq3m - lc.aq3m, an_digits) * ln_kc, ln_rn);
   ln_ber := ROUND(util_pg.indicoverturn(ln_berm - lc.berm, an_digits) * ln_kc, ln_rn);
   ln_bed := ROUND(util_pg.indicoverturn(ln_bedm - lc.bedm, an_digits) * ln_kc, ln_rn);
   ln_bq1 := ROUND(util_pg.indicoverturn(ln_bq1m - lc.bq1m, an_digits) * ln_kc, ln_rn);
   ln_bq3 := ROUND(util_pg.indicoverturn(ln_bq3m - lc.bq3m, an_digits) * ln_kc, ln_rn);
   ln_cer := ROUND(util_pg.indicoverturn(ln_cerm - lc.cerm, an_digits) * ln_kc, ln_rn);
   ln_ced := ROUND(util_pg.indicoverturn(ln_cedm - lc.cedm, an_digits) * ln_kc, ln_rn);
   ln_cq1 := ROUND(util_pg.indicoverturn(ln_cq1m - lc.cq1m, an_digits) * ln_kc, ln_rn);
   ln_cq3 := ROUND(util_pg.indicoverturn(ln_cq3m - lc.cq3m, an_digits) * ln_kc, ln_rn);
   ln_der := ROUND(util_pg.indicoverturn(ln_derm - lc.derm, an_digits) * ln_kc, ln_rn);
   ln_ded := ROUND(util_pg.indicoverturn(ln_dedm - lc.dedm, an_digits) * ln_kc, ln_rn);
   ln_dq1 := ROUND(util_pg.indicoverturn(ln_dq1m - lc.dq1m, an_digits) * ln_kc, ln_rn);
   ln_dq3 := ROUND(util_pg.indicoverturn(ln_dq3m - lc.dq3m, an_digits) * ln_kc, ln_rn);
   /*   util_pg.chdr(an_mid, ln_er, ln_ed, ln_q1, ln_q3, ln_q2, ln_q4);
      util_pg.chdr(an_mid, ln_aer, ln_aed, ln_aq1, ln_aq3, ln_aq2, ln_aq4);
      util_pg.chdr(an_mid, ln_ber, ln_bed, ln_bq1, ln_bq3, ln_bq2, ln_bq4);
      util_pg.chdr(an_mid, ln_cer, ln_ced, ln_cq1, ln_cq3, ln_cq2, ln_cq4);
      util_pg.chdr(an_mid, ln_der, ln_ded, ln_dq1, ln_dq3, ln_dq2, ln_dq4);*/
   INSERT INTO monthsorg
               (mid, er, ed, q1, q3, q2, q4, aer, aed, aq1, aq3, aq2, aq4, ber,
                bed, bq1, bq3, bq2, bq4, cer, ced, cq1, cq3, cq2, cq4, der, ded, dq1,
                dq3, dq2, dq4, erm, edm, q1m, q3m, q2m, q4m, aerm, aedm, aq1m, aq3m,
                aq2m, aq4m, berm, bedm, bq1m, bq3m, bq2m, bq4m, cerm, cedm, cq1m, cq3m, cq2m,
                cq4m, derm, dedm, dq1m, dq3m, dq2m, dq4m, er_mtrsn, ed_mtrsn, q1_mtrsn, q3_mtrsn, q2_mtrsn,
                q4_mtrsn, date_time, source, nsource)
        VALUES (an_mid, ln_er, ln_ed, ln_q1, ln_q3, NULL, NULL, ln_aer, ln_aed, ln_aq1, ln_aq3, NULL, NULL, ln_ber,
                ln_bed, ln_bq1, ln_bq3, NULL, NULL, ln_cer, ln_ced, ln_cq1, ln_cq3, NULL, NULL, ln_der, ln_ded, ln_dq1,
                ln_dq3, NULL, NULL, ln_erm, ln_edm, ln_q1m, ln_q3m, NULL, NULL, ln_aerm, ln_aedm, ln_aq1m, ln_aq3m,
                NULL, NULL, ln_berm, ln_bedm, ln_bq1m, ln_bq3m, NULL, NULL, ln_cerm, ln_cedm, ln_cq1m, ln_cq3m, NULL,
                NULL, ln_derm, ln_dedm, ln_dq1m, ln_dq3m, NULL, NULL, av_mtrsn, av_mtrsn, av_mtrsn, av_mtrsn, NULL,
                NULL, ad_date, 'КС', cn_alpha);
  ELSE
   util_pg.chdr(an_mid, ln_erm, ln_edm, ln_q1m, ln_q3m);
   util_pg.chdr(an_mid, ln_aerm, ln_aedm, ln_aq1m, ln_aq3m);
   util_pg.chdr(an_mid, ln_berm, ln_bedm, ln_bq1m, ln_bq3m);
   util_pg.chdr(an_mid, ln_cerm, ln_cedm, ln_cq1m, ln_cq3m);
   util_pg.chdr(an_mid, ln_derm, ln_dedm, ln_dq1m, ln_dq3m);
   INSERT INTO monthsorg
               (mid, erm, edm, q1m, q3m, q2m, q4m, aerm, aedm, aq1m, aq3m, aq2m, aq4m,
                berm, bedm, bq1m, bq3m, bq2m, bq4m, cerm, cedm, cq1m, cq3m, cq2m, cq4m,
                derm, dedm, dq1m, dq3m, dq2m, dq4m, er_mtrsn, q1_mtrsn, ed_mtrsn, q3_mtrsn, q2_mtrsn, q4_mtrsn,
                date_time, source, nsource)
        VALUES (an_mid, ln_erm, ln_edm, ln_q1m, ln_q3m, NULL, NULL, ln_aerm, ln_aedm, ln_aq1m, ln_aq3m, NULL, NULL,
                ln_berm, ln_bedm, ln_bq1m, ln_bq3m, NULL, NULL, ln_cerm, ln_cedm, ln_cq1m, ln_cq3m, NULL, NULL,
                ln_derm, ln_dedm, ln_dq1m, ln_dq3m, NULL, NULL, av_mtrsn, av_mtrsn, av_mtrsn, av_mtrsn, NULL, NULL,
                ad_date, 'КС', cn_alpha);
  END IF;
 END;
------------------------------------------------------------------------------------------------------------------------
 --******************************          Metkom              *******************************************************--
 ------------------------------------------------------------------------------------------------------------------------
  --Вставка графика нагрузки
 PROCEDURE set_halfhour_metcom(an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, ad_date DATE) IS
  ln_er NUMBER DEFAULT an_er;
  ln_ed NUMBER DEFAULT an_ed;
  ln_q1 NUMBER DEFAULT an_q1;
  ln_q3 NUMBER DEFAULT an_q3;
 BEGIN
  util_pg.chdr(an_mid, ln_er, ln_ed, ln_q1, ln_q3);
  INSERT INTO halfhourtmp
              (mid, date_time, nsource, er, ed, q1, q3)
       VALUES (an_mid, ad_date, cn_metkom, ln_er, ln_ed, ln_q1, ln_q3);
 EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
   UPDATE halfhourtmp
      SET er = ln_er,
          ed = ln_ed,
          q1 = ln_q1,
          q3 = ln_q3
    WHERE mid = an_mid AND date_time = ad_date AND nsource = cn_metkom;
  WHEN OTHERS THEN
   RAISE;
 END;
 ------------------------------------------------------------------------------------------------------------------------
END; -- Package Body comsrv_pg
/

-- End of DDL script for COMSRV_PG

-- Start of DDL script for DAS_PG
-- Generated 27-янв-03  11:34:00 am
-- from oe-RYDA:1

-- Package body DAS_PG

CREATE OR REPLACE
Package Body      DAS_PG
IS
-- Пакет Сервера сбора данных.
--
-- MODIFICATION HISTORY
-- Person      Date     Comments
-- ---------   -------- ------------------------------------------
-- Вештак      24.11.02 Создан

PROCEDURE CalcDay4Bill
  is

Begin
  CalcOneDay4Bill(-1,trunc(sysdate)-1);
  commit;
end;

PROCEDURE CalcOneDay4Bill (an_maket NUMBER, dday DATE)
  is
Begin
  insert into bill_calc (mid, date_time)
    select distinct mid, trunc(dday) + 1 from halfhourold
      where nexceptcalc is null
      and date_time > trunc(dday) and date_time <= trunc(dday) + 1;
  ProcessBillCalc;
end;

PROCEDURE CalcPeriod4Bill (dstart date, dend date)
  is
Begin
  insert into bill_calc (mid, date_time)
    select distinct mid, trunc(date_time)+1 from halfhourold
      where nexceptcalc is null
      and date_time > trunc(dstart) and date_time <= trunc(dend);
  ProcessBillCalc;
end;

PROCEDURE CalcPoint4Bill (nmid number, dstart date, dend date)
  is
Begin
  insert into bill_calc (mid, date_time)
    select distinct mid, trunc(date_time)+1 from halfhourold
      where nexceptcalc is null and mid = nmid
      and date_time > trunc(dstart) and date_time <= trunc(dend);
  ProcessBillCalc;
end;

PROCEDURE ProcessBillCalc is

  date_time_ date;
  rid_ number;
  lv_error varchar2(2000);
Begin

  delete from bill where (mid, date_time) in (select mid, date_time from bill_calc);
  date_time_ := trunc(sysdate, 'cc');
  for c in (select distinct date_time from bill_calc order by date_time) loop
    if date_time_ <> c.date_time then
      date_time_ := c.date_time;
      begin
        select distinct rid into rid_ from rates where to_char(time, 'mm') =
          (select max(to_char(time, 'mm')) from rates
          where to_char(time, 'mm') <= to_char(date_time_ - 1, 'mm'));
      exception when no_data_found then
        select distinct rid into rid_ from rates where to_char(time, 'mm') =
          (select max(to_char(time, 'mm')) from rates);
      end;
    end if;

        insert into bill (mid, date_time, source, er, aer, ber, cer, der,
                                              ed, aed, bed, ced, ded,
                                              q1, aq1, bq1, cq1, dq1,
                                              q2, aq2, bq2, cq2, dq2,
                                              q3, aq3, bq3, cq3, dq3,
                                              q4, aq4, bq4, cq4, dq4)
        (select mids, dates, 'Расч', sum(ers), sum(aers), sum(bers), sum(cers), sum(ders),
                                              sum(eds), sum(aeds), sum(beds), sum(ceds), sum(deds),
                                              sum(q1s), sum(aq1s), sum(bq1s), sum(cq1s), sum(dq1s),
                                              sum(q2s), sum(aq2s), sum(bq2s), sum(cq2s), sum(dq2s),
                                              sum(q3s), sum(aq3s), sum(bq3s), sum(cq3s), sum(dq3s),
                                              sum(q4s), sum(aq4s), sum(bq4s), sum(cq4s), sum(dq4s)
        from (select b.mid mids, b.date_time dates,
         nvl(er,0) ers, decode(rate, 0, er, 0) aers, decode(rate, 1, er, 0) bers, decode(rate, 2, er, 0) cers, decode(rate, 3, er, 0) ders,
         nvl(ed,0) eds, decode(rate, 0, ed, 0) aeds, decode(rate, 1, ed, 0) beds, decode(rate, 2, ed, 0) ceds, decode(rate, 3, ed, 0) deds,
         nvl(q1,0) q1s, decode(rate, 0, q1, 0) aq1s, decode(rate, 1, q1, 0) bq1s, decode(rate, 2, q1, 0) cq1s, decode(rate, 3, q1, 0) dq1s,
         nvl(q2,0) q2s, decode(rate, 0, q2, 0) aq2s, decode(rate, 1, q2, 0) bq2s, decode(rate, 2, q2, 0) cq2s, decode(rate, 3, q2, 0) dq2s,
         nvl(q3,0) q3s, decode(rate, 0, q3, 0) aq3s, decode(rate, 1, q3, 0) bq3s, decode(rate, 2, q3, 0) cq3s, decode(rate, 3, q3, 0) dq3s,
         nvl(q4,0) q4s, decode(rate, 0, q4, 0) aq4s, decode(rate, 1, q4, 0) bq4s, decode(rate, 2, q4, 0) cq4s, decode(rate, 3, q4, 0) dq4s
         from halfhour h, bill_calc b, rates r
         where h.mid = b.mid and b.date_time = date_time_
         and h.date_time > date_time_ - 1
         and h.date_time <= date_time_
         and r.rid = rid_
         and to_char(h.date_time-1/1440, 'sssss') >= to_char(r.time, 'sssss')
         and to_char(h.date_time-1/1440, 'sssss') < to_char(r.endtime, 'sssss')
         ) s
         group by s.mids, s.dates);
  end loop;
  delete from bill_calc;
--  insert into jobs(njob,date_time) values(3,sysdate);
 -- commit;
--exception
--when others then
  --  rollback;
    --lv_error := SQLERRM;
    --insert into jobs(njob,date_time,errortext) values(3,sysdate,lv_error);
    commit;
end;


END;
/

-- End of DDL script for DAS_PG

-- Start of DDL script for DEPARTMENTS_PG
-- Generated 27-янв-03  11:34:00 am
-- from oe-RYDA:1

-- Package body DEPARTMENTS_PG

CREATE OR REPLACE
PACKAGE BODY DEPARTMENTS_PG IS
  -- пакет работы с подразделениями
  -- дата создания 14/10/2001 (Сечин А.А.)
------------------------------------------------------------------------------------------------------------------------
  -- Процедура вставки
 PROCEDURE ins_p(
  av_name           VARCHAR2, --Название
  an_sort           NUMBER,   --Сортировка
  an_department OUT NUMBER --Ид подразделения
                 )
 IS
  ln_department NUMBER;
 BEGIN
  SELECT report_s.NEXTVAL
    INTO ln_department
    FROM DUAL;
  an_department := ln_department;
  INSERT INTO departments
              (ndepartment, vname, nsort)
       VALUES (ln_department, av_name, an_sort);
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'departments_pg.ins_p: Ошибка вставки подразделения. ' ||
                                   CHR(10) ||
                                   SQLERRM(SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
  -- Процедура обновления данных
 PROCEDURE upd_p(
  an_department NUMBER, --Ид подразделения
  av_name       VARCHAR2, --Название
  an_sort       NUMBER   --Сортировка
                        )
 IS
 BEGIN
  SAVEPOINT departments_ins_s;
  UPDATE departments
     SET vname = av_name,
         nsort = an_sort
   WHERE ndepartment = an_department;
  UPDATE reportgroups
     SET vname = av_name
   WHERE ndepartment = an_department;
 EXCEPTION
  WHEN OTHERS THEN
   ROLLBACK TO SAVEPOINT departments_ins_s;
   raise_application_error(
    -20001, 'departments_pg.upd_p: Ошибка обновления подразделения. ' ||
            CHR(10) ||
            SQLERRM(SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
  -- Процедура удаления данных
 PROCEDURE del_p(
  an_department NUMBER --Ид подразделения
                      )
 IS
 BEGIN
  DELETE FROM departments
        WHERE ndepartment = an_department;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'departments_pg.del_p: Ошибка удаления подразделения. ' ||
                                   CHR(10) ||
                                   SQLERRM(SQLCODE));
 END;
------------------------------------------------------------------------------------------------------------------------
END; -- Package Body
/

-- End of DDL script for DEPARTMENTS_PG

-- Start of DDL script for DEPORTATION_PG
-- Generated 27-янв-03  11:34:00 am
-- from oe-RYDA:1

-- Package body DEPORTATION_PG

CREATE OR REPLACE
PACKAGE BODY deportation_pg IS
   -- пакет работы с каналами экспорта данных
   -- дата создания 26/07/2002 (Сечин А.А.)
 ------------------------------------------------------------------------------------------------------------------------
    -- Процедура вставки
 PROCEDURE ins_p(
  av_name             VARCHAR2, --Название
  av_note             VARCHAR2, --Примечание
  an_maket        NUMBER, --Ид макета
  an_type             NUMBER, --Тип отсылки
  av_address          VARCHAR2, --Адрес
  an_parent           NUMBER, --Ид основного канала
  ad_from             DATE, --Отсылать с
  ad_till             DATE, --Отсылать по
  an_block            NUMBER, --Блокировка
  an_retries_tout     NUMBER, --Пауза между попытками мин
  an_retries          NUMBER, --Количество попыток
  an_deportation  OUT NUMBER --Ид канала
                            ) IS
  ln_deportation NUMBER;
 BEGIN
  SAVEPOINT deportation_ins;
  SELECT points_seq.NEXTVAL
    INTO ln_deportation
    FROM DUAL;
  INSERT INTO deportation
              (ndeportation, vname, vnote, nmaket, ntype,
               vaddress, nparent, dfrom, dtill, nblock, nretries_tout, nretries)
       VALUES (ln_deportation, av_name, av_note, DECODE(an_parent, NULL, an_maket,NULL), an_type,
               av_address, an_parent, ad_from, ad_till, an_block, an_retries_tout, an_retries);
  an_deportation := ln_deportation;
 EXCEPTION
  WHEN OTHERS THEN
   ROLLBACK TO SAVEPOINT deportation_ins;
   raise_application_error(
    -20001, 'DEPORTATION_pg.ins_p: Ошибка добавления каналами экспорта. ' || CHR(10) || SQLERRM(SQLCODE));
 END;
 ------------------------------------------------------------------------------------------------------------------------
    -- Процедура обновления
 PROCEDURE upd_p(
  an_deportation  NUMBER, --Ид канала
  av_name         VARCHAR2, --Название
  av_note         VARCHAR2, --Примечание
  an_maket        NUMBER, --Ид макета
  an_type         NUMBER, --Тип отсылки
  av_address      VARCHAR2, --Адрес
  an_parent       NUMBER, --Ид основного канала
  ad_from         DATE, --Отсылать с
  ad_till         DATE, --Отсылать по
  an_block        NUMBER, --Блокировка
  an_retries_tout NUMBER, --Пауза между попытками мин
  an_retries      NUMBER --Количество попыток
                        ) IS
 BEGIN
  SAVEPOINT deportation_upd;
  UPDATE deportation
     SET vname = av_name,
         vnote = av_note,
         nmaket = DECODE(an_parent, NULL, an_maket,NULL),
         ntype = an_type,
         vaddress = av_address,
         nparent = an_parent,
         dfrom = ad_from,
         dtill = ad_till,
         nblock = an_block,
         nretries_tout = an_retries_tout,
         nretries = an_retries
   WHERE ndeportation = an_deportation;
 EXCEPTION
  WHEN OTHERS THEN
   ROLLBACK TO SAVEPOINT deportation_upd;
   raise_application_error(
    -20001, 'DEPORTATION_pg.upd_p: Ошибка обновления каналами экспорта. ' || CHR(10) || SQLERRM(SQLCODE));
 END;
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура удаления данных
 PROCEDURE del_p(an_deportation NUMBER --Ид канала
                                      ) IS
 BEGIN
  SAVEPOINT deportation_del;
  UPDATE deportation
     SET nparent = NULL,
         nblock = 1
   WHERE nparent = an_deportation;
  DELETE FROM deportation
        WHERE ndeportation = an_deportation;
 EXCEPTION
  WHEN OTHERS THEN
   ROLLBACK TO SAVEPOINT deportation_del;
   raise_application_error(
    -20001, 'DEPORTATION_pg.del_p: Ошибка удаления каналами экспорта. ' || CHR(10) || SQLERRM(SQLCODE));
 END;
------------------------------------------------------------------------------------------------------------------------
END; -- Package Body
/

-- End of DDL script for DEPORTATION_PG

-- Start of DDL script for DEPORTPROCS_PG
-- Generated 27-янв-03  11:34:00 am
-- from oe-RYDA:1

-- Package body DEPORTPROCS_PG

CREATE OR REPLACE
PACKAGE BODY DEPORTPROCS_PG IS
   -- пакет работы с таблицей DEPORTPROCEDURES
   -- дата создания 01/12/2002 (Чудаков И.В.)
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура вставки
 PROCEDURE ins_p(
    av_vname                          VARCHAR2,
    av_vprocedure                     VARCHAR2,
    an_nperiod                        NUMBER,
    an_nshift                         NUMBER,
    an_ntype                          NUMBER,
    av_vparam                         VARCHAR2,
    av_vmemo                          VARCHAR2,
    an_nprocedure   OUT               NUMBER
                             ) IS
  ln_mid NUMBER;
 BEGIN
  SAVEPOINT deportprocs_ins;
  SELECT users_seq.NEXTVAL
    INTO ln_mid
    FROM DUAL;
  INSERT INTO DEPORTPROCEDURES
                (nprocedure, vname, vprocedure, nperiod, ntype, vmemo)
       VALUES (ln_mid,
               av_vname, av_vprocedure, an_nperiod, an_ntype, av_vmemo);
  an_nprocedure := ln_mid;
 EXCEPTION
  WHEN OTHERS THEN
   ROLLBACK TO SAVEPOINT deportprocs_ins;
   raise_application_error(-20001, 'deportprocs_pg.ins_p: Ошибка вставки строки. ' || CHR(10) || SQLERRM(SQLCODE));
 END;
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура обновления данных
 PROCEDURE upd_p(
    an_nprocedure                     NUMBER,
    av_vname                          VARCHAR2,
    av_vprocedure                     VARCHAR2,
    an_nperiod                        NUMBER,
    an_nshift                         NUMBER,
    an_ntype                          NUMBER,
    av_vparam                         VARCHAR2,
    av_vmemo                          VARCHAR2
                         ) IS
 BEGIN
  SAVEPOINT deportprocs_upd;
  UPDATE DEPORTPROCEDURES
     SET
        vname = av_vname,
        vprocedure = av_vprocedure,
        nperiod = an_nperiod,
        ntype = an_ntype,
        vmemo = av_vmemo
   WHERE nprocedure = an_nprocedure;
 EXCEPTION
  WHEN OTHERS THEN
   ROLLBACK TO SAVEPOINT deportprocs_upd;
   raise_application_error(-20001, 'deportprocs_pg.upd_p: Ошибка обновления DEPORTPROCEDURES. ' || CHR(10) || SQLERRM(SQLCODE));
 END;
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура удаления данных
 PROCEDURE del_p(an_nprocedure NUMBER
                              ) IS
 BEGIN
  SAVEPOINT deportprocs_del;
  DELETE FROM DEPORTPROCEDURES
        WHERE nprocedure = an_nprocedure;
 EXCEPTION
  WHEN OTHERS THEN
   ROLLBACK TO SAVEPOINT deportprocs_del;
   raise_application_error(-20001, 'deportprocs_pg.del_p: Ошибка удаления строки. ' || CHR(10) || SQLERRM(SQLCODE));
 END;
 ------------------------------------------------------------------------------------------------------------------------
END; -- Package Body
/

-- End of DDL script for DEPORTPROCS_PG

-- Start of DDL script for EDITCANALS_PG
-- Generated 27-янв-03  11:34:00 am
-- from oe-RYDA:1

-- Package body EDITCANALS_PG

CREATE OR REPLACE
PACKAGE BODY editcanals_pg
IS
  -- пакет работы с каналами
  -- дата создания 27/12/2001 (Сечин А.А.)
------------------------------------------------------------------------------------------------------------------------
  -- Процедура вставки
 PROCEDURE ins_p(
  an_parent           NUMBER, --Родитель
  av_name             VARCHAR2, --Название
  av_short_name       VARCHAR2, --Краткое название
  an_protocol_id      NUMBER, --
  an_com_id           NUMBER, --
  av_init_str         VARCHAR2, --
  av_addr             VARCHAR2, --
  an_cycle_tout       NUMBER, --
  an_retries          NUMBER, --
  an_retries_tout     NUMBER, --
  an_blocking         NUMBER, --
  av_caller_name      VARCHAR2, --
  an_mid          OUT NUMBER --Ид точки
                            )
 IS
  ln_mid NUMBER;
 BEGIN
  SAVEPOINT editcanals_ins;
  SELECT points_seq.NEXTVAL
    INTO ln_mid
    FROM DUAL;
  an_mid := ln_mid;
  INSERT INTO points
              (mid, parent, cod, ind, name, short_name, calc_count, ovv_count, ptype, implement_date, min30, min3, tag)
       VALUES (ln_mid, an_parent, 0, 2, av_name, av_short_name, 0, 0, 1, SYSDATE, 0, 0, NULL);
  INSERT INTO passive_dvs
              (mid, protocol_id, com_id, init_str, addr, cycle_tout, retries, retries_tout, blocking,
               caller_name)
       VALUES (ln_mid, an_protocol_id, an_com_id, av_init_str, av_addr, an_cycle_tout, an_retries, an_retries_tout, DECODE(an_blocking, 0, 'n', '*'),
               av_caller_name);
  INSERT INTO last_save
              (mid, PROFILE, halfhour, bill, state_date, state_cod, state_descr, clock, luck, rates, months)
   SELECT ln_mid, SYSDATE - 1, SYSDATE - 7, SYSDATE - 62, SYSDATE, 0, '(КС::Штатный режим)', 0, SYSDATE - 7, MAX(edit_date) - 1, SYSDATE - 370
     FROM rate_edit_date;
 EXCEPTION
  WHEN OTHERS THEN
   ROLLBACK TO SAVEPOINT editcanals_ins;
   raise_application_error(-20001, 'editcanals_pg.ins_p: Ошибка вставки канала. ' || CHR(10) || SQLERRM(SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
  -- Процедура обновления данных
 PROCEDURE upd_p(
  an_mid          NUMBER, --Ид точки
  an_parent       NUMBER, --Родитель
  av_name         VARCHAR2, --Название
  av_short_name   VARCHAR2, --Краткое название
  an_protocol_id  NUMBER, --
  an_com_id       NUMBER, --
  av_init_str     VARCHAR2, --
  av_addr         VARCHAR2, --
  an_cycle_tout   NUMBER, --
  an_retries      NUMBER, --
  an_retries_tout NUMBER, --
  an_blocking     NUMBER, --
  av_caller_name  VARCHAR2 --
                          )
 IS
  ln_lid NUMBER;
 BEGIN
  SAVEPOINT editcanals_upd;
  UPDATE points
     SET name = av_name,
         short_name = av_short_name
   WHERE mid = an_mid;
  UPDATE passive_dvs
     SET protocol_id = an_protocol_id,
         com_id = an_com_id,
         init_str = av_init_str,
         addr = av_addr,
         cycle_tout = an_cycle_tout,
         retries = an_retries,
         retries_tout = an_retries_tout,
         blocking = DECODE(an_blocking, 0, 'n', '*'),
         caller_name = av_caller_name
   WHERE mid = an_mid;
 EXCEPTION
  WHEN OTHERS THEN
   ROLLBACK TO SAVEPOINT editcanals_upd;
   raise_application_error(-20001, 'editcanals_pg.upd_p: Ошибка обновления канала. ' || CHR(10) || SQLERRM(SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
  -- Процедура удаления данных
 PROCEDURE del_p(
  an_mid NUMBER --Ид точки
               )
 IS
 BEGIN
  DELETE FROM points
        WHERE mid = an_mid;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'editcanals_pg.del_p: Ошибка удаления канала. ' || CHR(10) || SQLERRM(SQLCODE));
 END;
------------------------------------------------------------------------------------------------------------------------
END; -- Package Body
/

-- End of DDL script for EDITCANALS_PG

-- Start of DDL script for EDITEXPORTGROUP_PG
-- Generated 27-янв-03  11:34:01 am
-- from oe-RYDA:1

-- Package body EDITEXPORTGROUP_PG

CREATE OR REPLACE
PACKAGE BODY editexportgroup_pg
IS
  -- пакет работы с экспортируемыми группами
  -- дата создания 26/12/2001 (Сечин А.А.)
------------------------------------------------------------------------------------------------------------------------
  -- Процедура вставки
 PROCEDURE ins_p(
  an_parent          NUMBER, --Родитель
  av_name            VARCHAR2, --Название
  av_short_name      VARCHAR2, --Краткое название
  an_mid             NUMBER, --Ид точки
  an_inverted        NUMBER, --Признак инвертирования
  an_group_total     NUMBER, --Признак суммирования по группе
  an_isbill          NUMBER, --Экспорт суток
  an_billsz          NUMBER, --Экспорт суток (размер)
  an_ishour          NUMBER, --Экспорт получасовок
  an_hoursz          NUMBER, --Экспорт получасовок (размер)
  an_isprof          NUMBER, --Экспорт профиля
  an_profsz          NUMBER, --Экспорт профиля (размер)
  an_isjournal       NUMBER, --Экспорт журнала
  an_journalsz       NUMBER, --Экспорт журнала (размер)
  an_gid         OUT NUMBER --Ид группы
                           )
 IS
  ln_gid NUMBER;
 BEGIN
  SAVEPOINT editexportgroup_ins;
  SELECT groups_seq.NEXTVAL
    INTO ln_gid
    FROM DUAL;
  an_gid := ln_gid;
  INSERT INTO export_groups
              (gid, parent, name, short_name, mid, inverted, group_total, isbill,
               billsz, ishour, hoursz,
               isprof, profsz, isjournal,
               journalsz)
       VALUES (ln_gid, an_parent, av_name, av_short_name, an_mid, DECODE(an_inverted, 1, 'y', 'n'), DECODE(an_group_total, 1, 'y', 'n'), NVL(an_isbill, 0),
               DECODE(NVL(an_isbill, 0), 1, an_billsz, 0, NULL, an_billsz), NVL(an_ishour, 0), DECODE(NVL(an_ishour, 0), 1, an_hoursz, 0, NULL, an_hoursz),
               NVL(an_isprof, 0), DECODE(NVL(an_isprof, 0), 1, an_profsz, 0, NULL, an_profsz), NVL(an_isjournal, 0),
               DECODE(NVL(an_isjournal, 0), 1, an_journalsz, 0, NULL, an_journalsz));
 EXCEPTION
  WHEN OTHERS THEN
   ROLLBACK TO SAVEPOINT editexportgroup_ins;
   raise_application_error(-20001, 'editexportgroup_pg.ins_p: Ошибка вставки экспортируемой группы. ' || CHR(10) || SQLERRM(SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
  -- Процедура обновления данных
 PROCEDURE upd_p(
  an_gid         NUMBER, --Ид группы
  an_parent      NUMBER, --Родитель
  av_name        VARCHAR2, --Название
  av_short_name  VARCHAR2, --Краткое название
  an_mid         NUMBER, --Ид точки
  an_inverted    NUMBER, --Признак инвертирования
  an_group_total NUMBER, --Признак суммирования по группе
  an_isbill      NUMBER, --Экспорт суток
  an_billsz      NUMBER, --Экспорт суток (размер)
  an_ishour      NUMBER, --Экспорт получасовок
  an_hoursz      NUMBER, --Экспорт получасовок (размер)
  an_isprof      NUMBER, --Экспорт профиля
  an_profsz      NUMBER, --Экспорт профиля (размер)
  an_isjournal   NUMBER, --Экспорт журнала
  an_journalsz   NUMBER --Экспорт журнала (размер)
                       )
 IS
 BEGIN
  SAVEPOINT editexportgroup_upd;
  UPDATE export_groups
     SET parent = an_parent,
         name = av_name,
         short_name = av_short_name,
         inverted = DECODE(an_inverted, 1, 'y', 'n'),
         group_total = DECODE(an_group_total, 1, 'y', 'n'),
         isbill = NVL(an_isbill, 0),
         billsz = DECODE(NVL(an_isbill, 0), 1, an_billsz, 0, NULL, an_billsz),
         ishour = NVL(an_ishour, 0),
         hoursz = DECODE(NVL(an_ishour, 0), 1, an_hoursz, 0, NULL, an_hoursz),
         isprof = NVL(an_isprof, 0),
         profsz = DECODE(NVL(an_isprof, 0), 1, an_profsz, 0, NULL, an_profsz),
         isjournal = NVL(an_isjournal, 0),
         journalsz = DECODE(NVL(an_isjournal, 0), 1, an_journalsz, 0, NULL, an_journalsz)
   WHERE gid = an_gid;
 EXCEPTION
  WHEN OTHERS THEN
   ROLLBACK TO SAVEPOINT editexportgroup_upd;
   raise_application_error(-20001, 'editexportgroup_pg.upd_p: Ошибка обновления экспортируемой группы. ' || CHR(10) || SQLERRM(SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
  -- Процедура удаления данных
 PROCEDURE del_p(
  an_gid NUMBER --Ид точки
               )
 IS
 BEGIN
  DELETE FROM export_groups
        WHERE gid = an_gid;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'editexportgroup_pg.del_p: Ошибка удаления экспортируемой группы. ' || CHR(10) || SQLERRM(SQLCODE));
 END;
------------------------------------------------------------------------------------------------------------------------
END; -- Package Body
/

-- End of DDL script for EDITEXPORTGROUP_PG

-- Start of DDL script for EDITFEEDERGROUP_PG
-- Generated 27-янв-03  11:34:01 am
-- from oe-RYDA:1

-- Package body EDITFEEDERGROUP_PG

CREATE OR REPLACE
PACKAGE BODY editfeedergroup_pg IS
   -- пакет работы с группами присоединений
   -- дата создания 28/12/2001 (Сечин А.А.)
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура вставки
 PROCEDURE ins_p(
  an_parent         NUMBER, --Родитель
  av_name           VARCHAR2, --Название
  av_short_name     VARCHAR2, --Краткое название
  an_mid        OUT NUMBER --Ид точки
                          ) IS
  ln_mid NUMBER;
 BEGIN
  SAVEPOINT editfeedergroup_ins;
  SELECT points_seq.NEXTVAL
    INTO ln_mid
    FROM DUAL;
  an_mid := ln_mid;
  INSERT INTO points
              (mid, parent, cod, ind, name, short_name, calc_count, ovv_count, ptype, implement_date, min30, min3, tag,
               npoint)
       VALUES (ln_mid, an_parent, 0, 2, av_name, av_short_name, 0, 0, NULL, SYSDATE, NULL, NULL, NULL,
               NULL);
  INSERT INTO manual_dvs
              (mid)
       VALUES (ln_mid);
  IF util_pg.get_customer_id = 1 THEN
   ln_mid:=editfeeders_pg.InsGroup(ln_mid);
  END IF;
 EXCEPTION
  WHEN OTHERS THEN
   ROLLBACK TO SAVEPOINT editfeedergroup_ins;
   raise_application_error(
    -20001, 'editfeedergroup_pg.ins_p: Ошибка группы присоединений. ' || CHR(10) || SQLERRM(SQLCODE));
 END;
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура обновления данных
 PROCEDURE upd_p(
  an_mid        NUMBER, --Ид точки
  an_parent     NUMBER, --Родитель
  av_name       VARCHAR2, --Название
  av_short_name VARCHAR2 --Краткое название
                        ) IS
 ln_gid NUMBER;
 ln_gid1 NUMBER;
 BEGIN
  SAVEPOINT editfeedergroup_upd;
  UPDATE points
     SET name = av_name,
         short_name = av_short_name,
         parent = an_parent
   WHERE mid = an_mid;
  IF util_pg.get_customer_id = 1 THEN
   ln_gid:=editfeeders_pg.InsGroup(an_parent);
   ln_gid1:=editfeeders_pg.InsGroup(an_mid);
   update groups set name=av_name,parent=ln_gid where nroot1=1 and nroot2=an_mid;
  END IF;
 EXCEPTION
  WHEN OTHERS THEN
   ROLLBACK TO SAVEPOINT editfeedergroup_upd;
   raise_application_error(
    -20001, 'editfeedergroup_pg.upd_p: Ошибка обновления группы присоединений. ' || CHR(10) || SQLERRM(SQLCODE));
 END;
 ------------------------------------------------------------------------------------------------------------------------
    -- Процедура вставки для АСРПБ
 PROCEDURE ins_p_a(
  an_parent         NUMBER, --Родитель
  av_name           VARCHAR2, --Название
  av_short_name     VARCHAR2, --Краткое название
  an_point          NUMBER, --Ид прома
  an_mid        OUT NUMBER --Ид точки
                          ) IS
  ln_mid NUMBER;
 BEGIN
  SELECT points_seq.NEXTVAL
    INTO ln_mid
    FROM DUAL;
  an_mid := ln_mid;
  INSERT INTO points
              (mid, parent, cod, ind, name, short_name, calc_count, ovv_count, ptype, implement_date, min30, min3, tag,
               npoint)
       VALUES (ln_mid, an_parent, 0, 2, av_name, av_short_name, 0, 0, 1, SYSDATE, 0, 0, NULL,
               an_point);
  INSERT INTO manual_dvs
              (mid)
       VALUES (ln_mid);
  ln_mid:=editfeeders_pg.InsGroup(ln_mid);
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(
    -20001, 'editfeedergroup_pg.ins_p: Ошибка группы присоединений. ' || CHR(10) || SQLERRM(SQLCODE));
 END;
 ------------------------------------------------------------------------------------------------------------------------
    -- Процедура обновления данных для АСРПБ
 PROCEDURE upd_p_a(
  an_mid        NUMBER, --Ид точки
  an_parent     NUMBER, --Родитель
  av_name       VARCHAR2, --Название
  av_short_name VARCHAR2 --Краткое название
                        ) IS
 ln_gid NUMBER;
 ln_gid1 NUMBER;
 BEGIN
  UPDATE points
     SET name = av_name,
         short_name = av_short_name,
         parent = an_parent
   WHERE mid = an_mid;
  ln_gid:=editfeeders_pg.InsGroup(an_parent);
  ln_gid1:=editfeeders_pg.InsGroup(an_mid);
  update groups set name=av_name,parent=ln_gid where nroot1=1 and nroot2=an_mid;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(
    -20001, 'editfeedergroup_pg.upd_p: Ошибка обновления группы присоединений. ' || CHR(10) || SQLERRM(SQLCODE));
 END;
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура удаления данных
 PROCEDURE del_p(an_mid NUMBER --Ид точки
                              ) IS
 BEGIN
  DELETE FROM points
        WHERE mid = an_mid;
  delete from groups where nroot1=1 and nroot2=an_mid;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(
    -20001, 'editfeedergroup_pg.del_p: Ошибка удаления группы присоединений. ' || CHR(10) || SQLERRM(SQLCODE));
 END;
------------------------------------------------------------------------------------------------------------------------
END; -- Package Body
/

-- End of DDL script for EDITFEEDERGROUP_PG

-- Start of DDL script for EDITFEEDERS_PG
-- Generated 27-янв-03  11:34:01 am
-- from oe-RYDA:1

-- Package body EDITFEEDERS_PG

CREATE OR REPLACE
PACKAGE BODY editfeeders_pg IS
   -- пакет работы с точками
   -- дата создания 19/10/2001 (Сечин А.А.)
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура вставки
 PROCEDURE ins_p(
  an_parent          NUMBER, --Родитель
  an_type            NUMBER, --Тип точки
  av_name            VARCHAR2, --Название
  av_short_name      VARCHAR2, --Краткое название
  an_er_position     NUMBER,
  an_q1_position     NUMBER,
  an_ed_position     NUMBER,
  an_q3_position     NUMBER,
  an_smart           NUMBER, --Интеллектуал
  an_q1234           NUMBER, --Квадранты
  an_canal           NUMBER, --Номер канала
  av_cellnum         VARCHAR2, --Номер ячейки
  an_power           NUMBER, --Мощность
  an_current1        NUMBER, --Напряжение перв
  an_current2        NUMBER, --Напряжение вторич
  an_kc              NUMBER, --Коэфф
  an_tag             NUMBER, --Тег связи
  av_info            VARCHAR2, --Доп информация
  an_power2          NUMBER, --Мощность вторич кВ
  an_metkc           NUMBER, --Коэф прошитый в счетчике
  an_abc             NUMBER, --Заземленная нейтраль
  an_calcbill        NUMBER, --Верифицировать суточные
  an_calcmonths      NUMBER, --Верифицировать месячные
  an_inverted        NUMBER, --Инверсия
  an_switch          NUMBER, --Признак обводника
  an_mid         OUT NUMBER --Ид точки
                           ) IS
  ln_mid NUMBER;
 BEGIN
  SAVEPOINT editfeeders_ins;
  SELECT points_seq.NEXTVAL
    INTO ln_mid
    FROM DUAL;
  an_mid := ln_mid;
  INSERT INTO points
              (mid, parent, cod, ind, name, short_name, calc_count, ovv_count, ptype, implement_date, min30, min3, tag,
               npoint)
       VALUES (ln_mid, an_parent, 0, an_type, av_name, av_short_name, 0, 0, 1, SYSDATE, 0, 0, an_tag,
               NULL);
  INSERT INTO feeders
              (mid, er_position, q1_position, ed_position, q3_position, smart,
               q1234, canal, cellnum, POWER, current1, current2, kc, line_loss, act_loss, react_loss,
               vinfo, power2, metkc, nabc, ncalcbill, ncalcmonths,
               ninverted, nswitch)
       VALUES (ln_mid, an_er_position, an_q1_position, an_ed_position, an_q3_position, DECODE(an_smart, 1, '*', ''),
               DECODE(an_q1234, 1, '*', ''), an_canal, av_cellnum, an_power, an_current1, an_current2, an_kc, 0, 0, 0,
               av_info, an_power2, NVL(an_metkc, 1), NVL(an_abc, 0), NVL(an_calcbill, 0), NVL(an_calcmonths, 0),
               NVL(an_inverted, 0), NVL(an_switch, 0));
  INSERT INTO curr_power
              (mid, obsolete)
       VALUES (ln_mid, 1);
  --last_input
  IF an_er_position != 0 THEN
   INSERT INTO last_input
               (lid, mid, name, position, entype, kc)
        VALUES (points_seq.NEXTVAL, ln_mid, av_name || ' А птр.', an_er_position, 1, an_kc);
  END IF;
  IF an_ed_position != 0 THEN
   INSERT INTO last_input
               (lid, mid, name, position, entype, kc)
        VALUES (points_seq.NEXTVAL, ln_mid, av_name || ' А выд.', an_ed_position, 2, an_kc);
  END IF;
  IF an_q1_position != 0 THEN
   INSERT INTO last_input
               (lid, mid, name, position, entype, kc)
        VALUES (points_seq.NEXTVAL, ln_mid, av_name || DECODE(an_q1234, 1, ' Q1', ' Р птр.'), an_q1_position, 3, an_kc);
   IF an_q1234 = 1 THEN
    INSERT INTO last_input
                (lid, mid, name, position, entype, kc)
         VALUES (points_seq.NEXTVAL, ln_mid, av_name || ' Q2', an_q1_position, 4, an_kc);
   END IF;
  END IF;
  IF an_q3_position != 0 THEN
   INSERT INTO last_input
               (lid, mid, name, position, entype, kc)
        VALUES (points_seq.NEXTVAL, ln_mid, av_name || DECODE(an_q1234, 1, ' Q3', ' Р выд.'), an_q3_position, 5, an_kc);
   IF an_q1234 = 1 THEN
    INSERT INTO last_input
                (lid, mid, name, position, entype, kc)
         VALUES (points_seq.NEXTVAL, ln_mid, av_name || ' Q4', an_q3_position, 6, an_kc);
   END IF;
  END IF;
  --meters
  IF an_smart = 1 THEN
   INSERT INTO meters
               (id, mid, name, position, entype, smart, kc)
        VALUES (points_seq.NEXTVAL, ln_mid, av_name || ' Инт.', an_er_position, 7, '*', an_kc);
  ELSE
   IF an_er_position != 0 THEN
    INSERT INTO meters
                (id, mid, name, position, entype, smart, kc)
         VALUES (points_seq.NEXTVAL, ln_mid, av_name || ' А птр.', an_er_position, 1, '', an_kc);
   END IF;
   IF an_ed_position != 0 THEN
    INSERT INTO meters
                (id, mid, name, position, entype, smart, kc)
         VALUES (points_seq.NEXTVAL, ln_mid, av_name || ' А выд.', an_ed_position, 2, '', an_kc);
   END IF;
   IF an_q1_position != 0 THEN
    INSERT INTO meters
                (id, mid, name, position, entype, smart, kc)
         VALUES (points_seq.NEXTVAL, ln_mid, av_name || ' Р птр.', an_q1_position, 3, '', an_kc);
   END IF;
   IF an_q3_position != 0 THEN
    INSERT INTO meters
                (id, mid, name, position, entype, smart, kc)
         VALUES (points_seq.NEXTVAL, ln_mid, av_name || ' Р выд.', an_q3_position, 5, '', an_kc);
   END IF;
  END IF;
  IF util_pg.get_customer_id = 1 THEN
   ln_mid := editfeeders_pg.insgroup(ln_mid);
  END IF;
 EXCEPTION
  WHEN OTHERS THEN
   ROLLBACK TO SAVEPOINT editfeeders_ins;
   raise_application_error(-20001, 'editfeeders_pg.ins_p: Ошибка вставки присоединения. ' || CHR(10) || SQLERRM(
                                                                                                         SQLCODE));
 END;
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура обновления данных
 PROCEDURE upd_p(
  an_mid         NUMBER, --Ид точки
  an_parent      NUMBER, --Родитель
  an_type        NUMBER, --Тип точки
  av_name        VARCHAR2, --Название
  av_short_name  VARCHAR2, --Краткое название
  an_er_position NUMBER,
  an_q1_position NUMBER,
  an_ed_position NUMBER,
  an_q3_position NUMBER,
  an_smart       NUMBER, --Интеллектуал
  an_q1234       NUMBER, --Квадранты
  an_canal       NUMBER, --Номер канала
  av_cellnum     VARCHAR2, --Номер ячейки
  an_power       NUMBER, --Мощность
  an_current1    NUMBER, --Напряжение перв
  an_current2    NUMBER, --Напряжение вторич
  an_kc          NUMBER, --Коэфф
  an_tag         NUMBER, --Тег связи
  av_info        VARCHAR2, --Доп информация
  an_power2      NUMBER, --Мощность вторич кВ
  an_metkc       NUMBER, --Коэф прошитый в счетчике
  an_abc         NUMBER, --Заземленная нейтраль
  an_calcbill    NUMBER, --Верифицировать суточные
  an_calcmonths  NUMBER, --Верифицировать месячные
  an_inverted    NUMBER, --Инверсия
  an_switch      NUMBER --Признак обводника
                       ) IS
  ln_gid  NUMBER;
  ln_gid1 NUMBER;
 BEGIN
  SAVEPOINT editfeeders_upd;
  IF util_pg.get_customer_id = 1 THEN --ХЭС
   UPDATE points
      SET tag = an_tag
    WHERE mid = an_mid;
   UPDATE feeders
      SET er_position = an_er_position,
          q1_position = an_q1_position,
          ed_position = an_ed_position,
          q3_position = an_q3_position,
          vinfo = av_info,
          metkc = NVL(an_metkc, 1),
          nabc = NVL(an_abc, 0),
          ncalcbill = NVL(an_calcbill, 0),
          ncalcmonths = NVL(an_calcmonths, 0),
          ninverted = NVL(an_inverted, 0),
          nswitch = NVL(an_switch, 0)
    WHERE mid = an_mid;
  ELSE
   UPDATE points
      SET parent = an_parent,
          name = av_name,
          short_name = av_short_name,
          tag = an_tag
    WHERE mid = an_mid;
   UPDATE groups
      SET name = av_name,
          short_name = av_short_name
    WHERE mid = an_mid;
   UPDATE feeders
      SET er_position = an_er_position,
          q1_position = an_q1_position,
          ed_position = an_ed_position,
          q3_position = an_q3_position,
          smart = DECODE(an_smart, 1, '*', ''),
          q1234 = DECODE(an_q1234, 1, '*', ''),
          canal = an_canal,
          cellnum = av_cellnum,
          POWER = an_power,
          current1 = an_current1,
          current2 = an_current2,
          kc = an_kc,
          vinfo = av_info,
          power2 = an_power2,
          metkc = NVL(an_metkc, 1),
          nabc = NVL(an_abc, 0),
          ncalcbill = NVL(an_calcbill, 0),
          ncalcmonths = NVL(an_calcmonths, 0),
          ninverted = NVL(an_inverted, 0),
          nswitch = NVL(an_switch, 0)
    WHERE mid = an_mid;
   --last_input
   IF an_er_position != 0 THEN --Актив +
    UPDATE last_input
       SET name = av_name || ' А птр.',
           position = an_er_position,
           kc = an_kc
     WHERE mid = an_mid AND entype = 1;
    IF SQL%ROWCOUNT <= 0 THEN
     INSERT INTO last_input
                 (lid, mid, name, position, entype, kc)
          VALUES (points_seq.NEXTVAL, an_mid, av_name || ' А птр.', an_er_position, 1, an_kc);
    END IF;
   ELSE
    DELETE FROM last_input
          WHERE mid = an_mid AND entype = 1;
   END IF;
   IF an_ed_position != 0 THEN --Актив -
    UPDATE last_input
       SET name = av_name || ' А выд.',
           position = an_ed_position,
           kc = an_kc
     WHERE mid = an_mid AND entype = 2;
    IF SQL%ROWCOUNT <= 0 THEN
     INSERT INTO last_input
                 (lid, mid, name, position, entype, kc)
          VALUES (points_seq.NEXTVAL, an_mid, av_name || ' А выд.', an_ed_position, 2, an_kc);
    END IF;
   ELSE
    DELETE FROM last_input
          WHERE mid = an_mid AND entype = 2;
   END IF;
   IF an_q1_position != 0 THEN --Реактив +
    UPDATE last_input
       SET name = av_name || DECODE(an_q1234, 1, ' Q1', ' Р птр.'),
           position = an_q1_position,
           kc = an_kc
     WHERE mid = an_mid AND entype = 3;
    IF SQL%ROWCOUNT <= 0 THEN
     INSERT INTO last_input
                 (lid, mid, name, position, entype, kc)
          VALUES (points_seq.NEXTVAL, an_mid, av_name || DECODE(an_q1234, 1, ' Q1', ' Р птр.'), an_q1_position, 3, an_kc);
    END IF;
    IF an_q1234 = 1 THEN --Реактив + (квадранты)
     UPDATE last_input
        SET name = av_name || ' Q2',
            position = an_q1_position,
            kc = an_kc
      WHERE mid = an_mid AND entype = 4;
     IF SQL%ROWCOUNT <= 0 THEN
      INSERT INTO last_input
                  (lid, mid, name, position, entype, kc)
           VALUES (points_seq.NEXTVAL, an_mid, av_name || ' Q2', an_q1_position, 4, an_kc);
     END IF;
    ELSE
     DELETE FROM last_input
           WHERE mid = an_mid AND entype = 4;
    END IF;
   ELSE
    DELETE FROM last_input
          WHERE mid = an_mid AND entype IN (3, 4);
   END IF;
   IF an_q3_position != 0 THEN --Реактив -
    UPDATE last_input
       SET name = av_name || DECODE(an_q1234, 1, ' Q3', ' Р выд.'),
           position = an_q3_position,
           kc = an_kc
     WHERE mid = an_mid AND entype = 5;
    IF SQL%ROWCOUNT <= 0 THEN
     INSERT INTO last_input
                 (lid, mid, name, position, entype, kc)
          VALUES (points_seq.NEXTVAL, an_mid, av_name || DECODE(an_q1234, 1, ' Q3', ' Р выд.'), an_q3_position, 5, an_kc);
    END IF;
    IF an_q1234 = 1 THEN --Реактив - (квадранты)
     UPDATE last_input
        SET name = av_name || ' Q4',
            position = an_q3_position,
            kc = an_kc
      WHERE mid = an_mid AND entype = 6;
     IF SQL%ROWCOUNT <= 0 THEN
      INSERT INTO last_input
                  (lid, mid, name, position, entype, kc)
           VALUES (points_seq.NEXTVAL, an_mid, av_name || ' Q4', an_q3_position, 6, an_kc);
     END IF;
    ELSE
     DELETE FROM last_input
           WHERE mid = an_mid AND entype = 6;
    END IF;
   ELSE
    DELETE FROM last_input
          WHERE mid = an_mid AND entype IN (5, 6);
   END IF;
   --meters
   IF an_smart = 1 THEN
    DELETE FROM meters
          WHERE mid = an_mid AND entype BETWEEN 1 AND 6;
    UPDATE meters
       SET name = av_name || ' Инт.',
           position = an_er_position,
           kc = an_kc
     WHERE mid = an_mid AND entype = 7;
    IF SQL%ROWCOUNT <= 0 THEN
     INSERT INTO meters
                 (id, mid, name, position, entype, smart, kc)
          VALUES (points_seq.NEXTVAL, an_mid, av_name || ' Инт.', an_er_position, 7, '*', an_kc);
    END IF;
   ELSE
    DELETE FROM meters
          WHERE mid = an_mid AND entype = 7;
    IF an_er_position != 0 THEN
     UPDATE meters
        SET name = av_name || ' А птр.',
            position = an_er_position,
            kc = an_kc
      WHERE mid = an_mid AND entype = 1;
     IF SQL%ROWCOUNT <= 0 THEN
      INSERT INTO meters
                  (id, mid, name, position, entype, smart, kc)
           VALUES (points_seq.NEXTVAL, an_mid, av_name || ' А птр.', an_er_position, 1, '', an_kc);
     END IF;
    ELSE
     DELETE FROM meters
           WHERE mid = an_mid AND entype = 1;
    END IF;
    IF an_ed_position != 0 THEN
     UPDATE meters
        SET name = av_name || ' А выд.',
            position = an_ed_position,
            kc = an_kc
      WHERE mid = an_mid AND entype = 2;
     IF SQL%ROWCOUNT <= 0 THEN
      INSERT INTO meters
                  (id, mid, name, position, entype, smart, kc)
           VALUES (points_seq.NEXTVAL, an_mid, av_name || ' А выд.', an_ed_position, 2, '', an_kc);
     END IF;
    ELSE
     DELETE FROM meters
           WHERE mid = an_mid AND entype = 2;
    END IF;
    IF an_q1_position != 0 THEN
     UPDATE meters
        SET name = av_name || ' Р птр.',
            position = an_q1_position,
            kc = an_kc
      WHERE mid = an_mid AND entype = 3;
     IF SQL%ROWCOUNT <= 0 THEN
      INSERT INTO meters
                  (id, mid, name, position, entype, smart, kc)
           VALUES (points_seq.NEXTVAL, an_mid, av_name || ' Р птр.', an_q1_position, 3, '', an_kc);
     END IF;
    ELSE
     DELETE FROM meters
           WHERE mid = an_mid AND entype = 3;
    END IF;
    IF an_q3_position != 0 THEN
     UPDATE meters
        SET name = av_name || ' Р выд.',
            position = an_q3_position,
            kc = an_kc
      WHERE mid = an_mid AND entype = 5;
     IF SQL%ROWCOUNT <= 0 THEN
      INSERT INTO meters
                  (id, mid, name, position, entype, smart, kc)
           VALUES (points_seq.NEXTVAL, an_mid, av_name || ' Р выд.', an_q3_position, 5, '', an_kc);
     END IF;
    ELSE
     DELETE FROM meters
           WHERE mid = an_mid AND entype = 5;
    END IF;
   END IF;
  END IF;
  IF util_pg.get_customer_id = 1 THEN
   ln_gid := editfeeders_pg.insgroup(an_parent);
   ln_gid1 := editfeeders_pg.insgroup(an_mid);
   UPDATE groups
      SET name = av_name,
          parent = ln_gid
    WHERE nroot1 = 1 AND nroot2 = an_mid;
  END IF;
 EXCEPTION
  WHEN OTHERS THEN
   ROLLBACK TO SAVEPOINT editfeeders_upd;
   raise_application_error(
    -20001, 'editfeeders_pg.upd_p: Ошибка обновления присоединения. ' || CHR(10) || SQLERRM(SQLCODE));
 END;
 ------------------------------------------------------------------------------------------------------------------------
 FUNCTION insgroup(an_mid NUMBER)
  RETURN NUMBER IS
  ln_gid    NUMBER;
  ln_parent NUMBER;
  lv_name   VARCHAR2(256);
  ln_mid    NUMBER;
 BEGIN
  IF util_pg.get_customer_id = 1 THEN
   RETURN NULL;
  END IF;
  SELECT MAX(gid)
    INTO ln_gid
    FROM groups
   WHERE nroot1 = 1 AND nroot2 = an_mid;
  IF ln_gid > 0 THEN
   RETURN ln_gid;
  END IF;
  SELECT parent, name, DECODE(ind, 3, mid, NULL)
    INTO ln_parent, lv_name, ln_mid
    FROM points p
   WHERE mid = an_mid;
  IF ln_parent IS NOT NULL THEN
   SELECT MAX(gid)
     INTO ln_gid
     FROM groups
    WHERE nroot1 = 1 AND nroot2 = ln_parent;
   IF ln_gid IS NULL THEN
    ln_gid := insgroup(ln_parent);
   END IF;
  END IF;
  IF ln_parent IS NULL THEN
   SELECT MAX(gid)
     INTO ln_gid
     FROM groups
    WHERE parent IS NULL AND name = 'Точки АСРПП';
   IF ln_gid IS NULL THEN
    RETURN -1;
   END IF;
  ELSE
   SELECT MAX(gid)
     INTO ln_gid
     FROM groups
    WHERE nroot1 = 1 AND nroot2 = ln_parent;
  END IF;
  editgroups_pg.ins_p_a(ln_gid, lv_name, NULL, ln_mid, 0, 1, an_mid, NULL, NULL, ln_gid);
  RETURN ln_gid;
 END;
 ------------------------------------------------------------------------------------------------------------------------
    -- Процедура вставки АСКУЭ
 PROCEDURE ins_p_a(
  an_parent          NUMBER, --Родитель
  an_type            NUMBER, --Тип точки
  av_name            VARCHAR2, --Название
  av_short_name      VARCHAR2, --Краткое название
  an_er_position     NUMBER,
  an_q1_position     NUMBER,
  an_ed_position     NUMBER,
  an_q3_position     NUMBER,
  an_smart           NUMBER, --Интеллектуал
  an_q1234           NUMBER, --Квадранты
  av_cellnum         VARCHAR2, --Номер ячейки
  an_power           NUMBER, --Мощность
  an_current1        NUMBER, --Напряжение перв
  an_current2        NUMBER, --Напряжение вторич
  an_kc              NUMBER, --Коэфф
  an_point           NUMBER, --Ид точки АСРПП
  an_power2          NUMBER, --Мощность вторич кВ
  an_mid         OUT NUMBER --Ид точки
                           ) IS
  ln_mid NUMBER;
 BEGIN
  SELECT points_seq.NEXTVAL
    INTO ln_mid
    FROM DUAL;
  an_mid := ln_mid;
  INSERT INTO points
              (mid, parent, cod, ind, name, short_name, calc_count, ovv_count, ptype, implement_date, min30, min3, tag,
               npoint)
       VALUES (ln_mid, an_parent, 0, an_type, av_name, av_short_name, 0, 0, 1, SYSDATE, 0, 0, NULL,
               an_point);
  INSERT INTO feeders
              (mid, er_position, q1_position, ed_position, q3_position, smart,
               q1234, canal, cellnum, POWER, current1, current2, kc, line_loss, act_loss, react_loss, vinfo,
               power2, metkc, nabc, ncalcbill, ncalcmonths)
       VALUES (ln_mid, an_er_position, an_q1_position, an_ed_position, an_q3_position, DECODE(an_smart, 1, '*', ''),
               DECODE(an_q1234, 1, '*', ''), NULL, av_cellnum, an_power, an_current1, an_current2, an_kc, 0, 0, 0, NULL,
               an_power2, 1, 0, 0, 0);
  INSERT INTO curr_power
              (mid, obsolete)
       VALUES (ln_mid, 1);
  --last_input
  IF an_er_position != 0 THEN
   INSERT INTO last_input
               (lid, mid, name, position, entype, kc)
        VALUES (points_seq.NEXTVAL, ln_mid, av_name || ' А птр.', an_er_position, 1, an_kc);
  END IF;
  IF an_ed_position != 0 THEN
   INSERT INTO last_input
               (lid, mid, name, position, entype, kc)
        VALUES (points_seq.NEXTVAL, ln_mid, av_name || ' А выд.', an_ed_position, 2, an_kc);
  END IF;
  IF an_q1_position != 0 THEN
   INSERT INTO last_input
               (lid, mid, name, position, entype, kc)
        VALUES (points_seq.NEXTVAL, ln_mid, av_name || DECODE(an_q1234, 1, ' Q1', ' Р птр.'), an_q1_position, 3, an_kc);
   IF an_q1234 = 1 THEN
    INSERT INTO last_input
                (lid, mid, name, position, entype, kc)
         VALUES (points_seq.NEXTVAL, ln_mid, av_name || ' Q2', an_q1_position, 4, an_kc);
   END IF;
  END IF;
  IF an_q3_position != 0 THEN
   INSERT INTO last_input
               (lid, mid, name, position, entype, kc)
        VALUES (points_seq.NEXTVAL, ln_mid, av_name || DECODE(an_q1234, 1, ' Q3', ' Р выд.'), an_q3_position, 5, an_kc);
   IF an_q1234 = 1 THEN
    INSERT INTO last_input
                (lid, mid, name, position, entype, kc)
         VALUES (points_seq.NEXTVAL, ln_mid, av_name || ' Q4', an_q3_position, 6, an_kc);
   END IF;
  END IF;
  --meters
  IF an_smart = 1 THEN
   INSERT INTO meters
               (id, mid, name, position, entype, smart, kc)
        VALUES (points_seq.NEXTVAL, ln_mid, av_name || ' Инт.', an_er_position, 7, '*', an_kc);
  ELSE
   IF an_er_position != 0 THEN
    INSERT INTO meters
                (id, mid, name, position, entype, smart, kc)
         VALUES (points_seq.NEXTVAL, ln_mid, av_name || ' А птр.', an_er_position, 1, '', an_kc);
   END IF;
   IF an_ed_position != 0 THEN
    INSERT INTO meters
                (id, mid, name, position, entype, smart, kc)
         VALUES (points_seq.NEXTVAL, ln_mid, av_name || ' А выд.', an_ed_position, 2, '', an_kc);
   END IF;
   IF an_q1_position != 0 THEN
    INSERT INTO meters
                (id, mid, name, position, entype, smart, kc)
         VALUES (points_seq.NEXTVAL, ln_mid, av_name || ' Р птр.', an_q1_position, 3, '', an_kc);
   END IF;
   IF an_q3_position != 0 THEN
    INSERT INTO meters
                (id, mid, name, position, entype, smart, kc)
         VALUES (points_seq.NEXTVAL, ln_mid, av_name || ' Р выд.', an_q3_position, 5, '', an_kc);
   END IF;
  END IF;
  IF util_pg.get_customer_id = 1 THEN
   ln_mid := insgroup(ln_mid);
  END IF;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'editfeeders_pg.ins_p: Ошибка вставки присоединения. ' || CHR(10) || SQLERRM(
                                                                                                         SQLCODE));
 END;
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура обновления данных АСКУЭ
 PROCEDURE upd_p_a(
  an_mid         NUMBER, --Ид точки
  an_parent      NUMBER, --Родитель
  an_type        NUMBER, --Тип точки
  av_name        VARCHAR2, --Название
  av_short_name  VARCHAR2, --Краткое название
  an_er_position NUMBER,
  an_q1_position NUMBER,
  an_ed_position NUMBER,
  an_q3_position NUMBER,
  an_smart       NUMBER, --Интеллектуал
  an_q1234       NUMBER, --Квадранты
  av_cellnum     VARCHAR2, --Номер ячейки
  an_power       NUMBER, --Мощность
  an_current1    NUMBER, --Напряжение перв
  an_current2    NUMBER, --Напряжение вторич
  an_kc          NUMBER, --Коэфф
  an_power2      NUMBER --Мощность вторич кВ
                       --  an_metkc       NUMBER --Коэф прошитый в счетчике
                       ) IS
  ln_gid  NUMBER;
  ln_gid1 NUMBER;
 BEGIN
  UPDATE points
     SET parent = an_parent,
         name = av_name,
         short_name = av_short_name
   WHERE mid = an_mid;
  UPDATE groups
     SET name = av_name,
         short_name = av_short_name
   WHERE mid = an_mid;
  UPDATE feeders
     SET smart = DECODE(an_smart, 1, '*', ''),
         q1234 = DECODE(an_q1234, 1, '*', ''),
         cellnum = av_cellnum,
         POWER = an_power,
         current1 = an_current1,
         current2 = an_current2,
         kc = an_kc,
         power2 = an_power2
   WHERE mid = an_mid;
  --last_input
  IF an_er_position != 0 THEN --Актив +
   UPDATE last_input
      SET name = av_name || ' А птр.',
          position = an_er_position,
          kc = an_kc
    WHERE mid = an_mid AND entype = 1;
   IF SQL%ROWCOUNT <= 0 THEN
    INSERT INTO last_input
                (lid, mid, name, position, entype, kc)
         VALUES (points_seq.NEXTVAL, an_mid, av_name || ' А птр.', an_er_position, 1, an_kc);
   END IF;
  ELSE
   DELETE FROM last_input
         WHERE mid = an_mid AND entype = 1;
  END IF;
  IF an_ed_position != 0 THEN --Актив -
   UPDATE last_input
      SET name = av_name || ' А выд.',
          position = an_ed_position,
          kc = an_kc
    WHERE mid = an_mid AND entype = 2;
   IF SQL%ROWCOUNT <= 0 THEN
    INSERT INTO last_input
                (lid, mid, name, position, entype, kc)
         VALUES (points_seq.NEXTVAL, an_mid, av_name || ' А выд.', an_ed_position, 2, an_kc);
   END IF;
  ELSE
   DELETE FROM last_input
         WHERE mid = an_mid AND entype = 2;
  END IF;
  IF an_q1_position != 0 THEN --Реактив +
   UPDATE last_input
      SET name = av_name || DECODE(an_q1234, 1, ' Q1', ' Р птр.'),
          position = an_q1_position,
          kc = an_kc
    WHERE mid = an_mid AND entype = 3;
   IF SQL%ROWCOUNT <= 0 THEN
    INSERT INTO last_input
                (lid, mid, name, position, entype, kc)
         VALUES (points_seq.NEXTVAL, an_mid, av_name || DECODE(an_q1234, 1, ' Q1', ' Р птр.'), an_q1_position, 3, an_kc);
   END IF;
   IF an_q1234 = 1 THEN --Реактив + (квадранты)
    UPDATE last_input
       SET name = av_name || ' Q2',
           position = an_q1_position,
           kc = an_kc
     WHERE mid = an_mid AND entype = 4;
    IF SQL%ROWCOUNT <= 0 THEN
     INSERT INTO last_input
                 (lid, mid, name, position, entype, kc)
          VALUES (points_seq.NEXTVAL, an_mid, av_name || ' Q2', an_q1_position, 4, an_kc);
    END IF;
   ELSE
    DELETE FROM last_input
          WHERE mid = an_mid AND entype = 4;
   END IF;
  ELSE
   DELETE FROM last_input
         WHERE mid = an_mid AND entype IN (3, 4);
  END IF;
  IF an_q3_position != 0 THEN --Реактив -
   UPDATE last_input
      SET name = av_name || DECODE(an_q1234, 1, ' Q3', ' Р выд.'),
          position = an_q3_position,
          kc = an_kc
    WHERE mid = an_mid AND entype = 5;
   IF SQL%ROWCOUNT <= 0 THEN
    INSERT INTO last_input
                (lid, mid, name, position, entype, kc)
         VALUES (points_seq.NEXTVAL, an_mid, av_name || DECODE(an_q1234, 1, ' Q3', ' Р выд.'), an_q3_position, 5, an_kc);
   END IF;
   IF an_q1234 = 1 THEN --Реактив - (квадранты)
    UPDATE last_input
       SET name = av_name || ' Q4',
           position = an_q3_position,
           kc = an_kc
     WHERE mid = an_mid AND entype = 6;
    IF SQL%ROWCOUNT <= 0 THEN
     INSERT INTO last_input
                 (lid, mid, name, position, entype, kc)
          VALUES (points_seq.NEXTVAL, an_mid, av_name || ' Q4', an_q3_position, 6, an_kc);
    END IF;
   ELSE
    DELETE FROM last_input
          WHERE mid = an_mid AND entype = 6;
   END IF;
  ELSE
   DELETE FROM last_input
         WHERE mid = an_mid AND entype IN (5, 6);
  END IF;
  --meters
  IF an_smart = 1 THEN
   DELETE FROM meters
         WHERE mid = an_mid AND entype BETWEEN 1 AND 6;
   UPDATE meters
      SET name = av_name || ' Инт.',
          position = an_er_position,
          kc = an_kc
    WHERE mid = an_mid AND entype = 7;
   IF SQL%ROWCOUNT <= 0 THEN
    INSERT INTO meters
                (id, mid, name, position, entype, smart, kc)
         VALUES (points_seq.NEXTVAL, an_mid, av_name || ' Инт.', an_er_position, 7, '*', an_kc);
   END IF;
  ELSE
   DELETE FROM meters
         WHERE mid = an_mid AND entype = 7;
   IF an_er_position != 0 THEN
    UPDATE meters
       SET name = av_name || ' А птр.',
           position = an_er_position,
           kc = an_kc
     WHERE mid = an_mid AND entype = 1;
    IF SQL%ROWCOUNT <= 0 THEN
     INSERT INTO meters
                 (id, mid, name, position, entype, smart, kc)
          VALUES (points_seq.NEXTVAL, an_mid, av_name || ' А птр.', an_er_position, 1, '', an_kc);
    END IF;
   ELSE
    DELETE FROM meters
          WHERE mid = an_mid AND entype = 1;
   END IF;
   IF an_ed_position != 0 THEN
    UPDATE meters
       SET name = av_name || ' А выд.',
           position = an_ed_position,
           kc = an_kc
     WHERE mid = an_mid AND entype = 2;
    IF SQL%ROWCOUNT <= 0 THEN
     INSERT INTO meters
                 (id, mid, name, position, entype, smart, kc)
          VALUES (points_seq.NEXTVAL, an_mid, av_name || ' А выд.', an_ed_position, 2, '', an_kc);
    END IF;
   ELSE
    DELETE FROM meters
          WHERE mid = an_mid AND entype = 2;
   END IF;
   IF an_q1_position != 0 THEN
    UPDATE meters
       SET name = av_name || ' Р птр.',
           position = an_q1_position,
           kc = an_kc
     WHERE mid = an_mid AND entype = 3;
    IF SQL%ROWCOUNT <= 0 THEN
     INSERT INTO meters
                 (id, mid, name, position, entype, smart, kc)
          VALUES (points_seq.NEXTVAL, an_mid, av_name || ' Р птр.', an_q1_position, 3, '', an_kc);
    END IF;
   ELSE
    DELETE FROM meters
          WHERE mid = an_mid AND entype = 3;
   END IF;
   IF an_q3_position != 0 THEN
    UPDATE meters
       SET name = av_name || ' Р выд.',
           position = an_q3_position,
           kc = an_kc
     WHERE mid = an_mid AND entype = 5;
    IF SQL%ROWCOUNT <= 0 THEN
     INSERT INTO meters
                 (id, mid, name, position, entype, smart, kc)
          VALUES (points_seq.NEXTVAL, an_mid, av_name || ' Р выд.', an_q3_position, 5, '', an_kc);
    END IF;
   ELSE
    DELETE FROM meters
          WHERE mid = an_mid AND entype = 5;
   END IF;
  END IF;
  IF util_pg.get_customer_id = 1 THEN
   ln_gid := insgroup(an_parent);
   ln_gid1 := insgroup(an_mid);
   UPDATE groups
      SET name = av_name,
          parent = ln_gid
    WHERE nroot1 = 1 AND nroot2 = an_mid;
  END IF;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(
    -20001, 'editfeeders_pg.upd_p: Ошибка обновления присоединения. ' || CHR(10) || SQLERRM(SQLCODE));
 END;
 ------------------------------------------------------------------------------------------------------------------------
  -- Процедура удаления данных
 PROCEDURE del_p(an_mid NUMBER --Ид точки
                              ) IS
 BEGIN
  DELETE FROM points
        WHERE mid = an_mid;
  DELETE FROM groups
        WHERE nroot1 = 1 AND nroot2 = an_mid;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'editfeeders_pg.del_p: Ошибка удаления присоединения. ' || CHR(10) || SQLERRM(
                                                                                                          SQLCODE));
 END;
 ------------------------------------------------------------------------------------------------------------------------
 --Процедура обновления счетчика АСКУЭ
 PROCEDURE upd_meters_a(
  an_mid       NUMBER, --Ид точки
  an_entype    NUMBER, --ENTYPE
  av_smart     VARCHAR2, --SMART
  av_mtrsn     VARCHAR2, --MTRSN
  ad_date_time DATE, --DATE_TIME
  an_digits    NUMBER, --DIGITS
  av_mtype     VARCHAR2, --MTYPE
  an_mcurrent  NUMBER, --MCURRENT
  an_mpower    NUMBER, --MPOWER
  an_mconst    NUMBER, --MCONST
  an_mclass    NUMBER, --MCLASS
  an_myear     NUMBER, --MYEAR
  an_mquarter  NUMBER --MQUARTER
                     ) IS
 BEGIN
  UPDATE ryda.meters
     SET date_time = ad_date_time,
         mtrsn = av_mtrsn,
         digits = an_digits,
         mtype = av_mtype,
         mcurrent = an_mcurrent,
         mpower = an_mpower,
         myear = an_myear,
         mquarter = an_mquarter,
         mconst = an_mconst,
         mclass = an_mclass
   WHERE mid = an_mid AND entype = an_entype;
  IF av_smart = '*' THEN
   UPDATE ryda.last_input
      SET mtrsn = av_mtrsn,
          digits = an_digits
    WHERE mid = an_mid;
  ELSE
   UPDATE ryda.last_input
      SET mtrsn = av_mtrsn,
          digits = an_digits
    WHERE mid = an_mid AND entype = an_entype;
  END IF;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(
    -20001, 'editfeeders_pg.upd_meters: Ошибка обновления счетчика. ' || CHR(10) || SQLERRM(SQLCODE));
 END;
 ------------------------------------------------------------------------------------------------------------------------
 --Устанавливает параметры простых потерь
 PROCEDURE setpoterinfo(
  an_mid              NUMBER, --Ид точки
  an_wastepercentcalc NUMBER, --Тип потерь
  an_workinghours     NUMBER, --Часы работы
  an_fullhours        NUMBER, --Полные часы работы
  an_line_loss         NUMBER, --Портери в линии
  an_act_loss          NUMBER, --Потери акт транс
  an_react_loss        NUMBER --Потери реакт транс
                            ) IS
 BEGIN
  UPDATE feeders
     SET nwastepercentcalc = an_wastepercentcalc,
         nworkinghours = an_workinghours,
         nfullhours = an_fullhours,
         line_loss = an_line_loss,
         act_loss = an_act_loss,
         react_loss = an_react_loss
   WHERE mid = an_mid;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(
    -20001, 'editfeeders_pg.setpoterinfo: Ошибка обновления параметров потерь. ' || CHR(10) || SQLERRM(SQLCODE));
 END;
------------------------------------------------------------------------------------------------------------------------
END; -- Package Body
/

-- End of DDL script for EDITFEEDERS_PG

-- Start of DDL script for EDITFORMS_PG
-- Generated 27-янв-03  11:34:01 am
-- from oe-RYDA:1

-- Package body EDITFORMS_PG

CREATE OR REPLACE
PACKAGE BODY editforms_pg
IS
  -- пакет работы с группами
  -- дата создания 29/10/2001 (Сечин А.А.)
------------------------------------------------------------------------------------------------------------------------
  -- Процедура вставки
 PROCEDURE ins_p(
  an_parent             NUMBER, --
  an_monitor            NUMBER, --
  an_codetemplate       NUMBER, --
  av_nameform           VARCHAR2, --
  av_commentform        VARCHAR2, --
  av_enablecontrols     VARCHAR2, --
  an_stepprofile        NUMBER, --
  av_namealert          VARCHAR2, --
  av_procname        VARCHAR2, --
  at_gid                COMMON_PG.tt_number, --
  an_fid            OUT NUMBER --
                              )
 IS
  ln_fid NUMBER;
 BEGIN
  SAVEPOINT editforms_ins;
  SELECT forms_seq.NEXTVAL
    INTO ln_fid
    FROM DUAL;
  an_fid := ln_fid;
  INSERT INTO forms
              (fid, parent, monitor, codetemplate, nameform, commentform, enablecontrols, stepprofile, namealert,vprocname)
       VALUES (ln_fid, an_parent, an_monitor, an_codetemplate, av_nameform, av_commentform, av_enablecontrols, an_stepprofile, av_namealert,av_procname);
  FOR i IN 1 .. at_gid.count LOOP
   INSERT INTO form_group
               (fid, gid)
        VALUES (ln_fid, at_gid(i));
  END LOOP;
 EXCEPTION
  WHEN OTHERS THEN
   ROLLBACK TO SAVEPOINT editforms_ins;
   raise_application_error(-20001, 'editforms_pg.ins_p: Ошибка вставки формы монитора. ' || CHR(10) || SQLERRM(SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
  -- Процедура обновления данных
 PROCEDURE upd_p(
  an_fid            NUMBER, --
  an_parent         NUMBER, --
  an_monitor        NUMBER, --
  an_codetemplate   NUMBER, --
  av_nameform       VARCHAR2, --
  av_commentform    VARCHAR2, --
  av_enablecontrols VARCHAR2, --
  an_stepprofile    NUMBER, --
  av_namealert      VARCHAR2, --
  av_procname        VARCHAR2, --
  at_gid            COMMON_PG.tt_number --
                             )
 IS
 BEGIN
  SAVEPOINT editforms_upd;
  UPDATE forms
     SET parent = an_parent,
         monitor = an_monitor,
         codetemplate = an_codetemplate,
         nameform = av_nameform,
         commentform = av_commentform,
         enablecontrols = av_enablecontrols,
         stepprofile = an_stepprofile,
         namealert = av_namealert,
         vprocname=av_procname
   WHERE fid = an_fid;
  DELETE FROM form_group
        WHERE fid = an_fid;
  FOR i IN 1 .. at_gid.count LOOP
   INSERT INTO form_group
               (fid, gid)
        VALUES (an_fid, at_gid(i));
  END LOOP;
 EXCEPTION
  WHEN OTHERS THEN
   ROLLBACK TO SAVEPOINT editforms_upd;
   raise_application_error(-20001, 'editforms_pg.upd_p: Ошибка обновления формы монитора. ' || CHR(10) || SQLERRM(SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
  -- Процедура удаления данных
 PROCEDURE del_p(
  an_fid NUMBER --
               )
 IS
 BEGIN
  DELETE FROM forms
        WHERE fid = an_fid;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'editforms_pg.del_p: Ошибка удаления формы монитора. ' || CHR(10) || SQLERRM(SQLCODE));
 END;
------------------------------------------------------------------------------------------------------------------------
END; -- Package Body
/

-- End of DDL script for EDITFORMS_PG

-- Start of DDL script for EDITGROUPS_PG
-- Generated 27-янв-03  11:34:01 am
-- from oe-RYDA:1

-- Package body EDITGROUPS_PG

CREATE OR REPLACE
PACKAGE BODY editgroups_pg IS
   -- пакет работы с группами
   -- дата создания 29/10/2001 (Сечин А.А.)
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура вставки (общая)
 PROCEDURE ins_p_all(
  an_askue                 NUMBER, --1-изменения из АСКУЭ, иначе из АСРПП
  an_parent                NUMBER, --Родитель
  av_name                  VARCHAR2, --Название
  av_short_name            VARCHAR2, --Краткое название
  an_mid                   NUMBER, --Ид точки
  an_limit_id              NUMBER, --Ид лимита
  an_inverted              NUMBER, --Признак инвертирования
  an_group_total           NUMBER, --Признак суммирования по группе
  an_root1                NUMBER, --Ид группы прома
  an_root2                NUMBER, --Ид группы прома
  an_emergencyreserve      NUMBER, --Аварийная бронь
  an_technologyreserve     NUMBER, --Технологическая бронь
  an_gid               OUT NUMBER --Ид группы
                                 ) IS
  ln_gid NUMBER;
 BEGIN
  SELECT groups_seq.NEXTVAL
    INTO ln_gid
    FROM DUAL;
  an_gid := ln_gid;
  INSERT INTO groups
              (gid, parent, name, short_name, mid, limit_id,
               inverted,
               group_total, nroot1,nroot2,
               nemergencyreserve, ntechnologyreserve)
       VALUES (ln_gid, an_parent, av_name, av_short_name, an_mid, an_limit_id,
               DECODE(an_mid, NULL, 'n', DECODE(an_inverted, 1, 'y', 'n')),
               DECODE(ABS(SIGN(an_mid)), 1, 'n', DECODE(an_askue, 1, DECODE(an_group_total, 1, 'y', 'n'), 'y')), an_root1,an_root2,
               an_emergencyreserve, an_technologyreserve);
/*  IF an_parent IS NULL THEN
   INSERT INTO form_group
               (gid, fid)
    (SELECT ln_gid, fid
       FROM forms
      WHERE codetemplate <> 0);
  END IF;*/
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'editgroups_pg.ins_p: Ошибка вставки группы учета. ' || CHR(10) || SQLERRM(SQLCODE));
 END;
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура обновления данных (общая)
 PROCEDURE upd_p_all(
  an_askue             NUMBER, --1-изменения из АСКУЭ, иначе из АСРПП
  an_gid               NUMBER, --Ид группы
  an_parent            NUMBER, --Родитель
  av_name              VARCHAR2, --Название
  av_short_name        VARCHAR2, --Краткое название
  an_limit_id          NUMBER, --Ид лимита
  an_inverted          NUMBER, --Признак инвертирования
  an_group_total       NUMBER, --Признак суммирования по группе
  an_emergencyreserve  NUMBER, --Аварийная бронь
  an_technologyreserve NUMBER --Технологическая бронь
                             ) IS
 BEGIN
  IF util_pg.get_customer_id = 1 AND an_askue=1 THEN --ХЭС
   UPDATE groups
     SET group_total =
                     DECODE(ABS(SIGN(mid)), 1, 'n', DECODE(an_askue, 1, DECODE(an_group_total, 1, 'y', 'n'),
                                                                                                           group_total))
   WHERE gid = an_gid;
  ELSE
   UPDATE groups
     SET parent = an_parent,
         name = av_name,
         short_name = av_short_name,
         limit_id = DECODE(an_askue, 1, an_limit_id, limit_id),
         inverted = DECODE(mid, NULL, 'n', DECODE(an_inverted, 1, 'y', 'n')),
         group_total =
                     DECODE(ABS(SIGN(mid)), 1, 'n', DECODE(an_askue, 1, DECODE(an_group_total, 1, 'y', 'n'),
                                                                                                           group_total)),
         nemergencyreserve = DECODE(an_askue, 1, an_emergencyreserve,nemergencyreserve),
         ntechnologyreserve = DECODE(an_askue, 1, an_technologyreserve,ntechnologyreserve)
   WHERE gid = an_gid;
  END IF;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'editgroups_pg.upd_p: Ошибка обновления группы учета. ' || CHR(10) || SQLERRM(
                                                                                                          SQLCODE));
 END;
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура вставки
 PROCEDURE ins_p(
  an_parent                NUMBER, --Родитель
  av_name                  VARCHAR2, --Название
  av_short_name            VARCHAR2, --Краткое название
  an_mid                   NUMBER, --Ид точки
  an_limit_id              NUMBER, --Ид лимита
  an_inverted              NUMBER, --Признак инвертирования
  an_group_total           NUMBER, --Признак суммирования по группе
  an_emergencyreserve      NUMBER, --Аварийная бронь
  an_technologyreserve     NUMBER, --Технологическая бронь
  an_gid               OUT NUMBER --Ид группы
                                 ) IS
 BEGIN
  SAVEPOINT editgroups_ins;
  ins_p_all(
   1, an_parent, av_name, av_short_name, an_mid, an_limit_id, an_inverted, an_group_total, NULL, NULL, an_emergencyreserve,
   an_technologyreserve, an_gid);
 EXCEPTION
  WHEN OTHERS THEN
   ROLLBACK TO SAVEPOINT editgroups_ins;
   RAISE;
 END;
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура обновления данных
 PROCEDURE upd_p(
  an_gid               NUMBER, --Ид группы
  an_parent            NUMBER, --Родитель
  av_name              VARCHAR2, --Название
  av_short_name        VARCHAR2, --Краткое название
  an_mid               NUMBER, --Ид точки
  an_limit_id          NUMBER, --Ид лимита
  an_inverted          NUMBER, --Признак инвертирования
  an_group_total       NUMBER, --Признак суммирования по группе
  an_emergencyreserve  NUMBER, --Аварийная бронь
  an_technologyreserve NUMBER --Технологическая бронь
                             ) IS
 BEGIN
  SAVEPOINT editgroups_upd;
  upd_p_all(
   1, an_gid, an_parent, av_name, av_short_name, an_limit_id, an_inverted, an_group_total, an_emergencyreserve,
   an_technologyreserve);
 EXCEPTION
  WHEN OTHERS THEN
   ROLLBACK TO SAVEPOINT editgroups_upd;
   RAISE;
 END;
 ------------------------------------------------------------------------------------------------------------------------
    -- Процедура вставки АСРПП
 PROCEDURE ins_p_a(
  an_parent                NUMBER, --Родитель
  av_name                  VARCHAR2, --Название
  av_short_name            VARCHAR2, --Краткое название
  an_mid                   NUMBER, --Ид точки
  an_inverted              NUMBER, --Признак инвертирования
  an_root1                NUMBER, --Ид группы прома
  an_root2                NUMBER, --Ид группы прома
  an_emergencyreserve      NUMBER, --Аварийная бронь
  an_technologyreserve     NUMBER, --Технологическая бронь
  an_gid               OUT NUMBER --Ид группы
                                 ) IS
 BEGIN
  ins_p_all(
   0, an_parent, av_name, av_short_name, an_mid, NULL, an_inverted, NULL, an_root1,an_root2, an_emergencyreserve,
   an_technologyreserve, an_gid);
 END;
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура обновления данных АСРПП
 PROCEDURE upd_p_a(
  an_gid               NUMBER, --Ид группы
  an_parent            NUMBER, --Родитель
  av_name              VARCHAR2, --Название
  av_short_name        VARCHAR2, --Краткое название
  an_inverted          NUMBER, --Признак инвертирования
  an_emergencyreserve  NUMBER, --Аварийная бронь
  an_technologyreserve NUMBER --Технологическая бронь
                             ) IS
 BEGIN
  upd_p_all(
   0, an_gid, an_parent, av_name, av_short_name, NULL, an_inverted, NULL, an_emergencyreserve, an_technologyreserve);
 END;
 ------------------------------------------------------------------------------------------------------------------------
  -- Процедура удаления данных
 PROCEDURE del_p(an_gid NUMBER --Ид группы
                              ) IS
 BEGIN
  DELETE FROM groups
        WHERE gid = an_gid;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'editgroups_pg.del_p: Ошибка удаления группы учета. ' || CHR(10) || SQLERRM(SQLCODE));
 END;
 ------------------------------------------------------------------------------------------------------------------------
    -- Процедура изменения лимитов по группе
 PROCEDURE updlimit_p(
  an_gid       NUMBER, --Ид группы
  at_start     COMMON_PG.tt_varchar2, --Дата ввода в действие
  at_limitcons COMMON_PG.tt_number, --Потребление
  at_limitcapm COMMON_PG.tt_number, --Нагрузка утро
  at_limitcape COMMON_PG.tt_number --Нагрузка вечер
                        ) IS
 BEGIN
  SAVEPOINT editgroups_updlimit;
  DELETE FROM grouplimit
        WHERE gid = an_gid;
  FOR i IN 1 .. at_start.COUNT LOOP
   INSERT INTO grouplimit
               (gid, dstart, nlimitcons, nlimitcapm, nlimitcape)
        VALUES (an_gid, to_date(at_start(i),'dd.mm.yyyy'), at_limitcons(i), at_limitcapm(i), at_limitcape(i));
  END LOOP;
 EXCEPTION
  WHEN OTHERS THEN
   ROLLBACK TO SAVEPOINT editgroups_updlimit;
   RAISE;
 END;
------------------------------------------------------------------------------------------------------------------------
END; -- Package Body
/

-- End of DDL script for EDITGROUPS_PG

-- Start of DDL script for EDITMANUAL_PG
-- Generated 27-янв-03  11:34:01 am
-- from oe-RYDA:1

-- Package body EDITMANUAL_PG

CREATE OR REPLACE
PACKAGE BODY editmanual_pg
IS
  -- пакет работы с ручниками
  -- дата создания 25/12/2001 (Сечин А.А.)
------------------------------------------------------------------------------------------------------------------------
  -- Процедура редактирования значений
 PROCEDURE updvalue_p(
  an_mid  NUMBER, --Ид точки
  an_curr NUMBER, --тек значение
  ad_next DATE, --След дата
  an_next NUMBER --  След значение
                )
 IS
 BEGIN
  IF TRUNC(ad_next, 'MI') <= SYSDATE THEN
   raise_application_error(-20002, 'editmanual_pg.updvalue_p: Будущая дата должна быть больше текущей.');
  END IF;
  IF ad_next IS NULL THEN
   update manual_pts set curr_val=an_curr,next_date=ad_next,next_val=NULL where mid=an_mid;
  ELSE
   update manual_pts set curr_val=an_curr,next_date=ad_next,next_val=an_next where mid=an_mid;
  END IF;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'editmanual_pg.updvalue_p: Ошибка изменения значений. ' || CHR(10) || SQLERRM(SQLCODE));
 END;
------------------------------------------------------------------------------------------------------------------------
END; -- Package Body
/

-- End of DDL script for EDITMANUAL_PG

-- Start of DDL script for EDITMONITORS_PG
-- Generated 27-янв-03  11:34:01 am
-- from oe-RYDA:1

-- Package body EDITMONITORS_PG

CREATE OR REPLACE
Package Body      editmonitors_pg
IS
    -- пакет работы с мониторами
    -- дата создания 05/12/2002 (Коваленко А.С)
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура вставки
 PROCEDURE ins_p(
  an_nparent         NUMBER,--Ид родителя
  an_mschema         NUMBER,--Ид схемы
  av_name            VARCHAR2,--Название монитора
  an_dsize           NUMBER,--Размер описания
  alr_dfile          LONG RAW,--Описание монитора
  an_is_default      NUMBER,--Признак монитора по умолчанию
  an_monitor_id  OUT NUMBER --Ид монитора
                                 ) IS
 BEGIN
    SELECT roles_seq.NEXTVAL INTO an_monitor_id FROM DUAL;
    INSERT INTO monitors (monitor_id, nparent, mschema, name, dsize, dfile, is_default)
    VALUES (an_monitor_id, an_nparent, an_mschema, av_name, an_dsize, alr_dfile, an_is_default);
   EXCEPTION
    WHEN OTHERS THEN
     raise_application_error(-20001, 'editmonitors_pg.ins_p: Ошибка вставки монитора. ' || CHR(10) || SQLERRM(SQLCODE));
 END;
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура обновления данных
 PROCEDURE upd_p(
  an_monitor_id      NUMBER, --Ид монитора
  an_nparent         NUMBER,--Ид родителя
  an_mschema         NUMBER,--Ид схемы
  av_name            VARCHAR2,--Название монитора
  an_dsize           NUMBER,--Размер описания
  alr_dfile          LONG RAW,--Описание монитора
  an_is_default      NUMBER--Признак монитора по умолчанию
                             ) IS
 BEGIN
   IF an_dsize<0 THEN
     UPDATE monitors SET nparent = an_nparent, mschema = an_mschema, name = av_name, is_default = an_is_default
     WHERE monitor_id = an_monitor_id;
   ELSE
     UPDATE monitors SET nparent = an_nparent, mschema = an_mschema, name = av_name, dsize = an_dsize,
     dfile = alr_dfile, is_default = an_is_default
     WHERE monitor_id = an_monitor_id;
   END IF;
   EXCEPTION
    WHEN OTHERS THEN
     raise_application_error(-20001, 'editmonitors_pg.upd_p: Ошибка обновления монитора. ' || CHR(10) || SQLERRM(SQLCODE));
 END;
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура удаления данных
 PROCEDURE del_p(  an_monitor_id NUMBER --Ид монитора
                              ) IS
 BEGIN
   DELETE FROM monitors WHERE monitor_id = an_monitor_id;
   EXCEPTION
    WHEN OTHERS THEN
     raise_application_error(-20001, 'editmonitors_pg.del_p: Ошибка удаления монитора. ' || CHR(10) || SQLERRM(SQLCODE));
 END;
END; -- Package Body EDITMONITORS_PG
/

-- End of DDL script for EDITMONITORS_PG

-- Start of DDL script for EXPORT_PG
-- Generated 27-янв-03  11:34:01 am
-- from oe-RYDA:1

-- Package body EXPORT_PG

CREATE OR REPLACE
PACKAGE BODY EXPORT_PG
IS
  -- пакет работы системы экспорта данных
  -- дата создания 12/12/2001 Сечин А.А.
------------------------------------------------------------------------------------------------------------------------
-------------  interface  ----------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
--Готовим данные для экспорта
 PROCEDURE setexport(
  an_mid   NUMBER,
  ad_date  DATE,
  an_table NUMBER, -- an_table =1 BILL,=2 HALFHOUR,=3 PROFILE,=4 MONTHS,=5 JOURNAL (4 и 5 не реализовано)
  an_check NUMBER --Проверка на корректность
                 );
------------------------------------------------------------------------------------------------------------------------
-------------  implementation  -----------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
--Готовим данные для экспорта
 PROCEDURE setexport(
  an_mid    NUMBER,
  ad_date   DATE,
  an_table NUMBER, -- an_table =1 BILL,=2 HALFHOUR,=3 PROFILE,=4 MONTHS,=5 JOURNAL (4 и 5 не реализовано)
  an_check NUMBER --Проверка на корректность
  )
 IS
 ln_count NUMBER;
BEGIN
 IF an_check=1 THEN
  select count(*) into ln_count from dual
  where exists (select * from export_groups where mid=an_mid and decode(an_table,1,ISBILL,2,ISHOUR,3,ISPROF,4,0/*ISMONTHS*/,0)=1);
  IF ln_count=0 THEN
   RETURN;
  END IF;
 END IF;

 IF an_table=1 THEN
  insert into EXPORT_BILL(mid,date_time) values(an_mid,ad_date);
 ELSIF an_table=2 THEN
  insert into EXPORT_HOUR(mid,date_time) values(an_mid,ad_date);
 ELSIF an_table=3 THEN
  insert into EXPORT_PROF(mid,date_time) values(an_mid,ad_date);
 END IF;
EXCEPTION
 WHEN OTHERS THEN
  NULL;
END;
------------------------------------------------------------------------------------------------------------------------
--Готовим данные для экспорта
 PROCEDURE setexport(
  an_mid    NUMBER,
  ad_date   DATE,
  an_table NUMBER -- an_table =1 BILL,=2 HALFHOUR,=3 PROFILE,=4 MONTHS,=5 JOURNAL (4 и 5 не реализовано)
  )
 IS
BEGIN
 setexport(an_mid,ad_date,an_table,1);
END;
------------------------------------------------------------------------------------------------------------------------
--Готовим данные для экспорта (по сигналу)
 PROCEDURE setgroupexport(
  an_table NUMBER -- an_table =1 BILL,=2 HALFHOUR,=3 PROFILE,=4 MONTHS,=5 JOURNAL (4 и 5 не реализовано)
  )
 IS
 gn_sys DATE default SYSDATE;
 gn_dat DATE;
 cursor lcur_sel is select g.mid,e.mid emid,
  nvl(decode(an_table,1,e.BILL,2,e.HALFHOUR,3,e.PROFILE,4,e.MONTHS),gn_sys-decode(an_table,1,nvl(g.BILLsz,300),2,nvl(g.HOURsz/48,2),3,nvl(g.PROFsz/30,1),4,nvl(0/*g.MONTHSsz*30.5*/,1000))) lastd
  from export_groups g,last_export e
  where g.mid>0 and g.mid=e.mid(+) and decode(an_table,1,g.isbill,2,g.ISHOUR,3,g.ISPROF,4,0/*g.ISMONTHS*/,0)=1;
 cursor lcur_bill(lc_mid NUMBER,lc_min DATE) IS select date_time from bill where mid=lc_mid and date_time>lc_min and date_time<gn_sys order by date_time;
 cursor lcur_hour(lc_mid NUMBER,lc_min DATE) IS select date_time from HALFHOUR where mid=lc_mid and date_time>lc_min and date_time<gn_sys order by date_time;
 cursor lcur_profile(lc_mid NUMBER,lc_min DATE) IS select date_time from profile where mid=lc_mid and date_time>lc_min and date_time<gn_sys order by date_time;
 cursor lcur_months(lc_mid NUMBER,lc_min DATE) IS select date_time from months where mid=lc_mid and date_time>lc_min and date_time<gn_sys order by date_time;
 BEGIN
  FOR LC IN lcur_sel LOOP
   gn_dat:=LC.lastd;
   IF an_table=1 THEN
    FOR LC1 IN lcur_bill(LC.mid,LC.lastd) LOOP
     setexport(LC.mid,lc1.date_time,an_table,0);
     gn_dat:=lc1.date_time;
    END LOOP;
   ELSIF an_table=2 THEN
    FOR LC1 IN lcur_hour(LC.mid,LC.lastd) LOOP
     setexport(LC.mid,lc1.date_time,an_table,0);
     gn_dat:=lc1.date_time;
    END LOOP;
   ELSIF an_table=3 THEN
    FOR LC1 IN lcur_profile(LC.mid,LC.lastd) LOOP
     setexport(LC.mid,lc1.date_time,an_table,0);
     gn_dat:=lc1.date_time;
    END LOOP;
   ELSIF an_table=4 THEN
    FOR LC1 IN lcur_months(LC.mid,LC.lastd) LOOP
     setexport(LC.mid,lc1.date_time,an_table,0);
     gn_dat:=lc1.date_time;
    END LOOP;
   END IF;
   IF LC.emid IS NULL THEN
    INSERT INTO last_export(mid,BILL,HALFHOUR,PROFILE,MONTHS)
    VALUES(LC.mid,decode(an_table,1,gn_dat,LC.lastd),decode(an_table,2,gn_dat,LC.lastd),decode(an_table,3,gn_dat,LC.lastd),decode(an_table,4,gn_dat,LC.lastd));
   ELSE
    UPDATE last_export
    SET BILL=decode(an_table,1,gn_dat,BILL),
        HALFHOUR=decode(an_table,2,gn_dat,HALFHOUR),
        PROFILE=decode(an_table,3,gn_dat,PROFILE),
        MONTHS=decode(an_table,4,gn_dat,MONTHS)
    WHERE mid=LC.mid;
   END IF;
  END LOOP;
  signal(an_table);
 EXCEPTION
  WHEN OTHERS THEN
     raise_application_error(-20001, 'export_pg.setgroupexport: Ошибка вставки экспортируемых данных. ' || chr(10) || SqlErrm(SqlCode));
 END;
------------------------------------------------------------------------------------------------------------------------
--Сигнал для экспорта
 PROCEDURE signal(
  an_signal NUMBER -- an_signal =1 BILL,=2 HALFHOUR,=3 PROFILE,=4 MONTHS,=5 JOURNAL
  )
 IS
BEGIN
 IF an_signal=1 THEN
  SYS.DBMS_ALERT.SIGNAL('EXPORT_BILL_S', 'EXPORT_BILL_S');
 ELSIF an_signal=2 THEN
  SYS.DBMS_ALERT.SIGNAL('EXPORT_HOUR_S', 'EXPORT_HOUR_S');
 ELSIF an_signal=3 THEN
  SYS.DBMS_ALERT.SIGNAL('EXPORT_PROF_S', 'EXPORT_PROF_S');
 ELSIF an_signal=4 THEN
  SYS.DBMS_ALERT.SIGNAL('EXPORT_MONTHS_S', 'EXPORT_MONTHS_S');
 ELSIF an_signal=5 THEN
  SYS.DBMS_ALERT.SIGNAL('EXPORT_JOURNAL_S', 'EXPORT_JOURNAL_S');
 ELSIF an_signal=6 THEN
  SYS.DBMS_ALERT.SIGNAL('EXPORT_CURR_S', 'EXPORT_CURR_S');
 ELSIF an_signal=7 THEN
  SYS.DBMS_ALERT.SIGNAL('EXPORT_FISCAL_S', 'EXPORT_FISCAL_S');
 END IF;
END;
------------------------------------------------------------------------------------------------------------------------
END; -- Package Body INDIC_PG
/

-- End of DDL script for EXPORT_PG

-- Start of DDL script for FILEREPORT_PG
-- Generated 27-янв-03  11:34:01 am
-- from oe-RYDA:1

-- Package body FILEREPORT_PG

CREATE OR REPLACE
PACKAGE BODY FILEREPORT_PG IS
   ------------------------------------------------------------------------------------------------------------------------
     -- пакет по созданию отчетов в файл
     -- дата создания 27/07/2002 Сечин А.А.
 ------------------------------------------------------------------------------------------------------------------------
 gn_currline  NUMBER;
 gn_currgroup NUMBER;
 gd_currfrom  DATE;
 gd_currtill  DATE;
 gv_currname  VARCHAR2(256);
 ------------------------------------------------------------------------------------------------------------------------
 FUNCTION gn_group
  RETURN NUMBER IS
 BEGIN
  RETURN gn_currgroup;
 END;
 ------------------------------------------------------------------------------------------------------------------------
 FUNCTION gd_from
  RETURN DATE IS
 BEGIN
  RETURN gd_currfrom;
 END;
 ------------------------------------------------------------------------------------------------------------------------
 FUNCTION gd_till
  RETURN DATE IS
 BEGIN
  RETURN gd_currtill;
 END;
 ------------------------------------------------------------------------------------------------------------------------
 FUNCTION gv_name
  RETURN VARCHAR2 IS
 BEGIN
  RETURN gv_currname;
 END;
 ------------------------------------------------------------------------------------------------------------------------
 PROCEDURE main_p(an_form NUMBER, an_group NUMBER, ad_from DATE, ad_till DATE) IS
  lv_procname VARCHAR2(2000);
  ln_handle   INTEGER;
  ln_ret      NUMBER;
  ln_root1 NUMBER;
  ln_root2 NUMBER;
  lv_time VARCHAR2(8);
  lv_rdat VARCHAR2(8);
 BEGIN
  SELECT MAX(name), max(NROOT1), max(NROOT2)
    INTO gv_currname,ln_root1,ln_root2
    FROM groups
   WHERE gid = an_group;
  if ln_root1>1 and ln_root2 is not null then
   SELECT MAX(gid) INTO gn_currgroup
     FROM groups
    WHERE NROOT1 is null and  NROOT2=ln_root2;
  else
   gn_currgroup := an_group;
  end if;
  gd_currfrom := ad_from;
  gd_currtill := ad_till;
  gn_currline := 0;

  DELETE FROM textreport;
  COMMIT;
  SELECT RTRIM(LTRIM(MAX(vprocname))),nvl(MAX(substr(ENABLECONTROLS,2,1)),'0'),nvl(MAX(substr(ENABLECONTROLS,3,1)),'0')
    INTO lv_procname,lv_time,lv_rdat
    FROM forms
   WHERE fid = an_form;
  IF lv_procname IS NULL THEN
   raise_application_error(-20002, 'filereport_pg.main_p: Не задана отчетная процедура.');
  IF lv_time='0' THEN
    gd_currtill:=trunc(gd_currtill);
    gd_currfrom:=trunc(gd_currfrom);
  END IF;
  END IF;
  IF lv_rdat='0' THEN
    gd_currtill:=gd_currfrom+1;
  END IF;
  ln_handle := sys.DBMS_SQL.open_cursor;
  sys.DBMS_SQL.parse(ln_handle, 'begin ' || lv_procname || '; end;', sys.DBMS_SQL.native);
  ln_ret := sys.DBMS_SQL.EXECUTE(ln_handle);
  sys.DBMS_SQL.close_cursor(ln_handle);
  COMMIT;
 EXCEPTION
  WHEN OTHERS THEN
   ROLLBACK;
   IF sys.DBMS_SQL.is_open(ln_handle) THEN
    sys.DBMS_SQL.close_cursor(ln_handle);
   END IF;
   RAISE;
 END;
 ------------------------------------------------------------------------------------------------------------------------
 PROCEDURE put_p(av_text VARCHAR2) IS
 BEGIN
  gn_currline := gn_currline + 1;
  INSERT INTO textreport
              (norder, vtext)
       VALUES (gn_currline, av_text);
 END;
------------------------------------------------------------------------------------------------------------------------
END; -- Package Body REPORTS1_PG
/

-- End of DDL script for FILEREPORT_PG

-- Start of DDL script for FILE_PG
-- Generated 27-янв-03  11:34:01 am
-- from oe-RYDA:1

-- Package body FILE_PG

CREATE OR REPLACE
PACKAGE BODY file_pg IS
 -------------------------------------------------------------------------------------------
 --****                         Interface                                             ****--
 -------------------------------------------------------------------------------------------
 gr_file sys.UTL_FILE.file_type;
 gvcurr_param VARCHAR2(2000);
 -------------------------------------------------------------------------------------------
 --****                       Implementation                                          ****--
 -------------------------------------------------------------------------------------------
  FUNCTION gv_param return VARCHAR2 is
  begin
  return gvcurr_param;
  end;
 -------------------------------------------------------------------------------------------

 PROCEDURE main_p IS
  CURSOR lcur_sel(lc_sys DATE) IS
   SELECT   p.nprocedure, p.ntype,m.VPARAM, m.nmaket, p.vname, p.vprocedure, m.ncycle, m.nshift, p.nperiod,
            DECODE(
             m.doldcreated, NULL, DECODE(
                                   p.nperiod, 1, TRUNC(lc_sys - m.nshift / 1440, 'HH24') - 1 / 24, 2,
                                   TRUNC(lc_sys - m.nshift / 1440, 'DD') - 1, 3, TRUNC(
                                                                                  lc_sys -
                                                                                  m.nshift / 1440, 'D') -
                                                                                 7, 4,
                                   util_pg.add_dec(util_pg.truncdec(lc_sys - m.nshift / 1440), -1), 5,
                                   ADD_MONTHS(TRUNC(lc_sys - m.nshift / 1440, 'MM'), -1)),
             DECODE(
              p.nperiod, 1, DECODE(
                             m.ncycle, 1, TRUNC(m.doldcreated, 'HH24') + 1 / 24, TRUNC(
                                                                                  lc_sys -
                                                                                  m.nshift / 1440, 'HH24') -
                                                                                 1 / 24), 2,
              DECODE(
               m.ncycle, 1, TRUNC(m.doldcreated, 'DD') + 1, TRUNC(lc_sys - m.nshift / 1440, 'DD') - 1), 3,
              DECODE(m.ncycle, 1, TRUNC(m.doldcreated, 'D') + 7, TRUNC(lc_sys - m.nshift / 1440, 'D') - 7), 4,
              DECODE(
               m.ncycle, 1, util_pg.add_dec(util_pg.truncdec(m.doldcreated), 1),
               util_pg.add_dec(util_pg.truncdec(lc_sys - m.nshift / 1440), -1)), 5,
              DECODE(
               ncycle, 1, ADD_MONTHS(TRUNC(m.doldcreated, 'MM'), 1), ADD_MONTHS(
                                                                      TRUNC(
                                                                       lc_sys - m.nshift / 1440, 'MM'), -1)))) doldcreated
       FROM deportprocedures p, makets m
      WHERE p.nprocedure = m.nprocedure
        AND (p.ntype <> 0 OR EXISTS(
                                   SELECT *
                                     FROM deportation
                                    WHERE nmaket = m.nmaket AND nblock = 0 AND nparent IS NULL))
        AND m.nblock = 0
        AND (   m.doldcreated IS NULL
             OR DECODE(
                 p.nperiod, 1, TRUNC(m.doldcreated, 'HH24') + 2 / 24, 2, TRUNC(m.doldcreated, 'DD') + 2, 3,
                 TRUNC(m.doldcreated, 'D') + 14, 4, util_pg.add_dec(util_pg.truncdec(m.doldcreated), 2), 5,
                 ADD_MONTHS(TRUNC(m.doldcreated, 'MM'), 2)) <= lc_sys - m.nshift / 1440)
   ORDER BY 1, 2;
  CURSOR lcur_deport(lc_maket NUMBER) IS
   SELECT ndeportation
     FROM deportation
    WHERE nmaket = lc_maket AND nparent IS NULL AND nblock = 0;
  gd_sys      DATE;
  lv_seqfname VARCHAR2(128);
  lv_orgfname VARCHAR2(128);
  lv_fname    VARCHAR2(2000);
  lv_fpath    VARCHAR2(2000);
  ld_counter  DATE;
  ln_handle   INTEGER;
  ln_ret      NUMBER;
  ln_code     NUMBER;
  lv_error    VARCHAR2(2000);
 BEGIN
  admin_pg.begin_p;
  SELECT MAX(vvalue)
    INTO lv_fpath
    FROM parameter
   WHERE npid = 10;
  IF lv_fpath IS NULL THEN
   raise_application_error(-20002, 'Не задан каталог для хранения файлов рассылки в таблице конфигураций.');
  END IF;
  gd_sys := SYSDATE;
  ln_handle := sys.DBMS_SQL.open_cursor;
  FOR lc IN lcur_sel(gd_sys) LOOP
   ld_counter := lc.doldcreated;
   gvcurr_param:=lc.VPARAM;
   WHILE (lc.nperiod = 1 AND ld_counter + 1 / 24 <= gd_sys - lc.nshift / 1440)
      OR (lc.nperiod = 2 AND ld_counter + 1 <= gd_sys - lc.nshift / 1440)
      OR (lc.nperiod = 3 AND ld_counter + 7 <= gd_sys - lc.nshift / 1440)
      OR (lc.nperiod = 4 AND util_pg.add_dec(ld_counter, 1) <= gd_sys - lc.nshift / 1440)
      OR (lc.nperiod = 5 AND ADD_MONTHS(ld_counter, 1) <= gd_sys - lc.nshift / 1440) LOOP
    BEGIN
     BEGIN
      IF lc.ntype = 0 THEN --Макет
       SELECT TO_CHAR(deportation_seq.NEXTVAL) || '.txt'
         INTO lv_seqfname
         FROM DUAL;
       lv_orgfname := lv_seqfname;
       lv_fname := lv_fpath || lv_seqfname;
       gr_file := sys.UTL_FILE.fopen(lv_fpath, lv_fname, 'w');
       sys.DBMS_SQL.parse(
        ln_handle, 'BEGIN ' || lc.vprocedure || '(:lc_maket,:lc_dat,:lc_fname); END;', sys.DBMS_SQL.native);
       sys.DBMS_SQL.bind_variable(ln_handle, 'lc_maket', lc.nmaket);
       sys.DBMS_SQL.bind_variable(ln_handle, 'lc_dat', ld_counter);
       sys.DBMS_SQL.bind_variable(ln_handle, 'lc_fname', lv_orgfname, 128);
       IF sys.DBMS_SQL.EXECUTE(ln_handle) < 0 THEN
        raise_application_error(-20002, 'Ошибка запуска макета.');
       END IF;
       sys.DBMS_SQL.variable_value(ln_handle, 'lc_fname', lv_orgfname);
       sys.UTL_FILE.fclose(gr_file);
       FOR lc1 IN lcur_deport(lc.nmaket) LOOP
        UPDATE deportfiles
           SET vfile = lv_seqfname,
               vfilename = lv_orgfname,
               nstate = 0,
               verror = NULL
         WHERE ndeportation = lc1.ndeportation AND ddate = ld_counter;
        IF SQL%ROWCOUNT = 0 THEN
         INSERT INTO deportfiles
                     (ndeportation, ddate, vfile, vfilename, nstate, verror)
              VALUES (lc1.ndeportation, ld_counter, lv_seqfname, lv_orgfname, 0, NULL);
        END IF;
       END LOOP;
      ELSE --Процедура верификации
       sys.DBMS_SQL.parse(ln_handle, 'BEGIN ' || lc.vprocedure || '(:lc_maket,:lc_dat); END;', sys.DBMS_SQL.native);
       sys.DBMS_SQL.bind_variable(ln_handle, 'lc_maket', lc.nmaket);
       sys.DBMS_SQL.bind_variable(ln_handle, 'lc_dat', ld_counter);
       IF sys.DBMS_SQL.EXECUTE(ln_handle) < 0 THEN
        raise_application_error(-20002, 'Ошибка запуска макета.');
       END IF;
      END IF;
      UPDATE makets
         SET verror = NULL,
             doldcreated = ld_counter
       WHERE nmaket = lc.nmaket;
      COMMIT;
      IF lc.nperiod = 1 THEN
       ld_counter := ld_counter + 1 / 24;
      ELSIF lc.nperiod = 2 THEN
       ld_counter := ld_counter + 1;
      ELSIF lc.nperiod = 3 THEN
       ld_counter := ld_counter + 7;
      ELSIF lc.nperiod = 4 THEN
       ld_counter := util_pg.add_dec(ld_counter, 1);
      ELSIF lc.nperiod = 5 THEN
       ld_counter := ADD_MONTHS(ld_counter, 1);
      ELSE
       EXIT;
      END IF;
     EXCEPTION
      WHEN sys.UTL_FILE.invalid_path THEN
       raise_application_error(-20001, common_pg.geterrtext(1) || lv_fname);
      WHEN sys.UTL_FILE.invalid_operation THEN
       raise_application_error(-20001, common_pg.geterrtext(2) || lv_fname);
      WHEN sys.UTL_FILE.invalid_filehandle THEN
       raise_application_error(-20001, common_pg.geterrtext(3) || lv_fname);
      WHEN sys.UTL_FILE.write_error THEN
       raise_application_error(-20001, common_pg.geterrtext(4) || lv_fname);
      WHEN OTHERS THEN
       RAISE;
     END;
    EXCEPTION
     WHEN OTHERS THEN
      lv_error := SUBSTR('file_pg.main_p: '|| SQLERRM, 1, 2000);
      ln_code := SQLCODE;
      sys.UTL_FILE.fclose_all;
      ROLLBACK;
      UPDATE makets
         SET verror = lv_error
       WHERE nmaket = lc.nmaket;
      COMMIT;
      IF ln_code = -28 OR ln_code = -1089 THEN
       RAISE;
      ELSE
       EXIT;
      END IF;
    END;
   END LOOP;
  END LOOP;
  sys.DBMS_SQL.close_cursor(ln_handle);
  INSERT INTO jobs
              (njob, date_time)
       VALUES (2, SYSDATE);
  COMMIT;
 EXCEPTION
  WHEN OTHERS THEN
   lv_error := SUBSTR('file_pg.main_p: '|| SQLERRM, 1, 2000);
   ROLLBACK;
   IF sys.DBMS_SQL.is_open(ln_handle) THEN
    sys.DBMS_SQL.close_cursor(ln_handle);
   END IF;
   INSERT INTO jobs
               (njob, date_time, errortext)
        VALUES (2, SYSDATE, lv_error);
   COMMIT;
 END;
 ------------------------------------------------------------------------------------------------------------------------
 PROCEDURE out_p(av_str IN VARCHAR2) IS
 BEGIN
  sys.UTL_FILE.put_line(gr_file, av_str);
 END;
 -------------------------------------------------------------------------------------------------
 PROCEDURE startimmediate_p(an_maket NUMBER, ad_date DATE,av_param VARCHAR2) IS
  CURSOR lcur_sel IS
   SELECT m.nmaket, p.ntype, p.vprocedure,DECODE(p.nperiod, 1, TRUNC(ad_date, 'HH24'), 2, TRUNC(ad_date, 'DD'), 3, TRUNC(ad_date, 'D'), 4,util_pg.truncdec(ad_date), 5, TRUNC(ad_date, 'MM')) doldcreated
     FROM deportprocedures p, makets m
    WHERE m.nmaket = an_maket
      AND m.nprocedure = p.nprocedure(+)
      AND (p.ntype <> 0 OR EXISTS( SELECT *
                                     FROM deportation
                                    WHERE nmaket = an_maket AND nblock = 0 AND nparent IS NULL));
  CURSOR lcur_deport(lc_maket NUMBER) IS
   SELECT ndeportation
     FROM deportation
    WHERE nmaket = lc_maket AND nparent IS NULL AND nblock = 0;
  lv_seqfname VARCHAR2(128);
  lv_orgfname VARCHAR2(128);
  lv_fname    VARCHAR2(2000);
  lv_fpath    VARCHAR2(2000);
  ln_handle   INTEGER;
  ln_ret      NUMBER;
  ln_code     NUMBER;
  lv_error    VARCHAR2(2000);
  lc          lcur_sel%ROWTYPE;
 BEGIN
  gvcurr_param:=av_param;
  OPEN lcur_sel;
  FETCH lcur_sel INTO lc;
  IF lcur_sel%NOTFOUND THEN
   CLOSE lcur_sel;
   raise_application_error(-20002, 'Задание не найдено или нет доступных адресатов для получения макета.');
  END IF;
  CLOSE lcur_sel;
  ln_handle := sys.DBMS_SQL.open_cursor;
  IF lc.ntype = 0 THEN --Макет
   SELECT MAX(vvalue)
     INTO lv_fpath
     FROM parameter
    WHERE npid = 10;
   IF lv_fpath IS NULL THEN
    raise_application_error(-20002, 'Не задан каталог для хранения файлов рассылки в таблице конфигураций.');
   END IF;
   BEGIN
    SELECT TO_CHAR(deportation_seq.NEXTVAL) || '.txt'
      INTO lv_seqfname
      FROM DUAL;
    lv_orgfname := lv_seqfname;
    lv_fname := lv_fpath || lv_seqfname;
    gr_file := sys.UTL_FILE.fopen(lv_fpath, lv_fname, 'w');
    sys.DBMS_SQL.parse(ln_handle, 'BEGIN ' || lc.vprocedure || '(:lc_maket,:lc_dat,:lc_fname); END;',
                                                                                                    sys.DBMS_SQL.native);
    sys.DBMS_SQL.bind_variable(ln_handle, 'lc_maket', lc.nmaket);
    sys.DBMS_SQL.bind_variable(ln_handle, 'lc_dat', lc.doldcreated);
    sys.DBMS_SQL.bind_variable(ln_handle, 'lc_fname', lv_orgfname, 128);
    IF sys.DBMS_SQL.EXECUTE(ln_handle) < 0 THEN
     raise_application_error(-20002, 'Ошибка запуска макета.');
    END IF;
    sys.DBMS_SQL.variable_value(ln_handle, 'lc_fname', lv_orgfname);
    sys.UTL_FILE.fclose(gr_file);
    FOR lc1 IN lcur_deport(lc.nmaket) LOOP
     UPDATE deportfiles
        SET vfile = lv_seqfname,
            vfilename = lv_orgfname,
            nstate = 0,
            verror = NULL
      WHERE ndeportation = lc1.ndeportation AND ddate = lc.doldcreated;
     IF SQL%ROWCOUNT = 0 THEN
      INSERT INTO deportfiles
                  (ndeportation, ddate, vfile, vfilename, nstate, verror)
           VALUES (lc1.ndeportation, lc.doldcreated, lv_seqfname, lv_orgfname, 0, NULL);
     END IF;
    END LOOP;
   EXCEPTION
    WHEN sys.UTL_FILE.invalid_path THEN
     raise_application_error(-20001, common_pg.geterrtext(1) || lv_fname);
    WHEN sys.UTL_FILE.invalid_operation THEN
     raise_application_error(-20001, common_pg.geterrtext(2) || lv_fname);
    WHEN sys.UTL_FILE.invalid_filehandle THEN
     raise_application_error(-20001, common_pg.geterrtext(3) || lv_fname);
    WHEN sys.UTL_FILE.write_error THEN
     raise_application_error(-20001, common_pg.geterrtext(4) || lv_fname);
    WHEN OTHERS THEN
     RAISE;
   END;
  ELSE
   sys.DBMS_SQL.parse(ln_handle, 'BEGIN ' || lc.vprocedure || '(:lc_maket,:lc_dat); END;', sys.DBMS_SQL.native);
   sys.DBMS_SQL.bind_variable(ln_handle, 'lc_maket', lc.nmaket);
   sys.DBMS_SQL.bind_variable(ln_handle, 'lc_dat', lc.doldcreated);
   IF sys.DBMS_SQL.EXECUTE(ln_handle) < 0 THEN
    raise_application_error(-20002, 'Ошибка запуска макета.');
   END IF;
  END IF;
  sys.DBMS_SQL.close_cursor(ln_handle);
  COMMIT;
 EXCEPTION
  WHEN OTHERS THEN
   ROLLBACK;
   IF sys.DBMS_SQL.is_open(ln_handle) THEN
    sys.DBMS_SQL.close_cursor(ln_handle);
   END IF;
   RAISE;
 END;
-------------------------------------------------------------------------------------------------
END; -- Package Body file_pg
/

-- End of DDL script for FILE_PG

-- Start of DDL script for INDIC_PG
-- Generated 27-янв-03  11:34:01 am
-- from oe-RYDA:1

-- Package body INDIC_PG

CREATE OR REPLACE
PACKAGE BODY indic_pg IS
   -- пакет работы с показаниями
   -- дата создания 13/10/2001 Сечин А.А.
 ------------------------------------------------------------------------------------------------------------------------
 gn_1               NUMBER DEFAULT 5; --Округление показаний
 gn_2               NUMBER DEFAULT 3; --Округление расхода
 --chig
 man_inp_hhour_code NUMBER DEFAULT 13; --Код таблицы MAN_INP_HHOUR
 --e
 gn_outputgroup NUMBER;
 ------------------------------------------------------------------------------------------------------------------------
 PROCEDURE calc_hh24(an_mid NUMBER, ad_date DATE, an_type NUMBER,an_r NUMBER) IS
 ln_r NUMBER default nvl(an_r,0);
 ld_begin DATE default util_pg.trunchh24_2(getlastdate(an_mid,ad_date,an_type,0,5,1));
 ld_end DATE default util_pg.trunchh24_2(ad_date);
 cursor lc_sel is
 select to_char(util_pg.trunchh24_2(date_time),'SSSSS')/1800,
 sum(DECODE(an_type, 2, ed, 3, q1, 4, q2, 5, q3, 6, q4, er)) er
 from halfhourold where mid=an_mid and date_time>ld_begin and date_time<=ld_end and nexceptcalc is null
 group by util_pg.trunchh24_2(date_time);
 lt_koef common_pg.tt_number;
 cursor lc_sel1 is select NHH,DECODE(an_type, 2, ned, 3, nq1, 4, nq2, 5, nq3, 6, nq4, ner) er from AVERRATE;
 ln_sm NUMBER default 0;
 ld_tmp DATE;
 ln_rn NUMBER default 10;
 kk NUMBER;
 BEGIN
/*  IF an_type<>1 THEN
   return;
  END IF;*/
  update halfhourold set
  er=DECODE(an_type, 1, NULL,er),
  ed=DECODE(an_type, 2, NULL,ED),
  q1=DECODE(an_type, 3, NULL,q1),
  q2=DECODE(an_type, 4, NULL,q2),
  q3=DECODE(an_type, 5, NULL,q3),
  q4=DECODE(an_type, 6, NULL,q4)
  where mid=an_mid and date_time>ld_begin and date_time<=ld_end and nsource=cn_manualinput;
  IF round(ln_r,2)<=0 OR ld_begin IS NULL OR ld_end IS NULL OR ld_begin>=ld_end THEN
   return;
  END IF;
  select ln_r-nvl(sum(DECODE(an_type, 2, ed, 3, q1, 4, q2, 5, q3, 6, q4, er)),0),util_pg.trunchh24_2(nvl(max(date_time),ld_begin)+1/48) dt
  into ln_r,ld_begin
  from halfhourold where mid=an_mid and date_time>ld_begin and date_time<=ld_end and nexceptcalc is null
  and DECODE(an_type, 2, ed, 3, q1, 4, q2, 5, q3, 6, q4, er) is not null;
  IF round(ln_r,2)<=0 OR ld_begin>ld_end THEN
   return;
  END IF;
  lt_koef:=averrate_pg.averrate_f(an_mid,an_type,ld_begin,ld_end);

  ld_tmp:=ld_begin;
  kk:=1;
   WHILE ld_tmp<=ld_end LOOP
    update halfhourold set
     er=round(DECODE(an_type, 1, ln_r*lt_koef(kk),er),ln_rn),
     ed=round(DECODE(an_type, 2, ln_r*lt_koef(kk),ED),ln_rn),
     q1=round(DECODE(an_type, 3, ln_r*lt_koef(kk),q1),ln_rn),
     q2=round(DECODE(an_type, 4, ln_r*lt_koef(kk),q2),ln_rn),
     q3=round(DECODE(an_type, 5, ln_r*lt_koef(kk),q3),ln_rn),
     q4=round(DECODE(an_type, 6, ln_r*lt_koef(kk),q4),ln_rn)
    where mid=an_mid and date_time=ld_tmp and nsource=cn_manualinput;
    if sql%rowcount=0 then
     insert into halfhourold(mid,date_time,nsource,er,ed,q1,q2,q3,q4)
      values (an_mid,ld_tmp,cn_manualinput,
              round(DECODE(an_type, 1, ln_r*lt_koef(kk),NULL),ln_rn),
              round(DECODE(an_type, 2, ln_r*lt_koef(kk),NULL),ln_rn),
              round(DECODE(an_type, 3, ln_r*lt_koef(kk),NULL),ln_rn),
              round(DECODE(an_type, 4, ln_r*lt_koef(kk),NULL),ln_rn),
              round(DECODE(an_type, 5, ln_r*lt_koef(kk),NULL),ln_rn),
              round(DECODE(an_type, 6, ln_r*lt_koef(kk),NULL),ln_rn));
    end if;
    ld_tmp:=ld_tmp+1/48;
    kk:=kk+1;
   END LOOP;
   DAS_pg.CalcPoint4Bill(an_mid, ld_begin, ld_end);
 END;
  ------------------------------------------------------------------------------------------------------------------------
 PROCEDURE calc_hh24_equal(an_mid NUMBER, ad_date DATE, an_type NUMBER,an_r NUMBER) IS
 ln_r NUMBER default nvl(an_r,0);
 ld_begin DATE default trunc(ad_date)-1;
 ld_end DATE default trunc(ad_date);
 cursor lc_sel is
 select to_char(util_pg.trunchh24_2(date_time),'SSSSS')/1800,
 sum(DECODE(an_type, 2, ed, 3, q1, 4, q2, 5, q3, 6, q4, er)) er
 from halfhourold where mid=an_mid and date_time>ld_begin and date_time<=ld_end and nexceptcalc is null
 group by util_pg.trunchh24_2(date_time);
 ln_sm NUMBER;
 ln_ost NUMBER default 0;
 ld_tmp DATE;
 ln_rn NUMBER default 10;
 BEGIN
/*  IF an_type<>1 THEN
   return;
  END IF;*/
  update halfhourold set
  er=DECODE(an_type, 1, NULL,er),
  ed=DECODE(an_type, 2, NULL,ED),
  q1=DECODE(an_type, 3, NULL,q1),
  q2=DECODE(an_type, 4, NULL,q2),
  q3=DECODE(an_type, 5, NULL,q3),
  q4=DECODE(an_type, 6, NULL,q4)
  where mid=an_mid and date_time>ld_begin and date_time<=ld_end and nsource=cn_manualinput;
  IF round(ln_r,2)<=0 OR ld_begin IS NULL OR ld_end IS NULL OR ld_begin>=ld_end THEN
   return;
  END IF;
  select ln_r-nvl(sum(DECODE(an_type, 2, ed, 3, q1, 4, q2, 5, q3, 6, q4, er)),0),util_pg.trunchh24_2(nvl(max(date_time),ld_begin)+1/48) dt
  into ln_r,ld_begin
  from halfhourold where mid=an_mid and date_time>ld_begin and date_time<=ld_end and nexceptcalc is null
  and DECODE(an_type, 2, ed, 3, q1, 4, q2, 5, q3, 6, q4, er) is not null;
  IF round(ln_r,2)<=0 OR ld_begin>ld_end THEN
   return;
  END IF;
  ld_tmp:=ld_begin;
   WHILE ld_tmp<=ld_end LOOP
    IF ld_tmp<ld_end THEN
     ln_sm:=round(ln_r/48,ln_rn);
     ln_ost:=ln_ost+round(ln_r/48,ln_rn);
    ELSE
     ln_sm:=ln_r-ln_ost;
    END IF;
    update halfhourold set
     er=DECODE(an_type, 1, ln_sm,er),
     ed=DECODE(an_type, 2, ln_sm,ED),
     q1=DECODE(an_type, 3, ln_sm,q1),
     q2=DECODE(an_type, 4, ln_sm,q2),
     q3=DECODE(an_type, 5, ln_sm,q3),
     q4=DECODE(an_type, 6, ln_sm,q4)
    where mid=an_mid and date_time=ld_tmp and nsource=cn_manualinput;
    if sql%rowcount=0 then
     insert into halfhourold(mid,date_time,nsource,er,ed,q1,q2,q3,q4)
      values (an_mid,ld_tmp,cn_manualinput,
              DECODE(an_type, 1, ln_sm,NULL),
              DECODE(an_type, 2, ln_sm,NULL),
              DECODE(an_type, 3, ln_sm,NULL),
              DECODE(an_type, 4, ln_sm,NULL),
              DECODE(an_type, 5, ln_sm,NULL),
              DECODE(an_type, 6, ln_sm,NULL));
    end if;
    ld_tmp:=ld_tmp+1/48;
   END LOOP;
   DAS_pg.CalcPoint4Bill(an_mid, trunc(ld_begin), trunc(ld_end));
 END;
  ------------------------------------------------------------------------------------------------------------------------
 -- Дата последних (показаний an_kind=1 или расхода an_kind=2 иначе записи)
 FUNCTION getlastdate(
  an_mid   NUMBER,
  ad_date  DATE,
  an_ntype NUMBER,
  an_zone  NUMBER,
  an_table NUMBER, -- an_table =1 BILL,=2 HALFHOUR,=3 PROFILE,=5 BILLORG иначе MONTHSORGORG
  an_kind  NUMBER)
  RETURN DATE IS
  ld_ret DATE;
 BEGIN
  IF an_table = 1 THEN --BILL
   IF an_kind = 1 THEN --Показаний
    SELECT MAX(date_time)
      INTO ld_ret
      FROM bill
     WHERE mid = an_mid
       AND date_time < ad_date
       AND DECODE(
            an_zone, 1, DECODE(an_ntype, 2, aedm, 3, aq1m, 4, aq2m, 5, aq3m, 6, aq4m, aerm), 2, DECODE(
                                                                                                 an_ntype, 2, bedm, 3,
                                                                                                 bq1m, 4, bq2m, 5, bq3m,
                                                                                                 6, bq4m, berm), 3,
            DECODE(an_ntype, 2, cedm, 3, cq1m, 4, cq2m, 5, cq3m, 6, cq4m, cerm), 4, DECODE(
                                                                                     an_ntype, 2, dedm, 3, dq1m, 4,
                                                                                     dq2m, 5, dq3m, 6, dq4m, derm),
            DECODE(an_ntype, 2, edm, 3, q1m, 4, q2m, 5, q3m, 6, q4m, erm)) IS NOT NULL;
   ELSIF an_kind = 2 THEN --Расхода
    SELECT MAX(date_time)
      INTO ld_ret
      FROM bill
     WHERE mid = an_mid
       AND date_time < ad_date
       AND DECODE(
            an_zone, 1, DECODE(an_ntype, 2, aed, 3, aq1, 4, aq2, 5, aq3, 6, aq4, aer), 2, DECODE(
                                                                                           an_ntype, 2, bed, 3, bq1, 4,
                                                                                           bq2, 5, bq3, 6, bq4, ber), 3,
            DECODE(an_ntype, 2, ced, 3, cq1, 4, cq2, 5, cq3, 6, cq4, cer), 4, DECODE(
                                                                               an_ntype, 2, ded, 3, dq1, 4, dq2, 5, dq3,
                                                                               6, dq4, der), DECODE(
                                                                                              an_ntype, 2, ed, 3, q1, 4,
                                                                                              q2, 5, q3, 6, q4, er)) IS NOT NULL;
   ELSE --Записей
    SELECT MAX(date_time)
      INTO ld_ret
      FROM bill
     WHERE mid = an_mid
       AND date_time < ad_date
       AND (   DECODE(
             an_zone, 1, DECODE(an_ntype, 2, aedm, 3, aq1m, 4, aq2m, 5, aq3m, 6, aq4m, aerm), 2, DECODE(
                                                                                                  an_ntype, 2, bedm, 3,
                                                                                                  bq1m, 4, bq2m, 5,
                                                                                                  bq3m, 6, bq4m, berm),
             3, DECODE(an_ntype, 2, cedm, 3, cq1m, 4, cq2m, 5, cq3m, 6, cq4m, cerm), 4, DECODE(
                                                                                         an_ntype, 2, dedm, 3, dq1m, 4,
                                                                                         dq2m, 5, dq3m, 6, dq4m, derm),
             DECODE(an_ntype, 2, edm, 3, q1m, 4, q2m, 5, q3m, 6, q4m, erm)) IS NOT NULL
            OR DECODE(
                an_zone, 1, DECODE(an_ntype, 2, aed, 3, aq1, 4, aq2, 5, aq3, 6, aq4, aer), 2, DECODE(
                                                                                               an_ntype, 2, bed, 3, bq1,
                                                                                               4, bq2, 5, bq3, 6, bq4,
                                                                                               ber), 3, DECODE(
                                                                                                         an_ntype, 2,
                                                                                                         ced, 3, cq1, 4,
                                                                                                         cq2, 5, cq3, 6,
                                                                                                         cq4, cer), 4,
                DECODE(an_ntype, 2, ded, 3, dq1, 4, dq2, 5, dq3, 6, dq4, der), DECODE(
                                                                                an_ntype, 2, ed, 3, q1, 4, q2, 5, q3, 6,
                                                                                q4, er)) IS NOT NULL);
   END IF;
  ELSIF an_table = 2 THEN --HALFHOUR
   IF an_kind = 1 THEN --Показаний
    SELECT MAX(date_time)
      INTO ld_ret
      FROM halfhour
     WHERE mid = an_mid
       AND date_time < ad_date
       AND DECODE(an_ntype, 2, edm, 3, q1m, 4, q2m, 5, q3m, 6, q4m, erm) IS NOT NULL;
   ELSIF an_kind = 2 THEN --Расхода
    SELECT MAX(date_time)
      INTO ld_ret
      FROM halfhour
     WHERE mid = an_mid AND date_time < ad_date AND DECODE(an_ntype, 2, ed, 3, q1, 4, q2, 5, q3, 6, q4, er) IS NOT NULL;
   ELSE --Записей
    SELECT MAX(date_time)
      INTO ld_ret
      FROM halfhour
     WHERE mid = an_mid
       AND date_time < ad_date
       AND (   DECODE(an_ntype, 2, edm, 3, q1m, 4, q2m, 5, q3m, 6, q4m, erm) IS NOT NULL
            OR DECODE(an_ntype, 2, ed, 3, q1, 4, q2, 5, q3, 6, q4, er) IS NOT NULL);
   END IF;
  --chig
  ELSIF an_table = man_inp_hhour_code THEN --MAN_INP_HHOUR
   IF an_kind = 1 THEN --Показаний
    SELECT MAX(date_time)
      INTO ld_ret
      FROM man_inp_hhour
     WHERE mid = an_mid
       AND date_time < ad_date
       AND DECODE(an_ntype, 2, edm, 3, q1m, 4, q2m, 5, q3m, 6, q4m, erm) IS NOT NULL;
   ELSIF an_kind = 2 THEN --Расхода
    SELECT MAX(date_time)
      INTO ld_ret
      FROM man_inp_hhour
     WHERE mid = an_mid AND date_time < ad_date AND DECODE(an_ntype, 2, ed, 3, q1, 4, q2, 5, q3, 6, q4, er) IS NOT NULL;
   ELSE --Записей
    SELECT MAX(date_time)
      INTO ld_ret
      FROM man_inp_hhour
     WHERE mid = an_mid
       AND date_time < ad_date
       AND (   DECODE(an_ntype, 2, edm, 3, q1m, 4, q2m, 5, q3m, 6, q4m, erm) IS NOT NULL
            OR DECODE(an_ntype, 2, ed, 3, q1, 4, q2, 5, q3, 6, q4, er) IS NOT NULL);
   END IF;
  --e chig
  ELSIF an_table = 3 THEN --PROFILE
   IF an_kind = 1 THEN --Показаний
    SELECT MAX(date_time)
      INTO ld_ret
      FROM PROFILE
     WHERE mid = an_mid
       AND date_time < ad_date
       AND DECODE(an_ntype, 2, edm, 3, q1m, 4, q2m, 5, q3m, 6, q4m, erm) IS NOT NULL;
   ELSIF an_kind = 2 THEN --Расхода
    SELECT MAX(date_time)
      INTO ld_ret
      FROM PROFILE
     WHERE mid = an_mid AND date_time < ad_date AND DECODE(an_ntype, 2, ed, 3, q1, 4, q2, 5, q3, 6, q4, er) IS NOT NULL;
   ELSE --Записей
    SELECT MAX(date_time)
      INTO ld_ret
      FROM PROFILE
     WHERE mid = an_mid
       AND date_time < ad_date
       AND (   DECODE(an_ntype, 2, edm, 3, q1m, 4, q2m, 5, q3m, 6, q4m, erm) IS NOT NULL
            OR DECODE(an_ntype, 2, ed, 3, q1, 4, q2, 5, q3, 6, q4, er) IS NOT NULL);
   END IF;
  ELSIF an_table = 5 THEN --BILLORG
   IF an_kind = 1 THEN --Показаний
    SELECT MAX(date_time)
      INTO ld_ret
      FROM billorg
     WHERE mid = an_mid
       AND date_time < ad_date
       AND DECODE(
            an_zone, 1, DECODE(an_ntype, 2, aedm, 3, aq1m, 4, aq2m, 5, aq3m, 6, aq4m, aerm), 2, DECODE(
                                                                                                 an_ntype, 2, bedm, 3,
                                                                                                 bq1m, 4, bq2m, 5, bq3m,
                                                                                                 6, bq4m, berm), 3,
            DECODE(an_ntype, 2, cedm, 3, cq1m, 4, cq2m, 5, cq3m, 6, cq4m, cerm), 4, DECODE(
                                                                                     an_ntype, 2, dedm, 3, dq1m, 4,
                                                                                     dq2m, 5, dq3m, 6, dq4m, derm),
            DECODE(an_ntype, 2, edm, 3, q1m, 4, q2m, 5, q3m, 6, q4m, erm)) IS NOT NULL;
   ELSIF an_kind = 2 THEN --Расхода
    SELECT MAX(date_time)
      INTO ld_ret
      FROM billorg
     WHERE mid = an_mid
       AND date_time < ad_date
       AND DECODE(
            an_zone, 1, DECODE(an_ntype, 2, aed, 3, aq1, 4, aq2, 5, aq3, 6, aq4, aer), 2, DECODE(
                                                                                           an_ntype, 2, bed, 3, bq1, 4,
                                                                                           bq2, 5, bq3, 6, bq4, ber), 3,
            DECODE(an_ntype, 2, ced, 3, cq1, 4, cq2, 5, cq3, 6, cq4, cer), 4, DECODE(
                                                                               an_ntype, 2, ded, 3, dq1, 4, dq2, 5, dq3,
                                                                               6, dq4, der), DECODE(
                                                                                              an_ntype, 2, ed, 3, q1, 4,
                                                                                              q2, 5, q3, 6, q4, er)) IS NOT NULL;
   ELSE --Записей
    SELECT MAX(date_time)
      INTO ld_ret
      FROM billorg
     WHERE mid = an_mid
       AND date_time < ad_date
       AND (   DECODE(
             an_zone, 1, DECODE(an_ntype, 2, aedm, 3, aq1m, 4, aq2m, 5, aq3m, 6, aq4m, aerm), 2, DECODE(
                                                                                                  an_ntype, 2, bedm, 3,
                                                                                                  bq1m, 4, bq2m, 5,
                                                                                                  bq3m, 6, bq4m, berm),
             3, DECODE(an_ntype, 2, cedm, 3, cq1m, 4, cq2m, 5, cq3m, 6, cq4m, cerm), 4, DECODE(
                                                                                         an_ntype, 2, dedm, 3, dq1m, 4,
                                                                                         dq2m, 5, dq3m, 6, dq4m, derm),
             DECODE(an_ntype, 2, edm, 3, q1m, 4, q2m, 5, q3m, 6, q4m, erm)) IS NOT NULL
            OR DECODE(
                an_zone, 1, DECODE(an_ntype, 2, aed, 3, aq1, 4, aq2, 5, aq3, 6, aq4, aer), 2, DECODE(
                                                                                               an_ntype, 2, bed, 3, bq1,
                                                                                               4, bq2, 5, bq3, 6, bq4,
                                                                                               ber), 3, DECODE(
                                                                                                         an_ntype, 2,
                                                                                                         ced, 3, cq1, 4,
                                                                                                         cq2, 5, cq3, 6,
                                                                                                         cq4, cer), 4,
                DECODE(an_ntype, 2, ded, 3, dq1, 4, dq2, 5, dq3, 6, dq4, der), DECODE(
                                                                                an_ntype, 2, ed, 3, q1, 4, q2, 5, q3, 6,
                                                                                q4, er)) IS NOT NULL);
   END IF;
  ELSE ---MONTHSORGORG
   IF an_kind = 1 THEN --Показаний
    SELECT MAX(date_time)
      INTO ld_ret
      FROM monthsorg
     WHERE mid = an_mid
       AND date_time < ad_date
       AND DECODE(
            an_zone, 1, DECODE(an_ntype, 2, aedm, 3, aq1m, 4, aq2m, 5, aq3m, 6, aq4m, aerm), 2, DECODE(
                                                                                                 an_ntype, 2, bedm, 3,
                                                                                                 bq1m, 4, bq2m, 5, bq3m,
                                                                                                 6, bq4m, berm), 3,
            DECODE(an_ntype, 2, cedm, 3, cq1m, 4, cq2m, 5, cq3m, 6, cq4m, cerm), 4, DECODE(
                                                                                     an_ntype, 2, dedm, 3, dq1m, 4,
                                                                                     dq2m, 5, dq3m, 6, dq4m, derm),
            DECODE(an_ntype, 2, edm, 3, q1m, 4, q2m, 5, q3m, 6, q4m, erm)) IS NOT NULL;
   ELSIF an_kind = 2 THEN --Расхода
    SELECT MAX(date_time)
      INTO ld_ret
      FROM monthsorg
     WHERE mid = an_mid
       AND date_time < ad_date
       AND DECODE(
            an_zone, 1, DECODE(an_ntype, 2, aed, 3, aq1, 4, aq2, 5, aq3, 6, aq4, aer), 2, DECODE(
                                                                                           an_ntype, 2, bed, 3, bq1, 4,
                                                                                           bq2, 5, bq3, 6, bq4, ber), 3,
            DECODE(an_ntype, 2, ced, 3, cq1, 4, cq2, 5, cq3, 6, cq4, cer), 4, DECODE(
                                                                               an_ntype, 2, ded, 3, dq1, 4, dq2, 5, dq3,
                                                                               6, dq4, der), DECODE(
                                                                                              an_ntype, 2, ed, 3, q1, 4,
                                                                                              q2, 5, q3, 6, q4, er)) IS NOT NULL;
   ELSE --Записей
    SELECT MAX(date_time)
      INTO ld_ret
      FROM monthsorg
     WHERE mid = an_mid
       AND date_time < ad_date
       AND (   DECODE(
             an_zone, 1, DECODE(an_ntype, 2, aedm, 3, aq1m, 4, aq2m, 5, aq3m, 6, aq4m, aerm), 2, DECODE(
                                                                                                  an_ntype, 2, bedm, 3,
                                                                                                  bq1m, 4, bq2m, 5,
                                                                                                  bq3m, 6, bq4m, berm),
             3, DECODE(an_ntype, 2, cedm, 3, cq1m, 4, cq2m, 5, cq3m, 6, cq4m, cerm), 4, DECODE(
                                                                                         an_ntype, 2, dedm, 3, dq1m, 4,
                                                                                         dq2m, 5, dq3m, 6, dq4m, derm),
             DECODE(an_ntype, 2, edm, 3, q1m, 4, q2m, 5, q3m, 6, q4m, erm)) IS NOT NULL
            OR DECODE(
                an_zone, 1, DECODE(an_ntype, 2, aed, 3, aq1, 4, aq2, 5, aq3, 6, aq4, aer), 2, DECODE(
                                                                                               an_ntype, 2, bed, 3, bq1,
                                                                                               4, bq2, 5, bq3, 6, bq4,
                                                                                               ber), 3, DECODE(
                                                                                                         an_ntype, 2,
                                                                                                         ced, 3, cq1, 4,
                                                                                                         cq2, 5, cq3, 6,
                                                                                                         cq4, cer), 4,
                DECODE(an_ntype, 2, ded, 3, dq1, 4, dq2, 5, dq3, 6, dq4, der), DECODE(
                                                                                an_ntype, 2, ed, 3, q1, 4, q2, 5, q3, 6,
                                                                                q4, er)) IS NOT NULL);
   END IF;
  END IF;
  RETURN ld_ret;
 END;
 ------------------------------------------------------------------------------------------------------------------------
   -- Дата следующих (показаний an_kind=1 или расхода an_kind=2 иначе записи)
 FUNCTION getnextdate(
  an_mid   NUMBER,
  ad_date  DATE,
  an_ntype NUMBER,
  an_zone  NUMBER,
  an_table NUMBER, -- an_table =1 BILL,=2 HALFHOUR,=3 PROFILE иначе MONTHSORG
  an_kind  NUMBER)
  RETURN DATE IS
  ld_ret DATE;
 BEGIN
  IF an_table = 1 THEN --BILL
   IF an_kind = 1 THEN --Показаний
    SELECT MIN(date_time)
      INTO ld_ret
      FROM bill
     WHERE mid = an_mid
       AND date_time > ad_date
       AND DECODE(
            an_zone, 1, DECODE(an_ntype, 2, aedm, 3, aq1m, 4, aq2m, 5, aq3m, 6, aq4m, aerm), 2, DECODE(
                                                                                                 an_ntype, 2, bedm, 3,
                                                                                                 bq1m, 4, bq2m, 5, bq3m,
                                                                                                 6, bq4m, berm), 3,
            DECODE(an_ntype, 2, cedm, 3, cq1m, 4, cq2m, 5, cq3m, 6, cq4m, cerm), 4, DECODE(
                                                                                     an_ntype, 2, dedm, 3, dq1m, 4,
                                                                                     dq2m, 5, dq3m, 6, dq4m, derm),
            DECODE(an_ntype, 2, edm, 3, q1m, 4, q2m, 5, q3m, 6, q4m, erm)) IS NOT NULL;
   ELSIF an_kind = 2 THEN --Расхода
    SELECT MIN(date_time)
      INTO ld_ret
      FROM bill
     WHERE mid = an_mid
       AND date_time > ad_date
       AND DECODE(
            an_zone, 1, DECODE(an_ntype, 2, aed, 3, aq1, 4, aq2, 5, aq3, 6, aq4, aer), 2, DECODE(
                                                                                           an_ntype, 2, bed, 3, bq1, 4,
                                                                                           bq2, 5, bq3, 6, bq4, ber), 3,
            DECODE(an_ntype, 2, ced, 3, cq1, 4, cq2, 5, cq3, 6, cq4, cer), 4, DECODE(
                                                                               an_ntype, 2, ded, 3, dq1, 4, dq2, 5, dq3,
                                                                               6, dq4, der), DECODE(
                                                                                              an_ntype, 2, ed, 3, q1, 4,
                                                                                              q2, 5, q3, 6, q4, er)) IS NOT NULL;
   ELSE --Записей
    SELECT MIN(date_time)
      INTO ld_ret
      FROM bill
     WHERE mid = an_mid
       AND date_time > ad_date
       AND (   DECODE(
             an_zone, 1, DECODE(an_ntype, 2, aedm, 3, aq1m, 4, aq2m, 5, aq3m, 6, aq4m, aerm), 2, DECODE(
                                                                                                  an_ntype, 2, bedm, 3,
                                                                                                  bq1m, 4, bq2m, 5,
                                                                                                  bq3m, 6, bq4m, berm),
             3, DECODE(an_ntype, 2, cedm, 3, cq1m, 4, cq2m, 5, cq3m, 6, cq4m, cerm), 4, DECODE(
                                                                                         an_ntype, 2, dedm, 3, dq1m, 4,
                                                                                         dq2m, 5, dq3m, 6, dq4m, derm),
             DECODE(an_ntype, 2, edm, 3, q1m, 4, q2m, 5, q3m, 6, q4m, erm)) IS NOT NULL
            OR DECODE(
                an_zone, 1, DECODE(an_ntype, 2, aed, 3, aq1, 4, aq2, 5, aq3, 6, aq4, aer), 2, DECODE(
                                                                                               an_ntype, 2, bed, 3, bq1,
                                                                                               4, bq2, 5, bq3, 6, bq4,
                                                                                               ber), 3, DECODE(
                                                                                                         an_ntype, 2,
                                                                                                         ced, 3, cq1, 4,
                                                                                                         cq2, 5, cq3, 6,
                                                                                                         cq4, cer), 4,
                DECODE(an_ntype, 2, ded, 3, dq1, 4, dq2, 5, dq3, 6, dq4, der), DECODE(
                                                                                an_ntype, 2, ed, 3, q1, 4, q2, 5, q3, 6,
                                                                                q4, er)) IS NOT NULL);
   END IF;
  ELSIF an_table = 2 THEN --HALFHOUR
   IF an_kind = 1 THEN --Показаний
    SELECT MIN(date_time)
      INTO ld_ret
      FROM halfhour
     WHERE mid = an_mid
       AND date_time > ad_date
       AND DECODE(an_ntype, 2, edm, 3, q1m, 4, q2m, 5, q3m, 6, q4m, erm) IS NOT NULL;
   ELSIF an_kind = 2 THEN --Расхода
    SELECT MIN(date_time)
      INTO ld_ret
      FROM halfhour
     WHERE mid = an_mid AND date_time > ad_date AND DECODE(an_ntype, 2, ed, 3, q1, 4, q2, 5, q3, 6, q4, er) IS NOT NULL;
   ELSE --Записей
    SELECT MIN(date_time)
      INTO ld_ret
      FROM halfhour
     WHERE mid = an_mid
       AND date_time > ad_date
       AND (   DECODE(an_ntype, 2, edm, 3, q1m, 4, q2m, 5, q3m, 6, q4m, erm) IS NOT NULL
            OR DECODE(an_ntype, 2, ed, 3, q1, 4, q2, 5, q3, 6, q4, er) IS NOT NULL);
   END IF;
  ELSIF an_table = 3 THEN --PROFILE
   IF an_kind = 1 THEN --Показаний
    SELECT MIN(date_time)
      INTO ld_ret
      FROM PROFILE
     WHERE mid = an_mid
       AND date_time > ad_date
       AND DECODE(an_ntype, 2, edm, 3, q1m, 4, q2m, 5, q3m, 6, q4m, erm) IS NOT NULL;
   ELSIF an_kind = 2 THEN --Расхода
    SELECT MIN(date_time)
      INTO ld_ret
      FROM PROFILE
     WHERE mid = an_mid AND date_time > ad_date AND DECODE(an_ntype, 2, ed, 3, q1, 4, q2, 5, q3, 6, q4, er) IS NOT NULL;
   ELSE --Записей
    SELECT MIN(date_time)
      INTO ld_ret
      FROM PROFILE
     WHERE mid = an_mid
       AND date_time > ad_date
       AND (   DECODE(an_ntype, 2, edm, 3, q1m, 4, q2m, 5, q3m, 6, q4m, erm) IS NOT NULL
            OR DECODE(an_ntype, 2, ed, 3, q1, 4, q2, 5, q3, 6, q4, er) IS NOT NULL);
   END IF;
  ELSIF an_table = 5 THEN --BILLORG
   IF an_kind = 1 THEN --Показаний
    SELECT MIN(date_time)
      INTO ld_ret
      FROM billorg
     WHERE mid = an_mid
       AND date_time > ad_date
       AND DECODE(
            an_zone, 1, DECODE(an_ntype, 2, aedm, 3, aq1m, 4, aq2m, 5, aq3m, 6, aq4m, aerm), 2, DECODE(
                                                                                                 an_ntype, 2, bedm, 3,
                                                                                                 bq1m, 4, bq2m, 5, bq3m,
                                                                                                 6, bq4m, berm), 3,
            DECODE(an_ntype, 2, cedm, 3, cq1m, 4, cq2m, 5, cq3m, 6, cq4m, cerm), 4, DECODE(
                                                                                     an_ntype, 2, dedm, 3, dq1m, 4,
                                                                                     dq2m, 5, dq3m, 6, dq4m, derm),
            DECODE(an_ntype, 2, edm, 3, q1m, 4, q2m, 5, q3m, 6, q4m, erm)) IS NOT NULL;
   ELSIF an_kind = 2 THEN --Расхода
    SELECT MIN(date_time)
      INTO ld_ret
      FROM billorg
     WHERE mid = an_mid
       AND date_time > ad_date
       AND DECODE(
            an_zone, 1, DECODE(an_ntype, 2, aed, 3, aq1, 4, aq2, 5, aq3, 6, aq4, aer), 2, DECODE(
                                                                                           an_ntype, 2, bed, 3, bq1, 4,
                                                                                           bq2, 5, bq3, 6, bq4, ber), 3,
            DECODE(an_ntype, 2, ced, 3, cq1, 4, cq2, 5, cq3, 6, cq4, cer), 4, DECODE(
                                                                               an_ntype, 2, ded, 3, dq1, 4, dq2, 5, dq3,
                                                                               6, dq4, der), DECODE(
                                                                                              an_ntype, 2, ed, 3, q1, 4,
                                                                                              q2, 5, q3, 6, q4, er)) IS NOT NULL;
   ELSE --Записей
    SELECT MIN(date_time)
      INTO ld_ret
      FROM billorg
     WHERE mid = an_mid
       AND date_time > ad_date
       AND (   DECODE(
             an_zone, 1, DECODE(an_ntype, 2, aedm, 3, aq1m, 4, aq2m, 5, aq3m, 6, aq4m, aerm), 2, DECODE(
                                                                                                  an_ntype, 2, bedm, 3,
                                                                                                  bq1m, 4, bq2m, 5,
                                                                                                  bq3m, 6, bq4m, berm),
             3, DECODE(an_ntype, 2, cedm, 3, cq1m, 4, cq2m, 5, cq3m, 6, cq4m, cerm), 4, DECODE(
                                                                                         an_ntype, 2, dedm, 3, dq1m, 4,
                                                                                         dq2m, 5, dq3m, 6, dq4m, derm),
             DECODE(an_ntype, 2, edm, 3, q1m, 4, q2m, 5, q3m, 6, q4m, erm)) IS NOT NULL
            OR DECODE(
                an_zone, 1, DECODE(an_ntype, 2, aed, 3, aq1, 4, aq2, 5, aq3, 6, aq4, aer), 2, DECODE(
                                                                                               an_ntype, 2, bed, 3, bq1,
                                                                                               4, bq2, 5, bq3, 6, bq4,
                                                                                               ber), 3, DECODE(
                                                                                                         an_ntype, 2,
                                                                                                         ced, 3, cq1, 4,
                                                                                                         cq2, 5, cq3, 6,
                                                                                                         cq4, cer), 4,
                DECODE(an_ntype, 2, ded, 3, dq1, 4, dq2, 5, dq3, 6, dq4, der), DECODE(
                                                                                an_ntype, 2, ed, 3, q1, 4, q2, 5, q3, 6,
                                                                                q4, er)) IS NOT NULL);
   END IF;
  ELSE ---MONTHSORG
   IF an_kind = 1 THEN --Показаний
    SELECT MIN(date_time)
      INTO ld_ret
      FROM monthsorg
     WHERE mid = an_mid
       AND date_time > ad_date
       AND DECODE(
            an_zone, 1, DECODE(an_ntype, 2, aedm, 3, aq1m, 4, aq2m, 5, aq3m, 6, aq4m, aerm), 2, DECODE(
                                                                                                 an_ntype, 2, bedm, 3,
                                                                                                 bq1m, 4, bq2m, 5, bq3m,
                                                                                                 6, bq4m, berm), 3,
            DECODE(an_ntype, 2, cedm, 3, cq1m, 4, cq2m, 5, cq3m, 6, cq4m, cerm), 4, DECODE(
                                                                                     an_ntype, 2, dedm, 3, dq1m, 4,
                                                                                     dq2m, 5, dq3m, 6, dq4m, derm),
            DECODE(an_ntype, 2, edm, 3, q1m, 4, q2m, 5, q3m, 6, q4m, erm)) IS NOT NULL;
   ELSIF an_kind = 2 THEN --Расхода
    SELECT MIN(date_time)
      INTO ld_ret
      FROM monthsorg
     WHERE mid = an_mid
       AND date_time > ad_date
       AND DECODE(
            an_zone, 1, DECODE(an_ntype, 2, aed, 3, aq1, 4, aq2, 5, aq3, 6, aq4, aer), 2, DECODE(
                                                                                           an_ntype, 2, bed, 3, bq1, 4,
                                                                                           bq2, 5, bq3, 6, bq4, ber), 3,
            DECODE(an_ntype, 2, ced, 3, cq1, 4, cq2, 5, cq3, 6, cq4, cer), 4, DECODE(
                                                                               an_ntype, 2, ded, 3, dq1, 4, dq2, 5, dq3,
                                                                               6, dq4, der), DECODE(
                                                                                              an_ntype, 2, ed, 3, q1, 4,
                                                                                              q2, 5, q3, 6, q4, er)) IS NOT NULL;
   ELSE --Записей
    SELECT MIN(date_time)
      INTO ld_ret
      FROM monthsorg
     WHERE mid = an_mid
       AND date_time > ad_date
       AND (   DECODE(
             an_zone, 1, DECODE(an_ntype, 2, aedm, 3, aq1m, 4, aq2m, 5, aq3m, 6, aq4m, aerm), 2, DECODE(
                                                                                                  an_ntype, 2, bedm, 3,
                                                                                                  bq1m, 4, bq2m, 5,
                                                                                                  bq3m, 6, bq4m, berm),
             3, DECODE(an_ntype, 2, cedm, 3, cq1m, 4, cq2m, 5, cq3m, 6, cq4m, cerm), 4, DECODE(
                                                                                         an_ntype, 2, dedm, 3, dq1m, 4,
                                                                                         dq2m, 5, dq3m, 6, dq4m, derm),
             DECODE(an_ntype, 2, edm, 3, q1m, 4, q2m, 5, q3m, 6, q4m, erm)) IS NOT NULL
            OR DECODE(
                an_zone, 1, DECODE(an_ntype, 2, aed, 3, aq1, 4, aq2, 5, aq3, 6, aq4, aer), 2, DECODE(
                                                                                               an_ntype, 2, bed, 3, bq1,
                                                                                               4, bq2, 5, bq3, 6, bq4,
                                                                                               ber), 3, DECODE(
                                                                                                         an_ntype, 2,
                                                                                                         ced, 3, cq1, 4,
                                                                                                         cq2, 5, cq3, 6,
                                                                                                         cq4, cer), 4,
                DECODE(an_ntype, 2, ded, 3, dq1, 4, dq2, 5, dq3, 6, dq4, der), DECODE(
                                                                                an_ntype, 2, ed, 3, q1, 4, q2, 5, q3, 6,
                                                                                q4, er)) IS NOT NULL);
   END IF;
  END IF;
  RETURN ld_ret;
 END;
 ------------------------------------------------------------------------------------------------------------------------
   -- Последние показания
 FUNCTION getlastindic(an_mid NUMBER, ad_date DATE, an_ntype NUMBER, an_zone NUMBER, an_table NUMBER) -- an_table =1 BILL,=2 HALFHOUR,=3 PROFILE иначе MONTHSORG
  RETURN NUMBER IS
  ln_ret  NUMBER;
  ld_date DATE;
 BEGIN
  ld_date := getlastdate(an_mid, ad_date, an_ntype, NULL /*an_zone*/, an_table, 1);
  IF ld_date IS NULL THEN
   RETURN NULL;
  END IF;
  IF an_table = 1 THEN --BILL
   SELECT DECODE(
           an_zone, 1, DECODE(an_ntype, 2, aedm, 3, aq1m, 4, aq2m, 5, aq3m, 6, aq4m, aerm), 2, DECODE(
                                                                                                an_ntype, 2, bedm, 3,
                                                                                                bq1m, 4, bq2m, 5, bq3m,
                                                                                                6, bq4m, berm), 3,
           DECODE(an_ntype, 2, cedm, 3, cq1m, 4, cq2m, 5, cq3m, 6, cq4m, cerm), 4, DECODE(
                                                                                    an_ntype, 2, dedm, 3, dq1m, 4, dq2m,
                                                                                    5, dq3m, 6, dq4m, derm),
           DECODE(an_ntype, 2, edm, 3, q1m, 4, q2m, 5, q3m, 6, q4m, erm))
     INTO ln_ret
     FROM bill
    WHERE mid = an_mid AND date_time = ld_date;
  ELSIF an_table = 5 THEN --BILLORG
   SELECT DECODE(
           an_zone, 1, DECODE(an_ntype, 2, aedm, 3, aq1m, 4, aq2m, 5, aq3m, 6, aq4m, aerm), 2, DECODE(
                                                                                                an_ntype, 2, bedm, 3,
                                                                                                bq1m, 4, bq2m, 5, bq3m,
                                                                                                6, bq4m, berm), 3,
           DECODE(an_ntype, 2, cedm, 3, cq1m, 4, cq2m, 5, cq3m, 6, cq4m, cerm), 4, DECODE(
                                                                                    an_ntype, 2, dedm, 3, dq1m, 4, dq2m,
                                                                                    5, dq3m, 6, dq4m, derm),
           DECODE(an_ntype, 2, edm, 3, q1m, 4, q2m, 5, q3m, 6, q4m, erm))
     INTO ln_ret
     FROM billorg
    WHERE mid = an_mid AND date_time = ld_date;
  ELSIF an_table = 2 THEN --HALFHOUR
   SELECT DECODE(an_ntype, 2, edm, 3, q1m, 4, q2m, 5, q3m, 6, q4m, erm)
     INTO ln_ret
     FROM halfhour
    WHERE mid = an_mid AND date_time = ld_date;
  --chig
  ELSIF an_table = man_inp_hhour_code THEN --MAN_INP_HHOUR
   SELECT DECODE(an_ntype, 2, edm, 3, q1m, 4, q2m, 5, q3m, 6, q4m, erm)
     INTO ln_ret
     FROM man_inp_hhour
    WHERE mid = an_mid AND date_time = ld_date;
  --e chig
  ELSIF an_table = 3 THEN --PROFILE
   SELECT DECODE(an_ntype, 2, edm, 3, q1m, 4, q2m, 5, q3m, 6, q4m, erm)
     INTO ln_ret
     FROM PROFILE
    WHERE mid = an_mid AND date_time = ld_date;
  ELSE --MONTHSORG
   SELECT DECODE(
           an_zone, 1, DECODE(an_ntype, 2, aedm, 3, aq1m, 4, aq2m, 5, aq3m, 6, aq4m, aerm), 2, DECODE(
                                                                                                an_ntype, 2, bedm, 3,
                                                                                                bq1m, 4, bq2m, 5, bq3m,
                                                                                                6, bq4m, berm), 3,
           DECODE(an_ntype, 2, cedm, 3, cq1m, 4, cq2m, 5, cq3m, 6, cq4m, cerm), 4, DECODE(
                                                                                    an_ntype, 2, dedm, 3, dq1m, 4, dq2m,
                                                                                    5, dq3m, 6, dq4m, derm),
           DECODE(an_ntype, 2, edm, 3, q1m, 4, q2m, 5, q3m, 6, q4m, erm))
     INTO ln_ret
     FROM monthsorg
    WHERE mid = an_mid AND date_time = ld_date;
  END IF;
  RETURN ln_ret;
 END;
 ------------------------------------------------------------------------------------------------------------------------
   -- Последний расход
 FUNCTION getlastdebit(an_mid NUMBER, ad_date DATE, an_ntype NUMBER, an_zone NUMBER, an_table NUMBER) -- an_table =1 BILL,=2 HALFHOUR,=3 PROFILE иначе MONTHSORG
  RETURN NUMBER IS
  ln_ret  NUMBER;
  ld_date DATE;
 BEGIN
  ld_date := getlastdate(an_mid, ad_date, an_ntype, NULL /*an_zone*/, an_table, 2);
  IF ld_date IS NULL THEN
   RETURN NULL;
  END IF;
  IF an_table = 1 THEN --BILL
   SELECT DECODE(
           an_zone, 1, DECODE(an_ntype, 2, aed, 3, aq1, 4, aq2, 5, aq3, 6, aq4, aer), 2, DECODE(
                                                                                          an_ntype, 2, bed, 3, bq1, 4,
                                                                                          bq2, 5, bq3, 6, bq4, ber), 3,
           DECODE(an_ntype, 2, ced, 3, cq1, 4, cq2, 5, cq3, 6, cq4, cer), 4, DECODE(
                                                                              an_ntype, 2, ded, 3, dq1, 4, dq2, 5, dq3,
                                                                              6, dq4, der), DECODE(
                                                                                             an_ntype, 2, ed, 3, q1, 4,
                                                                                             q2, 5, q3, 6, q4, er))
     INTO ln_ret
     FROM bill
    WHERE mid = an_mid AND date_time = ld_date;
  ELSIF an_table = 5 THEN --BILLORG
   SELECT DECODE(
           an_zone, 1, DECODE(an_ntype, 2, aed, 3, aq1, 4, aq2, 5, aq3, 6, aq4, aer), 2, DECODE(
                                                                                          an_ntype, 2, bed, 3, bq1, 4,
                                                                                          bq2, 5, bq3, 6, bq4, ber), 3,
           DECODE(an_ntype, 2, ced, 3, cq1, 4, cq2, 5, cq3, 6, cq4, cer), 4, DECODE(
                                                                              an_ntype, 2, ded, 3, dq1, 4, dq2, 5, dq3,
                                                                              6, dq4, der), DECODE(
                                                                                             an_ntype, 2, ed, 3, q1, 4,
                                                                                             q2, 5, q3, 6, q4, er))
     INTO ln_ret
     FROM billorg
    WHERE mid = an_mid AND date_time = ld_date;
  ELSIF an_table = 2 THEN --HALFHOUR
   SELECT DECODE(an_ntype, 2, ed, 3, q1, 4, q2, 5, q3, 6, q4, er)
     INTO ln_ret
     FROM halfhour
    WHERE mid = an_mid AND date_time = ld_date;
  ELSIF an_table = 3 THEN --PROFILE
   SELECT DECODE(an_ntype, 2, ed, 3, q1, 4, q2, 5, q3, 6, q4, er)
     INTO ln_ret
     FROM PROFILE
    WHERE mid = an_mid AND date_time = ld_date;
  ELSE --MONTHSORG
   SELECT DECODE(
           an_zone, 1, DECODE(an_ntype, 2, aed, 3, aq1, 4, aq2, 5, aq3, 6, aq4, aer), 2, DECODE(
                                                                                          an_ntype, 2, bed, 3, bq1, 4,
                                                                                          bq2, 5, bq3, 6, bq4, ber), 3,
           DECODE(an_ntype, 2, ced, 3, cq1, 4, cq2, 5, cq3, 6, cq4, cer), 4, DECODE(
                                                                              an_ntype, 2, ded, 3, dq1, 4, dq2, 5, dq3,
                                                                              6, dq4, der), DECODE(
                                                                                             an_ntype, 2, ed, 3, q1, 4,
                                                                                             q2, 5, q3, 6, q4, er))
     INTO ln_ret
     FROM monthsorg
    WHERE mid = an_mid AND date_time = ld_date;
  END IF;
  RETURN ln_ret;
 END;
 ------------------------------------------------------------------------------------------------------------------------
   -- Расход по дате
 FUNCTION getdebit(an_mid NUMBER, ad_date DATE, an_ntype NUMBER, an_zone NUMBER, an_table NUMBER) -- an_table =1 BILL,=2 HALFHOUR,=3 PROFILE иначе MONTHSORG
  RETURN NUMBER IS
  ln_ret NUMBER;
 BEGIN
  IF an_table = 1 THEN --BILL
   SELECT DECODE(
           an_zone, 1, DECODE(an_ntype, 2, aed, 3, aq1, 4, aq2, 5, aq3, 6, aq4, aer), 2, DECODE(
                                                                                          an_ntype, 2, bed, 3, bq1, 4,
                                                                                          bq2, 5, bq3, 6, bq4, ber), 3,
           DECODE(an_ntype, 2, ced, 3, cq1, 4, cq2, 5, cq3, 6, cq4, cer), 4, DECODE(
                                                                              an_ntype, 2, ded, 3, dq1, 4, dq2, 5, dq3,
                                                                              6, dq4, der), DECODE(
                                                                                             an_ntype, 2, ed, 3, q1, 4,
                                                                                             q2, 5, q3, 6, q4, er))
     INTO ln_ret
     FROM bill
    WHERE mid = an_mid AND date_time = ad_date;
  ELSIF an_table = 5 THEN --BILLORG
   SELECT DECODE(
           an_zone, 1, DECODE(an_ntype, 2, aed, 3, aq1, 4, aq2, 5, aq3, 6, aq4, aer), 2, DECODE(
                                                                                          an_ntype, 2, bed, 3, bq1, 4,
                                                                                          bq2, 5, bq3, 6, bq4, ber), 3,
           DECODE(an_ntype, 2, ced, 3, cq1, 4, cq2, 5, cq3, 6, cq4, cer), 4, DECODE(
                                                                              an_ntype, 2, ded, 3, dq1, 4, dq2, 5, dq3,
                                                                              6, dq4, der), DECODE(
                                                                                             an_ntype, 2, ed, 3, q1, 4,
                                                                                             q2, 5, q3, 6, q4, er))
     INTO ln_ret
     FROM billorg
    WHERE mid = an_mid AND date_time = ad_date;
  ELSIF an_table = 2 THEN --HALFHOUR
   SELECT DECODE(an_ntype, 2, ed, 3, q1, 4, q2, 5, q3, 6, q4, er)
     INTO ln_ret
     FROM halfhour
    WHERE mid = an_mid AND date_time = ad_date;
  ELSIF an_table = 3 THEN --PROFILE
   SELECT DECODE(an_ntype, 2, ed, 3, q1, 4, q2, 5, q3, 6, q4, er)
     INTO ln_ret
     FROM PROFILE
    WHERE mid = an_mid AND date_time = ad_date;
  ELSE --MONTHSORG
   SELECT DECODE(
           an_zone, 1, DECODE(an_ntype, 2, aed, 3, aq1, 4, aq2, 5, aq3, 6, aq4, aer), 2, DECODE(
                                                                                          an_ntype, 2, bed, 3, bq1, 4,
                                                                                          bq2, 5, bq3, 6, bq4, ber), 3,
           DECODE(an_ntype, 2, ced, 3, cq1, 4, cq2, 5, cq3, 6, cq4, cer), 4, DECODE(
                                                                              an_ntype, 2, ded, 3, dq1, 4, dq2, 5, dq3,
                                                                              6, dq4, der), DECODE(
                                                                                             an_ntype, 2, ed, 3, q1, 4,
                                                                                             q2, 5, q3, 6, q4, er))
     INTO ln_ret
     FROM monthsorg
    WHERE mid = an_mid AND date_time = ad_date;
  END IF;
  RETURN ln_ret;
 END;
 ------------------------------------------------------------------------------------------------------------------------
 --Ins Upd Del показаний короткая
 PROCEDURE setindic(
  an_mid         NUMBER,
  ad_date        DATE,
  an_ntype       NUMBER,
  an_table       NUMBER, -- an_table =1 BILL,=2 HALFHOUR,=3 PROFILE иначе MONTHSORG
  an_needupdlast NUMBER, -- needupdlast=1, если в случае Upd производит Upd следующего расхода
  av_source      VARCHAR2,
  av_remark      VARCHAR2,
  av_mtrsn       VARCHAR2,
  an_kc          NUMBER,
  an_rm          NUMBER, --показания
  an_r           NUMBER --расход
                       ) IS
  ln_rm      NUMBER         DEFAULT ROUND(an_rm, gn_1);
  ln_r       NUMBER         DEFAULT ROUND(an_r, gn_2);
  ln_next_rm NUMBER; --Следующие показания
  ln_next_r  NUMBER; --Следующие расход
  ld_next_rm DATE; --Дата следующих показаний
  ln_dig     NUMBER;
  ln_handle  INTEGER;
  ln_ret     NUMBER;
  lv_sqlupd  VARCHAR2(2000) DEFAULT 'UPDATE ';
  lv_sqlins  VARCHAR2(2000) DEFAULT 'INSERT INTO ';
  lv_table   VARCHAR2(30);
  lb_det     BOOLEAN        DEFAULT TRUE;
  lv_add     VARCHAR2(10);
  lv_kc      VARCHAR2(200)  DEFAULT NVL(TO_CHAR(an_kc), 'NULL');
  lv_rm      VARCHAR2(200)  DEFAULT NVL(TO_CHAR(ROUND(an_rm, gn_1)), 'NULL');
  lv_r       VARCHAR2(200)  DEFAULT NVL(TO_CHAR(ROUND(an_r, gn_2)), 'NULL');
 BEGIN
  SAVEPOINT setindic_s_sp;
  ln_handle := sys.DBMS_SQL.open_cursor;
  IF an_table = 1 THEN
   lv_table := 'BILL';
  ELSIF an_table = 5 THEN
   lv_table := 'BILLORG';
  ELSIF an_table = 2 THEN
   lv_table := 'HALFHOUR';
   lb_det := FALSE;
  --chig
  ELSIF an_table = man_inp_hhour_code THEN
   lv_table := 'MAN_INP_HHOUR';
   lb_det := FALSE;
  --e
  ELSIF an_table = 3 THEN
   lv_table := 'PROFILE';
   lb_det := FALSE;
  ELSE
   lv_table := 'MONTHSORG';
  END IF;
  IF an_ntype = 2 THEN
   lv_add := 'ed';
  ELSIF an_ntype = 3 THEN
   lv_add := 'q1';
  ELSIF an_ntype = 4 THEN
   lv_add := 'q2';
  ELSIF an_ntype = 5 THEN
   lv_add := 'q3';
  ELSIF an_ntype = 6 THEN
   lv_add := 'q4';
  ELSE
   lv_add := 'er';
  END IF;
  --chig
  IF an_table = man_inp_hhour_code THEN
   lv_sqlins := lv_sqlins || lv_table || '(mid,date_time,' || lv_add || 'm,' || lv_add || ') VALUES(' || an_mid ||
                ',to_date(' || TO_CHAR(ad_date, 'YYYYMMDDHH24MISS') || ',''YYYYMMDDHH24MISS''),' || lv_rm || ',' || lv_r || ')';
   lv_sqlupd := lv_sqlupd || lv_table || ' SET ' || lv_add || 'm=' || lv_rm || ',' || lv_add || '=' || lv_r || ',' ||
                'date_time=to_date(' || TO_CHAR(ad_date, 'YYYYMMDDHH24MISS') || ',''YYYYMMDDHH24MISS'')' || ' where mid=' ||
                an_mid;
   BEGIN
    --Попытка выполнить всавку
    SAVEPOINT do_insert;
    sys.DBMS_SQL.parse(ln_handle, lv_sqlins, sys.DBMS_SQL.native);
    ln_ret := sys.DBMS_SQL.EXECUTE(ln_handle);
   --e Попытка выполнить всавку
   EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
     ROLLBACK TO do_insert;
     sys.DBMS_SQL.parse(ln_handle, lv_sqlupd, sys.DBMS_SQL.native);
     ln_ret := sys.DBMS_SQL.EXECUTE(ln_handle);
   END;
  ELSE
   --e chig
   IF lb_det THEN
    lv_sqlupd := lv_sqlupd || lv_table || ' SET ' || 'source=' || '''' || av_source || ''',' || 'remark=' || '''' || av_remark ||
                 ''',' || lv_add || '_MTRSN=''' || av_mtrsn || ''',' || lv_add || '_KC=' || lv_kc || ',' || lv_add || 'm=' ||
                 lv_rm || ',' || lv_add || '=' || lv_r || ' where mid=' || an_mid || ' and date_time=to_date(' ||
                 TO_CHAR(ad_date, 'YYYYMMDDHH24MISS') || ',''YYYYMMDDHH24MISS'')';
    lv_sqlins := lv_sqlins || lv_table || '(mid,date_time,' || 'source,remark,' || lv_add || '_MTRSN,' || lv_add || '_KC,' ||
                 lv_add || 'm,' || lv_add || ') VALUES(' || an_mid || ',to_date(' || TO_CHAR(
                                                                                      ad_date, 'YYYYMMDDHH24MISS') ||
                 ',''YYYYMMDDHH24MISS''),' || '''' || av_source || ''',''' || av_remark || ''',''' || av_mtrsn || ''',' ||
                 lv_kc || ',' || lv_rm || ',' || lv_r || ')';
   ELSE
    lv_sqlupd := lv_sqlupd || lv_table || ' SET ' || lv_add || 'm=' || lv_rm || ',' || lv_add || '=' || lv_r || ' where mid=' ||
                 an_mid || ' and date_time=to_date(' || TO_CHAR(ad_date, 'YYYYMMDDHH24MISS') || ',''YYYYMMDDHH24MISS'')';
    lv_sqlins := lv_sqlins || lv_table || '(mid,date_time,' || lv_add || 'm,' || lv_add || ') VALUES(' || an_mid ||
                 ',to_date(' || TO_CHAR(ad_date, 'YYYYMMDDHH24MISS') || ',''YYYYMMDDHH24MISS''),' || lv_rm || ',' || lv_r ||
                 ')';
   END IF;
   sys.DBMS_SQL.parse(ln_handle, lv_sqlupd, sys.DBMS_SQL.native);
   IF sys.DBMS_SQL.EXECUTE(ln_handle) = 0 THEN --UPDATE не удался, значит INSERT
    sys.DBMS_SQL.parse(ln_handle, lv_sqlins, sys.DBMS_SQL.native);
    ln_ret := sys.DBMS_SQL.EXECUTE(ln_handle);
   END IF;
   IF an_table = 5 THEN
    calc_hh24(an_mid, ad_date,an_ntype,an_r);
   END IF;
   export_pg.setexport(an_mid, ad_date, an_table);
   IF an_needupdlast = 1 THEN --Необходимо Upd  следующих показаний
    ld_next_rm := getnextdate(an_mid, ad_date, an_ntype, NULL /*an_zone*/, an_table, 1); --Дата след показаний
    IF ld_next_rm IS NOT NULL THEN --Есть следующие показания
     ln_next_rm := getlastindic(an_mid, ld_next_rm + 1 / (24 * 60 * 60), an_ntype, NULL, an_table); --Следующие показания (вычисляем как предыдущие, для их даты+ 1 сек)
     IF ln_rm IS NULL THEN --Если текущие удалили, то для следующих предидущими будут предидущие от текущих
      ln_rm := getlastindic(an_mid, ad_date, an_ntype, NULL, an_table);
     END IF;
     IF ln_rm IS NOT NULL THEN --Замечу, что уже ln_rm is not null и ln_next_rm is not null
      IF ln_next_rm >= ln_rm THEN
       ln_next_r := (ln_next_rm - ln_rm) * NVL(an_kc, 1);
      ELSE
       SELECT MAX(digits)
         INTO ln_dig
         FROM meters
        WHERE mid = an_mid AND DECODE(entype, 7, an_ntype, entype) = an_ntype;
       ln_dig := POWER(10, LENGTH(TRUNC(ln_dig)));
       IF ln_dig IS NULL OR ln_dig <= ln_rm THEN
        ln_dig := POWER(10, LENGTH(TRUNC(ln_rm)));
       END IF;
       ln_next_r := (ln_dig + ln_next_rm - ln_rm) * NVL(an_kc, 1);
      END IF;
     END IF;
     setdebit(an_mid, ld_next_rm, an_ntype, an_table, av_source, av_remark, av_mtrsn, an_kc, ln_next_r);
    END IF;
   END IF;
  --chig
  END IF;
  --e
  sys.DBMS_SQL.close_cursor(ln_handle);
 EXCEPTION
  WHEN OTHERS THEN
   ROLLBACK TO SAVEPOINT setindic_s_sp;
   IF sys.DBMS_SQL.is_open(ln_handle) THEN
    sys.DBMS_SQL.close_cursor(ln_handle);
   END IF;
   raise_application_error(-20001, 'indic_pg.setindic: Ошибка вставки показаний. ' || CHR(10) || SQLERRM(SQLCODE));
 END;
 ------------------------------------------------------------------------------------------------------------------------
 --Ins Upd Del показаний длинная (зоны)
 PROCEDURE setindic(
  an_mid         NUMBER,
  ad_date        DATE,
  an_ntype       NUMBER,
  an_table       NUMBER, -- an_table =1 BILL,=2 HALFHOUR,=3 PROFILE иначе MONTHSORG
  an_needupdlast NUMBER, -- needupdlast=1, если в случае Upd производит Upd следующего расхода
  av_source      VARCHAR2,
  av_remark      VARCHAR2,
  av_mtrsn       VARCHAR2,
  an_kc          NUMBER,
  an_rm          NUMBER, --показания
  an_arm         NUMBER, --показания 1 зона
  an_brm         NUMBER,
  an_crm         NUMBER,
  an_drm         NUMBER,
  an_r           NUMBER, --расход
  an_ar          NUMBER, --расход 1 зона
  an_br          NUMBER,
  an_cr          NUMBER,
  an_dr          NUMBER) IS
  ln_rm       NUMBER         DEFAULT ROUND(an_rm, gn_1);
  ln_r        NUMBER         DEFAULT ROUND(an_r, gn_2);
  ln_arm      NUMBER         DEFAULT ROUND(an_arm, gn_1);
  ln_ar       NUMBER         DEFAULT ROUND(an_ar, gn_2);
  ln_brm      NUMBER         DEFAULT ROUND(an_brm, gn_1);
  ln_br       NUMBER         DEFAULT ROUND(an_br, gn_2);
  ln_crm      NUMBER         DEFAULT ROUND(an_crm, gn_1);
  ln_cr       NUMBER         DEFAULT ROUND(an_cr, gn_2);
  ln_drm      NUMBER         DEFAULT ROUND(an_drm, gn_1);
  ln_dr       NUMBER         DEFAULT ROUND(an_dr, gn_2);
  ln_next_rm  NUMBER; --Следующие показания
  ln_next_r   NUMBER; --Следующие расход
  ln_next_arm NUMBER; --Следующие показания a
  ln_next_ar  NUMBER; --Следующие расход a
  ln_next_brm NUMBER; --Следующие показания b
  ln_next_br  NUMBER; --Следующие расход b
  ln_next_crm NUMBER; --Следующие показания c
  ln_next_cr  NUMBER; --Следующие расход c
  ln_next_drm NUMBER; --Следующие показания d
  ln_next_dr  NUMBER; --Следующие расход d
  ld_next_rm  DATE; --Дата следующих показаний
  ln_dig      NUMBER;
  ln_handle   INTEGER;
  ln_ret      NUMBER;
  lv_sqlupd   VARCHAR2(2000) DEFAULT 'UPDATE ';
  lv_sqlins   VARCHAR2(2000) DEFAULT 'INSERT INTO ';
  lv_table    VARCHAR2(30);
  lv_add      VARCHAR2(10);
  lv_kc       VARCHAR2(200)  DEFAULT NVL(TO_CHAR(an_kc), 'NULL');
  lv_rm       VARCHAR2(200)  DEFAULT NVL(TO_CHAR(ROUND(an_rm, gn_1)), 'NULL');
  lv_r        VARCHAR2(200)  DEFAULT NVL(TO_CHAR(ROUND(an_r, gn_2)), 'NULL');
  lv_arm      VARCHAR2(200)  DEFAULT NVL(TO_CHAR(ROUND(an_arm, gn_1)), 'NULL');
  lv_ar       VARCHAR2(200)  DEFAULT NVL(TO_CHAR(ROUND(an_ar, gn_2)), 'NULL');
  lv_brm      VARCHAR2(200)  DEFAULT NVL(TO_CHAR(ROUND(an_brm, gn_1)), 'NULL');
  lv_br       VARCHAR2(200)  DEFAULT NVL(TO_CHAR(ROUND(an_br, gn_2)), 'NULL');
  lv_crm      VARCHAR2(200)  DEFAULT NVL(TO_CHAR(ROUND(an_crm, gn_1)), 'NULL');
  lv_cr       VARCHAR2(200)  DEFAULT NVL(TO_CHAR(ROUND(an_cr, gn_2)), 'NULL');
  lv_drm      VARCHAR2(200)  DEFAULT NVL(TO_CHAR(ROUND(an_drm, gn_1)), 'NULL');
  lv_dr       VARCHAR2(200)  DEFAULT NVL(TO_CHAR(ROUND(an_dr, gn_2)), 'NULL');
 BEGIN
  SAVEPOINT setindic_l_sp;
  IF an_table IN (2, 3) THEN --Если HALFHOUR или PROFILE то вызываем короткую процедуру
   setindic(an_mid, ad_date, an_ntype, an_table, an_needupdlast, av_source, av_remark, av_mtrsn, an_kc, an_rm, an_r);
   RETURN;
  END IF;
  ln_handle := sys.DBMS_SQL.open_cursor;
  IF an_table = 1 THEN
   lv_table := 'BILL';
  ELSIF an_table = 5 THEN
   lv_table := 'BILLORG';
  ELSE
   lv_table := 'MONTHSORG';
  END IF;
  IF an_ntype = 2 THEN
   lv_add := 'ed';
  ELSIF an_ntype = 3 THEN
   lv_add := 'q1';
  ELSIF an_ntype = 4 THEN
   lv_add := 'q2';
  ELSIF an_ntype = 5 THEN
   lv_add := 'q3';
  ELSIF an_ntype = 6 THEN
   lv_add := 'q4';
  ELSE
   lv_add := 'er';
  END IF;
  lv_sqlupd := lv_sqlupd || lv_table || ' SET ' || 'source=' || '''' || av_source || ''',' || 'remark=' || '''' || av_remark ||
               ''',' || lv_add || '_MTRSN=''' || av_mtrsn || ''',' || lv_add || '_KC=' || lv_kc || ',' || lv_add || 'm=' || lv_rm ||
               ',' || lv_add || '=' || lv_r || ',a' || lv_add || 'm=' || lv_arm || ',a' || lv_add || '=' || lv_ar || ',b' || lv_add ||
               'm=' || lv_brm || ',b' || lv_add || '=' || lv_br || ',c' || lv_add || 'm=' || lv_crm || ',c' || lv_add || '=' ||
               lv_cr || ',d' || lv_add || 'm=' || lv_drm || ',d' || lv_add || '=' || lv_dr || ' where mid=' || an_mid ||
               ' and date_time=to_date(' || TO_CHAR(ad_date, 'YYYYMMDDHH24MISS') || ',''YYYYMMDDHH24MISS'')';
  lv_sqlins := lv_sqlins || lv_table || '(mid,date_time,' || 'source,remark,' || lv_add || '_MTRSN,' || lv_add || '_KC,' ||
               lv_add || 'm,' || lv_add || ',a' || lv_add || 'm,a' || lv_add || ',b' || lv_add || 'm,b' || lv_add || ',c' ||
               lv_add || 'm,c' || lv_add || ',d' || lv_add || 'm,d' || lv_add || ') VALUES(' || an_mid || ',to_date(' ||
               TO_CHAR(ad_date, 'YYYYMMDDHH24MISS') || ',''YYYYMMDDHH24MISS''),' || '''' || av_source || ''',''' || av_remark ||
               ''',''' || av_mtrsn || ''',' || lv_kc || ',' || lv_rm || ',' || lv_r || ',' || lv_arm || ',' || lv_ar || ',' ||
               lv_brm || ',' || lv_br || ',' || lv_crm || ',' || lv_cr || ',' || lv_drm || ',' || lv_dr || ')';
  sys.DBMS_SQL.parse(ln_handle, lv_sqlupd, sys.DBMS_SQL.native);
  IF sys.DBMS_SQL.EXECUTE(ln_handle) = 0 THEN --UPDATE не удался, значит INSERT
   sys.DBMS_SQL.parse(ln_handle, lv_sqlins, sys.DBMS_SQL.native);
   ln_ret := sys.DBMS_SQL.EXECUTE(ln_handle);
  END IF;
  export_pg.setexport(an_mid, ad_date, an_table);
  IF an_needupdlast = 1 THEN --Необходимо Upd  следующих показаний
   ld_next_rm := getnextdate(an_mid, ad_date, an_ntype, NULL /*an_zone*/, an_table, 1); --Дата след показаний
   IF ld_next_rm IS NOT NULL THEN --Есть следующие показания
    ln_next_rm := getlastindic(an_mid, ld_next_rm + 1 / (24 * 60 * 60), an_ntype, NULL, an_table); --Следующие показания (вычисляем как предыдущие, для их даты+ 1 сек)
    ln_next_arm := getlastindic(an_mid, ld_next_rm + 1 / (24 * 60 * 60), an_ntype, 1, an_table); --Следующие показания (вычисляем как предыдущие, для их даты+ 1 сек)
    ln_next_brm := getlastindic(an_mid, ld_next_rm + 1 / (24 * 60 * 60), an_ntype, 2, an_table); --Следующие показания (вычисляем как предыдущие, для их даты+ 1 сек)
    ln_next_crm := getlastindic(an_mid, ld_next_rm + 1 / (24 * 60 * 60), an_ntype, 3, an_table); --Следующие показания (вычисляем как предыдущие, для их даты+ 1 сек)
    ln_next_drm := getlastindic(an_mid, ld_next_rm + 1 / (24 * 60 * 60), an_ntype, 4, an_table); --Следующие показания (вычисляем как предыдущие, для их даты+ 1 сек)
    IF ln_rm IS NULL THEN --Если текущие удалили, то для следующих предидущими будут предидущие от текущих
     ln_rm := getlastindic(an_mid, ad_date, an_ntype, NULL, an_table);
     ln_arm := getlastindic(an_mid, ad_date, an_ntype, 1, an_table);
     ln_brm := getlastindic(an_mid, ad_date, an_ntype, 2, an_table);
     ln_crm := getlastindic(an_mid, ad_date, an_ntype, 3, an_table);
     ln_drm := getlastindic(an_mid, ad_date, an_ntype, 4, an_table);
    END IF;
    IF ln_rm IS NOT NULL THEN --Замечу, что уже ln_rm is not null и ln_next_rm is not null
     SELECT MAX(digits)
       INTO ln_dig
       FROM meters
      WHERE mid = an_mid AND DECODE(entype, 7, an_ntype, entype) = an_ntype;
     ln_dig := POWER(10, LENGTH(TRUNC(ln_dig)));
     IF ln_dig IS NULL OR ln_dig <= ln_rm THEN
      ln_dig := POWER(10, LENGTH(TRUNC(ln_rm)));
     END IF;
     IF ln_next_rm >= ln_rm THEN
      ln_next_r := (ln_next_rm - ln_rm) * NVL(an_kc, 1);
     ELSE
      ln_next_r := (ln_dig + ln_next_rm - ln_rm) * NVL(an_kc, 1);
     END IF;
     IF ln_next_arm >= ln_arm THEN --Зона A
      ln_next_ar := (ln_next_arm - ln_arm) * NVL(an_kc, 1);
     ELSE
      ln_next_ar := (ln_dig + ln_next_arm - ln_arm) * NVL(an_kc, 1);
     END IF;
     IF ln_next_brm >= ln_brm THEN --Зона B
      ln_next_br := (ln_next_brm - ln_brm) * NVL(an_kc, 1);
     ELSE
      ln_next_br := (ln_dig + ln_next_brm - ln_brm) * NVL(an_kc, 1);
     END IF;
     IF ln_next_crm >= ln_crm THEN --Зона C
      ln_next_cr := (ln_next_crm - ln_crm) * NVL(an_kc, 1);
     ELSE
      ln_next_cr := (ln_dig + ln_next_crm - ln_crm) * NVL(an_kc, 1);
     END IF;
     IF ln_next_drm >= ln_drm THEN --Зона D
      ln_next_dr := (ln_next_drm - ln_drm) * NVL(an_kc, 1);
     ELSE
      ln_next_dr := (ln_dig + ln_next_drm - ln_drm) * NVL(an_kc, 1);
     END IF;
    END IF;
    IF ABS(NVL(ln_next_r, 0) - (NVL(ln_next_ar, 0) + NVL(ln_next_br, 0) + NVL(ln_next_cr, 0) + NVL(ln_next_dr, 0))) <= 4 THEN --Разница в расходах <4
     setdebit(
      an_mid, ld_next_rm, an_ntype, an_table, av_source, av_remark, av_mtrsn, an_kc, ln_next_r, ln_next_ar, ln_next_br,
      ln_next_cr, ln_next_dr);
    ELSE --Не трогаем зоны
     setdebit(an_mid, ld_next_rm, an_ntype, an_table, av_source, av_remark, av_mtrsn, an_kc, ln_next_r);
    END IF;
   END IF;
  END IF;
  sys.DBMS_SQL.close_cursor(ln_handle);
 EXCEPTION
  WHEN OTHERS THEN
   ROLLBACK TO SAVEPOINT setindic_l_sp;
   IF sys.DBMS_SQL.is_open(ln_handle) THEN
    sys.DBMS_SQL.close_cursor(ln_handle);
   END IF;
   raise_application_error(-20001, 'indic_pg.setindic: Ошибка вставки показаний. ' || CHR(10) || SQLERRM(SQLCODE));
 END;
 ------------------------------------------------------------------------------------------------------------------------
 --Ins Upd Del расхода короткая
 PROCEDURE setdebit(
  an_mid    NUMBER,
  ad_date   DATE,
  an_ntype  NUMBER,
  an_table  NUMBER, -- an_table =1 BILL,=2 HALFHOUR,=3 PROFILE иначе MONTHSORG
  av_source VARCHAR2,
  av_remark VARCHAR2,
  av_mtrsn  VARCHAR2,
  an_kc     NUMBER,
  an_r      NUMBER --расход
                  ) IS
  ln_r      NUMBER         DEFAULT ROUND(an_r, gn_2);
  ln_handle INTEGER;
  ln_ret    NUMBER;
  lv_sqlupd VARCHAR2(2000) DEFAULT 'UPDATE ';
  lv_sqlins VARCHAR2(2000) DEFAULT 'INSERT INTO ';
  lv_table  VARCHAR2(30);
  lb_det    BOOLEAN        DEFAULT TRUE;
  lv_add    VARCHAR2(10);
  lv_kc     VARCHAR2(200)  DEFAULT NVL(TO_CHAR(an_kc), 'NULL');
  lv_r      VARCHAR2(200)  DEFAULT NVL(TO_CHAR(ROUND(an_r, gn_2)), 'NULL');
 BEGIN
  SAVEPOINT setdebit_s_sp;
  ln_handle := sys.DBMS_SQL.open_cursor;
  IF an_table = 1 THEN
   lv_table := 'BILL';
  ELSIF an_table = 2 THEN
   lv_table := 'HALFHOUR';
   lb_det := FALSE;
  ELSIF an_table = 3 THEN
   lv_table := 'PROFILE';
   lb_det := FALSE;
  ELSIF an_table = 5 THEN
   lv_table := 'BILLORG';
  ELSE
   lv_table := 'MONTHSORG';
  END IF;
  IF an_ntype = 2 THEN
   lv_add := 'ed';
  ELSIF an_ntype = 3 THEN
   lv_add := 'q1';
  ELSIF an_ntype = 4 THEN
   lv_add := 'q2';
  ELSIF an_ntype = 5 THEN
   lv_add := 'q3';
  ELSIF an_ntype = 6 THEN
   lv_add := 'q4';
  ELSE
   lv_add := 'er';
  END IF;
  IF lb_det THEN
   lv_sqlupd := lv_sqlupd || lv_table || ' SET ' || 'source=' || '''' || av_source || ''',' || 'remark=' || '''' || av_remark ||
                ''',' || lv_add || '_MTRSN=''' || av_mtrsn || ''',' || lv_add || '_KC=' || lv_kc || ',' || lv_add || '=' || lv_r ||
                ' where mid=' || an_mid || ' and date_time=to_date(' || TO_CHAR(ad_date, 'YYYYMMDDHH24MISS') ||
                ',''YYYYMMDDHH24MISS'')';
   lv_sqlins := lv_sqlins || lv_table || '(mid,date_time,' || 'source,remark,' || lv_add || '_MTRSN,' || lv_add || '_KC,' ||
                lv_add || ') VALUES(' || an_mid || ',to_date(' || TO_CHAR(ad_date, 'YYYYMMDDHH24MISS') ||
                ',''YYYYMMDDHH24MISS''),' || '''' || av_source || ''',''' || av_remark || ''',''' || av_mtrsn || ''',' ||
                lv_kc || ',' || lv_r || ')';
  ELSE
   lv_sqlupd := lv_sqlupd || lv_table || ' SET ' || lv_add || '=' || lv_r || ' where mid=' || an_mid ||
                ' and date_time=to_date(' || TO_CHAR(ad_date, 'YYYYMMDDHH24MISS') || ',''YYYYMMDDHH24MISS'')';
   lv_sqlins := lv_sqlins || lv_table || '(mid,date_time,' || lv_add || ') VALUES(' || an_mid || ',to_date(' ||
                TO_CHAR(ad_date, 'YYYYMMDDHH24MISS') || ',''YYYYMMDDHH24MISS''),' || lv_r || ')';
  END IF;
  sys.DBMS_SQL.parse(ln_handle, lv_sqlupd, sys.DBMS_SQL.native);
  IF sys.DBMS_SQL.EXECUTE(ln_handle) = 0 THEN --UPDATE не удался, значит INSERT
   sys.DBMS_SQL.parse(ln_handle, lv_sqlins, sys.DBMS_SQL.native);
   ln_ret := sys.DBMS_SQL.EXECUTE(ln_handle);
  END IF;
  IF an_table = 5 THEN
   calc_hh24_equal(an_mid, ad_date,an_ntype,an_r);
  END IF;
  export_pg.setexport(an_mid, ad_date, an_table);
  sys.DBMS_SQL.close_cursor(ln_handle);
 EXCEPTION
  WHEN OTHERS THEN
   ROLLBACK TO SAVEPOINT setdebit_s_sp;
   IF sys.DBMS_SQL.is_open(ln_handle) THEN
    sys.DBMS_SQL.close_cursor(ln_handle);
   END IF;
   raise_application_error(-20001, 'indic_pg.setdebit: Ошибка вставки расхода. ' || CHR(10) || SQLERRM(SQLCODE));
 END;
 ------------------------------------------------------------------------------------------------------------------------
 --Ins Upd Del расхода длинная (зоны)
 PROCEDURE setdebit(
  an_mid    NUMBER,
  ad_date   DATE,
  an_ntype  NUMBER,
  an_table  NUMBER, -- an_table =1 BILL,=2 HALFHOUR,=3 PROFILE иначе MONTHSORG
  av_source VARCHAR2,
  av_remark VARCHAR2,
  av_mtrsn  VARCHAR2,
  an_kc     NUMBER,
  an_r      NUMBER, --расход
  an_ar     NUMBER, --расход 1 зона
  an_br     NUMBER,
  an_cr     NUMBER,
  an_dr     NUMBER) IS
  ln_r      NUMBER         DEFAULT ROUND(an_r, gn_2);
  ln_ar     NUMBER         DEFAULT ROUND(an_ar, gn_2);
  ln_br     NUMBER         DEFAULT ROUND(an_br, gn_2);
  ln_cr     NUMBER         DEFAULT ROUND(an_cr, gn_2);
  ln_dr     NUMBER         DEFAULT ROUND(an_dr, gn_2);
  ln_handle INTEGER;
  ln_ret    NUMBER;
  lv_sqlupd VARCHAR2(2000) DEFAULT 'UPDATE ';
  lv_sqlins VARCHAR2(2000) DEFAULT 'INSERT INTO ';
  lv_table  VARCHAR2(30);
  lv_add    VARCHAR2(10);
  lv_kc     VARCHAR2(200)  DEFAULT NVL(TO_CHAR(an_kc), 'NULL');
  lv_r      VARCHAR2(200)  DEFAULT NVL(TO_CHAR(ROUND(an_r, gn_2)), 'NULL');
  lv_ar     VARCHAR2(200)  DEFAULT NVL(TO_CHAR(ROUND(an_ar, gn_2)), 'NULL');
  lv_br     VARCHAR2(200)  DEFAULT NVL(TO_CHAR(ROUND(an_br, gn_2)), 'NULL');
  lv_cr     VARCHAR2(200)  DEFAULT NVL(TO_CHAR(ROUND(an_cr, gn_2)), 'NULL');
  lv_dr     VARCHAR2(200)  DEFAULT NVL(TO_CHAR(ROUND(an_dr, gn_2)), 'NULL');
 BEGIN
  SAVEPOINT setdebit_l_sp;
  IF an_table IN (2, 3) THEN --Если HALFHOUR или PROFILE то вызываем короткую процедуру
   setdebit(an_mid, ad_date, an_ntype, an_table, av_source, av_remark, av_mtrsn, an_kc, an_r);
   RETURN;
  END IF;
  ln_handle := sys.DBMS_SQL.open_cursor;
  IF an_table = 1 THEN
   lv_table := 'BILL';
  ELSIF an_table = 5 THEN
   lv_table := 'BILLORG';
  ELSE
   lv_table := 'MONTHSORG';
  END IF;
  IF an_ntype = 2 THEN
   lv_add := 'ed';
  ELSIF an_ntype = 3 THEN
   lv_add := 'q1';
  ELSIF an_ntype = 4 THEN
   lv_add := 'q2';
  ELSIF an_ntype = 5 THEN
   lv_add := 'q3';
  ELSIF an_ntype = 6 THEN
   lv_add := 'q4';
  ELSE
   lv_add := 'er';
  END IF;
  lv_sqlupd := lv_sqlupd || lv_table || ' SET ' || 'source=' || '''' || av_source || ''',' || 'remark=' || '''' || av_remark ||
               ''',' || lv_add || '_MTRSN=''' || av_mtrsn || ''',' || lv_add || '_KC=' || lv_kc || ',' || lv_add || '=' || lv_r ||
               ',a' || lv_add || '=' || lv_ar || ',b' || lv_add || '=' || lv_br || ',c' || lv_add || '=' || lv_cr || ',d' || lv_add ||
               '=' || lv_dr || ' where mid=' || an_mid || ' and date_time=to_date(' || TO_CHAR(
                                                                                        ad_date, 'YYYYMMDDHH24MISS') ||
               ',''YYYYMMDDHH24MISS'')';
  lv_sqlins := lv_sqlins || lv_table || '(mid,date_time,' || 'source,remark,' || lv_add || '_MTRSN,' || lv_add || '_KC,' ||
               lv_add || ',a' || lv_add || ',b' || lv_add || ',c' || lv_add || ',d' || lv_add || ') VALUES(' || an_mid ||
               ',to_date(' || TO_CHAR(ad_date, 'YYYYMMDDHH24MISS') || ',''YYYYMMDDHH24MISS''),' || '''' || av_source ||
               ''',''' || av_remark || ''',''' || av_mtrsn || ''',' || lv_kc || ',' || lv_r || ',' || lv_ar || ',' || lv_br || ',' ||
               lv_cr || ',' || lv_dr || ')';
  sys.DBMS_SQL.parse(ln_handle, lv_sqlupd, sys.DBMS_SQL.native);
  IF sys.DBMS_SQL.EXECUTE(ln_handle) = 0 THEN --UPDATE не удался, значит INSERT
   sys.DBMS_SQL.parse(ln_handle, lv_sqlins, sys.DBMS_SQL.native);
   ln_ret := sys.DBMS_SQL.EXECUTE(ln_handle);
  END IF;
  export_pg.setexport(an_mid, ad_date, an_table);
  sys.DBMS_SQL.close_cursor(ln_handle);
 EXCEPTION
  WHEN OTHERS THEN
   ROLLBACK TO SAVEPOINT setdebit_l_sp;
   IF sys.DBMS_SQL.is_open(ln_handle) THEN
    sys.DBMS_SQL.close_cursor(ln_handle);
   END IF;
   raise_application_error(-20001, 'indic_pg.setdebit: Ошибка вставки расхода. ' || CHR(10) || SQLERRM(SQLCODE));
 END;
 ------------------------------------------------------------------------------------------------------------------------
 PROCEDURE setpower(an_mid NUMBER, ad_date DATE, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER) IS
 --Только для 15 минуток
 BEGIN
  UPDATE curr_power
     SET date_time = SYSDATE,
         er = NVL(4 * an_er, er),
         ed = NVL(4 * an_ed, ed),
         q1 = NVL(4 * an_q1, q1),
         q3 = NVL(4 * an_q3, q3)
   WHERE mid = an_mid;
  IF SQL%ROWCOUNT = 0 THEN
   INSERT INTO curr_power
               (mid, date_time, obsolete, er, ed, q1, q3)
        VALUES (an_mid, SYSDATE, 1, 4 * an_er, 4 * an_ed, 4 * an_q1, 4 * an_q3);
  END IF;
  FOR i IN 0 .. 4 LOOP
   UPDATE PROFILE
      SET er = NVL(an_er / 5, er),
          ed = NVL(an_ed / 5, ed),
          q1 = NVL(an_q1 / 5, q1),
          q3 = NVL(an_q3 / 5, q3)
    WHERE mid = an_mid AND date_time = ad_date - i / 480;
   IF SQL%ROWCOUNT = 0 THEN
    INSERT INTO PROFILE
                (mid, date_time, er, ed, q1, q3)
         VALUES (an_mid, ad_date - i / 480, an_er / 5, an_ed / 5, an_q1 / 5, an_q3 / 5);
   END IF;
  END LOOP;
 END;
------------------------------------------------------------------------------------------------------------------------
 --Возвращает ид группы точек с разбивкой графика поровну
 FUNCTION getoutputgroup
  RETURN NUMBER is
begin
return gn_outputgroup;
end;
------------------------------------------------------------------------------------------------------------------------
BEGIN
 BEGIN
  select to_number(max(vvalue)) into gn_outputgroup from parameter where npid=13;
 EXCEPTION
  when others then
  gn_outputgroup:=NULL;
 END;
END; -- Package Body INDIC_PG
/

-- End of DDL script for INDIC_PG

-- Start of DDL script for LOADCT_PG
-- Generated 27-янв-03  11:34:02 am
-- from oe-RYDA:1

-- Package body LOADCT_PG

CREATE OR REPLACE
PACKAGE BODY loadct_pg IS
 ------------------------------------------------------------------------------------------------------------------------
    -- Интерфейс взаимодействия БД с загрузчиком CT
    -- дата создания 02/12/2001 Сечин А.А.
 ------------------------------------------------------------------------------------------------------------------------

 cn_offset CONSTANT NUMBER := 0;--100000000;
 cn_source   CONSTANT NUMBER := 10;
 ------------------------------------------------------------------------------------------------------------------------
 --Вставка 3-х минуток
 PROCEDURE set_profile(an_mid NUMBER, ad_date DATE, an_er NUMBER) IS
  ln_mid NUMBER DEFAULT util_pg.getpointid(an_mid + cn_offset);
 BEGIN
  IF ln_mid IS NULL THEN
   RETURN;
  END IF;
  UPDATE curr_power
     SET er = an_er,
         obsolete = 0,
         date_time = ad_date
   WHERE mid = ln_mid;
  INSERT INTO PROFILE
              (mid, date_time, er)
       VALUES (ln_mid, ad_date, an_er / 30);
 EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
   UPDATE PROFILE
      SET er = an_er / 30
    WHERE mid = ln_mid AND date_time = ad_date;
  WHEN OTHERS THEN
   RAISE;
 END;
 ------------------------------------------------------------------------------------------------------------------------
  --Вставка графика нагрузки
 PROCEDURE set_halfhour(an_mid NUMBER, ad_date DATE, an_type NUMBER, an_val COMMON_PG.tt_number) IS
  ld_start DATE   DEFAULT TRUNC(ad_date) + 1 / 48;
  i        NUMBER DEFAULT 1;
  ln_mid   NUMBER DEFAULT util_pg.getpointid(an_mid + cn_offset);
 BEGIN
  IF ln_mid IS NULL THEN
   RETURN;
  END IF;
  WHILE  ld_start <= TRUNC(ad_date) + 1 AND i <= an_val.COUNT LOOP
   IF an_type = 1 THEN
    UPDATE halfhourold
       SET er = an_val(i) / 2
     WHERE mid = ln_mid AND date_time = ld_start AND nsource=cn_source;
    IF SQL%ROWCOUNT = 0 THEN
     INSERT INTO halfhourold
                 (mid, date_time, er,nsource)
          VALUES (ln_mid, ld_start, an_val(i) / 2,cn_source);
    END IF;
   ELSIF an_type = 2 THEN
    UPDATE halfhourold
       SET q1 = an_val(i / 2)
     WHERE mid = ln_mid AND date_time = ld_start AND nsource=cn_source;
    IF SQL%ROWCOUNT = 0 THEN
     INSERT INTO halfhourold
                 (mid, date_time, q1,nsource)
          VALUES (ln_mid, ld_start, an_val(i) / 2,cn_source);
    END IF;
   END IF;
   ld_start := ld_start + 1 / 48;
   i := i + 1;
  END LOOP;
 END;
 ------------------------------------------------------------------------------------------------------------------------
  --Вставка суточных
 PROCEDURE set_bill(an_mid NUMBER, ad_date DATE, an_er NUMBER, an_q1 NUMBER) IS
  ln_mid NUMBER DEFAULT util_pg.getpointid(an_mid + cn_offset);
 BEGIN
  IF ln_mid IS NULL THEN
   RETURN;
  END IF;
  UPDATE billorg
     SET er = an_er,
         q1 = an_q1
   WHERE mid = ln_mid AND date_time = ad_date;
  IF SQL%ROWCOUNT = 0 THEN
   INSERT INTO billorg
               (mid, date_time, er, q1)
        VALUES (ln_mid, ad_date, an_er, an_q1);
  END IF;
 END;
 ------------------------------------------------------------------------------------------------------------------------
   --Окончание загрузки
  -- 3-х , получасовки, сутиочные 0 или 1
 PROCEDURE set_signal(av_mask VARCHAR2) IS
 BEGIN
  NULL;
 END;
------------------------------------------------------------------------------------------------------------------------
END; -- Package Body LOADCT_PG
/

-- End of DDL script for LOADCT_PG

-- Start of DDL script for MAKETS_PG
-- Generated 27-янв-03  11:34:02 am
-- from oe-RYDA:1

-- Package body MAKETS_PG

CREATE OR REPLACE
PACKAGE BODY makets_pg IS
   -- пакет работы с точками
   -- дата создания 31/10/2002 (Калак С.С.)
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура вставки макета
 PROCEDURE ins_m(
  an_nprocedure     NUMBER, --ид процедуры
  av_vname          VARCHAR2, --Имя макета
  av_vnote          VARCHAR2, --Коментарий
  an_nblock         NUMBER, --Блокировка
  an_ncycle         NUMBER, --Выполнять невыполненые вовремя
  an_shift          NUMBER, --Сдвиг старта формирования мин
  av_param          VARCHAR2, --Параметр
  an_nmaket     OUT NUMBER --Ид макета
                          ) IS
  ln_mid NUMBER;
 BEGIN
  SELECT makets_seq.NEXTVAL
    INTO ln_mid
    FROM DUAL;
  an_nmaket := ln_mid;
  INSERT INTO makets
              (nmaket, nprocedure, vname, vnote, nblock, ncycle, nshift, vparam)
       VALUES (ln_mid, an_nprocedure, av_vname, av_vnote, an_nblock, an_ncycle, an_shift, av_param);
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'makets_pg.ins_m: Ошибка вставки макета. ' || CHR(10) || SQLERRM(SQLCODE));
 END;
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура вставки группы
 PROCEDURE ins_g(
  an_nmaket     NUMBER, --Ид макета
  av_vcode      VARCHAR2, --Код строки
  av_vname      VARCHAR2, --Имя грруппы
  av_vnote      VARCHAR2, --Коментарий
  an_ngroup OUT NUMBER --Ид группы
                      ) IS
  ln_mid NUMBER;
 BEGIN
  SELECT maketgroups_seq.NEXTVAL
    INTO ln_mid
    FROM DUAL;
  an_ngroup := ln_mid;
  INSERT INTO maketgroups
              (ngroup, nmaket, vcode, vname, vnote)
       VALUES (ln_mid, an_nmaket, av_vcode, av_vname, av_vnote);
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'makets_pg.ins_g: Ошибка вставки группы. ' || CHR(10) || SQLERRM(SQLCODE));
 END;
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура вставки точки
 PROCEDURE chg_p(
  an_ngroup NUMBER, --Ид группы
  an_mid    NUMBER, --Мид точки
  an_nkc    NUMBER, --Коэффициент вхождения
  an_ntype  NUMBER --Тип измерений
                  ) IS
  ln_exists NUMBER;
 BEGIN
  SELECT COUNT(*)
    INTO ln_exists
    FROM DUAL
   WHERE EXISTS( SELECT *
                   FROM maketpoints
                  WHERE mid = an_mid AND ngroup = an_ngroup);
  IF (ln_exists = 0) THEN
   INSERT INTO maketpoints
               (ngroup, mid, nkc, ntype)
        VALUES (an_ngroup, an_mid, an_nkc, an_ntype);
  ELSE
   UPDATE maketpoints
      SET nkc = an_nkc,
          ntype = an_ntype
    WHERE mid = an_mid AND ngroup = an_ngroup;
  END IF;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'makets_pg.chg_p: Ошибка изменения точки. ' || CHR(10) || SQLERRM(SQLCODE));
 END;
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура обновления макета
 PROCEDURE upd_m(
  an_nmaket     NUMBER, --Ид макета
  an_nprocedure NUMBER, --ид процедуры
  av_vname      VARCHAR2, --Имя макета
  av_vnote      VARCHAR2, --Коментарий
  an_nblock     NUMBER, --Блокировка
  an_ncycle     NUMBER, --Выполнять невыполненые вовремя
  an_shift      NUMBER, --Сдвиг старта формирования мин
  av_param      VARCHAR2 --Параметр
                        ) IS
 BEGIN
  UPDATE makets
     SET nprocedure = an_nprocedure,
         vname = av_vname,
         vnote = av_vnote,
         nblock = an_nblock,
         ncycle = an_ncycle,
         nshift = an_shift,
         vparam = av_param
   WHERE nmaket = an_nmaket;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'makets_pg.upd_m: Ошибка обновления макета. ' || CHR(10) || SQLERRM(SQLCODE));
 END;
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура обновления группы
 PROCEDURE upd_g(
  an_ngroup NUMBER, --Ид группы
  an_nmaket NUMBER, --Ид макета
  av_vcode  VARCHAR2, --Код строки
  av_vname  VARCHAR2, --Имя грруппы
  av_vnote  VARCHAR2 --Коментарий
                    ) IS
 BEGIN
  UPDATE maketgroups
     SET nmaket = an_nmaket,
         vcode = av_vcode,
         vname = av_vname,
         vnote = av_vnote
   WHERE ngroup = an_ngroup;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'makets_pg.upd_g: Ошибка обновления группы. ' || CHR(10) || SQLERRM(SQLCODE));
 END;
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура удаления макета
 PROCEDURE del_m(an_nmaket NUMBER --Ид макета
                                 ) IS
 BEGIN
  DELETE FROM makets
        WHERE nmaket = an_nmaket;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'makets_pg.del_m: Ошибка удаления макета. ' || CHR(10) || SQLERRM(SQLCODE));
 END;
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура удаления группы
 PROCEDURE del_g(an_ngroup NUMBER --Ид группы
                                 ) IS
 BEGIN
  DELETE FROM maketgroups
        WHERE ngroup = an_ngroup;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'makets_pg.del_g: Ошибка удаления группы. ' || CHR(10) || SQLERRM(SQLCODE));
 END;
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура удаления точки
 PROCEDURE del_p(an_mid NUMBER, --Ид точки
                               an_ngroup NUMBER --Ид группы
                                               ) IS
 BEGIN
  DELETE FROM maketpoints
        WHERE mid = an_mid AND ngroup = an_ngroup;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'makets_pg.del_p: Ошибка удаления точки. ' || CHR(10) || SQLERRM(SQLCODE));
 END;
------------------------------------------------------------------------------------------------------------------------
END; -- Package Body MAKETS_PG
/

-- End of DDL script for MAKETS_PG

-- Start of DDL script for MAXHOURS_PG
-- Generated 27-янв-03  11:34:02 am
-- from oe-RYDA:1

-- Package body MAXHOURS_PG

CREATE OR REPLACE
PACKAGE BODY maxhours_pg IS
   -- пакет работы с часами макс нагрузки
   -- дата создания 30/07/2002 (Сечин А.А.)
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура вставки
 PROCEDURE ins_p(
  ad_date_time         DATE, --Дата ввода в действие
  ad_morning_start     DATE, --Утро нач
  ad_morning_end       DATE, --Утро кон
  ad_evening_start     DATE, --Вечер нач
  ad_evening_end       DATE, --Вечер кон
  an_maxhour_id    OUT NUMBER --Ид
                             ) IS
  ln_maxhour_id NUMBER;
 BEGIN
  IF    TO_NUMBER(TO_CHAR(ad_morning_start, 'SSSSS')) >= TO_NUMBER(TO_CHAR(ad_morning_end, 'SSSSS'))
     OR TO_NUMBER(TO_CHAR(ad_morning_end, 'SSSSS')) >= TO_NUMBER(TO_CHAR(ad_evening_start, 'SSSSS'))
     OR TO_NUMBER(TO_CHAR(ad_evening_start, 'SSSSS')) >= TO_NUMBER(TO_CHAR(ad_evening_end, 'SSSSS')) THEN
   raise_application_error(-20001, 'Ошибка задания часов нагрузки. Интервалы утреннего и вечернего максимума не должны пересекаться. ');
  END IF;
  SELECT limits_seq.NEXTVAL
    INTO ln_maxhour_id
    FROM DUAL;
  INSERT INTO maxhours
              (maxhour_id, date_time, morning_start, morning_end, evening_start, evening_end)
       VALUES (ln_maxhour_id, ad_date_time,trunc(ad_date_time)+(ad_morning_start-trunc(ad_morning_start)),
                                           trunc(ad_date_time)+(ad_morning_end-trunc(ad_morning_end)),
                                           trunc(ad_date_time)+(ad_evening_start-trunc(ad_evening_start)),
                                           trunc(ad_date_time)+(ad_evening_end-trunc(ad_evening_end)));
  an_maxhour_id := ln_maxhour_id;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(
    -20001, 'maxhours_pg.ins_p: Ошибка добавления часов макс нагрузки. ' || CHR(10) || SQLERRM(SQLCODE));
 END;
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура обновления данных
 PROCEDURE upd_p(
  an_maxhour_id    NUMBER, --Ид
  ad_date_time     DATE, --Дата ввода в действие
  ad_morning_start DATE, --Утро нач
  ad_morning_end   DATE, --Утро кон
  ad_evening_start DATE, --Вечер нач
  ad_evening_end   DATE --Вечер кон
                       ) IS
 BEGIN
  IF    TO_NUMBER(TO_CHAR(ad_morning_start, 'SSSSS')) >= TO_NUMBER(TO_CHAR(ad_morning_end, 'SSSSS'))
     OR TO_NUMBER(TO_CHAR(ad_morning_end, 'SSSSS')) >= TO_NUMBER(TO_CHAR(ad_evening_start, 'SSSSS'))
     OR TO_NUMBER(TO_CHAR(ad_evening_start, 'SSSSS')) >= TO_NUMBER(TO_CHAR(ad_evening_end, 'SSSSS')) THEN
   raise_application_error(-20001, 'Ошибка задания часов нагрузки. Интервалы утреннего и вечернего максимума не должны пересекаться.');
  END IF;
  UPDATE maxhours
     SET date_time = ad_date_time,
         morning_start = trunc(ad_date_time)+(ad_morning_start-trunc(ad_morning_start)),
         morning_end = trunc(ad_date_time)+(ad_morning_end-trunc(ad_morning_end)),
         evening_start = trunc(ad_date_time)+(ad_evening_start-trunc(ad_evening_start)),
         evening_end = trunc(ad_date_time)+(ad_evening_end-trunc(ad_evening_end))
   WHERE maxhour_id = an_maxhour_id;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(
    -20001, 'maxhours_pg.upd_p: Ошибка изменения часов макс нагрузки. ' || CHR(10) || SQLERRM(SQLCODE));
 END;
 ------------------------------------------------------------------------------------------------------------------------
  -- Процедура удаления данных
 PROCEDURE del_p(an_maxhour_id NUMBER --Ид
                                     ) IS
 BEGIN
  DELETE FROM maxhours
        WHERE maxhour_id = an_maxhour_id;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(
    -20001, 'maxhours_pg.del_p: Ошибка удаления часов макс нагрузки. ' || CHR(10) || SQLERRM(SQLCODE));
 END;
------------------------------------------------------------------------------------------------------------------------
END; -- Package Body
/

-- End of DDL script for MAXHOURS_PG

-- Start of DDL script for PLSQL1_PG
-- Generated 27-янв-03  11:34:02 am
-- from oe-RYDA:1

-- Package body PLSQL1_PG

CREATE OR REPLACE
PACKAGE BODY plsql1_pg IS
  ------------------------------------------------------------------------------------------------------------------------
    -- пакет по созданию отчетов в файл
    -- дата создания 27/07/2002 Сечин А.А.
 ------------------------------------------------------------------------------------------------------------------------
 PROCEDURE report89_p(an_maket NUMBER);
 ------------------------------------------------------------------------------------------------------------------------
 PROCEDURE report1_p IS
  CURSOR lcur_sel IS
   SELECT     mid, DECODE(inverted, 'y', 1, 0) inv
         FROM groups
        WHERE mid IS NOT NULL
   CONNECT BY PRIOR gid = parent
   START WITH gid = filereport_pg.gn_group;
  CURSOR lcur_sel1(lc_mid NUMBER, lc_inv NUMBER) IS
   SELECT   TRUNC(
             TO_CHAR(date_time - 1 / 86400, 'SSSSS') / 1800) +
            1 dt,
            SUM(DECODE(lc_inv, 1, -util_pg.sld(mid, NVL(er, 0), NVL(ed, 0)), util_pg.sld(mid, NVL(er, 0), NVL(ed, 0)))) *
            2 er
       FROM halfhour
      WHERE mid = lc_mid AND date_time > filereport_pg.gd_from AND date_time <= filereport_pg.gd_till
   GROUP BY TRUNC(TO_CHAR(date_time - 1 / 86400, 'SSSSS') / 1800);
  lt_er    common_pg.tt_number;
  lv_name  VARCHAR2(2000);
  ln_bill  NUMBER              DEFAULT 0;
  ln_month NUMBER              DEFAULT 0;
  lv_time   VARCHAR2(10);
 BEGIN
  FOR i IN 1 .. 48 LOOP
   lt_er(i) := 0; --null;
  END LOOP;
  FOR lc IN lcur_sel LOOP
   FOR lc1 IN lcur_sel1(lc.mid, lc.inv) LOOP
    IF lc1.er IS NOT NULL THEN
     lt_er(lc1.dt) := NVL(lt_er(lc1.dt), 0) + lc1.er;
     ln_bill := ln_bill + lc1.er / 2;
    END IF;
   END LOOP;
  END LOOP;
  SELECT SUM(
          DECODE(
           g.inverted, 'y', -util_pg.sld(h.mid, NVL(h.er, 0), NVL(h.ed, 0)), util_pg.sld(
                                                                              h.mid, NVL(h.er, 0), NVL(h.ed, 0)))) er
    INTO ln_month
    FROM halfhour h, groups g
   WHERE h.mid = g.mid
     AND h.date_time > TRUNC(filereport_pg.gd_from, 'month')
     AND h.date_time <= filereport_pg.gd_till
     AND g.gid IN (SELECT     gid
                         FROM groups
                        WHERE mid IS NOT NULL
                   CONNECT BY PRIOR gid = parent
                   START WITH gid = filereport_pg.gn_group);
  filereport_pg.put_p('    График нагрузки по группе '|| filereport_pg.gv_name);
  filereport_pg.put_p('      за '|| TO_CHAR(filereport_pg.gd_from, 'DD.MM.YYYY') /*|| ' по ' ||
   TO_CHAR(filereport_pg.gd_till, 'DD.MM.YYYY')*/ || '  МВт ');
  filereport_pg.put_p('');
  filereport_pg.put_p(
   LPAD('Потребление Акт. энергии за сутки ', 51, ' ') ||
   TO_CHAR(ln_bill / 1000, '99999999990.999'));
  filereport_pg.put_p(
   LPAD('Потребление Акт. энергии с начала месяца ', 51, ' ') ||
   TO_CHAR(ln_month / 1000, '99999999990.999'));
  filereport_pg.put_p('');
  filereport_pg.put_p('+'|| LPAD('-', 65, '-') || '+');
  filereport_pg.put_p('| Время |Мощность МВт | Время |Мощность МВт | Время |Мощность МВт  ');
  filereport_pg.put_p('+'|| LPAD('-', 65, '-') || '+');
  FOR i IN 1 .. 16 LOOP
   lv_name := '| ';
   FOR j IN 1 .. 3 LOOP
    IF i=16 AND j=3 THEN
        lv_time := '24:00';
    ELSE
        lv_time := TO_CHAR(TRUNC(SYSDATE) + (16 * (j - 1) + i) / 48, 'HH24:MI');
    END IF;
    lv_name := lv_name || lv_time ||
               ' ' ||
               TO_CHAR(ROUND(lt_er(16 * (j - 1) + i) / 1000, 3), '99999990.999') ||
               ' | ';
   END LOOP;
   filereport_pg.put_p(SUBSTR(lv_name, 1, 100));
  END LOOP;
  filereport_pg.put_p('+'|| LPAD('-', 65, '-') || '+');
 END;
 ------------------------------------------------------------------------------------------------------------------------
 --Трафик сеансов связи
 PROCEDURE report2_p IS
  CURSOR lcur_sel IS
   SELECT   'COM ' || c.com_id com, TO_CHAR(t.dopen, 'dd.mm.yy hh24:mi:ss') dopen,
            ROUND(NVL((NVL(t.dstart, t.dopen) - t.dopen) * 1440 * 60, 0)) nsoed,
            ROUND(NVL((t.dend - NVL(t.dstart, t.dopen)) * 1440 * 60, 0)) nseans,
            ROUND(
             NVL((t.dend - NVL(t.dstart, t.dopen)) * 1440 * 60 + 15, 0)) noplatsek,
            NVL(
             ROUND(
              ((t.dend - NVL(t.dstart, t.dopen)) * 1440 * 60 + 15) * 0.38 /
              100, 2), 0) noplatgrn,
            LPAD(NVL(SUBSTR(c.init_str, 4, 11), ' '), 11, ' ') tel, RPAD(NVL(c.vname, ' '), 31, ' ') canal,
            RPAD(DECODE(TRIM(t.vuser), 'Unnamed user', 'Система', '', 'Система', t.vuser), 12, ' ') inic,
            NVL(t.nsend, 0) nsend, NVL(t.nreceived, 0) nreceived
       FROM ryda.channels c, ryda.traffic t
      WHERE c.cid = t.cid
        AND t.dstart >= filereport_pg.gd_from
        AND com_id IN (3, 4)
        AND t.dend < filereport_pg.gd_till
        AND t.cid IN (SELECT DISTINCT cid
                                 FROM ryda.chanpoint
                                WHERE mid IN (SELECT     mid
                                                    FROM groups
                                              CONNECT BY PRIOR gid = parent
                                              START WITH gid = filereport_pg.gn_group))
   ORDER BY c.com_id, NVL(t.dstart, t.dopen);
  ln_soed      NUMBER DEFAULT 0;
  ln_seans     NUMBER DEFAULT 0;
  ln_oplatsek  NUMBER DEFAULT 0;
  ln_oplatgrn  NUMBER DEFAULT 0;
  ln_send      NUMBER DEFAULT 0;
  ln_received  NUMBER DEFAULT 0;
  ln_asoed     NUMBER DEFAULT 0;
  ln_aseans    NUMBER DEFAULT 0;
  ln_aoplatsek NUMBER DEFAULT 0;
  ln_aoplatgrn NUMBER DEFAULT 0;
  ln_all       NUMBER DEFAULT 134;
 BEGIN
  filereport_pg.put_p('     Трафик сеансов связи по группе '|| filereport_pg.gv_name);
  filereport_pg.put_p(
   ' с '|| TO_CHAR(filereport_pg.gd_from, 'DD.MM.YYYY HH24:MI:SS') || ' по ' ||
   TO_CHAR(filereport_pg.gd_till, 'DD.MM.YYYY HH24:MI:SS'));
  filereport_pg.put_p('');
  filereport_pg.put_p(LPAD('-', ln_all, '-'));
  filereport_pg.put_p(
   ':Порт:      Дата       :Соедине:Сеанс,:К оплате,:К оплате,:Отослано:Принято :  Телефон  : Инициатор  :          Канал                :');
  filereport_pg.put_p(
   ':    :    соединения   :ние,сек: сек  :   сек   :   грн   :        :        :           :            :                               :');
  filereport_pg.put_p(LPAD('-', ln_all, '-'));
  FOR lc IN lcur_sel LOOP
   filereport_pg.put_p(
    lc.com || ':' || lc.dopen || ':' || LPAD(lc.nsoed, 7, ' ') || ':' || LPAD(lc.nseans, 6, ' ') || ':' ||
    LPAD(lc.noplatsek, 9, ' ') || ':' || TO_CHAR(lc.noplatgrn, '99990.99') || ':' || LPAD(lc.nsend, 8, ' ') || ':' ||
    LPAD(lc.nreceived, 8, ' ') || ':' || lc.tel || ':' || lc.inic || ':' || lc.canal || ':');
   ln_soed := ln_soed + lc.nsoed;
   ln_seans := ln_seans + lc.nseans;
   ln_oplatsek := ln_oplatsek + lc.noplatsek;
   ln_oplatgrn := ln_oplatgrn + lc.noplatgrn;
   ln_send := ln_send + lc.nsend;
   ln_received := ln_received + lc.nreceived;
  END LOOP;
  filereport_pg.put_p(LPAD('-', ln_all, '-'));
  filereport_pg.put_p(
   ':                ИТОГО :'|| LPAD(ln_soed, 7, ' ') || ':' || LPAD(ln_seans, 6, ' ') || ':' || LPAD(
                                                                                                  ln_oplatsek, 9, ' ') || ':' ||
   TO_CHAR(ln_oplatgrn, '99990.99') || ':' || LPAD(ln_send, 8, ' ') || ':' || LPAD(ln_received, 8, ' ') ||
   ':                                                        :');
  filereport_pg.put_p(LPAD('-', ln_all, '-'));
 END;
 ------------------------------------------------------------------------------------------------------------------------
 --Отчет LG (профиль)
 PROCEDURE report3_p IS
  CURSOR lcur_sel IS
   SELECT   w.mid mid, w.date_time date_time, w.nsort n, w.vdata data, p.name name, p1.name pname
       FROM lg_loadprof w, points p, points p1
      WHERE w.mid IN (SELECT     mid
                            FROM groups
                      CONNECT BY PRIOR gid = parent
                      START WITH gid = filereport_pg.gn_group)
        AND p.mid(+) = w.mid
        AND w.date_time >= filereport_pg.gd_from
        AND w.date_time <= filereport_pg.gd_till
        AND p.parent = p1.mid
   ORDER BY w.mid, w.date_time, w.nsort;
  ln_curr NUMBER DEFAULT -1;
  ld_curr DATE;
 BEGIN
  filereport_pg.put_p('    Отчет L'|| CHR(38) || 'G (профиль) по группе: ' || filereport_pg.gv_name);
  filereport_pg.put_p(
   '    начиная с '|| TO_CHAR(filereport_pg.gd_from, 'dd.mm.yyyy hh24:mi:ss') || ' по ' ||
   TO_CHAR(filereport_pg.gd_till, 'dd.mm.yyyy hh24:mi:ss'));
  filereport_pg.put_p('');
  FOR lc IN lcur_sel LOOP
   IF lc.mid <> ln_curr OR ld_curr <> lc.date_time THEN
    filereport_pg.put_p(RPAD('-', 80, '-'));
    filereport_pg.put_p('Подстанция:  '|| lc.pname);
    filereport_pg.put_p('Точка:  '|| lc.name);
    filereport_pg.put_p('Дата:   '|| TO_CHAR(lc.date_time, 'dd.mm.yyyy hh24:mi:ss'));
    filereport_pg.put_p(RPAD('-', 80, '-'));
    ln_curr := lc.mid;
    ld_curr := lc.date_time;
   END IF;
   filereport_pg.put_p(lc.data);
  END LOOP;
 END;
 ------------------------------------------------------------------------------------------------------------------------
 --Отчет LG (листинг показаний)
 PROCEDURE report4_p IS
  CURSOR lcur_sel IS
   SELECT   w.mid mid, w.date_time date_time, w.nsort n, w.vdata data, p.name name, p1.name pname
       FROM lg_readout w, points p, points p1
      WHERE w.mid IN (SELECT     mid
                            FROM groups
                      CONNECT BY PRIOR gid = parent
                      START WITH gid = filereport_pg.gn_group)
        AND p.mid(+) = w.mid
        AND w.date_time >= filereport_pg.gd_from
        AND w.date_time <= filereport_pg.gd_till
        AND p1.mid = p.parent
   ORDER BY w.mid, w.date_time, w.nsort;
  ln_curr NUMBER DEFAULT -1;
  ld_curr DATE;
 BEGIN
  filereport_pg.put_p('    Отчет L'|| CHR(38) || 'G (листинг показаний) по группе: ' || filereport_pg.gv_name);
  filereport_pg.put_p(
   '    начиная с '|| TO_CHAR(filereport_pg.gd_from, 'dd.mm.yyyy hh24:mi:ss') || ' по ' ||
   TO_CHAR(filereport_pg.gd_till, 'dd.mm.yyyy hh24:mi:ss'));
  filereport_pg.put_p('');
  FOR lc IN lcur_sel LOOP
   IF lc.mid <> ln_curr OR ld_curr <> lc.date_time THEN
    filereport_pg.put_p(RPAD('-', 80, '-'));
    filereport_pg.put_p('Подстанция:  '|| lc.pname);
    filereport_pg.put_p('Точка:  '|| lc.name);
    filereport_pg.put_p('Дата:   '|| TO_CHAR(lc.date_time, 'dd.mm.yyyy hh24:mi:ss'));
    filereport_pg.put_p(RPAD('-', 80, '-'));
    ln_curr := lc.mid;
    ld_curr := lc.date_time;
   END IF;
   filereport_pg.put_p(lc.data);
  END LOOP;
 END;
  ------------------------------------------------------------------------------------------------------------------------
 --Суточный график потребления активной и реактивной мощности
 PROCEDURE report5_p IS
  CURSOR lcur_select(ld_from DATE) IS
   SELECT   TRUNC(
             TO_CHAR(h.date_time - 1 / 86400, 'SSSSS') / 1800) +
            1 dt,
            SUM(
             DECODE(
              g.inverted, 'y', -util_pg.sld(h.mid, NVL(h.er, 0), NVL(h.ed, 0)), util_pg.sld(
                                                                                 h.mid, NVL(h.er, 0), NVL(h.ed, 0)))) *
            2 / 1000 sumer,
            SUM(
             DECODE(
              g.inverted, 'y', -util_pg.sld(h.mid, NVL(h.q1, 0), NVL(h.q3, 0)), util_pg.sld(
                                                                                 h.mid, NVL(h.q1, 0), NVL(h.q3, 0)))) *
            2 / 1000 sumqq
       FROM halfhour h, groups g
      WHERE h.mid = g.mid
        AND g.gid IN (SELECT     gid
                            FROM groups
                           WHERE mid IS NOT NULL
                      CONNECT BY PRIOR gid = parent
                      START WITH gid = filereport_pg.gn_group)
        AND h.date_time > ld_from
        AND h.date_time <= filereport_pg.gd_till
   GROUP BY TRUNC(
             TO_CHAR(h.date_time - 1 / 86400, 'SSSSS') / 1800);
  lt_er     common_pg.tt_number;
  lt_qq     common_pg.tt_number;
  lv_time   VARCHAR2(10);
  lv_name   VARCHAR2(2000);
  ln_abill  NUMBER              DEFAULT 0;
  ln_qbill  NUMBER              DEFAULT 0;
  ln_amonth NUMBER              DEFAULT 0;
  ln_qmonth NUMBER              DEFAULT 0;
 BEGIN
  filereport_pg.put_p('    Суточный график потребления активной и реактивной мощности по группе '|| filereport_pg.gv_name);
  filereport_pg.put_p(
   '      за '|| TO_CHAR(filereport_pg.gd_from, 'DD.MM.YYYY') || /*' по ' ||
   TO_CHAR(filereport_pg.gd_till, 'DD.MM.YYYY') ||*/ '  МВт ');
  filereport_pg.put_p('');
  FOR i IN 1 .. 48 LOOP
   lt_er(i) := 0; --null;
   lt_qq(i) := 0; --null;
  END LOOP;
  FOR lc IN lcur_select(filereport_pg.gd_from) LOOP
   lt_er(lc.dt) := NVL(lc.sumer, 0);
   lt_qq(lc.dt) := NVL(lc.sumqq, 0);
   ln_abill := ln_abill + lt_er(lc.dt);
   ln_qbill := ln_qbill + lt_qq(lc.dt);
  END LOOP;
  FOR lc IN lcur_select(TRUNC(filereport_pg.gd_from, 'month')) LOOP
   ln_amonth := ln_amonth + NVL(lc.sumer, 0);
   ln_qmonth := ln_qmonth + NVL(lc.sumqq, 0);
  END LOOP;
  filereport_pg.put_p(
   LPAD('Потребление Акт.   энергии за сутки ', 53, ' ') || LPAD(TO_CHAR(ln_abill, '99999999990.999'), 16, ' '));
  filereport_pg.put_p(
   LPAD('Потребление Реакт. энергии за сутки ', 53, ' ') || LPAD(TO_CHAR(ln_qbill, '99999999990.999'), 16, ' '));
  filereport_pg.put_p(
   LPAD('Потребление Акт.   энергии с начала месяца ', 53, ' ') ||
   LPAD(TO_CHAR(ln_amonth, '99999999990.999'), 16, ' '));
  filereport_pg.put_p(
   LPAD('Потребление Реакт. энергии с начала месяца ', 53, ' ') ||
   LPAD(TO_CHAR(ln_qmonth, '99999999990.999'), 16, ' '));
  filereport_pg.put_p('');
  filereport_pg.put_p(LPAD('-', 103, '-'));
  filereport_pg.put_p(
   ' Время      Акт.мощ.    Реакт.мощ. Время      Акт.мощ.    Реакт.мощ. Время      Акт.мощ.    Реакт.мощ.');
  filereport_pg.put_p(LPAD('-', 103, '-'));
  FOR i IN 1 .. 16 LOOP
   lv_name := '';
   FOR j IN 1 .. 3 LOOP
    IF i = 16 AND j = 3 THEN
        lv_time := '24:00';
    ELSE
        lv_time := TO_CHAR(TRUNC(SYSDATE) + (16 * (j - 1) + i) / 48, 'HH24:MI');
    END IF;
    lv_name := lv_name ||
               LPAD(lv_time, 6, ' ') ||
               LPAD(TO_CHAR(ROUND(lt_er(16 * (j - 1) + i), 3), '99999990.999'), 14, ' ') ||
               LPAD(TO_CHAR(ROUND(lt_qq(16 * (j - 1) + i), 3), '99999990.999'), 14, ' ');
   END LOOP;
   filereport_pg.put_p(SUBSTR(lv_name, 1, 103));
  END LOOP;
  filereport_pg.put_p(LPAD('-', 103, '-'));
 END;
 ------------------------------------------------------------------------------------------------------------------------
 --Потребление группы
 PROCEDURE report6_p IS
  CURSOR lcur_sel IS
   SELECT name, gid
     FROM ryda.groups
    WHERE parent = filereport_pg.gn_group;
  CURSOR lcur_sel1(lc_gid NUMBER) IS
SELECT SUM(DECODE(g.inverted, 'y', -util_pg.sld(c.mid, nvl(c.er,0), nvl(c.ed,0)), util_pg.sld(c.mid, nvl(c.er,0), nvl(c.ed,0)))) cnt
     FROM groups g, ryda.halfhour c
    WHERE g.gid IN (SELECT     g1.gid
                          FROM groups g1
                         WHERE g1.mid IS NOT NULL
                    CONNECT BY PRIOR g1.gid = g1.parent
                    START WITH g1.gid = lc_gid)
      AND g.mid = c.mid
      AND c.date_time >= filereport_pg.gd_from
      AND c.date_time <= filereport_pg.gd_till;
  ln_full NUMBER DEFAULT 0;
 BEGIN
  filereport_pg.put_p('    Потребление энергии по группе: '|| filereport_pg.gv_name);
  filereport_pg.put_p(
   '    начиная с '|| TO_CHAR(filereport_pg.gd_from, 'dd.mm.yyyy hh24:mi:ss') || ' по ' ||
   TO_CHAR(filereport_pg.gd_till, 'dd.mm.yyyy hh24:mi:ss'));
  filereport_pg.put_p('');
  filereport_pg.put_p(LPAD('-', 60, '-'));
  filereport_pg.put_p('    Составляющая                 Потребление, [МВт/час]');
  filereport_pg.put_p(LPAD('-', 60, '-'));
  FOR lc IN lcur_sel LOOP
   FOR lc1 IN lcur_sel1(lc.gid) LOOP
    IF lc1.cnt <> 0 THEN
     ln_full := ln_full + lc1.cnt;
     filereport_pg.put_p(RPAD(lc.name, 35, ' ') || LPAD(TO_CHAR(lc1.cnt / 1000, '999999990.999'), 15, ' '));
    ELSE
     filereport_pg.put_p(RPAD(lc.name, 45, ' ') || '*');
    END IF;
   END LOOP;
  END LOOP;
  filereport_pg.put_p(LPAD('-', 60, '-'));
  filereport_pg.put_p('   ИТОГО :                          '|| TO_CHAR(ln_full / 1000, '999999990.999'));
 END;
 ------------------------------------------------------------------------------------------------------------------------
 --Подекадный расход с нарастающим итогом
 PROCEDURE report7_p IS
  CURSOR lcur_pointsum(an_gid NUMBER, ad_month DATE, an_decad NUMBER) IS
   -- курсор-запрос по суммарному расходу по "an_decad"-декаде для "ad_month"-даты по "an_mid"-й точке, где "av_inverted"-признак инверсии точки в группе
   SELECT SUM(DECODE(g.inverted, 'y', -util_pg.sld(h.mid, nvl(h.er,0), nvl(h.ed,0)), util_pg.sld(h.mid, nvl(h.er,0), nvl(h.ed,0)))) summa
     FROM bill h, groups g
    WHERE g.gid = an_gid
      AND g.mid = h.mid
      AND h.date_time >
              DECODE(an_decad, 1, TRUNC(ad_month, 'MONTH'), 2, TRUNC(ad_month, 'MONTH') + 10, TRUNC(ad_month, 'MONTH') +
                                                                                              20)
      AND h.date_time <= DECODE(
                          an_decad, 1, TRUNC(ad_month, 'MONTH') + 10, 2, TRUNC(ad_month, 'MONTH') + 20,
                          TRUNC(ADD_MONTHS(ad_month, 1), 'MONTH'));
  CURSOR lcur_sel IS
   SELECT     RPAD(' ', 2 * (LEVEL - 1), ' ') || name name, gid, parent, inverted, mid
         FROM ryda.groups
   CONNECT BY PRIOR gid = parent
   START WITH gid = filereport_pg.gn_group;
  CURSOR lcur_sel1(an_gid NUMBER) IS
   SELECT     RPAD(' ', 2 * (LEVEL - 1), ' ') || name name, gid, parent, inverted, mid
         FROM ryda.groups
   CONNECT BY PRIOR gid = parent
   START WITH gid = an_gid;
  n_gids    common_pg.tt_number; -- таблицы с соответствующими гидами
  n_parents common_pg.tt_number;
  v_names   common_pg.tt_varchar2;
  n_dec_1   common_pg.tt_number; -- таблицы значений по декадам
  n_dec_2   common_pg.tt_number;
  n_dec_3   common_pg.tt_number;
  n_ind     NUMBER;
  i         NUMBER;
  j         NUMBER;
  n_d1      NUMBER;
  n_d2      NUMBER;
  n_d3      NUMBER;
  curdate   DATE;
 BEGIN
  filereport_pg.put_p('    Подекадный расход с нарастающим итогом по группе '|| filereport_pg.gv_name);
  filereport_pg.put_p(
   '         за '|| TO_CHAR(filereport_pg.gd_from, 'MONTH') || ' месяц ' || TO_CHAR(filereport_pg.gd_from, 'YYYY') ||
   ' года. [МВт/час]');
  filereport_pg.put_p('');
  filereport_pg.put_p(
   RPAD('-', 43, '-') || '+' || RPAD('-', 21, '-') || '+' || RPAD('-', 21, '-') || '+' || RPAD('-', 21, '-') || '+');
  filereport_pg.put_p(
   '               Наименование                |     1-я декада      |     2-я декада      |     3-я декада      |');
  filereport_pg.put_p(
   RPAD('-', 43, '-') || '+' || RPAD('-', 21, '-') || '+' || RPAD('-', 21, '-') || '+' || RPAD('-', 21, '-') || '+');
  n_ind := 0;
  FOR lc_sel IN lcur_sel LOOP
   n_ind := n_ind + 1;
   v_names(n_ind) := lc_sel.name;
   n_gids(n_ind) := lc_sel.gid;
   n_parents(n_ind) := lc_sel.parent;
   n_dec_1(n_ind) := 0;
   n_dec_2(n_ind) := 0;
   n_dec_3(n_ind) := 0;
   IF lc_sel.mid IS NOT NULL THEN
    FOR lc_sum IN lcur_pointsum(lc_sel.gid, filereport_pg.gd_from, 1) LOOP
     n_dec_1(n_ind) := lc_sum.summa;
    END LOOP;
    FOR lc_sum IN lcur_pointsum(lc_sel.gid, filereport_pg.gd_from, 2) LOOP
     n_dec_2(n_ind) := lc_sum.summa;
    END LOOP;
    FOR lc_sum IN lcur_pointsum(lc_sel.gid, filereport_pg.gd_from, 3) LOOP
     n_dec_3(n_ind) := lc_sum.summa;
    END LOOP;
   ELSE
    FOR lc_gsel IN lcur_sel1(lc_sel.gid) LOOP
     IF lc_gsel.mid IS NOT NULL THEN
      FOR lc_sum IN lcur_pointsum(lc_gsel.gid, filereport_pg.gd_from, 1) LOOP
       n_dec_1(n_ind) := n_dec_1(n_ind) + NVL(lc_sum.summa, 0);
      END LOOP;
      FOR lc_sum IN lcur_pointsum(lc_gsel.gid, filereport_pg.gd_from, 2) LOOP
       n_dec_2(n_ind) := n_dec_2(n_ind) + NVL(lc_sum.summa, 0);
      END LOOP;
      FOR lc_sum IN lcur_pointsum(lc_gsel.gid, filereport_pg.gd_from, 3) LOOP
       n_dec_3(n_ind) := n_dec_3(n_ind) + NVL(lc_sum.summa, 0);
      END LOOP;
     END IF;
    END LOOP;
   END IF;
  END LOOP;
  FOR i IN 1 .. n_ind LOOP
   n_d1 := n_dec_1(i);
   n_d2 := NVL(n_dec_2(i) + NVL(n_d1, 0), n_d1);
   n_d3 := NVL(n_dec_3(i) + NVL(n_d2, 0), n_d2);
   SELECT SYSDATE
     INTO curdate
     FROM DUAL;
   IF SYSDATE < TRUNC(ADD_MONTHS(filereport_pg.gd_from, 1), 'MONTH') THEN
    n_d3 := NULL;
   END IF;
   IF SYSDATE < TRUNC(filereport_pg.gd_from, 'MONTH') + 21 THEN
    n_d2 := NULL;
   END IF;
   IF SYSDATE < TRUNC(filereport_pg.gd_from, 'MONTH') + 11 THEN
    n_d1 := NULL;
   END IF;
   filereport_pg.put_p(
    RPAD(v_names(i), 43, ' ') || '|' || LPAD(NVL(TO_CHAR(n_d1 / 1000, '99999999999990.999'), ' '), 20, ' ') || ' |' ||
    LPAD(NVL(TO_CHAR(n_d2 / 1000, '99999999999990.999'), ' '), 20, ' ') || ' |' ||
    LPAD(NVL(TO_CHAR(n_d3 / 1000, '99999999999990.999'), ' '), 20, ' ') || ' |');
  END LOOP;
 END;
 ------------------------------------------------------------------------------------------------------------------------
 PROCEDURE report89_p(an_maket NUMBER) IS
  CURSOR lcur_sel IS
   SELECT DISTINCT f.vfile
              FROM deportfiles f, deportation d, makets m
             WHERE d.nmaket = m.nmaket
               AND d.ndeportation = f.ndeportation(+)
               AND m.nprocedure = an_maket
               AND ddate = TRUNC(filereport_pg.gd_from);
  gr_file   sys.UTL_FILE.file_type;
  lv_fname  VARCHAR2(2000);
  lv_fpath  VARCHAR2(2000);
  ln_handle INTEGER;
  ln_ret    NUMBER;
  lv_ret    VARCHAR2(4000);
 BEGIN
  BEGIN
   SELECT MAX(vvalue)
     INTO lv_fpath
     FROM parameter
    WHERE npid = 10;
   IF lv_fpath IS NULL THEN
    raise_application_error(-20002, 'Не задан каталог для хранения файлов рассылки в таблице конфигураций.');
   END IF;
   FOR lc IN lcur_sel LOOP
    lv_fname := lv_fpath || lc.vfile;
    gr_file := sys.UTL_FILE.fopen(lv_fpath, lv_fname, 'r');
    BEGIN
     LOOP
      sys.UTL_FILE.get_line(gr_file, lv_ret);
      filereport_pg.put_p(lv_ret);
     END LOOP;
    EXCEPTION
     WHEN NO_DATA_FOUND THEN
      NULL;
     WHEN OTHERS THEN
      RAISE;
    END;
   END LOOP;
   sys.UTL_FILE.fclose_all;
  EXCEPTION
   WHEN sys.UTL_FILE.invalid_path THEN
    raise_application_error(-20001, common_pg.geterrtext(1) || lv_fname);
   WHEN sys.UTL_FILE.invalid_operation THEN
    raise_application_error(-20001, common_pg.geterrtext(2) || lv_fname);
   WHEN sys.UTL_FILE.invalid_filehandle THEN
    raise_application_error(-20001, common_pg.geterrtext(3) || lv_fname);
   WHEN sys.UTL_FILE.write_error THEN
    raise_application_error(-20001, common_pg.geterrtext(4) || lv_fname);
   WHEN OTHERS THEN
    RAISE;
  END;
 EXCEPTION
  WHEN OTHERS THEN
   sys.UTL_FILE.fclose_all;
   RAISE;
 END;
  -----------------------------------------------------------------------------------------------------------------------
 --Макет 30817
 PROCEDURE report8_p IS
 BEGIN
--  report89_p(2);
  report89_p(5);
 END;
  -----------------------------------------------------------------------------------------------------------------------
 --Макет 1010
 PROCEDURE report9_p IS
 BEGIN
  report89_p(1);
 END;
  -----------------------------------------------------------------------------------------------------------------------
 --Типа 30817 за несколько дней
 PROCEDURE report10_p IS
   cursor lcur_sel is
   SELECT     mid, DECODE(inverted, 'y', 1, 0) inv,name
         FROM groups
        WHERE mid IS NOT NULL
   CONNECT BY PRIOR gid = parent
   START WITH gid = filereport_pg.gn_group
   order by name;
cursor lcur_sel1(lc_mid in number,ad_date date) is
   SELECT   TO_NUMBER(TO_CHAR(TRUNC(date_time - 1 / 86400, 'HH24'), 'HH24')) dt,
             SUM(util_pg.sld(b.mid, NVL(b.er, 0), NVL(b.ed, 0))) sm
       FROM halfhour b
      WHERE b.mid = lc_mid AND b.date_time > TRUNC(ad_date) AND b.date_time <= TRUNC(ad_date) + 1
   GROUP BY TO_NUMBER(TO_CHAR(TRUNC(date_time - 1 / 86400, 'HH24'), 'HH24'));
   ld_tmp DATE ;
  lt_ras    common_pg.tt_number;
  ln_rasall NUMBER;
  lv_str    VARCHAR2(4000);
 BEGIN
  FOR lc in lcur_sel loop
      filereport_pg.put_p('');
      filereport_pg.put_p(lc.name);
      ld_tmp:=filereport_pg.gd_from;
      WHILE ld_tmp<=filereport_pg.gd_till loop
           FOR i IN 0 .. 23 LOOP
            lt_ras(i) := 0;
           END LOOP;
           ln_rasall := 0;
           lv_str := '';
           for lc1 in lcur_sel1(lc.mid,ld_tmp) loop
             lt_ras(lc1.dt) := lt_ras(lc1.dt) + lc1.sm;
           end loop;
      lv_str :='';
   FOR i IN 0 .. 23 LOOP
    lt_ras(i) := lt_ras(i);
    ln_rasall := ln_rasall + lt_ras(i);
    lv_str := lv_str || round(lt_ras(i)) || ':';
   END LOOP;
   lv_str := to_char(ld_tmp,'DD.MM.YYYY') || ':' || round(ln_rasall) || ':' || lv_str;
   filereport_pg.put_p(lv_str);
   lt_ras.DELETE;
      ld_tmp:=ld_tmp+1;
      end loop;
  end loop;
 END;

 ------------------------------------------------------------------------------------------------------------------------
--Текущая мощность (KSS)
 PROCEDURE report11_p IS
 TimeLimit NUMBER default (1/24/3); -- 20 мин (add by KSS) предел расхождения во времени при считывании текущей мощьности (CURR_POWER)
  CURSOR lcur_summa(an_gid NUMBER) IS
    SELECT
        DECODE(g.INVERTED, 'y', -RYDA.UTIL_PG.SLD(c.MID, NVL(c.ER, 0), NVL(c.ED, 0)), RYDA.UTIL_PG.SLD(c.MID, NVL(c.ER, 0), NVL(c.ED, 0))) activ,
        DECODE(g.INVERTED, 'y', -RYDA.UTIL_PG.SLD(c.MID, NVL(c.Q3, 0), NVL(c.Q1, 0)), RYDA.UTIL_PG.SLD(c.MID, NVL(c.Q3, 0), NVL(c.Q1, 0))) react
    FROM RYDA.CURR_POWER c, RYDA.GROUPS g
    WHERE c.MID=g.MID AND g.GID IN(
        SELECT GID
        FROM RYDA.GROUPS
        WHERE MID IS NOT NULL
        CONNECT BY PRIOR GID=PARENT
        START WITH GID=an_gid
    )   AND c.DATE_TIME <= SYSDATE
        AND c.DATE_TIME >= (SYSDATE-TimeLimit)
        AND c.OBSOLETE = 0;
  CURSOR lcur_groups IS
    SELECT gid, name
    FROM RYDA.GROUPS
    WHERE parent=filereport_pg.gn_group;
  ln_cnt NUMBER DEFAULT 0;
  ln_cnts NUMBER DEFAULT 0;
  ln_activ NUMBER DEFAULT 0;
  ln_react NUMBER DEFAULT 0;
  ln_aactiv NUMBER DEFAULT 0;
  ln_areact NUMBER DEFAULT 0;
  lv_err varchar2(5);
 BEGIN
  filereport_pg.put_p('    Текущая мощность по группе: '|| filereport_pg.gv_name);
  filereport_pg.put_p('    Время: '|| TO_CHAR(SYSDATE, 'hh24:mi:ss') || '   Дата: ' || TO_CHAR(SYSDATE, 'dd.mm.yyyy'));
  filereport_pg.put_p('');
  filereport_pg.put_p(LPAD('-', 90, '-'));
  filereport_pg.put_p(RPAD('   Составляющая', 30, ' ') ||
                      RPAD('Акт.мощн.факт.,[МВт]', 28, ' ')||
                      RPAD('Реакт.мощн.факт.,[МВАр]', 28, ' ') ||
                      'ERR');
  filereport_pg.put_p(LPAD('-', 90, '-'));
  ln_aactiv := 0;
  ln_areact := 0;
  FOR lc IN lcur_groups LOOP
    SELECT COUNT(gid)
    INTO ln_cnt
    FROM ryda.groups
    WHERE mid IS NOT NULL
    CONNECT BY PRIOR gid=parent
    START WITH gid=lc.gid;

    IF ln_cnt = 0 THEN
        ln_activ := NULL;
        ln_react := NULL;
    ELSE
        ln_activ := 0;
        ln_react := 0;
        ln_cnts := 0;
        FOR lc1 IN lcur_summa(lc.gid) LOOP
          ln_cnts := ln_cnts+1;
          ln_activ := ln_activ+lc1.activ;
          ln_react := ln_react+lc1.react;
        END LOOP;
    END IF;
    IF ln_cnt <> ln_cnts THEN
      lv_err := '*';
    ELSE
      lv_err := ' ';
    END IF;
    filereport_pg.put_p(RPAD(lc.name, 35, ' ') ||
                        LPAD(NVL(TO_CHAR(ln_activ / 1000, '999999990.999'), ' '), 15, ' ') ||
                        LPAD(NVL(TO_CHAR(ln_react / 1000, '999999990.999'), ' '), 30, ' ') ||
                        LPAD(lv_err, 8, ' ')
                        );
    ln_aactiv := ln_aactiv+NVL(ln_activ,0);
    ln_areact := ln_areact+NVL(ln_react,0);
   END LOOP;
   filereport_pg.put_p(LPAD('-', 90, '-'));
   filereport_pg.put_p(RPAD('ИТОГО', 35, ' ') ||
                       LPAD(NVL(TO_CHAR(ln_aactiv / 1000, '999999990.999'), ' '), 15, ' ') ||
                       LPAD(NVL(TO_CHAR(ln_areact / 1000, '999999990.999'), ' '), 30, ' ') ||
                       LPAD(lv_err, 8, ' ')
                       );
 END;
 ------------------------------------------------------------------------------------------------------------------------
--Показания приборов учёта (KSS)
 PROCEDURE report12_p IS
  CURSOR lcur_fdrs IS
    SELECT
        m.POSITION pos,
        p.NAME nam,
        DECODE(m.ENTYPE, 1, 'актив. прм.', 2, 'актив. отд.', 3, 'реакт. прм.', 'реакт. ген.') entype,
        m.MTRSN sn,
        m.DIGITS mask,
        RYDA.UTIL_PG.get_meterage(p.mid, filereport_pg.gd_from, m.ENTYPE, 1) value
    FROM RYDA.METERS m, RYDA.POINTS p
    WHERE p.mid=m.mid AND p.mid IN (
        SELECT DISTINCT MID
        FROM RYDA.GROUPS
        WHERE MID IS NOT NULL
        CONNECT BY PRIOR GID=PARENT
        START WITH GID=filereport_pg.gn_group)
    ORDER BY nam, pos;
  lv_ps VARCHAR2(1000);
  ln_mid NUMBER DEFAULT 0;
  ln_gid NUMBER DEFAULT 0;
  ld_date DATE;
 BEGIN
    SELECT DECODE(mid, NULL, gid,  parent)
    INTO ln_gid
    FROM RYDA.GROUPS
    WHERE gid = filereport_pg.gn_group;
    SELECT name
    INTO lv_ps
    FROM RYDA.GROUPS
    WHERE gid=ln_gid;
    filereport_pg.put_p('    Показания по подстанции: '|| lv_ps);
    ld_date := trunc(filereport_pg.gd_from, 'dd')+floor((filereport_pg.gd_from-trunc(filereport_pg.gd_from, 'dd'))*48)/48;
    filereport_pg.put_p('    Время: '|| TO_CHAR(ld_date, 'hh24:mi:ss') || '   Дата: ' || TO_CHAR(ld_date, 'dd.mm.yyyy'));
    filereport_pg.put_p('');
    filereport_pg.put_p(LPAD('-', 80, '-'));
    filereport_pg.put_p(RPAD('Позиция', 8, ' ') ||
                        RPAD('Фидер', 30, ' ')|| ' ' ||
                        RPAD('Энергия', 12, ' ')||
                        RPAD('З-д №', 10, ' ')||
                        LPAD('  Показания  ', 18, ' '));
    filereport_pg.put_p(LPAD('-', 80, '-'));
    FOR lc IN lcur_fdrs LOOP
        filereport_pg.put_p(RPAD(lc.pos, 8, ' ') ||
                            RPAD(lc.nam, 30, ' ') || ' ' ||
                            RPAD(lc.entype, 12, ' ') ||
                            RPAD(lc.sn, 10, ' ') ||
                            LPAD(to_char(lc.value, replace(NVL(lc.mask, '999999.99'),'9','0')), 18, ' ')
                        );
    END LOOP;
    filereport_pg.put_p(LPAD('-', 80, '-'));
 END;
 ------------------------------------------------------------------------------------------------------------------------
--Первичная информация УСД ИТЕК (получасовой расход) (KSS)  an_type = 1
--Первичная информация УСД ИТЕК (суточный расход) (KSS)     an_type = 2
--Первичная информация УСД ИТЕК (месячный расход) (KSS)     an_type = 3
 PROCEDURE report13_p(an_type NUMBER) IS
  CURSOR lcur_sel(an_pos NUMBER, an_gid NUMBER) IS
    SELECT
        p.MID mid,
        DECODE(m.ENTYPE, 1, 'Актив. прм.', 2, 'Актив. отд.', 3, 'Реакт. прм.', 'Реакт. ген.') en,
        m.ENTYPE typ,
        p.NAME nam
    FROM RYDA.METERS m, RYDA.POINTS p
    WHERE m.MID=p.MID AND m.POSITION=an_pos AND p.MID IN (
      SELECT DISTINCT MID
      FROM RYDA.GROUPS
      WHERE MID IS NOT NULL AND PARENT=an_gid
    );
  lv_ps VARCHAR2(1000);
  ln_mid NUMBER DEFAULT 0;
  ln_gid NUMBER DEFAULT 0;
  ld_date DATE;
  lv_type VARCHAR2(50);
  ln_type NUMBER;
  lv_name VARCHAR2(256);
  ln_val NUMBER;
  ln_koef NUMBER;
 BEGIN
    SELECT DECODE(mid, NULL, gid, parent)
    INTO ln_gid
    FROM RYDA.GROUPS
    WHERE gid = filereport_pg.gn_group;
    SELECT name
    INTO lv_ps
    FROM RYDA.GROUPS
    WHERE gid=ln_gid;
    IF an_type = 1 THEN
        lv_type := '(за полчаса)';
        ld_date := trunc(filereport_pg.gd_from, 'dd')+floor((filereport_pg.gd_from-trunc(filereport_pg.gd_from, 'dd'))*48)/48;
    ELSE
      IF an_type = 2 THEN
        lv_type := '(за сутки)';
        ld_date := trunc(filereport_pg.gd_from, 'dd')+1;
      ELSE
        IF an_type = 3 THEN
            lv_type := '(за месяц)';
            ld_date := trunc(ADD_MONTHS(filereport_pg.gd_from, 1), 'mm');
        END IF;
      END IF;
    END IF;
    filereport_pg.put_p('   Первичная информация УСД ИТЕК ' || lv_type ||  ' по подстанции: '|| lv_ps);
    IF an_type=1 THEN
      filereport_pg.put_p('    Время: '|| TO_CHAR(ld_date, 'hh24:mi:ss') || '   Дата: ' || TO_CHAR(ld_date, 'dd.mm.yyyy'));
    ELSE
      IF an_type=2 THEN
        filereport_pg.put_p('    Дата: ' || TO_CHAR(ld_date-1, 'dd.mm.yyyy'));
      ELSE
        filereport_pg.put_p('    Месяц: ' || to_char(ld_date-1, 'MONTH'));
      END IF;
    END IF;
    filereport_pg.put_p('');
    filereport_pg.put_p(LPAD('-', 80, '-'));
    filereport_pg.put_p(RPAD('Позиция', 10, ' ') ||
                        LPAD(' Расход', 10, ' ') ||
                        RPAD('  Коэфф.ИТЕК''а', 16, ' ')||
                        RPAD('   Энергия', 18, ' ')||
                        RPAD('     Фидер', 30, ' ')
                        );
    filereport_pg.put_p(LPAD('-', 80, '-'));
    FOR i in 0 .. 63 LOOP
      lv_type := NULL;
      lv_name := NULL;
      ln_mid := NULL;
      ln_type := NULL;
      ln_val := NULL;
      ln_koef := NULL;
      FOR lc IN lcur_sel(i+33, ln_gid) LOOP
        ln_mid := lc.mid;
        lv_type := lc.en;
        ln_type := lc.typ;
        lv_name := lc.nam;
      END LOOP;
      IF ln_mid IS NOT NULL THEN
        IF an_type = 1 THEN
          SELECT SUM(DECODE(ln_type, 1, ER, 2, ED, 3, Q1, Q3))
          INTO ln_val
          FROM RYDA.HALFHOUROLD
          WHERE MID=ln_mid AND DATE_TIME=ld_date AND nexceptcalc is null AND nsource < 30;
        ELSE
          IF an_type = 2 THEN
            SELECT SUM(DECODE(ln_type, 1, ER, 2, ED, 3, Q1, Q3))
            INTO ln_val
            FROM RYDA.BILLORG
            WHERE MID=ln_mid AND DATE_TIME=ld_date AND nsource = 20;
          ELSE
            SELECT SUM(DECODE(ln_type, 1, ER, 2, ED, 3, Q1, Q3))
            INTO ln_val
            FROM RYDA.MONTHSORG
            WHERE MID=ln_mid AND DATE_TIME=ld_date  AND nsource = 20;
          END IF;
        END IF;
      END IF;
      SELECT SUM(DECODE(ln_type, 1, KER, 2, KED, 3, KQ1, KQ3)) koef
      INTO ln_koef
      FROM RYDA.ITEKCOEFF
      WHERE MID=ln_mid;
      filereport_pg.put_p(
        LPAD(i+1, 4, ' ') || '  ' ||
        LPAD(NVL(to_char(ln_val), ' '), 13, ' ') ||
        LPAD(NVL(to_char(ln_koef), ' '), 13, ' ') || '     ' ||
        RPAD(lv_type, 15, ' ') ||
        RPAD(lv_name, 50, ' ')
      );
    END LOOP;
 END;
 ------------------------------------------------------------------------------------------------------------------------
 --Подекадный расход с нарастающим итогом (по группам)
 PROCEDURE report14_p IS
   -- курсор-запрос по суммарному расходу по "an_decad"-декаде для "ad_month"-даты по "an_gid"-й группе
  CURSOR lcur_pointsum(an_gid NUMBER, ad_month DATE, an_decad NUMBER) IS
   SELECT SUM(DECODE(g.inverted, 'y', -util_pg.sld(h.mid, nvl(h.er,0), nvl(h.ed,0)), util_pg.sld(h.mid, nvl(h.er,0), nvl(h.ed,0)))) summa
   FROM bill h, groups g
   WHERE g.gid = an_gid
      AND g.mid = h.mid
      AND h.date_time >  DECODE(an_decad,
                                1, TRUNC(ad_month, 'MONTH'),
                                2, TRUNC(ad_month, 'MONTH') + 10,
                                TRUNC(ad_month, 'MONTH') + 20)
      AND h.date_time <= DECODE(an_decad,
                                1, TRUNC(ad_month, 'MONTH') + 10,
                                2, TRUNC(ad_month, 'MONTH') + 20,
                                TRUNC(ADD_MONTHS(ad_month, 1), 'MONTH'));
  CURSOR lcur_sel IS
   SELECT DECODE(gid, filereport_pg.gn_group, ' ', '-   ') || name nam, gid, parent, inverted, mid
   FROM ryda.groups
   WHERE gid = filereport_pg.gn_group OR parent = filereport_pg.gn_group
   ORDER BY name;
   --
  CURSOR lcur_sel1(an_gid NUMBER) IS
   SELECT RPAD(' ', 2 * (LEVEL - 1), ' ') || name name, gid, parent, inverted, mid
   FROM ryda.groups
   CONNECT BY PRIOR gid = parent
   START WITH gid = an_gid;
  n_gids    common_pg.tt_number; -- таблицы с соответствующими гидами
  n_parents common_pg.tt_number;
  v_names   common_pg.tt_varchar2;
  n_dec_1   common_pg.tt_number; -- таблицы значений по декадам
  n_dec_2   common_pg.tt_number;
  n_dec_3   common_pg.tt_number;
  n_ind     NUMBER;
  i         NUMBER;
  j         NUMBER;
  n_d1      NUMBER;
  n_d2      NUMBER;
  n_d3      NUMBER;
  curdate   DATE;
 BEGIN
  filereport_pg.put_p('    Подекадный расход перетока активной энергии с нарастающим итогом по группе '|| filereport_pg.gv_name);
  filereport_pg.put_p(
   '         за '|| TO_CHAR(filereport_pg.gd_from, 'MONTH') || ' месяц ' || TO_CHAR(filereport_pg.gd_from, 'YYYY') ||
   ' года. [тыс. кВт*час]');
  filereport_pg.put_p('');
  filereport_pg.put_p(
   RPAD('-', 43, '-') || '+' || RPAD('-', 21, '-') || '+' || RPAD('-', 21, '-') || '+' || RPAD('-', 21, '-') || '+');
  filereport_pg.put_p(
   '               Наименование                |     1-я декада      |     2-я декада      |     3-я декада      |');
  filereport_pg.put_p(
   RPAD('-', 43, '-') || '+' || RPAD('-', 21, '-') || '+' || RPAD('-', 21, '-') || '+' || RPAD('-', 21, '-') || '+');
  n_ind := 0;
  FOR lc_sel IN lcur_sel LOOP
   n_ind := n_ind + 1;
   v_names(n_ind) := lc_sel.nam;
   n_gids(n_ind) := lc_sel.gid;
   n_parents(n_ind) := lc_sel.parent;
   n_dec_1(n_ind) := 0;
   n_dec_2(n_ind) := 0;
   n_dec_3(n_ind) := 0;
   IF lc_sel.mid IS NOT NULL THEN
    FOR lc_sum IN lcur_pointsum(lc_sel.gid, filereport_pg.gd_from, 1) LOOP
     n_dec_1(n_ind) := lc_sum.summa;
    END LOOP;
    FOR lc_sum IN lcur_pointsum(lc_sel.gid, filereport_pg.gd_from, 2) LOOP
     n_dec_2(n_ind) := lc_sum.summa;
    END LOOP;
    FOR lc_sum IN lcur_pointsum(lc_sel.gid, filereport_pg.gd_from, 3) LOOP
     n_dec_3(n_ind) := lc_sum.summa;
    END LOOP;
   ELSE
    FOR lc_gsel IN lcur_sel1(lc_sel.gid) LOOP
     IF lc_gsel.mid IS NOT NULL THEN
      FOR lc_sum IN lcur_pointsum(lc_gsel.gid, filereport_pg.gd_from, 1) LOOP
       n_dec_1(n_ind) := n_dec_1(n_ind) + NVL(lc_sum.summa, 0);
      END LOOP;
      FOR lc_sum IN lcur_pointsum(lc_gsel.gid, filereport_pg.gd_from, 2) LOOP
       n_dec_2(n_ind) := n_dec_2(n_ind) + NVL(lc_sum.summa, 0);
      END LOOP;
      FOR lc_sum IN lcur_pointsum(lc_gsel.gid, filereport_pg.gd_from, 3) LOOP
       n_dec_3(n_ind) := n_dec_3(n_ind) + NVL(lc_sum.summa, 0);
      END LOOP;
     END IF;
    END LOOP;
   END IF;
  END LOOP;
  FOR i IN 1 .. n_ind LOOP
   n_d1 := n_dec_1(i);
   n_d2 := NVL(n_dec_2(i) + NVL(n_d1, 0), n_d1);
   n_d3 := NVL(n_dec_3(i) + NVL(n_d2, 0), n_d2);
   SELECT SYSDATE
     INTO curdate
     FROM DUAL;
   IF SYSDATE < TRUNC(ADD_MONTHS(filereport_pg.gd_from, 1), 'MONTH') THEN
    n_d3 := NULL;
   END IF;
   IF SYSDATE < TRUNC(filereport_pg.gd_from, 'MONTH') + 21 THEN
    n_d2 := NULL;
   END IF;
   IF SYSDATE < TRUNC(filereport_pg.gd_from, 'MONTH') + 11 THEN
    n_d1 := NULL;
   END IF;
   filereport_pg.put_p(
    RPAD(v_names(i), 43, ' ') || '|' || LPAD(NVL(TO_CHAR(n_d1 / 1000, '99999999999990.999'), ' '), 20, ' ') || ' |' ||
    LPAD(NVL(TO_CHAR(n_d2 / 1000, '99999999999990.999'), ' '), 20, ' ') || ' |' ||
    LPAD(NVL(TO_CHAR(n_d3 / 1000, '99999999999990.999'), ' '), 20, ' ') || ' |');
  END LOOP;
 END;
  -----------------------------------------------------------------------------------------------------------------------
 --Недопустимые расхождения при верификации
 PROCEDURE report15_p IS
   repwidth number default 90;
 BEGIN
   filereport_pg.put_p('    Недопустимые расхождения при верификации ');
   filereport_pg.put_p(' ');
   filereport_pg.put_p(rpad('-', repwidth, '-'));
   filereport_pg.put_p(rpad('     Дата',30,' ') || 'Подстанция / Точка учета');
   filereport_pg.put_p(rpad('Верификация',40,' ')||rpad('План',10,' ')||rpad('Факт',10,' ')||'Примечание');
   filereport_pg.put_p(rpad('-', repwidth, '-'));
   for c in (
     select rpad(to_char(ddate,'dd.mm.yy hh24:mi'),30,' ') dd,
     rpad(p1.name, 40,' ') proc,
     p3.name||'/'||p2.name point,
     rpad(vparam, 10, ' ') plan,
     rpad(round(abs(nmustbe - nindeed) / decode(sign(nmustbe), 0, 1, -1, -nmustbe, nmustbe) * 100, 3), 10, ' ') fact,
     decode(c.nprocedure,
     6, 'Осн.'||round(nmustbe,5)||' / Дубль.'||round(nindeed,5),
     7, 'Итек '||round(nmustbe,5)||' / БД '||round(nindeed,5),
     8, 'З-д №'||round(nmustbe,5)||' / Св.№'||round(nindeed,5),
     9, 'По ПУ '||round(nmustbe,5)||' / По БД '||round(nindeed,5),
     10, 'По ПУ '||round(nmustbe,5)||' / По БД '||round(nindeed,5),
     11, 'Прием '||round(nmustbe,5)||' / Отдача '||round(nindeed,5),
     12, 'ОВ '||round(nmustbe,5)||' / БД '||round(nindeed,5),
     null) prim
     from check_results c, points p1, points p2, points p3
     where p1.mid = c.nprocedure
     and p2.mid = c.mid
     and p3.mid = p2.parent
     order by ddate desc, p1.name
    ) loop
     filereport_pg.put_p(c.dd || c.point);
     filereport_pg.put_p(c.proc || c.plan || c.fact ||c.prim);
     filereport_pg.put_p(rpad('-', repwidth, '-'));
   end loop;
 END;
  -----------------------------------------------------------------------------------------------------------------------

END; -- Package Body plsql1_pg
/

-- End of DDL script for PLSQL1_PG

-- Start of DDL script for PLSQL2_PG
-- Generated 27-янв-03  11:34:02 am
-- from oe-RYDA:1

-- Package body PLSQL2_PG

CREATE OR REPLACE
PACKAGE BODY PLSQL2_PG
IS
--
-- MODIFICATION HISTORY
-- SDM         6/12/02  Comments
-- ---------   ------  ------------------------------------------

TYPE TNUMBER IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
gv_StartName VARCHAR2(128);
/*
gt_Levels TNUMBER;*/


PROCEDURE Put_p(av_Texp IN VARCHAR2) IS
BEGIN
if gb_DBMS_output then
    dbms_output.put_line(rpad(av_Texp,255));
else
    filereport_pg.put_p(av_Texp);
end if;
END;

FUNCTION vSortName_f(an_Gid IN NUMBER, an_StartGid IN NUMBER) RETURN VARCHAR2 IS
CURSOR lcur_Back IS
      select g.* from groups g
        connect by gid = prior parent and prior gid <> an_StartGid
        start with gid = an_Gid;
lv_Accumulator VARCHAR2(10000);
BEGIN
FOR lr IN lcur_Back LOOP
    lv_Accumulator := rpad(lr.name,35)||lv_Accumulator;
END LOOP;

return lv_Accumulator;
END;

FUNCTION vName_f(an_Gid IN NUMBER, an_Mid IN NUMBER, av_Name IN VARCHAR2) RETURN VARCHAR2 IS
lv_Result VARCHAR2(200);
BEGIN
lv_Result := av_Name;
if an_Mid is not null then
    select Name||'\'||lv_Result into lv_Result from Points where mid =
                    (select Parent from Points where mid = an_Mid);
end if;
return lv_Result;
END;

PROCEDURE rep1_p IS
lt_Res TT_Groups;
lv_Mask VARCHAR2(64);
ln_Length NUMBER := 15 + 36 + (length(gn_Amount) + 2)*25 + 9; --307;
lv_Title VARCHAR2(128) := 'Почасовой расход активной энергии';
lv_Title2 VARCHAR2(128) := 'Периметр АК "Харьковоблэнерго"';
lb_AllowPut BOOLEAN := false;
BEGIN
lt_Res := tmain_f;
lv_Title2 := lv_Title2||'. '||rtrim(gv_StartName)||
'. C '||to_char(FILEREPORT_PG.gd_from, 'DD.MM.YYYY HH24:MI:SS')||' по '||to_char(FILEREPORT_PG.gd_till, 'DD.MM.YYYY HH24:MI:SS');
lv_Mask := to_char(gn_Amount);
put_p(rpad(' ',ln_Length/2 - length(lv_Title)/2 - 1)||lv_Title);
put_p(rpad(' ',ln_Length/2 - length(lv_Title2)/2 - 1)||lv_Title2);
put_p(lpad('[кВт * ч]', ln_Length));
put_p(rpad('-',ln_Length,'-'));
put_p(rpad(' №', 15)
        ||'|'||rpad(' Группа/точка учета', 35)
        ||'|'||rpad(' Итого', length(gn_Amount) + 1)
        ||'|'||rpad(' 1:00', length(gn_Amount) + 1)
        ||'|'||rpad(' 2:00', length(gn_Amount) + 1)
        ||'|'||rpad(' 3:00', length(gn_Amount) + 1)
        ||'|'||rpad(' 4:00', length(gn_Amount) + 1)
        ||'|'||rpad(' 5:00', length(gn_Amount) + 1)
        ||'|'||rpad(' 6:00', length(gn_Amount) + 1)
        ||'|'||rpad(' 7:00', length(gn_Amount) + 1)
        ||'|'||rpad(' 8:00', length(gn_Amount) + 1)
        ||'|'||rpad(' 9:00', length(gn_Amount) + 1)
        ||'|'||rpad('10:00', length(gn_Amount) + 1)
        ||'|'||rpad('11:00', length(gn_Amount) + 1)
        ||'|'||rpad('12:00', length(gn_Amount) + 1)
        ||'|'||rpad('13:00', length(gn_Amount) + 1)
        ||'|'||rpad('14:00', length(gn_Amount) + 1)
        ||'|'||rpad('15:00', length(gn_Amount) + 1)
        ||'|'||rpad('16:00', length(gn_Amount) + 1)
        ||'|'||rpad('17:00', length(gn_Amount) + 1)
        ||'|'||rpad('18:00', length(gn_Amount) + 1)
        ||'|'||rpad('19:00', length(gn_Amount) + 1)
        ||'|'||rpad('20:00', length(gn_Amount) + 1)
        ||'|'||rpad('21:00', length(gn_Amount) + 1)
        ||'|'||rpad('22:00', length(gn_Amount) + 1)
        ||'|'||rpad('23:00', length(gn_Amount) + 1)
        ||'|'||rpad('24:00', length(gn_Amount) + 1)
        ||'|'||rpad('Иденти-', 7)
        ||'|'
     );
put_p(rpad(' ', 15)
        ||'|'||rpad(' ', 35)
        ||'|'||rpad(' за', length(gn_Amount) + 1)
        ||'|'||rpad(' ', length(gn_Amount) + 1)
        ||'|'||rpad(' ', length(gn_Amount) + 1)
        ||'|'||rpad(' ', length(gn_Amount) + 1)
        ||'|'||rpad(' ', length(gn_Amount) + 1)
        ||'|'||rpad(' ', length(gn_Amount) + 1)
        ||'|'||rpad(' ', length(gn_Amount) + 1)
        ||'|'||rpad(' ', length(gn_Amount) + 1)
        ||'|'||rpad(' ', length(gn_Amount) + 1)
        ||'|'||rpad(' ', length(gn_Amount) + 1)
        ||'|'||rpad(' ', length(gn_Amount) + 1)
        ||'|'||rpad(' ', length(gn_Amount) + 1)
        ||'|'||rpad(' ', length(gn_Amount) + 1)
        ||'|'||rpad(' ', length(gn_Amount) + 1)
        ||'|'||rpad(' ', length(gn_Amount) + 1)
        ||'|'||rpad(' ', length(gn_Amount) + 1)
        ||'|'||rpad(' ', length(gn_Amount) + 1)
        ||'|'||rpad(' ', length(gn_Amount) + 1)
        ||'|'||rpad(' ', length(gn_Amount) + 1)
        ||'|'||rpad(' ', length(gn_Amount) + 1)
        ||'|'||rpad(' ', length(gn_Amount) + 1)
        ||'|'||rpad(' ', length(gn_Amount) + 1)
        ||'|'||rpad(' ', length(gn_Amount) + 1)
        ||'|'||rpad(' ', length(gn_Amount) + 1)
        ||'|'||rpad(' ', length(gn_Amount) + 1)
        ||'|'||rpad('фикатор', 7)
        ||'|'
     );
put_p(rpad(' ', 15)
        ||'|'||rpad(' ', 35)
        ||'|'||rpad(' сутки', length(gn_Amount) + 1)
        ||'|'||rpad(' ', length(gn_Amount) + 1)
        ||'|'||rpad(' ', length(gn_Amount) + 1)
        ||'|'||rpad(' ', length(gn_Amount) + 1)
        ||'|'||rpad(' ', length(gn_Amount) + 1)
        ||'|'||rpad(' ', length(gn_Amount) + 1)
        ||'|'||rpad(' ', length(gn_Amount) + 1)
        ||'|'||rpad(' ', length(gn_Amount) + 1)
        ||'|'||rpad(' ', length(gn_Amount) + 1)
        ||'|'||rpad(' ', length(gn_Amount) + 1)
        ||'|'||rpad(' ', length(gn_Amount) + 1)
        ||'|'||rpad(' ', length(gn_Amount) + 1)
        ||'|'||rpad(' ', length(gn_Amount) + 1)
        ||'|'||rpad(' ', length(gn_Amount) + 1)
        ||'|'||rpad(' ', length(gn_Amount) + 1)
        ||'|'||rpad(' ', length(gn_Amount) + 1)
        ||'|'||rpad(' ', length(gn_Amount) + 1)
        ||'|'||rpad(' ', length(gn_Amount) + 1)
        ||'|'||rpad(' ', length(gn_Amount) + 1)
        ||'|'||rpad(' ', length(gn_Amount) + 1)
        ||'|'||rpad(' ', length(gn_Amount) + 1)
        ||'|'||rpad(' ', length(gn_Amount) + 1)
        ||'|'||rpad(' ', length(gn_Amount) + 1)
        ||'|'||rpad(' ', length(gn_Amount) + 1)
        ||'|'||rpad(' ', length(gn_Amount) + 1)
        ||'|'||rpad('полноты', 7)
        ||'|'
     );
put_p(rpad('-',ln_Length,'-'));
FOR j IN 0..lt_Res.count - 1 LOOP
    lb_AllowPut := false;
    if lt_Res(j).vNo like '1%' then
        lb_AllowPut := true;
    else
        lb_AllowPut := lt_Res(j).nTotal <> 0 or lt_Res(j).n1 <> 0 or lt_Res(j).n2 <> 0 or lt_Res(j).n3 <> 0 or
                           lt_Res(j).n4 <> 0 or lt_Res(j).n5 <> 0 or lt_Res(j).n6 <> 0 or lt_Res(j).n7 <> 0 or
                           lt_Res(j).n8 <> 0 or lt_Res(j).n9 <> 0 or lt_Res(j).n10 <> 0 or lt_Res(j).n11 <> 0 or
                           lt_Res(j).n12 <> 0 or lt_Res(j).n13 <> 0 or lt_Res(j).n14 <> 0 or lt_Res(j).n15 <> 0 or
                           lt_Res(j).n16 <> 0 or lt_Res(j).n17 <> 0 or lt_Res(j).n18 <> 0 or lt_Res(j).n19 <> 0 or
                           lt_Res(j).n20 <> 0 or lt_Res(j).n21 <> 0 or lt_Res(j).n22 <> 0 or lt_Res(j).n23 <> 0 or
                           lt_Res(j).n24 <> 0;
    end if;
    if lb_AllowPut then
        put_p(rpad(
        lt_Res(j).vNo, 15)||'|'||lt_Res(j).vName
        ||'|'||to_char(lt_Res(j).nTotal,lv_Mask)
        ||'|'||to_char(lt_Res(j).n1,lv_Mask)||'|'||to_char(lt_Res(j).n2,lv_Mask)
        ||'|'||to_char(lt_Res(j).n3,lv_Mask)||'|'||to_char(lt_Res(j).n4,lv_Mask)
        ||'|'||to_char(lt_Res(j).n5,lv_Mask)||'|'||to_char(lt_Res(j).n6,lv_Mask)
        ||'|'||to_char(lt_Res(j).n7,lv_Mask)||'|'||to_char(lt_Res(j).n8,lv_Mask)
        ||'|'||to_char(lt_Res(j).n9,lv_Mask)||'|'||to_char(lt_Res(j).n10,lv_Mask)
        ||'|'||to_char(lt_Res(j).n11,lv_Mask)||'|'||to_char(lt_Res(j).n12,lv_Mask)
        ||'|'||to_char(lt_Res(j).n13,lv_Mask)||'|'||to_char(lt_Res(j).n14,lv_Mask)
        ||'|'||to_char(lt_Res(j).n15,lv_Mask)||'|'||to_char(lt_Res(j).n16,lv_Mask)
        ||'|'||to_char(lt_Res(j).n17,lv_Mask)||'|'||to_char(lt_Res(j).n18,lv_Mask)
        ||'|'||to_char(lt_Res(j).n19,lv_Mask)||'|'||to_char(lt_Res(j).n20,lv_Mask)
        ||'|'||to_char(lt_Res(j).n21,lv_Mask)||'|'||to_char(lt_Res(j).n22,lv_Mask)
        ||'|'||to_char(lt_Res(j).n23,lv_Mask)||'|'||to_char(lt_Res(j).n24,lv_Mask)
        ||'|'||to_char(lt_Res(j).nFullness,'999999')
        ||'|'
        );
        if lt_Res.exists(j + 1) then
            if lt_Res(j + 1).nLev <> lt_Res(j).nLev or j = 0 then
               put_p(rpad('-',ln_Length,'-'));
            end if;
        end if;
    end if;
END LOOP;
put_p(rpad('-',ln_Length,'-'));

END;

FUNCTION tmain_f RETURN TT_Groups IS
lt_Res TT_Groups;
li_i BINARY_INTEGER := 0;
li_lev BINARY_INTEGER;
lt_levels TNumber;
lt_Totals TNumber;
lt_TotalsTotal TNumber;
lt_TotalsCounter TNumber;
FUNCTION rReset_f(ar_Row IN OUT gcur_Groups%ROWTYPE) RETURN gcur_Groups%ROWTYPE IS
BEGIN
ar_Row.nTotal := 0;
ar_Row.n1 := 0; ar_Row.n2 := 0; ar_Row.n3 := 0; ar_Row.n4 := 0;
ar_Row.n5 := 0; ar_Row.n6 := 0; ar_Row.n7 := 0; ar_Row.n8 := 0;
ar_Row.n9 := 0; ar_Row.n10 := 0; ar_Row.n11 := 0; ar_Row.n12 := 0;
ar_Row.n13 := 0; ar_Row.n14 := 0; ar_Row.n15 := 0; ar_Row.n16 := 0;
ar_Row.n17 := 0; ar_Row.n18 := 0; ar_Row.n19 := 0; ar_Row.n20 := 0;
ar_Row.n21 := 0; ar_Row.n22 := 0; ar_Row.n23 := 0; ar_Row.n24 := 0;
ar_Row.nFullness := 0;
return ar_Row;
END;

BEGIN
--dbms_output.put_line('!!! ');
FOR lr IN gcur_Groups LOOP
    if li_i = 0 then
        lt_Res(li_i) := rReset_f(lr);
        gv_StartName := lt_Res(li_i).vName;
        lt_Res(li_i).vName := rpad('Всего по периметру АК ХОЭ', 35);
        lt_Res(li_i).vNo := ' ';
        lt_Totals(0) := 0;
        lt_TotalsTotal(0) := 0;
        lt_TotalsCounter(0) := 0;
    end if;
    li_i := li_i + 1;
    lt_Res(li_i) := rReset_f(lr);
    if li_i = 1 then
        lt_levels(1) := 1; li_lev := 1;
    elsif lt_Res(li_i).nLev = lt_Res(li_i - 1).nLev then
        lt_levels(li_lev) := lt_levels(li_lev) + 1;
    elsif lt_Res(li_i).nLev > lt_Res(li_i - 1).nLev then
        li_lev := li_lev + (lt_Res(li_i).nLev - lt_Res(li_i - 1).nLev);
        lt_levels(li_lev) := 1;
        lt_Totals(li_lev - 1) := li_i - 1;
        lt_TotalsTotal(li_lev - 1) := 0;
        lt_TotalsCounter(li_lev - 1) := 0;
    elsif lt_Res(li_i).nLev < lt_Res(li_i - 1).nLev then
        FOR j IN REVERSE lt_Res(li_i).nLev + 1..lt_Res(li_i - 1).nLev LOOP
            lt_levels.delete(j);
        END LOOP;
        FOR j IN REVERSE lt_Res(li_i).nLev..lt_Res(li_i - 1).nLev - 1 LOOP
            lt_Totals.delete(j);
            lt_TotalsTotal.delete(j);
            lt_TotalsCounter.delete(j);
        END LOOP;
        li_lev := li_lev + (lt_Res(li_i).nLev - lt_Res(li_i - 1).nLev);
        lt_levels(li_lev) := lt_levels(li_lev) + 1;
    end if;
    FOR j IN 1..lt_levels.count LOOP
       if j = 1 then
           lt_Res(li_i).vNo := to_char(lt_levels(j));
       else
           lt_Res(li_i).vNo := lt_Res(li_i).vNo||'.'||lt_levels(j);
       end if;
    END LOOP;
--    lt_Res(li_i).vNo := lr.nRN||' '||lt_Totals(lt_Totals.count - 1)||' '||lr.nLev;
    if li_lev = 1 then
        if lt_levels(li_lev) = 1 then
            lt_Res(li_i).vName := rpad('Всего по АСКУЭ (авт. съём)', 35);
        elsif lt_levels(li_lev) = 2 then
            lt_Res(li_i).vName := rpad('Всего по ручному вводу', 35);
        end if;
    end if;
    declare
    CURSOR lc_HHO IS
    select to_char(date_time - 1/3600,'HH24') + 1 nHour, hho.* from halfHourOld hho
     where mid = lr.mid and date_time > FILEREPORT_PG.gd_from and date_time <= FILEREPORT_PG.gd_till
           and nExceptCalc is null;
    ln_Incr NUMBER;
    lt_InclIndexes tNumber;
    li_last NUMBER := li_i;
--    lt_Counter tNumber;
    ln_Counter NUMBER := 0;
    ln_0 NUMBER;
    begin
    ln_Counter := 0;
--    for j in 1..24 loop lt_Counter(j) := 0; end loop;
    FOR lr1 IN lc_HHO LOOP
       select (nvl(lr1.ed,0) - nvl(lr1.er,0))*decode(lr.inverted,'y',-1,'n',1,0)
        into ln_Incr from dual;
--       ln_Incr := (nvl(lr1.ed,0) - nvl(lr1.er,0));
--       lt_Counter(lr1.nHour) := lt_Counter(lr1.nHour) + 1;
       if (lr1.nSource <> 50 and lt_Totals(1) = 1) or
          (lr1.nSource = 50 and lt_Totals(1) <> 1) then
           ln_Counter := ln_Counter + 1;
       end if;
       declare
       lt_Dummy TNumber;
       PROCEDURE ProcessRow_p(ai_i IN NUMBER, at_Totals IN OUT TNumber) IS
           BEGIN
           for j in 0..at_Totals.count - 1 loop
               lt_Res(at_Totals(j)).nTotal := lt_Res(at_Totals(j)).nTotal + ln_Incr;
           end loop;
           lt_Res(ai_i).nTotal := lt_Res(ai_i).nTotal + ln_Incr;
           if lr1.nHour = 1 then
               for j in 0..at_Totals.count - 1 loop
                   lt_Res(at_Totals(j)).n1 := lt_Res(at_Totals(j)).n1 + ln_Incr;
               end loop;
               lt_Res(ai_i).n1 := lt_Res(ai_i).n1 + ln_Incr;
           elsif lr1.nHour = 2 then
               for j in 0..at_Totals.count - 1 loop
                   lt_Res(at_Totals(j)).n2 := lt_Res(at_Totals(j)).n2 + ln_Incr;
               end loop;
               lt_Res(ai_i).n2 := lt_Res(ai_i).n2 + ln_Incr;
           elsif lr1.nHour = 3 then
               for j in 0..at_Totals.count - 1 loop
                   lt_Res(at_Totals(j)).n3 := lt_Res(at_Totals(j)).n3 + ln_Incr;
               end loop;
               lt_Res(ai_i).n3 := lt_Res(ai_i).n3 + ln_Incr;
           elsif lr1.nHour = 4 then
               for j in 0..at_Totals.count - 1 loop
                   lt_Res(at_Totals(j)).n4 := lt_Res(at_Totals(j)).n4 + ln_Incr;
               end loop;
               lt_Res(ai_i).n4 := lt_Res(ai_i).n4 + ln_Incr;
           elsif lr1.nHour = 5 then
               for j in 0..at_Totals.count - 1 loop
                   lt_Res(at_Totals(j)).n5 := lt_Res(at_Totals(j)).n5 + ln_Incr;
               end loop;
               lt_Res(ai_i).n5 := lt_Res(ai_i).n5 + ln_Incr;
           elsif lr1.nHour = 6 then
               for j in 0..at_Totals.count - 1 loop
                   lt_Res(at_Totals(j)).n6 := lt_Res(at_Totals(j)).n6 + ln_Incr;
               end loop;
               lt_Res(ai_i).n6 := lt_Res(ai_i).n6 + ln_Incr;
           elsif lr1.nHour = 7 then
               for j in 0..at_Totals.count - 1 loop
                   lt_Res(at_Totals(j)).n7 := lt_Res(at_Totals(j)).n7 + ln_Incr;
               end loop;
               lt_Res(ai_i).n7 := lt_Res(ai_i).n7 + ln_Incr;
           elsif lr1.nHour = 8 then
               for j in 0..at_Totals.count - 1 loop
                   lt_Res(at_Totals(j)).n8 := lt_Res(at_Totals(j)).n8 + ln_Incr;
               end loop;
               lt_Res(ai_i).n8 := lt_Res(ai_i).n8 + ln_Incr;
           elsif lr1.nHour = 9 then
               for j in 0..at_Totals.count - 1 loop
                   lt_Res(at_Totals(j)).n9 := lt_Res(at_Totals(j)).n9 + ln_Incr;
               end loop;
               lt_Res(ai_i).n9 := lt_Res(ai_i).n9 + ln_Incr;
           elsif lr1.nHour = 10 then
               for j in 0..at_Totals.count - 1 loop
                   lt_Res(at_Totals(j)).n10 := lt_Res(at_Totals(j)).n10 + ln_Incr;
               end loop;
               lt_Res(ai_i).n10 := lt_Res(ai_i).n10 + ln_Incr;
           elsif lr1.nHour = 11 then
               for j in 0..at_Totals.count - 1 loop
                   lt_Res(at_Totals(j)).n11 := lt_Res(at_Totals(j)).n11 + ln_Incr;
               end loop;
               lt_Res(ai_i).n11 := lt_Res(ai_i).n11 + ln_Incr;
           elsif lr1.nHour = 12 then
               for j in 0..at_Totals.count - 1 loop
                   lt_Res(at_Totals(j)).n12 := lt_Res(at_Totals(j)).n12 + ln_Incr;
               end loop;
               lt_Res(ai_i).n12 := lt_Res(ai_i).n12 + ln_Incr;
           elsif lr1.nHour = 13 then
               for j in 0..at_Totals.count - 1 loop
                   lt_Res(at_Totals(j)).n13 := lt_Res(at_Totals(j)).n13 + ln_Incr;
               end loop;
               lt_Res(ai_i).n13 := lt_Res(ai_i).n13 + ln_Incr;
           elsif lr1.nHour = 14 then
               for j in 0..at_Totals.count - 1 loop
                   lt_Res(at_Totals(j)).n14 := lt_Res(at_Totals(j)).n14 + ln_Incr;
               end loop;
               lt_Res(ai_i).n14 := lt_Res(ai_i).n14 + ln_Incr;
           elsif lr1.nHour = 15 then
               for j in 0..at_Totals.count - 1 loop
                   lt_Res(at_Totals(j)).n15 := lt_Res(at_Totals(j)).n15 + ln_Incr;
               end loop;
               lt_Res(ai_i).n15 := lt_Res(ai_i).n15 + ln_Incr;
           elsif lr1.nHour = 16 then
               for j in 0..at_Totals.count - 1 loop
                   lt_Res(at_Totals(j)).n16 := lt_Res(at_Totals(j)).n16 + ln_Incr;
               end loop;
               lt_Res(ai_i).n16 := lt_Res(ai_i).n16 + ln_Incr;
           elsif lr1.nHour = 17 then
               for j in 0..at_Totals.count - 1 loop
                   lt_Res(at_Totals(j)).n17 := lt_Res(at_Totals(j)).n17 + ln_Incr;
               end loop;
               lt_Res(ai_i).n17 := lt_Res(ai_i).n17 + ln_Incr;
           elsif lr1.nHour = 18 then
               for j in 0..at_Totals.count - 1 loop
                   lt_Res(at_Totals(j)).n18 := lt_Res(at_Totals(j)).n18 + ln_Incr;
               end loop;
               lt_Res(ai_i).n18 := lt_Res(ai_i).n18 + ln_Incr;
           elsif lr1.nHour = 19 then
               for j in 0..at_Totals.count - 1 loop
                   lt_Res(at_Totals(j)).n19 := lt_Res(at_Totals(j)).n19 + ln_Incr;
               end loop;
               lt_Res(ai_i).n19 := lt_Res(ai_i).n19 + ln_Incr;
           elsif lr1.nHour = 20 then
               for j in 0..at_Totals.count - 1 loop
                   lt_Res(at_Totals(j)).n20 := lt_Res(at_Totals(j)).n20 + ln_Incr;
               end loop;
               lt_Res(ai_i).n20 := lt_Res(ai_i).n20 + ln_Incr;
           elsif lr1.nHour = 21 then
               for j in 0..at_Totals.count - 1 loop
                   lt_Res(at_Totals(j)).n21 := lt_Res(at_Totals(j)).n21 + ln_Incr;
               end loop;
               lt_Res(ai_i).n21 := lt_Res(ai_i).n21 + ln_Incr;
           elsif lr1.nHour = 22 then
               for j in 0..at_Totals.count - 1 loop
                   lt_Res(at_Totals(j)).n22 := lt_Res(at_Totals(j)).n22 + ln_Incr;
               end loop;
               lt_Res(ai_i).n22 :=lt_Res(ai_i).n22  + ln_Incr;
           elsif lr1.nHour = 23 then
               for j in 0..at_Totals.count - 1 loop
                   lt_Res(at_Totals(j)).n23 := lt_Res(at_Totals(j)).n23 + ln_Incr;
               end loop;
               lt_Res(ai_i).n23 := lt_Res(ai_i).n23 + ln_Incr;
           elsif lr1.nHour = 24 then
               for j in 0..at_Totals.count - 1 loop
                   lt_Res(at_Totals(j)).n24 := lt_Res(at_Totals(j)).n24 + ln_Incr;
               end loop;
               lt_Res(ai_i).n24 := lt_Res(ai_i).n24 + ln_Incr;
           end if;
           END;
       begin
       if (lr1.nSource <> 50 and lt_Totals(1) = 1) or
          (lr1.nSource = 50 and lt_Totals(1) <> 1) then
           ProcessRow_p(li_i, lt_Totals);
       end if;
       if (lr1.nSource <> 50 and lt_Totals(1) = 1) then
           if lr1.nSource in (30,40) then
               if not lt_InclIndexes.exists(30) then
                   li_last := li_last + 1;
                   lt_InclIndexes(30) := li_last;
                   lt_Res(lt_InclIndexes(30)) := rReset_f(lr);
                   lt_Res(lt_InclIndexes(30)).vName := rpad(' в т.ч. перевод на ОВ', 35);
                   lt_Res(lt_InclIndexes(30)).vNo := ' ';
               end if;
               ProcessRow_p(lt_InclIndexes(30), lt_Dummy);
           elsif lr1.nSource = 60 THEN
               if not lt_InclIndexes.exists(60) then
                   li_last := li_last + 1;
                   lt_InclIndexes(60) := li_last;
                   lt_Res(lt_InclIndexes(60)) := rReset_f(lr);
                   lt_Res(lt_InclIndexes(60)).vName := rpad(' в т.ч. ручной ввод', 35);
                   lt_Res(lt_InclIndexes(60)).vNo := ' ';
               end if;
               ProcessRow_p(lt_InclIndexes(60), lt_Dummy);
           end if;
       end if;
       end;
    END LOOP;
    if FILEREPORT_PG.gd_till > FILEREPORT_PG.gd_from and lr.mid is not null then
        lt_Res(li_i).nFullness := round(100*ln_Counter/((FILEREPORT_PG.gd_till - FILEREPORT_PG.gd_from)*48),5);
        for j in 0..lt_Totals.count - 1 loop
            lt_TotalsTotal(j) := lt_TotalsTotal(j) + (FILEREPORT_PG.gd_till - FILEREPORT_PG.gd_from)*48;
            lt_TotalsCounter(j) := lt_TotalsCounter(j) + ln_Counter;
            if j = 0 then ln_0 := 2; else ln_0 := 1; end if;
            lt_Res(lt_Totals(j)).nFullness := round(ln_0*100*lt_TotalsCounter(j)/lt_TotalsTotal(j),5);
        end loop;
    end if;
    li_i := li_last;
    end;

END LOOP;
return lt_Res;
END;

END;
/

-- End of DDL script for PLSQL2_PG

-- Start of DDL script for PLSQL3_PG
-- Generated 27-янв-03  11:34:02 am
-- from oe-RYDA:1

-- Package body PLSQL3_PG

CREATE OR REPLACE
PACKAGE BODY plsql3_pg IS
  ------------------------------------------------------------------------------------------------------------------------
    -- пакет по созданию отчетов в файл
    -- дата создания 27/07/2002 Сечин А.А.
 ------------------------------------------------------------------------------------------------------------------------
 PROCEDURE report1_p IS
  CURSOR lcur_sel IS
   SELECT c2.mid lg, c1.mid itek /*,p2.name,p1.name,c2.*,c1.**/
     FROM (SELECT f.mid, ch.cid, f.er_position
             FROM channels ch, chanpoint cp, feeders f
            WHERE ch.protocol_id = 3 AND ch.vname LIKE 'я%' AND ch.blocking = 0 AND ch.cid = cp.cid AND cp.mid = f.mid) c1,
          (SELECT f.mid, ch.cid, f.er_position
             FROM channels ch, chanpoint cp, feeders f
            WHERE ch.protocol_id = 19
              AND ch.cid IN (30913, 30787, 30917, 30947, 30919)
              AND ch.cid = cp.cid
              AND cp.mid = f.mid) c2,
          points p1, points p2
    WHERE DECODE(c1.cid, 31516, 30787, 31629, 30917, 31732, 30913, 31873, 30947, 32040, 30919) = c2.cid
      AND c1.er_position = c2.er_position
      AND c1.mid = p1.mid
      AND c2.mid = p2.mid;
  ln_maxdiff NUMBER default 1;
 BEGIN
  for lc in lcur_sel loop
   filereport_pg.put_p(lc.lg||' '||lc.itek);
  end loop;
 END;
-----------------------------------------------------------------------------------------------------------------------
END; -- Package Body plsql1_pg
/

-- End of DDL script for PLSQL3_PG

-- Start of DDL script for POINTCALC_PG
-- Generated 27-янв-03  11:34:02 am
-- from oe-RYDA:1

-- Package body POINTCALC_PG

CREATE OR REPLACE
Package Body    POINTCALC_PG IS
/*Если установлены режим работы присоединения (nWorkingHours, nShifts) и (или)
время его включения (nFullHours), для текущего месяца (в ConnectionParamFullHours)
или постоянный (в ConnectionParam), то для расчета потерь используются эти значения.
Если установлены режимы работы точек, подключенных к присоединению (nWorkTimeType,
nWorkingHours, nDayHours), и (или) времена их включения (nFullHours), для текущего месяца
(в PointFullHours) или постоянные (в PointI), то для расчета потерь используются
максимальные не равные нулю по величине режим работы и времена включения этих точек.
Равенство нулю режима работы или времени включения одной из этих точек означает
равенство нулю режима работы и (или) времени включения, использующегося для расчета потерь.
Иначе для расчета потерь в качестве режима работы и времени включения используются календарные
часы месяца расчета.
Режим работы, использующийся для расчета потерь, меньше или равен времени включения,
использующегося для расчета потерь.*/
------------------------------------------------------------------------------------------------
FUNCTION F_GetTypePot(an_Point IN NUMBER) RETURN VARCHAR2 IS
 ln_ret NUMBER;
BEGIN
 SELECT nvl(max(nWastePercentCalc),0) into ln_ret FROM feeders PO
   WHERE mid=an_Point;
 IF ln_ret=1 THEN
    return '%';
 ELSIF ln_ret=2 THEN
    return 'Фп';
 ELSIF ln_ret=3 THEN
    return '%2';
 ELSIF ln_ret=4 THEN
    select count(*) into ln_ret from dual where exists
    (SELECT mid nPoint FROM ConnectionParam WHERE mid=an_Point
    UNION ALL
    SELECT mid nPoint FROM SharedConnectionParam WHERE mid=an_Point);
    IF ln_ret=1 THEN
        return 'Ф';
    END IF;
 END IF;

 return 'Н';
END;
------------------------------------------------------------------------------------------------
PROCEDURE P_SetPoterCoef(an_RezNew IN OUT TR_PoterCoef,an_Coef IN NUMBER) IS
BEGIN
   an_RezNew.Z:=an_Coef;
   an_RezNew.Z1:=an_Coef;
   an_RezNew.Z2:=an_Coef;
   an_RezNew.Z3:=an_Coef;
   an_RezNew.H:=an_Coef;
   an_RezNew.D:=an_Coef;
END;
------------------------------------------------------------------------------------------------
FUNCTION F_ProvVar1(an_PARALLELCONNECTION NUMBER) RETURN NUMBER IS
ln_ret NUMBER;
 CURSOR lcur_sel IS
 /*Ищем параллельные присоединения и их время работы (To)*/
 SELECT nconnectionparam FROM ConnectionParam WHERE NPARALLELCONNECTION=an_PARALLELCONNECTION;
 CURSOR lcur_p(lc_param IN NUMBER) IS
  SELECT C.mid nPoint FROM Connectionparam C
  WHERE C.nConnectionparam=lc_param and C.NNOTINCLUDECONSUMP=0
  UNION ALL
  SELECT C.mid nPoint FROM SharedConnectionparam C
  WHERE C.nConnectionparam=lc_param and C.NNOTINCLUDECONSUMP=0;
BEGIN
  SELECT count(*) into ln_ret FROM ConnectionParam WHERE NPARALLELCONNECTION=an_PARALLELCONNECTION;
  IF ln_ret<2 THEN RETURN 0;
  END IF;
  FOR LC IN lcur_sel LOOP
    FOR LCP IN lcur_p(LC.nconnectionparam) LOOP
      select count(*) into ln_ret from dual where exists
       (select mid npoint from connectionparam where mid=LCP.nPoint
        and NNOTINCLUDECONSUMP=0 and nConnectionparam<>LC.nconnectionparam
        and nConnectionparam in (SELECT nconnectionparam FROM ConnectionParam
                                 WHERE NPARALLELCONNECTION=an_PARALLELCONNECTION )
        UNION ALL
        select mid npoint from sharedconnectionparam where mid=LCP.nPoint
        and NNOTINCLUDECONSUMP=0 and nConnectionparam<>LC.nconnectionparam
        and nConnectionparam in (SELECT nconnectionparam FROM ConnectionParam
                                 WHERE NPARALLELCONNECTION=an_PARALLELCONNECTION));
      IF ln_ret>0 THEN RETURN 1;
      END IF;
    END LOOP;
  END LOOP;
  RETURN 0;
END;
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
PROCEDURE P_GetSharesConsumption(an_ParallelConnection NUMBER,an_mid NUMBER,
                                 an_AccPeriod NUMBER,an_SA IN OUT NUMBER,an_SR IN OUT NUMBER) IS
 CURSOR lcur_sel IS
 SELECT C.nconnectionparam FROM ConnectionParam C WHERE C.NPARALLELCONNECTION=an_PARALLELCONNECTION
 AND EXISTS (select nconnectionparam from ConnectionParam WHERE mid=an_mid AND nconnectionparam=C.nconnectionparam
             union all
             select nconnectionparam from SharedConnectionParam WHERE mid=an_mid AND nconnectionparam=C.nconnectionparam);
 CURSOR lcur_p(lc_param IN NUMBER) IS
  SELECT c.mid nPoint
  FROM Connectionparam C
  WHERE C.nConnectionparam=lc_param and C.NNOTINCLUDECONSUMP=0
  UNION
  SELECT c.mid nPoint
  FROM SharedConnectionparam C
  WHERE C.nConnectionparam=lc_param and C.NNOTINCLUDECONSUMP=0;
 ln_A NUMBER;
 ln_R NUMBER;
BEGIN
    an_SA:=0; an_SR:=0;
    FOR LC IN lcur_sel LOOP
        FOR LCP IN lcur_p(LC.nconnectionparam) LOOP
          SELECT  nvl(SUM(nvl(er,0)*DECODE(nWasteabs,1,0,1)),0),
                  nvl(SUM(nvl(q1,0)*DECODE(nWasteabs,1,0,1)),0) INTO ln_A,ln_R FROM RYDA.BILL
          WHERE mid=LCP.nPoint AND date_time>to_date(an_AccPeriod,'YYYYMM')
              and date_time<=ADD_MONTHS(to_date(an_AccPeriod,'YYYYMM'),1);
          an_SA:=an_SA+ln_A;
          an_SR:=an_SR+ln_R;
        END LOOP;
    END LOOP;
END;
------------------------------------------------------------------------------------------------
FUNCTION F_GetParallelProc(an_PARALLELCONNECTION NUMBER,an_AccPeriod NUMBER,an_CurrentT0 NUMBER) RETURN NUMBER IS
ln_ret NUMBER;
ln_DayCount NUMBER default to_number(to_char(last_day(to_date(an_AccPeriod,'YYYYMM')),'DD')); --Кол-во дней в месяце
ln_maxT0 NUMBER;
ln_AllT0 NUMBER default 0;
 CURSOR lcur_sel IS
 /*Ищем параллельные присоединения и их время работы (To)*/
 SELECT nconnectionparam,nfullhours FROM ConnectionParam WHERE NPARALLELCONNECTION=an_PARALLELCONNECTION;
 CURSOR lcur_p(lc_param IN NUMBER) IS
  SELECT nvl(PH.nfullhours,PI.nfullhours) nfullhours FROM Connectionparam C,feeders PI,POINTFULLHOURS PH
  WHERE C.nConnectionparam=lc_param
  AND C.mid=PI.mid(+)
  AND PI.mid=PH.mid(+) AND an_AccPeriod=PH.NACCPERIOD(+)
  UNION ALL
  SELECT nvl(PH.nfullhours,PI.nfullhours) nfullhours FROM SharedConnectionparam C,feeders PI,POINTFULLHOURS PH
  WHERE C.nConnectionparam=lc_param
  AND C.mid=PI.mid(+)
  AND PI.mid=PH.mid(+) AND an_AccPeriod=PH.NACCPERIOD(+);
BEGIN
  SELECT count(*) into ln_ret FROM ConnectionParam WHERE NPARALLELCONNECTION=an_PARALLELCONNECTION;
  IF ln_ret<2 THEN RETURN 1;
  END IF;
  FOR LC IN lcur_sel LOOP
      ln_maxT0:=LC.nfullhours;
      IF ln_maxT0 IS NULL THEN
          FOR LCP IN lcur_p(LC.nconnectionparam) LOOP
              ln_maxT0:=GREATEST(nvl(LCP.nfullhours,ln_maxT0),nvl(ln_maxT0,LCP.nfullhours));
          END LOOP;
      END IF;
      ln_AllT0:=ln_AllT0+nvl(ln_maxT0,ln_DayCount*24);
  END LOOP;
  IF ln_AllT0=0 THEN
      RETURN 0;
  END IF;
  RETURN least(an_CurrentT0/ln_AllT0,1);--least(an_CurrentT0,ln_DayCount*24)/least(ln_AllT0,ln_DayCount*24);
END;
------------------------------------------------------------------------------------------------
PROCEDURE F_GetPoterNew(lr_PoterTemp IN OUT TR_PoterCoef,an_mid IN NUMBER,an_Act IN NUMBER,
                         an_AccPeriod IN NUMBER,an_PotrebOnly IN NUMBER) IS
 ln_A NUMBER; ln_A1 NUMBER; ln_A2 NUMBER; ln_A3 NUMBER;
 ln_R NUMBER; ln_R1 NUMBER; ln_R2 NUMBER; ln_R3 NUMBER;
 ln_PR1 NUMBER; ln_PR2 NUMBER;
 ln_S2 NUMBER; ln_SA NUMBER; ln_SR NUMBER;
 ln_Count NUMBER;
 lb_find BOOLEAN;
 ln_DayCount NUMBER default to_number(to_char(last_day(to_date(an_AccPeriod,'YYYYMM')),'DD')); --Кол-во дней в месяце
 ln_Point_workinghours NUMBER;
 ln_max_workinghours NUMBER;
 ln_Point_T0 NUMBER;
 ln_maxT0 NUMBER;
 ln_ProcParallel NUMBER;
 ln_ProvVar1 NUMBER;
-----------------------
 CURSOR lcur_sel IS
 /*Ищет всевозможные присоединения и их параметры для расчета потерь,
   где фигурирует точка с ид.=an_mid*/
 SELECT c.nconnectionparam, nvl(c.nsn,1) nsn, nvl(nsh,nvl(c.nsn,1)) nsh, nvl(c.ndeltapidling,0) ndeltapidling,
  nvl(c.ndeltapsc,0) ndeltapsc, nvl(c.niidling,0) niidling, nvl(c.nusc,0) nusc, nvl(c.nro,0) nro,
  nvl(c.nxo,0) nxo, nvl(c.nl,0) nl, nvl(c.nun,1) nun,(nvl(c.nenergypercent,100)/100) nenergypercent,
  nvl(ph.NWORKINGHOURS,nvl(c.NWORKINGHOURS,DECODE(999,3,700,1,200,2,450,NULL))) NWORKINGHOURS,c.NPARALLELCONNECTION,
  nvl(ph.NFULLHOURS,c.nfullhours) nfullhours,c.NNOTINCLUDECONSUMP,1 mainpoint
  FROM ConnectionParam c,CONNECTIONPARAMFULLHOURS ph WHERE c.mid=an_mid and
  c.NCONNECTIONPARAM=ph.NCONNECTIONPARAM(+) and an_AccPeriod=ph.nAccPeriod(+)
 UNION ALL
 SELECT C.nconnectionparam, nvl(C.nsn,1) nsn, nvl(nsh,nvl(c.nsn,1)) nsh, nvl(C.ndeltapidling,0) ndeltapidling,
  nvl(C.ndeltapsc,0) ndeltapsc, nvl(C.niidling,0) niidling, nvl(C.nusc,0) nusc, nvl(C.nro,0) nro,
  nvl(C.nxo,0) nxo, nvl(C.nl,0) nl, nvl(C.nun,1) nun,(nvl(C.nenergypercent,100)/100) nenergypercent,
  nvl(ph.NWORKINGHOURS,nvl(C.NWORKINGHOURS,DECODE(999,3,700,1,200,2,450,NULL))) NWORKINGHOURS,C.NPARALLELCONNECTION,
  nvl(ph.NFULLHOURS,C.nfullhours) nfullhours,S.NNOTINCLUDECONSUMP,0 mainpoint
  FROM ConnectionParam C,SharedConnectionParam S,CONNECTIONPARAMFULLHOURS ph
  WHERE S.mid=an_mid
  AND S.nConnectionParam=C.nConnectionParam(+) AND
  c.NCONNECTIONPARAM=ph.NCONNECTIONPARAM(+) and an_AccPeriod=ph.nAccPeriod(+);
 CURSOR lcur_p(lc_param NUMBER) IS
 /*Ищем все точки которые участвуют в доле по дележке потерь присоединения
   NNOTINCLUDECONSUMP - отвечает за включение расхода по точке в общее потребление по присоединению*/
  SELECT mid npoint,NNOTINCLUDECONSUMP FROM Connectionparam WHERE nConnectionparam=lc_param
  UNION ALL
  SELECT mid npoint,NNOTINCLUDECONSUMP FROM SharedConnectionparam WHERE nConnectionparam=lc_param ;
 CURSOR lcur_ss(lc_mid IN NUMBER) IS SELECT
 /*Дотягиваем информацию по остальным точкам, участвующим в дележке потерь
   а именно часы работы и наличае счетчиков для ответа на вопрос: Как счмтать
   расход реактивной (по активной или по показаниям реактивной)*/
   nvl(PH.NWORKINGHOURS,PI.nworkinghours) Point_workinghours,
   nvl(PH.nfullhours,PI.nfullhours) nfullhours
  FROM feeders PI, POINTFULLHOURS PH
  WHERE PI.mid=lc_mid and
  PI.mid=PH.mid(+) AND an_AccPeriod=PH.NACCPERIOD(+);
BEGIN
 P_SetPoterCoef(lr_PoterTemp,0); --Зануляем lr_PoterTemp

 IF an_PotrebOnly=1 THEN --мы не считаем потери, а считаем потребление по точке за месяц
    SELECT
     nvl(SUM(nvl(er,0)*DECODE(nWasteabs,1,0,1)),0), --Мы игнорируем записи с nWasteabs=1 (по уст. мощности)
     nvl(SUM(nvl(aer,0)*DECODE(nWasteabs,1,0,1)),0),  -- Актив
     nvl(SUM(nvl(ber,0)*DECODE(nWasteabs,1,0,1)),0),
     nvl(SUM(nvl(cer,0)*DECODE(nWasteabs,1,0,1)),0),
     nvl(SUM(nvl(q1,0)*DECODE(nWasteabs,1,0,1)),0),
     nvl(SUM(nvl(aq1,0)*DECODE(nWasteabs,1,0,1)),0),  -- Рактив
     nvl(SUM(nvl(bq1,0)*DECODE(nWasteabs,1,0,1)),0),
     nvl(SUM(nvl(cq1,0)*DECODE(nWasteabs,1,0,1)),0)
     INTO ln_A,ln_A1,ln_A2,ln_A3,ln_R,ln_R1,ln_R2,ln_R3
     FROM RYDA.BILL WHERE mid=an_mid AND
       date_time>to_date(an_AccPeriod,'YYYYMM') and date_time<=ADD_MONTHS(to_date(an_AccPeriod,'YYYYMM'),1);

     IF an_Act=1 THEN --Нужно по активной
         lr_PoterTemp.Z:=ln_A;
         lr_PoterTemp.Z1:=ln_A1;
         lr_PoterTemp.Z2:=ln_A2;
         lr_PoterTemp.Z3:=ln_A3;
     ELSE--Нужно по реактивной
         open lcur_ss(an_mid);
         FETCH lcur_ss into ln_Point_workinghours,ln_Point_T0;
         IF lcur_ss%NOTFOUND THEN
             close lcur_ss;
             return;
         END IF;
         close lcur_ss;

             lr_PoterTemp.Z:=ln_R;
             lr_PoterTemp.Z1:=ln_R1;
             lr_PoterTemp.Z2:=ln_R2;
             lr_PoterTemp.Z3:=ln_R3;
     END IF;
     return;
 END IF;

 SELECT COUNT(*) into ln_A FROM DUAL WHERE
  EXISTS (SELECT * FROM ConnectionParam WHERE mid=an_mid ) OR
  EXISTS (SELECT * FROM SharedConnectionParam WHERE mid=an_mid );
 IF ln_A=0 THEN --Если нет потерь
     return;
 END IF;

 /*Далее мы считаем потери. Берем все присоединения, где фигурирует точка.
   Считаем расход по всем точкам привязанным к данному присоединению и на этот расход считаем
   потери. Берем свою часть (пропорционально расходу). Причем, если участвует одна точка, то
   все потери вешаются на нее (это принципиально, если расход=0 а потери есть {потери холостого хода} )
   Часы работы трансформатора ln_max_workinghours и время всей работы ln_maxT0
   (обычно не задано и следовательно равно кол-ву часов в месяце) ищутся как
   максимальные среди всех точек и самого присоединения*/
 FOR LC in lcur_sel LOOP
    SELECT count(*) into ln_Count FROM Connectionparam C,feeders P
    WHERE C.nConnectionparam=LC.nConnectionparam
    and C.mid=P.mid(+);
    SELECT count(*) into ln_A FROM SharedConnectionparam C,feeders P
    WHERE C.nConnectionparam=LC.nConnectionparam
    and C.mid=P.mid(+);
    ln_Count:=ln_Count+ln_A;
    IF ln_Count=0 THEN
        NULL;
    ELSIF ln_Count=1 THEN --Не долевые
        IF nvl(LC.NWORKINGHOURS,1)<>0 THEN
          SELECT
          nvl(PH.NWORKINGHOURS,PI.nworkinghours),
          nvl(PH.nfullhours,nvl(nvl(LC.nfullhours,PI.nfullhours),ln_DayCount*24))
          into ln_max_workinghours,ln_maxT0
          FROM feeders PI, POINTFULLHOURS PH
          WHERE PI.mid=an_mid and
          PI.mid=PH.mid(+) AND an_AccPeriod=PH.NACCPERIOD(+);
          IF LC.NNOTINCLUDECONSUMP<>1 THEN
              SELECT  nvl(SUM(nvl(er,0)*DECODE(nWasteabs,1,0,1)),0),
                      nvl(SUM(nvl(q1,0)*DECODE(nWasteabs,1,0,1)),0) INTO ln_A,ln_R FROM RYDA.BILL
              WHERE mid=an_mid AND date_time>to_date(an_AccPeriod,'YYYYMM')
                  and date_time<=ADD_MONTHS(to_date(an_AccPeriod,'YYYYMM'),1);
          ELSE
              ln_A:=0;  ln_R:=0;
          END IF;
          ln_maxT0:=least(ln_maxT0,ln_DayCount*24);
          ln_max_workinghours:=least(ln_maxT0,nvl(GREATEST(nvl(LC.NWORKINGHOURS,ln_max_workinghours),nvl(ln_max_workinghours,LC.NWORKINGHOURS)),ln_DayCount*24),ln_DayCount*24);
          IF ln_max_workinghours>0 THEN --Если max время работы=0, то потери равны 0 (так договорились)
            /*Та формула , что  на бумаге немного переписана. Отделены два слагаемых
              которые содержат сумму квадратов расхода и которые не содержат*/
            IF an_Act=1 THEN --активные потери
                ln_PR1:=LC.ndeltapidling*ln_maxT0;
                ln_PR2:=(LC.ndeltapsc/(LC.nsh*LC.nsh*ln_max_workinghours))+
                            (((LC.nl/1000)*LC.nro)/(ln_max_workinghours*LC.nun*LC.nun));
            ELSE --реактивные потери
                ln_PR1:=(LC.nsn*LC.niidling)*(ln_maxT0/100);
                ln_PR2:=(LC.nusc/(100*LC.nsh*ln_max_workinghours))+
                            (((LC.nl/1000)*LC.nxo)/(ln_max_workinghours*LC.nun*LC.nun));
            END IF;
            lr_PoterTemp.Z:=lr_PoterTemp.Z+(ln_PR1+(ln_A*ln_A+ln_R*ln_R)*ln_PR2)*LC.nenergypercent;
          END IF;
        END IF;
    ELSE --Долевые
      ln_ProvVar1:=F_ProvVar1(LC.NPARALLELCONNECTION);
      ln_Count:=0;    ln_SA:=0;   ln_SR:=0;   ln_A1:=0;   ln_R1:=0;   lb_find:=false;
      ln_max_workinghours:=LC.NWORKINGHOURS;
      ln_maxT0:=NULL;
      FOR LCP IN lcur_p(LC.nconnectionparam) LOOP
          open lcur_ss(LCP.nPoint);
          FETCH lcur_ss into ln_Point_workinghours,ln_Point_T0;
          close lcur_ss;
              ln_Count:=ln_Count+1;
              SELECT  nvl(SUM(nvl(er,0)*DECODE(nWasteabs,1,0,1)),0),
                      nvl(SUM(nvl(q1,0)*DECODE(nWasteabs,1,0,1)),0) INTO ln_A,ln_R FROM RYDA.BILL
              WHERE mid=LCP.npoint AND date_time>to_date(an_AccPeriod,'YYYYMM')
                  and date_time<=ADD_MONTHS(to_date(an_AccPeriod,'YYYYMM'),1);
              IF LCP.nPoint=an_mid THEN
                  ln_A1:=ln_A;     ln_R1:=ln_R;   lb_find:=true;
              END IF;
              IF ln_Point_T0 IS NOT NULL THEN
                  ln_maxT0:=GREATEST(ln_Point_T0,nvl(ln_maxT0,ln_Point_T0));
              END IF;
              IF ln_Point_workinghours IS NOT NULL THEN
                  ln_max_workinghours:=GREATEST(ln_Point_workinghours,nvl(ln_max_workinghours,ln_Point_workinghours));
              END IF;
              IF LCP.NNOTINCLUDECONSUMP<>1 THEN
                  ln_SA:=ln_SA+ln_A;  ln_SR:=ln_SR+ln_R;
              END IF;
      END LOOP;
      IF ln_Count>0 THEN
          IF LC.NWORKINGHOURS=0 THEN --Если на параметре присоединения время работы=0, то потери равны 0 (так договорились)
              ln_PR1:=0;
              ln_PR2:=0;
          ELSE
              ln_maxT0:=least(nvl(nvl(LC.nfullhours,ln_maxT0),ln_DayCount*24),ln_DayCount*24);
              ln_max_workinghours:=least(ln_maxT0,nvl(ln_max_workinghours,ln_DayCount*24),ln_DayCount*24);
              IF ln_max_workinghours=0 THEN --Если max время работы=0, то потери равны 0 (так договорились)
                  ln_PR1:=0;
                  ln_PR2:=0;
              ELSE
                  IF an_Act=1 THEN --активные потери
                      ln_PR1:=LC.ndeltapidling*ln_maxT0;
                      ln_PR2:=(LC.ndeltapsc/(LC.nsh*LC.nsh*ln_max_workinghours))+
                                  (((LC.nl/1000)*LC.nro)/(ln_max_workinghours*LC.nun*LC.nun));
                  ELSE --реактивные потери
                      ln_PR1:=(LC.nsn*LC.niidling)*(ln_maxT0/100);
                      ln_PR2:=(LC.nusc/(100*LC.nsh*ln_max_workinghours))+
                                  (((LC.nl/1000)*LC.nxo)/(ln_max_workinghours*LC.nun*LC.nun));
                  END IF;
              END IF;
          END IF;
          IF ln_ProvVar1=1 THEN--спаренные трансформаторы без счетчиков
              ln_ProcParallel:=F_GetParallelProc(LC.NPARALLELCONNECTION,an_AccPeriod,ln_maxT0);
          ELSE
              ln_ProcParallel:=1;
          END IF;
          ln_S2:=Round(ln_ProcParallel*ln_SA)*Round(ln_ProcParallel*ln_SA)+
                 Round(ln_ProcParallel*ln_SR)*Round(ln_ProcParallel*ln_SR); --сумма квадратов расходов с весом каждого трансформатора
          IF ln_Count=1 AND lb_find AND (LC.nParallelConnection IS NULL OR ln_ProvVar1=1) THEN --одна точка
              lr_PoterTemp.Z:=lr_PoterTemp.Z+(ln_PR1+ln_S2*ln_PR2)*LC.nenergypercent;
          ELSIF (LC.nParallelConnection IS NULL OR ln_ProvVar1=1) THEN
              IF an_Act=1 THEN --пропорция
                IF Abs(ln_SA)>0 THEN
                  lr_PoterTemp.Z:=lr_PoterTemp.Z+(ln_PR1+ln_S2*ln_PR2)*LC.nenergypercent*least(ln_A1/ln_SA,1);
                ELSIF Abs(ln_SA)=0 THEN
                  IF LC.mainpoint=1 THEN
                    NULL;--Если закоментировать следующую строчку, то потери холостого хода без расхода не будут учитываться
                    lr_PoterTemp.Z:=lr_PoterTemp.Z+(ln_PR1+ln_S2*ln_PR2)*LC.nenergypercent;
                  END IF;
                END IF;
              ELSIF nvl(an_Act,0)<>1 THEN
               IF an_AccPeriod<200203 THEN--Потери по старому (реактив)
                IF Abs(ln_SR)>0 THEN
                  lr_PoterTemp.Z:=lr_PoterTemp.Z+(ln_PR1+ln_S2*ln_PR2)*LC.nenergypercent*least(ln_R1/ln_SR,1);
                ELSIF Abs(ln_SR)=0 THEN
                  IF LC.mainpoint=1 THEN
                    NULL;--Если закоментировать следующую строчку, то потери холостого хода без расхода не будут учитываться
                    lr_PoterTemp.Z:=lr_PoterTemp.Z+(ln_PR1+ln_S2*ln_PR2)*LC.nenergypercent;
                  END IF;
                END IF;
               ELSE--Потери по новому
                IF Abs(ln_SA)>0 THEN
                  lr_PoterTemp.Z:=lr_PoterTemp.Z+(ln_PR1+ln_S2*ln_PR2)*LC.nenergypercent*least(ln_A1/ln_SA,1);
                ELSIF Abs(ln_SA)=0 THEN
                  IF LC.mainpoint=1 THEN
                    NULL;--Если закоментировать следующую строчку, то потери холостого хода без расхода не будут учитываться
                    lr_PoterTemp.Z:=lr_PoterTemp.Z+(ln_PR1+ln_S2*ln_PR2)*LC.nenergypercent;
                  END IF;
                END IF;
               END IF;
              END IF;
          ELSE
              P_GetSharesConsumption(LC.nParallelConnection,an_mid,an_AccPeriod,ln_SA,ln_SR);
              IF an_Act=1 THEN --пропорция
                IF Abs(ln_SA)>0 THEN
                  lr_PoterTemp.Z:=lr_PoterTemp.Z+(ln_PR1+ln_S2*ln_PR2)*LC.nenergypercent*least(ln_A1/ln_SA,1);
                ELSIF Abs(ln_SA)=0 THEN
                  IF LC.mainpoint=1 THEN
                    NULL;--Если закоментировать следующую строчку, то потери холостого хода без расхода не будут учитываться
                    lr_PoterTemp.Z:=lr_PoterTemp.Z+(ln_PR1+ln_S2*ln_PR2)*LC.nenergypercent;
                  END IF;
                END IF;
              ELSIF nvl(an_Act,0)<>1 THEN
               IF an_AccPeriod<200203 THEN--Потери по старому (реактив)
                IF Abs(ln_SR)>0 THEN
                  lr_PoterTemp.Z:=lr_PoterTemp.Z+(ln_PR1+ln_S2*ln_PR2)*LC.nenergypercent*least(ln_R1/ln_SR,1);
                ELSIF Abs(ln_SR)=0 THEN
                  IF LC.mainpoint=1 THEN
                    NULL;--Если закоментировать следующую строчку, то потери холостого хода без расхода не будут учитываться
                    lr_PoterTemp.Z:=lr_PoterTemp.Z+(ln_PR1+ln_S2*ln_PR2)*LC.nenergypercent;
                  END IF;
                END IF;
               ELSE
                IF Abs(ln_SA)>0 THEN
                  lr_PoterTemp.Z:=lr_PoterTemp.Z+(ln_PR1+ln_S2*ln_PR2)*LC.nenergypercent*least(ln_A1/ln_SA,1);
                ELSIF Abs(ln_SA)=0 THEN
                  IF LC.mainpoint=1 THEN
                    NULL;--Если закоментировать следующую строчку, то потери холостого хода без расхода не будут учитываться
                    lr_PoterTemp.Z:=lr_PoterTemp.Z+(ln_PR1+ln_S2*ln_PR2)*LC.nenergypercent;
                  END IF;
                END IF;
               END IF;
              END IF;
          END IF;
      END IF;
    END IF;
 END LOOP;
END;
------------------------------------------------------------------------------------------------
FUNCTION F_Waste(an_AccPeriod IN NUMBER,an_mid IN NUMBER,av_Zone IN VARCHAR2,an_Act IN NUMBER) RETURN NUMBER IS
 ln_Rez NUMBER;
 ln_RezNew TR_PoterCoef;
 ln_RezNew1 TR_PoterCoef;
 ln_PoterA NUMBER;
 ln_PoterR NUMBER;
 ln_Poter NUMBER;
 ln_WastePercentCalc NUMBER;
 ln_Count NUMBER;
 ln_RezOut NUMBER;
 CURSOR lcur_Coef IS -- Вытягиваем процент потерь (для потерь не по формуле)
  SELECT nvl(PO.LINE_LOSS,0)+nvl(PO.ACT_LOSS,0),
                nvl(PO.REACT_LOSS,0),nWastePercentCalc
   FROM feeders PO WHERE PO.mid=an_mid;
BEGIN
/*Примечание:
    Если требуются потери по зоне, то считаем сумарные потери, а потом берем зонное вложение.*/
    open lcur_Coef;
    fetch lcur_Coef into ln_PoterA,ln_PoterR,ln_WastePercentCalc;
    IF lcur_Coef%NOTFOUND THEN
        close lcur_Coef;
        return 0;
    END IF;
    close lcur_Coef;

    IF ln_WastePercentCalc=0 THEN
        return 0;
    ELSIF ln_WastePercentCalc=4 THEN --Потери по формуле
        F_GetPoterNew(ln_RezNew,an_mid,an_Act,an_AccPeriod,0); --Считаем потери в ln_RezNew
        IF av_Zone='A' OR av_Zone='B' OR av_Zone='C' THEN --Потери по каждой зоне
            F_GetPoterNew(ln_RezNew1,an_mid,an_Act,an_AccPeriod,1); --Считаем расход в ln_RezNew1

            IF ln_RezNew1.Z1+ln_RezNew1.Z2+ln_RezNew1.Z3=0 THEN
                IF av_Zone='C' THEN --Ошибки округления на третью зону
                    return Round(ln_RezNew.Z);
                ELSE
                    return 0;
                END IF;
            END IF;
            ln_Rez:=Round(ln_RezNew.Z);

            IF av_Zone='A' THEN --Делим потери по зоне пропорционально вложению зоны
                ln_Rez:=Round((ln_Rez*ln_RezNew1.Z1)/(ln_RezNew1.Z1+ln_RezNew1.Z2+ln_RezNew1.Z3));
            ELSIF av_Zone='B' THEN
                ln_Rez:=Round((ln_Rez*ln_RezNew1.Z2)/(ln_RezNew1.Z1+ln_RezNew1.Z2+ln_RezNew1.Z3));
            ELSE
                ln_Rez:=Round(ln_Rez-
                     Round((ln_Rez*ln_RezNew1.Z1)/(ln_RezNew1.Z1+ln_RezNew1.Z2+ln_RezNew1.Z3))-
                     Round((ln_Rez*ln_RezNew1.Z2)/(ln_RezNew1.Z1+ln_RezNew1.Z2+ln_RezNew1.Z3)));
            END IF;
        ELSE --потери без зон
            ln_Rez:=ln_RezNew.Z;
        END IF;
    ELSE
        IF ln_WastePercentCalc>4 THEN --На будущее
            return 0;
        END IF;
        IF an_Act=1 THEN
            ln_Poter:=ln_PoterA;
        ELSE
            ln_Poter:=ln_PoterR;
        END IF;

        F_GetPoterNew(ln_RezNew,an_mid,an_Act,an_AccPeriod,1); --Считаем расход по точке в ln_RezNew
        IF ln_WastePercentCalc=1 THEN --потери в процентах
            ln_Rez:=Round(ln_RezNew.Z*ln_Poter/100);
        ELSIF ln_WastePercentCalc=2 THEN -- фиксированые потери
            ln_Rez:=ln_Poter;
        ELSIF ln_WastePercentCalc=3 THEN --потери процент в квадрате
            ln_Rez:=Round(ln_RezNew.Z*ln_RezNew.Z*ln_Poter/100000);
        END IF;

        IF av_Zone='A' OR av_Zone='B' OR av_Zone='C' THEN --если по зоне то процентовка
            IF ln_RezNew.Z1+ln_RezNew.Z2+ln_RezNew.Z3=0 THEN
                IF av_Zone='C' THEN --Ошибки округления на третью зону
                    return Round(ln_Rez);
                ELSE
                    return 0;
                END IF;
            END IF;

            IF av_Zone='A' THEN
                ln_Rez:=Round((ln_Rez*ln_RezNew.Z1)/(ln_RezNew.Z1+ln_RezNew.Z2+ln_RezNew.Z3));
            ELSIF av_Zone='B' THEN
                ln_Rez:=Round((ln_Rez*ln_RezNew.Z2)/(ln_RezNew.Z1+ln_RezNew.Z2+ln_RezNew.Z3));
            ELSE --ошибки округления на 3 зону
                ln_Rez:=Round(ln_Rez-
                     Round((ln_Rez*ln_RezNew.Z1)/(ln_RezNew.Z1+ln_RezNew.Z2+ln_RezNew.Z3))-
                     Round((ln_Rez*ln_RezNew.Z2)/(ln_RezNew.Z1+ln_RezNew.Z2+ln_RezNew.Z3)));
            END IF;
        END IF;
    END IF;

    return ROUND(ln_Rez);
END;
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
PROCEDURE P_DayGetSharesConsumption(an_ParallelConnection NUMBER,an_mid NUMBER,
                                 an_Day IN NUMBER,an_SA IN OUT NUMBER,an_SR IN OUT NUMBER) IS
 CURSOR lcur_sel IS
 SELECT C.nconnectionparam FROM ConnectionParam C WHERE C.NPARALLELCONNECTION=an_PARALLELCONNECTION
 AND EXISTS (select nconnectionparam from ConnectionParam WHERE mid=an_mid AND nconnectionparam=C.nconnectionparam
             union all
             select nconnectionparam from SharedConnectionParam WHERE mid=an_mid AND nconnectionparam=C.nconnectionparam);
 CURSOR lcur_p(lc_param IN NUMBER) IS
  SELECT c.mid nPoint
  FROM Connectionparam C
  WHERE C.nConnectionparam=lc_param and C.NNOTINCLUDECONSUMP=0
  UNION
  SELECT c.mid nPoint
  FROM SharedConnectionparam C
  WHERE C.nConnectionparam=lc_param and C.NNOTINCLUDECONSUMP=0;
 ln_A NUMBER;
 ln_R NUMBER;
BEGIN
    an_SA:=0; an_SR:=0;
    FOR LC IN lcur_sel LOOP
        FOR LCP IN lcur_p(LC.nconnectionparam) LOOP
          SELECT  nvl(SUM(nvl(er,0)*DECODE(nWasteabs,1,0,1)),0),
                  nvl(SUM(nvl(q1,0)*DECODE(nWasteabs,1,0,1)),0) INTO ln_A,ln_R FROM RYDA.BILL
          WHERE mid=LCP.nPoint AND date_time>to_date(an_Day,'YYYYMMDD')
              and date_time<=to_date(an_Day,'YYYYMMDD')+1;
          an_SA:=an_SA+ln_A;
          an_SR:=an_SR+ln_R;
        END LOOP;
    END LOOP;
END;
------------------------------------------------------------------------------------------------
FUNCTION F_DayGetParallelProc(an_PARALLELCONNECTION NUMBER,an_Day IN NUMBER,an_CurrentT0 NUMBER) RETURN NUMBER IS
ln_ret NUMBER;
ln_DayCount NUMBER default to_number(to_char(last_day(to_date(an_Day,'YYYYMMDD')),'DD')); --Кол-во дней в месяце
ln_maxT0 NUMBER;
ln_AllT0 NUMBER default 0;
 CURSOR lcur_sel IS
 /*Ищем параллельные присоединения и их время работы (To)*/
 SELECT nconnectionparam,nfullhours/ln_DayCount nfullhours FROM ConnectionParam WHERE NPARALLELCONNECTION=an_PARALLELCONNECTION;
 CURSOR lcur_p(lc_param IN NUMBER) IS
  SELECT nvl(PH.nfullhours,PI.nfullhours)/ln_DayCount nfullhours FROM Connectionparam C,feeders PI,POINTFULLHOURS PH
  WHERE C.nConnectionparam=lc_param
  AND C.mid=PI.mid(+)
  AND PI.mid=PH.mid(+) AND trunc(an_Day/100)=PH.NACCPERIOD(+)
  UNION ALL
  SELECT nvl(PH.nfullhours,PI.nfullhours)/ln_DayCount nfullhours FROM SharedConnectionparam C,feeders PI,POINTFULLHOURS PH
  WHERE C.nConnectionparam=lc_param
  AND C.mid=PI.mid(+)
  AND PI.mid=PH.mid(+) AND trunc(an_Day/100)=PH.NACCPERIOD(+);
BEGIN
  SELECT count(*) into ln_ret FROM ConnectionParam WHERE NPARALLELCONNECTION=an_PARALLELCONNECTION;
  IF ln_ret<2 THEN RETURN 1;
  END IF;
  FOR LC IN lcur_sel LOOP
      ln_maxT0:=LC.nfullhours;
      IF ln_maxT0 IS NULL THEN
          FOR LCP IN lcur_p(LC.nconnectionparam) LOOP
              ln_maxT0:=GREATEST(nvl(LCP.nfullhours,ln_maxT0),nvl(ln_maxT0,LCP.nfullhours));
          END LOOP;
      END IF;
      ln_AllT0:=ln_AllT0+nvl(ln_maxT0,ln_DayCount*24/ln_DayCount);
  END LOOP;
  IF ln_AllT0=0 THEN
      RETURN 0;
  END IF;
  RETURN least(an_CurrentT0/ln_AllT0,1);--least(an_CurrentT0,ln_DayCount*24)/least(ln_AllT0,ln_DayCount*24);
END;
------------------------------------------------------------------------------------------------
PROCEDURE F_DayGetPoterNew(lr_PoterTemp IN OUT TR_PoterCoef,an_mid IN NUMBER,an_Act IN NUMBER,
                         an_Day IN NUMBER,an_PotrebOnly IN NUMBER) IS
 ln_A NUMBER; ln_A1 NUMBER; ln_A2 NUMBER; ln_A3 NUMBER;
 ln_R NUMBER; ln_R1 NUMBER; ln_R2 NUMBER; ln_R3 NUMBER;
 ln_PR1 NUMBER; ln_PR2 NUMBER;
 ln_S2 NUMBER; ln_SA NUMBER; ln_SR NUMBER;
 ln_Count NUMBER;
 lb_find BOOLEAN;
 ln_DayCount NUMBER default to_number(to_char(last_day(to_date(an_Day,'YYYYMMDD')),'DD')); --Кол-во дней в месяце
 ln_Point_workinghours NUMBER;
 ln_max_workinghours NUMBER;
 ln_Point_T0 NUMBER;
 ln_maxT0 NUMBER;
 ln_ProcParallel NUMBER;
 ln_ProvVar1 NUMBER;
-----------------------
 CURSOR lcur_sel IS
 /*Ищет всевозможные присоединения и их параметры для расчета потерь,
   где фигурирует точка с ид.=an_mid*/
 SELECT c.nconnectionparam, nvl(c.nsn,1) nsn, nvl(nsh,nvl(c.nsn,1)) nsh, nvl(c.ndeltapidling,0) ndeltapidling,
  nvl(c.ndeltapsc,0) ndeltapsc, nvl(c.niidling,0) niidling, nvl(c.nusc,0) nusc, nvl(c.nro,0) nro,
  nvl(c.nxo,0) nxo, nvl(c.nl,0) nl, nvl(c.nun,1) nun,(nvl(c.nenergypercent,100)/100) nenergypercent,
  nvl(ph.NWORKINGHOURS,nvl(c.NWORKINGHOURS,DECODE(999,3,700,1,200,2,450,NULL)))/ln_DayCount NWORKINGHOURS,c.NPARALLELCONNECTION,
  nvl(ph.NFULLHOURS,c.nfullhours)/ln_DayCount nfullhours,c.NNOTINCLUDECONSUMP,1 mainpoint
  FROM ConnectionParam c,CONNECTIONPARAMFULLHOURS ph WHERE c.mid=an_mid and
  c.NCONNECTIONPARAM=ph.NCONNECTIONPARAM(+) and trunc(an_Day/100)=ph.nAccPeriod(+)
 UNION ALL
 SELECT C.nconnectionparam, nvl(C.nsn,1) nsn, nvl(nsh,nvl(c.nsn,1)) nsh, nvl(C.ndeltapidling,0) ndeltapidling,
  nvl(C.ndeltapsc,0) ndeltapsc, nvl(C.niidling,0) niidling, nvl(C.nusc,0) nusc, nvl(C.nro,0) nro,
  nvl(C.nxo,0) nxo, nvl(C.nl,0) nl, nvl(C.nun,1) nun,(nvl(C.nenergypercent,100)/100) nenergypercent,
  nvl(ph.NWORKINGHOURS,nvl(C.NWORKINGHOURS,DECODE(999,3,700,1,200,2,450,NULL)))/ln_DayCount NWORKINGHOURS,C.NPARALLELCONNECTION,
  nvl(ph.NFULLHOURS,C.nfullhours)/ln_DayCount nfullhours,S.NNOTINCLUDECONSUMP,0 mainpoint
  FROM ConnectionParam C,SharedConnectionParam S,CONNECTIONPARAMFULLHOURS ph
  WHERE S.mid=an_mid
  AND S.nConnectionParam=C.nConnectionParam(+) AND
  c.NCONNECTIONPARAM=ph.NCONNECTIONPARAM(+) and trunc(an_Day/100)=ph.nAccPeriod(+);
 CURSOR lcur_p(lc_param NUMBER) IS
 /*Ищем все точки которые участвуют в доле по дележке потерь присоединения
   NNOTINCLUDECONSUMP - отвечает за включение расхода по точке в общее потребление по присоединению*/
  SELECT mid npoint,NNOTINCLUDECONSUMP FROM Connectionparam WHERE nConnectionparam=lc_param
  UNION ALL
  SELECT mid npoint,NNOTINCLUDECONSUMP FROM SharedConnectionparam WHERE nConnectionparam=lc_param ;
 CURSOR lcur_ss(lc_mid IN NUMBER) IS SELECT
 /*Дотягиваем информацию по остальным точкам, участвующим в дележке потерь
   а именно часы работы и наличае счетчиков для ответа на вопрос: Как счмтать
   расход реактивной (по активной или по показаниям реактивной)*/
   nvl(PH.NWORKINGHOURS,PI.nworkinghours)/ln_DayCount Point_workinghours,
   nvl(PH.nfullhours,PI.nfullhours)/ln_DayCount nfullhours
  FROM feeders PI, POINTFULLHOURS PH
  WHERE PI.mid=lc_mid and
  PI.mid=PH.mid(+) AND trunc(an_Day/100)=PH.NACCPERIOD(+);
BEGIN
 P_SetPoterCoef(lr_PoterTemp,0); --Зануляем lr_PoterTemp

 IF an_PotrebOnly=1 THEN --мы не считаем потери, а считаем потребление по точке за месяц
    SELECT
     nvl(SUM(nvl(er,0)*DECODE(nWasteabs,1,0,1)),0), --Мы игнорируем записи с nWasteabs=1 (по уст. мощности)
     nvl(SUM(nvl(aer,0)*DECODE(nWasteabs,1,0,1)),0),  -- Актив
     nvl(SUM(nvl(ber,0)*DECODE(nWasteabs,1,0,1)),0),
     nvl(SUM(nvl(cer,0)*DECODE(nWasteabs,1,0,1)),0),
     nvl(SUM(nvl(q1,0)*DECODE(nWasteabs,1,0,1)),0),
     nvl(SUM(nvl(aq1,0)*DECODE(nWasteabs,1,0,1)),0),  -- Рактив
     nvl(SUM(nvl(bq1,0)*DECODE(nWasteabs,1,0,1)),0),
     nvl(SUM(nvl(cq1,0)*DECODE(nWasteabs,1,0,1)),0)
     INTO ln_A,ln_A1,ln_A2,ln_A3,ln_R,ln_R1,ln_R2,ln_R3
     FROM RYDA.BILL WHERE mid=an_mid AND
       date_time>to_date(an_day,'YYYYMMDD') and date_time<=to_date(an_day,'YYYYMMDD')+1;

     IF an_Act=1 THEN --Нужно по активной
         lr_PoterTemp.Z:=ln_A;
         lr_PoterTemp.Z1:=ln_A1;
         lr_PoterTemp.Z2:=ln_A2;
         lr_PoterTemp.Z3:=ln_A3;
     ELSE--Нужно по реактивной
         open lcur_ss(an_mid);
         FETCH lcur_ss into ln_Point_workinghours,ln_Point_T0;
         IF lcur_ss%NOTFOUND THEN
             close lcur_ss;
             return;
         END IF;
         close lcur_ss;
             lr_PoterTemp.Z:=ln_R;
             lr_PoterTemp.Z1:=ln_R1;
             lr_PoterTemp.Z2:=ln_R2;
             lr_PoterTemp.Z3:=ln_R3;
     END IF;
     return;
 END IF;

 SELECT COUNT(*) into ln_A FROM DUAL WHERE
  EXISTS (SELECT * FROM ConnectionParam WHERE mid=an_mid ) OR
  EXISTS (SELECT * FROM SharedConnectionParam WHERE mid=an_mid );
 IF ln_A=0 THEN --Если нет потерь
     return;
 END IF;

 /*Далее мы считаем потери. Берем все присоединения, где фигурирует точка.
   Считаем расход по всем точкам привязанным к данному присоединению и на этот расход считаем
   потери. Берем свою часть (пропорционально расходу). Причем, если участвует одна точка, то
   все потери вешаются на нее (это принципиально, если расход=0 а потери есть {потери холостого хода} )
   Часы работы трансформатора ln_max_workinghours и время всей работы ln_maxT0
   (обычно не задано и следовательно равно кол-ву часов в месяце) ищутся как
   максимальные среди всех точек и самого присоединения*/
 FOR LC in lcur_sel LOOP
    SELECT count(*) into ln_Count FROM Connectionparam C,feeders P
    WHERE C.nConnectionparam=LC.nConnectionparam
    and C.mid=P.mid(+);
    SELECT count(*) into ln_A FROM SharedConnectionparam C,feeders P
    WHERE C.nConnectionparam=LC.nConnectionparam
    and C.mid=P.mid(+);
    ln_Count:=ln_Count+ln_A;
    IF ln_Count=0 THEN
        NULL;
    ELSIF ln_Count=1 THEN --Не долевые
        IF nvl(LC.NWORKINGHOURS,1)<>0 THEN
          SELECT
          nvl(PH.NWORKINGHOURS,PI.nworkinghours)/ln_DayCount,
          nvl(PH.nfullhours,nvl(nvl(LC.nfullhours,PI.nfullhours),ln_DayCount*24))/ln_DayCount
          into ln_max_workinghours,ln_maxT0
          FROM feeders PI, POINTFULLHOURS PH
          WHERE PI.mid=an_mid and
          PI.mid=PH.mid(+) AND trunc(an_Day/100)=PH.NACCPERIOD(+);
          IF LC.NNOTINCLUDECONSUMP<>1 THEN
              SELECT  nvl(SUM(nvl(er,0)*DECODE(nWasteabs,1,0,1)),0),
                      nvl(SUM(nvl(q1,0)*DECODE(nWasteabs,1,0,1)),0) INTO ln_A,ln_R FROM RYDA.BILL
              WHERE mid=an_mid AND date_time>to_date(an_day,'YYYYMMDD')
                  and date_time<=to_date(an_day,'YYYYMMDD')+1;
          ELSE
              ln_A:=0;  ln_R:=0;
          END IF;
          ln_maxT0:=least(ln_maxT0,ln_DayCount*24/ln_DayCount);
          ln_max_workinghours:=least(ln_maxT0,nvl(GREATEST(nvl(LC.NWORKINGHOURS,ln_max_workinghours),nvl(ln_max_workinghours,LC.NWORKINGHOURS)),ln_DayCount*24/ln_DayCount),ln_DayCount*24/ln_DayCount);
          IF ln_max_workinghours>0 THEN --Если max время работы=0, то потери равны 0 (так договорились)
            /*Та формула , что  на бумаге немного переписана. Отделены два слагаемых
              которые содержат сумму квадратов расхода и которые не содержат*/
            IF an_Act=1 THEN --активные потери
                ln_PR1:=LC.ndeltapidling*ln_maxT0;
                ln_PR2:=(LC.ndeltapsc/(LC.nsh*LC.nsh*ln_max_workinghours))+
                            (((LC.nl/1000)*LC.nro)/(ln_max_workinghours*LC.nun*LC.nun));
            ELSE --реактивные потери
                ln_PR1:=(LC.nsn*LC.niidling)*(ln_maxT0/100);
                ln_PR2:=(LC.nusc/(100*LC.nsh*ln_max_workinghours))+
                            (((LC.nl/1000)*LC.nxo)/(ln_max_workinghours*LC.nun*LC.nun));
            END IF;
            lr_PoterTemp.Z:=lr_PoterTemp.Z+(ln_PR1+(ln_A*ln_A+ln_R*ln_R)*ln_PR2)*LC.nenergypercent;
          END IF;
        END IF;
    ELSE --Долевые
      ln_ProvVar1:=F_ProvVar1(LC.NPARALLELCONNECTION);
      ln_Count:=0;    ln_SA:=0;   ln_SR:=0;   ln_A1:=0;   ln_R1:=0;   lb_find:=false;
      ln_max_workinghours:=LC.NWORKINGHOURS;
      ln_maxT0:=NULL;
      FOR LCP IN lcur_p(LC.nconnectionparam) LOOP
          open lcur_ss(LCP.nPoint);
          FETCH lcur_ss into ln_Point_workinghours,ln_Point_T0;
          close lcur_ss;
              ln_Count:=ln_Count+1;
              SELECT  nvl(SUM(nvl(er,0)*DECODE(nWasteabs,1,0,1)),0),
                      nvl(SUM(nvl(q1,0)*DECODE(nWasteabs,1,0,1)),0) INTO ln_A,ln_R FROM RYDA.BILL
              WHERE mid=LCP.npoint AND date_time>to_date(an_day,'YYYYMMDD')
                  and date_time<=to_date(an_day,'YYYYMMDD')+1;
              IF LCP.nPoint=an_mid THEN
                  ln_A1:=ln_A;     ln_R1:=ln_R;   lb_find:=true;
              END IF;
              IF ln_Point_T0 IS NOT NULL THEN
                  ln_maxT0:=GREATEST(ln_Point_T0,nvl(ln_maxT0,ln_Point_T0));
              END IF;
              IF ln_Point_workinghours IS NOT NULL THEN
                  ln_max_workinghours:=GREATEST(ln_Point_workinghours,nvl(ln_max_workinghours,ln_Point_workinghours));
              END IF;
              IF LCP.NNOTINCLUDECONSUMP<>1 THEN
                  ln_SA:=ln_SA+ln_A;  ln_SR:=ln_SR+ln_R;
              END IF;
      END LOOP;
      IF ln_Count>0 THEN
          IF LC.NWORKINGHOURS=0 THEN --Если на параметре присоединения время работы=0, то потери равны 0 (так договорились)
              ln_PR1:=0;
              ln_PR2:=0;
          ELSE
              ln_maxT0:=least(nvl(nvl(LC.nfullhours,ln_maxT0),ln_DayCount*24/ln_DayCount),ln_DayCount*24/ln_DayCount);
              ln_max_workinghours:=least(ln_maxT0,nvl(ln_max_workinghours,ln_DayCount*24/ln_DayCount),ln_DayCount*24/ln_DayCount);
              IF ln_max_workinghours=0 THEN --Если max время работы=0, то потери равны 0 (так договорились)
                  ln_PR1:=0;
                  ln_PR2:=0;
              ELSE
                  IF an_Act=1 THEN --активные потери
                      ln_PR1:=LC.ndeltapidling*ln_maxT0;
                      ln_PR2:=(LC.ndeltapsc/(LC.nsh*LC.nsh*ln_max_workinghours))+
                                  (((LC.nl/1000)*LC.nro)/(ln_max_workinghours*LC.nun*LC.nun));
                  ELSE --реактивные потери
                      ln_PR1:=(LC.nsn*LC.niidling)*(ln_maxT0/100);
                      ln_PR2:=(LC.nusc/(100*LC.nsh*ln_max_workinghours))+
                                  (((LC.nl/1000)*LC.nxo)/(ln_max_workinghours*LC.nun*LC.nun));
                  END IF;
              END IF;
          END IF;
          IF ln_ProvVar1=1 THEN--спаренные трансформаторы без счетчиков
              ln_ProcParallel:=F_DayGetParallelProc(LC.NPARALLELCONNECTION,an_day,ln_maxT0);
          ELSE
              ln_ProcParallel:=1;
          END IF;
          ln_S2:=Round(ln_ProcParallel*ln_SA)*Round(ln_ProcParallel*ln_SA)+
                 Round(ln_ProcParallel*ln_SR)*Round(ln_ProcParallel*ln_SR); --сумма квадратов расходов с весом каждого трансформатора
          IF ln_Count=1 AND lb_find AND (LC.nParallelConnection IS NULL OR ln_ProvVar1=1) THEN --одна точка
              lr_PoterTemp.Z:=lr_PoterTemp.Z+(ln_PR1+ln_S2*ln_PR2)*LC.nenergypercent;
          ELSIF (LC.nParallelConnection IS NULL OR ln_ProvVar1=1) THEN
              IF an_Act=1 THEN --пропорция
                IF Abs(ln_SA)>0 THEN
                  lr_PoterTemp.Z:=lr_PoterTemp.Z+(ln_PR1+ln_S2*ln_PR2)*LC.nenergypercent*least(ln_A1/ln_SA,1);
                ELSIF Abs(ln_SA)=0 THEN
                  IF LC.mainpoint=1 THEN
                    NULL;--Если закоментировать следующую строчку, то потери холостого хода без расхода не будут учитываться
                    lr_PoterTemp.Z:=lr_PoterTemp.Z+(ln_PR1+ln_S2*ln_PR2)*LC.nenergypercent;
                  END IF;
                END IF;
              ELSIF nvl(an_Act,0)<>1 THEN
               IF an_day<20020301 THEN--Потери по старому (реактив)
                IF Abs(ln_SR)>0 THEN
                  lr_PoterTemp.Z:=lr_PoterTemp.Z+(ln_PR1+ln_S2*ln_PR2)*LC.nenergypercent*least(ln_R1/ln_SR,1);
                ELSIF Abs(ln_SR)=0 THEN
                  IF LC.mainpoint=1 THEN
                    NULL;--Если закоментировать следующую строчку, то потери холостого хода без расхода не будут учитываться
                    lr_PoterTemp.Z:=lr_PoterTemp.Z+(ln_PR1+ln_S2*ln_PR2)*LC.nenergypercent;
                  END IF;
                END IF;
               ELSE--Потери по новому
                IF Abs(ln_SA)>0 THEN
                  lr_PoterTemp.Z:=lr_PoterTemp.Z+(ln_PR1+ln_S2*ln_PR2)*LC.nenergypercent*least(ln_A1/ln_SA,1);
                ELSIF Abs(ln_SA)=0 THEN
                  IF LC.mainpoint=1 THEN
                    NULL;--Если закоментировать следующую строчку, то потери холостого хода без расхода не будут учитываться
                    lr_PoterTemp.Z:=lr_PoterTemp.Z+(ln_PR1+ln_S2*ln_PR2)*LC.nenergypercent;
                  END IF;
                END IF;
               END IF;
              END IF;
          ELSE
              P_DayGetSharesConsumption(LC.nParallelConnection,an_mid,an_day,ln_SA,ln_SR);
              IF an_Act=1 THEN --пропорция
                IF Abs(ln_SA)>0 THEN
                  lr_PoterTemp.Z:=lr_PoterTemp.Z+(ln_PR1+ln_S2*ln_PR2)*LC.nenergypercent*least(ln_A1/ln_SA,1);
                ELSIF Abs(ln_SA)=0 THEN
                  IF LC.mainpoint=1 THEN
                    NULL;--Если закоментировать следующую строчку, то потери холостого хода без расхода не будут учитываться
                    lr_PoterTemp.Z:=lr_PoterTemp.Z+(ln_PR1+ln_S2*ln_PR2)*LC.nenergypercent;
                  END IF;
                END IF;
              ELSIF nvl(an_Act,0)<>1 THEN
               IF an_day<20020301 THEN--Потери по старому (реактив)
                IF Abs(ln_SR)>0 THEN
                  lr_PoterTemp.Z:=lr_PoterTemp.Z+(ln_PR1+ln_S2*ln_PR2)*LC.nenergypercent*least(ln_R1/ln_SR,1);
                ELSIF Abs(ln_SR)=0 THEN
                  IF LC.mainpoint=1 THEN
                    NULL;--Если закоментировать следующую строчку, то потери холостого хода без расхода не будут учитываться
                    lr_PoterTemp.Z:=lr_PoterTemp.Z+(ln_PR1+ln_S2*ln_PR2)*LC.nenergypercent;
                  END IF;
                END IF;
               ELSE
                IF Abs(ln_SA)>0 THEN
                  lr_PoterTemp.Z:=lr_PoterTemp.Z+(ln_PR1+ln_S2*ln_PR2)*LC.nenergypercent*least(ln_A1/ln_SA,1);
                ELSIF Abs(ln_SA)=0 THEN
                  IF LC.mainpoint=1 THEN
                    NULL;--Если закоментировать следующую строчку, то потери холостого хода без расхода не будут учитываться
                    lr_PoterTemp.Z:=lr_PoterTemp.Z+(ln_PR1+ln_S2*ln_PR2)*LC.nenergypercent;
                  END IF;
                END IF;
               END IF;
              END IF;
          END IF;
      END IF;
    END IF;
 END LOOP;
END;
------------------------------------------------------------------------------------------------
FUNCTION F_DayWaste(an_Day IN NUMBER,an_mid IN NUMBER,av_Zone IN VARCHAR2,an_Act IN NUMBER) RETURN NUMBER IS   --Потери самые новые
 ln_Rez NUMBER;
 ln_RezNew TR_PoterCoef;
 ln_RezNew1 TR_PoterCoef;
 ln_PoterA NUMBER;
 ln_PoterR NUMBER;
 ln_Poter NUMBER;
 ln_WastePercentCalc NUMBER;
 ln_Count NUMBER;
 ln_RezOut NUMBER;
 CURSOR lcur_Coef IS -- Вытягиваем процент потерь (для потерь не по формуле)
  SELECT nvl(PO.LINE_LOSS,0)+nvl(PO.ACT_LOSS,0),
                nvl(PO.REACT_LOSS,0), nWastePercentCalc
   FROM feeders PO WHERE PO.mid=an_mid;
BEGIN
/*Примечание:
    Если требуются потери по зоне, то считаем сумарные потери, а потом берем зонное вложение.*/
    open lcur_Coef;
    fetch lcur_Coef into ln_PoterA,ln_PoterR,ln_WastePercentCalc;
    IF lcur_Coef%NOTFOUND THEN
        close lcur_Coef;
        return 0;
    END IF;
    close lcur_Coef;

    IF ln_WastePercentCalc=0 THEN
        return 0;
    ELSIF ln_WastePercentCalc=4 THEN --Потери по формуле
        F_DayGetPoterNew(ln_RezNew,an_mid,an_Act,an_day,0); --Считаем потери в ln_RezNew
        IF av_Zone='A' OR av_Zone='B' OR av_Zone='C' THEN --Потери по каждой зоне
            F_DayGetPoterNew(ln_RezNew1,an_mid,an_Act,an_day,1); --Считаем расход в ln_RezNew1

            IF ln_RezNew1.Z1+ln_RezNew1.Z2+ln_RezNew1.Z3=0 THEN
                IF av_Zone='C' THEN --Ошибки округления на третью зону
                    return Round(ln_RezNew.Z);
                ELSE
                    return 0;
                END IF;
            END IF;
            ln_Rez:=Round(ln_RezNew.Z);

            IF av_Zone='A' THEN --Делим потери по зоне пропорционально вложению зоны
                ln_Rez:=Round((ln_Rez*ln_RezNew1.Z1)/(ln_RezNew1.Z1+ln_RezNew1.Z2+ln_RezNew1.Z3));
            ELSIF av_Zone='B' THEN
                ln_Rez:=Round((ln_Rez*ln_RezNew1.Z2)/(ln_RezNew1.Z1+ln_RezNew1.Z2+ln_RezNew1.Z3));
            ELSE
                ln_Rez:=Round(ln_Rez-
                     Round((ln_Rez*ln_RezNew1.Z1)/(ln_RezNew1.Z1+ln_RezNew1.Z2+ln_RezNew1.Z3))-
                     Round((ln_Rez*ln_RezNew1.Z2)/(ln_RezNew1.Z1+ln_RezNew1.Z2+ln_RezNew1.Z3)));
            END IF;
        ELSE --потери без зон
            ln_Rez:=ln_RezNew.Z;
        END IF;
    ELSE
        IF ln_WastePercentCalc>4 THEN --На будущее
            return 0;
        END IF;
        IF an_Act=1 THEN
            ln_Poter:=ln_PoterA;
        ELSE
            ln_Poter:=ln_PoterR;
        END IF;

        F_DayGetPoterNew(ln_RezNew,an_mid,an_Act,an_day,1); --Считаем расход по точке в ln_RezNew
        IF ln_WastePercentCalc=1 THEN --потери в процентах
            ln_Rez:=Round(ln_RezNew.Z*ln_Poter/100);
        ELSIF ln_WastePercentCalc=2 THEN -- фиксированые потери
            ln_Rez:=ln_Poter;
        ELSIF ln_WastePercentCalc=3 THEN --потери процент в квадрате
            ln_Rez:=Round(ln_RezNew.Z*ln_RezNew.Z*ln_Poter/100000);
        END IF;

        IF av_Zone='A' OR av_Zone='B' OR av_Zone='C' THEN --если по зоне то процентовка
            IF ln_RezNew.Z1+ln_RezNew.Z2+ln_RezNew.Z3=0 THEN
                IF av_Zone='C' THEN --Ошибки округления на третью зону
                    return Round(ln_Rez);
                ELSE
                    return 0;
                END IF;
            END IF;

            IF av_Zone='A' THEN
                ln_Rez:=Round((ln_Rez*ln_RezNew.Z1)/(ln_RezNew.Z1+ln_RezNew.Z2+ln_RezNew.Z3));
            ELSIF av_Zone='B' THEN
                ln_Rez:=Round((ln_Rez*ln_RezNew.Z2)/(ln_RezNew.Z1+ln_RezNew.Z2+ln_RezNew.Z3));
            ELSE --ошибки округления на 3 зону
                ln_Rez:=Round(ln_Rez-
                     Round((ln_Rez*ln_RezNew.Z1)/(ln_RezNew.Z1+ln_RezNew.Z2+ln_RezNew.Z3))-
                     Round((ln_Rez*ln_RezNew.Z2)/(ln_RezNew.Z1+ln_RezNew.Z2+ln_RezNew.Z3)));
            END IF;
        END IF;
    END IF;

    return ROUND(ln_Rez);
END;
------------------------------------------------------------------------------------------------
END;
/

-- End of DDL script for POINTCALC_PG

-- Start of DDL script for RANDOM
-- Generated 27-янв-03  11:34:02 am
-- from oe-RYDA:1

-- Package body RANDOM

CREATE OR REPLACE
package body random is
--/* linear congruential random number generator */
--
m constant number:=100000000;
m1 constant number:=10000;
b constant number:=31415821;
--
a number;
--
the_date date;
days number;
secs number;
--
--/*-------------------------- mult ---------------------------*/
--/* private utility function */
--
function mult(p in number, q in number) return number is
   p1 number;
   p0 number;
   q1 number;
   q0 number;
begin
   p1:=trunc(p/m1);
   p0:=mod(p,m1);
   q1:=trunc(q/m1);
   q0:=mod(q,m1);
   return(mod((mod(p0*q1+p1*q0,m1)*m1+p0*q0),m));
end;   /* mult */
--
--/*-------------------------- rndint --------------------------*/
--/* returns random integer between [0, r-1] */
--
function rndint (r in number) return number is
begin
--   /* generate a random number and set it to be the new seed */
   a:=mod(mult(a,b)+1,m);
--
--   /* convert it to integer between [0, r-1] and return it */
   return(trunc((trunc(a/m1)*r)/m1));
end;
--  /* rndint */
--
--/*-------------------------- rndflt --------------------------*/
--/* returns random real between [0, 1] */
--
function rndflt return number is
begin
--   /* generate a random number and set it to be the new seed */
   a:=mod(mult(a,b)+1,m);
--   /* return it */
   return(a/m);
end;
--   /* rndflt */
--
--
begin
--/* package body random */
--   /* generate an initial seed "a" based on system date */
--   /* (must be connected to database.)                  */
   the_date:=sysdate;
   days:=to_number(to_char(the_date, 'j'));
   secs:=to_number(to_char(the_date, 'sssss'));
   a:=days*24*3600+secs;
end;
--  /* package body random */
/

-- End of DDL script for RANDOM

-- Start of DDL script for RATES_PG
-- Generated 27-янв-03  11:34:02 am
-- from oe-RYDA:1

-- Package body RATES_PG

CREATE OR REPLACE
Package Body      RATES_PG
  IS
  -- тарификация по режимным суткам
  -- дата создания 23.04.2002 (Коваленко А.С.)
------------------------------------------------------------------------------------------------------------------------
  -- Процедура расчета коэффициентов тарифных зон по режимным суткам
PROCEDURE CalcRatesCoef(
 av_date VARCHAR2 --Дата режимных суток в формате 'dd.mm.yyyy'
 )
 IS
  type T_StFinDate IS RECORD (StDate DATE, FinDate DATE);
  type T_DATE IS TABLE OF T_StFinDate INDEX BY BINARY_INTEGER;-- таблица для занесения начала и конца тар зон
  ln_prev_zone NUMBER;-- Предыдущий тип тариф зоны
  ld_switch_date DATE;-- Дата последней смены тарифных зон
  ld_date DATE; --Дата режимных суток
  ld_dateLastZone DATE; --Дата конца последней зоны
  v_SQL VARCHAR2(2000);

  ln_SumAr NUMBER;
  ln_SumBr NUMBER;
  ln_SumCr NUMBER;
  ln_SumDr NUMBER;
  ln_SumAllr NUMBER;

  ln_SumAd NUMBER;
  ln_SumBd NUMBER;
  ln_SumCd NUMBER;
  ln_SumDd NUMBER;
  ln_SumAlld NUMBER;

  ln_SumAq1 NUMBER;
  ln_SumBq1 NUMBER;
  ln_SumCq1 NUMBER;
  ln_SumDq1 NUMBER;
  ln_SumAllq1 NUMBER;

  ln_SumAq3 NUMBER;
  ln_SumBq3 NUMBER;
  ln_SumCq3 NUMBER;
  ln_SumDq3 NUMBER;
  ln_SumAllq3 NUMBER;

  lt_zoneA T_DATE;
  ln_Count_zoneA NUMBER := 0;
  lt_zoneB T_DATE;
  ln_Count_zoneB NUMBER := 0;
  lt_zoneC T_DATE;
  ln_Count_zoneC NUMBER := 0;
  lt_zoneD T_DATE;
  ln_Count_zoneD NUMBER := 0;
  li_i INTEGER;
  li_CurSumTar INTEGER;
  li_Rtn INTEGER;
  CURSOR cr_zone_range
  IS
   SELECT r.*, to_date(to_char(ld_date, 'dd.mm.yyyy ')||to_char(r.time, 'hh24:mi'),'dd.mm.yyyy hh24:mi') tz FROM rates r, rate_list rl WHERE r.rid = rl.rid AND rl.switch_date = ld_switch_date
    ORDER BY time;
  CURSOR cr_feeders_sel
  IS
   SELECT mid FROM feeders ORDER BY mid;
 BEGIN
   ld_date := to_date(av_date, 'dd.mm.yyyy');
   SELECT max(switch_date) INTO ld_switch_date FROM rate_list WHERE switch_date<=ld_date;
   -- Находим диапазоны тар зон
   FOR zone_range IN cr_zone_range LOOP
     IF ln_Count_zoneA=0 AND ln_Count_zoneB=0 AND ln_Count_zoneC=0 AND ln_Count_zoneD=0 THEN
       ld_dateLastZone := zone_range.tz+1;
     END IF;
     IF ln_prev_zone=0 THEN
       lt_zoneA(ln_Count_zoneA).FinDate:=zone_range.tz;
     END IF;
     IF ln_prev_zone=1 THEN
       lt_zoneB(ln_Count_zoneB).FinDate:=zone_range.tz;
     END IF;
     IF ln_prev_zone=2 THEN
       lt_zoneC(ln_Count_zoneC).FinDate:=zone_range.tz;
     END IF;
     IF ln_prev_zone=3 THEN
       lt_zoneD(ln_Count_zoneD).FinDate:=zone_range.tz;
     END IF;

     IF zone_range.rate=0 THEN
       ln_Count_zoneA := ln_Count_zoneA+1;
       ln_prev_zone:=zone_range.rate;
       lt_zoneA(ln_Count_zoneA).StDate:=zone_range.tz;
     END IF;
     IF zone_range.rate=1 THEN
       ln_Count_zoneB := ln_Count_zoneB+1;
       ln_prev_zone:=zone_range.rate;
       lt_zoneB(ln_Count_zoneB).StDate:=zone_range.tz;
     END IF;
     IF zone_range.rate=2 THEN
       ln_Count_zoneC := ln_Count_zoneC+1;
       ln_prev_zone:=zone_range.rate;
       lt_zoneC(ln_Count_zoneC).StDate:=zone_range.tz;
     END IF;
     IF zone_range.rate=3 THEN
       ln_Count_zoneD := ln_Count_zoneD+1;
       ln_prev_zone:=zone_range.rate;
       lt_zoneD(ln_Count_zoneD).StDate:=zone_range.tz;
     END IF;
   END LOOP;-- Конец цикла и теперь заносим финишную даду последней зоны
   IF ln_prev_zone=0 THEN
     lt_zoneA(ln_Count_zoneA).FinDate:=ld_dateLastZone;
   END IF;
   IF ln_prev_zone=1 THEN
     lt_zoneB(ln_Count_zoneB).FinDate:=ld_dateLastZone;
   END IF;
   IF ln_prev_zone=2 THEN
     lt_zoneC(ln_Count_zoneC).FinDate:=ld_dateLastZone;
   END IF;
   IF ln_prev_zone=3 THEN
     lt_zoneD(ln_Count_zoneD).FinDate:=ld_dateLastZone;
   END IF;

/*
   li_i := 1;
   FOR li_i IN 1..lt_zoneA.Count LOOP
     DBMS_OUTPUT.put_line('A - '||to_char(lt_zoneA(li_i).StDate, 'dd.mm.yyyy hh24:mi')||' - '||to_char(lt_zoneA(li_i).FinDate, 'dd.mm.yyyy hh24:mi'));
   END LOOP;
   li_i := 1;
   FOR li_i IN 1..lt_zoneB.Count LOOP
     DBMS_OUTPUT.put_line('B - '||to_char(lt_zoneB(li_i).StDate, 'dd.mm.yyyy hh24:mi')||' - '||to_char(lt_zoneB(li_i).FinDate, 'dd.mm.yyyy hh24:mi'));
   END LOOP;
   li_i := 1;
   FOR li_i IN 1..lt_zoneC.Count LOOP
     DBMS_OUTPUT.put_line('C - '||to_char(lt_zoneC(li_i).StDate, 'dd.mm.yyyy hh24:mi')||' - '||to_char(lt_zoneC(li_i).FinDate, 'dd.mm.yyyy hh24:mi'));
   END LOOP;
   li_i := 1;
   FOR li_i IN 1..lt_zoneD.Count LOOP
     DBMS_OUTPUT.put_line('D - '||to_char(lt_zoneD(li_i).StDate, 'dd.mm.yyyy hh24:mi')||' - '||to_char(lt_zoneD(li_i).FinDate, 'dd.mm.yyyy hh24:mi'));
   END LOOP;
  */

   -- Цикл по всем фидерам
   FOR feeders_sel IN cr_feeders_sel LOOP
     SELECT nvl(SUM(er),0), nvl(SUM(ed),0), nvl(SUM(q1),0), nvl(SUM(q3),0) INTO ln_SumAllr, ln_SumAlld, ln_SumAllq1, ln_SumAllq3 FROM halfhour WHERE mid = feeders_sel.mid
               AND date_time>ld_date AND date_time<=ld_date+1;
/*dbms_output.put_line(' --------------- '||to_char(feeders_sel.mid)||' ---------------' );
dbms_output.put_line(to_char(ln_SumAllr));
dbms_output.put_line(to_char(ln_SumAlld));
dbms_output.put_line(to_char(ln_SumAllq1));
dbms_output.put_line(to_char(ln_SumAllq3));
  */   -- Зона А
--dbms_output.put_line('========= Зона А =============');
     IF lt_zoneA.Count>0 THEN
           v_SQL := 'SELECT nvl(SUM(er),0), nvl(SUM(ed),0), nvl(SUM(q1),0), nvl(SUM(q3),0) FROM halfhour WHERE mid = '||to_char(feeders_sel.mid)||' AND( ';
           li_i := 1;
           v_SQL := v_SQL||'(date_time>to_date('||''''||
              to_char(lt_zoneA(li_i).StDate, 'dd.mm.yyyy hh24:mi')||''''||','||''''||'dd.mm.yyyy hh24:mi'||''''||
             ') AND date_time<=to_date('||''''||to_char(lt_zoneA(li_i).FinDate, 'dd.mm.yyyy hh24:mi')||''''||','||''''||
             'dd.mm.yyyy hh24:mi'||''''||'))';
          FOR li_i IN 2..lt_zoneA.Count LOOP
             v_SQL := v_SQL||' OR (date_time>to_date('||''''||
             to_char(lt_zoneA(li_i).StDate, 'dd.mm.yyyy hh24:mi')||''''||','||''''||'dd.mm.yyyy hh24:mi'||''''||
             ') AND date_time<=to_date('||''''||to_char(lt_zoneA(li_i).FinDate, 'dd.mm.yyyy hh24:mi')||''''||','||''''||
             'dd.mm.yyyy hh24:mi'||''''||'))';
          END LOOP;
           v_SQL := v_SQL||')';
           li_CurSumTar := SYS.DBMS_SQL.Open_Cursor;
           SYS.DBMS_SQL.PARSE(li_CurSumTar, v_SQL, SYS.DBMS_SQL.V7);
           SYS.DBMS_SQL.DEFINE_COLUMN(li_CurSumTar, 1, ln_SumAr);
           SYS.DBMS_SQL.DEFINE_COLUMN(li_CurSumTar, 2, ln_SumAd);
           SYS.DBMS_SQL.DEFINE_COLUMN(li_CurSumTar, 3, ln_SumAq1);
           SYS.DBMS_SQL.DEFINE_COLUMN(li_CurSumTar, 4, ln_SumAq3);
           li_Rtn := SYS.DBMS_SQL.EXECUTE(li_CurSumTar);
           IF li_Rtn=0 THEN
             li_Rtn := SYS.DBMS_SQL.FETCH_ROWS(li_CurSumTar);
             DBMS_SQL.COLUMN_VALUE(li_CurSumTar, 1, ln_SumAr);
             DBMS_SQL.COLUMN_VALUE(li_CurSumTar, 2, ln_SumAd);
             DBMS_SQL.COLUMN_VALUE(li_CurSumTar, 3, ln_SumAq1);
             DBMS_SQL.COLUMN_VALUE(li_CurSumTar, 4, ln_SumAq3);

/*dbms_output.put_line(to_char(ln_SumAr));
dbms_output.put_line(to_char(ln_SumAd));
dbms_output.put_line(to_char(ln_SumAq1));
dbms_output.put_line(to_char(ln_SumAq3));
*/
             IF ln_SumAllr>0 THEN
                ln_SumAr := ln_SumAr/ln_SumAllr;
             ELSE
                ln_SumAr := 0;
             END IF;
             IF ln_SumAlld>0 THEN
                ln_SumAd := ln_SumAd/ln_SumAlld;
             ELSE
                ln_SumAd := 0;
             END IF;
             IF ln_SumAllq1>0 THEN
                ln_SumAq1 := ln_SumAq1/ln_SumAllq1;
             ELSE
                ln_SumAq1 := 0;
             END IF;
             IF ln_SumAllq3>0 THEN
                ln_SumAq3 := ln_SumAq3/ln_SumAllq3;
             ELSE
                ln_SumAq3 := 0;
             END IF;

           END IF;
           DBMS_SQL.CLOSE_CURSOR(li_CurSumTar);
     ELSE
       ln_SumAr := 0;
       ln_SumAd := 0;
       ln_SumAq1 := 0;
       ln_SumAq3 := 0;
     END IF;

/*dbms_output.put_line(to_char(ln_SumAr));
dbms_output.put_line(to_char(ln_SumAd));
dbms_output.put_line(to_char(ln_SumAq1));
dbms_output.put_line(to_char(ln_SumAq3));
*/

     -- Зона B
--dbms_output.put_line('========= Зона B =============');
     IF lt_zoneB.Count>0 THEN
           v_SQL := 'SELECT nvl(SUM(er),0), nvl(SUM(ed),0), nvl(SUM(q1),0), nvl(SUM(q3),0) FROM halfhour WHERE mid = '||to_char(feeders_sel.mid)||' AND( ';
           li_i := 1;
           v_SQL := v_SQL||'(date_time>to_date('||''''||
              to_char(lt_zoneB(li_i).StDate, 'dd.mm.yyyy hh24:mi')||''''||','||''''||'dd.mm.yyyy hh24:mi'||''''||
             ') AND date_time<=to_date('||''''||to_char(lt_zoneB(li_i).FinDate, 'dd.mm.yyyy hh24:mi')||''''||','||''''||
             'dd.mm.yyyy hh24:mi'||''''||'))';
          FOR li_i IN 2..lt_zoneB.Count LOOP
             v_SQL := v_SQL||' OR (date_time>to_date('||''''||
             to_char(lt_zoneB(li_i).StDate, 'dd.mm.yyyy hh24:mi')||''''||','||''''||'dd.mm.yyyy hh24:mi'||''''||
             ') AND date_time<=to_date('||''''||to_char(lt_zoneB(li_i).FinDate, 'dd.mm.yyyy hh24:mi')||''''||','||''''||
             'dd.mm.yyyy hh24:mi'||''''||'))';
          END LOOP;
           v_SQL := v_SQL||')';
           li_CurSumTar := SYS.DBMS_SQL.Open_Cursor;
           SYS.DBMS_SQL.PARSE(li_CurSumTar, v_SQL, SYS.DBMS_SQL.V7);
           SYS.DBMS_SQL.DEFINE_COLUMN(li_CurSumTar, 1, ln_SumBr);
           SYS.DBMS_SQL.DEFINE_COLUMN(li_CurSumTar, 2, ln_SumBd);
           SYS.DBMS_SQL.DEFINE_COLUMN(li_CurSumTar, 3, ln_SumBq1);
           SYS.DBMS_SQL.DEFINE_COLUMN(li_CurSumTar, 4, ln_SumBq3);
           li_Rtn := SYS.DBMS_SQL.EXECUTE(li_CurSumTar);
           IF li_Rtn=0 THEN
             li_Rtn := SYS.DBMS_SQL.FETCH_ROWS(li_CurSumTar);
             DBMS_SQL.COLUMN_VALUE(li_CurSumTar, 1, ln_SumBr);
             DBMS_SQL.COLUMN_VALUE(li_CurSumTar, 2, ln_SumBd);
             DBMS_SQL.COLUMN_VALUE(li_CurSumTar, 3, ln_SumBq1);
             DBMS_SQL.COLUMN_VALUE(li_CurSumTar, 4, ln_SumBq3);

/*dbms_output.put_line(to_char(ln_SumBr));
dbms_output.put_line(to_char(ln_SumBd));
dbms_output.put_line(to_char(ln_SumBq1));
dbms_output.put_line(to_char(ln_SumBq3));
*/
             IF ln_SumAllr>0 THEN
                ln_SumBr := ln_SumBr/ln_SumAllr;
             ELSE
                ln_SumBr := 0;
             END IF;
             IF ln_SumAlld>0 THEN
                ln_SumBd := ln_SumBd/ln_SumAlld;
             ELSE
                ln_SumBd := 0;
             END IF;
             IF ln_SumAllq1>0 THEN
                ln_SumBq1 := ln_SumBq1/ln_SumAllq1;
             ELSE
                ln_SumBq1 := 0;
             END IF;
             IF ln_SumAllq3>0 THEN
                ln_SumBq3 := ln_SumBq3/ln_SumAllq3;
             ELSE
                ln_SumBq3 := 0;
             END IF;
           END IF;
           DBMS_SQL.CLOSE_CURSOR(li_CurSumTar);
     ELSE
       ln_SumBr := 0;
       ln_SumBd := 0;
       ln_SumBq1 := 0;
       ln_SumBq3 := 0;
     END IF;

/*dbms_output.put_line(to_char(ln_SumBr));
dbms_output.put_line(to_char(ln_SumBd));
dbms_output.put_line(to_char(ln_SumBq1));
dbms_output.put_line(to_char(ln_SumBq3));
  */   -- Зона C
--dbms_output.put_line('========= Зона C =============');
     IF lt_zoneC.Count>0 THEN
           v_SQL := 'SELECT nvl(SUM(er),0), nvl(SUM(ed),0), nvl(SUM(q1),0), nvl(SUM(q3),0) FROM halfhour WHERE mid = '||to_char(feeders_sel.mid)||' AND( ';
           li_i := 1;
           v_SQL := v_SQL||'(date_time>to_date('||''''||
              to_char(lt_zoneC(li_i).StDate, 'dd.mm.yyyy hh24:mi')||''''||','||''''||'dd.mm.yyyy hh24:mi'||''''||
             ') AND date_time<=to_date('||''''||to_char(lt_zoneC(li_i).FinDate, 'dd.mm.yyyy hh24:mi')||''''||','||''''||
             'dd.mm.yyyy hh24:mi'||''''||'))';
          FOR li_i IN 2..lt_zoneC.Count LOOP
             v_SQL := v_SQL||' OR (date_time>to_date('||''''||
             to_char(lt_zoneC(li_i).StDate, 'dd.mm.yyyy hh24:mi')||''''||','||''''||'dd.mm.yyyy hh24:mi'||''''||
             ') AND date_time<=to_date('||''''||to_char(lt_zoneC(li_i).FinDate, 'dd.mm.yyyy hh24:mi')||''''||','||''''||
             'dd.mm.yyyy hh24:mi'||''''||'))';
          END LOOP;
           v_SQL := v_SQL||')';
           li_CurSumTar := SYS.DBMS_SQL.Open_Cursor;
           SYS.DBMS_SQL.PARSE(li_CurSumTar, v_SQL, SYS.DBMS_SQL.V7);
           SYS.DBMS_SQL.DEFINE_COLUMN(li_CurSumTar, 1, ln_SumCr);
           SYS.DBMS_SQL.DEFINE_COLUMN(li_CurSumTar, 2, ln_SumCd);
           SYS.DBMS_SQL.DEFINE_COLUMN(li_CurSumTar, 3, ln_SumCq1);
           SYS.DBMS_SQL.DEFINE_COLUMN(li_CurSumTar, 4, ln_SumCq3);
           li_Rtn := SYS.DBMS_SQL.EXECUTE(li_CurSumTar);
           IF li_Rtn=0 THEN
             li_Rtn := SYS.DBMS_SQL.FETCH_ROWS(li_CurSumTar);
             DBMS_SQL.COLUMN_VALUE(li_CurSumTar, 1, ln_SumCr);
             DBMS_SQL.COLUMN_VALUE(li_CurSumTar, 2, ln_SumCd);
             DBMS_SQL.COLUMN_VALUE(li_CurSumTar, 3, ln_SumCq1);
             DBMS_SQL.COLUMN_VALUE(li_CurSumTar, 4, ln_SumCq3);

/*dbms_output.put_line(to_char(ln_SumCr));
dbms_output.put_line(to_char(ln_SumCd));
dbms_output.put_line(to_char(ln_SumCq1));
dbms_output.put_line(to_char(ln_SumCq3));
*/
             IF ln_SumAllr>0 THEN
                ln_SumCr := ln_SumCr/ln_SumAllr;
             ELSE
                ln_SumCr := 0;
             END IF;
             IF ln_SumAlld>0 THEN
                ln_SumCd := ln_SumCd/ln_SumAlld;
             ELSE
                ln_SumCd := 0;
             END IF;
             IF ln_SumAllq1>0 THEN
                ln_SumCq1 := ln_SumCq1/ln_SumAllq1;
             ELSE
                ln_SumCq1 := 0;
             END IF;
             IF ln_SumAllq3>0 THEN
                ln_SumCq3 := ln_SumCq3/ln_SumAllq3;
             ELSE
                ln_SumCq3 := 0;
             END IF;
           END IF;
           DBMS_SQL.CLOSE_CURSOR(li_CurSumTar);
     ELSE
       ln_SumCr := 0;
       ln_SumCd := 0;
       ln_SumCq1 := 0;
       ln_SumCq3 := 0;
     END IF;

/*dbms_output.put_line(to_char(ln_SumCr));
dbms_output.put_line(to_char(ln_SumCd));
dbms_output.put_line(to_char(ln_SumCq1));
dbms_output.put_line(to_char(ln_SumCq3));
  */   -- Зона D
--dbms_output.put_line('========= Зона D =============');
     IF lt_zoneD.Count>0 THEN
           v_SQL := 'SELECT nvl(SUM(er),0), nvl(SUM(ed),0), nvl(SUM(q1),0), nvl(SUM(q3),0) FROM halfhour WHERE mid = '||to_char(feeders_sel.mid)||' AND( ';
           li_i := 1;
           v_SQL := v_SQL||'(date_time>to_date('||''''||
              to_char(lt_zoneD(li_i).StDate, 'dd.mm.yyyy hh24:mi')||''''||','||''''||'dd.mm.yyyy hh24:mi'||''''||
             ') AND date_time<=to_date('||''''||to_char(lt_zoneD(li_i).FinDate, 'dd.mm.yyyy hh24:mi')||''''||','||''''||
             'dd.mm.yyyy hh24:mi'||''''||'))';
          FOR li_i IN 2..lt_zoneD.Count LOOP
             v_SQL := v_SQL||' OR (date_time>to_date('||''''||
             to_char(lt_zoneD(li_i).StDate, 'dd.mm.yyyy hh24:mi')||''''||','||''''||'dd.mm.yyyy hh24:mi'||''''||
             ') AND date_time<=to_date('||''''||to_char(lt_zoneD(li_i).FinDate, 'dd.mm.yyyy hh24:mi')||''''||','||''''||
             'dd.mm.yyyy hh24:mi'||''''||'))';
          END LOOP;
           v_SQL := v_SQL||')';
           li_CurSumTar := SYS.DBMS_SQL.Open_Cursor;
           SYS.DBMS_SQL.PARSE(li_CurSumTar, v_SQL, SYS.DBMS_SQL.V7);
           SYS.DBMS_SQL.DEFINE_COLUMN(li_CurSumTar, 1, ln_SumDr);
           SYS.DBMS_SQL.DEFINE_COLUMN(li_CurSumTar, 2, ln_SumDd);
           SYS.DBMS_SQL.DEFINE_COLUMN(li_CurSumTar, 3, ln_SumDq1);
           SYS.DBMS_SQL.DEFINE_COLUMN(li_CurSumTar, 4, ln_SumDq3);
           li_Rtn := SYS.DBMS_SQL.EXECUTE(li_CurSumTar);
           IF li_Rtn=0 THEN
             li_Rtn := SYS.DBMS_SQL.FETCH_ROWS(li_CurSumTar);
             DBMS_SQL.COLUMN_VALUE(li_CurSumTar, 1, ln_SumDr);
             DBMS_SQL.COLUMN_VALUE(li_CurSumTar, 2, ln_SumDd);
             DBMS_SQL.COLUMN_VALUE(li_CurSumTar, 3, ln_SumDq1);
             DBMS_SQL.COLUMN_VALUE(li_CurSumTar, 4, ln_SumDq3);

/*dbms_output.put_line(to_char(ln_SumDr));
dbms_output.put_line(to_char(ln_SumDd));
dbms_output.put_line(to_char(ln_SumDq1));
dbms_output.put_line(to_char(ln_SumDq3));
*/
             IF ln_SumAllr>0 THEN
                ln_SumDr := ln_SumDr/ln_SumAllr;
             ELSE
                ln_SumDr := 0;
             END IF;
             IF ln_SumAlld>0 THEN
                ln_SumDd := ln_SumDd/ln_SumAlld;
             ELSE
                ln_SumDd := 0;
             END IF;
             IF ln_SumAllq1>0 THEN
                ln_SumDq1 := ln_SumDq1/ln_SumAllq1;
             ELSE
                ln_SumDq1 := 0;
             END IF;
             IF ln_SumAllq3>0 THEN
                ln_SumDq3 := ln_SumDq3/ln_SumAllq3;
             ELSE
                ln_SumDq3 := 0;
             END IF;
           END IF;
           DBMS_SQL.CLOSE_CURSOR(li_CurSumTar);
     ELSE
       ln_SumDr := 0;
       ln_SumDd := 0;
       ln_SumDq1 := 0;
       ln_SumDq3 := 0;
     END IF;

/*dbms_output.put_line(to_char(ln_SumDr));
dbms_output.put_line(to_char(ln_SumDd));
dbms_output.put_line(to_char(ln_SumDq1));
dbms_output.put_line(to_char(ln_SumDq3));
*/
      UPDATE feeders SET
      ncra = ln_SumAr, ncrb = ln_SumBr, ncrc = ln_SumCr, ncrd = ln_SumDr,
      ncda = ln_SumAd, ncdb = ln_SumBd, ncdc = ln_SumCd, ncdd = ln_SumDd,
      ncq1a = ln_SumAq1, ncq1b = ln_SumBq1, ncq1c = ln_SumCq1, ncq1d = ln_SumDq1,
      ncq3a = ln_SumAq3, ncq3b = ln_SumBq3, ncq3c = ln_SumCq3, ncq3d = ln_SumDq3
      WHERE mid = feeders_sel.mid;
      COMMIT;
   END LOOP;   -- Цикл по всем фидерам

 END;

 PROCEDURE SetEndTime
 IS
 begin
   update rates set time = time - trunc(time, 'yyyy') + trunc(time, 'cc');
   update rates r set endtime = (select min(time) from rates where rid = r.rid and time > r.time);
   update rates r set endtime = trunc(time) + 1 - 1/86400 where endtime is null;
 --  commit;
 end;

END; -- Package Body RATE_PG
/

-- End of DDL script for RATES_PG

-- Start of DDL script for REPORTGROUPS_PG
-- Generated 27-янв-03  11:34:02 am
-- from oe-RYDA:1

-- Package body REPORTGROUPS_PG

CREATE OR REPLACE
PACKAGE BODY REPORTGROUPS_PG
IS
  -- пакет работы с отчетными группами
  -- дата создания 14/10/2001 (Сечин А.А.)
------------------------------------------------------------------------------------------------------------------------
  -- Процедура вставки
 PROCEDURE ins_p(
  an_parent          NUMBER, --Ид родителя
  av_name            VARCHAR2, --Название
  an_grouptype       NUMBER, --Ид типа группы
  av_groupkind       VARCHAR2, --Вид группы Главная или Состовляющая
  an_procedure       NUMBER, --Ид процедуры
  an_department      NUMBER, --Ид подразделения
  an_id              NUMBER, --Ид точки
  an_coef            NUMBER, --Коэф вхождения точки
  an_reportgroup OUT NUMBER --Ид группы
                           )
 IS
  ln_reportgroup NUMBER;
 BEGIN
  SELECT report_s.NEXTVAL
    INTO ln_reportgroup
    FROM DUAL;
  an_reportgroup := ln_reportgroup;
  INSERT INTO reportgroups
              (nreportgroup, nparent, vname, ngrouptype, vgroupkind, nprocedure, ndepartment, mid,
               ncoef)
       VALUES (ln_reportgroup, an_parent, av_name, an_grouptype, av_groupkind, an_procedure, an_department, an_id,
               an_coef);
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(
    -20001, 'reportgroups_pg.ins_p: Ошибка вставки отчетной группы. ' ||
            CHR(10) ||
            SQLERRM(SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
  -- Процедура обновления данных
 PROCEDURE upd_p(
  an_reportgroup NUMBER, --Ид группы
  an_parent      NUMBER, --Ид родителя
  av_name        VARCHAR2, --Название
  an_grouptype   NUMBER, --Ид типа группы
  av_groupkind   VARCHAR2, --Вид группы Главная или Состовляющая
  an_procedure   NUMBER, --Ид процедуры
  an_department  NUMBER, --Ид подразделения
  an_id          NUMBER, --Ид точки
  an_coef        NUMBER --Коэф вхождения точки
                       )
 IS
 BEGIN
  UPDATE reportgroups
     SET nparent = an_parent,
         vname = av_name,
         ngrouptype = an_grouptype,
         vgroupkind = av_groupkind,
         nprocedure = an_procedure,
         ndepartment = an_department,

--         mid = an_id,
         ncoef = an_coef
   WHERE nreportgroup = an_reportgroup;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(
    -20001, 'reportgroups_pg.upd_p: Ошибка обновления отчетной группы. ' ||
            CHR(10) ||
            SQLERRM(SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
  -- Процедура удаления данных
 PROCEDURE del_p(
  an_reportgroup NUMBER --Ид группы
                       )
 IS
 BEGIN
  DELETE FROM reportgroups
        WHERE nreportgroup = an_reportgroup;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(
    -20001, 'reportgroups_pg.del_p: Ошибка удаления отчетной группы. ' ||
            CHR(10) ||
            SQLERRM(SQLCODE));
 END;
-----------------------------------------------------------------------------------------------------------------------
END; -- Package Body
/

-- End of DDL script for REPORTGROUPS_PG

-- Start of DDL script for REPORTS1_PG
-- Generated 27-янв-03  11:34:03 am
-- from oe-RYDA:1

-- Package body REPORTS1_PG

CREATE OR REPLACE
PACKAGE BODY reports1_pg IS
  ------------------------------------------------------------------------------------------------------------------------
    -- пакет по созданию отчетов в файл
    -- дата создания 27/07/2002 Сечин А.А.
 ------------------------------------------------------------------------------------------------------------------------
 --Макет 1010
 PROCEDURE m1010_p(an_maket NUMBER, ad_date DATE, av_fname IN OUT VARCHAR2) IS
  CURSOR lcur_sel IS
   SELECT ngroup, vcode
     FROM maketgroups
    WHERE nmaket = an_maket;
  CURSOR lcur_sel1(lc_group NUMBER) IS
   SELECT mid, nkc, ntype
     FROM maketpoints
    WHERE ngroup = lc_group;
  ln_ras    NUMBER;
  ln_allras NUMBER;
 BEGIN
  file_pg.out_p('##01010 57 '|| TO_CHAR(ad_date, 'YYMMDD') || ' Данные счетчиков. ХЦПЭС');
  FOR lc IN lcur_sel LOOP
   ln_allras := 0;
   FOR lc1 IN lcur_sel1(lc.ngroup) LOOP
    SELECT ROUND(
            lc1.nkc *
            SUM(
             DECODE(
              lc1.ntype, 1, b.er, 2, b.ed, 3, b.q1, 4, b.q3, 5, util_pg.sld(b.mid, NVL(b.er, 0), NVL(b.ed, 0)), 6,
              util_pg.sld(b.mid, NVL(b.q1, 0), NVL(b.q3, 0)))))
      INTO ln_ras
      FROM halfhour b
     WHERE b.mid = lc1.mid AND b.date_time > TRUNC(ad_date) AND b.date_time <= TRUNC(ad_date) + 1;
    ln_allras := ln_allras + NVL(ln_ras, 0);
   END LOOP;
   file_pg.out_p(TO_CHAR(ad_date, 'DD ') || lc.vcode || ln_allras);
  END LOOP;
  file_pg.out_p('##');
 EXCEPTION
  WHEN OTHERS THEN
   RAISE;
 END;
 ------------------------------------------------------------------------------------------------------------------------
 PROCEDURE m30817_p(an_maket NUMBER, ad_date DATE, av_fname IN OUT VARCHAR2) IS
 --
-- Purpose: Формирование М3081 с переносом остатков округлений
--
-- MODIFICATION HISTORY
-- Person      Date    Comments
-- ---------   ------  -------------------------------------------
-- Вештак      30.12.02
cursor lc_maketgroups is
  select ngroup, vcode from maketgroups where nmaket = an_maket;
lv_str          varchar2(1000);
i               number;
nsign_          number;
groupcode_      number;
subgroupcode_   number;
ntemp           number;

BEGIN
  delete from makettemp;
  insert into makettemp (groupcode, subgroupcode, nsign)
    select groupcode, subgroupcode, nsign from maketformulas
    where nmaket = an_maket;
  update makettemp m set groupcode = (select ngroup from maketgroups where nmaket = an_maket and vcode = m.groupcode);
  update makettemp m set subgroupcode = (select ngroup from maketgroups where nmaket = an_maket and vcode = m.subgroupcode);

  delete from M30817;
  insert into M30817 (ngroup, hour, kWh, err) select ngroup, 0, 0, 0 from maketgroups where nmaket = an_maket
  and ngroup not in (select groupcode from makettemp);
  insert into M30817 (ngroup, hour, kWh)
    select p.ngroup, to_char(date_time-1/1440,'hh24')+1,  sum(nkc*(nvl(ed,0)-nvl(er,0))) from maketgroups g, maketpoints p, halfhour h
    where g.nmaket = an_maket
    and g.ngroup not in (select groupcode from makettemp)
    and p.ngroup = g.ngroup and h.mid = p.mid
    and h.date_time > trunc(ad_date)
    and h.date_time <= trunc(ad_date)+1
    group by p.ngroup, to_char(date_time-1/1440,'hh24');

  for i in 1..24 loop
    update M30817 m set (kWh, err) =
      (select round(a.kWh/1000 + b.err), a.kWh/1000+b.err-round(a.kWh/1000 + b.err) from M30817 a, M30817 b
       where a.ngroup = b.ngroup and a.hour = b.hour+1 and a.ngroup = m.ngroup and a.hour = i)
     where hour = i;
  end loop;

  for i in 0..24 loop
    insert into M30817 (ngroup, hour, kWh)
      select ngroup, i, 0 from maketgroups where nmaket = an_maket
      and ngroup in (select groupcode from makettemp);
  end loop;

  loop
    begin
      select groupcode, subgroupcode, nsign into groupcode_, subgroupcode_, nsign_
      from makettemp where subgroupcode not in (select groupcode from makettemp)
      and rownum = 1;
      exception when no_data_found then exit;
    end;

    for i in 1..24 loop
      begin
        select nsign_ * kWh into ntemp from M30817 where ngroup = subgroupcode_ and hour = i;
        exception when no_data_found then ntemp := 0;
      end;
      update M30817 set kWh = kWh + ntemp where ngroup = groupcode_ and hour = i;
    end loop;
/*
    update M30817 m set kWh =
      (select m.kWh + nsign_ * nvl(kWh, 0) from M30817 mm
      where ngroup = subgroupcode_
      and hour = m.hour)
    where ngroup = groupcode_;
*/
    delete from makettemp where groupcode = groupcode_ and subgroupcode = subgroupcode_;
  end loop;

  update M30817 m set kWh = (select sum(kwh) from M30817 where ngroup = m.ngroup) where hour = 0;

  file_pg.out_p('((//30817:'|| TO_CHAR(ad_date, 'MMDD') || ':000107:++');

  for lc in lc_maketgroups loop
    lv_str := lc.vcode || ':';
    for i in 0..24 loop
      begin
        select lv_str || kWh || ':' into lv_str from M30817 where ngroup = lc.ngroup and hour = i;
      exception when no_data_found then lv_str := lv_str || ':';
      end;
    end loop;
    file_pg.out_p(lv_str);
  end loop;

  file_pg.out_p('==))');

/*
  delete from M30817;
  insert into M30817 (ngroup, hour, kWh, err) select ngroup, 0, 0, 0 from maketgroups where nmaket = an_maket;
  insert into M30817 (ngroup, hour, kWh)
    select p.ngroup, to_char(date_time-1/1440,'hh24')+1,  sum(nkc*(nvl(ed,0)-nvl(er,0))) from maketgroups g, maketpoints p, halfhour h
    where g.nmaket = an_maket and p.ngroup = g.ngroup and h.mid = p.mid
    and h.date_time > trunc(ad_date)
    and h.date_time <= trunc(ad_date)+1
    group by p.ngroup, to_char(date_time-1/1440,'hh24');

  for i in 1..24 loop
    update M30817 m set (kWh, err) =
      (select round(a.kWh/1000 + b.err), a.kWh/1000+b.err-round(a.kWh/1000 + b.err) from M30817 a, M30817 b
       where a.ngroup = b.ngroup and a.hour = b.hour+1 and a.ngroup = m.ngroup and a.hour = i)
     where hour = i;
  end loop;
  update M30817 m set kWh = (select sum(kwh) from M30817 where ngroup = m.ngroup) where hour = 0;
-- comment begin
  delete from makettemp;
  insert into makettemp (groupcode, subgroupcode, nsign)
    select groupcode, subgroupcode, nsign from maketformulas
    where nmaket = an_maket;
  update makettemp m set groupcode = (select ngroup from maketgroups where nmaket = an_maket and vcode = m.groupcode);
  update makettemp m set subgroupcode = (select ngroup from maketgroups where nmaket = an_maket and vcode = m.subgroupcode);
  update M30817 m set kWh =
    (select sum(kWh*nsign) from M30817 mm, makettemp t
     where t.groupcode = m.ngroup and mm.ngroup = t.subgroupcode and mm.hour = m.hour), err = -1
  where ngroup in (select groupcode from makettemp);
-- comment end

  file_pg.out_p('((//30817:'|| TO_CHAR(ad_date, 'MMDD') || ':000107:++');

  for lc in lc_maketgroups loop
    lv_str := lc.vcode || ':';
    for i in 0..24 loop
      begin
        select lv_str || kWh || ':' into lv_str from M30817 where ngroup = lc.ngroup and hour = i;
      exception when no_data_found then lv_str := lv_str || ':';
      end;
    end loop;
    file_pg.out_p(lv_str);
  end loop;

  file_pg.out_p('==))');
*/
  EXCEPTION
    WHEN OTHERS THEN
    RAISE;

END;
 ------------------------------------------------------------------------------------------------------------------------
  --Макет 30817
/* PROCEDURE m30817_p(an_maket NUMBER, ad_date DATE, av_fname IN OUT VARCHAR2) IS
  TYPE tt_number IS TABLE OF NUMBER
   INDEX BY BINARY_INTEGER;
  CURSOR lcur_sel IS
   SELECT ngroup, vcode
     FROM maketgroups
    WHERE nmaket = an_maket
    order by vname;
  CURSOR lcur_sel1(lc_group NUMBER) IS
   SELECT mid, nkc, ntype
     FROM maketpoints
    WHERE ngroup = lc_group;
  CURSOR lcur_ras(lc_mid NUMBER, lc_nkc NUMBER, lc_ntype NUMBER) IS
   SELECT   TO_NUMBER(TO_CHAR(TRUNC(date_time - 1 / 86400, 'HH24'), 'HH24')) dt,
            ROUND(
             lc_nkc *
             nvl(SUM(
              DECODE(
               lc_ntype, 1, b.er, 2, b.ed, 3, b.q1, 4, b.q3, 5, util_pg.sld(b.mid, NVL(b.er, 0), NVL(b.ed, 0)), 6,
               util_pg.sld(b.mid, NVL(b.q1, 0), NVL(b.q3, 0)))),0)) sm
       FROM halfhour b
      WHERE b.mid = lc_mid AND b.date_time > TRUNC(ad_date) AND b.date_time <= TRUNC(ad_date) + 1
   GROUP BY TO_NUMBER(TO_CHAR(TRUNC(date_time - 1 / 86400, 'HH24'), 'HH24'));
  lt_ras    common_pg.tt_number;
  ln_rasall NUMBER;
  lv_str    VARCHAR2(4000);
 BEGIN
  file_pg.out_p('((//30817:'|| TO_CHAR(ad_date, 'MMDD') || ':000107:++');
  FOR lc IN lcur_sel LOOP
   FOR i IN 0 .. 23 LOOP
    lt_ras(i) := 0;
   END LOOP;
   ln_rasall := 0;
   lv_str := '';
   FOR lc1 IN lcur_sel1(lc.ngroup) LOOP
    FOR lc2 IN lcur_ras(lc1.mid, lc1.nkc, lc1.ntype) LOOP
     lt_ras(lc2.dt) := lt_ras(lc2.dt) + lc2.sm;
    END LOOP;
   END LOOP;
   FOR i IN 0 .. 23 LOOP
    lt_ras(i) := ROUND(lt_ras(i) / 1000);
    ln_rasall := ln_rasall + lt_ras(i);
    lv_str := lv_str || lt_ras(i) || ':';
   END LOOP;
   lv_str := lc.vcode || ':' || ln_rasall || ':' || lv_str;
   lt_ras.DELETE;
   file_pg.out_p(lv_str);
  END LOOP;
  file_pg.out_p('==))');
 EXCEPTION
  WHEN OTHERS THEN
   RAISE;
 END;*/
 ------------------------------------------------------------------------------------------------------------------------
 PROCEDURE lastsave_p(an_maket NUMBER, ad_date DATE, av_fname IN OUT VARCHAR2) IS
  CURSOR lcur_sel IS
   SELECT   pp.name || ';' || p.name || ';' || TO_CHAR(PROFILE, 'DD.MM.YYYY HH24:MI:SS') || ';' ||
            TO_CHAR(halfhour, 'DD.MM.YYYY HH24:MI:SS') || ';' || TO_CHAR(bill, 'DD.MM.YYYY HH24:MI:SS') || ';' ||
            TO_CHAR(months, 'DD.MM.YYYY HH24:MI:SS') || ';' || clock || ';' || TO_CHAR(
                                                                                state_date, 'DD.MM.YYYY HH24:MI:SS') ||
            ';' || state_cod || ';' || state_descr || ';' || TO_CHAR(luck, 'DD.MM.YYYY HH24:MI:SS') || ';' ||
            TO_CHAR(trial, 'DD.MM.YYYY HH24:MI:SS') nn
       FROM ryda.last_save b, ryda.points p, ryda.points pp
      WHERE b.mid = p.mid AND p.parent = pp.mid
   ORDER BY pp.name, p.name;
 BEGIN
  file_pg.out_p(
   'Отчет за:'|| TO_CHAR(ad_date, 'DD.MM.YYYY HH24:MI:SS') || '  Текущая дата:' || TO_CHAR(
                                                                                    SYSDATE, 'DD.MM.YYYY HH24:MI:SS'));
  FOR lc IN lcur_sel LOOP
   file_pg.out_p(lc.nn);
  END LOOP;
 END;
------------------------------------------------------------------------------------------------------------------------
END; -- Package Body REPORTS1_PG
/

-- End of DDL script for REPORTS1_PG

-- Start of DDL script for SWITCHES_PG
-- Generated 27-янв-03  11:34:03 am
-- from oe-RYDA:1

-- Package body SWITCHES_PG

CREATE OR REPLACE
Package Body  switches_pg
IS
    -- пакет работы с переключениями ов
    -- дата создания 02/12/2002 (Коваленко А.С)
    -- 05/12/2002 реализация проверок, расчетов и переносов (Вештак)
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура вставки
  PROCEDURE ins_p(
  an_switch                NUMBER, --Ид ОВ
  ad_switch                DATE,   --Дата переключения
  an_mid                   NUMBER, --Ид точки
  an_erm                   NUMBER, --Показание ОВ
  an_edm                   NUMBER, --Показание ОВ
  an_q1m                   NUMBER, --Показание ОВ
  an_q2m                   NUMBER, --Показание ОВ
  an_q3m                   NUMBER, --Показание ОВ
  an_q4m                   NUMBER, --Показание ОВ
  an_user_id               NUMBER, --Ид пользователя
  an_id               OUT NUMBER --Ид строки
                                 ) IS
  ln_mid     NUMBER := an_mid;
  prevmid    number;
  ad_escape  date;
  realescape date;
  ntemp      number;
  dtemp      date;
  vtemp      varchar2(500);
  exact      number;
  nstate_     number;

  er_        number;
  ed_        number;
  q1_        number;
  q2_        number;
  q3_        number;
  q4_        number;
  kc_        number;
 BEGIN
   -- поиск даты конца периода переключения
   select min(dswitch) into ad_escape from switches where nswitch = an_switch and dswitch >= ad_switch;
   if ad_escape is null then ad_escape := to_date('01.01.3001','dd.mm.yyyy'); end if;

   begin
     select mid into ntemp from switches where nswitch = an_switch and dswitch = ad_escape;
     exception when others then ntemp := 0;
   end;
   if not ((ntemp = an_switch and an_mid <> an_switch)
        or (ntemp <> an_switch and an_mid = an_switch)
        or ntemp = 0) then
     raise_application_error(-20001,'ОВ не может переключаться с точки на точку без перевода самого на себя!');
     return;
   end if;
   if an_mid = ntemp then
     raise_application_error(-20001,'Заданное назначение ОВ совпадает со следующим назначением!');
     return;
   end if;
   begin
     select mid into ntemp from switches where nswitch = an_switch and dswitch <= ad_switch and descape >= ad_switch;
     exception when others then ntemp := 0;
   end;
   if an_mid = ntemp then
     raise_application_error(-20001,'Заданное назначение ОВ совпадает с предыдущим назначением!');
     return;
   end if;

   if ad_switch = ad_escape then
     raise_application_error(-20001,'Для заданного ОВ и заданной даты уже есть запись в истории переключений!');
     return;
   end if;
   if an_switch <> an_mid then  -- проверяем, что по точке нет данных и нет другого ОВ в периоде переключения
     begin
       select count(*), min(date_time) into ntemp, dtemp from halfhourold where mid = an_mid and nsource in (10, 20)
       and date_time > ad_switch and date_time <= ad_escape;
       exception when others then ntemp := 0;
     end;
     if ntemp <> 0 then
       raise_application_error(-20001,'Некорректный период. По точке учета есть данные с '||to_char(dtemp,'dd.mm.yyyy hh24:mi'));
       return;
     end if;
     begin
       select min(nswitch) into ntemp from switches where nswitch <> an_switch and mid = an_mid
       and ((dswitch >= ad_switch and dswitch < ad_escape)
       or  (descape > ad_switch and descape <= ad_escape)
       or  (dswitch <= ad_switch and descape >= ad_escape));
       exception when others then ntemp := 0;
     end;
     if ntemp <> 0 then
       select name into vtemp from points where mid = ntemp;
       raise_application_error(-20001,'Обнаружено пересечение периодов переключений с ОВ '||vtemp);
       return;
     end if;
   end if;



     IF an_switch = an_mid THEN
        ln_mid := NULL;
     END IF;
    SELECT points_seq.NEXTVAL INTO an_id FROM DUAL;
    INSERT INTO switches (ID,NSWITCH,DSWITCH,MID,ERM,EDM,Q1M,Q2M,Q3M,Q4M,DENTER,USER_ID, descape)
    VALUES (an_id,an_switch,ad_switch,ln_mid,an_erm,an_edm,an_q1m,an_q2m,an_q3m,an_q4m,sysdate,an_user_id, ad_escape);


  -- корректируем конец периода предыдущего переключения
  update switches set descape = ad_switch where nswitch = an_switch and dswitch =
  (select max(dswitch) from switches where nswitch = an_switch and dswitch < ad_switch);
  begin
    select mid into prevmid from switches where nswitch = an_switch and descape = ad_switch;
    exception when others then prevmid := an_switch;
  end;
  realescape := trunc(ad_escape) + floor(to_char(ad_escape, 'sssss')/1800)*1800/24/60/60;
  if realescape <> ad_escape then realescape := realescape + 1/48; end if;
  update halfhourold set mid = an_mid where mid = prevmid and date_time = realescape and nsource = 50;
  if prevmid <> an_switch then
    update halfhourold h set nexceptcalc = (select nexceptcalc from halfhourold
      where date_time = h.date_time and nsource = h.nsource+20 and nswitch = an_switch)
    where mid = an_switch and date_time > ad_switch and date_time <= ad_escape;
                                 -- удаляем возможные дубликаты профиля ОВ в точках учета
    delete from halfhourold where nswitch = an_switch and date_time > ad_switch and date_time <= ad_escape;
  end if;

  if an_switch <> an_mid then    -- если ОВ переключили на точку, то дублируем профиль ОВ с ид точки
    insert into halfhourold (mid, date_time, nsource, nswitch, nexceptcalc, er, ed, q1, q2, q3, q4)
    (select an_mid, date_time, nsource+20, an_switch, nexceptcalc, er, ed, q1, q2, q3, q4
     from halfhourold where mid = an_switch
     and date_time > ad_switch
     and date_time <= ad_escape and nsource in (10, 20));
                                 -- исключаем из расчета профиль ОВ
    update halfhourold set nexceptcalc = 1 where mid = an_switch and date_time  > ad_switch
     and date_time <= realescape and nsource in (10, 20);
  end if;
/*
  else                           -- ОВ прешел сам на себя. Аккуратно проставляем признак включения в расчет
     update halfhourold h set nexceptcalc = (select nexceptcalc from halfhourold
       where date_time = h.date_time and nsource = h.nsource+20 and nswitch = an_switch)
     where mid = an_switch and date_time > ad_switch and date_time <= ad_escape;
                                 -- удаляем возможные дубликаты профиля ОВ в точках учета
     delete from halfhourold where nswitch = an_switch and date_time > ad_switch and date_time <= ad_escape;
  end if;
*/

  exact := 1;
  if to_char(ad_switch, 'sssss') = floor(to_char(ad_switch, 'sssss')/1800)*1800 then
    exact := 0;
  end if;
  nstate_ := -1;  vtemp := '';
  if prevmid = an_mid then
    nstate_ := 0;
  end if;
  if nvl(an_erm,0)=0 and nvl(an_edm,0)=0 and nvl(an_q1m,0)=0 and nvl(an_q2m,0)=0 and nvl(an_q3m,0)=0 and nvl(an_q4m,0)=0 then
    if exact = 1 then nstate_ := 0; else nstate_ := 2; end if;
    vtemp := 'Нет показаний для расчета переключения';
  end if;

  if nstate_ = -1 then
    dtemp := trunc(ad_switch) + floor(to_char(ad_switch, 'sssss')/1800)*1800/24/60/60 + 1/48;
    begin
      select count(*) into ntemp from monthsorg where mid = an_switch and date_time = trunc(ad_switch, 'mm');
      exception when others then ntemp := 0;
    end;
    if ntemp = 0 then
      vtemp := 'Нет предыдущих показаний OB для расчета переключения';
      nstate_ := 1 + exact;
    end if;
    begin
      select min(nsource) into ntemp from halfhourold where mid = an_switch and date_time = dtemp;
      exception when others then ntemp := 0;
    end;
    if ntemp = 0 then
      vtemp := 'Нет данных профиля нагрузки OB для расчета переключения';
      nstate_ := 1 + exact;
    end if;
  end if;

  if nstate_ = -1 then
    select max(digits) into ntemp from meters where mid = an_switch;
    select kc into kc_ from feeders where mid = an_switch;
    select kc_ * (nvl(an_erm,erm)-erm - ceil((sign(nvl(an_erm,erm)-erm)-1)/2) * floor(ntemp+1)),
           kc_ * (nvl(an_edm,edm)-edm - ceil((sign(nvl(an_edm,edm)-edm)-1)/2) * floor(ntemp+1)),
           kc_ * (nvl(an_q1m,q1m)-q1m - ceil((sign(nvl(an_q1m,q1m)-q1m)-1)/2) * floor(ntemp+1)),
           kc_ * (nvl(an_q2m,q2m)-q2m - ceil((sign(nvl(an_q2m,q2m)-q2m)-1)/2) * floor(ntemp+1)),
           kc_ * (nvl(an_q3m,q3m)-q3m - ceil((sign(nvl(an_q3m,q3m)-q3m)-1)/2) * floor(ntemp+1)),
           kc_ * (nvl(an_q4m,q4m)-q4m - ceil((sign(nvl(an_q4m,q4m)-q4m)-1)/2) * floor(ntemp+1))
    into er_, ed_, q1_, q2_, q3_, q4_
    from monthsorg
    where mid = an_switch and date_time = trunc(ad_switch,'mm');

    select er_ - sum(er), ed_ - sum(ed), q1_ - sum(q1), q2_ - sum(q2), q3_ - sum(q3), q4_ - sum(q4)
    into er_, ed_, q1_, q2_, q3_, q4_
    from halfhourold
    where mid = an_switch and date_time > trunc(ad_switch,'mm') and date_time <= ad_switch and nsource = 10;

    insert into halfhourold (mid, date_time, nsource, nswitch, nexceptcalc, er, ed, q1, q2, q3, q4)
    values (prevmid, dtemp, 50, an_switch, null, er_, ed_, q1_, q2_, q3_, q4_);

    select er-er_, ed-ed_, q1-q1_, q2-q2_, q3-q3_, q4-q4_
    into er_, ed_, q1_, q2_, q3_, q4_
    from halfhourold
    where mid = an_switch and date_time = dtemp and nsource = 10;

    insert into halfhourold (mid, date_time, nsource, nswitch, nexceptcalc, er, ed, q1, q2, q3, q4)
    values (an_mid, dtemp, 50, an_switch, null, er_, ed_, q1_, q2_, q3_, q4_);
    delete from halfhourold where mid = an_mid and date_time = dtemp and nsource = 30;
    if an_mid = an_switch then
      update halfhourold set nexceptcalc = 1 where mid = an_mid and date_time = dtemp and nsource = 10;
    end if;

    nstate_ := 0;
  end if;

  update switches set nstate = decode(nstate_,0,1,1,2,0), verror = vtemp where id = an_id;
   EXCEPTION
    WHEN OTHERS THEN
     raise_application_error(-20001, 'switches_pg.ins_p: Ошибка вставки переключения ОВ. ' || CHR(10) || SQLERRM(SQLCODE));
 END;
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура обновления данных
 PROCEDURE upd_p(
  an_id                   NUMBER, --Ид строки
  an_switch                NUMBER, --Ид ОВ
  ad_switch                DATE,   --Дата переключения
  an_mid                   NUMBER, --Ид точки
  an_erm                   NUMBER, --Показание ОВ
  an_edm                   NUMBER, --Показание ОВ
  an_q1m                   NUMBER, --Показание ОВ
  an_q2m                   NUMBER, --Показание ОВ
  an_q3m                   NUMBER, --Показание ОВ
  an_q4m                   NUMBER, --Показание ОВ
  an_user_id               NUMBER --Ид пользователя
                             ) IS
  ln_mid     NUMBER := an_mid;
  prevmid    number;
  ad_escape  date;
  ntemp      number;
  dtemp      date;
  vtemp      varchar2(500);
 BEGIN
   del_p(an_id);
   ins_p(an_switch, ad_switch, an_mid, an_erm, an_edm, an_q1m, an_q2m, an_q3m, an_q4m, an_user_id, ntemp);
   update switches set id = an_id where id = ntemp;

/*
    IF an_switch = an_mid THEN
        ln_mid := NULL;
     END IF;
   UPDATE switches SET NSWITCH = an_switch, DSWITCH = ad_switch,MID = ln_mid,ERM = an_erm,
                       EDM = an_edm,Q1M = an_q1m,Q2M = an_q2m,Q3M = an_q3m,Q4M = an_q4m,
                       DENTER = sysdate,USER_ID = an_user_id
   WHERE ID = an_id;
*/
   EXCEPTION
    WHEN OTHERS THEN
     raise_application_error(-20001, 'switches_pg.upd_p: Ошибка редaктирования переключения ОВ. ' || CHR(10) || SQLERRM(SQLCODE));
 END;
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура удаления данных
 PROCEDURE del_p(an_id NUMBER --Ид строки
                              ) IS
 an_switch  number;
 an_mid     number;
 prevmid    number;
 nextmid    number;
 ad_switch  date;
 ad_escape  date;
 realswitch date;
 realescape date;
 ntemp      number;
 dtemp      date;
 er_        number;
 ed_        number;
 q1_        number;
 q2_        number;
 q3_        number;
 q4_        number;
 BEGIN
  select nswitch, dswitch, descape, nvl(mid,nswitch) into an_switch, ad_switch, ad_escape, an_mid from switches where id = an_id;
  realswitch := trunc(ad_switch) + floor(to_char(ad_switch, 'sssss')/1800)*1800/24/60/60;
  if realswitch <> ad_switch then realswitch := realswitch + 1/48; end if;
  realescape := trunc(ad_escape) + floor(to_char(ad_escape, 'sssss')/1800)*1800/24/60/60;
  if realescape <> ad_escape then realescape := realescape + 1/48; end if;
  begin
    select nvl(mid, an_switch) into prevmid from switches where nswitch = an_switch and descape = ad_switch;
    exception when others then prevmid := an_switch;
  end;
  begin
    select nvl(mid, an_switch) into nextmid from switches where nswitch = an_switch and dswitch = ad_escape;
    exception when others then nextmid := 0;
  end;


  delete from halfhourold where nswitch = an_switch and nsource = 50 and date_time = realswitch;
  if an_mid <> an_switch then
    insert into halfhourold (mid, date_time, nsource, nswitch, nexceptcalc, er, ed, q1, q2, q3, q4)
      select an_mid, date_time, 30, an_switch, null, er, ed, q1, q2, q3, q4 from halfhourold
        where mid = an_switch and date_time = realswitch and nsource =
        (select min(nsource) from halfhourold where mid = an_switch and date_time = realswitch and nsource in (10,20));
  else
    update halfhourold set nexceptcalc = null where mid = an_switch and date_time = realswitch and nsource = 10;
  end if;

  if nextmid = prevmid then
    delete from halfhourold where nswitch = an_switch and nsource = 50 and date_time = realescape;
    if nextmid <> an_switch then
      insert into halfhourold (mid, date_time, nsource, nswitch, nexceptcalc, er, ed, q1, q2, q3, q4)
        select an_mid, date_time, 30, an_switch, null, er, ed, q1, q2, q3, q4 from halfhourold
          where mid = an_switch and date_time = realescape and nsource =
          (select min(nsource) from halfhourold where mid = an_switch and date_time = realescape and nsource in (10,20));
    else
      update halfhourold set nexceptcalc = null where mid = an_switch and date_time = realescape and nsource = 10;
    end if;
    delete from switches where nswitch = an_switch and dswitch = ad_escape;
  end if;

  if prevmid <> an_switch then
    if an_mid <> an_switch then
      update halfhourold set mid = prevmid where mid = an_mid and nswitch = an_switch
      and date_time >= realswitch and date_time <= realescape and nsource in (30, 40, 50);
    else
      insert into halfhourold (mid, date_time, nsource, nswitch, nexceptcalc, er, ed, q1, q2, q3, q4)
        select prevmid, date_time, 30, an_switch, null, er, ed, q1, q2, q3, q4 from halfhourold
          where mid = an_switch and date_time > ad_switch and date_time <= ad_escape and nsource = 10;
      update halfhourold set nexceptcalc = 1 where mid = an_mid and nsource in (10,20)
        and date_time > ad_switch and date_time <= ad_escape;
      update halfhourold set mid = prevmid where mid = an_mid and nswitch = an_switch
        and date_time = realescape and nsource = 50;
    end if;
  else
    delete from halfhourold where mid = an_mid and nswitch = an_switch and nsource in (30, 40)
      and date_time > ad_switch and date_time <= realescape;
    update halfhourold set nexceptcalc = null
      where mid = an_switch and nsource = 10 and date_time > ad_switch and date_time <= realescape;
/*
    update halfhourold h set nexceptcalc = null
      where mid = an_switch and date_time > ad_switch and date_time <= ad_escape and nsource = 20
      and not exists (select * from halfhourold where mid = an_switch and date_time = h.date_time and nsource = 10);
*/
  end if;

  update switches set descape = ad_escape where nswitch = an_switch and descape = ad_switch;

  DELETE FROM switches WHERE ID = an_id;

  return;

  if prevmid = 0 then
    delete from halfhourold where nswitch = an_switch and date_time > ad_switch and date_time <= ad_escape;
    update halfhourold set nexceptcalc = null
      where mid = an_switch and date_time > ad_switch and date_time <= ad_escape and nsource = 10;
    update halfhourold h set nexceptcalc = null
      where mid = an_switch and date_time > ad_switch and date_time <= ad_escape and nsource = 20
      and not exists (select * from halfhourold where mid = an_switch and date_time = h.date_time and nsource = 10);
    update halfhourold set mid = an_switch where mid = an_mid and nsource = 50 and date_time = realescape;
  else
    delete from halfhourold where nswitch = an_switch and nsource = 50 and date_time = realswitch;
    if prevmid <> an_switch and an_mid <> an_switch then
      update halfhourold set mid = prevmid where mid = an_mid and nsource in (30, 40, 50)
        and date_time > ad_switch and date_time <= realescape;
      begin
        insert into halfhourold (mid, date_time, nsource, nswitch, nexceptcalc, er, ed, q1, q2, q3, q4)
          select prevmid, date_time, nsource+20, an_switch, null, er, ed, q1, q2, q3, q4 from halfhourold
          where mid = an_switch and date_time = realswitch and nsource = 10;
        exception when others then null;
      end;
    elsif prevmid <> an_switch and an_mid = an_switch then
      update halfhourold set nexceptcalc = 1
        where mid = an_switch and date_time > ad_switch and date_time <= ad_escape;
      insert into halfhourold (mid, date_time, nsource, nswitch, nexceptcalc, er, ed, q1, q2, q3, q4)
        select prevmid, date_time, 30, an_switch, null, er, ed, q1, q2, q3, q4 from halfhourold
        where mid = an_switch and nsource = 10 and date_time > ad_switch and date_time <= ad_escape;
      update halfhourold set mid = prevmid, nexceptcalc = null
        where mid = an_switch and nsource = 50 and date_time = realescape;
    elsif prevmid = an_switch and an_mid <> an_switch then
      delete from halfhourold where mid = an_mid and nsource in (30, 40)
        and date_time > ad_switch and date_time <= ad_escape;
      update halfhourold set nexceptcalc = null
        where mid = an_switch and nsource = 10 and date_time > ad_switch and date_time <= ad_escape;
      update halfhourold h set nexceptcalc = null
        where mid = an_switch and date_time > ad_switch and date_time <= ad_escape and nsource = 20
        and not exists (select * from halfhourold where mid = an_switch and date_time = h.date_time and nsource = 10);
      if prevmid <> nextmid then
        update halfhourold set mid = an_switch where nswitch = an_switch and nsource = 50 and date_time = realescape;
      else
        delete from halfhourold where nsource = 50 and nswitch = an_switch and date_time = realescape;
        update halfhourold set nexceptcalc = null where nsource = 10 and mid = an_switch and date_time = realescape;
      end if;
    elsif prevmid = an_switch and an_mid = an_switch then
      NULL;
    end if;
  end if;

  update switches set descape = ad_escape where nswitch = an_switch and descape = ad_switch;

  DELETE FROM switches WHERE ID = an_id;

  return;


  if an_switch <> an_mid then   -- если ОВ работал на точку, то возвращаем профиль на ОВ
  /*
    update halfhourold h set nexceptcalc = (select nexceptcalc from halfhourold
       where date_time = h.date_time and nsource = h.nsource+20 and nswitch = an_switch)
     where mid = an_switch and date_time > ad_switch and date_time <= ad_escape;
  */
    update halfhourold h set nexceptcalc = null
     where mid = an_switch and nsource = 10 and date_time > ad_switch and date_time <= ad_escape;
                                 -- удаляем возможные дубликаты профиля ОВ в точках учета
     delete from halfhourold where nswitch = an_switch and date_time > ad_switch and date_time <= ad_escape;

  end if;
  begin
    select er, ed, q1, q2, q3, q4 into er_, ed_, q1_, q2_, q3_, q4_
    from halfhourold where nswitch = an_switch and nsource = 50 and date_time = dtemp;
    exception when others then
      er_ := 0; ed_ := 0; q1_ := 0; q2_ := 0; q3_ := 0; q4_ := 0;
  end;
     delete from halfhourold where nswitch = an_switch and nsource = 50 and date_time = dtemp;

  begin
    select mid into prevmid from switches where nswitch = an_switch and descape = ad_switch;
    exception when others then prevmid := 0;
  end;
  if prevmid <> 0 and prevmid <> an_switch then  -- если предыдущее переключение было на точку, то сносим профиль на нее
    insert into halfhourold (mid, date_time, nsource, nswitch, nexceptcalc, er, ed, q1, q2, q3, q4)
    (select prevmid, date_time, nsource+20, an_switch, nexceptcalc, er, ed, q1, q2, q3, q4
     from halfhourold where mid = an_switch
     and date_time > ad_switch
     and date_time <= ad_escape and nsource in (10, 20));

    if er_+ed_+q1_+q2_+q3_+q4_ <> 0 then
      insert into halfhourold (mid, date_time, nsource, nswitch, nexceptcalc, er, ed, q1, q2, q3, q4)
      values(prevmid, dtemp, 50, an_switch, null, er_, ed_, q1_, q2_, q3_, q4_);
    end if;
                                 -- исключаем из расчета профиль ОВ
    update halfhourold set nexceptcalc = 1 where mid = an_switch and date_time  > ad_switch
     and date_time <= ad_escape and nsource in (10, 20);
  end if;


  update switches set descape = ad_escape where nswitch = an_switch and descape = ad_switch;

   DELETE FROM switches WHERE ID = an_id;

   EXCEPTION
    WHEN OTHERS THEN
     raise_application_error(-20001, 'switches_pg.del_p: Ошибка удаления переключения ОВ. ' || CHR(10) || SQLERRM(SQLCODE));
 END;
 ------------------------------------------------------------------------------------------------------------------------
   -- Процедура расчета
PROCEDURE meterings (
an_switch   number,
ad_switch   date,
time1 out   varchar2,
er1 out     varchar2,
ed1 out     varchar2,
q11 out     varchar2,
q21 out     varchar2,
q31 out     varchar2,
q41 out     varchar2,
time2 out   varchar2,
er2 out     varchar2,
ed2 out     varchar2,
q12 out     varchar2,
q22 out     varchar2,
q32 out     varchar2,
q42 out     varchar2
 ) IS

  ntemp      number;
  dtemp      date;
  vtemp      varchar2(500);
  kc_        number;

begin
  dtemp := trunc(ad_switch) + floor(to_char(ad_switch, 'sssss')/1800)*1800/24/60/60;
  select kc into kc_ from feeders where mid = an_switch;
  begin
    time1 := to_char(dtemp, 'hh24:mi');
    select max(digits) into ntemp from meters where mid = an_switch;
    select erm, edm, q1m, q2m, q3m, q4m into er1, ed1, q11, q21, q31, q41
    from months where mid = an_switch and date_time = trunc(ad_switch,'mm');
    select round(er1+sum(er)/kc_ + ceil((sign(ntemp-(er1+sum(er)/kc_))-1)/2) * floor(ntemp+1),5),
           round(ed1+sum(ed)/kc_ + ceil((sign(ntemp-(ed1+sum(ed)/kc_))-1)/2) * floor(ntemp+1),5),
           round(q11+sum(q1)/kc_ + ceil((sign(ntemp-(q11+sum(q1)/kc_))-1)/2) * floor(ntemp+1),5),
           round(q21+sum(q2)/kc_ + ceil((sign(ntemp-(q21+sum(q2)/kc_))-1)/2) * floor(ntemp+1),5),
           round(q31+sum(q3)/kc_ + ceil((sign(ntemp-(q31+sum(q3)/kc_))-1)/2) * floor(ntemp+1),5),
           round(q41+sum(q4)/kc_ + ceil((sign(ntemp-(q41+sum(q4)/kc_))-1)/2) * floor(ntemp+1),5)
           into er1, ed1, q11, q21, q31, q41
    from halfhourold where mid = an_switch
    and date_time > trunc(ad_switch, 'mm')
    and date_time <= ad_switch
    and nsource = 10;
    if ad_switch <> dtemp then
      time2 := to_char(dtemp+1/48, 'hh24:mi');
      select round(er1+er/kc_ + ceil((sign(ntemp-(er1+er/kc_))-1)/2) * floor(ntemp+1),5),
             round(ed1+ed/kc_ + ceil((sign(ntemp-(ed1+ed/kc_))-1)/2) * floor(ntemp+1),5),
             round(q11+q1/kc_ + ceil((sign(ntemp-(q11+q1/kc_))-1)/2) * floor(ntemp+1),5),
             round(q21+q2/kc_ + ceil((sign(ntemp-(q21+q2/kc_))-1)/2) * floor(ntemp+1),5),
             round(q31+q3/kc_ + ceil((sign(ntemp-(q31+q3/kc_))-1)/2) * floor(ntemp+1),5),
             round(q41+q4/kc_ + ceil((sign(ntemp-(q41+q4/kc_))-1)/2) * floor(ntemp+1),5)
             into er2, ed2, q12, q22, q32, q42
      from halfhourold where mid = an_switch
      and date_time = dtemp + 1/48
      and nsource = 10;

    end if;

    exception when others then return;
  end;
--dbms_output.put_line(to_char(dtemp,'dd.mm.yyyy hh24:mi')||' '||time1||' '||er1||' '||ed1||' '||q11||' '||q21||' '||q31||' '||q41);
--dbms_output.put_line(time2||' '||er2||' '||ed2||' '||q12||' '||q22||' '||q32||' '||q42);
  NULL;
end;

END; -- Package Body SWITCHES_PG
/

-- End of DDL script for SWITCHES_PG

-- Start of DDL script for UTIL_PG
-- Generated 27-янв-03  11:34:03 am
-- from oe-RYDA:1

-- Package body UTIL_PG

CREATE OR REPLACE
PACKAGE BODY util_pg IS
 ------------------------------------------------------------------------------------------------------------------------
   -- пакет общего назначения
   -- дата создания 29/07/2002 Сечин А.А.
 ------------------------------------------------------------------------------------------------------------------------
 gn_customer_id NUMBER; --Ид заказчика
 /*
 0 - По умолчанию
 1 - ХОЭ
 2 - Кировоград ОЭ
 */
  ------------------------------------------------------------------------------------------------------------------------
 gt_sortobject  common_pg.tt_number;
  ------------------------------------------------------------------------------------------------------------------------
 --Отсечение даты до декады
 FUNCTION truncdec(d DATE)
  RETURN DATE IS
 BEGIN
  IF TO_NUMBER(TO_CHAR(d, 'DD')) <= 10 THEN
   RETURN TRUNC(d, 'MM');
  ELSIF TO_NUMBER(TO_CHAR(d, 'DD')) <= 20 THEN
   RETURN TRUNC(d, 'MM') + 10;
  END IF;
  RETURN TRUNC(d, 'MM') + 20;
 END;
 ------------------------------------------------------------------------------------------------------------------------
 --Вычисление декады
 FUNCTION getdec(d DATE)
  RETURN NUMBER IS
 BEGIN
  IF TO_NUMBER(TO_CHAR(d, 'DD')) <= 10 THEN
   RETURN 1;
  ELSIF TO_NUMBER(TO_CHAR(d, 'DD')) <= 20 THEN
   RETURN 2;
  END IF;
  RETURN 3;
 END;
 ------------------------------------------------------------------------------------------------------------------------
 FUNCTION add_dec(d DATE, i INTEGER)
  RETURN DATE IS
  ln_sec    NUMBER;
  ln_daydec NUMBER;
  ln_dec    NUMBER;
  ret       DATE;
 BEGIN
  ln_sec := TO_NUMBER(TO_CHAR(d, 'SSSSS')) / 86400;
  ln_daydec := TRUNC(d) - truncdec(d) + 1;
  ln_dec := getdec(d);
  ret := ADD_MONTHS(TRUNC(d, 'MM'), TRUNC(i / 3));
  IF MOD(i, 3) = -2 THEN
   IF ln_dec = 1 THEN
    ret := ADD_MONTHS(ret, -1);
    ln_dec := 2;
   ELSIF ln_dec = 2 THEN
    ret := ADD_MONTHS(ret, -1);
    ln_dec := 3;
   ELSE
    ln_dec := 1;
   END IF;
  ELSIF MOD(i, 3) = -1 THEN
   IF ln_dec = 1 THEN
    ret := ADD_MONTHS(ret, -1);
    ln_dec := 3;
   ELSIF ln_dec = 2 THEN
    ln_dec := 1;
   ELSE
    ln_dec := 2;
   END IF;
  ELSIF MOD(i, 3) = 1 THEN
   IF ln_dec = 1 THEN
    ln_dec := 2;
   ELSIF ln_dec = 2 THEN
    ln_dec := 3;
   ELSE
    ret := ADD_MONTHS(ret, 1);
    ln_dec := 1;
   END IF;
  ELSIF MOD(i, 3) = 2 THEN
   IF ln_dec = 1 THEN
    ln_dec := 3;
   ELSIF ln_dec = 2 THEN
    ret := ADD_MONTHS(ret, 1);
    ln_dec := 1;
   ELSE
    ret := ADD_MONTHS(ret, 1);
    ln_dec := 2;
   END IF;
  END IF;
  IF ln_dec = 1 OR ln_dec = 2 THEN
   ret := ret + LEAST(10 * (ln_dec - 1) + ln_daydec, 10 * ln_dec) - 1;
  ELSE
   ret := ret + LEAST(20 + ln_daydec, TO_NUMBER(TO_CHAR(LAST_DAY(ret), 'DD'))) - 1;
  END IF;
  RETURN ret + ln_sec;
 END;
 ------------------------------------------------------------------------------------------------------------------------
 --Отсечение до получасовок
 FUNCTION trunchh24_2(d DATE)
  RETURN DATE IS
 BEGIN
  RETURN TRUNC(d) + TRUNC(TO_CHAR(d, 'SSSSS') / 1800) / 48;
 END;
 ------------------------------------------------------------------------------------------------------------------------
  --Возвращает Ид заказчика
 FUNCTION get_customer_id
  RETURN NUMBER IS
 BEGIN
  RETURN gn_customer_id;
 END;
 ------------------------------------------------------------------------------------------------------------------------
  --Возвращает значение долга по группе
 FUNCTION get_group_debt(an_id NUMBER, an_restr NUMBER)
  RETURN NUMBER IS
  ln_ret NUMBER DEFAULT 0;
 BEGIN
  SELECT DECODE(an_restr, 0, MAX(ndeb), MAX(ndebrestr))
    INTO ln_ret
    FROM groups
   WHERE gid = an_id;
  /*  IF NVL(ln_ret, 0) <= 0 THEN
     ln_ret := 0;
    END IF;*/
  RETURN ln_ret;
 END;
 ------------------------------------------------------------------------------------------------------------------------
   --Возвращает 1, если есть данные по точке
 FUNCTION is_point_have_data(an_mid NUMBER)
  RETURN NUMBER IS
  ln_ret NUMBER;
 BEGIN
  SELECT COUNT(*)
    INTO ln_ret
    FROM DUAL
   WHERE EXISTS( SELECT *
                   FROM months e, (SELECT     mid
                                         FROM points
                                   CONNECT BY PRIOR mid = parent
                                   START WITH mid = an_mid) m
                  WHERE e.mid = m.mid)
      OR EXISTS( SELECT *
                   FROM bill e, (SELECT     mid
                                       FROM points
                                 CONNECT BY PRIOR mid = parent
                                 START WITH mid = an_mid) m
                  WHERE e.mid = m.mid)
      OR EXISTS( SELECT *
                   FROM halfhour e, (SELECT     mid
                                           FROM points
                                     CONNECT BY PRIOR mid = parent
                                     START WITH mid = an_mid) m
                  WHERE e.mid = m.mid)
      OR EXISTS( SELECT *
                   FROM PROFILE e, (SELECT     mid
                                          FROM points
                                    CONNECT BY PRIOR mid = parent
                                    START WITH mid = an_mid) m
                  WHERE e.mid = m.mid);
  RETURN ln_ret;
 END;
 ------------------------------------------------------------------------------------------------------------------------
 FUNCTION indicoverturn(an_val NUMBER, an_len NUMBER)
  RETURN NUMBER IS
  ln_res NUMBER;
  k      NUMBER DEFAULT 1;
  ln_len NUMBER DEFAULT TRUNC(NVL(ABS(an_len), 0));
 BEGIN
  ln_res := an_val;
  IF ABS(an_val) < 0.00001 THEN
   RETURN 0;
  END IF;
  IF NVL(an_val, 0) >= 0 THEN
   RETURN ln_res;
  ELSE
   IF ln_len <= 0 OR ln_len < LENGTH(TRUNC(ABS(an_val))) THEN
    ln_len := LENGTH(TRUNC(ABS(an_val)));
   END IF;
   WHILE ln_len > 0 LOOP
    k := k * 10;
    ln_len := ln_len - 1;
   END LOOP;
   ln_res := an_val + k;
  END IF;
  RETURN ln_res;
 END;
 ------------------------------------------------------------------------------------------------------------------------
 FUNCTION needchdr_f(an_mid NUMBER)
  RETURN NUMBER IS
 BEGIN
  IF gn_customer_id=1 OR gn_customer_id=2 THEN
   RETURN 1;
  ELSE
   RETURN 0;
  END IF;
 END;
 ------------------------------------------------------------------------------------------------------------------------
  PROCEDURE chdr(an_mid NUMBER, a IN OUT NUMBER, b IN OUT NUMBER) IS
  z NUMBER;
 BEGIN
  IF (needchdr_f(an_mid) = 1) THEN
   z := a;
   a := b;
   b := z;
  END IF;
 END;
 ------------------------------------------------------------------------------------------------------------------------
 PROCEDURE chdr(an_mid NUMBER, a IN OUT NUMBER, b IN OUT NUMBER, c IN OUT NUMBER, d IN OUT NUMBER) IS
  z NUMBER;
 BEGIN
  IF (needchdr_f(an_mid) = 1) THEN
   z := a;
   a := b;
   b := z;
   z := c;
   c := d;
   d := z;
  END IF;
 END;
 ------------------------------------------------------------------------------------------------------------------------
 PROCEDURE chdr(
  an_mid        NUMBER,
  a      IN OUT NUMBER,
  b      IN OUT NUMBER,
  c      IN OUT NUMBER,
  d      IN OUT NUMBER,
  e      IN OUT NUMBER,
  f      IN OUT NUMBER) IS
  z NUMBER;
 BEGIN
  IF (needchdr_f(an_mid) = 1) THEN
   z := a;
   a := b;
   b := z;
   z := c;
   c := d;
   d := z;
   z := e;
   e := f;
   f := z;
  END IF;
 END;
 ------------------------------------------------------------------------------------------------------------------------
 FUNCTION getpointid(an_point NUMBER)
  RETURN NUMBER IS
  ln_ret NUMBER;
 BEGIN
  SELECT MAX(mid)
    INTO ln_ret
    FROM points
   WHERE npoint = an_point;
  RETURN ln_ret;
 END;
 ------------------------------------------------------------------------------------------------------------------------
 --Переворот прием отдача
 FUNCTION sld(an_mid NUMBER, an_1 NUMBER, an_2 NUMBER)
  RETURN NUMBER IS
 BEGIN
  IF gn_customer_id=1 OR gn_customer_id=2 THEN
   RETURN -(an_1 - an_2);
  ELSE
   RETURN (an_1 - an_2);
  END IF;
 END;
 ------------------------------------------------------------------------------------------------------------------------
  --длиное название точки
 FUNCTION get_pointname(an_mid NUMBER, an_detal NUMBER) --0 только имя, 1 - имя и П.С., 2 - все
  RETURN VARCHAR2 IS
  lv_ret VARCHAR2(2000);
  lv_p   VARCHAR2(2000);
  lv_pa  VARCHAR2(2000);
  ln_smart NUMBER;
  CURSOR lcur_met(lc_smart NUMBER) IS
   SELECT decode(lc_smart,1,'№ '||mtrsn,decode(m.entype,1,'А пр.',2,'А от.',3,'Р пр.','Р ген.')||' №'||mtrsn||';') met
     FROM ryda.meters m
    WHERE m.mid = an_mid
      AND m.date_time = (SELECT MAX(date_time)
                           FROM ryda.meters
                          WHERE mid = an_mid
                            AND date_time < sysdate
                            AND DECODE(smart, '*', 1, 0) = lc_smart
                            AND entype = m.entype)
      AND DECODE(m.smart, '*', 1, 0) = lc_smart;

 BEGIN
  SELECT MAX(p.name), MAX(pa.name),max(DECODE(f.smart, '*',1,0))
    INTO lv_p, lv_pa,ln_smart
    FROM points p, points pa,feeders f
   WHERE p.mid = an_mid AND p.parent = pa.mid(+) and p.mid=f.mid(+);
  IF lv_p IS NOT NULL THEN
   lv_ret := 'Т.у. ' || lv_p;
  END IF;
  IF  an_detal > 0 AND lv_pa IS NOT NULL THEN
   lv_ret := 'П.с. ' || lv_pa || CHR(10) || lv_ret;
  END IF;
  IF an_detal > 1 AND lv_pa IS NOT NULL THEN
   lv_ret:=lv_ret||CHR(10)||'Cчетчики: ';
   FOR lc in lcur_met(ln_smart) loop
    lv_ret:=lv_ret||lc.met||'   ';
   end loop;
  END IF;
  RETURN SUBSTR(NVL(lv_ret, ' '), 1, 255);
 END;
 -------------------------------------------------------------------------------------------------
 PROCEDURE f_preparesortbyl_n IS
 BEGIN
  gt_sortobject.DELETE;
 END;
 -------------------------------------------------------------------------------------------------
 FUNCTION f_recursort(an_id NUMBER, an_sort NUMBER)
  RETURN NUMBER IS
  ln_sort NUMBER DEFAULT an_sort;
  CURSOR lcur_sel1 IS
   SELECT   task_id
       FROM tasks
      WHERE parent IS NULL
   ORDER BY name;
  CURSOR lcur_sel2 IS
   SELECT   task_id
       FROM tasks
      WHERE parent = an_id
   ORDER BY name;
 BEGIN
  IF an_id IS NULL THEN
   FOR lc IN lcur_sel1 LOOP
    ln_sort := ln_sort + 1;
    gt_sortobject(lc.task_id) := ln_sort;
    ln_sort := f_recursort(lc.task_id, ln_sort);
   END LOOP;
  ELSE
   FOR lc IN lcur_sel2 LOOP
    ln_sort := ln_sort + 1;
    gt_sortobject(lc.task_id) := ln_sort;
    ln_sort := f_recursort(lc.task_id, ln_sort);
   END LOOP;
  END IF;
  RETURN ln_sort;
 END;
 -------------------------------------------------------------------------------------------------
 FUNCTION f_sorttaskbyl_n(an_needread NUMBER, an_id NUMBER,an_start NUMBER)
  RETURN NUMBER IS
  ln_sort NUMBER DEFAULT 1;
 BEGIN
  IF NVL(an_needread, 1) <= 1 THEN
   gt_sortobject(an_id) := 1;
   ln_sort := f_recursort(an_start, ln_sort);
  END IF;
  RETURN gt_sortobject(an_id);
 EXCEPTION
  WHEN OTHERS THEN
   RETURN 10000;
 END;
-------------------------------------------------------------------------------------------------
-- Возвращает показания счетчика (рассчет показаний производится на основании
-- месячных или показаний занесенных в таблицу MAN_IMP_HHOUR показаний,
-- путем прибавление пролучасовых расходов)
-- параметр an_etype может принимать значения:
-- 1 - erm
-- 2 - edm
-- 3 - q1m
-- 4 - q2m
-- 5 - q3m
-- 6 - q4m
-- параметр an_meterage_table может принимать значения:
-- 1 - man_inp_hhour
-- 2 - months
-- 3 - billorg
 FUNCTION get_meterage(an_mid NUMBER, ad_date DATE, an_etype NUMBER, an_meterage_table NUMBER)
  RETURN NUMBER IS
  ld_LastDate_Met DATE := NULL;
  ln_m_erm NUMBER;
  ln_m_edm NUMBER;
  ln_m_q1m NUMBER;
  ln_m_q2m NUMBER;
  ln_m_q3m NUMBER;
  ln_m_q4m NUMBER;
  ln_erm NUMBER;
  ln_edm NUMBER;
  ln_q1m NUMBER;
  ln_q2m NUMBER;
  ln_q3m NUMBER;
  ln_q4m NUMBER;
  ln_ret NUMBER;
 BEGIN

  IF an_meterage_table = 1 THEN
     SELECT max(date_time) INTO ld_LastDate_Met FROM ryda.man_inp_hhour WHERE mid = an_mid AND date_time <= ad_date;
     SELECT erm, edm, q1m, q2m, q3m, q4m INTO ln_m_erm, ln_m_edm, ln_m_q1m, ln_m_q2m, ln_m_q3m, ln_m_q4m FROM ryda.man_inp_hhour WHERE mid = an_mid AND date_time = ld_LastDate_Met;
  ELSIF an_meterage_table = 2 THEN
     SELECT max(date_time) INTO ld_LastDate_Met FROM ryda.months WHERE mid = an_mid AND date_time <= ad_date;
     SELECT erm, edm, q1m, q2m, q3m, q4m INTO ln_m_erm, ln_m_edm, ln_m_q1m, ln_m_q2m, ln_m_q3m, ln_m_q4m FROM ryda.months WHERE mid = an_mid AND date_time = ld_LastDate_Met;
  ELSIF an_meterage_table = 3 THEN
     SELECT max(date_time) INTO ld_LastDate_Met FROM ryda.billorg WHERE mid = an_mid AND date_time <= ad_date;
     SELECT erm, edm, q1m, q2m, q3m, q4m INTO ln_m_erm, ln_m_edm, ln_m_q1m, ln_m_q2m, ln_m_q3m, ln_m_q4m FROM ryda.billorg WHERE mid = an_mid AND date_time = ld_LastDate_Met;
  END IF;

  SELECT nvl(sum(er/kc),0), nvl(sum(ed/kc),0), nvl(sum(q1/kc),0), nvl(sum(q2/kc),0), nvl(sum(q3/kc),0), nvl(sum(q4/kc),0)
         INTO ln_erm, ln_edm, ln_q1m, ln_q2m, ln_q3m, ln_q4m
         FROM ryda.halfhour h, ryda.feeders f WHERE f.mid = an_mid
         AND f.mid = h.mid
         AND date_time > ld_LastDate_Met
         AND date_time <= ad_date;

  IF an_etype = 1 THEN
     ln_ret := ln_m_erm + ln_erm;
  ELSIF an_etype = 2 THEN
     ln_ret := ln_m_edm + ln_edm;
  ELSIF an_etype = 3 THEN
     ln_ret := ln_m_q1m + ln_q1m;
  ELSIF an_etype = 4 THEN
     ln_ret := ln_m_q2m + ln_q2m;
  ELSIF an_etype = 5 THEN
     ln_ret := ln_m_q3m + ln_q3m;
  ELSIF an_etype = 6 THEN
     ln_ret := ln_m_q4m + ln_q4m;
  END IF;
  RETURN ln_ret;
/* EXCEPTION
  WHEN OTHERS THEN
   RETURN -1;*/
 END;
 ------------------------------------------------------------------------------------------------------------------------
BEGIN
 SELECT NVL(SUM(DECODE(vvalue, '', 0, vvalue)), 0)
   INTO gn_customer_id
   FROM parameter
  WHERE npid = 12;
END; -- Package Body UTIL_PG
/

-- End of DDL script for UTIL_PG
