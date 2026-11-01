//---------------------------------------------------------------------------

#ifndef fmUnit1H
#define fmUnit1H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <Dialogs.hpp>
#include <Mask.hpp>
#include <ComCtrls.hpp>
#include <Buttons.hpp>
#include <Printers.hpp>
#include <Math.hpp>
#include <math.h>
#include <Menus.hpp>
//---------------------------------------------------------------------------
class TForm1 : public TForm
{
__published:	// IDE-managed Components
	TButton *ButtonLoad;
	TOpenDialog *OpenDialog1;
	TButton *ButtonFont;
	TFontDialog *FontDialog1;
	TButton *Button3;
	TScrollBox *ScrollBox1;
	TImage *Image1;
	TButton *ButtonRefresh;
	TButton *ButtonAll;
	TGroupBox *GBSizes;
	TEdit *EditWidth;
	TEdit *EditHeight;
	TMaskEdit *MEScale;
	TTrackBar *TBLeftIndent;
	TTrackBar *TBRightIndent;
	TTrackBar *TBTopIndent;
	TTrackBar *TBBottomIndent;
	TLabel *LabelScale;
	TBitBtn *BitBtnUp;
	TBitBtn *BitBtnDown;
	TButton *ButtonPrint;
	TPrintDialog *PrintDialog1;
	TLabel *Label1;
	TMaskEdit *MESpacing;
	TLabel *Label2;
        TLabel *Label3;
        TLabel *Label4;
        TGroupBox *GroupBox1;
        TLabel *Label5;
        TEdit *LETop;
        TLabel *Label6;
        TEdit *LEBottom;
        TLabel *Label7;
        TEdit *LELeft;
        TLabel *Label8;
        TEdit *LERight;
	void __fastcall ButtonLoadClick(TObject *Sender);
	void __fastcall ButtonFontClick(TObject *Sender);
	void __fastcall FormCreate(TObject *Sender);
	void __fastcall FormDestroy(TObject *Sender);
	void __fastcall Button3Click(TObject *Sender);
	void __fastcall FormKeyDown(TObject *Sender, WORD &Key,
          TShiftState Shift);
	void __fastcall Image1DblClick(TObject *Sender);
	void __fastcall ButtonRefreshClick(TObject *Sender);
	void __fastcall ButtonAllClick(TObject *Sender);
	void __fastcall TBIndentsChange(TObject *Sender);
	void __fastcall FormMouseWheelDown(TObject *Sender, TShiftState Shift,
          TPoint &MousePos, bool &Handled);
	void __fastcall FormMouseWheelUp(TObject *Sender, TShiftState Shift,
          TPoint &MousePos, bool &Handled);
	void __fastcall BitBtnDownClick(TObject *Sender);
	void __fastcall BitBtnUpClick(TObject *Sender);
	void __fastcall ButtonPrintClick(TObject *Sender);
	void __fastcall NZoomClick(TObject *Sender);
private:	// User declarations
	TStringList *SL;
	Graphics::TBitmap *bmp;
	float Scale, Spacing;
	unsigned NextPage, Lines, NumLines;
public:		// User declarations
	__fastcall TForm1(TComponent* Owner);
	void OutText();
	void LoadText();
	int InchesToPixels(float Inches);
	int CmToPixels(float Cm);
	float PixelsToInches(int Pixels);
	float PixelsToCm(int Pixels);
protected:
};
//---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
