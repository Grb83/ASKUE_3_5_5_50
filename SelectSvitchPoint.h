//---------------------------------------------------------------------------
#ifndef SelectSvitchPointH
#define SelectSvitchPointH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <ComCtrls.hpp>
#include <Buttons.hpp>
#include <Mask.hpp>
#include <Graphics.hpp>
#include "InputSwitchMeterage.h"
#include "DBAccess.hpp"
#include "MemDS.hpp"
#include "Ora.hpp"
#include "OraSmart.hpp"
#include <DB.hpp>
//---------------------------------------------------------------------------

class TFormSelectSvitchPoint : public TForm
{

__published:	// IDE-managed Components
	TPanel *Panel14;
        TBitBtn *bbOK;
        TBitBtn *bbCancel;
        TPanel *Panel1;
        TMaskEdit *meDateSwitch;
        TLabel *Label1;
        TComboBox *cbOV;
        TLabel *Label2;
        TLabel *Label4;
        TComboBox *cbPoints;
        TImage *Image1;
        TBitBtn *bbInputMeterage;
  TMaskEdit *meDateSwitchOff;
  TLabel *Label3;
  TSpeedButton *sbFind;
  TSmartQuery *FillSwitchQuery;
  TSmartQuery *FillPointQuery;
  TOraStoredProc *HourParProc;
  TFloatField *FillSwitchQueryMID;
  TStringField *FillSwitchQueryVNAME;
  TSmartQuery *SetMask;
  TOraQuery *oqPointLimits;
  TOraStoredProc *opCheckSwitch;
        void __fastcall cbOVChange(TObject *Sender);
        void __fastcall bbOKClick(TObject *Sender);
        void __fastcall bbInputMeterageClick(TObject *Sender);
        void __fastcall meDateSwitchChange(TObject *Sender);
  void __fastcall sbFindClick(TObject *Sender);
public:		// User declarations
        TfmInputMeterage *InputMet;
	__fastcall TFormSelectSvitchPoint(TComponent* Owner);
        virtual __fastcall ~TFormSelectSvitchPoint();
	void __fastcall LoadCombo(TComboBox* ptrCombo);
	void __fastcall SetMasks(TMaskEdit* me1, TMaskEdit* me2, TMaskEdit* me3, TMaskEdit* me4, TMaskEdit* me5, TMaskEdit* me6, long PiontID);
        bool __fastcall InputControl();
        bool __fastcall DataControl();
  void SetPointByMID(int MID);        
};
//---------------------------------------------------------------------------
extern TFormSelectSvitchPoint *FormSelectSvitchPoint;
//---------------------------------------------------------------------------
#endif
