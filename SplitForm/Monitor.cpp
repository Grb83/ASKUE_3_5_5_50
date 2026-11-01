//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#include "SplitForm.h"
#include "Interior.h"
#include "Saa_SelectForm.h"
#include "SupperMain.h"
#include "unDataMod.h"
#include "SetupMonitors.h"
#include "SaveMonitorAs.h"
#include "InteriorEx.h"
#include "InteriorExRep.h" // Add KAS 15.03.2001
#include "InteriorExOpForm.h" // Add KAS 27.08.2001
#include "Saa_SelectGroup.h"
#include "Saa_SelectGroupProc.h"
#include "Monitor.h"
#include "Reconst.hpp"

//---------------------------------------------------------------------------
#pragma link "DBAccess"
#pragma link "MemDS"
#pragma link "Ora"
#pragma resource "*.dfm"
TManForm *ManForm;
extern HANDLE UpdateMonitors;
int TManForm::NumMonitor=1;
//---------------------------------------------------------------------------
__fastcall TManForm::TManForm(TComponent* Owner)
	: TForm(Owner),PageCtrlSplt(NULL)
{
   SupperMainForm->sbChangePeriod->Enabled=false;
   Monitor_Id = nParent = -1;
}
//---------------------------------------------------------------------------
//===== 20.05.2005 Frizyuk A.M. Start
void __fastcall TManForm::MonitorMenuEnabled()
{
  int rCode = dmMain->GetTaskRights(UsCon.Role_Id, 81);
  if (rCode == TASK_RIGHTS_ERROR)
  { Application->MessageBox(Application->Title.c_str(),Reconst_smes130_1.c_str(),MB_OK | MB_ICONERROR);
  }
  //===== Установка невидимости меню, вслучае запрета
  SaveMonitor->Visible      = rCode != TASK_RIGHTS_DISABLE;
  SaveMonitorAs->Visible    = rCode != TASK_RIGHTS_DISABLE;
  EditMonitorList->Visible  = rCode != TASK_RIGHTS_DISABLE;
  //===== Установка разрешения меню, вслучае наличия прав доступа
  SaveMonitor->Enabled      = rCode == TASK_RIGHTS_WRITE;
  SaveMonitorAs->Enabled    = rCode == TASK_RIGHTS_WRITE;
  EditMonitorList->Enabled  = rCode == TASK_RIGHTS_WRITE;
}
//---------------------------------------------------------------------------
void __fastcall TManForm::FormCreate(TObject *Sender)
{
	Caption=Caption+Reconst_smes130_2;
	PageCtrlSplt=new TPageCtrlSplt(this);
	PageCtrlSplt->Align=alClient;
	PageCtrlSplt->Parent=this;
	PageCtrlSplt->TabStop=false;
	PageCtrlSplt->Init();
  MonitorMenuEnabled();
  if (!SupperMainForm->N21->Enabled)
    MenuItemSetupMonitor->Enabled = false;
}
//---------------------------------------------------------------------------
void __fastcall TManForm::WMMonitorInit(TMessage & Message)
{
	AddRight->Click();
}
//---------------------------------------------------------------------------
void __fastcall TManForm::WMRefreshData(TMessage & Message)
{
	PostMessage(PageCtrlSplt->Handle,WM_REFRESHDATA,Message.WParam,Message.LParam);
}
//---------------------------------------------------------------------------
void __fastcall TManForm::AddPanelClick(TObject *Sender)
{
	static TAlign a[]={alLeft,alTop,alRight,alBottom};
	TBaseMonitorForm *p=new TBaseMonitorForm(PageCtrlSplt,OnProgressBarStepBy);
	PageCtrlSplt->AddChild(p,a[((TButton*)Sender)->Tag]);
   BitBtnFormClick(BitBtnForm);//SAA 15.11.2002
}
//---------------------------------------------------------------------------
void __fastcall TManForm::DeletePanelClick(TObject *Sender)
{
	PageCtrlSplt->RemoveChild();
}
//---------------------------------------------------------------------------
void __fastcall TManForm::N12Click(TObject *Sender)
{
	PageCtrlSplt->MaximizeChild();
}
//---------------------------------------------------------------------------
void __fastcall TManForm::N13Click(TObject *Sender)
{
	PageCtrlSplt->RestoreChild();
}
//---------------------------------------------------------------------------
void __fastcall TManForm::N1Click(TObject *Sender)
{
	TFormDescr* sfd=new TFormDescr;
	if( PageCtrlSplt->CurrentForm->GetFormDescr() )
		*sfd=*(PageCtrlSplt->CurrentForm->GetFormDescr());
	sfd->NameGroup=Reconst_smes130_7;
	sfd->CommentForm=Reconst_smes130_8;
	sfd->IdFormTree=101;
	sfd->CodeTemplate=AEBO_REBO_F;
	sfd->IdGroup=220;
	sfd->ShortNameGroup=Reconst_smes130_9;
	sfd->DateTime=TDateTime(1998,2,13);
	sfd->EnableControls<<TFormDescr::ctrlMonth
		<<TFormDescr::ctrlDay
		<<TFormDescr::ctrlHour
		<<TFormDescr::ctrlCalendar
		<<TFormDescr::ctrlGroup;
	sfd->StepProfile=TFormDescr::stpHour;
   while(WaitForSingleObject(UpdateMonitors,0)!=WAIT_OBJECT_0)
   {
      Application->ProcessMessages();// если не удалось иниц-ть. CS то обновить экранные формы...
      Sleep(0);// переключить управление на другой поток, коьт занял CS
   }
   // add by KSS
	PostMessage(PageCtrlSplt->CurrentForm->Handle,WM_REFRESHFORM,0,(LPARAM)sfd);
}
//---------------------------------------------------------------------------
void __fastcall TManForm::N2Click(TObject *Sender)
{
	TFormDescr* sfd=new TFormDescr;
	if( PageCtrlSplt->CurrentForm->GetFormDescr() )
		*sfd=*(PageCtrlSplt->CurrentForm->GetFormDescr());
	sfd->SummGroup=!sfd->SummGroup;
   // перед любым обновлением мониторов необходимо инициализировать кр. секцию UpdateMonitors
   while(WaitForSingleObject(UpdateMonitors,0)!=WAIT_OBJECT_0)
   {
      Application->ProcessMessages();// если не удалось иниц-ть. CS то обновить экранные формы...
      Sleep(0);// переключить управление на другой поток, коьт занял CS
   }
	PostMessage(PageCtrlSplt->CurrentForm->Handle,WM_REFRESHFORM,0,(LPARAM)sfd);
}
//---------------------------------------------------------------------------
void __fastcall TManForm::RotateClick(TObject *Sender)
{
	PostMessage(PageCtrlSplt->CurrentForm->Handle,WM_SETSPLITORIENT,0,0);
}
//---------------------------------------------------------------------------
void __fastcall TManForm::N5Click(TObject *Sender)
{
	TFileStream *istream=new TFileStream("SaveSplitter.bin",fmOpenRead|fmShareDenyWrite);
	PageCtrlSplt->Load( istream,OnProgressBarStepBy);
	delete istream;
}
//---------------------------------------------------------------------------
void __fastcall TManForm::BitBtnCloseClick(TObject *Sender)
{
        SupperMainForm->sbChangePeriod->Enabled=true;
        SendMessage(this->Handle, WM_CLOSE, 0, 0);
//	Close();
}
//---------------------------------------------------------------------------
void __fastcall TManForm::BitBtnFormClick(TObject *Sender)
{
    bool again=true;
    long Fid;
    TFormDescr* sfd=NULL, *fd = PageCtrlSplt->CurrentForm->GetFormDescr();
    TForm* fmSelectGroupReportUniv=NULL;

    if(!PageCtrlSplt->CurrentForm)
	    return;
    if(false&&!UsCon.Admin){
        SupperMainForm->N12Click(this);
    	return;
    }
    hCursor=::SetCursor(LoadCursor(NULL,IDC_WAIT));

    sfd = new TFormDescr;
	if(fd)
	    *sfd=*fd;
    if(sfd->CodeTemplate!=0)
        Fid=sfd->IdFormTree;
    else
   	    Fid=-1;
    ::SetCursor(hCursor);
    fmSelectReportForm = new TfmSelectReportForm(this,Fid,sfd);
    while(again){
        again = false;
        if(fmSelectReportForm->ShowModal() == mrOk )
        {
            if ( IsCommonRepForm( sfd->CodeTemplate ) )
                fmSelectGroupReportUniv = new TfmSelectGroupReportProc(this,sfd);
            else
                fmSelectGroupReportUniv = new TfmSelectGroupReport(this,sfd);
            //GRB ADD 07.02.2019 - пункт в меню для многотаблиичного отчёта для Житомира тут делаем видимым, а обработчик на onClick для него ставим в unInteriorIni.cpp там же для этого инклюдим Monitir.h. Хардкод -11й в списке меню File
            if (PL_SQL_MANY_TABLE == sfd->CodeTemplate){
                //20.09.2021 GRB ADD - споймал исключение ManForm == NULL
                if (ManForm!=NULL){

                ManForm->BitBtnPrevios->Enabled = false;
                ManForm->BitBtnNext->Enabled = false;
                //BitBtnPrevios->Visible = false;
                //BitBtnNext->Visible = false;
                for (int i=0; i < ManForm->MainMenu1->Items->Items[0]->Count; i++)
                        if (ManForm->MainMenu1->Items->Items[0]->Items[i]->Name == "SaveMultyTableToFile"){
                                ManForm->MainMenu1->Items->Items[0]->Items[i]->Visible = true;
                                ManForm->MainMenu1->Items->Items[0]->Items[i]->OnClick = SaveMultyTableToFileClick;

                                ManForm->MainMenu1->Items->Items[0]->Items[i]->Enabled = true;
                                }
                }
            }else{
                //20.09.2021 GRB ADD - споймал исключение ManForm == NULL
                if (ManForm!=NULL){
                ////20.09.2021 GRB ADD поставил проверку
                for (int i=0; i < ManForm->MainMenu1->Items->Items[0]->Count; i++)
                        if (ManForm->MainMenu1->Items->Items[0]->Items[i]->Name == "SaveMultyTableToFile"){
                                ManForm->MainMenu1->Items->Items[0]->Items[i]->Visible = false;
                                ManForm->MainMenu1->Items->Items[0]->Items[i]->Enabled = false;
                                }
                }
            }
            //END GRB ADD
            if( EXCEL_F == sfd->CodeTemplate )
                fmSelectGroupReportUniv->ModalResult = mrOk;
            else
            {
                bool prContWork = TRUE;
                if( sfd->CodeTemplate == EXCEL_REP_F ||
                    sfd->CodeTemplate == EXCEL_OP_FORM ||
                    sfd->CodeTemplate == SCHEMA_OP_FORM)
                {
                    TManForm *FFF = dynamic_cast<TManForm*>(SupperMainForm->ActiveMDIChild);
                    if(!( FFF && FFF->PageCtrlSplt->listMonitorForms->Count<2 ) )
                    {
                        Application->MessageBox(Reconst_smes130_3.c_str(),
                            Application->Title.c_str(),MB_OK|MB_ICONSTOP);
                        fmSelectGroupReportUniv->ModalResult = mrCancel;
                        prContWork = FALSE;
                    }
                }
                if( prContWork )
                    fmSelectGroupReportUniv->ShowModal();
            }
            if (fmSelectGroupReportUniv->ModalResult == mrOk)
            {
                //fmSelectReportForm->fd->CodeTemplate=1;
                // перед любым обновлением мониторов необходимо инициализировать кр. секцию UpdateMonitors
                while(WaitForSingleObject(UpdateMonitors,0)!=WAIT_OBJECT_0)
                {
                    Application->ProcessMessages();// если не удалось иниц-ть. CS то обновить экранные формы...
                    Sleep(0);// переключить управление на другой поток, коьт занял CS
                }
                PostMessage(PageCtrlSplt->CurrentForm->Handle,WM_REFRESHFORM,0,(LPARAM)new TFormDescr(*sfd));
            }else{
                // Повтор данного кода выбора формы
                again = true;
            }
        }
        else
        {
            TBaseMonitorForm* MF = (TBaseMonitorForm*)PageCtrlSplt->CurrentForm;
            if(fd->CodeTemplate==EXCEL_REP_F)
            {
                TInteriorExRep * TIFx = (TInteriorExRep*) MF->Interior;
                TIFx->DoVerb();
            }else if(fd->CodeTemplate==EXCEL_OP_FORM)
            {
                TInteriorExOpForm * TIFx = (TInteriorExOpForm*) MF->Interior;
                TIFx->DoVerb();
            }
        }
    }
    delete fmSelectGroupReportUniv;
    delete fmSelectReportForm;
    delete sfd;
}
//---------------------------------------------------------------------------
void __fastcall TManForm::BitBtnParamClick(TObject *Sender)
{
    if(!PageCtrlSplt->CurrentForm)
        return;
    hCursor=::SetCursor(LoadCursor(NULL,IDC_WAIT));

    TFormDescr* sfd=new TFormDescr;
	if( PageCtrlSplt->CurrentForm->GetFormDescr() )
	    *sfd=*(PageCtrlSplt->CurrentForm->GetFormDescr());

    if( sfd->CodeTemplate!=0 )
	{
        TForm* fmSelectGroupReportUniv;
        if ( IsCommonRepForm( sfd->CodeTemplate ) )
            fmSelectGroupReportUniv = new TfmSelectGroupReportProc(this,sfd);
        else
            fmSelectGroupReportUniv = new TfmSelectGroupReport(this,sfd);//обявление указателя окна настройки отображения
        ::SetCursor(hCursor);

        if  (sfd->CodeTemplate != 1200)
            fmSelectGroupReportUniv->ShowModal();//запускаетса форма в которой находитса компонент "птичник"
        if( fmSelectGroupReportUniv->ModalResult==mrOk ){
            // перед любым обновлением мониторов необходимо инициализировать кр. секцию UpdateMonitors
            while(WaitForSingleObject(UpdateMonitors,0)!=WAIT_OBJECT_0)
            {
                Application->ProcessMessages();// если не удалось иниц-ть. CS то обновить экранные формы...
                Sleep(0);// переключить управление на другой поток, коьт занял CS
            }
            PostMessage(PageCtrlSplt->CurrentForm->Handle,WM_REFRESHFORM,0,(LPARAM)sfd);
        }
        else
        {
            TBaseMonitorForm* MF = (TBaseMonitorForm*)PageCtrlSplt->CurrentForm;
            if(sfd->CodeTemplate==EXCEL_REP_F)
            {
                TInteriorExRep * TIFx = (TInteriorExRep*) MF->Interior;
                TIFx->DoVerb();
            }else if(sfd->CodeTemplate==EXCEL_OP_FORM)
            {
                TInteriorExOpForm * TIFx = (TInteriorExOpForm*) MF->Interior;
                TIFx->DoVerb();
            }
    	    delete sfd;
        }
	    delete fmSelectGroupReportUniv;
    }
    else
  	    delete sfd;
}
//---------------------------------------------------------------------------
void __fastcall TManForm::FormClose(TObject *Sender, TCloseAction &Action)
{
	ManForm=NULL;
	Action=caFree;
}
//---------------------------------------------------------------------------
void __fastcall TManForm::FileClick(TObject *Sender)
{
  SupperMainForm->N1->Click();
  OpenEdit->Enabled       = SupperMainForm->N11->Enabled;
  CreateMonitor->Enabled  = SupperMainForm->N13->Enabled;
  if (Caption == Reconst_smes130_4)
    SaveMonitor->Enabled  = false;
  else
  { int rCode = dmMain->GetTaskRights(UsCon.Role_Id, 81);
    SaveMonitor->Visible  = rCode != TASK_RIGHTS_DISABLE;
    SaveMonitor->Enabled  = rCode == TASK_RIGHTS_WRITE;
  }
}
//---------------------------------------------------------------------------
void __fastcall TManForm::CreateMonitorClick(TObject *Sender)
{
	SupperMainForm->N13->Click();
}
//---------------------------------------------------------------------------
void __fastcall TManForm::OpenMonitorClick(TObject *Sender)
{
	SupperMainForm->N12->Click();
}
//---------------------------------------------------------------------------
void __fastcall TManForm::ExitClick(TObject *Sender)
{
	SupperMainForm->N15->Click();
}
//---------------------------------------------------------------------------
void __fastcall TManForm::OpenEditClick(TObject *Sender)
{
	SupperMainForm->N11->Click();
}
//---------------------------------------------------------------------------
void __fastcall TManForm::BitBtnPreviosClick(TObject *Sender)
{  TDateTime DateTime;
// Add KAS 16.03.2001 Если форма-отчет то листаем ее листы

  /*   TBaseMonitorForm* MF = (TBaseMonitorForm*)PageCtrlSplt->listMonitorForms->Items[0];
     if(MF->Interior->fd->CodeTemplate != 1201 && MF->Interior->fd->CodeTemplate != 1202)
	     PageCtrlSplt->GoPreviosForm(); */
        TFormDescr* fd=new TFormDescr;
      unsigned short year,month,day;
	if( PageCtrlSplt->CurrentForm->GetFormDescr() ) {
	    *fd=*(PageCtrlSplt->CurrentForm->GetFormDescr());
       fd->DateTime.DecodeDate( &year,&month,&day);
      switch(fd->StepProfile)
          {
          case TFormDescr::stpHour :  DateTime= fd->DateTime-1; break;
          case TFormDescr::stpMinute :  DateTime= fd->DateTime-1/24; break;
          case TFormDescr::stpDay:
           if(month==1) DateTime= EncodeDate(year-1,(unsigned short)12,day);
           else   DateTime= EncodeDate(year,month-1,(unsigned short)1);
           break;
          case TFormDescr::stpMonth: DateTime= EncodeDate(year-1,month,(unsigned short)1); break;

          }
        fd->DateTime= DateTime;
        dmMain->SetShiftTimeZona(fd->DateTime);
       // перед любым обновлением мониторов необходимо инициализировать кр. секцию UpdateMonitors
            while(WaitForSingleObject(UpdateMonitors,0)!=WAIT_OBJECT_0)
            {
                Application->ProcessMessages();// если не удалось иниц-ть. CS то обновить экранные формы...
                Sleep(0);// переключить управление на другой поток, коьт занял CS
            }
            PostMessage(PageCtrlSplt->CurrentForm->Handle,WM_REFRESHFORM,0,(LPARAM)fd);
     }
}
//---------------------------------------------------------------------------
void __fastcall TManForm::BitBtnNextClick(TObject *Sender)
{  TDateTime DateTime;


// Add KAS 16.03.2001 Если форма-отчет то листаем ее листы
   /*  TBaseMonitorForm* MF = (TBaseMonitorForm*)PageCtrlSplt->listMonitorForms->Items[0];
     if(MF->Interior->fd->CodeTemplate != 1201 && MF->Interior->fd->CodeTemplate != 1202)
     	PageCtrlSplt->GoNextForm(); */
      TFormDescr* fd=new TFormDescr;
      unsigned short year,month,day;
	if( PageCtrlSplt->CurrentForm->GetFormDescr() ) {
	    *fd=*(PageCtrlSplt->CurrentForm->GetFormDescr());
       fd->DateTime.DecodeDate( &year,&month,&day);
      switch(fd->StepProfile)
          {
          case TFormDescr::stpHour :  DateTime= fd->DateTime+1; break;
          case TFormDescr::stpMinute :  DateTime= fd->DateTime+1/24; break;
          case TFormDescr::stpDay:  if(month==12) DateTime= EncodeDate(year+1,(unsigned short)1,day);
              else DateTime= EncodeDate(year,month+1,(unsigned short)1);
              break;
          case TFormDescr::stpMonth:   DateTime= EncodeDate(year+1,month,(unsigned short)1);
           break;

          }
        fd->DateTime= DateTime;
        dmMain->SetShiftTimeZona(fd->DateTime);
       // перед любым обновлением мониторов необходимо инициализировать кр. секцию UpdateMonitors
            while(WaitForSingleObject(UpdateMonitors,0)!=WAIT_OBJECT_0)
            {
                Application->ProcessMessages();// если не удалось иниц-ть. CS то обновить экранные формы...
                Sleep(0);// переключить управление на другой поток, коьт занял CS
            }
            PostMessage(PageCtrlSplt->CurrentForm->Handle,WM_REFRESHFORM,0,(LPARAM)fd);
   }
     
}
//---------------------------------------------------------------------------
void __fastcall TManForm::SaveMonitorAsClick(TObject *Sender)
{
        TfmSaveMonitorAs *f = new TfmSaveMonitorAs(this);
        f->eMonitorName->Text = Caption.SubString(10,Caption.Length()-9);
        if (f->ShowModal_Form(wtSaveAs) == mrOk)
        {
            Monitor_Id = f->Monitor_Id;
            nParent = f->nParent;
            Save_Monitor(f->eMonitorName->Text, UserRol.Monitor);
        }
        delete f;
}
//---------------------------------------------------------------------------
void __fastcall TManForm::SaveMonitorClick(TObject *Sender)
{
         long MonitorSchema = UserRol.Monitor;
         if (Caption.SubString(10,Caption.Length()-9) == Reconst_smes130_5)
            SaveMonitorAsClick(SaveMonitorAs);
         else
            Save_Monitor(Caption.SubString(10,Caption.Length()-9), MonitorSchema);
}
//---------------------------------------------------------------------------
void __fastcall TManForm::EditMonitorListClick(TObject *Sender)
{
        TfmSaveMonitorAs *f = new TfmSaveMonitorAs(this);
        f->ShowModal_Form(wtEdit);
        delete f;
}
//---------------------------------------------------------------------------
void __fastcall TManForm::FormCloseQuery(TObject *Sender, bool &CanClose)
{
	int i;
   while(WaitForSingleObject(UpdateMonitors,0)!=WAIT_OBJECT_0)
   {
      Application->ProcessMessages();// если не удалось иниц-ть. CS то обновить экранные формы...
      Sleep(0);// переключить управление на другой поток, коьт занял CS
   }
	TCloseAction Action;
	CanClose=true;
  //Для того чтобы свернуть OleContainer если он есть на форме
  ActiveControl = BitBtnClose;
	for( i=0; i<PageCtrlSplt->listMonitorForms->Count; ++i )
		((TBaseMonitorForm*)PageCtrlSplt->listMonitorForms->Items[i])->FormClose(this,Action);
   ReleaseMutex(UpdateMonitors);
}
//---------------------------------------------------------------------------
void __fastcall TManForm::MenuItemSetupMonitorClick(TObject *Sender)
{
	FormSetupMonitors->ShowModal();
}
//---------------------------------------------------------------------------
void __fastcall TManForm::EditParamMonitorClick(TObject *Sender)
{
//
}
//---------------------------------------------------------------------------
void __fastcall TManForm::PrintRepClick(TObject *Sender)
{
   PageCtrlSplt->CurrentForm->Interior->PrintRep();
}
//---------------------------------------------------------------------------

void __fastcall TManForm::PrintGraphClick(TObject *Sender)
{
     PageCtrlSplt->CurrentForm->Interior->PrintGraph();
}
//---------------------------------------------------------------------------

void __fastcall TManForm::SaveRepToFileClick(TObject *Sender)
{
     PageCtrlSplt->CurrentForm->Interior->SaveRepToFile(SaveDialog1);
}
//---------------------------------------------------------------------------

void __fastcall TManForm::SaveGraphToFileClick(TObject *Sender)
{
     PageCtrlSplt->CurrentForm->Interior->SaveGraphToFile(SaveDialog1);
}
//---------------------------------------------------------------------------
void __fastcall TManForm::FormActivate(TObject *Sender)
{
     PostMessage(this->Handle,WM_ACTIVATETHISFORM,0,NULL);
}
//---------------------------------------------------------------------------
// Для того чтобы убрать ненужный скроллинг на главной форме
void __fastcall TManForm::WMActivateThisForm(TMessage & Message)
{
  SupperMainForm->Height = SupperMainForm->Height-1;
  SupperMainForm->Height = SupperMainForm->Height+1;
}
//---------------------------------------------------------------------------

void __fastcall TManForm::menuSetupMonitorRefreshClick(TObject *Sender)
{
     //FormSetupMonitorRefresh->ShowModal();
}
//---------------------------------------------------------------------------

void __fastcall TManForm::PrintTableClick(TObject *Sender)
{
     PageCtrlSplt->CurrentForm->Interior->PrintTable();
}
//---------------------------------------------------------------------------

void __fastcall TManForm::N3Click(TObject *Sender)
{
	SupperMainForm->mnOperScan->Click();
}
//---------------------------------------------------------------------------
void __fastcall TManForm::NM5Click(TObject *Sender)
{
	SupperMainForm->N27->Click();
}
//---------------------------------------------------------------------------
void __fastcall TManForm::Save_Monitor(AnsiString aName, long aMSchema)
{
    long MSchema;
	char Name[150];
	long DSize;
    char *ptrMonDate = NULL;
    TStream* ostream = NULL;

    try{
        ostream = new TMemoryStream();
        if(!PageCtrlSplt->Save(ostream))
            throw Exception (Reconst_smes130_6);

        strcpy(Name, aName.c_str());
        MSchema = aMSchema;
        DSize = ostream->Size;
        ptrMonDate = new char[DSize];
        ostream->Position = 0;
        ostream->ReadBuffer(ptrMonDate, DSize);
        oqMonitor->ParamByName("par1")->AsInteger=Monitor_Id;
        oqMonitor->ParamByName("par2")->AsInteger=nParent;
        oqMonitor->ParamByName("par3")->AsInteger=MSchema;
        oqMonitor->ParamByName("par4")->AsString=Name;
        oqMonitor->ParamByName("par5")->AsInteger=DSize;
        oqMonitor->ParamByName("par6")->SetBlobData(ptrMonDate,DSize);
        try{
          oqMonitor->Execute();
        }catch(Exception &e){
          oqMonitor->Session->Rollback();
          throw;
        }
        oqMonitor->Session->Commit();
        Caption = Reconst_smes130_10 +aName;
        delete ostream;
        delete[] ptrMonDate;
    }catch(Exception &e){
        if(ostream) delete ostream;
        if(ptrMonDate) delete[] ptrMonDate;
        throw;
    }
}
//---------------------------------------------------------------------------
void __fastcall TManForm::SaveTableToFileClick(TObject *Sender)
{
     PageCtrlSplt->CurrentForm->Interior->SaveTableToFile(SaveDialog1);
}
//---------------------------------------------------------------------------
//GRB ADD 07.02.2019
void __fastcall TManForm::SaveMultyTableToFileClick(TObject *Sender)
{
     PageCtrlSplt->CurrentForm->Interior->SaveMultyTableToFile(SaveDialog1);
}
//---------------------------------------------------------------------------

