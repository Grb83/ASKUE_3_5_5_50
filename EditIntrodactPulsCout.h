//---------------------------------------------------------------------------
#ifndef EditIntrodactPulsCoutH
#define EditIntrodactPulsCoutH
//---------------------------------------------------------------------------
#include <Buttons.hpp>
#include <Classes.hpp>
#include <Controls.hpp>
#include <ExtCtrls.hpp>
#include <Grids.hpp>
#include <StdCtrls.hpp>
#include "DrawTable.h"
#include "Main.h"
#include <ActnList.hpp>
#include <ImgList.hpp>
#include <Menus.hpp>
#include "DBAccess.hpp"
#include "MemDS.hpp"
#include "Ora.hpp"
#include "OraSmart.hpp"
#include <DB.hpp>
#include "DBGridEh.hpp"
#include "unListCounter.h"
#include "VirtualTable.hpp"
//---------------------------------------------------------------------------
#define CountsListSize  512
//---------------------------------------------------------------------------
class TFormIntrodactPulsCount : public TMainForm
{
__published:	// IDE-managed Components
   TBitBtn *btParam;
  TSmartQuery *oqTree;
  TSmartQuery *oqSave;
  TDBGridEh *DBGridEh1;
  TDataSource *DS1;
  TVirtualTable *VT1;
  TStringField *VT1VName;
  TStringField *VT1date_count;
  TStringField *VT1MTRSN;
  TStringField *VT1DIGITS;
  TStringField *VT1MTYPE;
  TIntegerField *VT1MCURRENT;
  TIntegerField *VT1MPOWER;
  TIntegerField *VT1MYEAR;
  TIntegerField *VT1MQUARTER;
  TIntegerField *VT1MCONST;
  TStringField *VT1MCLASS;
  TStringField *VT1ID;
  TStringField *VT1MID;
  TStringField *VT1Position;
  TStringField *VT1Entype;
  TStringField *VT1Smart;
  TBooleanField *VT1Edited;
  void __fastcall FormCreate(TObject *Sender);
  void __fastcall VT1AfterEdit(TDataSet *DataSet);
  void __fastcall DBGridEh1KeyPress(TObject *Sender, char &Key);
  void __fastcall FormResize(TObject *Sender);
  void __fastcall FormShow(TObject *Sender);
        void __fastcall DBGridEh1Columns4EditButtons0Click(TObject *Sender,
          bool &Handled);
private:	// User declarations
   void __fastcall MainProc(TObject *Sender);
   int Mid;
   typedef struct smater{
      int Id;
      int Mid;
      char Name[148];
      int Position;
      int Entype;
      char SMART[4];	//VARCHAR2(1), признак интел. счетчика
      char MTRSN[20];		//
      char DATE_TIME[12];
      char DIGITS[20]; //рарядность
      char MTYPE[50];
      int MCURRENT;
      int MPOWER;
      int MCONST;
      char MCLASS[20];
      int MYEAR;
      int MQUARTER;
      bool editRecord;
   }MATER;

   unsigned long CountStr; // Количество строчек в результате запросаs
   MATER TreeTable[CountsListSize];
   void __fastcall ProvMask(AnsiString Str);
   void __fastcall SetAccess(TAccess value) {TMainForm::SetAccess(value);}
public:		// User declarations
   __fastcall TFormIntrodactPulsCount(TComponent* Owner, AnsiString, TAccess = accDenied);
protected:
   void __fastcall vSave(TObject* Sender);
   void __fastcall vRefresh(TObject* Sender);
   void __fastcall vParams(TObject* Sender);
};
//---------------------------------------------------------------------------
#endif
