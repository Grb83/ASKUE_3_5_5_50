//---------------------------------------------------------------------------
#include <vcl.h>
#include <stdio.h>
#pragma hdrstop
//#include "un_utl.h"
#include "unDataMod.h"
#include "Vit_Delta.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "DrawTable"
#pragma resource "*.dfm"
//---------------------------------------------------------------------------
__fastcall TFormVITInputDelta::TFormVITInputDelta(TComponent* Owner, AnsiString Name, TAccess a)
	: TMainForm(Owner, Name, a)
{
   pointPOL.myTime=TDateTime::CurrentDate();
}
//---------------------------------------------------------------------------

void __fastcall TFormVITInputDelta::FormCreate(TObject *Sender)
{
	vParams(NULL);
}
//---------------------------------------------------------------------------

void __fastcall TFormVITInputDelta::DrawTable1SetEditText(TObject *Sender,
	int ACol, int ARow, const AnsiString Value)
{
  if(!pointLastInput[ARow/2 - 1].editRecord)
    pointLastInput[ARow/2 - 1].editRecord=true;
  if(!EditRec)
    EditRec=true;
  if(prov)
    prov=0;
}
//---------------------------------------------------------------------------
void __fastcall TFormVITInputDelta::DrawTable1DrawCell(TObject *Sender, int Col, int Row, TRect &Rect,
	TGridDrawState State)
{
	 	if( State.Contains(gdSelected)&& DrawTable1->Focused()){
    	DrawTable1->Canvas->Brush->Color=clBtnFace;
    	DrawTable1->Canvas->FillRect(Rect);
    }else if( State.Contains(gdSelected)){
            DrawTable1->Canvas->Brush->Color=clBtnFace;
      	    DrawTable1->Canvas->FillRect(Rect);
          }
}
//---------------------------------------------------------------------------
void __fastcall TFormVITInputDelta::DrawTable1KeyDown(TObject *Sender,
	WORD &Key, TShiftState Shift)
{
  long ACol=DrawTable1->Col,ARow;
  if(!CountStr||DrawTable1->EditorMode)
    return;

	switch(Key){
    case 37: // VK_LEFT:
      if( DrawTable1->Col==4 ){
        ACol=7;		// 7-в случае ввода по тарифу D
        if(DrawTable1->Row != 2)
          ARow=DrawTable1->Row-2;
        else
          ARow=DrawTable1->RowCount-1;
        PostMessage(Handle,WM_SELECTCELL,(WPARAM)ACol,(LPARAM)ARow);
      }
      break;
    case 38: // VK_UP:
      if( DrawTable1->Row-2 >= 0 ){
        if(DrawTable1->Col!=9)
          DrawTable1->Row-=2;
        else
          DrawTable1->Row-=1;
      }
      break;
    case 39: // VK_RIGHT:
      if( DrawTable1->Col==7 ){// 7-в случае ввода по тарифу D
        ACol=4;
        if(DrawTable1->Row != DrawTable1->RowCount-1)
          ARow=DrawTable1->Row+2;
        else
          ARow=2;
        PostMessage(Handle,WM_SELECTCELL,(WPARAM)ACol,(LPARAM)ARow);
      }
      break;
    case 40: // VK_DOWN:
      if( DrawTable1->Row+2 < DrawTable1->RowCount ){
        if(DrawTable1->Col!=9)
          DrawTable1->Row+=2;
        else
          DrawTable1->Row+=1;
      }
      break;
  }
}
//---------------------------------------------------------------------------
void __fastcall TFormVITInputDelta::WMSelectCell(TMessage & Message)
{
  DrawTable1->Col=Message.WParam;
  DrawTable1->Row=Message.LParam;

  if(Message.LParam==2)
    DrawTable1->TopRow=1;
  if(Message.LParam==DrawTable1->RowCount-1)
    DrawTable1->TopRow=Message.LParam-DrawTable1->VisibleRowCount+1;
}
//---------------------------------------------------------------------------

void __fastcall TFormVITInputDelta::vParams(TObject* Sender)
{
   TFormVVMeter *f=NULL;
   try{
      if(EditRec)
      switch(MessageBox(Handle, Reconst_smes79_1.c_str(), Application->Title.c_str(),MB_YESNOCANCEL|MB_ICONQUESTION))
      {
      case IDYES:
         vSave(Sender);
         if(EditRec) return;
         break;
      case IDCANCEL:
         return;
      }
      f= new TFormVVMeter(this,&pointPOL);
      if((f->ShowModal() == mrOk)&&f->tvMain->Selected){
         MainProc(Sender);
      }else{
         if(!Sender)
            Close();
      }
      delete f;
      if(Sender)
         DrawTable1->SetFocus();
   }catch (Exception &exception){
      if(f)
         delete f;
      Application->ShowException(&exception);
      if(!Sender)
         Close();
   }
}
//---------------------------------------------------------------------------

void __fastcall TFormVITInputDelta::vRefresh(TObject* Sender)
{
  MainProc(this);
  DrawTable1->SetFocus();
}
//---------------------------------------------------------------------------
void __fastcall TFormVITInputDelta::MainProc(TObject *Sender)
{
	char seldat[20];
 // int state;
  AnsiString sql  =(pointPOL.ifpoint)? "select f.mid, pa.name||'/'||p.name name, ryda.indic_pg.measurename(mn.nmeasure,decode(f.q1234,'*',1,0)) type, \
                        m.position, mn.nmeasure, m.mtrsn, nvl(f.kc,1)KC, m.digits, \
                        to_char(ryda.indic_pg.getlastdate(f.mid,to_date(:par8, 'dd.mm.yyyy hh24:mi'),mn.nmeasure,NULL,5,2),'dd.mm.yyyy hh24:mi') lastd, \
                        ryda.indic_pg.getlastdebit(f.mid,to_date(:par8, 'dd.mm.yyyy hh24:mi'),mn.nmeasure,NULL,5) lastind, \
                        ryda.indic_pg.getlastdebit(f.mid,to_date(:par8, 'dd.mm.yyyy hh24:mi'),mn.nmeasure,1,5) lastindA, \
                        ryda.indic_pg.getlastdebit(f.mid,to_date(:par8, 'dd.mm.yyyy hh24:mi'),mn.nmeasure,2,5) lastindB, \
                        ryda.indic_pg.getlastdebit(f.mid,to_date(:par8, 'dd.mm.yyyy hh24:mi'),mn.nmeasure,3,5) lastindC, \
                        ryda.indic_pg.getlastdebit(f.mid,to_date(:par8, 'dd.mm.yyyy hh24:mi'),mn.nmeasure,4,5) lastindD, \
                        decode(mn.nmeasure,1,b.er,2,b.ed,3,b.q1,4,b.q2,5,b.q3,6,b.q4) e, \
                        decode(mn.nmeasure,1,b.aer,2,b.aed,3,b.aq1,4,b.aq2,5,b.aq3,6,b.aq4) ae, \
                        decode(mn.nmeasure,1,b.ber,2,b.bed,3,b.bq1,4,b.bq2,5,b.bq3,6,b.bq4) be, \
                        decode(mn.nmeasure,1,b.cer,2,b.ced,3,b.cq1,4,b.cq2,5,b.cq3,6,b.cq4) ce, \
                        decode(mn.nmeasure,1,b.der,2,b.ded,3,b.dq1,4,b.dq2,5,b.dq3,6,b.dq4) de \
                      from (select rownum nmeasure from dict where rownum<=6) mn,ryda.billorg b,ryda.meters m,ryda.feeders f,ryda.points p,ryda.points pa \
                      where mn.nmeasure in (:par1, :par2, :par3, :par4, :par5, :par6) \
                        and f.mid in (select mid from ryda.points where ind = 3 start with mid = :par7 connect by prior mid = parent) \
                        and f.mid=b.mid(+) and b.date_time(+)=to_date(:par8, 'dd.mm.yyyy hh24:mi') and f.mid=m.mid(+) \
                        and ryda.indic_pg.is_availability(mn.nmeasure,decode(f.q1234,'*',1,0),f.er_position,f.ed_position,f.q1_position,f.q3_position)=1 \
                        and mn.nmeasure=decode(m.entype,7,mn.nmeasure,m.entype)\
                        and f.mid=p.mid(+) and p.parent=pa.mid(+)\
                      order by m.position, pa.name,p.name,mn.nmeasure":

                      "select \
                        distinct  \
                        f.mid, pa.name||'/'||p.name name, ryda.indic_pg.measurename(mn.nmeasure,decode(f.q1234,'*',1,0)) type, \
                        m.position, mn.nmeasure, m.mtrsn, nvl(f.kc,1)KC, m.digits, \
                        to_char(ryda.indic_pg.getlastdate(f.mid,to_date(:par8, 'dd.mm.yyyy hh24:mi'),mn.nmeasure,NULL,5,2),'dd.mm.yyyy hh24:mi') lastd, \
                        ryda.indic_pg.getlastdebit(f.mid,to_date(:par8, 'dd.mm.yyyy hh24:mi'),mn.nmeasure,NULL,5) lastind, \
                        ryda.indic_pg.getlastdebit(f.mid,to_date(:par8, 'dd.mm.yyyy hh24:mi'),mn.nmeasure,1,5) lastindA, \
                        ryda.indic_pg.getlastdebit(f.mid,to_date(:par8, 'dd.mm.yyyy hh24:mi'),mn.nmeasure,2,5) lastindB, \
                        ryda.indic_pg.getlastdebit(f.mid,to_date(:par8, 'dd.mm.yyyy hh24:mi'),mn.nmeasure,3,5) lastindC, \
                        ryda.indic_pg.getlastdebit(f.mid,to_date(:par8, 'dd.mm.yyyy hh24:mi'),mn.nmeasure,4,5) lastindD, \
                        decode(mn.nmeasure,1,b.er,2,b.ed,3,b.q1,4,b.q2,5,b.q3,6,b.q4) e, \
                        decode(mn.nmeasure,1,b.aer,2,b.aed,3,b.aq1,4,b.aq2,5,b.aq3,6,b.aq4) ae, \
                        decode(mn.nmeasure,1,b.ber,2,b.bed,3,b.bq1,4,b.bq2,5,b.bq3,6,b.bq4) be, \
                        decode(mn.nmeasure,1,b.cer,2,b.ced,3,b.cq1,4,b.cq2,5,b.cq3,6,b.cq4) ce, \
                        decode(mn.nmeasure,1,b.der,2,b.ded,3,b.dq1,4,b.dq2,5,b.dq3,6,b.dq4) de \
                      from (select rownum nmeasure from dict where rownum<=6) mn,ryda.billorg b,ryda.meters m,ryda.feeders f,ryda.points p,ryda.points pa \
                      where mn.nmeasure in (:par1, :par2, :par3, :par4, :par5, :par6) \
                        and f.mid in (select mid from ryda.groups where mid is not null start with gid = :par7 connect by prior gid = parent) \
                        and f.mid=b.mid(+) and b.date_time(+)=to_date(:par8, 'dd.mm.yyyy hh24:mi') and f.mid=m.mid(+) \
                        and ryda.indic_pg.is_availability(mn.nmeasure,decode(f.q1234,'*',1,0),f.er_position,f.ed_position,f.q1_position,f.q3_position)=1 \
                        and mn.nmeasure=decode(m.entype,7,mn.nmeasure,m.entype)\
                        and f.mid=p.mid(+) and p.parent=pa.mid(+) \
                        order by m.position, 2,mn.nmeasure";

  try{

    Caption=TaskName+Reconst_smes79_2+pointPOL.myTime.FormatString("dd.mm.yyyy hh:nn");
    CountStr=0;
    EditRec=false;
    prov=0;
    ZeroMemory( &pointLastInput, sizeof(pointLastInput) );
    DrawTable1->StaticStrings->Clear();
    DrawTable1->TabStrings->Clear();
    strcpy(seldat,pointPOL.myTime.FormatString("dd.mm.yyyy hh:nn").c_str());
    //GRB ADD 16.04.2020 - test trouble ODAC
    dmMain->quMain->Params->Clear();
    //END ADD 
    dmMain->quMain->SQL->Text=sql;
    dmMain->quMain->ParamByName("par1")->AsInteger=pointPOL.entype[0];
    dmMain->quMain->ParamByName("par2")->AsInteger=pointPOL.entype[1];
    dmMain->quMain->ParamByName("par3")->AsInteger=pointPOL.entype[2];
    dmMain->quMain->ParamByName("par4")->AsInteger=pointPOL.entype[3];
    dmMain->quMain->ParamByName("par5")->AsInteger=pointPOL.entype[4];
    dmMain->quMain->ParamByName("par6")->AsInteger=pointPOL.entype[5];
    dmMain->quMain->ParamByName("par7")->AsInteger=pointPOL.mid;
    dmMain->quMain->ParamByName("par8")->AsString=seldat;
    dmMain->quMain->Execute();
    int i=0;
    while(!dmMain->quMain->Eof&&i<MAXINPUT){
    if(!dmMain->quMain->FieldByName("mid")->IsNull)
      strcpy(pointLastInput[i].Mid,dmMain->quMain->FieldByName("mid")->AsString.c_str());
    if(!dmMain->quMain->FieldByName("name")->IsNull)
      strcpy(pointLastInput[i].Name,dmMain->quMain->FieldByName("name")->AsString.c_str());
    if(!dmMain->quMain->FieldByName("type")->IsNull)
      strcpy(pointLastInput[i].Type,dmMain->quMain->FieldByName("type")->AsString.c_str());
    if(!dmMain->quMain->FieldByName("position")->IsNull)
      strcpy(pointLastInput[i].Position,dmMain->quMain->FieldByName("position")->AsString.c_str());
    if(!dmMain->quMain->FieldByName("nmeasure")->IsNull)
      strcpy(pointLastInput[i].Entype,dmMain->quMain->FieldByName("nmeasure")->AsString.c_str());
    if(!dmMain->quMain->FieldByName("mtrsn")->IsNull)
      strcpy(pointLastInput[i].Mtrsn,dmMain->quMain->FieldByName("mtrsn")->AsString.c_str());
    if(!dmMain->quMain->FieldByName("KC")->IsNull)
      strcpy(pointLastInput[i].KC,dmMain->quMain->FieldByName("KC")->AsString.c_str());
    if(!dmMain->quMain->FieldByName("digits")->IsNull)
      strcpy(pointLastInput[i].Digits,dmMain->quMain->FieldByName("digits")->AsString.c_str());
    if(!dmMain->quMain->FieldByName("lastd")->IsNull)
      strcpy(pointLastInput[i].Date_time,dmMain->quMain->FieldByName("lastd")->AsString.c_str());
    if(!dmMain->quMain->FieldByName("lastind")->IsNull)
      strcpy(pointLastInput[i].E,dmMain->quMain->FieldByName("lastind")->AsString.c_str());
    if(!dmMain->quMain->FieldByName("lastindA")->IsNull)
      strcpy(pointLastInput[i].AE,dmMain->quMain->FieldByName("lastindA")->AsString.c_str());
    if(!dmMain->quMain->FieldByName("lastindB")->IsNull)
      strcpy(pointLastInput[i].BE,dmMain->quMain->FieldByName("lastindB")->AsString.c_str());
    if(!dmMain->quMain->FieldByName("lastindC")->IsNull)
      strcpy(pointLastInput[i].CE,dmMain->quMain->FieldByName("lastindC")->AsString.c_str());
    if(!dmMain->quMain->FieldByName("lastindD")->IsNull)
      strcpy(pointLastInput[i].DE,dmMain->quMain->FieldByName("lastindD")->AsString.c_str());
    if(!dmMain->quMain->FieldByName("e")->IsNull)
      strcpy(pointLastInput[i].E_N,dmMain->quMain->FieldByName("e")->AsString.c_str());
    if(!dmMain->quMain->FieldByName("ae")->IsNull)
      strcpy(pointLastInput[i].AE_N,dmMain->quMain->FieldByName("ae")->AsString.c_str());
    if(!dmMain->quMain->FieldByName("be")->IsNull)
      strcpy(pointLastInput[i].BE_N,dmMain->quMain->FieldByName("be")->AsString.c_str());
    if(!dmMain->quMain->FieldByName("ce")->IsNull)
      strcpy(pointLastInput[i].CE_N,dmMain->quMain->FieldByName("ce")->AsString.c_str());
    if(!dmMain->quMain->FieldByName("de")->IsNull)
      strcpy(pointLastInput[i].DE_N,dmMain->quMain->FieldByName("de")->AsString.c_str());
    dmMain->quMain->Next();
    i++;
    }
     CountStr=i;


    DrawTable1->RowCount=1+2*CountStr;
    DrawTable1->ColCount=9;
    DrawTable1->ColsWidth="#-200#60#60#120#100#100#100#100#0";
    DrawTable1->TabStrings->Add("B C40 T25 M0x5 0xF$#$##$#$#$#$#$#$");
    DrawTable1->StaticStrings->Add(Reconst_smes79_3);
    DrawTable1->StaticStrings->Add(Reconst_smes79_4);
    DrawTable1->StaticStrings->Add(Reconst_smes79_5);
    DrawTable1->StaticStrings->Add(Reconst_smes79_6);
    DrawTable1->StaticStrings->Add("A");
    DrawTable1->StaticStrings->Add("B");
    DrawTable1->StaticStrings->Add("C");
    DrawTable1->StaticStrings->Add("D");
    static int VarDescr[]={100,20,20,20,20,20};
    DrawTable1->StructStrings->Rebuild(CountStr,5,VarDescr);
    DrawTable1->VarStrings->Clear();
    for(int i=0;i<(int)CountStr;i++){
  		DrawTable1->TabStrings->Add("B- C40 T25 A0 M0x5 0x8007$#A1$#C42 T27 A0x8025 M0x1 0x800E$#$#$#$#$#$#$");
    	DrawTable1->TabStrings->Add("A0x8015 M0x5 0x800D C40 T25 ^#^#C42 T27 M0x1 0x800C $#$#T25 E# E# E# E# E");
        DrawTable1->StaticStrings->Add(AnsiString("  ")+pointLastInput[i].Name+" "+AnsiString(pointLastInput[i].Mtrsn));
        DrawTable1->StaticStrings->Add(pointLastInput[i].Type);
        DrawTable1->StaticStrings->Add(Reconst_smes79_7);
        DrawTable1->StaticStrings->Add(pointLastInput[i].Date_time);
        DrawTable1->StaticStrings->Add(pointLastInput[i].E);
        DrawTable1->StaticStrings->Add(pointLastInput[i].AE);
        DrawTable1->StaticStrings->Add(pointLastInput[i].BE);
        DrawTable1->StaticStrings->Add(pointLastInput[i].CE);
        DrawTable1->StaticStrings->Add(pointLastInput[i].DE);
        DrawTable1->StaticStrings->Add(Reconst_smes79_8);
        DrawTable1->StaticStrings->Add(pointPOL.myTime.FormatString("dd.mm.yyyy hh:nn"));
        DrawTable1->VarStrings->Add(pointLastInput[i].E_N);
        DrawTable1->VarStrings->Add(pointLastInput[i].AE_N);
        DrawTable1->VarStrings->Add(pointLastInput[i].BE_N);
        DrawTable1->VarStrings->Add(pointLastInput[i].CE_N);
  		DrawTable1->VarStrings->Add(pointLastInput[i].DE_N);
    }
    if(CountStr){
    	DrawTable1->UpdateTabStrings();
      DrawTable1->FocusCell(4,2);
    }
    else
    {
        Application->MessageBox(Reconst_smes79_9.c_str(),Application->Title.c_str(),MB_OK|MB_ICONINFORMATION);
    }
    DrawTable1->Invalidate();

  }catch (Exception &e){
    DrawTable1->Invalidate();
    if(Sender){
      DrawTable1->SetFocus();
    }

    throw;
  }
}
//---------------------------------------------------------------------------
bool __fastcall TFormVITInputDelta::CheckRas(void)
{
  AnsiString sras;
  double dopusk;
  TDrawTable::SAttrCell *pRas;
  long j=-1,z=0;

  if(prov||!CountStr)//была проверка или нет записей
    return true;

  try{
    Screen->Cursor=crHourGlass;
    prov=2;//Можно сохранять
    for(j=0;j <(long)CountStr ;j++){
      if(!pointLastInput[j].editRecord)
        continue;
      dopusk=0;
      z=0;
      for(z=0;z<4;z++){
        pRas=(TDrawTable::SAttrCell *)DrawTable1->GetCellAttr(4+z,2+2*j);
        sras = pRas->SourceData->Strings[pRas->IndexData];
        switch(z){
          case 0:
            strcpy(pointLastInput[j].E_N,sras.c_str());
            break;
          case 1:
            strcpy(pointLastInput[j].AE_N,sras.c_str());
            break;
          case 2:
            strcpy(pointLastInput[j].BE_N,sras.c_str());
            break;
          case 3:
            strcpy(pointLastInput[j].CE_N,sras.c_str());
            break;
          case 4:
            strcpy(pointLastInput[j].DE_N,sras.c_str());
            break;
        }
        if(sras.IsEmpty()){
          sras="0";
//          pRas->SourceData->Strings[pRas->IndexData]="0";
        }
        dopusk+=(((z)?-1.0:1.0)*sras.ToDouble());
      }
      z=0;
      if(abs(dopusk)>=1)
        throw Exception (Reconst_smes79_10+FormatFloat("########0.00",dopusk));
    }
    Screen->Cursor=crDefault;
    DrawTable1->Invalidate();
    DrawTable1->SetFocus();
  }catch(Exception &exception){
    prov=0;
    Screen->Cursor=crDefault;
    if(j>=0){
      DrawTable1->FocusCell(3+z,2+2*j);
      if(DrawTable1->VisibleRowCount<2*(long)CountStr-1)
        DrawTable1->TopRow=1+2*j;
    }
  	Application->ShowException(&exception);
    DrawTable1->Invalidate();
    DrawTable1->SetFocus();
    return false;
  }
  return true;
}
//---------------------------------------------------------------------------
//save
void __fastcall TFormVITInputDelta::vSave(TObject* Sender)
{
    long i=-1;
	char seldat[20];
    POINTLASTINPUT pLI;
    static char *insupd = "begin \
                           ryda.indic_pg.setdebit(:par12,to_date(:par11, 'dd.mm.yyyy hh24:mi'),:par17,5,'Р.В',:par14,:par15,:par16,:par6,:par7,:par8,:par9,:par10); \
                         end;";
    if(!EditRec||!CountStr||!CheckRas())//нет редактирования или нет записей
        return;

  try{

    strcpy(seldat,pointPOL.myTime.FormatString("dd.mm.yyyy hh:nn").c_str());
    //GRB ADD 16.04.2020 - test trouble ODAC
    dmMain->quMain->Params->Clear();
    //END ADD 
    dmMain->quMain->SQL->Text=insupd;

    for(i=0; i <(long) CountStr; i++ ){
        if(pointLastInput[i].editRecord){
            pLI=pointLastInput[i];
            dmMain->quMain->ParamByName("par6")->AsString=pLI.E_N;
            dmMain->quMain->ParamByName("par7")->AsString=pLI.AE_N;
            dmMain->quMain->ParamByName("par8")->AsString=pLI.BE_N;
            dmMain->quMain->ParamByName("par9")->AsString=pLI.CE_N;
            dmMain->quMain->ParamByName("par10")->AsString=pLI.DE_N;
            dmMain->quMain->ParamByName("par11")->AsString=seldat;
            dmMain->quMain->ParamByName("par12")->AsString=pLI.Mid;
            dmMain->quMain->ParamByName("par14")->AsString=UsCon.uName;
            dmMain->quMain->ParamByName("par15")->AsString=pLI.Mtrsn;
            dmMain->quMain->ParamByName("par16")->AsString=pLI.KC;
            dmMain->quMain->ParamByName("par17")->AsString=pLI.Entype;
            dmMain->quMain->Execute();

        }
    }
    i=-1;
    dmMain->orases->Commit();

    EditRec=false;
    prov=0;
    for(long j=0;j <(long)CountStr ;j++){
        if(pointLastInput[j].editRecord)
            pointLastInput[j].editRecord=false;
    }

  }catch(Exception &exception){
    dmMain->orases->Rollback();

    if(i>=0){
        DrawTable1->FocusCell(3,2+2*i);
        if(DrawTable1->VisibleRowCount<2*(long)CountStr-1)
            DrawTable1->TopRow=1+2*i;
    }
  	Application->ShowException(&exception);
  }
    DrawTable1->Invalidate();
    DrawTable1->SetFocus();
}
//---------------------------------------------------------------------------
void __fastcall TFormVITInputDelta::DrawTable1KeyPress(TObject *Sender,
      char &Key)
{
  AnsiString S=(AnsiString)Key;
  AnsiString S1=".0123456789\b\r";
  if(!S1.Pos(S)){
    Key=NULL;
    Beep();
    return;
  }
}
//---------------------------------------------------------------------------

inline void __fastcall TFormVITInputDelta::SetAccess(TAccess value)
{
   if(FAccess!=value)
      TMainForm::SetAccess(value);
}
//---------------------------------------------------------------------------

