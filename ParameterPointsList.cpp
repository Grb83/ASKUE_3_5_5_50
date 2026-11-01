//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#include "ParameterPointsList.h"
#include "unDataMod.h"
#include "Reconst.hpp"

//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "DBAccess"
#pragma link "MemDS"
#pragma link "Ora"
#pragma resource "*.dfm"
#define TI_USED         0     //!< Используемый расход
#define TI_SHARED       1     //!< Долевые потери
#define TI_PARALEL      2     //!< Паралельные присоединения
#define TI_RELATED      3     //!< Зависимые присоединения
#define MAXCOUNTROW     100   //!< Количество вычитываемых строк из БД
#define FIRSTVISCOL     1     //!< Номер первой видимой колонки в StringGrid'е
#define POWER3_CONT     3     //!< Количество параметров для 3-хобмоточного трансформатора
#define TI_UP           0     //!< Высокая обмотка
#define TI_MIDDLE       1     //!< Средняя обмотка
#define TI_DOWN         2     //!< Низкая обмотка
#define imCChckFldr     24    //!< Индекс иконки "Закрытая папка c галочкой"
#define imOChckFldr     25    //!< Индекс иконки "Открытая папка c галочкой"
#define imCFldr         4     //!< Индекс иконки "Закрытая папка"
#define imOFldr         5     //!< Индекс иконки "Открытая папка"
#define imPoint         0     //!< Индекс иконки "Точка"
#define imParam         22    //!< Индекс иконки "Параметр (подточка)"
#define imParamChck     23    //!< Индекс иконки "Параметр (подточка)"
#define imPower2        26    //!< Индекс иконки "Силовой двухобмоточный трансформатор"
#define imPower3        27    //!< Индекс иконки "Силовой трехобмоточный трансформатор"
#define TT_FOLDER       2     //!< Тип папки при выборке из БД
#define TT_POINT        3     //!< Тип точки при выборке из БД
#define TT_PARAM        4     //!< Тип параметра точки при выборке из БД
#define TT_POWER2       243   //!< Тип 2-х обмоточного трансформатора при выборке из БД
#define TT_POWER3       244   //!< Тип 3-х обмоточного трансформатора при выборке из БД
//---------------------------------------------------------------------------

__fastcall TfmParameterPointsList::TfmParameterPointsList(TComponent* Owner, long *paramCid, int paramCnt, TAccess a)
        : TMainForm(Owner,NULL,a),CurrRow(0)
{
  lastPage      = 5;
  FParamCid     = paramCid;
  FParamCidCnt  = paramCnt;
  tcSelectParams->TabIndex    = TI_USED;
  Power3TabControl->TabIndex  = TI_UP;
  vRefresh(NULL);
  lastPage      = TI_USED;
}
//---------------------------------------------------------------------------

void __fastcall TfmParameterPointsList::vDelete(TObject *Sender)
{
  TTreeNode *tmp;

  if (tcSelectParams->TabIndex == TI_PARALEL)
  { if (tvParamView->Selected)
      switch (MessageBox(this->Handle,
              AnsiString(Reconst_smes50_10+
                            tvParamView->Selected->Text+">?").c_str(),
                          Reconst_smes50_11.c_str(),
                          MB_YESNO | MB_ICONQUESTION))
      { case IDYES:
          tmp = tvParamView->Selected->getNextSibling();
          if (!tmp)
            tmp = tvParamView->Selected->getPrevSibling();
          if (!tmp)
            tmp = tvParamView->Selected->Parent;
          if (tvParamView->Selected->ImageIndex == imParamChck)
          { tvParamView->Selected->Parent->ImageIndex     = imOFldr;
            tvParamView->Selected->Parent->SelectedIndex  = imOFldr;
          }
          tvParamView->Selected->Delete();
          tvParamView->Selected = tmp;
          if (tmp && tmp->Level == 0 && !tmp->HasChildren)
          { tvParamView->Selected = tmp->getNextSibling();
            if (!tvParamView->Selected)
              tvParamView->Selected = tmp->getPrevSibling();
            tmp->Delete();
          }
          EditRec = true;
          break;
      }
      return;
  }
  if (sgPointsList->Cells[1][0].IsEmpty())
    return;
  AnsiString  title = sgPointsList->Selection.Bottom == sgPointsList->Selection.Top
                        ? AnsiString(Reconst_smes50_12) + sgPointsList->Cells[1][sgPointsList->Row] + "?"
                        : AnsiString(Reconst_smes50_13);
  if (Application->MessageBox(title.c_str(), Application->Title.c_str(),
                              MB_YESNO | MB_ICONQUESTION | MB_DEFBUTTON2) == ID_YES)
  { int b = sgPointsList->Selection.Bottom;
    int t = sgPointsList->Selection.Top;
    int c = sgPointsList->RowCount;
    for (int i = 0; i < c - b - 1; i++)
      sgPointsList->Rows[t + i]->Text = sgPointsList->Rows[b + i + 1]->Text;
    for (int i = c - b + t; i <= c; i++)
      sgPointsList->Rows[i - 1]->Text = "";
    sgPointsList->RowCount  -= b - t;
    if (sgPointsList->RowCount > 2)
      sgPointsList->RowCount--;
    EditRec = true;
    bool  CanSelect = true;
    sgPointsListSelectCell(sgPointsList, 1, sgPointsList->Selection.Bottom, CanSelect);
  }
  iaDelete->Enabled = !sgPointsList->Cells[FIRSTVISCOL + 0][1].IsEmpty();
  plEdit->Enabled   = iaDelete->Enabled;
  SetLabel();
}
//---------------------------------------------------------------------------

void __fastcall TfmParameterPointsList::vRefresh(TObject *Sender)
{
  //===== Проверка на необходимость перечитки дерева при смене между
  //===== закладками "Используемый расход" и "Долевые потери"
  if (!((tcSelectParams->TabIndex == TI_USED || tcSelectParams->TabIndex == TI_SHARED)
        && (lastPage == TI_USED || lastPage == TI_SHARED)))
    ReadTreeNode(NULL);

  switch (tcSelectParams->TabIndex)
  { case TI_USED:// Используемый расход
      ReadUsedData();
      break;
    case TI_SHARED:// Долевые потери
      ReadSharedData();
      break;
    case TI_PARALEL:// Паралельные присоединения
      ReadParallelData();
      break;
    case TI_RELATED:// Зависимые присоединения
      ReadRelatedData();
      break;
    default:// Неизвестно
      sgPointsList->RowCount = 2;
      sgPointsList->Rows[0]->Clear();
      sgPointsList->Rows[1]->Clear();
      tvPoints->Items->BeginUpdate();
      tvPoints->Items->Clear();
      tvPoints->Items->EndUpdate();
  }
  iaDelete->Enabled = !sgPointsList->Cells[FIRSTVISCOL + 0][1].IsEmpty();
  plEdit->Enabled   = iaDelete->Enabled;
  EditRec = false;
}
//---------------------------------------------------------------------------
void __fastcall TfmParameterPointsList::vSave(TObject *Sender)
{
  switch(tcSelectParams->TabIndex)
  { case TI_USED:
      SaveUsedData(Sender);
      break;
    case TI_SHARED:
      SaveSharedData(Sender);
      break;
    case TI_PARALEL:
      SaveParalelData(Sender);
      break;
    case TI_RELATED:
      SaveRelatedData(Sender);
      break;
    default:
      ;
   }
}
//---------------------------------------------------------------------------
// Читает ветку дерева
bool __fastcall TfmParameterPointsList::ReadTreeNode(TObject *obj)
{
  TTreeNode *NodeParent = dynamic_cast<TTreeNode *>(obj);
  //===== Выбор вершин верхнего уровня
  char  *sqlRoot  =
    "SELECT 1 f_havechild, p.mid f_mid, p.name f_name, decode(p.ind,1,1,2,2,3) f_type, "
        "ryda.util_pg.Get_Pointname(p.mid,1,0) f_fullname "
      "FROM ryda.points p "
      "WHERE p.parent = (select min(mid) from ryda.enterprise) "
        "and exists ( select * "
                        "from ryda.points "
                        "where parent = p.mid " // and cod = 0
                          "and (ind < 3 or mid in (Select mid from ryda.feeders)) "
                    ") "
    "UNION ALL "
    "SELECT 0 f_havechild, p.mid f_mid, p.name f_name, decode(p.ind,1,1,2,2,3) f_type, "
        "ryda.util_pg.Get_Pointname(p.mid,1,0) f_fullname "
      "FROM ryda.points p "
      "WHERE p.parent = ( select min(mid) from ryda.enterprise) "
        "and not exists ( select * "
                            "from ryda.points "
                            "where parent = p.mid " //and cod = 0
                              "and (ind < 3 or mid in (Select mid from ryda.feeders)) "
                        ") "
    "ORDER BY 4, 3 ";
  //===== Выбор Используемого расхода и Долевых потерь
  char  *sqlLoss  =
    "SELECT 1 f_havechild, p.mid f_mid, p.name f_name, decode(p.ind,1,1,2,2,3) f_type, "
        "ryda.util_pg.Get_Pointname(p.MID,1,0) f_fullname "
      "FROM ryda.points p "
      "WHERE p.parent = :par1 and p.cod = 0 "
        "and (p.ind < 3 or p.mid in (Select mid from ryda.feeders)) "
        "and exists ( select * "
                        "from ryda.points "
                        "where parent = p.mid and cod = 0 "
                          "and (ind < 3 or mid in (Select mid from ryda.feeders)) "
                    ") "
    "UNION ALL "
    "SELECT 0 f_havechild, p.mid f_mid, p.name f_name, decode(p.ind,1,1,2,2,3) f_type, "
        "ryda.util_pg.Get_Pointname(p.mid,1,0) f_fullname "
      "FROM ryda.points p "
      "WHERE p.parent = :par1 and p.cod = 0 "
        "and (p.ind < 3 or p.mid in (Select mid from ryda.feeders)) "
        "and not exists ( select * "
                            "from ryda.points "
                            "where parent = p.mid and cod = 0 "
                              "and (ind < 3 or mid in (Select mid from ryda.feeders)) "
                        ") "
    "ORDER BY 4, 3 ";
  //===== Выбор параллельных присоединений
  char  *sqlParallel  =
    //--===== Выбор точек у которых есть параметры (подточек)
    "SELECT 1 f_havechild, p.mid f_mid, p.name f_name, decode(p.ind,1,1,2,2,3) f_type, "
        "ryda.util_pg.Get_Pointname(p.mid,1,0) f_fullname "
      "FROM ryda.points p "
      "WHERE p.parent = :par1 "
        "and p.ind < 3 "
        "and exists ( select * "
                        "from ryda.points "
                        "where parent = p.mid " //and cod = 0
                          "and (ind < 3 or ind = 600 or ind = 610) "
                    ") "
    "UNION ALL "
    //--===== Выбор точек у которых нет параметров (подточек)
    "SELECT 0 f_havechild, p.mid f_mid, p.name f_name, decode(p.ind,1,1,2,2,3) f_type, "
        "ryda.util_pg.Get_Pointname(p.mid,1,0) f_fullname "
      "FROM ryda.points p "
      "WHERE p.parent = :par1 "
	      "and p.ind < 3 "
        "and not exists ( select * "
                            "from ryda.points "
                            "where parent = p.mid " //and cod = 0 
                              "and (ind < 3 or ind = 600 or ind = 610) "
                        ") "
    "UNION ALL "
    //--===== Выбор 2-хобмоточных и 3-хобмоточных трансформаторов
    "SELECT 1 f_havechild, p.mid f_mid, p.name f_name, decode(p.ind, 600, 243, 610, 244, 0) f_type, "
        "p.name f_fullname "
      "FROM ryda.points p "
      "WHERE p.parent = :par1 "
        "and (p.ind = 600 or p.ind = 610) "
    "ORDER BY 4, 3";
  //===== Выборка параметров для параллельных присоединений
  char  *sqlParallelParam =
    "SELECT 0 f_havechild, cp.nconnectionparam f_mid, cp.vname f_name, 4 f_type, "
        "cp.vname f_fullname "
      "FROM ryda.connectionparam cp "
      "WHERE cp.mid = :par1 ";
  //===== Выборка зависимых присоединений
  char  *sqlRelated =
    "SELECT 1 f_havechild, p.mid f_mid, p.name f_name, decode(p.ind, 1, 1, 2, 2, 3) f_type, "
        "ryda.util_pg.Get_Pointname(p.mid,1,0) f_fullname, 0 nconnectionparam, 0 nparallelcon "
      "FROM ryda.points p "
      "WHERE p.parent = :par1 "
        "and p.cod = 0 "
        "and (p.ind < 3 or p.mid in (Select mid from ryda.feeders)) "
        "and exists ( select mid "
                        "from ryda.points "
                        "where parent = p.mid "
                          "and cod = 0 "
                          "and  (ind < 3 or mid in (Select mid from ryda.feeders)) "
                      "union all "
                      "select mid from ryda.connectionparam where mid = p.mid"
                    ") "
    "UNION ALL "
    "SELECT 0 f_havechild, p.mid f_mid, p.name f_name, decode(p.ind, 1, 1, 2, 2, 3) f_type, "
        "ryda.util_pg.Get_Pointname(p.MID, 1, 0) f_fullname, 0, 0 "
      "FROM ryda.points p "
      "WHERE p.parent = :par1 "
        "and p.cod = 0 "
        "and (p.ind < 3 or p.mid in (select mid from ryda.feeders)) "
        "and not exists ( select mid "
                            "from ryda.points "
                            "where parent = p.mid "
                              "and cod = 0 "
                              "and (ind < 3 or mid in (Select mid from ryda.FEEDERS)) "
                          "union all "
                          "select mid from ryda.connectionparam where mid = p.mid"
                        ") "
    "UNION ALL "
    "SELECT 0 f_havechild, c.mid f_mid, NVL(c.vname, c.nconnectionparam) f_name, 4 f_type, "
        "ryda.util_pg.get_pointname(c.mid, 1, 0) || ' / ' || NVL(c.vname,c.NCONNECTIONPARAM) f_fullname, "
        "c.nconnectionparam, c.nparallelconnection "
      "FROM ryda.points p, ryda.connectionparam c "
      "WHERE c.mid = :par1 "
        "and p.mid = c.mid "
    "ORDER BY 4, 3";


  stPoint *PTreeTable;
  TTreeNode *AddNode;
  unsigned long  cnt;

  try
  {
    tvPoints->Items->BeginUpdate();
    //GRB ADD 16.04.2020 - test trouble ODAC
    dmMain->quMain->Params->Clear();
    //END ADD 
     if (!NodeParent)
    { tvPoints->Items->Clear();
     dmMain->quMain->SQL->Text=sqlRoot;
    }
    else
    { switch (tcSelectParams->TabIndex)
      { case TI_USED:
        case TI_SHARED:
          dmMain->quMain->SQL->Text=sqlLoss;
          break;
        case TI_PARALEL:
          if (((stPoint *)NodeParent->Data)->Type == TT_POWER2
              || ((stPoint *)NodeParent->Data)->Type == TT_POWER3)
            dmMain->quMain->SQL->Text=sqlParallelParam;
          else
            dmMain->quMain->SQL->Text=sqlParallel;
          break;
        case TI_RELATED:
          dmMain->quMain->SQL->Text=sqlRelated;

          break;
        default:
          throw Exception(Reconst_smes50_16);
      }
      NodeParent->DeleteChildren();

    dmMain->quMain->ParamByName("par1")->AsInteger= ((stPoint *)NodeParent->Data)->Mid;
    }

      dmMain->quMain->Execute();
      while(!dmMain->quMain->Eof){
      PTreeTable  = new stPoint;
      ZeroMemory(PTreeTable,sizeof(stPoint));
      if(!dmMain->quMain->FieldByName("f_havechild")->IsNull)
        PTreeTable->HaveChild =dmMain->quMain->FieldByName("f_havechild")->AsInteger;
      if(!dmMain->quMain->FieldByName("f_mid")->IsNull)
        PTreeTable->Mid =dmMain->quMain->FieldByName("f_mid")->AsInteger;
      if(!dmMain->quMain->FieldByName("f_name")->IsNull)
        strcpy(PTreeTable->Name,dmMain->quMain->FieldByName("f_name")->AsString.c_str());
      if(!dmMain->quMain->FieldByName("f_type")->IsNull)
        PTreeTable->Type =dmMain->quMain->FieldByName("f_type")->AsInteger;
      if(!dmMain->quMain->FieldByName("f_fullname")->IsNull)
        strcpy(PTreeTable->LongName,dmMain->quMain->FieldByName("f_fullname")->AsString.c_str());
      if(NodeParent&&tcSelectParams->TabIndex==TI_RELATED){
        if(!dmMain->quMain->FieldByName("nconnectionparam")->IsNull)
        PTreeTable->nconnectionparam =dmMain->quMain->FieldByName("nconnectionparam")->AsInteger;
        if(!dmMain->quMain->FieldByName("nparallelcon")->IsNull)
        PTreeTable->nparallelconnection =dmMain->quMain->FieldByName("nparallelcon")->AsInteger;
      }

        repl_delimiters(PTreeTable->LongName, " / ");
        PTreeTable->NKC = 1;
        AddNode = tvPoints->Items->AddChildObject(NodeParent, PTreeTable->Name, PTreeTable);
        int image;
        switch (PTreeTable->Type)
        { case TT_POINT:
            image = imPoint;
            break;
          case TT_PARAM:
            image = imParam;
            break;
          case TT_POWER2:
            image = imPower2;
            break;
          case TT_POWER3:
            image = imPower3;
            break;
          default:
            image = imCFldr;
        }
        AddNode->ImageIndex = image;
        AddNode->SelectedIndex = image;
        AddNode->HasChildren = PTreeTable->HaveChild;
      dmMain->quMain->Next();
      }

  }
  catch (Exception &e)
  { tvPoints->Items->EndUpdate();

    Application->ShowException(&e);
    return  false;
  }
  tvPoints->Items->EndUpdate();

  SetLabel();
  return  true;
}
//---------------------------------------------------------------------------
void __fastcall TfmParameterPointsList::tvPointsCollapsed(TObject *Sender,
      TTreeNode *Node)
{
   if(Node)
   switch(Node->ImageIndex){
   case imOFldr:
      Node->SelectedIndex = imCFldr;
      Node->ImageIndex    = imCFldr;
      break;
   case imOChckFldr:
      Node->SelectedIndex = imCChckFldr;
      Node->ImageIndex    = imCChckFldr;
   }
}
//---------------------------------------------------------------------------
void __fastcall TfmParameterPointsList::tvPointsExpanded(TObject *Sender,
      TTreeNode *Node)
{
  if(Node)
  switch (Node->ImageIndex)
  { case imCFldr:
      Node->SelectedIndex = imOFldr;
      Node->ImageIndex    = imOFldr;
      break;
    case imCChckFldr:
      Node->SelectedIndex = imOChckFldr;
      Node->ImageIndex    = imOChckFldr;
  }
}
//---------------------------------------------------------------------------

void __fastcall TfmParameterPointsList::tvPointsExpanding(TObject *Sender,
      TTreeNode *Node, bool &AllowExpansion)
{
  if (Node && Node->HasChildren && !Node->getFirstChild())
    if (Sender == tvParamView)
      ReadParallelData(Node);
    else
      ReadTreeNode(Node);
}
//---------------------------------------------------------------------------

void __fastcall TfmParameterPointsList::sgPointsListDragOver(TObject *Sender,
      TObject *Source, int X, int Y, TDragState State, bool &Accept)
{
  stPoint *DragData;
  TTreeNode *tn;
  long  id1,
        id2;

  if (dynamic_cast<TTreeView *>(Source))
    DragData  = (stPoint *)((TTreeView *)Source)->Selected->Data;
  else
    DragData  = NULL;

  switch (tcSelectParams->TabIndex)
  { case TI_SHARED:
      if (Access == accRead || Sender != sgPointsList)
        Accept  = false;
      else
        Accept  = (DragData && (DragData->Type == TT_POINT || DragData->Type == TT_FOLDER)
                    && sgPointsList->Cols[0]->IndexOf(DragData->Mid) < 0);
      break;
    case TI_PARALEL:
      if (Sender != tvParamView || Access == accRead)
      { Accept  = false;
      }
      else
        if (Source == tvParamView)
          Accept  = true;
        else
          Accept  = DragData && DragData->Type == TT_PARAM;
                      //|| DragData->Type == TT_POWER2
                      //|| DragData->Type == TT_POWER3);
      break;
    case TI_RELATED:
      if (Access == accRead || Sender != tvPoints)
        Accept = false;
      else
      { id1 = DragData
                ? DragData->nconnectionparam
                : sgPointsList->Cells[0][sgPointsList->Row].ToInt();
        tn  = tvPoints->GetNodeAt(X, Y);
        id2 = (tn && tn->Data)
                ? ((stPoint *)tn->Data)->nconnectionparam
                : 0;
        if (id1 == 0 || id2 == 0 || id1 == id2)
          Accept  = false;
        else
          Accept  = true;
      }
      break;
    default:
      if (Sender != sgPointsList)
        Accept  = false;
      else
        Accept  = (Access == accRead)
                    ? false
                    : DragData && (DragData->Type == TT_POINT || DragData->Type == TT_FOLDER);
      break;
  }
}
//---------------------------------------------------------------------------

void __fastcall TfmParameterPointsList::sgPointsListDragDrop(TObject *Sender,
      TObject *Source, int X, int Y)
{
  stPoint *DragData;
  if (dynamic_cast<TTreeView *>(Source))
    DragData  = (stPoint *)((TTreeView *)Source)->Selected->Data;
  else
    DragData  = NULL;
  switch (tcSelectParams->TabIndex)
  { case TI_USED:
      DropUsedData(DragData);
      break;
    case TI_SHARED:
      DropSharedData(DragData);
      break;
    case TI_PARALEL:
      DropParallelData(tvParamView->GetNodeAt(X,Y), ((TTreeView *)Source)->Selected);
      break;
    case TI_RELATED:
      DropRelatedData(dynamic_cast<TTreeView*>(Source), tvPoints->GetNodeAt(X,Y));
      break;
    default:
      {}
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmParameterPointsList::SetAccess(TAccess value)
{
   if(FAccess != value){
      TMainForm::SetAccess(value);
      iaDelete->Enabled = value==accWrite;
      plEdit->Enabled = iaDelete->Enabled;
   }
}
//---------------------------------------------------------------------------
void __fastcall TfmParameterPointsList::sgPointsListSelectCell(TObject *Sender,
   int ACol, int ARow, bool &CanSelect)
{
   bool oldEdit = EditRec;
   SetLabel(ARow);
   CurrRow=0;
   switch(tcSelectParams->TabIndex){
   case TI_USED:
      gbUsedEdit->Caption = Reconst_smes50_17+
                       sgPointsList->Cells[FIRSTVISCOL+0][ARow]+"\"";
      edKC->Text = sgPointsList->Cells[FIRSTVISCOL+1][ARow];
      rgDimType->ItemIndex = GetIdByType(sgPointsList->Cells[FIRSTVISCOL+2][ARow]);
      cbCalcR->ItemIndex=GetIdByRType(sgPointsList->Cells[FIRSTVISCOL+3][ARow]);
      break;
   case TI_SHARED:
      gbSharedEdit->Caption = Reconst_smes50_18+
                       sgPointsList->Cells[FIRSTVISCOL+0][ARow]+"\"";
      aOffCalc->Checked = (sgPointsList->Cells[FIRSTVISCOL+1][ARow]==Reconst_smes50_19);
      break;
   case TI_PARALEL:
      break;
   case TI_RELATED:
      gbDependEdit->Caption = Reconst_smes50_20+
                       sgPointsList->Cells[FIRSTVISCOL+0][ARow]+"\"";
      eFirst->Text = sgPointsList->Cells[FIRSTVISCOL+1][ARow];
      eKC->Text = sgPointsList->Cells[FIRSTVISCOL+2][ARow];
      break;
   }
   EditRec = oldEdit;
   CurrRow = ARow;
}
//---------------------------------------------------------------------------
void __fastcall TfmParameterPointsList::SetLabel(int ARow)
{
   int i=0,j=0;
   if(sgPointsList->RowCount>2){
      i=(ARow)?ARow:((sgPointsList->Row>0)?sgPointsList->Row:1);
      j=sgPointsList->RowCount-1;
   }else{
      if(!sgPointsList->Cells[FIRSTVISCOL+0][1].IsEmpty()){
         i=1;
         j=1;
      }
   }
   paInfo->Caption=IntToStr(i)+AnsiString("/")+j;
}
//---------------------------------------------------------------------------
void __fastcall TfmParameterPointsList::eChange(TObject *Sender)
{
   EditRec = true;
   if(!CurrRow)
      return;
   else if(Sender==cbCalcR)
      sgPointsList->Cells[4][CurrRow] = cbCalcR->Items->Strings[cbCalcR->ItemIndex];
   else if(Sender==edKC)
      sgPointsList->Cells[2][CurrRow] = edKC->Text;
   else if(Sender==rgDimType)
      sgPointsList->Cells[3][CurrRow] = GetTypeById(rgDimType->ItemIndex);
   else if(Sender==aOffCalc){
      sgPointsList->Cells[2][CurrRow] = aOffCalc->Checked?Reconst_smes50_21:Reconst_smes50_19;
      aOffCalc->Checked = !aOffCalc->Checked;
   }
}
//---------------------------------------------------------------------------
AnsiString __fastcall TfmParameterPointsList::GetTypeById(int i)
{
   switch(i){
   case 1:
      return "A+";
   case 2:
      return "A-";
   }
   return "A+-";
}
//---------------------------------------------------------------------------
int __fastcall TfmParameterPointsList::GetIdByType(AnsiString s)
{
   if(s=="A+")
    return 1;
   if(s=="A-")
    return 2;
   return 0;
}
//---------------------------------------------------------------------------
int __fastcall TfmParameterPointsList::GetIdByRType(AnsiString s)
{
   for(int i=0;i<cbCalcR->Items->Count;i++){
    if(s==cbCalcR->Items->Strings[i])
      return i;
   }
   return -1;
}
//---------------------------------------------------------------------------
void __fastcall TfmParameterPointsList::edKCKeyPress(TObject *Sender,
      char &Key)
{
#define Sender ((TEdit*)Sender)
  AnsiString S=(AnsiString)Key;
  AnsiString Sd=AnsiString(DecimalSeparator);
  AnsiString S1="-0123456789\b\r";
  if((Sender->Text.Pos(Sd)&&!S1.Pos(S))||(!Sender->Text.Pos(Sd)&&!AnsiString(S1+Sd).Pos(S))){
    Key=NULL;
    Beep();
    return;
  }
#undef Sender
}
//---------------------------------------------------------------------------

void __fastcall TfmParameterPointsList::tcSelectParamsChanging(
      TObject *Sender, bool &AllowChange)
{
  if (EditRec)
    switch(MessageBox(this->Handle,
                        Reconst_smes50_22.c_str(),
                        Reconst_smes50_23.c_str(),
                        MB_YESNOCANCEL | MB_ICONQUESTION))
    { case IDYES:
        vSave(Sender);
        break;
      case IDNO:
        EditRec = false;
        break;
      case IDCANCEL:
        break;
    }
  AllowChange = !EditRec;
  switch (tcSelectParams->TabIndex)
  { case TI_USED:
      lastPage  = TI_USED;
      aSaldo->Enabled     = false;
      aPlus->Enabled      = false;
      aMinus->Enabled     = false;
      gbUsedEdit->Enabled = false;
      gbUsedEdit->Visible = false;
      if (FParamCidCnt == POWER3_CONT)
      { Power3TabControl->Visible   = false;
        Power3TabControl->TabIndex  = TI_UP;
      }
      break;
    case TI_SHARED:
      lastPage  = TI_SHARED;
      aOffCalc->Enabled           = false;
      gbSharedEdit->Enabled       = false;
      gbSharedEdit->Visible       = false;
      if (FParamCidCnt == POWER3_CONT)
      { Power3TabControl->Visible   = false;
        Power3TabControl->TabIndex  = TI_UP;
      }
      break;
    case TI_PARALEL:
      lastPage  = TI_PARALEL;
      tvParamView->Enabled  = false;
      tvParamView->Visible  = false;
      sgPointsList->Enabled = true;
      sgPointsList->Visible = true;
      paInfo->Visible = true;
      break;
    case TI_RELATED:
      lastPage  = TI_RELATED;
      gbDependEdit->Enabled = false;
      gbDependEdit->Visible = false;
      break;
  }
}
//---------------------------------------------------------------------------

void __fastcall TfmParameterPointsList::tcSelectParamsChange(
      TObject *Sender)
{
  switch (tcSelectParams->TabIndex)
  { case TI_USED:
      aSaldo->Enabled = true;
      aPlus->Enabled = true;
      aMinus->Enabled = true;
      gbUsedEdit->Enabled = true;
      gbUsedEdit->Visible = true;
      if (FParamCidCnt == POWER3_CONT)
      { Power3TabControl->TabIndex  = TI_UP;
        Power3TabControl->Visible   = true;
      }
      plTreeTitle->Caption = Reconst_smes50_24;
      sgPointsList->ColCount = 5;
      sgPointsList->ColWidths[2] = 26;
      sgPointsList->ColWidths[3] = 27;
      sgPointsList->ColWidths[4] = 158;
      sgPointsList->Rows[0]->Strings[FIRSTVISCOL+0] = Reconst_smes50_42;
      sgPointsList->Rows[0]->Strings[FIRSTVISCOL+1] = Reconst_smes50_25;
      sgPointsList->Rows[0]->Strings[FIRSTVISCOL+2] = Reconst_smes50_26;
      sgPointsList->Rows[0]->Strings[FIRSTVISCOL+3] = Reconst_smes50_27;
      break;
    case TI_SHARED:
      aOffCalc->Enabled         = true;
      gbSharedEdit->Enabled     = true;
      gbSharedEdit->Visible     = true;
      if (FParamCidCnt == POWER3_CONT)
      { Power3TabControl->TabIndex  = TI_UP;
        Power3TabControl->Visible   = true;
      }
      plTreeTitle->Caption = Reconst_smes50_28;
      sgPointsList->ColCount = 3;
      sgPointsList->ColWidths[2] = 150;
      sgPointsList->Rows[0]->Strings[FIRSTVISCOL+0] = Reconst_smes50_42;
      sgPointsList->Rows[0]->Strings[FIRSTVISCOL+1] = Reconst_smes50_29;
      break;
    case TI_PARALEL:
      tvParamView->Enabled = true;
      tvParamView->Visible = true;
      sgPointsList->Enabled = false;
      sgPointsList->Visible = false;
      paInfo->Visible = false;
      break;
    case TI_RELATED:
      gbDependEdit->Enabled = true;
      gbDependEdit->Visible = true;
      plTreeTitle->Caption = Reconst_smes50_30;
      sgPointsList->ColCount = 4;
      sgPointsList->ColWidths[2] = 200;
      sgPointsList->ColWidths[3] = 40;
      sgPointsList->Rows[0]->Strings[FIRSTVISCOL+0] = Reconst_smes50_31;
      sgPointsList->Rows[0]->Strings[FIRSTVISCOL+1] = Reconst_smes50_32;
      sgPointsList->Rows[0]->Strings[FIRSTVISCOL+2] = Reconst_smes50_33;
      break;
   }
   iaRefreshExecute(Sender);
}
//---------------------------------------------------------------------------

void __fastcall TfmParameterPointsList::SaveUsedData(TObject*)
{
  TEdit*edit=NULL;
  long masSize = sgPointsList->Cells[FIRSTVISCOL+0][1].IsEmpty()?0:sgPointsList->RowCount-1;
  try{
    oqSaveUsedData->SQL->Text=" begin ryda.loss_pg.setpoint_p(:par1,:par2,:par3,:par4,:par5); end; ";
    oqSaveUsedData->ParamByName("par1")->AsInteger=FParamCid[Power3TabControl->TabIndex];
    for(int j=2;j<=5;j++){
      oqSaveUsedData->ParamByName("par"+IntToStr(j))->Table=true;
      oqSaveUsedData->ParamByName("par"+IntToStr(j))->Length=1;
     // oqSaveUsedData->ParamByName("par"+IntToStr(j))->Clear();
    }
     oqSaveUsedData->ParamByName("par2")->ItemAsInteger[1]=0;
     oqSaveUsedData->ParamByName("par3")->ItemAsInteger[1]=0;
     oqSaveUsedData->ParamByName("par4")->ItemAsFloat[1]=0;
     oqSaveUsedData->ParamByName("par5")->ItemAsInteger[1]=0;
    for(int i=1;i<=masSize;i++){
      for(int j=2;j<=5;j++){
        oqSaveUsedData->ParamByName("par"+IntToStr(j))->Length=i;
      }
      oqSaveUsedData->ParamByName("par2")->ItemAsInteger[i]=sgPointsList->Cols[0]->Strings[i].ToInt();
      oqSaveUsedData->ParamByName("par3")->ItemAsInteger[i]=GetIdByType(sgPointsList->Cols[3]->Strings[i]);
      oqSaveUsedData->ParamByName("par4")->ItemAsFloat[i]=sgPointsList->Cols[2]->Strings[i].ToDouble();
      oqSaveUsedData->ParamByName("par5")->ItemAsInteger[i]=(int)cbCalcR->Items->Objects[GetIdByRType(sgPointsList->Cols[4]->Strings[i])];
    }
    oqSaveUsedData->Execute();
    dmMain->orases->Commit();
    EditRec = false;
   }catch(EConvertError&e){
      dmMain->orases->Rollback();
      Application->ShowException(&Exception(Reconst_smes50_34));
      edit->SetFocus();
      return;
   }catch(Exception&e){
      dmMain->orases->Rollback();
    	Application->ShowException(&e);
   }
}
//---------------------------------------------------------------------------

void __fastcall TfmParameterPointsList::ReadUsedData(void)
{
   char*s=
      "SELECT p.MID, RYDA.UTIL_PG.Get_Pointname(p.MID,1,0)VNAME,c.NKC, c.NTYPE, nvl(c.NRECOMPENS,0)NRECOM \
      FROM RYDA.POINTS p, RYDA.USEDCONSUMPT c \
      WHERE c.NCONNECTIONPARAM = :par1 AND c.mid = p.mid \
      ORDER BY 2";
   char*s1=
      "select NRECOMPENS,ltrim(to_char(nratio,'0.99'))||' '||VNAME vname,1 nsort,nratio from ryda.recompens \
         union all \
      select 0 NRECOMPENS,'Без переопределения',0 nsort,0 nratio from dual \
      order by 3,4 desc";
    AnsiString field1="NRECOMPENS";
    AnsiString field2="vname";
     char Name[156];

   try
   {
      long  tCid  = FParamCid[Power3TabControl->TabIndex];
      SetStringInfo(cbCalcR->Items,s1,field1,field2,dmMain->quMain);
      //GRB ADD 16.04.2020 - test trouble ODAC
      dmMain->quMain->Params->Clear();
      //END ADD 
      dmMain->quMain->SQL->Text=s;
      sgPointsList->Rows[1]->Clear();
      sgPointsList->RowCount = 2;
      dmMain->quMain->ParamByName("par1")->AsInteger=tCid;
      dmMain->quMain->Execute();
         while(!dmMain->quMain->Eof){
          if(!sgPointsList->Cells[FIRSTVISCOL+0][1].IsEmpty())
               sgPointsList->RowCount = sgPointsList->RowCount+1;

            strcpy(Name,dmMain->quMain->FieldByName("VNAME")->AsString.c_str());
            repl_delimiters(Name, " / ");
            sgPointsList->Cells[FIRSTVISCOL-1][sgPointsList->RowCount-1] = dmMain->quMain->FieldByName("MID")->AsInteger;
            sgPointsList->Cells[FIRSTVISCOL+0][sgPointsList->RowCount-1] = Name;
            sgPointsList->Cells[FIRSTVISCOL+1][sgPointsList->RowCount-1] = FloatToStr(dmMain->quMain->FieldByName("NKC")->AsFloat);
            sgPointsList->Cells[FIRSTVISCOL+2][sgPointsList->RowCount-1] = GetTypeById(dmMain->quMain->FieldByName("NTYPE")->AsInteger);
            sgPointsList->Cells[FIRSTVISCOL+3][sgPointsList->RowCount-1] = cbCalcR->Items->Strings[cbCalcR->Items->IndexOfObject((TObject*)dmMain->quMain->FieldByName("NRECOM")->AsInteger)];
        dmMain->quMain->Next();
        }

      iaDelete->Enabled = !sgPointsList->Cells[FIRSTVISCOL+0][1].IsEmpty();
      plEdit->Enabled = iaDelete->Enabled;
      bool CanSelect=true;
      sgPointsListSelectCell(this, 0, 1, CanSelect);
   }__finally
   {

   }

}
//---------------------------------------------------------------------------

void __fastcall TfmParameterPointsList::ReadSharedData()
{
  char  *s  = "SELECT p.MID, RYDA.UTIL_PG.Get_Pointname(p.MID,1,0)vname, c.nnotincludeconsump "
                "FROM RYDA.POINTS p, RYDA.SHAREDCONNECTIONPARAM c "
                "WHERE c.NCONNECTIONPARAM = :par1 AND c.mid = p.mid "
                "ORDER BY 2";

    stPoint *PointsTable;
  try
  {
    long  tCid  = FParamCid[Power3TabControl->TabIndex];
    //GRB ADD 16.04.2020 - test trouble ODAC
    dmMain->quMain->Params->Clear();
    //END ADD 
    dmMain->quMain->SQL->Text=s;
    sgPointsList->Rows[1]->Clear();
    sgPointsList->RowCount  = 2;
    dmMain->quMain->ParamByName("par1")->AsInteger=tCid;
      dmMain->quMain->Execute();
      while(!dmMain->quMain->Eof){
      PointsTable=new stPoint;
      ZeroMemory(PointsTable, sizeof(stPoint));
      PointsTable->Mid=dmMain->quMain->FieldByName("MID")->AsInteger;
      if(!dmMain->quMain->FieldByName("vname")->IsNull)
        strcpy(PointsTable->Name,dmMain->quMain->FieldByName("vname")->AsString.c_str());
      PointsTable->NNOTINCLUDECONSUMP=dmMain->quMain->FieldByName("nnotincludeconsump")->AsInteger;

      if (!sgPointsList->Cells[FIRSTVISCOL + 0][1].IsEmpty())
          sgPointsList->RowCount  = sgPointsList->RowCount + 1;
        repl_delimiters(PointsTable->Name, " / ");
        sgPointsList->Cells[FIRSTVISCOL - 1][sgPointsList->RowCount - 1]  = PointsTable->Mid;
        sgPointsList->Cells[FIRSTVISCOL + 0][sgPointsList->RowCount - 1]  = PointsTable->Name;
        sgPointsList->Cells[FIRSTVISCOL + 1][sgPointsList->RowCount - 1]  = (PointsTable->NNOTINCLUDECONSUMP == 1)
                                                                              ? Reconst_smes50_19
                                                                              : Reconst_smes50_21;
      dmMain->quMain->Next();
     }
    iaDelete->Enabled = !sgPointsList->Cells[FIRSTVISCOL + 0][1].IsEmpty();
    plEdit->Enabled   = iaDelete->Enabled;
    bool CanSelect  = true;
    sgPointsListSelectCell(this, 0, 1, CanSelect);
  }__finally
   {

   }

 }
//---------------------------------------------------------------------------

void __fastcall TfmParameterPointsList::DropUsedData(stPoint*DragData)
{
   if(!DragData)
      return;
   if(DragData->Type==3)
   {
      if(!sgPointsList->Cells[FIRSTVISCOL+0][1].IsEmpty())
         sgPointsList->RowCount++;
      sgPointsList->Rows[sgPointsList->RowCount-1]->Clear();
      sgPointsList->Rows[sgPointsList->RowCount-1]->Add(DragData->Mid);
      sgPointsList->Rows[sgPointsList->RowCount-1]->Add(DragData->LongName);
      sgPointsList->Rows[sgPointsList->RowCount-1]->Add(FloatToStr(DragData->NKC));
      sgPointsList->Rows[sgPointsList->RowCount-1]->Add(GetTypeById(DragData->NType));
      sgPointsList->Rows[sgPointsList->RowCount-1]->Add(cbCalcR->Items->Strings[cbCalcR->Items->IndexOfObject((TObject*)DragData->NRECOMPENS)]);
      EditRec = true;
      iaDelete->Enabled = !sgPointsList->Cells[FIRSTVISCOL+0][1].IsEmpty();
      plEdit->Enabled = iaDelete->Enabled;
      SetLabel();
   }else{
      TTreeNode* currnode = tvPoints->Selected;
      bool Accept = true;
      tvPointsExpanding(tvPoints, currnode, Accept);
      currnode = currnode->getFirstChild();
      while(currnode){
         currnode->Selected = true;
         sgPointsListDragOver(sgPointsList, tvPoints, 0, 0, dsDragEnter, Accept);
         if(Accept)
            sgPointsListDragDrop(sgPointsList, tvPoints, 0, 0);
         currnode = currnode->getNextSibling();
      }
   }
   if(sgPointsList->Selection.Top == sgPointsList->RowCount-1)
   {
      bool CanSelect=true;
      sgPointsListSelectCell(sgPointsList, 1, sgPointsList->RowCount-1, CanSelect);
   }
}
//---------------------------------------------------------------------------

void __fastcall TfmParameterPointsList::DropSharedData(stPoint*DragData)
{
   if(!DragData)
      return;
   if(DragData->Type==3)
   {
      if(!sgPointsList->Cells[FIRSTVISCOL+0][1].IsEmpty())
         sgPointsList->RowCount++;
      sgPointsList->Rows[sgPointsList->RowCount-1]->Clear();
      sgPointsList->Rows[sgPointsList->RowCount-1]->Add(DragData->Mid);
      sgPointsList->Rows[sgPointsList->RowCount-1]->Add(DragData->LongName);
      sgPointsList->Rows[sgPointsList->RowCount-1]->Add("Да");
      EditRec = true;
      iaDelete->Enabled = !sgPointsList->Cells[FIRSTVISCOL+0][1].IsEmpty();
      plEdit->Enabled = iaDelete->Enabled;
      SetLabel();
   }else{
      TTreeNode* currnode = tvPoints->Selected;
      bool Accept = true;
      tvPointsExpanding(tvPoints, currnode, Accept);
      currnode = currnode->getFirstChild();
      while(currnode){
         currnode->Selected = true;
         sgPointsListDragOver(sgPointsList, tvPoints, 0, 0, dsDragEnter, Accept);
         if(Accept)
            sgPointsListDragDrop(sgPointsList, tvPoints, 0, 0);
         currnode = currnode->getNextSibling();
      }
   }
   if(sgPointsList->Selection.Top == sgPointsList->RowCount-1)
   {
      bool CanSelect=true;
      sgPointsListSelectCell(sgPointsList, 1, sgPointsList->RowCount-1, CanSelect);
   }
}
//---------------------------------------------------------------------------

void __fastcall TfmParameterPointsList::DropParallelData(TTreeNode*accNode, TTreeNode*dragNode)
{
  TTreeNode *tmp,
            *tmp1;
  stPoint DragData;

  if (!dragNode)
    return;
  if (dragNode->TreeView == tvParamView)
  { strcpy(DragData.LongName, dragNode->Text.c_str());
    DragData.Mid  = (long)dragNode->Data;
    switch (dragNode->ImageIndex)
    { case imPower2:
        DragData.Type = TT_POWER2;
        break;
      case imPower3:
        DragData.Type = TT_POWER3;
        break;
      case imParam:
        DragData.Type = TT_PARAM;
        break;
    }

    //(dragNode->ImageIndex == imParam || dragNode->ImageIndex == imParamChck)
    //                  ? 4
    //                  : 2;
  }
  else
  { memcpy(&DragData, dragNode->Data, sizeof(stPoint));
    for (int i = 0; i < tvParamView->Items->Count; i++)
      if (tvParamView->Items->Item[i]->Level > 0
          && DragData.Mid == (long)tvParamView->Items->Item[i]->Data)
      { ShowMessage(Reconst_smes50_35);
        tvParamView->Items->Item[i]->Selected = true;
        return;
      }
  }

  //DragData.Type == TT_POWER2 || DragData.Type == TT_POWER3
  if (DragData.Type == TT_PARAM)
  { if (!accNode)
    { tmp = tvParamView->Items->AddObject(NULL, "", 0);
      tmp->ImageIndex     = imCFldr;
      tmp->SelectedIndex  = imCFldr;
    }
    else
      tmp = accNode->Parent ? accNode->Parent : accNode;
    tmp->Expand(false);
    if (dragNode->TreeView == tvParamView)
    { if (dragNode->Parent == tmp)
        return;
      //if (dragNode->ImageIndex == imParamChck)
      //{ tmp->ImageIndex = tmp->ImageIndex==imCFldr ? imCChckFldr : imOChckFldr;
      //  tmp->SelectedIndex = tmp->ImageIndex;
      //  dragNode->Parent->ImageIndex = imOFldr;
      //  dragNode->Parent->SelectedIndex = imOFldr;
      //}
      tmp1 = dragNode->Parent;
      dragNode->MoveTo(tmp, naAddChild);
      if (tmp1->Count == 0)
        tmp1->Delete();
      tmp = dragNode;
    }
    else
    { tmp = tvParamView->Items->AddChildObject(tmp, DragData.LongName, (TObject *)DragData.Mid);
      switch (DragData.Type)
      { case TT_POWER2:
          tmp->ImageIndex = imPower2;
          break;
        case TT_POWER3:
          tmp->ImageIndex = imPower3;
          break;
        case TT_PARAM:
          tmp->ImageIndex = imParam;
          break;
      }
      tmp->SelectedIndex  = tmp->ImageIndex;
    }
    EditRec = true;
  }
}
//---------------------------------------------------------------------------

void __fastcall TfmParameterPointsList::SaveSharedData(TObject*)
{
  long  masSize     = sgPointsList->Cells[FIRSTVISCOL + 0][1].IsEmpty()?0:sgPointsList->RowCount-1;
  try
  {
    long  tCid  = FParamCid[Power3TabControl->TabIndex];
    // сохранение привязки точек
    oqSaveSharedData->SQL->Text=" begin ryda.loss_pg.setsharedpoint_p(:par1,:par2,:par3); end; ";
    oqSaveSharedData->ParamByName("par1")->AsInteger=tCid;
    for(int i=2;i<=3;i++){
      oqSaveSharedData->ParamByName("par"+IntToStr(i))->Table=true;
      oqSaveSharedData->ParamByName("par"+IntToStr(i))->Length=1;
      oqSaveSharedData->ParamByName("par"+IntToStr(i))->ItemAsInteger[1]=0;
    }
    for(int j=1;j<=masSize;j++){
      for(int i=2;i<=3;i++)
        oqSaveSharedData->ParamByName("par"+IntToStr(i))->Length=j;
      oqSaveSharedData->ParamByName("par2")->ItemAsInteger[j]=sgPointsList->Cols[0]->Strings[j].ToInt();
      oqSaveSharedData->ParamByName("par3")->ItemAsInteger[j]=(sgPointsList->Cols[2]->Strings[j] == Reconst_smes50_21)?0:1;

      }
      oqSaveSharedData->Execute();
      dmMain->orases->Commit();
      EditRec = false;
  }catch (EConvertError &e){
    dmMain->orases->Rollback();
    Application->ShowException(&Exception(Reconst_smes50_34));
  }
  catch (Exception &e){
    dmMain->orases->Rollback();
    Application->ShowException(&e);
  }
}
//---------------------------------------------------------------------------

void __fastcall TfmParameterPointsList::ReadParallelData(TObject *Sender)
{
  char  *sqlRoot =
    "SELECT pc.nparallelconnection f_id, TO_CHAR(pc.nparallelconnection) f_name, "
        "1 f_haschild "
      "FROM ryda.parallelconnection pc "
      "WHERE exists (select nconnectionparam "
                      "from ryda.connectionparam "
                      "where nparallelconnection = pc.nparallelconnection "
                    ") "
    "UNION ALL "
    "SELECT pc.nparallelconnection f_id, TO_CHAR(pc.nparallelconnection) f_name, "
        "0 f_haschild "
      "FROM ryda.parallelconnection pc "
      "WHERE not exists (select nconnectionparam "
                          "from ryda.connectionparam "
                          "where nparallelconnection = pc.nparallelconnection "
                        ") ";
  char  *sqlSub =
    "SELECT cp.nconnectionparam f_id, cp.vname f_name, 4 f_type "
      "FROM ryda.connectionparam cp "
      "WHERE cp.nparallelconnection = :par1 ";

 stPoint *pointsTable;
  TTreeNode *Parent = dynamic_cast<TTreeNode *>(Sender);
 
  long rootid;

  try
  { try
    { rootid  = Parent
                  ? (long)Parent->Data
                  : 0;
     ;
      sgPointsList->RowCount  = 2;
      sgPointsList->Rows[1]->Clear();
      //GRB ADD 16.04.2020 - test trouble ODAC
      dmMain->quMain->Params->Clear();
      //END ADD 
      if (!Parent)
       dmMain->quMain->SQL->Text=sqlRoot;


      else
      {
        dmMain->quMain->SQL->Text=sqlSub;
        dmMain->quMain->ParamByName("par1")->AsInteger=rootid;
      }
      if (!Parent)
        tvParamView->Items->Clear();

        dmMain->quMain->Execute();
        while(!dmMain->quMain->Eof){
        pointsTable=new stPoint;
        ZeroMemory(pointsTable, sizeof(stPoint));
        TTreeNode *tmp;
          if (Parent)
          {
            if(!dmMain->quMain->FieldByName("f_id")->IsNull)
            pointsTable->Mid=dmMain->quMain->FieldByName("f_id")->AsInteger;
            if(!dmMain->quMain->FieldByName("f_name")->IsNull)
            strcpy(pointsTable->LongName,dmMain->quMain->FieldByName("f_name")->AsString.c_str());
            if(!dmMain->quMain->FieldByName("f_type")->IsNull)
            pointsTable->Type=dmMain->quMain->FieldByName("f_type")->AsInteger;
          //repl_delimiters(pointsTable[i].LongName, " / ");
            tmp = tvParamView->Items->AddChildObject(Parent, pointsTable->LongName, (TObject *)pointsTable->Mid);
            switch (pointsTable->Type)
            { case TT_POWER2:
                tmp->ImageIndex = imPower2;
                break;
              case TT_POWER3:
                tmp->ImageIndex = imPower3;
                break;
              case TT_PARAM:
                tmp->ImageIndex = imParam;
                break;
            }
            //tmp->ImageIndex     = pointsTable[i].NType?imParamChck:imParam;
            //tmp->SelectedIndex  = pointsTable[i].NType?imParamChck:imParam;
          }
          else
          {
           if(!dmMain->quMain->FieldByName("f_id")->IsNull)
            pointsTable->Mid=dmMain->quMain->FieldByName("f_id")->AsInteger;
           if(!dmMain->quMain->FieldByName("f_name")->IsNull)
            strcpy(pointsTable->LongName,dmMain->quMain->FieldByName("f_name")->AsString.c_str());
           if(!dmMain->quMain->FieldByName("f_haschild")->IsNull)
            pointsTable->HaveChild=dmMain->quMain->FieldByName("f_haschild")->AsInteger;

          tmp = tvParamView->Items->AddObject(NULL,pointsTable->LongName, (TObject *)pointsTable->Mid);
            tmp->ImageIndex     = imCFldr;
            //tmp->ImageIndex = pointsTable[i].NType?imCChckFldr:imCFldr;
            //tmp->SelectedIndex = pointsTable[i].NType?imCChckFldr:imCFldr;
          }
          tmp->SelectedIndex  = tmp->ImageIndex;
          tmp->HasChildren    = Parent
                                  ? 0
                                  : pointsTable->HaveChild;
        dmMain->quMain->Next();

      }
      if (!Parent)
      { TTreeNode *tmp  = tvParamView->Items->GetFirstNode();
        if (tmp)
          while (tmp && tmp != tmp->getNextSibling())
          { tmp->Expand(true);
            tmp = tmp->getNextSibling();
          }
      }
    }
    catch (Exception&e)
    { Application->ShowException(&e);
    }
  }__finally
   {

   }
 }
//---------------------------------------------------------------------------

void __fastcall TfmParameterPointsList::SaveParalelData(TObject *)
{
  TTreeNode *Node;
  long ind,dropAll = 1;
  try{
    // сохранение привязки точек
    oqSaveParalelData->SQL->Text=" begin ryda.loss_pg.setparallelconn_p(:par1, :par2, :par3, :par4); end; ";
    for(int j=1;j<=3;j++){
      oqSaveParalelData->ParamByName("par"+IntToStr(j))->Table=true;
      oqSaveParalelData->ParamByName("par"+IntToStr(j))->ParamType=ptInputOutput;
      oqSaveParalelData->ParamByName("par"+IntToStr(j))->Length=1;
     // oqSaveParalelData->ParamByName("par"+IntToStr(j))->Clear();
      oqSaveParalelData->ParamByName("par"+IntToStr(j))->ItemAsInteger[1]=0;
    }

    ind = 0;
    Node=tvParamView->Items->GetFirstNode();
    while(Node){
      if (Node->Level > 0){
        dropAll = 0;
        ind++;
        for(int j=1;j<=3;j++)
          oqSaveParalelData->ParamByName("par"+IntToStr(j))->Length=ind;
        oqSaveParalelData->ParamByName("par1")->ItemAsInteger[ind]=(long)Node->Data;
        oqSaveParalelData->ParamByName("par2")->ItemAsInteger[ind]=(long)Node->Parent->Data;
        oqSaveParalelData->ParamByName("par3")->ItemAsInteger[ind]=(long)Node->Parent;
      }
      Node=Node->GetNext();
    }
    oqSaveParalelData->ParamByName("par4")->AsInteger=dropAll;
    oqSaveParalelData->Execute();
    dmMain->orases->Commit();
    ind = 0;
    Node=tvParamView->Items->GetFirstNode();
    while(Node){
      if(Node->Level > 0){
        ind++;
        if(Node->Text.IsEmpty()){
          Node->Parent->Text = dmMain->quMain->ParamByName("par2")->ItemAsInteger[ind];
          Node->Parent->Data = (TObject*)dmMain->quMain->ParamByName("par2")->ItemAsInteger[ind];
        }
      }
      Node=Node->GetNext();
    }
    EditRec = false;
  }catch (Exception &e){
    dmMain->orases->Rollback();
    Application->ShowException(&e);
  }
}
//---------------------------------------------------------------------------

void __fastcall TfmParameterPointsList::ReadRelatedData()
{
  char  *s  =
    "SELECT r.nconnectionparam, "
        "ryda.util_pg.get_pointname(p.mid,1,0)||' / '|| NVL(p.vname, p.nconnectionparam) Name, "
        "ryda.util_pg.get_pointname(f.mid,1,0)||' / '|| NVL(f.vname, f.nconnectionparam) Related, "
        "r.nkc, r.nfirstparam "
      "FROM ryda.relatedparam r, ryda.connectionparam p, ryda.connectionparam f "
      "WHERE p.nconnectionparam = r.nconnectionparam "
        "and r.nfirstparam = f.nconnectionparam";


    stPoint *PointsTable;
  try
  { try
    { sgPointsList->RowCount  = 2;
      sgPointsList->Rows[1]->Clear();
      //GRB ADD 16.04.2020 - test trouble ODAC
      dmMain->quMain->Params->Clear();
      //END ADD 
      dmMain->quMain->SQL->Text=s;
        dmMain->quMain->Execute();
        while(!dmMain->quMain->Eof){
        PointsTable=new stPoint;
        ZeroMemory(PointsTable, sizeof(stPoint));
        if(!dmMain->quMain->FieldByName("nconnectionparam")->IsNull)
        PointsTable->nconnectionparam = dmMain->quMain->FieldByName("nconnectionparam")->AsInteger;
        if(!dmMain->quMain->FieldByName("Name")->IsNull)
        strcpy(PointsTable->Name,dmMain->quMain->FieldByName("Name")->AsString.c_str());
        if(!dmMain->quMain->FieldByName("Related")->IsNull)
        strcpy(PointsTable->LongName,dmMain->quMain->FieldByName("Related")->AsString.c_str());
        if(!dmMain->quMain->FieldByName("nkc")->IsNull)
        PointsTable->NKC = dmMain->quMain->FieldByName("nkc")->AsFloat;
        if(!dmMain->quMain->FieldByName("nconnectionparam")->IsNull)
        PointsTable->Mid = dmMain->quMain->FieldByName("nfirstparam")->AsInteger;

         if (!sgPointsList->Cells[FIRSTVISCOL + 0][1].IsEmpty())
            sgPointsList->RowCount  = sgPointsList->RowCount + 1;
          repl_delimiters(PointsTable->Name, " / ");
          repl_delimiters(PointsTable->LongName, " / ");
          sgPointsList->Cells[FIRSTVISCOL - 1][sgPointsList->RowCount - 1]    = PointsTable->nconnectionparam;
          sgPointsList->Objects[FIRSTVISCOL - 1][sgPointsList->RowCount - 1]  = (TObject *)PointsTable->Mid;
          sgPointsList->Cells[FIRSTVISCOL + 0][sgPointsList->RowCount - 1]    = PointsTable->Name;
          sgPointsList->Cells[FIRSTVISCOL + 1][sgPointsList->RowCount - 1]    = PointsTable->LongName;
          sgPointsList->Cells[FIRSTVISCOL + 2][sgPointsList->RowCount - 1]    = PointsTable->NKC;
        dmMain->quMain->Next();
  
      }
      iaDelete->Enabled = !sgPointsList->Cells[FIRSTVISCOL + 0][1].IsEmpty();
      plEdit->Enabled   = iaDelete->Enabled;
      bool  CanSelect = true;
      sgPointsListSelectCell(this, 0, 1, CanSelect);
    }
    catch (Exception &e)
    { Application->ShowException(&e);
    }
  }__finally
   {

   }

 }
//---------------------------------------------------------------------------

void __fastcall TfmParameterPointsList::DropRelatedData(bool fromTree, TTreeNode*dstNode)
{
   stPoint src, dst;
   if(fromTree){
      memcpy(&src, tvPoints->Selected->Data, sizeof(src));
      src.NKC = 1;
   }else{
      ZeroMemory(&src, sizeof(src));
      src.nconnectionparam = sgPointsList->Cells[0][sgPointsList->Row].ToInt();
      src.Mid = (long)sgPointsList->Objects[0][sgPointsList->Row];
      src.NKC = sgPointsList->Cells[3][sgPointsList->Row].ToInt();
      strcpy(src.LongName, sgPointsList->Cells[1][sgPointsList->Row].c_str());
   }
   if(dstNode && dstNode->Data)
      memcpy(&dst, dstNode->Data, sizeof(dst));
   else
      throw Exception(Reconst_smes50_36);

   if(dst.Type==4)
   {
      if(!(sgPointsList->Cells[FIRSTVISCOL+0][1].IsEmpty() || !fromTree))
         sgPointsList->RowCount++;
      int nRow = fromTree?sgPointsList->RowCount-1:sgPointsList->Row;
      sgPointsList->Rows[nRow]->Clear();
      sgPointsList->Rows[nRow]->Add(src.nconnectionparam);
      sgPointsList->Rows[nRow]->Add(src.LongName);
      sgPointsList->Rows[nRow]->Add(dst.LongName);
      sgPointsList->Rows[nRow]->Add(src.NKC);
      sgPointsList->Objects[0][nRow] = (TObject*)dst.nconnectionparam;
      EditRec = true;
      iaDelete->Enabled = !sgPointsList->Cells[FIRSTVISCOL+0][1].IsEmpty();
      plEdit->Enabled = iaDelete->Enabled;
      SetLabel();
   }
   if(sgPointsList->Selection.Top == sgPointsList->RowCount-1)
   {
      bool CanSelect=true;
      sgPointsListSelectCell(sgPointsList, 1, sgPointsList->RowCount-1, CanSelect);
   }
}
//---------------------------------------------------------------------------
void __fastcall TfmParameterPointsList::SaveRelatedData(TObject*)
{
  long masSize = sgPointsList->Cells[FIRSTVISCOL+0][1].IsEmpty()?0:sgPointsList->RowCount-1;
  try{
    oqSaveRelatedData->SQL->Text=" begin ryda.loss_pg.setrelatedconn_p(:par1, :par2, :par3); end; ";
    for(int i=1;i<=3;i++){
      oqSaveRelatedData->ParamByName("par"+IntToStr(i))->Table=true;
      oqSaveRelatedData->ParamByName("par"+IntToStr(i))->Length=1;
    }
    oqSaveRelatedData->ParamByName("par1")->ItemAsInteger[1]=0;
    oqSaveRelatedData->ParamByName("par2")->ItemAsInteger[1]=0;
    oqSaveRelatedData->ParamByName("par3")->ItemAsFloat[1]=0; 

    for(int j=1;j<=masSize;j++){
      for(int i=1;i<=3;i++)
        oqSaveRelatedData->ParamByName("par"+IntToStr(i))->Length=j;
      oqSaveRelatedData->ParamByName("par1")->ItemAsInteger[j]=sgPointsList->Cells[0][j].ToInt();
      oqSaveRelatedData->ParamByName("par2")->ItemAsInteger[j]=(long)sgPointsList->Objects[0][j];
      oqSaveRelatedData->ParamByName("par3")->ItemAsFloat[j]=sgPointsList->Cells[3][j].ToDouble();
    }
    oqSaveRelatedData->Execute();
    dmMain->orases->Commit();
    EditRec = false;
  }catch(Exception&e){
    dmMain->orases->Rollback();
    Application->ShowException(&e);
  }
}
//---------------------------------------------------------------------------

void __fastcall TfmParameterPointsList::aDimTypeChangeExecute(TObject *Sender)
{
   if(Sender==aSaldo)
      rgDimType->ItemIndex = 0;
   else if(Sender==aPlus)
      rgDimType->ItemIndex = 1;
   else if(Sender==aMinus)
      rgDimType->ItemIndex = 2;
}
//---------------------------------------------------------------------------

void __fastcall TfmParameterPointsList::FormCreate(TObject *Sender)
{
   sgPointsList->Rows[0]->Strings[FIRSTVISCOL+0] = Reconst_smes50_42;
   sgPointsList->Rows[0]->Strings[FIRSTVISCOL+1] = Reconst_smes50_25;
   sgPointsList->Rows[0]->Strings[FIRSTVISCOL+2] = Reconst_smes50_26;
   sgPointsList->Rows[0]->Strings[FIRSTVISCOL+3] = Reconst_smes50_27;
}
//---------------------------------------------------------------------------

void __fastcall TfmParameterPointsList::FormShow(TObject *Sender)
{
   tcSelectParamsChange(Sender);   
}
//---------------------------------------------------------------------------

void __fastcall TfmParameterPointsList::tvParamViewChange(TObject *Sender,
      TTreeNode *Node)
{
   iaDelete->Enabled = tvParamView->Selected;
}
//---------------------------------------------------------------------------
/*! Действия перед изменением обмотки
*/
void __fastcall TfmParameterPointsList::Power3TabControlChanging(
      TObject *Sender, bool &AllowChange)
{
  if (EditRec)
  { AnsiString  tStr  = Reconst_smes50_37;
    switch (Power3TabControl->TabIndex)
    { case TI_UP:
        tStr  += Reconst_smes50_38;
        break;
      case TI_MIDDLE:
        tStr  += Reconst_smes50_39;
        break;
      case TI_DOWN:
        tStr  += Reconst_smes50_40;
        break;
    }
    tStr  += "?";
    switch (MessageBox(this->Handle,
                        tStr.c_str(),
                        Reconst_smes50_41.c_str(),
                        MB_YESNOCANCEL | MB_ICONQUESTION))
    { case IDYES:
        vSave(Sender);
        break;
      case IDNO:
        EditRec = false;
        break;
      case IDCANCEL:
        break;
    }
  }
  lastPage  = tcSelectParams->TabIndex;
  AllowChange = !EditRec;
}
//---------------------------------------------------------------------------
/*! Действия после изменения обмотки
*/
void __fastcall TfmParameterPointsList::Power3TabControlChange(
      TObject *Sender)
{
  iaRefreshExecute(Sender);
}
//---------------------------------------------------------------------------


