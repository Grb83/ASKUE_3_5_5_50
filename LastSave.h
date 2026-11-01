//---------------------------------------------------------------------------

#ifndef LastSaveH
#define LastSaveH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Buttons.hpp>
#include <ExtCtrls.hpp>
#include <ComCtrls.hpp>
#include <ImgList.hpp>
#include <Graphics.hpp>
#include "Main.h"
#include <ActnList.hpp>
#include <Menus.hpp>
#include <Mask.hpp>
#include "DBAccess.hpp"
#include "MemDS.hpp"
#include "Ora.hpp"
#include <DB.hpp>
//---------------------------------------------------------------------------
class TLastSaveForm : public TMainForm
{
__published:	// IDE-managed Components
   TGroupBox *gbState;
   TLabel *lStateChange;
   TEdit *eDateState;
   TLabel *lStateDescr;
   TMemo *mDescrState;
   TLabel *lStateCod;
   TEdit *eTypeState;
   TImageList *imList;
   TPanel *plEdit;
   TImage *iState;
  TBitBtn *btnReceipt;
  TOraQuery *oqLastSave;
  TPanel *plChann;
  TLabel *cbLuckAre;
  TLabel *cbTrialAre;
  TMaskEdit *eLuck;
  TMaskEdit *eTrial;
  TGroupBox *gbPoints;
  TLabel *cbProfileAre;
  TLabel *cbHalfhourAre;
  TLabel *cbMonthAre;
  TLabel *cbBillAre;
  TMaskEdit *eProfile;
  TMaskEdit *eHalfhour;
  TMaskEdit *eBill;
  TMaskEdit *eMonth;
  TLabel *lClock;
  TEdit *eClock;
  TPanel *Panel1;
  TGroupBox *gbOFF;
  TLabel *lbCapState;
  TLabel *lbStateOFF;
  TLabel *lbCMDState;
  TLabel *lbCMD;
   void __fastcall FormCreate(TObject *Sender);
   void __fastcall eDateChange(TObject *Sender);
private:	// User declarations
   struct LASTSAVE{
      char profile[50], halfhour[50], bill[50], month[50];
      long clock;
      char state_date[50];
      long state_cod;
      char state_descr[200];
      char luck[50], trial[50];
   };
   long Mid;
   int chig;
   void __fastcall loadDate();
   void __fastcall SaveChanged(void);
   AnsiString __fastcall TrimAll(AnsiString );
   long accOFF;
public:		// User declarations
   __fastcall TLastSaveForm(TComponent* Owner, AnsiString Name, long mid, TAccess a=accDenied);
protected:
   void __fastcall vSave(TObject *Sender);
   void __fastcall vRefresh(TObject *Sender);
   void __fastcall vReceipt(TObject *Sender);
};
//---------------------------------------------------------------------------
extern PACKAGE TLastSaveForm *LastSaveForm;
//---------------------------------------------------------------------------
#endif

