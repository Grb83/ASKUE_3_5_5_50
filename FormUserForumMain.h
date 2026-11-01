//---------------------------------------------------------------------------

#ifndef FormUserForumMainH
#define FormUserForumMainH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Main.h"
#include <Buttons.hpp>
#include <ExtCtrls.hpp>
#include <ComCtrls.hpp>
#include <ToolWin.hpp>
#include "DBAccess.hpp"
#include "DBGridEh.hpp"
#include "MemDS.hpp"
#include "Ora.hpp"
#include <DB.hpp>
#include "DBCtrlsEh.hpp"
#include <Mask.hpp>
#include <Graphics.hpp>
#include <Grids.hpp>
#include "unDataMod.h"
//---------------------------------------------------------------------------
class TUserForumMain : public TMainForm
{
__published:	// IDE-managed Components
  TBitBtn *newTopic;
  TLabel *Label1;
  TLabel *Label2;
  TToolBar *ToolBar1;
  TDateTimePicker *fromCalendar;
  TLabel *Label3;
  TDateTimePicker *tillCalendar;
  TSplitter *Splitter1;
  TSplitter *Splitter2;
  TDBGridEh *topicsGrid;
  TOraQuery *receiveTopicsQuery;
  TOraDataSource *receiveTopicsDataSource;
  TOraQuery *receiveUsersQuery;
  TComboBox *usersComboBox;
  TTimer *Timer1;
  TPanel *SortPanel;
  TImage *AscImage;
  TImage *DescImage;
  void __fastcall usersComboBoxChange(TObject *Sender);
  void __fastcall fromCalendarChange(TObject *Sender);
  void __fastcall tillCalendarChange(TObject *Sender);
  void __fastcall newTopicClick(TObject *Sender);
  void __fastcall topicsGridDblClick(TObject *Sender);
  void __fastcall FormShow(TObject *Sender);
  void __fastcall Timer1Timer(TObject *Sender);
  void __fastcall FormClose(TObject *Sender, TCloseAction &Action);
  void __fastcall topicsGridColWidthsChanged(TObject *Sender);
  void __fastcall topicsGridTitleClick(TColumnEh *Column);
  void __fastcall FormCreate(TObject *Sender);
private:	// User declarations
  void __fastcall UpdateUserList();
  void __fastcall UpdateData();
  void __fastcall UpdateSortPanel();
  int __fastcall GetOrderColumnNumber();
  int SortOrder;
  AnsiString SortField;
public:		// User declarations
  __fastcall TUserForumMain(TComponent* Owner, AnsiString Name, TAccess a);
protected:
  void __fastcall vSave(TObject *Sender);
  void __fastcall vRefresh(TObject *Sender);
  __fastcall ~TUserForumMain();
};
//---------------------------------------------------------------------------
extern PACKAGE TUserForumMain *UserForumMain;
//---------------------------------------------------------------------------
#endif
