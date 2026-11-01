//---------------------------------------------------------------------------

#ifndef ReportDayChengeH
#define ReportDayChengeH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Buttons.hpp>
#include <ExtCtrls.hpp>
//---------------------------------------------------------------------------
class TfmRepDayChange : public TForm
{
__published:	// IDE-managed Components
        TPanel *Panel1;
        TPanel *Panel2;
        TBitBtn *BitBtn1;
        TBitBtn *BitBtn2;
        TEdit *EditRepDay;
        TLabel *Label1;
private:	// User declarations
public:		// User declarations
        __fastcall TfmRepDayChange(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfmRepDayChange *fmRepDayChange;
//---------------------------------------------------------------------------
#endif
