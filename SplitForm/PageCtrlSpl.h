//---------------------------------------------------------------------------
#ifndef PageCtrlSplH
#define PageCtrlSplH
//---------------------------------------------------------------------------
#include "SplitForm.h"
#include "MONITORFORM.h"
//---------------------------------------------------------------------------
class TPageCtrlSplt : public TPageControl
{
public:
	__fastcall virtual TPageCtrlSplt(Classes::TComponent* AOwner);
	__fastcall virtual ~TPageCtrlSplt(void);
protected:
	TPanel * EmptyPanel;
	TSplitterBaseMonitorForm* SplitterForm;
	TTabSheet *TabSheetSplit;
	TTabSheet *TabSheetMax;
	TBaseMonitorForm* FcurForm;
protected:
	void __fastcall SetCurForm(TBaseMonitorForm* );
	__property TBaseMonitorForm* curForm={read=FcurForm,write=SetCurForm};
	void __fastcall WMDeactiveSpltChild(TMessage & Message);
	void __fastcall WMActiveSpltChild(TMessage & Message);
	void __fastcall WMMaxSpltCild(TMessage & Message);
	void __fastcall WMRestSpltChild(TMessage & Message);
	void __fastcall WMCloseSpltChild(TMessage & Message);
	void __fastcall WMRefreshData(TMessage & Message);
	BEGIN_MESSAGE_MAP
		MESSAGE_HANDLER(WM_DEACTIVESPLTCHILD, TMessage, WMDeactiveSpltChild)
		MESSAGE_HANDLER(WM_ACTIVESPLTCHILD, TMessage, WMActiveSpltChild)
		MESSAGE_HANDLER(WM_MAXSPLTCHILD, TMessage, WMMaxSpltCild)
		MESSAGE_HANDLER(WM_RESTSPLTCHILD, TMessage, WMRestSpltChild)
		MESSAGE_HANDLER(WM_CLOSESPLTCHILD, TMessage, WMCloseSpltChild)
		MESSAGE_HANDLER(WM_REFRESHDATA, TMessage, WMRefreshData)
	END_MESSAGE_MAP(TPageControl)
public:
	void __fastcall AddChild( TBaseMonitorForm* AControl,TAlign AAlign );
	void __fastcall RemoveChild( void );
	void __fastcall MaximizeChild( void );
	void __fastcall RestoreChild();
	__property TBaseMonitorForm* CurrentForm={read=FcurForm};
	void __fastcall Init(void);
	bool __fastcall Save( TStream* );
	bool __fastcall Load( TStream* ,Classes::TNotifyEvent OnProgr );
	TBaseMonitorForm* __fastcall GoNextForm( void );
	TBaseMonitorForm* __fastcall GoPreviosForm( void );
public:
	Classes::TList* listMonitorForms;
};
//extern TPageCtrlSplt *PageCtrlSplt;
#endif
