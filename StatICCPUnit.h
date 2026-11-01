//---------------------------------------------------------------------------

#ifndef StatICCPUnitH
#define StatICCPUnitH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Main.h"
#include <ActnList.hpp>
#include <Buttons.hpp>
#include <ExtCtrls.hpp>
#include <ImgList.hpp>
#include <Menus.hpp>
#include "DBGridEh.hpp"
#include <Grids.hpp>
#include "DBAccess.hpp"
#include "MemDS.hpp"
#include "Ora.hpp"
#include "OraSmart.hpp"
#include <DB.hpp>
#include <ComCtrls.hpp>
#include <Mask.hpp>
#include <DBCtrls.hpp>
#include "PrnDbgeh.hpp"
#include <CheckLst.hpp>
//---------------------------------------------------------------------------

class TStatICCPForm : public TMainForm
{
__published:	// IDE-managed Components
  TDBGridEh *StatEhGrid;
  TDataSource *dsStat;
  TAction *iaPrint;
  TBitBtn *PrintBtn;
  TPanel *ToolsPanel;
  TLabel *Label1;
  TMaskEdit *meTimeFrom;
  TDateTimePicker *FromDate;
  TLabel *Label2;
  TDateTimePicker *TillDate;
  TMaskEdit *meTimeTill;
  TPrintDBGridEh *PrintMessageGrid;
  TCheckListBox *CLBChannels;
  TPanel *Panel1;
  TPanel *Panel2;
  TOraQuery *oqChannals;
  void __fastcall FormCreate(TObject *Sender);
  void __fastcall iaRefreshExecute(TObject *Sender);
  void __fastcall PrintBtnClick(TObject *Sender);

private:	// User declarations

 void RefreshGrid();

public:		// User declarations
  __fastcall TStatICCPForm(TComponent* Owner, AnsiString Name, TAccess a);
protected:
 void __fastcall vSave(TObject *Sender);
 void __fastcall vRefresh(TObject *Sender);
};
//---------------------------------------------------------------------------
extern PACKAGE TStatICCPForm *StatICCPForm;
//---------------------------------------------------------------------------
#endif
