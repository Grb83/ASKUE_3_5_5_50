inherited StatICCPForm: TStatICCPForm
  Left = 132
  Top = 157
  Width = 1130
  Height = 690
  Caption = 'StatICCPForm'
  OnCreate = FormCreate
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  inherited iplBottom: TPanel
    Top = 607
    Width = 1114
    inherited btnRefresh: TBitBtn
      Left = 100
    end
    inherited iplClose: TPanel
      Left = 1033
    end
    inherited btnSave: TBitBtn
      Left = 196
      Visible = False
    end
    object PrintBtn: TBitBtn
      Left = 6
      Top = 1
      Width = 87
      Height = 25
      Hint = #1042#1099#1074#1077#1089#1090#1080' '#1085#1072' '#1087#1077#1095#1072#1090#1100
      Caption = #1055#1077#1095#1072#1090#1100
      TabOrder = 3
      OnClick = PrintBtnClick
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000FF00FF00000000005A5A
        5A00D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
        D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D60000000000000000005A5A
        5A00B5B5B500B5B5B500B5B5B500B5B5B500B5B5B500B5B5B500B5B5B500B5B5
        B500B5B5B500B5B5B500B5B5B500B5B5B500B5B5B50000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000005A5A
        5A00FFFFFF00D6D6D60000000000000000000000000000000000000000000000
        000000000000000000008484840084848400B5B5B50000000000000000005A5A
        5A00D6D6D6000000000000000000000000000000000000000000000000000000
        000000000000000000000000000084848400B5B5B50000000000000000000000
        0000000000000000000000000000636363006363630063636300636363006363
        6300636363000000000000000000000000000000000000000000FF00FF006363
        6300000000000000000000000000E7E7E700E7E7E700E7E7E700E7E7E700E7E7
        E700E7E7E70000000000000000000000000063636300FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0000000000FFCECE00FF633100FF9C6300FFFFFF00FF63
        3100FF9C630000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0000000000FFCECE00FF633100FF9C6300FFFFFF00FF63
        3100FF9C630000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0000000000FFCECE00FF633100FF9C6300FFFFFF00FF63
        3100FF9C630000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0000000000D6D6D600FF633100FF9C6300FFFFFF00FF63
        3100FF9C630000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF000000000000000000D6D6D600FFFFFF00FFFFFF00FFFF
        FF00FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
        000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
    end
  end
  object StatEhGrid: TDBGridEh [1]
    Left = 185
    Top = 41
    Width = 929
    Height = 566
    Align = alClient
    DataSource = dsStat
    FooterColor = clYellow
    FooterFont.Charset = DEFAULT_CHARSET
    FooterFont.Color = clWindowText
    FooterFont.Height = -11
    FooterFont.Name = 'MS Sans Serif'
    FooterFont.Style = []
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    UseMultiTitle = True
    Columns = <
      item
        EditButtons = <>
        FieldName = 'channel'
        Footers = <>
        Title.Caption = #1050#1072#1085#1072#1083
        Width = 200
      end
      item
        Alignment = taCenter
        EditButtons = <>
        FieldName = 'statcs'
        Footers = <>
        Title.Caption = #1057#1090#1072#1090#1080#1089#1090#1080#1082#1072
        Width = 80
      end
      item
        EditButtons = <>
        FieldName = 'cycles'
        Footers = <>
        Title.Caption = #1062#1080#1082#1083#1086#1074' '#1086#1087#1088#1086#1089#1072
        Width = 80
      end
      item
        Alignment = taRightJustify
        EditButtons = <>
        FieldName = 'duration_sec'
        Footers = <>
        Title.Caption = #1044#1083#1080#1090#1077#1083#1100#1085#1086#1089#1090#1100' '#1086#1087#1088#1086#1089#1072' ('#1089#1077#1082'.)'
        Width = 80
      end
      item
        Alignment = taRightJustify
        EditButtons = <>
        FieldName = 'polls'
        Footers = <>
        Title.Caption = #1055#1072#1082#1077#1090#1086#1074' '#1079#1072#1087#1088#1086#1089#1072' '#1076#1072#1085#1085#1099#1093
        Width = 80
      end
      item
        Alignment = taRightJustify
        EditButtons = <>
        FieldName = 'lost_pc'
        Footers = <>
        Title.Caption = #1055#1086#1090#1077#1088#1100' '#1087#1072#1082#1077#1090#1086#1074' '#1086#1090#1074#1077#1090#1072' (%)'
        Width = 80
      end
      item
        Alignment = taRightJustify
        EditButtons = <>
        FieldName = 'corrects_pc'
        Footers = <>
        Title.Caption = #1050#1086#1088#1088#1077#1082#1094#1080#1103' '#1087#1088#1080#1077#1084#1072' '#1087#1072#1082#1077#1090#1086#1074' (%)'
        Width = 80
      end
      item
        Alignment = taRightJustify
        EditButtons = <>
        FieldName = 'errors_pc'
        Footers = <>
        Title.Caption = #1054#1096#1080#1073#1086#1082' '#1087#1088#1080#1077#1084#1072' '#1087#1072#1082#1077#1090#1086#1074' (%)'
        Width = 80
      end
      item
        Alignment = taRightJustify
        EditButtons = <>
        FieldName = 'connections'
        Footers = <>
        Title.Caption = #1059#1089#1090#1072#1085#1086#1074#1086#1082' '#1089#1074#1103#1079#1080
        Width = 80
      end
      item
        Alignment = taRightJustify
        EditButtons = <>
        FieldName = 'disconnections'
        Footers = <>
        Title.Caption = #1056#1072#1079#1088#1099#1074#1086#1074' '#1089#1074#1103#1079#1080
        Width = 80
      end
      item
        Alignment = taRightJustify
        EditButtons = <>
        FieldName = 'min_del_msec'
        Footers = <>
        Title.Caption = #1052#1080#1085#1080#1084#1072#1083#1100#1085#1072#1103' '#1079#1072#1076#1077#1088#1078#1082#1072' '#1086#1090#1074#1077#1090#1072' ('#1084#1089#1077#1082'.)'
        Width = 80
      end
      item
        Alignment = taRightJustify
        EditButtons = <>
        FieldName = 'max_del_msec'
        Footers = <>
        Title.Caption = #1052#1072#1082#1089#1080#1084#1072#1083#1100#1085#1072#1103' '#1079#1072#1076#1077#1088#1078#1082#1072' '#1086#1090#1074#1077#1090#1072' ('#1084#1089#1077#1082'.)'
        Width = 80
      end
      item
        Alignment = taRightJustify
        EditButtons = <>
        FieldName = 'delay_msec'
        Footers = <>
        Title.Caption = #1057#1088#1077#1076#1085#1103#1103' '#1079#1072#1076#1077#1088#1078#1082#1072' '#1086#1090#1074#1077#1090#1072' ('#1084#1089#1077#1082'.)'
        Width = 80
      end>
  end
  object ToolsPanel: TPanel [2]
    Left = 0
    Top = 0
    Width = 1114
    Height = 41
    Align = alTop
    TabOrder = 2
    object Label1: TLabel
      Left = 8
      Top = 14
      Width = 61
      Height = 13
      Caption = #1047#1072' '#1087#1077#1088#1080#1086#1076' '#1089
    end
    object Label2: TLabel
      Left = 224
      Top = 16
      Width = 12
      Height = 13
      Caption = #1087#1086
    end
    object meTimeFrom: TMaskEdit
      Left = 168
      Top = 12
      Width = 50
      Height = 21
      EditMask = '!99:99:99;1; '
      MaxLength = 8
      TabOrder = 0
      Text = '00:00:00'
    end
    object FromDate: TDateTimePicker
      Left = 78
      Top = 12
      Width = 85
      Height = 21
      CalAlignment = dtaLeft
      Date = 39899.6126344907
      Time = 39899.6126344907
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 1
    end
    object TillDate: TDateTimePicker
      Left = 244
      Top = 12
      Width = 85
      Height = 21
      CalAlignment = dtaLeft
      Date = 39899.6165800463
      Time = 39899.6165800463
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 2
    end
    object meTimeTill: TMaskEdit
      Left = 334
      Top = 12
      Width = 50
      Height = 21
      EditMask = '!99:99:99;1; '
      MaxLength = 8
      TabOrder = 3
      Text = '00:00:00'
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 41
    Width = 185
    Height = 566
    Align = alLeft
    Caption = 'Panel1'
    TabOrder = 3
    object CLBChannels: TCheckListBox
      Left = 1
      Top = 49
      Width = 183
      Height = 516
      Align = alClient
      ItemHeight = 13
      TabOrder = 0
    end
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 183
      Height = 48
      Align = alTop
      BevelOuter = bvNone
      Caption = #1042#1099#1073#1086#1088' '#1082#1072#1085#1072#1083#1086#1074
      TabOrder = 1
    end
  end
  inherited MenuSAA: TMainMenu
    Left = 216
    Top = 110
  end
  inherited PopupMenu1: TPopupMenu
    Left = 278
    Top = 110
  end
  inherited alDefault: TActionList
    Left = 354
    Top = 110
    inherited iaSave: TAction
      Enabled = True
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1074' '#1092#1072#1081#1083
    end
    object iaPrint: TAction
      Category = 'PopupMenu'
      Caption = #1055#1077#1095#1072#1090#1100
      Hint = #1042#1099#1074#1077#1089#1090#1080' '#1085#1072' '#1087#1077#1095#1072#1090#1100
      ImageIndex = 30
    end
  end
  inherited iImageList: TImageList
    Left = 414
    Top = 110
  end
  inherited ilMenu: TImageList
    Left = 156
    Top = 110
  end
  object dsStat: TDataSource
    DataSet = oqChannals
    Left = 32
    Top = 102
  end
  object PrintMessageGrid: TPrintDBGridEh
    DBGridEh = StatEhGrid
    Options = [pghFitGridToPageWidth]
    Page.BottomMargin = 1
    Page.LeftMargin = 1
    Page.RightMargin = 1
    Page.TopMargin = 1
    PageFooter.Font.Charset = DEFAULT_CHARSET
    PageFooter.Font.Color = clWindowText
    PageFooter.Font.Height = -11
    PageFooter.Font.Name = 'MS Sans Serif'
    PageFooter.Font.Style = []
    PageHeader.Font.Charset = DEFAULT_CHARSET
    PageHeader.Font.Color = clWindowText
    PageHeader.Font.Height = -11
    PageHeader.Font.Name = 'MS Sans Serif'
    PageHeader.Font.Style = []
    PrintFontName = 'MS Sans Serif'
    Units = MM
    Left = 280
    Top = 182
  end
  object oqChannals: TOraQuery
    Session = dmMain.orases
    AutoCommit = False
    Left = 552
    Top = 332
  end
end
