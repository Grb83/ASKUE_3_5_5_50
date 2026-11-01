//---------------------------------------------------------------------------

#ifndef DeportProcRunH
#define DeportProcRunH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Buttons.hpp>
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <Mask.hpp>
#include "DeportProcs.h"
//---------------------------------------------------------------------------
class TfmDeportProcRun : public TForm
{
__published:	// IDE-managed Components
   TPanel *Panel3;
   TPanel *Panel2;
   TLabel *Label1;
   TLabel *Label2;
   TEdit *EdParam;
   TMaskEdit *MEdTime;
   TDateTimePicker *DTPPar;
   TPanel *Panel1;
   TBitBtn *BitBtn1;
   TBitBtn *BitBtn2;
  TPanel *Panel4;
  TLabel *Label3;
  TDateTimePicker *dtStart;
  TDateTimePicker *dtFinish;
  TLabel *Label4;
  TPanel *Panel5;
  void __fastcall BitBtn1Click(TObject *Sender);
  void __fastcall BitBtn2Click(TObject *Sender);
  void __fastcall FormCreate(TObject *Sender);
  void __fastcall NewBtOKClick(TObject *Sender);
  void __fastcall StFinBtOKClick(TObject *Sender);
private:	// User declarations
public:		// User declarations
  __fastcall TfmDeportProcRun(TComponent* Owner);
  bool __fastcall CheckHBound();
  bool IsHour;
  stDeportProc CurrDeportProc;
  bool __fastcall DataInit( int PPNProc,int isMaket );
};
void DeportProcedureRun( int PPNProc,TComponent* Owner ,int isMaket=0 );
bool ShowDateDialog(TDateTime &dt,TComponent* Owner );
bool ShowDateStartFinishDialog(TDateTime &dt1,TDateTime &dt2, AnsiString vname,TComponent* Owner );
//---------------------------------------------------------------------------
extern PACKAGE TfmDeportProcRun *fmDeportProcRun;
//---------------------------------------------------------------------------
#endif
