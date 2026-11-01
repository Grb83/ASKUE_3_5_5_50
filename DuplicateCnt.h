//---------------------------------------------------------------------------

#ifndef DuplicateCntH
#define DuplicateCntH
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
#include <Grids.hpp>
#include <ComCtrls.hpp>

#include "Main.h"
#include "DuplicateCnt_InputParams.h"
//---------------------------------------------------------------------------

struct sDupPoints
{
        long mid;
        char PointName[150];
        char DStart[20];
        char DEnd[20];
        char VMemo[512];
        char UserName[50];
        char Denter[20];
};

class TfmDuplicateCnt : public TMainForm
{
__published:	// IDE-managed Components
        TBitBtn *bbEdit;
        TBitBtn *bbDelete;
        TBitBtn *bbParams;
        TBitBtn *bbAdd;
        TPanel *Panel1;
        TStringGrid *sgTable;
        THeaderControl *hcHead;
        TImageList *ilHead;
        void __fastcall FormCreate(TObject *Sender);
        void __fastcall hcHeadSectionResize(THeaderControl *HeaderControl,
          THeaderSection *Section);
        void __fastcall hcHeadSectionClick(THeaderControl *HeaderControl,
          THeaderSection *Section);
        void __fastcall sgTableKeyDown(TObject *Sender, WORD &Key,
          TShiftState Shift);
        void __fastcall FormResize(TObject *Sender);
        void __fastcall sgTableTopLeftChanged(TObject *Sender);
private:	// User declarations
        AnsiString strFrom;
        AnsiString strTo;
     //   AnsiString* strName;
     //   long m_mid;//mid of parent point
        long SortCol;//столбец по которому сортируем таблицу
        //1 - Name
        //2 - dateStart
        //3 - dateEnd
        //4 - Comment(Memo)
        //5 - UserName
        //6 - Input date
        int PredTopLeft;//самый первый видимый столбец таблицы
                //(дл€ синхронизации HeaderControl и StringGrid при горизонтальном скролле)
        bool SortAsc;//Ќаправление сортировки(true-возрастание,false-убывание)
        bool TableIsEmpty;//if true table empty

        POINTSTREEDEF RootPoint;

public:		// User declarations
        __fastcall TfmDuplicateCnt(TComponent* Owner, AnsiString, TAccess = accDenied);
        virtual __fastcall ~TfmDuplicateCnt();
        void __fastcall AddEdit(bool onEdit);
        void __fastcall FillTable();
protected:
        void __fastcall vSave(TObject* Sender);
        void __fastcall vNew(TObject* Sender);
        void __fastcall vRefresh(TObject* Sender);
        void __fastcall vParams(TObject* Sender);
        void __fastcall vDelete(TObject* Sender);
        void __fastcall vCheck(TObject* Sender);//–едактировать
};
//---------------------------------------------------------------------------
extern PACKAGE TfmDuplicateCnt *fmDuplicateCnt;
//---------------------------------------------------------------------------
#endif
