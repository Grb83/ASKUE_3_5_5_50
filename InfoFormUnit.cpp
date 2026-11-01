//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "InfoFormUnit.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TInfoForm *InfoForm = NULL;
//---------------------------------------------------------------------------
__fastcall TInfoForm::TInfoForm(TComponent* Owner)
  : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TInfoForm::PrintActionExecute(TObject *Sender)
{
  InfoREdit->Print("");  
}
//---------------------------------------------------------------------------
void __fastcall TInfoForm::CloseActionExecute(TObject *Sender)
{
  Close();  
}
//---------------------------------------------------------------------------
void __fastcall TInfoForm::FormCreate(TObject *Sender)
{
  InfoREdit->Lines->Clear();  
}
//---------------------------------------------------------------------------
void __fastcall TInfoForm::FormClose(TObject *Sender, TCloseAction &Action)
{
  Action    = caFree;
  InfoForm  = NULL;
}
//---------------------------------------------------------------------------
void __fastcall TInfoForm::FormKeyDown(TObject *Sender, WORD &Key,
      TShiftState Shift)
{
  if (Key == VK_ESCAPE)
  { Key = 0;
    Close();
  }
}
//---------------------------------------------------------------------------

