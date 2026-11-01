//---------------------------------------------------------------------------
#ifndef EditGroupsListH
#define EditGroupsListH
//---------------------------------------------------------------------------
#include <ActnList.hpp>
#include <Buttons.hpp>
#include <Classes.hpp>
#include <ComCtrls.hpp>
#include <Controls.hpp>
#include <Db.hpp>
#include <DBCtrls.hpp>
#include <DBGrids.hpp>
#include <ExtCtrls.hpp>
#include <Grids.hpp>
#include <ImgList.hpp>
#include <StdCtrls.hpp>
#include <VirtualTable.hpp>
#include "Main.h"
#include <Menus.hpp>
#include <DB.hpp>
#include "DBAccess.hpp"
#include "MemDS.hpp"
#include "Ora.hpp"
#include <Mask.hpp>
#include "FindPoint.h"
//---------------------------------------------------------------------------
class TFormEditGropsList : public TMainForm
{
__published:	// IDE-managed Components
	TPanel *Panel6;
	TPanel *Panel7;
	TPanel *Panel5;
	TPageControl *PageControl1;
	TTabSheet *TabSheet1;
    TTreeView *tvPoint;
	TTabSheet *TabSheet2;
    TPanel *paEdit;
	TPanel *Panel10;
	TPanel *Panel11;
    TEdit *edName;
	TPanel *Panel12;
	TPanel *Panel13;
    TEdit *edShortName;
	TPanel *Panel18;
	TPanel *Panel16;
	TPanel *Panel17;
    TBitBtn *btDel;
    TPanel *Panel8;
    TTreeView *tvGroup;
    TPanel *Panel9;
    TDBGrid *grMain;
    TDataSource *dsMain;
    TPanel *Panel19;
    TDBNavigator *DBNavigator1;
    TPanel *Panel20;
    TEdit *edAvBr;
    TLabel *Label1;
    TLabel *Label2;
    TLabel *Label3;
    TLabel *Label4;
    TEdit *edTehBr;
    TMemo *mInfoArea;
    TCheckBox *cbSum;
    TCheckBox *cbInvers;
    TLabel *Label5;
    TEdit *edParameter;
    TAction *aSumma;
    TAction *aInvert;
    TPanel *plPartlyCalc;
    TLabel *lPartlyCalc;
    TComboBox *cbPartlyCalc;
  TOraQuery *oqSaveLimits;
  TPanel *PanelPeriod;
  TLabel *lebPeriod;
  TLabel *labPo;
  TBitBtn *bbPeriod;
  TEdit *meStart;
  TEdit *meFinish;
  TSpeedButton *sbFind;
  TLabel *Label9;
  TEdit *lbId;
  TLabel *lblPointId;
  TEdit *edPointId;
  TLabel *lbKC;
  TEdit *eKC;
  TOraQuery *oqGetAcc;
        //GRB 26.10.2018 - added init - was NPExepcion when it use only in constructor
        void __fastcall GrbInit ();
	void __fastcall tvGroupChange(TObject *Sender, TTreeNode *Node);
    void __fastcall tvGroupChanging(TObject* Sender, TTreeNode* Node, bool &AllowChange);
	void __fastcall edNameChange(TObject *Sender);
	void __fastcall edShortNameChange(TObject *Sender);
	void __fastcall cbInversClick(TObject *Sender);
	void __fastcall tvGroupDragOver(TObject *Sender, TObject *Source, int X,
   	int Y, TDragState State, bool &Accept);
	void __fastcall tvGroupDragDrop(TObject*Sender, TObject*Source,int X,int Y);
    void __fastcall TableAfterInsert(TDataSet *DataSet);
    void __fastcall TableAfterDelete(TDataSet *DataSet);
    void __fastcall TableBeforePost(TDataSet *DataSet);
    void __fastcall TableAfterEdit(TDataSet *DataSet);
    void __fastcall DATEValidate(TField *Sender);
    void __fastcall edAvBrExit(TObject *Sender);
    void __fastcall edTehBrExit(TObject *Sender);
    void __fastcall edKeyPress(TObject *Sender, char &Key);
    void __fastcall cbSumClick(TObject *Sender);
    void __fastcall FormShow(TObject *Sender);
    void __fastcall tvExpanding(TObject *Sender, TTreeNode *Node,
        bool &AllowExpansion);
    void __fastcall tvDeletion(TObject *Sender, TTreeNode *Node);
    void __fastcall tvPointExpCol(TObject *Sender, TTreeNode *Node);
    void __fastcall FormDestroy(TObject *Sender);
    void __fastcall edParameterChange(TObject *Sender);
    void __fastcall aCbExecute(TObject *Sender);
    void __fastcall aMExecute(TObject *Sender);
    void __fastcall mMonClick(TObject *Sender);
    void __fastcall cbPartlyCalcChange(TObject *Sender);
  void __fastcall bbPeriodClick(TObject *Sender);
  void __fastcall sbFindClick(TObject *Sender);
  void __fastcall PopupMenu1Popup(TObject *Sender);
  void __fastcall miManualInpClick(TObject *Sender);

private:	// User declarations
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
    typedef struct{
        int id;
        char date_limit[16];
        double limcons;//потребление
        double limcarm;//лимит утро
        double limcape;//лимит вечер
        //add by NNV
        char stmot [20];
        char enmot [20];
        char stevt [20];
        char enevt [20];
        //TTime stmot;
        //TTime enmot;
        //TTime stevt;
        //TTime enevt;
        //end add by NNV
        short indcons;
        short indcarm;
        short indcape;
    }pointslim;

    TVirtualTable *VT_Data;
    TfmFindPoint *fmFP;
     TMenuItem* miManIn;
      TMenuItem* miManMetr;
    void __fastcall WM_SetActiveNode(TMessage& Message);
    void __fastcall FindNodeGroup(long id);
    int reccount;
    long nGroups_Del[10000]; // id тех групп которые удалены из дерева
                              //  и необходимо удалить из таблицы groups
    long CountGroups_Del; // Кол-во удаляемых групп
    bool __fastcall ReadNode(TTreeView* tv,TTreeNode* NodeParent);// Читает ветку дерева Точек или Групп
    bool __fastcall SaveLimits(TTreeNode *Node);
    void __fastcall SetEvents(bool b);
    void __fastcall ShowTable(TTreeNode *Node);
    void __fastcall SetFlag();
	bool __fastcall tvCheckDragOver(TTreeNode*,TTreeNode*);
    bool realdeletion;
    TVirtualTable *vtLimits;
    void __fastcall changeNode(TTreeNode*,TTreeNode*);
    void __fastcall SetAccess(TAccess value);
    void __fastcall copyChildNodes(TTreeNode*, TTreeNode*);
public:		// User declarations
  	__fastcall TFormEditGropsList(TComponent* Owner, AnsiString, TAccess = accDenied);
    static void __fastcall createSubMenu_G(TMenuItem*mi);

protected:
    long __fastcall GetNodeId(TObject*obj){
        TTreeNode*tn=dynamic_cast<TTreeNode*>(obj);
        if(tn)  return ((POINTSDIV*)tn->Data)->Id;
        else    return 0;
    }
    void __fastcall vSave(TObject* Sender);
    void __fastcall vRefresh(TObject* Sender);
    void __fastcall vDelete(TObject* Sender);
    void __fastcall vUpdate(TObject* Sender);
    void __fastcall vEditClick(TObject*);
    void __fastcall vAnyEditClick(TObject* Sender);
    __fastcall ~TFormEditGropsList();
};
//---------------------------------------------------------------------------
#endif

