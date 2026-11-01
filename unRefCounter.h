//---------------------------------------------------------------------------

#ifndef unSysParamH
#define unSysParamH
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
//---------------------------------------------------------------------------
class TfmRefCounter : public TForm
{
__published:	// IDE-managed Components
  TDBGridEh *grMain;
  TPanel *Panel10;
  TPanel *Panel1;
  TBitBtn *btOk;
  TBitBtn *BitBtn2;
  TBitBtn *btSave;
  TPanel *Panel2;
  TToolBar *ToolBar1;
  TToolButton *ToolButton10;
  TToolButton *ToolButton5;
  TToolButton *tbExport;
  TToolButton *tbPrint;
  TDataSource *dsMain;
  TImageList *ifMenu;
  TOraQuery *oqMain;
  TPrintDBGridEh *PrintMessageGrid;
  TFloatField *oqMainNMETERTYPE;
  TStringField *oqMainVNAME;
  TFloatField *oqMainDIGITS;
  TFloatField *oqMainMCURRENT;
  TFloatField *oqMainMPOWER;
  TFloatField *oqMainMCONST;
  TFloatField *oqMainMCLASS;
  TToolButton *tbAdd;
  TToolButton *tbDel;
  void __fastcall vRefresh(TObject *Sender);
  void __fastcall vSave(TObject *Sender);
  void __fastcall btSaveClick(TObject *Sender);
  void __fastcall tbExportClick(TObject *Sender);
  void __fastcall tbPrintClick(TObject *Sender);
  void __fastcall grMainTitleBtnClick(TObject *Sender, int ACol,
          TColumnEh *Column);
  void __fastcall btOkClick(TObject *Sender);
  void __fastcall oqMainAfterEdit(TDataSet *DataSet);
  void __fastcall tbAddClick(TObject *Sender);
  void __fastcall tbDelClick(TObject *Sender);
  void __fastcall dsMainDataChange(TObject *Sender, TField *Field);
private:	// User declarations
public:		// User declarations
  __fastcall TfmRefCounter(TComponent* Owner);
  void vRead();
  void __fastcall SaveTable(TComponent* Owner,TDBGridEh *gr,AnsiString RepCaption);
};
//---------------------------------------------------------------------------
extern PACKAGE TfmRefCounter *fmRefCounter;
//---------------------------------------------------------------------------
#endif
