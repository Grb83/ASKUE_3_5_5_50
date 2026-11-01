//---------------------------------------------------------------------------
#ifndef InputParamH
#define InputParamH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <Buttons.hpp>
#include <Mask.hpp>
#include <ComCtrls.hpp>
//---------------------------------------------------------------------------

class TFormInputParam : public TForm
{
__published:	// IDE-managed Components
	TPanel *Panel1;
	TPanel *Panel2;
	TPanel *Panel3;
	TEdit *Edit1;
	TPanel *Panel7;
	TPanel *Panel10;
	TBitBtn *BitBtn2;
	TPanel *Panel15;
	TPanel *Panel16;
	TPanel *Panel17;
	TPanel *Panel18;
	TEdit *Edit3;
	TEdit *Edit4;
	TEdit *Edit5;
	TEdit *Edit6;
	TBitBtn *BitBtn1;
  TMaskEdit *edFrom;
  TDateTimePicker *dtFrom;
  TDateTimePicker *dtTill;
  TMaskEdit *edTill;
  TLabel *Label1;
  TLabel *Label2;
  TLabel *Label3;
  TLabel *Label5;
  TEdit *Edit2;
  TLabel *Label6;
  TEdit *Edit7;
  TLabel *Label7;
  TLabel *Label8;
  TLabel *Label9;
  TLabel *Label4;
  TCheckBox *Cb_delete_all;
        TCheckBox *cb_small_val;
  void __fastcall BitBtn2Click(TObject *Sender);
  void __fastcall BitBtn1Click(TObject *Sender);
  void __fastcall OnChange(TObject *Sender);
  void __fastcall edLongKeyPess(TObject *Sender, char &Key);
  void __fastcall FormActivate(TObject *Sender);
  

  private:
   void __fastcall vRead();
  public:
    __fastcall TFormInputParam(TComponent* Owner,long id,TDateTime dt);
   static bool __fastcall ShowInputParam(TComponent* Owner,long id,TDateTime dt);
   long Mid;
};
//---------------------------------------------------------------------------
extern TFormInputParam *FormInputParam;
//---------------------------------------------------------------------------
#endif
