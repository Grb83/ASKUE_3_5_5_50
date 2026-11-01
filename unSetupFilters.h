//---------------------------------------------------------------------------

#ifndef unSetupFiltersH
#define unSetupFiltersH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Buttons.hpp>
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <ImgList.hpp>
#include <ToolWin.hpp>
#include <ActnList.hpp>
#include <Menus.hpp>
//---------------------------------------------------------------------------
class TfmSetupFilters : public TForm
{
__published:	// IDE-managed Components
  TPanel *Panel10;
  TPanel *Panel1;
  TBitBtn *BitBtn2;
  TBitBtn *btSave;
  TPanel *Panel2;
  TToolBar *ToolBar1;
  TToolButton *tbRefresh;
  TToolButton *ToolButton5;
  TImageList *ifMenu;
  TTreeView *tvFilter;
  TTreeView *tvEvent;
  TPanel *plFilters;
  TPanel *plEvents;
  TPanel *plNameF;
  TPanel *plNameE;
  TSplitter *Splitter1;
  TImageList *iImageList;
  TToolButton *tbDelete;
  TActionList *alDefault;
  TAction *iaSave;
  TAction *iaRefresh;
  TAction *iaNew;
  TAction *iaDelete;
  TAction *iaClose;
  TBitBtn *btOk;
  void __fastcall FormShow(TObject *Sender);
  void __fastcall tvExpanded(TObject *Sender, TTreeNode *Node);
  void __fastcall tvFilterExpanding(TObject *Sender, TTreeNode *Node,
          bool &AllowExpansion);
  void __fastcall tvEventExpanding(TObject *Sender, TTreeNode *Node,
          bool &AllowExpansion);
  void __fastcall tvFilterDeletion(TObject *Sender, TTreeNode *Node);
  void __fastcall tvFilterDragDrop(TObject *Sender, TObject *Source, int X,
          int Y);
  void __fastcall tvFilterDragOver(TObject *Sender, TObject *Source, int X,
          int Y, TDragState State, bool &Accept);
  void __fastcall tvFilterChange(TObject *Sender, TTreeNode *Node);
  void __fastcall vSave(TObject* Sender);
  void __fastcall vRefresh(TObject* Sender);
  void __fastcall vDelete(TObject* Sender);
  void __fastcall tvFilterKeyUp(TObject *Sender, WORD &Key,
          TShiftState Shift);
  void __fastcall tvFilterEdited(TObject *Sender, TTreeNode *Node,
          AnsiString &S);
  void __fastcall iaCloseExecute(TObject *Sender);
private:	// User declarations
    typedef struct {
        long Id;
        long tmpId; // для хранения новых Id
        long Type;
        long HaveChild;
        char Name[256];
        char PointInfo[256];
        long editing;// 0 -Не трогали, 1-трогали
        long Id_event;
    }POINTSDIV;
    long CountFilters_Del; // Кол-во удаляемых фильтров
    long nFilters_Del[10000]; // id тех фильтров, которые удалены из дерева
                              //  и необходимо удалить из таблицы FILTERS
    bool realdeletion;
  bool __fastcall ReadNode(TTreeView* tv,TTreeNode* NodeParent);// Читает ветку дерева Фильтров или Сообщений
  void __fastcall changeNode(TTreeNode*,TTreeNode*);
  void __fastcall copyChildNodes(TTreeNode*, TTreeNode*);
  bool __fastcall tvCheckDragOver(TTreeNode*,TTreeNode*);


public:		// User declarations
  __fastcall TfmSetupFilters(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfmSetupFilters *fmSetupFilters;
//---------------------------------------------------------------------------
#endif
