//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#include "MonitorForm.h"
#include "unDataMod.h"
#include "InteriorJournal.h"
#include "Saa_SelectGroup.h"
#include "Monitor.h"
#include "SupperMain.h" // Add KAS 17.07.2001
#include "SplitForm.h"
#include "Interior2.h"
#include "Interior1.h"
#include "Interior4.h"
#include "InteriorJournalSys.h"
#include "InteriorChart.h"
#include "InteriorLimitPower.h"
#include "InteriorDU.h"
#include "InteriorLimCons.h"
#include "InteriorEx.h"
#include "InteriorExRep.h"
#include "InteriorExRepOut.h"
#include "InteriorExOpForm.h"
#include "InteriorLimConsDebt.h"
#include "InteriorConsImbalance.h"
#include "InteriorDecad.h"
#include "InteriorPLProc.h"
#include "InteriorPLTable.h"
#include "InteriorDU2Chart.h"
//26.11.2020 - GRB ADD
#include "InteriorDU2ChartGRB.h"

#include "InteriorModus.h"
#include "InteriorMaket.h"
#include "InteriorFullDat.h"

#include "Reconst.hpp"
#include "unitperm.h"
//---------------------------------------------------------------------------
#pragma resource "*.dfm"
TBaseMonitorForm *BaseMonitorForm;
//int TBaseMonitorForm::CountMutex=0;
CRITICAL_SECTION ListInteriorCriticalSection;
extern HANDLE UpdateMonitors;
TList *ListInterior;
//---------------------------------------------------------------------------
__fastcall TBaseMonitorForm::TBaseMonitorForm(TComponent* Owner,Classes::TNotifyEvent OnProgr )
	: TForm(Owner)
{
	isMaximized=isActive=false;
	isPressButton=btNone;
    // OnProgressBarStepBy=NULL;
	OnProgressBarStepBy=OnProgr;
	isSmallFont=true;
	// ++CountMutex;
}
//---------------------------------------------------------------------------

__fastcall TBaseMonitorForm::~TBaseMonitorForm()
{
	delete Interior;
}
//---------------------------------------------------------------------------
// Отрисовка главного заголовка, в зависимости от состояния мозаичного окна
//		с фокусом					без фокуса
//		максимизировано				в обычном состоянии
void __fastcall TBaseMonitorForm::PaintBoxCaptionPaint(TObject *Sender)
{
#define Sender ((TPaintBox*)Sender)
   RECT lprc,r_close;
   lprc=Sender->ClientRect;
   --lprc.bottom;
   //DrawCaption(Handle,Sender->Canvas->Handle,&lprc,
   //	( isActive ? DC_ACTIVE : 0)|DC_ICON|DC_TEXT );
   if( Tag )
	   if( isActive )
   	{
	   	Sender->Color=clWindow;
		   Sender->Font->Color=clWindowText;
   	}
	   else
   	{
	   	Sender->Color=clWindow;
		   Sender->Font->Color=clInactiveCaptionText;
   	}
   else if( isActive )
   {
	   Sender->Color=clBlue;
		Sender->Font->Color=clWhite;
   }
	else
   {
	   Sender->Color=clInactiveCaption;
		Sender->Font->Color=clInactiveCaptionText;
   }
   Sender->Canvas->FillRect(Sender->ClientRect);
   //Sender->Canvas->TextRect(Sender->ClientRect, lprc.left, lprc.top, Caption);
   RECT lpRect=Sender->ClientRect;
   lpRect.right-=2*GetSystemMetrics(SM_CXSIZE);
   DrawText(Sender->Canvas->Handle,Caption.c_str(),-1,&lpRect,
	   DT_LEFT|DT_SINGLELINE|DT_VCENTER|DT_END_ELLIPSIS);

   r_close.top=lprc.top+2;
   r_close.bottom=GetSystemMetrics(SM_CYCAPTION)+lprc.top-3;
   r_close.right=lprc.right-2;
   r_close.left=r_close.right-(GetSystemMetrics(SM_CXSIZE)-2);

   //VTR
   //DrawFrameControl(Sender->Canvas->Handle,&r_close,DFC_CAPTION,
   //	DFCS_CAPTIONCLOSE/*|DFCS_INACTIVE*/);

   //r_close.right=r_close.left-2;
   //r_close.left=r_close.right-(GetSystemMetrics(SM_CXSIZE)-2);
   //12.06.2020 (цеплЯет ключ-бесключ: применил в key_unkey_return_to_odac_5_7 22.07.2020) GRB COMMENT - отключаем прорисовку блямбы, т.к её функционал развернуть-свернуть по факту не работает. Также отключил прорисовку пункта меню в InteriorJournal.cpp::Place и вернул её в InteriorJournal.cpp::~InteriorJournal
   /*
   DrawFrameControl(Sender->Canvas->Handle,&r_close,DFC_CAPTION,
	   (isMaximized ? DFCS_CAPTIONRESTORE: DFCS_CAPTIONMAX ));*/
	//END GRB COMMENT
   /*
   r_close.right=r_close.left;
   r_close.left=r_close.right-(GetSystemMetrics(SM_CXSIZE)-2);
   DrawFrameControl(Sender->Canvas->Handle,&r_close,DFC_CAPTION,DFCS_CAPTIONMIN);
   */
#undef Sender
}
//---------------------------------------------------------------------------
/*
	Для перерасчета системных размеров заголовка и т.д.
*/
void __fastcall TBaseMonitorForm::FormResize(TObject *Sender)
{
	//LabelComment->Update();
	AnsiString s=LabelComment->Caption;
	LabelComment->Caption="";
	LabelComment->Caption=s;//clBlue;
	//PaintBoxCaption->Height=GetSystemMetrics(SM_CYCAPTION);
}
//---------------------------------------------------------------------------
/*
	Для обработки ввода от мыши с целью генерации сообщений владельцу на
	максимизацию восстановление или закрытие мозаичного окна.
*/
void __fastcall TBaseMonitorForm::PaintBoxCaptionMouseDown(TObject *Sender,
	TMouseButton Button, TShiftState Shift, int X, int Y)
{
#define Sender ((TPaintBox*)Sender)
   TShiftState leftShift;
   leftShift<<ssLeft;
   if( Button!=Controls::mbLeft || Shift!=leftShift )
	   return;
   RECT lprc;
   lprc=Sender->ClientRect;
   //--lprc.bottom;

   lprc.bottom=GetSystemMetrics(SM_CYCAPTION)+lprc.top-3;
   lprc.top+=2;


   lprc.right-=2;
   lprc.left=lprc.right-(GetSystemMetrics(SM_CXSIZE)-2);
   //VTR
   /*
   if( X>=lprc.left && X<=lprc.right && Y>=lprc.top && Y<=lprc.bottom )
   {
	   isPressButton=btClose;
   	DrawFrameControl(Sender->Canvas->Handle,&lprc,DFC_CAPTION,
	   	DFCS_CAPTIONCLOSE|DFCS_PUSHED);
   	return;
   }
   */
   //lprc.right=lprc.left-2;
   //lprc.left=lprc.right-(GetSystemMetrics(SM_CXSIZE)-2);
   if( X>=lprc.left && X<=lprc.right && Y>=lprc.top && Y<=lprc.bottom )
   {
	   isPressButton=btMaxRest;
	   //12.06.2020 GRB COMMENT(цеплЯет ключ-бесключ: применил в key_unkey_return_to_odac_5_7 22.07.2020) - отключаем прорисовку блямбы, т.к её функционал развернуть-свернуть по факту не работает. Также отключил прорисовку пункта меню в InteriorJournal.cpp::Place и вернул её в InteriorJournal.cpp::~InteriorJournal
	  /*
      DrawFrameControl(Sender->Canvas->Handle,&lprc,DFC_CAPTION,
		   (isMaximized ? DFCS_CAPTIONRESTORE: DFCS_CAPTIONMAX )|DFCS_PUSHED);*/
	  //END GRB COMMENT
   	return;
   }
#undef Sender
}
//---------------------------------------------------------------------------
/*
	Для обработки ввода от мыши с целью генерации сообщений владельцу на
	максимизацию восстановление или закрытие мозаичного окна.
*/
void __fastcall TBaseMonitorForm::PaintBoxCaptionMouseMove(TObject *Sender,
	TShiftState Shift, int X, int Y)
{
#define Sender ((TPaintBox*)Sender)
   if( isPressButton!=btClose && isPressButton!=btMaxRest )
	   return;
   RECT lprc;
   lprc=Sender->ClientRect;
   //--lprc.bottom;

   lprc.bottom=GetSystemMetrics(SM_CYCAPTION)+lprc.top-3;
   lprc.top+=2;

   lprc.right-=2;
   lprc.left=lprc.right-(GetSystemMetrics(SM_CXSIZE)-2);
   //VTR
   /*
   if( isPressButton==btClose )
   {
	   if( X>=lprc.left && X<=lprc.right && Y>=lprc.top && Y<=lprc.bottom )
		   DrawFrameControl(Sender->Canvas->Handle,&lprc,DFC_CAPTION,
			   DFCS_CAPTIONCLOSE|DFCS_PUSHED);
   	else
	   	DrawFrameControl(Sender->Canvas->Handle,&lprc,DFC_CAPTION,
		   	DFCS_CAPTIONCLOSE);
   	return;
   }
   */
   //lprc.right=lprc.left-2;
   //lprc.left=lprc.right-(GetSystemMetrics(SM_CXSIZE)-2);
   if( isPressButton==btMaxRest )
   {
	//12.06.2020 GRB COMMENT(цеплЯет ключ-бесключ: применил в key_unkey_return_to_odac_5_7 22.07.2020) - отключаем прорисовку блямбы, т.к её функционал развернуть-свернуть по факту не работает. Также отключил прорисовку пункта меню в InteriorJournal.cpp::Place и вернул её в InteriorJournal.cpp::~InteriorJournal

      /*	   if( X>=lprc.left && X<=lprc.right && Y>=lprc.top && Y<=lprc.bottom )
		   DrawFrameControl(Sender->Canvas->Handle,&lprc,DFC_CAPTION,
			   (isMaximized ? DFCS_CAPTIONRESTORE: DFCS_CAPTIONMAX )|DFCS_PUSHED);
   	else
	   	DrawFrameControl(Sender->Canvas->Handle,&lprc,DFC_CAPTION,
		   	(isMaximized ? DFCS_CAPTIONRESTORE: DFCS_CAPTIONMAX )); */
        //END ADD 
   }
#undef Sender
}
//---------------------------------------------------------------------------
/*
	Для обработки ввода от мыши с целью генерации сообщений владельцу на
	максимизацию восстановление или закрытие мозаичного окна.
*/
void __fastcall TBaseMonitorForm::PaintBoxCaptionMouseUp(TObject *Sender,
	TMouseButton Button, TShiftState Shift, int X, int Y)
{
#define Sender ((TPaintBox*)Sender)
   if( isPressButton!=btClose && isPressButton!=btMaxRest )
	   return;
   RECT lprc;
   lprc=Sender->ClientRect;
   //--lprc.bottom;

   lprc.bottom=GetSystemMetrics(SM_CYCAPTION)+lprc.top-3;
   lprc.top+=2;

   lprc.right-=2;
   lprc.left=lprc.right-(GetSystemMetrics(SM_CXSIZE)-2);
   //VTR
   if( isPressButton==btClose && X>=lprc.left && X<=lprc.right && Y>=lprc.top && Y<=lprc.bottom )
   {
	   isPressButton=btNone;
       return;
   }
   else
   {
   //lprc.right=lprc.left-2;
   //lprc.left=lprc.right-(GetSystemMetrics(SM_CXSIZE)-2);
      if( isPressButton==btMaxRest && X>=lprc.left && X<=lprc.right && Y>=lprc.top && Y<=lprc.bottom )
      {
      //12.06.2020 GRB COMMENT(цеплЯет ключ-бесключ: применил в key_unkey_return_to_odac_5_7 22.07.2020) - отключаем прорисовку блямбы, т.к её функционал развернуть-свернуть по факту не работает. Также отключил прорисовку пункта меню в InteriorJournal.cpp::Place и вернул её в InteriorJournal.cpp::~InteriorJournal
       /*	DrawFrameControl(Sender->Canvas->Handle,&lprc,DFC_CAPTION,
		      (!isMaximized ? DFCS_CAPTIONRESTORE: DFCS_CAPTIONMAX ));  */
        //END COMMENT
      	if( isMaximized )
		      RestoreMonitorForm();
      	else
		      MaximizeMonitorForm();
      }
   }
   /*if( isPressButton==btClose && X>=lprc.left && X<=lprc.right && Y>=lprc.top && Y<=lprc.bottom )
   {
	   DrawFrameControl(Sender->Canvas->Handle,&lprc,DFC_CAPTION,
		   DFCS_CAPTIONCLOSE);
   	DeleteMonitorForm();

   }
   else
   {
      lprc.right=lprc.left-2;
      lprc.left=lprc.right-(GetSystemMetrics(SM_CXSIZE)-2);
      if( isPressButton==btMaxRest && X>=lprc.left && X<=lprc.right && Y>=lprc.top && Y<=lprc.bottom )
      {
	      DrawFrameControl(Sender->Canvas->Handle,&lprc,DFC_CAPTION,
		      (!isMaximized ? DFCS_CAPTIONRESTORE: DFCS_CAPTIONMAX ));
      	if( isMaximized )
	      	RestoreMonitorForm();
   	   else
	   	   MaximizeMonitorForm();
      }
   } */
   isPressButton=btNone;
#undef Sender
}
//---------------------------------------------------------------------------
void __fastcall TBaseMonitorForm::FormPaint(TObject *Sender)
{
	PaintBoxCaptionPaint(PaintBoxCaption);
}
//---------------------------------------------------------------------------
/*
	Генерация сообщения владельцу о активизации мозаичного окна.(получение фокуса)
*/
void __fastcall TBaseMonitorForm::FormActivate(TObject *Sender)
{
	if( dynamic_cast<TWinControl*>(Owner) )
		PostMessage( dynamic_cast<TWinControl*>(Owner)->Handle,WM_ACTIVESPLTCHILD,(WPARAM)0,(LPARAM)this);
}
//---------------------------------------------------------------------------
/*
	Генерация сообщения владельцу о деактивизации мозаичного окна.(потеря фокуса)
*/
void __fastcall TBaseMonitorForm::FormDeactivate(TObject *Sender)
{
	if( dynamic_cast<TWinControl*>(Owner) )
		PostMessage( dynamic_cast<TWinControl*>(Owner)->Handle,WM_DEACTIVESPLTCHILD,(WPARAM)0,(LPARAM)this);
}
//---------------------------------------------------------------------------
/*
	Владелец активизирует мозаичное окно.(установка фокуса)
*/
void __fastcall TBaseMonitorForm::WMSpltSetFocus(TMessage & Message)
{
	isActive=true;
	isMaximized=Message.WParam;
	if(!isMaximized)
	{
	   TWinControl* p=FindNextControl(NULL,true,true,false);
   	if( p )
	   	p->SetFocus();
	}
	/*
	if(Tag)
		LabelComment->Font->Color=clWindowText;
	else
		LabelComment->Font->Color=clWindowText;//clBlue;
	*/
	PaintBoxCaption->Invalidate();
}
//---------------------------------------------------------------------------
/*
	Владелец деактивизирует мозаичное окно.(снятие фокуса)
*/
void __fastcall TBaseMonitorForm::WMSpltKillFocus(TMessage & Message)
{
	isActive=false;
	isMaximized=Message.WParam;
   //LabelComment->Font->Color=clInactiveCaption;
	PaintBoxCaption->Invalidate();
}
//---------------------------------------------------------------------------
void __fastcall TBaseMonitorForm::FormCreate(TObject *Sender)
{
	//InitializeCriticalSection(&CriticalSection);
	if( (hMutex=CreateMutex(NULL,false,NULL))==NULL )
		throw(Exception(Reconst_smes124_1));
	SplitterForm=new TSplitterForm(this);
	SplitterForm->Align=alClient;
	SplitterForm->Parent=this;
	SplitterForm->Show();
	SplitterForm->OnClick=FormActivate;
	TFormDescr *fd=new TFormDescr;
	Interior=new TInterior(this,SplitterForm,fd,OnProgressBarStepBy);
	Interior->hMutex=NULL;
	LabelComment->Caption=GetFormDescr()->CommentForm;
	Caption=GetFormDescr()->NameGroup;
}
//---------------------------------------------------------------------------
void __fastcall TBaseMonitorForm::WMRefreshData(TMessage & Message)
{
	//Message.WParam=NameAlert,Message.LParam=VCursor;
   if(((Interior->fd->CodeTemplate==1202)||(Interior->fd->CodeTemplate==1200)))
      Interior->Invalidate( Message.WParam );
   if((Interior->fd->CodeTemplate!=1200) && (Interior->fd->CodeTemplate!=1201) && (Interior->fd->CodeTemplate!=1202))
      Interior->Invalidate( Message.WParam );
}
//---------------------------------------------------------------------------
void __fastcall TBaseMonitorForm::WMRefreshForm(TMessage & Message)
{
	//Message.LParam=&fd
	TFormDescr *fd=(TFormDescr *)Message.LParam;
	TInterior* newInterior;
    try
    {
         //22.08.2019 UNKEY VERSION COMMENT
        /*if(!dmMain->LicType&&GrdGetPermission(CHK_LIC_TASK,CHK_LIC_TASK_MONITOR)<=0)
          return;*/
        //END COMMENT
        //chig Выясняем, что вызвано после ввода новых параметров для Эксель-мониторов
        bool prIsExcelNewParam = FALSE;
        //Только если не изменился ид группы
        if (Interior && fd->IdFormTree == Interior->fd->IdFormTree )
            if(Interior->fd->CodeTemplate==EXCEL_REP_F ||
                Interior->fd->CodeTemplate==EXCEL_F ||
                Interior->fd->CodeTemplate==EXCEL_OP_FORM)
            {
                prIsExcelNewParam = TRUE;
                //chig 29.01.03
                if(fd->CodeTemplate==EXCEL_REP_F)
                    ((TInteriorExRep*)Interior)->DoVerb();
                if(fd->CodeTemplate==EXCEL_OP_FORM)
                    ((TInteriorExOpForm*)Interior)->DoVerb();
                //e chig 29.01.03
            }
        //e Только если не изменился ид группы
        //e chig
        AnsiString dt;
        unsigned short year, month;
        PaintBoxCaption->Invalidate();
        switch( fd->StepProfile )
        {
        case TFormDescr::stpMonth:
		    Caption=fd->NameGroup+" за "+fd->DateTime.FormatString("yyyy 'г.'");

			break;
      case TFormDescr::stpDay:
        Caption=fd->NameGroup+" за "+fd->DateTime.FormatString("mmmm YYYY'г.'");
     	break;
      case TFormDescr::stpHour:
		    Caption=fd->NameGroup+" за "+fd->DateTime.FormatString("ddddd");
     	break;
      case TFormDescr::stpMinute:
		    Caption=fd->NameGroup+" на "+fd-> DateTime.FormatString("ddddd")+" c "+fd->DateTime.FormatString("t");
			break;
        }
        LabelComment->Caption=fd->CommentForm;
        //chig
        if( prIsExcelNewParam )
        {
            if( hMutex==NULL || WaitForSingleObject(hMutex,INFINITE)==WAIT_OBJECT_0 )
            {
                //chig 29.01.03
                //Передача новых параметров в экземпляр интерьера
                Interior->fd = fd;
                //e Передача новых параметров в экземпляр интерьера
                //e chig 29.01.03
                //Обновление монитора для новых параметров
                switch( fd->CodeTemplate )
                { case EXCEL_REP_F:
                    ((TInteriorExRep*)Interior)->PassParamsToExcelAndRefr();
                    break;
                  case EXCEL_F:
                    ((TInteriorEx*)Interior)->PassParamsToExcelAndRefr();
                    break;
                  case EXCEL_OP_FORM:
                    ((TInteriorExOpForm*)Interior)->PassParamsToExcelAndRefr();
                    break;
                }
                //e Обновление монитора для новых параметров
                if(hMutex)
                    ReleaseMutex(hMutex);
            }else
                throw(Exception(Reconst_smes124_2));
        }
        else
        {
            //e chig
            EnterCriticalSection(&ListInteriorCriticalSection);
            try
            {
                switch( fd->CodeTemplate )
                {
                case 1:
                    newInterior=new T2xDrawTableChartInterior(this,SplitterForm,fd,OnProgressBarStepBy);
                    break;
                case AEBO_REBO_F:       // 100 - Переток Активной / Реактивной энергии [МВтч/МВАрч]
                case AERO_AEDO_F:       // 200 - Приём / Отдача Активной энергии [МВтч]
                case RERO_REDO_F:       // 300 - Приём / Отдача Реактивной энергии [МВАрч]
                //*************** Получасовки и минутки в мощности ****************************/
                case AEBO_REBO_POW_F:   // 101 - Переток Активной / Реактивной энергии [МВтч/МВАрч]
                case AERO_AEDO_POW_F:   // 201 - Приём / Отдача Активной энергии [МВтч]
                case RERO_REDO_POW_F:   // 301 - Приём / Отдача Реактивной энергии [МВАрч]
                //*************** Расходы суммируются по наростающей **************************/
                case AEBO_REBO_SUM_F:   // 102 - Переток Активной / Реактивной энергии [МВтч/МВАрч] Суммируется по наростающей
                case AERO_AEDO_SUM_F:   // 202 - Приём / Отдача Активной энергии [МВтч] Суммируется по наростающей
                case RERO_REDO_SUM_F:   // 302 - Приём / Отдача Реактивной энергии [МВАрч] Суммируется по наростающей
                //*****************************************************************************/
                case RQ1_RQ4_F:         //Приём / Отдача Реактивной энергии при импорте активной энергии [МВАрч]
                case RQ1_RQ4_POW_F:     //Приём / Отдача Реактивной энергии при импорте активной энергии [МВАрч]  Получасовки мощность
                case RQ2_RQ3_F:         //Приём / Отдача Реактивной энергии при экспорте активной энергии [МВАрч]
                case RQ2_RQ3_POW_F:     //Приём / Отдача Реактивной энергии при экспорте активной энергии [МВАрч] Получасовки мощность

                    newInterior=new T2Interior(this,SplitterForm,fd,OnProgressBarStepBy);
                    break;

                case AEBO_F:            // 400 - Переток Активной энергии [кВтч]
                case AERO_F:            // 500 - Приём Активной энергии [кВтч]
                case AEDO_F:            // 600 - Отдача Активной энергии [кВтч]
                case REBO_F:            // 700 - Переток Реактивной энергии [кВАрч]
                case RERO_F:            // 800 - Приём Реактивной энергии [кВАрч]
                case REDO_F:            // 900 - Отдача реактивной энергии [кВАрч]
                //************** Временные определенеия для газа, воды и тепла. ***************/
                case WATER_F:
                case GAS_F:
                case HEAT_F:
                //*****************************************************************************/
                //*************** Получасовки и минутки в мощности ****************************/
                case AEBO_POW_F:        // 401 - Переток Активной энергии [кВтч]
                case AERO_POW_F:        // 501 - Приём Активной энергии [кВтч]
                case AEDO_POW_F:        // 601 - Отдача Активной энергии [кВтч]
                case REBO_POW_F:        // 701 - Переток Реактивной энергии [кВАрч]
                case RERO_POW_F:        // 801 - Приём Реактивной энергии [кВАрч]
                case REDO_POW_F:        // 901 - Отдача реактивной энергии [кВАрч]
                //*****************************************************************************/
                //*************** Расходы суммируются по наростающей **************************/
                case AEBO_SUM_F: // 402 - Переток Активной энергии [кВтч] Суммируется по наростающей
                case AERO_SUM_F: // 502 - Приём Активной энергии [кВтч] Суммируется по наростающей
                case AEDO_SUM_F: // 602 - Отдача Активной энергии [кВтч] Суммируется по наростающей
                case REBO_SUM_F: // 702 - Переток Реактивной энергии [кВАрч] Суммируется по наростающей
                case RERO_SUM_F: // 802 - Приём Реактивной энергии [кВАрч] Суммируется по наростающей
                case REDO_SUM_F: // 902 - Отдача реактивной энергии [кВАрч] Суммируется по наростающей
                //*****************************************************************************/
                    newInterior=new T1Interior(this,SplitterForm,fd,OnProgressBarStepBy);
                    break;
                case AERO_AERA_AERB_AERC_F:	// 910 - Активная принятая общая и по тарифам [кВтч]
                case AEDO_AEDA_AEDB_AEDC_F: // 920 - Активная отданная общая и по тарифам [кВтч]
                case RERO_RERA_RERB_RERC_F: // 930 - Реактивная принятая общая и по тарифам [кВАрч]
                case REDO_REDA_REDB_REDC_F: // 940 - Реактивная отданная общая и по тарифам [кВАрч]
                case AERA_AERB_AERC_AERD_F: // 950 - Активная принятая по тарифам [кВтч]
                case AEDA_AEDB_AEDC_AEDD_F: // 960 - Активная отданная по тарифам [кВтч]
                case RERA_RERB_RERC_RERD_F: // 970 - Реактивная принятая по тарифам [кВАрч]
                case REDA_REDB_REDC_REDD_F: // 980 - Реактивная отданная по тарифам [кВАрч]
                // add KAS 20.04.2002
                case AEBO_AEBA_AEBB_AEBC_F: // 921 Переток активной э/э (общая и по тарифам) [кВтч]
                case REBO_REBA_REBB_REBC_F: //941 Переток реактивной э/э (общая и по тарифам) [кВарч]
                // end add
                //Баланс add by NNV
                case BALANCE_F: // 203 - Баланас Активной энергии [МВтч]
                case BALANCE_POW_F: // 204 - Баланс Активной энергии (ГН, Тех.проф. - мощность)
                case BALANCE_SUM_F: // 205 - Баланс Активной энергии (Суммируется по наростающей)
                case RE_BALANCE_F: // 303 - Баланс Реактивной энергии
                case RE_BALANCE_POW_F: // 304 - Баланс Реактивной энергии (ГН, Тех.проф. - мощность)
                case RE_BALANCE_SUM_F: // 305 - Баланс Реактивной энергии (Суммируется по наростающей)
                //end add NNV
                case NOT_BALANCE: // 206 - Небаланс  энергии
                case NOT_BALANCE_AER: // 207 - Небаланс активной энергии
                    newInterior=new T4Interior(this,SplitterForm,fd,OnProgressBarStepBy);
                    break;
                case APRO_C: // 10 - Активная мощность (графические формы)
                case RPRO_C: // 20 - Реактиная мощность
                    newInterior=new TChartInterior(this,SplitterForm,fd,OnProgressBarStepBy);
                    break;
                case APBO_F: // 30 - Мощность, лимит, отклонение [МВт]
                case RPBO_F: // 40 - Мощность, лимит, отклонение [МВт]
                    newInterior=new TLimitPowerInterior(this,SplitterForm,fd,OnProgressBarStepBy);
                    break;
                case JOURNAL_F: // 1000 - Журнал действий оператора
                    newInterior=new TJournalInterior(this,SplitterForm,fd,OnProgressBarStepBy);
                    break;
                //--------------------------------- Edit by Step------------------------------------------
                case EXCEL_F:
                // Add KAS 28.02.2001
                // Проверяем есть ли файл в нужной директории и если нет то вытягиваем его из базы
                    Control_Exist_File(fd->IdFormTree);
                    // end Add

                    newInterior=new TInteriorEx(this,SplitterForm,fd,OnProgressBarStepBy);
                    break;
                //----------------------------------------------------------------------------------------
                // Add chig 28.11.2002 --------------------------------------------------------------------
                case PL_SQL_REP_F:
                    newInterior=new TInteriorPLProc(this,SplitterForm,fd,OnProgressBarStepBy);
                    break;
                // end add -------------------------------------------------------------------------------
                case PL_SQL_TABLE: //SAA 07/12/2007
                    newInterior=new TInteriorPLTable(this,SplitterForm,fd,OnProgressBarStepBy);
                    break;
                // end add -------------------------------------------------------------------------------
				//GRB ADD 23.01.2019 - Для создания встроенного отчета о потреблении активной и реактивной энергии, а также генерации реактивной энергии по точке или группе точек абонента Житомир ОЭ
                case PL_SQL_MANY_TABLE: //GRB 23/01/2019
                    newInterior=new TInteriorPLTable(this,SplitterForm,fd,OnProgressBarStepBy,3);
                    break;
                // END GRB add -------------------------------------------------------------------------------

                case EXCEL_REP_F:
                // Проверяем есть ли файл в нужной директории и если нет то вытягиваем его из базы
                    Control_Exist_File(fd->IdFormTree);
                    newInterior=new TInteriorExRep(this,SplitterForm,fd,OnProgressBarStepBy);
                    break;
                // end add -------------------------------------------------------------------------------
                // Add KAS 27.08.2001 --------------------------------------------------------------------
                //===== 07.07.2005 Frizyuk A.M. Start
                case EXCEL_REP_OUT_F:
                  Control_Exist_File(fd->IdFormTree);
                  newInterior = new TInteriorExRepOut(this, SplitterForm, fd, OnProgressBarStepBy);
                  break;
                //===== 07.07.2005 Frizyuk A.M. Finish
                case EXCEL_OP_FORM:
                // Проверяем есть ли файл в нужной директории и если нет то вытягиваем его из базы
                    Control_Exist_File(fd->IdFormTree);
                    newInterior=new TInteriorExOpForm(this,SplitterForm,fd,OnProgressBarStepBy);
                    break;
                // end add -------------------------------------------------------------------------------
                case JOURNALSYS_F: // 1100 - Журнал сообщений системы
                    newInterior=new TJournalInteriorSys(this,SplitterForm,fd,OnProgressBarStepBy);
                    break;
                //case Disturber_F: // 51 - Оперативный контроль лимитов
                //case Disturber_F_BW:// 53 - Оперативный контроль лимитов (Ч\Б)
                //    newInterior=new TDisturberInterior(this,SplitterForm,fd,OnProgressBarStepBy,fd->CodeTemplate-Disturber_F);
                //    break;
                case DU_F:           // 50 - Текущая нагрузка, МВт
                case DU_F_BW:       // 52 - Текущая нагрузка (Ч\Б)
                    newInterior=new TDUInterior(this,SplitterForm,fd,OnProgressBarStepBy,fd->CodeTemplate-DU_F);
                    break;
                case ConsumLim_F:   // 54 - Контроль потребителей
                case ConsumLim_F_BW:// 55 - Контроль потребителей (Ч/Б)
                    newInterior=new TConsumLimit(this,SplitterForm,fd,OnProgressBarStepBy,fd->CodeTemplate-ConsumLim_F);
                    break;
                case ConsumLim_F__Debt:// 56 - Контроль потребителей-должников
                case ConsumLim_F_BW__Debt:// 57 - Контроль потребителей-должников (Ч/Б)
                    newInterior=new TConsumLimit(this,SplitterForm,fd,OnProgressBarStepBy,fd->CodeTemplate-ConsumLim_F__Debt);
                    break;
                case ConsumLim_F__Limit: // 58 - Контроль потребителей-перерасходчиков
                case ConsumLim_F_BW__Limit: // 59 - Контроль потребителей-перерасходчиков (Ч/Б)
                    newInterior=new TConsumLimit(this,SplitterForm,fd,OnProgressBarStepBy,fd->CodeTemplate-ConsumLim_F__Limit);
                    break;
                //case ConsumLost_F: // 60 - Контроль не поступления данных
                //case ConsumLost_F_BW: // 61 - Контроль не поступления данных (Ч\Б)
                //    newInterior=new TConsumLost(this,SplitterForm,fd,OnProgressBarStepBy,fd->CodeTemplate-ConsumLost_F);
                //    break;

                case ConsumLimDebt_F:   //62 - Контроль потребителей (Есть столбец долг)
                    newInterior=new TConsumLimitDebt(this,SplitterForm,fd,OnProgressBarStepBy,fd->CodeTemplate-ConsumLimDebt_F);
                    break;
                case ConsumImbalance_F: //63 - Небаланс энергообъектов
                    newInterior=new TConsumImbalance(this,SplitterForm,fd,OnProgressBarStepBy,fd->CodeTemplate-ConsumImbalance_F);
                    break;
                case ConsumImbalance_POW_F: //64 - Небаланс энергообъектов (По мощности)
                    newInterior=new TConsumImbalance(this,SplitterForm,fd,OnProgressBarStepBy,fd->CodeTemplate-ConsumImbalance_POW_F);
                    break;

                case AERO_DECAD_F: //1400 Приём Активной энергии по декадам [тыс.кВтч]
                    newInterior=new TDecadInterior(this,SplitterForm,fd,OnProgressBarStepBy,fd->CodeTemplate-AERO_DECAD_F);
                    break;
                case AEBO_DECAD_F: //1410 Переток Активной энергии по декадам [тыс.кВтч]
                    newInterior=new TDecadInterior(this,SplitterForm,fd,OnProgressBarStepBy,fd->CodeTemplate-AEBO_DECAD_F);
                    break;
                case DU2CHART_PARAMS: //65 //Текущие значения и параметры качества электроэнергии (КСС)
                    //26.11.2020 - изменил 
                    //newInterior=new TDU2ChartInterior(this,SplitterForm,fd,OnProgressBarStepBy);
                    newInterior=new TDU2ChartInteriorGRB(this,SplitterForm,fd,OnProgressBarStepBy);
                    break;
                case SCHEMA_OP_FORM: //1204 //Оперативная форма со схемой электрической сети (КСС)
                    Control_Exist_File(fd->IdFormTree);
                    newInterior = new TModusInterior(this,SplitterForm,fd,OnProgressBarStepBy);
                    break;
                case MODUS_OP_FORM: //1205 //Оперативная форма со схемой электрической сети от Модуса(КСС)
                    Control_Exist_File(fd->IdFormTree);
                    newInterior = new TModusInterior(this,SplitterForm,fd,OnProgressBarStepBy,TModusInterior::otModusActiveXeme);
                    break;
                case MAKET_F: // 1450 - Макет 30817
                    newInterior = new TMaketInterior(this,SplitterForm,fd,OnProgressBarStepBy,fd->CodeTemplate-MAKET_F);
                    break;
                case FULL_DATA: // 330 - //Полнота и своевременность прлучаемых данных
                    newInterior=new TInteriorFullDat(this,SplitterForm,fd,OnProgressBarStepBy);
                    break;
                default:
                    delete fd;
                    fd = new TFormDescr;
                    newInterior=new TInterior(this,SplitterForm,fd,OnProgressBarStepBy);
                    break;
                }
            }
            catch( Exception &e )
            {
                LeaveCriticalSection(&ListInteriorCriticalSection);
                throw;
            }
    //Удалить Interior из списка ожидающих обновления
            ListInterior->Remove(Interior);
            LeaveCriticalSection(&ListInteriorCriticalSection);

            if( hMutex==NULL || WaitForSingleObject(hMutex,INFINITE)==WAIT_OBJECT_0 )
            {
                try {
                    Interior->Destroy();
                    delete Interior;
                    Interior=NULL;
                }
                catch(Exception &e){}
                if(hMutex)ReleaseMutex(hMutex);
            }
            else
                throw(Exception(Reconst_smes124_2));
            try
            {
                newInterior->Place();
            // Kas 16.02.2001 Add
            //	if(fd->CodeTemplate==1200)
            // newInterior->Invalidate(6);
            // end add
    // Add KAS 16.03.2001 ***********************************************************
                TManForm *FFF = dynamic_cast<TManForm*>(SupperMainForm->ActiveMDIChild);
                if(FFF)
                {
                    if(fd->CodeTemplate==EXCEL_REP_F||fd->CodeTemplate==EXCEL_F||
                        fd->CodeTemplate==EXCEL_OP_FORM||fd->CodeTemplate==PL_SQL_REP_F||fd->CodeTemplate==PL_SQL_TABLE){
                        if(fd->CodeTemplate==EXCEL_REP_F || fd->CodeTemplate==EXCEL_OP_FORM ||
                            fd->CodeTemplate==PL_SQL_REP_F||fd->CodeTemplate==PL_SQL_TABLE)
                        {
                            FFF->Rotate->Enabled = false;
                            FFF->AddRight->Enabled = false;
                            FFF->AddBottom->Enabled = false;
                        }
                        FFF->PrintRep->Visible = true;
                        FFF->SaveRepToFile->Visible = true;
                        FFF->PrintTable->Visible = false;
                        FFF->PrintGraph->Visible = false;
                        FFF->SaveGraphToFile->Visible = false;
                        FFF->SaveTableToFile->Visible = false;
                        PopupMenuBaseForm->AutoPopup = false;
                        PopupMenuDU->AutoPopup = false;
                        FFF->N2->Visible = true;
                    }else if(fd->CodeTemplate==SCHEMA_OP_FORM ||
                             fd->CodeTemplate==MODUS_OP_FORM){
                        FFF->PrintRep->Visible = true;
                    }else{
                        FFF->Rotate->Enabled = true;
                        FFF->AddRight->Enabled = true;
                        FFF->AddBottom->Enabled = true;
                        FFF->PrintRep->Visible = false;
                        FFF->SaveRepToFile->Visible = false;
                        FFF->BitBtnNext->Enabled = true;
                        FFF->BitBtnPrevios->Enabled = true;
                    }
                    //GRB  COMMENT CHANGE 16.07.2019 - запрещаем бегать туда-сюда на минутке
                    /*FFF->BitBtnPrevios->Enabled =(fd->CodeTemplate==1201||fd->CodeTemplate==1202||fd->CodeTemplate==PL_SQL_REP_F||fd->CodeTemplate==PL_SQL_TABLE?false:true);
                    FFF->BitBtnNext->Enabled = (fd->CodeTemplate==1201||fd->CodeTemplate==1202||fd->CodeTemplate==PL_SQL_REP_F||fd->CodeTemplate==PL_SQL_TABLE?false:true);
                    */

                    //GRB REMOVE 16.07.2019
                    FFF->BitBtnPrevios->Enabled =(fd->CodeTemplate==1201||fd->CodeTemplate==1202||fd->CodeTemplate==PL_SQL_REP_F||fd->CodeTemplate==PL_SQL_TABLE?false:true);
                    if ((fd->StepProfile==TFormDescr::stpMinute))
                      FFF->BitBtnPrevios->Enabled = false;
                    FFF->BitBtnNext->Enabled = (fd->CodeTemplate==1201||fd->CodeTemplate==1202||fd->CodeTemplate==PL_SQL_REP_F||fd->CodeTemplate==PL_SQL_TABLE?false:true);
                    if ((fd->StepProfile==TFormDescr::stpMinute))
                      FFF->BitBtnNext->Enabled = false;
                    //END GRB REMOVE 16.07.2019
                    FFF->N2->Visible = false;
                    switch( fd->CodeTemplate )
                    {
                    case 1:
                    case AEBO_REBO_F: // 100 - Переток Активной / Реактивной энергии [МВтч/МВАрч]
                    case AERO_AEDO_F: // 200 - Приём / Отдача Активной энергии [МВтч]
                    case RERO_REDO_F: // 300 - Приём / Отдача Реактивной энергии [МВАрч]
                    case AEBO_REBO_POW_F: // 101 - Переток Активной / Реактивной энергии [МВтч/МВАрч]
                    case AERO_AEDO_POW_F: // 201 - Приём / Отдача Активной энергии [МВтч]
                    case RERO_REDO_POW_F: // 301 - Приём / Отдача Реактивной энергии [МВАрч]
                    case AEBO_F:	// 400 - Переток Активной энергии [кВтч]
                    case AERO_F:    // 500 - Приём Активной энергии [кВтч]
                    case AEDO_F:    // 600 - Отдача Активной энергии [кВтч]
                    case REBO_F:    // 700 - Переток Реактивной энергии [кВАрч]
                    case RERO_F:    // 800 - Приём Реактивной энергии [кВАрч]
                    case REDO_F:    // 900 - Отдача реактивной энергии [кВАрч]
                    case AEBO_POW_F:    // 401 - Переток Активной энергии [кВтч]
                    case AERO_POW_F:    // 501 - Приём Активной энергии [кВтч]
                    case AEDO_POW_F:    // 601 - Отдача Активной энергии [кВтч]
                    case REBO_POW_F:    // 701 - Переток Реактивной энергии [кВАрч]
                    case RERO_POW_F:    // 801 - Приём Реактивной энергии [кВАрч]
                    case REDO_POW_F:    // 901 - Отдача реактивной энергии [кВАрч]
                    /*************** Расходы суммируются по наростающей **************************/
                    case AEBO_REBO_SUM_F: // 102 - Переток Активной / Реактивной энергии [МВтч/МВАрч] Суммируется по наростающей
                    case AERO_AEDO_SUM_F: // 202 - Приём / Отдача Активной энергии [МВтч] Суммируется по наростающей
                    case RERO_REDO_SUM_F: // 302 - Приём / Отдача Реактивной энергии [МВАрч] Суммируется по наростающей
                    case AEBO_SUM_F: // 402 - Переток Активной энергии [кВтч] Суммируется по наростающей
                    case AERO_SUM_F: // 502 - Приём Активной энергии [кВтч] Суммируется по наростающей
                    case AEDO_SUM_F: // 602 - Отдача Активной энергии [кВтч] Суммируется по наростающей
                    case REBO_SUM_F: // 702 - Переток Реактивной энергии [кВАрч] Суммируется по наростающей
                    case RERO_SUM_F: // 802 - Приём Реактивной энергии [кВАрч] Суммируется по наростающей
                    case REDO_SUM_F: // 902 - Отдача реактивной энергии [кВАрч] Суммируется по наростающей
                    /*****************************************************************************/
                    case WATER_F:
                    case GAS_F:
                    case HEAT_F:
                    case AERO_AERA_AERB_AERC_F:	// 910 - Активная принятая общая и по тарифам [кВтч]
                    case AEDO_AEDA_AEDB_AEDC_F: // 920 - Активная отданная общая и по тарифам [кВтч]
                    case RERO_RERA_RERB_RERC_F: // 930 - Реактивная принятая общая и по тарифам [кВАрч]
                    case REDO_REDA_REDB_REDC_F: // 940 - Реактивная отданная общая и по тарифам [кВАрч]
                    case AERA_AERB_AERC_AERD_F: // 950 - Активная принятая по тарифам [кВтч]
                    case AEDA_AEDB_AEDC_AEDD_F: // 960 - Активная отданная по тарифам [кВтч]
                    case RERA_RERB_RERC_RERD_F: // 970 - Реактивная принятая по тарифам [кВАрч]
                    case REDA_REDB_REDC_REDD_F: // 980 - Реактивная отданная по тарифам [кВАрч]
                    // add KAS 20.04.2002
                    case AEBO_AEBA_AEBB_AEBC_F: // 921 Переток активной э/э (общая и по тарифам) [кВтч]
                    case REBO_REBA_REBB_REBC_F: //941 Переток реактивной э/э (общая и по тарифам) [кВарч]
                    // end add
                    case APRO_C: // 10 - Активная мощность (графические формы)
                    case RPRO_C: // 20 - Реактиная мощность
                    case APBO_F: // 30 - Активная Мощность, лимит, отклонение [МВт]
                    case RPBO_F: // 40 - Реактивная Мощность, лимит, отклонение [МВАр]
                    //Баланс add by NNV
                    case BALANCE_F: // 203 - Баланас Активной энергии [МВтч]
                    case BALANCE_POW_F: // 204 - Баланс Активной энергии (ГН, Тех.проф. - мощность)
                    case BALANCE_SUM_F: // 205 - Баланс Активной энергии (Суммируется по наростающей)
                    case NOT_BALANCE: // 206 - Небаланс активной энергии
                    case NOT_BALANCE_AER: // 207 - Небаланс активной энергии
                    case RE_BALANCE_F: // 303 - Баланс Реактивной энергии
                    case RE_BALANCE_POW_F: // 304 - Баланс Реактивной энергии (ГН, Тех.проф. - мощность)
                    case RE_BALANCE_SUM_F: // 305 - Баланс Реактивной энергии (Суммируется по наростающей)
                    case FULL_DATA : //330   //Полнота и своевременность прлучаемых данных
                    //end add NNV

                        FFF->PrintTable->Visible = true;
                        FFF->SaveTableToFile->Visible = true;
                        FFF->N2->Visible = true;
                        FFF->PrintGraph->Visible = true;
                        FFF->SaveGraphToFile->Visible = true;
                        break;
                    case JOURNAL_F: //Журнал действий оператора
                    case JOURNALSYS_F: //Журнал сообщений системы
                        FFF->SaveTableToFile->Visible = true;
                        break;
                    case DU2CHART_PARAMS: //Контроль параметров качества электроэнергии
                        FFF->SaveTableToFile->Visible = true;
                        FFF->PrintTable->Visible = true;
                        FFF->PrintGraph->Visible = true;
                        FFF->SaveGraphToFile->Visible = true;
                        break;
                    default:
                        FFF->PrintTable->Visible = false;
                        FFF->PrintGraph->Visible = false;
                        FFF->SaveGraphToFile->Visible = false;
                    }
                    if((fd->CodeTemplate==APRO_C)||(fd->CodeTemplate==RPRO_C))
                    {
                        FFF->PrintTable->Visible = false;
                        FFF->SaveTableToFile->Visible = false;
                    }
                    if((fd->CodeTemplate==DU_F)||(fd->CodeTemplate==Disturber_F)||(fd->CodeTemplate==ConsumLim_F)||
                        (fd->CodeTemplate==ConsumLim_F__Debt)||(fd->CodeTemplate==ConsumLim_F__Limit)||(fd->CodeTemplate==ConsumLost_F)||
                        (fd->CodeTemplate==AERO_DECAD_F)||(fd->CodeTemplate==ConsumLimDebt_F)||
                        (fd->CodeTemplate==ConsumImbalance_F)||(fd->CodeTemplate==ConsumImbalance_POW_F)||(fd->CodeTemplate==MAKET_F))
                    {
                        FFF->PrintTable->Visible = true;
                        FFF->SaveTableToFile->Visible = true;
                    }
                }
                // end Add **********************************************************************
            }
            catch (Exception &exception)
            {
                //begin Сечин 31.07.01
                fd=NULL;
                //end Сечин
                delete newInterior;
                throw;
            }
            Interior=newInterior;
            Interior->hMutex=hMutex;
            EnterCriticalSection(&ListInteriorCriticalSection);
            //Поместить Interior в список ожидающих обновления
            ListInterior->Add(Interior);
            LeaveCriticalSection(&ListInteriorCriticalSection);
            //chig
        }
        //e chig
    }
    catch (Exception &exception)
    {
        //	Application->ShowException(&exception);
        if(Interior)
        {
            Interior->Destroy();
		    delete Interior;
        }else if(fd){
        //begin Сечин 31.07.01
        //rem delete fd;
            delete fd;
            fd=NULL;
        }
        //end Сечин 31.07.01
        TFormDescr *fd1=new TFormDescr;
        Interior=new TInterior(this,SplitterForm,fd1,OnProgressBarStepBy);
        Interior->hMutex=hMutex;
        OnProgressBarStepBy(NULL);
        Screen->Cursor = crDefault;
        ReleaseMutex(UpdateMonitors); 
        throw;
    }
    if(Message.WParam==0)
    {
        if( isActive )
        {
            TWinControl* p=FindNextControl(NULL,true,true,false);
            if( p)
		        p->SetFocus();
        }
	    else
	        FormActivate(NULL);
    }
    ReleaseMutex(UpdateMonitors);
  //===== 04.07.2005 Frizyuk A.M. Start
  //===== Из-за выноса отчета во "внешний" Excel необходимо удалить форму монитора
/*  try
  { if (Interior)
    { if (dynamic_cast<TInteriorExRepOut *>(Interior))
      { TManForm  *tMForm = dynamic_cast<TManForm *>(this->Owner->Owner);
        if (tMForm)
          tMForm->BitBtnCloseClick(tMForm->BitBtnClose);
      }
    }
  }
  catch (Exception &e)
  {
  }*/
  //===== 04.07.2005 Frizyuk A.M. Finish
}
//---------------------------------------------------------------------------
void __fastcall TBaseMonitorForm::WMSetSpitOrient(TMessage & Message)
{
	Interior->setSplit();
}
//---------------------------------------------------------------------------
void __fastcall TBaseMonitorForm::MaximizeMonitorForm(void)
{
	if( !isMaximized && dynamic_cast<TWinControl*>(Owner) )
	{
		isMaximized=!isMaximized;
		PostMessage( (dynamic_cast<TWinControl*>(Owner))->Handle,WM_MAXSPLTCHILD,
			(WPARAM)0,(LPARAM)this);
		PaintBoxCaption->Invalidate();
	}
}
//---------------------------------------------------------------------------
void __fastcall TBaseMonitorForm::RestoreMonitorForm(void)
{
	if( isMaximized && dynamic_cast<TWinControl*>(Owner) )
	{
		isMaximized=!isMaximized;
		PostMessage( (dynamic_cast<TWinControl*>(Owner))->Handle,WM_RESTSPLTCHILD,
			(WPARAM)0,(LPARAM)this);
		PaintBoxCaption->Invalidate();
	}
}
//---------------------------------------------------------------------------
void __fastcall TBaseMonitorForm::DeleteMonitorForm(void)
{
	if( dynamic_cast<TWinControl*>(Owner) )
		PostMessage( dynamic_cast<TWinControl*>(Owner)->Handle,WM_CLOSESPLTCHILD,
			(WPARAM)0,(LPARAM)this);
}
//---------------------------------------------------------------------------

void __fastcall TBaseMonitorForm::MaximizeClick(TObject *Sender)
{
	MaximizeMonitorForm();
}
//---------------------------------------------------------------------------
void __fastcall TBaseMonitorForm::RestoreClick(TObject *Sender)
{
	RestoreMonitorForm();
}
//---------------------------------------------------------------------------
void __fastcall TBaseMonitorForm::DeleteClick(TObject *Sender)
{
	DeleteMonitorForm();
}
//---------------------------------------------------------------------------
void __fastcall TBaseMonitorForm::PaintBoxCaptionDblClick(TObject *Sender)
{
	if( isMaximized )
		RestoreMonitorForm();
	else
		MaximizeMonitorForm();
}
//---------------------------------------------------------------------------
void __fastcall TBaseMonitorForm::HideGraphicsClick(TObject *Sender)
{
	if(SplitterForm->Splitter)
	{
		((TMenuItem*)Sender)->Checked=!((TMenuItem*)Sender)->Checked;
		SplitterForm->Splitter->Tag=0x00000000;
		if( HideGraphics->Checked )
			SplitterForm->Splitter->Tag|=0x00010000;
		if( HideTable->Checked )
			SplitterForm->Splitter->Tag|=0x00000001;
		if( SplitterForm->Splitter->Tag==0x00000000 )
		if( (long)Sender==(long)HideGraphics )
		{
			SplitterForm->Splitter->Tag=0x00000001;
			HideTable->Checked=true;
		}
		else
		{
			SplitterForm->Splitter->Tag=0x00010000;
			HideGraphics->Checked=true;
		}
		SplitterForm->SplitFormResize(NULL);
	}
}
//---------------------------------------------------------------------------
bool __fastcall TBaseMonitorForm::SaveMonitorForm( TStream* ostream )
{
	TFormDescr *fd=GetFormDescr();
	if( !fd->SaveFormDescr( ostream ) )
		return false;
	try{
		ostream->WriteBuffer( &isSmallFont, sizeof(bool) );
	}
	catch(Exception &e)
	{
		isSmallFont=true;
	}
	return true;
}
//---------------------------------------------------------------------------
bool __fastcall TBaseMonitorForm::LoadMonitorForm( TStream* istream )
{
  TFormDescr  *fd = new TFormDescr;
	if (!fd->LoadFormDescr(istream))
	{ delete  fd;
		return  false;
	}
  //===== 21.07.2005 Frizyuk A.M. Start
  try{
   //GRB ADD 16.04.2020 - test trouble ODAC
   dmMain->quMain->Params->Clear();
   //END ADD 
   dmMain->quMain->SQL->Text=" begin "+SchemeName+"interior_pg.MonitorForm_LoadMonitorForm_p(:par1,:par2);end;";
   dmMain->quMain->ParamByName("par1")->AsInteger=fd->CodeTemplate;
   dmMain->quMain->ParamByName("par2")->AsInteger=fd->IdFormTree;
   dmMain->quMain->Execute();
   fd->CodeTemplate=dmMain->quMain->ParamByName("par1")->AsInteger;
   dmMain->quMain->Close();
  }
  catch (Exception &e)
  {
  }

  //===== 21.07.2005 Frizyuk A.M. Finish
  fd->DateTime = (int)TDateTime::CurrentDateTime();
  fd->DateTimePar = fd->DateTime-1;
	try
  { istream->ReadBuffer(&isSmallFont, sizeof(bool));
	}
  catch (Exception &e)
  { isSmallFont = true;
	}
  // перед любым обновлением мониторов необходимо инициализировать кр. секцию UpdateMonitors
  while (WaitForSingleObject(UpdateMonitors, 0) != WAIT_OBJECT_0)
  { Application->ProcessMessages();   // если не удалось иниц-ть. CS то обновить экранные формы...
    Sleep(0);                         // переключить управление на другой поток, кот занял CS
  }
  // add by KSS
	PostMessage(Handle, WM_REFRESHFORM, 1, (LPARAM)fd);
	return  true;
}
//---------------------------------------------------------------------------
void __fastcall TBaseMonitorForm::PopupMenuBaseFormPopup(TObject *Sender)
{
    if( Interior && dynamic_cast<T2xDrawTableChartInterior*>(Interior) )
	{
        View->Enabled=true;
		ChartFXColumns->Enabled=true;
		ChartFXLines->Enabled=true;
		ByGroup->Enabled=true;
		ByProfile->Enabled=true;
    IsValid->Enabled=true;
	}
	else
	{
		View->Enabled=false;
		ChartFXColumns->Enabled=false;
		ChartFXLines->Enabled=false;
		ByGroup->Enabled=false;
		ByProfile->Enabled=false;
    IsValid->Enabled=false;
	}
	SmallFont->Checked=!isSmallFont;
	SmallFont2->Checked=!isSmallFont;
}
//---------------------------------------------------------------------------
void __fastcall TBaseMonitorForm::LabelCommentMouseUp(TObject *Sender,
	TMouseButton Button, TShiftState Shift, int X, int Y)
{
    if(Interior && dynamic_cast<T2xDrawTableChartInterior*>(Interior)
		&& Button==Controls::mbRight && PopupMenu)
    {
	    POINT p;
		p.x=X;
		p.y=Y;
		p=LabelComment->ClientToScreen(p);
		PopupMenu->Popup(p.x,p.y);
	}
}
//---------------------------------------------------------------------------
void __fastcall TBaseMonitorForm::PanelClick(TObject *Sender)
{
#define PopUpMenu ((TMenuItem*)Sender)
	if(isMaximized)
	{
		PopUpMenu->Items[0]->Enabled=false;
		PopUpMenu->Items[1]->Enabled=true;
	}
	else
	{
		PopUpMenu->Items[0]->Enabled=true;
		PopUpMenu->Items[1]->Enabled=false;
	}
#undef PopUpMenu
}
//---------------------------------------------------------------------------
void __fastcall TBaseMonitorForm::ViewClick(TObject *Sender)
{
    HideGraphics->Checked=true;
    HideTable->Checked=true;
    if(LOWORD(SplitterForm->Splitter->Tag)==0)
        HideTable->Checked=false;
	if(HIWORD(SplitterForm->Splitter->Tag)==0)
        HideGraphics->Checked=false;
}
//---------------------------------------------------------------------------

void __fastcall TBaseMonitorForm::FormClose(TObject *Sender,
	TCloseAction &Action)
{
	Action = caFree;
	if(hMutex==NULL)
		return;
	EnterCriticalSection(&ListInteriorCriticalSection);
	//Удалить Interior из списка ожидающих обновления
	ListInterior->Remove(Interior);
	LeaveCriticalSection(&ListInteriorCriticalSection);
	if( WaitForSingleObject(hMutex,INFINITE)==WAIT_OBJECT_0 )
	{
        if(Interior) Interior->hMutex=NULL;
		ReleaseMutex(hMutex);
	}
	CloseHandle(hMutex);
	hMutex=NULL;
}
//---------------------------------------------------------------------------
void __fastcall TBaseMonitorForm::SmallFontClick(TObject *Sender)
{
#define Sender ((TMenuItem*)Sender)
	isSmallFont=!isSmallFont;
	Sender->Checked=!Sender->Checked;
    PostMessage(Handle,WM_REFRESHFORM,0,(LPARAM)new TFormDescr(*Interior->fd));
#undef Sender
}
//---------------------------------------------------------------------------

inline TFormDescr* TBaseMonitorForm::GetFormDescr(void)
{
  	return Interior->GetFormDescr();
}
//---------------------------------------------------------------------------


