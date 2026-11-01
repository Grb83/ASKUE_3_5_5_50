//---------------------------------------------------------------------------
#include <vcl.h>
#include <stdio.h>
#include <Math.hpp>
#pragma hdrstop
#include "unDataMod.h"
#include "Vit_input.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "DrawTable"
#pragma resource "*.dfm"
//---------------------------------------------------------------------------
__fastcall TFormVITInput::TFormVITInput(TComponent* Owner, AnsiString Name, TAccess a)
	: TMainForm(Owner, Name, a)
{
   pointPOL.myTime=TDateTime::CurrentDate();
}
//---------------------------------------------------------------------------
void __fastcall TFormVITInput::FormCreate(TObject *Sender)
{
	vParams(NULL);
}

//---------------------------------------------------------------------------
void __fastcall TFormVITInput::DrawTable1SetEditText(TObject *Sender, int ACol,
	int ARow, const AnsiString Value)
{
  if(ACol<4||ACol>7||ARow<2)
    return;
  if(!pointLastInput[ARow/2 - 1].editRecord)
    pointLastInput[ARow/2 - 1].editRecord=true;
  if(!EditRec)
    EditRec=true;
  if(prov)
    prov=0;
}
//---------------------------------------------------------------------------
void __fastcall TFormVITInput::DrawTable1GetEditMask(TObject *Sender, int ACol,
	int ARow, AnsiString &Value)
{
//      AnsiString strTr=AnsiString(pointLastInput[ARow/2 - 1].Digits);
//      if(strTr.Length()>0)
//           Value="!" + strTr + ";1;_";
}
//---------------------------------------------------------------------------
void __fastcall TFormVITInput::DrawTable1DrawCell(TObject *Sender, int Col, int Row, TRect &Rect,
	TGridDrawState State)
{
	 	if( State.Contains(gdSelected)&& DrawTable1->Focused())
    {
    	DrawTable1->Canvas->Brush->Color=clBtnFace;
    	DrawTable1->Canvas->FillRect(Rect);
    }else if( State.Contains(gdSelected)){
            DrawTable1->Canvas->Brush->Color=clBtnFace;
      	    DrawTable1->Canvas->FillRect(Rect);
          }
}
//---------------------------------------------------------------------------
void __fastcall TFormVITInput::DrawTable1KeyDown(TObject *Sender, WORD &Key,
	TShiftState Shift)
{
	long ACol,ARow;
  if( DrawTable1->EditorMode||!CountStr)

  ACol=DrawTable1->Col;
  switch(Key)
  {
        case VK_LEFT: // VK_LEFT:
                      if( DrawTable1->Col==4 )
                      {
                          ACol=7;		// 7-в случае ввода по тарифу D
                          if(DrawTable1->Row != 2)
                               ARow=DrawTable1->Row-2;
                          else
                               ARow=DrawTable1->RowCount-1;
                          PostMessage(Handle,WM_SELECTCELL,(WPARAM)ACol,(LPARAM)ARow);
                      }
                      break;
        case VK_UP: // VK_UP:
                      if( DrawTable1->Row-2 >= 0 )
                      {
                          if(DrawTable1->Col!=9)
                               DrawTable1->Row-=2;
                          else
                               DrawTable1->Row-=1;
                      }
                      break;
        case VK_RIGHT: // VK_RIGHT:
                      if( DrawTable1->Col==7 )
                      {// 8-в случае ввода по тарифу D
                          ACol=4;
                          if(DrawTable1->Row != DrawTable1->RowCount-1)
                               ARow=DrawTable1->Row+2;
                          else
                               ARow=2;
                          PostMessage(Handle,WM_SELECTCELL,(WPARAM)ACol,(LPARAM)ARow);
                      }
                      break;
        case VK_DOWN: // VK_DOWN:
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
void __fastcall TFormVITInput::WMSelectCell(TMessage & Message)
{
        DrawTable1->Col=Message.WParam;
        DrawTable1->Row=Message.LParam;
        if(Message.LParam==2)
        	DrawTable1->TopRow=1;
        if(Message.LParam==DrawTable1->RowCount-1)
        	DrawTable1->TopRow=Message.LParam-DrawTable1->VisibleRowCount+1;
}
//---------------------------------------------------------------------------
void __fastcall TFormVITInput::vParams(TObject* Sender)
{
  TFormVVMeter *f=NULL;
  try{
      if(EditRec)
      switch(MessageBox(Handle, Reconst_smes81_1.c_str(), Application->Title.c_str(),MB_YESNOCANCEL|MB_ICONQUESTION))
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

void __fastcall TFormVITInput::vRefresh(TObject* Sender)
{
  MainProc(this);
  DrawTable1->SetFocus();
}
//---------------------------------------------------------------------------
void TFormVITInput::MainProc(TObject *Sender)
{
	char seldat[20];
 // int state;
  AnsiString sql  =(pointPOL.ifpoint)? "select f.mid, pa.name||'/'||p.name name, ryda.indic_pg.measurename(mn.nmeasure,decode(f.q1234,'*',1,0)) type, \
                        m.position, mn.nmeasure, m.mtrsn, nvl(f.kc,1) KC , m.digits, \
                        to_char(ryda.indic_pg.getlastdate(f.mid,to_date(:par8, 'dd.mm.yyyy hh24:mi'),mn.nmeasure,NULL,5,1),'dd.mm.yyyy hh24:mi') lastd, \
                        ryda.indic_pg.getlastindic(f.mid,to_date(:par8, 'dd.mm.yyyy hh24:mi'),mn.nmeasure,NULL,5) lastind, \
                        ryda.indic_pg.getlastindic(f.mid,to_date(:par8, 'dd.mm.yyyy hh24:mi'),mn.nmeasure,1,5) lastindA, \
                        ryda.indic_pg.getlastindic(f.mid,to_date(:par8, 'dd.mm.yyyy hh24:mi'),mn.nmeasure,2,5) lastindB, \
                        ryda.indic_pg.getlastindic(f.mid,to_date(:par8, 'dd.mm.yyyy hh24:mi'),mn.nmeasure,3,5) lastindC, \
                        ryda.indic_pg.getlastindic(f.mid,to_date(:par8, 'dd.mm.yyyy hh24:mi'),mn.nmeasure,4,5) lastindD, \
                        decode(mn.nmeasure,1,b.erm,2,b.edm,3,b.q1m,4,b.q2m,5,b.q3m,6,b.q4m) em, \
                        decode(mn.nmeasure,1,b.aerm,2,b.aedm,3,b.aq1m,4,b.aq2m,5,b.aq3m,6,b.aq4m) aem, \
                        decode(mn.nmeasure,1,b.berm,2,b.bedm,3,b.bq1m,4,b.bq2m,5,b.bq3m,6,b.bq4m) bem, \
                        decode(mn.nmeasure,1,b.cerm,2,b.cedm,3,b.cq1m,4,b.cq2m,5,b.cq3m,6,b.cq4m) cem, \
                        decode(mn.nmeasure,1,b.derm,2,b.dedm,3,b.dq1m,4,b.dq2m,5,b.dq3m,6,b.dq4m) dem, \
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
                        m.position, mn.nmeasure, m.mtrsn, nvl(f.kc,1) KC , m.digits, \
                        to_char(ryda.indic_pg.getlastdate(f.mid,to_date(:par8, 'dd.mm.yyyy hh24:mi'),mn.nmeasure,NULL,5,1),'dd.mm.yyyy hh24:mi') lastd, \
                        ryda.indic_pg.getlastindic(f.mid,to_date(:par8, 'dd.mm.yyyy hh24:mi'),mn.nmeasure,NULL,5) lastind, \
                        ryda.indic_pg.getlastindic(f.mid,to_date(:par8, 'dd.mm.yyyy hh24:mi'),mn.nmeasure,1,5) lastindA, \
                        ryda.indic_pg.getlastindic(f.mid,to_date(:par8, 'dd.mm.yyyy hh24:mi'),mn.nmeasure,2,5) lastindB, \
                        ryda.indic_pg.getlastindic(f.mid,to_date(:par8, 'dd.mm.yyyy hh24:mi'),mn.nmeasure,3,5) lastindC, \
                        ryda.indic_pg.getlastindic(f.mid,to_date(:par8, 'dd.mm.yyyy hh24:mi'),mn.nmeasure,4,5) lastindD, \
                        decode(mn.nmeasure,1,b.erm,2,b.edm,3,b.q1m,4,b.q2m,5,b.q3m,6,b.q4m) em, \
                        decode(mn.nmeasure,1,b.aerm,2,b.aedm,3,b.aq1m,4,b.aq2m,5,b.aq3m,6,b.aq4m) aem, \
                        decode(mn.nmeasure,1,b.berm,2,b.bedm,3,b.bq1m,4,b.bq2m,5,b.bq3m,6,b.bq4m) bem, \
                        decode(mn.nmeasure,1,b.cerm,2,b.cedm,3,b.cq1m,4,b.cq2m,5,b.cq3m,6,b.cq4m) cem, \
                        decode(mn.nmeasure,1,b.derm,2,b.dedm,3,b.dq1m,4,b.dq2m,5,b.dq3m,6,b.dq4m) dem, \
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

    Caption=TaskName+Reconst_smes81_2+pointPOL.myTime.FormatString("dd.mm.yyyy hh:nn");
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
    strcpy(pointLastInput[i].EM,dmMain->quMain->FieldByName("lastind")->AsString.c_str());
    if(!dmMain->quMain->FieldByName("lastindA")->IsNull)
    strcpy(pointLastInput[i].AEM,dmMain->quMain->FieldByName("lastindA")->AsString.c_str());
    if(!dmMain->quMain->FieldByName("lastindB")->IsNull)
    strcpy(pointLastInput[i].BEM,dmMain->quMain->FieldByName("lastindB")->AsString.c_str());
    if(!dmMain->quMain->FieldByName("lastindC")->IsNull)
    strcpy(pointLastInput[i].CEM,dmMain->quMain->FieldByName("lastindC")->AsString.c_str());
    if(!dmMain->quMain->FieldByName("lastindD")->IsNull)
    strcpy(pointLastInput[i].DEM,dmMain->quMain->FieldByName("lastindD")->AsString.c_str());
    if(!dmMain->quMain->FieldByName("em")->IsNull)
    strcpy(pointLastInput[i].EM_N,dmMain->quMain->FieldByName("em")->AsString.c_str());
    if(!dmMain->quMain->FieldByName("aem")->IsNull)
    strcpy(pointLastInput[i].AEM_N,dmMain->quMain->FieldByName("aem")->AsString.c_str());
    if(!dmMain->quMain->FieldByName("bem")->IsNull)
    strcpy(pointLastInput[i].BEM_N,dmMain->quMain->FieldByName("bem")->AsString.c_str());
    if(!dmMain->quMain->FieldByName("cem")->IsNull)
    strcpy(pointLastInput[i].CEM_N,dmMain->quMain->FieldByName("cem")->AsString.c_str());
    if(!dmMain->quMain->FieldByName("dem")->IsNull)
    strcpy(pointLastInput[i].DEM_N,dmMain->quMain->FieldByName("dem")->AsString.c_str());
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
//	Получение данных в структуру для вывода данных
    DrawTable1->RowCount=1+2*CountStr;
    DrawTable1->ColCount=10;
    DrawTable1->RowsHeight="#25#35#35";
    DrawTable1->ColsWidth="#-160#50#50#110#85#85#85#85#0#120";
    DrawTable1->TabStrings->Add("B C40 T25 M0x5 0xF$#$##$#$#$#$#$#$#$");
    // в случае ввода по тарифу D
    //DrawTable1->ColsWidth="#160#55#125#95#95#95#95#95#-80";
    //DrawTable1->TabStrings->Add("B C40 T17 M0x5 0xF$##$#$#$#$#$#$#$");
    DrawTable1->StaticStrings->Add(Reconst_smes81_3);
    DrawTable1->StaticStrings->Add(Reconst_smes81_4);
    DrawTable1->StaticStrings->Add(Reconst_smes81_5);
    DrawTable1->StaticStrings->Add(Reconst_smes81_6);
    DrawTable1->StaticStrings->Add("A");
    DrawTable1->StaticStrings->Add("B");
    DrawTable1->StaticStrings->Add("C");
    DrawTable1->StaticStrings->Add("D");// в случае ввода по тарифу D
    DrawTable1->StaticStrings->Add(Reconst_smes81_7);
    static int VarDescr[]={20,20,20,20,20};
    DrawTable1->StructStrings->Rebuild(CountStr,5,VarDescr);
    DrawTable1->VarStrings->Clear();
    for(int i=0;i<(int)CountStr;i++){
    	DrawTable1->TabStrings->Add("B- C40 T25 A4 M0x5 0x8007$#A5$#T27 C42 A0x8025 M0x1 0x800E$#$#$#$#$#$#$#A0x8015 M0x1 0x8006 T25$");
    	DrawTable1->TabStrings->Add("A4 M0x5 0x800D T25 C40 ^#A5^#T27 C42 A0x8025 M0x1 0x800C $#$#T25 E# E# E# E# E# ^");
    	DrawTable1->StaticStrings->Add(AnsiString("  ")+pointLastInput[i].Name+" "+pointLastInput[i].Mtrsn);
      DrawTable1->StaticStrings->Add(pointLastInput[i].Type);
      DrawTable1->StaticStrings->Add(Reconst_smes81_8);
      DrawTable1->StaticStrings->Add(pointLastInput[i].Date_time);
      DrawTable1->StaticStrings->Add(pointLastInput[i].EM);
      DrawTable1->StaticStrings->Add(pointLastInput[i].AEM);
      DrawTable1->StaticStrings->Add(pointLastInput[i].BEM);
      DrawTable1->StaticStrings->Add(pointLastInput[i].CEM);
      DrawTable1->StaticStrings->Add(pointLastInput[i].DEM);// в случае ввода по тарифу D
      if(AnsiString(pointLastInput[i].E_N).IsEmpty()&&AnsiString(pointLastInput[i].AE_N).IsEmpty()&&
         AnsiString(pointLastInput[i].BE_N).IsEmpty()&&AnsiString(pointLastInput[i].CE_N).IsEmpty())
      	DrawTable1->StaticStrings->Add("");
      else
      	DrawTable1->StaticStrings->Add("O:"+AnsiString(pointLastInput[i].E_N)+"; "+
                                       "A:"+AnsiString(pointLastInput[i].AE_N)+";\n"+
                                       "B:"+AnsiString(pointLastInput[i].BE_N)+"; "+
                                       "C:"+AnsiString(pointLastInput[i].CE_N)+"; ");
    	DrawTable1->StaticStrings->Add("тек.");
      DrawTable1->StaticStrings->Add(pointPOL.myTime.FormatString("dd.mm.yyyy hh:nn"));
      DrawTable1->VarStrings->Add(pointLastInput[i].EM_N);
      DrawTable1->VarStrings->Add(pointLastInput[i].AEM_N);
      DrawTable1->VarStrings->Add(pointLastInput[i].BEM_N);
      DrawTable1->VarStrings->Add(pointLastInput[i].CEM_N);
      DrawTable1->VarStrings->Add(pointLastInput[i].DEM_N);// в случае ввода по тарифу D
    }
    if(CountStr){
    	DrawTable1->UpdateTabStrings();
      DrawTable1->FocusCell(4,2);
    }
    else
    {
        Application->MessageBox(Reconst_smes81_10.c_str(),Application->Title.c_str(),MB_OK|MB_ICONINFORMATION);
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
//Проверить
void __fastcall TFormVITInput::vCheck(TObject* Sender)
{
  AnsiString sras,scurr;
  bool conv;
  double proc;
  static double dopproc=30;
  double dopusk;
  TColor CurrentColor;
  TDrawTable::SAttrCell *pCur,*pRas;
  long redcell,redcellz,j=-1,z=0,notallpok;
  AnsiString srasS;

  if(prov||!CountStr)//была проверка или нет записей
    return;

  try{
    Screen->Cursor=crHourGlass;
    prov=2;//Можно сохранять
    for(j=0;j <(long)CountStr ;j++){
      if(!pointLastInput[j].editRecord)
        continue;
      CurrentColor=clWhite;
      dopusk=0;
      z=0;
      notallpok=0;
      sras="";
      pRas=(TDrawTable::SAttrCell *)DrawTable1->GetCellAttr(9,1+2*j);
      for(z=0;z<4;z++){
        pCur=(TDrawTable::SAttrCell *)DrawTable1->GetCellAttr(4+z,2+2*j);
        scurr=SAATrim(pCur->SourceData->Strings[pCur->IndexData]);
        if(scurr.IsEmpty())
          notallpok++;
        switch(z){
          case 0:
            sras=GetRas(pointLastInput[j].EM,scurr,pointLastInput[j].Digits,pointLastInput[j].KC,conv,proc);
            strcpy(pointLastInput[j].EM_N,scurr.c_str());
            strcpy(pointLastInput[j].E_N,sras.c_str());
            break;
          case 1:
            sras=GetRas(pointLastInput[j].AEM,scurr,pointLastInput[j].Digits,pointLastInput[j].KC,conv,proc);
            strcpy(pointLastInput[j].AEM_N,scurr.c_str());
            strcpy(pointLastInput[j].AE_N,sras.c_str());
            break;
          case 2:
            sras=GetRas(pointLastInput[j].BEM,scurr,pointLastInput[j].Digits,pointLastInput[j].KC,conv,proc);
            strcpy(pointLastInput[j].BEM_N,scurr.c_str());
            strcpy(pointLastInput[j].BE_N,sras.c_str());
            break;
          case 3:
            sras=GetRas(pointLastInput[j].CEM,scurr,pointLastInput[j].Digits,pointLastInput[j].KC,conv,proc);
            strcpy(pointLastInput[j].CEM_N,scurr.c_str());
            strcpy(pointLastInput[j].CE_N,sras.c_str());
            break;
          case 4:
            sras=GetRas(pointLastInput[j].DEM,scurr,pointLastInput[j].Digits,pointLastInput[j].KC,conv,proc);
            strcpy(pointLastInput[j].DEM_N,scurr.c_str());
            strcpy(pointLastInput[j].DE_N,sras.c_str());
            break;
        }
        if(!sras.IsEmpty())
          dopusk+=(((z)?-1.0:1.0)*sras.ToDouble());
        if(proc>=dopproc){
          CurrentColor=clRed;
          if(prov==2){
            prov=1;
            redcell=j;
            redcellz=z;
          }
        }else{
          if(conv&&(CurrentColor!=clRed))
            CurrentColor=clYellow;
          if(AnsiString(pointLastInput[j].EM).IsEmpty()&&(CurrentColor!=clRed)&&(CurrentColor!=clYellow))
            CurrentColor=clLime;
        }
      }
      z=0;
      if(notallpok!=0&&notallpok!=4)
        throw Exception (Reconst_smes81_11);
      if(AnsiString(pointLastInput[j].E_N).IsEmpty()&&AnsiString(pointLastInput[j].AE_N).IsEmpty()&&
         AnsiString(pointLastInput[j].BE_N).IsEmpty()&&AnsiString(pointLastInput[j].CE_N).IsEmpty())
        pRas->SourceData->Strings[pRas->IndexData]="";
      else
        pRas->SourceData->Strings[pRas->IndexData]="O:"+AnsiString(pointLastInput[j].E_N)+"; "+
                                                   "A:"+AnsiString(pointLastInput[j].AE_N)+";\n"+
                                                   "B:"+AnsiString(pointLastInput[j].BE_N)+"; "+
                                                   "C:"+AnsiString(pointLastInput[j].CE_N)+"; ";
      if(abs(dopusk)>=1)
        throw Exception (Reconst_smes81_12+FormatFloat("########0.00",dopusk));
      if(pRas->styleCell==TDrawTable::SAttrCell::cellStatic){
        pRas->BackgroundColor= CurrentColor;
        pRas=(TDrawTable::SAttrCell *)DrawTable1->GetCellAttr(9,2+2*j);
        pRas->BackgroundColor= CurrentColor;
      }
    }
    if(prov==1){
      DrawTable1->FocusCell(4+redcellz,2+2*redcell);
      if(DrawTable1->VisibleRowCount<2*(long)CountStr-1)
        DrawTable1->TopRow=1+2*redcell;
      MessageBox(Handle,AnsiString(Reconst_smes81_13+
                        IntToStr((long)dopproc)+Reconst_smes81_14).c_str(),
                        Application->Title.c_str(),MB_OK |MB_ICONWARNING);
    }
    Screen->Cursor=crDefault;
  }catch(Exception &exception){
    prov=0;
    Screen->Cursor=crDefault;
    if(j>=0){
      DrawTable1->FocusCell(4+z,2+2*j);
      if(DrawTable1->VisibleRowCount<2*(long)CountStr-1)
        DrawTable1->TopRow=1+2*j;
    }
  	Application->ShowException(&exception);
  }
  DrawTable1->Invalidate();
  DrawTable1->SetFocus();
}
//---------------------------------------------------------------------------
//save
void __fastcall TFormVITInput::vSave(TObject* Sender)
{
  long i=-1;
	char seldat[20];
  POINTLASTINPUT pLI;
  static char *insupd = "begin \
                           ryda.indic_pg.setindic(:par12,to_date(:par11, 'dd.mm.yyyy hh24:mi'),:par17,'Р.В',:par14,:par15,:par16,:par1,:par2,:par3,:par4,:par5,:par6,:par7,:par8,:par9,:par10); \
                         end;";
  if(!EditRec||!CountStr)//нет редактирования или нет записей
    return;
  if(!prov){
    MessageBox(Handle,Reconst_smes81_15.c_str(),
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
           dmMain->quMain->ParamByName("par2")->AsString= pLI.AEM_N;
           dmMain->quMain->ParamByName("par3")->AsString= pLI.BEM_N;
           dmMain->quMain->ParamByName("par4")->AsString= pLI.CEM_N;
           dmMain->quMain->ParamByName("par5")->AsString= pLI.DEM_N;
           dmMain->quMain->ParamByName("par6")->AsString= pLI.E_N;
           dmMain->quMain->ParamByName("par7")->AsString= pLI.AE_N;
           dmMain->quMain->ParamByName("par8")->AsString= pLI.BE_N;
           dmMain->quMain->ParamByName("par9")->AsString= pLI.CE_N;
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
void __fastcall TFormVITInput::DrawTable1KeyPress(TObject *Sender,
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

