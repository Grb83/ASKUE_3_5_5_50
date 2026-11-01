//---------------------------------------------------------------------------
#ifndef MonitorAlertH
#define MonitorAlertH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include "MonitorForm.h"
//---------------------------------------------------------------------------
class TMonitorAlert : public TThread
{
private:
protected:
	void __fastcall Execute();
public:
	__fastcall TMonitorAlert(bool CreateSuspended);
   __fastcall ~TMonitorAlert();
};
//---------------------------------------------------------------------------
extern CRITICAL_SECTION ListInteriorCriticalSection;
extern TList *ListInterior;
//---------------------------------------------------------------------------
#endif
