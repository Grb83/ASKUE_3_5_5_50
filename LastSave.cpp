//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "LastSave.h"
#include "unDataMod.h"
#include "EditFiders.h"
#include "EditRequestPlan.h"
#include "RequestMonitoring.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "DBAccess"
#pragma link "MemDS"
#pragma link "Ora"
#pragma resource "*.dfm"
TLastSaveForm *LastSaveForm;
//---------------------------------------------------------------------------
__fastcall TLastSaveForm::TLastSaveForm(TComponent* Owner, AnsiString Name, long mid, TAccess a)
   : TMainForm(Owner,NULL,a), Mid(mid), chig(0)
{
  bool lIsChan=false; //Канал
  if(dynamic_cast<TFormEditFiders*>(Owner)){
        //TaskName = AnsiString("Состояние опроса для точки <")+Name+">";
        TaskName = AnsiString(Reconst_smes42_2)+Name+">";
        gbState->Caption=Reconst_smes42_3;
    }
    if(dynamic_cast<TfmEditRequestPlan*>(Owner)){
        lIsChan = true;
        //TaskName = AnsiString("Состояние опроса для канала <")+Name+">";
        TaskName = AnsiString(Reconst_smes42_2)+Name+">";
        gbState->Caption=Reconst_smes42_5;
    }
    if(dynamic_cast<TfmRequestMonitoring*>(Owner)){
      if (mid%100==2){
        lIsChan = true;
        TaskName = AnsiString(Reconst_smes42_2)+Name+">";
        gbState->Caption=Reconst_smes42_5;
        Mid=(mid-2)/100;
      }else{
        TaskName = AnsiString(Reconst_smes42_2)+Name+">";
        gbState->Caption=Reconst_smes42_3;
        Mid=(mid-3)/100;
      }
    }
    plChann->Visible = lIsChan;
    plChann->Enabled = lIsChan;
    accOFF=lIsChan?-1:dmMain->GetTaskRights(UsCon.Role_Id, 109);
    gbOFF->Visible = (accOFF >= TASK_RIGHTS_READ);
    
    Caption = TaskName;
    if(Access==accRead){
        eLuck->ReadOnly = true;
        eBill->ReadOnly = true;
        eHalfhour->ReadOnly = true;
        eMonth->ReadOnly = true;
        eProfile->ReadOnly = true;
        eTrial->ReadOnly = true;
        eTypeState->ReadOnly = true;
    }
    iaReceipt->Visible = true;
    iaReceipt->Enabled=(Access==accWrite);
}
//---------------------------------------------------------------------------
void __fastcall TLastSaveForm::FormCreate(TObject *Sender)
{
   vRefresh(Sender);
}
//---------------------------------------------------------------------------
void __fastcall TLastSaveForm::loadDate()
{
  try{
    oqLastSave->Params->Clear();
    oqLastSave->SQL->Text="begin "+SchemeName+"UN_MAIN_PG.loaddate(:par1,:par2); end;";
    oqLastSave->ParamByName("par2")->ParamType = ptOutput;
    oqLastSave->ParamByName("par2")->DataType = ftCursor;
    oqLastSave->ParamByName("par1")->AsInteger=Mid;
    oqLastSave->Execute();
    bool b=false;
    if(!oqLastSave->Eof){
       eProfile->Text = oqLastSave->FieldByName("profile")->AsString;
       eHalfhour->Text = oqLastSave->FieldByName("halfhour")->AsString;
       eBill->Text = oqLastSave->FieldByName("bill")->AsString;
       eMonth->Text = oqLastSave->FieldByName("month")->AsString;
       mDescrState->Text = oqLastSave->FieldByName("state_descr")->AsString;
       eClock->Text = oqLastSave->FieldByName("clock")->AsString;
       eLuck->Text = oqLastSave->FieldByName("luck")->AsString;
       eTrial->Text = oqLastSave->FieldByName("trial")->AsString;
       eDateState->Text = oqLastSave->FieldByName("state_date")->AsString;
       eTypeState->Text = oqLastSave->FieldByName("state_cod")->AsString;
       if(oqLastSave->FieldByName("state_cod")->AsInteger >= 0){
          if(oqLastSave->FieldByName("state_cod")->AsInteger>0 && oqLastSave->FieldByName("state_cod")->AsInteger<50)
             imList->GetBitmap(0, iState->Picture->Bitmap);
          else
             imList->GetBitmap(1, iState->Picture->Bitmap);
       }
       if(accOFF >= TASK_RIGHTS_READ){
          switch (oqLastSave->FieldByName("NOFF")->AsInteger){
            case 1:
               lbStateOFF->Caption="Отключен "+oqLastSave->FieldByName("DOFF")->AsDateTime.FormatString("dd.mm.yyyy hh:nn:ss");
               lbStateOFF->Font->Color=clBlue;
               break;
            case 0: ;
               lbStateOFF->Caption="Включен "+oqLastSave->FieldByName("DOFF")->AsDateTime.FormatString("dd.mm.yyyy hh:nn:ss");
               lbStateOFF->Font->Color=clWindowText;
               break;
            default:
               lbStateOFF->Caption="Неизвестно";
               lbStateOFF->Font->Color=clWindowText;
          }
          AnsiString lCMD;
          int lcmdoff=oqLastSave->FieldByName("NCMDOFF")->AsInteger;
          if(!oqLastSave->FieldByName("DCMDOFF")->AsString.IsEmpty()){
            switch (lcmdoff){
              case 1:
                lCMD="на ОТКЛЮЧЕНИЕ";
                break;
              case 2:
                lCMD="на ВКЛЮЧЕНИЕ";
                break;
              default:
                lCMD="ОТМЕНА";
                break;
            }
            lbCMD->Caption="Команда "+lCMD+" выдана "+oqLastSave->FieldByName("DCMDOFF")->AsDateTime.FormatString("dd.mm.yyyy hh:nn:ss");
            if(lcmdoff==1||lcmdoff==2){
              if(oqLastSave->FieldByName("DEXECMDOFF")->AsString.IsEmpty())
                lbCMDState->Caption="Команда ожидает передачи роутеру.";
              else
                lbCMDState->Caption="Команда передана роутеру "+oqLastSave->FieldByName("DEXECMDOFF")->AsDateTime.FormatString("dd.mm.yyyy hh:nn:ss");
            }else
              lbCMDState->Caption="";
          }else{
            lbCMD->Caption="";
            lbCMDState->Caption="";
          }
       }
       b=true;
    }
    oqLastSave->Close();
    if(!b){
      mDescrState->Text = Reconst_smes42_6;
      gbOFF->Visible=false;
    }
  }catch(Exception&e){
    Application->ShowException(&e);
  }
}
//---------------------------------------------------------------------------
void __fastcall TLastSaveForm::SaveChanged(void)
{
   AnsiString tmp,sql="begin "+SchemeName+"EDITFEEDERS_PG.upd_last_save(:par1,";

   try{
      if(TrimAll(eProfile->Text).IsEmpty())
         tmp = "NULL";
      else
         tmp = "TO_DATE('"+eProfile->Text+"','dd.mm.yyyy hh24:mi:ss')";
      sql += tmp+",";

      if(TrimAll(eHalfhour->Text).IsEmpty())
         tmp = "NULL";
      else
         tmp = "TO_DATE('"+eHalfhour->Text+"','dd.mm.yyyy hh24:mi:ss')";
      sql += tmp+",";

      if(TrimAll(eBill->Text).IsEmpty())
         tmp = "NULL";
      else
         tmp = "TO_DATE('"+eBill->Text+"','dd.mm.yyyy hh24:mi:ss')";
      sql += tmp+",";

      if(TrimAll(eMonth->Text).IsEmpty())
         tmp = "NULL";
      else
         tmp = "TO_DATE('"+eMonth->Text+"','dd.mm.yyyy hh24:mi:ss')";

      sql += tmp+"); end;";

      oqLastSave->Params->Clear();
      oqLastSave->SQL->Text=sql;
      oqLastSave->ParamByName("par1")->AsInteger=Mid;
      oqLastSave->Execute();
      EditRec = false;
   }catch(Exception&e){
      Application->ShowException(&e);
   }
}
//---------------------------------------------------------------------------
void __fastcall TLastSaveForm::vSave(TObject *Sender)
{
   SaveChanged();
}
//---------------------------------------------------------------------------
void __fastcall TLastSaveForm::vRefresh(TObject *Sender)
{
   chig = 1;
   loadDate();
   chig = 0;
}
//---------------------------------------------------------------------------
void __fastcall TLastSaveForm::vReceipt(TObject *Sender)
{
  if(MessageBox(Handle,Reconst_smes42_7.c_str(), Application->Title.c_str(), MB_YESNO | MB_ICONQUESTION | MB_DEFBUTTON2)!=IDYES)
    return;
  oqLastSave->Params->Clear();
  oqLastSave->SQL->Text= "begin "+SchemeName+"admin_pg.receipting_chan_p(:par1); end;" ;
  oqLastSave->ParamByName("par1")->AsInteger=Mid;
  try{
    oqLastSave->Execute();
  }catch(Exception &e){
    dmMain->orases->Rollback();
    throw;
  }
  vRefresh(Sender);
}
//---------------------------------------------------------------------------
void __fastcall TLastSaveForm::eDateChange(TObject *Sender)
{
   if(chig==0)
      EditRec = true;
}
//---------------------------------------------------------------------------
AnsiString __fastcall TLastSaveForm::TrimAll(AnsiString a)
{
   int i=1;
   while(i<=a.Length())
      if(a.IsDelimiter(".: ",i))
         a.Delete(i,1);
      else
         i++;
   return a;
}
//---------------------------------------------------------------------------

