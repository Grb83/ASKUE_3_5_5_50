//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#include "ASKUETypes.h"
#include "unCalcParam.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "MemDS"
#pragma resource "*.dfm"
TfmCalcParam *fmCalcParam;
//---------------------------------------------------------------------------
__fastcall TfmCalcParam::TfmCalcParam(TComponent* Owner,TList *ls,bool fullacc)
  : TForm(Owner)
{
  this->ls=ls;
  this->fullacc=fullacc;
  VT_Data->Open();
  for(int j=0;j<ls->Count;j++){
    TTimeInfo *p=(TTimeInfo *)ls->Items[j];
    VT_Data->Append();
    VT_Data->FieldByName("NPERIOD")->Value=TDateTime(p->nperiod/10000,(p->nperiod/100)%100,p->nperiod%100);
    if(p->indic[0]>-1)
      VT_Data->FieldByName("NWH")->Value=p->f1;
    if(p->indic[1]>-1)
      VT_Data->FieldByName("NFH")->Value=p->f2;
    if(p->indic[2]>-1)
      VT_Data->FieldByName("NKC")->Value=p->f3;
    VT_Data->Post();
  }
  VT_Data->First();
  VT_Data->FieldByName("NPERIOD")->OnValidate=PeriodValidate;
  grMain->ReadOnly=!fullacc;
  btOk->Enabled=fullacc;
  DBNavigator1->Enabled=fullacc;
}
//---------------------------------------------------------------------------
void __fastcall TfmCalcParam::btOkClick(TObject *Sender)
{
  int cn=0;
  try{
    if(VT_Data->State!=dsBrowse)
      VT_Data->Post();
    dsMain->DataSet=NULL;
    VT_Data->First();
    while(!VT_Data->Eof){
      cn++;
      VT_Data->Next();
    }
    for(long i=0;i<ls->Count;i++)
      delete (TTimeInfo *)ls->Items[i];
    ls->Clear();
    ls->Capacity=cn;
    VT_Data->First();
    while(!VT_Data->Eof){
      TTimeInfo *p= new TTimeInfo;
      p->nperiod=VT_Data->FieldByName("NPERIOD")->AsDateTime.FormatString("yyyymmdd").ToInt();
      p->f1= VT_Data->FieldByName("NWH")->AsFloat;
      p->f2=VT_Data->FieldByName("NFH")->AsFloat;
      p->f3=VT_Data->FieldByName("NKC")->AsFloat;
      p->indic[0]=(VT_Data->FieldByName("NWH")->IsNull)?-1:0;
      p->indic[1]=(VT_Data->FieldByName("NFH")->IsNull)?-1:0;
      p->indic[2]=(VT_Data->FieldByName("NKC")->IsNull)?-1:0;
      ls->Add(p);
      VT_Data->Next();
    }
   dsMain->DataSet=VT_Data;
    ModalResult=mrOk;
  }catch(Exception &e){
    dsMain->DataSet=VT_Data;
    throw;
  }
}

//---------------------------------------------------------------------------
void __fastcall TfmCalcParam::PeriodValidate(TField *Sender)
{
  if(Sender->IsNull)
    throw Exception(Reconst_smes67_1);
  if(Sender->AsDateTime.FormatString("yyyymmdd").ToInt()<19900000)
    throw Exception(Reconst_smes67_2);
}
 //---------------------------------------------------------------------------
void __fastcall TfmCalcParam::VT_DataNewRecord(TDataSet *DataSet)
{
  VT_Data->FieldByName("NKC")->Value=1;
}
//---------------------------------------------------------------------------

