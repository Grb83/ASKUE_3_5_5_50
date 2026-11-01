//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#include "TypePart.h"
#include "unDataMod.h"
#include "selectpoint.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "MemDS"
#pragma link "DBAccess"
#pragma link "Ora"
#pragma link "PrnDbgeh"
#pragma link "DBGridEh"
#pragma resource "*.dfm"
//---------------------------------------------------------------------------
__fastcall TfmTypePart::TfmTypePart(TComponent* Owner,long id)
	: TForm(Owner)
{
  ReplaceRyda(this,BASE_SCHEME,SchemeName);
  vRead(id,0);
  if(grMain->SelectedIndex==0) grMain->SelectedIndex=1;
  insertclone = false;
}
//---------------------------------------------------------------------------

bool __fastcall TfmTypePart::fmTypePartShow(TComponent* Owner, long id)
{
  TfmTypePart *f=new TfmTypePart(Owner,id);
  int res = f->ShowModal();
  delete f;
  return (res == mrOk);
}
//---------------------------------------------------------------------------
void __fastcall TfmTypePart::vSave(TObject *Sender)
{ //save
   if(oqMain->State==dsEdit)
    oqMain->Post();
   try{
    oqMain->ApplyUpdates();
    oqMain->Session->Commit();
    oqMain->CommitUpdates();

    oqSort->Params->Clear();
    oqSort->SQL->Text="begin "+SchemeName+"ORDERFORMULA_PG.order_formula;end;";
    oqSort->Execute();
    dmMain->orases->Commit();
    
    btSave->Enabled=false;
   }catch (Exception &exception){
    oqMain->Session->Rollback();
    Application->ShowException(&exception);
  }
}
//-------------------------------------------------------------------------------
void __fastcall TfmTypePart::vRead(long Mid,unsigned long Sort)
{//consel

  this->Mid=Mid;
  //GRB ADD 16.04.2020 - test trouble ODAC
  dmMain->quMain->Params->Clear();
  //END ADD 
  dmMain->quMain->SQL->Text="select "+SchemeName+"util_pg.get_pointname("+IntToStr(Mid)+",0,0) name from dual";
  dmMain->quMain->Execute();
  Name=dmMain->quMain->FieldByName("name")->AsString;
  Caption=Reconst_smes64_5+Name;
  oqMain->Close();
  oqMain->ParamByName("mid")->AsInteger=Mid;
  oqMain->ParamByName("nsort")->AsInteger=Sort;
  oqMain->Execute();

}
//-----------------------------------------------------------------------------------
void __fastcall TfmTypePart::vRefresh(TObject *Sender)
{//cansel
  vRead(Mid,0);
  if(btSave->Enabled){
    btSave->Enabled=false;
  }
   btClone->Enabled = !oqMain->FieldByName("OWMID")->IsNull;
}

//---------------------------------------------------------------------------
void __fastcall TfmTypePart::grNameColumns2EditButtonClick(TObject *Sender,
      bool &Handled)
{
  GROUPDATAFORM gdf;
   gdf.gid = oqMain->FieldByName("pmid")->AsInteger;
   gdf.type=9;
   TfmSelectPoint*f = new TfmSelectPoint(this, &gdf);
   f->HelpContext=16031;
  if((f->ShowModal() == mrOk)&&f->tvMain->Selected){
    oqMain->Edit();
    oqMain->FieldByName("pmid")->AsInteger =gdf.gid;
    oqMain->FieldByName("pname")->AsString = gdf.Name;
   }
  delete f;
}
//---------------------------------------------------------------------------
void __fastcall TfmTypePart::tbPrintClick(TObject *Sender)
{
  PrintMessageGrid->PageHeader->CenterText->Clear();
  PrintMessageGrid->PageHeader->RightText->Clear();
  PrintMessageGrid->PageHeader->CenterText->Add(Caption);
  PrintMessageGrid->PageHeader->CenterText->Add("  ");
  PrintMessageGrid->PageHeader->RightText->Text=Now().FormatString("dd.mm.yyyy hh:nn:ss");
  PrintMessageGrid->Preview();
}
//---------------------------------------------------------------------------
void __fastcall TfmTypePart::vDelete(TObject *Sender)
{
  if(oqMain->FieldByName("OWMID")->IsNull)
    return;
  else{
    if(Mid!=oqMain->FieldByName("OWMID")->AsInteger){
      Application->MessageBox(AnsiString(Reconst_smes64_1+oqMain->FieldByName("OWNAME")->AsString).c_str(), Application->Title.c_str(), MB_OK | MB_ICONSTOP);
      return;
    }else{
      if(MessageBox(Handle,Reconst_smes64_2.c_str(),Application->Title.c_str(),MB_YESNO|MB_ICONQUESTION|MB_DEFBUTTON2)==IDYES)
        oqMain->Delete();
    }
  }
 btClone->Enabled = !(oqMain->FieldByName("OWMID")->IsNull);
}
//---------------------------------------------------------------------------
void __fastcall TfmTypePart::grNameColumns3EditButtonClick(TObject *Sender,
      bool &Handled)
{
   GROUPDATAFORM gdf;
   gdf.gid = oqMain->FieldByName("gid")->AsInteger;
   gdf.type=4;
   TfmSelectPoint*f = new TfmSelectPoint(this, &gdf);
   f->HelpContext=16031;
   if((f->ShowModal() == mrOk)&&f->tvMain->Selected){
   oqMain->Edit();
   oqMain->FieldByName("gid")->AsInteger =gdf.gid;
   oqMain->FieldByName("gname")->AsString = gdf.Name;
  }
  delete f;
}
//---------------------------------------------------------------------------
void __fastcall TfmTypePart::oqMainAfterEdit(TDataSet *DataSet)
{
 btSave->Enabled=true;
 btClone->Enabled = !(oqMain->FieldByName("OWMID")->IsNull);
}
//---------------------------------------------------------------------------
void __fastcall TfmTypePart::btClearClick(TObject *Sender)
{
  if(!(oqMain->RecordCount&&oqMain->FieldByName("mid")->AsInteger==oqMain->FieldByName("owmid")->AsInteger))
    return;
  if(grMain->Col==3&&oqMain->FieldByName("pmid")->AsInteger){
    if(MessageBox(Handle,AnsiString(Reconst_smes64_3+oqMain->FieldByName("pname")->AsString+">?").c_str(),Application->Title.c_str(),MB_YESNO|MB_ICONQUESTION|MB_DEFBUTTON2)==IDYES){
      oqMain->Edit();
      oqMain->FieldByName("pmid")->Clear();
      oqMain->FieldByName("pname")->Clear();
    }
  }
  if(grMain->Col==4&&oqMain->FieldByName("gid")->AsInteger){
    if(MessageBox(Handle,AnsiString(Reconst_smes64_3+oqMain->FieldByName("gname")->AsString+">?").c_str(),Application->Title.c_str(),MB_YESNO|MB_ICONQUESTION|MB_DEFBUTTON2)==IDYES){
      oqMain->Edit();
      oqMain->FieldByName("gid")->Clear();
      oqMain->FieldByName("gname")->Clear();
      btSave->Enabled=true;
    }
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmTypePart::grMainTitleClick(TColumnEh *Column)
{
  TColumnEh *tCol = dynamic_cast<TColumnEh *>(Column);
  int ACol=tCol->Index;
  vRead(Mid,ACol);
}
//---------------------------------------------------------------------------
void __fastcall TfmTypePart::tbExportClick(TObject *Sender)
{
  TdmMain::SaveTable(this,grMain,Reconst_smes64_5+Name);
}
//---------------------------------------------------------------------------
void __fastcall TfmTypePart::BitBtn1Click(TObject *Sender)
{
 if(Sender== btSave)
 {
 vSave(this);
 }
 if(Sender== BitBtn1)
 {
 vSave(this);
 Close();
 }
}
//---------------------------------------------------------------------------
void __fastcall TfmTypePart::btAddClick(TObject *Sender)
{
  insertclone = false;
  oqMain->Insert();
}
//---------------------------------------------------------------------------
void __fastcall TfmTypePart::btCloneClick(TObject *Sender)
{
  if(oqMain->FieldByName("OWMID")->IsNull)
    return;
  c_owname = oqMain->FieldByName("OWNAME")->AsString;
  c_pname = oqMain->FieldByName("pname")->AsString;
  c_gname = oqMain->FieldByName("gname")->AsString;
  c_pmid = oqMain->FieldByName("pmid")->IsNull ? -1 : oqMain->FieldByName("pmid")->AsInteger;
  c_gid = oqMain->FieldByName("gid")->IsNull ? -1 : oqMain->FieldByName("gid")->AsInteger;
  c_dregime = oqMain->FieldByName("dregime")->AsDateTime;
  c_nshift = oqMain->FieldByName("nshift")->AsInteger;
  c_ntype = oqMain->FieldByName("ntype")->AsInteger;
  insertclone = true;
  oqMain->Insert();
}
//---------------------------------------------------------------------------
void __fastcall TfmTypePart::grMainEnter(TObject *Sender)
{
  if(grMain->SelectedIndex==0) grMain->SelectedIndex=1;
}
//---------------------------------------------------------------------------
void __fastcall TfmTypePart::grMainKeyDown(TObject *Sender, WORD &Key,
      TShiftState Shift)
{
  bool b=true;
  if (grMain->SelectedIndex==2&&Key == VK_RETURN)
          grNameColumns2EditButtonClick(Sender,b);
  b=true;
  if (grMain->SelectedIndex==3&&Key == VK_RETURN)
          grNameColumns3EditButtonClick(Sender,b);
}
//---------------------------------------------------------------------------
void __fastcall TfmTypePart::oqMainAfterInsert(TDataSet *DataSet)
{
  if (insertclone)
  { DataSet->FieldByName("owmid")->AsInteger = Mid;
    DataSet->FieldByName("OWNAME")->AsString = c_owname;
    DataSet->FieldByName("dstart")->AsDateTime = Date();
    DataSet->FieldByName("pname")->AsString = c_pname;
    DataSet->FieldByName("gname")->AsString = c_gname;
    if (c_pmid == -1)
      DataSet->FieldByName("pmid")->SetData(NULL);
    else
      DataSet->FieldByName("pmid")->AsInteger = c_pmid;
    if (c_gid == -1)
      DataSet->FieldByName("gid")->SetData(NULL);
    else
      DataSet->FieldByName("gid")->AsInteger = c_gid;
    if ((int)c_dregime > 0)
      DataSet->FieldByName("dregime")->AsDateTime = c_dregime;
    DataSet->FieldByName("nshift")->AsInteger=c_nshift;
    DataSet->FieldByName("ntype")->AsInteger=c_ntype;
    btSave->Enabled=true;
    insertclone = false;
  }
  else
  { DataSet->FieldByName("owmid")->AsInteger=Mid;
    DataSet->FieldByName("OWNAME")->AsString=Name;
    DataSet->FieldByName("dstart")->AsDateTime=Date();
    DataSet->FieldByName("nshift")->AsInteger=0;
    DataSet->FieldByName("ntype")->AsInteger=0;
    btSave->Enabled=true;
  }
  btClone->Enabled = !oqMain->FieldByName("OWMID")->IsNull;
}
//---------------------------------------------------------------------------
void __fastcall TfmTypePart::oqMainAfterOpen(TDataSet *DataSet)
{
  btClone->Enabled = !oqMain->FieldByName("OWMID")->IsNull;
}
//---------------------------------------------------------------------------

