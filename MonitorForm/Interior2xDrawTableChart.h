//---------------------------------------------------------------------------

#ifndef Interior2xDrawTableChartH
#define Interior2xDrawTableChartH
//---------------------------------------------------------------------------
#include "Interior.h"
#include "DetailPoint.h"
//---------------------------------------------------------------------------
class T2xDrawTableChartInterior : public TInterior
{
    typedef TInterior inherited;
private:
    bool __fastcall AreTherTwoGraph();
    void __fastcall ResizeScaleOfGraph(long ARow, TChartSeries **pSeries, int SubCol, int SkipCol=0);
    void __fastcall ResizeScaleOfTwoGraph(long ARow, TChartSeries **pSeries, int SubCol);
    void __fastcall ResizeScaleOfSecondGraph(long ARow, TChartSeries **pSeries);
    void __fastcall ScaleOfGraph(bool fCode, int ColGraph, int MaxRowCount, long AClone, TLineSeries **pSeries, TDateTime *fDate, AnsiString LabelDateFormat);
    void __fastcall ScaleOfTwoGraph(bool fCode, int MaxRowCount, long AClone, TLineSeries **pSeries, TDateTime *fDate, AnsiString LabelDateFormat);
    int SV; //переменная хранит информацию об отражении метки качества. читает из реестра (0 - не выводить, 1 - метка кач данных, 2 - метка качества электроэнергии)
    TfmDetailPoint*Dp;
 protected:
    TDrawTable *DrawTable;
    TChart *pChart;
    TChart *pSecondChart;
	TStrings *NamesClones;      //имена клонов
    bool *fNumClones;
    bool fPlace;
	bool ClonePressed;          //для визуализации нажатий на заголовки таблицы
	TShiftState ShiftPressed;   //для визуализации нажатий на заголовки таблицы
	long ColPressed,RowPressed; //для визуализации нажатий на заголовки таблицы
	long Clones;                //общее количество клонов в таблице
	TCloneItem *datOracle;      //Двумерный массив всегда содержащий суммарный клон и столбец
					            //Клоны расположены по столбцам.
    bool IsColorAssigned( int PPInd );
    void AssignColor( int PPInd );
    TColor ColorByClonId( int PPInd );
    
public:
    __fastcall T2xDrawTableChartInterior(TComponent* Owner,TSplitterForm *,TFormDescr*,Classes::TNotifyEvent );
	virtual __fastcall ~T2xDrawTableChartInterior(void);

	//Выдача fd , с возможность проведения предварительной коррекции
	virtual TFormDescr* __fastcall GetFormDescr(void);

	//Снятие со SplitterFom и размещение на SplitterFom таблицы и графика,
	//вызываемтся при обновлении TBaseMonitorForm
	void __fastcall Destroy(void);
	virtual void __fastcall Place(void);

	//Установить новую компановку
	virtual bool __fastcall setSplit(void);

	//Возвращает количесиво подколонок для формы
	virtual long __fastcall SubColumns(void);

	//Возвращает имена подколонок для формы

 virtual AnsiString __fastcall GetSubColumnsNames(int);

	//Обновление данных из базы
	//NameAlert=-1 для обновления в любом случае
	virtual void __fastcall Invalidate( int Table );
	virtual void __fastcall refreshData( int Table,TOraQuery *qwInter );
	virtual void __fastcall selectData( TOraQuery *qwInter );

	//Получает данные о считываемой таблице
	virtual void __fastcall formDescr( void );

	//Формирует таблицу, располагая клоны по столбцам
	virtual void __fastcall clonesInColumns(void);
	virtual void __fastcall dataInColumns(void);

	//Формирует таблицу, располагая клоны по строкам
	virtual void __fastcall clonesInRows(void);
	virtual void __fastcall dataInRows(void);

	//Строит столбцевой график для указанного профиля
	virtual void __fastcall ChartFXColumns(long ARow);

	//Строит линейный график для указанного клона
	virtual void __fastcall ChartFXLines(long AClone);

	//Интерпритирует счелчок пользователь на таблице,
	//полагая что клоны расположены по столбцам
	//и проводит композицию или декомпозицию
	virtual void __fastcall clickComposition(long ACol, long ARow );

	//Интерпритирует счелчок пользователь на таблице,
	//полагая что клоны расположены по столбцам
	//и строит график профиля или распределения
	virtual void __fastcall clickGraphics(long ACol, long ARow );

	//Событийные обработчики
	void __fastcall OnClickPanel(System::TObject* Sender);
	void __fastcall OnKeyUp(TObject *Sender, WORD &Key,TShiftState Shift);
	void __fastcall ChartFXLinesClick(TObject *Sender);
  void __fastcall IsValidClick(TObject *Sender);//Достоверность
	virtual void __fastcall PopupMenuBaseFormPopup(TObject *Sender);
	virtual void __fastcall DrawTableMouseDown(TObject *Sender,TMouseButton Button,
		TShiftState Shift, int X, int Y);
    virtual void __fastcall DrawTableMouseMove(TObject *Sender,TShiftState Shift,
		int X, int Y);
	virtual void __fastcall DrawTableMouseUp(TObject *Sender,TMouseButton Button,
		TShiftState Shift, int X, int Y);
    // Add KAS 11.02.02
	virtual void __fastcall PrintGraph();
	virtual void __fastcall PrintTable();
	virtual void __fastcall SaveGraphToFile(TSaveDialog *aSaveDialog);
    virtual void __fastcall SaveTableToFile(TSaveDialog *aSaveDialog);

    // end Add
    //chig
    void __fastcall IncreaseScaleValue( double & PPYMinVal, double & PPYMaxVal );
    //e
  void __fastcall ShowDetailPoint(long ColPressed, long RowPressed );
  //GRB ADD 12.07.2019  - является ли дата в pfd->DateTime днём перевода времени за monthNumber
  bool __fastcall IsDayShiftMonth (TFormDescr *pfd, int monthNumber);
  // END GRB ADD
  //GRB ADD 26.08.2021 - два метода для автоформатирования по содержимому фиксированых колонок - исправление бага с обрезанием длинных имён в колонках
  void __fastcall AutoSizeColGRB (TDrawTable* tsg, int columnIndex);
  void __fastcall AutoSizeNameOnly (TDrawTable* tsg);
  //GRB ADD 27.08.2021 - берём из реестра размер шрифта и тип шрифта для того чтобы измерить сколько в длинну колонка с именем объекта занимает пикселей
  TFont * __fastcall GetActiveFont4MonitorFromReg ();
  //GRB ADD 27.08.2021 - подхватываем ресайз формы чтобы при отобраажении колонки монитора по ширине подхватывать и перерисовывать колонку с именем объекта
  void __fastcall FormShow(TObject *Sender);
  bool __fastcall GetContainedWidthStatusFromReg();
protected:
    typedef TChartSeries *PSeries;
    int SeriesDgrms;
    int SeriesLines;
    PSeries *Series;
};
//---------------------------------------------------------------------------
#endif
