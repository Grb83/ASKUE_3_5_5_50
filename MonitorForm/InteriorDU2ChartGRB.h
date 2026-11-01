//---------------------------------------------------------------------------

#ifndef InteriorDU2ChartGRBH
#define InteriorDU2ChartGRBH
//---------------------------------------------------------------------------
#include "Interior1.h"
#include "InteriorDU2Chart.h"
#define VECTOR_NUMS 6
        struct coord2x{
                int x;
                int y;
        };
        coord2x* coordVector;
        typedef struct coord2x coord2x;
        coord2x coordArcAngle[12], coordArcLittleAngle[12]; //координаты пересечения хорд из центра диаграммы с большим кругом с шагом по 30 градусов (от них строим арки и рисуем подписи)
        TColor gzk[6];  //Цвета желтый-зелёный-красный и их оттенки для разрисовки диаграммы и грида с поясняловкой
        int global_obsolete = 1; //считаем по умолчанию так
        DIM_MONITOR_PAIR [13][2];
//---------------------------------------------------------------------------
class TDU2ChartInteriorGRB : public T1Interior
{
   //---------------------------------------------------------------------------
   TChart *pChartGRB1; //моя новая векторная диаграмма
   TStringGrid *StringGrid1; //наша таблица с отображениями
   TChart *pChart1; //старые векторные диаграммы  - пойдёт под нож
   TVirtualTable *vtDU2Data;
   int currentRow;
 // структура данных для вывода подписей к стрелкам на канву - на будущее, будет используеться только в drawCaptionLines
        struct endVectorCoord{
            coord2x coord;
            AnsiString name;
            TColor color;
        };
        endVectorCoord* captionVector;
        struct ishod_data { //Слепок полученных данных с процедуры interiordu2chart_selectdata_p
                /*То што для всех */
                double na; //Разница между активной принятой и активной отданной мощности отнормированная на 1000
                double nr; //Разница между реактивной принятой и реактивной отданной мощности отнормированная на 1000
                double an; //Угол фи(коэффициент мощности) в градусах
                double cosf; //Косинус фи в радианах - те [-1;1]

                double ua; //Напряжение A
                double ub; //Напряжение B
                double uc; //Напряжение С

                double an_ua; //Угол напряжения 1 (градусы)
                double an_ub; //Угол напряжения 2 (градусы)
                double an_uc; //Угол напряжения 3 (градусы)

                double ia; //Ток A (Амперы)
                double ib; //Ток B (Амперы)
                double ic; //Ток C (Амперы)

                double an_ia;  //Углы тока (градусы)
                double an_ib; //Углы тока  (градусы)
                double an_ic; //Углы тока  (градусы)

                double U1U2;  //Относительные углы напряжения1 (градусы)
                double U1U3;  //Относительные углы напряжения2 (градусы)
                double U2U3;  //Относительные углы напряжения3 (градусы)

                double U1I1; //Углы сдвижки между вектором тока и напряжения по 1й фазе
                double U2I2; //Углы сдвижки между вектором тока и напряжения по 2й фазе
                double U3I3; //Углы сдвижки между вектором тока и напряжения по 3й фазе
                double freq; //Частота тока
                int obsolete;
        };
        ishod_data activ_data;
        AnsiString objName;
        AnsiString Language;
public:
__fastcall TDU2ChartInteriorGRB(TComponent* Owner,TSplitterForm *,TFormDescr*,Classes::TNotifyEvent);
   virtual __fastcall ~TDU2ChartInteriorGRB(void);
    //Формирует название строк таблицы монитора
    virtual void __fastcall formDescr( void );
    //Число параметров по объекту (столбцов)
	int __fastcall GetCountRow(void);
    //Выполняет вытяжку данных из БД в память (в datOracle)
    void __fastcall selectData(TOraQuery *qwInter);
    //Формирует таблицу с данными
    void __fastcall clonesInRows(void);
    //Возвращает имена подколонок для формы
	//virtual char** __fastcall GetSubColumnsNames(void);
    virtual AnsiString __fastcall GetSubColumnsNames(int n);
    //Заполняет таблицу данными
    void __fastcall dataInRows(void);
    //Формирование монитора на экране
    void __fastcall Place(void);
	//Интерпритирует счелчок пользователь на таблице,
	//полагая что клоны расположены по столбцам
	//и строит график профиля или распределения
    void __fastcall clickGraphics(long ColPressed, long RowPressed);
    //Установить новую компановку
	virtual bool __fastcall setSplit(void);
	//Строит линейный график для указанного параметра
    void __fastcall ChartFXLines(long AClone);
	//Строит график характеристик точки для указанного времени
    void __fastcall ChartFXColumns(long ARow);
    void __fastcall Destroy(void);
    void __fastcall OnPopupClick(TObject* Sender);
    //void __fastcall PopupMenuBaseFormPopupGRB(TObject *Sender);
  virtual void __fastcall SaveTableToFile(TSaveDialog *aSaveDialog);



  //Поехали добавлять своё
          void __fastcall StringGrid1DrawCell(TObject *Sender, int ACol,
          int ARow, const TRect &Rect, TGridDrawState State);
          void __fastcall DrawTableDrawCell(TObject *Sender, int ACol,
         int ARow, const TRect &Rect, TGridDrawState State);
         void __fastcall FormShow(TObject *Sender);

         //Чтобы перекрыть эффект сдвига колонки грида при случае когда столбец не помещается в область со скроллингом
          void __fastcall StringGrid1TopLeftChanged(TObject *Sender);
          void __fastcall writeParamsToTable();
          void __fastcall pChart1BeforeDraw(TObject *Sender);
          void __fastcall fAutoSizeColSG(TStringGrid* StringGrid);
          void __fastcall drawTitleDiagramm();
          __fastcall int getX1();
          __fastcall int getY1();
          __fastcall int getX2();
          __fastcall int getY3();
          __fastcall coord2x getCoord4CaptionOnRound (int x0, int y0, int Radius, int degree);// возвращает двумерные координаты для подписей на большом кругу диаграммы
          __fastcall void drawCaptionLines (endVectorCoord* );
          __fastcall void InitValue();
          __fastcall void placeChart();
          __fastcall void IncreaseScaleValue( double & PPYMinVal, double & PPYMaxVal );

protected:
    void  __fastcall ChartMouseDown(TObject*, TMouseButton, TShiftState, int, int);
    void __fastcall ChartMouseMove(TObject*, TShiftState, int, int);
    //Событийные обработчики
    void __fastcall OnClickPanel(System::TObject* Sender);
    void __fastcall OnKeyUp(TObject *Sender, WORD &Key,TShiftState Shift);
    void __fastcall ChartFXLinesClick(TObject *Sender);
    void __fastcall SaveGraphToFile(TSaveDialog *aSaveDialog);
    AnsiString __fastcall getSeparator();
    void __fastcall moveRowToActiveData(int aRow);
    AnsiString __fastcall getObjectName (int aRow);
    double __fastcall getMaxVector (double vec1, double vec2, double vec3 );
    //ресуем стрелку
    void __fastcall DrawLine(TCanvas3D* Canvas, double x0, double y0, double x1, double y1, double ArrowAngle, int ArrowLen);
    //GRB ADD 26.08.2021 - два метода для автоформатирования по содержимому фиксированых колонок - исправление бага с обрезанием длинных имён в колонках
  void __fastcall AutoSizeColGRB (TDrawTable* tsg, int columnIndex);
  void __fastcall AutoSizeNameOnly (TDrawTable* tsg);
  //GRB ADD 27.08.2021 - берём из реестра размер шрифта и тип шрифта для того чтобы измерить сколько в длинну колонка с именем объекта занимает пикселей
  TFont * __fastcall GetActiveFont4MonitorFromReg ();
  //GRB ADD 27.08.2021 - подхватываем ресайз формы чтобы при отобраажении колонки монитора по ширине подхватывать и перерисовывать колонку с именем объекта
  bool __fastcall GetContainedWidthStatusFromReg();
};
//---------------------------------------------------------------------------
#endif

