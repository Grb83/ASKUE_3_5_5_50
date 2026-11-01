//---------------------------------------------------------------------------
#ifndef SetupMonitorsH
#define SetupMonitorsH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <ComCtrls.hpp>
#include <Buttons.hpp>
#include <Grids.hpp>
#include <Dialogs.hpp>
#include "DrawTable.h"
#include <Chart.hpp>
#include <Series.hpp>
#include <TeEngine.hpp>
#include <TeeProcs.hpp>
#include <TeeFunci.hpp>
//---------------------------------------------------------------------------
class TFormSetupMonitors : public TForm
{
__published:	// IDE-managed Components
	TPanel *Panel1;
	TPageControl *PageControl1;
	TTabSheet *TabSheet1;
	TPanel *Panel3;
	TBitBtn *BitBtn1;
	TBitBtn *BitBtn2;
	TPanel *Panel2;
	TPanel *PanelColorTable;
	TPanel *PanelBWTable;
	TDrawTable *DrawTableColor;
	TDrawTable *DrawTableBW;
	TLabel *Label1;
	TLabel *LabelColorFont;
	TLabel *LabelBWFont;
	TButton *ButtonColorFont;
	TButton *ButtonBWFont;
	TLabel *Label2;
	TEdit *EditColorHeight;
	TEdit *EditBWHeight;
	TUpDown *UpDownColorHeight;
	TUpDown *UpDownBWHeight;
	TLabel *Label3;
	TEdit *EditColorWidthDigit;
	TEdit *EditBWWidthDigit;
	TUpDown *UpDownColorWidthDigit;
	TUpDown *UpDownBWWidthDigit;
	TLabel *Label4;
	TEdit *EditColorWidthName;
	TEdit *EditBWWidthName;
	TUpDown *UpDownColorWidthName;
	TUpDown *UpDownBWWidthName;
	TTabSheet *TabSheet2;
	TFontDialog *FontDialog;
   TRadioGroup *RadioGroupProfilePower;
   TTabSheet *TShPLSQLRep;
   TPanel *Panel4;
   TRichEdit *REdPLSQLRep;
   TPanel *Panel5;
   TLabel *Label5;
   TLabel *PLSQLRepFont;
   TButton *Button1;
   TRadioGroup *RGrPrintMode;
        TTabSheet *TabSheet3;
        TCheckBox *CheckBox1;
        TCheckBox *CheckBox2;
        TEdit *Edit1;
        TLabel *Label6;
        TLabel *Label7;
        TEdit *Edit2;
        TLabel *Label8;
        TEdit *Edit3;
        TTimer *Timer1;
   TTabSheet *tsGraph;
   TChart *Chart;
   TPanel *plGraphParam;
   TCheckBox *cbPoints;
   TCheckBox *cbMarks;
   TCheckBox *cbDiagram;
   TRadioGroup *rgDiagramType;
   TPieSeries *Series1;
        TRadioGroup *ChecAddFoBalanse;
  TRadioGroup *RadioGroupPowerCoeff;
  TCheckBox *CheckBox3;
  TGroupBox *GroupBox1;
  TLabel *Label9;
  TComboBox *cbFormatPnt;
  TCheckBox *cbSpecFormat;
  TRadioGroup *RadioGroupShowValidity;
        TRadioGroup *RadioGroupColWidthName;
	void __fastcall ButtonColorFontClick(TObject *Sender);
	void __fastcall EditColorHeightChange(TObject *Sender);
	void __fastcall ButtonBWFontClick(TObject *Sender);
	void __fastcall EditBWHeightChange(TObject *Sender);

	void __fastcall BitBtn1Click(TObject *Sender);
	void __fastcall FormShow(TObject *Sender);
   void __fastcall RadioGroupProfilePowerClick(TObject *Sender);
   void __fastcall Button1Click(TObject *Sender);
   void __fastcall lShowManualClick(TObject *Sender);
   void __fastcall Timer1Timer(TObject *Sender);
   void __fastcall cbPointsClick(TObject *Sender);
   void __fastcall cbMarksClick(TObject *Sender);
   void __fastcall OnViewUpdate(TObject *Sender);
   void __fastcall ChecAddFoBalanseClick(TObject *Sender);
  void __fastcall RadioGroupPowerCoeffClick(TObject *Sender);
  void __fastcall RadioGroupShowValidityClick(TObject *Sender);
  
private:	// User declarations
   bool FCommDataWarningSound, FTechDataWarningSound, FServiceWarningSound;
   long FFrequency, FDuration, FPause, FCommBeep, FTechBeep, FServBeep;
   TLineSeries* pLine;
   TBarSeries* pBar;
   TPieSeries* pPie;
   //14.09.2021 GRB ADD - флаг использования режима отрисовки колонки с именем группы по ширине самого длинного элемента
   bool isContainedWidth;

public:		// User declarations
   int kindOfADddBalanceDiag;//Вид отображаемого дополнительного графика на форме баланса
 
   TDrawTable::SAttrCell::TDataSource dsMan;
   TDrawTable::SAttrCell::TDataSource dsClear;
   TDrawTable::SAttrCell::TDataSource dsOvCh;
   TDrawTable::SAttrCell::TDataSource dsAll;
   TDrawTable::SAttrCell::TDataSource dsElectr;
   void __fastcall MinitoringPlaySoundWarning(long aDataControlType);
   void __fastcall MinitoringStopSoundWarning();
   __fastcall TFormSetupMonitors(TComponent* Owner);
	 void __fastcall InitRegistry(void);

};
//---------------------------------------------------------------------------
extern TFormSetupMonitors *FormSetupMonitors;
//---------------------------------------------------------------------------
#endif

