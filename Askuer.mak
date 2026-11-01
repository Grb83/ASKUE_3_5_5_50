# ---------------------------------------------------------------------------
!if !$d(BCB)
BCB = $(MAKEDIR)\..
!endif

# ---------------------------------------------------------------------------
# IDE SECTION
# ---------------------------------------------------------------------------
# The following section of the project makefile is managed by the BCB IDE.
# It is recommended to use the IDE to change any of the values in this
# section.
# ---------------------------------------------------------------------------

VERSION = BCB.05.03
# ---------------------------------------------------------------------------
PROJECT = Askuer.exe
OBJFILES = .obj\Askuer.obj .obj\Ioci.obj .obj\Ascue.obj .obj\un_utl.obj \
    .obj\OraTable.obj .obj\Find.obj .obj\Filter.obj .obj\Main.obj \
    .obj\setpasword.obj .obj\unAbout.obj .obj\ControlVolueDB.obj \
    .obj\EditCOMportList.obj .obj\EditCounter.obj .obj\EditDeportationPlan.obj \
    .obj\EditExportGropsList.obj .obj\EditGroupsList.obj .obj\EditMaket.obj \
    .obj\EditRates.obj .obj\EditSchema.obj .obj\EditTariff.obj \
    .obj\EditTimeMaxLoad.obj .obj\InterpriseRename.obj \
    .obj\OperScanSchEdit.obj .obj\ParamCommunicationServer.obj \
    .obj\SaveMonitorAs.obj .obj\SetupMonitorRefresh.obj .obj\SetupMonitors.obj \
    .obj\PrintDrawTable.obj .obj\JournalAlert.obj \
    .obj\UpdateImagesForSpeedButtons.obj .obj\UserEdit.obj .obj\ListUsers.obj \
    .obj\selectpoint.obj .obj\consump.obj .obj\ChannelPointsList.obj \
    .obj\ParameterPointsList.obj .obj\EditRequestPlan.obj \
    .obj\InputSwitchMeterage.obj .obj\SelectSvitchPoint.obj .obj\SwitchOV.obj \
    .obj\FidersList.obj .obj\EditIntrodactPulsCout.obj \
    .obj\ReportDepartment.obj .obj\ReportDayChenge.obj .obj\ReportGroups.obj \
    .obj\Vit_Meter.obj .obj\Vit_Delta.obj .obj\Vit_deltaExcel.obj \
    .obj\Vit_input.obj .obj\VIT_InputExcel.obj .obj\CountParam.obj \
    .obj\GetDataIntCounter.obj .obj\ChangeCounters.obj \
    .obj\OperScanSchedEd.obj .obj\OperScanSched.obj .obj\OperScanPointPar.obj \
    .obj\EditFiders.obj .obj\unWorkTime.obj .obj\unCalcParam.obj \
    .obj\SupperMain.obj .obj\RolsEdit.obj .obj\TaskMenu.obj \
    .obj\MONITORFORM.obj .obj\Interior.obj .obj\Interior2xDrawTableChart.obj \
    .obj\FormDescr.obj .obj\Saa_SelectGroup.obj .obj\Saa_SelectGroupProc.obj \
    .obj\Saa_SelectForm.obj .obj\RolsList.obj .obj\EditShemsList.obj \
    .obj\SplitForm.obj .obj\Monitor.obj .obj\PageCtrlSpl.obj \
    .obj\MonitorAlert.obj .obj\Interior1.obj .obj\Interior2.obj \
    .obj\Interior4.obj .obj\InteriorChart.obj .obj\InteriorDU.obj \
    .obj\InteriorEx.obj .obj\InteriorJournal.obj .obj\InteriorJournalSys.obj \
    .obj\InteriorLimCons.obj .obj\InteriorLimitPower.obj \
    .obj\InteriorLimConsDebt.obj .obj\InteriorConsImbalance.obj \
    .obj\InteriorExRep.obj .obj\InteriorExOpForm.obj .obj\InteriorDecad.obj \
    .obj\InteriorPLProc.obj .obj\InteriorDU2Chart.obj .obj\InteriorModus.obj \
    .obj\InteriorMaket.obj .obj\InteriorAlert.obj .obj\EditFormsList.obj \
    .obj\OperScanSchList.obj .obj\MonitorList.obj .obj\DeportProcsSched.obj \
    .obj\DeportProcRun.obj .obj\DeportProcs.obj .obj\ImportDatafiles.obj \
    .obj\RequestMonitoring.obj .obj\LastSave.obj .obj\GetSelectDateTime.obj \
    .obj\CopySchemaParams.obj .obj\ChangeTransformers.obj \
    .obj\InputParameters.obj .obj\InputParameters4.obj \
    .obj\EditTransformers.obj .obj\InteriorExRepOut.obj
RESFILES = Askuer.res
MAINSOURCE = Askuer.cpp
RESDEPEN = $(RESFILES) Find.dfm Filter.dfm Main.dfm setpasword.dfm unAbout.dfm \
    ControlVolueDB.dfm EditCOMportList.dfm EditCounter.dfm \
    EditDeportationPlan.dfm EditExportGropsList.dfm EditGroupsList.dfm \
    EditMaket.dfm EditRates.dfm EditSchema.dfm EditTariff.dfm \
    EditTimeMaxLoad.dfm InterpriseRename.dfm OperScanSchEdit.dfm \
    ParamCommunicationServer.dfm SaveMonitorAs.dfm \
    SetupMonitor\SetupMonitorRefresh.dfm SetupMonitor\SetupMonitors.dfm \
    MonitorForm\PrintDrawTable.dfm MonitorAlert\JournalAlert.dfm UserEdit.dfm \
    ListUsers.dfm Indic\selectpoint.dfm Indic\consump.dfm \
    ChannelPointsList.dfm ParameterPointsList.dfm EditRequestPlan.dfm \
    InputSwitchMeterage.dfm SelectSvitchPoint.dfm SwitchOV.dfm FidersList.dfm \
    EditIntrodactPulsCout.dfm ReportsForm\ReportDepartment.dfm \
    ReportsForm\ReportDayChenge.dfm ReportsForm\ReportGroups.dfm Vit_Meter.dfm \
    Vit_Delta.dfm Vit_deltaExcel.dfm Vit_input.dfm VIT_InputExcel.dfm \
    CountParam.dfm GetDataIntCounter.dfm ChangeCounters.dfm \
    OperScanSchedEd.dfm OperScanSched.dfm OperScanPointPar.dfm EditFiders.dfm \
    unWorkTime.dfm unCalcParam.dfm SupperMain.dfm RolsEdit.dfm TaskMenu.dfm \
    MonitorForm\MONITORFORM.dfm Saa_SelectGroup.dfm Saa_SelectGroupProc.dfm \
    Saa_SelectForm.dfm RolsList.dfm EditShemsList.dfm SplitForm\SplitForm.dfm \
    SplitForm\Monitor.dfm EditFormsList.dfm OperScanSchList.dfm \
    MonitorList.dfm DeportProcsSched.dfm DeportProcRun.dfm DeportProcs.dfm \
    ImportDatafiles.dfm RequestMonitoring.dfm LastSave.dfm \
    GetSelectDateTime.dfm CopySchemaParams.dfm ChangeTransformers.dfm \
    InputParameters.dfm InputParameters4.dfm EditTransformers.dfm
LIBFILES = ..\..\Lib\CommLib.lib ..\..\Lib\OCIW32.LIB
IDLFILES = 
IDLGENFILES = 
LIBRARIES = CRControls50.lib schem.lib sde.lib dclusr50.lib DAC50.lib \
    bcb2kaxserver50.lib Qrpt50.lib bcb97axserver50.lib Tee50.lib MyTable.lib \
    dclocx50.lib bcbsmp50.lib vcldbx50.lib vclbde50.lib vcldb50.lib vclx50.lib \
    vcl50.lib
PACKAGES = Vcl50.bpi Vclx50.bpi bcbsmp50.bpi Vcldb50.bpi vclado50.bpi ibsmp50.bpi \
    VCLBDE50.bpi vcldbx50.bpi Qrpt50.bpi TeeUI50.bpi TeeDB50.bpi Tee50.bpi \
    Dss50.bpi TeeQR50.bpi VCLIB50.bpi Vclmid50.bpi vclie50.bpi Inetdb50.bpi \
    Inet50.bpi NMFast50.bpi webmid50.bpi MyTable.bpi bcb97axserver50.bpi
SPARELIBS = vcl50.lib vclx50.lib vcldb50.lib vclbde50.lib vcldbx50.lib bcbsmp50.lib \
    dclocx50.lib MyTable.lib Tee50.lib bcb97axserver50.lib Qrpt50.lib \
    bcb2kaxserver50.lib DAC50.lib dclusr50.lib sde.lib schem.lib \
    CRControls50.lib
DEFFILE = 
# ---------------------------------------------------------------------------
PATHCPP = .;SetupMonitor;MonitorForm;MonitorAlert;Indic;ReportsForm;SplitForm
PATHASM = .;
PATHPAS = .;
PATHRC = .;
DEBUGLIBPATH = $(BCB)\lib\debug
RELEASELIBPATH = $(BCB)\lib\release
USERDEFINES = _DEBUG
SYSDEFINES = NO_STRICT
INCLUDEPATH = ;;;..\..;..\..\include;Indic;$(BCB)\Projects;ReportsForm;$(BCB)\Bin;$(BCB)\Imports;setupmonitor;dialup;monitoralert;splitform;monitorform;$(BCB)\include;$(BCB)\include\vcl;$(BCB)\ODAC\Include;$(BCB)\VTR_DTable;$(BCB)\ODAC;$(BCB)\ODAC\CRGrid
LIBPATH = ;;;..\..;..\..\Lib;Indic;$(BCB)\Projects;ReportsForm;$(BCB)\ODAC\Lib;$(BCB)\Imports;$(BCB)\Projects\Lib;$(BCB)\Projects\Bpl;setupmonitor;dialup;monitoralert;splitform;monitorform;$(BCB)\lib;$(BCB)\bin;$(BCB)\lib\obj;$(BCB)\VTR_DTable;$(BCB)\ODAC\CBuilder5;$(BCB)\ODAC\CRGrid
WARNINGS= -w-par -w-8027 -w-8026
# ---------------------------------------------------------------------------
CFLAG1 = -Od -H=$(BCB)\lib\vcl50.csm -Hc -Vx -Ve -X- -r- -a8 -b- -k -y -v -vi- -c \
    -tWM
IDLCFLAGS = -I..\.. -I..\..\include -IIndic -I$(BCB)\Projects -IReportsForm \
    -I$(BCB)\Bin -I$(BCB)\Imports -Isetupmonitor -Idialup -Imonitoralert \
    -Isplitform -Imonitorform -I$(BCB)\include -I$(BCB)\include\vcl \
    -I$(BCB)\ODAC\Include -I$(BCB)\VTR_DTable -I$(BCB)\ODAC \
    -I$(BCB)\ODAC\CRGrid -src_suffix cpp -D_DEBUG -no_tie -boa
PFLAGS = -AWinTypes=Windows;WinProcs=Windows;DbiTypes=BDE;DbiProcs=BDE;DbiErrs=BDE \
    -N2.obj -N0.obj -$Y+ -$W -$O- -v -JPHNV -M -JPHNE
RFLAGS = 
AFLAGS = /mu /w0 /zi
LFLAGS = -I.obj -D"" -aa -Tpe -x -Gn -v
# ---------------------------------------------------------------------------
ALLOBJ = c0w32.obj sysinit.obj $(OBJFILES)
ALLRES = $(RESFILES)
ALLLIB = $(LIBFILES) $(LIBRARIES) import32.lib cp32mt.lib
# ---------------------------------------------------------------------------
!ifdef IDEOPTIONS

[Version Info]
IncludeVerInfo=0
AutoIncBuild=0
MajorVer=1
MinorVer=0
Release=0
Build=0
Debug=0
PreRelease=0
Special=0
Private=0
DLL=0

[Version Info Keys]
CompanyName=
FileDescription=
FileVersion=1.0.0.0
InternalName=
LegalCopyright=
LegalTrademarks=
OriginalFilename=
ProductName=
ProductVersion=1.0.0.0
Comments=

[Debugging]
DebugSourceDirs=$(BCB)\source\vcl

!endif





# ---------------------------------------------------------------------------
# MAKE SECTION
# ---------------------------------------------------------------------------
# This section of the project file is not used by the BCB IDE.  It is for
# the benefit of building from the command-line using the MAKE utility.
# ---------------------------------------------------------------------------

.autodepend
# ---------------------------------------------------------------------------
!if "$(USERDEFINES)" != ""
AUSERDEFINES = -d$(USERDEFINES:;= -d)
!else
AUSERDEFINES =
!endif

!if !$d(BCC32)
BCC32 = bcc32
!endif

!if !$d(CPP32)
CPP32 = cpp32
!endif

!if !$d(DCC32)
DCC32 = dcc32
!endif

!if !$d(TASM32)
TASM32 = tasm32
!endif

!if !$d(LINKER)
LINKER = ilink32
!endif

!if !$d(BRCC32)
BRCC32 = brcc32
!endif


# ---------------------------------------------------------------------------
!if $d(PATHCPP)
.PATH.CPP = $(PATHCPP)
.PATH.C   = $(PATHCPP)
!endif

!if $d(PATHPAS)
.PATH.PAS = $(PATHPAS)
!endif

!if $d(PATHASM)
.PATH.ASM = $(PATHASM)
!endif

!if $d(PATHRC)
.PATH.RC  = $(PATHRC)
!endif
# ---------------------------------------------------------------------------
$(PROJECT): $(IDLGENFILES) $(OBJFILES) $(RESDEPEN) $(DEFFILE)
    $(BCB)\BIN\$(LINKER) @&&!
    $(LFLAGS) -L$(LIBPATH) +
    $(ALLOBJ), +
    $(PROJECT),, +
    $(ALLLIB), +
    $(DEFFILE), +
    $(ALLRES)
!
# ---------------------------------------------------------------------------
.pas.hpp:
    $(BCB)\BIN\$(DCC32) $(PFLAGS) -U$(INCLUDEPATH) -D$(USERDEFINES);$(SYSDEFINES) -O$(INCLUDEPATH) --BCB {$< }

.pas.obj:
    $(BCB)\BIN\$(DCC32) $(PFLAGS) -U$(INCLUDEPATH) -D$(USERDEFINES);$(SYSDEFINES) -O$(INCLUDEPATH) --BCB {$< }

.cpp.obj:
    $(BCB)\BIN\$(BCC32) $(CFLAG1) $(WARNINGS) -I$(INCLUDEPATH) -D$(USERDEFINES);$(SYSDEFINES) -n$(@D) {$< }

.c.obj:
    $(BCB)\BIN\$(BCC32) $(CFLAG1) $(WARNINGS) -I$(INCLUDEPATH) -D$(USERDEFINES);$(SYSDEFINES) -n$(@D) {$< }

.c.i:
    $(BCB)\BIN\$(CPP32) $(CFLAG1) $(WARNINGS) -I$(INCLUDEPATH) -D$(USERDEFINES);$(SYSDEFINES) -n. {$< }

.cpp.i:
    $(BCB)\BIN\$(CPP32) $(CFLAG1) $(WARNINGS) -I$(INCLUDEPATH) -D$(USERDEFINES);$(SYSDEFINES) -n. {$< }

.asm.obj:
    $(BCB)\BIN\$(TASM32) $(AFLAGS) -i$(INCLUDEPATH:;= -i) $(AUSERDEFINES) -d$(SYSDEFINES:;= -d) $<, $@

.rc.res:
    $(BCB)\BIN\$(BRCC32) $(RFLAGS) -I$(INCLUDEPATH) -D$(USERDEFINES);$(SYSDEFINES) -fo$@ $<
# ---------------------------------------------------------------------------




