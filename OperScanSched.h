//---------------------------------------------------------------------------
#ifndef OperScanSchedH
#define OperScanSchedH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <ImgList.hpp>
#include <Buttons.hpp>
#include "DBGridEh.hpp"
#include <Grids.hpp>
#include "DBAccess.hpp"
#include "MemDS.hpp"
#include "Ora.hpp"
#include <DB.hpp>
#include <Dialogs.hpp>
//---------------------------------------------------------------------------
const CHANNLIST_DIM = 20000;

typedef struct {
    char Id[20];
    char Name[100];
    char Start[100];
    char End[100];
    char CycleTout[100];
    char User[100];
    char Ready[100];
    char Kind[100];
    char Bloking[100];
    char Parent[100];
    char NotReadCurr[100];
    char Retries[100];
    char RetriesTout[100];
    char pGetChann[2];
    char isbilldata[100];
    char isbilldatadepth[100];
    char iscurrdata[100];
    char iscurrdatadepth[100];
    char comid[20];
    char is_dead[20];
    char prname[100];
}CHANNLIST;

class TfmOperScanSched : public TForm
{
__published:	// IDE-managed Components
  TImageList *ImageList1;
  TPanel *Panel2;
  TBitBtn *btStart;
  TBitBtn *btStop;
  TBitBtn *btPoint;
  TBitBtn *btClose;
  TBitBtn *btRefresh;
  TGroupBox *GroupBox1;
  TEdit *eFilter;
  TSpeedButton *spbFilter;
  TSpeedButton *spbDelFilter;
  TDBGridEh *grChannels;
  TOraQuery *oqChannels;
  TOraDataSource *dsChannels;
  TPanel *Panel1;
  TGroupBox *GroupBox2;
  TSpeedButton *sbPoint;
  TSpeedButton *sbDelPoint;
  TEdit *ePoint;
        TSaveDialog *SaveDialog1;
        TBitBtn *BitBtn1;
  void __fastcall btStartClick(TObject *Sender);
  void __fastcall FormCreate(TObject *Sender);
  void __fastcall btStopClick(TObject *Sender);
  void __fastcall btCloseClick(TObject *Sender);
  void __fastcall btPointClick(TObject *Sender);
  void __fastcall btRefreshClick(TObject *Sender);
  void __fastcall spbFilterClick(TObject *Sender);
  void __fastcall spbDelFilterClick(TObject *Sender);
  void __fastcall grChannelsDrawColumnCell(TObject *Sender,
          const TRect &Rect, int DataCol, TColumnEh *Column,
          TGridDrawState State);
  void __fastcall grChannelsTitleClick(TColumnEh *Column);
  void __fastcall eFilterKeyDown(TObject *Sender, WORD &Key,
          TShiftState Shift);
  void __fastcall sbPointClick(TObject *Sender);
  void __fastcall sbDelPointClick(TObject *Sender);
        void __fastcall grChannelsColumnMoved(TObject *Sender,
          int FromIndex, int ToIndex);
  //19.07.2022 GRB ADD сохзранение в файл
  void __fastcall SaveTableToFile (TObject *Sender);

private:	// User declarations
  AnsiString  orderStr;   // Строка сортировки для запроса
  bool wasSwapColumn;
public:		// User declarations
  __fastcall TfmOperScanSched(TComponent* Owner,int Mid,AnsiString Name,int CMid,AnsiString CName,int IfPoint);

  unsigned long CountStrChannList;
  CHANNLIST TableChannList[CHANNLIST_DIM];
  void __fastcall ScanActivate(AnsiString PPDT,AnsiString PPInt);
  void __fastcall ScanDeactivate();
  void __fastcall SchChRefresh();
 // static void __fastcall OperScanSchedShow(void);
    static void __fastcall OperScanSchedShow(int Mid=0,AnsiString Name="",int CMid=0,AnsiString CName="",int IfPoint=-1);
    // IfPoint=-1 без фильтров, IfPoint=1 фильтр по точкам, IfPoint=0 фильтр по точкам и каналам , IfPoint=2 фильтр по каналам
 };



//---------------------------------------------------------------------------
extern PACKAGE TfmOperScanSched *fmOperScanSched;
//---------------------------------------------------------------------------
#endif
