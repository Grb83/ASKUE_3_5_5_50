//---------------------------------------------------------------------------
#include <vcl.h>
#include <stdio.h>
#include <math.h>
#pragma hdrstop
#include "selectpoint.h"
#include "unDataMod.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "DBAccess"
#pragma link "MemDS"
#pragma link "Ora"
#pragma resource "*.dfm"
#define MAXPOINT	1000
TfmSelectPoint *fmSelectPoint;
//---------------------------------------------------------------------------
strGROUPDATAFORM::strGROUPDATAFORM(AnsiString SetMeas)
{
  type=6;
  myTime=TDateTime::CurrentDateTime();
  strcpy(Meas,SetMeas.c_str());
  try{
    gid = TdmMain::GetStr(SetMeas,1,".").ToInt();
    IsPoint = (TdmMain::GetStr(SetMeas,0,".")=="GID")?0:1;
  }catch(Exception &e){
    gid = 0;
    IsPoint = 0;
  }
}
//---------------------------------------------------------------------------
__fastcall TfmSelectPoint::TfmSelectPoint(TComponent* Owner,GROUPDATAFORM* sfd)
	: TForm(Owner)
{
   if(!sfd) throw Exception(Reconst_smes92_1);
   pointPOL=sfd;
   seldate->Date=pointPOL->myTime;
    fmFP=new TfmFindPoint(this);
  iaFind->OnExecute       = vFindClick;
}
//---------------------------------------------------------------------------
void __fastcall TfmSelectPoint::FormCreate(TObject *Sender)
{
if(pointPOL->HelpContext)
  HelpContext=pointPOL->HelpContext;
//GRB ADD 20.04.2021
if(pointPOL->type==7){
        sbFind->Enabled=false;
}

//END ADD
if(pointPOL->type==6)
{
 PanelMeas->Visible=true;
// ReadNodeMeas(TreeViewMeas,100);
}
if(pointPOL->type== 4){
      Panel7->Caption=Reconst_smes92_2;
   //   sbFind->Visible=false;
      }
   if(ReadNode(tvMain, NULL, pointPOL->type)){
      if(tvMain->Items->Count){
         if(pointPOL->gid){
            FindCurrNode(tvMain, pointPOL->gid, pointPOL->type,pointPOL->IsPoint);
            if(pointPOL->gid){
               CheckBox1->Checked=(pointPOL->entype[0]==1);
               CheckBox2->Checked=(pointPOL->entype[2]==3);
               CheckBox3->Checked=(pointPOL->entype[1]==2);
               CheckBox4->Checked=(pointPOL->entype[4]==5);
            }
         }else
            tvMain->Selected=tvMain->Items->Item[0];
      }else{
         paEdit->Enabled=false;
         btOk->Enabled=false;
      }
   }else{
      paEdit->Enabled=false;
      btOk->Enabled=false;
   }
   if(pointPOL->type){
      paEdit->Enabled = false;
      paEdit->Visible = false;
   }
}
//---------------------------------------------------------------------------
// Читает ветку дерева Точек
bool __fastcall TfmSelectPoint::ReadNode(TObject* Sender, TObject* ParentNode, long type)
{
   TTreeView*tv = (TTreeView*)Sender;
   TTreeNode*parNode = (TTreeNode*)ParentNode;
   AnsiString sqlRoot,sqlChld;
   POINTSTREEDEF*pData;
   TTreeNode* Node;
   try{
        dmMain->oqCursor->Params->Clear();
        dmMain->oqCursor->SQL->Text="begin "+SchemeName+"SAA_SELECT_PG.selectpoint_read_node(:par1,:FLAG,:par3); end;";
        dmMain->oqCursor->ParamByName("par3")->ParamType = ptOutput;
        dmMain->oqCursor->ParamByName("par3")->DataType = ftCursor;
        switch (type){
        case 4://Все группы учета
          dmMain->oqCursor->ParamByName("FLAG")->AsInteger = 1;
           break;
        case 2://Каналы с типом протокола: файл
          dmMain->oqCursor->ParamByName("FLAG")->AsInteger = 2;
          break;
        case 3://Все точки учета
          dmMain->oqCursor->ParamByName("FLAG")->AsInteger = 3;
          break;
        case 0://Группы начиная с группы разбивки
          dmMain->oqCursor->ParamByName("FLAG")->AsInteger = 4;
          break;
        case 7://Фильтры
          dmMain->oqCursor->ParamByName("FLAG")->AsInteger = 6;
          break;
        case 6://Точки+Группы+Трансформаторы
          dmMain->oqCursor->ParamByName("FLAG")->AsInteger = 8;
          break;
        case 9: //Точки учета без трансформаторов
          dmMain->oqCursor->ParamByName("FLAG")->AsInteger = 9;
          break;
        case 10: //Все каналы, доступные по правам для юзера
          dmMain->oqCursor->ParamByName("FLAG")->AsInteger = 10;
          break;
        default://Точки учета
          dmMain->oqCursor->ParamByName("FLAG")->AsInteger = 5;
           }
     if(type==6)
     {
          oqMeas->SQL->Text="begin "+SchemeName+"SAA_SELECT_PG.read_meas_node(:par1,:par2); end;";
          oqMeas->ParamByName("par1")->ParamType = ptOutput;
          oqMeas->ParamByName("par1")->DataType = ftCursor;
     }


      if(!parNode){
         if(type==3){//Добавить псевдовершину
           pData = new POINTSTREEDEF;
           ZeroMemory(pData,sizeof(POINTSTREEDEF));
           pData->HaveChild=1;
           strcpy(pData->Name,Reconst_smes92_3.c_str());
           parNode = tv->Items->AddChildObject(parNode, pData->Name, pData);
           parNode->ImageIndex =4;
           parNode->SelectedIndex =4;
         }
         dmMain->oqCursor->ParamByName("par1")->AsInteger=0;
      }else{
         dmMain->oqCursor->ParamByName("par1")->AsInteger=((POINTSTREEDEF*)parNode->Data)->Gid;
         }
         dmMain->oqCursor->Execute();
         while(!dmMain->oqCursor->Eof){
         pData = new POINTSTREEDEF;
         ZeroMemory(pData,sizeof(POINTSTREEDEF));
         pData->HaveChild = dmMain->oqCursor->FieldByName("HaveChild")->AsInteger;
         if(type==6)
         {
          pData->IsPoint=dmMain->oqCursor->FieldByName("IsPoint")->AsInteger;
          oqMeas->ParamByName("par2")->AsInteger=dmMain->oqCursor->FieldByName("nsort")->AsInteger;
          oqMeas->Execute();
          pData->pmeas = new TList;
          pData->pmeas->Capacity = pData->pmeas->Count;
          while(!oqMeas->Eof)
          {
           MEASURES *tMeas = new MEASURES;
           tMeas->Mid= oqMeas->FieldByName("nmeasure")->AsInteger;
           strcpy(tMeas->Name,oqMeas->FieldByName("vname")->AsString.c_str());
           strcpy(tMeas->Code,oqMeas->FieldByName("vcode")->AsString.c_str());
           pData->pmeas->Capacity = pData->pmeas->Count;
           pData->pmeas->Add(tMeas);
           oqMeas->Next();
          }
         }
         pData->Gid = dmMain->oqCursor->FieldByName("mid")->AsInteger;
         pData->Type = dmMain->oqCursor->FieldByName("type")->AsInteger;
         strcpy(pData->Name,dmMain->oqCursor->FieldByName("name")->AsString.c_str());
         strcpy(pData->PointInfo,dmMain->oqCursor->FieldByName("pinfo")->AsString.c_str());

         Node = tv->Items->AddChildObject(parNode, pData->Name, pData);
         if(type&&pData->Type==10) pData->Type=1;
         switch(pData->Type)
         {
         case 4: Node->ImageIndex =2;
                 Node->SelectedIndex =2;
                 break;
         case 1: Node->ImageIndex =0;
                 Node->SelectedIndex =0;
                 break;
         case 5: Node->ImageIndex =6;
                 Node->SelectedIndex =6;
                 break;
         case 6:  Node->ImageIndex =7;
                 Node->SelectedIndex =7;
                 break;
         case 7:  Node->ImageIndex =9;
                 Node->SelectedIndex =9;
                 break;
         case 8:  Node->ImageIndex =8;
                 Node->SelectedIndex =8;
                 break;
         case 9:  Node->ImageIndex =10;
                 Node->SelectedIndex =10;
                 break;
         default :  Node->ImageIndex =4;
                    Node->SelectedIndex =4;

         }
         if(pData->HaveChild)
            tv->Items->AddChildObject(Node,"",NULL);
         dmMain->oqCursor->Next();
         }

        

   }catch (Exception &exception){

  	   Application->ShowException(&exception);
      return false;
   }

   return true;
}
//---------------------------------------------------------------------------
//bool __fastcall TfmSelectPoint::ReadNodeMeas(TObject* Sender,int type)  TTreeNode *Node
bool __fastcall TfmSelectPoint::ReadNodeMeas(TObject* Sender,TTreeNode *sNode)
{
 TList *li=((POINTSTREEDEF*)sNode->Data)->pmeas;
  TTreeView *tv = (TTreeView*)Sender;
   TTreeNode* Node;
   AnsiString s= TdmMain::GetStr(pointPOL->Meas,2,".");

   ///////////////// если выбраны суточные/месячные показания
   AnsiString Temp=pointPOL->Meas;
   while (Temp.Pos(".")!=0)
  {
    Temp = Temp.SubString(Temp.Pos(".")+1,Temp.Length()-Temp.Pos("."));
  }

   if ((Temp=="M")||(Temp=="D")) s=s+"."+Temp;
   ////////////////////
  
   tv->Items->BeginUpdate();
   tv->Items->Clear();


   try{
     for(int i=0; i<li->Count; i++)
     {
      
      Node = tv->Items->AddObject(NULL, ((MEASURES*)li->Items[i])->Name,(void*) (MEASURES*)li->Items[i]);
      if(s.Length()&&s==AnsiString(((MEASURES*)li->Items[i])->Code))
        tv->Selected=Node;
      Node->ImageIndex=0;
      Node->SelectedIndex=0;
     }
    
   /* dmMain->oqCursor->Params->Clear();
    dmMain->oqCursor->SQL->Text="begin "+SchemeName+"SAA_SELECT_PG.read_meas_node(:par1,:par2); end;";
    dmMain->oqCursor->ParamByName("par1")->ParamType = ptOutput;
    dmMain->oqCursor->ParamByName("par1")->DataType = ftCursor;
    dmMain->oqCursor->ParamByName("par2")->AsInteger=type;
    dmMain->oqCursor->Execute();

    while(!dmMain->oqCursor->Eof){
      MEASURES *tMeas = new MEASURES;
      tMeas->Mid= dmMain->oqCursor->FieldByName("nmeasure")->AsInteger;
      strcpy(tMeas->Name,dmMain->oqCursor->FieldByName("vname")->AsString.c_str());
      strcpy(tMeas->Code,dmMain->oqCursor->FieldByName("vcode")->AsString.c_str());
      Node = tv->Items->AddObject(NULL, tMeas->Name,(void*) tMeas);
      if(s.Length()&&s==AnsiString(tMeas->Code))
        tv->Selected=Node;
      Node->ImageIndex=0;
      Node->SelectedIndex=0;
      dmMain->oqCursor->Next();
    } */
    if(!tv->Selected&&tv->Items->Count)
      tv->Selected=tv->Items->Item[0];
   }catch (Exception &exception){
      Application->ShowException(&exception);
      tv->Items->EndUpdate();
      return false;
   }
   tv->Items->EndUpdate();
   return true;
}

//-----------------------------------------------------------------------------------------------
void __fastcall TfmSelectPoint::FindCurrNode(TObject*Sender, long mid, long type,int IsPoint)
{
   TTreeView*tv = (TTreeView*)Sender;
   long parmid=mid;
   long pointsTree[MAXPOINT];
   unsigned long CountStr;
   int state;
   TTreeNode* Node=tv->Items->Item[0];
   try{
      ZeroMemory(&pointsTree,sizeof(pointsTree));
      dmMain->oqCursor->SQL->Text="begin "+SchemeName+"SAA_SELECT_PG.find_curr_node(:par1,:FLAG,:par3); end;";
      dmMain->oqCursor->ParamByName("par3")->ParamType = ptOutput;
      dmMain->oqCursor->ParamByName("par3")->DataType = ftCursor;

      if (type==0||type==4||(type==6&&IsPoint==0))
        dmMain->oqCursor->ParamByName("FLAG")->AsInteger=1;
      else if (type==10) // для каналов
        dmMain->oqCursor->ParamByName("FLAG")->AsInteger=4;
      else
        dmMain->oqCursor->ParamByName("FLAG")->AsInteger=2;


      dmMain->oqCursor->ParamByName("par1")->AsInteger=parmid;
      //GRB ADD 15.04.2021 - Для дерева формул
      if ((type == 6)&&(IsPoint==1)){
        dmMain->oqCursor->ParamByName("FLAG")->AsInteger=1;
      }
      if ((type == 6)&&(IsPoint==0)){
        dmMain->oqCursor->ParamByName("FLAG")->AsInteger=2;
      }
      //END ADD

      dmMain->oqCursor->Execute();
      int i=0;
      while(!dmMain->oqCursor->Eof&&i<MAXPOINT){
      pointsTree[i]= dmMain->oqCursor->FieldByName("mid")->AsInteger;
      dmMain->oqCursor->Next();
      i++;
      }
      CountStr= i;
      
      Node=tv->Items->GetFirstNode();
      if(type==3)//проскакиваем для псевдоточки
        Node=Node->getFirstChild();
      for(long i=(long)CountStr-1;i>=0;i--)
      { while(Node)
        { if(pointsTree[i]==((POINTSTREEDEF*)Node->Data)->Gid)
          { break;
          }
          Node=Node->getNextSibling();
        }
        if(i&&Node)
        { if(Node->getFirstChild()&&!Node->getFirstChild()->Data)
          { Node->DeleteChildren();
            if(!ReadNode(tv, Node, type))
              break;
          }
          Node=Node->getFirstChild();
        }
        else
          break;
      }
      tv->Selected=Node;

   }catch (Exception &exception){
      
      Application->ShowException(&exception);
      tv->Selected=Node;
   }
}
//---------------------------------------------------------------------------
void __fastcall TfmSelectPoint::tvMainChange(TObject *Sender, TTreeNode *Node)
{
  int type;
  btOk->Enabled=Node;
  lbCaption->Caption=(Node)?Node->Text:AnsiString("");
  mInfoArea->Lines->Text=(Node&&Node->Data)?AnsiString(((POINTSTREEDEF*)Node->Data)->PointInfo):AnsiString("");
  lbId->Text = (Node&&Node->Data)?AnsiString(((POINTSTREEDEF*)Node->Data)->Gid):AnsiString("");
  if(pointPOL->type==6){
  // type=(Node&&Node->Data)?((POINTSTREEDEF*)tvMain->Selected->Data)->Sort:-1;
  // ReadNodeMeas(TreeViewMeas,type);
    if(Node&&Node->Data)
      ReadNodeMeas(TreeViewMeas,Node);
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmSelectPoint::tvMainExpanding(TObject *Sender,
      TTreeNode *Node, bool &AllowExpansion)
{
  if(Node&&Node->getFirstChild()&&!Node->getFirstChild()->Data){
    Node->DeleteChildren();
    ReadNode(tvMain, Node, pointPOL->type);
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmSelectPoint::tvMainExpCol(TObject *Sender,
      TTreeNode *Node)
{
  switch(Node->ImageIndex){
    case 4:
      Node->ImageIndex=5;
      Node->SelectedIndex=5;
      break;
    case 5:
      Node->ImageIndex=4;
      Node->SelectedIndex=4;
      break;
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmSelectPoint::btOkClick(TObject *Sender)
{
   pointPOL->gid=((POINTSTREEDEF*)tvMain->Selected->Data)->Gid;
   strcpy(pointPOL->Name,((POINTSTREEDEF*)tvMain->Selected->Data)->Name);
   pointPOL->IsPoint=((POINTSTREEDEF*)tvMain->Selected->Data)->IsPoint;
   pointPOL->entype[0]=(CheckBox1->Checked)?1:0;
   pointPOL->entype[2]=(CheckBox2->Checked)?3:0;
   pointPOL->entype[3]=(CheckBox2->Checked)?4:0;
   pointPOL->entype[1]=(CheckBox3->Checked)?2:0;
   pointPOL->entype[4]=(CheckBox4->Checked)?5:0;
   pointPOL->entype[5]=(CheckBox4->Checked)?6:0;
   pointPOL->myTime=seldate->Date;
 if(pointPOL->type==6){
   if(!TreeViewMeas->Selected){
      if(Application->MessageBox(Reconst_smes92_4.c_str(),Caption.c_str(),MB_OK | MB_ICONWARNING)==MB_OK);
       return;
   }else{
      if(TreeViewMeas->Selected->Data){
        MEASURES *m=(MEASURES*)TreeViewMeas->Selected->Data;
        AnsiString s=IntToStr(pointPOL->gid)+"."+AnsiString(m->Code);
        if(pointPOL->IsPoint)
          s="MID."+s;
        else
          s="GID."+s;
        strcpy(pointPOL->Meas,s.c_str());
      }
   }
 }
 ModalResult=mrOk;
}
//---------------------------------------------------------------------------
void __fastcall TfmSelectPoint::vFindClick(TObject *Sender)
{
  // edited by KAG 04.03.2010
  //15.04.2021 GRB ADD добавил для редактора формул (контекст групп и точек проверку на тип 6 - вызовы идут из UnEditFormula.cpp )
  if (pointPOL->type == 10){ // дерево каналов
    /*fmFP->setContext(22);
    fmFP->setGroupsAndPoints(false);
    fmFP->SetChannel(1);
    fmFP->setOldFind (0);*/
    fmFP->setContext(0);
    fmFP->setGroupsAndPoints(false);
    fmFP->SetChannel(1);
    fmFP->setOldFind (1);
    }
  else{
    //GRB ADD 09.03.2021 -добавляем вызов 2-х сеттеров, определяющих контекст задачи
    //GRB ADD 15.04.2021 - добавляем контекст для дерева групп и точек (приходит из UnEditFormula.cpp)
    //GRB ADD 15.04.2021 - и сюда же добавляем контекст для групп по молотку в задаче 2.1
    //GRB ADD 15.04.2021 - и сюда же для 4-х фильтров по верхним кнопкам старый поиск
    if ((pointPOL->type == 3)||(pointPOL->type == 7)){
    fmFP->setOldFind (1);
    fmFP->setContext(0);
    fmFP->setGroupsAndPoints(false);
    fmFP->ShowModal();
    return;
    }
    if (pointPOL->type == 6){
    fmFP->setContext(0);
    fmFP->setGroupsAndPoints(true);
    fmFP->SetChannel(0);
    fmFP->setOldFind (0);
    }else{
    if (pointPOL->type == 4){
    fmFP->setContext(1);
    fmFP->setGroupsAndPoints(false);
    fmFP->SetChannel(0);
    fmFP->setOldFind (0);
    }else{
    fmFP->setContext(0);
    fmFP->setGroupsAndPoints(false);
    fmFP->SetChannel(0);
    fmFP->setOldFind (0);
    }
    }
    }
  fmFP->ShowModal();
}
//---------------------------------------------------------------------------
  void __fastcall TfmSelectPoint::WM_SetActiveNode(TMessage& Message)
{
   //GRB ADD 15.04.2021
   if (pointPOL->type == 6){
        FindCurrNode(tvMain, Message.LParam, pointPOL->type, Message.WParam);
        return;
   }
   //end ADD
   FindCurrNode(tvMain, Message.LParam, pointPOL->type, pointPOL->IsPoint);
}
//------------------------------------------------------------------------------
void __fastcall TfmSelectPoint::FormDestroy(TObject *Sender)
{
 delete fmFP;
}
//------------------------------------------------------------------------------
void __fastcall TfmSelectPoint::TreeViewMeasDeletion(TObject *Sender,
      TTreeNode *Node)
{
 // if(Node&&Node->Data)
 //   delete (MEASURES*)Node->Data;
}
//---------------------------------------------------------------------------

