//---------------------------------------------------------------------------
#ifndef unGuidH
#define unGuidH
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
class TfmGuid : public TForm
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
  TDBGridEh *grMain;
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
  TOraQuery *oqMeas;
  TToolButton *btGuid;
  TToolButton *ToolButton2;
  TOraQuery *oqSave;
  TStringField *oqMeasVNAME;
  TStringField *oqMeasMRID;
  TFloatField *oqMeasNMEASURE;
  TFloatField *oqMeasMID;
  void __fastcall tbPrintClick(TObject *Sender);
  void __fastcall vSave(TObject *Sender);
  bool __fastcall vRead(void);
  void __fastcall vRefresh(TObject *Sender);
  void __fastcall tbExportClick(TObject *Sender);
  void __fastcall btOkClick(TObject *Sender);
  void __fastcall oqMeasAfterEdit(TDataSet *DataSet);
  void __fastcall btGuidsClick(TObject *Sender);
private:	// User declarations
  long id;
  long type;
//  AnsiString Name;
public:		// User declarations
 	__fastcall TfmGuid(TComponent* Owner,long id,long type,AnsiString Name);
  static bool __fastcall fmGuidShow(TComponent* Owner,long id,long type,AnsiString Name);
};
//---------------------------------------------------------------------------
#endif
