//---------------------------------------------------------------------------
#include <vcl.h>
#include <stdio.h>
#include <math.h>
#pragma hdrstop

#include "unDataMod.h"
#include "Vit_Meter.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
#define MAXPOINT	1000
TFormVVMeter *FormVVMeter;
//---------------------------------------------------------------------------
__fastcall TFormVVMeter::TFormVVMeter(TComponent* Owner,POINTDATAFORM* sfd)
	: TForm(Owner)
{
  pointPOL=sfd;
  paTime->Enabled=pointPOL->usetime;
  paTime->Visible=pointPOL->usetime;
  seldate->Date=pointPOL->myTime;

  seltime->Text=pointPOL->myTime.FormatString("hh:nn");
  selstep->Text=pointPOL->myStep.FormatString("hh:nn");   // Add by KSS

  fmFP=new TfmFindPoint(this);
  iaFind->OnExecute       = vFindClick;
}
//---------------------------------------------------------------------------
void __fastcall TFormVVMeter::FormCreate(TObject *Sender)
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
bool __fastcall TFormVVMeter::ReadNode(TTreeNode* NodeParent)// Читает ветку дерева Точек
{
    POINTSTREEDEF*pData;
   TTreeNode* Node;
  try{
    //GRB ADD 16.04.2020 - test trouble ODAC
    dmMain->quMain->Params->Clear();
    //END ADD 
    if(!NodeParent)
      //------------------------------------------------------------------------- VNB 05.03.2008
     dmMain->quMain->SQL->Text=" select 1 HaveChild, mid, decode(ind,3,1,0) type, name ,1 point  \
                  FROM ryda.points p  \
                  WHERE cod=0 and mid=(select max(mid) from ryda.enterprise)  \
                        and exists (select * from ryda.points where parent=p.mid and cod=0)  \
                  union all  \
                  select 0 HaveChild, mid, decode(ind,3,1,0) type, name ,1 point  \
                  FROM ryda.points p  \
                  WHERE cod=0 and mid=(select max(mid) from ryda.enterprise)  \
                        and not exists (select * from ryda.points where parent=p.mid and cod=0)  \
                 union all  \
   select 1 HaveChild, gid mid, decode(mid,null,4,1) type, nvl(name,' ') name ,0 point  \
                  FROM ryda.groups p  \
                  where Parent is NULL \
                  and exists (select * from ryda.groups where parent=p.gid) \
                  union all  \
                  select 0 HaveChild, gid, decode(mid,null,4,1) type, nvl(name,' ') name ,0 point  \
                  FROM ryda.groups p \
                  where Parent is NULL  \
                  and not exists (select * from ryda.groups where parent=p.gid) \
                  order by 3,4  ";
    else{
    if(((POINTSTREEDEF*)NodeParent->Data)->IfPoint)
      dmMain->quMain->SQL->Text= "select 1 HaveChild, mid, decode(ind,3,1,0) type, name,1 point \
                  FROM ryda.points p \
                  WHERE cod=0 and parent=:par1 \
                        and exists (select * from ryda.points where parent=p.mid and cod=0) \
                  union all \
                  select 0 HaveChild, mid, decode(ind,3,1,0) type, name,1 point \
                  FROM ryda.points p \
                  WHERE cod=0 and parent=:par1 \
                        and not exists (select * from ryda.points where parent=p.mid and cod=0) \
                  order by 3,4";

    else
      dmMain->quMain->SQL->Text="select 1 HaveChild, gid mid, decode(mid,null,4,1) type, nvl(name,' ') name ,0 point \
                  FROM ryda.groups p \
                  WHERE parent=:par1 \
                     and exists (select * from ryda.groups where parent=p.gid) \
                  union all \
                  select 0 HaveChild, gid, decode(mid,null,4,1) type, nvl(name,' ') name ,0 point \
                  FROM ryda.groups p \
                  WHERE parent=:par1 \
                     and not exists (select * from ryda.groups where parent=p.gid) \
                  order by 3,4 ";
      //------------------------------------------------------------------------

       dmMain->quMain->ParamByName("par1")->AsInteger=((POINTSTREEDEF*)NodeParent->Data)->Mid;
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
    /*  Node->ImageIndex =(pData->Type)?2:0;
      Node->SelectedIndex =(pData->Type)?2:0;  */
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
void __fastcall TFormVVMeter::FindCurrNode(void)
{
  long parmid=pointPOL->mid;
  long pointsTree[MAXPOINT];
  unsigned long CountStr;
  int state;
  TTreeNode* Node=tvMain->Items->Item[0];
  try{

    ZeroMemory(&pointsTree,sizeof(pointsTree));

 /*   dmMain->quMain->SQL->Text="select mid from ryda.points connect by prior parent=mid and cod=0 start with mid=:par1 and cod=0";
    //GRB ADD 16.04.2020 - test trouble ODAC
    dmMain->quMain->Params->Clear();
    //END ADD 
    dmMain->quMain->ParamByName("par1")->AsInteger=parmid;
    dmMain->quMain->Execute();
    if(dmMain->quMain->Eof){
       //GRB ADD 16.04.2020 - test trouble ODAC
       dmMain->quMain->Params->Clear();
       //END ADD 
       dmMain->quMain->SQL->Text= "select gid mid from ryda.groups connect by prior parent=gid start with gid=:par1";
       dmMain->quMain->ParamByName("par1")->AsInteger=parmid;
       dmMain->quMain->Execute();}  */
       //---------------------------------------------VNB 05.03.2008
       //GRB ADD 16.04.2020 - test trouble ODAC
       dmMain->quMain->Params->Clear();
       //END ADD 
       //14.01.2021 - 14.01.2021 - GRB REWRITE Фикс бага на ОЖД с задвоением GID/MID и не раскрытием дерева
	   /*dmMain->quMain->SQL->Text= "select mid from ryda.points connect by prior parent=mid and cod=0 start with mid=:par1 and cod=0  \
       union all  \
       select gid mid from ryda.groups connect by prior parent=gid start with gid=:par1 ";
       dmMain->quMain->ParamByName("par1")->AsInteger=parmid;
       dmMain->quMain->Execute();
	   */
	   //GRB REWRITE 14.01.2021 
	  try{
	  dmMain->quMain->SQL->Text="begin "+SchemeName+"MANUAL_IN_PG.Find_Node_p(:par1,:par2,:par3);end; ";
	  dmMain->quMain->ParamByName("par3")->ParamType=ptOutput;
      dmMain->quMain->ParamByName("par3")->DataType=ftCursor;
      dmMain->quMain->ParamByName("par1")->AsInteger=parmid;
	  TTreeNode* tn = tvMain->Selected;
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
       //-------------------------------------
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
    }

  }catch (Exception &exception){

    Application->ShowException(&exception);
    tvMain->Selected=Node;
  }
}
//---------------------------------------------------------------------------
void __fastcall TFormVVMeter::tvMainChange(TObject *Sender, TTreeNode *Node)
{
   btOk->Enabled=Node;
   lbCaption->Caption=(Node)?Node->Text:AnsiString("");
   if(pointPOL->usestep){
      TTreeNode* tn = tvMain->Selected;
      POINTSTREEDEF*pData = (POINTSTREEDEF*)tn->Data;
      if(pData&&pData->Type==1){
         paTime->Enabled=false;
         paTime->Visible=false;
      }else{
         paTime->Enabled=true;
         paTime->Visible=true;
      }
   }
}
//---------------------------------------------------------------------------
void __fastcall TFormVVMeter::tvMainExpanding(TObject *Sender,
      TTreeNode *Node, bool &AllowExpansion)
{
  if(Node&&Node->getFirstChild()&&!Node->getFirstChild()->Data){
    Node->DeleteChildren();
    ReadNode(Node);
  }
}
//---------------------------------------------------------------------------
void __fastcall TFormVVMeter::tvMainExpCol(TObject *Sender,
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
void __fastcall TFormVVMeter::btOkClick(TObject *Sender)
{
   if(pointPOL->usetime)
      seldate->Time = TDateTime(seltime->Text.SubString(1,2).ToInt(),seltime->Text.SubString(4,2).ToInt(),0,0);
   pointPOL->usestep = (pointPOL->usestep&&(((POINTSTREEDEF*)tvMain->Selected->Data)->Type==1));
   pointPOL->mid=((POINTSTREEDEF*)tvMain->Selected->Data)->Mid;
   pointPOL->ifpoint=((POINTSTREEDEF*)tvMain->Selected->Data)->IfPoint;
   pointPOL->entype[0]=(CheckBox1->Checked)?1:0;
   pointPOL->entype[2]=(CheckBox2->Checked)?3:0;
   pointPOL->entype[3]=(CheckBox2->Checked)?4:0;
   pointPOL->entype[1]=(CheckBox3->Checked)?2:0;
   pointPOL->entype[4]=(CheckBox4->Checked)?5:0;
   pointPOL->entype[5]=(CheckBox4->Checked)?6:0;
   pointPOL->myTime=seldate->DateTime;
   pointPOL->myStep=TDateTime(selstep->Text.SubString(1,2).ToInt(),selstep->Text.SubString(4,2).ToInt(),0,0); // Add by KSS
   // выравнивание времени по границе шага // Add by KSS
   if(pointPOL->usestep&&pointPOL->myStep.Val>0){
      double t = pointPOL->myTime.Val-(int)pointPOL->myTime.Val;
      double k = floor(t/pointPOL->myStep.Val*1000000000.0)/1000000000.0;
      double d = ceil(k)*pointPOL->myStep.Val - t;
      if(d > 0) pointPOL->myTime.Val += d;
   }
   // end add by KSS
   ModalResult=mrOk;
}
//---------------------------------------------------------------------------

void __fastcall TFormVVMeter::vFindClick(TObject *Sender)
{
 //GRB ADD 10.03.2021 -добавляем вызов 2-х сеттеров, определяющих контекст задачи
 fmFP->setContext(0);//без разницы 0 или 1 на самом деле так как контекст где искать в группах или точках определяет юзер с полями 000 в ид группе или ид.точки
 fmFP->setGroupsAndPoints(true);
 //end add
 fmFP->ShowModal();
}

//--------------------------------------------------------------------------
 void __fastcall TFormVVMeter::WM_SetActiveNode(TMessage& Message)
{
    //GRB ADD 19.03.2021
    pointPOL->mid=Message.LParam;
    int isGroups = Message.WParam;
    if (!isGroups){

    FindCurrNode();
    }
    else{
    FindCurrNodeGroup(Message.LParam);
    }
    //END ADD

    /*pointPOL->mid=Message.LParam;
    FindCurrNode();*/

}
//-------------------------------------------------------------------------------

void __fastcall TFormVVMeter::FormDestroy(TObject *Sender)
{
   delete fmFP;
}
//---------------------------------------------------------------------------
//GRB ADD 19.03.2021 - добавляем размотчик для поиска в дереве групп, его тянем из EditGroupsList
void __fastcall TFormVVMeter::FindCurrNodeGroup(long id){
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



