//---------------------------------------------------------------------------
#ifndef TeleControlSignalsH
#define TeleControlSignalsH
#include "DBGridEh.hpp"
#include "Main.h"
#include "MemDS.hpp"
#include "VirtualTable.hpp"
#include <ActnList.hpp>
#include <Buttons.hpp>
#include <Classes.hpp>
#include <ComCtrls.hpp>
#include <Controls.hpp>
#include <Db.hpp>
#include <ExtCtrls.hpp>
#include <Grids.hpp>
#include <ImgList.hpp>
#include <Menus.hpp>
#include <StdCtrls.hpp>
//---------------------------------------------------------------------------
#include <ActnList.hpp>
#include <Buttons.hpp>
#include <Classes.hpp>
#include <Controls.hpp>
#include <ExtCtrls.hpp>
#include <StdCtrls.hpp>
#include "DrawTable.h"
#include "Main.h"
#include <ImgList.hpp>
#include <Menus.hpp>
#include <ComCtrls.hpp>
#include "MemDS.hpp"
#include "VirtualTable.hpp"
#include <Db.hpp>
#include <DBGrids.hpp>
#include <Grids.hpp>
#include "DBGridEh.hpp"
#include <DBCtrls.hpp>
#include <DB.hpp>
#include "DBAccess.hpp"
#include "Ora.hpp"

//---------------------------------------------------------------------------
 struct TItemData
 {
   TItemData();
   TItemData(long aNParam);
   long NParam;
   bool Modified;
   long tmp_NParam;
 };

class TFormTeleControlSignals : public TMainForm
{
__published:	// IDE-managed Components
   TBitBtn *bbAdd;
   TBitBtn *bbEdit;
   TBitBtn *bbDel;
  TVirtualTable *ConditionsVTable;
  TDataSource *ConditionsDS;
  TSplitter *Splitter1;
  TStringField *ConditionsVTableCondition;
  TPanel *Panel1;
  TDBGridEh *ConditionsDBGrid;
  TPanel *Panel2;
  TDBNavigator *DBNavigator1;
  TDateTimeField *ConditionsVTableDStart;
  TLabel *lbTitle;
  TTreeView *ParamsList;
  TOraQuery *oqSaveConditions;
  void __fastcall ConditionsVTableAfterInsert(TDataSet *DataSet);
  void __fastcall ConditionsVTableAfterDelete(TDataSet *DataSet);
  void __fastcall ConditionsDBGridEnter(TObject *Sender);
  void __fastcall ConditionsDBGridExit(TObject *Sender);
  void __fastcall iaCloseExecute(TObject *Sender);
  void __fastcall FormShow(TObject *Sender);
  void __fastcall ParamsListChanging(TObject *Sender, TTreeNode *Node,
          bool &AllowChange);
  void __fastcall ParamsListEdited(TObject *Sender, TTreeNode *Node,
          AnsiString &S);
  void __fastcall ParamsListChange(TObject *Sender, TTreeNode *Node);
private:// User declarations
   void __fastcall SetAccess(TAccess value);
   TTreeNode* AddParam(long id, AnsiString Name);
   void NewParam();
   void DeleteParam();
   void SaveParams();
   void LoadParams();
   void NewCondition();
   void DeleteCondition();
   void LoadConditions(long NParam);
   void SaveConditions(long NParam);
   void ClearList();
   int DelItems[1000];
   int DelItemsCount;
   bool LoadingConditions;
public:		// User declarations
	__fastcall TFormTeleControlSignals(TComponent* Owner, AnsiString, TAccess = accDenied);
   virtual __fastcall ~TFormTeleControlSignals();
protected:
   void __fastcall vSave(TObject* Sender);
   void __fastcall vCheck(TObject *Sender);
   void __fastcall vParams(TObject *Sender);
   void __fastcall vDelete(TObject *Sender);
   void __fastcall vNew(TObject *Sender);
   void __fastcall vRefresh(TObject* Sender);
};
//---------------------------------------------------------------------------
#endif
