//---------------------------------------------------------------------------

#ifndef unInteriorUniH
#define unInteriorUniH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "DBAccess.hpp"
#include "DBGridEh.hpp"
#include "MemDS.hpp"
#include "Ora.hpp"
#include "PrnDbgeh.hpp"
#include "VirtualTable.hpp"
#include <ActnList.hpp>
#include <DB.hpp>
#include <Grids.hpp>
#include <ImgList.hpp>
#include <Menus.hpp>
#include "FormDescr.h"
#include <ComCtrls.hpp>
#include <Dialogs.hpp>
#include <StrUtils.hpp>
#include "Monitor.h"
#include <ExtCtrls.hpp>
#include <QuickRpt.hpp>

//---------------------------------------------------------------------------
class TfmInteriorUni : public TForm
{
__published:	// IDE-managed Components
  TImageList *iImageList;
  TActionList *acBase;
  TAction *iaPoints;
  TAction *iaSave;
  TAction *iaCheck;
  TAction *iaNew;
  TAction *iaDelete;
  TAction *iaParams;
  TAction *iaClone;
  TAction *aMLeft;
  TAction *aMRigth;
  TAction *aMUp;
  TAction *aMDown;
  TAction *acFileClose;
  TAction *acFileExit;
  TAction *acRefresh;
  TAction *aMUpCtr;
  TAction *aMDownCtr;
  TAction *iaChannel;
  TAction *iaMakets;
  TAction *iaClear;
  TMainMenu *mnMain;
  TMenuItem *mnFile;
  TMenuItem *N4;
  TMenuItem *mnRefresh;
  TMenuItem *N5;
  TMenuItem *mnFileClose;
  TMenuItem *N1;
  TMenuItem *mnFileExit;
  TOraQuery *oqMaketInfoCol;
  TOraDataSource *dsData;
  TVirtualTable *vtData;
  TOraQuery *oqVal;
  TOraQuery *oqSave;
  TOraQuery *oqMaketInfoRow;
  TOraQuery *oqValGraf;
  TPrintDBGridEh *PrintDBGridEh1;
  TOraQuery *oqName;
  TDBGridEh *grData;
  TOraQuery *oqColor;
  TOraQuery *oqPrint;
  TOraQuery *oqTarZone;
        TStringGrid *MaketF;
        TOraQuery *oqValCartage;
        TOraQuery *oqMaketInfoCol53;
        TSaveDialog *SaveDialog1;
  void __fastcall grDataColExit(TObject *Sender);
  void __fastcall vtDataAfterPost(TDataSet *DataSet);
  void __fastcall vtDataAfterEdit(TDataSet *DataSet);
  void __fastcall grDataExit(TObject *Sender);
  void __fastcall vtDataNewRecord(TDataSet *DataSet);
  void __fastcall grDataColEnter(TObject *Sender);
  void __fastcall vtDataAfterScroll(TDataSet *DataSet);
  void __fastcall grDataDrawColumnCell(TObject *Sender, const TRect &Rect,
          int DataCol, TColumnEh *Column, TGridDrawState State);
  void __fastcall grDataTitleClick(TColumnEh *Column);
  void __fastcall grDataMouseDown(TObject *Sender, TMouseButton Button,
          TShiftState Shift, int X, int Y);
  void __fastcall grDataEnter(TObject *Sender);
  void __fastcall grDataDblClick(TObject *Sender);
  void __fastcall StringGrid1DrawCell(TObject *Sender, int ACol,
          int ARow, TRect &Rect, TGridDrawState State);

private:	// User declarations
  struct TFieldS{
    long id;
    TStrings*  Title;
    TColor TitleCl,DataCl;
    TAlignment TitleAl,DataAl;
    long nlock;
    long nwidth;
    char sMasks[32];
    TFieldS(){ ZeroMemory(this,sizeof(*this)); Title=new TStringList();}
    ~TFieldS(){ delete Title;}
  };
  long FixColCount;
  long TitleCount;
  long FooterCount;
  TList *ColInfo;
  TList *RowInfo;
  bool isExistsMaket;
  struct TColorS{
    long Col;
    long Row;
    long Color;
    char Info[256];
    TColorS(){ ZeroMemory(this,sizeof(*this));}
  };

  TColorS *masColor;
  int cntColor;
  TFormDescr* FD;
  void __fastcall ClearList(TList * l);
  void __fastcall ShowGraph(long Col,long Row);
  void __fastcall RefreshData(TObject *Sender);
  AnsiString __fastcall FormatByMask(const AnsiString cMasks,const AnsiString rMasks,double d);
  void __fastcall SendUpdateMessage(void);
  TColor __fastcall FindColor(int Col,int Row);
  AnsiString __fastcall FindColorStr(int Col,int Row);
  void __fastcall CreateColorMass(void);
  void __fastcall SaveTable(TComponent* Owner,TDBGridEh *gr,AnsiString RepCaption);
  AnsiString __fastcall getLastPartOfNameColumn (AnsiString columnName, int numRec,bool wasGroupNameAsFirstLine);
  TDateTime Dt1;
  TDateTime Dt2;
  TDateTime Dt3;
  AnsiString QuantityStr;
  bool EditRec;
  bool modeMaketFM;
  int __fastcall getRowMaketNum();
  int __fastcall getColMaket30917Num();
  void __fastcall formingMaket();

  void __fastcall fAutoSizeColSG(TStringGrid * StringGrid);
  void __fastcall split(TStringList* lout, char* str, const char* separator);
  AnsiString __fastcall getIdPointbyCode30917 (AnsiString code, TStringList* pointsInfo, TStringList* cloneMaketGroupsInfo);
  AnsiString __fastcall getNamebyCode30917 (AnsiString code, TStringList* pointsInfo, TStringList* cloneMaketGroupsInfo);

  void __fastcall printMaketHeader();
  void __fastcall printMaketValues();
  bool __fastcall printMaketData2();
  void __fastcall clearTable ();
  void __fastcall clearTable2();

  int __fastcall getColMaket30817Num();

  int __fastcall getColMaket30818Num();

  //GRB maket formed
  char maketType[30];
  TStringList* maket;
  TStringList* maketGroupsInfo;
  TStringList* cloneMaketGroupsInfo;
  TStringList* maketListPoints;
  AnsiString delim;
  // Тут секция с переменными и методами для работы с многостолбцовым макетом
  bool modeManyColumn;
  int tableNumbers;
  int columnNumbers; //
  int activeRowNumbers;
  AnsiString companyName;
  AnsiString consumerName;


  void __fastcall printHeaderManyColumn();
  void __fastcall printDataManyColumn();
protected:
  void __fastcall vSave(TObject* Sender);
public:		// User declarations
  __fastcall TfmInteriorUni(TComponent* Owner,TFormDescr*);
  __fastcall TfmInteriorUni(TComponent* Owner, TFormDescr*, TStringList*, char* , TStringList*,  TStringList*,  TStringList*, AnsiString);
  //GRB ADD 23.01.2019
  __fastcall TfmInteriorUni(TComponent* Owner,TFormDescr*, int tableNumbers);
  //GRB ADD 22.10.2022
  __fastcall TfmInteriorUni(TComponent* Owner,TFormDescr*, bool _mode30902_receive, TStringList *maket);
  __fastcall ~TfmInteriorUni();
  void __fastcall vRefresh(TObject *Sender);
  void __fastcall vSaveToFile(TObject *Sender,AnsiString sTitle=AnsiString(""));
  void __fastcall PrintData(TObject *Sender,AnsiString sTitle=AnsiString(""));
  //21.12.2108 GRB ADD - Для тестового вывода 3-х таблиц
  void __fastcall vRefreshTriada(TObject *Sender);
  void __fastcall SaveMultyTableToFileClick (TObject *Sender);
  AnsiString __fastcall getSeparator ();
  AnsiString __fastcall formFullValue(AnsiString row_value, AnsiString separator, int digitNumber);
  // Тут секция с переменными и методами для работы с принятым макетом 30902
 bool mode30902_receive;
 TStringList *maketRow;
 int block_size_902;
 void __fastcall vRefreshReceive30902(TObject *Sender);
 void __fastcall printMaketHeader30902();
 void __fastcall printMaketValues30902();
 int __fastcall getBlockSize_902();
 AnsiString __fastcall clear_prob (AnsiString str);
 int __fastcall getMaxSymbolInColumn (TStringGrid* tsg, int column);
 AnsiString __fastcall add_Prob_to_Max_Size (AnsiString row, int max_size);
};
//---------------------------------------------------------------------------
extern PACKAGE TfmInteriorUni *fmInteriorUni;
//---------------------------------------------------------------------------
#endif
