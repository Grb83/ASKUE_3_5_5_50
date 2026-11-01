//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "unSetupFilters.h"
#include "unDataMod.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TfmSetupFilters *fmSetupFilters;
//---------------------------------------------------------------------------
__fastcall TfmSetupFilters::TfmSetupFilters(TComponent* Owner)
  : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TfmSetupFilters::FormShow(TObject *Sender)
{
  if(ReadNode(tvFilter,NULL)&&ReadNode(tvEvent,NULL)){
        if(tvFilter->Items->Count){
           tvFilter->OnChange=tvFilterChange;
           tvFilter->Selected = tvFilter->Items->Item[0];
        }
        if(tvEvent->Items->Count){
           tvEvent->Selected=tvEvent->Items->Item[0];
        }
        Width=Width-1;
        Height=Height-1;
        tvFilter->SetFocus();
  }else{
     Close();
  }
}
//---------------------------------------------------------------------------
bool __fastcall TfmSetupFilters::ReadNode(TTreeView* tv,TTreeNode* NodeParent)// Читает ветку дерева
{
    POINTSDIV *pData;
    TTreeNode *AddNode;
    long parmid;
    try{
        dmMain->oqCursor->Params->Clear();
        dmMain->oqCursor->SQL->Text="begin "+SchemeName+"SAA_SELECT_PG.selectpoint_read_node(:par1,:FLAG,:par3); end;";
        dmMain->oqCursor->ParamByName("par3")->ParamType = ptOutput;
        dmMain->oqCursor->ParamByName("par3")->DataType = ftCursor;
        if(NodeParent && NodeParent->HasChildren)
            NodeParent->DeleteChildren();
        if(tv==tvFilter){
            dmMain->oqCursor->ParamByName("FLAG")->AsInteger = 6;//фильтры
            if(!NodeParent){
                CountFilters_Del=0;
                dmMain->oqCursor->ParamByName("par1")->AsInteger = 0;
            }else{
                parmid=((POINTSDIV*)NodeParent->Data)->Id;
                dmMain->oqCursor->ParamByName("par1")->AsInteger = parmid;
            }
        }else{
            dmMain->oqCursor->ParamByName("FLAG")->AsInteger = 7;//сообщения
            if(!NodeParent){
                pData=new POINTSDIV;
                ZeroMemory(pData,sizeof(POINTSDIV));
                strcpy(pData->Name,Reconst_smes74_1.c_str());
                pData->Type = 0;//0 - фильтр; 1 - сообщение
                AddNode = tv->Items->AddChildObject(NULL,pData->Name,pData); // добавляем псевдовершину
                AddNode->ImageIndex = 2;
                AddNode->SelectedIndex = 2;
                dmMain->oqCursor->ParamByName("par1")->AsInteger = 0;
            }else{
                parmid=((POINTSDIV*)NodeParent->Data)->Id;
                dmMain->oqCursor->ParamByName("par1")->AsInteger = parmid;
            }
        }
        dmMain->oqCursor->Execute();

         while(!dmMain->oqCursor->Eof){
         pData = new POINTSDIV;
         ZeroMemory(pData,sizeof(POINTSDIV));
         pData->HaveChild = dmMain->oqCursor->FieldByName("HaveChild")->AsInteger;
         pData->Id = dmMain->oqCursor->FieldByName("mid")->AsInteger;
         pData->tmpId = pData->Id;
         pData->Type = dmMain->oqCursor->FieldByName("type")->AsInteger;
         strcpy(pData->Name,dmMain->oqCursor->FieldByName("name")->AsString.c_str());
         strcpy(pData->PointInfo,dmMain->oqCursor->FieldByName("pinfo")->AsString.c_str());
         pData->Id_event = dmMain->oqCursor->FieldByName("id_event")->AsInteger;
         AddNode = tv->Items->AddChildObject(NodeParent, pData->Name, pData);
         if(pData->Type==0){
           AddNode->ImageIndex = 4;
           AddNode->SelectedIndex = 4;
         }
         else{
           AddNode->ImageIndex = 0;
           AddNode->SelectedIndex = 0;
         }
         if(pData->HaveChild)
            tv->Items->AddChildObject(AddNode,"",NULL);
         dmMain->oqCursor->Next();
         }

    }catch (Exception &exception){

  	    Application->ShowException(&exception);
        return false;
    }
    return true;
}
//---------------------------------------------------------------------------
void __fastcall TfmSetupFilters::tvExpanded(TObject *Sender,
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
void __fastcall TfmSetupFilters::tvFilterExpanding(TObject *Sender,
      TTreeNode *Node, bool &AllowExpansion)
{
  if(Node&&Node->getFirstChild()&&!Node->getFirstChild()->Data){
    Node->DeleteChildren();
    ReadNode(tvFilter, Node);
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmSetupFilters::tvEventExpanding(TObject *Sender,
      TTreeNode *Node, bool &AllowExpansion)
{
  if(Node&&Node->getFirstChild()&&!Node->getFirstChild()->Data){
    Node->DeleteChildren();
    ReadNode(tvEvent, Node);
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmSetupFilters::tvFilterDeletion(TObject *Sender,
      TTreeNode *Node)
{
   if(Node&&Node->Data){
     if(realdeletion&&((POINTSDIV*)Node->Data)->Id)
       nFilters_Del[CountFilters_Del++]=((POINTSDIV*)Node->Data)->Id;
     delete (POINTSDIV*)Node->Data;
   }
}
//---------------------------------------------------------------------------
void __fastcall TfmSetupFilters::tvFilterDragDrop(TObject *Sender,
      TObject *Source, int X, int Y)
{
   TTreeNode* Dst = ((TTreeView*)Sender)->GetNodeAt(X, Y);
   TTreeNode* Src;
   for (int i=0;i<(int)((TTreeView*)Source)->SelectionCount;i++){
     Src = ((TTreeView*)Source)->Selections[i];//Selected;
     if(!Src || !Src->Data)
        throw Exception(Reconst_smes74_2);
     Src->Cut = (GetKeyState(VK_CONTROL)&0x8000);
     if(Src->TreeView==tvFilter)
        Src->Cut = !Src->Cut;
     changeNode(Dst, Src);

     if(Src->TreeView==tvEvent && Src->Cut)
        Src->Cut = false;
     iaSave->Enabled = true;
   }
}
//---------------------------------------------------------------------------
void __fastcall TfmSetupFilters::changeNode(TTreeNode*Dst,TTreeNode*Src)
{
   TTreeNode*newNode;
try{
   Screen->Cursor=crDrag;
   if(!Src || !Src->Data) return;
   if(Dst && Dst->getFirstChild() && !Dst->getFirstChild()->Data)
      ReadNode((TTreeView*)Dst->TreeView, Dst);
   if(Src->TreeView==tvEvent){//Тянем справа
      if(Src->Cut){ // Copy only child Nodes
         if(Src->HasChildren)
            copyChildNodes(Dst, Src);
      }else{// Copy all Tree of Nodes
         POINTSDIV* pFilter = new POINTSDIV();
         memcpy(pFilter,(POINTSDIV*)Src->Data,sizeof(POINTSDIV));
         newNode = tvFilter->Items->AddChildObject(Dst, Src->Text, pFilter);
         newNode->ImageIndex = pFilter->Type?0:4;
         newNode->SelectedIndex = pFilter->Type?0:4;
         pFilter->Id=0;
         pFilter->editing=1;
         if(Src->HasChildren)
            copyChildNodes(newNode, Src);
         if(!tvFilter->Selected){
            tvFilter->OnChange=tvFilterChange;
            tvFilter->Selected=tvFilter->Items->Item[0];
         }
      }
   }else{// редактирование в пределах фильтров
      if(Src->Cut){ // Move
         Src->MoveTo(Dst, naAddChild);
         if(!((POINTSDIV*)Src->Data)->editing)
            ((POINTSDIV*)Src->Data)->editing=1;
      }else{// Copy
         POINTSDIV* pFilter = new POINTSDIV();
         memcpy(pFilter, Src->Data, sizeof(POINTSDIV));
         pFilter->Id = 0;
         pFilter->editing = 1;
         newNode = tvFilter->Items->AddChildObject(Dst, Src->Text, pFilter);
         newNode->ImageIndex = Src->ImageIndex;
         newNode->SelectedIndex = Src->SelectedIndex;
         if(Src->HasChildren)
            copyChildNodes(newNode, Src);
      }
   }
}catch (Exception &exception){
  	Application->ShowException(&exception);
}
   Screen->Cursor=crDefault;
}
//---------------------------------------------------------------------------
void __fastcall TfmSetupFilters::copyChildNodes(TTreeNode*d, TTreeNode*s)
{
   ReadNode((TTreeView*)s->TreeView,s);
   TTreeNode *tn = s->getFirstChild();
   while(tn){
      if (((POINTSDIV*)tn->Data)->Type!=0)
        changeNode(d, tn);
      tn = tn->getNextSibling();
   }
}
//---------------------------------------------------------------------------
bool __fastcall TfmSetupFilters::tvCheckDragOver(TTreeNode*accNode,TTreeNode*srcNode)
{
   POINTSDIV* p=NULL;//Текущее
   POINTSDIV* s;//Перетягиваемое
   try{
      if(!srcNode||!srcNode->Data){
         return false;
      }
      s=(POINTSDIV*)srcNode->Data;
      if(accNode)
         p=(POINTSDIV*)accNode->Data;
      if(srcNode->TreeView==tvEvent){//Тянем справа
         if(!accNode){//Родитель NULL
            if(s->Type)
               return false;
         }else{//Родитель не NULL
            if(p->Type==1)// на сообщение перетягивать нельзя, только на фильтр
               return false;
         }
      }else{//С места на место
         if(!accNode){//Родитель NULL
            if(s->Type||!srcNode->Parent)
               return false;
         }else{//Родитель не NULL
            if(p->Type||srcNode->Parent==accNode||srcNode==accNode||accNode->HasAsParent(srcNode))
               return false;
         }
      }
   }catch(Exception &e){
      return false;
   }
   return true; 
}
//---------------------------------------------------------------------------
void __fastcall TfmSetupFilters::tvFilterDragOver(TObject *Sender,
      TObject *Source, int X, int Y, TDragState State, bool &Accept)
{
   Accept = tvCheckDragOver(
      ((TTreeView*)Sender)->GetNodeAt(X, Y),
      ((TTreeView*)Source)->Selected);
}
//---------------------------------------------------------------------------
void __fastcall TfmSetupFilters::vSave(TObject* Sender)
{
  TTreeNode *Node=NULL;
  POINTSDIV PTreeTable;
  long par_id=0;
  try{
    dmMain->oqCursor->Params->Clear();
    dmMain->oqCursor->SQL->Text="begin "+SchemeName+"SAA_SELECT_PG.ins_upd_filter_p(:par1,:par2,:par3,:par4); end;";

    Node=tvFilter->Items->GetFirstNode();
    while(Node){
       if(Node->Data&&((POINTSDIV*)Node->Data)->editing){
         memcpy(&PTreeTable,(POINTSDIV*)Node->Data,sizeof(POINTSDIV));

         if(Node->Parent)
           par_id=((POINTSDIV*)Node->Parent->Data)->tmpId;
         else
           par_id=0;
          dmMain->oqCursor->ParamByName("par1")->ParamType=ptInputOutput;
          dmMain->oqCursor->ParamByName("par1")->DataType=ftInteger;
          dmMain->oqCursor->ParamByName("par1")->AsInteger=PTreeTable.Id;
          dmMain->oqCursor->ParamByName("par2")->AsInteger=par_id;
          dmMain->oqCursor->ParamByName("par3")->AsString=PTreeTable.Name;
          if (PTreeTable.Type==1) // событие
            dmMain->oqCursor->ParamByName("par4")->AsInteger = PTreeTable.Id_event;// nevent для события
          else
            dmMain->oqCursor->ParamByName("par4")->AsInteger = 0;

          dmMain->oqCursor->Execute();
          PTreeTable.Id=dmMain->oqCursor->ParamByName("par1")->AsInteger;
          ((POINTSDIV*)Node->Data)->tmpId=PTreeTable.Id; // новый Id пока храним в tmpId,
                                                         // т.к. в случае ошибки и повторном проходе цикла нам нужны старые Id
        }
        Node=Node->GetNext();
    }

    dmMain->oqCursor->Params->Clear();
    dmMain->oqCursor->SQL->Text="begin "+SchemeName+"SAA_SELECT_PG.del_filter_p(:par1); end;";
    for(int i=0;i<CountFilters_Del;i++){
      dmMain->oqCursor->ParamByName("par1")->AsInteger=nFilters_Del[i];
      dmMain->oqCursor->Execute();
    }

    dmMain->orases->Commit();

    CountFilters_Del=0;
    Node=tvFilter->Items->GetFirstNode();
    while(Node){
      if(Node->Data&&((POINTSDIV*)Node->Data)->editing){
        ((POINTSDIV*)Node->Data)->editing=0;
        ((POINTSDIV*)Node->Data)->Id = ((POINTSDIV*)Node->Data)->tmpId; // теперь сохраняем новый Id
        //((POINTSDIV*)Node->Data)->tmpId = 0;
        }
      Node=Node->GetNext();
    }
    iaSave->Enabled = false;

  }catch (Exception &exception){
  dmMain->orases->Rollback();

  	Application->ShowException(&exception);
    if(Node){
      tvFilter->Selected=Node;
      tvFilter->SetFocus();
      Node->EditText();
    }
    else
      ReadNode(tvFilter,NULL);
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmSetupFilters::tvFilterChange(TObject *Sender,
      TTreeNode *Node)
{
    if(!Node||!Node->Data){
        iaDelete->Enabled=false;
    }else{
        iaDelete->Enabled=true;
    }
}
//---------------------------------------------------------------------------
void __fastcall TfmSetupFilters::vRefresh(TObject* Sender)
{
  if (iaSave->Enabled &&
     MessageBox(Handle,AnsiString(Reconst_smes74_3).c_str(),Application->Title.c_str(),MB_YESNO|MB_ICONQUESTION|MB_DEFBUTTON2)==IDNO)
       return;
   TCursor oldc = Screen->Cursor;
   Screen->Cursor = crHourGlass;

   tvFilter->OnChange=NULL;
   tvFilter->Visible = false;
   tvFilter->Items->Clear();
   if(ReadNode(tvFilter,NULL)){
      if(tvFilter->Items->Count){
         tvFilter->Selected=tvFilter->Items->Item[0];
         tvFilter->OnChange=tvFilterChange;
      }
   }else
      tvFilterChange(tvFilter,NULL);
   tvFilter->Visible = true;
   tvFilter->SetFocus();

   Screen->Cursor = oldc;
   iaSave->Enabled = false;  
}
//---------------------------------------------------------------------------
void __fastcall TfmSetupFilters::vDelete(TObject* Sender)
{
 if (tvFilter->Focused()){
  if(!iaDelete->Enabled)
    return;
  TTreeNode *sNode=tvFilter->Selected;
  TTreeNode *parNode = sNode->Parent;
  TTreeView *tv=NULL;
  if(sNode&&sNode->Data&&MessageBox(Handle,AnsiString(Reconst_smes74_4+sNode->Text+">?").c_str(),Application->Title.c_str(),MB_YESNO|MB_ICONQUESTION|MB_DEFBUTTON2)==IDYES){
    tv=(TTreeView*)sNode->TreeView;
    try{
      realdeletion=true;
       if (sNode->HasChildren)// читаем детей для их удаления
         ReadNode(tvFilter,sNode);
      sNode->Delete();
      realdeletion=false;
      iaSave->Enabled = true;
    }catch(Exception &e){
      realdeletion=false;
      throw;
    }
    if(tv&&!tv->Items->Count&&tv->OnChange)
      tv->OnChange(tv,NULL);
    if (parNode && !parNode->HasChildren)
      tv->OnExpanded(tv,parNode);// обновляем иконку для родителя после удаления его детей
  }
 }
}
//---------------------------------------------------------------------------
void __fastcall TfmSetupFilters::tvFilterKeyUp(TObject *Sender, WORD &Key,
      TShiftState Shift)
{
  if (Key == VK_F2 && tvFilter->Selected && ((POINTSDIV*)tvFilter->Selected->Data)->Type==0)
    tvFilter->Selected->EditText();
  if (Key == VK_DELETE)
    vDelete(this);
}
//---------------------------------------------------------------------------
void __fastcall TfmSetupFilters::tvFilterEdited(TObject *Sender,
      TTreeNode *Node, AnsiString &S)
{
  if (Node->Text!=S){
    strcpy(((POINTSDIV*)Node->Data)->Name,S.c_str());
    ((POINTSDIV*)Node->Data)->editing = true;
    iaSave->Enabled = true;
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmSetupFilters::iaCloseExecute(TObject *Sender)
{
 if (iaSave->Enabled)
   vSave(this);
 if(!iaSave->Enabled)
   ModalResult=mrOk;
}
//---------------------------------------------------------------------------
