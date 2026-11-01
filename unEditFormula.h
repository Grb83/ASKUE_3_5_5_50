//---------------------------------------------------------------------------
#ifndef unEditFormulaH
#define unEditFormulaH
//---------------------------------------------------------------------------
#include <ActnList.hpp>
#include <Buttons.hpp>
#include <Classes.hpp>
#include "unTree.h"
#include "DBAccess.hpp"
#include "DBGridEh.hpp"
#include "MemDS.hpp"
#include "Ora.hpp"
#include "VirtualTable.hpp"
#include <ComCtrls.hpp>
#include <Controls.hpp>
#include <DB.hpp>
#include <ExtCtrls.hpp>
#include <Grids.hpp>
#include <ImgList.hpp>
#include <StdCtrls.hpp>
#include <ToolWin.hpp>
#include <Menus.hpp>

//---------------------------------------------------------------------------
class TfmEditFormula : public TForm
{
__published:	// IDE-managed Components
  TImageList *ifMenu;
  TPanel *Panel10;
  TPanel *Panel1;
  TBitBtn *btOk;
  TBitBtn *BitBtn2;
  TPanel *Panel2;
  TToolBar *ToolBar1;
  TToolButton *tbRefresh;
  TToolButton *ToolButton5;
  TBitBtn *btSave;
  TActionList *alDefault;
  TAction *iaPoints;
  TAction *iaSave;
  TAction *iaRefresh;
  TAction *iaCheck;
  TAction *iaNew;
  TAction *iaDelete;
  TAction *iaParams;
  TAction *iaClose;
  TAction *iaCutSAA;
  TAction *iaCopySAA;
  TAction *iaPasteSAA;
  TAction *iaDeleteSAA;
  TAction *iaSelectSAA;
  TAction *iaBlock;
  TAction *iaUnblock;
  TAction *iaReceipt;
  TAction *iaClone;
  TAction *iaFind;
  TAction *iaFindAgain;
  TAction *aMLeft;
  TAction *aMRigth;
  TAction *aMUp;
  TAction *aMDown;
  TAction *iaMon;
  TAction *iaFilter;
  TAction *aBlocking;
  TAction *aDataAbsence;
  TPanel *Panel3;
  TLabel *Label1;
  TComboBox *cbObjType;
  TPanel *Panel4;
  TPanel *Panel5;
  TPanel *Panel12;
  TLabel *Label2;
  TPanel *Panel6;
  TPanel *Panel8;
  TMemo *editFrmla;
  TPanel *Panel13;
  TLabel *Label3;
  TOraQuery *oqObjType;
  TToolButton *tbClear;
  TOraQuery *oqGetFrmla;
  TFloatField *oqGetFrmlaNID;
  TFloatField *oqGetFrmlaNORDER;
  TStringField *oqGetFrmlaVNAME;
  TStringField *oqGetFrmlaVPARAM;
  TStringField *oqGetFrmlaVMEMO;
  TVirtualTable *vtArg;
  TOraDataSource *dsArg;
  TStringField *vtArgvtArgVNAME;
  TStringField *vtArgvtArgVPARAM;
  TStringField *vtArgvtArgVMEMO;
  TOraQuery *oqSave;
  TEdit *edMemo;
  TLabel *Label4;
  TToolButton *tbFrmls;
  TToolButton *ToolButton6;
  TToolButton *tbTest;
  TPanel *Panel9;
  TDBGridEh *grArg;
  TOraQuery *oqClear;
  TStatusBar *sbEditFrmla;
  TOraQuery *oqAnalyse;
  TToolButton *tbAnalyse;
  TToolButton *ToolButton2;
  TOraQuery *oqTest;
  TFloatField *vtArgvtArgValue;
  TStatusBar *sbResult;
  TAction *iaAnalysis;
  TOraQuery *oqArguments;
  TFloatField *oqArgumentsNID;
  TFloatField *oqArgumentsNORDER;
  TStringField *oqArgumentsVNAME;
  TStringField *oqArgumentsVPARAM;
  TStringField *oqArgumentsVMEMO;
  TToolButton *ToolButton1;
  TAction *iaSaveFormula;
  TOraQuery *oqSaveFormula;
  TToolButton *EditParams;
  TToolButton *ToolButton7;
  TAction *iaEditParams;
  TToolButton *tbAddArg;
  TOraQuery *oqMeas;
  TStringField *vtArgvtArgVPntName;
  TOraQuery *oqPntName;
  TStringField *oqGetFrmlaOBJNAME;
  TFloatField *oqGetFrmlaNSHIFT;
  TFloatField *vtArgvtArgVShift;
  TPageControl *pcEditFormula;
  TTabSheet *tsEditFormula;
  TTabSheet *tbOccurrences;
  TTreeView *TreeMid;
  TOraQuery *oqTree;
  TPanel *Panel7;
  TBitBtn *btClose;
  TSplitter *Splitter1;
  TTreeView *TreeOccurr;
  TOraQuery *oqOccurr;
  TPanel *Panel14;
  TPanel *Panel11;
  TPanel *Panel15;
  TPanel *Panel16;
  TPanel *Panel17;
  TCheckBox *cbHourPeriod;
  TCheckBox *cbThirty_min;
  TPanel *Panel18;
  void __fastcall vSave(TObject *Sender);
  bool __fastcall vRead(void);
  void __fastcall vRefresh(TObject *Sender);
  void __fastcall btOkClick(TObject *Sender);
  void __fastcall btSaveClick(TObject *Sender);
  void __fastcall FormCreate(TObject *Sender);
  void __fastcall btShowTreeClick(TObject *Sender);
  void __fastcall editFrmlaDragOver(TObject *Sender, TObject *Source,
          int X, int Y, TDragState State, bool &Accept);
  void __fastcall editFrmlaDragDrop(TObject *Sender, TObject *Source,
          int X, int Y);
  void __fastcall editFrmlaMouseUp(TObject *Sender, TMouseButton Button,
          TShiftState Shift, int X, int Y);
  void __fastcall editFrmlaKeyUp(TObject *Sender, WORD &Key,
          TShiftState Shift);
  void __fastcall FormShow(TObject *Sender);
  void __fastcall FormDestroy(TObject *Sender);
  void __fastcall edMemoChange(TObject *Sender);
  void __fastcall editFrmlaChange(TObject *Sender);
  void __fastcall vtArgAfterEdit(TDataSet *DataSet);
  void __fastcall cbObjTypeSelect(TObject *Sender);
  void __fastcall grArgColumns1EditButtonClick(TObject *Sender,
          bool &Handled);
  void __fastcall tbAddArgClick(TObject *Sender);
  void __fastcall iaDeleteExecute(TObject *Sender);
  void __fastcall tbAnalyseClick(TObject *Sender);
  void __fastcall tbTestClick(TObject *Sender);
  void __fastcall FormCloseQuery(TObject *Sender, bool &CanClose);
  void __fastcall iaSaveFormulaExecute(TObject *Sender);
  void __fastcall iaEditParamsExecute(TObject *Sender);
  bool __fastcall Compiling (TObject *Sender);
  void __fastcall tbOccurrencesShow(TObject *Sender);
  void __fastcall TreeMidExpanding(TObject *Sender, TTreeNode *Node,
          bool &AllowExpansion);
  void __fastcall TreeOccurrExpanding(TObject *Sender, TTreeNode *Node,
          bool &AllowExpansion);
  void __fastcall cbHourPeriodClick(TObject *Sender);
  void __fastcall cbThirty_minClick(TObject *Sender);
private:	// User declarations
  bool compiled;
  TBookmark SavePlace;
  long id;
  int LCount;
  int start; int end;
  int Temp, Temp2;
  AnsiString Argument;
  bool existArg;
  bool exArg;
  struct SFormula{
      AnsiString vname;
      AnsiString vparam;
      AnsiString vmemo;
      double val;
      double shift;
      SFormula(AnsiString n,AnsiString p,AnsiString m,double v,double s){this->vname=n;this->vmemo=m;this->vparam=p;this->val=v;this->shift=s;};
      SFormula(){this->vname="";this->vmemo="";this->vparam="";this->val=0;this->shift=0;}
    };
    TList* ls;
    bool argFree;
    TfmTree *Tr;
    void	__fastcall WMInsertFormula(TMessage& Message);
    void 	__fastcall ReadTreeMid(TTreeNode* Node);
    void 	__fastcall ReadTreeOccurr(TTreeNode* Node);
    BEGIN_MESSAGE_MAP
     MESSAGE_HANDLER(WM_INSERT_FORMULA,TMessage, WMInsertFormula)
    END_MESSAGE_MAP(TForm)
    TStringList *measst;
public:		// User declarations
 	__fastcall TfmEditFormula(TComponent* Owner,long id);
  static bool __fastcall fmEditFormulaShow(TComponent* Owner,long id);
};
//---------------------------------------------------------------------------
#endif
