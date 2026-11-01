//---------------------------------------------------------------------------
#ifndef unCalcParamH
#define unCalcParamH
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
#include "MemDS.hpp"
//---------------------------------------------------------------------------
class TfmCalcParam : public TForm
{
__published:	// IDE-managed Components
  TPanel *Panel1;
  TPanel *Panel2;
  TBitBtn *btOk;
  TBitBtn *btCancel;
  TDBGrid *grMain;
  TDBNavigator *DBNavigator1;
  TDataSource *dsMain;
  TVirtualTable *VT_Data;
  TDateField *VT_DataNPERIOD;
  TFloatField *VT_DataNWH;
  TFloatField *VT_DataNFH;
  TFloatField *VT_DataNKC;
  void __fastcall btOkClick(TObject *Sender);
  void __fastcall VT_DataNewRecord(TDataSet *DataSet);
private:	// User declarations
  TList *ls;
  bool fullacc;
  void __fastcall PeriodValidate(TField *Sender);
public:		// User declarations
  __fastcall TfmCalcParam(TComponent* Owner,TList *ls,bool fullacc);
};
//---------------------------------------------------------------------------
extern PACKAGE TfmCalcParam *fmCalcParam;
//---------------------------------------------------------------------------
#endif
