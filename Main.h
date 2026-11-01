//---------------------------------------------------------------------------
#ifndef MainH
#define MainH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Menus.hpp>
#include <Buttons.hpp>
#include <Controls.hpp>
#include <ExtCtrls.hpp>
#include <StdCtrls.hpp>
#include <ActnList.hpp>
#include <ImgList.hpp>
#include <Comctrls.hpp>
#include <Clipbrd.hpp>
#include "unDataMod.h"
#include "Find.h"
#include "FindPoint.h"
#include "DBAccess.hpp"
#include "MemDS.hpp"
#include "Ora.hpp"
#include <DB.hpp>
//---------------------------------------------------------------------------
#define MAXCOUNTLEVEL  100
typedef bool __fastcall (__closure *TReadTreeNode)(TObject* Sender);
typedef long __fastcall (__closure *TGetNodeId)(TObject* Sender);
//---------------------------------------------------------------------------
#define CHANN_IN_COM          1
#define CHANN_FOR_POINTS      2
#define GROUP_FOR_POINTS      3
#define CHANN_DISTRIBUTION    4
#define MAKET_FOR_POINTS      5
#define OCCURR_POINTS_FORMULA 6

#define imChan            9
#define imRezChan         10
#define imBlChan          11
#define imBlRezChan       12

//void __fastcall ShowChannelList(TObject*, long, int = 0);
struct FORMS{
    long fid;
    long tmplCode;
    char name[256];
    char comment[256];
    char enablecontrols[20];
    long step;
    char alertname[64];
    char procname[128];
    long gid;
    long startmid;
};
//---------------------------------------------------------------------------
class TMainForm : public TForm
{
__published:
	TMainMenu *MenuSAA;
	TMenuItem *mnEdit;
	TMenuItem *mnCopy;
	TMenuItem *mnPaste;
	TMenuItem *mnCut;
	TMenuItem *mnDelete;
	TMenuItem *mnSelect;
	TMenuItem *N1;
	TPopupMenu *PopupMenu1;
	TMenuItem *mSave;
	TMenuItem *mCancel;
	TMenuItem *mCheck;
    TMenuItem *imiSep2;
    TMenuItem *mAdd;
	TMenuItem *mDelete;
    TMenuItem *mParams;
	TMenuItem *mClose;
    TPanel *iplBottom;
    TBitBtn *btnRefresh;
    TActionList *alDefault;
    TAction *iaSave;
    TAction *iaRefresh;
    TAction *iaClose;
    TAction *iaNew;
    TAction *iaDelete;
    TAction *iaCheck;
    TAction *iaParams;
    TAction *iaCutSAA;
    TAction *iaCopySAA;
    TAction *iaPasteSAA;
    TAction *iaDeleteSAA;
    TAction *iaSelectSAA;
    TAction *iaPoints;
    TAction *iaBlock;
    TAction *iaUnblock;
    TAction *iaClone;
    TPanel *iplClose;
    TBitBtn *btnClose;
    TMenuItem *mPoints;
    TMenuItem *mBlock;
    TMenuItem *mUnblock;
    TMenuItem *imiSep1;
    TImageList *iImageList;
    TImageList *ilMenu;
    TBitBtn *btnSave;
    TMenuItem *mClon;
    TAction *iaFind;
    TAction *iaFindAgain;
    TMenuItem *N2;
    TMenuItem *mnFind;
    TMenuItem *mnFindAgain;
    TAction *aMLeft;
    TAction *aMRigth;
    TAction *aMUp;
    TAction *aMDown;
    TMenuItem *mMon;
    TAction *iaMon;
  TAction *iaReceipt;
    TMenuItem *N4;
    TMenuItem *N5;
    TAction *iaFilter;
  TAction *iaMTX;
  TMenuItem *miManualInp;
  TMenuItem *mnOFF;
  TMenuItem *mnLineOFF;
  TMenuItem *mnON;
  TMenuItem *mnONCancel;
// void __fastcall N9Click(TObject *Sender);
//	void __fastcall N10Click(TObject *Sender);
    void __fastcall iaCloseExecute(TObject *Sender);
    void __fastcall iaRefreshExecute(TObject *Sender);
    void __fastcall FormCloseQuery(TObject *Sender, bool &CanClose);
    void __fastcall FormClose(TObject *Sender, TCloseAction &Action);
public:         // public user declarations
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
    }POINTSDIV;
    int TaskId;
    AnsiString TaskName;
    __property bool EditRec = { read=GetEditRec, write=SetEditRec, default=false};
    __property TAccess Access  = { read=GetAccess, write=SetAccess, default=accDenied};
//   bool __fastcall( __closure *myCopy )(void);
//   void __fastcall( __closure *myPaste)(void);
    __fastcall TMainForm(TComponent* Owner, AnsiString Name, TAccess = accDenied);
    virtual void __fastcall vFindClick(TObject*);
    virtual void __fastcall vFindAgainClick(TObject*);
    virtual __fastcall ~TMainForm();
    void __fastcall SetPopupMenu(TObject *Sender, int id,AnsiString PointName);//add by NNV
    static void __fastcall repl_delimiters(char*source, const char*byrepl);
    static void __fastcall createSubMenu(TMenuItem*);
    static void __fastcall createSubMenu_G(TMenuItem*mi);
protected:
    TAccess FAccess;
    void __fastcall ShowAction(TAction*, bool = true);
    virtual void __fastcall SetEditRec(bool value);
    virtual bool __fastcall GetEditRec(void);
    virtual void __fastcall SetAccess(TAccess value);
    virtual TAccess __fastcall GetAccess(){return FAccess;}
    virtual void __fastcall vSave(TObject *Sender) = 0;
    virtual void __fastcall vRefresh(TObject *Sender) = 0;
    virtual void __fastcall vNew(TObject *Sender){}
    virtual void __fastcall vDelete(TObject *Sender){}
    virtual void __fastcall vBlock(TObject* Sender){}
    virtual void __fastcall vUnblock(TObject* Sender){}
    virtual void __fastcall vPoints(TObject* Sender){}
    virtual void __fastcall vClone(TObject* Sender){}
    virtual void __fastcall vReceipt(TObject* Sender){}
    virtual void __fastcall vCheck(TObject* Sender){}
    virtual void __fastcall vParams(TObject* Sender){}
    virtual void __fastcall vUpdate(TObject * Sender);
	virtual void __fastcall vEditClick(TObject *Sender);
	virtual void __fastcall vAnyEditClick(TObject *Sender);
    virtual void __fastcall vMTX(TObject* Sender){}
    static void __fastcall FindNode(TTreeView*tv, long mid, TReadTreeNode&OnReadNode,TGetNodeId&GetNodeId, char*sql=NULL);
    static void __fastcall getUSDList(TPopupMenu* pm, long mid, Classes::TNotifyEvent&OnClick);
 //   static void __fastcall repl_delimiters(char*source, const char*byrepl);
    TWinControl*oldCtrl;
   virtual void  __fastcall WM_SetActiveNode(TMessage& Message);
	BEGIN_MESSAGE_MAP
      MESSAGE_HANDLER((WM_SETACTIVENODE),TMessage, WM_SetActiveNode)
	END_MESSAGE_MAP(TForm)
private:
    void __fastcall createSubMenu_M(TMenuItem*mi, int id);//end add by NNV
    bool FEditRec;
};
//---------------------------------------------------------------------------
#endif

