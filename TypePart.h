//---------------------------------------------------------------------------
#ifndef TypePartH
#define TypePartH
//---------------------------------------------------------------------------
#include <ActnList.hpp>
#include <Buttons.hpp>
#include <Classes.hpp>
#include <Controls.hpp>
#include <ExtCtrls.hpp>
#include <Grids.hpp>
#include <StdCtrls.hpp>
#include <ImgList.hpp>
#include <Menus.hpp>
#include "DBAccess.hpp"
#include "DBGridEh.hpp"
#include "MemDS.hpp"
#include "Ora.hpp"
#include "PrnDbgeh.hpp"
#include <ComCtrls.hpp>
#include <DB.hpp>
#include <ToolWin.hpp>
//---------------------------------------------------------------------------
class TfmTypePart : public TForm
{
__published:	// IDE-managed Components
  TDataSource *dsMain;
  TImageList *ifMenu;
  TOraQuery *oqMain;
  TStringField *oqMainOWNAME;
  TDateTimeField *oqMainDSTART;
  TStringField *oqMainPNAME;
  TStringField *oqMainGNAME;
  TDateTimeField *oqMainDREGIME;
  TFloatField *oqMainNSHIFT;
  TFloatField *oqMainMID;
  TFloatField *oqMainOWMID;
  TFloatField *oqMainPMID;
  TFloatField *oqMainGID;
  TPrintDBGridEh *PrintMessageGrid;
  TDBGridEh *grMain;
  TPanel *Panel10;
  TPanel *Panel1;
  TBitBtn *BitBtn1;
  TBitBtn *BitBtn2;
  TPanel *Panel2;
  TToolBar *ToolBar1;
  TToolButton *btAdd;
  TToolButton *ToolButton10;
  TToolButton *ToolButton5;
  TToolButton *btClear;
  TToolButton *ToolButton1;
  TToolButton *ToolButton3;
  TToolButton *tbExport;
  TToolButton *tbPrint;
  TBitBtn *btSave;
  TToolButton *btClone;
  TOraQuery *oqSort;
  TFloatField *oqMainNTYPE;


  void __fastcall grNameColumns2EditButtonClick(TObject *Sender,
          bool &Handled);
  void __fastcall tbPrintClick(TObject *Sender);
  void __fastcall vSave(TObject *Sender);
  void __fastcall vRead(long Mid,unsigned long Sort);
  void __fastcall vRefresh(TObject *Sender);
  void __fastcall vDelete(TObject *Sender);
  void __fastcall grNameColumns3EditButtonClick(TObject *Sender,
          bool &Handled);
  void __fastcall oqMainAfterEdit(TDataSet *DataSet);
  void __fastcall btClearClick(TObject *Sender);
  void __fastcall grMainTitleClick(TColumnEh *Column);
  void __fastcall tbExportClick(TObject *Sender);
  void __fastcall BitBtn1Click(TObject *Sender);
  void __fastcall btAddClick(TObject *Sender);
  void __fastcall grMainEnter(TObject *Sender);
  void __fastcall grMainKeyDown(TObject *Sender, WORD &Key,
          TShiftState Shift);
  void __fastcall oqMainAfterInsert(TDataSet *DataSet);
  void __fastcall btCloneClick(TObject *Sender);
  void __fastcall oqMainAfterOpen(TDataSet *DataSet);

private:	// User declarations
  bool insertclone;
  AnsiString c_owname;
  AnsiString c_pname;
  AnsiString c_gname;
  int c_pmid;
  int c_gid;
  TDateTime c_dregime;
  int c_nshift;
  int c_ntype;


public:		// User declarations
 	__fastcall TfmTypePart(TComponent* Owner,long id);
  static bool __fastcall fmTypePartShow(TComponent* Owner,long id);
  long Mid;
  AnsiString Name;
 protected:


};
//---------------------------------------------------------------------------
#endif
