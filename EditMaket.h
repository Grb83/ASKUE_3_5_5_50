//---------------------------------------------------------------------------
#ifndef EditMaketH
#define EditMaketH
//---------------------------------------------------------------------------
#include <ActnList.hpp>
#include <Buttons.hpp>
#include <Classes.hpp>
#include <ComCtrls.hpp>
#include <Controls.hpp>
#include <ExtCtrls.hpp>
#include <ImgList.hpp>
#include <Menus.hpp>
#include <StdCtrls.hpp>
#include <ToolWin.hpp>
#include "Main.h"
#include "DBAccess.hpp"
#include "MemDS.hpp"
#include "Ora.hpp"
#include <DB.hpp>
#include <Dialogs.hpp>
//---------------------------------------------------------------------------
#define imPoint     0
#define imInvPoint  1
#define imGroup     2
#define imMaket     3
#define imFolder    4
#define imOpenFldr  5
#define imBlMaket   6
#define imAgrGroup  7
#define imInvGroup  8
#define imMaketErr  24
#define imBlMaketErr 25
#define imOpenBlFolder  22
#define imBlFolder  23
#define SAA_MAXCOUNTPOINTS 100
//---------------------------------------------------------------------------
enum TMType {mtUnknown,mtMaket=1,mtGroup=2,mtPoint=3,mtAgrGroup=4,mtSubGroup=5,mtFolder=6};
enum TDimention {dmUnknown=0,dmAPlus=1,dmAMinus=2,dmA=3,dmQPlus=4,dmQMinus=5,dmQ=6};
//---------------------------------------------------------------------------
class TEditMaketForm : public TMainForm
{
__published:	// IDE-managed Components
   TPanel *MaketListPanel;
   TPanel *MaketListTitlePanel;
   TTreeView *MaketListTV;
   TPanel *plRight;
   TPageControl *PageControl;
   TTabSheet *tsPoints;
   TTabSheet *tsProperties;
   TTreeView *PointsTV;
  TPanel *plProp;
   TLabel *lName;
   TEdit *eName;
   TLabel *lComment;
   TMemo *mComment;
   TLabel *lFormationFunc;
   TComboBox *cbFormationFunc;
   TCheckBox *cbBlocking;
   TCheckBox *cbExecUnexecutingInTime;
   TLabel *lLastDateExec;
   TLabel *lError;
   TMemo *mError;
   TPanel *plGroups;
   TLabel *lStrCode;
   TEdit *eStrCode;
   TPanel *plPoints;
   TLabel *lShortName;
   TLabel *lEntryFactor;
   TEdit *eShortName;
   TEdit *eEntryFactor;
   TGroupBox *gbGroupDimType;
   TCheckBox *cbAMinus;
   TCheckBox *cbAOvfw;
   TCheckBox *cbQPlus;
   TCheckBox *cbQMinus;
   TCheckBox *cbQOvfw;
   TCheckBox *cbAPlus;
   TRadioGroup *rgDimType;
   TEdit *eLastDateExec;
   TShape *Shape1;
   TShape *Shape2;
   TShape *Shape3;
   TShape *Shape4;
   TLabel *lSFShift;
   TEdit *eSFShift;
   TEdit *eAddParams;
   TLabel *lAddParams;
   TCheckBox *cbAgrGroup;
   TPanel *plSubGroup;
   TLabel *lNSign;
   TEdit *eNSign;
   TLabel *lMid;
   TEdit *eMid;
    TToolBar *ToolBar1;
    TToolButton *ToolButton1;
    TToolButton *ToolButton2;
    TToolButton *ToolButton3;
    TToolButton *ToolButton4;
        TToolButton *ToolButton5;
  TToolButton *btChanel;
  TOraQuery *oqClone;
  TToolButton *btNewGroup;
  TPanel *plMaketProp;
  TAction *iaNewFolder;
        TToolButton *ToolButton6;
        TToolButton *btSign;
        TOpenDialog *ElSignatureOpen;
   void __fastcall FormShow(TObject *Sender);
   void __fastcall PointsTVCollapsed(TObject *Sender, TTreeNode *Node);
   void __fastcall PointsTVExpanded(TObject *Sender, TTreeNode *Node);
   void __fastcall PointsTVExpanding(TObject *Sender, TTreeNode *Node,
          bool &AllowExpansion);
   void __fastcall MaketListTVDragOver(TObject *Sender, TObject *Source,
          int X, int Y, TDragState State, bool &Accept);
   void __fastcall MaketListTVDragDrop(TObject *Sender, TObject *Source,
          int X, int Y);
   void __fastcall MaketListTVChange(TObject *Sender, TTreeNode *Node);
   void __fastcall MaketListTVChanging(TObject *Sender, TTreeNode *Node,
          bool &AllowChange);
   void __fastcall DataChange(TObject *Sender);
   void __fastcall CheckedClick(TObject *Sender);
   void __fastcall MaketListTVDeletion(TObject *Sender, TTreeNode *Node);
   void __fastcall cbMouseMove(TObject *Sender, TShiftState Shift,
          int X, int Y);
   void __fastcall cbDragOver(TObject *Sender, TObject *Source, int X,
          int Y, TDragState State, bool &Accept);
   void __fastcall cbDragDrop(TObject *Sender, TObject *Source, int X,
          int Y);
   void __fastcall aMExecute(TObject *Sender);
        void __fastcall btChanelClick(TObject *Sender);
        void __fastcall mMonClick(TObject *Sender);
  void __fastcall MaketListTVExpanded(TObject *Sender, TTreeNode *Node);
  void __fastcall iaNewFolderExecute(TObject *Sender);
        void __fastcall btSignClick(TObject *Sender);
private:	// User declarations
/*
struct MAKET
    {
        TMType Type; //= 1 - maket, 2-group, 3-point, 4-agr.group, 5-agr.subgroup
        short editing;// 0 -Не трогали, 1-трогали и скопировали, 2-трогали и не скопировали
        long Mid;  // идентификатоор элемента (Type)
        long tmpMid;
        char Name[150];
        union {  // объединение различных полей по макетам, группам и точкам
            struct { // структура по полям, относящимся к макетам и группам
                char Comment[256];   // общее поле для макета и группы
                union {   // объединение полей уникальных для макета и группы
                    struct {  // индивидуальные поля макетов
                        unsigned long FormationFunc; // процедура формирования
                        int Blocking;       // блокировка
                        int ExecUnexecutingInTime;   //  выполнять невыполненные вовремя
                        float SFShift;
                        char Params[2000];
                        char LastDateFormation[32];       //  последняя дата формирования
                        char Error[2000];              //  ошибка
                    };
                    struct { // индивидуальное поле группы (код строки в макете)
                        char StrCode[2000];
                        double nSign;  // индивидуальное поле для агрегатной подшруппы - коэффициент вхождения
                        long nGroup;   // ссылка на группу - парент по узлам дерева ( = ngroup, т.к. mid = nsubgroup)
                        TTreeNode *origin; // ссылка на группу, содержащую оригинальные параметры ... - не используется (для перехода к редактированию параметров самой группы...)
                    };
                };
            };
            struct {  // индивидуальные поля точек
                long GroupId;
                char Short_Name[50];
                double KC;		    //коэффициент вхождения
                TDimention DimType;     // тип измерения
            };
        }; // union
    };
*/
  struct MAKET
  {
      TMType Type; //= 1 - maket, 2-group, 3-point, 4-agr.group, 5-agr.subgroup, 6-folder
      short editing;// 0 -Не трогали, 1-трогали и скопировали, 2-трогали и не скопировали
      long Mid;  // идентификатоор элемента (Type)
      long tmpMid;
      char Name[150];
      char Comment[256];   // общее поле для макета и группы
      long FormationFunc; // процедура формирования
      int Blocking;       // блокировка
      int ExecUnexecutingInTime;   //  выполнять невыполненные вовремя
      float SFShift;
      char Params[2000];
      char LastDateFormation[32];       //  последняя дата формирования
      char Error[2000];              //  ошибка
      char StrCode[2000];
      double nSign;  // индивидуальное поле для агрегатной подшруппы - коэффициент вхождения
      long nGroup;   // ссылка на группу - парент по узлам дерева ( = ngroup, т.к. mid = nsubgroup) также юзаем для папок и макетов для хранения ид родителя
      TTreeNode *origin; // ссылка на группу, содержащую оригинальные параметры ... - не используется (для перехода к редактированию параметров самой группы...)
      long GroupId;
      char Short_Name[50];
      double KC;		    //коэффициент вхождения
      TDimention DimType;     // тип измерения
      MAKET(){ ZeroMemory(this,sizeof(*this)); }
      MAKET(TMType type);
  };
   bool __fastcall ReadTreeNode(TTreeView*,TTreeNode*);
   bool __fastcall LoadFormationFunc();
   void __fastcall CopyChildPoints(TTreeNode * d, TTreeNode * s);
   void __fastcall SetCGB(TDimention value, TCheckBoxState s);  // установка изменений по клику на компоненте для группы точек
   void __fastcall GetCGB();           // считать данные по точкам для группы
   bool realdeletion;
   struct{
      TMType Type;
      long Mid;
      long nGroup;
   } nNodes_Del[5000]; // массив узлов которые удалены из дерева и необходимо удалить из таблиц
   long CountNodes_Del;// Кол-во удаляемых узлов
   TTreeNode* m_Sel2Paste;//указатель узла, выделенного для вставки ч/з клаву (Ctrl+C, Ctrl+X)
   bool __fastcall CheckAcceptNode(TTreeNode*, TTreeNode*);
   bool __fastcall MoveNode(TTreeNode*mNode, TTreeNode*aNode);
   bool __fastcall CopyNode(TTreeNode*cNode, TTreeNode*aNode);
   TMType FSelType;
   void __fastcall SetAccess(TAccess value);
   void __fastcall vAnyEditClick(TObject* Sender);
   int __fastcall GetFolderInd(TTreeNode* Node, bool blocked);
   typedef struct {  //Новая ГУППЫ ОТЧЁТОВ
	  int Level;
  	  long Gid;
	  char Name[150];
          int Mid;
     }NEWREPORTGROUP;
public:		// User declarations
   __fastcall TEditMaketForm(TComponent*, AnsiString, TAccess = accDenied);
   void __fastcall SetSelType(TMType value);
   __fastcall ~TEditMaketForm();
protected:
   void __fastcall vSave(TObject *Sender);
   void __fastcall vRefresh(TObject *Sender);
   void __fastcall vNew(TObject* Sender);
   void __fastcall vDelete(TObject* Sender);
   void __fastcall vEditClick(TObject*);
   void __fastcall vClone(TObject *Sender);
   void __fastcall vUpdate(TObject*Sender);
   void __fastcall changeNode(TTreeNode*, TTreeNode*);
   __property TMType SelType  = { write=SetSelType };
};
//---------------------------------------------------------------------------
#endif
