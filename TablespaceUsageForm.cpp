//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "unDataMod.h"
#include "TablespaceUsageForm.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "DBAccess"
#pragma link "MemDS"
#pragma link "Ora"
#pragma link "DBGridEh"
#pragma resource "*.dfm"
TTablespaceUsage *TablespaceUsage;
//---------------------------------------------------------------------------
__fastcall TTablespaceUsage::TTablespaceUsage(TComponent* Owner)
  : TForm(Owner)
{
  try {
    oqTablespaceUsage->Execute();
    drawTable();
  }
  __except(EXCEPTION_EXECUTE_HANDLER) {
  }
}
//---------------------------------------------------------------------------

void __fastcall TTablespaceUsage::grTablespaceDrawColumnCell(
      TObject *Sender, const TRect &Rect, int DataCol, TColumnEh *Column,
      TGridDrawState State)
{
  TRect r = Rect;
  AnsiString s;
  tagRECT rct;

  if (((Column->Field->FieldName == "USAGE") ||
     (Column->Field->FieldName == "PCT_USED") ||
     (Column->Field->FieldName == "PCT_FREE")) && (!State.Contains(gdFixed))) {
    r.left++;
    r.right--;
    r.top++;
    r.bottom--;
    r.right = r.left + (r.Width() * Column->Field->AsInteger) / 100;
    //grTablespace->Canvas->Brush->Color = (Column->Field->FieldName == "USAGE"&&Column->Field->AsInteger>90)?clRed:(TColor)0xe0a040;
    //grTablespace->Canvas->Brush->Style = bsSolid;
    //grTablespace->Canvas->FillRect(r);
    r.left = r.right;
    r.right = Rect.right;
    //grTablespace->Canvas->Brush->Color = grTablespace->Color;
    //grTablespace->Canvas->Brush->Style = bsSolid;
    //grTablespace->Canvas->FillRect(r);
    //grTablespace->Canvas->Font->Assign(Column->Font);
    s = Column->Field->AsInteger;
    s += " %";
    rct = Rect;
    //grTablespace->Canvas->Brush->Style = bsClear;
    //DrawText(grTablespace->Canvas->Handle, s.c_str(), -1, &rct, DT_CENTER + DT_VCENTER + DT_SINGLELINE);
  } else {
    //grTablespace->DefaultDrawColumnCell(Rect, DataCol, Column, State);
  }
}
//---------------------------------------------------------------------------

void __fastcall TTablespaceUsage::grTablespaceDrawFooterCell(
      TObject *Sender, int DataCol, int Row, TColumnEh *Column,
      TRect &Rect, TGridDrawState State)
{
  //grTablespace->DefaultDrawFooterCell(Rect, DataCol, Row, Column, State);
}
//---------------------------------------------------------------------------

void __fastcall TTablespaceUsage::btnRefreshClick(TObject *Sender)
{
    oqTablespaceUsage->Execute();
    drawTable();
}
//---------------------------------------------------------------------------
void __fastcall TTablespaceUsage::fAutoSizeColSG(TStringGrid* StringGrid) {

    int iTempColSize = 0; //
    int iMaxColSize = 0; //

    for (int j = 0; j <= StringGrid->ColCount - 1; j++) {
        for (int i = 0; i <= StringGrid->RowCount - 1; i++) {
            iTempColSize = StringGrid->Canvas->TextWidth
                (StringGrid->Cells[j][i]);
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

        iTempColSize = 0; //
        iMaxColSize = 0;
    }

}
//---------------------------------------------------------------------------
/*void __fastcall TTablespaceUsage::drawTable(){
    int i = 0;
    while (!oqTablespaceUsage->Eof){
      if (!oqTablespaceUsage->FieldByName("TABLESPACE_NAME")->IsNull){
        tablespace_name[i] = oqTablespaceUsage->FieldByName("TABLESPACE_NAME")->AsString;
      }
      if (!oqTablespaceUsage->FieldByName("MEGS_ALLOC")->IsNull){
        megs_alloc[i] = oqTablespaceUsage->FieldByName("MEGS_ALLOC")->AsInteger;
      }
      if (!oqTablespaceUsage->FieldByName("MEGS_FREE")->IsNull){
        megs_free[i] = oqTablespaceUsage->FieldByName("MEGS_FREE")->AsInteger;
      }
      if (!oqTablespaceUsage->FieldByName("MEGS_USED")->IsNull){
        megs_used[i] = oqTablespaceUsage->FieldByName("MEGS_USED")->AsInteger;
      }
      if (!oqTablespaceUsage->FieldByName("PCT_FREE")->IsNull){
        pct_free[i] = oqTablespaceUsage->FieldByName("PCT_FREE")->AsInteger;
      }
      if (!oqTablespaceUsage->FieldByName("PCT_USED")->IsNull){
        pct_used[i] = oqTablespaceUsage->FieldByName("PCT_USED")->AsInteger;
      }
      if (!oqTablespaceUsage->FieldByName("MAX")->IsNull){
        max[i] = oqTablespaceUsage->FieldByName("MAX")->AsInteger;
      }
      if (!oqTablespaceUsage->FieldByName("USAGE")->IsNull){
        usage[i] = oqTablespaceUsage->FieldByName("USAGE")->AsInteger;
      }
      i++;
      oqTablespaceUsage->Next();
    }
     //Начали локализацию
     //GRB ADD 20.09.2019 - локализуем шапку таблицы
     AnsiString Language;
     TRegistry *Reg = new TRegistry(KEY_READ);
     try{
        Reg->RootKey =HKEY_LOCAL_MACHINE;
        Reg->Access=KEY_READ;
        Reg->OpenKey("SOFTWARE\\INTEP\\ASKUE", False);
        Language = Reg->ReadString("Language");
        if(!Language.Length()){
                char c[256];
                   GetLocaleInfo(GetSystemDefaultLCID(), LOCALE_SABBREVLANGNAME, c, sizeof(c));
                   Language=c;
                }
            }__finally{
                delete Reg;
        }
     for (int i = 0 ; i < MAX_COLUMN; i++)
        colNames[i] = colNamesRus[i];
     AnsiString allRow = allRowRus;
     if (Language =="UKR"){
       for (int i = 0 ; i < MAX_COLUMN; i++)
        colNames[i] = colNamesUkr[i];
       allRow = allRowUkr;
     }
     //закончили локализацию шапки
    for (int i = 0; i < MAX_COLUMN; i++){
        StringGrid1->Cells [i][0] = colNames[i];
    }

    for (int i = 0; i < MAX_ROW; i++)
        StringGrid1->Cells[0][i+1] = tablespace_name[i];
    for (int i = 0; i < MAX_ROW; i++)
        StringGrid1->Cells[1][i+1] = (pct_used[i]+"%");
    for (int i = 0; i < MAX_ROW; i++)
        StringGrid1->Cells[2][i+1] = (pct_free[i]+"%");
    for (int i = 0; i < MAX_ROW; i++)
        StringGrid1->Cells[3][i+1] = megs_alloc[i];
    for (int i = 0; i < MAX_ROW; i++)
        StringGrid1->Cells[4][i+1] = megs_used[i];
    for (int i = 0; i < MAX_ROW; i++)
        StringGrid1->Cells[5][i+1] = megs_free[i];
    for (int i = 0; i < MAX_ROW; i++)
        StringGrid1->Cells[6][i+1] = max[i];
    for (int i = 0; i < MAX_ROW; i++)
        StringGrid1->Cells[7][i+1] = (usage[i]+"%");
    StringGrid1->Cells [0][6] = allRow;
    long sum_by_column = 0;
    for (int i = 0; i < MAX_ROW; i++)
       sum_by_column+=StrToInt(megs_alloc[i]);
    StringGrid1->Cells [3][6] = sum_by_column;
    sum_by_column = 0;
    for (int i = 0; i < MAX_ROW; i++)
       sum_by_column+=StrToInt(megs_used[i]);
    StringGrid1->Cells [4][6] = sum_by_column;
    fAutoSizeColSG (StringGrid1);
}*/

void __fastcall TTablespaceUsage::SaveTableToFile(TObject *Sender)
{
    AnsiString Language;
     TRegistry *Reg = new TRegistry(KEY_READ);
     AnsiString delim = ";";
     aSaveDialog->DefaultExt = "csv";
     try{
        Reg->RootKey =HKEY_LOCAL_MACHINE;
        Reg->Access=KEY_READ;
        Reg->OpenKey("SOFTWARE\\INTEP\\ASKUE", False);
        Language = Reg->ReadString("Language");
        if(!Language.Length()){
                char c[256];
                   GetLocaleInfo(GetSystemDefaultLCID(), LOCALE_SABBREVLANGNAME, c, sizeof(c));
                   Language=c;
                }
            }__finally{
                delete Reg;
        }
    if (Language=="UKR"){
    aSaveDialog->Title = "Зберегти до файла...";
    aSaveDialog->FileName = "Табличний простір";
    aSaveDialog->Filter = "Текстові документи (*.txt)|*.txt|Файл з роздільником (*.csv)|*.csv|Excel-таблиця (*.xls)|*.xls";
    }else{
    aSaveDialog->Title = "Сохранить в файл...";
    aSaveDialog->FileName = "Табличное пространство";
    aSaveDialog->DefaultExt = "csv";
    aSaveDialog->Filter = "Текстовые документы (*.txt)|*.txt|Файл с разделителем (*.csv)|*.csv|Excel-таблица (*.xls)|*.xls";
    }
    if(aSaveDialog->Execute())
    {
                AnsiString rowData,str="";
                TStringList* sList=new TStringList;
                AnsiString fileName = aSaveDialog->FileName;
                AnsiString separator = getSeparator();

                for (int i = 0; i < StringGrid1->RowCount; i++){
                        for (int j = 0; j < StringGrid1->ColCount; j++){
                               rowData =  StringGrid1->Cells[j][i];
                               rowData = rowData+delim;
                               if (rowData!="")
                                        str = str + rowData;
                        }
                    sList->Add (str);
                    str="";
                }
                try{
                        if (!FileExists(fileName))
                                sList->SaveToFile(fileName);
                        else{
                                DeleteFile (fileName);
                                sList->SaveToFile(fileName);
                        }
                }catch (EFCreateError &efce){
                   throw;
                }
    }
}

void __fastcall TTablespaceUsage::drawTable(){
    int i = 0;
    while (!oqTablespaceUsage->Eof && i < MAX_ROW){
        if (!oqTablespaceUsage->FieldByName("TABLESPACE_NAME")->IsNull)
            tablespace_name[i] = oqTablespaceUsage->FieldByName("TABLESPACE_NAME")->AsString;
        else
            tablespace_name[i] = "";

        if (!oqTablespaceUsage->FieldByName("MEGS_ALLOC")->IsNull)
            megs_alloc[i] = oqTablespaceUsage->FieldByName("MEGS_ALLOC")->AsString;
        else
            megs_alloc[i] = "0";

        if (!oqTablespaceUsage->FieldByName("MEGS_FREE")->IsNull)
            megs_free[i] = oqTablespaceUsage->FieldByName("MEGS_FREE")->AsString;
        else
            megs_free[i] = "0";

        if (!oqTablespaceUsage->FieldByName("MEGS_USED")->IsNull)
            megs_used[i] = oqTablespaceUsage->FieldByName("MEGS_USED")->AsString;
        else
            megs_used[i] = "0";

        if (!oqTablespaceUsage->FieldByName("PCT_FREE")->IsNull)
            pct_free[i] = oqTablespaceUsage->FieldByName("PCT_FREE")->AsString;
        else
            pct_free[i] = "0";

        if (!oqTablespaceUsage->FieldByName("PCT_USED")->IsNull)
            pct_used[i] = oqTablespaceUsage->FieldByName("PCT_USED")->AsString;
        else
            pct_used[i] = "0";

        if (!oqTablespaceUsage->FieldByName("MAX")->IsNull)
            max[i] = oqTablespaceUsage->FieldByName("MAX")->AsString;
        else
            max[i] = "0";

        if (!oqTablespaceUsage->FieldByName("USAGE")->IsNull)
            usage[i] = oqTablespaceUsage->FieldByName("USAGE")->AsString;
        else
            usage[i] = "0";

        i++;
        oqTablespaceUsage->Next();
    }
    int realRows = i;

    // ??????????? ?????
    AnsiString Language;
    TRegistry *Reg = new TRegistry(KEY_READ);
    try {
        Reg->RootKey = HKEY_LOCAL_MACHINE;
        Reg->Access = KEY_READ;
        if (Reg->OpenKey("SOFTWARE\\INTEP\\ASKUE", False))
            Language = Reg->ReadString("Language");
        if (!Language.Length()){
            char c[256];
            GetLocaleInfo(GetSystemDefaultLCID(), LOCALE_SABBREVLANGNAME, c, sizeof(c));
            Language = c;
        }
    } __finally {
        delete Reg;
    }

    for (int k = 0; k < MAX_COLUMN; k++)
        colNames[k] = colNamesRus[k];
    AnsiString allRow = allRowRus;

    if (Language == "UKR") {
        for (int k = 0; k < MAX_COLUMN; k++)
            colNames[k] = colNamesUkr[k];
        allRow = allRowUkr;
    }

    // ?????????? ????? ???????
    for (int k = 0; k < MAX_COLUMN; k++){
        StringGrid1->Cells[k][0] = colNames[k];
    }

    // ?????????? ????? ??????
    StringGrid1->RowCount = realRows + 2;

    long total_alloc = 0;
    long total_used = 0;

    for (int r = 0; r < realRows; r++) {
        StringGrid1->Cells[0][r+1] = tablespace_name[r];
        StringGrid1->Cells[1][r+1] = pct_used[r] + "%";
        StringGrid1->Cells[2][r+1] = pct_free[r] + "%";
        StringGrid1->Cells[3][r+1] = megs_alloc[r];
        StringGrid1->Cells[4][r+1] = megs_used[r];
        StringGrid1->Cells[5][r+1] = megs_free[r];
        StringGrid1->Cells[6][r+1] = max[r];
        StringGrid1->Cells[7][r+1] = usage[r] + "%";

        total_alloc += StrToIntDef(megs_alloc[r], 0);
        total_used  += StrToIntDef(megs_used[r], 0);
    }

    // ???????? ??????
    int summaryRow = realRows + 1;
    StringGrid1->Cells[0][summaryRow] = allRow;
    StringGrid1->Cells[3][summaryRow] = total_alloc;
    StringGrid1->Cells[4][summaryRow] = total_used;

    fAutoSizeColSG(StringGrid1);
}

//---------------------------------------------------------------------------
AnsiString __fastcall TTablespaceUsage::getSeparator(){
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

