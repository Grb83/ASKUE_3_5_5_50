//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#include "ParamCommunicationServer.h"
#include "BlockMessage.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma resource "*.dfm"
TFormParamCommunicationServer*FormParamCommunicationServer=NULL;
//---------------------------------------------------------------------------
__fastcall TFormParamCommunicationServer::TFormParamCommunicationServer(TComponent* Owner, AnsiString Name, TAccess a)
	: TMainForm(Owner, Name, a)
{
   FormStyle = fsNormal;
   FormParamCommunicationServer = this;
}
//---------------------------------------------------------------------------
__fastcall TFormParamCommunicationServer::~TFormParamCommunicationServer()
{
   FormParamCommunicationServer = NULL;
}
//---------------------------------------------------------------------------
void  TFormParamCommunicationServer::TreeRead()
{
  dmMain->oqCursor->Params->Clear();
  dmMain->oqCursor->SQL->Text="begin "+SchemeName+"admin_pg.read_srv_parameter(:par1); end;";
  dmMain->oqCursor->ParamByName("par1")->ParamType = ptOutput;
  dmMain->oqCursor->ParamByName("par1")->DataType = ftCursor;
  dmMain->oqCursor->Execute();
  EditRec=false;
  Cang=1;
  if(!dmMain->oqCursor->Eof){
     TreeTable[0].min_delta=dmMain->oqCursor->FieldByName("min_delta")->AsInteger;
     TreeTable[0].max_delta=dmMain->oqCursor->FieldByName("max_delta")->AsInteger;
     strcpy(TreeTable[0].clock_set,dmMain->oqCursor->FieldByName("clock_set")->AsString.c_str());
     strcpy(TreeTable[0].curr_meter,dmMain->oqCursor->FieldByName("metering")->AsString.c_str());
     MaskEdit1->Text=TreeTable[0].min_delta;
     MaskEdit2->Text=TreeTable[0].max_delta;

     if(TreeTable[0].clock_set[0]=='*')  CheckBox1->Checked=true;
     else                                CheckBox1->Checked=false;

     if(TreeTable[0].curr_meter[0]=='*')  CheckBox4->Checked=true;
     else                               CheckBox4->Checked=false;

  }else{
     MaskEdit1->Text="";
     MaskEdit2->Text="";
     CheckBox1->Checked=false;
     CheckBox4->Checked=false;
  }
  Cang=0;
}
//---------------------------------------------------------------------------
bool  TFormParamCommunicationServer::TreeWrite()
{
 try{
    try{
 		if(MaskEdit1->Text.IsEmpty()) TreeTable[0].min_delta=0;
 		else                          TreeTable[0].min_delta=MaskEdit1->Text.ToInt();

 		if(MaskEdit2->Text.IsEmpty()) TreeTable[0].max_delta=0;
 		else                          TreeTable[0].max_delta=MaskEdit2->Text.ToInt();

 		if(CheckBox1->Checked) TreeTable[0].clock_set[0]='*';
 		else                   TreeTable[0].clock_set[0]='\0';

 		if(CheckBox4->Checked) TreeTable[0].curr_meter[0]='*';
 		else                   TreeTable[0].curr_meter[0]='\0';

 	}
    catch(Exception &e){
     throw(Exception(Reconst_smes49_1));
    }
  dmMain->oqCursor->Params->Clear();
 	dmMain->oqCursor->SQL->Text="begin "+SchemeName+"admin_pg.set_srv_parameter(:par1, :par2, :par3,:par4); commit; end;";
  dmMain->oqCursor->ParamByName("par1")->AsInteger=TreeTable[0].min_delta;
  dmMain->oqCursor->ParamByName("par2")->AsInteger=TreeTable[0].max_delta;
  dmMain->oqCursor->ParamByName("par3")->AsString=TreeTable[0].clock_set;
  dmMain->oqCursor->ParamByName("par4")->AsString=TreeTable[0].curr_meter;
  dmMain->oqCursor->Execute();
     EditRec=false;
     return true;
 }
 catch(Exception &exception){
  dmMain->orases->Rollback();
  Application->MessageBox(exception.Message.c_str(),Application->Title.c_str(),MB_OK	|MB_ICONSTOP);
  return false;
 }
}
//---------------------------------------------------------------------------
void __fastcall TFormParamCommunicationServer::FormCreate(TObject *Sender)
{
  TreeRead();
}
//---------------------------------------------------------------------------
void __fastcall TFormParamCommunicationServer::vSave(TObject *Sender)
{//save
    TreeWrite();
}
//---------------------------------------------------------------------------
void __fastcall TFormParamCommunicationServer::vRefresh(TObject *Sender)
{//consel
  TreeRead();
}
//---------------------------------------------------------------------------

void __fastcall TFormParamCommunicationServer::ChangeData(TObject *Sender)
{
 if(Cang) return;
  EditRec=true;
}
//---------------------------------------------------------------------------

void __fastcall TFormParamCommunicationServer::SetAccess(TAccess value)
{
   if(FAccess != value){
      TMainForm::SetAccess(value);
      bool wr = value==accWrite;
      MaskEdit1->ReadOnly = !wr;
      MaskEdit2->ReadOnly = !wr;
      CheckBox1->Enabled = wr;
      CheckBox4->Enabled = wr;
   }
}
//---------------------------------------------------------------------------
void __fastcall TFormParamCommunicationServer::aExecute(
      TObject *Sender)
{
   if(Sender==aClockCorrect)
      CheckBox1->Checked = !CheckBox1->Checked;
   else if(Sender==aWriteCurrYear)
      CheckBox4->Checked = !CheckBox4->Checked;
}
//---------------------------------------------------------------------------
void __fastcall TFormParamCommunicationServer::btMessageClick(
      TObject *Sender)
{
  TfmBlockMess::fmBlockMessShow(this);
}
//---------------------------------------------------------------------------

