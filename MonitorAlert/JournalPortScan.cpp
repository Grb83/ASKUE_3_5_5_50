//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#include "JournalPortScan.h"
#include "unDataMod.h"
#include "Filter.h"
#include "Reconst.hpp"
#include "unComportEvents.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "MemDS"
#pragma link "VirtualTable"
#pragma link "DBGridEh"
#pragma link "DBAccess"
#pragma link "Ora"
#pragma resource "*.dfm"
//---------------------------------------------------------------------------
__fastcall TdlgJournalPortScan::TdlgJournalPortScan(TComponent* Owner)
	: TForm(Owner)
{
  desc1=0;
  desc2=0;
  desc3=0;
  sort = 0;

    cbScan->Items->Clear();
    for(int i=0;i<dmMain->SrvList->Count;i++)
         cbScan->Items->AddObject(dmMain->SrvList->Strings[i],(TObject *)dmMain->SrvList->Objects[i]);
  if(dmMain->SrvList->Count==1){
    paCOM->Enabled=false;
    paCOM->Height=1;
  }
  cbScan->ItemIndex=0;
  SelectData();
  Caption = Reconst_smes95_1;
  RefreshData();
}
//---------------------------------------------------------------------------
void __fastcall TdlgJournalPortScan::SelectData( void )
{
  TListItem *LI;
  try{
     MessageGrid1->Items->Clear();
     oqSSD->Params->Clear();
     oqSSD->SQL->Text= "begin "+SchemeName+"COMPORTS_PG.select_data(:par1,:par2); end;";
     oqSSD->ParamByName("par1")->AsInteger=(int)cbScan->Items->Objects[cbScan->ItemIndex];
     oqSSD->ParamByName("par2")->ParamType = ptOutput;
     oqSSD->ParamByName("par2")->DataType = ftCursor;
    oqSSD->Execute();
    while(!oqSSD->Eof){
                LI = MessageGrid1->Items->Add();
                LI->SubItems->Add(oqSSD->FieldByName("field1")->AsString);
                LI->SubItems->Add("");
                LI->SubItems->Add("");
                oqSSD->Next();
    }
    oqSSD->Close();
    if(MessageGrid1->Items->Count){
      MessageGrid1->Selected = MessageGrid1->Items->Item[0];
      MessageGrid1->ItemFocused = MessageGrid1->Items->Item[0];
    }
    
   }catch(Exception &exception)
    {
        Application->ShowException(&exception);
    }
   }
 //-----------------------------------------------------------------------------------
 void __fastcall TdlgJournalPortScan::cbScanChange(TObject *Sender)
{
  SelectData();
  RefreshData();
}
//---------------------------------------------------------------------------
 bool __fastcall TdlgJournalPortScan::RefreshData( void )
{
  try{
    oqSSD->Params->Clear();
    oqSSD->SQL->Text = "begin "+SchemeName+"COMPORTS_PG.refresh_data(:par1,:par2); end;";
    oqSSD->ParamByName("par1")->AsInteger=(int)cbScan->Items->Objects[cbScan->ItemIndex];
    oqSSD->ParamByName("par2")->ParamType = ptOutput;
    oqSSD->ParamByName("par2")->DataType = ftCursor;
    oqSSD->Execute();
    MessageGrid1->Items->BeginUpdate();
    while(!oqSSD->Eof){
      for(int i=0; i< MessageGrid1->Items->Count;i++){
        if(MessageGrid1->Items->Item[i]->SubItems->Strings[0] == oqSSD->FieldByName("field1")->AsString){
          if(MessageGrid1->Items->Item[i]->SubItems->Strings[1]!= oqSSD->FieldByName("field2")->AsString)
            MessageGrid1->Items->Item[i]->SubItems->Strings[1]= oqSSD->FieldByName("field2")->AsString;
          if(MessageGrid1->Items->Item[i]->SubItems->Strings[2]!= oqSSD->FieldByName("field3")->AsString)
            MessageGrid1->Items->Item[i]->SubItems->Strings[2]= oqSSD->FieldByName("field3")->AsString;
          break;
        }
      }
      oqSSD->Next();
    }
    oqSSD->Close();
    MessageGrid1->Items->EndUpdate();
  }catch(Exception &exception){
    Application->ShowException(&exception);
    return false;
  }
  return true;
}
//---------------------------------------------------------------------------
void __fastcall TdlgJournalPortScan::Timer1Timer(TObject *Sender)
{
   Timer1->Enabled=false;
   RefreshData();
   Timer1->Enabled=true;
}
//---------------------------------------------------------------------------
/*! Отображение полного содержимого ячейки в отдельном окне.
*/
void __fastcall TdlgJournalPortScan::MessageGrid1DblClick(
      TObject *Sender)
{
    if(!MessageGrid1->Selected&&MessageGrid1->Items->Count>0)
    {
        MessageGrid1->ItemFocused = MessageGrid1->Items->Item[MessageGrid1->Items->Count-1];
        MessageGrid1->ItemFocused->Selected = true;
    }

    AnsiString selectedCOM = "";
    if (MessageGrid1->ItemFocused) selectedCOM = "COM" + MessageGrid1->ItemFocused->SubItems->Strings[0];
    TfmComportEvents *f=new TfmComportEvents(this,
      (int)cbScan->Items->Objects[cbScan->ItemIndex],
      selectedCOM);
    f->Show();
/*        ShowMessage(MessageGrid1->ItemFocused->SubItems->Strings[1] + "\n" +
                    MessageGrid1->ItemFocused->SubItems->Strings[2]);
*/
}
//---------------------------------------------------------------------------
void __fastcall TdlgJournalPortScan::MessageGrid1ColumnClick(
      TObject *Sender, TListColumn *Column)
{
  if (!Column)
    return;
  switch (Column->Index)
  { case 1:
        sort = desc1?(-1)*Column->Index:Column->Index;
        desc1 = !desc1;
      break;
    case 2:
        sort = desc2?(-1)*Column->Index:Column->Index;
        desc2 = !desc2;
      break;
    case 3:
        sort = desc3?(-1)*Column->Index:Column->Index;
        desc3 = !desc3;
      break;
  }
  Timer1->Enabled=false;
  SortData();
  Timer1->Enabled=true;
}
//---------------------------------------------------------------------------
 void __fastcall TdlgJournalPortScan::SortData( void )
{
  try{
    TListItem *LI;
    oqSSD->Params->Clear();
    oqSSD->SQL->Text = "begin "+SchemeName+"COMPORTS_PG.sort_data(:par1,:par2,:par3); end;";
    oqSSD->ParamByName("par1")->AsInteger=(int)cbScan->Items->Objects[cbScan->ItemIndex];
    oqSSD->ParamByName("par2")->AsInteger=sort;
    oqSSD->ParamByName("par3")->ParamType = ptOutput;
    oqSSD->ParamByName("par3")->DataType = ftCursor;
    oqSSD->Execute();
     MessageGrid1->Items->BeginUpdate();
     MessageGrid1->Items->Clear();
     while(!oqSSD->Eof){
                LI = MessageGrid1->Items->Add();
                LI->SubItems->Add(oqSSD->FieldByName("field1")->AsString);
              if(!oqSSD->FieldByName("field2")->IsNull)
                LI->SubItems->Add(oqSSD->FieldByName("field2")->AsDateTime.FormatString("dd.mm.yyyy hh:nn:ss"));
              else LI->SubItems->Add("");
                LI->SubItems->Add(oqSSD->FieldByName("field3")->AsString);
                oqSSD->Next();
          }
    oqSSD->Close();
    MessageGrid1->Items->EndUpdate();
    if(MessageGrid1->Items->Count){
      MessageGrid1->Selected = MessageGrid1->Items->Item[0];
      MessageGrid1->ItemFocused = MessageGrid1->Items->Item[0];
    }
  }catch(Exception &exception)
    {
        Application->ShowException(&exception);
    }
}
//---------------------------------------------------------------------------
void __fastcall TdlgJournalPortScan::FormShow(TObject *Sender)
{
  MessageGrid1->SetFocus();
  Timer1->Enabled=true;
}
//---------------------------------------------------------------------------

void __fastcall TdlgJournalPortScan::btJournalClick(TObject *Sender)
{
  TfmComportEvents *f=new TfmComportEvents(this,(int)cbScan->Items->Objects[cbScan->ItemIndex],"");
  f->Show();
}
//---------------------------------------------------------------------------




void __fastcall TdlgJournalPortScan::BitBtn1Click(TObject *Sender)
{
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
if (Language=="UKR"){
    SaveDialog1->Title = "Зберегти до файла...";
    SaveDialog1->FileName = "Сервер сбору даних";
    SaveDialog1->DefaultExt = "xls";
    SaveDialog1->Filter = "Excel-таблиця (*.xls)|*.xls|Файл з роздільником (*.csv)|*.csv|Текстові документи (*.txt)|*.txt";
    }else{
    SaveDialog1->Title = "Сохранить в файл...";
    SaveDialog1->FileName = "Сервер сбора данных";
    SaveDialog1->DefaultExt = "xls";
    SaveDialog1->Filter = "Excel-таблица (*.xls)|*.xls|Файл с разделителем (*.csv)|*.csv|Текстовые документы (*.txt)|*.txt";
    }
SaveDialog1->Options << ofOverwritePrompt;
SaveDialog1->FileName = this->Caption+ "_от_"+Date().CurrentDate();
if (SaveDialog1->Execute()){
                //GRB FIX 09.04.2019 - заменили разделитель колонок в csv-файле с запятой, на более естественный для Excel'я точку с запятой - и ниже по тексту файла меняем ;  на . в названиях колонок и данных 
                AnsiString delim = ";";
                AnsiString rowData,str="";
                TStringList* sList=new TStringList;
                AnsiString fileName = SaveDialog1->FileName;
                //Вычитываем заголовки TListView первой строкой
                for(int i=1;i<MessageGrid1->Columns->Count;i++){
                        rowData = MessageGrid1->Columns->Items[i]->Caption;
                        //экранируем(меняем на точки) точку с запятой(разделитель) (GRB FIX от 09.04.2019 - раньше была запятая), чтобы не появлялись фейковые столбцы
                        rowData = StringReplace(rowData,";",".",TReplaceFlags()<<rfReplaceAll<<rfIgnoreCase);
                        str = str + rowData;
                        if (i!=MessageGrid1->Columns->Count-1) str = str+delim;
                }
                sList->Add (str);
                str = "";
                rowData ="";
                //Вычитываем значения из TListView
                for (int i = 0; i < MessageGrid1->Items->Count; i++){
                        //for (int j = 0; j < lvInfo->Items->Item[i]->SubItems->Count-1; j++){
                        for (int j = 0; j < MessageGrid1->Items->Item[i]->SubItems->Count; j++){
                               rowData =  MessageGrid1->Items->Item[i]->SubItems->Strings[j];
                               //экранируем(меняем на точки) точки с запятой(разделитель) (GRB FIX от 09.04.2019 - раньше была запятая), чтобы не появлялись фейковые столбцы
                               rowData =  StringReplace(rowData,";",".",TReplaceFlags()<<rfReplaceAll<<rfIgnoreCase);
                               str = str + rowData;
                               if (j != MessageGrid1->Items->Item[i]->SubItems->Count-1) str = str + delim;
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

