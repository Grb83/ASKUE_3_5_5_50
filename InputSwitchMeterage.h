//---------------------------------------------------------------------------
#ifndef InputSwitchMeterageH
#define InputSwitchMeterageH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Buttons.hpp>
#include <ExtCtrls.hpp>
#include <Mask.hpp>
#include "Ora.hpp"
//---------------------------------------------------------------------------
class TfmInputMeterage : public TForm
{
__published:	// IDE-managed Components
        TPanel *Panel1;
        TPanel *Panel2;
        TPanel *Panel3;
        TBitBtn *bbOK;
        TBitBtn *bbCancel;
        TPanel *Panel4;
        TLabel *Label3;
        TLabel *Label4;
        TLabel *lTime1;
        TLabel *lTime2;
  TGroupBox *StartGroupBox;
  TLabel *Label5;
  TMaskEdit *meERM;
  TMaskEdit *meCalcERM1;
  TMaskEdit *meCalcERM2;
  TLabel *Label6;
  TMaskEdit *meEDM;
  TMaskEdit *meCalcEDM1;
  TMaskEdit *meCalcEDM2;
  TLabel *Label7;
  TMaskEdit *meQ1M;
  TMaskEdit *meCalcQ1M1;
  TMaskEdit *meCalcQ1M2;
  TLabel *Label8;
  TMaskEdit *meQ2M;
  TMaskEdit *meCalcQ2M1;
  TMaskEdit *meCalcQ2M2;
  TLabel *Label9;
  TMaskEdit *meQ3M;
  TMaskEdit *meCalcQ3M1;
  TMaskEdit *meCalcQ3M2;
  TLabel *Label10;
  TMaskEdit *meQ4M;
  TMaskEdit *meCalcQ4M1;
  TMaskEdit *meCalcQ4M2;
  TGroupBox *FinishGroupBox;
  TLabel *Label1;
  TLabel *Label2;
  TLabel *Label11;
  TLabel *Label12;
  TLabel *Label13;
  TLabel *labelQ4;
  TMaskEdit *meERMLast;
  TMaskEdit *meCalcERM1Last;
  TMaskEdit *meCalcERM2Last;
  TMaskEdit *meEDMLast;
  TMaskEdit *meEDMCalc1Last;
  TMaskEdit *meEDMCalc2Last;
  TMaskEdit *meQ1Last;
  TMaskEdit *meQ1CalcLast2;
  TMaskEdit *meQ1CalcLast1;
  TMaskEdit *meQ2Last;
  TMaskEdit *meQ2LastCalc1;
  TMaskEdit *meQ2LastCalc2;
  TMaskEdit *meQ3Last;
  TMaskEdit *meQ3mLastCalc1;
  TMaskEdit *meQ3mLastCalc2;
  TMaskEdit *meQ4Last;
  TMaskEdit *meQ4LastCalc1;
  TMaskEdit *meQ4LastCalc2;
  TPanel *Q4Panel;
  TPanel *Q2Panel;
  TPanel *PgenPanel;
  TPanel *Q4FinishPanel;
  TPanel *PgenFinishPanel;
  TPanel *Q2FinishPanel;
  TLabel *LastTime1;
  TLabel *LastTime2;
        void __fastcall EditKeyPress(TObject *Sender,
             char &Key);
        void __fastcall EditChange(TObject *Sender);
        void __fastcall bbOKClick(TObject *Sender);
private:	// User declarations
        bool __fastcall LimitControl(TMaskEdit* me);
        bool __fastcall WarningControl(TMaskEdit* me);
  TOraQuery *oqPointLimits; 
public:		// User declarations
        __fastcall TfmInputMeterage(TComponent* Owner);
        void __fastcall getPointLimits(TOraQuery* pOraQuery);
};
//---------------------------------------------------------------------------
extern PACKAGE TfmInputMeterage *fmInputMeterage;
//---------------------------------------------------------------------------
#endif
