//---------------------------------------------------------------------------
#ifndef PointConditionsH
#define PointConditionsH
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
//---------------------------------------------------------------------------
struct TItemData
{
  TItemData(int Param, AnsiString Name, AnsiString Condition);
  int NParam;
  AnsiString VName;
  AnsiString VCondition;
};
//---------------------------------------------------------------------------
class TfmPointConditions : public TMainForm
{
__published:	// IDE-managed Components
   TSplitter *Splitter1;
   TPanel *plBase;
   TStringGrid *sgPointsList;
   TPopupMenu *pmUSDList;
   TMenuItem *miCapUSDList;
   TMenuItem *miSepUSDList;
   TBitBtn *bbDeletePoint;
   TAction *aBlocking;
   TAction *aDataAbsence;
   TListView *ParamsList;
  TPanel *paInfo;
  TOraQuery *oqSavePointConditions;
  void __fastcall FormResize(TObject *Sender);
  void __fastcall ParamsListStartDrag(TObject *Sender,
          TDragObject *&DragObject);
  void __fastcall sgPointsListDragOver(TObject *Sender, TObject *Source,
          int X, int Y, TDragState State, bool &Accept);
  void __fastcall sgPointsListDragDrop(TObject *Sender, TObject *Source,
          int X, int Y);
  void __fastcall sgPointsListSelectCell(TObject *Sender, int ACol,
          int ARow, bool &CanSelect);
  void __fastcall sgPointsListSetEditText(TObject *Sender, int ACol,
          int ARow, const AnsiString Value);
private:	// User declarations
   TItemData *DragData;
   void __fastcall SetAccess(TAccess value);
   void __fastcall SetLabel(int ARow=0);
   void LoadParams();
   TListItem* AddParam(long id, AnsiString Name, AnsiString Condition);
   void LoadPointConditions();
   void SavePointConditions();
public:		// User declarations
   __fastcall TfmPointConditions(TComponent* Owner, int aPointId, TAccess = accDenied);
   int PointId;
protected:
   void __fastcall vUpdate(TObject*Sender);
   void __fastcall vDelete(TObject *Sender);
   void __fastcall vRefresh(TObject *Sender);
   void __fastcall vSave(TObject *Sender);
};
//---------------------------------------------------------------------------
#endif

