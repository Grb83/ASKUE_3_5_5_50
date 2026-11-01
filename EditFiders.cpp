//---------------------------------------------------------------------------
#include <vcl.h>
#include <stdio.h>
#pragma hdrstop

#include  "ASKUETypes.h"
#include "unDataMod.h"
#include "EditFiders.h"
#include "EditCounter.h"
#include "unWorkTime.h"
#include "unCalcParam.h"
#include "selectpoint.h"
#include "ParameterPointsList.h"
#include "LastSave.h"
#include "Monitor.h"
#include "SupperMain.h"
#include "Saa_SelectForm.h"
#include "Saa_SelectGroup.h"
#include "Saa_SelectGroupProc.h"
#include "InteriorExRep.h"
#include "InteriorExOpForm.h"
#include "InputParameters.h"
#include "InputParameters4.h"
#include "PointConditions.h"
#include "TypePart.h"
#include "unSpecParam.h"
#include "unMeterParameter.h"
#include "unEditFormula.h"
#include "unGuid.h"
#include "unKoeff.h"
#include "unPrior.h"
#include "Reconst.hpp"
#include "unViewTree.h"
#include "unitperm.h"
#include "ManualInput.h"
#include "ManualInputMeter.h"
//---------------------------------------------------------------------------
#define max(a, b)  (((a) > (b)) ? (a) : (b))
//---------------------------------------------------------------------------
#pragma link "DBAccess"
#pragma link "MemDS"
#pragma link "Ora"
#pragma resource "*.dfm"
UINT CF_POINTS_TREENODE; // описание формата для буфера обмена
extern HANDLE UpdateMonitors;
extern TSupperMainForm *SupperMainForm;
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::vUpdate(TObject * Sender)
{
    TMainForm::vUpdate(Sender);


    if(customer_id==1||customer_id==51) //Блокируем кое-что из редактирования
    {
        iaNew->Enabled = false;
        iaNewCalcNode->Enabled = false;
        tbNew->Enabled = false;
        mAdd->Enabled = false;
        aInsGroup->Enabled = false;
        iaDelete->Enabled = false;
    }
    ShowAction(iaFind);
}
//---------------------------------------------------------------------------

__fastcall TFormEditFiders::TFormEditFiders(TComponent* Owner, AnsiString Name, TAccess a)
	: TMainForm(Owner, Name, a),editOperation(opNone)//,USDPointDeleted(false)
{
    TFieldDef *pNewDef;
    aInsGroup->OnUpdate = vUpdate;
    aRclcData->Enabled = (Access==accWrite);
    aDelData->Enabled = (Access==accWrite);
    acSampleHours->Enabled = (Access==accWrite);
    acMeterParameter->Enabled = (Access==accWrite);
    accOFF=(dmMain->GetTaskRights(UsCon.Role_Id, 109) == TASK_RIGHTS_WRITE);

     miManualInp->Delete(miManualInp->Count-1);
     miManIn  = new TMenuItem(mMon);

      miManIn->Caption = "Ввод количества энергии";
      miManIn->OnClick = miManualInp->OnClick;
      miManualInp->Add(miManIn);

      miManMetr  = new TMenuItem(mMon);

      miManMetr->Caption = "Ввод показаний";

      miManMetr->OnClick =miManualInp->OnClick;
      miManualInp->Add(miManMetr);

    fmFP=new TfmFindPoint(this);

    VT_Data = new TVirtualTable(this);

    pNewDef = VT_Data->FieldDefs->AddFieldDef();
    pNewDef->Name = "NSOBST";
    pNewDef->DataType = ftFloat;

    pNewDef = VT_Data->FieldDefs->AddFieldDef();
    pNewDef->Name = "VNAME";
    pNewDef->DataType = ftString;
    pNewDef->Size=127;

    pNewDef = VT_Data->FieldDefs->AddFieldDef();
    pNewDef->Name = "NCONNECTIONPARAM";
    pNewDef->DataType = ftFloat;

    pNewDef = VT_Data->FieldDefs->AddFieldDef();
    pNewDef->Name = "MID";
    pNewDef->DataType = ftFloat;

    pNewDef = VT_Data->FieldDefs->AddFieldDef();
    pNewDef->Name = "NSN";
    pNewDef->DataType = ftFloat;

    pNewDef = VT_Data->FieldDefs->AddFieldDef();
    pNewDef->Name = "NSH";
    pNewDef->DataType = ftFloat;

    pNewDef = VT_Data->FieldDefs->AddFieldDef();
    pNewDef->Name = "NDELTAPIDLING";
    pNewDef->DataType = ftFloat;

    pNewDef = VT_Data->FieldDefs->AddFieldDef();
    pNewDef->Name = "NDELTAPSC";
    pNewDef->DataType = ftFloat;

    pNewDef = VT_Data->FieldDefs->AddFieldDef();
    pNewDef->Name = "NIIDLING";
    pNewDef->DataType = ftFloat;

    pNewDef = VT_Data->FieldDefs->AddFieldDef();
    pNewDef->Name = "NUSC";
    pNewDef->DataType = ftFloat;

    pNewDef = VT_Data->FieldDefs->AddFieldDef();
    pNewDef->Name = "NRO";
    pNewDef->DataType = ftFloat;

    pNewDef = VT_Data->FieldDefs->AddFieldDef();
    pNewDef->Name = "NXO";
    pNewDef->DataType = ftFloat;

    pNewDef = VT_Data->FieldDefs->AddFieldDef();
    pNewDef->Name = "NL";
    pNewDef->DataType = ftFloat;

    pNewDef = VT_Data->FieldDefs->AddFieldDef();
    pNewDef->Name = "NUN";
    pNewDef->DataType = ftFloat;

    pNewDef = VT_Data->FieldDefs->AddFieldDef();
    pNewDef->Name = "NWORKINGHOURS";
    pNewDef->DataType = ftFloat;


    pNewDef = VT_Data->FieldDefs->AddFieldDef();
    pNewDef->Name = "NFULLHOURS";
    pNewDef->DataType = ftFloat;

    pNewDef = VT_Data->FieldDefs->AddFieldDef();
    pNewDef->Name = "NENERGYPERCENT";
    pNewDef->DataType = ftFloat;


    pNewDef = VT_Data->FieldDefs->AddFieldDef();
    pNewDef->Name = "NNOTINCLUDECONSUMP";
    pNewDef->DataType = ftFloat;

    pNewDef = VT_Data->FieldDefs->AddFieldDef();
    pNewDef->Name = "NPARALLELCONNECTION";
    pNewDef->DataType = ftFloat;

    pNewDef = VT_Data->FieldDefs->AddFieldDef();
    pNewDef->Name = "NEDITING";
    pNewDef->DataType = ftInteger;

    pNewDef = VT_Data->FieldDefs->AddFieldDef();
    pNewDef->Name = "NTIMEINFO";
    pNewDef->DataType = ftInteger;

    pNewDef = VT_Data->FieldDefs->AddFieldDef();
    pNewDef->Name = "NEDITTIMEINFO";
    pNewDef->DataType = ftInteger;

    pNewDef = VT_Data->FieldDefs->AddFieldDef();
    pNewDef->Name = "NLIST";
    pNewDef->DataType = ftInteger;

    pNewDef = VT_Data->FieldDefs->AddFieldDef();
    pNewDef->Name = "NRENERGYPERCENT";
    pNewDef->DataType = ftFloat;

    pNewDef = VT_Data->FieldDefs->AddFieldDef();
    pNewDef->Name = "NPROCENT";
    pNewDef->DataType = ftFloat;

    pNewDef = VT_Data->FieldDefs->AddFieldDef();
    pNewDef->Name = "LINF";
    pNewDef->DataType = ftString;
    pNewDef->Size=15;

    dsMain->DataSet=VT_Data;
    DBText1->DataField="NCONNECTIONPARAM";
    DBEdit13->DataField="VNAME";
    DBEdit1->DataField="NSN";
    DBEdit15->DataField="NSH";
    DBEdit5->DataField="NDELTAPIDLING";
    DBEdit7->DataField="NDELTAPSC";
    DBEdit8->DataField="NIIDLING";
    DBEdit9->DataField="NUSC";
    DBEdit2->DataField="NRO";
    DBEdit3->DataField="NXO";
    DBEdit4->DataField="NL";
    DBEdit6->DataField="NUN";
    DBEdit10->DataField="NWORKINGHOURS";
    DBEdit11->DataField="NFULLHOURS";
    DBEdit12->DataField="NENERGYPERCENT";
    DBCheckBox1->DataField="NNOTINCLUDECONSUMP";
    DBEdit14->DataField="NRENERGYPERCENT";
    DBCheckBox2->DataField="NPROCENT";
    DBText2->DataField="LINF";

    VT_Data->AfterInsert=TableAfterInsert;
    VT_Data->AfterDelete=TableAfterDelete;
    VT_Data->AfterEdit=TableAfterEdit;
    VT_Data->Open();
    VT_Data->FieldByName("NSOBST")->DisplayLabel=Reconst_smes20_1;
    VT_Data->FieldByName("VNAME")->DisplayLabel=Reconst_smes20_2;
    VT_Data->FieldByName("NCONNECTIONPARAM")->DisplayLabel=Reconst_smes20_3;
    VT_Data->FieldByName("MID")->DisplayLabel=Reconst_smes20_4;
    VT_Data->FieldByName("NSN")->DisplayLabel="Sн";
    VT_Data->FieldByName("NSH")->DisplayLabel="Sh";
    VT_Data->FieldByName("NDELTAPIDLING")->DisplayLabel="Pxx";
    VT_Data->FieldByName("NDELTAPSC")->DisplayLabel="Pкз";
    VT_Data->FieldByName("NIIDLING")->DisplayLabel="Ixx";
    VT_Data->FieldByName("NUSC")->DisplayLabel="Uкз";
    VT_Data->FieldByName("NRO")->DisplayLabel="Ro";
    VT_Data->FieldByName("NXO")->DisplayLabel="Xo";
    VT_Data->FieldByName("NL")->DisplayLabel="L";
    VT_Data->FieldByName("NUN")->DisplayLabel="Un";
    VT_Data->FieldByName("NWORKINGHOURS")->DisplayLabel=Reconst_smes20_5;
    VT_Data->FieldByName("NFULLHOURS")->DisplayLabel=Reconst_smes20_6;
    VT_Data->FieldByName("NENERGYPERCENT")->DisplayLabel=Reconst_smes20_7;
    VT_Data->FieldByName("NNOTINCLUDECONSUMP")->DisplayLabel=Reconst_smes20_8;
    VT_Data->FieldByName("NPARALLELCONNECTION")->DisplayLabel=Reconst_smes20_9;
    VT_Data->FieldByName("NEDITING")->DisplayLabel=Reconst_smes20_10;
    VT_Data->FieldByName("NTIMEINFO")->DisplayLabel=Reconst_smes20_11;
    VT_Data->FieldByName("NEDITTIMEINFO")->DisplayLabel=Reconst_smes20_12;
    VT_Data->FieldByName("NLIST")->DisplayLabel=Reconst_smes20_13;
    VT_Data->FieldByName("NRENERGYPERCENT")->DisplayLabel=Reconst_smes20_14;
    VT_Data->FieldByName("NPROCENT")->DisplayLabel=Reconst_smes20_15;
    VT_Data->FieldByName("LINF")->DisplayLabel=Reconst_smes20_16;
    dmMain->oqCursor->Params->Clear();
    dmMain->oqCursor->SQL->Text="begin "+SchemeName+"editfeeders_pg.RECOMPENS_p(:par1); end;";
    dmMain->oqCursor->ParamByName("par1")->ParamType = ptOutput;
    dmMain->oqCursor->ParamByName("par1")->DataType = ftCursor;
    dmMain->oqCursor->Execute();
    cbCalcR->Items->Clear();
    while(!dmMain->oqCursor->Eof){
      cbCalcR->Items->AddObject(dmMain->oqCursor->FieldByName("vname")->AsString, (TObject *)dmMain->oqCursor->FieldByName("NRECOMPENS")->AsInteger);
      dmMain->oqCursor->Next();
    }
    dmMain->oqCursor->Close();
    SetLossInterface();
    SetCalcInterface();

    dmMain->oqCursor->Params->Clear();
    dmMain->oqCursor->SQL->Text="begin "+SchemeName+"editfeeders_pg.CALCPOINTTYPE_p(:par1); end;";
    dmMain->oqCursor->ParamByName("par1")->ParamType = ptOutput;
    dmMain->oqCursor->ParamByName("par1")->DataType = ftCursor;
    dmMain->oqCursor->Execute();
     cbCalcType->Items->Clear();
    while(!dmMain->oqCursor->Eof){
      cbCalcType->Items->AddObject(dmMain->oqCursor->FieldByName("vname")->AsString, (TObject *)dmMain->oqCursor->FieldByName("NCALCPOINTTYPE")->AsInteger);
      dmMain->oqCursor->Next();
    }
    dmMain->oqCursor->Close();

    dmMain->oqCursor->Params->Clear();
    dmMain->oqCursor->SQL->Text="begin "+SchemeName+"editfeeders_pg.IntegratorTimes_p(:par1); end;";
    dmMain->oqCursor->ParamByName("par1")->ParamType = ptOutput;
    dmMain->oqCursor->ParamByName("par1")->DataType = ftCursor;
    dmMain->oqCursor->Execute();
    cbIntgr->Items->Clear();
    while(!dmMain->oqCursor->Eof){
      cbIntgr->Items->AddObject(dmMain->oqCursor->FieldByName("NINTEGRALPERIOD")->AsString, (TObject *)StrToInt(dmMain->oqCursor->FieldByName("NINTEGRALPERIOD")->AsString));
      dmMain->oqCursor->Next();
    }
    dmMain->oqCursor->Close();
    if(cbIntgr->Items->Count)
      cbIntgr->ItemIndex=0;

    //Временная зона Украины
    dmMain->quMain->Params->Clear();
    dmMain->quMain->SQL->Text=" begin :par1:= "+SchemeName+"COMSRV_PG.get_systemtz; :par2:= "+SchemeName+"COMSRV_PG.get_systemtz_summer; end;";
    dmMain->quMain->ParamByName("par1")->DataType=ftInteger;
    dmMain->quMain->ParamByName("par1")->ParamType=ptOutput;
    dmMain->quMain->ParamByName("par2")->DataType=ftInteger;
    dmMain->quMain->ParamByName("par2")->ParamType=ptOutput;
    dmMain->quMain->Execute();
    TimeZoneUkrW=dmMain->quMain->ParamByName("par1")->AsInteger;
    TimeZoneUkrS=dmMain->quMain->ParamByName("par2")->AsInteger;


    oqGetAcc->ParamByName("par1")->AsInteger=UsCon.Role_Id;
    oqGetAcc->Execute();
     while(!oqGetAcc->Eof){
      if(oqGetAcc->FieldByName("task_cod")->AsInteger==603)miManIn->Tag=oqGetAcc->FieldByName("nacc")->AsInteger;
      if(oqGetAcc->FieldByName("task_cod")->AsInteger==608) miManMetr->Tag=oqGetAcc->FieldByName("nacc")->AsInteger;
     oqGetAcc->Next();
     }


     // регистрация формата для буфера обмена
    CF_POINTS_TREENODE = RegisterClipboardFormat("CF_POINTS_TREENODE");
    if(!CF_POINTS_TREENODE)
    {
        char mess[1025];
        LPVOID lpMsgBuf;
        FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_SYSTEM,
            NULL, GetLastError(),
            MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT), // Default language
            (LPTSTR) &lpMsgBuf,  0,  NULL);
        strncpy(mess, (char*)lpMsgBuf, 1024);
        LocalFree(lpMsgBuf);
        throw Exception(mess);
    }
    pcMain->ActivePage  = tsParam;
    //GRB ADD 29.05.2019
    RadioGroup1->ItemIndex = 0; //Торговая зона
    try{
    globalCompanyInfo = getCompanyInfoGlobal(this, &tradeZonesGlobalList);
    changePanel31Height(1);
    }catch (Exception &ex){
    tradeZonesGlobalList = new TStringList();
    }
}
//---------------------------------------------------------------------------

__fastcall TFormEditFiders::~TFormEditFiders()
{
  try{
  delete fmFP;
  //GRB ADD 18.07.2019
  fmFP = NULL; // на всяк случай ну как поможет от ExcessViolation
  //GRB
  if(Clipboard()->HasFormat(CF_POINTS_TREENODE))
    Clipboard()->Clear();
    }catch (Exception &ex){
    delete fmFP;
    fmFP = NULL; // на всяк случай ну как поможет от ExcessViolation
    MessageBox(Handle,"Валимся в TFormEditFiders::~TFormEditFiders(). Закройте и откройте 2 раза по крестику текущую задачу",
            "Память не удаляется",MB_OK|MB_ICONINFORMATION);
    }
}
//---------------------------------------------------------------------------

void __fastcall TFormEditFiders::FormShow(TObject *Sender)
{
    if(ReadTreeNode(NULL)){
        if(TreeView1->Items->Count){
            TreeView1->OnChange=TreeView1Change;
            TreeView1->OnChanging = TreeView1Changing;
            TreeView1->Selected=TreeView1->Items->Item[0];
        }
        Width=Width-1;
        Height=Height-1;
        TreeView1->SetFocus();
    }else{
        Close();
    }
    if(customer_id==1||customer_id==51) //Блокируем кое-что из редактирования
    {
        TreeView1->DragMode = dmManual;
        TreeView1->OnDragDrop = NULL;
        TreeView1->OnDragOver = NULL;
        TreeView1->OnStartDrag = NULL;
        TreeView1->OnKeyDown = NULL;

        Edit1->ReadOnly = true;
        Edit2->ReadOnly = true;
        Edit22->ReadOnly = true;
        Edit23->ReadOnly = true;

        CheckBox1->Enabled = false;
        CheckBox2->Enabled = false;
        sbUSDList->Enabled = false;
        Edit8->ReadOnly = true;
        Edit9->ReadOnly = true;
        Edit10->ReadOnly = true;
        Edit11->ReadOnly = true;
        Edit14->ReadOnly = true;
        Edit15->ReadOnly = true;

        sbKC->Enabled = false;
        sbKMeter->Enabled = false;
        Edit15->Width=90;
        Edit16->Width=90;

        iaNew->Enabled = false;
        iaNewCalcNode->Enabled = false;
        tbNew->Enabled = false;
        mAdd->Enabled = false;
        aInsGroup->Enabled = false;
        iaDelete->Enabled = false;
        aInsGroup->OnUpdate = vUpdate;
        iaNew->OnUpdate = vUpdate;
        iaNewCalcNode->OnUpdate = vUpdate;
        aLastSave->OnUpdate = vUpdate;

        btSetTimeP->Visible = true;
        Label19->Visible=btSetTimeP->Visible;
        Label20->Visible=btSetTimeP->Visible;
        DBEdit10->Visible=btSetTimeP->Visible;
        DBEdit11->Visible=btSetTimeP->Visible;
        DBCheckBox1->Top=247;

        mAdd->OnClick = NULL;
        mDelete->OnClick = NULL;
        mDelete->Visible=false;
        mAdd->Visible=false;

        cbLossType->Enabled=false;
        edTw->ReadOnly=true;
        edTf->ReadOnly=true;
        cbCalcR->Enabled=false;
        //cbCalcType->Enabled=false;
        DBEdit13->ReadOnly=true;
        DBEdit1->ReadOnly=true;
        DBEdit2->ReadOnly=true;
        DBEdit3->ReadOnly=true;
        DBEdit4->ReadOnly=true;
        DBEdit5->ReadOnly=true;
        DBEdit6->ReadOnly=true;
        DBEdit7->ReadOnly=true;
        DBEdit8->ReadOnly=true;
        DBEdit9->ReadOnly=true;
        DBEdit10->ReadOnly=true;
        DBEdit11->ReadOnly=true;
        DBEdit12->ReadOnly=true;
        DBEdit13->ReadOnly=true;
        DBEdit14->ReadOnly=true;
        DBEdit15->ReadOnly=true;
        DBCheckBox1->Enabled=false;
        btAddParam->Enabled=false;
        edLineLoss->ReadOnly=true;
        edATrLoss->ReadOnly=true;
        edRTrLoss->ReadOnly=true;

        // Add by KSS
        AnsiString tmp = HeaderControl1->Sections->Items[0]->Text;
        HeaderControl1->Sections->Items[0]->Text = HeaderControl1->Sections->Items[2]->Text;
        HeaderControl1->Sections->Items[2]->Text = tmp;
        tmp = HeaderControl1->Sections->Items[1]->Text;
        HeaderControl1->Sections->Items[1]->Text = HeaderControl1->Sections->Items[3]->Text;
        HeaderControl1->Sections->Items[3]->Text = tmp;
        // end add
    }
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::TreeView1Expanding(TObject *Sender,
    TTreeNode *Node, bool &AllowExpansion)
{
    if(Node&&Node->getFirstChild()&&!Node->getFirstChild()->Data)
        ReadTreeNode(Node);
}
//---------------------------------------------------------------------------
// Читает ветку дерева
bool __fastcall TFormEditFiders::ReadTreeNode(TObject*obj)
{
  TTreeNode*NodeParent=dynamic_cast<TTreeNode*>(obj);
  POINTSDIV *PTreeTable;
  TTreeNode *AddNode;
  try{
    TreeView1->Items->BeginUpdate();
        // вычитка перечня точек
    if(NodeParent && NodeParent->HasChildren)
      NodeParent->DeleteChildren();
    dmMain->oqCursor->Params->Clear();
    dmMain->oqCursor->SQL->Text="begin "+SchemeName+"editfeeders_pg.readnode_p(:par1,:par2,:par3); end;";
    dmMain->oqCursor->ParamByName("par3")->ParamType = ptOutput;
    dmMain->oqCursor->ParamByName("par3")->DataType = ftCursor;
    if(NodeParent){
     dmMain->oqCursor->ParamByName("par1")->AsInteger=((POINTSDIV*)NodeParent->Data)->Mid;
     dmMain->oqCursor->ParamByName("par2")->AsInteger=1;
    }else{
      CountPoints_Del=0;
      dmMain->oqCursor->ParamByName("par1")->Clear();
      dmMain->oqCursor->ParamByName("par2")->Clear();
   }
    dmMain->oqCursor->Execute();
    try{
    while(!dmMain->oqCursor->Eof){
      PTreeTable=new POINTSDIV;
      PTreeTable->editing=dmMain->oqCursor->FieldByName("HaveChild")->AsInteger;
      PTreeTable->Mid=dmMain->oqCursor->FieldByName("mid")->AsInteger;
      PTreeTable->Type=dmMain->oqCursor->FieldByName("Type")->AsInteger;
      strcpy(PTreeTable->Name,dmMain->oqCursor->FieldByName("name")->AsString.c_str());
      strcpy(PTreeTable->Short_Name,dmMain->oqCursor->FieldByName("short_name")->AsString.c_str());
      PTreeTable->ER_POSITION =dmMain->oqCursor->FieldByName("ER_POSITION")->AsInteger;
      PTreeTable->Q1_POSITION =dmMain->oqCursor->FieldByName("Q1_POSITION")->AsInteger;
      PTreeTable->ED_POSITION =dmMain->oqCursor->FieldByName("ED_POSITION")->AsInteger;
      PTreeTable->Q3_POSITION =dmMain->oqCursor->FieldByName("Q3_POSITION")->AsInteger;
      PTreeTable->SMART =dmMain->oqCursor->FieldByName("SMART")->AsInteger;
      PTreeTable->Q1234 =dmMain->oqCursor->FieldByName("Q")->AsInteger;
      PTreeTable->CANAL =dmMain->oqCursor->FieldByName("CANAL")->AsInteger;
      strcpy(PTreeTable->CELLNUM,dmMain->oqCursor->FieldByName("CELLNUM")->AsString.c_str());
      PTreeTable->POWER1 =dmMain->oqCursor->FieldByName("POWER")->AsFloat;
      PTreeTable->POWER2 =dmMain->oqCursor->FieldByName("POWER2")->AsFloat;
      PTreeTable->CURRENT1 =dmMain->oqCursor->FieldByName("CURRENT1")->AsFloat;
      PTreeTable->CURRENT2 =dmMain->oqCursor->FieldByName("CURRENT2")->AsFloat;
      PTreeTable->KC =dmMain->oqCursor->FieldByName("KC")->AsFloat;
      PTreeTable->MeterKC =dmMain->oqCursor->FieldByName("METKC")->AsFloat;
      PTreeTable->lOFF =dmMain->oqCursor->FieldByName("NOFF")->AsInteger;
      strcpy(PTreeTable->vOFF,dmMain->oqCursor->FieldByName("DOFF")->AsDateTime.FormatString("dd.mm.yyyy hh:nn:ss").c_str());
      if(!dmMain->oqCursor->FieldByName("tag")->IsNull)
        PTreeTable->Tag =dmMain->oqCursor->FieldByName("tag")->AsInteger;
      else
        PTreeTable->indic[0]=-1;
      strcpy(PTreeTable->v_info,dmMain->oqCursor->FieldByName("vinfo")->AsString.c_str());
      PTreeTable->nabs = dmMain->oqCursor->FieldByName("nabc")->AsInteger;
      PTreeTable->ncalcbill = dmMain->oqCursor->FieldByName("ncalcbill")->AsInteger;
      PTreeTable->ncalcmonth = dmMain->oqCursor->FieldByName("ncalcmonths")->AsInteger;
      PTreeTable->ninverted = dmMain->oqCursor->FieldByName("ninverted")->AsInteger;
      PTreeTable->nswitch = dmMain->oqCursor->FieldByName("nswitch")->AsInteger;
      PTreeTable->NLockSwitch = dmMain->oqCursor->FieldByName("nlockswitch")->AsInteger;
      PTreeTable->nDataWithOB = dmMain->oqCursor->FieldByName("NWITHSWITCH")->AsInteger;
 //<----
      PTreeTable->nlosstype = dmMain->oqCursor->FieldByName("NWASTEPERCENTCALC")->AsInteger;
      //GRB ADD 14.06.2019
      if ((PTreeTable->Type==2)||(PTreeTable->Type==4)){
        PTreeTable->eic_info.vfullname = dmMain->oqCursor->FieldByName("name")->AsString;
        PTreeTable->eic_info.vshortname = dmMain->oqCursor->FieldByName("short_name")->AsString;
        PTreeTable->eic_info.mms = dmMain->oqCursor->FieldByName("mms")->AsString;
        PTreeTable->eic_info.c_type = dmMain->oqCursor->FieldByName("ctype")->AsString;
        PTreeTable->eic_info.veic_code = dmMain->oqCursor->FieldByName("eic")->AsString;
        AnsiString isEic = dmMain->oqCursor->FieldByName("mms")->AsString;
        if (CompareStr (isEic,"*")==0){
        AnsiString ictype = dmMain->oqCursor->FieldByName("ctype")->AsString;
        int in_ctype = 0;
        try{
        in_ctype = StrToInt (ictype);
        } catch (Exception &ex){
         ictype = "";
        }
        }

      }else{ //не 2 и не 4 тип
         PTreeTable->eic_info.vfullname = dmMain->oqCursor->FieldByName("name")->AsString;
         PTreeTable->eic_info.vshortname = dmMain->oqCursor->FieldByName("short_name")->AsString;
         PTreeTable->eic_info.mms="";
         PTreeTable->eic_info.veic_code="";
         PTreeTable->eic_info.c_type = "";
      }
      //END ADD
      if(!dmMain->oqCursor->FieldByName("NWORKINGHOURS")->IsNull)
        PTreeTable->nwh =dmMain->oqCursor->FieldByName("NWORKINGHOURS")->AsFloat;
      else
        PTreeTable->indic[1]=-1;
      if(!dmMain->oqCursor->FieldByName("NFULLHOURS")->IsNull)
        PTreeTable->nfh = dmMain->oqCursor->FieldByName("NFULLHOURS")->AsFloat;
      else
        PTreeTable->indic[2]=-1;
      if(!dmMain->oqCursor->FieldByName("LINE_LOSS")->IsNull)
        PTreeTable->nlineloss =dmMain->oqCursor->FieldByName("LINE_LOSS")->AsFloat;
      else
        PTreeTable->indic[3]=-1;
      if(!dmMain->oqCursor->FieldByName("ACT_LOSS")->IsNull)
        PTreeTable->ntraloss =dmMain->oqCursor->FieldByName("ACT_LOSS")->AsFloat;
      else
        PTreeTable->indic[4]=-1;
      if(!dmMain->oqCursor->FieldByName("REACT_LOSS")->IsNull)
        PTreeTable->ntrrloss =dmMain->oqCursor->FieldByName("REACT_LOSS")->AsFloat;
      else
        PTreeTable->indic[5]=-1;
      PTreeTable->nrecompens =dmMain->oqCursor->FieldByName("nrecompens")->AsInteger;
      PTreeTable->USDMid =dmMain->oqCursor->FieldByName("USDMid")->AsInteger;
      strcpy(PTreeTable->USDText,dmMain->oqCursor->FieldByName("USDText")->AsString.c_str());
      PTreeTable->nblock =dmMain->oqCursor->FieldByName("nblock")->AsInteger;
      PTreeTable->ncalcpointtype =dmMain->oqCursor->FieldByName("NCALCPOINTTYPE")->AsInteger;
      if(!dmMain->oqCursor->FieldByName("NCURRPOWER")->IsNull)
        PTreeTable->ncurrpower =dmMain->oqCursor->FieldByName("NCURRPOWER")->AsFloat;
      else
        PTreeTable->indic[6]=-1;
      if(!dmMain->oqCursor->FieldByName("NMONTHCONSUMPT")->IsNull)
        PTreeTable->nmonthconsumpt =dmMain->oqCursor->FieldByName("NMONTHCONSUMPT")->AsFloat;
      else
        PTreeTable->indic[7]=-1;
      PTreeTable->DataAbsence =dmMain->oqCursor->FieldByName("DATAABS")->AsInteger;
      PTreeTable->CommControl =dmMain->oqCursor->FieldByName("COMMCONTR")->AsInteger;
      PTreeTable->TechControl =dmMain->oqCursor->FieldByName("TECHCONTR")->AsInteger;
      PTreeTable->nMainPoint =dmMain->oqCursor->FieldByName("mainmid")->AsInteger;
      strcpy(PTreeTable->MainText,dmMain->oqCursor->FieldByName("MainText")->AsString.c_str());
      PTreeTable->OppositeMid =dmMain->oqCursor->FieldByName("OppositeMid")->AsInteger;
      strcpy(PTreeTable->Opposite,dmMain->oqCursor->FieldByName("Opposite")->AsString.c_str());
      strcpy(PTreeTable->verifyParam,dmMain->oqCursor->FieldByName("verifyParam")->AsString.c_str());
      strcpy(PTreeTable->AddParams,dmMain->oqCursor->FieldByName("vaddParams")->AsString.c_str());
      strcpy(PTreeTable->ImportCode,dmMain->oqCursor->FieldByName("VIMPORTCODE")->AsString.c_str());
      PTreeTable->nblocktime =dmMain->oqCursor->FieldByName("NLOCKCORRECTTIME")->AsInteger;
      strcpy(PTreeTable->vCode,dmMain->oqCursor->FieldByName("VCODE")->AsString.c_str());
      strcpy(PTreeTable->vaccount,dmMain->oqCursor->FieldByName("VACCOUNT")->AsString.c_str());
      strcpy(PTreeTable->verifyDay,dmMain->oqCursor->FieldByName("verifyDay")->AsString.c_str());
      PTreeTable->classTN =dmMain->oqCursor->FieldByName("NCLASSTN")->AsFloat;
      PTreeTable->classTT =dmMain->oqCursor->FieldByName("NCLASSTT")->AsFloat;
      PTreeTable->ntimezonew = dmMain->oqCursor->FieldByName("NTIMEZONEW")->AsInteger;
      PTreeTable->ntimezones = dmMain->oqCursor->FieldByName("NTIMEZONES")->AsInteger;
      PTreeTable->norder = dmMain->oqCursor->FieldByName("norder")->AsInteger;
      strcpy(PTreeTable->formula,dmMain->oqCursor->FieldByName("formula")->AsString.c_str());
      strcpy(PTreeTable->vsource,dmMain->oqCursor->FieldByName("vsource")->AsString.c_str());
      repl_delimiters(PTreeTable->USDText, " ");
      repl_delimiters(PTreeTable->MainText, " ");
      repl_delimiters(PTreeTable->Opposite, " ");
      PTreeTable->indCommControl = (dmMain->oqCursor->FieldByName("COMMCONTR")->IsNull)?-1:0;
      PTreeTable->indTechControl = (dmMain->oqCursor->FieldByName("TECHCONTR")->IsNull)?-1:0;
      PTreeTable->integr=dmMain->oqCursor->FieldByName("NINTEGRALPERIOD")->AsInteger;
      PTreeTable->rescanal=dmMain->oqCursor->FieldByName("rescanal")->AsInteger;
      strcpy(PTreeTable->vnote,dmMain->oqCursor->FieldByName("vnote")->AsString.c_str());

      AddNode = TreeView1->Items->AddChildObject(NodeParent,PTreeTable->Name,PTreeTable);
      AddNode->ImageIndex =(PTreeTable->Type<=2)?4:(PTreeTable->ncalcpointtype>0)? 27:(PTreeTable->Type==4)?26:0;
      AddNode->SelectedIndex=(PTreeTable->Type<=2)?4:(PTreeTable->ncalcpointtype>0)? 27:(PTreeTable->Type==4)?26:0;

      if(PTreeTable->editing){
        TreeView1->Items->AddChildObject(AddNode,"",(void*)0);
        PTreeTable->editing=0;
      }
      PTreeTable->tmpMid=PTreeTable->Mid;
      PTreeTable->pcounter = new TList;
      PTreeTable->pcounter->Capacity = PTreeTable->pcounter->Count;
      PTreeTable->ploss = new TList;
      PTreeTable->ploss->Capacity = PTreeTable->ploss->Count;
      dmMain->oqCursor->Next();
    }
    }catch (EAccessViolation &eav){
         delete PTreeTable;
         MessageBox(Handle,"Не хватает памяти для работы с деревом(Валится в ReadTreeNode). Закройте и откройте 2 раза по крестику текущую задачу",
            "Память не выделяется",MB_OK|MB_ICONINFORMATION);
    }
    if(NodeParent){
      AddNode = NodeParent->getFirstChild(); // *****************Вычитка счётчиков
      if(!AddNode || AddNode->Parent!=NodeParent)
        throw Exception(Reconst_smes20_17+IntToStr(((POINTSDIV*)NodeParent->Data)->Mid));
      PTreeTable = (POINTSDIV*)AddNode->Data;
      dmMain->oqCursor->Params->Clear();
     dmMain->oqCursor->SQL->Text="begin "+SchemeName+"editfeeders_pg.readcounter_p(:par1,:par2); end;";
     dmMain->oqCursor->ParamByName("par2")->ParamType = ptOutput;
     dmMain->oqCursor->ParamByName("par2")->DataType = ftCursor;
     // dmMain->quMain->SQL->Text=sqlCounters;
      dmMain->oqCursor->ParamByName("par1")->AsInteger=((POINTSDIV*)NodeParent->Data)->Mid;
      dmMain->oqCursor->Execute();
      while(!dmMain->oqCursor->Eof){
        while(PTreeTable->Mid != dmMain->oqCursor->FieldByName("mid")->AsInteger){
          AddNode = NodeParent->GetNextChild(AddNode);
          if(!AddNode || AddNode->Parent!=NodeParent)
            throw Exception(Reconst_smes20_17+IntToStr(((POINTSDIV*)NodeParent->Data)->Mid));
          PTreeTable = (POINTSDIV*)AddNode->Data;
        }
        TFormCounter::POINTCOUNT *PCountTable=new TFormCounter::POINTCOUNT();
        PCountTable->mid=dmMain->oqCursor->FieldByName("mid")->AsInteger;
        strcpy(PCountTable->Name,dmMain->oqCursor->FieldByName("NAME")->AsString.c_str());
        strcpy(PCountTable->MTRSN,dmMain->oqCursor->FieldByName("MTRSN")->AsString.c_str());
        PCountTable->Entype=dmMain->oqCursor->FieldByName("ENTYPE")->AsInteger;
        strcpy(PCountTable->date_count,dmMain->oqCursor->FieldByName("date_count")->AsString.c_str());
        strcpy(PCountTable->DIGITS,dmMain->oqCursor->FieldByName("DIGITS")->AsString.c_str());
        strcpy(PCountTable->MTYPE,dmMain->oqCursor->FieldByName("MTYPE")->AsString.c_str());
        PCountTable->MCURRENT=dmMain->oqCursor->FieldByName("MCURRENT")->AsFloat;
        PCountTable->MPOWER=dmMain->oqCursor->FieldByName("MPOWER")->AsInteger;
        PCountTable->MCONST=dmMain->oqCursor->FieldByName("MCONST")->AsInteger;
        PCountTable->MCLASS=dmMain->oqCursor->FieldByName("MCLASS")->AsFloat;
        PCountTable->MYEAR=dmMain->oqCursor->FieldByName("MYEAR")->AsInteger;
        PCountTable->MQUARTER=dmMain->oqCursor->FieldByName("MQUARTER")->AsInteger;
        PCountTable->Position=dmMain->oqCursor->FieldByName("POSITION")->AsInteger;
        PTreeTable->pcounter->Capacity = PTreeTable->pcounter->Count;
        PTreeTable->pcounter->Add(PCountTable);
        dmMain->oqCursor->Next();
      }
      PTreeTable->pcounter->Capacity = PTreeTable->pcounter->Count;

      AddNode = NodeParent->getFirstChild(); // **************Вычитка Потерь
      if(!AddNode || AddNode->Parent!=NodeParent)
        throw Exception(Reconst_smes20_18);
      PTreeTable = (POINTSDIV*)AddNode->Data;
    //  dmMain->quMain->SQL->Text=sqlLossts;
      dmMain->oqCursor->Params->Clear();
      dmMain->oqCursor->SQL->Text="begin "+SchemeName+"editfeeders_pg.readlossts_p(:par1,:par2); end;";
      dmMain->oqCursor->ParamByName("par2")->ParamType = ptOutput;
      dmMain->oqCursor->ParamByName("par2")->DataType = ftCursor;
      dmMain->oqCursor->ParamByName("par1")->AsInteger=((POINTSDIV*)NodeParent->Data)->Mid;
      dmMain->oqCursor->Execute();
      while(!dmMain->oqCursor->Eof){
        bool  fFind = true;   //===== Признак найденной точки
        AddNode     = NodeParent->getFirstChild();    //===== Позиционирование на первую точку
        PTreeTable  = (POINTSDIV *)AddNode->Data;
        //===== Перебор всех точек для нахождения нужной
        while (PTreeTable->Mid != dmMain->oqCursor->FieldByName("MID")->AsInteger && fFind){
          PTreeTable->ploss->Capacity = PTreeTable->ploss->Count;
          AddNode = NodeParent->GetNextChild(AddNode);
          if (!AddNode || AddNode->Parent != NodeParent)
            fFind = false;
          else
            PTreeTable  = (POINTSDIV*)AddNode->Data;
        }
        if (!fFind){
          dmMain->oqCursor->Next();
          continue;
        }
        if (!PTreeTable->ploss)
          PTreeTable->ploss = new TList;
        POINTLOSS *PLossTable = new POINTLOSS;
        PLossTable->nsobst=dmMain->oqCursor->FieldByName("nsobst")->AsInteger;
        PLossTable->nconnectionparam=dmMain->oqCursor->FieldByName("NCONNECTIONPARAM")->AsInteger;
        PLossTable->mid=dmMain->oqCursor->FieldByName("MID")->AsInteger;
        if(!dmMain->oqCursor->FieldByName("VNAME")->IsNull)
          strcpy(PLossTable->vname,dmMain->oqCursor->FieldByName("VNAME")->AsString.c_str());
        else
          PLossTable->indic[0]=-1;
        if(!dmMain->oqCursor->FieldByName("NSN")->IsNull)
          PLossTable->nsn=dmMain->oqCursor->FieldByName("NSN")->AsFloat;
        else
          PLossTable->indic[1]=-1;
        if(!dmMain->oqCursor->FieldByName("NSH")->IsNull)
          PLossTable->nsh=dmMain->oqCursor->FieldByName("NSH")->AsFloat;
        else
          PLossTable->indic[2]=-1;
        if(!dmMain->oqCursor->FieldByName("NDELTAPIDLING")->IsNull)
          PLossTable->ndeltapidling=dmMain->oqCursor->FieldByName("NDELTAPIDLING")->AsFloat;
        else
          PLossTable->indic[3]=-1;
        if(!dmMain->oqCursor->FieldByName("NDELTAPSC")->IsNull)
          PLossTable->ndeltapsc=dmMain->oqCursor->FieldByName("NDELTAPSC")->AsFloat;
        else
          PLossTable->indic[4]=-1;
        if(!dmMain->oqCursor->FieldByName("NIIDLING")->IsNull)
          PLossTable->niidling=dmMain->oqCursor->FieldByName("NIIDLING")->AsFloat;
        else
          PLossTable->indic[5]=-1;
        if(!dmMain->oqCursor->FieldByName("NUSC")->IsNull)
          PLossTable->nusc=dmMain->oqCursor->FieldByName("NUSC")->AsFloat;
        else
          PLossTable->indic[6]=-1;
        if(!dmMain->oqCursor->FieldByName("NRO")->IsNull)
          PLossTable->nro=dmMain->oqCursor->FieldByName("NRO")->AsFloat;
        else
          PLossTable->indic[7]=-1;
        if(!dmMain->oqCursor->FieldByName("NXO")->IsNull)
          PLossTable->nxo=dmMain->oqCursor->FieldByName("NXO")->AsFloat;
        else
          PLossTable->indic[8]=-1;
        if(!dmMain->oqCursor->FieldByName("NL")->IsNull)
          PLossTable->nl=dmMain->oqCursor->FieldByName("NL")->AsFloat;
        else
          PLossTable->indic[9]=-1;
        if(!dmMain->oqCursor->FieldByName("NUN")->IsNull)
          PLossTable->nun=dmMain->oqCursor->FieldByName("NUN")->AsFloat;
        else
          PLossTable->indic[10]=-1;
        if(!dmMain->oqCursor->FieldByName("NENERGYPERCENT")->IsNull)
          PLossTable->nenergypercent=dmMain->oqCursor->FieldByName("NENERGYPERCENT")->AsFloat;
        else
          PLossTable->indic[11]=-1;
        if(!dmMain->oqCursor->FieldByName("NWORKINGHOURS")->IsNull)
          PLossTable->nworkinghours=dmMain->oqCursor->FieldByName("NWORKINGHOURS")->AsInteger;
        else
          PLossTable->indic[12]=-1;
        if(!dmMain->oqCursor->FieldByName("NFULLHOURS")->IsNull)
          PLossTable->nfullhours=dmMain->oqCursor->FieldByName("NFULLHOURS")->AsInteger;
        else
          PLossTable->indic[13]=-1;
        PLossTable->nnotincludeconsump=dmMain->oqCursor->FieldByName("NNOTINCLUDECONSUMP")->AsInteger;
        if(!dmMain->oqCursor->FieldByName("NPARALLELCONNECTION")->IsNull)
          PLossTable->nparallelconnection=dmMain->oqCursor->FieldByName("NPARALLELCONNECTION")->AsInteger;
        else
          PLossTable->indic[14]=-1;
        if(!dmMain->oqCursor->FieldByName("NRENERGYPERCENT")->IsNull)
          PLossTable->nrenergypercent=dmMain->oqCursor->FieldByName("NRENERGYPERCENT")->AsInteger;
        else
          PLossTable->indic[15]=-1;
        PLossTable->nprocent=dmMain->oqCursor->FieldByName("NPROCENT")->AsInteger;
        strcpy(PLossTable->linf,dmMain->oqCursor->FieldByName("linf")->AsString.c_str());
        PLossTable->pMid=dmMain->oqCursor->FieldByName("mid")->AsInteger;
        PLossTable->tmpnconnectionparam = PLossTable->nconnectionparam;
        PTreeTable->ploss->Add(PLossTable);
        PTreeTable->ploss->Capacity = PTreeTable->ploss->Count;
        dmMain->oqCursor->Next();
      }
      //-----------------------------------VNB 12.03.2008
      AddNode = NodeParent->getFirstChild(); // **************Вычитка групп
      if(!AddNode || AddNode->Parent!=NodeParent)
        throw Exception(Reconst_smes20_18);
      PTreeTable = (POINTSDIV*)AddNode->Data;
     // dmMain->quMain->SQL->Text=sqlGroup;
      dmMain->oqCursor->Params->Clear();
      dmMain->oqCursor->SQL->Text="begin "+SchemeName+"editfeeders_pg.readGroup_p(:par1,:par2); end;";
      dmMain->oqCursor->ParamByName("par2")->ParamType = ptOutput;
      dmMain->oqCursor->ParamByName("par2")->DataType = ftCursor;
      dmMain->oqCursor->ParamByName("par1")->AsInteger=((POINTSDIV*)NodeParent->Data)->Mid;
      dmMain->oqCursor->Execute();
      while(!dmMain->oqCursor->Eof){
         bool  gFind = true;   //===== Признак найденной точки
        AddNode     = NodeParent->getFirstChild();    //===== Позиционирование на первую точку
        PTreeTable  = (POINTSDIV *)AddNode->Data;
        //===== Перебор всех точек для нахождения нужной
        while (PTreeTable->Mid != dmMain->oqCursor->FieldByName("mid")->AsInteger && gFind){
          AddNode = NodeParent->GetNextChild(AddNode);
          if (!AddNode || AddNode->Parent != NodeParent)
            gFind = false;
          else
            PTreeTable  = (POINTSDIV*)AddNode->Data;
        }
        if (!gFind){
          dmMain->oqCursor->Next();
          continue;
        }

         if(!dmMain->oqCursor->FieldByName("gid")->IsNull)
         PTreeTable->Group= dmMain->oqCursor->FieldByName("gid")->AsInteger;
         if(!dmMain->oqCursor->FieldByName("name")->IsNull)
         strcpy(PTreeTable->GroupText,dmMain->oqCursor->FieldByName("name")->AsString.c_str());

         dmMain->oqCursor->Next();
         }
      //---------------------------------------------------
    }
  }catch (Exception &exception){
    TreeView1->Items->EndUpdate();
    Application->ShowException(&exception);
    return false;
  }
  TreeView1->Items->EndUpdate();
  return true;
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::TreeView1Changing(TObject *Sender,
      TTreeNode *Node, bool &AllowChange)
{
    TTreeNode *sNode=TreeView1->Selected;
    if(!sNode||!sNode->Data||((POINTSDIV*)sNode->Data)->editing!=2||((POINTSDIV*)sNode->Data)->Type==1)
        return;
    POINTSDIV *PTreeTable=(POINTSDIV*)sNode->Data;
  TTabSheet* ActivePage;
   PTreeTable->Type!=4? ActivePage=tsParam:ActivePage=tsMainSpec;


    TWinControl *Control=NULL;
    try{
      if(PTreeTable->Type!=4){
      //17.08.2021 - GRB CHANGE - REMOVE BLOCK
        /*strcpy(PTreeTable->Name,Edit1->Text.c_str());
        strcpy(PTreeTable->Short_Name,Edit2->Text.c_str());
        strcpy(PTreeTable->vsource,lSource2->Caption.c_str());*/
        //END REMOVE

        //BLOCK NEW
         strncpy(PTreeTable->Name, Edit1->Text.c_str(),sizeof(PTreeTable->Name) - 1);
         PTreeTable->Name[sizeof(PTreeTable->Name) - 1] = '\0';

         strncpy(PTreeTable->Short_Name, Edit2->Text.c_str(), sizeof (PTreeTable->Short_Name)-1);
         PTreeTable->Short_Name[sizeof(PTreeTable->Short_Name)-1] = '\0';

         strncpy (PTreeTable->vsource, lSource2->Caption.c_str(), sizeof(PTreeTable->vsource)-1);
         PTreeTable->vsource[sizeof(PTreeTable->vsource)-1] = '\0';
        //END BLOCK
         }
        if(PTreeTable->Type==3){
            Control=(TWinControl *)Edit3;
            PTreeTable->ER_POSITION=(Edit3->Text.IsEmpty())?0:Edit3->Text.ToInt();

            Control=(TWinControl *)Edit4;
            PTreeTable->Q1_POSITION=(Edit4->Text.IsEmpty())?0:Edit4->Text.ToInt();

            Control=(TWinControl *)Edit5;
            PTreeTable->ED_POSITION=(Edit5->Text.IsEmpty())?0:Edit5->Text.ToInt();

            Control=(TWinControl *)Edit6;
            PTreeTable->Q3_POSITION=(Edit6->Text.IsEmpty())?0:Edit6->Text.ToInt();

            PTreeTable->SMART       = CheckBox1->Checked;
            PTreeTable->Q1234       = CheckBox2->Checked;
            PTreeTable->nabs        = CheckBox3->Checked;
            PTreeTable->nblock      = cbBlockAutomaticPoll->Checked;
            PTreeTable->nblocktime  = CheckBox5->Checked;
            PTreeTable->nswitch     = CheckBox4->Checked;
            PTreeTable->NLockSwitch = cbNLockSwitch->Checked;
            PTreeTable->ncalcbill   = CalcBillCB->Checked;
            PTreeTable->ncalcmonth  = CalcMonthCB->Checked;
            PTreeTable->ninverted   = InvertedCB->Checked;
            PTreeTable->nDataWithOB = cbDataWithOB->Checked;
            PTreeTable->integr      = StrToInt(cbIntgr->Text);

            Control=(TWinControl *)Edit7;
            PTreeTable->CANAL=(Edit7->Text.IsEmpty())?0:Edit7->Text.ToInt();

            Control=(TWinControl *)eDopNum;
            PTreeTable->rescanal=(eDopNum->Text.IsEmpty())?0:eDopNum->Text.ToInt();
            //GRB CHANGE 17.08.2021
            //strcpy(PTreeTable->CELLNUM,Edit8->Text.c_str());
            strncpy(PTreeTable->CELLNUM, Edit8->Text.c_str(),sizeof(PTreeTable->CELLNUM) - 1);
            PTreeTable->CELLNUM[sizeof(PTreeTable->CELLNUM) - 1] = '\0';
            //END CHANGE
            Control=(TWinControl *)Edit15;
            PTreeTable->KC=(Edit15->Text.IsEmpty())?1:Edit15->Text.ToDouble();

            Control=(TWinControl *)edClassTN;
            PTreeTable->classTN=(edClassTN->Text.IsEmpty())?(double)1/2:edClassTN->Text.ToDouble();

            Control=(TWinControl *)edClassTT;
            PTreeTable->classTT=(edClassTT->Text.IsEmpty())?(double)1/2:edClassTT->Text.ToDouble();

            Control=(TWinControl *)Edit9;
            PTreeTable->POWER1=(Edit9->Text.IsEmpty())?0:Edit9->Text.ToDouble();

            Control=(TWinControl *)Edit14;
            PTreeTable->POWER2=(Edit14->Text.IsEmpty())?0:Edit14->Text.ToDouble();

            Control=(TWinControl *)Edit10;
            PTreeTable->CURRENT1=(Edit10->Text.IsEmpty())?0:Edit10->Text.ToDouble();

            Control=(TWinControl *)Edit11;
            PTreeTable->CURRENT2=(Edit11->Text.IsEmpty())?0:Edit11->Text.ToDouble();

            Control=(TWinControl *)Edit12;
            if((PTreeTable->indic[0] = Edit12->Text.IsEmpty()?-1:0)==0)
                PTreeTable->Tag = Edit12->Text.ToInt();

            Control=(TWinControl *)Edit16;
            PTreeTable->MeterKC=(Edit16->Text.IsEmpty())?1:Edit16->Text.ToDouble();
            //17.08.2021 GRB CHANGE
            /*strcpy(PTreeTable->vaccount,Edit25->Text.c_str());
            strcpy(PTreeTable->v_info,Edit13->Text.c_str());
            strcpy(PTreeTable->verifyParam,eVerifyParam->Text.c_str());
            strcpy(PTreeTable->AddParams,eAddParams->Text.c_str());
            strcpy(PTreeTable->formula,edFormula->Text.c_str());
            strcpy(PTreeTable->vsource,lSource->Caption.c_str());
            strcpy(PTreeTable->ImportCode,eImportCode->Text.c_str());
            strcpy(PTreeTable->vCode,eCode->Text.c_str());
            strcpy(PTreeTable->verifyDay,eVerifyDay->Text.c_str());
            strcpy(PTreeTable->vnote,mNote->Lines->Text.c_str()); */
            //BLOCK TO CHANGE
            strncpy(PTreeTable->vaccount, Edit25->Text.c_str(),sizeof(PTreeTable->vaccount) - 1);
            PTreeTable->vaccount[sizeof(PTreeTable->vaccount) - 1] = '\0';
            strncpy(PTreeTable->v_info, Edit13->Text.c_str(),sizeof(PTreeTable->v_info) - 1);
            PTreeTable->v_info[sizeof(PTreeTable->v_info) - 1] = '\0';
            strncpy(PTreeTable->verifyParam, eVerifyParam->Text.c_str(),sizeof(PTreeTable->verifyParam) - 1);
            PTreeTable->verifyParam[sizeof(PTreeTable->verifyParam) - 1] = '\0';
            strncpy(PTreeTable->AddParams, eAddParams->Text.c_str(),sizeof(PTreeTable->AddParams) - 1);
            PTreeTable->AddParams[sizeof(PTreeTable->AddParams) - 1] = '\0';
            strncpy(PTreeTable->formula, edFormula->Text.c_str(),sizeof(PTreeTable->formula) - 1);
            PTreeTable->formula[sizeof(PTreeTable->formula) - 1] = '\0';
            strncpy(PTreeTable->vsource, lSource->Caption.c_str(),sizeof(PTreeTable->vsource) - 1);
            PTreeTable->vsource[sizeof(PTreeTable->vsource) - 1] = '\0';
            strncpy(PTreeTable->ImportCode, eImportCode->Text.c_str(),sizeof(PTreeTable->ImportCode) - 1);
            PTreeTable->ImportCode[sizeof(PTreeTable->ImportCode) - 1] = '\0';
            strncpy(PTreeTable->vCode, eCode->Text.c_str(),sizeof(PTreeTable->vCode) - 1);
            PTreeTable->vCode[sizeof(PTreeTable->vCode) - 1] = '\0';
            strncpy(PTreeTable->verifyDay, eVerifyDay->Text.c_str(),sizeof(PTreeTable->verifyDay) - 1);
            PTreeTable->verifyDay[sizeof(PTreeTable->verifyDay) - 1] = '\0';
            strncpy(PTreeTable->vnote, mNote->Lines->Text.c_str(),sizeof(PTreeTable->vnote) - 1);
            PTreeTable->vnote[sizeof(PTreeTable->vnote) - 1] = '\0';
            //END BLOCK
            ActivePage=tsLoss;
            Control=(TWinControl *)cbLossType;
            PTreeTable->nlosstype=(cbLossType->ItemIndex<=0)?0:cbLossType->ItemIndex;

            Control=(TWinControl *)edLineLoss;
            if((PTreeTable->indic[3] = edLineLoss->Text.IsEmpty()?-1:0)==0)
                PTreeTable->nlineloss = edLineLoss->Text.ToDouble();

            Control=(TWinControl *)edATrLoss;
            if((PTreeTable->indic[4] = edATrLoss->Text.IsEmpty()?-1:0)==0)
                PTreeTable->ntraloss = edATrLoss->Text.ToDouble();

            Control=(TWinControl *)edRTrLoss;
            if((PTreeTable->indic[5] = edRTrLoss->Text.IsEmpty()?-1:0)==0)
                PTreeTable->ntrrloss = edRTrLoss->Text.ToDouble();

            Control=(TWinControl *)cbCalcR;
            PTreeTable->nrecompens = (long)cbCalcR->Items->Objects[cbCalcR->ItemIndex];
            SetLoss(sNode);

            ActivePage=tsAddParam;
            Control=(TWinControl *)edTw;
            if((PTreeTable->indic[1] = edTw->Text.IsEmpty()?-1:0)==0)
                PTreeTable->nwh = edTw->Text.ToDouble();

            Control=(TWinControl *)edTf;
            if((PTreeTable->indic[2] = edTf->Text.IsEmpty()?-1:0)==0)
                PTreeTable->nfh = edTf->Text.ToDouble();

            Control=(TWinControl *)edCurrPower;
            if((PTreeTable->indic[6] = edCurrPower->Text.IsEmpty()?-1:0)==0)
                PTreeTable->ncurrpower = edCurrPower->Text.ToDouble();

            Control=(TWinControl *)edMonthConsumpt;
            if((PTreeTable->indic[7] = edMonthConsumpt->Text.IsEmpty()?-1:0)==0)
                PTreeTable->nmonthconsumpt = edMonthConsumpt->Text.ToDouble();

            Control=(TWinControl *)cbCalcType;
            PTreeTable->ncalcpointtype = (long)cbCalcType->Items->Objects[cbCalcType->ItemIndex];

            PTreeTable->DataAbsence = cbDataAbsence->Checked ? 1 : 0;
            PTreeTable->ntimezonew = StrToInt(cbTimeZoneW->Text);
            PTreeTable->ntimezones = StrToInt(cbTimeZoneS->Text);
            Control=(TWinControl *)eComm;
            if(eComm->Text.IsEmpty())
                PTreeTable->indCommControl = -1;
            else {
                PTreeTable->CommControl = eComm->Text.ToInt();
                PTreeTable->indCommControl = 0;
            }
            Control=(TWinControl *)eTech;
            if(eTech->Text.IsEmpty())
                PTreeTable->indTechControl = -1;
            else{
                PTreeTable->TechControl = eTech->Text.ToInt();
                PTreeTable->indTechControl = 0;
            }
        }
        if(PTreeTable->Type==4)
        {
           ActivePage=tsMainSpec;
           //17.08.2021 GRB CHANGE
           /*strcpy(PTreeTable->Name,Edit22->Text.c_str());
           strcpy(PTreeTable->Short_Name,Edit23->Text.c_str());*/
           //END CHANGE
           //BLOCK TO CHANGE
           strncpy(PTreeTable->Name, Edit22->Text.c_str(),sizeof(PTreeTable->Name) - 1);
           PTreeTable->Name[sizeof(PTreeTable->Name) - 1] = '\0';
           strncpy(PTreeTable->Short_Name, Edit23->Text.c_str(),sizeof(PTreeTable->Short_Name) - 1);
           PTreeTable->Short_Name[sizeof(PTreeTable->Short_Name) - 1] = '\0';
           //END BLOCK
           PTreeTable->nswitch       = CheckBox7->Checked;
           PTreeTable->NLockSwitch   = cbNLockSwitch1->Checked;
           //17.08.2021 GRB CHANGE
           //strcpy(PTreeTable->vCode,eCode4->Text.c_str());
           //END CHANGE
           //BLOCK TO CHANGE
           strncpy(PTreeTable->vCode, eCode4->Text.c_str(),sizeof(PTreeTable->vCode) - 1);
           PTreeTable->vCode[sizeof(PTreeTable->vCode) - 1] = '\0';
           //END BLOCK
           Control=(TWinControl *)edCurrPower;
           if((PTreeTable->indic[6] = edCurrPower->Text.IsEmpty()?-1:0)==0)
             PTreeTable->ncurrpower = edCurrPower->Text.ToDouble();

           Control=(TWinControl *)edMonthConsumpt;
           if((PTreeTable->indic[7] = edMonthConsumpt->Text.IsEmpty()?-1:0)==0)
             PTreeTable->nmonthconsumpt = edMonthConsumpt->Text.ToDouble();

           Control=(TWinControl *)cbCalcType;
           PTreeTable->ncalcpointtype = (long)cbCalcType->Items->Objects[cbCalcType->ItemIndex];

           PTreeTable->ntimezonew = StrToInt(cbTimeZoneW_1->Text);
           PTreeTable->ntimezones = StrToInt(cbTimeZoneS_1->Text);
           //17.08.2021 GRB CHANGE
           //strcpy(PTreeTable->vnote,mNote2->Lines->Text.c_str());
           //END CHANGE
           //BLOCK TO CHANGE
           strncpy(PTreeTable->vnote, mNote2->Lines->Text.c_str(),sizeof(PTreeTable->vnote) - 1);
           PTreeTable->vnote[sizeof(PTreeTable->vnote) - 1] = '\0';
           //END BLOCK
           //GRB ADD 08.07.2019
           PTreeTable->eic_info.veic_code = Edit28->Text;
           if (RadioGroup2->ItemIndex==1){
                        PTreeTable->eic_info.mms = "*";
                        PTreeTable->eic_info.c_type = "4";
           }
           //END ADD
//<----------------------------
        }

        //GRB ADD 21.06.2019  Глупая заплатка - на бажина кроится именно тут  Нужно вставить mms, ctype бо чего-то при вставках их обнуляют и * убирают
      if(PTreeTable->Type==2){
        if (Panel31->FindChildControl("EICCheckbox")){
                TCheckBox *cbx = (TCheckBox*)Panel31->FindChildControl("EICCheckbox");
                //cbx->OnClick = NULL;
                PTreeTable->eic_info.vfullname = Edit1->Text;
                //17.08.2021 GRB CHANGE
                //strcpy (PTreeTable->Name,Edit1->Text.c_str());
                //END CHANGE
                //BLOCK TO CHANGE
                strncpy(PTreeTable->Name, Edit1->Text.c_str(),sizeof(PTreeTable->Name) - 1);
                PTreeTable->Name[sizeof(PTreeTable->Name) - 1] = '\0';
                //END BLOCK
                PTreeTable->eic_info.vshortname = Edit2->Text;
                //17.08.2021 GRB CHANGE
                //strcpy (PTreeTable->Short_Name, Edit2->Text.c_str());
                //END CHANGE
                //BLOCK TO CHANGE
                strncpy(PTreeTable->Short_Name, Edit2->Text.c_str(),sizeof(PTreeTable->Short_Name) - 1);
                PTreeTable->Short_Name[sizeof(PTreeTable->Short_Name) - 1] = '\0';
                //END BLOCK

                if (cbx->Checked){
                        PTreeTable->eic_info.mms = "*";
                        PTreeTable->eic_info.veic_code = Edit26->Text;
                        PTreeTable->eic_info.c_type = IntToStr(RadioGroup1->ItemIndex+1);
                }else{
                        PTreeTable->eic_info.mms = "";
                        PTreeTable->eic_info.veic_code="";
                        PTreeTable->eic_info.c_type="";
                }
	}
     }
      //END ADD

        PTreeTable->editing=1;

    }catch (Exception &exception){
        AllowChange=false;
        Application->ShowException(&exception);
        if(Control){
            if(pcMain->ActivePage!=ActivePage)
                pcMain->ActivePage=ActivePage;
            Control->SetFocus();
        }
    }
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::ShowCounter(TTreeNode *Node)
{
    TEdit *ed;
    TMemo *me;
    for(int i=0;i<ComponentCount;i++){
        ed=dynamic_cast<TEdit *>(Components[i]);
        if(ed){
          ed->OnChange=NULL;
          continue;
        }
        me=dynamic_cast<TMemo *>(Components[i]);
        if(me)
          me->OnChange=NULL;
    }
    Edit17->Text="";
    Edit18->Text="";
    Edit19->Text="";
    Edit20->Text="";
    Edit21->Text="";
    if(Node&&Node->Data&&((POINTSDIV*)Node->Data)->pcounter)
    {
        TList *list_count=((POINTSDIV*)Node->Data)->pcounter;
        TFormCounter::POINTCOUNT *PCountTable;
        for(int i=0;i<list_count->Count;i++)
        {
            PCountTable=(TFormCounter::POINTCOUNT *)list_count->Items[i];
            switch (PCountTable->Entype)
            {
            case 1:
                Edit17->Text=PCountTable->MTRSN;
                Panel34->Visible=false;
                break;
            case 3:
                Edit18->Text=PCountTable->MTRSN;
                Panel34->Visible=false;
                break;
            case 2:
                Edit19->Text=PCountTable->MTRSN;
                Panel34->Visible=false;
                break;
            case 5:
                Edit20->Text=PCountTable->MTRSN;
                Panel34->Visible=false;
                break;
            case 7:
                Edit21->Text=PCountTable->MTRSN;
                Panel34->Visible=true;
                break;
            }
        }
    }
    if(Panel34->Visible)
    {
        Edit17->TabStop=false;
        Edit18->TabStop=false;
        Edit19->TabStop=false;
        Edit20->TabStop=false;
        Edit21->TabStop=true;
    }
    else
    {
        Edit17->TabStop=true;
        Edit18->TabStop=true;
        Edit19->TabStop=true;
        Edit20->TabStop=true;
        Edit21->TabStop=false;
    }
    for(int i=0;i<ComponentCount;i++){
        ed=dynamic_cast<TEdit *>(Components[i]);
        if(ed){
          ed->OnChange=EditChange;
          continue;
        }
        me=dynamic_cast<TMemo *>(Components[i]);
        if(me)
          me->OnChange=EditChange;
    }
}
//---------------------------------------------------------------------------

void __fastcall TFormEditFiders::TreeView1Change(TObject *Sender,
      TTreeNode *Node)
{

    if(ActiveControl) oldCtrl = ActiveControl;

    TEdit *ed;
    TCheckBox *cb;
    TMemo *me;
    TRadioGroup *ra;

    POINTSDIV *PTreeTable=NULL;
    DisplayLoss(Node);
    SetAccMenuOFF();
    if(!Node||!Node->Data){
        tsMainSpec->TabVisible=false;
        tsParam->TabVisible=true;
        pcMain->ActivePage=tsParam;
        paEdit->Visible=false;
        paAddParam->Visible=false;
        iaDelete->Enabled=false;
//        aIns->Enabled=false;
        iaNewCalcNode->Enabled = false;
        iaNew->Enabled=false;
        tbNew->Enabled = false;
        mAdd->Enabled = false;
        paLoss->Visible=false;
        paLoss->Enabled=false;
        acMeterParameter->Enabled=false;
        tbPrior->Enabled=false;
        tbclonFormul->Enabled=false;
    }else{
        PTreeTable=(POINTSDIV*)Node->Data;
        switch (PTreeTable->Type)
        {

        case 1:
           if (pcMain->ActivePage==tsMainSpec){
              tsMainSpec->TabVisible=false;
             tsParam->TabVisible=true;

             pcMain->ActivePage=tsParam;
              }
             tsMainSpec->TabVisible=false;
             tsParam->TabVisible=true;
             paEdit->Visible=false;
            paAddParam->Visible=false;
            iaDelete->Enabled=false;
    //           aIns->Enabled=false;
            iaNew->Enabled=false;
            iaNewCalcNode->Enabled = false;
            tbNew->Enabled = false;
            mAdd->Enabled = false;
//            aAddGroup->Enabled=false;
            aInsGroup->Enabled=true;
            Edit1->Enabled=false;
            Edit2->Enabled=false;
            aEdit->Enabled=false;
            aOccurr->Enabled = false;
            aChannelList->Enabled = false;
            aGroupList->Enabled = false;
            aMaketList->Enabled = false;
            aLastSave->Enabled = false;
            aGuid->Enabled = false;
            aURD->Enabled = false;
            paLoss->Visible=false;
            paLoss->Enabled=false;
            acMeterParameter->Enabled=false;
            aNodeUp->Enabled=false;
            aNodeDown->Enabled=false;
            aSpezPar->Enabled=false;
            aBorder2Par->Enabled=false;
            tbKoeff->Enabled=false;
            tbPrior->Enabled=false;
            tbclonFormul->Enabled=true;
            //removeEICCheckBoxOnPanel(this);
            addEICCheckBoxOnPanel(this);
            break;
        case 2:
           if (pcMain->ActivePage==tsMainSpec){
             tsMainSpec->TabVisible=false;
             tsParam->TabVisible=true;
             pcMain->ActivePage=tsParam;

             }
             tsMainSpec->TabVisible=false;
             tsParam->TabVisible=true;
             paEdit->Visible=false;
            paAddParam->Visible=false;
            iaDelete->Enabled=true;
  //            aIns->Enabled=true;
            iaNew->Enabled=true;
            iaNewCalcNode->Enabled = true;
            tbNew->Enabled = true;
            mAdd->Enabled = true;
//            aAddGroup->Enabled=true;
            aInsGroup->Enabled=true;
            Edit1->Enabled=true;
            Edit2->Enabled=true;
            aEdit->Enabled=false;
            aOccurr->Enabled = false;
            aChannelList->Enabled = false;
            aLastSave->Enabled = false;
            aGroupList->Enabled = false;
            aGuid->Enabled = false;
            aURD->Enabled = false;
            aMaketList->Enabled = false;
            paLoss->Visible=false;
            paLoss->Enabled=false;
            acMeterParameter->Enabled=false;
            aNodeUp->Enabled=false;
            aNodeDown->Enabled=false;
            aSpezPar->Enabled=false;
            aBorder2Par->Enabled=false;
            tbKoeff->Enabled=false;
            tbPrior->Enabled=false;
            tbclonFormul->Enabled=true;
            break;
        case 3:
              if (pcMain->ActivePage==tsMainSpec){
              tsMainSpec->TabVisible=false;
             tsParam->TabVisible=true;
             pcMain->ActivePage=tsParam;

             }
             tsMainSpec->TabVisible=false;
             tsParam->TabVisible=true;
            paEdit->Visible=true;
            paAddParam->Visible=true;
            iaDelete->Enabled=true;
 //            aIns->Enabled=PTreeTable->SMART;
            iaNew->Enabled=true;
            iaNewCalcNode->Enabled = false;
            tbNew->Enabled = true;
            mAdd->Enabled = true;
//            aAddGroup->Enabled=true;
            aInsGroup->Enabled=false;
            Edit1->Enabled=true;
            Edit2->Enabled=true;
            aEdit->Enabled=true;
            aOccurr->Enabled      = true;
            aChannelList->Enabled = true;
            aLastSave->Enabled = true;
            aGroupList->Enabled = true;
            aGuid->Enabled = true;
            aURD->Enabled = true;
            aMaketList->Enabled = true;
            paLoss->Visible=true;
            paLoss->Enabled=true;
            acMeterParameter->Enabled=true;
            aSpezPar->Enabled=true;
            aBorder2Par->Enabled=true;
            tbKoeff->Enabled=false;
            tbPrior->Enabled=false;
            tbclonFormul->Enabled=false;
            cbIntgr->Enabled=true;
            if(Node->Parent&&Node->Parent->Data&&((POINTSDIV*)Node->Parent->Data)->Type==4)
            {
            aNodeUp->Enabled=true;
            aNodeDown->Enabled=true;
            }
            else
            {
             aNodeUp->Enabled=false;
             aNodeDown->Enabled=false;
            }
            if(paCalcPoint->Parent!=paCalcPoint1)
              paCalcPoint->Parent=paCalcPoint1;
            removeEICCheckBoxOnPanel(this);
            changePanel31Height (1);
            break;
        case 4:
          if (pcMain->ActivePage==tsParam){
             tsMainSpec->TabVisible=true;
             tsParam->TabVisible=false;
             pcMain->ActivePage=tsMainSpec;

             }
			 //26.07.2022 GRB ADD!
             acMeterParameter->Enabled = false;
             //end add
             tsMainSpec->TabVisible=true;
             tsParam->TabVisible=false;
             removeEICCheckBoxOnPanel(this);
             paAddParam->Visible=false;
             iaDelete->Enabled=true;
      //      Panel27->Visible=true;
         //   paEdit->Top=56;
//            aIns->Enabled=true;
            iaNew->Enabled=true;
            iaNewCalcNode->Enabled = true;
            tbNew->Enabled = true;
            mAdd->Enabled = true;
//            aAddGroup->Enabled=true;
            aInsGroup->Enabled=false;
         //   Edit1->Enabled=true;
         //   Edit2->Enabled=true;
            aEdit->Enabled=false;
            aOccurr->Enabled = true;
            aChannelList->Enabled = false;
            aLastSave->Enabled = false;
            aGroupList->Enabled = true;
            aGuid->Enabled = true;
            aURD->Enabled = true;
            aMaketList->Enabled = true;
            paLoss->Visible=false;
            paLoss->Enabled=false;
            aSpezPar->Enabled=true;
            aBorder2Par->Enabled=true;
            tbKoeff->Enabled=false;
            tbPrior->Enabled=true;
            tbclonFormul->Enabled=false;
            cbIntgr->Enabled=false;
            if(Node->Parent&&Node->Parent->Data&&((POINTSDIV*)Node->Parent->Data)->Type==4)
            {
            aNodeUp->Enabled=true;
            aNodeDown->Enabled=true;
            }
            else
            {
             aNodeUp->Enabled=false;
             aNodeDown->Enabled=false;
            }
          //  aNodeUp->Enabled=false;
          //  aNodeDown->Enabled=false;
            if(paCalcPoint->Parent!=paCalcPoint2)
              paCalcPoint->Parent=paCalcPoint2;
            //EditRec = false;
            changePanel31Height (1);
            break;
          }

    }


    for(int i=0;i<ComponentCount;i++){
      //GRB ADD
      ra = dynamic_cast<TRadioGroup *>(Components[i]);
      if (ra){
      ra->OnClick=NULL;
      continue;
      }
      //END GRB ADD
      me=dynamic_cast<TMemo *>(Components[i]);
        if(me){
            me->OnChange=NULL;
            me->Text="";
            continue;
        }
        cb=dynamic_cast<TCheckBox *>(Components[i]);
        if(cb){
        {
           cb->OnClick=NULL;
            cb->Checked=false;
            continue;
            }
        }

          //btLimit2->OnClick=NULL;
          btLimit->OnClick=NULL;
        ed=dynamic_cast<TEdit *>(Components[i]);
        if(ed){
            ed->OnChange=NULL;
            ed->Text="";
            continue;
        }


    }
    cbCalcR->OnChange=NULL;
    cbCalcType->OnChange=NULL;
    cbLossType->ItemIndex=0;
    SetLossInterface();
    SetCalcInterface();
    lbId->Text = "";
    if(!PTreeTable)
        return;
    if(PTreeTable->Type==2){
             //GRB ADD 11.06.2019
             addEICCheckBoxOnPanel(this);
             TCheckBox* cbx = (TCheckBox*)Panel31->FindChildControl("EICCheckbox");

             ComboBox1->Items->Clear();
             for (int i = 0 ; i < tradeZonesGlobalList->Count; i++){
                AnsiString curr = tradeZonesGlobalList->Strings[i];
                ComboBox1->Items->Add(curr);
                if (i==0) {
                        ComboBox1->Text = curr;
                }
             }
             showTradeZones();


             if (CompareStr (PTreeTable->eic_info.mms,"*")==0){
                cbx->Checked = true;
                Edit26->Text = PTreeTable->eic_info.veic_code;
                changePanel31Height (3);
                int op_sw = StrToInt (PTreeTable->eic_info.c_type);
                RadioGroup1->OnClick = NULL;
               switch (op_sw){
                case 1:{
                RadioGroup1->ItemIndex = PTreeTable->eic_info.c_type-1;
                Edit26->Enabled = false;
                Edit26->Text = PTreeTable->eic_info.veic_code;
                showTradeZones ();
                if (CompareStr (PTreeTable->eic_info.veic_code, UKRAINE_ZONE_CODE)==0){
                 ComboBox1->Text = UKRAINE_ZONE;
                }
                if (CompareStr (PTreeTable->eic_info.veic_code, BURSHTIN_ZONE_CODE)==0){
                 ComboBox1->Text = BURSHTIN_ZONE;
                }
                break;
               }
               case 2:{
                Edit26->Enabled = true;
                Edit26->Text = PTreeTable->eic_info.veic_code;
                RadioGroup1->ItemIndex = PTreeTable->eic_info.c_type-1;
                hideTradeZones();
                break;
               }
               case 3:{
                Edit26->Enabled = true;
                Edit26->Text = PTreeTable->eic_info.veic_code;
                RadioGroup1->ItemIndex = PTreeTable->eic_info.c_type-1;
                hideTradeZones();
                break;
               }
                case 4:{ //точка?
                changePanel31Height (1);
                break;
               }
             }
             }
             else{
               cbx->Checked = false;
               changePanel31Height(2);
             }
             //GRB ADD 24.06.2019

        if (getPanel31HeightState()!=3)
          changePanel31Height(2);
        }else{
        changePanel31Height(1);
    }
  if(PTreeTable->Type!=4)
    {
    Edit1->Text=PTreeTable->Name;
    Edit2->Text=PTreeTable->Short_Name;
    lbId->Text = IntToStr(PTreeTable->Mid);
   }
    if(PTreeTable->Type==1)
        return;

    if(PTreeTable->Type==3)
    {
        Edit3->Text             = IntToStr(PTreeTable->ER_POSITION);
        Edit4->Text             = IntToStr(PTreeTable->Q1_POSITION);
        Edit5->Text             = IntToStr(PTreeTable->ED_POSITION);
        Edit6->Text             = IntToStr(PTreeTable->Q3_POSITION);
        CheckBox1->Checked      = PTreeTable->SMART;
        CheckBox2->Checked      = PTreeTable->Q1234;
        CheckBox3->Checked      = PTreeTable->nabs;
        cbBlockAutomaticPoll->Checked = PTreeTable->nblock;
        CheckBox5->Checked      = PTreeTable->nblocktime;
        CheckBox4->Checked      = PTreeTable->nswitch;
        cbNLockSwitch->Checked  = PTreeTable->NLockSwitch;
        CalcBillCB->Checked     = PTreeTable->ncalcbill;
        CalcMonthCB->Checked    = PTreeTable->ncalcmonth;
        InvertedCB->Checked     = PTreeTable->ninverted;
        cbDataWithOB->Checked   = PTreeTable->nDataWithOB;
        Edit7->Text             = IntToStr(PTreeTable->CANAL);
        eDopNum->Text           = IntToStr(PTreeTable->rescanal);
        eUSDPoint->Text         = PTreeTable->USDText;
        eDuplPoint->Text        = PTreeTable->MainText;
        eGroup->Text            = PTreeTable->GroupText;
        Edit8->Text             = PTreeTable->CELLNUM;
        Edit9->Text             = FloatToStr(PTreeTable->POWER1);
        Edit14->Text            = FloatToStr(PTreeTable->POWER2);
        Edit10->Text            = FloatToStr(PTreeTable->CURRENT1);
        Edit11->Text            = FloatToStr(PTreeTable->CURRENT2);
        Edit15->Text            = FloatToStr(PTreeTable->KC);
        edClassTN->Text         = FloatToStr(PTreeTable->classTN);
        edClassTT->Text         = FloatToStr(PTreeTable->classTT);
        Edit16->Text            = FloatToStr(PTreeTable->MeterKC);
        Edit12->Text            = PTreeTable->indic[0]==0?AnsiString(PTreeTable->Tag).c_str():"";
        Edit25->Text            = PTreeTable->vaccount;
        Edit13->Text            = PTreeTable->v_info;
        eVerifyParam->Text      = PTreeTable->verifyParam;
        eAddParams->Text        = PTreeTable->AddParams;
        edFormula->Text         = PTreeTable->formula;
        lSource->Caption        = PTreeTable->vsource;
        eImportCode->Text       = PTreeTable->ImportCode;
        eCode->Text             = PTreeTable->vCode;
        eVerifyDay->Text        = PTreeTable->verifyDay;
        mNote->Lines->Text      = PTreeTable->vnote;

        cbLossType->ItemIndex=PTreeTable->nlosstype;
        edTw->Text=PTreeTable->indic[1]==0?FloatToStr(PTreeTable->nwh).c_str():"";
        edTf->Text=PTreeTable->indic[2]==0?FloatToStr(PTreeTable->nfh).c_str():"";
        edLineLoss->Text=PTreeTable->indic[3]==0?FloatToStr(PTreeTable->nlineloss).c_str():"";
        edATrLoss->Text=PTreeTable->indic[4]==0?FloatToStr(PTreeTable->ntraloss).c_str():"";
        edRTrLoss->Text=PTreeTable->indic[5]==0?FloatToStr(PTreeTable->ntrrloss).c_str():"";
        cbCalcR->ItemIndex=cbCalcR->Items->IndexOfObject((TObject*)PTreeTable->nrecompens);
        cbCalcType->ItemIndex=cbCalcType->Items->IndexOfObject((TObject*)PTreeTable->ncalcpointtype);
        edCurrPower->Text=PTreeTable->indic[6]==0?FloatToStr(PTreeTable->ncurrpower).c_str():"";
        edMonthConsumpt->Text=PTreeTable->indic[7]==0?FloatToStr(PTreeTable->nmonthconsumpt).c_str():"";
        eOpp->Text = PTreeTable->Opposite;
        cbDataAbsence->Checked = (PTreeTable->DataAbsence==1);
        if(PTreeTable->indCommControl<0) eComm->Text = "";
        else eComm->Text = PTreeTable->CommControl;
        if(PTreeTable->indTechControl<0) eTech->Text = "";
        else eTech->Text = PTreeTable->TechControl;

        cbTimeZoneW->ItemIndex = PTreeTable->ntimezonew+14;
        cbTimeZoneS->ItemIndex = PTreeTable->ntimezones+14;

        for(int i=0;i<cbIntgr->Items->Count;i++)
        {
          if((int)cbIntgr->Items->Objects[i]==PTreeTable->integr)
            cbIntgr->ItemIndex=i;
        }
        //btLimit2->OnClick=btLimitClick;

        if(Access==accWrite)
           CheckBox2->Enabled = (customer_id==1||customer_id==51) ? false:CheckBox1->Checked;
        sbUSDList->Enabled = CheckBox2->Enabled;
        ShowCounter(Node);
    }
    if(PTreeTable->Type==4){
    Edit22->Text=PTreeTable->Name;
    Edit23->Text=PTreeTable->Short_Name;
    Edit24->Text = IntToStr(PTreeTable->Mid);
    eOpposite->Text = PTreeTable->Opposite;
    eCode4->Text=PTreeTable->vCode;
    CheckBox7->Checked = PTreeTable->nswitch;
    cbNLockSwitch1->Checked = PTreeTable->NLockSwitch;
    cbDataWithOB->Checked   = PTreeTable->nDataWithOB;
//<------
    btLimit->OnClick=btLimitClick;
    cbCalcType->ItemIndex=cbCalcType->Items->IndexOfObject((TObject*)PTreeTable->ncalcpointtype);
    edCurrPower->Text=PTreeTable->indic[6]==0?FloatToStr(PTreeTable->ncurrpower).c_str():"";
    edMonthConsumpt->Text=PTreeTable->indic[7]==0?FloatToStr(PTreeTable->nmonthconsumpt).c_str():"";
    eGroup->Text=PTreeTable->GroupText;
    edFormula->Text=PTreeTable->formula;
    lSource2->Caption=PTreeTable->vsource;
    cbIntgr->ItemIndex=-1;

    cbTimeZoneW_1->ItemIndex = PTreeTable->ntimezonew+14;
    cbTimeZoneS_1->ItemIndex = PTreeTable->ntimezones+14;
    mNote2->Lines->Text      = PTreeTable->vnote;


    //GRB ADD 24.06.2019
    if (!(PTreeTable->eic_info.mms.IsEmpty()) && (CompareStr (PTreeTable->eic_info.mms,"*")==0)){
        Edit28->Visible = true;
        Label46->Visible = true;
        RadioGroup2->ItemIndex = 1;
        Edit28->Text = PTreeTable->eic_info.veic_code;
    }else{
         RadioGroup2->ItemIndex = 0;
         Edit28->Visible = false;
         Label46->Visible = false;

    }
    //END ADD


//<-------------------------------------------------------
    //tbLimit2->OnClick=btLimitClick;
    //tbLimit2->Enabled=true;
    }
    SetLossInterface();
    SetCalcInterface();
    for(int i=0;i<ComponentCount;i++){
    //GRB ADD
        ra = dynamic_cast<TRadioGroup*>(Components[i]);
        if(ra){
            if (CompareStr (ra->Name,"RadioGroup1")==0){
            ra->OnClick=RadioGroup1Click;
            }
            if (CompareStr (ra->Name,"RadioGroup2")==0){
            ra->OnClick=RadioGroup2Click;
            }
            continue;
        }
        //END GRB ADD
        ed=dynamic_cast<TEdit*>(Components[i]);
        if(ed){
            ed->OnChange=EditChange;
            continue;
        }
        me=dynamic_cast<TMemo*>(Components[i]);
        if(me){
            me->OnChange=EditChange;
            continue;
        }
        cb=dynamic_cast<TCheckBox*>(Components[i]);
        if(cb)
          cb->OnClick=CheckBoxClick;
        if (cb){
        if (CompareStr (cb->Name,"EICCheckbox")==0){
            cb->OnClick=EICCheckboxClick;
        }
        }

    }
    cbCalcR->OnChange=cbChange;
    cbCalcType->OnChange=cbChange;
    try{
   // PTreeTable=(POINTSDIV*)Node->Data;
        if (PTreeTable->Type==4&&pcMain->ActivePage==tsParam){
         pcMain->ActivePage=tsMainSpec;
         oldCtrl = ActiveControl;

        }
        if (PTreeTable->Type==3&&pcMain->ActivePage==tsMainSpec) {
        pcMain->ActivePage=tsParam;
        oldCtrl = ActiveControl;

        }
       ActiveControl = oldCtrl;




   /*   if(TreeView1->Selected&&TreeView1->Selected->Data)
      {
         FORMS *fms;
         fms=(FORMS*)mMon->Tag ;
         if(!fms) fms = new FORMS;
         ZeroMemory(fms, sizeof(FORMS));
         if(TreeView1->Selected&&TreeView1->Selected->Data)
          fms->gid = ((POINTSDIV*)TreeView1->Selected->Data)->Mid;
          fms->tmplCode=0;
          mMon->Tag = (int)fms;
          createSubMenu_F(mMon);
       }  */

    }catch(Exception&e){
        ActiveControl = NULL;
    }
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::EditChange(TObject *Sender)
{
  TTreeNode *sNode=TreeView1->Selected;
  if(!sNode||!sNode->Data||((POINTSDIV*)sNode->Data)->Type==1)
    return;
  if(((POINTSDIV*)sNode->Data)->editing!=2)
    ((POINTSDIV*)sNode->Data)->editing=2;
  if((TEdit*)Sender==Edit1||(TEdit*)Sender==Edit22)
    sNode->Text=((TEdit*)Sender)->Text;
  EditRec=true;
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::CheckBoxClick(TObject *Sender)
{
   TTreeNode *sNode=TreeView1->Selected;
   if(!sNode||!sNode->Data||(((POINTSDIV*)sNode->Data)->Type!=3&&((POINTSDIV*)sNode->Data)->Type!=4))
      return;
   if((TCheckBox*)Sender==CheckBox1){
      if(!CheckBox1->Checked)
      if(EditRec && ((POINTSDIV*)sNode->Data)->fUSD){
         MessageBox(Handle,Reconst_smes20_19.c_str(),
            Caption.c_str(),MB_OK|MB_ICONINFORMATION);
         CheckBox1->Checked=true;
         return;
      }
      getUSDList(pmUSDList,((POINTSDIV*)TreeView1->Selected->Data)->Mid,OnUSDListClick);
      if(!CheckBox1->Checked)
      if(pmUSDList->Items->Count>2){
         MessageBox(Handle,Reconst_smes20_21.c_str(),
            Application->Title.c_str(),MB_OK|MB_ICONWARNING);
         CheckBox1->Checked=true;
         return;
      }
      if(!CheckBox1->Checked&&CheckBox2->Checked)
         CheckBox2->Checked=false;
      CheckBox2->Enabled = CheckBox1->Checked;
      sbUSDList->Enabled = CheckBox2->Enabled;
      iaNew->Enabled=CheckBox1->Checked;
      iaNewCalcNode->Enabled = CheckBox1->Checked;
      tbNew->Enabled = CheckBox1->Checked;
      mAdd->Enabled = CheckBox1->Checked;
   }
  if(((POINTSDIV*)sNode->Data)->editing!=2)
    ((POINTSDIV*)sNode->Data)->editing=2;
  if(CheckBox1->Focused()&&CheckBox1->Checked&&!sNode->getFirstChild())
   {
    if(((POINTSDIV*)sNode->Data)->pcounter)
     {
      for(int i=0;i<((POINTSDIV*)sNode->Data)->pcounter->Count;i++)
        {
         TFormCounter::POINTCOUNT *PCountTable=(TFormCounter::POINTCOUNT *)((POINTSDIV*)sNode->Data)->pcounter->Items[i];
         delete PCountTable;
        }
      ((POINTSDIV*)sNode->Data)->pcounter->Clear();
     }
     TFormCounter::POINTCOUNT TreeTable;
     strcpy(TreeTable.Name,((AnsiString)((POINTSDIV*)sNode->Data)->Name+Reconst_smes20_24).c_str());
     TreeTable.Entype=7;
     strcpy(TreeTable.date_count,DateToStr(Date()).c_str());
     strcpy(TreeTable.MTRSN,"");
     strcpy(TreeTable.DIGITS,"");
     strcpy(TreeTable.MTYPE,"");
     TreeTable.MCURRENT=0;
     TreeTable.Position=0;
     TreeTable.MPOWER=0;
     TreeTable.MCONST=0;
     TreeTable.MCLASS=0;
     TreeTable.MYEAR=0;
     TreeTable.MQUARTER=0;
     TFormCounter::POINTCOUNT *PCountTable=new TFormCounter::POINTCOUNT;
     memcpy(PCountTable,&TreeTable,sizeof(TFormCounter::POINTCOUNT));
     ((POINTSDIV*)sNode->Data)->pcounter->Add(PCountTable);
   }
  if(CheckBox1->Focused()&&!CheckBox1->Checked)
   {
    if(((POINTSDIV*)sNode->Data)->pcounter)
     {
      for(int i=0;i<((POINTSDIV*)sNode->Data)->pcounter->Count;i++)
        {
         TFormCounter::POINTCOUNT *PCountTable=(TFormCounter::POINTCOUNT *)((POINTSDIV*)sNode->Data)->pcounter->Items[i];
         delete PCountTable;
        }
      ((POINTSDIV*)sNode->Data)->pcounter->Clear();
     }
     TFormCounter::POINTCOUNT TreeTable;
     if(!Edit3->Text.IsEmpty()&&Edit3->Text!="0")
      {
       strcpy(TreeTable.Name,((AnsiString)((POINTSDIV*)sNode->Data)->Name+Reconst_smes20_25).c_str());
       TreeTable.Entype=1;
       strcpy(TreeTable.date_count,DateToStr(Date()).c_str());
       strcpy(TreeTable.MTRSN,"");
       strcpy(TreeTable.DIGITS,"");
       strcpy(TreeTable.MTYPE,"");
       TreeTable.MCURRENT=0;
       TreeTable.Position=0;
       TreeTable.MPOWER=0;
       TreeTable.MCONST=0;
       TreeTable.MCLASS=0;
       TreeTable.MYEAR=0;
       TreeTable.MQUARTER=0;
       TFormCounter::POINTCOUNT *PCountTable=new TFormCounter::POINTCOUNT;
       memcpy(PCountTable,&TreeTable,sizeof(TFormCounter::POINTCOUNT));
       ((POINTSDIV*)sNode->Data)->pcounter->Add(PCountTable);
       }
     if(!Edit4->Text.IsEmpty()&&Edit4->Text!="0")
      {
       strcpy(TreeTable.Name,((AnsiString)((POINTSDIV*)sNode->Data)->Name+Reconst_smes20_26).c_str());
       TreeTable.Entype=3;
       strcpy(TreeTable.date_count,DateToStr(Date()).c_str());
       strcpy(TreeTable.MTRSN,"");
       strcpy(TreeTable.DIGITS,"");
       strcpy(TreeTable.MTYPE,"");
       TreeTable.MCURRENT=0;
       TreeTable.Position=0;
       TreeTable.MPOWER=0;
       TreeTable.MCONST=0;
       TreeTable.MCLASS=0;
       TreeTable.MYEAR=0;
       TreeTable.MQUARTER=0;
       TFormCounter::POINTCOUNT *PCountTable=new TFormCounter::POINTCOUNT;
       memcpy(PCountTable,&TreeTable,sizeof(TFormCounter::POINTCOUNT));
       ((POINTSDIV*)sNode->Data)->pcounter->Add(PCountTable);
       }
     if(!Edit5->Text.IsEmpty()&&Edit5->Text!="0")
      {
       strcpy(TreeTable.Name,((AnsiString)((POINTSDIV*)sNode->Data)->Name+Reconst_smes20_27).c_str());
       TreeTable.Entype=2;
       strcpy(TreeTable.date_count,DateToStr(Date()).c_str());
       strcpy(TreeTable.MTRSN,"");
       strcpy(TreeTable.DIGITS,"");
       strcpy(TreeTable.MTYPE,"");
       TreeTable.MCURRENT=0;
       TreeTable.Position=0;
       TreeTable.MPOWER=0;
       TreeTable.MCONST=0;
       TreeTable.MCLASS=0;
       TreeTable.MYEAR=0;
       TreeTable.MQUARTER=0;
       TFormCounter::POINTCOUNT *PCountTable=new TFormCounter::POINTCOUNT;
       memcpy(PCountTable,&TreeTable,sizeof(TFormCounter::POINTCOUNT));
       ((POINTSDIV*)sNode->Data)->pcounter->Add(PCountTable);
       }
     if(!Edit6->Text.IsEmpty()&&Edit6->Text!="0")
      {
       strcpy(TreeTable.Name,((AnsiString)((POINTSDIV*)sNode->Data)->Name+Reconst_smes20_28).c_str());
       TreeTable.Entype=5;
       strcpy(TreeTable.date_count,DateToStr(Date()).c_str());
       strcpy(TreeTable.MTRSN,"");
       strcpy(TreeTable.DIGITS,"");
       strcpy(TreeTable.MTYPE,"");
       TreeTable.MCURRENT=0;
       TreeTable.Position=0;
       TreeTable.MPOWER=0;
       TreeTable.MCONST=0;
       TreeTable.MCLASS=0;
       TreeTable.MYEAR=0;
       TreeTable.MQUARTER=0;
       TFormCounter::POINTCOUNT *PCountTable=new TFormCounter::POINTCOUNT;
       memcpy(PCountTable,&TreeTable,sizeof(TFormCounter::POINTCOUNT));
       ((POINTSDIV*)sNode->Data)->pcounter->Add(PCountTable);
       }
   }
   EditRec=true;
 ShowCounter(sNode);
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::TreeView1Deletion(TObject *Sender,
      TTreeNode *Node)
{
    if((TTreeNode*)Clipboard()->GetAsHandle(CF_POINTS_TREENODE)==Node)
        Clipboard()->Clear();
    TList *list;
    TList *ll;
    if(Node&&Node->Data){
        list=((POINTSDIV*)Node->Data)->pcounter;
        if(list){//Счетчики
            for(long i=0;i<list->Count;i++)
                delete (TFormCounter::POINTCOUNT *)list->Items[i];
            delete list;
        }
        list=((POINTSDIV*)Node->Data)->ploss;
        if(list){//Потери по формуле
            for(long i=0;i<list->Count;i++){
                ll= ((POINTLOSS *)list->Items[i])->pwtimeinfo;
                if(ll){
                    for(long k=0;k<ll->Count;k++)
                        delete (TTimeInfo *)ll->Items[k];
                    delete ll;
                }
                delete (POINTLOSS *)list->Items[i];
            }
            delete list;
        }
        list=((POINTSDIV*)Node->Data)->pwtimeinfo;
        if(list){//Задано время работы
            for(long i=0;i<list->Count;i++)
                delete (TTimeInfo *)list->Items[i];
            delete list;
        }
        list=((POINTSDIV*)Node->Data)->pwcalcparam;
        if(list){//Задано время работы
            for(long i=0;i<list->Count;i++)
                delete (TTimeInfo *)list->Items[i];
            delete list;
        }


        if(realdeletion&&((POINTSDIV*)Node->Data)->Mid){
            nPoints_Del[CountPoints_Del++]=((POINTSDIV*)Node->Data)->Mid;
            getUSDList(pmUSDList,nPoints_Del[CountPoints_Del-1],NULL);
            if(pmUSDList->Items->Count>2)
                USDPointDeleted = true;
        }
        delete (POINTSDIV*)Node->Data;
    }
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::vDelete(TObject *Sender)
{
   if(!iaDelete->Enabled)
      return;
   TTreeNode *sNode=TreeView1->Selected;
   TTreeView *tv=NULL;
   if(sNode && sNode->Data && ((POINTSDIV*)sNode->Data)->Type!=1 &&
      MessageBox(Handle,AnsiString(Reconst_smes20_29+sNode->Text+">?").c_str(),
                     Application->Title.c_str(),MB_YESNO|MB_ICONQUESTION|MB_DEFBUTTON2
                )==IDYES)
   {
      tv=(TTreeView*)sNode->TreeView;
      try{
         realdeletion=true;
         sNode->Delete();
         realdeletion=false;
      }catch(Exception &e){
         realdeletion=false;
         throw;
      }
      if(tv&&!tv->Items->Count&&tv->OnChange)
         tv->OnChange(tv,NULL);
      EditRec=true;
   }
   if(USDPointDeleted){
/*      switch(MessageBox(Handle,"Сохранить данные перед обновлением?","Обновление данных",MB_YESNOCANCEL|MB_ICONINFORMATION)){
      case IDYES:
         vSave(this);
         break;
      case IDNO:
         USDPointDeleted = false;
         break;
      case IDCANCEL:
         return;
      }
      vRefresh(this);
   */
      ClearUSDRef();
      USDPointDeleted = false;
   }
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::vNew(TObject *Sender)
{
   CreateNode(3);
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::vRefresh(TObject *Sender)
{
   TreeView1->OnChange=NULL;
   TreeView1->OnChanging=NULL;
   TreeView1->Items->BeginUpdate();
   TreeView1->Items->Clear();
   TreeView1->Items->EndUpdate();
   if(ReadTreeNode(NULL)){
      if(TreeView1->Items->Count){
         TreeView1->OnChange=TreeView1Change;
         TreeView1->Selected=TreeView1->Items->Item[0];
         TreeView1->OnChanging=TreeView1Changing;
      }
   }else{
      TreeView1Change(TreeView1,NULL);
   }
   EditRec=false;
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::SaveCounter(TTreeNode *Node)
{
  TList *ls;
  if(((POINTSDIV*)Node->Data)->pcounter)
    ls=((POINTSDIV*)Node->Data)->pcounter;
  else
    return;
  TFormCounter::POINTCOUNT *PTreeTable;
  int id_point = ((POINTSDIV*)Node->Data)->tmpMid;
  dmMain->quMain->Params->Clear();
  dmMain->quMain->SQL->Text="begin "+SchemeName+"meters_pg.upd_p(:par1,to_date(:par2,'dd.mm.yyyy'),:par3,:par4,:par5,:par6,:par7,:par8,:par9,:par10,:par11,:par12); end;";
  for(int i=0; i <ls->Count; i++ ){
    PTreeTable=(TFormCounter::POINTCOUNT*)ls->Items[i];
    dmMain->quMain->ParamByName("par1")->AsInteger=id_point;
    dmMain->quMain->ParamByName("par2")->AsString=PTreeTable->date_count;
    dmMain->quMain->ParamByName("par3")->AsString=PTreeTable->MTRSN;
    dmMain->quMain->ParamByName("par4")->AsString=PTreeTable->DIGITS;
    dmMain->quMain->ParamByName("par5")->AsString=PTreeTable->MTYPE;
    dmMain->quMain->ParamByName("par6")->AsFloat=PTreeTable->MCURRENT;
    dmMain->quMain->ParamByName("par7")->AsInteger=PTreeTable->MPOWER;
    dmMain->quMain->ParamByName("par8")->AsInteger=PTreeTable->MYEAR;
    dmMain->quMain->ParamByName("par9")->AsInteger=PTreeTable->MQUARTER;
    dmMain->quMain->ParamByName("par10")->AsInteger=PTreeTable->MCONST;
    dmMain->quMain->ParamByName("par11")->AsFloat=PTreeTable->MCLASS;
    dmMain->quMain->ParamByName("par12")->AsInteger=PTreeTable->Entype;
    dmMain->quMain->Execute();
  }
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::SaveLoss(TTreeNode *Node)
{
  POINTLOSS *PTreeTable;
  if(!Node || !Node->Data)
    throw Exception(Reconst_smes20_32);
  POINTSDIV *p=(POINTSDIV*)Node->Data;
  TList *ls=p->ploss;
  try{
    if(ls){
      oqSaveLoss->SQL->Text=" \
        begin \
          if :par20=1 and :par1=0 then \
            "+SchemeName+"loss_pg.ins_p(:par2,:par3,:par4,:par5,:par6,:par7,:par8,:par9,:par10,:par11,:par12,:par13,:par14,:par15,:par16,:par17,:par18,:par21,:par22,:par1); \
          elsif :par20=1 then \
            "+SchemeName+"loss_pg.upd_p(:par1,:par2,:par3,:par4,:par5,:par6,:par7,:par8,:par9,:par10,:par11,:par12,:par13,:par14,:par15,:par16,:par17,:par18,:par21,:par22); \
          else \
            "+SchemeName+"loss_pg.insupd_p(:par1,:par19,:par17);\
          end if; \
          "+SchemeName+"loss_pg.setparamtime_p(:par1, :par23, :par24, :par25); \
        end;";
      for(int i=0;i<ls->Count;i++){
        if(((POINTLOSS*)ls->Items[i])->editing){
          PTreeTable=(POINTLOSS*)ls->Items[i];
          oqSaveLoss->ParamByName("par1")->ParamType=ptInputOutput;
          oqSaveLoss->ParamByName("par1")->DataType=ftInteger;
          oqSaveLoss->ParamByName("par1")->AsInteger=PTreeTable->nconnectionparam;
          oqSaveLoss->ParamByName("par2")->AsInteger=p->tmpMid;
          if(PTreeTable->indic[0]>-1)
            oqSaveLoss->ParamByName("par3")->AsString=PTreeTable->vname;
          else
            oqSaveLoss->ParamByName("par3")->Clear();
          if(PTreeTable->indic[1]>-1)
            oqSaveLoss->ParamByName("par4")->AsFloat=PTreeTable->nsn;
          else
            oqSaveLoss->ParamByName("par4")->Clear();
          if(PTreeTable->indic[2]>-1)
            oqSaveLoss->ParamByName("par5")->AsFloat=PTreeTable->nsh;
          else
            oqSaveLoss->ParamByName("par5")->Clear();
          if(PTreeTable->indic[3]>-1)
            oqSaveLoss->ParamByName("par6")->AsFloat=PTreeTable->ndeltapidling;
          else
            oqSaveLoss->ParamByName("par6")->Clear();
          if(PTreeTable->indic[4]>-1)
            oqSaveLoss->ParamByName("par7")->AsFloat=PTreeTable->ndeltapsc;
          else
            oqSaveLoss->ParamByName("par7")->Clear();
          if(PTreeTable->indic[5]>-1)
            oqSaveLoss->ParamByName("par8")->AsFloat=PTreeTable->niidling;
          else
            oqSaveLoss->ParamByName("par8")->Clear();
          if(PTreeTable->indic[6]>-1)
            oqSaveLoss->ParamByName("par9")->AsFloat=PTreeTable->nusc;
          else
            oqSaveLoss->ParamByName("par9")->Clear();
          if(PTreeTable->indic[7]>-1)
            oqSaveLoss->ParamByName("par10")->AsFloat=PTreeTable->nro;
          else
            oqSaveLoss->ParamByName("par10")->Clear();
          if(PTreeTable->indic[8]>-1)
            oqSaveLoss->ParamByName("par11")->AsFloat=PTreeTable->nxo;
          else
            oqSaveLoss->ParamByName("par11")->Clear();
          if(PTreeTable->indic[9]>-1)
            oqSaveLoss->ParamByName("par12")->AsFloat=PTreeTable->nl;
          else
            oqSaveLoss->ParamByName("par12")->Clear();
          if(PTreeTable->indic[10]>-1)
            oqSaveLoss->ParamByName("par13")->AsFloat=PTreeTable->nun;
          else
            oqSaveLoss->ParamByName("par13")->Clear();
          if(PTreeTable->indic[11]>-1)
            oqSaveLoss->ParamByName("par14")->AsFloat=PTreeTable->nenergypercent;
          else
            oqSaveLoss->ParamByName("par14")->Clear();
          if(PTreeTable->indic[12]>-1)
            oqSaveLoss->ParamByName("par15")->AsInteger=PTreeTable->nworkinghours;
          else
            oqSaveLoss->ParamByName("par15")->Clear();
          if(PTreeTable->indic[13]>-1)
            oqSaveLoss->ParamByName("par16")->AsInteger=PTreeTable->nfullhours;
          else
            oqSaveLoss->ParamByName("par16")->Clear();
          oqSaveLoss->ParamByName("par17")->AsInteger=PTreeTable->nnotincludeconsump;
          if(PTreeTable->indic[14]>-1)
            oqSaveLoss->ParamByName("par18")->AsInteger=PTreeTable->nparallelconnection;
          else
            oqSaveLoss->ParamByName("par18")->Clear();
          oqSaveLoss->ParamByName("par19")->AsInteger=PTreeTable->mid;
          oqSaveLoss->ParamByName("par20")->AsInteger=PTreeTable->nsobst;
          if(PTreeTable->indic[15]>-1)
            oqSaveLoss->ParamByName("par21")->AsFloat=PTreeTable->nrenergypercent;
          else
          oqSaveLoss->ParamByName("par21")->Clear();
          oqSaveLoss->ParamByName("par22")->AsInteger=PTreeTable->nprocent;
          for(int z=23;z<=25;z++){
            oqSaveLoss->ParamByName("par"+IntToStr(z))->Table=true;
            oqSaveLoss->ParamByName("par"+IntToStr(z))->Length=1;
          //  oqSaveLoss->ParamByName("par"+IntToStr(z))->Clear();

          }
          oqSaveLoss->ParamByName("par23")->ItemAsInteger[1]=0;
          oqSaveLoss->ParamByName("par24")->ItemAsFloat[1]=0;
          oqSaveLoss->ParamByName("par25")->ItemAsFloat[1]=0;  
          if(PTreeTable->pwtimeinfo){
            for( int j=1; j<= PTreeTable->pwtimeinfo->Count; j++){
              TTimeInfo* pti=(TTimeInfo*)PTreeTable->pwtimeinfo->Items[j-1];
              for(int z=23;z<=25;z++)
                oqSaveLoss->ParamByName("par"+IntToStr(z))->Length=j;
              oqSaveLoss->ParamByName("par23")->ItemAsInteger[j]=pti->nperiod;
              if(pti->indic[0]>-1)
                oqSaveLoss->ParamByName("par24")->ItemAsFloat[j]=pti->f1;
              else
                oqSaveLoss->ParamByName("par24")->ItemClear(j);
              if(pti->indic[1]>-1)
                oqSaveLoss->ParamByName("par25")->ItemAsFloat[j]=pti->f2;
              else
                oqSaveLoss->ParamByName("par25")->ItemClear(j);
            }
          }
          oqSaveLoss->Execute();
          PTreeTable->tmpnconnectionparam=oqSaveLoss->ParamByName("par1")->AsInteger;
        }
      }
    }
    //удаление
	//GRB ADD 16.04.2020 - test trouble ODAC
    dmMain->quMain->Params->Clear();
    //END ADD 

    dmMain->quMain->SQL->Text="begin "+SchemeName+"loss_pg.del_p(:par1,:par2); end;";
    for(int i=0; i <p->countdelloss; i++){
      dmMain->quMain->ParamByName("par1")->AsInteger=p->delloss[i].nconnectionparam;
      dmMain->quMain->ParamByName("par2")->AsInteger=p->delloss[i].mid;
      dmMain->quMain->Execute();
    }
  }catch (Exception&e){
    Application->ShowException(&e);
  }
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::vSave(TObject *Sender)
{
  bool b=true;
  if((Access!=accWrite)||!EditRec)
    return;
  TreeView1Changing(TreeView1,TreeView1->Selected,b);
  if(!b)
     return;

  TTreeNode *Node=NULL;
  POINTSDIV *PTreeTable;

  try{
	//GRB ADD 16.04.2020 - test trouble ODAC
    dmMain->quMain->Params->Clear();
    //END ADD
    dmMain->quMain->SQL->Text="declare \
                   ln_34 NUMBER default :par34; \
                   ln_40 NUMBER default :par40; \
                   ln_52 NUMBER default :par52; \
                 begin \
                 if ln_34=0 then \
                    ln_34 := NULL; \
                 end if; \
                 if ln_40=0 then \
                    ln_40 := NULL; \
                 end if; \
                 if ln_52=0 then \
                    ln_52 := NULL; \
                 end if; \
                 if :par5=2   then\
                    if :par1>0 then \
                      "+SchemeName+"editfeedergroup_pg.upd_p(:par1,:par2,:par3,:par4,:par60,:par61,:par62); \
                    else \
                      "+SchemeName+"editfeedergroup_pg.ins_p(:par2,:par3,:par4,:par60,:par61,:par62,:par1); \
                    end if; \
                 end if; \
                 if :par5=3 or :par5=4  then\
                    if :par1>0 then \
                      "+SchemeName+"editfeeders_pg.upd_p(:par1,:par2,:par5,:par3,:par4,:par6,:par7,:par8,:par9,:par10,:par11,:par12,:par13,:par14,:par15,:par16,:par17,:par18,:par19,:par20,:par21,:par22,:par23,:par24,:par25,:par26,ln_34,:par35,:par37,:par38,:par39,ln_40,:par41,:par42,:par43,:par44,:par45,:par46,:par47,:par48,:par50,:par51,ln_52,:par53,:par54, :par55, :par56 ,:par57,:par58,:par59,:par60,:par61,:par62); \
                    else \
                      "+SchemeName+"editfeeders_pg.ins_p(:par2,:par5,:par3,:par4,:par6,:par7,:par8,:par9,:par10,:par11,:par12,:par13,:par14,:par15,:par16,:par17,:par18,:par19,:par20,:par21,:par22,:par23,:par24,:par25,:par26,ln_34,:par35,:par37,:par38,:par39,ln_40,:par41,:par42,:par43,:par44,:par45,:par46,:par47,:par48,:par50,:par51,ln_52,:par53,:par54, :par55, :par56,:par57,:par58,:par59,:par60,:par61,:par62,:par1); \
                    end if; \
                    "+SchemeName+"editfeeders_pg.setaddparam(:par1,:par27,:par28,:par29,:par30,:par31,:par32,:par33,:par36,:par49); \
                 end if; \
                end;";
    Node=TreeView1->Items->GetFirstNode();
    while(Node){
      if(Node->Data&&((POINTSDIV*)Node->Data)->editing){
        PTreeTable=(POINTSDIV*)Node->Data;
        dmMain->quMain->ParamByName("par1")->ParamType=ptInputOutput;
        dmMain->quMain->ParamByName("par1")->DataType=ftInteger;
        dmMain->quMain->ParamByName("par1")->AsInteger=PTreeTable->Mid;
        //Тут ошибка при работе с ОДАС 6.75 - при передаче парент - ID как AsInteger он приходит в процедуру как NULL, а раньше для ОДАКа 5.7 это работало
        //Но если поставить галку
        //Problemmed code here
        /*  if(Node->Parent && Node->Parent->Data)*/   //эта пурга осталась от старого и расскоментировать её НЕ НАДО
        //dmMain->quMain->ParamByName("par2")->AsInteger=((POINTSDIV*)Node->Parent->Data)->tmpMid;
        /*   else
        dmMain->quMain->ParamByName("par2")->Clear();*/ //тоже огрызок
        //End Problem

        //GRB 20.10.2020 TRY 2 FIX - от этот вариант решения проблемы надо распространить среди усех вариантов
        long test = (long) ((POINTSDIV*)Node->Parent->Data)->tmpMid;
        TOraNumber* testNumber = new TOraNumber();
        testNumber->AsInteger = ((POINTSDIV*)Node->Parent->Data)->tmpMid;
        dmMain->quMain->ParamByName("par2")->AsNumber=testNumber;
        //END TRY

        dmMain->quMain->ParamByName("par3")->AsString=PTreeTable->Name;
        dmMain->quMain->ParamByName("par4")->AsString=PTreeTable->Short_Name;
        dmMain->quMain->ParamByName("par5")->AsInteger=PTreeTable->Type;
        dmMain->quMain->ParamByName("par6")->AsInteger=PTreeTable->ER_POSITION;
        dmMain->quMain->ParamByName("par7")->AsInteger=PTreeTable->Q1_POSITION;
        dmMain->quMain->ParamByName("par8")->AsInteger=PTreeTable->ED_POSITION;
        dmMain->quMain->ParamByName("par9")->AsInteger=PTreeTable->Q3_POSITION;
        dmMain->quMain->ParamByName("par10")->AsInteger=PTreeTable->SMART;
        dmMain->quMain->ParamByName("par11")->AsInteger=PTreeTable->Q1234;
        dmMain->quMain->ParamByName("par12")->AsInteger=PTreeTable->CANAL;
        dmMain->quMain->ParamByName("par13")->AsString=PTreeTable->CELLNUM;
        dmMain->quMain->ParamByName("par14")->AsFloat=PTreeTable->POWER1;
        dmMain->quMain->ParamByName("par15")->AsFloat=PTreeTable->CURRENT1;
        dmMain->quMain->ParamByName("par16")->AsFloat=PTreeTable->CURRENT2;
        dmMain->quMain->ParamByName("par17")->AsFloat=PTreeTable->KC;
        if(PTreeTable->indic[0]>-1)
          dmMain->quMain->ParamByName("par18")->AsInteger=PTreeTable->Tag;
        else
          dmMain->quMain->ParamByName("par18")->Clear();
        dmMain->quMain->ParamByName("par19")->AsString=PTreeTable->v_info;
        dmMain->quMain->ParamByName("par20")->AsFloat=PTreeTable->POWER2;
        dmMain->quMain->ParamByName("par21")->AsFloat=PTreeTable->MeterKC;
        dmMain->quMain->ParamByName("par22")->AsInteger=PTreeTable->nabs;
        dmMain->quMain->ParamByName("par23")->AsInteger=PTreeTable->ncalcbill;
        dmMain->quMain->ParamByName("par24")->AsInteger=PTreeTable->ncalcmonth;
        dmMain->quMain->ParamByName("par25")->AsInteger=PTreeTable->ninverted;
        dmMain->quMain->ParamByName("par26")->AsInteger=PTreeTable->nswitch;
        dmMain->quMain->ParamByName("par27")->AsInteger=PTreeTable->nlosstype;
        if(PTreeTable->indic[1]>-1)
          dmMain->quMain->ParamByName("par28")->AsFloat=PTreeTable->nwh;
        else
          dmMain->quMain->ParamByName("par28")->Clear();
        if(PTreeTable->indic[2]>-1)
          dmMain->quMain->ParamByName("par29")->AsFloat=PTreeTable->nfh;
        else
          dmMain->quMain->ParamByName("par29")->Clear();
        if(PTreeTable->indic[3]>-1)
          dmMain->quMain->ParamByName("par30")->AsFloat=PTreeTable->nlineloss;
        else
          dmMain->quMain->ParamByName("par30")->Clear();
        if(PTreeTable->indic[4]>-1)
          dmMain->quMain->ParamByName("par31")->AsFloat=PTreeTable->nlineloss;
        else
          dmMain->quMain->ParamByName("par31")->Clear();
        if(PTreeTable->indic[5]>-1)
          dmMain->quMain->ParamByName("par32")->AsFloat=PTreeTable->ntrrloss;
        else
          dmMain->quMain->ParamByName("par32")->Clear();
        dmMain->quMain->ParamByName("par33")->AsInteger=PTreeTable->nrecompens;
        dmMain->quMain->ParamByName("par34")->AsInteger=PTreeTable->USDMid;
        dmMain->quMain->ParamByName("par35")->AsInteger=PTreeTable->nblock;
        dmMain->quMain->ParamByName("par36")->AsInteger=PTreeTable->ncalcpointtype;
        dmMain->quMain->ParamByName("par37")->AsInteger=PTreeTable->DataAbsence;
        if(PTreeTable->indCommControl>-1)
          dmMain->quMain->ParamByName("par38")->AsInteger=PTreeTable->CommControl;
        else
          dmMain->quMain->ParamByName("par38")->Clear();
        if(PTreeTable->indTechControl>-1)
          dmMain->quMain->ParamByName("par39")->AsInteger=PTreeTable->TechControl;
        else
          dmMain->quMain->ParamByName("par39")->Clear();
        dmMain->quMain->ParamByName("par40")->AsInteger=PTreeTable->nMainPoint;
        dmMain->quMain->ParamByName("par41")->AsString=PTreeTable->verifyParam;
        dmMain->quMain->ParamByName("par42")->AsString=PTreeTable->AddParams;
        dmMain->quMain->ParamByName("par43")->AsString=PTreeTable->ImportCode;
        dmMain->quMain->ParamByName("par44")->AsInteger=PTreeTable->nblocktime;
        dmMain->quMain->ParamByName("par45")->AsString=PTreeTable->vCode;
//GRB ADD 04.10.2022
        bool was_first_mess = true;
        if ((strlen(PTreeTable->Name)>119)&&(strlen(PTreeTable->Short_Name)==0)&&(was_first_mess)){
            AnsiString Language;
            was_first_mess = false;
            TRegistry *Reg = new TRegistry(KEY_READ);
            AnsiString text = "Размер поля 'Имя' у элемента с mid = "+IntToStr(PTreeTable->Mid)+" превышает 120 символов.\n Рекомендуется завести поле 'Краткое имя' для корректного отображения в отчетных данных.";
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
            if (Language =="UKR") text = "Розмір поля 'Iм'я' у елемента з mid =  "+IntToStr(PTreeTable->Mid)+" перевищує 120 символів.\n Рекомендується завести поле 'Коротке ім'я' для коректного відображення у звітних даних";
            MessageBox(Handle,text.c_str(), Caption.c_str(),MB_OK);
         }
        //END ADD
        //AND ADD
		//GRB ADD 05.07.2021
        bool chechVeridiAddParam = checkVerifyDailyByFormat(PTreeTable->verifyDay);
        if (!chechVeridiAddParam){
            AnsiString Language;
            TRegistry *Reg = new TRegistry(KEY_READ);
            AnsiString text = "Некорректный формат поля 'Параметры верификации суточных по ГН' для точки учёта с mid = "+IntToStr(PTreeTable->Mid)+"\n"+"Сохранение отменено!";

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
            if (Language =="UKR") text = "Некоректний формат поля 'Параметри верифікації добових по ГН' для точки обліку с mid = "+IntToStr(PTreeTable->Mid)+"\n"+"Збереження скасовано!";
            MessageBox(Handle,text.c_str(), Caption.c_str(),MB_OK|MB_ICONINFORMATION);
        return;
         }
        //END ADD
		
        dmMain->quMain->ParamByName("par46")->AsString=PTreeTable->verifyDay;
        dmMain->quMain->ParamByName("par47")->AsFloat=PTreeTable->classTN;
        dmMain->quMain->ParamByName("par48")->AsFloat=PTreeTable->classTT;
        dmMain->quMain->ParamByName("par49")->AsInteger=PTreeTable->Group;
        dmMain->quMain->ParamByName("par50")->AsInteger=PTreeTable->ntimezonew;
        dmMain->quMain->ParamByName("par51")->AsInteger=PTreeTable->ntimezones;
        dmMain->quMain->ParamByName("par52")->AsInteger=PTreeTable->OppositeMid;
        dmMain->quMain->ParamByName("par53")->AsInteger=PTreeTable->norder;
        dmMain->quMain->ParamByName("par54")->AsInteger=PTreeTable->integr;
        dmMain->quMain->ParamByName("par55")->AsInteger=PTreeTable->NLockSwitch;
        dmMain->quMain->ParamByName("par56")->AsInteger= PTreeTable->nDataWithOB;
        dmMain->quMain->ParamByName("par57")->AsInteger= PTreeTable->rescanal;
        dmMain->quMain->ParamByName("par58")->AsString=PTreeTable->vnote;
        dmMain->quMain->ParamByName("par59")->AsString=PTreeTable->vaccount;

        //GRB ADD 12.06.2019
        dmMain->quMain->ParamByName("par60")->AsString = PTreeTable->eic_info.mms;
        dmMain->quMain->ParamByName("par61")->AsString = PTreeTable->eic_info.veic_code;
        dmMain->quMain->ParamByName("par62")->AsString = PTreeTable->eic_info.c_type;
        //END ADD
        dmMain->quMain->Execute();
        PTreeTable->tmpMid=dmMain->quMain->ParamByName("par1")->AsInteger;
		/*if (testNumber!=NULL){
                delete[] testNumber;
                delete testNumber;
        } */
      }
      Node=Node->GetNext();
    }
    //Удаление
    //GRB ADD 16.04.2020 - test trouble ODAC
    dmMain->quMain->Params->Clear();
    //END ADD
    dmMain->quMain->SQL->Text="begin "+SchemeName+"editfeeders_pg.del_p(:par1); end;";
    for(int i=0;i<CountPoints_Del;i++){
      //dmMain->quMain->ParamByName("par1")->AsInteger=nPoints_Del[i];
      //GRB 20.10.2020 TRY 2 FIX - от этот вариант решения проблемы надо распространить среди усех вариантов
        TOraNumber* testNumberDel = new TOraNumber();
        testNumberDel->AsInteger = (long) nPoints_Del[i];
        dmMain->quMain->ParamByName("par1")->AsNumber=testNumberDel;
      //END TRY
      dmMain->quMain->Execute();
      /*if (testNumberDel!=NULL){
                delete[] testNumberDel;
                delete testNumberDel;
      } */
    }
    //Сохранение счетчиков
    Node=TreeView1->Items->GetFirstNode();
    while(Node){
     if(Node->Data&&((POINTSDIV*)Node->Data)->editcount==1)
        SaveCounter(Node);
     Node=Node->GetNext();
    }
    //Сохранение остального
    Node=TreeView1->Items->GetFirstNode();
    while(Node){
      if(Node->Data&&((POINTSDIV*)Node->Data)->editloss==1)
        SaveLoss(Node);
      if(Node->Data&&((POINTSDIV*)Node->Data)->edittimeinfo==1)
        SavePointTimeInfo(Node);
      if(Node->Data&&((POINTSDIV*)Node->Data)->editcalcparam==1)
        SavePointCalcParam(Node);
      Node=Node->GetNext();
    }



   dmMain->quMain->Params->Clear();
   dmMain->quMain->SQL->Text="begin "+SchemeName+"editfeeders_pg.upd_green;end;";
   dmMain->quMain->Execute();

   CountPoints_Del=0;
   dmMain->orases->Commit();
   //Очистка признаков редактирования
   Node=TreeView1->Items->GetFirstNode();
   while(Node){
      if(Node->Data&&((POINTSDIV*)Node->Data)->editing){
        PTreeTable=(POINTSDIV*)Node->Data;
        PTreeTable->editing=0;
        PTreeTable->editcount=0;
        PTreeTable->Mid=PTreeTable->tmpMid;
        PTreeTable->countdelloss=0;
        PTreeTable->editloss=0;
        PTreeTable->edittimeinfo=0;
        PTreeTable->editcalcparam=0;
        if(PTreeTable->ploss){
         for(long i=0;i<PTreeTable->ploss->Count;i++){
           POINTLOSS *pl=(POINTLOSS *)PTreeTable->ploss->Items[i];
           pl->nconnectionparam=pl->tmpnconnectionparam;
           pl->editing=0;
         }
        }
      }
      Node=Node->GetNext();
    }
    EditRec=false;
    Node=TreeView1->Items->GetFirstNode();
    while(Node){
      if(Node->Data && ((POINTSDIV*)Node->Data)->fUSD)
         ((POINTSDIV*)Node->Data)->fUSD = false;
      Node=Node->GetNext();
    }
    TreeView1Change(TreeView1,TreeView1->Selected);
  }catch (Exception &exception){
    dmMain->orases->Rollback();
  	Application->ShowException(&exception);
    if(Node)
      TreeView1->Selected=Node;
  }
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::edDoubleKeyPress(TObject *Sender,
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
void __fastcall TFormEditFiders::edLongKeyPress(TObject *Sender, char &Key)
{
#define Sender ((TEdit*)Sender)
  AnsiString S=(AnsiString)Key;
  AnsiString S1="0123456789\b\r";
  if(!S1.Pos(S)){
    Key=NULL;
    Beep();
    return;
  }
#undef Sender
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::tvMainExpCol(TObject *Sender,
      TTreeNode *Node)
{
 if(!Node||!Node->Data)
 return;
  if(((POINTSDIV*)Node->Data)->Type!=3&&((POINTSDIV*)Node->Data)->Type!=4){
    if(Node->Expanded)
     {
        Node->ImageIndex = 5;
        Node->SelectedIndex = 5;
     }
    else
     {
        Node->ImageIndex = 4;
        Node->SelectedIndex = 4;
     }
  }
}
//---------------------------------------------------------------------------

bool __fastcall TFormEditFiders::AcceptNode(TTreeNode*accNode,TTreeNode*srcNode)
{
    TShiftState State;
    POINTSDIV* p=NULL;//Текущее

    try{
        if(Access==accRead)
            throw Exception(Reconst_smes20_33);
        editOperation = opNone;
        if(GetKeyState(VK_CONTROL)&0x8000)
            State<<ssCtrl;
        if(GetKeyState(VK_SHIFT)&0x8000)
            State<<ssShift;
        // проверка на наличие данных в точках
        if(!srcNode||!srcNode->Data||((POINTSDIV*)srcNode->Data)->Type==1||
            !accNode || !accNode->Data || srcNode==accNode)
            return false;

        p=(POINTSDIV*)accNode->Data;
        // анализ операции
        if(State.Contains(ssCtrl)){
            if((p->Type==2||(p->Type==4 && (((POINTSDIV*)srcNode->Data)->Type==3||((POINTSDIV*)srcNode->Data)->Type==4))) && !accNode->HasAsParent(srcNode)){
                editOperation = opCopy;
                return true;
            }
            if(p->Type==3 && p->SMART && ((POINTSDIV*)srcNode->Data)->Type==3){
                editOperation = opUSDSet;
                return true;
            }
        }
        if(State.Contains(ssShift)){
            if((p->Type==2||(p->Type==4 && (((POINTSDIV*)srcNode->Data)->Type==3||((POINTSDIV*)srcNode->Data)->Type==4))) && !accNode->HasAsParent(srcNode)){
                editOperation = opCopy;
                return true;

            }
            if(p->Type==3 && ((POINTSDIV*)srcNode->Data)->Type==3){
                editOperation = opMainSet;
                return true;
            }
        }
        if(srcNode->Parent!=accNode && !accNode->HasAsParent(srcNode))
            if(p->Type==2||
               (p->Type==4 && (((POINTSDIV*)srcNode->Data)->Type==3||((POINTSDIV*)srcNode->Data)->Type==4))||
               (p->Type==1 && ((POINTSDIV*)srcNode->Data)->Type==2)){
              editOperation = opMove;
              return true;
            }
    }catch (Exception&e){
        Application->ShowException(&e);
        return false;
    }
    return false;
}
//---------------------------------------------------------------------------

void __fastcall TFormEditFiders::TreeView1DragOver(TObject *Sender,
      TObject *Source, int X, int Y, TDragState State, bool &Accept)
{
    Accept = AcceptNode(((TTreeView*)Sender)->GetNodeAt(X, Y),((TTreeView*)Source)->Selected);
    switch(editOperation){
    case opCopy:
        TreeView1->DragCursor = crDragCopy;
        break;
    case opMove:
        TreeView1->DragCursor = crDrag;
        break;
    case opUSDSet:
        TreeView1->DragCursor = crDragUsd;
        break;
    case opMainSet:
        TreeView1->DragCursor = crDragMain;
        break;
    case opNone:
        TreeView1->DragCursor = crDrag;
        break;
    }
}
//---------------------------------------------------------------------------

void __fastcall TFormEditFiders::changeNode(TTreeNode*Dst, TTreeNode*Src)
{
    TTreeNode*newNode;
    POINTSDIV* PTreeTable;
    long *mid;
    char *text;
 //   unsigned long cnt;
    bool b;

    try{
        Screen->Cursor=crHourGlass;
        if(!Src || !Src->Data) return;
        if(Dst && Dst->getFirstChild() && !Dst->getFirstChild()->Data)
            ReadTreeNode(Dst);

        switch(editOperation)
        {
        case opMainSet:
            mid = &((POINTSDIV*)Dst->Data)->Mid;
            text = &((POINTSDIV*)Src->Data)->MainText[0];
			//GRB ADD 16.04.2020 - test trouble ODAC
    	    dmMain->quMain->Params->Clear();
    	    //END ADD 
            dmMain->quMain->SQL->Text="SELECT "+SchemeName+"util_pg.get_pointname(:par1,2)text FROM DUAL";
            dmMain->quMain->ParamByName("par1")->AsInteger=(int)mid;
            dmMain->quMain->Execute();
            strcpy(text,dmMain->quMain->FieldByName("text")->AsString.c_str());

            ((POINTSDIV*)Src->Data)->nMainPoint = *mid;
            repl_delimiters(text, " ");
            if(!((POINTSDIV*)Src->Data)->editing)
                ((POINTSDIV*)Src->Data)->editing=1;
            ((POINTSDIV*)Dst->Data)->fMain = true;
            TreeView1->Selected = NULL;
            TreeView1->Selected = Src;
            break;
        case opUSDSet:
            mid = &((POINTSDIV*)Dst->Data)->Mid;
            text = &((POINTSDIV*)Src->Data)->USDText[0];
			//GRB ADD 16.04.2020 - test trouble ODAC
            dmMain->quMain->Params->Clear();
            //END ADD
            dmMain->quMain->SQL->Text="SELECT "+SchemeName+"util_pg.get_pointname(:par1,2)text FROM DUAL";
            dmMain->quMain->ParamByName("par1")->AsInteger=(int)mid;
            dmMain->quMain->Execute();
            strcpy(text,dmMain->quMain->FieldByName("text")->AsString.c_str());
            ((POINTSDIV*)Src->Data)->USDMid = *mid;
            repl_delimiters(text, " ");
            if(!((POINTSDIV*)Src->Data)->editing)
                ((POINTSDIV*)Src->Data)->editing=1;
            ((POINTSDIV*)Dst->Data)->fUSD = true;
            TreeView1->Selected = NULL;
            TreeView1->Selected = Src;
            break;
        case opMove:
            Src->MoveTo(Dst,naAddChild);
            if(!((POINTSDIV*)Src->Data)->editing)
                ((POINTSDIV*)Src->Data)->editing=1;
            break;
        case opCopy:
            b = true;
            TreeView1Changing(TreeView1, TreeView1->Selected, b);
            if(!b) return;
            POINTSDIV* PTreeTable = new POINTSDIV;
            memcpy(PTreeTable, (POINTSDIV*)Src->Data, sizeof(POINTSDIV));
            PTreeTable->Mid = PTreeTable->tmpMid = 0;
            PTreeTable->indic[6] = PTreeTable->indic[7] = -1;
            if(((POINTSDIV*)Src->Data)->pcounter){
                PTreeTable->pcounter = new TList();
                TList *src = ((POINTSDIV*)Src->Data)->pcounter;
                TList *dst = PTreeTable->pcounter;
                dst->Capacity = src->Capacity;
                for(int i=0; i < src->Count; i++){
                    TFormCounter::POINTCOUNT *pCounter = new TFormCounter::POINTCOUNT;
                    int n = dst->Add(pCounter);
                    memcpy(dst->Items[i], src->Items[i], sizeof(TFormCounter::POINTCOUNT));
                    ((TFormCounter::POINTCOUNT*)dst->Items[n])->id = 0;
                }
                PTreeTable->editcount = 1;
            }
            newNode = ((TTreeView*)Dst->TreeView)->Items->AddChildObject(Dst, PTreeTable->Name, PTreeTable);
            newNode->ImageIndex = Src->ImageIndex;
            newNode->SelectedIndex = Src->SelectedIndex;
            PTreeTable->editing = 1;
            if(PTreeTable->Type==3)
                PTreeTable->ploss=new TList;
            else
                PTreeTable->ploss=NULL;
            PTreeTable->pwtimeinfo=NULL;
            PTreeTable->pwcalcparam=NULL;
            PTreeTable->countdelloss=0;
            PTreeTable->editloss=0;
            PTreeTable->edittimeinfo=0;
            PTreeTable->editcalcparam=0;
            if(Src->HasChildren)
                copyChildNodes(newNode, Src);
        }
        EditRec = true;
    }catch (Exception &exception){
  	    Application->ShowException(&exception);
    }
    Screen->Cursor=crDefault;//crArrow;
}
//---------------------------------------------------------------------------

void __fastcall TFormEditFiders::tvDragDrop(TTreeNode* Node, int onKey)
{
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::TreeView1DragDrop(TObject *Sender,
      TObject *Source, int X, int Y)
{
    TTreeNode*Dst = ((TTreeView*)Sender)->GetNodeAt(X, Y);
    TTreeNode*Src = ((TTreeView*)Sender)->Selected;
    if(!Src || !Src->Data)
        throw Exception(Reconst_smes20_34);
    changeNode(Dst, Src);
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::aNodeUpExecute(TObject *Sender)
{
      TTreeNode*ptn=TreeView1->Selected;
      TTreeNode*Node;
 // Ctrl+Up
         if(ptn->getPrevSibling()&&ptn->Data&&((POINTSDIV*)ptn->Parent->Data)->Type==4)
         {
          ptn->MoveTo(ptn->getPrevSibling(),naInsert);
          TreeView1Change(TreeView1,ptn);
        //  while(ptn->Parent&& ptn->Parent->Data&&((POINTSDIV*)ptn->Parent->Data)->Type==4)
            ptn=ptn->Parent;//Родительский

          Node = ptn->getFirstChild();

          while(Node&&(POINTSDIV*)Node->Data)
          {
            if(((POINTSDIV*)Node->Data)->norder!=Node->Index)
              {
               ((POINTSDIV*)Node->Data)->norder=Node->Index;
                 if(((POINTSDIV*)Node->Data)->editing!=1)
                    ((POINTSDIV*)Node->Data)->editing=1;
                  if(!EditRec) EditRec = true;
              }
           Node = Node->getNextSibling();
        }
      }
   }
//--------------------------------------------------------------------------------------------------
void __fastcall TFormEditFiders::aNodeDownExecute(TObject *Sender)
{
       TTreeNode*ptn=TreeView1->Selected;
       TTreeNode*Node;
 // Ctrl+Down
       if(ptn->getNextSibling()&&ptn->Data&&((POINTSDIV*)ptn->Parent->Data)->Type==4)
        {
          ptn->getNextSibling()->MoveTo(ptn,naInsert);
          TreeView1Change(TreeView1,ptn);
         // while(ptn->Parent&& ptn->Parent->Data&&((POINTSDIV*)ptn->Parent->Data)->Type==4)
            ptn=ptn->Parent;//Родительский
            
           Node = ptn->getFirstChild();

          while(Node&&(POINTSDIV*)Node->Data)
          {
            if(((POINTSDIV*)Node->Data)->norder!=Node->Index)
              {
               ((POINTSDIV*)Node->Data)->norder=Node->Index;
                 if(((POINTSDIV*)Node->Data)->editing!=1)
                    ((POINTSDIV*)Node->Data)->editing=1;
                  if(!EditRec) EditRec = true;
              }
           Node = Node->getNextSibling();
        }
     }
  }
//---------------------------------------------------------------------------


void __fastcall TFormEditFiders::vEditClick(TObject*Sender)
{
    TTreeView*tv = dynamic_cast<TTreeView*>(ActiveControl);
    if(tv && tv==TreeView1){
        mnPaste->Enabled = Clipboard()->HasFormat(CF_POINTS_TREENODE);
        mnCut->Enabled = tv->Selected;
        mnCopy->Enabled = tv->Selected;
        mnDelete->Enabled = tv->Selected;
        mnSelect->Enabled = false;
    }else
        TMainForm::vEditClick(Sender);
}
//---------------------------------------------------------------------------

void __fastcall TFormEditFiders::vAnyEditClick(TObject* Sender)
{
   TComponent *pMenu=dynamic_cast<TComponent*>(Sender);
   TTreeNode*selNode;
   TTreeView*tvControl = dynamic_cast<TTreeView*>(ActiveControl);
   Clipboard()->Open();
   if(tvControl)
   try{
      if(pMenu)
         switch (pMenu->Tag){
         case 1: // Cut
            Clipboard()->Clear();
            if(Clipboard()->HasFormat(CF_POINTS_TREENODE))
               ((TTreeNode*)Clipboard()->GetAsHandle(CF_POINTS_TREENODE))->Cut = false;
            tvControl->Selected->Cut = true;
            Clipboard()->SetAsHandle(CF_POINTS_TREENODE, (UINT)tvControl->Selected);
            break;
         case 2: // Copy
            Clipboard()->Clear();
            if(Clipboard()->HasFormat(CF_POINTS_TREENODE))
               ((TTreeNode*)Clipboard()->GetAsHandle(CF_POINTS_TREENODE))->Cut = false;
            Clipboard()->SetAsHandle(CF_POINTS_TREENODE, (UINT)tvControl->Selected);
            break;
         case 3: // Paste
            selNode = (TTreeNode*)Clipboard()->GetAsHandle(CF_POINTS_TREENODE);
            if(!selNode)
               break;
            if(AcceptNode(tvControl->Selected, selNode) &&
                (editOperation==opMove || editOperation==opCopy))
            {
                if(selNode->Cut){
                    Clipboard()->Clear();
                    editOperation = opMove;
                }else
                    editOperation = opCopy;
                changeNode(tvControl->Selected, selNode);
            }else{
               selNode->Cut = false;
               MessageBox(this->Handle, Reconst_smes20_35.c_str(),Caption.c_str(), MB_OK|MB_ICONINFORMATION);
            }
            break;
         case 4: // Delete
            vDelete(Sender);
            break;
         }
   }catch(Exception&e){
     Clipboard()->Close();
   }else{
      //GRB CHANGE 10.09.2020 - по требованию Донецкой ЖД  - даём возможность работать с буфером обмена текста в форме с тем чтобы не пропала возможность использовать Сtrl+c, Ctrl+V в контексте работы с узлами дерева
      // видимо изменение контекста клипбоарда привело к тому что стандартная обработка этого в Main.cpp вела себя некорректно
      /*TMainForm::vAnyEditClick(Sender);*/
      vAnyEditClickEditFiders (Sender);
      }
   Clipboard()->Close();
}
//---------------------------------------------------------------------------


void __fastcall TFormEditFiders::btInsGroupClick(TObject *Sender)
{
    tbTools->SetFocus();
  TTreeNode *sNode=TreeView1->Selected;
  if(!sNode||!sNode->Data)
    return;
  POINTSDIV *PTreeTable=(POINTSDIV*)sNode->Data;

  if(PTreeTable->Type!=3){
    PTreeTable=new POINTSDIV;
    ZeroMemory(PTreeTable, sizeof(POINTSDIV));
    strcpy(PTreeTable->Name,Reconst_smes20_36.c_str());
    PTreeTable->Type=2;
    PTreeTable->editing=1;
    sNode->Expand(false);
    sNode=TreeView1->Items->AddChildObject(sNode,PTreeTable->Name,PTreeTable);
    sNode->ImageIndex=4;
    sNode->SelectedIndex=4;
    EditRec=true;
    TreeView1->Selected=sNode;
    SetFocusInFirst();
  }
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::btEditClick(TObject *Sender)
{
    tbTools->SetFocus();
    TTreeNode *sNode=TreeView1->Selected;
    if(!sNode||!sNode->Data)
        return;
    TFormCounter *ff= new TFormCounter(this,((POINTSDIV *)sNode->Data)->pcounter,((POINTSDIV *)sNode->Data)->Mid,((POINTSDIV *)sNode->Data)->Name);
    ff->Access = Access;
    if(ff->ShowModal()==mrOk){
        if(ff->editRecord)
        {
            ((POINTSDIV *)sNode->Data)->pcounter=ff->List_count;
            ((POINTSDIV *)sNode->Data)->editcount=1;
            EditRec=true;
        }
        else
            ((POINTSDIV *)sNode->Data)->editcount=0;
    }
    delete ff;
    ShowCounter(sNode);
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::ReplaceList(TObject *Sender,int type, AnsiString ss)
{
#define Sender ((TEdit*)Sender)
 TTreeNode *sNode=TreeView1->Selected;
 POINTSDIV *PTreeTable=(POINTSDIV*)sNode->Data;
 bool fl=false;
 if(CheckBox1->Checked)
   return;
 if((Sender->Text.IsEmpty() || Sender->Text.ToInt()==0))
 {
   if(PTreeTable->pcounter)
      for(int i=0;i<PTreeTable->pcounter->Count;i++)
         if(((TFormCounter::POINTCOUNT *)PTreeTable->pcounter->Items[i])->Entype==type)
            PTreeTable->pcounter->Remove(PTreeTable->pcounter->Items[i]);
 }
 if(!Sender->Text.IsEmpty() && Sender->Text.ToInt()!=0)
     {
      for(int i=0;i<PTreeTable->pcounter->Count;i++)
        if(((TFormCounter::POINTCOUNT *)PTreeTable->pcounter->Items[i])->Entype==type)
         fl=true;
        if(!fl){
         TFormCounter::POINTCOUNT TreeTable;
         strcpy(TreeTable.Name,((AnsiString)((POINTSDIV*)sNode->Data)->Name+ss).c_str());
         TreeTable.Entype=type;
         strcpy(TreeTable.date_count,DateToStr(Date()).c_str());
         strcpy(TreeTable.MTRSN,"");
         strcpy(TreeTable.DIGITS,"");
         strcpy(TreeTable.MTYPE,"");
         TreeTable.MCURRENT=0;
         TreeTable.Position=0;
         TreeTable.MPOWER=0;
         TreeTable.MCONST=0;
         TreeTable.MCLASS=0;
         TreeTable.MYEAR=0;
         TreeTable.MQUARTER=0;
         TFormCounter::POINTCOUNT *PCountTable=new TFormCounter::POINTCOUNT;
         memcpy(PCountTable,&TreeTable,sizeof(TFormCounter::POINTCOUNT));
         ((POINTSDIV*)sNode->Data)->pcounter->Add(PCountTable);
        }
     }
  ShowCounter(sNode);
#undef Sender
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::Edit3Exit(TObject *Sender)
{
 TTreeNode *sNode=TreeView1->Selected;
 if(!sNode||!sNode->Data)
    return;
 ReplaceList(Sender,1,Reconst_smes20_25);
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::Edit4Exit(TObject *Sender)
{
 TTreeNode *sNode=TreeView1->Selected;
 if(!sNode||!sNode->Data)
    return;
 ReplaceList(Sender,3,Reconst_smes20_26);
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::Edit5Exit(TObject *Sender)
{
 TTreeNode *sNode=TreeView1->Selected;
 if(!sNode||!sNode->Data)
    return;
 ReplaceList(Sender,2,Reconst_smes20_27);
}
//---------------------------------------------------------------------------

void __fastcall TFormEditFiders::Edit6Exit(TObject *Sender)
{
 TTreeNode *sNode=TreeView1->Selected;
 if(!sNode||!sNode->Data)
    return;
 ReplaceList(Sender,5,Reconst_smes20_28);
}
//---------------------------------------------------------------------------

void __fastcall TFormEditFiders::SetAccess(TAccess value)
{
   try{
   if(FAccess != value) {
      TMainForm::SetAccess(value);
      bool wr = value==accWrite;
      iaNew->Enabled = iaNew->Enabled&&wr;
      iaNewCalcNode->Enabled = iaNewCalcNode->Enabled&&wr;
      tbNew->Enabled = iaNew->Enabled;
      mAdd->Enabled = iaNew->Enabled;
      iaDelete->Enabled = iaDelete->Enabled&&wr;
//      aIns->Enabled = wr;
//      aAddGroup->Enabled = wr;
      aInsGroup->Enabled = aInsGroup->Enabled&&wr;
      btAddParam->Enabled = wr;
      btDelParam->Enabled = wr;
      btSetFormula->Enabled = wr;
      btSetTimeP->Enabled = wr;
      TEdit *ed;
      TMemo *me;
      TCheckBox *cb;
      TDBEdit *dbed;
      TDBCheckBox *dbcb;
      TComboBox *cbc;
      for(int i=0; i<ComponentCount; i++){
        ed=dynamic_cast<TEdit *>(Components[i]);
        if(ed){
          if(ed->Tag!=9)//Edit по жизни ReadOnly
             ed->ReadOnly = !wr;
          continue;
        }
        me=dynamic_cast<TMemo *>(Components[i]);
        if(me){
          me->ReadOnly = !wr;
          continue;
        }
        cb=dynamic_cast<TCheckBox *>(Components[i]);
        if(cb){
           cb->Enabled = wr;
           continue;
        }
        dbed=dynamic_cast<TDBEdit *>(Components[i]);
        if(dbed){
           dbed->ReadOnly = !wr;
           continue;
        }
        dbcb=dynamic_cast<TDBCheckBox *>(Components[i]);
        if(dbcb){
           dbcb->Enabled = wr;
           continue;
        }
        cbc=dynamic_cast<TComboBox *>(Components[i]);
        if(cbc){
           cbc->Enabled = wr;
           continue;
       }
     }
// Блокируем все поля ввода для параметров линий и тр-ров
        DBEdit1->ReadOnly=true;
        DBEdit2->ReadOnly=true;
        DBEdit3->ReadOnly=true;
        DBEdit4->ReadOnly=true;
        DBEdit5->ReadOnly=true;
        DBEdit6->ReadOnly=true;
        DBEdit7->ReadOnly=true;
        DBEdit8->ReadOnly=true;
        DBEdit9->ReadOnly=true;
        DBEdit15->ReadOnly=true;
   }
   }catch (Exception &ex){
                 MessageBox(Handle,"Не хватает памяти для работы с деревом(Валится в EditFiders::SetAccess). Закройте и откройте 2 раза по крестику текущую задачу",
            "Память не выделяется",MB_OK|MB_ICONINFORMATION);

   }
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::cbChange(TObject *Sender)
{
int mid;
  TTreeNode *sNode=TreeView1->Selected;
  if(!sNode||!sNode->Data||((POINTSDIV*)sNode->Data)->Type<3)
    return;
  if(((POINTSDIV*)sNode->Data)->editing!=2)
    ((POINTSDIV*)sNode->Data)->editing=2;
  EditRec=true;
  if(Sender==cbLossType)
    SetLossInterface();
  if(Sender==cbCalcType){
    SetCalcInterface();
    ((POINTSDIV*)sNode->Data)->ncalcpointtype = (long)cbCalcType->Items->Objects[cbCalcType->ItemIndex];
     int z=sNode->ImageIndex;
     sNode->ImageIndex=(cbCalcType->Items->Objects[cbCalcType->ItemIndex])?27:(((POINTSDIV*)sNode->Data)->Type==4)?26:0;
     sNode->SelectedIndex=(cbCalcType->Items->Objects[cbCalcType->ItemIndex])?27:(((POINTSDIV*)sNode->Data)->Type==4)?26:0;
     TreeView1->Selected=sNode;
     if(z!=sNode->ImageIndex)
       TreeView1->Invalidate();
  }
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::FormDestroy(TObject *Sender)
{
   delete VT_Data;
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::SetFocusInFirst()
{
  TTreeNode *sNode=TreeView1->Selected;
    if(sNode && sNode->Data &&((POINTSDIV*)sNode->Data)->Type==4){
        pcMain->ActivePage=tsMainSpec;
        Edit22->SetFocus();
        }
    else{
        pcMain->ActivePage=tsParam;
        Edit1->SetFocus();
        }


}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::SetLossInterface()
{
   paFormulaLoss->Visible=(cbLossType->ItemIndex==4);
   paFormulaLoss->Enabled=(cbLossType->ItemIndex==4);
   paSimpleLoss->Visible=(cbLossType->ItemIndex>0);
   paSimpleLoss->Enabled=(cbLossType->ItemIndex>0);
   DBCtrlGrid1->Visible=VT_Data&&!VT_Data->IsEmpty();
   SetButtonLossInterface();
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::SetCalcInterface()
{
  paCalcGroup->Enabled=((cbCalcType->ItemIndex>-1)&&(long)cbCalcType->Items->Objects[cbCalcType->ItemIndex]==5);
  paCalcGroup->Visible=paCalcGroup->Enabled;
  paCalcFormula->Enabled=((cbCalcType->ItemIndex>-1)&&(long)cbCalcType->Items->Objects[cbCalcType->ItemIndex]==6);
  paCalcFormula->Visible=paCalcFormula->Enabled;
 
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::btAddParamClick(TObject *Sender)
{
  if(!DBCtrlGrid1->Visible)
    DBCtrlGrid1->Visible=true;
  VT_Data->Append();
  DBEdit13->SetFocus();
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::btDelParamClick(TObject *Sender)
{
  POINTSDIV *p=(POINTSDIV*)TreeView1->Selected->Data;
  TList *list;
  if(VT_Data->State!=dsBrowse)
    VT_Data->Cancel();
  if(!VT_Data->IsEmpty())
  {
    if(p&&VT_Data->Fields->FieldByName("NCONNECTIONPARAM")->AsInteger>0)
    {
        int i=p->countdelloss;
        p->delloss[i].nconnectionparam=VT_Data->Fields->FieldByName("NCONNECTIONPARAM")->AsInteger;
        p->delloss[i].mid=VT_Data->Fields->FieldByName("NSOBST")->AsInteger?0:VT_Data->Fields->FieldByName("MID")->AsInteger;
        p->countdelloss=i+1;
    }
    list=((TList*)VT_Data->Fields->FieldByName("NTIMEINFO")->AsInteger);
    if(list)
    {//Задано время работы
        for(long i=0;i<list->Count;i++)
          delete (TTimeInfo *)list->Items[i];
        delete list;
    }
    // Проверяем Если параметры не пусты то удалять можно только в задаче ТР
    if(DBEdit1->Text.IsEmpty()&&DBEdit15->Text.IsEmpty()&&DBEdit2->Text.IsEmpty()&&DBEdit3->Text.IsEmpty())
      VT_Data->Delete();
    else
      Application->MessageBox(Reconst_smes20_37.c_str(),
                               Application->Title.c_str(),MB_OK|MB_ICONINFORMATION);
  }
  if(VT_Data->IsEmpty())
    DBCtrlGrid1->Visible=false;
  SetButtonLossInterface();
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::TableAfterEdit(TDataSet *DataSet)
{
  if(!TreeView1->Selected||!((POINTSDIV*)TreeView1->Selected->Data))
    return;
  VT_Data->Edit();
  VT_Data->FieldByName("NEDITING")->Value=1;
  SetFormulaLossInterface();
  SetButtonLossInterface();
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::TableAfterDelete(TDataSet *DataSet)
{
  if(!TreeView1->Selected||!((POINTSDIV*)TreeView1->Selected->Data))
    return;
  SetFormulaLossInterface();
  SetButtonLossInterface();
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::TableAfterInsert(TDataSet *DataSet)
{
  if(!TreeView1->Selected||!((POINTSDIV*)TreeView1->Selected->Data))
    return;
  VT_Data->FieldByName("NNOTINCLUDECONSUMP")->Value=0;
  VT_Data->FieldByName("NEDITING")->Value=1;
  VT_Data->FieldByName("NSOBST")->Value=1;
  VT_Data->FieldByName("NENERGYPERCENT")->Value=100;
  VT_Data->FieldByName("NRENERGYPERCENT")->Value=100;
  VT_Data->FieldByName("NPROCENT")->Value=0;
  VT_Data->FieldByName("LINF")->AsString="О";
  //VT_Data->FieldByName("MID")->Value=((POINTSDIV*)TreeView1->Selected->Data)->tmpMid;
  SetFormulaLossInterface();
  SetButtonLossInterface();
  PostData();
}
//---------------------------------------------------------------------------

void __fastcall TFormEditFiders::SetFormulaLossInterface()
{
   ((POINTSDIV*)TreeView1->Selected->Data)->editloss=1;
   ((POINTSDIV*)TreeView1->Selected->Data)->editing=2;
   EditRec=true;
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::SetButtonLossInterface()
{
   btDelParam->Enabled=((customer_id!=1&&customer_id!=51)&&(Access==accWrite)&&(!VT_Data->IsEmpty()));
   btSetFormula->Enabled=btDelParam->Enabled;
   btSetTimeP->Enabled = btSetFormula->Enabled;
//   btSetTimeP->Enabled=!VT_Data->IsEmpty();
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::DisplayLoss(TTreeNode *Node)
{
   if(!VT_Data)
     return;
   TDataSetNotifyEvent aDel=VT_Data->AfterDelete;
   TDataSetNotifyEvent aIns=VT_Data->AfterInsert;
   TDataSetNotifyEvent aEdit=VT_Data->AfterEdit;
   TDataSetNotifyEvent bPost=VT_Data->BeforePost;

   VT_Data->AfterDelete=NULL;
   VT_Data->AfterInsert=NULL;
   VT_Data->AfterEdit=NULL;
   VT_Data->BeforePost=NULL;
   dsMain->DataSet=NULL;

   VT_Data->First();
   while(!VT_Data->Eof)
   VT_Data->Delete();

   if(!Node||!Node->Data||!((POINTSDIV*)Node->Data)->ploss){
      dsMain->DataSet=VT_Data;
      VT_Data->AfterDelete=aDel;
      VT_Data->AfterInsert=aIns;
      VT_Data->AfterEdit=aEdit;
      return;
   }

   TList *list=((POINTSDIV*)Node->Data)->ploss;
   for(long i=0;i<list->Count;i++){
      POINTLOSS *p=(POINTLOSS *)list->Items[i];
      VT_Data->Append();
      VT_Data->Fields->FieldByName("NSOBST")->AsInteger = p->nsobst;
      VT_Data->Fields->FieldByName("VNAME")->AsString = p->vname;
      VT_Data->Fields->FieldByName("NCONNECTIONPARAM")->AsInteger = p->nconnectionparam;
      VT_Data->Fields->FieldByName("MID")->AsInteger = p->mid;
      if(p->indic[1]>-1)
         VT_Data->Fields->FieldByName("NSN")->AsFloat = p->nsn;
      else
         VT_Data->Fields->FieldByName("NSN")->Clear();
      if(p->indic[2]>-1)
         VT_Data->Fields->FieldByName("NSH")->AsFloat = p->nsh;
      else
         VT_Data->Fields->FieldByName("NSH")->Clear();
      if(p->indic[3]>-1)
         VT_Data->Fields->FieldByName("NDELTAPIDLING")->AsFloat = p->ndeltapidling;
      else
         VT_Data->Fields->FieldByName("NDELTAPIDLING")->Clear();
      if(p->indic[4]>-1)
         VT_Data->Fields->FieldByName("NDELTAPSC")->AsFloat = p->ndeltapsc;
      else
         VT_Data->Fields->FieldByName("NDELTAPSC")->Clear();
      if(p->indic[5]>-1)
         VT_Data->Fields->FieldByName("NIIDLING")->AsFloat = p->niidling;
      else
         VT_Data->Fields->FieldByName("NIIDLING")->Clear();
      if(p->indic[6]>-1)
         VT_Data->Fields->FieldByName("NUSC")->AsFloat = p->nusc;
      else
         VT_Data->Fields->FieldByName("NUSC")->Clear();
      if(p->indic[7]>-1)
         VT_Data->Fields->FieldByName("NRO")->AsFloat = p->nro;
      else
         VT_Data->Fields->FieldByName("NRO")->Clear();
      if(p->indic[8]>-1)
         VT_Data->Fields->FieldByName("NXO")->AsFloat = p->nxo;
      else
         VT_Data->Fields->FieldByName("NXO")->Clear();
      if(p->indic[9]>-1)
         VT_Data->Fields->FieldByName("NL")->AsFloat = p->nl;
      else
         VT_Data->Fields->FieldByName("NL")->Clear();
      if(p->indic[10]>-1)
         VT_Data->Fields->FieldByName("NUN")->AsFloat = p->nun;
      else
         VT_Data->Fields->FieldByName("NUN")->Clear();
      if(p->indic[11]>-1)
         VT_Data->Fields->FieldByName("NENERGYPERCENT")->AsFloat = p->nenergypercent;
      else
         VT_Data->Fields->FieldByName("NENERGYPERCENT")->Clear();

      if(p->indic[12]>-1)
         VT_Data->Fields->FieldByName("NWORKINGHOURS")->AsInteger = p->nworkinghours;
      else
         VT_Data->Fields->FieldByName("NWORKINGHOURS")->Clear();
      if(p->indic[13]>-1)
         VT_Data->Fields->FieldByName("NFULLHOURS")->AsInteger = p->nfullhours;
      else
         VT_Data->Fields->FieldByName("NFULLHOURS")->Clear();
      VT_Data->Fields->FieldByName("NNOTINCLUDECONSUMP")->AsInteger = p->nnotincludeconsump;
      if(p->indic[14]>-1)
         VT_Data->Fields->FieldByName("NPARALLELCONNECTION")->AsInteger = p->nparallelconnection;
      else
         VT_Data->Fields->FieldByName("NPARALLELCONNECTION")->Clear();
      if(p->indic[15]>-1)
         VT_Data->Fields->FieldByName("NRENERGYPERCENT")->AsFloat = p->nrenergypercent;
      else
         VT_Data->Fields->FieldByName("NRENERGYPERCENT")->Clear();
      VT_Data->Fields->FieldByName("NPROCENT")->AsInteger = p->nprocent;
      VT_Data->Fields->FieldByName("NTIMEINFO")->AsInteger = (int)p->pwtimeinfo;
      VT_Data->Fields->FieldByName("NEDITTIMEINFO")->AsInteger = p->edittimeinfo;
      VT_Data->Fields->FieldByName("NLIST")->AsInteger = (int)p;
      VT_Data->Fields->FieldByName("LINF")->AsString = p->linf;
      VT_Data->Post();
   }
   VT_Data->First();
   dsMain->DataSet=VT_Data;
   VT_Data->AfterDelete=aDel;
   VT_Data->AfterInsert=aIns;
   VT_Data->AfterEdit=aEdit;
   VT_Data->BeforePost=bPost;
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::SetLoss(TTreeNode *Node)
{
  if(VT_Data->State!=dsBrowse)
    VT_Data->Post();
  dsMain->DataSet=NULL;
  if(!Node||!Node->Data||!((POINTSDIV*)Node->Data)->ploss){
    dsMain->DataSet=VT_Data;
    return;
  }
  TList *list=((POINTSDIV*)Node->Data)->ploss;
  for(long i=0;i<list->Count;i++)
    delete (POINTLOSS *)list->Items[i];
  list->Clear();

  int i=0;
  VT_Data->First();
  while(!VT_Data->Eof){
    VT_Data->Next();
    i++;
  }
  list->Capacity=i;

  VT_Data->First();
  while(!VT_Data->Eof){
    POINTLOSS *p=new POINTLOSS;
    list->Add(p);
    p->editing=VT_Data->Fields->FieldByName("NEDITING")->AsInteger;
    p->nsobst=VT_Data->Fields->FieldByName("NSOBST")->AsInteger;
    strcpy(p->vname,VT_Data->Fields->FieldByName("VNAME")->AsString.c_str());
    p->nconnectionparam=VT_Data->Fields->FieldByName("NCONNECTIONPARAM")->AsInteger;
    p->tmpnconnectionparam=p->nconnectionparam;
    p->mid=VT_Data->Fields->FieldByName("MID")->AsInteger;
    if(VT_Data->Fields->FieldByName("NSN")->IsNull)
      p->indic[1]=-1;
    else
      p->nsn=VT_Data->Fields->FieldByName("NSN")->AsFloat;
    if(VT_Data->Fields->FieldByName("NSH")->IsNull)
      p->indic[2]=-1;
    else
      p->nsh=VT_Data->Fields->FieldByName("NSH")->AsFloat;
    if(VT_Data->Fields->FieldByName("NDELTAPIDLING")->IsNull)
      p->indic[3]=-1;
    else
      p->ndeltapidling=VT_Data->Fields->FieldByName("NDELTAPIDLING")->AsFloat;
    if(VT_Data->Fields->FieldByName("NDELTAPSC")->IsNull)
      p->indic[4]=-1;
    else
      p->ndeltapsc=VT_Data->Fields->FieldByName("NDELTAPSC")->AsFloat;
    if(VT_Data->Fields->FieldByName("NIIDLING")->IsNull)
      p->indic[5]=-1;
    else
      p->niidling=VT_Data->Fields->FieldByName("NIIDLING")->AsFloat;
    if(VT_Data->Fields->FieldByName("NUSC")->IsNull)
      p->indic[6]=-1;
    else
      p->nusc=VT_Data->Fields->FieldByName("NUSC")->AsFloat;
    if(VT_Data->Fields->FieldByName("NRO")->IsNull)
      p->indic[7]=-1;
    else
      p->nro=VT_Data->Fields->FieldByName("NRO")->AsFloat;
    if(VT_Data->Fields->FieldByName("NXO")->IsNull)
      p->indic[8]=-1;
    else
      p->nxo=VT_Data->Fields->FieldByName("NXO")->AsFloat;
    if(VT_Data->Fields->FieldByName("NL")->IsNull)
      p->indic[9]=-1;
    else
      p->nl=VT_Data->Fields->FieldByName("NL")->AsFloat;
    if(VT_Data->Fields->FieldByName("NUN")->IsNull)
      p->indic[10]=-1;
    else
      p->nun=VT_Data->Fields->FieldByName("NUN")->AsFloat;
    if(VT_Data->Fields->FieldByName("NENERGYPERCENT")->IsNull)
      p->indic[11]=-1;
    else
      p->nenergypercent=VT_Data->Fields->FieldByName("NENERGYPERCENT")->AsFloat;
    if(VT_Data->Fields->FieldByName("NWORKINGHOURS")->IsNull)
      p->indic[12]=-1;
    else
      p->nworkinghours=VT_Data->Fields->FieldByName("NWORKINGHOURS")->AsInteger;
    if(VT_Data->Fields->FieldByName("NFULLHOURS")->IsNull)
      p->indic[13]=-1;
    else
      p->nfullhours=VT_Data->Fields->FieldByName("NFULLHOURS")->AsInteger;
    p->nnotincludeconsump=VT_Data->Fields->FieldByName("NNOTINCLUDECONSUMP")->AsInteger;
    if(VT_Data->Fields->FieldByName("NPARALLELCONNECTION")->IsNull)
      p->indic[14]=-1;
    else
      p->nparallelconnection=VT_Data->Fields->FieldByName("NPARALLELCONNECTION")->AsInteger;
    if(VT_Data->Fields->FieldByName("NRENERGYPERCENT")->IsNull)
      p->indic[15]=-1;
    else
      p->nrenergypercent=VT_Data->Fields->FieldByName("NRENERGYPERCENT")->AsFloat;
    p->nprocent=VT_Data->Fields->FieldByName("NPROCENT")->AsInteger;
    strcpy(p->linf,VT_Data->Fields->FieldByName("LINF")->AsString.c_str());
    p->pwtimeinfo=(TList*)VT_Data->Fields->FieldByName("NTIMEINFO")->AsInteger;
    p->edittimeinfo=VT_Data->Fields->FieldByName("NEDITTIMEINFO")->AsInteger;
    VT_Data->Next();
  }
  VT_Data->First();
  dsMain->DataSet=VT_Data;
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::btSetTimeClick(TObject *Sender)
{
  TTreeNode *sNode=TreeView1->Selected;
  if(!sNode||!sNode->Data||((POINTSDIV*)sNode->Data)->Type<3)
    return;
  POINTSDIV *PTreeTable=(POINTSDIV*)sNode->Data;
  TTimeInfo *Pwtimeinfo;
  if(!PTreeTable->pwtimeinfo){
    if(PTreeTable->tmpMid){
    
      dmMain->oqCursor->Params->Clear();
      dmMain->oqCursor->SQL->Text="begin "+SchemeName+"editfeeders_pg.NACCPERIOD_p(:par1,:par2); end;";
      dmMain->oqCursor->ParamByName("par2")->ParamType = ptOutput;
      dmMain->oqCursor->ParamByName("par2")->DataType = ftCursor;
      dmMain->oqCursor->ParamByName("par1")->AsInteger= PTreeTable->tmpMid;
      dmMain->oqCursor->Execute();
      PTreeTable->pwtimeinfo = new TList();
      PTreeTable->pwtimeinfo->Capacity=1;
      while(!dmMain->oqCursor->Eof){
      Pwtimeinfo=new TTimeInfo;
      ZeroMemory(Pwtimeinfo,sizeof(TTimeInfo));
      Pwtimeinfo->nperiod=dmMain->oqCursor->FieldByName("NACCPERIOD")->AsInteger;
      if(!dmMain->oqCursor->FieldByName("NWORKINGHOURS")->IsNull){
      Pwtimeinfo->indic[0]=0;
      Pwtimeinfo->f1=dmMain->oqCursor->FieldByName("NWORKINGHOURS")->AsFloat;}
      else Pwtimeinfo->indic[0]=-1;
       if(!dmMain->oqCursor->FieldByName("NFULLHOURS")->IsNull){
      Pwtimeinfo->indic[1]=0;
      Pwtimeinfo->f2=dmMain->oqCursor->FieldByName("NFULLHOURS")->AsFloat;}
      else Pwtimeinfo->indic[1]=-1;
      PTreeTable->pwtimeinfo->Add(Pwtimeinfo);
      dmMain->oqCursor->Next();
      PTreeTable->pwtimeinfo->Capacity=PTreeTable->pwtimeinfo->Capacity+1;
      }
    }else
      PTreeTable->pwtimeinfo = new TList();
  }
  TfmWorkTime *f=new TfmWorkTime(this,PTreeTable->pwtimeinfo,(Access==accWrite)&&(customer_id!=1&&customer_id!=51));
  f->Caption=Reconst_smes20_38;
  if(f->ShowModal()==mrOk){
    PTreeTable->edittimeinfo=1;
    if(PTreeTable->editing!=2)
      PTreeTable->editing=2;
    EditRec=true;
  }
  delete f;
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::SavePointTimeInfo(TTreeNode *Node)
{
  if(!Node || !Node->Data)
    throw Exception(Reconst_smes20_39);
  TList *ls=((POINTSDIV*)Node->Data)->pwtimeinfo;
  oqSavePointTimeInfo->ParamByName("par1")->AsInteger=((POINTSDIV*)Node->Data)->tmpMid;
  for(int i=2;i<=4;i++){
    oqSavePointTimeInfo->ParamByName("par"+IntToStr(i))->Length=1;
    oqSavePointTimeInfo->ParamByName("par"+IntToStr(i))->Clear();
  }

  for(int i=1;(i<=ls->Count)&&(i<=SELECTCOUNT);i++){
    TTimeInfo * p=(TTimeInfo *)ls->Items[i-1];
    for(int j=2;j<=4;j++)
      oqSavePointTimeInfo->ParamByName("par"+IntToStr(j))->Length=i;
    oqSavePointTimeInfo->ParamByName("par2")->ItemAsInteger[i]=p->nperiod;
    if(p->indic[0]>-1)
      oqSavePointTimeInfo->ParamByName("par3")->ItemAsFloat[i]=p->f1;
    if(p->indic[1]>-1)
      oqSavePointTimeInfo->ParamByName("par4")->ItemAsFloat[i]=p->f2;
  }
  oqSavePointTimeInfo->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::btCalcParamClick(TObject *Sender)
{
    const dcnt=2;
    TTreeNode *sNode=TreeView1->Selected;
    if(!sNode||!sNode->Data||((POINTSDIV*)sNode->Data)->Type<3)
        return;

    POINTSDIV *PTreeTable=(POINTSDIV*)sNode->Data;
    TTimeInfo *wcpinf;
  //  int id_point = PTreeTable->tmpMid;


    if(!PTreeTable->pwcalcparam){
            PTreeTable->pwcalcparam = new TList();
            dmMain->oqCursor->Params->Clear();
            dmMain->oqCursor->SQL->Text="begin "+SchemeName+"editfeeders_pg.nperiod_p(:par1,:par2); end;";
            dmMain->oqCursor->ParamByName("par2")->ParamType = ptOutput;
            dmMain->oqCursor->ParamByName("par2")->DataType = ftCursor;
           dmMain->oqCursor->ParamByName("par1")->AsInteger= PTreeTable->tmpMid;
            dmMain->oqCursor->Execute();
            while(!dmMain->oqCursor->Eof){
            wcpinf=new TTimeInfo;
            ZeroMemory(wcpinf,sizeof(TTimeInfo));
            wcpinf->nperiod=dmMain->oqCursor->FieldByName("nperiod")->AsInteger;
            if(!dmMain->oqCursor->FieldByName("NCURRPOWER")->IsNull){
              wcpinf->indic[0]=0;
              wcpinf->f1=dmMain->oqCursor->FieldByName("NCURRPOWER")->AsFloat;}
            else wcpinf->indic[0]=-1;
            if(!dmMain->oqCursor->FieldByName("NMONTHCONSUMPT")->IsNull){
              wcpinf->indic[1]=0;
              wcpinf->f2=dmMain->oqCursor->FieldByName("NMONTHCONSUMPT")->AsFloat;
            }else
              wcpinf->indic[1]=-1;
            if(!dmMain->oqCursor->FieldByName("NKC")->IsNull){
              wcpinf->indic[2]=0;
              wcpinf->f3=dmMain->oqCursor->FieldByName("NKC")->AsFloat;
            }else
              wcpinf->indic[2]=-1;
            PTreeTable->pwcalcparam->Add(wcpinf);
            dmMain->oqCursor->Next();
           }

        PTreeTable->pwcalcparam->Capacity=PTreeTable->pwcalcparam->Count;
    }
    TfmCalcParam *f=new TfmCalcParam(this,PTreeTable->pwcalcparam,(Access==accWrite)&&(customer_id!=1&&customer_id!=51));
    f->Caption=Reconst_smes20_40;
    if(f->ShowModal()==mrOk){
        PTreeTable->editcalcparam=1;
        if(PTreeTable->editing!=2)
        PTreeTable->editing=2;
        EditRec=true;
        //А теперь ищем текущие параметры
        int mx=0;
        int cindex=-1;
        TTimeInfo *p;
        TList *ls=PTreeTable->pwcalcparam;
        for(int i=0;i<ls->Count;i++){
            p=(TTimeInfo *)ls->Items[i];
            if(p->nperiod<=TDateTime::CurrentDate().FormatString("yyyymmdd").ToInt()&&p->nperiod>mx){
                cindex=i;
                mx=p->nperiod;
            }
        }
        if(cindex>-1){//Нашли текущие параметры
            p=(TTimeInfo *)ls->Items[cindex];
            for(int i=0; i<dcnt; i++)
                PTreeTable->indic[6+i]=p->indic[i];
            PTreeTable->ncurrpower=p->f1;
            PTreeTable->nmonthconsumpt=p->f2;
            edCurrPower->Text=PTreeTable->indic[6]==0?FloatToStr(PTreeTable->ncurrpower).c_str():"";
            edMonthConsumpt->Text=PTreeTable->indic[7]==0?FloatToStr(PTreeTable->nmonthconsumpt).c_str():"";
        }else{
            for(int i=0; i<dcnt; i++)
                PTreeTable->indic[6+i]=-1;
            edCurrPower->Text="";
            edMonthConsumpt->Text="";
        }
    }
    delete f;
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::SavePointCalcParam(TTreeNode *Node)
{
  if(!Node || !Node->Data)
    throw Exception(Reconst_smes20_39);
  TList *ls = ((POINTSDIV*)Node->Data)->pwcalcparam;
  try{
    oqSavePointCalcParam->ParamByName("par1")->AsInteger=((POINTSDIV*)Node->Data)->tmpMid;
    for(int i=2;i<=5;i++){
      oqSavePointCalcParam->ParamByName("par"+IntToStr(i))->Length=1;
     // oqSavePointCalcParam->ParamByName("par"+IntToStr(i))->Clear();
      }
      oqSavePointCalcParam->ParamByName("par2")->ItemAsInteger[1]=0;
      oqSavePointCalcParam->ParamByName("par3")->ItemAsFloat[1]=0;
      oqSavePointCalcParam->ParamByName("par4")->ItemAsFloat[1]=0;
      oqSavePointCalcParam->ParamByName("par5")->ItemAsFloat[1]=0;

    for(int i=1; i<=ls->Count; i++){
      TTimeInfo * p=(TTimeInfo *)ls->Items[i-1];
      for(int j=2;j<=5;j++)
        oqSavePointCalcParam->ParamByName("par"+IntToStr(j))->Length=i;
      oqSavePointCalcParam->ParamByName("par2")->ItemAsInteger[i]=p->nperiod;
      if(p->indic[0]>-1)
        oqSavePointCalcParam->ParamByName("par3")->ItemAsFloat[i]=p->f1;
      if(p->indic[1]>-1)
        oqSavePointCalcParam->ParamByName("par4")->ItemAsFloat[i]=p->f2;
      if(p->indic[2]>-1)
        oqSavePointCalcParam->ParamByName("par5")->ItemAsFloat[i]=p->f3;
      }
      oqSavePointCalcParam->Execute();
  }catch(Exception&e){
    Application->ShowException(&e);
  }
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::btSetTimePClick(TObject *Sender)
{
  TTreeNode *sNode=TreeView1->Selected;
  if(!sNode||!sNode->Data||((POINTSDIV*)sNode->Data)->Type<3)
    return;
  POINTSDIV *PTreeTable=(POINTSDIV*)sNode->Data;
  if(VT_Data->State!=dsBrowse)
    VT_Data->Post();

  TList *list=((TList*)VT_Data->Fields->FieldByName("NTIMEINFO")->AsInteger);
  int id_param = VT_Data->Fields->FieldByName("NCONNECTIONPARAM")->AsInteger;
  int sobst=VT_Data->Fields->FieldByName("NSOBST")->AsInteger;
  if(!list){
    list = new TList();
    dmMain->oqCursor->Params->Clear();
    dmMain->oqCursor->SQL->Text="begin "+SchemeName+"editfeeders_pg.CONNECTACCPERIOD_p(:par1,:par2); end;";
    dmMain->oqCursor->ParamByName("par2")->ParamType = ptOutput;
    dmMain->oqCursor->ParamByName("par2")->DataType = ftCursor;
    dmMain->oqCursor->ParamByName("par1")->AsInteger=id_param;
    dmMain->oqCursor->Execute();
    while(!dmMain->oqCursor->Eof){
      TTimeInfo *Pwtimeinfo=new TTimeInfo;
      Pwtimeinfo->nperiod=dmMain->oqCursor->FieldByName("NACCPERIOD")->AsInteger;
      if(!dmMain->oqCursor->FieldByName("NWORKINGHOURS")->IsNull){
        Pwtimeinfo->indic[0]=0;
        Pwtimeinfo->f1=dmMain->oqCursor->FieldByName("NWORKINGHOURS")->AsFloat;
      }else
        Pwtimeinfo->indic[0]=-1;
      if(!dmMain->oqCursor->FieldByName("NFULLHOURS")->IsNull){
        Pwtimeinfo->indic[1]=0;
        Pwtimeinfo->f2=dmMain->oqCursor->FieldByName("NFULLHOURS")->AsFloat;
      }else
        Pwtimeinfo->indic[1]=-1;
      list->Add(Pwtimeinfo);
      dmMain->oqCursor->Next();
    }
    list->Capacity=list->Count;
  }
  TfmWorkTime *f=new TfmWorkTime(this,list,(Access==accWrite)&&(customer_id!=1&&customer_id!=51)&&sobst);
  f->Caption=Reconst_smes20_41;
  if(f->ShowModal()==mrOk){
    VT_Data->Edit();
    VT_Data->Fields->FieldByName("NEDITTIMEINFO")->AsInteger = 1;
    VT_Data->Post();
    PTreeTable->editloss=1;
    if(PTreeTable->editing!=2)
      PTreeTable->editing=2;
    EditRec=true;
  }else{
    if(VT_Data->Fields->FieldByName("NLIST")->AsInteger){
      POINTLOSS* pl=(POINTLOSS*)VT_Data->Fields->FieldByName("NLIST")->AsInteger;
      if(!pl->pwtimeinfo)
        pl->pwtimeinfo=list;
    }
  }
  delete f;
  TDataSetNotifyEvent aEdit=VT_Data->AfterEdit;
  TDataSetNotifyEvent bPost=VT_Data->BeforePost;
  VT_Data->AfterEdit=NULL;
  VT_Data->BeforePost=NULL;
  VT_Data->Edit();
  VT_Data->Fields->FieldByName("NTIMEINFO")->AsInteger=(int)list;
  VT_Data->Post();
  VT_Data->AfterEdit=aEdit;
  VT_Data->BeforePost=bPost;
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::btnUSDDropClick(TObject *Sender)
{
  POINTSDIV*SelNode = (POINTSDIV*)TreeView1->Selected->Data;
  TTreeNode*tmp;
  if(!SelNode->USDMid) return;
  SelNode->USDMid = 0;
  SelNode->USDText[0] = 0;
  tmp = TreeView1->Selected;
  TreeView1->Selected = NULL;
  TreeView1->Selected = tmp;
  if(!SelNode->editing){
      SelNode->editing = 1;
      EditRec = true;
  }
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::btnUSDSelectClick(TObject *Sender)
{
    POINTSDIV*SelNode = (POINTSDIV*)TreeView1->Selected->Data;
    GROUPDATAFORM gdf;
    gdf.gid = SelNode->USDMid?SelNode->USDMid:SelNode->Mid;
    gdf.type = 1;
    TfmSelectPoint*sp = new TfmSelectPoint(this, &gdf);
    sp->HelpContext=25034;
    sp->Caption = Reconst_smes20_42;
again:
    if(sp->ShowModal()==mrOk){
        int img = sp->tvMain->Selected->ImageIndex;
        if((img!=0 && img!=1)||SelNode->Mid==gdf.gid){
            MessageBox(Handle, Reconst_smes20_43.c_str(),
                Reconst_smes20_44.c_str(),
                MB_OK|MB_ICONINFORMATION);
            goto again;
        }
        {// проверка на интелектуальность выбранной точки
            char smart[10]={0};
            unsigned long cnt;

         
            dmMain->oqCursor->Params->Clear();
            dmMain->oqCursor->SQL->Text="begin "+SchemeName+"editfeeders_pg.SMART_p(:par1,:par2); end;";
            dmMain->oqCursor->ParamByName("par2")->ParamType = ptOutput;
            dmMain->oqCursor->ParamByName("par2")->DataType = ftString;
            dmMain->oqCursor->ParamByName("par1")->AsInteger=gdf.gid;
            dmMain->oqCursor->Execute();
            if(!dmMain->oqCursor->ParamByName("par2")->IsNull)
               strcpy(smart,dmMain->oqCursor->ParamByName("par2")->AsString.c_str());


            if(strcmp(smart,"*")){
                MessageBox(Handle, Reconst_smes20_45.c_str(),
                    Reconst_smes20_44.c_str(),
                    MB_OK|MB_ICONINFORMATION);
                goto again;
            }
        }
        SelNode->USDMid = gdf.gid;
        strcpy(SelNode->USDText, sp->mInfoArea->Text.c_str());
        repl_delimiters(SelNode->USDText, " ");
        TTreeNode*tmp = TreeView1->Selected;
        TreeView1->Selected = NULL;
        TreeView1->Selected = tmp;
        if(!SelNode->editing){
            SelNode->editing = 1;
            EditRec = true;
        }
    }
    delete sp;
}
//---------------------------------------------------------------------------

void __fastcall TFormEditFiders::OnUSDListClick(TObject *Sender)
{
   FindNode(TreeView1, (long)((TMenuItem*)Sender)->Tag, ReadTreeNode, getNodeId);
}
//---------------------------------------------------------------------------

void __fastcall TFormEditFiders::miCapUSDListDrawItem(TObject *Sender,
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
//
void __fastcall TFormEditFiders::sbUSDListClick(TObject *Sender)
{
   if(TreeView1->Selected && TreeView1->Selected->Data && ((POINTSDIV*)TreeView1->Selected->Data)->fUSD){
      MessageBox(Handle,Reconst_smes20_46.c_str(),
         Caption.c_str(),MB_OK|MB_ICONINFORMATION);
      return;
   }
   TPoint p;
   p.x = 0;
   p.y = sbUSDList->Height;
   p = sbUSDList->ClientToScreen(p);
   getUSDList(pmUSDList,((POINTSDIV*)TreeView1->Selected->Data)->Mid,OnUSDListClick);
   pmUSDList->Popup(p.x,p.y);
}
//---------------------------------------------------------------------------
inline void __fastcall TFormEditFiders::PostData(void)
{
   if(VT_Data->State!=dsBrowse)
      VT_Data->Post();
}
//---------------------------------------------------------------------------
// просмотр всех узлов и удаление УСД ссылки на bymid
void __fastcall TFormEditFiders::ClearUSDRef()
{
   TTreeNode *CurItem = TreeView1->Items->GetFirstNode();
   while (CurItem)
   {
      for(int i=0; i<CountPoints_Del; i++)
      if(CurItem->Data && ((POINTSDIV*)CurItem->Data)->USDMid==nPoints_Del[i])
      {
         ((POINTSDIV*)CurItem->Data)->USDMid = 0;
         ((POINTSDIV*)CurItem->Data)->USDText[0] = 0;
         ((POINTSDIV*)CurItem->Data)->fUSD = true;
      }
      CurItem = CurItem->GetNext();
   }
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::CopyClick(TObject *Sender)
{
   if(DBCtrlGrid1->Focused()){

   }
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::PasteClick(TObject *Sender)
{
   if(DBCtrlGrid1->Focused()){

   }
}
//---------------------------------------------------------------------------      
void __fastcall TFormEditFiders::aCbExecute(TObject *Sender)
{
   TAction*a=dynamic_cast<TAction*>(Sender);
   if(a){
      if(a==aIntellect && CheckBox1->Showing && CheckBox1->Visible && CheckBox1->Enabled)
         CheckBox1->Checked = !CheckBox1->Checked;
      else if(a==aQuadr && CheckBox2->Showing && CheckBox2->Visible && CheckBox2->Enabled)
         CheckBox2->Checked = !CheckBox2->Checked;
      else if(a==aEarthing && CheckBox3->Showing && CheckBox3->Visible && CheckBox3->Enabled)
         CheckBox3->Checked = !CheckBox3->Checked;
      else if(a==aBypasser && CheckBox4->Showing && CheckBox4->Visible && CheckBox4->Enabled)
         CheckBox4->Checked = !CheckBox4->Checked;
      else if(a==aBypasser && cbNLockSwitch->Showing && cbNLockSwitch->Visible && cbNLockSwitch->Enabled)
         cbNLockSwitch->Checked = !cbNLockSwitch->Checked;
      else if(a==aBypasser && CheckBox7->Showing && CheckBox7->Visible && CheckBox7->Enabled)
         CheckBox7->Checked = !CheckBox7->Checked;
      else if(a==aBypasser && cbNLockSwitch1->Showing && cbNLockSwitch1->Visible && cbNLockSwitch1->Enabled)
         cbNLockSwitch1->Checked = !cbNLockSwitch1->Checked;
      else if(a==aCheckBill && CalcBillCB->Showing && CalcBillCB->Visible && CalcBillCB->Enabled)
         CalcBillCB->Checked = !CalcBillCB->Checked;
      else if(a==aCheckMonth && CalcMonthCB->Showing && CalcMonthCB->Visible && CalcMonthCB->Enabled)
         CalcMonthCB->Checked = !CalcMonthCB->Checked;
      else if(a==aInverted && InvertedCB->Showing && InvertedCB->Visible && InvertedCB->Enabled)
         InvertedCB->Checked = !InvertedCB->Checked;
      else if(a==aDataAbsence && cbDataAbsence->Showing && cbDataAbsence->Visible && cbDataAbsence->Enabled)
         cbDataAbsence->Checked = !cbDataAbsence->Checked;
   }
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::btSetFormulaClick(TObject *Sender)
{
  POINTSDIV *p=(POINTSDIV*)TreeView1->Selected->Data;
  long connparam;
  if(VT_Data->State!=dsBrowse)
    VT_Data->Post();
  if(!VT_Data->IsEmpty()&&p){
    connparam=VT_Data->Fields->FieldByName("NCONNECTIONPARAM")->AsInteger;
    if(connparam){
      TMainForm*f;
      if(Sender==btSetFormula){
         f = new TfmParameterPointsList(this, &connparam, 1, Access);
         AnsiString S=(!VT_Data->Fields->FieldByName("VNAME")->AsString.IsEmpty())?VT_Data->Fields->FieldByName("VNAME")->AsString:VT_Data->Fields->FieldByName("NCONNECTIONPARAM")->AsString;
         f->Caption = f->Caption+": "+S+Reconst_smes20_48.c_str()+TreeView1->Selected->Text;
         f->ShowModal();
         delete f;
      }
    }else
      throw Exception(Reconst_smes20_49);
  }
}
//---------------------------------------------------------------------------

void __fastcall TFormEditFiders::copyChildNodes(TTreeNode*d, TTreeNode*s)
{
   ReadTreeNode(s);
   TTreeNode *tn = s->getFirstChild();
   while(tn){
      changeNode(d, tn);
      tn = tn->getNextSibling();
   }
}
//---------------------------------------------------------------------------

void __fastcall TFormEditFiders::aMExecute(TObject *Sender)
{
   TAction*pa = dynamic_cast<TAction*>(Sender);
   TTreeNode*ptn;
   if(pa){
      ptn = TreeView1->Selected;
      switch(pa->Tag){
      case 1:// Alt+Left
         if(ptn->Expanded)
            ptn->Collapse(false);
         else if(ptn->Parent)
            TreeView1->Selected = ptn->Parent;
         break;
      case 2:// Alt+Right
         if(!ptn->Expanded)
            ptn->Expand(false);
         else if(ptn->HasChildren)
            TreeView1->Selected = ptn->getFirstChild();
         break;
      case 3:// Alt+Up
         ptn = TreeView1->Selected->GetPrevVisible();
         if(ptn) TreeView1->Selected = ptn;
         break;
      case 4:// Alt+Down
         ptn = TreeView1->Selected->GetNextVisible();
         if(ptn) TreeView1->Selected = ptn;
         break;
      }
   }
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::btnAddListClick(TObject *Sender)
{
    tbTools->SetFocus();
    if(TreeView1->Selected && TreeView1->Selected->Data)
    { TfmViewTree *f = NULL;
      if(Sender==aChannelList)
      { f = new TfmViewTree(this, Reconst_smes43_8, ((POINTSDIV*)TreeView1->Selected->Data)->Mid, CHANN_FOR_POINTS);
        f->ShowModal();
      }
      else if(Sender==aGroupList)
      { f = new TfmViewTree(this, Reconst_smes43_9, ((POINTSDIV*)TreeView1->Selected->Data)->Mid, GROUP_FOR_POINTS);
        f->ShowModal();
      }
      else if(Sender==aMaketList)
      { f = new TfmViewTree(this, Reconst_smes43_11, ((POINTSDIV*)TreeView1->Selected->Data)->Mid, MAKET_FOR_POINTS);
        f->ShowModal();
      }
      else if(Sender==aOccurr)
      { f = new TfmViewTree(this, Reconst_smes43_13, ((POINTSDIV*)TreeView1->Selected->Data)->Mid, OCCURR_POINTS_FORMULA);
        f->ShowModal();
      }
      if(f)
        delete f;
   }//end if
}
//---------------------------------------------------------------------------

void __fastcall TFormEditFiders::btnLastSaveClick(TObject *Sender)
{
    tbTools->SetFocus();
    if(TreeView1->Selected && TreeView1->Selected->Data){
      TLastSaveForm * lsF = new TLastSaveForm(this,TreeView1->Selected->Text.c_str(),((POINTSDIV*)TreeView1->Selected->Data)->Mid,Access);
      lsF->ShowModal();
      delete lsF;
    }
}
//---------------------------------------------------------------------------

void __fastcall TFormEditFiders::iaMonExecute(TObject *Sender)
{
    TManForm*pMF=NULL;
    TBaseMonitorForm *p=NULL;
    HCURSOR hCursor;
    long Fid=-1;;
    TFormDescr* sfd=NULL;
    TForm* fmSelectGroupReportUniv=NULL;

    try{
        pMF = new TManForm(SupperMainForm);
        pMF->OnProgressBarStepBy = SupperMainForm->ProgressBarStepBy;
	    p = new TBaseMonitorForm(pMF->PageCtrlSplt,pMF->OnProgressBarStepBy);
    	pMF->PageCtrlSplt->AddChild(p,alTop);

    	if(!pMF->PageCtrlSplt->CurrentForm)
	    	throw Exception(Reconst_smes20_50);

        hCursor=::SetCursor(LoadCursor(NULL,IDC_WAIT));

    	sfd = new TFormDescr;
        sfd->IsPoints = true;
        sfd->IdGroup = ((POINTSDIV*)TreeView1->Selected->Data)->Mid;
        sfd->SummGroup = true;
        sfd->NameGroup = ((POINTSDIV*)TreeView1->Selected->Data)->Name;
        sfd->ShortNameGroup = ((POINTSDIV*)TreeView1->Selected->Data)->Short_Name;

        fmSelectReportForm = new TfmSelectReportForm(this,Fid,sfd);

        ::SetCursor(hCursor);

        while(fmSelectReportForm->ShowModal()!=mrOk ||
            !sfd->EnableControls.Contains(TFormDescr::ctrlPoint))
        {
            if(fmSelectReportForm->ModalResult != mrOk)
                break;
            if(!sfd->EnableControls.Contains(TFormDescr::ctrlPoint))
                ShowMessage(Reconst_smes20_51);
        }
        if(fmSelectReportForm->ModalResult == mrOk)
        {
            if (IsCommonRepForm( sfd->CodeTemplate ) )
                fmSelectGroupReportUniv = new TfmSelectGroupReportProc(this,sfd);
            else
                fmSelectGroupReportUniv = new TfmSelectGroupReport(this,sfd);

            if( EXCEL_F == sfd->CodeTemplate )
                fmSelectGroupReportUniv->ModalResult = mrOk;
            else
            {
                bool prContWork = TRUE;
                if(sfd->CodeTemplate == EXCEL_REP_F || sfd->CodeTemplate == EXCEL_OP_FORM)
                {
                    TManForm *FFF = dynamic_cast<TManForm*>(SupperMainForm->ActiveMDIChild);
                    if(!( FFF && FFF->PageCtrlSplt->listMonitorForms->Count<2 ) )
                    {
                        Application->MessageBox(Reconst_smes20_52.c_str(),
                            Application->Title.c_str(),MB_OK|MB_ICONSTOP);
                        fmSelectGroupReportUniv->ModalResult = mrCancel;
                        prContWork = FALSE;
                    }
                }
                if( prContWork )
                    //fmSelectGroupReportUniv->ShowModal();
                    fmSelectGroupReportUniv->ModalResult = mrOk;
            }
            if (fmSelectGroupReportUniv->ModalResult == mrOk)
            {
        	    //fmSelectReportForm->fd->CodeTemplate=1;
                // перед любым обновлением мониторов необходимо инициализировать кр. секцию UpdateMonitors
                while(WaitForSingleObject(UpdateMonitors,0)!=WAIT_OBJECT_0)
                {
                    Application->ProcessMessages();// если не удалось иниц-ть. CS то обновить экранные формы...
                    Sleep(0);// переключить управление на другой поток, коьт занял CS
                }
                // add by KSS
                PostMessage(pMF->PageCtrlSplt->CurrentForm->Handle,WM_REFRESHFORM,0,(LPARAM)fmSelectReportForm->fd);
            }else{
                // Повтор данного кода выбора формы
            }
        }
        else
        {
            if(sfd->CodeTemplate==EXCEL_REP_F)
            {
                TBaseMonitorForm* MF = (TBaseMonitorForm*)pMF->PageCtrlSplt->CurrentForm;
                TInteriorExRep * TIFx = (TInteriorExRep*) MF->Interior;
                TIFx->DoVerb();
            }else if(sfd->CodeTemplate==EXCEL_OP_FORM)
            {
                TBaseMonitorForm* MF = (TBaseMonitorForm*)pMF->PageCtrlSplt->CurrentForm;
                TInteriorExOpForm * TIFx = (TInteriorExOpForm*) MF->Interior;
                TIFx->DoVerb();
            }else{
                pMF->Close();
            }
        }
    }catch(Exception&e){
        if(fmSelectGroupReportUniv)
            delete fmSelectGroupReportUniv;
        if(fmSelectReportForm)
            delete fmSelectReportForm;
        ::SetCursor(hCursor);
        throw Exception(e);
    }
    delete fmSelectGroupReportUniv;
    delete fmSelectReportForm;
}
//---------------------------------------------------------------------------
// Add by KSS (04.06.2004)
void __fastcall TFormEditFiders::MonSelectClick(TObject *Sender)
{
    TMenuItem*mi=(TMenuItem*)Sender;
    FORMS*fms =(FORMS*)mi->Tag;
    if(fms && fms->tmplCode!=0)
    {
        ManForm = new TManForm(SupperMainForm);
        ManForm->OnProgressBarStepBy=SupperMainForm->ProgressBarStepBy;
    	TBaseMonitorForm *p=new TBaseMonitorForm(ManForm->PageCtrlSplt,ManForm->OnProgressBarStepBy);
	    ManForm->PageCtrlSplt->AddChild(p,alTop);
        TFormDescr* sfd=NULL;
        TForm* fmSelectGroupReportUniv=NULL;
        if(!ManForm->PageCtrlSplt->CurrentForm)
	        return;
        sfd = new TFormDescr;
	    if(ManForm->PageCtrlSplt->CurrentForm->GetFormDescr())
    	    *sfd=*(ManForm->PageCtrlSplt->CurrentForm->GetFormDescr());
        // Подготовка описания формы
        sfd->IdFormTree = fms->fid;
        sfd->CodeTemplate = fms->tmplCode;
        sfd->IdGroup = ((POINTSDIV*)TreeView1->Selected->Data)->Mid;
        sfd->SummGroup = true;
        sfd->NameForm = fms->name;
        sfd->CommentForm = fms->comment;
        sfd->NameAlert = fms->alertname;
        sfd->NameGroup = ((POINTSDIV*)TreeView1->Selected->Data)->Name;
        sfd->ShortNameGroup = ((POINTSDIV*)TreeView1->Selected->Data)->Short_Name;
        sfd->IsPoints=true;
        if(sfd->ShortNameGroup.Length()==0)
            sfd->ShortNameGroup = sfd->NameGroup;
        switch(fms->step){
        case 1:
            sfd->StepProfile = TFormDescr::stpMonth;
            break;
        case 2:
            sfd->StepProfile = TFormDescr::stpDay;
            break;
        case 3:
            sfd->StepProfile = TFormDescr::stpHour;
            break;
        case 4:
            sfd->StepProfile = TFormDescr::stpMinute;
            break;
        default:
            sfd->StepProfile = TFormDescr::stpNone;
        }

		sfd->EnableControls.Clear();
		char*ch = &fms->enablecontrols[0];
        if(*ch=='1')
          sfd->EnableControls<<TFormDescr::ctrlGroup;
        ch++;
        if(*ch=='1')
		    sfd->EnableControls<<TFormDescr::ctrlMonth;
        ch++;
        if(*ch=='1')
		    sfd->EnableControls<<TFormDescr::ctrlDay;
        ch++;
        if(*ch=='1')
		    sfd->EnableControls<<TFormDescr::ctrlHour;
        ch++;
        if(*ch=='1')
		    sfd->EnableControls<<TFormDescr::ctrlMinute;
        ch++;
        if(*ch=='1')
		    sfd->EnableControls<<TFormDescr::ctrlCalendar;
        ch++;
        if(*ch=='1')
            {sfd->EnableControls<<TFormDescr::ctrlPoint;sfd->startmid = fms->startmid;}
        ch++;
        if(*ch=='1')
          {sfd->indbird = true; sfd->bird = 0;}

        // Конец подготовки
        fmSelectReportForm = new TfmSelectReportForm(this,fms->fid,sfd);

        if(IsCommonRepForm(sfd->CodeTemplate))
            fmSelectGroupReportUniv = new TfmSelectGroupReportProc(this,sfd);
        else
            fmSelectGroupReportUniv = new TfmSelectGroupReport(this,sfd);
        if(EXCEL_F == sfd->CodeTemplate)
            fmSelectGroupReportUniv->ModalResult = mrOk;
        else
        {
            bool prContWork = TRUE;
            if(sfd->CodeTemplate == EXCEL_REP_F || sfd->CodeTemplate == EXCEL_OP_FORM)
            {
                TManForm *FFF = dynamic_cast<TManForm*>(SupperMainForm->ActiveMDIChild);
                if(!( FFF && FFF->PageCtrlSplt->listMonitorForms->Count<2 ) )
                {
                    Application->MessageBox(Reconst_smes20_52.c_str(),
                        Application->Title.c_str(),MB_OK|MB_ICONSTOP);
                    fmSelectGroupReportUniv->ModalResult = mrCancel;
                    prContWork = FALSE;
                }
            }
            if( prContWork )
                fmSelectGroupReportUniv->ModalResult = mrOk;
        }
        if (fmSelectGroupReportUniv->ModalResult == mrOk)
        {
            //fmSelectReportForm->fd->CodeTemplate=1;
            // перед любым обновлением мониторов необходимо инициализировать кр. секцию UpdateMonitors
            while(WaitForSingleObject(UpdateMonitors,0)!=WAIT_OBJECT_0)
            {
                Application->ProcessMessages();// если не удалось иниц-ть. CS то обновить экранные формы...
                Sleep(0);// переключить управление на другой поток, коьт занял CS
            }
            // add by KSS
            PostMessage(ManForm->PageCtrlSplt->CurrentForm->Handle,WM_REFRESHFORM,0,(LPARAM)sfd);
        }
        delete fmSelectGroupReportUniv;
        delete fmSelectReportForm;
        Cursor = crDefault;
        }
   // }else
   //  ; //if(mi==mMon&&mi->Count==1)  createSubMenu(mi);

}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::createSubMenu_F(TMenuItem*mi)
{

    FORMS *n, *fms = (FORMS*)mi->Tag;
    TMenuItem*chMi;

    try
    {
        long cnt = mi->Count;

         oqCursor2->Params->Clear();
         oqCursor2->SQL->Text="begin "+SchemeName+"editfeeders_pg.get_SubMenu_p(:par1,:par2,:par3,:par4); end;";
         oqCursor2->ParamByName("par4")->ParamType = ptOutput;
         oqCursor2->ParamByName("par4")->DataType = ftCursor;
         if(!fms || fms->fid==0)
         oqCursor2->ParamByName("par1")->AsInteger=0;
         else
         oqCursor2->ParamByName("par1")->AsInteger=fms->fid;
         oqCursor2->ParamByName("par2")->AsInteger= StrToInt(UserRol.Monitor);
         oqCursor2->ParamByName("par3")->DataType=ftInteger;
         oqCursor2->ParamByName("par3")->ParamType=ptInputOutput;
         oqCursor2->ParamByName("par3")->AsInteger=fms->gid;
         oqCursor2->Open();

        while(!oqCursor2->Eof){
            n = new FORMS;
            ZeroMemory(n, sizeof(FORMS));
            if(!oqCursor2->FieldByName("fid")->IsNull)
            n->fid=oqCursor2->FieldByName("fid")->AsInteger;
         if(!oqCursor2->FieldByName("codetemplate")->IsNull)
            n->tmplCode=oqCursor2->FieldByName("codetemplate")->AsInteger;
         else  n->tmplCode=0;
         if(!oqCursor2->FieldByName("nameform")->IsNull)
            strcpy(n->name,oqCursor2->FieldByName("nameform")->AsString.c_str());
         if(!oqCursor2->FieldByName("commentform")->IsNull)
            strcpy(n->comment,oqCursor2->FieldByName("commentform")->AsString.c_str());
         if(!oqCursor2->FieldByName("enablecontrols")->IsNull)
            strcpy(n->enablecontrols,oqCursor2->FieldByName("enablecontrols")->AsString.c_str());
         if(!oqCursor2->FieldByName("stepprofile")->IsNull)
            n->step=oqCursor2->FieldByName("stepprofile")->AsInteger;
         if(!oqCursor2->FieldByName("namealert")->IsNull)
            strcpy(n->alertname,oqCursor2->FieldByName("namealert")->AsString.c_str());
         if(!oqCursor2->FieldByName("vprocname")->IsNull)
            strcpy(n->procname,oqCursor2->FieldByName("vprocname")->AsString.c_str());
         if(!oqCursor2->ParamByName("par3")->IsNull)
            n->gid=oqCursor2->ParamByName("par3")->AsInteger;
        //  n->gid=fms->gid;
         if(!oqCursor2->FieldByName("mid")->IsNull)
            n->startmid=oqCursor2->FieldByName("mid")->AsInteger;

                chMi = new TMenuItem(mi);
                chMi->Caption = n->name;
                chMi->Tag = (long)n;
                chMi->OnClick = mi->OnClick;
                if(n->tmplCode==0)
                    chMi->Insert(0,new TMenuItem(mi));
                mi->Insert(0,chMi);
           oqCursor2->Next();
          }
          oqCursor2->Close();
        for(long i=0; i<cnt; i++){
            n = (FORMS*)mi->Items[mi->Count-1]->Tag;
            if(n)
                delete n;
            mi->Delete(mi->Count-1);
        }
        if(mi->Count==0){
            mi->Add(new TMenuItem(mi));
        }


          for (int i=0;i<mi->Count;i++){
           if(((FORMS*)mi->Items[i]->Tag)&&((FORMS*)mi->Items[i]->Tag)->tmplCode==0)
                    createSubMenu_F(mi->Items[i]);
          }

    }catch(Exception&e){
        throw Exception(e);
    }
}
// END Add by KSS (04.06.2004)
//---------------------------------------------------------------------------

void __fastcall TFormEditFiders::btnMainSelectClick(TObject *Sender)
{
    TfmSelectPoint*sp;
    POINTSDIV*SelNode = (POINTSDIV*)TreeView1->Selected->Data;
    GROUPDATAFORM gdf;

    gdf.gid = SelNode->nMainPoint?SelNode->nMainPoint:SelNode->Mid;
    gdf.type = 1;
    sp = new TfmSelectPoint(this, &gdf);
    sp->HelpContext=25034;
    sp->Caption = Reconst_smes20_53;

again:
    if(sp->ShowModal()==mrOk){
        int img = sp->tvMain->Selected->ImageIndex;

        if((img!=0 && img!=1)||SelNode->Mid==gdf.gid){
             MessageBox(Handle, Reconst_smes20_54.c_str(),
                Reconst_smes20_55.c_str(),
                MB_OK|MB_ICONINFORMATION);

            gdf.gid = SelNode->nMainPoint;
            goto again;
        }

        SelNode->nMainPoint = gdf.gid;
        strcpy(SelNode->MainText, sp->mInfoArea->Text.c_str());
        repl_delimiters(SelNode->MainText, " ");
     
        TTreeNode*tmp = TreeView1->Selected;
        TreeView1->Selected = NULL;
        TreeView1->Selected = tmp;
        if(!SelNode->editing){
            SelNode->editing = 1;
            EditRec = true;
        }
    }
    delete sp;
}

//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::sbOppositClick(TObject *Sender)
{
    TfmSelectPoint*sp;
    POINTSDIV*SelNode = (POINTSDIV*)TreeView1->Selected->Data;
    GROUPDATAFORM gdf;
    gdf.gid = SelNode->OppositeMid?SelNode->OppositeMid:SelNode->Mid;
    gdf.type = 1;
    sp = new TfmSelectPoint(this, &gdf);
    sp->Caption = Reconst_smes20_55;
    sp->HelpContext=25034;
again:
    if(sp->ShowModal()==mrOk){
        int img = sp->tvMain->Selected->ImageIndex;
        if((img!=0 && img!=1&& img!=6)||SelNode->Mid==gdf.gid){
                MessageBox(Handle, Reconst_smes20_56.c_str(),
                Reconst_smes20_44.c_str(),
                MB_OK|MB_ICONINFORMATION);
            gdf.gid = SelNode->OppositeMid;
            goto again;
         }
        
        SelNode->OppositeMid = gdf.gid;
        strcpy(SelNode->Opposite, sp->mInfoArea->Text.c_str());
        repl_delimiters(SelNode->Opposite, " ");


        TTreeNode*tmp = TreeView1->Selected;
        TreeView1->Selected = NULL;
        TreeView1->Selected = tmp;
        if(!SelNode->editing){
            SelNode->editing = 1;
            EditRec = true;
        }
    }
    delete sp;
}
//---------------------------------------------------------------------------


void __fastcall TFormEditFiders::sbGroupSelClick(TObject *Sender)
{

  POINTSDIV*SelNode = (POINTSDIV*)TreeView1->Selected->Data;
    GROUPDATAFORM gdf;
    gdf.gid = SelNode->Group;
    gdf.type = 4;
    TfmSelectPoint*sp = new TfmSelectPoint(this, &gdf);
    sp->Caption = Reconst_smes20_57;
    sp->HelpContext=25034;
    if(sp->ShowModal()==mrOk){
        SelNode->Group = gdf.gid;
        strcpy(SelNode->GroupText, sp->tvMain->Selected->Text.c_str());
        eGroup->Text=SelNode->GroupText;
        if(SelNode->editing!=2)
          SelNode->editing=2;
        EditRec=true;
    }
    delete sp;
}
//---------------------------------------------------------------------------

void __fastcall TFormEditFiders::btnMainDropClick(TObject *Sender)
{
    POINTSDIV*SelNode = (POINTSDIV*)TreeView1->Selected->Data;
    TTreeNode*tmp;
    if(!SelNode->nMainPoint) return;
    SelNode->nMainPoint = 0;
    SelNode->MainText[0] = 0;
    tmp = TreeView1->Selected;
    TreeView1->Selected = NULL;
    TreeView1->Selected = tmp;
    if(!SelNode->editing){
        SelNode->editing = 1;
        EditRec = true;
    }
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::sbGroupDropClick(TObject *Sender)
{
  POINTSDIV*SelNode = (POINTSDIV*)TreeView1->Selected->Data;
    TTreeNode*tmp;
    if(!SelNode->Group) return;
    SelNode->Group = 0;
    SelNode->GroupText[0] = 0;
    tmp = TreeView1->Selected;
    TreeView1->Selected = NULL;
    TreeView1->Selected = tmp;
    if(!SelNode->editing){
        SelNode->editing = 1;
        EditRec = true;
    }
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::sbDelOppositeClick(TObject *Sender)
{
   POINTSDIV*SelNode = (POINTSDIV*)TreeView1->Selected->Data;
    TTreeNode*tmp;
    if(!SelNode->OppositeMid) return;
    SelNode->OppositeMid = 0;
    SelNode->Opposite[0] = 0;
    tmp = TreeView1->Selected;
    TreeView1->Selected = NULL;
    TreeView1->Selected = tmp;
    if(!SelNode->editing){
        SelNode->editing = 1;
        EditRec = true;
    }
}
//---------------------------------------------------------------------------


void __fastcall TFormEditFiders::sbMainListClick(TObject *Sender)
{
   if(TreeView1->Selected && TreeView1->Selected->Data && ((POINTSDIV*)TreeView1->Selected->Data)->fUSD){
      MessageBox(Handle,Reconst_smes20_58.c_str(),
         Caption.c_str(),MB_OK|MB_ICONINFORMATION);
      return;
   }
   TPoint p;
   p.x = 0;
   p.y = sbUSDList->Height;
   p = sbMainList->ClientToScreen(p);
   getMainList(pmDuplList,((POINTSDIV*)TreeView1->Selected->Data)->Mid,OnUSDListClick);
   pmDuplList->Popup(p.x,p.y);
}
//---------------------------------------------------------------------------

void __fastcall TFormEditFiders::getMainList(TPopupMenu* pm, long mid, Classes::TNotifyEvent& OnClick)
{

    unsigned long u_mid = mid;
    AnsiString caption;
    char name[256];

    try{

        dmMain->oqCursor->Params->Clear();
        dmMain->oqCursor->SQL->Text="begin "+SchemeName+"editfeeders_pg.NMAINPOINT_p(:par1,:par2); end;";
        dmMain->oqCursor->ParamByName("par2")->ParamType = ptOutput;
        dmMain->oqCursor->ParamByName("par2")->DataType = ftCursor;
        dmMain->oqCursor->ParamByName("par1")->AsInteger=u_mid;
        while(pm->Items->Count>2)
            pm->Items->Delete(2);
         dmMain->oqCursor->Execute();
         int i;
         while(!dmMain->oqCursor->Eof){
          strcpy(name,dmMain->oqCursor->FieldByName("name")->AsString.c_str());
          repl_delimiters(name, " ");
          caption = name;
          TMenuItem*mi = NewItem(caption,0,false,true,OnClick,0,"miN"+IntToStr(i)+"USDList");
          mi->Tag = dmMain->oqCursor->FieldByName("MID")->AsInteger;
          pm->Items->Add(mi);
            dmMain->oqCursor->Next();
            i++;
           }

    }catch(Exception&e){
        throw e;
    }
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::sbListOppositeClick(TObject *Sender)
{
    if(TreeView1->Selected && TreeView1->Selected->Data && ((POINTSDIV*)TreeView1->Selected->Data)->fUSD){
      MessageBox(Handle,Reconst_smes20_60.c_str(),
         Caption.c_str(),MB_OK|MB_ICONINFORMATION);
      return;
   }
   TPoint p;
   p.x = 0;
   if((TSpeedButton*)Sender==sbListOpposite){
   p.y = sbListOpposite->Height;
   p = sbListOpposite->ClientToScreen(p);
   }
   if((TSpeedButton*)Sender==sbOppList){
   p.y = sbOppList->Height;
   p = sbOppList->ClientToScreen(p);
   }
   getListOpposite(pmOppositeList,((POINTSDIV*)TreeView1->Selected->Data)->Mid,OnUSDListClick);
   pmOppositeList->Popup(p.x,p.y);
}
//---------------------------------------------------------------------------
 void __fastcall TFormEditFiders::getListOpposite(TPopupMenu* pm, long mid, Classes::TNotifyEvent& OnClick)
{
      unsigned long u_mid = mid;
    AnsiString caption;
    char name[256];

    try{
        dmMain->oqCursor->Params->Clear();
        dmMain->oqCursor->SQL->Text="begin "+SchemeName+"editfeeders_pg.NOPPOSITE_p(:par1,:par2); end;";
        dmMain->oqCursor->ParamByName("par2")->ParamType = ptOutput;
        dmMain->oqCursor->ParamByName("par2")->DataType = ftCursor;
        dmMain->oqCursor->ParamByName("par1")->AsInteger=u_mid;
        while(pm->Items->Count>2)
            pm->Items->Delete(2);
         dmMain->oqCursor->Execute();
         int i;
         while(!dmMain->oqCursor->Eof){
          strcpy(name,dmMain->oqCursor->FieldByName("name")->AsString.c_str());
          repl_delimiters(name, " ");
          caption = name;
          TMenuItem*mi = NewItem(caption,0,false,true,OnClick,0,"miN"+IntToStr(i)+"USDList");
          mi->Tag = dmMain->oqCursor->FieldByName("MID")->AsInteger;
          pm->Items->Add(mi);
            dmMain->oqCursor->Next();
            i++;
           }

    }catch(Exception&e){
        throw e;
    }
}
//---------------------------------------------------------------------------

void __fastcall TFormEditFiders::aRclcDataExecute(TObject *Sender)
{
  TFormInputParameters* fmIP = NULL;
  try{
    fmIP = new TFormInputParameters(this);
    if(fmIP->ShowModal()==mrOk){
	  //GRB ADD 16.04.2020 - test trouble ODAC
      dmMain->quMain->Params->Clear();
      //END ADD
      dmMain->quMain->SQL->Text="begin "+SchemeName+"EDITFEEDERS_PG.recalcdiff(:par1, to_date(:par2,'dd.mm.yyyy hh24:mi')); end;";
      dmMain->quMain->ParamByName("par1")->AsInteger=((POINTSDIV*)TreeView1->Selected->Data)->Mid;
      dmMain->quMain->ParamByName("par2")->AsString=fmIP->meDate->Cells[0][0];
      dmMain->quMain->Execute();
      MessageBox(Handle,Reconst_smes20_62.c_str(),Caption.c_str(),MB_OK|MB_ICONINFORMATION);
    }
    delete fmIP;
  }catch(Exception&e){
    if(fmIP)
      delete fmIP;
    throw;
  }
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::aDelDataExecute(TObject *Sender)
{
    TFormInputParameters4* fmIP = NULL;
    try{
      fmIP = new TFormInputParameters4(this);
      if(fmIP->ShowModal()==mrOk){
		//GRB ADD 16.04.2020 - test trouble ODAC
        dmMain->quMain->Params->Clear();
        //END ADD 
        dmMain->quMain->SQL->Text="begin "+SchemeName+"editfeeders_pg.delete_data(:par1,:par2,:par3,:par4,:par5,:par6,:par7,:par8,:par9,:par10,:par11,:par12,:par13); end;";
        dmMain->quMain->ParamByName("par1")->AsInteger=((POINTSDIV*)TreeView1->Selected->Data)->Mid;
        for(int i=2;i<=9;i++)
          dmMain->quMain->ParamByName("par"+IntToStr(i))->AsDateTime=Now();
        if(fmIP->meProfileDate->Enabled){
          dmMain->quMain->ParamByName("par2")->AsDateTime=StrToDateTime(fmIP->meProfileDate->Text+":00");
          dmMain->quMain->ParamByName("par6")->AsDateTime=StrToDateTime(fmIP->meProfileDateEnd->Text+":00");
        }else{
          dmMain->quMain->ParamByName("par2")->Clear();
          dmMain->quMain->ParamByName("par6")->Clear();
        }
        if(fmIP->meHalfDate->Enabled){
          dmMain->quMain->ParamByName("par3")->AsDateTime=StrToDateTime(fmIP->meHalfDate->Text+":00");
          dmMain->quMain->ParamByName("par7")->AsDateTime=StrToDateTime(fmIP->meHalfDateEnd->Text+":00");
        }else{
          dmMain->quMain->ParamByName("par3")->Clear();
          dmMain->quMain->ParamByName("par7")->Clear();
        }
        if(fmIP->meBillDate->Enabled){
          dmMain->quMain->ParamByName("par4")->AsDateTime=StrToDateTime(fmIP->meBillDate->Text+":00");
          dmMain->quMain->ParamByName("par8")->AsDateTime=StrToDateTime(fmIP->meBillDateEnd->Text+":00");
        }else{
          dmMain->quMain->ParamByName("par4")->Clear();
          dmMain->quMain->ParamByName("par8")->Clear();
        }
        if(fmIP->meMonthDate->Enabled){
          dmMain->quMain->ParamByName("par5")->AsDateTime=StrToDateTime(fmIP->meMonthDate->Text+":00");
          dmMain->quMain->ParamByName("par9")->AsDateTime=StrToDateTime(fmIP->meMonthDateEnd->Text+":00");
        }else{
          dmMain->quMain->ParamByName("par5")->Clear();
          dmMain->quMain->ParamByName("par9")->Clear();
        }
         if(fmIP->meJournalDate->Enabled){
          dmMain->quMain->ParamByName("par10")->AsDateTime=StrToDateTime(fmIP->meJournalDate->Text+":00");
          dmMain->quMain->ParamByName("par11")->AsDateTime=StrToDateTime(fmIP->meJournalDateEnd->Text+":00");
        }else{
          dmMain->quMain->ParamByName("par10")->Clear();
          dmMain->quMain->ParamByName("par11")->Clear();
        }
        if(fmIP->meCurrentDate->Enabled){
          dmMain->quMain->ParamByName("par12")->AsDateTime=StrToDateTime(fmIP->meCurrentDate->Text+":00");
          dmMain->quMain->ParamByName("par13")->AsDateTime=StrToDateTime(fmIP->meCurrentDateEnd->Text+":00");
        }else{
          dmMain->quMain->ParamByName("par12")->Clear();
          dmMain->quMain->ParamByName("par13")->Clear();
        }
        dmMain->quMain->Execute();
        MessageBox(Handle,Reconst_smes20_63.c_str(),Application->Title.c_str(),MB_OK|MB_ICONINFORMATION);
      }
      delete fmIP;
    }catch(Exception&e){
      if(fmIP)
        delete fmIP;
      throw;
    }
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::tbNewClick(TObject *Sender)
{
  if(iaNewCalcNode->Enabled){
    TPoint p;
    p.x = tbNew->Left+tbNew->Width;
    p.y = tbNew->Top;
    p = tbNew->ClientToScreen(p);
    pmAddNode->Popup(p.x,p.y );

  }else
    CreateNode(3);
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::iaNewCalcNodeExecute(TObject *Sender)
{
  CreateNode(4);
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::CreateNode(long type_node)
{
TTreeNode *sNode=TreeView1->Selected;
    if(!sNode||!sNode->Data||((POINTSDIV*)sNode->Data)->Type==1)
        return;
    POINTSDIV *PTreeTable=(POINTSDIV*)sNode->Data;

    if(PTreeTable->Type==3){
        sNode=sNode->Parent;
        PTreeTable=(POINTSDIV*)sNode->Data;
    }

    if((PTreeTable->Type==2)||(PTreeTable->Type==4)||
        ((PTreeTable->Type==3)&&CheckBox1->Checked&&sNode==TreeView1->Selected)||
        ((PTreeTable->Type==3)&&PTreeTable->SMART&&sNode==TreeView1->Selected->Parent)){
        bool AllowChange=true;
        TreeView1Changing(TreeView1,TreeView1->Selected,AllowChange);
        if(!AllowChange)
            return;
        PTreeTable=new POINTSDIV;
        ZeroMemory(PTreeTable, sizeof(POINTSDIV));
        strcpy(PTreeTable->Name,Reconst_smes20_64.c_str());
        PTreeTable->Type=type_node;//3;
        PTreeTable->KC=1;
        PTreeTable->classTN=0.5;
        PTreeTable->classTT=0.5;
        PTreeTable->ntimezonew=TimeZoneUkrW;
        PTreeTable->ntimezones=TimeZoneUkrS;
        PTreeTable->MeterKC=1;
        PTreeTable->editing=2;
        PTreeTable->integr=30;
        PTreeTable->pcounter=new TList;
        PTreeTable->ploss=new TList;
        for(int z=1;z<3;z++)
            PTreeTable->indic[z]=-1;
        for(int z=6;z<8;z++)
            PTreeTable->indic[z]=-1;

        sNode->Expand(false);
        sNode=TreeView1->Items->AddChildObject(sNode,PTreeTable->Name,PTreeTable);
        if(type_node==3){
          sNode->ImageIndex=0;
          sNode->SelectedIndex=0;
        }else{
          sNode->ImageIndex=26;
          sNode->SelectedIndex=26;
        }
        EditRec=true;
        TreeView1->Selected=sNode;
        SetFocusInFirst();
    }else
        MessageBox(this->Handle,Reconst_smes20_65.c_str(),(this->Caption+Reconst_smes20_66.c_str()).c_str(),MB_ICONINFORMATION);
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::btTUClick(TObject *Sender)
{
  TTreeNode *sNode=TreeView1->Selected;
  if(!sNode||!sNode->Data||((POINTSDIV*)sNode->Data)->Type<3)
    return;
  POINTSDIV *PTreeTable=(POINTSDIV*)sNode->Data;
  if(PTreeTable->tmpMid){
    TfmPointConditions* f;
    f = new TfmPointConditions(this,PTreeTable->tmpMid, Access);
    f->Caption = Reconst_smes20_67 + Edit1->Text;
    f->ShowModal();
    delete f;
  }
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::vFindClick(TObject*)
{
  //GRB ADD 09.03.2021 - добавляем вызов 2х сеттеров, определяющих контекст задачи
  fmFP->setContext(0);
  fmFP->setGroupsAndPoints(false);
  //END ADD
  fmFP->ShowModal();
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::WM_SetActiveNode(TMessage& Message)
{
  FindNode(TreeView1, Message.LParam, ReadTreeNode, getNodeId);
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::acSampleHoursExecute(TObject *Sender)
{
 tbTools->SetFocus();
 if(TreeView1->Selected && TreeView1->Selected->Data)
   TfmTypePart::fmTypePartShow(this,((POINTSDIV*)TreeView1->Selected->Data)->Mid);
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::acMeterParameterExecute(TObject *Sender)
{
  tbTools->SetFocus();
  if(TreeView1->Selected && TreeView1->Selected->Data)
    TfmMeterParameter::fmMeterParameterShow(this,((POINTSDIV*)TreeView1->Selected->Data)->Mid,Access);
}
//---------------------------------------------------------------------------


void __fastcall TFormEditFiders::cbTimeZoneChange(TObject *Sender)
{
  TTreeNode *sNode=TreeView1->Selected;
  if(!sNode||!sNode->Data||((POINTSDIV*)sNode->Data)->Type==1)
    return;
  if(((POINTSDIV*)sNode->Data)->editing!=2)
    ((POINTSDIV*)sNode->Data)->editing=2;
  EditRec=true;
}
//---------------------------------------------------------------------------

void __fastcall TFormEditFiders::btSpezParamClick(TObject *Sender)
{
  TTreeNode *sNode=TreeView1->Selected;
  if(!sNode||!sNode->Data)
    return;
  if(((POINTSDIV*)TreeView1->Selected->Data)->Mid)
   TfmSpecParam::fmSpecParamShow(this,((POINTSDIV*)TreeView1->Selected->Data)->Mid,0);
}
//---------------------------------------------------------------------------

void __fastcall TFormEditFiders::btLimitClick(TObject *Sender)
{
  TTreeNode *sNode=TreeView1->Selected;
  if(!sNode||!sNode->Data)
    return;
  if(((POINTSDIV*)TreeView1->Selected->Data)->Mid)
   TfmSpecParam::fmSpecParamShow(this,((POINTSDIV*)TreeView1->Selected->Data)->Mid,1);
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::sbFormulaClick(TObject *Sender)
{
  TTreeNode *sNode=TreeView1->Selected;
  if(!sNode||!sNode->Data)
    return;
   //22.08.2019 UNKEY VERSION SUBSTR COMMENT BELOW
  if(((POINTSDIV*)TreeView1->Selected->Data)->Mid/*&&(dmMain->LicType||GrdGetPermission(CHK_LIC_TASK,CHK_LIC_TASK_MAKRETRIVE)>0)*/){
   //END COMMENT
   TfmEditFormula::fmEditFormulaShow(this,((POINTSDIV*)TreeView1->Selected->Data)->Mid);
   //GRB ADD 16.04.2020 - test trouble ODAC
   dmMain->quMain->Params->Clear();
   //END ADD 
   dmMain->quMain->SQL->Text="select nvl("+SchemeName+"editfeeders_pg.formulameas_p(:par1),' ')formula from dual";
   dmMain->quMain->ParamByName("par1")->AsInteger=((POINTSDIV*)TreeView1->Selected->Data)->Mid;
   dmMain->quMain->Execute();
   if(!dmMain->quMain->Eof)
    strcpy(((POINTSDIV*)TreeView1->Selected->Data)->formula,dmMain->quMain->FieldByName("formula")->AsString.c_str());
   edFormula->Clear();
   edFormula->Text=((POINTSDIV*)TreeView1->Selected->Data)->formula;
  }
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::sbDeleteFormulaClick(TObject *Sender)
{
  TTreeNode *sNode=TreeView1->Selected;
  if(!sNode||!sNode->Data)
    return;
  if(((POINTSDIV*)TreeView1->Selected->Data)->Mid&&(MessageBox(Handle,AnsiString(Reconst_smes20_68+sNode->Text+">?").c_str(),Application->Title.c_str(),MB_YESNO|MB_ICONQUESTION|MB_DEFBUTTON2)==IDYES)){
	   	//GRB ADD 16.04.2020 - test trouble ODAC
        dmMain->quMain->Params->Clear();
        //END ADD   
 	  dmMain->quMain->SQL->Text="begin "+SchemeName+"EDITFORMULA_PG.delete_formula(:par1); commit; end;";
    dmMain->quMain->ParamByName("par1")->AsInteger=((POINTSDIV*)TreeView1->Selected->Data)->Mid;
    dmMain->quMain->Execute();
    edFormula->Clear();
    ((POINTSDIV*)TreeView1->Selected->Data)->formula[0]=0;
  }
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::aGuidExecute(TObject *Sender)
{
  TTreeNode *sNode=TreeView1->Selected;
   if(!sNode||!sNode->Data)
    return;
   if(((POINTSDIV*)TreeView1->Selected->Data)->Mid)
   TfmGuid::fmGuidShow(this,((POINTSDIV*)TreeView1->Selected->Data)->Mid,((POINTSDIV*)TreeView1->Selected->Data)->Type,
   ((POINTSDIV*)TreeView1->Selected->Data)->Name);
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::aSpezParExecute(TObject *Sender)
{
  TTreeNode *sNode=TreeView1->Selected;
  if(!sNode||!sNode->Data)
    return;
  if(((POINTSDIV*)TreeView1->Selected->Data)->Mid)
   TfmSpecParam::fmSpecParamShow(this,((POINTSDIV*)TreeView1->Selected->Data)->Mid,0);
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::aBorder2ParExecute(TObject *Sender)
{
  TTreeNode *sNode=TreeView1->Selected;
  if(!sNode||!sNode->Data)
    return;
  if(((POINTSDIV*)TreeView1->Selected->Data)->Mid)
    TfmSpecParam::fmSpecParamShow(this,((POINTSDIV*)TreeView1->Selected->Data)->Mid,1);
}
//---------------------------------------------------------------------------


void __fastcall TFormEditFiders::tbKoeffClick(TObject *Sender)
{
 TTreeNode *sNode=TreeView1->Selected;
   if(!sNode||!sNode->Data||(((POINTSDIV*)sNode->Data)->Type!=3&&((POINTSDIV*)sNode->Data)->Type!=4))
      return;

 TfmKoeff * fm =new TfmKoeff(Owner,((POINTSDIV*)sNode->Data)->Mid,((POINTSDIV*)sNode->Data)->Name,(Access==accWrite));
 fm->ShowModal();
 delete fm;
}
//---------------------------------------------------------------------------

void __fastcall TFormEditFiders::tbPriorClick(TObject *Sender)
{
  TTreeNode *sNode=TreeView1->Selected;
  if(!sNode||!sNode->Data||(((POINTSDIV*)sNode->Data)->Type!=4))
        return;

 TfmPrior * fm =new TfmPrior(Owner,((POINTSDIV*)sNode->Data)->Mid,(Access==accWrite));
 fm->ShowModal();
 delete fm;
}
//---------------------------------------------------------------------------


void __fastcall TFormEditFiders::sbKMeterClick(TObject *Sender)
{
 bool test=true;
 if(Edit9->Text.ToDouble()==0||Edit10->Text.ToDouble()==0||Edit14->Text.ToDouble()==0||Edit11->Text.ToDouble()==0)
   test=false;

  if(Sender==sbKMeter)
  {
   if(!test)
   Edit16->Text=FloatToStr(1);
   else
   Edit16->Text=FloatToStr((Edit9->Text.ToDouble()*Edit10->Text.ToDouble())/(Edit14->Text.ToDouble()*Edit11->Text.ToDouble()));
  }
  if(Sender==sbKC)
   {
   if(!test)
   Edit15->Text=FloatToStr(1);
   else
   Edit15->Text=FloatToStr((Edit9->Text.ToDouble()*Edit10->Text.ToDouble())/(Edit14->Text.ToDouble()*Edit11->Text.ToDouble()));
   }
}

//---------------------------------------------------------------------------

void __fastcall TFormEditFiders::aURDExecute(TObject *Sender)
{
    TTreeNode *sNode=TreeView1->Selected;
  if(!sNode||!sNode->Data)
    return;
  if(((POINTSDIV*)TreeView1->Selected->Data)->Mid)
    TfmSpecParam::fmSpecParamShow(this,((POINTSDIV*)TreeView1->Selected->Data)->Mid,2);
}
//---------------------------------------------------------------------------

void __fastcall TFormEditFiders::cbIntgrChange(TObject *Sender)
{
 TTreeNode *sNode=TreeView1->Selected;
  if(!sNode||!sNode->Data||((POINTSDIV*)sNode->Data)->Type==1)
    return;
  if(((POINTSDIV*)sNode->Data)->editing!=2)
    ((POINTSDIV*)sNode->Data)->editing=2;
  EditRec=true;  
}
//---------------------------------------------------------------------------


void __fastcall TFormEditFiders::PopupMenu1Popup(TObject *Sender)
{
 if(TreeView1->Selected&&TreeView1->Selected->Data)
      {
         FORMS *fms;
         fms=(FORMS*)mMon->Tag ;
         if(!fms) fms = new FORMS;
         ZeroMemory(fms, sizeof(FORMS));
         if(TreeView1->Selected&&TreeView1->Selected->Data)
          fms->gid = ((POINTSDIV*)TreeView1->Selected->Data)->Mid;
          fms->tmplCode=0;
          mMon->Tag = (int)fms;
          createSubMenu_F(mMon);
       }
}
//--------------------------------------------------------------------------- 
void __fastcall TFormEditFiders::miManualInpClick(TObject *Sender)
{
  TAccess acc;
  int gid;
  TMainForm*Child;

  if(Sender==miManIn){
     acc = miManIn->Tag==1?accWrite:(miManIn->Tag==0?accRead:accDenied);
      //22.08.2019 UNKEY VERSION SUBSTR COMMENT BELLOW
    if(/*GrdGetPermission(CHK_LIC_TASK,CHK_LIC_TASK_MANUAL)>0&&*/TreeView1->Selected&&TreeView1->Selected->Data){
        //END COMMENT
          gid = ((POINTSDIV*)TreeView1->Selected->Data)->Mid;

    Child= new TfmManualInput(Application,miManIn->Caption, gid,1,acc);
    Child->TaskId=603;
  }
  }

  if(Sender==miManMetr){
      acc = miManMetr->Tag==1?accWrite:(miManMetr->Tag==0?accRead:accDenied);
      //22.08.2019 UNKEY VERSION SUBSTR COMMENT BELLOW
    if(/*GrdGetPermission(CHK_LIC_TASK,CHK_LIC_TASK_MANUAL)>0&&*/TreeView1->Selected&&TreeView1->Selected->Data){
    //END COMMENT
          gid = ((POINTSDIV*)TreeView1->Selected->Data)->Mid;

    Child= new TfmManualInputMeter(Application,miManMetr->Caption, gid,1,acc);
    Child->TaskId=608;
  }
  }
}
//---------------------------------------------------------------------------

void __fastcall TFormEditFiders::tbclonFormulClick(TObject *Sender)
{
   TfmSelectPoint*sp;

    GROUPDATAFORM gdf;
    gdf.gid = ((POINTSDIV*)TreeView1->Selected->Data)->Mid;
    gdf.type = 1;
    sp = new TfmSelectPoint(this, &gdf);
    sp->Caption = "Выбор источника для копирования формул";
    sp->HelpContext=25034;

    if(sp->ShowModal()==mrOk){
        int img = sp->tvMain->Selected->ImageIndex;
        if((img==4 || img==5)&&((POINTSDIV*)TreeView1->Selected->Data)->Mid!=gdf.gid){



        oqClonF->SQL->Text="begin "+SchemeName+"EDITFEEDERS_PG.clon_formulas(:par1,:par2); end;";
        oqClonF->ParamByName("par1")->AsInteger=gdf.gid;
        oqClonF->ParamByName("par2")->AsInteger=((POINTSDIV*)TreeView1->Selected->Data)->Mid;
        oqClonF->Execute();
        }
      else
      {
      MessageBox(this->Handle,"Не правильно выбран источник для копирования формул",(this->Caption+Reconst_smes20_66.c_str()).c_str(),MB_ICONINFORMATION);
      }
     }

    delete sp;
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::SetAccMenuOFF(void)
{
  bool loff=false;
  TTreeNode *sNode=TreeView1->Selected;
  bool lacc=(accOFF&&sNode&&sNode->Data&&((POINTSDIV*)sNode->Data)->Type>=3&&((POINTSDIV*)sNode->Data)->Mid);
  if(lacc){
    switch (((POINTSDIV*)sNode->Data)->lOFF){
      case 1:
         lbStateOFF->Caption="Отключен "+AnsiString(((POINTSDIV*)sNode->Data)->vOFF);
         loff=true;
         break;
      case 0: ;
         lbStateOFF->Caption="Включен "+AnsiString(((POINTSDIV*)sNode->Data)->vOFF);
         break;
      default:
         lbStateOFF->Caption="Неизвестно";
    }
  }else{
    lbStateOFF->Caption="";
  }
  lbStateOFF->Font->Color=(loff)?clBlue:clWindowText;
  mnLineOFF->Visible=lacc;
  mnLineOFF->Enabled=lacc;
  mnOFF->Visible=lacc;
  mnOFF->Enabled=lacc;
  mnONCancel->Visible=lacc;
  mnONCancel->Enabled=lacc;
  mnON->Visible=lacc;
  mnON->Enabled=lacc;
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::mnONOFFClick(TObject *Sender)
{
  TTreeNode *sNode=TreeView1->Selected;
  if(accOFF&&sNode&&sNode->Data&&((POINTSDIV*)sNode->Data)->Type>=3&&((POINTSDIV*)sNode->Data)->Mid)
    dmMain->SetCommandOff(((POINTSDIV*)sNode->Data)->Mid,((TComponent *)Sender)->Tag);
}

//GRB ADD 30.05.2019
//---------------------------------------------------------------------------
/*TFormEditFiders::EIC_INFO TFormEditFiders:: getCompanyInfo (TObject *Sender){
        EIC_INFO ret;
        oqGetCompanyInfo->Execute();
        ret.vfullname = oqGetCompanyInfo->ParamByName("par6")->AsString;
        ret.vshortname = oqGetCompanyInfo->ParamByName("par7")->AsString;
        ret.veic_code = oqGetCompanyInfo->ParamByName("par5")->AsString;
        AnsiString codeZone1, codeZone2;
        AnsiString is1, is2;
        codeZone1 = codeZone2 = is1 = is2 = "";
        codeZone1 = oqGetCompanyInfo->ParamByName("par8")->AsString;
        codeZone2 = oqGetCompanyInfo->ParamByName("par9")->AsString;
        is1 = oqGetCompanyInfo->ParamByName("par10")->AsString;
        is2 = oqGetCompanyInfo->ParamByName("par11")->AsString;


        bool bis1 = !(CompareStr (is1,"y"));
        bool bis2 = !(CompareStr (is2,"y"));

        TStringList* tradeZones = getTradeZones (codeZone1, codeZone2, bis1, bis2);
        ret.tradeZoneUkr = codeZone1; //сохраняем торговые доступные торговые зоны в структуре
        ret.tradeZoneBrsht = codeZone2;
        ret.isTradeZoneUkr = bis1;
        ret.isTradeZoneBrsht = bis2;
        */
        /*ComboBox1->Items->Clear();
        for (int i = 0 ; i < tradeZones->Count; i++){
                AnsiString curr = tradeZones->Strings[i];
                ComboBox1->Items->Add(curr);
                if (i==0) {
                        ComboBox1->Text = curr;
                }
        }
        showTradeZones();*/
        /*delete tradeZones;
        return ret;
}*/
//---------------------------------------------------------------------------
TFormEditFiders::EIC_INFO TFormEditFiders::getCompanyInfoGlobal (TObject *Sender, TStringList** companyList){
        EIC_INFO ret;
        try{
        oqGetCompanyInfo->Execute();
        ret.vfullname = oqGetCompanyInfo->ParamByName("par6")->AsString;
        ret.vshortname = oqGetCompanyInfo->ParamByName("par7")->AsString;
        ret.veic_code = oqGetCompanyInfo->ParamByName("par5")->AsString;
        AnsiString codeZone1, codeZone2;
        AnsiString is1, is2;
        codeZone1 = codeZone2 = is1 = is2 = "";
        codeZone1 = oqGetCompanyInfo->ParamByName("par8")->AsString;
        codeZone2 = oqGetCompanyInfo->ParamByName("par9")->AsString;
        is1 = oqGetCompanyInfo->ParamByName("par10")->AsString;
        is2 = oqGetCompanyInfo->ParamByName("par11")->AsString;

        bool bis1 = !(CompareStr (is1,"y"));
        bool bis2 = !(CompareStr (is2,"y"));

        *companyList = getTradeZones(codeZone1, codeZone2, bis1, bis2);
        ret.tradeZoneUkr = codeZone1; //сохраняем торговые доступные торговые зоны в структуре
        ret.tradeZoneBrsht = codeZone2;
        ret.isTradeZoneUkr = bis1;
        ret.isTradeZoneBrsht = bis2;
        }catch (Exception &ex){
        ret.vfullname = "";
        ret.vshortname = "";
        ret.veic_code ="";
        ret.tradeZoneUkr = "";
        ret.tradeZoneBrsht = "";
        ret.isTradeZoneUkr = false;
        ret.isTradeZoneBrsht = false;
        throw ex;
        }
        return ret;

}

//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::hideTradeZones(){
        ComboBox1->Visible = false;
        Label44->Visible = false;
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::showTradeZones(){
        ComboBox1->Visible = true;
        Label44->Visible = true;
}


//---------------------------------------------------------------------------

void __fastcall TFormEditFiders::RadioGroup1Click(TObject *Sender)
{
  int position_Radio = RadioGroup1->ItemIndex;
  Edit26->Enabled = true;
  TTreeNode *sNode=TreeView1->Selected;
  POINTSDIV *PTreeTable=(POINTSDIV*)sNode->Data;
  ((POINTSDIV*)sNode->Data)->editing=2;
  switch (position_Radio){
        case 0: {
           showTradeZones();
           Edit26->Enabled = false;
           EIC_INFO ret = globalCompanyInfo;//getCompanyInfo(this);
           AnsiString text = ComboBox1->Text;
           AnsiString v_code = getCodeZoneByName (text);
           Edit26->Text = v_code;
           break;
        }
        case 1: {
           Edit26->Enabled = true;
           hideTradeZones();
           break;
        }
        case 2: {
           Edit26->Enabled = true;
           hideTradeZones();
           break;
        }
  }
  //GRB ADD 15.07.2019
  //Вот этот код ниже раскоментировать для того чтобы при дёрганьи радиогруппы иерархии mms (Торговая зона-Область учёта - Поставщик) mms для группы пользователем автоматом разрешало пересохранять без всяких дополнительных телодвижений вроде изменения имени группы
  //Так заковыристо сделано, поскольку в RadioGroup1Click мы попадаем не только по клику юзера но и при движении по mms-иерархии при раскрытии дерева и там разрешать изменения НЕ НАДО
  TRadioGroup* whoSend=dynamic_cast<TRadioGroup*>(Sender);
  if (whoSend)
        EditRec = true;
  
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::EICCheckboxClick (TObject *Sender){
  TTreeNode *sNode=TreeView1->Selected;
        if(!sNode||!sNode->Data||((POINTSDIV*)sNode->Data)->Type==1)
                return;
        ((POINTSDIV*)sNode->Data)->editing=2;
        if (Panel31->FindChildControl("EICCheckbox")){
                TCheckBox* cbx = static_cast<TCheckBox*>(Sender);
                bool status = cbx->Checked;
				//GRB ADD 31.01.2020 - баг при уборе или добавлении галки тут же не устанавливается кнопка сохранить активной
                if ((cbx->Focused())&&(status==false)){ //чувак клацнул по чекбоксу который был до этого включён
                        EditRec = true;
                }
                if (status){
                changePanel31Height(3);
                }else{
                changePanel31Height(2);
                }
                RadioGroup1Click(Sender);
        }
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::addEICCheckBoxOnPanel (TObject *Sender){
        TCheckBox *exist =(TCheckBox *) Panel31->FindChildControl("EICCheckbox");
        if (!exist){
            TCheckBox *cbx = new TCheckBox (Sender);
            int old_height = Panel31->Height;
            cbx->Parent = Panel31;
            cbx->Name = "EICCheckbox";
            //Начали локализацию
            //GRB ADD 22.08.2019 - правим бажок с локализацией динамики
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
            if (Language =="UKR") cbx->Caption = "Структура комерційного обліку";
            else
            //END ADD 
            cbx->Caption = "Структура коммерческого учёта";
            cbx->Width = 240;
            cbx->Left = 5;
            cbx->Top = old_height + 10;
            cbx->Checked = false;
            cbx->OnClick = EICCheckboxClick;
            }
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::removeEICCheckBoxOnPanel (TObject *Sender){
   if (Panel31->FindChildControl("EICCheckbox")){
            delete (Panel31->FindChildControl("EICCheckbox"));
   }
}

//---------------------------------------------------------------------------

void __fastcall TFormEditFiders::RadioGroup2Click(TObject *Sender){
//считаем что чел будет точку а не группу добавлять
 //05.07.2019 GRB Comment - по требованию кальницкой
 Edit28->Text = "";
 //END COMMENT
 TTreeNode *sNode=TreeView1->Selected;
 POINTSDIV *PTreeTable=(POINTSDIV*)sNode->Data;
 Edit28->Text = PTreeTable->eic_info.veic_code;
 if (RadioGroup2->ItemIndex==1){
        Label46->Visible = true;
        Edit28->Visible = true;
        PTreeTable->eic_info.mms = "*";
 }else{
        Label46->Visible = false;
        Edit28->Visible = false;
        PTreeTable->eic_info.mms = "";
 }
}
//---------------------------------------------------------------------------
TStringList* __fastcall TFormEditFiders::getTradeZones (AnsiString codeZone1, AnsiString codeZone2, bool is1, bool is2 ){
        TStringList* ret = new TStringList();
        if (is1) ret->Add (UKRAINE_ZONE);
        if (is2) ret->Add (BURSHTIN_ZONE);
        return ret;
}
//---------------------------------------------------------------------------
AnsiString __fastcall TFormEditFiders::getCodeZoneByName (AnsiString zoneName){
   AnsiString ret = "";
   EIC_INFO info = globalCompanyInfo;
   if (CompareStr(zoneName,UKRAINE_ZONE)==0) {
        return info.tradeZoneUkr;
   }
   if (CompareStr(zoneName,BURSHTIN_ZONE)==0) {
        return info.tradeZoneBrsht;
   }
   return ret;
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::ComboBox1Change(TObject *Sender)
{
        Edit26->Text = "";
        AnsiString str = "";
        EIC_INFO ret;
        oqGetCompanyInfo->Execute();
        ret.vfullname = oqGetCompanyInfo->ParamByName("par6")->AsString;
        ret.vshortname = oqGetCompanyInfo->ParamByName("par7")->AsString;
        ret.veic_code = oqGetCompanyInfo->ParamByName("par5")->AsString;
        AnsiString codeZone1, codeZone2;
        AnsiString is1, is2;
        codeZone1 = codeZone2 = is1 = is2 = "";
        codeZone1 = oqGetCompanyInfo->ParamByName("par8")->AsString;
        codeZone2 = oqGetCompanyInfo->ParamByName("par9")->AsString;
        is1 = oqGetCompanyInfo->ParamByName("par10")->AsString;
        is2 = oqGetCompanyInfo->ParamByName("par11")->AsString;
        bool bis1 = !(CompareStr (is1,"y"));
        bool bis2 = !(CompareStr (is2,"y"));

        TStringList* tradeZones = getTradeZones (codeZone1, codeZone2, bis1, bis2);
        ret.tradeZoneUkr = codeZone1; //сохраняем торговые доступные торговые зоны в структуре
        ret.tradeZoneBrsht = codeZone2;
        ret.isTradeZoneUkr = bis1;
        ret.isTradeZoneBrsht = bis2;

        if (CompareStr(ComboBox1->Text,UKRAINE_ZONE)==0) {
                str = ret.tradeZoneUkr;
        }
        if (CompareStr(ComboBox1->Text,BURSHTIN_ZONE)==0) {
                str = ret.tradeZoneBrsht;
        }
        Edit26->Text = str;
        delete tradeZones;
}
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders::changePanel31Height(int state){
        switch (state){
        case 1:{
        Panel31->Height = PANEL31_HEIGHT_SMALL;// начальное состояние
        break;
        }
        case 2:{
        Panel31->Height = PANEL31_HEIGHT_WITH_CHECKBOX;// показывать чекбокс переключения
        break;
        }
        case 3:{
        Panel31->Height = PANEL31_HEIGHT_ALL;//с mms полями
        break;
        }
        }
}
//---------------------------------------------------------------------------
int __fastcall TFormEditFiders::getPanel31HeightState (){
  int height = Panel31->Height;
  switch (height){
  case PANEL31_HEIGHT_SMALL:{
        return 1;
  }
  case PANEL31_HEIGHT_WITH_CHECKBOX:{
        return 2;
  }
  case PANEL31_HEIGHT_ALL:{
        return 3;
  }
  }
}
//---------------------------------------------------------------------------
//10.09.2020 GRB ADD: Поскольку смена контекса регистрации формата для буфера обмена с пользовательского для дерева CF_POINTS_TREENODE на стандартный текстовый CF_TEXT
// при смене фокуса с дерева нихрена не помогла, то теперь обрабатывать ctrl+c, ctrl+v, ctrl-x(удаление выделенного фрагмента из эдита с помещением его в Сlipboard), ctrl-z(циклическое прохождение всего что там было)
//для эдитов с панели эдитфидерс будет самописный код

void __fastcall TFormEditFiders::vAnyEditClickEditFiders(TObject *Sender){
  TCustomEdit *pEdit;
  TComponent  *pMenu;
  try
  { pMenu = dynamic_cast<TComponent *>(Sender);
    pEdit = dynamic_cast<TCustomEdit *>(ActiveControl);

    if ((pEdit != NULL) && (pMenu != NULL))
      if (pMenu->Tag==1){//ctrl+a
          //pEdit->CutToClipboard();
          char* bufferCat;
          AnsiString source = pEdit->SelText;
          HGLOBAL clipbuffer;
	  EmptyClipboard();
	  clipbuffer = GlobalAlloc(GMEM_DDESHARE, source.Length()+1);
	  bufferCat = (char*)GlobalLock(clipbuffer);
          //GRB CHANGE 17.08.2021
	  strcpy(bufferCat, source.c_str());
          //END CHANGE
          //BLOCK TO CHANGE
          //strncpy(bufferCat, source.c_str(),sizeof(bufferCat) - 1);
          //bufferCat[sizeof(bufferCat) - 1] = '\0';
          //END BLOCK
	  GlobalUnlock(clipbuffer);
	  SetClipboardData(CF_TEXT,clipbuffer);
          //а теперь вырезаем  выделенную часть из самого эдита
          pEdit->Text = StringReplace( pEdit->Text, pEdit->SelText, "", TReplaceFlags( ));
      }
      if (pMenu->Tag==2){//clrt+s
          //pEdit->CopyToClipboard();
          char * bufferCopy;
          AnsiString source = pEdit->SelText;
          HGLOBAL clipbuffer;
	  EmptyClipboard();
	  clipbuffer = GlobalAlloc(GMEM_DDESHARE, source.Length()+1);
	  bufferCopy = (char*)GlobalLock(clipbuffer);
	  strcpy(bufferCopy, source.c_str());
	  GlobalUnlock(clipbuffer);
	  SetClipboardData(CF_TEXT,clipbuffer);
      }
      if (pMenu->Tag==3){//ctrl+v
          //pEdit->PasteFromClipboard();
          char * bufferPaste;
          AnsiString fromClipboard;
          HANDLE hData = GetClipboardData( CF_TEXT );
	  bufferPaste = (char*)GlobalLock( hData );
	  fromClipboard = bufferPaste;
	  GlobalUnlock( hData );
          //pEdit->Text = fromClipboard;  //так неправильно
          modifyEdit (pEdit, fromClipboard);
      }
      if (pMenu->Tag==4){//ctrl+z
          pEdit->SelectAll();
          pEdit->ClearSelection();
      }
      if (pMenu->Tag==5){//ctrl+a
          pEdit->SelectAll();
      }
  }
  catch (Exception &e)
  {
  }
}
//вставляем из клипбоарда в позицию курсора точку эдита
//---------------------------------------------------------------------------
void __fastcall TFormEditFiders:: modifyEdit(TCustomEdit * TCE, AnsiString toEdit){
        int selStart = TCE->SelStart;
        int sizeToEdit = toEdit.Length();
        AnsiString newValueOfEdit = TCE->Text.Insert (toEdit,selStart+1);
        //GRB ADD 12.08.2021 - пробуем не дать
        int wasFieldLength = TCE->Text.Length();
        TEdit* te = (TEdit*)TCE;
        int maxLength = te->MaxLength;
        if (maxLength>0){
                if ((wasFieldLength+sizeToEdit)<=maxLength){
                        if ((selStart+sizeToEdit)>=maxLength){
                                int razn = maxLength-selStart;
                                AnsiString toEdit2 = toEdit;
                                toEdit2 = toEdit2.SubString(1,razn);
                                newValueOfEdit  = TCE->Text.Insert (toEdit2,selStart+1);
                                TCE->Text = newValueOfEdit;
                                TCE->SetFocus();
                                TCE->SelStart = selStart+toEdit2.Length();
                                return;
                        }else{
                                int new_size = maxLength-(selStart+sizeToEdit);
                                AnsiString toEditPartMediocre = toEdit;
                                toEditPartMediocre = toEditPartMediocre.SubString(1,new_size);
                                newValueOfEdit  = TCE->Text.Insert (toEditPartMediocre,selStart+1);
                                TCE->Text = newValueOfEdit;
                                TCE->SetFocus();
                                TCE->SelStart = selStart+toEditPartMediocre.Length();
                                return;
                        }
                }else{
                 int razn2 = (wasFieldLength+sizeToEdit)-maxLength;
                 //int new_size = maxLength-(selStart+sizeToEdit-1);
                 //????toEditPartMediocre = toEditPartMediocre.SubString(1,new_size);
                 if ((wasFieldLength+sizeToEdit) > maxLength){
                  int chank =  maxLength - wasFieldLength;
                  toEdit= toEdit.SubString (1,chank);
                 }
                 newValueOfEdit = TCE->Text.Insert (toEdit,selStart+1);
                 TCE->Text = newValueOfEdit;
                 TCE->SetFocus();
                 TCE->SelStart = selStart+toEdit.Length();
                 return;
                }
         }
        //end ADD
        TCE->Text = newValueOfEdit;
        //и переводим курсор за позицию вставленного
        TCE->SetFocus();
        TCE->SelStart = selStart+toEdit.Length();
}
//---------------------------------------------------------------------------
bool __fastcall TFormEditFiders::checkVerifyDailyByFormat(AnsiString checkParam){
        AnsiString rowValue = checkParam;//eVerifyDay->Text;
        if (rowValue.IsEmpty()) return true;
        bool compre = false;
        compre = rowValue.Pos(";");
        if (compre){
        TStringList *stringList = new TStringList;
        stringList->Delimiter = ';';
        stringList->Clear();
        stringList->DelimitedText=rowValue;
        if (stringList->Count!=2)   return false;
        AnsiString s1 = stringList->Strings[0]; // word1
        AnsiString s2 = stringList->Strings[1]; // word2
        double test = 0;
        if (!checkFloat (s1,test)){
           return false;
        }
        test = 0;
        if (!checkFloat (s2,test)){
           return false;
        }
        delete stringList;
        return true;
        }
        return false;
}
//---------------------------------------------------------------------------
bool __fastcall TFormEditFiders::checkFloat (AnsiString s, double d){
        bool ret = false;
        if (s.IsEmpty()) return true;
        ret = TryStrToFloat (s,d);
        if (ret == false) return ret;
        if ((s.Pos("e")!=0)||(s.Pos("E")!=0)) return false;
        return ret;
}
//---------------------------------------------------------------------------






