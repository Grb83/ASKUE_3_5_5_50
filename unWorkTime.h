//---------------------------------------------------------------------------
#ifndef unWorkTimeH
#define unWorkTimeH
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
//---------------------------------------------------------------------------
class TfmWorkTime : public TForm
{
__published:	// IDE-managed Components
  TPanel *Panel1;
  TPanel *Panel2;
  TBitBtn *btOk;
  TBitBtn *btCancel;
  TDBGrid *grMain;
  TDBNavigator *DBNavigator1;
  TDataSource *dsMain;
  void __fastcall btOkClick(TObject *Sender);
  void __fastcall FormDestroy(TObject *Sender);
private:	// User declarations
  TList *ls;
  bool fullacc;
  TVirtualTable *VT_Data;
  void __fastcall PeriodValidate(TField *Sender);
public:		// User declarations
  __fastcall TfmWorkTime(TComponent* Owner,TList *ls,bool fullacc);
};
//---------------------------------------------------------------------------
extern PACKAGE TfmWorkTime *fmWorkTime;
//---------------------------------------------------------------------------
#endif
