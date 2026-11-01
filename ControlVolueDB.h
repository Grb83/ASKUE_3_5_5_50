//---------------------------------------------------------------------------
#ifndef ControlVolueDBH
#define ControlVolueDBH
//---------------------------------------------------------------------------
#include <ActnList.hpp>
#include <Buttons.hpp>
#include <Classes.hpp>
#include <Controls.hpp>
#include <ExtCtrls.hpp>
#include <Grids.hpp>
#include <StdCtrls.hpp>
#include "Main.h"
#include <ImgList.hpp>
#include <Menus.hpp>
#include "DBGridEh.hpp"
#include "VirtualTable.hpp"
#include "MemDS.hpp"
#include <Db.hpp>
#include <DB.hpp>
#include <Dialogs.hpp>
//---------------------------------------------------------------------------
class TFormControlVolueDB : public TMainForm
{
__published:	// IDE-managed Components
  TVirtualTable *VirtualTable1;
  TDBGridEh *DBGridEh1;
  TStringField *VirtualTable1Data;
  TIntegerField *VirtualTable1StoragePeriod;
  TIntegerField *VirtualTable1Arc;
  TStringField *VirtualTable1Extention;
  TBooleanField *VirtualTable1Modified;
  TDataSource *DataSource1;
  TStringField *VirtualTable1Table;
        TBitBtn *BitBtn1;
        TSaveDialog *aSaveDialog;
	void __fastcall FormCreate(TObject *Sender);
  void __fastcall VirtualTable1FieldChange(TField *Sender);
  void __fastcall DBGridEh1ColEnter(TObject *Sender);
  void __fastcall VirtualTable1AfterInsert(TDataSet *DataSet);
        void __fastcall BitBtn1Click(TObject *Sender);
private:	// User declarations
   typedef struct db_term{
      char data_name[100];
      char table_name[50];
      int term;
      int Archived;
      char Extension[30];
      int pEdit;
   }DB_TERM;
   unsigned long TreeCount;
   int TreeDecr[4];
   int Cheng;
   void __fastcall SetAccess(TAccess value);
   void __fastcall ChangeArchived(int, int);
public:		// User declarations
	__fastcall TFormControlVolueDB(TComponent* Owner, AnsiString, TAccess = accDenied);
   bool  TreeRead();
   bool  TreeWrite();
   int predCol;
   int predRow;
protected:
	void __fastcall vSave(TObject *Sender);
	void __fastcall vRefresh(TObject *Sender);
        //23.12.2022 - GRB ADD
        void __fastcall SaveTableToFile(TComponent* Owner,TDBGridEh *gr,AnsiString RepCaption);
};
//---------------------------------------------------------------------------
#endif
