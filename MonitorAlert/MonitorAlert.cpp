//---------------------------------------------------------------------------
#include <vcl.h>
#include <registry.hpp>
#include <Winbase.h>
#pragma hdrstop
#include "MonitorAlert.h"
#include "Interior.h"
#include "unDataMod.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
//   Important: Methods and properties of objects in VCL can only be
//   used in a method called using Synchronize, for example:
//
//      Synchronize(UpdateCaption);
//
//   where UpdateCaption could look like:
//
//      void __fastcall TMonitorAlert::UpdateCaption()
//      {
//        Form1->Caption = "Updated in a thread";
//      }
//---------------------------------------------------------------------------
static char alert[100];
static char alertmessage[100];
static int AlertTimeZonaMid;
static int AlertRateZona;
static int AlertPowerCoeff;
HANDLE UpdateMonitors;
//---------------------------------------------------------------------------
__fastcall TMonitorAlert::TMonitorAlert(bool CreateSuspended)
	: TThread(CreateSuspended)
{
   UpdateMonitors = CreateMutex(NULL,FALSE,NULL);

      dmMain->orasesAlert->ConnectString=dmMain->orases->ConnectString;
      dmMain->orasesAlert->Connect();
      dmMain->qwAlert->Params->Clear();
      dmMain->qwAlert->SQL->Text= "begin "+SchemeName+"common_pg.begin_p; "+SchemeName+"admin_pg.register_all; end;";
      dmMain->qwAlert->Execute();

      AlertTimeZonaMid=1;
      AlertRateZona=1;
      AlertPowerCoeff=-1;
}
//---------------------------------------------------------------------------

__fastcall TMonitorAlert::~TMonitorAlert()
{
   CloseHandle(UpdateMonitors);
}
//---------------------------------------------------------------------------

void __fastcall TMonitorAlert::Execute()
{
	long alertcode=-1, kom_data, tech_data;
	int Table = 0;
	int CurrInterior;
	TInterior *pInterior;
	//---- Place thread code here ----
  try{
    while(!Terminated){  //Sleep(2000);continue;
    //------------------------------------------------------------------------- VNB 7.07.2009
    if(AlertTimeZonaMid!=TimeZonaMid||AlertRateZona!=RateZona||AlertPowerCoeff!=PowerCoeff)
    {
    dmMain-> oqAlertTimeZona->Params->Clear();
    dmMain-> oqAlertTimeZona->SQL->Text=" begin "+SchemeName+"interior_pg.set_TimeZone(:par1);\
                                                 "+SchemeName+"interior_pg.set_RateZona(:par2);\
                                                 "+SchemeName+"interior_pg.set_powercoeff(:par3);end;";

    dmMain-> oqAlertTimeZona->ParamByName("par1")->AsInteger=TimeZonaMid;
    dmMain-> oqAlertTimeZona->ParamByName("par2")->AsInteger= RateZona;
    dmMain-> oqAlertTimeZona->ParamByName("par3")->AsInteger= PowerCoeff;
    dmMain-> oqAlertTimeZona->Execute();
      AlertTimeZonaMid=TimeZonaMid;
      AlertRateZona=RateZona;
      AlertPowerCoeff=PowerCoeff;
    }

    //------------------------------------------------------------------------------
      dmMain->qwAlert->Params->Clear();
      dmMain->qwAlert->SQL->Text="begin "+SchemeName+"admin_pg.waitany(:par1,:par2,:par3,5); end;";
      dmMain->qwAlert->ParamByName("par1")->ParamType=ptOutput;
      dmMain->qwAlert->ParamByName("par1")->DataType=ftString;
      dmMain->qwAlert->ParamByName("par1")->Size=100;
      dmMain->qwAlert->ParamByName("par2")->ParamType=ptOutput;
      dmMain->qwAlert->ParamByName("par2")->DataType=ftString;
      dmMain->qwAlert->ParamByName("par2")->Size=100;
      dmMain->qwAlert->ParamByName("par3")->ParamType=ptOutput;
      dmMain->qwAlert->ParamByName("par3")->DataType=ftInteger;
      alert[0]=0;
      dmMain->qwAlert->Execute();
      if(!dmMain->qwAlert->ParamByName("par1")->IsNull)
        strcpy(alert,dmMain->qwAlert->ParamByName("par1")->AsString.c_str());
      if(!dmMain->qwAlert->ParamByName("par2")->IsNull)
        strcpy(alertmessage,dmMain->qwAlert->ParamByName("par2")->AsString.c_str());
      if(!dmMain->qwAlert->ParamByName("par3")->IsNull)
        alertcode=dmMain->qwAlert->ParamByName("par3")->AsInteger;
      if( Terminated )
        break;
      Table=-1;
      if( alertcode==0 && !stricmp(alert,"BILL"))
        Table=3;
      if( alertcode==0 && !stricmp(alert,"PROFILE"))
        Table=1;
      if( alertcode==0 && !stricmp(alert,"HALFHOUR"))
        Table=2;
      if( alertcode==0 && !stricmp(alert,"JOURNAL"))
        Table=4;
      if( alertcode==0 && !stricmp(alert,"FISCAL"))
        Table=5;
      if( alertcode==0 && !stricmp(alert,"CURR_POWER"))
        Table=6;
      if( alertcode==0 && !stricmp(alert,"CHANNELS"))
        Table=7;

  	  if(Table>0){
     		CurrInterior=0;
      while(WaitForSingleObject(UpdateMonitors,0)!=WAIT_OBJECT_0){
        Application->ProcessMessages();// если не удалось иниц-ть. CS то обновить экранные формы...
        Sleep(0);// переключить управление на другой поток, коьт занял CS
      }
      while(CurrInterior>=0){
        EnterCriticalSection(&ListInteriorCriticalSection);
        if(ListInterior->Count<=CurrInterior){
          CurrInterior=-111;
          pInterior=NULL;
        }else{
          pInterior=(TInterior*)ListInterior->Items[CurrInterior];
          if( pInterior->hMutex==NULL || WaitForSingleObject(pInterior->hMutex,1)!=WAIT_OBJECT_0 )
            pInterior=NULL;
        }
        if(pInterior){
          if(!Terminated ){
            if((pInterior->fd->CodeTemplate!=EXCEL_F)&&(pInterior->fd->CodeTemplate!=EXCEL_REP_F)&&(pInterior->fd->CodeTemplate!=EXCEL_OP_FORM)&&
            (pInterior->fd->CodeTemplate!=DU2CHART_PARAMS)&&(Table!=TABLE_JOURNAL)&&(Table!=TABLE_FISCAL))
              pInterior->refreshData(Table,dmMain->qwAlert);
            if(dynamic_cast<TForm*>(pInterior->Owner))
              PostMessage((dynamic_cast<TForm*>(pInterior->Owner))->Handle, WM_REFRESHDATA,Table,0l);
          }else{
            CurrInterior=-111;
            pInterior=NULL;
          }
          ReleaseMutex(pInterior->hMutex);
        }
        LeaveCriticalSection(&ListInteriorCriticalSection);
        ++CurrInterior;
      }
      ReleaseMutex(UpdateMonitors);
    }
    if( Terminated )
      break;
    alertcode = 0;
    /*dmMain->qwAlert->Params->Clear();
    dmMain->qwAlert->SQL->Text="SELECT "+SchemeName+"monitoring_pg.get_role_beep_status_f(:par1, 0) kom_data, "+SchemeName+"monitoring_pg.get_role_beep_status_f(:par1, 1)tech_data FROM dual";
    dmMain->qwAlert->ParamByName("par1")->AsInteger=UsCon.Role_Id;
    dmMain->qwAlert->Execute();
    kom_data=dmMain->qwAlert->FieldByName("kom_data")->AsInteger;
    tech_data=dmMain->qwAlert->FieldByName("tech_data")->AsInteger;
    if(kom_data>0)
      FormSetupMonitors->MinitoringPlaySoundWarning(0);
    if(tech_data>0)
      FormSetupMonitors->MinitoringPlaySoundWarning(1);
    */
    }
    dmMain->qwAlert->Params->Clear();
    dmMain->qwAlert->SQL->Text="begin "+SchemeName+"admin_pg.remove_all; end;";
    dmMain->qwAlert->Execute();
  }catch(Exception&e){
    AnsiString s=e.Message+Reconst_smes96_1;
    Application->MessageBox(s.c_str(),AnsiString(Application->Title+": Диспетчер мониторов").c_str(),MB_OK | MB_ICONERROR);
  }
}
//---------------------------------------------------------------------------


