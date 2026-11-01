//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "unDataMod.h"
#include "FindPoint.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TfmFindPoint *fmFindPoint=NULL;
const AnsiString pageDelim = "/";
const AnsiString addedContext = "***";
const AnsiString tripleNullContext = "000";
//---------------------------------------------------------------------------
__fastcall TfmFindPoint::TfmFindPoint(TComponent* Owner,bool isGroup)
   : TForm(Owner)
{
  ReplaceRyda(this,BASE_SCHEME,SchemeName);
  iFound=0;
  cid=0;
  IsGroup=isGroup;
  GroupsAndPoints = false;
  myContext = 0;
  myAddContext = 0;
  oldFind = 0;
  //GRB ADD 18.02.2021
  findedId = new TStringList();
  Edit6->Text = "0"+pageDelim+"0";
  UpDown1->Enabled = false;
  enabledAllFields();
  //END ADD
}
//---------------------------------------------------------------------------
void __fastcall TfmFindPoint::bbOkClick(TObject *Sender)
{
  //Старый вариант поиска с выбором по одному узлу по каждому нажатию на кнопку "Найти" - оставим для истории
  /*dmMain->quMain->Params->Clear();
  dmMain->quMain->SQL->Text="begin :par5:="+SchemeName+"editfeeders_pg.findpoint(:par1, :par2, :par3, :par4,:par6,:par7,:par8,:par9); end;";
  dmMain->quMain->ParamByName("par1")->AsInteger=iFound;
  dmMain->quMain->ParamByName("par2")->AsString=Edit1->Text;
  dmMain->quMain->ParamByName("par3")->AsString=Edit2->Text;
  dmMain->quMain->ParamByName("par4")->AsString=Edit3->Text;
  dmMain->quMain->ParamByName("par6")->AsString=Edit4->Text;
  if(IsGroup)
    if (cid == 0)   // вернется id группы
      dmMain->quMain->ParamByName("par7")->AsInteger=1;
    else            // вернется id канала
      dmMain->quMain->ParamByName("par7")->AsInteger=2;
  else
    if (cid == 0)   // вернется id группы
      dmMain->quMain->ParamByName("par7")->Clear();
    else            // вернется id канала
      dmMain->quMain->ParamByName("par7")->AsInteger=2;
  dmMain->quMain->ParamByName("par8")->AsString=Edit5->Text;
  dmMain->quMain->ParamByName("par5")->DataType=ftInteger;
  dmMain->quMain->ParamByName("par5")->ParamType=ptOutput;
  dmMain->quMain->ParamByName("par9")->AsString=Edit25->Text;
  dmMain->quMain->Execute();
  iFound=dmMain->quMain->ParamByName("par5")->AsInteger;
 if(iFound)
   PostMessage( (dynamic_cast<TWinControl*>(Owner))->Handle,WM_SETACTIVENODE,(WPARAM)0,(LPARAM)iFound);
 else
   MessageBox(Handle,Reconst_smes32_1.c_str(),Application->Title.c_str(),MB_OK|MB_ICONINFORMATION); */

   //GRB 18.02.2021 REWRITE
   //02.04.2021 - Для исправления бага с переключкой с 000 на без них и назад в контексте дерева групп и точек;
   if (GroupsAndPoints){
        myContext = 0;
        myAddContext = 0;
   }
   Edit6->Text = "0"+pageDelim+"0";
   AnsiString lang = getCurrLang();
   bool isAnyFieldSet = isAnyTextFieldSet();
   if (isAnyFieldSet){  //есть хотя бы одно введённое поле
        bool in_obj = false;// проверяем введённую комбинацию на доп.контексты
        if (isAnyAddedContext(&in_obj)){ // есть *** в полях
           if (!isOnlyOneAddedContext()){
                AnsiString messageNoGo = "Допустимо использование *** не более, чем в одном поле поиска!";
                if (lang == "UKR") messageNoGo = "Припустимо використання *** не більше, чим в одному полі пошуку!";
                MessageBox(Handle,messageNoGo.c_str(),Application->Title.c_str(),MB_OK|MB_ICONINFORMATION);
                return;
           }
           if (in_obj){
                //тут обрабатывать будем доп.контекст когда *** в ид.объекта торчит
                //Делаем приобразование контексту 1->11, 2->22, 3->33
                //int test = myContext + (myContext*10); так херово
                int test = myContext;
                switch (test){
                case 1: { myAddContext = 11; break;}
                case 2: {myAddContext = 22; break;}
                case 3: {myAddContext = 33; break;}
                defalut:{ myAddContext = 0;}
                }
                myContext = test;
                //сделали
           }else{
                //А тут доп контекст для плана рассылки макетов и прочее такое если ещё будет
                //MessageBox(Handle,"Доп.контекст в Плане Рассылки макетов",Application->Title.c_str(),MB_OK|MB_ICONINFORMATION);
                //return;
                myAddContext = 0;
           }

        }else{  // нету *** в полях
                myAddContext = 0;
        }
        if ((GroupsAndPoints)&&((myContext == 0)||(myContext == 1))) {//дерево групп и точек
        int _tripleNullContext = wereTripleNullInContext();//а эту проверку нужно делать только когда мы в дереве групп и точек!
          if (_tripleNullContext==-1){
                AnsiString messageNoGo1 = "Ключ поиска 000 должен быть либо в поле 'ид. объекта', либо в поле 'ид. точки(доп.)', но не в обоих сразу!";
                if (lang == "UKR") messageNoGo1 = "Ключ пошука 000 має бути або у полі 'ід. об`єкту' або у полі 'ід. точки (доп.)', але не в обох відразу!";
                  MessageBox(Handle,messageNoGo1.c_str(),Application->Title.c_str(),MB_OK|MB_ICONINFORMATION);
                  return;
          }
          if (_tripleNullContext==1){
                myAddContext = 0;
          }
          if (_tripleNullContext==2){
                myAddContext = 1;
                myContext = 1;
          }
          if (_tripleNullContext==0){
                myAddContext = 0;     // тут блин вопрос 0 или 1?
          }
        }
        //обычный контекст
        //15.04.2021 - старый хелп для фильтров в контексте
        long size =  0;
        if (oldFind){
        findAllNodes();
        size = findedId->Count;
        }else
        size = findAllNodesCur();
        if (!size){
          shapedByRedElement(Edit6);
        }else{
          unshapeElement(Edit6);
        }
        bool find = setInitialPaging (findedId);
   }else{
   AnsiString needMinOne = "Нужно задать хотя бы одно поле для поиска";
   if (lang == "UKR") needMinOne = "Треба задати хоча б одне поле для пошука";
   MessageBox(Handle,needMinOne.c_str(),Application->Title.c_str(),MB_OK|MB_ICONINFORMATION);
   }
}
//---------------------------------------------------------------------------
void __fastcall TfmFindPoint::EditChange(TObject *Sender)
{
  iFound=0;
}
//---------------------------------------------------------------------------
void TfmFindPoint::SetChannel(int ch)
{
  cid = ch;
}
//---------------------------------------------------------------------------
void __fastcall TfmFindPoint::UpDown1ChangingEx(TObject *Sender,
      bool &AllowChange, short NewValue, TUpDownDirection Direction)
{
  AllowChange = false;
  const int offset = pageDelim.Length();
  AnsiString sValue = Edit6->Text;
  sValue.Delete(sValue.Pos(pageDelim), sValue.Length());//удаляем всё до
  bool was_move = false;
  if(Direction == 1){   //вправо
    if (StrToInt(sValue) < UpDown1->Max){
    was_move = true;
    Edit6->Text = IntToStr(StrToInt(sValue)+UpDown1->Increment)+pageDelim+IntToStr (UpDown1->Max);
    sValue = IntToStr (StrToInt(sValue)+UpDown1->Increment);
    }
    }
  if(Direction == 0){ //влево
    if (StrToInt(sValue)>UpDown1->Min){
    was_move = true;
    Edit6->Text = IntToStr(StrToInt(sValue)-UpDown1->Increment)+pageDelim+IntToStr (UpDown1->Max);
    sValue = IntToStr (StrToInt(sValue)-UpDown1->Increment);
    }
    }
   //открываем текущий, если в хранилище id что-то есть
   if ((findedId->Count!=0)&&(was_move)){
      int pos = StrToInt(sValue);
      AnsiString s_curr_id = findedId->Strings[pos-1];
      long i_curr_id = StrToInt64 (s_curr_id);
      if (i_curr_id) {
      if (!GroupsAndPoints)
        PostMessage( (dynamic_cast<TWinControl*>(Owner))->Handle,WM_SETACTIVENODE,(WPARAM)0,(LPARAM)i_curr_id);    //Мотаем если не группы и точки вместе
      else{
        int _tripleNullContext = wereTripleNullInContext();//а эту проверку нужно делать только когда мы в дереве групп и точек!   //если вместе
        if (_tripleNullContext==2)
                PostMessage( (dynamic_cast<TWinControl*>(Owner))->Handle,WM_SETACTIVENODE,(WPARAM)1,(LPARAM)i_curr_id); //ищем по группе
        else
                PostMessage( (dynamic_cast<TWinControl*>(Owner))->Handle,WM_SETACTIVENODE,(WPARAM)0,(LPARAM)i_curr_id);  //ищем там по точке
      }
   }

 }
}
//---------------------------------------------------------------------------
void __fastcall TfmFindPoint::findAllNodes(){
  if (findedId!=NULL)
    findedId->Clear();
    do{
        dmMain->quMain->Params->Clear();
        dmMain->quMain->SQL->Text="begin :par5:="+SchemeName+"editfeeders_pg.findpoint(:par1, :par2, :par3, :par4,:par6,:par7,:par8,:par9); end;";
        dmMain->quMain->ParamByName("par1")->AsInteger=iFound;
        dmMain->quMain->ParamByName("par2")->AsString=Edit1->Text;
        dmMain->quMain->ParamByName("par3")->AsString=Edit2->Text;
        dmMain->quMain->ParamByName("par4")->AsString=Edit3->Text;
        dmMain->quMain->ParamByName("par6")->AsString=/*Edit4->Text;*/Edit9->Text;
        if(IsGroup)
                if (cid == 0)   // вернется id группы
                        dmMain->quMain->ParamByName("par7")->AsInteger=1;
                else            // вернется id канала
                        dmMain->quMain->ParamByName("par7")->AsInteger=2;
        else
                if (cid == 0)   // вернется id группы
                        dmMain->quMain->ParamByName("par7")->Clear();
                else            // вернется id канала
                        dmMain->quMain->ParamByName("par7")->AsInteger=2;
        dmMain->quMain->ParamByName("par8")->AsString=Edit5->Text;
        dmMain->quMain->ParamByName("par5")->DataType=ftInteger;
        dmMain->quMain->ParamByName("par5")->ParamType=ptOutput;
        dmMain->quMain->ParamByName("par9")->AsString=Edit25->Text;
        dmMain->quMain->Execute();
        iFound=dmMain->quMain->ParamByName("par5")->AsInteger;
        if (iFound)
        findedId->Add(IntToStr(iFound));
  }while (iFound!=0);
}
//---------------------------------------------------------------------------
long __fastcall TfmFindPoint::findAllNodesCur (){
        findedId->Clear();
        dmMain->quMain->Params->Clear();
        //dmMain->quMain->SQL->Text="begin "+SchemeName+"editfeeders_pg.findpoint2(:an_pointtype, :av_name, :av_code, :av_mtrsn,:av_pmid,:av_canal,:av_account, :av_shortname, :av_note, :av_gid, :acur_t); end;";
        //изменение av_gid удаляем за ненадобностью
        dmMain->quMain->SQL->Text="begin "+SchemeName+"editfeeders_pg.findpoint(:an_pointtype, :av_pmid, :av_name, :av_shortname, :av_code, :av_mtrsn,:av_canal,:av_account,  :av_note, :av_vcode, :av_vimportcode, :acur_t); end;";
        dmMain->quMain->ParamByName("av_name")->AsString=Edit1->Text;
        dmMain->quMain->ParamByName("av_code")->AsString=Edit2->Text;
        dmMain->quMain->ParamByName("av_mtrsn")->AsString=Edit3->Text;
        if (GroupsAndPoints){  ///дерева групп и точек
        if ( (wereTripleNullInContext() == 1) ) {//случай 000 в контексте  дерева групп и точек
                dmMain->quMain->ParamByName("av_pmid")->AsString=Edit4->Text;

        }
        if ( (wereTripleNullInContext() == 2) ){
        dmMain->quMain->ParamByName("av_pmid")->AsString=Edit9->Text;
        }
        if ( (wereTripleNullInContext() == 0) ){
        dmMain->quMain->ParamByName("av_pmid")->AsString=Edit9->Text;
        }
        }
        else
        dmMain->quMain->ParamByName("av_pmid")->AsString=Edit9->Text;

        switch (myContext){
                case 0: {
                dmMain->quMain->ParamByName("an_pointtype")->Clear();
                break;
                }
                default: {
                if (myAddContext!=0)
                dmMain->quMain->ParamByName("an_pointtype")->AsInteger = myAddContext;
                else
                dmMain->quMain->ParamByName("an_pointtype")->AsInteger = myContext;
                break;
                }
        }
        dmMain->quMain->ParamByName("av_canal")->AsString=Edit5->Text;
        dmMain->quMain->ParamByName("av_account")->AsString=Edit25->Text;
        dmMain->quMain->ParamByName("av_shortname")->AsString=Edit7->Text;
        dmMain->quMain->ParamByName("av_note")->AsString=Edit8->Text;

        //dmMain->quMain->ParamByName("av_gid")->AsString=Edit4->Text;
        dmMain->quMain->ParamByName("av_vcode")->AsString = Edit11->Text;
        dmMain->quMain->ParamByName("av_vimportcode")->AsString = Edit10->Text;
        dmMain->quMain->ParamByName("acur_t")->DataType=ftCursor;
        dmMain->quMain->ParamByName("acur_t")->ParamType=ptOutput;
        if ( (GroupsAndPoints) &&((wereTripleNullInContext() == 2))){
          dmMain->quMain->ParamByName("an_pointtype")->AsInteger =1;
          /*dmMain->quMain->ParamByName("av_code")->AsString= "";
          dmMain->quMain->ParamByName("av_mtrsn")->AsString="";
          dmMain->quMain->ParamByName("av_canal")->AsString="";
          dmMain->quMain->ParamByName("av_account")->AsString="";
          dmMain->quMain->ParamByName("av_note")->AsString="";
          dmMain->quMain->ParamByName("av_vimportcode")->AsString="";
          dmMain->quMain->ParamByName("av_vcode")->AsString = "";*/
        }
        try{
        AnsiString lang = getCurrLang();
        correctParamsProcForTaskContext (myContext, myAddContext,GroupsAndPoints,lang);
        }  catch (Exception &ex){
                ShowMessage (ex.Message.c_str());
                return 0;
        }
        try{// делаем обработку на отсутствие editfeeders_pg.findpoint2 в БД - если нет то дёргаем старую editfeeders_pg.findpoint в цикле
        dmMain->quMain->Execute();
        } catch (EOraError &ex){
         //findAllNodes();
         ShowMessage (ex.Message.c_str());
        }
        while (!dmMain->quMain->Eof){
          AnsiString str = dmMain->quMain->FieldByName("mid")->AsString;
          findedId->Add (str);
          dmMain->quMain->Next();
        }
        return findedId->Count;
}
bool __fastcall TfmFindPoint::setInitialPaging(TStringList* findedId){
  bool ret = false;
  if (findedId->Count!=0){
    if (UpDown1->Min!=UpDown1->Max)
    UpDown1->Min = 1;
    UpDown1->Max = findedId->Count;
    Edit6->Text = IntToStr (UpDown1->Min) + pageDelim + IntToStr (UpDown1->Max);
    UpDown1->Enabled = true;
    //А тут раскрываем 1-й элемент сразу
    AnsiString s_first_id = findedId->Strings[0];
    long i_first_id = StrToInt64 (s_first_id);

    if (!GroupsAndPoints)
        PostMessage( (dynamic_cast<TWinControl*>(Owner))->Handle,WM_SETACTIVENODE,(WPARAM)0,(LPARAM)i_first_id);    //Мотаем если не группы и точки вместе
      else{
        int _tripleNullContext = wereTripleNullInContext();//а эту проверку нужно делать только когда мы в дереве групп и точек!   //если вместе
        if (_tripleNullContext==2)
                PostMessage( (dynamic_cast<TWinControl*>(Owner))->Handle,WM_SETACTIVENODE,(WPARAM)1,(LPARAM)i_first_id);
        else
                PostMessage( (dynamic_cast<TWinControl*>(Owner))->Handle,WM_SETACTIVENODE,(WPARAM)0,(LPARAM)i_first_id);
      }
  }else{
    UpDown1->Enabled = false;
    Edit6->Text = "0" + pageDelim + "0";
    MessageBox(Handle,Reconst_smes32_1.c_str(),Application->Title.c_str(),MB_OK|MB_ICONINFORMATION);
  }
  //GRB ADD - фиксим бажик с нахождением чего-то после того как нашелся 1 элемент 09.03.2021
  if ((findedId->Count == 0)|| (findedId->Count == 1))
     UpDown1->Enabled = false;
  if (findedId->Count > 1)
     UpDown1->Enabled = true;
  //end add
  return ret;
}
//---------------------------------------------------------------------------
bool __fastcall TfmFindPoint::isAnyTextFieldSet(){
   bool ret = false;
   if (!Edit1->Text.IsEmpty()){ //Наименование
        ret = true;
        return ret;
   }
   if (!Edit7->Text.IsEmpty()){ //Краткое имя
        ret = true;
        return ret;
   }
   if (!Edit8->Text.IsEmpty()){ //Примечание
        ret = true;
        return ret;
   }
   if (!Edit3->Text.IsEmpty()){ //Номер счётчика
        ret = true;
        return ret;
   }
   if (!Edit9->Text.IsEmpty()){ //Ид. объекта
        ret = true;
        return ret;
   }
   if (!Edit5->Text.IsEmpty()){ //Связной номер
        ret = true;
        return ret;
   }
   if (!Edit2->Text.IsEmpty()){ //Код точки
        ret = true;
        return ret;
   }
   if (!Edit25->Text.IsEmpty()){ //Лиц. счёт
        ret = true;
        return ret;
   }
   if (!Edit4->Text.IsEmpty()){ //Ид.точки (доп)
        ret = true;
        return ret;
   }
   if (!Edit10->Text.IsEmpty()){ //Связной код импорта
        ret = true;
        return ret;
   }
   if (!Edit11->Text.IsEmpty()){ //Код строки в макете
        ret = true;
        return ret;
   }
   return ret;
}
//---------------------------------------------------------------------------

bool __fastcall TfmFindPoint::isAnyAddedContext(bool *in_idobj){
   bool ret = false;
   *in_idobj = false;
   if (CompareText(Edit1->Text,addedContext)==0){ //Наименование
        ret = true;
        return ret;
   }
   if (CompareText(Edit7->Text,addedContext)==0){ //Краткое имя
        ret = true;
        return ret;
   }
   if (CompareText(Edit8->Text,addedContext)==0){ //Примечание
        ret = true;
        return ret;
   }
   if (CompareText(Edit3->Text,addedContext)==0){ //Номер счётчика
        ret = true;
        return ret;
   }
   if (CompareText(Edit9->Text,addedContext)==0){ //Ид. объекта
        ret = true;
        *in_idobj = true;
        return ret;
   }
   if (CompareText(Edit5->Text,addedContext)==0){ //Связной номер
        ret = true;
        return ret;
   }
   if (CompareText(Edit2->Text,addedContext)==0){ //Код точки
        ret = true;
        return ret;
   }
   if (CompareText(Edit25->Text,addedContext)==0){ //Лиц. счёт
        ret = true;
        return ret;
   }
   if (CompareText(Edit4->Text,addedContext)==0){ //Ид.точки (доп)
        ret = true;
        return ret;
   }
   if (CompareText(Edit10->Text,addedContext)==0){ //Связной код импорта
        ret = true;
        return ret;
   }
   if (CompareText(Edit11->Text,addedContext)==0){ //Код строки в макете
        ret = true;
        return ret;
   }
   return ret;

}
//---------------------------------------------------------------------------

bool __fastcall TfmFindPoint::isOnlyOneAddedContext(){
   bool ret = false;
   int countedAddedContext = 0;
   if (CompareText(Edit1->Text,addedContext)==0){ //Наименование
       countedAddedContext++;
   }
   if (CompareText(Edit7->Text,addedContext)==0){ //Краткое имя
        countedAddedContext++;
   }
   if (CompareText(Edit8->Text,addedContext)==0){ //Примечание
        countedAddedContext++;
   }
   if (CompareText(Edit3->Text,addedContext)==0){ //Номер счётчика
        countedAddedContext++;
   }
   if (CompareText(Edit9->Text,addedContext)==0){ //Ид. объекта
        countedAddedContext++;
   }
   if (CompareText(Edit5->Text,addedContext)==0){ //Связной номер
        countedAddedContext++;
   }
   if (CompareText(Edit2->Text,addedContext)==0){ //Код точки
        countedAddedContext++;
   }
   if (CompareText(Edit25->Text,addedContext)==0){ //Лиц. счёт
        countedAddedContext++;
   }
   if (CompareText(Edit4->Text,addedContext)==0){ //Ид.точки (доп)
        countedAddedContext++;
   }
   if (CompareText(Edit10->Text,addedContext)==0){ //Связной код импорта
        countedAddedContext++;
   }
   if (CompareText(Edit11->Text,addedContext)==0){ //Код строки в макете
        countedAddedContext++;
   }
   if (countedAddedContext == 1)
      ret = true;
   return ret;
}
//---------------------------------------------------------------------------
void  __fastcall TfmFindPoint::setContext (int context){
        myContext = context;
}
//---------------------------------------------------------------------------
void __fastcall TfmFindPoint::setGroupsAndPoints (bool groupsAndPoints){
        GroupsAndPoints = groupsAndPoints;
}
//---------------------------------------------------------------------------

int __fastcall TfmFindPoint::wereTripleNullInContext(){
        int ret_code = -1; //гипотеза nogo
        if ( (CompareText(Edit9->Text,tripleNullContext)==0)&&(CompareText(Edit4->Text,tripleNullContext)==0))
                return ret_code;  //невозможный контекст - nogo
        if (CompareText(Edit9->Text,tripleNullContext)==0){
                ret_code = 1;   //000 в id объекта
                return ret_code;
        }
        if (CompareText(Edit4->Text,tripleNullContext)==0){
                ret_code = 2;  //000 в id точки
                return ret_code;
        }
        ret_code = 0;   //не нашли такого
        return ret_code;
}
//---------------------------------------------------------------------------

AnsiString __fastcall TfmFindPoint::getCurrLang(){
  AnsiString Language;
  TRegistry *Reg = new TRegistry(KEY_READ);
  try{
        Reg->RootKey =HKEY_LOCAL_MACHINE;
        Reg->Access=KEY_READ;
        Reg->OpenKey("SOFTWARE\\INTEP\\ASKUE", False);
        Language = Reg->ReadString("Language");
        if(!Language.Length()){
            char c[256];
            GetLocaleInfo(GetSystemDefaultLCID(), LOCALE_SABBREVLANGNAME, c, sizeof(c));
            Language=c;
        }
  }__finally{
        delete Reg;
  }
  return Language;
}
//---------------------------------------------------------------------------
void __fastcall TfmFindPoint::shapedByRedElement(TEdit *elem){

  elem->Color= clRed;
  elem->Repaint();
}
//---------------------------------------------------------------------------
void __fastcall TfmFindPoint::unshapeElement(TEdit *elem){
  elem->Color= clGreen;
  elem->Repaint();
}
//---------------------------------------------------------------------------
void __fastcall TfmFindPoint::unshapeElementByDefault (TEdit* elem){
  elem->Color= clWindow;
  elem->Repaint();
}
//---------------------------------------------------------------------------
void __fastcall TfmFindPoint::correctParamsProcForTaskContext(Integer task_context, Integer add_task_context, bool groops_and_points, AnsiString lang){  //cм окончательную редакцию вовыной таблицы контекстов для задачи
  if ((task_context == NULL) && (!groops_and_points) ) return; //- для дерева точек разрешено всё
  if (!groops_and_points){// для несоставных деревьев
        if ((task_context == 1) &&(add_task_context!=11)){   //группы учёта - разрешено ид объекта наименование и короткое имя
                dmMain->quMain->ParamByName("av_code")->AsString= "";
                dmMain->quMain->ParamByName("av_mtrsn")->AsString="";
                dmMain->quMain->ParamByName("av_canal")->AsString="";
                dmMain->quMain->ParamByName("av_account")->AsString="";
                dmMain->quMain->ParamByName("av_note")->AsString="";
                dmMain->quMain->ParamByName("av_vimportcode")->AsString="";
                dmMain->quMain->ParamByName("av_vcode")->AsString = "";
                if ((Edit9->Text.IsEmpty()) && (Edit1->Text.IsEmpty()) && (Edit7->Text.IsEmpty())){
                 AnsiString mes = "Нужно задать хотя бы одно из поисковых полей 'Ид.объекта', 'Наименование', 'Краткое имя'";
                 if (CompareStr(lang,"UKR")==0)
                        mes = "Треба задати хоча б одне з пошукових полів 'Ід.об'єкта', 'Найменування', 'Коротке ім'я'";
                 throw Exception (mes);
                }

                return;
        }
        if (add_task_context==11){// группы учёта в которые входит ТУ - разрешено ид объекта и код точки
                dmMain->quMain->ParamByName("av_name")->AsString="";
                dmMain->quMain->ParamByName("av_shortname")->AsString = "";
                dmMain->quMain->ParamByName("av_mtrsn")->AsString="";
                dmMain->quMain->ParamByName("av_canal")->AsString="";
                dmMain->quMain->ParamByName("av_account")->AsString="";
                dmMain->quMain->ParamByName("av_note")->AsString="";
                dmMain->quMain->ParamByName("av_vimportcode")->AsString="";
                dmMain->quMain->ParamByName("av_vcode")->AsString = "";
                //13.04.2021 GRB FIX по просьбе Кальницкой - Излишне строгая проверка тк в Edit9 ***, а надо проверять Edit4
                //if ((Edit9->Text.IsEmpty()) && (Edit2->Text.IsEmpty())){
                 if ((Edit4->Text.IsEmpty()) && (Edit2->Text.IsEmpty())){
                 AnsiString mes = "Нужно задать хотя бы одно из поисковых полей 'Ид.объекта', 'Код точки'";
                 if (CompareStr(lang,"UKR")==0)
                        mes = "Треба задати хоча б одне з пошукових полів 'Ід.об'єкта', 'Код точки'";
                 throw Exception (mes);
                }
                if ((Edit2->Text.Pos("*")!=0) ||(Edit2->Text.Pos("%")!=0)){
                 AnsiString mes = "Уберите все символы '*' или '%' из поискового поля 'Код точки'";
                 if (CompareStr(lang,"UKR")==0)
                        mes = "Приберіть всі символи '*' або '%' з пошукового поля 'Код точки'";
                 throw Exception (mes);
                }
                if (!Edit4->Text.IsEmpty()){ //есть что-то в ид доп точки
                   dmMain->quMain->ParamByName("av_pmid")->AsString = Edit4->Text;
                }else{
                   dmMain->quMain->ParamByName("av_pmid")->AsString = "";
                }

                return;

        }
        if ((task_context == 2) &&(add_task_context!=22)){  //Канал опроса
                dmMain->quMain->ParamByName("av_shortname")->AsString = "";
                dmMain->quMain->ParamByName("av_code")->AsString= "";
                dmMain->quMain->ParamByName("av_mtrsn")->AsString="";
                dmMain->quMain->ParamByName("av_canal")->AsString="";
                dmMain->quMain->ParamByName("av_account")->AsString="";
                dmMain->quMain->ParamByName("av_vimportcode")->AsString="";
                dmMain->quMain->ParamByName("av_vcode")->AsString = "";

                if ((Edit9->Text.IsEmpty()) && (Edit1->Text.IsEmpty()) && (Edit8->Text.IsEmpty())){
                 AnsiString mes = "Нужно задать хотя бы одно из поисковых полей 'Ид.объекта', 'Наименование', 'Примечание'";
                 if (CompareStr(lang,"UKR")==0)
                        mes = "Треба задати хоча б одне з пошукових полів 'Ід.об'єкта', 'Найменування', 'Примітка'";
                 throw Exception (mes);
                 }

                return;
         }
        if (add_task_context==22){  //Каналы опроса ТУ
                dmMain->quMain->ParamByName("av_name")->AsString="";
                dmMain->quMain->ParamByName("av_shortname")->AsString = "";
                dmMain->quMain->ParamByName("av_mtrsn")->AsString="";
                dmMain->quMain->ParamByName("av_canal")->AsString="";
                dmMain->quMain->ParamByName("av_account")->AsString="";
                dmMain->quMain->ParamByName("av_note")->AsString="";
                dmMain->quMain->ParamByName("av_vimportcode")->AsString="";
                dmMain->quMain->ParamByName("av_vcode")->AsString = "";
                if ((Edit9->Text.IsEmpty()) && (Edit2->Text.IsEmpty())){
                 AnsiString mes = "Нужно задать хотя бы одно из поисковых полей 'Ид.объекта', 'Код точки'";
                 if (CompareStr(lang,"UKR")==0)
                        mes = "Треба задати хоча б одне з пошукових полів 'Ід.об'єкта', 'Код точки'";
                 throw Exception (mes);
                }
                if ((Edit2->Text.Pos("*")!=0) ||(Edit2->Text.Pos("%")!=0)){
                 AnsiString mes = "Уберите все символы '*' или '%' из поискового поля 'Код точки'";
                 if (CompareStr(lang,"UKR")==0)
                        mes = "Приберіть всі символи '*' або '%' з пошукового поля 'Код точки', 'Код точки'";
                 throw Exception (mes);

                }
                if (!Edit4->Text.IsEmpty()){ //есть что-то в ид доп точки
                   dmMain->quMain->ParamByName("av_pmid")->AsString = Edit4->Text;
                }else{
                   dmMain->quMain->ParamByName("av_pmid")->AsString = "";
                }
                return;
         }
         if (((task_context==22)&&(add_task_context==0))){// пришли из фильтра по каналам в оперативном опросе
                dmMain->quMain->ParamByName("av_name")->AsString="";
                dmMain->quMain->ParamByName("av_shortname")->AsString = "";
                dmMain->quMain->ParamByName("av_mtrsn")->AsString="";
                dmMain->quMain->ParamByName("av_canal")->AsString="";
                dmMain->quMain->ParamByName("av_account")->AsString="";
                dmMain->quMain->ParamByName("av_note")->AsString="";
                dmMain->quMain->ParamByName("av_vimportcode")->AsString="";
                dmMain->quMain->ParamByName("av_vcode")->AsString = "";
                if ((Edit9->Text.IsEmpty()) && (Edit2->Text.IsEmpty())){
                 AnsiString mes = "Нужно задать хотя бы одно из поисковых полей 'Ид.объекта', 'Код точки'";
                 if (CompareStr(lang,"UKR")==0)
                        mes = "Треба задати хоча б одне з пошукових полів 'Ід.об'єкта', 'Код точки'";
                 throw Exception (mes);
                }
                if ((Edit2->Text.Pos("*")!=0) ||(Edit2->Text.Pos("%")!=0)){
                 AnsiString mes = "Уберите все символы '*' или '%' из поискового поля 'Код точки'";
                 if (CompareStr(lang,"UKR")==0)
                        mes = "Приберіть всі символи '*' або '%' з пошукового поля 'Код точки', 'Код точки'";
                 throw Exception (mes);

                }
                return;
         }
         if ((task_context == 3) &&(add_task_context!=33)){  //Каналы рассылки
                dmMain->quMain->ParamByName("av_shortname")->AsString = "";
                dmMain->quMain->ParamByName("av_code")->AsString= "";
                dmMain->quMain->ParamByName("av_mtrsn")->AsString="";
                dmMain->quMain->ParamByName("av_canal")->AsString="";
                dmMain->quMain->ParamByName("av_account")->AsString="";
                dmMain->quMain->ParamByName("av_vimportcode")->AsString="";
                dmMain->quMain->ParamByName("av_vcode")->AsString = "";
                if ((Edit9->Text.IsEmpty()) && (Edit1->Text.IsEmpty()) && (Edit8->Text.IsEmpty())){
                 AnsiString mes = "Нужно задать хотя бы одно из поисковых полей 'Ид.объекта', 'Наименование', 'Примечание'";
                 if (CompareStr(lang,"UKR")==0)
                        mes = "Треба задати хоча б одне з пошукових полів 'Ід.об'єкта', 'Найменування', 'Примітка'";
                 throw Exception (mes);
                }
                return;
         }
          if (add_task_context==33){  //Каналы рассылки доп контекст
                dmMain->quMain->ParamByName("av_shortname")->AsString = "";
                dmMain->quMain->ParamByName("av_code")->AsString= "";
                dmMain->quMain->ParamByName("av_mtrsn")->AsString="";
                dmMain->quMain->ParamByName("av_canal")->AsString="";
                dmMain->quMain->ParamByName("av_account")->AsString="";
                dmMain->quMain->ParamByName("av_vimportcode")->AsString="";
                dmMain->quMain->ParamByName("av_vcode")->AsString = "";
                if ((Edit9->Text.IsEmpty()) && (Edit1->Text.IsEmpty()) && (Edit8->Text.IsEmpty())){
                 AnsiString mes = "Нужно задать хотя бы одно из поисковых полей 'Ид.объекта', 'Наименование', 'Примечание'";
                 if (CompareStr(lang,"UKR")==0)
                        mes = "Треба задати хоча б одне з пошукових полів 'Ід.об'єкта', 'Найменування', 'Примітка'";
                 throw Exception (mes);
                }
                if ((Edit2->Text.Pos("*")!=0) ||(Edit2->Text.Pos("%")!=0) || (Edit8->Text.Pos("*")!=0) || (Edit8->Text.Pos("%")!=0)){
                 AnsiString mes = "Уберите все символы '*' или '%' из поисковых полей 'Код точки','Примечание'";
                 if (CompareStr(lang,"UKR")==0)
                        mes = "Приберіть всі символи '*' або '%' з пошукових полів 'Код точки','Примітка'";
                 throw Exception (mes);

                }
                if (!Edit4->Text.IsEmpty()){ //есть что-то в ид доп точки
                   dmMain->quMain->ParamByName("av_pmid")->AsString = Edit4->Text;
                }else{
                   dmMain->quMain->ParamByName("av_pmid")->AsString = "";
                }
                return;
          }
  }else{ //для деревьев групп и точек
    if (task_context==1){
        dmMain->quMain->ParamByName("av_code")->AsString= "";
        dmMain->quMain->ParamByName("av_mtrsn")->AsString="";
        dmMain->quMain->ParamByName("av_canal")->AsString="";
        dmMain->quMain->ParamByName("av_account")->AsString="";
        dmMain->quMain->ParamByName("av_note")->AsString="";
        dmMain->quMain->ParamByName("av_vimportcode")->AsString="";
        dmMain->quMain->ParamByName("av_vcode")->AsString = "";
        if ((Edit9->Text.IsEmpty()) && (Edit1->Text.IsEmpty()) && (Edit7->Text.IsEmpty())){
                 AnsiString mes = "Нужно задать хотя бы одно из поисковых полей 'Ид.объекта', 'Наименование', 'Краткое имя'";
                 if (CompareStr(lang,"UKR")==0)
                        mes = "Треба задати хоча б одне з пошукових полів 'Ід.об'єкта', 'Найменування', 'Коротке ім'я'";
                 throw Exception (mes);
        }
        return;
    }
  }
}

void __fastcall TfmFindPoint::enabledAllFields(){
        Edit1->ReadOnly = false;
        Edit7->ReadOnly = false;
        Edit8->ReadOnly = false;
        Edit3->ReadOnly = false;
        Edit9->ReadOnly = false;
        Edit2->ReadOnly = false;
        Edit5->ReadOnly = false;
        Edit25->ReadOnly = false;
        Edit4->ReadOnly = false;
        Edit10->ReadOnly = false;
        Edit11->ReadOnly = false;
}





void __fastcall TfmFindPoint::BitBtn1Click(TObject *Sender)
{
Edit1->Clear();
Edit7->Clear();
Edit8->Clear();
Edit3->Clear();
Edit9->Clear();
Edit5->Clear();
Edit2->Clear();
Edit25->Clear();
Edit4->Clear();
Edit10->Clear();
Edit11->Clear();
Edit6->Clear();
unshapeElementByDefault(Edit6);
Edit6->Text = "0"+pageDelim+"0";
//02.04.2021 - Для исправления бага с переключкой с 000 на без них и назад в контексте дерева групп и точек;
if (GroupsAndPoints){
        myContext = 0;
        myAddContext = 0;
}
UpDown1->Enabled = false;
Edit1->SetFocus();
}
//---------------------------------------------------------------------------
void TfmFindPoint::setOldFind (int of){
oldFind = of;
}
//---------------------------------------------------------------------------

