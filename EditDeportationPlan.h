//---------------------------------------------------------------------------
#ifndef EditDeportationPlanH
#define EditDeportationPlanH
//---------------------------------------------------------------------------
#include <ActnList.hpp>
#include <Buttons.hpp>
#include <Classes.hpp>
#include <ComCtrls.hpp>
#include <Controls.hpp>
#include <ExtCtrls.hpp>
#include <ImgList.hpp>
#include <Mask.hpp>
#include <StdCtrls.hpp>
#include "Main.h"
#include <Menus.hpp>
#include <ToolWin.hpp>
//---------------------------------------------------------------------------
class TfmEditDeportationPlan : public TMainForm
{
__published:	// IDE-managed Components
   TPanel *Panel6;
	TPanel *Panel7;
   TImageList *ilMain;
   TPanel *Panel23;
   TPanel *paEdit;
   TPanel *Panel8;
   TPanel *Panel10;
   TPanel *Panel11;
   TPanel *Panel14;
   TPanel *Panel16;
   TPanel *Panel17;
   TEdit *eAddress;
   TPanel *Panel9;
   TPanel *Panel24;
   TPanel *Panel27;
   TPanel *Panel22;
   TCheckBox *chbBlocking;
   TPanel *Panel28;
   TComboBox *cbMainChannel;
   TTreeView *tvChannelsList;
   TPanel *Panel5;
   TPanel *Panel30;
   TEdit *eName;
   TMemo *mNote;
   TLabel *Label2;
   TRadioGroup *rgDataDeportationMode;
   TMaskEdit *meStart;
   TMaskEdit *meEnd;
   TComboBox *cbProc_id;
   TPanel *Panel21;
   TEdit *eRetries_Tout;
   TPanel *Panel20;
   TEdit *eRetries;
   TLabel *Label1;
   TPanel *Panel12;
   TEdit *eSendParam;
   TLabel *Label3;
   TLabel *Label4;
   TLabel *Label7;
   TAction *aBlocking;
   TAction *aEMail;
   TAction *aFTP;
   TAction *aLan;
  TToolBar *ToolBar1;
  TToolButton *ToolButton1;
  TToolButton *ToolButton3;
  TToolButton *ToolButton4;
  TEdit *lbId;
  TLabel *Label5;
  TToolButton *ToolButton2;
  TToolButton *ToolButton5;
  TAction *aNewGroup;
	void __fastcall tvChannelsListChange(TObject *Sender, TTreeNode *Node);
	void __fastcall ControlChange(TObject *Sender);
   void __fastcall tvChannelsListChanging(TObject *Sender, TTreeNode *Node,
      bool &AllowChange);
   void __fastcall edLongPress(TObject *Sender, char &Key);
   void __fastcall vDelete(TObject *Sender);
   void __fastcall tvChannelsListDeletion(TObject *Sender,
          TTreeNode *Node);
   void __fastcall aExecute(TObject *Sender);
        void __fastcall mMonClick(TObject *Sender);
  void __fastcall iaFindExecute(TObject *Sender);
  void __fastcall WM_SetActiveNode(TMessage& Message);
  void __fastcall aNewGroupExecute(TObject *Sender);
  void __fastcall tvChannelsListExpanding(TObject *Sender, TTreeNode *Node,
          bool &AllowExpansion);
  void __fastcall tvChannelsListExpanded(TObject *Sender, TTreeNode *Node);
  void __fastcall tvChannelsListDragOver(TObject *Sender, TObject *Source,
          int X, int Y, TDragState State, bool &Accept);
  void __fastcall tvChannelsListDragDrop(TObject *Sender, TObject *Source,
          int X, int Y);
private:	// User declarations
   struct stChannel{ // Атрибуты канала
      long NDeportation;//       Ид канала                          N
      bool HaveChilde;   //  Наличие детей
      bool IsFolder;     //Признак папки

      char Name[128];//          Название                           N
      char Note[256];//         Примечание                          Y
      long Proc_id;//         Процедура создающая макет             Y
      long DataDeportationMode;// Способ отсылки                    N
      char Address[2000];//       адрес отсылки файла              N
      long Parent; //            Главный канал                      Y
      char From[6]; //          Начало начало отсылки (hh24:mi)     Y
      char Till[6]; //            Окончание      (hh24:mi)          Y
      long Retries;      //      Кол попыток соединения             N
      long Retries_Tout; //      Пауза между попытками              N
      long Block;         //     Блокировка                         N
      short indicator[4];//    Флаги для контроля Proc_id, NPARENT, DFrom, DTill
      long editing;// 0 -Не трогали, 1-добавили, 2-редактировали
      long tmpNDeportation;//    Нужно при сохранении
      char SendParam[2000];//          Название                           N
   };
   long __fastcall getNodeId(TObject*obj){
        TTreeNode*tn=dynamic_cast<TTreeNode*>(obj);
        if(tn)  return ((stChannel*)tn->Data)->NDeportation;
        else    return 0;
    }
   TfmFindPoint *fmFP;
   bool ChangeControl;
   stChannel *SelChannel;
   long *nChannels_Del; // id тех каналов которые удалены списка
                              //  и необходимо удалить из таблицы каналов
   int Channels_Del_Count;
   bool __fastcall GetCombo(TComboBox *cb);
   bool __fastcall ReadChannels(TObject*obj); // Читает список каналов
   void __fastcall SetAccess(TAccess value);
   void __fastcall changeNode(TTreeNode*, TTreeNode*);
   void __fastcall copyChildNodes(TTreeNode*,TTreeNode*);
   bool is_changing;
public:		// User declarations
   __fastcall TfmEditDeportationPlan(TComponent* Owner, AnsiString, TAccess = accDenied);
   __fastcall ~TfmEditDeportationPlan();
protected:
	void __fastcall vNew(TObject *Sender);
	void __fastcall vSave(TObject *Sender);
	void __fastcall vRefresh(TObject *Sender);
  void __fastcall vClone(TObject* Sender);
};
//---------------------------------------------------------------------------
#endif
