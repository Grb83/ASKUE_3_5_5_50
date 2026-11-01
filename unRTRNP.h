//---------------------------------------------------------------------------

#ifndef unRTRNPH
#define unRTRNPH
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
#include <ImgList.hpp>
#include <ComCtrls.hpp>
#include <ToolWin.hpp>
#include <DBCtrls.hpp>
#include <Mask.hpp>
#include <Grids.hpp>
#include <Menus.hpp>
//#define TGridDrawState Gridseh::TGridDrawState
//---------------------------------------------------------------------------
class TfmRTRNP : public TForm
{
__published:	// IDE-managed Components
  TOraQuery *oqMain;
  TDataSource *dsMain;
  TOraQuery *oqSlave;
  TDataSource *dsSlave;
  TPanel *PanelAll;
  TSplitter *Splitter1;
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
  TPanel *PanelBottom;
  TBitBtn *btnRefresh;
  TBitBtn *btnClose;
  TBitBtn *m_btnSave;
  TPanel *PanelDetDetails;
  TPanel *PanelRouterDetails;
  TOraQuery *oqDetDetails;
  TGroupBox *gbCurrent;
  TDBText *dbtQ2M;
  TDBText *dbtQ1M;
  TLabel *Label4;
  TLabel *Label3;
  TDBText *dbtERM;
  TLabel *Label1;
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
  TEdit *dbtCID;
  TLabel *Label13;
  TDBText *dbtVSTATE;
  TLabel *Label15;
  TDBText *dbtDENTER;
  TLabel *Label16;
  TDBText *dbtCOSF;
  TLabel *Label19;
  TToolButton *ToolButton1;
  TToolButton *ToolButton2;
  TPanel *PanelRouterButtons;
  TToolBar *ToolBar2;
  TToolButton *ToolButton3;
  TToolButton *btnResetPacketId;
  TDBText *dbtER;
  TLabel *Label17;
  TDBText *dbtQ1;
  TLabel *Label26;
  TDataSource *dsDetDetails;
  TOraQuery *oqQuery;
  TGroupBox *GroupBox1;
  TDBText *dbtSTErr;
  TDBText *dbtSTWait;
  TLabel *Label24;
  TLabel *Label27;
  TDBText *dbtSTNorma;
  TLabel *Label28;
  TLabel *Label29;
  TDBText *dbtSTAll;
  TLabel *Label12;
  TDBText *dbtnTemp;
  TPanel *Panel1;
  TPanel *Panel2;
  TLabel *Label20;
  TLabel *Label22;
  TDBText *dbtTAG;
  TDBText *dbtVNAMEs;
  TLabel *Label21;
  TDBText *dbtDCURRPOWER;
  TLabel *Label2;
  TDBText *dbtVState1;
  TLabel *Label25;
  TDBText *dbtCANAL;
  TLabel *Label23;
  TEdit *dbtMID;
  TLabel *lbCapState;
  TDBText *dbtVOFF;
  TDBText *dbtVCMDOFF;
  TDBText *dbtVEXECMDOFF;
  TPopupMenu *PopupMenu1;
  TMenuItem *mnOFF;
  TMenuItem *mnON;
  TMenuItem *mnONCancel;

  void __fastcall btnRefreshClick(TObject *Sender);
  void __fastcall m_btnSaveClick(TObject *Sender);
  void __fastcall oqMainAfterScroll(TDataSet *DataSet);
  void __fastcall grRoutersEnter(TObject *Sender);
  void __fastcall grMetersDrawColumnCell(TObject *Sender,
          const TRect &Rect, int DataCol, TColumnEh *Column,
          TGridDrawState State);
  void __fastcall grMetersTitleClick(TColumnEh *Column);
  void __fastcall grRoutersTitleClick(TColumnEh *Column);
  void __fastcall oqMainBeforeOpen(TDataSet *DataSet);
  void __fastcall btnOkFilterClick(TObject *Sender);
  void __fastcall oqSlaveAfterScroll(TDataSet *DataSet);
  void __fastcall oqSlaveBeforeOpen(TDataSet *DataSet);
  void __fastcall FormClose(TObject *Sender, TCloseAction &Action);
  void __fastcall btnResetPacketIdClick(TObject *Sender);
  void __fastcall mnONCancelClick(TObject *Sender);
private:	// User declarations
  TDBGridEh * grActive;
  int order_by_det;
  int order_by;
  void __fastcall SelectDet(void);
  void __fastcall SelectConf(void);
  void __fastcall SetAccMenuOFF(void);
  bool accOFF;
public:		// User declarations
  __fastcall TfmRTRNP(TComponent* Owner);
  static bool __fastcall fmRTRNPShow(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfmRTRNP *fmRTRNP;
//---------------------------------------------------------------------------
#endif
