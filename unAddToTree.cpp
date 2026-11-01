//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "unAddToTree.h"
#include "unDataMod.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "DBAccess"
#pragma link "MemDS"
#pragma link "Ora"
#pragma resource "*.dfm"
TfmAddToTree *fmAddToTree;
//---------------------------------------------------------------------------
__fastcall TfmAddToTree::TfmAddToTree(TComponent* Owner, TfmTree::SFunction *vDate, bool enableBox)
  : TForm(Owner)
{
  this->BoxEnable=enableBox;
  this->vDate=vDate;
}
//---------------------------------------------------------------------------
void __fastcall TfmAddToTree::GrBtTypeClick(TObject *Sender)
{
  Panel8->Visible=GrBtType->ItemIndex;
}
//---------------------------------------------------------------------------
void __fastcall TfmAddToTree::btnAddOkClick(TObject *Sender)
{
  try {
  vDate->vname=edAddName->Text;
  vDate->ntype=GrBtType->ItemIndex;
  vDate->vvalue=memContains->Text;
  vDate->vmemo=memNote->Text;

  if(vDate->nid)
  oqSaveFunc->ParamByName("an_id")->AsInteger=vDate->nid;
  else
  oqSaveFunc->ParamByName("an_id")->Clear();

  if(vDate->nparent)
  oqSaveFunc->ParamByName("an_parent")->AsInteger=vDate->nparent;
  else
  oqSaveFunc->ParamByName("an_parent")->Clear();
  
  oqSaveFunc->ParamByName("an_type")->AsInteger=vDate->ntype;
  oqSaveFunc->ParamByName("av_name")->AsString=vDate->vname;
  oqSaveFunc->ParamByName("av_formula")->AsString=vDate->vvalue;
  oqSaveFunc->ParamByName("av_memo")->AsString=vDate->vmemo;

  oqSaveFunc->Execute();
  dmMain->orases->Commit();

  vDate->nid=oqSaveFunc->ParamByName("an_id")->AsInteger;
  ModalResult=mrOk;
  }
    catch (Exception &exception){
    dmMain->orases->Rollback();
    ModalResult=mrCancel;
  	Application->ShowException(&exception);
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmAddToTree::FormClose(TObject *Sender,
      TCloseAction &Action)
{
  //Action=caFree();
}
//---------------------------------------------------------------------------
void __fastcall TfmAddToTree::FormCreate(TObject *Sender)
{
  edAddName->Text=vDate->vname;
  GrBtType->ItemIndex=vDate->ntype;
  memContains->Text=vDate->vvalue;
  memNote->Text=vDate->vmemo;
  GrBtType->Enabled=BoxEnable;
}
//---------------------------------------------------------------------------



