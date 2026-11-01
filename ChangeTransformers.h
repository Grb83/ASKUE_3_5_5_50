//---------------------------------------------------------------------------

#ifndef ChangeTransformersH
#define ChangeTransformersH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ComCtrls.hpp>
#include <Buttons.hpp>
#include <ExtCtrls.hpp>
#include <Mask.hpp>
#include <Dialogs.hpp>
//---------------------------------------------------------------------------
class TChangeTransformersFormPriv;
class TCustomTransformerLine;
//---------------------------------------------------------------------------
class TChangeTransformersForm : public TForm
{
__published:	// IDE-managed Components
    TPanel *plTitle;
    TLabel *lName;
    TLabel *lData;
  TDateTimePicker *DataTPicker;
  TEdit *NameEdit;
    TPanel *plBottom;
  TBitBtn *CancelBtn;
  TBitBtn *OKBtn;
    TPanel *plTime;
  TMaskEdit *GetTimeMEdit;
  TMaskEdit *SetTimeMEdit;
    TPanel *plVal2;
  TEdit *SetVal2Edit;
  TEdit *GetVal2Edit;
    TPanel *plVal1;
  TEdit *GetVal1Edit;
  TEdit *SetVal1Edit;
    TPanel *plType;
    TPanel *plNames;
    TPanel *plName;
    TPanel *plGetName;
    TPanel *plSetName;
  TEdit *GetTypeEdit;
  TEdit *SetTypeEdit;
        TBitBtn *m_btnSave;
        TSaveDialog *aSaveDialog;
    void __fastcall onChange(TObject *Sender);
    void __fastcall OKBtnClick(TObject *Sender);
                  //GRB ADD 26.11.2022
    void __fastcall m_btnSaveClick(TObject *Sender);
private: // User declarations
    //TTransformersForm::TRANSFMS pt;
    //TCustomTransformer  *dTrans;
    TChangeTransformersFormPriv *d;
public:		// User declarations
    //__fastcall TChangeTransformersForm(TComponent* Owner, TStrings*types,
    //    const TTransformersForm::TRANSFMS &);
    __fastcall TChangeTransformersForm(TComponent* Owner, TCustomTransformerLine *);
    __fastcall ~TChangeTransformersForm();
          //GRB ADD 03.11.2022
  void __fastcall SaveTableToFile(TObject *Sender);
protected:
};
//---------------------------------------------------------------------------
extern PACKAGE TChangeTransformersForm *ChangeTransformersForm;
//---------------------------------------------------------------------------
#endif
