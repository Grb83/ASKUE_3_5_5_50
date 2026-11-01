//---------------------------------------------------------------------------
#ifndef ManualInTreeH
#define ManualInTreeH
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
#include <Menus.hpp>
#include <ActnList.hpp>
//---------------------------------------------------------------------------
struct strPOINTDATA{ // Выбор данных пользователем
   long mid;
   int ifpoint;
   int entype[6];
   TDateTime myTime;
   TDateTime myStep; // Add by KSS
   int   Step;
   bool usetime;
   bool usestep; // Add by KSS

   strPOINTDATA::strPOINTDATA(){
      ifpoint=1;
      myTime = StrToDateTime("01.01.2009 00:00:00");//TDateTime::CurrentDate();
      myStep = StrToTime("00:00:00");
      Step =1;
      entype[0]=1;
      entype[1]=2;
      entype[2]=3;
      entype[4]=5;
      usetime = false;
    }

   strPOINTDATA& strPOINTDATA::operator =(const strPOINTDATA& a){
      mid = a.mid;
      ifpoint=a.ifpoint;
      memcpy(entype, a.entype, sizeof(entype));
      myTime = a.myTime;
      myStep = a.myStep;
      Step=a.Step;
      usetime = a.usetime;
      usestep = a.usestep; // Add by KSS
      return *this;
   }
};
typedef struct strPOINTDATA POINTDATA;
//---------------------------------------------------------------------------
class TFormManualInTree : public TForm
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
   TPanel *paStep;
   TPanel *Panel14;
   TPanel *Panel15;
  
  TSpeedButton *sbFind;
  TRadioGroup *RadioGroupProfilePower;
  TActionList *ActionList1;
  TAction *iaFind;
  TPanel *paTime;
  TPanel *Panel9;
  TPanel *Panel12;
  TMaskEdit *seltime;
	void __fastcall tvMainChange(TObject *Sender, TTreeNode *Node);
	void __fastcall FormCreate(TObject *Sender);
	void __fastcall btOkClick(TObject *Sender);
  void __fastcall tvMainExpanding(TObject *Sender, TTreeNode *Node,
          bool &AllowExpansion);
  void __fastcall tvMainExpCol(TObject *Sender, TTreeNode *Node);
  void __fastcall vFindClick(TObject *Sender);
  void __fastcall WM_SetActiveNode(TMessage& Message);
  void __fastcall FormDestroy(TObject *Sender);
  void __fastcall seldateChange(TObject *Sender);

private:	// User declarations

	typedef struct { //дерево обьектов учета
    long Mid;
    long Type;
    long HaveChild;
    char Name[148];
    long IfPoint;
	}POINTSTREEDEF;
  bool __fastcall ReadNode(TTreeNode* NodeParent);// Читает ветку дерева Точек
  void __fastcall FindCurrNode(void);
  //GRB ADD 09.03.2021 - добавляем размотчик для поиска в дереве групп, его тянем из EditGroupsList
      typedef struct {
        long Id;
        long Type;
        char Name[150];
        char Short_Name[50];
        char InfoArea[256];
        long nLimits;
        long avbron;
        long techbron;
        long nSum;
        long inverted;
        long editing;// 0 -Не трогали, 1-трогали
        long editlim;
        TList *plim;
        long tmpId;
        char vparameter[256];
        long PartlyCalc;
        long nfromperiod;
        long ntillperiod;
        double nkc;
    }POINTSDIV;
  long __fastcall GetNodeId(TObject*obj){
        TTreeNode*tn=dynamic_cast<TTreeNode*>(obj);
        if(tn)  return ((POINTSDIV*)tn->Data)->Id;
        else    return 0;
    }

  void __fastcall FindCurrNodeGroup(long id);

  //END ADD

  POINTDATA *pointPOL;
   TfmFindPoint *fmFP;
   int _from_points;
public:		// User declarations
    __fastcall TFormManualInTree(TComponent* Owner,POINTDATA* sfd);
    __fastcall TFormManualInTree(TComponent* Owner,POINTDATA* sfd, int open_from_points);

protected:
  
  BEGIN_MESSAGE_MAP
      MESSAGE_HANDLER((WM_SETACTIVENODE),TMessage, WM_SetActiveNode)
	END_MESSAGE_MAP(TForm) 
};
//---------------------------------------------------------------------------
extern TFormManualInTree *FormManualInTree;
//---------------------------------------------------------------------------
#endif
