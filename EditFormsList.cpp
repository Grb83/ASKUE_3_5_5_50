//---------------------------------------------------------------------------
#include <vcl.h>
#include <stdio.h>
#pragma hdrstop
#define max(a, b)  (((a) > (b)) ? (a) : (b))
#define min(a, b)  (((a) < (b)) ? (a) : (b))
#include "EditFormsList.h"
#include "Interior.h"
#include "Saa_SelectGroup.h"
#include "selectpoint.h"
#include "CopySchemaParams.h"
#include "Saa_SelectGroup.h" // только для ручного копирования привязанных файлов Add by KSS
#include "unSpecParam.h"
#include "Reconst.hpp"
#pragma link "DBAccess"
#pragma link "MemDS"
#pragma link "Ora"
#pragma resource "*.dfm"
//---------------------------------------------------------------------------
#define  MAXTABLESIZE 256
//---------------------------------------------------------------------------
__fastcall TFormEditFormList::TFormEditFormList(TComponent* Owner, AnsiString Name, TAccess a)
	: TMainForm(Owner, Name, a)
{
   ShowAction(iaDelete);
   ShowAction(iaClone);
   btDel->Caption = "";
   btClon->Caption = "";
}
//---------------------------------------------------------------------------


bool __fastcall TFormEditFormList::GetShemas(void)
{

    try{
       cbSchema->Items->Clear();
       dmMain->oqCursor->Params->Clear();
       dmMain->oqCursor->SQL->Text="begin "+SchemeName+"interior_pg.EditFormList_GetShemas_p(:par1);end;";
       dmMain->oqCursor->ParamByName("par1")->DataType=ftCursor;
       dmMain->oqCursor->ParamByName("par1")->ParamType=ptOutput;

        dmMain->oqCursor->Execute();

       while(!dmMain->oqCursor->Eof){
       cbSchema->Items->AddObject(dmMain->oqCursor->FieldByName("name")->AsString,
                    (TObject*)dmMain->oqCursor->FieldByName("monitor")->AsInteger);
       dmMain->oqCursor->Next();
       }
         if(cbSchema->Items->Count){
            cbSchema->ItemIndex=0;
            CurrentSchema=(long)cbSchema->Items->Objects[cbSchema->ItemIndex];
        }else
            throw Exception(Reconst_smes21_1);
    }catch (Exception &exception){
        Application->ShowException(&exception);
        return false;
    }
    return true;
}
//---------------------------------------------------------------------------

void __fastcall TFormEditFormList::ReadGroupNode(TTreeNode* NodeParent)// Читает ветку дерева групп
{
    AUXDIV *PTreeTable;
    TTreeNode *AddNode;



      dmMain->oqCursor->Params->Clear();
      dmMain->oqCursor->SQL->Text="begin "+SchemeName+"interior_pg.EditFormList_ReadGroupNode_p(:par1,:par2,:par3);end;";
      dmMain->oqCursor->ParamByName("par3")->DataType=ftCursor;
      dmMain->oqCursor->ParamByName("par3")->ParamType=ptOutput;
       
      dmMain->oqCursor->ParamByName("par1")->AsInteger=(NodeParent)?1:0;
      if(NodeParent)
      dmMain->oqCursor->ParamByName("par2")->AsInteger=((AUXDIV*)NodeParent->Data)->Id;
      else
      dmMain->oqCursor->ParamByName("par2")->Clear();
      dmMain->oqCursor->Execute();
     while(!dmMain->oqCursor->Eof){
     PTreeTable=new AUXDIV;
     ZeroMemory(PTreeTable,sizeof(AUXDIV));
     PTreeTable->editing=dmMain->oqCursor->FieldByName("HaveChild")->AsInteger;
     PTreeTable->Id=dmMain->oqCursor->FieldByName("gid")->AsInteger;
     strcpy(PTreeTable->Name,dmMain->oqCursor->FieldByName("name")->AsString.c_str());
     AddNode = tvGroup->Items->AddChildObject(NodeParent,PTreeTable->Name,PTreeTable);
     AddNode->ImageIndex=2;
     AddNode->SelectedIndex=2;
            if(PTreeTable->editing){
                tvGroup->Items->AddChildObject(AddNode,"",(void*)0);
                PTreeTable->editing=0;
            }
       dmMain->oqCursor->Next();
       }
}
//---------------------------------------------------------------------------

bool __fastcall TFormEditFormList::GetGroups(void)
{
  TTreeNode *tn;
  try{

    tvGroup->Items->Clear();
    ReadGroupNode(NULL);
    if(tvGroup->Items->Count){
      tn=tvGroup->Items->Item[0];
      while(tn){
        if(tn->getFirstChild()&&!tn->getFirstChild()->Data){
          tn->DeleteChildren();
          ReadGroupNode(tn);
        }
        tn=tn->GetNext();
      }
      if(customer_id!=1&&customer_id!=51)
         tvGroup->FullExpand();
    }
  }catch (Exception &exception){

  	Application->ShowException(&exception);
    return false;
  }

  return true;
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFormList::tvFormChange(TObject *Sender,
      TTreeNode *Node)
{
    if(ActiveControl) oldCtrl = ActiveControl;

    short ind[1];
    unsigned long cnt;
    int state;
    TTreeNode *tn;
    POINTSDIV *PTreeTable=NULL;
    TList *ls=NULL;
    bool repform=false;

    try{
      EnableEvents(false);
      if(tvGroup->Items->Count){
         tn=tvGroup->Items->Item[0];
         while(tn){
            if(((AUXDIV*)tn->Data)->editing!=0)
               ((AUXDIV*)tn->Data)->editing=0;
            tn=tn->GetNext();
         }
      }
      if(Node&&Node->Data){
         PTreeTable=(POINTSDIV*)Node->Data;
         ls=PTreeTable->GroupList;
         if(ls)
            for(int i=0;i<ls->Count;i++){
               tn=(TTreeNode *)ls->Items[i];
               ((AUXDIV*)tn->Data)->editing=1;
            }
      }
      repform = PTreeTable&&(
        PTreeTable->CodeTamplate==EXCEL_F ||        //Универсальная форма отображения данных
        PTreeTable->CodeTamplate==EXCEL_REP_F ||    //Универсальная форма отображения отчетов
        PTreeTable->CodeTamplate==SCHEMA_OP_FORM || //Оперативная форма отображения схемы сети // Add by KSS
        PTreeTable->CodeTamplate==MODUS_OP_FORM || //Оперативная форма отображения схемы сети От МОДУСа // Add by KSS
        PTreeTable->CodeTamplate==EXCEL_OP_FORM || //Оперативная форма без маштабирования
        PTreeTable->CodeTamplate==EXCEL_REP_OUT_F   //Универсальная форма отображения отчетов во внешнем Excel'e
        );
      if(PTreeTable){
         edName->Text=PTreeTable->Name;
         edComment->Text=PTreeTable->Comment;
         edTemplates->Text=PTreeTable->TemplName;
         lbFormId->Text=(PTreeTable->Id>0)?IntToStr(PTreeTable->Id):AnsiString("");
         //chig
         edPLProc->Text=PTreeTable->pLProc;
         cbTimeFields->Checked=(PTreeTable->EnableControls[ cbTimeFields->Tag ]=='1');
         cbSecondBound->Checked=(PTreeTable->EnableControls[ cbSecondBound->Tag ]=='1');
         cbCheckPoints->Checked=(PTreeTable->EnableControls[ cbCheckPoints->Tag ]=='1');//add by NNV
         btnMainSelect->Enabled=cbCheckPoints->Checked;
         eDuplPoint->Enabled=btnMainSelect->Enabled;
         eDuplPoint->Text=PTreeTable->MidName;
         //e chig
         if(PTreeTable->CodeTamplate && !repform)
         {
            cbGroup->Checked=(PTreeTable->EnableControls[0]=='1');
            cbCalendar->Checked=(PTreeTable->EnableControls[5]=='1');
            for(int i=0;i<4;i++){
               eProf[i].cb->Checked=(PTreeTable->EnableControls[i+1]=='1');
               eProf[i].rb->Checked=0;
               eProf[i].rb->Enabled=eProf[i].cb->Checked;
            }
            if(PTreeTable->StepProfile>=1&&PTreeTable->StepProfile<=4)
               eProf[PTreeTable->StepProfile-1].rb->Checked=eProf[PTreeTable->StepProfile-1].cb->Checked;
         }
      }else{
         edName->Text="";
         edComment->Text="";
         lbFormId->Text="";
         edTemplates->Text="";
         edPLProc->Text="";
         eDuplPoint->Text="";
      }
      //cbPoint->Visible = (PTreeTable&&PTreeTable->NewEnableControls[6]=='1');
      //cbRegime->Visible = (PTreeTable&&PTreeTable->NewEnableControls[7]=='1'); // возможность выбора отображения панели "перечень отображаемых данных"
      cbPoint->Checked = (PTreeTable&&PTreeTable->EnableControls[6]=='1');
      //cbRegime->Checked = (PTreeTable&&PTreeTable->EnableControls[7]=='1');//выбрано или нет отображение панели "перечень отображаемых данных"
      cbRegime->Checked = false;
      aRight->Enabled=((Access==accWrite)&&(PTreeTable&&tvGroup->Selected&&PTreeTable->CodeTamplate&&pgControl->ActivePage==tsGroup));
      aLoadFile->Enabled=(PTreeTable&&repform);
      iaDelete->Enabled=PTreeTable;
      paControl->Visible=(PTreeTable&&PTreeTable->CodeTamplate&&!repform);
      paComment->Visible=(PTreeTable&&PTreeTable->CodeTamplate);
      //GRB CHANGE 25.01.2019
      //paParButton->Visible=(PTreeTable&&PTreeTable->CodeTamplate==PL_SQL_TABLE);
      paParButton->Visible=((PTreeTable&&PTreeTable->CodeTamplate==PL_SQL_TABLE)||(PTreeTable&&PTreeTable->CodeTamplate==PL_SQL_MANY_TABLE));
      //END GRB CHANGE
      if (PTreeTable&&IsCommonRepForm( PTreeTable->CodeTamplate ) )
      {
         paControl->Visible = false;
         Panel10->Height = 192;
         PnlTimePnl->Enabled=true;
         //GRB CHANGE 25.01.2019
         //PnlProcName->Visible = ((PTreeTable->CodeTamplate==PL_SQL_REP_F)||(PTreeTable->CodeTamplate==PL_SQL_TABLE));
         //PnlProcName->Enabled = ((PTreeTable->CodeTamplate==PL_SQL_REP_F)||(PTreeTable->CodeTamplate==PL_SQL_TABLE));
         PnlProcName->Visible = ((PTreeTable->CodeTamplate==PL_SQL_REP_F)||(PTreeTable->CodeTamplate==PL_SQL_TABLE)||(PTreeTable->CodeTamplate==PL_SQL_MANY_TABLE));
         PnlProcName->Enabled = ((PTreeTable->CodeTamplate==PL_SQL_REP_F)||(PTreeTable->CodeTamplate==PL_SQL_TABLE)||(PTreeTable->CodeTamplate==PL_SQL_MANY_TABLE));

        //END GRB CHANGE

      }else{
         Panel10->Height = 96;
         PnlTimePnl->Enabled=false;
      }
         //делаем видмымым

      lbPLProc->Visible = PTreeTable&&IsCommonRepForm( PTreeTable->CodeTamplate );
      edPLProc->Visible = PTreeTable&&IsCommonRepForm( PTreeTable->CodeTamplate );
         //e делаем видмымым
      if(Access==accWrite) paAll->Enabled = PTreeTable;
    }catch (Exception &exception){
  	   Application->ShowException(&exception);
    }
    EnableEvents(true);
    tvGroupChange(tvGroup,tvGroup->Selected);
    tvGroup->Invalidate();
    try{
        ActiveControl = oldCtrl;
    }catch(Exception&e){
        ActiveControl = NULL;
    }
}
//---------------------------------------------------------------------------

void __fastcall TFormEditFormList::tvGroupAdvancedCustomDrawItem(
   TCustomTreeView *Sender, TTreeNode *Node, TCustomDrawState State,
   TCustomDrawStage Stage, bool &PaintImages, bool &DefaultDraw)
{
   if (Node->Data&&((AUXDIV*)Node->Data)->editing)
      Sender->Canvas->Font->Style = TFontStyles() << fsUnderline;
   else{
      Sender->Canvas->Font->Style = TFontStyles() << fsBold;
      Sender->Canvas->Font->Style = TFontStyles();
   }
}
//---------------------------------------------------------------------------

void __fastcall TFormEditFormList::tvGroupDeletion(TObject *Sender,
      TTreeNode *Node)
{
  if(Node&&Node->Data)
    delete (AUXDIV*)Node->Data;
}
//---------------------------------------------------------------------------

void __fastcall TFormEditFormList::tvExpanding(TObject *Sender,
      TTreeNode *Node, bool &AllowExpansion)
{
  if(Node&&Node->getFirstChild()&&!Node->getFirstChild()->Data){
    Node->DeleteChildren();
    ReadNode((TTreeView*)Sender,Node);
  }
}
//---------------------------------------------------------------------------

void __fastcall TFormEditFormList::tvDeletion(TObject *Sender,
      TTreeNode *Node)
{
  if(SelectedNode&&SelectedNode==Node)
    SelectedNode=NULL;
  if(Node&&Node->Data){
    if(realdeletion&&((POINTSDIV*)Node->Data)->Id)
      nForms_Del[CountForms_Del++]=((POINTSDIV*)Node->Data)->Id;
    if(((POINTSDIV*)Node->Data)->GroupList)
      delete ((POINTSDIV*)Node->Data)->GroupList;
    delete (POINTSDIV*)Node->Data;
  }
}
//---------------------------------------------------------------------------

void __fastcall TFormEditFormList::tvExpColl(TObject *Sender,
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

void __fastcall TFormEditFormList::vSave(TObject *Sender)
{
  TTreeNode *Node=NULL;
  POINTSDIV PTreeTable;
  long ltmp=0;
  TList *ls;
  try{
     oqvSave->SQL->Text="declare \
                  ln_codetamplate NUMBER; \
                  ln_parent NUMBER; \
                begin \
                  if :par4>0 then \
                    ln_codetamplate:=:par4; \
                  end if; \
                  if :par2>0 then \
                    ln_parent:=:par2;\
                  end if; \
                  if :par1>0 then \
                    "+SchemeName+"editforms_pg.upd_p(:par1,ln_parent,:par3,ln_codetamplate,:par5,:par6,:par7,:par8,:par9,:par11,:par10,:par12); \
                  else \
                    "+SchemeName+"editforms_pg.ins_p(ln_parent,:par3,ln_codetamplate,:par5,:par6,:par7,:par8,:par9,:par11,:par10,:par12,:par1); \
                  end if; \
                end;";

    Node=tvForm->Items->GetFirstNode();
    while(Node){
      if(Node->Data&&((POINTSDIV*)Node->Data)->editing){
        memcpy(&PTreeTable,(POINTSDIV*)Node->Data,sizeof(POINTSDIV));
        ltmp=(Node->Parent)?((POINTSDIV*)Node->Parent->Data)->tmpId:0;
        ls=PTreeTable.GroupList;
        oqvSave->ParamByName("par10")->Table=true;
        oqvSave->ParamByName("par10")->Length=1;
        oqvSave->ParamByName("par10")->ItemAsInteger[1]=0;
//        oqvSave->ParamByName("par10")->Clear();
        if(ls){
          for(int k=0;k<ls->Count;k++){
            oqvSave->ParamByName("par10")->Length=k+1;
            oqvSave->ParamByName("par10")->ItemAsInteger[k+1]=((AUXDIV*)((TTreeNode *)ls->Items[k])->Data)->Id;
          }
        }
        oqvSave->ParamByName("par1")->DataType=ftInteger;
        oqvSave->ParamByName("par1")->ParamType=ptInputOutput;
        oqvSave->ParamByName("par1")->AsInteger=PTreeTable.Id;
        oqvSave->ParamByName("par2")->AsInteger=ltmp;
        oqvSave->ParamByName("par3")->AsInteger=CurrentSchema;
        oqvSave->ParamByName("par4")->AsInteger=PTreeTable.CodeTamplate;
        oqvSave->ParamByName("par5")->AsString=PTreeTable.Name;
        oqvSave->ParamByName("par6")->AsString=PTreeTable.Comment;
        oqvSave->ParamByName("par7")->AsString=PTreeTable.EnableControls;
        oqvSave->ParamByName("par8")->AsInteger=PTreeTable.StepProfile;
        oqvSave->ParamByName("par9")->AsString=PTreeTable.NameAlert;
        oqvSave->ParamByName("par11")->AsString=PTreeTable.pLProc;
        if(PTreeTable.Mid>0)
          oqvSave->ParamByName("par12")->AsInteger=PTreeTable.Mid;
        else
          oqvSave->ParamByName("par12")->Clear();
        oqvSave->Execute();
        PTreeTable.Id = oqvSave->ParamByName("par1")->AsInteger;
        ((POINTSDIV*)Node->Data)->tmpId=PTreeTable.Id;
      }
      Node=Node->GetNext();
    }

    //GRB FIX 25.05.2018 - GETTING ORA EXCEPTION ORA-00936 WHEN USER TRY TO DELETE FORM, CREATED IN ANOTHER ORACLE SESSION IN THAT BLOCK
    /*dmMain->qwInter->SQL->Text="begin "+SchemeName+"editforms_pg.del_p(:par1); end;";
    for(int i=0;i<CountForms_Del;i++){
      ltmp=nForms_Del[i];
      dmMain->qwInter->ParamByName("par1")->AsInteger=ltmp;
      dmMain->qwInter->Execute();
    }
   dmMain->orases->Commit();*/
   //END OF REPLACING

   //GRB FIX 25.05.2018 - BLOCK REPLACER
   Variant vPar[1];
   for(int i=0;i<CountForms_Del;i++){
     vPar[0] = nForms_Del[i];
     dmMain->orases->ExecProc(SchemeName+"editforms_pg.del_p",vPar,0);
   }
   dmMain->orases->Commit();
  //END OF REPLACER
   
   CountForms_Del=0;
   Node=tvForm->Items->GetFirstNode();
   while(Node){
      if(Node->Data&&((POINTSDIV*)Node->Data)->editing){
        ((POINTSDIV*)Node->Data)->editing=0;
        ((POINTSDIV*)Node->Data)->Id=((POINTSDIV*)Node->Data)->tmpId;
      }
      Node=Node->GetNext();
    }
    EditRec=false;
  }catch (Exception &exception){
    dmMain->orases->Rollback();
  	Application->ShowException(&exception);
    if(Node)
      tvForm->Selected=Node;
  }
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFormList::ReloadData(void)
{
  tvForm->OnChange=NULL;
  tvForm->OnChanging=NULL;
  Screen->Cursor=crHourGlass;
  tvForm->Visible=false;
  tvForm->Items->Clear();
  Screen->Cursor=crDefault;
  if(ReadNode(tvForm,NULL)){
    if(tvForm->Items->Count){
      tvForm->OnChange=tvFormChange;
      tvForm->Selected=tvForm->Items->Item[0];
    }else
      tvFormChange(tvForm,NULL);
  }else{
    tvFormChange(tvForm,NULL);
  }
  tvForm->Visible=true;
}
//---------------------------------------------------------------------------

void __fastcall TFormEditFormList::cbSchemaChange(TObject *Sender)
{
   if(EditRec){
      switch(MessageBox(Handle,Reconst_smes21_3.c_str(),Application->Title.c_str(),MB_YESNOCANCEL|MB_ICONQUESTION|MB_DEFBUTTON1)){
      case IDYES:
         vSave(Sender);
         if(EditRec){
            cbSchema->OnChange=NULL;
            cbSchema->ItemIndex=OldSchemaIndex;
            cbSchema->OnChange=cbSchemaChange;
            return;
         }
         break;
      case IDCANCEL:
         cbSchema->OnChange=NULL;
         cbSchema->ItemIndex=OldSchemaIndex;
         cbSchema->OnChange=cbSchemaChange;
         return;
      case IDNO:
         EditRec = false;
      }
   }
   OldSchemaIndex=cbSchema->ItemIndex;
   CurrentSchema=(long)cbSchema->Items->Objects[cbSchema->ItemIndex];
   ReloadData();
}
//---------------------------------------------------------------------------

void __fastcall TFormEditFormList::vRefresh(TObject *Sender)
{
  ReloadData();
}
//---------------------------------------------------------------------------

void __fastcall TFormEditFormList::vDelete(TObject *Sender)
{
  if(!iaDelete->Enabled)
    return;
  TTreeNode *sNode=tvForm->Selected;
  TTreeView *tv=NULL;
  if(sNode&&sNode->Data&&MessageBox(Handle,AnsiString(Reconst_smes21_4+sNode->Text+">?").c_str(),Application->Title.c_str(),MB_YESNO|MB_ICONQUESTION|MB_DEFBUTTON2)==IDYES){
    tv=(TTreeView*)sNode->TreeView;
    try{
      realdeletion=true;
      sNode->Delete();
      realdeletion=false;
    }catch(Exception &e){
      realdeletion=false;
      throw;
    }
    if(tv&&!tv->Items->Count&&tv->OnChange)
      tv->OnChange(tv,NULL);
      EditRec=true;
  }
}
//---------------------------------------------------------------------------

void __fastcall TFormEditFormList::btRightClick(TObject *Sender)
{
  if(!aRight->Enabled)
    return;
  TList *ls=((POINTSDIV*)tvForm->Selected->Data)->GroupList;
  TTreeNode *tn;
  int rez;
  if(((AUXDIV*)tvGroup->Selected->Data)->editing){
    ((AUXDIV*)tvGroup->Selected->Data)->editing=0;
    ls->Remove(tvGroup->Selected);
  }else{
    if(ls->Count>=MAXTABLESIZE)
      throw Exception(Reconst_smes21_5+IntToStr(MAXTABLESIZE));
    tn=tvGroup->Selected->Parent;
    while(tn){
      if(((AUXDIV*)tn->Data)->editing==1){
        if(customer_id==1||customer_id==51)
          rez=MessageBox(Handle,Reconst_smes21_6.c_str(),Application->Title.c_str(),MB_OK|MB_ICONERROR);
        else
          rez=MessageBox(Handle,AnsiString(Reconst_smes21_7+
                                              tvGroup->Selected->Text+
                                              Reconst_smes21_8).c_str(),Application->Title.c_str(),MB_YESNOCANCEL|MB_ICONQUESTION|MB_DEFBUTTON2);
        switch(rez){
          case IDYES:
            tn=NULL;
            break;
          default:
            return;
        }
      }
      if(tn)
        tn=tn->Parent;
    }
    tn=tvGroup->Selected->GetNext();
    bool bfirst=true;
    bool bdelacc=true;
    while(tn&&tn->HasAsParent(tvGroup->Selected)){
      if(((AUXDIV*)tn->Data)->editing==1){
        if(bfirst){
          bfirst=false;
          if(customer_id==1||customer_id==51){
            if(MessageBox(Handle,AnsiString(Reconst_smes21_9+
                                 tvGroup->Selected->Text+">?").c_str(),Application->Title.c_str(),MB_YESNOCANCEL|MB_ICONWARNING|MB_DEFBUTTON1)!=IDYES)
              return;
          }else{
            switch(MessageBox(Handle,AnsiString(Reconst_smes21_10+
                                  tvGroup->Selected->Text+">?").c_str(),Application->Title.c_str(),MB_YESNOCANCEL|MB_ICONQUESTION|MB_DEFBUTTON1)){
              case IDYES:
                bdelacc=true;
                break;
              case IDNO:
                bdelacc=false;
                break;
              default:
                return;
            }
          }
        }
      }
      if(bdelacc){
        ((AUXDIV*)tn->Data)->editing=0;
        ls->Remove(tn);
      }
      tn=tn->GetNext();
    }
    ((AUXDIV*)tvGroup->Selected->Data)->editing=1;
    ls->Add(tvGroup->Selected);
  }
  ((POINTSDIV*)tvForm->Selected->Data)->editing=1;
    EditRec=true;
  tvGroupChange(tvGroup,tvGroup->Selected);
  tvGroup->Invalidate();
}
//---------------------------------------------------------------------------

void __fastcall TFormEditFormList::tvGroupChange(TObject *Sender,
      TTreeNode *Node)
{
  if(Node&&!((AUXDIV*)Node->Data)->editing)
    btRight->Caption=Reconst_smes21_11;
  else
    btRight->Caption=Reconst_smes21_12;
}
//---------------------------------------------------------------------------

void __fastcall TFormEditFormList::pgControlChange(TObject *Sender)
{
  if(pgControl->ActivePage!=tsGroup)
    aRight->Enabled=false;
  else{
    TTreeNode *sNode=tvForm->Selected;
    if(sNode&&sNode->Data)
      aRight->Enabled=((Access==accWrite)&&(tvGroup->Selected&&((POINTSDIV*)sNode->Data)->CodeTamplate));
  }
}
//---------------------------------------------------------------------------

void __fastcall TFormEditFormList::tvGroupKeyPress(TObject *Sender,
      char &Key)
{
  if(Key==32) // Space Key
    btRightClick(btRight);
}
//---------------------------------------------------------------------------

void __fastcall TFormEditFormList::BtnLoadFileClick(TObject *Sender)
{
  if(!aLoadFile->Enabled)
    return;
  if(!((POINTSDIV*)tvForm->Selected->Data)->Id)
    throw Exception(Reconst_smes21_13);
  if(OpenDialog1->Execute())
  switch(WriteFile_Ex_to_DB(((POINTSDIV*)tvForm->Selected->Data)->Id, OpenDialog1->FileName))
  {
  case 1:
    MessageDlg(Reconst_smes21_14, mtInformation, TMsgDlgButtons() << mbOK, 0);
    break;
  case 2:
    MessageDlg(Reconst_smes21_15, mtInformation, TMsgDlgButtons() << mbOK, 0);
    break;
  }
}
//---------------------------------------------------------------------------

void __fastcall TFormEditFormList::edTextChange(TObject *Sender)
{
#define Sender ((TEdit*)Sender)
  TTreeNode* sNode=tvForm->Selected;
  if(!sNode||!sNode->Data)
    return;
  POINTSDIV* p=(POINTSDIV*)sNode->Data;
  if(!Sender->Tag)
  {//Назхвание
    strcpy(p->Name,Sender->Text.c_str());
    sNode->Text=Sender->Text;
  }
  else if ( 1 == Sender->Tag )//Комментарий
    strcpy(p->Comment,Sender->Text.c_str());
  else if ( 2 == Sender->Tag )//Процедура
    strcpy(p->pLProc,Sender->Text.c_str());

  if(!p->editing)
    p->editing=1;
    EditRec=true;
#undef Sender
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFormList::cbCtrClick(TObject *Sender)
{
#define Sender ((TCheckBox*)Sender)
  TTreeNode* sNode=tvForm->Selected;
  if(!sNode||!sNode->Data)
    return;
  POINTSDIV* p=(POINTSDIV*)sNode->Data;
  p->EnableControls[Sender->Tag]=(Sender->Checked)?'1':'0';
  //Только для выбора точек
  if(Sender==cbCheckPoints){ //Запускаем окно изменения точек
    btnMainSelectClick(Sender);
  }
  if(!p->editing)
    p->editing=1;
    EditRec=true;
#undef Sender
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFormList::cbClick(TObject *Sender)
{
#define Sender ((TCheckBox*)Sender)
  TTreeNode* sNode=tvForm->Selected;
  if(!sNode||!sNode->Data)
    return;
  POINTSDIV* p=(POINTSDIV*)sNode->Data;
  EnableEvents(false);
  p->EnableControls[Sender->Tag]=(Sender->Checked)?'1':'0';
  eProf[Sender->Tag-1].rb->Enabled=Sender->Checked;
  if(!Sender->Checked&&eProf[Sender->Tag-1].rb->Checked)
    eProf[Sender->Tag-1].rb->Checked=false;

  long checkid=-1;
  for(int i=0;i<4;i++){
    if(eProf[i].cb->Checked){
      if(checkid<0)
        checkid=i;
      else{
        checkid=-1;
        break;
      }
    }
  }
  p->StepProfile=0;
  if(checkid>=0){
    eProf[checkid].rb->Checked=true;
    p->StepProfile=checkid+1;
  }else{
    for(int i=0;i<4;i++){
      if(eProf[i].rb->Checked){
        p->StepProfile=i+1;
        break;
      }
    }
    if(!p->StepProfile){
      for(int i=0;i<4;i++){
        if(eProf[i].cb->Checked){
          eProf[i].rb->Checked=true;
          p->StepProfile=i+1;
          break;
        }
      }
    }
  }
  EnableEvents(true);
  if(!p->editing)
    p->editing=1;
    EditRec=true;
#undef Sender
}
//---------------------------------------------------------------------------

void __fastcall TFormEditFormList::rbClick(TObject *Sender)
{
#define Sender ((TCheckBox*)Sender)
  TTreeNode* sNode=tvForm->Selected;
  if(!sNode||!sNode->Data)
    return;
  POINTSDIV* p=(POINTSDIV*)sNode->Data;
  p->StepProfile=0;
  for(int i=0;i<4;i++){
    if(eProf[i].rb->Checked){
      p->StepProfile=i+1;
      break;
    }
  }
  if(!p->editing)
    p->editing=1;
  EditRec=true;
#undef Sender
}
//---------------------------------------------------------------------------

void __fastcall TFormEditFormList::EnableEvents(bool enab)
{
    if(enab){
        edName->OnChange=edTextChange;
        edComment->OnChange=edTextChange;
        edPLProc->OnChange=edTextChange;
        cbGroup->OnClick=cbCtrClick;
        cbPoint->OnClick=cbCtrClick;
        cbCalendar->OnClick=cbCtrClick;
        //chig
        cbTimeFields->OnClick=cbCtrClick;
        cbSecondBound->OnClick=cbCtrClick;
        cbRegime->OnClick = cbCtrClick;
        cbCheckPoints->OnClick = cbCtrClick;//add by NNV
        //e chig
        for(int i=0;i<4;i++){
            eProf[i].cb->OnClick=cbClick;
            eProf[i].rb->OnClick=rbClick;
        }
        tvGroup->OnKeyPress=tvGroupKeyPress;
    }else{
        edName->OnChange=NULL;
        edComment->OnChange=NULL;
        edPLProc->OnChange=NULL;
        cbGroup->OnClick=NULL;
        cbPoint->OnClick=NULL;
        cbCalendar->OnClick=NULL;
        //chig
        cbTimeFields->OnClick=NULL;
        cbSecondBound->OnClick=NULL;
        cbRegime->OnClick = NULL;
        cbCheckPoints->OnClick = NULL;//add by NNV
        //e chig
        for(int i=0;i<4;i++){
            eProf[i].cb->OnClick=NULL;
            eProf[i].rb->OnClick=NULL;
        }
        tvGroup->OnKeyPress=NULL;
    }
}
//---------------------------------------------------------------------------

void __fastcall TFormEditFormList::tvTempStartDrag(TObject *Sender,
      TDragObject *&DragObject)
{
  SelectedNode=((TTreeView*)Sender)->Selected;
}
//---------------------------------------------------------------------------

bool __fastcall TFormEditFormList::tvCheckDragOver(TTreeNode* Node,TTreeNode* MovNode)
{
    if(Access==accRead) return false;
    POINTSDIV* s;//Перетягиваемое
    try{
        if((!Node||(Node&&Node->TreeView==tvForm))&&MovNode&&MovNode->TreeView==tvForm)
        if(!Node||(Node!=MovNode->Parent&&MovNode!=Node))
        {
            POINTSDIV* mov = (POINTSDIV*)MovNode->Data;
            POINTSDIV* acc = Node?(POINTSDIV*)Node->Data:NULL;
            if((!acc||(!acc->CodeTamplate))&&mov)
                return true;
        }else return false;
        if(!SelectedNode||!SelectedNode->Data)
            return false;
        s=(POINTSDIV*)SelectedNode->Data;
        if(Node){
            if(((POINTSDIV*)Node->Data)->CodeTamplate)
                return false;
        }else if(s->CodeTamplate) return false;
    }catch(Exception&e){
        return false;
    }
    return true;
}
//---------------------------------------------------------------------------

void __fastcall TFormEditFormList::tvFormDragOver(TObject *Sender,
      TObject *Source, int X, int Y, TDragState State, bool &Accept)
{
  Accept = tvCheckDragOver(((TTreeView*)Sender)->GetNodeAt(X, Y),((TTreeView*)Source)->Selected);
}
//---------------------------------------------------------------------------

void __fastcall TFormEditFormList::tvFormDragDrop(TObject *Sender,
      TObject *Source, int X, int Y)
{
  bool Accept=true;
  TTreeNode* Node=((TTreeView*)Sender)->GetNodeAt(X, Y);
  POINTSDIV* PTreeTable;

  Accept = tvCheckDragOver(Node,((TTreeView*)Source)->Selected);
  if(!Accept)
    return;

  try{
   if(Source==Sender&&Source==tvForm)
   {
      if(Node&&Node->getFirstChild()&&!Node->getFirstChild()->Data){
         Node->DeleteChildren();
         ReadNode((TTreeView*)Sender,Node);
      }
      tvForm->Selected->Collapse(false);
      if(Node){
         Node->Expand(false);
         tvForm->Selected->MoveTo(Node, naAddChild);
      } else tvForm->Selected->MoveTo(tvForm->Items->GetFirstNode(), naAdd);
      ((POINTSDIV*)tvForm->Selected->Data)->editing = 1;
         EditRec=true;
      return;
   }
    Screen->Cursor=crHourGlass;
    if(Node)
      Node->Expand(false);

    PTreeTable=new POINTSDIV;
    memcpy(PTreeTable,(POINTSDIV*)SelectedNode->Data,sizeof(POINTSDIV));
    Node = tvForm->Items->AddChildObject(Node,PTreeTable->Name,PTreeTable);
    if(PTreeTable->CodeTamplate){
      PTreeTable->GroupList=new TList;
      Node->ImageIndex=19;
      Node->SelectedIndex=19;
    }else{
      PTreeTable->StepProfile=0;
      PTreeTable->GroupList=NULL;
      strcpy(PTreeTable->EnableControls,AnsiString::StringOfChar('0',sizeof(PTreeTable->EnableControls)-1).c_str());
      Node->ImageIndex=4;
      Node->SelectedIndex=4;
    }
    PTreeTable->Id=0;
    PTreeTable->tmpId=0;
    PTreeTable->editing=1;
      EditRec=true;
    Screen->Cursor=crDefault;
    tvForm->OnChange=tvFormChange;
    tvForm->Selected=Node;
  }catch (Exception &exception){
    Screen->Cursor=crDefault;
  	Application->ShowException(&exception);
  }
}
//---------------------------------------------------------------------------

void __fastcall TFormEditFormList::SetAccess(TAccess value)
{
   if(FAccess != value) {
      TMainForm::SetAccess(value);
      bool wr = value==accWrite;
      iaDelete->Enabled = wr;
      aRight->Enabled = wr;
      aLoadFile->Enabled = wr;
      paAll->Enabled = wr;
   }
}
//---------------------------------------------------------------------------

bool __fastcall TFormEditFormList::ReadNode(TTreeView* tv,TTreeNode* NodeParent)// Читает ветку дерева форм или шаблонов
{
 
    POINTSDIV *PTreeTable;
    TTreeNode *AddNode;
    TTreeNode *tn;
    AUXDIV *GidTable;
    try{

           dmMain->oqCursor->Params->Clear();
           dmMain->oqCursor->SQL->Text="begin "+SchemeName+"interior_pg.EditFormList_ReadNode1_p(:par1,:par2,:par3,:par4,:par5);end;";
           dmMain->oqCursor->ParamByName("par5")->DataType=ftCursor;
           dmMain->oqCursor->ParamByName("par5")->ParamType=ptOutput;

           dmMain->oqCursor->ParamByName("par1")->AsInteger=(NodeParent)?1:0;
           dmMain->oqCursor->ParamByName("par2")->AsInteger=(tv==tvForm)?1:0;
           if(NodeParent)
           dmMain->oqCursor->ParamByName("par3")->AsInteger=((POINTSDIV*)NodeParent->Data)->Id;
           else
           dmMain->oqCursor->ParamByName("par3")->Clear();
           dmMain->oqCursor->ParamByName("par4")->AsInteger=CurrentSchema;
           dmMain->oqCursor->Execute();
           while(!dmMain->oqCursor->Eof){
           PTreeTable=new POINTSDIV;
           ZeroMemory(PTreeTable,sizeof(POINTSDIV));
            PTreeTable->editing=dmMain->oqCursor->FieldByName("HaveChild")->AsInteger;
           PTreeTable->Id=dmMain->oqCursor->FieldByName("fid")->AsInteger;
           PTreeTable->CodeTamplate=dmMain->oqCursor->FieldByName("codetemplate")->AsInteger;
           if(!dmMain->oqCursor->FieldByName("nameform")->IsNull)
           strcpy(PTreeTable->Name,dmMain->oqCursor->FieldByName("nameform")->AsString.c_str());
           if(!dmMain->oqCursor->FieldByName("commentform")->IsNull)
           strcpy(PTreeTable->Comment,dmMain->oqCursor->FieldByName("commentform")->AsString.c_str());
           if(!dmMain->oqCursor->FieldByName("enablecontrols")->IsNull)
           strcpy(PTreeTable->EnableControls,dmMain->oqCursor->FieldByName("enablecontrols")->AsString.c_str());
           PTreeTable->StepProfile=dmMain->oqCursor->FieldByName("stepprofile")->AsInteger;
           if(!dmMain->oqCursor->FieldByName("namealert")->IsNull)
           strcpy(PTreeTable->NameAlert,dmMain->oqCursor->FieldByName("namealert")->AsString.c_str());
           if(!dmMain->oqCursor->FieldByName("vprocname")->IsNull)
           strcpy(PTreeTable->pLProc,dmMain->oqCursor->FieldByName("vprocname")->AsString.c_str());
/* vpr, 05.08.2016, below was performed two replacements  'nameform' by  'nameform_1'
           Here is a code how to get fields names in the oqCursor : TStringList *strs = new TStringList;dmMain->oqCursor->Fields->GetFieldNames(strs);char*ppp=strs->GetText(); */
           if(!dmMain->oqCursor->FieldByName("nameform_1")->IsNull)
           strcpy(PTreeTable->TemplName,dmMain->oqCursor->FieldByName("nameform_1")->AsString.c_str());
/* vpr, 05.08.2016, end of insertion*/
           if(!dmMain->oqCursor->FieldByName("enablecontrols")->IsNull)
           strcpy(PTreeTable->NewEnableControls,dmMain->oqCursor->FieldByName("enablecontrols")->AsString.c_str());
           PTreeTable->Mid=dmMain->oqCursor->FieldByName("mid")->AsInteger;
           if(!dmMain->oqCursor->FieldByName("midname")->IsNull)
           strcpy(PTreeTable->MidName,dmMain->oqCursor->FieldByName("midname")->AsString.c_str());

            //Латка для птичек "выбор точек" и "перечень отображаемых данных"
                if(tv!=tvForm){
                        PTreeTable->EnableControls[6]='0'; PTreeTable->EnableControls[7]='0';}
           //Окончание латки для птичек "выбор точек" и "перечень отображаемых данных"

                AddNode = tv->Items->AddChildObject(NodeParent,PTreeTable->Name,PTreeTable);
                if(PTreeTable->CodeTamplate){
                    if(tv==tvForm){
                        AddNode->ImageIndex=19;
                        AddNode->SelectedIndex=19;
                        PTreeTable->GroupList=new TList();
                    }else{
                        AddNode->ImageIndex=18;
                        AddNode->SelectedIndex=18;
                    }
                }else{
                    AddNode->ImageIndex=4;
                    AddNode->SelectedIndex=4;
                }
                if(PTreeTable->editing){
                    tv->Items->AddChildObject(AddNode,"",(void*)0);
                    PTreeTable->editing=0;
                }
                PTreeTable->tmpId=PTreeTable->Id;

             dmMain->oqCursor->Next();
        }
        // Вычитка групп
        if(tv==tvForm && NodeParent){
           dmMain->oqCursor->Params->Clear();
           dmMain->oqCursor->SQL->Text="begin "+SchemeName+"interior_pg.EditFormList_ReadNode2_p(:par1,:par2);end;";
           dmMain->oqCursor->ParamByName("par2")->DataType=ftCursor;
           dmMain->oqCursor->ParamByName("par2")->ParamType=ptOutput;

           dmMain->oqCursor->ParamByName("par1")->AsInteger=((POINTSDIV*)NodeParent->Data)->Id;

            AddNode = NodeParent->getFirstChild();
            if(!AddNode || AddNode->Parent!=NodeParent)
                throw Exception(Reconst_smes21_19);
            PTreeTable = (POINTSDIV*)AddNode->Data;
            dmMain->oqCursor->Execute();
            while(!dmMain->oqCursor->Eof){
            GidTable=new AUXDIV;
            ZeroMemory(GidTable,sizeof(AUXDIV));
              GidTable->Id=dmMain->oqCursor->FieldByName("gid")->AsInteger;
                 GidTable->editing =dmMain->oqCursor->FieldByName("fid")->AsInteger;
                   while(PTreeTable->Id != GidTable->editing)
                    {
                        if(PTreeTable->GroupList)
                            PTreeTable->GroupList->Capacity = PTreeTable->GroupList->Count;
                        AddNode = NodeParent->GetNextChild(AddNode);
                        if(!AddNode || AddNode->Parent!=NodeParent)
                            throw Exception(Reconst_smes21_20);
                        PTreeTable = (POINTSDIV*)AddNode->Data;
                    }
                    // Добавление группы в список
                    tn=tvGroup->Items->Item[0];
                    while(tn){
                        if(((AUXDIV*)tn->Data)->Id==GidTable->Id)
                            PTreeTable->GroupList->Add(tn);
                        tn=tn->GetNext();
                    }
              dmMain->oqCursor->Next();
              }

            if(!PTreeTable->GroupList)
                PTreeTable->GroupList = new TList;
            PTreeTable->GroupList->Capacity = PTreeTable->GroupList->Count;
        }
    }catch (Exception &exception){

  	    Application->ShowException(&exception);
        return false;
    }

    return true;
}
//---------------------------------------------------------------------------

void __fastcall TFormEditFormList::vClone(TObject *Sender)
{
    AnsiString sql = "begin "+SchemeName+"editforms_pg.copyschema_p(:par1, :par2, :par3, :par4); end;";
    long id1, id2, groupCopy, fileCopy;

    TFormCopyShcema*fcp = new TFormCopyShcema(this);
    fcp->cbSchemaName->Items->Assign(cbSchema->Items);
    fcp->cbSchemaName->Items->Delete(cbSchema->ItemIndex);
    fcp->cbSchemaName->ItemIndex = 0;
    fcp->cbFileCopy->Checked = false;
    if(fcp->ShowModal()==mrOk)
    {
        //GRB ADD 16.04.2020 - test trouble ODAC
        dmMain->quMain->Params->Clear();
        //END ADD 
        // Дублирование перечня форм
        dmMain->quMain->SQL->Text=sql;
        id1 = (long)cbSchema->Items->Objects[cbSchema->ItemIndex];
        id2 = (long)fcp->cbSchemaName->Items->Objects[fcp->cbSchemaName->ItemIndex];
        groupCopy = fcp->cbGroupCopy->Checked?1:0;
        // Так как штатным копирование файла ограничения в размере 32 кБ,
        // то мы копировать будем вручную (см. код ниже -> Копирование привязанных файлов)
        fileCopy = 0;
        dmMain->quMain->ParamByName("par1")->AsInteger=id1;
        dmMain->quMain->ParamByName("par2")->AsInteger=id2;
        dmMain->quMain->ParamByName("par3")->AsInteger=groupCopy;
        dmMain->quMain->ParamByName("par4")->AsInteger=fileCopy;
        dmMain->quMain->Execute();

        // ====================================================================
        // Копирование привязанных файлов
        if(fcp->cbFileCopy->Checked)
        try
        {
           typedef struct {
                long fid_src, fid_dst;
            } FIDS;
         
            FIDS *pFid;
            TList *listIds = new TList();
            // Вычитка информации какие файлы куда копировать
       
                dmMain->oqCursor->Params->Clear();
                dmMain->oqCursor->SQL->Text="begin "+SchemeName+"interior_pg.EditFormList_vClone_p(:par1,:par2,:par3);end;";
                dmMain->oqCursor->ParamByName("par3")->DataType=ftCursor;
                dmMain->oqCursor->ParamByName("par3")->ParamType=ptOutput;

                dmMain->oqCursor->ParamByName("par1")->AsInteger=id1;
                dmMain->oqCursor->ParamByName("par2")->AsInteger=id2;
                dmMain->oqCursor->Execute();
                while(!dmMain->oqCursor->Eof){
                pFid = new FIDS;
                ZeroMemory(pFid,sizeof(FIDS));
                pFid->fid_src = dmMain->oqCursor->FieldByName("fd1")->AsInteger;
                pFid->fid_dst = dmMain->oqCursor->FieldByName("fd2")->AsInteger;
                listIds->Add(pFid);
                dmMain->oqCursor->Next();

            }
            // Копирование файлов
            char *fileBody;
            for(int i=0; i<listIds->Count; i++)
                WriteFile_Ex_to_DB(((FIDS*)listIds->Items[i])->fid_dst,
                    Control_Exist_File(((FIDS*)listIds->Items[i])->fid_src),
                    true);
            for(int i=0; i<listIds->Count; i++) delete listIds->Items[i];
            delete listIds;
        }catch(Exception&e){
            Application->ShowException(&e);
        }
        // Копирование привязанных файлов (Конец)
        // ====================================================================
       
    }
    delete fcp;
}
//---------------------------------------------------------------------------

void __fastcall TFormEditFormList::aMExecute(TObject *Sender)
{
   TAction*pa = dynamic_cast<TAction*>(Sender);
   TTreeNode*ptn;
   if(pa){
      ptn = tvForm->Selected;
      switch(pa->Tag){
      case 1:// Alt+Left
         if(ptn->Expanded)
            ptn->Collapse(false);
         else if(ptn->Parent)
            tvForm->Selected = ptn->Parent;
         break;
      case 2:// Alt+Right
         if(!ptn->Expanded)
            ptn->Expand(false);
         else if(ptn->HasChildren)
            tvForm->Selected = ptn->getFirstChild();
         break;
      case 3:// Alt+Up
         ptn = tvForm->Selected->GetPrevVisible();
         if(ptn) tvForm->Selected = ptn;
         break;
      case 4:// Alt+Down
         ptn = tvForm->Selected->GetNextVisible();
         if(ptn) tvForm->Selected = ptn;
         break;
      }
   }
}
//---------------------------------------------------------------------------

void __fastcall TFormEditFormList::FormCreate(TObject *Sender)
{
   eProf[0].cb=cb1;
   eProf[0].rb=rb1;
   eProf[1].cb=cb2;
   eProf[1].rb=rb2;
   eProf[2].cb=cb3;
   eProf[2].rb=rb3;
   eProf[3].cb=cb4;
   eProf[3].rb=rb4;

   if(GetShemas()&&GetGroups()&&ReadNode(tvForm,NULL)&&ReadNode(tvTemp,NULL)){
      if(tvTemp->Items->Count){
         tvTemp->Selected=tvTemp->Items->Item[0];
      }
      if(tvGroup->Items->Count){
         tvGroup->Selected=tvGroup->Items->Item[0];
      }
      if(tvForm->Items->Count){
         tvForm->OnChange=tvFormChange;
         tvForm->Selected=tvForm->Items->Item[0];
      }
      tvGroup->OnChange=tvGroupChange;
      cbSchema->OnChange=cbSchemaChange;
      Width=Width-1;
      Height=Height-1;
   }else{
      Close();
   }
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFormList::btnMainSelectClick(TObject *Sender)
{
  TTreeNode* sNode=tvForm->Selected;
  if(!sNode||!sNode->Data)
    return;

  bool isedit=false;
  GROUPDATAFORM gdf;
  TfmSelectPoint*sp=NULL;
  POINTSDIV* p=(POINTSDIV*)sNode->Data;
  if(cbCheckPoints->Checked){
    gdf.gid = p->Mid;
    gdf.type = 3;
    sp = new TfmSelectPoint(this, &gdf);
    sp->HelpContext=25034;
    sp->Caption = Reconst_smes21_21;
    if(sp->ShowModal()==mrOk){
      isedit=true;
      p->Mid=gdf.gid;
      if(gdf.gid){//Не псевдоточка
        eDuplPoint->Text=gdf.Name;
      }else{
        eDuplPoint->Text="";
      }
    }
    delete sp;
  }else{
    isedit=true;
    p->Mid=0;
    eDuplPoint->Text="";
  }
  if(isedit){
    strcpy(p->MidName,eDuplPoint->Text.c_str());
    if(!p->editing)
      p->editing=1;
    EditRec=true;
  }
  btnMainSelect->Enabled=cbCheckPoints->Checked;
  eDuplPoint->Enabled=cbCheckPoints->Checked;
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFormList::eDuplPointDblClick(TObject *Sender)
{
  if(cbCheckPoints->Checked){
    btnMainSelectClick(this);
  }
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFormList::eDuplPointKeyDown(TObject *Sender,
      WORD &Key, TShiftState Shift)
{
  if(Key==32||Key==13)
    eDuplPointDblClick(this);
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFormList::btParamClick(TObject *Sender)
{
  TTreeNode *sNode=tvForm->Selected;
  if(!sNode||!sNode->Data)
    return;
  if(!((POINTSDIV*)sNode->Data)->Id)
    throw Exception(Reconst_smes21_22);
  TfmSpecParam::fmSpecParamShow(this,((POINTSDIV*)sNode->Data)->Id,1,2);
}
//---------------------------------------------------------------------------

