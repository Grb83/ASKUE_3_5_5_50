//---------------------------------------------------------------------------

#ifndef ValidParamOldH
#define ValidParamOldH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <Graphics.hpp>
#include <ImgList.hpp>
#include <ActnList.hpp>
//---------------------------------------------------------------------------
class TfmValidityFormOld : public TForm
{
__published:	// IDE-managed Components
  TPanel *pnName;
  TPanel *Panel3;
  TPanel *Panel23;
  TPanel *Panel4;
  TPanel *Panel24;
  TPanel *Panel1;
  TPanel *QuatPanel11;
  TImage *QuatImage11;
  TPanel *QuatPanel10;
  TImage *QuatImage10;
  TPanel *QuatPanel9;
  TImage *QuatImage9;
  TPanel *QuatPanel8;
  TImage *QuatImage8;
  TPanel *QuatPanel7;
  TImage *QuatImage7;
  TPanel *QuatPanel6;
  TImage *QuatImage6;
  TPanel *QuatPanel5;
  TImage *QuatImage5;
  TPanel *QuatPanel4;
  TImage *QuatImage4;
  TPanel *QuatPanel3;
  TImage *QuatImage3;
  TPanel *QuatPanel2;
  TImage *QuatImage2;
  TPanel *QuatPanel1;
  TImage *QuatImage1;
  TPanel *Panel2;
  TPanel *PlusQualPanel9;
  TPanel *PlusQualPanel8;
  TPanel *PlusQualPanel7;
  TPanel *PlusQualPanel6;
  TPanel *PlusQualPanel5;
  TPanel *PlusQualPanel4;
  TPanel *PlusQualPanel3;
  TPanel *PlusQualPanel2;
  TPanel *PlusQualPanel1;
  TImageList *ImageList1;
  TImage *Image1;
  TImage *Image2;
  TImage *Image3;
  TImage *Image4;
  TImage *Image5;
  TImage *Image6;
  TImage *Image7;
  TImage *Image8;
  TImage *Image9;
  TShape *Shape1;
  TLabel *edValidity;
  TShape *Shape2;
  TLabel *edSourse;
  TActionList *ActionList1;
  TAction *Action1;
  TPanel *Panel5;
  TImage *QuatImage22;
  TPanel *Panel6;
  void __fastcall Action1Execute(TObject *Sender);
 
private:	// User declarations
void __fastcall ReadData(char isval[32]);
public:		// User declarations
  __fastcall TfmValidityFormOld(TComponent* Owner,char isvalid[32],AnsiString Name,AnsiString NameForm);

};
//---------------------------------------------------------------------------
extern PACKAGE TfmValidityFormOld *fmValidityFormOld;
//---------------------------------------------------------------------------
#endif
