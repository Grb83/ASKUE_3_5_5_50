//---------------------------------------------------------------------------
#ifndef OperScanSchedEdH
#define OperScanSchedEdH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Buttons.hpp>
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <Mask.hpp>
//---------------------------------------------------------------------------
class TfmOperScanSchedEd : public TForm
{
__published:	// IDE-managed Components
  TPanel *Panel1;
  TPanel *Panel2;
  TBitBtn *btOk;
  TBitBtn *btCancel;
  TLabel *Label1;
  TLabel *Label2;
  TEdit *edPeriod;
  TMaskEdit *MEdEnd;
  void __fastcall btOkClick(TObject *Sender);
  void __fastcall edLongPress(TObject *Sender, char &Key);
private:	// User declarations
  void __fastcall CheckInteger(void);
  void __fastcall CheckHBound(void);
public:		// User declarations
  __fastcall TfmOperScanSchedEd(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfmOperScanSchedEd *fmOperScanSchedEd;
//---------------------------------------------------------------------------
#endif
