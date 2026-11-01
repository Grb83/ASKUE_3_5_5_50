//---------------------------------------------------------------------------
#ifndef OperScanPointParH
#define OperScanPointParH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Buttons.hpp>
#include <CheckLst.hpp>
#include <ExtCtrls.hpp>
#include <ComCtrls.hpp>
//---------------------------------------------------------------------------
class TfmOperScanPointPar : public TForm
{
__published:	// IDE-managed Components
  TPanel *Panel2;
  TLabel *Label1;
  TLabel *Label2;
  TEdit *EdRetries;
  TEdit *EdRetriesTout;
  TPanel *Panel1;
  TBitBtn *BitBtn1;
  TBitBtn *BitBtn2;
  TCheckBox *chbBill_Data;
  TEdit *eBill_Data_Dept;
  TLabel *Label4;
  TCheckBox *chbCurr_Data;
  TLabel *Label5;
  TEdit *eCurr_Data_Dept;
  TListView *lbPoints;
  void __fastcall FormCreate(TObject *Sender);
  void __fastcall BitBtn1Click(TObject *Sender);
  void __fastcall BitBtn2Click(TObject *Sender);
  void __fastcall edLongPress(TObject *Sender, char &Key);
  void __fastcall chbBill_DataClick(TObject *Sender);
  void __fastcall chbCurr_DataClick(TObject *Sender);
private:	// User declarations
  int curr_it; 
public:		// User declarations
  __fastcall TfmOperScanPointPar(TComponent* Owner, long curr_item);

  //OPER_POINTS TablePoints[OPER_POINTS_DIM];
  //unsigned long CountStrPoint;
};
//---------------------------------------------------------------------------
extern PACKAGE TfmOperScanPointPar *fmOperScanPointPar;
//---------------------------------------------------------------------------
#endif
