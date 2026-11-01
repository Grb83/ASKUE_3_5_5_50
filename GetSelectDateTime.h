//---------------------------------------------------------------------------

#ifndef GetSelectDateTimeH
#define GetSelectDateTimeH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ComCtrls.hpp>
#include <Mask.hpp>
#include <Buttons.hpp>
#include <ExtCtrls.hpp>
//---------------------------------------------------------------------------
class TfmGetSelectDateTime : public TForm
{
__published:	// IDE-managed Components
        TDateTimePicker *dtpDate;
        TDateTimePicker *dtpTime;
    TBitBtn *BitBtn1;
    TBitBtn *BitBtn2;
  TPanel *plRecMonitor;
  TPanel *plSupMain;
  TPanel *Panel1;
  TComboBox *cbMonth;
  TLabel *lbMonth;
  TEdit *edYear;
  TLabel *Label1;
        void __fastcall FormKeyDown(TObject *Sender, WORD &Key,
          TShiftState Shift);
  void __fastcall edYearKeyPress(TObject *Sender, char &Key);
  void __fastcall edYearExit(TObject *Sender);
private:
        TDateTime FDateTime;
        void __fastcall SetDateTime(TDateTime value);
        TDateTime __fastcall GetDateTime();	// User declarations
public:		// User declarations
        
        __fastcall TfmGetSelectDateTime(TComponent* Owner);
        __property TDateTime DateTime  = { read=GetDateTime, write=SetDateTime };
};
//---------------------------------------------------------------------------
extern PACKAGE TfmGetSelectDateTime *fmGetSelectDateTime;
//---------------------------------------------------------------------------
#endif
