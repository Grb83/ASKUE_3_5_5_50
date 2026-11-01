//---------------------------------------------------------------------------

#ifndef InteriorDU2ChartH
#define InteriorDU2ChartH
//---------------------------------------------------------------------------
#include "Interior1.h"
//---------------------------------------------------------------------------
//Текущие значения и параметры качества электроэнергии (КСС)
class TDU2ChartInterior : public T1Interior
{
   TChart *pChart1;
   TVirtualTable *vtDU2Data;
public:
    __fastcall TDU2ChartInterior(TComponent* Owner,TSplitterForm *,TFormDescr*,Classes::TNotifyEvent);
	virtual __fastcall ~TDU2ChartInterior(void);
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
  virtual void __fastcall SaveTableToFile(TSaveDialog *aSaveDialog);
protected:
    void __fastcall ChartMouseDown(TObject*, TMouseButton, TShiftState, int, int);
    void __fastcall ChartMouseMove(TObject*, TShiftState, int, int);
    //GRB ADD 26.08.2021 - два метода для автоформатирования по содержимому фиксированых колонок - исправление бага с обрезанием длинных имён в колонках
  void __fastcall AutoSizeColGRB (TDrawTable* tsg, int columnIndex);
  void __fastcall AutoSizeNameOnly (TDrawTable* tsg);
  //GRB ADD 27.08.2021 - берём из реестра размер шрифта и тип шрифта для того чтобы измерить сколько в длинну колонка с именем объекта занимает пикселей
  TFont * __fastcall GetActiveFont4MonitorFromReg ();
  //GRB ADD 27.08.2021 - подхватываем ресайз формы чтобы при отобраажении колонки монитора по ширине подхватывать и перерисовывать колонку с именем объекта
  void __fastcall FormShow(TObject *Sender);
  bool __fastcall GetContainedWidthStatusFromReg();

};
//---------------------------------------------------------------------------
#endif
