//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#include "unDataMod.h"
#include "ChannelPointsList.h"
#include "PointConditions.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "DBAccess"
#pragma link "MemDS"
#pragma link "Ora"
#pragma link "DBGridEh"
#pragma link "VirtualTable"
#pragma resource "*.dfm"

#define MAX_ROW_IN_LIST 500
const MaxCountRow = 100;
const FirstVisibleCol = 1;
long numPointInSubTree = 0;
const char* messageWarning ="Число точек опроса в окне просмотра после добавления будет превышать 500, и какая-то часть старых либо новых добавленных точек может не появиться в нём.\nДобавлять всё равно?";
const char* messageTitle = "Предупреждение: Переполнение окна просмотра";
//---------------------------------------------------------------------------
__fastcall TfmChannelPointsList::TfmChannelPointsList(TComponent* Owner, long Cid, long aIdProtocol, TAccess a)
        : TMainForm(Owner,NULL,a),CurrRow(0)
{
  TColumnEh *grColumn;
  TFieldDefs *pDefs = vtCod->FieldDefs;
  TFieldDef *pDef=NULL;

   Height=553;
   Width=780;
   if(customer_id==29||customer_id==0){
     btTU->Visible=true;
     btTU->Enabled=true;
   }
   FCid = Cid;
   FIdProtocol = aIdProtocol;
   if(FIdProtocol==61)
   {
   vtCod->AfterScroll=NULL;
    PanelCod->Visible=true;
    PanelCod->Enabled=true;
    plBase->Visible=false;
    plBase->Enabled=false;

    Label3->Parent=PanelID;
    Label3->Left=10;
    Label3->Top=3;

    lbId->Parent=PanelID;
    lbId->Left=75;
    lbId->Top=3;

    oqCod->Params->Clear();
    oqCod->SQL->Text="begin "+SchemeName+"ADDPARAM_PG.get_columbname(:par1);end;";
    oqCod->ParamByName("par1")->DataType=ftCursor;
    oqCod->ParamByName("par1")->ParamType=ptOutput;

      pDef = pDefs->AddFieldDef();
      pDef->DataType = ftInteger;
      pDef->Name = "mid";
      pDef->DisplayName="mid";

      pDef = pDefs->AddFieldDef();
      pDef->DataType = ftString;
      pDef->Size=400;
      pDef->Name = "name";
      pDef->DisplayName="name";

    for(int i=0; i<22; i++){

      pDef = pDefs->AddFieldDef();
      pDef->DataType = ftString;
      pDef->Size=12;
      pDef->Name = "Field"+IntToStr(i);
      pDef->DisplayName="Field"+IntToStr(i);
      }


     grColumn=grPoints->Columns->Add();
    // grColumn->Title->Caption=Reconst_smes6_1;
     grColumn->Title->Caption="Наименование(подстанция/фидер)";
     grColumn->Title->Alignment=taCenter;
     grColumn->FieldName="name";
     grColumn->Color=clBtnFace;
     grColumn->Width=450;
     oqCod->Execute();
    int i=0;
    while (!oqCod->Eof&&i<22)
    {
      grColumn=grPoints->Columns->Add();
      grColumn->Title->Caption=oqCod->FieldByName("vname")->AsString;
      grColumn->FieldName="Field"+IntToStr(i);
      grColumn->Width=64;
      oqCod->Next();
      i++;
    }
      grColumn=grPoints->Columns->Add();
      grColumn->Title->Caption=" ";
      grColumn->FieldName="mid";
      grColumn->Width=1;
      grColumn->Visible=false;

      grPoints->FrozenCols=1;


     grColumn=grCod->Columns->Add();
     grColumn->Title->Caption="Наименование атрибута";
     grColumn->FieldName="vdescr";
     grColumn->Color=clBtnFace;
     grColumn->ReadOnly=true;
     grColumn->Width=grCod->Width/2;
     grColumn->Title->Alignment=taCenter;
     grColumn=grCod->Columns->Add();
     grColumn->Title->Caption="Значение атрибута";
     grColumn->FieldName="vvalue";
     grColumn->Width=grCod->Width/2;
     grColumn->Title->Alignment=taCenter;
     grCod->FrozenCols=1;

    ReadDataCod();

    vtCod->First();
    iaDelete->Enabled=!vtCod->FieldByName("mid")->IsNull;
    grCod->Enabled=iaDelete->Enabled;
    lbId->Text =vtCod->FieldByName("mid")->AsInteger;
    ReadAddParam(vtCod->FieldByName("mid")->AsInteger);
    vtCod->AfterScroll=vtCodAfterScroll;
   }
   else
   {
    PanelCod->Visible=false;
    PanelCod->Enabled=false;
    plBase->Visible=true;
    plBase->Enabled=true;

   /* Label3->Parent=gbEdit;
    Label3->Left=303;
    Label3->Top=175;

   // lbId->Parent=gbEdit;
    lbId->Left=368;
    lbId->Top=175; */
    Label3->Parent=plBottom;
    Label3->Left=303;
    Label3->Top=130;

    lbId->Parent=plBottom;
    lbId->Left=368;
    lbId->Top=130;


  /* sgPointsList->Cells[FirstVisibleCol+0][0] = Reconst_smes6_1;
   sgPointsList->Cells[FirstVisibleCol+1][0] = Reconst_smes6_2; */

   //Выясняем что отображать    importcode или связной номер
   oqChPointsList->Params->Clear();
   oqChPointsList->SQL->Text="begin :par2:="+SchemeName+"channels_pg.is_viewimportcode(:par1); end;";
   oqChPointsList->ParamByName("par1")->AsInteger=aIdProtocol;
  // dmMain->quMain->ParamByName("par2")->Table=false;
   oqChPointsList->ParamByName("par2")->DataType=ftInteger;
   oqChPointsList->ParamByName("par2")->ParamType=ptOutput;
   oqChPointsList->Execute();
   FIsViewImportCode=oqChPointsList->ParamByName("par2")->AsInteger;

   if(FIsViewImportCode){
       plCodImp->Visible = true;
       plCanalNum->Visible = false;
       plUnion->Height=30;
       sgPointsList->ColCount=17;
       PlusDopCanal=0;
      /* Label1->Visible = false;
       eConnNumb->Visible = false;
       Label2->Visible = true;
       eImportCode->Visible = true; */
       sgPointsList->Cells[FirstVisibleCol+2][0] = Reconst_smes6_3;
   }else{
       plCodImp->Visible =  false;
       plCanalNum->Visible = true;
       plUnion->Height=68;
       sgPointsList->ColCount=19;
       PlusDopCanal=2;
      /* Label1->Visible = true;
       eConnNumb->Visible = true;
       Label2->Visible = false;
       eImportCode->Visible = false; */
       sgPointsList->Cells[FirstVisibleCol+2][0] = Reconst_smes6_4;
       sgPointsList->Cells[FirstVisibleCol+3][0] = "Доп.связ.№";
       sgPointsList->Cells[FirstVisibleCol+4][0] = "Выбор св.№";
   }

   sgPointsList->Cells[FirstVisibleCol+0][0] = Reconst_smes6_1;
   sgPointsList->Cells[FirstVisibleCol+1][0] = Reconst_smes6_2;

   sgPointsList->Cells[FirstVisibleCol+PlusDopCanal+3][0] = "А(+)";
   sgPointsList->Cells[FirstVisibleCol+PlusDopCanal+4][0] = "Р(+)";
   sgPointsList->Cells[FirstVisibleCol+PlusDopCanal+5][0] = "А(-)";
   sgPointsList->Cells[FirstVisibleCol+PlusDopCanal+6][0] = "Р(-)";
   sgPointsList->Cells[FirstVisibleCol+PlusDopCanal+7][0] = Reconst_smes6_5;
   sgPointsList->Cells[FirstVisibleCol+PlusDopCanal+8][0] = Reconst_smes6_6;
   sgPointsList->Cells[FirstVisibleCol+PlusDopCanal+9][0] = Reconst_smes6_7;
   sgPointsList->Cells[FirstVisibleCol+PlusDopCanal+10][0] = Reconst_smes6_8;
   sgPointsList->Cells[FirstVisibleCol+PlusDopCanal+11][0] = lComm->Caption;
   sgPointsList->Cells[FirstVisibleCol+PlusDopCanal+12][0] = lTech->Caption;
   sgPointsList->Cells[FirstVisibleCol+PlusDopCanal+13][0] = Reconst_smes6_9;
   sgPointsList->Cells[FirstVisibleCol+PlusDopCanal+14][0] = Reconst_smes6_10;
   sgPointsList->Cells[FirstVisibleCol+PlusDopCanal+15][0] = Reconst_smes6_11;
   ReadData("");
   }

   ReadTreeNode(NULL);
   rule.deniedAdd = false;
   rule.firstDialog = true;
   numPointInSubTree = 0;
}
//---------------------------------------------------------------------------
void __fastcall TfmChannelPointsList::vDelete(TObject *Sender)
{
if(FIdProtocol!=61)
   {
   if(sgPointsList->Cells[1][0].IsEmpty())
      return;
   AnsiString title = sgPointsList->Selection.Bottom==sgPointsList->Selection.Top ?
      AnsiString(Reconst_smes6_12)+sgPointsList->Cells[1][sgPointsList->Row]+"?" :
      AnsiString(Reconst_smes6_13);
   if(Application->MessageBox(title.c_str(), Application->Title.c_str(), MB_YESNO|MB_ICONQUESTION|MB_DEFBUTTON2)==ID_YES)
   {
      int b = sgPointsList->Selection.Bottom;
      int t = sgPointsList->Selection.Top;
      int c = sgPointsList->RowCount;
      for(int i=0;i < c-b-1; i++)
         sgPointsList->Rows[t+i]->Text = sgPointsList->Rows[b+i+1]->Text;
      for(int i=c-b+t; i<=c; i++)
         sgPointsList->Rows[i-1]->Text = "";
      sgPointsList->RowCount -= b-t;
      if(sgPointsList->RowCount>2)
         sgPointsList->RowCount--;
      EditRec = true;
      bool CanSelect=true;
      sgPointsListSelectCell(sgPointsList, 1, sgPointsList->Selection.Bottom, CanSelect);
      iaDelete->Enabled = !sgPointsList->Cells[FirstVisibleCol][1].IsEmpty();
      gbEdit->Enabled = iaDelete->Enabled;
   }
}
 else{
   vtCod->Delete();
   vtCod->First();
   iaDelete->Enabled =!vtCod->FieldByName("mid")->IsNull;
  // iaDelete->Enabled=vtCod->RecordCount>0;
   grCod->Enabled=iaDelete->Enabled;
   EditRec = true;
   }
  SetLabel();

}
//---------------------------------------------------------------------------
 void __fastcall TfmChannelPointsList::ReadDataCod()
 {
 int Mid=0;
    oqCod->Params->Clear();
    oqCod->SQL->Text="begin "+SchemeName+"channels_pg.get_readdatacod(:par1,:par2);end;";
    oqCod->ParamByName("par2")->DataType=ftCursor;
    oqCod->ParamByName("par2")->ParamType=ptOutput;
    oqCod->ParamByName("par1")->AsInteger=FCid;
    oqCod->Execute();
    vtCod->Open();
    while(!oqCod->Eof)
    {
     if(Mid!=oqCod->FieldByName("mid")->AsInteger)
     {
     vtCod->Append();
     Mid=oqCod->FieldByName("mid")->AsInteger;
     vtCod->FieldByName("mid")->AsInteger=oqCod->FieldByName("mid")->AsInteger;
     vtCod->FieldByName("name")->AsString=oqCod->FieldByName("vname")->AsString;
     if(!oqCod->FieldByName("nsort")->IsNull)
     vtCod->FieldByName("Field"+IntToStr((oqCod->FieldByName("nsort")->AsInteger*-1)-31))->AsString
                   =oqCod->FieldByName("vvalue")->AsString;

     }
     else
     {
     if(!oqCod->FieldByName("nsort")->IsNull)
     vtCod->FieldByName("Field"+IntToStr((oqCod->FieldByName("nsort")->AsInteger*-1)-31))->AsString
                   =oqCod->FieldByName("vvalue")->AsString;
     }
     oqCod->Next();
    }

 }
//-------------------------------------------------------------------------
  void __fastcall TfmChannelPointsList::ReadAddParam(int Mid)
 {
  vtCod->AfterScroll=NULL;
 vtCod->Open();
  //  oqAddParam->Params->Clear();
  //  oqAddParam->SQL->Text="begin "+SchemeName+"ADDPARAM_PG.get_addparam(:mid,:SpezParam,:tcur,:objtype);end;";
  //  oqAddParam->ParamByName("tcur")->DataType=ftCursor;
  //  oqAddParam->ParamByName("tcur")->ParamType=ptOutput;

    oqAddParam->ParamByName("mid")->AsInteger=Mid;
    oqAddParam->ParamByName("SpezParam")->AsInteger=2;
    oqAddParam->ParamByName("objtype")->AsInteger=1;

    oqAddParam->Execute();
    vtCod->AfterScroll=vtCodAfterScroll;


 }
//---------------------------------------------------------------------------------------------


void __fastcall TfmChannelPointsList::vtCodAfterScroll(TDataSet *DataSet)
{
    vtCod->AfterScroll=NULL;
     oqAddParam->DisableControls();
    grCod->Columns->BeginUpdate();
       oqAddParam->Close();
       ReadAddParam(vtCod->FieldByName("mid")->AsInteger);
       lbId->Text =vtCod->FieldByName("mid")->AsInteger;
    grCod->Columns->EndUpdate();
    oqAddParam->EnableControls();
    vtCod->AfterScroll=vtCodAfterScroll;
    SetLabel(vtCod->RecNo);
}
//---------------------------------------------------------------------------

void __fastcall TfmChannelPointsList::ReadData(AnsiString MidMass)
{

   stPoint *PointsTable;
   AnsiString sqlQry = MidMass.IsEmpty() ?
      AnsiString("begin ")+SchemeName+"channels_pg.get_ReadData1(:par1,:par2); end;":
      AnsiString("begin ")+SchemeName+"channels_pg.get_ReadData2(:par1,:par2); end;";
   try
   {
     oqChPointsList->Params->Clear();
     oqChPointsList->SQL->Text=sqlQry;
     oqChPointsList->ParamByName("par2")->ParamType = ptOutput;
     oqChPointsList->ParamByName("par2")->DataType = ftCursor;
      if(MidMass.IsEmpty())
      {
        sgPointsList->Rows[1]->Clear();
        sgPointsList->RowCount = 2;
        oqChPointsList->ParamByName("par1")->AsInteger=FCid;
      }
      else
        oqChPointsList->ParamByName("par1")->AsString=MidMass;

       oqChPointsList->Execute();
       while(!oqChPointsList->Eof){
       PointsTable=new stPoint;
       ZeroMemory(PointsTable,sizeof(stPoint));
       PointsTable->Mid=oqChPointsList->FieldByName("MID")->AsInteger;
        if(!oqChPointsList->FieldByName("vname")->IsNull)
           strcpy(PointsTable->Name,oqChPointsList->FieldByName("vname")->AsString.c_str());
        if(!oqChPointsList->FieldByName("TAG")->IsNull)
           strcpy(PointsTable->Tag,oqChPointsList->FieldByName("TAG")->AsString.c_str());
        PointsTable->CANAL=oqChPointsList->FieldByName("CANAL")->AsInteger;
        PointsTable->ER_POSITION=oqChPointsList->FieldByName("ER_POSITION")->AsInteger;
        PointsTable->Q1_POSITION=oqChPointsList->FieldByName("Q1_POSITION")->AsInteger;
        PointsTable->ED_POSITION=oqChPointsList->FieldByName("ED_POSITION")->AsInteger;
        PointsTable->Q3_POSITION=oqChPointsList->FieldByName("Q3_POSITION")->AsInteger;
        if(!oqChPointsList->FieldByName("VINFO")->IsNull)
           strcpy(PointsTable->v_info,oqChPointsList->FieldByName("VINFO")->AsString.c_str());
        if(!oqChPointsList->FieldByName("p_info")->IsNull)
           strcpy(PointsTable->p_info,oqChPointsList->FieldByName("p_info")->AsString.c_str());
        PointsTable->nBlock=oqChPointsList->FieldByName("NBLOCK")->AsInteger;
        if(!oqChPointsList->FieldByName("NDATAABSENCE")->IsNull)
           PointsTable->DataAbsence=oqChPointsList->FieldByName("NDATAABSENCE")->AsInteger;
        if(!oqChPointsList->FieldByName("NCOMMCONTROL")->IsNull)
           strcpy(PointsTable->CommCtrl,oqChPointsList->FieldByName("NCOMMCONTROL")->AsString.c_str());
        if(!oqChPointsList->FieldByName("NTECHCONTROL")->IsNull)
           strcpy(PointsTable->TechCtrl,oqChPointsList->FieldByName("NTECHCONTROL")->AsString.c_str());
        if(!oqChPointsList->FieldByName("vImportCode")->IsNull)
           strcpy(PointsTable->ImportCode,oqChPointsList->FieldByName("vImportCode")->AsString.c_str());
        PointsTable->nblocktime=oqChPointsList->FieldByName("nblocktime")->AsInteger;
        PointsTable->ntimezonew=oqChPointsList->FieldByName("NTIMEZONEW")->AsInteger;
        PointsTable->ntimezones=oqChPointsList->FieldByName("NTIMEZONES")->AsInteger;
        PointsTable->ResCanal=oqChPointsList->FieldByName("RESCANAL")->AsInteger;
        PointsTable->CheckCanal=oqChPointsList->FieldByName("NUSERESCANAL")->AsInteger;

            if(!sgPointsList->Cells[FirstVisibleCol][1].IsEmpty())
               sgPointsList->RowCount = sgPointsList->RowCount+1;
            repl_delimiters(PointsTable->Name, " / ");
            sgPointsList->Cells[FirstVisibleCol-1][sgPointsList->RowCount-1] = IntToStr(PointsTable->Mid);
            sgPointsList->Cells[FirstVisibleCol+0][sgPointsList->RowCount-1] = PointsTable->Name;
            sgPointsList->Cells[FirstVisibleCol+1][sgPointsList->RowCount-1] = PointsTable->nBlock;
            if(FIsViewImportCode)
                sgPointsList->Cells[FirstVisibleCol+2][sgPointsList->RowCount-1] = PointsTable->ImportCode;
            else {
                sgPointsList->Cells[FirstVisibleCol+2][sgPointsList->RowCount-1] = PointsTable->CANAL;
                sgPointsList->Cells[FirstVisibleCol+3][sgPointsList->RowCount-1] = PointsTable->ResCanal;
                sgPointsList->Cells[FirstVisibleCol+4][sgPointsList->RowCount-1] = PointsTable->CheckCanal;
                 }
            sgPointsList->Cells[FirstVisibleCol+PlusDopCanal+3][sgPointsList->RowCount-1] = PointsTable->ER_POSITION;
            sgPointsList->Cells[FirstVisibleCol+PlusDopCanal+4][sgPointsList->RowCount-1] = PointsTable->Q1_POSITION;
            sgPointsList->Cells[FirstVisibleCol+PlusDopCanal+5][sgPointsList->RowCount-1] = PointsTable->ED_POSITION;
            sgPointsList->Cells[FirstVisibleCol+PlusDopCanal+6][sgPointsList->RowCount-1] = PointsTable->Q3_POSITION;
            sgPointsList->Cells[FirstVisibleCol+PlusDopCanal+7][sgPointsList->RowCount-1] = PointsTable->Tag;
            sgPointsList->Cells[FirstVisibleCol+PlusDopCanal+8][sgPointsList->RowCount-1] = PointsTable->v_info;
            repl_delimiters(PointsTable->p_info, " ");
            sgPointsList->Cells[FirstVisibleCol+PlusDopCanal+9][sgPointsList->RowCount-1] = PointsTable->p_info;
            sgPointsList->Cells[FirstVisibleCol+PlusDopCanal+10][sgPointsList->RowCount-1] = PointsTable->DataAbsence;
            sgPointsList->Cells[FirstVisibleCol+PlusDopCanal+11][sgPointsList->RowCount-1] = PointsTable->CommCtrl;
            sgPointsList->Cells[FirstVisibleCol+PlusDopCanal+12][sgPointsList->RowCount-1] = PointsTable->TechCtrl;
            sgPointsList->Cells[FirstVisibleCol+PlusDopCanal+13][sgPointsList->RowCount-1] = PointsTable->nblocktime;
            sgPointsList->Cells[FirstVisibleCol+PlusDopCanal+14][sgPointsList->RowCount-1] = PointsTable->ntimezonew;
            sgPointsList->Cells[FirstVisibleCol+PlusDopCanal+15][sgPointsList->RowCount-1] = PointsTable->ntimezones;

         oqChPointsList->Next();
         }

      iaDelete->Enabled = !sgPointsList->Cells[FirstVisibleCol][1].IsEmpty();
      gbEdit->Enabled = iaDelete->Enabled;
      bool CanSelect=true;
      sgPointsListSelectCell(this, 0, 1, CanSelect);
   }__finally
   {

   }
}
//---------------------------------------------------------------------------
void __fastcall TfmChannelPointsList::vRefresh(TObject *Sender)
{
TBookmark SavePlace,SavePlace1;

if(FIdProtocol!=61)
   {
   ReadData("");
   EditRec = false;
   sgPointsList->SetFocus();
   }else{
    vtCod->AfterScroll=NULL;
    SavePlace = vtCod->GetBookmark();
    SavePlace1 =oqAddParam->GetBookmark();
    oqAddParam->DisableControls();
    vtCod->DisableControls();
    grCod->Columns->BeginUpdate();
    grPoints->Columns->BeginUpdate();
    vtCod->Close();
    vtCod->Clear();
    ReadDataCod();
    grPoints->Columns->EndUpdate();
    grCod->Columns->EndUpdate();
    vtCod->GotoBookmark(SavePlace);
    vtCod->FreeBookmark(SavePlace);
    oqAddParam->GotoBookmark(SavePlace1);
    oqAddParam->FreeBookmark(SavePlace1);
    oqAddParam->EnableControls();
    vtCod->EnableControls();
    iaDelete->Enabled=vtCod->RecordCount>0;
    grCod->Enabled=iaDelete->Enabled;
     EditRec = false;
    grPoints->SelectedIndex==0;
    grPoints->SetFocus();
    vtCod->AfterScroll=vtCodAfterScroll;}
}
//---------------------------------------------------------------------------
void __fastcall TfmChannelPointsList::vSave(TObject *Sender)
{
TBookmark SavePlace;
if(FIdProtocol!=61)
   {
   SavePoints();
   }else{
    SavePlace = vtCod->GetBookmark();
    vtCod->DisableControls();
     SaveCod();
    vtCod->GotoBookmark(SavePlace);
    vtCod->FreeBookmark(SavePlace);
    vtCod->EnableControls();

   }
}
//-----------------------------------------------------------------------------
void __fastcall TfmChannelPointsList::SaveCod()
{
// if(oqAddParam->State==dsEdit)
//   oqAddParam->Post();
   try{
//    oqAddParam->ApplyUpdates();
//    oqAddParam->Session->Commit();
//    oqAddParam->CommitUpdates();

  if(vtCod->State==dsInsert||vtCod->State==dsEdit)

     vtCod->Post();
     oqSave->Params->Clear();
     oqSave->SQL->Text=" begin "+SchemeName+"channels_pg.setpoint_p(:par1,:par2); end; ";
     oqSave->ParamByName("par1")->AsInteger=FCid;
     oqSave->ParamByName("par2")->Table=true;
     oqSave->ParamByName("par2")->Length=1;
     oqSave->ParamByName("par2")->ItemAsInteger[1]=0;
     vtCod->First();
     int i=1;
     while(!vtCod->Eof){
        oqSave->ParamByName("par2")->Length=i;
        oqSave->ParamByName("par2")->ItemAsInteger[i]=vtCod->FieldByName("mid")->AsInteger;
        i++;
        vtCod->Next();
     }
     oqSave->Execute();
     dmMain->orases->Commit();

 //--------------------------------------------------------------------------
     oqSave->Params->Clear();
     oqSave->SQL->Text="begin "+SchemeName+"ADDPARAM_PG.upd_addparam(:mid,:nsort,:vvalue,:objtype);end;";
     vtCod->First();
    while(!vtCod->Eof)
    {
    
      for(int i=2;i<vtCod->FieldCount;i++)
      {
        if(!vtCod->FieldByName("Field"+IntToStr(i-2))->IsNull)
         {
         oqSave->ParamByName("mid")->AsInteger=vtCod->FieldByName("mid")->AsInteger;
         oqSave->ParamByName("objtype")->AsInteger=1;
         oqSave->ParamByName("nsort")->AsInteger=-31-(i-2);
         oqSave->ParamByName("vvalue")->AsString=vtCod->FieldByName("Field"+IntToStr(i-2))->AsString;
         oqSave->Execute();
         dmMain->orases->Commit();
         }
     }
    vtCod->Next();
   }
 //--------------------------------------------------------
  //   vRefresh(this);

   }catch (Exception &exception){
    dmMain->orases->Rollback();
    vRefresh(this);
    Application->ShowException(&exception);
   }
   EditRec = false;
}
//-------------------------------------------------------------------------------
void __fastcall TfmChannelPointsList::SavePoints()
{

  TEdit*edit=NULL;
  long masSize = sgPointsList->Cells[FirstVisibleCol][1].IsEmpty()?0:sgPointsList->RowCount-1;
  try{
     oqSave->Params->Clear();
     oqSave->SQL->Text=" begin "+SchemeName+"channels_pg.setpoint_p(:par1,:par2,:par3); end; ";
     oqSave->ParamByName("par1")->AsInteger=FCid;
     oqSave->ParamByName("par2")->Table=true;
     oqSave->ParamByName("par2")->Length=1;
     oqSave->ParamByName("par2")->ItemAsInteger[1]=0;
     oqSave->ParamByName("par3")->Table=true;
     oqSave->ParamByName("par3")->Length=1;
     oqSave->ParamByName("par3")->ItemAsInteger[1]=0;
     for(int i=1;i<=masSize;i++){
        oqSave->ParamByName("par2")->Length=i;
        oqSave->ParamByName("par2")->ItemAsInteger[i]=sgPointsList->Cols[0]->Strings[i].ToInt();
        oqSave->ParamByName("par3")->Length=i;
        if(FIsViewImportCode)
        oqSave->ParamByName("par3")->ItemAsInteger[i]=0;
        else
        oqSave->ParamByName("par3")->ItemAsInteger[i]=sgPointsList->Cols[5]->Strings[i].ToInt();
     }
     oqSave->Execute();

      // сохранение изменений для точек...
      for(int i=0; i<sgPointsList->RowCount; i++)
     if(sgPointsList->Objects[0][i]){


    // вызов update_p-2
   oqChPointsList->Params->Clear();
   oqChPointsList->SQL->Text="begin "+SchemeName+"editfeeders_pg.upd_p(:par1,:par2,:par3,:par4,:par5,:par6,:par7,:par8,:par9,\
            :par10,:par11,:par12,:par13,:par14,:par15,:par16,:par17); end; ";
          edit = eConnNumb;

          oqChPointsList->ParamByName("par1")->AsInteger=sgPointsList->Cells[0][i].ToInt();
         if(FIsViewImportCode)
         {

            oqChPointsList->ParamByName("par2")->AsString=sgPointsList->Cells[3][i];
            oqChPointsList->ParamByName("par3")->Clear();
            oqChPointsList->ParamByName("par17")->Clear();
         }
         else
         {
            oqChPointsList->ParamByName("par3")->AsInteger=sgPointsList->Cells[3][i].Trim().ToInt();
            oqChPointsList->ParamByName("par2")->Clear();
            oqChPointsList->ParamByName("par17")->AsInteger=sgPointsList->Cells[4][i].Trim().ToInt();

         }
         edit = eTag;
         if( sgPointsList->Cells[8][i].Trim().IsEmpty())
                            oqChPointsList->ParamByName("par4")->Clear();
         else oqChPointsList->ParamByName("par4")->AsInteger=sgPointsList->Cells[PlusDopCanal+8][i].Trim().ToInt();

         edit = eAPlus;
         oqChPointsList->ParamByName("par5")->AsInteger=sgPointsList->Cells[PlusDopCanal+4][i].Trim().ToInt();

         edit = eRPlus;
         oqChPointsList->ParamByName("par6")->AsInteger=sgPointsList->Cells[PlusDopCanal+5][i].Trim().ToInt();

         edit = eAMinus;
         oqChPointsList->ParamByName("par7")->AsInteger=sgPointsList->Cells[PlusDopCanal+6][i].Trim().ToInt();

         edit = eRMinus;
        oqChPointsList->ParamByName("par8")->AsInteger=sgPointsList->Cells[PlusDopCanal+7][i].Trim().ToInt();

        if(sgPointsList->Cells[PlusDopCanal+9][i].IsEmpty())
                 oqChPointsList->ParamByName("par9")->Clear();
        else oqChPointsList->ParamByName("par9")->AsString= sgPointsList->Cells[PlusDopCanal+9][i];

         oqChPointsList->ParamByName("par10")->AsInteger=(sgPointsList->Cells[2][i]=="1")?1:0;

         oqChPointsList->ParamByName("par11")->AsInteger=(sgPointsList->Cells[PlusDopCanal+11][i]=="1")?1:0;

         edit = eComm;
        if(sgPointsList->Cells[PlusDopCanal+12][i].Trim().IsEmpty())
                           oqChPointsList->ParamByName("par12")->Clear();
        else  oqChPointsList->ParamByName("par12")->AsInteger=sgPointsList->Cells[PlusDopCanal+12][i].Trim().ToInt();

         edit = eTech;
         if(sgPointsList->Cells[PlusDopCanal+13][i].Trim().IsEmpty())
                           oqChPointsList->ParamByName("par13")->Clear();
         else oqChPointsList->ParamByName("par13")->AsInteger=sgPointsList->Cells[PlusDopCanal+13][i].Trim().ToInt();

        oqChPointsList->ParamByName("par14")->AsInteger=(sgPointsList->Cells[PlusDopCanal+14][i]=="1")?1:0;

         oqChPointsList->ParamByName("par15")->AsInteger=StrToInt(sgPointsList->Cells[PlusDopCanal+15][i]);

        oqChPointsList->ParamByName("par16")->AsInteger=StrToInt(sgPointsList->Cells[PlusDopCanal+16][i]);


        oqChPointsList->Execute();
          sgPointsList->Objects[0][i] = NULL;
      }

      dmMain->orases->Commit();
      EditRec = false;
   }
   catch(EConvertError&e){
      dmMain->orases->Rollback();
      Application->ShowException(&Exception(Reconst_smes6_14));
      edit->SetFocus();
      return;
   }
   catch(Exception&e){
     dmMain->orases->Rollback();
     Application->ShowException(&e);
   }

}
//---------------------------------------------------------------------------
// Читает ветку дерева
bool __fastcall TfmChannelPointsList::ReadTreeNode(TObject*obj)
{
   TTreeNode*NodeParent=dynamic_cast<TTreeNode*>(obj);
   stPoint *PTreeTable;
   TTreeNode *AddNode;

   try{
    oqChPointsList->Params->Clear();
    if(!NodeParent){
      oqChPointsList->SQL->Text=" begin "+SchemeName+"channels_pg.read_NOTparent(:par2); end; ";
    }else{
      oqChPointsList->SQL->Text=" begin "+SchemeName+"channels_pg.read_VSparent(:par1,:par2); end; ";
      oqChPointsList->ParamByName("par1")->AsInteger = ((stPoint*)NodeParent->Data)->Mid;
     }
     oqChPointsList->ParamByName("par2")->ParamType = ptOutput;
     oqChPointsList->ParamByName("par2")->DataType = ftCursor;
     oqChPointsList->Execute();
     while(!oqChPointsList->Eof){
     PTreeTable=new stPoint;
     ZeroMemory(PTreeTable,sizeof(stPoint));
      PTreeTable->HaveChild=oqChPointsList->FieldByName("HaveChild")->AsInteger;
     PTreeTable->Mid=oqChPointsList->FieldByName("mid")->AsInteger;
     strcpy(PTreeTable->Name,oqChPointsList->FieldByName("name")->AsString.c_str());
     PTreeTable->Type=oqChPointsList->FieldByName("Type")->AsInteger;
     if(!oqChPointsList->FieldByName("TAG")->IsNull)
     strcpy(PTreeTable->Tag,oqChPointsList->FieldByName("TAG")->AsString.c_str());
     PTreeTable->CANAL=oqChPointsList->FieldByName("CANAL")->AsInteger;
     PTreeTable->ResCanal=oqChPointsList->FieldByName("rescanal")->AsInteger;
     PTreeTable->CheckCanal=oqChPointsList->FieldByName("nuserescanal")->AsInteger;
     PTreeTable->ER_POSITION=oqChPointsList->FieldByName("ER_POSITION")->AsInteger;
     PTreeTable->Q1_POSITION=oqChPointsList->FieldByName("Q1_POSITION")->AsInteger;
     PTreeTable->ED_POSITION=oqChPointsList->FieldByName("ED_POSITION")->AsInteger;
     PTreeTable->Q3_POSITION=oqChPointsList->FieldByName("Q3_POSITION")->AsInteger;
     if(!oqChPointsList->FieldByName("VINFO")->IsNull)
     strcpy(PTreeTable->v_info,oqChPointsList->FieldByName("VINFO")->AsString.c_str());
     if(!oqChPointsList->FieldByName("LongName")->IsNull)
     strcpy(PTreeTable->LongName,oqChPointsList->FieldByName("LongName")->AsString.c_str());
     if(!oqChPointsList->FieldByName("p_info")->IsNull)
     strcpy(PTreeTable->p_info,oqChPointsList->FieldByName("p_info")->AsString.c_str());
     if(!oqChPointsList->FieldByName("nblock")->IsNull)
     PTreeTable->nBlock=oqChPointsList->FieldByName("nblock")->AsInteger;
     if(!oqChPointsList->FieldByName("ndataabsence")->IsNull)
     PTreeTable->DataAbsence=oqChPointsList->FieldByName("ndataabsence")->AsInteger;
     if(!oqChPointsList->FieldByName("ncommcontrol")->IsNull)
     strcpy(PTreeTable->CommCtrl,oqChPointsList->FieldByName("ncommcontrol")->AsString.c_str());
     if(!oqChPointsList->FieldByName("ntechcontrol")->IsNull)
     strcpy(PTreeTable->TechCtrl,oqChPointsList->FieldByName("ntechcontrol")->AsString.c_str());
     if(!oqChPointsList->FieldByName("vImportCode")->IsNull)
     strcpy(PTreeTable->ImportCode,oqChPointsList->FieldByName("vImportCode")->AsString.c_str());
     if(!oqChPointsList->FieldByName("NLOCKCORRECTTIME")->IsNull)
     PTreeTable->nblocktime=oqChPointsList->FieldByName("NLOCKCORRECTTIME")->AsInteger;
     if(!oqChPointsList->FieldByName("NTIMEZONEW")->IsNull)
     PTreeTable->ntimezonew=oqChPointsList->FieldByName("NTIMEZONEW")->AsInteger;
     if(!oqChPointsList->FieldByName("NTIMEZONES")->IsNull)
     PTreeTable->ntimezones=oqChPointsList->FieldByName("NTIMEZONES")->AsInteger;


            repl_delimiters(PTreeTable->p_info, " ");
            repl_delimiters(PTreeTable->LongName, " / ");
            AddNode = tvPoints->Items->AddChildObject(NodeParent,PTreeTable->Name,PTreeTable);
            AddNode->ImageIndex =(PTreeTable->Type==3)?0:(PTreeTable->Type==4)?26:4;
            AddNode->SelectedIndex=(PTreeTable->Type==3)?0:(PTreeTable->Type==4)?26:4;
            AddNode->HasChildren = PTreeTable->HaveChild;

        oqChPointsList->Next();
        }
  }
  catch (Exception &exception){
  	Application->ShowException(&exception);
    return false;
  }
  SetLabel();
  return true;
}
//---------------------------------------------------------------------------
void __fastcall TfmChannelPointsList::tvPointsCollapsed(TObject *Sender,
      TTreeNode *Node)
{
    if(Node&&Node->ImageIndex==5)
    {
      Node->SelectedIndex = 4;
      Node->ImageIndex = 4;
    }
}
//---------------------------------------------------------------------------
void __fastcall TfmChannelPointsList::tvPointsExpanded(TObject *Sender,
      TTreeNode *Node)
{
    if(Node&&Node->ImageIndex==4)
    {
      Node->SelectedIndex = 5;
      Node->ImageIndex = 5;
    }
}
//---------------------------------------------------------------------------
void __fastcall TfmChannelPointsList::tvPointsExpanding(TObject *Sender,
      TTreeNode *Node, bool &AllowExpansion)
{
   if(Node&&Node->HasChildren&&!Node->getFirstChild())
      ReadTreeNode(Node);
}
//---------------------------------------------------------------------------
void __fastcall TfmChannelPointsList::tvPointsStartDrag(TObject *Sender,
      TDragObject *&DragObject)
{

   DragData = (stPoint*)tvPoints->Selected->Data;
   rule.deniedAdd = false;
   rule.firstDialog = true;
   numPointInSubTree = 0;
}
//---------------------------------------------------------------------------
void __fastcall TfmChannelPointsList::sgPointsListDragOver(TObject *Sender,
      TObject *Source, int X, int Y, TDragState State, bool &Accept)
{
      Accept = (Access==accRead)?
      false:
      DragData&&sgPointsList->Cols[0]->IndexOf(DragData->Mid)<0&&(DragData->Type==3 || DragData->Type==2);
}
//29.05.2018 - FIX - METHOD COMMENTED BY GRB
//---------------------------------------------------------------------------
/*void __fastcall TfmChannelPointsList::sgPointsListDragDrop(TObject *Sender,
      TObject *Source, int X, int Y)
{
   if(DragData->Type==3){
      if(DragData)
      {
         if(!sgPointsList->Cells[FirstVisibleCol][1].IsEmpty())
            sgPointsList->RowCount++;
         sgPointsList->Rows[sgPointsList->RowCount-1]->Clear();
         sgPointsList->Rows[sgPointsList->RowCount-1]->Add(DragData->Mid);
         sgPointsList->Rows[sgPointsList->RowCount-1]->Add(DragData->LongName);
         sgPointsList->Rows[sgPointsList->RowCount-1]->Add(DragData->nBlock);

         if(FIsViewImportCode)
            sgPointsList->Rows[sgPointsList->RowCount-1]->Add(DragData->ImportCode);
         else {
            sgPointsList->Rows[sgPointsList->RowCount-1]->Add(DragData->CANAL);
            sgPointsList->Rows[sgPointsList->RowCount-1]->Add(DragData->ResCanal);
            sgPointsList->Rows[sgPointsList->RowCount-1]->Add(DragData->CheckCanal);
              }
         sgPointsList->Rows[sgPointsList->RowCount-1]->Add(DragData->ER_POSITION);
         sgPointsList->Rows[sgPointsList->RowCount-1]->Add(DragData->Q1_POSITION);
         sgPointsList->Rows[sgPointsList->RowCount-1]->Add(DragData->ED_POSITION);
         sgPointsList->Rows[sgPointsList->RowCount-1]->Add(DragData->Q3_POSITION);
         sgPointsList->Rows[sgPointsList->RowCount-1]->Add(DragData->Tag);
         sgPointsList->Rows[sgPointsList->RowCount-1]->Add(DragData->v_info);
         sgPointsList->Rows[sgPointsList->RowCount-1]->Add(DragData->p_info);
         sgPointsList->Rows[sgPointsList->RowCount-1]->Add(DragData->DataAbsence);
         sgPointsList->Rows[sgPointsList->RowCount-1]->Add(DragData->CommCtrl);
         sgPointsList->Rows[sgPointsList->RowCount-1]->Add(DragData->TechCtrl);
         sgPointsList->Rows[sgPointsList->RowCount-1]->Add(DragData->nblocktime);
         sgPointsList->Rows[sgPointsList->RowCount-1]->Add(DragData->ntimezonew);
         sgPointsList->Rows[sgPointsList->RowCount-1]->Add(DragData->ntimezones);
         DragData = NULL;
         EditRec = true;
         iaDelete->Enabled = !sgPointsList->Cells[FirstVisibleCol][1].IsEmpty();
         gbEdit->Enabled = iaDelete->Enabled;
         SetLabel();
      }
   }else{
      TTreeNode* currnode = Source==tvPoints?tvPoints->Selected:(TTreeNode*)Source;
      bool Accept = true;
      tvPointsExpanding(tvPoints, currnode, Accept);
      currnode = currnode->getFirstChild();
      while(currnode){
         DragData = (stPoint*)currnode->Data;
         sgPointsListDragOver(Sender, Source, X, Y, dsDragEnter, Accept);
         if(Accept)
            sgPointsListDragDrop(Sender, currnode, X, Y);
         currnode = currnode->getNextSibling();
      }
   }
   if(sgPointsList->Selection.Top == sgPointsList->RowCount-1)
   {
      bool CanSelect=true;
      sgPointsListSelectCell(sgPointsList, 1, sgPointsList->RowCount-1, CanSelect);
   }
}*/

//29.05.2018 - FIX - RENAMED TO sgPointsListDragDropOld BY GRB
//---------------------------------------------------------------------------

void __fastcall TfmChannelPointsList::sgPointsListDragDropOld(TObject *Sender,
      TObject *Source, int X, int Y)
{
   if(DragData->Type==3){
      if(DragData)
      {
         if(!sgPointsList->Cells[FirstVisibleCol][1].IsEmpty())
            sgPointsList->RowCount++;
         sgPointsList->Rows[sgPointsList->RowCount-1]->Clear();
         sgPointsList->Rows[sgPointsList->RowCount-1]->Add(DragData->Mid);
         sgPointsList->Rows[sgPointsList->RowCount-1]->Add(DragData->LongName);
         sgPointsList->Rows[sgPointsList->RowCount-1]->Add(DragData->nBlock);

         if(FIsViewImportCode)
            sgPointsList->Rows[sgPointsList->RowCount-1]->Add(DragData->ImportCode);
         else {
            sgPointsList->Rows[sgPointsList->RowCount-1]->Add(DragData->CANAL);
            sgPointsList->Rows[sgPointsList->RowCount-1]->Add(DragData->ResCanal);
            sgPointsList->Rows[sgPointsList->RowCount-1]->Add(DragData->CheckCanal);
              }
         sgPointsList->Rows[sgPointsList->RowCount-1]->Add(DragData->ER_POSITION);
         sgPointsList->Rows[sgPointsList->RowCount-1]->Add(DragData->Q1_POSITION);
         sgPointsList->Rows[sgPointsList->RowCount-1]->Add(DragData->ED_POSITION);
         sgPointsList->Rows[sgPointsList->RowCount-1]->Add(DragData->Q3_POSITION);
         sgPointsList->Rows[sgPointsList->RowCount-1]->Add(DragData->Tag);
         sgPointsList->Rows[sgPointsList->RowCount-1]->Add(DragData->v_info);
         sgPointsList->Rows[sgPointsList->RowCount-1]->Add(DragData->p_info);
         sgPointsList->Rows[sgPointsList->RowCount-1]->Add(DragData->DataAbsence);
         sgPointsList->Rows[sgPointsList->RowCount-1]->Add(DragData->CommCtrl);
         sgPointsList->Rows[sgPointsList->RowCount-1]->Add(DragData->TechCtrl);
         sgPointsList->Rows[sgPointsList->RowCount-1]->Add(DragData->nblocktime);
         sgPointsList->Rows[sgPointsList->RowCount-1]->Add(DragData->ntimezonew);
         sgPointsList->Rows[sgPointsList->RowCount-1]->Add(DragData->ntimezones);
         DragData = NULL;
         EditRec = true;
         iaDelete->Enabled = !sgPointsList->Cells[FirstVisibleCol][1].IsEmpty();
         gbEdit->Enabled = iaDelete->Enabled;
         SetLabel();
      }
   }else{
      TTreeNode* currnode = Source==tvPoints?tvPoints->Selected:(TTreeNode*)Source;
      bool Accept = true;
      tvPointsExpanding(tvPoints, currnode, Accept);
      currnode = currnode->getFirstChild();
      while(currnode){
         DragData = (stPoint*)currnode->Data;
         sgPointsListDragOver(Sender, Source, X, Y, dsDragEnter, Accept);
         if(Accept)
            sgPointsListDragDropOld(Sender, currnode, X, Y);
         currnode = currnode->getNextSibling();
      }
   }
   if(sgPointsList->Selection.Top == sgPointsList->RowCount-1)
   {
      bool CanSelect=true;
      sgPointsListSelectCell(sgPointsList, 1, sgPointsList->RowCount-1, CanSelect);
   }
}


//GRB FIX METHOD(if more 500 points in list - you don't see some of them at all, so need to be some warning) 29.05.2018 - REWRITE: + added 2 global flags: deniedAdd and firsDialog
void __fastcall TfmChannelPointsList::sgPointsListDragDrop(TObject *Sender,
      TObject *Source, int X, int Y)
{
   long tst = getNumPointsInSubTree(Sender, Source, X, Y);
         DragData = (stPoint*)tvPoints->Selected->Data;
   if (((sgPointsList->RowCount) + tst)>=MAX_ROW_IN_LIST){
    if (rule.firstDialog){
      rule.firstDialog = false;
    switch(MessageBox(Handle,messageWarning,messageTitle,MB_YESNO|MB_ICONQUESTION|MB_DEFBUTTON1)){
      case IDYES:
         rule.deniedAdd = false;
         break;
      case IDNO:
         rule.deniedAdd = true;
         break;
      }
   }
   }
   if (!rule.deniedAdd){
        sgPointsListDragDropOld (Sender,Source, X, Y);
   }
}

//---------------------------------------------------------------------------
// Предварительный рассчёт количества новых точек учёта в добавляемом поддереве проходом в глубину
long __fastcall TfmChannelPointsList::getNumPointsInSubTree(TObject *Sender, TObject *Source, int X, int Y){
   TTreeNode* currnode = Source==tvPoints?tvPoints->Selected:(TTreeNode*)Source;
   if(DragData->Type==3){
      if(DragData) {
         numPointInSubTree++;
         DragData = NULL;
      }
   }else{
      bool Accept = true;
      tvPointsExpanding(tvPoints, currnode, Accept);
      currnode = currnode->getFirstChild();
      while(currnode){
         DragData = (stPoint*)currnode->Data;
         sgPointsListDragOver(Sender, Source, X, Y, dsDragEnter, Accept);
         if(Accept)
            getNumPointsInSubTree(Sender, currnode, X, Y);
         currnode = currnode->getNextSibling();
      }
   }
   return numPointInSubTree;
}

//---------------------------------------------------------------------------
// Рассчёт количества любых узлов на подуровне (не нужно)
long getNumPointInGroup (TTreeNode* parnode){
        TTreeNode* currnode = parnode;
        long retNum = 0;
        while(currnode){
                currnode = currnode->getNextSibling();
                retNum++;
        }
        return retNum;
}
//---------------------------------------------------------------------------
void __fastcall TfmChannelPointsList::SetAccess(TAccess value)
{
   if(FAccess != value){
      TMainForm::SetAccess(value);
      iaDelete->Enabled = value==accWrite;
     if(FIdProtocol!=61)
        gbEdit->Enabled = iaDelete->Enabled;
     else
       grCod->Enabled=iaDelete->Enabled;

   }
}
//---------------------------------------------------------------------------
void __fastcall TfmChannelPointsList::sgPointsListSelectCell(TObject *Sender,
   int ACol, int ARow, bool &CanSelect)
{
   bool oldEdit = EditRec;
   SetLabel(ARow);
   CurrRow=0;
   lbId->Text = sgPointsList->Cells[0][ARow];
   gbEdit->Caption = Reconst_smes6_15+
                       sgPointsList->Cells[FirstVisibleCol+0][ARow]+"\"";
   cbBlocking->Checked = (sgPointsList->Cells[FirstVisibleCol+1][ARow]=="1");

   if(FIsViewImportCode)
      eImportCode->Text = sgPointsList->Cells[FirstVisibleCol+2][ARow];
   else{
      eConnNumb->Text = sgPointsList->Cells[FirstVisibleCol+2][ARow];
      eResCanal->Text = sgPointsList->Cells[FirstVisibleCol+3][ARow];
      cbConnMain->Checked=(sgPointsList->Cells[FirstVisibleCol+4][ARow]==0);
    //  sgPointsList->Cells[FirstVisibleCol+4][ARow]==0?cbConnMain->Checked=true:cbConnMain->Checked=false;
      cbConnRes->Checked=!cbConnMain->Checked;
      }

   eAPlus->Text      = sgPointsList->Cells[FirstVisibleCol+PlusDopCanal+3][ARow];
   eRPlus->Text      = sgPointsList->Cells[FirstVisibleCol+PlusDopCanal+4][ARow];
   eAMinus->Text     = sgPointsList->Cells[FirstVisibleCol+PlusDopCanal+5][ARow];
   eRMinus->Text     = sgPointsList->Cells[FirstVisibleCol+PlusDopCanal+6][ARow];
   eTag->Text        = sgPointsList->Cells[FirstVisibleCol+PlusDopCanal+7][ARow];
   //GRB CHANGE 21.09.2021 Заплатка размножения пробелов в USD и доп информации
   /*eAddInfo->Text    = sgPointsList->Cells[FirstVisibleCol+PlusDopCanal+8][ARow];
   eUSD->Text        = sgPointsList->Cells[FirstVisibleCol+PlusDopCanal+9][ARow];*/
   //GRB ADD 21.09.2021
         AnsiString saddInfo = sgPointsList->Cells[FirstVisibleCol+PlusDopCanal+8][ARow];
         if (!saddInfo.IsEmpty()){
                if ((saddInfo.AnsiPos(" ") == 1)){
                        eAddInfo->Text  = saddInfo.Delete(1,1);
                }else{
                        eAddInfo->Text = saddInfo;
                }
         }else{
                eAddInfo->Text = saddInfo;
         }
         AnsiString sUSD = sgPointsList->Cells[FirstVisibleCol+PlusDopCanal+9][ARow];
         if (!sUSD.IsEmpty()){
                if (sUSD.AnsiPos(" ") == 1){
                        eUSD->Text  = sUSD.Delete(1,1);
                }else{
                        eUSD->Text = sUSD;
                }
         }else{
         eUSD->Text = sUSD;
         }
   //END ADD

   cbDataAbsence->Checked = (sgPointsList->Cells[FirstVisibleCol+PlusDopCanal+10][ARow]=="1");

   eComm->Text       = sgPointsList->Cells[FirstVisibleCol+PlusDopCanal+11][ARow].Trim();
   eTech->Text       = sgPointsList->Cells[FirstVisibleCol+PlusDopCanal+12][ARow].Trim();

   cbBlockingTime->Checked = (sgPointsList->Cells[FirstVisibleCol+PlusDopCanal+13][ARow]=="1");
   cbTimeZoneW->ItemIndex = sgPointsList->Cells[FirstVisibleCol+PlusDopCanal+14][ARow].IsEmpty()?14:StrToInt(sgPointsList->Cells[FirstVisibleCol+PlusDopCanal+14][ARow])+14;
   cbTimeZoneS->ItemIndex = sgPointsList->Cells[FirstVisibleCol+PlusDopCanal+15][ARow].IsEmpty()?14:StrToInt(sgPointsList->Cells[FirstVisibleCol+PlusDopCanal+15][ARow])+14;
   EditRec = oldEdit;
   CurrRow = ARow;
}
//---------------------------------------------------------------------------
void __fastcall TfmChannelPointsList::SetLabel(int ARow)
{
  int i=0,j=0;
  if(FIdProtocol!=61)
 {
  if(sgPointsList->RowCount>2){
    i=(ARow)?ARow:((sgPointsList->Row>0)?sgPointsList->Row:1);
    j=sgPointsList->RowCount-1;
  }else{
    if(!sgPointsList->Cells[FirstVisibleCol][1].IsEmpty()){
      i=1;
      j=1;
    }
  }
}else{
   if(vtCod->RecordCount>0){
   i=(ARow)?ARow:((vtCod->RecNo>0)?vtCod->RecNo>0:1);
   j=vtCod->RecordCount;
  }
  }
  paInfo->Caption=IntToStr(i)+AnsiString("/")+IntToStr(j);
}
//---------------------------------------------------------------------------
void __fastcall TfmChannelPointsList::eChange(TObject *Sender)
{

   EditRec = true;
   if(!CurrRow)
      return;
   if(Sender==cbBlocking)
      sgPointsList->Cells[2][CurrRow] = cbBlocking->Checked?"1":"0";
   else if(Sender==cbBlockingTime)
      sgPointsList->Cells[PlusDopCanal+14][CurrRow] = cbBlockingTime->Checked?"1":"0";
   else if(Sender==cbDataAbsence)
      sgPointsList->Cells[PlusDopCanal+11][CurrRow] = cbDataAbsence->Checked?"1":"0";
   else if(Sender==eConnNumb)
      sgPointsList->Cells[3][CurrRow] = (eConnNumb->Text.IsEmpty())?AnsiString("0"):eConnNumb->Text;
   else if(Sender==eTag)
      sgPointsList->Cells[PlusDopCanal+8][CurrRow] = eTag->Text;
   else if(Sender==eAPlus)
      sgPointsList->Cells[PlusDopCanal+4][CurrRow] = (eAPlus->Text.IsEmpty())?AnsiString("0"):eAPlus->Text;
   else if(Sender==eRPlus)
      sgPointsList->Cells[PlusDopCanal+5][CurrRow] = (eRPlus->Text.IsEmpty())?AnsiString("0"):eRPlus->Text;
   else if(Sender==eAMinus)
      sgPointsList->Cells[PlusDopCanal+6][CurrRow] = (eAMinus->Text.IsEmpty())?AnsiString("0"):eAMinus->Text;
   else if(Sender==eRMinus)
      sgPointsList->Cells[PlusDopCanal+7][CurrRow] = (eRMinus->Text.IsEmpty())?AnsiString("0"):eRMinus->Text;
   else if(Sender==eAddInfo)
      sgPointsList->Cells[PlusDopCanal+9][CurrRow] = eAddInfo->Text;
   else if(Sender==eComm)
      sgPointsList->Cells[PlusDopCanal+12][CurrRow] = eComm->Text;
   else if(Sender==eTech)
      sgPointsList->Cells[PlusDopCanal+13][CurrRow] = eTech->Text;
   else if(Sender==eImportCode)
      sgPointsList->Cells[3][CurrRow] = eImportCode->Text;
   else if(Sender==eResCanal)
      sgPointsList->Cells[4][CurrRow] = eResCanal->Text;
   else if(Sender==cbTimeZoneW)
      sgPointsList->Cells[PlusDopCanal+15][CurrRow] = cbTimeZoneW->ItemIndex - 14;
   else if(Sender==cbTimeZoneS)
      sgPointsList->Cells[PlusDopCanal+16][CurrRow] = cbTimeZoneS->ItemIndex - 14;
   
   else return;
   sgPointsList->Objects[0][CurrRow] = (TObject*)1;


}
//---------------------------------------------------------------------------
void __fastcall TfmChannelPointsList::sbUSDListClick(TObject *Sender)
{
   TPoint p;
   p.x = 0;
   p.y = sbUSDList->Height;
   p = sbUSDList->ClientToScreen(p);
   TMainForm::getUSDList(pmUSDList,sgPointsList->Cells[0][CurrRow].ToInt(),OnUSDListClick);
   pmUSDList->Popup(p.x,p.y);
}
//---------------------------------------------------------------------------
void __fastcall TfmChannelPointsList::miCapUSDListDrawItem(TObject *Sender,
      TCanvas *ACanvas, TRect &ARect, bool Selected)
{
   TMenuItem*mi = (TMenuItem*)Sender;
   int y = (ARect.Height()-ACanvas->TextHeight("0"))/2;
   ACanvas->Brush->Color = (TColor)RGB(58,110,165);
   ACanvas->FillRect(ARect);
   ACanvas->Font->Color = clWhite;
   ACanvas->TextRect(ARect,2,y,"  "+mi->Caption.SubString(3,1000));
}
//---------------------------------------------------------------------------
void __fastcall TfmChannelPointsList::OnUSDListClick(TObject *Sender)
{
   FindNode(tvPoints, (long)((TMenuItem*)Sender)->Tag, ReadTreeNode, getNodeId);
}
//---------------------------------------------------------------------------
void __fastcall TfmChannelPointsList::aShortCutExecute(TObject *Sender)
{
   if(Sender==aBlocking)
      cbBlocking->Checked = !cbBlocking->Checked;
   else if(Sender==aDataAbsence)
      cbDataAbsence->Checked = !cbDataAbsence->Checked;
}
//---------------------------------------------------------------------------
void __fastcall TfmChannelPointsList::vUpdate(TObject*Sender)
{

  vtCod->AfterScroll=NULL;
   if((Access!=accWrite)&&((TAction*)Sender)->Enabled)
      ((TAction*)Sender)->Enabled = false;
   if(Sender==iaDelete)
      gbEdit->Enabled = ((TAction*)Sender)->Enabled;
  vtCod->AfterScroll=vtCodAfterScroll;
}
//---------------------------------------------------------------------------
void __fastcall TfmChannelPointsList::btTUClick(TObject *Sender)
{
  long Mid = StrToInt(sgPointsList->Cells[FirstVisibleCol-1][sgPointsList->Row]);
  if(Mid){
    TfmPointConditions* f;
    f = new TfmPointConditions(this,Mid, Access);
    f->Caption = Reconst_smes6_16 + sgPointsList->Cells[FirstVisibleCol][sgPointsList->Row];
    f->ShowModal();
    delete f;
  }
}
//---------------------------------------------------------------------------


void __fastcall TfmChannelPointsList::FormShow(TObject *Sender)
{
   if(FIdProtocol==61)
   {
   grPoints->SelectedIndex==0;
   grPoints->SetFocus();
   }
}

//---------------------------------------------------------------------------

void __fastcall TfmChannelPointsList::oqAddParamAfterEdit(
      TDataSet *DataSet)
{
   EditRec = true;
  
}
//---------------------------------------------------------------------------

void __fastcall TfmChannelPointsList::grPointsDragDrop(TObject *Sender,
      TObject *Source, int X, int Y)
{
vtCod->AfterScroll=NULL;
  if(DragData->Type==3){
      if(DragData)
      {
         vtCod->Append();
         vtCod->FieldByName("mid")->AsInteger=DragData->Mid;
         vtCod->FieldByName("name")->AsString=DragData->LongName;
         vtCod->Post();
        // SaveCod();
        ReadAddParam(vtCod->FieldByName("mid")->AsInteger);
       oqAddParam->DisableControls();
       oqAddParam->First();
       while(!oqAddParam->Eof)
       {
        vtCod->Edit();
        if(!oqAddParam->FieldByName("nsort")->IsNull)
        vtCod->FieldByName("Field"+IntToStr((oqAddParam->FieldByName("nsort")->AsInteger*-1)-31))->AsString
                   =oqAddParam->FieldByName("vvalue")->AsString;
       oqAddParam->Next();
       }
        oqAddParam->First();
        oqAddParam->EnableControls();
        EditRec = true;
      }

   }
  iaDelete->Enabled=vtCod->RecordCount>0;
  grCod->Enabled=iaDelete->Enabled;
  EditRec = true;
  vtCod->AfterScroll=vtCodAfterScroll;
  //iaSave->Enabled=true;
}
//---------------------------------------------------------------------------

void __fastcall TfmChannelPointsList::grPointsDragOver(TObject *Sender,
      TObject *Source, int X, int Y, TDragState State, bool &Accept)
{
vtCod->AfterScroll=NULL;
  bool Test=true;
   if(Access==accRead){
      Accept =false;
   }else{
     vtCod->DisableControls();
     vtCod->First();
    while(!vtCod->Eof)
    {
     if(vtCod->FieldByName("mid")->AsInteger==DragData->Mid)
      {
      Test =false;
      break;
      }
      vtCod->Next();
    }
     vtCod->EnableControls();
     Accept=DragData&&Test&&(DragData->Type==3 || DragData->Type==2);
   }
  
 vtCod->AfterScroll=vtCodAfterScroll;
 }

//---------------------------------------------------------------------------



void __fastcall TfmChannelPointsList::oqAddParamAfterPost(
      TDataSet *DataSet)
{
   vtCod->Edit();
   vtCod->FieldByName("Field"+IntToStr((oqAddParam->FieldByName("nsort")->AsInteger*-1)-31))->AsString=
   oqAddParam->FieldByName("vvalue")->AsString;
}
//---------------------------------------------------------------------------
void __fastcall TfmChannelPointsList::cbConnMainClick(TObject *Sender)
{
     EditRec = true;
     cbConnRes->Checked=!cbConnMain->Checked;
     if(!CurrRow)
      return;
     sgPointsList->Cells[5][CurrRow] = cbConnMain->Checked?"0":"1";
}
//---------------------------------------------------------------------------

void __fastcall TfmChannelPointsList::cbConnResClick(TObject *Sender)
{
     EditRec = true;
     cbConnMain->Checked=!cbConnRes->Checked;
     if(!CurrRow)
      return;
     sgPointsList->Cells[5][CurrRow] = cbConnMain->Checked?"0":"1";
}
//---------------------------------------------------------------------------

