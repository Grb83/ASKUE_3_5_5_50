//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "ValidParamOld.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TfmValidityFormOld *fmValidityFormOld;
//---------------------------------------------------------------------------
__fastcall TfmValidityFormOld::TfmValidityFormOld(TComponent* Owner,  char isvalid[32], AnsiString Name,AnsiString NameForm)
  : TForm(Owner)
{

  Caption= Reconst_smes126_1+Name+Reconst_smes126_2+NameForm;
   ReadData(isvalid);
}
//---------------------------------------------------------------------------

 void __fastcall TfmValidityFormOld::ReadData(char isval[32])
 {
 /*Основные поля
  0-достоверность (0-норма,1-недостоверные данные,2-зарезервированные данные,3-под вопросом)
  (0-ОК, 1-ошибка)
 1 - переполнение
 2-выход за границы
 3-нарушение калибровки источника
 4-дребезг сигнала
 5-сбой
 6-устаревшие данные
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
 22- Индикатор признака отчетных данных

 "01010101011010001110011000000"*/
 TPanel *pl;
 TImage *im;
 TLabel *ed;
 int Tag;
    for(int i=0;i<ComponentCount;i++)
    {
        pl=dynamic_cast<TPanel *>(Components[i]);
        im=dynamic_cast<TImage *>(Components[i]);
        ed=dynamic_cast<TLabel *>(Components[i]);

       if(ed&&ed->Tag==30)
       {
        switch(StrToInt(isval[ed->Tag-30]))
         {
          case 0: ed->Caption=Reconst_smes126_3;
                  Shape1->Brush->Color=(TColor)RGB(159,255,159); //clGreen
                  break;
          case 1: ed->Caption=Reconst_smes126_4; //clRed
                  Shape1->Brush->Color=clRed;
                  break;
          case 2: ed->Caption=Reconst_smes126_5;
                  Shape1->Brush->Color=(TColor)RGB(128,255,255); //clBlue
                  break;
          case 3: ed->Caption=Reconst_smes126_6;  //clYellow
                  Shape1->Brush->Color=(TColor)RGB(255,200,145);
                  break;
         }
        }

        if(pl&&pl->Tag>0&&pl->Tag<=11&&pl->Tag!=9)
        {
           if(StrToInt(isval[pl->Tag]))
           {
             pl->Hint+=Reconst_smes126_7;
            }
           else
           {
             pl->Hint+=Reconst_smes126_8;
           }
        }
        if(im&&im->Tag>0&&im->Tag<=11&&im->Tag!=9)
        {
           if(StrToInt(isval[im->Tag]))
            ImageList1->Draw(im->Canvas, 0 , 0 , 2, true);
           else
            ImageList1->Draw(im->Canvas, 0 , 0 , 0, true);
         }
       if(pl&&pl->Tag==9)
       {
         if(StrToInt(isval[pl->Tag])){
            pl->Caption=Reconst_smes126_9;
            ImageList1->Draw(QuatImage9->Canvas, 0 , 0 , 3, true);
            pl->Hint+=Reconst_smes126_10;
            }
           else
           {
            pl->Caption=Reconst_smes126_11;
            ImageList1->Draw(QuatImage9->Canvas, 0 , 0 , 0, true);
            pl->Hint+=Reconst_smes126_12;

           }
         }

        if(pl&&pl->Tag>11&&pl->Tag<=20)
        {
         switch(StrToInt(isval[pl->Tag]))
            {
            case 0: pl->Hint+=Reconst_smes126_13;
                    break;
            case 1: pl->Hint+=Reconst_smes126_14;
                    break;
            case 2: pl->Hint+=Reconst_smes126_15;
                    break;
            case 3: pl->Hint+=Reconst_smes126_16;
                    break;
            }
        }
         if(im&&im->Tag>11&&im->Tag<=20)
        {
           switch(StrToInt(isval[im->Tag]))
           {
             case 0:   ImageList1->Draw(im->Canvas, 0 , 0 , 4, true); break;
             case 1:   ImageList1->Draw(im->Canvas, 0 , 0 , 3, true); break;
             case 2:   ImageList1->Draw(im->Canvas, 0 , 0 , 5, true); break;
             case 3:   ImageList1->Draw(im->Canvas, 0 , 0 , 2, true); break;
           }
         }
        if(ed&&ed->Tag==21)
        {
        switch(StrToInt(isval[ed->Tag]))   //21-Код источника данных  (0-нет данных,1-осн.прибор,2-дуб.прибор,3-ОИК,4-руч.ввод,5-макет,6-прибор ОВ,7-рез.вычисл.)

            {
            case 0:// ed->Color=RGB(192,192,192);//Grey
                    ed->Caption=Reconst_smes126_17;
                    Shape2->Brush->Color=(TColor)RGB(192,192,192);//Grey
                    break;
            case 1: //ed->Color=RGB(159,255,159);//Green
                    ed->Caption=Reconst_smes126_18;
                    Shape2->Brush->Color=(TColor)RGB(159,255,159);//Green
                    break;
            case 2:// ed->Color=RGB(159,255,159);//Green
                    ed->Caption=Reconst_smes126_19;
                    Shape2->Brush->Color=(TColor)RGB(159,255,159);//Green
                    break;
            case 3: //ed->Color=RGB(147,147,255); //Blue
                    ed->Caption=Reconst_smes126_20;
                    Shape2->Brush->Color=(TColor)RGB(147,147,255); //Blue
                    break;
            case 4: //ed->Color=RGB(147,147,255);
                    ed->Caption=Reconst_smes126_21;
                    Shape2->Brush->Color=(TColor)RGB(147,147,255); //Blue
                    break;
            case 5: //ed->Color=RGB(147,147,255);
                    ed->Caption=Reconst_smes126_22;
                    Shape2->Brush->Color=(TColor)RGB(147,147,255); //Blue
                    break;
            case 6:// ed->Color=RGB(159,255,159);//Green
                    ed->Caption=Reconst_smes126_23;
                    Shape2->Brush->Color=(TColor)RGB(159,255,159);//Green
                    break;
            case 7:// ed->Color=RGB(128,255,255);
                    ed->Caption=Reconst_smes126_24;
                    Shape2->Brush->Color=(TColor)RGB(159,255,159);
                    break;
            case 8:// ed->Color=RGB(128,255,255);
                    ed->Caption=Reconst_smes126_25;
                    Shape2->Brush->Color=(TColor)RGB(147,147,255);
                    break;

            }
        }
        if(pl&&pl->Tag==22)
        {
         switch(StrToInt(isval[pl->Tag]))
            {
            case 0: pl->Hint=Reconst_smes126_26;
                    pl->Caption=Reconst_smes126_27;
                    pl->Color=clSilver;
                    ImageList1->Draw(QuatImage22->Canvas, 0 , 0 , 0, true);
                    break;
            case 1: pl->Hint=Reconst_smes126_28;
                    pl->Caption=Reconst_smes126_29;
                    pl->Color=(TColor)RGB(159,255,159);
                    ImageList1->Draw(QuatImage22->Canvas, 0 , 0 , 1, true);
                    break;
            }
        }


    }
 
 }
//---------------------------------------------------------------------------------


void __fastcall TfmValidityFormOld::Action1Execute(TObject *Sender)
{
 Close();  
}
//---------------------------------------------------------------------------

