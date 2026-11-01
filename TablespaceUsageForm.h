//---------------------------------------------------------------------------

#ifndef TablespaceUsageFormH
#define TablespaceUsageFormH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Buttons.hpp>
#include <ExtCtrls.hpp>
#include "DBAccess.hpp"
#include "MemDS.hpp"
#include "Ora.hpp"
#include <DB.hpp>
#include "DBGridEh.hpp"
#include "GridsEh.hpp"
#include <Grids.hpp>
#include <Dialogs.hpp>
//---------------------------------------------------------------------------
#define MAX_COLUMN 8
#define MAX_ROW 5

AnsiString tablespace_name[MAX_ROW];
AnsiString megs_alloc[MAX_ROW];
AnsiString megs_free[MAX_ROW];
AnsiString megs_used[MAX_ROW];
AnsiString pct_free[MAX_ROW];
AnsiString pct_used[MAX_ROW];
AnsiString max[MAX_ROW];
AnsiString usage[MAX_ROW];
const AnsiString colNamesRus[MAX_COLUMN] = {"Наименование пространства","Использовано, %","Свободно, %","Выделено, Mb","Использовано, Mb","Cвободно, Mb","Максимум, Mb","Использовано от максимума, %"};
const AnsiString colNamesUkr[MAX_COLUMN] = {"Найменування простору", "Використано, %", "Вільно, %","Виділено, Mb","Використано, Mb","Вільно, Mb", "Максимум, Mb","Використано від максимума, %"};
AnsiString colNames[MAX_COLUMN];

const AnsiString allRowRus = "Всего:";
const AnsiString allRowUkr = "Всього:";
class TTablespaceUsage : public TForm
{
__published:	// IDE-managed Components
  TPanel *Panel1;
  TPanel *Panel2;
  TBitBtn *btnRefresh;
  TBitBtn *btnClose;
        TStringGrid *StringGrid1;
        TOraQuery *oqTablespaceUsage;
        TBitBtn *BitBtn1;
        TSaveDialog *aSaveDialog;
  void __fastcall grTablespaceDrawColumnCell(TObject *Sender,
          const TRect &Rect, int DataCol, TColumnEh *Column,
          TGridDrawState State);
  void __fastcall grTablespaceDrawFooterCell(TObject *Sender, int DataCol,
          int Row, TColumnEh *Column, TRect &Rect, TGridDrawState State);
  void __fastcall btnRefreshClick(TObject *Sender);
  void __fastcall drawTable();
      //GRB ADD 03.11.2022
  void __fastcall SaveTableToFile(TObject *Sender);
  AnsiString __fastcall getSeparator();
private:	// User declarations
        void __fastcall fAutoSizeColSG(TStringGrid * StringGrid);

public:		// User declarations
  __fastcall TTablespaceUsage(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TTablespaceUsage *TablespaceUsage;
//---------------------------------------------------------------------------
#endif
