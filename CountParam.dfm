object FormCountParam: TFormCountParam
  Left = 591
  Top = 128
  HelpContext = 518
  BorderStyle = bsDialog
  Caption = #1040#1090#1088#1080#1073#1091#1090#1099' '#1089#1095#1077#1090#1095#1080#1082#1072
  ClientHeight = 435
  ClientWidth = 555
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 555
    Height = 65
    Align = alTop
    Caption = 'Panel1'
    TabOrder = 2
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 553
      Height = 32
      Align = alTop
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Caption = '             '#1058#1086#1095#1082#1072' '#1091#1095#1077#1090#1072':'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object Edit1: TEdit
        Left = 158
        Top = 6
        Width = 393
        Height = 24
        TabStop = False
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 0
      end
    end
    object Panel3: TPanel
      Left = 1
      Top = 33
      Width = 553
      Height = 31
      Align = alClient
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Caption = '             '#1044#1072#1090#1072' '#1079#1072#1084#1077#1085#1099':'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      object DateTimePicker1: TDateTimePicker
        Left = 158
        Top = 4
        Width = 186
        Height = 22
        CalAlignment = dtaLeft
        Date = 37017
        Time = 37017
        DateFormat = dfLong
        DateMode = dmComboBox
        Kind = dtkDate
        ParseInput = False
        TabOrder = 0
      end
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 65
    Width = 555
    Height = 24
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel4'
    TabOrder = 3
    object Panel5: TPanel
      Left = 0
      Top = 0
      Width = 185
      Height = 24
      Align = alLeft
      Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      TabOrder = 0
    end
    object Panel6: TPanel
      Left = 185
      Top = 0
      Width = 185
      Height = 24
      Align = alLeft
      Caption = #1057#1084#1077#1085#1103#1077#1084#1099#1081' '#1089#1095#1077#1090#1095#1080#1082
      TabOrder = 1
    end
    object Panel8: TPanel
      Left = 370
      Top = 0
      Width = 185
      Height = 24
      Align = alLeft
      Caption = #1059#1089#1090#1072#1085#1072#1074#1083#1080#1074#1072#1077#1084#1099#1081' '#1089#1095#1077#1090#1095#1080#1082
      TabOrder = 2
    end
  end
  object Panel7: TPanel
    Left = 0
    Top = 89
    Width = 555
    Height = 210
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel7'
    TabOrder = 0
    object Panel9: TPanel
      Left = 0
      Top = 189
      Width = 555
      Height = 21
      Align = alTop
      Alignment = taLeftJustify
      Caption = '         '#1042#1088#1077#1084#1103' '#1089#1085#1103#1090#1080#1103' '#1080' '#1091#1089#1090#1072#1085#1086#1074#1082#1080':'
      TabOrder = 9
      object Edit12: TMaskEdit
        Tag = 12
        Left = 184
        Top = 2
        Width = 187
        Height = 21
        EditMask = '!00:00;1;_'
        MaxLength = 5
        TabOrder = 0
        Text = '  :  '
        OnChange = Edit12Change
      end
      object Edit22: TMaskEdit
        Tag = 12
        Left = 372
        Top = 0
        Width = 182
        Height = 21
        EditMask = '!00:00;1;_'
        MaxLength = 5
        ReadOnly = True
        TabOrder = 1
        Text = '  :  '
      end
    end
    object Panel11: TPanel
      Left = 0
      Top = 147
      Width = 555
      Height = 21
      Align = alTop
      Alignment = taLeftJustify
      Caption = '         '#1048#1084#1087'./'#1082#1042#1090#1095':'
      TabOrder = 7
      object Edit10: TEdit
        Left = 184
        Top = 2
        Width = 187
        Height = 21
        TabStop = False
        ReadOnly = True
        TabOrder = 0
      end
      object Edit20: TEdit
        Tag = 11
        Left = 372
        Top = 0
        Width = 182
        Height = 21
        MaxLength = 10
        TabOrder = 1
        OnChange = ChangeInt
      end
    end
    object Panel12: TPanel
      Left = 0
      Top = 126
      Width = 555
      Height = 21
      Align = alTop
      Alignment = taLeftJustify
      Caption = '         '#1055#1083#1086#1084#1073#1072', '#1082#1074#1072#1088#1090#1072#1083':'
      TabOrder = 6
      object Edit9: TEdit
        Left = 184
        Top = 0
        Width = 187
        Height = 21
        TabStop = False
        ReadOnly = True
        TabOrder = 0
      end
      object Edit19: TEdit
        Tag = 11
        Left = 372
        Top = 0
        Width = 182
        Height = 21
        MaxLength = 1
        TabOrder = 1
        OnChange = ChangeInt
      end
    end
    object Panel13: TPanel
      Left = 0
      Top = 105
      Width = 555
      Height = 21
      Align = alTop
      Alignment = taLeftJustify
      Caption = '         '#1055#1083#1086#1084#1073#1072', '#1075#1086#1076' :'
      TabOrder = 5
      object Edit18: TEdit
        Tag = 11
        Left = 372
        Top = 0
        Width = 182
        Height = 21
        MaxLength = 4
        TabOrder = 1
        OnChange = ChangeInt
      end
      object Edit8: TEdit
        Left = 184
        Top = 2
        Width = 187
        Height = 21
        TabStop = False
        ReadOnly = True
        TabOrder = 0
      end
    end
    object Panel14: TPanel
      Left = 0
      Top = 84
      Width = 555
      Height = 21
      Align = alTop
      Alignment = taLeftJustify
      Caption = '         '#1042#1086#1083#1100#1090#1099'(V):'
      TabOrder = 4
      object Edit7: TEdit
        Left = 184
        Top = 0
        Width = 187
        Height = 21
        TabStop = False
        ReadOnly = True
        TabOrder = 0
      end
      object Edit17: TEdit
        Tag = 11
        Left = 372
        Top = 0
        Width = 182
        Height = 21
        MaxLength = 10
        TabOrder = 1
        OnChange = ChangeInt
      end
    end
    object Panel15: TPanel
      Left = 0
      Top = 63
      Width = 555
      Height = 21
      Align = alTop
      Alignment = taLeftJustify
      Caption = '         '#1040#1084#1087#1077#1088#1099' ('#1040'):'
      TabOrder = 3
      object Edit6: TEdit
        Left = 184
        Top = 0
        Width = 187
        Height = 21
        TabStop = False
        ReadOnly = True
        TabOrder = 0
      end
      object Edit16: TEdit
        Tag = 11
        Left = 372
        Top = 0
        Width = 182
        Height = 21
        MaxLength = 10
        TabOrder = 1
        OnChange = ChangeInt
      end
    end
    object Panel16: TPanel
      Left = 0
      Top = 42
      Width = 555
      Height = 21
      Align = alTop
      Alignment = taLeftJustify
      Caption = '         '#1058#1080#1087' '#1089#1095#1077#1090#1095#1080#1082#1072':'
      TabOrder = 2
      object Edit5: TEdit
        Left = 184
        Top = 0
        Width = 187
        Height = 21
        TabStop = False
        ReadOnly = True
        TabOrder = 0
      end
      object Edit15: TEdit
        Left = 372
        Top = 0
        Width = 182
        Height = 21
        MaxLength = 49
        TabOrder = 1
      end
    end
    object Panel17: TPanel
      Left = 0
      Top = 21
      Width = 555
      Height = 21
      Align = alTop
      Alignment = taLeftJustify
      Caption = '         '#1056#1072#1079#1088#1103#1076#1085#1086#1089#1090#1100':'
      TabOrder = 1
      object Edit4: TEdit
        Left = 184
        Top = 0
        Width = 187
        Height = 21
        TabStop = False
        ReadOnly = True
        TabOrder = 0
      end
      object Edit14: TEdit
        Left = 372
        Top = 0
        Width = 182
        Height = 21
        MaxLength = 19
        TabOrder = 1
      end
    end
    object Panel18: TPanel
      Left = 0
      Top = 0
      Width = 555
      Height = 21
      Align = alTop
      Alignment = taLeftJustify
      Caption = '         '#1047#1072#1074#1086#1076#1089#1082#1086#1081' '#8470' :'
      TabOrder = 0
      object Edit3: TEdit
        Left = 184
        Top = 0
        Width = 187
        Height = 21
        TabStop = False
        ReadOnly = True
        TabOrder = 1
      end
      object Edit13: TEdit
        Left = 372
        Top = 0
        Width = 182
        Height = 21
        MaxLength = 19
        TabOrder = 0
        OnExit = Edit13Exit
      end
    end
    object Panel19: TPanel
      Left = 0
      Top = 168
      Width = 555
      Height = 21
      Align = alTop
      Alignment = taLeftJustify
      Caption = '         '#1050#1083#1072#1089#1089':'
      TabOrder = 8
      object Edit11: TEdit
        Left = 184
        Top = 2
        Width = 187
        Height = 21
        TabStop = False
        ReadOnly = True
        TabOrder = 0
      end
      object Edit21: TEdit
        Tag = 11
        Left = 372
        Top = 0
        Width = 182
        Height = 21
        MaxLength = 5
        TabOrder = 1
        OnChange = ChangeDouble
      end
    end
  end
  object Panel10: TPanel
    Left = 0
    Top = 403
    Width = 555
    Height = 32
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 7
    object BitBtn2: TBitBtn
      Left = 476
      Top = 4
      Width = 75
      Height = 25
      Cancel = True
      Caption = #1054#1090#1084#1077#1085#1072
      TabOrder = 1
      OnClick = BitBtn2Click
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333000033338833333333333333333F333333333333
        0000333911833333983333333388F333333F3333000033391118333911833333
        38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
        911118111118333338F3338F833338F3000033333911111111833333338F3338
        3333F8330000333333911111183333333338F333333F83330000333333311111
        8333333333338F3333383333000033333339111183333333333338F333833333
        00003333339111118333333333333833338F3333000033333911181118333333
        33338333338F333300003333911183911183333333383338F338F33300003333
        9118333911183333338F33838F338F33000033333913333391113333338FF833
        38F338F300003333333333333919333333388333338FFF830000333333333333
        3333333333333333333888330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
    object BitBtn1: TBitBtn
      Left = 396
      Top = 4
      Width = 75
      Height = 25
      Caption = 'OK'
      Default = True
      Enabled = False
      TabOrder = 0
      OnClick = BitBtn1Click
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
  end
  object Panel20: TPanel
    Left = 0
    Top = 373
    Width = 555
    Height = 31
    Align = alTop
    TabOrder = 6
    object BitBtn3: TBitBtn
      Left = 224
      Top = 3
      Width = 127
      Height = 25
      Caption = #1055#1086#1082#1072#1079#1072#1085#1080#1103
      TabOrder = 0
      OnClick = BitBtn3Click
    end
  end
  object Panel21: TPanel
    Left = 0
    Top = 347
    Width = 555
    Height = 26
    Align = alTop
    Alignment = taLeftJustify
    Caption = '         '#1044#1086#1073#1072#1074#1083#1077#1085#1085#1086#1077' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1101#1085#1077#1088#1075#1080#1080':'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    object Edit25: TEdit
      Tag = 11
      Left = 278
      Top = 2
      Width = 187
      Height = 21
      TabOrder = 0
      OnChange = ChangeDouble
    end
  end
  object Panel22: TPanel
    Left = 0
    Top = 299
    Width = 555
    Height = 22
    Align = alTop
    Alignment = taLeftJustify
    Caption = '         '#1055#1086#1082#1072#1079#1072#1085#1080#1077':'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    object Edit23: TEdit
      Tag = 11
      Left = 184
      Top = 0
      Width = 187
      Height = 21
      MaxLength = 16
      TabOrder = 0
      OnChange = ChangeDouble
    end
    object Edit24: TEdit
      Tag = 11
      Left = 372
      Top = 0
      Width = 182
      Height = 21
      MaxLength = 16
      TabOrder = 1
      OnChange = ChangeDouble
    end
  end
  object Panel23: TPanel
    Left = 0
    Top = 321
    Width = 555
    Height = 26
    Align = alTop
    Alignment = taLeftJustify
    Caption = '         '#1055#1088#1080#1084#1077#1095#1072#1085#1080#1077':'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object Edit2: TEdit
      Tag = 11
      Left = 184
      Top = 2
      Width = 369
      Height = 21
      MaxLength = 255
      TabOrder = 0
    end
  end
  object oqTreeWriteNew: TOraQuery
    Session = dmMain.orases
    SQL.Strings = (
      'begin'
      
        '  ryda.CHANGE_METER.Change_meter_p(:AN_MID,to_date(:AD_DATE_TIME' +
        '_D,'#39'dd.mm.yyyy hh24:mi'#39'), :AT_M, :AN_ENTYPE, :AV_SMART, :AV_MTRS' +
        'N,to_date(:AD_DATE_TIME,'#39'dd.mm.yyyy hh24:mi'#39'), :AN_DIGITS, :AV_M' +
        'TYPE, :AN_MCURRENT, :AN_MPOWER, :AN_MCONST, :AN_MCLASS, :AN_MYEA' +
        'R, :AN_MQUARTER, :AV_MEMO, :AT_NEW_M);'
      'end;')
    AutoCommit = False
    Options.ReturnParams = True
    Left = 410
    Top = 6
    ParamData = <
      item
        DataType = ftFloat
        Name = 'AN_MID'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'AD_DATE_TIME_D'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'AT_M'
        ParamType = ptInput
        Table = True
      end
      item
        DataType = ftFloat
        Name = 'AN_ENTYPE'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AV_SMART'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AV_MTRSN'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'AD_DATE_TIME'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'AN_DIGITS'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AV_MTYPE'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'AN_MCURRENT'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'AN_MPOWER'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'AN_MCONST'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'AN_MCLASS'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'AN_MYEAR'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'AN_MQUARTER'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AV_MEMO'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'AT_NEW_M'
        ParamType = ptInput
        Table = True
      end>
  end
  object oqSelect: TSmartQuery
    Session = dmMain.orases
    SQL.Strings = (
      'begin'
      '  RYDA.CHANGE_METER.Select_data(:PMID, :PENTYPE, :PDATA);'
      'end;')
    Left = 272
    Top = 8
    ParamData = <
      item
        DataType = ftFloat
        Name = 'PMID'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'PENTYPE'
        ParamType = ptInput
      end
      item
        DataType = ftCursor
        Name = 'PDATA'
        ParamType = ptOutput
        Value = 'Object'
      end>
    object oqSelectID: TFloatField
      FieldName = 'ID'
      Required = True
    end
    object oqSelectNAME: TStringField
      FieldName = 'NAME'
      Size = 150
    end
    object oqSelectSMART: TStringField
      FieldName = 'SMART'
      Size = 1
    end
    object oqSelectMTRSN: TStringField
      FieldName = 'MTRSN'
    end
    object oqSelectDIGITS: TFloatField
      FieldName = 'DIGITS'
    end
    object oqSelectMTYPE: TStringField
      FieldName = 'MTYPE'
      Size = 50
    end
    object oqSelectMCURRENT: TFloatField
      FieldName = 'MCURRENT'
    end
    object oqSelectMPOWER: TFloatField
      FieldName = 'MPOWER'
    end
    object oqSelectMCONST: TFloatField
      FieldName = 'MCONST'
    end
    object oqSelectMCLASS: TFloatField
      FieldName = 'MCLASS'
    end
    object oqSelectMYEAR: TFloatField
      FieldName = 'MYEAR'
    end
    object oqSelectMQUARTER: TFloatField
      FieldName = 'MQUARTER'
    end
  end
  object oqBorder: TSmartQuery
    Session = dmMain.orases
    SQL.Strings = (
      'begin'
      
        '  RYDA.CHANGE_METER.Select_Border(:PQUERY_TYPE, :PMID, :PCHANGED' +
        'ATE, :PMTRSN, :PDATA);'
      'end;')
    Left = 154
    Top = 4
    ParamData = <
      item
        DataType = ftFloat
        Name = 'PQUERY_TYPE'
        ParamType = ptInput
        Value = 1
      end
      item
        DataType = ftFloat
        Name = 'PMID'
        ParamType = ptInput
        Value = 1
      end
      item
        DataType = ftString
        Name = 'PCHANGEDATE'
        ParamType = ptInput
        Value = '10.11.2009'
      end
      item
        DataType = ftString
        Name = 'PMTRSN'
        ParamType = ptInput
        Value = '1'
      end
      item
        DataType = ftCursor
        Name = 'PDATA'
        ParamType = ptOutput
        Value = 'Object'
      end>
    object oqBorderDTMIN: TStringField
      FieldName = 'DTMIN'
      Size = 16
    end
    object oqBorderDTMAX: TStringField
      FieldName = 'DTMAX'
      Size = 16
    end
  end
  object oqMeterDemIndic: TOraQuery
    Session = dmMain.orases
    SQL.Strings = (
      'begin'
      
        'ryda.change_meter.MeterDemIndic(:mmid, :ddate, :ER_MTRSN, :data_' +
        't);'
      'end;')
    Left = 478
    Top = 16
    ParamData = <
      item
        Name = 'mmid'
        ParamType = ptInput
        Value = ''
        ExtDataType = 107
      end
      item
        DataType = ftDateTime
        Name = 'ddate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ER_MTRSN'
        ParamType = ptInput
      end
      item
        DataType = ftCursor
        Name = 'data_t'
        Value = 'Object'
      end>
  end
end
