//---------------------------------------------------------------------------

#ifndef unAddToTreeH
#define unAddToTreeH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <Buttons.hpp>
#include "unTree.h"
#include "DBAccess.hpp"
#include "MemDS.hpp"
#include "Ora.hpp"
#include <DB.hpp>
//---------------------------------------------------------------------------
class TfmAddToTree : public TForm
{
__published:	// IDE-managed Components
  TPanel *Panel1;
  TPanel *Panel2;
  TPanel *Panel3;
  TLabel *Label1;
  TRadioGroup *GrBtType;
  TPanel *Panel4;
  TPanel *Panel5;
  TLabel *Label2;
  TPanel *Panel6;
  TMemo *memContains;
  TPanel *Panel7;
  TLabel *Label3;
  TMemo *memNote;
  TPanel *Panel8;
  TBitBtn *btnAddOk;
  TBitBtn *btnAddCancel;
  TEdit *edAddName;
  TOraQuery *oqSaveFunc;
  void __fastcall GrBtTypeClick(TObject *Sender);
  void __fastcall btnAddOkClick(TObject *Sender);
  void __fastcall FormClose(TObject *Sender, TCloseAction &Action);
  void __fastcall FormCreate(TObject *Sender);
private:	// User declarations
    TfmTree::SFunction *vDate;
    bool BoxEnable;
public:		// User declarations
  __fastcall TfmAddToTree(TComponent* Owner, TfmTree::SFunction *vDate, bool enableBox);
};
//---------------------------------------------------------------------------
extern PACKAGE TfmAddToTree *fmAddToTree;
//---------------------------------------------------------------------------
#endif
