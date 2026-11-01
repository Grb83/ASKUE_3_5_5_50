//---------------------------------------------------------------------------
#ifndef ChangeCountersH
#define ChangeCountersH
//---------------------------------------------------------------------------
#include <Buttons.hpp>
#include <Classes.hpp>
#include <ComCtrls.hpp>
#include <Controls.hpp>
#include <ExtCtrls.hpp>
#include <ImgList.hpp>
#include <StdCtrls.hpp>
#include "Main.h"
#include "FindPoint.h"
#include <ActnList.hpp>
#include <Menus.hpp>
#include "DBAccess.hpp"
#include "MemDS.hpp"
#include "Ora.hpp"
#include <DB.hpp>
//---------------------------------------------------------------------------
class TFormChangeCounters : public TMainForm
{
__published:	// IDE-managed Components
	TPanel *Panel3;
	TPanel *Panel4;
	TPanel *Panel5;
	TPanel *Panel7;
	TPanel *Panel8;
	TPanel *Panel9;
   TTreeView *tvMain;
	TPanel *Panel10;
	TPanel *Panel14;
   TRadioGroup *rg1;
	TGroupBox *GroupBox1;
	TPanel *Panel6;
   TCheckBox *cb1;
   TCheckBox *cb2;
   TCheckBox *cb3;
   TCheckBox *cb5;
   TCheckBox *cb4;
   TDateTimePicker *dtPicker;
  TBitBtn *btFind;
  TBitBtn *btInput;
  TBitBtn *bbDel;
  TOraQuery *oqChMeter;
	void __fastcall tvMainChange(TObject *Sender, TTreeNode *Node);
	void __fastcall rg1Click(TObject *Sender);
   void __fastcall tvMainExpCol(TObject *Sender, TTreeNode *Node);
   void __fastcall tvMainDeletion(TObject *Sender, TTreeNode *Node);
   void __fastcall tvMainExpanding(TObject *Sender, TTreeNode *Node,
          bool &AllowExpansion);
   void __fastcall FormCreate(TObject *Sender);
  void __fastcall vFindClick(TObject *Sender);
  void __fastcall FormDestroy(TObject *Sender);
  void __fastcall btInputClick(TObject *Sender);
  void __fastcall bbDelClick(TObject *Sender);
private:	// User declarations
   typedef struct { //дерево обьектов учета
      long Mid;
      long Type; //= 1 - enterprise, 2-station, 3-point, 4-точка учета
      char Name[148];
      long ER_POSITION;	//NUMBER, активная принятая энергия
      long Q1_POSITION;	//NUMBER, реактивная принятая энергия
      long ED_POSITION;	//NUMBER, активная отданая энергия
      long Q3_POSITION;	//NUMBER, реактивная отданая энергия
      long SMART;	//VARCHAR2(1), признак интел. счетчика
      double KC;		    //NUMBER, расчетный коэф.
      long editing;// Есть дети
   }POINTSDIV;
   //----------------------------------VNB 13.05.08
   typedef struct {
    long Mid;
    TDateTime date;
    
    //char date[20];
    char entype[6];
    int type;
   }CHANGEMETERS;
   //-----------------------------------------------
   TCheckBox *cb[5];
   long olditemindex;
 //  bool __fastcall ReadNode(TTreeNode* NodeParent);// Читает ветку дерева Точек
   bool __fastcall ReadNode(TObject*obj);
  
   void __fastcall SetAccess(TAccess value);
    void __fastcall WM_SetActiveNode(TMessage& Message);
    TfmFindPoint *fmFP;
  
public:		// User declarations
	__fastcall TFormChangeCounters(TComponent* Owner, AnsiString, TAccess = accDenied);
   void __fastcall vSave(TObject* Sender);

protected:
   void __fastcall vRefresh(TObject* Sender);
    long __fastcall getNodeId(TObject*obj){
        TTreeNode*tn=dynamic_cast<TTreeNode*>(obj);
        if(tn)  return ((POINTSDIV*)tn->Data)->Mid;
        else    return 0;
       } 
};
//---------------------------------------------------------------------------
#endif

