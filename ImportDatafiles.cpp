//---------------------------------------------------------------------------
#include <vcl.h>
#include <stdio.h>
#include <registry.hpp>
#include "selectpoint.h"
#include <utilcls.h>
#pragma hdrstop
#include "ImportDatafiles.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
//#pragma link "Excel_97_SRVR"
#pragma link "DBAccess"
#pragma link "MemDS"
#pragma link "Ora"
#pragma resource "*.dfm"
//---------------------------------------------------------------------------
#define REG_KEY "SOFTWARE\\HARTEP\\ASKUE\\ImportDatafiles\\SL7000"
#define REG_TitlesWorksheet "TitlesWorksheet"
#define REG_DataWorksheetTemplate "DataWorksheetTemplate"
#define REG_IntervalEnd "IntervalEnd"
#define REG_posActivePlusRow    "posActivePlusRow"
#define REG_posActivePlusCol    "posActivePlusCol"
#define REG_posActiveMinusRow   "posActiveMinusRow"
#define REG_posActiveMinusCol   "posActiveMinusCol"
#define REG_posReactivePlusRow  "posReactivePlusRow"
#define REG_posReactivePlusCol  "posReactivePlusCol"
#define REG_posReactiveMinusRow "posReactiveMinusRow"
#define REG_posReactiveMinusCol "posReactiveMinusCol"
#define REG_usevth "usevth"
#define REG_NLS_LANGUAGE "NLS_LANGUAGE"
#define nRUSSIAN "Русский"
#define nENGLISH "Английский"

//---------------------------------------------------------------------------
/*! Внутренний класс
*/
class TImportDatafilesFormPriv
{
public:
  /*! Конструктор, где:
      \param ffname - полное имя файла
  */
  TImportDatafilesFormPriv()
    :xlMaximized(0xFFFFEFD7), xlMinimized(0xFFFFEFD4), xlNormal(0xFFFFEFD1)
    ,xlAutoActivate(3), xlAutoClose(2), xlAutoDeactivate(4), xlAutoOpen(1)
  { disconnectEx();
    fullname  = "";
    fname     = "";
  }
  ~TImportDatafilesFormPriv()
  { disconnectEx();
  }

  /*! Присоединение к Excel'ю или запуск нового, где:
      \param ffname - полное имя файла
  */
  bool __fastcall connectEx(AnsiString ffname);
  /*! Отсоединение от Excel, где:
      \param fclose - признак закрытия Excel (default - false)

      Если \b fclose равен true, то Excel закрывается и происходит
        отсоединение от него, иначе только онсоединение.
  */
  void __fastcall disconnectEx(bool fclose = false);
  /*! Проверка на присоединение к Excel

      \return true вслучае присоединения, иначе - false.
  */
  bool __fastcall isConnected()
  { return  !(VarIsNull(excel) || VarIsNull(book));
  }
  /*! выбор необходимой страницы Excel, где:
      \param sheetname - Строка с наименованием необходимой страницы

      \return true если нужная страница выбрана, иначе - false.

      \attention вслучае выбора страницы переменная \b sheet
        принимает значение данной страницы, иначе ей присваивается
        значение \b Null()
  */
  bool __fastcall setSheet(AnsiString sheetname);
  bool __fastcall setSheet(int sheetnum);
  /*! Закрытие книги, где:
      \param fclose - признак сохранения книги
  */
  void __fastcall closeBook(bool fclose);

  Variant excel;    //===== Объект Excel'я
  Variant book;     //===== Объект загруженная WorkBook
  Variant sheet;    //===== Объект текущей страницы 

  AnsiString  fullname;   //===== Полное имя файла шаблона
  AnsiString  fname;      //===== Только имя файла шаблона

private:
  const int xlMaximized;
  const int xlMinimized;
  const int xlNormal;
  const int xlAutoActivate;
  const int xlAutoClose;
  const int xlAutoDeactivate;
  const int xlAutoOpen;
};
//---------------------------------------------------------------------------
bool __fastcall TImportDatafilesFormPriv::connectEx(AnsiString ffname)
{
  fullname  = ffname;
  fname     = ExtractFileName(ffname);

  bool  fNew  = false;    //===== признак вновь открытого Excel
  try
  { if (!isConnected())
    { try
      { excel = Variant::GetActiveObject("Excel.Application");
      }
      catch (Exception &e)
      { fNew  = true;
        excel = Variant::CreateObject("Excel.Application");
      }
    }
    excel.OlePropertyGet("Workbooks").OleProcedure("Open", WideString(fullname));
    book  = excel.OlePropertyGet("Workbooks", WideString(fname));
    book.OleProcedure("RunAutoMacros", Variant(xlAutoOpen));
    book.OleProcedure("RunAutoMacros", Variant(xlAutoActivate));
    //visibleEx();
  }
  catch (Exception &e)
  { Application->ShowException(&e);
    disconnectEx(fNew);
  }

  return  isConnected();
}
//---------------------------------------------------------------------------
void __fastcall TImportDatafilesFormPriv::disconnectEx(bool fclose)
{
  if (fclose)
  { try
    { closeBook(false);
      if (!VarIsNull(excel))
      { //excel.OleProcedure("Quit");
        if (excel.OlePropertyGet("Workbooks").OlePropertyGet("Count") > 0)
        { excel.OlePropertySet("WindowState", xlMinimized);
          excel.OlePropertySet("Visible", Variant(true));
        }
        else
          excel.OleProcedure("Quit");
      }
      Application->BringToFront();
    }
    catch (Exception &e)
    { Application->MessageBox(Application->Title.c_str(),
                             Reconst_smes35_3.c_str(),
                              MB_OK | MB_ICONWARNING);
    }
  }
  excel = Unassigned;
  excel = Null();
  book  = Null();
  sheet = Null();
}
//---------------------------------------------------------------------------
bool __fastcall TImportDatafilesFormPriv::setSheet(AnsiString sheetname)
{
  sheet = Null();
  try
  { if (!isConnected())
      return  false;

    sheet = book.OlePropertyGet("Worksheets", WideString(sheetname));
  }
  catch (Exception &e)
  { sheet = Null();
  }
  return  !VarIsNull(sheet);
}
//---------------------------------------------------------------------------
bool __fastcall TImportDatafilesFormPriv::setSheet(int sheetnum)
{
  sheet = Null();
  try
  { if (!isConnected())
      return  false;

    sheet = book.OlePropertyGet("Worksheets").OlePropertyGet("Item", Variant(sheetnum));
  }
  catch (Exception &e)
  { sheet = Null();
  }
  return  !VarIsNull(sheet);
}
//---------------------------------------------------------------------------
void __fastcall TImportDatafilesFormPriv::closeBook(bool fclose)
{
  if (VarIsNull(book))
    return;
  try
  { book.OleProcedure("RunAutoMacros", Variant(xlAutoClose));
    book.OleProcedure("RunAutoMacros", Variant(xlAutoDeactivate));
    book.OleProcedure("Close", Variant(fclose));
  }
  catch (Exception &e)
  { Application->ShowException(&e);
  }
  book  = Null();
}
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------



//---------------------------------------------------------------------------
typedef char dateline[32];
TSL7000Params SL7000Params;
//---------------------------------------------------------------------------
inline TSL7000Params::TSL7000Params()
{
  TitlesWorksheet=Reconst_smes35_6;
  //posActivePlus="A1";      posActiveMinus="A2";
  //posReactivePlus="A3";    posReactiveMinus="A4";
  posActivePlusRow    = "1";
  posActivePlusCol    = "1";
  posActiveMinusRow   = "2";
  posActiveMinusCol   = "1";
  posReactivePlusRow  = "3";
  posReactivePlusCol  = "1";
  posReactiveMinusRow = "4";
  posReactiveMinusCol = "1";

  DataWorksheetTemplate = "DD Month YYYY \"г\".";
  NLS_LANGUAGE  = "RUSSIAN";
  TimeStep      = "Interval End";
}
//---------------------------------------------------------------------------
__fastcall TImportDatafilesForm::TImportDatafilesForm(TComponent* Owner,AnsiString Name,TType t,TAccess a)
   : TMainForm(Owner, Name, a)
{
   //pXlsAppl = new TExcelApplication(this);
   //pXlsWkbk = new TExcelWorkbook(this);
   //pXlsWksh = new TExcelWorksheet(this);

   d  = new TImportDatafilesFormPriv();

   cbLangSel->ItemIndex = 0;
   cbFileType->ItemIndex = (int)t-1;
   Type = t;
   iaParams->OnUpdate = vUpdate;
}
//---------------------------------------------------------------------------

__fastcall TImportDatafilesForm::~TImportDatafilesForm()
{
   SaveParamsInReg();

/*
   delete pXlsWksh;
   pXlsWksh = NULL;

   delete pXlsWkbk;
   pXlsWkbk = NULL;

   if(pXlsAppl){
      if(pXlsAppl->Workbooks->Count>0 && pXlsAppl->Visible[0]==false)
      {
         pXlsAppl->WindowState[0] = xlMinimized;
         pXlsAppl->Visible[0] = true;
         Application->BringToFront();
      }
   }
   delete pXlsAppl;
   pXlsAppl = NULL;
*/
  d->closeBook(false);
  d->disconnectEx(true);
}
//---------------------------------------------------------------------------

void __fastcall TImportDatafilesForm::FormShow(TObject *Sender)
{
   lvFilesChange(Sender, NULL, ctState);
}
//---------------------------------------------------------------------------
// Загрузка выбранных файлов
void __fastcall TImportDatafilesForm::vSave(TObject *Sender)
{
  if(customer_id==1&&MessageBox(Handle,"Выполнить загрузку данных?",Application->Title.c_str(),MB_YESNO | MB_ICONQUESTION | MB_DEFBUTTON1) != IDYES)
    return;

   for(int i=0; i<lvFiles->Items->Count; i++){
      if(lvFiles->Items->Item[i]->ImageIndex==15 || !lvFiles->Items->Item[i]->Selected
         || !((PARAMS*)lvFiles->Items->Item[i]->Data)->mid)
         continue;
      switch(Type){
      case tLGFiles:
         LoadLGFile(*lvFiles->Items->Item[i]);
         break;
      case tSchlumFiles:
         LoadSLFile(*lvFiles->Items->Item[i]);
         break;
      case tAlphaFiles:
         LoadAlphaFile(*lvFiles->Items->Item[i]);
         break;
      case tMaketNEK:
         LoadMaketNEKFile(*lvFiles->Items->Item[i]);
         break;
      case tLGDatagyr:
         LoadLGDatagyrFile(*lvFiles->Items->Item[i]);
         break;;
      case tElvin:
         LoadElvinFile(*lvFiles->Items->Item[i]);
         break;
      case tMercury:
         LoadMercuryFile(*lvFiles->Items->Item[i]);
         break;
      case tCimRdf:
         LoadCimRdfFile(*lvFiles->Items->Item[i]);
         break;
      }
      if(lvFiles->Items->Item[i]->Focused){
         lvFiles->Items->Item[i]->Focused = false;
         lvFiles->Items->Item[i]->Focused = true;
      }
   }
}
//---------------------------------------------------------------------------
// Выбор ФАЙлов
void __fastcall TImportDatafilesForm::vNew(TObject *Sender)
{
   TListItem*li;
   if(!OpenDialog->Execute()) return;
   for(int i=0; i<OpenDialog->Files->Count; i++){
      li = lvFiles->Items->Add();
      li->Caption = OpenDialog->Files->Strings[i];
      li->SubItems->Add(Reconst_smes35_7);
      li->Data = new PARAMS();
      if(Type==tLGFiles)
         GetPoint(li);
      li->Focused = true;
   }
   if(lvFiles->Items->Count)
      iaParams->Enabled = true;
}
//---------------------------------------------------------------------------
// Удалить файлы
void __fastcall TImportDatafilesForm::vDelete(TObject *Sender)
{
   while(lvFiles->Selected){
      if(lvFiles->Selected->Focused)
         lvFiles->Selected->Focused = false;
      lvFiles->Selected->Delete();
   }
   if(!lvFiles->Items->Count){
      iaParams->Enabled = false;
      iaCheck->Enabled = false;
      iaSave->Enabled = false;
      iaDelete->Enabled = false;
      mResult->Lines->Clear();
   }
}
//---------------------------------------------------------------------------
// Удалить все файлы
void __fastcall TImportDatafilesForm::vParams(TObject* Sender)
{
   lvFiles->Items->BeginUpdate();
   lvFiles->Items->Clear();
   mResult->Lines->Clear();
   lvFiles->Items->EndUpdate();

   iaParams->Enabled = false;
   iaSave->Enabled = false;
   iaDelete->Enabled = false;
   iaCheck->Enabled = false;
}
//---------------------------------------------------------------------------
// удаление пункта из списка файлов
void __fastcall TImportDatafilesForm::lvFilesDeletion(TObject *Sender,
      TListItem *Item)
{
   if(Item->Data) {
      delete Item->Data;
      Item->Data = NULL;
   }
}
//---------------------------------------------------------------------------
// Переопределить привязку для Focused файла
void __fastcall TImportDatafilesForm::vCheck(TObject* Sender)
{
   TListItem*li;
   GROUPDATAFORM gdf;

   if(lvFiles->SelCount>0)
      li = lvFiles->Selected;
   else
   {
      li=dynamic_cast<TListItem*>(Sender);
      if(!li) li = lvFiles->ItemFocused;
   }
   if(!li) return;
   gdf.gid = ((PARAMS*)li->Data)->mid;
   gdf.type = (Type == tMaketNEK || Type == tLGDatagyr || Type == tCimRdf) ? 2 : 1;

   TfmSelectPoint*sp = new TfmSelectPoint(this, &gdf);
   if(lvFiles->SelCount>0)
      sp->Caption = Reconst_smes35_8;
   else
      sp->Caption = Reconst_smes35_9+li->Caption+"\"";
      sp->HelpContext=25032;
again:
   if(sp->ShowModal()==mrOk){
      int img = sp->tvMain->Selected->ImageIndex;
      if(img!=0 && img!=1){
         MessageBox(Handle, Reconst_smes35_10.c_str(),
            Reconst_smes35_11.c_str(), MB_OK|MB_ICONINFORMATION);
         goto again;
      }

      do
      {
         li->ImageIndex = 14;
         ((PARAMS*)li->Data)->mid = gdf.gid;
         ((PARAMS*)li->Data)->comm[0] = 0;
         li->SubItems->Strings[0] = sp->mInfoArea->Text;
         repl_delimiters(li->SubItems->Strings[0].c_str(), " ");
         mResult->Lines->Text = "";
         if(lvFiles->SelCount==0)
            break;
         do
         {
            if(li->Index+1 < lvFiles->Items->Count)
               li = lvFiles->Items->Item[li->Index+1];
            else
               li = NULL;
         }while(li && !li->Selected);
         if(!li)break;
      }while(true);
   }
   delete sp;
}
//---------------------------------------------------------------------------
void __fastcall TImportDatafilesForm::cbFileTypeChange(TObject *Sender)
{
   Type = (TType)(cbFileType->ItemIndex+1);
}
//---------------------------------------------------------------------------
void __fastcall TImportDatafilesForm::SetType(TType value)
{
   if(FType!=value){
      switch(value){
      case tLGFiles:
         OpenDialog->Filter = Reconst_smes35_12;
         plStep->Visible = true;
         plStep->Enabled = true;
         plSLParams->Visible = false;
         break;
      case tSchlumFiles:
         OpenDialog->Filter = Reconst_smes35_13;
         plStep->Visible = false;
         plStep->Enabled = false;
         plSLParams->Visible = true;
         cbLangSelChange(cbLangSel);
         break;
      case tAlphaFiles:
         OpenDialog->Filter = Reconst_smes35_12;
         plStep->Visible = false;
         plStep->Enabled = false;
         plSLParams->Visible = false;
         break;
      case tMaketNEK:
         OpenDialog->Filter = Reconst_smes35_12;
         plStep->Visible = false;
         plStep->Enabled = false;
         plSLParams->Visible = false;
         break;
      case tLGDatagyr:
         OpenDialog->Filter = Reconst_smes35_12;
         plStep->Visible = false;
         plStep->Enabled = false;
         plSLParams->Visible = false;
         break;
      case tElvin:
         OpenDialog->Filter = Reconst_smes35_12;
         plStep->Visible = false;
         plStep->Enabled = false;
         plSLParams->Visible = false;
         break;
      case tMercury:
         OpenDialog->Filter = Reconst_smes35_12;
         plStep->Visible = false;
         plStep->Enabled = false;
         plSLParams->Visible = false;
         break;
      }
      iaParams->Execute();
      FType = value;
   }
}
//---------------------------------------------------------------------------
inline TType __fastcall TImportDatafilesForm::GetType()
{
   return FType;
}
//---------------------------------------------------------------------------
void __fastcall TImportDatafilesForm::SetAccess(TAccess value)
{
   if(FAccess!=value){
      TMainForm::SetAccess(value);
      bool wr = value==accWrite;
      iaNew->Enabled = wr;
   }
}
//---------------------------------------------------------------------------
void __fastcall TImportDatafilesForm::lvFilesChanging(TObject *Sender,
      TListItem *Item, TItemChange Change, bool &AllowChange)
{
   if(Change != ctState) return;
   PARAMS*prms = (PARAMS*)Item->Data;
   if(!prms) return;
   prms->sel = Item->Selected;
   prms->foc = Item->Focused;
}
//---------------------------------------------------------------------------
void __fastcall TImportDatafilesForm::lvFilesChange(TObject *Sender,
      TListItem *Item, TItemChange Change)
{
   if(Change != ctState) return;
   PARAMS*prms = Item?(PARAMS*)Item->Data:NULL;
   if(!prms) return;
   if(prms->foc && !Item->Focused){// снятие фокуса
      mResult->Lines->Text = "";
      if(cbInterval->ItemIndex>=0){
         prms->interval = StrToInt(cbInterval->Text);
         cbInterval->ItemIndex = -1;
      }
   }
   if(!prms->foc && Item->Focused){// установка фокуса
      mResult->Lines->Text = prms->comm;
      cbInterval->ItemIndex = cbInterval->Items->IndexOf(IntToStr(prms->interval));
   }
   if(prms->sel != Item->Selected){// изменение выбора
      if(lvFiles->Selected){
         iaCheck->Enabled = true;
         iaSave->Enabled = true;
         iaDelete->Enabled = true;
      }else{
         iaCheck->Enabled = false;
         iaSave->Enabled = false;
         iaDelete->Enabled = false;
      }
   }
}
//---------------------------------------------------------------------------
// Автоматическое определение соответствия с точкой учёта
void __fastcall TImportDatafilesForm::GetPoint(TListItem*li)
{
   TStrings*strs = new TStringList();
   PARAMS*dst = (PARAMS*)li->Data;
   try{
      strs->LoadFromFile(li->Caption);
      oqGetPoint->SQL->Text="begin "+SchemeName+"DATA_IMPORT_PG.GetParamsLG(:par1,:par2,:par3,:par4,:par5); end;";
      oqGetPoint->ParamByName("par1")->AsString=li->Caption;
      oqGetPoint->ParamByName("par2")->Table=true;
      if(!strs->Count){
       oqGetPoint->ParamByName("par2")->Length=1;
      // oqGetPoint->ParamByName("par2")->Clear();
      oqGetPoint->ParamByName("par2")->ItemAsString[1]=0;
      }else{
        oqGetPoint->ParamByName("par2")->Length=strs->Count;
        for(int i=0;i<strs->Count;i++)
          oqGetPoint->ParamByName("par2")->ItemAsString[i+1]=strs->Strings[i];
      }
      strs->Clear();
      oqGetPoint->ParamByName("par3")->ParamType=ptOutput;
      oqGetPoint->ParamByName("par3")->DataType=ftInteger;
      oqGetPoint->ParamByName("par4")->ParamType=ptOutput;
      oqGetPoint->ParamByName("par4")->DataType=ftString;
      oqGetPoint->ParamByName("par5")->ParamType=ptOutput;
      oqGetPoint->ParamByName("par5")->DataType=ftInteger;
      try{
        oqGetPoint->Execute();
        if(!oqGetPoint->ParamByName("par3")->IsNull)
          dst->mid=oqGetPoint->ParamByName("par3")->AsInteger;
        if(!oqGetPoint->ParamByName("par4")->IsNull)
          strcpy(dst->comm,oqGetPoint->ParamByName("par4")->AsString.c_str());
        if(!oqGetPoint->ParamByName("par5")->IsNull)
          dst->interval=oqGetPoint->ParamByName("par5")->AsInteger;
        li->ImageIndex = 14;
      }catch(Exception&e){
        Application->ShowException(&e);
      }
      if(!dst->mid)
         li->ImageIndex = 15;
      repl_delimiters(dst->comm, " ");
      li->SubItems->Strings[0] = dst->comm;
      dst->comm[0] = 0;
   }catch(Exception&e){
      li->ImageIndex = 15;
      li->SubItems->Strings[0] = Reconst_smes35_14;
      strcpy(dst->comm, e.Message.c_str());
      Application->ShowException(&e);
   }
   delete strs;
}
//---------------------------------------------------------------------------
void __fastcall TImportDatafilesForm::cbIntervalChange(TObject *Sender)
{
   for(int i=0; i<lvFiles->Items->Count; i++)
      if(lvFiles->Items->Item[i]->Focused){
      // изменение параметров выделенного файла
         lvFiles->Items->Item[i]->Focused = false;
         lvFiles->Items->Item[i]->Focused = true;
      }
}
//---------------------------------------------------------------------------
void __fastcall TImportDatafilesForm::LoadLGFile(TListItem&li)
{
   TStrings*strs=new TStringList();
   PARAMS params, *pParams=(PARAMS*)li.Data;
   try{
      strs->LoadFromFile(li.Caption);
      if(pParams)
         memcpy(&params, pParams, sizeof(params));
      else
         memset(&params, 0, sizeof(params));
      oqLoadSLFile->SQL->Text="begin "+SchemeName+"DATA_IMPORT_PG.ImportLG(:par1, :par2, :par3, :par4); end;";
      oqLoadSLFile->ParamByName("par1")->AsInteger=params.mid;
      oqLoadSLFile->ParamByName("par2")->Table=true;
      if(!strs->Count){
        oqLoadSLFile->ParamByName("par2")->Length=1;
        //oqLoadSLFile->ParamByName("par2")->Clear();
        oqLoadSLFile->ParamByName("par2")->ItemAsString[1]=0;
      }else{
        oqLoadSLFile->ParamByName("par2")->Length=strs->Count;
        for(int j=0; j<strs->Count; j++)
          oqLoadSLFile->ParamByName("par2")->ItemAsString[j+1]=strs->Strings[j];
      }
      strs->Clear();
      oqLoadSLFile->ParamByName("par3")->AsInteger=params.interval;
      oqLoadSLFile->ParamByName("par4")->ParamType=ptOutput;
      oqLoadSLFile->ParamByName("par4")->DataType=ftString;
      try{
        oqLoadSLFile->Execute();
        strcpy(params.comm,oqLoadSLFile->ParamByName("par4")->AsString.c_str());
        li.ImageIndex = 17;
      }catch(Exception&e){
          strcpy(params.comm,e.Message.c_str());
          li.ImageIndex = 22;
          if(!cbIgnoreError->Checked)
            Application->ShowException(&e);
      }
      li.Selected = false;
   }catch(Exception&e){
      dmMain->orases->Rollback();
      Application->ShowException(&e);
   }
   if(pParams)
      memcpy(pParams, &params, sizeof(params));
   delete strs;
}
//---------------------------------------------------------------------------
void __fastcall TImportDatafilesForm::LoadSLFile(TListItem&li)
{
   TSL7000Params&p=SL7000Params;
   PARAMS params;
   long len=0, high, low, iAp, iAm, iRp, iRm, iTm, lded;
   dateline *times=NULL;
   dateline *chann1=NULL;
   dateline *chann2=NULL;
   dateline *chann3=NULL;
   dateline *chann4=NULL;
   dateline *chann5=NULL;
   dateline *chann6=NULL;
   dateline *chann7=NULL;
   dateline *chann8=NULL;
   dateline data;
   dateline dataformat;
   int usevth=1;

   char result[VARCHAR2LEN];
   long cnt;
   short ind[VARCHAR2LEN];

   long dayCount=0;
   TDates*masDays=NULL;

   try{
      if(p.usevth)
        usevth++;
      if(li.Data)
         memcpy(&params, li.Data, sizeof(params));
      else
         memset(&params, 0, sizeof(params));
      // очистка строки результатов
      params.comm[0]=0;
      getXlsFileData(li.Caption, dayCount, &masDays);
      strcpy(dataformat, p.DataWorksheetTemplate.c_str());
      lded = 0;
      for(int i=0; i<dayCount; i++)
      {
         //Application->HandleMessage();
         strcpy(data, masDays[i].dayDate.c_str());
         if(!masDays[i].dayDates.IsArray())
            continue;
         high = masDays[i].dayDates.ArrayHighBound(2);
         low = masDays[i].dayDates.ArrayLowBound(2);
         iTm = iAp = iAm = iRp = iRm = 0;
         for(int k=low; k<=high; k++){
            if(p.TimeStep == masDays[i].dayDates.GetElement(1, k)) iTm = k;
            if(p.ActivePlus  == masDays[i].dayDates.GetElement(1, k)) iAp = k;
            if(p.ActiveMinus == masDays[i].dayDates.GetElement(1, k)) iAm = k;
            if(p.ReactivePlus== masDays[i].dayDates.GetElement(1, k)) iRp = k;
            if(p.ReactiveMinus==masDays[i].dayDates.GetElement(1, k)) iRm = k;
         }
         if(iTm == 0)
            iTm = 1;
         if(iTm*iAp*iAm*iRp*iRm == 0)
            throw Exception(AnsiString(Reconst_smes35_15)+data);
         high = masDays[i].dayDates.ArrayHighBound();
         low = masDays[i].dayDates.ArrayLowBound();
         cnt = high-low;
         if(len!=(long)cnt){
            if(len>0){
               len = 0;
               delete [] times; times=NULL;
               delete [] chann1; chann1 = NULL;
               delete [] chann2; chann2 = NULL;
               delete [] chann3; chann3 = NULL;
               delete [] chann4; chann4 = NULL;
               delete [] chann5; chann5 = NULL;
               delete [] chann6; chann6 = NULL;
               delete [] chann7; chann7 = NULL;
               delete [] chann8; chann8 = NULL;
            }
            len = cnt;
            if(len>0){
               times = new dateline[len];
               chann1= new dateline[len];
               chann2= new dateline[len];
               chann3= new dateline[len];
               chann4= new dateline[len];
               chann5= new dateline[len];
               chann6= new dateline[len];
               chann7= new dateline[len];
               chann8= new dateline[len];
            }
         }
         for(int j=low+1, ind=0; j<=high; j++, ind++)
         {
            TDateTime date = masDays[i].dayDates.GetElement(j, iTm);
            strncpy(times[ind], date.FormatString("hh:nn:ss").c_str(),30);
            strncpy(chann1[ind], AnsiString(masDays[i].dayDates.GetElement(j, iAp)).c_str(),30);
            strncpy(chann2[ind], AnsiString(masDays[i].dayDates.GetElement(j, iAm)).c_str(),30);
            strncpy(chann3[ind], AnsiString(masDays[i].dayDates.GetElement(j, iRp)).c_str(),30);
            strncpy(chann4[ind], AnsiString(masDays[i].dayDates.GetElement(j, iRm)).c_str(),30);
            chann5[ind][0] = 0;   chann6[ind][0] = 0;
            chann7[ind][0] = 0;   chann8[ind][0] = 0;
         }

         oqLoadFile->SQL->Text="begin "+SchemeName+"DATA_IMPORT_PG.LOADDATABYBILL(:par1, :par2, :par3, :par4, :par5, :par6, :par7, :par8, :par9, :par10, :par11, :par12, :par13); end;";
         oqLoadFile->ParamByName("par1")->AsInteger=params.mid;
         oqLoadFile->ParamByName("par2")->AsString=dataformat;
         oqLoadFile->ParamByName("par3")->AsString=data;
         for(int j=4;j<=12;j++)
           oqLoadFile->ParamByName("par"+IntToStr(j))->Table=true;
         if(len){
           for(int j=4;j<=12;j++)
             oqLoadFile->ParamByName("par"+IntToStr(j))->Length=len;
           for(int k=0; k<len;k++){
            oqLoadFile->ParamByName("par4")->ItemAsString[k+1]=times[k];
            oqLoadFile->ParamByName("par5")->ItemAsString[k+1]=chann1[k];
            oqLoadFile->ParamByName("par6")->ItemAsString[k+1]=chann2[k];
            oqLoadFile->ParamByName("par7")->ItemAsString[k+1]=chann3[k];
            oqLoadFile->ParamByName("par8")->ItemAsString[k+1]=chann4[k];
            oqLoadFile->ParamByName("par9")->ItemAsString[k+1]=chann5[k];
            oqLoadFile->ParamByName("par10")->ItemAsString[k+1]=chann6[k];
            oqLoadFile->ParamByName("par11")->ItemAsString[k+1]=chann7[k];
            oqLoadFile->ParamByName("par12")->ItemAsString[k+1]=chann8[k];
           }
         }else{
           for(int j=4;j<13;j++){
             oqLoadFile->ParamByName("par"+IntToStr(j))->Length=1;
           //  oqLoadFile->ParamByName("par"+IntToStr(j))->Clear();
            oqLoadFile->ParamByName("par"+IntToStr(j))->ItemAsString[1]=0;
           }
         }
         oqLoadFile->ParamByName("par13")->AsInteger=usevth;
     if(len>0){
         try{
         oqLoadFile->Execute();
         lded++;
         }catch(Exception&e){
            strcat(params.comm, Reconst_smes35_16.c_str());
            strcat(params.comm, data);
            strcat(params.comm, "\n");
            strcat(params.comm, e.Message.c_str());
            if(!cbIgnoreError->Checked)
            Application->ShowException(&e);  }
        }
      }
      char tmpline[VARCHAR2LEN];
      sprintf(tmpline, Reconst_smes35_17.c_str(), lded, dayCount-1);
      strcat(params.comm, tmpline);
      li.ImageIndex = 17;
      li.Selected = false;
   }catch(EAccessViolation&e){
      li.ImageIndex = 22;
      Application->ShowException(&Exception(
         Reconst_smes35_18
         ));

   }catch(Exception&e){
      li.ImageIndex = 22;
      strcat(params.comm, e.Message.c_str());
      Application->ShowException(&e);

   }
   if(li.Data)
      memcpy(li.Data, &params, sizeof(params));
   if(len>0){
      len = 0;
      delete [] times; times=NULL;
      delete [] chann1; chann1 = NULL;
      delete [] chann2; chann2 = NULL;
      delete [] chann3; chann3 = NULL;
      delete [] chann4; chann4 = NULL;
      delete [] chann5; chann5 = NULL;
      delete [] chann6; chann6 = NULL;
      delete [] chann7; chann7 = NULL;
      delete [] chann8; chann8 = NULL;
   }
}
//---------------------------------------------------------------------------
void __fastcall TImportDatafilesForm::LoadAlphaFile(TListItem&li)
{
   TStrings*strs=new TStringList();
   PARAMS params, *pParams=(PARAMS*)li.Data;
   try{
      strs->LoadFromFile(li.Caption);
      if(pParams)
         memcpy(&params, pParams, sizeof(params));
      else
         memset(&params, 0, sizeof(params));
      oqLoadSLFile->SQL->Text="begin "+SchemeName+"DATA_IMPORT_PG.import_alpha(:par1, :par2, :par3, :par4); end;";
      oqLoadSLFile->ParamByName("par1")->AsInteger=params.mid;
      oqLoadSLFile->ParamByName("par2")->Table=true;
      if(!strs->Count){
        oqLoadSLFile->ParamByName("par2")->Length=1;
        //oqLoadSLFile->ParamByName("par2")->Clear();
        oqLoadSLFile->ParamByName("par2")->ItemAsString[1]=0;
      }else{
        oqLoadSLFile->ParamByName("par2")->Length=strs->Count;
        for(int j=0; j<strs->Count; j++)
          oqLoadSLFile->ParamByName("par2")->ItemAsString[j+1]=strs->Strings[j];
      }
      strs->Clear();
      oqLoadSLFile->ParamByName("par3")->AsInteger=params.interval;
      oqLoadSLFile->ParamByName("par4")->ParamType=ptOutput;
      oqLoadSLFile->ParamByName("par4")->DataType=ftString;
      try{
        oqLoadSLFile->Execute();
        strcpy(params.comm,oqLoadSLFile->ParamByName("par4")->AsString.c_str());
        li.ImageIndex = 17;
      }catch(Exception&e){
          strcpy(params.comm,e.Message.c_str());
          li.ImageIndex = 22;
          if(!cbIgnoreError->Checked)
            Application->ShowException(&e);
      }
      li.Selected = false;
   }catch(Exception&e){
      dmMain->orases->Rollback();
      Application->ShowException(&e);
   }
   if(pParams)
      memcpy(pParams, &params, sizeof(params));
   delete strs;
}
//---------------------------------------------------------------------------
void __fastcall TImportDatafilesForm::LoadMaketNEKFile(TListItem&li)
{
  PARAMS params, *pParams = (PARAMS*)li.Data;
  try
  {
    if (pParams)
      memcpy(&params, pParams, sizeof(params));
    else
      memset(&params, 0, sizeof(params));
    // находим как грузить, в BLOB или в CLOB
    oqLoadAsBlob->Close();
    oqLoadAsBlob->ParamByName("an_cid")->AsInteger = params.mid;
    oqLoadAsBlob->Execute();
    oqLoadMaketNEKFile->Params->Clear();
    if (oqLoadAsBlob->ParamByName("loadblob")->AsInteger == 1){
      oqLoadMaketNEKFile->SQL->Text="begin "+SchemeName+"comsrvfile_pg.load_file_b(:an_cid,:av_filename,:ad_filedate,:ab_data,:an_auto,:an_operation); end;";
      oqLoadMaketNEKFile->ParamByName("ab_data")->DataType = ftOraBlob;
      oqLoadMaketNEKFile->ParamByName("ab_data")->ParamType = ptInput;
      oqLoadMaketNEKFile->ParamByName("ab_data")->AsOraBlob->LoadFromFile(li.Caption);
    }else{
      oqLoadMaketNEKFile->SQL->Text="begin "+SchemeName+"comsrvfile_pg.load_file_c(:an_cid,:av_filename,:ad_filedate,:ac_data,:an_auto,:an_operation); end;";
      oqLoadMaketNEKFile->ParamByName("ac_data")->DataType = ftOraClob;
      oqLoadMaketNEKFile->ParamByName("ac_data")->ParamType = ptInput;
      oqLoadMaketNEKFile->ParamByName("ac_data")->AsOraClob->LoadFromFile(li.Caption);
    }
    oqLoadMaketNEKFile->ParamByName("an_cid")->AsInteger=params.mid;
    oqLoadMaketNEKFile->ParamByName("av_filename")->AsString=ExtractFileName(li.Caption);
    oqLoadMaketNEKFile->ParamByName("ad_filedate")->AsDateTime=FileDateToDateTime(FileAge(li.Caption));
    oqLoadMaketNEKFile->ParamByName("an_auto")->AsInteger=0;
    oqLoadMaketNEKFile->ParamByName("an_operation")->ParamType = ptOutput;
    oqLoadMaketNEKFile->ParamByName("an_operation")->DataType = ftInteger;

    try
    { oqLoadMaketNEKFile->Execute();
      oqLoadMaketNEKFile->Session->Commit();
      li.ImageIndex = 17;
    }catch(Exception &e)
    { strcpy(params.comm, e.Message.c_str());
      li.ImageIndex = 22;
      if (!cbIgnoreError->Checked)
        Application->ShowException(&e);
    }
    li.Selected = false;
  } catch (Exception&e)
  { dmMain->orases->Rollback();
    Application->ShowException(&e);
  }
  if (pParams)
    memcpy(pParams, &params, sizeof(params));
}
//---------------------------------------------------------------------------
void __fastcall TImportDatafilesForm::LoadLGDatagyrFile(TListItem&li)
{
   PARAMS params, *pParams=(PARAMS*)li.Data;
   try{
      if(pParams)
         memcpy(&params, pParams, sizeof(params));
      else
         memset(&params, 0, sizeof(params));
      oqLoadMaketNEKFile->Params->Clear();
      oqLoadMaketNEKFile->SQL->Text="begin "+SchemeName+"DATA_IMPORT_PG.l_LG(:par1,:par2); end;";
      oqLoadMaketNEKFile->ParamByName("par1")->AsInteger=params.mid;
      oqLoadMaketNEKFile->ParamByName("par2")->DataType = ftOraClob;
      oqLoadMaketNEKFile->ParamByName("par2")->ParamType = ptInput;
      oqLoadMaketNEKFile->ParamByName("par2")->AsOraClob->OCISvcCtx = dmMain->orases->OCISvcCtx;
      oqLoadMaketNEKFile->ParamByName("par2")->AsOraClob->CreateTemporary(ltClob);
      oqLoadMaketNEKFile->ParamByName("par2")->AsOraClob->LoadFromFile(li.Caption);
      oqLoadMaketNEKFile->ParamByName("par2")->AsOraClob->WriteLob();
      try{
        oqLoadMaketNEKFile->Execute();
        li.ImageIndex = 17;
      }catch(Exception&e){
        strcpy(params.comm, e.Message.c_str());
        li.ImageIndex = 22;
        if(!cbIgnoreError->Checked)
          Application->ShowException(&e);
      }
      li.Selected = false;
   }catch(Exception&e){
      dmMain->orases->Rollback();
      Application->ShowException(&e);
   }
   if(pParams)
      memcpy(pParams, &params, sizeof(params));
}
//---------------------------------------------------------------------------
void __fastcall TImportDatafilesForm::LoadCimRdfFile(TListItem&li)
{
   PARAMS params, *pParams=(PARAMS*)li.Data;
   try{
      if(pParams)
         memcpy(&params, pParams, sizeof(params));
      else
         memset(&params, 0, sizeof(params));
      oqLoadMaketNEKFile->Params->Clear();
      oqLoadMaketNEKFile->SQL->Text="begin "+SchemeName+"comsrvrdf_pg.l_cimrdf(:par1,:par2); end;";
      oqLoadMaketNEKFile->ParamByName("par1")->AsInteger=params.mid;
      oqLoadMaketNEKFile->ParamByName("par2")->DataType = ftOraClob;
      oqLoadMaketNEKFile->ParamByName("par2")->ParamType = ptInput;
      oqLoadMaketNEKFile->ParamByName("par2")->AsOraClob->OCISvcCtx = dmMain->orases->OCISvcCtx;
      oqLoadMaketNEKFile->ParamByName("par2")->AsOraClob->CreateTemporary(ltClob);
      oqLoadMaketNEKFile->ParamByName("par2")->AsOraClob->LoadFromFile(li.Caption);
      oqLoadMaketNEKFile->ParamByName("par2")->AsOraClob->WriteLob();
      try{
        oqLoadMaketNEKFile->Execute();
        li.ImageIndex = 17;
      }catch(Exception&e){
        strcpy(params.comm, e.Message.c_str());
        li.ImageIndex = 22;
        if(!cbIgnoreError->Checked)
          Application->ShowException(&e);
      }
      li.Selected = false;
   }catch(Exception&e){
      dmMain->orases->Rollback();
      Application->ShowException(&e);
   }
   if(pParams)
      memcpy(pParams, &params, sizeof(params));
}
//---------------------------------------------------------------------------
void __fastcall TImportDatafilesForm::LoadElvinFile(TListItem&li)
{
   TStrings*strs=new TStringList();
   PARAMS params, *pParams=(PARAMS*)li.Data;
   try{
      strs->LoadFromFile(li.Caption);
      if(pParams)
         memcpy(&params, pParams, sizeof(params));
      else
         memset(&params, 0, sizeof(params));
      oqLoadMaketNEKFile->Params->Clear();
      oqLoadMaketNEKFile->SQL->Text="begin "+SchemeName+"DATA_IMPORT_PG.import_elvin(:par1, :par2, :par3); end;";
      oqLoadMaketNEKFile->ParamByName("par1")->AsInteger=params.mid;
      oqLoadMaketNEKFile->ParamByName("par2")->AsString=ExtractFileName(li.Caption);
      oqLoadMaketNEKFile->ParamByName("par3")->Table=true;
      if(strs->Count){
        oqLoadMaketNEKFile->ParamByName("par3")->Length=strs->Count;
        for(int j=0; j<strs->Count; j++)
          oqLoadMaketNEKFile->ParamByName("par3")->ItemAsString[j+1]=strs->Strings[j].c_str();
      }else{
        oqLoadMaketNEKFile->ParamByName("par3")->Length=1;
       // oqLoadMaketNEKFile->ParamByName("par3")->Clear();
        oqLoadMaketNEKFile->ParamByName("par3")->ItemAsString[1]=0;
      }
      strs->Clear();
      try{
        oqLoadMaketNEKFile->Execute();
        li.ImageIndex = 17;
      }catch(Exception&e){
        strcpy(params.comm, e.Message.c_str());
        li.ImageIndex = 22;
        if(!cbIgnoreError->Checked)
          Application->ShowException(&e);
      }
      li.Selected = false;
   }catch(Exception&e){
      dmMain->orases->Rollback();
      Application->ShowException(&e);
   }
   if(pParams)
      memcpy(pParams, &params, sizeof(params));
   delete strs;
}
//---------------------------------------------------------------------------
void __fastcall TImportDatafilesForm::LoadMercuryFile(TListItem&li)
{
   TStrings*strs=new TStringList();
   PARAMS params, *pParams=(PARAMS*)li.Data;
   try{
      strs->LoadFromFile(li.Caption);
      if(pParams)
         memcpy(&params, pParams, sizeof(params));
      else
         memset(&params, 0, sizeof(params));
      oqLoadMaketNEKFile->Params->Clear();
      oqLoadMaketNEKFile->SQL->Text="begin "+SchemeName+"DATA_IMPORT_PG.import_mercury(:par1, :par2); end;";
      oqLoadMaketNEKFile->ParamByName("par1")->AsInteger=params.mid;
      oqLoadMaketNEKFile->ParamByName("par2")->Table=true;
      if(strs->Count){
        oqLoadMaketNEKFile->ParamByName("par2")->Length=strs->Count;
        for(int j=0; j<strs->Count; j++)
          oqLoadMaketNEKFile->ParamByName("par2")->ItemAsString[j+1]=strs->Strings[j].c_str();
      }else{
        oqLoadMaketNEKFile->ParamByName("par2")->Length=1;
       // oqLoadMaketNEKFile->ParamByName("par2")->Clear();
        oqLoadMaketNEKFile->ParamByName("par2")->ItemAsString[1]=0;
      }
      strs->Clear();
      try{
        oqLoadMaketNEKFile->Execute();
        li.ImageIndex = 17;
      }catch(Exception&e){
        strcpy(params.comm, e.Message.c_str());
        li.ImageIndex = 22;
        if(!cbIgnoreError->Checked)
          Application->ShowException(&e);
      }
      li.Selected = false;
   }catch(Exception&e){
      dmMain->orases->Rollback();
      Application->ShowException(&e);
   }
   if(pParams)
      memcpy(pParams, &params, sizeof(params));
   delete strs;
}
//---------------------------------------------------------------------------
void __fastcall TImportDatafilesForm::getXlsFileData(WideString FullFileName, long&dayCount, TDates**days)
{
  TSL7000Params &p  = SL7000Params;
  AnsiString  sDate;
  //RangePtr usrPtr;

  Variant  vUsrPtr;

  try
  { if (!days)
      throw Exception(Reconst_smes35_20);
    Screen->Cursor = crHourGlass;
    /* Запуск Excel. Новый экземпляр дабы избежать конфликты и не
    закрыть случайно уже запущенный Excel с потерей данных*/

    //pXlsAppl->ConnectKind = ckRunningOrNew;
    //pXlsAppl->Connect();
    // Открытие файла
    //pXlsWkbk->ConnectTo(pXlsAppl->Workbooks->Open(FullFileName));
    if (!d->connectEx(FullFileName))
      throw Exception(Reconst_smes35_21);

    Screen->Cursor = crHourGlass;
    // Считывание параметров каналов
    //for(int z=1; z<=pXlsWkbk->Worksheets->Count; z++){
    //   pXlsWksh->ConnectTo(pXlsWkbk->Worksheets->get_Item(z));
    //   if(p.TitlesWorksheet==pXlsWksh->Name)
    //      break;
    //}
    //if(p.TitlesWorksheet!=pXlsWksh->Name)
    //   throw Exception("Ошибка в формате Excel файла : не найден управляющий лист.");
    if (!d->setSheet(p.TitlesWorksheet))
      throw Exception(Reconst_smes35_22);

    //p.ActivePlus =   pXlsWksh->Get_Range(p.posActivePlus,TNoParam())->get_Value();
    //p.ActiveMinus =  pXlsWksh->Get_Range(p.posActiveMinus,TNoParam())->get_Value();
    //p.ReactivePlus = pXlsWksh->Get_Range(p.posReactivePlus,TNoParam())->get_Value();
    //p.ReactiveMinus =pXlsWksh->Get_Range(p.posReactiveMinus,TNoParam())->get_Value();

    p.ActivePlus    = d->sheet.OlePropertyGet("Cells", Variant(p.posActivePlusRow.ToInt()),
                                                        Variant(p.posActivePlusCol.ToInt())).
                                OlePropertyGet("Value");
    p.ActiveMinus   = d->sheet.OlePropertyGet("Cells", Variant(p.posActiveMinusRow.ToInt()),
                                                        Variant(p.posActiveMinusCol.ToInt())).
                                OlePropertyGet("Value");
    p.ReactivePlus  = d->sheet.OlePropertyGet("Cells", Variant(p.posReactivePlusRow.ToInt()),
                                                        Variant(p.posReactivePlusCol.ToInt())).
                                OlePropertyGet("Value");
    p.ReactiveMinus = d->sheet.OlePropertyGet("Cells", Variant(p.posReactiveMinusRow.ToInt()),
                                                        Variant(p.posReactiveMinusCol.ToInt())).
                                OlePropertyGet("Value");

    Screen->Cursor = crHourGlass;
    // Считывание данных из файла
    //dayCount = pXlsWkbk->Worksheets->Count;
    dayCount  = d->book.OlePropertyGet("Worksheets").OlePropertyGet("Count");
    *days = new TDates[dayCount];
    for (int i = 0; i < dayCount; i++)
    { //pXlsWksh->ConnectTo(pXlsWkbk->Worksheets->get_Item(i+1));
      if (!d->setSheet(i + 1))
        throw Exception(Reconst_smes35_24);
      //sDate = pXlsWksh->Name;
      sDate = d->sheet.OlePropertyGet("Name");
      if (p.TitlesWorksheet == sDate)
        continue;
      //usrPtr  = pXlsWksh->UsedRange[0];
      vUsrPtr = Null();
      vUsrPtr = d->sheet.OlePropertyGet("UsedRange");
      (*days)[i].dayDate  = sDate;
      //if (usrPtr)
      if (!(vUsrPtr.IsNull() || vUsrPtr.IsEmpty()))
      { //int bnds[]  = {1, usrPtr->Columns->Count, 1, usrPtr->Rows->Count};
        //(*days)[i].dayDates = VarArrayCreate(bnds, 1, varDouble);
        //(*days)[i].dayDates = usrPtr->get_Value();
        (*days)[i].dayDates = vUsrPtr.OlePropertyGet("Value");
      }
      else
        (*days)[i].dayDates.Clear();
    }
    //pXlsWkbk->Close(false);
    d->closeBook(false);
    d->disconnectEx(true);
    Screen->Cursor  = crDefault;
  }
  catch (Exception &e)
  { if (*days)
    { delete  [](*days);
      dayCount  = 0;
    }
    //pXlsWkbk->Close(false);
    d->closeBook(false);
    d->disconnectEx(true);
    Screen->Cursor  = crDefault;
    throw Exception(e);
  }
}
//---------------------------------------------------------------------------
void __fastcall TImportDatafilesForm::eDataFmtChange(TObject *Sender)
{
   SL7000Params.DataWorksheetTemplate = eDataFmt->Text;
}
//---------------------------------------------------------------------------
void __fastcall TImportDatafilesForm::eTitlesWorksheetChange(TObject *Sender)
{
   SL7000Params.TitlesWorksheet = eTitlesWorksheet->Text;
}
//---------------------------------------------------------------------------
void __fastcall TImportDatafilesForm::SaveParamsInReg(void)
{
   TSL7000Params&p = SL7000Params;
   TRegistry *Registry = new TRegistry;
   char buf[MAX_PATH];
   try
   {
      Registry->RootKey = HKEY_CURRENT_USER;
      Registry->OpenKey(REG_KEY,true);
      Registry->WriteString(REG_posActivePlusRow, p.posActivePlusRow);
      Registry->WriteString(REG_posActivePlusCol, p.posActivePlusCol);
      Registry->WriteString(REG_posActiveMinusRow, p.posActiveMinusRow);
      Registry->WriteString(REG_posActiveMinusCol, p.posActiveMinusCol);
      Registry->WriteString(REG_posReactivePlusRow, p.posReactivePlusRow);
      Registry->WriteString(REG_posReactivePlusCol, p.posReactivePlusCol);
      Registry->WriteString(REG_posReactiveMinusRow, p.posReactiveMinusRow);
      Registry->WriteString(REG_posReactiveMinusCol, p.posReactiveMinusCol);
      sprintf(buf, "%d", cbLangSel->ItemIndex);
      Registry->OpenKey(buf,true);
      Registry->WriteString(REG_TitlesWorksheet, p.TitlesWorksheet);
      Registry->WriteString(REG_DataWorksheetTemplate, p.DataWorksheetTemplate);
      Registry->WriteString(REG_IntervalEnd, p.TimeStep);
      Registry->WriteString(REG_NLS_LANGUAGE, p.NLS_LANGUAGE);
      Registry->WriteInteger(REG_usevth, p.usevth);
   }
   __finally
   {
      delete Registry;
   }
}
//---------------------------------------------------------------------------
void __fastcall TImportDatafilesForm::LoadParamsFromPeg()
{
   TSL7000Params&p = SL7000Params;
   TRegistry *Registry = new TRegistry;
   char buf[MAX_PATH];
   try
   {
      Registry->RootKey = HKEY_CURRENT_USER;
      if(!Registry->KeyExists(REG_KEY))
         throw Exception(Reconst_smes35_25);
      Registry->OpenKey(REG_KEY,false);
      p.posActivePlusRow    = Registry->ReadString(REG_posActivePlusRow);
      p.posActivePlusCol    = Registry->ReadString(REG_posActivePlusCol);
      p.posActiveMinusRow   = Registry->ReadString(REG_posActiveMinusRow);
      p.posActiveMinusCol   = Registry->ReadString(REG_posActiveMinusCol);
      p.posReactivePlusRow  = Registry->ReadString(REG_posReactivePlusRow);
      p.posReactivePlusCol  = Registry->ReadString(REG_posReactivePlusCol);
      p.posReactiveMinusRow = Registry->ReadString(REG_posReactiveMinusRow);
      p.posReactiveMinusCol = Registry->ReadString(REG_posReactiveMinusCol);
      sprintf(buf, "%d", cbLangSel->ItemIndex);
      if(!Registry->KeyExists(buf)){
         if(cbLangSel->Text==nRUSSIAN) p.NLS_LANGUAGE = "RUSSAIN";
         if(cbLangSel->Text==nENGLISH) p.NLS_LANGUAGE = "ENGLISH";
         throw Exception(Reconst_smes35_25);
      }
      Registry->OpenKey(buf,false);
      p.TitlesWorksheet = Registry->ReadString(REG_TitlesWorksheet);
      p.DataWorksheetTemplate = Registry->ReadString(REG_DataWorksheetTemplate);
      p.TimeStep = Registry->ReadString(REG_IntervalEnd);
      p.NLS_LANGUAGE = Registry->ReadString(REG_NLS_LANGUAGE);
      p.usevth = Registry->ReadInteger(REG_usevth);
      delete Registry;
   }catch(Exception&e){
      delete Registry;
   }
}
//---------------------------------------------------------------------------
void __fastcall TImportDatafilesForm::cbLangSelChange(TObject *Sender)
{
   LoadParamsFromPeg();
   eTitlesWorksheet->Text = SL7000Params.TitlesWorksheet;
   eDataFmt->Text = SL7000Params.DataWorksheetTemplate;
   cbVT->Checked=SL7000Params.usevth;
}
//---------------------------------------------------------------------------
void __fastcall TImportDatafilesForm::cbLangSelDropDown(TObject *Sender)
{
   SaveParamsInReg();
}
//---------------------------------------------------------------------------
void __fastcall TImportDatafilesForm::cbVTClick(TObject *Sender)
{
  SL7000Params.usevth=cbVT->Checked;
}
//---------------------------------------------------------------------------

