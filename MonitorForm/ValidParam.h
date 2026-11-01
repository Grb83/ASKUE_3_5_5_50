//---------------------------------------------------------------------------

#ifndef ValidParamH
#define ValidParamH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <Graphics.hpp>
#include <ImgList.hpp>
#include <ActnList.hpp>
#include <Buttons.hpp>
#include <ComCtrls.hpp>
#include <ToolWin.hpp>
#include <jpeg.hpp>
//---------------------------------------------------------------------------
/*#define DEFAULT   0
#define NODATA    1
#define OK        2
#define ERROR     3  */
//---------------------------------------------------------------------------
class TfmValidityForm : public TForm
{
__published:	// IDE-managed Components
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
  TImageList *ImageList1;
  TActionList *ActionList1;
  TAction *Action1;
  TPageControl *pcProp;
  TTabSheet *tsReliability;
  TTabSheet *tsDataSource;
  TPanel *Panel7;
  TPanel *Panel8;
  TPanel *Panel9;
  TPanel *Panel10;
  TPanel *Panel11;
  TPanel *Panel12;
  TPanel *Panel13;
  TPanel *Panel14;
  TPanel *Panel15;
  TPanel *Panel16;
  TPanel *Panel17;
  TPanel *Panel18;
  TPanel *Panel19;
  TPanel *Panel20;
  TPanel *Panel21;
  TPanel *Panel22;
  TPanel *Panel25;
  TAction *acListShow;
  TPanel *Panel26;
  TPanel *Panel27;
  TPanel *Panel28;
  TPanel *Panel29;
  TTabSheet *tsValidity;
  TAction *acPanelPress;
  TImage *imError;
  TImage *imProcess;
  TImage *imNotReported;
  TLabel *Label1;
  TLabel *Label2;
  TLabel *Label3;
  TPanel *Panel30;
  TLabel *Label4;
  TLabel *Label5;
  TLabel *Label6;
  TLabel *Label7;
  TPanel *Panel31;
  TLabel *Label8;
  TPanel *Panel32;
  TPanel *Panel33;
  TToolBar *ToolBar1;
  TToolButton *tbUP;
  TToolBar *ToolBar2;
  TToolButton *tbDown;
  TImage *imOK;
  TImage *imQuest;
  TToolBar *ToolBar3;
  TToolButton *tb1;
  TToolBar *ToolBar4;
  TToolButton *tb2;
  TToolBar *ToolBar5;
  TToolButton *tb3;
  TToolBar *ToolBar6;
  TToolButton *tb4;
  TToolBar *ToolBar7;
  TToolButton *tb5;
  TToolBar *ToolBar8;
  TToolButton *tb6;
  TToolBar *ToolBar9;
  TToolButton *tb7;
  TToolBar *ToolBar10;
  TToolButton *tb8;
  TImage *imSubst;
  TImage *imReported;
  TLabel *Lbl1_1;
  TLabel *Lbl2_1;
  TLabel *Lbl2_2;
  TLabel *Lbl1_2;
  TLabel *Lbl3_1;
  TLabel *Lbl3_2;
  TLabel *Lbl4_1;
  TLabel *Lbl4_2;
  TLabel *Lbl5_1;
  TLabel *Lbl5_2;
  TLabel *Lbl6_1;
  TLabel *Lbl6_2;
  TLabel *Lbl6_3;
  TLabel *Lbl7_1;
  TLabel *Lbl7_2;
  TLabel *Lbl7_3;
  TLabel *Lbl7_4;
  TLabel *Lbl8_1;
  TLabel *Lbl8_2;
  TLabel *Lbl8_3;
  TLabel *Lbl8_4;
  TImage *imValidity;
  TImage *imSource;
  TImage *imReport;
  TImage *imReserved;
  TLabel *Lbl6_4;
  void __fastcall Action1Execute(TObject *Sender);
  void __fastcall FormCreate(TObject *Sender);
  void __fastcall acListShowExecute(TObject *Sender);
  void __fastcall acPanelPressExecute(TObject *Sender);
  void __fastcall tbUPClick(TObject *Sender);
  void __fastcall tbDownClick(TObject *Sender);

private:	// User declarations
void __fastcall ReadData(char isval[32]);
public:		// User declarations
  __fastcall TfmValidityForm(TComponent* Owner,char isvalid[32],AnsiString Name,AnsiString NameForm);

};
//---------------------------------------------------------------------------
extern PACKAGE TfmValidityForm *fmValidityForm;
//---------------------------------------------------------------------------
#endif
