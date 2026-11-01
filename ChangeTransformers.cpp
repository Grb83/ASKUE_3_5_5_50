//---------------------------------------------------------------------------

#include <vcl.h>
#include "ASKUETypes.h"
#include "Reconst.hpp"
#include "unDataMod.h"
#include <math.h>
#pragma hdrstop

#include "ChangeTransformers.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TChangeTransformersForm *ChangeTransformersForm;
//---------------------------------------------------------------------------

class TChangeTransformersFormPriv
{
public:
  __fastcall TChangeTransformersFormPriv(TChangeTransformersForm *Owner, TCustomTransformerLine *tl)
  { parent    = Owner;
    transline = tl;
    canChange = false;
    switch (transline->type)
    { case TCustomTransformerLine::ttCurrent:
      case TCustomTransformerLine::ttVoltage:
        mtrans  = *((TMeteringTransformer *)transline);
        break;
      case TCustomTransformerLine::ttPower2:
        p2trans = *((TPowerTwoTransformer *)transline);
        break;
      case TCustomTransformerLine::ttPower3:
        p3trans = *((TPowerThreeTransformer *)transline);
        break;
      case TCustomTransformerLine::ttLine:
        tline = *((TTransmissionLine *)transline);
        break;
    }
  }
  __fastcall ~TChangeTransformersFormPriv()
  { parent    = NULL;
    transline = NULL;
  }

  __property bool canChange = {read = GetcanChange, write = SetcanChange};


  TCustomTransformerLine  *transline;
  TMeteringTransformer    mtrans;
  TPowerTwoTransformer    p2trans;
  TPowerThreeTransformer  p3trans;
  TTransmissionLine       tline;

  TChangeTransformersForm *parent;

private:
  bool __fastcall GetcanChange()
  { return  parent->GetTimeMEdit->OnChange != NULL;
  }
  void __fastcall SetcanChange(bool Value)
  { if (Value)
    { parent->GetTimeMEdit->OnChange  = parent->onChange;
      parent->SetVal1Edit->OnChange   = parent->onChange;
      parent->SetVal2Edit->OnChange   = parent->onChange;
    }
    else
    { parent->GetTimeMEdit->OnChange  = NULL;
      parent->SetVal1Edit->OnChange   = NULL;
      parent->SetVal2Edit->OnChange   = NULL;
    }
  }
};
//---------------------------------------------------------------------------

//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------

//__fastcall TChangeTransformersForm::TChangeTransformersForm(TComponent* Owner,
//    TStrings*types, const TTransformersForm::TRANSFMS &p)
//    : TForm(Owner),pt(p)
__fastcall TChangeTransformersForm::TChangeTransformersForm(TComponent* Owner,
    TCustomTransformerLine *transline)
    : TForm(Owner)
{
  d = new TChangeTransformersFormPriv(this, transline);

  NameEdit->Text  = d->transline->name;
  DataTPicker->DateTime = TDateTime::CurrentDateTime();
  switch (d->transline->type)
  { case TCustomTransformerLine::ttCurrent:
      GetTypeEdit->Text = Reconst_smes5_1;
      break;
    case TCustomTransformerLine::ttVoltage:
      GetTypeEdit->Text = Reconst_smes5_2;
      break;
    case TCustomTransformerLine::ttPower2:
      GetTypeEdit->Text = Reconst_smes5_3;
      break;
    case TCustomTransformerLine::ttPower3:
      GetTypeEdit->Text = Reconst_smes5_4;
      break;
    case TCustomTransformerLine::ttLine:
      GetTypeEdit->Text = Reconst_smes5_5;
      break;
    default:
      GetTypeEdit->Text = Reconst_smes5_6;
      break;
  }
  SetTypeEdit->Text   = GetTypeEdit->Text;
  GetTimeMEdit->Text  = DataTPicker->DateTime.FormatString("hh:nn");
  switch (d->transline->type)
  { case TCustomTransformerLine::ttCurrent:
    case TCustomTransformerLine::ttVoltage:
      GetVal1Edit->Text = d->mtrans.Val1;
      GetVal2Edit->Text = d->mtrans.Val2;
      SetVal1Edit->Text = d->mtrans.Val1;
      SetVal2Edit->Text = d->mtrans.Val2;
      break;
    case TCustomTransformerLine::ttPower2:
      break;
    case TCustomTransformerLine::ttPower3:
      break;
    case TCustomTransformerLine::ttLine:
      break;
    default:
      DataTPicker->Enabled    = false;
      DataTPicker->Color      = clMenu;
      GetTimeMEdit->Enabled   = false;
      DataTPicker->Color      = clMenu;
      SetVal1Edit->Enabled    = false;
      SetVal1Edit->Color      = clMenu;
      SetVal2Edit->Enabled    = false;
      SetVal2Edit->Color      = clMenu;
      break;
  }

  onChange(GetTimeMEdit);
  d->canChange  = true;
}
//---------------------------------------------------------------------------

__fastcall TChangeTransformersForm::~TChangeTransformersForm()
{
  delete  d;
}
//---------------------------------------------------------------------------

void __fastcall TChangeTransformersForm::onChange(TObject *Sender)
{
  TWinControl *tWC  = NULL;
  try
  {
    if (Sender == GetTimeMEdit)
    { tWC = GetTimeMEdit;
      TDateTime(GetTimeMEdit->Text, TDateTime::Time);
      SetTimeMEdit->Text  = GetTimeMEdit->Text;
    }
    if (SetTimeMEdit->Text != "__:__")
    { DataTPicker->DateTime.Val = floor(DataTPicker->DateTime.Val) +
                                    TDateTime(SetTimeMEdit->Text, TDateTime::Time).Val;

      switch (d->transline->type)
      { case TCustomTransformerLine::ttCurrent:
        case TCustomTransformerLine::ttVoltage:
          tWC = SetVal1Edit;
          SetVal1Edit->Text.ToDouble();
          tWC = SetVal2Edit;
          SetVal2Edit->Text.ToDouble();
          break;
        case TCustomTransformerLine::ttPower2:
          break;
        case TCustomTransformerLine::ttPower3:
          break;
        case TCustomTransformerLine::ttLine:
          break;
      }
      OKBtn->Enabled  = true;
    }
    else
    { OKBtn->Enabled  = false;
    }
  }
  catch (Exception &e)
  { OKBtn->Enabled  = false;
    if (tWC && d->canChange)
      tWC->SetFocus();
  }
}
//---------------------------------------------------------------------------

void __fastcall TChangeTransformersForm::OKBtnClick(TObject *Sender)
{
  try
  { char  tdate[DATE_LEN];
    memset(tdate, 0, DATE_LEN);
    strcpy(tdate, DataTPicker->DateTime.FormatString("dd.mm.yyyy hh:nn:ss").c_str());
    switch (d->transline->type)
    { case TCustomTransformerLine::ttCurrent:
      case TCustomTransformerLine::ttVoltage:
        d->mtrans.Val1  = SetVal1Edit->Text.ToDouble();
        d->mtrans.Val2  = SetVal2Edit->Text.ToDouble();
        //GRB ADD 16.04.2020 - test trouble ODAC
        dmMain->quMain->Params->Clear();
        //END ADD 

        dmMain->quMain->SQL->Text="begin "+SchemeName+"EDITTRANSFORMER_LINE_PG.change_p(:par1, TO_DATE(:par2,'dd.mm.yyyy hh24:mi:ss'), TO_DATE(:par3,'dd.mm.yyyy hh24:mi:ss'), :par4, :par5); end;";
        dmMain->quMain->ParamByName("par1")->AsInteger=d->mtrans.id;
        dmMain->quMain->ParamByName("par2")->AsString=d->mtrans.ddate;
        dmMain->quMain->ParamByName("par3")->AsString=tdate;
        dmMain->quMain->ParamByName("par4")->AsFloat=d->mtrans.Val1;
        dmMain->quMain->ParamByName("par5")->AsFloat=d->mtrans.Val2;
        dmMain->quMain->Execute();

        *((TMeteringTransformer *)d->transline) = d->mtrans;
        break;
      case TCustomTransformerLine::ttPower2:

        *((TPowerTwoTransformer *)d->transline) = d->p2trans; 
        break;
      case TCustomTransformerLine::ttPower3:

        *((TPowerThreeTransformer *)d->transline) = d->p3trans;
        break;
      case TCustomTransformerLine::ttLine:

        *((TTransmissionLine *)d->transline)  = d->tline;
        break;
    }

    ModalResult = mrOk;
  }
  catch (Exception &e)
  { ModalResult = mrNone;
    Application->ShowException(&e);
  }
}
//---------------------------------------------------------------------------

void __fastcall TChangeTransformersForm::m_btnSaveClick(TObject *Sender)
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
    aSaveDialog->FileName = "Атрибути трансформатора";
    aSaveDialog->Filter = "Текстові документи (*.txt)|*.txt|Файл з роздільником (*.csv)|*.csv|Excel-таблиця (*.xls)|*.xls";
    }else{
    aSaveDialog->Title = "Аттрибуты трансформатора...";
    aSaveDialog->FileName = "Табличное пространство";
    aSaveDialog->DefaultExt = "csv";
    aSaveDialog->Filter = "Текстовые документы (*.txt)|*.txt|Файл с разделителем (*.csv)|*.csv|Excel-таблица (*.xls)|*.xls";
    }
    if(aSaveDialog->Execute())
    {
                AnsiString rowData,str="";
                TStringList* sList=new TStringList;
                AnsiString fileName = aSaveDialog->FileName;
                str = (lName->Caption) + delim + NameEdit->Text;
                sList->Add (str);
                str = (lData->Caption) + delim + DataTPicker->Time;
                sList->Add (str);
                str = plName->Caption + delim + plGetName->Caption + delim + plSetName->Caption;
                sList->Add (str);

                str = plType->Caption+delim+GetTypeEdit->Text+delim+SetTypeEdit->Text;
                sList->Add (str);
                str = plTime->Caption+delim+GetTimeMEdit->Text+delim+SetTimeMEdit->Text;
                sList->Add (str);
                str = plVal1->Caption+delim+GetVal1Edit->Text+delim+SetVal1Edit->Text;
                sList->Add (str);
                str = plVal2->Caption+delim+GetVal2Edit->Text+delim+SetVal2Edit->Text;
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

