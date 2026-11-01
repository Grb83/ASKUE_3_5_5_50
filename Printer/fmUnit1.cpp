//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "fmUnit1.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TForm1 *Form1;
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
	: TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TForm1::ButtonLoadClick(TObject *Sender)
{
	if(OpenDialog1->Execute())
	{
		SL->Clear();
		SL->LoadFromFile(OpenDialog1->FileName);
		LoadText();
		ButtonRefreshClick(Sender);
	}
}
//---------------------------------------------------------------------------
void __fastcall TForm1::ButtonFontClick(TObject *Sender)
{
	if(FontDialog1->Execute())
	{
		bmp->Canvas->Font = FontDialog1->Font;
		LoadText();
		ButtonRefreshClick(Sender);
	}
}
//---------------------------------------------------------------------------

void __fastcall TForm1::FormCreate(TObject *Sender)
{
	SL = new TStringList();
	bmp = new Graphics::TBitmap;

	bmp->Canvas->Font = FontDialog1->Font;
	Image1->Canvas->CopyMode = cmSrcCopy;
	bmp->Monochrome = true;
	Image1->Picture->Bitmap->Monochrome = true;
	Spacing = MESpacing->Text.ToDouble() / 100;

	TBLeftIndent->Left = Image1->Left - 6;
	TBTopIndent->Top = Image1->Top - 6;

	TBLeftIndent->Tag = TBLeftIndent->Width;
	TBTopIndent->Tag = TBTopIndent->Height;
	TBRightIndent->Tag = TBRightIndent->Width;
	TBBottomIndent->Tag = TBBottomIndent->Height;
	TBLeftIndent->Max = TBLeftIndent->Width - 12;
	TBTopIndent->Max = TBTopIndent->Height - 12;
	TBRightIndent->Min = - TBRightIndent->Width + 12;
	TBBottomIndent->Min = - TBBottomIndent->Height + 12;
	ButtonRefreshClick(Sender);
}
//---------------------------------------------------------------------------

void __fastcall TForm1::FormDestroy(TObject *Sender)
{
	delete bmp;
	delete SL;
}
//---------------------------------------------------------------------------
#define STR_HEIGHT (-(1 + Spacing) * bmp->Canvas->Font->Height)
void TForm1::OutText()
{
	Image1->Picture->Bitmap->Width = EditWidth->Tag * Scale;
	Image1->Picture->Bitmap->Height = EditHeight->Tag * Scale;
	TBRightIndent->Left = Image1->Left + Image1->Width - TBRightIndent->Width + 6;
	TBBottomIndent->Top = Image1->Top + Image1->Height - TBBottomIndent->Height + 6;

	Image1->Picture->Bitmap->Canvas->FillRect(Rect(0, 0,
		Image1->Picture->Bitmap->Width, Image1->Picture->Bitmap->Height));

	Lines = floor((EditHeight->Tag - LETop->Tag -
		LEBottom->Tag) / STR_HEIGHT);
	float H = Lines * STR_HEIGHT,
		HL = NextPage * Lines * STR_HEIGHT;

	Label1->Caption = "Page " + IntToStr(NextPage + 1) + " of " +
		IntToStr(NumLines / Lines + 1);
	Image1->Picture->Bitmap->Canvas->CopyRect(Rect(LELeft->Tag * Scale,
		LETop->Tag * Scale, Image1->Width - LERight->Tag * Scale,
		(H + LETop->Tag) * Scale), bmp->Canvas, Rect(0, HL,
		EditWidth->Tag - LELeft->Tag - LERight->Tag, HL + H));
}


void __fastcall TForm1::Button3Click(TObject *Sender)
{
	LPTEXTMETRIC lptm = new TEXTMETRIC;
	HDC hdc = GetDC(bmp->Canvas->Handle);
	GetTextMetrics(hdc, lptm);
	ShowMessage(IntToStr(bmp->Width) + " X " + IntToStr(bmp->Height) +
		", " + MEScale->Text + ", " + MEScale->EditText + "\n" +
		IntToStr(lptm->tmExternalLeading));
	delete lptm;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::FormKeyDown(TObject *Sender, WORD &Key,
      TShiftState Shift)
{
	switch(Key)
	{
		case VK_PRIOR:
			BitBtnUp->Click();
			break;
		case VK_NEXT:
			BitBtnDown->Click();
			break;
		case VK_ESCAPE:
			Close();
	}
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Image1DblClick(TObject *Sender)
{
//	ShowMessage(IntToStr(Image1->Width) + " , " + IntToStr(Image1->Height));
	if(Scale < 1)
		MEScale->Text = "100";
	else
		MEScale->Text = "50";
	ButtonRefreshClick(Sender);
}
//---------------------------------------------------------------------------

void __fastcall TForm1::ButtonRefreshClick(TObject *Sender)
{
	Scale = MEScale->Text.ToDouble() / 100;

	TBLeftIndent->Width = TBLeftIndent->Tag * Scale;
	TBTopIndent->Height = TBTopIndent->Tag * Scale;
	TBRightIndent->Width = TBRightIndent->Tag * Scale;
	TBBottomIndent->Height = TBBottomIndent->Tag * Scale;

	LELeft->Tag = CmToPixels(LELeft->Text.ToDouble());
	LERight->Tag = CmToPixels(LERight->Text.ToDouble());
	LETop->Tag = CmToPixels(LETop->Text.ToDouble());
	LEBottom->Tag = CmToPixels(LEBottom->Text.ToDouble());
	EditWidth->Tag = CmToPixels(EditWidth->Text.ToDouble());
	EditHeight->Tag = CmToPixels(EditHeight->Text.ToDouble());

	TBLeftIndent->Position = LELeft->Tag;
	TBTopIndent->Position = LETop->Tag;
	TBRightIndent->Position = - LERight->Tag;
	TBBottomIndent->Position = - LEBottom->Tag;

	if(Spacing != MESpacing->Text.ToDouble() / 100)
	{
		Spacing = MESpacing->Text.ToDouble() / 100;
		LoadText();
	}
	OutText();
}
//---------------------------------------------------------------------------

void TForm1::LoadText()
{
	bmp->Canvas->FillRect(Rect(0, 0, bmp->Width, bmp->Height));
	int W = 0;
	for(int i = 0; i < SL->Count; i++)
		bmp->Canvas->TextWidth(SL->Strings[i]) > W ?
			W = bmp->Canvas->TextWidth(SL->Strings[i]) : 0;

	bmp->Width = W;
	bmp->Height = STR_HEIGHT * SL->Count;
	NextPage = 0;
	NumLines = SL->Count;
	for(int i = 0; i < SL->Count; i++)
	{
		bmp->Canvas->TextOut(0, STR_HEIGHT * i, SL->Strings[i]);
	}
}

void __fastcall TForm1::ButtonAllClick(TObject *Sender)
{

	Image1->Picture->Bitmap->Assign(bmp);
}
//---------------------------------------------------------------------------

int TForm1::InchesToPixels(float Inches)
{
	return (Inches * bmp->Canvas->Font->PixelsPerInch);
}

int TForm1::CmToPixels(float Cm)
{
	return (InchesToPixels(Cm / 2.54));
}
void __fastcall TForm1::TBIndentsChange(TObject *Sender)
{
	if(((TTrackBar*)Sender)->Name == "TBLeftIndent")
		LELeft->Tag = ((TTrackBar*)Sender)->Position;
	else if(((TTrackBar*)Sender)->Name == "TBRightIndent")
		LERight->Tag = - ((TTrackBar*)Sender)->Position;
	else if(((TTrackBar*)Sender)->Name == "TBTopIndent")
		LETop->Tag = ((TTrackBar*)Sender)->Position;
	else if(((TTrackBar*)Sender)->Name == "TBBottomIndent")
		LEBottom->Tag = - ((TTrackBar*)Sender)->Position;

	LELeft->Text = PixelsToCm(LELeft->Tag);
	LERight->Text = PixelsToCm(LERight->Tag);
	LETop->Text = PixelsToCm(LETop->Tag);
	LEBottom->Text = PixelsToCm(LEBottom->Tag);

	OutText();
}
//---------------------------------------------------------------------------

void __fastcall TForm1::FormMouseWheelDown(TObject *Sender,
      TShiftState Shift, TPoint &MousePos, bool &Handled)
{
	Handled = true;
	BitBtnDown->Click();
}
//---------------------------------------------------------------------------

void __fastcall TForm1::FormMouseWheelUp(TObject *Sender,
      TShiftState Shift, TPoint &MousePos, bool &Handled)
{
	Handled = true;
	BitBtnUp->Click();
}
//---------------------------------------------------------------------------

void __fastcall TForm1::BitBtnDownClick(TObject *Sender)
{
	if((NextPage + 1) * Lines < NumLines)
	{
		NextPage ++;
		OutText();
	}
}
//---------------------------------------------------------------------------

void __fastcall TForm1::BitBtnUpClick(TObject *Sender)
{
	if(NextPage)
	{
		NextPage --;
		OutText();
	}
}
//---------------------------------------------------------------------------

void __fastcall TForm1::ButtonPrintClick(TObject *Sender)
{

	TPrinter *prn = Printer();
        TFont *font = new TFont;
        font->Assign(prn->Canvas->Font);
        prn->Canvas->Font->Assign(bmp->Canvas->Font);
	prn->BeginDoc();
/////////////////////////////////////Printing
	for(unsigned PageNum = 0; (PageNum) * Lines < NumLines; PageNum ++)
	{
        for(unsigned i = 0; i < Lines && i + PageNum * Lines < NumLines; i ++)
			prn->Canvas->TextOut(LELeft->Tag, LETop->Tag +
				i * -(1 + Spacing) *
				prn->Canvas->Font->Height,
				SL->Strings[i + PageNum * Lines]);

                if((PageNum + 1) * Lines < NumLines)
        		prn->NewPage();
	}
/////////////////////////////////////Printing
	prn->EndDoc();
        prn->Canvas->Font->Assign(font);
        delete font;
}
//---------------------------------------------------------------------------

float TForm1::PixelsToInches(int Pixels)
{
	return SimpleRoundTo((float)Pixels / bmp->Canvas->Font->PixelsPerInch);
}

float TForm1::PixelsToCm(int Pixels)
{
	return SimpleRoundTo(PixelsToInches(Pixels) * 2.54);
}

//---------------------------------------------------------------------------

void __fastcall TForm1::NZoomClick(TObject *Sender)
{
	if(!((TMenuItem*)Sender)->Checked)
	{
		((TMenuItem*)Sender)->Checked = true;
		MEScale->Text = ((TMenuItem*)Sender)->Caption.SubString(1,
			((TMenuItem*)Sender)->Caption.Length()-2);
		ButtonRefreshClick(Sender);
	}
}
//---------------------------------------------------------------------------



