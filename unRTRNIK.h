//---------------------------------------------------------------------------

#ifndef unRTRNIKH
#define unRTRNIKH
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
//#define TGridDrawState Gridseh::TGridDrawState
//---------------------------------------------------------------------------
class TfmRTRNIK : public TForm
{
__published:	// IDE-managed Components
  TOraQuery *oqSlave;
  TDataSource *dsSlave;
  TPanel *PanelAll;
  TImageList *ilMenu;
  TPanel *PanelDet;
  TDBGridEh *grMeters;
  TPanel *paFilter;
  TPanel *PanelBottom;
  TBitBtn *btnRefresh;
  TBitBtn *btnClose;
  TBitBtn *m_btnSave;
  TPanel *PanelDetDetails;
  TOraQuery *oqDetDetails;
  TGroupBox *gbCurrent;
  TDBText *dbtERM;
  TLabel *Label1;
  TLabel *Label20;
  TDBText *dbtVNAMEs;
  TDBText *dbtBILL;
  TLabel *Label21;
  TLabel *Label22;
  TDBText *dbtTAG;
  TDBText *dbtSerial;
  TLabel *Label23;
  TLabel *Label25;
  TDBText *dbtER;
  TLabel *Label17;
  TDataSource *dsDetDetails;
  TDBText *dbtVState;
  TLabel *Label2;
  TPanel *Panel1;
  TPanel *Panel2;
  TPanel *Panel3;
  TCheckBox *cb1;
  TCheckBox *cb2;
  TGroupBox *GroupBox1;
  TRadioGroup *RadioGroup1;
  TCheckBox *cb5;
  TCheckBox *cb6;
  TRadioGroup *RadioGroup2;
  TCheckBox *cb3;
  TCheckBox *cb4;
  TPanel *Panel4;
  TRadioGroup *RadioGroup3;
  TCheckBox *cb7;
  TCheckBox *cb8;
  TDBEdit *dbtId;
  TLabel *Label3;
  TDBText *dbtQ1M;
  TLabel *Label4;
  TDBText *dbtQ3M;

  void __fastcall btnRefreshClick(TObject *Sender);
  void __fastcall m_btnSaveClick(TObject *Sender);
  void __fastcall grMetersDrawColumnCell(TObject *Sender,
          const TRect &Rect, int DataCol, TColumnEh *Column,
          TGridDrawState State);
  void __fastcall grMetersTitleClick(TColumnEh *Column);
  void __fastcall oqMainBeforeOpen(TDataSet *DataSet);
  void __fastcall oqSlaveAfterScroll(TDataSet *DataSet);
  void __fastcall oqSlaveBeforeOpen(TDataSet *DataSet);
  void __fastcall FormClose(TObject *Sender, TCloseAction &Action);
  void __fastcall cbClick(TObject *Sender);
private:	// User declarations
  int order_by;
  long fcid;
  void __fastcall SelectDet(void);
public:		// User declarations
  __fastcall TfmRTRNIK(TComponent* Owner,long lcid);
  static bool __fastcall fmRTRNIKShow(TComponent* Owner,long lcid);
};
//---------------------------------------------------------------------------
extern PACKAGE TfmRTRNIK *fmRTRNIK;
//---------------------------------------------------------------------------
#endif
