//---------------------------------------------------------------------------

#ifndef maketarmH
#define maketarmH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ActnList.hpp>
#include <Buttons.hpp>
#include <ExtCtrls.hpp>
#include <ImgList.hpp>
#include <Menus.hpp>
#include <ComCtrls.hpp>
#include <DBGrids.hpp>
#include <Grids.hpp>
#include <Mask.hpp>
#include "MemDS.hpp"
#include "VirtualTable.hpp"
#include <Db.hpp>
#include <ToolWin.hpp>
#include <Dialogs.hpp>
#include "DBGridEh.hpp"
#include <DB.hpp>
#include "DBAccess.hpp"
#include "Ora.hpp"
#include "Main.h"
#include "unInteriorUni.h"
#include "PrnDbgeh.hpp"
//---------------------------------------------------------------------------
#define imMaket     3
#define imFolder    4
#define imOpenFldr  5
#define imBlMaket   6
#define imChanelOp  9
#define imChanelROp 10
#define imChanelCL  11
#define imChanelRCL 12
#define imMaketErr  24
#define imBlMaketErr 25
#define imOpenBlFolder  22
#define imBlFolder  23
//---------------------------------------------------------------------------
class TfmMaketArm : public TMainForm
{
__published:	// IDE-managed Components
  TPanel *Panel2;
  TTreeView *MaketsTree;
  TSplitter *Splitter1;
  TDataSource *dsDataTable;
  TPanel *Panel1;
  TPageControl *MaketInfa;
  TTabSheet *Journal;
  TPanel *Panel5;
  TLabel *TimeStart;
  TPanel *Panel6;
  TLabel *lbMaket;
  TPanel *Panel7;
  TLabel *Label2;
  TLabel *Label4;
  TDateTimePicker *dtFrom;
  TMaskEdit *edFrom;
  TDateTimePicker *dtTill;
  TMaskEdit *edTill;
  TToolBar *ToolBar1;
  TToolButton *tbState0;
  TToolButton *tbState1;
  TToolButton *tbState2;
  TTabSheet *Maket;
  TRichEdit *reMaket;
  TPanel *Panel3;
  TLabel *lbMaketInfo;
  TLabel *lbRepName;
  TSaveDialog *SaveDialog1;
  TToolBar *tbTools;
  TToolButton *tbRun;
  TToolButton *tbLoadMaket;
  TToolButton *tbPreview;
  TToolButton *ToolButton1;
  TToolButton *tbPrint;
  TToolButton *tbSave;
  TMemo *meError;
  TDBGridEh *MessageGrid;
  TToolButton *tbSendM;
  TOraQuery *oqMaketArm;
  TOraQuery *oqRun;
  TTabSheet *OperWork;
  TToolButton *tbOperWork;
  TPrintDBGridEh *PrintMessageGrid;
  TToolButton *tbDel;
  TOraQuery *oqDel;
  TPanel *Panel4;
  TLabel *lbMaketName;
  TLabel *lbMaketState;
  TImage *imMaketState;
  TPanel *Panel8;
  TSpeedButton *SpeedButton1;

  void __fastcall FormShow(TObject *Sender);
  void __fastcall MaketsTreeChange(TObject *Sender, TTreeNode *Node);
  void __fastcall MaketsTreeDeletion(TObject *Sender, TTreeNode *Node);
  void __fastcall dtChange(TObject *Sender);
  void __fastcall edChange(TObject *Sender);
  void __fastcall edExit(TObject *Sender);
  void __fastcall tbStateClick(TObject *Sender);
  void __fastcall tbRunClick(TObject *Sender);
  void __fastcall tbMaketClick(TObject *Sender);
  void __fastcall tbSaveClick(TObject *Sender);
  void __fastcall tbPrintClick(TObject *Sender);
  void __fastcall MaketInfaChange(TObject *Sender);
  void __fastcall mMonClick(TObject *Sender);
  void __fastcall MessageGridDblClick(TObject *Sender);
  void __fastcall MessageGridDrawColumnCell(TObject *Sender,
          const TRect &Rect, int DataCol, TColumnEh *Column,
          TGridDrawState State);
  void __fastcall MessageGridTitleClick(TColumnEh *Column);
  void __fastcall tbSendMClick(TObject *Sender);
  void __fastcall tbOperWorkClick(TObject *Sender);
  void __fastcall MaketsTreeChanging(TObject *Sender, TTreeNode *Node,
          bool &AllowChange);
  void __fastcall MaketsTreeExpanded(TObject *Sender, TTreeNode *Node);
  void __fastcall MaketsTreeExpanding(TObject *Sender, TTreeNode *Node,
          bool &AllowExpansion);
  void __fastcall tbDelClick(TObject *Sender);
  void __fastcall SpeedButton1Click(TObject *Sender);
        void __fastcall MessageGridColumnMoved(TObject *Sender,
          int FromIndex, int ToIndex);
private:	// User declarations
    TfmInteriorUni *FInUn;
    struct MAKET{
        long ObjID;       // идентификатоор объекта
        long ObjType;     // тип объекта 0-шапка, 1-макет, 2-канал
        char Name[130];   //Наименование
        long Blocking;     // блокировка
        char Error[2000]; //  ошибка
        long Parent;      //Главный канал
        char LastSystemCreated[20]; //Дата следующего запуска системой
        int  nPeriod;
        int IsMaket; //Макет=1,Канал УППД=0;
        MAKET(){ ZeroMemory(this,sizeof(*this));}
    };
    struct DEPORTINFO{
       int  state;              //-0-создан 1-отослан 2-ошибка
       int  nMaket;
       char Period[20];
       char Maket[130];
       char MustBeCreated[20];
       char Created[20];
       char Channel[130];
       char Sended[20];
       int  nDelay;
       char IsFull[32];
       char Sender[130];
       char Error[2000];              //  ошибка
       int  nPeriod;
    };
    bool isChange;
    int orderStr;
    
    bool __fastcall ReadTreeNode(TTreeNode *ParentNode);
    void __fastcall ReadNodeInfo(void);
    void __fastcall SetEnabledControls(void);
    int __fastcall GetFolderInd(TTreeNode* Node, bool blocked);
    void __fastcall PrintGrid(void);
    void __fastcall SetLabelState(TLabel *lb,TImage *img);
    //GRB ADD
    int __fastcall getMaketId();
    TStringList* __fastcall getMaketFile();
    TStringList* __fastcall getGroupsInfoByMaketId(int maketId);
    TStringList* __fastcall getPointsNameAndPointsIDByGroupId(AnsiString groupId); //Имя и mid точек в списке разделяются :

    AnsiString __fastcall getMaketType (TStringList*);
    void split(TStringList* lout, char* str, const char* separator){
          for(char* tok = strtok(str, separator); tok; tok = strtok(NULL, separator)) {
          lout->Add(tok);
      }
      return;
    }
public:		// User declarations
    __fastcall TfmMaketArm(TComponent* Owner, AnsiString Name, TAccess a);
    void __fastcall vSave(TObject* Sender);
    void __fastcall vRefresh(TObject* Sender);
    static void __fastcall SaveTable(TComponent* Owner,TDBGridEh *gr,AnsiString RepCaption);
};
//---------------------------------------------------------------------------
//extern PACKAGE TfmMaketArm *fmMaketArm;
//---------------------------------------------------------------------------
#endif
