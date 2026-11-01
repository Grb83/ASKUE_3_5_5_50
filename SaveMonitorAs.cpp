//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#include "unDataMod.h"
#include "SaveMonitorAs.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma resource "*.dfm"
TfmSaveMonitorAs *fmSaveMonitorAs;
//---------------------------------------------------------------------------
__fastcall TfmSaveMonitorAs::TfmSaveMonitorAs(TComponent* Owner)
	: TForm(Owner)
{
     TreeIsEdit = false;
     ReadTreeNode(NULL);
     ActiveControl = eMonitorName;
     Monitors_Del = NULL;
     Monitors_Del_Count = 0;
}
//---------------------------------------------------------------------------
__fastcall TfmSaveMonitorAs::~TfmSaveMonitorAs()
{
    if(Monitors_Del) delete[] Monitors_Del;
}
//---------------------------------------------------------------------------
bool __fastcall TfmSaveMonitorAs::ReadTreeNode(TTreeNode* NodeParent)// Читает ветку дерева
{

  stMonitors *PTreeMonitors;
  TTreeNode *AddNode;


  try{
        dmMain->oqCursor->Params->Clear();
        dmMain->oqCursor->SQL->Text="begin "+SchemeName+"interior_pg.MonitorList_ReadTreeN_p(:par1,:par2,:par3,:par4);end;";
        dmMain->oqCursor->ParamByName("par4")->DataType=ftCursor;
        dmMain->oqCursor->ParamByName("par4")->ParamType=ptOutput;
        dmMain->oqCursor->ParamByName("par1")->AsInteger=(NodeParent)?1:0;
        dmMain->oqCursor->ParamByName("par2")->AsInteger=UserRol.Monitor;
        if(NodeParent)
        dmMain->oqCursor->ParamByName("par3")->AsInteger=((stMonitors*)NodeParent->Data)->Monitor_Id;
        else
        dmMain->oqCursor->ParamByName("par3")->Clear();
        dmMain->oqCursor->Execute();

            while(!dmMain->oqCursor->Eof){
            PTreeMonitors=new stMonitors;
            ZeroMemory(PTreeMonitors,sizeof(stMonitors));
            PTreeMonitors->HaveChild = dmMain->oqCursor->FieldByName("HaveChild")->AsInteger;
            PTreeMonitors->Monitor_Id = dmMain->oqCursor->FieldByName("Monitor_Id")->AsInteger;
            PTreeMonitors->MSchema = dmMain->oqCursor->FieldByName("MSchema")->AsInteger;
            strcpy(PTreeMonitors->Name,dmMain->oqCursor->FieldByName("Name")->AsString.c_str());
            PTreeMonitors->DSize = dmMain->oqCursor->FieldByName("DSize")->AsInteger;
            PTreeMonitors->State = 0;
            AddNode = tvMonitors->Items->AddChildObject(NodeParent,PTreeMonitors->Name,PTreeMonitors);
            AddNode->ImageIndex =(PTreeMonitors->DSize>0)?1:0;
            AddNode->SelectedIndex=(PTreeMonitors->DSize>0)?1:0;
            AddNode->HasChildren = PTreeMonitors->HaveChild;
            dmMain->oqCursor->Next();
            }
      

  }catch (Exception &exception){

  	Application->ShowException(&exception);
    return false;
  }
  
  return true;
}

//---------------------------------------------------------------------------

void __fastcall TfmSaveMonitorAs::tvMonitorsCollapsed(TObject *Sender,
      TTreeNode *Node)
{
    if(Node&&Node->ImageIndex==2)
    {
      Node->SelectedIndex = 0;
      Node->ImageIndex = 0;
    }
}
//---------------------------------------------------------------------------

void __fastcall TfmSaveMonitorAs::tvMonitorsExpanded(TObject *Sender,
      TTreeNode *Node)
{
    if(Node&&Node->ImageIndex==0)
    {
      Node->SelectedIndex = 2;
      Node->ImageIndex = 2;
    }
}
//---------------------------------------------------------------------------

void __fastcall TfmSaveMonitorAs::tvMonitorsExpanding(TObject *Sender,
      TTreeNode *Node, bool &AllowExpansion)
{
    if(Node&&Node->HasChildren&&!Node->getFirstChild())
      ReadTreeNode(Node);
}
//---------------------------------------------------------------------------

void __fastcall TfmSaveMonitorAs::AddInsGroup(TTreeNode *Node)
{
   TTreeNode *AddNode;
   stMonitors *PTreeMonitors;
   if(Node&&(((stMonitors*)Node->Data)->DSize>0)) return;
   PTreeMonitors = new stMonitors;
   PTreeMonitors->Monitor_Id = 0;
   PTreeMonitors->MSchema = UserRol.Monitor;
   strcpy(PTreeMonitors->Name, Reconst_smes57_1.c_str());
   PTreeMonitors->Monitor_Id = -1;
   PTreeMonitors->DSize = 0;
   PTreeMonitors->State = 1;
   if(Node) Node->Expand(false);
   AddNode = tvMonitors->Items->AddChildObject(Node,PTreeMonitors->Name,PTreeMonitors);
   AddNode->ImageIndex = 0;
   AddNode->SelectedIndex = 0;
   AddNode->Selected = true;
   TreeIsEdit = true;
}
//---------------------------------------------------------------------------

void __fastcall TfmSaveMonitorAs::bbAddGroupClick(TObject *Sender)
{
     if(tvMonitors->Selected)
         AddInsGroup(tvMonitors->Selected->Parent);
     else
         AddInsGroup(NULL);
}
//---------------------------------------------------------------------------

void __fastcall TfmSaveMonitorAs::bbInsGroupClick(TObject *Sender)
{
     if(tvMonitors->Selected)
        AddInsGroup(tvMonitors->Selected);
}
//---------------------------------------------------------------------------

void __fastcall TfmSaveMonitorAs::tvMonitorsChange(TObject *Sender,
      TTreeNode *Node)
{
     if(Node&&((stMonitors*)Node->Data)->DSize>0) eMonitorName->Text = Node->Text;
}
//---------------------------------------------------------------------------


void __fastcall TfmSaveMonitorAs::tvMonitorsEdited(TObject *Sender,
      TTreeNode *Node, AnsiString &S)
{
      strcpy(((stMonitors*)Node->Data)->Name, S.c_str());
      ((stMonitors*)Node->Data)->State = ((stMonitors*)Node->Data)->State==1?1:2;
      TreeIsEdit = true;
}
//---------------------------------------------------------------------------


void __fastcall TfmSaveMonitorAs::FormCloseQuery(TObject *Sender,
      bool &CanClose)
{
      if(TreeIsEdit)
      {
         CanClose = false;
         switch(Application->MessageBox(Reconst_smes57_2.c_str(),Application->Title.c_str(),MB_YESNOCANCEL|MB_ICONQUESTION|MB_DEFBUTTON1))
         {
             case IDYES: tvMonitorsSave(); CanClose = true; break;
             case IDNO: CanClose = true; break;
         }
      }
}
//---------------------------------------------------------------------------
bool __fastcall TfmSaveMonitorAs::tvMonitorsSave()
{
   TTreeNode *Node;
   stMonitors Mon;
   short indic;
   if(!TreeIsEdit) return true;
   //GRB ADD 16.04.2020 - test trouble ODAC
   dmMain->quMain->Params->Clear();
   //END ADD 
   dmMain->quMain->SQL->Text="begin "
                " if :par5>1 then  "+SchemeName+" editmonitors_pg.upd_p(:par1,:par2,:par3,:par4,-1,NULL,0);  "
                " else  "+SchemeName+"editmonitors_pg.ins_p(:par2,:par3,:par4,0,NULL,0,:par1); "
                "  end if; "
                "end;";
   Node = tvMonitors->Items->GetFirstNode();
   try {
      while(Node)
          {
              if(((stMonitors*)Node->Data)->State>0)
              {
                  memcpy(&Mon,(stMonitors*)Node->Data,sizeof(Mon));
                  dmMain->quMain->ParamByName("par1")->DataType=ftInteger;
                  dmMain->quMain->ParamByName("par1")->ParamType=ptInputOutput;
                  dmMain->quMain->ParamByName("par1")->AsInteger= Mon.Monitor_Id;
                  if(Node->Parent){
                    Mon.HaveChild = ((stMonitors*)Node->Parent->Data)->Monitor_Id;
                    dmMain->quMain->ParamByName("par2")->AsInteger= Mon.HaveChild;
                  }else
                    dmMain->quMain->ParamByName("par2")->Clear();
                  dmMain->quMain->ParamByName("par3")->AsInteger= Mon.MSchema;
                  dmMain->quMain->ParamByName("par4")->AsString = Mon.Name;
                  dmMain->quMain->ParamByName("par5")->AsInteger= Mon.State;
                  dmMain->quMain->Execute();
                  Mon.Monitor_Id = dmMain->quMain->ParamByName("par1")->AsInteger;
                  ((stMonitors*)Node->Data)->Monitor_Id = Mon.Monitor_Id;
              }
              Node = Node->GetNext();
          }
    }
    catch(Exception &e)
    {
         dmMain->orases->Rollback();
         Node->Selected = true;
         Application->ShowException(&e);
         return false;
    }
     //GRB ADD 16.04.2020 - test trouble ODAC
     dmMain->quMain->Params->Clear();
     //END ADD 
    dmMain->quMain->SQL->Text="begin  "+SchemeName+"editmonitors_pg.del_p(:par1); end;";


    for(int i=0; Monitors_Del&&i<Monitors_Del_Count; i++)
    {
       Mon.Monitor_Id = Monitors_Del[i];
       dmMain->quMain->ParamByName("par1")->AsInteger=Mon.Monitor_Id;
       dmMain->quMain->Execute();
    }

    dmMain->orases->Commit();
    Monitors_Del_Count = 0;
    if(Monitors_Del) delete[] Monitors_Del;
    Monitors_Del = NULL;
    Node = tvMonitors->Items->GetFirstNode();
    while(Node)
    {
        ((stMonitors*)Node->Data)->State = 0;
        Node = Node->GetNext();
    }
    TreeIsEdit = false;
    return true;
}
//---------------------------------------------------------------------------

void __fastcall TfmSaveMonitorAs::bbEditClick(TObject *Sender)
{
     if(tvMonitors->Selected)
       tvMonitors->Selected->EditText();
}
//---------------------------------------------------------------------------

void __fastcall TfmSaveMonitorAs::btOkClick(TObject *Sender)
{
    if(!tvMonitorsSave()) return;// Сохраняем дерево
    TTreeNode *ParentNode;
    if(FWinType==wtSaveAs)
    {
        if(tvMonitors->Selected)
            ParentNode = ((stMonitors*)tvMonitors->Selected->Data)->DSize>0 ?
                tvMonitors->Selected->Parent:
                tvMonitors->Selected;
        if(!tvMonitors->Selected || !ParentNode)
            throw Exception(Reconst_smes57_3);
        if((eMonitorName->Text.Trim().Length()==0)||(eMonitorName->Text.Trim()==Reconst_smes57_4))
            throw Exception(Reconst_smes57_5);
        nParent = ((stMonitors*)ParentNode->Data)->Monitor_Id;
        if(FindMonitorName(ParentNode))
            switch(Application->MessageBox(Reconst_smes57_6.c_str(),
                                           Application->Title.c_str(),MB_YESNOCANCEL|MB_DEFBUTTON3|MB_ICONWARNING))
            {
            case ID_NO: ModalResult = mrCancel; return;
            case ID_YES: Monitor_Id = ((stMonitors*)tvMonitors->Selected->Data)->Monitor_Id; break;
            case ID_CANCEL: return;
            }
        else
            Monitor_Id = -1;
    }
    ModalResult = mrOk;
}
//---------------------------------------------------------------------------

bool __fastcall TfmSaveMonitorAs::FindMonitorName(TTreeNode *aNode)
{
         TTreeNode *Node = aNode;
    Node->Expand(false);
    Node = Node->getFirstChild();
    while(Node)
    {
       if((Node->Text==eMonitorName->Text)&&((stMonitors*)Node->Data)->DSize>0)
       {
           Node->Selected = true;
           return true;
       }
       Node = Node->GetNextChild(Node);
    }
    return false;
}
//---------------------------------------------------------------------------

int __fastcall TfmSaveMonitorAs::ShowModal_Form(WindowType aWinType)
{
    FWinType = aWinType;
    switch(aWinType)
    {
         case wtSaveAs: Caption = Reconst_smes57_7;
                        Panel2->Visible = true;
                        break;
         case wtEdit:   Caption = Reconst_smes57_8;
                        Panel2->Visible = false;
                        break;
    }
    return ShowModal();
}

//---------------------------------------------------------------------------

void __fastcall TfmSaveMonitorAs::bbDelClick(TObject *Sender)
{
    if(tvMonitors->Selected&&Application->MessageBox(AnsiString(Reconst_smes57_9+tvMonitors->Selected->Text+"?").c_str(),
                  Application->Title.c_str(),MB_YESNO|MB_DEFBUTTON2|MB_ICONQUESTION)==ID_YES)
    {
           tvMonitors->Selected->Delete();
           TreeIsEdit = true;
    }
}
//---------------------------------------------------------------------------

void __fastcall TfmSaveMonitorAs::tvMonitorsDeletion(TObject *Sender,
      TTreeNode *Node)
{
        if(((stMonitors*)Node->Data)->State!=1)
        {
              Monitors_Del_Count++;
              if(!Monitors_Del)
                Monitors_Del = new long[1];
              else
                Monitors_Del = (long*)realloc(Monitors_Del, (Monitors_Del_Count*sizeof(long)));
              Monitors_Del[Monitors_Del_Count-1] = ((stMonitors*)Node->Data)->Monitor_Id;
        }
        delete (stMonitors*)Node->Data;
}
//---------------------------------------------------------------------------

void __fastcall TfmSaveMonitorAs::tvMonitorsDragOver(TObject *Sender,
      TObject *Source, int X, int Y, TDragState State, bool &Accept)
{
   TTreeNode*accNode = tvMonitors->GetNodeAt(X, Y);
   TTreeNode*movNode = tvMonitors->Selected;
   if(accNode&&(accNode->ImageIndex==1 || accNode==movNode->Parent)||(!accNode&&movNode->ImageIndex==1))
   {
      Accept = false;
      return;
   }
}
//---------------------------------------------------------------------------

void __fastcall TfmSaveMonitorAs::tvMonitorsDragDrop(TObject *Sender,
      TObject *Source, int X, int Y)
{
   TTreeNode*accNode = tvMonitors->GetNodeAt(X, Y);
   TTreeNode*movNode = tvMonitors->Selected;
   if(!movNode||!accNode)
    return;
   if(accNode&&accNode->HasChildren&&!accNode->getFirstChild())
     ReadTreeNode(accNode);
   stMonitors* mov = ((stMonitors*)movNode->Data);
   //if(accNode)
   movNode->MoveTo(accNode, naAddChild);
   //else movNode->MoveTo(tvMonitors->Items->GetFirstNode(), naAdd);
   if(mov&&!mov->State) mov->State = 2;
   TreeIsEdit = true;
}
//---------------------------------------------------------------------------









