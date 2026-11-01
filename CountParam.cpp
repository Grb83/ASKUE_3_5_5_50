//---------------------------------------------------------------------------
#include <vcl.h>
#include <stdio.h>
#include <math.h>
#pragma hdrstop
#include "CountParam.h"
#include "unDataMod.h"
#include "GetDataIntCounter.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma link "DBAccess"
#pragma link "MemDS"
#pragma link "Ora"
#pragma link "OraSmart"
#pragma resource "*.dfm"
TFormCountParam *FormCountParam;
double meterDemIndic[30], meterNewIndic[60];
//---------------------------------------------------------------------------
__fastcall TFormCountParam::TFormCountParam(TComponent* Owner,TYPECOUNT* zTypeCount,TDateTime dt)
	: TForm(Owner)
{
  TypeCount=zTypeCount;
  DateTimePicker1->Date=dt;
  for(int j=0; j<30; j++)
  {
        meterDemIndic[j] = -1;
        meterNewIndic[j] = -1;
  }
  for(int j=30; j<60; j++)
        meterNewIndic[j] = -1;

}
//---------------------------------------------------------------------------
void __fastcall TFormCountParam::FormCreate(TObject *Sender)
{
  AnsiString str;
    /*  dmMain->quMain->SQL->Text= " SELECT ID ,NAME ,SMART ,MTRSN,DIGITS ,MTYPE ,\
                         MCURRENT ,MPOWER ,MCONST ,MCLASS ,MYEAR ,MQUARTER\
                    FROM  ryda.meters  WHERE mid=:par13 AND ENTYPE=:par14";*/

 /* dmMain->quMain->ParamByName("par13")->AsInteger=TypeCount->Mid;
  dmMain->quMain->ParamByName("par14")->AsInteger=TypeCount->Enertype;
  dmMain->quMain->Execute();*/
  oqSelect->ParamByName("pmid")->AsInteger = TypeCount->Mid;
  oqSelect->ParamByName("pentype")->AsInteger = TypeCount->Enertype;
  oqSelect->Execute();
  if(!oqSelect->FieldByName("ID")->IsNull)
  TreeTable[0].Id= oqSelect->FieldByName("ID")->AsInteger;
  if(!oqSelect->FieldByName("NAME")->IsNull)
  strcpy(TreeTable[0].Name,oqSelect->FieldByName("NAME")->AsString.c_str());
  if(!oqSelect->FieldByName("SMART")->IsNull)
  strcpy(TreeTable[0].SMART,oqSelect->FieldByName("SMART")->AsString.c_str());
  if(!oqSelect->FieldByName("MTRSN")->IsNull)
  strcpy(TreeTable[0].MTRSN,oqSelect->FieldByName("MTRSN")->AsString.c_str());
  if(!oqSelect->FieldByName("DIGITS")->IsNull)
  strcpy(TreeTable[0].DIGITS,oqSelect->FieldByName("DIGITS")->AsString.c_str());
  if(!oqSelect->FieldByName("MTYPE")->IsNull)
  strcpy(TreeTable[0].MTYPE,oqSelect->FieldByName("MTYPE")->AsString.c_str());
  if(!oqSelect->FieldByName("MCURRENT")->IsNull)
  TreeTable[0].MCURRENT= oqSelect->FieldByName("MCURRENT")->AsInteger;
  if(!oqSelect->FieldByName("MPOWER")->IsNull)
  TreeTable[0].MPOWER= oqSelect->FieldByName("MPOWER")->AsInteger;
  if(!oqSelect->FieldByName("MCONST")->IsNull)
  TreeTable[0].MCONST= oqSelect->FieldByName("MCONST")->AsInteger;
  if(!oqSelect->FieldByName("MCLASS")->IsNull)
  TreeTable[0].MCLASS= oqSelect->FieldByName("MCLASS")->AsFloat;
  if(!oqSelect->FieldByName("MYEAR")->IsNull)
  TreeTable[0].MYEAR= oqSelect->FieldByName("MYEAR")->AsInteger;
  if(!oqSelect->FieldByName("MQUARTER")->IsNull)
  TreeTable[0].MQUARTER= oqSelect->FieldByName("MQUARTER")->AsInteger;
  if(!oqSelect->Eof){
     str=TypeCount->DataChange;
     DateTimePicker1->Date = str;
    Edit3->Text= TreeTable[0].MTRSN;    Edit13->Text="";
    Edit4->Text= TreeTable[0].DIGITS;   Edit14->Text="";
    Edit5->Text= TreeTable[0].MTYPE;    Edit15->Text="";
    Edit6->Text= TreeTable[0].MCURRENT; Edit16->Text="";
    Edit7->Text= TreeTable[0].MPOWER;   Edit17->Text="";
    Edit8->Text= TreeTable[0].MYEAR;    Edit18->Text="";
    Edit9->Text= TreeTable[0].MQUARTER; Edit19->Text="";
    Edit10->Text= TreeTable[0].MCONST;  Edit20->Text="";
    Edit11->Text= TreeTable[0].MCLASS;  Edit21->Text="";
    Edit2->Text="";
    Edit12->Text= TDateTime::CurrentTime().FormatString("hh:nn");
    Edit22->Text = Edit12->Text;
    //(TDateTime::CurrentTime()+ 6.944444444444e-4).FormatString("hh:nn");
    if(TreeTable[0].SMART[0]!='*'){
      Edit24->Text=""; Edit23->Text= ""; Edit25->Text="";
      Panel20->Visible=false;
    }else{
      Panel21->Visible=false;
      Panel22->Visible=false;
    }
  }
  memset(tBill, 0, sizeof(TBIIL)*4); // Kas 22.11.01
}
//---------------------------------------------------------------------------
void __fastcall TFormCountParam::BitBtn3Click(TObject *Sender)
{//segned
    strcpy(tBill[0].Name,TreeTable[0].Name);
    if (!first)   //если первое открытие - массив еще не заполнен, заполняем
    {
      oqMeterDemIndic->Close();
      oqMeterDemIndic->ParamByName("ddate")->AsDateTime = StrToDateTime(DateTimePicker1->Date + Edit12->Text);
      oqMeterDemIndic->ParamByName("mmid")->AsInteger = TypeCount->Mid;
      oqMeterDemIndic->ParamByName("ER_MTRSN")->AsString = Edit3->Text;

      oqMeterDemIndic->Execute();

      while (!oqMeterDemIndic->Eof)
      {
        for (int i = 0;  i<30; i++)
          meterDemIndic[i] = oqMeterDemIndic->FieldByName("F"+IntToStr(i+1))->AsFloat;

        oqMeterDemIndic->Next();
      }
      oqMeterDemIndic->Close();
      first = true;
    }
    FormGetDataIntCounter= new TFormGetDataIntCounter(this,tBill);
    FormGetDataIntCounter->ShowModal();
    delete  FormGetDataIntCounter;
}
//---------------------------------------------------------------------------
void __fastcall TFormCountParam::BitBtn1Click(TObject *Sender)
{
   if(Edit13->Text.Length()==0)
   {
      BitBtn1->Enabled=false;
      Application->MessageBox(Reconst_smes9_1.c_str(), Application->Title.c_str() ,MB_OK|MB_ICONSTOP);
   }
  if(!Insert_0(this)) return;
  if(TreeWriteNew())
  {
           Close();
           ModalResult = mrOk;
  }
}
//---------------------------------------------------------------------------
void __fastcall TFormCountParam::BitBtn2Click(TObject *Sender)
{
   dmMain->orases->Rollback();
   ModalResult = mrCancel;
}
//---------------------------------------------------------------------------
bool TFormCountParam::Insert_0(TObject *Sender)
{
  TCustomEdit *myEdit;


  try{
   if ( !ProvMask(Edit14->Text)) return false;

   for (int i=0; i<this->ComponentCount;i++){
    if (this->Components[i]->Tag==11){
       myEdit=dynamic_cast<TCustomEdit*>(Components[i]);
	   if(( myEdit!=NULL )&&(myEdit->Text.Length()==0)) myEdit->Text = "0";
    }
    if (this->Components[i]->Tag==12){
       myEdit=dynamic_cast<TCustomEdit*>(Components[i]);
	   if(( myEdit!=NULL )&&(myEdit->Text.Length()==0)) myEdit->Text = "00:00";
    }
    if (this->Components[i]->Tag==13){
       myEdit=dynamic_cast<TCustomEdit*>(Components[i]);
	   if(( myEdit!=NULL )&&(myEdit->Text.Length()==0)) myEdit->Text = "9999999.999";
    }
   }
  }
  catch(Exception &e){
   return false;
  }
  return true;
}
//---------------------------------------------------------------------------
void __fastcall TFormCountParam::ChangeInt(TObject *Sender)
{
 TCustomEdit *myEdit;
 try{
  myEdit=dynamic_cast<TCustomEdit*>(Sender);
  if((myEdit==NULL)||(myEdit->Text.Length()==0)) return;
  if(myEdit->Text.ToInt()==0);
 }
 catch(Exception &e){
  myEdit->Text="0";
 }
}
//---------------------------------------------------------------------------
void __fastcall TFormCountParam::ChangeDouble(TObject *Sender)
{
TCustomEdit *myEdit;
 try{
  myEdit=dynamic_cast<TCustomEdit*>(Sender);
  if((myEdit==NULL)||(myEdit->Text.Length()==0)) return;
  if(myEdit->Text.ToDouble()==0);
 }
 catch(Exception &e){
  myEdit->Text="0";
 }
}
//---------------------------------------------------------------------------
bool TFormCountParam::ProvMask(AnsiString Str)
{
 bool CanPoint=false;

 try{
	 if(Str.Length()==0) throw(Exception(""));
	 for(int i=1; i<=Str.Length();i++)
 		{
	     if((Str[i]=='9')||(CanPoint&&(Str[i]=='.'))){
         	if ((i>1)&&(Str[i]=='.'))	CanPoint=false;
         }else
         	throw(Exception(""));

	     if (i==1) CanPoint=true;
    	}
 }
 catch(Exception &e){
  Application->MessageBox(Reconst_smes9_2.c_str(),
            	Application->Title.c_str(), MB_OK|MB_ICONSTOP);
  return false;
 }
    return true;
}
//---------------------------------------------------------------------------
int TFormCountParam::GetMaskDigits(int db,AnsiString Digits)
{
 AnsiString Str="";
 AnsiString Str_db;
 if (Digits.Length()>0){
  char ch[20];
  strcpy(ch,Digits.c_str());
  return (atoi(ch)+1);
 }else{
 	   Str_db=AnsiString(abs(db));
       for(int i=0; i<Str_db.Length(); i++) Str=Str+"9";
       return (Str.ToInt()+1);
 }
}
//---------------------------------------------------------------------------
void __fastcall TFormCountParam::Edit13Exit(TObject *Sender)
{
  if(BitBtn2==ActiveControl) return;
  if(Panel7->Enabled)
    if(Edit13->Text.Length())
    {
        BitBtn1->Enabled=true;
    }
    else
    {
        BitBtn1->Enabled=false;
        Application->MessageBox(Reconst_smes9_4.c_str(), Application->Title.c_str(), MB_OK|MB_ICONSTOP);
        ActiveControl = Edit13;
    }
}
//---------------------------------------------------------------------------
void __fastcall TFormCountParam::FormShow(TObject *Sender)
{
	if(!Edit3->Text.Length()){
    Application->MessageBox(Reconst_smes9_5.c_str(), Application->Title.c_str(), MB_OK|MB_ICONSTOP);
    BitBtn1->Enabled = false;
    Panel7->Enabled = false;
    BitBtn3->Enabled = false;
    Panel21->Enabled = false;
    Panel22->Enabled = false;
    PostMessage(Handle,WM_CLOSE,0,0);//SAA 21.12.2001
  }else
    BitBtn1->Enabled=true;
}
//---------------------------------------------------------------------------

void __fastcall TFormCountParam::Edit12Change(TObject *Sender)
{
    Edit22->Text = Edit12->Text;
}
//---------------------------------------------------------------------------
bool  TFormCountParam::TreeWriteNew()
{
  double GetEnerInt;
// Add Kas 20.11.01  Определяем если есть показания по заменяемому счетчику с датой больше чем дата замены
//                   то не даем заменять
  char Min_DT[20], Max_DT[20], ChangeDate[16], Mtrsn[20];
  unsigned long DateCountStr = 0;
  strcpy(Mtrsn, Edit3->Text.c_str());
  strcpy(TypeCount->DataChange, DateTimePicker1->Date.FormatString("dd.mm.yyyy").c_str());
  sprintf(ChangeDate, "%s %s",TypeCount->DataChange, Edit12->Text.c_str());
  switch(TypeCount->Enertype){
    case 1: //A ptr  1
      //dmMain->quMain->SQL->Text="SELECT to_char(MIN(date_time), 'dd.mm.yyyy hh24:mi')DTMin, to_char(MAX(date_time), 'dd.mm.yyyy hh24:mi')DTMax FROM ryda.billorg WHERE mid=:par1 AND date_time>=to_date(:par2, 'dd.mm.yyyy hh24:mi') AND ER_mtrsn =:par3";
        oqBorder->ParamByName("pquery_type")->AsInteger = 1;
      break;
    case 2: //A get  2
      //dmMain->quMain->SQL->Text="SELECT to_char(MIN(date_time), 'dd.mm.yyyy hh24:mi')DTMin, to_char(MAX(date_time), 'dd.mm.yyyy hh24:mi')DTMax FROM ryda.billorg WHERE mid=:par1 AND date_time>=to_date(:par2, 'dd.mm.yyyy hh24:mi') AND ED_mtrsn =:par3";
      oqBorder->ParamByName("pquery_type")->AsInteger = 2;
      break;
    case 3: //Q1  3
      //dmMain->quMain->SQL->Text="SELECT to_char(MIN(date_time), 'dd.mm.yyyy hh24:mi')MDTMin, to_char(MAX(date_time), 'dd.mm.yyyy hh24:mi')DTMax FROM ryda.billorg WHERE mid=:par1 AND date_time>=to_date(:par2, 'dd.mm.yyyy hh24:mi') AND Q1_mtrsn =:par3";
      oqBorder->ParamByName("pquery_type")->AsInteger = 3;
      break;
    case 5: //Q3
      //dmMain->quMain->SQL->Text="SELECT to_char(MIN(date_time), 'dd.mm.yyyy hh24:mi')DTMin, to_char(MAX(date_time), 'dd.mm.yyyy hh24:mi')DTMax FROM ryda.billorg WHERE mid=:par1 AND date_time>=to_date(:par2, 'dd.mm.yyyy hh24:mi') AND Q3_mtrsn =:par3";
      oqBorder->ParamByName("pquery_type")->AsInteger = 4;
      break;
    default:
      if(TreeTable[0].SMART[0]=='*')
        //dmMain->quMain->SQL->Text="SELECT to_char(MIN(date_time), 'dd.mm.yyyy hh24:mi')DTMin, to_char(MAX(date_time), 'dd.mm.yyyy hh24:mi')DTMax FROM ryda.billorg WHERE mid=:par1 AND date_time>=to_date(:par2, 'dd.mm.yyyy hh24:mi')";
        oqBorder->ParamByName("pquery_type")->AsInteger = 0;
      else{
        Application->MessageBox(Reconst_smes9_6.c_str(), Application->Title.c_str(), MB_OK|MB_ICONSTOP);
        return false;
      }
      break;
  }

  /*dmMain->quMain->ParamByName("par1")->AsInteger=TypeCount->Mid;
  dmMain->quMain->ParamByName("par2")->AsString=ChangeDate;*/
  oqBorder->ParamByName("pmid")->AsInteger = TypeCount->Mid;
  oqBorder->ParamByName("pChangeDate")->AsString = ChangeDate;
  if((TypeCount->Enertype==1)||(TypeCount->Enertype==2)||(TypeCount->Enertype==3)||(TypeCount->Enertype==5))
    //dmMain->quMain->ParamByName("par3")->AsString=Mtrsn;
  oqBorder->ParamByName("pmtrsn")->AsString = Mtrsn;
  oqBorder->Execute();
  //dmMain->quMain->Execute();
  if(!oqBorder->FieldByName("DTMin")->IsNull){
    strcpy(Min_DT,oqBorder->FieldByName("DTMin")->AsString.c_str());
    DateCountStr=1;
  }
  if(!oqBorder->FieldByName("DTMax")->IsNull){
    strcpy(Min_DT,oqBorder->FieldByName("DTMax")->AsString.c_str());
    DateCountStr=1;
  }
  if(DateCountStr){
    AnsiString StrMsgErr=AnsiString(Reconst_smes9_7)+AnsiString(Min_DT)+AnsiString(Reconst_smes9_8);
    if(Application->MessageBox(StrMsgErr.c_str(), Application->Title.c_str(), MB_YESNO|MB_ICONWARNING)==IDNO)
      return false;
  }
  //---------- Привязка данных обновления счетчика ----------------------
  try{
    switch(TypeCount->Enertype){
      case 1:   meterDemIndic[0] = Edit23->Text.ToDouble(); meterNewIndic[5] = Edit24->Text.ToDouble(); meterNewIndic[0] = Edit25->Text.ToDouble(); break;
      case 2:   meterDemIndic[5] = Edit23->Text.ToDouble(); meterNewIndic[15] = Edit24->Text.ToDouble(); meterNewIndic[10] = Edit25->Text.ToDouble(); break;
      case 3:   meterDemIndic[10] = Edit23->Text.ToDouble(); meterNewIndic[25] = Edit24->Text.ToDouble(); meterNewIndic[20] = Edit25->Text.ToDouble(); break;
      case 5:   meterDemIndic[20] = Edit23->Text.ToDouble(); meterNewIndic[45] = Edit24->Text.ToDouble(); meterNewIndic[40] = Edit25->Text.ToDouble(); break;
    }
//    oqTreeWriteNew->SQL->Text="begin ryda.CHANGE_METER.Change_meter_p(:par1,to_date(:par2,'dd.mm.yyyy hh24:mi'),:par3,:par4,:par5,:par6,to_date(:par7,'dd.mm.yyyy hh24:mi'),:par8,:par9,:par10,:par11,:par12,:par13,:par14,:par15,:par16,:par17); end;";
    oqTreeWriteNew->ParamByName("an_mid")->AsInteger=TypeCount->Mid;
    oqTreeWriteNew->ParamByName("ad_date_time_d")->AsString=ChangeDate;
    oqTreeWriteNew->ParamByName("at_m")->Table=true;
    int j=0;
    for(int i=0; i<30; i++){
      oqTreeWriteNew->ParamByName("at_m")->Length=++j;
      oqTreeWriteNew->ParamByName("at_m")->ItemAsFloat[j]=meterDemIndic[i];
    }
    oqTreeWriteNew->ParamByName("an_entype")->AsInteger=TypeCount->Enertype;
    oqTreeWriteNew->ParamByName("av_smart")->AsString=TreeTable[0].SMART;
    oqTreeWriteNew->ParamByName("av_mtrsn")->AsString=Edit13->Text;
    oqTreeWriteNew->ParamByName("ad_date_time")->AsString=ChangeDate;
    oqTreeWriteNew->ParamByName("an_digits")->AsString=Edit14->Text;
    oqTreeWriteNew->ParamByName("av_mtype")->AsString=Edit15->Text;
    oqTreeWriteNew->ParamByName("an_mcurrent")->AsInteger=Edit16->Text.ToInt();
    oqTreeWriteNew->ParamByName("an_mpower")->AsInteger=Edit17->Text.ToInt();
    oqTreeWriteNew->ParamByName("an_mconst")->AsInteger=Edit20->Text.ToInt();
    oqTreeWriteNew->ParamByName("an_mclass")->AsFloat=Edit21->Text.ToDouble();
    oqTreeWriteNew->ParamByName("an_myear")->AsInteger=Edit18->Text.ToInt();
    oqTreeWriteNew->ParamByName("an_mquarter")->AsInteger=Edit19->Text.ToInt();
    oqTreeWriteNew->ParamByName("av_memo")->AsString=Edit2->Text;
    oqTreeWriteNew->ParamByName("at_new_m")->Table=true;
    j=0;
    for(int i=0; i<60; i++){
      oqTreeWriteNew->ParamByName("at_new_m")->Length=++j;
      oqTreeWriteNew->ParamByName("at_new_m")->ItemAsFloat[j]=meterNewIndic[i];
    }
  }catch(Exception &e){
    Application->MessageBox(Reconst_smes9_9.c_str(), Application->Title.c_str(), MB_OK|MB_ICONSTOP);
    return false;
  }
  oqTreeWriteNew->Execute();
  dmMain->orases->Commit();
  return true;
}
//---------------------------------------------------------------------------

