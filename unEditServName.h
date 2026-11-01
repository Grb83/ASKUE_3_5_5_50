//---------------------------------------------------------------------------

#ifndef unEditServNameH
#define unEditServNameH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Buttons.hpp>
#include <ExtCtrls.hpp>
#include "DBAccess.hpp"
#include "MemDS.hpp"
#include "Ora.hpp"
#include <DB.hpp>
#include <ActnList.hpp>
//---------------------------------------------------------------------------
class TfmEditServName : public TForm
{
__published:	// IDE-managed Components
  TPanel *Panel1;
  TPanel *Panel2;
  TBitBtn *btnOk;
  TBitBtn *btnCancel;
  TLabel *Label1;
  TEdit *edServName;
  TOraQuery *oqUpdateName;
  TActionList *Actions;
  TAction *acOk;
  TAction *acCancel;
  void __fastcall FormShow(TObject *Sender);
  void __fastcall acOkExecute(TObject *Sender);
  void __fastcall acCancelExecute(TObject *Sender);
private:	// User declarations
  AnsiString NName;
  long mid;
public:		// User declarations
  __fastcall TfmEditServName(TComponent* Owner, AnsiString ServName, long mmid);
};
//---------------------------------------------------------------------------
extern PACKAGE TfmEditServName *fmEditServName;
//---------------------------------------------------------------------------
#endif
