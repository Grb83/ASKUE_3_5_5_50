//---------------------------------------------------------------------------

#ifndef unTreeH
#define unTreeH
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
//---------------------------------------------------------------------------
class TfmTree : public TForm
{
__published:	// IDE-managed Components
  TTreeView *tvFunctions;
  TToolBar *ToolBar1;
  TToolButton *ToolButton1;
  TToolButton *ToolButton2;
  TToolButton *ToolButton3;
  TToolButton *ToolButton4;
  TOraQuery *oqTree;
  TImageList *Images;
  TActionList *Actions;
  TAction *acAdd;
  TAction *acDel;
  TAction *acEdit;
  TAction *acCopy;
  TOraQuery *oqDel;
  TOraQuery *oqSaveFunc;
  void __fastcall FormCreate(TObject *Sender);
  void __fastcall acAddExecute(TObject *Sender);
  void __fastcall acDelExecute(TObject *Sender);
  void __fastcall acEditExecute(TObject *Sender);
  void __fastcall acCopyExecute(TObject *Sender);
  void __fastcall tvFunctionsExpanded(TObject *Sender, TTreeNode *Node);
  void __fastcall tvFunctionsCollapsed(TObject *Sender, TTreeNode *Node);
  void __fastcall tvFunctionsGetSelectedIndex(TObject *Sender,
          TTreeNode *Node);
  void __fastcall tvFunctionsExpanding(TObject *Sender, TTreeNode *Node,
          bool &AllowExpansion);

  void __fastcall Refresh();
  void __fastcall tvFunctionsDragOver(TObject *Sender, TObject *Source,
          int X, int Y, TDragState State, bool &Accept);
  void __fastcall tvFunctionsDragDrop(TObject *Sender, TObject *Source,
          int X, int Y);
  void __fastcall tvFunctionsDeletion(TObject *Sender, TTreeNode *Node);
  void __fastcall tvFunctionsKeyDown(TObject *Sender, WORD &Key,
          TShiftState Shift);
private:	// User declarations
  void __fastcall ReadNode(TTreeNode* ParentNode);
public:		// User declarations
  struct SFunction
    {      // структура таблицы пользователей
    long nid;             //ид объекта
    long nparent;         //ид родителя
    short ntype;          //  0-папка, 1-формула, 2-функция
    AnsiString vname;     //название
    AnsiString vvalue;    //содержание
    AnsiString vmemo;     //описание
    SFunction(){nid=0;nparent=0;ntype=0;vname="";vvalue="";vmemo="";}
    };

    TTreeNode* Bufer;
  __fastcall TfmTree(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfmTree *fmTree;
//---------------------------------------------------------------------------
#endif
