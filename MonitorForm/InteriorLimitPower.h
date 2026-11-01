//---------------------------------------------------------------------------
#ifndef InteriorLimitPowerH
#define InteriorLimitPowerH
//---------------------------------------------------------------------------
#include "Interior2xDrawTableChart.h"
//---------------------------------------------------------------------------
class TLimitPowerInterior : public T2xDrawTableChartInterior
{
	public:
		__fastcall TLimitPowerInterior(TComponent* Owner,TSplitterForm *,
			TFormDescr*,Classes::TNotifyEvent );
		virtual __fastcall ~TLimitPowerInterior(void);
		virtual void __fastcall refreshData( int Table,TOraQuery *qwInter );
		virtual void __fastcall selectData(TOraQuery *qwInter );
		virtual void __fastcall formDescr( void );
		virtual long __fastcall SubColumns(void);

    virtual AnsiString __fastcall GetSubColumnsNames(int);
		virtual void __fastcall clonesInColumns(void);
		virtual void __fastcall clonesInRows(void);
		virtual void __fastcall ChartFXColumns(long ARow);
		virtual void __fastcall ChartFXLines(long AClone);
		virtual void __fastcall Place(void);
		void __fastcall PopupMenuBaseFormPopup(TObject *Sender);
		void __fastcall ChartFXGetLegend(System::TObject* Sender,
			short nType, short &nRes);
                virtual AnsiString __fastcall GetUnitOfEnergy();

};
//---------------------------------------------------------------------------
#endif
