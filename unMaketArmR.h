//---------------------------------------------------------------------------

#ifndef unMaketArmRH
#define unMaketArmRH
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
#include "DBAccess.hpp"
#include "DBGridEh.hpp"
#include "MemDS.hpp"
#include "Ora.hpp"
#include "PrnDbgeh.hpp"
#include <ComCtrls.hpp>
#include <DB.hpp>
#include <Dialogs.hpp>
#include <Grids.hpp>
#include <Mask.hpp>
#include <ToolWin.hpp>
//****************************
#include <DBGrids.hpp>
#include <math.h >
#include "unInteriorUni.h"
#include "GridsEh.hpp"
//****************************
#define imPoint           0
#define imInvPoint        1
#define imMaket           3
#define imMaketExists     181
#define imMaketVar        184
#define imFolder          4
#define imBlMaket         6
#define imBlMaketExists   182
#define imBlMaketVar      185
#define imMaketErr        24
#define imBlMaketErr      25
#define imChan            9
#define imRezChan         10
#define imBlChan          11
#define imBlRezChan       12
#define MAKET_TYPE_30817 2

//---------------------------------------------------------------------------
class TfmMaketArmR : public TMainForm
{
__published:	// IDE-managed Components
  TImageList *ImageList1;
  TActionList *acBase;
  TAction *acFileClose;
  TAction *acFileExit;
  TAction *acRefresh;
  TAction *aMUpCtr;
  TAction *aMDownCtr;
  TAction *iaChannel;
  TAction *iaMakets;
  TAction *iaClear;
  TMainMenu *mnMain;
  TMenuItem *mnFile;
  TMenuItem *MenuItem1;
  TMenuItem *mnRefresh;
  TMenuItem *MenuItem2;
  TMenuItem *mnFileClose;
  TMenuItem *MenuItem3;
  TMenuItem *mnFileExit;
  TSplitter *Splitter1;
  TPanel *Panel2;
  TTreeView *DeportsTree;
  TPanel *Panel1;
  TPageControl *MaketInfa;
  TTabSheet *OperWork;
  TPanel *Panel4;
  TLabel *lbMaketName;
  TLabel *lbMaketState;
  TImage *imMaketState;
  TTabSheet *Journal;
  TPanel *Panel5;
  TLabel *TimeStart;
  TPanel *Panel6;
  TLabel *lbDeportation;
  TPanel *Panel7;
  TLabel *Label2;
  TLabel *Label4;
  TDateTimePicker *dtFrom;
  TMaskEdit *edFrom;
  TDateTimePicker *dtTill;
  TMaskEdit *edTill;
  TToolBar *tbFilter;
  TToolButton *tbTimer;
  TToolButton *ToolButton7;
  TToolButton *tbState0;
  TToolButton *tbState1;
  TToolButton *tbState2;
  TDBGridEh *MessageGrid;
  TTabSheet *Maket;
  TRichEdit *reMaket;
  TPanel *Panel3;
  TLabel *lbRepName;
  TLabel *lbState;
  TImage *imState;
  TMemo *meError;
  TMemo *meErrorLoad;
  TToolBar *tbTools;
  TToolButton *tbTree;
  TToolButton *ToolButton5;
  TToolButton *ToolButton3;
  TToolButton *ToolButton2;
  TToolButton *tbReload;
  TToolButton *tbVerify;
  TToolButton *tbLoad;
  TToolButton *tbPreview;
  TToolButton *tbOperWork;
  TToolButton *tbJournal;
  TToolButton *ToolButton6;
  TToolButton *tbLoadFromFile;
  TToolButton *tbDelete;
  TToolButton *ToolButton4;
  TToolButton *tbSave;
  TToolButton *tbPrint;
  TToolButton *ToolButton1;
  TToolButton *tbNotepad;
  TOraQuery *oqDeports;
  TOraQuery *oqDeportInfo;
  TOraDataSource *dsDeportInfo;
  TOraQuery *oqVspom;
  TSaveDialog *SaveDialog1;
  TPrintDBGridEh *PrintMessageGrid;
  TOpenDialog *OpenDialog1;
  TOraQuery *oqExistsMaket;
  TTimer *Timer1;
  TOraQuery *oqIsLoad;
  TAction *alDelete;
  TPanel *Panel8;
  TSpeedButton *SpeedButton1;
  TPanel *Panel9;
  TSpeedButton *SpeedButton2;


  void __fastcall DeportsTreeChange(TObject *Sender, TTreeNode *Node);
        void __fastcall edChange(TObject *Sender);
        void __fastcall edExit(TObject *Sender);
        void __fastcall tbStateClick(TObject *Sender);
        void __fastcall tbVerifyClick(TObject *Sender);
        void __fastcall tbPreviewClick(TObject *Sender);
        void __fastcall tbSaveClick(TObject *Sender);
        void __fastcall tbPrintClick(TObject *Sender);
        void __fastcall MaketInfaChange(TObject *Sender);
        void __fastcall tbLoadClick(TObject *Sender);
        void __fastcall DeportsTreeExpanding(TObject *Sender,
          TTreeNode *Node, bool &AllowExpansion);
        void __fastcall dtChange(TObject *Sender);
        void __fastcall MessageGridDblClick(TObject *Sender);
  void __fastcall DeportsTreeChanging(TObject *Sender, TTreeNode *Node,
          bool &AllowChange);
  void __fastcall FormCloseQuery(TObject *Sender, bool &CanClose);
  void __fastcall MessageGridTitleClick(TColumnEh *Column);
  void __fastcall MessageGridDrawColumnCell(TObject *Sender,
          const TRect &Rect, int DataCol, TColumnEh *Column,TGridDrawState State);
  void __fastcall oqDeportInfoAfterScroll(TDataSet *DataSet);
  void __fastcall tbOperWorkClick(TObject *Sender);
  void __fastcall tbLoadFromFileClick(TObject *Sender);
  void __fastcall tbReloadClick(TObject *Sender);
  void __fastcall tbTreeClick(TObject *Sender);
  void __fastcall DeportsTreeEnter(TObject *Sender);
  void __fastcall MessageGridEnter(TObject *Sender);
  void __fastcall reMaketSelectionChange(TObject *Sender);
  void __fastcall tbJournalClick(TObject *Sender);
  void __fastcall FormClose(TObject *Sender, TCloseAction &Action);
  void __fastcall tbNotepadClick(TObject *Sender);
  void __fastcall tbTimerClick(TObject *Sender);
  void __fastcall Timer1Timer(TObject *Sender);
        void __fastcall MessageGridColumnMoved(TObject *Sender,
          int FromIndex, int ToIndex);
        void __fastcall CheckBox1Click(TObject *Sender);
  void __fastcall btnSaveClick(TObject *Sender);
private:	// User declarations
TfmInteriorUni *FInUn;
struct MAKET{
          long ObjID;       // идентификатоор объекта
          long ObjType;     // тип объекта 0-шапка, 1-канал , 2- макет
          char Name[130];   //Наименование
          long Blocking;     // блокировка
          char Error[2000]; //  ошибка
          long Parent;      //Главный канал
          char LastSystemCreated[20]; //Дата следующего запуска системой
          double nperiod;
          long ProcID;
          long nPreview;
          long nformat;
          MAKET(){ ZeroMemory(this,sizeof(*this));}
        };
        bool isChange;
       // bool isOldTree;
        AnsiString orderStr;
        //TfmBaseEditMaket *fmEditMaket;
        void __fastcall ReadNodeInfo(void);
        bool __fastcall ReadTreeNode(TTreeNode *ParentNode);
        void __fastcall SetEnabledControls(void);
        bool __fastcall ReloadMaketForm(long nPreview=0,long ObjID=0);
        void __fastcall PrintGrid(void);
        void __fastcall SetLabelState(TLabel *lb,TImage *img);
        //void __fastcall SetViewTask(TViewTask value);
     //   void __fastcall SetStateWindow();
      //  void __fastcall SaveStateWindow();
       // void __fastcall SetIsExistsState(void);
        void __fastcall SetDate(TDateTime &dfrom,TDateTime &dtill);
                        //07.07.2020 GRB ADD - вычитка и установка режима строгости
        int __fastcall getStrictRegime();
        void __fastcall setStrictRegime(bool regime);
        void __fastcall addCheckBox1OnPanel (TObject *Sender);


public:		// User declarations
  //static void __fastcall UnivPrintRep(TComponent* Owner,int lMode,TRichEdit* reTmp);
  static void __fastcall SaveTable(TComponent* Owner,TDBGridEh *gr,AnsiString RepCaption);
  __fastcall TfmMaketArmR(TComponent* Owner, AnsiString Name, TAccess a);
  __fastcall ~TfmMaketArmR();

protected:
  void __fastcall vSave(TObject* Sender){};
  void __fastcall vRefresh(TObject* Sender);
  void __fastcall vDelete(TObject* Sender);

};
//---------------------------------------------------------------------------
extern PACKAGE TfmMaketArmR *fmMaketArmR;
//---------------------------------------------------------------------------
#endif
