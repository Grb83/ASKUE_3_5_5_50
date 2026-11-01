//---------------------------------------------------------------------------

#ifndef unMeterParameterH
#define unMeterParameterH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "DBAccess.hpp"
#include "DBGridEh.hpp"
#include "MemDS.hpp"
#include "Ora.hpp"
#include "PrnDbgeh.hpp"
#include <Buttons.hpp>
#include <ComCtrls.hpp>
#include <DB.hpp>
#include <ExtCtrls.hpp>
#include <Grids.hpp>
#include <ImgList.hpp>
#include <ToolWin.hpp>
#include <Dialogs.hpp>
#include "unDataMod.h"
#include <DBCtrls.hpp>
//---------------------------------------------------------------------------
class TfmMeterParameter : public TForm
{
__published:	// IDE-managed Components
  TDBGridEh *grMain;
  TPanel *Panel10;
  TPanel *Panel1;
  TBitBtn *BitBtn1;
  TBitBtn *BitBtn2;
  TBitBtn *btSave;
  TPanel *Panel2;
  TToolBar *ToolBar1;
  TToolButton *btAdd;
  TToolButton *ToolButton10;
  TToolButton *ToolButton5;
  TToolButton *btClear;
  TToolButton *btDelete;
  TToolButton *ToolButton3;
  TToolButton *tbExport;
  TToolButton *tbPrint;
  TDataSource *dsMain;
  TImageList *ifMenu;
  TOraQuery *oqMain;
  TPrintDBGridEh *PrintMessageGrid;
  TToolButton *tbView;
  TDateTimeField *oqMainDDATE;
  TStringField *oqMainVFILENAME;
  TBlobField *oqMainBFILE;
  TStringField *oqMainVNOTE;
  TSaveDialog *SaveDialog1;
  TOpenDialog *OpenDialog1;
  TFloatField *oqMainMID;
  TPanel *Panel3;
  TLabel *Label1;
  TDataSource *dsDateParam;
  TOraQuery *oqDateParam;
  TLabel *Label2;
  void __fastcall tbPrintClick(TObject *Sender);
  void __fastcall vSave(TObject *Sender);
  void __fastcall vRead(long Mid,unsigned long Sort);
  void __fastcall vRefresh(TObject *Sender);
  void __fastcall vDelete(TObject *Sender);
  void __fastcall oqMainAfterEdit(TDataSet *DataSet);
  void __fastcall btClearClick(TObject *Sender);
  void __fastcall tbExportClick(TObject *Sender);
  void __fastcall BitBtn1Click(TObject *Sender);
  void __fastcall btAddClick(TObject *Sender);
  void __fastcall grMainKeyDown(TObject *Sender, WORD &Key,
          TShiftState Shift);
  void __fastcall oqMainAfterInsert(TDataSet *DataSet);
  void __fastcall grMainColumns1EditButtonClick(TObject *Sender,
          bool &Handled);
  void __fastcall tbViewClick(TObject *Sender);
  void __fastcall btSaveClick(TObject *Sender);

private:	// User declarations
public:		// User declarations
  __fastcall TfmMeterParameter(TComponent* Owner,long id, TAccess = accDenied);
  static bool __fastcall fmMeterParameterShow(TComponent* Owner,long id, TAccess a);
  long Mid;
};
//---------------------------------------------------------------------------
extern PACKAGE TfmMeterParameter *fmMeterParameter;
//---------------------------------------------------------------------------
#endif
