//---------------------------------------------------------------------------
#ifndef Interior4H
#define Interior4H
//---------------------------------------------------------------------------
#include "Interior2.h"
//---------------------------------------------------------------------------
class T4Interior : public T2Interior
{
	public:
		__fastcall T4Interior(TComponent* Owner,TSplitterForm *,
			TFormDescr*,Classes::TNotifyEvent );
		virtual __fastcall ~T4Interior(void);
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
