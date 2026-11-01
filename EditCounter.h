//---------------------------------------------------------------------------
#ifndef EditCounterH
#define EditCounterH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Buttons.hpp>
#include <ExtCtrls.hpp>
#include <Grids.hpp>
#include <Buttons.hpp>
#include "DBGridEh.hpp"
#include "MemDS.hpp"
#include "VirtualTable.hpp"
#include <DB.hpp>
#include "unDataMod.h"
#include "DBAccess.hpp"
#include "Ora.hpp"
//---------------------------------------------------------------------------
#define CountsListSize  512
//---------------------------------------------------------------------------
class TFormCounter : public TForm
{
__published:	// IDE-managed Components
    TPanel *Panel2;
    TPanel *Panel3;
    TBitBtn *btSave;
    TPanel *Panel4;
    TBitBtn *btOk;
    TBitBtn *btCancel;
  TDBGridEh *DBGridEh1;
  TVirtualTable *VT1;
  TDataSource *DS1;
  TStringField *VName;
  TStringField *MTRSN;
  TStringField *DIGITS;
  TStringField *MTYPE;
  TIntegerField *MPOWER;
  TIntegerField *MYEAR;
  TIntegerField *MQUARTER;
  TIntegerField *MCONST;
  TFloatField *MCURRENT;
  TDateField *date_count;
  TFloatField *MCLASS;
  TBitBtn *BitBtn1;
    void __fastcall btCancelClick(TObject *Sender);
    void __fastcall btSaveClick(TObject *Sender);
    void __fastcall btOkClick(TObject *Sender);
    void __fastcall FormShow(TObject *Sender);
    void __fastcall DS1DataChange(TObject *Sender, TField *Field);
  void __fastcall DBGridEh1KeyPress(TObject *Sender, char &Key);
  void __fastcall DBGridEh1Columns4EditButtons0Click(TObject *Sender,
          bool &Handled);
  void __fastcall BitBtn1Click(TObject *Sender);
public:

    struct POINTCOUNT{
        long mid;
        long id;
        //GRB ADD - Удваиваем данные
        char date_count[16];
        char Name[148];
        char MTRSN[21];
        char DIGITS[21];
        char MTYPE[51];
        int Entype;
        double MCURRENT;
        int Position;
        int MPOWER;
        int MCONST;
       // char MCLASS[20];
        double MCLASS;
        int MYEAR;
        int MQUARTER;
        POINTCOUNT(){ZeroMemory(this,sizeof(*this));}
    };
  static void __fastcall ProvMask(AnsiString Str);
private:	// User declarations
    POINTCOUNT TreeTable[CountsListSize];
    int Mid;
    TAccess FAccess;
    void __fastcall MainProc(TObject *Sender);
    void __fastcall SetAccess(TAccess value);
    TAccess __fastcall GetAccess();
    void __fastcall TFormCounter::Validate(TField *Sender);
public:		// User declarations
    __fastcall TFormCounter(TComponent* Owner,TList *List_count,int Mid, AnsiString name);
    TList *List_count;
    bool editRecord;
    __property TAccess Access  = { read=GetAccess, write=SetAccess };
};
//---------------------------------------------------------------------------
extern PACKAGE TFormCounter *FormCounter;
//---------------------------------------------------------------------------
#endif
