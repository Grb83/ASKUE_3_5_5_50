//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
#include "unPrior.h"
#include "unDataMod.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "DBAccess"
#pragma link "MemDS"
#pragma link "Ora"
#pragma resource "*.dfm"
TfmPrior *fmPrior;
//---------------------------------------------------------------------------
__fastcall TfmPrior::TfmPrior(TComponent* Owner,long Mid,bool fullacc)
  : TForm(Owner)
{
 this->fullacc=fullacc;
 ReplaceRyda(this,BASE_SCHEME,SchemeName);
 Parent=Mid;
 tvHistory->ReadOnly  = !fullacc;
 ToolBar1->Enabled=fullacc;
 dtStart->Enabled=fullacc;
 dtEnd->Enabled=fullacc;
 dtStart->Date=Date();
 dtEnd->Date=Date()+1;
}
//---------------------------------------------------------------------------
void __fastcall TfmPrior::FormCreate(TObject *Sender)
{
  ReadNode(Parent);
}
//---------------------------------------------------------------------------
void __fastcall TfmPrior::tvHistoryChange(TObject *Sender, TTreeNode *Node)
{
 if(!fullacc ) return;
  if(!Node||!Node->Data){

     tbDel->Enabled=false;
     tbUp->Enabled=false;
     tbDown->Enabled=false;
     tbFUp->Enabled=false;
     tbEDown->Enabled=false;
     dtStart->Enabled=false;
     dtEnd->Enabled=false;
    }else {
   SPrior *Data=(SPrior*)Node->Data;

   switch (Data->ntype)
    {
    case 0:
            tbDel->Enabled=true;
            tbUp->Enabled=false;
            tbDown->Enabled=false;
            dtStart->Enabled=true;
            dtStart->Date=Data->dstart;
            dtEnd->Enabled=true;
            dtEnd->Date=Data->dend;
            tbFUp->Enabled=false;
            tbEDown->Enabled=false;
            break;
    case 1:
            tbDel->Enabled=false;
            tbUp->Enabled=false;
            tbDown->Enabled=false;
            tbFUp->Enabled=false;
            tbEDown->Enabled=false;
            dtStart->Enabled=false;
            dtEnd->Enabled=false;
            break;
    case 2:

            tbDel->Enabled=false;
            tbUp->Enabled=true;
            tbDown->Enabled=true;
            tbFUp->Enabled=true;
            tbEDown->Enabled=true;
            dtStart->Enabled=false;
            dtEnd->Enabled=false;
            break;
     }

   }

}
//---------------------------------------------------------------------------
void __fastcall TfmPrior::acAddExecute(TObject *Sender)
{
   TTreeNode* Node;
   TTreeNode* ParNode;

   ParNode=tvHistory->Items->GetFirstNode();
   SPrior *pData=new SPrior;
   pData->mid=0;
   pData->ntype=0;
   pData->norder=0;
   pData->vname=(Date()).FormatString("dd.mm.yyyy")+" ... "+(Date()+1).FormatString("dd.mm.yyyy");
   pData->dstart=Date();
   pData->dend=Date()+1;
   pData->olddstart=Date();
   pData->olddend=Date()+1;
   pData->editing=3;

    Node = tvHistory->Items->AddChildObject(ParNode, pData->vname, pData);
    Node->ImageIndex =0;
    Node->SelectedIndex =0;

    if(!ReadNodeAdd(Node)) tvHistory->Items->Delete(Node);



    tbSave->Enabled=true;
    tbRefresh->Enabled=true;

}
//---------------------------------------------------------------------------

void __fastcall TfmPrior::acDelExecute(TObject *Sender)
{
  TTreeNode *DNode=tvHistory->Selected;
  TTreeNode *Node;
  try {
 if(MessageBox(Handle,AnsiString(Reconst_smes76_1+((SPrior*)tvHistory->Selected->Data)->vname+"?").c_str(),Application->Title.c_str(),MB_YESNO|MB_ICONQUESTION|MB_DEFBUTTON2)!=IDYES)
    return;

  oqTest->Params->Clear();
  oqTest->SQL->Text="begin "+SchemeName+"PRIORITY_PG.del_p(:mid, :start ,:end ) ;end;";
  Node=DNode->getFirstChild();
  while(Node&&Node->Data&&((SPrior*)Node->Data)->ntype==2)
  {
   oqTest->ParamByName("mid")->AsInteger=((SPrior*)Node->Data)->mid;
   oqTest->ParamByName("start")->AsDateTime=((SPrior*)Node->Data)->olddstart;
   oqTest->ParamByName("end")->AsDateTime=((SPrior*)Node->Data)->olddend;
   oqTest->Execute();
   dmMain->orases->Commit();
   Node=DNode->GetNextChild(Node);
  }

  tvHistory->Items->Delete(tvHistory->Selected);
 }catch (Exception &exception){
    dmMain->orases->Rollback();
  	Application->ShowException(&exception);
  }

 // tbSave->Enabled=true;
  tbRefresh->Enabled=true;
}

//---------------------------------------------------------------------------
void __fastcall TfmPrior::tvHistoryExpanded(TObject *Sender,
      TTreeNode *Node)
{
  SPrior *Data=(SPrior*)Node->Data;
  if (Data->ntype==0)
  {
      Node->ImageIndex=1;
      Node->SelectedIndex=1;
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmPrior::tvHistoryCollapsed(TObject *Sender,
      TTreeNode *Node)
{
   SPrior *Data=(SPrior*)Node->Data;
    if (Data->ntype==0)
    {
     Node->ImageIndex=0;
     Node->SelectedIndex=0;
    }
}
//---------------------------------------------------------------------------
// Читает ветку дерева Точек
void __fastcall TfmPrior::ReadNode(long Parent)
{
  TTreeNode* Node;
  TTreeNode* ParNode;
  TTreeNode* ChNode;
  oqPrior->Params->Clear();
  oqPrior->SQL->Text="begin "+SchemeName+"PRIORITY_PG.getnode(:par1,:par2);end;";
  oqPrior->ParamByName("par2")->DataType=ftCursor;
  oqPrior->ParamByName("par2")->ParamType=ptOutput;
  oqPrior->ParamByName("par1")->AsInteger=Parent;
  oqPrior->Execute();
  while(!oqPrior->Eof)
  {

   SPrior *pData=new SPrior;
   pData->mid=oqPrior->FieldByName("mid")->AsInteger;
   pData->ntype=oqPrior->FieldByName("havechild")->AsInteger;
   pData->norder=oqPrior->FieldByName("norder")->AsInteger;
   pData->vname=oqPrior->FieldByName("name")->AsString;
   pData->dstart=oqPrior->FieldByName("dstart")->AsDateTime;
   pData->dend=oqPrior->FieldByName("dend")->AsDateTime;
   pData->olddstart=oqPrior->FieldByName("dstart")->AsDateTime;
   pData->olddend=oqPrior->FieldByName("dend")->AsDateTime;
   pData->editing=0;

  if(pData->ntype==1)
    ParNode = tvHistory->Items->AddObject(NULL, pData->vname, pData);
  else
  {
    Node=tvHistory->Items->AddChildObject(ParNode, pData->vname, pData);

  }

 switch(pData->ntype){
    case 0: Node->ImageIndex =0;
            Node->SelectedIndex =0;
            break;
    case 1: ParNode->ImageIndex =9;
            ParNode->SelectedIndex =9;
            break;
    case 2: Node->ImageIndex =8;
            Node->SelectedIndex =8;
            break;
   }
  if(pData->ntype==0)
     ReadNodePrior(Node);
    oqPrior->Next();
  }

}
//------------------------------------------------------------------------------
 void __fastcall TfmPrior::ReadNodePrior(TTreeNode* ParNode)
 {
   TTreeNode* Node;
   oqTest->Params->Clear();
   oqTest->SQL->Text="begin "+SchemeName+"PRIORITY_PG.getinfo(:par1,:par2,:par3, :par4);end;";
   oqTest->ParamByName("par4")->DataType=ftCursor;
   oqTest->ParamByName("par4")->ParamType=ptOutput;

   oqTest->ParamByName("par1")->AsInteger=Parent;
   oqTest->ParamByName("par2")->AsDateTime=((SPrior*)ParNode->Data)->dstart;
   oqTest->ParamByName("par3")->AsDateTime=((SPrior*)ParNode->Data)->dend;
   oqTest->Execute();
  while(!oqTest->Eof)
  {
  SPrior *pData=new SPrior;
   pData->mid=oqTest->FieldByName("mid")->AsInteger;
   pData->ntype=oqTest->FieldByName("havechild")->AsInteger;
   pData->norder=oqTest->FieldByName("norder")->AsInteger;
   pData->vname=oqTest->FieldByName("name")->AsString;
   pData->dstart=oqTest->FieldByName("dstart")->AsDateTime;
   pData->dend=oqTest->FieldByName("dend")->AsDateTime;
   pData->olddstart=oqTest->FieldByName("dstart")->AsDateTime;
   pData->olddend=oqTest->FieldByName("dend")->AsDateTime;
   pData->editing=0;
      Node = tvHistory->Items->AddChildObject(ParNode, pData->vname, pData);
      Node->ImageIndex =8;
      Node->SelectedIndex =8;
   oqTest->Next();
  }
 }

//---------------------------------------------------------------------------
 bool __fastcall TfmPrior::ReadNodeAdd(TTreeNode* ParNode)
 {
   TTreeNode* Node=NULL;
   oqPrior->Params->Clear();
   oqPrior->SQL->Text="begin "+SchemeName+"PRIORITY_PG.getadd(:par1,:par2);end;";
   oqPrior->ParamByName("par2")->DataType=ftCursor;
   oqPrior->ParamByName("par2")->ParamType=ptOutput;

   oqPrior->ParamByName("par1")->AsInteger=Parent;

   oqPrior->Execute();
  while(!oqPrior->Eof)
  {
  SPrior *pData=new SPrior;
   pData->mid=oqPrior->FieldByName("mid")->AsInteger;
   pData->ntype=oqPrior->FieldByName("havechild")->AsInteger;
   pData->norder=oqPrior->FieldByName("norder")->AsInteger;
   pData->vname=oqPrior->FieldByName("name")->AsString;
   pData->dstart=Date();
   pData->dend=Date()+1;
   pData->olddstart=Date();
   pData->olddend=Date()+1;
   pData->editing=3;
      Node = tvHistory->Items->AddChildObject(ParNode, pData->vname, pData);
      Node->ImageIndex =8;
      Node->SelectedIndex =8;
   oqPrior->Next();

  }
  if(Node) tvHistory->Selected=Node->Parent;
  if(Node) return true;
  else return false;
 }
//----------------------------------------------------------------------------

void __fastcall TfmPrior::tbUpClick(TObject *Sender)
{
   TTreeNode*ptn=tvHistory->Selected;
      TTreeNode*Node;
 // Ctrl+Up
         if(ptn->getPrevSibling()&&ptn->Data&&((SPrior*)ptn->Parent->Data)->ntype==0)
         {
          ptn->MoveTo(ptn->getPrevSibling(),naInsert);

            ptn=ptn->Parent;//Родительский

          Node = ptn->getFirstChild();

          while(Node&&(SPrior*)Node->Data)
          {
            if(((SPrior*)Node->Data)->norder!=Node->Index)
              {
               ((SPrior*)Node->Data)->norder=Node->Index;
                 if(((SPrior*)Node->Data)->editing!=1)
                    ((SPrior*)Node->Data)->editing=1;

              }
           Node = Node->getNextSibling();
        }
    tbSave->Enabled=true;
    tbRefresh->Enabled=true;
      }

}
//---------------------------------------------------------------------------
void __fastcall TfmPrior::tbFUpClick(TObject *Sender)
{
     TTreeNode*ptn=tvHistory->Selected;
      TTreeNode*Node;
 // Ctrl+Up
         if(ptn->Parent->getFirstChild()&&ptn->Data&&((SPrior*)ptn->Parent->Data)->ntype==0)
         {
          ptn->MoveTo(ptn->Parent->getFirstChild(),naInsert);

            ptn=ptn->Parent;//Родительский

          Node = ptn->getFirstChild();

          while(Node&&(SPrior*)Node->Data)
          {
            if(((SPrior*)Node->Data)->norder!=Node->Index)
              {
               ((SPrior*)Node->Data)->norder=Node->Index;
                 if(((SPrior*)Node->Data)->editing!=1)
                    ((SPrior*)Node->Data)->editing=1;

              }
           Node = Node->getNextSibling();
        }
        tbSave->Enabled=true;
       tbRefresh->Enabled=true;
      }

}
//---------------------------------------------------------------------------

void __fastcall TfmPrior::tbDownClick(TObject *Sender)
{
       TTreeNode*ptn=tvHistory->Selected;
       TTreeNode*Node;
 // Ctrl+Down
       if(ptn->getNextSibling()&&ptn->Data&&((SPrior*)ptn->Parent->Data)->ntype==0)
        {
          ptn->getNextSibling()->MoveTo(ptn,naInsert);

            ptn=ptn->Parent;//Родительский

           Node = ptn->getFirstChild();

          while(Node&&(SPrior*)Node->Data)
          {
            if(((SPrior*)Node->Data)->norder!=Node->Index)
              {
               ((SPrior*)Node->Data)->norder=Node->Index;
                if(((SPrior*)Node->Data)->editing!=1)
                    ((SPrior*)Node->Data)->editing=1;
               }
           Node = Node->getNextSibling();
        }
        tbSave->Enabled=true;
        tbRefresh->Enabled=true;
     }
}
//---------------------------------------------------------------------------
void __fastcall TfmPrior::tbEDownClick(TObject *Sender)
{
     TTreeNode*ptn=tvHistory->Selected;
       TTreeNode*Node;
 // Ctrl+Down

       if(ptn->Parent->GetLastChild()&&ptn->Data&&((SPrior*)ptn->Parent->Data)->ntype==0)
        {
          ptn->MoveTo(ptn->Parent->GetLastChild(),naInsert);
          
          if(ptn->getNextSibling()&&ptn->Data&&((SPrior*)ptn->Parent->Data)->ntype==0)
         {
          ptn->getNextSibling()->MoveTo(ptn,naInsert);
          }
       
            ptn=ptn->Parent;//Родительский

           Node = ptn->getFirstChild();

          while(Node&&(SPrior*)Node->Data)
          {
            if(((SPrior*)Node->Data)->norder!=Node->Index)
              {
               ((SPrior*)Node->Data)->norder=Node->Index;
                if(((SPrior*)Node->Data)->editing!=1)
                    ((SPrior*)Node->Data)->editing=1;
               }
           Node = Node->getNextSibling();
        }
    tbSave->Enabled=true;
    tbRefresh->Enabled=true;
     }
}
//---------------------------------------------------------------------------

void __fastcall TfmPrior::Refresh()
{

 tvHistory->Items->BeginUpdate();
 tvHistory->Items->Clear();
 ReadNode(Parent);
 tvHistory->Items->EndUpdate();

 }

//---------------------------------------------------------------------------

void __fastcall TfmPrior::dtStartChange(TObject *Sender)
{
     sbOk->Enabled=true;
}
//---------------------------------------------------------------------------

void __fastcall TfmPrior::sbOkClick(TObject *Sender)
{

    TTreeNode *sNode=tvHistory->Selected;

  if(!sNode||!sNode->Data||((SPrior*)sNode->Data)->ntype!=0)
    return;

  if (dtStart->Date>=dtEnd->Date )
     {
     if(MessageBox(Handle,Reconst_smes133_1.c_str(),Application->Title.c_str(),MB_OK|MB_ICONERROR)==IDOK)
       return;
     }


   if(((SPrior*)sNode->Data)->editing!=2)
    ((SPrior*)sNode->Data)->editing=2;
     sNode->Text=(dtStart->Date).FormatString("dd.mm.yyyy")+" ... "+(dtEnd->Date).FormatString("dd.mm.yyyy");
    ((SPrior*)sNode->Data)->dstart=dtStart->Date;
    ((SPrior*)sNode->Data)->dend=dtEnd->Date;
    
     TTreeNode *sFNode=sNode->getFirstChild();
     while(sFNode){
      if(sFNode->Data&&((SPrior*)sFNode->Data)->ntype>1)
      {
       ((SPrior*)sFNode->Data)->dstart=dtStart->Date;
       ((SPrior*)sFNode->Data)->dend=dtEnd->Date;
       if(((SPrior*)sFNode->Data)->editing==3)
       {
       ((SPrior*)sFNode->Data)->olddstart=dtStart->Date;
       ((SPrior*)sFNode->Data)->olddend=dtEnd->Date;
       ((SPrior*)sFNode->Data)->editing=2;
       }
        if(((SPrior*)sFNode->Data)->editing!=2)
          ((SPrior*)sFNode->Data)->editing=2;
      }
      sFNode=sNode->GetNextChild(sFNode);
     }

     sbOk->Enabled=false;
     tbSave->Enabled=true;
     tbRefresh->Enabled=true;

}

//----------------------------------------------------------------------------------------

void __fastcall TfmPrior::tbSaveClick(TObject *Sender)
{
  vSave();
  tbSave->Enabled=false;

}
//---------------------------------------------------------------------------

void __fastcall TfmPrior::tbRefreshClick(TObject *Sender)
{
   Refresh();
}
//---------------------------------------------------------------------------
 void __fastcall TfmPrior::vSave()
{
  SPrior*pData;
  TTreeNode *Node=NULL;
  oqPrior->Params->Clear();

  oqPrior->SQL->Text="begin "+SchemeName+"PRIORITY_PG.upd_p(:mid,:oldstart ,:start ,:end ,:oldend ,:norder);end;";
try{
  Node = tvHistory->Items->GetFirstNode();

  while(Node){
      if(Node->Data&&((SPrior*)Node->Data)->ntype==2&&((SPrior*)Node->Data)->editing>0){
        pData=(SPrior*)Node->Data;
        oqPrior->ParamByName("mid")->AsInteger=pData->mid;
        oqPrior->ParamByName("norder")->AsInteger=pData->norder;
        oqPrior->ParamByName("start")->AsDateTime=pData->dstart;
        oqPrior->ParamByName("end")->AsDateTime=pData->dend;
        if(((SPrior*)Node->Data)->editing!=3)
        {
        oqPrior->ParamByName("oldstart")->AsDateTime=pData->olddstart;
        oqPrior->ParamByName("oldend")->AsDateTime=pData->olddend;
        }
        else
        {
        oqPrior->ParamByName("oldstart")->Clear();
        oqPrior->ParamByName("oldend")->Clear();
        }
        oqPrior->Execute();

        }
      Node=Node->GetNext();
  }

 Node = tvHistory->Items->GetFirstNode();
  while(Node)
  {
  if(Node->Data&&((SPrior*)Node->Data)->ntype==2&&((SPrior*)Node->Data)->editing>0)
     {
     ((SPrior*)Node->Data)->editing=0;
     ((SPrior*)Node->Data)->olddstart=pData->dstart;
     ((SPrior*)Node->Data)->olddend=pData->dend;
     }
   Node=Node->GetNext();
  }
 }catch (Exception &exception)
   {
      dmMain->orases->Rollback();
      Application->ShowException(&exception);
      if(Node) tvHistory->Selected=Node;
   }
}


//------------------------------------------------------------------------------


void __fastcall TfmPrior::BitBtn1Click(TObject *Sender)
{
 Close();  
}
//---------------------------------------------------------------------------

