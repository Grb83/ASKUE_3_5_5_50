object FormSelectSvitchPoint: TFormSelectSvitchPoint
  Left = 395
  Top = 341
  BorderStyle = bsDialog
  Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1087#1077#1088#1077#1082#1083#1102#1095#1077#1085#1080#1077
  ClientHeight = 207
  ClientWidth = 384
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel14: TPanel
    Left = 0
    Top = 178
    Width = 384
    Height = 29
    Align = alBottom
    TabOrder = 1
    object bbOK: TBitBtn
      Left = 224
      Top = 2
      Width = 75
      Height = 25
      Caption = 'OK'
      Default = True
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = bbOKClick
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
    object bbCancel: TBitBtn
      Left = 303
      Top = 2
      Width = 75
      Height = 25
      Caption = #1054#1090#1084#1077#1085#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Kind = bkCancel
    end
    object bbInputMeterage: TBitBtn
      Left = 4
      Top = 2
      Width = 99
      Height = 25
      Caption = #1042#1074#1086#1076' '#1087#1086#1082#1072#1079#1072#1085#1080#1081
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = bbInputMeterageClick
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 384
    Height = 178
    Align = alClient
    TabOrder = 0
    object Label1: TLabel
      Left = 6
      Top = 11
      Width = 175
      Height = 13
      Caption = #1044#1072#1090#1072' / '#1074#1088#1077#1084#1103' '#1074#1082#1083#1102#1095#1077#1085#1080#1103' '#1054#1042':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 10
      Top = 62
      Width = 141
      Height = 13
      Caption = #1054#1073#1093#1086#1076#1085#1086#1081' '#1074#1099#1082#1083#1102#1095#1072#1090#1077#1083#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 13
      Top = 133
      Width = 72
      Height = 13
      Caption = #1058#1086#1095#1082#1072' '#1091#1095#1077#1090#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Image1: TImage
      Left = 173
      Top = 105
      Width = 32
      Height = 32
      AutoSize = True
      Picture.Data = {
        055449636F6E0000010002002020100000000000E80200002600000010101000
        00000000280100000E0300002800000020000000400000000100040000000000
        8002000000000000000000000000000000000000000000000000800000800000
        0080800080000000800080008080000080808000C0C0C0000000FF0000FF0000
        00FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000000000000000
        0000000008888888888888888888888888888880088888888888888888888888
        888888800888888888888887F88888888888888008888888888888700F888888
        88888880088888888888870000F88888888888800888888888887000000F8888
        8888888008888888888700000000F88888888880088888888870000000000F88
        888888800888888887000000000000F88888888008888888700000000000000F
        88888880088888870000000000000000F8888880088888700000000000000000
        0F88888008888700000000000000000000F88880088870000000000000000000
        000F88800887000000000000000000000000F88008777777777000000000F777
        7777788008888888887000000000F8888888888008888888887000000000F888
        8888888008888888887000000000F8888888888008888888887000000000F888
        8888888008888888887000000000F8888888888008888888887000000000F888
        8888888008888888887000000000F8888888888008888888887000000000F888
        8888888008888888887000000000F8888888888008888888887000000000F888
        8888888008888888887000000000F8888888888008888888887000000000F888
        8888888008888888887000000000F88888888880088888888888000000008888
        8888888000000000000000000000000000000000FFFFFFFF8000000180000001
        80000001800080018001C0018003E0018007F001800FF801801FFC01803FFE01
        807FFF0180FFFF8181FFFFC183FFFFE1800FF001800FF001800FF001800FF001
        800FF001800FF001800FF001800FF001800FF001800FF001800FF001800FF001
        800FF001800FF001800FF001800FF001FFFFFFFF280000001000000020000000
        0100040000000000C00000000000000000000000000000000000000000000000
        00008000008000000080800080000000800080008080000080808000C0C0C000
        0000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0000000000
        00000000F888888888888870F8888880F8888870F88888000F888870F8888000
        00F88870F8880000000F8870F88000000000F870F800000000000F70F7777000
        00777770F888800000888870F888800000888870F888800000888870F8888000
        00888870F888800000888870F888800000888870FFFFFF0000FFFFF000005812
        0000000000000F880180870003C0888807E000000FF000F803F8870003C08888
        03C0000003C0000F03C0870003C0888703C0000003C0000003C08700}
    end
    object Label3: TLabel
      Left = 6
      Top = 36
      Width = 184
      Height = 13
      Caption = #1044#1072#1090#1072' / '#1074#1088#1077#1084#1103' '#1074#1099#1082#1083#1102#1095#1077#1085#1080#1103' '#1054#1042':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object sbFind: TSpeedButton
      Left = 354
      Top = 150
      Width = 22
      Height = 20
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000
        0000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF000000000000000000000000000000000000000000FF00FF0000000000C6C6
        C600000000000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF0000000000C6C6C600000000000000000000000000FF00FF0000000000C6C6
        C600000000000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF0000000000C6C6C600000000000000000000000000FF00FF00000000000000
        00000000000000000000000000000000000000000000FF00FF00000000000000
        00000000000000000000000000000000000000000000FF00FF0000000000C6C6
        C60084848400000000000000000000000000000000000000000000000000C6C6
        C6000000000000000000000000000000000000000000FF00FF0000000000C6C6
        C60084848400000000000000000000000000C6C6C6000000000000000000C6C6
        C6000000000000000000000000000000000000000000FF00FF0000000000C6C6
        C60084848400000000000000000000000000C6C6C6000000000000000000C6C6
        C6000000000000000000000000000000000000000000FF00FF00FF00FF000000
        0000848484000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
        FF0000000000C6C6C600848484000000000000000000FF00FF0000000000C6C6
        C600848484000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF000000000000000000000000000000000000000000FF00FF00000000000000
        0000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00848484000000000000000000FF00FF00FF00FF00FF00FF008484
        84000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00848484000000000000000000FF00FF00FF00FF00FF00FF008484
        84000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      OnClick = sbFindClick
    end
    object meDateSwitch: TMaskEdit
      Left = 198
      Top = 8
      Width = 104
      Height = 21
      EditMask = '!99/99/9999 99:99;1; '
      MaxLength = 16
      TabOrder = 0
      Text = '  .  .       :  '
      OnChange = meDateSwitchChange
    end
    object cbOV: TComboBox
      Left = 6
      Top = 80
      Width = 371
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 2
      OnChange = cbOVChange
    end
    object cbPoints: TComboBox
      Left = 6
      Top = 150
      Width = 343
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 3
    end
    object meDateSwitchOff: TMaskEdit
      Left = 198
      Top = 32
      Width = 103
      Height = 21
      EditMask = '!99/99/9999 99:99;1; '
      MaxLength = 16
      TabOrder = 1
      Text = '  .  .       :  '
    end
  end
  object FillSwitchQuery: TSmartQuery
    Session = dmMain.orases
    SQL.Strings = (
      'begin'
      '  ryda.switches_pg.get_swlist(:PAR, :PLIST);'
      'end;')
    Left = 70
    Top = 102
    ParamData = <
      item
        DataType = ftFloat
        Name = 'PAR'
        ParamType = ptInput
      end
      item
        DataType = ftCursor
        Name = 'PLIST'
        ParamType = ptOutput
        Value = 'Object'
      end>
    object FillSwitchQueryMID: TFloatField
      FieldName = 'MID'
      Required = True
    end
    object FillSwitchQueryVNAME: TStringField
      FieldName = 'VNAME'
      Size = 303
    end
  end
  object FillPointQuery: TSmartQuery
    Session = dmMain.orases
    SQL.Strings = (
      'begin'
      '  ryda.switches_pg.get_pointlist(:PARAM, :POINTLIST);'
      'end;')
    Left = 100
    Top = 102
    ParamData = <
      item
        DataType = ftFloat
        Name = 'PARAM'
        ParamType = ptInput
      end
      item
        DataType = ftCursor
        Name = 'POINTLIST'
        ParamType = ptOutput
        Value = 'Object'
      end>
  end
  object HourParProc: TOraStoredProc
    StoredProcName = 'ryda.switches_pg.meterings'
    SQL.Strings = (
      'begin'
      
        '  ryda.switches_pg.meterings(:AN_SWITCH, :AD_SWITCH, :TIME1, :ER' +
        '1, :ED1, :Q11, :Q21, :Q31, :Q41, :TIME2, :ER2, :ED2, :Q12, :Q22,' +
        ' :Q32, :Q42);'
      'end;')
    Left = 280
    Top = 108
    ParamData = <
      item
        DataType = ftFloat
        Name = 'AN_SWITCH'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'AD_SWITCH'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'TIME1'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'ER1'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'ED1'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'Q11'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'Q21'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'Q31'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'Q41'
        ParamType = ptOutput
      end
      item
        DataType = ftDateTime
        Name = 'TIME2'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'ER2'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'ED2'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'Q12'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'Q22'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'Q32'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'Q42'
        ParamType = ptOutput
      end>
  end
  object SetMask: TSmartQuery
    Session = dmMain.orases
    SQL.Strings = (
      'begin'
      '  ryda.switches_pg.set_mask(:FMID, :MASK);'
      'end;')
    Left = 22
    Top = 84
    ParamData = <
      item
        DataType = ftFloat
        Name = 'FMID'
        ParamType = ptInput
      end
      item
        DataType = ftCursor
        Name = 'MASK'
        ParamType = ptOutput
        Value = 'Object'
      end>
  end
  object oqPointLimits: TOraQuery
    Session = dmMain.orases
    SQL.Strings = (
      'begin'
      '  ryda.SWITCHES_PG.READ_POINTLIMITS_P(:AN_MID, :ACUR_T);'
      'end;')
    Left = 240
    Top = 56
    ParamData = <
      item
        DataType = ftInteger
        Name = 'AN_MID'
        ParamType = ptInput
      end
      item
        DataType = ftCursor
        Name = 'ACUR_T'
        ParamType = ptOutput
        Value = 'Object'
      end>
  end
  object opCheckSwitch: TOraStoredProc
    StoredProcName = 'RYDA.SWITCHES_PG.check_switch'
    Session = dmMain.orases
    SQL.Strings = (
      'begin'
      '  :RESULT := RYDA.SWITCHES_PG.check_switch(:ANSWID);'
      'end;')
    Left = 338
    Top = 104
    ParamData = <
      item
        DataType = ftFloat
        Name = 'RESULT'
        ParamType = ptOutput
      end
      item
        DataType = ftFloat
        Name = 'ANSWID'
        ParamType = ptInput
      end>
  end
end
