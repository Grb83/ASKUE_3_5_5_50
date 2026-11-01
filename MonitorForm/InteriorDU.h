//---------------------------------------------------------------------------
#ifndef InteriorDUH
#define InteriorDUH
//---------------------------------------------------------------------------
#include "Interior.h"

//---------------------------------------------------------------------------
class TDUInterior : public TInterior
{
	protected:
		bool is_B_and_W;
		TDrawTable *DrawTable;
		TStrings *NamesClones;//имена клонов
		bool ClonePressed;//для визуализации нажатий на заголовки таблицы
		TShiftState ShiftPressed;//для визуализации нажатий на заголовки таблицы
		long ColPressed,RowPressed;//для визуализации нажатий на заголовки таблицы
		long Clones;//общее количество клонов в таблице
		TCloneItem *datOracle;//Двумерный массив.
						 //Клоны расположены по столбцам. В столбе значения для одного клона.
	public:
		__fastcall TDUInterior(TComponent* Owner,TSplitterForm *,TFormDescr*,Classes::TNotifyEvent,bool B_and_W );
		virtual __fastcall ~TDUInterior(void);

		//Снятие со SplitterFom и размещение на SplitterFom таблицы и графика,
		//вызываемтся при обновлении TBaseMonitorForm
		virtual void __fastcall Destroy(void);
		virtual void __fastcall Place(void);

		//Установить новую компановку
		virtual bool __fastcall setSplit(void);

		//Возвращает количесиво подколонок для формы
		virtual long __fastcall SubColumns(void){return 3;};

		//Возвращает имена подколонок для формы
		virtual AnsiString __fastcall GetSubColumnsNames(int);

		//Обновление данных из базы
		//NameAlert=-1 для обновления в любом случае
		virtual void __fastcall refreshData( int Table,TOraQuery *qwInterDU);
 //		virtual void __fastcall selectData( VCursor& );
    void __fastcall selectData(  TOraQuery *qwInterDU );
		virtual void __fastcall Invalidate( int Table );

		//Получает данные о считываемой таблице
		virtual void __fastcall formDescr( void );

		//Формирует таблицу, располагая клоны по столбцам
		virtual void __fastcall clonesInColumns(void);
		virtual void __fastcall dataInColumns(void);

		//Интерпритирует счелчок пользователь на таблице,
		//и проводит декомпозицию по группе
		virtual void __fastcall clickComposition(long ACol, long ARow );
		virtual void __fastcall clickDialog(long ACol, long ARow );

		//Событийные обработчики
		virtual void __fastcall OnClickPanel(System::TObject* Sender);
		virtual void __fastcall OnKeyUp(TObject *Sender, WORD &Key,TShiftState Shift);
		virtual void __fastcall OnClickMenuItemGroup(TObject *Sender);
	        virtual void __fastcall OnClickMenuItemMainGroup(TObject *Sender);
		virtual void __fastcall OnPopupMenuDU(TObject *Sender);
		virtual void __fastcall DrawTableMouseDown(TObject *Sender,TMouseButton Button,
			TShiftState Shift, int X, int Y);
		virtual void __fastcall DrawTableMouseMove(TObject *Sender,TShiftState Shift,
			int X, int Y);
		virtual void __fastcall DrawTableMouseUp(TObject *Sender,TMouseButton Button,
			TShiftState Shift, int X, int Y);
                // Add KAS 05.07.2002
                virtual void __fastcall PrintTable();
                virtual void __fastcall SaveTableToFile(TSaveDialog *aSaveDialog);
                //GRB ADD 26.08.2021 - два метода для автоформатирования по содержимому фиксированых колонок - исправление бага с обрезанием длинных имён в колонках
                void __fastcall AutoSizeColGRB (TDrawTable* tsg, int columnIndex);
                void __fastcall AutoSizeNameOnly (TDrawTable* tsg);
                //GRB ADD 27.08.2021 - берём из реестра размер шрифта и тип шрифта для того чтобы измерить сколько в длинну колонка с именем объекта занимает пикселей
                TFont * __fastcall GetActiveFont4MonitorFromReg ();
                //GRB ADD 27.08.2021 - подхватываем ресайз формы чтобы при отобраажении колонки монитора по ширине подхватывать и перерисовывать колонку с именем объекта
                void __fastcall FormShow(TObject *Sender);
                bool __fastcall GetContainedWidthStatusFromReg();

};
//---------------------------------------------------------------------------
#endif
