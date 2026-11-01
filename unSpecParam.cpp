//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#include "unSpecParam.h"
#include "unDataMod.h"
#pragma link "MemDS"
#pragma link "DBAccess"
#pragma link "Ora"
#pragma link "PrnDbgeh"
#pragma link "DBGridEh"
#pragma link "PrnDbgeh"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
//---------------------------------------------------------------------------
__fastcall TfmSpecParam::TfmSpecParam(TComponent* Owner,long id,long ltype,long ltable)
	: TForm(Owner)
{
 ReplaceRyda(this,BASE_SCHEME,SchemeName);
 this->id=id;
 this->ltype=ltype;
 this->ltable = ltable;
 if(ltable==1){
  switch(ltype)
  {
   case 0: HelpContext=17034;break;  //Специальные параметры для точки учета
   case 1: HelpContext=29051;break;  //Физические и технологические границы точки учета
   case 2: HelpContext=17034;break;  //Коды каналов и коды объектов для точки учета
  }
  }else{
  HelpContext=106091; // Специальные параметры для формы
 }
 if(!vRead())
  Close();
 if(grMain->SelectedIndex==0)
  grMain->SelectedIndex=1;
}
//---------------------------------------------------------------------------
bool __fastcall TfmSpecParam::fmSpecParamShow(TComponent* Owner,long id,long ltype,long ltable)
{
  TfmSpecParam *f=new TfmSpecParam(Owner,id,ltype,ltable);
  int res = f->ShowModal();
  delete f;
  return (res == mrOk);
}
//---------------------------------------------------------------------------
void __fastcall TfmSpecParam::vSave(TObject *Sender)
{ //save
   if(oqMain->State==dsEdit)
      oqMain->Post();
   try{
    oqMain->ApplyUpdates();
    oqMain->Session->Commit();
    oqMain->CommitUpdates();
    btSave->Enabled=false;
   }catch (Exception &exception){
    oqMain->Session->Rollback();
    Application->ShowException(&exception);
  }
}
//-------------------------------------------------------------------------------
bool __fastcall TfmSpecParam::vRead(void)
{//consel
  oqCaption->ParamByName("an_mid")->AsInteger=id;
  oqCaption->ParamByName("an_type")->AsInteger=ltype;
  oqCaption->ParamByName("an_table")->AsInteger=ltable;
  oqCaption->Execute();
  Caption=oqCaption->FieldByName("name")->AsString;
  oqCaption->Close();
  oqMain->Close();
  oqMain->ParamByName("mid")->AsInteger=id;
  oqMain->ParamByName("SpezParam")->AsInteger=ltype;
  oqMain->ParamByName("objtype")->AsInteger=ltable;
  oqMain->Execute();
  if(!oqMain->Eof)return true;
  else  return false;
}
//-----------------------------------------------------------------------------------
void __fastcall TfmSpecParam::vRefresh(TObject *Sender)
{//cansel
  vRead();
  if(btSave->Enabled){
    btSave->Enabled=false;
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmSpecParam::tbPrintClick(TObject *Sender)
{
  PrintMessageGrid->PageHeader->CenterText->Clear();
  PrintMessageGrid->PageHeader->RightText->Clear();
  PrintMessageGrid->PageHeader->CenterText->Add(Caption);
  PrintMessageGrid->PageHeader->CenterText->Add("  ");
  PrintMessageGrid->PageHeader->RightText->Text=Now().FormatString("dd.mm.yyyy hh:nn:ss");
  PrintMessageGrid->Preview();
}
//---------------------------------------------------------------------------
void __fastcall TfmSpecParam::oqMainAfterEdit(TDataSet *DataSet)
{
 btSave->Enabled=true;
}
//---------------------------------------------------------------------------
void __fastcall TfmSpecParam::tbExportClick(TObject *Sender)
{
  TdmMain::SaveTable(this,grMain,Caption);
}
//---------------------------------------------------------------------------
void __fastcall TfmSpecParam::btOkClick(TObject *Sender)
{
 if (btSave->Enabled)
   vSave(this);
 if(!btSave->Enabled)
   ModalResult=mrOk;
}

//---------------------------------------------------------------------------
void __fastcall TfmSpecParam::btSaveClick(TObject *Sender)
{
  vSave(this);
}
//---------------------------------------------------------------------------
void __fastcall TfmSpecParam::grMainCellClick(TColumnEh *Column)
{
  if (oqMain->FieldByName("ntype")->AsInteger==6 || oqMain->FieldByName("ntype")->AsInteger==7){
    Column->ButtonStyle = 1;// cbsEllipsis
    Column->ReadOnly = true;
  }
  else{
    Column->ButtonStyle = 0;// cbsAuto
    Column->ReadOnly = false;
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmSpecParam::grMainEditButtonClick(TObject *Sender)
{
  if(OpenDialog1->Execute()){
      oqMain->Edit();
      grMain->SelectedField->AsString = OpenDialog1->FileName;
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmSpecParam::oqMainBeforeUpdateExecute(TDataSet *Sender,
      TStatementTypes StatementTypes, TDAParams *Params)
{
  if(Sender->FieldByName("ntype")->AsInteger==6||Sender->FieldByName("ntype")->AsInteger==7){
//    oqSaveLob->Params->Clear();
    oqSaveLob->ParamByName("mid")->AsInteger = id;
    oqSaveLob->ParamByName("nsort")->AsInteger = Sender->FieldByName("nsort")->AsInteger;
    oqSaveLob->ParamByName("objtype")->AsInteger = ltable;
    oqSaveLob->ParamByName("value")->DataType = (Sender->FieldByName("ntype")->AsInteger==6)?ftOraClob:ftOraBlob;
    oqSaveLob->ParamByName("value")->ParamType = ptInput;
    if(Sender->FieldByName("ntype")->AsInteger==6){
      if(!Sender->FieldByName("vvalue")->AsString.IsEmpty())
        oqSaveLob->ParamByName("value")->AsOraClob->LoadFromFile(Sender->FieldByName("vvalue")->AsString);
      else
        oqSaveLob->ParamByName("value")->AsOraClob->Clear();
    }else{
      if(!Sender->FieldByName("vvalue")->AsString.IsEmpty())
        oqSaveLob->ParamByName("value")->AsOraBlob->LoadFromFile(Sender->FieldByName("vvalue")->AsString);
      else
        oqSaveLob->ParamByName("value")->AsOraClob->Clear();
    }
    oqSaveLob->Execute();
    oqSaveLob->Session->Commit();
  }
}
//---------------------------------------------------------------------------

void __fastcall TfmSpecParam::tbClearClick(TObject *Sender)
{
  if(!oqMain->Eof){
    oqMain->Edit();
    oqMain->FieldByName("vvalue")->AsString="";
    oqMain->Post();
  }
}
//---------------------------------------------------------------------------

void __fastcall TfmSpecParam::oqMainAfterScroll(TDataSet *DataSet)
{
  tbClear->Enabled=(!oqMain->Eof&&(oqMain->FieldByName("ntype")->AsInteger==6 || oqMain->FieldByName("ntype")->AsInteger==7));
}
//---------------------------------------------------------------------------

