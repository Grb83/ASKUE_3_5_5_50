//---------------------------------------------------------------------------
#ifndef InteriorLimConsDebtH
#define InteriorLimConsDebtH

#include "InteriorDU.h"
#include "Filter.h"
//---------------------------------------------------------------------------
class TConsumLimitDebt : public TDUInterior
{
	public:
		__fastcall TConsumLimitDebt(TComponent* Owner,TSplitterForm *,TFormDescr*,Classes::TNotifyEvent,bool B_and_W );
		virtual __fastcall ~TConsumLimitDebt(void);

		//Снятие со SplitterFom и размещение на SplitterFom таблицы и графика,
		//вызываемтся при обновлении TBaseMonitorForm
		virtual void __fastcall Place(void);

		//Возвращает количесиво подколонок для формы
		virtual long __fastcall SubColumns(void){return 6;};

		//Возвращает имена подколонок для формы
		virtual AnsiString __fastcall GetSubColumnsNames(int);

		//Формирует таблицу, располагая клоны по столбцам
		virtual void __fastcall clonesInColumns(void);
		virtual void __fastcall dataInColumns(void);

		//Обновление данных из базы
		//NameAlert=-1 для обновления в любом случае
		virtual void __fastcall refreshData( int Table,TOraQuery *qwInter );
		virtual void __fastcall selectData( TOraQuery *qwInter );
		virtual void __fastcall Invalidate( int Table );

		//Получает данные о считываемой таблице
		virtual void __fastcall formDescr( void );

		//Интерпритирует счелчок пользователь на таблице,
		//и проводит декомпозицию по группе
		//virtual void __fastcall clickComposition(long ACol, long ARow );
		virtual void __fastcall clickDialog(long ACol, long ARow );
		void __fastcall OnClickMenuItemAttr(TObject *Sender);
		void __fastcall OnSelectCell(TObject* Sender, int Col, int Row, bool &CanSelect);
		void __fastcall OnPopupMenuDU(TObject *Sender);
};
//---------------------------------------------------------------------------
#endif
