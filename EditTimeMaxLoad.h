//---------------------------------------------------------------------------
#ifndef EditTimeMaxLoadH
#define EditTimeMaxLoadH
//---------------------------------------------------------------------------
#include <ActnList.hpp>
#include <Buttons.hpp>
#include <Classes.hpp>
#include <ComCtrls.hpp>
#include <Controls.hpp>
#include <ExtCtrls.hpp>
#include <Mask.hpp>
#include <StdCtrls.hpp>
#include "Main.h"
#include <ImgList.hpp>
#include <Menus.hpp>
//---------------------------------------------------------------------------
class TFormEditTimeMaxLoad : public TMainForm
{
__published:	// IDE-managed Components
	TPanel *Panel5;
	TPanel *Panel7;
	TPanel *Panel9;
   TBitBtn *btAdd;
   TBitBtn *btDelete;
   TPanel *paEdit;
	TPanel *Panel6;
	TPanel *Panel8;
	TTreeView *TreeView1;
  TLabel *Label1;
  TMaskEdit *meStart;
  TMaskEdit *meMStart;
  TMaskEdit *meMEnd;
  TLabel *Label2;
  TLabel *Label3;
  TLabel *Label6;
  TLabel *Label7;
  TLabel *Label4;
  TMaskEdit *meEStart;
  TLabel *Label5;
  TMaskEdit *meEEnd;
  void __fastcall FormShow(TObject *Sender);
  void __fastcall TreeView1Changing(TObject *Sender, TTreeNode *Node,
          bool &AllowChange);
  void __fastcall meChange(TObject *Sender);
  void __fastcall TreeView1Deletion(TObject *Sender, TTreeNode *Node);
  void __fastcall TreeView1Change(TObject *Sender, TTreeNode *Node);
  void __fastcall meStartExit(TObject *Sender);
  void __fastcall meMStartExit(TObject *Sender);
private:	// User declarations
   typedef struct { //дерево обьектов учета
      long Mid;
      long tmpMid;
      char Date_Time[16];	    //DATE,
      char Morning_Start[8];	//DATE,
      char Morning_End[8];  	//DATE,
      char Evening_Start[8];	//DATE,
      char Evening_End[8];  	//DATE,
      long editing;// 0 -Не трогали, 1-трогали и скопировали, 2-трогали и не скопировали
   }POINTSDIV;
   bool realdeletion;
   long nPoints_Del[1000]; // id тех групп которые удалены из дерева
                            //  и необходимо удалить из таблицы MAXHOURS
   long CountPoints_Del;// Кол-во удаляемых элементов
   bool __fastcall ReadData(void);// Читает данные
   void __fastcall SetAccess(TAccess value);
public:		// User declarations
	__fastcall TFormEditTimeMaxLoad(TComponent* Owner, AnsiString, TAccess = accDenied);
protected:
	void __fastcall vNew(TObject *Sender);
	void __fastcall vDelete(TObject *Sender);
	void __fastcall vSave(TObject *Sender);
	void __fastcall vRefresh(TObject *Sender);
};
//---------------------------------------------------------------------------
#endif
