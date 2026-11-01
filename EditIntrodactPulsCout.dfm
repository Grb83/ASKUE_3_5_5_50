inherited FormIntrodactPulsCount: TFormIntrodactPulsCount
  Left = 161
  Top = 217
  HelpContext = 525
  VertScrollBar.Range = 0
  BorderStyle = bsNone
  Caption = 'FormIntrodactPulsCount'
  ClientHeight = 448
  ClientWidth = 1000
  OldCreateOrder = False
  PopupMenu = PopupMenu1
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited iplBottom: TPanel
    Top = 423
    Width = 1000
    inherited iplClose: TPanel
      Left = 919
    end
    object btParam: TBitBtn
      Left = 201
      Top = 1
      Width = 104
      Height = 25
      Action = iaParams
      Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00969696000C0C0C0000FFFF000099CC000099CC000066
        99000C0C0C0096969600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0096969600393939000099CC0000FFFF000099CC000099
        CC000C0C0C0096969600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00969696000C0C0C00CCFFFF000099CC000C0C
        0C0096969600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00969696000C0C0C00CCFFFF000099CC000C0C
        0C0096969600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00969696000C0C0C00CCFFFF000099CC000C0C
        0C0096969600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00969696000C0C0C00CCFFFF00006699000C0C
        0C0096969600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00969696000C0C0C0000669900006699000C0C
        0C0096969600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0096969600FF00
        FF00FF00FF00FF00FF00FF00FF00393939001C1C1C0022222200222222002222
        22002222220096969600222222002222220022222200FF00FF000C0C0C009696
        9600FF00FF00FF00FF009696960039393900B2B2B200D7D7D700D7D7D700D7D7
        D700CCCCCC00222222000C0C0C00A4A0A0004D4D4D0096969600222222002222
        22009696960096969600393939000C0C0C00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00D7D7D7004D4D4D009696960022222200D7D7
        D700B2B2B20039393900222222004D4D4D00FF00FF00FF00FF00D7D7D700D7D7
        D700D7D7D700D7D7D700D7D7D700D7D7D7004D4D4D0096969600FF00FF004D4D
        4D00F1F1F100FF00FF00F1F1F100FF00FF00FFFFFF00B2B2B200B2B2B200B2B2
        B200B2B2B200B2B2B200B2B2B200B2B2B2004D4D4D0096969600FF00FF00FF00
        FF004D4D4D004D4D4D0022222200CCCCCC00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00333333000C0C0C00B2B2B2004D4D4D0096969600FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00222222002222220022222200222222002222
        220022222200FF00FF00FF00FF002222220022222200FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
    end
  end
  object DBGridEh1: TDBGridEh [1]
    Left = 0
    Top = 0
    Width = 1000
    Height = 423
    Align = alClient
    AllowedOperations = [alopUpdateEh]
    DataSource = DS1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    FooterColor = clWindow
    FooterFont.Charset = DEFAULT_CHARSET
    FooterFont.Color = clWindowText
    FooterFont.Height = -11
    FooterFont.Name = 'MS Sans Serif'
    FooterFont.Style = []
    Options = [dgEditing, dgTitles, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ParentFont = False
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = [fsBold]
    TitleLines = 2
    UseMultiTitle = True
    OnKeyPress = DBGridEh1KeyPress
    Columns = <
      item
        Color = clBtnFace
        EditButtons = <>
        FieldName = 'VName'
        Footers = <>
        ReadOnly = True
        Title.Caption = #1058#1086#1095#1082#1072' '#1091#1095#1077#1090#1072
        Width = 208
      end
      item
        EditButtons = <>
        FieldName = 'date_count'
        Footers = <>
        Title.Caption = #1044#1072#1090#1072
        Width = 79
      end
      item
        EditButtons = <>
        FieldName = 'MTRSN'
        Footers = <>
        Title.Caption = #1047'-'#1076' '#8470
        Width = 95
      end
      item
        EditButtons = <>
        FieldName = 'DIGITS'
        Footers = <>
        Title.Caption = #1056#1072#1079#1088#1103#1076#1085#1086#1089#1090#1100
        Width = 101
      end
      item
        DblClickNextVal = True
        EditButtons = <
          item
            OnClick = DBGridEh1Columns4EditButtons0Click
          end>
        FieldName = 'MTYPE'
        Footers = <>
        Title.Caption = #1058#1080#1087
        Width = 228
      end
      item
        EditButtons = <>
        FieldName = 'MCURRENT'
        Footers = <>
        Title.Caption = '('#1040')'
        Width = 40
      end
      item
        EditButtons = <>
        FieldName = 'MPOWER'
        Footers = <>
        Title.Caption = '(V)'
        Width = 40
      end
      item
        EditButtons = <>
        FieldName = 'MYEAR'
        Footers = <>
        Title.Caption = #1055#1083#1086#1084#1073#1072'|'#1043#1086#1076
        Width = 31
      end
      item
        EditButtons = <>
        FieldName = 'MQUARTER'
        Footers = <>
        Title.Caption = #1055#1083#1086#1084#1073#1072'|'#1050#1074'.'
        Width = 26
      end
      item
        EditButtons = <>
        FieldName = 'MCONST'
        Footers = <>
        Title.Caption = #1048#1084#1087'./'#1082#1042#1090#1095
        Width = 71
      end
      item
        EditButtons = <>
        FieldName = 'MCLASS'
        Footers = <>
        Title.Caption = #1050#1083'.'
        Width = 62
      end>
  end
  inherited MenuSAA: TMainMenu
    Left = 62
    Top = 74
  end
  inherited PopupMenu1: TPopupMenu
    Left = 28
    Top = 74
  end
  inherited alDefault: TActionList
    Top = 68
  end
  inherited iImageList: TImageList
    Left = 138
    Top = 66
  end
  inherited ilMenu: TImageList
    Left = 24
    Top = 122
  end
  object oqTree: TSmartQuery
    Session = dmMain.orases
    SQL.Strings = (
      'begin'
      '  ryda.METERS_PG.create_tree(:TOP, :TREE);'
      'end;')
    Left = 356
    Top = 96
    ParamData = <
      item
        DataType = ftFloat
        Name = 'TOP'
        ParamType = ptInput
      end
      item
        DataType = ftCursor
        Name = 'TREE'
        ParamType = ptOutput
        Value = 'Object'
      end>
  end
  object oqSave: TSmartQuery
    Session = dmMain.orases
    SQL.Strings = (
      'begin'
      
        '  ryda.meters_pg.upd_p(:AN_MID, :AD_DATE_TIME, :AV_MTRSN, :AN_DI' +
        'GITS, :AV_MTYPE, :AN_MCURRENT, :AN_MPOWER, :AN_MYEAR, :AV_MQUART' +
        'ER, :AN_MCONST, :AN_MCLASS, :AN_ENTYPE);'
      'end;')
    Left = 452
    Top = 110
    ParamData = <
      item
        DataType = ftFloat
        Name = 'AN_MID'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'AD_DATE_TIME'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AV_MTRSN'
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
        Name = 'AN_MYEAR'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'AV_MQUARTER'
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
        Name = 'AN_ENTYPE'
        ParamType = ptInput
      end>
  end
  object DS1: TDataSource
    DataSet = VT1
    Left = 286
    Top = 320
  end
  object VT1: TVirtualTable
    AfterEdit = VT1AfterEdit
    FieldDefs = <
      item
        Name = 'VName'
        DataType = ftString
        Size = 127
      end
      item
        Name = 'date_count'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'MTRSN'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'DIGITS'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'MTYPE'
        DataType = ftString
        Size = 75
      end
      item
        Name = 'MCURRENT'
        DataType = ftInteger
      end
      item
        Name = 'MPOWER'
        DataType = ftInteger
      end
      item
        Name = 'MYEAR'
        DataType = ftInteger
      end
      item
        Name = 'MQUARTER'
        DataType = ftInteger
      end
      item
        Name = 'MCONST'
        DataType = ftInteger
      end
      item
        Name = 'MCLASS'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'ID'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'MID'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Position'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Entype'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Smart'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Edited'
        DataType = ftBoolean
      end>
    Left = 340
    Top = 322
    Data = {
      020011000500564E616D6501007F000A00646174655F636F756E740100140005
      004D5452534E01001E00060044494749545301001E0005004D5459504501004B
      0008004D43555252454E540300000006004D504F5745520300000005004D5945
      41520300000008004D515541525445520300000006004D434F4E535403000000
      06004D434C41535301001400020049440100140003004D494401001400080050
      6F736974696F6E010014000600456E74797065010014000500536D6172740100
      1400060045646974656405000000000000000000}
    object VT1VName: TStringField
      FieldName = 'VName'
      Size = 127
    end
    object VT1date_count: TStringField
      FieldName = 'date_count'
    end
    object VT1MTRSN: TStringField
      FieldName = 'MTRSN'
      Size = 30
    end
    object VT1DIGITS: TStringField
      FieldName = 'DIGITS'
      Size = 30
    end
    object VT1MTYPE: TStringField
      DisplayWidth = 50
      FieldName = 'MTYPE'
    end
    object VT1MCURRENT: TIntegerField
      FieldName = 'MCURRENT'
    end
    object VT1MPOWER: TIntegerField
      FieldName = 'MPOWER'
    end
    object VT1MYEAR: TIntegerField
      FieldName = 'MYEAR'
    end
    object VT1MQUARTER: TIntegerField
      FieldName = 'MQUARTER'
    end
    object VT1MCONST: TIntegerField
      FieldName = 'MCONST'
    end
    object VT1MCLASS: TStringField
      FieldName = 'MCLASS'
    end
    object VT1ID: TStringField
      FieldName = 'ID'
    end
    object VT1MID: TStringField
      FieldName = 'MID'
    end
    object VT1Position: TStringField
      FieldName = 'Position'
    end
    object VT1Entype: TStringField
      FieldName = 'Entype'
    end
    object VT1Smart: TStringField
      FieldName = 'Smart'
    end
    object VT1Edited: TBooleanField
      FieldName = 'Edited'
    end
  end
end
