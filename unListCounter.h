//---------------------------------------------------------------------------
#ifndef unListCounterH
#define unListCounterH
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
//---------------------------------------------------------------------------
class TfmListCounter : public TForm
{
__published:	// IDE-managed Components
    TPanel *Panel2;
    TPanel *Panel4;
    TBitBtn *btOk;
    TBitBtn *btCancel;
  TOraQuery *oqType;
  TFloatField *oqTypeNMETERTYPE;
  TStringField *oqTypeVNAME;
  TFloatField *oqTypeDIGITS;
  TFloatField *oqTypeMCURRENT;
  TFloatField *oqTypeMPOWER;
  TFloatField *oqTypeMCONST;
  TFloatField *oqTypeMCLASS;
  TListBox *lbList;
  void __fastcall btCancelClick(TObject *Sender);
  void __fastcall btOkClick(TObject *Sender);
  void __fastcall FormShow(TObject *Sender);
  void __fastcall FormDestroy(TObject *Sender);
  void __fastcall lbListKeyDown(TObject *Sender, WORD &Key,
          TShiftState Shift);
  void __fastcall lbListDblClick(TObject *Sender);

public:
  struct MTYPE_VALUE
  {
      AnsiString DIGITS;
      float MCURRENT, MCLASS;
      int MPOWER, MCONST;
      MTYPE_VALUE(){ZeroMemory(this,sizeof(*this));}
  };
private:	// User declarations
public:		// User declarations
    __fastcall TfmListCounter(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfmListCounter *fmListCounter;
//---------------------------------------------------------------------------
#endif
