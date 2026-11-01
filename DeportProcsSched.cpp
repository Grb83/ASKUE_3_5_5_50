//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#include "DeportProcsSched.h"
#include "unDataMod.h"
#include "DeportProcRun.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TfmDeportProcsSched *fmDeportProcsSched;
//---------------------------------------------------------------------------
__fastcall TfmDeportProcsSched::TfmDeportProcsSched(TComponent* Owner)
  : TForm(Owner)
{
  SelProcess = NULL;
}
//---------------------------------------------------------------------------
void __fastcall TfmDeportProcsSched::Button4Click(TObject *Sender)
{
  Close();
}
//---------------------------------------------------------------------------
void __fastcall TfmDeportProcsSched::bbRunProcessClick(TObject *Sender)
{
  if(SelProcess)
    DeportProcedureRun(SelProcess->nMaket,this);
}
//---------------------------------------------------------------------------
void __fastcall TfmDeportProcsSched::ReadProcesses(TTreeNode *ParentNode, bool addfolders)
{
  int ind;
  stProcesses *PProcesses;
  TListItem *LI;
  // уже прочитаную ветку дерева не читаем
  if (addfolders&&ParentNode&&ParentNode->getFirstChild()&&ParentNode->getFirstChild()->Data)
    return;
  lvProcess->OnChange = NULL;
  ProcessTree->OnChange = NULL;
  try
  {
    if(ParentNode && addfolders){
      ParentNode->DeleteChildren();
    }
    if(ProcessTree->Selected==ParentNode){
      lvProcess->Clear();
    }

    dmMain->oqCursor->Close();
    dmMain->oqCursor->Params->Clear();
    dmMain->oqCursor->SQL->Text="begin "+SchemeName+"file_pg.read_processes_sh(:par1,:par2,:par3); end;";

    if (ParentNode && ParentNode->Data){
      dmMain->oqCursor->ParamByName("par1")->AsInteger=((stProcesses*)ParentNode->Data)->nMaket;
      dmMain->oqCursor->ParamByName("par2")->AsInteger=((stProcesses*)ParentNode->Data)->NType;
    }else{
      dmMain->oqCursor->ParamByName("par1")->Clear();
      dmMain->oqCursor->ParamByName("par2")->Clear();
    }
    dmMain->oqCursor->ParamByName("par3")->ParamType = ptOutput;
    dmMain->oqCursor->ParamByName("par3")->DataType = ftCursor;
    dmMain->oqCursor->Execute();

    TTreeNode *addNode;
    while(!dmMain->oqCursor->Eof){
       PProcesses = new stProcesses;
       ZeroMemory(PProcesses,sizeof(stProcesses));
       PProcesses->NType = dmMain->oqCursor->FieldByName("ntype")->AsInteger;
       PProcesses->nMaket = dmMain->oqCursor->FieldByName("nmaket")->AsInteger;
       strcpy(PProcesses->vName,dmMain->oqCursor->FieldByName("vname")->AsString.c_str());
       PProcesses->nProcedure = dmMain->oqCursor->FieldByName("nprocedure")->AsInteger;
       strcpy(PProcesses->vNote,dmMain->oqCursor->FieldByName("vnote")->AsString.c_str());
       strcpy(PProcesses->vPeriod,dmMain->oqCursor->FieldByName("nperiod")->AsString.c_str());
       PProcesses->nShift = dmMain->oqCursor->FieldByName("nshift")->AsInteger;
       strcpy(PProcesses->vParam,dmMain->oqCursor->FieldByName("vparam")->AsString.c_str());
       strcpy(PProcesses->vError,dmMain->oqCursor->FieldByName("verror")->AsString.c_str());
       strcpy(PProcesses->vNextCreated,dmMain->oqCursor->FieldByName("NextCreated")->AsString.c_str());
       PProcesses->nCycle = dmMain->oqCursor->FieldByName("ncycle")->AsInteger;
       PProcesses->nBlock = dmMain->oqCursor->FieldByName("nblock")->AsInteger;
       strcpy(PProcesses->vProcedure,dmMain->oqCursor->FieldByName("vProcedure")->AsString.c_str());
       strcpy(PProcesses->vLastCreated,dmMain->oqCursor->FieldByName("vLastCreated")->AsString.c_str());

       if (dmMain->oqCursor->FieldByName("isfolder")->AsInteger==1){ // строим ветку дерева папок
         if (addfolders){
           addNode = ProcessTree->Items->AddChildObject(ParentNode, PProcesses->vName, PProcesses);
           ind = GetFolderInd(addNode, PProcesses->nBlock);
           addNode->ImageIndex = ind;
           addNode->SelectedIndex = ind;
           if(dmMain->oqCursor->FieldByName("HaveChild")->AsInteger){  // проверка на наличие дочерних
             ProcessTree->Items->AddChildObject(addNode,"",(void*)0);
           }
         }
       }else{  // строим список содержимого папки в дереве
         if (ProcessTree->Selected==ParentNode){
           LI = lvProcess->Items->Add();
           LI->ImageIndex = PProcesses->nBlock;
           LI->StateIndex = PProcesses->nBlock;
           LI->Data = PProcesses;
           LI->SubItems->Add(PProcesses->vName);
           LI->SubItems->Add(PProcesses->vProcedure);
           LI->SubItems->Add(PProcesses->nShift);
           LI->SubItems->Add(PProcesses->vPeriod);
           LI->SubItems->Add(PProcesses->vLastCreated);
           LI->SubItems->Add(PProcesses->vNextCreated);
         }
       }

       dmMain->oqCursor->Next();
       }
       dmMain->oqCursor->Close();
  }catch (Exception &exception){
    lvProcess->OnChange = lvProcessChange;
    ProcessTree->OnChange = ProcessTreeChange;
    Application->ShowException(&exception);
  }
  ProcessTree->OnChange = ProcessTreeChange;
  lvProcess->OnChange = lvProcessChange;
  if(lvProcess->Items->Count){
    bbRunProcess->Enabled = true;
    lvProcess->Selected = lvProcess->Items->Item[0];
  }else
    bbRunProcess->Enabled = false;
}
//---------------------------------------------------------------------------
void __fastcall TfmDeportProcsSched::FormShow(TObject *Sender)
{
  ReadProcesses(NULL,true);
  ProcessTree->SetFocus();
  lvProcessChange(lvProcess,NULL,ctState);
  lvProcess->OnChange = lvProcessChange;
  if(lvProcess->Items->Count)
    lvProcess->Selected = lvProcess->Items->Item[0];
}
//---------------------------------------------------------------------------
void __fastcall TfmDeportProcsSched::lvProcessChange(TObject *Sender,
      TListItem *Item, TItemChange Change)
{
    SelProcess = NULL;
    for(int i=0; i<ComponentCount; i++)
    {
        if(dynamic_cast<TCustomEdit*>(Components[i]))
          ((TCustomEdit*)Components[i])->Clear();
        if(dynamic_cast<TComboBox*>(Components[i]))
          ((TComboBox*)Components[i])->ItemIndex = -1;
        if(dynamic_cast<TCheckBox*>(Components[i]))
        {
          ((TCheckBox*)Components[i])->Checked = false;
//          ControlChange(Components[i]);
        }
        if(dynamic_cast<TMemo*>(Components[i]))
          ((TMemo*)Components[i])->Clear();
    }
    if(!Item || !Item->Data)
       return;
    SelProcess = (stProcesses*)Item->Data;
    eNote->Text = SelProcess->vNote;
    eParam->Text = SelProcess->vParam;
    eError->Text = SelProcess->vError;
}
//---------------------------------------------------------------------------
void __fastcall TfmDeportProcsSched::lvProcessDeletion(TObject *Sender,
      TListItem *Item)
{
  if (Item)
    delete (stDeportProc*)Item->Data;
}
//---------------------------------------------------------------------------
int __fastcall TfmDeportProcsSched::GetFolderInd(TTreeNode* Node, bool blocked)
{
   int ind;
   if(blocked)
   {
      ind = Node->Expanded?5:4;
   }else{
      ind = Node->Expanded?3:2;
   }
   return ind;
}
//---------------------------------------------------------------------------
void __fastcall TfmDeportProcsSched::ProcessTreeExpanding(TObject *Sender,
      TTreeNode *Node, bool &AllowExpansion)
{
  ProcessTree->OnChange = NULL;
  ReadProcesses(Node,true);
  ProcessTree->OnChange = ProcessTreeChange;
}
//---------------------------------------------------------------------------
void __fastcall TfmDeportProcsSched::ProcessTreeDeletion(TObject *Sender,
      TTreeNode *Node)
{
  if(Node)
    delete (stProcesses*)Node->Data;
}
//---------------------------------------------------------------------------
void __fastcall TfmDeportProcsSched::ProcessTreeExpanded(TObject *Sender,
      TTreeNode *Node)
{
   if(!Node || !Node->Data) return;

   Node->ImageIndex = GetFolderInd(Node, ((stProcesses*)Node->Data)->nBlock);
   Node->SelectedIndex = Node->ImageIndex;
}
//---------------------------------------------------------------------------
void __fastcall TfmDeportProcsSched::ProcessTreeChange(TObject *Sender,
      TTreeNode *Node)
{
  ReadProcesses(Node,false);
}
//---------------------------------------------------------------------------



