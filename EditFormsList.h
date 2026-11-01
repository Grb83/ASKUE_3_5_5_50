//---------------------------------------------------------------------------
#ifndef EditFormsListH
#define EditFormsListH
//---------------------------------------------------------------------------
#include <ActnList.hpp>
#include <Buttons.hpp>
#include <Classes.hpp>
#include <ComCtrls.hpp>
#include <Controls.hpp>
#include <Dialogs.hpp>
#include <ExtCtrls.hpp>
#include <ImgList.hpp>
#include <StdCtrls.hpp>
#include "Main.h"
#include <Menus.hpp>
#include "DBAccess.hpp"
#include "MemDS.hpp"
#include "Ora.hpp"
#include <DB.hpp>
//---------------------------------------------------------------------------

class TFormEditFormList : public TMainForm
{
__published:	// IDE-managed Components
	TPanel *Panel6;
	TPanel *Panel7;
    TTreeView *tvForm;
	TPanel *Panel5;
	TPanel *Panel16;
    TPageControl *pgControl;
    TTabSheet *tsTemp;
    TTreeView *tvTemp;
    TTabSheet *tsParam;
	TPanel *Panel9;
    TPanel *paAll;
    TTabSheet *tsGroup;
	TPanel *Panel10;
	TBitBtn *BtnLoadFile;
	TOpenDialog *OpenDialog1;
    TTreeView *tvGroup;
    TBitBtn *btRight;
    TPanel *Panel14;
    TPanel *Panel17;
    TComboBox *cbSchema;
    TPanel *paControl;
    TPanel *Panel12;
    TPanel *Panel13;
    TPanel *Panel11;
    TPanel *Panel15;
    TPanel *Panel19;
    TPanel *Panel20;
    TPanel *Panel21;
    TPanel *Panel22;
    TPanel *Panel23;
    TCheckBox *cb1;
    TCheckBox *cb2;
    TCheckBox *cb3;
    TCheckBox *cb4;
    TCheckBox *cbGroup;
    TCheckBox *cbCalendar;
    TRadioButton *rb1;
    TRadioButton *rb2;
    TRadioButton *rb3;
    TRadioButton *rb4;
    TActionList *ActionList1;
    TAction *aRight;
    TAction *aLoadFile;
    TPanel *PnlTimePnl;
    TCheckBox *cbTimeFields;
    TCheckBox *cbSecondBound;
    TPanel *PnlNameComment;
    TPanel *paComment;
    TLabel *Label2;
    TEdit *edComment;
    TLabel *Label3;
    TEdit *edTemplates;
    TPanel *Panel8;
    TLabel *Label1;
    TLabel *Label4;
    TEdit *edName;
    TPanel *PnlProcName;
    TLabel *lbPLProc;
    TEdit *edPLProc;
    TCheckBox *cbPoint;
    TSpeedButton *btDel;
    TSpeedButton *btClon;
        TCheckBox *cbRegime;
        TCheckBox *cbCheckPoints;
  TEdit *eDuplPoint;
  TSpeedButton *btnMainSelect;
  TOraQuery *oqvSave;
  TButton *btParam;
  TPanel *paParButton;
  TEdit *lbFormId;
	void __fastcall BtnLoadFileClick(TObject *Sender);
    void __fastcall cbSchemaChange(TObject *Sender);
    void __fastcall tvGroupDeletion(TObject *Sender, TTreeNode *Node);
    void __fastcall tvExpanding(TObject *Sender, TTreeNode *Node,
          bool &AllowExpansion);
    void __fastcall tvDeletion(TObject *Sender, TTreeNode *Node);
    void __fastcall tvExpColl(TObject *Sender, TTreeNode *Node);
    void __fastcall tvFormChange(TObject *Sender, TTreeNode *Node);
    void __fastcall tvGroupAdvancedCustomDrawItem(TCustomTreeView *Sender,
          TTreeNode *Node, TCustomDrawState State, TCustomDrawStage Stage,
          bool &PaintImages, bool &DefaultDraw);
    void __fastcall btRightClick(TObject *Sender);
    void __fastcall tvGroupChange(TObject *Sender, TTreeNode *Node);
    void __fastcall pgControlChange(TObject *Sender);
    void __fastcall tvGroupKeyPress(TObject *Sender, char &Key);
    void __fastcall edTextChange(TObject *Sender);
    void __fastcall cbCtrClick(TObject *Sender);
    void __fastcall cbClick(TObject *Sender);
    void __fastcall rbClick(TObject *Sender);
    void __fastcall tvTempStartDrag(TObject *Sender,
          TDragObject *&DragObject);
    void __fastcall tvFormDragDrop(TObject *Sender, TObject *Source, int X,
          int Y);
    void __fastcall tvFormDragOver(TObject *Sender, TObject *Source, int X,
          int Y, TDragState State, bool &Accept);
    void __fastcall aMExecute(TObject *Sender);
    void __fastcall FormCreate(TObject *Sender);
  void __fastcall btnMainSelectClick(TObject *Sender);
  void __fastcall eDuplPointDblClick(TObject *Sender);
  void __fastcall eDuplPointKeyDown(TObject *Sender, WORD &Key,
          TShiftState Shift);
  void __fastcall btParamClick(TObject *Sender);
private:	// User declarations
    typedef struct { //Вспомогательная структура
        long Id;
        char Name[200];
        long editing;
    }AUXDIV;
    typedef struct { //Структура для вытяжки шаблонов
        long Id;
        long CodeTamplate;
        char Name[200];
        char Comment[200];
        char EnableControls[20];
        char NewEnableControls[20];
        long StepProfile;
        char NameAlert[50];
        TList* GroupList;
        long editing;
        long tmpId;
        char pLProc[100];
        char TemplName[200];
        long Mid;
        char MidName[150];
    }POINTSDIV;
    typedef struct { //Вспомогательная структура
        TRadioButton *rb;
        TCheckBox *cb;
    }RADCHECK;
    long nForms_Del[10000]; // id тех форм которые удалены из дерева
                              //  и необходимо удалить из таблицы groups
    long CountForms_Del; // Кол-во удаляемых форм
    long CurrentSchema;
    long OldSchemaIndex;
    TTreeNode* SelectedNode;
    bool realdeletion;
    RADCHECK eProf[4];
    bool __fastcall ReadNode(TTreeView* tv,TTreeNode* NodeParent);// Читает ветку дерева форм или шаблонов
    void __fastcall ReadGroupNode(TTreeNode* NodeParent);// Читает ветку дерева групп
    bool __fastcall GetShemas(void);
    bool __fastcall GetGroups(void);
    void __fastcall ReloadData(void);
    void __fastcall EnableEvents(bool enab);
	bool __fastcall tvCheckDragOver(TTreeNode* AccNode, TTreeNode* MovNode);
    void __fastcall SetAccess(TAccess value);
public:		// User declarations
	__fastcall TFormEditFormList(TComponent* Owner, AnsiString, TAccess = accDenied);
private:
    void __fastcall vSave(TObject *Sender);
    void __fastcall vRefresh(TObject *Sender);
    void __fastcall vDelete(TObject *Sender);
    void __fastcall vClone(TObject *Sender);
};
//---------------------------------------------------------------------------
#endif
