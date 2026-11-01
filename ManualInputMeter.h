//---------------------------------------------------------------------------
#ifndef ManualInputMeterH
#define ManualInputMeterH
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
//---------------------------------------------------------------------------
#define WM_SELECTCELL (WM_USER+100)
#define MAXINPUT	5000
//---------------------------------------------------------------------------
class TfmManualInputMeter : public TMainForm
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
  TOraQuery *oqReadRow;
  TDataSource *dsReadRow;
  TOraQuery *oqReadData;
  TVirtualTable *vtData;
  TOraQuery *oqSave;
  TOraQuery *oqMaxValue;
  TFloatField *vtDatamid;
  TStringField *vtDataname;
  TStringField *vtDatatype;
  TStringField *vtDatamtrsn;
  TIntegerField *vtDatakc;
  TFloatField *vtDatalastind;
  TFloatField *vtDataem;
  TFloatField *vtDatae;
  TFloatField *vtDatadigits;
  TPrintDBGridEh *PrintGrid;
  TIntegerField *vtDatanmeasure;
  TFloatField *vtDatapredmin;
  TFloatField *vtDatapredmax;
  TFloatField *vtDataavarmin;
  TFloatField *vtDataavarmax;
  TFloatField *vtDatafizmin;
  TFloatField *vtDatafizmax;
  TDateTimeField *vtDatalastd;
  TDateTimeField *vtDatanextd;
  TFloatField *vtDatanextind;
  TPanel *Panel1;
  TPanel *Panel3;
  TLabel *Label1;
  TComboBox *ComboBox1;
  TOraQuery *setTimeShift;
	void __fastcall FormCreate(TObject *Sender);
  void __fastcall iaRefreshExecute(TObject *Sender);
  void __fastcall tbPrintClick(TObject *Sender);
  void __fastcall iaCloseExecute(TObject *Sender);
  void __fastcall vtDataemValidate(TField *Sender);
  void __fastcall dbManInputColEnter(TObject *Sender);

private:	// User declarations
   void __fastcall ReadData();
   void __fastcall vParamsEditFeeders();
    TFormManualInTree *f;
   POINTDATA p;
   int ColCount;
   int RowCount;
   int TCount;
   AnsiString NameGroup;
   long ttable;
   float OldValue;
   int isEditFeeders;
   int nmid;
   TAccess Access;
public:		// User declarations
	__fastcall TfmManualInputMeter(TComponent* Owner,AnsiString, long ttable,long rezerv, TAccess = accDenied);

protected:

   void __fastcall vSave(TObject* Sender);
   void __fastcall vRefresh(TObject* Sender);
   void __fastcall vParams(TObject* Sender);

};
//---------------------------------------------------------------------------
#endif

