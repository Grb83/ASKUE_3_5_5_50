object dmMain: TdmMain
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 330
  Top = 153
  Height = 373
  Width = 542
  object orases: TOraSession
    ConnectPrompt = False
    Options.NeverConnect = True
    AutoCommit = False
    AfterConnect = orasesAfterConnect
    BeforeConnect = orasesBeforeConnect
    Left = 38
    Top = 4
  end
  object quMain: TOraQuery
    Session = orases
    SQL.Strings = (
      '')
    ReadOnly = True
    AutoCommit = False
    Options.ReturnParams = True
    Left = 162
    Top = 8
  end
  object qwUtil: TOraQuery
    Session = orases
    Left = 32
    Top = 124
  end
  object qwInter: TOraQuery
    Session = orases
    AutoCommit = False
    Options.ReturnParams = True
    Left = 266
    Top = 8
  end
  object qwIntMaket: TOraQuery
    Session = orases
    SQL.Strings = (
      '')
    AutoCommit = False
    Options.ReturnParams = True
    Left = 266
    Top = 66
  end
  object orasesAlert: TOraSession
    ConnectPrompt = False
    AutoCommit = False
    Left = 40
    Top = 242
  end
  object qwAlert: TOraQuery
    Session = orasesAlert
    AutoCommit = False
    Options.ReturnParams = True
    Left = 124
    Top = 238
  end
  object qwIntMaket2: TOraQuery
    Session = orases
    AutoCommit = False
    Options.ReturnParams = True
    Left = 266
    Top = 120
  end
  object oqCursor2: TOraQuery
    Session = orases
    SQL.Strings = (
      'select NSRV,VNAME from ryda.srv order by nsrv')
    ReadOnly = True
    AutoCommit = False
    Left = 378
    Top = 56
  end
  object oqInit: TOraQuery
    Session = orases
    SQL.Strings = (
      'begin '
      'ryda.common_pg.begin_p(:par3);'
      ':par1:=ryda.util_pg.get_customer_id;'
      ':par2:=ryda.util_pg.obsolescence_f;'
      ':par4:=nvl(ryda.util_pg.enterprisename_f,'#39' '#39');'
      ':par5:=ryda.util_pg.stepprofile_f*60;'
      ':par6:=ryda.util_pg.lenprofile_f*3600;'
      ':par7:=ryda.util_pg.stephalfhour_f;'
      ':par8:=ryda.common_pg.naccperiod;'
      ':par9:=ryda.util_pg.warning_f;'
      
        'select count(*) into :par10 from ryda.feeders where mid not in (' +
        'select mid from ryda.pointformula);'
      ':par11:=ryda.util_pg.getparamvalue_f(56);'
      'commit;'
      'end;')
    ReadOnly = True
    AutoCommit = False
    Options.ReturnParams = True
    Left = 160
    Top = 74
    ParamData = <
      item
        DataType = ftInteger
        Name = 'par3'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'par1'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'par2'
        ParamType = ptOutput
        Size = 2000
      end
      item
        DataType = ftString
        Name = 'par4'
        ParamType = ptOutput
        Size = 2000
      end
      item
        DataType = ftInteger
        Name = 'par5'
        ParamType = ptOutput
      end
      item
        DataType = ftInteger
        Name = 'par6'
        ParamType = ptOutput
      end
      item
        DataType = ftInteger
        Name = 'par7'
        ParamType = ptOutput
      end
      item
        DataType = ftInteger
        Name = 'par8'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'par9'
        ParamType = ptOutput
        Size = 2000
      end
      item
        DataType = ftInteger
        Name = 'par10'
        ParamType = ptOutput
      end
      item
        DataType = ftInteger
        Name = 'par11'
        ParamType = ptOutput
      end>
  end
  object oqChMeter: TOraQuery
    Session = orases
    AutoCommit = False
    Left = 234
    Top = 238
  end
  object oqCursor: TOraQuery
    Session = orases
    AutoCommit = False
    Left = 380
    Top = 118
  end
  object oqInterCursor: TOraQuery
    Session = orases
    AutoCommit = False
    Left = 386
    Top = 174
  end
  object oqHighLightButtons: TOraQuery
    Session = orases
    SQL.Strings = (
      'begin'
      '  ryda.CTS_PG.SHOW_CTS_DS(:SERV, :SHOW_SERV);'
      'end;')
    Left = 368
    Top = 260
    ParamData = <
      item
        DataType = ftInteger
        Name = 'SERV'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'SHOW_SERV'
        ParamType = ptOutput
      end>
  end
  object oqFormsEX: TOraQuery
    Session = orases
    SQL.Strings = (
      '')
    AutoCommit = False
    Left = 462
    Top = 250
    object oqFormsEXFILEBODY: TBlobField
      FieldName = 'FILEBODY'
      Required = True
    end
  end
  object oqGTZ: TOraQuery
    Session = orases
    AutoCommit = False
    Options.ReturnParams = True
    Left = 326
    Top = 10
  end
  object oqAlertTimeZona: TOraQuery
    Session = orasesAlert
    AutoCommit = False
    Options.ReturnParams = True
    Left = 120
    Top = 296
  end
  object oqFindFile: TOraQuery
    Session = orases
    SQL.Strings = (
      'begin ryda.un_main_pg.get_pas(:a_cur);end;')
    AutoCommit = False
    Left = 474
    Top = 26
    ParamData = <
      item
        DataType = ftCursor
        Name = 'a_cur'
        Value = 'Object'
      end>
  end
  object oqMenu_G: TOraQuery
    Session = orases
    AutoCommit = False
    Left = 476
    Top = 106
  end
  object tmStatus: TTimer
    Enabled = False
    Interval = 60000
    OnTimer = tmStatusTimer
    Left = 114
    Top = 174
  end
  object oqCursorUnic: TOraQuery
    Session = orases
    Left = 440
    Top = 184
  end
end
