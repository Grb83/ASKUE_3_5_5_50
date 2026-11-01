//---------------------------------------------------------------------------
#ifndef InteriorH
#define InteriorH
//---------------------------------------------------------------------------
#include <system.hpp>
#include <classes.hpp>
#include <OleCtrls.hpp>
#include <math.h>
#include <values.h>
#include <Chart.hpp>
#include <TeEngine.hpp>
#include <TeeProcs.hpp>
#include <Series.hpp>
#include <TeeFunci.hpp>
#include "SplitForm.h"
#include "SetupMonitors.h"
#include "FormDescr.h"
#include "PrintDrawTable.h"
#include <utilcls.h>
#include "Ora.hpp"
//---------------------------------------------------------------------------
#pragma option -w-hid
/*---------------------------------------------------------------------------
Hierarhy:
  ____________
  |TInterior |
  |__________|
       |   ___________________________
       |-->|TInteriorAlert           |
       |   |_________________________|
       |   ___________________________
       |-->|TInteriorEx              |
       |   |_________________________|
       |   ___________________________
       |-->|TInteriorExOpForm        |
       |   |_________________________|
       |   ___________________________
       |-->|TInteriorExRep           |
       |   |_________________________|
       |   ___________________________
       |-->|TJournalInterior         |
       |   |_________________________|
       |   ___________________________
       |-->|TJournalInteriorSys      |
       |   |_________________________|
       |   ___________________________
       |-->|TChartInterior           |
       |   |_________________________|
       |   ___________________________
       |-->|TInteriorPLProc          |
       |   |_________________________|
       |
       |   ___________________________
       |-->|TInteriorFullDat         |
       |   |_________________________|
       |
       |   ___________________________
       |-->|T2xDrawTableChartInterior|
       |   |_________________________|
       |       |   _____________________
       |       |-->|T2Interior         |
       |       |   |___________________|
       |       |      |   _____________________
       |       |      |-->|T1Interior         |
       |       |      |   |___________________|
       |       |      |     |   _____________________
       |       |      |     |-->|TDU2ChartInterior  |
       |       |      |         |___________________|
       |       |      |   _____________________
       |       |      |-->|T4Interior         |
       |       |          |___________________|
       |       |
       |       |   _____________________
       |       |-->|TLimitPowerInterior|
       |           |___________________|
       |   __________________________
       |-->|TDUInterior             |
       |   |________________________|
       |       |   _____________________
       |       |-->|TConsumImbalance   |
       |       |   |___________________|
       |       |   _____________________
       |       |-->|TDecadInterior     |
       |       |   |___________________|
       |       |   _____________________
       |       |-->|TConsumLimit       |
       |       |   |___________________|
       |       |   _____________________
       |       |-->|TConsumLimitDebt   |
       |           |___________________|
       |   _____________________
       |-->|TModusInterior     |
           |___________________|
  --------------------------------------------------------------------*/
//  Form codes:
//Двустолбцевые
#define AEBO_REBO_F         100   //Переток Активной / Реактивной энергии [МВтч/МВАрч]
#define AEBO_REBO_POW_F     101     //Переток Активной / Реактивной энергии [МВтч/МВАрч] Получасовки мощность
#define AEBO_REBO_SUM_F     102     //Переток Активной / Реактивной энергии [МВтч/МВАрч] Суммируется по наростающей
#define AERO_AEDO_F         200   //Приём / Отдача Активной энергии [МВтч]
#define AERO_AEDO_POW_F     201   //Приём / Отдача Активной энергии [МВтч] Получасовки мощность
#define AERO_AEDO_SUM_F     202   //Приём / Отдача Активной энергии [МВтч] Суммируется по наростающей
#define RERO_REDO_F         300   //Приём / Отдача Реактивной энергии [МВАрч]
#define RERO_REDO_POW_F     301   //Приём / Отдача Реактивной энергии [МВАрч] Получасовки мощность
#define RERO_REDO_SUM_F     302   //Приём / Отдача Реактивной энергии [МВАрч] Суммируется по наростающей

#define RQ1_RQ4_F           310   //Приём / Отдача Реактивной энергии при импорте активной энергии [МВАрч]
#define RQ1_RQ4_POW_F       311   //Приём / Отдача Реактивной энергии при импорте активной энергии [МВАрч]  Получасовки мощность
#define RQ2_RQ3_F           320   //Приём / Отдача Реактивной энергии при экспорте активной энергии [МВАрч]
#define RQ2_RQ3_POW_F       321   //Приём / Отдача Реактивной энергии при экспорте активной энергии [МВАрч] Получасовки мощность
#define FULL_DATA           330   //Полнота и своевременность прлучаемых данных

//Одностолбцевые
#define AEBO_F              400   //Переток Активной энергии [кВтч]
#define AEBO_POW_F          401   //Переток Активной энергии [кВтч] Получасовки мощность
#define AEBO_SUM_F          402   //Переток Активной энергии [кВтч] Суммируется по наростающей
#define AERO_F              500   //Приём Активной энергии [кВтч]
#define AERO_POW_F          501   //Приём Активной энергии [кВтч] Получасовки мощность
#define AERO_SUM_F          502   //Приём Активной энергии [кВтч] Суммируется по наростающей
#define AEDO_F              600   //Отдача Активной энергии [кВтч]
#define AEDO_POW_F          601   //Отдача Активной энергии [кВтч] Получасовки мощность
#define AEDO_SUM_F          602   //Отдача Активной энергии [кВтч] Суммируется по наростающей

#define REBO_F              700   //Переток Реактивной энергии [кВАрч]
#define REBO_POW_F          701   //Переток Реактивной энергии [кВАрч] Получасовки мощность
#define REBO_SUM_F          702   //Переток Реактивной энергии [кВАрч] Суммируется по наростающей
#define RERO_F              800   //Приём Реактивной энергии [кВАрч]
#define RERO_POW_F          801   //Приём Реактивной энергии [кВАрч] Получасовки мощность
#define RERO_SUM_F          802   //Приём Реактивной энергии [кВАрч] Суммируется по наростающей
#define REDO_F              900   //Отдача реактивной энергии [кВАрч]
#define REDO_POW_F          901   //Отдача реактивной энергии [кВАрч] Получасовки мощность
#define REDO_SUM_F          902   //Отдача реактивной энергии [кВАрч] Суммируется по наростающей

#define AERO_DECAD_F        1400  //Приём Активной энергии по декадам [тыс.кВтч]
#define AEBO_DECAD_F        1410  //Переток Активной энергии по декадам [тыс.кВтч]

#define MAKET_F        1450 // Макет 30817

//Четырехстолбцевые (тарифные)
#define AERO_AERA_AERB_AERC_F 910 //Активная принятая общая и по тарифам [кВтч]
#define AEDO_AEDA_AEDB_AEDC_F 920 //Активная отданная общая и по тарифам [кВтч]
#define AEBO_AEBA_AEBB_AEBC_F 921 //Переток активной э/э (общая и по тарифам) [кВтч]
#define RERO_RERA_RERB_RERC_F 930 //Реактивная принятая общая и по тарифам [кВАрч]
#define REDO_REDA_REDB_REDC_F 940 //Реактивная отданная общая и по тарифам [кВАрч]
#define REBO_REBA_REBB_REBC_F 941 //Переток реактивной э/э (общая и по тарифам) [кВарч]

#define AERA_AERB_AERC_AERD_F 950 //Активная принятая по тарифам [кВтч]
#define AEDA_AEDB_AEDC_AEDD_F 960 //Активная отданная по тарифам [кВтч]
#define RERA_RERB_RERC_RERD_F 970 //Реактивная принятая по тарифам [кВАрч]
#define REDA_REDB_REDC_REDD_F 980 //Реактивная отданная по тарифам [кВАрч]

//Баланс
#define BALANCE_F         203   //Баланас Активной энергии [МВтч]
#define BALANCE_POW_F     204   //Баланс Активной энергии (ГН, Тех.проф. - мощность)
#define BALANCE_SUM_F     205   //Баланс Активной энергии (Суммируется по наростающей)
#define RE_BALANCE_F         303   //Баланс Реактивной энергии
#define RE_BALANCE_POW_F     304   //Баланс Реактивной энергии (ГН, Тех.проф. - мощность)
#define RE_BALANCE_SUM_F     305   //Баланс Реактивной энергии (Суммируется по наростающей)
#define NOT_BALANCE         206   //Небаланс энергии
#define NOT_BALANCE_AER      207   //Небаланс активной энергии


//Графики
#define APRO_C              10    //Активная мощность
#define RPRO_C              20    //Реактивная мощность

//Лимиты мощности
#define APBO_F              30    //Мощность, лимит, отклонение [МВт]
#define RPBO_F              40    //Мощность, лимит, отклонение [МВт]

//Форма диспечерского управления
#define DU_F              50    //Текущая нагрузка, МВт
#define DU_F_BW             52    //Текущая нагрузка (Ч\Б)
#define Disturber_F         51    //Оперативный контроль лимитов
#define Disturber_F_BW      53    //Оперативный контроль лимитов (Ч\Б)
#define ConsumLim_F         54    //Контроль потребителей (План Факт Отклонение)
#define ConsumLim_F_BW      55    //Контроль потребителей (Ч/Б) (План Факт Отклонение)
#define ConsumLim_F__Debt   56    //Контроль потребителей-должников
#define ConsumLim_F_BW__Debt 57   //Контроль потребителей-должников (Ч/Б)
#define ConsumLim_F__Limit  58    //Контроль потребителей-перерасходчиков
#define ConsumLim_F_BW__Limit 59  //Контроль потребителей-перерасходчиков (Ч/Б)
#define ConsumLost_F 60       //Контроль не поступления данных
#define ConsumLost_F_BW     61    //Контроль не поступления данных (Ч\Б)

#define ConsumLimDebt_F     62    //Контроль потребителей (Есть столбец долг)
#define ConsumImbalance_F   63    //Небаланс энергообъектов
#define ConsumImbalance_POW_F 64  //Небаланс энергообъектов (По мощности)

#define DU2CHART_PARAMS     65      //Текущие значения и параметры качества электроэнергии (КСС)
//GRB ADD 27.11.2020
#define DU2CHART_PARAMS_NEW     66 //Векторная диаграмма качества электроэнергии (вместо 65) 

//Шаблон журнала
#define JOURNAL_F           1000  //Журнал действий оператора
#define JOURNALSYS_F        1100    //Журнал сообщений системы

//Шаблон монитора с Excel-ом
#define EXCEL_F             1200  //Универсальная форма отображения данных
#define EXCEL_REP_F         1201    //Универсальная форма отображения отчетов
#define EXCEL_OP_FORM       1202    //Оперативная форма без маштабирования
#define EXCEL_REP_OUT_F     1206    //Универсальная форма отображения отчетов во внешнем Excel'e
//Схемы
#define SCHEMA_OP_FORM      1204    //Оперативная форма отображения схемы сети // Add by KSS
#define MODUS_OP_FORM       1205    //Оперативная форма отображения схемы сети // Add by KSS
//SQL
#define PL_SQL_REP_F        1203    //Универсальная форма отображения отчетов с использованием PL-SQL
#define PL_SQL_TABLE        1207    //Универсальная таблица
//23.01.2019 GRB ADD - задача Для создания встроенного отчета о потреблении активной и реактивной энергии, а также генерации реактивной энергии по точке или группе точек абонента Житомир ОЭ, получена в конце 2018 г.
#define PL_SQL_MANY_TABLE   1208    //Универсальная многотабличная(3 или 4 таблиц) форма с возможностью сохранения в SQL

//таблицы при срабатывании alert
#define TABLE_PROFILE       (int)(1)
#define TABLE_HALFHOUR      (int)(2)
#define TABLE_BILL          (int)(3)
#define TABLE_JOURNAL       (int)(4)
#define TABLE_FISCAL        (int)(5)
#define TABLE_CURR_POWER    (int)(6)
#define TABLE_CURR_DEMAND   (int)(7)

/************** Временные определенеия для газа, воды и тепла. ***************/
#define WATER_F             4001  //Переток Активной энергии [кВтч]
#define GAS_F               4003  //Переток Активной энергии [кВтч]
#define HEAT_F              4002  //Переток Активной энергии [кВтч]
/*****************************************************************************/
#define AMOUNTSERIES        100     // Максим. число крафиков на полотне
//-------------------------------------------------------------------------------

//---------------------------------------------------------------------------
struct TCloneItem
{
    double val;
    char isvalid[32];
    TCloneItem(){ZeroMemory(this,sizeof(*this)); this->val=-MAXFLOAT;};
};

class TInterior : public TComponent
{
protected:
    TSplitterForm *SplitterForm;
    virtual int __fastcall GetCountRow();
    TVirtualTable *VT_PrintData;// Add KAS 25.06.2002 Для печати таблиц
    long __fastcall GroupJump(long value); // Для перемещения по спискам
    AnsiString __fastcall GetCurrentDate( TOraQuery *quMain);
    void __fastcall setDataSourceToDrawTable(TDrawTable*, TCloneItem*, int, int, int);
    void __fastcall setColorToDrawTable(TDrawTable*,int );
   
     AnsiString __fastcall GetCaptionPowerCoeff();
public:
    long GroupIsList; // Для бродилова по спискам
  TFormDescr *fd;
  //bool is_refreshData;
  Classes::TNotifyEvent OnProgressBarStepBy;
  static AnsiString DateTimeFormat;
/*  static AnsiString ObsoleteTimeLimit;// Интервал времени после которого данные считаются устаревшими
                                       // т.е. если дата данных в curr_power отличается от максимальной даты на
                                       // ObsoleteTimeLimit то данные устарели и не выводятся
*/
  HANDLE hMutex;
    TStrings *ColumnsCaption;// Названия колонок для печати
  __fastcall TInterior(TComponent* Owner,TSplitterForm *,TFormDescr*,Classes::TNotifyEvent );
  __fastcall TInterior(TComponent* Owner):TComponent(Owner),fd(NULL),ColumnsCaption(NULL){;}
  virtual __fastcall ~TInterior(void);
  virtual TFormDescr* __fastcall GetFormDescr(void){return fd;}
  virtual void __fastcall Destroy(void){}
  virtual void __fastcall Place(void){}
  virtual bool __fastcall setSplit(void){return true;}


  virtual void __fastcall selectData( TOraQuery *qwInter );

    virtual void __fastcall refreshForm(void);
  __property int RowCount = {read=GetCountRow};

  //**********        Фоновая загрузка данных ************************
  //refreshData - выполняется в контексте фоновой нитки,
  //              и служит для получения данных из сервера
  //              не должна содержать вызовов методов и свойств VCL
  virtual void __fastcall refreshData( int Table,TOraQuery *quMain );
  //Invalidate -  выполняется в контексте главного процесса,
  //              и служит для визуального отображения данных
  virtual void __fastcall Invalidate( int Table );
    // Add KAS 11.02.02
  virtual void __fastcall PrintRep();
  virtual void __fastcall PrintGraph();
  virtual void __fastcall SaveRepToFile(TSaveDialog *aSaveDialog);
  virtual void __fastcall SaveTableToFile(TSaveDialog *aSaveDialog);
  //GRB ADD
  virtual void __fastcall SaveMultyTableToFile(TSaveDialog *aSaveDialog);
  virtual void __fastcall SaveGraphToFile(TSaveDialog *aSaveDialog);
  virtual void __fastcall PrintTable();
    double YMaxVal, YMinVal; // Максимум и минимум на графике
    // Возвращает единицу измерения энергии
    virtual AnsiString __fastcall GetUnitOfEnergy();
    // end Add
};
//---------------------------------------------------------------------------
extern int refreshDataCount;
extern AnsiString MyFloatFormat;
extern const int LenFloat;
extern const int IND_CNT;// максимальное количество значений в ячейке интерьера
//---------------------------------------------------------------------------
//chig
bool IsCommonRepForm(int pPCode);
//e chig

#endif
