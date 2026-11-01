//---------------------------------------------------------------------------
#include <vcl.h>
#include <stdio.h>
#pragma hdrstop
#include "unDataMod.h"
#include "VIT_InputExcel.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "DrawTable"
#pragma resource "*.dfm"
//---------------------------------------------------------------------------
__fastcall TFormVITInputExcel::TFormVITInputExcel(TComponent* Owner,AnsiString Name, long ttable,long rezerv, TAccess a)
	: TMainForm(Owner, Name, a)
{
   this->ttable=ttable;
   switch(ttable){
   case 1:
      tname="BILL";
      break;
   case 2:
      tname="HALFHOUR";
      pointPOL.usetime=true;
      addwhere=" and nvl(b.nsource,0) not in (7,8) ";//эх яюърчрэш  яЁш чрьхэх
      break;
   case 13:
      tname="MAN_INP_HHOUR";
      pointPOL.usetime=true;
      break;
   case 3:
      tname="PROFILE";
      pointPOL.usetime=true;
      break;
   case 5:
   case 6:
   case 7:
   case 8:
      tname="BILLORG";
      pointPOL.usetime=true;
      addwhere=" and nvl(b.nsource,0) not in (7,8) ";//эх яюърчрэш  яЁш чрьхэх
      break;
   default:
      tname="MONTHS";
      addwhere=" and nvl(b.nsource,0) not in (7,8) ";//эх яюърчрэш  яЁш чрьхэх
   }
   pointPOL.myTime=TDateTime::CurrentDate();
}
//---------------------------------------------------------------------------

void __fastcall TFormVITInputExcel::FormCreate(TObject *Sender)
{
	vParams(NULL);
}
//---------------------------------------------------------------------------

void __fastcall TFormVITInputExcel::DrawTable1SetEditText(TObject *Sender,
	int ACol, int ARow, const AnsiString Value)
{
   if(Access==accRead) return;
   if(ACol!=6)
      return;
   if(!pointLastInput[ARow - 1].editRecord)
      pointLastInput[ARow - 1].editRecord=true;
   if(!EditRec)
      EditRec = true;
   if(prov)
      prov=0;
}
//---------------------------------------------------------------------------
void __fastcall TFormVITInputExcel::DrawTable1GetEditMask(TObject *Sender,
	int ACol, int ARow, AnsiString &Value)
{
	AnsiString strTr=AnsiString(pointLastInput[ARow - 1].Digits);
	if(strTr.Length()>0)
    Value="!" + strTr + ";1;_";
}
//---------------------------------------------------------------------------
void __fastcall TFormVITInputExcel::DrawTable1DrawCell(TObject *Sender, int Col, int Row, TRect &Rect,
	TGridDrawState State)
{
   if(State.Contains(gdSelected)&& DrawTable1->Focused()){
      DrawTable1->Canvas->Brush->Color=clBtnFace;
    	DrawTable1->Canvas->FillRect(Rect);
   }else if( State.Contains(gdSelected)){
      DrawTable1->Canvas->Brush->Color=clBtnFace;
      DrawTable1->Canvas->FillRect(Rect);
   }
}
//---------------------------------------------------------------------------
void __fastcall TFormVITInputExcel::DrawTable1KeyDown(TObject *Sender,
	WORD &Key, TShiftState Shift)
{
	int ACol,ARow;
  if(DrawTable1->EditorMode){
   	if(Key==13)
	    Key=40;
    else
      return;
  }
  if(CountStr==0)
    return;
  ACol=DrawTable1->Col;
	switch(Key){
    case 38: // VK_UP:
      if(DrawTable1->Row != 1)
        ARow=DrawTable1->Row-1;
      else{
        ARow=DrawTable1->RowCount-1;
        PostMessage(Handle,WM_SELECTCELL,(WPARAM)ACol,(LPARAM)ARow);
      }
      break;
    case 40: // VK_DOWN:
      if( DrawTable1->Row != DrawTable1->RowCount-1 )
        ARow=DrawTable1->Row+1;
      else
        ARow=1;
        PostMessage(Handle,WM_SELECTCELL,(WPARAM)ACol,(LPARAM)ARow);
      break;
    }
}
//---------------------------------------------------------------------------
void __fastcall TFormVITInputExcel::WMSelectCell(TMessage & Message)
{
  DrawTable1->Col=Message.WParam;
  DrawTable1->Row=Message.LParam;
  if(Message.LParam==1)
    DrawTable1->TopRow=1;
  if(Message.LParam==DrawTable1->RowCount-1)
    DrawTable1->TopRow=Message.LParam-DrawTable1->VisibleRowCount+1;
}
//---------------------------------------------------------------------------
void __fastcall TFormVITInputExcel::vParams(TObject* Sender)
{
  TFormVVMeter *f=NULL;
  try{
    if(EditRec){
      switch(MessageBox(Handle,Reconst_smes82_1.c_str(),Application->Title.c_str(),MB_YESNOCANCEL|MB_ICONQUESTION|MB_DEFBUTTON1)){
        case IDYES:
          vSave(Sender);
          if(EditRec){
            DrawTable1->SetFocus();
            return;
          }
          break;
        case IDNO:
          break;
        default :
          DrawTable1->SetFocus();
          return;
      }
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

void __fastcall TFormVITInputExcel::MainProc(TObject *Sender)
{
	char seldat[20];
  int state;
    AnsiString sql  =(pointPOL.ifpoint)? AnsiString("select f.mid, f.vcode||decode(f.vcode,NULL,'','  /')||pa.name||'/'||p.name name, ryda.indic_pg.measurename(mn.nmeasure,decode(f.q1234,'*',1,0)) type, \
                        DECODE(mn.nmeasure,1,f.er_position,2,f.ed_position,3,f.q1_position,5,f.q3_position) Position, \
                        mn.nmeasure, m.mtrsn, nvl(f.kc,1) KC, m.digits, \
                        to_char(ryda.indic_pg.getlastdate(f.mid,to_date(:par8, 'dd.mm.yyyy hh24:mi'),mn.nmeasure,NULL,:par101,1),'dd.mm.yyyy hh24:mi') lastd, \
                        ryda.indic_pg.getlastindic(f.mid,to_date(:par8, 'dd.mm.yyyy hh24:mi'),mn.nmeasure,NULL,:par101) lastind, \
                        decode(mn.nmeasure,1,b.erm,2,b.edm,3,b.q1m,4,b.q2m,5,b.q3m,6,b.q4m) em, \
                        decode(mn.nmeasure,1,b.er,2,b.ed,3,b.q1,4,b.q2,5,b.q3,6,b.q4) e \
                      from (select rownum nmeasure from dict where rownum<=6) mn,ryda.")+tname+AnsiString(" b,ryda.meters m,ryda.feeders f,ryda.points p,ryda.points pa \
                      where mn.nmeasure in (:par1, :par2, :par3, :par4, :par5, :par6) ")+addwhere+AnsiString(" \
                        and f.mid in (select mid from ryda.points where ind = 3 start with mid = :par7 connect by prior mid = parent)  \
                        and f.mid=b.mid(+) and b.date_time(+)=to_date(:par8, 'dd.mm.yyyy hh24:mi') and f.mid=m.mid(+) \
                        and ryda.indic_pg.is_availability(mn.nmeasure,decode(f.q1234,'*',1,0),f.er_position,f.ed_position,f.q1_position,f.q3_position)=1 \
                        and mn.nmeasure=decode(m.entype,7,mn.nmeasure,m.entype)\
                        and f.mid=p.mid(+) and p.parent=pa.mid(+)\
                      order by m.position, pa.name,p.name,mn.nmeasure"):

                       AnsiString("select \
                        distinct  \
                        f.mid, f.vcode||decode(f.vcode,NULL,'','  /')||pa.name||'/'||p.name name, ryda.indic_pg.measurename(mn.nmeasure,decode(f.q1234,'*',1,0)) type, \
                        DECODE(mn.nmeasure,1,f.er_position,2,f.ed_position,3,f.q1_position,5,f.q3_position) Position, \
                        mn.nmeasure, m.mtrsn, nvl(f.kc,1) KC, m.digits, \
                        to_char(ryda.indic_pg.getlastdate(f.mid,to_date(:par8, 'dd.mm.yyyy hh24:mi'),mn.nmeasure,NULL,:par101,1),'dd.mm.yyyy hh24:mi') lastd, \
                        ryda.indic_pg.getlastindic(f.mid,to_date(:par8, 'dd.mm.yyyy hh24:mi'),mn.nmeasure,NULL,:par101) lastind, \
                        decode(mn.nmeasure,1,b.erm,2,b.edm,3,b.q1m,4,b.q2m,5,b.q3m,6,b.q4m) em, \
                        decode(mn.nmeasure,1,b.er,2,b.ed,3,b.q1,4,b.q2,5,b.q3,6,b.q4) e \
                      from (select rownum nmeasure from dict where rownum<=6) mn,ryda.")+tname+AnsiString(" b,ryda.meters m,ryda.feeders f,ryda.points p,ryda.points pa \
                      where mn.nmeasure in (:par1, :par2, :par3, :par4, :par5, :par6) ")+addwhere+AnsiString(" \
                        and f.mid in (select mid from ryda.groups where mid is not null start with gid = :par7 connect by prior gid = parent)  \
                        and f.mid=b.mid(+) and b.date_time(+)=to_date(:par8, 'dd.mm.yyyy hh24:mi') and f.mid=m.mid(+) \
                        and ryda.indic_pg.is_availability(mn.nmeasure,decode(f.q1234,'*',1,0),f.er_position,f.ed_position,f.q1_position,f.q3_position)=1 \
                        and mn.nmeasure=decode(m.entype,7,mn.nmeasure,m.entype)\
                        and f.mid=p.mid(+) and p.parent=pa.mid(+)  \
                       order by  2,mn.nmeasure");


  try{

    Caption = TaskName+Reconst_smes81_2+pointPOL.myTime.FormatString("dd.mm.yyyy hh:nn");
    CountStr=0;
    EditRec = false;
    prov=0;
    ZeroMemory( &pointLastInput, sizeof(pointLastInput) );
    DrawTable1->StaticStrings->Clear();
    DrawTable1->TabStrings->Clear();
    strcpy(seldat,pointPOL.myTime.FormatString("dd.mm.yyyy hh:nn").c_str());
    //GRB ADD 16.04.2020 - test trouble ODAC
    dmMain->quMain->Params->Clear();
    //END ADD 

    dmMain->quMain->SQL->Text=sql;
    dmMain->quMain->ParamByName("par1")->AsInteger= pointPOL.entype[0];
    dmMain->quMain->ParamByName("par2")->AsInteger= pointPOL.entype[1];
    dmMain->quMain->ParamByName("par3")->AsInteger= pointPOL.entype[2];
    dmMain->quMain->ParamByName("par4")->AsInteger= pointPOL.entype[3];
    dmMain->quMain->ParamByName("par5")->AsInteger= pointPOL.entype[4];
    dmMain->quMain->ParamByName("par6")->AsInteger= pointPOL.entype[5];
    dmMain->quMain->ParamByName("par7")->AsInteger= pointPOL.mid ;
    dmMain->quMain->ParamByName("par8")->AsString= seldat;
    dmMain->quMain->ParamByName("par101")->AsInteger= ttable;


    dmMain->quMain->Execute();
    int i=0;
    while(!dmMain->quMain->Eof&&i<MAXINPUT){
    if(!dmMain->quMain->FieldByName("mid")->IsNull)
    strcpy(pointLastInput[i].Mid,dmMain->quMain->FieldByName("mid")->AsString.c_str());
    if(!dmMain->quMain->FieldByName("name")->IsNull)
    strcpy(pointLastInput[i].Name,dmMain->quMain->FieldByName("name")->AsString.c_str());
    if(!dmMain->quMain->FieldByName("type")->IsNull)
    strcpy(pointLastInput[i].Type,dmMain->quMain->FieldByName("type")->AsString.c_str());
    if(!dmMain->quMain->FieldByName("Position")->IsNull)
    strcpy(pointLastInput[i].Position,dmMain->quMain->FieldByName("Position")->AsString.c_str());
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
    strcpy(pointLastInput[i].EM,dmMain->quMain->FieldByName("lastind")->AsString.c_str());
    if(!dmMain->quMain->FieldByName("em")->IsNull)
    strcpy(pointLastInput[i].EM_N,dmMain->quMain->FieldByName("em")->AsString.c_str());
    if(!dmMain->quMain->FieldByName("e")->IsNull)
    strcpy(pointLastInput[i].E_N,dmMain->quMain->FieldByName("e")->AsString.c_str());
    dmMain->quMain->Next();
    i++;
    }
    CountStr=i;

//	Получение данных в структуру для вывода данных
    DrawTable1->RowCount=1+CountStr;
    DrawTable1->ColCount=8;
    DrawTable1->RowsHeight="#25#25";
    DrawTable1->ColsWidth="#-190#90#135#90#110#100#100#100";
    DrawTable1->TabStrings->Add("B C40 T25 M0x5 0xF$#$#$#$#$#$#$#$");
    DrawTable1->StaticStrings->Add(Reconst_smes82_2);
    DrawTable1->StaticStrings->Add(Reconst_smes82_3);
    DrawTable1->StaticStrings->Add(Reconst_smes82_4);
    DrawTable1->StaticStrings->Add(Reconst_smes82_5);
    DrawTable1->StaticStrings->Add(Reconst_smes82_6);
    DrawTable1->StaticStrings->Add(Reconst_smes82_7);
    DrawTable1->StaticStrings->Add(Reconst_smes82_8);
    DrawTable1->StaticStrings->Add(Reconst_smes82_9);
    static int VarDescr[]={20};
    DrawTable1->StructStrings->Rebuild(CountStr,1,VarDescr);
    DrawTable1->VarStrings->Clear();
    for(int i=0;i<(int)CountStr;i++){
  		DrawTable1->TabStrings->Add("A0 B- C40 T25 M0x5 0x800F $#A1$#C42 T27 M0x1 0x800E$#$#$#$#T25 E#$");
	  	DrawTable1->StaticStrings->Add(AnsiString("  ")+pointLastInput[i].Name);
	  	DrawTable1->StaticStrings->Add(pointLastInput[i].Type);
      DrawTable1->StaticStrings->Add(pointLastInput[i].Mtrsn);
      DrawTable1->StaticStrings->Add(pointLastInput[i].KC);
      DrawTable1->StaticStrings->Add(pointLastInput[i].Date_time);
      DrawTable1->StaticStrings->Add(pointLastInput[i].EM);
  		DrawTable1->VarStrings->Add(pointLastInput[i].EM_N);
	  	DrawTable1->StaticStrings->Add(pointLastInput[i].E_N);
    }
    if(CountStr)
    {
    	DrawTable1->UpdateTabStrings();
      DrawTable1->FocusCell(6,1);
    }
    else
    {
        Application->MessageBox(Reconst_smes82_10.c_str(),Application->Title.c_str(),MB_OK|MB_ICONINFORMATION);
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
// Проверить
void __fastcall TFormVITInputExcel::vCheck(TObject* Sender)
{
  AnsiString sras,scurr;
  bool conv;
  double proc;
  static double dopproc=30;
  TColor CurrentColor;
  TDrawTable::SAttrCell *pCur,*pRas;
  long redcell,j=-1;

  if(prov||!CountStr)//была проверка или нет записей
    return;

  try{
    Screen->Cursor=crHourGlass;
    prov=2;//Можно сохранять
    for(j=0;j <(long)CountStr ;j++){
      if(!pointLastInput[j].editRecord)
        continue;
      CurrentColor=clWhite;
      pCur=(TDrawTable::SAttrCell *)DrawTable1->GetCellAttr(6,1+j);
      pRas=(TDrawTable::SAttrCell *)DrawTable1->GetCellAttr(7,1+j);
      scurr=SAATrim(pCur->SourceData->Strings[pCur->IndexData]);
      sras=GetRas(pointLastInput[j].EM,scurr,pointLastInput[j].Digits,pointLastInput[j].KC,conv,proc);
      pRas->SourceData->Strings[pRas->IndexData]=sras;
      strcpy(pointLastInput[j].EM_N,scurr.c_str());
      strcpy(pointLastInput[j].E_N,sras.c_str());
      if(proc>=dopproc){
        CurrentColor=clRed;
        if(prov==2){
          prov=1;
          redcell=j;
        }
      }else{
        if(conv)
          CurrentColor=clYellow;
        if(AnsiString(pointLastInput[j].EM).IsEmpty())
          CurrentColor=clLime;
      }
      if(pRas->styleCell==TDrawTable::SAttrCell::cellStatic)
        pRas->BackgroundColor= CurrentColor;
    }
    if(prov==1){
      DrawTable1->FocusCell(5,1+redcell);
      if(DrawTable1->VisibleRowCount<(long)CountStr-1)
        DrawTable1->TopRow=1+redcell;
      MessageBox(Handle,AnsiString(Reconst_smes82_11+
                        IntToStr((long)dopproc)+Reconst_smes82_12).c_str(),
                        Application->Title.c_str(),MB_OK |MB_ICONWARNING);
    }
    Screen->Cursor=crDefault;
  }catch(Exception &exception){
    prov=0;
    Screen->Cursor=crDefault;
    if(j>=0){
      DrawTable1->FocusCell(5,1+j);
      if(DrawTable1->VisibleRowCount<(long)CountStr-1)
        DrawTable1->TopRow=1+j;
    }
  	Application->ShowException(&exception);
  }
  DrawTable1->Invalidate();
  DrawTable1->SetFocus();
}
//---------------------------------------------------------------------------

void __fastcall TFormVITInputExcel::vRefresh(TObject* Sender)
{
   MainProc(this);
   DrawTable1->SetFocus();
}
//---------------------------------------------------------------------------
// Сохранить
void __fastcall TFormVITInputExcel::vSave(TObject* Sender)
{
  long i=-1;
	char seldat[20];
  POINTLASTINPUT pLI;
  static char *insupd = "begin \
                          ryda.indic_pg.setindic(:par12,to_date(:par11, 'dd.mm.yyyy hh24:mi'),:par17,:par101,1,'Р.В',:par14,:par15,:par16,:par1,:par2); \
                         end;";
  if(!EditRec||!CountStr)//нет редактирования или нет записей
    return;
  if(!prov){
    MessageBox(Handle,Reconst_smes82_13.c_str(),
        Application->Title.c_str(),MB_OK|MB_ICONSTOP);
      return;
  }

  try{

    strcpy(seldat,pointPOL.myTime.FormatString("dd.mm.yyyy hh:nn").c_str());
    //GRB ADD 16.04.2020 - test trouble ODAC
    dmMain->quMain->Params->Clear();
    //END ADD 
    dmMain->quMain->SQL->Text=insupd;

    for(i=0; i <(long) CountStr; i++ ){
      if(pointLastInput[i].editRecord){
        pLI=pointLastInput[i];
       dmMain->quMain->ParamByName("par1")->AsString= pLI.EM_N;
        dmMain->quMain->ParamByName("par2")->AsString= pLI.E_N;
        dmMain->quMain->ParamByName("par11")->AsString= seldat;
        dmMain->quMain->ParamByName("par12")->AsString= pLI.Mid;
        dmMain->quMain->ParamByName("par14")->AsString= UsCon.uName;
        dmMain->quMain->ParamByName("par15")->AsString= pLI.Mtrsn;
        dmMain->quMain->ParamByName("par16")->AsString= pLI.KC;
        dmMain->quMain->ParamByName("par17")->AsString= pLI.Entype;
        dmMain->quMain->ParamByName("par101")->AsInteger= ttable;
        dmMain->quMain->Execute();
      }
    }
    i=-1;
    dmMain->orases->Commit();

    EditRec = false;
    prov=0;
    for(long j=0;j <(long)CountStr ;j++){
      if(pointLastInput[j].editRecord)
        pointLastInput[j].editRecord=false;
    }

  }catch(Exception &exception){
      dmMain->orases->Rollback();

    if(i>=0){
      DrawTable1->FocusCell(5,1+i);
      if(DrawTable1->VisibleRowCount<(long)CountStr-1)
        DrawTable1->TopRow=1+i;
    }
  	Application->ShowException(&exception);
  }
  DrawTable1->Invalidate();
  DrawTable1->SetFocus();
}
//---------------------------------------------------------------------------
void __fastcall TFormVITInputExcel::DrawTable1KeyPress(TObject *Sender,
      char &Key)
{
  AnsiString S=(AnsiString)Key;
  AnsiString S1=".0123456789\b\r";
  if(!S1.Pos(S)||(Access==accRead)){
    Key=NULL;
    Beep();
    return;
  }
}
//---------------------------------------------------------------------------

void __fastcall TFormVITInputExcel::SetAccess(TAccess value)
{
   if(FAccess != value) {
      TMainForm::SetAccess(value);
      bool wr = value==accWrite;
      iaCheck->Enabled = wr;
   }
}
//---------------------------------------------------------------------------

void __fastcall TFormVITInputExcel::vFindAgainClick(TObject*)
{
   if(!FindForm) return;

   AnsiString text;
   int inc = (FindForm->rgDirection->ItemIndex==0)?-1:1;
   int findRow = (FindForm->rgOrigin->ItemIndex==0)?
      DrawTable1->Row + inc : FindForm->currPos;

   for(; findRow<DrawTable1->RowCount && findRow>=0; findRow=findRow+inc)
   {
      int ind = findRow-1;
      TFindForm::TMeasure msr;
      if(ind<0 || ind>=(long)CountStr) throw Exception(Reconst_smes82_15);
      msr.text = strcat(pointLastInput[ind].Mid,pointLastInput[ind].Name);
      msr.entype = atoi(pointLastInput[ind].Entype);
      msr.pos = atoi(pointLastInput[ind].Position);
      if(FindForm->Compare(&msr))
      {
         DrawTable1->Row = findRow;
         FindForm->currPos = findRow+inc;
         return;
      }
   }
   MessageBox(this->Handle,
      Reconst_smes82_16.c_str(),
      this->Caption.c_str(), MB_OK|MB_ICONINFORMATION);
}
//---------------------------------------------------------------------------

void __fastcall TFormVITInputExcel::vFindClick(TObject*Sender)
{
   if(!FindForm)
      new TFindForm(this);
   if(FindForm->ShowModal()==mrOk){
      FindForm->currPos = (FindForm->rgOrigin->ItemIndex==0)?
         (DrawTable1->Row + (FindForm->rgDirection->ItemIndex==0 ? -1 : 1)):
         (FindForm->rgDirection->ItemIndex==0 ? DrawTable1->RowCount-1 : 1);
      vFindAgainClick(Sender);
   }
}
//---------------------------------------------------------------------------

