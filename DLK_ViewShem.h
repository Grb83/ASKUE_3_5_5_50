//---------------------------------------------------------------------------

#ifndef DLK_ViewShemH
#define DLK_ViewShemH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ActnList.hpp>
#include <Buttons.hpp>
#include <ExtCtrls.hpp>
#include <ImgList.hpp>
#include <Menus.hpp>
#include <OleCtrls.hpp>
#include <ComCtrls.hpp>
#include <ToolWin.hpp>
#include "Main.h"
#include "Open_OCX.h"
//---------------------------------------------------------------------------
#define BAD_STR ""
#define BAD_ID  -1
//---------------------------------------------------------------------------
/*! Перечень типов режимов данной формы
*/
typedef enum
{ vsNone        = 0x00,   //!< Не выбран режим просмотра
  vsCommutation = 0x01,   //!< Режим Коммутации
  vsLoss        = 0x02    //!< Режим просмотра потерь
} TVSFormType;
//---------------------------------------------------------------------------
class TMainFormPrivate
{
public:
  AnsiString  period;         //!< Период
  AnsiString  newperiod;      //!< Вновь добавленный период
  long        subperiodID;    //!< Идентификатор подпериода
  AnsiString  subperiodStr;   //!< Идентификатор подпериода
  long        shemID;         //!< Идентификатор схемы
  AnsiString  shemStr;        //!< Идентификатор схемы
  long        datatype;       //!< Идентификатор в списке "Вид:"
  long  pid;        //id property "положение при нормальной схеме"
  long  pid_text;   //id property "текст"
  bool  refresh;    //!< Признак обновления всех данных
  //TDataVector data; //!< Список идентификаторов значений
  TMainFormPrivate()
  { period        = BAD_STR;
    newperiod     = BAD_STR;
    subperiodID   = BAD_ID;
    subperiodStr  = BAD_STR;
    shemID        = BAD_ID;
    shemStr       = BAD_STR;
    datatype      = BAD_ID;

    pid       = 1;
    pid_text  = 4;

    refresh = false;

    //data.clear();
  }
  ~TMainFormPrivate()
  { period        = BAD_STR;
    newperiod     = BAD_STR;
    subperiodID   = BAD_ID;
    subperiodStr  = BAD_STR;
    shemID        = BAD_ID;
    shemStr       = BAD_STR;
    datatype      = BAD_ID;
    //data.clear();
  }
};
//---------------------------------------------------------------------------
class TViewShemForm : public TMainForm
{
__published:	// IDE-managed Components
  TfmShemEdit *ShemEdit;
  TCoolBar *MainCoolBar;
  TToolBar *ToolBar1;
  TToolBar *ToolBar2;
  TSpeedButton *PrintSBtn;
  TToolButton *ToolButton1;
  TSpeedButton *RefreshSBtn;
  TSpeedButton *FitSBtn;
  TSpeedButton *InsertSBtn;
  TSpeedButton *CalcSBtn;
  TSpeedButton *InfoSBtn;
  TToolButton *ToolButton2;
  TLabel *Label1;
  TComboBox *ScaleCB;
  TImageList *DLKIList;
  TActionList *DLKAList;
  TAction *PrintAction;
  TAction *RefreshAction;
  TAction *FitAction;
  TAction *InfoAction;
  TAction *InsertAction;
  TAction *CalcAction;
  TLabel *Label2;
  TComboBox *DataTypeCB;
  TLabel *Label3;
  TComboBox *SubPeriodCB;
  TLabel *Label4;
  TComboBox *PeriodCB;
  TLabel *Label5;
  TComboBox *ShemCB;
  TToolButton *ToolButton3;
  TToolButton *ToolButton4;
  TToolButton *ToolButton5;
  TDateTimePicker *PeriodDTP;
  void __fastcall FormDestroy(TObject *Sender);
  void __fastcall PrintActionExecute(TObject *Sender);
  void __fastcall RefreshActionExecute(TObject *Sender);
  void __fastcall FitActionExecute(TObject *Sender);
  void __fastcall InfoActionExecute(TObject *Sender);
  void __fastcall InsertActionExecute(TObject *Sender);
  void __fastcall CalcActionExecute(TObject *Sender);
  void __fastcall ScaleCBChange(TObject *Sender);
  void __fastcall ShemCBChange(TObject *Sender);
  void __fastcall PeriodCBChange(TObject *Sender);
  void __fastcall SubPeriodCBChange(TObject *Sender);
  void __fastcall DataTypeCBChange(TObject *Sender);
  void __fastcall ShemEditChangeCommut(TObject *Sender, int *change);
protected:
  virtual void __fastcall vRefresh(TObject *Sender);
  virtual void __fastcall vSave(TObject *Sender);
private:	// User declarations
  void __fastcall LoadShemList();
  void __fastcall LoadPeriodList();
  void __fastcall LoadSubPeriodList();
  void __fastcall LoadShem();
  void __fastcall ClearLoss();
  void __fastcall LoadLoss();
  void __fastcall LoadCommutation();

  TVSFormType       dvstype;
  TMainFormPrivate  *d;

public:		// User declarations
  __property  TVSFormType type  = { read  = dvstype };

  __fastcall TViewShemForm(TComponent* Owner, AnsiString Name, TAccess acc = accDenied,
                            TVSFormType vsftype = vsCommutation);
};
//---------------------------------------------------------------------------
extern PACKAGE TViewShemForm *ViewShemForm;
//---------------------------------------------------------------------------

#endif
