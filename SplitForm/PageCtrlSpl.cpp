//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#include "Monitor.h"
#include "PageCtrlSpl.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------

__fastcall TPageCtrlSplt::TPageCtrlSplt(Classes::TComponent* AOwner):
	TPageControl(AOwner),EmptyPanel(NULL),SplitterForm(NULL),FcurForm(NULL),
    TabSheetSplit(NULL),TabSheetMax(NULL)
{
	listMonitorForms= new Classes::TList();
	listMonitorForms->Capacity=16;
}
//---------------------------------------------------------------------------

void __fastcall TPageCtrlSplt::Init(void)
{
	TabSheetMax=new TTabSheet(this);
	TabSheetMax->TabVisible=false;
	TabSheetMax->TabStop=false;
	TabSheetMax->PageControl=this;

	TabSheetSplit=new TTabSheet(this);
	TabSheetSplit->TabVisible=false;
	TabSheetSplit->TabStop=false;
	TabSheetSplit->PageControl=this;

	ActivePage=TabSheetSplit;

	EmptyPanel=new TPanel(this);
	EmptyPanel->Parent=TabSheetMax;
	EmptyPanel->TabStop=false;
	EmptyPanel->Align=alClient;

	SplitterForm=new TSplitterBaseMonitorForm(this);
	SplitterForm->Align=alClient;
	SplitterForm->Parent=TabSheetSplit;
	SplitterForm->Show();
}
//---------------------------------------------------------------------------
__fastcall TPageCtrlSplt::~TPageCtrlSplt(void)
{
    delete listMonitorForms;
}
//---------------------------------------------------------------------------
void __fastcall TPageCtrlSplt::AddChild( TBaseMonitorForm* AControl,TAlign AAlign )
{
	if(AControl==NULL)
		return;
	if(ActivePage==TabSheetMax)
		RestoreChild();
	SplitterForm->AddChild(curForm,AControl,AAlign);
	listMonitorForms->Add(AControl);
	curForm=AControl;
}
//---------------------------------------------------------------------------
void __fastcall TPageCtrlSplt::RemoveChild(void)
{
	int delIndex;
	TBaseMonitorForm* del;
	if( FcurForm==NULL )
		return;
	if(ActivePage==TabSheetMax)
		RestoreChild();
	delIndex=listMonitorForms->IndexOf( curForm );
	del=curForm;
	SplitterForm->RemoveChild( curForm );
	listMonitorForms->Delete( delIndex );
	if( listMonitorForms->Count )
	{
		delIndex=( delIndex < listMonitorForms->Count )? delIndex : 0;
		FcurForm=(TBaseMonitorForm* )listMonitorForms->Items[delIndex];
		PostMessage(curForm->Handle,WM_SPLTSETFOCUS,0,0);
	}
	else
		FcurForm=NULL;
	delete del;
}
//---------------------------------------------------------------------------
void __fastcall TPageCtrlSplt::MaximizeChild( void )
{
	if( listMonitorForms->Count>1 && ActivePage==TabSheetSplit )
	{
			ActivePage=TabSheetMax;
			SplitterForm->MaximizeChild( curForm,TabSheetMax );
	}
	PostMessage(curForm->Handle,WM_SPLTSETFOCUS,1,0);
}
//---------------------------------------------------------------------------
void __fastcall TPageCtrlSplt::RestoreChild()
{
	if( listMonitorForms->Count>1 && ActivePage==TabSheetMax )
	{
		SplitterForm->MaximizeChild( EmptyPanel,TabSheetMax );
		ActivePage=TabSheetSplit;
	}
	PostMessage(curForm->Handle,WM_SPLTSETFOCUS,0,0);
}
//---------------------------------------------------------------------------
void __fastcall TPageCtrlSplt::WMDeactiveSpltChild(TMessage & Message)
{
	//curForm=NULL;
}
//---------------------------------------------------------------------------
void __fastcall TPageCtrlSplt::WMActiveSpltChild(TMessage & Message)
{
	if( curForm!=(TBaseMonitorForm*)Message.LParam )
		curForm=(TBaseMonitorForm*)Message.LParam;
}
//---------------------------------------------------------------------------
void __fastcall TPageCtrlSplt::WMMaxSpltCild(TMessage & Message)
{
	curForm=(TBaseMonitorForm*)Message.LParam;
	MaximizeChild();
}
//---------------------------------------------------------------------------
void __fastcall TPageCtrlSplt::WMRestSpltChild(TMessage & Message)
{
	RestoreChild();
}
//---------------------------------------------------------------------------
void __fastcall TPageCtrlSplt::WMCloseSpltChild(TMessage & Message)
{
	if( listMonitorForms->IndexOf((void*)Message.LParam)!=-1 )
	{
		if( curForm!=(TBaseMonitorForm* )Message.LParam )
		{
			SplitterForm->RemoveChild( (TBaseMonitorForm* )Message.LParam );
			listMonitorForms->Remove( (TBaseMonitorForm* )Message.LParam );
			delete (TBaseMonitorForm* )Message.LParam;
		}
		else
			RemoveChild();
	}
}
//---------------------------------------------------------------------------
void __fastcall TPageCtrlSplt::SetCurForm(TBaseMonitorForm* newForm )
{
    if( FcurForm==newForm )
		return;
	if( newForm )
	{
		if( listMonitorForms->IndexOf(newForm)==-1 )
			throw( Exception(Reconst_smes131_1));
		if( FcurForm!=NULL )
			SendNotifyMessage(FcurForm->Handle,WM_SPLTKILLFOCUS,0,0);
		SendNotifyMessage(newForm->Handle,WM_SPLTSETFOCUS,(ActivePage==TabSheetMax?1:0),0);
	}
	else
	{
		//listMonitorForms->Pack();
		if( listMonitorForms->Count )
			throw( Exception(Reconst_smes131_2));
	}
	FcurForm = newForm;
// Add KAS 12.02.2002 ***********************************************************
    TManForm *FFF = dynamic_cast<TManForm*>(Owner);
    if(FFF)
    {
        FFF->N2->Visible = false;
        FFF->PrintRep->Visible = false;
        FFF->SaveRepToFile->Visible = false;
        FFF->PrintGraph->Visible = false;
        FFF->SaveGraphToFile->Visible = false;
        switch(FFF->PageCtrlSplt->CurrentForm->Interior->fd->CodeTemplate)
        {
        case EXCEL_REP_F:
        case EXCEL_F:
        case EXCEL_OP_FORM:
            FFF->N2->Visible = true;
            FFF->PrintRep->Visible = true;
            FFF->SaveRepToFile->Visible = true;
            break;
        case AEBO_REBO_F: // 100 - Переток Активной / Реактивной энергии [МВтч/МВАрч]
        case AERO_AEDO_F: // 200 - Приём / Отдача Активной энергии [МВтч]
        case RERO_REDO_F: // 300 - Приём / Отдача Реактивной энергии [МВАрч]
        case AEBO_F:	// 400 - Переток Активной энергии [кВтч]
        case AERO_F:    // 500 - Приём Активной энергии [кВтч]
        case AEDO_F:    // 600 - Отдача Активной энергии [кВтч]
        case REBO_F:    // 700 - Переток Реактивной энергии [кВАрч]
        case RERO_F:    // 800 - Приём Реактивной энергии [кВАрч]
        case REDO_F:    // 900 - Отдача реактивной энергии [кВАрч]
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
        case APRO_C: // 10 - Активная мощность (графические формы)
        case RPRO_C: // 20 - Реактиная мощность
        case MAKET_F: // 1450 - Макет 30817
//Баланс add by NNV
        case BALANCE_F: // 203 - Баланас Активной энергии [МВтч]
        case BALANCE_SUM_F: // 205 - Баланс Активной энергии (Суммируется по наростающей)
        case RE_BALANCE_F: // 303 - Баланс Реактивной энергии
        case RE_BALANCE_SUM_F: // 305 - Баланс Реактивной энергии (Суммируется по наростающей)
//end add by NNV
            FFF->N2->Visible = true;
            FFF->PrintGraph->Visible = true;
            FFF->SaveGraphToFile->Visible = true;
            break;
                //ADD BY GRB
        case PL_SQL_MANY_TABLE: // 1208 - Житомирская таблица
            FFF->SaveMultyTableToFile->Visible = true;
            FFF->SaveMultyTableToFile->Enabled = true;
            break;

        }
    }
// end Add **********************************************************************
}
//---------------------------------------------------------------------------
bool __fastcall TPageCtrlSplt::Save( TStream* ostream )
{
	RestoreChild();
	if( SplitterForm->SaveSplitter( ostream )==true )
		return true;
	return false;
}
//---------------------------------------------------------------------------
bool __fastcall TPageCtrlSplt::Load( TStream* istream, Classes::TNotifyEvent OnProgr )
{
	if(curForm)
	{
	RestoreChild();
	while( curForm )
		RemoveChild();
	}
	if( SplitterForm->LoadSplitter( istream, OnProgr,listMonitorForms ) )
	{
		for( int i=1 ; i<listMonitorForms->Count ; ++i )
			PostMessage(((TBaseMonitorForm*)listMonitorForms->Items[i])->Handle,
				WM_SPLTKILLFOCUS,0,0);
		if(listMonitorForms->Count)
		curForm=(TBaseMonitorForm*)listMonitorForms->Items[0];
		SplitterForm->SplitFormResize(NULL);
		return true;
	}
	return false;
}
//---------------------------------------------------------------------------
TBaseMonitorForm* __fastcall TPageCtrlSplt::GoNextForm( void )
{
	int index=listMonitorForms->IndexOf(curForm);
	if( index<=listMonitorForms->Count-1 && index>=0 )
	{
		if(index==listMonitorForms->Count-1)
			index=-1;
		if(ActivePage==TabSheetMax)
		{
			SplitterForm->MaximizeChild( EmptyPanel,TabSheetMax );
			SplitterForm->MaximizeChild( (TBaseMonitorForm*)listMonitorForms->Items[index+1],TabSheetMax );
			curForm=(TBaseMonitorForm*)listMonitorForms->Items[index+1];
		}
		else
			curForm=(TBaseMonitorForm*)listMonitorForms->Items[index+1];
	}
	return curForm;
}
//---------------------------------------------------------------------------
TBaseMonitorForm* __fastcall TPageCtrlSplt::GoPreviosForm( void )
{
	int index=listMonitorForms->IndexOf(curForm);
	if( index>=0 )
	{
		if(index==0)
			index=listMonitorForms->Count;
		if(ActivePage==TabSheetMax)
		{
			SplitterForm->MaximizeChild( EmptyPanel,TabSheetMax );
			SplitterForm->MaximizeChild( (TBaseMonitorForm*)listMonitorForms->Items[index-1],TabSheetMax );
			curForm=(TBaseMonitorForm*)listMonitorForms->Items[index-1];
		}
		else
			curForm=(TBaseMonitorForm*)listMonitorForms->Items[index-1];
	}
	return curForm;
}
//---------------------------------------------------------------------------
void __fastcall TPageCtrlSplt::WMRefreshData(TMessage & Message)
{
	int i=0;
	for( ; i<listMonitorForms->Count ; ++i )
	{
		PostMessage(((TBaseMonitorForm*)listMonitorForms->Items[i])->Handle,WM_REFRESHDATA,Message.WParam,Message.LParam);
		++refreshDataCount;
	}
}
//---------------------------------------------------------------------------

