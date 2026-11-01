//---------------------------------------------------------------------------
#ifndef SaveMonitorAsH
#define SaveMonitorAsH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <Buttons.hpp>
#include <Mask.hpp>
#include <ComCtrls.hpp>
#include <ImgList.hpp>
//---------------------------------------------------------------------------
enum WindowType {wtSaveAs, wtEdit};
struct stMonitors
{  //МОНИТОРЫ
	 long Monitor_Id;
	 long MSchema;
	 char Name[150];
	 long DSize;
    long HaveChild;
    long State; // 0-не трогали 1-добавили 2-изменили
};
class TfmSaveMonitorAs : public TForm
{
__published:	// IDE-managed Components
        TPanel *Panel2;
        TLabel *Label1;
        TCheckBox *CheckBox1;
        TPanel *Panel3;
        TTreeView *tvMonitors;
        TPanel *Panel4;
        TImageList *ImageList1;
        TPanel *Panel1;
        TBitBtn *bbAddGroup;
        TBitBtn *bbInsGroup;
        TPanel *Panel5;
        TBitBtn *bbDel;
        TEdit *eMonitorName;
        TBitBtn *bbEdit;
        TPanel *Panel6;
        TBitBtn *btOk;
        TBitBtn *btCancel;
	void __fastcall btOkClick(TObject *Sender);
        void __fastcall tvMonitorsCollapsed(TObject *Sender,
          TTreeNode *Node);
        void __fastcall tvMonitorsExpanded(TObject *Sender,
          TTreeNode *Node);
        void __fastcall tvMonitorsExpanding(TObject *Sender,
          TTreeNode *Node, bool &AllowExpansion);
        void __fastcall bbAddGroupClick(TObject *Sender);
        void __fastcall bbInsGroupClick(TObject *Sender);
        void __fastcall tvMonitorsChange(TObject *Sender, TTreeNode *Node);
        void __fastcall tvMonitorsEdited(TObject *Sender, TTreeNode *Node,
          AnsiString &S);
        void __fastcall FormCloseQuery(TObject *Sender, bool &CanClose);
        void __fastcall bbEditClick(TObject *Sender);
        int __fastcall ShowModal_Form(WindowType aWinType);
        void __fastcall bbDelClick(TObject *Sender);
        void __fastcall tvMonitorsDeletion(TObject *Sender,
          TTreeNode *Node);
   void __fastcall tvMonitorsDragOver(TObject *Sender, TObject *Source,
          int X, int Y, TDragState State, bool &Accept);
   void __fastcall tvMonitorsDragDrop(TObject *Sender, TObject *Source,
          int X, int Y);
private:	// User declarations
    bool __fastcall FindMonitorName(TTreeNode *aNode);
    bool TreeIsEdit;
    long *Monitors_Del; // id тех мониторов которые удалены списка
                              //  и необходимо удалить из таблицы
    int Monitors_Del_Count;
    WindowType FWinType;
public:		// User declarations
	__fastcall TfmSaveMonitorAs(TComponent* Owner);
	virtual __fastcall ~TfmSaveMonitorAs();
        bool __fastcall ReadTreeNode(TTreeNode* NodeParent);// Читает ветку дерева
        void __fastcall AddInsGroup(TTreeNode *Node);
        bool __fastcall tvMonitorsSave();
        long Monitor_Id, nParent;
};
//---------------------------------------------------------------------------
extern TfmSaveMonitorAs *fmSaveMonitorAs;
//---------------------------------------------------------------------------
#endif
