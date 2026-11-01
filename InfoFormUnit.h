//---------------------------------------------------------------------------

#ifndef InfoFormUnitH
#define InfoFormUnitH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Buttons.hpp>
#include <ComCtrls.hpp>
#include <ToolWin.hpp>
#include <ActnList.hpp>
#include <ImgList.hpp>
//---------------------------------------------------------------------------
class TInfoForm : public TForm
{
__published:	// IDE-managed Components
  TRichEdit *InfoREdit;
  TCoolBar *CoolBar1;
  TToolBar *ToolBar1;
  TStatusBar *StatusBar1;
  TSpeedButton *SpeedButton1;
  TSpeedButton *SpeedButton2;
  TActionList *InfoAList;
  TAction *PrintAction;
  TAction *CloseAction;
  TImageList *ImageList1;
  void __fastcall PrintActionExecute(TObject *Sender);
  void __fastcall CloseActionExecute(TObject *Sender);
  void __fastcall FormCreate(TObject *Sender);
  void __fastcall FormClose(TObject *Sender, TCloseAction &Action);
  void __fastcall FormKeyDown(TObject *Sender, WORD &Key,
          TShiftState Shift);
private:	// User declarations
public:		// User declarations
  __fastcall TInfoForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TInfoForm *InfoForm;
//---------------------------------------------------------------------------
#endif
