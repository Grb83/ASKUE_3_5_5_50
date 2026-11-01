//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "GetSelectDateTime.h"
#include <Math.hpp>
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TfmGetSelectDateTime *fmGetSelectDateTime;
//---------------------------------------------------------------------------
__fastcall TfmGetSelectDateTime::TfmGetSelectDateTime(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TfmGetSelectDateTime::SetDateTime(TDateTime value)
{
        if(FDateTime != value)
        {
                FDateTime = value;
                dtpDate->Date = FDateTime;
                dtpTime->Time = FDateTime;
        }
}
//---------------------------------------------------------------------------

TDateTime __fastcall TfmGetSelectDateTime::GetDateTime()
{
        FDateTime = (double)(Floor(dtpDate->Date) + dtpTime->Time - Floor(dtpTime->Time));
        return FDateTime;
}
//---------------------------------------------------------------------------

void __fastcall TfmGetSelectDateTime::FormKeyDown(TObject *Sender,
      WORD &Key, TShiftState Shift)
{
    if(Key == VK_RETURN)
    {
       ModalResult = mrOk;
    }
    if(Key == VK_ESCAPE)
    {
       ModalResult = mrCancel;
    }

}
//---------------------------------------------------------------------------
 
void __fastcall TfmGetSelectDateTime::edYearKeyPress(TObject *Sender,
      char &Key)
{
 AnsiString S=(AnsiString)Key;
 AnsiString S1="0123456789\b\r";
  if(!S1.Pos(S)){
    Key=NULL;
    Beep();
    return;
    }
 }
//---------------------------------------------------------------------------


void __fastcall TfmGetSelectDateTime::edYearExit(TObject *Sender)
{
  if(plSupMain->Visible){

    if(edYear->Text.Length()<4)
    {
        Application->MessageBox(Reconst_smes34_1.c_str(), Application->Title.c_str(), MB_OK|MB_ICONSTOP);
        ActiveControl = edYear;
    }
   }
}
//---------------------------------------------------------------------------

