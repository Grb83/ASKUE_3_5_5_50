//---------------------------------------------------------------------------
#ifndef CountParamH
#define CountParamH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <Buttons.hpp>
#include <Mask.hpp>
#include <ComCtrls.hpp>
#include "DBAccess.hpp"
#include "MemDS.hpp"
#include "Ora.hpp"
#include <DB.hpp>
#include "OraSmart.hpp"
//---------------------------------------------------------------------------
extern double meterDemIndic[30], meterNewIndic[60];

typedef struct {
  int Mid;
  int Enertype;
  char DataChange[12];
  double Kc;
}TYPECOUNT;

typedef struct {
  char Name[150];
  char SOURCE[50];	//VARCHAR2(50),
  char REMARK[128];	//VARCHAR2(200),
  char ER_MTRSN[20];	//VARCHAR2(20),
  double ER_KC;		//NUMBER,
  double ERM;		//NUMBER,
  double ER;		//NUMBER,
  double AERM;		//NUMBER,
  double AER;		//NUMBER,
  double BERM;		//NUMBER,
  double BER;		//NUMBER,
  double CERM;		//NUMBER,
  double CER;		//NUMBER,
  double DERM;		//NUMBER,
  double DER;		//NUMBER,
  char Q1_MTRSN[20];	//VARCHAR2(20),
  double Q1_KC;		//NUMBER,
  double Q1M;		//NUMBER,
  double Q1;		//NUMBER,
  double AQ1M;		//NUMBER,
  double AQ1;		//NUMBER,
  double BQ1M;		//NUMBER,
  double BQ1;		//NUMBER,
  double CQ1M;		//NUMBER,
  double CQ1;		//NUMBER,
  double DQ1M;		//NUMBER,
  double DQ1;		//NUMBER,
  char ED_MTRSN[20];	//VARCHAR2(20),
  double ED_KC;		//NUMBER,
  double EDM;		//NUMBER,
  double ED;		//NUMBER,
  double AEDM;		//NUMBER,
  double AED;		//NUMBER,
  double BEDM;		//NUMBER,
  double BED;		//NUMBER,
  double CEDM;		//NUMBER,
  double CED;		//NUMBER,
  double DEDM;		//NUMBER,
  double DED;		//NUMBER,
  char Q3_MTRSN[20];	//VARCHAR2(20),
  double Q3_KC;		//NUMBER,
  double Q3M;		//NUMBER,
  double Q3;		//NUMBER,
  double AQ3M;		//NUMBER,
  double AQ3;		//NUMBER,
  double BQ3M;		//NUMBER,
  double BQ3;		//NUMBER,
  double CQ3M;		//NUMBER,
  double CQ3;		//NUMBER,
  double DQ3M;		//NUMBER,
  double DQ3;		//NUMBER,
  char Q2_MTRSN[20];	//VARCHAR2(20),
  double Q2_KC;		//NUMBER,
  double Q2M;		//NUMBER,
  double Q2;		//NUMBER,
  double AQ2M;		//NUMBER,
  double AQ2;		//NUMBER,
  double BQ2M;		//NUMBER,
  double BQ2;		//NUMBER,
  double CQ2M;		//NUMBER,
  double CQ2;		//NUMBER,
  double DQ2M;		//NUMBER,
  double DQ2;		//NUMBER,
  char Q4_MTRSN[20];	//VARCHAR2(20),
  double Q4_KC;		//NUMBER,
  double Q4M;		//NUMBER,
  double Q4;		//NUMBER,
  double AQ4M;		//NUMBER,
  double AQ4;		//NUMBER,
  double BQ4M;		//NUMBER,
  double BQ4;		//NUMBER,
  double CQ4M;		//NUMBER,
  double CQ4;		//NUMBER,
  double DQ4M;		//NUMBER,
  double DQ4;		//NUMBER
} TBIIL;



class TFormCountParam : public TForm
{
__published:	// IDE-managed Components
	TPanel *Panel1;
	TPanel *Panel2;
	TPanel *Panel3;
	TEdit *Edit1;
	TPanel *Panel4;
	TPanel *Panel7;
	TPanel *Panel10;
	TBitBtn *BitBtn2;
	TPanel *Panel5;
	TPanel *Panel6;
	TPanel *Panel8;
	TPanel *Panel9;
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
	TBitBtn *BitBtn3;
	TEdit *Edit3;
	TEdit *Edit13;
	TEdit *Edit4;
	TEdit *Edit5;
	TEdit *Edit6;
	TEdit *Edit7;
	TEdit *Edit8;
	TEdit *Edit9;
	TEdit *Edit10;
	TEdit *Edit11;
	TMaskEdit *Edit12;
	TEdit *Edit14;
	TEdit *Edit15;
	TEdit *Edit16;
	TEdit *Edit17;
	TEdit *Edit18;
	TEdit *Edit19;
	TEdit *Edit20;
	TEdit *Edit21;
	TMaskEdit *Edit22;
	TPanel *Panel21;
	TEdit *Edit25;
	TPanel *Panel22;
	TEdit *Edit23;
	TEdit *Edit24;
	TBitBtn *BitBtn1;
     TDateTimePicker *DateTimePicker1;
  TPanel *Panel23;
  TEdit *Edit2;
  TOraQuery *oqTreeWriteNew;
  TSmartQuery *oqSelect;
  TSmartQuery *oqBorder;
  TStringField *oqBorderDTMIN;
  TStringField *oqBorderDTMAX;
  TFloatField *oqSelectID;
  TStringField *oqSelectNAME;
  TStringField *oqSelectSMART;
  TStringField *oqSelectMTRSN;
  TFloatField *oqSelectDIGITS;
  TStringField *oqSelectMTYPE;
  TFloatField *oqSelectMCURRENT;
  TFloatField *oqSelectMPOWER;
  TFloatField *oqSelectMCONST;
  TFloatField *oqSelectMCLASS;
  TFloatField *oqSelectMYEAR;
  TFloatField *oqSelectMQUARTER;
  TOraQuery *oqMeterDemIndic;
	void __fastcall FormCreate(TObject *Sender);
	void __fastcall BitBtn3Click(TObject *Sender);
	void __fastcall BitBtn1Click(TObject *Sender);
	void __fastcall BitBtn2Click(TObject *Sender);
	void __fastcall ChangeInt(TObject *Sender);
	void __fastcall ChangeDouble(TObject *Sender);
	
	void __fastcall Edit13Exit(TObject *Sender);
  void __fastcall FormShow(TObject *Sender);
        void __fastcall Edit12Change(TObject *Sender);
private:	// User declarations

typedef struct smater{
   int Id;
   char Name[148];
   char DATE_TIME[20];
   char SMART[4];	//VARCHAR2(1), признак интел. счетчика
   char MTRSN[20];		//
   char DIGITS[20]; //рарядность
   char MTYPE[50];
   int MCURRENT;
   int MPOWER;
   int MCONST;
   double MCLASS;
   int MYEAR;
   int MQUARTER;
   char VMEMO[256];	//VARCHAR2(256),
   int pEdit;
}MATER;

 MATER TreeTable[1];
   TYPECOUNT* TypeCount;
   TBIIL tBill[4];
   bool Insert_0(TObject *Sender);
   bool ProvMask(AnsiString Str);
   int GetMaskDigits(int db,AnsiString Digits);
public:		// User declarations
   __fastcall TFormCountParam(TComponent* Owner,TYPECOUNT* zTypeCount,TDateTime dt);
   bool  TreeWriteNew();
   bool first;
   int TaskId;
};
//---------------------------------------------------------------------------
extern TFormCountParam *FormCountParam;
//---------------------------------------------------------------------------
#endif
