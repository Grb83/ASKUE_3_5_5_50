//---------------------------------------------------------------------------
#include <vcl.h>
#include <stdio.h>
#include <math.h>
#pragma hdrstop

#include "unDataMod.h"
#include "ManualInTree.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
#define MAXPOINT	1000
TFormManualInTree *FormManualInTree;
//---------------------------------------------------------------------------
__fastcall TFormManualInTree::TFormManualInTree(TComponent* Owner,POINTDATA* sfd)
	: TForm(Owner)
{
  _from_points = 0;
  if(!sfd) throw Exception(Reconst_smes92_1);
  pointPOL=sfd;
  paTime->Visible=pointPOL->usetime;
  paStep->Visible=!pointPOL->usetime;
  if(!pointPOL->usetime)
  {
     paStep->Top=52;
  }
  
  seltime->Text=pointPOL->myTime.FormatString("hh:nn");
  seldate->Date=pointPOL->myTime;
  RadioGroupProfilePower->ItemIndex=pointPOL->Step;
  

  fmFP=new TfmFindPoint(this);
  iaFind->OnExecute       = vFindClick;

}
//---------------------------------------------------------------------------
__fastcall TFormManualInTree::TFormManualInTree(TComponent* Owner,POINTDATA* sfd, int from_points)
	: TForm(Owner)
{
  _from_points = from_points;
  if(!sfd) throw Exception(Reconst_smes92_1);
  pointPOL=sfd;
  paTime->Visible=pointPOL->usetime;
  paStep->Visible=!pointPOL->usetime;
  if(!pointPOL->usetime)
  {
     paStep->Top=52;
  }

  seltime->Text=pointPOL->myTime.FormatString("hh:nn");
  seldate->Date=pointPOL->myTime;
  RadioGroupProfilePower->ItemIndex=pointPOL->Step;


  fmFP=new TfmFindPoint(this);
  iaFind->OnExecute       = vFindClick;

}
//---------------------------------------------------------------------------
void __fastcall TFormManualInTree::FormCreate(TObject *Sender)
{
  if(ReadNode(NULL)){
    if(tvMain->Items->Count){
      if(pointPOL->mid)
        FindCurrNode();
      else
        tvMain->Selected=tvMain->Items->Item[0];
    }else{
      paEdit->Enabled=false;
      btOk->Enabled=false;
    }
  }else{
    paEdit->Enabled=false;
    btOk->Enabled=false;
  }
}
//---------------------------------------------------------------------------
bool __fastcall TFormManualInTree::ReadNode(TTreeNode* NodeParent)// Читает ветку дерева Точек
{
    POINTSTREEDEF*pData;
   TTreeNode* Node;
  try{


   // PROCEDURE Read_Node_p(an_mid NUMBER,if_point NUMBER,acur_t OUT common_pg.tcur)
      //------------------------------------------------------------------------- VNB 05.03.2008
   dmMain->quMain->Params->Clear();
   dmMain->quMain->SQL->Text="begin "+SchemeName+"MANUAL_IN_PG.Read_Node_p(:par1,:par2,:par3);end; ";
   dmMain->quMain->ParamByName("par3")->ParamType=ptOutput;
   dmMain->quMain->ParamByName("par3")->DataType=ftCursor;
   if(!NodeParent)
    {
    dmMain->quMain->ParamByName("par1")->Clear();
    dmMain->quMain->ParamByName("par2")->Clear();
    }
   else
    {
    dmMain->quMain->ParamByName("par1")->AsInteger=((POINTSTREEDEF*)NodeParent->Data)->Mid;
    dmMain->quMain->ParamByName("par2")->AsInteger= ((POINTSTREEDEF*)NodeParent->Data)->IfPoint;
    }

     dmMain->quMain->Execute();

  while(!dmMain->quMain->Eof){
     pData = new POINTSTREEDEF;
     ZeroMemory(pData,sizeof(POINTSTREEDEF));
     pData->HaveChild=dmMain->quMain->FieldByName("HaveChild")->AsInteger;
      pData->Mid=dmMain->quMain->FieldByName("mid")->AsInteger;
      pData->Type=dmMain->quMain->FieldByName("type")->AsInteger;
      strcpy(pData->Name,dmMain->quMain->FieldByName("name")->AsString.c_str());
      pData->IfPoint=dmMain->quMain->FieldByName("point")->AsInteger;
      Node = tvMain->Items->AddChildObject(NodeParent, pData->Name, pData);
      switch(pData->Type){
      case 1:
         Node->ImageIndex = 2;
         Node->SelectedIndex=2;
         break;
      case 4:
         Node->ImageIndex = 4;
         Node->SelectedIndex=4;
         break;
      default:
         Node->ImageIndex = 0;
         Node->SelectedIndex=0;
         break;
         }

      if(pData->HaveChild)
        tvMain->Items->AddChildObject(Node,"",NULL);
     dmMain->quMain->Next();
        }
   }catch (Exception &exception){

  	Application->ShowException(&exception);
    return false;
  }

  return true;
}
//---------------------------------------------------------------------------
void __fastcall TFormManualInTree::FindCurrNode(void)
{
  long parmid=pointPOL->mid;
  long pointsTree[MAXPOINT];
  unsigned long CountStr;
  int state;
  TTreeNode* Node=tvMain->Items->Item[0];
  try{

    ZeroMemory(&pointsTree,sizeof(pointsTree));

      dmMain->quMain->Params->Clear();
      //14.01.2021 - GRB REWRITE Фикс бага на ОЖД с задвоением GID/MID и не раскрытием дерева
	  /*dmMain->quMain->SQL->Text="begin "+SchemeName+"MANUAL_IN_PG.Find_Node_p(:par1,:par2);end; ";
      dmMain->quMain->ParamByName("par2")->ParamType=ptOutput;
      dmMain->quMain->ParamByName("par2")->DataType=ftCursor;
      dmMain->quMain->ParamByName("par1")->AsInteger=parmid;
      dmMain->quMain->Execute();*/
	  
	  //GRB REWRITE 14.01.2021 
	  try{
	  dmMain->quMain->SQL->Text="begin "+SchemeName+"MANUAL_IN_PG.Find_Node_p(:par1,:par2,:par3);end; ";
	  dmMain->quMain->ParamByName("par3")->ParamType=ptOutput;
      dmMain->quMain->ParamByName("par3")->DataType=ftCursor;
      dmMain->quMain->ParamByName("par1")->AsInteger=parmid;
	  TTreeNode* tn = tvMain->Selected;
          if (_from_points == 1)
                dmMain->quMain->ParamByName("par2")->AsInteger=1;
          else

	  dmMain->quMain->ParamByName("par2")->AsInteger=pointPOL->ifpoint;
      dmMain->quMain->Execute();
	  
	  }
	  catch (Exception &ex){
	  dmMain->quMain->SQL->Text="begin "+SchemeName+"MANUAL_IN_PG.Find_Node_p(:par1,:par2);end; ";
      dmMain->quMain->ParamByName("par2")->ParamType=ptOutput;
      dmMain->quMain->ParamByName("par2")->DataType=ftCursor;
      dmMain->quMain->ParamByName("par1")->AsInteger=parmid;  		  
	  dmMain->quMain->Execute();

	  }

    int i=0;
    while(!dmMain->quMain->Eof&&i<MAXPOINT){
    pointsTree[i]= dmMain->quMain->FieldByName("mid")->AsInteger;
    dmMain->quMain->Next();
    i++;
    }
    CountStr=i;
    Node=tvMain->Items->GetFirstNode();
    for(long i=(long)CountStr-1;i>=0;i--){
      while(Node){
        if(pointsTree[i]==((POINTSTREEDEF*)Node->Data)->Mid)
          break;
        Node=Node->getNextSibling();
      }
      if(i&&Node){
        if(Node->getFirstChild()&&!Node->getFirstChild()->Data){
          Node->DeleteChildren();
          if(!ReadNode(Node))
            break;
        }
        Node=Node->getFirstChild();
      }else
        break;
    }
    tvMain->Selected=Node;
    if(pointPOL->mid){
      CheckBox1->Checked=(pointPOL->entype[0]==1);
      CheckBox2->Checked=(pointPOL->entype[2]==3);
      CheckBox3->Checked=(pointPOL->entype[1]==2);
      CheckBox4->Checked=(pointPOL->entype[4]==5);
      seldate->DateTime=pointPOL->myTime;
      RadioGroupProfilePower->ItemIndex=pointPOL->Step;
    }

  }catch (Exception &exception){

    Application->ShowException(&exception);
    tvMain->Selected=Node;
  }
}
//---------------------------------------------------------------------------
void __fastcall TFormManualInTree::tvMainChange(TObject *Sender, TTreeNode *Node)
{
   btOk->Enabled=Node;
   lbCaption->Caption=(Node)?Node->Text:AnsiString("");

      //TTreeNode* tn = tvMain->Selected;
      //POINTSTREEDEF*pData = (POINTSTREEDEF*)tn->Data;


}
//---------------------------------------------------------------------------
void __fastcall TFormManualInTree::tvMainExpanding(TObject *Sender,
      TTreeNode *Node, bool &AllowExpansion)
{
  if(Node&&Node->getFirstChild()&&!Node->getFirstChild()->Data){
    Node->DeleteChildren();
    ReadNode(Node);
  }
}
//---------------------------------------------------------------------------
void __fastcall TFormManualInTree::tvMainExpCol(TObject *Sender,
      TTreeNode *Node)
{
  switch(Node->ImageIndex){
    case 0:
      Node->ImageIndex=5;
      Node->SelectedIndex=5;
      break;
    case 5:
      Node->ImageIndex=0;
      Node->SelectedIndex=0;
      break;
  }
}
//---------------------------------------------------------------------------
void __fastcall TFormManualInTree::btOkClick(TObject *Sender)
{
    if(pointPOL->usetime)
      seldate->Time = TDateTime(seltime->Text.SubString(1,2).ToInt(),seltime->Text.SubString(4,2).ToInt(),0,0);
   pointPOL->mid=((POINTSTREEDEF*)tvMain->Selected->Data)->Mid;
   pointPOL->ifpoint=((POINTSTREEDEF*)tvMain->Selected->Data)->IfPoint;
   pointPOL->entype[0]=(CheckBox1->Checked)?1:0;
   pointPOL->entype[2]=(CheckBox2->Checked)?3:0;
   pointPOL->entype[3]=(CheckBox2->Checked)?4:0;
   pointPOL->entype[1]=(CheckBox3->Checked)?2:0;
   pointPOL->entype[4]=(CheckBox4->Checked)?5:0;
   pointPOL->entype[5]=(CheckBox4->Checked)?6:0;
   pointPOL->myTime=seldate->DateTime;
   pointPOL->Step=RadioGroupProfilePower->ItemIndex;
   dmMain->SetShiftTimeZona(seldate->DateTime);



   ModalResult=mrOk;
}
//---------------------------------------------------------------------------

void __fastcall TFormManualInTree::vFindClick(TObject *Sender)
{
  //GRB ADD 09.03.2021 -добавляем вызов 2-х сеттеров, определяющих контекст задачи
 fmFP->setContext(0);//и не ноль и не один а внутри файндпоинта по переданному GroupsAndPoints ставить контекст по 000 так или сяк ну или 0 
 fmFP->setGroupsAndPoints(true);
 //end add

 fmFP->ShowModal();
}

//--------------------------------------------------------------------------
 void __fastcall TFormManualInTree::WM_SetActiveNode(TMessage& Message)
{

    pointPOL->mid=Message.LParam;
    //GRB ADD 09.03.2021
    int isGroups = Message.WParam;
    if (!isGroups){
    //01.04.2021 - GRB FIX (Исправление бага с непоиском по дереву точек)
    _from_points = 1;
    //end fix
    FindCurrNode();
    }
    else{
    //01.04.2021 - GRB FIX Для цельности
    _from_points = 0;
    //end fix 
    FindCurrNodeGroup(Message.LParam);
    }
}
//-------------------------------------------------------------------------------

void __fastcall TFormManualInTree::FormDestroy(TObject *Sender)
{
   delete fmFP;
}
//---------------------------------------------------------------------------


void __fastcall TFormManualInTree::seldateChange(TObject *Sender)
{
  pointPOL->myTime=seldate->DateTime;
}
//---------------------------------------------------------------------------
//GRB ADD 09.03.2021 - добавляем размотчик для поиска в дереве групп, его тянем из EditGroupsList
void __fastcall TFormManualInTree::FindCurrNodeGroup(long id){
    // Запрос - путь к точке :1 начиная с коренного узла
    #define MAXCOUNTLEVEL  100
    long parmid=id;
    long pointsTree[MAXCOUNTLEVEL];
    TTreeNode*Node;
    try{
          ZeroMemory(&pointsTree,sizeof(pointsTree));
          dmMain->oqCursor->Params->Clear();
          dmMain->oqCursor->SQL->Text="begin "+SchemeName+"editgroups_pg.find_node(:par1,:par2); end;";
          dmMain->oqCursor->ParamByName("par2")->ParamType = ptOutput;
          dmMain->oqCursor->ParamByName("par2")->DataType = ftCursor;

        Node = tvMain->Items->GetFirstNode();

            dmMain->oqCursor->ParamByName("par1")->AsInteger= parmid;
            dmMain->oqCursor->Execute();
            unsigned long rowCount=0;
            int j=0;
            while(!dmMain->oqCursor->Eof&&j< MAXCOUNTLEVEL){
             pointsTree[j]= dmMain->oqCursor->FieldByName("gid")->AsInteger;
               dmMain->oqCursor->Next();
             j++;
             }
             rowCount=j;
             for(unsigned long i=0; i<rowCount; i++)
             {
                 while(Node){
                    if(pointsTree[i]==GetNodeId(Node))
                        break;
                    Node=Node->getNextSibling();
                }
               if((i<rowCount-1)&&(Node!=NULL))
               {
                    if((Node->HasChildren && !Node->getFirstChild()) ||
                     (Node->getFirstChild() && !Node->getFirstChild()->Data))
                    {
                        Node->DeleteChildren();
                        if(!ReadNode(Node))
                            break;
                    }
                    Node=Node->getFirstChild();
                }else
                    break;
            }
        tvMain->Selected = Node;
    }catch (Exception &exception){
        Application->ShowException(&exception);
        tvMain->Selected=Node;
       }
}

//---------------------------------------------------------------------------
//END ADD
//---------------------------------------------------------------------------



