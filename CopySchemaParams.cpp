//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "CopySchemaParams.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TFormCopyShcema *FormCopyShcema;
//---------------------------------------------------------------------------
__fastcall TFormCopyShcema::TFormCopyShcema(TComponent* Owner)
    : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TFormCopyShcema::btOkClick(TObject *Sender)
{
    switch(MessageBox(this->Handle,
        Reconst_smes8_1.c_str(),
        this->Caption.c_str(), MB_YESNO|MB_ICONQUESTION))
    {
    case IDYES:
        break;
    case IDNO:
        ModalResult = mrNone;
        break;
    }
}
//---------------------------------------------------------------------------
