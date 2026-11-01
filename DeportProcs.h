//---------------------------------------------------------------------------
#ifndef DeportProcsH
#define DeportProcsH
//---------------------------------------------------------------------------
#include <ActnList.hpp>
#include <Buttons.hpp>
#include <Classes.hpp>
#include <ComCtrls.hpp>
#include <Controls.hpp>
#include <ExtCtrls.hpp>
#include <Forms.hpp>
#include <ImgList.hpp>
#include <StdCtrls.hpp>
#include "Main.h"
#include <Menus.hpp>
#include <ToolWin.hpp>
#include <Dialogs.hpp>
//---------------------------------------------------------------------------
struct stDeportProc{ // Атрибуты канала
  long NProcedure;//                Ид канала                          N
  char VName[256];//          Название                           N
  char VProcedure[128];//          Название  проц                         N
  char VMemo[2000];//         Примечание                         Y
  char VParam[2000];
  float NPeriod;
  long NShift;
  long NType;
  short indicator[6];//    Флаги для контроля 4-мя long и две даты
  long editing;// 0 -Не трогали, 1-добавили, 2-редактировали
  long tmpCid;//    Нужно при сохранении
};

struct stProcesses
{
  long NType;// 1 - макет 2 - процедура
  long nMaket;//                Ид канала                N
  char vName[200];//          Название                  N
  long nProcedure;
  char vProcedure[256];//         Примечание                Y
  char vNote[256];//         Примечание                Y
  char vPeriod[20];
  long nShift;
  char vParam[2000];
  char vError[2000];
  char vNextCreated[20]; // дата следующего выполнения системного выполнения
  long nCycle;
  long nBlock;
  long editing;// 0 -Не трогали, 1-добавили, 2-редактировали
  char vLastCreated[20]; // дата последнего выполнения
};

struct stProcedures
{
   long nProsedure;
   char vName[256];
   char vPeriod[15];
};
class TfmDeportProcs : public TMainForm
{
__published:	// IDE-managed Components
	TPanel *Panel6;
	TPanel *Panel7;
  TPanel *Panel23;
  TPanel *Panel9;
        TPanel *Panel8;
        TScrollBox *ScrollBox1;
        TPanel *paEdit;
  TLabel *Label1;
  TEdit *eName;
  TMemo *mNote;
  TLabel *Label3;
  TEdit *eNShift;
  TLabel *Label4;
  TLabel *Label2;
  TLabel *Label5;
  TEdit *eParam;
        TComboBox *cbProcName;
        TCheckBox *chbExecUnexecutingInTime;
        TCheckBox *chbBlocking;
        TLabel *Label6;
        TLabel *Label7;
        TMemo *mError;
        TLabel *Label8;
        TEdit *eNextDateRun;
        TListView *lvProcess;
        TEdit *eLastDateRun;
        TImageList *ilMain;
        TBitBtn *bbRunProcess;
  TLabel *lbId;
  TLabel *Label9;
        TToolBar *ToolBar1;
        TToolButton *btDel;
        TToolButton *btAdd;
        TToolButton *ToolButton3;
        TToolButton *btCanel;
  TPopupMenu *PopupMenu2;
  TMenuItem *qweqwe1;
  TMenuItem *qweqweqw1;
  TMenuItem *qweqweq1;
  TMenuItem *qweqwe2;
  TMenuItem *qweqw1;
  TMenuItem *N2342341;
  TMenuItem *N234321;
  TMenuItem *N2342342;
  TMenuItem *N2342343;
  TMenuItem *asd1;
  TToolBar *ToolBar2;
  TToolButton *tbState0;
  TToolButton *tbState1;
        TBitBtn *BitBtn1;
        TSaveDialog *SaveDialog1;
  void __fastcall FormShow(TObject *Sender);
  void __fastcall edLongPress(TObject *Sender, char &Key);
        void __fastcall lvProcessChanging(TObject *Sender, TListItem *Item,
          TItemChange Change, bool &AllowChange);
        void __fastcall lvProcessChange(TObject *Sender, TListItem *Item,
          TItemChange Change);
        void __fastcall lvProcessDeletion(TObject *Sender,
          TListItem *Item);
        void __fastcall ChangeParams(TObject *Sender);
        void __fastcall cbProcNameExit(TObject *Sender);
        void __fastcall bbRunProcessClick(TObject *Sender);
        void __fastcall lvProcessClick(TObject *Sender);
        void __fastcall Action1Execute(TObject *Sender);
        void __fastcall mMonClick(TObject *Sender);
  void __fastcall tbStateClick(TObject *Sender);
        void __fastcall BitBtn1Click(TObject *Sender);
private:	// User declarations
  bool ChangeControl;
  stProcesses *SelProcess;
  long *Processes_Del; // id тех процессов которые удалены списка
                              //  и необходимо удалить из таблицы
  int Processes_Del_Count;
  bool __fastcall ReadCombo();
  bool __fastcall ReadProcesses();    // Читает список процессов
  TStrings* PeriodName;
   void __fastcall SetAccess(TAccess value);
public:		// User declarations
	__fastcall TfmDeportProcs(TComponent* Owner, AnsiString, TAccess = accDenied);
	virtual __fastcall ~TfmDeportProcs();
protected:
   void __fastcall vSave(TObject *Sender);
   void __fastcall vRefresh(TObject *Sender);
   void __fastcall vNew(TObject *Sender);
   void __fastcall vDelete(TObject *Sender);
};
//---------------------------------------------------------------------------
#endif
