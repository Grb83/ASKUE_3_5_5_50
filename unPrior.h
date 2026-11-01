//---------------------------------------------------------------------------

#ifndef unPriorH
#define unPriorH
//---------------------------------------------------------------------------
#define  WM_INSERT_FORMULA (WM_USER+51)//
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "DBAccess.hpp"
#include "MemDS.hpp"
#include "Ora.hpp"
#include <ComCtrls.hpp>
#include <DB.hpp>
#include <ImgList.hpp>
#include <ToolWin.hpp>
#include <ActnList.hpp>
#include <ExtCtrls.hpp>
#include <Buttons.hpp>
//---------------------------------------------------------------------------
class TfmPrior : public TForm
{
__published:	// IDE-managed Components
  TTreeView *tvHistory;
  TToolBar *ToolBar1;
  TToolButton *tbAdd;
  TToolButton *tbDel;
  TImageList *Images;
  TActionList *Actions;
  TAction *acAdd;
  TAction *acDel;
  TPanel *plHistory;
  TOraQuery *oqPrior;
  TPanel *Panel1;
  TPanel *Panel2;
  TPanel *plEditDate;
  TDateTimePicker *dtStart;
  TDateTimePicker *dtEnd;
  TLabel *lbDStart;
  TLabel *lbDEnd;
  TToolButton *ToolButton5;
  TToolButton *tbFUp;
  TToolButton *tbUp;
  TToolButton *tbDown;
  TToolButton *tbEDown;
  TSpeedButton *sbOk;
  TLabel *Label1;
  TToolButton *ToolButton1;
  TToolButton *tbRefresh;
  TToolButton *tbSave;
  TBitBtn *BitBtn1;
  TOraQuery *oqTest;
  void __fastcall FormCreate(TObject *Sender);
  void __fastcall acAddExecute(TObject *Sender);
  void __fastcall acDelExecute(TObject *Sender);
  void __fastcall tvHistoryExpanded(TObject *Sender, TTreeNode *Node);
  void __fastcall tvHistoryCollapsed(TObject *Sender, TTreeNode *Node);

  void __fastcall Refresh();
  void __fastcall vSave();

   
  void __fastcall tvHistoryChange(TObject *Sender, TTreeNode *Node);
  void __fastcall dtStartChange(TObject *Sender);
  void __fastcall tbUpClick(TObject *Sender);
  void __fastcall tbDownClick(TObject *Sender);
  void __fastcall sbOkClick(TObject *Sender);
  void __fastcall tbFUpClick(TObject *Sender);
  void __fastcall tbEDownClick(TObject *Sender);
  void __fastcall tbSaveClick(TObject *Sender);
  void __fastcall tbRefreshClick(TObject *Sender);
  void __fastcall BitBtn1Click(TObject *Sender);
private:	// User declarations
  void __fastcall ReadNode(long Parent);
  void __fastcall ReadNodePrior(TTreeNode* ParNode);
  bool __fastcall ReadNodeAdd(TTreeNode* ParNode);
  bool fullacc;
public: 	// User declarations

  long Parent;
  struct SPrior
    {      // структура таблицы пользователей
    long mid;             //ид объекта
    short ntype;          //  1-зеленая, 0-дата папка, 2-синяя
    long norder;         //приоритет
    AnsiString vname;     //название
    TDateTime dstart;
    TDateTime dend;
    TDateTime olddstart;
    TDateTime olddend;
    int editing; //1-перестановка, 2-изменение времени,3-добавление нового
    SPrior(){
    mid=0;
    ntype=0;
    norder =0;
    vname="";
    dstart = Date();
    dend=Date()+1;
    olddstart = Date();
    olddend=Date()+1;
    editing=0;}
    };

   // TTreeNode* Bufer;
  __fastcall TfmPrior(TComponent* Owner,long Mid,bool fullacc);
};
//---------------------------------------------------------------------------
extern PACKAGE TfmPrior *fmPrior;
//---------------------------------------------------------------------------
#endif
