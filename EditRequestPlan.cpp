//---------------------------------------------------------------------------
#include <vcl.h>
#include <stdio.h>
#include <System.hpp>
#pragma hdrstop
#include "EditRequestPlan.h"
#include "unDataMod.h"
#include "ChannelPointsList.h"
#include "LastSave.h"
#include "OperScanSchedEd.h"
#include "unMTX.h"
#include "unRTRNP.h"
#include "unRTRNIK.h"
#include "unChInt.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma link "DBAccess"
#pragma link "MemDS"
#pragma link "Ora"
#pragma resource "*.dfm"
UINT CF_CHANNELS_TREENODE; // описание формата для буфера обмена
//---------------------------------------------------------------------------
__fastcall TfmEditRequestPlan::TfmEditRequestPlan(TComponent* Owner, AnsiString Name, TAccess a)
  : TMainForm(Owner, Name, a),ChangeControl(true)
{
    if(Access==accWrite){
        eUsdPassword->PasswordChar = 0;
    }

   iaPoints->Visible = true;
   iaNew->Visible = true;
   iaDelete->Visible = true;
   iaClone->Visible = true;
   iaBlock->Visible = true;
   iaUnblock->Visible = true;
   OldScanIndex=0;

   nPoints_Del = NULL;
   Points_Del_Count = 0;
   // регистрация формата для буфера обмена
   CF_CHANNELS_TREENODE = RegisterClipboardFormat("CF_CHANNELS_TREENODE");
   if(!CF_CHANNELS_TREENODE)
   {
      char mess[1025];
      LPVOID lpMsgBuf;
      FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_SYSTEM,
         NULL, GetLastError(),
         MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT), // Default language
         (LPTSTR) &lpMsgBuf,  0,  NULL);
      strncpy(mess, (char*)lpMsgBuf, 1024);
      LocalFree(lpMsgBuf);
      throw Exception(mess);
   }
  fmFP = new TfmFindPoint(this);
  iaFind->OnExecute = iaFindExecute;
  iaFind->Enabled = true;
  iaMTX->OnExecute = iaMTXExecute;
  iaMTX->Enabled = true;
  iaRTR56->OnExecute = iaRTR56Execute;
  iaRTR56->Enabled = true;
  ShowAction(iaFind);
}
//---------------------------------------------------------------------------
__fastcall TfmEditRequestPlan::~TfmEditRequestPlan()
{
    delete fmFP;
    if(Clipboard()->HasFormat(CF_CHANNELS_TREENODE))
      Clipboard()->Clear();
}
//------------------------------------------------------------------------------------------
void __fastcall TfmEditRequestPlan::FormShow(TObject *Sender)
{
   cbScan->Items->Clear();
    for(int i=0;i<dmMain->SrvList->Count;i++)
       cbScan->Items->AddObject(dmMain->SrvList->Strings[i],dmMain->SrvList->Objects[i]);
       cbScan->ItemIndex=0;

   if (dmMain->SrvList->Count==1)
    {
    Panel3->Visible=false;
    Panel3->Width=1;
    }
    
  if(GetCombo(cbProtocol_id)&&GetCombo(cbCom_id)&&GetCombo(cbMainChannel)&&ReadChannelNode(NULL)){
      tvChannelsList->OnChange = tvChannelsListChange;
    if(tvChannelsList->Items->Count)
      tvChannelsList->Selected = tvChannelsList->Items->Item[0];
    tvChannelsList->OnChanging = tvChannelsListChanging;
    Width = Width-1;
    Height = Height-1;
    tvChannelsList->SetFocus();
    tvChannelsListChange(Sender,tvChannelsList->Selected);
  }else
    Close();
}
//---------------------------------------------------------------------------
// Читает список каналов
bool __fastcall TfmEditRequestPlan::ReadChannelNode(TObject*obj)
{
   stChannel *PChannel;
   TTreeNode *TN;
   long id=1;
  // long id = obj&&((TTreeNode*)obj)->Data?((stChannel*)((TTreeNode*)obj)->Data)->Cid:1;

     if(obj)
        id = getNodeId(obj);//((stChannel*)((TTreeNode*)obj)->Data)->Cid;
     else
     {
       oqEditReqPlan->Params->Clear();
       oqEditReqPlan->SQL->Text="begin "+SchemeName+"channels_pg.get_mid(:par1,:par2); end;";
       oqEditReqPlan->ParamByName("par2")->ParamType = ptOutput;
       oqEditReqPlan->ParamByName("par2")->DataType = ftCursor;
       oqEditReqPlan->ParamByName("par1")->AsInteger=(int)cbScan->Items->Objects[cbScan->ItemIndex];
       oqEditReqPlan->Execute();
       if(!oqEditReqPlan->Eof)
       nsrv=oqEditReqPlan->FieldByName("mid")->AsInteger;
       id=nsrv;
       oqEditReqPlan->Close();
     }

   long acc = Access;
   try
   {
      oqEditReqPlan->Params->Clear();
      oqEditReqPlan->SQL->Text = "begin "+SchemeName+"channels_pg.get_ReadNode(:par1,:par2,:par3); end;";
      oqEditReqPlan->ParamByName("par3")->ParamType = ptOutput;
      oqEditReqPlan->ParamByName("par3")->DataType = ftCursor;
      oqEditReqPlan->ParamByName("par1")->AsInteger=id;
      oqEditReqPlan->ParamByName("par2")->AsInteger=acc;
      if(obj)
         ((TTreeNode*)obj)->DeleteChildren();
      oqEditReqPlan->Execute();
      while(!oqEditReqPlan->Eof){
       PChannel = new stChannel;
       ZeroMemory(PChannel,sizeof(stChannel));
       PChannel->editing=oqEditReqPlan->FieldByName("IS_GROUP")->AsInteger;
      PChannel->tmpCid=oqEditReqPlan->FieldByName("HAS_CHILD")->AsInteger;
      PChannel->Cid=oqEditReqPlan->FieldByName("CID")->AsInteger;
      strcpy(PChannel->Name,oqEditReqPlan->FieldByName("VNAME")->AsString.c_str());
      if(!oqEditReqPlan->FieldByName("vnote")->IsNull)
      strcpy(PChannel->Note,oqEditReqPlan->FieldByName("vnote")->AsString.c_str());
      if(!oqEditReqPlan->FieldByName("protocol_id")->IsNull)
      PChannel->PROTOCOL_ID=oqEditReqPlan->FieldByName("protocol_id")->AsInteger;
      if(!oqEditReqPlan->FieldByName("com_id")->IsNull)
      PChannel->COM_ID=oqEditReqPlan->FieldByName("com_id")->AsInteger;
      if(!oqEditReqPlan->FieldByName("init_str")->IsNull)
      strcpy(PChannel->INIT_STR,oqEditReqPlan->FieldByName("init_str")->AsString.c_str());
      if(!oqEditReqPlan->FieldByName("vaddparam")->IsNull)
      strcpy(PChannel->DopParam,oqEditReqPlan->FieldByName("vaddparam")->AsString.c_str());
      if(!oqEditReqPlan->FieldByName("ADDR")->IsNull)
      strcpy(PChannel->ADDR,oqEditReqPlan->FieldByName("ADDR")->AsString.c_str());
      if(!oqEditReqPlan->FieldByName("CYCLE_TOUT")->IsNull)
      PChannel->CYCLE_TOUT=oqEditReqPlan->FieldByName("CYCLE_TOUT")->AsInteger;
      if(!oqEditReqPlan->FieldByName("RETRIES")->IsNull)
      PChannel->RETRIES=oqEditReqPlan->FieldByName("RETRIES")->AsInteger;
      if(!oqEditReqPlan->FieldByName("RETRIES_TOUT")->IsNull)
      PChannel->RETRIES_TOUT=oqEditReqPlan->FieldByName("RETRIES_TOUT")->AsInteger;
      if(!oqEditReqPlan->FieldByName("BLOCKING")->IsNull)
      PChannel->BLOCKING=oqEditReqPlan->FieldByName("BLOCKING")->AsInteger;
      if(!oqEditReqPlan->FieldByName("CALLER_NAME")->IsNull)
      strcpy(PChannel->Caller_Name,oqEditReqPlan->FieldByName("CALLER_NAME")->AsString.c_str());
      if(!oqEditReqPlan->FieldByName("NBILLDATA")->IsNull)
      PChannel->NBILLDATA=oqEditReqPlan->FieldByName("NBILLDATA")->AsInteger;
      if(!oqEditReqPlan->FieldByName("NBILLDATADEPTH")->IsNull){
      PChannel->indicator[0]=0;
      PChannel->NBILLDATADEPTH=oqEditReqPlan->FieldByName("NBILLDATADEPTH")->AsInteger;}
      else  PChannel->indicator[0]=-1;
      if(!oqEditReqPlan->FieldByName("NCURRDATA")->IsNull)
      PChannel->NCURRDATA=oqEditReqPlan->FieldByName("NCURRDATA")->AsInteger;
      if(!oqEditReqPlan->FieldByName("NCURRDATADEPTH")->IsNull){
      PChannel->indicator[1]=0;
      PChannel->NCURRDATADEPTH=oqEditReqPlan->FieldByName("NCURRDATADEPTH")->AsInteger;}
      else  PChannel->indicator[1]=-1;
      if(!oqEditReqPlan->FieldByName("NNETPARAM")->IsNull)
      PChannel->NNETPARAM=oqEditReqPlan->FieldByName("NNETPARAM")->AsInteger;
      if(!oqEditReqPlan->FieldByName("NJOURNAL")->IsNull)
      PChannel->NJOURNAL=oqEditReqPlan->FieldByName("NJOURNAL")->AsInteger;
      if(!oqEditReqPlan->FieldByName("DSTART")->IsNull){
      PChannel->indicator[2]=0;
      strcpy(PChannel->DSTART,oqEditReqPlan->FieldByName("DSTART")->AsString.c_str());}
      else  PChannel->indicator[2]=-1;
      if(!oqEditReqPlan->FieldByName("DEND")->IsNull){
      PChannel->indicator[3]=0;
      strcpy(PChannel->DEND,oqEditReqPlan->FieldByName("DEND")->AsString.c_str());}
      else  PChannel->indicator[3]=-1;
      if(!oqEditReqPlan->FieldByName("NDAY")->IsNull){
      PChannel->indicator[4]=0;
      PChannel->NDAY=oqEditReqPlan->FieldByName("NDAY")->AsInteger;}
      else  PChannel->indicator[4]=-1;
      if(!oqEditReqPlan->FieldByName("NPARENT")->IsNull){
      PChannel->indicator[5]=0;
      PChannel->NPARENT=oqEditReqPlan->FieldByName("NPARENT")->AsInteger;}
      else  PChannel->indicator[5]=-1;
      if(!oqEditReqPlan->FieldByName("NNOTREADCURR")->IsNull)
      PChannel->NREADCUR=oqEditReqPlan->FieldByName("NNOTREADCURR")->AsInteger;
      if(!oqEditReqPlan->FieldByName("NWAIT")->IsNull)
      PChannel->iConnTimeWait=oqEditReqPlan->FieldByName("NWAIT")->AsInteger;
      if(!oqEditReqPlan->FieldByName("VACCUSER")->IsNull)
      strcpy(PChannel->eUsdName,oqEditReqPlan->FieldByName("VACCUSER")->AsString.c_str());
      if(!oqEditReqPlan->FieldByName("eUsdPassword")->IsNull)
      strcpy(PChannel->eUsdPassword,oqEditReqPlan->FieldByName("eUsdPassword")->AsString.c_str());
      if(!oqEditReqPlan->FieldByName("NLOCKCORRECTTIME")->IsNull)
      PChannel->LOCKCORRECTTIME=oqEditReqPlan->FieldByName("NLOCKCORRECTTIME")->AsInteger;

            if(id)
               TN = tvChannelsList->Items->AddChildObject((TTreeNode*)obj, PChannel->Name, PChannel);
            else
               TN = tvChannelsList->Items->AddObject(NULL, PChannel->Name, PChannel);
            bool fBlock = PChannel->BLOCKING;
            if(PChannel->editing){
               PChannel->editing = 0;
               TN->ImageIndex = fBlock?23:4;
               TN->SelectedIndex = fBlock?23:4;
            }else{
               TN->ImageIndex = PChannel->indicator[5]<0?(fBlock?11:9):(fBlock?12:10);
               TN->SelectedIndex = PChannel->indicator[5]<0?(fBlock?11:9):(fBlock?12:10);
            }
            if(PChannel->tmpCid){
               tvChannelsList->Items->AddChildObject(TN,"",NULL);
               PChannel->tmpCid = 0;
            }
         PChannel->editingperiod=0;
         oqEditReqPlan->Next();
         }

   }
   catch (Exception &exception)
   {

      Application->ShowException(&exception);
      return false;
   }

   return true;
}
//---------------------------------------------------------------------------
bool __fastcall TfmEditRequestPlan::GetCombo(TComboBox *cb)
{
  try{
    cb->Items->Clear();
    oqEditReqPlan->Params->Clear();
    oqEditReqPlan->SQL->Text="begin "+SchemeName+"channels_pg.get_combo(:par1,:flag,:par3); end;";
    oqEditReqPlan->ParamByName("par3")->ParamType = ptOutput;
    oqEditReqPlan->ParamByName("par3")->DataType = ftCursor;
    if(cb==cbProtocol_id)
      oqEditReqPlan->ParamByName("flag")->AsInteger = 1;
    if(cb==cbCom_id){
      oqEditReqPlan->ParamByName("flag")->AsInteger = 2;
      oqEditReqPlan->ParamByName("par1")->AsInteger=(int)cbScan->Items->Objects[cbScan->ItemIndex];
    }
    if(cb==cbMainChannel){
      cb->Items->Add("");
      oqEditReqPlan->ParamByName("flag")->AsInteger = 3;
    }
    oqEditReqPlan->Execute();
    while(!oqEditReqPlan->Eof){
      cb->Items->AddObject(oqEditReqPlan->FieldByName("VNAME")->AsString,(TObject*)oqEditReqPlan->FieldByName("CID")->AsInteger);
      oqEditReqPlan->Next();
    }
    if(!oqEditReqPlan->RecordCount){
      if(cb==cbProtocol_id)
        throw Exception(Reconst_smes26_1);
      if(cb==cbCom_id)
        throw Exception(Reconst_smes26_2);
    }
  }catch (Exception &exception){
    Application->ShowException(&exception);
    return false;
  }
  return true;
}
//---------------------------------------------------------------------------
void __fastcall TfmEditRequestPlan::tvChannelsListChanging(TObject *Sender,
      TTreeNode *Node, bool &AllowChange)
{
   if(SelChannel->editing!=2 && SelChannel->editing!=1)
      return;
   bool isGroup = !IsChannel(tvChannelsList->Selected);
   TWinControl *Control=NULL;
   try{
      strcpy(SelChannel->Name,eName->Text.c_str());
      if(isGroup) goto checkBlocking;
      strcpy(SelChannel->Note,mNote->Text.c_str());
      Control=(TWinControl*)eCaller_Name;
      eCaller_Name->Text = "Srv";
      if(eCaller_Name->Text.IsEmpty())
         throw Exception(Reconst_smes26_3);
      else
         strcpy(SelChannel->Caller_Name,eCaller_Name->Text.c_str());
      Control=(TWinControl*)cbProtocol_id;
      if(cbProtocol_id->ItemIndex<0)
         throw Exception(Reconst_smes26_4);
      else
         SelChannel->PROTOCOL_ID=(long)cbProtocol_id->Items->Objects[cbProtocol_id->ItemIndex];
      Control=(TWinControl *)cbCom_id;
      if(cbCom_id->ItemIndex<0)
         throw Exception(Reconst_smes26_5);
      else
         SelChannel->COM_ID=(long)cbCom_id->Items->Objects[cbCom_id->ItemIndex];
      strcpy(SelChannel->INIT_STR,eInit_str->Text.c_str());
      strcpy(SelChannel->DopParam,eDopParam->Text.c_str());
      strcpy(SelChannel->eUsdName,eUsdName->Text.c_str());
      strcpy(SelChannel->eUsdPassword,eUsdPassword->Text.c_str());
      strcpy(SelChannel->ADDR,eAddr->Text.c_str());
      if(cbMainChannel->ItemIndex>0)
      {
         SelChannel->NPARENT = (long)cbMainChannel->Items->Objects[cbMainChannel->ItemIndex];
         SelChannel->indicator[5] = 0;
      }
      else
         SelChannel->indicator[5] = -1;
    Control=(TWinControl *)eCycle_Tout;
    if(eCycle_Tout->Text.IsEmpty()||eCycle_Tout->Text.ToInt()<0)
      throw Exception(Reconst_smes26_6);
    else
      SelChannel->CYCLE_TOUT = eCycle_Tout->Text.ToInt();
    Control=(TWinControl *)eRetries;
    if(eRetries->Text.IsEmpty()||eRetries->Text.ToInt()<=0)
      throw Exception(Reconst_smes26_7);
    else
      SelChannel->RETRIES = eRetries->Text.ToInt();
    Control=(TWinControl *)eRetries_Tout;
    if(eRetries_Tout->Text.IsEmpty()||eRetries_Tout->Text.ToInt()<0)
      throw Exception(Reconst_smes26_8);
    else
      SelChannel->RETRIES_TOUT = eRetries_Tout->Text.ToInt();
    Control=(TWinControl *)eConnTimeWait;
    if(eConnTimeWait->Text.IsEmpty()||eConnTimeWait->Text.ToInt()<=0)
      throw Exception(Reconst_smes26_9);
    else
      SelChannel->iConnTimeWait = eConnTimeWait->Text.ToInt();
    Control=(TWinControl *)meStart;
    try
    {
          if(meStart->Text == "  :  ")
             SelChannel->indicator[2] = -1;
          else
          {
             StrToTime(meStart->Text);
             strcpy(SelChannel->DSTART, meStart->Text.c_str());
             SelChannel->indicator[2] = 0;
          }
    }
    catch(EConvertError &ECR){throw Exception(Reconst_smes26_10);}
    Control=(TWinControl*)meEnd;
    try
    {
          if(meEnd->Text == "  :  ")
             SelChannel->indicator[3] = -1;
          else
          {
             StrToTime(meEnd->Text);
             strcpy(SelChannel->DEND, meEnd->Text.c_str());
             SelChannel->indicator[3] = 0;
          }
    }
    catch(EConvertError &ECR) {throw Exception(Reconst_smes26_11); }

    Control=(TWinControl *)eDay;
    if(!eDay->Text.IsEmpty())
    {
    //   if(eDay->Text.ToInt()>31)
    //     throw Exception(Reconst_smes26_12);
       SelChannel->NDAY = eDay->Text.ToInt();
       SelChannel->indicator[4] = 0;
    }
    else
       SelChannel->indicator[4] = -1;

//    Control=(TWinControl *)eBill_Data_Dept;
    SelChannel->NBILLDATA = chbBill_Data->Checked;
//    if(chbBill_Data->Checked&&eBill_Data_Dept->Text.IsEmpty()) throw Exception("Выбрано чтение коммерческих данныех но не указана глубина вычетки.");
    if(!eBill_Data_Dept->Text.IsEmpty())
    {
       SelChannel->NBILLDATADEPTH = eBill_Data_Dept->Text.ToInt();
       SelChannel->indicator[0] = 0;
    }
    else
       SelChannel->indicator[0] = -1;

//    Control=(TWinControl *)eCurr_Data_Dept;
    SelChannel->NCURRDATA = chbCurr_Data->Checked;
//    if(chbCurr_Data->Checked&&eCurr_Data_Dept->Text.IsEmpty()) throw Exception("Выбрано чтение технических данныех но не указана глубина вычетки.");
    if(!eCurr_Data_Dept->Text.IsEmpty())
    {
       SelChannel->NCURRDATADEPTH = eCurr_Data_Dept->Text.ToInt();
       SelChannel->indicator[1] = 0;
    }
    else
       SelChannel->indicator[1] = -1;
    SelChannel->NNETPARAM = chbNet_Param->Checked;
    SelChannel->NJOURNAL = chbJournal->Checked;
    SelChannel->NREADCUR = chbNReadCurr->Checked;
    SelChannel->LOCKCORRECTTIME = cbBlockingTime->Checked;
checkBlocking:
    SelChannel->BLOCKING = chbBlocking->Checked;
  }
  catch (Exception &exception)
  {
      AllowChange=false;
      Application->ShowException(&exception);
      if(Control) Control->SetFocus();
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmEditRequestPlan::tvChannelsListChange(TObject *Sender,
  TTreeNode *Node)
{
   if(ActiveControl) oldCtrl = ActiveControl;
   paEdit->Enabled   = ChangeControl = false;
   iaDelete->Enabled = false;
   iaClone->Enabled  = false;
   aState->Enabled   = false;
   aQuick->Enabled   = false;
   iaPoints->Enabled = false;
   iaRTR->Enabled = false;iaRTR->Visible = iaRTR->Enabled;
   for(int i=0; i<ComponentCount; i++)
   {
      if(dynamic_cast<TCustomEdit*>(Components[i]))
         ((TCustomEdit*)Components[i])->Clear();
      if(dynamic_cast<TComboBox*>(Components[i]))
         ((TComboBox*)Components[i])->ItemIndex = -1;
      if(dynamic_cast<TCheckBox*>(Components[i]))
      {
         ((TCheckBox*)Components[i])->Checked = false;
         ControlChange(Components[i]);
      }
   }
   lbId->Text="";
   if(!tvChannelsList->Selected)
     {
      cbScan->ItemIndex = OldScanIndex;
      return;
      }
   SelChannel = (stChannel*)tvChannelsList->Selected->Data;
   if(IsChannel(tvChannelsList->Selected))
   {
      mNote->Visible = true;
      Label2->Visible = true;
      Panel11->Visible = true;
      Panel18->Visible = true;
      Panel24->Visible = true;
   }else{
      Label2->Visible = false;
      mNote->Visible = false;
      Panel24->Visible = false;
      Panel18->Visible = false;
      Panel11->Visible = false;
   }

   eName->Text = SelChannel->Name;
   mNote->Text = SelChannel->Note;
   lbId->Text = (SelChannel->Cid>0)?IntToStr(SelChannel->Cid):AnsiString("");
   eCaller_Name->Text = SelChannel->Caller_Name;
   cbProtocol_id->ItemIndex = cbProtocol_id->Items->IndexOfObject((TObject*)SelChannel->PROTOCOL_ID);
   ControlChange(cbProtocol_id);
   cbCom_id->ItemIndex = cbCom_id->Items->IndexOfObject((TObject*)SelChannel->COM_ID);
   cbScan->ItemIndex = OldScanIndex;
   eInit_str->Text = SelChannel->INIT_STR;
   eDopParam->Text = SelChannel->DopParam;
   eUsdName->Text = SelChannel->eUsdName;
   eUsdPassword->Text = SelChannel->eUsdPassword;
   eAddr->Text = SelChannel->ADDR;
   cbMainChannel->ItemIndex = SelChannel->indicator[5]>=0 ? cbMainChannel->Items->IndexOfObject((TObject*)SelChannel->NPARENT):-1;

   eCycle_Tout->Text = IntToStr(SelChannel->CYCLE_TOUT);
   eRetries->Text = IntToStr(SelChannel->RETRIES);
   eRetries_Tout->Text = IntToStr(SelChannel->RETRIES_TOUT);
   eConnTimeWait->Text = IntToStr(SelChannel->iConnTimeWait);
   meStart->Text = SelChannel->indicator[2]>=0?SelChannel->DSTART:"  :  ";
   meEnd->Text = SelChannel->indicator[3]>=0?SelChannel->DEND:"  :  ";
   eDay->Text = SelChannel->indicator[4]>=0?IntToStr(SelChannel->NDAY).c_str():"";
   chbBill_Data->Checked = SelChannel->NBILLDATA;
   eBill_Data_Dept->Text = SelChannel->indicator[0]>=0?IntToStr(SelChannel->NBILLDATADEPTH).c_str():"";
   chbCurr_Data->Checked = SelChannel->NCURRDATA;
   eCurr_Data_Dept->Text = SelChannel->indicator[1]>=0?IntToStr(SelChannel->NCURRDATADEPTH).c_str():"";
   chbNet_Param->Checked = SelChannel->NNETPARAM;
   chbJournal->Checked = SelChannel->NJOURNAL;
   chbBlocking->Checked = SelChannel->BLOCKING;
   chbNReadCurr->Checked = SelChannel->NREADCUR;
   cbBlockingTime->Checked = SelChannel->LOCKCORRECTTIME;
   if(Access==accWrite)
      paEdit->Enabled = ChangeControl = true;
   iaDelete->Enabled = true;
   iaClone->Enabled = IsChannel(tvChannelsList->Selected);
   aState->Enabled = iaClone->Enabled;
   aQuick->Enabled = (iaClone->Enabled)&&(Access==accWrite);
   iaPoints->Enabled = iaClone->Enabled;
   iaRTR->Enabled =(SelChannel->Cid&&IsRTR(SelChannel->PROTOCOL_ID)); iaRTR->Visible = iaRTR->Enabled;

   eCycle_Tout->Enabled=(cbMainChannel->ItemIndex<1);
   try{
      ActiveControl = oldCtrl;
   }catch(Exception&e){
      ActiveControl = NULL;
   }
}
//---------------------------------------------------------------------------
void __fastcall TfmEditRequestPlan::cbScanChange(TObject *Sender)
{
   if(EditRec){
      switch(MessageBox(Handle,Reconst_smes26_15.c_str(),Application->Title.c_str(),MB_YESNOCANCEL|MB_ICONQUESTION|MB_DEFBUTTON1)){
      case IDYES:
         vSave(Sender);
         if(EditRec){
            cbScan->OnChange=NULL;
            cbScan->ItemIndex=OldScanIndex;
            cbScan->OnChange=cbScanChange;
            return;
         }
         break;
      case IDCANCEL:
         cbScan->OnChange=NULL;
         cbScan->ItemIndex=OldScanIndex;
         cbScan->OnChange=cbScanChange;
         return;
      case IDNO:
         EditRec = false;
      }
   }
   OldScanIndex=cbScan->ItemIndex;
   vRefresh(this);
}
//---------------------------------------------------------------------------
void __fastcall TfmEditRequestPlan::ControlChange(TObject *Sender)
{
   if(tvChannelsList->Selected&&ChangeControl)
   {
      EditRec = true;
      SelChannel->editing = SelChannel->editing==1?1:2;
      if(Sender==(TObject*)eName)
         tvChannelsList->Selected->Text=eName->Text;
      if((Sender==(TObject*)cbMainChannel)||(Sender==(TObject*)chbBlocking))
      {
         bool fBlock = chbBlocking->Checked;
         if(IsChannel(tvChannelsList->Selected)){
            tvChannelsList->Selected->ImageIndex = cbMainChannel->ItemIndex<1?(fBlock?11:9):(fBlock?12:10);
            tvChannelsList->Selected->SelectedIndex = cbMainChannel->ItemIndex<1?(fBlock?11:9):(fBlock?12:10);
         }else{
            tvChannelsList->Selected->ImageIndex = tvChannelsList->Selected->Expanded?(fBlock?22:5):(fBlock?23:4);
            tvChannelsList->Selected->SelectedIndex = tvChannelsList->Selected->Expanded?(fBlock?22:5):(fBlock?23:4);
         }
         tvChannelsList->Invalidate();
      }
   }
   if(Sender==(TObject*)chbBill_Data){
      eBill_Data_Dept->Enabled = chbBill_Data->Checked;
      eBill_Data_Dept->Color = chbBill_Data->Checked?clWindow:clMenu;
   }
   if(Sender==(TObject*)chbCurr_Data){
      eCurr_Data_Dept->Enabled = chbCurr_Data->Checked;
      eCurr_Data_Dept->Color = chbCurr_Data->Checked?clWindow:clMenu;
   }
   if(Sender==(TObject*)cbMainChannel)
    eCycle_Tout->Enabled=(cbMainChannel->ItemIndex<1);
   if (tvChannelsList->Selected && Sender==(TObject*)cbProtocol_id && cbProtocol_id->ItemIndex!=-1)
   {
     if ((long)cbProtocol_id->Items->Objects[cbProtocol_id->ItemIndex] == 37)
       cbBlockingTime->Caption = "Ручная &загрузка макетов";
     else
       cbBlockingTime->Caption = "Блокировка коррекции &времени";
   }
}
//---------------------------------------------------------------------------
void __fastcall TfmEditRequestPlan::vNew(TObject* Sender)
{
   bool b=true;
   TTreeNode* TN;
   tvChannelsList->OnChange = NULL;
   tvChannelsList->OnChanging = NULL;
   if(tvChannelsList->Selected) tvChannelsListChanging(tvChannelsList,tvChannelsList->Selected,b);
   if(b){
      stChannel* PChannel = new stChannel;
      ZeroMemory(PChannel, sizeof(stChannel));
      for(long j=0;j<6;j++)
         PChannel->indicator[j] = -1;
      strcpy(PChannel->Name,Reconst_smes26_16.c_str());
      PChannel->editing = 1;
      PChannel->BLOCKING = true;
      PChannel->iConnTimeWait = 40;
      PChannel->CYCLE_TOUT = 1800;
      PChannel->RETRIES = 4;
      PChannel->RETRIES_TOUT = 8;
      TN = tvChannelsList->Items->AddObject(tvChannelsList->Selected, PChannel->Name, PChannel);
      TN->ImageIndex = 11;
      TN->SelectedIndex = 11;
      TN->Selected = true;
      EditRec = true;
      if(Access==accWrite)
         paEdit->Enabled = true;
      tvChannelsListChange(tvChannelsList,TN);
      eName->SetFocus();
   }
   tvChannelsList->OnChange = tvChannelsListChange;
   tvChannelsList->OnChanging = tvChannelsListChanging;
}
//---------------------------------------------------------------------------
void __fastcall TfmEditRequestPlan::vDelete(TObject* Sender)
{
   if(tvChannelsList->Selected&&Application->MessageBox(AnsiString(Reconst_smes26_17+tvChannelsList->Selected->Text+"?").c_str(), Application->Title.c_str(), MB_YESNO|MB_ICONQUESTION|MB_DEFBUTTON2)==IDYES)
   {
      tvChannelsList->OnChanging = NULL;
      tvChannelsList->OnDeletion = tvChannelsListDeletion;
      tvChannelsList->Selected->Delete();
      tvChannelsList->OnDeletion = NULL;
      tvChannelsList->OnChanging = tvChannelsListChanging;
      if(!tvChannelsList->Selected)
         tvChannelsListChange(tvChannelsList, tvChannelsList->Selected);
      EditRec = true;
   }
}
//---------------------------------------------------------------------------
void __fastcall TfmEditRequestPlan::tvChannelsListDeletion(TObject *Sender,
      TTreeNode *Node)
{
   if(Clipboard()->GetAsHandle(CF_CHANNELS_TREENODE)==(unsigned int)Node)
      Clipboard()->Clear();
   if(Node && Node->Data && ((stChannel*)Node->Data)->editing!=1)
   {
      Points_Del_Count++;
      if(!nPoints_Del)
         nPoints_Del = new long[1];
      else
         nPoints_Del = (long*)realloc(nPoints_Del, (Points_Del_Count*sizeof(long)));
      nPoints_Del[Points_Del_Count-1] = ((stChannel*)Node->Data)->Cid;
   }
}
//---------------------------------------------------------------------------
void __fastcall TfmEditRequestPlan::vRefresh(TObject* Sender)
{
   tvChannelsList->OnChange=NULL;
   tvChannelsList->OnChanging=NULL;
   Screen->Cursor=crHourGlass;
   tvChannelsList->Visible = false;
   tvChannelsList->Items->Clear();
   if(nPoints_Del) delete[] nPoints_Del;
   nPoints_Del = NULL;
   Points_Del_Count = 0;
   GetCombo(cbProtocol_id);
   GetCombo(cbCom_id);
   GetCombo(cbMainChannel);
   cbScan->ItemIndex = OldScanIndex;
   tvChannelsListChange(tvChannelsList,NULL);
   Screen->Cursor=crDefault;
   if(ReadChannelNode(NULL))
      if(tvChannelsList->Items->Count>0){
         tvChannelsList->OnChange = tvChannelsListChange;
         tvChannelsList->Selected = tvChannelsList->Items->Item[0];
      }
   tvChannelsList->Visible=true;
   tvChannelsList->OnChange = tvChannelsListChange;
   tvChannelsList->OnChanging = tvChannelsListChanging;
}
//---------------------------------------------------------------------------
void __fastcall TfmEditRequestPlan::vSave(TObject* Sender)
{
   bool b=true;
   AnsiString sqlWrite =
      "begin \
         if :par1>0 then "+SchemeName+"channels_pg.upd_p(:par1,:par25,:par2,:par3,:par4,:par5,:par6,:par7,:par8,:par9,:par10,:par11,:par12,:par13,:par14,:par15,:par16,:par17,:par18,to_date(:par19, 'hh24:mi'),to_date(:par20, 'hh24:mi'),:par21,:par22,:par23,:par24,:par27,:par28,:par29,:par30); \
         else "+SchemeName+"channels_pg.ins_p(:par26,:par25,:par2,:par3,:par4,:par5,:par6,:par7,:par8,:par9,:par10,:par11,:par12,:par13,:par14,:par15,:par16,:par17,:par18,to_date(:par19, 'hh24:mi'),to_date(:par20, 'hh24:mi'),:par21,:par22,:par23,:par24,:par27,:par28,:par29,:par30,:par1); \
         end if; \
      end;";
   AnsiString sqlDel = "begin "+SchemeName+"channels_pg.del_p(:par1); end;";
   if(tvChannelsList->Selected) tvChannelsListChanging(tvChannelsList,tvChannelsList->Selected,b);
   if(!b) return;
   TTreeNode *Node=NULL;
   stChannel Channel;
   short indic[6];
   long parent;
   long ischanel;
   try{
      oqEditReqPlan->Params->Clear();
      oqEditReqPlan->SQL->Text=sqlWrite;
      Node = tvChannelsList->Items->GetFirstNode();
      while(Node)
      {
         if(Node->Data && ((stChannel*)Node->Data)->editing>0)
         {
            stChannel*src = (stChannel*)Node->Data;
            memcpy(&Channel, src, sizeof(stChannel));
            memcpy(&indic,src->indicator,sizeof(indic));
            if(Node->Parent && Node->Parent->Data)
               parent = ((stChannel*)Node->Parent->Data)->editing?
                  ((stChannel*)Node->Parent->Data)->tmpCid:
                  ((stChannel*)Node->Parent->Data)->Cid;
           // else parent = 0;
            else parent=nsrv;
            ischanel = IsChannel(Node)?1:0;

            oqEditReqPlan->ParamByName("par1")->ParamType=ptInputOutput;
            oqEditReqPlan->ParamByName("par1")->DataType=ftInteger;
            oqEditReqPlan->ParamByName("par1")->AsInteger=Channel.Cid;
            oqEditReqPlan->ParamByName("par2")->AsString=Channel.Name;
            oqEditReqPlan->ParamByName("par3")->AsString=Channel.Note;
            oqEditReqPlan->ParamByName("par4")->AsInteger=Channel.PROTOCOL_ID;
            oqEditReqPlan->ParamByName("par5")->AsInteger=Channel.COM_ID;
            oqEditReqPlan->ParamByName("par6")->AsString=Channel.INIT_STR;
            oqEditReqPlan->ParamByName("par7")->AsString=Channel.ADDR;
            oqEditReqPlan->ParamByName("par8")->AsInteger=Channel.CYCLE_TOUT;
            oqEditReqPlan->ParamByName("par9")->AsInteger=Channel.RETRIES;
            oqEditReqPlan->ParamByName("par10")->AsInteger=Channel.RETRIES_TOUT;
            oqEditReqPlan->ParamByName("par11")->AsInteger=Channel.BLOCKING;
            oqEditReqPlan->ParamByName("par12")->AsString=Channel.Caller_Name;
            oqEditReqPlan->ParamByName("par13")->AsInteger=Channel.NBILLDATA;

            if(indic[0]>-1)
               oqEditReqPlan->ParamByName("par14")->AsInteger=Channel.NBILLDATADEPTH;
            else oqEditReqPlan->ParamByName("par14")->Clear();
            oqEditReqPlan->ParamByName("par15")->AsInteger=Channel.NCURRDATA;
            if(indic[1]>-1)
               oqEditReqPlan->ParamByName("par16")->AsInteger=Channel.NCURRDATADEPTH;
            else oqEditReqPlan->ParamByName("par16")->Clear();
            oqEditReqPlan->ParamByName("par17")->AsInteger=Channel.NNETPARAM;
            oqEditReqPlan->ParamByName("par18")->AsInteger=Channel.NJOURNAL;
            if(indic[2]>-1)
               oqEditReqPlan->ParamByName("par19")->AsString=Channel.DSTART;
            else oqEditReqPlan->ParamByName("par19")->Clear();
            if(indic[3]>-1)
               oqEditReqPlan->ParamByName("par20")->AsString=Channel.DEND;
            else oqEditReqPlan->ParamByName("par20")->Clear();
            if(indic[4]>-1)
               oqEditReqPlan->ParamByName("par21")->AsInteger=Channel.NDAY;
            else oqEditReqPlan->ParamByName("par21")->Clear();
            if(indic[5]>-1)
               oqEditReqPlan->ParamByName("par22")->AsInteger=Channel.NPARENT;
            else oqEditReqPlan->ParamByName("par22")->Clear();   
            oqEditReqPlan->ParamByName("par23")->AsInteger=Channel.NREADCUR;
            oqEditReqPlan->ParamByName("par24")->AsInteger=Channel.iConnTimeWait;
            oqEditReqPlan->ParamByName("par25")->AsInteger=parent;
            oqEditReqPlan->ParamByName("par26")->AsInteger=ischanel;
            oqEditReqPlan->ParamByName("par27")->AsString=Channel.eUsdName;
            oqEditReqPlan->ParamByName("par28")->AsString=Channel.eUsdPassword;
            oqEditReqPlan->ParamByName("par29")->AsInteger=Channel.LOCKCORRECTTIME;
            oqEditReqPlan->ParamByName("par30")->AsString=Channel.DopParam;
           // oqEditReqPlan->ParamByName("par30")->AsInteger=(int)cbScan->Items->Objects[cbScan->ItemIndex];
            oqEditReqPlan->Execute();
          if(Channel.editingperiod)  SaveP(Node);

             Channel.Cid=oqEditReqPlan->ParamByName("par1")->AsInteger;
            ((stChannel*)Node->Data)->tmpCid = Channel.Cid;
         }
         Node = Node->GetNext();
      }
      oqEditReqPlan->Params->Clear();
      oqEditReqPlan->SQL->Text=sqlDel;

      for(int i=0; nPoints_Del&&i<Points_Del_Count; i++)
      {
         Channel.Cid = nPoints_Del[i];
         oqEditReqPlan->ParamByName("par1")->AsInteger=Channel.Cid;
         oqEditReqPlan->Execute();
      }
      dmMain->orases->Commit();
      if(nPoints_Del) delete[] nPoints_Del;
      nPoints_Del = NULL;
      Points_Del_Count = 0;
      Node = tvChannelsList->Items->GetFirstNode();
      while(Node)
      {
         if(!Node->Data){
            Node=Node->GetNext();
            continue;
         }
         if(((stChannel*)Node->Data)->editing>0)
         {
            ((stChannel*)Node->Data)->editing=0;
            ((stChannel*)Node->Data)->Cid=((stChannel*)Node->Data)->tmpCid;
         }
         Node=Node->GetNext();
      }
      long ind = cbMainChannel->ItemIndex<0?-1:(long)cbMainChannel->Items->Objects[cbMainChannel->ItemIndex];
      GetCombo(cbMainChannel);
      cbMainChannel->ItemIndex = ind<0?-1:cbMainChannel->Items->IndexOfObject((TObject*)ind);
      EditRec = false;

   }
   catch (Exception &exception)
   {
      dmMain->orases->Rollback();
      Application->ShowException(&exception);
      if(Node) tvChannelsList->Selected=Node;
   }
}
//---------------------------------------------------------------------------
void __fastcall TfmEditRequestPlan::SaveP(TTreeNode* sNode)
{
     ChIntr *PTreeTable;

     oqSaveP->Params->Clear();
     oqSaveP->SQL->Text="begin "+SchemeName+"channels_pg.delchaninterval(:par1);end;";
     oqSaveP->ParamByName("par1")->AsInteger=((stChannel*)sNode->Data)->Cid;
      oqSaveP->Execute();


      oqSaveP->Params->Clear();
      oqSaveP->SQL->Text="begin "+SchemeName+"channels_pg.inschaninterval(:par1,:par2,:par3,:par4,:par5,:par6);end;";
     //  SelChannel = (stChannel*)tvChannelsList->Selected->Data;

       stChannel*p = (stChannel*)sNode->Data;
     //  memcpy(&Channel, p, sizeof(stChannel));
       TList *ls=p->lsdopperiod;
        for(int i=0;i<ls->Count;i++){

          PTreeTable=(ChIntr*)ls->Items[i];
        //  if ((double)PTreeTable->fromTime>0.0&&(double)PTreeTable->fromTime>0.0){
          oqSaveP->ParamByName("par1")->AsInteger=((stChannel*)sNode->Data)->Cid;
          oqSaveP->ParamByName("par2")->AsDateTime=(int)Now()+PTreeTable->fromTime;
          oqSaveP->ParamByName("par3")->AsDateTime=(int)Now()+PTreeTable->tillTime;
          oqSaveP->ParamByName("par4")->AsInteger=PTreeTable->NetParam;
          oqSaveP->ParamByName("par5")->AsInteger=PTreeTable->Journal;
          oqSaveP->ParamByName("par6")->AsInteger=PTreeTable->NotReadCurr;

          oqSaveP->Execute();
         // }
        }
     p->editingperiod=0;
    oqSaveP->Session->Commit();
}
//------------------------------------------------------------------------------
void __fastcall TfmEditRequestPlan::edLongPress(TObject *Sender,
      char &Key)
{
#define Sender ((TEdit*)Sender)
  AnsiString S=(AnsiString)Key;
  AnsiString S1="0123456789\b\r";
  if(!S1.Pos(S)){
    Key=NULL;
    Beep();
    return;
  }
#undef Sender
}
//---------------------------------------------------------------------------
void __fastcall TfmEditRequestPlan::vPoints(TObject* Sender)
{
   if(SelChannel&&SelChannel->Cid>0)
   {
      TfmChannelPointsList *fmChannelPointsList = new TfmChannelPointsList(this, SelChannel->Cid,SelChannel->PROTOCOL_ID, Access);
      fmChannelPointsList->Caption = fmChannelPointsList->Caption+Reconst_smes26_18+tvChannelsList->Selected->Text+")";
      fmChannelPointsList->ShowModal();
      delete fmChannelPointsList;
   }
   else if(EditRec) throw Exception(Reconst_smes26_19);
}
//---------------------------------------------------------------------------
void __fastcall TfmEditRequestPlan::vBlock(TObject* Sender)
{
   bool ac = true;
   tvChannelsListChanging(this, tvChannelsList->Selected, ac);
   ac = false;
   TTreeNode *treeNode = tvChannelsList->Items->GetFirstNode();
   while(treeNode)
   {
      stChannel *cannel = (stChannel *)treeNode->Data;
      if(cannel && !cannel->BLOCKING){
         switch(treeNode->ImageIndex){
         case 4:
            treeNode->ImageIndex = 23;
            treeNode->SelectedIndex = 23;
            break;
         case 5:
            treeNode->ImageIndex = 22;
            treeNode->SelectedIndex = 22;
            break;
         case 9:
            treeNode->ImageIndex = 11;
            treeNode->SelectedIndex = 11;
            break;
         case 10:
            treeNode->ImageIndex = 12;
            treeNode->SelectedIndex = 12;
            break;
         }
         cannel->BLOCKING = true;
         cannel->editing = 1;
         ac = true;
      }
      treeNode = treeNode->getNextSibling();
   }
   if(ac) EditRec = true;
   tvChannelsListChange(this, tvChannelsList->Selected);
}
//---------------------------------------------------------------------------
void __fastcall TfmEditRequestPlan::vUnblock(TObject* Sender)
{
   bool ac = true;
   tvChannelsListChanging(this, tvChannelsList->Selected, ac);
   TTreeNode *treeNode = tvChannelsList->Items->GetFirstNode();
   ac = false;
   while(treeNode)
   {
      stChannel *cannel = (stChannel *)treeNode->Data;
      if(cannel && cannel->BLOCKING){
         switch(treeNode->ImageIndex){
         case 23:
            treeNode->ImageIndex = 4;
            treeNode->SelectedIndex = 4;
            break;
         case 22:
            treeNode->ImageIndex = 5;
            treeNode->SelectedIndex = 5;
            break;
         case 11:
            treeNode->ImageIndex = 9;
            treeNode->SelectedIndex = 9;
            break;
         case 12:
            treeNode->ImageIndex = 10;
            treeNode->SelectedIndex = 10;
            break;
         }
         cannel->BLOCKING = false;
         cannel->editing = 1;
         ac = true;
      }
      treeNode = treeNode->getNextSibling();
   }
   if(ac) EditRec = true;
   tvChannelsListChange(this, tvChannelsList->Selected);
}
//---------------------------------------------------------------------------
void __fastcall TfmEditRequestPlan::SetAccess(TAccess value)
{
    if(FAccess != value) {
        TMainForm::SetAccess(value);
        bool wr = value==accWrite;
        iaNew->Enabled = wr;
        aNewGroup->Enabled = wr;
        iaDelete->Enabled = wr;
        iaClone->Enabled = IsChannel(tvChannelsList->Selected)?wr:false;
        aState->Enabled = iaClone->Enabled;
        aQuick->Enabled = iaClone->Enabled;
        iaBlock->Enabled = wr;
        iaUnblock->Enabled = wr;
        paEdit->Enabled = wr;
        // выключение реакции системы на изменение содержимого поля
        // на время изменения свойства PasswordChar
        TNotifyEvent change = eUsdPassword->OnChange;
        eUsdPassword->OnChange = NULL;
        eUsdPassword->PasswordChar = wr?0:'*';
        eUsdPassword->OnChange = change;
        // обновление для содержимого PasswordChar
//        if(wr) vRefresh(this);
    }
}
//---------------------------------------------------------------------------
void __fastcall TfmEditRequestPlan::vClone(TObject* Sender)
{
   bool b=true;
   TTreeNode* TN;
   tvChannelsList->OnChange = NULL;
   tvChannelsList->OnChanging = NULL;
   if(tvChannelsList->Selected)
      tvChannelsListChanging(tvChannelsList,tvChannelsList->Selected,b);
   if(b){
      stChannel* POldChannel = (stChannel *)tvChannelsList->Selected->Data;
      stChannel* PChannel = new stChannel;
      memcpy(PChannel,POldChannel,sizeof(stChannel));
      strcpy(PChannel->Name,Reconst_smes26_20.c_str());
      PChannel->tmpCid=0;
      PChannel->Cid=0;
      PChannel->editing = 1;
      TN = tvChannelsList->Items->AddObject(tvChannelsList->Selected, PChannel->Name, PChannel);
      TN->ImageIndex = tvChannelsList->Selected->ImageIndex;
      TN->SelectedIndex = TN->ImageIndex;
      TN->Selected = true;
      EditRec = true;
      if(Access==accWrite)
         paEdit->Enabled = true;
      tvChannelsListChange(tvChannelsList,TN);
      eName->SetFocus();
   }
   tvChannelsList->OnChange = tvChannelsListChange;
   tvChannelsList->OnChanging = tvChannelsListChanging;
}
//---------------------------------------------------------------------------
void __fastcall TfmEditRequestPlan::aExecute(TObject *Sender)
{
   if(Sender==aBlocking)
      chbBlocking->Checked=!chbBlocking->Checked;
   else if(Sender==aBillData)
      chbBill_Data->Checked=!chbBill_Data->Checked;
   else if(Sender==aCurrData)
      chbCurr_Data->Checked=!chbCurr_Data->Checked;
   else if(Sender==aNetParam)
      chbNet_Param->Checked=!chbNet_Param->Checked;
   else if(Sender==aJournal)
      chbJournal->Checked=!chbJournal->Checked;
   else if(Sender==aNReadCurr)
      chbNReadCurr->Checked=!chbNReadCurr->Checked;
   else if(Sender==aNLockCorrectTime)
      cbBlockingTime->Checked=!cbBlockingTime->Checked;
}
//---------------------------------------------------------------------------
void __fastcall TfmEditRequestPlan::tvChannelsListExpColl(
      TObject *Sender, TTreeNode *Node)
{
   if(!Node || !Node->Data) return;

   if(tvChannelsList->Selected==Node ? chbBlocking->Checked : ((stChannel*)Node->Data)->BLOCKING)
   {
      Node->ImageIndex = Node->Expanded?22:23;
      Node->SelectedIndex = Node->Expanded?22:23;
   }else{
      Node->ImageIndex = Node->Expanded?5:4;
      Node->SelectedIndex = Node->Expanded?5:4;
   }
}
//---------------------------------------------------------------------------
void __fastcall TfmEditRequestPlan::tvChannelsListExpanding(
      TObject *Sender, TTreeNode *Node, bool &AllowExpansion)
{
   if(!Node || !Node->Data) return;
   TTreeNode*cn = Node->getFirstChild();
   if(!cn || !cn->Data)
      if(!ReadChannelNode(Node))
         throw Exception(Reconst_smes26_21);
}
//---------------------------------------------------------------------------
void __fastcall TfmEditRequestPlan::tvChannelsListDragOver(TObject *Sender,
      TObject *Source, int X, int Y, TDragState State, bool &Accept)
{
   TTreeNode*dst = ((TTreeView*)Sender)->GetNodeAt(X, Y);
   TTreeNode*src = ((TTreeView*)Source)->Selected;
   Accept = dst?
      AcceptNode(dst, src):
      Accept = PtInRect(&(((TTreeView*)Sender)->ClientRect), TPoint(X,Y));
}
//---------------------------------------------------------------------------
bool __fastcall TfmEditRequestPlan::AcceptNode(TTreeNode*accNode,TTreeNode*srcNode)
{
   if(Access!=accWrite)
      return false;
   if(accNode==srcNode ||
      accNode==srcNode->Parent ||
      accNode->HasAsParent(srcNode))
      return false;
   return !IsChannel(accNode);
}
//---------------------------------------------------------------------------
void __fastcall TfmEditRequestPlan::tvChannelsListDragDrop(TObject *Sender,
      TObject *Source, int X, int Y)
{
   TTreeNode*Dst = ((TTreeView*)Sender)->GetNodeAt(X, Y);
   TTreeNode*Src = ((TTreeView*)Source)->Selected;
   if(!Src || !Src->Data)
      throw Exception(Reconst_smes26_22);
   Src->Cut = !(GetKeyState(VK_CONTROL)&0x8000);
   changeNode(Dst, Src);
}
//---------------------------------------------------------------------------
void __fastcall TfmEditRequestPlan::aNewGroupExecute(TObject *Sender)
{
   bool b=true;
   TTreeNode* TN;

   tvChannelsList->OnChange = NULL;
   tvChannelsList->OnChanging = NULL;
   if(tvChannelsList->Selected) tvChannelsListChanging(tvChannelsList,tvChannelsList->Selected,b);
   if(b){
      stChannel* PChannel = new stChannel;
      ZeroMemory(PChannel, sizeof(stChannel));
      for(long j=0;j<6;j++)
         PChannel->indicator[j] = -1;
      strcpy(PChannel->Name,Reconst_smes26_23.c_str());
      PChannel->editing = 1;
      TN = tvChannelsList->Items->AddObject(tvChannelsList->Selected, PChannel->Name, PChannel);
      TN->ImageIndex = 4;
      TN->SelectedIndex = 4;
      TN->Selected = true;
      EditRec = true;
      if(Access==accWrite)
         paEdit->Enabled = true;
      tvChannelsListChange(tvChannelsList,TN);
      eName->SetFocus();
   }
   tvChannelsList->OnChange = tvChannelsListChange;
   tvChannelsList->OnChanging = tvChannelsListChanging;
}
//---------------------------------------------------------------------------
bool __fastcall TfmEditRequestPlan::IsChannel(TTreeNode*tn)
{
   if(tn)
   switch(tn->ImageIndex){
   case 4: case 5: case 22: case 23:
      return false;
   }
   return true;
}
//---------------------------------------------------------------------------
void __fastcall TfmEditRequestPlan::vEditClick(TObject*Sender)
{
   TTreeNode*tn;
   if(ActiveControl==tvChannelsList){
      mnPaste->Enabled = Clipboard()->HasFormat(CF_CHANNELS_TREENODE);
      mnCut->Enabled = tvChannelsList->Selected;
      mnCopy->Enabled = tvChannelsList->Selected;
      mnDelete->Enabled = tvChannelsList->Selected;
      mnSelect->Enabled = false;
   }else
      TMainForm::vEditClick(Sender);
}
//---------------------------------------------------------------------------
void __fastcall TfmEditRequestPlan::vAnyEditClick(TObject*Sender)
{
   TTreeNode*selNode;
   TTreeView*tvControl = dynamic_cast<TTreeView*>(ActiveControl);
   TComponent *pMenu=dynamic_cast<TComponent*>(Sender);

   if(tvControl)
   try{
      if(pMenu)
         switch (pMenu->Tag){
         case 1: // Cut
            if(Clipboard()->HasFormat(CF_CHANNELS_TREENODE))
               ((TTreeNode*)Clipboard()->GetAsHandle(CF_CHANNELS_TREENODE))->Cut = false;
            tvChannelsList->Selected->Cut = true;
            Clipboard()->SetAsHandle(CF_CHANNELS_TREENODE, (UINT)tvControl->Selected);
            break;
         case 2: // Copy
            if(Clipboard()->HasFormat(CF_CHANNELS_TREENODE))
               ((TTreeNode*)Clipboard()->GetAsHandle(CF_CHANNELS_TREENODE))->Cut = false;
            Clipboard()->SetAsHandle(CF_CHANNELS_TREENODE, (UINT)tvControl->Selected);
            break;
         case 3: // Paste
            selNode = (TTreeNode*)Clipboard()->GetAsHandle(CF_CHANNELS_TREENODE);
            if(!selNode)
               break;
            if(selNode->Cut) Clipboard()->Clear();
            if(AcceptNode(tvControl->Selected, selNode))
               changeNode(tvControl->Selected, selNode);
            else{
               selNode->Cut = false;
               MessageBox(this->Handle, Reconst_smes26_24.c_str(),
                  Caption.c_str(), MB_OK|MB_ICONINFORMATION);
            }
            break;
         case 4: // Delete
            vDelete(Sender);
            break;
         case 5:
            break;
         default : return;
         }
   }catch(Exception &e){
   }
   else
      TMainForm::vAnyEditClick(Sender);
   selNode = NULL;
}
//---------------------------------------------------------------------------
void __fastcall TfmEditRequestPlan::changeNode(TTreeNode*Dst, TTreeNode*Src)
{
   TTreeNode*newNode;

   if(!Src || !Src->Data) return;
   if(Dst && Dst->getFirstChild() && !Dst->getFirstChild()->Data)
      ReadChannelNode(Dst);
   if(Src->Cut){ // Move
      Src->MoveTo(Dst, naAddChild);
      ((stChannel*)Src->Data)->editing = 2;
   }else{// Copy
      stChannel* pChnl = new stChannel();
      memcpy(pChnl, Src->Data, sizeof(stChannel));
      pChnl->Cid = pChnl->tmpCid = 0;
      newNode = tvChannelsList->Items->AddChildObject(Dst, Src->Text, pChnl);
      newNode->ImageIndex = Src->ImageIndex;
      newNode->SelectedIndex = Src->SelectedIndex;
      ((stChannel*)newNode->Data)->editing = 1;
      if(Src->HasChildren)
         copyChildNodes(newNode, Src);
   }
   EditRec = true;
}
//---------------------------------------------------------------------------
void __fastcall TfmEditRequestPlan::copyChildNodes(TTreeNode*d, TTreeNode*s)
{
   ReadChannelNode(s);
   TTreeNode *tn = s->getFirstChild();
   while(tn){
      changeNode(d, tn);
      tn = tn->getNextSibling();
   }
}
//---------------------------------------------------------------------------
void __fastcall TfmEditRequestPlan::tvChannelsListMouseDown(
      TObject *Sender, TMouseButton Button, TShiftState Shift, int X,
      int Y)
{
   if(Button==mbRight) tvChannelsList->Selected = tvChannelsList->GetNodeAt(X, Y);
}
//---------------------------------------------------------------------------
void __fastcall TfmEditRequestPlan::aMExecute(TObject *Sender)
{
   TTreeNode*ptn;
   TAction*pa = dynamic_cast<TAction*>(Sender);

   if(pa){
      ptn = tvChannelsList->Selected;
      switch(pa->Tag){
      case 1:// Alt+Left
         if(ptn->Expanded)
            ptn->Collapse(false);
         else if(ptn->Parent)
            tvChannelsList->Selected = ptn->Parent;
         break;
      case 2:// Alt+Right
         if(!ptn->Expanded)
            ptn->Expand(false);
         else if(ptn->HasChildren)
            tvChannelsList->Selected = ptn->getFirstChild();
         break;
      case 3:// Alt+Up
         ptn = tvChannelsList->Selected->GetPrevVisible();
         if(ptn) tvChannelsList->Selected = ptn;
         break;
      case 4:// Alt+Down
         ptn = tvChannelsList->Selected->GetNextVisible();
         if(ptn) tvChannelsList->Selected = ptn;
         break;
      }
   }
}
//---------------------------------------------------------------------------
void __fastcall TfmEditRequestPlan::aStateExecute(TObject *Sender)
{
  TLastSaveForm *lsF = new TLastSaveForm(this,tvChannelsList->Selected->Text.c_str(),((stChannel*)tvChannelsList->Selected->Data)->Cid,Access);
  lsF->ShowModal();
  delete lsF;
}
//---------------------------------------------------------------------------
void __fastcall TfmEditRequestPlan::aQuickExecute(TObject *Sender)
{
  TfmOperScanSchedEd* f=NULL;
  AnsiString sql;
  try{
   if(SelChannel&&SelChannel->Cid>0){
     if(IsOperStart(SelChannel->Cid)){ //Оперативный опрос запущен и мы останавливаем
        if(Application->MessageBox(AnsiString(Reconst_smes26_25).c_str(), Application->Title.c_str(), MB_YESNO|MB_ICONQUESTION|MB_DEFBUTTON1)==IDYES){
          oqEditReqPlan->SQL->Text=AnsiString("begin "+SchemeName+"operscan_pg.deactive_p(")+IntToStr(SelChannel->Cid)+AnsiString("); commit; end;");
          oqEditReqPlan->Execute();

        }
     }else{//Запускаем оперативный опрос
       f= new TfmOperScanSchedEd(this);
       f->edPeriod->Text = SelChannel->CYCLE_TOUT;
       f->MEdEnd->Text = TDateTime(Now()+ 1.0/24.0).FormatString("hh:nn");
       if(f->ShowModal()==mrOk){
        oqEditReqPlan->Params->Clear();
        oqEditReqPlan->SQL->Text=AnsiString("begin "+SchemeName+"operscan_pg.active_p(")+IntToStr(SelChannel->Cid)+
                      AnsiString(",to_date('"+f->MEdEnd->Text+"','hh24:mi'),")+f->edPeriod->Text+
                      AnsiString("); commit; end;");

        oqEditReqPlan->Execute();
       }
      delete f;
      f=NULL;
     }
   }else
      if(EditRec)
        throw Exception(Reconst_smes26_26);
  }catch(Exception &e){
    if(f)
      delete f;
    dmMain->orases->Rollback();
    throw;
  }
}
//---------------------------------------------------------------------------
bool __fastcall TfmEditRequestPlan::IsOperStart(long cid)
{
   oqEditReqPlan->Params->Clear();
   oqEditReqPlan->SQL->Text="begin "+SchemeName+"channels_pg.IsOperStart(:par1,:par2); end;";
   oqEditReqPlan->ParamByName("par2")->ParamType = ptOutput;
   oqEditReqPlan->ParamByName("par2")->DataType = ftCursor;
   oqEditReqPlan->ParamByName("par1")->AsInteger=cid;
   oqEditReqPlan->Execute();
   return oqEditReqPlan->FieldByName("cn")->AsInteger;
}
//---------------------------------------------------------------------------
// add by NNV
void __fastcall TfmEditRequestPlan::mMonClick(TObject *Sender)
{
  SetPopupMenu( Sender, SelChannel->Cid, SelChannel->Name);
}
//end add by NNV
//---------------------------------------------------------------------------

void __fastcall TfmEditRequestPlan::iaFindExecute(TObject *Sender)
{
  //GRB ADD 09.03.2021 -добавляем вызов 2-х сеттеров, определяющих контекст задачи
 fmFP->setContext(2);
 fmFP->setGroupsAndPoints(false);
 //end add
  fmFP->ShowModal();
}
//---------------------------------------------------------------------------

void __fastcall TfmEditRequestPlan::WM_SetActiveNode(TMessage& Message)
{
//  FindNode(tvChannelsList, Message.LParam, ReadChannelNode, getNodeId,("begin "+SchemeName+"un_main_pg.find_chanel_node(:par1,:par2); end;").c_str());
  FindNode(tvChannelsList, Message.LParam, ReadChannelNode, getNodeId);
}
//---------------------------------------------------------------------------
void __fastcall TfmEditRequestPlan::iaMTXExecute(TObject *Sender)
{
  TfmMTX::fmMTXShow(this);
}
//---------------------------------------------------------------------------
void __fastcall TfmEditRequestPlan::iaRTR56Execute(TObject *Sender)
{
  TfmRTRNP::fmRTRNPShow(this);
}
//---------------------------------------------------------------------------

void __fastcall TfmEditRequestPlan::btAddParamClick(TObject *Sender)
{

    TTreeNode *sNode=tvChannelsList->Selected;
    if(!sNode||!sNode->Data)
        return;
     stChannel *PChannel=(stChannel*)sNode->Data;


    if(!PChannel->lsdopperiod){
            PChannel->lsdopperiod = new TList();
            oqEditReqPlan->Params->Clear();
            oqEditReqPlan->SQL->Text="begin "+SchemeName+"channels_pg.get_dopperiod(:par1,:par2); end;";
            oqEditReqPlan->ParamByName("par2")->ParamType = ptOutput;
            oqEditReqPlan->ParamByName("par2")->DataType = ftCursor;
            oqEditReqPlan->ParamByName("par1")->AsInteger= PChannel->Cid;
            oqEditReqPlan->Execute();
            while(!oqEditReqPlan->Eof){
            ChIntr *p=new ChIntr;
            ZeroMemory(p,sizeof(ChIntr));
            p->fromTime=oqEditReqPlan->FieldByName("dstart")->AsDateTime;
            p->tillTime=oqEditReqPlan->FieldByName("dend")->AsDateTime;
            p->NetParam=oqEditReqPlan->FieldByName("nnetparam")->AsInteger;
            p->Journal=oqEditReqPlan->FieldByName("njournal")->AsInteger;
            p->NotReadCurr=oqEditReqPlan->FieldByName("nnotreadcurr")->AsInteger;
            PChannel->lsdopperiod->Add(p);
            oqEditReqPlan->Next();
           }

        PChannel->lsdopperiod->Capacity=PChannel->lsdopperiod->Count;
   }

  
    TfmChInter *f=new TfmChInter(this,PChannel->lsdopperiod,true);

    if(f->ShowModal()==mrOk)
     {
        PChannel->editing=1;
        PChannel->editingperiod=1;
        EditRec = true;
     }
    delete f;
}
//---------------------------------------------------------------------------
void __fastcall TfmEditRequestPlan::iaRTRExecute(TObject *Sender)
{
  TTreeNode *sNode=tvChannelsList->Selected;
  if(!sNode||!sNode->Data||!((stChannel*)sNode->Data)->Cid)
    return;

  TfmRTRNIK::fmRTRNIKShow(this,((stChannel*)sNode->Data)->Cid);
}
//---------------------------------------------------------------------------
bool __fastcall TfmEditRequestPlan::IsRTR(long prot_id)
{
  return (prot_id==1012);
}
//---------------------------------------------------------------------------

