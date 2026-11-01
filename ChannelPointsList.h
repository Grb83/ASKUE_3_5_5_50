//---------------------------------------------------------------------------
#ifndef ChannelPointsListH
#define ChannelPointsListH
//---------------------------------------------------------------------------
#include <ActnList.hpp>
#include <Buttons.hpp>
#include <Classes.hpp>
#include <ComCtrls.hpp>
#include <Controls.hpp>
#include <ExtCtrls.hpp>
#include <Grids.hpp>
#include <ImgList.hpp>
#include <StdCtrls.hpp>
#include "Main.h"
#include <Menus.hpp>
#include "DBAccess.hpp"
#include "MemDS.hpp"
#include "Ora.hpp"
#include <DB.hpp>
#include "DBGridEh.hpp"
#include "VirtualTable.hpp"
//---------------------------------------------------------------------------
class TfmChannelPointsList : public TMainForm
{
__published:	// IDE-managed Components
   TSplitter *Splitter1;
   TTreeView *tvPoints;
   TPanel *plBase;
   TStringGrid *sgPointsList;
   TGroupBox *gbEdit;
   TEdit *eConnNumb;
   TLabel *Label1;
   TLabel *Label6;
   TEdit *eTag;
   TLabel *Label7;
   TEdit *eAddInfo;
   TLabel *Label8;
   TEdit *eUSD;
   TSpeedButton *sbUSDList;
   TPopupMenu *pmUSDList;
   TMenuItem *miCapUSDList;
   TMenuItem *miSepUSDList;
   TCheckBox *cbBlocking;
   TBitBtn *bbDeletePoint;
   TPanel *paInfo;
   TAction *aBlocking;
  TLabel *Label9;
  TPanel *Panel1;
  TLabel *lbAP;
  TEdit *eAPlus;
  TLabel *lbAN;
  TEdit *eAMinus;
  TLabel *lbRP;
  TEdit *eRPlus;
  TLabel *lbRN;
  TEdit *eRMinus;
   TCheckBox *cbDataAbsence;
   TLabel *lComm;
   TLabel *lTech;
   TEdit *eComm;
   TEdit *eTech;
   TAction *aDataAbsence;
  TLabel *Label2;
  TEdit *eImportCode;
  TCheckBox *cbBlockingTime;
  TButton *btTU;
  TOraQuery *oqSave;
  TLabel *lTimeZoneS;
  TLabel *lTimeZoneW;
  TComboBox *cbTimeZoneW;
  TComboBox *cbTimeZoneS;
  TOraQuery *oqChPointsList;
  TEdit *lbId;
  TLabel *Label3;
  TPanel *PanelCod;
  TPanel *PanelID;
  TPanel *PaneGridPoint;
  TPanel *PaneCaption;
  TPanel *PaneGridCod;
  TLabel *LabelCod;
  TDBGridEh *grPoints;
  TDBGridEh *grCod;
  TVirtualTable *vtCod;
  TOraQuery *oqCod;
  TDataSource *dsCod;
  TOraQuery *oqAddParam;
  TDataSource *dsAddParam;
  TSplitter *Splitter2;
  TEdit *eResCanal;
  TCheckBox *cbConnRes;
  TPanel *plCanalNum;
  TGroupBox *gbCodImp;
  TCheckBox *cbConnMain;
  TPanel *plUnion;
  TPanel *plCodImp;
  TPanel *plBottom;
   void __fastcall tvPointsCollapsed(TObject *Sender,TTreeNode *Node);
   void __fastcall tvPointsExpanded(TObject *Sender,TTreeNode *Node);
   void __fastcall tvPointsExpanding(TObject *Sender,TTreeNode *Node, bool &AllowExpansion);
   void __fastcall tvPointsStartDrag(TObject *Sender,TDragObject *&DragObject);
   void __fastcall sgPointsListDragOver(TObject *Sender,
      TObject *Source, int X, int Y, TDragState State, bool &Accept);
   void __fastcall sgPointsListDragDrop(TObject *Sender,TObject *Source, int X, int Y);
   void __fastcall sgPointsListDragDropOld(TObject *Sender,TObject *Source, int X, int Y);
   long __fastcall getNumPointsInSubTree(TObject *Sender, TObject *Source, int X, int Y);
   void __fastcall sgPointsListSelectCell(TObject *Sender, int ACol,
   int ARow, bool &CanSelect);
   void __fastcall eChange(TObject *Sender);
   void __fastcall OnUSDListClick(TObject *Sender);
   void __fastcall sbUSDListClick(TObject *Sender);
   void __fastcall miCapUSDListDrawItem(TObject *Sender, TCanvas *ACanvas,
          TRect &ARect, bool Selected);
   void __fastcall aShortCutExecute(TObject *Sender);
  void __fastcall btTUClick(TObject *Sender);
  void __fastcall FormShow(TObject *Sender);
  void __fastcall vtCodAfterScroll(TDataSet *DataSet);
  void __fastcall oqAddParamAfterEdit(TDataSet *DataSet);
  void __fastcall grPointsDragDrop(TObject *Sender, TObject *Source, int X,
          int Y);
  void __fastcall grPointsDragOver(TObject *Sender, TObject *Source, int X,
          int Y, TDragState State, bool &Accept);
  void __fastcall oqAddParamAfterPost(TDataSet *DataSet);
  void __fastcall cbConnMainClick(TObject *Sender);
  void __fastcall cbConnResClick(TObject *Sender);
private:	// User declarations
   struct stPoint
   {
      long HaveChild;
      long Mid;
      char Name[156];
      char LongName[256];
      long Type; //= 1 - enterprise, 2-station, 3-point, 4-точка учета
      char Tag[10];
      long CANAL;		//NUMBER, канал
      long ER_POSITION;	//NUMBER, активная принятая энергия
      long Q1_POSITION;	//NUMBER, реактивная принятая энергия
      long ED_POSITION;	//NUMBER, активная отданая энергия
      long Q3_POSITION;	//NUMBER, реактивная отданая энергия
      char v_info[256];
      char p_info[256];
      long nBlock;
      long DataAbsence;
      char CommCtrl[10];
      char TechCtrl[10];
      char ImportCode[64];// связной код импорта
      long nblocktime;
      int ntimezonew, ntimezones;
      long ResCanal; //Дополнительный связной номер
      int CheckCanal;//Признак выбора связного номера
   };

   stPoint *DragData;
   struct RuleDialog{
        bool deniedAdd;
        bool firstDialog;
   };
   RuleDialog rule;
   long FCid;
   long CurrRow;
   long FIdProtocol;
   long FIsViewImportCode;
   int PlusDopCanal;
   bool __fastcall ReadTreeNode(TObject*obj);// Читает ветку дерева
   void __fastcall ReadData(AnsiString MidMass);
   void __fastcall ReadAddParam(int Mid);
   void __fastcall ReadDataCod();
   void __fastcall SavePoints();
   void __fastcall SaveCod();
   void __fastcall SetLabel(int ARow=0);
   void __fastcall SetAccess(TAccess value);
public:		// User declarations
   __fastcall TfmChannelPointsList(TComponent* Owner, long Cid, long aIdProtocol, TAccess = accDenied);
protected:
   void __fastcall vUpdate(TObject*Sender);
   void __fastcall vDelete(TObject *Sender);
   void __fastcall vRefresh(TObject *Sender);
   void __fastcall vSave(TObject *Sender);
   long __fastcall getNodeId(TObject*obj){
      TTreeNode*tn=dynamic_cast<TTreeNode*>(obj);
      if(tn)
         return ((stPoint*)tn->Data)->Mid;
      else
         return 0;
   }
};
//---------------------------------------------------------------------------
#endif

