//---------------------------------------------------------------------------
#include <vcl.h>
#include <utilcls.h>
#pragma hdrstop
#include "unDataMod.h"
#include "InteriorExRepOut.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------

/*! Внутренний класс
*/
class TInteriorExRepOutPriv
{
public:
  /*! Конструктор, где:
      \param ffname - полное имя файла
  */
  TInteriorExRepOutPriv(AnsiString ffname)
    :xlMaximized(0xFFFFEFD7), xlMinimized(0xFFFFEFD4), xlNormal(0xFFFFEFD1)
    ,xlAutoActivate(3), xlAutoClose(2), xlAutoDeactivate(4), xlAutoOpen(1)
    ,sheetindex(1)
  { disconnectEx();
    fullname  = ffname;
    fname     = ExtractFileName(ffname);
  }
  ~TInteriorExRepOutPriv()
  { disconnectEx();
  }

  /*! Присоединение к Excel'ю или запуск нового
  */
  bool __fastcall connectEx();
  /*! Отсоединение от Excel, где:
      \param fclose - признак закрытия Excel (default - false)

      Если \b fclose равен true, то Excel закрывается и происходит
        отсоединение от него, иначе только онсоединение.
  */
  void __fastcall disconnectEx(bool fclose = false);
  /*! Передача фокуса и управления в Excel
  */
  void __fastcall SwitchToExcel();
  /*! Отбражение Excel'а
  */
  bool __fastcall visibleEx();
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
  /*! \overload
      Выбор необходимой страницы по индексу, где:
      \param sheetnum - индекс необходимой страницы
  */
  bool __fastcall setSheet(int sheetnum);
  /*! Активация страницы, где:
      \param sheetnum - индекс необходимой страницы

      \return true если нужная страница выбрана, иначе - false.

      \attention вслучае активации страницы переменная \b sheet
        принимает значение данной страницы, иначе ей присваивается
        значение \b Null()
  */
  bool __fastcall activateSheet(int sheetnum);

  Variant excel;    //===== Объект Excel'я
  Variant book;     //===== Объект загруженная WorkBook
  Variant sheet;    //===== Объект текущей страницы

  AnsiString  fullname;   //===== Полное имя файла шаблона
  AnsiString  fname;      //===== Только имя файла шаблона

  int sheetindex;   //===== Индекс текущей страницы

  void __fastcall RunMacros(AnsiString aMacrosName);

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
bool __fastcall TInteriorExRepOutPriv::connectEx()
{
  if (isConnected())
    return  true;
  bool  fNew  = false;    //===== признак вновь открытого Excel
  try
  { try
    { excel = Variant::GetActiveObject("Excel.Application");
    }
    catch (Exception &e)
    { fNew  = true;
      excel = Variant::CreateObject("Excel.Application");
    }
    if(!fNew){
      try{
        excel.OlePropertyGet("Workbooks").OleProcedure("Open", WideString(fullname));
      }catch(Exception &e){
        throw Exception(Reconst_smes115_1+e.Message);
      }
    }else
      excel.OlePropertyGet("Workbooks").OleProcedure("Open", WideString(fullname));
    book  = excel.OlePropertyGet("Workbooks", WideString(fname));
    book.OleProcedure("RunAutoMacros", Variant(xlAutoOpen));
    book.OleProcedure("RunAutoMacros", Variant(xlAutoActivate));
    visibleEx();
  }
  catch(Exception &e){
    Application->ShowException(&e);
    disconnectEx(fNew);
  }

  return  isConnected();
}
//---------------------------------------------------------------------------
void __fastcall TInteriorExRepOutPriv::disconnectEx(bool fclose)
{
  if (fclose)
  { try
    { if (isConnected())
      { excel.OleProcedure("Quit");
      }
    }
    catch (Exception &e)
    { Application->MessageBox(Application->Title.c_str(),
                              Reconst_smes115_2.c_str(),
                              MB_OK | MB_ICONWARNING);
    }
  }
  excel = Unassigned;
  excel = Null();
  book  = Null();
  sheet = Null();
}
//---------------------------------------------------------------------------
static BOOL CALLBACK EnumWindowsProc(HWND hwnd, LPARAM lParam)
{
  //Процедура для перечисления открытых окон в Windows и нахождение окна с "Отчеты (АСКУЭ)"
  static char WinName[15];
  if (GetWindowText(hwnd, WinName, sizeof(WinName)) && strcmp(Reconst_smes115_5.c_str(), WinName) == 0)
  { if (GetClassName(hwnd, WinName, sizeof(WinName)) && strcmp("XLMAIN", WinName) == 0)
    { *((HWND *)lParam) = hwnd;
      return  false;
    }
    else
      return  true;
  }
  else
    return  true;
}
//---------------------------------------------------------------------------
void __fastcall TInteriorExRepOutPriv::SwitchToExcel()
{
  HWND  hWnd  = NULL;
  EnumWindows((WNDENUMPROC)EnumWindowsProc, (LPARAM)&hWnd);
  if (hWnd != NULL)
    BringWindowToTop(hWnd);
}
//---------------------------------------------------------------------------
bool __fastcall TInteriorExRepOutPriv::visibleEx()
{
  bool  f = true;
  if (!isConnected())
    return  false;
  try{
    excel.OlePropertySet("Caption", WideString(Reconst_smes115_5));
    excel.OlePropertySet("DisplayFullScreen", Variant(false));
    excel.OlePropertySet("Visible", Variant(true));
    if (excel.OlePropertyGet("WindowState") == xlMinimized)
      excel.OlePropertySet("WindowState", xlNormal);
    excel.OlePropertySet("ScreenUpdating", Variant(true));
    book.OleProcedure("RunAutoMacros", Variant(xlAutoOpen));
    book.OleProcedure("RunAutoMacros", Variant(xlAutoActivate));
    //Application->BringToFront();
  }catch (Exception &e){
    f = false;
    Application->ShowException(&e);
  }
  return  f;
}
//---------------------------------------------------------------------------
bool __fastcall TInteriorExRepOutPriv::setSheet(AnsiString sheetname)
{
  sheet = Null();
  try
  { if (!isConnected())
      return  false;


    Variant tVar  = book.OlePropertyGet("Worksheets");    //===== Доступ к листам
    int tCnt  = tVar.OlePropertyGet("Count");             //===== Количество листов
    //===== Перебор всех листов в поисках необходимого
    for (int i = 1; i <= tCnt; ++i){
      if (tVar.OlePropertyGet("Item", Variant(i)).OlePropertyGet("Name") == sheetname){
        sheet = tVar.OlePropertyGet("Item", Variant(i));
        break;
      }
    }
    if(VarIsNull(sheet))
      sheet = book.OlePropertyGet("Worksheets", WideString(sheetname));
  }
  catch (Exception &e)
  { sheet = Null();
  }
  return  !VarIsNull(sheet);
}
//---------------------------------------------------------------------------
bool __fastcall TInteriorExRepOutPriv::setSheet(int sheetnum)
{
  sheet = Null;
  try
  { if (isConnected())
      sheet = book.OlePropertyGet("Worksheets").OlePropertyGet("Item", Variant(sheetnum));
  }
  catch (Exception &e)
  { sheet = Null;
  }
  return  !VarIsNull(sheet);
}
//---------------------------------------------------------------------------
bool __fastcall TInteriorExRepOutPriv::activateSheet(int sheetnum)
{
  sheet = Null();
  try
  { if (!setSheet(sheetnum))
      return  false;

    AnsiString  tName = sheet.OlePropertyGet("Name");
    if ((tName != "Сценарий") && (tName != "Имя БД") && (tName != "repfilenamedlg"))
    { sheet.OleProcedure("Activate");
      sheetindex  = sheet.OlePropertyGet("Index");
    }
  }
  catch (Exception &e)
  { sheet = Null();
  }
  return  !VarIsNull(sheet);
}
//---------------------------------------------------------------------------

void __fastcall TInteriorExRepOutPriv::RunMacros(AnsiString aMacrosName)
{
  if (!isConnected())
    throw Exception(Reconst_smes115_6);
  AnsiString s(fname+"!"+aMacrosName);
//  AnsiString s("bench95.xlt!"+aMacrosName);
//  AnsiString s(fullname+"!"+aMacrosName);
                                                        
  excel.OleProcedure("Run", Variant(s));
}
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------

/*! Интерьер для генерации отчета во внешнем Excel'e
    Сделан по аналогии TInteriorExRep
*/

__fastcall TInteriorExRepOut::TInteriorExRepOut(TComponent* Owner,TSplitterForm *aSP,TFormDescr* aFD,Classes::TNotifyEvent OnProgr):
	TInterior(Owner,aSP,aFD,OnProgr )
{
  if (!dynamic_cast<TWinControl *>(Owner))
  { OnProgressBarStepBy(NULL);
    throw Exception(Reconst_smes115_7);
  }
  AnsiString gn = fd->NameGroup;
  gn = StringReplace(gn,"/","_",TReplaceFlags() << rfReplaceAll);
  gn = StringReplace(gn,"*","_",TReplaceFlags() << rfReplaceAll);
  gn = StringReplace(gn,"\\","_",TReplaceFlags() << rfReplaceAll);
  gn = StringReplace(gn,"\"","_",TReplaceFlags() << rfReplaceAll);
  gn = StringReplace(gn,"\'","_",TReplaceFlags() << rfReplaceAll);
  AnsiString fn = ExtractFileName(ExFileFullName).SubString(1,ExtractFileName(ExFileFullName).LowerCase().Pos(".xls")-1);
  fn = ExtractFilePath(ExFileFullName)+fn;
  fn = fn+"_"+ gn;
  fn = fn+"_"+Now().FormatString("ddmmyy_hhnnss");
  if(FileExists(fn+".xls")){
    for(int i=0;i<1000;i++){
     if(!FileExists(fn+"_"+IntToStr(i)+".xls")){
      fn=fn+IntToStr(i);
      break;
     }
    }
  }
  fn = fn+".xls";
  RenameFile(ExFileFullName, fn);
  d = new TInteriorExRepOutPriv(fn);
}

//---------------------------------------------------------------------------
void __fastcall TInteriorExRepOut::PassParamsToExcel()
{
  try
  { //===== Присоедининяемся к необходимому листу
    if (!d->setSheet("Сценарий"))
      throw Exception(Reconst_smes113_4);

    //===== Заносим Ид группы в ячейку С9
    d->sheet.OlePropertyGet("Cells", 9, 3).OlePropertySet("Value", Variant(fd->IdGroup));
    //===== Заносим дату начала в ячейку С10
    d->sheet.OlePropertyGet("Cells", 10, 3).OlePropertySet("Value", WideString(FormatDateTime("dd.mm.yyyy hh:nn", fd->DateTimePar)));
    //===== Заносим дату конца в ячейку C11
    d->sheet.OlePropertyGet("Cells", 11, 3).OlePropertySet("Value", WideString(FormatDateTime("dd.mm.yyyy hh:nn", fd->DateTime)));
  }
  catch (Exception &e)
  { Application->ShowException(&e);
    throw;
  }
}
//---------------------------------------------------------------------------
void __fastcall TInteriorExRepOut::PassParamsToExcelAndRefr()
{
  try
  { //===== Формирование параметров
    PassParamsToExcel();

    //===== Присоедининяемся к необходимому листу
    if (!d->setSheet("Имя БД"))
      throw Exception(Reconst_smes113_5);

    //===== Запись строки связи с БД в ячейку B4
    d->sheet.OlePropertyGet("Cells", 4, 2).OlePropertySet("Value", WideString(dmMain->orases->Server));
    //===== Инициация запуска генерации отчета
    //===== Запись в ячейку B7 любых данных
     d->sheet.OlePropertyGet("Range", "B7").OleProcedure("Clear");
//    d->activateSheet(1);
  }
  catch (Exception &e)
  { Application->ShowException(&e);
  }
}

//---------------------------------------------------------------------------
void __fastcall TInteriorExRepOut::Place(void)
{
  try
  { //===== Если не подключились, то делать нечего ;-)
    if (!d->connectEx())
      throw Exception(Reconst_smes115_8);

    Application->ProcessMessages();

    PassParamsToExcelAndRefr();
 //   d->RunMacros("RunReport");
    d->SwitchToExcel();

  }
  catch (Exception &e)
  { Application->ShowException(&e);
  }
}
//---------------------------------------------------------------------------
__fastcall TInteriorExRepOut::~TInteriorExRepOut(void)
{
  delete  d;
  d = NULL;
}
//---------------------------------------------------------------------------

