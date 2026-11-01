//---------------------------------------------------------------------------
#ifndef ParamCommunicationServerH
#define ParamCommunicationServerH
//---------------------------------------------------------------------------
#include <ActnList.hpp>
#include <Buttons.hpp>
#include <Classes.hpp>
#include <Controls.hpp>
#include <ExtCtrls.hpp>
#include <Mask.hpp>
#include <StdCtrls.hpp>
#include "Main.h"
#include <ImgList.hpp>
#include <Menus.hpp>
//---------------------------------------------------------------------------
class TFormParamCommunicationServer : public TMainForm
{
__published:	// IDE-managed Components
	TPanel *Panel5;
	TPanel *Panel6;
	TPanel *Panel7;
	TMaskEdit *MaskEdit1;
	TMaskEdit *MaskEdit2;
	TPanel *Panel8;
	TCheckBox *CheckBox1;
	TCheckBox *CheckBox4;
   TAction *aClockCorrect;
   TAction *aWriteCurrYear;
  TButton *btMessage;
	void __fastcall FormCreate(TObject *Sender);
	void __fastcall ChangeData(TObject *Sender);
   void __fastcall aExecute(TObject *Sender);
  void __fastcall btMessageClick(TObject *Sender);
private:	// User declarations
   typedef struct CS_profile{
      int min_delta;
      int max_delta;
      char clock_set[4];
      char curr_meter[4];
   }CS_PROFILE;

   CS_PROFILE TreeTable[1];
   int Cang;
   void __fastcall SetAccess(TAccess value);
public:		// User declarations
   __fastcall TFormParamCommunicationServer(TComponent* Owner, AnsiString, TAccess = accDenied);
   void  TreeRead();
   bool  TreeWrite();
protected:
	void __fastcall vSave(TObject *Sender);
	void __fastcall vRefresh(TObject *Sender);
   __fastcall ~TFormParamCommunicationServer();
};
//---------------------------------------------------------------------------
extern TFormParamCommunicationServer*FormParamCommunicationServer;
//---------------------------------------------------------------------------
#endif
