//---------------------------------------------------------------------------
#ifndef Interior1H
#define Interior1H
//---------------------------------------------------------------------------
#include "Interior2.h"
//---------------------------------------------------------------------------
class T1Interior : public T2Interior
{
	public:
		__fastcall T1Interior(TComponent* Owner,TSplitterForm *,
			TFormDescr*,Classes::TNotifyEvent );
		virtual __fastcall ~T1Interior(void);
		virtual void __fastcall selectData( TOraQuery *qwInter );
		//virtual void __fastcall formDescr( void );
		virtual long __fastcall SubColumns(void);
	
   virtual AnsiString __fastcall GetSubColumnsNames(int);
                virtual AnsiString __fastcall GetUnitOfEnergy();
};
//---------------------------------------------------------------------------
#endif
