//---------------------------------------------------------------------------
#ifndef selectpointH
#define selectpointH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <Buttons.hpp>
#include <ComCtrls.hpp>
#include <Mask.hpp>
#include <ImgList.hpp>
#include "FindPoint.h"
#include <ActnList.hpp>
#include "DBAccess.hpp"
#include "MemDS.hpp"
#include "Ora.hpp"
#include <DB.hpp>
//---------------------------------------------------------------------------
struct strGROUPDATAFORM{ // Выбор данных пользователем
   long gid;
   int entype[6];
   TDateTime myTime;
   int type;
   char Name[148];
   char Meas[64];
   int IsPoint;
   TList *pmeas;
   int HelpContext;
   strGROUPDATAFORM():type(0),gid(0),IsPoint(0),HelpContext(0),myTime(TDateTime::CurrentDateTime()){;}
   strGROUPDATAFORM(AnsiString Meas);
   strGROUPDATAFORM& strGROUPDATAFORM::operator =(const strGROUPDATAFORM& a){
      gid = a.gid;
      memcpy(entype, a.entype, sizeof(entype));
      myTime = a.myTime;
      type = a.type;
      strcpy(Name, a.Name);
      strcpy(Meas, a.Meas);
      IsPoint=a.IsPoint;
      pmeas=a.pmeas;
      return *this;
   }
};
typedef struct strGROUPDATAFORM GROUPDATAFORM;
//---------------------------------------------------------------------------
class TfmSelectPoint : public TForm
{
__published:	// IDE-managed Components
	TPanel *Panel2;
	TPanel *Panel3;
	TBitBtn *btOk;
	TPanel *Panel4;
  TPanel *paEdit;
	TPanel *Panel6;
	TPanel *Panel7;
	TTreeView *tvMain;
	TPanel *Panel8;
	TPanel *Panel10;
	TPanel *Panel11;
	TPanel *Panel13;
	TBitBtn *btCancel;
  TLabel *lbCaption;
	TGroupBox *GroupBox1;
	TCheckBox *CheckBox2;
	TCheckBox *CheckBox3;
	TCheckBox *CheckBox4;
	TCheckBox *CheckBox1;
  TDateTimePicker *seldate;
  TPanel *Panel1;
  TImageList *ilMain;
   TMemo *mInfoArea;
  TActionList *ActionList1;
  TAction *iaFind;
  TSpeedButton *sbFind;
  TPanel *PanelMeas;
  TTreeView *TreeViewMeas;
  TPanel *Panel9;
  TOraQuery *oqMeas;
  TLabel *Label3;
  TEdit *lbId;
  TPanel *Panel5;
	void __fastcall tvMainChange(TObject *Sender, TTreeNode *Node);
	void __fastcall FormCreate(TObject *Sender);
	void __fastcall btOkClick(TObject *Sender);
  void __fastcall tvMainExpanding(TObject *Sender, TTreeNode *Node,
          bool &AllowExpansion);
  void __fastcall tvMainExpCol(TObject *Sender, TTreeNode *Node);
  void __fastcall vFindClick(TObject *Sender);
  void __fastcall WM_SetActiveNode(TMessage& Message);
  void __fastcall FormDestroy(TObject *Sender);
  void __fastcall TreeViewMeasDeletion(TObject *Sender, TTreeNode *Node);
 
private:	// User declarations
	struct POINTSTREEDEF{ //дерево обьектов учета
      long Gid;
      long Type;
      long HaveChild;
      char Name[148];
      char PointInfo[256];
      int IsPoint;
      TList *pmeas;
   //   int Sort;
	};
  struct MEASURES{ //дерево типов измерений
      long Mid;
      long Type;
      char Name[64];
      char Code[16];
      MEASURES(){ZeroMemory(this,sizeof(*this));}
  };
int Count;
   bool __fastcall ReadNode(TObject* Sender, TObject* ParentNode, long type);
 //  bool __fastcall ReadNodeMeas(TObject* Sender,int type);
 bool __fastcall ReadNodeMeas(TObject* Sender,TTreeNode *sNode);
   GROUPDATAFORM *pointPOL;
    TfmFindPoint *fmFP;
public:		// User declarations
   void __fastcall FindCurrNode(TObject*Sender, long mid, long type,int IsPoint);
   __fastcall TfmSelectPoint(TComponent* Owner,GROUPDATAFORM* sfd);
protected:

  BEGIN_MESSAGE_MAP
      MESSAGE_HANDLER((WM_SETACTIVENODE),TMessage, WM_SetActiveNode)
	END_MESSAGE_MAP(TForm)

};
//---------------------------------------------------------------------------
extern TfmSelectPoint *fmSelectPoint;
//---------------------------------------------------------------------------
#endif
