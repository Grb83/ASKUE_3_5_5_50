//---------------------------------------------------------------------------
#include <vcl.h>
#include <stdio.h>
#include "selectpoint.h"
#pragma hdrstop
#include "EditIntrodactPulsCout.h"
#include "Reconst.hpp"
#include "unDataMod.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "DrawTable"
#pragma link "DBAccess"
#pragma link "MemDS"
#pragma link "Ora"
#pragma link "OraSmart"
#pragma link "DBGridEh"
#pragma link "VirtualTable"
#pragma resource "*.dfm"
//---------------------------------------------------------------------------
__fastcall TFormIntrodactPulsCount::TFormIntrodactPulsCount(TComponent* Owner, AnsiString Name, TAccess a)
	: TMainForm(Owner, Name, a)
{
   ShowAction(iaParams);
}
//---------------------------------------------------------------------------
void __fastcall TFormIntrodactPulsCount::FormCreate(TObject *Sender)
{
	vParams(NULL);
}
//---------------------------------------------------------------------------

void __fastcall TFormIntrodactPulsCount::MainProc(TObject *Sender)
{
   try{
    EditRec=false;

    oqTree->ParamByName("top")->AsInteger = Mid;
    oqTree->Execute();

    VT1->DisableControls();
    VT1->Clear();
    VT1->Open();

    oqTree->First();
    while (!oqTree->Eof)
    {
      VT1->Append();
      VT1->FieldByName("ID")->AsInteger=oqTree->FieldByName("ID")->AsInteger;
      VT1->FieldByName("MID")->AsInteger=oqTree->FieldByName("MID")->AsInteger;
      VT1->FieldByName("POSITION")->AsInteger=oqTree->FieldByName("POSITION")->AsInteger;
      VT1->FieldByName("ENTYPE")->AsInteger=oqTree->FieldByName("ENTYPE")->AsInteger;
      VT1->FieldByName("SMART")->AsString=oqTree->FieldByName("SMART")->AsString;
      VT1->FieldByName("VName")->AsString=oqTree->FieldByName("NAME")->AsString;
      VT1->FieldByName("date_count")->AsString =oqTree->FieldByName("DATE_TIME")->AsString;
      VT1->FieldByName("MTRSN")->AsString=oqTree->FieldByName("MTRSN")->AsString;
      VT1->FieldByName("DIGITS")->AsString=oqTree->FieldByName("DIGITS")->AsString;
      VT1->FieldByName("MTYPE")->AsString=oqTree->FieldByName("MTYPE")->AsString;
      VT1->FieldByName("MCURRENT")->AsInteger=oqTree->FieldByName("MCURRENT")->AsInteger;
      VT1->FieldByName("MPOWER")->AsInteger=oqTree->FieldByName("MPOWER")->AsInteger;
      VT1->FieldByName("MYEAR")->AsInteger=oqTree->FieldByName("MYEAR")->AsInteger;
      VT1->FieldByName("MQUARTER")->AsInteger=oqTree->FieldByName("MQUARTER")->AsInteger;;
      VT1->FieldByName("MCONST")->AsInteger=oqTree->FieldByName("MCONST")->AsInteger;
      VT1->FieldByName("MCLASS")->AsString=oqTree->FieldByName("MCLASS")->AsString;
      VT1->FieldByName("Edited")->AsBoolean=false;
      VT1->Post();
      oqTree->Next();
    }
    VT1->First();
    VT1->EnableControls();

  }catch (Exception &e){
    if(Sender){
      DBGridEh1->SetFocus();
      VT1->First();
      VT1->EnableControls();
    }

    throw;
  }
 }
//---------------------------------------------------------------------------
void __fastcall TFormIntrodactPulsCount::vParams(TObject* Sender)
{
  TBookmark Book;
  Book=VT1->GetBookmark();
  GROUPDATAFORM gdf;
 gdf.HelpContext=525;
 TfmSelectPoint*f=NULL;
  try{
    if(EditRec){
      switch(MessageBox(Handle,Reconst_smes23_1.c_str(),Application->Title.c_str(),MB_YESNOCANCEL|MB_ICONQUESTION|MB_DEFBUTTON1)){
        case IDYES:
          vSave(Sender);
          if(EditRec){
            DBGridEh1->SetFocus();
            DBGridEh1->SelectedIndex=1;
            return;
          }
          break;
        case IDNO:
          break;
        default :
        DBGridEh1->SetFocus();
        VT1->GotoBookmark(Book);
        VT1->FreeBookmark(Book);
          return;
      }
    }
   gdf.gid = Mid;
   gdf.type=9;
   f = new TfmSelectPoint(this, &gdf);
   if((f->ShowModal() == mrOk)&&f->tvMain->Selected){
            Mid=gdf.gid;
            MainProc(Sender);
    }else{
      if(!Sender)
            Close();
    }
    delete f;
    if(Sender)
    {
      DBGridEh1->SetFocus();
      DBGridEh1->SelectedIndex=1;
    }
  }catch (Exception &exception){
    if(f)
      delete f;
  	Application->ShowException(&exception);
    if(!Sender)
      Close();
  }
}
//---------------------------------------------------------------------------
void __fastcall TFormIntrodactPulsCount::vRefresh(TObject* Sender)
{
  TBookmark Book;
  Book=VT1->GetBookmark();
  MainProc(this);
  VT1->GotoBookmark(Book);
  VT1->FreeBookmark(Book);
  DBGridEh1->SetFocus();
}
//---------------------------------------------------------------------------
void __fastcall TFormIntrodactPulsCount::vSave(TObject* Sender)
{
  TBookmark Book;
    if(!EditRec) //нет редактирования
    return;
  try{
    VT1->DisableControls();
    Book=VT1->GetBookmark();

   VT1->First();
   while (!VT1->Eof)
   {
        if (VT1->FieldByName("Edited")->AsBoolean)
        ProvMask(VT1->FieldByName("DIGITS")->AsString);
        VT1->Next();
    }


    VT1->First();
    while (!VT1->Eof)
    {
      if (VT1->FieldByName("Edited")->AsBoolean)
      {
       oqSave->ParamByName("AN_MID")->AsInteger=VT1->FieldByName("MID")->AsInteger;
       oqSave->ParamByName("AD_DATE_TIME")->AsString=VT1->FieldByName("date_count")->AsString;
       oqSave->ParamByName("AV_MTRSN")->AsString=VT1->FieldByName("MTRSN")->AsString;
       oqSave->ParamByName("AN_DIGITS")->AsString=VT1->FieldByName("DIGITS")->AsString;
       oqSave->ParamByName("AV_MTYPE")->AsString=VT1->FieldByName("MTYPE")->AsString;
       oqSave->ParamByName("AN_MCURRENT")->AsInteger=VT1->FieldByName("MCURRENT")->AsInteger;
       oqSave->ParamByName("AN_MPOWER")->AsInteger=VT1->FieldByName("MPOWER")->AsInteger;
       oqSave->ParamByName("AN_MYEAR")->AsInteger=VT1->FieldByName("MYEAR")->AsInteger;
       oqSave->ParamByName("AV_MQUARTER")->AsInteger=VT1->FieldByName("MQUARTER")->AsInteger;
       oqSave->ParamByName("AN_MCONST")->AsInteger=VT1->FieldByName("MCONST")->AsInteger;
       oqSave->ParamByName("AN_MCLASS")->AsString=VT1->FieldByName("MCLASS")->AsString;
       oqSave->ParamByName("AN_ENTYPE")->AsInteger=VT1->FieldByName("ENTYPE")->AsInteger;
       VT1->Edit();
       VT1->FieldByName("Edited")->AsBoolean=false;
       VT1->Post();
       oqSave->Execute();
      }
       VT1->Next();
    }

    dmMain->orases->Commit();
    VT1->GotoBookmark(Book);
    VT1->EnableControls();
    VT1->FreeBookmark(Book);

    EditRec=false;
  }catch(Exception &exception){
   dmMain->orases->Rollback();
   VT1->GotoBookmark(Book);
   VT1->EnableControls();
   VT1->FreeBookmark(Book);
   Application->ShowException(&exception);
  }

  DBGridEh1->SetFocus();
}
//---------------------------------------------------------------------------
void __fastcall TFormIntrodactPulsCount::ProvMask(AnsiString Str)
{
  bool CanPoint=false;
  if(Str.Length()==0)
    return;
  for(int i=1; i<=Str.Length();i++){
    if((Str[i]=='9')||(CanPoint&&(Str[i]=='.'))){
      if((i>1)&&(Str[i]=='.'))
        CanPoint=false;
    }else
     throw(Exception(Reconst_smes23_2));
    if(i==1)
     CanPoint=true;
  }
}
//---------------------------------------------------------------------------
void __fastcall TFormIntrodactPulsCount::VT1AfterEdit(TDataSet *DataSet)
{
  if(Access==accRead)
    return;
  EditRec=true;
  VT1->FieldByName("Edited")->AsBoolean=true;
}
//---------------------------------------------------------------------------
void __fastcall TFormIntrodactPulsCount::DBGridEh1KeyPress(TObject *Sender,
      char &Key)
{
    if(Access==accRead){
      Beep();
      Key = NULL;
   }
}
//---------------------------------------------------------------------------

void __fastcall TFormIntrodactPulsCount::FormResize(TObject *Sender)
{
  DBGridEh1->Columns->Items[0]->Width=this->Width-670;
}
//---------------------------------------------------------------------------
void __fastcall TFormIntrodactPulsCount::FormShow(TObject *Sender)
{
 DBGridEh1->SetFocus();
 DBGridEh1->SelectedIndex=1;
}
//---------------------------------------------------------------------------

void __fastcall TFormIntrodactPulsCount::DBGridEh1Columns4EditButtons0Click(
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

