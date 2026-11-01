//---------------------------------------------------------------------------

#ifndef BlockMessageH
#define BlockMessageH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "DBAccess.hpp"
#include "DBGridEh.hpp"
#include "MemDS.hpp"
#include "Ora.hpp"
#include "PrnDbgeh.hpp"
#include <Buttons.hpp>
#include <ComCtrls.hpp>
#include <DB.hpp>
#include <ExtCtrls.hpp>
#include <Grids.hpp>
#include <ImgList.hpp>
#include <ToolWin.hpp>
#include "DBCtrlsEh.hpp"
#include <Mask.hpp>
#include <Menus.hpp>
//---------------------------------------------------------------------------
class TfmBlockMess : public TForm
{
__published:	// IDE-managed Components
  TDBGridEh *grMessage;
  TPanel *Panel10;
  TPanel *Panel1;
  TBitBtn *BitBtn1;
  TBitBtn *BitBtn2;
  TBitBtn *btSave;
  TPanel *Panel2;
  TToolBar *ToolBar1;
  TToolButton *ToolButton10;
  TToolButton *ToolButton5;
  TToolButton *tbExport;
  TToolButton *tbPrint;
  TDataSource *dsMain;
  TImageList *ifMenu;
  TOraQuery *oqMessage;
  TPrintDBGridEh *PrintMessageGrid;
  TPanel *Panel3;
  TLabel *Label1;
  TComboBox *cbType;
  TOraQuery *oqType;
  TOraDataSource *dsType;
  TPageControl *PageControl1;
  TTabSheet *TabSheet1;
  TTabSheet *TabSheet2;
  TDBGridEh *grStatusBits;
  TOraQuery *oqBits;
  TOraDataSource *dsBits;
  TOraQuery *oqValid;
  TOraQuery *oqNQM;
  void __fastcall grMessageDrawColumnCell(TObject *Sender, const TRect &Rect,
          int DataCol, TColumnEh *Column, TGridDrawState State);
  void __fastcall vRefresh(TObject *Sender);
  void __fastcall grMessageDblClick(TObject *Sender);
  void __fastcall btSaveClick(TObject *Sender);
  void __fastcall tbExportClick(TObject *Sender);
  void __fastcall tbPrintClick(TObject *Sender);
  void __fastcall grMessageTitleBtnClick(TObject *Sender, int ACol,
          TColumnEh *Column);
  void __fastcall grMessageKeyPress(TObject *Sender, char &Key);
  void __fastcall cbTypeChange(TObject *Sender);
  void __fastcall grStatusBitsDblClick(TObject *Sender);
  void __fastcall grStatusBitsTitleBtnClick(TObject *Sender, int ACol,
          TColumnEh *Column);
  void __fastcall grMessageColumns4EditButtonClick(TObject *Sender,
          bool &Handled);
  void __fastcall oqMessageAfterEdit(TDataSet *DataSet);
private:	// User declarations
  long meter_type;
  long sort_mess,sort_bits;
public:		// User declarations
  __fastcall TfmBlockMess(TComponent* Owner);
  static bool __fastcall fmBlockMessShow(TComponent* Owner);
  void vRead(long MeterType,long Sort_mess, long Sort_bits);
};
//---------------------------------------------------------------------------
extern PACKAGE TfmBlockMess *fmBlockMess;
//---------------------------------------------------------------------------
#endif
