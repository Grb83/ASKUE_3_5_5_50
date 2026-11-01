/////////////////////////////////////////////////////////////////////////////
// FILE        : InteriorAlert.cpp
// SUBSYSTEM   : ASCUE/SuperMainForm
// AUTHORS     : Valeriy V. Bludov (BlVal)
// CREATED     : 07/20/2002
// REQUIRES    : [%3]
// CONTAINS    :
//      constants
//      typedefs
//      class names
//      procedure names
// DESCRIPTION :
//      Невизуальный компонент для получения событий об обновлении таблицы
//      системных сообщений. Событие приходит от фоновой нити выполнения
//      MonitorAlert. Сообщение об обновлении передается главному окну приложения
//      для обновления статусов.
// REVISIONS   :
//      MM/DD/YY - (Author) Description
/////////////////////////////////////////////////////////////////////////////
#include <vcl.h>
#pragma hdrstop
#include "InteriorAlert.h"
#include "unDataMod.h"
#include "SupperMain.h"
/////////////////////////////////////////////////////////////////////////////
//Глобальный список компонентов, получающих сообщения об обновленях таблиц
extern TList *ListInterior;

//Глобальный обект для синхронизации исключения членов из очереди наблюдателей
extern CRITICAL_SECTION ListInteriorCriticalSection;
/////////////////////////////////////////////////////////////////////////////
// TInteriorAlert::TInteriorAlert - constructor
// TAKES:
//      none
// RETURNS:
//      none
/////////////////////////////////////////////////////////////////////////////
__fastcall TInteriorAlert::TInteriorAlert(TComponent* Owner):TInterior(Owner)
{
	fd                  = new TFormDescr;
	SplitterForm        = NULL;
	OnProgressBarStepBy = NULL;
	VT_PrintData        = NULL;
	VT_PrintData        = NULL;
	hMutex              = CreateMutex( NULL, FALSE, NULL );

	//Поместить экземпляр в список ожидающих обновления
        if( hMutex )
        {
                //Без мьютекса компонент не будет получать сообщения об обновлении таблиц
        	EnterCriticalSection(&ListInteriorCriticalSection);
	        ListInterior->Add( this );
        	LeaveCriticalSection(&ListInteriorCriticalSection);
        }
   // Add by KSS - посылаем инициализирующее сообщение ...
}
/////////////////////////////////////////////////////////////////////////////
// TInteriorAlert::~TInteriorAlert - destructor
// TAKES:
//      none
// RETURNS:
//      none
/////////////////////////////////////////////////////////////////////////////
__fastcall TInteriorAlert::~TInteriorAlert(void)
{
        if ( hMutex )
        {
        	EnterCriticalSection( &ListInteriorCriticalSection );
	        ListInterior->Remove( this );
        	LeaveCriticalSection( &ListInteriorCriticalSection );

                CloseHandle( hMutex );
                hMutex = NULL;
        }
}
/////////////////////////////////////////////////////////////////////////////
// TInteriorAlert::refreshData - <reference name>
// TAKES:
//      Table     - [in] код таблицы от которой получен сигнал об обновлении
//      oraCursor - [in]
// RETURNS:
//      none
// ASSUMES:
//      Additional requirements to arguments and calculatioanl environment
// EFFECTS:
//      Side effects
// NOTES:
//      Any useful (or of no use) comments
/////////////////////////////////////////////////////////////////////////////
void __fastcall TInteriorAlert::refreshData( int Table, TOraQuery *quMain )
{
	extern TSupperMainForm *SupperMainForm;
	AnsiString sql;
	int iFlag = 0, state;
   LPARAM lParam = 0;

	if ( Table == 4){
		// Обрыв связи
    quMain->Params->Clear();
    quMain->SQL->Text = " begin "+SchemeName+"interior_pg.InteriorAlert_refreshData1_p(:par1);end;";
    quMain->ParamByName("par1")->DataType=ftCursor;
    quMain->ParamByName("par1")->ParamType=ptOutput;
    quMain->Execute();
    iFlag=quMain->FieldByName("iFlag")->AsInteger;
    quMain->Close();
		if( iFlag )
			lParam |= 0x04;
		else
			lParam &= 0xFFFFFFFB;
		// Предупреждение
    quMain->Params->Clear();
    quMain->SQL->Text = " begin "+SchemeName+"interior_pg.InteriorAlert_refreshData2_p(:par1);end;";
    quMain->ParamByName("par1")->DataType=ftCursor;
    quMain->ParamByName("par1")->ParamType=ptOutput;
   	quMain->Execute();
    iFlag=quMain->FieldByName("iFlag")->AsInteger;
    quMain->Close();
		if( iFlag )
			lParam |= 0x02;
		else
			lParam &= 0xFFFFFFFD;

		// Сообщение
    quMain->Params->Clear();
    quMain->SQL->Text = " begin "+SchemeName+"interior_pg.InteriorAlert_refreshData3_p(:par1);end;";
    quMain->ParamByName("par1")->DataType=ftCursor;
    quMain->ParamByName("par1")->ParamType=ptOutput;
    quMain->Execute();
    iFlag=quMain->FieldByName("iFlag")->AsInteger;
    quMain->Close();
		if( iFlag )
			lParam |= 0x01;
		else
			lParam &= 0xFFFFFFFE;

    quMain->Params->Clear();
    quMain->SQL->Text = " begin :par1 :="+SchemeName+"CTS_PG.is_showe; end;";
    quMain->ParamByName("par1")->DataType=ftInteger;
    quMain->ParamByName("par1")->ParamType=ptOutput;
    quMain->Execute();
    iFlag=quMain->ParamByName("par1")->AsInteger;
    quMain->Close();
		if( iFlag )
			lParam |= 0x08;
		else
			lParam &= 0xFFFFFFFF;
	}
  PostMessage( SupperMainForm -> Handle, WM_UPDATE_SPEED_BUTTON, Table, lParam );
}
/////////////////////////////////////////////////////////////////////////////

