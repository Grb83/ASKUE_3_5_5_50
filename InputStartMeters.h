//---------------------------------------------------------------------------

#ifndef InputStartMetersH
#define InputStartMetersH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Vit_Meter.h"
#include "Main.h"
#include <ActnList.hpp>
#include <Buttons.hpp>
#include <ExtCtrls.hpp>
#include <ImgList.hpp>
#include <Menus.hpp>
#include "DBAccess.hpp"
#include "DBGridEh.hpp"
#include "MemDS.hpp"
#include "Ora.hpp"
#include "VirtualTable.hpp"
#include <DB.hpp>
#include <Grids.hpp>
//---------------------------------------------------------------------------
class TfmInputStartMeters : public TMainForm
{
__published:	// IDE-managed Components
  TBitBtn *btParam;
  TPanel *Panel1;
  TDBGridEh *dbManInput;
  TVirtualTable *vtData;
  TOraDataSource *dsData;
  TOraQuery *oqData;
  TIntegerField *vtDatamid;
  TStringField *vtDataname;
  TStringField *vtDatamtrsn;
  TIntegerField *vtDataKC;
  TFloatField *vtDataem;
  TFloatField *vtDatae;
  TDateField *vtDataddate;
  TTimeField *vtDatadtime;
  TFloatField *vtDatamconst;
  TBitBtn *bbTest;
  TOraQuery *oqSave;
  TIntegerField *vtDataIsEdit;
  TOraQuery *oqTest;
  void __fastcall FormCreate(TObject *Sender);
  void __fastcall vtDataAfterPost(TDataSet *DataSet);
  void __fastcall bbTestClick(TObject *Sender);
private:	// User declarations
  POINTDATAFORM pointPOL;
  int RowCount;
   void __fastcall ReadData();
public:		// User declarations
  __fastcall TfmInputStartMeters(TComponent* Owner,AnsiString Name, TAccess acc);
protected:
   void __fastcall vSave(TObject* Sender);
   void __fastcall vRefresh(TObject* Sender);
   void __fastcall vCheck(TObject* Sender);
   void __fastcall vParams(TObject* Sender);
};
//---------------------------------------------------------------------------
extern PACKAGE TfmInputStartMeters *fmInputStartMeters;
//---------------------------------------------------------------------------
#endif
