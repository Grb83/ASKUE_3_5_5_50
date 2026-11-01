//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "InteriorModus.h"
#include "Monitor.h"
#include "SupperMain.h"
#include "Saa_SelectForm.h"
#include "Saa_SelectGroup.h"
#include "Saa_SelectGroupProc.h"
//#include "EditFiders.h"
//#include "EditGroupsList.h"
#include "Main.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma link "Open_OCX"
#pragma link "sdePanelXControl_OCX"
#pragma package(smart_init)
//---------------------------------------------------------------------------
#define MAX_POINTS 500
#define PROGRESS_STEP 10
#define ACTIVEX_VER_FAILED "\nПроверьте версию установленного компонента ActiveX для схемы."
//---------------------------------------------------------------------------
//typedef TArrow Sdepanelxcontrol_tlb::TIndicatorArrowDirection;
// Для запуска монитора по выделенному объекту
extern HANDLE UpdateMonitors;
//---------------------------------------------------------------------------

__fastcall TModusInterior::TModusInterior(TComponent* Owner,TSplitterForm *aSP,
	TFormDescr *aFD,Classes::TNotifyEvent OnProgr, eObjectType objType)
    : TInterior(Owner,aSP,aFD,OnProgr),Timer(NULL),HartePanel(NULL),ModusPanel(NULL)
{
    InitializeCriticalSection(&timerUpdate);

    Timer = new TTimer(Owner);
    Timer->Enabled = false;
    Timer->Interval = 1;
    Timer->OnTimer = OnTime;

    TPopupMenu*ppmu = (dynamic_cast<TForm*>(Owner))->PopupMenu;
    onShowTools = new TMenuItem(Owner);
    onShowTools->Caption = Reconst_smes122_2;
    onShowTools->OnClick = ShowToolsClick;
    onShowStatus = new TMenuItem(Owner);
    onShowStatus->Caption = Reconst_smes122_3;
    onShowStatus->OnClick = ShowStatusClick;
    onMonitoring = new TMenuItem(Owner);
    onMonitoring->Caption = Reconst_smes122_4;
    onMonitoring->OnClick = MonSelectClick;
    onMonitoring->Insert(0,new TMenuItem(Owner));
    if(ppmu){
        for(int i=0; i<ppmu->Items->Count; i++)
            if(ppmu->Items->Items[i]->Name=="ChartFXLines" ||
                ppmu->Items->Items[i]->Name=="ChartFXColumns" ||
                ppmu->Items->Items[i]->Name=="ByGroup" ||
                ppmu->Items->Items[i]->Name=="ByProfile")
            {
                ppmu->Items->Items[i]->Enabled = false;
                //ppmu->Items->Items[i]->Visible = false;
            }
        ppmu->Items->Insert(0,onMonitoring);
        ppmu->Items->Insert(0,onShowStatus);
        ppmu->Items->Insert(0,onShowTools);
        ppmu->AutoPopup = false;
        ppmu->OnPopup = NULL;
    }

    try{
        switch(objType){
        case otDefault:
            HartePanel = new TfmShemEdit(Owner);
            HartePanel->Visible = false;
            break;
        case otModusActiveXeme:
            ModusPanel = new TsdePanelX(Owner);
            ModusPanel->Visible = false;
            break;
        }
        formDescr();
        if(HartePanel){
            HartePanel->Parent = dynamic_cast<TWinControl*>(Owner);
            HartePanel->Align = alClient;
            HartePanel->OnDocDblClick = DocDblClick;
            HartePanel->OnDocRightClick = DocRightClick;
            HartePanel->PopupMenu = ppmu;
            HartePanel->Visible = true;
            //HartePanel->FitToWindow();
        }else if(ModusPanel){
            ModusPanel->Parent = dynamic_cast<TWinControl*>(Owner);
            ModusPanel->Align = alClient;
            ModusPanel->OnDocDblClick = DocDblClick;
            ModusPanel->OnDocRightClick = sdeDocRightClick;
            ModusPanel->PopupMenu = ppmu;
            ModusPanel->Visible = true;
            ModusPanel->FitToWindow();
        }
        selectData(dmMain->oqCursor2);
    }catch(Exception&e){
        Application->ShowException(&Exception(e.Message+ACTIVEX_VER_FAILED));
        PostMessage(SupperMainForm->ActiveMDIChild->Handle, WM_CLOSE, 0,0);
    }
}
//---------------------------------------------------------------------------

__fastcall TModusInterior::~TModusInterior()
{
    DeleteCriticalSection(&timerUpdate);
    TPopupMenu*ppmu = (dynamic_cast<TForm*>(Owner))->PopupMenu;
    if(onShowStatus){
        ppmu->Items->Delete(onShowStatus->MenuIndex);
        delete onShowStatus;
    }
    if(onShowTools){
        ppmu->Items->Remove(onShowTools);
        delete onShowTools;
    }
    if(onMonitoring){
        ppmu->Items->Remove(onMonitoring);
        delete onMonitoring;
    }
    if(HartePanel) delete HartePanel;
    if(ModusPanel) delete ModusPanel;
}
//---------------------------------------------------------------------------
void __fastcall TModusInterior::selectData( TOraQuery *qwInter )
{
    double value;
    long color, arrow;
    AnsiString switch_val, tmp;
    long id, out_val=0;
    int step = ColumnsCaption->Count/PROGRESS_STEP;
    try{
      OnProgressBarStepBy(this);
      qwInter->Params->Clear();
      qwInter->SQL->Text="begin "+SchemeName+"diagram_pg.get_modusinfo_byid(:par1,NULL, :par2, :par3, :par4, :par5, :par6); end;";
      qwInter->ParamByName("par1")->DataType=ftString;
      qwInter->ParamByName("par1")->Size=255;
      qwInter->ParamByName("par2")->ParamType=ptOutput;
      qwInter->ParamByName("par2")->DataType=ftFloat;
      qwInter->ParamByName("par3")->ParamType=ptOutput;
      qwInter->ParamByName("par3")->DataType=ftInteger;
      qwInter->ParamByName("par4")->ParamType=ptOutput;
      qwInter->ParamByName("par4")->DataType=ftInteger;
      qwInter->ParamByName("par5")->ParamType=ptOutput;
      qwInter->ParamByName("par5")->DataType=ftInteger;
      qwInter->ParamByName("par6")->ParamType=ptOutput;
      qwInter->ParamByName("par6")->DataType=ftString;
      for(int i=0; i<ColumnsCaption->Count; i++){
        AnsiString s=ColumnsCaption->Strings[i];
        s=s.SubString(1,s.Pos(" ")-1);
        qwInter->ParamByName("par1")->AsString=s;
        qwInter->ParamByName("par2")->Clear();
        qwInter->ParamByName("par3")->Clear();
        qwInter->ParamByName("par4")->Clear();
        qwInter->ParamByName("par5")->Clear();
        qwInter->ParamByName("par6")->Clear();
        qwInter->Execute();
        value=qwInter->ParamByName("par2")->AsFloat;
        arrow=qwInter->ParamByName("par3")->AsInteger;
        color=qwInter->ParamByName("par4")->AsInteger;
        switch_val=qwInter->ParamByName("par6")->AsString;
        qwInter->Close();
        if(HartePanel){
          out_val = 0;
          HartePanel->IsTextIndicator(WideString(s), &out_val);
          if (out_val == 1)
            HartePanel->SetDataToLabel(WideString(s), WideString(switch_val), color);
          else
            HartePanel->SetIndicatorData(WideString(s), value, (Open_tlb::TIndicatorArrowDirection)arrow, color);
            //HartePanel->SetIndicatorData(WideString(s), value, (Open_tlb::TIndicatorArrowDirection)arrow, color,qwInter->ParamByName("par5")->AsInteger);  //Это для даты
        }else
          if(ModusPanel)
            ModusPanel->SetIndicatorData(WideString(s), value, arrow, color);
        if (step!=0 && i%step == 0) OnProgressBarStepBy(this);
      }
      OnProgressBarStepBy(NULL);
    }catch(Exception&e){
        OnProgressBarStepBy(NULL);
        Application->MessageBox(AnsiString(Reconst_smes122_5+e.Message).c_str(),Reconst_smes122_6.c_str(),MB_OK|MB_ICONSTOP);
    }
}
//---------------------------------------------------------------------------

void __fastcall TModusInterior::formDescr(void)
{
    long count=0;
    if(HartePanel){
        HartePanel->FileName = ExFileFullName;
        count = HartePanel->CountID;
    }else if(ModusPanel){
        ModusPanel->FileName = ExFileFullName;
        count = ModusPanel->CountID;
    }
    ColumnsCaption->Clear();
    for(long i=0; i<count; i++)
    {
        WideString n;
        if(HartePanel) HartePanel->GetID(i,&n);
        else if(ModusPanel) n = ModusPanel->IDs[i];
        AnsiString tmp = n;
        ColumnsCaption->Add(tmp+" ");
    }
    ColumnsCaption->Capacity = ColumnsCaption->Count;
}
//---------------------------------------------------------------------------

void __fastcall TModusInterior::ShowStatusClick(TObject *Sender)
{
    try{
        TMenuItem*mi = dynamic_cast<TMenuItem*>(Sender);
        if(!mi) return;
        mi->Checked = !mi->Checked;
        if(HartePanel) HartePanel->StatusVisible = mi->Checked;
        else if(ModusPanel) ModusPanel->StatusVisible = mi->Checked;
    }catch(Exception&e){
        e.Message += ACTIVEX_VER_FAILED;
        throw e;
    }
}
//---------------------------------------------------------------------------

void __fastcall TModusInterior::ShowToolsClick(TObject *Sender)
{
    try{
        TMenuItem*mi = dynamic_cast<TMenuItem*>(Sender);
        if(!mi) return;
        mi->Checked = !mi->Checked;
        if(HartePanel) HartePanel->ToolVisible = mi->Checked;
        else if(ModusPanel) ModusPanel->ToolVisible = mi->Checked;
    }catch(Exception&e){
        e.Message += ACTIVEX_VER_FAILED;
        throw e;
    }
}
//---------------------------------------------------------------------------

void __fastcall TModusInterior::DocDblClick(TObject*Sender,BSTR ID)
{
    try{
        // Add your code here
    }catch(Exception&e){
        e.Message += ACTIVEX_VER_FAILED;
        throw e;
    }
}
//---------------------------------------------------------------------------

void __fastcall TModusInterior::DocRightClick(TObject*Sender,BSTR ID,int Shift,int X,int Y)
{
    sdeDocRightClick(Sender,ID,Shift,X,Y);
}
//---------------------------------------------------------------------------

void __fastcall TModusInterior::MonSelectClick(TObject *Sender)
{

  TMenuItem*mi;
  mi = dynamic_cast<TMenuItem*>(Sender);
  FORMS*fms = (FORMS*)mi->Tag;
  if(fms && fms->tmplCode!=0){
    dmMain->oqInterCursor->Params->Clear();
    dmMain->oqInterCursor->SQL->Text="begin "+SchemeName+"interior_pg.ModusInterior_MonSelectClick_p(:par1,:par2,:par3,:par4,:par5,:par6,:par7); end;";
    dmMain->oqInterCursor->ParamByName("par7")->ParamType=ptOutput;
    dmMain->oqInterCursor->ParamByName("par7")->DataType=ftCursor;

    dmMain->oqInterCursor->ParamByName("par2")->AsInteger=currId;
    dmMain->oqInterCursor->ParamByName("par1")->AsInteger=fd->StepProfile;
    dmMain->oqInterCursor->ParamByName("par3")->AsInteger=isPoint;
    dmMain->oqInterCursor->ParamByName("par4")->AsInteger=fd->GetPeriodForYearStart(fd->DateTime);
    dmMain->oqInterCursor->ParamByName("par5")->AsInteger=fd->GetPeriodForYearFinish(fd->DateTime);
    dmMain->oqInterCursor->ParamByName("par6")->AsInteger=fd->GetPeriod(fd->DateTime);

    dmMain->oqInterCursor->Execute();
    strcpy(currName,dmMain->oqInterCursor->FieldByName("name")->AsString.c_str());
    dmMain->oqInterCursor->Close();

    ManForm = new TManForm(SupperMainForm);
    ManForm->OnProgressBarStepBy=SupperMainForm->ProgressBarStepBy;
    TBaseMonitorForm *p=new TBaseMonitorForm(ManForm->PageCtrlSplt,ManForm->OnProgressBarStepBy);
	  ManForm->PageCtrlSplt->AddChild(p,alTop);
    TFormDescr* sfd=NULL;
    TForm* fmSelectGroupReportUniv=NULL;
    if(!ManForm->PageCtrlSplt->CurrentForm)
	    return;
    sfd = new TFormDescr;
	  if(ManForm->PageCtrlSplt->CurrentForm->GetFormDescr())
      *sfd=*(ManForm->PageCtrlSplt->CurrentForm->GetFormDescr());
        // Подготовка описания формы
    sfd->IdFormTree = fms->fid;
    sfd->CodeTemplate = fms->tmplCode;
    sfd->IdGroup = currId;
    sfd->IsPoints = isPoint;
    sfd->SummGroup = true;
    sfd->NameForm = fms->name;
    sfd->CommentForm = fms->comment;
    sfd->NameAlert = fms->alertname;
    sfd->NameGroup = currName;
    sfd->ShortNameGroup = currName;
    switch(fms->step){
      case 1:
        sfd->StepProfile = TFormDescr::stpMonth;
        break;
      case 2:
        sfd->StepProfile = TFormDescr::stpDay;
        break;
      case 3:
        sfd->StepProfile = TFormDescr::stpHour;
        break;
      case 4:
        sfd->StepProfile = TFormDescr::stpMinute;
        break;
    }
		sfd->EnableControls.Clear();
		char*ch = &fms->enablecontrols[0];
    if(*ch=='1')
		  sfd->EnableControls<<TFormDescr::ctrlMonth;
    ch++;
    if(*ch=='1')
		  sfd->EnableControls<<TFormDescr::ctrlDay;
    ch++;
    if(*ch=='1')
		  sfd->EnableControls<<TFormDescr::ctrlHour;
    ch++;
    if(*ch=='1')
		  sfd->EnableControls<<TFormDescr::ctrlMinute;
    ch++;
    if(*ch=='1')
		  sfd->EnableControls<<TFormDescr::ctrlCalendar;
    ch++;
    if(*ch=='1')
      sfd->EnableControls<<TFormDescr::ctrlGroup;
    ch++;
    if(*ch=='1')
      sfd->EnableControls<<TFormDescr::ctrlPoint;
    ch++;
    if(*ch=='1')
      sfd->indbird = true;// добавленно даля задания режима видимости панели "перечень отображаемых данных"
    else
      sfd->indbird = false;

        // Конец подготовки
    fmSelectReportForm = new TfmSelectReportForm(this,fms->fid,sfd);

    if(IsCommonRepForm(sfd->CodeTemplate))
      fmSelectGroupReportUniv = new TfmSelectGroupReportProc(this,sfd);
    else
      fmSelectGroupReportUniv = new TfmSelectGroupReport(this,sfd);
    if(EXCEL_F == sfd->CodeTemplate)
      fmSelectGroupReportUniv->ModalResult = mrOk;
    else{
      bool prContWork = TRUE;
      if(sfd->CodeTemplate == EXCEL_REP_F || sfd->CodeTemplate == EXCEL_OP_FORM){
        TManForm *FFF = dynamic_cast<TManForm*>(SupperMainForm->ActiveMDIChild);
        if(!( FFF && FFF->PageCtrlSplt->listMonitorForms->Count<2 ) ){
          Application->MessageBox(Reconst_smes122_8.c_str(),Application->Title.c_str(),MB_OK|MB_ICONSTOP);
          fmSelectGroupReportUniv->ModalResult = mrCancel;
          prContWork = FALSE;
        }
      }
      if( prContWork )
        fmSelectGroupReportUniv->ModalResult = mrOk;
    }
    if (fmSelectGroupReportUniv->ModalResult == mrOk){
            //fmSelectReportForm->fd->CodeTemplate=1;
            // перед любым обновлением мониторов необходимо инициализировать кр. секцию UpdateMonitors
      while(WaitForSingleObject(UpdateMonitors,0)!=WAIT_OBJECT_0){
        Application->ProcessMessages();// если не удалось иниц-ть. CS то обновить экранные формы...
        Sleep(0);// переключить управление на другой поток, коьт занял CS
      }
            // add by KSS
      PostMessage(ManForm->PageCtrlSplt->CurrentForm->Handle,WM_REFRESHFORM,0,(LPARAM)sfd);
    }
    delete fmSelectGroupReportUniv;
    delete fmSelectReportForm;
    Screen->Cursor = crDefault;
  }else{
    if(isPoint)
      TMainForm::createSubMenu(mi);
    else{
      if(mi==onMonitoring){
        if(!fms)
          fms = new FORMS;
        ZeroMemory(fms, sizeof(FORMS));
        fms->gid = currId;
        mi->Tag = (int)fms;
      }
    }
  }
}
//---------------------------------------------------------------------------

void __fastcall TModusInterior::OnTime(TObject *Sender)
{
    EnterCriticalSection(&timerUpdate);
    Timer->Enabled = false;
    selectData(dmMain->oqCursor2);
    LeaveCriticalSection(&timerUpdate);
}
//---------------------------------------------------------------------------

void __fastcall TModusInterior::refreshData(int Table,  TOraQuery *qwInter )
{
	if(!Timer->Enabled && Table==TABLE_CURR_POWER)
    {
        EnterCriticalSection(&timerUpdate);
        Timer->Enabled = true;
        LeaveCriticalSection(&timerUpdate);
    }
}
//---------------------------------------------------------------------------

void __fastcall TModusInterior::PrintRep()
{
    try{
        if(HartePanel) HartePanel->Print();
        else if(ModusPanel) ModusPanel->Print();
    }catch(Exception&e){
        e.Message += ACTIVEX_VER_FAILED;
        throw e;
    }
}
//---------------------------------------------------------------------------

void __fastcall TModusInterior::sdeDocRightClick(TObject*Sender,BSTR ID,long Shift,long X,long Y)
{
    int i;
    AnsiString s;

    try{
        for(i=0; i<ColumnsCaption->Count; i++)
        {
            s = ColumnsCaption->Strings[i];
            if(s.SubString(1,s.Pos(' ')-1)==ID)
                break;
        }
        if(ID==NULL || i==ColumnsCaption->Count)
            onMonitoring->Enabled = false;
        else
        {
            onMonitoring->Enabled = true;
            isPoint = s.SubString(1, s.Pos('.')-1)=="MID";
            s = s.SubString(s.Pos('.')+1,s.Pos(' ')-s.Pos('.'));
            AnsiString tmp = s.SubString(1,s.Pos('.')-1);
            if(tmp.Length()>0)
                currId = tmp.ToInt();
        }
        TPoint p;
        if(HartePanel){
            p = HartePanel->ClientToScreen(TPoint(X,Y));
            HartePanel->PopupMenu->Popup(p.x, p.y);
        }else if(ModusPanel){
            // координаты возвращаются в Screen системе и без учёта рамки... 
            ModusPanel->PopupMenu->Popup(X+6, Y+7);
        }
    }catch(Exception&e){
        e.Message += ACTIVEX_VER_FAILED;
        throw e;
    }
}
//---------------------------------------------------------------------------

