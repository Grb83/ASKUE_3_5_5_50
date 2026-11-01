//---------------------------------------------------------------------------
#include <teeprevi.hpp>
#include <vcl.h>
#include <stdio.h>
#include <math.h>
#pragma hdrstop

#include "Interior.h"
#include "unDataMod.h"
#include "MonitorForm.h"
#include "Reconst.hpp"
#pragma package(smart_init)

const int IND_CNT=10;   // максимальное количество значений в ячейке интерьера
AnsiString TInterior::DateTimeFormat("dd'.'mm'.'yyyy hh':'nn':'ss");
extern HANDLE UpdateMonitors;
AnsiString MyFloatFormat = "###,###,##0.000;;0.00";
const int LenFloat=20;
int refreshDataCount=0;
//---------------------------------------------------------------------------

__fastcall TInterior::TInterior(TComponent* Owner,TSplitterForm *aSF,TFormDescr* aFD,Classes::TNotifyEvent OnPogr)
    : TComponent(Owner),fd(aFD), ColumnsCaption(NULL),SplitterForm(aSF)
{
    ReplaceRyda(this,BASE_SCHEME,SchemeName);
    TFormSetupMonitors*psm = new TFormSetupMonitors(Application);
	OnProgressBarStepBy=OnPogr;
    GroupIsList = 0;
	if(Owner!=NULL && dynamic_cast<TForm*>(Owner)!=NULL )
	{
		(dynamic_cast<TForm*>(Owner))->HelpContext=15;
		dynamic_cast<TForm*>(Owner)->Tag=0;
		dynamic_cast<TForm*>(Owner)->Color=clBtnFace;

        if( dynamic_cast<TBaseMonitorForm*>(Owner)->isSmallFont )
        {
            SplitterForm->Font->Size=psm->PanelColorTable->Font->Size;
            SplitterForm->Font->Name=psm->PanelColorTable->Font->Name;
        }
        else
        {
            SplitterForm->Font->Size=psm->PanelBWTable->Font->Size;
            SplitterForm->Font->Name=psm->PanelBWTable->Font->Name;
        }

        VT_PrintData = new TVirtualTable(this);
        VT_PrintData->Name = "VT_PrintData";
        ColumnsCaption = new TStringList();
/*        //-----------VNB 12.12.2008
        if(dynamic_cast<TBaseMonitorForm*>(Owner))
        {
         if(PowerCoeff==1)  //если не делим на тысячу
         {
             AnsiString s = ((TBaseMonitorForm*)Owner)->LabelComment->Caption;
             if( s.Pos("тыс."))
             {
              s = s.SubString(1,s.Pos("тыс.")-1)+s.SubString(s.Pos("тыс.")+ 4,s.Length());
              ((TBaseMonitorForm*)Owner)->LabelComment->Caption = s;
              }
          }
          if(PowerCoeff==1000)  //если делим на тысячу
          {
            AnsiString s = ((TBaseMonitorForm*)Owner)->LabelComment->Caption;
            if(s.Pos("[")&&!s.Pos("тыс."))
             {
              s = s.SubString(1,s.Pos("["))+ " тыс."+s.SubString(s.Pos("[")+1,s.Length());
              ((TBaseMonitorForm*)Owner)->LabelComment->Caption = s;
              }
          }
        }


 //-------------VNB end;   */
                // Меняем единицы измерения в коментарии фомы
        if(dynamic_cast<TBaseMonitorForm*>(Owner)&&
            (fd->StepProfile==TFormDescr::stpHour ||
             fd->StepProfile==TFormDescr::stpMinute))
        {
            AnsiString s = ((TBaseMonitorForm*)Owner)->LabelComment->Caption;
            //05.02.2020 - GRB bugfix with dobled caption [квТч квтч] - I just comment a next line and add block

            //s = s.SubString(1,s.Pos("["));
            /*
            AnsiString grbTest = s.SubString(1,s.Pos("["));
            if (grbTest.IsEmpty()){
              s = ((TBaseMonitorForm*)Owner)->LabelComment->Caption + " [";
              s = s.SubString(1,s.Pos("["));
            } */
            switch(fd->CodeTemplate)
            {
            /*case AEBO_POW_F:
            case AERO_POW_F:
            case AEDO_POW_F:
            case AERO_AEDO_POW_F:
                s = s+((PowerCoeff==1)?Reconst_smes104_27: Reconst_smes101_2);//   Reconst_smes101_2;

                break;*/
/*            case REBO_POW_F:
            case RERO_POW_F:
            case REDO_POW_F:
            case RERO_REDO_POW_F:
            case RQ1_RQ4_POW_F:
            case RQ2_RQ3_POW_F:
                s = s+((PowerCoeff==1)?Reconst_smes104_28: Reconst_smes101_3);//Reconst_smes101_3;
                break;*/
            case AEBO_REBO_POW_F: // 101 - Переток Активной / Реактивной энергии [МВтч/МВАрч]
                //s = s+Reconst_smes101_4;
                //05.02.2020 - GRB bugfix with dobled caption [квТч квтч] - I just comment a next line
                //s = s+((PowerCoeff==1)?AnsiString(Reconst_smes104_27+"/"+Reconst_smes104_28): Reconst_smes101_4);//Reconst_smes101_4;
                break;  //01/04/2014
            default: s = ((TBaseMonitorForm*)Owner)->LabelComment->Caption;
            }
            ((TBaseMonitorForm*)Owner)->LabelComment->Caption = s;
        }
	}
    delete psm;
}
//---------------------------------------------------------------------------

void __fastcall TInterior::refreshForm(void)
{
	TFormDescr* aFD=new TFormDescr(*GetFormDescr());
    // перед любым обновлением мониторов необходимо инициализировать кр. секцию UpdateMonitors
    while(WaitForSingleObject(UpdateMonitors,0)!=WAIT_OBJECT_0)
    {
        Application->ProcessMessages();// если не удалось иниц-ть. CS то обновить экранные формы...
        Sleep(0);// переключить управление на другой поток, коьт занял CS
    }
    // add by KSS
    PostMessage((dynamic_cast<TWinControl*>(Owner))->Handle,WM_REFRESHFORM,0,(LPARAM)aFD);
}
//---------------------------------------------------------------------------
__fastcall TInterior::~TInterior(void)
{
    if(VT_PrintData){
        VT_PrintData->Close();
        delete VT_PrintData;
    }
    if(fd)  delete fd;
    if(ColumnsCaption) delete ColumnsCaption;
}
//---------------------------------------------------------------------------
int __fastcall TInterior::GetCountRow()
{
	int i;
	unsigned short year,month,day;

 switch(fd->StepProfile)
	{
    case TFormDescr::stpMonth: i=12; break;
    case TFormDescr::stpHour:
    fd->DateTime.DecodeDate(&year,&month,&day);

    if((IsShiftTimeZona)&&(month==10)&&( fd->DateTime.DayOfWeek()==1&&31-day<7))  //25 час
       i=24*(60/PowerProfile)+1*(60/PowerProfile);
    else if((IsShiftTimeZona)&&(month==3)&&( fd->DateTime.DayOfWeek()==1&&31-day<7)) //23 час
       i=24*(60/PowerProfile)-1*(60/PowerProfile);
    else
     i=24*(60/PowerProfile);
    break;

 //   case TFormDescr::stpHour: i=24*(60/PowerProfile); break;
    case TFormDescr::stpDay:
	    fd->DateTime.DecodeDate(&year,&month,&day);
		if(month==2){
		    i=28;
			if(year%4==0) ++i;
            break;
        }
		i=31;
		if(month%7!=0 && (month%7)%2==0) --i;
        break;
    //GRB COMMENT
    /*case TFormDescr::stpMinute: i=LenPROFILE/StepPROFILE; break;*/
    //END GRB COMMENT
    //GRB CHANGE 12.07.2019
    //для минутного разбиения надо учиывать переход времени на зиму-лето тоже
    case TFormDescr::stpMinute:{
      fd->DateTime.DecodeDate(&year,&month,&day);
      if((IsShiftTimeZona)&&(month==10)&&( fd->DateTime.DayOfWeek()==1&&31-day<7))  //25 час
        i=(LenPROFILE/StepPROFILE)+1*(3600/StepPROFILE);
      else if((IsShiftTimeZona)&&(month==3)&&( fd->DateTime.DayOfWeek()==1&&31-day<7)) //23 час
        i=(LenPROFILE/StepPROFILE)-1*(3600/StepPROFILE);
      else
        i=LenPROFILE/StepPROFILE;
      break;
    }
    //END GRB CHANGE
    default: i=0;
    }
    return i;
}
//---------------------------------------------------------------------------
void __fastcall TInterior::refreshData( int,TOraQuery *quMain )
{
	--refreshDataCount;
}
//---------------------------------------------------------------------------
void __fastcall TInterior::Invalidate( int Table )
{
}
//---------------------------------------------------------------------------
void __fastcall TInterior::selectData( TOraQuery *qwInter )
{
}
//---------------------------------------------------------------------------
// Add KAS 11.02.02
void __fastcall TInterior::PrintRep()
{}
//---------------------------------------------------------------------------
void __fastcall TInterior::PrintGraph()
{}
//---------------------------------------------------------------------------
void __fastcall TInterior::PrintTable()
{}
//---------------------------------------------------------------------------
void __fastcall TInterior::SaveRepToFile(TSaveDialog *aSaveDialog)
{}
//---------------------------------------------------------------------------
void __fastcall TInterior::SaveTableToFile(TSaveDialog *aSaveDialog)
{}
//---------------------------------------------------------------------------
void __fastcall TInterior::SaveMultyTableToFile(TSaveDialog *aSaveDialog)
{}
//---------------------------------------------------------------------------
void __fastcall TInterior::SaveGraphToFile(TSaveDialog *aSaveDialog)
{}
//---------------------------------------------------------------------------
long __fastcall TInterior::GroupJump(long value) // Для перемещения по спискам
{
  long Id_Group = value;

  // Определяем что на входе группа или список
  if(fd->IsPoints)
    GroupIsList=1;
  else{
    dmMain->oqInterCursor->Params->Clear();
    dmMain->oqInterCursor->SQL->Text=" begin  \
                                "+SchemeName+"interior_pg.Interior_GroupJump(:par1,:par2,:par3,:par4,:par5,:par6,:par7);  \
                                end; ";

    dmMain->oqInterCursor->ParamByName("par7")->ParamType=ptOutput;
    dmMain->oqInterCursor->ParamByName("par7")->DataType=ftCursor;
    dmMain->oqInterCursor->ParamByName("par1")->Clear();
    dmMain->oqInterCursor->ParamByName("par2")->AsInteger= fd->StepProfile;
    dmMain->oqInterCursor->ParamByName("par3")->AsInteger=Id_Group;
    dmMain->oqInterCursor->ParamByName("par4")->AsInteger=fd->GetPeriod(fd->DateTime);

    dmMain->oqInterCursor->ParamByName("par5")->AsInteger=fd->GetPeriodForYearStart(fd->DateTime);
    dmMain->oqInterCursor->ParamByName("par6")->AsInteger=fd->GetPeriodForYearFinish(fd->DateTime);

    dmMain->oqInterCursor->Execute();
    GroupIsList = dmMain->oqInterCursor->FieldByName("GroupIsList")->AsInteger;
    dmMain->oqInterCursor->Close();
  }
  if(GroupIsList==2){
     if(fd->IsPoints){
       fd->IdGroupList = Id_Group;
       Id_Group=0;
     }else{
       fd->IdGroupList = Id_Group;
       dmMain->oqInterCursor->Params->Clear();
       dmMain->oqInterCursor->SQL->Text="begin "+SchemeName+"interior_pg.Interior_GroupJump(:par1,:par2,:par3,:par4,:par5,:par6,:par7); end;";
       dmMain->oqInterCursor->ParamByName("par7")->ParamType=ptOutput;
       dmMain->oqInterCursor->ParamByName("par7")->DataType=ftCursor;

       dmMain->oqInterCursor->ParamByName("par1")->AsInteger= GroupIsList;
       dmMain->oqInterCursor->ParamByName("par2")->AsInteger= fd->StepProfile;
       dmMain->oqInterCursor->ParamByName("par3")->AsInteger=Id_Group;
       dmMain->oqInterCursor->ParamByName("par4")->AsInteger=fd->GetPeriod(fd->DateTime);

       dmMain->oqInterCursor->ParamByName("par5")->AsInteger=fd->GetPeriodForYearStart(fd->DateTime);
       dmMain->oqInterCursor->ParamByName("par6")->AsInteger=fd->GetPeriodForYearFinish(fd->DateTime);
       dmMain->oqInterCursor->Execute();
       Id_Group=dmMain->oqInterCursor->FieldByName("gid")->AsInteger;
       dmMain->oqInterCursor->Close();
     }
     fd->IdGroupJump = Id_Group;
   }
   return Id_Group;
}
//---------------------------------------------------------------------------
AnsiString __fastcall TInterior::GetCurrentDate( TOraQuery *quMain)
{
  quMain->SQL->Text="SELECT to_char(sysdate, 'dd.mm.yyyy hh24:mi')CurrDate FROM dual";
  quMain->Execute();
  AnsiString s=quMain->FieldByName("CurrDate")->AsString;
  quMain->Close();
  return s;
 }

//---------------------------------------------------------------------------

AnsiString __fastcall TInterior::GetUnitOfEnergy()
{
   return "";
}
//---------------------------------------------------------------------------
// end Add
bool IsCommonRepForm( int pPCode )
{
  //GRB CHANGE 25.01.2019
  //return (pPCode==PL_SQL_REP_F)||(pPCode==EXCEL_F)||(pPCode==EXCEL_REP_F)||(pPCode==EXCEL_OP_FORM)||(pPCode==EXCEL_REP_OUT_F)||(pPCode==PL_SQL_TABLE);
return (pPCode==PL_SQL_REP_F)||(pPCode==EXCEL_F)||(pPCode==EXCEL_REP_F)||(pPCode==EXCEL_OP_FORM)||(pPCode==EXCEL_REP_OUT_F)||(pPCode==PL_SQL_TABLE||(pPCode==PL_SQL_MANY_TABLE));
};
//---------------------------------------------------------------------------
// Add by KSS
// Функция обновляет свойства ячеек таблицы dt в зависимости от значения nsource в массиве данных pClone
// P.S. количество VarStrings таблицы dt должно совпадать с длиной массива pClone - cntClone
void __fastcall TInterior::setDataSourceToDrawTable(TDrawTable*dt, TCloneItem*pClone,
   int cntClones, int cntColumns, int cntRows)
{
    if(!FormSetupMonitors->RadioGroupShowValidity->ItemIndex)
        return;
    long varIndex = 0;

    TDrawTable::SAttrCell* pAttr;
    char Symb[4][32]={"OK"," X "," * "," ? "};
    TColor Color [4]={clGreen,clRed,clBlue ,(TColor)RGB(255,128,0)}; //Цвет фона верхнего  RGB(255,128,0)
    TColor ColorSimbol[4]={clWhite,clWhite,clWhite,clWhite}; //Цвет шрифта верхнего
    char Symb1[9][32]={" N "," 1 "," 2 "," S "," P "," M "," O "," A "," П " };
    TColor Color1[9]={(TColor)RGB(192,192,192),clGreen,clGreen,clBlue,clBlue,clBlue,clGreen,(TColor)RGB(159,255,159),clBlue};//Цвет фона нижнего
    TColor ColorSimbol1[9]={clBlack,clWhite,clWhite,clWhite,clWhite,clWhite,clWhite,clBlack,clWhite};         //Цвет шрифта нижнего
    char Symb2[2][32]={" N "," Y "};
    TColor Color2[2]={clRed,clGreen};//Цвет фона верхнего левого
    TColor ColorSimbol2[2]={clWhite,clWhite};         //Цвет шрифта верхнего   левого
    int flag=0;
    try{



     for(int i=0; i<(fd->VerticalSplit?dt->RowCount:dt->ColCount); i++)

      for(int j=0; j<(fd->VerticalSplit?dt->ColCount:dt->RowCount); j++)
        {

            pAttr = fd->VerticalSplit?
                (TDrawTable::SAttrCell*)dt->GetCellAttr(j,i):
                (TDrawTable::SAttrCell*)dt->GetCellAttr(i,j);
            if(pAttr && pAttr->styleCell==TDrawTable::SAttrCell::cellVar)
            {
                if(varIndex >= cntClones*cntColumns*cntRows)
                {
                    throw Exception(Reconst_smes101_5);
                }


           if(!fd->VerticalSplit&&!fd->SummGroup&&(varIndex%(dt->RowCount-1+cntColumns)==0))varIndex+=cntColumns;
        //   if(!fd->VerticalSplit&&!fd->SummGroup&&(varIndex%dt->RowCount==0))varIndex++;
           if(fd->VerticalSplit&&!fd->SummGroup&&(varIndex%(dt->ColCount-1+cntColumns)==0))varIndex+=cntColumns;
           flag=0;
           if(pClone[ varIndex].isvalid[0]!='\0')  //проверка правильности каждого символа в строке метки качества
           {
             if(StrToInt(pClone[ varIndex].isvalid[0])<0 ||StrToInt(pClone[ varIndex].isvalid[0])>3)
             flag=1;
             for(int n=1 ; n<=11; n++){
             if(StrToInt(pClone[ varIndex].isvalid[n])!=0&&StrToInt(pClone[ varIndex].isvalid[n])!=1)
             flag=1;
             }

             for(int n=12; n<20; n++)
             {
              if(StrToInt(pClone[ varIndex].isvalid[n])<0||StrToInt(pClone[ varIndex].isvalid[n])>3)
              flag=1;
             }
             if(StrToInt(pClone[ varIndex].isvalid[21])<0 ||StrToInt(pClone[ varIndex].isvalid[21])>8)
              flag=1;
              
             if(pClone[ varIndex].isvalid[22]=='\0') pClone[ varIndex].isvalid[22]='0';
             if(StrToInt(pClone[ varIndex].isvalid[22])!=0&&StrToInt(pClone[ varIndex].isvalid[22])!=1)
             {
             flag=1;
             }
              if(flag)
              {
              pClone[ varIndex].isvalid[0]='\0';
              flag=0;
              }
           }


           if(pClone[ varIndex].isvalid[0]!='\0')
              {
                FormSetupMonitors->dsAll.fSymbUL=0;
                FormSetupMonitors->dsAll.fSymbBL=0;
                FormSetupMonitors->dsAll.fSymbUR=0;
                FormSetupMonitors->dsAll.fSymbBR=0;

                if (FormSetupMonitors->RadioGroupShowValidity->ItemIndex == 1)
                {
                  if(StrToInt(pClone[ varIndex].isvalid[0]))
                  {
                    FormSetupMonitors->dsAll.fSymbUR=7;
                    FormSetupMonitors->dsAll.colUR = ColorSimbol[StrToInt(pClone[ varIndex].isvalid[0])];
                    strcpy(FormSetupMonitors->dsAll.cSymbUR, Symb[StrToInt(pClone[ varIndex].isvalid[0])] );
                    FormSetupMonitors->dsAll.bkcolUR = Color[StrToInt(pClone[ varIndex].isvalid[0])];
                  }
                  FormSetupMonitors->dsAll.fSymbBR=7;
                  FormSetupMonitors->dsAll.colBR = ColorSimbol1[StrToInt(pClone[ varIndex].isvalid[21])];
                  strcpy(FormSetupMonitors->dsAll.cSymbBR, Symb1[StrToInt(pClone[ varIndex].isvalid[21])] );
                  FormSetupMonitors->dsAll.bkcolBR = Color1[StrToInt(pClone[ varIndex].isvalid[21])];

            /*  if(StrToInt(pClone[ varIndex].isvalid[22])==0)
              {
               FormSetupMonitors->dsAll.fSymbUL=7;
               FormSetupMonitors->dsAll.colUL = ColorSimbol2[StrToInt(pClone[ varIndex].isvalid[22])];
               strcpy(FormSetupMonitors->dsAll.cSymbUL, Symb2[StrToInt(pClone[ varIndex].isvalid[22])] );
               FormSetupMonitors->dsAll.bkcolUL = Color2[StrToInt(pClone[ varIndex].isvalid[22])];
              } */
              }

              else if (FormSetupMonitors->RadioGroupShowValidity->ItemIndex == 2)
              {
                if(StrToInt(pClone[ varIndex].isvalid[0]))
                  {
                        FormSetupMonitors->dsAll.kSymbFontSize = 80;
                        FormSetupMonitors->dsAll.fSymbUR = 7;
                        strncpy(FormSetupMonitors->dsAll.cSymbUR," E ",sizeof(FormSetupMonitors->dsAll.cSymbUR));
                        FormSetupMonitors->dsAll.colUR = clRed;  FormSetupMonitors->dsAll.bkcolUR = clRed;
                  }
              }
              }
              else
              {
                FormSetupMonitors->dsAll.fSymbUL=0;
                FormSetupMonitors->dsAll.fSymbBL=0;
                FormSetupMonitors->dsAll.fSymbUR=0;
                FormSetupMonitors->dsAll.fSymbBR=0;
              }

         
                pAttr->DataSource = FormSetupMonitors->dsAll;
               varIndex++;
     

         }
     
     }
    }catch(Exception&e){
        Application->ShowException(&e);
    }
}
//---------------------------------------------------------------------------------------------------------------------
void __fastcall TInterior::setColorToDrawTable(TDrawTable*dt,int columns)
{
   TDrawTable::SAttrCell* pAttr;
   if(fd->CodeTemplate!=206) return;
    try{

     for(int i=0; i<(fd->VerticalSplit?dt->RowCount:dt->ColCount); i++)

      for(int j=0; j<(fd->VerticalSplit?dt->ColCount:dt->RowCount); j++)
        {

            pAttr = fd->VerticalSplit?
                (TDrawTable::SAttrCell*)dt->GetCellAttr(j,i):
                (TDrawTable::SAttrCell*)dt->GetCellAttr(i,j);
            if(pAttr && pAttr->styleCell==TDrawTable::SAttrCell::cellVar)
            {

     if((fd->VerticalSplit&&(i%columns==0&&i))||(!fd->VerticalSplit&&(j%columns==0&&j)))
              {

            if(!dt->VarStrings->Strings[pAttr->IndexData].IsEmpty() &&
                dt->VarStrings->Strings[pAttr->IndexData]<0.0)
                pAttr->BackgroundColor=clRed;
               }
           }
      }
   }catch(Exception&e){
        Application->ShowException(&e);
    }
}
//-----------------------------------------------------------------------------------------------------------------------

  AnsiString __fastcall TInterior::GetCaptionPowerCoeff()
{

AnsiString  d = "";
  switch( fd->CodeTemplate )
  {

 case AEBO_REBO_F :          //Переток Активной / Реактивной энергии [МВтч/МВАрч]
 case AEBO_REBO_POW_F:          //Переток Активной / Реактивной энергии [МВтч/МВАрч] Получасовки мощность
 case AEBO_REBO_SUM_F :         //Переток Активной / Реактивной энергии [МВтч/МВАрч] Суммируется по наростающей

              d = (PowerCoeff==1)?Reconst_smes101_6: Reconst_smes101_7;
                break;


 case AEBO_F:                 //Переток Активной энергии [кВтч]
 case AEBO_POW_F:             //Переток Активной энергии [кВтч] Получасовки мощность
 case AEBO_SUM_F :            //Переток Активной энергии [кВтч] Суммируется по наростающей
 case AERO_F :                //Приём Активной энергии [кВтч]
 case AERO_POW_F:             //Приём Активной энергии [кВтч] Получасовки мощность
 case AERO_SUM_F :            //Приём Активной энергии [кВтч] Суммируется по наростающей
 case AEDO_F :               //Отдача Активной энергии [кВтч]
 case AEDO_POW_F:             //Отдача Активной энергии [кВтч] Получасовки мощность
 case AEDO_SUM_F :            //Отдача Активной энергии [кВтч] Суммируется по наростающей
 case AERO_DECAD_F:         //Приём Активной энергии по декадам [тыс.кВтч]
 case AEBO_DECAD_F :        //Переток Активной энергии по декадам [тыс.кВтч]
 case AERO_AERA_AERB_AERC_F:  //Активная принятая общая и по тарифам [кВтч]
 case AEDO_AEDA_AEDB_AEDC_F: //Активная отданная общая и по тарифам [кВтч]
 case AEBO_AEBA_AEBB_AEBC_F:  //Переток активной э/э (общая и по тарифам) [кВтч]
 case AERA_AERB_AERC_AERD_F:  //Активная принятая по тарифам [кВтч]
 case AEDA_AEDB_AEDC_AEDD_F:  //Активная отданная по тарифам [кВтч]
 case AERO_AEDO_F :           //Приём / Отдача Активной энергии [МВтч]
 case AERO_AEDO_POW_F:        //Приём / Отдача Активной энергии [МВтч] Получасовки мощность
 case AERO_AEDO_SUM_F :       //Приём / Отдача Активной энергии [МВтч] Суммируется по наростающей
 case BALANCE_F:           //Баланас Активной энергии [МВтч]
 case BALANCE_POW_F:        //Баланс Активной энергии (ГН, Тех.проф. - мощность)
 case BALANCE_SUM_F :       //Баланс Активной энергии (Суммируется по наростающей)
 case NOT_BALANCE:
 case NOT_BALANCE_AER: // 207 - Небаланс активной энергии
            if((fd->CodeTemplate==AEBO_POW_F||fd->CodeTemplate==AERO_POW_F||fd->CodeTemplate==AEDO_POW_F||fd->CodeTemplate==AERO_AEDO_POW_F)&&(fd->StepProfile==TFormDescr::stpHour ||
             fd->StepProfile==TFormDescr::stpMinute)){
             d = (PowerCoeff==1)?Reconst_smes104_27: Reconst_smes101_2;//   Reconst_smes101_2;
            }else
              d = (PowerCoeff==1)?Reconst_smes101_8: Reconst_smes101_9;
            break;
 case REBO_F :                //Переток Реактивной энергии [кВАрч]
 case REBO_POW_F :            //Переток Реактивной энергии [кВАрч] Получасовки мощность
 case REBO_SUM_F :            //Переток Реактивной энергии [кВАрч] Суммируется по наростающей
 case RERO_F :                //Приём Реактивной энергии [кВАрч]
 case RERO_POW_F :            //Приём Реактивной энергии [кВАрч] Получасовки мощность
 case RERO_SUM_F :            //Приём Реактивной энергии [кВАрч] Суммируется по наростающей
 case REDO_F :                //Отдача реактивной энергии [кВАрч]
 case REDO_POW_F:             //Отдача реактивной энергии [кВАрч] Получасовки мощность
 case REDO_SUM_F :           //Отдача реактивной энергии [кВАрч] Суммируется по наростающей
 case RERO_RERA_RERB_RERC_F:  //Реактивная принятая общая и по тарифам [кВАрч]
 case REDO_REDA_REDB_REDC_F:  //Реактивная отданная общая и по тарифам [кВАрч]
 case REBO_REBA_REBB_REBC_F:  //Переток реактивной э/э (общая и по тарифам) [кВарч]
 case RERA_RERB_RERC_RERD_F:  //Реактивная принятая по тарифам [кВАрч]
 case REDA_REDB_REDC_REDD_F:  //Реактивная отданная по тарифам [кВАрч]
 case RERO_REDO_F :           //Приём / Отдача Реактивной энергии [МВАрч]
 case RERO_REDO_POW_F:        //Приём / Отдача Реактивной энергии [МВАрч] Получасовки мощность
 case RERO_REDO_SUM_F :       //Приём / Отдача Реактивной энергии [МВАрч] Суммируется по наростающей
 case RQ1_RQ4_F :             //Приём / Отдача Реактивной энергии при импорте активной энергии [МВАрч]
 case RQ1_RQ4_POW_F:          //Приём / Отдача Реактивной энергии при импорте активной энергии [МВАрч]  Получасовки мощность
 case RQ2_RQ3_F :             //Приём / Отдача Реактивной энергии при экспорте активной энергии [МВАрч]
 case RQ2_RQ3_POW_F:          //Приём / Отдача Реактивной энергии при экспорте активной энергии [МВАрч] Получасовки мощность
 case RE_BALANCE_F:            //Баланс Реактивной энергии
 case RE_BALANCE_POW_F:        //Баланс Реактивной энергии (ГН, Тех.проф. - мощность)
 case RE_BALANCE_SUM_F:        //Баланс Реактивной энергии (Суммируется по наростающей)
            if((fd->CodeTemplate==REBO_POW_F||fd->CodeTemplate==RERO_POW_F||fd->CodeTemplate==REDO_POW_F||fd->CodeTemplate==RERO_REDO_POW_F||
              fd->CodeTemplate==RQ1_RQ4_POW_F||fd->CodeTemplate==RQ2_RQ3_POW_F)&&(fd->StepProfile==TFormDescr::stpHour ||fd->StepProfile==TFormDescr::stpMinute)){
               d = (PowerCoeff==1)?Reconst_smes104_28: Reconst_smes101_3;//Reconst_smes101_3;
            }else
              d = (PowerCoeff==1)?Reconst_smes101_10: Reconst_smes101_11;
            break;
 case APBO_F :                //Мощность, лимит, отклонение [МВт]
 case RPBO_F :                //Мощность, лимит, отклонение [МВт]
          d = " [МВт] ";
          break;
    }

   return d;
}
//---------------------------------------------------------------------------
