//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#include "InputParam.h"
#include "unDataMod.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------

#pragma resource "*.dfm"
TFormInputParam *FormInputParam;

//---------------------------------------------------------------------------
__fastcall TFormInputParam::TFormInputParam(TComponent* Owner, long id,TDateTime dt)
	: TForm(Owner)

{
  ReplaceRyda(this,BASE_SCHEME,SchemeName);
  Mid=id;
  dtFrom->Date=(dt-1);
  edFrom->Text="00:00";
  dtTill->Date=dt;
  edTill->Text="00:00";
  vRead();
}
//---------------------------------------------------------------------------

bool __fastcall TFormInputParam::ShowInputParam(TComponent* Owner,long id,TDateTime dt)
{
  TFormInputParam *f=new TFormInputParam(Owner,id,dt);
  int res = f->ShowModal();
  delete f;
  return (res == mrOk);
}
//---------------------------------------------------------------------------

void __fastcall TFormInputParam::vRead()
{

  long tQ1234;
  char tmet[5];
  //GRB ADD 16.04.2020 - test trouble ODAC
  dmMain->quMain->Params->Clear();
  //END ADD 
  dmMain->quMain->SQL->Text="select p.name,decode(f.Q1234,'*',1,0) Q1234, \
              decode(f.smart,'*','1111',decode(nvl(f.ER_POSITION,0),0,0,1)||decode(nvl(f.ED_POSITION,0),0,0,1)||decode(nvl(f.Q1_POSITION,0),0,0,1)||decode(nvl(f.Q3_POSITION,0),0,0,1))met \
              from "+SchemeName+"points p,"+SchemeName+"feeders f where p.mid=:par1 and p.mid=f.mid" ;

  dmMain->quMain->ParamByName("par1")->AsInteger=Mid;
  dmMain->quMain->Execute();
  if(!dmMain->quMain->Eof){
     if(!dmMain->quMain->FieldByName("name")->IsNull)
     Edit1->Text= dmMain->quMain->FieldByName("name")->AsString;
     tQ1234=dmMain->quMain->FieldByName("Q1234")->AsInteger;
     strcpy(tmet,dmMain->quMain->FieldByName("met")->AsString.c_str());
     if(dmMain->quMain->FieldByName("met")->AsString.SubString(1,1)=="1") Panel18->Visible=true;
     if(StrToInt(tmet[1])) Panel17->Visible=true;
     if(StrToInt(tmet[2]))
        {   Panel16->Visible=true;
            if(tQ1234) Label3->Caption=AnsiString(Reconst_smes37_1);
            else
            { Label5->Visible=false;
              Edit5->Visible=false;
              Panel16->Height=31;
              Panel7->Height=Panel7->Height-31;
            }
          }
     else  Panel16->Height=0;
     if(StrToInt(tmet[3]))
         {   Panel15->Visible=true;
             if(tQ1234)Label4->Caption=AnsiString(Reconst_smes37_2);
             else{ Label6->Visible=false;
                   Edit7->Visible=false;
                   Panel15->Height=31;
                   Panel7->Height=Panel7->Height-31;
                 }
           }
     else Panel15->Height=0;

     }
}
//---------------------------------------------------------------------------


void __fastcall TFormInputParam::BitBtn2Click(TObject *Sender)
{
   Close();
   Mid=0;
}
//---------------------------------------------------------------------------

void __fastcall TFormInputParam::BitBtn1Click(TObject *Sender)
{
  AnsiString df,dt;
//GRB CHANGE 12.12.2022
if (cb_small_val->Checked == false){
try{
  //GRB ADD 16.04.2020 - test trouble ODAC
  dmMain->quMain->Params->Clear();
  //END ADD
 dmMain->quMain->SQL->Text="begin "+SchemeName+"indic_pg.setcorrection(:par1,to_date(:par2,'dd.mm.yyyy hh24:mi'), to_date(:par3,'dd.mm.yyyy hh24:mi'),:par4,:par5,:par6,:par7,:par8,:par9,1,:par10); end;";
  df=dtFrom->Date.FormatString("dd:mm:yyyy") +AnsiString(" ")+ edFrom->Text;
  dt=dtTill->Date.FormatString("dd:mm:yyyy") +AnsiString(" ")+ edTill->Text;
  dmMain->quMain->ParamByName("par1")->AsInteger=Mid;
  dmMain->quMain->ParamByName("par2")->AsString=df;
  dmMain->quMain->ParamByName("par3")->AsString=dt;
  if(Edit3->Text.IsEmpty()) dmMain->quMain->ParamByName("par4")->Clear();
  else dmMain->quMain->ParamByName("par4")->AsInteger=StrToInt(Edit3->Text);
  if(Edit4->Text.IsEmpty()) dmMain->quMain->ParamByName("par5")->Clear();
  else dmMain->quMain->ParamByName("par5")->AsInteger=StrToInt(Edit4->Text);
  if(Edit2->Text.IsEmpty()) dmMain->quMain->ParamByName("par6")->Clear();
  else dmMain->quMain->ParamByName("par6")->AsInteger=StrToInt(Edit2->Text);
  if(Edit5->Text.IsEmpty()) dmMain->quMain->ParamByName("par7")->Clear();
  else dmMain->quMain->ParamByName("par7")->AsInteger=StrToInt(Edit5->Text);
  if(Edit6->Text.IsEmpty()) dmMain->quMain->ParamByName("par8")->Clear();
  else dmMain->quMain->ParamByName("par8")->AsInteger=StrToInt(Edit6->Text);
  if(Edit7->Text.IsEmpty()) dmMain->quMain->ParamByName("par9")->Clear();
  else dmMain->quMain->ParamByName("par9")->AsInteger=StrToInt(Edit7->Text);
  dmMain->quMain->ParamByName("par10")->AsInteger=(Cb_delete_all->Checked)?1:0;
  dmMain->quMain->Execute();
  dmMain->orases->Commit();
  ModalResult=mrOk;
  }catch(Exception&e){
    dmMain->orases->Rollback();
    Application->ShowException(&e);
  }
  }/*GRB ADD ELSE 12.12.2022  x1000 + pereraschet*/else{
  try{
  //GRB ADD 16.04.2020 - test trouble ODAC
  dmMain->quMain->Params->Clear();
  //END ADD
 dmMain->quMain->SQL->Text="begin "+SchemeName+"indic_pg.setcorrection(:par1,to_date(:par2,'dd.mm.yyyy hh24:mi'), to_date(:par3,'dd.mm.yyyy hh24:mi'),:par4,:par5,:par6,:par7,:par8,:par9,1,:par10); end;";
  df=dtFrom->Date.FormatString("dd:mm:yyyy") +AnsiString(" ")+ edFrom->Text;
  dt=dtTill->Date.FormatString("dd:mm:yyyy") +AnsiString(" ")+ edTill->Text;
  dmMain->quMain->ParamByName("par1")->AsInteger=Mid;
  dmMain->quMain->ParamByName("par2")->AsString=df;
  dmMain->quMain->ParamByName("par3")->AsString=dt;
  if(Edit3->Text.IsEmpty()) dmMain->quMain->ParamByName("par4")->Clear();
  else dmMain->quMain->ParamByName("par4")->AsInteger=StrToInt(Edit3->Text)*1000;
  if(Edit4->Text.IsEmpty()) dmMain->quMain->ParamByName("par5")->Clear();
  else dmMain->quMain->ParamByName("par5")->AsInteger=StrToInt(Edit4->Text)*1000;
  if(Edit2->Text.IsEmpty()) dmMain->quMain->ParamByName("par6")->Clear();
  else dmMain->quMain->ParamByName("par6")->AsInteger=StrToInt(Edit2->Text)*1000;
  if(Edit5->Text.IsEmpty()) dmMain->quMain->ParamByName("par7")->Clear();
  else dmMain->quMain->ParamByName("par7")->AsInteger=StrToInt(Edit5->Text)*1000;
  if(Edit6->Text.IsEmpty()) dmMain->quMain->ParamByName("par8")->Clear();
  else dmMain->quMain->ParamByName("par8")->AsInteger=StrToInt(Edit6->Text)*1000;
  if(Edit7->Text.IsEmpty()) dmMain->quMain->ParamByName("par9")->Clear();
  else dmMain->quMain->ParamByName("par9")->AsInteger=StrToInt(Edit7->Text)*1000;
  dmMain->quMain->ParamByName("par10")->AsInteger=(Cb_delete_all->Checked)?1:0;
  dmMain->quMain->Execute();
  /*перерасчет*/
  dmMain->quMain->Params->Clear();
  dmMain->quMain->SQL->Text="begin "+SchemeName+"EDITFEEDERS_PG.recalcdiff(:par1, to_date(:par2,'dd.mm.yyyy hh24:mi')); end;";
  dmMain->quMain->ParamByName("par1")->AsInteger=Mid;
  dmMain->quMain->ParamByName("par2")->AsString=df;
  dmMain->quMain->Execute();
  dmMain->orases->Commit();
  MessageBox(Handle,Reconst_smes20_62.c_str(),Caption.c_str(),MB_OK|MB_ICONINFORMATION);
  ModalResult=mrOk;
  /*закончили операцию x1000 и перерасчет*/
  }catch(Exception&e){
    dmMain->orases->Rollback();
    Application->ShowException(&e);
  }
  }
 }

//---------------------------------------------------------------------------
void __fastcall TFormInputParam::OnChange(TObject *Sender)
{
  BitBtn1->Enabled=true;
}
//---------------------------------------------------------------------------
void __fastcall TFormInputParam::edLongKeyPess(TObject *Sender,
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
void __fastcall TFormInputParam::FormActivate(TObject *Sender)
{
//  Edit3->SetFocus();
}
//---------------------------------------------------------------------------

