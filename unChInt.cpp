//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#include "ASKUETypes.h"
#include "unChInt.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "MemDS"
#pragma link "DBGridEh"
#pragma resource "*.dfm"
TfmChInter *fmChInter;

//---------------------------------------------------------------------------
__fastcall TfmChInter::TfmChInter(TComponent* Owner,TList *ls,bool fullacc)
  : TForm(Owner)
{
  this->ls=ls;
  this->fullacc=fullacc;
  VT_Data->Open();

 /* if  (ls->Count==0){
   VT_Data->Edit();
   VT_Data->FieldByName("VT_NNETPARAM")->Value=0;
   VT_Data->FieldByName("VT_NJOURNAL")->Value=0;
   VT_Data->FieldByName("VT_NNOTREADCURR")->Value=0;
  }  */

  for(int j=0;j<ls->Count;j++){

  ChIntr *p=(ChIntr *)ls->Items[j];
   VT_Data->Append();
 // if ((int)p->fromTime>0)
  VT_Data->FieldByName("VT_SPeriod")->Value=(double)p->fromTime;
 // if ((int)p->tillTime>0)
  VT_Data->FieldByName("VT_FPeriod")->Value=(double)p->tillTime;
  VT_Data->FieldByName("VT_NNETPARAM")->Value=p->NetParam;
  VT_Data->FieldByName("VT_NJOURNAL")->Value=p->Journal;
  VT_Data->FieldByName("VT_NNOTREADCURR")->Value=p->NotReadCurr;
  VT_Data->Post();
  }
  VT_Data->First();


 
  grMain->ReadOnly=!fullacc;
  btOk->Enabled=fullacc;
  DBNavigator1->Enabled=fullacc;
}
//---------------------------------------------------------------------------
void __fastcall TfmChInter::btOkClick(TObject *Sender)
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
      delete (ChIntr *)ls->Items[i];
     // delete (TTimeInfo *)ls->Items[i];
    ls->Clear();
    ls->Capacity=cn;
    VT_Data->First();
    while(!VT_Data->Eof){
     // TTimeInfo *p= new TTimeInfo;
      ChIntr *p=new ChIntr;
      p->fromTime=VT_Data->FieldByName("VT_SPeriod")->AsDateTime;
      p->tillTime=VT_Data->FieldByName("VT_FPeriod")->AsDateTime;
      if(!VT_Data->FieldByName("VT_NNETPARAM")->IsNull)
        p->NetParam=VT_Data->FieldByName("VT_NNETPARAM")->AsBoolean==true?1:0;
      else
        p->NetParam=1;
      if(!VT_Data->FieldByName("VT_NJOURNAL")->IsNull)
       p->Journal=VT_Data->FieldByName("VT_NJOURNAL")->AsBoolean==true?1:0;
      else
        p->Journal=1;
      if(!VT_Data->FieldByName("VT_NNOTREADCURR")->IsNull)
      p->NotReadCurr=VT_Data->FieldByName("VT_NNOTREADCURR")->AsBoolean==true?1:0;
      else
      p->NotReadCurr=1;
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




void __fastcall TfmChInter::VT_DataNewRecord(TDataSet *DataSet)
{
  VT_Data->FieldByName("VT_NNETPARAM")->Value=0;
  VT_Data->FieldByName("VT_NJOURNAL")->Value=0;
  VT_Data->FieldByName("VT_NNOTREADCURR")->Value=0;
}
//---------------------------------------------------------------------------

