//---------------------------------------------------------------------------
#include <vcl.h>
#include <stdio.h>

#include "unDataMod.h"
#pragma hdrstop
#include "consump.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "DrawTable"
#pragma resource "*.dfm"
//---------------------------------------------------------------------------
__fastcall TfmConsump::TfmConsump(TComponent* Owner, AnsiString Name, long ttable,long rezerv, TAccess a, bool onHlrInput)
	: TMainForm(Owner, Name, a)
{
  this->ttable=ttable;
  switch(ttable){
    case 1:
      tname="BILL";
      break;
    case 2:
      tname="HALFHOUR";
      break;
    case 3:
      tname="PROFILE";
      break;
    case 5:
    case 6:
    case 7:
    case 8:
      tname="BILLORG";
      break;
    default:
      tname="MONTHS";
  }
  pointPOL.myTime=TDateTime::CurrentDate();
}
//---------------------------------------------------------------------------

void __fastcall TfmConsump::FormCreate(TObject *Sender)
{
	vParams(NULL);
}
//---------------------------------------------------------------------------

void __fastcall TfmConsump::DrawTable1SetEditText(TObject *Sender,
	int ACol, int ARow, const AnsiString Value)
{
   if(Access==accRead) return;
     if(ACol!=5)
       return;
     if(!pointLastInput[ARow - 1].editRecord)
       pointLastInput[ARow - 1].editRecord=true;
  if(!EditRec)
    EditRec=true;
}
//---------------------------------------------------------------------------
void __fastcall TfmConsump::DrawTable1DrawCell(TObject *Sender,
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
void __fastcall TfmConsump::DrawTable1KeyDown(TObject *Sender,
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
        ARow=1;
        PostMessage(Handle,WM_SELECTCELL,(WPARAM)ACol,(LPARAM)ARow);
      }
      break;
    }
}
//---------------------------------------------------------------------------
void __fastcall TfmConsump::WMSelectCell(TMessage & Message)
{
  DrawTable1->Col=Message.WParam;
  DrawTable1->Row=Message.LParam;
  if(Message.LParam==1)
    DrawTable1->TopRow=1;
  if(Message.LParam==DrawTable1->RowCount-1)
    DrawTable1->TopRow=Message.LParam-DrawTable1->VisibleRowCount+1;
}
//---------------------------------------------------------------------------

void __fastcall TfmConsump::vParams(TObject* Sender)
{
   TfmSelectPoint *f=NULL;
   try{
      if(EditRec)
      switch(MessageBox(Handle, Reconst_smes91_1.c_str(), Application->Title.c_str(),MB_YESNOCANCEL|MB_ICONQUESTION))
      {
      case IDYES:
         vSave(Sender);
         if(EditRec) return;
         break;
      case IDCANCEL:
         return;
      }
      f= new TfmSelectPoint(this,&pointPOL);
      f->HelpContext=25034;
      if((f->ShowModal() == mrOk)&&f->tvMain->Selected){
//         DrawTable1->FixedRows = 1;
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

void __fastcall TfmConsump::vRefresh(TObject* Sender)
{
  MainProc(this);
  DrawTable1->SetFocus();
}
//---------------------------------------------------------------------------

void TfmConsump::MainProc(TObject *Sender)
{

	char seldat[20];

    AnsiString sql = "select f.mid, pa.name||'/'||p.name name, ryda.indic_pg.measurename(mn.nmeasure,decode(f.q1234,'*',1,0)) type, \
                        mn.nmeasure, m.mtrsn, nvl(f.kc,1)KC, \
                        to_char(ryda.indic_pg.getlastdate(f.mid,to_date(:par8, 'dd.mm.yyyy hh24:mi'),mn.nmeasure,NULL,:par101,2),'dd.mm.yyyy hh24:mi') lastd, \
                        ryda.indic_pg.getlastdebit(f.mid,to_date(:par8, 'dd.mm.yyyy hh24:mi'),mn.nmeasure,NULL,:par101) lastdeb, \
                        decode(mn.nmeasure,1,b.er,2,b.ed,3,b.q1,4,b.q2,5,b.q3,6,b.q4) e \
                      from (select rownum nmeasure from dict where rownum<=6) mn,ryda."+tname+" b,ryda.meters m,ryda.feeders f,ryda.points p,ryda.points pa \
                      where mn.nmeasure in (:par1, :par2, :par3, :par4, :par5, :par6) \
                        and f.mid in (select mid from ryda.groups start with gid = :par7 connect by prior gid = parent) \
                        and f.mid=b.mid(+) and b.date_time(+)=to_date(:par8, 'dd.mm.yyyy hh24:mi') and f.mid=m.mid(+) \
                        and ryda.indic_pg.is_availability(mn.nmeasure,decode(f.q1234,'*',1,0),f.er_position,f.ed_position,f.q1_position,f.q3_position)=1 \
                        and mn.nmeasure=decode(m.entype,7,mn.nmeasure,m.entype)\
                        and f.mid=p.mid(+) and p.parent=pa.mid(+)\
                      order by m.position, pa.name,p.name,mn.nmeasure";
  try{

    Caption=TaskName+Reconst_smes81_2+pointPOL.myTime.FormatString("dd.mm.yyyy hh:nn");
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
    dmMain->quMain->ParamByName("par7")->AsInteger=pointPOL.gid;
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

    // Получение данных в структуру для вывода данных
    // DrawTable1->FixedRows=1;
    DrawTable1->RowCount=1+CountStr;
    DrawTable1->ColCount=6;
  	DrawTable1->ColsWidth="#-220#60#135#140#150#150";
    DrawTable1->TabStrings->Add("B C40 T25 M0x5 0xF$#$#$#$#$#$");
    DrawTable1->StaticStrings->Add(Reconst_smes91_2);
    DrawTable1->StaticStrings->Add(Reconst_smes91_3);
    DrawTable1->StaticStrings->Add(Reconst_smes91_4);
    DrawTable1->StaticStrings->Add(Reconst_smes91_5);
    DrawTable1->StaticStrings->Add(Reconst_smes91_6);
    DrawTable1->StaticStrings->Add(Reconst_smes91_7);
    static int VarDescr[]={20};
    DrawTable1->StructStrings->Rebuild(CountStr,1,VarDescr);
    DrawTable1->VarStrings->Clear();
    for(int i=0;i<(int)CountStr;i++){
    	DrawTable1->TabStrings->Add("B- A0 C40 T25 M0x5 0x800F$#A1 $#C42 T27 M0x1 0x800E $#$#$#M0x1 0x800E T25 E");
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
// Сохранить
void __fastcall TfmConsump::vSave(TObject* Sender)
{
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
void __fastcall TfmConsump::DrawTable1KeyPress(
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

inline void __fastcall TfmConsump::SetAccess(TAccess value)
{
   if(FAccess != value)
      TMainForm::SetAccess(value);
}
//---------------------------------------------------------------------------

