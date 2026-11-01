//-------------------------------------------------------------------------
#include <vcl.h>
#include <stdio.h>

#pragma hdrstop
#include "SelectSvitchPoint.h"
#include "SwitchOV.h"
#include "unDataMod.h"
#include "selectpoint.h"

#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma link "MemDS"
#pragma link "VirtualTable"
#pragma link "DBGridEh"
#pragma link "DBAccess"
#pragma link "Ora"
#pragma resource "*.dfm"
//---------------------------------------------------------------------------
__fastcall TFormSwitchOV::TFormSwitchOV(TComponent* Owner, AnsiString Name, TAccess a)
	: TMainForm(Owner, Name, a)
{
  JournalGridEh->OnDrawColumnCell   = JournalGridEhDrawColumnCell;
  SwitchOVGridEh->OnDrawColumnCell  = SwitchOVGridEhDrawColumnCell;

   ShowAction(iaSave, false);
   ShowAction(iaNew);
   iaParams->Caption = Reconst_smes61_1;
   ShowAction(iaParams);
   ShowAction(iaDelete);

   iaCheck->Caption = Reconst_smes61_2;
   bbCalc->Action = iaCheck;
   FilterStr = 0;
   Col_num = 8;
   iaNew->Enabled = wr_rights && (PageControl1->ActivePageIndex==0);
   dtFrom->DateTime = TDateTime::CurrentDate()-365;
   dtTill->DateTime = TDateTime::CurrentDate()+1;
   vRefresh(this);
}

//---------------------------------------------------------------------------
void __fastcall TFormSwitchOV::Read_OV_Journal()
{
  AnsiString sqlStr;
  try
  {
    oqStateOV->ParamByName("ORDER_BY")->AsInteger = 1;
    oqStateOV->ParamByName("DIRECT")->AsInteger = 1;
    oqStateOV->Execute();
  }catch(Exception &exception)
  {
    Application->ShowException(&exception);
  }
}
//---------------------------------------------------------------------------
void __fastcall TFormSwitchOV::Read_OV_Switch()//(const AnsiString FilterStr, int order, int dir)    //заполняет грид журнала переключений
{
  TWinControl *aControl;
  AnsiString sqlStr;
  try{
      aControl=edFrom;
      StrToTime(edFrom->Text+":00");
      aControl=edTill;
      StrToTime(edTill->Text+":00");
    }catch(Exception &e){
      edFrom->Text="00:00";
      edTill->Text="00:00";
      Application->MessageBox(Reconst_smes61_3.c_str(),Application->Title.c_str(),MB_OK	|MB_ICONWARNING);
      aControl->SetFocus();
    }

    oqSwitchOV->ParamByName("dFrom")->AsString = dtFrom->Date.FormatString("dd.mm.yyyy")+" "+edFrom->Text+":00";
    oqSwitchOV->ParamByName("dTill")->AsString = dtTill->Date.FormatString("dd.mm.yyyy")+" "+edTill->Text+":00";
    oqSwitchOV->ParamByName("order_by")->AsInteger = 1;
    oqSwitchOV->ParamByName("filter_str")->AsString = FilterStr;
    oqSwitchOV->ParamByName("direct")->AsInteger = 1;

    //--------------------------------заполнение из Курсора--------------------------------------------------------
/*    SelectSwitch->ParamByName("DFROM")->AsString = dtFrom->Date.FormatString("dd.mm.yyyy")+" "+edFrom->Text+":00";
    SelectSwitch->ParamByName("DTILL")->AsString = dtTill->Date.FormatString("dd.mm.yyyy")+" "+edTill->Text+":00";*/
    //-------------------------------------------------------------------------------------------------------------
    //SwitchOVGridEh->DataSource->DataSet->Refresh();
//    int temp =   SwitchOVGridEh->DataSource->DataSet->RecordCount;


//    SelectSwitch->Prepare();
    try
    {
    // SelectSwitch->Execute();
     oqSwitchOV->Execute();
    }
    catch (Exception &e)
    {
     Application->ShowException(&e);
    }
    if (oqSwitchOV->RecordCount)
     {
      iaParams->Enabled = true && wr_rights;
      iaDelete->Enabled = true && wr_rights;
     }
    else
     {
      iaParams->Enabled = false;
      iaDelete->Enabled = false;
     }
  Read_OV_Journal();
}
//---------------------------------------------------------------------------
void __fastcall TFormSwitchOV::AddEdit(bool onEdit)  //вызывается при Action iaNew и редактировании. Добавляет/редактирует запись
{                                                    //(вызывает форму выбора обводника и точки)
   bool CanSelect, isError = false;                  //в случае ModalResult == mrOk - вносит данные в БД
   long ID;                                          //в конструкторе создает форму ввода параметров
   long NSWITCH;                                     //и заполняет комбобоксы формы
   char DSWITCH[20];
   double ERM, EDM, Q1M, Q2M, Q3M, Q4M;
   long Mid;
   char user_id[20];
   AnsiString sql;
   short indic[6];
   if(onEdit && oqSwitchOV->RecordCount<=0) return;

   TFormSelectSvitchPoint *f = new TFormSelectSvitchPoint(this);
   if (onEdit)
   {
    f->cbOV->Enabled = false;

    if (((oqStateOV->FieldByName("POINTNAME")->AsString != "В резерве")&&(PageControl1->ActivePageIndex==0))||
        (oqSwitchOV->FieldByName("DESCAPE")->IsNull)&&(PageControl1->ActivePageIndex==1))
    {
     f->cbPoints->Enabled = false;
     f->sbFind->Enabled = false;
     f->meDateSwitch->Enabled = false;
    }
   }
   else
   {
    f->meDateSwitch->Enabled = true;
    f->cbOV->Enabled = true;
    f->cbPoints->Enabled = true;
    f->sbFind->Enabled = true;
   }
   while(true){
      try{
         if(!isError){
          if (PageControl1->ActivePageIndex == 1)
            {
                //f->cbOV->ItemIndex = f->cbOV->Items->IndexOfObject((TObject*)oqStateOV->FieldByName("mid")->AsInteger);
                f->cbOV->ItemIndex = f->cbOV->Items->IndexOfObject((TObject*)oqSwitchOV->FieldByName("nswitch")->AsInteger);
                f->cbOVChange(this);
             }
             else
             {
                f->cbOV->ItemIndex = f->cbOV->Items->IndexOfObject((TObject*)oqStateOV->FieldByName("mid")->AsInteger);
                f->cbOVChange(this);
             }
            if(onEdit)//в случае редактирования
            {
               f->Caption = Reconst_smes61_4;
               if (PageControl1->ActivePageIndex == 1)
               {
                if (!oqSwitchOV->FieldByName("DSWITCH")->IsNull)
                 f->meDateSwitch->Text = FormatDateTime("dd.mm.yyyy hh:nn",oqSwitchOV->FieldByName("DSWITCH")->AsDateTime); //заполняем даты включения и выключения
                if (!oqSwitchOV->FieldByName("DESCAPE")->IsNull)
                f->meDateSwitchOff->Text = FormatDateTime("dd.mm.yyyy hh:nn",oqSwitchOV->FieldByName("DESCAPE")->AsDateTime);
                if (!f->FillPointQuery->Locate("mid",oqSwitchOV->FieldByName("pmid")->AsInteger,TLocateOptions() << loCaseInsensitive))
                  f->cbPoints->Items->AddObject(oqSwitchOV->FieldByName("PointName")->AsString, (TObject*)oqSwitchOV->FieldByName("pmid")->AsInteger);
                f->cbPoints->ItemIndex = f->cbPoints->Items->IndexOfObject((TObject*)oqSwitchOV->FieldByName("pmid")->AsInteger);

                //тут заполняется содержимое формы параметров (начальные)
                f->InputMet->meERM->Text = oqSwitchOV->FieldByName("ERM")->AsFloat<0 ? AnsiString(""):oqSwitchOV->FieldByName("ERM")->AsString;
                f->InputMet->meEDM->Text = oqSwitchOV->FieldByName("EDM")->AsFloat<0 ? AnsiString(""):oqSwitchOV->FieldByName("EDM")->AsString;
                f->InputMet->meQ1M->Text = oqSwitchOV->FieldByName("Q1M")->AsFloat<0 ? AnsiString(""):oqSwitchOV->FieldByName("Q1M")->AsString;
                f->InputMet->meQ2M->Text = oqSwitchOV->FieldByName("Q2M")->AsFloat<0 ? AnsiString(""):oqSwitchOV->FieldByName("Q2M")->AsString;
                f->InputMet->meQ3M->Text = oqSwitchOV->FieldByName("Q3M")->AsFloat<0 ? AnsiString(""):oqSwitchOV->FieldByName("Q3M")->AsString;
                f->InputMet->meQ4M->Text = oqSwitchOV->FieldByName("Q4M")->AsFloat<0 ? AnsiString(""):oqSwitchOV->FieldByName("Q4M")->AsString;
                //(конечные)
                f->InputMet->meERMLast->Text = oqSwitchOV->FieldByName("ERME")->AsFloat<0 ? AnsiString(""):oqSwitchOV->FieldByName("ERME")->AsString;
                f->InputMet->meEDMLast->Text = oqSwitchOV->FieldByName("EDME")->AsFloat<0 ? AnsiString(""):oqSwitchOV->FieldByName("EDME")->AsString;
                f->InputMet->meQ1Last->Text = oqSwitchOV->FieldByName("Q1ME")->AsFloat<0 ? AnsiString(""):oqSwitchOV->FieldByName("Q1ME")->AsString;
                f->InputMet->meQ2Last->Text = oqSwitchOV->FieldByName("Q2ME")->AsFloat<0 ? AnsiString(""):oqSwitchOV->FieldByName("Q2ME")->AsString;
                f->InputMet->meQ3Last->Text = oqSwitchOV->FieldByName("Q3ME")->AsFloat<0 ? AnsiString(""):oqSwitchOV->FieldByName("Q3ME")->AsString;
                f->InputMet->meQ4Last->Text = oqSwitchOV->FieldByName("Q4ME")->AsFloat<0 ? AnsiString(""):oqSwitchOV->FieldByName("Q4ME")->AsString;

                ID = oqSwitchOV->FieldByName("ID")->AsInteger;
               }else{  //тоже для текущих
                 if(oqStateOV->FieldByName("POINTNAME")->AsString != "В резерве"){
                   f->meDateSwitch->Text = oqStateOV->FieldByName("SwBegin")->IsNull ? AnsiString("") :  oqStateOV->FieldByName("SwBegin")->AsDateTime.FormatString("dd.mm.yyyy hh:nn");
                   f->meDateSwitchOff->Text = oqStateOV->FieldByName("SwEnd")->IsNull ? AnsiString("") :  oqStateOV->FieldByName("SwEnd")->AsDateTime.FormatString("dd.mm.yyyy hh:nn");
                 }
                 f->cbOVChange(this);
                 if (!f->FillPointQuery->Locate("vname",oqStateOV->FieldByName("PointName")->AsString,TLocateOptions() << loCaseInsensitive))
                   f->cbPoints->Items->AddObject(oqStateOV->FieldByName("PointName")->AsString, (TObject*)oqStateOV->FieldByName("pmid")->AsInteger);
                 f->cbPoints->ItemIndex = f->cbPoints->Items->IndexOfObject((TObject*)oqStateOV->FieldByName("pmid")->AsInteger);
                 ID = oqStateOV->FieldByName("ID")->AsInteger;
               }
            }else{ //onEdit  т.е. в случае добавления новых записей
               if (PageControl1->ActivePageIndex == 1)
                 NSWITCH = oqSwitchOV->FieldByName("nSwitch")->AsInteger;
               else
                 NSWITCH = oqStateOV->FieldByName("nSwitch")->AsInteger;

                oqGet_Date->ParamByName("id")->AsInteger = NSWITCH;
                oqGet_Date->Execute();
               if(oqGet_Date->Eof)
                 f->meDateSwitch->Text = Now().FormatString("dd.mm.yyyy hh:nn");
               else
                 f->meDateSwitch->Text = dmMain->quMain->FieldByName("DateStr")->AsString;


            }
            if (PageControl1->ActivePageIndex == 0)
            {
             if (oqStateOV->FieldByName("PointName")->AsString != "В резерве")
               f->SetPointByMID(oqStateOV->FieldByName("MID")->AsInteger);
            }
         }

         int EnableInputMeasurment;
         //dmMain->quMain->Execute();
         oqEIM->Execute();
         EnableInputMeasurment=oqEIM->ParamByName("EIM")->AsInteger;
        /* dmMain->quMain->Next();
         if(!dmMain->quMain->Eof) throw;*/
         f->bbInputMeterage->Enabled = (EnableInputMeasurment != 1);
         f->ShowModal();
         if(f->ModalResult == mrOk)
         {TOraStoredProc* Proc;
          if (onEdit)   //изменение или добавление записи
          {
           TDateTime a,b;
           if (!(f->meDateSwitchOff->Text == "  .  .       :  "))
           {
            a = StrToDateTime(f->meDateSwitchOff->Text);
           }
           else
           {
            a = NULL;
           }

           if (!(f->meDateSwitch->Text == "  .  .       :  "))
           {
            b = StrToDateTime(f->meDateSwitch->Text);
           }
           else
           {
            b = NULL;
           }
    //common_pg.userid_f
           Proc = SwUpdateProc;
           Proc->ParamByName("an_id")->AsInteger = ID;    // ID стороки
           Proc->ParamByName("an_switch")->AsInteger = (long)f->cbOV->Items->Objects[f->cbOV->ItemIndex];      //ID обводника
           if ((int)b) Proc->ParamByName("ad_switch")->AsDateTime = b; else Proc->ParamByName("ad_switchLast")->Clear();
           if ((int)a) Proc->ParamByName("ad_switchLast")->AsDateTime = a; else Proc->ParamByName("ad_switchLast")->Clear();
           Proc->ParamByName("an_mid")->AsInteger = (long)f->cbPoints->Items->Objects[f->cbPoints->ItemIndex];
           if (f->InputMet->meERM->Text.IsEmpty())
             Proc->ParamByName("an_erm")->Clear();
           else Proc->ParamByName("an_erm")->AsFloat = StrToFloat(f->InputMet->meERM->Text);
           if (f->InputMet->meEDM->Text.IsEmpty())
             Proc->ParamByName("an_edm")->Clear();
           else
             Proc->ParamByName("an_edm")->AsFloat = StrToFloat(f->InputMet->meEDM->Text);
           if (f->InputMet->meQ1M->Text.IsEmpty())
             Proc->ParamByName("an_q1m")->Clear();
           else
             Proc->ParamByName("an_q1m")->AsFloat = StrToFloat(f->InputMet->meQ1M->Text);
           if (f->InputMet->meQ2M->Text.IsEmpty())
             Proc->ParamByName("an_q2m")->Clear();
           else
             Proc->ParamByName("an_q2m")->AsFloat = StrToFloat(f->InputMet->meQ2M->Text);

           if (f->InputMet->meQ3M->Text.IsEmpty())
             Proc->ParamByName("an_q3m")->Clear();
           else Proc->ParamByName("an_q3m")->AsFloat = StrToFloat(f->InputMet->meQ3M->Text);
           if (f->InputMet->meQ4M->Text.IsEmpty())
             Proc->ParamByName("an_q4m")->Clear();
           else  
             Proc->ParamByName("an_q4m")->AsFloat = StrToFloat(f->InputMet->meQ4M->Text);
           if (f->InputMet->meERMLast->Text.IsEmpty())
             Proc->ParamByName("an_ermLast")->Clear();
           else
             Proc->ParamByName("an_ermLast")->AsFloat = StrToFloat(f->InputMet->meERMLast->Text);
           if (f->InputMet->meEDMLast->Text.IsEmpty())
             Proc->ParamByName("an_edmLast")->Clear();
           else
             Proc->ParamByName("an_edmLast")->AsFloat = StrToFloat(f->InputMet->meEDMLast->Text);
           if (f->InputMet->meQ1Last->Text.IsEmpty())
             Proc->ParamByName("an_q1Last")->Clear();
           else
           Proc->ParamByName("an_q1Last")->AsFloat = StrToFloat(f->InputMet->meQ1Last->Text);
           if (f->InputMet->meQ2Last->Text.IsEmpty())
             Proc->ParamByName("an_q2Last")->Clear();
           else
             Proc->ParamByName("an_q2Last")->AsFloat = StrToFloat(f->InputMet->meQ2Last->Text);
           if (f->InputMet->meQ3Last->Text.IsEmpty())
             Proc->ParamByName("an_q3Last")->Clear();
           else
             Proc->ParamByName("an_q3Last")->AsFloat = StrToFloat(f->InputMet->meQ3Last->Text);
           if (f->InputMet->meQ4Last->Text.IsEmpty())
             Proc->ParamByName("an_q4Last")->Clear();
           else
             Proc->ParamByName("an_q4Last")->AsFloat = StrToFloat(f->InputMet->meQ4Last->Text);

           try
            {
            Proc->Prepare();
            Proc->Execute();
            }
           catch (Exception &e)
           {
            Application->MessageBox(e.Message.c_str(),Application->Title.c_str(),MB_OK|MB_ICONERROR);
           }
          }
          else
          {
           Proc = SwInsertProc;
           TDateTime a;
           if (!(f->meDateSwitchOff->Text == "  .  .       :  "))
           {
            a = StrToDateTime(f->meDateSwitchOff->Text);
           }
           else
           {
            a = NULL;
           }
           //Proc->ParamByName("an_id")->AsInteger = ID;    // ID стороки
           Proc->ParamByName("an_switch")->AsInteger = (long)f->cbOV->Items->Objects[f->cbOV->ItemIndex];      //ID обводника
           Proc->ParamByName("ad_switch")->AsDateTime = StrToDateTime(f->meDateSwitch->Text); //дата ввода
           if ((int)a) Proc->ParamByName("ad_escape")->AsDateTime = a;
           else Proc->ParamByName("ad_escape")->Clear();
           Proc->ParamByName("an_mid")->AsInteger = (long)f->cbPoints->Items->Objects[f->cbPoints->ItemIndex];
           if (f->InputMet->meERM->Text.IsEmpty())
             Proc->ParamByName("an_erm")->Clear();
           else
             Proc->ParamByName("an_erm")->AsFloat = StrToFloat(f->InputMet->meERM->Text);
           if (f->InputMet->meEDM->Text.IsEmpty())
             Proc->ParamByName("an_edm")->Clear();
           else
             Proc->ParamByName("an_edm")->AsFloat = StrToFloat(f->InputMet->meEDM->Text);
           if (f->InputMet->meQ1M->Text.IsEmpty())
             Proc->ParamByName("an_q1m")->Clear();
           else
             Proc->ParamByName("an_q1m")->AsFloat = StrToFloat(f->InputMet->meQ1M->Text);
           if (f->InputMet->meQ2M->Text.IsEmpty())
             Proc->ParamByName("an_q2m")->Clear();
           else  
             Proc->ParamByName("an_q2m")->AsFloat = StrToFloat(f->InputMet->meQ2M->Text);
           if (f->InputMet->meQ3M->Text.IsEmpty())
             Proc->ParamByName("an_q3m")->Clear();
           else  
             Proc->ParamByName("an_q3m")->AsFloat = StrToFloat(f->InputMet->meQ3M->Text);
           if (f->InputMet->meQ4M->Text.IsEmpty())
             Proc->ParamByName("an_q4m")->Clear();
           else
             Proc->ParamByName("an_q4m")->AsFloat = StrToFloat(f->InputMet->meQ4M->Text);
           if (f->InputMet->meERMLast->Text.IsEmpty())
             Proc->ParamByName("an_ermLast")->Clear();
           else
             Proc->ParamByName("an_ermLast")->AsFloat = StrToFloat(f->InputMet->meERMLast->Text);
           if (f->InputMet->meEDMLast->Text.IsEmpty())
             Proc->ParamByName("an_edmLast")->Clear();
           else  
             Proc->ParamByName("an_edmLast")->AsFloat = StrToFloat(f->InputMet->meEDMLast->Text);
           if (f->InputMet->meQ1Last->Text.IsEmpty())
             Proc->ParamByName("an_q1Last")->Clear();
           else
             Proc->ParamByName("an_q1Last")->AsFloat = StrToFloat(f->InputMet->meQ1Last->Text);
           if (f->InputMet->meQ2Last->Text.IsEmpty())
             Proc->ParamByName("an_q2Last")->Clear();
           else
             Proc->ParamByName("an_q2Last")->AsFloat = StrToFloat(f->InputMet->meQ2Last->Text);
           if (f->InputMet->meQ3Last->Text.IsEmpty())
             Proc->ParamByName("an_q3Last")->Clear();
           else
             Proc->ParamByName("an_q3Last")->AsFloat = StrToFloat(f->InputMet->meQ3Last->Text);
           if (f->InputMet->meQ4Last->Text.IsEmpty())
             Proc->ParamByName("an_q4Last")->Clear();
           else
             Proc->ParamByName("an_q4Last")->AsFloat = StrToFloat(f->InputMet->meQ4Last->Text);
           try
            {
            Proc->Prepare();
            Proc->Execute();
            }
           catch (Exception &e)
           {
            Application->MessageBox(e.Message.c_str(),Application->Title.c_str(),MB_OK|MB_ICONERROR);
           }
           
          }
         }

         /*{
            dmMain->quMain->SQL->Text=sql;  //вызов процедуры редактирования или добавления
            NSWITCH = (long)f->cbOV->Items->Objects[f->cbOV->ItemIndex];
            strcpy(DSWITCH, f->meDateSwitch->Text.c_str());
            indic[0] = f->InputMet->meERM->Tag;
            indic[1] = f->InputMet->meEDM->Tag;
            indic[2] = f->InputMet->meQ1M->Tag;
            indic[3] = f->InputMet->meQ2M->Tag;
            indic[4] = f->InputMet->meQ3M->Tag;
            indic[5] = f->InputMet->meQ4M->Tag;

            //---------------------------------------  VNB 30.05.08
            dmMain->quMain->ParamByName("par1")->ParamType=ptInputOutput;
            dmMain->quMain->ParamByName("par1")->DataType=ftInteger;
            dmMain->quMain->ParamByName("par1")->AsInteger=ID;
            dmMain->quMain->ParamByName("par2")->AsInteger=NSWITCH;
            dmMain->quMain->ParamByName("par3")->AsString=DSWITCH;
            dmMain->quMain->ParamByName("par4")->AsInteger=(long)f->cbPoints->Items->Objects[f->cbPoints->ItemIndex];
           if(!indic[0])
             dmMain->quMain->ParamByName("par5")->AsFloat=SAATrim(f->InputMet->meERM->Text).ToDouble();
          else  dmMain->quMain->ParamByName("par5")->Clear();
          if(!indic[1])
             dmMain->quMain->ParamByName("par6")->AsFloat=SAATrim(f->InputMet->meEDM->Text).ToDouble();
          else  dmMain->quMain->ParamByName("par6")->Clear();
           if(!indic[2])
            dmMain->quMain->ParamByName("par7")->AsFloat=SAATrim(f->InputMet->meQ1M->Text).ToDouble();
          else  dmMain->quMain->ParamByName("par7")->Clear();
           if(!indic[3])
            dmMain->quMain->ParamByName("par8")->AsFloat=SAATrim(f->InputMet->meQ2M->Text).ToDouble();
          else  dmMain->quMain->ParamByName("par8")->Clear();
           if(!indic[4])
            dmMain->quMain->ParamByName("par9")->AsFloat=SAATrim(f->InputMet->meQ3M->Text).ToDouble();
          else  dmMain->quMain->ParamByName("par9")->Clear();
           if(!indic[5])
            dmMain->quMain->ParamByName("par10")->AsFloat=SAATrim(f->InputMet->meQ4M->Text).ToDouble();
          else  dmMain->quMain->ParamByName("par10")->Clear();
            dmMain->quMain->ParamByName("par11")->AsString=UsCon.User_Id;
            //-----------------------------------------


            dmMain->quMain->Execute();

            dmMain->orases->Commit();*/
            if (f->ModalResult == mrOk) Read_OV_Switch(); //обновляет таблицу

         break;

      } catch (Exception &e){
         isError = true;
         Application->MessageBox(e.Message.c_str(),Application->Title.c_str(),MB_OK|MB_ICONERROR);
      }
   }
   if(PageControl1->ActivePage == TabSheet2) SwitchOVGridEh->SetFocus();
   delete f;
}
//---------------------------------------------------------------------------
void __fastcall TFormSwitchOV::vDelete(TObject *Sender)    //удаление записи происходит тут
{
    if(SwitchOVGridEh->RowCount&&Application->MessageBox(AnsiString(Reconst_smes61_6+
        oqSwitchOV->FieldByName("SWITCHNAME")->AsString+" -> "+
        oqSwitchOV->FieldByName("POINTNAME")->AsString+" > на "+
        oqSwitchOV->FieldByName("DSWITCH")->AsString+"?").c_str(),
       Application->Title.c_str(),MB_YESNO|MB_ICONQUESTION|MB_DEFBUTTON2)==IDYES)
    {
        Del_proc->ParamByName("AN_ID")->AsInteger = oqSwitchOV->FieldByName("ID")->AsInteger;
        try
        {
         Del_proc->Prepare();
         Del_proc->Execute();
        }
        catch (Exception &e)
        {
         Application->MessageBox(e.Message.c_str(),Application->Title.c_str(),MB_OK|MB_ICONERROR);
        }
        Read_OV_Switch();
    }
   SwitchOVGridEh->SetFocus();
}
//---------------------------------------------------------------------------
void __fastcall TFormSwitchOV::vParams(TObject *Sender)
{
     AddEdit(true);
}
//---------------------------------------------------------------------------
void __fastcall TFormSwitchOV::vNew(TObject *Sender)
{
   AddEdit(false);
}
//---------------------------------------------------------------------------
void __fastcall TFormSwitchOV::SetAccess(TAccess value)
{                           //устанавливает доступ к контролам
   if(FAccess != value){
      TMainForm::SetAccess(value);
      wr_rights = value==accWrite;
      iaNew->Enabled = wr_rights;
      iaParams->Enabled = wr_rights;
      iaDelete->Enabled = wr_rights;
      iaCheck->Enabled = wr_rights;
   }
}
//---------------------------------------------------------------------------
void __fastcall TFormSwitchOV::vSave(TObject* Sender)
{
   //TODO: Add your source code here
}
//---------------------------------------------------------------------------
void __fastcall TFormSwitchOV::vRefresh(TObject* Sender)
{
   Read_OV_Switch();
   if (PageControl1->ActivePage == TabSheet2)
   {
    ActiveControl = SwitchOVGridEh;
    if (!oqSwitchOV->Eof)
      oqSwitchOV->First();
   }
}
//---------------------------------------------------------------------------
void __fastcall TFormSwitchOV::JournalGridEhTitleBtnClick(TObject *Sender,
      int ACol, TColumnEh *Column)
{
 if (Column->Title->SortMarker != smUpEh)
  {
    oqStateOV->ParamByName("direct")->AsInteger = 0;
    Column->Title->SortMarker = smUpEh;
  }
  else
  {
   Column->Title->SortMarker = smDownEh;
   oqStateOV->ParamByName("direct")->AsInteger = 1;
  }
  //int Col_num = 0;
  if (Column->Title->Caption == Reconst_smes61_12) Col_num = 1;
  if (Column->Title->Caption == Reconst_smes61_13) Col_num = 2;
  if (Column->Title->Caption == Reconst_smes61_14) Col_num = 3;

  oqStateOV->ParamByName("order_by")->AsInteger = Col_num;
  oqStateOV->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TFormSwitchOV::JournalGridEhDrawColumnCell(TObject *Sender,
      const TRect &Rect, int DataCol, TColumnEh *Column,
      TGridDrawState State)
{
  /*if (DataCol == 3)
  {

    if(oqStateOV->FieldByName("State")->AsInteger == 0)
     {
      JournalGridEh->Canvas->Brush->Color = clRed;
      JournalGridEh->Canvas->Font->Color   = clRed;
     }
       else
       {
        JournalGridEh->Canvas->Brush->Color = clLime;
        JournalGridEh->Canvas->Font->Color = clLime;
       }
  } */
  JournalGridEh->DefaultDrawColumnCell(Rect,DataCol,Column,State);
}
//---------------------------------------------------------------------------
void __fastcall TFormSwitchOV::TabSheet1Resize(TObject *Sender)
{
   int w = JournalGridEh->ClientWidth - 35;
   w -= JournalGridEh->Columns->Items[2]->Width;
   w -= JournalGridEh->Columns->Items[3]->Width;
   JournalGridEh->Columns->Items[0]->Width = w/2;
   JournalGridEh->Columns->Items[1]->Width = w/2;
}
//---------------------------------------------------------------------------
void __fastcall TFormSwitchOV::PageControl1Change(TObject *Sender)
{
//if (TPageControl(Sender).ActivePage == TPageControl(Sender).TabIndex)
 if (PageControl1->TabIndex)
  {
   iaDelete->Enabled = true && wr_rights;
   iaNew->Enabled = false;
   Col_num = 8;
  }
  else
   {
    iaDelete->Enabled = false;
    iaNew->Enabled = true && wr_rights;
    Col_num = 1;
   }
//  iaDelete->Enabled=(Access==accWrite&&PageControl1->ActivePageIndex);
  for (int i=0; i<JournalGridEh->Columns->Count-1; i++)
    JournalGridEh->Columns->Items[i]->Title->SortMarker = smNoneEh;
  for (int i=0; i<SwitchOVGridEh->Columns->Count-1; i++)
    SwitchOVGridEh->Columns->Items[i]->Title->SortMarker = smNoneEh;
  vRefresh(this);
}
//---------------------------------------------------------------------------
void __fastcall TFormSwitchOV::StateOVDSDataChange(TObject *Sender,
      TField *Field)
{
//   iaParams->Enabled = (Access==accWrite&&oqStateOV->FieldByName("SwBegin")->AsString != "");        //----------------------------ТУТ
}
//---------------------------------------------------------------------------
void __fastcall TFormSwitchOV::SwitchOVGridEhTitleBtnClick(TObject *Sender,
      int ACol, TColumnEh *Column)
{
  
  if (Column->Title->SortMarker != smUpEh)
  {

    Column->Title->SortMarker = smUpEh;
   oqSwitchOV->ParamByName("direct")->AsInteger = 1;
  }
  else
  {
   oqSwitchOV->ParamByName("direct")->AsInteger = 0;
    Column->Title->SortMarker = smDownEh;
  }
  
  if (Column->Title->Caption == Reconst_smes61_15) Col_num = 8;
  if (Column->Title->Caption == Reconst_smes61_16) Col_num = 7;
  if (Column->Title->Caption == Reconst_smes61_17) Col_num = 9;
  if (Column->Title->Caption == Reconst_smes61_18) Col_num = 10;
  if (Column->Title->Caption == Reconst_smes61_19) Col_num = 11;
  if (Column->Title->Caption == "PERSON") Col_num = 12;
  if (Column->Title->Caption == Reconst_smes61_19) Col_num = 24;
  if (Column->FieldName == "PERSONRET") Col_num = 25;

  oqSwitchOV->ParamByName("order_by")->AsInteger = Col_num;
  oqSwitchOV->ParamByName("dFrom")->AsString = dtFrom->Date.FormatString("dd.mm.yyyy")+" "+edFrom->Text+":00";
  oqSwitchOV->ParamByName("dTill")->AsString = dtTill->Date.FormatString("dd.mm.yyyy")+" "+edTill->Text+":00";
//  oqSwitchOV->ParamByName("filter_str")->AsString ="";
  oqSwitchOV->Execute();
//  Read_OV_Switch(const AnsiString FilterStr, int order, int dir)

}
//---------------------------------------------------------------------------
void __fastcall TFormSwitchOV::oqSwitchOVAfterScroll(TDataSet *DataSet)
{
  Label4->Caption = "Р птр:";
  Label6->Caption = "Р ген:";
  Label20->Caption = "Р птр::";
  Label21->Caption = "Р ген:";
  DBText1->Caption = "";
  DBText2->Caption = "";
  DBText3->Caption = "";
  DBText4->Caption = "";
  DBText5->Caption = "";
  DBText6->Caption = "";
//  DBText7->Caption = "";
  Label5->Visible = false;
  Label7->Visible = false;
  DBText4->Visible = false;
  DBText6->Visible = false;

  Label20->Visible = false;
  Label21->Visible = false;
  DBText10->Visible = false;
  DBText11->Visible = false;
  if(DataSet->FieldByName("q1234")->AsInteger)
    {
        Label4->Caption = "Q1:";
        Label6->Caption = "Q3:";
        Label5->Visible = true;
        Label7->Visible = true;
        DBText4->Visible = true;
        DBText6->Visible = true;

        Label20->Caption = "Q1:";
        Label21->Caption = "Q3:";
        Label20->Visible = true;
        Label21->Visible = true;
        DBText10->Visible = true;
        DBText11->Visible = true;
    }
    DBText1->Caption = DataSet->FieldByName("ERM")->AsFloat<0 ? AnsiString(""):DataSet->FieldByName("ERM")->AsString;
    DBText2->Caption = DataSet->FieldByName("EDM")->AsFloat<0 ? AnsiString(""):DataSet->FieldByName("EDM")->AsString;
    DBText3->Caption = DataSet->FieldByName("Q1M")->AsFloat<0 ? AnsiString(""):DataSet->FieldByName("Q1M")->AsString;
    DBText4->Caption = DataSet->FieldByName("Q2M")->AsFloat<0 ? AnsiString(""):DataSet->FieldByName("Q2M")->AsString;
    DBText5->Caption = DataSet->FieldByName("Q3M")->AsFloat<0 ? AnsiString(""):DataSet->FieldByName("Q3M")->AsString;
    DBText6->Caption = DataSet->FieldByName("Q4M")->AsFloat<0 ? AnsiString(""):DataSet->FieldByName("Q4M")->AsString;
//    DBText7->Caption = DataSet->FieldByName("VError")->AsString;
}
//---------------------------------------------------------------------------


//---------------------------------------------------------------------------
void __fastcall TFormSwitchOV::SwitchOVGridEhKeyDown(TObject *Sender,
      WORD &Key, TShiftState Shift)
{
   if(Access==accRead) return;
      if(Shift==TShiftState())
          switch(Key)
          {
               case VK_RETURN: vParams(iaParams); break;
               //case VK_INSERT: vNew(iaNew); break;
               case VK_DELETE: vDelete(iaDelete); break;
          }
}
//---------------------------------------------------------------------------
void __fastcall TFormSwitchOV::JournalGridEhDblClick(TObject *Sender)
{
/*  if (PageControl1->ActivePage == TabSheet1 && oqStateOV->FieldByName("PointName")&&oqStateOV->FieldByName("nswitch")->AsInteger!=0){
    FilterStr = " and s.nswitch=" +oqStateOV->FieldByName("nswitch")->AsString;
    eObject->Text = oqStateOV->FieldByName("switchname")->AsString;
    gid = oqStateOV->FieldByName("nswitch")->AsInteger;
    dtFrom->DateTime = 0;
    dtTill->DateTime = TDateTime::CurrentDate()+1;
    edFrom->Text="00:00";
    edTill->Text="00:00";
    JournalOrderStr = " 1 desc";
    SwitchOVGridEh->Columns->Items[0]->Title->SortMarker = smDownEh;
    PageControl1->ActivePage = TabSheet2;
    Read_OV_Switch();
  }*/
}

//---------------------------------------------------------------------------
void __fastcall TFormSwitchOV::btnFilterClick(TObject *Sender)
{
    GROUPDATAFORM gdf;
    if (gid) gdf.gid = gid;
    gdf.type = 1;
    TfmSelectPoint*sp = new TfmSelectPoint(this, &gdf);
    sp->Caption = Reconst_smes61_11;
    sp->HelpContext=52034;
    if(sp->ShowModal()==mrOk){
       eObject->Text  = gdf.Name;
       FilterStr = gdf.gid;
//       filter = eObject->Text;
//       StrCopy(filter.c_str(), eObject->Text.c_str());
       oqSwitchOV->ParamByName("dFrom")->AsString = dtFrom->Date.FormatString("dd.mm.yyyy")+" "+edFrom->Text+":00";
       oqSwitchOV->ParamByName("dTill")->AsString = dtTill->Date.FormatString("dd.mm.yyyy")+" "+edTill->Text+":00";
       oqSwitchOV->ParamByName("order_by")->AsInteger = 1;
       oqSwitchOV->ParamByName("filter_str")->AsInteger = FilterStr;
       oqSwitchOV->ParamByName("direct")->AsInteger = 0;
       oqSwitchOV->Execute();
       if (oqSwitchOV->RecordCount)
      {
      iaParams->Enabled = true && wr_rights;
      iaDelete->Enabled = true && wr_rights;
      }
      else
      {
      iaParams->Enabled = false;
      iaDelete->Enabled = false;
      }
       gid = gdf.gid;
    }
    delete sp;
}
//---------------------------------------------------------------------------
void __fastcall TFormSwitchOV::eObjectKeyPress(TObject *Sender, char &Key)
{
  if(Key==46)

    btnFilterClick(this);
}
//---------------------------------------------------------------------------
void __fastcall TFormSwitchOV::JournalGridEhKeyPress(TObject *Sender,
      char &Key)
{
  if(Key==VK_RETURN)
    JournalGridEhDblClick(this);
}
//---------------------------------------------------------------------------


//---------------------------------------------------------------------------





void __fastcall TFormSwitchOV::SwitchOVGridEhDrawColumnCell(
      TObject *Sender, const TRect &Rect, int DataCol, TColumnEh *Column,
      TGridDrawState State)
{

/*  if (DataCol == 4)
  {

    if(oqSwitchOV->FieldByName("nstate")->AsInteger == 0)
     {
      SwitchOVGridEh->Canvas->Brush->Color = clRed;
      SwitchOVGridEh->Canvas->Font->Color   = clRed;
     }
     else
     {
       SwitchOVGridEh->Canvas->Brush->Color = clLime;
       SwitchOVGridEh->Canvas->Font->Color = clLime;
     }
  }*/
    SwitchOVGridEh->DefaultDrawColumnCell(Rect,DataCol,Column,State);
  /*if (DataCol == 5){
    if(oqSwitchOV->FieldByName("NSWITCH")->AsInteger == oqSwitchOV->FieldByName("nmid")->AsInteger)
      SwitchOVGridEh->Canvas->TextRect(Rect,Rect.Left+2,Rect.Top+2,"Возврат");
    else
      SwitchOVGridEh->Canvas->TextRect(Rect,Rect.Left+2,Rect.Top+2,"Переключение");
  }                                                                                */
}
//---------------------------------------------------------------------------
 
void __fastcall TFormSwitchOV::oqSwitchOVDSWITCHGetText(TField *Sender,
      AnsiString &Text, bool DisplayText)
{
  if (!Sender->Value.IsNull())
 {
  /*
  AnsiString buf = DateTimeToStr((TDateTime)Sender->Value);
  Text = buf.Delete(17,3);*/
  AnsiString buf = ((TDateTime)Sender->Value).FormatString("dd.mm.yyyy hh:nn");
  Text = buf;
  }
}
//---------------------------------------------------------------------------
      /* if (TVarData(Sender->Value).VType != NULL)
 {
  AnsiString buf = DateTimeToStr((TDateTime)Sender->Value);
  Text = buf.Delete(17,3);
 }*/



void __fastcall TFormSwitchOV::oqSwitchOVDESCAPEGetText(TField *Sender,
      AnsiString &Text, bool DisplayText)
{
 if (!Sender->Value.IsNull())
 {
  /*
  AnsiString buf = DateTimeToStr((TDateTime)Sender->Value);
  Text = buf.Delete(17,3);*/
  AnsiString buf = ((TDateTime)Sender->Value).FormatString("dd.mm.yyyy hh:nn");
  Text = buf;
 }
}
//---------------------------------------------------------------------------

void __fastcall TFormSwitchOV::oqStateOVAfterScroll(TDataSet *DataSet)
{
  if(PageControl1->ActivePageIndex==0)
   if(oqStateOV->FieldByName("POINTNAME")->AsString != "В резерве")
    {
     iaNew->Enabled = false;
     iaParams->Enabled = true && wr_rights;
    }
   else
    {
     iaNew->Enabled = true && wr_rights;
     iaParams->Enabled = false;
    }
}
//GRB ADD 28.11.2022
//---------------------------------------------------------------------------
void __fastcall TFormSwitchOV::m_btnSaveClick(TObject *Sender)
{
      if (PageControl1->ActivePage == TabSheet1 ){
      SaveTable(this,JournalGridEh,/*TDateTime::CurrentDateTime().FormatString("dd.mm.yyyy hh:nn:ss")+"       "+*/TabSheet1->Caption);
      }
      if (PageControl1->ActivePage == TabSheet2 ){
      SaveTable(this,SwitchOVGridEh,/*TDateTime::CurrentDateTime().FormatString("dd.mm.yyyy hh:nn:ss")+"       "+*/TabSheet2->Caption);
      }
}
//---------------------------------------------------------------------------
void __fastcall TFormSwitchOV::SaveTable(TComponent* Owner,TDBGridEh *gr,AnsiString RepCaption){
  AnsiString s,fname;
  TStringList *StringList;
  TBookmark SavePlace;
  AnsiString  tab = char(9);
  TDataSet  *ds = gr->DataSource->DataSet;
  if (!ds || !ds->Active){
    Application->MessageBox(Reconst_smes44_4.c_str(),Application->Title.c_str(),MB_OK | MB_ICONSTOP);
    return;
  }
  this->SaveDialog1->Title = RepCaption+"...";
  this->SaveDialog1->DefaultExt = "txt";
  this->SaveDialog1->FileName=RepCaption;
  this->SaveDialog1->Filter = "Текстові документи (*.txt)|*.txt|Файл з роздільником (*.csv)|*.csv|Excel-таблиця (*.xls)|*.xls";
  if(this->SaveDialog1->Execute()){
    fname=this->SaveDialog1->FileName;
    }
  else{
    fname="";
    }
  //delete sd;
  if(fname.IsEmpty())
    return;

  try{
    StringList  = new TStringList;
    //Завголовок
    if(!RepCaption.IsEmpty())
      StringList->Add(RepCaption);
    s="";
    for (int i = 0; i < gr->Columns->Count; i++){
      if(gr->Columns->Items[i]->Visible&&gr->Columns->Items[i]->Field){
        if(!s.IsEmpty())
          s += tab;
        s+= gr->Columns->Items[i]->Title->Caption;
      }
    }
    StringList->Add(s);
    //Данные
    SavePlace = ds->GetBookmark();
    ds->DisableControls();
    ds->First();
    int cn  = 0;
    while (!ds->Eof){
      s="";
      for (int i = 0; i < gr->Columns->Count; i++){
        if (gr->Columns->Items[i]->Visible&&gr->Columns->Items[i]->Field){
          if(!s.IsEmpty())
            s += tab;
          if (gr->Columns->Items[i]->Field->DataType == ftDateTime)
            s += gr->Columns->Items[i]->Field->AsDateTime.FormatString("dd.mm.yyyy hh:nn:ss");
          else
            s += gr->Columns->Items[i]->Field->AsString;
        }
      }
      StringList->Add(s);
      cn++;
      ds->Next();
    }
    ds->GotoBookmark(SavePlace);
    ds->FreeBookmark(SavePlace);
    ds->EnableControls();
    StringList->SaveToFile(fname);
    delete  StringList;
    Application->MessageBox(AnsiString(AnsiString(Reconst_smes44_8) +
                              fname +
                              AnsiString(Reconst_smes44_9) +
                              IntToStr(cn) +
                              AnsiString(Reconst_smes44_10)).c_str(),
                            Application->Title.c_str(),
                            MB_OK | MB_ICONINFORMATION);
  }
  catch (Exception &e){
    delete  StringList;
    throw;
  }
}
//---------------------------------------------------------------------------

