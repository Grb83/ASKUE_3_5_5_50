//---------------------------------------------------------------------------

#ifndef FindPointH
#define FindPointH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Buttons.hpp>
#include <ExtCtrls.hpp>
#include <ComCtrls.hpp>
#define WM_SETACTIVENODE (WM_USER+211)
//---------------------------------------------------------------------------
class TfmFindPoint : public TForm
{
__published:	// IDE-managed Components
  TEdit *Edit1;
  TEdit *Edit2;
  TEdit *Edit3;
  TLabel *Label1;
  TLabel *Label2;
  TLabel *Label3;
  TEdit *Edit4;
  TLabel *Label4;
  TLabel *Label5;
  TEdit *Edit5;
  TLabel *Label40;
  TEdit *Edit25;
  TPanel *Panel1;
  TBitBtn *bbOk;
  TBitBtn *bbCancel;
        TGroupBox *GroupBox1;
        TEdit *Edit6;
        TUpDown *UpDown1;
        TEdit *Edit7;
        TLabel *Label6;
        TEdit *Edit8;
        TLabel *Label7;
        TLabel *Label8;
        TEdit *Edit9;
        TEdit *Edit10;
        TLabel *Label9;
        TEdit *Edit11;
        TLabel *Label10;
        TBitBtn *BitBtn1;
        TGroupBox *GroupBox2;
   void __fastcall bbOkClick(TObject *Sender);
  void __fastcall EditChange(TObject *Sender);
        void __fastcall UpDown1ChangingEx(TObject *Sender,
          bool &AllowChange, short NewValue, TUpDownDirection Direction);
        void __fastcall BitBtn1Click(TObject *Sender);
private:
  /*int*/ long iFound;
  bool IsGroup;
  int cid;
  bool GroupsAndPoints; // ...а также признак того что мы в дереве и групп и точек (true) либо нет (false)
  int myContext;//[0,1,11,2,22,3,33] - допустимое множество конечных вариантов, а приходит в сеттере что-то из множества [0, 1, 2, 3]
  int myAddContext; //[0, 11, 22, 33] - устанавливаем по умолчанию в 0, если находим такой контекст то ставим в не ноль и ищем по нему а не по myContext. Сам пришедший из сетера myContext НЕ МЕНЯЕМ!
  //а везде по коду перед вызовом fmFP->ShowModal дёргаем сетеры setContext и setGroupsAndPoints
  public:		// User declarations
  int oldFind;
   long currPos;
     //GRB ADD 18.02.2021
  TStringList *findedId;     //храним все найденные по критерию айдишники тут
  __fastcall void findAllNodes ();//ищем все узлы тут  получаем по одному ответу - как код в старом bbOkClick, только зацикленный - промежуточное решение для совместимости со старым наполнением базы
  __fastcall long findAllNodesCur ();//ищем все узлы тут - используем новую процедуру Хомича, получаем все ответы за раз, возвращаем сколько нашли
  __fastcall bool isAnyTextFieldSet(); // проверяем что хотя бы одно поле для ввода заполнено перед вызовом процедуры Хомича, чтобы не получить вообще все точки
  __fastcall bool isAnyAddedContext(bool *in_idobj); // проверяем что есть хотя бы одно заполненое юзером поле с "***" - доп.контекстом, и устанавливает внутри себя переданное ей in_idobj в true если контекст *** находится в поле ид.объекта, если контекста нет или он не там - то сбрасывает его в false
  __fastcall bool isOnlyOneAddedContext(); // проверяем что таких полей не больше одного за сеанс - иначе запрещаем передавать в процедуру
  __fastcall int wereTripleNullInContext (); // контекст наличия 000 то ли в id объекта то ли в id точки - только для дерева групп и точек - ручные ввода и редактор формул. Возвращает [[-1 - невозможное сочетание - и там и там],0 - не нашел, 1 - "000" в id объекта, 2 - "000" в id точек
  __fastcall AnsiString getCurrLang();
  __fastcall void shapedByRedElement(TEdit* elem);
  __fastcall void unshapeElement(TEdit* elem);
  __fastcall void unshapeElementByDefault (TEdit* elem);
  __fastcall bool setInitialPaging(TStringList* findedId);//если что-то нашли меняем значение в поле эдита результатов и min/max пейджинатора, возвращаем true если нашли хоть что-то
   __fastcall TfmFindPoint(TComponent* Owner,bool isGroup=false);
   __fastcall void setContext (int context);
   __fastcall void setGroupsAndPoints (bool groupsAndPoints);
   __fastcall void correctParamsProcForTaskContext(int task_context, int add_task_context, bool groops_and_points, AnsiString lang);     //тут будем устанавливать входные параметры вовыной процедуры поиска на нулл исходя из контекста задачи и генерить эксепшины если не задано хотя бы одно ключевое поле
   __fastcall void enabledAllFields();
   void SetChannel(int ch);
   //GRB ADD 15.04.2021
   void setOldFind (int of);
};
//---------------------------------------------------------------------------
extern PACKAGE TfmFindPoint *fmFindPoint;
//---------------------------------------------------------------------------
#endif
