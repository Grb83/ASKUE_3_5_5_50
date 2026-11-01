//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#include "EditTariff.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "DrawTable"
#pragma resource "*.dfm"
#define MAXCOUNTARRAY 100
//---------------------------------------------------------------------------
__fastcall TEditTariffForm::TEditTariffForm(TComponent* Owner, AnsiString Name, TAccess a)
   : TMainForm(Owner, Name, a)
{
   TreeDecr[0]= 50;
   TreeDecr[1]= 50;
}
//---------------------------------------------------------------------------

void __fastcall TEditTariffForm::SetAccess(TAccess value)
{
   if(FAccess != value) {
      TMainForm::SetAccess(value);
      bool write = value==accWrite;
      iaNew->Enabled = write;
      iaDelete->Enabled = write;
      DrawTable->Enabled = write;
   }
}
//---------------------------------------------------------------------------
void __fastcall TEditTariffForm::vSave(TObject* Sender)
{
   if(!EditRec) return;
   TARIFF tData;
   long FTariffType = (long)cbTariffType->Items->Objects[cbTariffType->ItemIndex];
   try{
      //GRB ADD 16.04.2020 - test trouble ODAC
      dmMain->quMain->Params->Clear();
      //END ADD 
      dmMain->quMain->SQL->Text="begin \
                     if :par3 = 1 then \
                        "+SchemeName+"tariff_pg.ins_data(:par5,:par1, :par2); \
                     else \
                        "+SchemeName+"tariff_pg.upd_data(:par5,:par4, :par1, :par2); \
                     end if; \
                  end;";


      for(int i=0; i<mTariff.Count(); i++){
         if(mTariff[i].editing==2){
            memcpy(&tData, &mTariff[i], sizeof(TARIFF));
            dmMain->quMain->ParamByName("par1")->AsString=tData.bData;
            dmMain->quMain->ParamByName("par2")->AsFloat=tData.Value;
            dmMain->quMain->ParamByName("par3")->AsInteger=tData.editing;
            dmMain->quMain->ParamByName("par4")->AsString=tData.kData;
            dmMain->quMain->ParamByName("par5")->AsInteger=FTariffType;
            dmMain->quMain->Execute();
         }
      }
      for(int i=0; i<mTariff.Count(); i++){
         if(mTariff[i].editing==1){
            memcpy(&tData, &mTariff[i], sizeof(TARIFF));
            dmMain->quMain->ParamByName("par1")->AsString=tData.bData;
            dmMain->quMain->ParamByName("par2")->AsFloat=tData.Value;
            dmMain->quMain->ParamByName("par3")->AsInteger=tData.editing;
            dmMain->quMain->ParamByName("par4")->AsString=tData.kData;
            dmMain->quMain->ParamByName("par5")->AsInteger=FTariffType;
            dmMain->quMain->Execute();
         }
      }
      //GRB ADD 16.04.2020 - test trouble ODAC
      dmMain->quMain->Params->Clear();
      //END ADD 
      dmMain->quMain->SQL->Text="begin \
                     "+SchemeName+"tariff_pg.del_t(:par2,:par1); \
                  end;";

      for(int i=0; i<mDeleted.Count(); i++){
         memcpy(&tData, &mDeleted[i], sizeof(TARIFF));
         dmMain->quMain->ParamByName("par1")->AsString=tData.kData;
         dmMain->quMain->ParamByName("par2")->AsInteger=FTariffType;
         dmMain->quMain->Execute();
      }
      dmMain->orases->Commit();
      mDeleted.Clear();
      EditRec = false;
   }catch (Exception &e){
      dmMain->orases->Rollback();
      throw;
   }
}
//---------------------------------------------------------------------------

void __fastcall TEditTariffForm::vRefresh(TObject* Sender)
{
   LoadTariffType();
   Load();
   CurrRow = 1;
}
//---------------------------------------------------------------------------

void __fastcall TEditTariffForm::vNew(TObject* Sender)
{
   TARIFF *k = mTariff.First();
   TARIFF *t = mTariff.Add();
   strcpy(t->bData, TDateTime::CurrentDate().FormatString("dd.mm.yyyy").c_str());
   if(k) t->Value = k->Value;
   else t->Value = 0.0;
   t->editing = 1;
   strcpy(t->kData, t->bData);
   EditRec = true;
   UpdateDrawTable();
   CurrRow = mTariff.Count();
   DrawTable->Selection.Top = CurrRow;
   DrawTable->Selection.Bottom = CurrRow;
   DrawTable->Invalidate();
}
//---------------------------------------------------------------------------

void __fastcall TEditTariffForm::vDelete(TObject* Sender)
{
   int ind = CurrRow-1;
   if(ind < 0 || ind >= mTariff.Count())
      return;
   if(mTariff[ind].editing!=1){
      TARIFF *p = mDeleted.Add();
      memcpy(p, &mTariff[ind], sizeof(TARIFF));
   }
   mTariff.Delete(ind);
   EditRec = true;
   UpdateDrawTable();
   if(CurrRow>mTariff.Count()) CurrRow = mTariff.Count();
   else CurrRow = ind+1;
}
//---------------------------------------------------------------------------

bool __fastcall TEditTariffForm::Load()
{
   TARIFF aData[MAXCOUNTLEVEL];

   long FTariffType = (long)cbTariffType->Items->Objects[cbTariffType->ItemIndex];
   try{

      ZeroMemory(&aData, sizeof(aData));
      dmMain->oqCursor->Params->Clear();
      dmMain->oqCursor->SQL->Text="begin "+SchemeName+"tariff_pg.load_p(:par1,:par2);end;";
      dmMain->oqCursor->ParamByName("par2")->DataType=ftCursor;
      dmMain->oqCursor->ParamByName("par2")->ParamType=ptOutput;
      mTariff.Clear();
      dmMain->oqCursor->ParamByName("par1")->AsInteger=FTariffType;
      dmMain->oqCursor->Execute();

      int i=0;
      while(!dmMain->oqCursor->Eof&&i<MAXCOUNTLEVEL){
      if(!dmMain->oqCursor->FieldByName("bData")->IsNull)
      strcpy(aData[i].bData,dmMain->oqCursor->FieldByName("bData")->AsString.c_str());
      aData[i].Value=dmMain->oqCursor->FieldByName("NVALUE")->AsFloat;

            TARIFF *t = mTariff.Add();
            memcpy(t, &aData[i], sizeof(TARIFF));

            strcpy(t->kData, t->bData);
            t->editing = 0;
         dmMain->oqCursor->Next();
         i++;
      }
      UpdateDrawTable();
   }catch(Exception&e){

  	   Application->ShowException(&e);
      return false;
   }
       return true;
}
//---------------------------------------------------------------------------

void __fastcall TEditTariffForm::FormShow(TObject *Sender)
{
   LoadTariffType();
   Load();
   CurrRow = 1;
}
//---------------------------------------------------------------------------

void __fastcall TEditTariffForm::DrawTableSetEditText(TObject *Sender,
      int ACol, int ARow, const AnsiString Value)
{
   if(ACol){
      try{
         mTariff[ARow-1].Value = Value.ToDouble();
         DrawTable->VarStrings->Strings[DrawTable->GetCellAttr(ACol,ARow)->IndexData] = mTariff[ARow-1].Value;
         if(!mTariff[ARow-1].editing) mTariff[ARow-1].editing = 2;
         EditRec = true;
      }catch(Exception&e){
         DrawTable->VarStrings->Strings[DrawTable->GetCellAttr(ACol,ARow)->IndexData] = mTariff[ARow-1].Value;
      }
   }else{
      if(Value.IsEmpty())
         DrawTable->VarStrings->Strings[DrawTable->GetCellAttr(ACol,ARow)->IndexData] = mTariff[ARow-1].bData;
      else try{
         strcpy(mTariff[ARow-1].bData, StrToDateTime(Value).DateString().c_str());
         DrawTable->VarStrings->Strings[DrawTable->GetCellAttr(ACol,ARow)->IndexData] = mTariff[ARow-1].bData;
         if(!mTariff[ARow-1].editing) mTariff[ARow-1].editing = 2;
         EditRec = true;
      }catch(Exception&e){
         DrawTable->VarStrings->Strings[DrawTable->GetCellAttr(ACol,ARow)->IndexData] = mTariff[ARow-1].bData;
      }
   }
}
//---------------------------------------------------------------------------

void __fastcall TEditTariffForm::UpdateDrawTable(void)
{
   DrawTable->StructStrings->Rebuild(mTariff.Count(),2,TreeDecr);
   for(int i=2 ; i<=mTariff.Count(); ++i){
      DrawTable->TabStrings->Add(DrawTable->TabStrings->Strings[1]);
   }
   DrawTable->RowCount = mTariff.Count()+1;
   DrawTable->UpdateTabStrings();
   int j = 0;
   for(int i=0;i<mTariff.Count();i++){
      DrawTable->VarStrings->Strings[j++] = mTariff[i].bData;
      DrawTable->VarStrings->Strings[j++] = mTariff[i].Value;
   }
   DrawTable->Invalidate();
}

void __fastcall TEditTariffForm::SetCurrRow(int value)
{
   if(value>0 && value<=mTariff.Count())
   {
      if(FCurrRow>0 && FCurrRow <= mTariff.Count()){
         TDrawTable::SAttrCell* pCellAttr = (TDrawTable::SAttrCell*)DrawTable->GetCellAttr(0, FCurrRow);
         pCellAttr->BackgroundColor = clWhite;
         pCellAttr->FontColor = clBlack;
         pCellAttr = (TDrawTable::SAttrCell*)DrawTable->GetCellAttr(1, FCurrRow);
         pCellAttr->BackgroundColor = clWhite;
         pCellAttr->FontColor = clBlack;
      }
      FCurrRow = value;
      TDrawTable::SAttrCell* pCellAttr = (TDrawTable::SAttrCell*)DrawTable->GetCellAttr(0, FCurrRow);
      pCellAttr->BackgroundColor = clBlue;
      pCellAttr->FontColor = clWhite;
      pCellAttr = (TDrawTable::SAttrCell*)DrawTable->GetCellAttr(1, FCurrRow);
      pCellAttr->BackgroundColor = clBlue;
      pCellAttr->FontColor = clWhite;
      DrawTable->Invalidate();
   }
}
int __fastcall TEditTariffForm::GetCurrRow()
{
   return FCurrRow;
}

void __fastcall TEditTariffForm::DrawTableClick(TObject *Sender)
{
   CurrRow = DrawTable->Selection.Top;
}
//---------------------------------------------------------------------------

void __fastcall TEditTariffForm::cbTariffTypeChange(TObject *Sender)
{
   static bool skip = false;
   if(skip) return;
   try{
   if(EditRec){
      switch(MessageBox(Handle,Reconst_smes27_1.c_str(),Application->Title.c_str(),MB_YESNOCANCEL|MB_ICONQUESTION|MB_DEFBUTTON1)){
      case IDYES:
         vSave(Sender);
         break;
      case IDNO:
         break;
      case IDCANCEL:
         skip = true;
         cbTariffType->ItemIndex = TariffTypeIndex;
         skip = false;
         return;
      }
   }
   Load();
   EditRec = false;
   CurrRow = 1;
   }catch(Exception&e){
      Application->ShowException(&e);
   }
}
//---------------------------------------------------------------------------

bool __fastcall TEditTariffForm::LoadTariffType(void)
{
 try {
   int currTariff = cbTariffType->ItemIndex;
   dmMain->oqCursor->Params->Clear();
   dmMain->oqCursor->SQL->Text="begin "+SchemeName+"tariff_pg.load_tarifftype_p(:par1);end;";
   dmMain->oqCursor->ParamByName("par1")->DataType=ftCursor;
   dmMain->oqCursor->ParamByName("par1")->ParamType=ptOutput;
   dmMain->oqCursor->Execute();
    cbTariffType->Clear();
   while(!dmMain->oqCursor->Eof){
    cbTariffType->Items->AddObject(dmMain->oqCursor->FieldByName("vname")->AsString,
                                  (TObject *)dmMain->oqCursor->FieldByName("ntarifftype")->AsInteger);
    dmMain->oqCursor->Next();
    }
  
   cbTariffType->ItemIndex = (currTariff==-1)?0:currTariff;
 } catch (Exception &exception){
   Application->ShowException(&exception);
   return false;
 }
   return true;
}
//---------------------------------------------------------------------------

void __fastcall TEditTariffForm::cbTariffTypeEnter(TObject *Sender)
{
   TariffTypeIndex = cbTariffType->ItemIndex;
}
//---------------------------------------------------------------------------

