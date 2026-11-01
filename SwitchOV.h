//---------------------------------------------------------------------------
#ifndef SwitchOVH
#define SwitchOVH
//---------------------------------------------------------------------------
#include <ActnList.hpp>
#include <Buttons.hpp>
#include <Classes.hpp>
#include <Controls.hpp>
#include <ExtCtrls.hpp>
#include <StdCtrls.hpp>
#include "DrawTable.h"
#include "Main.h"
#include <ImgList.hpp>
#include <Menus.hpp>
#include <ComCtrls.hpp>
#include "MemDS.hpp"
#include "VirtualTable.hpp"
#include <Db.hpp>
#include <DBGrids.hpp>
#include <Grids.hpp>
#include "DBGridEh.hpp"
#include <DB.hpp>
#include "DBAccess.hpp"
#include "Ora.hpp"
#include <DBCtrls.hpp>
#include <Mask.hpp>
#include <ToolWin.hpp>
#include <Dialogs.hpp>
//---------------------------------------------------------------------------
struct sOV_Switch
{
    long ID;
    long NSWITCH;
    char DSWITCH[20];
    char SwitchName[150];
    long q1234;
    double ERM;
    double EDM;
    double Q1M;
    double Q2M;
    double Q3M;
    double Q4M;
    long Mid;
    char PointName[150];
    char Denter_User[50];
    long NState;
    char VError[256];
};
class TFormSwitchOV : public TMainForm
{
__published:	// IDE-managed Components
   TBitBtn *bbAdd;
   TBitBtn *bbEdit;
   TBitBtn *bbDel;
   TBitBtn *bbCalc;
  TPageControl *PageControl1;
  TTabSheet *TabSheet1;
  TTabSheet *TabSheet2;
  TPanel *Panel3;
  TLabel *Label8;
  TLabel *Label1;
  TLabel *Label2;
  TLabel *Label3;
  TLabel *Label4;
  TLabel *Label5;
  TLabel *Label6;
  TLabel *Label7;
  TLabel *Label9;
  TLabel *Label10;
  TLabel *Label11;
  TLabel *Label15;
  TVirtualTable *JournalVTable;
  TStringField *JournalVTableSwitchName;
  TStringField *JournalVTablePointName;
  TStringField *JournalVTableSwBegin;
  TIntegerField *JournalVTableColor;
  TDataSource *StateOVDS;
  TDBGridEh *JournalGridEh;
  TIntegerField *JournalVTableID;
  TIntegerField *JournalVTablenSwitch;
  TIntegerField *JournalVTableMID;
  TOraQuery *oqStateOV;
  TOraDataSource *SwitchOVDS;
  TOraQuery *oqSwitchOV;
  TDBGridEh *SwitchOVGridEh;
  TDBText *DBText1;
  TDBText *DBText2;
  TDBText *DBText3;
  TDBText *DBText4;
  TDBText *DBText5;
  TDBText *DBText6;
  TPanel *Panel7;
  TLabel *Label16;
  TLabel *Label17;
  TDateTimePicker *dtFrom;
  TMaskEdit *edFrom;
  TDateTimePicker *dtTill;
  TMaskEdit *edTill;
  TLabel *Label18;
  TEdit *eObject;
  TSpeedButton *btnFilter;
  TOraStoredProc *SwInsertProc;
  TOraStoredProc *SwUpdateProc;
  TLabel *Label12;
  TLabel *Label13;
  TLabel *Label14;
  TLabel *Label19;
  TLabel *Label20;
  TLabel *Label21;
  TLabel *Label22;
  TDBText *DBText7;
  TDBText *DBText8;
  TDBText *DBText9;
  TDBText *DBText10;
  TDBText *DBText11;
  TDBText *DBText12;
  TOraStoredProc *SelectSwitch;
  TOraDataSource *SelectSwitchOV;
  TOraStoredProc *Del_proc;
  TOraQuery *oqGet_Date;
  TOraQuery *oqEIM;
  TStringField *oqStateOVSWITCHNAME;
  TStringField *oqStateOVPOINTNAME;
  TDateTimeField *oqStateOVSWDATE;
  TDateTimeField *oqStateOVSWBEGIN;
  TDateTimeField *oqStateOVSWEND;
  TFloatField *oqStateOVID;
  TFloatField *oqStateOVNSWITCH;
  TFloatField *oqStateOVMID;
  TFloatField *oqStateOVPMID;
  TStringField *oqStateOVPNAME;
  TFloatField *oqSwitchOVERME;
  TFloatField *oqSwitchOVEDME;
  TFloatField *oqSwitchOVQ1ME;
  TFloatField *oqSwitchOVQ2ME;
  TFloatField *oqSwitchOVQ3ME;
  TFloatField *oqSwitchOVQ4ME;
  TDateTimeField *oqSwitchOVDESCAPE;
  TDateTimeField *oqSwitchOVDSWITCH;
  TStringField *oqSwitchOVSWITCHNAME;
  TStringField *oqSwitchOVPOINTNAME;
  TDateTimeField *oqSwitchOVDATEENTER;
  TStringField *oqSwitchOVPERSON;
  TFloatField *oqSwitchOVID;
  TFloatField *oqSwitchOVNSWITCH;
  TFloatField *oqSwitchOVQ1234;
  TFloatField *oqSwitchOVERM;
  TFloatField *oqSwitchOVEDM;
  TFloatField *oqSwitchOVQ1M;
  TFloatField *oqSwitchOVQ2M;
  TFloatField *oqSwitchOVQ3M;
  TFloatField *oqSwitchOVQ4M;
  TFloatField *oqSwitchOVNMID;
  TFloatField *oqSwitchOVPMID;
  TDateTimeField *oqSwitchOVDENTERRET;
  TStringField *oqSwitchOVPERSONRET;
        TBitBtn *m_btnSave;
        TSaveDialog *SaveDialog1;
  void __fastcall JournalGridEhTitleBtnClick(TObject *Sender, int ACol,
          TColumnEh *Column);
  void __fastcall JournalGridEhDrawColumnCell(TObject *Sender,
          const TRect &Rect, int DataCol, TColumnEh *Column,
          TGridDrawState State);
  void __fastcall TabSheet1Resize(TObject *Sender);
  void __fastcall PageControl1Change(TObject *Sender);
  void __fastcall StateOVDSDataChange(TObject *Sender, TField *Field);
  void __fastcall SwitchOVGridEhTitleBtnClick(TObject *Sender, int ACol,
          TColumnEh *Column);
  void __fastcall oqSwitchOVAfterScroll(TDataSet *DataSet);
  void __fastcall SwitchOVGridEhKeyDown(TObject *Sender, WORD &Key,
          TShiftState Shift);
  void __fastcall JournalGridEhDblClick(TObject *Sender);
  void __fastcall btnFilterClick(TObject *Sender);
  void __fastcall eObjectKeyPress(TObject *Sender, char &Key);
  void __fastcall JournalGridEhKeyPress(TObject *Sender, char &Key);
  void __fastcall SwitchOVGridEhDrawColumnCell(TObject *Sender,
          const TRect &Rect, int DataCol, TColumnEh *Column,
          TGridDrawState State);
  void __fastcall oqSwitchOVDSWITCHGetText(TField *Sender,
          AnsiString &Text, bool DisplayText);
  void __fastcall oqSwitchOVDESCAPEGetText(TField *Sender,
          AnsiString &Text, bool DisplayText);
  void __fastcall oqStateOVAfterScroll(TDataSet *DataSet);
        void __fastcall m_btnSaveClick(TObject *Sender);
private:// User declarations
   void __fastcall SetAccess(TAccess value);
   AnsiString JournalOrderStr,SwitchOVOrderStr;
   int gid, FilterStr, Col_num;
   bool wr_rights;
public:		// User declarations
	void __fastcall Read_OV_Switch();
  void __fastcall Read_OV_Journal();
	__fastcall TFormSwitchOV(TComponent* Owner, AnsiString, TAccess = accDenied);
   void __fastcall AddEdit(bool = false);
   //28.11.2022 GRB ADD
   void __fastcall SaveTable(TComponent* Owner,TDBGridEh *gr,AnsiString RepCaption);
protected:
   void __fastcall vSave(TObject* Sender);
   void __fastcall vParams(TObject *Sender);
   void __fastcall vDelete(TObject *Sender);
   void __fastcall vNew(TObject *Sender);
   void __fastcall vRefresh(TObject* Sender);
};
//---------------------------------------------------------------------------
#endif
