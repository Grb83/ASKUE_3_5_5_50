//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "unEditServName.h"
#include "unDataMod.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "DBAccess"
#pragma link "MemDS"
#pragma link "Ora"
#pragma resource "*.dfm"
TfmEditServName *fmEditServName;
//---------------------------------------------------------------------------
__fastcall TfmEditServName::TfmEditServName(TComponent* Owner, AnsiString ServName, long mmid)
  : TForm(Owner)
{
  NName = ServName;
  mid = mmid;
}
//---------------------------------------------------------------------------
void __fastcall TfmEditServName::FormShow(TObject *Sender)
{
  edServName->Text = NName;
}
//---------------------------------------------------------------------------
void __fastcall TfmEditServName::acOkExecute(TObject *Sender)
{
  if (edServName->Text == "")
  {
    MessageDlg("Поле имени не может быть пустым",
               mtError, TMsgDlgButtons() << mbOK, 0);
    return;
  }
  else
  {
    oqUpdateName->Close();

    oqUpdateName->ParamByName("mmid")->AsInteger = mid;
    oqUpdateName->ParamByName("NewName")->AsString = edServName->Text;

    oqUpdateName->Execute();
    oqUpdateName->Close();

    this->ModalResult = mrOk;
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmEditServName::acCancelExecute(TObject *Sender)
{
  this->ModalResult = mrCancel;
}
//---------------------------------------------------------------------------
