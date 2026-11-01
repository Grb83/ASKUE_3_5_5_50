//---------------------------------------------------------------------------
#ifndef InteriorDecadH
#define InteriorDecadH
//---------------------------------------------------------------------------
#include "InteriorDU.h"
#include "MonitorForm.h"
#include <stdio.h>
//---------------------------------------------------------------------------
class TDecadInterior : public TDUInterior
{
        protected:
                 AnsiString NameCol1,NameCol2,NameCol3;
	public:
		__fastcall TDecadInterior(TComponent* Owner,TSplitterForm *,TFormDescr*,Classes::TNotifyEvent,bool B_and_W );
		virtual __fastcall ~TDecadInterior(void);

		//Снятие со SplitterFom и размещение на SplitterFom таблицы и графика,
		//вызываемтся при обновлении TBaseMonitorForm
//		virtual void __fastcall Destroy(void);
		virtual void __fastcall Place(void);
/*
		//Установить новую компановку
		virtual bool __fastcall setSplit(void);
                                                     */
		//Возвращает количесиво подколонок для формы
		virtual long __fastcall SubColumns(void){return 3;};

		///Возвращает имена подколонок для формы
		virtual AnsiString __fastcall GetSubColumnsNames(int);

	     	//Обновление данных из базы
		//NameAlert=-1 для обновления в любом случае
		virtual void __fastcall refreshData( int Table,TOraQuery *qwInter );
	     	virtual void __fastcall selectData( TOraQuery *qwInter );
	     	virtual void __fastcall Invalidate( int Table );
		//Получает данные о считываемой таблице
		virtual void __fastcall formDescr( void );
           
		//Формирует таблицу, располагая клоны по столбцам
		virtual void __fastcall clonesInColumns(void);
	     	virtual void __fastcall dataInColumns(void);
             
		//Интерпритирует счелчок пользователь на таблице,
		//и проводит декомпозицию по группе
		virtual void __fastcall clickComposition(long ACol, long ARow );

	   /*	//Событийные обработчики
		void __fastcall OnClickPanel(System::TObject* Sender);
		void __fastcall OnKeyUp(TObject *Sender, WORD &Key,TShiftState Shift);
		void __fastcall OnClickMenuItemGroup(TObject *Sender);
  */
  		void __fastcall OnClickMenuItemMainGroup(TObject *Sender);
/*		void __fastcall OnPopupMenuDU(TObject *Sender);
		void __fastcall DrawTableMouseDown(TObject *Sender,TMouseButton Button,
			TShiftState Shift, int X, int Y);
		void __fastcall DrawTableMouseMove(TObject *Sender,TShiftState Shift,
			int X, int Y);
		void __fastcall DrawTableMouseUp(TObject *Sender,TMouseButton Button,
			TShiftState Shift, int X, int Y);
*/
      virtual void __fastcall PrintTable();
};
//---------------------------------------------------------------------------
#endif
