//---------------------------------------------------------------------------

#ifndef InputParameters4H
#define InputParameters4H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Buttons.hpp>
#include <Grids.hpp>
#include <Mask.hpp>
//---------------------------------------------------------------------------
class TFormInputParameters4 : public TForm
{
__published:	// IDE-managed Components
    TLabel *lProfileDate;
    TBitBtn *bbOk;
    TBitBtn *bbCancel;
    TLabel *lHalfDate;
    TLabel *lBillDate;
    TCheckBox *cbProfileDate;
    TCheckBox *cbHalfDate;
    TCheckBox *cbBillDate;
    TLabel *lDescr;
    TLabel *lMonthDate;
    TCheckBox *cbMonthDate;
    TMaskEdit *meProfileDate;
    TMaskEdit *meHalfDate;
    TMaskEdit *meBillDate;
    TMaskEdit *meMonthDate;
  TLabel *Label1;
  TLabel *Label2;
  TMaskEdit *meProfileDateEnd;
  TLabel *Label3;
  TLabel *Label4;
  TMaskEdit *meHalfDateEnd;
  TMaskEdit *meBillDateEnd;
  TMaskEdit *meMonthDateEnd;
  TLabel *Label5;
  TLabel *Label6;
  TLabel *Label7;
  TLabel *Label8;
  TMaskEdit *meJournalDateEnd;
  TLabel *Label10;
  TMaskEdit *meJournalDate;
  TLabel *Label9;
  TCheckBox *cbJournalDate;
  TLabel *lJournalDate;
  TMaskEdit *meCurrentDateEnd;
  TLabel *Label12;
  TMaskEdit *meCurrentDate;
  TLabel *Label11;
  TCheckBox *cbCurrentDate;
  TLabel *lCurrentDate;
        TGroupBox *GroupBox1;
        TLabel *IAllDate;
        TCheckBox *cbAllDate;
        TLabel *Label13;
        TMaskEdit *allProfileDate;
        TMaskEdit *allProfileDateEnd;
        TLabel *Label14;
    void __fastcall cbClick(TObject *Sender);
    void __fastcall cbClickAll(TObject *Sender);
private:	// User declarations
public:		// User declarations
    __fastcall TFormInputParameters4(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TFormInputParameters4 *FormInputParameters4;
//---------------------------------------------------------------------------
#endif
