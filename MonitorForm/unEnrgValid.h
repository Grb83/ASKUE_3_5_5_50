//---------------------------------------------------------------------------

#ifndef unEnrgValidH
#define unEnrgValidH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <ComCtrls.hpp>
#include <ImgList.hpp>
#include <ActnList.hpp>
//---------------------------------------------------------------------------
class TfmEnrgValid : public TForm
{
__published:	// IDE-managed Components
  TPanel *Panel1;
  TButton *btnClose;
  TPanel *Panel2;
  TPanel *pnlRequir;
  TLabel *lblRequir;
  TPanel *Panel3;
  TPanel *Panel4;
  TPageControl *pcUnRequir;
  TTabSheet *tsGOST;
  TTabSheet *tsEN;
  TImage *QuatImage1;
  TPanel *Panel5;
  TPanel *Panel6;
  TImage *Image1;
  TPanel *Panel7;
  TImage *Image2;
  TPanel *Panel8;
  TImage *Image3;
  TPanel *Panel9;
  TImage *Image4;
  TPanel *Panel10;
  TImage *Image5;
  TPanel *Panel11;
  TImage *Image6;
  TPanel *Panel12;
  TImage *Image7;
  TPanel *Panel13;
  TImage *Image8;
  TPanel *Panel14;
  TImage *Image9;
  TPanel *Panel15;
  TImage *Image10;
  TPanel *Panel16;
  TImage *Image11;
  TPanel *Panel17;
  TImage *Image12;
  TPanel *Panel18;
  TImage *Image13;
  TPanel *Panel19;
  TImage *Image14;
  TPanel *Panel20;
  TImage *Image15;
  TPanel *Panel21;
  TImage *Image16;
  TPanel *Panel22;
  TImage *Image17;
  TPanel *Panel23;
  TImage *Image18;
  TPanel *Panel24;
  TImage *Image19;
  TPanel *Panel25;
  TImage *Image20;
  TPanel *Panel26;
  TImage *Image21;
  TImageList *ImageList1;
  TActionList *ActionList1;
  TAction *Action1;
  void __fastcall FormResize(TObject *Sender);
  void __fastcall Action1Execute(TObject *Sender);
private:	// User declarations
  void __fastcall ReadData(char isval[32]);
public:		// User declarations
  __fastcall TfmEnrgValid(TComponent* Owner,char isvalid[32],AnsiString Name,AnsiString NameForm);
};
//---------------------------------------------------------------------------
extern PACKAGE TfmEnrgValid *fmEnrgValid;
//---------------------------------------------------------------------------
#endif
