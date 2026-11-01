//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#include "unDataMod.h"
#include "unInteriorUni.h"
#include "unGraphMaket.h"
#include "Saa_SelectGroupProc.h"

#include "Reconst.hpp"
#define UNVALUEROW 2
#define FIXEDCOLUMN 4
#include "Main.h"
#define DIGITNUMBER 2 //количество знаков после запятой для данных в многостолбцовом макете. Значения принудительно добиваются до этого

//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "DBAccess"
#pragma link "DBGridEh"
#pragma link "MemDS"
#pragma link "Ora"
#pragma link "PrnDbgeh"
#pragma link "VirtualTable"
#pragma resource "*.dfm"
TfmInteriorUni *fmInteriorUni;
const int receive_maket_30902_col_num = 28;
const int receive_maket_30902_fixed_col_num = 3;

//---------------------------------------------------------------------------
__fastcall TfmInteriorUni::TfmInteriorUni(TComponent* Owner,TFormDescr* aFD)
  : TForm(Owner)
{
  ReplaceRyda(this,BASE_SCHEME,SchemeName);
  FD=aFD;
  modeMaketFM=false;
  modeManyColumn = false;
  MaketF->Visible=false;
  grData->Visible = true;

  ColInfo= new TList();
  RowInfo= new TList();
 // grData->ReadOnly=true;
}
//GRB ADD 22.10.2021
__fastcall TfmInteriorUni::TfmInteriorUni(TComponent* Owner,TFormDescr* aFD, bool _mode30902_receive, TStringList *maket): TForm(Owner)
{

        ReplaceRyda(this,BASE_SCHEME,SchemeName);
        FD=aFD;
        modeMaketFM=false;
        modeManyColumn = false;
        mode30902_receive = true;
        maketRow = maket;
        MaketF->Visible=true;
        MaketF->FixedCols = receive_maket_30902_fixed_col_num;
        MaketF->ColCount = receive_maket_30902_col_num;
        block_size_902 = getBlockSize_902();
        MaketF->RowCount = maketRow->Count-1;
        grData->Visible = false;

        ColInfo= new TList();
        RowInfo= new TList();

}
//---------------------------------------------------------------------------
__fastcall TfmInteriorUni::TfmInteriorUni(TComponent* Owner,TFormDescr* aFD, TStringList* maket, char* maketType, TStringList* maketGroupsInfo, TStringList* cloneMaketGroupsInfo, TStringList* maketListPoints, AnsiString delim)
  : TForm(Owner)
  //конструктор копирования для сформированных/отправленных макетов + выстанавливается признак modeMaketFM новодела
{
        ReplaceRyda(this,BASE_SCHEME,SchemeName);
        FD=aFD;
        ColInfo= new TList();
        RowInfo= new TList();
        grData->Visible = false;
        modeManyColumn = false;
        this->maket = maket;
        strcpy (this->maketType,maketType);
        this->maketGroupsInfo = maketGroupsInfo;
        this->cloneMaketGroupsInfo = cloneMaketGroupsInfo;
        this->maketListPoints = maketListPoints;
        this->delim = delim;
        modeMaketFM=true;
        //TODO Для украинской версии всё это не работает, так как MaketF біло добавлено позже и ссілки на нее в UKR файле НЕТУ!
        MaketF->TopRow = false;
        if (strcmp(maketType, "30917")==0){
          MaketF->RowCount = getRowMaketNum()+1;//c заголовком
          MaketF->ColCount = getColMaket30917Num()+FIXEDCOLUMN;// наименование+тип измерения+код+сумма
          ShowScrollBar(MaketF->Handle, SB_VERT, true);
          ShowScrollBar(MaketF->Handle, SB_HORZ, true);
          MaketF->FixedCols = FIXEDCOLUMN;
        }
        if (strcmp(maketType, "30817")==0){
          MaketF->RowCount = getRowMaketNum()+1;//c заголовком
          MaketF->ColCount = getColMaket30817Num()+FIXEDCOLUMN;// наименование+тип измерения+код+сумма
          ShowScrollBar(MaketF->Handle, SB_VERT, true);
          ShowScrollBar(MaketF->Handle, SB_HORZ, true);
          MaketF->FixedCols = FIXEDCOLUMN;
        }
        if (strcmp(maketType, "30818")==0){
          MaketF->RowCount = getRowMaketNum()+2;//c расширенным заголовком
          MaketF->ColCount = getColMaket30818Num()+FIXEDCOLUMN;// наименование+тип измерения+код+сумма
          ShowScrollBar(MaketF->Handle, SB_VERT, true);
          ShowScrollBar(MaketF->Handle, SB_HORZ, true);
          MaketF->FixedCols = FIXEDCOLUMN;
        }
        //TODO здесь все макеты
        MaketF->Visible=true;
}
__fastcall TfmInteriorUni::TfmInteriorUni(TComponent* Owner,TFormDescr* aFD, int _tableNumbers): TForm(Owner){
  //конструктор для многотабличных(по умолчанию 3 колонки - A+, A-, R+) отчётов + выстанавливается признак modeManyColumn новодела, признак modeMaketFM cбрасывается
        ReplaceRyda(this,BASE_SCHEME,SchemeName);
        FD=aFD;
        ColInfo= new TList();
        RowInfo= new TList();
        grData->Visible = false;
        modeMaketFM=false;
        modeManyColumn = true;
        tableNumbers = _tableNumbers;
        columnNumbers = 25*tableNumbers + (tableNumbers-1)+1; //по умолчанию 3 таблицы по 25 колонок в каждой + дата - итого 78 колонок (+2 пустых между таблицами)
        MaketF->FixedCols = 1;
        //ManForm->MainMenu1->Items->Items[0]->Items[11]->OnClick = SaveTableToFileClick;
        for (int i=0; i < ManForm->MainMenu1->Items->Items[0]->Count; i++){
           if (ManForm->MainMenu1->Items->Items[0]->Items[i]->Name == "SaveMultyTableToFile") 
                ManForm->MainMenu1->Items->Items[0]->Items[i]->OnClick = this->SaveMultyTableToFileClick;
        }
       ManForm->BitBtnNext->Enabled = false;
       ManForm->BitBtnPrevios->Enabled = false;

       //TODO GRB По требованию Кальницкой << >> в отчёте с многотабличной формой, бо одного лишь Enabled здеь и в Monitor.cpp недостаточно, они всё равно активны, надо разобраться, но времени на это нет
       // Побочный эффект - пропадают дальше по всем отчётам (но они там и не нужны).
       ManForm->BitBtnNext->Visible = false;
       ManForm->BitBtnPrevios->Visible = false;

  }

//---------------------------------------------------------------------------
__fastcall TfmInteriorUni::~TfmInteriorUni()
{
  ClearList(ColInfo);
  ClearList(RowInfo);
  delete ColInfo;
  delete RowInfo;
  if(cntColor){
    cntColor=0;
    delete masColor;
  }
  if (modeMaketFM){
  //clearTable2();
  }
  if (modeManyColumn){
  }
  if (mode30902_receive){
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmInteriorUni::split(TStringList* lout, char* str, const char* separator){
    char* _str="";
    strcpy (_str,str);
    for(char* tok = strtok(_str, separator); tok; tok = strtok(NULL, separator)) {
          lout->Add(tok);
      }
      return;
  }
//---------------------------------------------------------------------------
AnsiString __fastcall TfmInteriorUni::getIdPointbyCode30917 (AnsiString code, TStringList* pointsInfo, TStringList* cloneMaketGroupsInfo){
  AnsiString idGroup="";
  AnsiString ret = "-1";
  AnsiString groupCodeToFind = code.SubString (2,code.Length()-3);
  int ntype = atoi (this->maketType);
  if (ntype==30817){
        groupCodeToFind = code.SubString (2,code.Length()-2);
  }
  for (int i = 0 ; i < cloneMaketGroupsInfo->Count; i++){
        String curr = cloneMaketGroupsInfo->Strings[i];
        TStringList* list = new TStringList();
        split (list,curr.c_str(),delim.c_str());
        if (CompareStr(groupCodeToFind, list->Strings[2])==0){
                idGroup = list->Strings[1];
                ret = idGroup;
                for (int j = 0; j <pointsInfo->Count; j++){
                        String currPoint =  pointsInfo->Strings[j];
                        TStringList* point = new TStringList();
                        split (point,currPoint.c_str(),delim.c_str());
                        if (CompareStr(idGroup, point->Strings[2])==0){
                                ret = point->Strings[1];
                                delete point;
                                return ret;
                        }
                        delete point;
                }
                delete list;
                break;
        }
  }
  return ret;
  }
//---------------------------------------------------------------------------
AnsiString __fastcall TfmInteriorUni::getNamebyCode30917 (AnsiString code, TStringList* pointsInfo, TStringList* cloneMaketGroupsInfo){
  AnsiString ret = "-1";
  AnsiString groupCodeToFind = code.SubString (2,code.Length()-3);
  int ntype = atoi (this->maketType);
  if (ntype==30817){
        groupCodeToFind = code.SubString (2,code.Length()-2);
  }
  for (int i = 0 ; i < cloneMaketGroupsInfo->Count; i++){
        String curr = cloneMaketGroupsInfo->Strings[i];
        TStringList* list = new TStringList();
        split (list,curr.c_str(),delim.c_str());
        if (CompareStr(groupCodeToFind, list->Strings[2])==0){
                ret = list->Strings[0];
                delete list;
                break;
        }
  }
  return ret;
}
//---------------------------------------------------------------------------

int __fastcall TfmInteriorUni::getRowMaketNum(){   //сколько строчек в макете 30917 с данными, которые нам нужно отображать
   int res = (this->maket->Count)-UNVALUEROW;
   return res;
}

//---------------------------------------------------------------------------
int __fastcall TfmInteriorUni::getColMaket30917Num(){   //сколько столбцов в макете 30917 с данными, которые нам нужно отображать
   int res = 48; //TODO найти сколько на самом деле ( длинна строки с данными из макета)
   return res;
}
//---------------------------------------------------------------------------
int __fastcall TfmInteriorUni::getColMaket30817Num(){
   int res = 24; //TODO найти сколько на самом деле ( длинна строки с данными из макета)
   return res;
}
//---------------------------------------------------------------------------
int __fastcall TfmInteriorUni::getColMaket30818Num(){
   int res = 4; //TODO найти сколько на самом деле ( длинна строки с данными из макета)
   return res;
}
//---------------------------------------------------------------------------
void __fastcall TfmInteriorUni::formingMaket(){   //Выводим первую строку с обозначениями
        {//30817-30917 -30818
        printMaketHeader();
        if (printMaketData2())
                printMaketValues();
        fAutoSizeColSG (MaketF);
        }
}
//---------------------------------------------------------------------------
void __fastcall TfmInteriorUni::printMaketHeader(){
char str[200];
if (strcmp(maketType, "30818")==0){
   MaketF->Cells[0][1] = "Наименовaние";
   MaketF->Cells[1][1] = "Тип изм.";
   MaketF->Cells[2][1] = "КОД";
   MaketF->Cells[3][1] = "СУММА";
   strcpy(str,"Показания по тарифу");
   for (int i = FIXEDCOLUMN ; i<8; i++)
        MaketF->Cells[i][0] = str;
   strcpy(str,"A");
   MaketF->Cells[4][1] = str;
   strcpy(str,"B");
   MaketF->Cells[5][1] = str;
   strcpy(str,"C");
   MaketF->Cells[6][1] = str;
   strcpy(str,"D");
   MaketF->Cells[7][1] = str;
}
if (strcmp(maketType, "30817")==0){
   strcpy(str,"Наименование");
   MaketF->Cells[0][0] = str;
   strcpy(str,"Тип изм.");
   MaketF->Cells[1][0] = str;
   strcpy(str,"КОД");
   MaketF->Cells[2][0] = str;
   strcpy(str,"СУММА");
   MaketF->Cells[3][0] = str;
   for (int i = 1; i <= 24; i++){
     strcpy (str, itoa(i,str,10));
     strcat (str,":00");
     MaketF->Cells[i+3][0] = str;
   }
}
if (strcmp(maketType, "30917")==0){
   strcpy(str,"Наименование");
   MaketF->Cells[0][0] = str;
   strcpy(str,"Тип изм.");
   MaketF->Cells[1][0] = str;
   strcpy(str,"КОД");
   MaketF->Cells[2][0] = str;
   strcpy(str,"СУММА");
   MaketF->Cells[3][0] = str;
   strcpy(str,"00:30");
   MaketF->Cells[4][0] = str;
   strcpy(str,"01:00");
   MaketF->Cells[5][0] = str;
   strcpy(str,"01:30");
   MaketF->Cells[6][0] = str;
   strcpy(str,"02:00");
   MaketF->Cells[7][0] = str;
   strcpy(str,"02:30");
   MaketF->Cells[8][0] = str;
   strcpy(str,"03:00");
   MaketF->Cells[9][0] = str;
   strcpy(str,"03:30");
   MaketF->Cells[10][0] = str;
   strcpy(str,"04:00");
   MaketF->Cells[11][0] = str;
   strcpy(str,"04:30");
   MaketF->Cells[12][0] = str;
   strcpy(str,"05:00");
   MaketF->Cells[13][0] = str;
   strcpy(str,"05:30");
   MaketF->Cells[14][0] = str;
   strcpy(str,"06:00");
   MaketF->Cells[15][0] = str;
   strcpy(str,"06:30");
   MaketF->Cells[16][0] = str;
   strcpy(str,"07:00");
   MaketF->Cells[17][0] = str;
   strcpy(str,"07:30");
   MaketF->Cells[18][0] = str;
   strcpy(str,"08:00");
   MaketF->Cells[19][0] = str;
   strcpy(str,"08:30");
   MaketF->Cells[20][0] = str;
   strcpy(str,"09:00");
   MaketF->Cells[21][0] = str;
   strcpy(str,"09:30");
   MaketF->Cells[22][0] = str;
   strcpy(str,"10:00");
   MaketF->Cells[23][0] = str;
   strcpy(str,"10:30");
   MaketF->Cells[24][0] = str;
   strcpy(str,"11:00");
   MaketF->Cells[25][0] = str;
   strcpy(str,"11:30");
   MaketF->Cells[26][0] = str;
   strcpy(str,"12:00");
   MaketF->Cells[27][0] = str;
   strcpy(str,"12:30");
   MaketF->Cells[28][0] = str;
   strcpy(str,"13:00");
   MaketF->Cells[29][0] = str;
   strcpy(str,"13:30");
   MaketF->Cells[30][0] = str;
   strcpy(str,"14:00");
   MaketF->Cells[31][0] = str;
   strcpy(str,"14:30");
   MaketF->Cells[32][0] = str;
   strcpy(str,"15:00");
   MaketF->Cells[33][0] = str;
   strcpy(str,"15:30");
   MaketF->Cells[34][0] = str;
   strcpy(str,"16:00");
   MaketF->Cells[35][0] = str;
   strcpy(str,"16:30");
   MaketF->Cells[36][0] = str;
   strcpy(str,"17:00");
   MaketF->Cells[37][0] = str;
   strcpy(str,"17:30");
   MaketF->Cells[38][0] = str;
   strcpy(str,"18:00");
   MaketF->Cells[39][0] = str;
   strcpy(str,"18:30");
   MaketF->Cells[40][0] = str;
   strcpy(str,"19:00");
   MaketF->Cells[41][0] = str;
   strcpy(str,"19:30");
   MaketF->Cells[42][0] = str;
   strcpy(str,"20:00");
   MaketF->Cells[43][0] = str;
   strcpy(str,"20:30");
   MaketF->Cells[44][0] = str;
   strcpy(str,"21:00");
   MaketF->Cells[45][0] = str;
   strcpy(str,"21:30");
   MaketF->Cells[46][0] = str;
   strcpy(str,"22:00");
   MaketF->Cells[47][0] = str;
   strcpy(str,"22:30");
   MaketF->Cells[48][0] = str;
   strcpy(str,"23:00");
   MaketF->Cells[49][0] = str;
   strcpy(str,"23:30");
   MaketF->Cells[50][0] = str;
   strcpy(str,"24:00");
   MaketF->Cells[51][0] = str;
   }
} 
//---------------------------------------------------------------------------
bool __fastcall TfmInteriorUni::printMaketData2(){
  bool ret = true;
  if ((strcmp(maketType, "30917")==0)||(strcmp(maketType, "30817")==0)){
   char str[200];
   strcpy(str,"Наименование");
   MaketF->Cells[0][0] = str;
   strcpy(str,"Тип изм.");
   MaketF->Cells[1][0] = str;
   strcpy(str,"КОД");
   MaketF->Cells[2][0] = str;
   strcpy(str,"СУММА");
   MaketF->Cells[3][0] = str;

   if (strcmp(maketType, "30817")==0){
     for (int i = 1; i <= 24; i++){
        strcpy (str, itoa(i,str,10));
        strcat (str,":00");
        MaketF->Cells[i+3][0] = str;
    }
   }else{

   //30917
   strcpy(str,"00:30");
   MaketF->Cells[4][0] = str;
   strcpy(str,"01:00");
   MaketF->Cells[5][0] = str;
   strcpy(str,"01:30");
   MaketF->Cells[6][0] = str;
   strcpy(str,"02:00");
   MaketF->Cells[7][0] = str;
   strcpy(str,"02:30");
   MaketF->Cells[8][0] = str;
   strcpy(str,"03:00");
   MaketF->Cells[9][0] = str;
   strcpy(str,"03:30");
   MaketF->Cells[10][0] = str;
   strcpy(str,"04:00");
   MaketF->Cells[11][0] = str;
   strcpy(str,"04:30");
   MaketF->Cells[12][0] = str;
   strcpy(str,"05:00");
   MaketF->Cells[13][0] = str;
   strcpy(str,"05:30");
   MaketF->Cells[14][0] = str;
   strcpy(str,"06:00");
   MaketF->Cells[15][0] = str;
   strcpy(str,"06:30");
   MaketF->Cells[16][0] = str;
   strcpy(str,"07:00");
   MaketF->Cells[17][0] = str;
   strcpy(str,"07:30");
   MaketF->Cells[18][0] = str;
   strcpy(str,"08:00");
   MaketF->Cells[19][0] = str;
   strcpy(str,"08:30");
   MaketF->Cells[20][0] = str;
   strcpy(str,"09:00");
   MaketF->Cells[21][0] = str;
   strcpy(str,"09:30");
   MaketF->Cells[22][0] = str;
   strcpy(str,"10:00");
   MaketF->Cells[23][0] = str;
   strcpy(str,"10:30");
   MaketF->Cells[24][0] = str;
   strcpy(str,"11:00");
   MaketF->Cells[25][0] = str;
   strcpy(str,"11:30");
   MaketF->Cells[26][0] = str;
   strcpy(str,"12:00");
   MaketF->Cells[27][0] = str;
   strcpy(str,"12:30");
   MaketF->Cells[28][0] = str;
   strcpy(str,"13:00");
   MaketF->Cells[29][0] = str;
   strcpy(str,"13:30");
   MaketF->Cells[30][0] = str;
   strcpy(str,"14:00");
   MaketF->Cells[31][0] = str;
   strcpy(str,"14:30");
   MaketF->Cells[32][0] = str;
   strcpy(str,"15:00");
   MaketF->Cells[33][0] = str;
   strcpy(str,"15:30");
   MaketF->Cells[34][0] = str;
   strcpy(str,"16:00");
   MaketF->Cells[35][0] = str;
   strcpy(str,"16:30");
   MaketF->Cells[36][0] = str;
   strcpy(str,"17:00");
   MaketF->Cells[37][0] = str;
   strcpy(str,"17:30");
   MaketF->Cells[38][0] = str;
   strcpy(str,"18:00");
   MaketF->Cells[39][0] = str;
   strcpy(str,"18:30");
   MaketF->Cells[40][0] = str;
   strcpy(str,"19:00");
   MaketF->Cells[41][0] = str;
   strcpy(str,"19:30");
   MaketF->Cells[42][0] = str;
   strcpy(str,"20:00");
   MaketF->Cells[43][0] = str;
   strcpy(str,"20:30");
   MaketF->Cells[44][0] = str;
   strcpy(str,"21:00");
   MaketF->Cells[45][0] = str;
   strcpy(str,"21:30");
   MaketF->Cells[46][0] = str;
   strcpy(str,"22:00");
   MaketF->Cells[47][0] = str;
   strcpy(str,"22:30");
   MaketF->Cells[48][0] = str;
   strcpy(str,"23:00");
   MaketF->Cells[49][0] = str;
   strcpy(str,"23:30");
   MaketF->Cells[50][0] = str;
   strcpy(str,"24:00");
   MaketF->Cells[51][0] = str;
   }
   TStringList* NCID = new TStringList();
   for (int i = 0; i<maketListPoints->Count; i++){ //имена групп, показатели, id
      String rowParameters = maketListPoints->Strings[i];
      split (NCID,rowParameters.c_str(),delim.c_str());
   }
   for (int j = 1; j<maket->Count-1; j++){ //собственно данные
      String rowMaket = maket->Strings[j];
      TStringList* rowData = new TStringList();
      split (rowData,rowMaket.c_str(), ":");
      String rowType;
      for (int k = 0; k<3; k++){
        switch (k){
          case 0:{
          try{
          rowType = rowData->Strings[0];
          MaketF->Cells[k][j] = getNamebyCode30917 (rowType,NCID,cloneMaketGroupsInfo);
          break;
          }catch (Exception &ex){
          ;
          }
          }
          case 1:{
          try{
          rowType = rowData->Strings[0];
          AnsiString tst = rowType;
          tst.Delete(tst.Length(),1); //удаляем скобки по бокам
          tst.Delete(1,1);
          AnsiString codeNum="1";
          codeNum = tst.SubString(tst.Length(),1);
          bool noValidCode = true;
          if (CompareStr(codeNum,"1")==0){
                MaketF->Cells[1][j]="A+";
                noValidCode = false;
          }
          if (CompareStr(codeNum,"2")==0){
                MaketF->Cells[1][j]="A-";
                noValidCode = false;
          }
          if (CompareStr(codeNum,"3")==0) {
                MaketF->Cells[1][j]="R+";
                noValidCode = false;
          }
          if (CompareStr(codeNum,"4")==0) {
                MaketF->Cells[1][j]="R-";
                noValidCode = false;
          }
          if (noValidCode) {
                /*char strNum[5];
                itoa(j+1,strNum,10);
                AnsiString msg = "Встретился невалидный код показателя " + tst+ " в "+ strNum+"-й строке макета";
                Application->MessageBox(msg.c_str(),"Ошибка при при разборе макета ",MB_ICONERROR);
                return false;*/
                MaketF->Cells[1][j]="";
          }
        }catch (Exception &ex){;}
        }
          case 2:{
          try{
          rowType = rowData->Strings[0];
          //MaketF->Cells[2][j] = getIdPointbyCode30917 (rowType,maketListPoints,cloneMaketGroupsInfo);
          AnsiString tst = rowType;
          tst = rowType.SubString(2,tst.Length()-2);
          MaketF->Cells[2][j] = tst;
          break;
         }catch (Exception &ex){
         ;
         }
         }
      }
      }
      delete rowData;
   }
   delete NCID;
 }//30917+30817
  if (strcmp(maketType, "30818")==0){
   char str[200];
   MaketF->Cells[0][1] = "Наименовaние";
   MaketF->Cells[1][1] = "Тип изм.";
   MaketF->Cells[2][1] = "КОД";
   MaketF->Cells[3][1] = "СУММА";
   strcpy(str,"Показания по тарифу");
   for (int i = FIXEDCOLUMN ; i<8; i++)
        MaketF->Cells[i][0] = str;
   strcpy(str,"A");
   MaketF->Cells[4][1] = str;
   strcpy(str,"B");
   MaketF->Cells[5][1] = str;
   strcpy(str,"C");
   MaketF->Cells[6][1] = str;
   strcpy(str,"D");
   MaketF->Cells[7][1] = str;
   TStringList* NCID = new TStringList();
   for (int i = 0; i<maketListPoints->Count; i++){ //имена групп, показатели, id
      String rowParameters = maketListPoints->Strings[i];
      split (NCID,rowParameters.c_str(),delim.c_str());
   }
   //try{
   for (int j = 1; j<maket->Count-1; j++){ //собственно данные
      String rowMaket = maket->Strings[j];
      TStringList* rowData = new TStringList();
      split (rowData,rowMaket.c_str(), ":");
      String rowType;
      for (int k = 0; k<3; k++){
        switch (k){
          case 0:{
		  try{
          rowType = rowData->Strings[0];
          MaketF->Cells[k][j+1] = getNamebyCode30917 (rowType,NCID,cloneMaketGroupsInfo);
          break;
		  }catch (Exception &ex){;} 
          }
          case 1:{
		  try{
          rowType = rowData->Strings[0];
          AnsiString tst = rowType;
          tst.Delete(tst.Length(),1); //удаляем скобки по бокам
          tst.Delete(1,1);
          AnsiString codeNum="1";
          codeNum = tst.SubString(tst.Length(),1);
          bool noValidCode = true;
          if (CompareStr(codeNum,"1")==0){
                MaketF->Cells[1][j+1]="A+";
                noValidCode = false;
          }
          if (CompareStr(codeNum,"2")==0){
                MaketF->Cells[1][j+1]="A-";
                noValidCode = false;

          }
          if (CompareStr(codeNum,"3")==0) {
                MaketF->Cells[1][j+1]="Q1";
                noValidCode = false;
          }
          if (CompareStr(codeNum,"4")==0) {
                MaketF->Cells[1][j+1]="Q2";
                noValidCode = false;
          }
          if (CompareStr(codeNum,"5")==0) {
                MaketF->Cells[1][j+1]="Q3";
                noValidCode = false;
          }
          if (CompareStr(codeNum,"6")==0) {
                MaketF->Cells[1][j+1]="Q4";
                noValidCode = false;
          }
          if (noValidCode) {
                /*char strNum[5];
                itoa(j+1,strNum,10);
                AnsiString msg = "Встретился невалидный код показателя " + tst+ " в "+ strNum+"-й строке макета";
                Application->MessageBox(msg.c_str(),"Ошибка при при разборе макета ",MB_ICONERROR);
                return false; */
                MaketF->Cells[1][j+1]="";
          }
		}catch (Exception &ex){;}
        }
          case 2:{
          try{
		  rowType = rowData->Strings[0];
          //MaketF->Cells[2][j+1] = getIdPointbyCode30917 (rowType,maketListPoints,cloneMaketGroupsInfo);
          AnsiString tst = rowType;
          tst = rowType.SubString(2,tst.Length()-2);
          MaketF->Cells[2][j+1] = tst;
          break;
         }catch (Exception &ex){;}
		 }
      }
      }
      delete rowData;
   }
   delete NCID;
  }
  return ret;
}

//---------------------------------------------------------------------------
void __fastcall TfmInteriorUni::printMaketValues(){
  for (int j = 1; j<maket->Count-1; j++){ //собственно данные
      String rowMaket = maket->Strings[j];
      TStringList* rowData = new TStringList();
      split (rowData,rowMaket.c_str(), ":");
      String rowType;
      for (int k = 3; k<rowData->Count+2; k++){
         rowType = rowData->Strings[k-2];
         if (strcmp(maketType, "30818")==0){ //на строчку ниже выводим из-за расширенного заголовка
                MaketF->Cells[k][j+1] = rowType;//собственно значения
         }else
         MaketF->Cells[k][j] = rowType;//собственно значения
      }
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmInteriorUni::clearTable()
{
  for (int i=0; i < MaketF->ColCount; i++) {
    MaketF->Cols[i]->Clear();
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmInteriorUni::clearTable2()
{
for(int i = 0; i < MaketF->ColCount; i++)
        for(int j = 0; j < MaketF->RowCount; j++)
                MaketF->Cells[i][j] = "";
}
//---------------------------------------------------------------------------
void __fastcall TfmInteriorUni::fAutoSizeColSG(TStringGrid * StringGrid){
int iTempColSize = 0;
  int iMaxColSize = 0;
  for (int j = 0; j <= StringGrid->ColCount - 1; j++) {
        for (int i = 0; i <= StringGrid->RowCount - 1; i++) {
            iTempColSize = StringGrid->Canvas->TextWidth (StringGrid->Cells[j][i]);
            if (iTempColSize > iMaxColSize) {
                iMaxColSize = iTempColSize;
            }
        }

        if (iMaxColSize == 0) {
            StringGrid->ColWidths[j] = 125;
        }
        else {
            StringGrid->ColWidths[j] = iMaxColSize +
                StringGrid->GridLineWidth + 10;
        }
        iTempColSize = 0;
        iMaxColSize = 0;
  }
}

//---------------------------------------------------------------------------
void __fastcall TfmInteriorUni::ClearList(TList * l)
{
  for(int i=0;i<l->Count;i++)
    delete (TFieldS*)l->Items[i];
  l->Clear();
}
//---------------------------------------------------------------------------
void __fastcall TfmInteriorUni::vRefresh(TObject *Sender)
{
  //GRB ADD - Многотабличный отчёт для Житомира
  if (modeManyColumn){
        vRefreshTriada (Sender);
        return;
  }
  TColumnEh *grColumn;
  TFieldDefs *pDefs = vtData->FieldDefs;
  TFieldDef *pDef=NULL;
  TFieldS *fInf;
  if (!modeMaketFM){
  try{
    //сбрасываем обработчики
    isExistsMaket=false;
    vtData->OnNewRecord=NULL;
    vtData->AfterEdit=NULL;
    vtData->AfterPost=NULL;
    vtData->AfterScroll=NULL;
    vtData->DisableControls();
    //Чистим старое
    ClearList(ColInfo);
    ClearList(RowInfo);
    if(cntColor){
      cntColor=0;
      delete masColor;
    }
    grData->Columns->BeginUpdate();
    grData->FrozenCols=0;
    grData->FooterRowCount=0;
    grData->Columns->Clear();
    vtData->Close();
    vtData->Clear();
    vtData->DeleteFields();
    vtData->Open();
    //Вычитываем струкуру таблицы
    oqMaketInfoCol->Close();
    oqMaketInfoCol->ParamByName("nfid")->AsInteger=FD->IdFormTree;
    oqMaketInfoCol->ParamByName("nispoint")->AsInteger=FD->IsPoints;
    oqMaketInfoCol->ParamByName("nid")->AsInteger=FD->IdGroup;
    oqMaketInfoCol->ParamByName("dfrom")->AsDateTime=FD->dateTimePar;
    oqMaketInfoCol->ParamByName("dtill")->AsDateTime=FD->dateTime;
    oqMaketInfoCol->ParamByName("taddparam")->Length=FDADDPARAMSIZE;
    for(int i=0;i<FDADDPARAMSIZE;i++){
      oqMaketInfoCol->ParamByName("taddparam")->ItemAsString[i+1]=FD->FAddParam[i];
    }
    oqMaketInfoCol->Execute();
    Dt1=oqMaketInfoCol->ParamByName("dfrom")->AsDateTime;
    Dt2=oqMaketInfoCol->ParamByName("dtill")->AsDateTime;
   
    FixColCount=oqMaketInfoCol->ParamByName("ncnfixcol")->AsInteger;
    TitleCount=oqMaketInfoCol->ParamByName("ncntitle")->AsInteger;
    FooterCount=oqMaketInfoCol->ParamByName("ncnfooter")->AsInteger;
    int z=0;
    while(!oqMaketInfoCol->Eof){
      AnsiString S;
      z++;
      if(z>ColInfo->Capacity)
        ColInfo->Capacity+=50;
      //Заполним структуру
      fInf=new TFieldS;
      ColInfo->Add(fInf);
      fInf->id=oqMaketInfoCol->FieldByName("id")->AsInteger;
      for(int i=0;i<TitleCount;i++)
        fInf->Title->Add(oqMaketInfoCol->FieldByName("Title"+IntToStr(i+1))->AsString);
      fInf->TitleCl=(TColor)oqMaketInfoCol->FieldByName("TitleCl")->AsInteger;
      fInf->TitleAl=(TAlignment)oqMaketInfoCol->FieldByName("TitleAl")->AsInteger;
      fInf->DataCl=(TColor)oqMaketInfoCol->FieldByName("DataCl")->AsInteger;
      fInf->DataAl=(TAlignment)oqMaketInfoCol->FieldByName("DataAl")->AsInteger;
      fInf->nlock=oqMaketInfoCol->FieldByName("nlock")->AsInteger;
      fInf->nwidth=oqMaketInfoCol->FieldByName("nwidth")->AsInteger;
      strcpy(fInf->sMasks,oqMaketInfoCol->FieldByName("vmasks")->AsString.c_str());
      //А теперь Grid
      grColumn=grData->Columns->Add();
      grColumn->Tag=z-1;//Запоминаем порядок (а то колонки поменяют)
      grColumn->FieldName="Field"+IntToStr(z);
      for(int i=0;i<TitleCount;i++){
        if(i&&!fInf->Title->Strings[i].IsEmpty())
          S=S+"|";
        S=S+fInf->Title->Strings[i];
      }
      grColumn->Title->Caption=S;
      grColumn->Title->Color=fInf->TitleCl;
      grColumn->Title->Alignment=fInf->TitleAl;
      if(fInf->nwidth>0)
        grColumn->Width=fInf->nwidth;
      grColumn->Color=fInf->DataCl;
      grColumn->Alignment=fInf->DataAl;
      grColumn->ReadOnly=fInf->nlock;
      oqMaketInfoCol->Next();
    }
    if(grData->Columns->Count>FixColCount)
      grData->FrozenCols=FixColCount;

    grData->FooterRowCount=FooterCount;

    oqMaketInfoRow->Close();
    oqMaketInfoRow->Cursor=oqMaketInfoCol->ParamByName("row_t")->AsCursor;
    oqMaketInfoRow->Execute();
    z=0;
    while(!oqMaketInfoRow->Eof){
      z++;
      if(z>RowInfo->Capacity)
        RowInfo->Capacity+=50;
      //Заполним структуру
      fInf=new TFieldS;
      RowInfo->Add(fInf);
      fInf->id=oqMaketInfoRow->FieldByName("id")->AsInteger;
      for(int i=0;i<FixColCount;i++)
        fInf->Title->Add(oqMaketInfoRow->FieldByName("Title"+IntToStr(i+1))->AsString);
      fInf->DataCl=(TColor)oqMaketInfoRow->FieldByName("DataCl")->AsInteger;
      fInf->nlock=oqMaketInfoRow->FieldByName("nlock")->AsInteger;
      strcpy(fInf->sMasks,oqMaketInfoRow->FieldByName("vmasks")->AsString.c_str());
      oqMaketInfoRow->Next();
    }
    oqMaketInfoRow->Close();
    oqMaketInfoCol->ParamByName("row_t")->AsCursor->FreeCursor();
    oqMaketInfoCol->Close();
    //Теперь структура таблицы
    pDef = pDefs->AddFieldDef();
    pDef->DataType = ftInteger;
    pDef->Name = "id";
    pDef->DisplayName="id";
    pDef = pDefs->AddFieldDef();
    pDef->DataType = ftInteger;
    pDef->Name = "num";
    pDef->DisplayName="num";
    for(int i=0; i<ColInfo->Count; i++){
      pDef = pDefs->AddFieldDef();
      if(i<FixColCount){
        pDef->DataType = ftString;
        pDef->Size = 256;
      }else{
        pDef->DataType = ftFloat;
      }
      pDef->Name = "Field"+IntToStr(i+1);
      pDef->DisplayName="Field"+IntToStr(i+1);
    }
    //Теперь данные
    isExistsMaket=(RowInfo->Count*(ColInfo->Count-FixColCount)>0);
    if(isExistsMaket){//Не пустой макет
      //Заполним масив цветов
      CreateColorMass();
      //Ну а теперь данные
      oqVal->Close();
      oqVal->ParamByName("nfid")->AsInteger=FD->IdFormTree;
      oqVal->ParamByName("nispoint")->AsInteger=FD->IsPoints;
      oqVal->ParamByName("nid")->AsInteger=FD->IdGroup;
      oqVal->ParamByName("dfrom")->AsDateTime=FD->dateTimePar;
      oqVal->ParamByName("dtill")->AsDateTime=FD->dateTime;
      oqVal->ParamByName("data_t")->Length=RowInfo->Count*(ColInfo->Count-FixColCount);
      oqVal->Execute();
      QuantityStr="";
      QuantityStr=oqVal->ParamByName("quantity")->AsString;
      //added by KAG 28.12.2009
      Dt3 = oqVal->ParamByName("forming_data")->AsDateTime;
      z=0;
      int cnt_footer=(ColInfo->Count-FixColCount)*FooterCount;
      for(int i=0;i<oqVal->ParamByName("data_t")->Length-cnt_footer;i++){
        if(!(i%(ColInfo->Count-FixColCount))){
          if(vtData->State==dsInsert||vtData->State==dsEdit)
            vtData->Post();
          vtData->Append();
          vtData->FieldByName("id")->AsInteger=((TFieldS*)RowInfo->Items[z])->id;
          vtData->FieldByName("num")->AsInteger=z;
          for(int k=0;k<FixColCount;k++){
            vtData->FieldByName("Field"+IntToStr(k+1))->AsString=((TFieldS*)RowInfo->Items[z])->Title->Strings[k];
          }
          z++;
        }
        if(!oqVal->ParamByName("data_t")->ItemIsNull[i+1])
          vtData->FieldByName("Field"+IntToStr(1+FixColCount+i%(ColInfo->Count-FixColCount)))->AsFloat=oqVal->ParamByName("data_t")->ItemAsFloat[i+1];
      }
      if(vtData->State==dsInsert||vtData->State==dsEdit)
        vtData->Post();
      for(int i=oqVal->ParamByName("data_t")->Length-cnt_footer;i<oqVal->ParamByName("data_t")->Length;i++){
        long Col=FixColCount+i%(ColInfo->Count-FixColCount);
        long Row=i/(ColInfo->Count-FixColCount);
        TFieldS *cInfo=(TFieldS *)ColInfo->Items[Col];
        TFieldS *rInfo=(TFieldS *)RowInfo->Items[Row];
        if(Col==FixColCount){
          for(int k=0;k<FixColCount;k++){
            TColumnFooterEh *lcf_footer;
            lcf_footer = grData->Columns->Items[k]->Footers->Add();
            lcf_footer->ValueType = fvtStaticText;
            lcf_footer->Value = ((TFieldS*)RowInfo->Items[Row])->Title->Strings[k];
            lcf_footer->Alignment = ((TFieldS*)ColInfo->Items[k])->TitleAl;
            lcf_footer->Color = ((TFieldS*)ColInfo->Items[k])->TitleCl;
            lcf_footer->Font->Style = TFontStyles() << fsBold;
          }
        }

        TColumnFooterEh *lcf_footer;
        lcf_footer = grData->Columns->Items[Col]->Footers->Add();
        lcf_footer->ValueType = fvtStaticText;
        if(!oqVal->ParamByName("data_t")->ItemIsNull[i+1])
          lcf_footer->Value = FormatByMask(cInfo->sMasks,rInfo->sMasks,oqVal->ParamByName("data_t")->ItemAsFloat[i+1]);
        else
          lcf_footer->Value = "";
        if(cInfo->DataAl != alLeft)
          lcf_footer->Alignment = cInfo->DataAl;
        else
          lcf_footer->Alignment = rInfo->DataAl;
        if(rInfo->DataCl != clWhite)
          lcf_footer->Color =rInfo->DataCl;
        else
          lcf_footer->Color = cInfo->DataCl;
        lcf_footer->Font->Style = TFontStyles() << fsBold;
      }
      oqVal->Close();
    }else{
      if(RowInfo->Count>0&&ColInfo->Count>0&&ColInfo->Count==FixColCount){
        for(z=0;z<RowInfo->Count;z++){
            vtData->Append();
            vtData->FieldByName("id")->AsInteger=((TFieldS*)RowInfo->Items[z])->id;
            vtData->FieldByName("num")->AsInteger=z;
            for(int k=0;k<FixColCount;k++){
              vtData->FieldByName("Field"+IntToStr(k+1))->AsString=((TFieldS*)RowInfo->Items[z])->Title->Strings[k];
            }
            vtData->Post();
        }

      }
    }
    grData->Columns->EndUpdate();
    vtData->OnNewRecord=vtDataNewRecord;
    vtData->AfterEdit=vtDataAfterEdit;
    vtData->AfterPost=vtDataAfterPost;
    vtData->AfterScroll=vtDataAfterScroll;
    vtData->First();
    vtData->EnableControls();
    SendUpdateMessage();
  }catch(Exception &e){
    vtData->EnableControls();
    Application->ShowException(&e);
  }
  }//старые добрые макеты и uppd - не трогаем
  else{ //новодел начинается тут
      if ((strcmp(maketType, "30917")==0)||(strcmp(maketType, "30817")==0)||(strcmp(maketType, "30818")==0)){
        formingMaket();
      }//конец макетов 30817-30917
  }
}
void __fastcall TfmInteriorUni::vRefreshTriada(TObject *Sender){
   printHeaderManyColumn();
   printDataManyColumn();
}

//---------------------------------------------------------------------------
void __fastcall TfmInteriorUni::RefreshData(TObject *Sender)
{
  TBookmark SavePlace;
  try{
    SavePlace = vtData->GetBookmark();
    vtData->OnNewRecord=NULL;
    vtData->AfterEdit=NULL;
    vtData->AfterPost=NULL;
    vtData->AfterScroll=NULL;
    vtData->DisableControls();
    //Заполним масив цветов
    CreateColorMass();
    //Ну а теперь данные
    oqVal->Close();
    oqVal->ParamByName("nfid")->AsInteger=FD->IdFormTree;
    oqVal->ParamByName("nispoint")->AsInteger=FD->IsPoints;
    oqVal->ParamByName("nid")->AsInteger=FD->IdGroup;
    oqVal->ParamByName("dfrom")->AsDateTime=FD->dateTimePar;
    oqVal->ParamByName("dtill")->AsDateTime=FD->dateTime;
    oqVal->ParamByName("data_t")->Length=RowInfo->Count*(ColInfo->Count-FixColCount);
    oqVal->Execute();
    int z=0;
    vtData->First();
    while(!vtData->Eof){
      if(z+1>oqVal->ParamByName("data_t")->Length){//Если структура макета изменилась
//SAA        PostMessage(ParentForm->Handle,WM_REFRESHFORM, NULL,NULL);
        return;
      }
      vtData->Edit();
      for(int k=0;k<ColInfo->Count-FixColCount;k++){
        if(!oqVal->ParamByName("data_t")->ItemIsNull[z+1])
          vtData->FieldByName("Field"+IntToStr(1+FixColCount+k))->AsFloat=oqVal->ParamByName("data_t")->ItemAsFloat[z+1];
        else
          vtData->FieldByName("Field"+IntToStr(1+FixColCount+k))->Clear();
        z++;
      }
      vtData->Next();
    }
    int f_num=0;
    for(int i=z;i<oqVal->ParamByName("data_t")->Length;i++){
      long Col=FixColCount+i%(ColInfo->Count-FixColCount);
      long Row=i/(ColInfo->Count-FixColCount);
      if(!oqVal->ParamByName("data_t")->ItemIsNull[i+1])
        grData->Columns->Items[Col]->Footers->Items[f_num]->Value=FormatByMask(((TFieldS*)ColInfo->Items[Col])->sMasks,((TFieldS*)RowInfo->Items[Row])->sMasks,oqVal->ParamByName("data_t")->ItemAsFloat[i+1]);
      else
        grData->Columns->Items[Col]->Footers->Items[f_num]->Value="";
      if(Col==(ColInfo->Count-1))
        f_num++;
    }
    if(vtData->State==dsEdit)
      vtData->Post();
    oqVal->Close();
    vtData->OnNewRecord=vtDataNewRecord;
    vtData->AfterEdit=vtDataAfterEdit;
    vtData->AfterPost=vtDataAfterPost;
    vtData->AfterScroll=vtDataAfterScroll;
    vtData->First();
    vtData->EnableControls();
    vtData->GotoBookmark(SavePlace);
    vtData->FreeBookmark(SavePlace);
    SendUpdateMessage();
  }catch(Exception &e){
    vtData->EnableControls();
    Application->ShowException(&e);
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmInteriorUni::grDataColExit(TObject *Sender)
{
  if(EditRec && (vtData->State == dsEdit))
    vtData->Post();
}
//---------------------------------------------------------------------------
void __fastcall TfmInteriorUni::vtDataAfterPost(TDataSet *DataSet)
{
   vSave(this);
}
//---------------------------------------------------------------------------
void __fastcall TfmInteriorUni::vtDataAfterEdit(TDataSet *DataSet)
{
  if(!EditRec)EditRec=true;
}
//---------------------------------------------------------------------------
void __fastcall TfmInteriorUni::grDataExit(TObject *Sender)
{
  if(EditRec && (vtData->State == dsEdit))
    vtData->Post();
}
//---------------------------------------------------------------------------
void __fastcall TfmInteriorUni::vtDataNewRecord(TDataSet *DataSet)
{
  vtData->Cancel();
}
//---------------------------------------------------------------------------
void __fastcall TfmInteriorUni::grDataColEnter(TObject *Sender)
{
  if(grData->Col<FixColCount)
    grData->Col=(grData->Columns->Count==FixColCount)?(FixColCount-1):FixColCount;
  grDataEnter(Sender);
}
//---------------------------------------------------------------------------
void __fastcall TfmInteriorUni::vtDataAfterScroll(TDataSet *DataSet)
{
  if(!isExistsMaket)
    return;
  bool b=((TFieldS*)RowInfo->Items[vtData->FieldByName("num")->AsInteger])->nlock;
  for(int i=0;i<grData->Columns->Count;i++)
    grData->Columns->Items[i]->ReadOnly=b||((TFieldS*)ColInfo->Items[grData->Columns->Items[i]->Tag])->nlock;
  grDataEnter(this);
}
//---------------------------------------------------------------------------
void __fastcall TfmInteriorUni::grDataDrawColumnCell(TObject *Sender,
      const TRect &Rect, int DataCol, TColumnEh *Column,
      TGridDrawState State)
{
  if(!isExistsMaket||!vtData->Active||!(DataCol>0&&Column->Tag+1>FixColCount)) //Только не FixCol
    return;
  TFieldS *cInfo=(TFieldS *)ColInfo->Items[Column->Tag];
  TFieldS *rInfo=(TFieldS *)RowInfo->Items[vtData->FieldByName("num")->AsInteger];

  AnsiString s;
  if(!Column->Field->IsNull)
    s=FormatByMask(cInfo->sMasks,rInfo->sMasks,Column->Field->AsFloat);
  //Теперь рисуем
  TColor cl=FindColor(cInfo->id,rInfo->id);
  if(cl){
    grData->Canvas->Brush->Color=cl;
  }else{
    if(rInfo->DataCl!=clWhite)
      grData->Canvas->Brush->Color=rInfo->DataCl;
    else
      grData->Canvas->Brush->Color=cInfo->DataCl;
  }
  grData->Canvas->FillRect(Rect);
  grData->Canvas->Font->Color=clBlack;
  if(cInfo->DataAl==alLeft)
    grData->Canvas->TextRect(Rect,Rect.Left+2,Rect.Top+2,s);
  else
    grData->Canvas->TextRect(Rect,Rect.Right-(grData->Canvas->TextWidth(s)+3), Rect.Top+2,s);
}
//---------------------------------------------------------------------------
TColor __fastcall TfmInteriorUni::FindColor(int Col,int Row)
{
  for(int i=0;i<cntColor;i++){
    if(masColor[i].Col==Col&&masColor[i].Row==Row)
      return (TColor)masColor[i].Color;
  }
  return (TColor)0;
}
//---------------------------------------------------------------------------
AnsiString __fastcall TfmInteriorUni::FindColorStr(int Col,int Row)
{
  for(int i=0;i<cntColor;i++){
    if(masColor[i].Col==Col&&masColor[i].Row==Row)
      return masColor[i].Info;
  }
  return "";
}
//---------------------------------------------------------------------------
void __fastcall TfmInteriorUni::grDataTitleClick(TColumnEh *Column)
{
  if(isExistsMaket&&Column->Tag>=FixColCount)//&&cbInvert->Checked&&
    ShowGraph(((TFieldS *)ColInfo->Items[Column->Tag])->id,((TFieldS *)RowInfo->Items[vtData->FieldByName("num")->AsInteger])->id);
}
//---------------------------------------------------------------------------
void __fastcall TfmInteriorUni::grDataMouseDown(TObject *Sender,
      TMouseButton Button, TShiftState Shift, int X, int Y)
{
  //На DataCellClick писать нельзя т.к. OnEnter блокирует FrozenCols
  double d=0;
  if(isExistsMaket&&grData->SelectedIndex&&vtData->Active){//&&!cbInvert->Checked
    for(int i=0;i<grData->FrozenCols;i++)
      d+=grData->Columns->Items[i]->Width;
    if(X<d)
      ShowGraph(((TFieldS *)ColInfo->Items[grData->Columns->Items[grData->SelectedIndex]->Tag])->id,((TFieldS *)RowInfo->Items[vtData->FieldByName("num")->AsInteger])->id);
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmInteriorUni::ShowGraph(long Col,long Row)
{
  oqValGraf->ParamByName("nfid")->AsInteger=FD->IdFormTree;
  oqValGraf->ParamByName("nispoint")->AsInteger=FD->IsPoints;
  oqValGraf->ParamByName("nid")->AsInteger=FD->IdGroup;
  oqValGraf->ParamByName("dfrom")->AsDateTime=FD->dateTimePar;
  oqValGraf->ParamByName("dtill")->AsDateTime=FD->dateTime;
  oqValGraf->ParamByName("ncol")->AsInteger=Col;
  oqValGraf->ParamByName("nrow")->AsInteger=Row;
  oqValGraf->ParamByName("x_t")->Length=RowInfo->Count*(ColInfo->Count-FixColCount);
  oqValGraf->ParamByName("y_t")->Length=RowInfo->Count*(ColInfo->Count-FixColCount);
  oqValGraf->Execute();
  if(oqValGraf->ParamByName("ret")->AsInteger){
    TList* lst=new TList;
    lst->Capacity=oqValGraf->ParamByName("ret")->AsInteger;
    for(int i=0;i<oqValGraf->ParamByName("ret")->AsInteger;i++){
      if(!oqValGraf->ParamByName("y_t")->ItemIsNull[i+1]){
        TfmGraphMaket::TItems *itm=new TfmGraphMaket::TItems;
        itm->x=oqValGraf->ParamByName("x_t")->ItemAsFloat[i+1];
        itm->y=oqValGraf->ParamByName("y_t")->ItemAsFloat[i+1];
        lst->Add(itm);
      }
    }
    TfmGraphMaket* f;
    f=new TfmGraphMaket(this,lst,oqValGraf->ParamByName("vtitle")->AsString,oqValGraf->ParamByName("vxtitle")->AsString,oqValGraf->ParamByName("vytitle")->AsString);
    f->ShowModal();
    delete f;
    for(int i=0;i<lst->Count;i++)
      delete (TfmGraphMaket::TItems*)lst->Items[i];
    delete lst;
  }
  oqValGraf->Close();
}
//---------------------------------------------------------------------------
void __fastcall TfmInteriorUni::vSave(TObject* Sender)
{

  if(!isExistsMaket||!EditRec||!vtData->Active)
    return;

  long Col=((TFieldS *)ColInfo->Items[grData->Columns->Items[grData->SelectedIndex]->Tag])->id;
  long Row=((TFieldS *)RowInfo->Items[vtData->FieldByName("num")->AsInteger])->id;
  try{
  
    oqSave->ParamByName("nfid")->AsInteger=FD->IdFormTree;
    oqSave->ParamByName("nispoint")->AsInteger=FD->IsPoints;
    oqSave->ParamByName("nid")->AsInteger=FD->IdGroup;
    oqSave->ParamByName("dfrom")->AsDateTime=FD->DateTimePar;
    oqSave->ParamByName("dtill")->AsDateTime=FD->DateTime;
    oqSave->ParamByName("ncol")->AsInteger=Col;
    oqSave->ParamByName("nrow")->AsInteger=Row;

    if(grData->Columns->Items[grData->SelectedIndex]->Field->IsNull)
      oqSave->ParamByName("nvalue")->Clear();
    else
      oqSave->ParamByName("nvalue")->AsFloat=grData->Columns->Items[grData->SelectedIndex]->Field->AsFloat;
    oqSave->Execute();
    oqSave->Session->Commit();
    EditRec=false;
    oqSave->Close();
    RefreshData(this);
  }catch(Exception &e){
    oqSave->Session->Rollback();
    Application->ShowException(&e);
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmInteriorUni::PrintData(TObject *Sender,AnsiString sTitle)
{
  AnsiString sFile=TdmMain::GetTmpPath()+"askueprn.tmp";
  AnsiString TmpDate;
  AnsiString TarZone;
  int validity;
  AnsiString mess;
  AnsiString pc;

  /*if (mode30902_receive){
        QuickRep1->DataSet = MaketF;
        return;
  }*/
  oqTarZone->SQL->Text="select vname from "+SchemeName+"SCHEDULELIST where NSCHEDULELIST=:par1";
  oqTarZone->ParamByName("par1")->ParamType=ptInput;
  oqTarZone->ParamByName("par1")->AsInteger=RateZona;
  oqTarZone->Execute();
  TarZone=oqTarZone->FieldByName("VNAME")->AsString;
  oqTarZone->Close();

  //Параметры имеют другой смысл
  bool IsTimeFields = FD->EnableControls.Contains(TFormDescr::ctrlMonth);
  bool IsSecondBound = FD->EnableControls.Contains(TFormDescr::ctrlDay);

  //Если для отчета не выводится поле времени, то дата окончания - 00:00 часов следующего дня
//  if(!(IsTimeFields&&IsSecondBound)) TmpDate= (TDateTime(Dt2)+1).FormatString("dd.mm.yyyy hh:nn"); //saa 07.12.2010
  if(!IsTimeFields&&!IsSecondBound) TmpDate= (TDateTime(Dt1)+1).FormatString("dd.mm.yyyy hh:nn");
  else TmpDate= TDateTime(Dt2).FormatString("dd.mm.yyyy hh:nn");
  PrintDBGridEh1->BeforeGridText->Clear();
  PrintDBGridEh1->AfterGridText->Clear();
  PrintDBGridEh1->Title->Clear();
  PrintDBGridEh1->PageHeader->RightText->Clear();

  oqPrint->ParamByName("an_fid")->AsInteger=FD->IdFormTree;
  oqPrint->Execute();

  if (oqPrint->ParamByName("an_usedefphr")->AsInteger)
    PrintDBGridEh1->PageHeader->RightText->Text=Now().FormatString("dd.mm.yyyy hh:nn:ss");

  if(!oqPrint->ParamByName("ab_before")->IsNull&&oqPrint->ParamByName("ab_before")->AsOraBlob->LengthLob()){
    oqPrint->ParamByName("ab_before")->AsOraBlob->SaveToFile(sFile);
    PrintDBGridEh1->BeforeGridText->LoadFromFile(sFile);
  }
  if(!oqPrint->ParamByName("ab_after")->IsNull&&oqPrint->ParamByName("ab_after")->AsOraBlob->LengthLob()){
    oqPrint->ParamByName("ab_after")->AsOraBlob->SaveToFile(sFile);
    PrintDBGridEh1->AfterGridText->LoadFromFile(sFile);
  }
  /*add******************* 30.06.2009 start *************/
  int usedeftitle=oqPrint->ParamByName("an_usedeftitle")->AsInteger;
  AnsiString Time;

  if (oqPrint->ParamByName("an_reporttitle")->AsInteger)
  {
    switch (TimeZona){
      case  -1:  Time=Reconst_smes134_2;
                break;
      case  0:  Time=Reconst_smes134_1;
                break;
      case 1: Time=Reconst_smes134_3;
                break;
    }
    PrintDBGridEh1->BeforeGridText->Add(FD->NameGroup);
    if(oqPrint->ParamByName("an_timezone")->AsInteger) PrintDBGridEh1->BeforeGridText->Add(Reconst_smes134_4+Time+Reconst_smes134_5);
    if(oqPrint->ParamByName("an_showtarzone")->AsInteger) PrintDBGridEh1->BeforeGridText->Add(Reconst_smes134_9+TarZone);
    PrintDBGridEh1->BeforeGridText->Add(Reconst_smes134_6+TDateTime(Dt1).FormatString("dd.mm.yyyy hh:nn")+" - "+TmpDate);
    usedeftitle=0;
  }
  // edited by KAG 28.12.2009
  if((oqPrint->ParamByName("an_quantity")->AsInteger)&&(QuantityStr!="")){
    validity = QuantityStr.SubString(1,1).ToInt();
    switch (validity){
      case 0: mess = Reconst_smes134_11;
              break;
      case 1: mess = Reconst_smes134_12;
              break;
      case 2: mess = Reconst_smes134_13;
              break;
      case 3: mess = Reconst_smes134_14;
              break;

    }
    PrintDBGridEh1->BeforeGridText->Add(Reconst_smes134_10+mess);
  }

   if (oqPrint->ParamByName("an_powercoeff")->AsInteger){
    if (PowerCoeff==1000)
      pc= Reconst_smes106_29+" ("+ Reconst_smes106_31+") ";
    else
      pc= Reconst_smes106_28+" ("+ Reconst_smes106_30+") ";
    PrintDBGridEh1->BeforeGridText->Add("Размерность данных : " + pc);
   }


  if (oqPrint->ParamByName("an_form_date")->AsInteger)
    PrintDBGridEh1->BeforeGridText->Add("Дата формирования отчета: " + Dt3.FormatString("dd.mm.yyyy hh:nn:ss"));
  
  if (usedeftitle){
    if(!sTitle.IsEmpty())
      PrintDBGridEh1->Title->Add(sTitle);
    else
      PrintDBGridEh1->Title->Add(FD->NameGroup+Reconst_smes134_7+TDateTime(Dt1).FormatString("dd.mm.yyyy hh:nn")+Reconst_smes134_8+TmpDate);
  }

 /*********************** 30.06.2009 end *************/
  if(FileExists(sFile))
    DeleteFile(sFile);

  PrintDBGridEh1->Preview();

  }
//---------------------------------------------------------------------------
void __fastcall TfmInteriorUni::vSaveToFile(TObject *Sender,AnsiString sTitle)
{
  if(sTitle=="")
    sTitle=FD->NameGroup;

  SaveTable(Owner,grData,sTitle);      //функция сохранения в файл отличается от unDataMod
                                       //возможностью форматированного вывода чисел (опционально - 3 знака после разделителя)
}
//---------------------------------------------------------------------------
void __fastcall TfmInteriorUni::grDataEnter(TObject *Sender)
{
//SAA  int num=0,count=0;
//SAA  num=vtData->RecNo;
//SAA  count=grData->Col-FixColCount+1;//vtData->RecordCount;
//SAA  PostMessage(Application->MainForm->Handle,WM_SETSTATUS, num,count);
}
//---------------------------------------------------------------------------
AnsiString __fastcall TfmInteriorUni::FormatByMask(const AnsiString cMasks,const AnsiString rMasks,double d)
{
  //Форматированый вывод (строка приоритетней)
  AnsiString Format;
    if(!cMasks.IsEmpty())
      Format=cMasks;
    if(!rMasks.IsEmpty())
      Format=rMasks;
    if(!Format.IsEmpty())
      return FormatFloat(Format,d);
    else
      return FloatToStr(d);
}
//---------------------------------------------------------------------------
void __fastcall TfmInteriorUni::SendUpdateMessage(void)
{
  TForm *f;
//SAA  if(f=dynamic_cast<TForm*>(Owner))
//SAA    PostMessage(f->Handle,WM_READERRORLIST,NULL,NULL);
}
//---------------------------------------------------------------------------
void __fastcall TfmInteriorUni::CreateColorMass(void)
{
  if(cntColor){
    cntColor=0;
    delete masColor;
  }
  oqColor->Close();
  oqColor->ParamByName("nfid")->AsInteger=FD->IdFormTree;
  oqColor->ParamByName("nispoint")->AsInteger=FD->IsPoints;
  oqColor->ParamByName("nid")->AsInteger=FD->IdGroup;
  oqColor->ParamByName("dfrom")->AsDateTime=FD->dateTimePar;
  oqColor->ParamByName("dtill")->AsDateTime=FD->dateTime;
  oqColor->Execute();
  while(!oqColor->Eof){
    cntColor++;
    oqColor->Next();
  }
  if(cntColor){
    masColor=new TColorS[cntColor];
    oqColor->First();
    int kk=0;
    while(!oqColor->Eof){
      masColor[kk].Col=oqColor->FieldByName("nCol")->AsInteger;
      masColor[kk].Row=oqColor->FieldByName("nRow")->AsInteger;
      masColor[kk].Color=oqColor->FieldByName("nColor")->AsInteger;
      strcpy(masColor[kk].Info,oqColor->FieldByName("vInfo")->AsString.c_str());
      kk++;
      oqColor->Next();
    }
  }
  oqColor->Close();
}
//---------------------------------------------------------------------------
void __fastcall TfmInteriorUni::grDataDblClick(TObject *Sender)
{
  if(!isExistsMaket||!vtData->Active||grData->SelectedIndex<0||grData->Columns->Items[grData->SelectedIndex]->Tag+1<=FixColCount) //Только не FixCol
    return;
  //Теперь рисуем
  AnsiString s=FindColorStr(((TFieldS *)ColInfo->Items[grData->Columns->Items[grData->SelectedIndex]->Tag])->id,((TFieldS *)RowInfo->Items[vtData->FieldByName("num")->AsInteger])->id);
  if(!s.Trim().IsEmpty())
    Application->MessageBox(s.c_str(),Application->Title.c_str(),MB_OK	|MB_ICONWARNING);
}

//---------------------------------------------------------------------------
AnsiString __fastcall TfmInteriorUni::getLastPartOfNameColumn (AnsiString columnName, int numRec, bool wasGroupNameAsFirstLine){
   //GRB FIX 17.12.2019 - плодятся новые столбцы с переносом на следующую строку в экзешнике когда у нас в исходной строке есть слещ
   if (columnName.Pos("\r")!=0)
        columnName=StringReplace(columnName,"\r"," ",TReplaceFlags()<<rfReplaceAll<<rfIgnoreCase);
   //конец заплатки
   AnsiString ret = columnName;
   TStringList* rowData = NULL;
   int length = 0;
   try{
   rowData = new TStringList();
   split (rowData,columnName.c_str(), "|");
   length = rowData->Count;
   if (wasGroupNameAsFirstLine){ //47 proc
   if (length > 1) {
        AnsiString isNumber = rowData->Strings[length-1];
        int tst = StrToInt(isNumber);//for exception generated
        ret = rowData->Strings[length-1];
        delete rowData;
        rowData = NULL;
        return ret;
   }else{
        delete rowData;
        rowData = NULL;
        return ret;
   }
   }else{              //5.06
   if ((numRec!=0)&&(length > 1)) {
        AnsiString isNumber = rowData->Strings[length-1];
        int tst = StrToInt(isNumber);//for exception generated
        ret = rowData->Strings[length-1];
        delete rowData;
        rowData = NULL;
        return ret;
   }else{
        delete rowData;
        rowData = NULL;
        return ret;
   }
   }
   }
   catch (EConvertError &ecr){
        //ret = rowData->Strings[length-2]+ AnsiString (" ") + rowData->Strings[length-1]; //2 последних
        ///GRB FIX 26.12.2018 - Изменил своё же изменение ради 38-й процедуры по требованию Кальницкой
        ///TODO Это хардкод и тут надо бы передавать номер процедуры и так делать только для 38-й.
        //GRB TEST 17.12.2019 Не годится и это решение ниже без номера процедуры
        if (rowData->Strings[length-1]!=NULL){
                ret = rowData->Strings[length-1];
                delete rowData;
                rowData = NULL;
                return ret;
        } 
        ret = rowData->Strings[length-2]+ AnsiString (" ") + rowData->Strings[length-1]; //2 последних
        //END OF HARDCODE
        delete rowData;
        rowData = NULL;
        return ret;
   }
   catch (Exception &e){ //ошибки в ходе попытки отсечения части строки
   if (rowData!=NULL){
        delete rowData;
        rowData = NULL;
   }
   return ret;
   }
}

//---------------------------------------------------------------------------
//функция сохранения в файл отличается от unDataMod
//возможностью форматированного вывода чисел (опционально - 3 знака после разделителя)

void __fastcall TfmInteriorUni::SaveTable(TComponent* Owner,TDBGridEh *gr,AnsiString RepCaption)
{
  AnsiString s, s1, fname;
  TStringList *StringList;
  TBookmark SavePlace;
  AnsiString  tab = char(9);
  AnsiString ExportSeparator;
  int SpecFormat;
  TSaveDialog *sd=new TSaveDialog(Owner);
  TDataSet  *ds = gr->DataSource->DataSet;
  //25.10.2021 GRB ADD
  if (mode30902_receive){
  TRegistry *Reg = new TRegistry(KEY_READ);
      try
      {
        Reg->RootKey = HKEY_CURRENT_USER;
        Reg->Access = KEY_READ;
        Reg->OpenKey("\\SOFTWARE\\Grant\\Ascue\\Monitors", False);
        if(Reg->ValueExists("ExportSeparator"))
              ExportSeparator = ((Reg->ReadString("ExportSeparator") == ",") ? (",") : ("."));
        else
             ExportSeparator = (".");

        if(Reg->ValueExists("isSpecFormat"))
             SpecFormat = (Reg->ReadInteger("isSpecFormat")) ? 1 : 0;
        else
             SpecFormat = 0;

      }
      __finally
      {
        delete Reg;
      }
       sd->Title = Reconst_smes68_10;
  sd->DefaultExt = "txt";
  sd->FileName=Reconst_smes68_11;
  sd->Filter = "Текстовые документы (*.txt)|*.txt|Файл с разделителем (*.csv)|*.csv";
  sd->Options << ofOverwritePrompt;
  if(sd->Execute()){
    fname=sd->FileName;
    }
  else{
    fname="";
    }
  delete sd;
  if(fname.IsEmpty())
    return;
  //30902 receive to csv
  if ((fname.Pos(".csv")!=0)||(fname.Pos(".csV")!=0)||(fname.Pos(".cSv")!=0)||(fname.Pos(".cSV")!=0)||(fname.Pos(".Csv")!=0)||(fname.Pos(".CsV")!=0)||(fname.Pos(".CSv")!=0)||(fname.Pos(".CSV")!=0)){
                AnsiString rowData,str="";
                TStringList* sList=new TStringList;
                AnsiString separator = getSeparator(); //разделитель целой и дробной части
                AnsiString delimcomma = ";";  //разделитель колонок в csv
                if(!RepCaption.IsEmpty())
                        sList->Add(RepCaption);
                //Вычитываем значения из MaketF

                for (int i = 0; i < MaketF->RowCount; i++){
                        for (int j = 0; j < MaketF->ColCount; j++){
                               rowData =  MaketF->Cells[j][i];
                               if (i>0) //тут значения
                               rowData = StringReplace(rowData,".",separator,TReplaceFlags()<<rfReplaceAll<<rfIgnoreCase);

                               if (rowData!="")
                                        str = str + rowData;
                               if (j !=MaketF->ColCount-1)
                                        str = str + delimcomma;
                        }
                    sList->Add (str);
                    str="";
                }
                //TODO:Перезаписывать без предупреждения, если файл с таким именем существует?
                try{
                        if (!FileExists(fname))
                                sList->SaveToFile(fname);
                        else{
                                DeleteFile (fname);
                                sList->SaveToFile(fname);
                        }
                        delete sList;
                        sList = NULL;
                }catch (EFCreateError &efce){
                   if  (sList != NULL){
                        delete sList;
                        sList = NULL;
                   }
                   throw; //To application
                }
        return;
    }
  // 30902 receive to txt
  try{
  StringList  = new TStringList;
    //Заголовок
    if(!RepCaption.IsEmpty())
      StringList->Add(RepCaption);
    s="";

    //перегоняем из грида MaketF в TStringList и сохраняем
    for (int i = 0; i < MaketF->RowCount; i++){
        for (int j = 0; j < receive_maket_30902_col_num; j++){
                int max_col_size = getMaxSymbolInColumn (MaketF,j);
                if(!s.IsEmpty()) s += tab;
                s = s+add_Prob_to_Max_Size(MaketF->Cells[j][i], max_col_size);
                }
        StringList->Add (s);
        s = "";
    }
    StringList->SaveToFile(fname);
    delete StringList;
    StringList = NULL;
  }catch (Exception &e){
        if (StringList!=NULL) delete StringList;
        throw e;
  }

      return;
  }
  //25.10.2021 END ADD

  if (!ds || !ds->Active){
  if (ds){
  {
  TRegistry *Reg = new TRegistry(KEY_READ);
      try
      {
        Reg->RootKey = HKEY_CURRENT_USER;
        Reg->Access = KEY_READ;
        Reg->OpenKey("\\SOFTWARE\\Grant\\Ascue\\Monitors", False);
        if(Reg->ValueExists("ExportSeparator"))
              ExportSeparator = ((Reg->ReadString("ExportSeparator") == ",") ? (",") : ("."));
        else
             ExportSeparator = (".");

        if(Reg->ValueExists("isSpecFormat"))
             SpecFormat = (Reg->ReadInteger("isSpecFormat")) ? 1 : 0;
        else
             SpecFormat = 0;

      }
      __finally
      {
        delete Reg;
      }
       sd->Title = Reconst_smes68_10;
  sd->DefaultExt = "txt";
  sd->FileName=Reconst_smes68_11;
  sd->Filter =  "Текстовые документы (*.txt)|*.txt|Файл с разделителем (*.csv)|*.csv";
  sd->Options << ofOverwritePrompt;
  if(sd->Execute()){
    fname=sd->FileName;
    }
  else{
    fname="";
    }
  delete sd;
  if(fname.IsEmpty())
    return;
  //MAKETS receive to csv
  if ((fname.Pos(".csv")!=0)||(fname.Pos(".csV")!=0)||(fname.Pos(".cSv")!=0)||(fname.Pos(".cSV")!=0)||(fname.Pos(".Csv")!=0)||(fname.Pos(".CsV")!=0)||(fname.Pos(".CSv")!=0)||(fname.Pos(".CSV")!=0)){
                AnsiString rowData,str="";
                TStringList* sList=new TStringList;
                AnsiString separator = getSeparator();
                AnsiString delimcomma = ";";
                if(!RepCaption.IsEmpty())
                        sList->Add(RepCaption);
                for (int i = 0; i < MaketF->RowCount; i++){
                        for (int j = 0; j < MaketF->ColCount; j++){
                               rowData =  MaketF->Cells[j][i];
                               if (i>0) //??? ????????
                               rowData = StringReplace(rowData,".",separator,TReplaceFlags()<<rfReplaceAll<<rfIgnoreCase);

                               if (rowData!="")
                                        str = str + rowData;
                               if (j !=MaketF->ColCount-1)
                                        str = str + delimcomma;
                        }
                    sList->Add (str);
                    str="";
                }
                //TODO:?????????????? ??? ??????????????, ???? ???? ? ????? ?????? ???????????
                try{
                        if (!FileExists(fname))
                                sList->SaveToFile(fname);
                        else{
                                DeleteFile (fname);
                                sList->SaveToFile(fname);
                        }
                        delete sList;
                        sList = NULL;
                }catch (EFCreateError &efce){
                   if  (sList != NULL){
                        delete sList;
                        sList = NULL;
                   }
                   throw; //To application
                }
        return;
    }
  // 30902 receive to txt
  try{
  StringList  = new TStringList;
    //?????????
    if(!RepCaption.IsEmpty())
      StringList->Add(RepCaption);
    s="";

    //?????????? ?? ????? MaketF ? TStringList ? ?????????
    for (int i = 0; i < MaketF->RowCount; i++){
        for (int j = 0; j < MaketF->ColCount; j++){
                int max_col_size = getMaxSymbolInColumn (MaketF,j);
                if(!s.IsEmpty()) s += tab;
                s = s+add_Prob_to_Max_Size(MaketF->Cells[j][i], max_col_size);

                }
        StringList->Add (s);
        s = "";
    }
    StringList->SaveToFile(fname);
    delete StringList;
    StringList = NULL;
  }catch (Exception &e){
        if (StringList!=NULL) delete StringList;
        throw e;
  }

      return;
  }
  }else{

    Application->MessageBox(Reconst_smes68_9.c_str(),Application->Title.c_str(),MB_OK | MB_ICONSTOP);
    return;
    }
  }

  TRegistry *Reg = new TRegistry(KEY_READ);
      try
      {
        Reg->RootKey = HKEY_CURRENT_USER;
        Reg->Access = KEY_READ;
        Reg->OpenKey("\\SOFTWARE\\Grant\\Ascue\\Monitors", False);
        if(Reg->ValueExists("ExportSeparator"))
              ExportSeparator = ((Reg->ReadString("ExportSeparator") == ",") ? (",") : ("."));
        else
             ExportSeparator = (".");

        if(Reg->ValueExists("isSpecFormat"))
             SpecFormat = (Reg->ReadInteger("isSpecFormat")) ? 1 : 0;
        else
             SpecFormat = 0;

      }
      __finally
      {
        delete Reg;
      }


  sd->Title = Reconst_smes68_10;
  sd->DefaultExt = "txt";
  sd->FileName=Reconst_smes68_11;
  sd->Filter = Reconst_smes68_12;
  sd->Options << ofOverwritePrompt;
  if(sd->Execute())
    fname=sd->FileName;
  else
    fname="";
  delete sd;
  if(fname.IsEmpty())
    return;

  try{
    StringList  = new TStringList;
    //Заголовок
    if(!RepCaption.IsEmpty())
      StringList->Add(RepCaption);
    s="";
    for (int i = 0; i < gr->Columns->Count; i++){
      if(gr->Columns->Items[i]->Visible&&gr->Columns->Items[i]->Field){
        if(!s.IsEmpty())
          s += tab;
        //GRB CHANGED 05.09.2018
        //s+= gr->Columns->Items[i]->Title->Caption;
        s+=getLastPartOfNameColumn(gr->Columns->Items[i]->Title->Caption,i,!RepCaption.IsEmpty());
      }
    }
    StringList->Add(s);
    //Данные
    SavePlace = ds->GetBookmark();
    ds->DisableControls();
    ds->First();
    int cn  = 0;
    while (!ds->Eof){
      s="";
      for (int i = 0; i < gr->Columns->Count; i++)
      {
        if (gr->Columns->Items[i]->Visible&&gr->Columns->Items[i]->Field)
        {
          if(!s.IsEmpty())
            s += tab;
          if (gr->Columns->Items[i]->Field->DataType == ftDateTime)
            s += gr->Columns->Items[i]->Field->AsDateTime.FormatString("dd.mm.yyyy hh:nn:ss");
          else
          {
            if(gr->Columns->Items[i]->Field->DataType == ftFloat)
            {
              if ((SpecFormat) && (gr->Columns->Items[i]->Field->AsString != ""))
                s1 = FormatByMask(((TFieldS*)ColInfo->Items[i])->sMasks, ((TFieldS*)RowInfo->Items[cn])->sMasks, StrToFloat(gr->Columns->Items[i]->Field->AsString));
              else
                s1 = gr->Columns->Items[i]->Field->AsString;

              if (ExportSeparator == ",")
                s += StringReplace(s1,".",",",TReplaceFlags()<<rfReplaceAll);
              else
                s += StringReplace(s1,",",".",TReplaceFlags()<<rfReplaceAll);
            }
            else
              s += gr->Columns->Items[i]->Field->AsString;
          }
        }
      }
      StringList->Add(s);
      cn++;
      ds->Next();
    }
    ds->GotoBookmark(SavePlace);
    ds->FreeBookmark(SavePlace);
    ds->EnableControls();
    StringList->SaveToFile(fname);
    delete  StringList;
    Application->MessageBox(AnsiString(AnsiString(Reconst_smes68_13) +
                              fname +
                              AnsiString(Reconst_smes68_14) +
                              IntToStr(cn) +
                              AnsiString(Reconst_smes68_15)).c_str(),
                            Application->Title.c_str(),
                            MB_OK | MB_ICONINFORMATION);
  }
  catch (Exception &e){
    delete  StringList;
    throw;
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmInteriorUni::StringGrid1DrawCell(TObject *Sender,
      int ACol, int ARow, TRect &Rect, TGridDrawState State)
{
 TStringGrid*     StrGridPtr;
 StrGridPtr = (TStringGrid*)Sender;
 StrGridPtr->Canvas->Brush->Color=clWhite;
 int x,y;
 x=Rect.left+(Rect.Width()-MaketF->Canvas->TextWidth(MaketF->Cells[ACol][ARow]))/2;
 y=Rect.top+(Rect.Height()-MaketF->Canvas->TextHeight(MaketF->Cells[ACol][ARow]))/2;
 if (mode30902_receive){
        if (ARow<(maketRow->Count-block_size_902-1)){
                StrGridPtr->Canvas->Brush->Color=(TColor)RGB(212, 208, 200);
                StrGridPtr->Canvas->FillRect(Rect);
                StrGridPtr->Canvas->TextOut (x,y, StrGridPtr->Cells[ACol][ARow]);
                }else{
                StrGridPtr->Canvas->Brush->Color=(TColor)RGB(250, 228, 141);
                StrGridPtr->Canvas->FillRect(Rect);
                StrGridPtr->Canvas->TextOut (x,y, StrGridPtr->Cells[ACol][ARow]);

                }
 }

 if (modeManyColumn){
                if ((ACol==0) || (ARow<6)) //поля с датами, часами и заголовки - по центру
                StrGridPtr->Canvas->TextOut (x,y, StrGridPtr->Cells[ACol][ARow]);
                else{  //значения почти по правому краю
                 Rect.right = Rect.right-2;
                 DrawTextA(StrGridPtr->Canvas->Handle, StrGridPtr->Cells[ACol][ARow].c_str(), strlen(StrGridPtr->Cells[ACol][ARow].c_str()), &Rect,  DT_RIGHT);
                }

 }
 if ((strcmp(maketType, "30917")==0)||(strcmp(maketType, "30817")==0)){
        if (ACol==3 && ARow!=0) {
                StrGridPtr->Canvas->Brush->Color=(TColor)RGB(255, 255, 0);
                StrGridPtr->Canvas->FillRect(Rect);
                StrGridPtr->Canvas->TextOut (x,y, StrGridPtr->Cells[ACol][ARow]);
        }else
        if (ACol<=2 || ARow==0){
                StrGridPtr->Canvas->Brush->Color=(TColor)RGB(212, 208, 200);
                StrGridPtr->Canvas->FillRect(Rect);
                StrGridPtr->Canvas->TextOut (x,y, StrGridPtr->Cells[ACol][ARow]);
        } else
                StrGridPtr->Canvas->TextOut (x,y, StrGridPtr->Cells[ACol][ARow]);

}
 if (strcmp(maketType, "30818")==0){
    if (ACol==3 && ARow>1) {
                StrGridPtr->Canvas->Brush->Color=(TColor)RGB(255, 255, 0);
                StrGridPtr->Canvas->FillRect(Rect);
                StrGridPtr->Canvas->TextOut (x,y, StrGridPtr->Cells[ACol][ARow]);
    }else
        if ((ACol<=2) || (ARow < 2)){
                StrGridPtr->Canvas->Brush->Color=(TColor)RGB(212, 208, 200);
                StrGridPtr->Canvas->FillRect(Rect);
                StrGridPtr->Canvas->TextOut (x,y, StrGridPtr->Cells[ACol][ARow]);
        } else
                StrGridPtr->Canvas->TextOut (x,y, StrGridPtr->Cells[ACol][ARow]);
 }
}
//---------------------------------------------------------------------------
void __fastcall TfmInteriorUni::printHeaderManyColumn(){
          //конструктор для многотабличных(по умолчанию 3 колонки - A+, A-, R+) отчётов + выстанавливается признак modeManyColumn новодела, признак modeMaketFM cбрасывается
        grData->Visible = false;
        modeMaketFM=false;
        modeManyColumn = true;
        MaketF->Visible=true;
        int tableNumbers = 3;
        int columnNumbers = 25*tableNumbers + (tableNumbers-1)+1; //Получено империческим путём

        //Вычитываем струкуру таблицы
        oqMaketInfoCol53->Close();
        oqMaketInfoCol53->ParamByName("nfid")->AsInteger=FD->IdFormTree;
        oqMaketInfoCol53->ParamByName("nispoint")->AsInteger=FD->IsPoints;
        oqMaketInfoCol53->ParamByName("nid")->AsInteger=FD->IdGroup;
        oqMaketInfoCol53->ParamByName("dfrom")->AsDateTime=FD->dateTimePar;
        oqMaketInfoCol53->ParamByName("dtill")->AsDateTime=FD->dateTime;
        oqMaketInfoCol53->ParamByName("taddparam")->Length=FDADDPARAMSIZE;
        for(int i=0;i<FDADDPARAMSIZE;i++){
                oqMaketInfoCol53->ParamByName("taddparam")->ItemAsString[i+1]=FD->FAddParam[i];
        }
        oqMaketInfoCol53->Execute();
        Dt1=oqMaketInfoCol53->ParamByName("dfrom")->AsDateTime;
        Dt2=oqMaketInfoCol53->ParamByName("dtill")->AsDateTime;

        FixColCount=oqMaketInfoCol53->ParamByName("ncnfixcol")->AsInteger;
        MaketF->FixedCols = FixColCount;
        TitleCount=oqMaketInfoCol53->ParamByName("ncntitle")->AsInteger;
        MaketF->RowCount = TitleCount;//c заголовком
        FooterCount=oqMaketInfoCol53->ParamByName("ncnfooter")->AsInteger;
        int z=0;
        //Вычитываем данные о колонках - col_t1, col_t2, col_t3 и опционально col_t4
        //col_t1
        oqMaketInfoCol53->Cursor=oqMaketInfoCol53->ParamByName("col_t1")->AsCursor;
        AnsiString blank1, blank2 ="";
        AnsiString typeEnergy="P";
        AnsiString dateName="";
        while(!oqMaketInfoCol53->Eof){
          z++;
          if(z>ColInfo->Capacity)
             ColInfo->Capacity+=50;
          //Заполним структуру
          int id =oqMaketInfoCol53->FieldByName("id")->AsInteger;
          for(int i=1;i<TitleCount;i++)  {
                AnsiString currValue = "";
                oqMaketInfoCol53->FieldByName("Title"+IntToStr(i))->AsString;
                if (oqMaketInfoCol53->FieldByName("Title"+IntToStr(i))->AsString!=NULL)
                        currValue = oqMaketInfoCol53->FieldByName("Title"+IntToStr(i))->AsString;
                if (z==1){     //1-я запись
                        switch (i){
                        case 1:{
                                companyName = currValue;
                                break;
                                }
                        case 2:{
                                blank1 = currValue;
                                break;
                                }
                        case 3:{
                                blank2 = currValue;
                                break;
                                }

                        case 4:{
                                consumerName = currValue;
                                break;
                                }
                        case 5:{
                                typeEnergy = currValue;
                                break;
                        }
                        case 6:{
                               dateName = currValue;
                               break;
                        }
                   }
                }
          }
        oqMaketInfoCol53->Next();
        }
        //
        MaketF->ColCount = columnNumbers;// наименование+тип измерения+код+сумма
        MaketF->TopRow = false;
        MaketF->Visible=true;
        clearTable();
        char str[200];
        strcpy(str,companyName.c_str());
        MaketF->Cells[0][0] = str; //Первый стовпчик перший рядок Назва компании
        strcpy(str,blank1.c_str());
        MaketF->Cells[0][1] = str; //Пустой другий рядок
        strcpy(str,blank2.c_str());
        MaketF->Cells[0][2] = str; //Пустой третий рядок
        strcpy(str,consumerName.c_str());
        MaketF->Cells[0][3] = str;//Назва споживача  */
        for (int i = 0; i < 3; i++){
           switch (i){
           case 0 :{
           strcpy(str,typeEnergy.c_str());    //P
           MaketF->Cells[1][4] = str;
           break;
           }
           case 1 :{
           strcpy(str,"Q+");  //Q+
           MaketF->Cells[27][4] = str;
           break;
           }
           case 2 :{
           strcpy(str,"Q-");   //Q-
           MaketF->Cells[53][4] = str;
           break;
           }
         }
        }

        strcpy(str,dateName.c_str());
        MaketF->Cells[0][5] = str;//

        for (int i = 0; i <3; i++){
                switch (i){
                case 0:{
                   strcpy(str,"1:00");
                   MaketF->Cells[1][5] = str;
                   strcpy(str,"2:00");
                   MaketF->Cells[2][5] = str;
                   strcpy(str,"3:00");
                   MaketF->Cells[3][5] = str;
                   strcpy(str,"4:00");
                   MaketF->Cells[4][5] = str;
                   strcpy(str,"5:00");
                   MaketF->Cells[5][5] = str;
                   strcpy(str,"6:00");
                   MaketF->Cells[6][5] = str;
                   strcpy(str,"7:00");
                   MaketF->Cells[7][5] = str;
                   strcpy(str,"8:00");
                   MaketF->Cells[8][5] = str;
                   strcpy(str,"9:00");
                   MaketF->Cells[9][5] = str;
                   strcpy(str,"10:00");
                   MaketF->Cells[10][5] = str;
                   strcpy(str,"11:00");
                   MaketF->Cells[11][5] = str;
                   strcpy(str,"12:00");
                   MaketF->Cells[12][5] = str;
                   strcpy(str,"13:00");
                   MaketF->Cells[13][5] = str;
                   strcpy(str,"14:00");
                   MaketF->Cells[14][5] = str;
                   strcpy(str,"15:00");
                   MaketF->Cells[15][5] = str;
                   strcpy(str,"16:00");
                   MaketF->Cells[16][5] = str;
                   strcpy(str,"17:00");
                   MaketF->Cells[17][5] = str;
                   strcpy(str,"18:00");
                   MaketF->Cells[18][5] = str;
                   strcpy(str,"19:00");
                   MaketF->Cells[19][5] = str;
                   strcpy(str,"20:00");
                   MaketF->Cells[20][5] = str;
                   strcpy(str,"21:00");
                   MaketF->Cells[21][5] = str;
                   strcpy(str,"22:00");
                   MaketF->Cells[22][5] = str;
                   strcpy(str,"23:00");
                   MaketF->Cells[23][5] = str;
                   strcpy(str,"24:00");
                   MaketF->Cells[24][5] = str;
                   strcpy(str,"25:00");
                   MaketF->Cells[25][5] = str;
                }
                   MaketF->Cells[26][5] = "     ";

                case 1:{
                   strcpy(str,"1:00");
                   MaketF->Cells[27][5] = str;
                   strcpy(str,"2:00");
                   MaketF->Cells[28][5] = str;
                   strcpy(str,"3:00");
                   MaketF->Cells[29][5] = str;
                   strcpy(str,"4:00");
                   MaketF->Cells[30][5] = str;
                   strcpy(str,"5:00");
                   MaketF->Cells[31][5] = str;
                   strcpy(str,"6:00");
                   MaketF->Cells[32][5] = str;
                   strcpy(str,"7:00");
                   MaketF->Cells[33][5] = str;
                   strcpy(str,"8:00");
                   MaketF->Cells[34][5] = str;
                   strcpy(str,"9:00");
                   MaketF->Cells[35][5] = str;
                   strcpy(str,"10:00");
                   MaketF->Cells[36][5] = str;
                   strcpy(str,"11:00");
                   MaketF->Cells[37][5] = str;
                   strcpy(str,"12:00");
                   MaketF->Cells[38][5] = str;
                   strcpy(str,"13:00");
                   MaketF->Cells[39][5] = str;
                   strcpy(str,"14:00");
                   MaketF->Cells[40][5] = str;
                   strcpy(str,"15:00");
                   MaketF->Cells[41][5] = str;
                   strcpy(str,"16:00");
                   MaketF->Cells[42][5] = str;
                   strcpy(str,"17:00");
                   MaketF->Cells[43][5] = str;
                   strcpy(str,"18:00");
                   MaketF->Cells[44][5] = str;
                   strcpy(str,"19:00");
                   MaketF->Cells[45][5] = str;
                   strcpy(str,"20:00");
                   MaketF->Cells[46][5] = str;
                   strcpy(str,"21:00");
                   MaketF->Cells[47][5] = str;
                   strcpy(str,"22:00");
                   MaketF->Cells[48][5] = str;
                   strcpy(str,"23:00");
                   MaketF->Cells[49][5] = str;
                   strcpy(str,"24:00");
                   MaketF->Cells[50][5] = str;
                   strcpy(str,"25:00");
                   MaketF->Cells[51][5] = str;
                }
                MaketF->Cells[52][5] = "     ";
                case 2:{
                   strcpy(str,"1:00");
                   MaketF->Cells[53][5] = str;
                   strcpy(str,"2:00");
                   MaketF->Cells[54][5] = str;
                   strcpy(str,"3:00");
                   MaketF->Cells[55][5] = str;
                   strcpy(str,"4:00");
                   MaketF->Cells[56][5] = str;
                   strcpy(str,"5:00");
                   MaketF->Cells[57][5] = str;
                   strcpy(str,"6:00");
                   MaketF->Cells[58][5] = str;
                   strcpy(str,"7:00");
                   MaketF->Cells[59][5] = str;
                   strcpy(str,"8:00");
                   MaketF->Cells[60][5] = str;
                   strcpy(str,"9:00");
                   MaketF->Cells[61][5] = str;
                   strcpy(str,"10:00");
                   MaketF->Cells[62][5] = str;
                   strcpy(str,"11:00");
                   MaketF->Cells[63][5] = str;
                   strcpy(str,"12:00");
                   MaketF->Cells[64][5] = str;
                   strcpy(str,"13:00");
                   MaketF->Cells[65][5] = str;
                   strcpy(str,"14:00");
                   MaketF->Cells[66][5] = str;
                   strcpy(str,"15:00");
                   MaketF->Cells[67][5] = str;
                   strcpy(str,"16:00");
                   MaketF->Cells[68][5] = str;
                   strcpy(str,"17:00");
                   MaketF->Cells[69][5] = str;
                   strcpy(str,"18:00");
                   MaketF->Cells[70][5] = str;
                   strcpy(str,"19:00");
                   MaketF->Cells[71][5] = str;
                   strcpy(str,"20:00");
                   MaketF->Cells[72][5] = str;
                   strcpy(str,"21:00");
                   MaketF->Cells[73][5] = str;
                   strcpy(str,"22:00");
                   MaketF->Cells[74][5] = str;
                   strcpy(str,"23:00");
                   MaketF->Cells[75][5] = str;
                   strcpy(str,"24:00");
                   MaketF->Cells[76][5] = str;
                   strcpy(str,"25:00");
                   MaketF->Cells[77][5] = str;
                }
                }
        }
         //Строки с датами и тут же считаем сколько их будет для вывода значений
        oqMaketInfoCol53->Close();
        oqMaketInfoRow->Cursor=oqMaketInfoCol53->ParamByName("row_t")->AsCursor;
        oqMaketInfoRow->Execute();
        int colRowDate=0;
        while(!oqMaketInfoRow->Eof){
                AnsiString tst = oqMaketInfoRow->FieldByName("Title1")->AsString;
                MaketF->RowCount++;
                MaketF->Cells[0][6+colRowDate] = tst;
                colRowDate++;
                oqMaketInfoRow->Next();
        }
        activeRowNumbers = colRowDate;
        //end

        //fAutoSizeColSG (MaketF);

}

void __fastcall TfmInteriorUni::printDataManyColumn(){
    //querry for values
    oqValCartage->Close();
    oqValCartage->ParamByName("nfid")->AsInteger=FD->IdFormTree;
    oqValCartage->ParamByName("nispoint")->AsInteger=FD->IsPoints;
    oqValCartage->ParamByName("nid")->AsInteger=FD->IdGroup;
    oqValCartage->ParamByName("dfrom")->AsDateTime=FD->dateTimePar;
    oqValCartage->ParamByName("dtill")->AsDateTime=FD->dateTime;
    oqValCartage->ParamByName("data_er")->Length=activeRowNumbers*25;
    oqValCartage->ParamByName("data_q1")->Length=activeRowNumbers*25;
    oqValCartage->ParamByName("data_q3")->Length=activeRowNumbers*25;
    oqValCartage->Execute();
    Dt3 = oqValCartage->ParamByName("forming_data")->AsDateTime;
    long Row=0;
    AnsiString separator = getSeparator();
    //P values
    for(int i=0;i<oqValCartage->ParamByName("data_er")->Length;i++){
        long Col = MaketF->FixedCols+i%(26 - MaketF->FixedCols);
        long Row = 6 + i/25;
        if (!oqValCartage->ParamByName("data_er")->ItemIsNull[i+1]){

                MaketF->Cells[Col][Row] = formFullValue(oqValCartage->ParamByName("data_er")->ItemAsFloat[i+1], separator, DIGITNUMBER);
                }
        }
    //Q+ values
    Row=0;
    for(int i=0;i<oqValCartage->ParamByName("data_q1")->Length;i++){
        long Col = MaketF->FixedCols+i%(26 - MaketF->FixedCols)+(25+1);
        long Row = 6 + i/25;
        if (!oqValCartage->ParamByName("data_q1")->ItemIsNull[i+1])
                MaketF->Cells[Col][Row] = formFullValue(oqValCartage->ParamByName("data_q1")->ItemAsFloat[i+1], separator, DIGITNUMBER);
        }
    //Q- values
    Row=0;
    for(int i=0;i<oqValCartage->ParamByName("data_q3")->Length;i++){
        long Col = MaketF->FixedCols+i%(26 - MaketF->FixedCols)+2*(25+1);
        long Row = 6 + i/25;
        if (!oqValCartage->ParamByName("data_q3")->ItemIsNull[i+1])
                MaketF->Cells[Col][Row] = formFullValue(oqValCartage->ParamByName("data_q3")->ItemAsFloat[i+1], separator, DIGITNUMBER);
        }
    //Q- values
        fAutoSizeColSG (MaketF);
}


//---------------------------------------------------------------------------
//Экспорт содержимого формы в csv-файл, из которого Excel может сгенерить .xls

void __fastcall TfmInteriorUni::SaveMultyTableToFileClick(TObject *Sender)
{
        AnsiString delim = ";";  //разделитель колонок в csv
        /*
        AnsiString char2Del = "\"";
        while (companyName.Pos(char2Del)!=0)   {
                companyName.Delete(companyName.Pos(char2Del),char2Del.Length());
        }
        while (consumerName.Pos(char2Del)!=0)   {
                consumerName.Delete(consumerName.Pos(char2Del),char2Del.Length());
        }
        AnsiString a_name = "Компания "+companyName + " потребитель "+consumerName;
        */
        //Tак от ошибок
        AnsiString a_name = "Отчёт";
        SaveDialog1->FileName = a_name;
        if (SaveDialog1->Execute()){
                AnsiString rowData,str="";
                TStringList* sList=new TStringList;
                AnsiString fileName = SaveDialog1->FileName;
                AnsiString separator = getSeparator(); //разделитель целой и дробной части
                //Вычитываем значения из MaketF
                for (int i = 0; i < MaketF->RowCount; i++){
                        for (int j = 0; j < MaketF->ColCount; j++){
                               rowData =  MaketF->Cells[j][i];
                               if (i>6) //тут значения
                               rowData = StringReplace(rowData,".",separator,TReplaceFlags()<<rfReplaceAll<<rfIgnoreCase);

                               if (rowData!="")
                                        str = str + rowData;
                               if (j !=MaketF->ColCount-1)
                                        str = str + delim;
                        }
                    sList->Add (str);
                    str="";
                }
                //TODO:Перезаписывать без предупреждения, если файл с таким именем существует?
                try{
                        if (!FileExists(fileName))
                                sList->SaveToFile(fileName);
                        else{
                                DeleteFile (fileName);
                                sList->SaveToFile(fileName);
                        }
                }catch (EFCreateError &efce){
                   throw; //To application
                }
        }


}
//---------------------------------------------------------------------------
AnsiString __fastcall TfmInteriorUni::getSeparator(){
 TRegistry *Reg = new TRegistry(KEY_READ);
 AnsiString ExportSeparator = ",";
      try
      {
        Reg->RootKey = HKEY_CURRENT_USER;
        Reg->Access = KEY_READ;
        Reg->OpenKey("\\SOFTWARE\\Grant\\Ascue\\Monitors", False);
        if(Reg->ValueExists("ExportSeparator"))
              ExportSeparator = ((Reg->ReadString("ExportSeparator") == ",") ? (",") : ("."));
        else
             ExportSeparator = (".");
      }
      __finally
      {
        delete Reg;
      }
      return ExportSeparator;
}

//---------------------------------------------------------------------------
//GRB ADD 02.02.2019 добиваем  значение вида xx, xx.y, xx.yy до вида xx.yyy где yyy - число знаков после запятой по умолчанию digitNumber = 3
AnsiString __fastcall TfmInteriorUni::formFullValue (AnsiString row_value, AnsiString separator, int digitNumber){
  AnsiString ret = "";
  int pos = row_value.Pos(separator);
  if (row_value=="") return ret; // на всякий случай
  if (pos == 0){    //нету точки - добавляем её и ещё digitNumber нулей
        ret = row_value.Insert (separator, row_value.Length()+1);
        for (int i = 0; i < digitNumber; i++ ){
           ret = ret.Insert ("0",row_value.Length()+1);
        }
  }else{ //есть точка
   int afterdot = row_value.Length() - pos;
   if ( afterdot >=digitNumber)
        return row_value;
   else{  //добиваем столько сколько нужно до digitNumber нулей
       for (int i = afterdot ; i < digitNumber; i++ )
        ret = row_value.Insert ("0",row_value.Length()+1);
   }
  }
  return ret;
}
//---------------------------------------------------------------------------

void __fastcall TfmInteriorUni::vRefreshReceive30902(TObject *Sender){
printMaketHeader30902();
printMaketValues30902();
fAutoSizeColSG (MaketF);
}
//---------------------------------------------------------------------------

void __fastcall TfmInteriorUni::printMaketHeader30902(){
   //шапка макета
   MaketF->Cells[0][0] = "Код показателя";
   MaketF->Cells[1][0] = "День месяца";
   MaketF->Cells[2][0] = "Сумма за сутки";
   for (int i = 0; i < receive_maket_30902_col_num-receive_maket_30902_fixed_col_num; i++)
   MaketF->Cells[3+i][0] = IntToStr(i+1)+ "-й час";
   //подвал макета
   /*int fin_row = MaketF->RowCount-1;
   MaketF->Cells[0][fin_row] = "Код показателя";
   MaketF->Cells[1][fin_row] = "0";
   MaketF->Cells[2][fin_row] = "Сумма за месяц";
   for (int i = 0; i < 25; i++)
   MaketF->Cells[3+i][fin_row] ="Сумма "+ IntToStr(i+1)+ "-й час";*/

}
//---------------------------------------------------------------------------
void __fastcall TfmInteriorUni::printMaketValues30902(){
  for (int i = 1; i < maketRow->Count-1; i++){
        AnsiString currRow = clear_prob(maketRow->operator[](i));
        TStringList * MyList = new TStringList();
        MyList->Delimiter = L':';
        MyList->DelimitedText = currRow;
        for (int j = 0; j < receive_maket_30902_col_num; j++)
                MaketF->Cells[j][i] = MyList->operator[](j);
        delete MyList;
  }
}
//---------------------------------------------------------------------------
int __fastcall TfmInteriorUni::getBlockSize_902(){ //Определяем когда начинает повторяться 1й код в макете - считаем что это фактическое количество показателей
        int ret = 1;
        AnsiString cod1, currCod;
        cod1 = ""; currCod = "";
        for (int i = 1; i < maketRow->Count-1; i++){
        AnsiString currRow = clear_prob(maketRow->operator[](i));
        TStringList * MyList = new TStringList();
        MyList->Delimiter = L':';
        MyList->DelimitedText = currRow;
        if (i == 1) {
        cod1 = MyList->operator[](0);
        continue;
        }
        else{
            currCod  = MyList->operator[](0);
            if (CompareText (cod1, currCod)==0){
                //if (ret>10) return 10;
                return ret;
            }else{
            ret++;
            }
            }
        delete MyList;
        }

        return ret;
}
//---------------------------------------------------------------------------
AnsiString __fastcall TfmInteriorUni::clear_prob (AnsiString str){
        AnsiString st = str;
        for(; st.Pos(" "); st = AnsiReplaceText(st, " ", ""));
        return st;
}
//---------------------------------------------------------------------------
//определяем максимальную текстовку по колонке
int __fastcall TfmInteriorUni::getMaxSymbolInColumn (TStringGrid* tsg, int column){
        int ret = 0;
        int max = 0;
        for (int i = 0; i < tsg->RowCount; i++){
                if (tsg->Cells[column][i].Length() > max) max = tsg->Cells[column][i].Length();
        }
        return max;
}
//---------------------------------------------------------------------------
//добиваем пробелами до максимума по колонке с тем чтобы цивильно форматировалось в файле
AnsiString __fastcall TfmInteriorUni::add_Prob_to_Max_Size (AnsiString row, int max_size){
        AnsiString ret = row;
        for (int i = row.Length(); i <max_size; i++)
                ret = ret + " ";
        return ret;
}
//---------------------------------------------------------------------------



