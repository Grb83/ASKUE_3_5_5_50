//---------------------------------------------------------------------------
#include <vcl.h>
#include <stdio.h>
#pragma hdrstop
#include "InterpriseRename.h"
//---------------------------------------------------------------------------
#pragma link "DBAccess"
#pragma link "MemDS"
#pragma link "Ora"
#pragma resource "*.dfm"
#include "Reconst.hpp"
TFormIntrpriseReneme*FormIntrpriseReneme=NULL;
//---------------------------------------------------------------------------
__fastcall TFormIntrpriseReneme::TFormIntrpriseReneme(TComponent* Owner, AnsiString Name, TAccess a)
	: TMainForm(Owner, Name, a)
{
   ReadData();
   FormStyle = fsNormal;
   FormIntrpriseReneme=this;
}
//---------------------------------------------------------------------------
__fastcall TFormIntrpriseReneme::~TFormIntrpriseReneme()
{
   FormIntrpriseReneme=NULL;
}
//---------------------------------------------------------------------------
void __fastcall TFormIntrpriseReneme::ReadData(void)
{
  AnsiString pName,pSName;
  int pCod;
  //GRB ADD 27.05.2019 - задача с обменом макетами в формате xml - Энергорынок - добавляем Код торговой зоны и Код точки учёта
  AnsiString EICCode,fullName, shortName;
  AnsiString tradeZoneCod1, tradeZoneCod2; // названия кодов - подтягиваем из базы

  AnsiString tradeZone1, tradeZone2;// признаки принадлежности к зонам 0 - нет, 1 - да
  tradeZone1 = "y";
  tradeZone2 = "n";
  tradeZoneCod1 = tradeZoneCod2 = EICCode = fullName = shortName = "";
  TDate dInitDate;
  //END ADD
  Edit1->Text="";
  Edit2->Text="";
  Edit3->Text="";
  dmMain->oqCursor->Params->Clear();

  //dmMain->oqCursor->SQL->Text="begin "+SchemeName+"editfeedergroup_pg.read_enterprise_data(:par1,:par2,:par3,:par4); end;";
  dmMain->oqCursor->SQL->Text="begin "+SchemeName+"editfeedergroup_pg.read_enterprise_data(:par1,:par2,:par3,:par4,:par5,:par6,:par7,:par8,:par9,:par10,:par11); end;";

  dmMain->oqCursor->ParamByName("par1")->ParamType=ptOutput;
  dmMain->oqCursor->ParamByName("par1")->DataType=ftInteger;
  dmMain->oqCursor->ParamByName("par2")->ParamType=ptOutput;
  dmMain->oqCursor->ParamByName("par2")->DataType=ftString;
  dmMain->oqCursor->ParamByName("par2")->Size=2000;
  dmMain->oqCursor->ParamByName("par3")->ParamType=ptOutput;
  dmMain->oqCursor->ParamByName("par3")->DataType=ftString;
  dmMain->oqCursor->ParamByName("par3")->Size=2000;
  dmMain->oqCursor->ParamByName("par4")->ParamType=ptOutput;
  dmMain->oqCursor->ParamByName("par4")->DataType=ftInteger;
  //GRB ADD 04.06.2019 новые параметы
  dmMain->oqCursor->ParamByName("par5")->ParamType=ptOutput;
  dmMain->oqCursor->ParamByName("par5")->DataType=ftString;
  dmMain->oqCursor->ParamByName("par6")->ParamType=ptOutput;
  dmMain->oqCursor->ParamByName("par6")->DataType=ftString;
  dmMain->oqCursor->ParamByName("par7")->ParamType=ptOutput;
  dmMain->oqCursor->ParamByName("par7")->DataType=ftString;
  dmMain->oqCursor->ParamByName("par8")->ParamType=ptOutput;
  dmMain->oqCursor->ParamByName("par8")->DataType=ftString;
  dmMain->oqCursor->ParamByName("par9")->ParamType=ptOutput;
  dmMain->oqCursor->ParamByName("par9")->DataType=ftString;
  dmMain->oqCursor->ParamByName("par10")->ParamType=ptOutput;
  dmMain->oqCursor->ParamByName("par10")->DataType=ftString;
  dmMain->oqCursor->ParamByName("par11")->ParamType=ptOutput;
  dmMain->oqCursor->ParamByName("par11")->DataType=ftString;
  //ENA ADD

  dmMain->oqCursor->Execute();

  Mid = dmMain->oqCursor->ParamByName("par1")->AsInteger;
  pName =dmMain->oqCursor->ParamByName("par2")->AsString;
  pSName = dmMain->oqCursor->ParamByName("par3")->AsString;
  pCod = dmMain->oqCursor->ParamByName("par4")->AsInteger;
  //GRB ADD 04.06.2019 - задача с обменом макетами в формате xml - Энергорынок - добавляем Код торговой зоны и Код точки учёта
  EICCode = dmMain->oqCursor->ParamByName("par5")->AsString;
  fullName = dmMain->oqCursor->ParamByName("par6")->AsString;
  shortName = dmMain->oqCursor->ParamByName("par7")->AsString;
  tradeZoneCod1 = dmMain->oqCursor->ParamByName("par8")->AsString; //кода зон
  tradeZoneCod2 = dmMain->oqCursor->ParamByName("par9")->AsString;
  tradeZone1 = dmMain->oqCursor->ParamByName("par10")->AsString;  //признаки y/n
  tradeZone2 = dmMain->oqCursor->ParamByName("par11")->AsString;
  //END ADD
  Edit1->Text=pName;
  Edit2->Text=pSName;

  if(!IntToStr(pCod).IsEmpty())
    Edit3->Text=IntToStr(pCod);
  //GRB ADD 27.05.2019 - задача с обменом макетами в формате xml - Энергорынок - добавляем Код торговой зоны и Код точки учёта
  //GRB ADD 04.06.2019
  if (CompareStr (tradeZone1,"y") == 0){
     CheckBox1->Checked = true;
  }else{
     CheckBox1->Checked = false;
  }
  if (CompareStr (tradeZone2,"y") == 0){
     CheckBox2->Checked = true;
  }else{
     CheckBox2->Checked = false;
  }
  Edit4->Text = tradeZoneCod1;
  Edit5->Text = tradeZoneCod2;
  Edit6->Text = EICCode;
  Edit7->Text = fullName;
  Edit8->Text = shortName;
  //END ADD

  EditRec=false;
}
//---------------------------------------------------------------------------
void __fastcall TFormIntrpriseReneme::vSave(TObject *Sender)
{
  if(!EditRec)
    return;
  try{
     //GRB ADD 28.05.2019 - добавил проверку на то что хотя бы один чекбокс установлен
   if (((CheckBox1->Checked) || (CheckBox2->Checked)) == false ){
       Application->MessageBox(Reconst_smes41_1.c_str(),"ERROR!",MB_OK	|MB_ICONSTOP);
       return;
   }
  //GRB REM 28.05.2019
  //if(Edit1->Text.IsEmpty()||Edit2->Text.IsEmpty())
   //GRB UPD 28.05.2019 - добавил проверку на пустоту 3-х EIC полей (дата и так есть всегда сегодняшняя)
   if(Edit1->Text.IsEmpty()||Edit2->Text.IsEmpty()||Edit6->Text.IsEmpty()||Edit7->Text.IsEmpty()||Edit8->Text.IsEmpty())
   {
       Application->MessageBox(Reconst_smes41_1.c_str(),"ERROR!",MB_OK	|MB_ICONSTOP);
       return;
   }
  else{
    dmMain->oqCursor->Params->Clear();
    //GRB REM 27.05.2019 - задача с обменом макетами в формате xml - Энергорынок - добавляем Код торговой зоны и Код точки учёта, добавляем 2 новых параметра
    //dmMain->oqCursor->SQL->Text="begin "+SchemeName+"editfeedergroup_pg.interprise_p(:par1,:par2,:par3,:par4); end;";
    //GRB ADD 27.05.2019
    dmMain->oqCursor->SQL->Text="begin "+SchemeName+"editfeedergroup_pg.interprise_p(:par1,:par2,:par3,:par4,:par5,:par6,:par7,:par8,:par9); end;";
    //END ADD
    dmMain->oqCursor->ParamByName("par1")->ParamType=ptInputOutput;
    dmMain->oqCursor->ParamByName("par1")->DataType=ftInteger;
    dmMain->oqCursor->ParamByName("par1")->AsInteger=Mid;
    dmMain->oqCursor->ParamByName("par2")->AsString=Edit1->Text;
    dmMain->oqCursor->ParamByName("par3")->AsString=Edit2->Text;
    if(StrToIntDef(Edit3->Text,0)>0)
       dmMain->oqCursor->ParamByName("par4")->AsInteger=StrToIntDef(Edit3->Text,0);
       else
       dmMain->oqCursor->ParamByName("par4")->Clear();
    //GRB ADD  27.05.2019
    dmMain->oqCursor->ParamByName("par5")->AsString = Edit6->Text;  //Код ЕИС
    dmMain->oqCursor->ParamByName("par6")->AsString = Edit7->Text;  //Наименование
    dmMain->oqCursor->ParamByName("par7")->AsString = Edit8->Text;  //Короткое имя

    if (CheckBox1->Checked)
    dmMain->oqCursor->ParamByName("par8")->AsString = "y";  //Находится в торговой зоны Украины
    else
    dmMain->oqCursor->ParamByName("par8")->AsString = "n";  //Не Находится в торговой зоны Украины
    if (CheckBox2->Checked)
    dmMain->oqCursor->ParamByName("par9")->AsString = "y";  //Код торговой зоны Бурштын
    else
    dmMain->oqCursor->ParamByName("par9")->AsString = "n";  //Не Находится в торговой зоны Бурштын


    //END ADD
    dmMain->oqCursor->Execute();
    Mid=dmMain->oqCursor->ParamByName("par1")->AsInteger;
    dmMain->orases->Commit();

    EditRec=false;
    }
  }catch (Exception &exception){
   dmMain->orases->Rollback();
   Application->ShowException(&exception);
  }
}
//---------------------------------------------------------------------------
void __fastcall TFormIntrpriseReneme::vRefresh(TObject *Sender)
{
   ReadData();
}
//---------------------------------------------------------------------------
void __fastcall TFormIntrpriseReneme::Edit1Change(TObject *Sender)
{
	EditRec=true;
}
//---------------------------------------------------------------------------
void __fastcall TFormIntrpriseReneme::SetAccess(TAccess value)
{
   if(FAccess != value) {
      TMainForm::SetAccess(value);
      bool write = value==accWrite;
      Panel5->Enabled = write;
   }
}
//---------------------------------------------------------------------------
void __fastcall TFormIntrpriseReneme::edLongKeyPress(TObject *Sender,
      char &Key)
{
#define Sender ((TEdit*)Sender)
  AnsiString S=(AnsiString)Key;
  AnsiString S1="0123456789\b\r";
  if(!S1.Pos(S)){
    Key=NULL;
    Beep();
    return;
  }
#undef Sender
}
//---------------------------------------------------------------------------

void __fastcall TFormIntrpriseReneme::Edit6Change(TObject *Sender)
{
	EditRec=true;
}
//---------------------------------------------------------------------------

void __fastcall TFormIntrpriseReneme::Edit7Change(TObject *Sender)
{
 	EditRec=true;
}
//---------------------------------------------------------------------------

void __fastcall TFormIntrpriseReneme::Edit8Change(TObject *Sender)
{
	EditRec=true;
}
//---------------------------------------------------------------------------

void __fastcall TFormIntrpriseReneme::CheckBox1Click(TObject *Sender)
{
	EditRec=true;
}
//---------------------------------------------------------------------------

void __fastcall TFormIntrpriseReneme::CheckBox2Click(TObject *Sender)
{
	EditRec=true;
}
//---------------------------------------------------------------------------

void __fastcall TFormIntrpriseReneme::m_btnSaveClick(TObject *Sender)
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
    aSaveDialog->FileName = "Специфікація підприємства";
    aSaveDialog->Filter = "Текстові документи (*.txt)|*.txt|Файл з роздільником (*.csv)|*.csv|Excel-таблиця (*.xls)|*.xls";
    }else{
    aSaveDialog->Title = "Сохранить в файл...";
    aSaveDialog->FileName = "Спецификация предприятия";
    aSaveDialog->DefaultExt = "csv";
    aSaveDialog->Filter = "Текстовые документы (*.txt)|*.txt|Файл с разделителем (*.csv)|*.csv|Excel-таблица (*.xls)|*.xls";
    }
    if(aSaveDialog->Execute())
    {
                AnsiString rowData,str="";
                TStringList* sList=new TStringList;
                AnsiString fileName = aSaveDialog->FileName;
                str = (Label1->Caption) + delim + Edit1->Text;
                sList->Add (str);
                str = (Label2->Caption) + delim + Edit2->Text;
                sList->Add (str);
                str = Label3->Caption + delim + Edit3->Text;
                sList->Add (str);

                str = Label4->Caption+delim+Edit4->Text+delim;
                if (CheckBox1->Checked){
                   str = str + "+";
                }else{
                   str = str + "-";
                }
                sList->Add (str);
                str = Label5->Caption+delim+Edit5->Text+delim;
                if (CheckBox2->Checked){
                   str = str + "+";
                }else{
                   str = str + "-";
                }
                sList->Add (str);

                str = (Label6->Caption) + delim + Edit6->Text;
                sList->Add (str);
                str = (Label7->Caption) + delim + Edit7->Text;
                sList->Add (str);
                str = (Label8->Caption) + delim + Edit8->Text;
                sList->Add (str);

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

