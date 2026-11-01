//---------------------------------------------------------------------------
#ifndef Interior6H
#define Interior6H
//---------------------------------------------------------------------------
#include "Interior4.h"
//---------------------------------------------------------------------------
class T6Interior : public T4Interior
{
	public:
		__fastcall T6Interior(TComponent* Owner,TSplitterForm *,
			TFormDescr*,Classes::TNotifyEvent );
		virtual __fastcall ~T6Interior(void);
		virtual void __fastcall selectData( TOraQuery *qwInter  );
		//virtual void __fastcall formDescr( void );
		virtual long __fastcall SubColumns(void);
	 
   virtual AnsiString __fastcall GetSubColumnsNames(int);
                virtual AnsiString __fastcall GetUnitOfEnergy();
                //add by NNV
            //    void __fastcall ChoiceOfTable( AnsiString &oracletable );
                //end add by NNV
};
//---------------------------------------------------------------------------
#endif
