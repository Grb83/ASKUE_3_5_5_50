//---------------------------------------------------------------------------
#include <vcl.h>
#include <stdio.h>
#include <math.h>
#pragma hdrstop
#include "unDataMod.h"
#include "Saa_SelectForm.h"
#include "Saa_SelectGroupProc.h"
#include "Monitor.h"
#include "Interior.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "DBAccess"
#pragma link "MemDS"
#pragma link "Ora"
#pragma resource "*.dfm"
TfmSelectGroupReportProc *fmSelectGroupReportProc;
//---------------------------------------------------------------------------
__fastcall TfmSelectGroupReportProc::TfmSelectGroupReportProc(TComponent* Owner,TFormDescr* sfd)
	: TForm(Owner)
{
 fd=sfd;
}
//---------------------------------------------------------------------------
void __fastcall TfmSelectGroupReportProc::FormShow(TObject *Sender)
{
  tvMain->Focused();		//выбрать нужный по id_Group
}
//---------------------------------------------------------------------------
bool TfmSelectGroupReportProc::GetAllTree(TObject *Sender)
{
 int ii;
 try{
     dmMain->oqCursor->Params->Clear();
     dmMain->oqCursor->SQL->Text="begin "+SchemeName+"saa_select_pg.SelectGroupProc_GetAllTree_p(:par1,:par2,:par3,:par4);end;";
     dmMain->oqCursor->ParamByName("par4")->DataType=ftCursor;
     dmMain->oqCursor->ParamByName("par4")->ParamType=ptOutput;

     dmMain->oqCursor->ParamByName("par1")->AsInteger=fd->CodeTemplate;

    if((fd->CodeTemplate!=1000)&&(fd->CodeTemplate!=1100)){          // Обычный режим
        TTreeNode *MyTreeNode1;

        if(fd->EnableControls.Contains(TFormDescr::ctrlPoint))
              //  TfmSelectReportForm::AddPoints(tvMain, NULL, 3, 2,fd->startmid);
               TfmSelectReportForm::AddPoints(tvMain, NULL, 2, 2,fd->startmid);

        dmMain->oqCursor->ParamByName("par2")->AsInteger=fd->IdFormTree;
        dmMain->oqCursor->ParamByName("par3")->AsInteger = SetVisualControls(this);  //Установка доступности;
        dmMain->oqCursor->Execute();
        while(!dmMain->oqCursor->Eof){
          MyTreeNode1=tvMain->Items->AddObject(NULL,dmMain->oqCursor->FieldByName("VNAME")->AsString,(void*)dmMain->oqCursor->FieldByName("Gid")->AsInteger);
          if (dmMain->oqCursor->FieldByName("PP")->AsInteger==1)
            tvMain->Items->AddChildObject(MyTreeNode1,"",(void*)0);
          ii = GetIndexPicture(dmMain->oqCursor->FieldByName("PR")->AsInteger);
          MyTreeNode1->ImageIndex = ii;
          MyTreeNode1->SelectedIndex = ii;
          dmMain->oqCursor->Next();
        }
    }else{
       TTreeNode *Node,*MyTreeNode1;
       if(fd->CodeTemplate==1000){
         Node = tvMain->Items->AddObject(NULL,Reconst_smes56_1,(void*)0);
        dmMain->oqCursor->ParamByName("par2")->Clear();
        dmMain->oqCursor->ParamByName("par3")->Clear();

       }else{
         Node = tvMain->Items->AddObject(NULL,Reconst_smes56_2,(void*)0);
         dmMain->oqCursor->ParamByName("par2")->Clear();
        dmMain->oqCursor->ParamByName("par3")->Clear();
       }
       Node->ImageIndex = 3;
       Node->SelectedIndex = 3;
       dmMain->oqCursor->Execute();
       while(!dmMain->oqCursor->Eof){
        MyTreeNode1=tvMain->Items->AddChildObject(Node,dmMain->oqCursor->FieldByName("VNAME")->AsString,(void*)(dmMain->oqCursor->FieldByName("Mid")->AsInteger));
        if(dmMain->oqCursor->FieldByName("Lev")->AsInteger==1)
          tvMain->Items->AddChildObject(MyTreeNode1,"",(void*)0);
        if(fd->CodeTemplate==1000){
          ii = GetIndexPictureJournal(dmMain->oqCursor->FieldByName("Task_Cod")->AsInteger);
        }else{
          ii = (dmMain->oqCursor->FieldByName("Task_Cod")->AsInteger==3)?2:3;
        }
        MyTreeNode1->ImageIndex=ii;
        MyTreeNode1->SelectedIndex=ii;
        dmMain->oqCursor->Next();
      }
    }//fd->CodeTemplate
 }catch(Exception &exception){
    Application->MessageBox(exception.Message.c_str(),Reconst_smes55_5.c_str(),MB_OK|MB_ICONSTOP);
    return false;
 }
 return true;
}
//---------------------------------------------------------------------------
void __fastcall TfmSelectGroupReportProc::FormCreate(TObject *Sender)
{
  //Параметры имеют другой смысл
  IsTimeFields = fd->EnableControls.Contains(TFormDescr::ctrlMonth);
  IsSecondBound = fd->EnableControls.Contains(TFormDescr::ctrlDay);
  //e Параметры имеют другой смысл
  MEdBeg1->Visible = IsTimeFields;
  MEdBeg2->Visible = MEdBeg1->Visible;
  MEdEnd1->Visible = IsTimeFields && IsSecondBound;
  MEdEnd2->Visible = MEdEnd1->Visible;
  LbHBound1->Visible = IsSecondBound;
  LbHBound2->Visible = LbHBound1->Visible;
  LbHBound1->Visible = IsSecondBound;
  LbHBound2->Visible = LbHBound1->Visible;
  DTPickDEnd1->Visible = IsSecondBound;
  DTPickDEnd2->Visible = DTPickDEnd1->Visible;
  LbLBound1->Visible = IsSecondBound;
  LbLBound2->Visible = LbLBound1->Visible;
  LbDate1->Visible = !IsSecondBound;
  LbDate2->Visible = LbDate1->Visible;
  LbTime1->Visible = IsTimeFields && !IsSecondBound;
  LbTime2->Visible = LbTime1->Visible;

  DTPickDBeg1->Left = (IsSecondBound )?108:252;
  DTPickDBeg2->Left = DTPickDBeg1->Left;
  MEdBeg1->Left = (IsSecondBound )?231:447;
  MEdBeg2->Left = MEdBeg1->Left;

  int prDelta;
  if(IsTimeFields)
    prDelta = 0;
  else{
    prDelta = (IsSecondBound )?50:108;
  }
  DTPickDBeg1->Left += prDelta;
  DTPickDBeg2->Left = DTPickDBeg1->Left;
  DTPickDEnd1->Left += prDelta;
  DTPickDEnd2->Left = DTPickDEnd1->Left;
  LbDate1->Left += prDelta;
  LbDate2->Left = LbDate1->Left;
  LbLBound1->Left += prDelta;
  LbLBound2->Left = LbLBound1->Left;
  LbHBound1->Left += prDelta;
  LbHBound2->Left = LbHBound1->Left;


  tvMain->Items->Clear();
  TDateTime prEndDT = fd->DateTime;
  TDateTime prBegDT = fd->DateTimePar;

  DTPickDBeg1->Date = (TDateTime)( floor( prBegDT ) );
  MEdBeg1->Text = prBegDT.FormatString("hh:nn");
  DTPickDEnd1->Date = (TDateTime)( floor( prEndDT ) );
  MEdEnd1->Text = prEndDT.FormatString("hh:nn");
  AnsiString s=GetVisibledaddparampanel();
  paAdd1->Visible=(s.SubString(1,1)==1);
  paAdd2->Visible=(s.SubString(2,1)==1);
  if(paAdd1->Visible){
    if(AnsiString(fd->FAddParam[0])!=""){
      DTPickDBeg2->Date = StrToDate(AnsiString(fd->FAddParam[0]).SubString(1,10));
      MEdBeg2->Text = AnsiString(fd->FAddParam[0]).SubString(11,5);
    }else{
      DTPickDBeg2->Date = (int)Now()-1;
      MEdBeg2->Text = "00:00";
    }
    if(AnsiString(fd->FAddParam[1])!=""){
      DTPickDEnd2->Date = StrToDate(AnsiString(fd->FAddParam[1]).SubString(1,10));
      MEdEnd2->Text = AnsiString(fd->FAddParam[1]).SubString(11,5);
    }else{
      DTPickDEnd2->Date = (int)Now();
      MEdEnd2->Text = "00:00";
    }
  }
  if(paAdd2->Visible){
    if(AnsiString(fd->FAddParam[2])!="")
      ed51Proc->Text=fd->FAddParam[2];
    ed51Ammount->Text=fd->FAddParam[3];
    rbEnergy->ItemIndex=(AnsiString(fd->FAddParam[4])=="")?0:AnsiString(fd->FAddParam[4]).ToInt();
  }
  GetAllTree(this);
  if(fd->IdGroup>0)
	  TfmSelectReportForm::GetSelectedTree(tvMain,fd);
}
//---------------------------------------------------------------------------
int TfmSelectGroupReportProc::SetVisualControls(TObject *Sender)
{
 return (fd->EnableControls.Contains(TFormDescr::ctrlGroup))?200:2;
}
//--------------------------------------------------------------------------
int TfmSelectGroupReportProc::GetIndexPicture(int i)
{
 if(i<10)  return 0;
	else return (i == 11)?2:1;
}
//---------------------------------------------------------------------------
int TfmSelectGroupReportProc::GetIndexPictureJournal(int i)
{
	return (i == 0)?3:4;
}
//---------------------------------------------------------------------------
void __fastcall TfmSelectGroupReportProc::tvMainDblClick(TObject *Sender)
{
	btOkClick(this);
}
//---------------------------------------------------------------------------
void __fastcall TfmSelectGroupReportProc::FormKeyDown(TObject *Sender,
      WORD &Key, TShiftState Shift)
{
  if(Key==13&&Shift==TShiftState()&&btOk->CanFocus()){
    Key=0;
    btOk->SetFocus();
    keybd_event(13, (byte) MapVirtualKey(13, 0), 0, 0);
  }
}
//---------------------------------------------------------------------------
void __fastcall CheckTimeInput( AnsiString PPVal, AnsiString PPNameStr )
{
  try{
    StrToTime( PPVal + ":00" );
  }catch(Exception &e){
    throw Exception (AnsiString(Reconst_smes56_3 + PPNameStr + "'."));
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmSelectGroupReportProc::btOkClick(TObject *Sender)
{
  //Границы
  AnsiString prStr;
  TDateTime prBeg,prBeg2,prEnd,prEnd2;
  if(IsSecondBound)
    prStr = Reconst_smes56_4;
  else
    prStr = Reconst_smes56_5;
  if(!IsTimeFields){
    MEdBeg1->Text = "00:00";
    MEdEnd1->Text = "00:00";
    if(paAdd1->Visible){
      MEdBeg2->Text = MEdBeg1->Text;
      MEdEnd2->Text = MEdEnd1->Text;
    }
  }

  CheckTimeInput( MEdBeg1->Text,prStr);
  prBeg = (TDateTime )floor( DTPickDBeg1->Date ) + StrToTime( MEdBeg1->Text + ":00" );
  dmMain->SetShiftTimeZona(prBeg);

  CheckTimeInput( MEdEnd1->Text, Reconst_smes56_6 );
  prEnd = (TDateTime )floor( DTPickDEnd1->Date ) + StrToTime( MEdEnd1->Text + ":00" );
  if(!IsSecondBound)
    prEnd = prBeg + 1;


  if(paAdd1->Visible){
    CheckTimeInput( MEdBeg2->Text,prStr);
    prBeg2 = (TDateTime )floor( DTPickDBeg2->Date ) + StrToTime( MEdBeg2->Text + ":00" );
    dmMain->SetShiftTimeZona(prBeg2);

    CheckTimeInput( MEdEnd2->Text, Reconst_smes56_6 );
    prEnd2 = (TDateTime )floor( DTPickDEnd2->Date ) + StrToTime( MEdEnd2->Text + ":00" );
    if(!IsSecondBound)
      prEnd2 = prBeg2 + 1;
  }
  if(IsSecondBound&&(prBeg > prEnd||(paAdd1->Visible&&prBeg2 > prEnd2)))
    throw Exception (Reconst_smes56_7);

  int prGId = -1;
  int isPoint = 0;
  TTreeNode* Node = tvMain->Selected;
  if(Node&&Node->Data){
    prGId = (long)Node->Data;
    isPoint=prGId<0;
  }
  if(PL_SQL_REP_F == fd->CodeTemplate ){
    quOk->SQL->Text= "begin "+SchemeName+"FILEREPORT_PG.main_p(:par1,:par2,to_date(:par3,'dd.mm.yyyy hh24:mi:ss'),to_date( :par4,'dd.mm.yyyy hh24:mi:ss'),:par5); end;";
    quOk->ParamByName("par1")->AsInteger=fd->IdFormTree;
    quOk->ParamByName("par2")->AsInteger=(isPoint)?-prGId:prGId;
    quOk->ParamByName("par3")->AsString=prBeg.FormatString("dd.mm.yyyy hh:nn:ss");
    quOk->ParamByName("par4")->AsString=prEnd.FormatString("dd.mm.yyyy hh:nn:ss");
    quOk->ParamByName("par5")->AsInteger=isPoint;
    quOk->Execute();
  }
  SetAddParam();
  if(Node)
    fd->NameGroup = Node->Text;
  fd->IdGroup = abs(prGId);
  fd->IsPoints = isPoint;
  fd->CeilingIdGroup = fd->IdGroup;
  fd->DateTime = prEnd;
  fd->DateTimePar = prBeg;
  if(paAdd1->Visible){
    strcpy(fd->FAddParam[0],prBeg2.FormatString("dd.mm.yyyy hh:nn:ss").c_str());
    strcpy(fd->FAddParam[1],prEnd2.FormatString("dd.mm.yyyy hh:nn:ss").c_str());
  }
  PostMessage( NULL,WM_REFRESHFORM,0,(LPARAM)fd );
  ModalResult = mrOk;
}
//---------------------------------------------------------------------------
void TfmSelectGroupReportProc::SetAddParam(void)
{
  if(paAdd2->Visible){
    if(ed51Proc->Text.Trim().Length())
      ed51Proc->Text.Trim().ToDouble();
    strcpy(fd->FAddParam[2],ed51Proc->Text.Trim().c_str());
    if(ed51Ammount->Text.Trim().Length())
      ed51Ammount->Text.Trim().ToDouble();
    strcpy(fd->FAddParam[3],ed51Ammount->Text.Trim().c_str());
    strcpy(fd->FAddParam[4],IntToStr(rbEnergy->ItemIndex).c_str());
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmSelectGroupReportProc::tvMainExpanding(TObject *Sender,
      TTreeNode *Node, bool &AllowExpansion)
{
  int ii;
  try{
     quGroupProc->Params->Clear();
     quGroupProc->SQL->Text="begin "+SchemeName+"saa_select_pg.SelectGroupProc_tvMainExp_p(:par1,:par2,:par3);end;";
     quGroupProc->ParamByName("par3")->DataType=ftCursor;
     quGroupProc->ParamByName("par3")->ParamType=ptOutput;

      quGroupProc->ParamByName("par1")->AsInteger=fd->CodeTemplate;

    if((fd->CodeTemplate!=1000)&&(fd->CodeTemplate!=1100)){   // Обычный режим
      TTreeNode *MyTreeNode1;
      MyTreeNode1=Node->getFirstChild();
      if((MyTreeNode1==NULL)||((long)MyTreeNode1->Data==0)){
        Node->DeleteChildren();
      }else{
        return;
      }
      long i=(long)Node->Data;
      if(i<0)
       // TfmSelectReportForm::AddPoints(tvMain, Node, 3, 2);
       TfmSelectReportForm::AddPoints(tvMain, Node, 2, 2);
      else{

        quGroupProc->ParamByName("par2")->AsInteger=i;
        quGroupProc->Execute();
        while(!quGroupProc->Eof){
          MyTreeNode1=tvMain->Items->AddChildObject(Node,quGroupProc->FieldByName("VNAME")->AsString,(void*)(quGroupProc->FieldByName("Gid")->AsInteger));
          if (quGroupProc->FieldByName("PP")->AsInteger==1)
            tvMain->Items->AddChildObject(MyTreeNode1,"",(void*)0);
          ii = GetIndexPicture(quGroupProc->FieldByName("PR")->AsInteger);
          MyTreeNode1->ImageIndex = ii;
          MyTreeNode1->SelectedIndex = ii;
          quGroupProc->Next();
        }
      }
    }else{                                                    //Журнал
    	TTreeNode *MyTreeNode1;
    	MyTreeNode1=Node->getFirstChild();
    	if((MyTreeNode1==NULL)||((long)MyTreeNode1->Data==0)){
		    Node->DeleteChildren();
    	}else{
	      return;
    	}
      long i = (long)Node->Data;

      quGroupProc->ParamByName("par2")->AsInteger=i;
      quGroupProc->Execute();
      while(!quGroupProc->Eof){
  			MyTreeNode1=tvMain->Items->AddChildObject(Node,quGroupProc->FieldByName("VNAME")->AsString,(void*)(quGroupProc->FieldByName("Mid")->AsInteger));
	  		if (quGroupProc->FieldByName("Lev")->AsInteger==1)
		  		tvMain->Items->AddChildObject(MyTreeNode1,"",(void*)0);
			  if(fd->CodeTemplate==1000){
				  ii = GetIndexPictureJournal(quGroupProc->FieldByName("Task_Cod")->AsInteger);
  			}else{
	  			ii = (quGroupProc->FieldByName("Task_Cod")->AsInteger==3)?2:3;
		  	}
			  MyTreeNode1->ImageIndex = ii;
  			MyTreeNode1->SelectedIndex = ii;
        quGroupProc->Next();
    	}
    }
  }catch(Exception &e){
  	Application->MessageBox(e.Message.c_str(),Reconst_smes55_5.c_str(),MB_OK|MB_ICONSTOP);
	  AllowExpansion=false;
  }
}
//---------------------------------------------------------------------------
AnsiString TfmSelectGroupReportProc::GetVisibledaddparampanel(void)
{
  dmMain->quMain->SQL->Text="select "+SchemeName+"UNIINTERIOR_PG.f_getvisibledaddparampanel("+IntToStr(fd->IdFormTree)+") name from dual";
  dmMain->quMain->Params->Clear();
  dmMain->quMain->Execute();
  AnsiString ret=dmMain->quMain->FieldByName("name")->AsString;
  dmMain->quMain->Close();
  return ret;
}
//---------------------------------------------------------------------------

