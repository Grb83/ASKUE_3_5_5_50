//---------------------------------------------------------------------------
#ifndef Interior2H
#define Interior2H
//---------------------------------------------------------------------------
#include "Interior2xDrawTableChart.h"
//---------------------------------------------------------------------------
class T2Interior : public T2xDrawTableChartInterior
{
	public:
		__fastcall T2Interior(TComponent* Owner,TSplitterForm *,
			TFormDescr*,Classes::TNotifyEvent );
		virtual __fastcall ~T2Interior(void);
		virtual void __fastcall selectData( TOraQuery *qwInter );
		virtual void __fastcall formDescr( void );
		virtual long __fastcall SubColumns(void);
   virtual AnsiString __fastcall GetSubColumnsNames(int);
                //add by NNV
             //   void __fastcall ChoiceOfTable( AnsiString &oracletable );
             //   void __fastcall ChoiceOfTimeDiap(AnsiString &grouping, char *FirstDate, char *LastDate);
                void __fastcall ChoiceOfTimeDiap( char *FirstDate, char *LastDate);
                void __fastcall CheckPrecipice(int rowCount, int iClones, int SubColumns, int Clones, TCloneItem *datOracle);
                //end add by NNV
};
//---------------------------------------------------------------------------
#endif
