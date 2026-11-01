//---------------------------------------------------------------------------
#ifndef Saa_SelectFormH
#define Saa_SelectFormH
#define SAA_MAXCOUNTFORMS 112
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <ComCtrls.hpp>
#include <Buttons.hpp>
#include <ImgList.hpp>
#include "FormDescr.h"
#include "DBAccess.hpp"
#include "MemDS.hpp"
#include "Ora.hpp"
#include <DB.hpp>
//---------------------------------------------------------------------------
int GetStepProfileInv(TFormDescr::TStepProfie i);
int GetStepProfile(int i);
//---------------------------------------------------------------------------
class TfmSelectReportForm : public TForm
{
__published:	// IDE-managed Components
	TPanel *Panel2;
	TTreeView *tvMain;
	TPanel *Panel3;
	TBitBtn *btCancel;
	TBitBtn *btNext;
	TImageList *ilMain;
	TLabel *Label1;
  TOraQuery *quMain1;
	void __fastcall FormCreate(TObject *Sender);
	void __fastcall FormShow(TObject *Sender);
	void __fastcall btNextClick(TObject *Sender);
	void __fastcall tvMainChange(TObject *Sender, TTreeNode *Node);
	void __fastcall tvMainExpanding(TObject *Sender, TTreeNode *Node, bool &AllowExpansion);
private:	// User declarations
	typedef struct {  // ‘Œ–Ã€ Œ“◊®“Œ¬
	 int Level;
	 long Fid;
	 char NameForm[200];
	 int CodeTemplate;
  }REPORTFORM;
   long fID;
   HCURSOR hCursor;
public:		// User declarations
   typedef struct {  //ÕÓ‚‡ˇ √”œœ€ Œ“◊®“Œ¬
	  int Level;
  	long Gid;
	  char Name[150];
    int Mid;
   }NEWREPORTGROUP;
 	typedef struct {  //«¿ƒ¿◊»
	 int Level;
	 long Task_Id;
	 long Task_Cod;
	 char Name[100];
  }MYTASKS;
	__fastcall TfmSelectReportForm(TComponent* Owner,long id_Fid, TFormDescr* = NULL);
   TFormDescr *fd;
   static int __fastcall AddPoints(TTreeView*,TTreeNode*,int,int, int lmid=-1);
   static bool __fastcall GetSelectedTree(TTreeView*,TFormDescr*);
   //16.04.2021 GRB ADD
   static bool __fastcall GetSelectedTreeG(TTreeView*,TFormDescr*);
   static bool __fastcall GetSelectedTreeP(TTreeView*,TFormDescr*);
};
//---------------------------------------------------------------------------
extern TfmSelectReportForm *fmSelectReportForm;
//---------------------------------------------------------------------------
#endif
