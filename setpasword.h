//---------------------------------------------------------------------------
#ifndef setpaswordH
#define setpaswordH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <Buttons.hpp>
#include <Mask.hpp>
//---------------------------------------------------------------------------
class TFormSetPasword : public TForm
{
__published:	// IDE-managed Components
	TPanel *Panel1;
	TLabel *Label2;
	TLabel *Label3;
	TLabel *Label4;
  TBitBtn *btOk;
	TBitBtn *BitBtn2;
  TMaskEdit *me1;
  TMaskEdit *me3;
  TMaskEdit *me2;
	void __fastcall btOkClick(TObject *Sender);
private:
  bool __fastcall setPassword(char* NewPassw);
public:		// User declarations
	__fastcall TFormSetPasword(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern TFormSetPasword *FormSetPasword;
//---------------------------------------------------------------------------
#endif
