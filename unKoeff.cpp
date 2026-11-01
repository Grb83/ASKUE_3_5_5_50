//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#include "ASKUETypes.h"
#include "unDataMod.h"
#include "unKoeff.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "DBAccess"
#pragma link "MemDS"
#pragma link "Ora"
#pragma link "DBGridEh"
#pragma resource "*.dfm"
TfmKoeff *fmKoeff;
//---------------------------------------------------------------------------
__fastcall TfmKoeff::TfmKoeff(TComponent* Owner,long Mid,AnsiString Name,bool fullacc)
  : TForm(Owner)
{
   Caption= Caption+Reconst_smes133_2+ Name;
   ReplaceRyda(this,BASE_SCHEME,SchemeName);
   this->Mid=Mid;
   ReadData(Mid);
   if(grMain->SelectedIndex==0) grMain->SelectedIndex=1;
   grMain->ReadOnly      = !fullacc;
   btOk->Enabled         = fullacc;
   DBNavigator1->Enabled = fullacc;
}
//---------------------------------------------------------------------------
void __fastcall TfmKoeff::ReadData(int Mid)
{
   oqData->ParamByName("mid")->AsInteger=Mid;
   oqData->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TfmKoeff::vSave(TObject *Sender)
{
 if(oqData->State==dsEdit)
     oqData->Post();
   try{
    oqData->ApplyUpdates();

    }catch (Exception &exception){
    throw;
    }

  oqData->CommitUpdates();

 }
 //------------------------------------------------------------------------------

void __fastcall TfmKoeff::btOkClick(TObject *Sender)
{

  vSave(this);
  Close();

}
//---------------------------------------------------------------------------


void __fastcall TfmKoeff::oqDataAfterInsert(TDataSet *DataSet)
{
   DataSet->FieldByName("mid")->AsInteger=Mid;
   DataSet->FieldByName("dstart")->AsDateTime=Date();
   DataSet->FieldByName("kc")->AsFloat=1;
   DataSet->Post();
}
//---------------------------------------------------------------------------

void __fastcall TfmKoeff::dsMainDataChange(TObject *Sender, TField *Field)
{

    if((!oqData->FieldByName("dend")->IsNull)&&
    (oqData->FieldByName("dstart")->AsDateTime>=oqData->FieldByName("dend")->AsDateTime ))

    {
     if(MessageBox(Handle,Reconst_smes133_1.c_str(),Application->Title.c_str(),MB_OK|MB_ICONERROR)==IDOK)
     oqData->Edit();
     oqData->FieldByName("dend")->Clear(); 
    }
}
//---------------------------------------------------------------------------

