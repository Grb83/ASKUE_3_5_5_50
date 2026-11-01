//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "ValidParam.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TfmValidityForm *fmValidityForm;
//---------------------------------------------------------------------------
__fastcall TfmValidityForm::TfmValidityForm(TComponent* Owner,  char isvalid[32], AnsiString Name,AnsiString NameForm)
  : TForm(Owner)
{

  Caption= Caption + " " + Name + AnsiString(Reconst_smes126_62)+NameForm + "     " + AnsiString(isvalid);
  //AnsiString("Метка качества данных ")+Name+AnsiString(Reconst_smes126_62)+NameForm+"     "+AnsiString(isvalid);
   ReadData(isvalid);
}
//---------------------------------------------------------------------------

 void __fastcall TfmValidityForm::ReadData(char isval[32])
 {
 /*Основные поля
  0-достоверность (0-норма,1-недостоверные данные,2-зарезервированные данные,3-под вопросом)
  (0-ОК, 1-ошибка)
 1 - переполнение
 2-выход за границы
 3-нарушение калибровки источника
 4-дребезг сигнала
 5-сбой
 6-несвоевременные или неполные данные (устаревшие данные)
 7-неустойчивость
 8-неточность
 9-источник данных(0-процесс, 1-подставлено оператором)
 10-тестовые данные
 11-заблокированно оператором

 Дополнительные поля(00-обработка не выполнялась,01-недостаточно данных,10-ОК,11-Ошибка)
 12 -получение исходных данных
 13-контроль своевременности данных
 14-контроль по ЖС
 15-контроль границ
 16-Восстановление по первичным данным
 17-Верификация по первичным данным
 18-Учет ОВ
 19-Дорасчет
 20-Верификация по балансу

 21-Код источника данных  (0-нет данных,1-осн.прибор,2-дуб.прибор,3-ОИК,4-руч.ввод,5-макет,6-прибор ОВ,7-автом.вычисл.,8-подсист.вычисл.)
 22- Индикатор признака отчетных данных*/

 //isval="11111111111111122211111111111";

 TPanel *pl;
 TImage *im;
 TLabel *ed;
 TImage *Image1, *Image2, *Image3;
 int Tag;

 //перед открытием очищаем отметки о сообщениях
  for(int i=0;i<ComponentCount;i++) {
    ed=dynamic_cast<TLabel *>(Components[i]);
    if (ed&&ed->Tag==111)
    ed->Caption="";
  }
 // проход по всем компонентам и их индивидуальная настройка
 for(int i=0;i<ComponentCount;i++) {
      if (Components[i]->Tag!=1000) {
        pl=dynamic_cast<TPanel *>(Components[i]);
        im=dynamic_cast<TImage *>(Components[i]);
        ed=dynamic_cast<TLabel *>(Components[i]);

        if(im&&im->Tag>0&&im->Tag<=11&&im->Tag!=9&&im->Tag!=6){
          if(StrToInt(isval[im->Tag]))
            ImageList1->Draw(im->Canvas, 0 , 0 , 10, true);
          else
            ImageList1->Draw(im->Canvas, 0 , 0 , 12, true);
        }
        if(pl&&!pl->Tag){
         switch(StrToInt(isval[pl->Tag])){
            case 0: pl->Caption=Reconst_smes126_7;
                  break;
            case 1: pl->Caption=Reconst_smes126_8;
                  break;
            case 2: pl->Caption=Reconst_smes126_9;
                  break;
            case 3: pl->Caption=Reconst_smes126_10;
                  break;
         }
        }

        if(pl&&pl->Tag==9){
          if(StrToInt(isval[pl->Tag])){
            pl->Caption=Reconst_smes126_2;
          }
            else{
            pl->Caption=Reconst_smes126_1;
          }
        }

        if(pl&&pl->Tag==22){
          if(StrToInt(isval[pl->Tag])){
            pl->Caption=Reconst_smes126_3;
          }
          else{
            pl->Caption=Reconst_smes126_5;
          }
        }

        if(im&&im->Tag==9){
          if(StrToInt(isval[im->Tag])){
           im->Picture=imSubst->Picture;
          }
          else{
           im->Picture=imProcess->Picture;
          }
         }

        if(im&&im->Tag==22){
          if(StrToInt(isval[im->Tag])){
            im->Picture=imReported->Picture;
          }
          else {
            im->Picture=imNotReported->Picture;
          }
        }

        if(im&&im->Tag==0){
          switch(StrToInt(isval[im->Tag])){
            case 0: im->Picture=imOK->Picture;
                    break;
            case 1: im->Picture=imError->Picture;
                    break;
            case 2: im->Picture=imReserved->Picture;
                    break;
            case 3: im->Picture=imQuest->Picture;
                    break;
          }
        }

        if(ed&&ed->Tag==22){
          if(StrToInt(isval[ed->Tag])) {
            ed->Caption=Reconst_smes126_4;
            ed->Font->Color=clBlack;
          }
          else {
            ed->Caption=Reconst_smes126_6;
            ed->Font->Color=clGray;
          }
        }

        if(ed&&ed->Tag==18){
          switch(StrToInt(isval[ed->Tag])) {
            case 2:   ed->Caption=Reconst_smes126_23;
                      ed->Font->Color=clBlack;
                      break;
            default:  ed->Caption=Reconst_smes126_22;
                      ed->Font->Color=clGray;
                      break;
          }
        }

        if(ed&&ed->Tag==19){
          switch(StrToInt(isval[ed->Tag])) {
            case 2:   ed->Caption=Reconst_smes126_25;
                      ed->Font->Color=clBlack;
                      break;
            default:  ed->Caption=Reconst_smes126_24;
                      ed->Font->Color=clGray;
                      break;
          }
        }
        if(ed&&ed->Tag==21){
          switch(StrToInt(isval[ed->Tag])) {//21-Код источника данных
                                          //(0-нет данных,1-осн.прибор,2-дуб.прибор,
                                          //3-ОИК,4-руч.ввод,5-макет,6-прибор ОВ,7-рез.вычисл.)

            case 0: ed->Caption=Reconst_smes126_11;
                    break;
            case 1: ed->Caption=Reconst_smes126_12;
                    break;
            case 2: ed->Caption=Reconst_smes126_13;
                    break;
            case 3: ed->Caption=Reconst_smes126_14;
                    Label5->Caption="";
                    break;
            case 4: ed->Caption=Reconst_smes126_15;
                    break;
            case 5: ed->Caption=Reconst_smes126_16;
                    break;
            case 6: ed->Caption=Reconst_smes126_17;
                    break;
            case 7: ed->Caption=Reconst_smes126_19;
                    break;
            case 8: ed->Caption=Reconst_smes126_20;
                    break;

          }
        }

        if(ed&&ed->Tag==211){
          switch(StrToInt(isval[21])) {
            case 6:  ed->Caption=Reconst_smes126_18;
                     break;
            case 8:  ed->Caption=Reconst_smes126_20;
                     break;
            default: ed->Caption="";
          }
        }
     }
    }
    //вывод спискапоясняющих полей
         //Пояснение ПЕРЕПОЛНЕНИЕ
         tb1->Enabled=(StrToInt(isval[1]));
         if (!tb1->Enabled) Panel9->Visible=false;

         //Пояснение ГРАНИЦЫ
         if ((!StrToInt(isval[2])))
         {
            switch(StrToInt(isval[15]))
            {
              case 2:   tb2->Enabled=true;
                        Lbl2_1->Caption=Reconst_smes126_26;
                        Lbl2_2->Caption=Reconst_smes126_27;
                        break;

              default:   tb2->Enabled=false;
                        Panel11->Visible=false;
                        break;
            }
         }

         else
         {
          switch(StrToInt(isval[15]))
            {
              case 3:   tb2->Enabled=true;
                        Lbl2_1->Caption=Reconst_smes126_28;
                        Lbl2_2->Caption=Reconst_smes126_29;
                        break;

              default:  tb2->Enabled=true;
                        Lbl2_1->Caption=Reconst_smes126_30;
                        Lbl2_2->Caption=Reconst_smes126_31;
                        break;
            }
         }

         //Пояснение калибровка
         if ((!StrToInt(isval[3])))
         {
            switch(StrToInt(isval[14]))
            {
              case 2:   tb3->Enabled=true;
                        Lbl3_1->Caption=Reconst_smes126_32;
                        Lbl3_2->Caption=Reconst_smes126_33;
                        break;

              default:  tb3->Enabled=false;
                        Panel13->Visible=false;
                        break;
            }
         }

         else
         {
          switch(StrToInt(isval[14]))
            {
              case 3:   tb3->Enabled=true;
                        Lbl3_1->Caption=Reconst_smes126_34;
                        Lbl3_2->Caption=Reconst_smes126_35;
                        break;

              default:  tb3->Enabled=true;
                        Lbl3_1->Caption=Reconst_smes126_36;
                        Lbl3_2->Caption=Reconst_smes126_37;
                        break;
            }
         }

         //Пояснение СБОЙ
         if ((!StrToInt(isval[5])))
         {
            switch(StrToInt(isval[14]))
            {
              case 2:   tb5->Enabled=true;
                        Lbl5_1->Caption=Reconst_smes126_38;
                        Lbl5_2->Caption=Reconst_smes126_39;
                        break;

              default:  tb5->Enabled=false;
                        Panel17->Visible=false;
                        break;
            }
         }

         else
         {
          switch(StrToInt(isval[14]))
            {
              case 3:   tb5->Enabled=true;
                        Lbl5_1->Caption=Reconst_smes126_40;
                        Lbl5_2->Caption=Reconst_smes126_41;
                        break;

              default:  tb5->Enabled=true;
                        Lbl5_1->Caption=Reconst_smes126_42;
                        Lbl5_2->Caption=Reconst_smes126_43;
                        break;
            }
         }
         //Пояснение НЕСВОЕВРЕМЕННЫЕ ИЛИ НЕПОЛНЫЕ ДАННЫЕ
         tb6->Enabled=true;

         if(StrToInt(isval[0])!=2)
         {
          Lbl6_4->Caption=Reconst_smes126_63;
          if (StrToInt(isval[6])) ImageList1->Draw(QuatImage6->Canvas, 0 , 0 , 10, true);
          else ImageList1->Draw(QuatImage6->Canvas, 0, 0, 12, true);
         }
         else
         {
          ImageList1->Draw(QuatImage6->Canvas, 0, 0, 10, true);
          if (!StrToInt(isval[19])) Lbl6_4->Caption=Reconst_smes126_64;
          else Lbl6_4->Caption=Reconst_smes126_65;
         }

         if (!StrToInt(isval[6]))
         {
            switch(StrToInt(isval[13]))
            {
              case 2:   Lbl6_1->Caption=Reconst_smes126_44;
                        Lbl6_2->Caption=Reconst_smes126_45;
                        break;

              default:  break;
            }
         }

         else
         {
          switch(StrToInt(isval[13]))
            {
              case 3:   Lbl6_1->Caption=Reconst_smes126_46;
                        Lbl6_2->Caption=Reconst_smes126_47;
                        break;

              default:  Lbl6_1->Caption=Reconst_smes126_48;
                        Lbl6_2->Caption=Reconst_smes126_49;
                        break;
            }
            if (StrToInt(isval[11])) Lbl6_3->Caption=Reconst_smes126_50;
            else Lbl6_3->Caption="";
         }

         //Пояснение ПРОТИВОРЕЧИВОСТЬ
         if ((!StrToInt(isval[7])))
         {
          if((StrToInt(isval[17])!=2)&&(StrToInt(isval[20])!=2))
          {
            tb7->Enabled=false;
            Panel21->Visible=false;
          }
          else
          {
            if (StrToInt(isval[17])==2)
            {
              tb7->Enabled=true;
              Lbl7_1->Caption=Reconst_smes126_51;
              Lbl7_2->Caption=Reconst_smes126_52;
            }
            if (StrToInt(isval[20])==2)
            {
              tb7->Enabled=true;
              Lbl7_3->Caption=Reconst_smes126_53;
              Lbl7_4->Caption=Reconst_smes126_54;
            }
          }
         }

         else
         {
           if((StrToInt(isval[17])!=3)&&(StrToInt(isval[20])!=3))
          {
            tb7->Enabled=true;
            Lbl7_1->Caption=Reconst_smes126_55;
            Lbl7_2->Caption=Reconst_smes126_43;
          }
          else
          {
            if (StrToInt(isval[17])==3)
            {
              tb7->Enabled=true;
              Lbl7_1->Caption=Reconst_smes126_38;
              Lbl7_2->Caption=Reconst_smes126_56;
            }
            if (StrToInt(isval[20])==3)
            {
              tb7->Enabled=true;
              Lbl7_3->Caption=Reconst_smes126_38;
              Lbl7_4->Caption=Reconst_smes126_57;
            }
          }
         }

     //Пояснение ДРЕБЕЗГ СИГНАЛА
     tb4->Enabled=(StrToInt(isval[4]));
     if (!tb4->Enabled) Panel15->Visible=false;

     //Пояснение НЕТОЧНОСТЬ
     if(!StrToInt(isval[8]))
     {
        if (StrToInt(isval[16])==2)
        {
          tb8->Enabled=true;
          Lbl8_1->Caption=Reconst_smes126_38;
          Lbl8_2->Caption=Reconst_smes126_58;
        }
        else
        {
          tb8->Enabled=false;
          Panel25->Visible=false;
        }
     }
     else
     {
        if (StrToInt(isval[16])==3)
        {
          tb8->Enabled=true;
          Lbl8_3->Caption=Reconst_smes126_38;
          Lbl8_4->Caption=Reconst_smes126_59;
        }
        else
        {
          tb8->Enabled=true;
          Lbl8_3->Caption=Reconst_smes126_60;
          Lbl8_4->Caption=Reconst_smes126_43;

        }
     }
 }
//---------------------------------------------------------------------------------
void __fastcall TfmValidityForm::Action1Execute(TObject *Sender)
{
 Close();
}
//---------------------------------------------------------------------------

void __fastcall TfmValidityForm::FormCreate(TObject *Sender)
{
  Panel8->Height=QuatPanel1->Height+1;
  Panel10->Height=QuatPanel2->Height+1;
  Panel12->Height=QuatPanel3->Height+1;
  Panel14->Height=QuatPanel4->Height+1;
  Panel16->Height=QuatPanel5->Height+1;
  Panel18->Height=QuatPanel6->Height+1;
  Panel20->Height=QuatPanel7->Height+1;
  Panel22->Height=QuatPanel8->Height+1;

  Panel26->Width=Panel27->Width/3;
  Panel28->Width=Panel27->Width/3;
  Panel29->Width=Panel27->Width/3;


  for (int i=0; i<pcProp->PageCount; i++)
  {
    pcProp->Pages[i]->TabVisible=false;
  }

  pcProp->ActivePageIndex=0;


}
//---------------------------------------------------------------------------

void __fastcall TfmValidityForm::acListShowExecute(TObject *Sender)
{
TToolButton *Button=(TToolButton*)Sender;

switch (Button->Tag)
{
  case 1: if (Button->ImageIndex==9)
          {
            Panel8->Height=30+Panel9->Height;
            Panel9->Visible=true;
          }
          else
          {
            Panel8->Height=31;
            Panel9->Visible=false;
          }
          break;
  case 2: if (Button->ImageIndex==9)
          {
            Panel10->Height=30+Panel11->Height;
            Panel11->Visible=true;
          }
          else
          {
            Panel10->Height=31;
            Panel11->Visible=false;
          }

          break;
  case 3: if (Button->ImageIndex==9)
          {
            Panel12->Height=30+Panel13->Height;
            Panel13->Visible=true;
          }
          else
          {
            Panel12->Height=31;
            Panel13->Visible=false;
          }

          break;
  case 4: if (Button->ImageIndex==9)
          {
            Panel14->Height=30+Panel15->Height;
            Panel15->Visible=true;
          }
          else
          {
            Panel14->Height=31;
            Panel15->Visible=false;
          }

          break;
  case 5: if (Button->ImageIndex==9)
          {
            Panel16->Height=30+Panel17->Height;
            Panel17->Visible=true;
          }
          else
          {
            Panel16->Height=31;
            Panel17->Visible=false;
          }

          break;
  case 6: if (Button->ImageIndex==9)
          {
            Panel18->Height=30+Panel9->Height;
            Panel19->Visible=true;
          }
          else
          {
            Panel18->Height=31;
            Panel19->Visible=false;
          }

          break;
  case 7: if (Button->ImageIndex==9)
          {
            Panel20->Height=30+Panel21->Height;
            Panel21->Visible=true;
          }
          else
          {
            Panel20->Height=31;
            Panel21->Visible=false;
          }

          break;
  case 8: if (Button->ImageIndex==9)
          {
            Panel22->Height=30+Panel25->Height;
            Panel25->Visible=true;
           /* Panel8->Visible=false;
            Panel10->Visible=false;
            tbUP->Enabled=true; */
          }
          else
          {
            Panel22->Height=31;
            Panel25->Visible=false;
          }
          break;
}   

if(Button->ImageIndex==8) Button->ImageIndex=9;
else Button->ImageIndex=8;

if ((Panel22->Top+Panel22->Height)>(this->Height-Panel27->Height)) //410-75-20-240)
  tbDown->Enabled=true;

else tbDown->Enabled=false;

}
//---------------------------------------------------------------------------

void __fastcall TfmValidityForm::acPanelPressExecute(TObject *Sender)
{
  TPanel *pl;
  TImage *im;
  TLabel *ed;

  TPanel *Panel;

  pl=dynamic_cast<TPanel *>(Sender);
  im=dynamic_cast<TImage *>(Sender);
  ed=dynamic_cast<TLabel *>(Sender);

  if(pl)
    Panel=(TPanel*)Sender;
  if(im)
    Panel=(TPanel*)(im->Parent);
  if(ed)
    Panel=(TPanel*)(ed->Parent);  

  Panel26->BevelInner=bvRaised;
  Panel26->BevelOuter=bvRaised;

  Panel28->BevelInner=bvRaised;
  Panel28->BevelOuter=bvRaised;

  Panel29->BevelInner=bvRaised;
  Panel29->BevelOuter=bvRaised;

  Panel->BevelInner=bvLowered;
  Panel->BevelOuter=bvLowered;
  
  pcProp->ActivePageIndex=(Panel->Tag)/9;
}
//---------------------------------------------------------------------------
void __fastcall TfmValidityForm::tbUPClick(TObject *Sender)
{
 if(!Panel22->Visible)
  Panel22->Visible=true;

 else if((Panel22->Visible)&&(!Panel20->Visible))
  Panel20->Visible=true;

 else if((!Panel18->Visible)&&(Panel20->Visible) )
  Panel18->Visible=true;

 else if((!Panel16->Visible)&&(Panel18->Visible))
  Panel16->Visible=true;

 else if((!Panel14->Visible)&&(Panel16->Visible))
  Panel14->Visible=true;

 else if((!Panel12->Visible)&&(Panel14->Visible))
  Panel12->Visible=true;

 else if((!Panel10->Visible)&&(Panel12->Visible))
  Panel10->Visible=true;

 if((!Panel8->Visible)&&(Panel10->Visible))
  Panel8->Visible=true;

 if ((Panel22->Top+Panel22->Height)<=(this->Height-Panel27->Height)) //410-75-20-240)
  tbDown->Enabled=false;
 else tbDown->Enabled=true;

 if((Panel8->Visible)&&(Panel10->Visible)&&(Panel12->Visible)&&(Panel14->Visible)&&(Panel16->Visible)&&(Panel18->Visible)&&(Panel20->Visible)&&(Panel22->Visible))
  tbUP->Enabled=false;

}
//---------------------------------------------------------------------------
void __fastcall TfmValidityForm::tbDownClick(TObject *Sender)
{
  if(Panel8->Visible)
 Panel8->Visible=false;

 else if(Panel10->Visible)
 Panel10->Visible=false;

 else if(Panel12->Visible)
 Panel12->Visible=false;

 else if(Panel14->Visible)
 Panel14->Visible=false;

 else if(Panel16->Visible)
 Panel16->Visible=false;

 else if(Panel18->Visible)
 Panel18->Visible=false;

 else if(Panel20->Visible)
 Panel20->Visible=false;

 /*else if(Panel22->Visible)
 Panel22->Visible=false;  */

// if (!Panel8->Visible)
  tbUP->Enabled=true;

 if(!((Panel8->Visible)||(Panel10->Visible)||(Panel12->Visible)||(Panel14->Visible)||(Panel16->Visible)||(Panel18->Visible)||(Panel20->Visible)))
  tbDown->Enabled=false;

}
//---------------------------------------------------------------------------





