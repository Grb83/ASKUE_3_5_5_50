//---------------------------------------------------------------------------
#ifndef JournalAlertH
#define JournalAlertH
//---------------------------------------------------------------------------
#include "MemDS.hpp"
#include "VirtualTable.hpp"
#include <ActnList.hpp>
#include <Buttons.hpp>
#include <Classes.hpp>
#include <Controls.hpp>                 
#include <Db.hpp>
#include <DBGrids.hpp>
#include <ExtCtrls.hpp>
#include <Grids.hpp>
#include <ImgList.hpp>
#include <StdCtrls.hpp>
#include <Dialogs.hpp>
#include "DBGridEh.hpp"
#include <DB.hpp>
#include "DBAccess.hpp"
#include "Ora.hpp"
//---------------------------------------------------------------------------
class TdlgJournalAlert : public TForm
{
__published:	// IDE-managed Components
	TPanel *Panel1;
	TPanel *Panel2;
    TTimer *Timer1;
    TBitBtn *m_btnRefreshData;
    TBitBtn *btnFilter;
    TBitBtn *m_btnSubmit;
    TActionList *ActionList1;
    TAction *aFilter;
    TImageList *ImageList1;
    TAction *aSubmit;
  TDataSource *MessageDS;
  TAction *aExport;
  TSaveDialog *SaveDialog1;
  TBitBtn *m_btnSave;
  TDBGridEh *MessageGrid;
  TOraQuery *quMain;
  TBitBtn *m_btnClose;
	void __fastcall OnSubmit(TObject *Sender);
	void __fastcall OnShow(TObject *Sender);
    void __fastcall Timer1Timer(TObject *Sender);
    void __fastcall aFilterClick(TObject *Sender);
  void __fastcall MessageGridDblClick(TObject *Sender);
  void __fastcall m_btnRefreshDataClick(TObject *Sender);
  void __fastcall aExportExecute(TObject *Sender);
  void __fastcall MessageGridDrawColumnCell(TObject *Sender,
          const TRect &Rect, int DataCol, TColumnEh *Column,
          TGridDrawState State);
  void __fastcall MessageGridTitleClick(TColumnEh *Column);
        void __fastcall MessageGridColumnMoved(TObject *Sender,
          int FromIndex, int ToIndex);
private:	// User declarations
  AnsiString  sqlStr;   //! Строка SQL запроса
  AnsiString  orderStr;   //! Строка сортировки для запроса
	void __fastcall SelectData( void );
	unsigned long m_ulNumberSelectedRows;
    THintWindow * pHintWnd;
    int Xpos;
    int Ypos;
    AnsiString Name;
    AnsiString sAdvFilter;
    //GRB ADD 28.02.2020
    bool wasSwapColumn;
//    inline AnsiString __fastcall Cells(TDrawTable*, int, int);
public:		// User declarations
	__fastcall TdlgJournalAlert(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TdlgJournalAlert *dlgJournalAlert;
//---------------------------------------------------------------------------
#endif
