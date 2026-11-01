//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#include "TaskMenu.h"
#include "SupperMain.h"
#include "Main.h"
#include "unDataMod.h"
#include "InterpriseRename.h"
#include "DeportProcs.h"
#include "EditRequestPlan.h"
#include "ParamCommunicationServer.h"
#include "EditCOMportList.h"
#include "EditFormsList.h"
#include "EditTimeMaxLoad.h"
#include "ControlVolueDB.h"
#include "EditRates.h"
#include "EditTariff.h"
//////////////////////////////
#include "EditGroupsList.h"
//#include "EditExportGropsList.h"
#include "EditFiders.h"
#include "EditIntrodactPulsCout.h"
#include "ChangeCounters.h"
#include "SwitchOV.h"
#include "EditMaket.h"
#include "maketarm.h"
#include "Vit_input.h"
//#include "ReportGroups.h"
#include "EditDeportationPlan.h"
#include "VIT_InputExcel.h"
#include "Vit_Delta.h"
#include "Vit_deltaExcel.h"
#include "consump.h"
#include "ImportDatafiles.h"
#include "RequestMonitoring.h"
#include "EditTransformers.h"
#include "DuplicateCnt.h"
#include "DLK_ViewShem.h"
#include "TeleControlSignals.h"
#include "unMaketArmR.h"
#include "StatICCPUnit.h"
#include "ManualInput.h"
#include "ManualInputMeter.h"
#include "FormUserForumMain.h" 
#include "MonitorICCPUnit.h"
#include "InputStartMeters.h"
//////////////////////////////
#include "Reconst.hpp"
#include "unitperm.h"
//---------------------------------------------------------------------------
#pragma resource "*.dfm"
TTaskMenuForm *TaskMenuForm=NULL;
//---------------------------------------------------------------------------

__fastcall TTaskMenuForm::TTaskMenuForm(TComponent* Owner)
	: TForm(Owner)
{
   TaskMenuForm = this;
}
//---------------------------------------------------------------------------

__fastcall TTaskMenuForm::~TTaskMenuForm()
{
   TaskMenuForm = NULL;
}
//---------------------------------------------------------------------------

void __fastcall TTaskMenuForm::FormCreate(TObject *Sender)
{
   if(ReadTreeNode(NULL)&&tvTasks->Items->Count)
      tvTasks->Selected=tvTasks->Items->Item[0];
}
//---------------------------------------------------------------------------

void __fastcall TTaskMenuForm::tvTasksDblClick(TObject *Sender)
{

    TTreeView *tv = dynamic_cast<TTreeView*>(Sender);
    if(tv&&tv->Selected&&tv->Selected->Data){
      TASKLIST* pAktTask=(TASKLIST*)tv->Selected->Data;
      RunTask(pAktTask->TaskName, pAktTask->NumberTask, pAktTask->fullacc);
    }
}
//---------------------------------------------------------------------------

bool __fastcall TTaskMenuForm::ReadTreeNode(TTreeNode* NodeParent)// Читает ветку дерева
{
  TASKLIST *PTreeTable;
  TTreeNode *AddNode;
  try{
    try{
    tvTasks->Items->BeginUpdate();
    if(!NodeParent)
      tvTasks->Items->Clear();

    dmMain->oqCursor->Params->Clear();
    dmMain->oqCursor->SQL->Text=" begin "+SchemeName+"interior_pg.TaskMenuForm_ReadTreeNode_p(:par1,:par2,:par3,:par4);end;";

    dmMain->oqCursor->ParamByName("par4")->DataType=ftCursor;
    dmMain->oqCursor->ParamByName("par4")->ParamType=ptOutput;

    dmMain->oqCursor->ParamByName("par1")->AsInteger =(NodeParent)?1:0;
    if(NodeParent)
      dmMain->oqCursor->ParamByName("par2")->AsInteger = ((TASKLIST*)NodeParent->Data)->Task_id;
    else{
      dmMain->oqCursor->ParamByName("par2")->AsInteger = 0;
      dmMain->oqCursor->ParamByName("par2")->Clear();
    }
    dmMain->oqCursor->ParamByName("par3")->AsInteger=UsCon.Role_Id;
    }catch (Exception &ex){
         AnsiString mess = "Беда перед вызовом interior_pg.TaskMenuForm_ReadTreeNode_p(:par1,:par2,:par3,:par4) с параметрами NodeParent->Data)->Task_id="+IntToStr (((TASKLIST*)NodeParent->Data)->Task_id);
         Application->MessageBox (mess.c_str(),Application->Title.c_str(),MB_OK);
    }
    try{
    dmMain->oqCursor->Execute();
    }catch (Exception &ex){
         AnsiString mess = "Беда на вызове interior_pg.TaskMenuForm_ReadTreeNode_p(:par1,:par2,:par3,:par4) с параметрами NodeParent->Data)->Task_id="+IntToStr (((TASKLIST*)NodeParent->Data)->Task_id);
         Application->MessageBox (mess.c_str(),Application->Title.c_str(),MB_OK);
    }
    try{
    while(!dmMain->oqCursor->Eof){
      PTreeTable = new TASKLIST;
      PTreeTable->Parent=dmMain->oqCursor->FieldByName("HaveChild")->AsInteger;
      PTreeTable->Task_id=dmMain->oqCursor->FieldByName("TASK_ID")->AsInteger;
      PTreeTable->NumberTask=dmMain->oqCursor->FieldByName("TASK_COD")->AsInteger;
      PTreeTable->TaskName=dmMain->oqCursor->FieldByName("NAME")->AsString;
      PTreeTable->fullacc = dmMain->oqCursor->FieldByName("NACC")->AsInteger;
      AddNode = tvTasks->Items->AddChildObject(NodeParent,PTreeTable->TaskName,PTreeTable);
      AddNode->ImageIndex =(PTreeTable->NumberTask)?1:0;
      AddNode->SelectedIndex=(PTreeTable->NumberTask)?1:0;
      if(PTreeTable->Parent){
        tvTasks->Items->AddChildObject(AddNode,"",(void*)0);
        PTreeTable->Parent=0;
      }
      dmMain->oqCursor->Next();
    }
    dmMain->oqCursor->Close();
    tvTasks->Items->EndUpdate();
    }catch   (Exception &ex){
         AnsiString mess = "Беда после вызова interior_pg.TaskMenuForm_ReadTreeNode_p(:par1,:par2,:par3,:par4) с параметрами NodeParent->Data)->Task_id="+IntToStr (((TASKLIST*)NodeParent->Data)->Task_id);
         Application->MessageBox (mess.c_str(),Application->Title.c_str(),MB_OK);
    }
  }catch (Exception &exception){
  	Application->ShowException(&exception);
    return false;
  }
  return true;
}
//----------------------------------------------------------------------------

void __fastcall TTaskMenuForm::tvTasksDeletion(TObject *Sender,
      TTreeNode *Node)
{
   if(Node&&Node->Data)
      delete (TASKLIST*)Node->Data;
}
//---------------------------------------------------------------------------

void __fastcall TTaskMenuForm::tvTasksExpanding(TObject *Sender,
      TTreeNode *Node, bool &AllowExpansion)
{
   AllowExpansion = false;
}
//---------------------------------------------------------------------------

void __fastcall TTaskMenuForm::TreeView1ExpCol(TObject *Sender,
      TTreeNode *Node)
{
   switch(Node->ImageIndex){
   case 0:
      Node->ImageIndex = 2;
      Node->SelectedIndex = 2;
      break;
   case 2:
      Node->ImageIndex = 0;
      Node->SelectedIndex = 0;
      break;
   }
}
//---------------------------------------------------------------------------

void __fastcall TTaskMenuForm::RunTask(AnsiString Name, int Id, int a)
{
    TAccess acc = a==1?accWrite:(a==0?accRead:accDenied);
    TMainForm*Child;
//    Graphics::TColor accessColor = (acc==accRead)?clBlue:clGreen;
    int id = Id;

    // проверка открыта выбранная задача или нет
    for(int i=0; i<SupperMainForm->MDIChildCount; i++){
        Child = dynamic_cast<TMainForm*>(SupperMainForm->MDIChildren[i]);
        if(Child && (Child->TaskId==Id)){
            PostMessage(SupperMainForm->ClientHandle,WM_MDIACTIVATE,(WPARAM)SupperMainForm->MDIChildren[i]->Handle,0);
            return;
        }
    }
    Child=NULL;

   // запуск новый задачи
   Screen->Cursor = crHourGlass;
   try{
       switch(id){
   case 10:  //    настройка групп учета  по аскує +
        //22.08.2019 UNKEY VERSION COMMENT
      /*if(dmMain->LicType||GrdGetPermission(CHK_LIC_TASK,CHK_LIC_TASK_GROUP)>0)*/
          //22.08.2019 END  COMMENT
        Child = new TFormEditGropsList(Application, Name, acc);
    	break;
/*   case 11:  // настройка експортных групп учета +
      Child = new TFormEditExportGropsList(Application, Name, acc);
    	break;*/
   case 21:  // Контроль объема БД +
      Child = new TFormControlVolueDB(Application, Name, acc);
    	break;
   case 22:  // параметры коммуникационного сервера
      if(FormParamCommunicationServer){
         ::SetFocus(FormParamCommunicationServer->Handle);
         Screen->Cursor = crDefault;
         return;
      }else
         Child = new TFormParamCommunicationServer(Application, Name, acc);
    	break;
   case 33:  // задание часов максимума нагрузки
      Child = new TFormEditTimeMaxLoad(Application, Name, acc);
    	break;
   case 40:  // Ввод спецификации  предприятия   +
      if(FormIntrpriseReneme){
         ::SetFocus(FormIntrpriseReneme->Handle);
         Screen->Cursor = crDefault;
         return;
      }else
         Child = new TFormIntrpriseReneme(Application, Name, acc);
    	break;
   case 46:  // Настройка присоединений
      Child = new TFormEditFiders(Application, Name, acc); //, Message.LParam
      break;
   case 47:  // Настройка счетчиков
      Child = new TFormIntrodactPulsCount(Application, Name, acc);
      break;
   case 48:  // Замена счетчиков
      Child = new TFormChangeCounters(Application, Name, acc);
      break;
   case 49:  // Редактирование трансформаторов
      Child = new TTransformersForm(Application, Name, acc);
      break;
   case 51:  // Настройка  форм
        //22.08.2019 UNKEY VERSION COMMENT
      /*if(dmMain->LicType||GrdGetPermission(CHK_LIC_TASK,CHK_LIC_TASK_MONITOR)>0)*/
        //22.08.2019 UNKEY VERSION COMMENT
        Child = new TFormEditFormList(Application, Name, acc);
      break;
   case 60:  // Тарифные зоны и типы дней
      Child = new TFormEditRates(Application, Name, acc);
      break;
   case 71: // настройка СОМ портов   +
      Child = new TFormEditCOMportList(Application, Name, acc);
      break;
   case 72: // 6.9 Переключение ОВ   +
      Child = new TFormSwitchOV(Application, Name, acc);
      break;
   case 73: // Учет электроэнергии по дублирующим счетчикам
      Child = new TfmDuplicateCnt(Application, Name, acc);
      break;
   case 76: // Редактор макетови Added by Kalak Sergey
      Child = new TEditMaketForm(Application, Name, acc);
      break;
   case 654:// Просомтр макетови
        //22.08.2019 UNKEY VERSION COMMENT
      /*if(dmMain->LicType||GrdGetPermission(CHK_LIC_TASK,CHK_LIC_TASK_MAKCREATE)>0)*/
        //END COMMENT
        Child = new TfmMaketArm(Application, Name, acc);
      break;
   case 605: // Ввод начальных показаний
     //22.08.2019 UNKEY VERSION COMMENT
      /*if(dmMain->LicType||GrdGetPermission(CHK_LIC_TASK,CHK_LIC_TASK_MANUAL)>0)*/{
        Child = new TFormVITInputExcel(Application,Name, 13,0, acc);
        Child->HelpContext = 515;
      }
      break;
   case 606: // Процедуры для фоновых процессов
      Child = new TfmDeportProcs(Application, Name, acc);
      break;
   case 200: // Ввод показаний по тарифам в BILL           +
        //22.08.2019 UNKEY VERSION COMMENT
      /*if(dmMain->LicType||GrdGetPermission(CHK_LIC_TASK,CHK_LIC_TASK_MANUAL)>0)*/
        //END COMMENT
        Child = new TFormVITInput(Application, Name, acc);
      break;
   case 201: // Ввод колличества энергии по тарифам в BILL  +
   //22.08.2019 UNKEY VERSION COMMENT
      /*if(dmMain->LicType||GrdGetPermission(CHK_LIC_TASK,CHK_LIC_TASK_MANUAL)>0)*/
      //END COMMENT
        Child = new TFormVITInputDelta(Application, Name, acc);
      break;
 /*  case 502: // Отчеты          Add KAS
      Child = new TfmReportGroups(Application, Name, acc);
      break; */
   case 505: // План опроса     Add KAS
      Child = new TfmEditRequestPlan(Application, Name, acc);
      break;
   case 506: // План отсылки     Add KAS
           //22.08.2019 UNKEY VERSION COMMENT
      /*if(dmMain->LicType||GrdGetPermission(CHK_LIC_TASK,CHK_LIC_TASK_MAKSEND)>0)*/
      //END COMMENT
        Child = new TfmEditDeportationPlan(Application, Name, acc);
       break;
 //  case 507:// План отсылки и приема информации VNB
  //  Child = new TfmMaketSend(Application, Name, acc);
  //    break;
   case 204: // Ввод показаний в BILL          +
           //22.08.2019 UNKEY VERSION COMMENT
      /*if(dmMain->LicType||GrdGetPermission(CHK_LIC_TASK,CHK_LIC_TASK_MANUAL)>0)*/
      //END COMMENT
        Child = new TFormVITInputExcel(Application, Name, 1,0, acc);
      break;
   case 203: // Ввод кол-ва энергии в BILL  +
              //22.08.2019 UNKEY VERSION COMMENT
      /*if(dmMain->LicType||GrdGetPermission(CHK_LIC_TASK,CHK_LIC_TASK_MANUAL)>0)*/
        //END COMMENT
        Child = new TFormVITInputDeltaExcel(Application, Name, 1,0, acc);
      break;
   case 603: // Ввод кол-ва энергии  +(получасовки)
//      Child = new TFormVITInputDeltaExcel(Application,Name, 2,0,acc,true);
  //    Child->HelpContext = 514;
          //22.08.2019 UNKEY VERSION COMMENT
      /*if(dmMain->LicType||GrdGetPermission(CHK_LIC_TASK,CHK_LIC_TASK_MANUAL)>0)*/{
      //END COMMENT
        Child = new TfmManualInput(Application,Name, 13,0, acc);
//        Child->HelpContext = 515;
      }
      break;
   case 604: // Ввод показаний          +(получасовки)

      /*if(dmMain->LicType||GrdGetPermission(CHK_LIC_TASK,CHK_LIC_TASK_MANUAL)>0)*/{
        //END COMMENT
        Child = new TFormVITInputExcel(Application,Name, 2,0, acc);
        Child->HelpContext = 513;
      }
      break;
   case 608: // Ввод показаний с разбивкой на 1/2 часа пропорционально
          //22.08.2019 UNKEY VERSION COMMENT
      /*if(dmMain->LicType||GrdGetPermission(CHK_LIC_TASK,CHK_LIC_TASK_MANUAL)>0)*/
        //END COMMENT
        Child = new TfmManualInputMeter(Application,Name, 5,0, acc);
//      Child = new TFormVITInputExcel(Application, Name, 5,0, acc);
      break;
   case 609: // Ввод кол-ва энергии  + (с разноской по 1/2 часа ровный последние сутки) спец группа
   //22.08.2019 UNKEY VERSION COMMENT
      /*if(dmMain->LicType||GrdGetPermission(CHK_LIC_TASK,CHK_LIC_TASK_MANUAL)>0)*/
      //END COMMENT
        Child = new TfmConsump(Application,Name, 8,0, acc);
      break;
  case 610: // Ввод тарифов UMC
      Child = new TEditTariffForm(Application,Name, acc);
      break;
   case 611: // Ввод показаний с разбивкой на 1/2 часа пропорционально последние сутки           +
      //22.08.2019 UNKEY VERSION COMMENT
      /*if(dmMain->LicType||GrdGetPermission(CHK_LIC_TASK,CHK_LIC_TASK_MANUAL)>0)*/
      //END COMMENT
        Child = new TFormVITInputExcel(Application,Name, 6,0, acc);
      break;
   case 612: // Ввод кол-ва энергии  +  (с разноской по 1/2 часа пропорционально последние сутки)
        //22.08.2019 UNKEY VERSION COMMENT
      /*if(dmMain->LicType||GrdGetPermission(CHK_LIC_TASK,CHK_LIC_TASK_MANUAL)>0)*/
        //END COMMENT
        Child = new TFormVITInputDeltaExcel(Application,Name, 6,0, acc);
      break;
   case 614: // Ввод показаний с разбивкой на 1/2 часа ровно
             //22.08.2019 UNKEY VERSION COMMENT
      /*if(dmMain->LicType||GrdGetPermission(CHK_LIC_TASK,CHK_LIC_TASK_MANUAL)>0)*/{
        //END COMMENT
        Child = new TFormVITInputExcel(Application,Name, 7,0, acc);
        Child->HelpContext = 508;
      }
      break;
   case 615: // Ввод показаний с разбивкой на 1/2 часа ровно последние сутки           +
             //22.08.2019 UNKEY VERSION COMMENT
      /*if(dmMain->LicType||GrdGetPermission(CHK_LIC_TASK,CHK_LIC_TASK_MANUAL)>0)*/
      //END COMMENT
        Child = new TFormVITInputExcel(Application,Name, 8,0, acc);
      break;
   case 616: // Ввод кол-ва энергии  +  (с разноской по 1/2 часа пропорционально)
             //22.08.2019 UNKEY VERSION COMMENT
      /*if(dmMain->LicType||GrdGetPermission(CHK_LIC_TASK,CHK_LIC_TASK_MANUAL)>0)*/
      //END COMMENT
        Child = new TFormVITInputDeltaExcel(Application,Name, 5,0, acc);
      break;
   case 617: // Ввод кол-ва энергии  +  (с разноской по 1/2 часа ровно)
             //22.08.2019 UNKEY VERSION COMMENT
      /*if(dmMain->LicType||GrdGetPermission(CHK_LIC_TASK,CHK_LIC_TASK_MANUAL)>0)*/{
        //END COMMENT
        Child = new TFormVITInputDeltaExcel(Application,Name, 7,0, acc);
        Child->HelpContext = 512;
      }
      break;
   case 618: // Ввод кол-ва энергии  +  (с разноской по 1/2 часа ровно последние сутки)
      //22.08.2019 UNKEY VERSION COMMENT
      /*if(dmMain->LicType||GrdGetPermission(CHK_LIC_TASK,CHK_LIC_TASK_MANUAL)>0)*/
      //END COMMENT
        Child = new TFormVITInputDeltaExcel(Application,Name, 8,0, acc);
      break;
   case 619: // Импорт данных с файлов LG (Add by KSS)
      Child = new TImportDatafilesForm(Application,Name,TType(tLGFiles),acc);
      break;
   case 620: // Мониторинг опроса
       //22.08.2019 UNKEY VERSION COMMENT
      /*if(dmMain->LicType||GrdGetPermission(CHK_LIC_TASK,CHK_LIC_TASK_MONITORING)>0)*/
      //END COMMENT
        Child = new TfmRequestMonitoring(Application,Name,acc);
      break;
   case 621: // Ввод кол-ва энергии  +  (с разноской по 1/2 часа ровно)
   //22.08.2019 UNKEY VERSION COMMENT
      /*if(dmMain->LicType||GrdGetPermission(CHK_LIC_TASK,CHK_LIC_TASK_MANUAL)>0)*/{
      //END COMMENT
        Child = new TFormVITInputDeltaExcel(Application,Name, 9,0, acc);
        Child->HelpContext = 512;
      }
      break;
      //GRB ADD 18.08.2026 - вызов терминала опроса и терминала показаний из меню
   /*case 630:{
         WinExec((AnsiString("evid_terme.exe ") +dmMain->orases->ConnectString).c_str(),SW_SHOW);
   }
   break;
   case 631: {
         AnsiString conStr = AnsiString(" Us")+AnsiString("ER")+AnsiString("=")+
  dmMain->orases->Username+AnsiString(" p")+AnsiString("ass")+AnsiString("word")+AnsiString("=")+
  dmMain->orases->Password;
       WinExec(("opros_term.exe tns=" +dmMain->orases->Server +conStr).c_str(),SW_SHOW);
   }
   break; */
      //end
   case 658: // АРМ оператора приема макетов
   //22.08.2019 UNKEY VERSION COMMENT
      /*if(dmMain->LicType||GrdGetPermission(CHK_LIC_TASK,CHK_LIC_TASK_MAKRETRIVE)>0)*/
      //END COMMENT
        Child = new TfmMaketArmR(Application,Name,acc);
      break;
   case 659: // Статистика ICCP
      Child = new TStatICCPForm(Application,Name,acc);
      break;
   case 660: // Форум пользователей
      Child = new TUserForumMain(Application, Name, acc);
      break;
   case 661: // Монитор ICCP
      Child = new TMonitorICCPForm(Application,Name,acc);
      break;
   case 664:// Ввод стартовых показаний счетчика по отношению к "свистку"
      Child = new TfmInputStartMeters (Application,Name,acc);
      break;
   case 1000:  //    настройка групп верификации
      Child = new TFormEditGropsList(Application, Name, acc);
      ((TFormEditGropsList*)Child)->Panel7->Caption = Reconst_smes62_1;
      ((TFormEditGropsList*)Child)->Label5->Caption = Reconst_smes62_2;
      ((TFormEditGropsList*)Child)->Panel19->Visible = false;
      ((TFormEditGropsList*)Child)->grMain->Visible = false;
      ((TFormEditGropsList*)Child)->DBNavigator1->Visible = false;
      ((TFormEditGropsList*)Child)->Label3->Visible = false;
      ((TFormEditGropsList*)Child)->edAvBr->Visible = false;
      ((TFormEditGropsList*)Child)->Label4->Visible = false;
      ((TFormEditGropsList*)Child)->edTehBr->Visible = false;
      ((TFormEditGropsList*)Child)->cbSum->Visible = false;
    	break;
//===== 10.04.2006 DarLocK Started
      //===== Коммутация
      case 652:
        Child = new TViewShemForm(Application, Name, acc, vsCommutation);
        break;
      //===== Просмотр потерь
      case 653:
        Child = new TViewShemForm(Application, Name, acc, vsLoss);
        break;
//===== 10.04.2006 DarLocK Finished
       case 1001: //6.10. Редактирование телесигналов  
        Child = new TFormTeleControlSignals(Application, Name, acc);
        break;

   default:
    Screen->Cursor = crDefault;
      return;
   }
   if(Child)
     Child->TaskId=Id;
   }catch(Exception&e){
      Application->ShowException(&e);
   }
   Screen->Cursor = crDefault;
}
//---------------------------------------------------------------------------

void __fastcall TTaskMenuForm::btnCloseClick(TObject *Sender)
{
   Close();
}
//---------------------------------------------------------------------------

void __fastcall TTaskMenuForm::FormShow(TObject *Sender)
{
   tvTasks->Focused();
}
//---------------------------------------------------------------------------

void __fastcall TTaskMenuForm::FormClose(TObject *Sender, TCloseAction &Action)
{
   Action = caFree;
}
//---------------------------------------------------------------------------

void __fastcall TTaskMenuForm::tvTasksChange(TObject *Sender,
      TTreeNode *Node)
{
      if(Node && Node->getFirstChild() && !Node->getFirstChild()->Data){
        Node->DeleteChildren();
        ReadTreeNode(Node);
      }
      TreeView1->Items->Clear();
      TTreeNode *node;
      for(int i = 0; i < Node->Count; i++){
        node = TreeView1->Items->AddChildObject(NULL, Node->Item[i]->Text, Node->Item[i]->Data);
        node->ImageIndex = 1;
        node->SelectedIndex = 1;
      }
}
//---------------------------------------------------------------------------

void __fastcall TTaskMenuForm::tvKeyDown(TObject *Sender, WORD &Key,
      TShiftState Shift)
{
    TTreeView *tv = dynamic_cast<TTreeView*>(Sender);
    if(!tv)
        return;
    switch(Key)
    {
        case VK_RETURN:
            tvTasksDblClick(tv);
            break;
        case VK_LEFT:
            if(tv == TreeView1)
                tvTasks->SetFocus();
            break;
        case VK_RIGHT:
            if(tv == tvTasks)
                TreeView1->SetFocus();
            break;
    };
}
//---------------------------------------------------------------------------

