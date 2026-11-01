//---------------------------------------------------------------------------
#include <vcl.h>
#include <stdio.h>
#pragma hdrstop
#include "unDataMod.h"
#include "FormDescr.h"
#include "SupperMain.h"
#include "Monitor.h"
#include "Saa_SelectForm.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma link "DBAccess"
#pragma link "MemDS"
#pragma link "Ora"
#pragma resource "*.dfm"
#define SAA_MAXCOUNTPOINTS 100
#define SAA_MAXCOUNTPATH  64
TfmSelectReportForm *fmSelectReportForm;
//---------------------------------------------------------------------------
int GetStepProfileInv(TFormDescr::TStepProfie i)
{
  switch(i){
    case 31: return 2;
    case 24: return 3;;
    case 60: return 4;
    default : return 1;
  }
}
//---------------------------------------------------------------------------
int GetStepProfile(int i)
{
  switch(i){
    case 2: return 31;
    case 3: return 24;;
    case 4: return 60;
    default : return 12;
  }
}
//---------------------------------------------------------------------------
__fastcall TfmSelectReportForm::TfmSelectReportForm(TComponent* Owner,long id_Fid, TFormDescr*pfd)
	: TForm(Owner), fID(id_Fid), fd(pfd)
{
}
//---------------------------------------------------------------------------
void __fastcall TfmSelectReportForm::FormCreate(TObject *Sender)
{
  bool fSel=false;
  TTreeNode * FindTreeNode;
  TTreeNode *MyTreeNode1;
  try{
    tvMain->Items->Clear();
    dmMain->oqCursor->Params->Clear();
    dmMain->oqCursor->SQL->Text="begin "+SchemeName+"saa_select_pg.SelectForm_FormCreate_p(:par1,:par2);end;";
    dmMain->oqCursor->ParamByName("par2")->DataType=ftCursor;
    dmMain->oqCursor->ParamByName("par2")->ParamType=ptOutput;
    dmMain->oqCursor->ParamByName("par1")->AsInteger = UserRol.Monitor;
    dmMain->oqCursor->Execute();
    while(!dmMain->oqCursor->Eof){
		  MyTreeNode1=tvMain->Items->AddChildObject(NULL,dmMain->oqCursor->FieldByName("VNAME")->AsString,(void*)(dmMain->oqCursor->FieldByName("FID")->AsInteger));
      if(dmMain->oqCursor->FieldByName("Lev")->AsInteger==1)
        tvMain->Items->AddChildObject(MyTreeNode1,"",(void*)0);
      bool b=false;
      if(!fSel)
	      tvMainExpanding(this,MyTreeNode1,b);
      if(dmMain->oqCursor->FieldByName("FID")->AsInteger==fID){
        fSel=true;
        FindTreeNode=MyTreeNode1;
      }
      int ii=(dmMain->oqCursor->FieldByName("CodeTemplate")->AsInteger==0)?0:1;
      MyTreeNode1->ImageIndex = ii;
	    MyTreeNode1->SelectedIndex = ii;
      dmMain->oqCursor->Next();
   	}
	  if(fSel)
 		  FindTreeNode->Selected=true;
  }catch(Exception &exception){
	  Application->MessageBox(exception.Message.c_str(),Application->Title.c_str(),MB_OK|MB_ICONSTOP);
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmSelectReportForm::FormShow(TObject *Sender)
{
 tvMain->Focused();
}
//---------------------------------------------------------------------------
void __fastcall TfmSelectReportForm::btNextClick(TObject *Sender)
{
  TTreeNode *Node;
  try{
      // VTR
    hCursor=::SetCursor(LoadCursor(NULL,IDC_WAIT));
    Node = tvMain->Selected;
    if((Node!=NULL)&&(Node->AbsoluteIndex > -1)&&(Node->ImageIndex==1)){
      char EnableControls[20]={0};
    
    dmMain->oqCursor->Params->Clear();
    dmMain->oqCursor->SQL->Text="begin "+SchemeName+"saa_select_pg.SelectForm_btNextClick_p(:par1,:par2);end;";
    dmMain->oqCursor->ParamByName("par2")->DataType=ftCursor;
    dmMain->oqCursor->ParamByName("par2")->ParamType=ptOutput;
      dmMain->oqCursor->ParamByName("par1")->AsInteger=(long)(Node->Data);
      dmMain->oqCursor->Execute();
      strcpy(EnableControls,dmMain->oqCursor->FieldByName("EnableControls")->AsString.c_str());
      if(dmMain->oqCursor->Eof){
        Node->Delete();
        return;
      }
//Зачищаем (чтоб else не писать)
      fd->VerticalSplit=false;
      fd->EnableControls.Clear();
      fd->indbird=false;
      fd->IdFormTree =(long)(Node->Data);
      fd->StepProfile = (TFormDescr::EStepProfile)GetStepProfile(dmMain->oqCursor->FieldByName("StepProfile")->AsInteger);
      fd->NameForm = Node->Text;
      fd->CodeTemplate = dmMain->oqCursor->FieldByName("CodeTemplate")->AsInteger;
      if(EnableControls[0]=='1')
        fd->EnableControls<<TFormDescr::ctrlGroup;
      if(EnableControls[1]=='1')
        fd->EnableControls<<TFormDescr::ctrlMonth;
      if(EnableControls[2]=='1')
        fd->EnableControls<<TFormDescr::ctrlDay;
      if(EnableControls[3]=='1')
        fd->EnableControls<<TFormDescr::ctrlHour;
      if(EnableControls[4]=='1')
        fd->EnableControls<<TFormDescr::ctrlMinute;
      if(EnableControls[5]=='1')
        fd->EnableControls<<TFormDescr::ctrlCalendar;
      if(EnableControls[6]=='1')
        fd->EnableControls<<TFormDescr::ctrlPoint;
      if(EnableControls[7]=='1'){
        fd->indbird = true;
        fd->bird = 0;
        EnableControls[7]='\0';
      }
      fd->DateTime.Val = floor(fd->DateTime.Val);
      fd->DateTimePar.Val = floor(fd->DateTimePar.Val);
      if(fd->EnableControls.Contains(TFormDescr::ctrlHour)){
        fd->DateTime.Val += TDateTime::CurrentTime().Val;
        fd->DateTimePar.Val += TDateTime::CurrentTime().Val;
      }

      fd->CommentForm=dmMain->oqCursor->FieldByName("CommentForm")->AsString;
      fd->NameAlert=dmMain->oqCursor->FieldByName("NameAlert")->AsString;
      strcpy( fd->pLProc, dmMain->oqCursor->FieldByName("vprocname")->AsString.c_str() );
      fd->startmid=dmMain->oqCursor->FieldByName("MID")->AsInteger;
      if(fd->DateTimePar>fd->DateTime)
        fd->DateTimePar=fd->DateTime-1;
      ModalResult = mrOk;
    }
    ::SetCursor(hCursor);
  }catch(Exception &exception){
      Application->MessageBox(exception.Message.c_str(),Application->Title.c_str(),MB_OK|MB_ICONSTOP);
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmSelectReportForm::tvMainChange(TObject *Sender, TTreeNode *Node)
{
   Label1->Caption = tvMain->Selected->Text;
}
//---------------------------------------------------------------------------
void __fastcall TfmSelectReportForm::tvMainExpanding(TObject *Sender, TTreeNode *Node,
	bool &AllowExpansion)
{
  TTreeNode *MyTreeNode1;
  TTreeNode * FindTreeNode;
  MyTreeNode1=Node->getFirstChild();
  bool fSel=false;
  if((MyTreeNode1==NULL)||((long)MyTreeNode1->Data==0)){
	  Node->DeleteChildren();
  }else{
    return;
  }

  quMain1->Params->Clear();
  quMain1->SQL->Text="begin "+SchemeName+"saa_select_pg.SelectForm_tvMainExp_p(:par1,:par2,:par3);end;";
  quMain1->ParamByName("par3")->DataType=ftCursor;
  quMain1->ParamByName("par3")->ParamType=ptOutput;

  quMain1->ParamByName("par1")->AsInteger = UserRol.Monitor;
  quMain1->ParamByName("par2")->AsInteger=(long)Node->Data;
  quMain1->Execute();
  while(!quMain1->Eof){
    MyTreeNode1=tvMain->Items->AddChildObject(Node,quMain1->FieldByName("VNAME")->AsString,(void*)(quMain1->FieldByName("FID")->AsInteger));
		if (quMain1->FieldByName("Lev")->AsInteger==1)
		  tvMain->Items->AddChildObject(MyTreeNode1,"",(void*)0);
    if(quMain1->FieldByName("FID")->AsInteger==fID){
    	fSel=true;
      FindTreeNode=MyTreeNode1;
    }
    int ii=(quMain1->FieldByName("CodeTemplate")->AsInteger==0)?0:1;
	  MyTreeNode1->ImageIndex = ii;
  	MyTreeNode1->SelectedIndex = ii;
    quMain1->Next();
  }
  quMain1->First();
  if(quMain1->Eof){
  	AllowExpansion=false;
	  return;
  }
  if(fSel)
    FindTreeNode->Selected=true;
}
//---------------------------------------------------------------------------

int __fastcall TfmSelectReportForm::AddPoints(TTreeView*tv, TTreeNode*tn, int ind1, int ind2, int lmid)
{ //если ind1==1-Saa_SelectGroup, ==2-Saa_SelectGroupProc

  try{
    TTreeNode *tmp;
     dmMain->oqCursor->Params->Clear();
    dmMain->oqCursor->SQL->Text="begin "+SchemeName+"saa_select_pg.SelectForm_AddPoints_p(:par1,:par2,:par3,:par4);end;";
    dmMain->oqCursor->ParamByName("par4")->DataType=ftCursor;
    dmMain->oqCursor->ParamByName("par4")->ParamType=ptOutput;
    dmMain->oqCursor->ParamByName("par1")->AsInteger= lmid;
    if(tn==NULL)
    dmMain->oqCursor->ParamByName("par2")->Clear();
    else
    dmMain->oqCursor->ParamByName("par2")->AsInteger= -(long)tn->Data;
    dmMain->oqCursor->ParamByName("par3")->AsInteger= (tn==NULL)?0:1;

    if((tn==NULL)&&(!lmid))
    {
         tn = tv->Items->AddChildObject(tn,Reconst_smes54_1,(void*)0);
          tn->ImageIndex = 3;
          tn->SelectedIndex = 3;
    }

    dmMain->oqCursor->Execute();
    while(!dmMain->oqCursor->Eof){
      tmp = tv->Items->AddChildObject(tn,dmMain->oqCursor->FieldByName("VNAME")->AsString,(void*)-dmMain->oqCursor->FieldByName("Mid")->AsInteger);
      if(dmMain->oqCursor->FieldByName("PP")->AsInteger==1)
        tv->Items->AddChild(tmp, "");
    if(ind1==1)
     {
       switch(dmMain->oqCursor->FieldByName("T")->AsInteger)
       {
         case 0: tmp->ImageIndex =3;
                 tmp->SelectedIndex = 3;
                 break;
         case 1: tmp->ImageIndex =2;
                 tmp->SelectedIndex = 2;
                 break;
         case 5: tmp->ImageIndex =5;
                 tmp->SelectedIndex = 5;
                 break;
         case 6: tmp->ImageIndex =6;
                 tmp->SelectedIndex = 6;
                 break;
         case 7: tmp->ImageIndex =8;
                 tmp->SelectedIndex = 8;
                 break;
         case 8: tmp->ImageIndex =7;
                 tmp->SelectedIndex = 7;
                 break;
         case 9: tmp->ImageIndex =9;
                 tmp->SelectedIndex = 9;
                 break;
       }

    }

    if(ind1==2)
     {
       switch(dmMain->oqCursor->FieldByName("T")->AsInteger)
       {
         case 0: tmp->ImageIndex =3;
                 tmp->SelectedIndex = 3;
                 break;
         case 1: tmp->ImageIndex =2;
                 tmp->SelectedIndex = 2;
                 break;
         case 5: tmp->ImageIndex =25;
                 tmp->SelectedIndex = 25;
                 break;
         case 6: tmp->ImageIndex =26;
                 tmp->SelectedIndex = 26;
                 break;
         case 7: tmp->ImageIndex =22;
                 tmp->SelectedIndex = 22;
                 break;
         case 8: tmp->ImageIndex =27;
                 tmp->SelectedIndex = 27;
                 break;
       }

    }
    /*  tmp->ImageIndex = (dmMain->oqCursor->FieldByName("T")->AsInteger==-1)?ind2:ind1;
      tmp->SelectedIndex = (dmMain->oqCursor->FieldByName("T")->AsInteger==-1)?ind2:ind1; */
      dmMain->oqCursor->Next();
    }
  }catch(Exception&e){
    throw e;
  }
  return 0;
}
//---------------------------------------------------------------------------
bool __fastcall TfmSelectReportForm::GetSelectedTree(TTreeView*tv,TFormDescr*fd)
{
  long id_path[SAA_MAXCOUNTPATH];

  if(tv->Items->Count==0)
    return false;

  dmMain->oqCursor->Params->Clear();
  dmMain->oqCursor->SQL->Text="begin "+SchemeName+"saa_select_pg.SelectForm_GetSelectedTree_p(:par1,:par2,:par3,:par4);end;";
  dmMain->oqCursor->ParamByName("par4")->DataType=ftCursor;
  dmMain->oqCursor->ParamByName("par4")->ParamType=ptOutput;
  dmMain->oqCursor->ParamByName("par1")->AsInteger=fd->CodeTemplate;
  dmMain->oqCursor->ParamByName("par2")->AsInteger=(fd->IsPoints)?1:0;
  //GRB TEST 26.10.2020
  //dmMain->oqCursor->ParamByName("par2")->AsInteger=0;
  //END TEST
  dmMain->oqCursor->ParamByName("par3")->AsInteger=fd->IdGroup;
  dmMain->oqCursor->Execute();
  long CountStr=0;
  while (!dmMain->oqCursor->Eof&& CountStr<SAA_MAXCOUNTPATH){
    id_path[CountStr]=dmMain->oqCursor->FieldByName("id")->AsInteger;
    dmMain->oqCursor->Next();
    CountStr++;
  }
  if(CountStr<=0){
	  return false;
  }else{
	  if((fd->CodeTemplate==1000)||(fd->CodeTemplate==1100)||((fd->startmid==0)&&(fd->IsPoints)&&
         ((fd->CodeTemplate==1200)||(fd->CodeTemplate==1201)||(fd->CodeTemplate==1202)||(fd->CodeTemplate==1203)||(fd->CodeTemplate==1306))))
    id_path[CountStr++]=0;
    long temp_id_Node,i,k;
   	TTreeNode *Node,*Node1;
	  Node = tv->Items->GetFirstNode();
   	for(i=CountStr-1;i>=0;--i){
	    temp_id_Node=id_path[i];
      k=0;
   		while(Node!=NULL){
	   	  if(k==0){
          Node1=Node;
          k++;
        }
		   	long j=(fd->IsPoints?-1:1)*(long)Node->Data;
			  if(j==temp_id_Node){
				  if(i>0){
					  Node->Expand(false);
   					Node=Node->getFirstChild();
	   			}
		   		break;
        }else{
				  Node=Node->getNextSibling();
   			}
	   		if(Node==NULL){
          Node=Node1;
          break;
        }
      }
    }
	  if(Node!=NULL){
		  Node->Selected=true;
    }else{
	    return false;
    }
  }
  return true;
}
//16.04.2021 GRB ADD
//---------------------------------------------------------------------------
bool __fastcall TfmSelectReportForm::GetSelectedTreeG(TTreeView*tv,TFormDescr*fd)
{
  long id_path[SAA_MAXCOUNTPATH];

  if(tv->Items->Count==0)
    return false;

  dmMain->oqCursor->Params->Clear();
  dmMain->oqCursor->SQL->Text="begin "+SchemeName+"saa_select_pg.SelectForm_GetSelectedTree_p(:par1,:par2,:par3,:par4);end;";
  dmMain->oqCursor->ParamByName("par4")->DataType=ftCursor;
  dmMain->oqCursor->ParamByName("par4")->ParamType=ptOutput;
  dmMain->oqCursor->ParamByName("par1")->AsInteger=fd->CodeTemplate;
  dmMain->oqCursor->ParamByName("par2")->AsInteger=0;
  //GRB TEST 26.10.2020
  //dmMain->oqCursor->ParamByName("par2")->AsInteger=0;
  //END TEST
  dmMain->oqCursor->ParamByName("par3")->AsInteger=fd->IdGroup;
  dmMain->oqCursor->Execute();
  long CountStr=0;
  while (!dmMain->oqCursor->Eof&& CountStr<SAA_MAXCOUNTPATH){
    id_path[CountStr]=dmMain->oqCursor->FieldByName("id")->AsInteger;
    dmMain->oqCursor->Next();
    CountStr++;
  }
  if(CountStr<=0){
	  return false;
  }else{
	  if((fd->CodeTemplate==1000)||(fd->CodeTemplate==1100)||((fd->startmid==0)&&(fd->IsPoints)&&
         ((fd->CodeTemplate==1200)||(fd->CodeTemplate==1201)||(fd->CodeTemplate==1202)||(fd->CodeTemplate==1203)||(fd->CodeTemplate==1306))))
    id_path[CountStr++]=0;
    long temp_id_Node,i,k;
   	TTreeNode *Node,*Node1;
	  Node = tv->Items->GetFirstNode();
   	for(i=CountStr-1;i>=0;--i){
	    temp_id_Node=id_path[i];
      k=0;
   		while(Node!=NULL){
	   	  if(k==0){
          Node1=Node;
          k++;
        }
		   	long j=(fd->IsPoints?-1:1)*(long)Node->Data;
			  if(j==temp_id_Node){
				  if(i>0){
					  Node->Expand(false);
   					Node=Node->getFirstChild();
	   			}
		   		break;
        }else{
				  Node=Node->getNextSibling();
   			}
	   		if(Node==NULL){
          Node=Node1;
          break;
        }
      }
    }
	  if(Node!=NULL){
		  Node->Selected=true;
    }else{
	    return false;
    }
  }
  return true;
}
//---------------------------------------------------------------------------
bool __fastcall TfmSelectReportForm::GetSelectedTreeP(TTreeView*tv,TFormDescr*fd)
{
  long id_path[SAA_MAXCOUNTPATH];

  if(tv->Items->Count==0)
    return false;

  dmMain->oqCursor->Params->Clear();
  dmMain->oqCursor->SQL->Text="begin "+SchemeName+"saa_select_pg.SelectForm_GetSelectedTree_p(:par1,:par2,:par3,:par4);end;";
  dmMain->oqCursor->ParamByName("par4")->DataType=ftCursor;
  dmMain->oqCursor->ParamByName("par4")->ParamType=ptOutput;
  dmMain->oqCursor->ParamByName("par1")->AsInteger=fd->CodeTemplate;
  dmMain->oqCursor->ParamByName("par2")->AsInteger=1;
  //GRB TEST 26.10.2020
  //dmMain->oqCursor->ParamByName("par2")->AsInteger=0;
  //END TEST
  dmMain->oqCursor->ParamByName("par3")->AsInteger=fd->IdGroup;
  dmMain->oqCursor->Execute();
  long CountStr=0;
  while (!dmMain->oqCursor->Eof&& CountStr<SAA_MAXCOUNTPATH){
    id_path[CountStr]=dmMain->oqCursor->FieldByName("id")->AsInteger;
    dmMain->oqCursor->Next();
    CountStr++;
  }
  if(CountStr<=0){
	  return false;
  }else{
	  if((fd->CodeTemplate==1000)||(fd->CodeTemplate==1100)||((fd->startmid==0)&&(fd->IsPoints)&&
         ((fd->CodeTemplate==1200)||(fd->CodeTemplate==1201)||(fd->CodeTemplate==1202)||(fd->CodeTemplate==1203)||(fd->CodeTemplate==1306))))
    id_path[CountStr++]=0;
    long temp_id_Node,i,k;
   	TTreeNode *Node,*Node1;
	  Node = tv->Items->GetFirstNode();
   	for(i=CountStr-1;i>=0;--i){
	    temp_id_Node=id_path[i];
      k=0;
   		while(Node!=NULL){
	   	  if(k==0){
          Node1=Node;
          k++;
        }
		   	long j=(fd->IsPoints?-1:1)*(long)Node->Data;
			  if(j==temp_id_Node){
				  if(i>0){
					  Node->Expand(false);
   					Node=Node->getFirstChild();
	   			}
		   		break;
        }else{
				  Node=Node->getNextSibling();
   			}
	   		if(Node==NULL){
          Node=Node1;
          break;
        }
      }
    }
	  if(Node!=NULL){
		  Node->Selected=true;
    }else{
	    return false;
    }
  }
  return true;
}
//---------------------------------------------------------------------------



