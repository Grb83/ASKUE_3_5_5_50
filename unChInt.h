//---------------------------------------------------------------------------
#ifndef unChIntH
#define unChIntH
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
#include "DBGridEh.hpp"
//------------------------------------------------------------------------------
struct strChIntr{ // Выбор данных пользователем
   TDateTime fromTime;
   TDateTime tillTime;
   int NetParam;
   int Journal;
   int NotReadCurr;
   //strChIntr():fromTime(TDateTime::CurrentTime()),tillTime(TDateTime::CurrentTime()){;}
   strChIntr():fromTime(0),tillTime(0),NetParam(0),Journal(0),NotReadCurr(0) {;}
   strChIntr& strChIntr::operator =(const strChIntr& a){
      fromTime = a.fromTime;
      tillTime = a.tillTime;
      NetParam=a.NetParam;
      Journal=a.Journal;
      NotReadCurr=a.NotReadCurr;
      return *this;
   }
};
typedef struct strChIntr ChIntr;
//---------------------------------------------------------------------------
class TfmChInter : public TForm
{
__published:	// IDE-managed Components
  TPanel *Panel1;
  TPanel *Panel2;
  TBitBtn *btOk;
  TBitBtn *btCancel;
  TDBNavigator *DBNavigator1;
  TDataSource *dsMain;
  TVirtualTable *VT_Data;
  TTimeField *VT_DataVT_SPeriod;
  TTimeField *VT_DataVT_FPeriod;
  TDBGridEh *grMain;
  TBooleanField *VT_DataVT_NNETPARAM;
  TBooleanField *VT_DataVT_NJOURNAL;
  TBooleanField *VT_DataVT_NNOTREADCURR;
  void __fastcall btOkClick(TObject *Sender);
  void __fastcall VT_DataNewRecord(TDataSet *DataSet);
private:	// User declarations
  TList *ls;
  bool fullacc;
  
public:		// User declarations
  __fastcall TfmChInter(TComponent* Owner,TList *ls,bool fullacc);
};
//---------------------------------------------------------------------------
extern PACKAGE TfmChInter *fmChInter;
//---------------------------------------------------------------------------
#endif
