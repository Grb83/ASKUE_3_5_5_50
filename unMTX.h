//---------------------------------------------------------------------------

#ifndef unMTXH
#define unMTXH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Buttons.hpp>
#include <ExtCtrls.hpp>
#include <Grids.hpp>
#include <DB.hpp>
#include "DBAccess.hpp"
#include "MemDS.hpp"
#include "Ora.hpp"
#include "DBGridEh.hpp"
#include "GridsEh.hpp"
#include <ImgList.hpp>
#include <ComCtrls.hpp>
#include <ToolWin.hpp>
#include <DBCtrls.hpp>

//#define TGridDrawState Gridseh::TGridDrawState
//---------------------------------------------------------------------------
class TfmMTX : public TForm
{
__published:	// IDE-managed Components
  TOraQuery *oqMain;
  TDataSource *dsMain;
  TOraQuery *oqSlave;
  TDataSource *dsSlave;
  TPanel *PanelAll;
  TSplitter *Splitter1;
  TOraQuery *OraQuery;
  TImageList *ilMenu;
  TPanel *PanelDet;
  TDBGridEh *grMeters;
  TPanel *PanelRouter;
  TDBGridEh *grRouters;
  TPanel *PanelDetTop;
  TToolBar *ToolBar1;
  TToolButton *btnErrorFilter;
  TToolButton *btnWarningFilter;
  TToolButton *btnOkFilter;
  TToolBar *ToolBar3;
  TToolButton *btnDeleteMeter;
  TPanel *PanelBottom;
  TBitBtn *btnRefresh;
  TBitBtn *btnClose;
  TBitBtn *m_btnSave;
  TPanel *PanelDetDetails;
  TPanel *PanelRouterDetails;
  TOraQuery *oqDetDetails;
  TDataSource *dsDetDetailes;
  TGroupBox *gbCurrent;
  TDBText *dbtQ3M;
  TDBText *dbtQ1M;
  TLabel *Label4;
  TLabel *Label3;
  TDBText *dbtEDM;
  TDBText *dbtERM;
  TLabel *Label1;
  TLabel *Label2;
  TLabel *Label5;
  TDBText *dbtVolt;
  TLabel *Label6;
  TDBText *dbtVolt2;
  TLabel *Label7;
  TDBText *dbtVolt3;
  TLabel *Label8;
  TDBText *dbtCurrento;
  TLabel *Label9;
  TDBText *dbtCurr2;
  TLabel *Label10;
  TDBText *dbtCurr3;
  TDBText *dbtVNAME;
  TLabel *Label11;
  TDBText *dbtNMTRSN;
  TLabel *Label12;
  TDBText *dbtCID;
  TLabel *Label13;
  TDBText *dbtADDR;
  TLabel *Label14;
  TDBText *dbtVSTATE;
  TLabel *Label15;
  TDBText *dbtDENTER;
  TLabel *Label16;
  TDBText *dbtDSTATE;
  TLabel *Label17;
  TDBText *dbtFREQ;
  TLabel *Label18;
  TDBText *dbtCOSF;
  TLabel *Label19;
  TToolButton *ToolButton1;
  TToolButton *ToolButton2;
  TPanel *PanelRouterButtons;
  TToolBar *ToolBar2;
  TToolButton *ToolButton3;
  TToolButton *btnDeleteRouter;
  TLabel *Label20;
  TDBText *dbtVNAMEs;
  TDBText *dbtDCURRPOWER;
  TLabel *Label21;
  TLabel *Label22;
  TDBText *dbtVTYPE;
  TDBText *dbtNMTRSN1;
  TLabel *Label23;
  TLabel *Label24;
  TDBText *dbtVERROR;
  TLabel *Label25;
  TDBText *dbtMID;

  void __fastcall btnRefreshClick(TObject *Sender);
  void __fastcall m_btnSaveClick(TObject *Sender);
  void __fastcall oqMainAfterScroll(TDataSet *DataSet);
  void __fastcall grRoutersEnter(TObject *Sender);
  void __fastcall btnDeleteMeterClick(TObject *Sender);
  void __fastcall grMetersDrawColumnCell(TObject *Sender,
          const TRect &Rect, int DataCol, TColumnEh *Column,
          TGridDrawState State);
  void __fastcall grMetersTitleClick(TColumnEh *Column);
  void __fastcall grRoutersTitleClick(TColumnEh *Column);
  void __fastcall oqMainBeforeOpen(TDataSet *DataSet);
  void __fastcall btnOkFilterClick(TObject *Sender);
  void __fastcall btnDeleteRouterClick(TObject *Sender);
  void __fastcall oqSlaveAfterScroll(TDataSet *DataSet);
  void __fastcall oqSlaveBeforeOpen(TDataSet *DataSet);
  void __fastcall FormClose(TObject *Sender, TCloseAction &Action);
private:	// User declarations
  TDBGridEh * grActive;
  int order_by_det;
  int order_by;
  void __fastcall SelectDet(void);
  void __fastcall SelectConf(void);
public:		// User declarations
  __fastcall TfmMTX(TComponent* Owner);
  static bool __fastcall fmMTXShow(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfmMTX *fmMTX;
//---------------------------------------------------------------------------
#endif
