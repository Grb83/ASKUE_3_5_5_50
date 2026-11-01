//---------------------------------------------------------------------------

#include <vcl.h>
#include <ShellAPI.h>
#pragma hdrstop
#include "unMeterParameter.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "DBAccess"
#pragma link "DBGridEh"
#pragma link "MemDS"
#pragma link "Ora"
#pragma link "PrnDbgeh"
#pragma resource "*.dfm"
TfmMeterParameter *fmMeterParameter;
//---------------------------------------------------------------------------
__fastcall TfmMeterParameter::TfmMeterParameter(TComponent* Owner,long id, TAccess a)
  : TForm(Owner)
{
  ReplaceRyda(this,BASE_SCHEME,SchemeName);
  bool acc = a==accRead?true:false;
  acc = acc && !(dmMain->GetTaskRights(UsCon.Role_Id, 106) == TASK_RIGHTS_WRITE);
  grMain->ReadOnly = acc;
  grMain->Columns->Items[1]->ButtonStyle = acc?(Dbgrids::cbsNone):(Dbgrids::cbsEllipsis);
  btAdd->Enabled = !acc;
  //btClear->Enabled = !acc;
  btClear->Enabled = false;
  btDelete->Enabled = !acc;
  vRead(id,0);
}
//---------------------------------------------------------------------------
bool __fastcall TfmMeterParameter::fmMeterParameterShow(TComponent* Owner, long id, TAccess a)
{
  int res;
  if (a==accDenied){
    ShowMessage(Reconst_smes73_1);
    res = mrCancel;
  }
  else{
    TfmMeterParameter *f=new TfmMeterParameter(Owner,id,a);
    res = f->ShowModal();
    delete f;
  }
  return (res == mrOk);
}
//---------------------------------------------------------------------------
void __fastcall TfmMeterParameter::vSave(TObject *Sender)
{ //save
   if(oqMain->State==dsEdit)
    oqMain->Post();
   try{
    oqMain->ApplyUpdates();
    oqMain->Session->Commit();
    oqMain->CommitUpdates();
    oqMain->Close();
    oqMain->ParamByName("mid")->AsInteger=Mid;
    oqMain->Execute();
    btSave->Enabled=false;
   }catch (Exception &exception){
    oqMain->Session->Rollback();
    Application->ShowException(&exception);
  }
}
//-------------------------------------------------------------------------------
void __fastcall TfmMeterParameter::vRead(long Mid,unsigned long Sort)
{//cansel

  this->Mid=Mid;
  //GRB ADD 16.04.2020 - test trouble ODAC
  dmMain->quMain->Params->Clear();
  //END ADD 
  dmMain->quMain->SQL->Text="select "+SchemeName+"util_pg.get_pointname("+IntToStr(Mid)+",0,0) name from dual";
  dmMain->quMain->Execute();
  //Caption=Reconst_smes73_2+dmMain->quMain->FieldByName("name")->AsString;
  oqMain->Close();
  oqMain->ParamByName("mid")->AsInteger=Mid;
  oqMain->Execute();
  oqDateParam->Close();
  oqDateParam->ParamByName("mid")->AsInteger=Mid;
  oqDateParam->Execute();
  Label2->Caption = oqDateParam->ParamByName("RESULT")->AsString;
}
//-----------------------------------------------------------------------------------
void __fastcall TfmMeterParameter::vRefresh(TObject *Sender)
{//cansel
  vRead(Mid,0);
  if(btSave->Enabled){
    btSave->Enabled=false;
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmMeterParameter::tbPrintClick(TObject *Sender)
{
  PrintMessageGrid->PageHeader->CenterText->Clear();
  PrintMessageGrid->PageHeader->RightText->Clear();
  PrintMessageGrid->PageHeader->CenterText->Add(Caption);
  PrintMessageGrid->PageHeader->CenterText->Add("  ");
  PrintMessageGrid->PageHeader->RightText->Text=Now().FormatString("dd.mm.yyyy hh:nn:ss");
  PrintMessageGrid->Preview();
}
//---------------------------------------------------------------------------
void __fastcall TfmMeterParameter::vDelete(TObject *Sender)
{
  if(MessageBox(Handle,Reconst_smes73_3.c_str(),Application->Title.c_str(),MB_YESNO|MB_ICONQUESTION|MB_DEFBUTTON2)==IDYES)
    oqMain->Delete();
}
//---------------------------------------------------------------------------
void __fastcall TfmMeterParameter::oqMainAfterEdit(TDataSet *DataSet)
{
  btSave->Enabled=true;
}
//---------------------------------------------------------------------------
void __fastcall TfmMeterParameter::btClearClick(TObject *Sender)
{
  if(!oqMain->RecordCount)
    return;
  if(grMain->Col==2&&!oqMainVFILENAME->AsString.IsEmpty()){
    if(MessageBox(Handle,AnsiString(Reconst_smes73_4+oqMainDDATE->AsDateTime+">?").c_str(),Application->Title.c_str(),MB_YESNO|MB_ICONQUESTION|MB_DEFBUTTON2)==IDYES){
      oqMain->Edit();
      oqMainBFILE->Clear();
      oqMainVFILENAME->Clear();
      btSave->Enabled=true;
    }
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmMeterParameter::tbExportClick(TObject *Sender)
{
  if(!oqMain->RecordCount)
    return;
  SaveDialog1->FileName = oqMainVFILENAME->AsString;
  if(SaveDialog1->Execute())
    oqMainBFILE->SaveToFile(SaveDialog1->FileName);
}
//---------------------------------------------------------------------------
void __fastcall TfmMeterParameter::BitBtn1Click(TObject *Sender)
{
  if (btSave->Enabled)
    vSave(this);
  Close();
}
//---------------------------------------------------------------------------
void __fastcall TfmMeterParameter::btAddClick(TObject *Sender)
{
  oqMain->Insert();
}
//---------------------------------------------------------------------------
void __fastcall TfmMeterParameter::grMainKeyDown(TObject *Sender, WORD &Key,
      TShiftState Shift)
{
  if (grMain->SelectedIndex==1&&Key == VK_RETURN){
    bool b=true;
    grMainColumns1EditButtonClick(Sender,b);
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmMeterParameter::oqMainAfterInsert(TDataSet *DataSet)
{
  DataSet->FieldByName("mid")->AsInteger=Mid;
  DataSet->FieldByName("ddate")->AsDateTime=Date();
  btSave->Enabled=true;
}
//---------------------------------------------------------------------------
void __fastcall TfmMeterParameter::grMainColumns1EditButtonClick(
      TObject *Sender, bool &Handled)
{
  if (OpenDialog1->Execute()){
    oqMain->Edit();
    oqMainBFILE->LoadFromFile(OpenDialog1->FileName);
    oqMainVFILENAME->AsString = ExtractFileName(OpenDialog1->FileName);
    btSave->Enabled=true;
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmMeterParameter::tbViewClick(TObject *Sender)
{
  AnsiString path;
  if(!oqMainVFILENAME->AsString.IsEmpty()){
    path = oqMainVFILENAME->AsString;
    path = TdmMain::GetTmpPath()+ExtractFileName(path);
    oqMainBFILE->SaveToFile(path);
    int i=(int)ShellExecute(Handle,"open",path.c_str(),NULL,NULL,SW_SHOWDEFAULT);
    if(i<=32){
      i=(int)ShellExecute(Handle,"edit",path.c_str(),NULL,NULL,SW_SHOWDEFAULT);
      if (i<=32)
      Application->MessageBox(AnsiString(Reconst_smes73_5+IntToStr(i)+")").c_str(),Application->Title.c_str(),MB_OK	|MB_ICONSTOP);
      }
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmMeterParameter::btSaveClick(TObject *Sender)
{
    vSave(this);
}
//---------------------------------------------------------------------------

