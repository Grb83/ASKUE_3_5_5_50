//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
#include "EditTransformers.h"
#include "unDataMod.h"
#include "ParameterPointsList.h"
#include "ChangeTransformers.h"
#include "unWorkTime.h"
#include "ASKUETypes.h"
#include "unSpecParam.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "DBAccess"
#pragma link "MemDS"
#pragma link "Ora"
#pragma resource "*.dfm"
TTransformersForm *TransformersForm;
//---------------------------------------------------------------------------
#define imCFldr 4       //!< Индекс иконки "Закрытая папка"
#define imOFldr 5       //!< Индекс иконки "Открытая папка"
#define imCurrent 24    //!< Индекс иконки "Измерительный трансформатор тока"
#define imVoltage 25    //!< Индекс иконки "Измерительный трансформатор напряжения"
#define imPower2  26    //!< Индекс иконки "Силовой двухобмоточный трансформатор"
#define imPower3  27    //!< Индекс иконки "Силовой трехобмоточный трансформатор"
#define imLine    21    //!< Индекс иконки "Линии"
#define imReactor 28    //!< Индекс иконки "Реактор"
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
/*! Внутренний класс
*/
class TTransformersFormPriv
{
public:
  typedef enum
  { opNone,
    opCopy,
    opMove
  } TOperation;

  typedef struct __DelList
  { long  id;
    TCustomTransformerLine::TTransLineTypes type;

    __DelList()
    { id    = 0;
      type  = TCustomTransformerLine::ttNone;
    }
    __DelList(long tid, TCustomTransformerLine::TTransLineTypes ttype)
    { id    = tid;
      type  = ttype;
    }
  } TDelList;

  TTransformersFormPriv(TTransformersForm *AOwner);
  ~TTransformersFormPriv();

  /*! Очистка данных в листе дерева
  */
  void __fastcall clearData(TCustomTransformerLine *transline)
  { if (!transline)
      return;
    switch (transline->type)
    { case TCustomTransformerLine::ttCurrent:
      case TCustomTransformerLine::ttVoltage:
        delete  (TMeteringTransformer *)transline;
        break;
      case TCustomTransformerLine::ttPower2:
        delete  (TPowerTwoTransformer *)transline;
        break;
      case TCustomTransformerLine::ttPower3:
        delete  (TPowerTwoTransformer *)transline;
        break;
      case TCustomTransformerLine::ttLine:
        delete  (TTransmissionLine *)transline;
        break;
      case TCustomTransformerLine::ttReactor:
        delete  (TReactor *)transline;
        break;
      case TCustomTransformerLine::ttNone:
        delete  (TTransmissionLine *)transline;
        break;
      default:
        delete  transline;
    }
    transline = NULL;
  }
  /*! Очистка данных в листе дерева
  */
  void __fastcall clearData(void *data)
  { if (!data)
      return;
    clearData((TCustomTransformerLine *)data);
    data  = NULL;
  }
  /*! Очистка данных в листе дерева
  */
  void __fastcall clearData(TTreeNode *node)
  { if (!node)
      return;

    clearData(node->Data);
    node->Data = NULL;
  }
  //===== Очистка дерева и объектов в нем
  //void __fastcall clearTree(TTreeNode *node);
  //===== Создание трансформатора\линии
  TCustomTransformerLine *
    __fastcall createTransLine(TCustomTransformerLine::TTransLineTypes ttype,
                                const double *Values, const short *Indics, bool fnew = false);
  //===== Создание трансформатора\линии
  TCustomTransformerLine *
    __fastcall createTransLine(TCustomTransformerLine::TTransLineTypes ttype,
                                TCustomTransformerLine *trans, bool fnew = false);
  //===== Создание листа
  TTreeNode * __fastcall createNode(TTreeNode *node, TCustomTransformerLine *trans);
  //===== Запрет TAction
  void __fastcall disableAction(TAction *act)
  { if (!act)
      return;
    act->OnExecute  = NULL;
    act->Enabled    = false;
    act->Visible    = false;
  }
  //===== Очистка списка удаленных элементов
  void __fastcall clearRemovs()
  { TDelList  *tDL  = NULL;
    for (int i = 0; i < removs->Count; ++i)
    { tDL = (TDelList *)removs->Items[i];
      delete  tDL;
    }
    removs->Clear();
  }

  //===== Свойства и объекты для внутреннего использования
  TList *removs;                //!< Список удаленных элементов
  UINT  CF_TRANSFMS_TREENODE;   //!< Описание формата для буфера обмена

  TTransformersForm *parent;    //!< Указатель на родителя

  TOperation  eOper;            //!< Тип операции над листом

  __property bool editCatch   = { read  = GeteditCatch, write = SeteditCatch };
  __property AnsiString cnum  = { read  = Getcnum };

private:
  void __fastcall SeteditCatch(bool Value)
  { if (Value)
    { parent->NameEdit->OnChange      = parent->onChange;
      //parent->DateMEdit->OnChange     = parent->onChange;
      //===== Изменение параметров Измерительного трансформатора
      parent->mVal1Edit->OnChange     = parent->onChange;
      parent->mVal2Edit->OnChange     = parent->onChange;
      //===== Изменение параметров 2-хобмоточного трансформатора
      parent->p2SnEdit->OnChange        = parent->onChange;
      parent->p2dPxxEdit->OnChange      = parent->onChange;
      parent->p2dPkzEdit->OnChange      = parent->onChange;
      parent->p2IxxEdit->OnChange       = parent->onChange;
      parent->p2UkzEdit->OnChange       = parent->onChange;
      parent->p2WorkHoursEdit->OnChange = parent->onChange;
      parent->p2FullHoursEdit->OnChange = parent->onChange;
      //===== Изменение параметров 3-хобмоточного трансформатора
      parent->p3SnEdit->OnChange        = parent->onChange;
      parent->p3SuEdit->OnChange        = parent->onChange;
      parent->p3SmEdit->OnChange        = parent->onChange;
      parent->p3SdEdit->OnChange        = parent->onChange;
      parent->p3dPxxEdit->OnChange      = parent->onChange;
      parent->p3dPkzuEdit->OnChange     = parent->onChange;
      parent->p3dPkzmEdit->OnChange     = parent->onChange;
      parent->p3dPkzdEdit->OnChange     = parent->onChange;
      parent->p3IxxEdit->OnChange       = parent->onChange;
      parent->p3UkzuEdit->OnChange      = parent->onChange;
      parent->p3UkzmEdit->OnChange      = parent->onChange;
      parent->p3UkzdEdit->OnChange      = parent->onChange;
      parent->p3WorkHoursEdit->OnChange = parent->onChange;
      parent->p3FullHoursEdit->OnChange = parent->onChange;
      //===== Изменение параметров линии
      parent->tlRoEdit->OnChange  = parent->onChange;
      parent->tlXoEdit->OnChange  = parent->onChange;
      parent->tlLEdit->OnChange   = parent->onChange;
      parent->tlUnEdit->OnChange  = parent->onChange;
      //===== Изменение параметров реактора
      parent->RctrUnEdit->OnChange      = parent->onChange;
      parent->RctrSnEdit->OnChange      = parent->onChange;
      parent->RctrDPEdit->OnChange      = parent->onChange;
      parent->RctrFHoursEdit->OnChange  = parent->onChange;
      parent->RctrCHoursEdit->OnChange  = parent->onChange;
      //===== Реакция на перемещение по листам
      parent->tvTransfms->OnChange    = parent->tvTransfmsChange;
      parent->tvTransfms->OnChanging  = parent->tvTransfmsChanging;
    }
    else
    { parent->NameEdit->OnChange      = NULL;
      //parent->DateMEdit->OnChange     = NULL;
      //===== Изменение параметров Измерительного трансформатора
      parent->mVal1Edit->OnChange = NULL;
      parent->mVal2Edit->OnChange = NULL;
      //===== Изменение параметров 2-хобмоточного трансформатора
      parent->p2SnEdit->OnChange        = NULL;
      parent->p2dPxxEdit->OnChange      = NULL;
      parent->p2dPkzEdit->OnChange      = NULL;
      parent->p2IxxEdit->OnChange       = NULL;
      parent->p2UkzEdit->OnChange       = NULL;
      parent->p2WorkHoursEdit->OnChange = NULL;
      parent->p2FullHoursEdit->OnChange = NULL;
      //===== Изменение параметров 3-хобмоточного трансформатора
      parent->p3SnEdit->OnChange        = NULL;
      parent->p3SuEdit->OnChange        = NULL;
      parent->p3SmEdit->OnChange        = NULL;
      parent->p3SdEdit->OnChange        = NULL;
      parent->p3dPxxEdit->OnChange      = NULL;
      parent->p3dPkzuEdit->OnChange     = NULL;
      parent->p3dPkzmEdit->OnChange     = NULL;
      parent->p3dPkzdEdit->OnChange     = NULL;
      parent->p3IxxEdit->OnChange       = NULL;
      parent->p3UkzuEdit->OnChange      = NULL;
      parent->p3UkzmEdit->OnChange      = NULL;
      parent->p3UkzdEdit->OnChange      = NULL;
      parent->p3WorkHoursEdit->OnChange = NULL;
      parent->p3FullHoursEdit->OnChange = NULL;
      //===== Изменение параметров линии
      parent->tlRoEdit->OnChange  = NULL;
      parent->tlXoEdit->OnChange  = NULL;
      parent->tlLEdit->OnChange   = NULL;
      parent->tlUnEdit->OnChange  = NULL;
      //===== Изменение параметров реактора
      parent->RctrUnEdit->OnChange      = NULL;
      parent->RctrSnEdit->OnChange      = NULL;
      parent->RctrDPEdit->OnChange      = NULL;
      parent->RctrFHoursEdit->OnChange  = NULL;
      parent->RctrCHoursEdit->OnChange  = NULL;
      //===== Реакция на перемещение по листам
      parent->tvTransfms->OnChanging  = NULL;
      parent->tvTransfms->OnChange    = NULL;
    }
  }
  bool __fastcall GeteditCatch()
  { return  parent->NameEdit->OnChange != NULL;
  }
  AnsiString Getcnum()
  { return  " " + IntToStr(++dnum);
  }

  unsigned int  dnum;   //!< номер добавляемого элемента для добавления к имени трансформатора/линии

};
//---------------------------------------------------------------------------
TTransformersFormPriv::TTransformersFormPriv(TTransformersForm *AOwner)
{
  dnum  = 0;
  eOper = opNone;

  parent  = AOwner;

  removs  = new TList();
  // регистрация формата для буфера обмена
  try
  { CF_TRANSFMS_TREENODE  = RegisterClipboardFormat("CF_TRANSFMS_TREENODE");
    if (!CF_TRANSFMS_TREENODE)
    { char  mess[1025];
      LPVOID lpMsgBuf;
      FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_SYSTEM,
                    NULL, GetLastError(),
                    MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT), // Default language
                    (LPTSTR) &lpMsgBuf,  0,  NULL);
      strncpy(mess, (char *)lpMsgBuf, 1024);
      LocalFree(lpMsgBuf);
      throw Exception(mess);
    }
  }
  catch (Exception &e)
  { Application->ShowException(&e);
  }
}
//---------------------------------------------------------------------------
TTransformersFormPriv::~TTransformersFormPriv()
{
  try
  { clearRemovs();
    delete  removs;
  }
  catch (Exception &e)
  {
  }

  try
  { if (Clipboard()->HasFormat(CF_TRANSFMS_TREENODE))
      Clipboard()->Clear();
  }
  catch (Exception &e)
  {
  }
}
//---------------------------------------------------------------------------
/*! Очистка дерева и объектов в нем
*/
/*
void __fastcall TTransformersFormPriv::clearTree(TTreeNode *node)
{
  try
  { if (node)
    { for (int i = 0; i < node->Count; ++i)
      { clearData(node->Item[i]);
        if (node->Item[i]->HasChildren)
          clearTree(node->Item[i]);
      }
    }
    else
    { parent->tvTransfms->Items->BeginUpdate();
      try
      { for (int i = 0; i < parent->tvTransfms->Items->Count; ++i)
        { clearData(parent->tvTransfms->Items->Item[i]);
          if (parent->tvTransfms->Items->Item[i]->HasChildren)
            clearTree(parent->tvTransfms->Items->Item[i]);
        }
        parent->tvTransfms->Items->Clear();
      }
      __finally
      { parent->tvTransfms->Items->EndUpdate();
      }
    }
  }
  catch (Exception &e)
  {
  }
}
*/
//---------------------------------------------------------------------------
/*! Создание Трансформатора и заполнение необходимых полей, где:
    \param ttype - тип трансформатора
    \param Values - указатель на массив значений параметров

    \return созданный трансформатор иначе NULL.
*/
TCustomTransformerLine *
__fastcall TTransformersFormPriv::createTransLine(TCustomTransformerLine::TTransLineTypes ttype,
                                                  const double *Values, const short *Indics, bool fnew)
{
  TMeteringTransformer    *mTrans   = NULL;
  TPowerTwoTransformer    *p2Trans  = NULL;
  TPowerThreeTransformer  *p3Trans  = NULL;
  TTransmissionLine       *tLine    = NULL;
  TReactor                *tReact = NULL;

  try
  { switch (ttype)
    { case TCustomTransformerLine::ttCurrent:
      case TCustomTransformerLine::ttVoltage:
        mTrans  = new TMeteringTransformer(ttype);
        if (Values)
        { mTrans->Val1  = Values[0];
          mTrans->Val2  = Values[1];
        }
        if (Indics)
        { mTrans->indVal1 = Indics[0];
          mTrans->indVal2 = Indics[1];
        }
        if (fnew)
          mTrans->name  = (mTrans->name + cnum).c_str();
        return  mTrans;
      case TCustomTransformerLine::ttPower2:
        p2Trans = new TPowerTwoTransformer();
        if (Values)
        { p2Trans->Sn     = Values[0];
          p2Trans->dPxx   = Values[1];
          p2Trans->dPkz   = Values[2];
          p2Trans->Ixx    = Values[3];
          p2Trans->Ukz    = Values[4];
          p2Trans->WHours = Values[5];
          p2Trans->FHours = Values[6];
        }
        if (Indics)
        { p2Trans->indSn      = Indics[0];
          p2Trans->inddPxx    = Indics[1];
          p2Trans->inddPkz    = Indics[2];
          p2Trans->indIxx     = Indics[3];
          p2Trans->indUkz     = Indics[4];
          p2Trans->indWHours  = Indics[5];
          p2Trans->indFHours  = Indics[6];
        }
        if (fnew)
          p2Trans->name = (p2Trans->name + cnum).c_str();
        return  p2Trans;
      case TCustomTransformerLine::ttPower3:
        p3Trans = new TPowerThreeTransformer();
        if (Values)
        { p3Trans->Sn     = Values[0];
          p3Trans->Su     = Values[1];
          p3Trans->Sm     = Values[2];
          p3Trans->Sd     = Values[3];
          p3Trans->dPxx   = Values[4];
          p3Trans->dPkzu  = Values[5];
          p3Trans->dPkzm  = Values[6];
          p3Trans->dPkzd  = Values[7];
          p3Trans->Ixx    = Values[8];
          p3Trans->Ukzu   = Values[9];
          p3Trans->Ukzm   = Values[10];
          p3Trans->Ukzd   = Values[11];
          p3Trans->WHours = Values[12];
          p3Trans->FHours = Values[13];
        }
        if (Indics)
        { p3Trans->indSn      = Indics[0];
          p3Trans->indSu      = Indics[1];
          p3Trans->indSm      = Indics[2];
          p3Trans->indSd      = Indics[3];
          p3Trans->inddPxx    = Indics[4];
          p3Trans->inddPkzu   = Indics[5];
          p3Trans->inddPkzm   = Indics[6];
          p3Trans->inddPkzd   = Indics[7];
          p3Trans->indIxx     = Indics[8];
          p3Trans->indUkzu    = Indics[9];
          p3Trans->indUkzm    = Indics[10];
          p3Trans->indUkzd    = Indics[11];
          p3Trans->indWHours  = Indics[12];
          p3Trans->indFHours  = Indics[13];
        }
        if (fnew)
          p3Trans->name = (p3Trans->name + cnum).c_str();
        return  p3Trans;
      case TCustomTransformerLine::ttLine:
        tLine = new TTransmissionLine();
        if (Values)
        { tLine->Ro = Values[0];
          tLine->Xo = Values[1];
          tLine->L  = Values[2];
          tLine->Un = Values[3];
        }
        if (Indics)
        { tLine->indRo  = Indics[0];
          tLine->indXo  = Indics[1];
          tLine->indL   = Indics[2];
          tLine->indUn  = Indics[3];
        }
        if (fnew)
          tLine->name = (tLine->name + cnum).c_str();
        return  tLine;
        //
        case TCustomTransformerLine::ttReactor:
        tReact = new TReactor();
        if (Values)
        { tReact->Un     = Values[0];
          tReact->Sn     = Values[1];
          tReact->DP     = Values[2];
          tReact->FHours = Values[3];
          tReact->CHours = Values[4];
        }
        if (Indics)
        { tReact->indUn     = Indics[0];
          tReact->indSn     = Indics[1];
          tReact->indDP     = Indics[2];
          tReact->indFHours = Indics[3];
          tReact->indCHours = Indics[4];
        }
        if (fnew)
          tReact->name = (tReact->name + cnum).c_str();
        return  tReact;
        //
      default:
        return  new TCustomTransformerLine(TCustomTransformerLine::ttNone);
    }
  }
  catch (Exception &e)
  { clearData(mTrans);
    mTrans  = NULL;
    clearData(p2Trans);
    p2Trans = NULL;
    clearData(p3Trans);
    p3Trans = NULL;
    clearData(tReact);
    tReact  = NULL;
  }
  return  NULL;
}
//---------------------------------------------------------------------------
/*! Создание Трансформатора на основе существующего, где:
    \param ttype - тип трансформатора
    \param trans - указатель на существующий трансформатор

    \return созданный трансформатор иначе NULL.
*/
TCustomTransformerLine *
__fastcall TTransformersFormPriv::createTransLine(TCustomTransformerLine::TTransLineTypes ttype,
                                                  TCustomTransformerLine *transline, bool fnew)
{
  if (!transline)
    return  NULL;

  TCustomTransformerLine  *tTransLine = NULL;
  try
  { switch (ttype)
    { case TCustomTransformerLine::ttCurrent:
      case TCustomTransformerLine::ttVoltage:
        tTransLine  = new TMeteringTransformer((TMeteringTransformer *)transline);
        break;
      case TCustomTransformerLine::ttPower2:
        tTransLine  = new TPowerTwoTransformer((TPowerTwoTransformer *)transline);
        break;
      case TCustomTransformerLine::ttPower3:
        tTransLine  = new TPowerThreeTransformer((TPowerThreeTransformer *)transline);
        break;
      case TCustomTransformerLine::ttLine:
        tTransLine  = new TTransmissionLine((TTransmissionLine *)transline);
        break;
      case TCustomTransformerLine::ttReactor:
        tTransLine  = new TReactor((TReactor *)transline);
        break;
      default:
        tTransLine  = new TCustomTransformerLine(transline);
        break;
    }
    if (fnew)
      tTransLine->name  = (tTransLine->name + cnum).c_str();
  }
  catch (Exception &e)
  { clearData(tTransLine);
    tTransLine  = NULL;
  }
  return  tTransLine;
}
//---------------------------------------------------------------------------
/*! Создание листа дерева, где:
    \param node - указатель на родительский лист
    \param trans - указатель на добавляемый объект трансформатора

    \return созданный лист или NULL
*/
TTreeNode * __fastcall TTransformersFormPriv::createNode(TTreeNode *node,
                                                          TCustomTransformerLine *transline)
{
  TTreeNode *tNode  = NULL;
  try
  { tNode = parent->tvTransfms->Items->AddChildObject(node, transline->name, transline);
    switch (transline->type)
    { case TCustomTransformerLine::ttCurrent:
        tNode->ImageIndex = imCurrent;
        break;
      case TCustomTransformerLine::ttVoltage:
        tNode->ImageIndex = imVoltage;
        break;
      case TCustomTransformerLine::ttPower2:
        tNode->ImageIndex = imPower2;
        break;
      case TCustomTransformerLine::ttPower3:
        tNode->ImageIndex = imPower3;
        break;
      case TCustomTransformerLine::ttLine:
        tNode->ImageIndex = imLine;
        break;
      case TCustomTransformerLine::ttReactor:
        tNode->ImageIndex = imReactor;
        break;
      default:
        tNode->ImageIndex   = imCFldr;
        tNode->HasChildren  = transline->edit;
    }
    tNode->SelectedIndex  = tNode->ImageIndex;
    transline->edit = false;
  }
  catch (Exception &e)
  { if (tNode)
    { tNode->Data = NULL;
      delete  tNode;
    }
    tNode = NULL;
  }
  return  tNode;
}
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
__fastcall TTransformersForm::TTransformersForm(TComponent* Owner, AnsiString Name, TAccess a)
  : TMainForm(Owner, Name, a)
{
}
//---------------------------------------------------------------------------
/*! Действия при создании формы
*/
void __fastcall TTransformersForm::FormCreate(TObject *Sender)
{
  d = new TTransformersFormPriv(this);

  //===== Включение удаления элементов
  ShowAction(iaDelete, true);

  //===== Стартовые настройки
  mClon->Action = iaMon;

  if (customer_id == 1||customer_id==51)
  { mVal1Edit->ReadOnly = true;
    mVal2Edit->ReadOnly = true;
    tbTools->Visible    = false;
  }

  //===== Установка закладок невидимыми
  for (int i = 0; i < TransformerPControl->PageCount; ++i)
    TransformerPControl->Pages[i]->TabVisible = false;


  New2PowerTransAction->Tag       = TCustomTransformerLine::ttPower2;
  New3PowerTransAction->Tag       = TCustomTransformerLine::ttPower3;
  NewIMeteringTransAction->Tag    = TCustomTransformerLine::ttCurrent;
  NewUMeteringTransAction->Tag    = TCustomTransformerLine::ttVoltage;
  NewTransmissionLineAction->Tag  = TCustomTransformerLine::ttLine;
  NewReactorMenuAction->Tag       = TCustomTransformerLine::ttReactor;

  New2PowerTransAction->OnExecute       = NewTransLine;
  New3PowerTransAction->OnExecute       = NewTransLine;
  NewIMeteringTransAction->OnExecute    = NewTransLine;
  NewUMeteringTransAction->OnExecute    = NewTransLine;
  NewTransmissionLineAction->OnExecute  = NewTransLine;
  NewReactorMenuAction->OnExecute       = NewTransLine;

  //===== Запрещение некоторых Действий
  //===== Запрещение добавления стандартного нового элемента
  d->disableAction(iaNew);
  //===== Запрещение мониторинга элемента
  d->disableAction(iaMon);
  //===== Запрещение Добавления Измерительных трансформаторов
  d->disableAction(NewMeteringTransAction);
  d->disableAction(NewIMeteringTransAction);
  d->disableAction(NewUMeteringTransAction);

  //===== Открытие данных
  vRefresh(Sender);
}
//---------------------------------------------------------------------------
/*! Действия перед разрушением формы
*/
void __fastcall TTransformersForm::FormDestroy(TObject *Sender)
{
  delete  d;
  d = NULL;
}
//---------------------------------------------------------------------------
void __fastcall TTransformersForm::onChange(TObject *Sender)
{
  if (Sender == NameEdit)
    tvTransfms->Selected->Text  = NameEdit->Text;
//  if (dynamic_cast<TEdit *>(Sender))
  //  ((TEdit *)Sender)->Text = ((TEdit *)Sender)->Text.Trim();

  EditRec = true;
}
//---------------------------------------------------------------------------
void __fastcall TTransformersForm::NewPowerTransActionExecute(
      TObject *Sender)
{
  TPoint  tP(NewPowerTransTBtn->
              ClientToScreen(TPoint(NewPowerTransTBtn->Left,
                                    NewPowerTransTBtn->Top + NewPowerTransTBtn->Height)));
  NewPowerTransformMenu->Popup(tP.x, tP.y);
}
//---------------------------------------------------------------------------
void __fastcall TTransformersForm::NewMeteringTransActionExecute(
      TObject *Sender)
{
  TPoint  tP(NewMeteringTransTBtn->
              ClientToScreen(TPoint(NewMeteringTransTBtn->Left,
                                    NewMeteringTransTBtn->Top + NewMeteringTransTBtn->Height)));
  NewMeteringTransformMenu->Popup(tP.x, tP.y);
}
//---------------------------------------------------------------------------
void __fastcall TTransformersForm::NewLineActionExecute(TObject *Sender)
{
  TPoint  tP(NewLineTBtn->ClientToScreen(TPoint(NewLineTBtn->Left,
                                                NewLineTBtn->Top + NewLineTBtn->Height)));
  NewLineMenu->Popup(tP.x, tP.y);
}
//---------------------------------------------------------------------------
void __fastcall TTransformersForm::tvTransfmsChange(TObject *Sender,
      TTreeNode *Node)
{
  if (!Node)
    return;
  if (ActiveControl)
    oldCtrl = ActiveControl;

  TCustomTransformerLine  *tTransLine = (TCustomTransformerLine *)Node->Data;
  TMeteringTransformer    *mTrans     = NULL;
  TPowerTwoTransformer    *p2Trans    = NULL;
  TPowerThreeTransformer  *p3Trans    = NULL;
  TTransmissionLine       *tLine      = NULL;
  TReactor                *tReact     = NULL;

  d->editCatch  = false;
//  CalcLossParamAction->Enabled  = tTransLine->type != TCustomTransformerLine::ttNone;
  SetWorkTimeAction->Enabled    = tTransLine->type == TCustomTransformerLine::ttPower2
                                    || tTransLine->type == TCustomTransformerLine::ttPower3
                                    || tTransLine->type == TCustomTransformerLine::ttReactor;
  aSpezPar->Enabled = tTransLine->type == TCustomTransformerLine::ttLine ||
                      tTransLine->type == TCustomTransformerLine::ttPower2 ||
                      tTransLine->type == TCustomTransformerLine::ttPower3||
                      tTransLine->type == TCustomTransformerLine::ttReactor;
  aBorderPar->Enabled = aSpezPar->Enabled;

  NameEdit->ReadOnly  = tTransLine->type == TCustomTransformerLine::ttNone;
  NameEdit->Color     = tTransLine->type != TCustomTransformerLine::ttNone ? clWindow : clMenu;

  paramPanel->Enabled = tTransLine->type != TCustomTransformerLine::ttNone;
  paramPanel->Visible = tTransLine->type != TCustomTransformerLine::ttNone;

  TransformerPControl->ActivePage = NULL;
  //===== Разрешение просмотра монитора по данному объекту
  iaMon->Enabled  = tTransLine->type != TCustomTransformerLine::ttNone;

  //===== Заполнение необходимых полей
  eId->Text = tTransLine->id;
  NameEdit->Text  = tTransLine->name;//tvTransfms->Selected->Text;
  //===== Убрано т.к. временно от даты отказались
  //if (tTransLine->type != TCustomTransformerLine::ttNone)
  //  DateMEdit->Text = tTransLine->date;
  switch (tTransLine->type)
  { case TCustomTransformerLine::ttCurrent:
    case TCustomTransformerLine::ttVoltage:
      //===== измерительный трансформатор
      TransformerPControl->ActivePage = MeteringTransformerPage;

      lValueFirst->Caption  = tTransLine->type == TCustomTransformerLine::ttCurrent
                                ? Reconst_smes29_8
                                : Reconst_smes29_9;
      lValueSecond->Caption = tTransLine->type == TCustomTransformerLine::ttCurrent
                                ? Reconst_smes29_10
                                : Reconst_smes29_11;
      mTrans  = (TMeteringTransformer *)tTransLine;

      //===== Val1
      mVal1Edit->Text = mTrans->indVal1 == PARAM_NOTNULL
                          ? FloatToStr(mTrans->Val1)
                          : AnsiString("");
      //===== Val2
      mVal2Edit->Text = mTrans->indVal2 == PARAM_NOTNULL
                          ? FloatToStr(mTrans->Val2)
                          : AnsiString("");
      break;
    case TCustomTransformerLine::ttPower2:
      //===== 2-хобмоточный трансформатор
      TransformerPControl->ActivePage = TwoPowerTransformerPage;
      p2Trans = (TPowerTwoTransformer *)tTransLine;

      //===== Sn
      p2SnEdit->Text        = p2Trans->indSn == PARAM_NOTNULL
                                ? FloatToStr(p2Trans->Sn)
                                : AnsiString("");
      //===== dPxx
      p2dPxxEdit->Text      = p2Trans->inddPxx == PARAM_NOTNULL
                                ? FloatToStr(p2Trans->dPxx)
                                : AnsiString("");
      //===== dPkz
      p2dPkzEdit->Text      = p2Trans->inddPkz == PARAM_NOTNULL
                                ? FloatToStr(p2Trans->dPkz)
                                : AnsiString("");
      //===== Ixx
      p2IxxEdit->Text       = p2Trans->indIxx == PARAM_NOTNULL
                                ? FloatToStr(p2Trans->Ixx)
                                : AnsiString("");
      //===== Ukz
      p2UkzEdit->Text       = p2Trans->indUkz == PARAM_NOTNULL
                                ? FloatToStr(p2Trans->Ukz)
                                : AnsiString("");
      //===== WHours
      p2WorkHoursEdit->Text = p2Trans->indWHours == PARAM_NOTNULL
                                ? FloatToStr(p2Trans->WHours)
                                : AnsiString("");
      //===== FHours
      p2FullHoursEdit->Text = p2Trans->indFHours == PARAM_NOTNULL
                                ? FloatToStr(p2Trans->FHours)
                                : AnsiString("");
      break;
    case TCustomTransformerLine::ttPower3:
      //===== 2-хобмоточный трансформатор
      TransformerPControl->ActivePage = ThreePowerTransformerPage;
      p3Trans = (TPowerThreeTransformer *)tTransLine;

      //===== Sn
      p3SnEdit->Text        = p3Trans->indSn == PARAM_NOTNULL
                                ? FloatToStr(p3Trans->Sn)
                                : AnsiString("");
      //===== Su
      p3SuEdit->Text        = p3Trans->indSu == PARAM_NOTNULL
                                ? FloatToStr(p3Trans->Su)
                                : AnsiString("");
      //===== Sm
      p3SmEdit->Text        = p3Trans->indSm == PARAM_NOTNULL
                                ? FloatToStr(p3Trans->Sm)
                                : AnsiString("");
      //===== Sd
      p3SdEdit->Text        = p3Trans->indSd == PARAM_NOTNULL
                                ? FloatToStr(p3Trans->Sd)
                                : AnsiString("");
      //===== dPxx
      p3dPxxEdit->Text      = p3Trans->inddPxx == PARAM_NOTNULL
                                ? FloatToStr(p3Trans->dPxx)
                                : AnsiString("");
      //===== dPkzu
      p3dPkzuEdit->Text     = p3Trans->inddPkzu == PARAM_NOTNULL
                                ? FloatToStr(p3Trans->dPkzu)
                                : AnsiString("");
      //===== dPkzm
      p3dPkzmEdit->Text     = p3Trans->inddPkzm == PARAM_NOTNULL
                                ? FloatToStr(p3Trans->dPkzm)
                                : AnsiString("");
      //===== dPkzd
      p3dPkzdEdit->Text     = p3Trans->inddPkzd == PARAM_NOTNULL
                                ? FloatToStr(p3Trans->dPkzd)
                                : AnsiString("");
      //===== Ixx
      p3IxxEdit->Text       = p3Trans->indIxx == PARAM_NOTNULL
                                ? FloatToStr(p3Trans->Ixx)
                                : AnsiString("");
      //===== Ukzu
      p3UkzuEdit->Text      = p3Trans->indUkzu == PARAM_NOTNULL
                                ? FloatToStr(p3Trans->Ukzu)
                                : AnsiString("");
      //===== Ukzm
      p3UkzmEdit->Text      = p3Trans->indUkzm == PARAM_NOTNULL
                                ? FloatToStr(p3Trans->Ukzm)
                                : AnsiString("");
      //===== Ukzd
      p3UkzdEdit->Text      = p3Trans->indUkzd == PARAM_NOTNULL
                                ? FloatToStr(p3Trans->Ukzd)
                                : AnsiString("");
      //===== WHours
      p3WorkHoursEdit->Text = p3Trans->indWHours == PARAM_NOTNULL
                                ? FloatToStr(p3Trans->WHours)
                                : AnsiString("");
      //===== FHours
      p3FullHoursEdit->Text = p3Trans->indFHours == PARAM_NOTNULL
                                ? FloatToStr(p3Trans->FHours)
                                : AnsiString("");
      break;
    case TCustomTransformerLine::ttLine:
      //===== линия передачи
      TransformerPControl->ActivePage = TransmissionLinePage;
      tLine = (TTransmissionLine *)tTransLine;

      //===== Ro
      tlRoEdit->Text  = tLine->indRo == PARAM_NOTNULL
                          ? FloatToStr(tLine->Ro)
                          : AnsiString("");
      //===== Xo
      tlXoEdit->Text  = tLine->indXo == PARAM_NOTNULL
                          ? FloatToStr(tLine->Xo)
                          : AnsiString("");
      //===== L
      tlLEdit->Text   = tLine->indL == PARAM_NOTNULL
                          ? FloatToStr(tLine->L)
                          : AnsiString("");
      //===== Un
      tlUnEdit->Text  = tLine->indUn == PARAM_NOTNULL
                          ? FloatToStr(tLine->Un)
                          : AnsiString("");
      break;
      case TCustomTransformerLine::ttReactor:
      //===== реактор
      TransformerPControl->ActivePage = ReactorPage;
      tReact = (TReactor *)tTransLine;

      //===== Un
      RctrUnEdit->Text  = tReact->indUn == PARAM_NOTNULL
                          ? FloatToStr(tReact->Un)
                          : AnsiString("");
      //===== Sn
      RctrSnEdit->Text  = tReact->indSn == PARAM_NOTNULL
                          ? FloatToStr(tReact->Sn)
                          : AnsiString("");
      //===== DP
      RctrDPEdit->Text   = tReact->indDP == PARAM_NOTNULL
                          ? FloatToStr(tReact->DP)
                          : AnsiString("");
      //===== FHours
      RctrFHoursEdit->Text  = tReact->indFHours == PARAM_NOTNULL
                          ? FloatToStr(tReact->FHours)
                          : AnsiString("");

      //===== CHours
      RctrCHoursEdit->Text  = tReact->indCHours == PARAM_NOTNULL
                          ? FloatToStr(tReact->CHours)
                          : AnsiString("");
      break;
  }

  d->editCatch = true;

  try
  { ActiveControl = oldCtrl;
  }
  catch (Exception &e)
  { ActiveControl = NULL;
  }
}
//---------------------------------------------------------------------------
void __fastcall TTransformersForm::tvTransfmsChanging(TObject *Sender,
      TTreeNode *Node, bool &AllowChange)
{
  TMeteringTransformer    *mTrans   = NULL;
  TPowerTwoTransformer    *p2Trans  = NULL;
  TPowerThreeTransformer  *p3Trans  = NULL;
  TTransmissionLine       *tLine    = NULL;
  TReactor                *tReact   = NULL;

  AllowChange = AllowChangeNode();//Sender, Node);
  TTreeView *tTV  = dynamic_cast<TTreeView *>(Sender);
  if (AllowChange && EditRec && tTV && tTV->Selected)
  { TCustomTransformerLine  *tTransLine = (TCustomTransformerLine *)tTV->Selected->Data;
    if (tTransLine->type == TCustomTransformerLine::ttNone)
      return;
    tTransLine->name  = NameEdit->Text.c_str();
    //===== Убрано т.к. временно от даты отказались
    //tTransLine->date  = DateMEdit->Text.c_str();
    switch (tTransLine->type)
    { case TCustomTransformerLine::ttCurrent:
      case TCustomTransformerLine::ttVoltage:
        //===== измерительный трансформатор
        mTrans  = (TMeteringTransformer *)tTransLine;
        //===== Val1
        if (mVal1Edit->Text.Trim().Length())
        { mTrans->Val1    = mVal1Edit->Text.Trim().ToDouble();
          mTrans->indVal1 = PARAM_NOTNULL;
        }
        else
          mTrans->indVal1 = PARAM_NULL;
        //=====
        if (mVal2Edit->Text.Trim().Length())
        { mTrans->Val2    = mVal2Edit->Text.Trim().ToDouble();
          mTrans->indVal2 = PARAM_NOTNULL;
        }
        else
          mTrans->indVal2 = PARAM_NULL;

        break;
      case TCustomTransformerLine::ttPower2:
        //===== 2-хобмоточный трансформатор
        p2Trans = (TPowerTwoTransformer *)tTransLine;
        //===== Sn
        if (p2SnEdit->Text.Trim().Length())
        { p2Trans->Sn     = p2SnEdit->Text.Trim().ToDouble();
          p2Trans->indSn  = PARAM_NOTNULL;
        }
        else
          p2Trans->indSn  = PARAM_NULL;
        //===== dPxx
        if (p2dPxxEdit->Text.Trim().Length())
        { p2Trans->dPxx     = p2dPxxEdit->Text.Trim().ToDouble();
          p2Trans->inddPxx  = PARAM_NOTNULL;
        }
        else
          p2Trans->inddPxx  = PARAM_NULL;
        //===== dPkz
        if (p2dPkzEdit->Text.Trim().Length())
        { p2Trans->dPkz     = p2dPkzEdit->Text.Trim().ToDouble();
          p2Trans->inddPkz  = PARAM_NOTNULL;
        }
        else
          p2Trans->inddPkz  = PARAM_NULL;
        //===== Ixx
        if (p2IxxEdit->Text.Trim().Length())
        { p2Trans->Ixx    = p2IxxEdit->Text.Trim().ToDouble();
          p2Trans->indIxx = PARAM_NOTNULL;
        }
        else
          p2Trans->indIxx = PARAM_NULL;
        //===== Ukz
        if (p2UkzEdit->Text.Trim().Length())
        { p2Trans->Ukz    = p2UkzEdit->Text.Trim().ToDouble();
          p2Trans->indUkz = PARAM_NOTNULL;
        }
        else
          p2Trans->indUkz = PARAM_NULL;
        //===== WHours
        if (p2WorkHoursEdit->Text.Trim().Length())
        { p2Trans->WHours     = p2WorkHoursEdit->Text.Trim().ToDouble();
          p2Trans->indWHours  = PARAM_NOTNULL;
        }
        else
          p2Trans->indWHours  = PARAM_NULL;
        //===== FHours
        if (p2FullHoursEdit->Text.Trim().Length())
        { p2Trans->FHours     = p2FullHoursEdit->Text.Trim().ToDouble();
          p2Trans->indFHours  = PARAM_NOTNULL;
        }
        else
          p2Trans->indFHours  = PARAM_NULL;
        break;
      case TCustomTransformerLine::ttPower3:
        //===== 3-хобмоточный трансформатор
        p3Trans = (TPowerThreeTransformer *)tTransLine;
        //===== Sn
        if (p3SnEdit->Text.Trim().Length())
        { p3Trans->Sn     = p3SnEdit->Text.Trim().ToDouble();
          p3Trans->indSn  = PARAM_NOTNULL;
        }
        else
          p3Trans->indSn  = PARAM_NULL;
        //===== Su
        if (p3SuEdit->Text.Trim().Length())
        { p3Trans->Su     = p3SuEdit->Text.Trim().ToDouble();
          p3Trans->indSu  = PARAM_NOTNULL;
        }
        else
          p3Trans->indSu  = PARAM_NULL;
        //===== Sm
        if (p3SmEdit->Text.Trim().Length())
        { p3Trans->Sm     = p3SmEdit->Text.Trim().ToDouble();
          p3Trans->indSm  = PARAM_NOTNULL;
        }
        else
          p3Trans->indSm  = PARAM_NULL;
        //===== Sd
        if (p3SdEdit->Text.Trim().Length())
        { p3Trans->Sd     = p3SdEdit->Text.Trim().ToDouble();
          p3Trans->indSd  = PARAM_NOTNULL;
        }
        else
          p3Trans->indSd  = PARAM_NULL;
        //===== dPxx
        if (p3dPxxEdit->Text.Trim().Length())
        { p3Trans->dPxx     = p3dPxxEdit->Text.Trim().ToDouble();
          p3Trans->inddPxx  = PARAM_NOTNULL;
        }
        else
          p3Trans->inddPxx  = PARAM_NULL;
        //===== dPkzu
        if (p3dPkzuEdit->Text.Trim().Length())
        { p3Trans->dPkzu    = p3dPkzuEdit->Text.Trim().ToDouble();
          p3Trans->inddPkzu = PARAM_NOTNULL;
        }
        else
          p3Trans->inddPkzu = PARAM_NULL;
        //===== dPkzm
        if (p3dPkzmEdit->Text.Trim().Length())
        { p3Trans->dPkzm    = p3dPkzmEdit->Text.Trim().ToDouble();
          p3Trans->inddPkzm = PARAM_NOTNULL;
        }
        else
          p3Trans->inddPkzm = PARAM_NULL;
        //===== dPkzd
        if (p3dPkzdEdit->Text.Trim().Length())
        { p3Trans->dPkzd    = p3dPkzdEdit->Text.Trim().ToDouble();
          p3Trans->inddPkzd = PARAM_NOTNULL;
        }
        else
          p3Trans->inddPkzd = PARAM_NULL;
        //===== Ixx
        if (p3IxxEdit->Text.Trim().Length())
        { p3Trans->Ixx    = p3IxxEdit->Text.Trim().ToDouble();
          p3Trans->indIxx = PARAM_NOTNULL;
        }
        else
          p3Trans->indIxx = PARAM_NULL;
        //===== Ukzu
        if (p3UkzuEdit->Text.Trim().Length())
        { p3Trans->Ukzu     = p3UkzuEdit->Text.Trim().ToDouble();
          p3Trans->indUkzu  = PARAM_NOTNULL;
        }
        else
          p3Trans->indUkzu  = PARAM_NULL;
        //===== Ukzm
        if (p3UkzmEdit->Text.Trim().Length())
        { p3Trans->Ukzm     = p3UkzmEdit->Text.Trim().ToDouble();
          p3Trans->indUkzm  = PARAM_NOTNULL;
        }
        else
          p3Trans->indUkzm  = PARAM_NULL;
        //===== Ukzd
        if (p3UkzdEdit->Text.Trim().Length())
        { p3Trans->Ukzd     = p3UkzdEdit->Text.Trim().ToDouble();
          p3Trans->indUkzd  = PARAM_NOTNULL;
        }
        else
          p3Trans->indUkzd  = PARAM_NULL;
        //===== WHours
        if (p3WorkHoursEdit->Text.Trim().Length())
        { p3Trans->WHours     = p3WorkHoursEdit->Text.Trim().ToDouble();
          p3Trans->indWHours  = PARAM_NOTNULL;
        }
        else
          p3Trans->indWHours  = PARAM_NULL;
        //===== FHours
        if (p3FullHoursEdit->Text.Trim().Length())
        { p3Trans->FHours     = p3FullHoursEdit->Text.Trim().ToDouble();
          p3Trans->indFHours  = PARAM_NOTNULL;
        }
        else
          p3Trans->indFHours  = PARAM_NULL;
        break;
      case TCustomTransformerLine::ttLine:
        //===== линия передачи
        tLine = (TTransmissionLine *)tTransLine;
        //===== Ro
        if (tlRoEdit->Text.Trim().Length())
        { tLine->Ro     = tlRoEdit->Text.Trim().ToDouble();
          tLine->indRo  = PARAM_NOTNULL;
        }
        else
          tLine->indRo  = PARAM_NULL;
        //===== Xo
        if (tlXoEdit->Text.Trim().Length())
        { tLine->Xo     = tlXoEdit->Text.Trim().ToDouble();
          tLine->indXo  = PARAM_NOTNULL;
        }
        else
          tLine->indXo  = PARAM_NULL;
        //===== L
        if (tlLEdit->Text.Trim().Length())
        { tLine->L    = tlLEdit->Text.Trim().ToDouble();
          tLine->indL = PARAM_NOTNULL;
        }
        else
          tLine->indL = PARAM_NULL;
        //===== Un
        if (tlUnEdit->Text.Trim().Length())
        { tLine->Un     = tlUnEdit->Text.Trim().ToDouble();
          tLine->indUn  = PARAM_NOTNULL;
        }
        else
          tLine->indUn  = PARAM_NULL;
        break;
        case TCustomTransformerLine::ttReactor:
        //===== Реактор
        tReact = (TReactor *)tTransLine;
        //===== Un
        if (RctrUnEdit->Text.Trim().Length())
        { tReact->Un     = RctrUnEdit->Text.Trim().ToDouble();
          tReact->indUn  = PARAM_NOTNULL;
        }
        else
          tReact->indUn  = PARAM_NULL;
        //===== Sn
        if (RctrSnEdit->Text.Trim().Length())
        { tReact->Sn     = RctrSnEdit->Text.Trim().ToDouble();
          tReact->indSn  = PARAM_NOTNULL;
        }
        else
          tReact->indSn  = PARAM_NULL;
        //===== DP
        if (RctrDPEdit->Text.Trim().Length())
        { tReact->DP    = RctrDPEdit->Text.Trim().ToDouble();
          tReact->indDP = PARAM_NOTNULL;
        }
        else
          tReact->indDP = PARAM_NULL;
        //===== FHours
        if (RctrFHoursEdit->Text.Trim().Length())
        { tReact->FHours     = RctrFHoursEdit->Text.Trim().ToDouble();
          tReact->indFHours  = PARAM_NOTNULL;
        }
        else
          tReact->indFHours  = PARAM_NULL;
        //===== CHours
        if (RctrCHoursEdit->Text.Trim().Length())
        { tReact->CHours     = RctrCHoursEdit->Text.Trim().ToDouble();
          tReact->indCHours  = PARAM_NOTNULL;
        }
        else
          tReact->indCHours  = PARAM_NULL;
        break;
    }
    if (!tTransLine->edit)
      tTransLine->edit = true;
  }
}
//---------------------------------------------------------------------------
void __fastcall TTransformersForm::tvTransfmsCollapsing(TObject *Sender,
      TTreeNode *Node, bool &AllowCollapse)
{
  Node->ImageIndex    = imCFldr;
  Node->SelectedIndex = Node->ImageIndex;
}
//---------------------------------------------------------------------------
void __fastcall TTransformersForm::tvTransfmsDeletion(TObject *Sender,
      TTreeNode *Node)
{
  d->clearData(Node);
  //if (Node->Data)
    //delete  Node->Data;
}
//---------------------------------------------------------------------------
void __fastcall TTransformersForm::tvTransfmsDragDrop(TObject *Sender,
      TObject *Source, int X, int Y)
{
  try
  { TTreeNode *dst  = ((TTreeView*)Sender)->GetNodeAt(X, Y);
    TTreeNode *src  = ((TTreeView*)Sender)->Selected;
    if (!src || !src->Data)
      throw Exception(Reconst_smes29_12);
    changeNode(src, dst);
  }
  catch (Exception &e)
  { Application->ShowException(&e);
  }
}
//---------------------------------------------------------------------------
void __fastcall TTransformersForm::tvTransfmsDragOver(TObject *Sender,
      TObject *Source, int X, int Y, TDragState State, bool &Accept)
{
  Accept  = AcceptNode(((TTreeView*)Source)->Selected,
                        ((TTreeView*)Sender)->GetNodeAt(X, Y));
  switch (d->eOper)
  { case TTransformersFormPriv::opCopy:
      tvTransfms->DragCursor  = crDragCopy;
      break;
    case TTransformersFormPriv::opMove:
      tvTransfms->DragCursor  = crDrag;
      break;
    case TTransformersFormPriv::opNone:
      tvTransfms->DragCursor  = crDrag;
      break;
  }
}
//---------------------------------------------------------------------------
void __fastcall TTransformersForm::tvTransfmsExpanding(TObject *Sender,
      TTreeNode *Node, bool &AllowExpansion)
{
  try
  { if (!Node->getFirstChild())
      ReadTreeNode(Node);
    Node->ImageIndex    = imOFldr;
    Node->SelectedIndex = Node->ImageIndex;
  }
  catch (Exception &e)
  { AllowExpansion  = false;
    Application->ShowException(&e);
  }
}
//---------------------------------------------------------------------------

/*! Сохранение изменений
*/
void __fastcall TTransformersForm::vSave(TObject* Owner)
{
 /* char  sqlMDel[]   = "begin "+SchemeName+"EDITTRANSFORMER_LINE_PG.del_p(:par1); end;";
  char  sqlP2Del[]  = "begin "+SchemeName+"EDITTRANSFORMER_LINE_PG.delt2_p(:par1); end;";
  char  sqlP3Del[]  = "begin "+SchemeName+"EDITTRANSFORMER_LINE_PG.delt3_p(:par1); end;";
  char  sqlTLDel[]  = "begin "+SchemeName+"EDITTRANSFORMER_LINE_PG.dell_p(:par1); end;";
  char  sqlM[]  = "begin "
                    "if :par1=0 then "
                      +SchemeName+"EDITTRANSFORMER_LINE_PG.ins_p(:par2,:par3,:par4,TO_DATE(:par5,'dd.mm.yyyy hh24:mi:ss'),:par6,:par7,:par1); "
                    "else "
                      +SchemeName+"EDITTRANSFORMER_LINE_PG.upd_p(:par1,:par2,:par3,:par4,TO_DATE(:par5,'dd.mm.yyyy hh24:mi:ss'),:par6,:par7); "
                    "end if; "
                  "end;";
  char  sqlP2[] = "begin "
                    "if :par1=0 then "
                      +SchemeName+"EDITTRANSFORMER_LINE_PG.inst2_p(:par2, :par3, :par4, :par5, :par6, :par7, :par8, :par9, :par10, :par1); "
                    "else "
                      +SchemeName+"EDITTRANSFORMER_LINE_PG.updt2_p(:par1, :par2, :par3, :par4, :par5, :par6, :par7, :par8, :par9, :par10); "
                    "end if; "
                  "end;";
  char  sqlP3[] = "begin "
                    "if :par1=0 then "
                      +SchemeName+"EDITTRANSFORMER_LINE_PG."
                              "inst3_p(:par2, :par3, :par4, :par5, :par6, :par7, :par8, :par9, :par10, :par11, :par12, :par13, :par14, :par15, :par16, :par17, :par1); "
                    "else "
                      +SchemeName+"EDITTRANSFORMER_LINE_PG."
                              "updt3_p(:par1, :par2, :par3, :par4, :par5, :par6, :par7, :par8, :par9, :par10, :par11, :par12, :par13, :par14, :par15, :par16, :par17); "
                    "end if; "
                  "end;";
  char  sqlTL[] = "begin "
                    "if :par1=0 then "
                      +SchemeName+"EDITTRANSFORMER_LINE_PG.insl_p(:par2, :par3, :par4, :par5, :par6, :par7, :par1); "
                    "else "
                      +SchemeName+"EDITTRANSFORMER_LINE_PG.updl_p(:par1, :par2, :par3, :par4, :par5, :par6, :par7); "
                    "end if; "
                  "end;";  */
  AnsiString  sqlMDel   = "begin "+SchemeName+"EDITTRANSFORMER_LINE_PG.del_p(:par1); end;";
  AnsiString sqlP2Del  = "begin "+SchemeName+"EDITTRANSFORMER_LINE_PG.delt2_p(:par1); end;";
  AnsiString  sqlP3Del  = "begin "+SchemeName+"EDITTRANSFORMER_LINE_PG.delt3_p(:par1); end;";
  AnsiString  sqlTLDel  = "begin "+SchemeName+"EDITTRANSFORMER_LINE_PG.dell_p(:par1); end;";
  AnsiString  sqlRctrDel  = "begin "+SchemeName+"EDITTRANSFORMER_LINE_PG.delr_p(:par1); end;";
  AnsiString  sqlM  = "begin "
                    "if :par1=0 then "
                      +SchemeName+"EDITTRANSFORMER_LINE_PG.ins_p(:par2,:par3,:par4,TO_DATE(:par5,'dd.mm.yyyy hh24:mi:ss'),:par6,:par7,:par1); "
                    "else "
                      +SchemeName+"EDITTRANSFORMER_LINE_PG.upd_p(:par1,:par2,:par3,:par4,TO_DATE(:par5,'dd.mm.yyyy hh24:mi:ss'),:par6,:par7); "
                    "end if; "
                  "end;";
  AnsiString  sqlP2 = "begin "
                    "if :par1=0 then "
                      +SchemeName+"EDITTRANSFORMER_LINE_PG.inst2_p(:par2, :par3, :par4, :par5, :par6, :par7, :par8, :par9, :par10, :par1); "
                    "else "
                      +SchemeName+"EDITTRANSFORMER_LINE_PG.updt2_p(:par1, :par2, :par3, :par4, :par5, :par6, :par7, :par8, :par9, :par10); "
                    "end if; "
                  "end;";
  AnsiString  sqlP3 = "begin "
                    "if :par1=0 then "
                      +SchemeName+"EDITTRANSFORMER_LINE_PG."
                              "inst3_p(:par2, :par3, :par4, :par5, :par6, :par7, :par8, :par9, :par10, :par11, :par12, :par13, :par14, :par15, :par16, :par17, :par1); "
                    "else "
                      +SchemeName+"EDITTRANSFORMER_LINE_PG."
                              "updt3_p(:par1, :par2, :par3, :par4, :par5, :par6, :par7, :par8, :par9, :par10, :par11, :par12, :par13, :par14, :par15, :par16, :par17); "
                    "end if; "
                  "end;";
  AnsiString  sqlTL = "begin "
                    "if :par1=0 then "
                      +SchemeName+"EDITTRANSFORMER_LINE_PG.insl_p(:par2, :par3, :par4, :par5, :par6, :par7, :par1); "
                    "else "
                      +SchemeName+"EDITTRANSFORMER_LINE_PG.updl_p(:par1, :par2, :par3, :par4, :par5, :par6, :par7); "
                    "end if; "
                  "end;";
  AnsiString  sqlRctr = "begin "
                    "if :par1=0 then "
                      +SchemeName+"EDITTRANSFORMER_LINE_PG.insr_p(:par2, :par3, :par4, :par5, :par6, :par7, :par8, :par1); "
                    "else "
                      +SchemeName+"EDITTRANSFORMER_LINE_PG.updr_p(:par1, :par2, :par3, :par4, :par5, :par6, :par7, :par8); "
                    "end if; "
                  "end;";

  long  id,       //===== Идентификатор удаляемого трансформатора
        parent;   //===== Идентификатор родительского объекта

  TCustomTransformerLine  *cTransLine = NULL;   //===== Указатель на базовый трансформатор ...
  TMeteringTransformer    mTrans;               //===== измерительный трансформатор
  TPowerTwoTransformer    p2Trans;              //===== Силовой 2-х обмоточный
  TPowerThreeTransformer  p3Trans;              //===== Силовой 3-х обмоточный
  TTransmissionLine       tLine;                //===== Линия Электро Передач
  TReactor                tReact;               //===== Реактор

  TTreeNode *tNode    = NULL;                   //===== Рабочий указатель на лист
  TTreeNode *oldNode  = tvTransfms->Selected;   //===== Указатель на старый выделенный лист

  try
  { // Обновление содержимого данных из экранных компонентов
    tvTransfms->Selected  = NULL;
    if (tvTransfms->Selected)
      return;
    // Сохранение изменений


    tNode = tvTransfms->Items->GetFirstNode();
    while (tNode)
    { cTransLine  = (TCustomTransformerLine *)tNode->Data;
      if (cTransLine && cTransLine->edit && cTransLine->type != TCustomTransformerLine::ttNone)
      { //===== Получение ID родителя
        parent  = ((TCustomTransformerLine *)tNode->Parent->Data)->id;
        //===== Запись изменений по типу трансформатора
        switch (cTransLine->type)
        { case TCustomTransformerLine::ttCurrent:
          case TCustomTransformerLine::ttVoltage:
            mTrans  = *((TMeteringTransformer *)cTransLine);
            //GRB ADD 16.04.2020 - test trouble ODAC
            dmMain->quMain->Params->Clear();
            //END ADD 
            dmMain->quMain->SQL->Text=sqlM;
            dmMain->quMain->ParamByName("par1")->ParamType=ptInputOutput;
            dmMain->quMain->ParamByName("par1")->DataType=ftInteger;
            dmMain->quMain->ParamByName("par1")->AsInteger=mTrans.id;
            dmMain->quMain->ParamByName("par2")->AsInteger=parent;
            dmMain->quMain->ParamByName("par3")->AsString=mTrans.dname;
            dmMain->quMain->ParamByName("par4")->AsInteger=mTrans.type;
            dmMain->quMain->ParamByName("par5")->AsString=mTrans.ddate;
            if(mTrans.indVal1>-1)
            dmMain->quMain->ParamByName("par6")->AsFloat=mTrans.Val1;
            else dmMain->quMain->ParamByName("par6")->Clear();
            if(mTrans.indVal2>-1)
            dmMain->quMain->ParamByName("par7")->AsFloat=mTrans.Val2;
            else dmMain->quMain->ParamByName("par7")->Clear();
            break;
          case TCustomTransformerLine::ttPower2:
            p2Trans = *((TPowerTwoTransformer *)cTransLine);
            //GRB ADD 16.04.2020 - test trouble ODAC
            dmMain->quMain->Params->Clear();
            //END ADD 
            dmMain->quMain->SQL->Text=sqlP2;
            dmMain->quMain->ParamByName("par1")->ParamType=ptInputOutput;
            dmMain->quMain->ParamByName("par1")->DataType=ftInteger;
            dmMain->quMain->ParamByName("par1")->AsInteger=p2Trans.id;
            dmMain->quMain->ParamByName("par2")->AsString=p2Trans.dname;
            dmMain->quMain->ParamByName("par3")->AsInteger=parent;
            //===== Parameters
            if(p2Trans.indSn >-1)
            dmMain->quMain->ParamByName("par4")->AsFloat=p2Trans.Sn;
            else dmMain->quMain->ParamByName("par4")->Clear();
            if(p2Trans.inddPxx >-1)
            dmMain->quMain->ParamByName("par5")->AsFloat=p2Trans.dPxx;
            else dmMain->quMain->ParamByName("par5")->Clear();
            if(p2Trans.inddPkz >-1)
            dmMain->quMain->ParamByName("par6")->AsFloat=p2Trans.dPkz;
            else dmMain->quMain->ParamByName("par6")->Clear();
            if(p2Trans.indIxx >-1)
            dmMain->quMain->ParamByName("par7")->AsFloat=p2Trans.Ixx;
            else dmMain->quMain->ParamByName("par7")->Clear();
            if(p2Trans.indUkz >-1)
            dmMain->quMain->ParamByName("par8")->AsFloat=p2Trans.Ukz;
            else dmMain->quMain->ParamByName("par8")->Clear();
            if(p2Trans.WHours >-1)
            dmMain->quMain->ParamByName("par9")->AsFloat=p2Trans.WHours;
            else dmMain->quMain->ParamByName("par9")->Clear();
            if(p2Trans.indFHours >-1)
            dmMain->quMain->ParamByName("par10")->AsFloat=p2Trans.FHours;
            else dmMain->quMain->ParamByName("par9")->Clear();
            break;
          case TCustomTransformerLine::ttPower3:
            p3Trans = *((TPowerThreeTransformer *)cTransLine);
            //GRB ADD 16.04.2020 - test trouble ODAC
            dmMain->quMain->Params->Clear();
            //END ADD 
            dmMain->quMain->SQL->Text=sqlP3;
            dmMain->quMain->ParamByName("par1")->ParamType=ptInputOutput;
            dmMain->quMain->ParamByName("par1")->DataType=ftInteger;
            dmMain->quMain->ParamByName("par1")->AsInteger=p3Trans.id;
            dmMain->quMain->ParamByName("par2")->AsString=p3Trans.dname;
            dmMain->quMain->ParamByName("par3")->AsInteger=parent;
             //===== Parameters
            if(p3Trans.indSn>-1)
            dmMain->quMain->ParamByName("par4")->AsFloat=p3Trans.Sn;
            else dmMain->quMain->ParamByName("par4")->Clear();
            if(p3Trans.indSu>-1)
            dmMain->quMain->ParamByName("par5")->AsFloat=p3Trans.Su;
            else dmMain->quMain->ParamByName("par5")->Clear();
            if(p3Trans.indSm>-1)
            dmMain->quMain->ParamByName("par6")->AsFloat=p3Trans.Sm;
            else dmMain->quMain->ParamByName("par6")->Clear();
            if(p3Trans.indSd>-1)
            dmMain->quMain->ParamByName("par7")->AsFloat=p3Trans.Sd;
            else dmMain->quMain->ParamByName("par7")->Clear();
            if(p3Trans.inddPxx>-1)
            dmMain->quMain->ParamByName("par8")->AsFloat=p3Trans.dPxx;
            else dmMain->quMain->ParamByName("par8")->Clear();
            if(p3Trans.inddPkzu>-1)
            dmMain->quMain->ParamByName("par9")->AsFloat=p3Trans.dPkzu;
            else dmMain->quMain->ParamByName("par9")->Clear();
            if(p3Trans.inddPkzm>-1)
            dmMain->quMain->ParamByName("par10")->AsFloat=p3Trans.dPkzm;
            else dmMain->quMain->ParamByName("par10")->Clear();
            if(p3Trans.inddPkzd>-1)
            dmMain->quMain->ParamByName("par11")->AsFloat=p3Trans.dPkzd;
            else dmMain->quMain->ParamByName("par11")->Clear();
            if(p3Trans.indIxx>-1)
            dmMain->quMain->ParamByName("par12")->AsFloat=p3Trans.Ixx;
            else dmMain->quMain->ParamByName("par12")->Clear();
            if(p3Trans.indUkzu>-1)
            dmMain->quMain->ParamByName("par13")->AsFloat=p3Trans.Ukzu;
            else dmMain->quMain->ParamByName("par13")->Clear();
            if(p3Trans.indUkzm>-1)
            dmMain->quMain->ParamByName("par14")->AsFloat=p3Trans.Ukzm;
            else dmMain->quMain->ParamByName("par14")->Clear();
            if(p3Trans.indUkzd>-1)
            dmMain->quMain->ParamByName("par15")->AsFloat=p3Trans.Ukzd;
            else dmMain->quMain->ParamByName("par15")->Clear();
            if(p3Trans.indWHours>-1)
            dmMain->quMain->ParamByName("par16")->AsFloat=p3Trans.WHours;
            else dmMain->quMain->ParamByName("par16")->Clear();
            if(p3Trans.indWHours>-1)
            dmMain->quMain->ParamByName("par17")->AsFloat=p3Trans.FHours;
            else dmMain->quMain->ParamByName("par17")->Clear();
            break;
          case TCustomTransformerLine::ttLine:
            tLine = *((TTransmissionLine *)cTransLine);
            //GRB ADD 16.04.2020 - test trouble ODAC
            dmMain->quMain->Params->Clear();
            //END ADD 
            dmMain->quMain->SQL->Text=sqlTL;
            dmMain->quMain->ParamByName("par1")->ParamType=ptInputOutput;
            dmMain->quMain->ParamByName("par1")->DataType=ftInteger;
            dmMain->quMain->ParamByName("par1")->AsInteger=tLine.id;
            dmMain->quMain->ParamByName("par2")->AsString=tLine.dname;
            dmMain->quMain->ParamByName("par3")->AsInteger=parent;
            //===== Parameters
            if(tLine.indRo>-1)
            dmMain->quMain->ParamByName("par4")->AsFloat=tLine.Ro;
            else dmMain->quMain->ParamByName("par4")->Clear();
            if(tLine.indXo>-1)
            dmMain->quMain->ParamByName("par5")->AsFloat=tLine.Xo;
            else dmMain->quMain->ParamByName("par5")->Clear();
            if(tLine.indL>-1)
            dmMain->quMain->ParamByName("par6")->AsFloat=tLine.L;
            else dmMain->quMain->ParamByName("par6")->Clear();
            if(tLine.indUn>-1)
            dmMain->quMain->ParamByName("par7")->AsFloat=tLine.Un;
            else dmMain->quMain->ParamByName("par7")->Clear();
            break;
            case TCustomTransformerLine::ttReactor:
            tReact = *((TReactor *)cTransLine);
            //GRB ADD 16.04.2020 - test trouble ODAC
            dmMain->quMain->Params->Clear();
            //END ADD 
            dmMain->quMain->SQL->Text=sqlRctr;
            dmMain->quMain->ParamByName("par1")->ParamType=ptInputOutput;
            dmMain->quMain->ParamByName("par1")->DataType=ftInteger;
            dmMain->quMain->ParamByName("par1")->AsInteger=tReact.id;
            dmMain->quMain->ParamByName("par2")->AsString=tReact.dname;
            dmMain->quMain->ParamByName("par3")->AsInteger=parent;
            //===== Parameters
            if(tReact.indUn>-1)
            dmMain->quMain->ParamByName("par4")->AsFloat=tReact.Un;
            else dmMain->quMain->ParamByName("par4")->Clear();
            if(tReact.indSn>-1)
            dmMain->quMain->ParamByName("par5")->AsFloat=tReact.Sn;
            else dmMain->quMain->ParamByName("par5")->Clear();
            if(tReact.indDP>-1)
            dmMain->quMain->ParamByName("par6")->AsFloat=tReact.DP;
            else dmMain->quMain->ParamByName("par6")->Clear();
            if(tReact.indFHours>-1)
            dmMain->quMain->ParamByName("par7")->AsFloat=tReact.FHours;
            else dmMain->quMain->ParamByName("par7")->Clear();
            if(tReact.indCHours>-1)
            dmMain->quMain->ParamByName("par8")->AsFloat=tReact.CHours;
            else dmMain->quMain->ParamByName("par8")->Clear();
            break;
        }
        dmMain->quMain->Execute();

        if (!cTransLine->id)
        { switch (cTransLine->type)
          { case TCustomTransformerLine::ttCurrent:
            case TCustomTransformerLine::ttVoltage:
              mTrans.id=dmMain->quMain->ParamByName("par1")->AsInteger;
              cTransLine->id  = mTrans.id;
              break;
            case TCustomTransformerLine::ttPower2:
              p2Trans.id=dmMain->quMain->ParamByName("par1")->AsInteger;
              cTransLine->id  = p2Trans.id;
              break;
            case TCustomTransformerLine::ttPower3:
              p3Trans.id=dmMain->quMain->ParamByName("par1")->AsInteger;
              cTransLine->id  = p3Trans.id;
              break;
            case TCustomTransformerLine::ttLine:
              tLine.id=dmMain->quMain->ParamByName("par1")->AsInteger;
              cTransLine->id  = tLine.id;
              break;
            case TCustomTransformerLine::ttReactor:
              tReact.id=dmMain->quMain->ParamByName("par1")->AsInteger;
              cTransLine->id  = tReact.id;
              break;
          }
        }
        cTransLine->edit  = false;
      }
      tNode = tNode->GetNext();
    }
    // Удаление удаленных
    for (int i = 0; i < d->removs->Count; i++)
    { TTransformersFormPriv::TDelList *tDL  = (TTransformersFormPriv::TDelList *)d->removs->Items[i];

      switch (tDL->type)
      { case TCustomTransformerLine::ttCurrent:
        case TCustomTransformerLine::ttVoltage:
          //GRB ADD 16.04.2020 - test trouble ODAC
          dmMain->quMain->Params->Clear();
          //END ADD 
          dmMain->quMain->SQL->Text=sqlMDel;
          break;
        case TCustomTransformerLine::ttPower2:
          //GRB ADD 16.04.2020 - test trouble ODAC
          dmMain->quMain->Params->Clear();
          //END ADD 
          dmMain->quMain->SQL->Text=sqlP2Del;
          break;
        case TCustomTransformerLine::ttPower3:
          //GRB ADD 16.04.2020 - test trouble ODAC
          dmMain->quMain->Params->Clear();
          //END ADD 
          dmMain->quMain->SQL->Text=sqlP3Del;
          break;
        case TCustomTransformerLine::ttLine:
          //GRB ADD 16.04.2020 - test trouble ODAC
          dmMain->quMain->Params->Clear();
          //END ADD 
          dmMain->quMain->SQL->Text=sqlTLDel;
          break;
        case TCustomTransformerLine::ttReactor:
          //GRB ADD 16.04.2020 - test trouble ODAC
          dmMain->quMain->Params->Clear();
          //END ADD 
          dmMain->quMain->SQL->Text=sqlRctrDel;
          break;
      }
      dmMain->quMain->ParamByName("par1")->AsInteger=tDL->id;
      dmMain->quMain->Execute();

    }
    d->clearRemovs();
    dmMain->orases->Commit();
    EditRec = false;
  }
  catch (Exception &e)
  { dmMain->orases->Rollback();
    if (tNode)
      tNode->Selected = true;
    Application->ShowException(&e);
  }
  // Обновление содержимого экранных компонентов
  tvTransfms->Selected  = oldNode;
}
//---------------------------------------------------------------------------

/*! Обновление данных
*/
void __fastcall TTransformersForm::vRefresh(TObject *Sender)
{
  d->editCatch = false;
  //d->clearTree(NULL);
  tvTransfms->Items->BeginUpdate();
  tvTransfms->Items->Clear();
  ReadTreeNode(NULL);
  tvTransfms->Selected  = tvTransfms->Items->GetFirstNode();
  tvTransfmsChange(Owner, tvTransfms->Selected);
  tvTransfms->Items->EndUpdate();
  d->editCatch = true;
}
//---------------------------------------------------------------------------
/*! Удаление объекта
*/
void __fastcall TTransformersForm::vDelete(TObject *Sender)
{
  TCustomTransformerLine  *tTransLine = (TCustomTransformerLine *)tvTransfms->Selected->Data;
  if (tTransLine->type == TCustomTransformerLine::ttNone)
  { Application->MessageBox(Reconst_smes29_13.c_str(),
                            Caption.c_str(), MB_OK | MB_ICONINFORMATION);
    return;
  }
  if (Application->MessageBox((Reconst_smes29_14 + tvTransfms->Selected->Text + ">.").c_str(),
                              Caption.c_str(), MB_YESNO | MB_ICONQUESTION) == IDYES)
  { if (tTransLine->id)
    { TTransformersFormPriv::TDelList *tDL  =
        new TTransformersFormPriv::TDelList(tTransLine->id, TCustomTransformerLine::TTransLineTypes(tTransLine->type));
      d->removs->Add(tDL);
    }
    tvTransfms->Selected->Delete();
    tvTransfmsChange(Owner, tvTransfms->Selected);
    EditRec = true;
  }
}
//---------------------------------------------------------------------------
/*! Разрешение или запрещение пунктов меню
*/
void __fastcall TTransformersForm::vEditClick(TObject *Sender)
{
  TTreeView *tTV  = dynamic_cast<TTreeView *>(ActiveControl);
  if (tTV && tTV == tvTransfms)
  { mnPaste->Enabled  = Clipboard()->HasFormat(d->CF_TRANSFMS_TREENODE);
    mnCut->Enabled    = tTV->Selected;
    mnCopy->Enabled   = tTV->Selected;
    mnDelete->Enabled = tTV->Selected;
    mnSelect->Enabled = false;
  }
  else
    inherited::vEditClick(Sender);
}
//---------------------------------------------------------------------------
void __fastcall TTransformersForm::vAnyEditClick(TObject* Sender)
{
  TComponent  *pMenu      = dynamic_cast<TComponent *>(Sender);
  TTreeNode   *selNode;
  TTreeView   *tvControl  = dynamic_cast<TTreeView *>(ActiveControl);
  if (tvControl)
    try
    { if (pMenu)
        switch (pMenu->Tag)
        { case 1: // Cut
            if (Clipboard()->HasFormat(d->CF_TRANSFMS_TREENODE))
              ((TTreeNode *)Clipboard()->GetAsHandle(d->CF_TRANSFMS_TREENODE))->Cut  = false;
            tvControl->Selected->Cut  = true;
            Clipboard()->SetAsHandle(d->CF_TRANSFMS_TREENODE, (UINT)tvControl->Selected);
            break;
          case 2: // Copy
            if (Clipboard()->HasFormat(d->CF_TRANSFMS_TREENODE))
              ((TTreeNode *)Clipboard()->GetAsHandle(d->CF_TRANSFMS_TREENODE))->Cut  = false;
            Clipboard()->SetAsHandle(d->CF_TRANSFMS_TREENODE, (UINT)tvControl->Selected);
            break;
          case 3: // Paste
            selNode = (TTreeNode *)Clipboard()->GetAsHandle(d->CF_TRANSFMS_TREENODE);
            if (!selNode)
              break;
            if (AcceptNode(tvControl->Selected, selNode)
                && (d->eOper == TTransformersFormPriv::opMove
                    || d->eOper == TTransformersFormPriv::opCopy))
            { if(selNode->Cut)
              { Clipboard()->Clear();
                d->eOper  = TTransformersFormPriv::opMove;
              }
              else
                d->eOper  = TTransformersFormPriv::opCopy;
              changeNode(tvControl->Selected, selNode);
            }
            else
            { selNode->Cut  = false;
              Application->MessageBox(Reconst_smes29_15.c_str(),
                                      Caption.c_str(), MB_OK | MB_ICONINFORMATION);
            }
            break;
          case 4: // Delete
            vDelete(Sender);
            break;
        }
    }
    catch (Exception&e)
    {
    }
  else
    inherited::vAnyEditClick(Sender);
}
//---------------------------------------------------------------------------
/*! Создание нового трансформатора
*/
void __fastcall TTransformersForm::NewTransLine(TObject *Sender)
{
  //===== Проверка на правильность вызова
  TAction *tAction  = dynamic_cast<TAction *>(Sender);
  if (!tAction)
    return;
  if (tAction->Tag != TCustomTransformerLine::ttCurrent
      && tAction->Tag != TCustomTransformerLine::ttVoltage
      && tAction->Tag != TCustomTransformerLine::ttPower2
      && tAction->Tag != TCustomTransformerLine::ttPower3
      && tAction->Tag != TCustomTransformerLine::ttLine
      && tAction->Tag != TCustomTransformerLine::ttReactor)
    return;

  if (!AllowChangeNode())//Owner, NULL))
    return;

  TCustomTransformerLine  *tTransLine = NULL;   //===== Новый трансформатор
  TTreeNode               *tNode      = NULL;   //===== Новый элемент дерева
  try
  { if (tvTransfms->Selected->HasChildren && !tvTransfms->Selected->getFirstChild())
      ReadTreeNode(tvTransfms->Selected);
    tTransLine  = d->createTransLine(TCustomTransformerLine::TTransLineTypes(tAction->Tag),
                                      (double *)NULL, (short *)NULL, true);
    if (!tTransLine)
      throw Exception(Reconst_smes29_16);
    tNode   = d->createNode(((TCustomTransformerLine *)tvTransfms->Selected->Data)->type != TCustomTransformerLine::ttNone
                                ? tvTransfms->Selected->Parent
                                : tvTransfms->Selected,
                              tTransLine);
    if (!tNode)
      throw Exception(Reconst_smes29_17);

    switch (tTransLine->type)
    { case TCustomTransformerLine::ttCurrent:
        tNode->ImageIndex = imCurrent;
        break;
      case TCustomTransformerLine::ttVoltage:
        tNode->ImageIndex = imVoltage;
        break;
      case TCustomTransformerLine::ttPower2:
        tNode->ImageIndex = imPower2;
        break;
      case TCustomTransformerLine::ttPower3:
        tNode->ImageIndex = imPower3;
        break;
      case TCustomTransformerLine::ttLine:
        tNode->ImageIndex = imLine;
        break;
      case TCustomTransformerLine::ttReactor:
        tNode->ImageIndex = imReactor;
        break;
    }
    tNode->SelectedIndex  = tNode->ImageIndex;
    tNode->Selected = true;
    EditRec = true;
  }
  catch (Exception &e)
  { d->clearData(tTransLine);
    tTransLine  = NULL;
    if (tNode)
    { tNode->Data = NULL;
      delete  tNode;
    }
    Application->ShowException(&e);
  }
}
//---------------------------------------------------------------------------
/*! Вычитка списка листьев дерева, где:
    \param Owner - указатель на родителя листьев
*/
bool __fastcall TTransformersForm::ReadTreeNode(TObject *Sender)
{
  TCustomTransformerLine  *tTransLine = NULL;               //===== Трансформатор
  TTreeNode *Parent = dynamic_cast<TTreeNode *>(Sender);    //===== Родительский лист

  try
  {
    dmMain->oqCursor->Params->Clear();
    dmMain->oqCursor->SQL->Text="begin "+SchemeName+"EDITTRANSFORMER_LINE_PG.ReadNode_p(:par1,:par2,:par3); end;";
    dmMain->oqCursor->ParamByName("par3")->ParamType = ptOutput;
    dmMain->oqCursor->ParamByName("par3")->DataType = ftCursor;
    if (Parent)
     {
     dmMain->oqCursor->ParamByName("par1")->AsInteger=((TCustomTransformerLine *)Parent->Data)->id;
     dmMain->oqCursor->ParamByName("par2")->AsInteger=1;
     }
    else
     {
     dmMain->oqCursor->ParamByName("par1")->Clear();
     dmMain->oqCursor->ParamByName("par2")->Clear();
     }

    double  tVals[PARAM_COUNT];
    short   tIndic[PARAM_COUNT];
    dmMain->oqCursor->Execute();
    while(!dmMain->oqCursor->Eof){
      if(!dmMain->oqCursor->FieldByName("f_val1")->IsNull){
      tIndic[0]=0;
      tVals[0]=dmMain->oqCursor->FieldByName("f_val1")->AsFloat;}
      else tIndic[0]=-1;
      if(!dmMain->oqCursor->FieldByName("f_val2")->IsNull){
      tIndic[1]=0;
      tVals[1]=dmMain->oqCursor->FieldByName("f_val2")->AsFloat;}
      else tIndic[1]=-1;
      if(!dmMain->oqCursor->FieldByName("f_val3")->IsNull){
      tIndic[2]=0;
      tVals[2]=dmMain->oqCursor->FieldByName("f_val3")->AsFloat;}
      else tIndic[2]=-1;
      if(!dmMain->oqCursor->FieldByName("f_val4")->IsNull){
      tIndic[3]=0;
      tVals[3]=dmMain->oqCursor->FieldByName("f_val4")->AsFloat;}
      else tIndic[3]=-1;
      if(!dmMain->oqCursor->FieldByName("f_val5")->IsNull){
      tIndic[4]=0;
      tVals[4]=dmMain->oqCursor->FieldByName("f_val5")->AsFloat;}
      else tIndic[4]=-1;
      if(!dmMain->oqCursor->FieldByName("f_val6")->IsNull){
      tIndic[5]=0;
      tVals[5]=dmMain->oqCursor->FieldByName("f_val6")->AsFloat;}
      else tIndic[5]=-1;
      if(!dmMain->oqCursor->FieldByName("f_val7")->IsNull){
      tIndic[6]=0;
      tVals[6]=dmMain->oqCursor->FieldByName("f_val7")->AsFloat;}
      else tIndic[6]=-1;
      if(!dmMain->oqCursor->FieldByName("f_val8")->IsNull){
      tIndic[7]=0;
      tVals[7]=dmMain->oqCursor->FieldByName("f_val8")->AsFloat;}
      else tIndic[7]=-1;
      if(!dmMain->oqCursor->FieldByName("f_val9")->IsNull){
      tIndic[8]=0;
      tVals[8]=dmMain->oqCursor->FieldByName("f_val9")->AsFloat;}
      else tIndic[8]=-1;
      if(!dmMain->oqCursor->FieldByName("f_val10")->IsNull){
      tIndic[9]=0;
      tVals[9]=dmMain->oqCursor->FieldByName("f_val10")->AsFloat;}
      else tIndic[9]=-1;
      if(!dmMain->oqCursor->FieldByName("f_val11")->IsNull){
      tIndic[10]=0;
      tVals[10]=dmMain->oqCursor->FieldByName("f_val11")->AsFloat;}
      else tIndic[10]=-1;
      if(!dmMain->oqCursor->FieldByName("f_val12")->IsNull){
      tIndic[11]=0;
      tVals[11]=dmMain->oqCursor->FieldByName("f_val12")->AsFloat;}
      else tIndic[11]=-1;
      if(!dmMain->oqCursor->FieldByName("f_val13")->IsNull){
      tIndic[12]=0;
      tVals[12]=dmMain->oqCursor->FieldByName("f_val13")->AsFloat;}
      else tIndic[12]=-1;
      if(!dmMain->oqCursor->FieldByName("f_val14")->IsNull){
      tIndic[13]=0;
      tVals[13]=dmMain->oqCursor->FieldByName("f_val14")->AsFloat;}
      else tIndic[13]=-1;
      tTransLine  = d->createTransLine(TCustomTransformerLine::TTransLineTypes(dmMain->oqCursor->FieldByName("f_type")->AsInteger), tVals, tIndic);
      if (!tTransLine)
        throw Exception(Reconst_smes29_18);
      tTransLine->edit  = dmMain->oqCursor->FieldByName("f_edit")->AsInteger;
      tTransLine->id    = dmMain->oqCursor->FieldByName("f_id")->AsInteger;
      strcpy(tTransLine->name,dmMain->oqCursor->FieldByName("f_name")->AsString.c_str());
      strcpy(tTransLine->date, "");
      if (!d->createNode(Parent, tTransLine))
        throw Exception(Reconst_smes29_19);
      dmMain->oqCursor->Next();
    }

  }catch (Exception &e){
    Application->ShowException(&e);
    return false;
  }

  return  true;
}
//---------------------------------------------------------------------------
/*! Проверка на возможность переходить на новый лист,
    путем проверки правильности заполнения данных трансформатора, где:
    \param Sender - Указатель на вызывающий объект
    \param Node - Указатель на лист, с которого хотят перейти

    \return true если можно, иначе - false
*/
bool __fastcall TTransformersForm::AllowChangeNode()
{
  if (!tvTransfms->Selected)
    return true;
  else
    if (!tvTransfms->Selected->Data)
      return  true;

  TWinControl *tWC  = NULL;

  bool  f = true;
  if (EditRec)
  { try
    { tWC = NameEdit;
      NameEdit->Text  = NameEdit->Text.Trim();
      if (!NameEdit->Text.Length())
        throw Exception(Reconst_smes29_20);
      //===== Убрано т.к. временно от даты отказались
      //tWC = DateMEdit;
      //TDateTime(DateMEdit->Text);

      switch (((TCustomTransformerLine *)tvTransfms->Selected->Data)->type)
      { case TCustomTransformerLine::ttCurrent:
        case TCustomTransformerLine::ttVoltage:
          tWC = mVal1Edit;
          if (mVal1Edit->Text.Trim().Length())
            mVal1Edit->Text.ToDouble();
          tWC = mVal2Edit;
          if (mVal2Edit->Text.Trim().Length())
            mVal2Edit->Text.ToDouble();
          break;
        case TCustomTransformerLine::ttPower2:
          tWC = p2SnEdit;
          if (p2SnEdit->Text.Trim().Length())
            p2SnEdit->Text.ToDouble();
          tWC = p2dPxxEdit;
          if (p2dPxxEdit->Text.Trim().Length())
            p2dPxxEdit->Text.ToDouble();
          tWC = p2dPkzEdit;
          if (p2dPkzEdit->Text.Trim().Length())
            p2dPkzEdit->Text.ToDouble();
          tWC = p2IxxEdit;
          if (p2IxxEdit->Text.Trim().Length())
            p2IxxEdit->Text.ToDouble();
          tWC = p2UkzEdit;
          if (p2UkzEdit->Text.Trim().Length())
            p2UkzEdit->Text.ToDouble();
          break;
        case TCustomTransformerLine::ttPower3:
          tWC = p3SnEdit;
          if (p3SnEdit->Text.Trim().Length())
            p3SnEdit->Text.ToDouble();
          tWC = p3SuEdit;
          if (p3SuEdit->Text.Trim().Length())
            p3SuEdit->Text.ToDouble();
          tWC = p3SmEdit;
          if (p3SmEdit->Text.Trim().Length())
            p3SmEdit->Text.ToDouble();
          tWC = p3SdEdit;
          if (p3SdEdit->Text.Trim().Length())
            p3SdEdit->Text.ToDouble();
          tWC = p3dPxxEdit;
          if (p3dPxxEdit->Text.Trim().Length())
            p3dPxxEdit->Text.ToDouble();
          tWC = p3dPkzuEdit;
          if (p3dPkzuEdit->Text.Trim().Length())
            p3dPkzuEdit->Text.ToDouble();
          tWC = p3dPkzmEdit;
          if (p3dPkzmEdit->Text.Trim().Length())
            p3dPkzmEdit->Text.ToDouble();
          tWC = p3dPkzdEdit;
          if (p3dPkzdEdit->Text.Trim().Length())
            p3dPkzdEdit->Text.ToDouble();
          tWC = p3IxxEdit;
          if (p3IxxEdit->Text.Trim().Length())
            p3IxxEdit->Text.ToDouble();
          tWC = p3UkzuEdit;
          if (p3UkzuEdit->Text.Trim().Length())
            p3UkzuEdit->Text.ToDouble();
          tWC = p3UkzmEdit;
          if (p3UkzmEdit->Text.Trim().Length())
            p3UkzmEdit->Text.ToDouble();
          tWC = p3UkzdEdit;
          if (p3UkzdEdit->Text.Trim().Length())
            p3UkzdEdit->Text.ToDouble();
          break;
        case TCustomTransformerLine::ttLine:
          tWC = tlRoEdit;
          if (tlRoEdit->Text.Trim().Length())
            tlRoEdit->Text.ToDouble();
          tWC = tlXoEdit;
          if (tlXoEdit->Text.Trim().Length())
            tlXoEdit->Text.ToDouble();
          tWC = tlLEdit;
          if (tlLEdit->Text.Trim().Length())
            tlLEdit->Text.ToDouble();
          tWC = tlUnEdit;
          if (tlUnEdit->Text.Trim().Length())
            tlUnEdit->Text.ToDouble();
          break;
        case TCustomTransformerLine::ttReactor:
          tWC = RctrUnEdit;
          if (RctrUnEdit->Text.Trim().Length())
            RctrUnEdit->Text.ToDouble();
          tWC = RctrSnEdit;
          if (RctrSnEdit->Text.Trim().Length())
            RctrSnEdit->Text.ToDouble();
          tWC = RctrDPEdit;
          if (RctrDPEdit->Text.Trim().Length())
            RctrDPEdit->Text.ToDouble();
          tWC = RctrFHoursEdit;
          if (RctrFHoursEdit->Text.Trim().Length())
            RctrFHoursEdit->Text.ToDouble();
          tWC = RctrFHoursEdit;
          if (RctrCHoursEdit->Text.Trim().Length())
            RctrCHoursEdit->Text.ToDouble();
          break;
      }
    }
    catch (EConvertError &e)
    { f = false;
      Application->ShowException(&Exception(Reconst_smes29_21 + e.Message));
      if (tWC)
        tWC->SetFocus();
    }
  }
  return  f;
}
//---------------------------------------------------------------------------
/*! Разрешение операции над листом, где:
    \param srcNode - исходный лист
    \param dstNode - лист получатель

    \return true вслучае разрешения, иначе - false
*/
bool __fastcall TTransformersForm::AcceptNode(TTreeNode *srcNode, TTreeNode *dstNode)
{
  TShiftState State;

  try
  { if (Access == accRead)
      throw Exception(Reconst_smes29_22);
    d->eOper  = TTransformersFormPriv::opNone;
    if (GetKeyState(VK_CONTROL) & 0x8000)
      State << ssCtrl;
    if (GetKeyState(VK_SHIFT) & 0x8000)
      State << ssShift;
    // проверка на наличие данных в точках
    if (!srcNode || !srcNode->Data
        || ((TCustomTransformerLine *)srcNode->Data)->type == TCustomTransformerLine::ttNone
        || !dstNode || !dstNode->Data
        || ((TCustomTransformerLine *)dstNode->Data)->type != TCustomTransformerLine::ttNone
        || srcNode == dstNode)
      return false;
    // анализ операции
    if (State.Contains(ssCtrl) && !dstNode->HasAsParent(srcNode))
    { d->eOper  = TTransformersFormPriv::opCopy;
      return  true;
    }
    if (srcNode->Parent != dstNode && !dstNode->HasAsParent(srcNode))
    { d->eOper  = TTransformersFormPriv::opMove;
      return  true;
    }
  }
  catch (Exception &e)
  { Application->ShowException(&e);
    return  false;
  }
  return false;
}
//---------------------------------------------------------------------------
/*! Копирование или перенос листа, где:
    \param srcNode - исходный лист
    \param dstNode - лист получатель
*/
void __fastcall TTransformersForm::changeNode(TTreeNode *srcNode, TTreeNode *dstNode)
{
  TCustomTransformerLine  *tTransLine = NULL;
  TTreeNode               *tNode      = NULL;

  try
  { Screen->Cursor  = crHourGlass;
    if (!srcNode || !srcNode->Data)
      return;
    if (dstNode && dstNode->HasChildren && !dstNode->getFirstChild())
      ReadTreeNode(dstNode);

    switch (d->eOper)
    { case TTransformersFormPriv::opMove:
        srcNode->MoveTo(dstNode, naAddChild);
        if (!((TCustomTransformerLine *)srcNode->Data)->edit)
          ((TCustomTransformerLine *)srcNode->Data)->edit  = true;
        break;
      case TTransformersFormPriv::opCopy:
        tTransLine  = d->createTransLine(TCustomTransformerLine::TTransLineTypes(((TCustomTransformerLine *)srcNode->Data)->type),
                                          (TCustomTransformerLine *)srcNode->Data, true);
        if (!tTransLine)
          throw Exception(Reconst_smes29_23);
        tTransLine->id  = 0;
        tNode = d->createNode(dstNode, tTransLine);
        if (!tNode)
          throw Exception(Reconst_smes29_24);
        tNode->ImageIndex     = srcNode->ImageIndex;
        tNode->SelectedIndex  = srcNode->SelectedIndex;
        tTransLine->edit  = true;
        if (srcNode->HasChildren)
          copyChildNodes(srcNode, tNode);
    }
    EditRec = true;
  }
  catch (Exception &exception)
  { d->clearData(tTransLine);
    tTransLine  = NULL;
    if (tNode)
    { tNode->Data = NULL;
      delete  tNode;
    }
    Application->ShowException(&exception);
  }
  Screen->Cursor  = crDefault;//crArrow;
}
//---------------------------------------------------------------------------
/*! Копирование всех дочерних листьев, где:
    \param srcNode - исходный лист, чьих детей нужно скопировать
    \param dstNode - лист получатель
*/
void __fastcall TTransformersForm::copyChildNodes(TTreeNode *srcNode, TTreeNode *dstNode)
{
  ReadTreeNode(srcNode);
  TTreeNode *tNode  = srcNode->getFirstChild();
  while (tNode)
  { changeNode(dstNode, tNode);
    tNode = tNode->getNextSibling();
  }
}
//---------------------------------------------------------------------------

void __fastcall TTransformersForm::iaMonExecute(TObject *Sender)
{
  if (!tvTransfms->Selected)
    return;
  if (!tvTransfms->Selected->Data)
    return;

  TChangeTransformersForm *ctf  =
    new TChangeTransformersForm(this, (TCustomTransformerLine *)tvTransfms->Selected->Data);
  try
  { //if (AllowChangeNode(Sender, tNode) && ctf->ShowModal() == mrOk)
    if (AllowChangeNode() && ctf->ShowModal() == mrOk)
    { //strcpy(pt->date, ctf->dtpData->DateTime.FormatString("dd.mm.yyyy hh:nn:ss").c_str());
      //pt->Val1  = ctf->eSetVal1->Text.ToDouble();
      //pt->Val2  = ctf->eSetVal2->Text.ToDouble();
      //EditRec = true;

      tvTransfmsChange(Sender, tvTransfms->Selected);
    }
  }
  __finally
  { delete  ctf;
    ctf = NULL;
  }
}
//---------------------------------------------------------------------------
/*! Производится расчет потерь
*/
void __fastcall TTransformersForm::CalcLossParamActionExecute(
      TObject *Sender)
{
  if (!tvTransfms->Selected && !tvTransfms->Selected->Data)
    return;

  TCustomTransformerLine  *tTransLine = (TCustomTransformerLine *)tvTransfms->Selected->Data;
  if (tTransLine->type == TCustomTransformerLine::ttNone)
  { Application->MessageBox(Reconst_smes29_25.c_str(),
                            Caption.c_str(), MB_OK | MB_ICONINFORMATION);
    return;
  }
  if (tTransLine->id == 0)
  { AnsiString  tStr  = AnsiString(Reconst_smes29_26) +
                          ((tTransLine->type == TCustomTransformerLine::ttLine)
                            ? (Reconst_smes29_27)
                            : (Reconst_smes29_28)) +
                          Reconst_smes29_29;
    Application->MessageBox(tStr.c_str(),
                            Caption.c_str(),
                            MB_OK | MB_ICONINFORMATION);
    return;
  }
    dmMain->oqCursor->Params->Clear();
    dmMain->oqCursor->SQL->Text="begin "+SchemeName+"EDITTRANSFORMER_LINE_PG.CalcLossParam_p(:par1,:par2); end;";
    dmMain->oqCursor->ParamByName("par2")->ParamType = ptOutput;
    dmMain->oqCursor->ParamByName("par2")->DataType = ftCursor;

  long  params[SELECTCOUNT];    //===== Массив идентификаторов параметров
  unsigned long CountStr  = 0;

  try
  {
    dmMain->oqCursor->ParamByName("par1")->AsInteger=tTransLine->id;
    memset(params, 0, sizeof(params));
    dmMain->oqCursor->Execute();
    int i=0;
    while(!dmMain->oqCursor->Eof&&i<SELECTCOUNT){
    params[i]=dmMain->oqCursor->FieldByName("nconnectionparam")->AsInteger;
    dmMain->oqCursor->Next();
    i++ ;
    }
    CountStr=i;
    if (CountStr == 0)
      throw Exception(AnsiString("У ") +
                          ((tTransLine->type == TCustomTransformerLine::ttLine)
                            ? (Reconst_smes29_30)
                            : (Reconst_smes29_31)) +
                          Reconst_smes29_32);

    TfmParameterPointsList  *paramFrm = new TfmParameterPointsList(this, params, CountStr, Access);
    try
    { switch (tTransLine->type)
      { case TCustomTransformerLine::ttCurrent:
        case TCustomTransformerLine::ttVoltage:
          paramFrm->Caption = Reconst_smes29_34;
          break;
        case TCustomTransformerLine::ttPower2:
          paramFrm->Caption = Reconst_smes29_35;
          break;
        case TCustomTransformerLine::ttPower3:
          paramFrm->Caption = Reconst_smes29_283;
          break;
        case TCustomTransformerLine::ttLine:
          paramFrm->Caption = Reconst_smes29_284;
          break;
        case TCustomTransformerLine::ttReactor:
          paramFrm->Caption = Reconst_smes29_300;
          break;
      }
      paramFrm->Caption = paramFrm->Caption + tTransLine->name;
      paramFrm->ShowModal();
    }
    __finally
    { delete  paramFrm;
    }
  }
  catch (Exception &e)
  { Application->ShowException(&e);
    
  }
}
//---------------------------------------------------------------------------
/*! Установка времени работы трансформаторов
*/
void __fastcall TTransformersForm::SetWorkTimeActionExecute(
      TObject *Sender)
{
  TTreeNode *tNode  = tvTransfms->Selected;
  if (!tNode || !tNode->Data||((TCustomTransformerLine *)tNode->Data)->type == TCustomTransformerLine::ttNone
      || ((TCustomTransformerLine *)tNode->Data)->type == TCustomTransformerLine::ttLine)
    return;
  TCustomTransformerLine  *tTransLine = (TCustomTransformerLine *)tNode->Data;

  if(tTransLine->id==0){
    AnsiString  tStr  = AnsiString(Reconst_smes29_285) +((tTransLine->type == TCustomTransformerLine::ttLine)
                            ? (Reconst_smes29_286)
                            : (Reconst_smes29_287)) +
                          Reconst_smes29_288;
    Application->MessageBox(tStr.c_str(),Caption.c_str(),MB_OK | MB_ICONINFORMATION);
    return;
  }
  long  tId = tTransLine->id;
  try{
    TList *tList  = NULL;
    try{
     dmMain->oqCursor->Params->Clear();
     dmMain->oqCursor->SQL->Text="begin "+SchemeName+"EDITTRANSFORMER_LINE_PG.WorkTime_p(:par1,:par2); end;";
     dmMain->oqCursor->ParamByName("par2")->ParamType = ptOutput;
     dmMain->oqCursor->ParamByName("par2")->DataType = ftCursor;
      dmMain->oqCursor->ParamByName("par1")->AsInteger=tId;
      dmMain->oqCursor->Execute();
      tList = new TList();
      while(!dmMain->oqCursor->Eof){
        TTimeInfo *tti  = new TTimeInfo;
        tti->nperiod=dmMain->oqCursor->FieldByName("naccperiod")->AsInteger;
        if(!dmMain->oqCursor->FieldByName("nworkinghours")->IsNull)
          tti->f1=dmMain->oqCursor->FieldByName("nworkinghours")->AsFloat;
        else
          tti->indic[0]=-1;
        if(!dmMain->oqCursor->FieldByName("nfullhours")->IsNull)
          tti->f2=dmMain->oqCursor->FieldByName("nfullhours")->AsFloat;
        else
          tti->indic[1]=-1;
        tList->Add(tti);
        dmMain->oqCursor->Next();
      }
      TfmWorkTime *f  = new TfmWorkTime(this, tList, (Access == accWrite) && (customer_id != 1&&customer_id != 51));
      try{
        f->Caption=Reconst_smes29_299;
        if (f->ShowModal() == mrOk){
          oqSetWorkTimeActionExecute->ParamByName("par1")->AsInteger=tId;
          for(int i=2;i<=4;i++){
            oqSetWorkTimeActionExecute->ParamByName("par"+IntToStr(i))->Length=1;
            oqSetWorkTimeActionExecute->ParamByName("par"+IntToStr(i))->Clear();
          }
          for(int i=1;i<=tList->Count;i++){
            TTimeInfo *tti  = (TTimeInfo *)tList->Items[i-1];
            for(int j=2;j<=4;j++)
            oqSetWorkTimeActionExecute->ParamByName("par"+IntToStr(j))->Length=i;
            oqSetWorkTimeActionExecute->ParamByName("par2")->ItemAsInteger[i]=tti->nperiod;
            if(tti->indic[0]>-1)
              oqSetWorkTimeActionExecute->ParamByName("par3")->ItemAsInteger[i]=tti->f1;
            else
              oqSetWorkTimeActionExecute->ParamByName("par3")->ItemClear(i);
            if(tti->indic[1]>-1)
               oqSetWorkTimeActionExecute->ParamByName("par4")->ItemAsInteger[i]=tti->f2;
            else
             oqSetWorkTimeActionExecute->ParamByName("par4")->ItemClear(i);
          }
          oqSetWorkTimeActionExecute->Execute();
          dmMain->orases->Commit();
        }
      }__finally{
        delete f;
      }
    }__finally{
      for(int i = 0; i < tList->Count; ++i)
        delete  (TTimeInfo *)tList->Items[i];
      tList->Clear();
      delete  tList;
    }
  }catch (Exception &e){
    dmMain->orases->Rollback();
    Application->ShowException(&e);
  }
}
//---------------------------------------------------------------------------
void __fastcall TTransformersForm::aSpezParExecute(TObject *Sender)
{
  TTreeNode *sNode=tvTransfms->Selected;
  if(!sNode||!sNode->Data)
    return;
  if(((TCustomTransformerLine *)tvTransfms->Selected->Data)->id)
    TfmSpecParam::fmSpecParamShow(this,((TCustomTransformerLine *)tvTransfms->Selected->Data)->id,0);
}
//---------------------------------------------------------------------------
void __fastcall TTransformersForm::aBorderParExecute(TObject *Sender)
{
  TTreeNode *sNode=tvTransfms->Selected;
  if(!sNode||!sNode->Data)
    return;
  if(((TCustomTransformerLine *)tvTransfms->Selected->Data)->id)
    TfmSpecParam::fmSpecParamShow(this,((TCustomTransformerLine *)tvTransfms->Selected->Data)->id,1);
}
//---------------------------------------------------------------------------

void __fastcall TTransformersForm::NewReactorActionExecute(
      TObject *Sender)
{
  TPoint  tP(NewReactorTBtn->
              ClientToScreen(TPoint(NewReactorTBtn->Left,
                                    NewReactorTBtn->Top + NewReactorTBtn->Height)));
  NewReactorMenu->Popup(tP.x, tP.y);

}
//---------------------------------------------------------------------------


