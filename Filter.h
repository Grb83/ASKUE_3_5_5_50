//---------------------------------------------------------------------------
#ifndef FilterH
#define FilterH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Buttons.hpp>
#include <ExtCtrls.hpp>
//---------------------------------------------------------------------------
extern int FGid;
extern int FGid_adv;

class TfmFilter : public TForm
{
__published:	// IDE-managed Components
        TPanel *Panel1;
        TPanel *Panel2;
        TBitBtn *bbOK;
        TBitBtn *bbCancel;
        TLabel *Label1;
        TLabel *Label2;
        TLabel *Label3;
        TLabel *Label4;
        TLabel *Label5;
        TEdit *ePlan;
        TEdit *eReserv;
        TEdit *eDebtRestr;
        TEdit *eDebt;
        TLabel *Label6;
        TLabel *Label7;
        TLabel *Label8;
        TLabel *Label9;
    TPanel *plJournal;
    TLabel *lTitle;
    TLabel *lType;
    TComboBox *cbType;
    TLabel *lSource;
    TComboBox *cbSource;
    TPanel *plMessages;
    TLabel *Label10;
    TLabel *lMessTitle1;
    TLabel *lMessTitle2;
    TComboBox *cbMessValue1;
  TSpeedButton *btnMainSelect;
  TEdit *edMessValue;
  TEdit *edCode;
  TLabel *lMessTitle3;
  TEdit *edCode2;
  TLabel *lCode2;
  TSpeedButton *btnDelAdvFilter;
  TSpeedButton *btnAdvFilter;
  TEdit *edAdvFilter;
  TLabel *lAdvFilter;
  TPanel *plAdv;
  TLabel *lAdvFilter2;
  TEdit *edAdvFilter2;
  TSpeedButton *btnAdvFilter2;
  TSpeedButton *btnDelAdvFilter2;
  TCheckBox *chbNot2;
  TCheckBox *chbNot;
  TPanel *Panel3;
  TPanel *Panel4;
  TPanel *Panel5;
         void __fastcall EditKeyPress(TObject *Sender,
                        char &Key);
        void __fastcall EditChange(TObject *Sender);
  void __fastcall btnMainSelectClick(TObject *Sender);
  void __fastcall btnAdvFilterClick(TObject *Sender);
  void __fastcall btnDelAdvFilterClick(TObject *Sender);
  void __fastcall btnDelAdvFilter2Click(TObject *Sender);
  void __fastcall btnAdvFilter2Click(TObject *Sender);
private:	// User declarations
public:		// User declarations
        __fastcall TfmFilter(TComponent* Owner);

};
//---------------------------------------------------------------------------
extern PACKAGE TfmFilter *fmFilter;
//---------------------------------------------------------------------------
#endif
