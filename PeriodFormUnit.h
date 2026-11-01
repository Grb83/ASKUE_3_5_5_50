//---------------------------------------------------------------------------

#ifndef PeriodFormUnitH
#define PeriodFormUnitH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
//---------------------------------------------------------------------------
class TPeriodForm : public TForm
{
__published:	// IDE-managed Components
  TPanel *Panel1;
  TButton *OkBtn;
  TButton *CancelBtn;
  TPanel *Panel2;
  TMonthCalendar *MonthCalendar;
private:	// User declarations
public:		// User declarations
  __fastcall TPeriodForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TPeriodForm *PeriodForm;
//---------------------------------------------------------------------------
#endif
