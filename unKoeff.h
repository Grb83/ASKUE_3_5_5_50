//---------------------------------------------------------------------------
#ifndef unKoeffH
#define unKoeffH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Buttons.hpp>
#include <ExtCtrls.hpp>
#include <DBGrids.hpp>
#include <Grids.hpp>
#include <DBCtrls.hpp>
#include <Db.hpp>
#include "VirtualTable.hpp"
#include <DB.hpp>
#include "DBAccess.hpp"
#include "MemDS.hpp"
#include "Ora.hpp"
#include "DBGridEh.hpp"
//---------------------------------------------------------------------------
class TfmKoeff : public TForm
{
__published:	// IDE-managed Components
  TPanel *Panel1;
  TPanel *Panel2;
  TBitBtn *btOk;
  TBitBtn *btCancel;
  TDBNavigator *DBNavigator1;
  TDataSource *dsMain;
  TOraQuery *oqData;
  TDBGridEh *grMain;
  void __fastcall btOkClick(TObject *Sender);
  void __fastcall oqDataAfterInsert(TDataSet *DataSet);
  void __fastcall dsMainDataChange(TObject *Sender, TField *Field);

private:	// User declarations

  int Mid;
  void __fastcall ReadData(int Mid);
  void __fastcall vSave(TObject *Sender);
public:		// User declarations
  __fastcall TfmKoeff(TComponent* Owner,long Mid,AnsiString Name,bool fullacc);
};
//---------------------------------------------------------------------------
extern PACKAGE TfmKoeff *fmKoeff;
//---------------------------------------------------------------------------
#endif
