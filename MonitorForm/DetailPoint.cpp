//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
#include "unDataMod.h"
#include "Reconst.hpp"
#include "SetupMonitors.h"
#include "ValidParam.h"
#include "DetailPoint.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "DBGridEh"
#pragma link "MemDS"
#pragma link "VirtualTable"
#pragma link "DBAccess"
#pragma link "Ora"
#pragma resource "*.dfm"
TfmDetailPoint *fmDetailPoint;
//---------------------------------------------------------------------------
__fastcall TfmDetailPoint::TfmDetailPoint(TComponent* Owner)
  : TForm(Owner)
{
   ReplaceRyda(this,BASE_SCHEME,SchemeName);

     //заполнение списка объектов
  oqObjType->Execute();

 while (!oqObjType->Eof) {
  if(oqObjType->FieldByName("nid")->AsInteger)
   cbMeas->Items->AddObject(oqObjType->FieldByName("VNAME")->AsString,(TObject*)oqObjType->FieldByName("nid")->AsInteger);
   oqObjType->Next();
 }

 oqObjType->Close();
 cbMeas->ItemIndex=0;
 ColPresed=false;

}
//-------------------------------------------------------------------------------------------------------
void TfmDetailPoint::SetFormDesc(TFormDescr* aFD,int aIdGroup,int aInd)
{

      iFD=aFD;
      if(!iFD->IsPoints){
          oqTest->Params->Clear();
          oqTest->SQL->Text="begin :test:="+SchemeName+"DETAILPOINT_PG.get_mid(:nmid);end;";
          oqTest->ParamByName("test")->ParamType=ptOutput;
          oqTest->ParamByName("test")->DataType=ftInteger;
          oqTest->ParamByName("nmid")->AsInteger=aIdGroup;
          oqTest->Execute();
         // iFD->IsPoints=true;
          IdGroup=oqTest->ParamByName("test")->AsInteger;
          }else
           IdGroup=aIdGroup;
      Ind=aInd;
      ObjIDCount=0;
      Max= ObjIDCount;
      IdForm[ObjIDCount].Id =IdGroup;
      IdForm[ObjIDCount].Ind=Ind;
      }
//-------------------------------------------------------------------------------------------------

void __fastcall TfmDetailPoint::FormActivate(TObject *Sender)
{
  vParams(NULL);
}
//---------------------------------------------------------------------------
void __fastcall TfmDetailPoint::vParams(TObject* Sender)
{


 int FRowCount;
    try{
      editFrmla->Clear();
      eTypeF->Caption="";
      vtData->DisableControls();
       SpezRef();

     vtData->First();
      if(Ind==1) {
   // editfeeders_pg.formulameas_p(IdGroup)
     ReadDataFormula(GetCodeTemplate(),IdGroup);
     ReadDataArgument();
      }else{
        while (!vtData->Eof){
       ReadDataFormula(GetCodeTemplate(),vtData->FieldByName("mid")->AsInteger);
       vtData->Next();
       }
      }
     vtData->First();
     vtData->EnableControls();



        grDetail->SetFocus();

  }catch (Exception &exception){
     	Application->ShowException(&exception);
    if(!Sender)
         Close();
  }
}
//---------------------------------------------------------------------------
long __fastcall TfmDetailPoint::GetCodeTemplate()
{
  int CodeTemplate;

// if (Ind==1){
 switch ((long)cbMeas->Items->Objects[cbMeas->ItemIndex])
        {
      case 0:  // CodeTemplate=400;break; //AEBO_F
      case 1:   CodeTemplate=500;break; //AERO_F
      case 2:   CodeTemplate=600;break; //AEDO_F
      case 3:   CodeTemplate=800;break;  //RERO_F
      case 5:   CodeTemplate=900;break;//REDO_F
      }
// }else
//   CodeTemplate=iFD->CodeTemplate;
   
   return  CodeTemplate;
 }
//-----------------------------------------------------------------------------
 void __fastcall TfmDetailPoint::GetColumnName()
{

   TColumnEh *grColumn;
   AnsiString S;
  double StepPROFILE;
  TDateTime tempDate;
	AnsiString formatDate;
	AnsiString formatDateSum;
 // double PowerProfile;
  int ind=0;
 	unsigned short year,month,day,hour, minute, sec, msec;

   //-----------------------------------   наполнение колонок фиксированных
   AnsiString NamePoint1;
   TFieldDefs *pDefs = vtData->FieldDefs;
    TFieldDef *pDef=NULL;
    //Теперь структура таблицы

    pDef = pDefs->AddFieldDef();
    pDef->DataType = ftFloat;
    pDef->Name = "mid";
    pDef->DisplayName="mid";
    pDef = pDefs->AddFieldDef();
    pDef->DataType = ftInteger;
    pDef->Name = "test";
    pDef->DisplayName="test";
    pDef = pDefs->AddFieldDef();
    pDef->DataType = ftString;
    pDef->Size=400;
    pDef->Name = "name";
    pDef->DisplayName="name";
    pDef = pDefs->AddFieldDef();
    pDef->DataType = ftString;
    pDef->Name = "type";
    pDef->Size=50;
    pDef->DisplayName="type";
   if(Ind==1){
    pDef = pDefs->AddFieldDef();
    pDef->DataType = ftInteger;
    pDef->Name = "nid";
    pDef->DisplayName="nid";
    pDef = pDefs->AddFieldDef();
    pDef->DataType = ftString;
    pDef->Size=100;
    pDef->Name = "vparam";
    pDef->DisplayName="vparam";
    pDef = pDefs->AddFieldDef();
    pDef->DataType = ftInteger;
    pDef->Name = "summ";
    pDef->DisplayName="summ";
    pDef = pDefs->AddFieldDef();
    pDef->DataType = ftInteger;
    pDef->Name = "nshift";
    pDef->DisplayName="nshift";
    pDef = pDefs->AddFieldDef();
    pDef->DataType = ftInteger;
    pDef->Name = "NOPTTYPEt";
    pDef->DisplayName="NOPTTYPE";
     pDef = pDefs->AddFieldDef();
    pDef->DataType = ftInteger;
    pDef->Name = "nhoureriod";
    pDef->DisplayName="nhoureriod";
     pDef = pDefs->AddFieldDef();
    pDef->DataType = ftInteger;
    pDef->Name = "ntimezonew";
    pDef->DisplayName="ntimezonew";
     pDef = pDefs->AddFieldDef();
    pDef->DataType = ftInteger;
    pDef->Name = "ntimezones";
    pDef->DisplayName="ntimezones";

    }


    iFD->DateTime.DecodeDate(&year,&month,&day);

  int PP;
   //PowerProfile=30;

    if((IsShiftTimeZona)&&(month==10)&&(iFD->DateTime.DayOfWeek()==1&&31-day<7))  //25 час
       ColCount=24*(60/PowerProfile)+1*(60/PowerProfile);
    else if((IsShiftTimeZona)&&(month==3)&&(iFD->DateTime.DayOfWeek()==1&&31-day<7)) //23 час
       ColCount=24*(60/PowerProfile)-1*(60/PowerProfile);
    else
     ColCount=24*(60/PowerProfile);





    hour=1;
    StepPROFILE=1.0/ColCount;
     if(ColCount>24*(60/PowerProfile))//25 час
    {
    StepPROFILE=1.0/(ColCount-60/PowerProfile);
    tempDate=TDateTime(year,month,day)+hour/(double)(ColCount-60/PowerProfile);
    }
    else if(ColCount<24*(60/PowerProfile))//23 час
    {
    StepPROFILE=1.0/(ColCount+60/PowerProfile);
    tempDate=TDateTime(year,month,day)+hour/(double)(ColCount+60/PowerProfile);
    }
    else
    {
    	StepPROFILE=1.0/ColCount;
     tempDate=TDateTime(year,month,day)+hour/(double)ColCount;
     }
   	formatDate="t";
		formatDateSum="dd/mm/yyyy";


    for(int i=0; i<ColCount+1; i++){
      pDef = pDefs->AddFieldDef();
      pDef->DataType = ftFloat;
      pDef->Name = "Field"+IntToStr(i);
      pDef->DisplayName="Field"+IntToStr(i);

      pDef = pDefs->AddFieldDef();
      pDef->DataType = ftString;
      pDef->Name = "Nqm"+IntToStr(i);
      pDef->Size=50;

      }


    if(Ind==1)
    ReadDataRow();
    else
    ReadDataRowGreen();
       //фиксированные колонки
  for(int i=0;i<4;i++)
  {
  grColumn=grDetail->Columns->Add();
  switch(i)
  {

 case 0:  grColumn->Color=clBtnFace;
          grColumn->ReadOnly=true;
          grColumn->Width=20;
          break;
  case 1: grColumn->Title->Caption=(Ind==1)?"Формула|Аргументы формулы":"Обобщенная точка учета|Источники";
          grColumn->FieldName="name";
          grColumn->Color=clBtnFace;
          grColumn->ReadOnly=true;
          grColumn->Width=200;
          grColumn->WordWrap=true;
          break;
  case 2: grColumn->Title->Caption="Вид энергии";
          grColumn->FieldName="TYPE";
          grColumn->Color=clBtnFace;
          grColumn->ReadOnly=true;
          grColumn->Width=(Ind==1)?60:0;
          break;
  case 3: grColumn->Title->Caption="Сумма|"+iFD->DateTime.FormatString(formatDateSum);
          grColumn->Color=clYellow;
          grColumn->FieldName="Field"+IntToStr(0);
          grColumn->ReadOnly=true;
          grColumn->Width=79;
          break;

  }


  }




    for(int z=1;z<ColCount+1;z++){
      grColumn=grDetail->Columns->Add();
      grColumn->Tag=z+(grDetail->FrozenCols)-2;//Запоминаем порядок (а то колонки поменяют)
      grColumn->Title->Caption=tempDate.FormatString(formatDate);
      grColumn->FieldName="Field"+IntToStr(z);
          //------------------------------------------

    tempDate+=StepPROFILE;
   

     tempDate.DecodeTime(&hour, &minute, &sec, &msec);

     if((IsShiftTimeZona)&&ColCount>24*(60/PowerProfile)&&!ind&&(hour==(PowerProfile==60?5-TimeZona:4-TimeZona)
      && minute==(PowerProfile==60?0:PowerProfile)))

       {
           ind=60/PowerProfile;   //25 час
           tempDate=tempDate-ind*StepPROFILE;

       }
     if((IsShiftTimeZona)&&ColCount<24*(60/PowerProfile)&&!ind&&(hour==(PowerProfile==60?4-TimeZona:3-TimeZona)
      && minute==(PowerProfile==60?0:PowerProfile)))

       {
           ind=60/PowerProfile;   //23 час
           tempDate=tempDate+ind*StepPROFILE;

       }
      //---------------------------------------------

      grColumn->Width=70;
      }
      grDetail->FrozenCols=4;
      TCount=0;
      grDetail->FixedColor=clBtnFace;
      grDetail->Columns->EndUpdate();

   //------------------------------------------------------------------------------------------

  
}

//------------------------------------------------------------------------------------------------------
 bool __fastcall TfmDetailPoint::ReadDataRow()
 {
 vtData->Open();

    oqReadRow->Params->Clear();
    oqReadRow->SQL->Text="begin "+SchemeName+"DETAILPOINT_PG.get_points(:idgroup,:meas,:acur);end;";
    oqReadRow->ParamByName("acur")->DataType=ftCursor;
    oqReadRow->ParamByName("acur")->ParamType=ptOutput;
    oqReadRow->ParamByName("idgroup")->AsInteger=IdGroup;
    oqReadRow->ParamByName("meas")->AsInteger=(long)cbMeas->Items->Objects[cbMeas->ItemIndex];
    oqReadRow->Execute();
    RowCount=0;

      while (!oqReadRow->Eof){
           RowCount++;
       if(vtData->State==dsInsert||vtData->State==dsEdit)
            vtData->Post();
          vtData->Append();


          vtData->FieldByName("nid")->AsFloat=oqReadRow->FieldByName("nid")->AsFloat;
          vtData->FieldByName("mid")->AsFloat=oqReadRow->FieldByName("mid")->AsFloat;
          vtData->FieldByName("name")->AsString=oqReadRow->FieldByName("name")->AsString;
          vtData->FieldByName("type")->AsString=oqReadRow->FieldByName("type")->AsString;
          vtData->FieldByName("vparam")->AsString=oqReadRow->FieldByName("vparam")->AsString;
          vtData->FieldByName("nshift")->AsInteger=oqReadRow->FieldByName("nshift")->AsInteger;
          vtData->FieldByName("NOPTTYPE")->AsInteger=oqReadRow->FieldByName("NOPTTYPE")->AsInteger;
          vtData->FieldByName("nhoureriod")->AsInteger=oqReadRow->FieldByName("nhoureriod")->AsInteger;
          vtData->FieldByName("ntimezonew")->AsInteger=oqReadRow->FieldByName("ntimezonew")->AsInteger;
          vtData->FieldByName("ntimezones")->AsInteger=oqReadRow->FieldByName("ntimezones")->AsInteger;

          if(oqReadRow->FieldByName("norder")->AsInteger==-1){
            editFrmla->Text= oqReadRow->FieldByName("vformula")->AsString;
            eTypeF->Caption= oqReadRow->FieldByName("vtypeformula")->AsString;
            }
          vtData->FieldByName("test")->AsInteger=oqReadRow->FieldByName("test")->AsInteger;



         vtData->FieldByName("summ")->AsInteger=oqReadRow->FieldByName("summ")->AsInteger;
          oqReadRow->Next();

          }
       if(!RowCount)return false;
       else  return true;
 }
 //------------------------------------------------------------------------------------------------------
 void __fastcall TfmDetailPoint::ReadDataRowGreen()
 {
 vtData->Open();

    oqReadRow->Params->Clear();
    oqReadRow->SQL->Text="begin "+SchemeName+"DETAILPOINT_PG.get_points_green( :idgroup ,:date ,:acur);end;";
    oqReadRow->ParamByName("acur")->DataType=ftCursor;
    oqReadRow->ParamByName("acur")->ParamType=ptOutput;
    oqReadRow->ParamByName("idgroup")->AsInteger=IdGroup;
    oqReadRow->ParamByName("date")->AsDateTime=iFD->DateTime;
    oqReadRow->Execute();
    RowCount=0;
      while (!oqReadRow->Eof){
           RowCount++;
       if(vtData->State==dsInsert||vtData->State==dsEdit)
            vtData->Post();
          vtData->Append();

          vtData->FieldByName("mid")->AsFloat=oqReadRow->FieldByName("mid")->AsFloat;
          vtData->FieldByName("name")->AsString=oqReadRow->FieldByName("name")->AsString;
          vtData->FieldByName("test")->AsInteger=oqReadRow->FieldByName("test")->AsInteger;
          

         oqReadRow->Next();

          }
 }
//---------------------------------------------------------------------------
 void __fastcall TfmDetailPoint::ReadDataFormula(int aCodeTemplate,int aMid)
{
// int CodeTemplate;
 char FirstDate[20], LastDate[20];
 unsigned short year, month, day;
 AnsiString DateTimeFormat("dd'.'mm'.'yyyy hh':'nn':'ss");

   iFD->DateTime.DecodeDate(&year, &month, &day);
   strcpy( FirstDate,(TDateTime(year, month, day)+1.157407407407e-5).FormatString(DateTimeFormat).c_str());
   strcpy( LastDate,(TDateTime(year, month,day)+1).FormatString(DateTimeFormat).c_str());





     oqDataFormula->Params->Clear();
     oqDataFormula->SQL->Text=" begin "+SchemeName+"interior_pg.Interior1_selectData_p(:par7, \
                              :par8,:par9,:par10,:par11,:par12,:par13,:par1,:par2,:par3,:par4,:par5,:par6,:par14); end;";





   //   -----------------------------------------------------------------------------
      oqDataFormula->ParamByName("par14")->ParamType=ptOutput;
      oqDataFormula->ParamByName("par14")->DataType=ftCursor;

      oqDataFormula->ParamByName("par7")->AsInteger=1;//iFD->IsPoints?1:0; ;
      oqDataFormula->ParamByName("par8")->AsInteger=iFD->StepProfile;
      oqDataFormula->ParamByName("par9")->AsInteger=aCodeTemplate;
      oqDataFormula->ParamByName("par10")->AsString=IntToStr(ColCount);
      oqDataFormula->ParamByName("par11")->AsInteger=iFD->bird;
      oqDataFormula->ParamByName("par12")->AsInteger=PowerProfile;
     // oqDataFormula->ParamByName("par13")->AsInteger=24*(60/PowerProfile);
     if(iFD->StepProfile==TFormDescr::stpHour)
        oqDataFormula->ParamByName("par13")->AsInteger=24*(60/PowerProfile);
      else
        oqDataFormula->ParamByName("par13")->AsInteger=StepPROFILE;

   //  ---------------------------------------------------------------------------------
      oqDataFormula->ParamByName("par1")->AsString=FirstDate;
      oqDataFormula->ParamByName("par2")->AsString=LastDate;
      oqDataFormula->ParamByName("par3")->AsInteger=aMid; //IdGroup;
      oqDataFormula->ParamByName("par6")->AsInteger=iFD->GetPeriod(iFD->DateTime);
      oqDataFormula->ParamByName("par4")->AsInteger=iFD->GetPeriodForYearStart(iFD->DateTime);
      oqDataFormula->ParamByName("par5")->AsInteger=iFD->GetPeriodForYearFinish(iFD->DateTime);




  //  vtData->First();
    if(vtData->State==dsInsert||vtData->State==dsEdit)
          vtData->Post();

     oqDataFormula->Execute();
      while(!oqDataFormula->Eof){
             vtData->Edit();

               if(!oqDataFormula->FieldByName("AParam")->IsNull)
               //  vtData->FieldByName("Field"+IntToStr(oqDataFormula->FieldByName("BGroup")->AsInteger))->AsFloat= StrToFloat(FormatFloat("###,###,##0.000;;0.00"/*"0.000"*/,oqDataFormula->FieldByName("AParam")->AsFloat));
               vtData->FieldByName("Field"+IntToStr(oqDataFormula->FieldByName("BGroup")->AsInteger))->AsFloat= oqDataFormula->FieldByName("AParam")->AsFloat;
                  if(oqDataFormula->FieldByName("decnsour")->AsString.Length()>=22)
                        vtData->FieldByName("Nqm"+IntToStr(oqDataFormula->FieldByName("BGroup")->AsInteger))->AsString= oqDataFormula->FieldByName("decnsour")->AsString;
              oqDataFormula->Next();

     }

   if(vtData->State==dsInsert||vtData->State==dsEdit)
          vtData->Post();

  }
//------------------------------------------------------------------------------------------------------
 void __fastcall TfmDetailPoint::ReadDataArgument()
 {
   int Summ;
 //  int Timeshift;
   vtData->First();
   vtData->Next();
   TDateTime dd;
   if(vtData->State==dsInsert||vtData->State==dsEdit)
          vtData->Post();

   /*   Timeshift=0;
 if (Ind==1)
    {
    oqTest->Params->Clear();
    oqTest->SQL->Text="begin :test:="+SchemeName+"DETAILPOINT_PG.get_timeshift(:nmid);end;";
    oqTest->ParamByName("test")->ParamType=ptOutput;
    oqTest->ParamByName("test")->DataType=ftInteger;
    oqTest->ParamByName("nmid")->AsInteger=IdGroup;
    oqTest->Execute();
    Timeshift=oqTest->ParamByName("test")->AsInteger;
    }    */
    while (!vtData->Eof)
    {
      if(vtData->FieldByName("NOPTTYPE")->AsInteger!=0){
        ReadDataFormula(GetCodeTemplate(),vtData->FieldByName("mid")->AsInteger);
      }else{
      dd= iFD->DateTime;

      oqArgument->ParamByName("dfrom")->AsDateTime=dd;
      oqArgument->ParamByName("dtill")->AsDateTime=dd+1;
      oqArgument->ParamByName("ncount")->AsInteger=ColCount+1;//ColCount+2;
      oqArgument->ParamByName("vparam")->AsString=vtData->FieldByName("vparam")->AsString;
      oqArgument->ParamByName("nshift")->AsInteger=vtData->FieldByName("nshift")->AsInteger;
      oqArgument->ParamByName("nhoureriod")->AsInteger=vtData->FieldByName("nhoureriod")->AsInteger;
      oqArgument->ParamByName("ntimezonew")->AsInteger=vtData->FieldByName("ntimezonew")->AsInteger;
      oqArgument->ParamByName("ntimezones")->AsInteger=vtData->FieldByName("ntimezones")->AsInteger;

      oqArgument->ParamByName("tparamval")->Length=ColCount+1;//ColCount+2;
      oqArgument->ParamByName("tqm")->Length=ColCount+1;//ColCount+2;
  //    oqArgument->ParamByName("Timeshift")->AsInteger=Timeshift;




      oqArgument->Execute();


         for(int i=1;i<=ColCount+1/*ColCount+2*/;i++)
           {
             vtData->Edit();
             if(!oqArgument->ParamByName("tparamval")->ItemIsNull[i])

               vtData->FieldByName("Field"+IntToStr(i-1))->AsFloat=oqArgument->ParamByName("tparamval")->ItemAsFloat[i];
               vtData->FieldByName("Nqm"+IntToStr(i-1))->AsString=oqArgument->ParamByName("tqm")->ItemAsString[i];

           }


         if(vtData->State==dsInsert||vtData->State==dsEdit)
          vtData->Post();
      }
      vtData->Next();
    }


 }
//-------------------------------------------------------------------------------------------------------------------

void __fastcall TfmDetailPoint::grDetailDrawColumnCell(TObject *Sender,
      const TRect &Rect, int DataCol, TColumnEh *Column,
      TGridDrawState State)
{
 AnsiString s;
 char aisvalid[32];
 TRect Rect1(Rect.Right-(grDetail->Canvas->TextWidth("s"))-3,Rect.Top+1,
            Rect.Right-1,Rect.Top+(grDetail->Canvas->TextWidth("s")+3)); //Верхний правый угол ячейки
 //TRect Rect2(Rect.Left+1,Rect.Top+1,Rect.Left+(grDetail->Canvas->TextWidth("s"))+3,
 //           Rect.Top+(grDetail->Canvas->TextWidth("s")+3));             //Верхний левый угол ячейки
 TRect Rect3(Rect.Right-(grDetail->Canvas->TextWidth("s"))-3,Rect.Bottom-(grDetail->Canvas->TextWidth("s"))-3,
            Rect.Right-1,Rect.Bottom);                                //Нижний правый угол ячейки
  char Symb[4][32]={"OK"," X "," * "," ? "};
  TColor Color [4]={clGreen,clRed,clBlue ,(TColor)RGB(255,128,0)}; //Цвет фона верхнего  RGB(255,128,0)
  TColor ColorSimbol[4]={clWhite,clWhite,clWhite,clWhite}; //Цвет шрифта верхнего
  char Symb1[9][32]={" N "," 1 "," 2 "," S "," P "," M "," O "," A "," П " };
  TColor Color1[9]={(TColor)RGB(192,192,192),clGreen,clGreen,clBlue,clBlue,clBlue,clGreen,(TColor)RGB(159,255,159),clBlue};//Цвет фона нижнего
  TColor ColorSimbol1[9]={clBlack,clWhite,clWhite,clWhite,clWhite,clWhite,clWhite,clBlack,clWhite};         //Цвет шрифта нижнего

  if(DataCol==0)
  {
    if(vtData->FieldByName("test")->AsInteger>0)

        ImageList1->Draw(grDetail->Canvas, Rect.Left + 2, Rect.Top + 1,
                      vtData->FieldByName("test")->AsInteger -1,
                      true);
  }

    if(DataCol>2)
    {
      if(vtData->FieldByName("mid")->AsInteger==IdGroup )
          {

           grDetail->Canvas->Brush->Color=clYellow;
           grDetail->Canvas->FillRect(Rect);
          }
          if(!grDetail->Columns->Items[DataCol]->Field->IsNull)
          {
           grDetail->Canvas->Refresh();
           grDetail->Canvas->Font->Name="MS Sans Serif";//"Fixedsys";
           grDetail->Canvas->Font->Size = -11;
           grDetail->Canvas->Font->Color=clBlack;
           s=FormatFloat("###,###,##0.000;;0.00"/*"0.000"*/,grDetail->Columns->Items[DataCol]->Field->AsFloat);
           grDetail->Canvas->TextRect(Rect,Rect.Right-(grDetail->Canvas->TextWidth(s)+15),Rect.Top+2,s);
           }

  //  if(DataCol>3)
  //  {
         strcpy(aisvalid,vtData->FieldByName("Nqm"+IntToStr(DataCol-3))->AsString.c_str());
        if (FormSetupMonitors->RadioGroupShowValidity->ItemIndex == 1)
        {
              if(GetQuality(aisvalid))
           {
           grDetail->Canvas->Refresh();
           grDetail->Canvas->Font->Name = "Small Fonts";
           grDetail->Canvas->Font->Size =Rect1.Height()-1.5;// -7;
           if(StrToInt(aisvalid[0])){
           grDetail->Canvas->Brush->Color=Color[StrToInt(aisvalid[0])];
           grDetail->Canvas->FillRect(Rect1);
           grDetail->Canvas->Font->Color=ColorSimbol[StrToInt(aisvalid[0])];
           grDetail->Canvas->TextRect(Rect1,Rect1.Left,Rect1.Top,Symb[StrToInt(aisvalid[0])]);
           }
           grDetail->Canvas->Brush->Color=Color1[StrToInt(aisvalid[21])];
           grDetail->Canvas->FillRect(Rect3);
           grDetail->Canvas->Font->Color=ColorSimbol1[StrToInt(aisvalid[21])];
           grDetail->Canvas->TextRect(Rect3,Rect3.Left,Rect3.Top,Symb1[StrToInt(aisvalid[21])]);

           }
        }
    if (FormSetupMonitors->RadioGroupShowValidity->ItemIndex == 2)
        {
         if((aisvalid[0]!='\0')&&(StrToInt(aisvalid[0])))
          {
           grDetail->Canvas->Brush->Color=clRed;
           grDetail->Canvas->FillRect(Rect1);
          }
        }
   //  }
  }
}
//---------------------------------------------------------------------------


void __fastcall TfmDetailPoint::grDetailMouseUp(TObject *Sender,
      TMouseButton Button, TShiftState Shift, int X, int Y)
{
 char s[32];
      if(ColPresed)
      {
        if(IdGroup==vtData->FieldByName("mid")->AsInteger)
        {
          SpeedButton1Click(this);//  return;
        }else{
        oqTest->Params->Clear();
        oqTest->SQL->Text="begin :test:="+SchemeName+"DETAILPOINT_PG.test_points(:idgroup,:ispoints);end;";
        oqTest->ParamByName("test")->ParamType=ptOutput;
        oqTest->ParamByName("test")->DataType=ftInteger;
        oqTest->ParamByName("idgroup")->AsInteger=vtData->FieldByName("mid")->AsInteger;
        oqTest->ParamByName("ispoints")->AsInteger=1;
        oqTest->Execute();
        if(!oqTest->ParamByName("test")->AsInteger)  return;
        Screen->Cursor=crHourGlass;
        IdGroup=vtData->FieldByName("mid")->AsInteger;
        if(Ind!=oqTest->ParamByName("test")->AsInteger)
        {
          Ind=oqTest->ParamByName("test")->AsInteger;
          SpezRef();

        }else
           Ind=oqTest->ParamByName("test")->AsInteger;
        ObjIDCount++;
        IdForm[ObjIDCount].Id=IdGroup;
        IdForm[ObjIDCount].Ind=Ind;
        Max= ObjIDCount;
        if(Max>=MaxInd) ObjIDCount=0;

        vRefresh(this);
        ColPresed=false;
       Screen->Cursor=crDefault;
       }
      }
     if(ColValidPressed&&grDetail->SelectedIndex>2){
      if(!vtData->FieldByName("Nqm"+IntToStr(grDetail->SelectedIndex-3))->AsString.IsEmpty())
      {
      strcpy(s,vtData->FieldByName("Nqm"+IntToStr(grDetail->SelectedIndex-3))->AsString.c_str());
      TfmValidityForm *ValidityForm = new TfmValidityForm(this,s,vtData->FieldByName("name")->AsString,
                      grDetail->Columns->Items[grDetail->SelectedIndex]->Title->Caption);
      ValidityForm->ShowModal();
      ColValidPressed=false;
      delete ValidityForm;
      }else
         ColValidPressed=false;
     }
}
//---------------------------------------------------------------------------
void __fastcall TfmDetailPoint::SpezRef()
{
      //  Panel2->Enabled=(Ind==1);
        editFrmla->Clear();
        eTypeF->Caption="";
        lbFormula->Caption=(Ind==1)?"Формула":"Обобщенная точка учета";
          grDetail->Columns->BeginUpdate();
          grDetail->FrozenCols=0;
          grDetail->FooterRowCount=0;
          grDetail->Columns->Clear();
          vtData->Close();
          vtData->Clear();
          vtData->DeleteFields();
          GetColumnName();

}
//------------------------------------------------------------------------------

void __fastcall TfmDetailPoint::grDetailMouseDown(TObject *Sender,
      TMouseButton Button, TShiftState Shift, int X, int Y)
{
 TShiftState rightShift;
	rightShift<<ssRight;
  
     	if(Button==mbRight && Shift==rightShift&&grDetail->SelectedIndex==1)
      {
       ColPresed=true;

      }
      	if(Button==mbRight && Shift==rightShift&&grDetail->SelectedIndex>2)
      {
      ColValidPressed =true;
       }
}
//---------------------------------------------------------------------------
 void __fastcall TfmDetailPoint::SpeedButton1Click(TObject *Sender)
{
    if (ObjIDCount>0)
    {
      IdGroup=IdForm[ObjIDCount-1].Id;
      if(Ind!=IdForm[ObjIDCount-1].Ind)
      {
       Ind=IdForm[ObjIDCount-1].Ind;
         SpezRef();
      }else
       Ind=IdForm[ObjIDCount-1].Ind;

       vRefresh(this);
      ObjIDCount=ObjIDCount-1;
    }
}
//---------------------------------------------------------------------------

void __fastcall TfmDetailPoint::SpeedButton2Click(TObject *Sender)
{
   if (ObjIDCount<Max)
     {

         IdGroup=IdForm[ObjIDCount+1].Id;
         if(Ind!=IdForm[ObjIDCount+1].Ind)
          {
            Ind=IdForm[ObjIDCount+1].Ind;
            SpezRef();
          }else
            Ind=IdForm[ObjIDCount+1].Ind;

           vRefresh(this);
        ObjIDCount=ObjIDCount+1;
     }
}
//---------------------------------------------------------------------------

void __fastcall TfmDetailPoint::vRefresh(TObject* Sender)
{

  try{
     editFrmla->Clear();
     eTypeF->Caption="";
     vtData->DisableControls();
     vtData->Clear();
     if(Ind==1)
       ReadDataRow();
     else
       ReadDataRowGreen();
     vtData->First();
     if(Ind==1){
     ReadDataFormula(GetCodeTemplate(),IdGroup);
     ReadDataArgument();
     }else{
       while (!vtData->Eof){
       ReadDataFormula(GetCodeTemplate(),vtData->FieldByName("mid")->AsInteger);
       vtData->Next();
       }
     }
     vtData->First();
     vtData->EnableControls();
     ColPresed=false;

  }catch(Exception &e){
    vtData->EnableControls();
    Application->ShowException(&e);
  }
  
}
 //---------------------------------------------------------------------------


void __fastcall TfmDetailPoint::cbMeasChange(TObject *Sender)
{
    vRefresh(this);
}
//---------------------------------------------------------------------------
  bool __fastcall TfmDetailPoint::GetQuality(char *isvalid)
  {

    int flag;
  //  if(!FormSetupMonitors->RadioGroupShowValidity->ItemIndex)
  //      return false;
    flag=0;
  // if (FormSetupMonitors->RadioGroupShowValidity->ItemIndex == 1)
   //   {
          if(isvalid[0]!='\0')  //проверка правильности каждого символа в строке метки качества
           {
             if(StrToInt(isvalid[0])<0 ||StrToInt(isvalid[0])>3)
             flag=1;
             for(int n=1 ; n<=11; n++)
             {
             if(StrToInt(isvalid[n])!=0&&StrToInt(isvalid[n])!=1)
             flag=1;
             }

             for(int n=12; n<20; n++)
             {
              if(StrToInt(isvalid[n])<0||StrToInt(isvalid[n])>3)
              flag=1;
              }
             if(StrToInt(isvalid[21])<0 ||StrToInt(isvalid[21])>8)
              flag=1;
              
             if(isvalid[22]=='\0') isvalid[22]='0';
             if(StrToInt(isvalid[22])!=0&&StrToInt(isvalid[22])!=1)
             {
             flag=1;
             }
           }else  flag=1;
     //  }else  flag=1;

    return !flag;
 }
 //--------------------------------------------------------------------------------

