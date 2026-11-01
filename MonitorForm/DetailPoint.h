//---------------------------------------------------------------------------

#ifndef DetailPointH
#define DetailPointH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include "DBGridEh.hpp"
#include <Grids.hpp>
#include "FormDescr.h"
#include "MemDS.hpp"
#include "VirtualTable.hpp"
#include <DB.hpp>
#include "DBAccess.hpp"
#include "Ora.hpp"
#include <Buttons.hpp>
#include <ImgList.hpp>
//---------------------------------------------------------------------------
#define MaxInd       1000
//---------------------------------------------------------------------------------
class TfmDetailPoint : public TForm
{
__published:	// IDE-managed Components
  TPanel *plDetail;
  TPanel *Panel4;
  TDBGridEh *grDetail;
  TVirtualTable *vtData;
  TOraQuery *oqObjType;
  TOraQuery *oqReadRow;
  TOraDataSource *dsReadRow;
  TMemo *editFrmla;
  TPanel *Panel2;
  TLabel *lbFormula;
  TLabel *lbMeas;
  TComboBox *cbMeas;
  TPanel *Panel3;
  TPanel *Panel5;
  TSplitter *Splitter1;
  TPanel *Panel6;
  TOraQuery *oqDataFormula;
  TOraQuery *oqArgument;
  TOraQuery *oqTest;
  TSpeedButton *SpeedButton2;
  TSpeedButton *SpeedButton1;
  TImageList *ImageList1;
  TLabel *Label1;
  TLabel *eTypeF;
  void __fastcall FormActivate(TObject *Sender);
  void __fastcall grDetailDrawColumnCell(TObject *Sender,
          const TRect &Rect, int DataCol, TColumnEh *Column,
          TGridDrawState State);
  void __fastcall grDetailMouseUp(TObject *Sender, TMouseButton Button,
          TShiftState Shift, int X, int Y);
  void __fastcall grDetailMouseDown(TObject *Sender, TMouseButton Button,
          TShiftState Shift, int X, int Y);
  void __fastcall SpeedButton1Click(TObject *Sender);
  void __fastcall SpeedButton2Click(TObject *Sender);
  void __fastcall cbMeasChange(TObject *Sender);
private:	// User declarations
  TFormDescr* iFD;
  void __fastcall GetColumnName();
  void __fastcall vParams(TObject* Sender);
  void __fastcall vRefresh(TObject* Sender);
  bool __fastcall ReadDataRow();
  void __fastcall ReadDataRowGreen();
  void __fastcall SpezRef();
  long __fastcall GetCodeTemplate();
  void __fastcall ReadDataFormula(int aCodeTemplate,int aMid);
  void __fastcall ReadDataArgument();
  bool __fastcall GetQuality(char *isvalid);
   int ColCount;
   AnsiString NameGroup;
   int RowCount;
   int TCount;
   int IdGroup;
   bool ColPresed;
   bool ColValidPressed;
   struct IF{
         int Id;
         int Ind;
      } IdForm[1000];
  // int IdForm[1000];
   int ObjIDCount;
   int Max;
   int Ind;
public:		// User declarations
  __fastcall TfmDetailPoint(TComponent* Owner);
  void SetFormDesc(TFormDescr* aFD,int aIdGroup,int aInd);
};
//---------------------------------------------------------------------------
extern PACKAGE TfmDetailPoint *fmDetailPoint;
//---------------------------------------------------------------------------
#endif
