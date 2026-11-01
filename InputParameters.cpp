//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "InputParameters.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TFormInputParameters *FormInputParameters;
//---------------------------------------------------------------------------
__fastcall TFormInputParameters::TFormInputParameters(TComponent* Owner)
    : TForm(Owner)
{
    meDate->Cells[0][0] = (TDateTime::CurrentDate()-1).FormatString("dd.mm.yyyy")+" 00:00";
}
//---------------------------------------------------------------------------

void __fastcall TFormInputParameters::meDateGetEditMask(TObject *Sender,
      int ACol, int ARow, AnsiString &Value)
{
    Value = "!99/99/0000 90:00;1;_";
}
//---------------------------------------------------------------------------

