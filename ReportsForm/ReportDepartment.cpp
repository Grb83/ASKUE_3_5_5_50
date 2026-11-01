//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#include "ReportDepartment.h"
#include "unDataMod.h"
#include "Main.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TfmDepartmens *fmDepartmens;
//---------------------------------------------------------------------------
__fastcall TfmDepartmens::TfmDepartmens(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TfmDepartmens::FormShow(TObject *Sender)
{
 Retrieve();
}
//---------------------------------------------------------------------------
void __fastcall TfmDepartmens::BitBtn3Click(TObject *Sender)
{
unsigned long row;
row = StringGridDep->RowCount;
    StringGridDep->RowCount = row + 1;
    StringGridDep->Cells[1][row] = "<Новое подразделение>";
    StringGridDep->Cells[0][row] = "99999";
    StringGridDep->Cells[2][row] = "-1";
    StringGridDep->Cells[3][row] = "3";
    StringGridDep->Row = row;
}
//---------------------------------------------------------------------------

void __fastcall TfmDepartmens::BitBtn5Click(TObject *Sender)
{
    il_row = StringGridDep->Row;
}
//---------------------------------------------------------------------------

void __fastcall TfmDepartmens::BitBtn6Click(TObject *Sender)
{
    il_row = -1;
//  TfmDepartmens *f = new TfmDepartmens(this);
//  f->ShowModal();
//  delete f;
}
//---------------------------------------------------------------------------
void __fastcall TfmDepartmens::SaveChanged()
{
    long CountStr, ll_change, ll_dep, ll_sort;
    char lc_dep[128];
    AnsiString ls_sort;
    bool lb_modify = true;
 try{
    CountStr = StringGridDep->RowCount - 1;
    for(long i=1; i<=CountStr; i++)
    {
        StrCopy(lc_dep, StringGridDep->Cells[1][i].c_str());
        ll_change = StrToInt(StringGridDep->Cells[3][i]);
        ls_sort = StringGridDep->Cells[0][i];
        //GRB ADD 16.04.2020 - test trouble ODAC
        dmMain->quMain->Params->Clear();
        //END ADD 
        switch (ll_change)
        {
        case 3 :
            for (int i=1; i<=ls_sort.Length(); i++)
            {
                if(!ls_sort.IsDelimiter("0123456789\b",i))
                {
                    lb_modify = false; i = ls_sort.Length();
                }
            }
            if(!lb_modify)
            {
                Application->MessageBox("Столбец сортировки должен иметь цифрорвой формат. Данные не будут сохранены", Application->Title.c_str(), MB_OK | MB_ICONASTERISK);
            }
            else
            {
                ll_sort = StrToInt(ls_sort);
                dmMain->quMain->SQL->Text="BEGIN ryda.departments_pg.ins_p(:par1,:par2,:par3); END;";
                ll_dep = -1;
                StrCopy(lc_dep, StringGridDep->Cells[1][i].c_str());
                dmMain->quMain->ParamByName("par1")->AsString=lc_dep;
                dmMain->quMain->ParamByName("par2")->AsInteger=ll_sort;
                dmMain->quMain->ParamByName("par3")->ParamType=ptOutput;
                dmMain->quMain->ParamByName("par3")->DataType=ftInteger;
                dmMain->quMain->Execute();
                ll_dep=dmMain->quMain->ParamByName("par3")->AsInteger;
                if (ll_dep >0)
                {
                    StringGridDep->Cells[2][i] = IntToStr(ll_dep);
                }
            }
            break;
        case 2 :
            for (int i=1; i<=ls_sort.Length(); i++)
            {
                if(!ls_sort.IsDelimiter("0123456789\b",i))
                {
                    lb_modify = false; i = ls_sort.Length();
                }
            }
            if(!lb_modify)
            {
                Application->MessageBox("Столбец сортировки должен иметь цифрорвой формат. Данные не будут сохранены", Application->Title.c_str(), MB_OK | MB_ICONASTERISK);
            }
            else
            {
                ll_sort = StrToInt(ls_sort);
                dmMain->quMain->SQL->Text="BEGIN ryda.departments_pg.upd_p(:par1,:par2,:par3); END;";
                ll_dep = StrToInt(StringGridDep->Cells[2][i]);
                StrCopy(lc_dep, StringGridDep->Cells[1][i].c_str());
                dmMain->quMain->ParamByName("par1")->AsInteger=ll_dep;
                dmMain->quMain->ParamByName("par2")->AsString=lc_dep;
                dmMain->quMain->ParamByName("par3")->AsInteger=ll_sort;
                dmMain->quMain->Execute();
                lb_modify = true;
            }
            break;
        }
        if  (ll_change>1 && lb_modify)
        {
             dmMain->orases->Commit();
            /*if (curr.execute()==0)
            {
       	        curr.commit();
            }
            else
            {
                dmMain->orases->Rollback();
                curr.getError();
                curr.rollback();
                throw Exception(curr.errortext);
            }   */
            StringGridDep->Cells[3][i] = "1";
        }
    }

    // Удаление
    for (long i=1; i<=il_Count; i++)
    {
        //GRB ADD 16.04.2020 - test trouble ODAC
        dmMain->quMain->Params->Clear();
        //END ADD 
        dmMain->quMain->SQL->Text="BEGIN ryda.departments_pg.del_p(:par1); END;";
        ll_dep = il_Del[i];
        dmMain->quMain->ParamByName("par1")->AsInteger=ll_dep;
        dmMain->quMain->Execute();
        dmMain->orases->Commit();
       // curr.setSource(1,(char*)&ll_dep,sizeof(long),NULL,INT_TYPE);
       /* if (curr.execute()==0)
        {
       	    curr.commit();
        }
        else
        {
            curr.getError();
            curr.rollback();
            throw Exception(curr.errortext);
        } */
    }
    il_Count = 0;
   }catch(Exception &e){
   dmMain ->orases->Rollback();
   Application->ShowException(&e);
   }
}
//---------------------------------------------------------------------------
void __fastcall TfmDepartmens::BitBtn1Click(TObject *Sender)
{
     SaveChanged();
}
//---------------------------------------------------------------------------

void __fastcall TfmDepartmens::BitBtn4Click(TObject *Sender)
{
long CountStr, ll_change, ll_row;
char lc_dep[128];
CountStr = StringGridDep->RowCount - 1;
ll_row = StringGridDep->Row;
il_Count++;
il_Del[il_Count] = StrToInt(StringGridDep->Cells[2][ll_row]);
if  (ll_row > 0)
{
for (long i=ll_row; i<=CountStr; i++)
       {
             StringGridDep->Cells[0][i] = StringGridDep->Cells[0][i+1];
             StringGridDep->Cells[1][i] = StringGridDep->Cells[1][i+1];
             StringGridDep->Cells[2][i] = StringGridDep->Cells[2][i+1];
             StringGridDep->Cells[3][i] = StringGridDep->Cells[3][i+1];
       }
StringGridDep->RowCount = CountStr;
}
}
//---------------------------------------------------------------------------

void __fastcall TfmDepartmens::StringGridDepGetEditText(TObject *Sender,
      int ACol, int ARow, AnsiString &Value)
{
unsigned long l, row;
row = StringGridDep->Row;
l = StrToInt(StringGridDep->Cells[3][row]);
       if  (l==1)
       {
         StringGridDep->Cells[3][row] = "2";
       }
//StringGridDep->Options->GoEditing = true;
}
//---------------------------------------------------------------------------
void __fastcall TfmDepartmens::Retrieve()
{
  stStorDepat StorDep[1000];// Структура для вытяжки хранимых процедур
 // int state;
  unsigned long CountStr = 0;
  // вытягиваем данные
   //GRB ADD 16.04.2020 - test trouble ODAC
   dmMain->quMain->Params->Clear();
   //END ADD 
   dmMain->quMain->SQL->Text="SELECT D.NDEPARTMENT , D.VNAME, D.NSORT FROM RYDA.DEPARTMENTS D ORDER BY D.NSORT";
   dmMain->quMain->Execute();
   int i=0;
   while(!dmMain->quMain->Eof&&i<1000){
   StorDep[i].nDepartment=dmMain->quMain->FieldByName("NDEPARTMENT")->AsInteger;
   strcpy(StorDep[i].vName,dmMain->quMain->FieldByName("VNAME")->AsString.c_str());
   StorDep[i].nSort=dmMain->quMain->FieldByName("NSORT")->AsInteger;
   dmMain->quMain->Next();
   i++;
   }
   CountStr=i;

   if (CountStr > 0)
   {
     StringGridDep->RowCount = CountStr + 1;

       for(unsigned long i=1; i<=CountStr; i++)
       {
             StringGridDep->Cells[1][i] = StorDep[i-1].vName;
             StringGridDep->Cells[0][i] = IntToStr(StorDep[i-1].nSort);
             StringGridDep->Cells[2][i] = IntToStr(StorDep[i-1].nDepartment);
             StringGridDep->Cells[3][i] = "1";
       }
     
   }
   else
   {
             Application->MessageBox("Не существует ни одного подразделения. Будет добавлено новое подразделение", Application->Title.c_str(), MB_OK | MB_ICONASTERISK);
             StringGridDep->Cells[1][1] = "<Новое подразделение>";
             StringGridDep->Cells[0][1] = "99999";
             StringGridDep->Cells[2][1] = "-1";
             StringGridDep->Cells[3][1] = "3";
   }
             StringGridDep->Cells[1][0] = "Наименование подразделения";
             StringGridDep->Cells[0][0] = "Сорт.";
             StringGridDep->Cells[2][0] = "-1";
             StringGridDep->Cells[3][0] = "1";
   il_Count = 0;
}
//---------------------------------------------------------------------------
void __fastcall TfmDepartmens::BitBtn2Click(TObject *Sender)
{
Retrieve();
}
//---------------------------------------------------------------------------
bool __fastcall TfmDepartmens::InsDepartment(long *l_Department, char *c_Department)
{
    il_row = -1;
    if (ShowModal() == mrOk)
    {
        if  (il_row > 0 )
        {
            *l_Department = StrToInt(StringGridDep->Cells[2][il_row]);
            StrCopy(c_Department, StringGridDep->Cells[1][il_row].c_str());
            return true;
        }
    }
    return false;
}
//---------------------------------------------------------------------------


void __fastcall TfmDepartmens::FormCloseQuery(TObject *Sender,
      bool &CanClose)
{
long CountStr, ll_change;
CountStr = StringGridDep->RowCount - 1;
{
for (long i=1; i<=CountStr; i++)
       {
         if (il_Count>0)
         {
          ll_change = 4;
         }
         else
         {
         ll_change = StrToInt(StringGridDep->Cells[3][i]);
         }
         if  (ll_change>1)
         {
                 CanClose = false;
                 int st = Application->MessageBox("Сохранить изменения?", Application->Title.c_str(), MB_YESNOCANCEL | MB_ICONQUESTION);
                 if(st==IDYES)
                 {
                   SaveChanged();
                   CanClose = true;
                 }
                 if(st==IDNO)
                 {
                   CanClose = true;
                   il_row = -1;
                 }
           i = CountStr + 1;
         }
       }
}
}
//---------------------------------------------------------------------------


