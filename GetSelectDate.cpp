//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "GetSelectDate.h"
#include <Math.hpp>
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TfmGetSelectDate *fmGetSelectDate;
//---------------------------------------------------------------------------
__fastcall TfmGetSelectDate::TfmGetSelectDate(TComponent* Owner)
        : TForm(Owner)
{
        FDateTime = Now()-1;
        dtpDate->DateTime = FDateTime;

}
__fastcall TfmGetSelectDate:: TfmGetSelectDate(TComponent* Owner, AnsiString pageDate): TForm(Owner){
        FDateTime = Now()-1;
        dtpDate->DateTime = FDateTime;
        CurrDate->Text = pageDate;
}

//---------------------------------------------------------------------------
void __fastcall TfmGetSelectDate::SetDateTime(TDateTime value)
{
        if(FDateTime != value)
        {
                FDateTime = value;
                dtpDate->Date = FDateTime;
        }
}
//---------------------------------------------------------------------------

TDateTime __fastcall TfmGetSelectDate::GetDateTime()
{
        FDateTime = (double)(Floor(dtpDate->Date));
        return FDateTime;
}
//---------------------------------------------------------------------------

 