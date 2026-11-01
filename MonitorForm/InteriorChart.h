//---------------------------------------------------------------------------
#ifndef InteriorChartH
#define InteriorChartH
//---------------------------------------------------------------------------
#include "Interior.h"
//---------------------------------------------------------------------------
class TChartInterior : public TInterior
{
	private:
                TPopupMenu *OwnerMenu;
	protected:
		TChart *pChart;
		TStrings *NamesClones;//имена клонов
		long Clones;//общее количество клонов в таблице
		TCloneItem *datOracle;//Двумерный массив всегда содержащий суммарный клон и столбец
						 //Клоны расположены по столбцам.
	public:

		__fastcall TChartInterior(TComponent* Owner,TSplitterForm *,TFormDescr*,Classes::TNotifyEvent );
		virtual __fastcall ~TChartInterior(void);

		//Снятие со SplitterFom таблицы и графика, вызываемтся при обновлении TBaseMonitorForm
		virtual void __fastcall Destroy(void);
		virtual void __fastcall Place(void);

		//Возвращает количесиво подколонок для формы
		virtual long __fastcall SubColumns(void);

		//Обновление данных из базы
		//NameAlert=-1 для обновления в любом случае
		virtual void __fastcall refreshData( int Table,TOraQuery *qwInter  );
		virtual void __fastcall selectData( TOraQuery *qwInter );
		virtual void __fastcall Invalidate( int Table );

		//Получает данные о считываемой таблице
		virtual void __fastcall formDescr( void );

		//Строит линейный график для указанного клона
		void __fastcall ChartFXLines(long AClone);
// Add KAS 11.02.02
 		virtual void __fastcall PrintGraph();
	    	virtual void __fastcall SaveGraphToFile(TSaveDialog *aSaveDialog);
                virtual AnsiString __fastcall GetUnitOfEnergy();

// end Add

          void __fastcall PopupMenuBaseFormPopup(TObject *Sender);
};
//---------------------------------------------------------------------------
#endif
