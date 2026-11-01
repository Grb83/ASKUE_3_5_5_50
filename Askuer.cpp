//---------------------------------------------------------------------------
#include <vcl.h>
#include <stdio.h>
#pragma hdrstop
//---------------------------------------------------------------------------
USEFORM("unDataMod.cpp", dmMain); /* TDataModule: File Type */
USEFORM("uOraDBConnection.cpp", fmConnect);
USEFORM("FindPoint.cpp", fmFindPoint);
USEFORM("Find.cpp", FindForm);
USEFORM("Filter.cpp", fmFilter);
USEFORM("Main.cpp", MainForm);
USEFORM("setpasword.cpp", FormSetPasword);
USEFORM("unAbout.cpp", fmAbout);
USEFORM("SaveMonitorAs.cpp", fmSaveMonitorAs);
USEFORM("MonitorForm\PrintDrawTable.cpp", fmQR);
USEFORM("MonitorAlert\JournalAlert.cpp", dlgJournalAlert);
USEFORM("Indic\selectpoint.cpp", fmSelectPoint);
USEFORM("InputSwitchMeterage.cpp", fmInputMeterage);
USEFORM("OperScanSchedEd.cpp", fmOperScanSchedEd);
USEFORM("OperScanSched.cpp", fmOperScanSched);
USEFORM("OperScanPointPar.cpp", fmOperScanPointPar);
USEFORM("SupperMain.cpp", SupperMainForm);
USEFORM("TaskMenu.cpp", TaskMenuForm);
USEFORM("MonitorForm\MONITORFORM.cpp", BaseMonitorForm);
USEFORM("Saa_SelectGroup.cpp", fmSelectGroupReport);
USEFORM("Saa_SelectGroupProc.cpp", fmSelectGroupReportProc);
USEFORM("Saa_SelectForm.cpp", fmSelectReportForm);
USEFORM("SplitForm\SplitForm.cpp", SplitterForm);
USEFORM("SplitForm\Monitor.cpp", ManForm);
USEFORM("MonitorList.cpp", fmMonitorList);
USEFORM("GetSelectDateTime.cpp", fmGetSelectDateTime);
USEFORM("PeriodFormUnit.cpp", PeriodForm);
USEFORM("InfoFormUnit.cpp", InfoForm);
USEFORM("ParamCommunicationServer.cpp", FormParamCommunicationServer);
USEFORM("InterpriseRename.cpp", FormIntrpriseReneme);
USEFORM("DeportProcsSched.cpp", fmDeportProcsSched);
USEFORM("DeportProcRun.cpp", fmDeportProcRun);
USEFORM("Vit_Meter.cpp", FormVVMeter);
USEFORM("Vit_input.cpp", FormVITInput);
USEFORM("VIT_InputExcel.cpp", FormVITInputExcel);
USEFORM("EditGroupsList.cpp", FormEditGropsList);
USEFORM("EditTimeMaxLoad.cpp", FormEditTimeMaxLoad);
USEFORM("ControlVolueDB.cpp", FormControlVolueDB);
USEFORM("ChangeCounters.cpp", FormChangeCounters);
USEFORM("CountParam.cpp", FormCountParam);
USEFORM("GetDataIntCounter.cpp", FormGetDataIntCounter);
USEFORM("EditIntrodactPulsCout.cpp", FormIntrodactPulsCount);
USEFORM("EditFormsList.cpp", FormEditFormList);
USEFORM("CopySchemaParams.cpp", FormCopyShcema);
USEFORM("EditRates.cpp", FormEditRates);
USEFORM("DeportProcs.cpp", fmDeportProcs);
USEFORM("EditCOMportList.cpp", FormEditCOMportList);
USEFORM("SwitchOV.cpp", FormSwitchOV);
USEFORM("SelectSvitchPoint.cpp", FormSelectSvitchPoint);
USEFORM("DuplicateCnt.cpp", fmDuplicateCnt);
USEFORM("DuplicateCnt_InputParams.cpp", fmDuplicateCnt_InputParams);
USEFORM("DuplicateCnt_ps_tu.cpp", fmDuplicateCnt_PS_TU);
USEFORM("EditMaket.cpp", EditMaketForm);
USEFORM("maketarm.cpp", fmMaketArm);
USEFORM("Vit_Delta.cpp", FormVITInputDelta);
USEFORM("Vit_deltaExcel.cpp", FormVITInputDeltaExcel);
USEFORM("Indic\consump.cpp", fmConsump);
USEFORM("EditTariff.cpp", EditTariffForm);
USEFORM("RequestMonitoring.cpp", fmRequestMonitoring);
USEFORM("EditCounter.cpp", FormCounter);
USEFORM("InputParameters.cpp", FormInputParameters);
USEFORM("InputParameters4.cpp", FormInputParameters4);
USEFORM("LastSave.cpp", LastSaveForm);
USEFORM("ParameterPointsList.cpp", fmParameterPointsList);
USEFORM("unCalcParam.cpp", fmCalcParam);
USEFORM("unWorkTime.cpp", fmWorkTime);
USEFORM("EditRequestPlan.cpp", fmEditRequestPlan);
USEFORM("TeleControlSignals.cpp", FormTeleControlSignals);
USEFORM("EditFiders.cpp", FormEditFiders);
USEFORM("PointConditions.cpp", fmPointConditions);
USEFORM("ChannelPointsList.cpp", fmChannelPointsList);
USEFORM("EditDeportationPlan.cpp", fmEditDeportationPlan);
USEFORM("DLK_ViewShem.cpp", ViewShemForm);
USEFORM("EditTransformers.cpp", TransformersForm);
USEFORM("ChangeTransformers.cpp", ChangeTransformersForm);
USEFORM("ImportDatafiles.cpp", ImportDatafilesForm);
USEFORM("InputParam.cpp", FormInputParam);
USEFORM("TypePart.cpp", fmTypePart);
USEFORM("NewMonitorForm\unGraphMaket.cpp", fmGraphMaket);
USEFORM("NewMonitorForm\unInteriorUni.cpp", fmInteriorUni);
USEFORM("MonitorAlert\unCTSJournal.cpp", fmCTSJournal);
USEFORM("unMeterParameter.cpp", fmMeterParameter);
USEFORM("unEditFormula.cpp", fmEditFormula);
USEFORM("BlockMessage.cpp", fmBlockMess);
USEFORM("unSetupFilters.cpp", fmSetupFilters);
USEFORM("MonitorAlert\JournalPortScan.cpp", dlgJournalPortScan);
USEFORM("unSpecParam.cpp", fmSpecParam);
USEFORM("MonitorForm\ValidParamOld.cpp", fmValidityFormOld);
USEFORM("unTree.cpp", fmTree);
USEFORM("MonitorAlert\unDSJournal.cpp", fmDSJournal);
USEFORM("unAddToTree.cpp", fmAddToTree);
USEFORM("unGuid.cpp", fmGuid);
USEFORM("unMaketArmR.cpp", fmMaketArmR);
USEFORM("unKoeff.cpp", fmKoeff);
USEFORM("unPrior.cpp", fmPrior);
USEFORM("SetupMonitor\SetupMonitors.cpp", FormSetupMonitors);
USEFORM("ManualInput.cpp", fmManualInput);
USEFORM("ManualInTree.cpp", FormManualInTree);
USEFORM("StatICCPUnit.cpp", StatICCPForm);
USEFORM("MonitorForm\ValidParam.cpp", fmValidityForm);
USEFORM("FormUserForumViewTopic.cpp", UserForumViewTopic);
USEFORM("FormUserForumAddReply.cpp", UserForumAddReply);
USEFORM("FormUserForumAddTopic.cpp", UserForumAddTopic);
USEFORM("FormUserForumMain.cpp", UserForumMain);
USEFORM("ManualInputMeter.cpp", fmManualInputMeter);
USEFORM("unEditServName.cpp", fmEditServName);
USEFORM("MonitorICCPUnit.cpp", MonitorICCPForm);
USEFORM("MonitorForm\unEnrgValid.cpp", fmEnrgValid);
USEFORM("MonitorForm\DetailPoint.cpp", fmDetailPoint);
USEFORM("unRefCounter.cpp", fmRefCounter);
USEFORM("unListCounter.cpp", fmListCounter);
USEFORM("unViewTree.cpp", fmViewTree);
USEFORM("unComportEvents.cpp", fmComportEvents);
USEFORM("TablespaceUsageForm.cpp", TablespaceUsage);
USEFORM("unMTX.cpp", fmMTX);
USEFORM("unRTRNIK.cpp", fmRTRNIK);
USEFORM("unChInt.cpp", fmChInter);
USEFORM("InputStartMeters.cpp", fmInputStartMeters);
USEFORM("unRTRNP.cpp", fmRTRNP);
USEFORM("GetSelectDate.cpp", fmGetSelectDate);
//---------------------------------------------------------------------------
#include "unDataMod.h"
#include "unAbout.h"
#include "Reconst.hpp"
#include "Reinit.hpp"
#include "unitperm.h"
//---------------------------------------------------------------------------
#pragma link "permlib.lib"
//---------------------------------------------------------------------------
WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR lpCmdLine, int)
{
  HANDLE hTemp;
  int Error;
  try{
  //22.08.2019 UNKEY VERSION COMMENT
/*#if CHK_ALL_LIMITS==1 //Проверка ограничений
     if (GrdInitPermission()<0){
        ShowMessage("Ошибка инициализации ключа электронной защиты.");
        return 0;
     }
#endif */
    //END COMMENT
    //Начали локализацию
    AnsiString Language;
    TRegistry *Reg = new TRegistry(KEY_READ);
    try{
      Reg->RootKey =HKEY_LOCAL_MACHINE;
      Reg->Access=KEY_READ;
      Reg->OpenKey("SOFTWARE\\INTEP\\ASKUE", False);
      Language = Reg->ReadString("Language");
      if(!Language.Length()){
        char c[256];
        GetLocaleInfo(GetSystemDefaultLCID(), LOCALE_SABBREVLANGNAME, c, sizeof(c));
        Language=c;
      }
    }__finally{
      delete Reg;
    }
    if(Language=="UKR")
      LoadNewResourceModule(LANG_UKRAINIAN);
    //Закончили локализацию
  	Application->Initialize();
    Application->UpdateFormatSettings = false;
    InitGlobalVariable();
    hTemp=CreateMutex(NULL,false,"FirstASCUER");
    Error=GetLastError();
    if(!ParamStr(5).Length()||Error!=ERROR_ALREADY_EXISTS){
     Application->Title = "АСКУЭ";
     Application->Title = Reconst_smes1_1;
     //16.10.2020 - Это старый механизм подключения хелпа - по новому через shellExecute в каждом окне и отлове F1 в нём с именем html файла его тут нужно будет убрать
     //Application->HelpFile = "Askue.hlp";
     //Application->HelpFile = "askue.chm";
     fmAbout = new TfmAbout(Application);
     fmAbout->BorderIcons = TBorderIcons();
     fmAbout->BorderStyle = bsNone;
     fmAbout->Position = poScreenCenter;
     fmAbout->Height = fmAbout->Image1->Height;
     Application->CreateForm(__classid(TdmMain), &dmMain);
                 Application->CreateForm(__classid(TSupperMainForm), &SupperMainForm);
                 Application->CreateForm(__classid(TFormSetupMonitors), &FormSetupMonitors);
                 Application->CreateForm(__classid(TfmMonitorList), &fmMonitorList);
                 fmAbout->Hide();
      delete fmAbout;
      Application->Run();
    }else
      if(Error == ERROR_ALREADY_EXISTS)
        ShowMessage(Reconst_smes1_2);
    CloseHandle(hTemp);
  }catch (Exception &exception){
	  Application->ShowException(&exception);
  }
	return 0;
}
//---------------------------------------------------------------------------
/*
WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR lpCmdLine, int)
{
  HANDLE hTemp;
  int Error;
  try{
#if CHK_ALL_LIMITS==1 //Проверка ограничений
     if (GrdInitPermission()<0){
        ShowMessage("Ошибка инициализации ключа электронной защиты.");
        return 0;
     }
#endif
    //Начали локализацию
    AnsiString Language;
    TRegistry *Reg = new TRegistry(KEY_READ);
    try{
      Reg->RootKey =HKEY_LOCAL_MACHINE;
      Reg->Access=KEY_READ;
      Reg->OpenKey("SOFTWARE\\INTEP\\ASKUE", False);
      Language = Reg->ReadString("Language");
      if(!Language.Length()){
        char c[256];
        GetLocaleInfo(GetSystemDefaultLCID(), LOCALE_SABBREVLANGNAME, c, sizeof(c));
        Language=c;
      }
    }__finally{
      delete Reg;
    }
    if(Language=="UKR")
      LoadNewResourceModule(LANG_UKRAINIAN);
    //Закончили локализацию
  	Application->Initialize();
    Application->UpdateFormatSettings = false;
    InitGlobalVariable();
    hTemp=CreateMutex(NULL,false,"FirstASCUER");
    Error=GetLastError();
    if(!ParamStr(5).Length()||Error!=ERROR_ALREADY_EXISTS){
     Application->Title = "АСКУЭ";
     Application->Title = Reconst_smes1_1;
     Application->HelpFile = "Askue.hlp";
     fmAbout = new TfmAbout(Application);
     fmAbout->BorderIcons = TBorderIcons();
     fmAbout->BorderStyle = bsNone;
     fmAbout->Position = poScreenCenter;
     fmAbout->Height = fmAbout->Image1->Height;
     Application->CreateForm(__classid(TdmMain), &dmMain);
     if(!dmMain->orases->Connected)
        return 0;
     Application->CreateForm(__classid(TSupperMainForm), &SupperMainForm);
     Application->CreateForm(__classid(TFormSetupMonitors), &FormSetupMonitors);
     if(dmMain->LicType||GrdGetPermission(CHK_LIC_TASK,CHK_LIC_TASK_MONITOR)>0)
       Application->CreateForm(__classid(TfmMonitorList), &fmMonitorList);
     fmAbout->Hide();
      delete fmAbout;
      Application->Run();
    }else
      if(Error == ERROR_ALREADY_EXISTS)
        ShowMessage(Reconst_smes1_2);
    CloseHandle(hTemp);
  }catch (Exception &exception){
	  Application->ShowException(&exception);
  }
	return 0;
}
*/

