//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#include "ASKUETypes.h"
#include "unWorkTime.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TfmWorkTime *fmWorkTime;
//---------------------------------------------------------------------------
__fastcall TfmWorkTime::TfmWorkTime(TComponent* Owner,TList *ls,bool fullacc)
  : TForm(Owner)
{
  this->ls      = ls;
  this->fullacc = fullacc;
  TFieldDef *pNewDef;
  VT_Data = new TVirtualTable(this);

  pNewDef = VT_Data->FieldDefs->AddFieldDef();
  pNewDef->Name     = "NPERIOD";
  pNewDef->DataType = ftInteger;

  pNewDef = VT_Data->FieldDefs->AddFieldDef();
  pNewDef->Name     = "NWH";
  pNewDef->DataType = ftFloat;

  pNewDef = VT_Data->FieldDefs->AddFieldDef();
  pNewDef->Name     = "NFH";
  pNewDef->DataType = ftFloat;

  dsMain->DataSet=VT_Data;
  grMain->Columns->Items[0]->FieldName  = "NPERIOD";
  grMain->Columns->Items[1]->FieldName  = "NWH";
  grMain->Columns->Items[2]->FieldName  = "NFH";

  VT_Data->Open();
  VT_Data->FieldByName("NPERIOD")->DisplayLabel = Reconst_smes77_1;
  VT_Data->FieldByName("NWH")->DisplayLabel     = Reconst_smes77_2;
  VT_Data->FieldByName("NFH")->DisplayLabel     = Reconst_smes77_3;

  for (int j = 0; j < ls->Count; j++)
  { TTimeInfo *p  = (TTimeInfo *)ls->Items[j];
    VT_Data->Append();
    VT_Data->FieldByName("NPERIOD")->Value  = p->nperiod;
    if (p->indic[0] >- 1)
      VT_Data->FieldByName("NWH")->Value  = p->f1;
    if (p->indic[1] >- 1)
      VT_Data->FieldByName("NFH")->Value  = p->f2;
    VT_Data->Post();
  }
  VT_Data->First();
  VT_Data->FieldByName("NPERIOD")->OnValidate = PeriodValidate;
  grMain->ReadOnly      = !fullacc;
  btOk->Enabled         = fullacc;
  DBNavigator1->Enabled = fullacc;
}
//---------------------------------------------------------------------------
void __fastcall TfmWorkTime::btOkClick(TObject *Sender)
{
  int cn  = 0;
  try
  { if (VT_Data->State != dsBrowse)
      VT_Data->Post();
    dsMain->DataSet = NULL;
    VT_Data->First();
    while (!VT_Data->Eof)
    { cn++;
      if (VT_Data->FieldByName("NWH")->AsFloat > VT_Data->FieldByName("NFH")->AsFloat)
        throw Exception(Reconst_smes77_4);
      VT_Data->Next();
    }
    for (long i = 0; i < ls->Count; i++)
      delete  (TTimeInfo *)ls->Items[i];
    ls->Clear();
    ls->Capacity  = cn;
    VT_Data->First();
    while (!VT_Data->Eof)
    { TTimeInfo *p  = new TTimeInfo;
      p->nperiod  = VT_Data->FieldByName("NPERIOD")->AsInteger;
      p->f1       = VT_Data->FieldByName("NWH")->AsFloat;
      p->f2       = VT_Data->FieldByName("NFH")->AsFloat;
      p->indic[0] = (VT_Data->FieldByName("NWH")->IsNull) ? -1 : 0;
      p->indic[1] = (VT_Data->FieldByName("NFH")->IsNull) ? -1 : 0;
      ls->Add(p);
      VT_Data->Next();
    }
    dsMain->DataSet = VT_Data;
    ModalResult = mrOk;
  }
  catch (Exception &e)
  { Application->ShowException(&e);
    dsMain->DataSet = VT_Data;
    VT_Data->RecNo  = cn;
    VT_Data->FieldByName("NWH")->FocusControl();
    ModalResult     = mrNone;
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmWorkTime::FormDestroy(TObject *Sender)
{
  delete  VT_Data;
}
//---------------------------------------------------------------------------
void __fastcall TfmWorkTime::PeriodValidate(TField *Sender)
{
  try
  { if (Sender->IsNull)
      throw Exception(Reconst_smes77_5);
    int i = Sender->AsInteger;
    int k = i % 100;
    if (!(i > 190001 && i < 290001 && k > 0 && k < 13))
      throw Exception(Reconst_smes77_6);
  }
  catch (Exception &e)
  { Application->ShowException(&e);
  }
}
 //---------------------------------------------------------------------------

