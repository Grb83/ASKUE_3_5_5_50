//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
#include "unTree.h"
#include "unDataMod.h"
#include "unAddToTree.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "DBAccess"
#pragma link "MemDS"
#pragma link "Ora"
#pragma resource "*.dfm"
TfmTree *fmTree;
//---------------------------------------------------------------------------
__fastcall TfmTree::TfmTree(TComponent* Owner)
  : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TfmTree::FormCreate(TObject *Sender)
{
  ReadNode(NULL);
}
//---------------------------------------------------------------------------
void __fastcall TfmTree::acAddExecute(TObject *Sender)
{
    TTreeNode* ChNode;
    SFunction *sf=new SFunction;
    if(!((SFunction*)tvFunctions->Selected->Data)->ntype)
      sf->nparent=((SFunction*)tvFunctions->Selected->Data)->nid;
    else
      sf->nparent=((SFunction*)tvFunctions->Selected->Parent->Data)->nid;

    sf->ntype=1;
    TfmAddToTree *f= new  TfmAddToTree (this, sf, true);
    if(f->ShowModal()==mrOk){
      if(!((SFunction*)tvFunctions->Selected->Data)->ntype)
        ChNode=tvFunctions->Items->AddChildObject(tvFunctions->Selected,sf->vname,sf);
      else
        ChNode=tvFunctions->Items->AddChildObject(tvFunctions->Selected->Parent,sf->vname,sf);

      switch(sf->ntype){
        case 0: ChNode->ImageIndex =0;
            ChNode->SelectedIndex =0;
            break;
        case 1: ChNode->ImageIndex =2;
            ChNode->SelectedIndex =2;
            break;
        case 2: ChNode->ImageIndex =7;
            ChNode->SelectedIndex =7;
            break;
      }
    }else{
      delete sf;
    }
    delete f;
}
//---------------------------------------------------------------------------

void __fastcall TfmTree::acDelExecute(TObject *Sender)
{
  try {
 if(MessageBox(Handle,AnsiString(Reconst_smes76_1+((SFunction*)tvFunctions->Selected->Data)->vname+"?").c_str(),Application->Title.c_str(),MB_YESNO|MB_ICONQUESTION|MB_DEFBUTTON2)!=IDYES)
    return;
  oqDel->ParamByName("an_id")->AsInteger=((SFunction*)tvFunctions->Selected->Data)->nid;
  oqDel->Execute();
  dmMain->orases->Commit();
  tvFunctions->Items->Delete(tvFunctions->Selected);
 }catch (Exception &exception){
    dmMain->orases->Rollback();
  	Application->ShowException(&exception);
  }

}
//---------------------------------------------------------------------------

void __fastcall TfmTree::acEditExecute(TObject *Sender)
{
  TfmAddToTree *f= new  TfmAddToTree (this, (SFunction*) tvFunctions->Selected->Data, false);
  f->ShowModal();
  tvFunctions->Selected->Text=((SFunction*) tvFunctions->Selected->Data)->vname;
  delete f;
}
//---------------------------------------------------------------------------

void __fastcall TfmTree::acCopyExecute(TObject *Sender)
{
  if(!tvFunctions->Selected||!tvFunctions->Selected->Data)
    return;
  PostMessage((dynamic_cast<TWinControl*>(Owner))->Handle, WM_INSERT_FORMULA,(WPARAM)tvFunctions,NULL);
}
//---------------------------------------------------------------------------
void __fastcall TfmTree::tvFunctionsExpanded(TObject *Sender,
      TTreeNode *Node)
{
  SFunction *Data=(SFunction*)Node->Data;
  if (Data->ntype==0)
  {
      Node->ImageIndex=1;
      Node->SelectedIndex=1;
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmTree::tvFunctionsCollapsed(TObject *Sender,
      TTreeNode *Node)
{
   SFunction *Data=(SFunction*)Node->Data;
    if (Data->ntype==0)
    {
     Node->ImageIndex=0;
     Node->SelectedIndex=0;
    }
}
//---------------------------------------------------------------------------
void __fastcall TfmTree::tvFunctionsGetSelectedIndex(TObject *Sender,
      TTreeNode *Node)
{
 if(!tvFunctions->Selected||!tvFunctions->Selected->Data||((SFunction*)tvFunctions->Selected->Data)->ntype==0)
  acCopy->Enabled=false;
 else
  acCopy->Enabled=true;
}
//---------------------------------------------------------------------------
void __fastcall TfmTree::tvFunctionsExpanding(TObject *Sender,
      TTreeNode *Node, bool &AllowExpansion)
{
  if(Node&&Node->getFirstChild()&&!Node->getFirstChild()->Data){
    Node->DeleteChildren();
    ReadNode(Node);
  }
}
//---------------------------------------------------------------------------
// Читает ветку дерева Точек
void __fastcall TfmTree::ReadNode(TTreeNode* parNode)
{
  TTreeNode* Node;
  if(parNode)
    oqTree->ParamByName("parent")->AsInteger=((SFunction*)parNode->Data)->nid;
  else
    oqTree->ParamByName("parent")->Clear();

  oqTree->Execute();

  while(!oqTree->Eof){
   SFunction *pData=new SFunction;
   pData->nid=oqTree->FieldByName("nid")->AsInteger;
   pData->nparent=oqTree->FieldByName("nparent")->AsInteger;
   pData->ntype=oqTree->FieldByName("ntype")->AsInteger;
   pData->vname=oqTree->FieldByName("vname")->AsString;
   pData->vvalue=oqTree->FieldByName("vvalue")->AsString;
   pData->vmemo=oqTree->FieldByName("vmemo")->AsString;

   Node = tvFunctions->Items->AddChildObject(parNode, pData->vname, pData);
   switch(pData->ntype){
    case 0: Node->ImageIndex =0;
            Node->SelectedIndex =0;
            break;
    case 1: Node->ImageIndex =2;
            Node->SelectedIndex =2;
            break;
    case 2: Node->ImageIndex =7;
            Node->SelectedIndex =7;
            break;
   }


   if(oqTree->FieldByName("havechild")->AsInteger)
    tvFunctions->Items->AddChildObject(Node,"",NULL);

   oqTree->Next();
  }
}
//------------------------------------------------------------------------------
void __fastcall TfmTree::Refresh()
{
 tvFunctions->Items->BeginUpdate();
 tvFunctions->Items->Clear();
 ReadNode(NULL);
 tvFunctions->Items->EndUpdate();
}
//-------------------------------------------------------------------------------
void __fastcall TfmTree::tvFunctionsDragOver(TObject *Sender,
      TObject *Source, int X, int Y, TDragState State, bool &Accept)
{
  SetFocus();
  TTreeNode*dst = ((TTreeView*)Sender)->GetNodeAt(X, Y);
  TTreeNode*src = ((TTreeView*)Source)->Selected;

  if (dst)
    Accept=(dst!=src &&dst!=src->Parent &&(!dst->HasAsParent(src))&&(!((SFunction*)dst->Data)->ntype));

  if (Y==0) SendMessage(tvFunctions->Handle, WM_VSCROLL, SB_LINEUP, 0);
  if (Y==(tvFunctions->Height-20)) SendMessage(tvFunctions->Handle, WM_VSCROLL, SB_LINEDOWN, 0);
}
//---------------------------------------------------------------------------

void __fastcall TfmTree::tvFunctionsDragDrop(TObject *Sender,
      TObject *Source, int X, int Y)
{
   TTreeNode*Dst = ((TTreeView*)Sender)->GetNodeAt(X, Y);
   TTreeNode*Src = ((TTreeView*)Source)->Selected;
   try {
   if(!Src || !Src->Data)
    return;

  SFunction* Sf=(SFunction*)Src->Data;
   if (Dst) {
    Sf->nparent=((SFunction*)Dst->Data)->nid;
    oqSaveFunc->ParamByName("an_parent")->AsInteger=Sf->nparent;
   }
   else {
    Sf->nparent=0;
    oqSaveFunc->ParamByName("an_parent")->Clear();
   }

  oqSaveFunc->ParamByName("an_id")->AsInteger=Sf->nid;
  oqSaveFunc->ParamByName("an_type")->AsInteger=Sf->ntype;
  oqSaveFunc->ParamByName("av_name")->AsString=Sf->vname;
  oqSaveFunc->ParamByName("av_formula")->AsString=Sf->vvalue;
  oqSaveFunc->ParamByName("av_memo")->AsString=Sf->vmemo;

  oqSaveFunc->Execute();
  Src->MoveTo(Dst, naAddChild);
  dmMain->orases->Commit();
  }
    catch (Exception &exception){
    dmMain->orases->Rollback();
  	Application->ShowException(&exception);
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmTree::tvFunctionsDeletion(TObject *Sender,
      TTreeNode *Node)
{
  if(Node->Data)
    delete (SFunction*)Node->Data;
}
//---------------------------------------------------------------------------


void __fastcall TfmTree::tvFunctionsKeyDown(TObject *Sender, WORD &Key,
      TShiftState Shift)
{
if ((Shift.Contains(ssCtrl))){
 if (Key == 'X') {
    Bufer=tvFunctions->Selected;
    Bufer->Cut=true;
 }

 if (Key == 'V') {
  if (!Bufer) return;
  TTreeNode *N;
  try {
    if (!((SFunction*)tvFunctions->Selected->Data)->ntype)
      oqSaveFunc->ParamByName("an_parent")->AsInteger=((SFunction*)tvFunctions->Selected->Data)->nid;
    else oqSaveFunc->ParamByName("an_parent")->AsInteger=((SFunction*)tvFunctions->Selected->Parent->Data)->nid;

    oqSaveFunc->ParamByName("an_id")->AsInteger=((SFunction*)Bufer->Data)->nid;
    oqSaveFunc->ParamByName("an_type")->AsInteger=((SFunction*)Bufer->Data)->ntype;
    oqSaveFunc->ParamByName("av_name")->AsString=((SFunction*)Bufer->Data)->vname;
    oqSaveFunc->ParamByName("av_formula")->AsString=((SFunction*)Bufer->Data)->vvalue;
    oqSaveFunc->ParamByName("av_memo")->AsString=((SFunction*)Bufer->Data)->vmemo;

    oqSaveFunc->Execute();

    if (!((SFunction*)tvFunctions->Selected->Data)->ntype) Bufer->MoveTo(tvFunctions->Selected,naAddChild);
    else Bufer->MoveTo(tvFunctions->Selected,naAdd);
    Bufer=NULL;
    dmMain->orases->Commit();
  }
  catch (Exception &exception){
    dmMain->orases->Rollback();
  	Application->ShowException(&exception);
  }
 }
}
else return;
}
//---------------------------------------------------------------------------

