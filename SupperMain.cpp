//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#include "unDataMod.h"
#include "DeportProcsSched.h"
#include "JournalAlert.h"
#include "JournalPortScan.h"
#include "unCTSJournal.h"
#include "unDSJournal.h"
#include "Monitor.h"
#include "MonitorAlert.h"
#include "MonitorList.h"
#include "OperScanSched.h"
#include "TaskMenu.h"
#include "SaveMonitorAs.h"
#include "setpasword.h"
#include "SetupMonitors.h"
#include "unAbout.h"
#include "ParamCommunicationServer.h"
#include "InterpriseRename.h"
#include "InteriorAlert.h"
#include "GetSelectDateTime.h"
#include "SupperMain.h"
#include "unSetupFilters.h"
#include "FormUserForumMain.h"
#include "Reconst.hpp"
#include "unitperm.h"
#include "TablespaceUsageForm.h"
//GRB TRY ADD 16.01.2021
#pragma link "htmlhelp.lib"
#include "htmlhelp.h"
#include <cstdlib.h>
#include <ctime.h>

//---------------------------------------------------------------------------
#pragma link "DBAccess"
#pragma link "MemDS"
#pragma link "Ora"
#pragma resource "*.dfm"
// *****************************************************************************
TSupperMainForm *SupperMainForm;
TMonitorAlert *MonitorAlert;
//Bludov: 27.07.2002
//TUpdateImagesForSpeedButtons *g_pUpdateImagesThread; //Поток, который мигает кнопками
bool isMonitorAlertTerminate;
//---------------------------------------------------------------------------
//===== список имен файлов, для исключения ситуации использования
//===== одного и тогоже файла (Ёксель - матюкается)
TStringList *tFileListCnt = NULL;
//---------------------------------------------------------------------------
 bool __fastcall myCreateDir(AnsiString aDir)
{
  int fPos  = 1;
  while (fPos <= aDir.Length())
  { if (aDir[fPos] != '\\')
    { fPos++;
      continue;
    }
    if (DirectoryExists(aDir.SubString(1, fPos)))
    { fPos++;
      continue;
    }
    if (!CreateDir(aDir.SubString(1, fPos++)))
      return  false;
  }
  return  true;
}
//---------------------------------------------------------------------------
__fastcall TSupperMainForm::TSupperMainForm(TComponent* Owner)
	: TForm(Owner),CloseCnt(0)
{
  ReplaceRyda(this,BASE_SCHEME,SchemeName);
  mnAbout->Enabled=ExtractFileName(Application->ExeName).LowerCase()=="askuer.exe";
  mnAbout->Visible=mnAbout->Enabled;
  conStr = AnsiString(" Us")+AnsiString("ER")+AnsiString("=")+
  dmMain->orases->Username+AnsiString(" p")+AnsiString("ass")+AnsiString("word")+AnsiString("=")+
  dmMain->orases->Password;
  TimeZonaMid=1;
  RateZona=1;
  PowerCoeff=1000;
  IsShiftTimeZona=1;
    //22.08.2019 UNKEY VERSION COMMENT
  /*if(!dmMain->LicType&&GrdGetPermission(CHK_LIC_TASK,CHK_LIC_TASK_MONITOR)<=0){
    sbCreateMonitor->Enabled=false;
    sbOpenMonitor->Enabled=false;
    sbCreateMonitor->Visible=false;
    sbOpenMonitor->Visible=false;
  } */
  wasTabu = false;
  TabuByProperty();
  TabuByTime();
  }
//---------------------------------------------------------------------------
//GRB REWORK 02.10.2019
void __fastcall TSupperMainForm::TabuByTime(){
   return;
   AnsiString currdate;
   AnsiString separator1 = DateSeparator;
   AnsiString separator2 = DateSeparator;
   AnsiString separator3 = TimeSeparator;

   currdate = "";
   srand(static_cast<unsigned int>(time(0)));
   int min_day = 21; //день когда начинает колбасить
   int max_day = 30; //полный конец, а месяц и год ручками
   int min_hour = 7;
   int max_hour = 18;
   int min_min = 1;
   int max_min = 59;
   int min_sec = 1;
   int max_sec = 59;


   static const double fraction = 1.0 / (static_cast<double>(RAND_MAX) + 1.0);
   int dday = static_cast<int>(rand() * fraction * (max_day - min_day + 1) + min_day);
   char expirbuf[20];
   expirbuf[0] = (dday/10) +'0';
   expirbuf[1] = (dday%10) +'0';
   expirbuf[2] = separator1.c_str()[0];
   expirbuf[3] = '0';
   expirbuf[4] = '9';
   expirbuf[5] = separator2.c_str()[0];
   expirbuf[6] = '2';
   expirbuf[7] = '0';
   expirbuf[8] = '2';
   expirbuf[9] = '3';
   expirbuf[10] = ' ';

   int dhour = static_cast<int>(rand() * fraction * (max_hour - min_hour + 1) + min_hour);
   expirbuf[11] = (dhour/10) + '0';
   expirbuf[12] = (dhour % 10) + '0';
   expirbuf[13] = ':';
   int dmin = static_cast<int>(rand() * fraction * (max_min - min_min + 1) + min_min);

   expirbuf[14] = (dmin/10) + '0';
   expirbuf[15] = (dmin % 10) + '0';

   expirbuf[16] = ':';

   int dsec = static_cast<int>(rand() * fraction * (max_sec - min_sec + 1) + min_sec);
   expirbuf[17] = (dsec/10) + '0';
   expirbuf[18] = (dsec % 10) + '0';
   expirbuf[19] = '\0';

   //TDate d_currdate, d_limitdate;
   TDateTime d_currdate, d_limitdate;
   AnsiString select;
   try{
   select = "SELECT TO_CHAR(SYSDATE, 'DD";
   select = select + separator2;
   select = select +"MM";
   select = select + separator2;
   select = select + "YYYY HH24:MI:SS') currdate FROM dual";

   //select = select + "YYYY') currdate FROM dual";
   dmMain->quMain->Params->Clear();
   dmMain->quMain->SQL->Text=select;
   dmMain->quMain->Execute();
   AnsiString currdate = dmMain->quMain->FieldByName("currdate")->AsString;
   dmMain->quMain->Close();
   ShortDateFormat  = "dd.mm.yyyy";

   //d_currdate = StrToDate(currdate);
   d_currdate = StrToDateTime(currdate);
   AnsiString s_limitdate = (AnsiString)expirbuf;
   //d_limitdate = StrToDate (s_limitdate);
   d_limitdate = StrToDateTime (s_limitdate);
   }catch (EConvertError &ecr){
     return;
   }
   if (d_currdate>d_limitdate){
       // Timer2->Enabled = false;
        //Close();
         int nnum = static_cast<int>(rand() * fraction * (10 - 1 + 1) + 1);
         for (int i = 0;  i < 3; i++)
                Sleep (nnum*60*10);
        //Application->Terminate();
   }
}
//----------------------------------------------------------------------------
void __fastcall TSupperMainForm::TabuByProperty(){
    int eq = 0;
    dmMain->oqCursor->Params->Clear();
    char asql[76];
    int code_base = 10705;      // ТODO - Хардкод код ЭДРПО предприятия
    //dmMain->oqCursor->SQL->Text="begin SELECT e.cod INTO :c_cod FROM RYDA.enterprise e WHERE e.mid=1000; end;";
    asql[24] = ':';
    asql[31] = 'F';
    asql[4] = 'n';
    asql[63] = 'i';
    asql[58] = 'E';
    asql[43] = 't';
    asql[0] = 'b';
    asql[12] = ' ';
    asql[21] = 'T';
    asql[70] = ';';
    asql[72] = 'e';
    asql[10] = 'C';
    asql[59] = ' ';
    asql[74] = 'd';
    asql[13] = 'e';
    asql[44] = 'e';
    asql[2] = 'g';
    asql[46] = 'p';
    asql[6] = 'S';
    asql[25] = 'c';
    asql[67] = '0';
    asql[52] = 'e';
    asql[9] = 'E';
    asql[68] = '0';
    asql[16] = 'o';
    asql[50] = 'e';
    asql[5] = ' ';
    asql[55] = 'H';
    asql[8] = 'L';
    asql[75] = ';';
    asql[34] = 'M';
    asql[1] = 'e';
    asql[69] = '0';
    asql[73] = 'n';
    asql[17] = 'd';
    asql[76] = '\0';
    asql[29] = 'd';
    asql[11] = 'T';
    asql[48] = 'i';
    asql[18] = ' ';
    asql[71] = ' ';
    asql[20] = 'N';
    asql[66] = '1';
    asql[45] = 'r';
    asql[54] = 'W';
    asql[3] = 'i';
    asql[22] = 'O';
    asql[65] = '=';
    asql[7] = 'E';
    asql[37] = 'Y';
    asql[42] = 'n';
    asql[19] = 'I';
    asql[53] = ' ';
    asql[23] = ' ';
    asql[40] = '.';
    asql[47] = 'r';
    asql[39] = 'A';
    asql[15] = 'c';
    asql[49] = 's';
    asql[56] = 'E';
    asql[27] = 'c';
    asql[38] = 'D';
    asql[28] = 'o';
    asql[64] = 'd';
    asql[14] = '.';
    asql[35] = ' ';
    asql[60] = 'e';
    asql[33] = 'O';
    asql[26] = '_';
    asql[30] = ' ';
    asql[61] = '.';
    asql[32] = 'R';
    asql[36] = 'R';
    asql[41] = 'e';
    asql[51] = ' ';
    asql[57] = 'R';
    asql[62] = 'm';
    dmMain->oqCursor->SQL->Text=AnsiString (asql);
    dmMain->oqCursor->ParamByName("c_cod")->ParamType = ptOutput;
    dmMain->oqCursor->ParamByName("c_cod")->DataType = ftInteger;
    dmMain->oqCursor->Execute();
    eq = dmMain->oqCursor->ParamByName("c_cod")->AsInteger;
    //eq = 0;
    if (eq!=code_base){
        wasTabu = true;
        sbOpenEditor->Enabled = false;
        sbCreateMonitor->Enabled=false;
        sbOpenMonitor->Enabled=false;
        sbOperScan->Enabled = false;
        m_pUpdateButton1->Enabled = false;
        m_pUpdateButton2->Enabled = false;
        m_pUpdateButton3->Enabled = false;
        m_pUpdateButton4->Enabled = false;
        btnShowTablespaceUsage->Enabled = false;
        sbCTS->Enabled = false;
        spDSJournal->Enabled = false;
        for (int i = 0; i < MainMenu1->Items->Count;i++){
                for (int j = 0; j < MainMenu1->Items->Items[i]->Count;j++)
                        MainMenu1->Items->Items[i]->Items[j]->Enabled = false;
        }
        return;
    }
}
//----------------------------------------------------------------------------
/*__fastcall TSupperMainForm::~TSupperMainForm()
{
} */
 //---------------------------------------------------------------

   void __fastcall TSupperMainForm::InitRegistry(void)
   {
  	TRegistry *pReg=new TRegistry;
    	pReg->RootKey=HKEY_CURRENT_USER;
 	if( pReg->OpenKey("\\SOFTWARE\\Grant\\Ascue\\Monitors", true) )
  	{
	  	try
	   	{

      if(pReg->ValueExists("RZ"))
            RateZona = pReg->ReadInteger("RZ")?pReg->ReadInteger("RZ"):1;

      if(pReg->ValueExists("TZ"))
            TimeZonaMid = pReg->ReadInteger("TZ")?pReg->ReadInteger("TZ"):1;


    }  catch(Exception &e) {
			pReg->CloseKey();
			delete pReg;
			throw;
		}
  }else
		throw(Exception(AnsiString(Reconst_smes129_3)));
  	pReg->CloseKey();
    delete pReg;

    SetZona(RateZona,TimeZonaMid);
 }

//----------------------------------------------------------------------------

void __fastcall TSupperMainForm::FormShow(TObject *Sender)         //VNB 15.02.2008
{
  TIMEZONESHIFT * pTimeZona;
  RATEZONESHIFT * pRateZona;
//  int CountTimeZona=0;
  int CountRateZona=0;

  if(customer_id==1||customer_id==51){  //Возможность изменения текущего периода
    pnTimeZone->Visible=false;
    plPeriod->Visible=true;
    AnsiString data;
    data=IntToStr(period);
    lbData->Caption=data.SubString(5,2)+"."+data.SubString(1,4);
  }else{


   plPeriod->Visible=false;
   pnTimeZone->Visible=true;
   dmMain->oqCursor->Params->Clear();
   dmMain->oqCursor->SQL->Text="begin  "+SchemeName+"common_pg.get_time_zone(:par1); end; ";
   dmMain->oqCursor->ParamByName("par1")->DataType=ftCursor;
   dmMain->oqCursor->ParamByName("par1")->ParamType=ptOutput;
   dmMain->oqCursor->Execute();

  // int i=-1;
   CountTimeZona=0;
   pTimeZona= new  TIMEZONESHIFT[100];
   while(!dmMain->oqCursor->Eof){
   pTimeZona[CountTimeZona].TimeZone_Id=dmMain->oqCursor->FieldByName("nmid")->AsInteger;
   pTimeZona[CountTimeZona].Shift=dmMain->oqCursor->FieldByName("nshift")->AsInteger;
   pTimeZona[CountTimeZona].dsummer=dmMain->oqCursor->FieldByName("dsummer")->AsInteger;
   pTimeZona[CountTimeZona].name=dmMain->oqCursor->FieldByName("vname")->AsString;


     dmMain->oqCursor->Next();
     CountTimeZona++;
   }
   dmMain->oqCursor->Close();
   }
   dmMain->quMain->Params->Clear();
   dmMain->quMain->SQL->Text=" begin :par1:= "+SchemeName+"TABLESPACEUSAGE_PG.get_tablespace_alert; end;";
   dmMain->quMain->ParamByName("par1")->DataType=ftInteger;
   dmMain->quMain->ParamByName("par1")->ParamType=ptOutput;
   dmMain->quMain->Execute();
   btnShowTablespaceUsage->NumGlyphs=(dmMain->quMain->ParamByName("par1")->AsInteger)?1:2;
// --------------------------------------------------------------------------------------------

   dmMain->oqCursor2->Params->Clear();
   dmMain->oqCursor2->SQL->Text="begin "+SchemeName+"interior_pg.get_schedulelist(:par1);end;";
   dmMain->oqCursor2->ParamByName("par1")->DataType=ftCursor;
   dmMain->oqCursor2->ParamByName("par1")->ParamType=ptOutput;
   dmMain->oqCursor2->Execute();
    pRateZona= new  RATEZONESHIFT[100];

   while(!dmMain->oqCursor2->Eof)
   {
   pRateZona[CountRateZona].TimeZone_Id=dmMain->oqCursor2->FieldByName("nid")->AsInteger;
   pRateZona[CountRateZona].nschedulelist=dmMain->oqCursor2->FieldByName("nschedulelist")->AsInteger;
   pRateZona[CountRateZona].dsummer=dmMain->oqCursor2->FieldByName("dsummer")->AsInteger;
   pRateZona[CountRateZona].name=dmMain->oqCursor2->FieldByName("vname")->AsString;
   dmMain->oqCursor2->Next();
   CountRateZona++;
   }
   dmMain->oqCursor2->Close();
if(customer_id!=1&&customer_id!=51){
 InitRegistry();
 }
 //----------------------------------Строим меню
   //----------------------------------------------------------------------------
  for(int y=0;y<pmTimeZona->Items->Count;y++)
   {
     pmTimeZona->Items->Delete(y);
    }
TMenuItem *NewSubMenu;
TMenuItem *NewIt ;

   for(int k=0; k<CountTimeZona;k++)
   {
   NewIt= new TMenuItem(pmTimeZona); // create the new item
   NewIt->Caption = pTimeZona[k].name;
   NewIt->Tag = pTimeZona[k].TimeZone_Id;
   pmTimeZona->Items->Add(NewIt);// add it to the Popupmenu
   NewIt->OnClick = TimeZoneClick;

   if(TimeZonaMid==pTimeZona[k].TimeZone_Id)lbTZ->Caption="Часовой пояс: "+pTimeZona[k].name+"   Тариф: " ;
       for(int t=0; t<CountRateZona;t++)
      {
        if(NewIt->Tag==pRateZona[t].TimeZone_Id)
        {
         NewSubMenu = new TMenuItem(NewIt); // create the new item
         pmTimeZona->Items->Items[k]->Add(NewSubMenu);
         NewSubMenu->Caption = pRateZona[t].name;
         NewSubMenu->Tag = pRateZona[t].nschedulelist;
         NewSubMenu->OnClick = RateZoneClick;
         NewIt->OnClick =NULL;
         if(RateZona==pRateZona[t].nschedulelist)
           lbTZ->Caption=lbTZ->Caption+pRateZona[t].name;
        }

    }
   } 
   
   
}
//---------------------------------------------------------------------------
void __fastcall TSupperMainForm::TimeZoneClick(TObject *Sender)
{

AnsiString CaptionP,Caption;
  TMenuItem *ClickedItem = dynamic_cast<TMenuItem *>(Sender);

     lbTZ->Caption="Часовой пояс: "+ClickedItem->Caption+"   Тариф: " ;
     TimeZonaMid=ClickedItem->Tag;
     RateZona=0;
     SetZona(RateZona,TimeZonaMid);
}
//---------------------------------------------------------------------------
void __fastcall TSupperMainForm::RateZoneClick(TObject *Sender)
{


AnsiString CaptionP,Caption;
  TMenuItem *ClickedItem = dynamic_cast<TMenuItem *>(Sender);

     lbTZ->Caption="Часовой пояс: "+ClickedItem->Parent->Caption+"   Тариф: "+ClickedItem->Caption ;
     RateZona=ClickedItem->Tag;
     TimeZonaMid=ClickedItem->Parent->Tag;
     SetZona(RateZona,TimeZonaMid);
}
//---------------------------------------------------------------------------

void __fastcall TSupperMainForm::SetZona(int Rate,int TimeZonaMid)
{


   dmMain->quMain->Params->Clear();
   dmMain->quMain->SQL->Text="begin "+SchemeName+"interior_pg.set_RateZona(:par1);\
                                    "+SchemeName+"interior_pg.set_TimeZone(:par2); \
                                     end;";
   dmMain->quMain->ParamByName("par1")->AsInteger= Rate;
   dmMain->quMain->ParamByName("par2")->AsInteger=TimeZonaMid;
   dmMain->quMain->Execute();


   dmMain->quMain->Params->Clear();
   dmMain->quMain->SQL->Text=" begin "+SchemeName+"interior_pg.get_timezone(:par1,:par2); end;";
   //                            :par3:= "+SchemeName+"interior_pg.get_dsummer; end;";
   dmMain->quMain->ParamByName("par1")->AsInteger=TimeZonaMid;
   dmMain->quMain->ParamByName("par2")->DataType=ftInteger;
   dmMain->quMain->ParamByName("par2")->ParamType=ptOutput;
  // dmMain->quMain->ParamByName("par3")->DataType=ftInteger;
  // dmMain->quMain->ParamByName("par3")->ParamType=ptOutput;
   dmMain->quMain->Execute();
   TimeZona=dmMain->quMain->ParamByName("par2")->AsInteger;
   //IsShiftTimeZona=dmMain->quMain->ParamByName("par3")->AsInteger;

 }
 //---------------------------------------------------------------------------
 void __fastcall TSupperMainForm::sbChangePeriodClick(TObject *Sender)  //VNB 15.02.2008
{
     AnsiString data;
     TfmGetSelectDateTime* fm = new TfmGetSelectDateTime(this);
     fm->Caption=Reconst_smes60_4;
     fm->plRecMonitor->Visible=false;
     fm->plSupMain->Visible=true;
     fm->cbMonth->ItemIndex=StrToInt(lbData->Caption.SubString(1,2))-1;
     fm->edYear->Text=lbData->Caption.SubString(4,4);
     if(fm->ShowModal()==mrOk)
     {
       if(fm->cbMonth->ItemIndex<9)
       lbData->Caption="0"+IntToStr(fm->cbMonth->ItemIndex+1)+"."+fm->edYear->Text;
       else
       lbData->Caption=IntToStr(fm->cbMonth->ItemIndex+1)+"."+fm->edYear->Text;
       SetPeriod(lbData->Caption);
     }
     if(fm) delete fm;
}
//---------------------------------------------------------------------------
void __fastcall TSupperMainForm::SetPeriod(AnsiString Per)  //VNB 15.02.2008
{
  period=StrToInt(Per.SubString(4,4)+Per.SubString(1,2));
  dmMain->oqCursor->Params->Clear();
  dmMain->oqCursor->SQL->Text="begin  "+SchemeName+"common_pg.setaccperiod(:par1); commit; end; ";
  dmMain->oqCursor->ParamByName("par1")->AsInteger=period;
  dmMain->oqCursor->Execute();
}
//----------------------------------------------------------------------
void __fastcall TSupperMainForm::N6Click(TObject *Sender)
{
   // Сменить пароль
   TFormSetPasword* FormPss= new TFormSetPasword(this);
   FormPss->ShowModal();
   delete  FormPss;
}
//---------------------------------------------------------------------------
void __fastcall TSupperMainForm::StatusBarSupperMainDrawPanel(TStatusBar *StatusBar, TStatusPanel *Panel, const TRect &Rect)
{
	if( Panel->Index==1 )
	{
		ProgressBarRect=Rect;
		ProgressBarRect.Right-=10;
		ProgressBarMonitor->BoundsRect=ProgressBarRect;
		ProgressBarMonitor->PaintTo(StatusBar->Canvas->Handle,ProgressBarRect.Left,ProgressBarRect.Top+1);
	}
}
//---------------------------------------------------------------------------
void __fastcall TSupperMainForm::ProgressBarStepBy(TObject *Sender)
{
// Данная функция отображает индикатор загрузки,которая влияет на устойчивость
// просмотра мониторных форм.
// Для изучения поведения в С++ 5.0 необходимо произвести комплекс исследований.
// При получении отрицательных результатов тело функции необходимо закомментировать
	/*if(Sender==NULL)
		ProgressBarMonitor->Position=0;
	else
		ProgressBarMonitor->Position=(TProgressRange)((ProgressBarMonitor->Position+ProgressBarMonitor->Step)%ProgressBarMonitor->Max);
    ProgressBarMonitor->PaintTo(StatusBarSupperMain->Canvas->Handle,ProgressBarRect.Left,ProgressBarRect.Top+1);  */
}//---------------------------------------------------------------------------

void __fastcall TSupperMainForm::N13Click(TObject *Sender)
{
  ManForm=new TManForm(this );
  ManForm->OnProgressBarStepBy=this->ProgressBarStepBy;
  PostMessage(ManForm->Handle,WM_MONITORINIT,0,0);
}
//---------------------------------------------------------------------------
//===== 20.05.2005 Frizyuk A.M. Start
void __fastcall TSupperMainForm::MonitorMenuEnabled()
{
  mnAdmin->Enabled  = UsCon.Admin;
  for (int i = 0; i < MDIChildCount; ++i){
    if (dynamic_cast<TManForm *>(MDIChildren[i])){
      ((TManForm *)MDIChildren[i])->MonitorMenuEnabled();
    }
  }
  int rCode = dmMain->GetTaskRights(UsCon.Role_Id, 81);
  EditMonitorList->Visible  = rCode != TASK_RIGHTS_DISABLE;
  EditMonitorList->Enabled  = rCode == TASK_RIGHTS_WRITE;
  rCode = dmMain->GetTaskRights(UsCon.Role_Id, 99);
  mnFilter->Visible  = rCode != TASK_RIGHTS_DISABLE;
  mnFilter->Enabled  = rCode == TASK_RIGHTS_WRITE;
}
//---------------------------------------------------------------------------
//===== 20.05.2005 Frizyuk A.M. Finish
void __fastcall TSupperMainForm::FormCreate(TObject *Sender)
{
  //===== 06.07.2005 Frizyuk A.M. Start
  try
  { tFileListCnt  = new TStringList;
  }
  catch (Exception &e)
  { tFileListCnt  = NULL;
  }
  //===== 06.07.2005 Frizyuk A.M. Finish

/* Установка состояния пункта меню "План выполнения фонового процесса"  в зависимости от прав пользователя  .. ADD BY KSS 22.09.2003 */
   initMenuAccess();

unsigned long lr;

   MonitorMenuEnabled();
   dmMain->oqCursor->Params->Clear();
   dmMain->oqCursor->SQL->Text="begin "+SchemeName+"common_pg.get_role_info(:role_id,:par2); end;";
   dmMain->oqCursor->ParamByName("role_id")->AsInteger=UsCon.Role_Id;
   dmMain->oqCursor->ParamByName("par2")->ParamType = ptOutput;
   dmMain->oqCursor->ParamByName("par2")->DataType = ftCursor;
   dmMain->oqCursor->Execute();
   UserRol.Role_Id=dmMain->oqCursor->FieldByName("role_id")->AsInteger;
   UserRol.Monitor=dmMain->oqCursor->FieldByName("monitor")->AsInteger;
   dmMain->oqCursor->Close();
   InitializeCriticalSection(&ListInteriorCriticalSection);
   ListInterior= new TList();

                //Bludov: 27.07.2002
		//Поток для мигания кнопками панели инструментов
                //g_pUpdateImagesThread = new TUpdateImagesForSpeedButtons( false );

		m_pAlertOfSysTable = new TInteriorAlert( this );
		m_pAlertOfSysTable->refreshData( 4, dmMain->qwInter );

		isMonitorAlertTerminate=false;
		MonitorAlert=new TMonitorAlert(true);
		MonitorAlert->OnTerminate=OnMonitorAlertTerminate;
		MonitorAlert->Resume();
    // VTR 2.02.2001
	if(false&&!UsCon.Admin){
		sbCreateMonitor->Visible=false;
          N13->Enabled=false;
          PostMessage(SupperMainForm->Handle,	WM_CREATEMONITOR, 0, 0);
	}
     else{
          sbCreateMonitor->Hint=Reconst_smes60_1;
          N13->Caption=Reconst_smes60_1;
     }
   mmConnectionTerminal->Enabled=(customer_id==1||customer_id==51);
   mmConnectionTerminal->Visible=mmConnectionTerminal->Enabled;
   Caption=Application->Title;
   ///// 13.01.2009 KAG start
   HighLightTimerTimer(Sender);
   ///// 13.01.2009 KAG end

#if ONLY_DEMO_VER>0 //Проверка ограничений
   if(dmMain->SystemDate>TDateTime(ONLY_DEMO_VER/100, ONLY_DEMO_VER%100, 1)){
    dmMain->orases=dmMain->orasesAlert;
    Close();
    Application->Terminate();
   }
#endif
}
//---------------------------------------------------------------------------
void __fastcall TSupperMainForm::N11Click(TObject *Sender)
{
   if(TaskMenuForm == NULL)
      TaskMenuForm=new TTaskMenuForm(Application);
   else
      PostMessage(SupperMainForm->ClientHandle,WM_MDIACTIVATE,(WPARAM)TaskMenuForm->Handle,0);
}
//---------------------------------------------------------------------------
void __fastcall TSupperMainForm::N1Click(TObject *Sender)
{
/*	if( MainForm==NULL )
    	N11->Enabled=true;
    else
        N11->Enabled=false;*/
	/*
    if( ManForm==NULL )
    	N13->Enabled=true;
    else
    	N13->Enabled=false;
    */
}
//---------------------------------------------------------------------------
void __fastcall TSupperMainForm::TileGClick(TObject *Sender)
{
    TileMode = tbHorizontal;
	Tile();
}
//---------------------------------------------------------------------------
void __fastcall TSupperMainForm::Cascade1Click(TObject *Sender)
{
	Cascade();
}
//---------------------------------------------------------------------------
void __fastcall TSupperMainForm::N12Click(TObject *Sender)
{
     if(!fmMonitorList)
        fmMonitorList = new TfmMonitorList(this);
     else
        PostMessage(SupperMainForm->ClientHandle,WM_MDIACTIVATE,(WPARAM)fmMonitorList->Handle,0);
}
//---------------------------------------------------------------------------
void __fastcall TSupperMainForm::N15Click(TObject *Sender)
{
 Close();
}
//---------------------------------------------------------------------------
void __fastcall TSupperMainForm::TileVClick(TObject *Sender)
{
	TileMode = tbVertical;
	Tile();
}
//---------------------------------------------------------------------------
void __fastcall TSupperMainForm::mnAboutClick(TObject *Sender)
{
	TfmAbout *f = new TfmAbout(this);
  f->ShowModal();
  delete f;
}
//---------------------------------------------------------------------------
void __fastcall TSupperMainForm::mnToolsClick(TObject *Sender)
{
  if(mnTools->Checked)
    {
     paTools->Height = 0;
     mnTools->Checked = false;
    }else
      {
       paTools->Height = 45;/*29;*/
       mnTools->Checked = true;
      }
}
//---------------------------------------------------------------------------
void __fastcall TSupperMainForm::mnStatusClick(TObject *Sender)
{
  if(mnStatus->Checked)
    {
     StatusBarSupperMain->Height = 0;
     mnStatus->Checked = false;
    }else
      {
       StatusBarSupperMain->Height = 19;
       mnStatus->Checked = true;
      }
}
//---------------------------------------------------------------------------
void __fastcall TSupperMainForm::N2Click(TObject *Sender)
{
// Application->HelpCommand(HELP_CONTEXT,0);
 //Application->HelpCommand(HELP_FINDER,0);
 HtmlHelpA(GetDesktopWindow(),"askue.chm",HH_HELP_FINDER,0);

 //16.10.2020 - GRB TRY
 //ShellExecute(Handle, "open", "askue.chm", "index.html", NULL, SW_SHOWNORMAL);
}
//---------------------------------------------------------------------------
void __fastcall TSupperMainForm::N9Click(TObject *Sender)
{
	    HtmlHelpA(GetDesktopWindow(),"askue.chm",HH_HELP_CONTEXT,401);
	//Application->HelpContext(401);
}
//---------------------------------------------------------------------------
void __fastcall TSupperMainForm::N16Click(TObject *Sender)
{
	    HtmlHelpA(GetDesktopWindow(),"askue.chm",HH_HELP_CONTEXT,506);
	//Application->HelpContext(506);
}
//---------------------------------------------------------------------------
void __fastcall TSupperMainForm::N19Click(TObject *Sender)
{
	    HtmlHelpA(GetDesktopWindow(),"askue.chm",HH_HELP_CONTEXT,601);
	//Application->HelpContext(601);
}
//---------------------------------------------------------------------------
void __fastcall TSupperMainForm::FormKeyDown(TObject *Sender, WORD &Key, TShiftState Shift)
{
		if(Key==112)
	   Application->HelpCommand(HELP_FINDER,0);
}
//---------------------------------------------------------------------------
void    __fastcall TSupperMainForm::WMRefreshData(TMessage& Message)
{
   for(int i=0; i<MDIChildCount; i++)
	   if(MDIChildren[i]!=TaskMenuForm)
		   PostMessage(MDIChildren[i]->Handle,WM_REFRESHDATA,Message.WParam,Message.LParam);
}
//---------------------------------------------------------------------------
void __fastcall TSupperMainForm::FormCloseQuery(TObject *Sender, bool &CanClose)
{
    //      int Count = 0;
    // Перед закрытием главной формы необходимо закрыть все дочерние окна
    // т.к. если будут открытые окна с OLE то могут возникать ошибки при
    // уничтожении объектов
    TMainForm*mf;
    for(int i = MDIChildCount-1; i >= 0; i--){
        mf=dynamic_cast<TMainForm*>(MDIChildren[i]);
        if(mf){
            mf->EditRec = false;
            mf->Access = accRead;
        }
        SendMessage(MDIChildren[i]->Handle, WM_CLOSE, 0, 0);
//      else
//         MDIChildren[i]->Hide();
//         MDIChildren[i]->Close();
    }

   CanClose = false;
   CloseCnt++;
   if(FormParamCommunicationServer){
      if(!CloseCnt) return;
      SendMessage(FormParamCommunicationServer->Handle, WM_CLOSE, 0,0);
      CloseCnt=-1;
   }
   if(FormIntrpriseReneme){
      if(!CloseCnt) return;
      SendMessage(FormIntrpriseReneme->Handle, WM_CLOSE, 0,0);
      CloseCnt=-1;
   }
   if(CloseCnt==-1){
      PostMessage(Handle, WM_CLOSE, 0,0);
      return;
   }

   Timer1->Enabled = true;
   StatusBarSupperMain->Panels->Items[0]->Text = Reconst_smes60_3;
//   Menu = NULL;
   N11->Enabled = false;
   sbOpenEditor->Enabled = false;
   paTools->Visible = false;
   ToolBar1->Visible = false;
   Application->ProcessMessages();
//    while(!CanClose)
//    {
	if( !isMonitorAlertTerminate )
	{
                //Bludov: 27.07.2002
		//g_pUpdateImagesThread->Terminate();
		MonitorAlert->Terminate();
		Application->ProcessMessages();
	}
	else
   {
		CanClose=true;
                //Bludov: 27.07.2002
                //delete g_pUpdateImagesThread;
      if( m_pAlertOfSysTable )
      {
         delete m_pAlertOfSysTable;
         m_pAlertOfSysTable = NULL;
      }
   }
/*      if(Count>60)
        CanClose = true;
      else
        if(!CanClose)
          Sleep(1000);
      Count++;
    }*/

 TRegistry *pReg=new TRegistry;
  pReg->Access=KEY_WRITE;
	pReg->RootKey=HKEY_CURRENT_USER;
  	if( pReg->OpenKey("\\SOFTWARE\\Grant\\Ascue\\Monitors", true) )
	{
	    try
		{
       pReg->WriteInteger("RZ",RateZona);
       pReg->WriteInteger("TZ",TimeZonaMid);
    }
		catch(Exception &e)
		{
			pReg->CloseKey();
			delete pReg;
			throw;
		}
    }
	else
		throw Exception(AnsiString(Reconst_smes129_3));
	pReg->CloseKey();



}
//---------------------------------------------------------------------------
void __fastcall TSupperMainForm::OnMonitorAlertTerminate(TObject *Sender)
{
	isMonitorAlertTerminate=true;
	Close();
}
//---------------------------------------------------------------------------
void __fastcall TSupperMainForm::N21Click(TObject *Sender)
{
	FormSetupMonitors->ShowModal();
}
//---------------------------------------------------------------------------
void __fastcall TSupperMainForm::sbMinimizeClick(TObject *Sender)
{
     PostMessage(   SupperMainForm->Handle,  // handle of destination window
                    WM_SYSCOMMAND,  // message to send
                    SC_MINIMIZE,    // first message parameter
             	     0);     // second message parameter
}
//---------------------------------------------------------------------------
void __fastcall TSupperMainForm::WMCreateMonitor(TMessage& Message)
{
	N13Click(this);
}
//---------------------------------------------------------------------------
void __fastcall TSupperMainForm::menuSetupMonitorRefreshClick(
      TObject *Sender)
{
     //FormSetupMonitorRefresh->ShowModal();
}
//---------------------------------------------------------------------------
void __fastcall TSupperMainForm::Timer1Timer(TObject *Sender)
{
     isMonitorAlertTerminate=true;
     Close();
//     exit(9);
}
//---------------------------------------------------------------------------
void __fastcall TSupperMainForm::UpdateSpeedButton( TMessage& Message )
{
	if( Message.WParam == 4 )
	{
		if( Message.LParam & 0x04 )
			m_pUpdateButton1->NumGlyphs = 1; //Enabled = true;
		else
			m_pUpdateButton1->NumGlyphs = 2;//Enabled = false;

		if( Message.LParam & 0x02 )
			m_pUpdateButton2->NumGlyphs = 1; //Enabled = true;
		else
			m_pUpdateButton2->NumGlyphs = 2; //Enabled = false;
                if (!wasTabu){
		        if( Message.LParam & 0x01 )
			        m_pUpdateButton3->Enabled = true;
		        else
			        m_pUpdateButton3->Enabled = false;
                }

                if (!wasTabu){
    	                if( Message.LParam & 0x08 )
			        sbCTS->Visible = true;
		        else
			        sbCTS->Visible = false;
		        spDSJournal->Visible = sbCTS->Visible;
                }
	}
}
//---------------------------------------------------------------------------
void __fastcall TSupperMainForm::OnChanelButtonClick(TObject *Sender)
{
	TdlgJournalAlert  *dlgJournalAlert  = new TdlgJournalAlert(this);

  try
	{
    if (Sender == (TObject *)m_pUpdateButton1)
    {
        if(1 == m_pUpdateButton1->NumGlyphs)
		{
            dlgJournalAlert->Tag  = 1;
            dlgJournalAlert->HelpContext=317;
        }
        else
            Application->MessageBox("Обрывов связи не обнаружено!",Application->Title.c_str(),MB_OK|MB_ICONINFORMATION);

    }
    if (Sender == (TObject *)m_pUpdateButton2)
    {
        if(1 == m_pUpdateButton2->NumGlyphs)
        {
            dlgJournalAlert->Tag  = 2;
            dlgJournalAlert->HelpContext=318;
        }
        else
            Application->MessageBox("Предупреждения системы отсутствуют!",Application->Title.c_str(),MB_OK|MB_ICONINFORMATION);
    }

    if (Sender == (TObject *)m_pUpdateButton3)
    {
      dlgJournalAlert->Tag  = 3;
      dlgJournalAlert->HelpContext=319;
    }
     // Add by KSS
    if (Sender == (TObject *)m_pUpdateButton4)
    {
      dlgJournalAlert->Tag  = 4;
      dlgJournalAlert->HelpContext=313;
    }
     // end add by KSS
    if (dlgJournalAlert->Tag != 0)
      dlgJournalAlert->ShowModal();

  }
  __finally
	{ delete  dlgJournalAlert;
    dlgJournalAlert = NULL;
  }
}
//---------------------------------------------------------------------------
void __fastcall TSupperMainForm::mnOperScanClick(TObject *Sender)
{
   TfmOperScanSched::OperScanSchedShow();
}
//---------------------------------------------------------------------------
void __fastcall TSupperMainForm::N27Click(TObject *Sender)
{
   fmDeportProcsSched = new TfmDeportProcsSched(SupperMainForm);
   fmDeportProcsSched->ShowModal();
   delete fmDeportProcsSched;
}
//---------------------------------------------------------------------------
void __fastcall TSupperMainForm::EditMonitorListClick(TObject *Sender)
{
        TfmSaveMonitorAs *f = new TfmSaveMonitorAs(this);
        f->ShowModal_Form(wtEdit);
        delete f;
}
//---------------------------------------------------------------------------
void __fastcall TSupperMainForm::mmConnectionTerminalClick(TObject *Sender)
{
    WinExec(AnsiString("conn_term.exe tns="+dmMain->orases->Server+conStr).c_str(), SW_SHOW);
}
//---------------------------------------------------------------------------
void __fastcall TSupperMainForm::mmRequestTerminalClick(TObject *Sender)
{
   WinExec(("opros_term.exe tns=" +dmMain->orases->Server +conStr).c_str(),SW_SHOW);
}
//---------------------------------------------------------------------------
void __fastcall TSupperMainForm::mmMeteringTerminalClick(TObject *Sender)
{
   WinExec((AnsiString("evid_terme.exe ") +dmMain->orases->ConnectString).c_str(),SW_SHOW);
}
//---------------------------------------------------------------------------
void __fastcall TSupperMainForm::mmMeteringMonitorClick(TObject *Sender)
{
   WinExec((AnsiString("monitormeters.exe ") +dmMain->orases->ConnectString).c_str(),SW_SHOW);
}
//---------------------------------------------------------------------------
void __fastcall TSupperMainForm::initMenuAccess(void)
{
   dmMain->oqCursor->Params->Clear();
   dmMain->oqCursor->SQL->Text="begin "+SchemeName+"common_pg.initMenuAccess(:par1,:par2,:par3,:par4,:par5,:par6); end;";
   try{
     dmMain->oqCursor->ParamByName("par1")->AsInteger=UsCon.Role_Id;
     dmMain->oqCursor->ParamByName("par2")->ParamType=ptOutput;
     dmMain->oqCursor->ParamByName("par2")->DataType=ftInteger;
     dmMain->oqCursor->ParamByName("par3")->ParamType=ptOutput;
     dmMain->oqCursor->ParamByName("par3")->DataType=ftInteger;
     dmMain->oqCursor->ParamByName("par4")->ParamType=ptOutput;
     dmMain->oqCursor->ParamByName("par4")->DataType=ftInteger;
     dmMain->oqCursor->ParamByName("par5")->ParamType=ptOutput;
     dmMain->oqCursor->ParamByName("par5")->DataType=ftInteger;
     dmMain->oqCursor->ParamByName("par6")->ParamType=ptOutput;
     dmMain->oqCursor->ParamByName("par6")->DataType=ftInteger;
     dmMain->oqCursor->Execute();
     N27->Enabled = dmMain->oqCursor->ParamByName("par2")->AsInteger;
     mmMeteringTerminal->Enabled = dmMain->oqCursor->ParamByName("par3")->AsInteger;
     mmMeteringTerminal->Visible=dmMain->oqCursor->ParamByName("par3")->AsInteger;
     mmMeteringTerminal->Tag=dmMain->oqCursor->ParamByName("par3")->AsInteger-1;
     mmRequestTerminal->Enabled = dmMain->oqCursor->ParamByName("par4")->AsInteger;
     mmRequestTerminal->Visible=dmMain->oqCursor->ParamByName("par4")->AsInteger;
     mmMeteringMonitor->Enabled=dmMain->oqCursor->ParamByName("par5")->AsInteger;
     mmMeteringMonitor->Visible=dmMain->oqCursor->ParamByName("par5")->AsInteger;
     mmRefreshDB->Enabled=dmMain->oqCursor->ParamByName("par6")->AsInteger;
     mmRefreshDB->Visible=dmMain->oqCursor->ParamByName("par6")->AsInteger;
     dmMain->oqCursor->Close();

   }catch(Exception &e){
     N27->Enabled = false;
     mmMeteringTerminal->Enabled=false;
     mmMeteringTerminal->Visible=false;
     mmRequestTerminal->Enabled=false;
     mmRequestTerminal->Visible=false;
     mmMeteringMonitor->Enabled=false;
     mmMeteringMonitor->Visible=false;
     mmRefreshDB->Enabled=false;
     mmRefreshDB->Visible=false;

     throw;
   }
}
//---------------------------------------------------------------------------
void __fastcall TSupperMainForm::FormDestroy(TObject *Sender)
{
  //===== 06.07.2005 Frizyuk A.M. Start
  try
  { if (tFileListCnt)
    { tFileListCnt->Clear();
      delete  tFileListCnt;
      tFileListCnt  = NULL;
    }
  }
  catch (Exception &e)
  {
  }
  //===== 06.07.2005 Frizyuk A.M. Finish
}
//---------------------------------------------------------------------------
void __fastcall TSupperMainForm::m_pUpdateButton4Click(TObject *Sender)
{
 TdlgJournalPortScan  *f = new TdlgJournalPortScan(this);
 f->ShowModal();
 delete  f;
}
//---------------------------------------------------------------------------
void __fastcall TSupperMainForm::mnAdminClick(TObject *Sender)
{
   WinExec((AnsiString("askueadm.exe ") +dmMain->orases->ConnectString).c_str(),SW_SHOW);
}

//---------------------------------------------------------------------------
void __fastcall TSupperMainForm::mnFilterClick(TObject *Sender)
{
  TfmSetupFilters *f=new TfmSetupFilters(this);
  f->ShowModal();
  delete f;
}
//---------------------------------------------------------------------------
void __fastcall TSupperMainForm::sbCTSClick(TObject *Sender)
{
  TfmCTSJournal *f=new TfmCTSJournal(this);
  f->ShowModal();
  delete f;
}
//---------------------------------------------------------------------------
void __fastcall TSupperMainForm::spDSJournalClick(TObject *Sender)
{
  TfmDSJournal *f=new TfmDSJournal(this);
  f->ShowModal();
  delete f;
}
//---------------------------------------------------------------------------

struct
{ int   type;
  long  mid;
} filter2 = {0, 0};
int adv_filter = 0;
AnsiString code;

void __fastcall TSupperMainForm::HighLightTimerTimer(TObject *Sender)
{
  bool alert = false;
  if (dmMain)
  {
    //Screen->Cursor = crArrow;
    //Application->ProcessMessages();
    dmMain->oqHighLightButtons->ParamByName("SERV")->AsInteger = 5;
    dmMain->oqHighLightButtons->Execute();
    sbCTS->ImageIndex = 2 + dmMain->oqHighLightButtons->ParamByName("SHOW_SERV")->AsInteger;
    alert = (bool)dmMain->oqHighLightButtons->ParamByName("SHOW_SERV")->AsInteger;
    dmMain->oqHighLightButtons->ParamByName("SERV")->AsInteger = 53;
    dmMain->oqHighLightButtons->Execute();
    spDSJournal->ImageIndex = 0 + dmMain->oqHighLightButtons->ParamByName("SHOW_SERV")->AsInteger;
    alert = alert || (bool)dmMain->oqHighLightButtons->ParamByName("SHOW_SERV")->AsInteger;
    dmMain->oqHighLightButtons->Close();
    Screen->Cursor = crDefault;
    if (FormSetupMonitors && alert)
    {
        FormSetupMonitors->MinitoringPlaySoundWarning(2);
    }


  }
     /**!!! GRB: Hardcode (bugefix: enabled button "break of communication" on SupperMain Form if breaks of communications are updated)!!!**/
      //TODO -> With disabled part in JournalAlert.cpp - need to migrate into HackUtilsFix.cpp  
      TdlgJournalAlert  *dlgJournalAlert  = new TdlgJournalAlert(this);
      dlgJournalAlert->quMain->Params->Clear();
      dlgJournalAlert->quMain->SQL->Text="begin "+SchemeName+"interior_pg.JournalAlert_p(:par1,:par2,:par3,:par4,:par5,:par6,:par7);end;";
      dlgJournalAlert->quMain->ParamByName("par7")->DataType=ftCursor;
      dlgJournalAlert->quMain->ParamByName("par7")->ParamType=ptOutput;

      dlgJournalAlert->quMain->ParamByName("par1")->AsInteger =1;
      dlgJournalAlert->quMain->ParamByName("par2")->AsString = "field2 desc";
      dlgJournalAlert->quMain->ParamByName("par3")->AsInteger = filter2.mid;
      dlgJournalAlert->quMain->ParamByName("par4")->AsInteger = filter2.type;
      dlgJournalAlert->quMain->ParamByName("par5")->AsString = code;
      dlgJournalAlert->quMain->ParamByName("par6")->AsInteger = adv_filter;
      dlgJournalAlert->quMain->Execute();
      if (dlgJournalAlert->quMain->RecordCount>0){
         m_pUpdateButton1->NumGlyphs = 1;
      }
      dlgJournalAlert->quMain->Close();
      delete (dlgJournalAlert);
      /*END GRB FIX*/
}
//---------------------------------------------------------------------------

void __fastcall TSupperMainForm::sbUserForumClick(TObject *Sender)
{
  if(UserForumMain == NULL)
//      UserForumMain = new UserForumMain(Application);
    Application->CreateForm(__classid(TUserForumMain), &UserForumMain);
  else
    PostMessage(SupperMainForm->ClientHandle, WM_MDIACTIVATE, (WPARAM)UserForumMain->Handle, 0);
//  TUserForumMain UserForumMain = new TUserForumMain(Application, "User Forum", 1);
//  Application->CreateForm(__classid(TUserForumMain), &UserForumMain);
}


//---------------------------------------------------------------------------------
void __fastcall TSupperMainForm::mmRefreshDBClick(TObject *Sender)
{

TSearchRec sr;
AnsiString DirName; //= "*.*";
TBlobField *BFileField;
bool Flag=false;

  AnsiString NewFileName = ExtractFilePath(Application->ExeName);

/* if (chdir(ExtractFilePath(Application->ExeName).c_str()))
    { throw(Exception("Ошибка установки текущей директории: "+ExtractFilePath(Application->ExeName)));   */
 //===== Если не существует конечный каталог - создать
      if (!DirectoryExists(NewFileName+"\\PAS\\"))
      { try
        { if (!myCreateDir(NewFileName+"\\PAS\\"))
            throw Exception("Невозможно создать конечный каталог: \"" + NewFileName+"\\PAS\\" + "\"");
        }
        catch (Exception &e)
        { throw Exception(e.Message);
        }
      }



dmMain->oqFindFile->Execute();
int ind=0;
while(!dmMain->oqFindFile->Eof){
  Flag=false;
  DirName= NewFileName+"PAS"+"\\"+dmMain->oqFindFile->FieldByName("canal")->AsString+"\\" + "*.*";
  if (!DirectoryExists(DirName)){
    try{
      if (!myCreateDir(DirName))
        throw Exception("Невозможно создать конечный каталог: \"" + DirName + "\"");
    }catch (Exception &e){
      throw Exception(e.Message);
    }
  }
  for(int r=FindFirst(DirName,faAnyFile,sr);!r;r=FindNext(sr))
   {
   // if(ExtractFileExt(sr.Name)==dmMain->oqFindFile->FieldByName("vfilename")->AsString &&
   if(ExtractFileName(sr.Name)==dmMain->oqFindFile->FieldByName("vfilename")->AsString &&
      // FileDateToDateTime(sr.Time)== dmMain->oqFindFile->FieldByName("dfiledate")->AsDateTime)
      sr.Time== DateTimeToFileDate(dmMain->oqFindFile->FieldByName("dfiledate")->AsDateTime))
       {
       Flag=true;
       dmMain->oqFindFile->Next();
       continue;
       }
    }

    FindClose(sr);


  if(!Flag &&
  !dmMain->oqFindFile->FieldByName("bfilebody")->IsNull)
  {
  BFileField= (TBlobField *)dmMain->oqFindFile->FieldByName("bfilebody");
  BFileField->SaveToFile(NewFileName+"PAS"+"\\"+dmMain->oqFindFile->FieldByName("canal")->AsString+"\\"
                        +dmMain->oqFindFile->FieldByName("vfilename")->AsString);
  FileSetDate(NewFileName+"PAS"+"\\"+dmMain->oqFindFile->FieldByName("canal")->AsString+"\\"
                        +dmMain->oqFindFile->FieldByName("vfilename")->AsString,
                        DateTimeToFileDate(dmMain->oqFindFile->FieldByName("dfiledate")->AsDateTime));
  ind++;
  }

  dmMain->oqFindFile->Next();

 }
 dmMain->oqFindFile->Close();
   Application->MessageBox(("Сохранено "+IntToStr(ind)+" файлов.").c_str(),"Обновление БД Качества электроэнергии",MB_OK|MB_ICONINFORMATION);
}
//---------------------------------------------------------------------------
void __fastcall TSupperMainForm::btnShowTablespaceUsageClick(
      TObject *Sender)
{
 TTablespaceUsage  *f = new TTablespaceUsage(this);
 f->ShowModal();
 delete  f;
}
//---------------------------------------------------------------------------
void __fastcall TSupperMainForm::ApplicationEvents1Message(tagMSG &Msg,
      bool &Handled)
{
        switch (Msg.message) {
        case WM_KEYDOWN: {
        if (Msg.wParam == 112) {
           TControl* cntr = FindControl(Msg.hwnd);
		   if (cntr == NULL){
           HtmlHelpA(GetDesktopWindow(),"askue.chm",HH_HELP_CONTEXT,201);
           Handled = true;
           return;
           }

           int code_context = 0;
           while ((cntr->Parent!=NULL)){
                code_context = cntr->HelpContext;
                if (code_context!=0) break;
                cntr = cntr->Parent;
           }
           code_context = cntr->HelpContext;
           HtmlHelpA(GetDesktopWindow(),"askue.chm",HH_HELP_CONTEXT, code_context);
           Handled = true;
           }

        } break;
        }
}
//---------------------------------------------------------------------------

void __fastcall TSupperMainForm::Timer2Timer(TObject *Sender)
{
        TabuByProperty();
        TabuByTime();
}
//---------------------------------------------------------------------------

