//---------------------------------------------------------------------------
#ifndef PrintDrawTableH
#define PrintDrawTableH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Db.hpp>
#include <DBCtrls.hpp>
#include <DBGrids.hpp>
#include <ExtCtrls.hpp>
#include <Grids.hpp>
#include <QuickRpt.hpp>
#include <VirtualTable.hpp>
#include <Qrctrls.hpp>
#include <DB.hpp>
#include <QRCtrls.hpp>
#include "Interior.h"
//---------------------------------------------------------------------------
class TfmQR : public TForm
{
__published:	// IDE-managed Components
        TDataSource *DataSource1;
        TDBGrid *DBGrid1;
        TListBox *ListBox1;
        TQuickRep *MRQuickRep;
        TQRBand *QRBand2;
        TQRDBText *MRQRDBTextSubRowName;
        TQRDBText *MRQRDBText1;
        TQRDBText *MRQRDBText2;
        TQRBand *TitleBand1;
        TQRLabel *MRQRLabelTitle;
        TQRLabel *MRQRLabelComment;
        TQRBand *QRBand1;
        TQRGroup *QRGroup1;
        TQRDBText *MRQRDBTextRowName;
        TQRLabel *MRQRLabel1;
        TQRLabel *MRQRLabel2;
        TQRLabel *MRQRLabel3;
        TQRLabel *MRQRLabel4;
        TQRLabel *MRQRLabel5;
        TQRLabel *MRQRLabel6;
        TQRLabel *MRQRLabel7;
        TQRLabel *MRQRLabel8;
        TQRLabel *MRQRLabel9;
        TQRDBText *MRQRDBText3;
        TQRDBText *MRQRDBText4;
        TQRDBText *MRQRDBText5;
        TQRDBText *MRQRDBText6;
        TQRDBText *MRQRDBText7;
        TQRDBText *MRQRDBText8;
        TQRDBText *MRQRDBText9;
        TQuickRep *SRQuickRep;
        TQRBand *QRBand3;
        TQRDBText *SRQRDBTextRowName;
        TQRDBText *SRQRDBText1;
        TQRDBText *SRQRDBText2;
        TQRDBText *SRQRDBText3;
        TQRDBText *SRQRDBText4;
        TQRDBText *SRQRDBText5;
        TQRDBText *SRQRDBText6;
        TQRDBText *SRQRDBText7;
        TQRDBText *SRQRDBText8;
        TQRDBText *SRQRDBText9;
        TQRBand *QRBand4;
        TQRLabel *SRQRLabelTitle;
        TQRLabel *SRQRLabelComment;
        TQRBand *QRBand5;
        TQRLabel *SRQRLabel1;
        TQRLabel *SRQRLabel2;
        TQRLabel *SRQRLabel3;
        TQRLabel *SRQRLabel4;
        TQRLabel *SRQRLabel5;
        TQRLabel *SRQRLabel6;
        TQRLabel *SRQRLabel7;
        TQRLabel *SRQRLabel8;
        TQRLabel *SRQRLabel9;
        TQRLabel *MRQRLabel10;
        TQRLabel *MRQRLabel11;
        TQRDBText *MRQRDBText10;
        TQRDBText *MRQRDBText11;
        TQRLabel *SRQRLabel10;
        TQRLabel *SRQRLabel11;
        TQRDBText *SRQRDBText10;
        TQRDBText *SRQRDBText11;
private:	// User declarations
public:		// User declarations
        __fastcall TfmQR(TComponent* Owner);
};

class TPrintDrawTable : public TComponent
{
private:	// User declarations
        TList *RepFormList;
        TList *RepList;
public:		// User declarations
        TPrintDialog *PD;
        __fastcall TPrintDrawTable(TComponent* Owner);
	virtual __fastcall ~TPrintDrawTable(void);
        void __fastcall PrintTable(AnsiString aTitle, AnsiString aComment, TStrings *aColumnsCaption,
                                            TVirtualTable *aVT_PrintData, int aColumhNameWidth, int aColumnWidth, int aRepType, TFormDescr *fd);
        void __fastcall SaveTableToFile(AnsiString aTitle, AnsiString aComment, TStrings *aColumnsCaption,
                                            TVirtualTable *aVT_PrintData, int aColumhNameWidth, int aColumnWidth, int aRepType, AnsiString aFileName, WORD aFlags);
        // aFlags - 0х0 - Разделители Tab шапка не печатается


};
//---------------------------------------------------------------------------
#endif
