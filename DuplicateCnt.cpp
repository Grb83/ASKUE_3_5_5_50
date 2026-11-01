//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "DuplicateCnt.h"
#include "DuplicateCnt_ps_tu.h"
#include "DuplicateCnt_InputParams.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"

TfmDuplicateCnt *fmDuplicateCnt;

/*
Модули:

DuplicatedCnt                                    
DuplicatedCnt_PS_TU
DuplicatedCnt_InputParams

Проект находится тут:
"D:\DATA [Kalak]\Serj\PROJECTS\askueold"

Бэкапы хранятся тут:
"D:\DATA [Kalak]\Serj\PROJECTS\BackUp"

Изменения в проекте:
1. Project/Options/Linker Max stack size: 0x00900000 //для рекурсивных функций
2. Стрелки указывающие напрвления сортировки: bmp/ARW_DN.ico, bmp/ARW_UP.ico
*/

//---------------------------------------------------------------------------
__fastcall TfmDuplicateCnt::TfmDuplicateCnt(TComponent* Owner, AnsiString Name, TAccess a)
        : TMainForm(Owner, Name, a)
{
        ShowAction(iaSave, false);
        ShowAction(iaNew);
        ShowAction(iaParams);
        ShowAction(iaDelete);
        iaCheck->Caption=Reconst_smes14_1;
        bbEdit->Action=iaCheck;
        bbEdit->Hint=Reconst_smes14_2;
        ShowAction(iaCheck);
        PredTopLeft=0;
        SortAsc=true;
}
//---------------------------------------------------------------------------

__fastcall TfmDuplicateCnt::~TfmDuplicateCnt()
{
/*        for(int i=0;i<sgTable->RowCount;i++)
        {
                sgTable->Rows[i]->Clear();
        }
        */
}
//---------------------------------------------------------------------------

void __fastcall TfmDuplicateCnt::FormCreate(TObject *Sender)
{
        SortCol=2;//2 - Дата_начала - сортировка по умолчанию
        SortAsc=true;
        hcHead->Sections->Items[SortCol-1]->ImageIndex=SortAsc;
        vParams((TObject*)(int)1);//первый запуск, если отмена в окне выбора параметров, то закрываем полностью
        FormResize(Sender);
}
//---------------------------------------------------------------------------

void __fastcall TfmDuplicateCnt::FormResize(TObject *Sender)
{
        for(int i=0;i<sgTable->ColCount;i++)
                sgTable->ColWidths[i]=hcHead->Sections->Items[i]->Width-0.5;

}
//---------------------------------------------------------------------------
//синхронизируем ширину столбцов таблицы и заголовка
void __fastcall TfmDuplicateCnt::hcHeadSectionResize(
      THeaderControl *HeaderControl, THeaderSection *Section)
{
        sgTable->ColWidths[Section->Index]=Section->Width-.5;
        hcHead->Width=sgTable->Width;
}
//---------------------------------------------------------------------------

void __fastcall TfmDuplicateCnt::hcHeadSectionClick(
      THeaderControl *HeaderControl, THeaderSection *Section)
{
        //кликнули по заголовку - выбираем по какому столбцу сортировать
        if(SortCol==Section->Index+1)//выбрали тот же столбец - сортировка в обратном напрвлении
        {
                SortAsc=!SortAsc;
                Section->ImageIndex=SortAsc;
        }
        else{//сортируем другой столбец
                hcHead->Sections->Items[SortCol-1]->ImageIndex=-1;
                SortCol=Section->Index+1;
                Section->ImageIndex=1;
                SortAsc=true;//изначально по неубыванию
        }
        vRefresh(this);
}
//---------------------------------------------------------------------------

void __fastcall TfmDuplicateCnt::sgTableKeyDown(TObject *Sender, WORD &Key,
      TShiftState Shift)
{
        if(Access==accRead) return;
        if(Shift==TShiftState())
                switch(Key)
                {
//                        case VK_RETURN: vParams(iaParams); break;
                        case VK_RETURN: vCheck(iaCheck); break;
                        case VK_INSERT: vNew(iaNew); break;
                        case VK_DELETE: vDelete(iaDelete); break;
                }
}
//---------------------------------------------------------------------------

void __fastcall TfmDuplicateCnt::FillTable()
{
          sDupPoints *DupPoints;
          short indic[6];
        for(int i=0;i<sgTable->RowCount;i++)
        {
                sgTable->Rows[i]->Clear();
        }
        sgTable->RowCount=0;

        AnsiString sqlMain="SELECT ryda.util_pg.get_pointname(c.mid, 1)PointName, to_char(c.dstart,'dd.mm.yyyy')dstart, \
                                   to_char(c.dend,'dd.mm.yyyy')DEnd, c.vmemo, \
                                   u.name, to_char(c.denter,'dd.mm.yyyy hh24:mi:ss')Denter, c.mid \
                            FROM ryda.calcbyduplication c, ryda.users u \
                            WHERE mid in (select f.mid from \
                                         (select mid from ryda.points connect by parent = prior mid start with mid = :par1) p, ryda.feeders f \
                                          where p.mid = f.mid and nmainpoint > 0) \
                            and u.user_id = c.user_id";

        //если пользователь выбрал "все записи", то по дате не ищем(иначе не будут находиться пустые поля)
        if(!((strFrom=="01.01.1900")&&(strTo=="31.12.9999")))//for selecting NULL fields
                sqlMain+=" AND c.dstart >= to_date('"+strFrom+"','dd.mm.yyyy') AND c.dend <= to_date('"+strTo+"','dd.mm.yyyy')";


        sqlMain+=" ORDER BY "+IntToStr(SortCol);//сортируем по выбранному столбцу
        if(!SortAsc)sqlMain+=" DESC";//descending sorting

        dmMain->quMain->Params->Clear();
        dmMain->quMain->SQL->Text=sqlMain;
        dmMain->quMain->ParamByName("par1")->AsInteger=RootPoint.Gid;
        dmMain->quMain->Execute();
        int i;
        while(!dmMain->quMain->Eof){
         DupPoints=new sDupPoints;
         ZeroMemory( DupPoints,sizeof(sDupPoints));
         if(!dmMain->quMain->FieldByName("PointName")->IsNull){
          indic[0]=0;
         strcpy(DupPoints->PointName,dmMain->quMain->FieldByName("PointName")->AsString.c_str());}
         else  indic[0]=-1;
         if(!dmMain->quMain->FieldByName("dstart")->IsNull){
          indic[1]=0;
         strcpy(DupPoints->DStart,dmMain->quMain->FieldByName("dstart")->AsString.c_str());}
         else  indic[1]=-1;
         if(!dmMain->quMain->FieldByName("DEnd")->IsNull){
          indic[2]=0;
         strcpy(DupPoints->DEnd,dmMain->quMain->FieldByName("DEnd")->AsString.c_str());}
         else  indic[2]=-1;
         if(!dmMain->quMain->FieldByName("vmemo")->IsNull){
          indic[3]=0;
         strcpy(DupPoints->VMemo,dmMain->quMain->FieldByName("vmemo")->AsString.c_str());}
         else  indic[3]=-1;
         if(!dmMain->quMain->FieldByName("name")->IsNull){
          indic[4]=0;
         strcpy(DupPoints->UserName,dmMain->quMain->FieldByName("name")->AsString.c_str());}
         else  indic[4]=-1;
         if(!dmMain->quMain->FieldByName("Denter")->IsNull){
          indic[5]=0;
         strcpy(DupPoints->Denter,dmMain->quMain->FieldByName("Denter")->AsString.c_str());}
         else  indic[5]=-1;
         DupPoints->mid=dmMain->quMain->FieldByName("mid")->AsInteger;
                        if(indic[0]>=0)sgTable->Cells[0][i] = DupPoints->PointName;
                        if(indic[1]>=0)sgTable->Cells[1][i] = DupPoints->DStart;
                        if(indic[2]>=0)sgTable->Cells[2][i] = DupPoints->DEnd;
                        if(indic[3]>=0)sgTable->Cells[3][i] = DupPoints->VMemo;
                        if(indic[4]>=0)sgTable->Cells[4][i] = DupPoints->UserName;
                        if(indic[5]>=0)sgTable->Cells[5][i] = DupPoints->Denter;

                        sgTable->Objects[0][i] = (TObject*)DupPoints->mid;
                        sgTable->RowCount = sgTable->RowCount+1;
               dmMain->quMain->Next();
               i++;
               }
           TableIsEmpty =!dmMain->quMain->RecordCount;
           dmMain->quMain->Close();
           sgTable->RowCount = sgTable->RowCount-1;
           sgTable->Invalidate();
}

//---------------------------------------------------------------------------
void __fastcall TfmDuplicateCnt::vParams(TObject* Sender)
{
        GROUPDATAFORM sfd;
        sfd.type=0;
        sfd.gid=0;
        TfmDuplicateCnt_InputParams *InPar=new TfmDuplicateCnt_InputParams(this,&sfd);
        InPar->Main();
        InPar->Caption=Reconst_smes14_4;
        if(InPar->ShowModal()==mrOk)
        {
                RootPoint.Gid=InPar->pointPOL->gid;
                RootPoint.Type=((POINTSTREEDEF*)InPar->tvMain->Selected->Data)->Type;
                RootPoint.HaveChild=((POINTSTREEDEF*)InPar->tvMain->Selected->Data)->HaveChild;
                strncpy(RootPoint.Name,((POINTSTREEDEF*)InPar->tvMain->Selected->Data)->Name,148);

                strFrom = InPar->dtpFrom->Date.FormatString("dd.mm.yyyy");
                strTo = InPar->dtpTo->Date.FormatString("dd.mm.yyyy");
                vRefresh(this);
        }
        else
        {
            if((int)Sender==1)
               Close();
        }//если первый запуск, то закрываем окно
        delete InPar;
}
//---------------------------------------------------------------------------

void __fastcall TfmDuplicateCnt::AddEdit(bool onEdit)
{
        TfmDuplicateCnt_PS_TU  *PS_TU = new TfmDuplicateCnt_PS_TU(this);

        if(onEdit)
        {
                if(!TableIsEmpty)
                {
                        PS_TU->edTU->Text = sgTable->Cells[0][sgTable->Row]+
                                " ("+IntToStr((long)(sgTable->Objects[0][sgTable->Row]))+")";
                        try
                        {
                                PS_TU->dtpFrom->Date=StrToDate(sgTable->Cells[1][sgTable->Row]);
                                if(sgTable->Cells[2][sgTable->Row].IsEmpty())
                                {
                                    PS_TU->dtpTo->Date=PS_TU->dtpFrom->Date+1;
                                    PS_TU->chbDateTo->Checked = false;
                                }
                                else
                                {
                                    PS_TU->dtpTo->Date=StrToDate(sgTable->Cells[2][sgTable->Row]);
                                    PS_TU->chbDateTo->Checked = true;
                                }
                        }
                        catch(EConvertError &e)
                        {
                                PS_TU->dtpFrom->Date=Date()-1;
                                PS_TU->dtpTo->Date=Date();
                        }
                        PS_TU->mmComment->Text = sgTable->Cells[3][sgTable->Row];
                        PS_TU->RootPoint.Gid = (long)(sgTable->Objects[0][sgTable->Row]);//мид редактируемой точки
                        PS_TU->RootPoint.Type = 1;
                        strncpy(PS_TU->RootPoint.Name,(sgTable->Cells[0][sgTable->Row]).c_str(),148);//имя редактируемой точки
                }
                else
                {
                   delete PS_TU;
                   throw Exception(Reconst_smes14_5);
                }
        }
        else
        {
                PS_TU->dtpFrom->Date=Date()-1;
                PS_TU->dtpTo->Date=Date();
        }

        if(PS_TU->ShowModal()==mrOk)
        {
                AnsiString sql, sFrom, sTo, sMemo;

                if(PS_TU->chbDateTo->Checked)
                   sql="begin ryda.calcdublicate_pg.add_edit_sw_p(:par1,to_date(:par2,'dd.mm.yyyy'),to_date(:par4,'dd.mm.yyyy'),:par3); end;";
                else
                   sql="begin ryda.calcdublicate_pg.add_edit_sw_p(:par1,to_date(:par2,'dd.mm.yyyy'),NULL,:par3); end;";
                dmMain->quMain->Params->Clear();   
                dmMain->quMain->SQL->Text=sql;
                sFrom = PS_TU->dtpFrom->Date.FormatString("dd.mm.yyyy");
                sTo = PS_TU->dtpTo->Date.FormatString("dd.mm.yyyy");
                sMemo = PS_TU->mmComment->Text;
                dmMain->quMain->ParamByName("par1")->AsInteger=PS_TU->RootPoint.Gid;
                dmMain->quMain->ParamByName("par2")->AsString=sFrom;
                dmMain->quMain->ParamByName("par3")->AsString=sMemo;
                if(PS_TU->chbDateTo->Checked)
                  dmMain->quMain->ParamByName("par4")->AsString=sTo;
                 try{
                 dmMain->quMain->Execute();
                 dmMain->orases->Commit();
                 vRefresh(this);
                }catch(Exception &e){
                  dmMain->orases->Rollback();
                  Application->ShowException(&e);
                }
        }
        delete PS_TU;
}
//---------------------------------------------------------------------------

void __fastcall TfmDuplicateCnt::vSave(TObject* Sender)
{
///for owerload parent form method
}
//---------------------------------------------------------------------------

void __fastcall TfmDuplicateCnt ::vRefresh(TObject* Sender)
{
        int OldRow=sgTable->Row;
        int LeftCol=sgTable->LeftCol;
        FillTable();
        sgTable->Row = OldRow>=sgTable->RowCount?sgTable->RowCount-1:OldRow;
        sgTable->LeftCol=LeftCol;

}
//---------------------------------------------------------------------------

void __fastcall TfmDuplicateCnt::vCheck(TObject* Sender)//Редактировать
{
        AddEdit(true);
}
//---------------------------------------------------------------------------

void __fastcall TfmDuplicateCnt::vNew(TObject* Sender)//Добавить
{
        AddEdit(false);
}
//---------------------------------------------------------------------------

void __fastcall TfmDuplicateCnt::vDelete(TObject* Sender)
{
        int OldRow=sgTable->Row;
        char Date[12];
        strcpy(Date,sgTable->Cells[1][OldRow].c_str());
        long mid;
        if(Application->MessageBox(AnsiString(Reconst_smes14_6+sgTable->Cells[0][OldRow]+
                Reconst_smes14_7+sgTable->Cells[1][OldRow]+
                Reconst_smes14_8+sgTable->Cells[2][OldRow]+"'").c_str()
                ,Application->Title.c_str(),
                MB_YESNO|MB_ICONQUESTION|MB_DEFBUTTON2)==IDYES)
        {
                mid = (long)(sgTable->Objects[0][OldRow]);
                dmMain->quMain->Params->Clear();
                dmMain->quMain->SQL->Text="begin ryda.calcdublicate_pg.del_sw_p(:par1,to_date(:par2,'dd.mm.yyyy')); end;";//mid and date
                dmMain->quMain->ParamByName("par1")->AsInteger=mid;
                dmMain->quMain->ParamByName("par2")->AsString=Date;
                try{
                  dmMain->quMain->Execute();
                  dmMain->orases->Commit();
                  FillTable();
                  sgTable->Row = OldRow>=sgTable->RowCount?sgTable->RowCount-1:OldRow;
                }catch(Exception &e){
                  dmMain->orases->Rollback();
                  Application->ShowException(&e);
                }
        }
        sgTable->SetFocus();
}
//---------------------------------------------------------------------------
//функция синхронизирует столбцы заголовка и таблицы при горизонтальной прокрутке

void __fastcall TfmDuplicateCnt::sgTableTopLeftChanged(TObject *Sender)
{
        PredTopLeft=sgTable->LeftCol;
        for(int i=0;i<PredTopLeft;i++)
                hcHead->Sections->Items[i]->Width=0;
        for(int i=PredTopLeft;i<sgTable->ColCount;i++)
                hcHead->Sections->Items[i]->Width=sgTable->ColWidths[i]+0.5;
}
//---------------------------------------------------------------------------

