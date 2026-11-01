//---------------------------------------------------------------------------

#ifndef CopySchemaParamsH
#define CopySchemaParamsH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Buttons.hpp>
//---------------------------------------------------------------------------
class TFormCopyShcema : public TForm
{
__published:	// IDE-managed Components
    TLabel *lSchemaName;
    TComboBox *cbSchemaName;
    TCheckBox *cbGroupCopy;
    TBitBtn *btOk;
    TBitBtn *btCancel;
    TCheckBox *cbFileCopy;
    void __fastcall btOkClick(TObject *Sender);
private:	// User declarations
public:		// User declarations
    __fastcall TFormCopyShcema(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TFormCopyShcema *FormCopyShcema;
//---------------------------------------------------------------------------
#endif
