//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#include "ControlVolueDB.h"
#include <stdio.h>
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "DBGridEh"
#pragma link "VirtualTable"
#pragma link "MemDS"
#pragma resource "*.dfm"
//---------------------------------------------------------------------------
__fastcall TFormControlVolueDB::TFormControlVolueDB(TComponent* Owner, AnsiString Name, TAccess a)
	: TMainForm(Owner, Name, a)
{
   TreeDecr[0]= 100;
   TreeDecr[1]= 20;
   TreeDecr[2]= 20;
   TreeDecr[3]= 20;
}
//---------------------------------------------------------------------------
bool  TFormControlVolueDB::TreeRead()
{
   DB_TERM *TreeTable;
   VirtualTable1StoragePeriod->OnChange = NULL;
   VirtualTable1Arc->OnChange = NULL;
   VirtualTable1Extention->OnChange = NULL;
   VirtualTable1->AfterInsert=NULL;
  try
  {
   VirtualTable1->DisableControls();
   VirtualTable1->Open();
   VirtualTable1->Clear();

   dmMain->oqCursor->Params->Clear();
   //GRB ADD 05.09.2019 try to fix char* to AnsiString convert error :)
   /*char buf[100];
   memset(buf, 0, sizeof(buf));
   strcpy (buf, "begin ");
   strcat (buf, SchemeName.c_str());
   strcat (buf, "DBTERM_PG.tree_read(:par1); end;");
   AnsiString sqlText = "";
   sqlText = (AnsiString) buf;
   dmMain->oqCursor->SQL->Text= sqlText; */
   //
   //FAIL GRB NOT REMOVE NEXT STRING 05.09.2019 - looks like oqCursor used in different threads - see unDataMod
   dmMain->oqCursor->SQL->Text= "begin "+SchemeName+"DBTERM_PG.tree_read(:par1); end;";
   dmMain->oqCursor->ParamByName("par1")->ParamType = ptOutput;
   dmMain->oqCursor->ParamByName("par1")->DataType = ftCursor;

       dmMain->oqCursor->Execute();
       while(!dmMain->oqCursor->Eof){
       TreeTable=new DB_TERM;
       ZeroMemory(TreeTable,sizeof(DB_TERM));
       if(!dmMain->oqCursor->FieldByName("data_name")->IsNull)
       strcpy(TreeTable->data_name,dmMain->oqCursor->FieldByName("data_name")->AsString.c_str());
       if(!dmMain->oqCursor->FieldByName("table_name")->IsNull)
       strcpy(TreeTable->table_name,dmMain->oqCursor->FieldByName("table_name")->AsString.c_str());
       if(!dmMain->oqCursor->FieldByName("term")->IsNull)
       TreeTable->term=dmMain->oqCursor->FieldByName("term")->AsInteger;
       if(!dmMain->oqCursor->FieldByName("narchived")->IsNull)
       TreeTable->Archived=dmMain->oqCursor->FieldByName("narchived")->AsInteger;
       if(!dmMain->oqCursor->FieldByName("vextention")->IsNull)
       strcpy(TreeTable->Extension,dmMain->oqCursor->FieldByName("vextention")->AsString.c_str());
         VirtualTable1->Append();
         VirtualTable1->FieldByName("Table")->AsString = TreeTable->table_name;
         VirtualTable1->FieldByName("Data")->AsString = TreeTable->data_name;
         VirtualTable1->FieldByName("StoragePeriod")->AsInteger = TreeTable->term;
         VirtualTable1->FieldByName("Arc")->AsInteger  = TreeTable->Archived;
         VirtualTable1->FieldByName("Extention")->AsString  = TreeTable->Extension;
         VirtualTable1->FieldByName("Modified")->AsBoolean  = false;
         VirtualTable1->Post();
         dmMain->oqCursor->Next();
         }
    }
  __finally
  {

    VirtualTable1->First();
    VirtualTable1->EnableControls();
  }
   DBGridEh1->Col=2;
   VirtualTable1StoragePeriod->OnChange = VirtualTable1FieldChange;
   VirtualTable1Arc->OnChange = VirtualTable1FieldChange;
   VirtualTable1Extention->OnChange = VirtualTable1FieldChange;
   VirtualTable1->AfterInsert=VirtualTable1AfterInsert;

  EditRec=false;
  return true;
}
//--------------------------------------------------------------------------
bool  TFormControlVolueDB::TreeWrite()
{
  int i;
  DB_TERM TreeTable;

 	AnsiString sqlU= "begin "+SchemeName+"DBTERM_PG.UPD_TERM(:par1,:par2,:par3,:par4); end;";

     VirtualTable1->DisableControls();
     VirtualTable1->First();
     while(!VirtualTable1->Eof){
       if(!VirtualTable1->FieldByName("Modified")->AsBoolean){
         VirtualTable1->Next();
         continue;
        }
        sprintf(TreeTable.table_name,"%s",VirtualTable1->FieldByName("Table")->AsString.c_str());
        TreeTable.term = VirtualTable1->FieldByName("StoragePeriod")->AsInteger;
        TreeTable.Archived = VirtualTable1->FieldByName("Arc")->AsInteger;
        sprintf(TreeTable.Extension,"%s",VirtualTable1->FieldByName("Extention")->AsString.c_str());
        dmMain->oqCursor->Params->Clear();
        dmMain->oqCursor->SQL->Text=sqlU;
        dmMain->oqCursor->ParamByName("par1")->AsString=TreeTable.table_name;
        dmMain->oqCursor->ParamByName("par2")->AsInteger=TreeTable.term;
        dmMain->oqCursor->ParamByName("par3")->AsInteger=TreeTable.Archived;
        dmMain->oqCursor->ParamByName("par4")->AsString=TreeTable.Extension;
        try{
         dmMain->oqCursor->Execute();
        }catch (Exception &exception){
          dmMain->orases->Rollback();
          VirtualTable1->EnableControls();
         	Application->ShowException(&exception);
          return false;
        }
        VirtualTable1->Next();
     }
     dmMain->orases->Commit();
     VirtualTable1->First();
     while(!VirtualTable1->Eof){
      VirtualTable1->Edit();
      VirtualTable1->FieldByName("Modified")->AsBoolean = false;
      VirtualTable1->Post();
      VirtualTable1->Next();
     }
     EditRec=false;
     VirtualTable1->First();
     VirtualTable1->EnableControls();
     return true;
}
//--------------------------------------------------------------------------
void __fastcall TFormControlVolueDB::vSave(TObject *Sender)
{ //save
  TreeWrite();
}
//---------------------------------------------------------------------------
void __fastcall TFormControlVolueDB::vRefresh(TObject *Sender)
{//consel
// if(EditRec)
{
  TreeRead();
  EditRec=false;
 }
}
//---------------------------------------------------------------------------
void __fastcall TFormControlVolueDB::FormCreate(TObject *Sender)
{
   TreeRead();
}
//---------------------------------------------------------------------------
void __fastcall TFormControlVolueDB::SetAccess(TAccess value)
{
   if(FAccess != value) {
      TMainForm::SetAccess(value);
      DBGridEh1->Enabled = value==accWrite;
   }
}
//---------------------------------------------------------------------------
void __fastcall TFormControlVolueDB::VirtualTable1FieldChange(
      TField *Sender)
{
     EditRec = true;
     VirtualTable1->FieldByName("Modified")->AsBoolean  = true;
}
//---------------------------------------------------------------------------
void __fastcall TFormControlVolueDB::DBGridEh1ColEnter(TObject *Sender)
{
    if(DBGridEh1->Col<2)
      DBGridEh1->Col=2;
}
//---------------------------------------------------------------------------
void __fastcall TFormControlVolueDB::VirtualTable1AfterInsert(
      TDataSet *DataSet)
{
  DataSet->Cancel();
}
//---------------------------------------------------------------------------

void __fastcall TFormControlVolueDB::SaveTableToFile(TComponent* Owner,TDBGridEh *gr,AnsiString RepCaption){
 AnsiString Language;
     TRegistry *Reg = new TRegistry(KEY_READ);
     AnsiString delim = ";";
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
    aSaveDialog->FileName = "Контроль вмісту БД";
    aSaveDialog->DefaultExt = "xls";
    aSaveDialog->Filter = "Excel-таблиця (*.xls)|*.xls|Файл з роздільником (*.csv)|*.csv|Текстові документи (*.txt)|*.txt";
    }else{
    aSaveDialog->Title = "Сохранить в файл...";
    aSaveDialog->FileName = "Контроль объёма БД";
    aSaveDialog->DefaultExt = "xls";
    aSaveDialog->Filter = "Excel-таблица (*.xls)|*.xls|Файл с разделителем (*.csv)|*.csv|Текстовые документы (*.txt)|*.txt";
    }
    aSaveDialog->Options << ofOverwritePrompt;
    if(aSaveDialog->Execute())
    {
    AnsiString s;
    TStringList *StringList;
    TBookmark SavePlace;
    AnsiString  tab = char(9);
    TDataSet  *ds = gr->DataSource->DataSet;
    if (!ds || !ds->Active){
       Application->MessageBox(Reconst_smes44_4.c_str(),Application->Title.c_str(),MB_OK | MB_ICONSTOP);
       return;
    }
    try{
    StringList  = new TStringList;
    //Завголовок
    if(!RepCaption.IsEmpty())
      StringList->Add(RepCaption);
    s="";
    for (int i = 0; i < gr->Columns->Count; i++){
      if(gr->Columns->Items[i]->Visible&&gr->Columns->Items[i]->Field){
        if(!s.IsEmpty())
          s += tab;
        s+= gr->Columns->Items[i]->Title->Caption;
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
      for (int i = 0; i < gr->Columns->Count; i++){
        if (gr->Columns->Items[i]->Visible&&gr->Columns->Items[i]->Field){
          if(!s.IsEmpty())
            s += tab;
          if (gr->Columns->Items[i]->FieldName == "Arc"){
            if (StrToInt (gr->Columns->Items[i]->Field->AsString)==1)  s += "Да";
            else s += "Нет";
            }
          else
            s += gr->Columns->Items[i]->Field->AsString;
        }
      }
      StringList->Add(s);
      cn++;
      ds->Next();
    }
    ds->GotoBookmark(SavePlace);
    ds->FreeBookmark(SavePlace);
    ds->EnableControls();
    StringList->SaveToFile(aSaveDialog->FileName);
    delete  StringList;
    Application->MessageBox(AnsiString(AnsiString(Reconst_smes44_8) +
                              aSaveDialog->FileName +
                              AnsiString(Reconst_smes44_9) +
                              IntToStr(cn) +
                              AnsiString(Reconst_smes44_10)).c_str(),
                            Application->Title.c_str(),
                            MB_OK | MB_ICONINFORMATION); 
  }
  catch (Exception &e){
    delete  StringList;
    throw;
  }

 }
}
//---------------------------------------------------------------------------

void __fastcall TFormControlVolueDB::BitBtn1Click(TObject *Sender)
{
SaveTableToFile(this,DBGridEh1,TDateTime::CurrentDateTime().FormatString("dd.mm.yyyy hh:nn:ss")+"       "+this->Caption);
}
//---------------------------------------------------------------------------

