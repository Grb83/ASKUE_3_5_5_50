//---------------------------------------------------------------------------

#ifndef GetSelectDateH
#define GetSelectDateH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Buttons.hpp>
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
//---------------------------------------------------------------------------
class TfmGetSelectDate : public TForm
{
__published:	// IDE-managed Components
        TPanel *plSupMain;
        TPanel *Panel1;
        TLabel *Label1;
        TDateTimePicker *dtpDate;
        TBitBtn *BitBtn1;
        TBitBtn *BitBtn2;
        TEdit *CurrDate;
        TLabel *Label2;
private:	// User declarations
        TDateTime FDateTime;
        void __fastcall SetDateTime(TDateTime value);
        TDateTime __fastcall GetDateTime();	// User declarations

public:		// User declarations
        __fastcall TfmGetSelectDate(TComponent* Owner);
        __fastcall TfmGetSelectDate(TComponent* Owner, AnsiString pageDate);

        __property TDateTime DateTime  = { read=GetDateTime, write=SetDateTime };

};
//---------------------------------------------------------------------------
extern PACKAGE TfmGetSelectDate *fmGetSelectDate;
//---------------------------------------------------------------------------
#endif
