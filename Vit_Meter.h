//---------------------------------------------------------------------------
#ifndef Vit_MeterH
#define Vit_MeterH
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
struct strPOINTDATAFORM{ // Выбор данных пользователем
   long mid;
   int ifpoint;
   int entype[6];
   TDateTime myTime;
   TDateTime myStep; // Add by KSS
   bool usetime;
   bool usestep; // Add by KSS
   
   strPOINTDATAFORM::strPOINTDATAFORM(){
      ifpoint=1;
      myStep = StrToTime("00:30");
      entype[0]=1;
      entype[1]=2;
      entype[2]=3;
      entype[4]=5;

    }

   strPOINTDATAFORM& strPOINTDATAFORM::operator =(const strPOINTDATAFORM& a){
      mid = a.mid;
      ifpoint=a.ifpoint;
      memcpy(entype, a.entype, sizeof(entype));
      myTime = a.myTime;
      myStep = a.myStep;
      usetime = a.usetime;
      usestep = a.usestep; // Add by KSS
      return *this;
   }
};
typedef struct strPOINTDATAFORM POINTDATAFORM;
//---------------------------------------------------------------------------
class TFormVVMeter : public TForm
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
  TPanel *paTime;
  TPanel *Panel9;
  TPanel *Panel12;
  TMaskEdit *seltime;
  TImageList *ilMain;
   TPanel *paStep;
   TPanel *Panel14;
   TPanel *Panel15;
   TMaskEdit *selstep;
  TActionList *ActionList1;
  TAction *iaFind;
  TSpeedButton *sbFind;
	void __fastcall tvMainChange(TObject *Sender, TTreeNode *Node);
	void __fastcall FormCreate(TObject *Sender);
	void __fastcall btOkClick(TObject *Sender);
  void __fastcall tvMainExpanding(TObject *Sender, TTreeNode *Node,
          bool &AllowExpansion);
  void __fastcall tvMainExpCol(TObject *Sender, TTreeNode *Node);
  void __fastcall vFindClick(TObject *Sender);
  void __fastcall WM_SetActiveNode(TMessage& Message);
  void __fastcall FormDestroy(TObject *Sender);

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
  void __fastcall FindCurrNodeGroup(long id);
  long __fastcall GetNodeId(TObject*obj){
        TTreeNode* tn=dynamic_cast<TTreeNode*>(obj);
        if(tn)  return ((POINTSTREEDEF*)tn->Data)->Mid;
        else    return 0;
  }

  POINTDATAFORM *pointPOL;
   TfmFindPoint *fmFP;
public:		// User declarations
    __fastcall TFormVVMeter(TComponent* Owner,POINTDATAFORM* sfd);

protected:
  
  BEGIN_MESSAGE_MAP
      MESSAGE_HANDLER((WM_SETACTIVENODE),TMessage, WM_SetActiveNode)
	END_MESSAGE_MAP(TForm) 
};
//---------------------------------------------------------------------------
extern TFormVVMeter *FormVVMeter;
//---------------------------------------------------------------------------
#endif
