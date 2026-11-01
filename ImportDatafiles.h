//---------------------------------------------------------------------------
#ifndef ImportDatafilesH
#define ImportDatafilesH
//---------------------------------------------------------------------------
#include "Main.h"
#include "unDataMod.h"
#include <ActnList.hpp>
#include <Buttons.hpp>
#include <Classes.hpp>
#include <ComCtrls.hpp>
#include <Controls.hpp>
#include <Dialogs.hpp>
#include <ExtCtrls.hpp>
#include <ImgList.hpp>
#include <Menus.hpp>
#include <StdCtrls.hpp>
#include "DBAccess.hpp"
#include "MemDS.hpp"
#include "Ora.hpp"
#include <DB.hpp>
//---------------------------------------------------------------------------
#define VARCHAR2LEN 1000
#define VARCHAR4LEN 4000
//---------------------------------------------------------------------------
enum TType{tNone=0,tLGFiles,tSchlumFiles,tAlphaFiles,tMaketNEK,tLGDatagyr,tElvin,tMercury,tCimRdf};
// Параметры формата Excel файлов с данныим счётчиков SL7000
struct TSL7000Params
{ /* Конфигурационные параметры */
  AnsiString  TitlesWorksheet;
  //AnsiString posActivePlus, ActivePlus;
  //AnsiString posActiveMinus, ActiveMinus;
  //AnsiString posReactivePlus, ReactivePlus;
  //AnsiString posReactiveMinus, ReactiveMinus;

  AnsiString  posActivePlusRow, posActivePlusCol, ActivePlus;
  AnsiString  posActiveMinusRow, posActiveMinusCol, ActiveMinus;
  AnsiString  posReactivePlusRow, posReactivePlusCol, ReactivePlus;
  AnsiString  posReactiveMinusRow, posReactiveMinusCol, ReactiveMinus;

  AnsiString  DataWorksheetTemplate;
  AnsiString  NLS_LANGUAGE;
  AnsiString  TimeStep;

  int usevth;
  TSL7000Params();
};
//---------------------------------------------------------------------------
// Структура для хранение данных за сутки
struct TDates{
   AnsiString dayDate;
   Variant dayDates;
};
//---------------------------------------------------------------------------
class TImportDatafilesFormPriv;
//---------------------------------------------------------------------------
class TImportDatafilesForm : public TMainForm
{
__published:	// IDE-managed Components
   TGroupBox *gbParameters;
   TGroupBox *gbFiles;
   TListView *lvFiles;
   TOpenDialog *OpenDialog;
   TPanel *Panel2;
   TBitBtn *btAdd;
   TBitBtn *btDel;
   TBitBtn *btDelAll;
   TBitBtn *btRebind;
   TPanel *plFileType;
   TLabel *Label3;
   TComboBox *cbFileType;
   TPanel *plErrorCheck;
   TCheckBox *cbIgnoreError;
   TPanel *plResult;
   TPanel *plSLParams;
   TLabel *lDataFormat;
   TLabel *lTitlesWorksheet;
   TEdit *eDataFmt;
   TEdit *eTitlesWorksheet;
   TPanel *plStep;
   TLabel *Label2;
   TComboBox *cbInterval;
   TPanel *Panel1;
   TMemo *mResult;
   TLabel *Label1;
   TComboBox *cbLangSel;
   TLabel *lLangSel;
  TCheckBox *cbVT;
  TOraQuery *oqGetPoint;
  TOraQuery *oqLoadSLFile;
  TOraQuery *oqLoadFile;
  TOraQuery *oqLoadMaketNEKFile;
  TOraQuery *oqLoadAsBlob;
   void __fastcall lvFilesChange(TObject *Sender, TListItem *Item,
          TItemChange Change);
   void __fastcall lvFilesChanging(TObject *Sender, TListItem *Item,
          TItemChange Change, bool &AllowChange);
   void __fastcall cbIntervalChange(TObject *Sender);
   void __fastcall FormShow(TObject *Sender);
   void __fastcall cbFileTypeChange(TObject *Sender);
   void __fastcall lvFilesDeletion(TObject *Sender, TListItem *Item);
   void __fastcall eDataFmtChange(TObject *Sender);
   void __fastcall eTitlesWorksheetChange(TObject *Sender);
   void __fastcall cbLangSelChange(TObject *Sender);
   void __fastcall cbLangSelDropDown(TObject *Sender);
  void __fastcall cbVTClick(TObject *Sender);
private:
   typedef char tline[VARCHAR2LEN];
   typedef char tline4[VARCHAR4LEN];
   struct PARAMS{
      long mid;
      int interval;
      char comm[VARCHAR2LEN];
      PARAMS():mid(0),interval(0){comm[0]=0;}
      // служ. поля
      bool sel;
      bool foc;
   };
   //TExcelApplication *pXlsAppl;
   //TExcelWorkbook  *pXlsWkbk;
   //TExcelWorksheet *pXlsWksh;

   TImportDatafilesFormPriv *d;
public:		// User declarations
   __fastcall TImportDatafilesForm(TComponent* Owner,AnsiString ,TType,TAccess);
protected:
   __property TType Type  = { read=GetType, write=SetType };
   TType __fastcall GetType();
   void __fastcall SetType(TType value);
   TType FType;
   void __fastcall SetAccess(TAccess value);

   void __fastcall GetPoint(TListItem*);
   void __fastcall vSave(TObject *Sender);
   void __fastcall vNew(TObject *Sender);
   void __fastcall vDelete(TObject *Sender);
   void __fastcall vCheck(TObject *Sender);
   void __fastcall vParams(TObject *Sender);
   void __fastcall vRefresh(TObject* Sender){;}
   void __fastcall LoadLGFile(TListItem&);
   void __fastcall LoadSLFile(TListItem&);
   void __fastcall LoadAlphaFile(TListItem&);
   void __fastcall LoadMaketNEKFile(TListItem&);
   void __fastcall LoadLGDatagyrFile(TListItem&);
   void __fastcall LoadCimRdfFile(TListItem&);
   void __fastcall LoadElvinFile(TListItem&li);
   void __fastcall LoadMercuryFile(TListItem&li);
   void __fastcall getXlsFileData(WideString FullFileName, long&dayCount, TDates**days);
   void __fastcall SaveParamsInReg(void);
   void __fastcall LoadParamsFromPeg();
   __fastcall ~TImportDatafilesForm();
};
//---------------------------------------------------------------------------
#endif
