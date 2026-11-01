//---------------------------------------------------------------------------
#include <vcl.h>
#include <stdio.h>
#pragma hdrstop
#include "EditTimeMaxLoad.h"
#define MAXCOUNTHOURS  10000

#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
//---------------------------------------------------------------------------

__fastcall TFormEditTimeMaxLoad::TFormEditTimeMaxLoad(TComponent* Owner, AnsiString Name, TAccess a)
	: TMainForm(Owner, Name, a)
{
}
//---------------------------------------------------------------------------

void __fastcall TFormEditTimeMaxLoad::FormShow(TObject *Sender)
{
  if(ReadData()){
    if(TreeView1->Items->Count){
      TreeView1->OnChange=TreeView1Change;
      TreeView1->Selected=TreeView1->Items->Item[0];
      TreeView1->OnChanging=TreeView1Changing;
    }
    Width=Width-1;
    Height=Height-1;
    TreeView1->SetFocus();
  }else{
   Close();
  }
}
//---------------------------------------------------------------------------

bool __fastcall TFormEditTimeMaxLoad::ReadData(void)// Читает данные
{
  POINTSDIV *PTreeTable;
  TTreeNode *AddNode=NULL;

  try{
      dmMain->oqCursor->Params->Clear();
      dmMain->oqCursor->SQL->Text="begin "+SchemeName+"maxhours_pg.read_data_p(:par1);end;";
      dmMain->oqCursor->ParamByName("par1")->DataType=ftCursor;
      dmMain->oqCursor->ParamByName("par1")->ParamType=ptOutput;
      dmMain->oqCursor->Execute();

      while(!dmMain->oqCursor->Eof){
        PTreeTable=new POINTSDIV;
        ZeroMemory(PTreeTable,sizeof(POINTSDIV));
      PTreeTable->Mid=dmMain->oqCursor->FieldByName("MAXHOUR_ID")->AsInteger;
      strcpy(PTreeTable->Date_Time,dmMain->oqCursor->FieldByName("dt")->AsString.c_str());
      strcpy(PTreeTable->Morning_Start,dmMain->oqCursor->FieldByName("MS")->AsString.c_str());
      strcpy(PTreeTable->Morning_End,dmMain->oqCursor->FieldByName("ME")->AsString.c_str());
      strcpy(PTreeTable->Evening_Start,dmMain->oqCursor->FieldByName("ES")->AsString.c_str());
      strcpy(PTreeTable->Evening_End,dmMain->oqCursor->FieldByName("EE")->AsString.c_str());
      AddNode = TreeView1->Items->AddObject(AddNode,PTreeTable->Date_Time,PTreeTable);
      PTreeTable->tmpMid=PTreeTable->Mid;
      dmMain->oqCursor->Next();
      }
   }catch (Exception &exception){
  	Application->ShowException(&exception);
    return false;
  }

  return true;
}
//---------------------------------------------------------------------------

void __fastcall TFormEditTimeMaxLoad::TreeView1Changing(TObject *Sender,
      TTreeNode *Node, bool &AllowChange)
{
  TTreeNode *sNode=TreeView1->Selected;
  if(!sNode||!sNode->Data||((POINTSDIV*)sNode->Data)->editing!=2)
    return;
  POINTSDIV *PTreeTable=(POINTSDIV*)sNode->Data;
  TWinControl *Control=NULL;
  try{
    Control=(TWinControl *)meStart;
    if(meStart->Text=="  .  .    ")
      throw Exception(Reconst_smes28_1);
    try{
      StrToDate(meStart->Text);
    }catch(Exception &e){
      throw Exception(Reconst_smes28_2+meStart->Text+Reconst_smes28_3);
    }
    strcpy(PTreeTable->Date_Time,meStart->Text.c_str());
    Control=(TWinControl *)meMStart;
    if(meMStart->Text=="  :  ")
      throw Exception(Reconst_smes28_4);
    strcpy(PTreeTable->Morning_Start,meMStart->Text.c_str());
    Control=(TWinControl *)meMEnd;
    if(meMEnd->Text=="  :  ")
      throw Exception(Reconst_smes28_5);
    strcpy(PTreeTable->Morning_End,meMEnd->Text.c_str());
    Control=(TWinControl *)meEStart;
    if(meEStart->Text=="  :  ")
      throw Exception(Reconst_smes28_6);
    strcpy(PTreeTable->Evening_Start,meEStart->Text.c_str());
    Control=(TWinControl *)meEEnd;
    if(meEEnd->Text=="  :  ")
      throw Exception(Reconst_smes28_7);
    strcpy(PTreeTable->Evening_End,meEEnd->Text.c_str());
    PTreeTable->editing=1;
  }catch (Exception &exception){
    AllowChange=false;
	  Application->ShowException(&exception);
    if(Control)
      Control->SetFocus();
  }
}
//---------------------------------------------------------------------------

void __fastcall TFormEditTimeMaxLoad::TreeView1Change(TObject *Sender,
      TTreeNode *Node)
{
  TMaskEdit *ed;
  POINTSDIV *PTreeTable=NULL;
  if(Access==accWrite) paEdit->Enabled=Node;
  iaDelete->Enabled=Node;
  if(Node)
    PTreeTable=(POINTSDIV*)Node->Data;
  for(int i=0;i<ComponentCount;i++){
    ed=dynamic_cast<TMaskEdit *>(Components[i]);
    if(ed){
      ed->OnChange=NULL;
      ed->Text="";
      continue;
    }
  }
  if(!PTreeTable)
    return;
  meStart->Text=PTreeTable->Date_Time;
  meMStart->Text=PTreeTable->Morning_Start;
  meMEnd->Text=PTreeTable->Morning_End;
  meEStart->Text=PTreeTable->Evening_Start;
  meEEnd->Text=PTreeTable->Evening_End;

  for(int i=0;i<ComponentCount;i++){
    ed=dynamic_cast<TMaskEdit *>(Components[i]);
    if(ed){
      ed->OnChange=meChange;
      continue;
    }
  }
}
//---------------------------------------------------------------------------

void __fastcall TFormEditTimeMaxLoad::meChange(TObject *Sender)
{
  TTreeNode *sNode=TreeView1->Selected;
  if(!sNode||!sNode->Data)
    return;
  if(((POINTSDIV*)sNode->Data)->editing!=2)
    ((POINTSDIV*)sNode->Data)->editing=2;
  if((TMaskEdit*)Sender==meStart)
    sNode->Text=meStart->Text;
    EditRec=true;
}
//---------------------------------------------------------------------------

void __fastcall TFormEditTimeMaxLoad::TreeView1Deletion(TObject *Sender,
      TTreeNode *Node)
{
  if(Node&&Node->Data){
    if(realdeletion&&((POINTSDIV*)Node->Data)->Mid)
      nPoints_Del[CountPoints_Del++]=((POINTSDIV*)Node->Data)->Mid;
    delete (POINTSDIV*)Node->Data;
  }
}
//---------------------------------------------------------------------------

void __fastcall TFormEditTimeMaxLoad::vNew(TObject *Sender)
{
  TTreeNode *sNode;
  POINTSDIV *PTreeTable;
  bool AllowChange=true;
  TreeView1Changing(TreeView1,TreeView1->Selected,AllowChange);
  if(!AllowChange)
    return;
  PTreeTable=new POINTSDIV;
  ZeroMemory(PTreeTable, sizeof(POINTSDIV));
  strcpy(PTreeTable->Date_Time,TDateTime().CurrentDate().DateString().c_str());
  PTreeTable->editing=2;
  sNode=TreeView1->Items->InsertObject((TreeView1->Items->Count)?TreeView1->Items->Item[0]:NULL,PTreeTable->Date_Time,PTreeTable);
   EditRec=true;
  TreeView1->OnChange=TreeView1Change;
  TreeView1->OnChanging=TreeView1Changing;
  TreeView1->Selected=sNode;
  meStart->SetFocus();
}
//---------------------------------------------------------------------------

void __fastcall TFormEditTimeMaxLoad::vDelete(TObject *Sender)
{
   if(!iaDelete->Enabled)
    return;
  TTreeNode *sNode=TreeView1->Selected;
  TTreeView *tv=NULL;
  if(sNode&&MessageBox(Handle,AnsiString(Reconst_smes28_8+sNode->Text+">?").c_str(),Application->Title.c_str(),MB_YESNO|MB_ICONQUESTION|MB_DEFBUTTON2)==IDYES){
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
  TreeView1->SetFocus();
}
//---------------------------------------------------------------------------

void __fastcall TFormEditTimeMaxLoad::vRefresh(TObject *Sender)
{
  TreeView1->OnChange=NULL;
  TreeView1->OnChanging=NULL;
  Screen->Cursor=crHourGlass;
  TreeView1->Visible=false;
  TreeView1->Items->Clear();
  Screen->Cursor=crDefault;
  if(ReadData()){
    if(TreeView1->Items->Count){
      TreeView1->OnChange=TreeView1Change;
      TreeView1->Selected=TreeView1->Items->Item[0];
      TreeView1->OnChanging=TreeView1Changing;
    }
  }else{
    TreeView1Change(TreeView1,NULL);
  }
  TreeView1->Visible=true;
  EditRec=false;
  TreeView1->SetFocus();
}
//---------------------------------------------------------------------------

void __fastcall TFormEditTimeMaxLoad::vSave(TObject *Sender)
{
  bool b=true;
  TreeView1Changing(TreeView1,TreeView1->Selected,b);
  if(!b)
    return;
  TTreeNode *Node=NULL;
  POINTSDIV PTreeTable;
  long ltmp=0;
  try{
    //GRB ADD 16.04.2020 - test trouble ODAC
    dmMain->quMain->Params->Clear();
    //END ADD 
    dmMain->quMain->SQL->Text="begin \
                  if :par1>0 then \
                    "+SchemeName+"maxhours_pg.upd_p(:par1,to_date(:par2,'dd.mm.yyyy'),to_date('01012000'||:par3,'DDMMYYYYHH24:MI'),to_date('01012000'||:par4,'DDMMYYYYHH24:MI'),to_date('01012000'||:par5,'DDMMYYYYHH24:MI'),to_date('01012000'||:par6,'DDMMYYYYHH24:MI')); \
                  else \
                    "+SchemeName+"maxhours_pg.ins_p(to_date(:par2,'dd.mm.yyyy'),to_date('01012000'||:par3,'DDMMYYYYHH24:MI'),to_date('01012000'||:par4,'DDMMYYYYHH24:MI'),to_date('01012000'||:par5,'DDMMYYYYHH24:MI'),to_date('01012000'||:par6,'DDMMYYYYHH24:MI'),:par1); \
                  end if; \
                end;";

    Node=TreeView1->Items->GetFirstNode();
    while(Node){
      if(Node->Data&&((POINTSDIV*)Node->Data)->editing){
        memcpy(&PTreeTable,(POINTSDIV*)Node->Data,sizeof(POINTSDIV));

         dmMain->quMain->ParamByName("par1")->ParamType=ptInputOutput;
         dmMain->quMain->ParamByName("par1")->DataType=ftInteger;
         dmMain->quMain->ParamByName("par1")->AsInteger=PTreeTable.Mid;
         dmMain->quMain->ParamByName("par2")->AsString=PTreeTable.Date_Time;
         dmMain->quMain->ParamByName("par3")->AsString=PTreeTable.Morning_Start;
         dmMain->quMain->ParamByName("par4")->AsString=PTreeTable.Morning_End;
         dmMain->quMain->ParamByName("par5")->AsString=PTreeTable.Evening_Start;
         dmMain->quMain->ParamByName("par6")->AsString=PTreeTable.Evening_End;
         dmMain->quMain->Execute();
         PTreeTable.Mid=dmMain->quMain->ParamByName("par1")->AsInteger;
         ((POINTSDIV*)Node->Data)->tmpMid=PTreeTable.Mid;
      }
      Node=Node->GetNext();
    }
    //GRB ADD 16.04.2020 - test trouble ODAC
    dmMain->quMain->Params->Clear();
    //END ADD 
    dmMain->quMain->SQL->Text="begin "+SchemeName+"maxhours_pg.del_p(:par1); end;";
    for(int i=0;i<CountPoints_Del;i++){
      ltmp=nPoints_Del[i];
      dmMain->quMain->ParamByName("par1")->AsInteger=ltmp;
      dmMain->quMain->Execute();
      }
      dmMain->orases->Commit();
    CountPoints_Del=0;
    Node=TreeView1->Items->GetFirstNode();
    while(Node){
      if(Node->Data&&((POINTSDIV*)Node->Data)->editing){
        ((POINTSDIV*)Node->Data)->editing=0;
        ((POINTSDIV*)Node->Data)->Mid=((POINTSDIV*)Node->Data)->tmpMid;
      }
      Node=Node->GetNext();
    }
    EditRec=false;

    TreeView1->SetFocus();
  }catch (Exception &exception){
  dmMain->orases->Rollback();
 	Application->ShowException(&exception);
    if(Node)
      TreeView1->Selected=Node;
    meStart->SetFocus();
  }
}
//---------------------------------------------------------------------------

void __fastcall TFormEditTimeMaxLoad::meStartExit(TObject *Sender)
{
#define Sender ((TMaskEdit*)Sender)
  if(Sender->Text=="  .  .    ")
    return;
  Sender->OnChange=NULL;
  try{
    try{
      Sender->Text=DateToStr(StrToDate(Sender->Text));
      TreeView1->Selected->Text=Sender->Text;
    }catch(Exception &e){
      throw Exception(Reconst_smes28_9+Sender->Text+Reconst_smes28_10);
    }
  }catch(Exception &e){
    Application->ShowException(&e);
    Sender->SetFocus();
  }
  Sender->OnChange=meChange;
#undef Sender
}
//---------------------------------------------------------------------------

void __fastcall TFormEditTimeMaxLoad::meMStartExit(TObject *Sender)
{
#define Sender ((TMaskEdit*)Sender)
  if(Sender->Text=="  :  ")
    return;
  Sender->OnChange=NULL;
  try{
    try{
      Sender->Text=StrToTime(Sender->Text+":00").FormatString("hh:nn");
    }catch(Exception &e){
      throw Exception(Reconst_smes28_9+Sender->Text+Reconst_smes28_10);
    }
  }catch(Exception &e){
    Application->ShowException(&e);
    Sender->SetFocus();
  }
  Sender->OnChange=meChange;
#undef Sender
}
//---------------------------------------------------------------------------

void __fastcall TFormEditTimeMaxLoad::SetAccess(TAccess value)
{
   if(FAccess != value){
      TMainForm::SetAccess(value);
      bool wr = value==accWrite;
      iaNew->Enabled = wr;
      iaDelete->Enabled = wr;
      paEdit->Enabled = wr;
   }
}
//---------------------------------------------------------------------------

