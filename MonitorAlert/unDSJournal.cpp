//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#include "unDSJournal.h"
#include "unDataMod.h"
#include "Filter.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "MemDS"
#pragma link "VirtualTable"
#pragma link "DBGridEh"
#pragma link "DBAccess"
#pragma link "Ora"
#pragma resource "*.dfm"
//---------------------------------------------------------------------------
__fastcall TfmDSJournal::TfmDSJournal(TComponent* Owner)
	: TForm(Owner),	m_ulNumberSelectedRows(0)
{
  desc1=0;
  desc2=0;
  desc3=0;
  desc4=0;
  desc5=0;
  sort = 0;

  SelectData();
}
//---------------------------------------------------------------------------
void __fastcall TfmDSJournal::SelectData( void )
{
  TListItem *LI;
  try{
     MessageGrid1->Items->Clear();
     oqCursor->Params->Clear();
     oqCursor->SQL->Text= "begin "+SchemeName+"CTS_PG.getdata_DS(:par1); end;";
     oqCursor->ParamByName("par1")->ParamType = ptOutput;
     oqCursor->ParamByName("par1")->DataType = ftCursor;
    oqCursor->Execute();
    while(!oqCursor->Eof){
                LI = MessageGrid1->Items->Add();
                LI->SubItems->AddObject(AnsiString(""),(TObject*)oqCursor->FieldByName("field0")->AsInteger);
                LI->SubItems->AddObject(oqCursor->FieldByName("field2")->AsString,(TObject*)oqCursor->FieldByName("field1")->AsInteger);
                LI->SubItems->Add(oqCursor->FieldByName("field3")->AsDateTime.FormatString("dd.mm.yyyy hh:nn:ss"));
                LI->SubItems->Add(oqCursor->FieldByName("field4")->AsString);
                if(oqCursor->FieldByName("field5")->IsNull)
                  LI->SubItems->Add("");
                else
                  LI->SubItems->Add(oqCursor->FieldByName("field5")->AsDateTime.FormatString("dd.mm.yyyy hh:nn:ss"));
                if(oqCursor->FieldByName("field6")->IsNull)
                  LI->SubItems->Add("");
                else
                  LI->SubItems->Add(oqCursor->FieldByName("field6")->AsDateTime.FormatString("dd.mm.yyyy hh:nn:ss"));

                oqCursor->Next();
               }

   }catch(Exception &exception)
    {
        Application->ShowException(&exception);
    }
   }

//---------------------------------------------------------------------------
 bool __fastcall TfmDSJournal::RefreshData( void )
{
  try{
    AnsiString s;
    oqCursor->Params->Clear();
    oqCursor->SQL->Text ="begin "+SchemeName+"CTS_PG.getdata_DS(:par1); end;";
    oqCursor->ParamByName("par1")->ParamType = ptOutput;
    oqCursor->ParamByName("par1")->DataType = ftCursor;
    oqCursor->Execute();
    MessageGrid1->Items->BeginUpdate();
    while(!oqCursor->Eof){
      for(int i=0; i< MessageGrid1->Items->Count;i++)
          if(MessageGrid1->Items->Item[i]->SubItems->Objects[0]==(TObject*)oqCursor->FieldByName("field0")->AsInteger){
                MessageGrid1->Items->Item[i]->SubItems->Strings[0]=AnsiString("");
                if(MessageGrid1->Items->Item[i]->SubItems->Objects[1]!= (TObject*)oqCursor->FieldByName("field1")->AsInteger)
                MessageGrid1->Items->Item[i]->SubItems->Objects[1]= (TObject*)oqCursor->FieldByName("field1")->AsInteger;
                if(MessageGrid1->Items->Item[i]->SubItems->Strings[1]!= oqCursor->FieldByName("field2")->AsString)
                MessageGrid1->Items->Item[i]->SubItems->Strings[1]= oqCursor->FieldByName("field2")->AsString;
                if(MessageGrid1->Items->Item[i]->SubItems->Strings[2]!= oqCursor->FieldByName("field3")->AsDateTime.FormatString("dd.mm.yyyy hh:nn:ss"))
                MessageGrid1->Items->Item[i]->SubItems->Strings[2]= oqCursor->FieldByName("field3")->AsDateTime.FormatString("dd.mm.yyyy hh:nn:ss");
                if(MessageGrid1->Items->Item[i]->SubItems->Strings[3]!= oqCursor->FieldByName("field4")->AsString)
                MessageGrid1->Items->Item[i]->SubItems->Strings[3]= oqCursor->FieldByName("field4")->AsString;
                if(oqCursor->FieldByName("field5")->IsNull)
                  s="";
                else
                  s=oqCursor->FieldByName("field5")->AsDateTime.FormatString("dd.mm.yyyy hh:nn:ss");
                if(MessageGrid1->Items->Item[i]->SubItems->Strings[4]!= s)
                MessageGrid1->Items->Item[i]->SubItems->Strings[4]= s;
                if(oqCursor->FieldByName("field6")->IsNull)
                  s="";
                else
                  s=oqCursor->FieldByName("field6")->AsDateTime.FormatString("dd.mm.yyyy hh:nn:ss");
                if(MessageGrid1->Items->Item[i]->SubItems->Strings[5]!= s)
                MessageGrid1->Items->Item[i]->SubItems->Strings[5]= s;
          }
          oqCursor->Next();
    }
  MessageGrid1->Items->EndUpdate();
  }catch(Exception &exception)
    {
        Application->ShowException(&exception);
        return false;
    }
    return true;
 }
//---------------------------------------------------------------------------
void __fastcall TfmDSJournal::OnShow(TObject *Sender)
{

      Caption = Reconst_smes98_1;
 if(RefreshData())

 if(MessageGrid1->Items->Count)
      {
        MessageGrid1->Selected = MessageGrid1->Items->Item[0];
        MessageGrid1->ItemFocused = MessageGrid1->Items->Item[0];
      }
   MessageGrid1->SetFocus();

  acDelete->Enabled=UsCon.Admin;
  ToolBar->Visible=UsCon.Admin;
}
//---------------------------------------------------------------------------
void __fastcall TfmDSJournal::Timer1Timer(TObject *Sender)
{
   Timer1->Enabled=false;
   RefreshData();
   Timer1->Enabled=true;
}
//---------------------------------------------------------------------------
/*! Отображение полного содержимого ячейки в отдельном окне.
*/
void __fastcall TfmDSJournal::MessageGrid1DblClick(
      TObject *Sender)
{
    if(!MessageGrid1->Selected&&MessageGrid1->Items->Count>0)
    {
        MessageGrid1->ItemFocused = MessageGrid1->Items->Item[MessageGrid1->Items->Count-1];
        MessageGrid1->ItemFocused->Selected = true;
    }
        ShowMessage(MessageGrid1->ItemFocused->SubItems->Strings[1] + "\n" +
                    MessageGrid1->ItemFocused->SubItems->Strings[2]+ "\n" +
                    MessageGrid1->ItemFocused->SubItems->Strings[3]);
}
//---------------------------------------------------------------------------
void __fastcall TfmDSJournal::MessageGrid1ColumnClick(
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
    case 4:
        sort = desc4?(-1)*Column->Index:Column->Index;
        desc4 = !desc4;
      break;
    case 5:
        sort = desc5?(-1)*Column->Index:Column->Index;
        desc5 = !desc5;
      break;
  }
  Timer1->Enabled=false;
  SortData();
  Timer1->Enabled=true;
}
//---------------------------------------------------------------------------
 void __fastcall TfmDSJournal::SortData( void )
{
  try{
    TListItem *LI;
    oqCursor->Params->Clear();
    oqCursor->SQL->Text = "begin "+SchemeName+"CTS_PG.sortdata_DS(:par1,:par2); end;";
    oqCursor->ParamByName("par1")->AsInteger=sort;
    oqCursor->ParamByName("par2")->ParamType = ptOutput;
    oqCursor->ParamByName("par2")->DataType = ftCursor;
    oqCursor->Execute();
     MessageGrid1->Items->BeginUpdate();
     MessageGrid1->Items->Clear();
     while(!oqCursor->Eof){
                LI = MessageGrid1->Items->Add();
                LI->SubItems->AddObject(AnsiString(""),(TObject*)oqCursor->FieldByName("field0")->AsInteger);
                LI->SubItems->AddObject(oqCursor->FieldByName("field2")->AsString,(TObject*)oqCursor->FieldByName("field1")->AsInteger);
                LI->SubItems->Add(oqCursor->FieldByName("field3")->AsDateTime.FormatString("dd.mm.yyyy hh:nn:ss"));
                LI->SubItems->Add(oqCursor->FieldByName("field4")->AsString);
                LI->SubItems->Add(oqCursor->FieldByName("field5")->AsDateTime.FormatString("dd.mm.yyyy hh:nn:ss"));
                if(oqCursor->FieldByName("field6")->IsNull)
                  LI->SubItems->Add("");
                else
                  LI->SubItems->Add(oqCursor->FieldByName("field6")->AsDateTime.FormatString("dd.mm.yyyy hh:nn:ss"));
                oqCursor->Next();
          }
          oqCursor->Close();
  MessageGrid1->Items->EndUpdate();
  MessageGrid1->Selected = MessageGrid1->Items->Item[0];
  MessageGrid1->ItemFocused = MessageGrid1->Items->Item[0];
  }catch(Exception &exception)
    {
        Application->ShowException(&exception);
    }
}

//---------------------------------------------------------------------------
void __fastcall TfmDSJournal::MessageGrid1CustomDrawItem(
      TCustomListView *Sender, TListItem *Item, TCustomDrawState State,
      bool &DefaultDraw)
{
 switch ((int)Item->SubItems->Objects[1])
  {
  case 1:   MessageGrid1->Canvas->Brush->Color = clWhite;
            break;
  case 3:   MessageGrid1->Canvas->Brush->Color = clRed;
            break;
  default:  MessageGrid1->Canvas->Brush->Color = (TColor)9299194;
            break;
  }

}
//---------------------------------------------------------------------------
void __fastcall TfmDSJournal::MessageGrid1GetSubItemImage(TObject *Sender,
      TListItem *Item, int SubItem, int &ImageIndex)
{
   switch ((int)Item->SubItems->Objects[1])
  {
  case 1:   Item->SubItemImages[0]=2;
                        break;
  case 3: Item->SubItemImages[0]=3;
                        break;
  default: Item->SubItemImages[0]=4;
                        break;
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmDSJournal::acDeleteExecute(TObject *Sender)
{
int tmp;
if (MessageBox(Handle,"Вы настаиваете на удалении?",Application->Title.c_str(),MB_YESNO|MB_ICONQUESTION|MB_DEFBUTTON2)==IDYES)
{
  oqToDel->Close();
  oqToDel->ParamByName("mid")->AsInteger=(int)(MessageGrid1->ItemFocused->SubItems->Objects[0]);
  oqToDel->Execute();
  oqToDel->Close();
  tmp=MessageGrid1->Selected->Index;
  MessageGrid1->Selected->Delete();
  if (tmp<MessageGrid1->Items->Count)
  {
    MessageGrid1->Selected = MessageGrid1->Items->Item[tmp];
    MessageGrid1->ItemFocused = MessageGrid1->Items->Item[tmp];
  }
  else
  {
    tmp=MessageGrid1->Items->Count;
    tmp--;
    MessageGrid1->Selected = MessageGrid1->Items->Item[tmp];
    MessageGrid1->ItemFocused = MessageGrid1->Items->Item[tmp];
  }
}
else
  return;
}
//---------------------------------------------------------------------------
void __fastcall TfmDSJournal::SaveTableToFile(TObject *Sender)
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
    aSaveDialog->FileName = "Служба діагостики";
    aSaveDialog->Filter = "Текстові документи (*.txt)|*.txt|Файл з роздільником (*.csv)|*.csv|Excel-таблиця (*.xls)|*.xls";
    }else{
    aSaveDialog->Title = "Сохранить в файл...";
    aSaveDialog->FileName = "Служба диагностики";
    aSaveDialog->DefaultExt = "csv";
    aSaveDialog->Filter = "Текстовые документы (*.txt)|*.txt|Файл с разделителем (*.csv)|*.csv|Excel-таблица (*.xls)|*.xls";
    }
    if(aSaveDialog->Execute())
    {
                AnsiString rowData,str="";
                TStringList* sList=new TStringList;
                AnsiString fileName = aSaveDialog->FileName;
                for(int i=1; i< 6;i++){
                        rowData =  (AnsiString)MessageGrid1->Items->Item[1]->SubItems->Strings[i];
                        rowData = rowData+delim; ;

                  if (rowData!="")
                                        str = str + rowData;

                   }
                   sList->Add (str);
                    str="";
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
//---------------------------------------------------------------------------

