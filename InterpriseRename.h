//---------------------------------------------------------------------------
#ifndef InterpriseRenameH
#define InterpriseRenameH
//---------------------------------------------------------------------------
#include <Buttons.hpp>
#include <Classes.hpp>
#include <Controls.hpp>
#include <ExtCtrls.hpp>
#include <StdCtrls.hpp>
#include "Main.h"
#include <ActnList.hpp>
#include <ImgList.hpp>
#include <Menus.hpp>
#include "DBAccess.hpp"
#include "MemDS.hpp"
#include "Ora.hpp"
#include <DB.hpp>
#include <ComCtrls.hpp>
#include <Dialogs.hpp>
//---------------------------------------------------------------------------
class TFormIntrpriseReneme : public TMainForm
{
__published:	// IDE-managed Components
	TPanel *Panel5;
	TLabel *Label1;
	TEdit *Edit1;
	TLabel *Label2;
	TEdit *Edit2;
	TLabel *Label3;
	TEdit *Edit3;
        TLabel *Label4;
        TLabel *Label5;
        TGroupBox *GroupBox1;
        TLabel *Label6;
        TLabel *Label7;
        TLabel *Label8;
        TEdit *Edit4;
        TEdit *Edit5;
        TCheckBox *CheckBox1;
        TCheckBox *CheckBox2;
        TEdit *Edit6;
        TEdit *Edit7;
        TEdit *Edit8;
        TBitBtn *m_btnSave;
        TSaveDialog *aSaveDialog;
	void __fastcall Edit1Change(TObject *Sender);
  void __fastcall edLongKeyPress(TObject *Sender, char &Key);
        void __fastcall Edit6Change(TObject *Sender);
        void __fastcall Edit7Change(TObject *Sender);
        void __fastcall Edit8Change(TObject *Sender);
        void __fastcall CheckBox1Click(TObject *Sender);
        void __fastcall CheckBox2Click(TObject *Sender);
        void __fastcall m_btnSaveClick(TObject *Sender);
private:	// User declarations
  long Mid;
  void __fastcall SetAccess(TAccess value);
  void __fastcall ReadData(void);
public:		// User declarations
	__fastcall TFormIntrpriseReneme(TComponent* Owner, AnsiString, TAccess = accDenied);
protected:
	void __fastcall vSave(TObject *Sender);
	void __fastcall vRefresh(TObject *Sender);
   __fastcall ~TFormIntrpriseReneme();
};
//---------------------------------------------------------------------------
extern TFormIntrpriseReneme*FormIntrpriseReneme;
//---------------------------------------------------------------------------
#endif
