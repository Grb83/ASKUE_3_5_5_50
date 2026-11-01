//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#include "unGuid.h"
#include "unDataMod.h"
#pragma link "MemDS"
#pragma link "DBAccess"
#pragma link "Ora"
#pragma link "PrnDbgeh"
#pragma link "DBGridEh"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
//---------------------------------------------------------------------------
__fastcall TfmGuid::TfmGuid(TComponent* Owner,long id,long type,AnsiString Name)
	: TForm(Owner)
{
 ReplaceRyda(this,BASE_SCHEME,SchemeName);
 this->id=id;
 this->type=type;
 Caption=Caption+" "+Name;

 if(!vRead())
  Close();

 if(grMain->SelectedIndex==0)
  grMain->SelectedIndex=1;
}
//---------------------------------------------------------------------------
bool __fastcall TfmGuid::fmGuidShow(TComponent* Owner,long id,long type,AnsiString Name)
{
  TfmGuid *f=new TfmGuid(Owner,id,type,Name);
  int res = f->ShowModal();
  delete f;
  return (res == mrOk);
}
//---------------------------------------------------------------------------
void __fastcall TfmGuid::vSave(TObject *Sender)
{

   if(oqMeas->State==dsEdit)
    oqMeas->Post();
try{

    oqSave->SQL->Text=" begin "+SchemeName+" editfeeders_pg.ins_Guid(:mid,:nmeasure,:mrid); end; ";
    oqSave->ParamByName("nmeasure")->DataType =ftInteger;
    oqSave->ParamByName("nmeasure")->ParamType =ptInput;
    oqSave->ParamByName("nmeasure")->Table=true;
    oqSave->ParamByName("nmeasure")->Length=1;
    oqSave->ParamByName("nmeasure")->ItemAsInteger[1]=0;

    oqSave->ParamByName("mrid")->DataType =ftString;
    oqSave->ParamByName("mrid")->ParamType =ptInput;
    oqSave->ParamByName("mrid")->Table=true;
    oqSave->ParamByName("mrid")->Length=1;
    oqSave->ParamByName("mrid")->ItemAsString[1]="";


    oqMeas->First();
    while(!oqMeas->Eof){
    if(!oqMeas->FieldByName("mrid")->IsNull){
     oqSave->ParamByName("mid")->AsInteger=oqMeas->FieldByName("mid")->AsInteger;
     oqSave->ParamByName("nmeasure")->ItemAsInteger[oqSave->ParamByName("nmeasure")->Length]=oqMeas->FieldByName("nmeasure")->AsInteger;
     oqSave->ParamByName("nmeasure")->Length++;
     oqSave->ParamByName("mrid")->ItemAsString[oqSave->ParamByName("mrid")->Length]=oqMeas->FieldByName("mrid")->AsString;
     oqSave->ParamByName("mrid")->Length++;
     }
     oqMeas->Next();

     }

    oqSave->Execute();
   dmMain->orases->Commit();
    btSave->Enabled=false;


  }catch (Exception &exception){
    dmMain->orases->Rollback();
    Application->ShowException(&exception);
  }
}
//-------------------------------------------------------------------------------
bool __fastcall TfmGuid::vRead(void)
{
  oqMeas->ParamByName("mid")->AsInteger=id;
  oqMeas->ParamByName("type")->AsInteger=type;
  oqMeas->Execute();
  if(!oqMeas->Eof)return true;
  else  return false;

}
//-----------------------------------------------------------------------------------
void __fastcall TfmGuid::vRefresh(TObject *Sender)
{//cansel
  vRead();
  if(btSave->Enabled){
    btSave->Enabled=false;
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmGuid::tbPrintClick(TObject *Sender)
{
  PrintMessageGrid->PageHeader->CenterText->Clear();
  PrintMessageGrid->PageHeader->RightText->Clear();
  PrintMessageGrid->PageHeader->CenterText->Add(Caption);
  PrintMessageGrid->PageHeader->CenterText->Add("  ");
  PrintMessageGrid->PageHeader->RightText->Text=Now().FormatString("dd.mm.yyyy hh:nn:ss");
  PrintMessageGrid->Preview();
}
//---------------------------------------------------------------------------
void __fastcall TfmGuid::tbExportClick(TObject *Sender)
{
  TdmMain::SaveTable(this,grMain,Caption);
}
//---------------------------------------------------------------------------
void __fastcall TfmGuid::btOkClick(TObject *Sender)
{
 if (btSave->Enabled)
   vSave(this);
 if(!btSave->Enabled)
   ModalResult=mrOk;
}

//---------------------------------------------------------------------------


void __fastcall TfmGuid::oqMeasAfterEdit(TDataSet *DataSet)
{
   btSave->Enabled=true;
}
//---------------------------------------------------------------------------

void __fastcall TfmGuid::btGuidsClick(TObject *Sender)
{
  grMain->Columns->BeginUpdate();

  oqSave->Params->Clear();
  oqSave->SQL->Text=" select  "+SchemeName+"util_pg.create_guid guid from dict where rownum<=:par1";
  oqSave->ParamByName("par1")->AsInteger=oqMeas->RecordCount;
  oqSave->Execute();

  oqMeas->First();
  oqSave->First();
     while(!oqMeas->Eof){
     if(oqMeas->FieldByName("mrid")->IsNull)
      {
      oqMeas->Edit();
      oqMeas->FieldByName("mrid")->AsString=oqSave->FieldByName("guid")->AsString;
      oqSave->Next();
      }
      oqMeas->Next();
     }
 
 grMain->Columns->EndUpdate();
}
//---------------------------------------------------------------------------

