//---------------------------------------------------------------------------
#include <vcl.h>
#include <stdio.h>
#pragma hdrstop
#include "SelectSvitchPoint.h"
#include "unDataMod.h"
#include "selectpoint.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma link "DBAccess"
#pragma link "MemDS"
#pragma link "Ora"
#pragma link "OraSmart"
#pragma resource "*.dfm"
TFormSelectSvitchPoint *FormSelectSvitchPoint;
//---------------------------------------------------------------------------
__fastcall TFormSelectSvitchPoint::TFormSelectSvitchPoint(TComponent* Owner)
	: TForm(Owner)
{
      InputMet = new TfmInputMeterage(this);
      LoadCombo(cbOV);
      if(customer_id==1){
      sbFind->Enabled=false;
      sbFind->Visible=false;
      }

}
//---------------------------------------------------------------------------
__fastcall TFormSelectSvitchPoint::~TFormSelectSvitchPoint()
{
      delete InputMet;
}
//---------------------------------------------------------------------------
void _fastcall TFormSelectSvitchPoint::LoadCombo(TComboBox* ptrCombo)        //читает из базы содержимое комбобоксов
                                                                             //в зависимости от иx имени
{
     if(ptrCombo->Name=="cbOV")
     {
      cbOV->Clear();
      cbPoints->Clear();
      FillSwitchQuery->ParamByName("par")->AsInteger = 1;
      FillSwitchQuery->Prepare();
      FillSwitchQuery->Execute();
      while (!FillSwitchQuery->Eof)
      {
       cbOV->Items->AddObject(FillSwitchQuery->FieldByName("vname")->AsString, (TObject*)FillSwitchQuery->FieldByName("mid")->AsInteger);
       FillSwitchQuery->Next();
      }
     }
     if(ptrCombo->Name=="cbPoints")
     {
      ptrCombo->Clear();
      FillPointQuery->ParamByName("param")->AsInteger = cbOV->ItemIndex>-1 ? (long)cbOV->Items->Objects[cbOV->ItemIndex]:0;
      FillPointQuery->Prepare();
      FillPointQuery->Execute();
      while (!FillPointQuery->Eof)
      {
       cbPoints->Items->AddObject(FillPointQuery->FieldByName("vname")->AsString, (TObject*)FillPointQuery->FieldByName("mid")->AsInteger);
       FillPointQuery->Next();
      }
     }
}
//---------------------------------------------------------------------------
void __fastcall TFormSelectSvitchPoint::SetMasks(TMaskEdit* me1, TMaskEdit* me2, TMaskEdit* me3, TMaskEdit* me4,
                                                 TMaskEdit* me5, TMaskEdit* me6, long PiontID)
{

          long MID = PiontID;
     me1->Text = "";me2->Text = "";me3->Text = "";me4->Text = "";me5->Text = "";me6->Text = "";
     me1->EditMask = "";me2->EditMask = "";me3->EditMask = "";me4->EditMask = "";me5->EditMask = "";me6->EditMask = "";
     /*dmMain->quMain->SQL->Text=" SELECT entype, digits, decode(f.q1234,'*',1,0)q1234 FROM "+SchemeName+"meters m, "+SchemeName+"feeders f WHERE f.mid = :par1 AND f.mid = m.mid";
     dmMain->quMain->ParamByName("par1")->AsInteger=MID;
     dmMain->quMain->Execute();*/

     SetMask->ParamByName("fmid")->AsInteger = MID;
     SetMask->Execute();

     InputMet->Label7->Caption = "Р птр:";
     InputMet->Label9->Caption = "Р ген:";
     InputMet->Q2Panel->Visible = false;
     InputMet->Q4Panel->Visible = false;
     InputMet->PgenPanel->Top = 96;
     InputMet->Label11->Caption = "Р птр:";
     InputMet->Label13->Caption = "Р ген:";
     InputMet->Q2FinishPanel->Visible = false;
     InputMet->Q4FinishPanel->Visible = false;
                      InputMet->PgenFinishPanel->Top = 113;
                      InputMet->StartGroupBox->Height = 123;
                      InputMet->FinishGroupBox->Top = 172;
                      InputMet->FinishGroupBox->Height = 143;
                      InputMet->Height = 380;

     while(!SetMask->Eof) {
        switch(SetMask->FieldByName("entype")->AsInteger)

         {
            /*case 1:
                   me1->EditMask = dmMain->quMain->FieldByName("digits")->IsNull?AnsiString(""):"!"+dmMain->quMain->FieldByName("digits")->AsString+";1;_";
                   break;
            case 2:
                   me2->EditMask=dmMain->quMain->FieldByName("digits")->IsNull?AnsiString(""):"!"+dmMain->quMain->FieldByName("digits")->AsString+";1;_";
                   break;
            case 3:
                   me3->EditMask = dmMain->quMain->FieldByName("digits")->IsNull?AnsiString(""):"!"+dmMain->quMain->FieldByName("digits")->AsString+";1;_";
                   break;
            case 5:
                   me5->EditMask = dmMain->quMain->FieldByName("digits")->IsNull?AnsiString(""):"!"+dmMain->quMain->FieldByName("digits")->AsString+";1;_";
                   break;*/
            case 7:
                   /*me1->EditMask = dmMain->quMain->FieldByName("digits")->IsNull?AnsiString(""):"!"+dmMain->quMain->FieldByName("digits")->AsString+";1;_";
                   me2->EditMask = dmMain->quMain->FieldByName("digits")->IsNull?AnsiString(""):"!"+dmMain->quMain->FieldByName("digits")->AsString+";1;_";
                   me3->EditMask = dmMain->quMain->FieldByName("digits")->IsNull?AnsiString(""):"!"+dmMain->quMain->FieldByName("digits")->AsString+";1;_";
                   me4->EditMask = dmMain->quMain->FieldByName("digits")->IsNull?AnsiString(""):"!"+dmMain->quMain->FieldByName("digits")->AsString+";1;_";
                   me5->EditMask = dmMain->quMain->FieldByName("digits")->IsNull?AnsiString(""):"!"+dmMain->quMain->FieldByName("digits")->AsString+";1;_";
                   me6->EditMask = dmMain->quMain->FieldByName("digits")->IsNull?AnsiString(""):"!"+dmMain->quMain->FieldByName("digits")->AsString+";1;_";*/
                   if(SetMask->FieldByName("q1234")->AsInteger)
                   {                                      //если выбран интелектуальный счетчик
                      InputMet->Label7->Caption = "Q1:";  //проверяем, квадранты или нет
                      InputMet->Label9->Caption = "Q3:";
                      InputMet->Q2Panel->Visible = true;
                      InputMet->Q4Panel->Visible = true;
                      InputMet->PgenPanel->Top = 118;
                      InputMet->Label11->Caption = "Q1:";
                      InputMet->Label13->Caption = "Q3:";
                      InputMet->Q2FinishPanel->Visible = true;
                      InputMet->Q4FinishPanel->Visible = true;
                      InputMet->PgenFinishPanel->Top = 139;
                      InputMet->StartGroupBox->Height = 174;
                      InputMet->FinishGroupBox->Top = 226;
                      InputMet->FinishGroupBox->Height = 195;
                      InputMet->Height = 488;
                   }
                   else
                   {                                      
                      InputMet->Label7->Caption = "Р птр:";
                      InputMet->Label9->Caption = "Р ген:";
                      InputMet->Q2Panel->Visible = false;
                      InputMet->Q4Panel->Visible = false;
                      InputMet->PgenPanel->Top = 96;
                      InputMet->Label11->Caption = "Р птр:";
                      InputMet->Label13->Caption = "Р ген:";
                      InputMet->Q2FinishPanel->Visible = false;
                      InputMet->Q4FinishPanel->Visible = false;
                      InputMet->PgenFinishPanel->Top = 113;
                      InputMet->StartGroupBox->Height = 123;
                      InputMet->FinishGroupBox->Top = 172;
                      InputMet->FinishGroupBox->Height = 143;
                      InputMet->Height = 380;
                   }
                   break;
              }
       SetMask->Next();
     }
     me1->Enabled = true; //в любом случае будут видны
     me2->Enabled = true;
     me3->Enabled = true;
     me5->Enabled = true;
}
//---------------------------------------------------------------------------

void __fastcall TFormSelectSvitchPoint::cbOVChange(TObject *Sender)
{
   if(cbOV->ItemIndex>=0)
   {
      SetMasks(InputMet->meERM,InputMet->meEDM,InputMet->meQ1M,InputMet->meQ2M,
               InputMet->meQ3M,InputMet->meQ4M,(long)cbOV->Items->Objects[cbOV->ItemIndex]);
      //По постановке Вештака все поля ввода должны иметь 6 знаков после запятой, независимо
      //от формата, указанного в базе
      /*InputMet->meERM->EditMask = "!999999.999999;1; ";
      InputMet->meEDM->EditMask = "!999999.999999;1; ";
      InputMet->meQ1M->EditMask = "!999999.999999;1; ";
      InputMet->meQ2M->EditMask = "!999999.999999;1; ";
      InputMet->meQ3M->EditMask = "!999999.999999;1; ";
      InputMet->meQ4M->EditMask = "!999999.999999;1; ";*/

      InputMet->ModalResult = mrNone;
      bbInputMeterage->Font->Color = clRed;
   }
   LoadCombo(cbPoints);
}
//---------------------------------------------------------------------------

void __fastcall TFormSelectSvitchPoint::bbOKClick(TObject *Sender)
{
   try
   {
    opCheckSwitch->ParamByName("ANSWID")->AsInteger = (long)cbOV->Items->Objects[cbOV->ItemIndex];
    opCheckSwitch->Execute();
    if ((opCheckSwitch->ParamByName("RESULT")->AsInteger)&&(meDateSwitchOff->Text == "  .  .       :  "))
    {
     Application->MessageBox("Данный ОВ уже используется",Application->Title.c_str(),MB_OK);
     return;
    }
   if (meDateSwitchOff->Text != "  .  .       :  ")
    if(StrToDateTime(meDateSwitch->Text)>=StrToDateTime(meDateSwitchOff->Text))
    {
     Application->MessageBox("Дата перевода на ОВ не может быть больше или равна дате снятия",Application->Title.c_str(),MB_OK);
     return;
    }

    if(InputControl())
    {
       if (!bbInputMeterage->Enabled)
       {
         ModalResult = mrOk;
         return;
       }
 //      if(!DataControl()) throw Exception("По данному ОВ отсутствует график нагрузки. Опросите счетчик с помощью задачи оперативного опроса.");
       if(InputMet->ModalResult==mrOk)
        ModalResult = mrOk;
       else
       {
        if(Application->MessageBox(Reconst_smes58_4.c_str(),Application->Title.c_str(),
         MB_YESNO|MB_ICONWARNING|MB_DEFBUTTON2)==ID_YES)
           ModalResult = mrOk;
      }
    }


 }
  catch(EConvertError &e)
  {
   Application->MessageBox("Неверно введена дата/время!",Application->Title.c_str(),MB_OK);
  }

  catch (EOraError &e)
  {
   Application->MessageBox("Отсутствует подключение к базе данных",Application->Title.c_str(),MB_OK);
  }
  
  catch (Exception &e)
  {
   Application->MessageBox("Неизвестная ошибка!",Application->Title.c_str(),MB_OK);
  }
}
//---------------------------------------------------------------------------
void __fastcall TFormSelectSvitchPoint::bbInputMeterageClick(     //обработчик ввода параметров
      TObject *Sender)                                            //тут же заполняются рассчетные параметры (DataControl)
{
   int r = IDYES;
   if(!InputControl()) return;
   if(!DataControl())
     r = Application->MessageBox(Reconst_smes58_5.c_str(),Application->Title.c_str(),MB_YESNO|MB_ICONQUESTION);
     if(r==IDYES&&InputMet->ShowModal()==mrOk)   //Вызывается форма ввода показаний, введенные данные хранятся в ее контролах
       bbInputMeterage->Font->Color = clBlack;
}
//---------------------------------------------------------------------------
bool __fastcall TFormSelectSvitchPoint::InputControl()//проверяет формат даты переключения
{
     TWinControl* Ctrl;
     int meEnabled, meNoInput;
   try
   {
      Ctrl = meDateSwitch;
      try
      {
       if (meDateSwitchOff->Text!="  .  .       :  ")
        {
         StrToDateTime(meDateSwitchOff->Text);
         InputMet->FinishGroupBox->Enabled = true;
         InputMet->PgenFinishPanel->Enabled = true;
        }
        else
        {
         InputMet->PgenFinishPanel->Enabled = false;
         InputMet->FinishGroupBox->Enabled = false;

        }
        StrToDateTime(meDateSwitch->Text);
      }
      catch(EConvertError &ce)
      { throw Exception (Reconst_smes58_6); }
      Ctrl = cbOV;
      if(cbOV->ItemIndex<0) throw Exception (Reconst_smes58_7);
      Ctrl = cbPoints;
      if(cbPoints->ItemIndex<0) throw Exception (Reconst_smes58_8);
   }
   catch(Exception &e)
   {
      ActiveControl = Ctrl;
      Application->MessageBox(e.Message.c_str(),Application->Title.c_str(),MB_OK|MB_ICONERROR);
      return false;
   }
   return true;
}
//---------------------------------------------------------------------------
bool __fastcall TFormSelectSvitchPoint::DataControl()      //заполняет контролы подсказок получасовыми данными
{
   bool ret = false;
   char CalcMet[12][20];
   char TimeMet[2][20];
   char DTSwitch[20];
   long ID;
   short indic;

   oqPointLimits->Close();
   oqPointLimits->ParamByName("an_mid")->AsInteger = (long)cbPoints->Items->Objects[cbPoints->ItemIndex];
   oqPointLimits->Execute();
   InputMet->getPointLimits(oqPointLimits);

   HourParProc->ParamByName("an_switch")->AsInteger = (long)cbOV->Items->Objects[cbOV->ItemIndex];
   HourParProc->ParamByName("ad_switch")->AsDateTime = StrToDateTime(meDateSwitch->Text);
   HourParProc->Prepare();
   HourParProc->Execute();

   InputMet->lTime1->Caption = HourParProc->ParamByName("time1")->IsNull ? "" : HourParProc->ParamByName("time1")->AsDateTime.FormatString("hh:nn").c_str();
   InputMet->meCalcERM1->Text = HourParProc->ParamByName("er1")->IsNull ? "" : HourParProc->ParamByName("er1")->AsString.c_str();
   InputMet->meCalcEDM1->Text = HourParProc->ParamByName("ed1")->IsNull ? "" : HourParProc->ParamByName("ed1")->AsString.c_str();
   InputMet->meCalcQ1M1->Text = HourParProc->ParamByName("q11")->IsNull ? "" : HourParProc->ParamByName("q11")->AsString.c_str();
   InputMet->meCalcQ2M1->Text = HourParProc->ParamByName("q21")->IsNull ? "" : HourParProc->ParamByName("q21")->AsString.c_str();
   InputMet->meCalcQ3M1->Text = HourParProc->ParamByName("q31")->IsNull ? "" : HourParProc->ParamByName("q31")->AsString.c_str();
   InputMet->meCalcQ4M1->Text = HourParProc->ParamByName("q41")->IsNull ? "" : HourParProc->ParamByName("q41")->AsString.c_str();
   InputMet->lTime2->Caption = HourParProc->ParamByName("time2")->IsNull ? "" : HourParProc->ParamByName("time2")->AsDateTime.FormatString("hh:nn").c_str();
   InputMet->meCalcERM2->Text = HourParProc->ParamByName("er2")->IsNull ? "" : HourParProc->ParamByName("er2")->AsString.c_str();
   InputMet->meCalcEDM2->Text = HourParProc->ParamByName("ed2")->IsNull ? "" : HourParProc->ParamByName("ed2")->AsString.c_str();
   InputMet->meCalcQ1M2->Text = HourParProc->ParamByName("q12")->IsNull ? "" : HourParProc->ParamByName("q12")->AsString.c_str();
   InputMet->meCalcQ2M2->Text = HourParProc->ParamByName("q22")->IsNull ? "" : HourParProc->ParamByName("q22")->AsString.c_str();
   InputMet->meCalcQ3M2->Text = HourParProc->ParamByName("q32")->IsNull ? "" : HourParProc->ParamByName("q32")->AsString.c_str();
   InputMet->meCalcQ4M2->Text = HourParProc->ParamByName("q42")->IsNull ? "" : HourParProc->ParamByName("q42")->AsString.c_str();
   if (InputMet->FinishGroupBox->Enabled)
   {
   HourParProc->ParamByName("an_switch")->AsInteger = (long)cbOV->Items->Objects[cbOV->ItemIndex];
   HourParProc->ParamByName("ad_switch")->AsDateTime = StrToDateTime(meDateSwitchOff->Text);
   HourParProc->Prepare();
   HourParProc->Execute();
   InputMet->LastTime1->Caption = HourParProc->ParamByName("time1")->IsNull ? "" : HourParProc->ParamByName("time1")->AsDateTime.FormatString("hh:nn").c_str();
   InputMet->meCalcERM1Last->Text = HourParProc->ParamByName("er1")->IsNull ? "" : HourParProc->ParamByName("er1")->AsString.c_str();
   InputMet->meEDMCalc1Last->Text = HourParProc->ParamByName("ed1")->IsNull ? "" : HourParProc->ParamByName("ed1")->AsString.c_str();
   InputMet->meQ1CalcLast1->Text = HourParProc->ParamByName("q11")->IsNull ? "" : HourParProc->ParamByName("q11")->AsString.c_str();
   InputMet->meQ2LastCalc1->Text = HourParProc->ParamByName("q21")->IsNull ? "" : HourParProc->ParamByName("q21")->AsString.c_str();
   InputMet->meQ3mLastCalc1->Text = HourParProc->ParamByName("q31")->IsNull ? "" : HourParProc->ParamByName("q31")->AsString.c_str();
   InputMet->meQ4LastCalc1->Text = HourParProc->ParamByName("q41")->IsNull ? "" : HourParProc->ParamByName("q41")->AsString.c_str();
   InputMet->LastTime2->Caption = HourParProc->ParamByName("time2")->IsNull ? "" : HourParProc->ParamByName("time2")->AsDateTime.FormatString("hh:nn").c_str();
   InputMet->meCalcERM2Last->Text = HourParProc->ParamByName("er2")->IsNull ? "" : HourParProc->ParamByName("er2")->AsString.c_str();
   InputMet->meEDMCalc2Last->Text = HourParProc->ParamByName("ed2")->IsNull ? "" : HourParProc->ParamByName("ed2")->AsString.c_str();
   InputMet->meQ1CalcLast2->Text = HourParProc->ParamByName("q12")->IsNull ? "" : HourParProc->ParamByName("q12")->AsString.c_str();
   InputMet->meQ2LastCalc2->Text = HourParProc->ParamByName("q22")->IsNull ? "" : HourParProc->ParamByName("q22")->AsString.c_str();
   InputMet->meQ3mLastCalc2->Text = HourParProc->ParamByName("q32")->IsNull ? "" : HourParProc->ParamByName("q32")->AsString.c_str();
   InputMet->meQ4LastCalc2->Text = HourParProc->ParamByName("q42")->IsNull ? "" : HourParProc->ParamByName("q42")->AsString.c_str();
   }


  /*or(int i=0; i<12; i++)
    { if(!AnsiString(CalcMet[i]).IsEmpty())  //если хотя бы одно значение не пустое
     {
         ret = true;
        // continue;
     }

    }

   if(ret)
       {  */
       AnsiString sVal;
       ret=true;
     /*  InputMet->meERM->ReadOnly = (InputMet->meCalcERM1->Text==InputMet->meCalcERM2->Text)? true:false;
       InputMet->meEDM->ReadOnly = (InputMet->meCalcEDM1->Text==InputMet->meCalcEDM2->Text)? true:false;
       InputMet->meQ1M->ReadOnly = (InputMet->meCalcQ1M1->Text==InputMet->meCalcQ1M2->Text)? true:false;
       InputMet->meQ2M->ReadOnly = (InputMet->meCalcQ1M1->Text==InputMet->meCalcQ1M2->Text)? true:false;
       InputMet->meQ3M->ReadOnly = (InputMet->meCalcQ1M1->Text==InputMet->meCalcQ1M2->Text)? true:false;
       InputMet->meQ4M->ReadOnly = (InputMet->meCalcQ1M1->Text==InputMet->meCalcQ1M2->Text)? true:false;*/

       /*InputMet->meERMLast
        InputMet->meEDMLast
        InputMet->meQ1Last
        InputMet->meQ2Last
        InputMet->meQ3Last
        InputMet->meQ4Last*/
/*
       sVal = (InputMet->meCalcERM1->Text==InputMet->meCalcERM2->Text||InputMet->lTime2->Caption.IsEmpty())? InputMet->meCalcERM1->Text:InputMet->meERM->Text;
       InputMet->meERM->Text = sVal.Pos(".")==0 ? sVal:sVal.SetLength(sVal.Pos(".")+(InputMet->meERM->Text.Length()-InputMet->meERM->Text.Pos(".")) );

       sVal = (InputMet->meCalcEDM1->Text==InputMet->meCalcEDM2->Text||InputMet->lTime2->Caption.IsEmpty())? InputMet->meCalcEDM1->Text:InputMet->meEDM->Text;
       InputMet->meEDM->Text = sVal.SetLength(sVal.Pos(".")+(InputMet->meEDM->Text.Length()-InputMet->meEDM->Text.Pos(".")) );

       sVal = (InputMet->meCalcQ1M1->Text==InputMet->meCalcQ1M2->Text||InputMet->lTime2->Caption.IsEmpty())? InputMet->meCalcQ1M1->Text:InputMet->meQ1M->Text;
       InputMet->meQ1M->Text = sVal.SetLength(sVal.Pos(".")+(InputMet->meQ1M->Text.Length()-InputMet->meQ1M->Text.Pos(".")) );

       sVal = (InputMet->meCalcQ1M1->Text==InputMet->meCalcQ1M2->Text||InputMet->lTime2->Caption.IsEmpty())? InputMet->meCalcQ2M1->Text:InputMet->meQ2M->Text;
       InputMet->meQ2M->Text = sVal.SetLength(sVal.Pos(".")+(InputMet->meQ2M->Text.Length()-InputMet->meQ2M->Text.Pos(".")) );

       sVal = (InputMet->meCalcQ1M1->Text==InputMet->meCalcQ1M2->Text||InputMet->lTime2->Caption.IsEmpty())? InputMet->meCalcQ3M1->Text:InputMet->meQ3M->Text;
       InputMet->meQ3M->Text = sVal.SetLength(sVal.Pos(".")+(InputMet->meQ3M->Text.Length()-InputMet->meQ3M->Text.Pos(".")) );

       sVal = (InputMet->meCalcQ1M1->Text==InputMet->meCalcQ1M1->Text||InputMet->lTime2->Caption.IsEmpty())? InputMet->meCalcQ4M1->Text:InputMet->meQ4M->Text;
       InputMet->meQ4M->Text = sVal.SetLength(sVal.Pos(".")+(InputMet->meQ4M->Text.Length()-InputMet->meQ4M->Text.Pos(".")) );
                                      */
        //какойто индийский код
      /* InputMet->meERM->EditMask = InputMet->meERM->ReadOnly ? AnsiString(""):InputMet->meERM->EditMask;
       InputMet->meEDM->EditMask = InputMet->meEDM->ReadOnly ? AnsiString(""):InputMet->meEDM->EditMask;
       InputMet->meQ1M->EditMask = InputMet->meQ1M->ReadOnly ? AnsiString(""):InputMet->meQ1M->EditMask;
       InputMet->meQ2M->EditMask = InputMet->meQ2M->ReadOnly ? AnsiString(""):InputMet->meQ2M->EditMask;
       InputMet->meQ3M->EditMask = InputMet->meQ3M->ReadOnly ? AnsiString(""):InputMet->meQ3M->EditMask;
       InputMet->meQ4M->EditMask = InputMet->meQ4M->ReadOnly ? AnsiString(""):InputMet->meQ4M->EditMask;*/

      /* InputMet->meERM->Text = (InputMet->meCalcERM1->Text==InputMet->meCalcERM2->Text||InputMet->lTime2->Caption.IsEmpty())? InputMet->meCalcERM1->Text:InputMet->meERM->Text;
       InputMet->meEDM->Text = (InputMet->meCalcEDM1->Text==InputMet->meCalcEDM2->Text||InputMet->lTime2->Caption.IsEmpty())? InputMet->meCalcEDM1->Text:InputMet->meEDM->Text;
       InputMet->meQ1M->Text = (InputMet->meCalcQ1M1->Text==InputMet->meCalcQ1M2->Text||InputMet->lTime2->Caption.IsEmpty())? InputMet->meCalcQ1M1->Text:InputMet->meQ1M->Text;
       InputMet->meQ2M->Text = (InputMet->meCalcQ1M1->Text==InputMet->meCalcQ1M2->Text||InputMet->lTime2->Caption.IsEmpty())? InputMet->meCalcQ2M1->Text:InputMet->meQ2M->Text;
       InputMet->meQ3M->Text = (InputMet->meCalcQ1M1->Text==InputMet->meCalcQ1M2->Text||InputMet->lTime2->Caption.IsEmpty())? InputMet->meCalcQ3M1->Text:InputMet->meQ3M->Text;
       InputMet->meQ4M->Text = (InputMet->meCalcQ1M1->Text==InputMet->meCalcQ1M1->Text||InputMet->lTime2->Caption.IsEmpty())? InputMet->meCalcQ4M1->Text:InputMet->meQ4M->Text;*/
       if (InputMet->FinishGroupBox->Enabled)
       {
        /*InputMet->meERMLast->ReadOnly = (InputMet->meCalcERM1Last->Text == InputMet->meCalcERM2Last->Text) ? true:false;
        InputMet->meEDMLast->ReadOnly = (InputMet->meEDMCalc1Last->Text == InputMet->meEDMCalc2Last->Text) ? true:false;
        InputMet->meQ1Last->ReadOnly  = (InputMet->meQ1CalcLast1->Text == InputMet->meQ1CalcLast2->Text) ? true:false;
        InputMet->meQ2Last->ReadOnly  = (InputMet->meQ2LastCalc1->Text == InputMet->meQ2LastCalc2->Text) ? true:false;
        InputMet->meQ3Last->ReadOnly  = (InputMet->meQ3mLastCalc1->Text == InputMet->meQ3mLastCalc2->Text) ? true:false;
        InputMet->meQ4Last->ReadOnly  = (InputMet->meQ4LastCalc1->Text == InputMet->meQ4LastCalc2->Text) ? true:false;*/

        /*InputMet->meERMLast->Text = (InputMet->meCalcERM1Last->Text == InputMet->meCalcERM2Last->Text || InputMet->LastTime2->Caption.IsEmpty()) ? InputMet->meCalcERM1Last->Text : InputMet->meERMLast->Text;
        InputMet->meEDMLast->Text = (InputMet->meEDMCalc1Last->Text == InputMet->meEDMCalc2Last->Text || InputMet->LastTime2->Caption.IsEmpty()) ? InputMet->meEDMCalc1Last->Text : InputMet->meEDMLast->Text;
        InputMet->meQ1Last->Text  = (InputMet->meQ1CalcLast1->Text == InputMet->meQ1CalcLast2->Text || InputMet->LastTime2->Caption.IsEmpty()) ? InputMet->meQ1CalcLast1->Text : InputMet->meQ1Last->Text;
        InputMet->meQ2Last->Text  = (InputMet->meQ2LastCalc1->Text == InputMet->meQ2LastCalc2->Text || InputMet->LastTime2->Caption.IsEmpty()) ? InputMet->meQ2LastCalc1->Text : InputMet->meQ2Last->Text;
        InputMet->meQ3Last->Text  = (InputMet->meQ3mLastCalc1->Text == InputMet->meQ3mLastCalc2->Text || InputMet->LastTime2->Caption.IsEmpty()) ? InputMet->meQ3mLastCalc1->Text : InputMet->meQ3Last->Text;
        InputMet->meQ4Last->Text  = (InputMet->meQ4LastCalc1->Text == InputMet->meQ4LastCalc2->Text || InputMet->LastTime2->Caption.IsEmpty()) ? InputMet->meQ4LastCalc1->Text : InputMet->meQ4Last->Text;*/
//     }
       }
   return ret;
}
//---------------------------------------------------------------------------

void __fastcall TFormSelectSvitchPoint::meDateSwitchChange(TObject *Sender)
{
       InputMet->meERM->Text = "";
       InputMet->meEDM->Text = "";
       InputMet->meQ1M->Text = "";
       InputMet->meQ2M->Text = "";
       InputMet->meQ3M->Text = "";
       InputMet->meQ4M->Text = "";
       bbInputMeterage->Font->Color = clRed;
}
//---------------------------------------------------------------------------
void TFormSelectSvitchPoint::SetPointByMID(int MID)
{
  for(int i = 0; i < cbPoints->Items->Count; i++)
  {
    if ((int)cbPoints->Items->Objects[i] == MID)
    {
      cbPoints->ItemIndex = i;
      break;
    }
  }
}
void __fastcall TFormSelectSvitchPoint::sbFindClick(TObject *Sender)
{

int flag=0;
GROUPDATAFORM gdf;
  TfmSelectPoint*sp=NULL;
   if(cbPoints->ItemIndex>-1)
   gdf.gid=(long) cbPoints->Items->Objects[cbPoints->ItemIndex];
   gdf.type=9;

 sp=new TfmSelectPoint(this, &gdf);
 sp->HelpContext=25034;
  if(sp->ShowModal()==mrOk)
  {

       for(int i = 0; i < cbPoints->Items->Count; i++)
        {
            if ((int)cbPoints->Items->Objects[i] == gdf.gid)
          {
           cbPoints->ItemIndex = i;
           flag=1;
           break;
          }

        }
     if(!flag&&(sp->tvMain->Selected->SelectedIndex==0||sp->tvMain->Selected->SelectedIndex==6)) {
      cbPoints->Items->AddObject(gdf.Name,(TObject*)gdf.gid);
      cbPoints->ItemIndex =cbPoints->Items->Count-1;
        }
   }
    flag=0;
    delete sp;
  
}
//---------------------------------------------------------------------------

