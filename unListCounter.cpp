//---------------------------------------------------------------------------
#include <vcl.h>
#include <stdio.h>
#pragma hdrstop
#include "unListCounter.h"
#include "Main.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "DrawTable"
#pragma link "DBGridEh"
#pragma link "MemDS"
#pragma link "VirtualTable"
#pragma link "DBAccess"
#pragma link "Ora"
#pragma resource "*.dfm"
TfmListCounter *fmListCounter;
//---------------------------------------------------------------------------

__fastcall TfmListCounter::TfmListCounter(TComponent* Owner)
        : TForm(Owner)
{
  oqType->Close();
  oqType->Open();
  oqType->First();
  while (!oqType->Eof)
  {
    MTYPE_VALUE *t_val = new MTYPE_VALUE();
    t_val->DIGITS   = oqType->FieldByName("DIGITS")->AsString;
    lbList->Items->AddObject(oqType->FieldByName("VNAME")->AsString, (TObject*)t_val);
    t_val->MCURRENT = oqType->FieldByName("MCURRENT")->AsFloat;
    t_val->MPOWER   = oqType->FieldByName("MPOWER")->AsInteger;
    t_val->MCONST   = oqType->FieldByName("MCONST")->AsInteger;
    t_val->MCLASS   = oqType->FieldByName("MCLASS")->AsFloat;
    oqType->Next();
  }
}
//---------------------------------------------------------------------------

void __fastcall TfmListCounter::btCancelClick(TObject *Sender)
{
  ModalResult = mrCancel;
}
//---------------------------------------------------------------------------

void __fastcall TfmListCounter::FormShow(TObject *Sender)
{
  lbList->SetFocus();
}
//---------------------------------------------------------------------------

void __fastcall TfmListCounter::btOkClick(TObject *Sender)
{
  if(-1 == lbList->ItemIndex)
    MessageBox(Handle,  Reconst_smes137_1.c_str(), Application->Title.c_str(), MB_OK | MB_ICONWARNING);
  else
    ModalResult = mrOk;
}
//---------------------------------------------------------------------------

void __fastcall TfmListCounter::FormDestroy(TObject *Sender)
{
  for(int i =0; i < lbList->Items->Count; i++)
    delete (MTYPE_VALUE*) lbList->Items->Objects[i];
  lbList->Items->Clear();
}
//---------------------------------------------------------------------------

void __fastcall TfmListCounter::lbListKeyDown(TObject *Sender, WORD &Key,
      TShiftState Shift)
{
  if(Key == VK_RETURN)
    btOkClick(NULL);
}
//---------------------------------------------------------------------------

void __fastcall TfmListCounter::lbListDblClick(TObject *Sender)
{
  btOkClick(NULL);
}
//---------------------------------------------------------------------------

