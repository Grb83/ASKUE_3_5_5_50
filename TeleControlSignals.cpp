//---------------------------------------------------------------------------
#include <vcl.h>
#include <stdio.h>

#pragma hdrstop
#include "SelectSvitchPoint.h"
#include "TeleControlSignals.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma link "MemDS"
#pragma link "VirtualTable"
#pragma link "DBGridEh"
#pragma link "DBGridEh"
#pragma link "Main"
#pragma link "MemDS"
#pragma link "VirtualTable"
#pragma link "DBAccess"
#pragma link "Ora"
#pragma resource "*.dfm"
//---------------------------------------------------------------------------
TItemData::TItemData()
{
  NParam = 0;
  Modified = true;
}
//---------------------------------------------------------------------------
TItemData::TItemData(long aNParam)
{
  NParam = aNParam;
  Modified = false;
}
//---------------------------------------------------------------------------
__fastcall TFormTeleControlSignals::TFormTeleControlSignals(TComponent* Owner, AnsiString Name, TAccess a)
	: TMainForm(Owner, Name, a)
{
   ShowAction(iaNew);
   ShowAction(iaDelete);
}
//---------------------------------------------------------------------------
__fastcall TFormTeleControlSignals::~TFormTeleControlSignals()
{
}
//---------------------------------------------------------------------------
void __fastcall TFormTeleControlSignals::vNew(TObject *Sender)
{
  NewParam();
  EditRec = true;
}
//---------------------------------------------------------------------------
void __fastcall TFormTeleControlSignals::vDelete(TObject *Sender)
{
  DeleteParam();
  EditRec = true;
}
//---------------------------------------------------------------------------
void __fastcall TFormTeleControlSignals::vParams(TObject *Sender)
{

}
//---------------------------------------------------------------------------
void TFormTeleControlSignals::ClearList()
{
   ParamsList->OnChanging = NULL;
   for(int i = 0; i < ParamsList->Items->Count; i++)
   {
     if (!ParamsList->Items->Item[i]->Data) continue;
     delete ParamsList->Items->Item[i]->Data;
   }
   ParamsList->Items->Clear();
   ParamsList->OnChanging = ParamsListChanging;
}
//---------------------------------------------------------------------------
void TFormTeleControlSignals::LoadConditions(long NParam)
{
  LoadingConditions = true;
  try
  {
    lbTitle->Caption=(ParamsList->Selected)?ParamsList->Selected->Text:AnsiString("");

    ConditionsVTable->DisableControls();
    ConditionsVTable->Open();
    ConditionsVTable->Clear();

    dmMain->oqCursor->Params->Clear();
    dmMain->oqCursor->SQL->Text="begin "+SchemeName+"TC_PG.loadinfo(:par1,:par2); end;";
    dmMain->oqCursor->ParamByName("par1")->AsInteger=NParam;
    dmMain->oqCursor->ParamByName("par2")->ParamType = ptOutput;
    dmMain->oqCursor->ParamByName("par2")->DataType = ftCursor;
    dmMain->oqCursor->Execute();
    while(!dmMain->oqCursor->Eof){
         ConditionsVTable->Append();
         ConditionsVTable->FieldByName("DStart")->AsString  = dmMain->oqCursor->FieldByName("DStartStr")->AsString;
         ConditionsVTable->FieldByName("VCondition")->AsString  = dmMain->oqCursor->FieldByName("VCONDITION")->AsString;
         ConditionsVTable->Post();
       dmMain->oqCursor->Next();
       }
   }
  __finally
  {
    
    ConditionsVTable->EnableControls();
    ConditionsVTable->First();
    LoadingConditions = false;
  }
  EditRec=false;
}
//---------------------------------------------------------------------------
void TFormTeleControlSignals::SaveConditions(long NParam)
{
  oqSaveConditions->Session=dmMain->orases;
  if ((ConditionsVTable->State == dsEdit) ||
       (ConditionsVTable->State == dsInsert))
     ConditionsVTable->Post();
  //т.к. прцедура редактирования БД не работает с пустыми массивами

 try{
   oqSaveConditions->ParamByName("par1")->AsInteger=NParam;
   for(int i=2;i<=3;i++){
     oqSaveConditions->ParamByName("par"+IntToStr(i))->Length=1;
     oqSaveConditions->ParamByName("par"+IntToStr(i))->Clear();
   }

   ConditionsVTable->DisableControls();
   ConditionsVTable->First();
   int cnt = 0;
   while(!ConditionsVTable->Eof){
     cnt++;
     for(int i=2;i<=3;i++)
       oqSaveConditions->ParamByName("par"+IntToStr(i))->Length=cnt;
     oqSaveConditions->ParamByName("par2")->ItemAsString[cnt]=ConditionsVTable->FieldByName("DStart")->AsString;
     oqSaveConditions->ParamByName("par3")->ItemAsString[cnt]=ConditionsVTable->FieldByName("VCondition")->AsString;
     ConditionsVTable->Next();
   }
   oqSaveConditions->Execute();
   dmMain->orases->Commit();
   }__finally{
     ConditionsVTable->First();
     ConditionsVTable->EnableControls();
   }
   EditRec=false;
}
//---------------------------------------------------------------------------
void TFormTeleControlSignals::LoadParams()
{
  ParamsList->OnChanging = NULL;
  ClearList();
  DelItemsCount = 0;

  dmMain->oqCursor->Params->Clear();
  dmMain->oqCursor->SQL->Text="begin "+SchemeName+"TC_PG.loadparams(:par1); end;";
  dmMain->oqCursor->ParamByName("par1")->ParamType = ptOutput;
  dmMain->oqCursor->ParamByName("par1")->DataType = ftCursor;
  dmMain->oqCursor->Execute();
  while(!dmMain->oqCursor->Eof){
    AddParam(dmMain->oqCursor->FieldByName("NPARAM")->AsInteger,dmMain->oqCursor->FieldByName("VNAME")->AsString);
    dmMain->oqCursor->Next();
  }
  if (ParamsList->Items->Count > 0)
    ParamsList->Selected = ParamsList->Items->Item[0];
  ParamsList->OnChanging = ParamsListChanging;
}
//---------------------------------------------------------------------------
TTreeNode* TFormTeleControlSignals::AddParam(long id, AnsiString Name)
{
   TTreeNode* newItem;
   newItem = ParamsList->Items->Add(NULL,Name);
   newItem->Data = new TItemData(id);
   newItem->ImageIndex=3;
   newItem->SelectedIndex=3;
   return newItem;
}
//---------------------------------------------------------------------------
void TFormTeleControlSignals::NewParam()
{
   static int cnt = 1;
   ParamsList->Selected = AddParam(0,Reconst_smes63_1 + IntToStr(cnt++));
   ParamsList->SetFocus();
}
//---------------------------------------------------------------------------
void TFormTeleControlSignals::DeleteParam()
{
  TTreeNode* selItem;
  selItem = ParamsList->Selected;
  if (!selItem) return;
  long id = ((TItemData*)selItem->Data)->NParam;
  if (id != 0) DelItems[DelItemsCount++] = id;
  selItem->Delete();
}
//---------------------------------------------------------------------------
void TFormTeleControlSignals::SaveParams()
{
  char VName[150];
  long NParam;
  TItemData* ItemData;
  //GRB ADD 16.04.2020 - test trouble ODAC
  dmMain->quMain->Params->Clear();
  //END ADD 
  dmMain->quMain->SQL->Text="begin if :par1>0 then "+SchemeName+"tc_pg.upd_params(:par1,:par2); else  "+SchemeName+"tc_pg.ins_params(:par2,:par1); end if;  end;";

  for(int i = 0; i <  ParamsList->Items->Count; i++){
       ItemData = (TItemData*)ParamsList->Items->Item[i]->Data;
       if (!ItemData->Modified)
        continue;
       dmMain->quMain->ParamByName("par1")->DataType=ftInteger;
       dmMain->quMain->ParamByName("par1")->ParamType=ptInputOutput;
       dmMain->quMain->ParamByName("par1")->AsInteger=ItemData->NParam;
       dmMain->quMain->ParamByName("par2")->AsString=ParamsList->Items->Item[i]->Text;
       try{
         dmMain->quMain->Execute();
         ItemData->tmp_NParam=dmMain->quMain->ParamByName("par1")->AsInteger;
       }catch(Exception &e){
          dmMain->orases->Rollback();
          throw;
       }
  }
  for(int i = 0; i < DelItemsCount; i++){
     //GRB ADD 16.04.2020 - test trouble ODAC
     dmMain->quMain->Params->Clear();
     //END ADD 
     dmMain->quMain->SQL->Text="begin "+SchemeName+"tc_pg.del_params(:par1); end;";
     dmMain->quMain->ParamByName("par1")->AsInteger=DelItems[i];
     try{
      dmMain->quMain->Execute();
     }catch(Exception &e){
        dmMain->orases->Rollback();
        throw;
     }
   }
  DelItemsCount = 0;
  dmMain->orases->Commit();
  for(int i = 0; i <  ParamsList->Items->Count; i++){
    if(ItemData->NParam != 0)
      continue;
    ItemData->NParam = ItemData->tmp_NParam;
  }
}
//---------------------------------------------------------------------------
void __fastcall TFormTeleControlSignals::vCheck(TObject *Sender)
{
}
//---------------------------------------------------------------------------
void __fastcall TFormTeleControlSignals::SetAccess(TAccess value)
{
   if(FAccess != value){
      TMainForm::SetAccess(value);
      bool wr = value==accWrite;
      iaNew->Enabled = wr;
      iaParams->Enabled = wr;
      iaDelete->Enabled = wr;
      iaCheck->Enabled = wr;
   }
}
//---------------------------------------------------------------------------

void __fastcall TFormTeleControlSignals::vSave(TObject* Sender)
{
   SaveParams();
   if (ParamsList->Selected)
   {
    long NParam = ((TItemData*)ParamsList->Selected->Data)->NParam;
    if (EditRec) SaveConditions(NParam);
   }
   EditRec = false;
}
//---------------------------------------------------------------------------
void __fastcall TFormTeleControlSignals::vRefresh(TObject* Sender)
{
 LoadParams();
 EditRec = false;
}

//---------------------------------------------------------------------------
void __fastcall TFormTeleControlSignals::ConditionsVTableAfterInsert(
      TDataSet *DataSet)
{
  if (LoadingConditions) return;
  /*
  static int cnt = 0;
  ConditionsVTable->FieldByName("DStart")->AsDateTime  = Now();
  ConditionsVTable->FieldByName("VCondition")->AsString  = "Condition " + IntToStr(cnt++);
  */
  EditRec = true;
}
//---------------------------------------------------------------------------

void __fastcall TFormTeleControlSignals::ConditionsVTableAfterDelete(
      TDataSet *DataSet)
{
  EditRec = true;
}
//---------------------------------------------------------------------------
void __fastcall TFormTeleControlSignals::ConditionsDBGridEnter(
      TObject *Sender)
{
   iaNew->Enabled = false;
   iaDelete->Enabled = false;
}
//---------------------------------------------------------------------------

void __fastcall TFormTeleControlSignals::ConditionsDBGridExit(
      TObject *Sender)
{
   iaNew->Enabled = true;
   iaDelete->Enabled = true;
}
//---------------------------------------------------------------------------
void __fastcall TFormTeleControlSignals::iaCloseExecute(TObject *Sender)
{
  ParamsList->OnChanging = NULL;
  Close();
}
//---------------------------------------------------------------------------
void __fastcall TFormTeleControlSignals::FormShow(TObject *Sender)
{
 vRefresh(this);
}
//---------------------------------------------------------------------------
void __fastcall TFormTeleControlSignals::ParamsListChanging(
      TObject *Sender, TTreeNode *Node, bool &AllowChange)
{
    if(!ParamsList->Selected) return;
    
    AllowChange = false;
    if (!EditRec){
      AllowChange = true;
      return;
    }

    switch(Application->MessageBox(Reconst_smes63_2.c_str(),Application->Title.c_str(),MB_YESNOCANCEL|MB_ICONQUESTION)){
       case  IDYES:
         try
          {
           SaveParams();
           SaveConditions(((TItemData*)ParamsList->Selected->Data)->NParam);
          }
         catch (Exception &exception)
         {
     	     Application->ShowException(&exception);
           return;
         }
          EditRec = false;
          AllowChange = true;
          break;
       case  IDNO:
          EditRec = false;
          AllowChange = true;
          break;
       case  IDCANCEL:
          break;
    }
}
//---------------------------------------------------------------------------

void __fastcall TFormTeleControlSignals::ParamsListEdited(TObject *Sender,
      TTreeNode *Node, AnsiString &S)
{
 ((TItemData*)Node->Data)->Modified = true;
  EditRec = true;
}
//---------------------------------------------------------------------------

void __fastcall TFormTeleControlSignals::ParamsListChange(TObject *Sender,
      TTreeNode *Node)
{
   if (!ParamsList->Selected) return;
   LoadConditions(((TItemData*)ParamsList->Selected->Data)->NParam);
}
//---------------------------------------------------------------------------

