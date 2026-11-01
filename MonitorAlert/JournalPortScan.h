//---------------------------------------------------------------------------
#ifndef JournalPortScanH
#define JournalPortScanH
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
//---------------------------------------------------------------------------
class TdlgJournalPortScan : public TForm
{
__published:	// IDE-managed Components
  TPanel *paBtn;
	TPanel *Panel2;
    TTimer *Timer1;
    TBitBtn *m_btnRefreshData;
    TImageList *ImageList1;
  TListView *MessageGrid1;
  TPanel *paCOM;
  TComboBox *cbScan;
  TOraQuery *oqSSD;
  TBitBtn *btJournal;
  TBitBtn *btnClose;
        TBitBtn *BitBtn1;
        TSaveDialog *SaveDialog1;
  void __fastcall Timer1Timer(TObject *Sender);
//  void __fastcall MessageGridDblClick(TObject *Sender);
//  void __fastcall m_btnRefreshDataClick(TObject *Sender);
  void __fastcall MessageGrid1DblClick(TObject *Sender);
  void __fastcall MessageGrid1ColumnClick(TObject *Sender,
          TListColumn *Column);
  void __fastcall cbScanChange(TObject *Sender);
  void __fastcall FormShow(TObject *Sender);
  void __fastcall btJournalClick(TObject *Sender);
        void __fastcall BitBtn1Click(TObject *Sender);
//  void __fastcall MessageGridTitleClick(TColumnEh *Column);
private:	// User declarations
  bool desc1;
  bool desc2;
  bool desc3;
  int sort;// признак сортировки дл€ запроса
	void __fastcall SelectData( void );
  bool __fastcall RefreshData( void );
  void __fastcall SortData( void );
  AnsiString  sqlStr;   //! —трока SQL запроса
//  AnsiString  orderStr;   //! —трока сортировки дл€ запроса
 // int CurrentScan;
//    THintWindow * pHintWnd;
//    int Xpos;
//    int Ypos;
   // TListItem *LI;
public:		// User declarations
	__fastcall TdlgJournalPortScan(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TdlgJournalPortScan *dlgJournalPortScan;
//---------------------------------------------------------------------------
#endif
