//---------------------------------------------------------------------------
#ifndef InputParametersH
#define InputParametersH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Buttons.hpp>
#include <Grids.hpp>
//---------------------------------------------------------------------------
class TFormInputParameters : public TForm
{
__published:	// IDE-managed Components
    TBitBtn *bbOk;
    TBitBtn *bbCancel;
    TLabel *lDate;
    TStringGrid *meDate;
    void __fastcall meDateGetEditMask(TObject *Sender, int ACol, int ARow, AnsiString &Value);
private:	// User declarations
public:		// User declarations
    __fastcall TFormInputParameters(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TFormInputParameters *FormInputParameters;
//---------------------------------------------------------------------------
#endif
