//---------------------------------------------------------------------------
#ifndef ParameterPointsListH
#define ParameterPointsListH
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
#include <Forms.hpp>
#include "DBAccess.hpp"
#include "MemDS.hpp"
#include "Ora.hpp"
#include <DB.hpp>
//---------------------------------------------------------------------------
class TfmParameterPointsList : public TMainForm
{
__published:	// IDE-managed Components
   TBitBtn *bbDeletePoint;
   TAction *aBlocking;
   TTabControl *tcSelectParams;
   TPanel *plBase;
   TPanel *paInfo;
   TPanel *plRight;
   TTreeView *tvPoints;
   TSplitter *splCenter;
   TPanel *plTreeTitle;
   TAction *aOffCalc;
   TAction *aSaldo;
   TAction *aPlus;
   TAction *aMinus;
  TPanel *DataPanel;
  TPanel *plView;
  TTreeView *tvParamView;
  TStringGrid *sgPointsList;
  TPanel *plEdit;
  TGroupBox *gbUsedEdit;
  TLabel *ldKC;
  TLabel *lCalcR;
  TEdit *edKC;
  TRadioGroup *rgDimType;
  TComboBox *cbCalcR;
  TGroupBox *gbSharedEdit;
  TCheckBox *cbOffCalc;
  TGroupBox *gbDependEdit;
  TLabel *lFirst;
  TLabel *lKC;
  TEdit *eKC;
  TEdit *eFirst;
  TTabControl *Power3TabControl;
  TOraQuery *oqSaveParalelData;
  TOraQuery *oqSaveUsedData;
  TOraQuery *oqSaveSharedData;
  TOraQuery *oqSaveRelatedData;
   void __fastcall tvPointsCollapsed(TObject *Sender,TTreeNode *Node);
   void __fastcall tvPointsExpanded(TObject *Sender,TTreeNode *Node);
   void __fastcall tvPointsExpanding(TObject *Sender,TTreeNode *Node, bool &AllowExpansion);
   void __fastcall sgPointsListDragOver(TObject *Sender,
      TObject *Source, int X, int Y, TDragState State, bool &Accept);
   void __fastcall sgPointsListDragDrop(TObject *Sender,TObject *Source, int X, int Y);
   void __fastcall sgPointsListSelectCell(TObject *Sender, int ACol,
   int ARow, bool &CanSelect);
   void __fastcall eChange(TObject *Sender);
   void __fastcall edKCKeyPress(TObject *Sender, char &Key);
   void __fastcall tcSelectParamsChanging(TObject *Sender,
          bool &AllowChange);
   void __fastcall tcSelectParamsChange(TObject *Sender);
   void __fastcall aDimTypeChangeExecute(TObject *Sender);
   void __fastcall FormCreate(TObject *Sender);
   void __fastcall FormShow(TObject *Sender);
   void __fastcall tvParamViewChange(TObject *Sender, TTreeNode *Node);
  void __fastcall Power3TabControlChanging(TObject *Sender,
          bool &AllowChange);
  void __fastcall Power3TabControlChange(TObject *Sender);
private:	// User declarations
  unsigned short  lastPage;
   struct stPoint
   {
      long HaveChild;
      long Mid;                     //===== идентификатор объекта
      char Name[156];
      char LongName[256];
      long Type;                    //===== 1 - enterprise,
                                    //===== 2 - station,
                                    //===== 3 - point,
                                    //===== 4 - connectionparam,
                                    //===== 5 - parallelconnection
                                    //===== 243 - 2-хобмоточный трансформатор
                                    //===== 244 - 3-хобмоточный трансформатор

      double NKC;		                //===== NUMBER, коэффициент
      long NType;		                //===== NUMBER, тип расчета
      long NRECOMPENS;	            //===== NUMBER, расчет реактива
      long NNOTINCLUDECONSUMP;
      long nconnectionparam;        //===== NUMBER, ид параметра (Type=4, 243, 244)
      long nparallelconnection;     //===== NUMBER, ид паралельного параметра (Type=4, 243, 244)
//      long nconnectionparam2;       //===== NUMBER, ид параметра (Type=244)
//      long nparallelconnection2;    //===== NUMBER, ид паралельного параметра (Type=244)
//      long nconnectionparam3;       //===== NUMBER, ид параметра (Type=244)
//      long nparallelconnection3;    //===== NUMBER, ид паралельного параметра (Type=244)
   };
   long *FParamCid;
   int  FParamCidCnt;
   long CurrRow;
   bool __fastcall ReadTreeNode(TObject*obj);// Читает ветку дерева
   void __fastcall SetLabel(int ARow=0);
   void __fastcall SetAccess(TAccess value);
   AnsiString __fastcall GetTypeById(int i);
   int __fastcall GetIdByType(AnsiString s);
   int __fastcall GetIdByRType(AnsiString s);
   void __fastcall SaveUsedData(TObject*);
   void __fastcall ReadUsedData(void);
   void __fastcall ReadSharedData();
   void __fastcall DropUsedData(stPoint*);
   void __fastcall DropSharedData(stPoint*);
   void __fastcall DropParallelData(TTreeNode*,TTreeNode*);
   void __fastcall SaveSharedData(TObject*);
   void __fastcall ReadParams(TObject*);
   void __fastcall ReadParallelData(TObject* = NULL);
   void __fastcall SaveParalelData(TObject*);
   void __fastcall ReadRelatedData();
   void __fastcall DropRelatedData(bool, TTreeNode*);
   void __fastcall SaveRelatedData(TObject*);
public:		// User declarations
   __fastcall TfmParameterPointsList(TComponent* Owner, long *paramCid, int paramCnt, TAccess = accDenied);
protected:
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

