//---------------------------------------------------------------------------
#ifndef unSpecParamH
#define unSpecParamH
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
#include <Dialogs.hpp>
//---------------------------------------------------------------------------
class TfmSpecParam : public TForm
{
__published:	// IDE-managed Components
  TDataSource *dsMain;
  TImageList *ifMenu;
  TPrintDBGridEh *PrintMessageGrid;
  TPanel *Panel10;
  TPanel *Panel1;
  TBitBtn *btOk;
  TBitBtn *BitBtn2;
  TPanel *Panel2;
  TToolBar *ToolBar1;
  TToolButton *ToolButton10;
  TToolButton *ToolButton5;
  TToolButton *tbExport;
  TToolButton *tbPrint;
  TBitBtn *btSave;
  TOraQuery *oqMain;
  TFloatField *oqMainNSORT;
  TStringField *oqMainVDESCR;
  TStringField *oqMainVVALUE;
  TDBGridEh *grMain;
  TFloatField *oqMainMID;
  TActionList *alDefault;
  TAction *iaPoints;
  TAction *iaSave;
  TAction *iaRefresh;
  TAction *iaCheck;
  TAction *iaNew;
  TAction *iaDelete;
  TAction *iaParams;
  TAction *iaClose;
  TAction *iaCutSAA;
  TAction *iaCopySAA;
  TAction *iaPasteSAA;
  TAction *iaDeleteSAA;
  TAction *iaSelectSAA;
  TAction *iaBlock;
  TAction *iaUnblock;
  TAction *iaReceipt;
  TAction *iaClone;
  TAction *iaFind;
  TAction *iaFindAgain;
  TAction *aMLeft;
  TAction *aMRigth;
  TAction *aMUp;
  TAction *aMDown;
  TAction *iaMon;
  TAction *iaFilter;
  TAction *aBlocking;
  TAction *aDataAbsence;
  TFloatField *oqMainNTYPE;
  TOpenDialog *OpenDialog1;
  TOraQuery *oqSaveLob;
  TOraQuery *oqCaption;
  TFloatField *oqMainOBJTYPE;
  TToolButton *tbClear;
  TToolButton *ToolButton2;
  void __fastcall tbPrintClick(TObject *Sender);
  void __fastcall vSave(TObject *Sender);
  bool __fastcall vRead(void);
  void __fastcall vRefresh(TObject *Sender);
  void __fastcall oqMainAfterEdit(TDataSet *DataSet);
  void __fastcall tbExportClick(TObject *Sender);
  void __fastcall btOkClick(TObject *Sender);
  void __fastcall btSaveClick(TObject *Sender);
  void __fastcall grMainCellClick(TColumnEh *Column);
  void __fastcall grMainEditButtonClick(TObject *Sender);
  void __fastcall oqMainBeforeUpdateExecute(TDataSet *Sender,
          TStatementTypes StatementTypes, TDAParams *Params);
  void __fastcall tbClearClick(TObject *Sender);
  void __fastcall oqMainAfterScroll(TDataSet *DataSet);
private:	// User declarations
  long id;
  long ltype;
  long ltable;
  AnsiString Name;
public:		// User declarations
 	__fastcall TfmSpecParam(TComponent* Owner,long id, long ltype, long ltable);
  static bool __fastcall fmSpecParamShow(TComponent* Owner,long id, long ltype, long ltable=1);
};
//---------------------------------------------------------------------------
#endif
