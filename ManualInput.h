//---------------------------------------------------------------------------
#ifndef ManualInputH
#define ManualInputH
//---------------------------------------------------------------------------
#include "DrawTable.h"
#include <ActnList.hpp>
#include <Buttons.hpp>
#include <Classes.hpp>
#include <Controls.hpp>
#include <ExtCtrls.hpp>
#include <Grids.hpp>
#include <StdCtrls.hpp>
#include "ManualInTree.h"
#include "Main.h"
#include <ImgList.hpp>
#include <Menus.hpp>
#include "DBGridEh.hpp"
#include <ComCtrls.hpp>
#include <ToolWin.hpp>
#include "DBAccess.hpp"
#include "MemDS.hpp"
#include "Ora.hpp"
#include <DB.hpp>
#include "VirtualTable.hpp"
#include "PrnDbgeh.hpp"
#include "GetSelectDateTime.h"
//---------------------------------------------------------------------------
#define WM_SELECTCELL (WM_USER+100)
#define MAXINPUT	5000
//---------------------------------------------------------------------------
class TfmManualInput : public TMainForm
{
__published:	// IDE-managed Components
  TDBGridEh *dbManInput;
  TToolBar *ToolBar1;
  TToolButton *btSave;
  TToolButton *tbRefresh;
  TToolButton *ToolButton5;
  TToolButton *btParams;
  TToolButton *ToolButton3;
  TToolButton *tbPrint;
  TBitBtn *btCheck;
  TPanel *Panel1;
  TCheckBox *cbConst;
  TOraQuery *oqReadRow;
  TDataSource *dsReadRow;
  TOraQuery *oqReadData;
  TVirtualTable *vtData;
  TOraQuery *oqSave;
  TCheckBox *cbInv;
  TPanel *Panel2;
  TOraQuery *oqMaxValue;
  TBitBtn *btInput;
  TOraQuery *oqMaxValue1;
  TComboBox *ComboBox1;
  TPanel *Panel3;
  TLabel *Label1;
  TOraQuery *setTimeShift;
  TPanel *Panel4;
  TRadioGroup *RadioGroup1;
  TToolButton *ToolButton1;
  TToolButton *tbCopyData;
  TToolButton *tbCopyDataYest;
  TToolButton *ToolButton2;
  TToolButton *tbDown;
  TToolButton *tbUp;
  TToolButton *ToolButton7;
  TPrintDBGridEh *PrintMessageGrid;
        TToolButton *ToolButton4;
        TToolButton *ToolButton6;
	void __fastcall FormCreate(TObject *Sender);
  void __fastcall btCheckClick(TObject *Sender);
  void __fastcall dbManInputDrawColumnCell(TObject *Sender,
          const TRect &Rect, int DataCol, TColumnEh *Column,
          TGridDrawState State);
  void __fastcall btSaveClick(TObject *Sender);
  void __fastcall tbRefreshClick(TObject *Sender);
  void __fastcall vtDataAfterPost(TDataSet *DataSet);
  void __fastcall iaCloseExecute(TObject *Sender);
  void __fastcall cbInvClick(TObject *Sender);
  void __fastcall dbManInputMouseUp(TObject *Sender, TMouseButton Button,
          TShiftState Shift, int X, int Y);
  void __fastcall vCopyClick(TObject *Sender);
  void __fastcall vPasteClick(TObject *Sender);
  void __fastcall btInputClick(TObject *Sender);
  void __fastcall dbManInputColEnter(TObject *Sender);
  void __fastcall FormCloseQuery(TObject *Sender, bool &CanClose);
  void __fastcall FormShow(TObject *Sender);
  void __fastcall ComboBox1Change(TObject *Sender);
  void __fastcall dbManInputKeyDown(TObject *Sender, WORD &Key,
          TShiftState Shift);
  void __fastcall RadioGroup1Click(TObject *Sender);
  void __fastcall tbCopyDataClick(TObject *Sender);
  void __fastcall tbCopyDataYestClick(TObject *Sender);
  void __fastcall tbDownClick(TObject *Sender);
  void __fastcall tbPrintClick(TObject *Sender);
  void __fastcall dbManInputColExit(TObject *Sender);
        void __fastcall ToolButton4Click(TObject *Sender);
        void __fastcall ToolButton6Click(TObject *Sender);
  
private:	// User declarations
   void __fastcall ReadData();
   void __fastcall GetColumnName();
   void __fastcall GetColumnNameInv();
   void __fastcall Check(double mid ,int nmeasure,AnsiString mtrsn,double kc, double Field0,int Col); // Возврат данных при разбивке на сутки
   void __fastcall PCheck();
   void __fastcall InvCheck();
   bool __fastcall SaveCheck();
   bool __fastcall SaveInvCheck();
   bool __fastcall GetColorAndMess( const TRect &Rect, float TestSender,int Col,bool flag);
   void __fastcall SetKoeff(int f);
   void __fastcall CopyData();
   //26.01.2021 GRB ADD
   long __fastcall getLastMid ();//затыкаем баг с копированием за предыдущие сутки в СopyData - проблема в том что для последней точки мы выходим в vtData на неправильную область - теперь будем для таких точек делать отделт 
   TFormManualInTree *f;
   POINTDATA p;
   POINTDATA tp;
   bool EditSum;
 //  long prov;	// Состояние проверки 0-Не проводилась, 1-проводилась (сохранять нельзя), 2-проводилась (сохранять можно)
   unsigned long CountStr; // Количество строчек в результате запроса
//   long ttable;
   int ColCount;
   AnsiString NameGroup;
   int RowCount;
   int TCount;
   bool INV;
   bool TestMes;
   int TestMid;

   struct MIDEDIT{
    long mid;
    int IsEdit;
   };
    MIDEDIT * MidIsEdit;

   struct MAXMIN{
     long mid;
     int meas;
     AnsiString mtrsn;
     double KC;
     float old;
     double SumInv; //-для красивого раскрашивания суммы при инверсии храним сумму расчетную после Post
     double PredMax;  //- Предупредительная граница
     double PredMin;  //- Предупредительная граница
     double AvarMax;  //- Аварийная граница
     double AvarMin;  //- Аварийная граница
     double FizMax;   //- Физическая граница
     double FizMin;    //- Физическая граница
     int IsEdit;       //- Признак редактирования
     };
   MAXMIN * TestMinMax;


   void __fastcall SetAccess(TAccess value);
   TBookmark __fastcall TestEditMid(TVirtualTable *tvtData,TBookmark tSavePlace, long mid);
   long isEditFeeders;
   void __fastcall vParamsEditFeeders();
   TAccess Access;  
public:		// User declarations
	__fastcall TfmManualInput(TComponent* Owner,AnsiString, long ttable,long rezerv, TAccess = accDenied);

protected:

   void __fastcall vSave(TObject* Sender);
   void __fastcall vRefresh(TObject* Sender);
   void __fastcall vCheck(TObject* Sender);
   void __fastcall vParams(TObject* Sender);


};
//---------------------------------------------------------------------------
#endif

