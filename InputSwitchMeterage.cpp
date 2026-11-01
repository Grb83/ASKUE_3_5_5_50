//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#include "InputSwitchMeterage.h"
#include "unDataMod.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TfmInputMeterage *fmInputMeterage;
//---------------------------------------------------------------------------
__fastcall TfmInputMeterage::TfmInputMeterage(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TfmInputMeterage::EditKeyPress(TObject *Sender,
      char &Key)
{
        TMaskEdit* me = (TMaskEdit*)Sender;
        if(Key==',') Key = '.';
        //if(me->EditMask!="") return;
        bool setPoint = false;

/*      if((int)Key==VK_RETURN)
      {
        keybd_event(VK_RETURN, (byte) MapVirtualKey(VK_RETURN, 0), KEYEVENTF_KEYUP, 0);
        keybd_event(VK_TAB, (byte) MapVirtualKey(VK_TAB, 0), 0, 0);
        Key = NULL;
        return;
      }*/
      if(me->Text.Pos("."))
         setPoint = true;
      if((Key=='.') && (setPoint))
         Key = NULL;
      if((Key != '.') && ((((int)Key)<48) || (((int)Key)>57)) && (((int)Key)!=VK_BACK)||((Key=='.')&&(StrLen(me->Text.c_str())==0)))
      {
         Key = NULL;
         Beep();
      }
}
//---------------------------------------------------------------------------

void __fastcall TfmInputMeterage::EditChange(TObject *Sender)
{
        TMaskEdit* me = (TMaskEdit*)Sender;
     if(me->EditMask!="") return;
     TShiftState S;

        int DigitsAfterPoint = 0, Pos = 0;

      Pos = me->Text.Pos(".");
      if(Pos)
         DigitsAfterPoint = me->Text.Length() - Pos;
      else
      {
         if(me->Text.Length()>12)
         {
              keybd_event(VK_BACK, (byte) MapVirtualKey(VK_BACK, 0), 0, 0);
              keybd_event(VK_BACK, (byte) MapVirtualKey(VK_BACK, 0), KEYEVENTF_KEYUP, 0);
              Beep();
         }
      }
      if(DigitsAfterPoint>5)
      {
              keybd_event(VK_BACK, (byte) MapVirtualKey(VK_BACK, 0), 0, 0);
              keybd_event(VK_BACK, (byte) MapVirtualKey(VK_BACK, 0), KEYEVENTF_KEYUP, 0);
              Beep();
      }
}
//---------------------------------------------------------------------------
void __fastcall TfmInputMeterage::bbOKClick(TObject *Sender)       //введенные данные хранятся в самих контролах
{
/*      bool InpMet = false;
      ModalResult = mrNone;
         for(int i=0; i<ComponentCount; i++)
         {
            try
            {
                  if(dynamic_cast<TMaskEdit*>(Components[i])&&((TMaskEdit*)Components[i])->Enabled) //если компонент - TMaskEdit
                  {                                                                                 //проверить допустимость содержимого
                     Components[i]->Tag = -1;
                     if(!(((TMaskEdit*)Components[i])->Text.IsEmpty()||Trim(((TMaskEdit*)Components[i])->Text)=="."||
                         Trim(((TMaskEdit*)Components[i])->Text)==","))
                     {
                           SAATrim(((TMaskEdit*)Components[i])->Text).ToDouble();
                           LimitControl((TMaskEdit*)Components[i]);
                           Components[i]->Tag = 0;
                           InpMet = true;
                     }
                  }
            }
            catch(EConvertError &ce)
            {}
         }                                                          
      if(!InpMet) throw Exception("Не введены показания");
      ModalResult = mrOk;*/
  bool valid  = true, is_clear = true, mes = false, warning = false;
  int count = 0;
  ModalResult = mrNone;
  for (int i = 0; i<ComponentCount; i++)
  {try
   {
    if(dynamic_cast<TMaskEdit*>(Components[i])&&((TMaskEdit*)Components[i])->Parent->Enabled&&((TMaskEdit*)Components[i])->Tag<0
       &&((TMaskEdit*)Components[i])->Parent->Visible)
    {
     if (((TMaskEdit*)Components[i])->Text.IsEmpty())
      is_clear = false;
     else
      valid = LimitControl((TMaskEdit*)Components[i]);
      warning = WarningControl((TMaskEdit*)Components[i]);
      count++;
    }
    if (!valid || !is_clear || warning) mes = true; // || !is_clear

   }
   catch (EConvertError &ce)
   {}
  }
  if (mes)
  {
   if(MessageDlg(Reconst_smes40_1, mtWarning, mbOKCancel, 0) == mrOk)
     ModalResult = mrOk;
   else
     ModalResult = mrNone;
  }
  else
   ModalResult=mrOk;
}
//---------------------------------------------------------------------------
bool __fastcall TfmInputMeterage::LimitControl(TMaskEdit* me)    //проверяет диапазон ввода показаний
{
         double v, v1 = -1, v2 = -1;
       v = SAATrim(me->Text).ToDouble();
     if(me==meERM)
     {
          v1 = meCalcERM1->Text.IsEmpty()? -1 : StrToFloat(meCalcERM1->Text);//(!SAATrim(meCalcERM1->Text).IsEmpty()&&SAATrim(meCalcERM1->Text)!="."&&SAATrim(meCalcERM1->Text)!=",")?SAATrim(meCalcERM1->Text).ToDouble():-1;
          v2 = meCalcERM2->Text.IsEmpty()? -1 : StrToFloat(meCalcERM2->Text);//(!SAATrim(meCalcERM2->Text).IsEmpty()&&SAATrim(meCalcERM2->Text)!="."&&SAATrim(meCalcERM2->Text)!=",")?SAATrim(meCalcERM2->Text).ToDouble():-1;
     }
     if(me==meEDM)
     {
          v1 = meCalcEDM1->Text.IsEmpty() ? -1 : StrToFloat(meCalcEDM1->Text);//(!SAATrim(meCalcEDM1->Text).IsEmpty()&&SAATrim(meCalcEDM1->Text)!="."&&SAATrim(meCalcEDM1->Text)!=",")?SAATrim(meCalcEDM1->Text).ToDouble():-1;
          v2 = meCalcEDM2->Text.IsEmpty() ? -1 : StrToFloat(meCalcEDM2->Text);//(!SAATrim(meCalcEDM2->Text).IsEmpty()&&SAATrim(meCalcEDM2->Text)!="."&&SAATrim(meCalcEDM2->Text)!=",")?SAATrim(meCalcEDM2->Text).ToDouble():-1;
     }
     if(me==meQ1M)
     {
          v1 = meCalcQ1M1->Text.IsEmpty() ? -1 : StrToFloat(meCalcQ1M1->Text);//(!SAATrim(meCalcQ1M1->Text).IsEmpty()&&SAATrim(meCalcQ1M1->Text)!="."&&SAATrim(meCalcQ1M1->Text)!=",")?SAATrim(meCalcQ1M1->Text).ToDouble():-1;
          v2 = meCalcQ1M2->Text.IsEmpty() ? -1 : StrToFloat(meCalcQ1M2->Text);//(!SAATrim(meCalcQ1M2->Text).IsEmpty()&&SAATrim(meCalcQ1M2->Text)!="."&&SAATrim(meCalcQ1M2->Text)!=",")?SAATrim(meCalcQ1M2->Text).ToDouble():-1;
     }
     if(me==meQ2M)
     {
          v1 = meCalcQ2M1->Text.IsEmpty() ? -1 : StrToFloat(meCalcQ2M1->Text);//(!SAATrim(meCalcQ2M1->Text).IsEmpty()&&SAATrim(meCalcQ2M1->Text)!="."&&SAATrim(meCalcQ2M1->Text)!=",")?SAATrim(meCalcQ2M1->Text).ToDouble():-1;
          v2 = meCalcQ2M2->Text.IsEmpty() ? -1 : StrToFloat(meCalcQ2M2->Text);//(!SAATrim(meCalcQ2M2->Text).IsEmpty()&&SAATrim(meCalcQ2M2->Text)!="."&&SAATrim(meCalcQ2M2->Text)!=",")?SAATrim(meCalcQ2M2->Text).ToDouble():-1;
     }
     if(me==meQ3M)
     {
          v1 = meCalcQ3M1->Text.IsEmpty() ? -1 : StrToFloat(meCalcQ3M1->Text);//(!SAATrim(meCalcQ3M1->Text).IsEmpty()&&SAATrim(meCalcQ3M1->Text)!="."&&SAATrim(meCalcQ3M1->Text)!=",")?SAATrim(meCalcQ3M1->Text).ToDouble():-1;
          v2 = meCalcQ3M2->Text.IsEmpty() ? -1 : StrToFloat(meCalcQ3M2->Text);//(!SAATrim(meCalcQ3M2->Text).IsEmpty()&&SAATrim(meCalcQ3M2->Text)!="."&&SAATrim(meCalcQ3M2->Text)!=",")?SAATrim(meCalcQ3M2->Text).ToDouble():-1;
     }
     if(me==meQ4M)
     {
          v1 = meCalcQ4M1->Text.IsEmpty() ? -1 : StrToFloat(meCalcQ4M1->Text);//(!SAATrim(meCalcQ4M1->Text).IsEmpty()&&SAATrim(meCalcQ4M1->Text)!="."&&SAATrim(meCalcQ4M1->Text)!=",")?SAATrim(meCalcQ4M1->Text).ToDouble():-1;
          v2 = meCalcQ4M2->Text.IsEmpty() ? -1 : StrToFloat(meCalcQ4M2->Text);//(!SAATrim(meCalcQ4M2->Text).IsEmpty()&&SAATrim(meCalcQ4M2->Text)!="."&&SAATrim(meCalcQ4M2->Text)!=",")?SAATrim(meCalcQ4M2->Text).ToDouble():-1;
     }
     //---------------------Last------------------------
     if(me==meERMLast)
     {
          v1 = meCalcERM1Last->Text.IsEmpty() ? -1 : StrToFloat(meCalcERM1Last->Text);//(!SAATrim(meCalcERM1Last->Text).IsEmpty()&&SAATrim(meCalcERM1Last->Text)!="."&&SAATrim(meCalcERM1Last->Text)!=",")?SAATrim(meCalcERM1Last->Text).ToDouble():-1;
          v2 = meCalcERM2Last->Text.IsEmpty() ? -1 : StrToFloat(meCalcERM2Last->Text);//(!SAATrim(meCalcERM2Last->Text).IsEmpty()&&SAATrim(meCalcERM2Last->Text)!="."&&SAATrim(meCalcERM2Last->Text)!=",")?SAATrim(meCalcERM2Last->Text).ToDouble():-1;
     }

     if(me==meEDMLast)
     {
          v1 = meEDMCalc1Last->Text.IsEmpty() ? -1 : StrToFloat(meEDMCalc1Last->Text);//(!SAATrim(meEDMCalc1Last->Text).IsEmpty()&&SAATrim(meEDMCalc1Last->Text)!="."&&SAATrim(meEDMCalc1Last->Text)!=",")?SAATrim(meEDMCalc1Last->Text).ToDouble():-1;
          v2 = meEDMCalc2Last->Text.IsEmpty() ? -1 : StrToFloat(meEDMCalc2Last->Text);//(!SAATrim(meEDMCalc2Last->Text).IsEmpty()&&SAATrim(meEDMCalc2Last->Text)!="."&&SAATrim(meEDMCalc2Last->Text)!=",")?SAATrim(meEDMCalc2Last->Text).ToDouble():-1;
     }


     if(me==meQ1Last)
     {
          v1 = meQ1CalcLast1->Text.IsEmpty() ? -1 : StrToFloat(meQ1CalcLast1->Text);//(!SAATrim(meQ1CalcLast1->Text).IsEmpty()&&SAATrim(meQ1CalcLast1->Text)!="."&&SAATrim(meQ1CalcLast1->Text)!=",")?SAATrim(meQ1CalcLast1->Text).ToDouble():-1;
          v2 = meQ1CalcLast2->Text.IsEmpty() ? -1 : StrToFloat(meQ1CalcLast2->Text);//(!SAATrim(meQ1CalcLast2->Text).IsEmpty()&&SAATrim(meQ1CalcLast2->Text)!="."&&SAATrim(meQ1CalcLast2->Text)!=",")?SAATrim(meQ1CalcLast2->Text).ToDouble():-1;
     }

     if(me==meQ2Last)
     {
          v1 = meQ2LastCalc1->Text.IsEmpty() ? -1 : StrToFloat(meQ2LastCalc1->Text);//(!SAATrim(meQ2LastCalc1->Text).IsEmpty()&&SAATrim(meQ2LastCalc1->Text)!="."&&SAATrim(meQ2LastCalc1->Text)!=",")?SAATrim(meQ2LastCalc1->Text).ToDouble():-1;
          v2 = meQ2LastCalc2->Text.IsEmpty() ? -1 : StrToFloat(meQ2LastCalc2->Text);//(!SAATrim(meQ2LastCalc2->Text).IsEmpty()&&SAATrim(meQ2LastCalc2->Text)!="."&&SAATrim(meQ2LastCalc2->Text)!=",")?SAATrim(meQ2LastCalc2->Text).ToDouble():-1;
     }

     if(me==meQ3Last)
     {
          v1 = meQ3mLastCalc1->Text.IsEmpty() ? -1 : StrToFloat(meQ3mLastCalc1->Text);//(!SAATrim(meQ3mLastCalc1->Text).IsEmpty()&&SAATrim(meQ3mLastCalc1->Text)!="."&&SAATrim(meQ3mLastCalc1->Text)!=",")?SAATrim(meQ3mLastCalc1->Text).ToDouble():-1;
          v2 = meQ3mLastCalc2->Text.IsEmpty() ? -1 : StrToFloat(meQ3mLastCalc2->Text);//(!SAATrim(meQ3mLastCalc2->Text).IsEmpty()&&SAATrim(meQ3mLastCalc2->Text)!="."&&SAATrim(meQ3mLastCalc2->Text)!=",")?SAATrim(meQ3mLastCalc2->Text).ToDouble():-1;
     }

          if(me==meQ4Last)
     {
          v1 = meQ4LastCalc1->Text.IsEmpty() ? -1 : StrToFloat(meQ4LastCalc1->Text);//(!SAATrim(meQ4LastCalc1->Text).IsEmpty()&&SAATrim(meQ4LastCalc1->Text)!="."&&SAATrim(meQ4LastCalc1->Text)!=",")?SAATrim(meQ4LastCalc1->Text).ToDouble():-1;
          v2 = meQ4LastCalc2->Text.IsEmpty() ? -1 : StrToFloat(meQ4LastCalc2->Text);//(!SAATrim(meQ4LastCalc2->Text).IsEmpty()&&SAATrim(meQ4LastCalc2->Text)!="."&&SAATrim(meQ4LastCalc2->Text)!=",")?SAATrim(meQ4LastCalc2->Text).ToDouble():-1;
     }

     //-------------------------------------------------
     if ((v1!=-1) &&  (v2!=-1))
//      if(!(((!(v1<0)&&!(v2<0))&&v>=v1&&v<=v2)||((!(v1<0)&&v2<0)&&v==v1)||(v1<0&&v2<0)))
       if ((v<v1)||(v>v2))
     {
//        ActiveControl = me;
        return false;
     }
     return true;
}
//---------------------------------------------------------------------------
bool __fastcall TfmInputMeterage::WarningControl(TMaskEdit* me)    //проверяет предупредительные границы ввода показаний
{
     double v, v1 = -1, v2 = -1;
     v = SAATrim(me->Text).ToDouble();
     if (!oqPointLimits)
       return false;

     if(me==meERM || me==meERMLast)
     {
          v1 = oqPointLimits->FieldByName("ermin")->IsNull? -1 : oqPointLimits->FieldByName("ermin")->AsFloat;
          v2 = oqPointLimits->FieldByName("ermax")->IsNull? -1 : oqPointLimits->FieldByName("ermax")->AsFloat;
     }
     if(me==meEDM || me==meEDMLast)
     {
          v1 = oqPointLimits->FieldByName("edmin")->IsNull? -1 : oqPointLimits->FieldByName("edmin")->AsFloat;
          v2 = oqPointLimits->FieldByName("edmax")->IsNull? -1 : oqPointLimits->FieldByName("edmax")->AsFloat;
     }
     if(me==meQ1M || me==meQ1Last)
     {
          v1 = oqPointLimits->FieldByName("q1min")->IsNull? -1 : oqPointLimits->FieldByName("q1min")->AsFloat;
          v2 = oqPointLimits->FieldByName("q1max")->IsNull? -1 : oqPointLimits->FieldByName("q1max")->AsFloat;
     }
     if(me==meQ3M || me==meQ3Last)
     {
          v1 = oqPointLimits->FieldByName("q3min")->IsNull? -1 : oqPointLimits->FieldByName("q3min")->AsFloat;
          v2 = oqPointLimits->FieldByName("q3max")->IsNull? -1 : oqPointLimits->FieldByName("q3max")->AsFloat;
     }
     //-------------------------------------------------
     if ((v1!=-1) &&  (v2!=-1))
       if ((v<v1)||(v>v2))
       {
         return true;
       }
     return false;
}
//---------------------------------------------------------------------------
void __fastcall TfmInputMeterage::getPointLimits(TOraQuery* pOraQuery)
{
  oqPointLimits = pOraQuery;
}
//---------------------------------------------------------------------------
