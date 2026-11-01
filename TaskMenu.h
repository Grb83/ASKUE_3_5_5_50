//---------------------------------------------------------------------------
#ifndef TaskMenuH
#define TaskMenuH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <ComCtrls.hpp>
#include <Buttons.hpp>
#include <Mask.hpp>
#include <ImgList.hpp>
#include <jpeg.hpp>
//---------------------------------------------------------------------------
class TTaskMenuForm : public TForm
{
__published:	// IDE-managed Components
	TPanel *Panel2;
   TTreeView *tvTasks;
	TPanel *Panel4;
   TPanel *Panel1;
        TImageList *ImageList2;
        TSplitter *Splitter1;
        TTreeView *TreeView1;
    TPanel *Panel3;
    TBitBtn *BitBtn2;
	void __fastcall btnCloseClick(TObject *Sender);
	void __fastcall tvTasksDblClick(TObject *Sender);
	void __fastcall FormShow(TObject *Sender);
   void __fastcall tvTasksDeletion(TObject *Sender, TTreeNode *Node);
   void __fastcall tvTasksExpanding(TObject *Sender, TTreeNode *Node,
          bool &AllowExpansion);
   void __fastcall TreeView1ExpCol(TObject *Sender, TTreeNode *Node);
   void __fastcall FormCreate(TObject *Sender);
   void __fastcall FormClose(TObject *Sender, TCloseAction &Action);
        void __fastcall tvTasksChange(TObject *Sender, TTreeNode *Node);
    void __fastcall tvKeyDown(TObject *Sender, WORD &Key,
          TShiftState Shift);
private:	// User declarations
   typedef struct { //task list
      int Task_id;
      int Parent;
      AnsiString TaskName;
      int NumberTask;
      int fullacc;
      TASKLIST(){Task_id=0;Parent=0;TaskName="";NumberTask=0;fullacc=0;}
   }TASKLIST;
   void __fastcall RunTask(AnsiString Name, int Id, int);
public:		// User declarations
   bool __fastcall ReadTreeNode(TTreeNode* NodeParent);// Читает ветку дерева
	__fastcall TTaskMenuForm(TComponent* Owner);
protected:
   __fastcall ~TTaskMenuForm();
};
//---------------------------------------------------------------------------
extern TTaskMenuForm *TaskMenuForm;
//---------------------------------------------------------------------------
#endif
