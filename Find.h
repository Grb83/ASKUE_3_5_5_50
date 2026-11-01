//---------------------------------------------------------------------------

#ifndef FindH
#define FindH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Buttons.hpp>
#include <ExtCtrls.hpp>
#define EN 1
#define ED 2
#define Q1 3
#define Q2 4
#define Q3 5
#define Q4 6
//---------------------------------------------------------------------------
class TFindForm : public TForm
{
__published:	// IDE-managed Components
   TBitBtn *bbOk;
   TBitBtn *bbCancel;
   TLabel *lMeasure;
   TRadioGroup *rgDirection;
   TCheckBox *cbCase;
   TRadioGroup *rgOrigin;
   TGroupBox *gbParams;
   TCheckBox *cbAP;
   TCheckBox *cbAM;
   TCheckBox *cbRP;
   TCheckBox *cbRM;
   TEdit *eAP;
   TEdit *eAM;
   TEdit *eRP;
   TEdit *eRM;
   TComboBox *cbMeasure;
   void __fastcall cbClick(TObject *Sender);
   void __fastcall bbOkClick(TObject *Sender);
private:
   bool __fastcall conformance(char*, char*);	// User declarations
public:		// User declarations
   struct TMeasure{
      AnsiString text;
      int entype, pos;
   };
   long currPos;
   __fastcall TFindForm(TComponent* Owner);
   bool __fastcall Compare(TMeasure*);
   __fastcall ~TFindForm();
};
//---------------------------------------------------------------------------
extern PACKAGE TFindForm *FindForm;
//---------------------------------------------------------------------------
#endif
