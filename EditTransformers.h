//---------------------------------------------------------------------------

#ifndef EditTransformersH
#define EditTransformersH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Main.h"
#include <ActnList.hpp>
#include <Buttons.hpp>
#include <ExtCtrls.hpp>
#include <ImgList.hpp>
#include <Menus.hpp>
#include <ComCtrls.hpp>
#include <Grids.hpp>
#include <ToolWin.hpp>
#include <Mask.hpp>
#include "DBAccess.hpp"
#include "MemDS.hpp"
#include "Ora.hpp"
#include <DB.hpp>
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
class TTransformersFormPriv;
//---------------------------------------------------------------------------
class TTransformersForm : public TMainForm
{
  typedef TMainForm inherited;
__published:	// IDE-managed Components
  TPanel *plParams;
  TToolBar *tbTools;
  TToolButton *NewPowerTransTBtn;
  TToolButton *NewMeteringTransTBtn;
  TToolButton *tbDelete;
  TPanel *HeaderPanel;
  TLabel *lName;
  TLabel *lId;
  TEdit *NameEdit;
  TPanel *plTransfms;
  TTreeView *tvTransfms;
  TPanel *plTransfmsTitle;
  TPopupMenu *NewMeteringTransformMenu;
  TMenuItem *N6;
  TMenuItem *N7;
  TPopupMenu *NewPowerTransformMenu;
  TMenuItem *N21;
  TMenuItem *N31;
  TAction *NewPowerTransAction;
  TAction *New2PowerTransAction;
  TAction *New3PowerTransAction;
  TAction *NewMeteringTransAction;
  TAction *NewIMeteringTransAction;
  TAction *NewUMeteringTransAction;
  TMenuItem *N3;
  TMenuItem *N8;
  TMenuItem *N9;
  TMenuItem *N10;
  TMenuItem *N32;
  TMenuItem *N22;
  TEdit *eId;
  TPanel *paramPanel;
  TPageControl *TransformerPControl;
  TTabSheet *MeteringTransformerPage;
  TLabel *lValueSecond;
  TLabel *lValueFirst;
  TEdit *mVal2Edit;
  TEdit *mVal1Edit;
  TTabSheet *TwoPowerTransformerPage;
  TTabSheet *ThreePowerTransformerPage;
  TLabel *Label1;
  TMaskEdit *DateMEdit;
  TLabel *p2SnLabel;
  TEdit *p2SnEdit;
  TLabel *p2dPxxLabel;
  TLabel *p2dPkzLabel;
  TLabel *p2IxxLabel;
  TLabel *p2UkzLabel;
  TEdit *p2dPxxEdit;
  TEdit *p2dPkzEdit;
  TEdit *p2IxxEdit;
  TEdit *p2UkzEdit;
  TLabel *p3SnLabel;
  TLabel *p3SuLabel;
  TLabel *p3SmLabel;
  TLabel *p3SdLabel;
  TLabel *p3PxxLabel;
  TEdit *p3SnEdit;
  TEdit *p3SuEdit;
  TEdit *p3SmEdit;
  TEdit *p3SdEdit;
  TEdit *p3dPxxEdit;
  TLabel *p3PkzuLabel;
  TLabel *p3PkzmLabel;
  TLabel *p3PkzdLabel;
  TLabel *p3IxxLabel;
  TLabel *p3UkzuLabel;
  TEdit *p3dPkzuEdit;
  TEdit *p3dPkzmEdit;
  TEdit *p3dPkzdEdit;
  TEdit *p3IxxEdit;
  TEdit *p3UkzuEdit;
  TLabel *p3UkzmLabel;
  TEdit *p3UkzmEdit;
  TLabel *p3UkzdLabel;
  TEdit *p3UkzdEdit;
  TAction *NewLineAction;
  TAction *NewTransmissionLineAction;
  TTabSheet *TransmissionLinePage;
  TLabel *tlNRoLabel;
  TEdit *tlRoEdit;
  TLabel *tlXoLabel;
  TEdit *tlXoEdit;
  TLabel *tlLLabel;
  TEdit *tlLEdit;
  TLabel *tlUnLabel;
  TEdit *tlUnEdit;
  TToolButton *ChangeTransLineTBtn;
  TMenuItem *N11;
  TMenuItem *N12;
  TToolButton *NewLineTBtn;
  TPopupMenu *NewLineMenu;
  TMenuItem *N13;
  TLabel *p2WorkHoursLabel;
  TEdit *p2WorkHoursEdit;
  TLabel *p2FullHoursLabel;
  TEdit *p2FullHoursEdit;
  TEdit *p3FullHoursEdit;
  TEdit *p3WorkHoursEdit;
  TLabel *p3WorkHoursLabel;
  TLabel *p3FullHoursLabel;
  TBevel *p2TimeBevel;
  TBevel *p3TimeBevel;
  TBevel *Bevel1;
  TBevel *Bevel2;
  TAction *CalcLossParamAction;
  TMenuItem *N14;
  TAction *SetWorkTimeAction;
  TToolButton *ToolButton1;
  TToolButton *SetWorkTimeTBtn;
  TToolButton *CalcLossParamTBtn;
  TMenuItem *N15;
  TOraQuery *oqSetWorkTimeActionExecute;
  TToolButton *tbSpezParam;
  TToolButton *tbLimit;
  TAction *aSpezPar;
  TAction *aBorderPar;
  TToolButton *NewReactorTBtn;
  TAction *NewReactorAction;
  TPopupMenu *NewReactorMenu;
  TMenuItem *N16;
  TAction *NewReactorMenuAction;
  TTabSheet *ReactorPage;
  TBevel *Bevel3;
  TLabel *Label2;
  TEdit *RctrCHoursEdit;
  TEdit *RctrFHoursEdit;
  TLabel *Label3;
  TBevel *Bevel4;
  TLabel *RctUnLbl;
  TEdit *RctrUnEdit;
  TLabel *RctrSnLbl;
  TEdit *RctrSnEdit;
  TLabel *RctrDPLbl;
  TEdit *RctrDPEdit;
  void __fastcall NewPowerTransActionExecute(TObject *Sender);
  void __fastcall NewMeteringTransActionExecute(TObject *Sender);
  void __fastcall tvTransfmsChange(TObject *Sender, TTreeNode *Node);
  void __fastcall tvTransfmsChanging(TObject *Sender, TTreeNode *Node,
          bool &AllowChange);
  void __fastcall tvTransfmsCollapsing(TObject *Sender, TTreeNode *Node,
          bool &AllowCollapse);
  void __fastcall tvTransfmsDeletion(TObject *Sender, TTreeNode *Node);
  void __fastcall tvTransfmsDragDrop(TObject *Sender, TObject *Source,
          int X, int Y);
  void __fastcall tvTransfmsDragOver(TObject *Sender, TObject *Source,
          int X, int Y, TDragState State, bool &Accept);
  void __fastcall tvTransfmsExpanding(TObject *Sender, TTreeNode *Node,
          bool &AllowExpansion);
  void __fastcall FormCreate(TObject *Sender);
  void __fastcall FormDestroy(TObject *Sender);
  void __fastcall onChange(TObject *Sender);
  void __fastcall iaMonExecute(TObject *Sender);
  void __fastcall NewLineActionExecute(TObject *Sender);
  void __fastcall CalcLossParamActionExecute(TObject *Sender);
  void __fastcall SetWorkTimeActionExecute(TObject *Sender);
  void __fastcall aSpezParExecute(TObject *Sender);
  void __fastcall aBorderParExecute(TObject *Sender);
  void __fastcall NewReactorActionExecute(TObject *Sender);
private:	// User declarations
  TTransformersFormPriv *d;

  bool __fastcall AllowChangeNode();

  bool __fastcall AcceptNode(TTreeNode *srcNode, TTreeNode *dstNode);
  void __fastcall changeNode(TTreeNode *srcNode, TTreeNode *dscNode);
  void __fastcall copyChildNodes(TTreeNode *srcNode, TTreeNode *dstNode);
public:		// User declarations
  __fastcall TTransformersForm(TComponent* Owner, AnsiString Name, TAccess a);

  void __fastcall vSave(TObject* Owner);
  void __fastcall vRefresh(TObject *Sender);
  void __fastcall vDelete(TObject *Sender);
  void __fastcall vEditClick(TObject *Sender);
  void __fastcall vAnyEditClick(TObject *Sender);
  void __fastcall NewTransLine(TObject *Sender);
  bool __fastcall ReadTreeNode(TObject *Sender);
};
//---------------------------------------------------------------------------
extern PACKAGE TTransformersForm *TransformersForm;
//---------------------------------------------------------------------------
#endif
