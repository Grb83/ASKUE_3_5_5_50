//---------------------------------------------------------------------------

#ifndef DuplicateCnt_ps_tuH
#define DuplicateCnt_ps_tuH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Buttons.hpp>
#include <Mask.hpp>
#include <ExtCtrls.hpp>
#include <ComCtrls.hpp>

#include "DuplicateCnt_InputParams.h"
//---------------------------------------------------------------------------
class TfmDuplicateCnt_PS_TU : public TForm
{
__published:	// IDE-managed Components
        TPanel *Panel1;
        TBitBtn *bbOK;
        TBitBtn *bbCancel;
        TPanel *Panel2;               
        TLabel *Label1;
        TEdit *edTU;
        TBitBtn *bbTree;
        TLabel *Label2;
        TLabel *Label3;
        TMemo *mmComment;
        TLabel *Label4;
        TDateTimePicker *dtpFrom;
        TDateTimePicker *dtpTo;
  TCheckBox *chbDateTo;
        void __fastcall bbTreeClick(TObject *Sender);
        void __fastcall bbOKClick(TObject *Sender);
  void __fastcall chbDateToClick(TObject *Sender);
private:	// User declarations
public:		// User declarations
        //long m_mid;//mid of point that name displayed in PS_TU edit
        //tree displayed from this point
        //char m_name[150];//name of root point

        POINTSTREEDEF RootPoint;//replace m_mid and m_name; 
//        __fastcall TfmDuplicateCnt_PS_TU(TComponent* Owner, long mid);
        __fastcall TfmDuplicateCnt_PS_TU(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfmDuplicateCnt_PS_TU *fmDuplicateCnt_PS_TU;
//---------------------------------------------------------------------------
#endif
