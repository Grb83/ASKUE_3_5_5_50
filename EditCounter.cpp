//---------------------------------------------------------------------------
#include <vcl.h>
#include <stdio.h>
#pragma hdrstop
#include "EditCounter.h"
#include "Main.h"
#include "unRefCounter.h"
#include "unListCounter.h"
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
TFormCounter *FormCounter;
//---------------------------------------------------------------------------
__fastcall TFormCounter::TFormCounter(TComponent* Owner,TList *List_count,int Mid, AnsiString name)
        : TForm(Owner)
{
  this->Mid = Mid;
  this->List_count = List_count;
  Caption = Reconst_smes18_1+name;
  MainProc(this);
}
//---------------------------------------------------------------------------

void __fastcall TFormCounter::btCancelClick(TObject *Sender)
{
  editRecord=false;
  ModalResult=mrCancel;
}
//---------------------------------------------------------------------------

void __fastcall TFormCounter::MainProc(TObject *Sender)
{
  try{
      VT1->Open();
    for(int i=0;i<(int)List_count->Count;i++){

      POINTCOUNT *PCountTable=(POINTCOUNT *)List_count->Items[i];
       TreeTable[i]=*PCountTable;
      VT1->Append();
      VT1->Edit();
      VT1->Fields->FieldByName("VName")->AsString=PCountTable->Name;
      VT1->Fields->FieldByName("date_count")->AsDateTime=StrToDate(PCountTable->date_count);
      VT1->Fields->FieldByName("MTRSN")->AsString=PCountTable->MTRSN;
      VT1->Fields->FieldByName("DIGITS")->AsString=PCountTable->DIGITS;
      VT1->Fields->FieldByName("MTYPE")->AsString=PCountTable->MTYPE;
      VT1->Fields->FieldByName("MCURRENT")->AsFloat=PCountTable->MCURRENT;
      VT1->Fields->FieldByName("MPOWER")->AsInteger=PCountTable->MPOWER;
      VT1->Fields->FieldByName("MYEAR")->AsInteger=PCountTable->MYEAR;
      VT1->Fields->FieldByName("MQUARTER")->AsInteger=PCountTable->MQUARTER;
      VT1->Fields->FieldByName("MCONST")->AsInteger=PCountTable->MCONST;
      VT1->Fields->FieldByName("MCLASS")->AsFloat=PCountTable->MCLASS;
      VT1->Post();
     }
      VT1->First();
      DBGridEh1->ReadOnly=(Access==accRead)? true:false;
  }
  catch (Exception &e)
  {
     throw;
  }
}
//---------------------------------------------------------------------------

void __fastcall TFormCounter::FormShow(TObject *Sender)
{
  if(customer_id==1||Access==accRead||customer_id==51){ //Блокируем редактирование
     editRecord=false;

     btOk->Enabled = false;
    }
  DBGridEh1->SetFocus();
}
//---------------------------------------------------------------------------

void __fastcall TFormCounter::btSaveClick(TObject *Sender)
{

     int cn=0;
  try{
    if(VT1->State!=dsBrowse)
       VT1->Post();


    DS1->DataSet=NULL;
    VT1->First();
    while(!VT1->Eof){
      cn++;
      VT1->Next();
    }

    for(long i=0;i<List_count->Count;i++){

      POINTCOUNT *PCountTable=(POINTCOUNT *)List_count->Items[i];
      delete PCountTable;

      }
    List_count->Clear();
    List_count->Capacity=cn;
    VT1->First();
    int i=0;
    while(!VT1->Eof){
      POINTCOUNT *PCountTable=new POINTCOUNT;
      memcpy(PCountTable,&TreeTable[i],sizeof(POINTCOUNT));
      //GRB CHANGE 21.08.2020 - fix баг с дорисовкой строки другим полем - отсутствует нулл-терминейтед символ строки в конце - пробуем заменть strcpy на strncpy, и смотрим что если вылазит за фактический размер в базе отсекаем его и насильственно дописываем в конец буфера /0
      strcpy(PCountTable->Name,VT1->Fields->FieldByName("VName")->AsString.c_str());
      strcpy(PCountTable->date_count,(DateToStr(VT1->Fields->FieldByName("date_count")->AsDateTime)).c_str());
      if (strlen(VT1->Fields->FieldByName("MTRSN")->AsString.c_str())>20){
        strncpy(PCountTable->MTRSN,VT1->Fields->FieldByName("MTRSN")->AsString.c_str(),20);
        strcat(PCountTable->MTRSN,"\0");
      }else
      strcpy(PCountTable->MTRSN,VT1->Fields->FieldByName("MTRSN")->AsString.c_str());

      if (strlen(VT1->Fields->FieldByName("DIGITS")->AsString.c_str())>20){
        strncpy(PCountTable->DIGITS,VT1->Fields->FieldByName("DIGITS")->AsString.c_str(),20);
        strcat(PCountTable->DIGITS,"\0");
      }else
      strcpy(PCountTable->DIGITS,VT1->Fields->FieldByName("DIGITS")->AsString.c_str());

      if (strlen(VT1->Fields->FieldByName("MTYPE")->AsString.c_str())>50){
        strncpy(PCountTable->MTYPE,VT1->Fields->FieldByName("MTYPE")->AsString.c_str(),50);
        strcat(PCountTable->MTYPE,"\0");
      }else
      strcpy(PCountTable->MTYPE,VT1->Fields->FieldByName("MTYPE")->AsString.c_str());
      //END OF FIX
      PCountTable->MCURRENT=VT1->Fields->FieldByName("MCURRENT")->AsFloat;
      PCountTable->MPOWER=VT1->Fields->FieldByName("MPOWER")->AsInteger;
      PCountTable->MYEAR=VT1->Fields->FieldByName("MYEAR")->AsInteger;
      PCountTable->MQUARTER=VT1->Fields->FieldByName("MQUARTER")->AsInteger;
      PCountTable->MCONST=VT1->Fields->FieldByName("MCONST")->AsInteger;
      PCountTable->MCLASS=VT1->Fields->FieldByName("MCLASS")->AsFloat;
      List_count->Add(PCountTable);
      VT1->Next();
      i++;
       }
   DS1->DataSet=VT1;
  }catch(Exception &e){
    DS1->DataSet=VT1;
    throw;
  }

}
//---------------------------------------------------------------------------

void __fastcall TFormCounter::btOkClick(TObject *Sender)
{
  if(VT1->State!=dsBrowse){
      editRecord=true;
      btSaveClick(Sender);
      }

     else {
         editRecord=false;
         Close();
   }
   ModalResult=mrOk;
}
//---------------------------------------------------------------------------

void __fastcall TFormCounter::DS1DataChange(TObject *Sender, TField *Field)
{
  if(!VT1->FieldByName("MCURRENT")->IsNull)
  if (VT1->FieldByName("MCURRENT")->AsFloat<0)
        throw Exception(Reconst_smes18_2);
  if(!VT1->FieldByName("MPOWER")->IsNull)
  VT1->FieldByName("MPOWER")->OnValidate=Validate;
  if(!VT1->FieldByName("MQUARTER")->IsNull)
  if(VT1->FieldByName("MQUARTER")->AsFloat<0||VT1->FieldByName("MQUARTER")->AsFloat>4)
       throw Exception(Reconst_smes18_3);
  if(!VT1->FieldByName("MYEAR")->IsNull)
  if(VT1->FieldByName("MYEAR")->AsInteger<0||VT1->FieldByName("MYEAR")->AsInteger>2999)
         throw Exception(Reconst_smes18_3);
  if(!VT1->FieldByName("MCLASS")->IsNull)
     if(VT1->FieldByName("MCLASS")->AsFloat<0)
      throw Exception(Reconst_smes18_2);
  ProvMask(VT1->FieldByName("DIGITS")->AsString);
}
//---------------------------------------------------------------------------

 void __fastcall TFormCounter::Validate(TField *Sender)
{
   if(Sender->AsInteger<0)
      throw Exception(Reconst_smes18_2);
}
//-----------------------------------------------------------------------------------

void __fastcall TFormCounter::ProvMask(AnsiString Str)
{
  bool CanPoint=false;
  if(Str.Length()==0)
    return;
  for(int i=1; i<=Str.Length();i++){
    if((Str[i]=='9')||(CanPoint&&(Str[i]=='.'))){
      if((i>1)&&(Str[i]=='.'))
        CanPoint=false;
    }else
     throw(Exception(Reconst_smes18_7));
    if(i==1)
     CanPoint=true;
  }
}
//---------------------------------------------------------------------------
void __fastcall TFormCounter::SetAccess(TAccess value)
{
   if(FAccess != value) {
      bool wr = (FAccess = value)==accWrite;
      if(wr) return;
   }
}
//---------------------------------------------------------------------------

TAccess __fastcall TFormCounter::GetAccess()
{
   return FAccess;
}
//---------------------------------------------------------------------------

void __fastcall TFormCounter::DBGridEh1KeyPress(TObject *Sender, char &Key)
{
     if(Access==accRead){
      Beep();
      Key = NULL;
   }
}
//---------------------------------------------------------------------------

void __fastcall TFormCounter::DBGridEh1Columns4EditButtons0Click(
      TObject *Sender, bool &Handled)
{
  TfmListCounter *fmLC = new TfmListCounter(this);
  VT1->Edit();
  if(fmLC->ShowModal() == mrOk)
  {
    VT1->Edit();
    TfmListCounter::MTYPE_VALUE *t_Val = (TfmListCounter::MTYPE_VALUE*)fmLC->lbList->Items->Objects[fmLC->lbList->ItemIndex];
    VT1->FieldByName("MTYPE")->AsString = fmLC->lbList->Items->Strings[fmLC->lbList->ItemIndex];
    VT1->FieldByName("DIGITS")->AsString  = t_Val->DIGITS;
    VT1->FieldByName("MCURRENT")->AsFloat = t_Val->MCURRENT;
    VT1->FieldByName("MPOWER")->AsInteger = t_Val->MPOWER;
    VT1->FieldByName("MCONST")->AsInteger = t_Val->MCONST;
    VT1->FieldByName("MCLASS")->AsFloat = t_Val->MCLASS;
  }
  delete fmLC;
}
//---------------------------------------------------------------------------

void __fastcall TFormCounter::BitBtn1Click(TObject *Sender)
{
  TfmRefCounter *fmRC = new TfmRefCounter(this);
  fmRC->ShowModal();
  delete fmRC;
}
//---------------------------------------------------------------------------

