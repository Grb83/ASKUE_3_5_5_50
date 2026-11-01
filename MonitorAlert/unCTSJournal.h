//---------------------------------------------------------------------------
#ifndef unCTSJournalH
#define unCTSJournalH
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
#include <ComCtrls.hpp>
#include "DBAccess.hpp"
#include "Ora.hpp"
#include <ToolWin.hpp>
//---------------------------------------------------------------------------
class TfmCTSJournal : public TForm
{
__published:	// IDE-managed Components
	TPanel *Panel1;
	TPanel *Panel2;
    TTimer *Timer1;
    TBitBtn *m_btnRefreshData;
    TImageList *ImageList1;
  TListView *MessageGrid1;
  TOraQuery *oqCursor;
  TToolBar *ToolBar;
  TToolButton *ToolButton2;
  TToolButton *btnDel;
  TActionList *Actions;
  TAction *acDelete;
  TOraQuery *oqToDel;
  TBitBtn *m_btnClose;
	void __fastcall OnShow(TObject *Sender);
  void __fastcall Timer1Timer(TObject *Sender);

  void __fastcall MessageGrid1DblClick(TObject *Sender);
  void __fastcall MessageGrid1ColumnClick(TObject *Sender,
          TListColumn *Column);

  void __fastcall MessageGrid1CustomDrawItem(TCustomListView *Sender,
          TListItem *Item, TCustomDrawState State, bool &DefaultDraw);

  void __fastcall MessageGrid1GetSubItemImage(TObject *Sender,
          TListItem *Item, int SubItem, int &ImageIndex);
  void __fastcall acDeleteExecute(TObject *Sender);
 

private:	// User declarations
  bool desc1;
  bool desc2;
  bool desc3;
  bool desc4;
  bool desc5;
  int sort;// признак сортировки дл€ запроса
	void __fastcall SelectData( void );
  bool __fastcall RefreshData( void );
  void __fastcall SortData( void );
	unsigned long m_ulNumberSelectedRows;
  AnsiString  sqlStr;   //! —трока SQL запроса

public:		// User declarations
	__fastcall TfmCTSJournal(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfmCTSJournal *fmCTSJournal;
//---------------------------------------------------------------------------
#endif
