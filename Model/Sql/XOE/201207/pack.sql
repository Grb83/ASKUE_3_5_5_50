-- Start of DDL Script for Package RYDA.EDITFEEDERS_PG
-- Generated 17.07.2012 10:12:49 from RYDA@test2

CREATE OR REPLACE 
PACKAGE editfeeders_pg IS
  -- пакет работы с точками
  -- дата создания 19/10/2001 (Сечин А.А.)
------------------------------------------------------------------------------------------------------------------------
  -- Процедура вставки (полное кол-во параметров)
 PROCEDURE ins_p (an_parent NUMBER,   --Родитель
                                   an_type NUMBER,   --Тип точки
                                                  av_name VARCHAR2,   --Название
                                                                   av_short_name VARCHAR2,   --Краткое название
                                                                                          an_er_position NUMBER, an_q1_position NUMBER, an_ed_position NUMBER,
 an_q3_position NUMBER, an_smart NUMBER,   --Интеллектуал
                                        an_q1234 NUMBER,   --Квадранты
                                                        an_canal NUMBER,   --Номер канала
                                                                        av_cellnum VARCHAR2,   --Номер ячейки
                                                                                            an_power NUMBER,   --Мощность перв кВ
                                                                                                            an_current1 NUMBER,   --Напряжение перв
                                                                                                                               an_current2 NUMBER,   --Напряжение вторич
 an_kc NUMBER,   --Коэфф
              an_tag NUMBER,   --Тег связи
                            av_info VARCHAR2,   --Доп информация
                                             an_power2 NUMBER,   --Мощность вторич кВ
                                                              an_metkc NUMBER,   --Коэф прошитый в счетчике
                                                                              an_abc NUMBER,   --Заземленная нейтраль
                                                                                            an_calcbill NUMBER,   --Верифицировать суточные
                                                                                                               an_calcmonths NUMBER,   --Верифицировать месячные
 an_inverted NUMBER,   --Инверсия
                    an_switch NUMBER,   --Признак обводника
                                     an_usd NUMBER,   --УСД
                                                   an_nblock NUMBER,   -- блокировка автоматического опроса
                                                                    an_dataabsence NUMBER, an_commctrl NUMBER, an_techctrl NUMBER, an_main NUMBER,   --nMainPoint - основная точка учёта (для дублирования)
 av_verifyparam VARCHAR2,   -- Параметры верификации
                         av_addparams VARCHAR2,   -- Дополнительные параметры
                                               av_importcode VARCHAR2,   -- Связной код импорта
                                                                      an_lockcorrecttime NUMBER,   -- блокировка коррекции времени
                                                                                                av_code VARCHAR2,   -- код точки
                                                                                                                 av_verifyday VARCHAR2,   -- Параметры верификации суточных
 an_classtn NUMBER,   --Класс тотности ТН
                   an_classtt NUMBER,   --Класс тотности ТТ
                                     an_timezonew NUMBER,   --Веменная зона зимой
                                                         an_timezones NUMBER,   --Веменная зона летом
                                                                             an_opposite NUMBER,   --id, информация о противоположной точке
                                                                                                an_norder NUMBER,   --порядок в дереве по умолчанию 0
                                                                                                an_nintegr NUMBER, --период интеграции
 an_mid OUT NUMBER   --Ид точки
 );

------------------------------------------------------------------------------------------------------------------------
    -- Процедура вставки АСКУЭ
 PROCEDURE ins_p_a (an_parent NUMBER,   --Родитель
                                     an_type NUMBER,   --Тип точки
                                                    av_name VARCHAR2,   --Название
                                                                     av_short_name VARCHAR2,   --Краткое название
                                                                                            an_er_position NUMBER, an_q1_position NUMBER, an_ed_position NUMBER,
 an_q3_position NUMBER, an_smart NUMBER,   --Интеллектуал
                                        an_q1234 NUMBER,   --Квадранты
                                                        av_cellnum VARCHAR2,   --Номер ячейки
                                                                            an_power NUMBER,   --Мощность
                                                                                            an_current1 NUMBER,   --Напряжение перв
                                                                                                               an_current2 NUMBER,   --Напряжение вторич
                                                                                                                                  an_kc NUMBER,   --Коэфф
 an_point NUMBER,   --Ид точки АСРПП
                 an_power2 NUMBER,   --Мощность вторич кВ
                 an_ptype NUMBER,
                an_order NUMBER,
                                  an_mid OUT NUMBER   --Ид точки
 );

------------------------------------------------------------------------------------------------------------------------
 PROCEDURE upd_p_b(an_mid NUMBER,an_test NUMBER   --Ид точки
 );
------------------------------------------------------------------------------------------------------------------------
  -- Процедура обновления данных АСКУЭ
 PROCEDURE upd_p_a (an_mid NUMBER,   --Ид точки
                                  an_parent NUMBER,   --Родитель
                                                   an_type NUMBER,   --Тип точки
                                                                  av_name VARCHAR2,   --Название
                                                                                   av_short_name VARCHAR2,   --Краткое название
                                                                                                          an_er_position NUMBER, an_q1_position NUMBER,
 an_ed_position NUMBER, an_q3_position NUMBER, an_smart NUMBER,   --Интеллектуал
                                                               an_q1234 NUMBER,   --Квадранты
                                                                               av_cellnum VARCHAR2,   --Номер ячейки
                                                                                                   an_power NUMBER,   --Мощность
                                                                                                                   an_current1 NUMBER,   --Напряжение перв
 an_current2 NUMBER,   --Напряжение вторич
                    an_kc NUMBER,   --Коэфф
                                 an_power2 NUMBER   --Мощность вторич кВ
 --  an_metkc       NUMBER --Коэф прошитый в счетчике
 );

------------------------------------------------------------------------------------------------------------------------
  -- Процедура вставки при синхронизации
 PROCEDURE ins_p_synchro (an_parent NUMBER,   --Родитель
                                           an_type NUMBER,   --Тип точки
                                                          av_name VARCHAR2,   --Название
                                                                           av_short_name VARCHAR2,   --Краткое название
                                                                                                  an_smart NUMBER,   --Интеллектуал
                                                                                                                  an_q1234 NUMBER,   --Квадранты
                                                                                                                                  av_cellnum VARCHAR2,   --Номер ячейки
 an_power NUMBER,   --Мощность
                 an_current1 NUMBER,   --Напряжение перв
                                    an_current2 NUMBER,   --Напряжение вторич
                                                       an_kc NUMBER,   --Коэфф
                                                                    an_root NUMBER,   --Ид точки в родительской БД
                                                                                   an_power2 NUMBER,   --Мощность вторич кВ
                                                                                                    an_mid OUT NUMBER   --Ид точки
 );

------------------------------------------------------------------------------------------------------------------------
  -- Процедура удаления данных
 PROCEDURE del_p (an_mid NUMBER   --Ид точки
                               );

------------------------------------------------------------------------------------------------------------------------
--Процедура обновления счетчика АСКУЭ
 PROCEDURE upd_meters_a (an_mid NUMBER,   --Ид точки
                                       an_entype NUMBER,   --ENTYPE
                                                        av_smart VARCHAR2,   --SMART
                                                                          av_mtrsn VARCHAR2,   --MTRSN
                                                                                            ad_date_time DATE,   --DATE_TIME
                                                                                                              an_digits NUMBER,   --DIGITS
                                                                                                                               av_mtype VARCHAR2,   --MTYPE
 an_mcurrent NUMBER,   --MCURRENT
                    an_mpower NUMBER,   --MPOWER
                                     an_mconst NUMBER,   --MCONST
                                                      an_mclass NUMBER,   --MCLASS
                                                                       an_myear NUMBER,   --MYEAR
                                                                                       an_mquarter NUMBER   --MQUARTER
 );

------------------------------------------------------------------------------------------------------------------------
 FUNCTION insgroup (an_mid NUMBER)
  RETURN NUMBER;

------------------------------------------------------------------------------------------------------------------------
--Устанавливает параметры простых потерь
 PROCEDURE setaddparam (an_mid NUMBER,   --Ид точки
                                      an_wastepercentcalc NUMBER,   --Тип потерь
                                                                 an_workinghours NUMBER,   --Часы работы
                                                                                        an_fullhours NUMBER,   --Полные часы работы
                                                                                                            an_line_loss NUMBER,   --Портери в линии
 an_act_loss NUMBER,   --Потери акт транс
                    an_react_loss NUMBER,   --Потери реакт транс
                                         an_recompens NUMBER,   --Тип расчета реактива
                                                             an_calcpointtype NUMBER DEFAULT NULL,   -- Тип расчетной точки
 an_gid NUMBER DEFAULT NULL   --ид расчет группы
 );

------------------------------------------------------------------------------------------------------------------------
     -- Нормативные параметры точки
 PROCEDURE setcalcparam_p (an_mid NUMBER,   --Ид точки
                                         at_date common_pg.tt_number,   --Дата ввода в действие
                                                                     at_currpower common_pg.tt_number,   --Мощность
                                                                                                      at_monthconsumpt common_pg.tt_number,   --Месяч расход
 at_kc common_pg.tt_number   --Коэф пересчета
 );

------------------------------------------------------------------------------------------------------------------------
  -- Процедура обновления данных (с полным набором параметров)
 PROCEDURE upd_p (an_mid NUMBER,   --Ид точки
                                an_parent NUMBER,   --Родитель
                                                 an_type NUMBER,   --Тип точки
                                                                av_name VARCHAR2,   --Название
                                                                                 av_short_name VARCHAR2,   --Краткое название
                                                                                                        an_er_position NUMBER, an_q1_position NUMBER,
 an_ed_position NUMBER, an_q3_position NUMBER, an_smart NUMBER,   --Интеллектуал
                                                               an_q1234 NUMBER,   --Квадранты
                                                                               an_canal NUMBER,   --Номер канала
                                                                                               av_cellnum VARCHAR2,   --Номер ячейки
                                                                                                                   an_power NUMBER,   --Мощность
                                                                                                                                   an_current1 NUMBER,   --Напряжение перв
 an_current2 NUMBER,   --Напряжение вторич
                    an_kc NUMBER,   --Коэфф
                                 an_tag NUMBER,   --Тег связи
                                               av_info VARCHAR2,   --Доп информация
                                                                an_power2 NUMBER,   --Мощность вторич кВ
                                                                                 an_metkc NUMBER,   --Коэф прошитый в счетчике
                                                                                                 an_abc NUMBER,   --Заземленная нейтраль
                                                                                                               an_calcbill NUMBER,   --Верифицировать суточные
 an_calcmonths NUMBER,   --Верифицировать месячные
                      an_inverted NUMBER,   --Инверсия
                                         an_switch NUMBER,   --Признак обводника
                                                          an_usd NUMBER,   --УСД
                                                                        an_nblock NUMBER,   --Блокировка авт. опроса
                                                                                         an_dataabsence NUMBER, an_commctrl NUMBER, an_techctrl NUMBER,
 an_main NUMBER,   --nMainPoint - основная точка учёта (для дублирования)
                av_verifyparam VARCHAR2,   -- Параметры верификации
                                        av_addparams VARCHAR2,   -- Дополнительные параметры
                                                              av_importcode VARCHAR2,   -- Связной код импорта
                                                                                     an_lockcorrecttime NUMBER,   -- блокировка коррекции времени
                                                                                                               av_code VARCHAR2,   -- код точки
                                                                                                                                av_verifyday VARCHAR2,   -- Параметры верификации суточных
 an_classtn NUMBER,   --Класс тотности ТН
                   an_classtt NUMBER,   --Класс тотности ТТ
                                     an_timezonew NUMBER,   --Веменная зона зимой
                                                         an_timezones NUMBER,   --Веменная зона летом
                                                                             an_opposite NUMBER,   --id, информация о противоположной точке
 an_norder NUMBER,   --порядок в дереве по умолчанию 0
 an_nintegr NUMBER, --период интеграции
 an_lockswitch NUMBER --не переходит на ОВ
 );

------------------------------------------------------------------------------------------------------------------------
 -- Процедура обновления данных (с неполным набором параметров)
 PROCEDURE upd_p (an_mid NUMBER,   --Ид точки
                                av_importcode VARCHAR2,   -- Связной код импорта
                                                       an_canal NUMBER,   --Номер канала
                                                                       an_tag NUMBER,   --Тег связи
                                                                                     an_er_position NUMBER, an_q1_position NUMBER, an_ed_position NUMBER,
 an_q3_position NUMBER, av_info VARCHAR2,   --Доп информация
                                         an_nblock NUMBER,   --Блокировка авт. опроса
                                                          an_dataabsence NUMBER, an_commctrl NUMBER, an_techctrl NUMBER, an_lockcorrecttime NUMBER,   -- блокировка коррекции времени
 an_timezonew NUMBER,   --Временная зона зимой
                     an_timezones NUMBER   --Временная зона летом
 );   -- 16 параметра

---------------------------------------------------------------------------------------------------------------------
--Процедура обновления параметров
 PROCEDURE upd_last_save (an_mid NUMBER,   --Ид точки
                                        ad_profile DATE,   -- Дата постедней считанного профиля
                                                        ad_halfhour DATE,   -- Дата постедней считанного получасовки
                                                                         ad_bill DATE,   -- Дата постедней считанного суточного показания
 ad_month DATE   -- Дата постедней считанного месячного показания
 );

------------------------------------------------------------------------------------------------------------------------
  --Процедура добавления пустой строки в last_save
 PROCEDURE ins_last_save (an_mid NUMBER,   --Ид точки
                                        av_state VARCHAR2 DEFAULT NULL, an_state_cod NUMBER DEFAULT 0, an_clock NUMBER DEFAULT 0);

------------------------------------------------------------------------------------------------------------------------
   -- Пересчитывает расход по показаниям счетчика и ГН
 PROCEDURE recalcdiff (an_mid NUMBER, ad_from DATE);   --расход

------------------------------------------------------------------------------------------------------------------------
 --Процедура удаления данных из БД
 PROCEDURE delete_data (an_mid NUMBER,   --Ид точки
                                      ad_profile DATE,   -- Дата > которой удаляются данные профиля
                                                ad_halfhour DATE,   -- Дата > которой удаляются данные ГН
                                                           ad_bill DATE,   -- Дата > которой удаляются данные Суточных
                                                                  ad_month DATE,   --  Дата > которой удаляются месячные Суточных                                                                          
 ad_profile_e DATE DEFAULT NULL,   -- Дата <= которой удаляются данные профиля
             ad_halfhour_e DATE DEFAULT NULL,   -- Дата <= которой удаляются данные ГН
                          ad_bill_e DATE DEFAULT NULL,   -- Дата <= которой удаляются данные Суточных
                                   ad_month_e DATE DEFAULT NULL,   --  Дата <= которой удаляются месячные Суточных
 ad_journal DATE DEFAULT NULL,   -- Дата > которой удаляются данные Журнала
           ad_journal_e DATE DEFAULT NULL,   -- Дата <= которой удаляются данные Журнала
                       ad_currpower DATE DEFAULT NULL,   --  Дата > которой удаляются мгновенные данные                                                            
                                   ad_currpower_e DATE DEFAULT NULL,   --  Дата <= которой удаляются мгновенные данные
 an_withreload NUMBER DEFAULT 1   --Признак сдвига LAST_SAVE
 );

------------------------------------------------------------------------------------------------------------------------
--ищем точку (an_mid - точка старта)
 FUNCTION findpoint (an_mid NUMBER, av_name VARCHAR2, av_code VARCHAR2, av_mtrsn VARCHAR2, av_pmid VARCHAR2 DEFAULT NULL,an_pointtype NUMBER DEFAULT NULL, av_canal VARCHAR2 DEFAULT NULL)
  RETURN NUMBER;
------------------------------------------------------------------------------------------------------------------------
PROCEDURE RECOMPENS_p(acur_t OUT common_pg.tcur);
------------------------------------------------------------------------------------------------------------------------
PROCEDURE CALCPOINTTYPE_p(acur_t OUT common_pg.tcur);
-----------------------------------------------------------------------------------------------------------------------
PROCEDURE NACCPERIOD_p(an_mid NUMBER,acur_t OUT common_pg.tcur);
-----------------------------------------------------------------------------------------------------------------------
PROCEDURE CONNECTACCPERIOD_p(an_mid NUMBER,acur_t OUT common_pg.tcur);
----------------------------------------------------------------------------------------------------------------------
PROCEDURE nperiod_p(an_mid NUMBER,acur_t OUT common_pg.tcur);
-----------------------------------------------------------------------------------------------------------------------
--дерево точек
PROCEDURE ReadNode_p(an_mid NUMBER,an_parent NUMBER,acur_t OUT common_pg.tcur);
------------------------------------------------------------------------------------------------------------------------
--счетчики для точки
PROCEDURE ReadCounter_p(an_mid NUMBER,acur_t OUT common_pg.tcur);
----------------------------------------------------------------------------------------------------------------------
--потери для точки
PROCEDURE ReadLossts_p(an_mid NUMBER,acur_t OUT common_pg.tcur);
----------------------------------------------------------------------------------------------------------------------
--рассчетная группа для точки
PROCEDURE ReadGroup_p(an_mid NUMBER,acur_t OUT common_pg.tcur);
-----------------------------------------------------------------------------------------------------------------------
PROCEDURE SMART_p(an_mid NUMBER,av_sm OUT VARCHAR2);
-----------------------------------------------------------------------------------------------------------------------
PROCEDURE get_SubMenu_p(an_fid NUMBER,an_monitor NUMBER,an_gid NUMBER,acur_t OUT common_pg.tcur);
-----------------------------------------------------------------------------------------------------------------------
PROCEDURE NMAINPOINT_p(an_mid NUMBER,acur_t OUT common_pg.tcur);
-----------------------------------------------------------------------------------------------------------------------
PROCEDURE NOPPOSITE_p(an_mid NUMBER,acur_t OUT common_pg.tcur);
-----------------------------------------------------------------------------------------------------------------------
--возвращает измерения и их глобальные индексы для конкретной точки
--Виленская Н.Б. 14.11.2008
PROCEDURE get_Measure(an_mid NUMBER,an_objtype NUMBER,acur_t OUT common_pg.tcur);
-----------------------------------------------------------------------------------------------------------------------
--сохраняет измерения и их глобальные индексы для конкретной точки
--Виленская Н.Б. 14.11.2008
PROCEDURE ins_Guid(an_mid NUMBER,an_nmeasure common_pg.tt_number, an_mrid common_pg.tt_varchar2);

-----------------------------------------------------------------------------------------------------------
FUNCTION FormulaMeas_p(an_mid NUMBER)
RETURN VARCHAR2;
------------------------------------------------------------------------------------------------- 
 -- added by KAG 27.01.2010
 -- список базовых периодов интеграции
 PROCEDURE IntegratorTimes_p (acur_t OUT common_pg.tcur);
--------------------------------------------------------------------------------------------------------------
END;   -- Package Specification EDITFEEDERS_PG
/


-- End of DDL Script for Package RYDA.EDITFEEDERS_PG

-- Start of DDL Script for Package RYDA.COMSRV_PG
-- Generated 17.07.2012 10:13:01 from RYDA@test2

CREATE OR REPLACE 
PACKAGE comsrv_pg IS
------------------------------------------------------------------------------------------------------------------------
   -- Интерфейс взаимодействия БД с Носиком А.В.
   -- дата создания 30/11/2001 Сечин А.А.
------------------------------------------------------------------------------------------------------------------------
 cn_auto           CONSTANT NUMBER := 10;
------------------------------------------------------------------------------------------------------------------------
 cn_sl_7000        CONSTANT NUMBER := 1;
 cn_uspd_64        CONSTANT NUMBER := 2;
 cn_lg_zxd         CONSTANT NUMBER := 3;
 cn_argo           CONSTANT NUMBER := 4;
 cn_ea             CONSTANT NUMBER := 5;
 cn_energy9        CONSTANT NUMBER := 6;
 cn_elvin          CONSTANT NUMBER := 7;
 cn_set_4          CONSTANT NUMBER := 8;
 cn_lzqm           CONSTANT NUMBER := 9;
 cn_ce_304         CONSTANT NUMBER := 10;
 cn_ce_6850        CONSTANT NUMBER := 11;
 cn_ce_303         CONSTANT NUMBER := 12;
 cn_lg_zxb         CONSTANT NUMBER := 14;
 cn_energysimple   CONSTANT NUMBER := 15;
 cn_maket          CONSTANT NUMBER := 16;
 cn_a1r            CONSTANT NUMBER := 17;
 cn_metkom         CONSTANT NUMBER := 18;
 cn_rtu            CONSTANT NUMBER := 19;
 cn_itek           CONSTANT NUMBER := 20;   --И дубль
 cn_oblik          CONSTANT NUMBER := 21;
 cn_mercury        CONSTANT NUMBER := 22;
 cn_calc           CONSTANT NUMBER := 23;
 cn_inet           CONSTANT NUMBER := 24;
 cn_ev2            CONSTANT NUMBER := 25;
 cn_iccp           CONSTANT NUMBER := 26;
 cn_uppd           CONSTANT NUMBER := 27;
 cn_oik            CONSTANT NUMBER := 28;   --ОИК ХАРТЭП
 cn_oikdonbas      CONSTANT NUMBER := 29;   --ОИК Донбас ЭС (Старый)
 cn_a1800          CONSTANT NUMBER := 30;
 cn_nik2303 CONSTANT NUMBER := 32;
 cn_mtx     CONSTANT NUMBER := 33;
 cn_rtr56   CONSTANT NUMBER := 34;
 

------------------------------------------------------------------------------------------------------------------------
--******************************          Общие процедуры      *******************************************************--
------------------------------------------------------------------------------------------------------------------------
   --Вставка суточных расходов (Єнергия меркурий облик и.т.д. только расход)
 PROCEDURE set_bill_eom (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, an_aer NUMBER, an_aed NUMBER,
 an_aq1 NUMBER, an_aq3 NUMBER, an_aq2 NUMBER, an_aq4 NUMBER, an_ber NUMBER, an_bed NUMBER, an_bq1 NUMBER, an_bq3 NUMBER, an_bq2 NUMBER, an_bq4 NUMBER,
 an_cer NUMBER, an_ced NUMBER, an_cq1 NUMBER, an_cq3 NUMBER, an_cq2 NUMBER, an_cq4 NUMBER, an_der NUMBER, an_ded NUMBER, an_dq1 NUMBER, an_dq3 NUMBER,
 an_dq2 NUMBER, an_dq4 NUMBER, av_mtrsn VARCHAR2, ad_date DATE, an_source NUMBER DEFAULT NULL
 );

------------------------------------------------------------------------------------------------------------------------
 PROCEDURE signal (an_signal NUMBER);

------------------------------------------------------------------------------------------------------------------------
--Возвращает признак необходимость коррекции времени и допустимый диапазон (Если an_cid>0, то проверяет канал, an_mid>0, то проверяет точку)
 PROCEDURE get_timeinfo (an_cid NUMBER, an_mid NUMBER, an_min_delta OUT NUMBER, an_max_delta OUT NUMBER, an_clock_set OUT NUMBER);

------------------------------------------------------------------------------------------------------------------------
--Возвращает информацию по программироваению времени счетчика (часовые пояса)
 PROCEDURE get_wstimeinfo(an_mid NUMBER, an_timezonew OUT NUMBER, an_timezones OUT NUMBER);
------------------------------------------------------------------------------------------------------------------------
 PROCEDURE set_traffic (an_cid NUMBER, ad_open DATE, ad_start DATE, ad_end DATE, an_send NUMBER, an_recv NUMBER, av_user VARCHAR2);

------------------------------------------------------------------------------------------------------------------------

 --Сверка номера счетчика (Если возвращает не 0 то отваливаем и переходим к другому счетчику)
 FUNCTION check_mtrsn (an_mid NUMBER, av_mtrsn VARCHAR2)
  RETURN NUMBER;

------------------------------------------------------------------------------------------------------------------------
 --Вставка текущих
 PROCEDURE set_curr_power_meter (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, ad_date DATE);

------------------------------------------------------------------------------------------------------------------------
 --Вставка текущих (+ ток в нуле)
 PROCEDURE set_curr_power_meter (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_freq NUMBER,
 an_cos_fi NUMBER, an_volt1 NUMBER, an_volt2 NUMBER, an_volt3 NUMBER, an_curr1 NUMBER, an_curr2 NUMBER, an_curr3 NUMBER, an_fii1 NUMBER, an_fii2 NUMBER,
 an_fii3 NUMBER, an_fiu1 NUMBER, an_fiu2 NUMBER, an_fiu3 NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, an_i0 NUMBER,
 an_type NUMBER, ad_date DATE
 );

 --Вставка текущих
 PROCEDURE set_curr_power_meter (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_freq NUMBER,
 an_cos_fi NUMBER, an_volt1 NUMBER, an_volt2 NUMBER, an_volt3 NUMBER, an_curr1 NUMBER, an_curr2 NUMBER, an_curr3 NUMBER, an_fii1 NUMBER, an_fii2 NUMBER,
 an_fii3 NUMBER, an_fiu1 NUMBER, an_fiu2 NUMBER, an_fiu3 NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, an_type NUMBER,
 ad_date DATE
 );

-----------------------------------------------------------------------------------------------------------------------
 --Вставка параметров качества
 PROCEDURE set_curr_quality_meter (an_mid NUMBER, an_voltvar NUMBER, an_voltchanmod NUMBER, an_flickersev NUMBER, an_thd NUMBER, an_nharmkoef NUMBER,
 an_obrunbkoef NUMBER, an_zerunbkoef NUMBER, an_powfreq NUMBER, an_voltdiptime NUMBER, an_tempvoltkoef NUMBER, an_quickchan NUMBER, an_unbalvolt NUMBER,
 an_voltinterharm NUMBER, an_voltdip NUMBER, an_shortinterrupt NUMBER, an_longinterrupt NUMBER, an_tempovervolt NUMBER, an_transovervolt NUMBER, ad_date DATE
 );

-----------------------------------------------------------------------------------------------------------------------
  --Вставка суточных для счетчиков
 PROCEDURE set_bill_meter (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_aerm NUMBER, an_aedm NUMBER,
 an_aq1m NUMBER, an_aq3m NUMBER, an_aq2m NUMBER, an_aq4m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_bq2m NUMBER, an_bq4m NUMBER,
 an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_cq2m NUMBER, an_cq4m NUMBER, an_derm NUMBER, an_dedm NUMBER, an_dq1m NUMBER, an_dq3m NUMBER,
 an_dq2m NUMBER, an_dq4m NUMBER, av_mtrsn VARCHAR2, an_digits NUMBER, ad_date DATE
 );

------------------------------------------------------------------------------------------------------------------------
  --Вставка месячных для счетчиков
 PROCEDURE set_months_meter (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_aerm NUMBER,
 an_aedm NUMBER, an_aq1m NUMBER, an_aq3m NUMBER, an_aq2m NUMBER, an_aq4m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_bq2m NUMBER,
 an_bq4m NUMBER, an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_cq2m NUMBER, an_cq4m NUMBER, an_derm NUMBER, an_dedm NUMBER, an_dq1m NUMBER,
 an_dq3m NUMBER, an_dq2m NUMBER, an_dq4m NUMBER, av_mtrsn VARCHAR2, an_digits NUMBER, ad_date DATE
 );

------------------------------------------------------------------------------------------------------------------------
 PROCEDURE set_halfhour_meter (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, an_status NUMBER,
 an_metertype NUMBER, av_qm VARCHAR2, ad_date DATE, an_period NUMBER DEFAULT NULL
 );

 PROCEDURE set_halfhour_meter (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, an_erm NUMBER, an_edm NUMBER,
 an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_status NUMBER, an_metertype NUMBER, av_qm VARCHAR2, ad_date DATE, an_period NUMBER DEFAULT NULL
 );

-----------------------------------------------------------------------------------------------------------------------
--******************************          УСПД КМ-64           *******************************************************--
------------------------------------------------------------------------------------------------------------------------
   --Вставка суточных
 PROCEDURE set_bill_uspd (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_aerm NUMBER, an_aedm NUMBER,
 an_aq1m NUMBER, an_aq3m NUMBER, an_aq2m NUMBER, an_aq4m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_bq2m NUMBER, an_bq4m NUMBER,
 an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_cq2m NUMBER, an_cq4m NUMBER, an_derm NUMBER, an_dedm NUMBER, an_dq1m NUMBER, an_dq3m NUMBER,
 an_dq2m NUMBER, an_dq4m NUMBER, av_mtrsn VARCHAR2, an_digits NUMBER,   --Значность счетчика, необходимо передать соответствующую АРГО
                                                                        --( для A1R было 6 - A1R_ParamCalc.DPLocE )
                                                                     ad_date DATE
 );

------------------------------------------------------------------------------------------------------------------------
  --Вставка месячных
 PROCEDURE set_months_uspd (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_aerm NUMBER, an_aedm NUMBER,
 an_aq1m NUMBER, an_aq3m NUMBER, an_aq2m NUMBER, an_aq4m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_bq2m NUMBER, an_bq4m NUMBER,
 an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_cq2m NUMBER, an_cq4m NUMBER, an_derm NUMBER, an_dedm NUMBER, an_dq1m NUMBER, an_dq3m NUMBER,
 an_dq2m NUMBER, an_dq4m NUMBER, av_mtrsn VARCHAR2, an_digits NUMBER,   --Значность счетчика, необходимо передать соответствующую АРГО
                                                                        --( для A1R 6 - A1R_ParamCalc.DPLocE )
                                                                     ad_date DATE
 );

------------------------------------------------------------------------------------------------------------------------
 --Вставка графика нагрузки
 PROCEDURE set_halfhour_uspd (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, ad_date DATE);

------------------------------------------------------------------------------------------------------------------------
--******************************          Itek 210             *******************************************************--
------------------------------------------------------------------------------------------------------------------------
--Вставка коэффициентов
 PROCEDURE set_coeffic_itek (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER);

------------------------------------------------------------------------------------------------------------------------
--Вставка 3-х минуток
 PROCEDURE set_profile_itek (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, ad_date DATE);

------------------------------------------------------------------------------------------------------------------------
 --Вставка графика нагрузки
 PROCEDURE set_halfhour_itek (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, ad_date DATE);

------------------------------------------------------------------------------------------------------------------------
 --Вставка суточных
 PROCEDURE set_bill_itek (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_zone NUMBER,   --1-A, 2-B, 3-C,4-D. иначе общий
                                                                                                                ad_date DATE);

------------------------------------------------------------------------------------------------------------------------
 --Вставка месячных
 PROCEDURE set_months_itek (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_zone NUMBER,   --1-A, 2-B, 3-C,4-D. иначе общий
                                                                                                                  ad_date DATE);

------------------------------------------------------------------------------------------------------------------------
--******************************          L                  *******************************************************--
------------------------------------------------------------------------------------------------------------------------
 --Статус LG
 PROCEDURE mark_lgstatus (newmid NUMBER, newdate_time DATE, newt NUMBER, newu NUMBER, news NUMBER, newm NUMBER, newkt NUMBER, newl1 IN OUT NUMBER,
 newl2 IN OUT NUMBER, newl3 IN OUT NUMBER
 );

------------------------------------------------------------------------------------------------------------------------
 PROCEDURE mark_lgstatus_d (an_mid NUMBER, ad_date_time DATE, an_st NUMBER, an_lp NUMBER, an_ev NUMBER, an_uo NUMBER, an_u NUMBER, an_t NUMBER, an_kt NUMBER,
 an_s NUMBER, an_ip NUMBER, an_bt NUMBER, an_fe NUMBER
 );

------------------------------------------------------------------------------------------------------------------------
-- Журнал событий ZxD
 PROCEDURE mark_zxd_event (an_mid NUMBER, ad_date DATE, an_event_hi NUMBER, an_found OUT NUMBER, av_state VARCHAR2, av_error VARCHAR2);

------------------------------------------------------------------------------------------------------------------------
 --Вставка текущих ZxB
 PROCEDURE set_curr_power_zxb (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, ad_date DATE);

 --Вставка текущих ZxB (+ ток в нуле)
 PROCEDURE set_curr_power_zxb (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_freq NUMBER,
 an_cos_fi NUMBER, an_volt1 NUMBER, an_volt2 NUMBER, an_volt3 NUMBER, an_curr1 NUMBER, an_curr2 NUMBER, an_curr3 NUMBER, an_fiu1i1 NUMBER, an_fiu2i2 NUMBER,
 an_fiu3i3 NUMBER, an_fiu1 NUMBER, an_fiu2 NUMBER, an_fiu3 NUMBER, an_i0 NUMBER, ad_date DATE
 );

 --Вставка текущих ZxB
 PROCEDURE set_curr_power_zxb (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_freq NUMBER,
 an_cos_fi NUMBER, an_volt1 NUMBER, an_volt2 NUMBER, an_volt3 NUMBER, an_curr1 NUMBER, an_curr2 NUMBER, an_curr3 NUMBER, an_fiu1i1 NUMBER, an_fiu2i2 NUMBER,
 an_fiu3i3 NUMBER, an_fiu1 NUMBER, an_fiu2 NUMBER, an_fiu3 NUMBER, ad_date DATE
 );

 --Вставка текущих ZxB с квадрантами (+ ток в нуле)
 PROCEDURE set_curr_power_zxb (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_rrm NUMBER, an_rdm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER,
 an_q4m NUMBER, an_freq NUMBER, an_cos_fi NUMBER, an_volt1 NUMBER, an_volt2 NUMBER, an_volt3 NUMBER, an_curr1 NUMBER, an_curr2 NUMBER, an_curr3 NUMBER,
 an_fiu1i1 NUMBER, an_fiu2i2 NUMBER, an_fiu3i3 NUMBER, an_fiu1 NUMBER, an_fiu2 NUMBER, an_fiu3 NUMBER, an_i0 NUMBER, ad_date DATE
 );

 --Вставка текущих ZxB с квадрантами
 PROCEDURE set_curr_power_zxb (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_rrm NUMBER, an_rdm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER,
 an_q4m NUMBER, an_freq NUMBER, an_cos_fi NUMBER, an_volt1 NUMBER, an_volt2 NUMBER, an_volt3 NUMBER, an_curr1 NUMBER, an_curr2 NUMBER, an_curr3 NUMBER,
 an_fiu1i1 NUMBER, an_fiu2i2 NUMBER, an_fiu3i3 NUMBER, an_fiu1 NUMBER, an_fiu2 NUMBER, an_fiu3 NUMBER, ad_date DATE
 );

------------------------------------------------------------------------------------------------------------------------
  --Вставка текущих ZxD (+ ток в нуле)
 PROCEDURE set_curr_power_zxd (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_rrm NUMBER, an_rdm NUMBER, an_q1m NUMBER, an_q2m NUMBER, an_q3m NUMBER,
 an_q4m NUMBER, an_freq NUMBER, an_cos_fi NUMBER, an_volt1 NUMBER, an_volt2 NUMBER, an_volt3 NUMBER, an_curr1 NUMBER, an_curr2 NUMBER, an_curr3 NUMBER,
 an_fiu1i1 NUMBER, an_fiu2i2 NUMBER, an_fiu3i3 NUMBER, an_fiu1u2 NUMBER, an_fiu1u3 NUMBER, an_fiu2u3 NUMBER, an_er NUMBER, an_ed NUMBER, an_rr NUMBER, an_rd NUMBER,
 an_q1 NUMBER, an_q2 NUMBER, an_q3 NUMBER, an_q4 NUMBER, an_i0 NUMBER, ad_date DATE
 );

 --Вставка текущих ZxD
 PROCEDURE set_curr_power_zxd (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_rrm NUMBER, an_rdm NUMBER, an_q1m NUMBER, an_q2m NUMBER, an_q3m NUMBER,
 an_q4m NUMBER, an_freq NUMBER, an_cos_fi NUMBER, an_volt1 NUMBER, an_volt2 NUMBER, an_volt3 NUMBER, an_curr1 NUMBER, an_curr2 NUMBER, an_curr3 NUMBER,
 an_fiu1i1 NUMBER, an_fiu2i2 NUMBER, an_fiu3i3 NUMBER, an_fiu1u2 NUMBER, an_fiu1u3 NUMBER, an_fiu2u3 NUMBER, an_er NUMBER, an_ed NUMBER, an_rr NUMBER, an_rd NUMBER,
 an_q1 NUMBER, an_q2 NUMBER, an_q3 NUMBER, an_q4 NUMBER, ad_date DATE
 );

------------------------------------------------------------------------------------------------------------------------
 --Вставка графика нагрузки
 PROCEDURE set_halfhour_zxb (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_status NUMBER, ad_date DATE);

------------------------------------------------------------------------------------------------------------------------
 --Вставка графика нагрузки (По показаниям)
 PROCEDURE set_halfhour_zxb (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER,
 av_mtrsn VARCHAR2, an_digits NUMBER, an_status NUMBER, ad_date DATE, an_source NUMBER DEFAULT NULL
 );

------------------------------------------------------------------------------------------------------------------------
 --Вставка графика нагрузки по индукционникам
 PROCEDURE set_halfhour_zxb_induc (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, av_mtrsn VARCHAR2, an_digits NUMBER, ad_date DATE);

------------------------------------------------------------------------------------------------------------------------
 PROCEDURE set_halfhour_fag_induc (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, av_mtrsn VARCHAR2, an_digits NUMBER, ad_date DATE);

------------------------------------------------------------------------------------------------------------------------
 --Вставка листинга показаний
 PROCEDURE set_readout_zxb (an_mid NUMBER, at_data common_pg.tt_varchar2);

------------------------------------------------------------------------------------------------------------------------
 --Вставка листинга графика нагрузки
 PROCEDURE set_loadprof_zxb (an_mid NUMBER, at_data common_pg.tt_varchar2);

------------------------------------------------------------------------------------------------------------------------
 --Вставка суточных
 PROCEDURE set_bill_zxb (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_aerm NUMBER, an_aedm NUMBER, an_aq1m NUMBER, an_aq3m NUMBER,
 an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_derm NUMBER, an_dedm NUMBER,
 an_dq1m NUMBER, an_dq3m NUMBER, av_mtrsn VARCHAR2, an_digits NUMBER,   --Значность счетчика
                                                                     ad_date DATE
 );

------------------------------------------------------------------------------------------------------------------------
 --Вставка месячных
 PROCEDURE set_months_zxb (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_aerm NUMBER, an_aedm NUMBER, an_aq1m NUMBER,
 an_aq3m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_derm NUMBER,
 an_dedm NUMBER, an_dq1m NUMBER, an_dq3m NUMBER, av_mtrsn VARCHAR2, an_digits NUMBER,   --Значность счетчика
                                                                                     ad_date DATE
 );

------------------------------------------------------------------------------------------------------------------------
--Расширенный с квадрантами
------------------------------------------------------------------------------------------------------------------------
 --Вставка суточных
 PROCEDURE set_bill_zxb (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_rrm NUMBER, an_rdm NUMBER, an_aerm NUMBER, an_aedm NUMBER, an_arrm NUMBER, an_ardm NUMBER,
 an_berm NUMBER, an_bedm NUMBER, an_brrm NUMBER, an_brdm NUMBER, an_cerm NUMBER, an_cedm NUMBER, an_crrm NUMBER, an_crdm NUMBER, an_derm NUMBER, an_dedm NUMBER,
 an_drrm NUMBER, an_drdm NUMBER, an_q1m NUMBER, an_q2m NUMBER, an_q3m NUMBER, an_q4m NUMBER, an_aq1m NUMBER, an_aq2m NUMBER, an_aq3m NUMBER, an_aq4m NUMBER,
 an_bq1m NUMBER, an_bq2m NUMBER, an_bq3m NUMBER, an_bq4m NUMBER, an_cq1m NUMBER, an_cq2m NUMBER, an_cq3m NUMBER, an_cq4m NUMBER, an_dq1m NUMBER, an_dq2m NUMBER,
 an_dq3m NUMBER, an_dq4m NUMBER, av_mtrsn VARCHAR2, an_digits NUMBER,   --Значность счетчика
                                                                     ad_date DATE
 );

------------------------------------------------------------------------------------------------------------------------
 --Вставка месячных
 PROCEDURE set_months_zxb (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_rrm NUMBER, an_rdm NUMBER, an_aerm NUMBER, an_aedm NUMBER, an_arrm NUMBER,
 an_ardm NUMBER, an_berm NUMBER, an_bedm NUMBER, an_brrm NUMBER, an_brdm NUMBER, an_cerm NUMBER, an_cedm NUMBER, an_crrm NUMBER, an_crdm NUMBER, an_derm NUMBER,
 an_dedm NUMBER, an_drrm NUMBER, an_drdm NUMBER, an_q1m NUMBER, an_q2m NUMBER, an_q3m NUMBER, an_q4m NUMBER, an_aq1m NUMBER, an_aq2m NUMBER, an_aq3m NUMBER,
 an_aq4m NUMBER, an_bq1m NUMBER, an_bq2m NUMBER, an_bq3m NUMBER, an_bq4m NUMBER, an_cq1m NUMBER, an_cq2m NUMBER, an_cq3m NUMBER, an_cq4m NUMBER, an_dq1m NUMBER,
 an_dq2m NUMBER, an_dq3m NUMBER, an_dq4m NUMBER, av_mtrsn VARCHAR2, an_digits NUMBER,   --Значность счетчика
                                                                                     ad_date DATE
 );

------------------------------------------------------------------------------------------------------------------------
--******************************          A1R                  *******************************************************--
------------------------------------------------------------------------------------------------------------------------
 --Вставка текущих
 PROCEDURE set_curr_power_a1r (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, ad_date DATE);

-----------------------------------------------------------------------------------------------------------------------
 --Вставка графика нагрузки
 PROCEDURE set_halfhour_a1r (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, ad_date DATE);

-----------------------------------------------------------------------------------------------------------------------
  --Вставка суточных
 PROCEDURE set_bill_a1r (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_aerm NUMBER, an_aedm NUMBER,
 an_aq1m NUMBER, an_aq3m NUMBER, an_aq2m NUMBER, an_aq4m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_bq2m NUMBER, an_bq4m NUMBER,
 an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_cq2m NUMBER, an_cq4m NUMBER, an_derm NUMBER, an_dedm NUMBER, an_dq1m NUMBER, an_dq3m NUMBER,
 an_dq2m NUMBER, an_dq4m NUMBER, av_mtrsn VARCHAR2, an_digits NUMBER,   --Значность счетчика, необходимо передать 6 - A1R_ParamCalc.DPLocE
                                                                     ad_date DATE
 );

-----------------------------------------------------------------------------------------------------------------------
  --Вставка месячных
 PROCEDURE set_months_a1r (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_aerm NUMBER, an_aedm NUMBER,
 an_aq1m NUMBER, an_aq3m NUMBER, an_aq2m NUMBER, an_aq4m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_bq2m NUMBER, an_bq4m NUMBER,
 an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_cq2m NUMBER, an_cq4m NUMBER, an_derm NUMBER, an_dedm NUMBER, an_dq1m NUMBER, an_dq3m NUMBER,
 an_dq2m NUMBER, an_dq4m NUMBER, av_mtrsn VARCHAR2, an_digits NUMBER,   --Значность счетчика, необходимо передать 6 - A1R_ParamCalc.DPLocE
                                                                     ad_date DATE
 );

------------------------------------------------------------------------------------------------------------------------
--******************************          Alpha                *******************************************************--
------------------------------------------------------------------------------------------------------------------------
 --Вставка текущих
 PROCEDURE set_curr_power_alpha (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_rrm NUMBER, an_rdm NUMBER, an_q1m NUMBER, an_q2m NUMBER, an_q3m NUMBER,
 an_q4m NUMBER, ad_date DATE
 );

-----------------------------------------------------------------------------------------------------------------------
  --Вставка параметров сети
 PROCEDURE set_net_param_alpha (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_volt1 NUMBER, an_volt2 NUMBER, an_volt3 NUMBER,
 an_curr1 NUMBER, an_curr2 NUMBER, an_curr3 NUMBER, an_fiu1 NUMBER, an_fiu2 NUMBER, an_fiu3 NUMBER, an_fii1 NUMBER, an_fii2 NUMBER, an_fii3 NUMBER,
 an_cos_fi NUMBER, ad_date DATE
 );

-----------------------------------------------------------------------------------------------------------------------
 --Вставка графика нагрузки
 PROCEDURE set_halfhour_alpha (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, ad_date DATE, an_period NUMBER DEFAULT 30);

-----------------------------------------------------------------------------------------------------------------------
 --Вставка графика нагрузки
 PROCEDURE set_halfhour_alpha (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, ad_date DATE,
 an_period NUMBER DEFAULT 30
 );

-----------------------------------------------------------------------------------------------------------------------
  --Вставка суточных
 PROCEDURE set_bill_alpha (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_rrm NUMBER, an_rdm NUMBER, an_aerm NUMBER, an_aedm NUMBER, an_aq1m NUMBER,
 an_aq3m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_derm NUMBER,
 an_dedm NUMBER, an_dq1m NUMBER, an_dq3m NUMBER, an_q1m NUMBER, an_q2m NUMBER, an_q3m NUMBER, an_q4m NUMBER, av_mtrsn VARCHAR2, an_digits NUMBER,   --Значность счетчика, необходимо передать 6 - Alpha_ParamCalc.DPLocE
 ad_date DATE
 );

-----------------------------------------------------------------------------------------------------------------------
  --Вставка месячных
 PROCEDURE set_months_alpha (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_rrm NUMBER, an_rdm NUMBER, an_aerm NUMBER, an_aedm NUMBER, an_aq1m NUMBER,
 an_aq3m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_derm NUMBER,
 an_dedm NUMBER, an_dq1m NUMBER, an_dq3m NUMBER, an_q1m NUMBER, an_q2m NUMBER, an_q3m NUMBER, an_q4m NUMBER, av_mtrsn VARCHAR2, an_digits NUMBER,   --Значность счетчика, необходимо передать 6 - Alpha_ParamCalc.DPLocE
 ad_date DATE
 );

------------------------------------------------------------------------------------------------------------------------
 PROCEDURE mark_a1140event (newmid NUMBER, newev_date DATE, newtype NUMBER, FOUND OUT NUMBER);

------------------------------------------------------------------------------------------------------------------------
 PROCEDURE mark_eaevent (newmid NUMBER, newev_date DATE, newtype NUMBER, FOUND OUT NUMBER);

------------------------------------------------------------------------------------------------------------------------
 --******************************          Metkom              *******************************************************--
 ------------------------------------------------------------------------------------------------------------------------
  --Вставка графика нагрузки
 PROCEDURE set_halfhour_metcom (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, ad_date DATE);

------------------------------------------------------------------------------------------------------------------------
  --Вставка трафика обмена с  Fag12
 PROCEDURE set_traffic_fag12 (an_mid NUMBER, at_data common_pg.tt_varchar2);

------------------------------------------------------------------------------------------------------------------------
  --Процедура проверки доступности коррекции времени УСД Fag-12
 FUNCTION get_acc_time_correct_fag12 (an_cid NUMBER   -- Ид канала (возврат 1-Можно, 0- нельзя)
                                                   )
  RETURN NUMBER;

 PRAGMA RESTRICT_REFERENCES (get_acc_time_correct_fag12, WNDS, WNPS);

------------------------------------------------------------------------------------------------------------------------
 --Установка состояния и величины расхождения системного таймера Fag-12
 PROCEDURE set_time_info_fag12 (an_cid NUMBER,   -- Ид канала
                                              an_state NUMBER,   -- Состояние (0 -Расхождение в норме, 1-Расхождение в пределах коррекции (требуется коррекция),2-Рассхождение привысило верхнюю величину)
 an_value NUMBER   --Величина рассхождения в секундах
 );

------------------------------------------------------------------------------------------------------------------------
--******************************          RTU                 *******************************************************--
------------------------------------------------------------------------------------------------------------------------
 --Вставка графика нагрузки
 PROCEDURE set_halfhour_rtu (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, ad_date DATE);

-----------------------------------------------------------------------------------------------------------------------
   --Вставка суточных расходов и показаний
 PROCEDURE set_bill_rtu (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, an_erm NUMBER, an_edm NUMBER,
 an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, ad_date DATE
 );

------------------------------------------------------------------------------------------------------------------------
--******************************          SCHLUM               *******************************************************--
------------------------------------------------------------------------------------------------------------------------
 --Вставка текущих (+ ток в нуле)
 PROCEDURE set_curr_power_schlum (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_freq NUMBER,
 an_cos_fi NUMBER, an_volt1 NUMBER, an_volt2 NUMBER, an_volt3 NUMBER, an_curr1 NUMBER, an_curr2 NUMBER, an_curr3 NUMBER, an_fiu1i1 NUMBER, an_fiu2i2 NUMBER,
 an_fiu3i3 NUMBER, an_fiu1u2 NUMBER, an_fiu1u3 NUMBER, an_fiu2u3 NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER,
 an_i0 NUMBER, ad_date DATE
 );

 --Вставка текущих
 PROCEDURE set_curr_power_schlum (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_freq NUMBER,
 an_cos_fi NUMBER, an_volt1 NUMBER, an_volt2 NUMBER, an_volt3 NUMBER, an_curr1 NUMBER, an_curr2 NUMBER, an_curr3 NUMBER, an_fiu1i1 NUMBER, an_fiu2i2 NUMBER,
 an_fiu3i3 NUMBER, an_fiu1u2 NUMBER, an_fiu1u3 NUMBER, an_fiu2u3 NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER,
 ad_date DATE
 );

-----------------------------------------------------------------------------------------------------------------------
 --Вставка графика нагрузки
 PROCEDURE set_halfhour_schlum (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, ad_date DATE,
 an_period NUMBER DEFAULT 30, an_status NUMBER DEFAULT 0
 );

-----------------------------------------------------------------------------------------------------------------------
  --Вставка суточных
 PROCEDURE set_bill_schlum (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_aerm NUMBER, an_aedm NUMBER,
 an_aq1m NUMBER, an_aq3m NUMBER, an_aq2m NUMBER, an_aq4m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_bq2m NUMBER, an_bq4m NUMBER,
 an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_cq2m NUMBER, an_cq4m NUMBER, an_derm NUMBER, an_dedm NUMBER, an_dq1m NUMBER, an_dq3m NUMBER,
 an_dq2m NUMBER, an_dq4m NUMBER, av_mtrsn VARCHAR2, an_digits NUMBER,   --Значность счетчика, необходимо передать 6 - A1R_ParamCalc.DPLocE
                                                                     ad_date DATE
 );

-----------------------------------------------------------------------------------------------------------------------
  --Вставка месячных
 PROCEDURE set_months_schlum (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_aerm NUMBER,
 an_aedm NUMBER, an_aq1m NUMBER, an_aq3m NUMBER, an_aq2m NUMBER, an_aq4m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_bq2m NUMBER,
 an_bq4m NUMBER, an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_cq2m NUMBER, an_cq4m NUMBER, an_derm NUMBER, an_dedm NUMBER, an_dq1m NUMBER,
 an_dq3m NUMBER, an_dq2m NUMBER, an_dq4m NUMBER, av_mtrsn VARCHAR2, an_digits NUMBER,   --Значность счетчика, необходимо передать 6 - A1R_ParamCalc.DPLocE
 ad_date DATE
 );

------------------------------------------------------------------------------------------------------------------------
 PROCEDURE mark_status_schlum (an_mid NUMBER, at_date_time common_pg.tt_varchar2, at_event_hi common_pg.tt_number, at_event_lo common_pg.tt_number);

------------------------------------------------------------------------------------------------------------------------
--Вставка графика нагрузки по индукционникам
 PROCEDURE set_halfhour_sl_induc (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, ad_date DATE,
 an_period NUMBER DEFAULT 30
 );

------------------------------------------------------------------------------------------------------------------------
  --******************************          Energy              *******************************************************--
  ------------------------------------------------------------------------------------------------------------------------
  --Вставка текущих
 PROCEDURE set_curr_power_energy (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_freq NUMBER, an_cos_fi NUMBER, an_volt1 NUMBER,
 an_curr1 NUMBER, an_volt2 NUMBER, an_volt3 NUMBER, an_curr2 NUMBER, an_curr3 NUMBER, ad_date DATE
 );

-----------------------------------------------------------------------------------------------------------------------
 --Вставка показаний счетчика
 PROCEDURE set_total_energy (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q2 NUMBER, an_q3 NUMBER, an_q4 NUMBER);

-----------------------------------------------------------------------------------------------------------------------
 --Журнал событий
 PROCEDURE mark_energyevent (newmid NUMBER, newev_date DATE, newtype NUMBER, FOUND OUT NUMBER, newl1 NUMBER, newl2 NUMBER, newl3 NUMBER);

-----------------------------------------------------------------------------------------------------------------------
 --Вставка графика нагрузки
 PROCEDURE set_halfhour_energy (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, ad_date DATE);

-----------------------------------------------------------------------------------------------------------------------
  --Вставка графика нагрузки (для упращенной енергии)
 PROCEDURE set_halfhour_energy_simple (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, av_mtrsn VARCHAR2,
 an_status NUMBER, ad_date DATE, an_step NUMBER DEFAULT 1 / 48
 );

-----------------------------------------------------------------------------------------------------------------------
  --Вставка суточных расходов
 PROCEDURE set_bill_energy (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, an_aer NUMBER, an_aed NUMBER,
 an_aq1 NUMBER, an_aq3 NUMBER, an_aq2 NUMBER, an_aq4 NUMBER, an_ber NUMBER, an_bed NUMBER, an_bq1 NUMBER, an_bq3 NUMBER, an_bq2 NUMBER, an_bq4 NUMBER,
 an_cer NUMBER, an_ced NUMBER, an_cq1 NUMBER, an_cq3 NUMBER, an_cq2 NUMBER, an_cq4 NUMBER, an_der NUMBER, an_ded NUMBER, an_dq1 NUMBER, an_dq3 NUMBER,
 an_dq2 NUMBER, an_dq4 NUMBER, ad_date DATE
 );

------------------------------------------------------------------------------------------------------------------------
   --Вставка суточных показаний
 PROCEDURE set_bill_energy_m (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_aerm NUMBER,
 an_aedm NUMBER, an_aq1m NUMBER, an_aq3m NUMBER, an_aq2m NUMBER, an_aq4m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_bq2m NUMBER,
 an_bq4m NUMBER, an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_cq2m NUMBER, an_cq4m NUMBER, an_derm NUMBER, an_dedm NUMBER, an_dq1m NUMBER,
 an_dq3m NUMBER, an_dq2m NUMBER, an_dq4m NUMBER, ad_date DATE
 );

------------------------------------------------------------------------------------------------------------------------
   --Вставка месячных расходов
 PROCEDURE set_months_energy (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, an_aer NUMBER, an_aed NUMBER,
 an_aq1 NUMBER, an_aq3 NUMBER, an_aq2 NUMBER, an_aq4 NUMBER, an_ber NUMBER, an_bed NUMBER, an_bq1 NUMBER, an_bq3 NUMBER, an_bq2 NUMBER, an_bq4 NUMBER,
 an_cer NUMBER, an_ced NUMBER, an_cq1 NUMBER, an_cq3 NUMBER, an_cq2 NUMBER, an_cq4 NUMBER, an_der NUMBER, an_ded NUMBER, an_dq1 NUMBER, an_dq3 NUMBER,
 an_dq2 NUMBER, an_dq4 NUMBER, ad_date DATE
 );

------------------------------------------------------------------------------------------------------------------------
  --Вставка месячных показаний
 PROCEDURE set_months_energy_m (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_aerm NUMBER,
 an_aedm NUMBER, an_aq1m NUMBER, an_aq3m NUMBER, an_aq2m NUMBER, an_aq4m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_bq2m NUMBER,
 an_bq4m NUMBER, an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_cq2m NUMBER, an_cq4m NUMBER, an_derm NUMBER, an_dedm NUMBER, an_dq1m NUMBER,
 an_dq3m NUMBER, an_dq2m NUMBER, an_dq4m NUMBER, ad_date DATE
 );

------------------------------------------------------------------------------------------------------------------------
 --******************************          Oblik              *******************************************************--
 ------------------------------------------------------------------------------------------------------------------------
 --Вставка текущих
 PROCEDURE set_curr_power_oblik (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_freq NUMBER, an_cos_fi NUMBER, an_volt1 NUMBER,
 an_curr1 NUMBER, an_volt2 NUMBER, an_volt3 NUMBER, an_curr2 NUMBER, an_curr3 NUMBER, ad_date DATE
 );

-----------------------------------------------------------------------------------------------------------------------
 --Вставка показаний счетчика
 PROCEDURE set_total_oblik (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER);

-----------------------------------------------------------------------------------------------------------------------
 --Вставка минутного профиля
 PROCEDURE set_profile_oblik (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, ad_date DATE);

------------------------------------------------------------------------------------------------------------------------
 --Вставка минутного профиля по индукционникам
 PROCEDURE set_profile_oblik_induc (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, ad_date DATE);

-----------------------------------------------------------------------------------------------------------------------
 --Вставка графика нагрузки
 PROCEDURE set_halfhour_oblik (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, ad_date DATE);

------------------------------------------------------------------------------------------------------------------------
 --Вставка графика нагрузки по индукционникам
 PROCEDURE set_halfhour_oblik_induc (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, ad_date DATE);

-----------------------------------------------------------------------------------------------------------------------
  --Вставка суточных расходов
 PROCEDURE set_bill_oblik (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, an_aer NUMBER, an_aed NUMBER,
 an_aq1 NUMBER, an_aq3 NUMBER, an_aq2 NUMBER, an_aq4 NUMBER, an_ber NUMBER, an_bed NUMBER, an_bq1 NUMBER, an_bq3 NUMBER, an_bq2 NUMBER, an_bq4 NUMBER,
 an_cer NUMBER, an_ced NUMBER, an_cq1 NUMBER, an_cq3 NUMBER, an_cq2 NUMBER, an_cq4 NUMBER, an_der NUMBER, an_ded NUMBER, an_dq1 NUMBER, an_dq3 NUMBER,
 an_dq2 NUMBER, an_dq4 NUMBER, ad_date DATE
 );

-----------------------------------------------------------------------------------------------------------------------
  --Вставка суточных расходов по индукционникам
 PROCEDURE set_bill_oblik_induc (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, an_aer NUMBER, an_aed NUMBER,
 an_aq1 NUMBER, an_aq3 NUMBER, an_aq2 NUMBER, an_aq4 NUMBER, an_ber NUMBER, an_bed NUMBER, an_bq1 NUMBER, an_bq3 NUMBER, an_bq2 NUMBER, an_bq4 NUMBER,
 an_cer NUMBER, an_ced NUMBER, an_cq1 NUMBER, an_cq3 NUMBER, an_cq2 NUMBER, an_cq4 NUMBER, an_der NUMBER, an_ded NUMBER, an_dq1 NUMBER, an_dq3 NUMBER,
 an_dq2 NUMBER, an_dq4 NUMBER, ad_date DATE
 );

------------------------------------------------------------------------------------------------------------------------
   --Вставка суточных показаний
 PROCEDURE set_bill_oblik_m (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_aerm NUMBER,
 an_aedm NUMBER, an_aq1m NUMBER, an_aq3m NUMBER, an_aq2m NUMBER, an_aq4m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_bq2m NUMBER,
 an_bq4m NUMBER, an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_cq2m NUMBER, an_cq4m NUMBER, an_derm NUMBER, an_dedm NUMBER, an_dq1m NUMBER,
 an_dq3m NUMBER, an_dq2m NUMBER, an_dq4m NUMBER, ad_date DATE
 );

------------------------------------------------------------------------------------------------------------------------
   --Вставка суточных показаний по индукционникам
 PROCEDURE set_bill_oblik_m_induc (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_aerm NUMBER,
 an_aedm NUMBER, an_aq1m NUMBER, an_aq3m NUMBER, an_aq2m NUMBER, an_aq4m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_bq2m NUMBER,
 an_bq4m NUMBER, an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_cq2m NUMBER, an_cq4m NUMBER, an_derm NUMBER, an_dedm NUMBER, an_dq1m NUMBER,
 an_dq3m NUMBER, an_dq2m NUMBER, an_dq4m NUMBER, ad_date DATE
 );

------------------------------------------------------------------------------------------------------------------------
   --Вставка месячных расходов
 PROCEDURE set_months_oblik (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, an_aer NUMBER, an_aed NUMBER,
 an_aq1 NUMBER, an_aq3 NUMBER, an_aq2 NUMBER, an_aq4 NUMBER, an_ber NUMBER, an_bed NUMBER, an_bq1 NUMBER, an_bq3 NUMBER, an_bq2 NUMBER, an_bq4 NUMBER,
 an_cer NUMBER, an_ced NUMBER, an_cq1 NUMBER, an_cq3 NUMBER, an_cq2 NUMBER, an_cq4 NUMBER, an_der NUMBER, an_ded NUMBER, an_dq1 NUMBER, an_dq3 NUMBER,
 an_dq2 NUMBER, an_dq4 NUMBER, ad_date DATE
 );

------------------------------------------------------------------------------------------------------------------------
   --Вставка месячных расходов по индукционникам
 PROCEDURE set_months_oblik_induc (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, an_aer NUMBER, an_aed NUMBER,
 an_aq1 NUMBER, an_aq3 NUMBER, an_aq2 NUMBER, an_aq4 NUMBER, an_ber NUMBER, an_bed NUMBER, an_bq1 NUMBER, an_bq3 NUMBER, an_bq2 NUMBER, an_bq4 NUMBER,
 an_cer NUMBER, an_ced NUMBER, an_cq1 NUMBER, an_cq3 NUMBER, an_cq2 NUMBER, an_cq4 NUMBER, an_der NUMBER, an_ded NUMBER, an_dq1 NUMBER, an_dq3 NUMBER,
 an_dq2 NUMBER, an_dq4 NUMBER, ad_date DATE
 );

------------------------------------------------------------------------------------------------------------------------
  --Вставка месячных показаний
 PROCEDURE set_months_oblik_m (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_aerm NUMBER,
 an_aedm NUMBER, an_aq1m NUMBER, an_aq3m NUMBER, an_aq2m NUMBER, an_aq4m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_bq2m NUMBER,
 an_bq4m NUMBER, an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_cq2m NUMBER, an_cq4m NUMBER, an_derm NUMBER, an_dedm NUMBER, an_dq1m NUMBER,
 an_dq3m NUMBER, an_dq2m NUMBER, an_dq4m NUMBER, ad_date DATE
 );

------------------------------------------------------------------------------------------------------------------------
  --Вставка месячных показаний по индукционникам
 PROCEDURE set_months_oblik_m_induc (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_aerm NUMBER,
 an_aedm NUMBER, an_aq1m NUMBER, an_aq3m NUMBER, an_aq2m NUMBER, an_aq4m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_bq2m NUMBER,
 an_bq4m NUMBER, an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_cq2m NUMBER, an_cq4m NUMBER, an_derm NUMBER, an_dedm NUMBER, an_dq1m NUMBER,
 an_dq3m NUMBER, an_dq2m NUMBER, an_dq4m NUMBER, ad_date DATE
 );

------------------------------------------------------------------------------------------------------------------------
--Выдача ТУ
 FUNCTION put_tu_oblik (an_mid NUMBER, an_clamp NUMBER DEFAULT 0)
  RETURN NUMBER;

------------------------------------------------------------------------------------------------------------------------
--******************************          АРГО             *******************************************************--
------------------------------------------------------------------------------------------------------------------------
 --Вставка текущих
 PROCEDURE set_curr_power_argo (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_freq NUMBER,
 an_cos_fi NUMBER, an_volt1 NUMBER, an_volt2 NUMBER, an_volt3 NUMBER, an_curr1 NUMBER, an_curr2 NUMBER, an_curr3 NUMBER, an_fiu1i1 NUMBER, an_fiu2i2 NUMBER,
 an_fiu3i3 NUMBER, an_fiu1u2 NUMBER, an_fiu1u3 NUMBER, an_fiu2u3 NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER,
 ad_date DATE
 );

-----------------------------------------------------------------------------------------------------------------------
 --Вставка графика нагрузки
 PROCEDURE set_halfhour_argo (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, ad_date DATE);

------------------------------------------------------------------------------------------------------------------------
  --Вставка суточных
 PROCEDURE set_bill_argo (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_aerm NUMBER, an_aedm NUMBER,
 an_aq1m NUMBER, an_aq3m NUMBER, an_aq2m NUMBER, an_aq4m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_bq2m NUMBER, an_bq4m NUMBER,
 an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_cq2m NUMBER, an_cq4m NUMBER, an_derm NUMBER, an_dedm NUMBER, an_dq1m NUMBER, an_dq3m NUMBER,
 an_dq2m NUMBER, an_dq4m NUMBER, av_mtrsn VARCHAR2, an_digits NUMBER, ad_date DATE
 );

------------------------------------------------------------------------------------------------------------------------
  --Вставка месячных
 PROCEDURE set_months_argo (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_aerm NUMBER, an_aedm NUMBER,
 an_aq1m NUMBER, an_aq3m NUMBER, an_aq2m NUMBER, an_aq4m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_bq2m NUMBER, an_bq4m NUMBER,
 an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_cq2m NUMBER, an_cq4m NUMBER, an_derm NUMBER, an_dedm NUMBER, an_dq1m NUMBER, an_dq3m NUMBER,
 an_dq2m NUMBER, an_dq4m NUMBER, av_mtrsn VARCHAR2, an_digits NUMBER,   --Значность счетчика, необходимо передать соответствующую АРГО
                                                                        --( для A1R 6 - A1R_ParamCalc.DPLocE )
                                                                     ad_date DATE
 );

------------------------------------------------------------------------------------------------------------------------
  --Вставка событий
 PROCEDURE mark_status_argo (an_mid NUMBER, at_date_time common_pg.tt_varchar2, at_event_hi common_pg.tt_number, at_event_lo common_pg.tt_number);

------------------------------------------------------------------------------------------------------------------------
--******************************          Меркурий             *******************************************************--
-----------------------------------------------------------------------------------------------------------------------
 --Вставка показаний счетчика
 PROCEDURE set_total_mercury (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER);

------------------------------------------------------------------------------------------------------------------------
--Вставка текущих
 PROCEDURE set_curr_power_mercury (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_freq NUMBER, an_cos_fi NUMBER, an_volt1 NUMBER,
 an_curr1 NUMBER, an_volt2 NUMBER, an_volt3 NUMBER, an_curr2 NUMBER, an_curr3 NUMBER, an_fiu1u2 NUMBER, an_fiu1u3 NUMBER, an_fiu2u3 NUMBER, ad_date DATE
 );

------------------------------------------------------------------------------------------------------------------------
  --Вставка суточных расходов
 PROCEDURE set_bill_mercury (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, an_aer NUMBER, an_aed NUMBER,
 an_aq1 NUMBER, an_aq3 NUMBER, an_aq2 NUMBER, an_aq4 NUMBER, an_ber NUMBER, an_bed NUMBER, an_bq1 NUMBER, an_bq3 NUMBER, an_bq2 NUMBER, an_bq4 NUMBER,
 an_cer NUMBER, an_ced NUMBER, an_cq1 NUMBER, an_cq3 NUMBER, an_cq2 NUMBER, an_cq4 NUMBER, an_der NUMBER, an_ded NUMBER, an_dq1 NUMBER, an_dq3 NUMBER,
 an_dq2 NUMBER, an_dq4 NUMBER, av_mtrsn VARCHAR2, ad_date DATE
 );

------------------------------------------------------------------------------------------------------------------------
   --Вставка суточных показаний
 PROCEDURE set_bill_mercury_m (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_aerm NUMBER,
 an_aedm NUMBER, an_aq1m NUMBER, an_aq3m NUMBER, an_aq2m NUMBER, an_aq4m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_bq2m NUMBER,
 an_bq4m NUMBER, an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_cq2m NUMBER, an_cq4m NUMBER, an_derm NUMBER, an_dedm NUMBER, an_dq1m NUMBER,
 an_dq3m NUMBER, an_dq2m NUMBER, an_dq4m NUMBER, ad_date DATE
 );

------------------------------------------------------------------------------------------------------------------------
   --Вставка месячных расходов
 PROCEDURE set_months_mercury (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, an_aer NUMBER, an_aed NUMBER,
 an_aq1 NUMBER, an_aq3 NUMBER, an_aq2 NUMBER, an_aq4 NUMBER, an_ber NUMBER, an_bed NUMBER, an_bq1 NUMBER, an_bq3 NUMBER, an_bq2 NUMBER, an_bq4 NUMBER,
 an_cer NUMBER, an_ced NUMBER, an_cq1 NUMBER, an_cq3 NUMBER, an_cq2 NUMBER, an_cq4 NUMBER, an_der NUMBER, an_ded NUMBER, an_dq1 NUMBER, an_dq3 NUMBER,
 an_dq2 NUMBER, an_dq4 NUMBER, av_mtrsn VARCHAR2, ad_date DATE
 );

------------------------------------------------------------------------------------------------------------------------
  --Вставка месячных показаний
 PROCEDURE set_months_mercury_m (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_aerm NUMBER,
 an_aedm NUMBER, an_aq1m NUMBER, an_aq3m NUMBER, an_aq2m NUMBER, an_aq4m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_bq2m NUMBER,
 an_bq4m NUMBER, an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_cq2m NUMBER, an_cq4m NUMBER, an_derm NUMBER, an_dedm NUMBER, an_dq1m NUMBER,
 an_dq3m NUMBER, an_dq2m NUMBER, an_dq4m NUMBER, ad_date DATE
 );

------------------------------------------------------------------------------------------------------------------------
 --Вставка графика нагрузки
 PROCEDURE set_halfhour_mercury (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, ad_date DATE);

------------------------------------------------------------------------------------------------------------------------
--******************************          LZQM             *******************************************************--
-----------------------------------------------------------------------------------------------------------------------
 --Вставка показаний счетчика
 PROCEDURE set_total_lzqm (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER);

-----------------------------------------------------------------------------------------------------------------------
 PROCEDURE set_curr_power_lzqm (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_freq NUMBER, an_cos_fi NUMBER, an_volt1 NUMBER,
 an_curr1 NUMBER, an_volt2 NUMBER, an_volt3 NUMBER, an_curr2 NUMBER, an_curr3 NUMBER, an_fiu1u2 NUMBER, an_fiu1u3 NUMBER, an_fiu2u3 NUMBER, ad_date DATE
 );

-----------------------------------------------------------------------------------------------------------------------
 PROCEDURE set_halfhour_lzqm (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, ad_date DATE);

-----------------------------------------------------------------------------------------------------------------------
 PROCEDURE set_bill_lzqm (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, an_aer NUMBER, an_aed NUMBER,
 an_aq1 NUMBER, an_aq3 NUMBER, an_aq2 NUMBER, an_aq4 NUMBER, an_ber NUMBER, an_bed NUMBER, an_bq1 NUMBER, an_bq3 NUMBER, an_bq2 NUMBER, an_bq4 NUMBER,
 an_cer NUMBER, an_ced NUMBER, an_cq1 NUMBER, an_cq3 NUMBER, an_cq2 NUMBER, an_cq4 NUMBER, an_der NUMBER, an_ded NUMBER, an_dq1 NUMBER, an_dq3 NUMBER,
 an_dq2 NUMBER, an_dq4 NUMBER, av_mtrsn VARCHAR2, ad_date DATE
 );

-----------------------------------------------------------------------------------------------------------------------
 PROCEDURE set_bill_lzqm_m (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_aerm NUMBER, an_aedm NUMBER,
 an_aq1m NUMBER, an_aq3m NUMBER, an_aq2m NUMBER, an_aq4m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_bq2m NUMBER, an_bq4m NUMBER,
 an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_cq2m NUMBER, an_cq4m NUMBER, an_derm NUMBER, an_dedm NUMBER, an_dq1m NUMBER, an_dq3m NUMBER,
 an_dq2m NUMBER, an_dq4m NUMBER, ad_date DATE
 );

-----------------------------------------------------------------------------------------------------------------------
 PROCEDURE set_months_lzqm (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, an_aer NUMBER, an_aed NUMBER,
 an_aq1 NUMBER, an_aq3 NUMBER, an_aq2 NUMBER, an_aq4 NUMBER, an_ber NUMBER, an_bed NUMBER, an_bq1 NUMBER, an_bq3 NUMBER, an_bq2 NUMBER, an_bq4 NUMBER,
 an_cer NUMBER, an_ced NUMBER, an_cq1 NUMBER, an_cq3 NUMBER, an_cq2 NUMBER, an_cq4 NUMBER, an_der NUMBER, an_ded NUMBER, an_dq1 NUMBER, an_dq3 NUMBER,
 an_dq2 NUMBER, an_dq4 NUMBER, av_mtrsn VARCHAR2, ad_date DATE
 );

-----------------------------------------------------------------------------------------------------------------------
 PROCEDURE set_months_lzqm_m (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_aerm NUMBER,
 an_aedm NUMBER, an_aq1m NUMBER, an_aq3m NUMBER, an_aq2m NUMBER, an_aq4m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_bq2m NUMBER,
 an_bq4m NUMBER, an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_cq2m NUMBER, an_cq4m NUMBER, an_derm NUMBER, an_dedm NUMBER, an_dq1m NUMBER,
 an_dq3m NUMBER, an_dq2m NUMBER, an_dq4m NUMBER, ad_date DATE
 );

-----------------------------------------------------------------------------------------------------------------------
 PROCEDURE mark_lzqmevent (newmid NUMBER, newev_date DATE, newtype NUMBER, FOUND OUT NUMBER, newstate NUMBER);

------------------------------------------------------------------------------------------------------------------------
--******************************          SET-4               *******************************************************--
------------------------------------------------------------------------------------------------------------------------
 --Вставка текущих
 PROCEDURE set_curr_power_set4 (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_freq NUMBER, an_cos_fi NUMBER, an_volt1 NUMBER,
 an_volt2 NUMBER, an_volt3 NUMBER, an_curr1 NUMBER, an_curr2 NUMBER, an_curr3 NUMBER, an_fiu1i1 NUMBER, an_fiu2i2 NUMBER, an_fiu3i3 NUMBER, an_er NUMBER,
 an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, ad_date DATE
 );

-----------------------------------------------------------------------------------------------------------------------
 --Вставка графика нагрузки
 PROCEDURE set_halfhour_set4 (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, ad_date DATE);

------------------------------------------------------------------------------------------------------------------------
  --Вставка суточных расходов
 PROCEDURE set_bill_set4 (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_aer NUMBER, an_aed NUMBER, an_aq1 NUMBER, an_aq3 NUMBER,
 an_ber NUMBER, an_bed NUMBER, an_bq1 NUMBER, an_bq3 NUMBER, an_cer NUMBER, an_ced NUMBER, an_cq1 NUMBER, an_cq3 NUMBER, an_der NUMBER, an_ded NUMBER,
 an_dq1 NUMBER, an_dq3 NUMBER, av_mtrsn VARCHAR2, ad_date DATE
 );

------------------------------------------------------------------------------------------------------------------------
   --Вставка суточных показаний
 PROCEDURE set_bill_set4_m (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_aerm NUMBER, an_aedm NUMBER, an_aq1m NUMBER,
 an_aq3m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_derm NUMBER,
 an_dedm NUMBER, an_dq1m NUMBER, an_dq3m NUMBER, ad_date DATE
 );

------------------------------------------------------------------------------------------------------------------------
   --Вставка месячных расходов
 PROCEDURE set_months_set4 (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_aer NUMBER, an_aed NUMBER, an_aq1 NUMBER, an_aq3 NUMBER,
 an_ber NUMBER, an_bed NUMBER, an_bq1 NUMBER, an_bq3 NUMBER, an_cer NUMBER, an_ced NUMBER, an_cq1 NUMBER, an_cq3 NUMBER, an_der NUMBER, an_ded NUMBER,
 an_dq1 NUMBER, an_dq3 NUMBER, av_mtrsn VARCHAR2, ad_date DATE
 );

------------------------------------------------------------------------------------------------------------------------
  --Вставка месячных показаний
 PROCEDURE set_months_set4_m (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_aerm NUMBER, an_aedm NUMBER, an_aq1m NUMBER,
 an_aq3m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_derm NUMBER,
 an_dedm NUMBER, an_dq1m NUMBER, an_dq3m NUMBER, ad_date DATE
 );

------------------------------------------------------------------------------------------------------------------------
-- Журнал событий SET4
 PROCEDURE mark_set4event (newmid NUMBER, newev_date DATE, newtype NUMBER, FOUND OUT NUMBER);

------------------------------------------------------------------------------------------------------------------------
--******************************          SEB-2A.07            *******************************************************--
------------------------------------------------------------------------------------------------------------------------
-- Журнал событий SEB-2A.07
 PROCEDURE mark_seb2a07event (newmid NUMBER, newev_date DATE, newtype NUMBER, FOUND OUT NUMBER);

------------------------------------------------------------------------------------------------------------------------
--**********************************          CE-304    CE-6850        ***********************************************--
------------------------------------------------------------------------------------------------------------------------
--Вставка текущих
 PROCEDURE set_curr_power_ce304 (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_freq NUMBER,
 an_cos_fi NUMBER, an_volt1 NUMBER, an_volt2 NUMBER, an_volt3 NUMBER, an_curr1 NUMBER, an_curr2 NUMBER, an_curr3 NUMBER, an_fiu1i1 NUMBER, an_fiu2i2 NUMBER,
 an_fiu3i3 NUMBER, an_fiu1u2 NUMBER, an_fiu1u3 NUMBER, an_fiu2u3 NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER,
 ad_date DATE
 );

-----------------------------------------------------------------------------------------------------------------------
 --Вставка графика нагрузки
 PROCEDURE set_halfhour_ce304 (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, an_status NUMBER, ad_date DATE);

------------------------------------------------------------------------------------------------------------------------
   --Вставка суточных показаний
 PROCEDURE set_bill_ce304_m (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_aerm NUMBER,
 an_aedm NUMBER, an_aq1m NUMBER, an_aq3m NUMBER, an_aq2m NUMBER, an_aq4m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_bq2m NUMBER,
 an_bq4m NUMBER, an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_cq2m NUMBER, an_cq4m NUMBER, an_derm NUMBER, an_dedm NUMBER, an_dq1m NUMBER,
 an_dq3m NUMBER, an_dq2m NUMBER, an_dq4m NUMBER, av_mtrsn VARCHAR2, ad_date DATE
 );

------------------------------------------------------------------------------------------------------------------------
   --Вставка месячных показаний
 PROCEDURE set_months_ce304_m (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_aerm NUMBER,
 an_aedm NUMBER, an_aq1m NUMBER, an_aq3m NUMBER, an_aq2m NUMBER, an_aq4m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_bq2m NUMBER,
 an_bq4m NUMBER, an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_cq2m NUMBER, an_cq4m NUMBER, an_derm NUMBER, an_dedm NUMBER, an_dq1m NUMBER,
 an_dq3m NUMBER, an_dq2m NUMBER, an_dq4m NUMBER, av_mtrsn VARCHAR2, ad_date DATE
 );

 ------------------------------------------------------------------------------------------------------------------------
-- журнал событий
 PROCEDURE mark_ce304event (newmid NUMBER, newev_date DATE, newtype NUMBER, FOUND OUT NUMBER, newstate NUMBER);

------------------------------------------------------------------------------------------------------------------------
 PROCEDURE mark_ce6850event (newmid NUMBER, newev_date DATE, newtype NUMBER, FOUND OUT NUMBER, newstate NUMBER);

------------------------------------------------------------------------------------------------------------------------
 PROCEDURE mark_ce303event (newmid NUMBER, newev_date DATE, newtype NUMBER, FOUND OUT NUMBER, newstate NUMBER);

------------------------------------------------------------------------------------------------------------------------
 PROCEDURE mark_elvinevent (newmid NUMBER, newev_date DATE, newtype NUMBER, FOUND OUT NUMBER);

------------------------------------------------------------------------------------------------------------------------
 --******************************          A1800             *******************************************************--
 ------------------------------------------------------------------------------------------------------------------------
 --Вставка текущих
 PROCEDURE set_curr_power_a1800 (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_freq NUMBER, an_cos_fi NUMBER, an_volt1 NUMBER,
 an_volt2 NUMBER, an_volt3 NUMBER, an_curr1 NUMBER, an_curr2 NUMBER, an_curr3 NUMBER, an_fiu1u2 NUMBER, an_fiu1u3 NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER,
 an_q3 NUMBER, ad_date DATE
 );

------------------------------------------------------------------------------------------------------------------------
 --Вставка графика нагрузки
 PROCEDURE set_halfhour_a1800 (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_status NUMBER, ad_date DATE);

------------------------------------------------------------------------------------------------------------------------
  --Вставка суточных
 PROCEDURE set_bill_a1800 (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_aerm NUMBER, an_aedm NUMBER, an_aq1m NUMBER,
 an_aq3m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_derm NUMBER,
 an_dedm NUMBER, an_dq1m NUMBER, an_dq3m NUMBER, av_mtrsn VARCHAR2, ad_date DATE
 );

------------------------------------------------------------------------------------------------------------------------
  --Вставка месячных
 PROCEDURE set_months_a1800 (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_aerm NUMBER, an_aedm NUMBER, an_aq1m NUMBER,
 an_aq3m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_derm NUMBER,
 an_dedm NUMBER, an_dq1m NUMBER, an_dq3m NUMBER, av_mtrsn VARCHAR2, ad_date DATE
 );

------------------------------------------------------------------------------------------------------------------------
 --Журнал событий
 PROCEDURE mark_a1800event (newmid NUMBER, newev_date DATE, newtype NUMBER, FOUND OUT NUMBER);

------------------------------------------------------------------------------------------------------------------------
 --******************************          EMS             *******************************************************--
 ------------------------------------------------------------------------------------------------------------------------

 --Вставка текущих
 PROCEDURE set_curr_power_ems (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, ad_date DATE);

------------------------------------------------------------------------------------------------------------------------
  --Вставка суточных
 PROCEDURE set_bill_ems (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_aerm NUMBER, an_aedm NUMBER, an_aq1m NUMBER, an_aq3m NUMBER,
 an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_derm NUMBER, an_dedm NUMBER,
 an_dq1m NUMBER, an_dq3m NUMBER, av_mtrsn VARCHAR2, ad_date DATE
 );

------------------------------------------------------------------------------------------------------------------------
   --Вставка месячных расходов
 PROCEDURE set_months_ems (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, an_aer NUMBER, an_aed NUMBER,
 an_aq1 NUMBER, an_aq3 NUMBER, an_aq2 NUMBER, an_aq4 NUMBER, an_ber NUMBER, an_bed NUMBER, an_bq1 NUMBER, an_bq3 NUMBER, an_bq2 NUMBER, an_bq4 NUMBER,
 an_cer NUMBER, an_ced NUMBER, an_cq1 NUMBER, an_cq3 NUMBER, an_cq2 NUMBER, an_cq4 NUMBER, an_der NUMBER, an_ded NUMBER, an_dq1 NUMBER, an_dq3 NUMBER,
 an_dq2 NUMBER, an_dq4 NUMBER, av_mtrsn VARCHAR2, ad_date DATE
 );

------------------------------------------------------------------------------------------------------------------------
  --Вставка месячных показаний
 PROCEDURE set_months_ems_m (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_aerm NUMBER,
 an_aedm NUMBER, an_aq1m NUMBER, an_aq3m NUMBER, an_aq2m NUMBER, an_aq4m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_bq2m NUMBER,
 an_bq4m NUMBER, an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_cq2m NUMBER, an_cq4m NUMBER, an_derm NUMBER, an_dedm NUMBER, an_dq1m NUMBER,
 an_dq3m NUMBER, an_dq2m NUMBER, an_dq4m NUMBER, ad_date DATE
 );

------------------------------------------------------------------------------------------------------------------------
 --******************************          DLL METER           *******************************************************--
------------------------------------------------------------------------------------------------------------------------

 --Вставка текущих
 PROCEDURE set_curr_power_dllmtr (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_freq NUMBER,
 an_cos_fi NUMBER, an_volt1 NUMBER, an_volt2 NUMBER, an_volt3 NUMBER, an_curr1 NUMBER, an_curr2 NUMBER, an_curr3 NUMBER, an_fiu1i1 NUMBER, an_fiu2i2 NUMBER,
 an_fiu3i3 NUMBER, an_fiu1u2 NUMBER, an_fiu1u3 NUMBER, an_fiu2u3 NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER,
 an_type NUMBER, ad_date DATE
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
 PROCEDURE set_parametrization_date (an_mid NUMBER, av_date VARCHAR2);   --Установка (сверка) даты параметризации av_date dd.mm.yyyy hh24:mi:ss
-----------------------------------------------------------------------------------------------------------------------
END;   -- Package Specification comsrv_pg
/


-- End of DDL Script for Package RYDA.COMSRV_PG

-- Start of DDL Script for Package RYDA.COMSRVMTX_PG
-- Generated 17.07.2012 10:13:23 from RYDA@test2

CREATE OR REPLACE 
PACKAGE comsrvmtx_pg IS
------------------------------------------------------------------------------------------------------------------------
   -- Интерфейс взаимодействия БД с драйвером МТХ
   -- дата создания 02/04/2012
------------------------------------------------------------------------------------------------------------------------
 FUNCTION connectnextmeter(
 an_mid NUMBER,                                                                               --Ид точки, начиная с которой необходимо получить следующую точку
               an_cid NUMBER,                                                                                                                       --Ид канала
                             an_retmid OUT NUMBER,                                                                                                   --Ид точки
                                                  ln_canal OUT NUMBER,                                                                        --Адресс счетчика
                                                                      lv_name OUT VARCHAR2,                                                      --Наименование
                                                                                           ln_kc OUT NUMBER,                                   --Расчетный коэф
                                                                                                            ln_tag OUT NUMBER,                      --Тег связи
 lv_info OUT VARCHAR2                                                                                                                          --Доп информация
 )
  RETURN NUMBER;

------------------------------------------------------------------------------------------------------------------------
 PROCEDURE set_curr_power(
 an_mid NUMBER, an_erm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_freq NUMBER, an_temp NUMBER, an_volt1 NUMBER, an_volt2 NUMBER, an_volt3 NUMBER,
 an_curr1 NUMBER, an_curr2 NUMBER, an_curr3 NUMBER,an_cosf NUMBER,  ad_date DATE
 );

-----------------------------------------------------------------------------------------------------------------------
 PROCEDURE set_halfhour(an_mid NUMBER, an_er NUMBER, ad_date DATE);

-----------------------------------------------------------------------------------------------------------------------
 PROCEDURE set_bill(
 an_mid NUMBER, an_er NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_aer NUMBER, an_aq1 NUMBER, an_aq3 NUMBER, an_ber NUMBER, an_bq1 NUMBER, an_bq3 NUMBER,
 an_cer NUMBER, an_cq1 NUMBER, an_cq3 NUMBER, an_der NUMBER, an_dq1 NUMBER, an_dq3 NUMBER, av_mtrsn VARCHAR2, ad_date DATE
 );

-----------------------------------------------------------------------------------------------------------------------
 PROCEDURE set_months(
 an_mid NUMBER, an_er NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_aer NUMBER, an_aq1 NUMBER, an_aq3 NUMBER, an_ber NUMBER, an_bq1 NUMBER, an_bq3 NUMBER,
 an_cer NUMBER, an_cq1 NUMBER, an_cq3 NUMBER, an_der NUMBER, an_dq1 NUMBER, an_dq3 NUMBER, av_mtrsn VARCHAR2, ad_date DATE
 );

-----------------------------------------------------------------------------------------------------------------------
 --Запись журнала (an_type - тип счетчика 3-3-х фазник  1-однофазник, иначе 3-х фазник)
 PROCEDURE set_journal(an_mid NUMBER, an_event common_pg.tt_number, av_date common_pg.tt_varchar2                              --в формате d.mm.yyyy hh24:mi:ss
                                                                                                 ,an_type NUMBER DEFAULT 3);

------------------------------------------------------------------------------------------------------------------------
 PROCEDURE set_state(
 an_mid NUMBER,                                                                                                                           --Ид точки или канала
               an_state_cod NUMBER,                                                                                                             --Код сообщения
                                   av_state_descr VARCHAR2,                                                                                   --Текст сообщения
                                                           an_clock NUMBER DEFAULT 0                                                        --Расхождение часов
 );

------------------------------------------------------------------------------------------------------------------------
END;                                                                                                                       -- Package Specification COMSRVMTX_PG
/


-- End of DDL Script for Package RYDA.COMSRVMTX_PG

-- Start of DDL Script for Package RYDA.COMSRVCIM_PG
-- Generated 17.07.2012 10:13:31 from RYDA@test2

CREATE OR REPLACE 
PACKAGE comsrvcim_pg IS
------------------------------------------------------------------------------------------------------------------------
   -- Интерфейс взаимодействия БД с Носиком А.В. для прямых select'ов в коде опросчика
   -- дата создания 11/06/2008
------------------------------------------------------------------------------------------------------------------------
--                                       TComServerThread
------------------------------------------------------------------------------------------------------------------------
 cn_info_len CONSTANT NUMBER := 47;
 cv_info_def CONSTANT VARCHAR2(128) := ' ';

------------------------------------------------------------------------------------------------------------------------
 FUNCTION connectnextmeter(
  an_mid              NUMBER,
  an_cid              NUMBER,
  ln_mid        OUT   NUMBER,
  ln_canal      OUT   NUMBER,
  ln_name       OUT   VARCHAR2,
  ln_kc         OUT   NUMBER,
  ln_tag        OUT   NUMBER,
  ln_vinfo      OUT   VARCHAR2,
  ln_nabc       OUT   NUMBER,
  ln_q1234      OUT   NUMBER,
  lv_info_def         VARCHAR2 DEFAULT cv_info_def,
  ln_info_len         NUMBER DEFAULT cn_info_len,
  ln_tag_def          NUMBER DEFAULT 0
 )
  RETURN NUMBER;

------------------------------------------------------------------------------------------------------------------------

 -- void __fastcall TComServerThread::ConnectNextPassiveDVS(void)
 FUNCTION get_passivedvs(
  an_cid                    NUMBER,
  ln_cid              OUT   NUMBER,
  ln_addr             OUT   NUMBER,
  ln_vname            OUT   VARCHAR2,
  ln_protocol_id      OUT   NUMBER,
  ln_init_str         OUT   VARCHAR2,
  ln_retries          OUT   NUMBER,
  ln_retries_tout     OUT   NUMBER,
  ln_is_block         OUT   NUMBER,
  ln_nbilldata        OUT   NUMBER,
  ln_nbilldatadepth   OUT   NUMBER,
  ln_ncurrdata        OUT   NUMBER,
  ln_ncurrdatadepth   OUT   NUMBER,
  ln_njournal         OUT   NUMBER,
  ln_nnetparam        OUT   NUMBER,
  ln_vuser            OUT   VARCHAR2,
  ln_vnote            OUT   VARCHAR2,
  ln_nwait            OUT   NUMBER
 )
  RETURN NUMBER;

------------------------------------------------------------------------------------------------------------------------

 -- void __fastcall TComServerThread::SaveStateThread(long id_cod, char* str)
 FUNCTION sel_statecod(an_mid NUMBER, ln_state_cod OUT NUMBER)
  RETURN NUMBER;

------------------------------------------------------------------------------------------------------------------------

 -- void __fastcall TComServerThread::SaveStateThread(long id_cod, char* str)
 PROCEDURE ins_lastsave(an_mid NUMBER, an_state_cod NUMBER, an_state_descr VARCHAR2, an_clock NUMBER);

------------------------------------------------------------------------------------------------------------------------

 -- void __fastcall TComServerThread::SaveStateThread(long id_cod, char* str)
 PROCEDURE upd_lastsave(an_mid NUMBER, an_state_cod NUMBER, an_state_descr VARCHAR2, an_clock NUMBER);

------------------------------------------------------------------------------------------------------------------------

 -- void __fastcall TComServerThread::SaveStateThread(long id_cod, char* str)
 PROCEDURE ins_journal(an_mid NUMBER, an_state_cod NUMBER, an_state_descr VARCHAR2);

------------------------------------------------------------------------------------------------------------------------

 -- void __fastcall TComServerThread::SetLuck(void)
 PROCEDURE upd_lastsaveluck(an_cid NUMBER);

------------------------------------------------------------------------------------------------------------------------

 -- void __fastcall TComServerThread::SetLuck(void)
 PROCEDURE upd_channels(an_cid NUMBER);

------------------------------------------------------------------------------------------------------------------------

 -- void __fastcall TComServerThread::SetLuck(void)
 PROCEDURE upd_lastsavetrial(an_mid NUMBER);

------------------------------------------------------------------------------------------------------------------------
--                                       TZxB_Thread
------------------------------------------------------------------------------------------------------------------------

 -- bool __fastcall TZxB_Thread::ConnectNextZxB_(void)
 FUNCTION connectnextzxb(
  an_mid           NUMBER,
  an_cid           NUMBER,
  ln_mid     OUT   NUMBER,
  ln_canal   OUT   NUMBER,
  ln_name    OUT   VARCHAR2,
  ln_kc      OUT   NUMBER,
  ln_tag     OUT   NUMBER,
  ln_vinfo   OUT   VARCHAR2
 )
  RETURN NUMBER;

------------------------------------------------------------------------------------------------------------------------

 -- bool __fastcall TZxB_Thread::LoadMapLandis(void)
 FUNCTION loadmaplandis(
  an_nusd         NUMBER,
  an_mid    OUT   common_pg.tt_number,
  an_er     OUT   common_pg.tt_number,
  an_ed     OUT   common_pg.tt_number,
  an_q1     OUT   common_pg.tt_number,
  an_q3     OUT   common_pg.tt_number,
  an_kc     OUT   common_pg.tt_number
 )
  RETURN NUMBER;

------------------------------------------------------------------------------------------------------------------------

 -- void __fastcall TZxB_Thread::LoadLastSaveDates(void)
 FUNCTION loadlastsavedates(
  an_mid              NUMBER,                                                                                --Ид точки
  ln_profile    OUT   VARCHAR2,                                                --Дата чтения текущих dd.mm.yyyy hh24:mi
  ln_halfhour   OUT   VARCHAR2,                                                     --Дата чтения ГН dd.mm.yyyy hh24:mi
  ln_bill       OUT   VARCHAR2,                                               --Дата чтения суточных dd.mm.yyyy hh24:mi
  ln_months     OUT   VARCHAR2                                                --Дата чтения месячных dd.mm.yyyy hh24:mi
 )
  RETURN NUMBER;

------------------------------------------------------------------------------------------------------------------------
 -- void __fastcall TZxB_Thread::LoadLastChangeDates(void)
 FUNCTION loadlastchangedates(
  an_mid              NUMBER,
  ln_profile    OUT   VARCHAR2,
  ln_halfhour   OUT   VARCHAR2,
  ln_bill       OUT   VARCHAR2,
  ln_months     OUT   VARCHAR2
 )
  RETURN NUMBER;

------------------------------------------------------------------------------------------------------------------------
 FUNCTION loadlastsavejournal(an_mid NUMBER, av_journal OUT VARCHAR2)
  RETURN NUMBER;

------------------------------------------------------------------------------------------------------------------------

 -- void __fastcall TZxB_Thread::LoadLastSaveDates(void)
 PROCEDURE ins_lastsavemeter(an_mid NUMBER, an_clock NUMBER);

------------------------------------------------------------------------------------------------------------------------

 -- void __fastcall TZxB_Thread::SaveHalfHour(void* tempProfile)
 PROCEDURE upd_lastsavehalfhour(an_mid NUMBER, an_halfhour VARCHAR2);

------------------------------------------------------------------------------------------------------------------------

 -- void __fastcall TZxB_Thread::SaveCurrentValues(void* tempProfile, stLandis_Net Landis_Net)
 PROCEDURE upd_lastsaveprofile(
  an_mid       NUMBER,                                                                                       --Ид точки
  an_clock     NUMBER,                                                                 --Расхождение времени в секундах
  an_profile   VARCHAR2                                                           ----Дата показаний dd.mm.yyyy hh24:mi
 );

------------------------------------------------------------------------------------------------------------------------

 -- void __fastcall TZxB_Thread::SaveDayData(void* tempProfile)
 PROCEDURE upd_lastsavebill(an_mid NUMBER, an_bill VARCHAR2);

------------------------------------------------------------------------------------------------------------------------

 -- void __fastcall TZxB_Thread::SaveMonthData(void* tempProfile)
 PROCEDURE upd_lastsavemonths(an_mid NUMBER, an_months VARCHAR2);

------------------------------------------------------------------------------------------------------------------------
--                                       TOblikThread
------------------------------------------------------------------------------------------------------------------------

 -- void __fastcall TOblikThread::LoadYearDay(void)
 FUNCTION sel_metering(ln_metering OUT NUMBER)
  RETURN NUMBER;

------------------------------------------------------------------------------------------------------------------------

 -- bool __fastcall TOblikThread::ConnectNextOblik(void)
 FUNCTION connectnextoblik(
  an_mid           NUMBER,
  an_cid           NUMBER,
  ln_mid     OUT   NUMBER,
  ln_canal   OUT   NUMBER,
  ln_name    OUT   VARCHAR2,
  ln_kc      OUT   NUMBER,
  ln_tag     OUT   NUMBER
 )
  RETURN NUMBER;

 FUNCTION connectnextoblik(
  an_mid           NUMBER,
  an_cid           NUMBER,
  ln_mid     OUT   NUMBER,
  ln_canal   OUT   NUMBER,
  ln_name    OUT   VARCHAR2,
  ln_kc      OUT   NUMBER,
  ln_tag     OUT   NUMBER,
  ln_vinfo   OUT   VARCHAR2
 )
  RETURN NUMBER;

------------------------------------------------------------------------------------------------------------------------

 -- bool __fastcall TOblikThread::LoadMapOblik(void)
 FUNCTION loadmapoblik(
  an_nusd         NUMBER,
  an_mid    OUT   common_pg.tt_number,
  an_er     OUT   common_pg.tt_number,
  an_ed     OUT   common_pg.tt_number,
  an_q1     OUT   common_pg.tt_number,
  an_q3     OUT   common_pg.tt_number,
  an_kc     OUT   common_pg.tt_number
 )
  RETURN NUMBER;

------------------------------------------------------------------------------------------------------------------------
--                                       TItekThread
------------------------------------------------------------------------------------------------------------------------

 -- bool __fastcall TItekThread::LoadMapItek(void)
 FUNCTION loadmapitek(
  an_cid         NUMBER,
  an_mid   OUT   common_pg.tt_number,
  an_er    OUT   common_pg.tt_number,
  an_ed    OUT   common_pg.tt_number,
  an_q1    OUT   common_pg.tt_number,
  an_q3    OUT   common_pg.tt_number
 )
  RETURN NUMBER;

------------------------------------------------------------------------------------------------------------------------

 -- void __fastcall TItekThread::SaveProfile(float *tempProfile)
 PROCEDURE upd_lastsaveprofileitek(an_cid NUMBER, an_clock NUMBER, an_profile VARCHAR2);

------------------------------------------------------------------------------------------------------------------------

 -- void __fastcall TItekThread::SaveHalfHour(float *tempProfile)
 PROCEDURE upd_lastsavehalfhouritek(an_cid NUMBER, an_halfhour VARCHAR2);

------------------------------------------------------------------------------------------------------------------------

 -- void __fastcall TItekThread::UpdateLastSaveDay(void)
 PROCEDURE upd_lastsavebillitek(an_cid NUMBER, an_bill VARCHAR2);

------------------------------------------------------------------------------------------------------------------------

 -- void __fastcall TItekThread::UpdateLastSaveMonth(void)
 PROCEDURE upd_lastsavemonthsitek(an_cid NUMBER, an_months VARCHAR2);

------------------------------------------------------------------------------------------------------------------------
--                                       TCT5000_Thread
------------------------------------------------------------------------------------------------------------------------

 -- bool __fastcall TCT5000_Thread::LoadMapItek(void)
 FUNCTION loadmapct5000(
  an_cid         NUMBER,
  an_mid   OUT   common_pg.tt_number,
  an_er    OUT   common_pg.tt_number,
  an_ed    OUT   common_pg.tt_number,
  an_q1    OUT   common_pg.tt_number,
  an_q3    OUT   common_pg.tt_number
 )
  RETURN NUMBER;

------------------------------------------------------------------------------------------------------------------------
--                                       TA1R_Thread
------------------------------------------------------------------------------------------------------------------------

 -- bool __fastcall TA1R_Thread::ConnectNextA1R_(void)
 FUNCTION connectnexta1r(
  an_mid           NUMBER,
  an_cid           NUMBER,
  ln_mid     OUT   NUMBER,
  ln_canal   OUT   NUMBER,
  ln_name    OUT   VARCHAR2,
  ln_kc      OUT   NUMBER,
  ln_tag     OUT   NUMBER
 )
  RETURN NUMBER;

------------------------------------------------------------------------------------------------------------------------
--                                       TAlphaThread
------------------------------------------------------------------------------------------------------------------------

 -- bool __fastcall TAlphaThread::ConnectNextAlpha(void)
 FUNCTION connectnextalpha(
  an_mid           NUMBER,
  an_cid           NUMBER,
  ln_mid     OUT   NUMBER,
  ln_canal   OUT   NUMBER,
  ln_name    OUT   VARCHAR2,
  ln_kc      OUT   NUMBER,
  ln_tag     OUT   NUMBER,
  ln_nabc    OUT   NUMBER
 )
  RETURN NUMBER;

------------------------------------------------------------------------------------------------------------------------
--                                       TEnergyThread
------------------------------------------------------------------------------------------------------------------------

 -- bool __fastcall TEnergyThread::ConnectNextEnergy(void)
 FUNCTION connectnextenergy(
  an_mid           NUMBER,
  an_cid           NUMBER,
  ln_mid     OUT   NUMBER,
  ln_canal   OUT   NUMBER,
  ln_name    OUT   VARCHAR2,
  ln_kc      OUT   NUMBER,
  ln_tag     OUT   NUMBER,
  ln_nabc    OUT   NUMBER,
  ln_vinfo   OUT   VARCHAR2
 )
  RETURN NUMBER;

------------------------------------------------------------------------------------------------------------------------
--                                       TRTU_Thread
------------------------------------------------------------------------------------------------------------------------

 -- bool __fastcall TRTU_Thread::ConnectNextPoint()
 FUNCTION connectnextrtu(
  an_mid           NUMBER,
  an_cid           NUMBER,
  ln_mid     OUT   NUMBER,
  ln_canal   OUT   NUMBER,
  ln_name    OUT   VARCHAR2,
  ln_kc      OUT   NUMBER,
  ln_tag     OUT   NUMBER
 )
  RETURN NUMBER;

------------------------------------------------------------------------------------------------------------------------
--                                       TArgoThread
------------------------------------------------------------------------------------------------------------------------

 -- bool __fastcall TArgoThread::ConnectNextArgo(void)
 FUNCTION connectnextargo(
  an_mid           NUMBER,
  an_cid           NUMBER,
  ln_mid     OUT   NUMBER,
  ln_canal   OUT   NUMBER,
  ln_name    OUT   VARCHAR2,
  ln_kc      OUT   NUMBER,
  ln_tag     OUT   NUMBER
 )
  RETURN NUMBER;

------------------------------------------------------------------------------------------------------------------------
--                                       TElvinThread
------------------------------------------------------------------------------------------------------------------------

 -- bool __fastcall TElvinThread::ConnectNextElvin(void)
 FUNCTION connectnextelvin(
  an_mid           NUMBER,
  an_cid           NUMBER,
  ln_mid     OUT   NUMBER,
  ln_canal   OUT   NUMBER,
  ln_name    OUT   VARCHAR2,
  ln_kc      OUT   NUMBER,
  ln_tag     OUT   NUMBER,
  ln_vinfo   OUT   VARCHAR2
 )
  RETURN NUMBER;

------------------------------------------------------------------------------------------------------------------------
--                                       TSL_DlmsThread
------------------------------------------------------------------------------------------------------------------------

 -- bool __fastcall TSL_DlmsThread::ConnectNextSL_Dlms(void)
 FUNCTION connectnextsl_dlms(
  an_mid           NUMBER,
  an_cid           NUMBER,
  ln_mid     OUT   NUMBER,
  ln_canal   OUT   NUMBER,
  ln_name    OUT   VARCHAR2,
  ln_kc      OUT   NUMBER,
  ln_tag     OUT   NUMBER,
  ln_vinfo   OUT   VARCHAR2
 )
  RETURN NUMBER;

------------------------------------------------------------------------------------------------------------------------
 FUNCTION connectnextmtxdlms_dlms(
  an_mid           NUMBER,
  an_cid           NUMBER,
  ln_mid     OUT   NUMBER,
  ln_canal   OUT   NUMBER,
  ln_name    OUT   VARCHAR2,
  ln_kc      OUT   NUMBER,
  ln_tag     OUT   NUMBER,
  ln_vinfo   OUT   VARCHAR2
 )
  RETURN NUMBER;

------------------------------------------------------------------------------------------------------------------------
--                                       TZxD_DlmsThread
------------------------------------------------------------------------------------------------------------------------

 -- bool __fastcall TZxD_DlmsThread::ConnectNextZxD_Dlms(void)
 FUNCTION connectnextzxd_dlms(
  an_mid           NUMBER,
  an_cid           NUMBER,
  ln_mid     OUT   NUMBER,
  ln_canal   OUT   NUMBER,
  ln_name    OUT   VARCHAR2,
  ln_kc      OUT   NUMBER,
  ln_tag     OUT   NUMBER,
  ln_vinfo   OUT   VARCHAR2
 )
  RETURN NUMBER;

------------------------------------------------------------------------------------------------------------------------
--                                       TUSPD_ChanThread
------------------------------------------------------------------------------------------------------------------------

 -- bool __fastcall TUSPD_ChanThread::ConnectNextUspdChan(void)
 FUNCTION connectnextuspdchan(
  an_mid           NUMBER,
  an_cid           NUMBER,
  ln_mid     OUT   NUMBER,
  ln_canal   OUT   NUMBER,
  ln_name    OUT   VARCHAR2,
  ln_kc      OUT   NUMBER,
  ln_tag     OUT   NUMBER
 )
  RETURN NUMBER;

------------------------------------------------------------------------------------------------------------------------

 -- void __fastcall TUSPD_ChanThread::SaveDiffTimeUSD(void)
 PROCEDURE upd_lastsaveclock(an_mid NUMBER, an_clock NUMBER);

------------------------------------------------------------------------------------------------------------------------

 -- void __fastcall TUSPD_ChanThread::LoadChannelStatus(void)
 PROCEDURE upd_lastsavestate(an_mid NUMBER, an_clock NUMBER, an_state_cod NUMBER, an_state_date VARCHAR2);

------------------------------------------------------------------------------------------------------------------------

 -- void __fastcall TUSPD_ChanThread::LoadCurrentValues(void)
 PROCEDURE upd_lastsaveprofile(an_mid NUMBER, an_profile VARCHAR2);

------------------------------------------------------------------------------------------------------------------------
--                                       TSET4_Thread
------------------------------------------------------------------------------------------------------------------------

 -- bool __fastcall TSET4_Thread::ConnectNextSET4_(void)
 FUNCTION connectnextset4(
  an_mid           NUMBER,
  an_cid           NUMBER,
  ln_mid     OUT   NUMBER,
  ln_canal   OUT   NUMBER,
  ln_name    OUT   VARCHAR2,
  ln_kc      OUT   NUMBER,
  ln_tag     OUT   NUMBER,
  ln_nabc    OUT   NUMBER
 )
  RETURN NUMBER;

------------------------------------------------------------------------------------------------------------------------
--                                       TMercuryThread
------------------------------------------------------------------------------------------------------------------------

 -- bool __fastcall TMercuryThread::ConnectNextMercury(void)
 FUNCTION connectnextmercury(
  an_mid           NUMBER,
  an_cid           NUMBER,
  ln_mid     OUT   NUMBER,
  ln_canal   OUT   NUMBER,
  ln_name    OUT   VARCHAR2,
  ln_kc      OUT   NUMBER,
  ln_tag     OUT   NUMBER,
  ln_nabc    OUT   NUMBER
 )
  RETURN NUMBER;

------------------------------------------------------------------------------------------------------------------------
--                                       TLzqmThread
------------------------------------------------------------------------------------------------------------------------

 -- bool __fastcall TLzqmThread::ConnectNextLzqm(void)
 FUNCTION connectnextlzqm(
  an_mid           NUMBER,
  an_cid           NUMBER,
  ln_mid     OUT   NUMBER,
  ln_canal   OUT   NUMBER,
  ln_name    OUT   VARCHAR2,
  ln_kc      OUT   NUMBER,
  ln_tag     OUT   NUMBER,
  ln_nabc    OUT   NUMBER
 )
  RETURN NUMBER;

------------------------------------------------------------------------------------------------------------------------
--                                       TCE304_Thread
------------------------------------------------------------------------------------------------------------------------

 -- bool __fastcall TCE304_Thread::ConnectNextCE304(void)
 FUNCTION connectnextce304(
  an_mid           NUMBER,
  an_cid           NUMBER,
  ln_mid     OUT   NUMBER,
  ln_canal   OUT   NUMBER,
  ln_name    OUT   VARCHAR2,
  ln_kc      OUT   NUMBER,
  ln_tag     OUT   NUMBER,
  ln_vinfo   OUT   VARCHAR2
 )
  RETURN NUMBER;

------------------------------------------------------------------------------------------------------------------------
--                                       TSatecThread
------------------------------------------------------------------------------------------------------------------------

 -- bool __fastcall TSatecThread::ConnectNextSatec(void)
 FUNCTION connectnextsatec(
  an_mid           NUMBER,
  an_cid           NUMBER,
  ln_mid     OUT   NUMBER,
  ln_canal   OUT   NUMBER,
  ln_name    OUT   VARCHAR2,
  ln_kc      OUT   NUMBER,
  ln_tag     OUT   NUMBER,
  ln_vinfo   OUT   VARCHAR2
 )
  RETURN NUMBER;

------------------------------------------------------------------------------------------------------------------------
--                                       TDllMeterThread
------------------------------------------------------------------------------------------------------------------------

 -- bool __fastcall TDllMeterThread::Get_DLL_Name(void)
 FUNCTION get_dll_name(an_protocol NUMBER, ln_name OUT VARCHAR2)
  RETURN NUMBER;

------------------------------------------------------------------------------------------------------------------------

 -- bool __fastcall TDllMeterThread::ConnectNextDllMeter(void)
 FUNCTION connectnextdllmeter(
  an_mid           NUMBER,
  an_cid           NUMBER,
  ln_mid     OUT   NUMBER,
  ln_canal   OUT   NUMBER,
  ln_name    OUT   VARCHAR2,
  ln_kc      OUT   NUMBER,
  ln_tag     OUT   NUMBER,
  ln_nabc    OUT   NUMBER,
  ln_q1234   OUT   NUMBER,
  ln_vinfo   OUT   VARCHAR2
 )
  RETURN NUMBER;

------------------------------------------------------------------------------------------------------------------------
--                                       TA1800Thread
------------------------------------------------------------------------------------------------------------------------

 -- bool __fastcall TA1800Thread::ConnectNextAlpha(void)
 FUNCTION connectnexta1800(
  an_mid           NUMBER,
  an_cid           NUMBER,
  ln_mid     OUT   NUMBER,
  ln_canal   OUT   NUMBER,
  ln_name    OUT   VARCHAR2,
  ln_kc      OUT   NUMBER,
  ln_tag     OUT   NUMBER,
  ln_vinfo   OUT   VARCHAR2
 )
  RETURN NUMBER;

------------------------------------------------------------------------------------------------------------------------
--                                       TFile_Thread
------------------------------------------------------------------------------------------------------------------------

 -- AnsiString __fastcall TFile_Thread::GetLastFileName(int aFileType)
 FUNCTION getlastfilename1(an_mid NUMBER, ln_name OUT VARCHAR2)
  RETURN NUMBER;

------------------------------------------------------------------------------------------------------------------------
 FUNCTION getlastfilename2(an_mid NUMBER, ln_name OUT VARCHAR2)
  RETURN NUMBER;

------------------------------------------------------------------------------------------------------------------------
 FUNCTION getlastfilename3(an_mid NUMBER, ln_name OUT VARCHAR2)
  RETURN NUMBER;

------------------------------------------------------------------------------------------------------------------------

 -- bool __fastcall TFile_Thread::CheckFileExists(AnsiString aFileName)
 FUNCTION checkfileexists(an_count OUT NUMBER, ln_name VARCHAR2)
  RETURN NUMBER;

------------------------------------------------------------------------------------------------------------------------

 -- AnsiString __fastcall TFile_Thread::GetLastFileName(int aFileType)
 PROCEDURE ins_lastsavemeter(an_mid NUMBER);

------------------------------------------------------------------------------------------------------------------------

 -- void __fastcall TFile_Thread::SetLastFileName(AnsiString aFileName)
 PROCEDURE upd_lastfilename1(an_mid NUMBER, an_date VARCHAR2, an_file VARCHAR2);

------------------------------------------------------------------------------------------------------------------------
 PROCEDURE upd_lastfilename2(an_mid NUMBER, an_date VARCHAR2, an_file VARCHAR2);

------------------------------------------------------------------------------------------------------------------------
 PROCEDURE upd_lastfilename3(an_mid NUMBER, an_date VARCHAR2, an_file VARCHAR2);

------------------------------------------------------------------------------------------------------------------------
 --чтение даты последней коррекции времени сетчика  в формате dd.mm.yyyy hh24:mi:ss
 FUNCTION get_metercorrect(an_mid NUMBER)
  RETURN VARCHAR2;

 PRAGMA RESTRICT_REFERENCES(get_metercorrect, WNDS, WNPS);

------------------------------------------------------------------------------------------------------------------------
 --установка даты последней коррекции времени сетчика в формате dd.mm.yyyy hh24:mi:ss
 PROCEDURE set_metercorrect(an_mid NUMBER, av_datetime VARCHAR2);
------------------------------------------------------------------------------------------------------------------------
END;                                                                               -- Package Specification COMSRVCIM_PG
/


-- End of DDL Script for Package RYDA.COMSRVCIM_PG

-- Start of DDL Script for Package Body RYDA.EDITFEEDERS_PG
-- Generated 17.07.2012 10:14:10 from RYDA@test2

CREATE OR REPLACE 
PACKAGE BODY editfeeders_pg IS
 -- пакет работы с точками
 -- дата создания 19/10/2001 (Сечин А.А.)
 gn_task_code             NUMBER DEFAULT 46;
 lc_namelength   CONSTANT NUMBER := 140;

------------------------------------------------------------------------------------------------------------------------
  -- Процедура вставки (полное кол-во параметров)
 PROCEDURE ins_p (an_parent NUMBER,   --Родитель
                                   an_type NUMBER,   --Тип точки
                                                  av_name VARCHAR2,   --Название
                                                                   av_short_name VARCHAR2,   --Краткое название
                                                                                          an_er_position NUMBER, an_q1_position NUMBER, an_ed_position NUMBER,
 an_q3_position NUMBER, an_smart NUMBER,   --Интеллектуал
                                        an_q1234 NUMBER,   --Квадранты
                                                        an_canal NUMBER,   --Номер канала
                                                                        av_cellnum VARCHAR2,   --Номер ячейки
                                                                                            an_power NUMBER,   --Мощность
                                                                                                            an_current1 NUMBER,   --Напряжение перв
                                                                                                                               an_current2 NUMBER,   --Напряжение вторич
 an_kc NUMBER,   --Коэфф
              an_tag NUMBER,   --Тег связи
                            av_info VARCHAR2,   --Доп информация
                                             an_power2 NUMBER,   --Мощность вторич кВ
                                                              an_metkc NUMBER,   --Коэф прошитый в счетчике
                                                                              an_abc NUMBER,   --Заземленная нейтраль
                                                                                            an_calcbill NUMBER,   --Верифицировать суточные
                                                                                                               an_calcmonths NUMBER,   --Верифицировать месячные
 an_inverted NUMBER,   --Инверсия
                    an_switch NUMBER,   --Признак обводника
                                     an_usd NUMBER,   --УСД
                                                   an_nblock NUMBER,   -- блокировка автоматического опроса
                                                                    an_dataabsence NUMBER, an_commctrl NUMBER, an_techctrl NUMBER, an_main NUMBER,   --nMainPoint - основная точка учёта (для дублирования)
 av_verifyparam VARCHAR2,   -- Параметры верификации
                         av_addparams VARCHAR2,   -- Дополнительные параметры
                                               av_importcode VARCHAR2,   -- Связной код импорта
                                                                      an_lockcorrecttime NUMBER,   -- блокировка коррекции времени
                                                                                                av_code VARCHAR2,   -- код точки
                                                                                                                 av_verifyday VARCHAR2,   -- Параметры верификации суточных
 an_classtn NUMBER,   --Класс тотности ТН
                   an_classtt NUMBER,   --Класс тотности ТТ
                                     an_timezonew NUMBER,   --Веменная зона зимой
                                                         an_timezones NUMBER,   --Веменная зона летом
                                                                             an_opposite NUMBER,   --id, информация о противоположной точке
                                                                                                an_norder NUMBER,   --порядок в дереве по умолчанию 0
                                                                                                an_nintegr NUMBER, --период интеграции
 an_mid OUT NUMBER   --Ид точки
 ) IS   -- 46 параметра
  ln_mid   NUMBER;
 BEGIN
  SAVEPOINT editfeeders_ins;

  SELECT points_seq.NEXTVAL
    INTO ln_mid
    FROM DUAL;

  an_mid := ln_mid;

  INSERT INTO points
              (mid, PARENT, cod, ind, NAME, short_name, implement_date, tag, npoint, norder
              )
       VALUES (ln_mid, an_parent, 0, an_type, av_name, av_short_name, SYSDATE, an_tag, NULL, an_norder
              );

  INSERT INTO feeders
              (mid, er_position, q1_position, ed_position, q3_position, smart, q1234, canal,
               cellnum, POWER, current1, current2, kc, line_loss, act_loss, react_loss, vinfo, power2, metkc, nabc, ncalcbill,
               ncalcmonths, ninverted, nswitch, nusd, nblock, ndataabsence, ncommcontrol, ntechcontrol, nmainpoint,
               verifyparam, vaddparams, vimportcode, nlockcorrecttime, vcode, verifyday, nclasstn, nclasstt, ntimezonew, ntimezones,
               nopposite,NINTEGRALPERIOD
              )
       VALUES (ln_mid, an_er_position, an_q1_position, an_ed_position, an_q3_position, DECODE (an_smart, 1, '*', ''), DECODE (an_q1234, 1, '*', ''), an_canal,
               av_cellnum, an_power, an_current1, an_current2, an_kc, 0, 0, 0, av_info, an_power2, NVL (an_metkc, 1), NVL (an_abc, 0), NVL (an_calcbill, 0),
               NVL (an_calcmonths, 0), NVL (an_inverted, 0), NVL (an_switch, 0), an_usd, an_nblock, an_dataabsence, an_commctrl, an_techctrl, an_main,
               av_verifyparam, av_addparams, av_importcode, an_lockcorrecttime, av_code, av_verifyday, an_classtn, an_classtt, an_timezonew, an_timezones,
               an_opposite,an_nintegr 
              );

  INSERT INTO curr_power
              (mid, date_time, obsolete
              )
       VALUES (ln_mid, SYSDATE, 1
              );

  --meters
  IF an_smart = 1 THEN
   INSERT INTO meters
               (ID, mid, NAME, POSITION, entype, smart, kc
               )
        VALUES (points_seq.NEXTVAL, ln_mid, SUBSTR (av_name, 1, lc_namelength) || ' Инт.', an_er_position, 7, '*', an_kc
               );
  ELSE
   IF an_er_position != 0 THEN
    INSERT INTO meters
                (ID, mid, NAME, POSITION, entype, smart, kc
                )
         VALUES (points_seq.NEXTVAL, ln_mid, SUBSTR (av_name, 1, lc_namelength) || ' А птр.', an_er_position, 1, '', an_kc
                );
   END IF;

   IF an_ed_position != 0 THEN
    INSERT INTO meters
                (ID, mid, NAME, POSITION, entype, smart, kc
                )
         VALUES (points_seq.NEXTVAL, ln_mid, SUBSTR (av_name, 1, lc_namelength) || ' А выд.', an_ed_position, 2, '', an_kc
                );
   END IF;

   IF an_q1_position != 0 THEN
    INSERT INTO meters
                (ID, mid, NAME, POSITION, entype, smart, kc
                )
         VALUES (points_seq.NEXTVAL, ln_mid, SUBSTR (av_name, 1, lc_namelength) || ' Р птр.', an_q1_position, 3, '', an_kc
                );
   END IF;

   IF an_q3_position != 0 THEN
    INSERT INTO meters
                (ID, mid, NAME, POSITION, entype, smart, kc
                )
         VALUES (points_seq.NEXTVAL, ln_mid, SUBSTR (av_name, 1, lc_namelength) || ' Р выд.', an_q3_position, 5, '', an_kc
                );
   END IF;
  END IF;

  IF util_pg.get_customer_id = 1 THEN
   ln_mid := editfeeders_pg.insgroup (ln_mid);
  END IF;

  admin_pg.fiscal_p (gn_task_code, 1, 'Добавлена точка учета ' || util_pg.node_path_f (an_mid, 'points', 'mid', 'parent'));
 EXCEPTION
  WHEN OTHERS THEN
   ROLLBACK TO SAVEPOINT editfeeders_ins;
   raise_application_error (-20001, 'editfeeders_pg.ins_p: Ошибка вставки присоединения. ' || CHR (10) || SQLERRM (SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
  FUNCTION insgroup (an_mid NUMBER)
  RETURN NUMBER IS
  ln_gid      NUMBER;
  ln_parent   NUMBER;
  lv_name     VARCHAR2 (256);
  ln_mid      NUMBER;
  ln_testmid  NUMBER;
 BEGIN
  IF NVL (util_pg.get_customer_id, 0) <> 1 THEN
   RETURN NULL;
  END IF;
  
 ln_testmid:=0;

  SELECT MAX (gid)
    INTO ln_gid
    FROM GROUPS
   WHERE nroot1 = 1 AND nroot2 = an_mid;

  IF ln_gid > 0 THEN
   RETURN ln_gid;
  END IF;

  SELECT PARENT, NAME, DECODE (ind, 3, mid, 4, mid ,NULL)
    INTO ln_parent, lv_name, ln_mid
    FROM points p
   WHERE mid = an_mid;

  IF ln_parent IS NOT NULL THEN
   SELECT MAX (gid)
     INTO ln_gid
     FROM GROUPS
    WHERE nroot1 = 1 AND nroot2 = ln_parent;

   IF ln_gid IS NULL THEN
    ln_gid := insgroup (ln_parent);
   END IF;
  END IF;

  IF ln_parent IS NULL THEN
   SELECT MAX (gid)
     INTO ln_gid
     FROM GROUPS
    WHERE PARENT IS NULL AND NAME = 'Точки АСРПП';

   IF ln_gid IS NULL THEN
    RETURN -1;
   END IF;
  ELSE
   SELECT MAX (gid), MAX(mid)
     INTO ln_gid,ln_testmid
     FROM GROUPS
    WHERE nroot1 = 1 AND nroot2 = ln_parent;
  END IF;
   IF ln_testmid>0 THEN
   RETURN -1;
   ELSE
     editgroups_pg.ins_p_a (ln_gid, lv_name, NULL, ln_mid, 0, 1, an_mid, NULL, NULL, NULL, NULL,NULL, ln_gid);
   END IF;
  RETURN ln_gid;
 END;

-----------------------------------------------------------------------------------------------------------------------------
   -- Процедура вставки АСКУЭ
 PROCEDURE ins_p_a (an_parent NUMBER,   --Родитель
                                     an_type NUMBER,   --Тип точки
                                                    av_name VARCHAR2,   --Название
                                                                     av_short_name VARCHAR2,   --Краткое название
                                                                                            an_er_position NUMBER, an_q1_position NUMBER, an_ed_position NUMBER,
 an_q3_position NUMBER, an_smart NUMBER,   --Интеллектуал
                                        an_q1234 NUMBER,   --Квадранты
                                                        av_cellnum VARCHAR2,   --Номер ячейки
                                                                            an_power NUMBER,   --Мощность
                                                                                            an_current1 NUMBER,   --Напряжение перв
                                                                                                               an_current2 NUMBER,   --Напряжение вторич
                                                                                                                                  an_kc NUMBER,   --Коэфф
 an_point NUMBER,   --Ид точки АСРПП
                 an_power2 NUMBER,   --Мощность вторич кВ,
                 an_ptype NUMBER,
                 an_order NUMBER,
                                  an_mid OUT NUMBER   --Ид точки
 ) IS
  ln_mid   NUMBER;
  ln_ind   NUMBER;
  
 BEGIN
  SELECT points_seq.NEXTVAL
    INTO ln_mid
    FROM DUAL;

  an_mid := ln_mid;
 

  INSERT INTO points
              (mid, PARENT, cod, ind, NAME, short_name, implement_date, tag, npoint,ptype,norder
              )
       VALUES (ln_mid, an_parent, 0, an_type, av_name, av_short_name, SYSDATE, NULL, an_point,an_ptype,an_order
              );
              

  INSERT INTO feeders
              (mid, er_position, q1_position, ed_position, q3_position, smart, q1234, canal,
               cellnum, POWER, current1, current2, kc, line_loss, act_loss, react_loss, vinfo, power2, metkc, nabc, ncalcbill, ncalcmonths, nlockcorrecttime
              )
       VALUES (ln_mid, an_er_position, an_q1_position, an_ed_position, an_q3_position, DECODE (an_smart, 1, '*', ''), DECODE (an_q1234, 1, '*', ''), NULL,
               av_cellnum, an_power, an_current1, an_current2, an_kc, 0, 0, 0, NULL, an_power2, 1, 0, 0, 0, 0
              );

  INSERT INTO curr_power
              (mid, obsolete
              )
       VALUES (ln_mid, 1
              );
              
  
  --meters
  IF an_smart = 1 THEN
   INSERT INTO meters
               (ID, mid, NAME, POSITION, entype, smart, kc
               )
        VALUES (points_seq.NEXTVAL, ln_mid, SUBSTR (av_name, 1, lc_namelength) || ' Инт.', an_er_position, 7, '*', an_kc
               );
  ELSE
   IF an_er_position != 0 THEN
    INSERT INTO meters
                (ID, mid, NAME, POSITION, entype, smart, kc
                )
         VALUES (points_seq.NEXTVAL, ln_mid, SUBSTR (av_name, 1, lc_namelength) || ' А птр.', an_er_position, 1, '', an_kc
                );
   END IF;

   IF an_ed_position != 0 THEN
    INSERT INTO meters
                (ID, mid, NAME, POSITION, entype, smart, kc
                )
         VALUES (points_seq.NEXTVAL, ln_mid, SUBSTR (av_name, 1, lc_namelength) || ' А выд.', an_ed_position, 2, '', an_kc
                );
   END IF;

   IF an_q1_position != 0 THEN
    INSERT INTO meters
                (ID, mid, NAME, POSITION, entype, smart, kc
                )
         VALUES (points_seq.NEXTVAL, ln_mid, SUBSTR (av_name, 1, lc_namelength) || ' Р птр.', an_q1_position, 3, '', an_kc
                );
   END IF;

   IF an_q3_position != 0 THEN
    INSERT INTO meters
                (ID, mid, NAME, POSITION, entype, smart, kc
                )
         VALUES (points_seq.NEXTVAL, ln_mid, SUBSTR (av_name, 1, lc_namelength) || ' Р выд.', an_q3_position, 5, '', an_kc
                );
   END IF;
  END IF;

  IF util_pg.get_customer_id = 1 THEN
  
  /* SELECT p1.ind
   INTO ln_ind 
   FROM points p,points p1 
   WHERE p.mid=ln_mid 
   AND p1.mid=p.parent;
   
  IF ln_ind<>4 OR ln_ind<>3 THEN*/
     ln_mid := insgroup (ln_mid);
--  END IF;
  END IF;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error (-20001, 'editfeeders_pg.ins_p: Ошибка вставки присоединения. ' || CHR (10) || SQLERRM (SQLCODE));
 END;


------------------------------------------------------------------------------------------------------------------------
   -- Процедура вставки АСКУЭ
 PROCEDURE ins_p_synchro (an_parent NUMBER,   --Родитель
                                           an_type NUMBER,   --Тип точки
                                                          av_name VARCHAR2,   --Название
                                                                           av_short_name VARCHAR2,   --Краткое название
                                                                                                  an_smart NUMBER,   --Интеллектуал
                                                                                                                  an_q1234 NUMBER,   --Квадранты
                                                                                                                                  av_cellnum VARCHAR2,   --Номер ячейки
 an_power NUMBER,   --Мощность
                 an_current1 NUMBER,   --Напряжение перв
                                    an_current2 NUMBER,   --Напряжение вторич
                                                       an_kc NUMBER,   --Коэфф
                                                                    an_root NUMBER,   --Ид точки в родительской БД
                                                                                   an_power2 NUMBER,   --Мощность вторич кВ
                                                                                                    an_mid OUT NUMBER   --Ид точки
 ) IS
  ln_mid   NUMBER;
 BEGIN
  SELECT points_seq.NEXTVAL
    INTO ln_mid
    FROM DUAL;

  an_mid := ln_mid;

  INSERT INTO points
              (mid, PARENT, cod, ind, NAME, short_name, implement_date, tag, nroot
              )
       VALUES (ln_mid, an_parent, 0, an_type, av_name, av_short_name, SYSDATE, NULL, an_root
              );

  INSERT INTO feeders
              (mid, er_position, q1_position, ed_position, q3_position, smart, q1234, canal, cellnum, POWER, current1, current2, kc, line_loss, act_loss,
               react_loss, vinfo, power2, metkc, nabc, ncalcbill, ncalcmonths, nlockcorrecttime
              )
       VALUES (ln_mid, 0, 0, 0, 0, DECODE (an_smart, 1, '*', ''), DECODE (an_q1234, 1, '*', ''), NULL, av_cellnum, an_power, an_current1, an_current2, an_kc, 0, 0,
               0, NULL, an_power2, 1, 0, 0, 0, 0
              );

  INSERT INTO curr_power
              (mid, obsolete
              )
       VALUES (ln_mid, 1
              );

  INSERT INTO meters
              (ID, mid, NAME, POSITION, entype, smart, kc
              )
       VALUES (points_seq.NEXTVAL, ln_mid, SUBSTR (av_name, 1, lc_namelength) || ' Инт.', 0, 7, '*', an_kc
              );
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error (-20001, 'editfeeders_pg.ins_p_synchro: Ошибка вставки присоединения. ' || CHR (10) || SQLERRM (SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
  -- Процедура обновления данных АСКУЭ
  PROCEDURE upd_p_a (an_mid NUMBER,   --Ид точки
                                  an_parent NUMBER,   --Родитель
                                                   an_type NUMBER,   --Тип точки
                                                                  av_name VARCHAR2,   --Название
                                                                                   av_short_name VARCHAR2,   --Краткое название
                                                                                                          an_er_position NUMBER, an_q1_position NUMBER,
 an_ed_position NUMBER, an_q3_position NUMBER, an_smart NUMBER,   --Интеллектуал
                                                               an_q1234 NUMBER,   --Квадранты
                                                                               av_cellnum VARCHAR2,   --Номер ячейки
                                                                                                   an_power NUMBER,   --Мощность
                                                                                                                   an_current1 NUMBER,   --Напряжение перв
 an_current2 NUMBER,   --Напряжение вторич
                    an_kc NUMBER,   --Коэфф
                                 an_power2 NUMBER   --Мощность вторич кВ
 --  an_metkc       NUMBER --Коэф прошитый в счетчике
 ) IS
  ln_gid    NUMBER;
  ln_gid1   NUMBER;
 BEGIN
  UPDATE points
     SET PARENT = an_parent,
         NAME = av_name,
         short_name = av_short_name,
         ind=an_type
   WHERE mid = an_mid;

  UPDATE GROUPS
     SET NAME = av_name,
         short_name = av_short_name
   WHERE mid = an_mid;

  UPDATE feeders
     SET smart = DECODE (an_smart, 1, '*', ''),
         q1234 = DECODE (an_q1234, 1, '*', ''),
         cellnum = av_cellnum,
         POWER = an_power,
         current1 = an_current1,
         current2 = an_current2,
         kc = an_kc,
         power2 = an_power2
   WHERE mid = an_mid;

  --meters
  IF an_smart = 1 THEN
   DELETE FROM meters
         WHERE mid = an_mid AND entype BETWEEN 1 AND 6;

   UPDATE meters
      SET NAME = SUBSTR (av_name, 1, lc_namelength) || ' Инт.',
          POSITION = an_er_position,
          kc = an_kc
    WHERE mid = an_mid AND entype = 7;

   IF SQL%ROWCOUNT <= 0 THEN
    INSERT INTO meters
                (ID, mid, NAME, POSITION, entype, smart, kc
                )
         VALUES (points_seq.NEXTVAL, an_mid, SUBSTR (av_name, 1, lc_namelength) || ' Инт.', an_er_position, 7, '*', an_kc
                );
   END IF;
  ELSE
   DELETE FROM meters
         WHERE mid = an_mid AND entype = 7;

   IF an_er_position != 0 THEN
    UPDATE meters
       SET NAME = SUBSTR (av_name, 1, lc_namelength) || ' А птр.',
           POSITION = an_er_position,
           kc = an_kc
     WHERE mid = an_mid AND entype = 1;

    IF SQL%ROWCOUNT <= 0 THEN
     INSERT INTO meters
                 (ID, mid, NAME, POSITION, entype, smart, kc
                 )
          VALUES (points_seq.NEXTVAL, an_mid, SUBSTR (av_name, 1, lc_namelength) || ' А птр.', an_er_position, 1, '', an_kc
                 );
    END IF;
   ELSE
    DELETE FROM meters
          WHERE mid = an_mid AND entype = 1;
   END IF;

   IF an_ed_position != 0 THEN
    UPDATE meters
       SET NAME = SUBSTR (av_name, 1, lc_namelength) || ' А выд.',
           POSITION = an_ed_position,
           kc = an_kc
     WHERE mid = an_mid AND entype = 2;

    IF SQL%ROWCOUNT <= 0 THEN
     INSERT INTO meters
                 (ID, mid, NAME, POSITION, entype, smart, kc
                 )
          VALUES (points_seq.NEXTVAL, an_mid, SUBSTR (av_name, 1, lc_namelength) || ' А выд.', an_ed_position, 2, '', an_kc
                 );
    END IF;
/* - changed by EVK 31.08.2011
   ELSE
    DELETE FROM meters
          WHERE mid = an_mid AND entype = 2;
*/
   END IF;

   IF an_q1_position != 0 THEN
    UPDATE meters
       SET NAME = SUBSTR (av_name, 1, lc_namelength) || ' Р птр.',
           POSITION = an_q1_position,
           kc = an_kc
     WHERE mid = an_mid AND entype = 3;

    IF SQL%ROWCOUNT <= 0 THEN
     INSERT INTO meters
                 (ID, mid, NAME, POSITION, entype, smart, kc
                 )
          VALUES (points_seq.NEXTVAL, an_mid, SUBSTR (av_name, 1, lc_namelength) || ' Р птр.', an_q1_position, 3, '', an_kc
                 );
    END IF;
   ELSE
    DELETE FROM meters
          WHERE mid = an_mid AND entype = 3;
   END IF;

   IF an_q3_position != 0 THEN
    UPDATE meters
       SET NAME = SUBSTR (av_name, 1, lc_namelength) || ' Р выд.',
           POSITION = an_q3_position,
           kc = an_kc
     WHERE mid = an_mid AND entype = 5;

    IF SQL%ROWCOUNT <= 0 THEN
     INSERT INTO meters
                 (ID, mid, NAME, POSITION, entype, smart, kc
                 )
          VALUES (points_seq.NEXTVAL, an_mid, SUBSTR (av_name, 1, lc_namelength) || ' Р выд.', an_q3_position, 5, '', an_kc
                 );
    END IF;
   ELSE
    DELETE FROM meters
          WHERE mid = an_mid AND entype = 5;
   END IF;
  END IF;

  IF util_pg.get_customer_id = 1 THEN
   ln_gid := insgroup (an_parent);
   ln_gid1 := insgroup (an_mid);

   UPDATE GROUPS
      SET NAME = av_name,
          PARENT = ln_gid
    WHERE nroot1 = 1 AND nroot2 = an_mid;
  END IF;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error (-20001, 'editfeeders_pg.upd_p: Ошибка обновления присоединения. ' || CHR (10) || SQLERRM (SQLCODE));
 END;
------------------------------------------------------------------------------------------------------------------------
PROCEDURE upd_p_b(an_mid NUMBER,   --Ид зеленой точки
                   an_test NUMBER   --Ид синей точки
 )IS
 
 
 BEGIN
 UPDATE  feeders f SET (f.er_position, f.q1_position, f.ed_position,
       f.q3_position,   f.canal,  
       f.line_loss, f.act_loss,
       f.react_loss, f.ov_mid, f.vinfo,  f.metkc, f.nabc,
       f.ncalcbill, f.ncalcmonths, f.ninverted, f.nswitch,
       f.nworkinghours, f.nfullhours, f.nwastepercentcalc, f.nrecompens,
       f.nusd, f.nblock, f.ncalcpointtype, f.ntechcontrol,
       f.ncommcontrol, f.ndataabsence, f.ndataabsencec,
       f.ndataabsencect, f.ddataabsencec, f.nmainpoint, f.verifyparam,
       f.ntcurrent, f.ntpower, f.vaddparams, f.vimportcode,
       f.nlockcorrecttime, f.vcode, f.verifyday, f.nclasstn, f.nclasstt,
       f.ntimezonew, f.ntimezones, f.nopposite, f.nintegralperiod)=   
 (SELECT a.er_position, a.q1_position, a.ed_position,
       a.q3_position,   a.canal,  
       a.line_loss, a.act_loss,
       a.react_loss, a.ov_mid, a.vinfo,  a.metkc, a.nabc,
       a.ncalcbill, a.ncalcmonths, a.ninverted, 0 nswitch,
       a.nworkinghours, a.nfullhours, a.nwastepercentcalc, a.nrecompens,
       a.nusd, a.nblock, a.ncalcpointtype, a.ntechcontrol,
       a.ncommcontrol, a.ndataabsence, a.ndataabsencec,
       a.ndataabsencect, a.ddataabsencec, a.nmainpoint, a.verifyparam,
       a.ntcurrent, a.ntpower, a.vaddparams, a.vimportcode,
        a.nlockcorrecttime, NULL vcode, a.verifyday, a.nclasstn, a.nclasstt,
       a.ntimezonew, a.ntimezones, a.nopposite, a.nintegralperiod
   FROM feeders a 
   WHERE a.mid=an_mid)
   WHERE mid=an_test;
   
   UPDATE  points p SET (p.tag)=
   (SELECT a.tag FROM points a   WHERE a.mid=an_mid)
   WHERE mid=an_test;
   
    INSERT INTO  last_save ( mid, PROFILE, halfhour, bill, rate, clock,
       state_date, state_cod, state_descr, luck, rates,
       months, trial, fail, journal, halfhourchange,
       dparametrization, dmetercorrect)
    SELECT an_mid, a.PROFILE, a.halfhour, a.bill, a.rate, a.clock,
       a.state_date, a.state_cod, a.state_descr, a.luck, a.rates,
       a.months, a.trial, a.fail, a.journal, a.halfhourchange,
       a.dparametrization, a.dmetercorrect
    FROM last_save a WHERE mid=an_test;
  
 END;
---------------------------------------------------------------------------------------------------------------
 -- Процедура удаления данных
 PROCEDURE del_p (an_mid NUMBER   --Ид точки
                               ) IS
 BEGIN
  admin_pg.fiscal_p (gn_task_code, 3, 'Удалена точка учета ' || util_pg.node_path_f (an_mid, 'points', 'mid', 'parent'));

  UPDATE feeders
     SET nusd = NULL
   WHERE nusd = an_mid;

  UPDATE feeders
     SET nmainpoint = NULL
   WHERE nmainpoint = an_mid;

  UPDATE feeders
     SET nopposite = NULL
   WHERE nopposite = an_mid;

  UPDATE forms f
     SET f.mid = NULL
   WHERE f.mid IN (SELECT     mid
                         FROM points
                   CONNECT BY PRIOR mid = PARENT
                   START WITH mid = an_mid);

  DELETE FROM points
        WHERE mid = an_mid;

  DELETE FROM GROUPS
        WHERE nroot1 = 1 AND nroot2 = an_mid;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error (-20001, 'editfeeders_pg.del_p: Ошибка удаления присоединения. ' || CHR (10) || SQLERRM (SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
--Процедура обновления счетчика АСКУЭ
 PROCEDURE upd_meters_a (an_mid NUMBER,   --Ид точки
                                       an_entype NUMBER,   --ENTYPE
                                                        av_smart VARCHAR2,   --SMART
                                                                          av_mtrsn VARCHAR2,   --MTRSN
                                                                                            ad_date_time DATE,   --DATE_TIME
                                                                                                              an_digits NUMBER,   --DIGITS
                                                                                                                               av_mtype VARCHAR2,   --MTYPE
 an_mcurrent NUMBER,   --MCURRENT
                    an_mpower NUMBER,   --MPOWER
                                     an_mconst NUMBER,   --MCONST
                                                      an_mclass NUMBER,   --MCLASS
                                                                       an_myear NUMBER,   --MYEAR
                                                                                       an_mquarter NUMBER   --MQUARTER
 ) IS
 BEGIN
  UPDATE meters
     SET date_time = ad_date_time,
         mtrsn = av_mtrsn,
         DIGITS = an_digits,
         mtype = av_mtype,
         mcurrent = an_mcurrent,
         mpower = an_mpower,
         myear = an_myear,
         mquarter = an_mquarter,
         mconst = an_mconst,
         mclass = an_mclass
   WHERE mid = an_mid AND entype = an_entype;

  admin_pg.fiscal_p (gn_task_code, 2, 'Изменены атрибуты счетчика №' || av_mtrsn || ' для точки ' || util_pg.node_path_f (an_mid, 'points', 'mid', 'parent'));
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error (-20001, 'editfeeders_pg.upd_meters: Ошибка обновления счетчика. ' || CHR (10) || SQLERRM (SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
--Устанавливает параметры простых потерь
 PROCEDURE setaddparam (an_mid NUMBER,   --Ид точки
                                      an_wastepercentcalc NUMBER,   --Тип потерь
                                                                 an_workinghours NUMBER,   --Часы работы
                                                                                        an_fullhours NUMBER,   --Полные часы работы
                                                                                                            an_line_loss NUMBER,   --Портери в линии
                                                                                                                                an_act_loss NUMBER,   --Потери акт транс
 an_react_loss NUMBER,   --Потери реакт транс
                      an_recompens NUMBER,   --Тип расчета реактива
                                          an_calcpointtype NUMBER,   --Тип расчетной точки
                                                                  an_gid NUMBER   --ид расчет группы
 ) IS
 BEGIN
  --  raise_application_error(-20001, 'В доступе отказано');
  UPDATE feeders
     SET nwastepercentcalc = an_wastepercentcalc,
         nworkinghours = an_workinghours,
         nfullhours = an_fullhours,
         line_loss = an_line_loss,
         act_loss = an_act_loss,
         react_loss = an_react_loss,
         nrecompens = DECODE (an_recompens, 1, 1, 0, NULL, an_recompens),
        ncalcpointtype = DECODE (an_calcpointtype, 1, 1, 0, NULL, an_calcpointtype)
   WHERE mid = an_mid;

  IF an_gid <> 0 THEN
   UPDATE calcpointbygroup
      SET gid = an_gid
    WHERE mid = an_mid;

   IF SQL%ROWCOUNT = 0 THEN
    INSERT INTO calcpointbygroup
                (mid, gid
                )
         VALUES (an_mid, an_gid
                );
   END IF;
  ELSE
   DELETE FROM calcpointbygroup
         WHERE mid = an_mid;
  END IF;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error (-20001, 'editfeeders_pg.setaddparam: Ошибка дополнительных параметров точки. ' || CHR (10) || SQLERRM (SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
     -- Нормативные параметры точки
 PROCEDURE setcalcparam_p (an_mid NUMBER,   --Ид точки
                                         at_date common_pg.tt_number,   --Дата ввода в действие
                                                                     at_currpower common_pg.tt_number,   --Мощность
                                                                                                      at_monthconsumpt common_pg.tt_number,   --Месяч расход
 at_kc common_pg.tt_number   --Коэф пересчета
 ) IS
 BEGIN
  SAVEPOINT setcalcparam_sp;

  DELETE FROM pointsparam
        WHERE mid = an_mid;

  IF at_date.COUNT > 0 AND at_date (1) <> 0 THEN
   FOR i IN 1 .. at_date.COUNT LOOP
    INSERT INTO pointsparam
                (mid, ddate, ncurrpower, nmonthconsumpt, nkc
                )
         VALUES (an_mid, TO_DATE (at_date (i), 'yyyymmdd'), at_currpower (i), at_monthconsumpt (i), NVL (at_kc (i), 1)
                );
   END LOOP;
  END IF;

  admin_pg.fiscal_p (gn_task_code, 2, 'Изменены нормативные параметры точки учета ' || util_pg.node_path_f (an_mid, 'points', 'mid', 'parent'));
 EXCEPTION
  WHEN OTHERS THEN
   ROLLBACK TO SAVEPOINT setcalcparam_sp;
   raise_application_error (-20001, 'editfeeders_pg.setcalcparam_p: Задания нормативных параметров точки учета. ' || CHR (10) || SQLERRM (SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
  -- Процедура обновления данных (с полным набором параметров)
 PROCEDURE upd_p (an_mid NUMBER,   --Ид точки
                                an_parent NUMBER,   --Родитель
                                                 an_type NUMBER,   --Тип точки
                                                                av_name VARCHAR2,   --Название
                                                                                 av_short_name VARCHAR2,   --Краткое название
                                                                                                        an_er_position NUMBER, an_q1_position NUMBER,
 an_ed_position NUMBER, an_q3_position NUMBER, an_smart NUMBER,   --Интеллектуал
                                                               an_q1234 NUMBER,   --Квадранты
                                                                               an_canal NUMBER,   --Номер канала
                                                                                               av_cellnum VARCHAR2,   --Номер ячейки
                                                                                                                   an_power NUMBER,   --Мощность
                                                                                                                                   an_current1 NUMBER,   --Напряжение перв
 an_current2 NUMBER,   --Напряжение вторич
                    an_kc NUMBER,   --Коэфф
                                 an_tag NUMBER,   --Тег связи
                                               av_info VARCHAR2,   --Доп информация
                                                                an_power2 NUMBER,   --Мощность вторич кВ
                                                                                 an_metkc NUMBER,   --Коэф прошитый в счетчике
                                                                                                 an_abc NUMBER,   --Заземленная нейтраль
                                                                                                               an_calcbill NUMBER,   --Верифицировать суточные
 an_calcmonths NUMBER,   --Верифицировать месячные
                      an_inverted NUMBER,   --Инверсия
                                         an_switch NUMBER,   --Признак обводника
                                                          an_usd NUMBER,   --УСД
                                                                        an_nblock NUMBER,   --Блокировка авт. опроса
                                                                                         an_dataabsence NUMBER, an_commctrl NUMBER, an_techctrl NUMBER,
 an_main NUMBER,   --nMainPoint - основная точка учёта (для дублирования)
                av_verifyparam VARCHAR2,   -- Параметры верификации
                                        av_addparams VARCHAR2,   -- Дополнительные параметры
                                                              av_importcode VARCHAR2,   -- Связной код импорта
                                                                                     an_lockcorrecttime NUMBER,   -- блокировка коррекции времени
                                                                                                               av_code VARCHAR2,   -- код точки
                                                                                                                                av_verifyday VARCHAR2,   -- Параметры верификации суточных
 an_classtn NUMBER,   --Класс тотности ТН
                   an_classtt NUMBER,   --Класс тотности ТТ
                                     an_timezonew NUMBER,   --Временная зона зимой
                                                         an_timezones NUMBER,   --Временная зона летом
                                                                             an_opposite NUMBER,   --id, информация о противоположной точке
 an_norder NUMBER,   --порядок в дереве по умолчанию 0
 an_nintegr NUMBER, --период интеграции
 an_lockswitch NUMBER --не переходит на ОВ
 ) IS   -- 44 параметра
  ln_gid      NUMBER;
  ln_gid1     NUMBER;
  ln_old_kc   NUMBER;
 BEGIN
  SAVEPOINT editfeeders_upd;

  SELECT MAX (kc)
    INTO ln_old_kc
    FROM feeders
   WHERE mid = an_mid;

  IF util_pg.get_customer_id = 1 THEN   --ХЭС
   UPDATE points
      SET tag = an_tag,
          norder = an_norder
    WHERE mid = an_mid;

   UPDATE feeders
      SET er_position = an_er_position,
          q1_position = an_q1_position,
          ed_position = an_ed_position,
          q3_position = an_q3_position,
          canal = an_canal,
          vinfo = av_info,
          metkc = NVL (an_metkc, 1),
          nabc = NVL (an_abc, 0),
          ncalcbill = NVL (an_calcbill, 0),
          ncalcmonths = NVL (an_calcmonths, 0),
          ninverted = NVL (an_inverted, 0),
          nswitch = NVL (an_switch, 0),
          nusd = an_usd,
          nblock = an_nblock,
          ndataabsence = an_dataabsence,
          ncommcontrol = an_commctrl,
          ntechcontrol = an_techctrl,
          nmainpoint = an_main,
          verifyparam = av_verifyparam,
          vaddparams = av_addparams,
          vimportcode = av_importcode,
          nlockcorrecttime = an_lockcorrecttime,
          vcode = av_code,
          verifyday = av_verifyday,
          nclasstn = an_classtn,
          nclasstt = an_classtt,
          ntimezonew = an_timezonew,
          ntimezones = an_timezones,
          nopposite = an_opposite,
          NINTEGRALPERIOD = an_nintegr,
          NLOCKSWITCH = an_lockswitch
    WHERE mid = an_mid;
  ELSE
   UPDATE points
      SET PARENT = an_parent,
          NAME = av_name,
          short_name = av_short_name,
          tag = an_tag,
          norder = an_norder
    WHERE mid = an_mid;

   UPDATE GROUPS
      SET NAME = av_name,
          short_name = av_short_name
    WHERE mid = an_mid;

   UPDATE feeders
      SET er_position = an_er_position,
          q1_position = an_q1_position,
          ed_position = an_ed_position,
          q3_position = an_q3_position,
          smart = DECODE (an_smart, 1, '*', ''),
          q1234 = DECODE (an_q1234, 1, '*', ''),
          canal = an_canal,
          cellnum = av_cellnum,
          POWER = an_power,
          current1 = an_current1,
          current2 = an_current2,
          kc = an_kc,
          vinfo = av_info,
          power2 = an_power2,
          metkc = NVL (an_metkc, 1),
          nabc = NVL (an_abc, 0),
          ncalcbill = NVL (an_calcbill, 0),
          ncalcmonths = NVL (an_calcmonths, 0),
          ninverted = NVL (an_inverted, 0),
          nswitch = NVL (an_switch, 0),
          nusd = an_usd,
          nblock = an_nblock,
          ndataabsence = an_dataabsence,
          ncommcontrol = an_commctrl,
          ntechcontrol = an_techctrl,
          nmainpoint = an_main,
          verifyparam = av_verifyparam,
          vaddparams = av_addparams,
          vimportcode = av_importcode,
          nlockcorrecttime = an_lockcorrecttime,
          vcode = av_code,
          verifyday = av_verifyday,
          nclasstn = an_classtn,
          nclasstt = an_classtt,
          ntimezonew = an_timezonew,
          ntimezones = an_timezones,
          nopposite = an_opposite,
          NINTEGRALPERIOD=an_nintegr,
          NLOCKSWITCH = an_lockswitch
    WHERE mid = an_mid;

   --meters
   IF an_smart = 1 THEN
    DELETE FROM meters
          WHERE mid = an_mid AND entype BETWEEN 1 AND 6;

    UPDATE meters
       SET NAME = SUBSTR (av_name, 1, lc_namelength) || ' Инт.',
           POSITION = an_er_position,
           kc = an_kc
     WHERE mid = an_mid AND entype = 7;

    IF SQL%ROWCOUNT <= 0 THEN
     INSERT INTO meters
                 (ID, mid, NAME, POSITION, entype, smart, kc
                 )
          VALUES (points_seq.NEXTVAL, an_mid, SUBSTR (av_name, 1, lc_namelength) || ' Инт.', an_er_position, 7, '*', an_kc
                 );
    END IF;
   ELSE
    DELETE FROM meters
          WHERE mid = an_mid AND entype = 7;

    IF an_er_position != 0 THEN
     UPDATE meters
        SET NAME = SUBSTR (av_name, 1, lc_namelength) || ' А птр.',
            POSITION = an_er_position,
            kc = an_kc
      WHERE mid = an_mid AND entype = 1;

     IF SQL%ROWCOUNT <= 0 THEN
      INSERT INTO meters
                  (ID, mid, NAME, POSITION, entype, smart, kc
                  )
           VALUES (points_seq.NEXTVAL, an_mid, SUBSTR (av_name, 1, lc_namelength) || ' А птр.', an_er_position, 1, '', an_kc
                  );
     END IF;
    ELSE
     DELETE FROM meters
           WHERE mid = an_mid AND entype = 1;
    END IF;

    IF an_ed_position != 0 THEN
     UPDATE meters
        SET NAME = SUBSTR (av_name, 1, lc_namelength) || ' А выд.',
            POSITION = an_ed_position,
            kc = an_kc
      WHERE mid = an_mid AND entype = 2;

     IF SQL%ROWCOUNT <= 0 THEN
      INSERT INTO meters
                  (ID, mid, NAME, POSITION, entype, smart, kc
                  )
           VALUES (points_seq.NEXTVAL, an_mid, SUBSTR (av_name, 1, lc_namelength) || ' А выд.', an_ed_position, 2, '', an_kc
                  );
     END IF;
    ELSE
     DELETE FROM meters
           WHERE mid = an_mid AND entype = 2;
    END IF;

    IF an_q1_position != 0 THEN
     UPDATE meters
        SET NAME = SUBSTR (av_name, 1, lc_namelength) || ' Р птр.',
            POSITION = an_q1_position,
            kc = an_kc
      WHERE mid = an_mid AND entype = 3;

     IF SQL%ROWCOUNT <= 0 THEN
      INSERT INTO meters
                  (ID, mid, NAME, POSITION, entype, smart, kc
                  )
           VALUES (points_seq.NEXTVAL, an_mid, SUBSTR (av_name, 1, lc_namelength) || ' Р птр.', an_q1_position, 3, '', an_kc
                  );
     END IF;
    ELSE
     DELETE FROM meters
           WHERE mid = an_mid AND entype = 3;
    END IF;

    IF an_q3_position != 0 THEN
     UPDATE meters
        SET NAME = SUBSTR (av_name, 1, lc_namelength) || ' Р выд.',
            POSITION = an_q3_position,
            kc = an_kc
      WHERE mid = an_mid AND entype = 5;

     IF SQL%ROWCOUNT <= 0 THEN
      INSERT INTO meters
                  (ID, mid, NAME, POSITION, entype, smart, kc
                  )
           VALUES (points_seq.NEXTVAL, an_mid, SUBSTR (av_name, 1, lc_namelength) || ' Р выд.', an_q3_position, 5, '', an_kc
                  );
     END IF;
    ELSE
     DELETE FROM meters
           WHERE mid = an_mid AND entype = 5;
    END IF;
   END IF;
  END IF;

  IF util_pg.get_customer_id = 1 THEN
   ln_gid := editfeeders_pg.insgroup (an_parent);
   ln_gid1 := editfeeders_pg.insgroup (an_mid);

   UPDATE GROUPS
      SET NAME = av_name,
          PARENT = ln_gid
    WHERE nroot1 = 1 AND nroot2 = an_mid;
  END IF;

  admin_pg.fiscal_p (gn_task_code, 2, 'Изменены атрибуты точки ' || util_pg.node_path_f (an_mid, 'points', 'mid', 'parent'));

  IF ln_old_kc <> an_kc THEN
   file_pg.startbyevents_p (46, an_mid, SYSDATE);
  END IF;
 EXCEPTION
  WHEN OTHERS THEN
   ROLLBACK TO SAVEPOINT editfeeders_upd;
   raise_application_error (-20001, 'editfeeders_pg.upd_p: Ошибка обновления присоединения. ' || CHR (10) || SQLERRM (SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
 -- Процедура обновления данных (с неполным набором параметров)
 PROCEDURE upd_p (an_mid NUMBER,   --Ид точки
                                av_importcode VARCHAR2,   -- Связной код импорта
                                                       an_canal NUMBER,   --Номер канала
                                                                       an_tag NUMBER,   --Тег связи
                                                                                     an_er_position NUMBER, an_q1_position NUMBER, an_ed_position NUMBER,
 an_q3_position NUMBER, av_info VARCHAR2,   --Доп информация
                                         an_nblock NUMBER,   --Блокировка авт. опроса
                                                          an_dataabsence NUMBER, an_commctrl NUMBER, an_techctrl NUMBER, an_lockcorrecttime NUMBER,   -- блокировка коррекции времени
 an_timezonew NUMBER,   --Временная зона зимой
                     an_timezones NUMBER   --Временная зона летом
 -- an_parent            NUMBER,   --Родитель
  --an_type              NUMBER,   --Тип точки
  --av_name              VARCHAR2,   --Название
  --av_short_name        VARCHAR2,   --Краткое название
  -- an_smart             NUMBER,   --Интеллектуал
 -- an_q1234             NUMBER,   --Квадранты
 -- av_cellnum           VARCHAR2,   --Номер ячейки
 -- an_power             NUMBER,   --Мощность
 -- an_current1          NUMBER,   --Напряжение перв
  --an_current2          NUMBER,   --Напряжение вторич
  --an_kc                NUMBER,   --Коэфф
  --an_power2            NUMBER,   --Мощность вторич кВ
  --an_metkc             NUMBER,   --Коэф прошитый в счетчике
  --an_abc               NUMBER,   --Заземленная нейтраль
  --an_calcbill          NUMBER,   --Верифицировать суточные
  --an_calcmonths        NUMBER,   --Верифицировать месячные
  --an_inverted          NUMBER,   --Инверсия
  --an_switch            NUMBER,   --Признак обводника
 -- an_usd               NUMBER,   --УСД
--  an_main              NUMBER,   --nMainPoint - основная точка учёта (для дублирования)
--  av_verifyparam       VARCHAR2,   -- Параметры верификации
--  av_addparams         VARCHAR2,   -- Дополнительные параметры
--  av_code              VARCHAR2,   -- код точки
 -- av_verifyday         VARCHAR2,   -- Параметры верификации суточных
 -- an_classtn           NUMBER,   --Класс тотности ТН
 -- an_classtt           NUMBER,   --Класс тотности ТТ
 -- an_opposite          NUMBER,   --id, информация о противоположной точке
--  an_norder            NUMBER  --порядок в дереве по умолчанию 0
 ) IS   -- 16 параметра
  CURSOR lcur_f (cn_mid NUMBER) IS
   SELECT p.mid, p.PARENT, 0 ntype, p.NAME, p.short_name, DECODE (f.smart, '*', 1, 0) smart, DECODE (f.q1234, '*', 1, 0) q1234, f.cellnum, f.POWER, f.current1,
          f.current2, f.kc, f.power2, f.metkc, f.nabc, f.ncalcbill, f.ncalcmonths, f.ninverted, f.nswitch, f.nlockswitch, f.nusd, f.vcode, f.nmainpoint, f.verifyparam,
          f.vaddparams, f.verifyday, f.nclasstn, f.nclasstt, f.nopposite, p.norder, f.nintegralperiod
     FROM points p, feeders f
    WHERE p.mid = f.mid(+) AND p.mid = cn_mid;
 BEGIN
  FOR cr IN lcur_f (an_mid) LOOP
   upd_p (an_mid, cr.PARENT, cr.ntype, cr.NAME, cr.short_name, an_er_position, an_q1_position, an_ed_position, an_q3_position, cr.smart, cr.q1234, an_canal,
          cr.cellnum, cr.POWER, cr.current1, cr.current2, cr.kc, an_tag, av_info, cr.power2, cr.metkc, cr.nabc, cr.ncalcbill, cr.ncalcmonths, cr.ninverted,
          cr.nswitch, cr.nusd, an_nblock, an_dataabsence, an_commctrl, an_techctrl, cr.nmainpoint, cr.verifyparam, cr.vaddparams, av_importcode, an_lockcorrecttime,
          cr.vcode, cr.verifyday, cr.nclasstn, cr.nclasstt, an_timezonew, an_timezones, cr.nopposite, cr.norder, cr.nintegralperiod, cr.nlockswitch);
  END LOOP;
 END;

--------------------------------------------------------------------------------------------
--Процедура обновления параметров
 PROCEDURE upd_last_save (an_mid NUMBER,   --Ид точки
                                        ad_profile DATE,   -- Дата постедней считанного профиля
                                                        ad_halfhour DATE,   -- Дата постедней считанного получасовки
                                                                         ad_bill DATE,   -- Дата постедней считанного суточного показания
 ad_month DATE   -- Дата постедней считанного месячного показания
 ) IS
  ld_sys   DATE DEFAULT TRUNC (SYSDATE);
 BEGIN
  ins_last_save (an_mid);

  UPDATE last_save
     SET PROFILE = ad_profile,
         halfhour = ad_halfhour,
         bill = ad_bill,
         months = ad_month
   WHERE mid = an_mid;

  admin_pg.fiscal_p (gn_task_code, 2, 'Изменены параметры дат считанных данных (LAST_SAVE) для точки ' || util_pg.node_path_f (an_mid, 'points', 'mid', 'parent'));
  COMMIT;
 EXCEPTION
  WHEN OTHERS THEN
   ROLLBACK;
   raise_application_error (-20001, 'editfeeders_pg.upd_last_save: Ошибка обновления параметров сохраненных данных. ' || CHR (10) || SQLERRM (SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
  --Процедура добавления пустой строки в last_save
 PROCEDURE ins_last_save (an_mid NUMBER,   --Ид точки
                                        av_state VARCHAR2,an_state_cod NUMBER , an_clock NUMBER ) IS
  ld_sys   DATE DEFAULT TRUNC (SYSDATE);
 BEGIN
  INSERT INTO last_save
              (mid, PROFILE, halfhour, bill, state_date, state_cod, state_descr, clock, luck, rates, months, journal)
   SELECT an_mid, ld_sys - 10, ld_sys - 370, ld_sys - 370, ld_sys, NVL(an_state_cod, 0), NVL(av_state, 'Опрос не производился '), NVL(an_clock, 0),
          ld_sys - 100, ld_sys - 100, ld_sys - 370, ld_sys - 370
   FROM   DUAL
   WHERE  NOT EXISTS(SELECT *
                     FROM   last_save
                     WHERE  mid = an_mid);
 END;

------------------------------------------------------------------------------------------------------------------------
   -- Пересчитывает расход по показаниям счетчика и ГН
 PROCEDURE recalcdiff (an_mid NUMBER, ad_from DATE) IS   --расход
  ln_rn     NUMBER          DEFAULT 10;
  lv_name   VARCHAR2 (4000);
 BEGIN
  FOR lc IN (SELECT p.mid, NVL (f.kc, 0) kc
               FROM (SELECT     mid, ind
                           FROM points
                     CONNECT BY PRIOR mid = PARENT
                     START WITH mid = an_mid) p,
                    feeders f
              WHERE p.mid = f.mid AND p.ind = 3 AND NVL (f.kc, 0) > 0
                    AND NVL (f.ncalcpointtype, 0) NOT IN
                                                   (calcformula_pg.cn_cpt_cons, calcformula_pg.cn_cpt_amm, calcformula_pg.cn_cpt_sum, calcformula_pg.cn_cpt_formula)) LOOP
   lv_name := util_pg.node_path_f (lc.mid, 'points', 'mid', 'parent');

   --Обновляем точку
   UPDATE halfhourold
      SET er = ROUND (lc.kc * er / NVL (nkc, 1), ln_rn),
          ed = ROUND (lc.kc * ed / NVL (nkc, 1), ln_rn),
          q1 = ROUND (lc.kc * q1 / NVL (nkc, 1), ln_rn),
          q3 = ROUND (lc.kc * q3 / NVL (nkc, 1), ln_rn),
          q2 = ROUND (lc.kc * q2 / NVL (nkc, 1), ln_rn),
          q4 = ROUND (lc.kc * q4 / NVL (nkc, 1), ln_rn),
          nkc = lc.kc,
          denter = SYSDATE
    WHERE mid = lc.mid AND date_time > ad_from;

   DELETE FROM halfhourold
         WHERE mid = lc.mid AND date_time > TRUNC (ad_from) AND NOT (nsource BETWEEN 1 AND util_pg.cn_manualinputw);

   UPDATE billorg
      SET er = ROUND (lc.kc * er / NVL (er_kc, 1), ln_rn),
          aer = ROUND (lc.kc * aer / NVL (er_kc, 1), ln_rn),
          ber = ROUND (lc.kc * ber / NVL (er_kc, 1), ln_rn),
          cer = ROUND (lc.kc * cer / NVL (er_kc, 1), ln_rn),
          ed = ROUND (lc.kc * ed / NVL (ed_kc, 1), ln_rn),
          aed = ROUND (lc.kc * aed / NVL (ed_kc, 1), ln_rn),
          bed = ROUND (lc.kc * bed / NVL (ed_kc, 1), ln_rn),
          ced = ROUND (lc.kc * ced / NVL (ed_kc, 1), ln_rn),
          q1 = ROUND (lc.kc * q1 / NVL (q1_kc, 1), ln_rn),
          aq1 = ROUND (lc.kc * aq1 / NVL (q1_kc, 1), ln_rn),
          bq1 = ROUND (lc.kc * bq1 / NVL (q1_kc, 1), ln_rn),
          cq1 = ROUND (lc.kc * cq1 / NVL (q1_kc, 1), ln_rn),
          q3 = ROUND (lc.kc * q3 / NVL (q3_kc, 1), ln_rn),
          aq3 = ROUND (lc.kc * aq3 / NVL (q3_kc, 1), ln_rn),
          bq3 = ROUND (lc.kc * bq3 / NVL (q3_kc, 1), ln_rn),
          cq3 = ROUND (lc.kc * cq3 / NVL (q3_kc, 1), ln_rn),
          q2 = ROUND (lc.kc * q2 / NVL (q2_kc, 1), ln_rn),
          aq2 = ROUND (lc.kc * aq2 / NVL (q2_kc, 1), ln_rn),
          bq2 = ROUND (lc.kc * bq2 / NVL (q2_kc, 1), ln_rn),
          cq2 = ROUND (lc.kc * cq2 / NVL (q2_kc, 1), ln_rn),
          q4 = ROUND (lc.kc * q4 / NVL (q4_kc, 1), ln_rn),
          aq4 = ROUND (lc.kc * aq4 / NVL (q4_kc, 1), ln_rn),
          bq4 = ROUND (lc.kc * bq4 / NVL (q4_kc, 1), ln_rn),
          cq4 = ROUND (lc.kc * cq4 / NVL (q4_kc, 1), ln_rn),
          er_kc = lc.kc,
          ed_kc = lc.kc,
          q1_kc = lc.kc,
          q2_kc = lc.kc,
          q3_kc = lc.kc,
          q4_kc = lc.kc
    WHERE mid = lc.mid AND date_time > ad_from;

   UPDATE monthsorg
      SET er = ROUND (lc.kc * er / NVL (er_kc, 1), ln_rn),
          aer = ROUND (lc.kc * aer / NVL (er_kc, 1), ln_rn),
          ber = ROUND (lc.kc * ber / NVL (er_kc, 1), ln_rn),
          cer = ROUND (lc.kc * cer / NVL (er_kc, 1), ln_rn),
          ed = ROUND (lc.kc * ed / NVL (ed_kc, 1), ln_rn),
          aed = ROUND (lc.kc * aed / NVL (ed_kc, 1), ln_rn),
          bed = ROUND (lc.kc * bed / NVL (ed_kc, 1), ln_rn),
          ced = ROUND (lc.kc * ced / NVL (ed_kc, 1), ln_rn),
          q1 = ROUND (lc.kc * q1 / NVL (q1_kc, 1), ln_rn),
          aq1 = ROUND (lc.kc * aq1 / NVL (q1_kc, 1), ln_rn),
          bq1 = ROUND (lc.kc * bq1 / NVL (q1_kc, 1), ln_rn),
          cq1 = ROUND (lc.kc * cq1 / NVL (q1_kc, 1), ln_rn),
          q3 = ROUND (lc.kc * q3 / NVL (q3_kc, 1), ln_rn),
          aq3 = ROUND (lc.kc * aq3 / NVL (q3_kc, 1), ln_rn),
          bq3 = ROUND (lc.kc * bq3 / NVL (q3_kc, 1), ln_rn),
          cq3 = ROUND (lc.kc * cq3 / NVL (q3_kc, 1), ln_rn),
          q2 = ROUND (lc.kc * q2 / NVL (q2_kc, 1), ln_rn),
          aq2 = ROUND (lc.kc * aq2 / NVL (q2_kc, 1), ln_rn),
          bq2 = ROUND (lc.kc * bq2 / NVL (q2_kc, 1), ln_rn),
          cq2 = ROUND (lc.kc * cq2 / NVL (q2_kc, 1), ln_rn),
          q4 = ROUND (lc.kc * q4 / NVL (q4_kc, 1), ln_rn),
          aq4 = ROUND (lc.kc * aq4 / NVL (q4_kc, 1), ln_rn),
          bq4 = ROUND (lc.kc * bq4 / NVL (q4_kc, 1), ln_rn),
          cq4 = ROUND (lc.kc * cq4 / NVL (q4_kc, 1), ln_rn),
          er_kc = lc.kc,
          ed_kc = lc.kc,
          q1_kc = lc.kc,
          q2_kc = lc.kc,
          q3_kc = lc.kc,
          q4_kc = lc.kc
    WHERE mid = lc.mid AND date_time > ad_from;

   --Обновляем ОВ
   UPDATE halfhourold
      SET er = ROUND (lc.kc * er / NVL (nkc, 1), ln_rn),
          ed = ROUND (lc.kc * ed / NVL (nkc, 1), ln_rn),
          q1 = ROUND (lc.kc * q1 / NVL (nkc, 1), ln_rn),
          q3 = ROUND (lc.kc * q3 / NVL (nkc, 1), ln_rn),
          q2 = ROUND (lc.kc * q2 / NVL (nkc, 1), ln_rn),
          q4 = ROUND (lc.kc * q4 / NVL (nkc, 1), ln_rn),
          nkc = lc.kc,
          denter = SYSDATE
    WHERE nswitch = lc.mid AND date_time > ad_from;

   DELETE FROM halfhourold
         WHERE nswitch = lc.mid AND date_time > TRUNC (ad_from) AND NOT (nsource BETWEEN 1 AND util_pg.cn_manualinputw);

   -- Чистим bill
   DELETE FROM billold
         WHERE mid = lc.mid AND date_time > ad_from;

   INSERT INTO lagging_records
               (mid, ddate)
    (SELECT   mid, TRUNC (date_time - 1 / 1440)
         FROM halfhourold
        WHERE mid = lc.mid AND date_time > ad_from
     GROUP BY mid, TRUNC (date_time - 1 / 1440)
     MINUS
     SELECT mid, ddate
       FROM lagging_records);

   admin_pg.fiscal_p (gn_task_code, 2, 'Выполнен перерасчет расхода начиная с ' || TO_CHAR (ad_from, 'DD.MM.YYYY HH24:MI:SS') || ' по точке учета ' || lv_name);
   COMMIT;
  END LOOP;

  FOR i IN 0 .. TRUNC (SYSDATE - TRUNC (ad_from)) - 1 LOOP
   calcformula_pg.calc (TRUNC (ad_from) + i, an_mid);
   COMMIT;
  END LOOP;

  IF util_pg.newcalcday_f = 0 THEN
   das_pg.calcperiod4bill (TRUNC (ad_from), TRUNC (SYSDATE));
  ELSE
   IF util_pg.get_customer_id = 45 THEN
    NULL;
   ELSE
    das_pg.closeperiod (1, SYSDATE);
   END IF;
  END IF;

  COMMIT;
 EXCEPTION
  WHEN OTHERS THEN
   ROLLBACK;
   raise_application_error (-20001, 'indic_pg.recalcdiff: Ошибка перерасчета расходапо точке: ''' || lv_name || '''. ' || CHR (10) || SQLERRM (SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
 --Процедура удаления данных из БД
 PROCEDURE delete_data (an_mid NUMBER,   --Ид точки
                                      ad_profile DATE,   -- Дата > которой удаляются данные профиля
                                                      ad_halfhour DATE,   -- Дата > которой удаляются данные ГН
                                                                       ad_bill DATE,   -- Дата > которой удаляются данные Суточных
                                                                                    ad_month DATE,   --  Дата > которой удаляются месячные Суточных
                                                                                                  ad_profile_e DATE,   -- Дата <= которой удаляются данные профиля
 ad_halfhour_e DATE,   -- Дата <= которой удаляются данные ГН
                    ad_bill_e DATE,   -- Дата <= которой удаляются данные Суточных
                                   ad_month_e DATE,   --  Дата <= которой удаляются месячные Суточных
                                                   ad_journal DATE,   -- Дата > которой удаляются данные Журнала
                                                                   ad_journal_e DATE,   -- Дата <= которой удаляются данные Журнала
                                                                                     ad_currpower DATE,   --  Дата > которой удаляются мгновенные данные
 ad_currpower_e DATE,   --  Дата <= которой удаляются мгновенные данные
                     an_withreload NUMBER   --Признак сдвига LAST_SAVE
 ) IS
  lv_name   VARCHAR2 (4000);
  ld_end    DATE            DEFAULT TO_DATE (300001, 'YYYYMM');
 BEGIN
  FOR lc IN (SELECT p.mid, DECODE (util_pg.taketimezone, 1, 0, NVL (util_pg.cn_tzw - f.ntimezonew, 0)) tz
               FROM (SELECT     mid
                           FROM points
                     CONNECT BY PRIOR mid = PARENT
                     START WITH mid = an_mid) p,
                    feeders f
              WHERE f.mid = p.mid) LOOP
   lv_name := util_pg.node_path_f (lc.mid, 'points', 'mid', 'parent');

   IF ad_profile IS NOT NULL THEN
    DELETE FROM PROFILE
          WHERE mid = lc.mid AND date_time > ad_profile AND date_time <= NVL (ad_profile_e, ld_end);

    admin_pg.fiscal_p (gn_task_code, 3,
                       'Выполнено удаление данных профиля за период с ' || TO_CHAR (ad_profile, 'DD.MM.YYYY HH24:MI:SS') || ' по '
                       || TO_CHAR (NVL (ad_profile_e, ld_end), 'DD.MM.YYYY HH24:MI:SS') || ' по точке учета ' || lv_name);
   END IF;

   IF ad_halfhour IS NOT NULL THEN
    DELETE FROM halfhourold
          WHERE mid = lc.mid AND date_time > ad_halfhour AND date_time <= NVL (ad_halfhour_e, ld_end);

    DELETE FROM billold
          WHERE mid = lc.mid AND date_time > ad_halfhour AND date_time <= NVL (ad_halfhour_e, ld_end);

    --ОВ
    DELETE FROM billold
          WHERE mid IN (SELECT mid
                          FROM halfhourold
                         WHERE nswitch = lc.mid AND date_time > ad_halfhour AND date_time <= NVL (ad_halfhour_e, ld_end)) AND date_time > ad_halfhour
                AND date_time <= NVL (ad_halfhour_e, ld_end);

    DELETE FROM halfhourold
          WHERE nswitch = lc.mid AND date_time > ad_halfhour AND date_time <= NVL (ad_halfhour_e, ld_end);

    admin_pg.fiscal_p (gn_task_code, 3,
                       'Выполнено удаление данных ГН начиная с ' || TO_CHAR (ad_halfhour, 'DD.MM.YYYY HH24:MI:SS') || ' по '
                       || TO_CHAR (NVL (ad_halfhour_e, ld_end), 'DD.MM.YYYY HH24:MI:SS') || ' по точке учета ' || lv_name);
   END IF;

   IF ad_bill IS NOT NULL THEN
    DELETE FROM billorg
          WHERE mid = lc.mid AND date_time >= TRUNC (ad_bill) + 1 AND date_time <= NVL (ad_bill_e, ld_end);

    admin_pg.fiscal_p (gn_task_code, 3,
                       'Выполнено удаление суточных данных начиная с ' || TO_CHAR (ad_bill, 'DD.MM.YYYY HH24:MI:SS') || ' по '
                       || TO_CHAR (NVL (ad_bill_e, ld_end), 'DD.MM.YYYY HH24:MI:SS') || ' по точке учета ' || lv_name);
   END IF;

   IF ad_month IS NOT NULL THEN
    DELETE FROM monthsorg
          WHERE mid = lc.mid AND date_time >= ADD_MONTHS (TRUNC (ad_month, 'MONTH'), 1) AND date_time <= NVL (ad_month_e, ld_end);

    admin_pg.fiscal_p (gn_task_code, 3,
                       'Выполнено удаление месячных данных начиная с ' || TO_CHAR (ad_month, 'DD.MM.YYYY HH24:MI:SS') || ' по '
                       || TO_CHAR (NVL (ad_month_e, ld_end), 'DD.MM.YYYY HH24:MI:SS') || ' по точке учета ' || lv_name);
   END IF;

   IF ad_journal IS NOT NULL THEN
    DELETE FROM journal
          WHERE mid = lc.mid AND date_time > ad_journal AND date_time <= NVL (ad_journal_e, ld_end);

    admin_pg.fiscal_p (gn_task_code, 3,
                       'Выполнено удаление данных журнала начиная с ' || TO_CHAR (ad_journal, 'DD.MM.YYYY HH24:MI:SS') || ' по '
                       || TO_CHAR (NVL (ad_journal_e, ld_end), 'DD.MM.YYYY HH24:MI:SS') || ' по точке учета ' || lv_name);
   END IF;

   IF ad_currpower IS NOT NULL THEN
    DELETE FROM curr_power_arch
          WHERE mid = lc.mid AND date_time > ad_currpower AND date_time <= NVL (ad_currpower_e, ld_end);

    admin_pg.fiscal_p (gn_task_code, 3,
                       'Выполнено удаление мгновенных данных начиная с ' || TO_CHAR (ad_currpower, 'DD.MM.YYYY HH24:MI:SS') || ' по '
                       || TO_CHAR (NVL (ad_currpower_e, ld_end), 'DD.MM.YYYY HH24:MI:SS') || ' по точке учета ' || lv_name);
   END IF;

   IF an_withreload = 1 THEN
    UPDATE last_save
       SET PROFILE = NVL (ad_profile, PROFILE),
           halfhour = NVL (util_pg.to_unlocaltime_if_new (ad_halfhour) - lc.tz / 24, halfhour),
           bill = NVL (ad_bill, bill),
           months = NVL (ad_month, months),
           journal = NVL (ad_journal, journal)
     WHERE mid = lc.mid;
   END IF;

   COMMIT;
  END LOOP;

  IF util_pg.getparamvalue_f (45) = 1 THEN
   RETURN;
  END IF;

  IF util_pg.newcalcday_f = 0 THEN
   das_pg.calcperiod4bill (TRUNC (ad_halfhour), TRUNC (SYSDATE));
  ELSE
   das_pg.closeperiod (1, SYSDATE);
  END IF;

  COMMIT;
 EXCEPTION
  WHEN OTHERS THEN
   ROLLBACK;
   raise_application_error (-20001, 'indic_pg.delete_data: Ошибка удаления данных по точке: ''' || lv_name || '''. ' || CHR (10) || SQLERRM (SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
 --ищем точку, группу или канал (an_mid - точка старта)
 FUNCTION findpoint (an_mid NUMBER, av_name VARCHAR2, av_code VARCHAR2, av_mtrsn VARCHAR2, av_pmid VARCHAR2, an_pointtype NUMBER, av_canal VARCHAR2)
  RETURN NUMBER IS
  lv_sql     VARCHAR2 (2000);
  lv_name    VARCHAR2 (2000) DEFAULT REPLACE (UPPER (TRIM (av_name)), '*', '%');
  lv_code    VARCHAR2 (2000) DEFAULT REPLACE (UPPER (TRIM (av_code)), '*', '%');
  lv_mtrsn   VARCHAR2 (2000) DEFAULT REPLACE (UPPER (TRIM (av_mtrsn)), '*', '%');
  lv_pmid    VARCHAR2 (2000) DEFAULT REPLACE (UPPER (TRIM (av_pmid)), '*', '%');
  lv_canal   VARCHAR2 (2000) DEFAULT REPLACE (UPPER (TRIM (av_canal)), '*', '%');  
  ln_ret     NUMBER;
 BEGIN
   
--  IF an_pointtype IS NOT NULL THEN
  IF an_pointtype = 1 THEN  -- группы
   lv_sql := 'select nvl(min(p.gid),0) from groups p,feeders f,meters m where p.gid> NVL (:an_mid, 0) and f.mid=p.mid and f.mid=m.mid(+) ';
  ELSIF an_pointtype = 2 THEN -- каналы added by KAG 10.03.2010
   lv_sql := 'select nvl(min(cp.cid),0) from chanpoint cp, feeders f, meters m, points p 
               WHERE cp.cid> NVL (:an_mid, 0) AND f.mid=cp.mid AND f.mid=m.mid(+) AND p.mid=cp.mid 
                     AND EXISTS (SELECT * FROM  schemchannels
                                  WHERE NOPERSCANSCHEMAS IN (SELECT NOPERSCANSCHEMAS FROM ROLES
                                                              WHERE role_id IN (SELECT role_id FROM users WHERE usr = '''||USER||'''))
                                        AND cid = cp.cid) ';    
  ELSE  -- точки
   -- lv_sql := 'select nvl(min(f.mid),0) from points p,feeders f,meters m where f.mid>' || NVL (an_mid, 0) || ' and f.mid=p.mid and f.mid=m.mid(+) ';
   lv_sql := 'select nvl(min(p.mid),0) from points p,feeders f,meters m where p.mid> NVL (:an_mid, 0) and p.mid=f.mid(+) and f.mid=m.mid(+) ';
  END IF;

  IF lv_name IS NOT NULL THEN
   IF INSTR (lv_name, '%') > 0 THEN
    lv_sql := lv_sql || ' and upper(p.NAME) like ''' || lv_name || '''';
   ELSE
    lv_sql := lv_sql || ' and upper(p.NAME)=''' || lv_name || '''';
   END IF;
  END IF;

  IF lv_code IS NOT NULL THEN
   IF INSTR (lv_code, '%') > 0 THEN
    lv_sql := lv_sql || ' and upper(f.VCODE) like ''' || lv_code || '''';
   ELSE
    lv_sql := lv_sql || ' and upper(f.VCODE)=''' || lv_code || '''';
   END IF;
  END IF;

  IF lv_mtrsn IS NOT NULL THEN
   IF INSTR (lv_mtrsn, '%') > 0 THEN
    lv_sql := lv_sql || ' and upper(m.MTRSN) like ''' || lv_mtrsn || '''';
   ELSE
    lv_sql := lv_sql || ' and upper(m.MTRSN)=''' || lv_mtrsn || '''';
   END IF;
  END IF;

  IF lv_pmid IS NOT NULL THEN
   IF INSTR (lv_pmid, '%') > 0 THEN
    --IF an_pointtype IS NOT NULL THEN
    IF an_pointtype = 1 THEN
     lv_sql := lv_sql || ' and upper(p.GID) like ''' || lv_pmid || '''';
    ELSE
     lv_sql := lv_sql || ' and upper(p.MID) like ''' || lv_pmid || '''';
    END IF;
   ELSE
    --IF an_pointtype IS NOT NULL THEN
    IF an_pointtype = 1 THEN
     lv_sql := lv_sql || ' and upper(p.GID)=''' || lv_pmid || '''';
    ELSE
     lv_sql := lv_sql || ' and upper(p.MID)=''' || lv_pmid || '''';
    END IF;
   END IF;
  END IF;

  IF lv_canal IS NOT NULL THEN
   IF INSTR (lv_canal, '%') > 0 THEN
    lv_sql := lv_sql || ' and upper(f.CANAL) like ''' || lv_canal || '''';
   ELSE
    lv_sql := lv_sql || ' and upper(f.CANAL)=''' || lv_canal || '''';
   END IF;
  END IF;

  EXECUTE IMMEDIATE lv_sql
               INTO ln_ret using an_mid;
  
  RETURN ln_ret;
 END;

--------------------------------------------------------------------------------------------------------------
 PROCEDURE recompens_p (acur_t OUT common_pg.tcur) IS
 BEGIN
  OPEN acur_t FOR
   SELECT   nrecompens, LTRIM (TO_CHAR (nratio, '0.99')) || ' ' || vname vname, 1 nsort, nratio
       FROM recompens
   UNION ALL
   SELECT   0 nrecompens, 'По счетчику на реактивную', 0 nsort, 0 nratio
       FROM DUAL
   ORDER BY 3, 4 DESC;
 END;

-----------------------------------------------------------------------------------------------------------------
 PROCEDURE calcpointtype_p (acur_t OUT common_pg.tcur) IS
 BEGIN
  OPEN acur_t FOR
   SELECT   ncalcpointtype, vname, 1 nsort
       FROM calcpointtype
   UNION ALL
   SELECT   0, 'Не производить', 0 nsort
       FROM DUAL
   ORDER BY 3, 2;
 END;

-------------------------------------------------------------------------------------------------------------------
 PROCEDURE naccperiod_p (an_mid NUMBER, acur_t OUT common_pg.tcur) IS
 BEGIN
  OPEN acur_t FOR
   SELECT   naccperiod, nworkinghours, nfullhours
       FROM pointfullhours
      WHERE mid = an_mid
   ORDER BY 1 DESC;
 END;

-----------------------------------------------------------------------------------------------------------------
 PROCEDURE connectaccperiod_p (an_mid NUMBER, acur_t OUT common_pg.tcur) IS
 BEGIN
  OPEN acur_t FOR
   SELECT   naccperiod, nworkinghours, nfullhours
       FROM connectionparamfullhours
      WHERE nconnectionparam = an_mid
   ORDER BY 1 DESC;
 END;

-----------------------------------------------------------------------------------------------------------------
 PROCEDURE nperiod_p (an_mid NUMBER, acur_t OUT common_pg.tcur) IS
 BEGIN
  OPEN acur_t FOR
   SELECT   TO_CHAR (ddate, 'yyyymmdd') nperiod, ncurrpower, nmonthconsumpt, nkc
       FROM pointsparam
      WHERE mid = an_mid
   ORDER BY ddate DESC;
 END;

---------------------------------------------------------------------------------------------------------------------
 PROCEDURE readnode_p (an_mid NUMBER, an_parent NUMBER, acur_t OUT common_pg.tcur) IS
 BEGIN
  IF an_parent IS NULL THEN
   OPEN acur_t FOR
    SELECT   1 havechild, p.mid, 1 TYPE, p.NAME, p.short_name, DECODE (p.ind, 1, 1, 2, 1, 3), 0 er_position, 0 q1_position, 0 ed_position, 0 q3_position, 0 smart,
             0 q, 0 canal, 0 cellnum, 0 POWER, 0 power2, 0 current1, 0 current2, 0 kc, 0 metkc, p.tag, '' vinfo, 0 nabc, 0 ncalcbill, 0 ncalcmonths, 0 ninverted,
             0 nswitch, 0 nlockswitch, 0 nwastepercentcalc, 0 nworkinghours, 0 nfullhours, 0 line_loss, 0 act_loss, 0 react_loss, 0 nrecompens, DECODE (1, 2, 0) usdmid,
             '' usdtext, DECODE (1, 2, 0) nblock, 0 ncalcpointtype, 0 ncurrpower, 0 nmonthconsumpt, 0 dataabs, 0 commcontr, 0 techcontr, DECODE (1, 2, 0) mainmid,
             '' maintext, 0 gid, '' groupname, '' verifyparam, '' vaddparams, '' vimportcode, 0 nlockcorrecttime, '' vcode, '' verifyday, 1 / 2 nclasstn,
             1 / 2 nclasstt, 2 ntimezonew, 3 ntimezones, DECODE (1, 2, 0) oppositemid, ' ' opposite, p.norder, ' ' formula, '' vsource ,0 NINTEGRALPERIOD
        FROM points p
       WHERE p.mid = (SELECT MIN (mid)
                        FROM enterprise) AND EXISTS (SELECT *
                                                       FROM points
                                                      WHERE PARENT = p.mid AND cod = 0 AND (ind < 3 OR mid IN (SELECT mid
                                                                                                                 FROM feeders)))
    UNION ALL
    SELECT   0 havechild, p.mid, 1, p.NAME, p.short_name, DECODE (p.ind, 1, 1, 2, 1, 3), 0 er_position, 0 q1_position, 0 ed_position, 0 q3_position, 0, 0, 0 canal,
             0 cellnum, 0 POWER, 0 power2, 0 current1, 0 current2, 0 kc, 0 kc, p.tag, '' vinfo, 0 nabc, 0 ncalcbill, 0 ncalcmonths, 0 ninverted, 0 nswitch, 0 nlockswitch,
             0 nwastepercentcalc, 0 nworkinghours, 0 nfullhours, 0 line_loss, 0 act_loss, 0 react_loss, 0 nrecompens, DECODE (1, 2, 0) usdmid, '' usdtext,
             DECODE (1, 2, 0) nblock, 0 ncalcpointtype, 0 ncurrpower, 0 nmonthconsumpt, 0 dataabs, 0 commcontr, 0 techcontr, DECODE (1, 2, 0) mainmid, '' maintext,
             0 gid, '' groupname, '' verifyparam, '' vaddparams, '' vimportcode, 0 nlockcorrecttime, '' vcode, '' verifyday, 1 / 2 nclasstn, 1 / 2 nclasstt,
             2 ntimezonew, 3 ntimezones, DECODE (1, 2, 0) oppositemid, ' ' opposite, p.norder, ' ' formula, '' vsource,0 NINTEGRALPERIOD
        FROM points p
       WHERE p.mid = (SELECT MIN (mid)
                        FROM enterprise) AND NOT EXISTS (SELECT *
                                                           FROM points
                                                          WHERE PARENT = p.mid AND cod = 0 AND (ind < 3 OR mid IN (SELECT mid
                                                                                                                     FROM feeders)))
    ORDER BY norder, 6, 4;
  ELSE
   OPEN acur_t FOR
    SELECT   1 havechild, p.mid, DECODE (p.ind, 1, 1, 2, 2, 3, 3, 4) TYPE, p.NAME, p.short_name, DECODE (p.ind, 1, 1, 2, 1, 3), NVL (f.er_position, 0) er_position,
             NVL (f.q1_position, 0) q1_position, NVL (f.ed_position, 0) ed_position, NVL (f.q3_position, 0) q3_position, DECODE (f.smart, '*', 1, 0) smart,
             DECODE (f.q1234, '*', 1, 0) q, NVL (f.canal, 0) canal, f.cellnum, NVL (f.POWER, 0) POWER, NVL (f.power2, 0) power2, NVL (f.current1, 1) current1,
             NVL (f.current2, 1) current2, NVL (f.kc, 1) kc, NVL (f.metkc, 1) metkc, p.tag, vinfo, NVL (f.nabc, 0) nabc, NVL (f.ncalcbill, 0) ncalcbill,
             NVL (f.ncalcmonths, 0) ncalcmonths, NVL (f.ninverted, 0) ninverted, NVL (f.nswitch, 0) nswitch, NVL (f.nlockswitch, 0) nlockswitch, NVL (f.nwastepercentcalc, 0) nwastepercentcalc,
             f.nworkinghours, f.nfullhours, f.line_loss, f.act_loss, f.react_loss, NVL (nrecompens, 0) nrecompens, f.nusd usdmid,
             util_pg.get_pointname (f.nusd, 2) usdtext, f.nblock, NVL (f.ncalcpointtype, 0) ncalcpointtype, util_pg.get_curr_power (p.mid) ncurrpower,
             util_pg.get_months_consumpt (p.mid) nmonthconsumpt, f.ndataabsence dataabs, f.ncommcontrol commcontr, f.ntechcontrol techcontr, f.nmainpoint mainmid,
             util_pg.get_pointname (f.nmainpoint, 2) maintext, f.verifyparam, f.vaddparams, f.vimportcode, NVL (f.nlockcorrecttime, 0) nlockcorrecttime, f.vcode,
             f.verifyday, NVL (f.nclasstn, 1 / 2) nclasstn, NVL (f.nclasstt, 1 / 2) nclasstt, NVL (f.ntimezonew, 2) ntimezonew, NVL (f.ntimezones, 3) ntimezones,
             f.nopposite oppositemid, util_pg.get_pointname (f.nopposite, 2) opposite, p.norder, NVL (editfeeders_pg.formulameas_p (p.mid), ' ') formula, t.vname vsource
             ,f.NINTEGRALPERIOD
        FROM points p, feeders f, sourcetypes t
       WHERE p.PARENT = an_mid AND p.cod = 0 AND (p.ind < 3 OR p.mid IN (SELECT mid
                                                                           FROM feeders)) AND p.mid = f.mid(+)
             AND EXISTS (SELECT *
                           FROM points
                          WHERE PARENT = p.mid AND cod = 0 AND (ind < 3 OR mid IN (SELECT mid
                                                                                     FROM feeders)))
             AND p.ptype = t.ptype(+)
    UNION ALL
    SELECT   0 havechild, p.mid, DECODE (p.ind, 1, 1, 2, 2, 3, 3, 4), p.NAME, p.short_name, DECODE (p.ind, 1, 1, 2, 1, 3), NVL (f.er_position, 0),
             NVL (f.q1_position, 0), NVL (f.ed_position, 0), NVL (f.q3_position, 0), DECODE (f.smart, '*', 1, 0), DECODE (f.q1234, '*', 1, 0), NVL (f.canal, 0),
             f.cellnum, NVL (f.POWER, 0), NVL (f.power2, 0), NVL (f.current1, 1), NVL (f.current2, 1), NVL (f.kc, 1), NVL (f.metkc, 1), p.tag, vinfo,
             NVL (f.nabc, 0), NVL (f.ncalcbill, 0), NVL (f.ncalcmonths, 0), NVL (f.ninverted, 0), NVL (f.nswitch, 0), NVL (f.nlockswitch, 0) nlockswitch, NVL (f.nwastepercentcalc, 0), f.nworkinghours,
             f.nfullhours, f.line_loss, f.act_loss, f.react_loss, NVL (nrecompens, 0) nrecompens, f.nusd, util_pg.get_pointname (f.nusd, 2), f.nblock,
             NVL (f.ncalcpointtype, 0) ncalcpointtype, util_pg.get_curr_power (p.mid) ncurrpower, util_pg.get_months_consumpt (p.mid) nmonthconsumpt,
             f.ndataabsence dataabs, f.ncommcontrol commcontr, f.ntechcontrol techcontr, f.nmainpoint mainmid, util_pg.get_pointname (f.nmainpoint, 2),
             f.verifyparam, f.vaddparams, f.vimportcode, NVL (f.nlockcorrecttime, 0), f.vcode, f.verifyday, NVL (f.nclasstn, 1 / 2) nclasstn,
             NVL (f.nclasstt, 1 / 2) nclasstt, NVL (f.ntimezonew, 2) ntimezonew, NVL (f.ntimezones, 3) ntimezones, f.nopposite oppositemid,
             util_pg.get_pointname (f.nopposite, 2) opposite, p.norder, NVL (editfeeders_pg.formulameas_p (p.mid), ' ') formula, t.vname vsource,
             f.NINTEGRALPERIOD
        FROM points p, feeders f, sourcetypes t
       WHERE p.PARENT = an_mid AND p.cod = 0 AND (p.ind < 3 OR p.mid IN (SELECT mid
                                                                           FROM feeders)) AND p.mid = f.mid(+)
             AND NOT EXISTS (SELECT *
                               FROM points
                              WHERE PARENT = p.mid AND cod = 0 AND (ind < 3 OR mid IN (SELECT mid
                                                                                         FROM feeders)))
             AND p.ptype = t.ptype(+)
    ORDER BY norder, 6, 4;
  END IF;
 END;

-----------------------------------------------------------------------------------------------------------------------
 PROCEDURE readcounter_p (an_mid NUMBER, acur_t OUT common_pg.tcur) IS
 BEGIN
  OPEN acur_t FOR
   SELECT   p.mid, m.ID, m.NAME, m.mtrsn, m.entype, TO_CHAR (NVL (m.date_time, SYSDATE), 'dd.mm.yyyy') date_count, m.DIGITS, m.mtype, m.mcurrent, m.mpower,
            m.mconst, m.mclass, m.myear, m.mquarter, m.POSITION, p.norder
       FROM meters m, points p
      WHERE m.mid = p.mid AND p.PARENT = an_mid
   ORDER BY norder, DECODE (p.ind, 1, 1, 2, 1, 3), p.NAME, m.NAME, m.entype;
 END;

---------------------------------------------------------------------------------------------------------------
 PROCEDURE readlossts_p (an_mid NUMBER, acur_t OUT common_pg.tcur) IS
 BEGIN
  OPEN acur_t FOR
   SELECT   1 nsobst, c.nconnectionparam, c.mid, c.vname, c.nsn, c.nsh, c.ndeltapidling, c.ndeltapsc, c.niidling, c.nusc, c.nro, c.nxo, c.nl, c.nun,
            c.nenergypercent, c.nworkinghours, c.nfullhours, c.nnotincludeconsump, c.nparallelconnection, c.nrenergypercent, c.nprocent,
            util_pg.get_loss_info (c.nconnectionparam, c.mid) linf, p.mid, p.NAME
       FROM connectionparam c, points p
      WHERE p.mid = c.mid AND p.PARENT = an_mid
   UNION ALL
   SELECT   0 nsobst, c.nconnectionparam, s.mid, c.vname, c.nsn, c.nsh, c.ndeltapidling, c.ndeltapsc, c.niidling, c.nusc, c.nro, c.nxo, c.nl, c.nun,
            c.nenergypercent, c.nworkinghours, c.nfullhours, s.nnotincludeconsump, c.nparallelconnection, c.nrenergypercent, c.nprocent,
            util_pg.get_loss_info (s.nconnectionparam, s.mid) linf, p.mid, p.NAME
       FROM connectionparam c, sharedconnectionparam s, points p
      WHERE s.mid = p.mid AND s.nconnectionparam = c.nconnectionparam(+) AND p.PARENT = an_mid
   ORDER BY 24, 1 DESC, 4, 2;
 END;

---------------------------------------------------------------------------------------------------------------
 PROCEDURE readgroup_p (an_mid NUMBER, acur_t OUT common_pg.tcur) IS
 BEGIN
  OPEN acur_t FOR
   SELECT   c.gid, g.NAME, p.mid
       FROM calcpointbygroup c, GROUPS g, points p
      WHERE g.gid = c.gid AND p.mid = c.mid(+) AND p.PARENT = an_mid
   ORDER BY 3;
 END;

---------------------------------------------------------------------------------------------------------------------
 PROCEDURE smart_p (an_mid NUMBER, av_sm OUT VARCHAR2) IS
 BEGIN
  SELECT MAX (smart) sm
    INTO av_sm
    FROM meters
   WHERE mid = an_mid AND ROWNUM = 1;
 END;

---------------------------------------------------------------------------------------
 PROCEDURE get_submenu_p (an_fid NUMBER, an_monitor NUMBER, an_gid NUMBER, acur_t OUT common_pg.tcur) IS
  lv_sub   VARCHAR2 (100);
  lv_sql   VARCHAR2 (1000);
 BEGIN
  IF an_fid <> 0 THEN
   lv_sub := ' PARENT = :par1 ';
  ELSE
   lv_sub := ' PARENT IS NULL ';
  END IF;

  lv_sql :=
   ' SELECT DISTINCT DECODE (f.codetemplate, NULL, 1, 0) CHILD, f.fid,
                f.codetemplate, f.nameform, f.commentform, f.enablecontrols,
                f.stepprofile, f.namealert, f.vprocname,:par3,f.mid
           FROM forms f
          WHERE '
   || lv_sub
   || ' AND monitor = :par2
     CONNECT BY PRIOR PARENT = fid
     START WITH SUBSTR (enablecontrols, 7, 1) = ''1'' AND
((f.CODETEMPLATE NOT IN (1200,1201,1202,1203,1206)) OR (f.CODETEMPLATE IN (1200,1201,1202,1203,1206)
 AND (f.mid IS NULL OR f.mid IN (SELECT mid FROM points CONNECT BY PRIOR parent=mid START WITH mid=:par3)) ))
 ORDER BY 1, nameform DESC ';

  IF an_fid <> 0 THEN
   OPEN acur_t FOR lv_sql USING an_gid, an_fid, an_monitor, an_gid;
  ELSE
   OPEN acur_t FOR lv_sql USING an_gid, an_monitor, an_gid;
  END IF;
 END;

-------------------------------------------------------------------------------------------------------
 PROCEDURE nmainpoint_p (an_mid NUMBER, acur_t OUT common_pg.tcur) IS
 BEGIN
  OPEN acur_t FOR
   SELECT mid, util_pg.get_pointname (mid, 1) NAME
     FROM feeders
    WHERE nmainpoint = an_mid;
 END;

-------------------------------------------------------------------------------------------------------------
 PROCEDURE nopposite_p (an_mid NUMBER, acur_t OUT common_pg.tcur) IS
 BEGIN
  OPEN acur_t FOR
   SELECT mid, util_pg.get_pointname (mid, 1) NAME
     FROM feeders
    WHERE nopposite = an_mid;
 END;

--------------------------------------------------------------------------------------------------------------
--возвращает измерения и их глобальные индексы для конкретной точки
--Виленская Н.Б. 14.11.2008
 PROCEDURE get_measure (an_mid NUMBER, an_objtype NUMBER, acur_t OUT common_pg.tcur) IS
 BEGIN
  OPEN acur_t FOR
   SELECT   s.vname, m.mrid, s.nmeasure, an_mid mid
       FROM mrids m, MEASURES s
      WHERE s.nmeasure = m.nmeasure(+) AND an_mid = m.mid(+) AND s.nmrid = 1
   ORDER BY 3;
 END;

-----------------------------------------------------------------------------------------------------------------------
--Сохранение глобальных индексов
 PROCEDURE ins_guid (an_mid NUMBER, an_nmeasure common_pg.tt_number, an_mrid common_pg.tt_varchar2) IS
 BEGIN
  DELETE FROM mrids
        WHERE mid = an_mid;

  IF an_nmeasure.COUNT > 0 THEN
   FOR i IN 1 .. an_nmeasure.COUNT - 1 LOOP
    IF (an_mrid IS NOT NULL) THEN
     INSERT INTO mrids
                 (mid, nmeasure, mrid
                 )
          VALUES (an_mid, an_nmeasure (i), an_mrid (i)
                 );
    END IF;
   END LOOP;
  END IF;
 END;

-----------------------------------------------------------------------------------------------------------------
 FUNCTION formulameas_p (an_mid NUMBER)
  RETURN VARCHAR2 IS
  lc_meas    common_pg.tcur;
  lv_nmeas   VARCHAR2 (100) DEFAULT ' ';
  lv_row     VARCHAR2 (100) DEFAULT ' ';
 BEGIN
  OPEN lc_meas FOR
   SELECT DECODE (a.nmeas, 0, 'Общая', 1, 'A+', 2, 'A-', 3, 'R+', 5, 'R-', ' ')
     INTO lv_nmeas
     FROM pointformula a
    WHERE a.mid = an_mid;

  LOOP
   FETCH lc_meas
    INTO lv_row;

   EXIT WHEN lc_meas%NOTFOUND;

   IF lc_meas%ROWCOUNT = 1 THEN
    lv_nmeas := lv_row;
   ELSE
    lv_nmeas := lv_nmeas || '; ' || lv_row;
   END IF;
  END LOOP;

  CLOSE lc_meas;

  RETURN lv_nmeas;
 END;
------------------------------------------------------------------------------------------------- 
 -- added by KAG 27.01.2010
 -- список базовых периодов интеграции
 PROCEDURE IntegratorTimes_p (acur_t OUT common_pg.tcur) IS
 BEGIN
  OPEN acur_t FOR
      SELECT 1 NINTEGRALPERIOD FROM dual
      UNION ALL 
      SELECT 2 NINTEGRALPERIOD FROM dual
      UNION ALL 
      SELECT 3 NINTEGRALPERIOD FROM dual
      UNION ALL 
      SELECT 5 NINTEGRALPERIOD FROM dual
      UNION ALL 
      SELECT 10 NINTEGRALPERIOD FROM dual
      UNION ALL 
      SELECT 15 NINTEGRALPERIOD FROM dual
      UNION ALL 
      SELECT 30 NINTEGRALPERIOD FROM dual
      UNION ALL 
      SELECT 60 NINTEGRALPERIOD FROM dual;      
 END;
-------------------------------------------------------------------------------------------------
END;   -- Package Body
/


-- End of DDL Script for Package Body RYDA.EDITFEEDERS_PG

-- Start of DDL Script for Package Body RYDA.COMSRV_PG
-- Generated 17.07.2012 10:14:18 from RYDA@test2

CREATE OR REPLACE 
PACKAGE BODY comsrv_pg IS
------------------------------------------------------------------------------------------------------------------------
   -- Интерфейс взаимодействия БД с Носиком А.В.
   -- дата создания 30/11/2001 Сечин А.А.
------------------------------------------------------------------------------------------------------------------------
 cn_roundalpha   CONSTANT NUMBER := 6;
 cn_roundrtu     CONSTANT NUMBER := 5;
 cn_roundall     CONSTANT NUMBER := 5;

------------------------------------------------------------------------------------------------------------------------
 PROCEDURE set_abc_zxb (an_mid NUMBER, an_volt1 NUMBER, an_volt2 NUMBER, an_volt3 NUMBER, ad_date DATE);

------------------------------------------------------------------------------------------------------------------------
--******************************          Общие процедуры      *******************************************************--
------------------------------------------------------------------------------------------------------------------------
   --Вставка суточных расходов (Єнергия меркурий облик и.т.д. только расход)
 PROCEDURE set_bill_eom (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, an_aer NUMBER, an_aed NUMBER,
 an_aq1 NUMBER, an_aq3 NUMBER, an_aq2 NUMBER, an_aq4 NUMBER, an_ber NUMBER, an_bed NUMBER, an_bq1 NUMBER, an_bq3 NUMBER, an_bq2 NUMBER, an_bq4 NUMBER,
 an_cer NUMBER, an_ced NUMBER, an_cq1 NUMBER, an_cq3 NUMBER, an_cq2 NUMBER, an_cq4 NUMBER, an_der NUMBER, an_ded NUMBER, an_dq1 NUMBER, an_dq3 NUMBER,
 an_dq2 NUMBER, an_dq4 NUMBER, av_mtrsn VARCHAR2, ad_date DATE, an_source NUMBER
 ) IS
  ln_er       NUMBER         DEFAULT an_er;
  ln_ed       NUMBER         DEFAULT an_ed;
  ln_q1       NUMBER         DEFAULT an_q1;
  ln_q3       NUMBER         DEFAULT an_q3;
  ln_q2       NUMBER         DEFAULT an_q2;
  ln_q4       NUMBER         DEFAULT an_q4;
  ln_aer      NUMBER         DEFAULT an_aer;
  ln_aed      NUMBER         DEFAULT an_aed;
  ln_aq1      NUMBER         DEFAULT an_aq1;
  ln_aq3      NUMBER         DEFAULT an_aq3;
  ln_aq2      NUMBER         DEFAULT an_aq2;
  ln_aq4      NUMBER         DEFAULT an_aq4;
  ln_ber      NUMBER         DEFAULT an_ber;
  ln_bed      NUMBER         DEFAULT an_bed;
  ln_bq1      NUMBER         DEFAULT an_bq1;
  ln_bq3      NUMBER         DEFAULT an_bq3;
  ln_bq2      NUMBER         DEFAULT an_bq2;
  ln_bq4      NUMBER         DEFAULT an_bq4;
  ln_cer      NUMBER         DEFAULT an_cer;
  ln_ced      NUMBER         DEFAULT an_ced;
  ln_cq1      NUMBER         DEFAULT an_cq1;
  ln_cq3      NUMBER         DEFAULT an_cq3;
  ln_cq2      NUMBER         DEFAULT an_cq2;
  ln_cq4      NUMBER         DEFAULT an_cq4;
  ln_der      NUMBER         DEFAULT an_der;
  ln_ded      NUMBER         DEFAULT an_ded;
  ln_dq1      NUMBER         DEFAULT an_dq1;
  ln_dq3      NUMBER         DEFAULT an_dq3;
  ln_dq2      NUMBER         DEFAULT an_dq2;
  ln_dq4      NUMBER         DEFAULT an_dq4;
  lv_mtrsn    VARCHAR2 (128) DEFAULT TRIM (av_mtrsn);
  ln_source   NUMBER         DEFAULT NVL (an_source, cn_auto);
 BEGIN
  util_pg.chdr (an_mid, ln_er, ln_ed, ln_q1, ln_q3, ln_q2, ln_q4);
  util_pg.chdr (an_mid, ln_aer, ln_aed, ln_aq1, ln_aq3, ln_aq2, ln_aq4);
  util_pg.chdr (an_mid, ln_ber, ln_bed, ln_bq1, ln_bq3, ln_bq2, ln_bq4);
  util_pg.chdr (an_mid, ln_cer, ln_ced, ln_cq1, ln_cq3, ln_cq2, ln_cq4);
  util_pg.chdr (an_mid, ln_der, ln_ded, ln_dq1, ln_dq3, ln_dq2, ln_dq4);

  IF lv_mtrsn IS NULL THEN
   SELECT MAX (mtrsn)
     INTO lv_mtrsn
     FROM meters
    WHERE mid = an_mid AND entype = 7;
  END IF;

  INSERT INTO billorg
              (mid, er, ed, q1, q3, q2, q4, aer, aed, aq1, aq3, aq2, aq4, ber, bed, bq1, bq3, bq2, bq4,
               cer, ced, cq1, cq3, cq2, cq4, der, ded, dq1, dq3, dq2, dq4, date_time, SOURCE, nsource, er_mtrsn, ed_mtrsn,
               q1_mtrsn, q3_mtrsn, q2_mtrsn, q4_mtrsn
              )
       VALUES (an_mid, ln_er, ln_ed, ln_q1, ln_q3, ln_q2, ln_q4, ln_aer, ln_aed, ln_aq1, ln_aq3, ln_aq2, ln_aq4, ln_ber, ln_bed, ln_bq1, ln_bq3, ln_bq2, ln_bq4,
               ln_cer, ln_ced, ln_cq1, ln_cq3, ln_cq2, ln_cq4, ln_der, ln_ded, ln_dq1, ln_dq3, ln_dq2, ln_dq4, ad_date, 'КС', ln_source, lv_mtrsn, lv_mtrsn,
               lv_mtrsn, lv_mtrsn, lv_mtrsn, lv_mtrsn
              );
 EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
   UPDATE billorg
      SET (er, ed, q1, q3, q2, q4, aer, aed, aq1, aq3, aq2, aq4, ber, bed, bq1, bq3, bq2, bq4, cer, ced, cq1, cq3, cq2, cq4, der, ded, dq1, dq3, dq2, dq4) =
           (SELECT ln_er, ln_ed, ln_q1, ln_q3, ln_q2, ln_q4, ln_aer, ln_aed, ln_aq1, ln_aq3, ln_aq2, ln_aq4, ln_ber, ln_bed, ln_bq1, ln_bq3, ln_bq2, ln_bq4, ln_cer,
                   ln_ced, ln_cq1, ln_cq3, ln_cq2, ln_cq4, ln_der, ln_ded, ln_dq1, ln_dq3, ln_dq2, ln_dq4
              FROM DUAL)
    WHERE mid = an_mid AND date_time = ad_date AND nsource = ln_source;
  WHEN OTHERS THEN
   raise_application_error (-20001, 'comsrv_pg.set_bill_eom: ' || SQLERRM (SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
   --Вставка месячных расходов
 PROCEDURE set_months_eom (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, an_aer NUMBER, an_aed NUMBER,
 an_aq1 NUMBER, an_aq3 NUMBER, an_aq2 NUMBER, an_aq4 NUMBER, an_ber NUMBER, an_bed NUMBER, an_bq1 NUMBER, an_bq3 NUMBER, an_bq2 NUMBER, an_bq4 NUMBER, an_cer NUMBER,
 an_ced NUMBER, an_cq1 NUMBER, an_cq3 NUMBER, an_cq2 NUMBER, an_cq4 NUMBER, an_der NUMBER, an_ded NUMBER, an_dq1 NUMBER, an_dq3 NUMBER, an_dq2 NUMBER, an_dq4 NUMBER,
 av_mtrsn VARCHAR2, ad_date DATE
 ) IS
  ln_er      NUMBER         DEFAULT an_er;
  ln_ed      NUMBER         DEFAULT an_ed;
  ln_q1      NUMBER         DEFAULT an_q1;
  ln_q3      NUMBER         DEFAULT an_q3;
  ln_q2      NUMBER         DEFAULT an_q2;
  ln_q4      NUMBER         DEFAULT an_q4;
  ln_aer     NUMBER         DEFAULT an_aer;
  ln_aed     NUMBER         DEFAULT an_aed;
  ln_aq1     NUMBER         DEFAULT an_aq1;
  ln_aq3     NUMBER         DEFAULT an_aq3;
  ln_aq2     NUMBER         DEFAULT an_aq2;
  ln_aq4     NUMBER         DEFAULT an_aq4;
  ln_ber     NUMBER         DEFAULT an_ber;
  ln_bed     NUMBER         DEFAULT an_bed;
  ln_bq1     NUMBER         DEFAULT an_bq1;
  ln_bq3     NUMBER         DEFAULT an_bq3;
  ln_bq2     NUMBER         DEFAULT an_bq2;
  ln_bq4     NUMBER         DEFAULT an_bq4;
  ln_cer     NUMBER         DEFAULT an_cer;
  ln_ced     NUMBER         DEFAULT an_ced;
  ln_cq1     NUMBER         DEFAULT an_cq1;
  ln_cq3     NUMBER         DEFAULT an_cq3;
  ln_cq2     NUMBER         DEFAULT an_cq2;
  ln_cq4     NUMBER         DEFAULT an_cq4;
  ln_der     NUMBER         DEFAULT an_der;
  ln_ded     NUMBER         DEFAULT an_ded;
  ln_dq1     NUMBER         DEFAULT an_dq1;
  ln_dq3     NUMBER         DEFAULT an_dq3;
  ln_dq2     NUMBER         DEFAULT an_dq2;
  ln_dq4     NUMBER         DEFAULT an_dq4;
  lv_mtrsn   VARCHAR2 (128);
 BEGIN
  util_pg.chdr (an_mid, ln_er, ln_ed, ln_q1, ln_q3, ln_q2, ln_q4);
  util_pg.chdr (an_mid, ln_aer, ln_aed, ln_aq1, ln_aq3, ln_aq2, ln_aq4);
  util_pg.chdr (an_mid, ln_ber, ln_bed, ln_bq1, ln_bq3, ln_bq2, ln_bq4);
  util_pg.chdr (an_mid, ln_cer, ln_ced, ln_cq1, ln_cq3, ln_cq2, ln_cq4);
  util_pg.chdr (an_mid, ln_der, ln_ded, ln_dq1, ln_dq3, ln_dq2, ln_dq4);

  SELECT NVL (TRIM (av_mtrsn), MAX (mtrsn))
    INTO lv_mtrsn
    FROM meters
   WHERE mid = an_mid AND entype = 7;

  INSERT INTO monthsorg
              (mid, er, ed, q1, q3, q2, q4, aer, aed, aq1, aq3, aq2, aq4, ber, bed, bq1, bq3, bq2, bq4,
               cer, ced, cq1, cq3, cq2, cq4, der, ded, dq1, dq3, dq2, dq4, date_time, SOURCE, nsource, er_mtrsn, ed_mtrsn, q1_mtrsn,
               q3_mtrsn, q2_mtrsn, q4_mtrsn
              )
       VALUES (an_mid, ln_er, ln_ed, ln_q1, ln_q3, ln_q2, ln_q4, ln_aer, ln_aed, ln_aq1, ln_aq3, ln_aq2, ln_aq4, ln_ber, ln_bed, ln_bq1, ln_bq3, ln_bq2, ln_bq4,
               ln_cer, ln_ced, ln_cq1, ln_cq3, ln_cq2, ln_cq4, ln_der, ln_ded, ln_dq1, ln_dq3, ln_dq2, ln_dq4, ad_date, 'КС', cn_auto, lv_mtrsn, lv_mtrsn, lv_mtrsn,
               lv_mtrsn, lv_mtrsn, lv_mtrsn
              );
 EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
   UPDATE monthsorg
      SET (er, ed, q1, q3, q2, q4, aer, aed, aq1, aq3, aq2, aq4, ber, bed, bq1, bq3, bq2, bq4, cer, ced, cq1, cq3, cq2, cq4, der, ded, dq1, dq3, dq2, dq4) =
           (SELECT ln_er, ln_ed, ln_q1, ln_q3, ln_q2, ln_q4, ln_aer, ln_aed, ln_aq1, ln_aq3, ln_aq2, ln_aq4, ln_ber, ln_bed, ln_bq1, ln_bq3, ln_bq2, ln_bq4, ln_cer,
                   ln_ced, ln_cq1, ln_cq3, ln_cq2, ln_cq4, ln_der, ln_ded, ln_dq1, ln_dq3, ln_dq2, ln_dq4
              FROM DUAL)
    WHERE mid = an_mid AND date_time = ad_date AND nsource = cn_auto;
  WHEN OTHERS THEN
   raise_application_error (-20001, 'comsrv_pg.set_months_eom: ' || SQLERRM (SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
 --Сверка номера счетчика (Если возвращает не 0 то отваливаем и переходим к другому счетчику)
 FUNCTION check_mtrsn (an_mid NUMBER, av_mtrsn VARCHAR2)
  RETURN NUMBER IS
 BEGIN
  RETURN 0;
 END;

------------------------------------------------------------------------------------------------------------------------
--Проседура приведения формата углов счетчика к абсолютным углам
/*
an_typeconvert - 1  преобразуем sl-7000
an_typeconvert - 2  преобразуем ARGO
an_typeconvert - 3  Не преобразуем
an_typeconvert - 4  преобразуем ZxD СЭС
Иначе не преобразуем
*/
 PROCEDURE convert_corners (an_typeconvert NUMBER, an_u1 IN OUT NUMBER, an_u2 IN OUT NUMBER, an_u3 IN OUT NUMBER, an_i1 IN OUT NUMBER, an_i2 IN OUT NUMBER,
 an_i3 IN OUT NUMBER
 ) IS
  ln_u1   NUMBER DEFAULT an_u1;
  ln_u2   NUMBER DEFAULT an_u2;
  ln_u3   NUMBER DEFAULT an_u3;
  ln_i1   NUMBER DEFAULT an_i1;
  ln_i2   NUMBER DEFAULT an_i2;
  ln_i3   NUMBER DEFAULT an_i3;
 BEGIN
  IF an_typeconvert = 1 THEN   -- Schlum (SL7000)
   /* - an_fiu1 - угол между U2 и U1, а надо U1
      - an_fiu2 - угол между U3 и U1, а надо U2
      - an_fiu3 - угол между U2 и U3, а надо U3
      - an_fii1 - угол между I1 и U1, а надо I1
      - an_fii2 - угол между I2 и U2, а надо I2
      - an_fii3 - угол между I3 и U3, а надо I3    */
   an_u1 := 0;
   an_u2 := ln_u1;
   an_u3 := ln_u1 + ln_u3;
   an_i1 := an_u1 + ln_i1;
   an_i2 := an_u2 + ln_i2;
   an_i3 := an_u3 + ln_i3;
  ELSIF an_typeconvert = 2 THEN   -- ARGO
   /* - an_fiu1 - NULL (подразумевается   0), а надо U1 (  0)
      - an_fiu2 - NULL (подразумевается 120), а надо U2 (120)
      - an_fiu3 - NULL (подразумевается 240), а надо U3 (240)
      - an_fii1 - угол между I1 и U1, а надо I1
      - an_fii2 - угол между I2 и U2, а надо I2
      - an_fii3 - угол между I3 и U3, а надо I3    */
   an_u1 := 0;
   an_u2 := 120;
   an_u3 := 240;
   an_i1 := ln_u1 + ln_i1;
   an_i2 := ln_u2 + ln_i2;
   an_i3 := ln_u3 + ln_i3;
  ELSIF an_typeconvert = 4 THEN   -- ZxD с СЭС
   /* - an_fii1 - угол между I1 и U1, а надо I1
      - an_fii2 - угол между I2 и U2, а надо I2
      - an_fii3 - угол между I3 и U3, а надо I3    */
   an_i1 := ln_u1 + ln_i1;
   an_i2 := ln_u2 + ln_i2;
   an_i3 := ln_u3 + ln_i3;
  ELSE
   an_u1 := 0;
  END IF;

  --Убираем обороты
  an_u1 := MOD (an_u1, 360);
  an_u2 := MOD (an_u2, 360);
  an_u3 := MOD (an_u3, 360);
  an_i1 := MOD (an_i1, 360);
  an_i2 := MOD (an_i2, 360);
  an_i3 := MOD (an_i3, 360);

  --Делаем все от [0:360]
  IF an_u1 < 0 THEN
   an_u1 := 360 + an_u1;
  END IF;

  IF an_u2 < 0 THEN
   an_u2 := 360 + an_u2;
  END IF;

  IF an_u3 < 0 THEN
   an_u3 := 360 + an_u3;
  END IF;

  IF an_i1 < 0 THEN
   an_i1 := 360 + an_i1;
  END IF;

  IF an_i2 < 0 THEN
   an_i2 := 360 + an_i2;
  END IF;

  IF an_i3 < 0 THEN
   an_i3 := 360 + an_i3;
  END IF;
 END;

------------------------------------------------------------------------------------------------------------------------
 PROCEDURE signal (an_signal NUMBER) IS
 BEGIN
  admin_pg.signal (an_signal);
 END;

------------------------------------------------------------------------------------------------------------------------
--Возвращает признак необходимость коррекции времени и допустимый диапазон (Если an_cid>0, то проверяет канал, an_mid>0, то проверяет точку)
 PROCEDURE get_timeinfo (an_cid NUMBER, an_mid NUMBER, an_min_delta OUT NUMBER, an_max_delta OUT NUMBER, an_clock_set OUT NUMBER) IS
  ln_clock_set   NUMBER;
 BEGIN
  SELECT NVL (MAX (min_delta), 120), NVL (MAX (max_delta), 360), DECODE (NVL (MAX (clock_set), ' '), '*', 1, 0)
    INTO an_min_delta, an_max_delta, ln_clock_set
    FROM cs_profile;

  IF an_cid > 0 AND ln_clock_set = 1 THEN
   SELECT DECODE (MAX (nlockcorrecttime), 1, 0, 1)
     INTO ln_clock_set
     FROM channels
    WHERE cid = an_cid;
  END IF;

  IF an_mid > 0 AND ln_clock_set = 1 THEN
   SELECT DECODE (MAX (nlockcorrecttime), 1, 0, 1)
     INTO ln_clock_set
     FROM feeders
    WHERE mid = an_mid;
  END IF;

  an_clock_set := ln_clock_set;
 END;

------------------------------------------------------------------------------------------------------------------------
--Возвращает информацию по программироваению времени счетчика (часовые пояса)
 PROCEDURE get_wstimeinfo(an_mid NUMBER, an_timezonew OUT NUMBER, an_timezones OUT NUMBER) IS
 BEGIN
  SELECT NVL(MAX(ntimezonew), util_pg.cn_tzw), NVL(MAX(ntimezones), util_pg.cn_tzs)
  INTO   an_timezonew, an_timezones
  FROM   feeders
  WHERE  mid = an_mid;
 END;

------------------------------------------------------------------------------------------------------------------------
 PROCEDURE set_traffic (an_cid NUMBER, ad_open DATE, ad_start DATE, ad_end DATE, an_send NUMBER, an_recv NUMBER, av_user VARCHAR2) IS
 BEGIN
  IF util_pg.locksysjournal_f = 1 THEN
   RETURN;
  END IF;

  UPDATE traffic
     SET dstart = ad_start,
         dend = ad_end,
         nsend = an_send,
         nreceived = an_recv,
         vuser = av_user
   WHERE cid = an_cid AND dopen = ad_open;

  IF SQL%ROWCOUNT = 0 THEN
   INSERT INTO traffic
        VALUES (an_cid, ad_open, ad_start, ad_end, an_send, an_recv, av_user);
  END IF;
 END;

------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
 --Вставка текущих
 PROCEDURE set_curr_power_meter (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, ad_date DATE) IS
  ln_rn     NUMBER DEFAULT 5;
  ln_kc     NUMBER;
  ln_erm    NUMBER DEFAULT an_erm;
  ln_edm    NUMBER DEFAULT an_edm;
  ln_q1m    NUMBER DEFAULT an_q1m;
  ln_q3m    NUMBER DEFAULT an_q3m;
  ln_q2m    NUMBER DEFAULT an_q2m;
  ln_q4m    NUMBER DEFAULT an_q4m;
  ln_er     NUMBER;
  ln_ed     NUMBER;
  ln_q1     NUMBER;
  ln_q3     NUMBER;
  ln_q2     NUMBER;
  ln_q4     NUMBER;
  ln_oerm   NUMBER;
  ln_oedm   NUMBER;
  ln_oq1m   NUMBER;
  ln_oq3m   NUMBER;
  ln_oq2m   NUMBER;
  ln_oq4m   NUMBER;
  ln_k      NUMBER;
  ld_date   DATE   DEFAULT SYSDATE;
 BEGIN
  util_pg.chdr (an_mid, ln_erm, ln_edm, ln_q1m, ln_q3m, ln_q2m, ln_q4m);

  SELECT 24 * MAX (ld_date - date_time) dt, NVL (MAX (erm), 0), NVL (MAX (edm), 0), NVL (MAX (q1m), 0), NVL (MAX (q3m), 0), NVL (MAX (q2m), 0), NVL (MAX (q4m), 0)
    INTO ln_k, ln_oerm, ln_oedm, ln_oq1m, ln_oq3m, ln_oq2m, ln_oq4m
    FROM curr_power
   WHERE mid = an_mid;

  IF util_pg.get_typecalcpower (an_mid) = 1 AND ln_k > 0 THEN
   SELECT NVL (MAX (kc), 1)
     INTO ln_kc
     FROM feeders
    WHERE mid = an_mid;

   ln_er := ROUND (ln_kc * util_pg.indicoverturn (ln_erm - ln_oerm, NULL) / ln_k, ln_rn);
   ln_ed := ROUND (ln_kc * util_pg.indicoverturn (ln_edm - ln_oedm, NULL) / ln_k, ln_rn);
   ln_q1 := ROUND (ln_kc * util_pg.indicoverturn (ln_q1m - ln_oq1m, NULL) / ln_k, ln_rn);
   ln_q3 := ROUND (ln_kc * util_pg.indicoverturn (ln_q3m - ln_oq3m, NULL) / ln_k, ln_rn);
   ln_q2 := ROUND (ln_kc * util_pg.indicoverturn (ln_q2m - ln_oq2m, NULL) / ln_k, ln_rn);
   ln_q4 := ROUND (ln_kc * util_pg.indicoverturn (ln_q4m - ln_oq4m, NULL) / ln_k, ln_rn);
  END IF;

  UPDATE curr_power
     SET erm = ln_erm,
         edm = ln_edm,
         q1m = ln_q1m,
         q3m = ln_q3m,
         q2m = ln_q2m,
         q4m = ln_q4m,
         er = ln_er,
         ed = ln_ed,
         q1 = ln_q1,
         q3 = ln_q3,
         q2 = ln_q2,
         q4 = ln_q4,
         cosf = NULL,
         volt = NULL,
         volt2 = NULL,
         volt3 = NULL,
         currento = NULL,
         curr2 = NULL,
         curr3 = NULL,
         nfiu1 = NULL,
         nfiu2 = NULL,
         nfiu3 = NULL,
         nfii1 = NULL,
         nfii2 = NULL,
         nfii3 = NULL,
         obsolete = 0,
         date_time = ld_date
   WHERE mid = an_mid;

  das_pg.insert_cp_in_profile (an_mid);
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error (-20001, 'comsrv_pg.set_curr_power_meter: ' || SQLERRM (SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
--Вставка текущих
 PROCEDURE set_curr_power_meter (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_freq NUMBER,
 an_cos_fi NUMBER, an_volt1 NUMBER, an_volt2 NUMBER, an_volt3 NUMBER, an_curr1 NUMBER, an_curr2 NUMBER, an_curr3 NUMBER, an_fii1 NUMBER, an_fii2 NUMBER,
 an_fii3 NUMBER, an_fiu1 NUMBER, an_fiu2 NUMBER, an_fiu3 NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, an_i0 NUMBER,
 an_type NUMBER, ad_date DATE
 ) IS
  ln_erm    NUMBER DEFAULT an_erm;
  ln_edm    NUMBER DEFAULT an_edm;
  ln_q1m    NUMBER DEFAULT an_q1m;
  ln_q3m    NUMBER DEFAULT an_q3m;
  ln_q2m    NUMBER DEFAULT an_q2m;
  ln_q4m    NUMBER DEFAULT an_q4m;
  ln_er     NUMBER DEFAULT an_er;
  ln_ed     NUMBER DEFAULT an_ed;
  ln_q1     NUMBER DEFAULT an_q1;
  ln_q3     NUMBER DEFAULT an_q3;
  ln_q2     NUMBER DEFAULT an_q2;
  ln_q4     NUMBER DEFAULT an_q4;
  ln_fii1   NUMBER DEFAULT an_fii1;
  ln_fii2   NUMBER DEFAULT an_fii2;
  ln_fii3   NUMBER DEFAULT an_fii3;
  ln_fiu1   NUMBER DEFAULT an_fiu1;
  ln_fiu2   NUMBER DEFAULT an_fiu2;
  ln_fiu3   NUMBER DEFAULT an_fiu3;
  ln_kc     NUMBER;
 BEGIN
  convert_corners (an_type, ln_fiu1, ln_fiu2, ln_fiu3, ln_fii1, ln_fii2, ln_fii3);
  util_pg.chdr (an_mid, ln_erm, ln_edm, ln_q1m, ln_q3m, ln_q2m, ln_q4m);
  util_pg.chdr (an_mid, ln_er, ln_ed, ln_q1, ln_q3, ln_q2, ln_q4);

  SELECT NVL (MAX (kc), 1)
    INTO ln_kc
    FROM feeders
   WHERE mid = an_mid;

  ln_er := ln_er * ln_kc;
  ln_ed := ln_ed * ln_kc;
  ln_q1 := ln_q1 * ln_kc;
  ln_q3 := ln_q3 * ln_kc;
  ln_q2 := ln_q2 * ln_kc;
  ln_q4 := ln_q4 * ln_kc;

  UPDATE curr_power
     SET erm = ln_erm,
         edm = ln_edm,
         q1m = ln_q1m,
         q3m = ln_q3m,
         q2m = ln_q2m,
         q4m = ln_q4m,
         obsolete = 0,
         date_time = ad_date,
         freq = an_freq,
         cosf = an_cos_fi,
         volt = an_volt1,
         volt2 = an_volt2,
         volt3 = an_volt3,
         currento = an_curr1,
         curr2 = an_curr2,
         curr3 = an_curr3,
         er = ln_er,
         ed = ln_ed,
         q1 = ln_q1,
         q3 = ln_q3,
         q2 = ln_q2,
         q4 = ln_q4,
         nfiu1 = ln_fiu1,
         nfiu2 = ln_fiu2,
         nfiu3 = ln_fiu3,
         nfii1 = ln_fii1,
         nfii2 = ln_fii2,
         nfii3 = ln_fii3,
         ni0 = an_i0
   WHERE mid = an_mid;

  das_pg.insert_cp_in_profile (an_mid);
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error (-20001, 'comsrv_pg.set_curr_power_meter: ' || SQLERRM (SQLCODE));
 END;

-----------------------------------------------------------------------------------------------------------------------
--Вставка текущих
 PROCEDURE set_curr_power_meter (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_freq NUMBER,
 an_cos_fi NUMBER, an_volt1 NUMBER, an_volt2 NUMBER, an_volt3 NUMBER, an_curr1 NUMBER, an_curr2 NUMBER, an_curr3 NUMBER, an_fii1 NUMBER, an_fii2 NUMBER,
 an_fii3 NUMBER, an_fiu1 NUMBER, an_fiu2 NUMBER, an_fiu3 NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, an_type NUMBER,
 ad_date DATE
 ) IS
 BEGIN
  set_curr_power_meter (an_mid, an_erm, an_edm, an_q1m, an_q3m, an_q2m, an_q4m, an_freq, an_cos_fi, an_volt1, an_volt2, an_volt3, an_curr1, an_curr2, an_curr3,
                        an_fii1, an_fii2, an_fii3, an_fiu1, an_fiu2, an_fiu3, an_er, an_ed, an_q1, an_q3, an_q2, an_q4, NULL, an_type, ad_date);
 END;

-----------------------------------------------------------------------------------------------------------------------
 PROCEDURE set_curr_quality_meter (an_mid NUMBER, an_voltvar NUMBER, an_voltchanmod NUMBER, an_flickersev NUMBER, an_thd NUMBER, an_nharmkoef NUMBER,
 an_obrunbkoef NUMBER, an_zerunbkoef NUMBER, an_powfreq NUMBER, an_voltdiptime NUMBER, an_tempvoltkoef NUMBER, an_quickchan NUMBER, an_unbalvolt NUMBER,
 an_voltinterharm NUMBER, an_voltdip NUMBER, an_shortinterrupt NUMBER, an_longinterrupt NUMBER, an_tempovervolt NUMBER, an_transovervolt NUMBER, ad_date DATE
 ) IS
 BEGIN
  UPDATE curr_quality
     SET date_time = ad_date,
         nvoltvar = an_voltvar,
         nvoltchanmod = an_voltchanmod,
         nflickersev = an_flickersev,
         nthd = an_thd,
         nnharmkoef = an_nharmkoef,
         nobrunbkoef = an_obrunbkoef,
         nzerunbkoef = an_zerunbkoef,
         npowfreq = an_powfreq,
         nvoltdiptime = an_voltdiptime,
         ntempvoltkoef = an_tempvoltkoef,
         nquickchan = an_quickchan,
         nunbalvolt = an_unbalvolt,
         nvoltinterharm = an_voltinterharm,
         nvoltdip = an_voltdip,
         nshortinterrupt = an_shortinterrupt,
         nlonginterrupt = an_longinterrupt,
         ntempovervolt = an_tempovervolt,
         ntransovervolt = an_transovervolt
   WHERE mid = an_mid;

  IF SQL%ROWCOUNT = 0 THEN
   INSERT INTO curr_quality
               (mid
               )
        VALUES (an_mid
               );

   set_curr_quality_meter (an_mid, an_voltvar, an_voltchanmod, an_flickersev, an_thd, an_nharmkoef, an_obrunbkoef, an_zerunbkoef, an_powfreq, an_voltdiptime,
                           an_tempvoltkoef, an_quickchan, an_unbalvolt, an_voltinterharm, an_voltdip, an_shortinterrupt, an_longinterrupt, an_tempovervolt,
                           an_transovervolt, ad_date);
  END IF;
 END;

-----------------------------------------------------------------------------------------------------------------------
  --Вставка суточных
 PROCEDURE set_bill_meter (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_aerm NUMBER, an_aedm NUMBER,
 an_aq1m NUMBER, an_aq3m NUMBER, an_aq2m NUMBER, an_aq4m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_bq2m NUMBER, an_bq4m NUMBER,
 an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_cq2m NUMBER, an_cq4m NUMBER, an_derm NUMBER, an_dedm NUMBER, an_dq1m NUMBER, an_dq3m NUMBER,
 an_dq2m NUMBER, an_dq4m NUMBER, av_mtrsn VARCHAR2, an_digits NUMBER,   --Значность счетчика, необходимо передать 6 - A1R_ParamCalc.DPLocE
                                                                     ad_date DATE
 ) IS
  CURSOR lcur_sel IS
   SELECT NVL (erm, 0) erm, NVL (edm, 0) edm, NVL (q1m, 0) q1m, NVL (q3m, 0) q3m, NVL (q2m, 0) q2m, NVL (q4m, 0) q4m, NVL (aerm, 0) aerm, NVL (aedm, 0) aedm,
          NVL (aq1m, 0) aq1m, NVL (aq3m, 0) aq3m, NVL (aq2m, 0) aq2m, NVL (aq4m, 0) aq4m, NVL (berm, 0) berm, NVL (bedm, 0) bedm, NVL (bq1m, 0) bq1m,
          NVL (bq3m, 0) bq3m, NVL (bq2m, 0) bq2m, NVL (bq4m, 0) bq4m, NVL (cerm, 0) cerm, NVL (cedm, 0) cedm, NVL (cq1m, 0) cq1m, NVL (cq3m, 0) cq3m,
          NVL (cq2m, 0) cq2m, NVL (cq4m, 0) cq4m, NVL (derm, 0) derm, NVL (dedm, 0) dedm, NVL (dq1m, 0) dq1m, NVL (dq3m, 0) dq3m, NVL (dq2m, 0) dq2m,
          NVL (dq4m, 0) dq4m, NVL (er_mtrsn, ' ')
     FROM billorg
    WHERE mid = an_mid
          AND date_time = (SELECT MAX (date_time)
                             FROM billorg
                            WHERE mid = an_mid AND date_time < ad_date AND LPAD (UPPER (TRIM (er_mtrsn)), 20, '0') = LPAD (UPPER (TRIM (av_mtrsn)), 20, '0'))
          AND LPAD (UPPER (TRIM (er_mtrsn)), 20, '0') = LPAD (UPPER (TRIM (av_mtrsn)), 20, '0');

  lc          lcur_sel%ROWTYPE;
  lb_found    BOOLEAN;
  ln_kc       NUMBER;
  ln_rn       NUMBER             DEFAULT 10;
  lv_source   VARCHAR2 (32)      DEFAULT 'КС';
  ln_erm      NUMBER             DEFAULT ROUND (an_erm, cn_roundall);
  ln_edm      NUMBER             DEFAULT ROUND (an_edm, cn_roundall);
  ln_q1m      NUMBER             DEFAULT ROUND (an_q1m, cn_roundall);
  ln_q3m      NUMBER             DEFAULT ROUND (an_q3m, cn_roundall);
  ln_q2m      NUMBER             DEFAULT ROUND (an_q2m, cn_roundall);
  ln_q4m      NUMBER             DEFAULT ROUND (an_q4m, cn_roundall);
  ln_aerm     NUMBER             DEFAULT ROUND (an_aerm, cn_roundall);
  ln_aedm     NUMBER             DEFAULT ROUND (an_aedm, cn_roundall);
  ln_aq1m     NUMBER             DEFAULT ROUND (an_aq1m, cn_roundall);
  ln_aq3m     NUMBER             DEFAULT ROUND (an_aq3m, cn_roundall);
  ln_aq2m     NUMBER             DEFAULT ROUND (an_aq2m, cn_roundall);
  ln_aq4m     NUMBER             DEFAULT ROUND (an_aq4m, cn_roundall);
  ln_berm     NUMBER             DEFAULT ROUND (an_berm, cn_roundall);
  ln_bedm     NUMBER             DEFAULT ROUND (an_bedm, cn_roundall);
  ln_bq1m     NUMBER             DEFAULT ROUND (an_bq1m, cn_roundall);
  ln_bq3m     NUMBER             DEFAULT ROUND (an_bq3m, cn_roundall);
  ln_bq2m     NUMBER             DEFAULT ROUND (an_bq2m, cn_roundall);
  ln_bq4m     NUMBER             DEFAULT ROUND (an_bq4m, cn_roundall);
  ln_cerm     NUMBER             DEFAULT ROUND (an_cerm, cn_roundall);
  ln_cedm     NUMBER             DEFAULT ROUND (an_cedm, cn_roundall);
  ln_cq1m     NUMBER             DEFAULT ROUND (an_cq1m, cn_roundall);
  ln_cq3m     NUMBER             DEFAULT ROUND (an_cq3m, cn_roundall);
  ln_cq2m     NUMBER             DEFAULT ROUND (an_cq2m, cn_roundall);
  ln_cq4m     NUMBER             DEFAULT ROUND (an_cq4m, cn_roundall);
  ln_derm     NUMBER             DEFAULT ROUND (an_derm, cn_roundall);
  ln_dedm     NUMBER             DEFAULT ROUND (an_dedm, cn_roundall);
  ln_dq1m     NUMBER             DEFAULT ROUND (an_dq1m, cn_roundall);
  ln_dq3m     NUMBER             DEFAULT ROUND (an_dq3m, cn_roundall);
  ln_dq2m     NUMBER             DEFAULT ROUND (an_dq2m, cn_roundall);
  ln_dq4m     NUMBER             DEFAULT ROUND (an_dq4m, cn_roundall);
  ln_er       NUMBER;
  ln_ed       NUMBER;
  ln_q1       NUMBER;
  ln_q3       NUMBER;
  ln_q2       NUMBER;
  ln_q4       NUMBER;
  ln_aer      NUMBER;
  ln_aed      NUMBER;
  ln_aq1      NUMBER;
  ln_aq3      NUMBER;
  ln_aq2      NUMBER;
  ln_aq4      NUMBER;
  ln_ber      NUMBER;
  ln_bed      NUMBER;
  ln_bq1      NUMBER;
  ln_bq3      NUMBER;
  ln_bq2      NUMBER;
  ln_bq4      NUMBER;
  ln_cer      NUMBER;
  ln_ced      NUMBER;
  ln_cq1      NUMBER;
  ln_cq3      NUMBER;
  ln_cq2      NUMBER;
  ln_cq4      NUMBER;
  ln_der      NUMBER;
  ln_ded      NUMBER;
  ln_dq1      NUMBER;
  ln_dq3      NUMBER;
  ln_dq2      NUMBER;
  ln_dq4      NUMBER;
 BEGIN
  OPEN lcur_sel;

  FETCH lcur_sel
   INTO lc;

  lb_found := lcur_sel%FOUND;

  CLOSE lcur_sel;

  util_pg.chdr (an_mid, ln_erm, ln_edm, ln_q1m, ln_q3m, ln_q2m, ln_q4m);
  util_pg.chdr (an_mid, ln_aerm, ln_aedm, ln_aq1m, ln_aq3m, ln_aq2m, ln_aq4m);
  util_pg.chdr (an_mid, ln_berm, ln_bedm, ln_bq1m, ln_bq3m, ln_bq2m, ln_bq4m);
  util_pg.chdr (an_mid, ln_cerm, ln_cedm, ln_cq1m, ln_cq3m, ln_cq2m, ln_cq4m);
  util_pg.chdr (an_mid, ln_derm, ln_dedm, ln_dq1m, ln_dq3m, ln_dq2m, ln_dq4m);

  SELECT NVL (MAX (kc), 1)
    INTO ln_kc
    FROM feeders
   WHERE mid = an_mid;

  IF lb_found THEN
   ln_er := ROUND (util_pg.indicoverturn (ln_erm - lc.erm, an_digits) * ln_kc, ln_rn);
   ln_ed := ROUND (util_pg.indicoverturn (ln_edm - lc.edm, an_digits) * ln_kc, ln_rn);
   ln_q1 := ROUND (util_pg.indicoverturn (ln_q1m - lc.q1m, an_digits) * ln_kc, ln_rn);
   ln_q3 := ROUND (util_pg.indicoverturn (ln_q3m - lc.q3m, an_digits) * ln_kc, ln_rn);
   ln_q2 := ROUND (util_pg.indicoverturn (ln_q2m - lc.q2m, an_digits) * ln_kc, ln_rn);
   ln_q4 := ROUND (util_pg.indicoverturn (ln_q4m - lc.q4m, an_digits) * ln_kc, ln_rn);
   ln_aer := ROUND (util_pg.indicoverturn (ln_aerm - lc.aerm, an_digits) * ln_kc, ln_rn);
   ln_aed := ROUND (util_pg.indicoverturn (ln_aedm - lc.aedm, an_digits) * ln_kc, ln_rn);
   ln_aq1 := ROUND (util_pg.indicoverturn (ln_aq1m - lc.aq1m, an_digits) * ln_kc, ln_rn);
   ln_aq3 := ROUND (util_pg.indicoverturn (ln_aq3m - lc.aq3m, an_digits) * ln_kc, ln_rn);
   ln_aq2 := ROUND (util_pg.indicoverturn (ln_aq2m - lc.aq2m, an_digits) * ln_kc, ln_rn);
   ln_aq4 := ROUND (util_pg.indicoverturn (ln_aq4m - lc.aq4m, an_digits) * ln_kc, ln_rn);
   ln_ber := ROUND (util_pg.indicoverturn (ln_berm - lc.berm, an_digits) * ln_kc, ln_rn);
   ln_bed := ROUND (util_pg.indicoverturn (ln_bedm - lc.bedm, an_digits) * ln_kc, ln_rn);
   ln_bq1 := ROUND (util_pg.indicoverturn (ln_bq1m - lc.bq1m, an_digits) * ln_kc, ln_rn);
   ln_bq3 := ROUND (util_pg.indicoverturn (ln_bq3m - lc.bq3m, an_digits) * ln_kc, ln_rn);
   ln_bq2 := ROUND (util_pg.indicoverturn (ln_bq2m - lc.bq2m, an_digits) * ln_kc, ln_rn);
   ln_bq4 := ROUND (util_pg.indicoverturn (ln_bq4m - lc.bq4m, an_digits) * ln_kc, ln_rn);
   ln_cer := ROUND (util_pg.indicoverturn (ln_cerm - lc.cerm, an_digits) * ln_kc, ln_rn);
   ln_ced := ROUND (util_pg.indicoverturn (ln_cedm - lc.cedm, an_digits) * ln_kc, ln_rn);
   ln_cq1 := ROUND (util_pg.indicoverturn (ln_cq1m - lc.cq1m, an_digits) * ln_kc, ln_rn);
   ln_cq3 := ROUND (util_pg.indicoverturn (ln_cq3m - lc.cq3m, an_digits) * ln_kc, ln_rn);
   ln_cq2 := ROUND (util_pg.indicoverturn (ln_cq2m - lc.cq2m, an_digits) * ln_kc, ln_rn);
   ln_cq4 := ROUND (util_pg.indicoverturn (ln_cq4m - lc.cq4m, an_digits) * ln_kc, ln_rn);
   ln_der := ROUND (util_pg.indicoverturn (ln_derm - lc.derm, an_digits) * ln_kc, ln_rn);
   ln_ded := ROUND (util_pg.indicoverturn (ln_dedm - lc.dedm, an_digits) * ln_kc, ln_rn);
   ln_dq1 := ROUND (util_pg.indicoverturn (ln_dq1m - lc.dq1m, an_digits) * ln_kc, ln_rn);
   ln_dq3 := ROUND (util_pg.indicoverturn (ln_dq3m - lc.dq3m, an_digits) * ln_kc, ln_rn);
   ln_dq2 := ROUND (util_pg.indicoverturn (ln_dq2m - lc.dq2m, an_digits) * ln_kc, ln_rn);
   ln_dq4 := ROUND (util_pg.indicoverturn (ln_dq4m - lc.dq4m, an_digits) * ln_kc, ln_rn);
  END IF;

  INSERT INTO billorg
              (mid, er, ed, q1, q3, q2, q4, aer, aed, aq1, aq3, aq2, aq4, ber, bed, bq1, bq3, bq2, bq4,
               cer, ced, cq1, cq3, cq2, cq4, der, ded, dq1, dq3, dq2, dq4, erm, edm, q1m, q3m, q2m, q4m,
               aerm, aedm, aq1m, aq3m, aq2m, aq4m, berm, bedm, bq1m, bq3m, bq2m, bq4m, cerm, cedm, cq1m, cq3m,
               cq2m, cq4m, derm, dedm, dq1m, dq3m, dq2m, dq4m, er_mtrsn, ed_mtrsn, q1_mtrsn, q3_mtrsn, q2_mtrsn, q4_mtrsn, date_time,
               SOURCE, nsource, er_kc, ed_kc, q1_kc, q3_kc, q2_kc, q4_kc
              )
       VALUES (an_mid, ln_er, ln_ed, ln_q1, ln_q3, ln_q2, ln_q4, ln_aer, ln_aed, ln_aq1, ln_aq3, ln_aq2, ln_aq4, ln_ber, ln_bed, ln_bq1, ln_bq3, ln_bq2, ln_bq4,
               ln_cer, ln_ced, ln_cq1, ln_cq3, ln_cq2, ln_cq4, ln_der, ln_ded, ln_dq1, ln_dq3, ln_dq2, ln_dq4, ln_erm, ln_edm, ln_q1m, ln_q3m, ln_q2m, ln_q4m,
               ln_aerm, ln_aedm, ln_aq1m, ln_aq3m, ln_aq2m, ln_aq4m, ln_berm, ln_bedm, ln_bq1m, ln_bq3m, ln_bq2m, ln_bq4m, ln_cerm, ln_cedm, ln_cq1m, ln_cq3m,
               ln_cq2m, ln_cq4m, ln_derm, ln_dedm, ln_dq1m, ln_dq3m, ln_dq2m, ln_dq4m, av_mtrsn, av_mtrsn, av_mtrsn, av_mtrsn, av_mtrsn, av_mtrsn, ad_date,
               lv_source, cn_auto, ln_kc, ln_kc, ln_kc, ln_kc, ln_kc, ln_kc
              );
 EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
   UPDATE billorg
      SET er_mtrsn = av_mtrsn,
          er_kc = ln_kc,
          erm = ln_erm,
          er = ln_er,
          aerm = ln_aerm,
          aer = ln_aer,
          berm = ln_berm,
          ber = ln_ber,
          cerm = ln_cerm,
          cer = ln_cer,
          derm = ln_derm,
          der = ln_der,
          q1_mtrsn = av_mtrsn,
          q1_kc = ln_kc,
          q1m = ln_q1m,
          q1 = ln_q1,
          aq1m = ln_aq1m,
          aq1 = ln_aq1,
          bq1m = ln_bq1m,
          bq1 = ln_bq1,
          cq1m = ln_cq1m,
          cq1 = ln_cq1,
          dq1m = ln_dq1m,
          dq1 = ln_dq1,
          ed_mtrsn = av_mtrsn,
          ed_kc = ln_kc,
          edm = ln_edm,
          ed = ln_ed,
          aedm = ln_aedm,
          aed = ln_aed,
          bedm = ln_bedm,
          bed = ln_bed,
          cedm = ln_cedm,
          ced = ln_ced,
          dedm = ln_dedm,
          ded = ln_ded,
          q3_mtrsn = av_mtrsn,
          q3_kc = ln_kc,
          q3m = ln_q3m,
          q3 = ln_q3,
          aq3m = ln_aq3m,
          aq3 = ln_aq3,
          bq3m = ln_bq3m,
          bq3 = ln_bq3,
          cq3m = ln_cq3m,
          cq3 = ln_cq3,
          dq3m = ln_dq3m,
          dq3 = ln_dq3,
          q2_mtrsn = av_mtrsn,
          q2_kc = ln_kc,
          q2m = ln_q2m,
          q2 = ln_q2,
          aq2m = ln_aq2m,
          aq2 = ln_aq2,
          bq2m = ln_bq2m,
          bq2 = ln_bq2,
          cq2m = ln_cq2m,
          cq2 = ln_cq2,
          dq2m = ln_dq2m,
          dq2 = ln_dq2,
          q4_mtrsn = av_mtrsn,
          q4_kc = ln_kc,
          q4m = ln_q4m,
          q4 = ln_q4,
          aq4m = ln_aq4m,
          aq4 = ln_aq4,
          bq4m = ln_bq4m,
          bq4 = ln_bq4,
          cq4m = ln_cq4m,
          cq4 = ln_cq4,
          dq4m = ln_dq4m,
          dq4 = ln_dq4,
          SOURCE = lv_source
    WHERE mid = an_mid AND date_time = ad_date AND nsource = cn_auto;
  WHEN OTHERS THEN
   raise_application_error (-20001, 'comsrv_pg.set_bill_meter: ' || SQLERRM (SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
  --Вставка месячных
 PROCEDURE set_months_meter (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_aerm NUMBER, an_aedm NUMBER,
 an_aq1m NUMBER, an_aq3m NUMBER, an_aq2m NUMBER, an_aq4m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_bq2m NUMBER, an_bq4m NUMBER,
 an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_cq2m NUMBER, an_cq4m NUMBER, an_derm NUMBER, an_dedm NUMBER, an_dq1m NUMBER, an_dq3m NUMBER,
 an_dq2m NUMBER, an_dq4m NUMBER, av_mtrsn VARCHAR2, an_digits NUMBER,   --Значность счетчика, необходимо передать 6 - A1R_ParamCalc.DPLocE
                                                                     ad_date DATE
 ) IS
  CURSOR lcur_sel IS
   SELECT NVL (erm, 0) erm, NVL (edm, 0) edm, NVL (q1m, 0) q1m, NVL (q3m, 0) q3m, NVL (q2m, 0) q2m, NVL (q4m, 0) q4m, NVL (aerm, 0) aerm, NVL (aedm, 0) aedm,
          NVL (aq1m, 0) aq1m, NVL (aq3m, 0) aq3m, NVL (aq2m, 0) aq2m, NVL (aq4m, 0) aq4m, NVL (berm, 0) berm, NVL (bedm, 0) bedm, NVL (bq1m, 0) bq1m,
          NVL (bq3m, 0) bq3m, NVL (bq2m, 0) bq2m, NVL (bq4m, 0) bq4m, NVL (cerm, 0) cerm, NVL (cedm, 0) cedm, NVL (cq1m, 0) cq1m, NVL (cq3m, 0) cq3m,
          NVL (cq2m, 0) cq2m, NVL (cq4m, 0) cq4m, NVL (derm, 0) derm, NVL (dedm, 0) dedm, NVL (dq1m, 0) dq1m, NVL (dq3m, 0) dq3m, NVL (dq2m, 0) dq2m,
          NVL (dq4m, 0) dq4m, NVL (er_mtrsn, ' ')
     FROM monthsorg
    WHERE mid = an_mid
          AND date_time = (SELECT MAX (date_time)
                             FROM monthsorg
                            WHERE mid = an_mid AND date_time < ad_date AND LPAD (UPPER (TRIM (er_mtrsn)), 20, '0') = LPAD (UPPER (TRIM (av_mtrsn)), 20, '0'))
          AND LPAD (UPPER (TRIM (er_mtrsn)), 20, '0') = LPAD (UPPER (TRIM (av_mtrsn)), 20, '0');

  lc          lcur_sel%ROWTYPE;
  lb_found    BOOLEAN;
  ln_kc       NUMBER;
  ln_rn       NUMBER             DEFAULT 10;
  lv_source   VARCHAR2 (32)      DEFAULT 'КС';
  ln_erm      NUMBER             DEFAULT ROUND (an_erm, cn_roundall);
  ln_edm      NUMBER             DEFAULT ROUND (an_edm, cn_roundall);
  ln_q1m      NUMBER             DEFAULT ROUND (an_q1m, cn_roundall);
  ln_q3m      NUMBER             DEFAULT ROUND (an_q3m, cn_roundall);
  ln_q2m      NUMBER             DEFAULT ROUND (an_q2m, cn_roundall);
  ln_q4m      NUMBER             DEFAULT ROUND (an_q4m, cn_roundall);
  ln_aerm     NUMBER             DEFAULT ROUND (an_aerm, cn_roundall);
  ln_aedm     NUMBER             DEFAULT ROUND (an_aedm, cn_roundall);
  ln_aq1m     NUMBER             DEFAULT ROUND (an_aq1m, cn_roundall);
  ln_aq3m     NUMBER             DEFAULT ROUND (an_aq3m, cn_roundall);
  ln_aq2m     NUMBER             DEFAULT ROUND (an_aq2m, cn_roundall);
  ln_aq4m     NUMBER             DEFAULT ROUND (an_aq4m, cn_roundall);
  ln_berm     NUMBER             DEFAULT ROUND (an_berm, cn_roundall);
  ln_bedm     NUMBER             DEFAULT ROUND (an_bedm, cn_roundall);
  ln_bq1m     NUMBER             DEFAULT ROUND (an_bq1m, cn_roundall);
  ln_bq3m     NUMBER             DEFAULT ROUND (an_bq3m, cn_roundall);
  ln_bq2m     NUMBER             DEFAULT ROUND (an_bq2m, cn_roundall);
  ln_bq4m     NUMBER             DEFAULT ROUND (an_bq4m, cn_roundall);
  ln_cerm     NUMBER             DEFAULT ROUND (an_cerm, cn_roundall);
  ln_cedm     NUMBER             DEFAULT ROUND (an_cedm, cn_roundall);
  ln_cq1m     NUMBER             DEFAULT ROUND (an_cq1m, cn_roundall);
  ln_cq3m     NUMBER             DEFAULT ROUND (an_cq3m, cn_roundall);
  ln_cq2m     NUMBER             DEFAULT ROUND (an_cq2m, cn_roundall);
  ln_cq4m     NUMBER             DEFAULT ROUND (an_cq4m, cn_roundall);
  ln_derm     NUMBER             DEFAULT ROUND (an_derm, cn_roundall);
  ln_dedm     NUMBER             DEFAULT ROUND (an_dedm, cn_roundall);
  ln_dq1m     NUMBER             DEFAULT ROUND (an_dq1m, cn_roundall);
  ln_dq3m     NUMBER             DEFAULT ROUND (an_dq3m, cn_roundall);
  ln_dq2m     NUMBER             DEFAULT ROUND (an_dq2m, cn_roundall);
  ln_dq4m     NUMBER             DEFAULT ROUND (an_dq4m, cn_roundall);
  ln_er       NUMBER;
  ln_ed       NUMBER;
  ln_q1       NUMBER;
  ln_q3       NUMBER;
  ln_q2       NUMBER;
  ln_q4       NUMBER;
  ln_aer      NUMBER;
  ln_aed      NUMBER;
  ln_aq1      NUMBER;
  ln_aq3      NUMBER;
  ln_aq2      NUMBER;
  ln_aq4      NUMBER;
  ln_ber      NUMBER;
  ln_bed      NUMBER;
  ln_bq1      NUMBER;
  ln_bq3      NUMBER;
  ln_bq2      NUMBER;
  ln_bq4      NUMBER;
  ln_cer      NUMBER;
  ln_ced      NUMBER;
  ln_cq1      NUMBER;
  ln_cq3      NUMBER;
  ln_cq2      NUMBER;
  ln_cq4      NUMBER;
  ln_der      NUMBER;
  ln_ded      NUMBER;
  ln_dq1      NUMBER;
  ln_dq3      NUMBER;
  ln_dq2      NUMBER;
  ln_dq4      NUMBER;
 BEGIN
  OPEN lcur_sel;

  FETCH lcur_sel
   INTO lc;

  lb_found := lcur_sel%FOUND;

  CLOSE lcur_sel;

  util_pg.chdr (an_mid, ln_erm, ln_edm, ln_q1m, ln_q3m, ln_q2m, ln_q4m);
  util_pg.chdr (an_mid, ln_aerm, ln_aedm, ln_aq1m, ln_aq3m, ln_aq2m, ln_aq4m);
  util_pg.chdr (an_mid, ln_berm, ln_bedm, ln_bq1m, ln_bq3m, ln_bq2m, ln_bq4m);
  util_pg.chdr (an_mid, ln_cerm, ln_cedm, ln_cq1m, ln_cq3m, ln_cq2m, ln_cq4m);
  util_pg.chdr (an_mid, ln_derm, ln_dedm, ln_dq1m, ln_dq3m, ln_dq2m, ln_dq4m);

  SELECT NVL (MAX (kc), 1)
    INTO ln_kc
    FROM feeders
   WHERE mid = an_mid;

  IF lb_found THEN
   ln_er := ROUND (util_pg.indicoverturn (ln_erm - lc.erm, an_digits) * ln_kc, ln_rn);
   ln_ed := ROUND (util_pg.indicoverturn (ln_edm - lc.edm, an_digits) * ln_kc, ln_rn);
   ln_q1 := ROUND (util_pg.indicoverturn (ln_q1m - lc.q1m, an_digits) * ln_kc, ln_rn);
   ln_q3 := ROUND (util_pg.indicoverturn (ln_q3m - lc.q3m, an_digits) * ln_kc, ln_rn);
   ln_q2 := ROUND (util_pg.indicoverturn (ln_q2m - lc.q2m, an_digits) * ln_kc, ln_rn);
   ln_q4 := ROUND (util_pg.indicoverturn (ln_q4m - lc.q4m, an_digits) * ln_kc, ln_rn);
   ln_aer := ROUND (util_pg.indicoverturn (ln_aerm - lc.aerm, an_digits) * ln_kc, ln_rn);
   ln_aed := ROUND (util_pg.indicoverturn (ln_aedm - lc.aedm, an_digits) * ln_kc, ln_rn);
   ln_aq1 := ROUND (util_pg.indicoverturn (ln_aq1m - lc.aq1m, an_digits) * ln_kc, ln_rn);
   ln_aq3 := ROUND (util_pg.indicoverturn (ln_aq3m - lc.aq3m, an_digits) * ln_kc, ln_rn);
   ln_aq2 := ROUND (util_pg.indicoverturn (ln_aq2m - lc.aq2m, an_digits) * ln_kc, ln_rn);
   ln_aq4 := ROUND (util_pg.indicoverturn (ln_aq4m - lc.aq4m, an_digits) * ln_kc, ln_rn);
   ln_ber := ROUND (util_pg.indicoverturn (ln_berm - lc.berm, an_digits) * ln_kc, ln_rn);
   ln_bed := ROUND (util_pg.indicoverturn (ln_bedm - lc.bedm, an_digits) * ln_kc, ln_rn);
   ln_bq1 := ROUND (util_pg.indicoverturn (ln_bq1m - lc.bq1m, an_digits) * ln_kc, ln_rn);
   ln_bq3 := ROUND (util_pg.indicoverturn (ln_bq3m - lc.bq3m, an_digits) * ln_kc, ln_rn);
   ln_bq2 := ROUND (util_pg.indicoverturn (ln_bq2m - lc.bq2m, an_digits) * ln_kc, ln_rn);
   ln_bq4 := ROUND (util_pg.indicoverturn (ln_bq4m - lc.bq4m, an_digits) * ln_kc, ln_rn);
   ln_cer := ROUND (util_pg.indicoverturn (ln_cerm - lc.cerm, an_digits) * ln_kc, ln_rn);
   ln_ced := ROUND (util_pg.indicoverturn (ln_cedm - lc.cedm, an_digits) * ln_kc, ln_rn);
   ln_cq1 := ROUND (util_pg.indicoverturn (ln_cq1m - lc.cq1m, an_digits) * ln_kc, ln_rn);
   ln_cq3 := ROUND (util_pg.indicoverturn (ln_cq3m - lc.cq3m, an_digits) * ln_kc, ln_rn);
   ln_cq2 := ROUND (util_pg.indicoverturn (ln_cq2m - lc.cq2m, an_digits) * ln_kc, ln_rn);
   ln_cq4 := ROUND (util_pg.indicoverturn (ln_cq4m - lc.cq4m, an_digits) * ln_kc, ln_rn);
   ln_der := ROUND (util_pg.indicoverturn (ln_derm - lc.derm, an_digits) * ln_kc, ln_rn);
   ln_ded := ROUND (util_pg.indicoverturn (ln_dedm - lc.dedm, an_digits) * ln_kc, ln_rn);
   ln_dq1 := ROUND (util_pg.indicoverturn (ln_dq1m - lc.dq1m, an_digits) * ln_kc, ln_rn);
   ln_dq3 := ROUND (util_pg.indicoverturn (ln_dq3m - lc.dq3m, an_digits) * ln_kc, ln_rn);
   ln_dq2 := ROUND (util_pg.indicoverturn (ln_dq2m - lc.dq2m, an_digits) * ln_kc, ln_rn);
   ln_dq4 := ROUND (util_pg.indicoverturn (ln_dq4m - lc.dq4m, an_digits) * ln_kc, ln_rn);
  END IF;

  INSERT INTO monthsorg
              (mid, er, ed, q1, q3, q2, q4, aer, aed, aq1, aq3, aq2, aq4, ber, bed, bq1, bq3, bq2, bq4,
               cer, ced, cq1, cq3, cq2, cq4, der, ded, dq1, dq3, dq2, dq4, erm, edm, q1m, q3m, q2m, q4m,
               aerm, aedm, aq1m, aq3m, aq2m, aq4m, berm, bedm, bq1m, bq3m, bq2m, bq4m, cerm, cedm, cq1m, cq3m,
               cq2m, cq4m, derm, dedm, dq1m, dq3m, dq2m, dq4m, er_mtrsn, ed_mtrsn, q1_mtrsn, q3_mtrsn, q2_mtrsn, q4_mtrsn, date_time,
               SOURCE, nsource, er_kc, ed_kc, q1_kc, q3_kc, q2_kc, q4_kc
              )
       VALUES (an_mid, ln_er, ln_ed, ln_q1, ln_q3, ln_q2, ln_q4, ln_aer, ln_aed, ln_aq1, ln_aq3, ln_aq2, ln_aq4, ln_ber, ln_bed, ln_bq1, ln_bq3, ln_bq2, ln_bq4,
               ln_cer, ln_ced, ln_cq1, ln_cq3, ln_cq2, ln_cq4, ln_der, ln_ded, ln_dq1, ln_dq3, ln_dq2, ln_dq4, ln_erm, ln_edm, ln_q1m, ln_q3m, ln_q2m, ln_q4m,
               ln_aerm, ln_aedm, ln_aq1m, ln_aq3m, ln_aq2m, ln_aq4m, ln_berm, ln_bedm, ln_bq1m, ln_bq3m, ln_bq2m, ln_bq4m, ln_cerm, ln_cedm, ln_cq1m, ln_cq3m,
               ln_cq2m, ln_cq4m, ln_derm, ln_dedm, ln_dq1m, ln_dq3m, ln_dq2m, ln_dq4m, av_mtrsn, av_mtrsn, av_mtrsn, av_mtrsn, av_mtrsn, av_mtrsn, ad_date,
               lv_source, cn_auto, ln_kc, ln_kc, ln_kc, ln_kc, ln_kc, ln_kc
              );
 EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
   UPDATE monthsorg
      SET er_mtrsn = av_mtrsn,
          er_kc = ln_kc,
          erm = ln_erm,
          er = ln_er,
          aerm = ln_aerm,
          aer = ln_aer,
          berm = ln_berm,
          ber = ln_ber,
          cerm = ln_cerm,
          cer = ln_cer,
          derm = ln_derm,
          der = ln_der,
          q1_mtrsn = av_mtrsn,
          q1_kc = ln_kc,
          q1m = ln_q1m,
          q1 = ln_q1,
          aq1m = ln_aq1m,
          aq1 = ln_aq1,
          bq1m = ln_bq1m,
          bq1 = ln_bq1,
          cq1m = ln_cq1m,
          cq1 = ln_cq1,
          dq1m = ln_dq1m,
          dq1 = ln_dq1,
          ed_mtrsn = av_mtrsn,
          ed_kc = ln_kc,
          edm = ln_edm,
          ed = ln_ed,
          aedm = ln_aedm,
          aed = ln_aed,
          bedm = ln_bedm,
          bed = ln_bed,
          cedm = ln_cedm,
          ced = ln_ced,
          dedm = ln_dedm,
          ded = ln_ded,
          q3_mtrsn = av_mtrsn,
          q3_kc = ln_kc,
          q3m = ln_q3m,
          q3 = ln_q3,
          aq3m = ln_aq3m,
          aq3 = ln_aq3,
          bq3m = ln_bq3m,
          bq3 = ln_bq3,
          cq3m = ln_cq3m,
          cq3 = ln_cq3,
          dq3m = ln_dq3m,
          dq3 = ln_dq3,
          q2_mtrsn = av_mtrsn,
          q2_kc = ln_kc,
          q2m = ln_q2m,
          q2 = ln_q2,
          aq2m = ln_aq2m,
          aq2 = ln_aq2,
          bq2m = ln_bq2m,
          bq2 = ln_bq2,
          cq2m = ln_cq2m,
          cq2 = ln_cq2,
          dq2m = ln_dq2m,
          dq2 = ln_dq2,
          q4_mtrsn = av_mtrsn,
          q4_kc = ln_kc,
          q4m = ln_q4m,
          q4 = ln_q4,
          aq4m = ln_aq4m,
          aq4 = ln_aq4,
          bq4m = ln_bq4m,
          bq4 = ln_bq4,
          cq4m = ln_cq4m,
          cq4 = ln_cq4,
          dq4m = ln_dq4m,
          dq4 = ln_dq4,
          SOURCE = lv_source
    WHERE mid = an_mid AND date_time = ad_date AND nsource = cn_auto;
  WHEN OTHERS THEN
   raise_application_error (-20001, 'comsrv_pg.set_months_meter: ' || SQLERRM (SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
  --Вставка ГН для счетчиков
 PROCEDURE set_halfhour_meter (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, an_status NUMBER,
 an_metertype NUMBER, av_qm VARCHAR2, ad_date DATE, an_period NUMBER
 ) IS
 BEGIN
  set_halfhour_meter (an_mid, an_er, an_ed, an_q1, an_q3, an_q2, an_q4, NULL, NULL, NULL, NULL, NULL, NULL, an_status, an_metertype, av_qm, ad_date, an_period);
 END;

------------------------------------------------------------------------------------------------------------------------
  --Вставка ГН для счетчиков
 PROCEDURE set_halfhour_meter (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, an_erm NUMBER, an_edm NUMBER,
 an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_status NUMBER, an_metertype NUMBER, av_qm VARCHAR2, ad_date DATE, an_period NUMBER
 ) IS
  ln_er             NUMBER DEFAULT an_er;
  ln_ed             NUMBER DEFAULT an_ed;
  ln_q1             NUMBER DEFAULT an_q1;
  ln_q3             NUMBER DEFAULT an_q3;
  ln_q2             NUMBER DEFAULT an_q2;
  ln_q4             NUMBER DEFAULT an_q4;
  ln_erm            NUMBER DEFAULT an_erm;
  ln_edm            NUMBER DEFAULT an_edm;
  ln_q1m            NUMBER DEFAULT an_q1m;
  ln_q3m            NUMBER DEFAULT an_q3m;
  ln_q2m            NUMBER DEFAULT an_q2m;
  ln_q4m            NUMBER DEFAULT an_q4m;
  ln_stepprofile    NUMBER DEFAULT util_pg.stepprofile_f;
  ln_stephalfhour   NUMBER DEFAULT util_pg.stephalfhour_f;
  ld_date           DATE   DEFAULT util_pg.to_localtime_if_new (ad_date);
  ln_source         NUMBER DEFAULT cn_auto;
 BEGIN
  util_pg.chdr (an_mid, ln_er, ln_ed, ln_q1, ln_q3, ln_q2, ln_q4);
  util_pg.chdr (an_mid, ln_erm, ln_edm, ln_q1m, ln_q3m, ln_q2m, ln_q4m);

/*  IF an_metertype = cn_itek THEN
   ln_source := cn_itek;
  END IF;*/
  IF /*Доп проверка*/ an_period <= ln_stepprofile AND MOD (ln_stepprofile, an_period) = 0 AND util_pg.get_typekeephalfhour (an_mid) = 1 THEN   --Расчитывать ГН по ГН счетчика (при параметризации ПУ < 30 писать в PROFILE и считать ГН)
   IF util_pg.newhalfhour_f = 1 AND util_pg.is_timeswitch (ad_date) = -1 THEN   --Время перехода с лета на зиму (nsource=19,29)
    ln_source := 19;
   END IF;

   BEGIN
    INSERT INTO PROFILE
                (mid, date_time, nsource, er, ed, q1, q3, q2, q4, erm, edm, q1m, q3m, q2m, q4m, vqm
                )
         VALUES (an_mid, ld_date, ln_source, ln_er, ln_ed, ln_q1, ln_q3, ln_q2, ln_q4, ln_erm, ln_edm, ln_q1m, ln_q3m, ln_q2m, ln_q4m, av_qm
                );
   EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
     UPDATE PROFILE
        SET er = ln_er,
            ed = ln_ed,
            q1 = ln_q1,
            q3 = ln_q3,
            q2 = ln_q2,
            q4 = ln_q4,
            erm = ln_erm,
            edm = ln_edm,
            q1m = ln_q1m,
            q3m = ln_q3m,
            q2m = ln_q2m,
            q4m = ln_q4m,
            vqm = av_qm
      WHERE mid = an_mid AND date_time = ld_date AND nsource = ln_source;
   END;

   IF ad_date = util_pg.trunc_d (ad_date, ln_stephalfhour / 1440) THEN
    FOR lc IN (SELECT SUM (er) er, SUM (ed) ed, SUM (q1) q1, SUM (q3) q3, SUM (q2) q2, SUM (q4) q4, sumqm (vqm) vqm
                 FROM PROFILE
                WHERE mid = an_mid AND date_time > ld_date - ln_stephalfhour / 1440 AND date_time <= ld_date AND nsource = ln_source) LOOP
     das_pg.ins_halfhourtmp (an_mid, ad_date, ln_source, lc.er, lc.ed, lc.q1, lc.q3, lc.q2, lc.q4, ln_erm, ln_edm, ln_q1m, ln_q3m, ln_q2m, ln_q4m, NULL,
                             an_metertype, lc.vqm);
    END LOOP;
   END IF;
  ELSE
   das_pg.insert_hf_in_profile (an_mid, ad_date, an_period, ln_er, ln_ed, ln_q1, ln_q2, ln_q3, ln_q4);
   das_pg.ins_halfhourtmp (an_mid, ad_date, ln_source, ln_er, ln_ed, ln_q1, ln_q3, ln_q2, ln_q4, ln_erm, ln_edm, ln_q1m, ln_q3m, ln_q2m, ln_q4m, an_status,
                           an_metertype, av_qm);
  END IF;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error (-20001, 'comsrv_pg.set_halfhour_meter: ' || SQLERRM (SQLCODE));
 END;

 ------------------------------------------------------------------------------------------------------------------------
--******************************          УСПД КМ-64           *******************************************************--
------------------------------------------------------------------------------------------------------------------------
   --Вставка суточных
 PROCEDURE set_bill_uspd (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_aerm NUMBER, an_aedm NUMBER,
 an_aq1m NUMBER, an_aq3m NUMBER, an_aq2m NUMBER, an_aq4m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_bq2m NUMBER, an_bq4m NUMBER,
 an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_cq2m NUMBER, an_cq4m NUMBER, an_derm NUMBER, an_dedm NUMBER, an_dq1m NUMBER, an_dq3m NUMBER,
 an_dq2m NUMBER, an_dq4m NUMBER, av_mtrsn VARCHAR2, an_digits NUMBER,   --Значность счетчика, необходимо передать соответствующую АРГО
                                                                        --( для A1R было 6 - A1R_ParamCalc.DPLocE )
                                                                     ad_date DATE
 ) IS
 BEGIN
  set_bill_meter (an_mid, an_erm, an_edm, an_q1m, an_q3m, an_q2m, an_q4m, an_aerm, an_aedm, an_aq1m, an_aq3m, an_aq2m, an_aq4m, an_berm, an_bedm, an_bq1m, an_bq3m,
                  an_bq2m, an_bq4m, an_cerm, an_cedm, an_cq1m, an_cq3m, an_cq2m, an_cq4m, an_derm, an_dedm, an_dq1m, an_dq3m, an_dq2m, an_dq4m, av_mtrsn, an_digits,
                  ad_date);
 END;

------------------------------------------------------------------------------------------------------------------------
  --Вставка месячных
 PROCEDURE set_months_uspd (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_aerm NUMBER, an_aedm NUMBER,
 an_aq1m NUMBER, an_aq3m NUMBER, an_aq2m NUMBER, an_aq4m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_bq2m NUMBER, an_bq4m NUMBER,
 an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_cq2m NUMBER, an_cq4m NUMBER, an_derm NUMBER, an_dedm NUMBER, an_dq1m NUMBER, an_dq3m NUMBER,
 an_dq2m NUMBER, an_dq4m NUMBER, av_mtrsn VARCHAR2, an_digits NUMBER,   --Значность счетчика, необходимо передать соответствующую АРГО
                                                                        --( для A1R 6 - A1R_ParamCalc.DPLocE )
                                                                     ad_date DATE
 ) IS
 BEGIN
  set_months_meter (an_mid, an_erm, an_edm, an_q1m, an_q3m, an_q2m, an_q4m, an_aerm, an_aedm, an_aq1m, an_aq3m, an_aq2m, an_aq4m, an_berm, an_bedm, an_bq1m,
                    an_bq3m, an_bq2m, an_bq4m, an_cerm, an_cedm, an_cq1m, an_cq3m, an_cq2m, an_cq4m, an_derm, an_dedm, an_dq1m, an_dq3m, an_dq2m, an_dq4m, av_mtrsn,
                    an_digits, ad_date);
 END;

------------------------------------------------------------------------------------------------------------------------
 --Вставка графика нагрузки
 PROCEDURE set_halfhour_uspd (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, ad_date DATE) IS
 BEGIN
  set_halfhour_meter (an_mid, an_er, an_ed, an_q1, an_q3, an_q2, an_q4, NULL, cn_uspd_64, NULL, ad_date, NULL);
 END;

------------------------------------------------------------------------------------------------------------------------
--******************************          Itek 210             *******************************************************--
------------------------------------------------------------------------------------------------------------------------
 --Вставка коэффициентов
 PROCEDURE set_coeffic_itek (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER) IS
 BEGIN
  UPDATE itekcoeff
     SET date_time = SYSDATE,
         ker = an_er,
         ked = an_ed,
         kq1 = an_q1,
         kq3 = an_q3
   WHERE mid = an_mid;

  IF SQL%ROWCOUNT = 0 THEN
   INSERT INTO itekcoeff
               (mid, date_time, ker, ked, kq1, kq3
               )
        VALUES (an_mid, SYSDATE, an_er, an_ed, an_q1, an_q3
               );
  END IF;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error (-20001, 'comsrv_pg.set_coeffic_itek: ' || SQLERRM (SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
 --Вставка 3-х минуток
 PROCEDURE set_profile_itek (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, ad_date DATE) IS
  ln_er       NUMBER DEFAULT an_er;
  ln_ed       NUMBER DEFAULT an_ed;
  ln_q1       NUMBER DEFAULT an_q1;
  ln_q3       NUMBER DEFAULT an_q3;
  ln_delt     NUMBER DEFAULT 60 / util_pg.stepprofile_f;
  ld_date     DATE   DEFAULT ad_date;
  ln_source   NUMBER DEFAULT cn_auto;
  ln_mid      NUMBER;
 BEGIN
  IF FALSE THEN   --IF убрать, когда Носик станет вести по зиме
   ld_date := util_pg.to_localtime_if_new (ad_date);

   IF util_pg.newhalfhour_f = 1 AND util_pg.is_timeswitch (ad_date) = -1 THEN   --Время перехода с лета на зиму (nsource=19,29)
    ln_source := 19;
   END IF;
  END IF;

  util_pg.chdr (an_mid, ln_er, ln_ed, ln_q1, ln_q3);

  FOR lc IN (SELECT mid
               FROM points
              WHERE mid = an_mid
             UNION ALL
             SELECT pa.mid
               FROM points p, points pa, feeders f
              WHERE p.mid = an_mid AND p.ind = 3 AND p.PARENT = pa.mid AND pa.ind = 4 AND pa.mid = f.mid AND f.ncalcpointtype IS NULL) LOOP
   UPDATE curr_power
      SET er = ln_er * ln_delt,
          ed = ln_ed * ln_delt,
          q1 = ln_q1 * ln_delt,
          q3 = ln_q3 * ln_delt,
          obsolete = 0,
          date_time = ld_date
    WHERE mid = lc.mid;

   BEGIN
    INSERT INTO PROFILE
                (mid, date_time, nsource, er, ed, q1, q3
                )
         VALUES (lc.mid, ld_date, ln_source, ln_er, ln_ed, ln_q1, ln_q3
                );
   EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
     UPDATE PROFILE
        SET er = ln_er,
            ed = ln_ed,
            q1 = ln_q1,
            q3 = ln_q3
      WHERE mid = lc.mid AND date_time = ld_date AND nsource = ln_source;
    WHEN OTHERS THEN
     RAISE;
   END;
  END LOOP;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error (-20001, 'comsrv_pg.set_profile_itek: ' || SQLERRM (SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
 --Вставка графика нагрузки
 PROCEDURE set_halfhour_itek (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, ad_date DATE) IS
 BEGIN
  set_halfhour_meter (an_mid, an_er, an_ed, an_q1, an_q3, NULL, NULL, NULL, cn_itek, NULL, ad_date, NULL);
 END;

------------------------------------------------------------------------------------------------------------------------
  --Вставка месячных и суточных ИТЭК
 PROCEDURE set_bm_itek (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_zone NUMBER,   --1-A, 2-B, 3-C,4-D. иначе общий
                                                                                                              ad_date DATE, an_type NUMBER
 )   -- 1 - BILL. иначе MONTHS
  IS
  ln_er      NUMBER          DEFAULT an_er;
  ln_ed      NUMBER          DEFAULT an_ed;
  ln_q1      NUMBER          DEFAULT an_q1;
  ln_q3      NUMBER          DEFAULT an_q3;
  lv_table   VARCHAR2 (32);
  lv_pref    VARCHAR2 (8);
  lv_sql     VARCHAR2 (4000);
 BEGIN
  util_pg.chdr (an_mid, ln_er, ln_ed, ln_q1, ln_q3);

  --выбираем таблицу
  IF an_type = 1 THEN
   lv_table := 'billorg';
  ELSE
   lv_table := 'monthsorg';
  END IF;

  --выбираем тариф
  IF an_zone = 1 THEN
   lv_pref := 'a';
  ELSIF an_zone = 2 THEN
   lv_pref := 'b';
  ELSIF an_zone = 3 THEN
   lv_pref := 'c';
  ELSIF an_zone = 4 THEN
   lv_pref := 'd';
  END IF;

  lv_sql :=
   'update ' || lv_table || ' set ' || lv_pref || 'er=:1,' || lv_pref || 'ed=:2,' || lv_pref || 'q1=:3,' || lv_pref
   || 'q3=:4 where mid=:5 and date_time=:6 and nsource=:7';

  EXECUTE IMMEDIATE lv_sql
              USING ln_er, ln_ed, ln_q1, ln_q3, an_mid, ad_date, cn_auto;

  IF SQL%ROWCOUNT = 0 THEN
   lv_sql :=
    'insert into ' || lv_table || '(mid,date_time,nsource,' || lv_pref || 'er,' || lv_pref || 'ed,' || lv_pref || 'q1,' || lv_pref
    || 'q3) values(:1,:2,:3,:4,:5,:6,:7)';

   EXECUTE IMMEDIATE lv_sql
               USING an_mid, ad_date, cn_auto, ln_er, ln_ed, ln_q1, ln_q3;
  END IF;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error (-20001, 'comsrv_pg.set_bm_itek: ' || SQLERRM (SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
 --Вставка суточных
 PROCEDURE set_bill_itek (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_zone NUMBER,   --1-A, 2-B, 3-C,4-D. иначе общий
                                                                                                                ad_date DATE) IS
 BEGIN
  set_bm_itek (an_mid, an_er, an_ed, an_q1, an_q3, an_zone, ad_date, 1);
 END;

------------------------------------------------------------------------------------------------------------------------
 --Вставка месячных
 PROCEDURE set_months_itek (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_zone NUMBER,   --1-A, 2-B, 3-C,4-D. иначе общий
                                                                                                                  ad_date DATE) IS
 BEGIN
  set_bm_itek (an_mid, an_er, an_ed, an_q1, an_q3, an_zone, ad_date, 0);
 END;

------------------------------------------------------------------------------------------------------------------------
--******************************          L                  *******************************************************--
------------------------------------------------------------------------------------------------------------------------
 --Вставка текущих
 PROCEDURE set_curr_power_zxb (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, ad_date DATE) IS
 BEGIN
  set_curr_power_zxb (an_mid, an_erm, an_edm, an_q1m, an_q3m, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
                      ad_date);
 END;

------------------------------------------------------------------------------------------------------------------------
 --Вставка текущих ZxB (+ ток в нуле)
 PROCEDURE set_curr_power_zxb (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_freq NUMBER,
 an_cos_fi NUMBER, an_volt1 NUMBER, an_volt2 NUMBER, an_volt3 NUMBER, an_curr1 NUMBER, an_curr2 NUMBER, an_curr3 NUMBER, an_fiu1i1 NUMBER, an_fiu2i2 NUMBER,
 an_fiu3i3 NUMBER, an_fiu1 NUMBER, an_fiu2 NUMBER, an_fiu3 NUMBER, an_i0 NUMBER, ad_date DATE
 ) IS
 BEGIN
  set_curr_power_zxb (an_mid, an_erm, an_edm, an_q1m, an_q3m, an_q1m, an_q3m, an_q2m, an_q4m, an_freq, an_cos_fi, an_volt1, an_volt2, an_volt3, an_curr1, an_curr2,
                      an_curr3, an_fiu1i1, an_fiu2i2, an_fiu3i3, an_fiu1, an_fiu2, an_fiu3, an_i0, ad_date);
 END;

------------------------------------------------------------------------------------------------------------------------
 --Вставка текущих ZxB
 PROCEDURE set_curr_power_zxb (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_freq NUMBER,
 an_cos_fi NUMBER, an_volt1 NUMBER, an_volt2 NUMBER, an_volt3 NUMBER, an_curr1 NUMBER, an_curr2 NUMBER, an_curr3 NUMBER, an_fiu1i1 NUMBER, an_fiu2i2 NUMBER,
 an_fiu3i3 NUMBER, an_fiu1 NUMBER, an_fiu2 NUMBER, an_fiu3 NUMBER, ad_date DATE
 ) IS
 BEGIN
  set_curr_power_zxb (an_mid, an_erm, an_edm, an_q1m, an_q3m, an_q1m, an_q3m, an_q2m, an_q4m, an_freq, an_cos_fi, an_volt1, an_volt2, an_volt3, an_curr1, an_curr2,
                      an_curr3, an_fiu1i1, an_fiu2i2, an_fiu3i3, an_fiu1, an_fiu2, an_fiu3, ad_date);
 END;

------------------------------------------------------------------------------------------------------------------------
 --Вставка текущих ZxB с квадрантами (+ ток в нуле)
 PROCEDURE set_curr_power_zxb (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_rrm NUMBER, an_rdm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER,
 an_freq NUMBER, an_cos_fi NUMBER, an_volt1 NUMBER, an_volt2 NUMBER, an_volt3 NUMBER, an_curr1 NUMBER, an_curr2 NUMBER, an_curr3 NUMBER, an_fiu1i1 NUMBER,
 an_fiu2i2 NUMBER, an_fiu3i3 NUMBER, an_fiu1 NUMBER, an_fiu2 NUMBER, an_fiu3 NUMBER, an_i0 NUMBER, ad_date DATE
 ) IS
  ln_rn     NUMBER DEFAULT 5;
  ln_kc     NUMBER;
  ln_erm    NUMBER DEFAULT an_erm;
  ln_edm    NUMBER DEFAULT an_edm;
  ln_q1m    NUMBER DEFAULT an_rrm;
  ln_q3m    NUMBER DEFAULT an_rdm;
  ln_q2m    NUMBER;
  ln_q4m    NUMBER;
  ln_er     NUMBER;
  ln_ed     NUMBER;
  ln_q1     NUMBER;
  ln_q3     NUMBER;
  ln_q2     NUMBER;
  ln_q4     NUMBER;
  ln_oerm   NUMBER;
  ln_oedm   NUMBER;
  ln_oq1m   NUMBER;
  ln_oq3m   NUMBER;
  ln_oq2m   NUMBER;
  ln_oq4m   NUMBER;
  ln_k      NUMBER;
  ld_date   DATE   DEFAULT SYSDATE;
  ln_fii1   NUMBER DEFAULT an_fiu1i1;
  ln_fii2   NUMBER DEFAULT an_fiu2i2;
  ln_fii3   NUMBER DEFAULT an_fiu3i3;
  ln_fiu1   NUMBER DEFAULT an_fiu1;
  ln_fiu2   NUMBER DEFAULT an_fiu2;
  ln_fiu3   NUMBER DEFAULT an_fiu3;
 BEGIN
  IF util_pg.is_indicbyq1234 (an_mid) = 1 THEN
   ln_q1m := an_q1m;
   ln_q3m := an_q3m;
   ln_q2m := an_q2m;
   ln_q4m := an_q4m;
  END IF;

  convert_corners (util_pg.getcornersparam (an_mid), ln_fiu1, ln_fiu2, ln_fiu3, ln_fii1, ln_fii2, ln_fii3);
  util_pg.chdr (an_mid, ln_erm, ln_edm, ln_q1m, ln_q3m, ln_q2m, ln_q4m);

  SELECT 24 * MAX (ld_date - date_time) dt, NVL (MAX (erm), 0), NVL (MAX (edm), 0), NVL (MAX (q1m), 0), NVL (MAX (q3m), 0), NVL (MAX (q2m), 0), NVL (MAX (q4m), 0)
    INTO ln_k, ln_oerm, ln_oedm, ln_oq1m, ln_oq3m, ln_oq2m, ln_oq4m
    FROM curr_power
   WHERE mid = an_mid;

  IF util_pg.get_typecalcpower (an_mid) = 1 AND ln_k > 0 THEN
   SELECT NVL (MAX (kc), 1)
     INTO ln_kc
     FROM feeders
    WHERE mid = an_mid;

   ln_er := ROUND (ln_kc * util_pg.indicoverturn (ln_erm - ln_oerm, NULL) / ln_k, ln_rn);
   ln_ed := ROUND (ln_kc * util_pg.indicoverturn (ln_edm - ln_oedm, NULL) / ln_k, ln_rn);
   ln_q1 := ROUND (ln_kc * util_pg.indicoverturn (ln_q1m - ln_oq1m, NULL) / ln_k, ln_rn);
   ln_q3 := ROUND (ln_kc * util_pg.indicoverturn (ln_q3m - ln_oq3m, NULL) / ln_k, ln_rn);
   ln_q2 := ROUND (ln_kc * util_pg.indicoverturn (ln_q2m - ln_oq2m, NULL) / ln_k, ln_rn);
   ln_q4 := ROUND (ln_kc * util_pg.indicoverturn (ln_q4m - ln_oq4m, NULL) / ln_k, ln_rn);
  END IF;

  UPDATE curr_power
     SET erm = ln_erm,
         edm = ln_edm,
         q1m = ln_q1m,
         q3m = ln_q3m,
         q2m = ln_q2m,
         q4m = ln_q4m,
         er = ln_er,
         ed = ln_ed,
         q1 = ln_q1,
         q3 = ln_q3,
         q2 = ln_q2,
         q4 = ln_q4,
         freq = an_freq,
         cosf = an_cos_fi,
         volt = an_volt1,
         volt2 = an_volt2,
         volt3 = an_volt3,
         currento = an_curr1,
         curr2 = an_curr2,
         curr3 = an_curr3,
         nfiu1 = ln_fiu1,
         nfiu2 = ln_fiu2,
         nfiu3 = ln_fiu3,
         nfii1 = ln_fii1,
         nfii2 = ln_fii2,
         nfii3 = ln_fii3,
         ni0 = an_i0,
         obsolete = 0,
         date_time = ld_date
   WHERE mid = an_mid;

  set_abc_zxb (an_mid, an_volt1, an_volt2, an_volt3, ld_date);
  das_pg.insert_cp_in_profile (an_mid);
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error (-20001, 'comsrv_pg.set_curr_power_zxb: ' || SQLERRM (SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
 --Вставка текущих ZxB с квадрантами
 PROCEDURE set_curr_power_zxb (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_rrm NUMBER, an_rdm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER,
 an_freq NUMBER, an_cos_fi NUMBER, an_volt1 NUMBER, an_volt2 NUMBER, an_volt3 NUMBER, an_curr1 NUMBER, an_curr2 NUMBER, an_curr3 NUMBER, an_fiu1i1 NUMBER,
 an_fiu2i2 NUMBER, an_fiu3i3 NUMBER, an_fiu1 NUMBER, an_fiu2 NUMBER, an_fiu3 NUMBER, ad_date DATE
 ) IS
 BEGIN
  set_curr_power_zxb (an_mid, an_erm, an_edm, an_rrm, an_rdm, an_q1m, an_q3m, an_q2m, an_q4m, an_freq, an_cos_fi, an_volt1, an_volt2, an_volt3, an_curr1, an_curr2,
                      an_curr3, an_fiu1i1, an_fiu2i2, an_fiu3i3, an_fiu1, an_fiu2, an_fiu3, NULL, ad_date);
 END;

------------------------------------------------------------------------------------------------------------------------
  --Вставка текущих ZxD (+ ток в нуле)
 PROCEDURE set_curr_power_zxd (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_rrm NUMBER, an_rdm NUMBER, an_q1m NUMBER, an_q2m NUMBER, an_q3m NUMBER, an_q4m NUMBER,
 an_freq NUMBER, an_cos_fi NUMBER, an_volt1 NUMBER, an_volt2 NUMBER, an_volt3 NUMBER, an_curr1 NUMBER, an_curr2 NUMBER, an_curr3 NUMBER, an_fiu1i1 NUMBER,
 an_fiu2i2 NUMBER, an_fiu3i3 NUMBER, an_fiu1u2 NUMBER, an_fiu1u3 NUMBER, an_fiu2u3 NUMBER, an_er NUMBER, an_ed NUMBER, an_rr NUMBER, an_rd NUMBER, an_q1 NUMBER,
 an_q2 NUMBER, an_q3 NUMBER, an_q4 NUMBER, an_i0 NUMBER, ad_date DATE
 ) IS
 BEGIN
  IF util_pg.is_indicbyq1234 (an_mid) = 1 THEN
   set_curr_power_meter (an_mid, an_erm, an_edm, an_q1m, an_q3m, an_q2m, an_q4m, an_freq, an_cos_fi, an_volt1, an_volt2, an_volt3, an_curr1, an_curr2, an_curr3,
                         an_fiu1i1, an_fiu2i2, an_fiu3i3, an_fiu1u2, an_fiu1u3, an_fiu2u3, an_er, an_ed, an_q1, an_q3, an_q2, an_q4, an_i0, 3, ad_date);
  ELSE
   set_curr_power_meter (an_mid, an_erm, an_edm, an_rrm, an_rdm, NULL, NULL, an_freq, an_cos_fi, an_volt1, an_volt2, an_volt3, an_curr1, an_curr2, an_curr3,
                         an_fiu1i1, an_fiu2i2, an_fiu3i3, an_fiu1u2, an_fiu1u3, an_fiu2u3, an_er, an_ed, an_rr, an_rd, NULL, NULL, an_i0, 3, ad_date);
  END IF;
 END;

------------------------------------------------------------------------------------------------------------------------
  --Вставка текущих ZxD
 PROCEDURE set_curr_power_zxd (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_rrm NUMBER, an_rdm NUMBER, an_q1m NUMBER, an_q2m NUMBER, an_q3m NUMBER, an_q4m NUMBER,
 an_freq NUMBER, an_cos_fi NUMBER, an_volt1 NUMBER, an_volt2 NUMBER, an_volt3 NUMBER, an_curr1 NUMBER, an_curr2 NUMBER, an_curr3 NUMBER, an_fiu1i1 NUMBER,
 an_fiu2i2 NUMBER, an_fiu3i3 NUMBER, an_fiu1u2 NUMBER, an_fiu1u3 NUMBER, an_fiu2u3 NUMBER, an_er NUMBER, an_ed NUMBER, an_rr NUMBER, an_rd NUMBER, an_q1 NUMBER,
 an_q2 NUMBER, an_q3 NUMBER, an_q4 NUMBER, ad_date DATE
 ) IS
 BEGIN
  IF util_pg.is_indicbyq1234 (an_mid) = 1 THEN
   set_curr_power_meter (an_mid, an_erm, an_edm, an_q1m, an_q3m, an_q2m, an_q4m, an_freq, an_cos_fi, an_volt1, an_volt2, an_volt3, an_curr1, an_curr2, an_curr3,
                         an_fiu1i1, an_fiu2i2, an_fiu3i3, an_fiu1u2, an_fiu1u3, an_fiu2u3, an_er, an_ed, an_q1, an_q3, an_q2, an_q4, 3, ad_date);
  ELSE
   set_curr_power_meter (an_mid, an_erm, an_edm, an_rrm, an_rdm, NULL, NULL, an_freq, an_cos_fi, an_volt1, an_volt2, an_volt3, an_curr1, an_curr2, an_curr3,
                         an_fiu1i1, an_fiu2i2, an_fiu3i3, an_fiu1u2, an_fiu1u3, an_fiu2u3, an_er, an_ed, an_rr, an_rd, NULL, NULL, 3, ad_date);
  END IF;
 END;

------------------------------------------------------------------------------------------------------------------------

 --Вставка графика нагрузки
 PROCEDURE set_halfhour_zxb (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_status NUMBER, ad_date DATE) IS
  lv_mtrsn       VARCHAR2 (256);
  ln_paramtype   NUMBER;
 BEGIN
  SELECT DECODE (MAX (vvalue), '1', 1, 0)
    INTO ln_paramtype
    FROM addpointparamval
   WHERE mid = an_mid AND nsort = 72;

  IF ln_paramtype = 1 THEN   --Параметризация счетчика на автосохранение показаний
   SELECT NVL (MAX (mtrsn), 'LG')
     INTO lv_mtrsn
     FROM meters
    WHERE mid = an_mid AND entype = 7;

   set_halfhour_zxb (an_mid, NULL, NULL, NULL, NULL, an_er, an_ed, an_q1, an_q3, lv_mtrsn, NULL, an_status, ad_date);
  ELSE
   set_halfhour_meter (an_mid, an_er, an_ed, an_q1, an_q3, NULL, NULL, an_status, cn_lg_zxd, NULL, ad_date, NULL);
  END IF;
 END;

------------------------------------------------------------------------------------------------------------------------
 --Вставка графика нагрузки (По показаниям)
 PROCEDURE set_halfhour_zxb (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER,
 av_mtrsn VARCHAR2, an_digits NUMBER,   --Значность счетчика
                                     an_status NUMBER, ad_date DATE, an_source NUMBER
 ) IS
  ld_winter   DATE               DEFAULT util_pg.to_localtime_if_new (ad_date, 1);
  ln_source   NUMBER             DEFAULT cn_auto;
  ln_switch   NUMBER;

  CURSOR lcur_sel (lc_source NUMBER) IS
   SELECT 0 ts, NVL (erm, 0) erm, NVL (edm, 0) edm, NVL (q1m, 0) q1m, NVL (q3m, 0) q3m
     FROM halfhourtmp
    WHERE mid = an_mid AND date_time = (SELECT MAX (date_time) dt
                                          FROM halfhourtmp
                                         WHERE mid = an_mid AND date_time < ad_date /*AND nsource = lc_source*/)
          AND LPAD (UPPER (TRIM (er_mtrsn)), 20, '0') = LPAD (UPPER (TRIM (av_mtrsn)), 20, '0')   /*AND nsource = lc_source*/
   UNION ALL
   SELECT util_pg.is_timeswitch (date_time) ts, NVL (erm, 0) erm, NVL (edm, 0) edm, NVL (q1m, 0) q1m, NVL (q3m, 0) q3m
     FROM halfhour
    WHERE mid = an_mid
          AND date_time = (SELECT MAX (date_time) dt
                             FROM halfhourold   --halfhourold для быстроты и убрали AND lpad(UPPER(TRIM(er_mtrsn)),20,'0') = lpad(UPPER(TRIM(av_mtrsn)),20,'0')
                            WHERE mid = an_mid AND date_time < ld_winter /*AND (nsource = lc_source OR nsource = lc_source + 9)*/)
          AND LPAD (UPPER (TRIM (er_mtrsn)), 20, '0') = LPAD (UPPER (TRIM (av_mtrsn)), 20, '0') /*AND (nsource >= lc_source AND nsource <= lc_source + 9)*/;

  CURSOR lcur_sel1 (lc_source NUMBER) IS
   SELECT 0 ts, NVL (erm, 0) erm, NVL (edm, 0) edm, NVL (q1m, 0) q1m, NVL (q3m, 0) q3m
     FROM halfhour
    WHERE mid = an_mid
          AND util_pg.to_unlocaltime_if_new (date_time, nsource) =
              (SELECT MAX (util_pg.to_unlocaltime_if_new (date_time, nsource)) dt
                 FROM halfhourold   --halfhourold для быстроты и убрали AND lpad(UPPER(TRIM(er_mtrsn)),20,'0') = lpad(UPPER(TRIM(av_mtrsn)),20,'0')
                WHERE mid = an_mid AND date_time < ld_winter /*AND (nsource = lc_source OR nsource = lc_source + 9)*/ AND date_time >= ld_winter - 2 / 24
                      AND util_pg.to_unlocaltime_if_new (date_time, nsource) < ad_date)
          AND LPAD (UPPER (TRIM (er_mtrsn)), 20, '0') = LPAD (UPPER (TRIM (av_mtrsn)), 20, '0')   /*AND (nsource >= lc_source AND nsource <= lc_source + 9)*/
          AND date_time < ld_winter AND date_time >= ld_winter - 2 / 24;

  lc          lcur_sel%ROWTYPE;
  lb_found    BOOLEAN;
  ln_kc       NUMBER;
  ln_rn       NUMBER             DEFAULT 10;
  ln_erm      NUMBER             DEFAULT an_erm;
  ln_edm      NUMBER             DEFAULT an_edm;
  ln_q1m      NUMBER             DEFAULT an_q1m;
  ln_q3m      NUMBER             DEFAULT an_q3m;
  ln_er       NUMBER             DEFAULT an_er;
  ln_ed       NUMBER             DEFAULT an_ed;
  ln_q1       NUMBER             DEFAULT an_q1;
  ln_q3       NUMBER             DEFAULT an_q3;
 BEGIN
  IF an_source = util_pg.cn_manualinput THEN
   ln_source := util_pg.cn_manualinput;
  END IF;

  OPEN lcur_sel (ln_source);

  FETCH lcur_sel
   INTO lc;

  lb_found := lcur_sel%FOUND;

  CLOSE lcur_sel;

  util_pg.chdr (an_mid, ln_erm, ln_edm, ln_q1m, ln_q3m);
  util_pg.chdr (an_mid, ln_er, ln_ed, ln_q1, ln_q3);

  IF lb_found AND lc.ts = -1 THEN
   OPEN lcur_sel1 (ln_source);

   FETCH lcur_sel1
    INTO lc;

   lb_found := lcur_sel1%FOUND;

   CLOSE lcur_sel1;
  END IF;

  IF lb_found THEN
   SELECT NVL (MAX (kc), 1)
     INTO ln_kc
     FROM feeders
    WHERE mid = an_mid;

   ln_er := ROUND (util_pg.indicoverturn (ln_erm - lc.erm, an_digits) * ln_kc, ln_rn);
   ln_ed := ROUND (util_pg.indicoverturn (ln_edm - lc.edm, an_digits) * ln_kc, ln_rn);
   ln_q1 := ROUND (util_pg.indicoverturn (ln_q1m - lc.q1m, an_digits) * ln_kc, ln_rn);
   ln_q3 := ROUND (util_pg.indicoverturn (ln_q3m - lc.q3m, an_digits) * ln_kc, ln_rn);
  END IF;

  das_pg.ins_halfhourtmp (an_mid, ad_date, an_source, ln_er, ln_ed, ln_q1, ln_q3, NULL, NULL, ln_erm, ln_edm, ln_q1m, ln_q3m, NULL, NULL, an_status, cn_lg_zxd, NULL,
                          av_mtrsn);
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error (-20001, 'comsrv_pg.set_halfhour_zxb: ' || SQLERRM (SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
  --Вставка графика нагрузки по индукционникам
 PROCEDURE set_halfhour_zxb_induc (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, av_mtrsn VARCHAR2, an_digits NUMBER, ad_date DATE) IS
 BEGIN
  set_halfhour_zxb (an_mid, NULL, NULL, NULL, NULL, an_erm, an_edm, an_q1m, an_q3m, av_mtrsn, an_digits, NULL, ad_date);
 END;

-----------------------------------------------------------------------------------------------------------------------
 PROCEDURE set_halfhour_fag_induc (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, av_mtrsn VARCHAR2, an_digits NUMBER, ad_date DATE) IS
 BEGIN
  set_halfhour_zxb (an_mid, an_er, an_ed, an_q1, an_q3, NULL, ad_date);
 END;

-----------------------------------------------------------------------------------------------------------------------
  --Вставка листинга показаний
 PROCEDURE set_readout_zxb (an_mid NUMBER, at_data common_pg.tt_varchar2) IS
  ld_dat   DATE DEFAULT SYSDATE;
 BEGIN
  IF util_pg.locksysjournal_f = 1 THEN
   RETURN;
  END IF;

  SAVEPOINT set_readout_zxb_sp;

  FOR j IN 1 .. 2 LOOP   --Глупый код лечит ограничение первичного ключа на быстрых каналах при опросе месячных и суточных в одну секунду
   BEGIN
    FOR i IN 1 .. at_data.COUNT LOOP
     INSERT INTO lg_readout
                 (mid, date_time, nsort, vdata
                 )
          VALUES (an_mid, ld_dat, i, at_data (i)
                 );
    END LOOP;

    EXIT;
   EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
     IF j = 1 THEN
      DBMS_LOCK.sleep (1);
      ld_dat := SYSDATE;
     ELSE
      RAISE;
     END IF;
    WHEN OTHERS THEN
     RAISE;
   END;
  END LOOP;
 EXCEPTION
  WHEN OTHERS THEN
   ROLLBACK TO SAVEPOINT set_readout_zxb_sp;
   raise_application_error (-20001, 'comsrv_pg.set_readout_zxb: ' || SQLERRM (SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
 --Вставка листинга графика нвгрузки
 PROCEDURE set_loadprof_zxb (an_mid NUMBER, at_data common_pg.tt_varchar2) IS
  ld_dat   DATE DEFAULT SYSDATE;
 BEGIN
  IF util_pg.locksysjournal_f = 1 THEN
   RETURN;
  END IF;

  SAVEPOINT set_loadprof_zxb_sp;

  FOR i IN 1 .. at_data.COUNT LOOP
   INSERT INTO lg_loadprof
               (mid, date_time, nsort, vdata
               )
        VALUES (an_mid, ld_dat, i, at_data (i)
               );
  END LOOP;
 EXCEPTION
  WHEN OTHERS THEN
   ROLLBACK TO SAVEPOINT set_loadprof_zxb_sp;
   raise_application_error (-20001, 'comsrv_pg.set_loadprof_zxb: ' || SQLERRM (SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
  --Вставка суточных
 PROCEDURE set_bill_zxb (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_aerm NUMBER, an_aedm NUMBER, an_aq1m NUMBER, an_aq3m NUMBER,
 an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_derm NUMBER, an_dedm NUMBER,
 an_dq1m NUMBER, an_dq3m NUMBER, av_mtrsn VARCHAR2, an_digits NUMBER,   --Значность счетчика
                                                                     ad_date DATE
 ) IS
 BEGIN
  set_bill_meter (an_mid, an_erm, an_edm, an_q1m, an_q3m, NULL, NULL, an_aerm, an_aedm, an_aq1m, an_aq3m, NULL, NULL, an_berm, an_bedm, an_bq1m, an_bq3m, NULL,
                  NULL, an_cerm, an_cedm, an_cq1m, an_cq3m, NULL, NULL, an_derm, an_dedm, an_dq1m, an_dq3m, NULL, NULL, av_mtrsn, an_digits, ad_date);
 END;

------------------------------------------------------------------------------------------------------------------------
  --Вставка месячных
 PROCEDURE set_months_zxb (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_aerm NUMBER, an_aedm NUMBER, an_aq1m NUMBER, an_aq3m NUMBER,
 an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_derm NUMBER, an_dedm NUMBER,
 an_dq1m NUMBER, an_dq3m NUMBER, av_mtrsn VARCHAR2, an_digits NUMBER,   --Значность счетчика
                                                                     ad_date DATE
 ) IS
 BEGIN
  set_months_meter (an_mid, an_erm, an_edm, an_q1m, an_q3m, NULL, NULL, an_aerm, an_aedm, an_aq1m, an_aq3m, NULL, NULL, an_berm, an_bedm, an_bq1m, an_bq3m, NULL,
                    NULL, an_cerm, an_cedm, an_cq1m, an_cq3m, NULL, NULL, an_derm, an_dedm, an_dq1m, an_dq3m, NULL, NULL, av_mtrsn, an_digits, ad_date);
 END;

------------------------------------------------------------------------------------------------------------------------
--Расширенный с квадрантами
------------------------------------------------------------------------------------------------------------------------
  --Вставка суточных
 PROCEDURE set_bill_zxb (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_rrm NUMBER, an_rdm NUMBER, an_aerm NUMBER, an_aedm NUMBER, an_arrm NUMBER, an_ardm NUMBER,
 an_berm NUMBER, an_bedm NUMBER, an_brrm NUMBER, an_brdm NUMBER, an_cerm NUMBER, an_cedm NUMBER, an_crrm NUMBER, an_crdm NUMBER, an_derm NUMBER, an_dedm NUMBER,
 an_drrm NUMBER, an_drdm NUMBER, an_q1m NUMBER, an_q2m NUMBER, an_q3m NUMBER, an_q4m NUMBER, an_aq1m NUMBER, an_aq2m NUMBER, an_aq3m NUMBER, an_aq4m NUMBER,
 an_bq1m NUMBER, an_bq2m NUMBER, an_bq3m NUMBER, an_bq4m NUMBER, an_cq1m NUMBER, an_cq2m NUMBER, an_cq3m NUMBER, an_cq4m NUMBER, an_dq1m NUMBER, an_dq2m NUMBER,
 an_dq3m NUMBER, an_dq4m NUMBER, av_mtrsn VARCHAR2, an_digits NUMBER,   --Значность счетчика
                                                                     ad_date DATE
 ) IS
 BEGIN
  IF util_pg.is_indicbyq1234 (an_mid) = 1 THEN
   set_bill_meter (an_mid, an_erm, an_edm, an_q1m, an_q3m, an_q2m, an_q4m, an_aerm, an_aedm, an_aq1m, an_aq3m, an_aq2m, an_aq4m, an_berm, an_bedm, an_bq1m, an_bq3m,
                   an_bq2m, an_bq4m, an_cerm, an_cedm, an_cq1m, an_cq3m, an_cq2m, an_cq4m, an_derm, an_dedm, an_dq1m, an_dq3m, an_dq2m, an_dq4m, av_mtrsn,
                   an_digits, ad_date);
  ELSE
   set_bill_meter (an_mid, an_erm, an_edm, an_rrm, an_rdm, NULL, NULL, an_aerm, an_aedm, an_arrm, an_ardm, NULL, NULL, an_berm, an_bedm, an_brrm, an_brdm, NULL,
                   NULL, an_cerm, an_cedm, an_crrm, an_crdm, NULL, NULL, an_derm, an_dedm, an_drrm, an_drdm, NULL, NULL, av_mtrsn, an_digits, ad_date);
  END IF;
 END;

------------------------------------------------------------------------------------------------------------------------
 --Вставка месячных
 PROCEDURE set_months_zxb (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_rrm NUMBER, an_rdm NUMBER, an_aerm NUMBER, an_aedm NUMBER, an_arrm NUMBER, an_ardm NUMBER,
 an_berm NUMBER, an_bedm NUMBER, an_brrm NUMBER, an_brdm NUMBER, an_cerm NUMBER, an_cedm NUMBER, an_crrm NUMBER, an_crdm NUMBER, an_derm NUMBER, an_dedm NUMBER,
 an_drrm NUMBER, an_drdm NUMBER, an_q1m NUMBER, an_q2m NUMBER, an_q3m NUMBER, an_q4m NUMBER, an_aq1m NUMBER, an_aq2m NUMBER, an_aq3m NUMBER, an_aq4m NUMBER,
 an_bq1m NUMBER, an_bq2m NUMBER, an_bq3m NUMBER, an_bq4m NUMBER, an_cq1m NUMBER, an_cq2m NUMBER, an_cq3m NUMBER, an_cq4m NUMBER, an_dq1m NUMBER, an_dq2m NUMBER,
 an_dq3m NUMBER, an_dq4m NUMBER, av_mtrsn VARCHAR2, an_digits NUMBER,   --Значность счетчика
                                                                     ad_date DATE
 ) IS
 BEGIN
  IF util_pg.is_indicbyq1234 (an_mid) = 1 THEN
   set_months_meter (an_mid, an_erm, an_edm, an_q1m, an_q3m, an_q2m, an_q4m, an_aerm, an_aedm, an_aq1m, an_aq3m, an_aq2m, an_aq4m, an_berm, an_bedm, an_bq1m,
                     an_bq3m, an_bq2m, an_bq4m, an_cerm, an_cedm, an_cq1m, an_cq3m, an_cq2m, an_cq4m, an_derm, an_dedm, an_dq1m, an_dq3m, an_dq2m, an_dq4m,
                     av_mtrsn, an_digits, ad_date);
  ELSE
   set_months_meter (an_mid, an_erm, an_edm, an_rrm, an_rdm, NULL, NULL, an_aerm, an_aedm, an_arrm, an_ardm, NULL, NULL, an_berm, an_bedm, an_brrm, an_brdm, NULL,
                     NULL, an_cerm, an_cedm, an_crrm, an_crdm, NULL, NULL, an_derm, an_dedm, an_drrm, an_drdm, NULL, NULL, av_mtrsn, an_digits, ad_date);
  END IF;
 END;

------------------------------------------------------------------------------------------------------------------------
--******************************          A1R             *******************************************************--
------------------------------------------------------------------------------------------------------------------------
 --Вставка текущих
 PROCEDURE set_curr_power_a1r (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, ad_date DATE) IS
 BEGIN
  set_curr_power_meter (an_mid, an_erm, an_edm, an_q1m, an_q3m, an_q2m, an_q4m, ad_date);
 END;

-----------------------------------------------------------------------------------------------------------------------
 --Вставка графика нагрузки
 PROCEDURE set_halfhour_a1r (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, ad_date DATE) IS
 BEGIN
  set_halfhour_meter (an_mid, ROUND (an_er, cn_roundalpha), ROUND (an_ed, cn_roundalpha), ROUND (an_q1, cn_roundalpha), ROUND (an_q3, cn_roundalpha), NULL, NULL,
                      NULL, cn_a1r, NULL, ad_date, NULL);
 END;

------------------------------------------------------------------------------------------------------------------------
  --Вставка суточных
 PROCEDURE set_bill_a1r (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_aerm NUMBER, an_aedm NUMBER,
 an_aq1m NUMBER, an_aq3m NUMBER, an_aq2m NUMBER, an_aq4m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_bq2m NUMBER, an_bq4m NUMBER,
 an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_cq2m NUMBER, an_cq4m NUMBER, an_derm NUMBER, an_dedm NUMBER, an_dq1m NUMBER, an_dq3m NUMBER,
 an_dq2m NUMBER, an_dq4m NUMBER, av_mtrsn VARCHAR2, an_digits NUMBER,   --Значность счетчика, необходимо передать 6 - A1R_ParamCalc.DPLocE
                                                                     ad_date DATE
 ) IS
  ln_round   NUMBER DEFAULT 5;
 BEGIN
  IF util_pg.get_customer_id = 10 THEN
   SELECT NVL (MAX (3), ln_round)
     INTO ln_round
     FROM points
    WHERE mid = an_mid AND PARENT IN (1737, 1742);
  END IF;

  set_bill_meter (an_mid, ROUND (an_erm, ln_round), ROUND (an_edm, ln_round), ROUND (an_q1m, ln_round), ROUND (an_q3m, ln_round), ROUND (an_q2m, ln_round),
                  ROUND (an_q4m, ln_round), ROUND (an_aerm, ln_round), ROUND (an_aedm, ln_round), ROUND (an_aq1m, ln_round), ROUND (an_aq3m, ln_round),
                  ROUND (an_aq2m, ln_round), ROUND (an_aq4m, ln_round), ROUND (an_berm, ln_round), ROUND (an_bedm, ln_round), ROUND (an_bq1m, ln_round),
                  ROUND (an_bq3m, ln_round), ROUND (an_bq2m, ln_round), ROUND (an_bq4m, ln_round), ROUND (an_cerm, ln_round), ROUND (an_cedm, ln_round),
                  ROUND (an_cq1m, ln_round), ROUND (an_cq3m, ln_round), ROUND (an_cq2m, ln_round), ROUND (an_cq4m, ln_round), ROUND (an_derm, ln_round),
                  ROUND (an_dedm, ln_round), ROUND (an_dq1m, ln_round), ROUND (an_dq3m, ln_round), ROUND (an_dq2m, ln_round), ROUND (an_dq4m, ln_round), av_mtrsn,
                  an_digits, ad_date);
 END;

------------------------------------------------------------------------------------------------------------------------
  --Вставка месячных
 PROCEDURE set_months_a1r (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_aerm NUMBER, an_aedm NUMBER,
 an_aq1m NUMBER, an_aq3m NUMBER, an_aq2m NUMBER, an_aq4m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_bq2m NUMBER, an_bq4m NUMBER,
 an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_cq2m NUMBER, an_cq4m NUMBER, an_derm NUMBER, an_dedm NUMBER, an_dq1m NUMBER, an_dq3m NUMBER,
 an_dq2m NUMBER, an_dq4m NUMBER, av_mtrsn VARCHAR2, an_digits NUMBER,   --Значность счетчика, необходимо передать 6 - A1R_ParamCalc.DPLocE
                                                                     ad_date DATE
 ) IS
  ln_round   NUMBER DEFAULT 5;
 BEGIN
  IF util_pg.get_customer_id = 10 THEN
   SELECT NVL (MAX (3), ln_round)
     INTO ln_round
     FROM points
    WHERE mid = an_mid AND PARENT IN (1737, 1742);
  END IF;

  set_months_meter (an_mid, ROUND (an_erm, ln_round), ROUND (an_edm, ln_round), ROUND (an_q1m, ln_round), ROUND (an_q3m, ln_round), ROUND (an_q2m, ln_round),
                    ROUND (an_q4m, ln_round), ROUND (an_aerm, ln_round), ROUND (an_aedm, ln_round), ROUND (an_aq1m, ln_round), ROUND (an_aq3m, ln_round),
                    ROUND (an_aq2m, ln_round), ROUND (an_aq4m, ln_round), ROUND (an_berm, ln_round), ROUND (an_bedm, ln_round), ROUND (an_bq1m, ln_round),
                    ROUND (an_bq3m, ln_round), ROUND (an_bq2m, ln_round), ROUND (an_bq4m, ln_round), ROUND (an_cerm, ln_round), ROUND (an_cedm, ln_round),
                    ROUND (an_cq1m, ln_round), ROUND (an_cq3m, ln_round), ROUND (an_cq2m, ln_round), ROUND (an_cq4m, ln_round), ROUND (an_derm, ln_round),
                    ROUND (an_dedm, ln_round), ROUND (an_dq1m, ln_round), ROUND (an_dq3m, ln_round), ROUND (an_dq2m, ln_round), ROUND (an_dq4m, ln_round), av_mtrsn,
                    an_digits, ad_date);
 END;

------------------------------------------------------------------------------------------------------------------------
--******************************          Alpha           *******************************************************--
------------------------------------------------------------------------------------------------------------------------
 --Вставка текущих
 PROCEDURE set_curr_power_alpha (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_rrm NUMBER, an_rdm NUMBER, an_q1m NUMBER, an_q2m NUMBER, an_q3m NUMBER,
 an_q4m NUMBER, ad_date DATE
 ) IS
 BEGIN
  IF util_pg.is_indicbyq1234 (an_mid) = 1 THEN
   set_curr_power_meter (an_mid, an_erm, an_edm, an_q1m, an_q3m, an_q2m, an_q4m, ad_date);
  ELSE
   set_curr_power_meter (an_mid, an_erm, an_edm, an_rrm, an_rdm, NULL, NULL, ad_date);
  END IF;
 END;

-----------------------------------------------------------------------------------------------------------------------
 --Вставка параметров сети
 PROCEDURE set_net_param_alpha (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_volt1 NUMBER, an_volt2 NUMBER, an_volt3 NUMBER,
 an_curr1 NUMBER, an_curr2 NUMBER, an_curr3 NUMBER, an_fiu1 NUMBER, an_fiu2 NUMBER, an_fiu3 NUMBER, an_fii1 NUMBER, an_fii2 NUMBER, an_fii3 NUMBER, an_cos_fi NUMBER,
 ad_date DATE
 ) IS
  ln_er     NUMBER DEFAULT an_er;
  ln_ed     NUMBER DEFAULT an_ed;
  ln_q1     NUMBER DEFAULT an_q1;
  ln_q3     NUMBER DEFAULT an_q3;
  ln_fiu1   NUMBER DEFAULT an_fiu1;
  ln_fiu2   NUMBER DEFAULT an_fiu2;
  ln_fiu3   NUMBER DEFAULT an_fiu3;
  ln_fii1   NUMBER DEFAULT an_fii1;
  ln_fii2   NUMBER DEFAULT an_fii2;
  ln_fii3   NUMBER DEFAULT an_fii3;
 BEGIN
  util_pg.chdr (an_mid, ln_er, ln_ed, ln_q1, ln_q3);
  convert_corners (0, ln_fiu1, ln_fiu2, ln_fiu3, ln_fii1, ln_fii2, ln_fii3);

  IF util_pg.get_typecalcpower (an_mid) = 1 THEN
   UPDATE curr_power
      SET cosf = an_cos_fi,
          volt = an_volt1,
          volt2 = an_volt2,
          volt3 = an_volt3,
          currento = an_curr1,
          curr2 = an_curr2,
          curr3 = an_curr3,
          nfiu1 = ln_fiu1,
          nfiu2 = ln_fiu2,
          nfiu3 = ln_fiu3,
          nfii1 = ln_fii1,
          nfii2 = ln_fii2,
          nfii3 = ln_fii3
    WHERE mid = an_mid;
  ELSE
   UPDATE curr_power
      SET er = ln_er,
          ed = ln_ed,
          q1 = ln_q1,
          q3 = ln_q3,
          cosf = an_cos_fi,
          volt = an_volt1,
          volt2 = an_volt2,
          volt3 = an_volt3,
          currento = an_curr1,
          curr2 = an_curr2,
          curr3 = an_curr3,
          nfiu1 = ln_fiu1,
          nfiu2 = ln_fiu2,
          nfiu3 = ln_fiu3,
          nfii1 = ln_fii1,
          nfii2 = ln_fii2,
          nfii3 = ln_fii3
    WHERE mid = an_mid;

   das_pg.insert_cp_in_profile (an_mid);
  END IF;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error (-20001, 'comsrv_pg.set_net_param_alpha: ' || SQLERRM (SQLCODE));
 END;

-----------------------------------------------------------------------------------------------------------------------
 PROCEDURE set_halfhour_alpha (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, ad_date DATE, an_period NUMBER) IS
 BEGIN
  set_halfhour_alpha (an_mid, an_er, an_ed, an_q1, an_q3, NULL, NULL, ad_date, an_period);
 END;

-----------------------------------------------------------------------------------------------------------------------
 --Вставка графика нагрузки
 PROCEDURE set_halfhour_alpha (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, ad_date DATE, an_period NUMBER) IS
 BEGIN
  set_halfhour_meter (an_mid, ROUND (an_er, cn_roundalpha), ROUND (an_ed, cn_roundalpha), ROUND (an_q1, cn_roundalpha), ROUND (an_q3, cn_roundalpha),
                      ROUND (an_q2, cn_roundalpha), ROUND (an_q4, cn_roundalpha), NULL, cn_ea, NULL, ad_date, an_period);
 END;

------------------------------------------------------------------------------------------------------------------------
  --Вставка суточных
 PROCEDURE set_bill_alpha (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_rrm NUMBER, an_rdm NUMBER, an_aerm NUMBER, an_aedm NUMBER, an_aq1m NUMBER, an_aq3m NUMBER,
 an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_derm NUMBER, an_dedm NUMBER,
 an_dq1m NUMBER, an_dq3m NUMBER, an_q1m NUMBER, an_q2m NUMBER, an_q3m NUMBER, an_q4m NUMBER, av_mtrsn VARCHAR2, an_digits NUMBER,   --Значность счетчика, необходимо передать 6 - Alpha_ParamCalc.DPLocE
 ad_date DATE
 ) IS
  ln_round   NUMBER DEFAULT 5;
 BEGIN
  IF util_pg.get_customer_id = 10 THEN
   SELECT NVL (MAX (3), ln_round)
     INTO ln_round
     FROM points
    WHERE mid = an_mid AND PARENT IN (1737, 1742);
  END IF;

  IF util_pg.is_indicbyq1234 (an_mid) = 1 THEN
   set_bill_meter (an_mid, ROUND (an_erm, ln_round), ROUND (an_edm, ln_round), ROUND (an_q1m, ln_round), ROUND (an_q3m, ln_round), ROUND (an_q2m, ln_round),
                   ROUND (an_q4m, ln_round), ROUND (an_aerm, ln_round), ROUND (an_aedm, ln_round), ROUND (an_aq1m, ln_round), ROUND (an_aq3m, ln_round), NULL, NULL,
                   ROUND (an_berm, ln_round), ROUND (an_bedm, ln_round), ROUND (an_bq1m, ln_round), ROUND (an_bq3m, ln_round), NULL, NULL,
                   ROUND (an_cerm, ln_round), ROUND (an_cedm, ln_round), ROUND (an_cq1m, ln_round), ROUND (an_cq3m, ln_round), NULL, NULL,
                   ROUND (an_derm, ln_round), ROUND (an_dedm, ln_round), ROUND (an_dq1m, ln_round), ROUND (an_dq3m, ln_round), NULL, NULL, av_mtrsn, an_digits,
                   ad_date);
  ELSE
   set_bill_meter (an_mid, ROUND (an_erm, ln_round), ROUND (an_edm, ln_round), ROUND (an_rrm, ln_round), ROUND (an_rdm, ln_round), NULL, NULL,
                   ROUND (an_aerm, ln_round), ROUND (an_aedm, ln_round), ROUND (an_aq1m, ln_round), ROUND (an_aq3m, ln_round), NULL, NULL,
                   ROUND (an_berm, ln_round), ROUND (an_bedm, ln_round), ROUND (an_bq1m, ln_round), ROUND (an_bq3m, ln_round), NULL, NULL,
                   ROUND (an_cerm, ln_round), ROUND (an_cedm, ln_round), ROUND (an_cq1m, ln_round), ROUND (an_cq3m, ln_round), NULL, NULL,
                   ROUND (an_derm, ln_round), ROUND (an_dedm, ln_round), ROUND (an_dq1m, ln_round), ROUND (an_dq3m, ln_round), NULL, NULL, av_mtrsn, an_digits,
                   ad_date);
  END IF;
 END;

------------------------------------------------------------------------------------------------------------------------
  --Вставка месячных
 PROCEDURE set_months_alpha (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_rrm NUMBER, an_rdm NUMBER, an_aerm NUMBER, an_aedm NUMBER, an_aq1m NUMBER,
 an_aq3m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_derm NUMBER,
 an_dedm NUMBER, an_dq1m NUMBER, an_dq3m NUMBER, an_q1m NUMBER, an_q2m NUMBER, an_q3m NUMBER, an_q4m NUMBER, av_mtrsn VARCHAR2, an_digits NUMBER,   --Значность счетчика, необходимо передать 6 - Alpha_ParamCalc.DPLocE
 ad_date DATE
 ) IS
  ln_round   NUMBER DEFAULT 5;
 BEGIN
  IF util_pg.get_customer_id = 10 THEN
   SELECT NVL (MAX (3), ln_round)
     INTO ln_round
     FROM points
    WHERE mid = an_mid AND PARENT IN (1737, 1742);
  END IF;

  IF util_pg.is_indicbyq1234 (an_mid) = 1 THEN
   set_months_meter (an_mid, ROUND (an_erm, ln_round), ROUND (an_edm, ln_round), ROUND (an_q1m, ln_round), ROUND (an_q3m, ln_round), ROUND (an_q2m, ln_round),
                     ROUND (an_q4m, ln_round), ROUND (an_aerm, ln_round), ROUND (an_aedm, ln_round), ROUND (an_aq1m, ln_round), ROUND (an_aq3m, ln_round), NULL,
                     NULL, ROUND (an_berm, ln_round), ROUND (an_bedm, ln_round), ROUND (an_bq1m, ln_round), ROUND (an_bq3m, ln_round), NULL, NULL,
                     ROUND (an_cerm, ln_round), ROUND (an_cedm, ln_round), ROUND (an_cq1m, ln_round), ROUND (an_cq3m, ln_round), NULL, NULL,
                     ROUND (an_derm, ln_round), ROUND (an_dedm, ln_round), ROUND (an_dq1m, ln_round), ROUND (an_dq3m, ln_round), NULL, NULL, av_mtrsn, an_digits,
                     ad_date);
  ELSE
   set_months_meter (an_mid, ROUND (an_erm, ln_round), ROUND (an_edm, ln_round), ROUND (an_rrm, ln_round), ROUND (an_rdm, ln_round), NULL, NULL,
                     ROUND (an_aerm, ln_round), ROUND (an_aedm, ln_round), ROUND (an_aq1m, ln_round), ROUND (an_aq3m, ln_round), NULL, NULL,
                     ROUND (an_berm, ln_round), ROUND (an_bedm, ln_round), ROUND (an_bq1m, ln_round), ROUND (an_bq3m, ln_round), NULL, NULL,
                     ROUND (an_cerm, ln_round), ROUND (an_cedm, ln_round), ROUND (an_cq1m, ln_round), ROUND (an_cq3m, ln_round), NULL, NULL,
                     ROUND (an_derm, ln_round), ROUND (an_dedm, ln_round), ROUND (an_dq1m, ln_round), ROUND (an_dq3m, ln_round), NULL, NULL, av_mtrsn, an_digits,
                     ad_date);
  END IF;
 END;

------------------------------------------------------------------------------------------------------------------------
 --******************************          Metkom              *******************************************************--
 ------------------------------------------------------------------------------------------------------------------------
  --Вставка графика нагрузки
 PROCEDURE set_halfhour_metcom (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, ad_date DATE) IS
  ln_er     NUMBER DEFAULT an_er;
  ln_ed     NUMBER DEFAULT an_ed;
  ln_q1     NUMBER DEFAULT an_q1;
  ln_q3     NUMBER DEFAULT an_q3;
  ln_delt   NUMBER DEFAULT 6;
 BEGIN
  util_pg.chdr (an_mid, ln_er, ln_ed, ln_q1, ln_q3);

  IF util_pg.get_customer_id = 3 THEN
   UPDATE curr_power
      SET er = ln_er * ln_delt,
          ed = ln_ed * ln_delt,
          q1 = ln_q1 * ln_delt,
          q3 = ln_q3 * ln_delt,
          obsolete = 0,
          date_time = ad_date
    WHERE mid = an_mid;
  END IF;

  set_halfhour_meter (an_mid, an_er, an_ed, an_q1, an_q3, NULL, NULL, NULL, cn_metkom, NULL, util_pg.to_unlocaltime_if_new (ad_date), NULL);
 END;

------------------------------------------------------------------------------------------------------------------------
 PROCEDURE set_traffic_fag12 (an_mid NUMBER, at_data common_pg.tt_varchar2) IS
 BEGIN
  set_loadprof_zxb (an_mid, at_data);
 END;

------------------------------------------------------------------------------------------------------------------------
  --Процедура проверки доступности коррекции времени УСД Fag-12
 FUNCTION get_acc_time_correct_fag12 (an_cid NUMBER   -- Ид канала (возврат 1-Можно, 0- нельзя)
                                                   )
  RETURN NUMBER IS
  ln_dif     NUMBER;
  ln_limit   NUMBER DEFAULT 8 * 60;
 BEGIN
  --  RETURN 1;
  SELECT (SYSDATE - MIN (halfhour)) * 24 * 3600
    INTO ln_dif
    FROM last_save
   WHERE mid IN (SELECT cid
                   FROM channels
                  WHERE protocol_id IN (24, 25));

  IF ln_dif < ln_limit THEN
   RETURN 1;
  ELSE
   RETURN 0;
  END IF;
 END;

------------------------------------------------------------------------------------------------------------------------
 --Установка состояния и величины расхождения системного таймера Fag-12
 PROCEDURE set_time_info_fag12 (an_cid NUMBER,   -- Ид канала
                                              an_state NUMBER,   -- Состояние (0 -Расхождение в норме, 1-Расхождение в пределах коррекции (требуется коррекция),2-Рассхождение привысило верхнюю величину)
 an_value NUMBER   --Величина рассхождения в секундах
 ) IS
  lv_text        VARCHAR2 (2000) DEFAULT 'Время устройства сбора Fag-12 расходится с системным на ' || an_value || ' сек.';
  ln_procedure   NUMBER          DEFAULT 16;
 BEGIN
  IF an_state = 0 THEN
   DELETE FROM check_status
         WHERE nprocedure = ln_procedure;

   RETURN;
  END IF;

  UPDATE check_status
     SET ddate = SYSDATE,
         vtext = lv_text
   WHERE nprocedure = ln_procedure;

  IF SQL%ROWCOUNT = 0 THEN
   INSERT INTO check_status
               (nprocedure, ddate, vtext
               )
        VALUES (ln_procedure, SYSDATE, lv_text
               );
  END IF;
 END;

 ------------------------------------------------------------------------------------------------------------------------
 --******************************          RTU                 *******************************************************--
------------------------------------------------------------------------------------------------------------------------
  --Вставка графика нагрузки
 PROCEDURE set_halfhour_rtu (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, ad_date DATE) IS
 BEGIN
  set_halfhour_meter (an_mid, ROUND (an_er / 2, cn_roundrtu), ROUND (an_ed / 2, cn_roundrtu), ROUND (an_q1 / 2, cn_roundrtu), ROUND (an_q3 / 2, cn_roundrtu), NULL,
                      NULL, NULL, cn_rtu, NULL, util_pg.to_unlocaltime_if_new (ad_date), NULL);
 END;

-----------------------------------------------------------------------------------------------------------------------
   --Вставка суточных расходов и показаний
 PROCEDURE set_bill_rtu (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, an_erm NUMBER, an_edm NUMBER,
 an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, ad_date DATE
 ) IS
  ln_er           NUMBER         DEFAULT ROUND (an_er, cn_roundrtu);
  ln_ed           NUMBER         DEFAULT ROUND (an_ed, cn_roundrtu);
  ln_q1           NUMBER         DEFAULT ROUND (an_q1, cn_roundrtu);
  ln_q3           NUMBER         DEFAULT ROUND (an_q3, cn_roundrtu);
  ln_q2           NUMBER         DEFAULT ROUND (an_q2, cn_roundrtu);
  ln_q4           NUMBER         DEFAULT ROUND (an_q4, cn_roundrtu);
  ln_erm          NUMBER         DEFAULT ROUND (an_erm, cn_roundrtu);
  ln_edm          NUMBER         DEFAULT ROUND (an_edm, cn_roundrtu);
  ln_q1m          NUMBER         DEFAULT ROUND (an_q1m, cn_roundrtu);
  ln_q3m          NUMBER         DEFAULT ROUND (an_q3m, cn_roundrtu);
  ln_q2m          NUMBER         DEFAULT ROUND (an_q2m, cn_roundrtu);
  ln_q4m          NUMBER         DEFAULT ROUND (an_q4m, cn_roundrtu);
  ld_last_date    DATE;
  ln_data_found   NUMBER         DEFAULT 0;
  ln_digits       NUMBER;
  ln_delta        NUMBER         DEFAULT 100;
  ln_kc           NUMBER;
  lv_name         VARCHAR2 (200);
  ln_com          NUMBER;
  ln_ers          NUMBER;
  ln_eds          NUMBER;
  ln_q1s          NUMBER;
  ln_q3s          NUMBER;
  ln_q2s          NUMBER;
  ln_q4s          NUMBER;
  ln_erm_old      NUMBER;
  ln_edm_old      NUMBER;
  ln_q1m_old      NUMBER;
  ln_q3m_old      NUMBER;
  ln_q2m_old      NUMBER;
  ln_q4m_old      NUMBER;
  ln_metcontrol   NUMBER         DEFAULT util_pg.getparamvalue_f (31);
 BEGIN
  util_pg.chdr (an_mid, ln_er, ln_ed, ln_q1, ln_q3, ln_q2, ln_q4);
  util_pg.chdr (an_mid, ln_erm, ln_edm, ln_q1m, ln_q3m, ln_q2m, ln_q4m);

  BEGIN
   SELECT kc
     INTO ln_kc
     FROM feeders
    WHERE mid = an_mid;

   SELECT NAME
     INTO lv_name
     FROM points
    WHERE mid = an_mid;

   SELECT MAX (com_id)
     INTO ln_com
     FROM channels c, chanpoint cp
    WHERE cp.mid = an_mid AND c.cid = cp.cid;

   SELECT LENGTH (TRUNC (digits))
     INTO ln_digits
     FROM meters
    WHERE mid = an_mid AND entype = 7;

   ln_data_found := 1;
  EXCEPTION
   WHEN NO_DATA_FOUND THEN
    ln_data_found := 0;
  END;

  IF ln_data_found = 1 THEN
   BEGIN
    SELECT MAX (date_time)
      INTO ld_last_date
      FROM billorg
     WHERE mid = an_mid AND nsource = 10 AND date_time < ad_date AND erm IS NOT NULL;

    SELECT erm
      INTO ln_erm_old
      FROM billorg
     WHERE mid = an_mid AND nsource = 10 AND date_time = ld_last_date;

    SELECT NVL (SUM (er), 0)
      INTO ln_ers
      FROM billorg
     WHERE mid = an_mid AND nsource = 10 AND date_time > ld_last_date AND date_time < ad_date;
   EXCEPTION
    WHEN NO_DATA_FOUND THEN
     ln_erm_old := NULL;
   END;

   BEGIN
    SELECT MAX (date_time)
      INTO ld_last_date
      FROM billorg
     WHERE mid = an_mid AND nsource = 10 AND date_time < ad_date AND edm IS NOT NULL;

    SELECT edm
      INTO ln_edm_old
      FROM billorg
     WHERE mid = an_mid AND nsource = 10 AND date_time = ld_last_date;

    SELECT NVL (SUM (ed), 0)
      INTO ln_eds
      FROM billorg
     WHERE mid = an_mid AND nsource = 10 AND date_time > ld_last_date AND date_time < ad_date;
   EXCEPTION
    WHEN NO_DATA_FOUND THEN
     ln_edm_old := NULL;
   END;

   BEGIN
    SELECT MAX (date_time)
      INTO ld_last_date
      FROM billorg
     WHERE mid = an_mid AND nsource = 10 AND date_time < ad_date AND q1m IS NOT NULL;

    SELECT q1m
      INTO ln_q1m_old
      FROM billorg
     WHERE mid = an_mid AND nsource = 10 AND date_time = ld_last_date;

    SELECT NVL (SUM (q1), 0)
      INTO ln_q1s
      FROM billorg
     WHERE mid = an_mid AND nsource = 10 AND date_time > ld_last_date AND date_time < ad_date;
   EXCEPTION
    WHEN NO_DATA_FOUND THEN
     ln_q1m_old := NULL;
   END;

   BEGIN
    SELECT MAX (date_time)
      INTO ld_last_date
      FROM billorg
     WHERE mid = an_mid AND nsource = 10 AND date_time < ad_date AND q2m IS NOT NULL;

    SELECT q2m
      INTO ln_q2m_old
      FROM billorg
     WHERE mid = an_mid AND nsource = 10 AND date_time = ld_last_date;

    SELECT NVL (SUM (q2), 0)
      INTO ln_q2s
      FROM billorg
     WHERE mid = an_mid AND nsource = 10 AND date_time > ld_last_date AND date_time < ad_date;
   EXCEPTION
    WHEN NO_DATA_FOUND THEN
     ln_q2m_old := NULL;
   END;

   BEGIN
    SELECT MAX (date_time)
      INTO ld_last_date
      FROM billorg
     WHERE mid = an_mid AND nsource = 10 AND date_time < ad_date AND q3m IS NOT NULL;

    SELECT q3m
      INTO ln_q3m_old
      FROM billorg
     WHERE mid = an_mid AND nsource = 10 AND date_time = ld_last_date;

    SELECT NVL (SUM (q3), 0)
      INTO ln_q3s
      FROM billorg
     WHERE mid = an_mid AND nsource = 10 AND date_time > ld_last_date AND date_time < ad_date;
   EXCEPTION
    WHEN NO_DATA_FOUND THEN
     ln_q3m_old := NULL;
   END;

   BEGIN
    SELECT MAX (date_time)
      INTO ld_last_date
      FROM billorg
     WHERE mid = an_mid AND nsource = 10 AND date_time < ad_date AND q4m IS NOT NULL;

    SELECT q4m
      INTO ln_q4m_old
      FROM billorg
     WHERE mid = an_mid AND nsource = 10 AND date_time = ld_last_date;

    SELECT NVL (SUM (q4), 0)
      INTO ln_q4s
      FROM billorg
     WHERE mid = an_mid AND nsource = 10 AND date_time > ld_last_date AND date_time < ad_date;
   EXCEPTION
    WHEN NO_DATA_FOUND THEN
     ln_q4m_old := NULL;
   END;

   /*       SELECT nvl(SUM(er),0), nvl(SUM(ed),0), nvl(SUM(q1),0), nvl(SUM(q3),0), nvl(SUM(q2),0), nvl(SUM(q4),0) INTO ln_erS, ln_edS, ln_q1S, ln_q3S, ln_q2S, ln_q4S
          FROM billorg WHERE mid = an_mid AND nsource = 10 AND date_time > ld_last_date AND date_time < ad_date;
   */
   IF util_pg.indicoverturn (ln_erm - ln_erm_old, ln_digits) * ln_kc IS NOT NULL
      AND ((util_pg.indicoverturn (ln_erm - ln_erm_old, ln_digits) * ln_kc) - ln_delta > ln_ers + ln_er
           OR (util_pg.indicoverturn (ln_erm - ln_erm_old, ln_digits) * ln_kc) + ln_delta < ln_ers + ln_er
           OR (util_pg.indicoverturn (ln_erm - ln_erm_old, ln_digits) * ln_kc) < ln_ers + ln_er - ln_delta
           OR (util_pg.indicoverturn (ln_erm - ln_erm_old, ln_digits) * ln_kc) > ln_ers + ln_er + ln_delta
          ) THEN
    admin_pg.set_comport_event_p (ln_com, lv_name || '--> !!! Показания < erm > некорректны !!!  ' || ln_erm);

    IF ln_metcontrol = 1 THEN
     ln_erm := NULL;
    END IF;
   END IF;

   IF util_pg.indicoverturn (ln_edm - ln_edm_old, ln_digits) * ln_kc IS NOT NULL
      AND ((util_pg.indicoverturn (ln_edm - ln_edm_old, ln_digits) * ln_kc) - ln_delta > ln_eds + ln_ed
           OR (util_pg.indicoverturn (ln_edm - ln_edm_old, ln_digits) * ln_kc) + ln_delta < ln_eds + ln_ed
           OR (util_pg.indicoverturn (ln_edm - ln_edm_old, ln_digits) * ln_kc) < ln_eds + ln_ed - ln_delta
           OR (util_pg.indicoverturn (ln_edm - ln_edm_old, ln_digits) * ln_kc) > ln_eds + ln_ed + ln_delta
          ) THEN
    admin_pg.set_comport_event_p (ln_com, lv_name || '--> !!! Показания < edm > некорректны !!!  ' || ln_edm);

    IF ln_metcontrol = 1 THEN
     ln_edm := NULL;
    END IF;
   END IF;

   IF util_pg.indicoverturn (ln_q1m - ln_q1m_old, ln_digits) * ln_kc IS NOT NULL
      AND ((util_pg.indicoverturn (ln_q1m - ln_q1m_old, ln_digits) * ln_kc) - ln_delta > ln_q1s + ln_q1
           OR (util_pg.indicoverturn (ln_q1m - ln_q1m_old, ln_digits) * ln_kc) + ln_delta < ln_q1s + ln_q1
           OR (util_pg.indicoverturn (ln_q1m - ln_q1m_old, ln_digits) * ln_kc) < ln_q1s + ln_q1 - ln_delta
           OR (util_pg.indicoverturn (ln_q1m - ln_q1m_old, ln_digits) * ln_kc) > ln_q1s + ln_q1 + ln_delta
          ) THEN
    admin_pg.set_comport_event_p (ln_com, lv_name || '--> !!! Показания < q1m > некорректны !!!  ' || ln_q1m);

    IF ln_metcontrol = 1 THEN
     ln_q1m := NULL;
    END IF;
   END IF;

   IF util_pg.indicoverturn (ln_q2m - ln_q2m_old, ln_digits) * ln_kc IS NOT NULL
      AND ((util_pg.indicoverturn (ln_q2m - ln_q2m_old, ln_digits) * ln_kc) - ln_delta > ln_q2s + ln_q2
           OR (util_pg.indicoverturn (ln_q2m - ln_q2m_old, ln_digits) * ln_kc) + ln_delta < ln_q2s + ln_q2
           OR (util_pg.indicoverturn (ln_q2m - ln_q2m_old, ln_digits) * ln_kc) < ln_q2s + ln_q2 - ln_delta
           OR (util_pg.indicoverturn (ln_q2m - ln_q2m_old, ln_digits) * ln_kc) > ln_q2s + ln_q2 + ln_delta
          ) THEN
    admin_pg.set_comport_event_p (ln_com, lv_name || '--> !!! Показания < q2m > некорректны !!!  ' || ln_q2m);

    IF ln_metcontrol = 1 THEN
     ln_q2m := NULL;
    END IF;
   END IF;

   IF util_pg.indicoverturn (ln_q3m - ln_q3m_old, ln_digits) * ln_kc IS NOT NULL
      AND ((util_pg.indicoverturn (ln_q3m - ln_q3m_old, ln_digits) * ln_kc) - ln_delta > ln_q3s + ln_q3
           OR (util_pg.indicoverturn (ln_q3m - ln_q3m_old, ln_digits) * ln_kc) + ln_delta < ln_q3s + ln_q3
           OR (util_pg.indicoverturn (ln_q3m - ln_q3m_old, ln_digits) * ln_kc) < ln_q3s + ln_q3 - ln_delta
           OR (util_pg.indicoverturn (ln_q3m - ln_q3m_old, ln_digits) * ln_kc) > ln_q3s + ln_q3 + ln_delta
          ) THEN
    admin_pg.set_comport_event_p (ln_com, lv_name || '--> !!! Показания < q3m > некорректны !!!  ' || ln_q3m);

    IF ln_metcontrol = 1 THEN
     ln_q3m := NULL;
    END IF;
   END IF;

   IF util_pg.indicoverturn (ln_q4m - ln_q4m_old, ln_digits) * ln_kc IS NOT NULL
      AND ((util_pg.indicoverturn (ln_q4m - ln_q4m_old, ln_digits) * ln_kc) - ln_delta > ln_q4s + ln_q4
           OR (util_pg.indicoverturn (ln_q4m - ln_q4m_old, ln_digits) * ln_kc) + ln_delta < ln_q4s + ln_q4
           OR (util_pg.indicoverturn (ln_q4m - ln_q4m_old, ln_digits) * ln_kc) < ln_q4s + ln_q4 - ln_delta
           OR (util_pg.indicoverturn (ln_q4m - ln_q4m_old, ln_digits) * ln_kc) > ln_q4s + ln_q4 + ln_delta
          ) THEN
    admin_pg.set_comport_event_p (ln_com, lv_name || '--> !!! Показания < q4m > некорректны !!!  ' || ln_q4m);

    IF ln_metcontrol = 1 THEN
     ln_q4m := NULL;
    END IF;
   END IF;
  END IF;

  INSERT INTO billorg
              (mid, er, ed, q1, q3, q2, q4, erm, edm, q1m, q3m, q2m, q4m, date_time, SOURCE, nsource
              )
       VALUES (an_mid, ln_er, ln_ed, ln_q1, ln_q3, ln_q2, ln_q4, ln_erm, ln_edm, ln_q1m, ln_q3m, ln_q2m, ln_q4m, ad_date, 'КС', cn_auto
              );
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error (-20001, 'comsrv_pg.set_bill_rtu: ' || SQLERRM (SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
 --******************************          SCHLUM             *******************************************************--
 ------------------------------------------------------------------------------------------------------------------------

 --Вставка текущих (+ ток в нуле)
 PROCEDURE set_curr_power_schlum (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_freq NUMBER,
 an_cos_fi NUMBER, an_volt1 NUMBER, an_volt2 NUMBER, an_volt3 NUMBER, an_curr1 NUMBER, an_curr2 NUMBER, an_curr3 NUMBER, an_fiu1i1 NUMBER, an_fiu2i2 NUMBER,
 an_fiu3i3 NUMBER, an_fiu1u2 NUMBER, an_fiu1u3 NUMBER, an_fiu2u3 NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER,
 an_i0 NUMBER, ad_date DATE
 ) IS
 BEGIN
  set_curr_power_meter (an_mid, an_erm, an_edm, an_q1m, an_q3m, an_q2m, an_q4m, an_freq, an_cos_fi, an_volt1, an_volt2, an_volt3, an_curr1, an_curr2, an_curr3,
                        an_fiu1i1, an_fiu2i2, an_fiu3i3, an_fiu1u2, an_fiu1u3, an_fiu2u3, an_er, an_ed, an_q1, an_q3, an_q2, an_q4, an_i0, 1, ad_date);
 END;

-----------------------------------------------------------------------------------------------------------------------
 --Вставка текущих
 PROCEDURE set_curr_power_schlum (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_freq NUMBER,
 an_cos_fi NUMBER, an_volt1 NUMBER, an_volt2 NUMBER, an_volt3 NUMBER, an_curr1 NUMBER, an_curr2 NUMBER, an_curr3 NUMBER, an_fiu1i1 NUMBER, an_fiu2i2 NUMBER,
 an_fiu3i3 NUMBER, an_fiu1u2 NUMBER, an_fiu1u3 NUMBER, an_fiu2u3 NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER,
 ad_date DATE
 ) IS
 BEGIN
  set_curr_power_meter (an_mid, an_erm, an_edm, an_q1m, an_q3m, an_q2m, an_q4m, an_freq, an_cos_fi, an_volt1, an_volt2, an_volt3, an_curr1, an_curr2, an_curr3,
                        an_fiu1i1, an_fiu2i2, an_fiu3i3, an_fiu1u2, an_fiu1u3, an_fiu2u3, an_er, an_ed, an_q1, an_q3, an_q2, an_q4, 1, ad_date);
 END;

-----------------------------------------------------------------------------------------------------------------------
 --Вставка графика нагрузки
 PROCEDURE set_halfhour_schlum (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, ad_date DATE, an_period NUMBER,
 an_status NUMBER
 ) IS
 BEGIN
  set_halfhour_meter (an_mid, an_er, an_ed, an_q1, an_q3, an_q2, an_q4, an_status, cn_sl_7000, NULL, ad_date, an_period);
 END;

------------------------------------------------------------------------------------------------------------------------
 --Вставка графика нагрузки по индукционникам
 PROCEDURE set_halfhour_sl_induc (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, ad_date DATE, an_period NUMBER) IS
 BEGIN
  set_halfhour_schlum (an_mid, an_er, an_ed, an_q1, an_q3, an_q2, an_q4, ad_date, an_period);
 END;

-----------------------------------------------------------------------------------------------------------------------
  --Вставка суточных
 PROCEDURE set_bill_schlum (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_aerm NUMBER, an_aedm NUMBER,
 an_aq1m NUMBER, an_aq3m NUMBER, an_aq2m NUMBER, an_aq4m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_bq2m NUMBER, an_bq4m NUMBER,
 an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_cq2m NUMBER, an_cq4m NUMBER, an_derm NUMBER, an_dedm NUMBER, an_dq1m NUMBER, an_dq3m NUMBER,
 an_dq2m NUMBER, an_dq4m NUMBER, av_mtrsn VARCHAR2, an_digits NUMBER,   --Значность счетчика, необходимо передать 6 - A1R_ParamCalc.DPLocE
                                                                     ad_date DATE
 ) IS
  ln_round   NUMBER DEFAULT 5;
 BEGIN
  set_bill_meter (an_mid, ROUND (an_erm, ln_round), ROUND (an_edm, ln_round), ROUND (an_q1m, ln_round), ROUND (an_q3m, ln_round), ROUND (an_q2m, ln_round),
                  ROUND (an_q4m, ln_round), ROUND (an_aerm, ln_round), ROUND (an_aedm, ln_round), ROUND (an_aq1m, ln_round), ROUND (an_aq3m, ln_round),
                  ROUND (an_aq2m, ln_round), ROUND (an_aq4m, ln_round), ROUND (an_berm, ln_round), ROUND (an_bedm, ln_round), ROUND (an_bq1m, ln_round),
                  ROUND (an_bq3m, ln_round), ROUND (an_bq2m, ln_round), ROUND (an_bq4m, ln_round), ROUND (an_cerm, ln_round), ROUND (an_cedm, ln_round),
                  ROUND (an_cq1m, ln_round), ROUND (an_cq3m, ln_round), ROUND (an_cq2m, ln_round), ROUND (an_cq4m, ln_round), ROUND (an_derm, ln_round),
                  ROUND (an_dedm, ln_round), ROUND (an_dq1m, ln_round), ROUND (an_dq3m, ln_round), ROUND (an_dq2m, ln_round), ROUND (an_dq4m, ln_round), av_mtrsn,
                  an_digits, ad_date);
 END;

------------------------------------------------------------------------------------------------------------------------
  --Вставка месячных
 PROCEDURE set_months_schlum (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_aerm NUMBER,
 an_aedm NUMBER, an_aq1m NUMBER, an_aq3m NUMBER, an_aq2m NUMBER, an_aq4m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_bq2m NUMBER,
 an_bq4m NUMBER, an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_cq2m NUMBER, an_cq4m NUMBER, an_derm NUMBER, an_dedm NUMBER, an_dq1m NUMBER,
 an_dq3m NUMBER, an_dq2m NUMBER, an_dq4m NUMBER, av_mtrsn VARCHAR2, an_digits NUMBER,   --Значность счетчика, необходимо передать 6 - A1R_ParamCalc.DPLocE
                                                                                     ad_date DATE
 ) IS
  ln_round   NUMBER DEFAULT 5;
 BEGIN
  set_months_meter (an_mid, ROUND (an_erm, ln_round), ROUND (an_edm, ln_round), ROUND (an_q1m, ln_round), ROUND (an_q3m, ln_round), ROUND (an_q2m, ln_round),
                    ROUND (an_q4m, ln_round), ROUND (an_aerm, ln_round), ROUND (an_aedm, ln_round), ROUND (an_aq1m, ln_round), ROUND (an_aq3m, ln_round),
                    ROUND (an_aq2m, ln_round), ROUND (an_aq4m, ln_round), ROUND (an_berm, ln_round), ROUND (an_bedm, ln_round), ROUND (an_bq1m, ln_round),
                    ROUND (an_bq3m, ln_round), ROUND (an_bq2m, ln_round), ROUND (an_bq4m, ln_round), ROUND (an_cerm, ln_round), ROUND (an_cedm, ln_round),
                    ROUND (an_cq1m, ln_round), ROUND (an_cq3m, ln_round), ROUND (an_cq2m, ln_round), ROUND (an_cq4m, ln_round), ROUND (an_derm, ln_round),
                    ROUND (an_dedm, ln_round), ROUND (an_dq1m, ln_round), ROUND (an_dq3m, ln_round), ROUND (an_dq2m, ln_round), ROUND (an_dq4m, ln_round), av_mtrsn,
                    an_digits, ad_date);
 END;

------------------------------------------------------------------------------------------------------------------------
 --******************************          Energy              *******************************************************--
 ------------------------------------------------------------------------------------------------------------------------
 --Вставка текущих
 PROCEDURE set_curr_power_energy (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_freq NUMBER, an_cos_fi NUMBER, an_volt1 NUMBER,
 an_curr1 NUMBER, an_volt2 NUMBER, an_volt3 NUMBER, an_curr2 NUMBER, an_curr3 NUMBER, ad_date DATE
 ) IS
  ln_er   NUMBER DEFAULT an_er;
  ln_ed   NUMBER DEFAULT an_ed;
  ln_q1   NUMBER DEFAULT an_q1;
  ln_q3   NUMBER DEFAULT an_q3;
 BEGIN
  util_pg.chdr (an_mid, ln_er, ln_ed, ln_q1, ln_q3);

  UPDATE curr_power
     SET er = ln_er,
         ed = ln_ed,
         q1 = ln_q1,
         q3 = ln_q3,
         obsolete = 0,
         date_time = ad_date,
         freq = an_freq,
         cosf = an_cos_fi,
         volt = an_volt1,
         volt2 = an_volt2,
         volt3 = an_volt3,
         currento = an_curr1,
         curr2 = an_curr2,
         curr3 = an_curr3
   WHERE mid = an_mid;

  das_pg.insert_cp_in_profile (an_mid);
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error (-20001, 'comsrv_pg.set_curr_power_energy: ' || SQLERRM (SQLCODE));
 END;

-----------------------------------------------------------------------------------------------------------------------
 --Вставка показаний счетчика
 PROCEDURE set_total_energy (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q2 NUMBER, an_q3 NUMBER, an_q4 NUMBER) IS
  ln_er   NUMBER DEFAULT an_er;
  ln_ed   NUMBER DEFAULT an_ed;
  ln_q1   NUMBER DEFAULT an_q1;
  ln_q2   NUMBER DEFAULT an_q2;
  ln_q3   NUMBER DEFAULT an_q3;
  ln_q4   NUMBER DEFAULT an_q4;
 BEGIN
  util_pg.chdr (an_mid, ln_er, ln_ed, ln_q1, ln_q3, ln_q2, ln_q4);

  UPDATE curr_power
     SET erm = ln_er,
         edm = ln_ed,
         q1m = ln_q1,
         q2m = ln_q2,
         q3m = ln_q3,
         q4m = ln_q4
   WHERE mid = an_mid;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error (-20001, 'comsrv_pg.set_total_energy: ' || SQLERRM (SQLCODE));
 END;

-----------------------------------------------------------------------------------------------------------------------

 --Вставка графика нагрузки
 PROCEDURE set_halfhour_energy (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, ad_date DATE) IS
 BEGIN
  set_halfhour_meter (an_mid, an_er, an_ed, an_q1, an_q3, an_q2, an_q4, NULL, cn_energy9, NULL, ad_date, NULL);
 END;

-----------------------------------------------------------------------------------------------------------------------
   --Вставка графика нагрузки (для упращенной енергии)
 PROCEDURE set_halfhour_energy_simple (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, av_mtrsn VARCHAR2,
 an_status NUMBER, ad_date DATE, an_step NUMBER
 ) IS
  ln_erm       NUMBER              DEFAULT an_erm;
  ln_edm       NUMBER              DEFAULT an_edm;
  ln_q1m       NUMBER              DEFAULT an_q1m;
  ln_q3m       NUMBER              DEFAULT an_q3m;
  ln_q2m       NUMBER              DEFAULT an_q2m;
  ln_q4m       NUMBER              DEFAULT an_q4m;
  ld_winter    DATE                DEFAULT util_pg.to_localtime_if_new (ad_date);

  CURSOR lcur_sel IS
   SELECT date_time, NVL (erm, ln_erm) erm, NVL (edm, ln_edm) edm, NVL (q1m, ln_q1m) q1m, NVL (q3m, ln_q3m) q3m, NVL (q2m, ln_q2m) q2m, NVL (q4m, ln_q4m) q4m
     FROM halfhourtmp
    WHERE mid = an_mid AND date_time = (SELECT MAX (date_time) dt
                                          FROM halfhourtmp
                                         WHERE mid = an_mid AND date_time < ad_date AND nsource = cn_auto)
          AND LPAD (UPPER (TRIM (er_mtrsn)), 20, '0') = LPAD (UPPER (TRIM (av_mtrsn)), 20, '0') AND nsource = cn_auto
   UNION ALL
   SELECT util_pg.to_unlocaltime_if_new (date_time) date_time, NVL (erm, ln_erm) erm, NVL (edm, ln_edm) edm, NVL (q1m, ln_q1m) q1m, NVL (q3m, ln_q3m) q3m,
          NVL (q2m, ln_q2m) q2m, NVL (q4m, ln_q4m) q4m
     FROM halfhour
    WHERE mid = an_mid AND date_time = (SELECT MAX (date_time) dt
                                          FROM halfhourold
                                         WHERE mid = an_mid AND date_time < ld_winter AND (nsource = cn_auto OR nsource = cn_auto + 9))
          AND LPAD (UPPER (TRIM (er_mtrsn)), 20, '0') = LPAD (UPPER (TRIM (av_mtrsn)), 20, '0') AND (nsource >= cn_auto AND nsource <= cn_auto + 9);

  lc           lcur_sel%ROWTYPE;
  lb_found     BOOLEAN;
  ln_kc        NUMBER;
  ln_digits    NUMBER;
  ln_tdigits   NUMBER;
  ln_rn        NUMBER              DEFAULT 10;
  ln_rn1       NUMBER              DEFAULT 3;
  lt_dt        common_pg.tt_date;
  lt_erm       common_pg.tt_number;
  lt_edm       common_pg.tt_number;
  lt_q1m       common_pg.tt_number;
  lt_q3m       common_pg.tt_number;
  lt_q2m       common_pg.tt_number;
  lt_q4m       common_pg.tt_number;
  ln_er        NUMBER;
  ln_ed        NUMBER;
  ln_q1        NUMBER;
  ln_q3        NUMBER;
  ln_q2        NUMBER;
  ln_q4        NUMBER;
  ln_cn        NUMBER              DEFAULT 1;
  ld_date      DATE;
  ln_k         NUMBER;
 BEGIN
  util_pg.chdr (an_mid, ln_erm, ln_edm, ln_q1m, ln_q3m, ln_q2m, ln_q4m);

  OPEN lcur_sel;

  FETCH lcur_sel
   INTO lc;

  lb_found := lcur_sel%FOUND;

  CLOSE lcur_sel;

  IF lb_found THEN
   SELECT NVL (MAX (kc), 1)
     INTO ln_kc
     FROM feeders
    WHERE mid = an_mid;

   SELECT LENGTH (TRUNC (MAX (digits))), NVL (LENGTH (MAX (digits) - TRUNC (MAX (digits))) - 1, ln_rn1)
     INTO ln_digits, ln_rn1
     FROM meters
    WHERE mid = an_mid AND entype = 7;

   --Отсекаем до разрядности
   ln_erm := TRUNC (ln_erm, ln_rn1);
   ln_edm := TRUNC (ln_edm, ln_rn1);
   ln_q1m := TRUNC (ln_q1m, ln_rn1);
   ln_q3m := TRUNC (ln_q3m, ln_rn1);
   ln_q2m := TRUNC (ln_q2m, ln_rn1);
   ln_q4m := TRUNC (ln_q4m, ln_rn1);
   lc.erm := TRUNC (lc.erm, ln_rn1);
   lc.edm := TRUNC (lc.edm, ln_rn1);
   lc.q1m := TRUNC (lc.q1m, ln_rn1);
   lc.q3m := TRUNC (lc.q3m, ln_rn1);
   lc.q2m := TRUNC (lc.q2m, ln_rn1);
   lc.q4m := TRUNC (lc.q4m, ln_rn1);
   --Вычислим разрядность для overindic_to_indic
   ln_tdigits :=
    GREATEST (NVL (ln_digits, 0), NVL (LENGTH (TRUNC (ln_erm)), 0), NVL (LENGTH (TRUNC (lc.erm)), 0), NVL (LENGTH (TRUNC (ln_edm)), 0),
              NVL (LENGTH (TRUNC (lc.edm)), 0), NVL (LENGTH (TRUNC (ln_q1m)), 0), NVL (LENGTH (TRUNC (lc.q1m)), 0), NVL (LENGTH (TRUNC (ln_q3m)), 0),
              NVL (LENGTH (TRUNC (lc.q3m)), 0), NVL (LENGTH (TRUNC (ln_q2m)), 0), NVL (LENGTH (TRUNC (lc.q2m)), 0), NVL (LENGTH (TRUNC (ln_q4m)), 0),
              NVL (LENGTH (TRUNC (lc.q4m)), 0));
   lt_dt (ln_cn) := lc.date_time;
   lt_erm (ln_cn) := lc.erm;
   lt_edm (ln_cn) := lc.edm;
   lt_q1m (ln_cn) := lc.q1m;
   lt_q3m (ln_cn) := lc.q3m;
   lt_q2m (ln_cn) := lc.q2m;
   lt_q4m (ln_cn) := lc.q4m;
   ld_date := util_pg.ceil_d (lc.date_time + 1 / 86400, an_step);   --Чуть больше чем предидущее

   WHILE ld_date <= ad_date LOOP
    ln_cn := ln_cn + 1;
    lt_dt (ln_cn) := ld_date;
    ln_k := (ld_date - lc.date_time) / (ad_date - lc.date_time);
    lt_erm (ln_cn) := TRUNC (util_pg.overindic_to_indic (lc.erm + util_pg.indicoverturn (ln_erm - lc.erm, ln_digits) * ln_k, ln_tdigits), ln_rn1);
    lt_edm (ln_cn) := TRUNC (util_pg.overindic_to_indic (lc.edm + util_pg.indicoverturn (ln_edm - lc.edm, ln_digits) * ln_k, ln_tdigits), ln_rn1);
    lt_q1m (ln_cn) := TRUNC (util_pg.overindic_to_indic (lc.q1m + util_pg.indicoverturn (ln_q1m - lc.q1m, ln_digits) * ln_k, ln_tdigits), ln_rn1);
    lt_q3m (ln_cn) := TRUNC (util_pg.overindic_to_indic (lc.q3m + util_pg.indicoverturn (ln_q3m - lc.q3m, ln_digits) * ln_k, ln_tdigits), ln_rn1);
    lt_q2m (ln_cn) := TRUNC (util_pg.overindic_to_indic (lc.q2m + util_pg.indicoverturn (ln_q2m - lc.q2m, ln_digits) * ln_k, ln_tdigits), ln_rn1);
    lt_q4m (ln_cn) := TRUNC (util_pg.overindic_to_indic (lc.q4m + util_pg.indicoverturn (ln_q4m - lc.q4m, ln_digits) * ln_k, ln_tdigits), ln_rn1);
    ld_date := ld_date + an_step;
   END LOOP;

   FOR i IN 2 .. lt_erm.COUNT LOOP
    ln_er := ROUND (util_pg.indicoverturn (lt_erm (i) - lt_erm (i - 1), ln_digits) * ln_kc, ln_rn);
    ln_ed := ROUND (util_pg.indicoverturn (lt_edm (i) - lt_edm (i - 1), ln_digits) * ln_kc, ln_rn);
    ln_q1 := ROUND (util_pg.indicoverturn (lt_q1m (i) - lt_q1m (i - 1), ln_digits) * ln_kc, ln_rn);
    ln_q3 := ROUND (util_pg.indicoverturn (lt_q3m (i) - lt_q3m (i - 1), ln_digits) * ln_kc, ln_rn);
    ln_q2 := ROUND (util_pg.indicoverturn (lt_q2m (i) - lt_q2m (i - 1), ln_digits) * ln_kc, ln_rn);
    ln_q4 := ROUND (util_pg.indicoverturn (lt_q4m (i) - lt_q4m (i - 1), ln_digits) * ln_kc, ln_rn);
    das_pg.ins_halfhourtmp (an_mid, lt_dt (i), NULL, ln_er, ln_ed, ln_q1, ln_q3, ln_q2, ln_q4, lt_erm (i), lt_edm (i), lt_q1m (i), lt_q3m (i), lt_q2m (i),
                            lt_q4m (i), an_status, cn_energysimple, NULL, av_mtrsn);
   END LOOP;
  ELSE
   das_pg.ins_halfhourtmp (an_mid, ad_date, NULL, NULL, NULL, NULL, NULL, NULL, NULL, ln_erm, ln_edm, ln_q1m, ln_q3m, ln_q2m, ln_q4m, an_status, cn_energysimple,
                           NULL, av_mtrsn);
  END IF;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error (-20001, 'comsrv_pg.set_halfhour_energy_simple: ' || SQLERRM (SQLCODE));
 END;

-----------------------------------------------------------------------------------------------------------------------
  --Вставка суточных расходов
 PROCEDURE set_bill_energy (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, an_aer NUMBER, an_aed NUMBER,
 an_aq1 NUMBER, an_aq3 NUMBER, an_aq2 NUMBER, an_aq4 NUMBER, an_ber NUMBER, an_bed NUMBER, an_bq1 NUMBER, an_bq3 NUMBER, an_bq2 NUMBER, an_bq4 NUMBER, an_cer NUMBER,
 an_ced NUMBER, an_cq1 NUMBER, an_cq3 NUMBER, an_cq2 NUMBER, an_cq4 NUMBER, an_der NUMBER, an_ded NUMBER, an_dq1 NUMBER, an_dq3 NUMBER, an_dq2 NUMBER, an_dq4 NUMBER,
 ad_date DATE
 ) IS
 BEGIN
  set_bill_eom (an_mid, an_er, an_ed, an_q1, an_q3, an_q2, an_q4, an_aer, an_aed, an_aq1, an_aq3, an_aq2, an_aq4, an_ber, an_bed, an_bq1, an_bq3, an_bq2, an_bq4,
                an_cer, an_ced, an_cq1, an_cq3, an_cq2, an_cq4, an_der, an_ded, an_dq1, an_dq3, an_dq2, an_dq4, NULL, ad_date);
 END;

------------------------------------------------------------------------------------------------------------------------
   --Вставка суточных показаний
 PROCEDURE set_bill_energy_m (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_aerm NUMBER,
 an_aedm NUMBER, an_aq1m NUMBER, an_aq3m NUMBER, an_aq2m NUMBER, an_aq4m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_bq2m NUMBER,
 an_bq4m NUMBER, an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_cq2m NUMBER, an_cq4m NUMBER, an_derm NUMBER, an_dedm NUMBER, an_dq1m NUMBER,
 an_dq3m NUMBER, an_dq2m NUMBER, an_dq4m NUMBER, ad_date DATE
 ) IS
  ln_erm    NUMBER DEFAULT ROUND (an_erm, cn_roundall);
  ln_edm    NUMBER DEFAULT ROUND (an_edm, cn_roundall);
  ln_q1m    NUMBER DEFAULT ROUND (an_q1m, cn_roundall);
  ln_q3m    NUMBER DEFAULT ROUND (an_q3m, cn_roundall);
  ln_q2m    NUMBER DEFAULT ROUND (an_q2m, cn_roundall);
  ln_q4m    NUMBER DEFAULT ROUND (an_q4m, cn_roundall);
  ln_aerm   NUMBER DEFAULT ROUND (an_aerm, cn_roundall);
  ln_aedm   NUMBER DEFAULT ROUND (an_aedm, cn_roundall);
  ln_aq1m   NUMBER DEFAULT ROUND (an_aq1m, cn_roundall);
  ln_aq3m   NUMBER DEFAULT ROUND (an_aq3m, cn_roundall);
  ln_aq2m   NUMBER DEFAULT ROUND (an_aq2m, cn_roundall);
  ln_aq4m   NUMBER DEFAULT ROUND (an_aq4m, cn_roundall);
  ln_berm   NUMBER DEFAULT ROUND (an_berm, cn_roundall);
  ln_bedm   NUMBER DEFAULT ROUND (an_bedm, cn_roundall);
  ln_bq1m   NUMBER DEFAULT ROUND (an_bq1m, cn_roundall);
  ln_bq3m   NUMBER DEFAULT ROUND (an_bq3m, cn_roundall);
  ln_bq2m   NUMBER DEFAULT ROUND (an_bq2m, cn_roundall);
  ln_bq4m   NUMBER DEFAULT ROUND (an_bq4m, cn_roundall);
  ln_cerm   NUMBER DEFAULT ROUND (an_cerm, cn_roundall);
  ln_cedm   NUMBER DEFAULT ROUND (an_cedm, cn_roundall);
  ln_cq1m   NUMBER DEFAULT ROUND (an_cq1m, cn_roundall);
  ln_cq3m   NUMBER DEFAULT ROUND (an_cq3m, cn_roundall);
  ln_cq2m   NUMBER DEFAULT ROUND (an_cq2m, cn_roundall);
  ln_cq4m   NUMBER DEFAULT ROUND (an_cq4m, cn_roundall);
  ln_derm   NUMBER DEFAULT ROUND (an_derm, cn_roundall);
  ln_dedm   NUMBER DEFAULT ROUND (an_dedm, cn_roundall);
  ln_dq1m   NUMBER DEFAULT ROUND (an_dq1m, cn_roundall);
  ln_dq3m   NUMBER DEFAULT ROUND (an_dq3m, cn_roundall);
  ln_dq2m   NUMBER DEFAULT ROUND (an_dq2m, cn_roundall);
  ln_dq4m   NUMBER DEFAULT ROUND (an_dq4m, cn_roundall);
 BEGIN
  util_pg.chdr (an_mid, ln_erm, ln_edm, ln_q1m, ln_q3m, ln_q2m, ln_q4m);
  util_pg.chdr (an_mid, ln_aerm, ln_aedm, ln_aq1m, ln_aq3m, ln_aq2m, ln_aq4m);
  util_pg.chdr (an_mid, ln_berm, ln_bedm, ln_bq1m, ln_bq3m, ln_bq2m, ln_bq4m);
  util_pg.chdr (an_mid, ln_cerm, ln_cedm, ln_cq1m, ln_cq3m, ln_cq2m, ln_cq4m);
  util_pg.chdr (an_mid, ln_derm, ln_dedm, ln_dq1m, ln_dq3m, ln_dq2m, ln_dq4m);

  UPDATE billorg
     SET (erm, edm, q1m, q3m, q2m, q4m, aerm, aedm, aq1m, aq3m, aq2m, aq4m, berm, bedm, bq1m, bq3m, bq2m, bq4m, cerm, cedm, cq1m, cq3m, cq2m, cq4m, derm, dedm, dq1m,
          dq3m, dq2m, dq4m) =
          (SELECT ln_erm, ln_edm, ln_q1m, ln_q3m, ln_q2m, ln_q4m, ln_aerm, ln_aedm, ln_aq1m, ln_aq3m, ln_aq2m, ln_aq4m, ln_berm, ln_bedm, ln_bq1m, ln_bq3m, ln_bq2m,
                  ln_bq4m, ln_cerm, ln_cedm, ln_cq1m, ln_cq3m, ln_cq2m, ln_cq4m, ln_derm, ln_dedm, ln_dq1m, ln_dq3m, ln_dq2m, ln_dq4m
             FROM DUAL)
   WHERE mid = an_mid AND date_time = ad_date AND nsource = cn_auto;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error (-20001, 'comsrv_pg.set_bill_energy_m: ' || SQLERRM (SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
   --Вставка месячных расходов
 PROCEDURE set_months_energy (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, an_aer NUMBER, an_aed NUMBER,
 an_aq1 NUMBER, an_aq3 NUMBER, an_aq2 NUMBER, an_aq4 NUMBER, an_ber NUMBER, an_bed NUMBER, an_bq1 NUMBER, an_bq3 NUMBER, an_bq2 NUMBER, an_bq4 NUMBER, an_cer NUMBER,
 an_ced NUMBER, an_cq1 NUMBER, an_cq3 NUMBER, an_cq2 NUMBER, an_cq4 NUMBER, an_der NUMBER, an_ded NUMBER, an_dq1 NUMBER, an_dq3 NUMBER, an_dq2 NUMBER, an_dq4 NUMBER,
 ad_date DATE
 ) IS
 BEGIN
  set_months_eom (an_mid, an_er, an_ed, an_q1, an_q3, an_q2, an_q4, an_aer, an_aed, an_aq1, an_aq3, an_aq2, an_aq4, an_ber, an_bed, an_bq1, an_bq3, an_bq2, an_bq4,
                  an_cer, an_ced, an_cq1, an_cq3, an_cq2, an_cq4, an_der, an_ded, an_dq1, an_dq3, an_dq2, an_dq4, NULL, ad_date);
 END;

------------------------------------------------------------------------------------------------------------------------
  --Вставка месячных показаний
 PROCEDURE set_months_energy_m (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_aerm NUMBER,
 an_aedm NUMBER, an_aq1m NUMBER, an_aq3m NUMBER, an_aq2m NUMBER, an_aq4m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_bq2m NUMBER,
 an_bq4m NUMBER, an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_cq2m NUMBER, an_cq4m NUMBER, an_derm NUMBER, an_dedm NUMBER, an_dq1m NUMBER,
 an_dq3m NUMBER, an_dq2m NUMBER, an_dq4m NUMBER, ad_date DATE
 ) IS
  ln_erm    NUMBER DEFAULT ROUND (an_erm, cn_roundall);
  ln_edm    NUMBER DEFAULT ROUND (an_edm, cn_roundall);
  ln_q1m    NUMBER DEFAULT ROUND (an_q1m, cn_roundall);
  ln_q3m    NUMBER DEFAULT ROUND (an_q3m, cn_roundall);
  ln_q2m    NUMBER DEFAULT ROUND (an_q2m, cn_roundall);
  ln_q4m    NUMBER DEFAULT ROUND (an_q4m, cn_roundall);
  ln_aerm   NUMBER DEFAULT ROUND (an_aerm, cn_roundall);
  ln_aedm   NUMBER DEFAULT ROUND (an_aedm, cn_roundall);
  ln_aq1m   NUMBER DEFAULT ROUND (an_aq1m, cn_roundall);
  ln_aq3m   NUMBER DEFAULT ROUND (an_aq3m, cn_roundall);
  ln_aq2m   NUMBER DEFAULT ROUND (an_aq2m, cn_roundall);
  ln_aq4m   NUMBER DEFAULT ROUND (an_aq4m, cn_roundall);
  ln_berm   NUMBER DEFAULT ROUND (an_berm, cn_roundall);
  ln_bedm   NUMBER DEFAULT ROUND (an_bedm, cn_roundall);
  ln_bq1m   NUMBER DEFAULT ROUND (an_bq1m, cn_roundall);
  ln_bq3m   NUMBER DEFAULT ROUND (an_bq3m, cn_roundall);
  ln_bq2m   NUMBER DEFAULT ROUND (an_bq2m, cn_roundall);
  ln_bq4m   NUMBER DEFAULT ROUND (an_bq4m, cn_roundall);
  ln_cerm   NUMBER DEFAULT ROUND (an_cerm, cn_roundall);
  ln_cedm   NUMBER DEFAULT ROUND (an_cedm, cn_roundall);
  ln_cq1m   NUMBER DEFAULT ROUND (an_cq1m, cn_roundall);
  ln_cq3m   NUMBER DEFAULT ROUND (an_cq3m, cn_roundall);
  ln_cq2m   NUMBER DEFAULT ROUND (an_cq2m, cn_roundall);
  ln_cq4m   NUMBER DEFAULT ROUND (an_cq4m, cn_roundall);
  ln_derm   NUMBER DEFAULT ROUND (an_derm, cn_roundall);
  ln_dedm   NUMBER DEFAULT ROUND (an_dedm, cn_roundall);
  ln_dq1m   NUMBER DEFAULT ROUND (an_dq1m, cn_roundall);
  ln_dq3m   NUMBER DEFAULT ROUND (an_dq3m, cn_roundall);
  ln_dq2m   NUMBER DEFAULT ROUND (an_dq2m, cn_roundall);
  ln_dq4m   NUMBER DEFAULT ROUND (an_dq4m, cn_roundall);
 BEGIN
  util_pg.chdr (an_mid, ln_erm, ln_edm, ln_q1m, ln_q3m, ln_q2m, ln_q4m);
  util_pg.chdr (an_mid, ln_aerm, ln_aedm, ln_aq1m, ln_aq3m, ln_aq2m, ln_aq4m);
  util_pg.chdr (an_mid, ln_berm, ln_bedm, ln_bq1m, ln_bq3m, ln_bq2m, ln_bq4m);
  util_pg.chdr (an_mid, ln_cerm, ln_cedm, ln_cq1m, ln_cq3m, ln_cq2m, ln_cq4m);
  util_pg.chdr (an_mid, ln_derm, ln_dedm, ln_dq1m, ln_dq3m, ln_dq2m, ln_dq4m);

  UPDATE monthsorg
     SET (erm, edm, q1m, q3m, q2m, q4m, aerm, aedm, aq1m, aq3m, aq2m, aq4m, berm, bedm, bq1m, bq3m, bq2m, bq4m, cerm, cedm, cq1m, cq3m, cq2m, cq4m, derm, dedm, dq1m,
          dq3m, dq2m, dq4m) =
          (SELECT ln_erm, ln_edm, ln_q1m, ln_q3m, ln_q2m, ln_q4m, ln_aerm, ln_aedm, ln_aq1m, ln_aq3m, ln_aq2m, ln_aq4m, ln_berm, ln_bedm, ln_bq1m, ln_bq3m, ln_bq2m,
                  ln_bq4m, ln_cerm, ln_cedm, ln_cq1m, ln_cq3m, ln_cq2m, ln_cq4m, ln_derm, ln_dedm, ln_dq1m, ln_dq3m, ln_dq2m, ln_dq4m
             FROM DUAL)
   WHERE mid = an_mid AND date_time = ad_date AND nsource = cn_auto;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error (-20001, 'comsrv_pg.set_months_energy_m: ' || SQLERRM (SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
  --******************************          Oblik              *******************************************************--
  ------------------------------------------------------------------------------------------------------------------------
 --Вставка текущих
 PROCEDURE set_curr_power_oblik (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_freq NUMBER, an_cos_fi NUMBER, an_volt1 NUMBER,
 an_curr1 NUMBER, an_volt2 NUMBER, an_volt3 NUMBER, an_curr2 NUMBER, an_curr3 NUMBER, ad_date DATE
 ) IS
 BEGIN
  set_curr_power_energy (an_mid, an_er, an_ed, an_q1, an_q3, an_freq, an_cos_fi, an_volt1, an_curr1, an_volt2, an_volt3, an_curr2, an_curr3, ad_date);
 END;

-----------------------------------------------------------------------------------------------------------------------
 --Вставка показаний счетчика
 PROCEDURE set_total_oblik (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER) IS
 BEGIN
  set_total_energy (an_mid, an_er, an_ed, an_q1, an_q2, an_q3, an_q4);
 END;

-----------------------------------------------------------------------------------------------------------------------
 --Вставка минутного профиля
 PROCEDURE set_profile_oblik (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, ad_date DATE) IS
  ln_er       NUMBER DEFAULT an_er;
  ln_ed       NUMBER DEFAULT an_ed;
  ln_q1       NUMBER DEFAULT an_q1;
  ln_q3       NUMBER DEFAULT an_q3;
  ln_q2       NUMBER DEFAULT an_q2;
  ln_q4       NUMBER DEFAULT an_q4;
  ld_date     DATE   DEFAULT ad_date;
  ln_source   NUMBER DEFAULT cn_auto;
 BEGIN
  IF FALSE THEN   --IF убрать, когда Носик станет вести по зиме
   ld_date := util_pg.to_localtime_if_new (ad_date);

   IF util_pg.newhalfhour_f = 1 AND util_pg.is_timeswitch (ad_date) = -1 THEN   --Время перехода с лета на зиму (nsource=19,29)
    ln_source := 19;
   END IF;
  END IF;

  util_pg.chdr (an_mid, ln_er, ln_ed, ln_q1, ln_q3, ln_q2, ln_q4);

  INSERT INTO PROFILE
              (mid, date_time, nsource, er, ed, q1, q3, q2, q4
              )
       VALUES (an_mid, ld_date, ln_source, ln_er, ln_ed, ln_q1, ln_q3, ln_q2, ln_q4
              );
 EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
   UPDATE PROFILE
      SET er = ln_er,
          ed = ln_ed,
          q1 = ln_q1,
          q3 = ln_q3,
          q2 = ln_q2,
          q4 = ln_q4
    WHERE mid = an_mid AND date_time = ld_date AND nsource = ln_source;
  WHEN OTHERS THEN
   raise_application_error (-20001, 'comsrv_pg.set_profile_oblik: ' || SQLERRM (SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
 --Вставка минутного профиля по индукционникам
 PROCEDURE set_profile_oblik_induc (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, ad_date DATE) IS
 BEGIN
  set_profile_oblik (an_mid, an_er, an_ed, an_q1, an_q3, an_q2, an_q4, ad_date);
 END;

-----------------------------------------------------------------------------------------------------------------------
 --Вставка графика нагрузки
 PROCEDURE set_halfhour_oblik (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, ad_date DATE) IS
 BEGIN
  set_halfhour_meter (an_mid, an_er, an_ed, an_q1, an_q3, an_q2, an_q4, NULL, cn_oblik, NULL, ad_date, NULL);
 END;

------------------------------------------------------------------------------------------------------------------------
 --Вставка графика нагрузки по индукционникам
 PROCEDURE set_halfhour_oblik_induc (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, ad_date DATE) IS
 BEGIN
  set_halfhour_meter (an_mid, an_er, an_ed, an_q1, an_q3, an_q2, an_q4, NULL, cn_oblik, NULL, ad_date, NULL);
 END;

-----------------------------------------------------------------------------------------------------------------------
  --Вставка суточных расходов
 PROCEDURE set_bill_oblik (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, an_aer NUMBER, an_aed NUMBER,
 an_aq1 NUMBER, an_aq3 NUMBER, an_aq2 NUMBER, an_aq4 NUMBER, an_ber NUMBER, an_bed NUMBER, an_bq1 NUMBER, an_bq3 NUMBER, an_bq2 NUMBER, an_bq4 NUMBER, an_cer NUMBER,
 an_ced NUMBER, an_cq1 NUMBER, an_cq3 NUMBER, an_cq2 NUMBER, an_cq4 NUMBER, an_der NUMBER, an_ded NUMBER, an_dq1 NUMBER, an_dq3 NUMBER, an_dq2 NUMBER, an_dq4 NUMBER,
 ad_date DATE
 ) IS
 BEGIN
  set_bill_eom (an_mid, an_er, an_ed, an_q1, an_q3, an_q2, an_q4, an_aer, an_aed, an_aq1, an_aq3, an_aq2, an_aq4, an_ber, an_bed, an_bq1, an_bq3, an_bq2, an_bq4,
                an_cer, an_ced, an_cq1, an_cq3, an_cq2, an_cq4, an_der, an_ded, an_dq1, an_dq3, an_dq2, an_dq4, NULL, ad_date);
 END;

-----------------------------------------------------------------------------------------------------------------------
  --Вставка суточных расходов по индукционникам
 PROCEDURE set_bill_oblik_induc (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, an_aer NUMBER, an_aed NUMBER,
 an_aq1 NUMBER, an_aq3 NUMBER, an_aq2 NUMBER, an_aq4 NUMBER, an_ber NUMBER, an_bed NUMBER, an_bq1 NUMBER, an_bq3 NUMBER, an_bq2 NUMBER, an_bq4 NUMBER, an_cer NUMBER,
 an_ced NUMBER, an_cq1 NUMBER, an_cq3 NUMBER, an_cq2 NUMBER, an_cq4 NUMBER, an_der NUMBER, an_ded NUMBER, an_dq1 NUMBER, an_dq3 NUMBER, an_dq2 NUMBER, an_dq4 NUMBER,
 ad_date DATE
 ) IS
 BEGIN
  set_bill_oblik (an_mid, an_er, an_ed, an_q1, an_q3, an_q2, an_q4, an_aer, an_aed, an_aq1, an_aq3, an_aq2, an_aq4, an_ber, an_bed, an_bq1, an_bq3, an_bq2, an_bq4,
                  an_cer, an_ced, an_cq1, an_cq3, an_cq2, an_cq4, an_der, an_ded, an_dq1, an_dq3, an_dq2, an_dq4, ad_date);
 END;

------------------------------------------------------------------------------------------------------------------------
   --Вставка суточных показаний
 PROCEDURE set_bill_oblik_m (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_aerm NUMBER, an_aedm NUMBER,
 an_aq1m NUMBER, an_aq3m NUMBER, an_aq2m NUMBER, an_aq4m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_bq2m NUMBER, an_bq4m NUMBER,
 an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_cq2m NUMBER, an_cq4m NUMBER, an_derm NUMBER, an_dedm NUMBER, an_dq1m NUMBER, an_dq3m NUMBER,
 an_dq2m NUMBER, an_dq4m NUMBER, ad_date DATE
 ) IS
 BEGIN
  set_bill_energy_m (an_mid, an_erm, an_edm, an_q1m, an_q3m, an_q2m, an_q4m, an_aerm, an_aedm, an_aq1m, an_aq3m, an_aq2m, an_aq4m, an_berm, an_bedm, an_bq1m,
                     an_bq3m, an_bq2m, an_bq4m, an_cerm, an_cedm, an_cq1m, an_cq3m, an_cq2m, an_cq4m, an_derm, an_dedm, an_dq1m, an_dq3m, an_dq2m, an_dq4m, ad_date);
 END;

------------------------------------------------------------------------------------------------------------------------
   --Вставка суточных показаний по индукционникам
 PROCEDURE set_bill_oblik_m_induc (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_aerm NUMBER,
 an_aedm NUMBER, an_aq1m NUMBER, an_aq3m NUMBER, an_aq2m NUMBER, an_aq4m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_bq2m NUMBER,
 an_bq4m NUMBER, an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_cq2m NUMBER, an_cq4m NUMBER, an_derm NUMBER, an_dedm NUMBER, an_dq1m NUMBER,
 an_dq3m NUMBER, an_dq2m NUMBER, an_dq4m NUMBER, ad_date DATE
 ) IS
 BEGIN
  set_bill_oblik_m (an_mid, an_erm, an_edm, an_q1m, an_q3m, an_q2m, an_q4m, an_aerm, an_aedm, an_aq1m, an_aq3m, an_aq2m, an_aq4m, an_berm, an_bedm, an_bq1m,
                    an_bq3m, an_bq2m, an_bq4m, an_cerm, an_cedm, an_cq1m, an_cq3m, an_cq2m, an_cq4m, an_derm, an_dedm, an_dq1m, an_dq3m, an_dq2m, an_dq4m, ad_date);
 END;

------------------------------------------------------------------------------------------------------------------------
   --Вставка месячных расходов
 PROCEDURE set_months_oblik (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, an_aer NUMBER, an_aed NUMBER,
 an_aq1 NUMBER, an_aq3 NUMBER, an_aq2 NUMBER, an_aq4 NUMBER, an_ber NUMBER, an_bed NUMBER, an_bq1 NUMBER, an_bq3 NUMBER, an_bq2 NUMBER, an_bq4 NUMBER, an_cer NUMBER,
 an_ced NUMBER, an_cq1 NUMBER, an_cq3 NUMBER, an_cq2 NUMBER, an_cq4 NUMBER, an_der NUMBER, an_ded NUMBER, an_dq1 NUMBER, an_dq3 NUMBER, an_dq2 NUMBER, an_dq4 NUMBER,
 ad_date DATE
 ) IS
 BEGIN
  set_months_eom (an_mid, an_er, an_ed, an_q1, an_q3, an_q2, an_q4, an_aer, an_aed, an_aq1, an_aq3, an_aq2, an_aq4, an_ber, an_bed, an_bq1, an_bq3, an_bq2, an_bq4,
                  an_cer, an_ced, an_cq1, an_cq3, an_cq2, an_cq4, an_der, an_ded, an_dq1, an_dq3, an_dq2, an_dq4, NULL, ad_date);
 END;

------------------------------------------------------------------------------------------------------------------------
   --Вставка месячных расходов по индукционникам
 PROCEDURE set_months_oblik_induc (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, an_aer NUMBER, an_aed NUMBER,
 an_aq1 NUMBER, an_aq3 NUMBER, an_aq2 NUMBER, an_aq4 NUMBER, an_ber NUMBER, an_bed NUMBER, an_bq1 NUMBER, an_bq3 NUMBER, an_bq2 NUMBER, an_bq4 NUMBER, an_cer NUMBER,
 an_ced NUMBER, an_cq1 NUMBER, an_cq3 NUMBER, an_cq2 NUMBER, an_cq4 NUMBER, an_der NUMBER, an_ded NUMBER, an_dq1 NUMBER, an_dq3 NUMBER, an_dq2 NUMBER, an_dq4 NUMBER,
 ad_date DATE
 ) IS
 BEGIN
  set_months_oblik (an_mid, an_er, an_ed, an_q1, an_q3, an_q2, an_q4, an_aer, an_aed, an_aq1, an_aq3, an_aq2, an_aq4, an_ber, an_bed, an_bq1, an_bq3, an_bq2,
                    an_bq4, an_cer, an_ced, an_cq1, an_cq3, an_cq2, an_cq4, an_der, an_ded, an_dq1, an_dq3, an_dq2, an_dq4, ad_date);
 END;

------------------------------------------------------------------------------------------------------------------------
  --Вставка месячных показаний
 PROCEDURE set_months_oblik_m (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_aerm NUMBER,
 an_aedm NUMBER, an_aq1m NUMBER, an_aq3m NUMBER, an_aq2m NUMBER, an_aq4m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_bq2m NUMBER,
 an_bq4m NUMBER, an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_cq2m NUMBER, an_cq4m NUMBER, an_derm NUMBER, an_dedm NUMBER, an_dq1m NUMBER,
 an_dq3m NUMBER, an_dq2m NUMBER, an_dq4m NUMBER, ad_date DATE
 ) IS
 BEGIN
  set_months_energy_m (an_mid, an_erm, an_edm, an_q1m, an_q3m, an_q2m, an_q4m, an_aerm, an_aedm, an_aq1m, an_aq3m, an_aq2m, an_aq4m, an_berm, an_bedm, an_bq1m,
                       an_bq3m, an_bq2m, an_bq4m, an_cerm, an_cedm, an_cq1m, an_cq3m, an_cq2m, an_cq4m, an_derm, an_dedm, an_dq1m, an_dq3m, an_dq2m, an_dq4m,
                       ad_date);
 END;

------------------------------------------------------------------------------------------------------------------------
  --Вставка месячных показаний по индукционникам
 PROCEDURE set_months_oblik_m_induc (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_aerm NUMBER,
 an_aedm NUMBER, an_aq1m NUMBER, an_aq3m NUMBER, an_aq2m NUMBER, an_aq4m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_bq2m NUMBER,
 an_bq4m NUMBER, an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_cq2m NUMBER, an_cq4m NUMBER, an_derm NUMBER, an_dedm NUMBER, an_dq1m NUMBER,
 an_dq3m NUMBER, an_dq2m NUMBER, an_dq4m NUMBER, ad_date DATE
 ) IS
 BEGIN
  set_months_oblik_m (an_mid, an_erm, an_edm, an_q1m, an_q3m, an_q2m, an_q4m, an_aerm, an_aedm, an_aq1m, an_aq3m, an_aq2m, an_aq4m, an_berm, an_bedm, an_bq1m,
                      an_bq3m, an_bq2m, an_bq4m, an_cerm, an_cedm, an_cq1m, an_cq3m, an_cq2m, an_cq4m, an_derm, an_dedm, an_dq1m, an_dq3m, an_dq2m, an_dq4m,
                      ad_date);
 END;

------------------------------------------------------------------------------------------------------------------------
 FUNCTION put_tu_oblik (an_mid NUMBER, an_clamp NUMBER)
  RETURN NUMBER IS
  ln_ret   NUMBER DEFAULT 0;
 BEGIN
  FOR lc IN (SELECT   clamp, tc_pg.get_condition (nparam, SYSDATE) cond, vvalue
                 FROM tcsignals
                WHERE mid = an_mid AND clamp > an_clamp
             ORDER BY clamp) LOOP
   IF tc_pg.check_condition (lc.vvalue) = 1 THEN
    ln_ret := lc.clamp;
    EXIT;
   END IF;
  END LOOP;

  RETURN ln_ret;
 END;

------------------------------------------------------------------------------------------------------------------------
--******************************          АРГО             *******************************************************--
------------------------------------------------------------------------------------------------------------------------
 --Вставка текущих
 PROCEDURE set_curr_power_argo (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_freq NUMBER,
 an_cos_fi NUMBER, an_volt1 NUMBER, an_volt2 NUMBER, an_volt3 NUMBER, an_curr1 NUMBER, an_curr2 NUMBER, an_curr3 NUMBER, an_fiu1i1 NUMBER, an_fiu2i2 NUMBER,
 an_fiu3i3 NUMBER, an_fiu1u2 NUMBER, an_fiu1u3 NUMBER, an_fiu2u3 NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER,
 ad_date DATE
 ) IS
 BEGIN
  set_curr_power_meter (an_mid, an_erm, an_edm, an_q1m, an_q3m, an_q2m, an_q4m, an_freq, an_cos_fi, an_volt1, an_volt2, an_volt3, an_curr1, an_curr2, an_curr3,
                        an_fiu1i1, an_fiu2i2, an_fiu3i3, an_fiu1u2, an_fiu1u3, an_fiu2u3, an_er, an_ed, an_q1, an_q3, an_q2, an_q4, 2, ad_date);
 END;

-----------------------------------------------------------------------------------------------------------------------
 --Вставка графика нагрузки
 PROCEDURE set_halfhour_argo (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, ad_date DATE) IS
 BEGIN
  set_halfhour_meter (an_mid, an_er, an_ed, an_q1, an_q3, NULL, NULL, NULL, cn_argo, NULL, ad_date, NULL);
 END;

------------------------------------------------------------------------------------------------------------------------
  --Вставка суточных
 PROCEDURE set_bill_argo (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_aerm NUMBER, an_aedm NUMBER,
 an_aq1m NUMBER, an_aq3m NUMBER, an_aq2m NUMBER, an_aq4m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_bq2m NUMBER, an_bq4m NUMBER,
 an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_cq2m NUMBER, an_cq4m NUMBER, an_derm NUMBER, an_dedm NUMBER, an_dq1m NUMBER, an_dq3m NUMBER,
 an_dq2m NUMBER, an_dq4m NUMBER, av_mtrsn VARCHAR2, an_digits NUMBER,   --Значность счетчика, необходимо передать соответствующую АРГО
                                                                        --( для A1R было 6 - A1R_ParamCalc.DPLocE )
                                                                     ad_date DATE
 ) IS
 BEGIN
  set_bill_meter (an_mid, an_erm, an_edm, an_q1m, an_q3m, an_q2m, an_q4m, an_aerm, an_aedm, an_aq1m, an_aq3m, an_aq2m, an_aq4m, an_berm, an_bedm, an_bq1m, an_bq3m,
                  an_bq2m, an_bq4m, an_cerm, an_cedm, an_cq1m, an_cq3m, an_cq2m, an_cq4m, an_derm, an_dedm, an_dq1m, an_dq3m, an_dq2m, an_dq4m, av_mtrsn, an_digits,
                  ad_date);
 END;

------------------------------------------------------------------------------------------------------------------------
  --Вставка месячных
 PROCEDURE set_months_argo (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_aerm NUMBER, an_aedm NUMBER,
 an_aq1m NUMBER, an_aq3m NUMBER, an_aq2m NUMBER, an_aq4m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_bq2m NUMBER, an_bq4m NUMBER,
 an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_cq2m NUMBER, an_cq4m NUMBER, an_derm NUMBER, an_dedm NUMBER, an_dq1m NUMBER, an_dq3m NUMBER,
 an_dq2m NUMBER, an_dq4m NUMBER, av_mtrsn VARCHAR2, an_digits NUMBER,   --Значность счетчика, необходимо передать соответствующую АРГО
                                                                        --( для A1R 6 - A1R_ParamCalc.DPLocE )
                                                                     ad_date DATE
 ) IS
 BEGIN
  set_months_meter (an_mid, an_erm, an_edm, an_q1m, an_q3m, an_q2m, an_q4m, an_aerm, an_aedm, an_aq1m, an_aq3m, an_aq2m, an_aq4m, an_berm, an_bedm, an_bq1m,
                    an_bq3m, an_bq2m, an_bq4m, an_cerm, an_cedm, an_cq1m, an_cq3m, an_cq2m, an_cq4m, an_derm, an_dedm, an_dq1m, an_dq3m, an_dq2m, an_dq4m, av_mtrsn,
                    an_digits, ad_date);
 END;

------------------------------------------------------------------------------------------------------------------------
--******************************          Меркурий             *******************************************************--
-----------------------------------------------------------------------------------------------------------------------
 --Вставка показаний счетчика
 PROCEDURE set_total_mercury (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER) IS
 BEGIN
  set_total_energy (an_mid, an_er, an_ed, an_q1, an_q2, an_q3, an_q4);
 END;

 ------------------------------------------------------------------------------------------------------------------------
--Вставка текущих
 PROCEDURE set_curr_power_mercury (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_freq NUMBER, an_cos_fi NUMBER, an_volt1 NUMBER,
 an_curr1 NUMBER, an_volt2 NUMBER, an_volt3 NUMBER, an_curr2 NUMBER, an_curr3 NUMBER, an_fiu1u2 NUMBER, an_fiu1u3 NUMBER, an_fiu2u3 NUMBER, ad_date DATE
 ) IS
 BEGIN
  set_curr_power_energy (an_mid, an_er, an_ed, an_q1, an_q3, an_freq, an_cos_fi, an_volt1, an_curr1, an_volt2, an_volt3, an_curr2, an_curr3, ad_date);
 END;

------------------------------------------------------------------------------------------------------------------------
  --Вставка суточных расходов
 PROCEDURE set_bill_mercury (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, an_aer NUMBER, an_aed NUMBER,
 an_aq1 NUMBER, an_aq3 NUMBER, an_aq2 NUMBER, an_aq4 NUMBER, an_ber NUMBER, an_bed NUMBER, an_bq1 NUMBER, an_bq3 NUMBER, an_bq2 NUMBER, an_bq4 NUMBER, an_cer NUMBER,
 an_ced NUMBER, an_cq1 NUMBER, an_cq3 NUMBER, an_cq2 NUMBER, an_cq4 NUMBER, an_der NUMBER, an_ded NUMBER, an_dq1 NUMBER, an_dq3 NUMBER, an_dq2 NUMBER, an_dq4 NUMBER,
 av_mtrsn VARCHAR2, ad_date DATE
 ) IS
 BEGIN
  set_bill_eom (an_mid, an_er, an_ed, an_q1, an_q3, an_q2, an_q4, an_aer, an_aed, an_aq1, an_aq3, an_aq2, an_aq4, an_ber, an_bed, an_bq1, an_bq3, an_bq2, an_bq4,
                an_cer, an_ced, an_cq1, an_cq3, an_cq2, an_cq4, an_der, an_ded, an_dq1, an_dq3, an_dq2, an_dq4, av_mtrsn, ad_date);
 END;

------------------------------------------------------------------------------------------------------------------------
   --Вставка суточных показаний
 PROCEDURE set_bill_mercury_m (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_aerm NUMBER,
 an_aedm NUMBER, an_aq1m NUMBER, an_aq3m NUMBER, an_aq2m NUMBER, an_aq4m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_bq2m NUMBER,
 an_bq4m NUMBER, an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_cq2m NUMBER, an_cq4m NUMBER, an_derm NUMBER, an_dedm NUMBER, an_dq1m NUMBER,
 an_dq3m NUMBER, an_dq2m NUMBER, an_dq4m NUMBER, ad_date DATE
 ) IS
 BEGIN
  set_bill_energy_m (an_mid, an_erm, an_edm, an_q1m, an_q3m, an_q2m, an_q4m, an_aerm, an_aedm, an_aq1m, an_aq3m, an_aq2m, an_aq4m, an_berm, an_bedm, an_bq1m,
                     an_bq3m, an_bq2m, an_bq4m, an_cerm, an_cedm, an_cq1m, an_cq3m, an_cq2m, an_cq4m, an_derm, an_dedm, an_dq1m, an_dq3m, an_dq2m, an_dq4m, ad_date);
 END;

------------------------------------------------------------------------------------------------------------------------
   --Вставка месячных расходов
 PROCEDURE set_months_mercury (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, an_aer NUMBER, an_aed NUMBER,
 an_aq1 NUMBER, an_aq3 NUMBER, an_aq2 NUMBER, an_aq4 NUMBER, an_ber NUMBER, an_bed NUMBER, an_bq1 NUMBER, an_bq3 NUMBER, an_bq2 NUMBER, an_bq4 NUMBER, an_cer NUMBER,
 an_ced NUMBER, an_cq1 NUMBER, an_cq3 NUMBER, an_cq2 NUMBER, an_cq4 NUMBER, an_der NUMBER, an_ded NUMBER, an_dq1 NUMBER, an_dq3 NUMBER, an_dq2 NUMBER, an_dq4 NUMBER,
 av_mtrsn VARCHAR2, ad_date DATE
 ) IS
 BEGIN
  set_months_eom (an_mid, an_er, an_ed, an_q1, an_q3, an_q2, an_q4, an_aer, an_aed, an_aq1, an_aq3, an_aq2, an_aq4, an_ber, an_bed, an_bq1, an_bq3, an_bq2, an_bq4,
                  an_cer, an_ced, an_cq1, an_cq3, an_cq2, an_cq4, an_der, an_ded, an_dq1, an_dq3, an_dq2, an_dq4, av_mtrsn, ad_date);
 END;

------------------------------------------------------------------------------------------------------------------------
  --Вставка месячных показаний
 PROCEDURE set_months_mercury_m (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_aerm NUMBER,
 an_aedm NUMBER, an_aq1m NUMBER, an_aq3m NUMBER, an_aq2m NUMBER, an_aq4m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_bq2m NUMBER,
 an_bq4m NUMBER, an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_cq2m NUMBER, an_cq4m NUMBER, an_derm NUMBER, an_dedm NUMBER, an_dq1m NUMBER,
 an_dq3m NUMBER, an_dq2m NUMBER, an_dq4m NUMBER, ad_date DATE
 ) IS
 BEGIN
  set_months_energy_m (an_mid, an_erm, an_edm, an_q1m, an_q3m, an_q2m, an_q4m, an_aerm, an_aedm, an_aq1m, an_aq3m, an_aq2m, an_aq4m, an_berm, an_bedm, an_bq1m,
                       an_bq3m, an_bq2m, an_bq4m, an_cerm, an_cedm, an_cq1m, an_cq3m, an_cq2m, an_cq4m, an_derm, an_dedm, an_dq1m, an_dq3m, an_dq2m, an_dq4m,
                       ad_date);
 END;

------------------------------------------------------------------------------------------------------------------------
  --Вставка графика нагрузки
 PROCEDURE set_halfhour_mercury (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, ad_date DATE) IS
 BEGIN
  set_halfhour_meter (an_mid, an_er, an_ed, an_q1, an_q3, an_q2, an_q4, NULL, cn_mercury, NULL, ad_date, NULL);
 END;

------------------------------------------------------------------------------------------------------------------------
--******************************          LZQM             *******************************************************--
-----------------------------------------------------------------------------------------------------------------------
 --Вставка показаний счетчика
 PROCEDURE set_total_lzqm (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER) IS
 BEGIN
  set_total_energy (an_mid, an_er, an_ed, an_q1, an_q2, an_q3, an_q4);
 END;

 ------------------------------------------------------------------------------------------------------------------------
--Вставка текущих
 PROCEDURE set_curr_power_lzqm (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_freq NUMBER, an_cos_fi NUMBER, an_volt1 NUMBER,
 an_curr1 NUMBER, an_volt2 NUMBER, an_volt3 NUMBER, an_curr2 NUMBER, an_curr3 NUMBER, an_fiu1u2 NUMBER, an_fiu1u3 NUMBER, an_fiu2u3 NUMBER, ad_date DATE
 ) IS
 BEGIN
  set_curr_power_energy (an_mid, an_er, an_ed, an_q1, an_q3, an_freq, an_cos_fi, an_volt1, an_curr1, an_volt2, an_volt3, an_curr2, an_curr3, ad_date);
 END;

------------------------------------------------------------------------------------------------------------------------
 --Вставка графика нагрузки
 PROCEDURE set_halfhour_lzqm (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, ad_date DATE) IS
 BEGIN
  set_halfhour_meter (an_mid, an_er, an_ed, an_q1, an_q3, an_q2, an_q4, NULL, cn_lzqm, NULL, ad_date, NULL);
 END;

------------------------------------------------------------------------------------------------------------------------
  --Вставка суточных расходов
 PROCEDURE set_bill_lzqm (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, an_aer NUMBER, an_aed NUMBER,
 an_aq1 NUMBER, an_aq3 NUMBER, an_aq2 NUMBER, an_aq4 NUMBER, an_ber NUMBER, an_bed NUMBER, an_bq1 NUMBER, an_bq3 NUMBER, an_bq2 NUMBER, an_bq4 NUMBER, an_cer NUMBER,
 an_ced NUMBER, an_cq1 NUMBER, an_cq3 NUMBER, an_cq2 NUMBER, an_cq4 NUMBER, an_der NUMBER, an_ded NUMBER, an_dq1 NUMBER, an_dq3 NUMBER, an_dq2 NUMBER, an_dq4 NUMBER,
 av_mtrsn VARCHAR2, ad_date DATE
 ) IS
 BEGIN
  set_bill_eom (an_mid, an_er, an_ed, an_q1, an_q3, an_q2, an_q4, an_aer, an_aed, an_aq1, an_aq3, an_aq2, an_aq4, an_ber, an_bed, an_bq1, an_bq3, an_bq2, an_bq4,
                an_cer, an_ced, an_cq1, an_cq3, an_cq2, an_cq4, an_der, an_ded, an_dq1, an_dq3, an_dq2, an_dq4, av_mtrsn, ad_date);
 END;

------------------------------------------------------------------------------------------------------------------------
   --Вставка суточных показаний
 PROCEDURE set_bill_lzqm_m (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_aerm NUMBER, an_aedm NUMBER,
 an_aq1m NUMBER, an_aq3m NUMBER, an_aq2m NUMBER, an_aq4m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_bq2m NUMBER, an_bq4m NUMBER,
 an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_cq2m NUMBER, an_cq4m NUMBER, an_derm NUMBER, an_dedm NUMBER, an_dq1m NUMBER, an_dq3m NUMBER,
 an_dq2m NUMBER, an_dq4m NUMBER, ad_date DATE
 ) IS
 BEGIN
  set_bill_energy_m (an_mid, an_erm, an_edm, an_q1m, an_q3m, an_q2m, an_q4m, an_aerm, an_aedm, an_aq1m, an_aq3m, an_aq2m, an_aq4m, an_berm, an_bedm, an_bq1m,
                     an_bq3m, an_bq2m, an_bq4m, an_cerm, an_cedm, an_cq1m, an_cq3m, an_cq2m, an_cq4m, an_derm, an_dedm, an_dq1m, an_dq3m, an_dq2m, an_dq4m, ad_date);
 END;

------------------------------------------------------------------------------------------------------------------------
   --Вставка месячных расходов
 PROCEDURE set_months_lzqm (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, an_aer NUMBER, an_aed NUMBER,
 an_aq1 NUMBER, an_aq3 NUMBER, an_aq2 NUMBER, an_aq4 NUMBER, an_ber NUMBER, an_bed NUMBER, an_bq1 NUMBER, an_bq3 NUMBER, an_bq2 NUMBER, an_bq4 NUMBER, an_cer NUMBER,
 an_ced NUMBER, an_cq1 NUMBER, an_cq3 NUMBER, an_cq2 NUMBER, an_cq4 NUMBER, an_der NUMBER, an_ded NUMBER, an_dq1 NUMBER, an_dq3 NUMBER, an_dq2 NUMBER, an_dq4 NUMBER,
 av_mtrsn VARCHAR2, ad_date DATE
 ) IS
 BEGIN
  set_months_eom (an_mid, an_er, an_ed, an_q1, an_q3, an_q2, an_q4, an_aer, an_aed, an_aq1, an_aq3, an_aq2, an_aq4, an_ber, an_bed, an_bq1, an_bq3, an_bq2, an_bq4,
                  an_cer, an_ced, an_cq1, an_cq3, an_cq2, an_cq4, an_der, an_ded, an_dq1, an_dq3, an_dq2, an_dq4, av_mtrsn, ad_date);
 END;

------------------------------------------------------------------------------------------------------------------------
  --Вставка месячных показаний
 PROCEDURE set_months_lzqm_m (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_aerm NUMBER,
 an_aedm NUMBER, an_aq1m NUMBER, an_aq3m NUMBER, an_aq2m NUMBER, an_aq4m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_bq2m NUMBER,
 an_bq4m NUMBER, an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_cq2m NUMBER, an_cq4m NUMBER, an_derm NUMBER, an_dedm NUMBER, an_dq1m NUMBER,
 an_dq3m NUMBER, an_dq2m NUMBER, an_dq4m NUMBER, ad_date DATE
 ) IS
 BEGIN
  set_months_energy_m (an_mid, an_erm, an_edm, an_q1m, an_q3m, an_q2m, an_q4m, an_aerm, an_aedm, an_aq1m, an_aq3m, an_aq2m, an_aq4m, an_berm, an_bedm, an_bq1m,
                       an_bq3m, an_bq2m, an_bq4m, an_cerm, an_cedm, an_cq1m, an_cq3m, an_cq2m, an_cq4m, an_derm, an_dedm, an_dq1m, an_dq3m, an_dq2m, an_dq4m,
                       ad_date);
 END;

------------------------------------------------------------------------------------------------------------------------
 --******************************          SET-4             *******************************************************--
 ------------------------------------------------------------------------------------------------------------------------

 --Вставка текущих
 PROCEDURE set_curr_power_set4 (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_freq NUMBER, an_cos_fi NUMBER, an_volt1 NUMBER,
 an_volt2 NUMBER, an_volt3 NUMBER, an_curr1 NUMBER, an_curr2 NUMBER, an_curr3 NUMBER, an_fiu1i1 NUMBER, an_fiu2i2 NUMBER, an_fiu3i3 NUMBER, an_er NUMBER,
 an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, ad_date DATE
 ) IS
 BEGIN
  set_curr_power_schlum (an_mid, an_erm, an_edm, an_q1m, an_q3m, NULL, NULL, an_freq, an_cos_fi, an_volt1, an_volt2, an_volt3, an_curr1, an_curr2, an_curr3,
                         an_fiu1i1, an_fiu2i2, an_fiu3i3, NULL, NULL, NULL, an_er, an_ed, an_q1, an_q3, NULL, NULL, ad_date);
 END;

-----------------------------------------------------------------------------------------------------------------------
 --Вставка графика нагрузки
 PROCEDURE set_halfhour_set4 (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, ad_date DATE) IS
 BEGIN
  set_halfhour_energy (an_mid, an_er, an_ed, an_q1, an_q3, NULL, NULL, ad_date);
 END;

------------------------------------------------------------------------------------------------------------------------
  --Вставка суточных расходов
 PROCEDURE set_bill_set4 (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_aer NUMBER, an_aed NUMBER, an_aq1 NUMBER, an_aq3 NUMBER,
 an_ber NUMBER, an_bed NUMBER, an_bq1 NUMBER, an_bq3 NUMBER, an_cer NUMBER, an_ced NUMBER, an_cq1 NUMBER, an_cq3 NUMBER, an_der NUMBER, an_ded NUMBER, an_dq1 NUMBER,
 an_dq3 NUMBER, av_mtrsn VARCHAR2, ad_date DATE
 ) IS
 BEGIN
  set_bill_eom (an_mid, an_er, an_ed, an_q1, an_q3, NULL, NULL, an_aer, an_aed, an_aq1, an_aq3, NULL, NULL, an_ber, an_bed, an_bq1, an_bq3, NULL, NULL, an_cer,
                an_ced, an_cq1, an_cq3, NULL, NULL, an_der, an_ded, an_dq1, an_dq3, NULL, NULL, av_mtrsn, ad_date);
 END;

------------------------------------------------------------------------------------------------------------------------
   --Вставка суточных показаний
 PROCEDURE set_bill_set4_m (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_aerm NUMBER, an_aedm NUMBER, an_aq1m NUMBER,
 an_aq3m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_derm NUMBER,
 an_dedm NUMBER, an_dq1m NUMBER, an_dq3m NUMBER, ad_date DATE
 ) IS
 BEGIN
  set_bill_energy_m (an_mid, an_erm, an_edm, an_q1m, an_q3m, NULL, NULL, an_aerm, an_aedm, an_aq1m, an_aq3m, NULL, NULL, an_berm, an_bedm, an_bq1m, an_bq3m, NULL,
                     NULL, an_cerm, an_cedm, an_cq1m, an_cq3m, NULL, NULL, an_derm, an_dedm, an_dq1m, an_dq3m, NULL, NULL, ad_date);
 END;

------------------------------------------------------------------------------------------------------------------------
   --Вставка месячных расходов
 PROCEDURE set_months_set4 (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_aer NUMBER, an_aed NUMBER, an_aq1 NUMBER, an_aq3 NUMBER,
 an_ber NUMBER, an_bed NUMBER, an_bq1 NUMBER, an_bq3 NUMBER, an_cer NUMBER, an_ced NUMBER, an_cq1 NUMBER, an_cq3 NUMBER, an_der NUMBER, an_ded NUMBER, an_dq1 NUMBER,
 an_dq3 NUMBER, av_mtrsn VARCHAR2, ad_date DATE
 ) IS
 BEGIN
  set_months_eom (an_mid, an_er, an_ed, an_q1, an_q3, NULL, NULL, an_aer, an_aed, an_aq1, an_aq3, NULL, NULL, an_ber, an_bed, an_bq1, an_bq3, NULL, NULL, an_cer,
                  an_ced, an_cq1, an_cq3, NULL, NULL, an_der, an_ded, an_dq1, an_dq3, NULL, NULL, av_mtrsn, ad_date);
 END;

------------------------------------------------------------------------------------------------------------------------
  --Вставка месячных показаний
 PROCEDURE set_months_set4_m (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_aerm NUMBER, an_aedm NUMBER, an_aq1m NUMBER,
 an_aq3m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_derm NUMBER,
 an_dedm NUMBER, an_dq1m NUMBER, an_dq3m NUMBER, ad_date DATE
 ) IS
 BEGIN
  set_months_energy_m (an_mid, an_erm, an_edm, an_q1m, an_q3m, NULL, NULL, an_aerm, an_aedm, an_aq1m, an_aq3m, NULL, NULL, an_berm, an_bedm, an_bq1m, an_bq3m, NULL,
                       NULL, an_cerm, an_cedm, an_cq1m, an_cq3m, NULL, NULL, an_derm, an_dedm, an_dq1m, an_dq3m, NULL, NULL, ad_date);
 END;

------------------------------------------------------------------------------------------------------------------------
--**********************************          CE-304    CE-6850        ***********************************************--
------------------------------------------------------------------------------------------------------------------------
--Вставка текущих
 PROCEDURE set_curr_power_ce304 (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_freq NUMBER,
 an_cos_fi NUMBER, an_volt1 NUMBER, an_volt2 NUMBER, an_volt3 NUMBER, an_curr1 NUMBER, an_curr2 NUMBER, an_curr3 NUMBER, an_fiu1i1 NUMBER, an_fiu2i2 NUMBER,
 an_fiu3i3 NUMBER, an_fiu1u2 NUMBER, an_fiu1u3 NUMBER, an_fiu2u3 NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER,
 ad_date DATE
 ) IS
 BEGIN
  set_curr_power_meter (an_mid, an_erm, an_edm, an_q1m, an_q3m, an_q2m, an_q4m, an_freq, an_cos_fi, an_volt1, an_volt2, an_volt3, an_curr1, an_curr2, an_curr3,
                        an_fiu1i1, an_fiu2i2, an_fiu3i3, an_fiu1u2, an_fiu1u3, an_fiu2u3, an_er, an_ed, an_q1, an_q3, an_q2, an_q4, 0, ad_date);
 END;

-----------------------------------------------------------------------------------------------------------------------
 --Вставка графика нагрузки
 PROCEDURE set_halfhour_ce304 (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, an_status NUMBER, ad_date DATE) IS
 BEGIN
  set_halfhour_meter (an_mid, an_er, an_ed, an_q1, an_q3, an_q2, an_q4, an_status, cn_ce_304, NULL, ad_date, NULL);
 END;

------------------------------------------------------------------------------------------------------------------------
   --Вставка суточных показаний
 PROCEDURE set_bill_ce304_m (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_aerm NUMBER, an_aedm NUMBER,
 an_aq1m NUMBER, an_aq3m NUMBER, an_aq2m NUMBER, an_aq4m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_bq2m NUMBER, an_bq4m NUMBER,
 an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_cq2m NUMBER, an_cq4m NUMBER, an_derm NUMBER, an_dedm NUMBER, an_dq1m NUMBER, an_dq3m NUMBER,
 an_dq2m NUMBER, an_dq4m NUMBER, av_mtrsn VARCHAR2, ad_date DATE
 ) IS
 BEGIN
  comsrv_pg.set_bill_meter (an_mid, an_erm, an_edm, an_q1m, an_q3m, an_q2m, an_q4m, an_aerm, an_aedm, an_aq1m, an_aq3m, an_aq2m, an_aq4m, an_berm, an_bedm, an_bq1m,
                            an_bq3m, an_bq2m, an_bq4m, an_cerm, an_cedm, an_cq1m, an_cq3m, an_cq2m, an_cq4m, an_derm, an_dedm, an_dq1m, an_dq3m, an_dq2m, an_dq4m,
                            av_mtrsn, 0, ad_date);
 END;

------------------------------------------------------------------------------------------------------------------------
   --Вставка месячных показаний
 PROCEDURE set_months_ce304_m (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_aerm NUMBER,
 an_aedm NUMBER, an_aq1m NUMBER, an_aq3m NUMBER, an_aq2m NUMBER, an_aq4m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_bq2m NUMBER,
 an_bq4m NUMBER, an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_cq2m NUMBER, an_cq4m NUMBER, an_derm NUMBER, an_dedm NUMBER, an_dq1m NUMBER,
 an_dq3m NUMBER, an_dq2m NUMBER, an_dq4m NUMBER, av_mtrsn VARCHAR2, ad_date DATE
 ) IS
 BEGIN
  comsrv_pg.set_months_meter (an_mid, an_erm, an_edm, an_q1m, an_q3m, an_q2m, an_q4m, an_aerm, an_aedm, an_aq1m, an_aq3m, an_aq2m, an_aq4m, an_berm, an_bedm,
                              an_bq1m, an_bq3m, an_bq2m, an_bq4m, an_cerm, an_cedm, an_cq1m, an_cq3m, an_cq2m, an_cq4m, an_derm, an_dedm, an_dq1m, an_dq3m, an_dq2m,
                              an_dq4m, av_mtrsn, 0, ad_date);
 END;

------------------------------------------------------------------------------------------------------------------------
 --******************************          A1800             *******************************************************--
 ------------------------------------------------------------------------------------------------------------------------

 --Вставка текущих
 PROCEDURE set_curr_power_a1800 (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_freq NUMBER, an_cos_fi NUMBER, an_volt1 NUMBER,
 an_volt2 NUMBER, an_volt3 NUMBER, an_curr1 NUMBER, an_curr2 NUMBER, an_curr3 NUMBER, an_fiu1u2 NUMBER, an_fiu1u3 NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER,
 an_q3 NUMBER, ad_date DATE
 ) IS
 BEGIN
  set_curr_power_meter (an_mid, an_erm, an_edm, an_q1m, an_q3m, NULL, NULL, an_freq, an_cos_fi, an_volt1, an_volt2, an_volt3, an_curr1, an_curr2, an_curr3, NULL,
                        NULL, NULL, an_fiu1u2, an_fiu1u3, NULL, an_er, an_ed, an_q1, an_q3, NULL, NULL, 0, ad_date);
 END;

------------------------------------------------------------------------------------------------------------------------

 --Вставка графика нагрузки
 PROCEDURE set_halfhour_a1800 (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_status NUMBER, ad_date DATE) IS
 BEGIN
  set_halfhour_meter (an_mid, an_er, an_ed, an_q1, an_q3, NULL, NULL, an_status, cn_a1800, NULL, ad_date, NULL);
 END;

------------------------------------------------------------------------------------------------------------------------
  --Вставка суточных
 PROCEDURE set_bill_a1800 (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_aerm NUMBER, an_aedm NUMBER, an_aq1m NUMBER, an_aq3m NUMBER,
 an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_derm NUMBER, an_dedm NUMBER,
 an_dq1m NUMBER, an_dq3m NUMBER, av_mtrsn VARCHAR2, ad_date DATE
 ) IS
 BEGIN
  set_bill_meter (an_mid, an_erm, an_edm, an_q1m, an_q3m, NULL, NULL, an_aerm, an_aedm, an_aq1m, an_aq3m, NULL, NULL, an_berm, an_bedm, an_bq1m, an_bq3m, NULL,
                  NULL, an_cerm, an_cedm, an_cq1m, an_cq3m, NULL, NULL, an_derm, an_dedm, an_dq1m, an_dq3m, NULL, NULL, av_mtrsn, 0, ad_date);
 END;

------------------------------------------------------------------------------------------------------------------------
  --Вставка месячных
 PROCEDURE set_months_a1800 (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_aerm NUMBER, an_aedm NUMBER, an_aq1m NUMBER,
 an_aq3m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_derm NUMBER,
 an_dedm NUMBER, an_dq1m NUMBER, an_dq3m NUMBER, av_mtrsn VARCHAR2, ad_date DATE
 ) IS
 BEGIN
  set_months_meter (an_mid, an_erm, an_edm, an_q1m, an_q3m, NULL, NULL, an_aerm, an_aedm, an_aq1m, an_aq3m, NULL, NULL, an_berm, an_bedm, an_bq1m, an_bq3m, NULL,
                    NULL, an_cerm, an_cedm, an_cq1m, an_cq3m, NULL, NULL, an_derm, an_dedm, an_dq1m, an_dq3m, NULL, NULL, av_mtrsn, 0, ad_date);
 END;

------------------------------------------------------------------------------------------------------------------------
 --Журнал событий
 PROCEDURE mark_a1800event (newmid NUMBER, newev_date DATE, newtype NUMBER, FOUND OUT NUMBER) IS
  code      NUMBER          DEFAULT 0;
  MESSAGE   VARCHAR2 (2000);
 BEGIN
  code := -1010;
  MESSAGE := ' Событие счетчика: ' || newtype;

  IF newtype = 1 THEN
   code := 1010;
   MESSAGE := ' Отключение напряжения (Primary Power Down)';
  END IF;

  IF newtype = 2 THEN
   code := -1010;
   MESSAGE := ' Включение напряжения (Primary Power Up)';
  END IF;

  IF newtype = 3 THEN
   code := -1001;
   MESSAGE := ' Коррекция часов. Время до коррекции.';
  END IF;

  IF newtype = 4 THEN
   code := 1001;
   MESSAGE := ' Коррекция часов. Время после коррекции.';
  END IF;

  IF newtype = 7 THEN
   code := 1011;
   MESSAGE := ' End Device Accessed for Read';
  END IF;

  IF newtype = 8 THEN
   code := 1011;
   MESSAGE := ' End Device Accessed for Write';
  END IF;

  IF newtype = 11 THEN
   code := 1011;
   MESSAGE := ' End Device Programmed';
  END IF;

  IF newtype = 12 THEN
   code := 1011;
   MESSAGE := ' Communication Terminated Normally';
  END IF;

  IF newtype = 13 THEN
   code := 1011;
   MESSAGE := ' Communication Terminated Abnormally';
  END IF;

  IF newtype = 16 THEN
   code := 1014;
   MESSAGE := ' Очистка журнала истории (History LOg Cleared)';
  END IF;

  IF newtype = 18 THEN
   code := 1014;
   MESSAGE := ' Очистка журнала событий.';
  END IF;

  IF newtype = 20 THEN
   code := 1013;
   MESSAGE := ' Сброс максимальной мощности (Demand Reset Occured)';
  END IF;

  IF newtype = 21 THEN
   code := 1013;
   MESSAGE := ' Self Read Occured';
  END IF;

  IF newtype = 22 THEN
   code := -1013;
   MESSAGE := ' Daylight Savings Time On';
  END IF;

  IF newtype = 23 THEN
   code := -1013;
   MESSAGE := ' Daylight Savings Time Off';
  END IF;

  IF newtype = 2056 THEN
   code := 1010;
   MESSAGE := ' Пропадание питания фазы А';
  END IF;

  IF newtype = 2057 THEN
   code := -1010;
   MESSAGE := ' Восстановление питания фазы А';
  END IF;

  IF newtype = 2058 THEN
   code := 1010;
   MESSAGE := ' Пропадание питания фазы В';
  END IF;

  IF newtype = 2059 THEN
   code := -1010;
   MESSAGE := ' Восстановление питания фазы В';
  END IF;

  IF newtype = 2060 THEN
   code := 1010;
   MESSAGE := ' Пропадание питания фазы С';
  END IF;

  IF newtype = 2061 THEN
   code := -1010;
   MESSAGE := ' Восстановление питания фазы С';
  END IF;

  IF newtype = 2050 THEN
   code := 1012;
   MESSAGE := ' Крышка счетчика снята';
  END IF;

  SELECT COUNT (*)
    INTO FOUND
    FROM DUAL
   WHERE EXISTS (SELECT evtype
                   FROM ea_events
                  WHERE mid = newmid AND evdate = newev_date AND evtype = newtype);

  IF FOUND = 1 THEN
   RETURN;
  END IF;

  INSERT INTO journal
              (date_time, mid, state_cod, state_descr
              )
       VALUES (newev_date, newmid, code, MESSAGE
              );

  INSERT INTO ea_events
              (mid, evdate, evtype
              )
       VALUES (newmid, newev_date, newtype
              );
 END;

------------------------------------------------------------------------------------------------------------------------
 --******************************          EMS             *******************************************************--
 ------------------------------------------------------------------------------------------------------------------------

 --Вставка текущих
 PROCEDURE set_curr_power_ems (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, ad_date DATE) IS
 BEGIN
  set_curr_power_meter (an_mid, an_erm, an_edm, an_q1m, an_q3m, NULL, NULL, ad_date);
 END;

------------------------------------------------------------------------------------------------------------------------
  --Вставка суточных
 PROCEDURE set_bill_ems (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_aerm NUMBER, an_aedm NUMBER, an_aq1m NUMBER, an_aq3m NUMBER,
 an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_derm NUMBER, an_dedm NUMBER,
 an_dq1m NUMBER, an_dq3m NUMBER, av_mtrsn VARCHAR2, ad_date DATE
 ) IS
 BEGIN
  set_bill_meter (an_mid, an_erm, an_edm, an_q1m, an_q3m, NULL, NULL, an_aerm, an_aedm, an_aq1m, an_aq3m, NULL, NULL, an_berm, an_bedm, an_bq1m, an_bq3m, NULL,
                  NULL, an_cerm, an_cedm, an_cq1m, an_cq3m, NULL, NULL, an_derm, an_dedm, an_dq1m, an_dq3m, NULL, NULL, av_mtrsn, 0, ad_date);
 END;

------------------------------------------------------------------------------------------------------------------------
   --Вставка месячных расходов
 PROCEDURE set_months_ems (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, an_aer NUMBER, an_aed NUMBER,
 an_aq1 NUMBER, an_aq3 NUMBER, an_aq2 NUMBER, an_aq4 NUMBER, an_ber NUMBER, an_bed NUMBER, an_bq1 NUMBER, an_bq3 NUMBER, an_bq2 NUMBER, an_bq4 NUMBER, an_cer NUMBER,
 an_ced NUMBER, an_cq1 NUMBER, an_cq3 NUMBER, an_cq2 NUMBER, an_cq4 NUMBER, an_der NUMBER, an_ded NUMBER, an_dq1 NUMBER, an_dq3 NUMBER, an_dq2 NUMBER, an_dq4 NUMBER,
 av_mtrsn VARCHAR2, ad_date DATE
 ) IS
 BEGIN
  set_months_eom (an_mid, an_er, an_ed, an_q1, an_q3, an_q2, an_q4, an_aer, an_aed, an_aq1, an_aq3, an_aq2, an_aq4, an_ber, an_bed, an_bq1, an_bq3, an_bq2, an_bq4,
                  an_cer, an_ced, an_cq1, an_cq3, an_cq2, an_cq4, an_der, an_ded, an_dq1, an_dq3, an_dq2, an_dq4, av_mtrsn, ad_date);
 END;

------------------------------------------------------------------------------------------------------------------------
  --Вставка месячных показаний
 PROCEDURE set_months_ems_m (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_aerm NUMBER, an_aedm NUMBER,
 an_aq1m NUMBER, an_aq3m NUMBER, an_aq2m NUMBER, an_aq4m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_bq2m NUMBER, an_bq4m NUMBER,
 an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_cq2m NUMBER, an_cq4m NUMBER, an_derm NUMBER, an_dedm NUMBER, an_dq1m NUMBER, an_dq3m NUMBER,
 an_dq2m NUMBER, an_dq4m NUMBER, ad_date DATE
 ) IS
 BEGIN
  set_months_energy_m (an_mid, an_erm, an_edm, an_q1m, an_q3m, an_q2m, an_q4m, an_aerm, an_aedm, an_aq1m, an_aq3m, an_aq2m, an_aq4m, an_berm, an_bedm, an_bq1m,
                       an_bq3m, an_bq2m, an_bq4m, an_cerm, an_cedm, an_cq1m, an_cq3m, an_cq2m, an_cq4m, an_derm, an_dedm, an_dq1m, an_dq3m, an_dq2m, an_dq4m,
                       ad_date);
 END;

 ------------------------------------------------------------------------------------------------------------------------
 --******************************          DLL METER           *******************************************************--
------------------------------------------------------------------------------------------------------------------------
--Вставка текущих
 PROCEDURE set_curr_power_dllmtr (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_freq NUMBER,
 an_cos_fi NUMBER, an_volt1 NUMBER, an_volt2 NUMBER, an_volt3 NUMBER, an_curr1 NUMBER, an_curr2 NUMBER, an_curr3 NUMBER, an_fiu1i1 NUMBER, an_fiu2i2 NUMBER,
 an_fiu3i3 NUMBER, an_fiu1u2 NUMBER, an_fiu1u3 NUMBER, an_fiu2u3 NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER,
 an_type NUMBER, ad_date DATE
 ) IS
 BEGIN
  set_curr_power_meter (an_mid, an_erm, an_edm, an_q1m, an_q3m, an_q2m, an_q4m, an_freq, an_cos_fi, an_volt1, an_volt2, an_volt3, an_curr1, an_curr2, an_curr3,
                        an_fiu1i1, an_fiu2i2, an_fiu3i3, an_fiu1u2, an_fiu1u3, an_fiu2u3, an_er, an_ed, an_q1, an_q3, an_q2, an_q4, an_type, ad_date);
 END;

------------------------------------------------------------------------------------------------------------------------
  --Вставка суточных расходов
 PROCEDURE set_bill_dllmtr (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, an_aer NUMBER, an_aed NUMBER,
 an_aq1 NUMBER, an_aq3 NUMBER, an_aq2 NUMBER, an_aq4 NUMBER, an_ber NUMBER, an_bed NUMBER, an_bq1 NUMBER, an_bq3 NUMBER, an_bq2 NUMBER, an_bq4 NUMBER, an_cer NUMBER,
 an_ced NUMBER, an_cq1 NUMBER, an_cq3 NUMBER, an_cq2 NUMBER, an_cq4 NUMBER, an_der NUMBER, an_ded NUMBER, an_dq1 NUMBER, an_dq3 NUMBER, an_dq2 NUMBER, an_dq4 NUMBER,
 av_mtrsn VARCHAR2, an_type NUMBER, ad_date DATE
 ) IS
 BEGIN
  set_bill_eom (an_mid, an_er, an_ed, an_q1, an_q3, an_q2, an_q4, an_aer, an_aed, an_aq1, an_aq3, an_aq2, an_aq4, an_ber, an_bed, an_bq1, an_bq3, an_bq2, an_bq4,
                an_cer, an_ced, an_cq1, an_cq3, an_cq2, an_cq4, an_der, an_ded, an_dq1, an_dq3, an_dq2, an_dq4, av_mtrsn, ad_date);
 END;

------------------------------------------------------------------------------------------------------------------------
   --Вставка суточных показаний
 PROCEDURE set_bill_dllmtr_m (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_aerm NUMBER,
 an_aedm NUMBER, an_aq1m NUMBER, an_aq3m NUMBER, an_aq2m NUMBER, an_aq4m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_bq2m NUMBER,
 an_bq4m NUMBER, an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_cq2m NUMBER, an_cq4m NUMBER, an_derm NUMBER, an_dedm NUMBER, an_dq1m NUMBER,
 an_dq3m NUMBER, an_dq2m NUMBER, an_dq4m NUMBER, an_type NUMBER, ad_date DATE
 ) IS
 BEGIN
  set_bill_energy_m (an_mid, an_erm, an_edm, an_q1m, an_q3m, an_q2m, an_q4m, an_aerm, an_aedm, an_aq1m, an_aq3m, an_aq2m, an_aq4m, an_berm, an_bedm, an_bq1m,
                     an_bq3m, an_bq2m, an_bq4m, an_cerm, an_cedm, an_cq1m, an_cq3m, an_cq2m, an_cq4m, an_derm, an_dedm, an_dq1m, an_dq3m, an_dq2m, an_dq4m, ad_date);
 END;

------------------------------------------------------------------------------------------------------------------------
  --Вставка месячных расходов
 PROCEDURE set_months_dllmtr (an_mid NUMBER, an_er NUMBER, an_ed NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_q2 NUMBER, an_q4 NUMBER, an_aer NUMBER, an_aed NUMBER,
 an_aq1 NUMBER, an_aq3 NUMBER, an_aq2 NUMBER, an_aq4 NUMBER, an_ber NUMBER, an_bed NUMBER, an_bq1 NUMBER, an_bq3 NUMBER, an_bq2 NUMBER, an_bq4 NUMBER, an_cer NUMBER,
 an_ced NUMBER, an_cq1 NUMBER, an_cq3 NUMBER, an_cq2 NUMBER, an_cq4 NUMBER, an_der NUMBER, an_ded NUMBER, an_dq1 NUMBER, an_dq3 NUMBER, an_dq2 NUMBER, an_dq4 NUMBER,
 av_mtrsn VARCHAR2, an_type NUMBER, ad_date DATE
 ) IS
 BEGIN
  set_months_eom (an_mid, an_er, an_ed, an_q1, an_q3, an_q2, an_q4, an_aer, an_aed, an_aq1, an_aq3, an_aq2, an_aq4, an_ber, an_bed, an_bq1, an_bq3, an_bq2, an_bq4,
                  an_cer, an_ced, an_cq1, an_cq3, an_cq2, an_cq4, an_der, an_ded, an_dq1, an_dq3, an_dq2, an_dq4, av_mtrsn, ad_date);
 END;

------------------------------------------------------------------------------------------------------------------------
   --Вставка месячных показаний
 PROCEDURE set_months_dllmtr_m (an_mid NUMBER, an_erm NUMBER, an_edm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_q2m NUMBER, an_q4m NUMBER, an_aerm NUMBER,
 an_aedm NUMBER, an_aq1m NUMBER, an_aq3m NUMBER, an_aq2m NUMBER, an_aq4m NUMBER, an_berm NUMBER, an_bedm NUMBER, an_bq1m NUMBER, an_bq3m NUMBER, an_bq2m NUMBER,
 an_bq4m NUMBER, an_cerm NUMBER, an_cedm NUMBER, an_cq1m NUMBER, an_cq3m NUMBER, an_cq2m NUMBER, an_cq4m NUMBER, an_derm NUMBER, an_dedm NUMBER, an_dq1m NUMBER,
 an_dq3m NUMBER, an_dq2m NUMBER, an_dq4m NUMBER, an_type NUMBER, ad_date DATE
 ) IS
 BEGIN
  set_months_energy_m (an_mid, an_erm, an_edm, an_q1m, an_q3m, an_q2m, an_q4m, an_aerm, an_aedm, an_aq1m, an_aq3m, an_aq2m, an_aq4m, an_berm, an_bedm, an_bq1m,
                       an_bq3m, an_bq2m, an_bq4m, an_cerm, an_cedm, an_cq1m, an_cq3m, an_cq2m, an_cq4m, an_derm, an_dedm, an_dq1m, an_dq3m, an_dq2m, an_dq4m,
                       ad_date);
 END;

-----------------------------------------------------------------------------------------------------------------------
 --******************************          Универсальный механизм вставки событий          ******************************
 ------------------------------------------------------------------------------------------------------------------------
--Вставка событий - вспомогат. Возвращает 0- не вставляли 1-вставили -1 - не вставляли т.к. уже есть такое
 FUNCTION mark_status_univ_single (an_metertype NUMBER, an_mid NUMBER, ad_date DATE, an_event_hi NUMBER, an_event_lo NUMBER)
  RETURN NUMBER IS
  lv_code    VARCHAR2 (256);
  ln_state   NUMBER;
  lv_descr   VARCHAR2 (512);
  ln_lock    NUMBER;
  ln_event   NUMBER;
  ln_ret     NUMBER;
 BEGIN
  IF an_metertype IN (cn_argo, cn_sl_7000) THEN
   ln_event := comsrverr_pg.get_metererrinfo (an_metertype, an_event_hi, an_event_lo, lv_code, ln_state, lv_descr, ln_lock);
  END IF;

  IF ln_event > 0 AND ln_lock = 0 THEN
   ln_ret := admin_pg.ins_journal_p (ad_date, an_mid, ln_state, lv_descr, ln_event, lv_code);

   IF ln_ret = 0 THEN
    --RETURN -1;
    RETURN 0;
   END IF;

   RETURN 1;
  END IF;

  RETURN 0;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error (-20001, 'comsrv_pg.mark_status_univ_single_body: ' || SQLERRM (SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
 PROCEDURE mark_status_univ (an_metertype NUMBER, an_mid NUMBER, at_date_time common_pg.tt_varchar2, at_event_hi common_pg.tt_number,
 at_event_lo common_pg.tt_number) IS
  ld_date       DATE;
  ln_ret        NUMBER;
  ln_inserted   NUMBER DEFAULT 0;
 BEGIN
  FOR i IN 1 .. at_date_time.COUNT LOOP
   BEGIN
    ld_date := TO_DATE (at_date_time (i), 'dd.mm.yyyy hh24:mi:ss');

    IF ld_date <= SYSDATE THEN
     ln_ret := mark_status_univ_single (an_metertype, an_mid, ld_date, at_event_hi (i), at_event_lo (i));
    END IF;

    IF ln_ret > 0 THEN
     ln_inserted := 1;
    ELSIF ln_ret = -1 THEN
     EXIT;
    END IF;
   EXCEPTION
    WHEN OTHERS THEN
     NULL;
   END;
  END LOOP;

  IF ln_inserted > 0 THEN
   admin_pg.signal (6);
  END IF;
 END;

------------------------------------------------------------------------------------------------------------------------
--Вставка событий для schlum
 PROCEDURE mark_status_schlum (an_mid NUMBER, at_date_time common_pg.tt_varchar2, at_event_hi common_pg.tt_number, at_event_lo common_pg.tt_number) IS
 BEGIN
  mark_status_univ (cn_sl_7000, an_mid, at_date_time, at_event_hi, at_event_lo);
 END;

------------------------------------------------------------------------------------------------------------------------
  --Вставка событий argo
 PROCEDURE mark_status_argo (an_mid NUMBER, at_date_time common_pg.tt_varchar2, at_event_hi common_pg.tt_number, at_event_lo common_pg.tt_number) IS
 BEGIN
  mark_status_univ (cn_argo, an_mid, at_date_time, at_event_hi, at_event_lo);
 END;

------------------------------------------------------------------------------------------------------------------------

 -- Журнал событий ZxD
 PROCEDURE mark_zxd_event (an_mid NUMBER, ad_date DATE, an_event_hi NUMBER, an_found OUT NUMBER, av_state VARCHAR2, av_error VARCHAR2) IS
  lv_code    VARCHAR2 (256);
  ln_state   NUMBER;
  lv_descr   VARCHAR2 (512);
  ln_lock    NUMBER;
  ln_event   NUMBER;
  ln_ret     NUMBER;
 BEGIN
  an_found := 0;
  ln_event := comsrverr_pg.get_metererrinfo (cn_lg_zxd, an_event_hi, 0, lv_code, ln_state, lv_descr, ln_lock);

  IF ln_event > 0 AND ln_lock = 0 THEN
   ln_ret := admin_pg.ins_journal_p (ad_date, an_mid, ln_state, lv_descr || '. состояние: ' || av_state || '; ошибка F.F: ' || av_error, ln_event, lv_code);

   IF ln_ret = 0 THEN
    an_found := 1;
   END IF;
  END IF;
 END;

-----------------------------------------------------------------------------------------------------------------------
  --Статус LG
 PROCEDURE mark_lgstatus (newmid NUMBER, newdate_time DATE, newt NUMBER, newu NUMBER, news NUMBER, newm NUMBER, newkt NUMBER, newl1 IN OUT NUMBER,
 newl2 IN OUT NUMBER, newl3 IN OUT NUMBER
 ) IS
  t                NUMBER;
  u                NUMBER;
  s                NUMBER;
  m                NUMBER;
  kt               NUMBER;
  l1               NUMBER;
  l2               NUMBER;
  l3               NUMBER;
  ll               NUMBER;
  code             NUMBER          DEFAULT 0;
  MESSAGE          VARCHAR2 (2000);
  ln_tmp           NUMBER;
  newdate_time_l   DATE;
 BEGIN
  newdate_time_l := util_pg.to_localtime (newdate_time);

  SELECT NVL (MAX (t), 0), NVL (MAX (u), 0), NVL (MAX (s), 0), NVL (MAX (m), 0), NVL (MAX (l1), 0), NVL (MAX (l2), 0), NVL (MAX (l3), 0), MAX (1)
    INTO t, u, s, m, l1, l2, l3, ln_tmp
    FROM lgstatus
   WHERE mid = newmid;

  IF ln_tmp IS NULL THEN
   INSERT INTO lgstatus
               (mid, date_time, t, u, s, m, kt, l1, l2, l3
               )
        VALUES (newmid, SYSDATE - 365, 0, 0, 0, 0, 0, 0, 0, 0
               );
  END IF;

  SELECT NVL (MAX (nabc), 0)
    INTO ll
    FROM feeders
   WHERE mid = newmid;

  IF ll = 0 THEN   -- для двухэлементных счетчиков фаза В есть всегда
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
   MESSAGE := ' Смена сезона.';

   INSERT INTO journal
               (date_time, mid, state_cod, state_descr
               )
        VALUES (newdate_time_l, newmid, code, MESSAGE
               );
  END IF;

  IF newt <> 0 THEN
   code := -1001;
   MESSAGE := ' Коррекция часов.';

   INSERT INTO journal
               (date_time, mid, state_cod, state_descr
               )
        VALUES (newdate_time_l, newmid, code, MESSAGE
               );
  END IF;

  IF newm <> 0 THEN
   code := -1003;
   MESSAGE := ' Проведена параметризация счетчика.';

   INSERT INTO journal
               (date_time, mid, state_cod, state_descr
               )
        VALUES (newdate_time_l, newmid, code, MESSAGE
               );
  END IF;

  IF newu <> u AND newu = 1 THEN
   code := -1010;
   MESSAGE := ' Включение напряжения.';

   INSERT INTO journal
               (date_time, mid, state_cod, state_descr
               )
        VALUES (newdate_time_l, newmid, code, MESSAGE
               );
  END IF;

  IF newl1 <> l1 AND newl1 <> 0 AND newu <> 0 THEN
   code := -1005;
   MESSAGE := ' Есть фаза А.';

   INSERT INTO journal
               (date_time, mid, state_cod, state_descr
               )
        VALUES (newdate_time_l, newmid, code, MESSAGE
               );
  END IF;

  IF newl2 <> l2 AND newl2 <> 0 AND newu <> 0 THEN
   code := -1005;
   MESSAGE := ' Есть фаза B.';

   INSERT INTO journal
               (date_time, mid, state_cod, state_descr
               )
        VALUES (newdate_time_l, newmid, code, MESSAGE
               );
  END IF;

  IF newl3 <> l3 AND newl3 <> 0 AND newu <> 0 THEN
   code := -1005;
   MESSAGE := ' Есть фаза C.';

   INSERT INTO journal
               (date_time, mid, state_cod, state_descr
               )
        VALUES (newdate_time_l, newmid, code, MESSAGE
               );
  END IF;

  IF newl1 <> l1 AND newl1 = 0 AND newu <> 0 THEN
   code := 1005;
   MESSAGE := ' Нет фазы А.';

   INSERT INTO journal
               (date_time, mid, state_cod, state_descr
               )
        VALUES (newdate_time_l, newmid, code, MESSAGE
               );
  END IF;

  IF newl2 <> l2 AND newl2 = 0 AND newu <> 0 THEN
   code := 1005;
   MESSAGE := ' Нет фазы B.';

   INSERT INTO journal
               (date_time, mid, state_cod, state_descr
               )
        VALUES (newdate_time_l, newmid, code, MESSAGE
               );
  END IF;

  IF newl3 <> l3 AND newl3 = 0 AND newu <> 0 THEN
   code := 1005;
   MESSAGE := ' Нет фазы C.';

   INSERT INTO journal
               (date_time, mid, state_cod, state_descr
               )
        VALUES (newdate_time_l, newmid, code, MESSAGE
               );
  END IF;

  IF newu <> u AND newu = 0 THEN
   code := 1010;
   MESSAGE := ' Включение счетчика после отключения напряжения.';

   INSERT INTO journal
               (date_time, mid, state_cod, state_descr
               )
        VALUES (newdate_time_l, newmid, code, MESSAGE
               );
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

   admin_pg.signal (6);
  END IF;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error (-20001, 'comsrv_pg.mark_lgstatus: ' || SQLERRM (SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
 PROCEDURE mark_lgstatus_d (an_mid NUMBER, ad_date_time DATE, an_st NUMBER, an_lp NUMBER, an_ev NUMBER, an_uo NUMBER, an_u NUMBER, an_t NUMBER, an_kt NUMBER,
 an_s NUMBER, an_ip NUMBER, an_bt NUMBER, an_fe NUMBER
 ) IS
  ln_s             NUMBER;
  ln_bt            NUMBER;
  ln_fe            NUMBER;
  ln_code          NUMBER          DEFAULT 0;
  lv_message       VARCHAR2 (2000);
  ln_dif           NUMBER;
  ad_date_time_l   DATE;
 BEGIN
  /*
  if (StatusLP I 0x8000) St = 1; else St = 0; (Однократно) Запись статусного сообщения перед последним изменением времени
  if (StatusLP I 0x4000) Lp = 1; else Lp = 0; (Однократно) Память профиля данных полностью обнулена
  if (StatusLP I 0x2000) Ev = 1; else Ev = 0; (Однократно) Список событий полностью удален
  if (StatusLP I 0x0080) Uo = 1; else Uo = 0; (Однократно) Провал напряжения (по 3 фазам)
  if (StatusLP I 0x0040) U  = 1; else U  = 0; (Однократно) Восстановление напряжения
  if (StatusLP I 0x0020) T  = 1; else T  = 0; (Однократно) Изменено время/дата
  if (StatusLP I 0x0010) KT = 1; else KT = 0; (Однократно) Выполнен сброс
  if (StatusLP I 0x0008) S  = 1; else S  = 0; (По изменению) Лето или зима (1 = лето, 0 = зима)
  if (StatusLP I 0x0004) Ip = 1; else Ip = 0; (Не учит) Неполное измерение, интеграционный период слишком мал
  if (StatusLP I 0x0002) Bt = 1; else Bt = 0; (По изменению) Резерв питания календарных часов исчерпан (некорр. время)
  if (StatusLP I 0x0001) Fe = 1; else Fe = 0; (По изменению) Регистрация фатальной ошибки
  */
  ad_date_time_l := util_pg.to_localtime (ad_date_time);

  SELECT MAX (s), NVL (MAX (bt), 0), NVL (MAX (fe), 0), MAX (ad_date_time - date_time)
    INTO ln_s, ln_bt, ln_fe, ln_dif
    FROM lgstatus
   WHERE mid = an_mid;

  IF ln_s IS NULL THEN
   INSERT INTO lgstatus
               (mid, date_time, s, l1, l2, l3
               )
        VALUES (an_mid, SYSDATE - 365, an_s, 1, 1, 1
               );
  END IF;

  /*  IF ln_dif>-1 AND ln_dif<0  THEN
     RETURN;
    END IF; */
  IF an_st = 1 THEN
   ln_code := -1015;
   lv_message := ' Запись статусного сообщения перед последним изменением времени.';

   INSERT INTO journal
               (mid, date_time, state_cod, state_descr
               )
        VALUES (an_mid, ad_date_time_l, ln_code, lv_message
               );
  END IF;

  IF an_lp = 1 THEN
   ln_code := 1016;
   lv_message := ' Память профиля данных полностью обнулена.';

   INSERT INTO journal
               (mid, date_time, state_cod, state_descr
               )
        VALUES (an_mid, ad_date_time_l, ln_code, lv_message
               );
  END IF;

  IF an_ev = 1 THEN
   ln_code := 1014;
   lv_message := ' Сброс журнала событий.';

   INSERT INTO journal
               (mid, date_time, state_cod, state_descr
               )
        VALUES (an_mid, ad_date_time_l, ln_code, lv_message
               );
  END IF;

  IF an_uo = 1 THEN
   ln_code := 1010;
   lv_message := ' Отключение напряжения';

   INSERT INTO journal
               (mid, date_time, state_cod, state_descr
               )
        VALUES (an_mid, ad_date_time_l, ln_code, lv_message
               );
  END IF;

  IF an_u = 1 THEN
   ln_code := -1010;
   lv_message := ' Включение напряжения.';

   INSERT INTO journal
               (mid, date_time, state_cod, state_descr
               )
        VALUES (an_mid, ad_date_time_l, ln_code, lv_message
               );
  END IF;

  IF an_t = 1 THEN
   ln_code := -1001;
   lv_message := ' Коррекция часов.';

   INSERT INTO journal
               (mid, date_time, state_cod, state_descr
               )
        VALUES (an_mid, ad_date_time_l, ln_code, lv_message
               );
  END IF;

  IF an_kt = 1 THEN
   ln_code := 1013;
   lv_message := ' Выполнен сброс.';

   INSERT INTO journal
               (mid, date_time, state_cod, state_descr
               )
        VALUES (an_mid, ad_date_time_l, ln_code, lv_message
               );
  END IF;

  IF ln_s <> an_s THEN
   ln_code := -1002;
   lv_message := ' Смена сезона.';

   INSERT INTO journal
               (mid, date_time, state_cod, state_descr
               )
        VALUES (an_mid, ad_date_time_l, ln_code, lv_message
               );
  END IF;

  IF ln_bt <> an_bt THEN
   IF an_bt = 1 THEN
    ln_code := 1017;
    lv_message := ' Резерв питания календарных часов исчерпан. ';
   ELSE
    ln_code := -1017;
    lv_message := ' Резерв питания календарных часов восстановлен. ';
   END IF;

   INSERT INTO journal
               (mid, date_time, state_cod, state_descr
               )
        VALUES (an_mid, ad_date_time_l, ln_code, lv_message
               );
  END IF;

  IF ln_fe <> an_fe THEN
   IF an_fe = 1 THEN
    ln_code := 1018;
    lv_message := ' Фатальная ошибка. ';
   ELSE
    ln_code := -1018;
    lv_message := ' Фатальная ошибка устранена. ';
   END IF;

   INSERT INTO journal
               (mid, date_time, state_cod, state_descr
               )
        VALUES (an_mid, ad_date_time_l, ln_code, lv_message
               );
  END IF;

  IF ln_code <> 0 THEN
   UPDATE lgstatus
      SET date_time = ad_date_time,
          s = an_s,
          bt = an_bt,
          fe = an_fe
    WHERE mid = an_mid;
  END IF;

  admin_pg.signal (6);
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error (-20001, 'comsrv_pg.mark_lgstatus_d: ' || SQLERRM (SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
 --Вставка информации по наличаю фазы
 PROCEDURE set_abc_zxb (an_mid NUMBER, an_volt1 NUMBER, an_volt2 NUMBER, an_volt3 NUMBER, ad_date DATE) IS
  ln_l1        NUMBER;
  ln_l2        NUMBER;
  ln_l3        NUMBER;
  ln_code      NUMBER          DEFAULT 0;
  lv_message   VARCHAR2 (2000);
  ln_tmp       NUMBER;
  ln_volt1     NUMBER;
  ln_volt2     NUMBER;
  ln_volt3     NUMBER;
  ln_abc       NUMBER;
 BEGIN
  SELECT DECODE (an_volt1, NULL, 0, 1), DECODE (an_volt2, NULL, 0, 1), DECODE (an_volt3, NULL, 0, 1)
    INTO ln_volt1, ln_volt2, ln_volt3
    FROM DUAL;

  SELECT NVL (MAX (nabc), 0)
    INTO ln_abc
    FROM feeders
   WHERE mid = an_mid;

  IF ln_abc = 0 THEN
   ln_volt2 := 1;
  END IF;

  SELECT NVL (MAX (l1), 1), NVL (MAX (l2), 1), NVL (MAX (l3), 1), MAX (1)
    INTO ln_l1, ln_l2, ln_l3, ln_tmp
    FROM lgstatus
   WHERE mid = an_mid;

  IF ln_tmp IS NULL THEN
   INSERT INTO lgstatus
               (mid, date_time, t, u, s, m, kt, l1, l2, l3
               )
        VALUES (an_mid, SYSDATE - 365, 0, 1, 0, 0, 0, 1, 1, 1
               );
  END IF;

  IF ln_volt1 <> ln_l1 AND ln_volt1 <> 0 AND an_volt1 IS NOT NULL THEN
   ln_code := -1005;
   lv_message := ' Есть фаза A.';

   INSERT INTO journal
               (date_time, mid, state_cod, state_descr
               )
        VALUES (ad_date, an_mid, ln_code, lv_message
               );
  END IF;

  IF ln_volt1 <> ln_l1 AND ln_volt1 = 0 AND an_volt1 IS NOT NULL THEN
   ln_code := 1005;
   lv_message := ' Нет фазы A.';

   INSERT INTO journal
               (date_time, mid, state_cod, state_descr
               )
        VALUES (ad_date, an_mid, ln_code, lv_message
               );
  END IF;

  IF ln_volt2 <> ln_l2 AND ln_volt2 <> 0 AND an_volt2 IS NOT NULL THEN
   ln_code := -1005;
   lv_message := ' Есть фаза B.';

   INSERT INTO journal
               (date_time, mid, state_cod, state_descr
               )
        VALUES (ad_date, an_mid, ln_code, lv_message
               );
  END IF;

  IF ln_volt2 <> ln_l2 AND ln_volt2 = 0 AND an_volt2 IS NOT NULL THEN
   ln_code := 1005;
   lv_message := ' Нет фазы B.';

   INSERT INTO journal
               (date_time, mid, state_cod, state_descr
               )
        VALUES (ad_date, an_mid, ln_code, lv_message
               );
  END IF;

  IF ln_volt3 <> ln_l3 AND ln_volt3 <> 0 AND an_volt3 IS NOT NULL THEN
   ln_code := -1005;
   lv_message := ' Есть фаза C.';

   INSERT INTO journal
               (date_time, mid, state_cod, state_descr
               )
        VALUES (ad_date, an_mid, ln_code, lv_message
               );
  END IF;

  IF ln_volt3 <> ln_l3 AND ln_volt3 = 0 AND an_volt3 IS NOT NULL THEN
   ln_code := 1005;
   lv_message := ' Нет фазы C.';

   INSERT INTO journal
               (date_time, mid, state_cod, state_descr
               )
        VALUES (ad_date, an_mid, ln_code, lv_message
               );
  END IF;

  IF ln_code <> 0 THEN
   UPDATE lgstatus
      SET date_time = ad_date,
          u = 1,
          l1 = ln_volt1,
          l2 = ln_volt2,
          l3 = ln_volt3
    WHERE mid = an_mid;

   admin_pg.signal (6);
  END IF;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error (-20001, 'comsrv_pg.set_abc_zxb: ' || SQLERRM (SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
 PROCEDURE mark_a1140event (newmid NUMBER, newev_date DATE, newtype NUMBER, FOUND OUT NUMBER) IS
  code       NUMBER          DEFAULT 0;
  MESSAGE    VARCHAR2 (2000);
  state      NUMBER;
  newtype1   NUMBER;
 BEGIN
  state := MOD (newtype, 10);
  newtype1 := FLOOR (newtype / 10);
  code := -1001;

  CASE
   WHEN newtype1 >= 1 AND newtype1 <= 3 THEN
    MESSAGE := ' Обратный ход ';
   WHEN newtype1 >= 4 AND newtype1 <= 6 THEN
    MESSAGE := ' Отключение фазы: ';

    IF BITAND (state, 1) = 1 THEN
     MESSAGE := MESSAGE || ' A';
    END IF;

    IF BITAND (state, 2) = 2 THEN
     MESSAGE := MESSAGE || ' B';
    END IF;

    IF BITAND (state, 4) = 4 THEN
     MESSAGE := MESSAGE || ' C';
    END IF;
   WHEN newtype1 >= 7 AND newtype1 <= 9 THEN
    MESSAGE := ' Отключение питания ';
   WHEN newtype1 >= 10 AND newtype1 <= 12 THEN
    MESSAGE := ' Программирование счетчика';

    IF state = 0 THEN
     MESSAGE := MESSAGE || ' (оптопорт)';
    ELSIF state = 1 THEN
     MESSAGE := MESSAGE || ' (удаленно)';
    END IF;
   WHEN newtype1 >= 13 AND newtype1 <= 15 THEN
    MESSAGE := ' Изменение коэффициента CT';

    IF state = 0 THEN
     MESSAGE := MESSAGE || ' (оптопорт)';
    ELSIF state = 1 THEN
     MESSAGE := MESSAGE || ' (удаленно)';
    END IF;
   WHEN newtype1 >= 16 AND newtype1 <= 18 THEN
    MESSAGE := ' Событие биллинга';
   WHEN newtype1 >= 19 AND newtype1 <= 21 THEN
    MESSAGE := ' Транзитный сброс';
   WHEN newtype1 >= 22 AND newtype1 <= 24 THEN
    MESSAGE := ' Ошибка счетчика';
   WHEN newtype1 >= 25 AND newtype1 <= 27 THEN
    MESSAGE := ' Крышка терминала';
   WHEN newtype1 >= 28 AND newtype1 <= 30 THEN
    MESSAGE := ' Крышка основная';
   WHEN newtype1 >= 31 AND newtype1 <= 33 THEN
    MESSAGE := ' Батарея внутренняя';
   WHEN newtype1 >= 34 AND newtype1 <= 36 THEN
    MESSAGE := ' Батарея внешняя';
   WHEN newtype1 = 37 THEN
    MESSAGE := ' Установка внешней батареи ';
   ELSE
    MESSAGE := ' Событие счетчика: ' || newtype1 || '/' || state;
  END CASE;

  SELECT COUNT (*)
    INTO FOUND
    FROM DUAL
   WHERE EXISTS (SELECT evtype
                   FROM ea_events
                  WHERE mid = newmid AND evdate = newev_date AND evtype = newtype);

  IF FOUND = 1 THEN
   RETURN;
  END IF;

  INSERT INTO journal
              (date_time, mid, state_cod, state_descr
              )
       VALUES (newev_date, newmid, code, MESSAGE
              );

  INSERT INTO ea_events
              (mid, evdate, evtype
              )
       VALUES (newmid, newev_date, newtype
              );
 END;

------------------------------------------------------------------------------------------------------------------------
 PROCEDURE mark_eaevent (newmid NUMBER, newev_date DATE, newtype NUMBER, FOUND OUT NUMBER) IS
  code      NUMBER          DEFAULT 0;
  MESSAGE   VARCHAR2 (2000);
 BEGIN
  IF newtype = 0 THEN
   code := 1010;
   MESSAGE := ' Отключение напряжения.';
  END IF;

  IF newtype = 1 THEN
   code := -1010;
   MESSAGE := ' Включение напряжения.';
  END IF;

  IF newtype = 2 THEN
   code := -1001;
   MESSAGE := ' Коррекция часов. Время до коррекции.';
  END IF;

  IF newtype = 3 THEN
   code := 1001;
   MESSAGE := ' Коррекция часов. Время после коррекции.';
  END IF;

  IF newtype = 4 THEN
   code := 1011;
   MESSAGE := ' Начало режима тестирования счетчика.';
  END IF;

  IF newtype = 5 THEN
   code := 1012;
   MESSAGE := ' Окончание режима тестирования счетчика.';
  END IF;

  IF newtype = 6 THEN
   code := 1013;
   MESSAGE := ' Сброс максимальной мощности.';
  END IF;

  IF newtype = 255 THEN
   code := 1014;
   MESSAGE := ' Сброс журнала событий.';
  END IF;

  SELECT COUNT (*)
    INTO FOUND
    FROM DUAL
   WHERE EXISTS (SELECT evtype
                   FROM ea_events
                  WHERE mid = newmid AND evdate = newev_date AND evtype = newtype);

  IF FOUND = 1 THEN
   RETURN;
  END IF;

  INSERT INTO journal
              (date_time, mid, state_cod, state_descr
              )
       VALUES (newev_date, newmid, code, MESSAGE
              );

  INSERT INTO ea_events
              (mid, evdate, evtype
              )
       VALUES (newmid, newev_date, newtype
              );
 END;

------------------------------------------------------------------------------------------------------------------------
 --Журнал событий
 PROCEDURE mark_energyevent (newmid NUMBER, newev_date DATE, newtype NUMBER, FOUND OUT NUMBER, newl1 NUMBER, newl2 NUMBER, newl3 NUMBER) IS
  ll        NUMBER;
  code      NUMBER;
  MESSAGE   VARCHAR2 (2000);
 BEGIN
  SELECT COUNT (*)
    INTO FOUND
    FROM DUAL
   WHERE EXISTS (SELECT *
                   FROM ea_events
                  WHERE mid = newmid AND evdate = newev_date AND evtype = newtype);

  IF FOUND = 1 THEN
   RETURN;
  END IF;

  INSERT INTO ea_events
              (mid, evdate, evtype
              )
       VALUES (newmid, newev_date, newtype
              );

  code := -1005;

  IF newl1 = 0 THEN
   MESSAGE := ' Есть фаза А.';
  ELSE
   code := 1005;
   MESSAGE := ' Нет фазы А.';
  END IF;

  SELECT NVL (nabc, 0)
    INTO ll
    FROM feeders
   WHERE mid = newmid;

  IF ll <> 0 THEN   -- для двухэлементных счетчиков фаза В есть всегда
   IF newl2 = 0 THEN
    MESSAGE := MESSAGE || ' Есть фаза B.';
   ELSE
    code := 1005;
    MESSAGE := MESSAGE || ' Нет фазы B.';
   END IF;
  END IF;

  IF newl3 = 0 THEN
   MESSAGE := MESSAGE || ' Есть фаза C.';
  ELSE
   code := 1005;
   MESSAGE := MESSAGE || ' Нет фазы C.';
  END IF;

  INSERT INTO journal
              (date_time, mid, state_cod, state_descr
              )
       VALUES (newev_date, newmid, code, MESSAGE
              );
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error (-20001, 'comsrv_pg.mark_energyevent: ' || SQLERRM (SQLCODE));
 END;

-----------------------------------------------------------------------------------------------------------------------
 PROCEDURE mark_elvinevent (newmid NUMBER, newev_date DATE, newtype NUMBER, FOUND OUT NUMBER) IS
  evtype    NUMBER;
  code      NUMBER          DEFAULT 0;
  MESSAGE   VARCHAR2 (2000);
  l_type    NUMBER;
 BEGIN
  IF newtype = 0 THEN
   code := 1010;
   MESSAGE := ' Отключение счетчика.';
  END IF;

  IF newtype = 1 THEN
   code := -1010;
   MESSAGE := ' Включение счетчика. Нет напряжения на фазах.';
  END IF;

  IF newtype > 1 THEN
   l_type := MOD (newtype, 16);
   MESSAGE := '';

   IF l_type >= 8 THEN
    code := -1005;
    MESSAGE := MESSAGE || ' Включение фазы C.';
   END IF;

   l_type := MOD (newtype, 8);

   IF l_type >= 4 THEN
    code := -1005;
    MESSAGE := MESSAGE || ' Включение фазы B.';
   END IF;

   l_type := MOD (newtype, 4);

   IF l_type >= 2 THEN
    code := -1005;
    MESSAGE := MESSAGE || ' Включение фазы A.';
   END IF;
  END IF;

  SELECT evtype
    INTO evtype
    FROM ea_events
   WHERE mid = newmid AND evdate = newev_date AND evtype = newtype;

  FOUND := 1;
 EXCEPTION
  WHEN NO_DATA_FOUND THEN
   INSERT INTO journal
               (date_time, mid, state_cod, state_descr
               )
        VALUES (newev_date, newmid, code, MESSAGE
               );

   INSERT INTO ea_events
               (mid, evdate, evtype
               )
        VALUES (newmid, newev_date, newtype
               );

   FOUND := 0;
  WHEN OTHERS THEN
   raise_application_error (-20001, 'comsrv_pg.mark_elvinevent: ' || SQLERRM (SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
-- Журнал событий SET4
 PROCEDURE mark_set4event (newmid NUMBER, newev_date DATE, newtype NUMBER, FOUND OUT NUMBER) IS
  evtype    NUMBER;
  code      NUMBER          DEFAULT 0;
  MESSAGE   VARCHAR2 (2000);
 BEGIN
  IF newtype = 1 THEN
   code := 1010;
   MESSAGE := ' Отключение счетчика.';
  END IF;

  IF newtype = 256 THEN
   code := -1010;
   MESSAGE := ' Включение счетчика.';
  END IF;

  IF newtype = 2 THEN
   code := -1001;
   MESSAGE := ' Коррекция часов. Время до коррекции.';
  END IF;

  IF newtype = 512 THEN
   code := 1001;
   MESSAGE := ' Коррекция часов. Время после коррекции.';
  END IF;

  IF newtype = 3 THEN
   code := 1019;
   MESSAGE := ' Коррекция расписания праздничных дней.';
  END IF;

  IF newtype = 4 THEN
   code := 1020;
   MESSAGE := ' Коррекция тарифного расписания.';
  END IF;

  IF newtype = 5 THEN
   code := 1021;
   MESSAGE := ' Сброс показаний энергии.';
  END IF;

  IF newtype = 6 THEN
   code := 1022;
   MESSAGE := ' Инициализация массива профиля мощности.';
  END IF;

  IF newtype = 7 THEN
   code := 1005;
   MESSAGE := ' Выключение фазы 1 счетчика.';
  END IF;

  IF newtype = 7 * 256 THEN
   code := -1005;
   MESSAGE := ' Включение фазы 1 счетчика.';
  END IF;

  IF newtype = 8 THEN
   code := 1005;
   MESSAGE := ' Выключение фазы 2 счетчика.';
  END IF;

  IF newtype = 8 * 256 THEN
   code := -1005;
   MESSAGE := ' Включение фазы 2 счетчика.';
  END IF;

  IF newtype = 9 THEN
   code := 1005;
   MESSAGE := ' Выключение фазы 3 счетчика.';
  END IF;

  IF newtype = 9 * 256 THEN
   code := -1005;
   MESSAGE := ' Включение фазы 3 счетчика.';
  END IF;

  IF newtype = 10 THEN
   code := 1023;
   MESSAGE := ' Открытие защитной крышки.';
  END IF;

  IF newtype = 10 * 256 THEN
   code := 1023;
   MESSAGE := ' Закрытие защитной крышки.';
  END IF;

  SELECT evtype
    INTO evtype
    FROM ea_events
   WHERE mid = newmid AND evdate = newev_date AND evtype = newtype;

  FOUND := 1;
 EXCEPTION
  WHEN NO_DATA_FOUND THEN
   INSERT INTO journal
               (date_time, mid, state_cod, state_descr
               )
        VALUES (newev_date, newmid, code, MESSAGE
               );

   INSERT INTO ea_events
               (mid, evdate, evtype
               )
        VALUES (newmid, newev_date, newtype
               );

   FOUND := 0;
  WHEN OTHERS THEN
   raise_application_error (-20001, 'comsrv_pg.mark_set4event: ' || SQLERRM (SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
-- Журнал событий SEB 2A.07
 PROCEDURE mark_seb2a07event (newmid NUMBER, newev_date DATE, newtype NUMBER, FOUND OUT NUMBER) IS
  code      NUMBER          DEFAULT 0;
  MESSAGE   VARCHAR2 (2000);
  state     NUMBER;
 BEGIN
  IF newtype = 1 THEN
   code := -1010;
   MESSAGE := ' Включение счетчика.';
  END IF;

  IF newtype = 2 THEN
   code := 1010;
   MESSAGE := ' Отключение счетчика.';
  END IF;

  IF newtype = 3 THEN
   code := 1023;
   MESSAGE := ' Открытие защитной крышки.';
  END IF;

  IF newtype = 4 THEN
   code := -1001;
   MESSAGE := ' Коррекция часов. Время до коррекции.';
  END IF;

  SELECT COUNT (*)
    INTO FOUND
    FROM DUAL
   WHERE EXISTS (SELECT evtype
                   FROM ea_events
                  WHERE mid = newmid AND evdate = newev_date AND evtype = newtype);

  IF FOUND = 1 THEN
   RETURN;
  END IF;

  INSERT INTO journal
              (date_time, mid, state_cod, state_descr
              )
       VALUES (newev_date, newmid, code, MESSAGE
              );

  INSERT INTO ea_events
              (mid, evdate, evtype
              )
       VALUES (newmid, newev_date, newtype
              );
 END;

------------------------------------------------------------------------------------------------------------------------
 PROCEDURE mark_lzqmevent (newmid NUMBER, newev_date DATE, newtype NUMBER, FOUND OUT NUMBER, newstate NUMBER) IS
  evtype    NUMBER;
  code      NUMBER          DEFAULT 0;
  MESSAGE   VARCHAR2 (2000);
 BEGIN
  IF newtype = 0 THEN
   code := 1010;
   MESSAGE := ' Отключение счетчика.';
  END IF;

  IF newtype = 1 THEN
   code := -1010;
   MESSAGE := ' Включение счетчика.';
  END IF;

  IF newtype = 2 THEN
   code := -1010;
   MESSAGE := ' Изменение состояния фаз: ' || newstate;
  END IF;

  SELECT evtype
    INTO evtype
    FROM ea_events
   WHERE mid = newmid AND evdate = newev_date AND evtype = newtype;

  FOUND := 1;
 EXCEPTION
  WHEN NO_DATA_FOUND THEN
   INSERT INTO journal
               (date_time, mid, state_cod, state_descr
               )
        VALUES (newev_date, newmid, code, MESSAGE
               );

   INSERT INTO ea_events
               (mid, evdate, evtype
               )
        VALUES (newmid, newev_date, newtype
               );

   FOUND := 0;
  WHEN OTHERS THEN
   raise_application_error (-20001, 'comsrv_pg.mark_lzqmevent: ' || SQLERRM (SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
-- журнал событий
 PROCEDURE mark_ce304event (newmid NUMBER, newev_date DATE, newtype NUMBER, FOUND OUT NUMBER, newstate NUMBER) IS
  evtype    NUMBER;
  code      NUMBER          DEFAULT 0;
  MESSAGE   VARCHAR2 (2000);
  ln_type   NUMBER;
 BEGIN
  ln_type := (newtype * 65536) + newstate;

  IF newtype = 0 THEN
   IF newstate = 0 THEN
    code := -1015;
    MESSAGE := 'Проблем счетчика не обнаружено';
   ELSE
    code := 1015;
    MESSAGE := '';

    IF BITAND (newstate, 1) = 1 THEN
     MESSAGE := 'Сбой часов реального времени (невозможна тарификация) ' || MESSAGE;
    END IF;

    IF BITAND (newstate, 2) = 2 THEN
     MESSAGE := 'Проблемы группы системного времени (может быть неучтена энергия последнего измерения) ' || MESSAGE;
    END IF;

    IF BITAND (newstate, 4) = 4 THEN
     MESSAGE := 'Проблемы группы технологической (нет учета энергии) ' || MESSAGE;
    END IF;

    IF BITAND (newstate, 8) = 8 THEN
     MESSAGE := 'Проблемы группы параметров измерителя (нет учета энергии) ' || MESSAGE;
    END IF;

    IF BITAND (newstate, 16) = 16 THEN
     MESSAGE := 'Проблемы группы интерфейсного обмена (недостоверны параметры обмена) ' || MESSAGE;
    END IF;

    IF BITAND (newstate, 32) = 32 THEN
     MESSAGE := 'Проблемы группы тарификации (нет учета по тарифам) ' || MESSAGE;
    END IF;

    IF BITAND (newstate, 64) = 64 THEN
     MESSAGE := 'Проблемы накопленных основных данных (недостоверна группа накопления энергий активного тарифа) ' || MESSAGE;
    END IF;

    IF BITAND (newstate, 128) = 128 THEN
     MESSAGE := 'Проблемы накопленных дополнительных данных (недостоверны максимумы средней мощности и активные записи профилей) ' || MESSAGE;
    END IF;

    IF BITAND (newstate, 256) = 256 THEN
     MESSAGE := 'Проблемы группы журналов (недостоверна информация в журналах) ' || MESSAGE;
    END IF;

    IF BITAND (newstate, 512) = 512 THEN
     MESSAGE := 'Неожиданный аппаратный сброс ' || MESSAGE;
    END IF;

    IF BITAND (newstate, 1024) = 1024 THEN
     MESSAGE := 'Проблемы накопителя данных профиля. ' || MESSAGE;
    END IF;
   END IF;
  END IF;

  IF newtype = 1 THEN
   IF newstate = 0 THEN
    code := -1011;
    MESSAGE := 'Все параметры счетчика в норме';   --'Отклонений значений параметров не обнаружено';
   ELSE
    code := 1011;
    MESSAGE := '';

    IF BITAND (newstate, 1) = 1 THEN
     MESSAGE := 'Фаза А выключена (напряжение фазы меньше 5% номинального) ' || MESSAGE;
    END IF;

    IF BITAND (newstate, 2) = 2 THEN
     MESSAGE := 'Фаза B выключена (напряжение фазы меньше 5% номинального) ' || MESSAGE;
    END IF;

    IF BITAND (newstate, 4) = 4 THEN
     MESSAGE := 'Фаза C выключена (напряжение фазы меньше 5% номинального) ' || MESSAGE;
    END IF;

    IF BITAND (newstate, 8) = 8 THEN
     MESSAGE := 'Напряжение фазы А меньше заданного параметром LEVDN ' || MESSAGE;
    END IF;

    IF BITAND (newstate, 16) = 16 THEN
     MESSAGE := 'Напряжение фазы B меньше заданного параметром LEVDN ' || MESSAGE;
    END IF;

    IF BITAND (newstate, 32) = 32 THEN
     MESSAGE := 'Напряжение фазы C меньше заданного параметром LEVDN ' || MESSAGE;
    END IF;

    IF BITAND (newstate, 64) = 64 THEN
     MESSAGE := 'Напряжение фазы А больше заданного параметром LEVUP ' || MESSAGE;
    END IF;

    IF BITAND (newstate, 128) = 128 THEN
     MESSAGE := 'Напряжение фазы B больше заданного параметром LEVUP ' || MESSAGE;
    END IF;

    IF BITAND (newstate, 256) = 256 THEN
     MESSAGE := 'Напряжение фазы C больше заданного параметром LEVUP ' || MESSAGE;
    END IF;

    IF BITAND (newstate, 512) = 512 THEN
     MESSAGE := 'Частота сети вне диапазона от 47,5 до 52,5 Гц ' || MESSAGE;
    END IF;
   END IF;
  END IF;

  IF newtype = 2 THEN
   code := 1012;
   MESSAGE := 'Очистка накопленных данных каналов вычислителя';
  END IF;

  IF newtype = 3 THEN
   code := 1013;
   MESSAGE := 'Неожиданный аппаратный сброс';
  END IF;

  IF newtype = 4 THEN
   code := 1010;
   MESSAGE := 'Выключение счетчика';
  END IF;

  IF newtype = 5 THEN
   code := -1010;
   MESSAGE := 'Включение счетчика';
  END IF;

  SELECT evtype
    INTO evtype
    FROM ea_events
   WHERE mid = newmid AND evdate = newev_date AND evtype = ln_type;

  FOUND := 1;
 EXCEPTION
  WHEN NO_DATA_FOUND THEN
   INSERT INTO journal
               (date_time, mid, state_cod, state_descr
               )
        VALUES (newev_date, newmid, code, MESSAGE
               );

   INSERT INTO ea_events
               (mid, evdate, evtype
               )
        VALUES (newmid, newev_date, ln_type
               );

   FOUND := 0;
  WHEN OTHERS THEN
   raise_application_error (-20001, 'comsrv_pg.mark_ce304event: ' || SQLERRM (SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
 PROCEDURE mark_ce6850event (newmid NUMBER, newev_date DATE, newtype NUMBER, FOUND OUT NUMBER, newstate NUMBER) IS
  evtype    NUMBER;
  code      NUMBER          DEFAULT 0;
  MESSAGE   VARCHAR2 (2000);
  ln_type   NUMBER;
 BEGIN
  ln_type := (newtype * 65536) + newstate;

  IF newtype = 0 THEN
   IF newstate = 0 THEN
    code := -1011;
    MESSAGE := 'Фазы счетчика в норме';   --'Отклонений значений параметров не обнаружено';
   ELSE
    code := 1011;
    MESSAGE := '';

    IF BITAND (newstate, 1) = 1 THEN
     MESSAGE := 'Превышение напряжения фазы А ' || MESSAGE;
    END IF;

    IF BITAND (newstate, 2) = 2 THEN
     MESSAGE := 'Превышение напряжения фазы B ' || MESSAGE;
    END IF;

    IF BITAND (newstate, 4) = 4 THEN
     MESSAGE := 'Превышение напряжения фазы C ' || MESSAGE;
    END IF;

    IF BITAND (newstate, 8) = 8 THEN
     MESSAGE := 'Понижение напряжения фазы А ' || MESSAGE;
    END IF;

    IF BITAND (newstate, 16) = 16 THEN
     MESSAGE := 'Понижение напряжения фазы B ' || MESSAGE;
    END IF;

    IF BITAND (newstate, 32) = 32 THEN
     MESSAGE := 'Понижение напряжения фазы C ' || MESSAGE;
    END IF;

    IF BITAND (newstate, 64) = 64 THEN
     MESSAGE := 'Нет напряжения фазы А ' || MESSAGE;
    END IF;

    IF BITAND (newstate, 128) = 128 THEN
     MESSAGE := 'Нет напряжения фазы B ' || MESSAGE;
    END IF;

    IF BITAND (newstate, 256) = 256 THEN
     MESSAGE := 'Нет напряжения фазы C ' || MESSAGE;
    END IF;

    IF BITAND (newstate, 512) = 512 THEN
     MESSAGE := 'Выключение счетчика ' || MESSAGE;
    END IF;
   END IF;
  END IF;

  IF newtype = 1 THEN
   IF newstate = 0 THEN
    code := -1012;
    MESSAGE := 'Состояние счетчика в норме';
   ELSE
    code := 1012;
    MESSAGE := '';

    IF BITAND (newstate, 1) = 1 THEN
     MESSAGE := 'Ошибка контрольной суммы калибровочных коэффициентов ' || MESSAGE;
    END IF;

    IF BITAND (newstate, 2) = 2 THEN
     MESSAGE := 'Ошибка накопления энергии (суммарная) ' || MESSAGE;
    END IF;

    IF BITAND (newstate, 4) = 4 THEN
     MESSAGE := 'Ошибка EEPROM ' || MESSAGE;
    END IF;

    IF BITAND (newstate, 8) = 8 THEN
     MESSAGE := 'Состояние (резерв) ' || MESSAGE;
    END IF;

    IF BITAND (newstate, 16) = 16 THEN
     MESSAGE := 'Ошибка массива <Исключительные дни> ' || MESSAGE;
    END IF;

    IF BITAND (newstate, 32) = 32 THEN
     MESSAGE := 'Ошибка массива <Сезонные графики> ' || MESSAGE;
    END IF;

    IF BITAND (newstate, 64) = 64 THEN
     MESSAGE := 'Ошибка массива <Тарифные графики> ' || MESSAGE;
    END IF;

    IF BITAND (newstate, 128) = 128 THEN
     MESSAGE := 'Ошибка массива <Графики дней> ' || MESSAGE;
    END IF;

    IF BITAND (newstate, 256) = 256 THEN
     MESSAGE := 'Авария питания ' || MESSAGE;
    END IF;

    IF BITAND (newstate, 512) = 512 THEN
     MESSAGE := 'Разряд батарейки ' || MESSAGE;
    END IF;

    IF BITAND (newstate, 1024) = 1024 THEN
     MESSAGE := 'Ошибка чтения часов ' || MESSAGE;
    END IF;

    IF BITAND (newstate, 2048) = 2048 THEN
     MESSAGE := 'Последнее воскресенье месяца ' || MESSAGE;
    END IF;

    IF BITAND (newstate, 4096) = 4096 THEN
     MESSAGE := 'Летнее время ' || MESSAGE;
    END IF;

    IF BITAND (newstate, 8192) = 8192 THEN
     MESSAGE := 'Была корректировка часов ' || MESSAGE;
    END IF;

    IF BITAND (newstate, 16384) = 16384 THEN
     MESSAGE := 'Ошибка записи энергий нарастающим итогом ' || MESSAGE;
    END IF;
   END IF;
  END IF;

  SELECT evtype
    INTO evtype
    FROM ea_events
   WHERE mid = newmid AND evdate = newev_date AND evtype = ln_type;

  FOUND := 1;
 EXCEPTION
  WHEN NO_DATA_FOUND THEN
   INSERT INTO journal
               (date_time, mid, state_cod, state_descr
               )
        VALUES (newev_date, newmid, code, MESSAGE
               );

   INSERT INTO ea_events
               (mid, evdate, evtype
               )
        VALUES (newmid, newev_date, ln_type
               );

   FOUND := 0;
  WHEN OTHERS THEN
   raise_application_error (-20001, 'comsrv_pg.mark_ce6850event: ' || SQLERRM (SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
 PROCEDURE mark_ce303event (newmid NUMBER, newev_date DATE, newtype NUMBER, FOUND OUT NUMBER, newstate NUMBER) IS
  evtype    NUMBER;
  code      NUMBER          DEFAULT 0;
  MESSAGE   VARCHAR2 (2000);
  ln_type   NUMBER;
 BEGIN
  ln_type := (newtype * 65536) + newstate;

  IF newtype = 0 THEN
   code := 1011;
   MESSAGE := '';

   IF BITAND (newstate, 1) = 1 THEN
    MESSAGE := 'Фаза А-(1) ' || MESSAGE;
   ELSE
    MESSAGE := 'Фаза А-(0) ' || MESSAGE;
   END IF;

   IF BITAND (newstate, 2) = 2 THEN
    MESSAGE := 'Фаза B-(1) ' || MESSAGE;
   ELSE
    MESSAGE := 'Фаза B-(0) ' || MESSAGE;
   END IF;

   IF BITAND (newstate, 4) = 4 THEN
    MESSAGE := 'Фаза C-(1) ' || MESSAGE;
   ELSE
    MESSAGE := 'Фаза C-(0) ' || MESSAGE;
   END IF;
  END IF;

  SELECT evtype
    INTO evtype
    FROM ea_events
   WHERE mid = newmid AND evdate = newev_date AND evtype = ln_type;

  FOUND := 1;
 EXCEPTION
  WHEN NO_DATA_FOUND THEN
   INSERT INTO journal
               (date_time, mid, state_cod, state_descr
               )
        VALUES (newev_date, newmid, code, MESSAGE
               );

   INSERT INTO ea_events
               (mid, evdate, evtype
               )
        VALUES (newmid, newev_date, ln_type
               );

   FOUND := 0;
  WHEN OTHERS THEN
   raise_application_error (-20001, 'comsrv_pg.mark_ce303event: ' || SQLERRM (SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
 PROCEDURE set_parametrization_date (an_mid NUMBER, av_date VARCHAR2) IS   --Установка (сверка) даты параметризации av_date dd.mm.yyyy hh24:mi:ss
  cn_parammet   CONSTANT NUMBER := 522;
  ld_date                DATE;
  ld_tmp                 DATE;
 BEGIN
  ld_date := TO_DATE (av_date, 'yy-mm-dd hh24:mi:ss');

  SELECT MAX (dparametrization)
    INTO ld_tmp
    FROM last_save
   WHERE mid = an_mid;

  IF NVL (ld_tmp, TO_DATE (190001, 'YYYYMM')) <> ld_date THEN
   UPDATE last_save
      SET dparametrization = ld_date
    WHERE mid = an_mid;

   IF ld_tmp IS NOT NULL THEN   --Изменена дата параметризации генерим тревогу
    admin_pg.ins_journal_p (SYSDATE, an_mid, 0,
                            'Изменение с ''' || TO_CHAR (ld_tmp, 'dd.mm.yyyy hh24:mi:ss') || ''' на ''' || TO_CHAR (ld_date, 'dd.mm.yyyy hh24:mi:ss') || '''',
                            cn_parammet);
   END IF;
  END IF;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error (-20001, 'comsrv_pg.set_parametrization_date: ' || SQLERRM (SQLCODE));
 END;
-----------------------------------------------------------------------------------------------------------------------
END;   -- Package Body comsrv_pg
/


-- End of DDL Script for Package Body RYDA.COMSRV_PG

-- Start of DDL Script for Package Body RYDA.COMSRVCIM_PG
-- Generated 17.07.2012 10:14:22 from RYDA@test2

CREATE OR REPLACE 
PACKAGE BODY comsrvcim_pg IS
------------------------------------------------------------------------------------------------------------------------
   -- Интерфейс взаимодействия БД с Носиком А.В. для прямых select'ов в коде опросчика
   -- дата создания 11/06/2008
------------------------------------------------------------------------------------------------------------------------
--                                       TComServerThread
------------------------------------------------------------------------------------------------------------------------
 FUNCTION connectnextmeter(
 an_mid NUMBER, an_cid NUMBER, ln_mid OUT NUMBER, ln_canal OUT NUMBER, ln_name OUT VARCHAR2, ln_kc OUT NUMBER, ln_tag OUT NUMBER, ln_vinfo OUT VARCHAR2,
 ln_nabc OUT NUMBER, ln_q1234 OUT NUMBER, lv_info_def VARCHAR2, ln_info_len NUMBER, ln_tag_def NUMBER
 )
  RETURN NUMBER IS
 BEGIN
  FOR lc IN (SELECT f.mid, NVL(f.canal, 0) canal, SUBSTR(NVL(p.NAME, 'Без имени'), 1, 31) vname, NVL(f.kc, 1) kc, NVL(p.tag, ln_tag_def) tag,
                    SUBSTR(NVL(TRIM(f.vinfo), lv_info_def), 1, ln_info_len) vinfo, f.nabc, DECODE(f.q1234, '*', 1, 0) q1234
             FROM   points p, feeders f
             WHERE  f.mid = (SELECT MIN(pp.mid)
                             FROM   points pp
                             WHERE  pp.mid > an_mid AND pp.mid IN(SELECT mid
                                                                  FROM   chanpoint
                                                                  WHERE  cid = an_cid AND nskip IS NULL) AND pp.ind = 3) AND f.mid = p.mid(+)) LOOP
   ln_mid := lc.mid;
   ln_canal := lc.canal;
   ln_name := lc.vname;
   ln_kc := lc.kc;
   ln_tag := lc.tag;
   ln_vinfo := lc.vinfo;
   ln_nabc := lc.nabc;
   ln_q1234 := lc.q1234;
   RETURN 1;
  END LOOP;

  RETURN 0;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'COMSRVCIM_PG.connectnextmeter: ' || SQLERRM(SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------

 -- void __fastcall TComServerThread::ConnectNextPassiveDVS(void)
 FUNCTION get_passivedvs(
 an_cid NUMBER, ln_cid OUT NUMBER, ln_addr OUT NUMBER, ln_vname OUT VARCHAR2, ln_protocol_id OUT NUMBER, ln_init_str OUT VARCHAR2, ln_retries OUT NUMBER,
 ln_retries_tout OUT NUMBER, ln_is_block OUT NUMBER, ln_nbilldata OUT NUMBER, ln_nbilldatadepth OUT NUMBER, ln_ncurrdata OUT NUMBER,
 ln_ncurrdatadepth OUT NUMBER, ln_njournal OUT NUMBER, ln_nnetparam OUT NUMBER, ln_vuser OUT VARCHAR2, ln_vnote OUT VARCHAR2, ln_nwait OUT NUMBER
 )
  RETURN NUMBER IS
 BEGIN
  FOR lc IN (SELECT cid, TO_NUMBER(NVL(addr, '1')) addr, SUBSTR(NVL(vname, 'Unnamed channel'), 1, 31) vname, protocol_id,
                    SUBSTR(NVL(init_str, ' '), 1, 63) init_str, NVL(retries, 1) retries, NVL(retries_tout, 0) retries_tout,
                    channels_pg.is_block(cid, blocking) blocking, nbilldata, NVL(nbilldatadepth, -1) nbilldatadepth, ncurrdata,
                    NVL(ncurrdatadepth, -1) ncurrdatadepth, njournal, nnetparam, NVL(vaccuser, ' ') vaccuser, NVL(vnote, ' ') vnote, nwait
             FROM   channels
             WHERE  cid = an_cid) LOOP
   ln_cid := lc.cid;
   ln_addr := lc.addr;
   ln_vname := lc.vname;
   ln_protocol_id := lc.protocol_id;
   ln_init_str := lc.init_str;
   ln_retries := lc.retries;
   ln_retries_tout := lc.retries_tout;
   ln_is_block := lc.blocking;
   ln_nbilldata := lc.nbilldata;
   ln_nbilldatadepth := lc.nbilldatadepth;
   ln_ncurrdata := lc.ncurrdata;
   ln_ncurrdatadepth := lc.ncurrdatadepth;
   ln_njournal := lc.njournal;
   ln_nnetparam := lc.nnetparam;
   ln_vuser := lc.vaccuser;
   ln_vnote := lc.vnote;
   ln_nwait := lc.nwait;
   RETURN 1;
  END LOOP;

  RETURN 0;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'COMSRVCIM_PG.get_PassiveDVS: ' || SQLERRM(SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------

 -- void __fastcall TComServerThread::SaveStateThread(long id_cod, char* str)
 FUNCTION sel_statecod(an_mid NUMBER, ln_state_cod OUT NUMBER)
  RETURN NUMBER IS
 BEGIN
  FOR lc IN (SELECT NVL(state_cod, 100) state_cod
             FROM   last_save
             WHERE  mid = an_mid) LOOP
   ln_state_cod := lc.state_cod;
   RETURN 1;
  END LOOP;

  RETURN 0;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'COMSRVCIM_PG.sel_StateCod: ' || SQLERRM(SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------

 -- void __fastcall TComServerThread::SaveStateThread(long id_cod, char* str)
 PROCEDURE ins_lastsave(an_mid NUMBER, an_state_cod NUMBER, an_state_descr VARCHAR2, an_clock NUMBER) IS
 BEGIN
  editfeeders_pg.ins_last_save(an_mid, an_state_descr, an_state_cod, an_clock);
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'COMSRVCIM_PG.ins_LastSave: ' || SQLERRM(SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------

 -- void __fastcall TComServerThread::SaveStateThread(long id_cod, char* str)
 PROCEDURE upd_lastsave(an_mid NUMBER, an_state_cod NUMBER, an_state_descr VARCHAR2, an_clock NUMBER) IS
 BEGIN
  UPDATE last_save
  SET state_date = SYSDATE,
      state_cod = an_state_cod,
      state_descr = an_state_descr,
      clock = an_clock
  WHERE  mid = an_mid;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'COMSRVCIM_PG.upd_LastSave: ' || SQLERRM(SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------

 -- void __fastcall TComServerThread::SaveStateThread(long id_cod, char* str)
 PROCEDURE ins_journal(an_mid NUMBER, an_state_cod NUMBER, an_state_descr VARCHAR2) IS
 BEGIN
  INSERT INTO journal
              (mid, date_time, state_cod, state_descr, nevent)
  VALUES      (an_mid, SYSDATE, an_state_cod, an_state_descr, comsrvdisp_pg.cn_processmet);
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'COMSRVCIM_PG.ins_Journal: ' || SQLERRM(SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------

 -- void __fastcall TComServerThread::SetLuck(void)
 PROCEDURE upd_lastsaveluck(an_cid NUMBER) IS
 BEGIN
  UPDATE last_save
  SET luck = SYSDATE
  WHERE  mid IN(SELECT     cid
                FROM       channels
                CONNECT BY PRIOR cid = nparent
                START WITH cid = an_cid
                UNION ALL
                SELECT     cid
                FROM       channels
                CONNECT BY PRIOR nparent = cid
                START WITH cid = an_cid);
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'COMSRVCIM_PG.upd_LastSaveLuck: ' || SQLERRM(SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------

 -- void __fastcall TComServerThread::SetLuck(void)
 PROCEDURE upd_channels(an_cid NUMBER) IS
 BEGIN
  UPDATE channels
  SET is_dead = NULL
  WHERE  cid = an_cid;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'COMSRVCIM_PG.upd_Channels: ' || SQLERRM(SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------

 -- void __fastcall TComServerThread::SetLuck(void)
 PROCEDURE upd_lastsavetrial(an_mid NUMBER) IS
 BEGIN
  UPDATE last_save
  SET trial = SYSDATE
  WHERE  mid = an_mid;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'COMSRVCIM_PG.upd_LastSaveTrial: ' || SQLERRM(SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
--                                       TZxB_Thread
------------------------------------------------------------------------------------------------------------------------

 -- bool __fastcall TZxB_Thread::ConnectNextZxB_(void)
 FUNCTION connectnextzxb(
 an_mid NUMBER, an_cid NUMBER, ln_mid OUT NUMBER, ln_canal OUT NUMBER, ln_name OUT VARCHAR2, ln_kc OUT NUMBER, ln_tag OUT NUMBER, ln_vinfo OUT VARCHAR2
 )
  RETURN NUMBER IS
  ln_nabc             NUMBER;
  ln_q1234            NUMBER;
 BEGIN
  RETURN connectnextmeter(an_mid, an_cid, ln_mid, ln_canal, ln_name, ln_kc, ln_tag, ln_vinfo, ln_nabc, ln_q1234);
 END;

------------------------------------------------------------------------------------------------------------------------

 -- bool __fastcall TZxB_Thread::LoadMapLandis(void)
 FUNCTION loadmaplandis(
 an_nusd NUMBER, an_mid OUT common_pg.tt_number, an_er OUT common_pg.tt_number, an_ed OUT common_pg.tt_number, an_q1 OUT common_pg.tt_number,
 an_q3 OUT common_pg.tt_number, an_kc OUT common_pg.tt_number
 )
  RETURN NUMBER IS
  CURSOR temp_cur IS
   SELECT mid, NVL(er_position, 0) er, NVL(ed_position, 0) ed, NVL(q1_position, 0) q1, NVL(q3_position, 0) q3, NVL(kc, 1) nkc
   FROM   feeders
   WHERE  ROWNUM < 17 AND nusd = an_nusd;

  i                   NUMBER DEFAULT 0;
 BEGIN
  FOR temp_cur_rec IN temp_cur LOOP
   --NULL;
   i := i + 1;
   an_mid(i) := temp_cur_rec.mid;
   an_er(i) := temp_cur_rec.er;
   an_ed(i) := temp_cur_rec.ed;
   an_q1(i) := temp_cur_rec.q1;
   an_q3(i) := temp_cur_rec.q3;
   an_kc(i) := temp_cur_rec.nkc;

   IF i >= 16 THEN
    EXIT;
   END IF;
  END LOOP;

  RETURN i;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'COMSRVCIM_PG.loadMapLandis: ' || SQLERRM(SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------

 -- void __fastcall TZxB_Thread::LoadLastSaveDates(void)
 FUNCTION loadlastsavedates(an_mid NUMBER, ln_profile OUT VARCHAR2, ln_halfhour OUT VARCHAR2, ln_bill OUT VARCHAR2, ln_months OUT VARCHAR2)
  RETURN NUMBER IS
 BEGIN
  FOR lc IN (SELECT TO_CHAR(PROFILE, 'dd.mm.yyyy hh24:mi') pf, TO_CHAR(halfhour, 'dd.mm.yyyy hh24:mi') hh, TO_CHAR(bill, 'dd.mm.yyyy hh24:mi') bill,
                    TO_CHAR(months, 'dd.mm.yyyy hh24:mi') months
             FROM   last_save
             WHERE  mid = an_mid) LOOP
   ln_profile := lc.pf;
   ln_halfhour := lc.hh;
   ln_bill := lc.bill;
   ln_months := lc.months;
   RETURN 1;
  END LOOP;

  RETURN 0;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'COMSRVCIM_PG.loadLastSaveDates: ' || SQLERRM(SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
 -- void __fastcall TZxB_Thread::LoadLastSaveDates(void)
 FUNCTION loadlastchangedates(an_mid NUMBER, ln_profile OUT VARCHAR2, ln_halfhour OUT VARCHAR2, ln_bill OUT VARCHAR2, ln_months OUT VARCHAR2)
  RETURN NUMBER IS
 BEGIN
  FOR lc IN (SELECT TO_CHAR(NVL(halfhourchange, TRUNC(SYSDATE) - 45), 'dd.mm.yyyy hh24:mi') halfhourchange
             FROM   last_save
             WHERE  mid = an_mid) LOOP
   ln_profile := lc.halfhourchange;
   ln_halfhour := lc.halfhourchange;
   ln_bill := lc.halfhourchange;
   ln_months := lc.halfhourchange;
   RETURN 1;
  END LOOP;

  RETURN 0;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'COMSRVCIM_PG.loadlastchangedates: ' || SQLERRM(SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
 FUNCTION loadlastsavejournal(an_mid NUMBER, av_journal OUT VARCHAR2)
  RETURN NUMBER IS
 BEGIN
  FOR lc IN (SELECT TO_CHAR(NVL(journal, SYSDATE - 370), 'dd.mm.yyyy hh24:mi') jour
             FROM   last_save
             WHERE  mid = an_mid) LOOP
   av_journal := lc.jour;
   RETURN 1;
  END LOOP;

  RETURN 0;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'COMSRVCIM_PG.loadlastsavejournal: ' || SQLERRM(SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------

 -- void __fastcall TZxB_Thread::LoadLastSaveDates(void)
 PROCEDURE ins_lastsavemeter(an_mid NUMBER, an_clock NUMBER) IS
 BEGIN
  editfeeders_pg.ins_last_save(an_mid, NULL, NULL, an_clock);
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'COMSRVCIM_PG.ins_LastSaveMeter: ' || SQLERRM(SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------

 -- void __fastcall TZxB_Thread::SaveHalfHour(void* tempProfile)
 PROCEDURE upd_lastsavehalfhour(an_mid NUMBER, an_halfhour VARCHAR2) IS
 BEGIN
  UPDATE last_save
  SET halfhour = TO_DATE(an_halfhour, 'dd.mm.yyyy hh24:mi'),
      halfhourchange = SYSDATE
  WHERE  mid = an_mid;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'COMSRVCIM_PG.upd_LastSaveHalfHour: ' || SQLERRM(SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------

 -- void __fastcall TZxB_Thread::SaveCurrentValues(void* tempProfile, stLandis_Net Landis_Net)
 PROCEDURE upd_lastsaveprofile(an_mid NUMBER, an_clock NUMBER, an_profile VARCHAR2) IS
 BEGIN
  UPDATE last_save
  SET PROFILE = TO_DATE(an_profile, 'dd.mm.yyyy hh24:mi'),
      clock = an_clock
  WHERE  mid = an_mid;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'COMSRVCIM_PG.upd_LastSaveProfile: ' || SQLERRM(SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------

 -- void __fastcall TZxB_Thread::SaveDayData(void* tempProfile)
 PROCEDURE upd_lastsavebill(an_mid NUMBER, an_bill VARCHAR2) IS
  ld_date             DATE;
 BEGIN
  ld_date := TO_DATE(an_bill, 'dd.mm.yyyy hh24:mi');

  IF util_pg.get_customer_id = 45 THEN                                                                                        --Чтоб читать недоучеты постоянно
   ld_date := LEAST(TRUNC(SYSDATE) - 1, ld_date);
  END IF;

  UPDATE last_save
  SET bill = ld_date
  WHERE  mid = an_mid;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'COMSRVCIM_PG.upd_LastSaveBill: ' || SQLERRM(SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------

 -- void __fastcall TZxB_Thread::SaveMonthData(void* tempProfile)
 PROCEDURE upd_lastsavemonths(an_mid NUMBER, an_months VARCHAR2) IS
 BEGIN
  UPDATE last_save
  SET months = TO_DATE(an_months, 'dd.mm.yyyy hh24:mi')
  WHERE  mid = an_mid;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'COMSRVCIM_PG.upd_LastSaveMonths: ' || SQLERRM(SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
--                                       TOblikThread
------------------------------------------------------------------------------------------------------------------------

 -- void __fastcall TOblikThread::LoadYearDay(void)
 FUNCTION sel_metering(ln_metering OUT NUMBER)
  RETURN NUMBER IS
 BEGIN
  SELECT DECODE(MAX(metering), '*', 1, 0)
  INTO   ln_metering
  FROM   cs_profile;

  RETURN 1;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'COMSRVCIM_PG.sel_Metering: ' || SQLERRM(SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------

 -- bool __fastcall TOblikThread::ConnectNextOblik(void)
 FUNCTION connectnextoblik(an_mid NUMBER, an_cid NUMBER, ln_mid OUT NUMBER, ln_canal OUT NUMBER, ln_name OUT VARCHAR2, ln_kc OUT NUMBER, ln_tag OUT NUMBER)
  RETURN NUMBER IS
  lv_info             VARCHAR2(2000);
 BEGIN
  RETURN connectnextoblik(an_mid, an_cid, ln_mid, ln_canal, ln_name, ln_kc, ln_tag, lv_info);
 END;

------------------------------------------------------------------------------------------------------------------------
 FUNCTION connectnextoblik(
 an_mid NUMBER, an_cid NUMBER, ln_mid OUT NUMBER, ln_canal OUT NUMBER, ln_name OUT VARCHAR2, ln_kc OUT NUMBER, ln_tag OUT NUMBER, ln_vinfo OUT VARCHAR2
 )
  RETURN NUMBER IS
  ln_nabc             NUMBER;
  ln_q1234            NUMBER;
 BEGIN
  RETURN connectnextmeter(an_mid, an_cid, ln_mid, ln_canal, ln_name, ln_kc, ln_tag, ln_vinfo, ln_nabc, ln_q1234, ' ', 16);
 END;

------------------------------------------------------------------------------------------------------------------------
 -- bool __fastcall TOblikThread::LoadMapOblik(void)
 FUNCTION loadmapoblik(
 an_nusd NUMBER, an_mid OUT common_pg.tt_number, an_er OUT common_pg.tt_number, an_ed OUT common_pg.tt_number, an_q1 OUT common_pg.tt_number,
 an_q3 OUT common_pg.tt_number, an_kc OUT common_pg.tt_number
 )
  RETURN NUMBER IS
  CURSOR temp_cur IS
   SELECT mid, NVL(er_position, 0) er, NVL(ed_position, 0) ed, NVL(q1_position, 0) q1, NVL(q3_position, 0) q3, NVL(kc, 1) nkc
   FROM   feeders
   WHERE  ROWNUM < 9 AND nusd = an_nusd;

  i                   NUMBER DEFAULT 0;
 BEGIN
  FOR temp_cur_rec IN temp_cur LOOP
   --NULL;
   i := i + 1;
   an_mid(i) := temp_cur_rec.mid;
   an_er(i) := temp_cur_rec.er;
   an_ed(i) := temp_cur_rec.ed;
   an_q1(i) := temp_cur_rec.q1;
   an_q3(i) := temp_cur_rec.q3;
   an_kc(i) := temp_cur_rec.nkc;

   IF i >= 8 THEN
    EXIT;
   END IF;
  END LOOP;

  RETURN i;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'COMSRVCIM_PG.loadMapOblik: ' || SQLERRM(SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
--                                       TItekThread
------------------------------------------------------------------------------------------------------------------------

 -- bool __fastcall TItekThread::LoadMapItek(void)
 FUNCTION loadmapitek(
 an_cid NUMBER, an_mid OUT common_pg.tt_number, an_er OUT common_pg.tt_number, an_ed OUT common_pg.tt_number, an_q1 OUT common_pg.tt_number,
 an_q3 OUT common_pg.tt_number
 )
  RETURN NUMBER IS
  CURSOR temp_cur IS
   SELECT NVL(ov_mid, mid) mid, NVL(er_position, 0) er, NVL(ed_position, 0) ed, NVL(q1_position, 0) q1, NVL(q3_position, 0) q3
   FROM   feeders
   WHERE  ROWNUM < 97 AND mid IN(SELECT mid
                                 FROM   chanpoint
                                 WHERE  cid = an_cid);

  i                   NUMBER DEFAULT 0;
 BEGIN
  FOR temp_cur_rec IN temp_cur LOOP
   --NULL;
   i := i + 1;
   an_mid(i) := temp_cur_rec.mid;
   an_er(i) := temp_cur_rec.er;
   an_ed(i) := temp_cur_rec.ed;
   an_q1(i) := temp_cur_rec.q1;
   an_q3(i) := temp_cur_rec.q3;

   IF i >= 96 THEN
    EXIT;
   END IF;
  END LOOP;

  RETURN i;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'COMSRVCIM_PG.LoadMapItek: ' || SQLERRM(SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------

 -- void __fastcall TItekThread::SaveProfile(float *tempProfile)
 PROCEDURE upd_lastsaveprofileitek(an_cid NUMBER, an_clock NUMBER, an_profile VARCHAR2) IS
 BEGIN
  UPDATE last_save
  SET PROFILE = TO_DATE(an_profile, 'dd.mm.yyyy hh24:mi'),
      clock = an_clock
  WHERE  mid IN(SELECT     cid
                FROM       channels
                CONNECT BY PRIOR cid = nparent
                START WITH cid = an_cid
                UNION
                SELECT     cid
                FROM       channels
                CONNECT BY PRIOR nparent = cid
                START WITH cid = an_cid);
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'COMSRVCIM_PG.upd_LastSaveProfileItek: ' || SQLERRM(SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------

 -- void __fastcall TItekThread::SaveHalfHour(float *tempProfile)
 PROCEDURE upd_lastsavehalfhouritek(an_cid NUMBER, an_halfhour VARCHAR2) IS
 BEGIN
  UPDATE last_save
  SET halfhour = TO_DATE(an_halfhour, 'dd.mm.yyyy hh24:mi')
  WHERE  mid IN(SELECT     cid
                FROM       channels
                CONNECT BY PRIOR cid = nparent
                START WITH cid = an_cid
                UNION
                SELECT     cid
                FROM       channels
                CONNECT BY PRIOR nparent = cid
                START WITH cid = an_cid);
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'COMSRVCIM_PG.upd_LastSaveHalfHourItek: ' || SQLERRM(SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------

 -- void __fastcall TItekThread::UpdateLastSaveDay(void)
 PROCEDURE upd_lastsavebillitek(an_cid NUMBER, an_bill VARCHAR2) IS
 BEGIN
  UPDATE last_save
  SET bill = TO_DATE(an_bill, 'dd.mm.yyyy hh24:mi')
  WHERE  mid IN(SELECT     cid
                FROM       channels
                CONNECT BY PRIOR cid = nparent
                START WITH cid = an_cid
                UNION
                SELECT     cid
                FROM       channels
                CONNECT BY PRIOR nparent = cid
                START WITH cid = an_cid);
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'COMSRVCIM_PG.upd_LastSaveBillItek: ' || SQLERRM(SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------

 -- void __fastcall TItekThread::UpdateLastSaveMonth(void)
 PROCEDURE upd_lastsavemonthsitek(an_cid NUMBER, an_months VARCHAR2) IS
 BEGIN
  UPDATE last_save
  SET months = TO_DATE(an_months, 'dd.mm.yyyy hh24:mi')
  WHERE  mid IN(SELECT     cid
                FROM       channels
                CONNECT BY PRIOR cid = nparent
                START WITH cid = an_cid
                UNION
                SELECT     cid
                FROM       channels
                CONNECT BY PRIOR nparent = cid
                START WITH cid = an_cid);
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'COMSRVCIM_PG.upd_LastSaveMonthsItek: ' || SQLERRM(SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
--                                       TCT5000_Thread
------------------------------------------------------------------------------------------------------------------------

 -- bool __fastcall TCT5000_Thread::LoadMapItek(void)
 FUNCTION loadmapct5000(
 an_cid NUMBER, an_mid OUT common_pg.tt_number, an_er OUT common_pg.tt_number, an_ed OUT common_pg.tt_number, an_q1 OUT common_pg.tt_number,
 an_q3 OUT common_pg.tt_number
 )
  RETURN NUMBER IS
  CURSOR temp_cur IS
   SELECT NVL(ov_mid, mid) mid, NVL(er_position, 0) er, NVL(ed_position, 0) ed, NVL(q1_position, 0) q1, NVL(q3_position, 0) q3
   FROM   feeders
   WHERE  ROWNUM < 65 AND mid IN(SELECT mid
                                 FROM   chanpoint
                                 WHERE  cid = an_cid);

  i                   NUMBER DEFAULT 0;
 BEGIN
  FOR temp_cur_rec IN temp_cur LOOP
   --NULL;
   i := i + 1;
   an_mid(i) := temp_cur_rec.mid;
   an_er(i) := temp_cur_rec.er;
   an_ed(i) := temp_cur_rec.ed;
   an_q1(i) := temp_cur_rec.q1;
   an_q3(i) := temp_cur_rec.q3;

   IF i >= 64 THEN
    EXIT;
   END IF;
  END LOOP;

  RETURN i;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'COMSRVCIM_PG.loadMapCT5000: ' || SQLERRM(SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
--                                       TA1R_Thread
------------------------------------------------------------------------------------------------------------------------

 -- bool __fastcall TA1R_Thread::ConnectNextA1R_(void)
 FUNCTION connectnexta1r(an_mid NUMBER, an_cid NUMBER, ln_mid OUT NUMBER, ln_canal OUT NUMBER, ln_name OUT VARCHAR2, ln_kc OUT NUMBER, ln_tag OUT NUMBER)
  RETURN NUMBER IS
  ln_vinfo            VARCHAR2(128);
  ln_nabc             NUMBER;
  ln_q1234            NUMBER;
 BEGIN
  RETURN connectnextmeter(an_mid, an_cid, ln_mid, ln_canal, ln_name, ln_kc, ln_tag, ln_vinfo, ln_nabc, ln_q1234);
 END;

------------------------------------------------------------------------------------------------------------------------
--                                       TAlphaThread
------------------------------------------------------------------------------------------------------------------------

 -- bool __fastcall TAlphaThread::ConnectNextAlpha(void)
 FUNCTION connectnextalpha(
 an_mid NUMBER, an_cid NUMBER, ln_mid OUT NUMBER, ln_canal OUT NUMBER, ln_name OUT VARCHAR2, ln_kc OUT NUMBER, ln_tag OUT NUMBER, ln_nabc OUT NUMBER
 )
  RETURN NUMBER IS
  ln_vinfo            VARCHAR2(128);
  ln_q1234            NUMBER;
 BEGIN
  RETURN connectnextmeter(an_mid, an_cid, ln_mid, ln_canal, ln_name, ln_kc, ln_tag, ln_vinfo, ln_nabc, ln_q1234);
 END;

------------------------------------------------------------------------------------------------------------------------
--                                       TEnergyThread
------------------------------------------------------------------------------------------------------------------------

 -- bool __fastcall TEnergyThread::ConnectNextEnergy(void)
 FUNCTION connectnextenergy(
 an_mid NUMBER, an_cid NUMBER, ln_mid OUT NUMBER, ln_canal OUT NUMBER, ln_name OUT VARCHAR2, ln_kc OUT NUMBER, ln_tag OUT NUMBER, ln_nabc OUT NUMBER,
 ln_vinfo OUT VARCHAR2
 )
  RETURN NUMBER IS
  ln_q1234            NUMBER;
 BEGIN
  RETURN connectnextmeter(an_mid, an_cid, ln_mid, ln_canal, ln_name, ln_kc, ln_tag, ln_vinfo, ln_nabc, ln_q1234, '0', 15);
 END;

------------------------------------------------------------------------------------------------------------------------
--                                       TRTU_Thread
------------------------------------------------------------------------------------------------------------------------

 -- bool __fastcall TRTU_Thread::ConnectNextPoint()
 FUNCTION connectnextrtu(an_mid NUMBER, an_cid NUMBER, ln_mid OUT NUMBER, ln_canal OUT NUMBER, ln_name OUT VARCHAR2, ln_kc OUT NUMBER, ln_tag OUT NUMBER)
  RETURN NUMBER IS
  ln_vinfo            VARCHAR2(128);
  ln_nabc             NUMBER;
  ln_q1234            NUMBER;
 BEGIN
  RETURN connectnextmeter(an_mid, an_cid, ln_mid, ln_canal, ln_name, ln_kc, ln_tag, ln_vinfo, ln_nabc, ln_q1234, cv_info_def, cn_info_len, 12);
 END;

------------------------------------------------------------------------------------------------------------------------
--                                       TArgoThread
------------------------------------------------------------------------------------------------------------------------

 -- bool __fastcall TArgoThread::ConnectNextArgo(void)
 FUNCTION connectnextargo(an_mid NUMBER, an_cid NUMBER, ln_mid OUT NUMBER, ln_canal OUT NUMBER, ln_name OUT VARCHAR2, ln_kc OUT NUMBER, ln_tag OUT NUMBER)
  RETURN NUMBER IS
  ln_vinfo            VARCHAR2(128);
  ln_nabc             NUMBER;
  ln_q1234            NUMBER;
 BEGIN
  RETURN connectnextmeter(an_mid, an_cid, ln_mid, ln_canal, ln_name, ln_kc, ln_tag, ln_vinfo, ln_nabc, ln_q1234);
 END;

------------------------------------------------------------------------------------------------------------------------
--                                       TElvinThread
------------------------------------------------------------------------------------------------------------------------

 -- bool __fastcall TElvinThread::ConnectNextElvin(void)
 FUNCTION connectnextelvin(
 an_mid NUMBER, an_cid NUMBER, ln_mid OUT NUMBER, ln_canal OUT NUMBER, ln_name OUT VARCHAR2, ln_kc OUT NUMBER, ln_tag OUT NUMBER, ln_vinfo OUT VARCHAR2
 )
  RETURN NUMBER IS
  ln_nabc             NUMBER;
  ln_q1234            NUMBER;
 BEGIN
  RETURN connectnextmeter(an_mid, an_cid, ln_mid, ln_canal, ln_name, ln_kc, ln_tag, ln_vinfo, ln_nabc, ln_q1234);
 END;

------------------------------------------------------------------------------------------------------------------------
--                                       TSL_DlmsThread
------------------------------------------------------------------------------------------------------------------------

 -- bool __fastcall TSL_DlmsThread::ConnectNextSL_Dlms(void)
 FUNCTION connectnextsl_dlms(
 an_mid NUMBER, an_cid NUMBER, ln_mid OUT NUMBER, ln_canal OUT NUMBER, ln_name OUT VARCHAR2, ln_kc OUT NUMBER, ln_tag OUT NUMBER, ln_vinfo OUT VARCHAR2
 )
  RETURN NUMBER IS
  ln_nabc             NUMBER;
  ln_q1234            NUMBER;
 BEGIN
  RETURN connectnextmeter(an_mid, an_cid, ln_mid, ln_canal, ln_name, ln_kc, ln_tag, ln_vinfo, ln_nabc, ln_q1234, 'ABCDEFGH', 31);
 END;

------------------------------------------------------------------------------------------------------------------------
 FUNCTION connectnextmtxdlms_dlms(
 an_mid NUMBER, an_cid NUMBER, ln_mid OUT NUMBER, ln_canal OUT NUMBER, ln_name OUT VARCHAR2, ln_kc OUT NUMBER, ln_tag OUT NUMBER, ln_vinfo OUT VARCHAR2
 )
  RETURN NUMBER IS
  ln_nabc             NUMBER;
  ln_q1234            NUMBER;
 BEGIN
  RETURN connectnextmeter(an_mid, an_cid, ln_mid, ln_canal, ln_name, ln_kc, ln_tag, ln_vinfo, ln_nabc, ln_q1234, 'ABCDEFGH', 31);
 END;

------------------------------------------------------------------------------------------------------------------------
--                                       TZxD_DlmsThread
------------------------------------------------------------------------------------------------------------------------

 -- bool __fastcall TZxD_DlmsThread::ConnectNextZxD_Dlms(void)
 FUNCTION connectnextzxd_dlms(
 an_mid NUMBER, an_cid NUMBER, ln_mid OUT NUMBER, ln_canal OUT NUMBER, ln_name OUT VARCHAR2, ln_kc OUT NUMBER, ln_tag OUT NUMBER, ln_vinfo OUT VARCHAR2
 )
  RETURN NUMBER IS
  ln_nabc             NUMBER;
  ln_q1234            NUMBER;
 BEGIN
  RETURN connectnextmeter(an_mid, an_cid, ln_mid, ln_canal, ln_name, ln_kc, ln_tag, ln_vinfo, ln_nabc, ln_q1234, 'ZxD_dlms');
 END;

------------------------------------------------------------------------------------------------------------------------
--                                       TUSPD_ChanThread
------------------------------------------------------------------------------------------------------------------------

 -- bool __fastcall TUSPD_ChanThread::ConnectNextUspdChan(void)
 FUNCTION connectnextuspdchan(an_mid NUMBER, an_cid NUMBER, ln_mid OUT NUMBER, ln_canal OUT NUMBER, ln_name OUT VARCHAR2, ln_kc OUT NUMBER, ln_tag OUT NUMBER)
  RETURN NUMBER IS
  ln_vinfo            VARCHAR2(128);
  ln_nabc             NUMBER;
  ln_q1234            NUMBER;
 BEGIN
  RETURN connectnextmeter(an_mid, an_cid, ln_mid, ln_canal, ln_name, ln_kc, ln_tag, ln_vinfo, ln_nabc, ln_q1234, 'ZxD_dlms');
 END;

------------------------------------------------------------------------------------------------------------------------

 -- void __fastcall TUSPD_ChanThread::SaveDiffTimeUSD(void)
 PROCEDURE upd_lastsaveclock(an_mid NUMBER, an_clock NUMBER) IS
 BEGIN
  UPDATE last_save
  SET clock = an_clock
  WHERE  mid = an_mid;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'COMSRVCIM_PG.upd_LastSaveClock: ' || SQLERRM(SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------

 -- void __fastcall TUSPD_ChanThread::LoadChannelStatus(void)
 PROCEDURE upd_lastsavestate(an_mid NUMBER, an_clock NUMBER, an_state_cod NUMBER, an_state_date VARCHAR2) IS
 BEGIN
  UPDATE last_save
  SET state_date = TO_DATE(an_state_date, 'dd.mm.yyyy hh24:mi'),
      clock = an_clock,
      state_cod = an_state_cod,
      state_descr = comsrverr_pg.errortext(an_state_cod, comsrv_pg.cn_uspd_64)
  WHERE  mid = an_mid;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'COMSRVCIM_PG.upd_LastSaveState: ' || SQLERRM(SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------

 -- void __fastcall TUSPD_ChanThread::LoadCurrentValues(void)
 PROCEDURE upd_lastsaveprofile(an_mid NUMBER, an_profile VARCHAR2) IS
 BEGIN
  UPDATE last_save
  SET PROFILE = TO_DATE(an_profile, 'dd.mm.yyyy hh24:mi')
  WHERE  mid = an_mid;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'COMSRVCIM_PG.upd_LastSaveProfile2: ' || SQLERRM(SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
--                                       TSET4_Thread
------------------------------------------------------------------------------------------------------------------------

 -- bool __fastcall TSET4_Thread::ConnectNextSET4_(void)
 FUNCTION connectnextset4(
 an_mid NUMBER, an_cid NUMBER, ln_mid OUT NUMBER, ln_canal OUT NUMBER, ln_name OUT VARCHAR2, ln_kc OUT NUMBER, ln_tag OUT NUMBER, ln_nabc OUT NUMBER
 )
  RETURN NUMBER IS
  ln_vinfo            VARCHAR2(128);
  ln_q1234            NUMBER;
 BEGIN
  RETURN connectnextmeter(an_mid, an_cid, ln_mid, ln_canal, ln_name, ln_kc, ln_tag, ln_vinfo, ln_nabc, ln_q1234);
 END;

------------------------------------------------------------------------------------------------------------------------
--                                       TMercuryThread
------------------------------------------------------------------------------------------------------------------------

 -- bool __fastcall TMercuryThread::ConnectNextMercury(void)
 FUNCTION connectnextmercury(
 an_mid NUMBER, an_cid NUMBER, ln_mid OUT NUMBER, ln_canal OUT NUMBER, ln_name OUT VARCHAR2, ln_kc OUT NUMBER, ln_tag OUT NUMBER, ln_nabc OUT NUMBER
 )
  RETURN NUMBER IS
  ln_vinfo            VARCHAR2(128);
  ln_q1234            NUMBER;
 BEGIN
  RETURN connectnextmeter(an_mid, an_cid, ln_mid, ln_canal, ln_name, ln_kc, ln_tag, ln_vinfo, ln_nabc, ln_q1234);
 END;

 ------------------------------------------------------------------------------------------------------------------------
--                                       TLzqmThread
------------------------------------------------------------------------------------------------------------------------

 -- bool __fastcall TLzqmThread::ConnectNextLzqm(void)
 FUNCTION connectnextlzqm(
 an_mid NUMBER, an_cid NUMBER, ln_mid OUT NUMBER, ln_canal OUT NUMBER, ln_name OUT VARCHAR2, ln_kc OUT NUMBER, ln_tag OUT NUMBER, ln_nabc OUT NUMBER
 )
  RETURN NUMBER IS
  ln_vinfo            VARCHAR2(128);
  ln_q1234            NUMBER;
 BEGIN
  RETURN connectnextmeter(an_mid, an_cid, ln_mid, ln_canal, ln_name, ln_kc, ln_tag, ln_vinfo, ln_nabc, ln_q1234);
 END;

------------------------------------------------------------------------------------------------------------------------
--                                       TCE304_Thread
------------------------------------------------------------------------------------------------------------------------

 -- bool __fastcall TCE304_Thread::ConnectNextCE304(void)
 FUNCTION connectnextce304(
 an_mid NUMBER, an_cid NUMBER, ln_mid OUT NUMBER, ln_canal OUT NUMBER, ln_name OUT VARCHAR2, ln_kc OUT NUMBER, ln_tag OUT NUMBER, ln_vinfo OUT VARCHAR2
 )
  RETURN NUMBER IS
  ln_nabc             NUMBER;
  ln_q1234            NUMBER;
 BEGIN
  RETURN connectnextmeter(an_mid, an_cid, ln_mid, ln_canal, ln_name, ln_kc, ln_tag, ln_vinfo, ln_nabc, ln_q1234);
 END;

------------------------------------------------------------------------------------------------------------------------
--                                       TSatecThread
------------------------------------------------------------------------------------------------------------------------

 -- bool __fastcall TSatecThread::ConnectNextSatec(void)
 FUNCTION connectnextsatec(
 an_mid NUMBER, an_cid NUMBER, ln_mid OUT NUMBER, ln_canal OUT NUMBER, ln_name OUT VARCHAR2, ln_kc OUT NUMBER, ln_tag OUT NUMBER, ln_vinfo OUT VARCHAR2
 )
  RETURN NUMBER IS
  ln_nabc             NUMBER;
  ln_q1234            NUMBER;
 BEGIN
  RETURN connectnextmeter(an_mid, an_cid, ln_mid, ln_canal, ln_name, ln_kc, ln_tag, ln_vinfo, ln_nabc, ln_q1234, 'Satec');
 END;

------------------------------------------------------------------------------------------------------------------------
--                                       TDllMeterThread
------------------------------------------------------------------------------------------------------------------------

 -- bool __fastcall TDllMeterThread::Get_DLL_Name(void)
 FUNCTION get_dll_name(an_protocol NUMBER, ln_name OUT VARCHAR2)
  RETURN NUMBER IS
 BEGIN
  SELECT NVL(dll_name, ' ')
  INTO   ln_name
  FROM   protocols
  WHERE  protocol_id = an_protocol;

  RETURN 1;
 EXCEPTION
  WHEN NO_DATA_FOUND THEN
   RETURN 0;
  WHEN OTHERS THEN
   raise_application_error(-20001, 'COMSRVCIM_PG.get_DLL_Name: ' || SQLERRM(SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------

 -- bool __fastcall TDllMeterThread::ConnectNextDllMeter(void)
 FUNCTION connectnextdllmeter(
 an_mid NUMBER, an_cid NUMBER, ln_mid OUT NUMBER, ln_canal OUT NUMBER, ln_name OUT VARCHAR2, ln_kc OUT NUMBER, ln_tag OUT NUMBER, ln_nabc OUT NUMBER,
 ln_q1234 OUT NUMBER, ln_vinfo OUT VARCHAR2
 )
  RETURN NUMBER IS
 BEGIN
  RETURN connectnextmeter(an_mid, an_cid, ln_mid, ln_canal, ln_name, ln_kc, ln_tag, ln_vinfo, ln_nabc, ln_q1234, cv_info_def, 127);
 END;

------------------------------------------------------------------------------------------------------------------------
--                                       TA1800Thread
------------------------------------------------------------------------------------------------------------------------

 -- bool __fastcall TA1800Thread::ConnectNextAlpha(void)
 FUNCTION connectnexta1800(
 an_mid NUMBER, an_cid NUMBER, ln_mid OUT NUMBER, ln_canal OUT NUMBER, ln_name OUT VARCHAR2, ln_kc OUT NUMBER, ln_tag OUT NUMBER, ln_vinfo OUT VARCHAR2
 )
  RETURN NUMBER IS
  ln_nabc             NUMBER;
  ln_q1234            NUMBER;
 BEGIN
  RETURN connectnextmeter(an_mid, an_cid, ln_mid, ln_canal, ln_name, ln_kc, ln_tag, ln_vinfo, ln_nabc, ln_q1234, '00000000', 31);
 END;

------------------------------------------------------------------------------------------------------------------------
--                                       TFile_Thread
------------------------------------------------------------------------------------------------------------------------

 -- AnsiString __fastcall TFile_Thread::GetLastFileName(int aFileType)
 FUNCTION getlastfilename1(an_mid NUMBER, ln_name OUT VARCHAR2)
  RETURN NUMBER IS
 BEGIN
  FOR lc IN (SELECT NVL(TO_CHAR(halfhour, 'yymmdd'), '000000') || NVL(SUBSTR(TO_CHAR(PROFILE, 'j'), 6, 2), '00') || '.hhh' a
             FROM   last_save
             WHERE  mid = an_mid) LOOP
   ln_name := lc.a;
   RETURN 1;
  END LOOP;

  RETURN 0;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'COMSRVCIM_PG.getLastFileName1: ' || SQLERRM(SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
 FUNCTION getlastfilename2(an_mid NUMBER, ln_name OUT VARCHAR2)
  RETURN NUMBER IS
 BEGIN
  FOR lc IN (SELECT NVL(TO_CHAR(bill, 'yymmdd'), '000000') || NVL(SUBSTR(TO_CHAR(PROFILE, 'j'), 4, 2), '00') || '.ddd' a
             FROM   last_save
             WHERE  mid = an_mid) LOOP
   ln_name := lc.a;
   RETURN 1;
  END LOOP;

  RETURN 0;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'COMSRVCIM_PG.getLastFileName2: ' || SQLERRM(SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
 FUNCTION getlastfilename3(an_mid NUMBER, ln_name OUT VARCHAR2)
  RETURN NUMBER IS
 BEGIN
  FOR lc IN (SELECT NVL(TO_CHAR(months, 'yymmdd'), '000000') || NVL(SUBSTR(TO_CHAR(PROFILE, 'j'), 2, 2), '00') || '.mmm' a
             FROM   last_save
             WHERE  mid = an_mid) LOOP
   ln_name := lc.a;
   RETURN 1;
  END LOOP;

  RETURN 0;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'COMSRVCIM_PG.getLastFileName3: ' || SQLERRM(SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------

 -- bool __fastcall TFile_Thread::CheckFileExists(AnsiString aFileName)
 FUNCTION checkfileexists(an_count OUT NUMBER, ln_name VARCHAR2)
  RETURN NUMBER IS
 BEGIN
  SELECT COUNT(*) c
  INTO   an_count
  FROM   copyfiles
  WHERE  vfilename = ln_name;

  RETURN 1;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'COMSRVCIM_PG.checkFileExists: ' || SQLERRM(SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------

 -- AnsiString __fastcall TFile_Thread::GetLastFileName(int aFileType)
 PROCEDURE ins_lastsavemeter(an_mid NUMBER) IS
 BEGIN
  editfeeders_pg.ins_last_save(an_mid);
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'COMSRVCIM_PG.ins_LastSaveMeter-2: ' || SQLERRM(SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------

 -- void __fastcall TFile_Thread::SetLastFileName(AnsiString aFileName)
 PROCEDURE upd_lastfilename1(an_mid NUMBER, an_date VARCHAR2, an_file VARCHAR2) IS
 BEGIN
  UPDATE last_save
  SET PROFILE = (SELECT TO_DATE(an_file || NVL(SUBSTR(TO_CHAR(PROFILE, 'j'), 4, 2), '00') || NVL(SUBSTR(TO_CHAR(PROFILE, 'j'), 6, 2), '00'), 'j')
                 FROM   last_save
                 WHERE  mid = an_mid),
      halfhour = TO_DATE(an_date, 'yymmdd')
  WHERE  mid = an_mid;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'COMSRVCIM_PG.upd_LastFileName1: ' || SQLERRM(SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
 PROCEDURE upd_lastfilename2(an_mid NUMBER, an_date VARCHAR2, an_file VARCHAR2) IS
 BEGIN
  UPDATE last_save
  SET PROFILE = (SELECT TO_DATE(NVL(SUBSTR(TO_CHAR(PROFILE, 'j'), 1, 3), '000') || an_file || NVL(SUBSTR(TO_CHAR(PROFILE, 'j'), 6, 2), '00'), 'j')
                 FROM   last_save
                 WHERE  mid = an_mid),
      bill = TO_DATE(an_date, 'yymmdd')
  WHERE  mid = an_mid;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'COMSRVCIM_PG.upd_LastFileName2: ' || SQLERRM(SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
 PROCEDURE upd_lastfilename3(an_mid NUMBER, an_date VARCHAR2, an_file VARCHAR2) IS
 BEGIN
  UPDATE last_save
  SET PROFILE = (SELECT TO_DATE(NVL(SUBSTR(TO_CHAR(PROFILE, 'j'), 1, 3), '000') || NVL(SUBSTR(TO_CHAR(PROFILE, 'j'), 4, 2), '00') || an_file, 'j')
                 FROM   last_save
                 WHERE  mid = an_mid),
      months = TO_DATE(an_date, 'yymmdd')
  WHERE  mid = an_mid;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'COMSRVCIM_PG.upd_LastFileName3: ' || SQLERRM(SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
 --чтение даты последней коррекции времени сетчика  в формате dd.mm.yyyy hh24:mi:ss
 FUNCTION get_metercorrect(an_mid NUMBER)
  RETURN VARCHAR2 IS
  lv_ret              VARCHAR2(32);
 BEGIN
  SELECT TO_CHAR(MAX(dmetercorrect), 'dd.mm.yyyy hh24:mi:ss')
  INTO   lv_ret
  FROM   last_save
  WHERE  mid = an_mid;

  RETURN lv_ret;
 END;

------------------------------------------------------------------------------------------------------------------------
 --установка даты последней коррекции времени сетчика в формате dd.mm.yyyy hh24:mi:ss
 PROCEDURE set_metercorrect(an_mid NUMBER, av_datetime VARCHAR2) IS
  ld_date             DATE := TO_DATE(av_datetime, 'dd.mm.yyyy hh24:mi:ss');
 BEGIN
  UPDATE last_save
  SET dmetercorrect = ld_date
  WHERE  mid = an_mid;

  IF SQL%ROWCOUNT = 0 THEN
   ins_lastsavemeter(an_mid);
  END IF;

  UPDATE last_save
  SET dmetercorrect = ld_date
  WHERE  mid = an_mid;
 END;
------------------------------------------------------------------------------------------------------------------------
END;                                                                                                                                -- Package Body COMSRVCIM_PG
/


-- End of DDL Script for Package Body RYDA.COMSRVCIM_PG

-- Start of DDL Script for Package Body RYDA.COMSRVMTX_PG
-- Generated 17.07.2012 10:14:26 from RYDA@test2

CREATE OR REPLACE 
PACKAGE BODY comsrvmtx_pg IS
------------------------------------------------------------------------------------------------------------------------
 cn_mtxport CONSTANT NUMBER := 127;

------------------------------------------------------------------------------------------------------------------------
   -- Интерфейс взаимодействия БД с драйвером МТХ
   -- дата создания 02/04/2012
------------------------------------------------------------------------------------------------------------------------
 FUNCTION connectnextmeter(
 an_mid NUMBER, an_cid NUMBER, an_retmid OUT NUMBER, ln_canal OUT NUMBER, lv_name OUT VARCHAR2, ln_kc OUT NUMBER, ln_tag OUT NUMBER, lv_info OUT VARCHAR2
 )
  RETURN NUMBER IS
  ln_nabc             NUMBER;
  ln_q1234            NUMBER;
  ln_ret              NUMBER;
 BEGIN
  ln_ret := comsrvcim_pg.connectnextmeter(an_mid, an_cid, an_retmid, ln_canal, lv_name, ln_kc, ln_tag, lv_info, ln_nabc, ln_q1234);

  IF ln_ret > 0 AND an_retmid > 0 THEN
   editfeeders_pg.ins_last_save(an_retmid);
   COMMIT;
  END IF;

  RETURN ln_ret;
 END;

------------------------------------------------------------------------------------------------------------------------
    --Вставка текущих
 PROCEDURE set_curr_power(
 an_mid NUMBER, an_erm NUMBER, an_q1m NUMBER, an_q3m NUMBER, an_freq NUMBER, an_temp NUMBER, an_volt1 NUMBER, an_volt2 NUMBER, an_volt3 NUMBER, an_curr1 NUMBER,
 an_curr2 NUMBER, an_curr3 NUMBER, an_cosf NUMBER, ad_date DATE
 ) IS
  ln_type             NUMBER DEFAULT 0;
 BEGIN
  SAVEPOINT set_curr_power_sp;
  comsrv_pg.set_curr_power_meter(an_mid, an_erm, 0, an_q1m, an_q3m, NULL, NULL, an_freq, an_cosf, an_volt1, an_volt2, an_volt3, an_curr1, an_curr2, an_curr3,
   NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, ad_date);
  comsrvcim_pg.upd_lastsaveprofile(an_mid, TO_CHAR(ad_date, 'dd.mm.yyyy hh24:mi'));
 EXCEPTION
  WHEN OTHERS THEN
   ROLLBACK TO SAVEPOINT set_curr_power_sp;
   raise_application_error(-20001, 'COMSRVMTX_PG.set_curr_power: ' || SQLERRM(SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
 --Вставка графика нагрузки
 PROCEDURE set_halfhour(an_mid NUMBER, an_er NUMBER, ad_date DATE) IS
 BEGIN
  SAVEPOINT set_halfhour_sp;
  comsrv_pg.set_halfhour_meter(an_mid, an_er, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, comsrv_pg.cn_mtx, NULL, ad_date);
  comsrvcim_pg.upd_lastsavehalfhour(an_mid, TO_CHAR(ad_date, 'dd.mm.yyyy hh24:mi'));
 EXCEPTION
  WHEN OTHERS THEN
   ROLLBACK TO SAVEPOINT set_halfhour_sp;
   raise_application_error(-20001, 'COMSRVMTX_PG.set_halfhour: ' || SQLERRM(SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
    --Вставка суточных расходов
 PROCEDURE set_bill(
 an_mid NUMBER, an_er NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_aer NUMBER, an_aq1 NUMBER, an_aq3 NUMBER, an_ber NUMBER, an_bq1 NUMBER, an_bq3 NUMBER,
 an_cer NUMBER, an_cq1 NUMBER, an_cq3 NUMBER, an_der NUMBER, an_dq1 NUMBER, an_dq3 NUMBER, av_mtrsn VARCHAR2, ad_date DATE
 ) IS
 BEGIN
  SAVEPOINT set_bill_sp;
  comsrv_pg.set_bill_meter(an_mid, an_er, NULL, an_q1, an_q3, NULL, NULL, an_aer, NULL, an_aq1, an_aq3, NULL, NULL, an_ber, NULL, an_bq1, an_bq3, NULL, NULL,
   an_cer, NULL, an_cq1, an_cq3, NULL, NULL, an_der, NULL, an_dq1, an_dq3, NULL, NULL, av_mtrsn, NULL, ad_date);
  comsrvcim_pg.upd_lastsavebill(an_mid, TO_CHAR(ad_date, 'dd.mm.yyyy hh24:mi'));
 EXCEPTION
  WHEN OTHERS THEN
   ROLLBACK TO SAVEPOINT set_halfhour_sp;
   raise_application_error(-20001, 'COMSRVMTX_PG.set_bill: ' || SQLERRM(SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
  --Вставка месячных расходов
 PROCEDURE set_months(
 an_mid NUMBER, an_er NUMBER, an_q1 NUMBER, an_q3 NUMBER, an_aer NUMBER, an_aq1 NUMBER, an_aq3 NUMBER, an_ber NUMBER, an_bq1 NUMBER, an_bq3 NUMBER,
 an_cer NUMBER, an_cq1 NUMBER, an_cq3 NUMBER, an_der NUMBER, an_dq1 NUMBER, an_dq3 NUMBER, av_mtrsn VARCHAR2, ad_date DATE
 ) IS
 BEGIN
  SAVEPOINT set_months_sp;
  comsrv_pg.set_months_meter(an_mid, an_er, NULL, an_q1, an_q3, NULL, NULL, an_aer, NULL, an_aq1, an_aq3, NULL, NULL, an_ber, NULL, an_bq1, an_bq3, NULL, NULL,
   an_cer, NULL, an_cq1, an_cq3, NULL, NULL, an_der, NULL, an_dq1, an_dq3, NULL, NULL, av_mtrsn, NULL, ad_date);
  comsrvcim_pg.upd_lastsavemonths(an_mid, TO_CHAR(ad_date, 'dd.mm.yyyy hh24:mi'));
 EXCEPTION
  WHEN OTHERS THEN
   ROLLBACK TO SAVEPOINT set_months_sp;
   raise_application_error(-20001, 'COMSRVMTX_PG.set_months: ' || SQLERRM(SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
--Запись журнала
 PROCEDURE set_journal(an_mid NUMBER, an_event common_pg.tt_number, av_date common_pg.tt_varchar2, an_type NUMBER) IS
  cn_deferrcode CONSTANT NUMBER := 630;
  ln_event            NUMBER;
  ld_date             DATE;
  ld_max              DATE;
 BEGIN
  SAVEPOINT set_journal_sp;

  FOR i IN 1 .. an_event.COUNT LOOP
   IF av_date(i) IS NULL OR NVL(an_event(i), 0) <= 0 THEN
    RETURN;
   END IF;

   ld_date := TO_DATE(av_date(i), 'dd.mm.yyyy hh24:mi:ss');

   SELECT NVL(MAX(nevent), cn_deferrcode)
   INTO   ln_event
   FROM   metereventsdict
   WHERE  nmetertype = comsrv_pg.cn_mtx AND neventcode = an_event(i) AND neventclass = DECODE(an_type, 1, 1, 3);

   admin_pg.ins_journal_p(ld_date, an_mid, 0, '', ln_event, an_event(i));
   ld_max := GREATEST(NVL(ld_max, ld_date), ld_max);
  END LOOP;

  UPDATE last_save
  SET journal = ld_max
  WHERE  mid = an_mid AND(NVL(journal, ld_max - 1) < ld_max);
 EXCEPTION
  WHEN OTHERS THEN
   ROLLBACK TO SAVEPOINT set_journal_sp;
   raise_application_error(-20001, 'set_journal: mid=' || an_mid || ' ' || SQLERRM(SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
 PROCEDURE set_state(
 an_mid NUMBER,                                                                                                                            --Ид точки или канала
               an_state_cod NUMBER,                                                                                                              --Код сообщения
                                   av_state_descr VARCHAR2,                                                                                    --Текст сообщения
                                                           an_clock NUMBER DEFAULT 0                                                         --Расхождение часов
 ) IS
  ln_curr_cod         NUMBER;
  ln_clock            NUMBER := NVL(an_clock, 0);
 BEGIN
  SELECT MAX(NVL(state_cod, 100))
  INTO   ln_curr_cod
  FROM   last_save
  WHERE  mid = an_mid;

  IF ln_curr_cod IS NULL OR ln_curr_cod <> an_state_cod THEN
   IF an_state_cod >= 0 THEN
    comsrvcim_pg.upd_lastsave(an_mid, an_state_cod, av_state_descr, ln_clock);
   ELSE 
   	comsrvcim_pg.upd_lastsave(an_mid, an_state_cod, 'Штатный режим', ln_clock);
   END IF;

   comsrvcim_pg.ins_journal(an_mid, an_state_cod, nvl(av_state_descr, 'Штатный режим'));
  END IF;
 EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 'set_state: mid=' || an_mid || ' ' || SQLERRM(SQLCODE));
 END;

------------------------------------------------------------------------------------------------------------------------
END;
-- Package Body COMSRVDLL_PG
/


-- End of DDL Script for Package Body RYDA.COMSRVMTX_PG
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

/*

(select 'ALTER PACKAGE '||OBJECT_NAME||' COMPILE PACKAGE;' c from user_objects where OBJECT_TYPE = 'PACKAGE'AND STATUS = 'INVALID'
union all select 'ALTER VIEW '||OBJECT_NAME||' COMPILE;' c from user_objects where OBJECT_TYPE = 'VIEW'AND STATUS = 'INVALID'
union all select 'ALTER PROCEDURE '||OBJECT_NAME||' COMPILE;' c from user_objects where OBJECT_TYPE = 'PROCEDURE'AND STATUS = 'INVALID'
union all select 'ALTER FUNCTION ' ||OBJECT_NAME||' COMPILE;' c from user_objects where OBJECT_TYPE = 'FUNCTION' AND STATUS = 'INVALID'
union all select 'ALTER PACKAGE '||OBJECT_NAME||' COMPILE BODY;' c from user_objects where OBJECT_TYPE = 'PACKAGE BODY' AND STATUS = 'INVALID'
union all select 'ALTER TRIGGER ' ||OBJECT_NAME||' COMPILE;' c from user_objects where OBJECT_TYPE = 'TRIGGER' AND STATUS = 'INVALID')

*/


