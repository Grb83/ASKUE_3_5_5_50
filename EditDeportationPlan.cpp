//---------------------------------------------------------------------------
#include <vcl.h>
#include <stdio.h>
#include <System.hpp>
#pragma hdrstop
#include "EditDeportationPlan.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma resource "*.dfm"
//---------------------------------------------------------------------------
__fastcall TfmEditDeportationPlan::TfmEditDeportationPlan(TComponent* Owner, AnsiString Name, TAccess a)
  : TMainForm(Owner, Name, a),ChangeControl(true),is_changing(false)
{
  if(GetCombo(cbProc_id)&&GetCombo(cbMainChannel)&&ReadChannels(NULL))
  {
    tvChannelsList->OnChange = tvChannelsListChange;
    if(tvChannelsList->Items->Count)
       tvChannelsList->Selected = tvChannelsList->Items->Item[0];
    tvChannelsList->OnChanging = tvChannelsListChanging;
    Width = Width-1;
    Height = Height-1;
  }else
    Close();
  iaNew->Visible = true;
  iaDelete->Visible = true;
  iaClone->Visible = true;
  nChannels_Del = NULL;
  Channels_Del_Count = 0;
  aNewGroup->Enabled = true;
  fmFP = new TfmFindPoint(this);
  iaFind->OnExecute = iaFindExecute;
  iaFind->Enabled = true;
  ShowAction(iaFind);
}
//---------------------------------------------------------------------------

__fastcall TfmEditDeportationPlan::~TfmEditDeportationPlan()
{
  delete fmFP;
}
//---------------------------------------------------------------------------

bool __fastcall TfmEditDeportationPlan::ReadChannels(TObject*obj)// Читает список каналов
{
  stChannel *PChannel = NULL;
  TTreeNode *TN = NULL;
  TTreeNode *Node = (TTreeNode*)obj;
  try
  {
    dmMain->quMain->Params->Clear();
    dmMain->quMain->SQL->Text = "begin " + SchemeName + "DEPORTATION_PG.getdepchannelstree(:par1, :par2); end;";
    if(!Node)
    { dmMain->quMain->ParamByName("par1")->Clear();
      dmMain->quMain->ParamByName("par2")->ParamType = ptOutput;
      dmMain->quMain->ParamByName("par2")->DataType = ftCursor;
      dmMain->quMain->Execute();
    }
    else //вызывается при Expanding
    { dmMain->quMain->ParamByName("par1")->AsInteger = getNodeId(obj);
      dmMain->quMain->ParamByName("par2")->ParamType = ptOutput;
      dmMain->quMain->ParamByName("par2")->DataType = ftCursor;
      dmMain->quMain->Execute();
      Node->DeleteChildren();
    }
    while(!dmMain->quMain->Eof)
    {
     PChannel= new stChannel;
     ZeroMemory(PChannel,sizeof(stChannel));
     PChannel->NDeportation = dmMain->quMain->FieldByName("MID")->AsInteger;

      strcpy(PChannel->Name,dmMain->quMain->FieldByName("VNAME")->AsString.c_str());
      if(!dmMain->quMain->FieldByName("VNOTE")->IsNull)
      strcpy(PChannel->Note,dmMain->quMain->FieldByName("VNOTE")->AsString.c_str());
      if(!dmMain->quMain->FieldByName("NMAKET")->IsNull)
      { PChannel->indicator[0]=0;
        PChannel->Proc_id=dmMain->quMain->FieldByName("NMAKET")->AsInteger;
      }
      else
        PChannel->indicator[0]=-1;
      PChannel->DataDeportationMode=dmMain->quMain->FieldByName("NTYPE")->AsInteger;
      strcpy(PChannel->Address,dmMain->quMain->FieldByName("VADDRESS")->AsString.c_str());
      if(!dmMain->quMain->FieldByName("NPARENT")->IsNull)
      { PChannel->indicator[1]=0;
        PChannel->Parent=dmMain->quMain->FieldByName("NPARENT")->AsInteger;
      }
      else
        PChannel->indicator[1]=-1;
      if(!dmMain->quMain->FieldByName("DFROM")->IsNull)
      { PChannel->indicator[2]=0;
        strcpy(PChannel->From,dmMain->quMain->FieldByName("DFROM")->AsString.c_str());
      }
      else
        PChannel->indicator[2]=-1;
      if(!dmMain->quMain->FieldByName("DTILL")->IsNull)
      { PChannel->indicator[3]=0;
        strcpy(PChannel->Till,dmMain->quMain->FieldByName("DTILL")->AsString.c_str());
      }
      else
        PChannel->indicator[3]=-1;
      PChannel->Retries=dmMain->quMain->FieldByName("NRETRIES")->AsInteger;
      PChannel->Retries_Tout=dmMain->quMain->FieldByName("NRETRIES_TOUT")->AsInteger;
      PChannel->Block=dmMain->quMain->FieldByName("NBLOCK")->AsInteger;
      if(!dmMain->quMain->FieldByName("VPARAM")->IsNull)
        strcpy(PChannel->SendParam,dmMain->quMain->FieldByName("VPARAM")->AsString.c_str());

      TN = tvChannelsList->Items->AddChildObject(Node, PChannel->Name, PChannel);
      PChannel->IsFolder   = (bool)dmMain->quMain->FieldByName("ISFOLDER")->AsInteger;
      PChannel->HaveChilde = (bool)dmMain->quMain->FieldByName("HAVECHILD")->AsInteger;
      //построение папки
      if(PChannel->IsFolder)
      { if(PChannel->HaveChilde)//есть дети
          tvChannelsList->Items->AddChildObject(TN, "1", NULL);
        //нет детей
        TN->ImageIndex = (PChannel->Block)?6:4;
      }
      else
      { if(PChannel->indicator[1]<0)
          TN->ImageIndex = (PChannel->Block)?2:0;
        else
          TN->ImageIndex = (PChannel->Block)?3:1;
      }
      TN->SelectedIndex = TN->ImageIndex;
      dmMain->quMain->Next();
    } //end while
  }//end try
  catch (Exception &exception)
  {
    Application->ShowException(&exception);
    return false;
  }
  return true;
}
//---------------------------------------------------------------------------
bool __fastcall TfmEditDeportationPlan::GetCombo(TComboBox *cb)
{
  try
  {
    cb->Items->Clear();
    dmMain->quMain->Params->Clear();
    dmMain->quMain->SQL->Text="begin " + SchemeName + "DEPORTATION_PG.getList(:Flag, :par1); end;";

    dmMain->quMain->ParamByName("par1")->ParamType = ptOutput;
    dmMain->quMain->ParamByName("par1")->DataType = ftCursor;
    if(cb==cbProc_id)
      dmMain->quMain->ParamByName("Flag")->AsInteger = 0;//Список макетов
    if(cb==cbMainChannel)
    { cb->Items->Add("");
      dmMain->quMain->ParamByName("Flag")->AsInteger = 1;//Список осн. каналов
    }
    dmMain->quMain->Execute();
    while(!dmMain->quMain->Eof)
    {
      cb->Items->AddObject(dmMain->quMain->FieldByName("VNAME")->AsString,
                          (TObject*)dmMain->quMain->FieldByName("NDEPORTATION")->AsInteger);
      dmMain->quMain->Next();
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
void __fastcall TfmEditDeportationPlan::tvChannelsListChanging(TObject *Sender,
      TTreeNode *Node, bool &AllowChange)
{
  if(!(SelChannel->editing == 2)&&!(SelChannel->editing == 1))
    return;
  TWinControl *Control=NULL;
  try{
    Control=(TWinControl*)eName;
    if(eName->Text.IsEmpty())
      throw Exception(Reconst_smes19_1);
    if(SelChannel->IsFolder)//папка
    { //Обновляем данные
      strcpy(SelChannel->Name, eName->Text.c_str());
      SelChannel->Block = chbBlocking->Checked;
    }
    else //каналы
    { strcpy(SelChannel->Name,eName->Text.c_str());
      strcpy(SelChannel->Note,mNote->Text.c_str());
      strcpy(SelChannel->SendParam,eSendParam->Text.c_str());
      if(cbMainChannel->ItemIndex<=0)
      {
         Control=(TWinControl*)cbProc_id;
         if(cbProc_id->ItemIndex<0)
           throw Exception(Reconst_smes19_2);
         SelChannel->Proc_id=(long)cbProc_id->Items->Objects[cbProc_id->ItemIndex];
         SelChannel->indicator[0] = 0;
      }
      else
        SelChannel->indicator[0] = -1;
      SelChannel->DataDeportationMode = rgDataDeportationMode->ItemIndex;
      Control=(TWinControl*)eAddress;
      if(eAddress->Text.IsEmpty())
        throw Exception(Reconst_smes19_3);
      strcpy(SelChannel->Address,eAddress->Text.c_str());
      if(cbMainChannel->ItemIndex>0)
      {
        SelChannel->Parent = (long)cbMainChannel->Items->Objects[cbMainChannel->ItemIndex];
        SelChannel->indicator[1] = 0;
      }
      else
        SelChannel->indicator[1] = -1;

      Control=(TWinControl *)meStart;
      try
      {
            if(meStart->Text == "  :  ")
               SelChannel->indicator[2] = -1;
            else
            {
               StrToTime(meStart->Text);
               strcpy(SelChannel->From, meStart->Text.c_str());
               SelChannel->indicator[2] = 0;
            }
      }
      catch(EConvertError &ECR){throw Exception(Reconst_smes19_4);}

      Control=(TWinControl*)meEnd;
      try
      {
            if(meEnd->Text == "  :  ")
               SelChannel->indicator[3] = -1;
            else
            {
               StrToTime(meEnd->Text);
               strcpy(SelChannel->Till, meEnd->Text.c_str());
               SelChannel->indicator[3] = 0;
            }
      }
      catch(EConvertError &ECR) {throw Exception(Reconst_smes19_5); }
      Control=(TWinControl *)eRetries;
      if(eRetries->Text.IsEmpty()||eRetries->Text.ToInt()<=0)
        throw Exception(Reconst_smes19_6);
      SelChannel->Retries = eRetries->Text.ToInt();
      Control=(TWinControl *)eRetries_Tout;
      if(eRetries_Tout->Text.IsEmpty()||eRetries_Tout->Text.ToInt()<0)
        throw Exception(Reconst_smes19_7);
      SelChannel->Retries_Tout = eRetries_Tout->Text.ToInt();
      SelChannel->Block = chbBlocking->Checked;
    }//end else
  }catch (Exception &exception) {
      AllowChange=false;
      if(Control) Control->SetFocus();
      Application->ShowException(&exception);
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmEditDeportationPlan::tvChannelsListChange(TObject *Sender,
  TTreeNode *Node)
{
  try{
   is_changing=true;
   paEdit->Enabled = ChangeControl = false;
   iaDelete->Enabled = false;
   iaClone->Enabled = false;
   for(int i=0; i<ComponentCount; i++)
   {
      if(dynamic_cast<TCustomEdit*>(Components[i]))
         ((TCustomEdit*)Components[i])->Clear();
      if(dynamic_cast<TComboBox*>(Components[i]))
         ((TComboBox*)Components[i])->ItemIndex = -1;
      if(dynamic_cast<TCheckBox*>(Components[i]))
         ((TCheckBox*)Components[i])->Checked = false;
   }
   lbId->Text = "";
   if(!tvChannelsList->Selected)
      return;
   SelChannel = (stChannel*)tvChannelsList->Selected->Data;

   eName->Text = SelChannel->Name;
   lbId->Text = (SelChannel->NDeportation>0)?IntToStr(SelChannel->NDeportation):AnsiString("");
   chbBlocking->Checked = SelChannel->Block;
   if(!SelChannel->IsFolder)
   { //Канала
     Panel10->Height  = 95;
     Panel24->Visible = true;
     Panel11->Visible = true;
     Label2->Visible  = true;
     mNote->Visible   = true;
     iaClone->Enabled = true;
     mNote->Text = SelChannel->Note;
     eSendParam->Text = SelChannel->SendParam;
     if(SelChannel->indicator[0]<0)
        Panel5->Visible = false;
     else
     {  Panel5->Visible = true;
        cbProc_id->ItemIndex = cbProc_id->Items->IndexOfObject((TObject*)SelChannel->Proc_id);
     }
     eAddress->Text = SelChannel->Address;
     cbMainChannel->ItemIndex = SelChannel->indicator[1]>=0 ? cbMainChannel->Items->IndexOfObject((TObject*)SelChannel->Parent):-1;
     meStart->Text = SelChannel->indicator[2]>=0?SelChannel->From:"  :  ";
     meEnd->Text = SelChannel->indicator[3]>=0?SelChannel->Till:"  :  ";
     eRetries->Text = IntToStr(SelChannel->Retries);
     eRetries_Tout->Text = IntToStr(SelChannel->Retries_Tout);
     rgDataDeportationMode->ItemIndex = SelChannel->DataDeportationMode;
   }//end if
   else//Folder
   { //скрываем все ненужное
     Label2->Visible  = false;
     mNote->Visible   = false;
     Panel11->Visible = false;
     Panel24->Visible = false;
     Panel10->Height  = 63;
     iaClone->Enabled = false;
   }
   if(Access==accWrite)
    paEdit->Enabled = ChangeControl = true;
   bool edRec = EditRec;
   ControlChange(rgDataDeportationMode);
   EditRec = edRec;
   iaDelete->Enabled = true;
  }catch (Exception &exception) {
      Application->ShowException(&exception);
  }
  is_changing=false;
}
//---------------------------------------------------------------------------
void __fastcall TfmEditDeportationPlan::ControlChange(TObject *Sender)
{
   if(tvChannelsList->Selected&&ChangeControl)
   {
      EditRec = true;
      if(!is_changing&&!SelChannel->editing) //     21.05.2013 is_changing добавил Сечин чтоб не сохранялось первый элемент 
        SelChannel->editing=2;
        //SelChannel->editing = SelChannel->editing==1?1:2;
      if(Sender==(TObject*)eName)
         tvChannelsList->Selected->Text=eName->Text;
      if((Sender==(TObject*)cbMainChannel)||(Sender==(TObject*)chbBlocking))
      {
         bool fbl = chbBlocking->Checked;
         if(SelChannel->IsFolder)
            if(tvChannelsList->Selected->Expanded)
              tvChannelsList->Selected->ImageIndex = (fbl)?7:5;
            else
              tvChannelsList->Selected->ImageIndex = (fbl)?6:4;
         else
            tvChannelsList->Selected->ImageIndex = cbMainChannel->ItemIndex<1?(fbl?2:0):(fbl?3:1);
            //tvChannelsList->Selected->SelectedIndex = cbMainChannel->ItemIndex<1?(fbl?2:0):(fbl?3:1);
         tvChannelsList->Selected->SelectedIndex = tvChannelsList->Selected->ImageIndex;
         Panel5->Visible = cbMainChannel->ItemIndex<1;
         tvChannelsList->Invalidate();
      }
      if(Sender==(TObject*)rgDataDeportationMode){
         switch(rgDataDeportationMode->ItemIndex){
         case 0:
            Label1->Caption = Reconst_smes19_8;
            break;
         case 1:
            Label1->Caption = Reconst_smes19_9;
            break;
         case 2:
            Label1->Caption = Reconst_smes19_10;
            break;
         default:
            Label1->Caption = "";
         }
      }
   }
}
//---------------------------------------------------------------------------

void __fastcall TfmEditDeportationPlan::vNew(TObject *Sender)
{
      bool b=true;
      TTreeNode* TN;
    tvChannelsList->OnChange = NULL;
    tvChannelsList->OnChanging = NULL;
    if(tvChannelsList->Selected) tvChannelsListChanging(tvChannelsList,tvChannelsList->Selected,b);
    if(!b) {
      tvChannelsList->OnChange = tvChannelsListChange;
      tvChannelsList->OnChanging = tvChannelsListChanging;
      return;
    }
    stChannel* PChannel = new stChannel;
    ZeroMemory(PChannel, sizeof(stChannel));
    for(long j=1;j<4;j++)
      PChannel->indicator[1] = -1;
    strcpy(PChannel->Name,Reconst_smes19_11.c_str());
    PChannel->editing = 1;
    PChannel->Block = true;
    strcpy(PChannel->From,"00:00");
    PChannel->indicator[2]=0;
    strcpy(PChannel->Till,"23:59");
    PChannel->indicator[3]=0;
    PChannel->Retries = 2;
    PChannel->Retries_Tout = 2;
    TN = tvChannelsList->Items->AddObject(tvChannelsList->Selected, PChannel->Name, PChannel);
    TN->ImageIndex = 2;
    TN->SelectedIndex = 2;
    TN->Selected = true;
    EditRec = true;
    if(Access==accWrite) paEdit->Enabled = true;
    tvChannelsListChange(tvChannelsList,TN);
    tvChannelsList->OnChange = tvChannelsListChange;
    tvChannelsList->OnChanging = tvChannelsListChanging;
    eName->SetFocus();
}
//---------------------------------------------------------------------------

void __fastcall TfmEditDeportationPlan::vDelete(TObject *Sender)
{
    if(tvChannelsList->Selected&&Application->MessageBox(AnsiString(Reconst_smes19_12+tvChannelsList->Selected->Text+"?").c_str(), Application->Title.c_str(), MB_YESNO|MB_ICONQUESTION|MB_DEFBUTTON2)==IDYES)
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

void __fastcall TfmEditDeportationPlan::tvChannelsListDeletion(TObject *Sender,
      TTreeNode *Node)
{
   if(Node->Data && ((stChannel*)Node->Data)->editing!=1)
   {
      Channels_Del_Count++;
      if(!nChannels_Del)
        nChannels_Del = new long[1];
      else
        nChannels_Del = (long*)realloc(nChannels_Del, (Channels_Del_Count*sizeof(long)));
      nChannels_Del[Channels_Del_Count-1] = ((stChannel*)Node->Data)->NDeportation;
   }
}
//---------------------------------------------------------------------------

void __fastcall TfmEditDeportationPlan::vRefresh(TObject *Sender)
{
   tvChannelsList->OnChange=NULL;
   tvChannelsList->OnChanging=NULL;
   Screen->Cursor=crHourGlass;
   tvChannelsList->Visible=false;
   tvChannelsList->Items->Clear();
   Screen->Cursor=crDefault;
   GetCombo(cbProc_id);
   GetCombo(cbMainChannel);
   if(ReadChannels(NULL))
      if(tvChannelsList->Items->Count>0)
      {
         tvChannelsList->OnChange = tvChannelsListChange;
         tvChannelsList->Selected = tvChannelsList->Items->Item[0];
      }
   tvChannelsList->Visible=true;
   tvChannelsList->OnChange = tvChannelsListChange;
   tvChannelsList->OnChanging = tvChannelsListChanging;
   EditRec=false;
   if(nChannels_Del) delete[] nChannels_Del;
   nChannels_Del = NULL;
   Channels_Del_Count = 0;
}
//---------------------------------------------------------------------------

void __fastcall TfmEditDeportationPlan::vSave(TObject *Sender)
{
  bool b=true;
  if(tvChannelsList->Selected) tvChannelsListChanging(tvChannelsList,tvChannelsList->Selected,b);
  if(!b) return;
  TTreeNode *Node=NULL;
  stChannel Channel;
  short indic[4];
  try{
    //15.04.2020 - GRB ADD - dmMain->quMain->Params->Clear(); без этого под ODAC 6.7 вместо строк приходят пустышки
    dmMain->quMain->Params->Clear();
    //END ADD
    dmMain->quMain->SQL->Text="begin \
                  if :par1>0 then \
                    "+SchemeName+"deportation_pg.upd_p(:par1,:par2,:par3,:par4,:par5,:par6,:par7,to_date(:par8, 'hh24:mi'),to_date(:par9, 'hh24:mi'),:par10,:par11,:par12,:par13, :par14, :par15); \
                  else \
                    "+SchemeName+"deportation_pg.ins_p(:par2,:par3,:par4,:par5,:par6,:par7,to_date(:par8, 'hh24:mi'),to_date(:par9, 'hh24:mi'),:par10,:par11,:par12,:par13,:par1, :par14, :par15); \
                  end if; \
                end;";
    Node = tvChannelsList->Items->GetFirstNode();
    while(Node)
    {
      if(Node->Data && ((stChannel*)Node->Data)->editing > 0)
      {
          memcpy(&Channel,(stChannel*)Node->Data,sizeof(stChannel));
          memcpy(&indic,((stChannel*)Node->Data)->indicator,sizeof(indic));
          dmMain->quMain->ParamByName("par1")->ParamType=ptInputOutput;
          dmMain->quMain->ParamByName("par1")->DataType=ftInteger;
          dmMain->quMain->ParamByName("par1")->AsInteger=Channel.NDeportation;
          dmMain->quMain->ParamByName("par2")->AsString=Channel.Name;
          dmMain->quMain->ParamByName("par3")->AsString=Channel.Note;
          if(indic[0]>-1)
            dmMain->quMain->ParamByName("par4")->AsInteger=Channel.Proc_id;
          else
            dmMain->quMain->ParamByName("par4")->Clear();
          dmMain->quMain->ParamByName("par5")->AsInteger=Channel.DataDeportationMode;
          dmMain->quMain->ParamByName("par6")->AsString=Channel.Address;
          if(indic[1]>-1)
            dmMain->quMain->ParamByName("par7")->AsInteger=Channel.Parent;
          else
            dmMain->quMain->ParamByName("par7")->Clear();
          if(indic[2]>-1)
            dmMain->quMain->ParamByName("par8")->AsString=Channel.From;
          else
            dmMain->quMain->ParamByName("par8")->Clear();
          if(indic[3]>-1)
            dmMain->quMain->ParamByName("par9")->AsString=Channel.Till;
          else
            dmMain->quMain->ParamByName("par9")->Clear();
          dmMain->quMain->ParamByName("par10")->AsInteger=Channel.Block;
          dmMain->quMain->ParamByName("par11")->AsInteger=Channel.Retries_Tout;
          dmMain->quMain->ParamByName("par12")->AsInteger=Channel.Retries;
          dmMain->quMain->ParamByName("par13")->AsString=Channel.SendParam;
          if(Node->Parent && Node->Parent->Data)//Родитель
            if(((stChannel*)Node->Parent->Data)->tmpNDeportation)
              dmMain->quMain->ParamByName("par14")->AsInteger = ((stChannel*)Node->Parent->Data)->tmpNDeportation;
            else
              dmMain->quMain->ParamByName("par14")->AsInteger = ((stChannel*)Node->Parent->Data)->NDeportation;
          else
            dmMain->quMain->ParamByName("par14")->Clear();
           dmMain->quMain->ParamByName("par15")->AsInteger = (int)Channel.IsFolder;
          dmMain->quMain->ParamByName("par13")->AsString=Channel.SendParam;
          dmMain->quMain->Execute();
          Channel.NDeportation=dmMain->quMain->ParamByName("par1")->AsInteger;
          ((stChannel*)Node->Data)->tmpNDeportation = Channel.NDeportation;
      }//end if
      Node = Node->GetNext();
    }
    //GRB ADD 16.04.2020 - test trouble ODAC
    dmMain->quMain->Params->Clear();
    //END ADD 
    dmMain->quMain->SQL->Text="begin "+SchemeName+"deportation_pg.del_p(:par1); end;";
    for(int i=0; nChannels_Del&&i<Channels_Del_Count; i++)
    { Channel.NDeportation = nChannels_Del[i];
      dmMain->quMain->ParamByName("par1")->AsInteger=Channel.NDeportation;
      dmMain->quMain->Execute();
    }
    dmMain->orases->Commit();
    if(nChannels_Del) delete[] nChannels_Del;
    nChannels_Del = NULL;
    Channels_Del_Count = 0;
    Node = tvChannelsList->Items->GetFirstNode();
    while(Node)
    {
        if(Node->Data && ((stChannel*)Node->Data)->editing>0)
        {
           ((stChannel*)Node->Data)->editing=0;
           ((stChannel*)Node->Data)->NDeportation=((stChannel*)Node->Data)->tmpNDeportation;
        }
        Node=Node->GetNext();
    }
    long ind = cbMainChannel->ItemIndex<0?-1:(long)cbMainChannel->Items->Objects[cbMainChannel->ItemIndex];
    GetCombo(cbMainChannel);
    cbMainChannel->ItemIndex = ind<0?-1:cbMainChannel->Items->IndexOfObject((TObject*)ind);
    EditRec=false;
  }catch (Exception &exception){
      dmMain->orases->Rollback();
      Application->ShowException(&exception);
      if(Node) tvChannelsList->Selected=Node;
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmEditDeportationPlan::edLongPress(TObject *Sender,
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

void __fastcall TfmEditDeportationPlan::SetAccess(TAccess value)
{
   if(FAccess != value){
      TMainForm::SetAccess(value);
      bool wr = (value==accWrite);
      iaDelete->Enabled = wr;
      iaClone->Enabled = wr;
      paEdit->Enabled = wr;
      iaNew->Enabled = wr;
   }
}
//---------------------------------------------------------------------------

void __fastcall TfmEditDeportationPlan::aExecute(TObject *Sender)
{
   if(Sender==aBlocking)
      chbBlocking->Checked = !chbBlocking->Checked;
   else if(Sender==aEMail)
      rgDataDeportationMode->ItemIndex = 0;
   else if(Sender==aFTP)
      rgDataDeportationMode->ItemIndex = 1;
   else if(Sender==aLan)
      rgDataDeportationMode->ItemIndex = 2;
}
//---------------------------------------------------------------------------
void __fastcall TfmEditDeportationPlan::vClone(TObject* Sender)
{
    bool b=true;
    TTreeNode* TN=tvChannelsList->Selected;
    if(!TN||!TN->Data)
      return;
    tvChannelsList->OnChange = NULL;
    tvChannelsList->OnChanging = NULL;
    if(tvChannelsList->Selected) tvChannelsListChanging(tvChannelsList,tvChannelsList->Selected,b);
    if(!b) {
      tvChannelsList->OnChange = tvChannelsListChange;
      tvChannelsList->OnChanging = tvChannelsListChanging;
      return;
    }
    stChannel* PChannel = new stChannel;
    memcpy(PChannel,(stChannel*)TN->Data, sizeof(stChannel));
    PChannel->editing = 1;
    PChannel->NDeportation=0;
    PChannel->tmpNDeportation=0;
    int i=TN->ImageIndex;
    TN = tvChannelsList->Items->AddObject(TN, PChannel->Name, PChannel);
    TN->ImageIndex = i;
    TN->SelectedIndex = i;
    TN->Selected = true;
    EditRec = true;
    if(Access==accWrite) paEdit->Enabled = true;
    tvChannelsListChange(tvChannelsList,TN);
    tvChannelsList->OnChange = tvChannelsListChange;
    tvChannelsList->OnChanging = tvChannelsListChanging;
    eName->SetFocus();
}
//---------------------------------------------------------------------------
void __fastcall TfmEditDeportationPlan::mMonClick(TObject *Sender)
{
 SetPopupMenu( Sender, SelChannel->NDeportation,SelChannel->Name);
}
//---------------------------------------------------------------------------

void __fastcall TfmEditDeportationPlan::iaFindExecute(TObject *Sender)
{
  //GRB ADD 09.03.2021 -добавляем вызов 2-х сеттеров, определяющих контекст задачи
  fmFP->setContext(3);
  fmFP->setGroupsAndPoints(false);
  //END ADD
  fmFP->ShowModal();
}
//---------------------------------------------------------------------------

void __fastcall TfmEditDeportationPlan::WM_SetActiveNode(TMessage& Message)
{
  FindNode(tvChannelsList, Message.LParam,ReadChannels, getNodeId);
}
//---------------------------------------------------------------------------

void __fastcall TfmEditDeportationPlan::aNewGroupExecute(TObject *Sender)
{
   bool b=true;
   TTreeNode* TN;

   tvChannelsList->OnChange = NULL;
   tvChannelsList->OnChanging = NULL;
   if(tvChannelsList->Selected)
    tvChannelsListChanging(tvChannelsList,tvChannelsList->Selected,b);
   if(b){
      stChannel* PChannel = new stChannel;
      ZeroMemory(PChannel, sizeof(stChannel));
      for(long j=0;j<6;j++)
         PChannel->indicator[j] = -1;
      strcpy(PChannel->Name,Reconst_smes26_23.c_str());
      PChannel->editing = 1;
      PChannel->IsFolder = true;
      PChannel->HaveChilde = false;
      PChannel->Block = false;
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

void __fastcall TfmEditDeportationPlan::tvChannelsListExpanding(
      TObject *Sender, TTreeNode *Node, bool &AllowExpansion)
{
   if(!Node || !Node->Data) return;
   TTreeNode*cn = Node->getFirstChild();
   if(!cn || !cn->Data)
      if(!ReadChannels(Node))
         throw Exception(Reconst_smes26_21);
}
//---------------------------------------------------------------------------

void __fastcall TfmEditDeportationPlan::tvChannelsListExpanded(
      TObject *Sender, TTreeNode *Node)
{
    if(Node->Expanded)
      Node->ImageIndex = (((stChannel*)Node->Data)->Block)?7:5;
    else
      Node->ImageIndex = (((stChannel*)Node->Data)->Block)?6:4;
    Node->SelectedIndex = Node->ImageIndex;
}
//---------------------------------------------------------------------------

void __fastcall TfmEditDeportationPlan::tvChannelsListDragOver(
      TObject *Sender, TObject *Source, int X, int Y, TDragState State,
      bool &Accept)
{
  TTreeNode*dst = ((TTreeView*)Sender)->GetNodeAt(X, Y);
  TTreeNode*src = ((TTreeView*)Source)->Selected;
  if(dst && ((stChannel*)dst->Data)->IsFolder)
    Accept = true;
  else if(!dst)
    Accept = PtInRect(&(((TTreeView*)Sender)->ClientRect), TPoint(X,Y));
  else
    Accept = false;
}
//---------------------------------------------------------------------------

void __fastcall TfmEditDeportationPlan::tvChannelsListDragDrop(
      TObject *Sender, TObject *Source, int X, int Y)
{
  TTreeNode*Dst = ((TTreeView*)Sender)->GetNodeAt(X, Y);
  TTreeNode*Src = ((TTreeView*)Source)->Selected;
  if(!Src || !Src->Data)
     throw Exception(Reconst_smes26_22);
  Src->Cut = !(GetKeyState(VK_CONTROL)&0x8000);
  changeNode(Dst, Src);
}
//---------------------------------------------------------------------------

void __fastcall TfmEditDeportationPlan::changeNode(TTreeNode*Dst, TTreeNode*Src)
{
   TTreeNode*newNode;

  if(!Src || !Src->Data) return;
  if(Dst && Dst->getFirstChild() && !Dst->getFirstChild()->Data)
     ReadChannels(Dst);
  if(Src->Cut)
  { // Move
    Src->MoveTo(Dst, naAddChild);
     ((stChannel*)Src->Data)->editing = 2;
  }
  else
  {// Copy
    stChannel* pChnl = new stChannel();
    memcpy(pChnl, Src->Data, sizeof(stChannel));
    pChnl->NDeportation = pChnl->tmpNDeportation = 0;
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

void __fastcall TfmEditDeportationPlan::copyChildNodes(TTreeNode*d, TTreeNode*s)
{
   ReadChannels(s);
   TTreeNode *tn = s->getFirstChild();
   while(tn){
      changeNode(d, tn);
      tn = tn->getNextSibling();
   }
}
//---------------------------------------------------------------------------

