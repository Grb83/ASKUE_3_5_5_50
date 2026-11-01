//---------------------------------------------------------------------------
#include <vcl.h>
#include <stdio.h>
#include "CountParam.h"
#include "InputParam.h"
#pragma hdrstop
#include "ChangeCounters.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "DBAccess"
#pragma link "MemDS"
#pragma link "Ora"
#pragma resource "*.dfm"
#define MAXPOINT	1000
//---------------------------------------------------------------------------

__fastcall TFormChangeCounters::TFormChangeCounters(TComponent* Owner, AnsiString Name, TAccess a)
	: TMainForm(Owner, Name, a)
{
   if(a==accRead)
      throw(Exception(Reconst_smes4_1));

   dtPicker->DateTime=TDateTime::CurrentDate();
   cb[0]=cb1;
   cb[1]=cb2;
   cb[2]=cb3;
   cb[3]=cb4;
   cb[4]=cb5;

   olditemindex=-1;

    fmFP=new TfmFindPoint(this);
    iaFind->OnExecute       = vFindClick;
}
//---------------------------------------------------------------------------

//bool __fastcall TFormChangeCounters::ReadNode(TTreeNode* NodeParent)// Читает ветку дерева Точек
 bool __fastcall TFormChangeCounters::ReadNode(TObject*obj)
{
    TTreeNode*NodeParent=dynamic_cast<TTreeNode*>(obj);
    POINTSDIV *TreeTable;
    CHANGEMETERS *ChMet;
    TTreeNode *AddNode;
    TTreeNode *AddNodeDate;


    try{
       
        oqChMeter->SQL->Text="begin "+SchemeName+"change_meter.ChMeter_p(:par1,:par2);end;";
        oqChMeter->ParamByName("par2")->DataType=ftCursor;
        oqChMeter->ParamByName("par2")->ParamType=ptOutput;

        dmMain->oqCursor->Params->Clear();
        dmMain->oqCursor->SQL->Text="begin "+SchemeName+"change_meter.read_node_p(:par1,:par2);end;";
        dmMain->oqCursor->ParamByName("par2")->DataType=ftCursor;
        dmMain->oqCursor->ParamByName("par2")->ParamType=ptOutput;
        if(NodeParent)
        dmMain->oqCursor->ParamByName("par1")->AsInteger=((POINTSDIV*)NodeParent->Data)->Mid;
        else
        dmMain->oqCursor->ParamByName("par1")->Clear();

        dmMain->oqCursor->Execute();
        while(!dmMain->oqCursor->Eof){
        TreeTable= new POINTSDIV;
        ZeroMemory(TreeTable,sizeof(POINTSDIV));
        TreeTable->editing=dmMain->oqCursor->FieldByName("HaveChild")->AsInteger;
        TreeTable->Mid=dmMain->oqCursor->FieldByName("mid")->AsInteger;
        TreeTable->Type=dmMain->oqCursor->FieldByName("type")->AsInteger;
        if(!dmMain->oqCursor->FieldByName("name")->IsNull)
         strcpy(TreeTable->Name,dmMain->oqCursor->FieldByName("name")->AsString.c_str());
        TreeTable->ER_POSITION=dmMain->oqCursor->FieldByName("ER_POSITION")->AsInteger;
        TreeTable->Q1_POSITION=dmMain->oqCursor->FieldByName("Q1_POSITION")->AsInteger;
        TreeTable->ED_POSITION=dmMain->oqCursor->FieldByName("ED_POSITION")->AsInteger;
        TreeTable->Q3_POSITION=dmMain->oqCursor->FieldByName("Q3_POSITION")->AsInteger;
        TreeTable->SMART=dmMain->oqCursor->FieldByName("SMART")->AsInteger;
        TreeTable->KC=dmMain->oqCursor->FieldByName("KC")->AsInteger;


                AddNode = tvMain->Items->AddChildObject(NodeParent,TreeTable->Name,TreeTable);
                AddNode->ImageIndex =(TreeTable->Type==3)?0:4;
                AddNode->SelectedIndex=(TreeTable->Type==3)?0:4;
                if(TreeTable->editing){
                    tvMain->Items->AddChildObject(AddNode,"",(void*)0);
                    TreeTable->editing=0;
   //----------------------------------------------VNB 13.05.08
                }else{
                oqChMeter->ParamByName("par1")->AsInteger=TreeTable->Mid;
                oqChMeter->Execute();

                AnsiString text;
                  while(!oqChMeter->Eof){
                        ChMet= new CHANGEMETERS;
                        ZeroMemory(ChMet,sizeof(CHANGEMETERS));
                        ChMet->Mid=TreeTable->Mid;
                        ChMet->date=oqChMeter->FieldByName("dend")->AsDateTime;
                        strcpy(ChMet->entype,oqChMeter->FieldByName("entype")->AsString.c_str());
                        ChMet->type=oqChMeter->FieldByName("type")->AsInteger;
                        text=(ChMet->date.FormatString("dd.mm.yyyy"))+ " " +AnsiString(ChMet->entype);
                        AddNodeDate = tvMain->Items->AddChildObject(AddNode,text,ChMet);
                        AddNodeDate->ImageIndex =-1;
                        AddNodeDate->SelectedIndex=-1;
                        oqChMeter->Next();
                   }
   //-------------------------------------------------------------------------------
              }
            dmMain->oqCursor->Next();
          }
    }catch (Exception &exception){

        Application->ShowException(&exception);
        return false;
    }
  return true;
}

//-------------------------------------------------------------------------------
void __fastcall TFormChangeCounters::FormCreate(TObject *Sender)
{
  if(ReadNode(NULL)&&tvMain->Items->Count){
    tvMain->OnChange=tvMainChange;
    tvMain->Selected=tvMain->Items->Item[0];
  }
}
//---------------------------------------------------------------------------
void __fastcall TFormChangeCounters::bbDelClick(TObject *Sender)
{
    TTreeNode *Node=tvMain->Selected;
    TTreeNode *Parent=Node->Parent;
   // int Mid=((CHANGEMETERS*)Node->Data)->Mid;
    CHANGEMETERS *p=(CHANGEMETERS*)Node->Data;
    if(Node&&Node->Data&&
    MessageBox(Handle,AnsiString(Reconst_smes4_3+Node->Text+">?").c_str(),Application->Title.c_str(),MB_YESNO|MB_ICONQUESTION|MB_DEFBUTTON2)==IDYES){

 try{
    //GRB ADD 16.04.2020 - test trouble ODAC
    dmMain->quMain->Params->Clear();
    //END ADD 
    dmMain->quMain->SQL->Text="begin \
                                 "+SchemeName+"change_meter.del_change_meter_p(:par1,:par2,:par3);  \
                               end; " ;
    dmMain->quMain->ParamByName("par1")->AsInteger=(int)p->Mid;
    dmMain->quMain->ParamByName("par2")->AsDateTime=p->date;
    dmMain->quMain->ParamByName("par3")->AsInteger=p->type;
    dmMain->quMain->Execute();
    dmMain->orases->Commit();

     Node->Delete();
     tvMain->Selected=Parent;
   //  tvMain->OnChange=tvMainChange;
  }catch (Exception &exception){
    dmMain->orases->Rollback();
  	Application->ShowException(&exception);
  //  tvMain->OnChange=tvMainChange;
    if(Node)
      tvMain->Selected=Node;
  }
 }
}
//---------------------------------------------------------------------------

void __fastcall TFormChangeCounters::tvMainExpCol(TObject *Sender,
      TTreeNode *Node)
{
  switch(Node->ImageIndex){
    case 4:
      Node->ImageIndex = 5;
      Node->SelectedIndex = 5;
      break;
    case 5:
      Node->ImageIndex = 4;
      Node->SelectedIndex = 4;
      break;
  }
}
//---------------------------------------------------------------------------
void __fastcall TFormChangeCounters::tvMainChange(TObject *Sender, TTreeNode *Node)
{
  POINTSDIV *PTreeTable=NULL;
  rg1->OnClick=NULL;
  if(!Node||!Node->Data||((POINTSDIV*)Node->Data)->Type!=3){
    for(int i=0;i<5;i++)
      cb[i]->Checked=false;
    rg1->ItemIndex=-1;
    rg1->Enabled=false;
    btInput->Enabled=false;
    iaRefresh->Enabled=false;
    dtPicker->Enabled=false;
    }else{
    PTreeTable=(POINTSDIV*)Node->Data;
    if(PTreeTable->SMART){
      for(int i=0;i<4;i++)
        cb[i]->Checked=false;
      cb[4]->Checked=true;
      rg1->ItemIndex=4;
      rg1->Enabled=false;
      iaRefresh->Enabled=true;
      dtPicker->Enabled=true;
      btInput->Enabled=true;
    }else{
      cb1->Checked=PTreeTable->ER_POSITION;
      cb2->Checked=PTreeTable->ED_POSITION;
      cb3->Checked=PTreeTable->Q1_POSITION;
      cb4->Checked=PTreeTable->Q3_POSITION;
      cb5->Checked=false;
      rg1->ItemIndex=-1;
      for(int i=0;i<4;i++){
        if(cb[i]->Checked){
          rg1->ItemIndex=i;
          break;
        }
      }
      bool moreone=false;
      if(rg1->ItemIndex>=0){
        for(int i=rg1->ItemIndex+1;i<4;i++){
          if(cb[i]->Checked){
            moreone=true;
            break;
          }
        }
      }
      btInput->Enabled=(rg1->ItemIndex>=0);
      iaRefresh->Enabled=(rg1->ItemIndex>=0);
      rg1->Enabled=moreone;
      dtPicker->Enabled=true;

    }
  }
  bbDel->Enabled=(Node->SelectedIndex==-1);
  olditemindex=rg1->ItemIndex;
  rg1->OnClick=rg1Click;
}
//---------------------------------------------------------------------------

void __fastcall TFormChangeCounters::vRefresh(TObject* Sender)
{
   TYPECOUNT Counter;
   switch(rg1->ItemIndex){
   case 0:
      Counter.Enertype=1;
      break;
   case 1:
      Counter.Enertype=2;
      break;
   case 2:
      Counter.Enertype=3;
      break;
   case 3:
      Counter.Enertype=5;
      break;
   case 4:
      Counter.Enertype=7;
      break;
   default:
      return;
   }
   POINTSDIV *PTreeTable=(POINTSDIV*)tvMain->Selected->Data;
   Counter.Mid=PTreeTable->Mid;
   Counter.Kc=PTreeTable->KC;
   strcpy(Counter.DataChange,dtPicker->Date.FormatString("dd.mm.yyyy").c_str());
   FormCountParam= new TFormCountParam(this,&Counter,dtPicker->Date);
   FormCountParam->Edit1->Text=PTreeTable->Name;
   if(FormCountParam->ShowModal()==mrOk)
      dtPicker->Date=FormCountParam->DateTimePicker1->Date;
   delete FormCountParam;
   //------------------------------------------------------------ VNB 15.05.08
   int Mid=PTreeTable->Mid;
   tvMain->OnChange=NULL;
    tvMain->Items->BeginUpdate();
    tvMain->Items->Clear();
    if(ReadNode(NULL))
    FindNode(tvMain, Mid, ReadNode, getNodeId);
    tvMain->OnChange=tvMainChange;
     if(!tvMain->Selected) tvMain->Selected=tvMain->Items->Item[0];
     tvMain->Items->EndUpdate();
     tvMain->SetFocus();
   //----------------------------------------------------------
}
//---------------------------------------------------------------------------
void __fastcall TFormChangeCounters::rg1Click(TObject *Sender)
{
  rg1->OnClick=NULL;
  if(rg1->ItemIndex>=0&&cb[rg1->ItemIndex]->Checked)
    olditemindex=rg1->ItemIndex;
  else
    rg1->ItemIndex=olditemindex;
  rg1->OnClick=rg1Click;
}
//---------------------------------------------------------------------------
void __fastcall TFormChangeCounters::tvMainDeletion(TObject *Sender,
      TTreeNode *Node)
{
  if(Node&&Node->Data)
    delete (POINTSDIV*)Node->Data;
}
//---------------------------------------------------------------------------
void __fastcall TFormChangeCounters::tvMainExpanding(TObject *Sender,
      TTreeNode *Node, bool &AllowExpansion)
{
  if(Node&&Node->getFirstChild()&&!Node->getFirstChild()->Data){
    Node->DeleteChildren();
    ReadNode(Node);
  }
}
//---------------------------------------------------------------------------

inline void __fastcall TFormChangeCounters::SetAccess(TAccess value)
{
   if(FAccess != value)
      TMainForm::SetAccess(value);
   if(FAccess==accRead)
      Close();
}
//---------------------------------------------------------------------------

void __fastcall TFormChangeCounters::vSave(TObject* Sender)
{
   //TODO: Add your source code here
}

//------------------------------------------------------------------------------
void __fastcall TFormChangeCounters::vFindClick(TObject *Sender)
{
  //GRB ADD 09.03.2021 -добавляем вызов 2-х сеттеров, определяющих контекст задачи
  fmFP->setContext(0);
  fmFP->setGroupsAndPoints(false);
  //END ADD
  fmFP->ShowModal();
}
//---------------------------------------------------------------------------
void __fastcall TFormChangeCounters::WM_SetActiveNode(TMessage& Message)
{
    FindNode(tvMain, Message.LParam, ReadNode, getNodeId);
}
//----------------------------------------------------------------------

void __fastcall TFormChangeCounters::FormDestroy(TObject *Sender)
{
  delete fmFP;
}
//---------------------------------------------------------------------------

void __fastcall TFormChangeCounters::btInputClick(TObject *Sender)
{
 TFormInputParam::ShowInputParam(this,((POINTSDIV*)tvMain->Selected->Data)->Mid,dtPicker->Date);  
}
//---------------------------------------------------------------------------









