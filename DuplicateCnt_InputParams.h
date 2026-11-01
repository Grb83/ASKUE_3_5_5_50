//---------------------------------------------------------------------------

#ifndef DuplicateCnt_InputParamsH
#define DuplicateCnt_InputParamsH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Buttons.hpp>
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <ImgList.hpp>
#include <Mask.hpp>
#include "selectpoint.h"

#define MAXPOINT	1000//from selectpoint.cpp
//---------------------------------------------------------------------------

typedef struct { //дерево обьектов учета
                long Gid;
                long Type;
                long HaveChild;
                char Name[148];
                char PointInfo[256];
        }POINTSTREEDEF;
//---------------------------------------------------------------------------

class TfmDuplicateCnt_InputParams  : public TForm
{
__published:	// IDE-managed Components
        TLabel *lbReflect;
        TLabel *lbFrom;
        TLabel *lbTo;
        TDateTimePicker *dtpFrom;
        TDateTimePicker *dtpTo;
        TCheckBox *cbAll;
  TTreeView *tvMain;
  TBitBtn *bbOk;
  TBitBtn *bbCancel;
  TPanel *Panel1;
    TPanel *paEdit;
  TImageList *iImageList;
  TPanel *Panel2;
        void __fastcall tvMainChange(TObject *Sender, TTreeNode *Node);
        void __fastcall bbOkClick(TObject *Sender);
        void __fastcall cbAllClick(TObject *Sender);
  void __fastcall tvMainExpanding(TObject *Sender, TTreeNode *Node,
          bool &AllowExpansion);
  void __fastcall tvMainExpanded(TObject *Sender, TTreeNode *Node);
  void __fastcall tvMainCollapsed(TObject *Sender, TTreeNode *Node);
private:	// User declarations
        TDateTime dtFrom,dtTo;
//        bool __fastcall ReadNode(TTreeNode* NodeParent);
        bool __fastcall ReadNode(TObject* Sender, TObject* ParentNode);
public:		// User declarations
        GROUPDATAFORM *pointPOL;
        POINTSTREEDEF RootPoint;
//        char RootName[150];//name of root point, if we edit or add switch
        __fastcall TfmDuplicateCnt_InputParams(TComponent* Owner,GROUPDATAFORM* sfd);
        void __fastcall Main(void);
};
//---------------------------------------------------------------------------
extern PACKAGE TfmDuplicateCnt_InputParams *fmDuplicateCnt_InputParams;
//---------------------------------------------------------------------------
#endif
