//---------------------------------------------------------------------------
#include <vcl.h>
#include <stdio.h>
#pragma hdrstop
#include "EditRates.h"
#include "unDataMod.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "DBAccess"
#pragma link "MemDS"
#pragma link "Ora"
#pragma link "OraSmart"
#pragma resource "*.dfm"
// AnsiString rate_type[]={Reconst_smes25_1.c_str(),Reconst_smes25_2.c_str(),Reconst_smes25_3.c_str(),Reconst_smes25_4.c_str()};
   AnsiString rate_type[]={"А(пик)","В(полупик)","С(ночь)","D(резерв)","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X",};
//---------------------------------------------------------------------------
__fastcall TFormEditRates::TFormEditRates(TComponent* Owner, AnsiString Name, TAccess a)
	: TMainForm(Owner, Name, a)
{
   ShowAction(iaNew);
   ShowAction(iaDelete);
   ShowAction(iaClone);
   aAddRate->OnUpdate = vUpdate;
   aDelRate->OnUpdate = vUpdate;
   aAddZone->OnUpdate = vUpdate;
   aDelZone->OnUpdate = vUpdate;
}
//---------------------------------------------------------------------------

void  TFormEditRates::TreeRead()
{


     /* dmMain->oqCursor->Params->Clear();
      dmMain->oqCursor->SQL->Text="begin "+SchemeName+"RATES_PG.select_rid_p(:par1);end;";
      dmMain->oqCursor->ParamByName("par1")->DataType=ftCursor;
      dmMain->oqCursor->ParamByName("par1")->ParamType=ptOutput;
      dmMain->oqCursor->Execute();*/
   oqDates->ParamByName("SHEDULE")->AsInteger = (int) cbZone->Items->Objects[cbZone->ItemIndex];
   oqDates->Execute();

   int i=0;
   while(!oqDates->Eof&&i<RATE_SIZE){
   if(!oqDates->FieldByName("rid")->IsNull)
   TreeTable[i].Rid=oqDates->FieldByName("rid")->AsInteger;
   if(!oqDates->FieldByName("switch_date1")->IsNull)
   strcpy(TreeTable[i].Switch_Date,oqDates->FieldByName("switch_date1")->AsString.c_str());
   oqDates->Next();
   i++;
   }
   TreeCount=i;
   TListItem* Sl;

   for(unsigned long i=0; i<TreeCount;i++){
      Sl = TreeView->Items->Add();
      Sl->Caption = TreeTable[i].Switch_Date;
      Sl->Data = &TreeTable[i];
    /*  dmMain->oqCursor->Params->Clear();
      dmMain->oqCursor->SQL->Text="begin "+SchemeName+"RATES_PG.read_data_p(:par1,:par2);end;";
      dmMain->oqCursor->ParamByName("par2")->DataType=ftCursor;
      dmMain->oqCursor->ParamByName("par2")->ParamType=ptOutput;
      dmMain->oqCursor->ParamByName("par1")->AsInteger= TreeTable[i].Rid;
      dmMain->oqCursor->Execute();*/
      oqTime->ParamByName("an_rid")->AsInteger = TreeTable[i].Rid;
      oqTime->Execute();
      int j=0;
      while(!oqTime->Eof&&j<RATE_MAX){
      if(!oqTime->FieldByName("time1")->IsNull)
       strcpy(TreeTable[i].RatesList[j].Time,oqTime->FieldByName("time1")->AsString.c_str());
      if(!oqTime->FieldByName("rate")->IsNull)
       TreeTable[i].RatesList[j].Rate=oqTime->FieldByName("rate")->AsInteger;
       oqTime->Next();
       j++;
       }
       TreeTable[i].RatesListCount=j;
   }   
   if(TreeCount)
    {
     TreeView->Selected = TreeView->Items->Item[0];
     DelRateBB->Enabled = true;
    }
    else
     DelRateBB->Enabled = false;
   EditRec = false;
}
//---------------------------------------------------------------------------

void TFormEditRates::TreeWrite()
{
  /*AnsiString sqlUpd = "begin  \
                    if :par5=1 then  "+SchemeName+"RATES_PG.ins_tariff_p(TO_DATE(:par2,'dd.mm.yyyy'), :par3, :par4,:par1); \
                    else if :par5=2 then  \
                         "+SchemeName+"RATES_PG.update_tariff_p(:par1, TO_DATE(:par2,'dd.mm.yyyy'), :par3, :par4);  \
                         else \
                           "+SchemeName+"RATES_PG.del_tariff_p(:par1);  \
                         end if; \
                    end if; \
                  end; ";*/
   RATE_LIST pTreeTable;

//   char *massage = "Изменена таблица ТАРИФОВ";
  int Rid=0;
  TSmartQuery* Act = NULL;
   try{
      for(int i=0; i<(int)TreeCount; ++i){
         if(!TreeTable[i].pEdit)
            continue;
         // save changes
         memcpy(&pTreeTable, &TreeTable[i], sizeof(pTreeTable));
//         oqTreeWrite->SQL->Text=sqlUpd;
/*         oqTreeWrite->ParamByName("par1")->ParamType=ptInputOutput;
         oqTreeWrite->ParamByName("par1")->DataType=ftInteger;

         oqTreeWrite->ParamByName("par1")->AsInteger=pTreeTable.Rid;
         oqTreeWrite->ParamByName("par2")->AsString=pTreeTable.Switch_Date;
         oqTreeWrite->ParamByName("par5")->AsInteger=pTreeTable.pEdit;
         oqTreeWrite->ParamByName("par3")->Table=true;
         oqTreeWrite->ParamByName("par4")->Table=true;
          int cnt=0;
          for(unsigned long j=0; j<pTreeTable.RatesListCount; j++){
           cnt++;
           oqTreeWrite->ParamByName("par3")->Length=cnt;
           oqTreeWrite->ParamByName("par3")->ItemAsString[cnt]=pTreeTable.RatesList[j].Time;
           oqTreeWrite->ParamByName("par4")->Length=cnt;
           oqTreeWrite->ParamByName("par4")->ItemAsInteger[cnt]=pTreeTable.RatesList[j].Rate;

           }
          if(!cnt){
            oqTreeWrite->ParamByName("par3")->Length=1;
            oqTreeWrite->ParamByName("par3")->ItemAsString[1]=0;
            oqTreeWrite->ParamByName("par4")->Length=1;
            oqTreeWrite->ParamByName("par4")->ItemAsInteger[1]=0;
            }
            oqTreeWrite->Execute();*/
//ryda.RATES_PG.ins_tariff_p(:AN_SCHDUE, :AD_SWITCH_DATE, :AV_TIMES, :AV_RATES, :AN_RID);
//ryda.RATES_PG.update_tariff_p(:AN_SCHDUE, :AN_RID, :AD_SWITCH_DATE, :AV_TIMES, :AV_RATES);
            switch (pTreeTable.pEdit)
            {
             case 1 : Act = oqInsert;
                      break;
             case 2:  Act = oqUpdate;
                      break;
             default:
                  oqDelete->ParamByName("AN_RID")->AsInteger = pTreeTable.Rid;
                  oqDelete->Execute();
               break;
            }
            if (Act)
            {
               Act->ParamByName("AN_RID")->AsInteger = pTreeTable.Rid;
               Act->ParamByName("AN_SCHDUE")->AsInteger = (int) cbZone->Items->Objects[cbZone->ItemIndex];
               Act->ParamByName("AD_SWITCH_DATE")->AsDate = StrToDateTime(pTreeTable.Switch_Date);
               Act->ParamByName("AV_TIMES")->Table = true;
               Act->ParamByName("AV_RATES")->Table = true;
               int cnt = 0;
               for (int j = 0;j<(int)pTreeTable.RatesListCount; j++)
               {
                cnt++;
                Act->ParamByName("AV_TIMES")->Length = cnt;
                Act->ParamByName("AV_TIMES")->ItemAsString[cnt]=pTreeTable.RatesList[j].Time;
                Act->ParamByName("AV_RATES")->Length=cnt;
                Act->ParamByName("AV_RATES")->ItemAsInteger[cnt]=pTreeTable.RatesList[j].Rate;
               }
               if (!cnt)
               {
                Act->ParamByName("AV_TIMES")->Length = 0;
                //Act->ParamByName("AV_TIMES")->ItemAsString[1]=0;
                Act->ParamByName("AV_RATES")->Length=0;
               // Act->ParamByName("AV_RATES")->ItemAsInteger[1]=0;
               }
               Act->Execute();
            }
//------------------------------------------------------------------------------------------------------------------------------------
            //pTreeTable.Rid=oqTreeWrite->ParamByName("AN_RID")->AsInteger;
            if(TreeTable[i].pEdit==1||TreeTable[i].pEdit==2)
                 Rid=pTreeTable.Rid;
           }
      for(int i=0; i < (int)TreeCount; ++i)
         TreeTable[i].pEdit=0;
         dmMain->orases->Commit();
         EditRec = false;
          vRefresh(this);
     if(Rid){
       for(int j=0; j < (int)TreeCount; ++j){
         if(Rid == ((RATE_LIST*)TreeView->Items->Item[j]->Data)->Rid)
            TreeView->Selected = TreeView->Items->Item[j];
           }
       }

   }catch(Exception &e){
        dmMain->orases->Rollback();
        Application->ShowException(&e);
             for(int j=0; j < (int)TreeCount; ++j){
         if(pTreeTable.Rid == ((RATE_LIST*)TreeView->Items->Item[j]->Data)->Rid){
            TreeView->Selected = TreeView->Items->Item[j];
            break;
         }
      }
   }
}
//---------------------------------------------------------------------------
int TFormEditRates::SetRatesCount()
{
 oqZone->Locate("vname",cbZone->Text,TLocateOptions()<<loCaseInsensitive);
 return oqZone->FieldByName("ncount")->AsInteger;
}

void __fastcall TFormEditRates::FormShow(TObject *Sender)
{
   oqZone->Execute();
   while (!oqZone->Eof)
   {
    cbZone->Items->AddObject(oqZone->FieldByName("VNAME")->AsString,(TObject*)oqZone->FieldByName("NSCHEDULELIST")->AsInteger);
    oqZone->Next();
   }
   Curent = 0;
   cbZone->ItemIndex = 0;

   for(int i=0; i<SetRatesCount(); i++)
      RateCB->Items->Add(rate_type[i]);
   DateDTP->ControlStyle >> csFramed;
   RateCB->Ctl3D = false;
   TreeRead();
}
//---------------------------------------------------------------------------

void __fastcall TFormEditRates::TreeViewChange(TObject *Sender, TListItem *Item, TItemChange Change)
{
   AnsiString str;
   if(!TreeView->Selected){
      if(DateDTP->Focused() && TreeView->Items->Count==1){
         DateDTPExit(Sender);
         TreeView->SetFocus();
      }
      return;
   }
   Cheng=1;
   RATE_LIST* sGruop=(RATE_LIST*)TreeView->Selected->Data;
   str=sGruop->Switch_Date;
   DateDTP->Date=str;

   DrawTable->Items->Clear();
   for(int i=0; i < RATE_MAX; ++i){
      if(sGruop->RatesList[i].Time[0]!='\0'){
         TListItem*li = DrawTable->Items->Add();
         li->Caption = sGruop->RatesList[i].Time;
         li->SubItems->Add(rate_type[sGruop->RatesList[i].Rate]);
      }
   }
   if(DrawTable->Items->Count)
   {
      DrawTable->ItemFocused = DrawTable->Items->Item[0];
      DelZoneBB->Enabled = true;
   }
   else
    DelZoneBB->Enabled = false;
   Cheng=0;

   if(DateDTP->Focused()){
      DateDTPExit(Sender);
      bool a = true;
      if(TreeView->Selected)
         TreeViewEditing(Sender, TreeView->Selected, a);
   }
}
//---------------------------------------------------------------------------

void __fastcall TFormEditRates::AddRateBBClick(TObject *Sender)
{

   DelRateBB->Enabled = true;
   TListItem* Sl;
   AnsiString str;
   int i=TreeCount;
   str = DateDTP->Date.CurrentDate().FormatString("dd.mm.yyyy");
   Sl = TreeView->Items->Add();
   Sl->Caption = str;

   strcpy(TreeTable[i].Switch_Date,str.c_str());
   TreeTable[i].RatesListCount=0;

   for(int j=0; j<RATE_MAX; ++j){
      TreeTable[i].RatesList[j].Time[0] = '\0';
      TreeTable[i].RatesList[j].Rate = 0;
   }
  TreeTable[i].pEdit=1;
   Sl->Data=&TreeTable[(int)TreeCount];

   ++TreeCount;
   TreeView->ItemFocused = Sl;
   TreeView->Selected = Sl;
   EditRec = true;

}
//---------------------------------------------------------------------------

void __fastcall TFormEditRates::AddZoneBBClick(TObject *Sender)
{
   if(!TreeView->Selected) return;
   DelZoneBB->Enabled = true;
   int iCnt = DrawTable->Items->Count;
   if(iCnt>=RATE_MAX) return;
   TListItem*li = DrawTable->Items->Add();
   if(iCnt>0)
      li->Caption = DrawTable->Items->Item[iCnt-1]->Caption;
   else
      li->Caption = "00:00";
   li->SubItems->Add(rate_type[2]);
   RATE_LIST *rl = (RATE_LIST *)TreeView->Selected->Data;
   rl->pEdit = 2;
   strcpy(rl->RatesList[iCnt].Time, "00:00");
   rl->RatesList[iCnt].Rate = 2;
   rl->RatesListCount++;
   DrawTable->Selected = li;
   EditRec = true;
}
//---------------------------------------------------------------------------

void __fastcall TFormEditRates::DelZoneBBClick(TObject *Sender)
{
   while(DrawTable->Selected)
   {
      int ind = DrawTable->Selected->Index;
      RATE_LIST* sGroup = (RATE_LIST*)TreeView->Selected->Data;
      for(int i=ind; i < (int)sGroup->RatesListCount-1; i++)
      {
         strcpy(sGroup->RatesList[i].Time, sGroup->RatesList[i+1].Time);
         sGroup->RatesList[i].Rate = sGroup->RatesList[i+1].Rate;
      }
      sGroup->RatesListCount--;
      sGroup->RatesList[sGroup->RatesListCount].Time[0] = '\0';
      sGroup->RatesList[sGroup->RatesListCount].Rate = 0;
      if(!sGroup->pEdit) sGroup->pEdit = 2;
      DrawTable->Selected->Delete();
      if(!EditRec) EditRec = true;
   }
   DrawTable->Selected = DrawTable->ItemFocused;
   if (DrawTable->Items->Count)
    DelZoneBB->Enabled = true;
   else
    DelZoneBB->Enabled = false;
}
//---------------------------------------------------------------------------

void __fastcall TFormEditRates::DelRateBBClick(TObject *Sender)
{
   if(TreeView->Selected==NULL) return;

   if(Application->MessageBox(Reconst_smes25_6.c_str(), Application->Title.c_str(), MB_YESNO | MB_ICONQUESTION)==IDNO)
      return;
   RATE_LIST* sGruop=(RATE_LIST*)TreeView->Selected->Data;
   switch(sGruop->pEdit)
   {
   case 0:
   case 2:
      sGruop->pEdit=3;
      break;
   case 1:
       sGruop->pEdit=0;
   }
   if(!EditRec) EditRec = true;
   TreeView->Selected->Delete();
   TreeView->Selected = TreeView->ItemFocused;
   if (TreeView->Items->Count)
    DelRateBB->Enabled = true;
   else
    DelRateBB->Enabled = false;
 //  vRefresh(this);
// TreeWrite();
}
//---------------------------------------------------------------------------
//save
void __fastcall TFormEditRates::vSave(TObject* Sender)
{

   TreeWrite();

}
//---------------------------------------------------------------------------
//cancel
void __fastcall TFormEditRates::vRefresh(TObject* Sender)
{
   TreeView->SetFocus();

   TreeView->Items->BeginUpdate();
   DrawTable->Items->BeginUpdate();
   TreeView->Items->Clear();
   DrawTable->Items->Clear();
   ZeroMemory(TreeTable, sizeof(TreeTable));
   TreeRead();
   TreeView->Items->EndUpdate();
   DrawTable->Items->EndUpdate();
  
}
//---------------------------------------------------------------------------

void __fastcall TFormEditRates::TreeViewEditing(TObject *Sender,
      TListItem *Item, bool &AllowEdit)
{
   DateDTP->Visible = true;
   DateDTP->SetFocus();
   AllowEdit = false;
}
//---------------------------------------------------------------------------

void __fastcall TFormEditRates::DateDTPExit(TObject *Sender)
{
   DateDTP->Visible = false;
   if(!TreeView->ItemFocused) return;
   if(TreeView->ItemFocused->Caption != DateDTP->DateTime.FormatString("dd.mm.yyyy")){
      TreeView->ItemFocused->Caption = DateDTP->DateTime.FormatString("dd.mm.yyyy");
      RATE_LIST *rl = (RATE_LIST *)TreeView->ItemFocused->Data;
      strcpy(rl->Switch_Date, TreeView->ItemFocused->Caption.c_str());
      if(!rl->pEdit) rl->pEdit = 2;
      if(!EditRec) EditRec = true;
   }
   ReleaseCapture();
}

//---------------------------------------------------------------------------

void __fastcall TFormEditRates::DrawTableEditing(TObject *Sender,
      TListItem *Item, bool &AllowEdit)
{
   if(posX < DrawTable->Columns->Items[0]->Width+DrawTable->Left){
      TimeDTP->Visible = true;
      TimeDTP->SetFocus();
   }else{
      RateCB->Visible = true;
      RateCB->SetFocus();
   }
   AllowEdit = false;
}
//---------------------------------------------------------------------------

void __fastcall TFormEditRates::TimeDTPExit(TObject *Sender)
{

   TimeDTP->Visible = false;
   if(!DrawTable->Selected) return;
    if(StrToTime(DrawTable->Selected->Caption) != TimeDTP->Time){
      DrawTable->Selected->Caption = TimeDTP->DateTime.FormatString("t");
      RATE_LIST *rl = (RATE_LIST *)TreeView->Selected->Data;
      int ind = DrawTable->Selected->Index;
      strcpy(rl->RatesList[ind].Time, DrawTable->Selected->Caption.c_str());
      if(!rl->pEdit) rl->pEdit = 2;
      if(!EditRec) EditRec = true;
   }
   ReleaseCapture();
   DrawTable->SetFocus();
}
//---------------------------------------------------------------------------

void __fastcall TFormEditRates::DrawTableMouseMove(TObject *Sender,
      TShiftState Shift, int X, int Y)
{
   posX = X;
}
//---------------------------------------------------------------------------

void __fastcall TFormEditRates::RateCBExit(TObject *Sender)
{
   RateCB->Visible = false;
   if(!DrawTable->Selected) return;
   if(DrawTable->Selected->SubItems->Strings[0] != RateCB->Text){
      DrawTable->Selected->SubItems->Strings[0] = RateCB->Text;
      RATE_LIST *rl = (RATE_LIST *)TreeView->Selected->Data;
      int ind = DrawTable->Selected->Index;
      rl->RatesList[ind].Rate = RateCB->ItemIndex;
      if(!rl->pEdit) rl->pEdit = 2;
      if(!EditRec) EditRec = true;
   }
   ReleaseCapture();
   DrawTable->SetFocus();
}
//---------------------------------------------------------------------------

void __fastcall TFormEditRates::TreeViewFocusChange(TObject *Sender)
{
   TListView *lv;
   if ((lv = dynamic_cast<TListView *>(Sender)) != 0) {
      if(!lv->Selected)
         lv->Selected = lv->ItemFocused;
      if(!lv->ItemFocused)
         lv->ItemFocused = lv->Selected;
   }
}
//---------------------------------------------------------------------------

void __fastcall TFormEditRates::SetAccess(TAccess value)
{
   if(FAccess != value) {
      TMainForm::SetAccess(value);
      bool wr = value==accWrite;
      aAddRate->Enabled = wr;
      aAddZone->Enabled = wr;
      aDelRate->Enabled = wr;
      aDelZone->Enabled = wr;
      iaNew->Enabled = wr;
      iaDelete->Enabled = wr;
      iaClone->Enabled = wr;
      DrawTable->ReadOnly = !wr;
      TreeView->ReadOnly = !wr;
   }
}
//---------------------------------------------------------------------------

void __fastcall TFormEditRates::TimeDTPUserInput(TObject *Sender,
      const AnsiString UserString, TDateTime &DateAndTime,
      bool &AllowChange)
{
   try{
      AllowChange = false;
   }catch(Exception &e){
   }
}
//---------------------------------------------------------------------------

void __fastcall TFormEditRates::vNew(TObject* Sender)
{
   if(TimeDTP->Focused() || RateCB->Focused())
      return;
   if(TreeView->Focused()||DateDTP->Focused()){
      TreeView->SetFocus();
      AddRateBBClick(Sender);
   }
   if(DrawTable->Focused()||TimeDTP->Focused()||RateCB->Focused()){
      DrawTable->SetFocus();
      AddZoneBBClick(Sender);
   }
}
//---------------------------------------------------------------------------

void __fastcall TFormEditRates::vDelete(TObject* Sender)
{
   if(TimeDTP->Focused() || RateCB->Focused())
      return;
   if(TreeView->Focused()||DateDTP->Focused()){
      DelRateBBClick(Sender);
   }
   if(DrawTable->Focused()||TimeDTP->Focused()||RateCB->Focused())
      DelZoneBBClick(Sender);
}
//---------------------------------------------------------------------------

void __fastcall TFormEditRates::TreeViewKeyPress(TObject *Sender,
      char &Key)
{
   if(Access==accWrite && TreeView->Selected){
      DateDTP->Visible = true;
      DateDTP->SetFocus();
      DateDTPEnter(DateDTP);
      if(Key!=VK_RETURN)
         PostMessage(DateDTP->Handle, WM_CHAR, Key, 0);
      Key = 0;
   }
}
//---------------------------------------------------------------------------

void __fastcall TFormEditRates::DateDTPKeyPress(TObject *Sender, char &Key)
{
   if(Key==VK_RETURN){
      TreeView->SetFocus();
      SendMessage(TreeView->Handle, WM_KEYDOWN, VK_DOWN, 0);
      SendMessage(TreeView->Handle, WM_KEYUP, VK_DOWN, 0);
      SendMessage(TreeView->Handle, WM_CHAR, VK_RETURN, 0);
   }
   if(Key==27){
      TNotifyEvent ee = DateDTP->OnExit;
      DateDTP->OnExit = NULL;
      DateDTP->Visible = false;
      TreeView->SetFocus();
      DateDTP->OnExit = ee;
      ReleaseCapture();
   }
}
//---------------------------------------------------------------------------
 
void __fastcall TFormEditRates::TimeDTPKeyPress(TObject *Sender, char &Key)
{
   if(Key==VK_RETURN){
      TimeDTPExit(TimeDTP);
      RateCB->Visible = true;
      RateCB->SetFocus();
   }
   if(Key==27){
    //  TNotifyEvent ee = DateDTP->OnExit;
      TNotifyEvent ee = TimeDTP->OnExit;
      TimeDTP->OnExit = NULL;
      TimeDTP->Visible = false;
      DrawTable->SetFocus();
      TimeDTP->OnExit = ee;
      ReleaseCapture();
     }
 }
//---------------------------------------------------------------------------

void __fastcall TFormEditRates::RateCBKeyPress(TObject *Sender, char &Key)
{
   static flag=0;// флаг для пркдотвращения двойного нажатия на Enter
   if(Key==VK_RETURN){
      if(flag==0){
         RateCBExit(Sender);
         SendMessage(DrawTable->Handle, WM_KEYDOWN, VK_DOWN, 0);
         SendMessage(DrawTable->Handle, WM_KEYUP, VK_DOWN, 0);
         TimeDTP->Visible = true;
         TimeDTP->SetFocus();
         flag=1;
      }else flag=0;
   }
   if(Key==27){
      TNotifyEvent ee = DateDTP->OnExit;
      RateCB->OnExit = NULL;
      RateCB->Visible = false;
      DrawTable->SetFocus();
      RateCB->OnExit = ee;
      ReleaseCapture();
   }
}
//---------------------------------------------------------------------------

void __fastcall TFormEditRates::DrawTableChange(TObject *Sender,
      TListItem *Item, TItemChange Change)
{
   TLVChangeEvent ev = DrawTable->OnChange;
   if(!Item->Selected){
      DrawTable->OnChange = NULL;
      if(TimeDTP->Focused() && DrawTable->Items->Count==1){
         TimeDTPExit(Sender);
         DrawTable->SetFocus();
      }
      if(RateCB->Focused() && DrawTable->Items->Count==1){
         RateCBExit(Sender);
         DrawTable->SetFocus();
      }
      DrawTable->OnChange = ev;
      return;
   }

   if(TimeDTP->Focused()){
      DrawTable->OnChange = NULL;
      TimeDTPExit(Sender);
      DrawTable->OnChange = ev;
      bool a = true;
      if(DrawTable->Selected){
         posX = DrawTable->Columns->Items[0]->Width+DrawTable->Left-1;
         DrawTableEditing(Sender, DrawTable->Selected, a);
      }
   }

   if(RateCB->Focused()){
      RateCBExit(Sender);
      bool a = true;
      if(DrawTable->Selected){
         posX = DrawTable->Columns->Items[0]->Width+DrawTable->Left+1;
         DrawTableEditing(Sender, DrawTable->Selected, a);
      }
   }
}
//---------------------------------------------------------------------------

void __fastcall TFormEditRates::DateDTPEnter(TObject *Sender)
{
   TRect r = TreeView->ItemFocused->DisplayRect(drLabel);
   DateDTP->Left = r.Left+TreeView->Left;
   DateDTP->Top = r.Top+TreeView->Top;
   DateDTP->Width = r.Width();
   DateDTP->Height = r.Height()+5;
   DateDTP->DateTime = StrToDateTime(TreeView->ItemFocused->Caption);
   SetCaptureControl(DateDTP);
}
//---------------------------------------------------------------------------

void __fastcall TFormEditRates::DrawTableKeyPress(TObject *Sender,
      char &Key)
{
   if(Access==accWrite)
   if(Key==VK_RETURN && DrawTable->Selected){
/*      if(Shift==TShiftState()<<ssAlt)
         RateCB->Visible = true;
         RateCB->SetFocus();
/*      else*/
         TimeDTP->Visible = true;
         TimeDTP->SetFocus();
         /**/
   }
}
//---------------------------------------------------------------------------

void __fastcall TFormEditRates::RateCBEnter(TObject *Sender)
{
   int w = DrawTable->Columns->Items[0]->Width;
   TRect r = DrawTable->ItemFocused->DisplayRect(drLabel);
   RateCB->Left = r.Left+DrawTable->Left+w;
   RateCB->Top = r.Top+DrawTable->Top;
   RateCB->Width = w;
   RateCB->Height = r.Height()+5;
   RATE_LIST *rl = (RATE_LIST *)TreeView->Selected->Data;
   RateCB->ItemIndex = rl->RatesList[DrawTable->ItemFocused->Index].Rate;
   SetCaptureControl(RateCB);
}
//---------------------------------------------------------------------------

void __fastcall TFormEditRates::TimeDTPEnter(TObject *Sender)
{
   int w = DrawTable->Columns->Items[0]->Width;
   TRect r = DrawTable->ItemFocused->DisplayRect(drLabel);
   TimeDTP->Left = r.Left+DrawTable->Left;
   TimeDTP->Top = r.Top+DrawTable->Top;
   TimeDTP->Width = w;
   TimeDTP->Height = r.Height()+5;
 //  TimeDTP->DateTime = StrToDateTime(DrawTable->ItemFocused->Caption);
   TimeDTP->Time = StrToTime(DrawTable->ItemFocused->Caption);
   SetCaptureControl(TimeDTP);
}
//---------------------------------------------------------------------------
void __fastcall TFormEditRates::vClone(TObject* Sender)
{
/*  dmMain->quMain->SQL->Text="begin "+SchemeName+"RATES_PG.clone_p; end;";     //---------------------ТУТ------------------
  dmMain->quMain->Execute();
  vRefresh(Sender);         */
  oqClone->ParamByName("AN_SCHDUE")->AsInteger = (int) cbZone->Items->Objects[cbZone->ItemIndex];
  oqClone->Execute();
  vRefresh(this);
}
//---------------------------------------------------------------------------



void __fastcall TFormEditRates::cbZoneChange(TObject *Sender)
{
 if (EditRec)
 {
  SendMessage(Application->MainForm->ClientHandle, WM_MDIACTIVATE, (WPARAM)this->Handle, 0);
     switch (MessageBox(Handle, Reconst_smes43_5.c_str(),
                         Caption.c_str(), MB_YESNOCANCEL | MB_ICONQUESTION | MB_DEFBUTTON1))
      { case IDCANCEL:
                      cbZone->ItemIndex = Curent;
                      break;
        case IDYES:
                   vSave(this);
                   Curent = cbZone->ItemIndex;
                   vRefresh(this);
                   RateCB->Clear();
                   for(int i=0; i<SetRatesCount(); i++)
                    RateCB->Items->Add(rate_type[i]);
                   break;
        case IDNO: Curent = cbZone->ItemIndex;
                   RateCB->Clear();
                   for(int i=0; i<SetRatesCount(); i++)
                    RateCB->Items->Add(rate_type[i]); 
                   vRefresh(this);
                   break;

      }
 }
 else
 {
  vRefresh(this);
  Curent = cbZone->ItemIndex;
  RateCB->Clear();
  for(int i=0; i<SetRatesCount(); i++)
   RateCB->Items->Add(rate_type[i]);
 }
}
//---------------------------------------------------------------------------






