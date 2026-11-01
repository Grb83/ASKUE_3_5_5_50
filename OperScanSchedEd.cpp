//---------------------------------------------------------------------------
#include <vcl.h>
#include <math.h>
#pragma hdrstop
#include "OperScanSched.h"
#include "OperScanSchedEd.h"

#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TfmOperScanSchedEd *fmOperScanSchedEd;
//---------------------------------------------------------------------------
__fastcall TfmOperScanSchedEd::TfmOperScanSchedEd(TComponent* Owner)
  : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TfmOperScanSchedEd::CheckInteger(void)
{
  try{
    if(edPeriod->Text.ToInt()<=0)
      throw Exception("");
  }catch(Exception &e){
    throw Exception(Reconst_smes48_1);
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmOperScanSchedEd::CheckHBound(void)
{
  TDateTime prDT;
  try{
    prDT=StrToTime( MEdEnd->Text + ":00" );
  }
  catch(Exception &exception){
    throw Exception(Reconst_smes48_2);
  }
  TDateTime prNow = Now();
  if(!(prDT - floor( prDT )>prNow - floor( prNow )))
    throw Exception(Reconst_smes48_3);
}
//---------------------------------------------------------------------------
void __fastcall TfmOperScanSchedEd::btOkClick(TObject *Sender)
{
  CheckHBound();
  CheckInteger();
  ModalResult=mrOk;
}
//---------------------------------------------------------------------------
void __fastcall TfmOperScanSchedEd::edLongPress(TObject *Sender, char &Key)
{
#define Sender ((TEdit*)Sender)
  AnsiString S=(AnsiString)Key;
  AnsiString S1="0123456789\b\r";
  if(!S1.Pos(S)){
    Key=NULL;
    Beep();
    return;
  }
#undef Sender
}
//---------------------------------------------------------------------------

