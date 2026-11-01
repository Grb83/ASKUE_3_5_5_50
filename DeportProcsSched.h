//---------------------------------------------------------------------------
#ifndef DeportProcsSchedH
#define DeportProcsSchedH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <ImgList.hpp>
#include <Buttons.hpp>
#include "DeportProcs.h"
//---------------------------------------------------------------------------
class TfmDeportProcsSched : public TForm
{
__published:	// IDE-managed Components
  TListView *lvProcess;
  TImageList *ilMain;
  TPanel *Panel1;
  TLabel *Label5;
  TEdit *eParam;
  TLabel *Label1;
  TLabel *Label2;
  TEdit *eNote;
   TMemo *eError;
  TPanel *Panel2;
  TPanel *Panel3;
  TBitBtn *bbRunProcess;
  TPanel *Panel4;
  TPanel *Panel5;
  TTreeView *ProcessTree;
  TSplitter *Splitter1;
  TBitBtn *m_btnClose;
  void __fastcall Button4Click(TObject *Sender);
  void __fastcall bbRunProcessClick(TObject *Sender);
  void __fastcall FormShow(TObject *Sender);
  void __fastcall lvProcessDeletion(TObject *Sender, TListItem *Item);
  void __fastcall lvProcessChange(TObject *Sender, TListItem *Item
    ,
    TItemChange Change
    );
  void __fastcall ProcessTreeExpanding(TObject *Sender, TTreeNode *Node,
          bool &AllowExpansion);
  void __fastcall ProcessTreeDeletion(TObject *Sender, TTreeNode *Node);
  void __fastcall ProcessTreeExpanded(TObject *Sender, TTreeNode *Node);
  void __fastcall ProcessTreeChange(TObject *Sender, TTreeNode *Node);
private:	// User declarations
  int __fastcall GetFolderInd(TTreeNode* Node, bool blocked);
public:		// User declarations
  __fastcall TfmDeportProcsSched(TComponent* Owner);
  stProcesses *SelProcess;
  void __fastcall ReadProcesses(TTreeNode *ParentNode, bool addfolders);
};

//---------------------------------------------------------------------------
extern PACKAGE TfmDeportProcsSched *fmDeportProcsSched;
//---------------------------------------------------------------------------
#endif
