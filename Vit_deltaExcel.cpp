//---------------------------------------------------------------------------
#include <vcl.h>
#include <stdio.h>
#pragma hdrstop

#include "unDataMod.h"
#include "Vit_deltaExcel.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "DrawTable"
#pragma resource "*.dfm"
//---------------------------------------------------------------------------
__fastcall TFormVITInputDeltaExcel::TFormVITInputDeltaExcel(TComponent* Owner, AnsiString Name, long ttable,long rezerv, TAccess a, bool onHlrInput)
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
      break;
   case 3:
      tname="PROFILE";
      pointPOL.usetime=true;
      break;
   case 5:
   case 6:
   case 7:
   case 8:
   case 9:
      tname="BILLORG";
      break;
   default:
      tname="MONTHS";
   }
   pointPOL.myTime=TDateTime::CurrentDate();
   onHalfHourInput = onHlrInput;
}
//---------------------------------------------------------------------------

void __fastcall TFormVITInputDeltaExcel::FormCreate(TObject *Sender)
{
	vParams(NULL);
}
//---------------------------------------------------------------------------
void __fastcall TFormVITInputDeltaExcel::DrawTable1SetEditText(TObject *Sender,
	int ACol, int ARow, const AnsiString Value)
{
   if(Access==accRead) return; 
  if(pointPOL.usestep){
     if(!pointHalfHurValues[ACol-1][ARow-4].editRecord)
       pointHalfHurValues[ACol-1][ARow-4].editRecord = true;
  }else{
     if(ACol!=5)
       return;
     if(!pointLastInput[ARow - 1].editRecord)
       pointLastInput[ARow - 1].editRecord=true;
  }
  if(!EditRec)
    EditRec=true;
}
//---------------------------------------------------------------------------
void __fastcall TFormVITInputDeltaExcel::DrawTable1DrawCell(TObject *Sender,
	int Col, int Row, TRect &Rect, TGridDrawState State)
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
void __fastcall TFormVITInputDeltaExcel::DrawTable1KeyDown(TObject *Sender,
	WORD &Key, TShiftState Shift)
{
	long ACol,ARow;
  if( DrawTable1->EditorMode)
    return;
  if(CountStr==0)
    return;
  ACol=DrawTable1->Col;
	switch(Key){
    case 38: // VK_UP:
      if(DrawTable1->Row != DrawTable1->FixedRows)
        ARow=DrawTable1->Row-1;
      else{
        ARow=DrawTable1->RowCount-1;
        PostMessage(Handle,WM_SELECTCELL,(WPARAM)ACol,(LPARAM)ARow);
      }
      break;
    case 40: // VK_DOWN:
      if( DrawTable1->Row != DrawTable1->RowCount-1 )
        ARow=DrawTable1->Row+1;
      else{
        ARow=pointPOL.usestep?4:1;
        PostMessage(Handle,WM_SELECTCELL,(WPARAM)ACol,(LPARAM)ARow);
      }
      break;
    }
}
//---------------------------------------------------------------------------
void __fastcall TFormVITInputDeltaExcel::WMSelectCell(TMessage & Message)
{
  DrawTable1->Col=Message.WParam;
  DrawTable1->Row=Message.LParam;
  if(Message.LParam==1)
    DrawTable1->TopRow=1;
  if(Message.LParam==DrawTable1->RowCount-1)
    DrawTable1->TopRow=Message.LParam-DrawTable1->VisibleRowCount+1;
}
//---------------------------------------------------------------------------

void __fastcall TFormVITInputDeltaExcel::vParams(TObject* Sender)
{
   TFormVVMeter *f=NULL;
   try{
      if(EditRec)
      switch(MessageBox(Handle, Reconst_smes80_1.c_str(), Application->Title.c_str(),MB_YESNOCANCEL|MB_ICONQUESTION))
      {
      case IDYES:
         vSave(Sender);
         if(EditRec) return;
         break;
      case IDCANCEL:
         return;
      }
      bool oldUse = pointPOL.usestep;
      if(onHalfHourInput)
         pointPOL.usestep = true;
      f= new TFormVVMeter(this,&pointPOL);
      if((f->ShowModal() == mrOk)&&f->tvMain->Selected){
         if(onHalfHourInput&&pointPOL.usestep){
            DrawTable1->RowCount = 5;
            DrawTable1->FixedRows = 4;
            newMainProc(Sender, f->tvMain->Selected->Text);
         }else{
            DrawTable1->FixedRows = 1;
            MainProc(Sender);
         }
      }else{
         pointPOL.usestep = oldUse;
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

void __fastcall TFormVITInputDeltaExcel::vRefresh(TObject* Sender)
{
   if(pointPOL.usestep)
      newMainProc(this);
   else
      MainProc(this);
  DrawTable1->SetFocus();
}
//---------------------------------------------------------------------------
void TFormVITInputDeltaExcel::MainProc(TObject *Sender)
{
	char seldat[20];
   // int state;
    AnsiString sql  =(pointPOL.ifpoint)? "select f.mid, f.vcode||decode(f.vcode,NULL,'','  /')||pa.name||'/'||p.name name, ryda.indic_pg.measurename(mn.nmeasure,decode(f.q1234,'*',1,0)) type, \
                        mn.nmeasure, m.mtrsn, nvl(f.kc,1)KC, \
                        to_char(ryda.indic_pg.getlastdate(f.mid,to_date(:par8, 'dd.mm.yyyy hh24:mi'),mn.nmeasure,NULL,:par101,2),'dd.mm.yyyy hh24:mi') lastd, \
                        ryda.indic_pg.getlastdebit(f.mid,to_date(:par8, 'dd.mm.yyyy hh24:mi'),mn.nmeasure,NULL,:par101) lastdeb, \
                        decode(mn.nmeasure,1,b.er,2,b.ed,3,b.q1,4,b.q2,5,b.q3,6,b.q4) e \
                      from (select rownum nmeasure from dict where rownum<=6) mn,(select mid,date_time,er,ed,q1,q2,q3,q4 from ryda."+tname+" where date_time=to_date(:par8, 'dd.mm.yyyy hh24:mi')) b,ryda.meters m,ryda.feeders f,ryda.points p,ryda.points pa \
                      where mn.nmeasure in (:par1, :par2, :par3, :par4, :par5, :par6) \
                        and f.mid in (select mid from ryda.points where ind = 3 start with mid = :par7 connect by prior mid = parent) \
                        and f.mid=b.mid(+) and f.mid=m.mid(+) \
                        and ryda.indic_pg.is_availability(mn.nmeasure,decode(f.q1234,'*',1,0),f.er_position,f.ed_position,f.q1_position,f.q3_position)=1 \
                        and mn.nmeasure=decode(m.entype,7,mn.nmeasure,m.entype)\
                        and f.mid=p.mid(+) and p.parent=pa.mid(+)\
                      order by m.position, pa.name,p.name,mn.nmeasure":

                       "select \
                        distinct  \
                        f.mid, f.vcode||decode(f.vcode,NULL,'','  /')||pa.name||'/'||p.name name, ryda.indic_pg.measurename(mn.nmeasure,decode(f.q1234,'*',1,0)) type, \
                        mn.nmeasure, m.mtrsn, nvl(f.kc,1)KC, \
                        to_char(ryda.indic_pg.getlastdate(f.mid,to_date(:par8, 'dd.mm.yyyy hh24:mi'),mn.nmeasure,NULL,:par101,2),'dd.mm.yyyy hh24:mi') lastd, \
                        ryda.indic_pg.getlastdebit(f.mid,to_date(:par8, 'dd.mm.yyyy hh24:mi'),mn.nmeasure,NULL,:par101) lastdeb, \
                        decode(mn.nmeasure,1,b.er,2,b.ed,3,b.q1,4,b.q2,5,b.q3,6,b.q4) e \
                      from (select rownum nmeasure from dict where rownum<=6) mn,(select mid,date_time,er,ed,q1,q2,q3,q4 from ryda."+tname+" where date_time=to_date(:par8, 'dd.mm.yyyy hh24:mi')) b,ryda.meters m,ryda.feeders f,ryda.points p,ryda.points pa \
                      where mn.nmeasure in (:par1, :par2, :par3, :par4, :par5, :par6) \
                        and f.mid in (select mid from ryda.groups where mid is not null start with gid = :par7 connect by prior gid = parent) \
                        and f.mid=b.mid(+) and f.mid=m.mid(+) \
                        and ryda.indic_pg.is_availability(mn.nmeasure,decode(f.q1234,'*',1,0),f.er_position,f.ed_position,f.q1_position,f.q3_position)=1 \
                        and mn.nmeasure=decode(m.entype,7,mn.nmeasure,m.entype)\
                        and f.mid=p.mid(+) and p.parent=pa.mid(+) \
                        order by  2,mn.nmeasure";

  try{

    Caption=TaskName+Reconst_smes80_2+pointPOL.myTime.FormatString("dd.mm.yyyy hh:nn");
    CountStr=0;
    EditRec=false;
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
    dmMain->quMain->ParamByName("par101")->AsInteger=ttable;

    dmMain->quMain->Execute();
    int i=0;
    while(!dmMain->quMain->Eof&&i<MAXINPUT){
    if(!dmMain->quMain->FieldByName("mid")->IsNull)
      strcpy(pointLastInput[i].Mid,dmMain->quMain->FieldByName("mid")->AsString.c_str());
    if(!dmMain->quMain->FieldByName("name")->IsNull)
      strcpy(pointLastInput[i].Name,dmMain->quMain->FieldByName("name")->AsString.c_str());
    if(!dmMain->quMain->FieldByName("type")->IsNull)
      strcpy(pointLastInput[i].Type,dmMain->quMain->FieldByName("type")->AsString.c_str());
    if(!dmMain->quMain->FieldByName("nmeasure")->IsNull)
      strcpy(pointLastInput[i].Entype,dmMain->quMain->FieldByName("nmeasure")->AsString.c_str());
    if(!dmMain->quMain->FieldByName("mtrsn")->IsNull)
      strcpy(pointLastInput[i].Mtrsn,dmMain->quMain->FieldByName("mtrsn")->AsString.c_str());
    if(!dmMain->quMain->FieldByName("KC")->IsNull)
      strcpy(pointLastInput[i].KC,dmMain->quMain->FieldByName("KC")->AsString.c_str());
    if(!dmMain->quMain->FieldByName("lastd")->IsNull)
      strcpy(pointLastInput[i].Date_time,dmMain->quMain->FieldByName("lastd")->AsString.c_str());
    if(!dmMain->quMain->FieldByName("lastdeb")->IsNull)
      strcpy(pointLastInput[i].E,dmMain->quMain->FieldByName("lastdeb")->AsString.c_str());
    if(!dmMain->quMain->FieldByName("e")->IsNull)
      strcpy(pointLastInput[i].E_N,dmMain->quMain->FieldByName("e")->AsString.c_str());
    dmMain->quMain->Next();
    i++;
    }
     CountStr=i;

    //	Получение данных в структуру для вывода данных
    DrawTable1->FixedRows=1;
    DrawTable1->RowCount=1+CountStr;
    DrawTable1->ColCount=6;
  	DrawTable1->ColsWidth="#-250#80#135#125#130#130#150";
    DrawTable1->TabStrings->Add("B C40 T25 M0x5 0xF$#$#$#$#$#$");
    DrawTable1->StaticStrings->Add(Reconst_smes80_3);
    DrawTable1->StaticStrings->Add(Reconst_smes80_4);
    DrawTable1->StaticStrings->Add(Reconst_smes80_5);
    DrawTable1->StaticStrings->Add(Reconst_smes80_6);
    DrawTable1->StaticStrings->Add(Reconst_smes80_7);
    DrawTable1->StaticStrings->Add(Reconst_smes80_8);
    static int VarDescr[]={20};
    DrawTable1->StructStrings->Rebuild(CountStr,1,VarDescr);
    DrawTable1->VarStrings->Clear();
    for(int i=0;i<(int)CountStr;i++){
    	DrawTable1->TabStrings->Add("A0 B- C40 T25 M0x5 0x800F$#A1$#C42 T27 M0x1 0x800E $#$#$#M0x1 0x800E T25 E");
    	DrawTable1->StaticStrings->Add(AnsiString("  ")+pointLastInput[i].Name);
    	DrawTable1->StaticStrings->Add(pointLastInput[i].Type);
        DrawTable1->StaticStrings->Add(pointLastInput[i].Mtrsn);
        DrawTable1->StaticStrings->Add(pointLastInput[i].Date_time);
        DrawTable1->StaticStrings->Add(pointLastInput[i].E);
        DrawTable1->VarStrings->Add(pointLastInput[i].E_N);
    }
    if(CountStr){
    	DrawTable1->UpdateTabStrings();
        DrawTable1->FocusCell(5,1);
    }
    else
    {
        Application->MessageBox(Reconst_smes80_9.c_str(),Application->Title.c_str(),MB_OK|MB_ICONINFORMATION);
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
void __fastcall TFormVITInputDeltaExcel::vSave(TObject* Sender)
{  // Сохранить
   if(pointPOL.usestep){
      newSave(Sender);
      return;
   }
  long i=-1;
	char seldat[20];
  POINTLASTINPUT pLI;
  AnsiString scurr;
  TDrawTable::SAttrCell *pCur;
  static char *insupd = "begin \
                          ryda.indic_pg.setdebit(:par12,to_date(:par11, 'dd.mm.yyyy hh24:mi'),:par17,:par101,'Р.В',:par14,:par15,:par16,:par2); \
                         end;";
  if(!EditRec||!CountStr)//нет редактирования или нет записей
    return;

  try{

    for(i=0;i <(long)CountStr ;i++){
      if(!pointLastInput[i].editRecord)
        continue;
      pCur=(TDrawTable::SAttrCell *)DrawTable1->GetCellAttr(5,1+i);
      scurr=SAATrim(pCur->SourceData->Strings[pCur->IndexData]);
      if(!scurr.IsEmpty())
        scurr.ToDouble();
      strcpy(pointLastInput[i].E_N, scurr.c_str());
    }

    strcpy(seldat,pointPOL.myTime.FormatString("dd.mm.yyyy hh:nn").c_str());
    //GRB ADD 16.04.2020 - test trouble ODAC
    dmMain->quMain->Params->Clear();
    //END ADD     
    dmMain->quMain->SQL->Text=insupd;

    for(i=0; i <(long) CountStr; i++){
      if(pointLastInput[i].editRecord){
        pLI=pointLastInput[i];
        dmMain->quMain->ParamByName("par2")->AsString=pLI.E_N;
        dmMain->quMain->ParamByName("par11")->AsString=seldat;
        dmMain->quMain->ParamByName("par12")->AsString=pLI.Mid;
        dmMain->quMain->ParamByName("par14")->AsString=UsCon.uName;
        dmMain->quMain->ParamByName("par15")->AsString=pLI.Mtrsn;
        dmMain->quMain->ParamByName("par16")->AsString=pLI.KC;
        dmMain->quMain->ParamByName("par17")->AsString=pLI.Entype;
        dmMain->quMain->ParamByName("par101")->AsInteger=ttable;
        dmMain->quMain->Execute();

      }
    }
    i=-1;
    dmMain->orases->Commit();

    EditRec=false;
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
void __fastcall TFormVITInputDeltaExcel::DrawTable1KeyPress(
      TObject *Sender, char &Key)
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

void __fastcall TFormVITInputDeltaExcel::newMainProc(TObject*Sender, AnsiString pName)
{
   char seldat[20];
  // int state;
   try{
      if(pName!=NULL)
         Caption=Reconst_smes80_10+pName+Reconst_smes80_11+
            pointPOL.myTime.FormatString("dd mmm yyyy")+Reconst_smes80_12+
            pointPOL.myTime.FormatString("hh:nn");

      CountStr=0;
      RCount = ((int)pointPOL.myTime.Val+1-pointPOL.myTime.Val)/pointPOL.myStep.Val;
      EditRec=false;
      ZeroMemory(pointLastInput, sizeof(pointLastInput));
      ZeroMemory(pointHalfHurValues, sizeof(pointHalfHurValues));
      DrawTable1->StaticStrings->Clear();
      DrawTable1->TabStrings->Clear();

      AnsiString select =
        "select f.mid, ryda.indic_pg.measurename(mn.nmeasure,decode(f.q1234,'*',1,0)) name, \
            decode(mn.nmeasure,1,f.er_position,2,f.ed_position,3,f.q1_position,5,f.q3_position)Position, mn.nmeasure, m.mtrsn, nvl(f.kc,1) KC, \
            to_char(ryda.indic_pg.getlastdate(f.mid,to_date(:par8, 'dd.mm.yyyy hh24:mi'),mn.nmeasure,NULL,:par101,2),'dd.mm.yyyy hh24:mi') lastd, \
            ryda.indic_pg.getlastdebit(f.mid,to_date(:par8, 'dd.mm.yyyy hh24:mi'),mn.nmeasure,NULL,:par101) lastdeb";
      TDateTime d = pointPOL.myTime.Val+pointPOL.myStep.Val;
      AnsiString HHS="";
      for(int i=0; i<(int)RCount; i++){
         HHS="HHV"+IntToStr(i);
         select += ", ryda.indic_pg.getdebit(f.mid,to_date('"+d.FormatString("dd.mm.yyyy hh:nn")+"', 'dd.mm.yyyy hh24:mi'),mn.nmeasure,NULL,:par101)"+HHS;
         d.Val += pointPOL.myStep.Val;
      }
      if(pointPOL.ifpoint){
        select +=
        " from (select rownum nmeasure from dict where rownum<=6) mn,ryda.meters m,ryda.feeders f \
         where mn.nmeasure in (:par1, :par2, :par3, :par4, :par5, :par6) \
            and f.mid in (select mid from ryda.points where ind = 3 start with mid = :par7 connect by prior mid = parent) \
            and f.mid=m.mid(+) and ryda.indic_pg.is_availability(mn.nmeasure,decode(f.q1234,'*',1,0),f.er_position,f.ed_position,f.q1_position,f.q3_position)=1 \
            and mn.nmeasure=decode(m.entype,7,mn.nmeasure,m.entype)\
         order by mn.nmeasure";
      }else{
        select +=
        " from (select rownum nmeasure from dict where rownum<=6) mn,ryda.meters m,ryda.feeders f \
         where mn.nmeasure in (:par1, :par2, :par3, :par4, :par5, :par6) \
            and f.mid in (select mid from ryda.groups where mid is not null start with gid = :par7 connect by prior gid = parent) \
            and f.mid=m.mid(+) and ryda.indic_pg.is_availability(mn.nmeasure,decode(f.q1234,'*',1,0),f.er_position,f.ed_position,f.q1_position,f.q3_position)=1 \
            and mn.nmeasure=decode(m.entype,7,mn.nmeasure,m.entype)\
         order by mn.nmeasure";
      }
      //GRB ADD 16.04.2020 - test trouble ODAC
      dmMain->quMain->Params->Clear();
      //END ADD 
      dmMain->quMain->SQL->Text=select;
      strcpy(seldat, pointPOL.myTime.FormatString("dd.mm.yyyy hh:nn").c_str());
      seldat[15] = '1';
     dmMain->quMain->ParamByName("par1")->AsInteger=pointPOL.entype[0];
     dmMain->quMain->ParamByName("par2")->AsInteger=pointPOL.entype[1];
     dmMain->quMain->ParamByName("par3")->AsInteger=pointPOL.entype[2];
     dmMain->quMain->ParamByName("par4")->AsInteger=pointPOL.entype[3];
     dmMain->quMain->ParamByName("par5")->AsInteger=pointPOL.entype[4];
     dmMain->quMain->ParamByName("par6")->AsInteger=pointPOL.entype[5];
     dmMain->quMain->ParamByName("par7")->AsInteger=pointPOL.mid;
     dmMain->quMain->ParamByName("par8")->AsString=seldat;
     dmMain->quMain->ParamByName("par101")->AsInteger=ttable;
     dmMain->quMain->Execute();
     int i=0;
     while(!dmMain->quMain->Eof&&i<MAXINPUT){
     if(!dmMain->quMain->FieldByName("mid")->IsNull)
     strcpy(pointLastInput[i].Mid,dmMain->quMain->FieldByName("mid")->AsString.c_str());
     if(!dmMain->quMain->FieldByName("name")->IsNull)
     strcpy(pointLastInput[i].Name,dmMain->quMain->FieldByName("name")->AsString.c_str());
     if(!dmMain->quMain->FieldByName("Position")->IsNull)
     strcpy(pointLastInput[i].Position,dmMain->quMain->FieldByName("Position")->AsString.c_str());
     if(!dmMain->quMain->FieldByName("nmeasure")->IsNull)
     strcpy(pointLastInput[i].Entype,dmMain->quMain->FieldByName("nmeasure")->AsString.c_str());
     if(!dmMain->quMain->FieldByName("mtrsn")->IsNull)
     strcpy(pointLastInput[i].Mtrsn,dmMain->quMain->FieldByName("mtrsn")->AsString.c_str());
     if(!dmMain->quMain->FieldByName("KC")->IsNull)
     strcpy(pointLastInput[i].KC,dmMain->quMain->FieldByName("KC")->AsString.c_str());
     if(!dmMain->quMain->FieldByName("lastd")->IsNull)
     strcpy(pointLastInput[i].Date_time,dmMain->quMain->FieldByName("lastd")->AsString.c_str());
     if(!dmMain->quMain->FieldByName("lastdeb")->IsNull)
     strcpy(pointLastInput[i].E,dmMain->quMain->FieldByName("lastdeb")->AsString.c_str());
     AnsiString HHV="";
      for(int j=0; j<(int)RCount; j++){
         HHV="HHV"+IntToStr(j);
         if(!dmMain->quMain->FieldByName(HHV)->IsNull)
         pointHalfHurValues[i][j].Val=dmMain->quMain->FieldByName(HHV)->AsFloat;}
      dmMain->quMain->Next();
      i++;
     }
     CountStr=i;
    //	Получение данных в структуру для вывода данных
      DrawTable1->RowCount=4+RCount;
      DrawTable1->ColCount=1+CountStr;
      AnsiString strs = "#120";
      for(int i=0; i<(int)CountStr; i++,strs += "#-100");
      DrawTable1->ColsWidth = strs;
      strs = "B C40 T25 M0x5 0xF $ ";
      for(int i=0;i<(int)CountStr;i++) strs += " #M0x1 0xF $ ";
      DrawTable1->TabStrings->Add(strs);
      DrawTable1->StaticStrings->Add(Reconst_smes80_17);
      for(int i=0; i<(int)CountStr; i++)
         DrawTable1->StaticStrings->Add(pointLastInput[i].Name);
      strs = "B- M0x5 0xF $ ";
      for(int i=0;i<(int)CountStr;i++) strs += "#M0x5 0x800F $ ";
      DrawTable1->TabStrings->Add(strs);
      DrawTable1->StaticStrings->Add(Reconst_smes80_13);
      for(int i=0;i<(int)CountStr;i++)
         DrawTable1->StaticStrings->Add(pointLastInput[i].Mtrsn);
      DrawTable1->TabStrings->Add(strs);
      DrawTable1->StaticStrings->Add(Reconst_smes80_14);
      for(int i=0;i<(int)CountStr;i++)
         DrawTable1->StaticStrings->Add(pointLastInput[i].Date_time);
      DrawTable1->TabStrings->Add(strs);
      DrawTable1->StaticStrings->Add(Reconst_smes80_15);
      for(int i=0;i<(int)CountStr;i++)
         DrawTable1->StaticStrings->Add(pointLastInput[i].E);

      static int VarDescr[6] = {20,20,20,20,20,20};
      DrawTable1->StructStrings->Rebuild(RCount, CountStr, VarDescr);
      DrawTable1->VarStrings->Clear();
      strs = "B- C40 T25 M0x5 0xF $ ";
      for(int i=0; i<(int)CountStr; i++, strs += "# C42 M0x1 0x800E E ");
      d = pointPOL.myTime.Val+pointPOL.myStep.Val;
      for(int i=0; i<(int)RCount; i++){
         DrawTable1->TabStrings->Add(strs);
         if(i < (int)RCount-1)
            DrawTable1->StaticStrings->Add(d.TimeString());
         else
            DrawTable1->StaticStrings->Add("24:00:00");
         d.Val += pointPOL.myStep.Val;
         for(int j=0; j<(int)CountStr; j++)
            DrawTable1->VarStrings->Add(FloatToStr(pointHalfHurValues[j][i].Val));
      }
      if(CountStr){
         DrawTable1->UpdateTabStrings();
         DrawTable1->FocusCell(1,4);
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

void __fastcall TFormVITInputDeltaExcel::newSave(TObject*)
{
   if(!EditRec||!CountStr)//нет редактирования или нет записей
   return;

   long i = -1, j = -1;
   POINTLASTINPUT pLI;
   char currdate[20];
   char Val_N[20];
   AnsiString scurr;
   TDrawTable::SAttrCell *pCur;
   static char *insupd="begin \
                           ryda.indic_pg.setdebit(:par12,to_date(:par11, 'dd.mm.yyyy hh24:mi'),:par17,:par101,'Р.В',:par14,:par15,:par16,:par2); \
                        end;";
   try{


      for(i=0; i<(long)CountStr ;i++)
      for(j=0; j<(long)RCount ;j++){
         if(!pointHalfHurValues[i][j].editRecord)
            continue;
         int fc = DrawTable1->FixedCols, fr = DrawTable1->FixedRows;
         pCur=(TDrawTable::SAttrCell *)DrawTable1->GetCellAttr(fc+i,fr+j);
         scurr=SAATrim(pCur->SourceData->Strings[pCur->IndexData]);
         if(!scurr.IsEmpty())
            pointHalfHurValues[i][j].Val_N = scurr.ToDouble();
      }
      //GRB ADD 16.04.2020 - test trouble ODAC
      dmMain->quMain->Params->Clear();
      //END ADD 
      dmMain->quMain->SQL->Text=insupd;

      for(i=0; i<(long)CountStr ;i++){
         TDateTime d = TDateTime(pointPOL.myTime.Val + pointPOL.myStep.Val);
         for(j=0; j<(long)RCount ;j++, d.Val += pointPOL.myStep.Val){
            if(pointHalfHurValues[i][j].editRecord){
               pLI=pointLastInput[i];
               strcpy(currdate, d.FormatString("dd.mm.yyyy hh:nn").c_str());
               strcpy(Val_N, FloatToStr(pointHalfHurValues[i][j].Val_N).c_str());
               dmMain->quMain->ParamByName("par2")->AsString=Val_N;
               dmMain->quMain->ParamByName("par11")->AsString=currdate;
               dmMain->quMain->ParamByName("par12")->AsString=pLI.Mid;
               dmMain->quMain->ParamByName("par14")->AsString=UsCon.uName;
               dmMain->quMain->ParamByName("par15")->AsString=pLI.Mtrsn;
               dmMain->quMain->ParamByName("par16")->AsString=pLI.KC;
               dmMain->quMain->ParamByName("par17")->AsString=pLI.Entype;
               dmMain->quMain->ParamByName("par101")->AsInteger=ttable;
               dmMain->quMain->Execute();

            }
         }
      }
      i = j = -1;
      dmMain->orases->Commit();

      EditRec = false;
      for(i=0; i<(long)CountStr ;i++)
      for(j=0; j<(long)RCount ;j++){
         if(pointHalfHurValues[i][j].editRecord)
            pointHalfHurValues[i][j].editRecord = false;
      }

   }catch(Exception &exception){
      dmMain->orases->Rollback();
      if((i>=0)&&(j>=0)){
         DrawTable1->FocusCell(1+i,4+j);
         if(DrawTable1->VisibleRowCount<(long)CountStr-1)
            DrawTable1->TopRow=1+i;
      }
      Application->ShowException(&exception);
   }
   DrawTable1->Invalidate();
   DrawTable1->SetFocus();
}
//---------------------------------------------------------------------------

void __fastcall TFormVITInputDeltaExcel::SetAccess(TAccess value)
{
   if(FAccess != value)
      TMainForm::SetAccess(value);
}
//---------------------------------------------------------------------------

void __fastcall TFormVITInputDeltaExcel::vFindAgainClick(TObject*)
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
      if(ind<0 || ind>=(long)CountStr)
         break;
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
      Reconst_smes80_16.c_str(),
      this->Caption.c_str(), MB_OK|MB_ICONINFORMATION);
}
//---------------------------------------------------------------------------

void __fastcall TFormVITInputDeltaExcel::vFindClick(TObject*Sender)
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

