//---------------------------------------------------------------------------

#ifndef MonitorICCPUnitH
#define MonitorICCPUnitH
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
#include <ToolWin.hpp>
//---------------------------------------------------------------------------

class TMonitorICCPForm : public TMainForm
{
__published:	// IDE-managed Components
  TAction *iaPrint;
  TDBGridEh *grMonitor;
  TOraDataSource *dsMonitor;
  TOraQuery *oqGetMonitor;
  TPanel *Panel1;
  TDBGridEh *grAssociation;
  TOraQuery *oqAssociations;
  TOraDataSource *dsAssociations;
  TPanel *Panel5;
  TFloatField *oqAssociationsMID;
  TStringField *oqAssociationsNNAME;
  TStringField *oqAssociationsSTATE;
  TDateTimeField *oqAssociationsSTATE_DATE;
  TStringField *oqAssociationsMESS;
  TPanel *Panel6;
  TLabel *Label1;
  TFloatField *oqGetMonitorMID;
  TStringField *oqGetMonitorNNAME;
  TStringField *oqGetMonitorSTATE;
  TStringField *oqGetMonitorASSOC;
  TDateTimeField *oqGetMonitorSTATE_DATE;
  TStringField *oqGetMonitorMESS;
  TPanel *Panel8;
  TSplitter *Splitter2;
  TTimer *Timer;
  TPanel *Panel10;
  TLabel *Label3;
  TStringField *oqGetMonitorMESS_DATE;
  TStringField *oqAssociationsMESS_DATE;
  TAction *acEdServName;
  TToolBar *ToolBar1;
  TToolButton *ToolButton1;
  TToolButton *ToolButton3;
  TToolButton *ToolButton4;
  TToolButton *ToolButton5;
  TPrintDBGridEh *PrintgrMonitor;
  void __fastcall FormCreate(TObject *Sender);
  void __fastcall grMonitorCellClick(TColumnEh *Column);
  void __fastcall grMonitorKeyUp(TObject *Sender, WORD &Key,
          TShiftState Shift);
  void __fastcall Panel3Resize(TObject *Sender);
  void __fastcall FormShow(TObject *Sender);
  void __fastcall Refresh(int srt);
  void __fastcall AssociationsRefresh();
  void __fastcall TimerTimer(TObject *Sender);
  void __fastcall iaPrintExecute(TObject *Sender);
  void __fastcall grMonitorTitleClick(TColumnEh *Column);
  void __fastcall iaRefreshExecute(TObject *Sender);
  void __fastcall grAssociationTitleClick(TColumnEh *Column);
  void __fastcall grAssociationKeyUp(TObject *Sender, WORD &Key,
          TShiftState Shift);
  void __fastcall grAssociationCellClick(TColumnEh *Column);
  void __fastcall acEdServNameExecute(TObject *Sender);
  void __fastcall FormClose(TObject *Sender, TCloseAction &Action);

private:	// User declarations
    int RowToRem;        //хранение последней выделенной строки в табл "Монитор"
    int AssRowToRem;     //хранение последней выделенной строки в табл "Ассоциации"
    int MonColToRem;     //хранение столбца, по которому сортируем в табл "Монитор"
    int AssColToRem;     //хранение столбца, по которому сортируем в табл "Ассоциации"

public:		// User declarations
  __fastcall TMonitorICCPForm(TComponent* Owner, AnsiString Name, TAccess a);
protected:
 void __fastcall vSave(TObject *Sender);
 void __fastcall vRefresh(TObject *Sender);
};
//---------------------------------------------------------------------------
extern PACKAGE TMonitorICCPForm *MonitorICCPForm;
//---------------------------------------------------------------------------
#endif
