//---------------------------------------------------------------------------
#ifndef ReportDepartmentH
#define ReportDepartmentH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <Buttons.hpp>
#include <Grids.hpp>
//---------------------------------------------------------------------------
struct stStorDepat // Структура для вытяжки подразделений
{
       long nDepartment;
       char vName[128];
       long nSort;
};
class TfmDepartmens : public TForm
{
__published:	// IDE-managed Components
        TPanel *Panel1;
        TStringGrid *StringGridDep;
        TBitBtn *BitBtn1;
        TBitBtn *BitBtn3;
        TBitBtn *BitBtn4;
        TBitBtn *BitBtn5;
        TBitBtn *BitBtn6;
        TBitBtn *BitBtn2;
        void __fastcall FormShow(TObject *Sender);
        void __fastcall BitBtn3Click(TObject *Sender);
        void __fastcall BitBtn5Click(TObject *Sender);
        void __fastcall BitBtn6Click(TObject *Sender);
        void __fastcall BitBtn1Click(TObject *Sender);
        void __fastcall SaveChanged();
        void __fastcall BitBtn4Click(TObject *Sender);
        void __fastcall StringGridDepGetEditText(TObject *Sender, int ACol,
          int ARow, AnsiString &Value);
        void __fastcall Retrieve();
        void __fastcall BitBtn2Click(TObject *Sender);
        bool __fastcall InsDepartment(long *l_Department, char *c_Department);
        void __fastcall FormCloseQuery(TObject *Sender, bool &CanClose);
private:	// User declarations
public:		// User declarations
        __fastcall TfmDepartmens(TComponent* Owner);
        long il_Del[100];
        long il_Count, il_row;

};
//---------------------------------------------------------------------------
extern PACKAGE TfmDepartmens *fmDepartmens;
//---------------------------------------------------------------------------
#endif
