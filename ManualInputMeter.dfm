inherited fmManualInputMeter: TfmManualInputMeter
  Left = 190
  Top = 341
  HelpContext = 512
  VertScrollBar.Range = 0
  BorderStyle = bsNone
  Caption = #1058#1072#1073#1083#1080#1094#1072' '#1088#1091#1095#1085#1086#1075#1086' '#1074#1074#1086#1076#1072' '#1087#1086#1082#1072#1079#1072#1085#1080#1081
  ClientHeight = 335
  ClientWidth = 1167
  OldCreateOrder = False
  Font.Height = -10
  PopupMenu = PopupMenu1
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited iplBottom: TPanel
    Top = 310
    Width = 1167
    TabOrder = 1
    inherited btnRefresh: TBitBtn
      Left = 64
      Action = nil
      Enabled = False
      Visible = False
      OnClick = nil
    end
    inherited iplClose: TPanel
      Left = 904
      Width = 263
      AutoSize = False
      TabOrder = 2
      inherited btnClose: TBitBtn
        Tag = 5
        Left = 162
        Width = 100
        Caption = '&'#1047#1072#1082#1088#1099#1090#1100
      end
    end
    inherited btnSave: TBitBtn
      Left = 40
      Top = -1
      Action = nil
      TabOrder = 3
      Visible = False
    end
    object ToolBar1: TToolBar
      Tag = 1
      Left = 0
      Top = 0
      Width = 153
      Height = 25
      Align = alLeft
      ButtonHeight = 25
      ButtonWidth = 25
      Caption = 'ToolBar1'
      EdgeBorders = []
      EdgeInner = esNone
      EdgeOuter = esNone
      Flat = True
      Images = ilMenu
      TabOrder = 1
      object btSave: TToolButton
        Left = 0
        Top = 0
        Action = iaSave
        Enabled = False
        ParentShowHint = False
        ShowHint = True
      end
      object tbRefresh: TToolButton
        Left = 25
        Top = 0
        Action = iaRefresh
        ParentShowHint = False
        ShowHint = True
      end
      object ToolButton5: TToolButton
        Left = 50
        Top = 0
        Width = 8
        Caption = 'ToolButton5'
        ImageIndex = 35
        Style = tbsSeparator
      end
      object btParams: TToolButton
        Left = 58
        Top = 0
        Action = iaParams
        ParentShowHint = False
        ShowHint = True
      end
      object ToolButton3: TToolButton
        Left = 83
        Top = 0
        Width = 8
        Caption = 'ToolButton3'
        Enabled = False
        ImageIndex = 76
        Style = tbsSeparator
      end
      object tbPrint: TToolButton
        Left = 91
        Top = 0
        Hint = #1055#1077#1095#1072#1090#1100
        Caption = #1055#1077#1095#1072#1090#1100
        ImageIndex = 30
        ParentShowHint = False
        ShowHint = True
        OnClick = tbPrintClick
      end
    end
  end
  object dbManInput: TDBGridEh [1]
    Left = 0
    Top = 41
    Width = 1167
    Height = 269
    Align = alClient
    AllowedOperations = [alopUpdateEh]
    AutoFitColWidths = True
    DataSource = dsReadRow
    FooterColor = 8454143
    FooterFont.Charset = DEFAULT_CHARSET
    FooterFont.Color = clWindowText
    FooterFont.Height = -10
    FooterFont.Name = 'MS Sans Serif'
    FooterFont.Style = []
    FrozenCols = 6
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
    OptionsEh = [dghFixed3D, dghFooter3D, dghHighlightFocus, dghClearSelection, dghIncSearch]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -10
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    UseMultiTitle = True
    OnColEnter = dbManInputColEnter
    Columns = <
      item
        Color = clBtnFace
        EditButtons = <>
        FieldName = 'name'
        Footers = <>
        ReadOnly = True
        Title.Caption = #1058#1086#1095#1082#1080' '#1091#1095#1077#1090#1072
        Width = 303
      end
      item
        Color = clSkyBlue
        EditButtons = <>
        FieldName = 'type'
        Footers = <>
        ReadOnly = True
        Title.Caption = #1058#1080#1087' '#1080#1079#1084'.'
        Width = 80
      end
      item
        Color = clBtnFace
        EditButtons = <>
        FieldName = 'mtrsn'
        Footers = <>
        ReadOnly = True
        Title.Caption = #1047#1072#1074#1086#1076#1089#1082#1086#1081' '#1085#1086#1084#1077#1088' '#1089#1095#1077#1090#1095#1080#1082#1072
        Width = 131
      end
      item
        Alignment = taRightJustify
        Color = clSkyBlue
        EditButtons = <>
        FieldName = 'kc'
        Footers = <>
        ReadOnly = True
        Title.Caption = #1056#1072#1089#1095#1077#1090#1085#1099#1081' '#1082#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090
        Width = 72
      end
      item
        Color = clBtnFace
        EditButtons = <>
        FieldName = 'lastd'
        Footers = <>
        ReadOnly = True
        Title.Caption = #1044#1072#1090#1072' '#1087#1088#1077#1076#1099#1076#1091#1097#1080#1093' '#1087#1086#1082#1072#1079#1072#1085#1080#1081
        Width = 115
      end
      item
        Color = clSkyBlue
        EditButtons = <>
        FieldName = 'lastind'
        Footers = <>
        ReadOnly = True
        Title.Caption = #1055#1088#1077#1076#1099#1076#1091#1097#1080#1077' '#1087#1086#1082#1072#1079#1072#1085#1080#1103
        Width = 98
      end
      item
        EditButtons = <>
        FieldName = 'em'
        Footers = <>
        Title.Caption = #1058#1077#1082#1091#1097#1080#1077' '#1087#1086#1082#1072#1079#1072#1085#1080#1103
        Width = 101
      end
      item
        Color = clSkyBlue
        EditButtons = <>
        FieldName = 'e'
        Footers = <>
        ReadOnly = True
        Title.Caption = #1055#1088#1080#1088#1072#1097#1077#1085#1080#1077' '#1087#1086#1082#1072#1079#1072#1085#1080#1081
        Width = 110
      end
      item
        Alignment = taRightJustify
        Color = clBtnFace
        EditButtons = <>
        FieldName = 'nextd'
        Footers = <>
        ReadOnly = True
        Title.Caption = #1044#1072#1090#1072' '#1089#1083#1077#1076#1091#1102#1097#1080#1093' '#1087#1086#1082#1072#1079#1072#1085#1080#1081
        Width = 110
      end
      item
        Color = clSkyBlue
        EditButtons = <>
        FieldName = 'nextind'
        Footers = <>
        ReadOnly = True
        Title.Caption = #1057#1083#1077#1076#1091#1102#1097#1080#1077' '#1087#1086#1082#1072#1079#1072#1085#1080#1103
        Width = 110
      end>
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 0
    Width = 1167
    Height = 41
    Align = alTop
    TabOrder = 2
    object Panel3: TPanel
      Left = 766
      Top = 1
      Width = 400
      Height = 39
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object Label1: TLabel
        Left = 54
        Top = 14
        Width = 100
        Height = 13
        Caption = #1042#1074#1086#1076' '#1087#1086#1082#1072#1079#1072#1085#1080#1081' '#1087#1086':'
      end
      object ComboBox1: TComboBox
        Left = 165
        Top = 10
        Width = 235
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 0
        Text = #1059#1082#1088#1072#1080#1085#1089#1082#1086#1077' '#1074#1088#1077#1084#1103
        Items.Strings = (
          #1059#1082#1088#1072#1080#1085#1089#1082#1086#1077' '#1074#1088#1077#1084#1103
          #1057#1088#1077#1076#1085#1077#1077#1074#1088#1086#1087#1077#1081#1089#1082#1086#1077' '#1074#1088#1077#1084#1103)
      end
    end
  end
  inherited MenuSAA: TMainMenu
    Left = 50
    Top = 70
  end
  inherited PopupMenu1: TPopupMenu
    Left = 84
    Top = 60
  end
  inherited alDefault: TActionList
    Left = 142
    Top = 66
    inherited iaSave: TAction
      Enabled = True
    end
    inherited iaCheck: TAction
      Enabled = True
      Visible = True
    end
    inherited iaParams: TAction
      Enabled = True
      Visible = True
    end
    inherited iaFind: TAction
      Enabled = True
      Visible = True
    end
    inherited iaFindAgain: TAction
      Enabled = True
      Visible = True
    end
  end
  inherited iImageList: TImageList
    Left = 180
    Top = 64
  end
  inherited ilMenu: TImageList
    Top = 68
  end
  object oqReadRow: TOraQuery
    Session = dmMain.orases
    SQL.Strings = (
      'begin ryda.MANUAL_METER_IN.Read_Row_p(:par1,:par2,:par3,:par4,'
      
        '                            :par5 ,:par6 ,:par7 ,:par8,:par10,:p' +
        'ar11,:par9);end;')
    AutoCommit = False
    Left = 390
    Top = 38
    ParamData = <
      item
        DataType = ftFloat
        Name = 'par1'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'par2'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'par3'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'par4'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'par5'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'par6'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'par7'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'par8'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'par10'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'par11'
        ParamType = ptInput
      end
      item
        DataType = ftCursor
        Name = 'par9'
        ParamType = ptOutput
        Value = 'Object'
      end>
  end
  object dsReadRow: TDataSource
    DataSet = vtData
    Left = 470
    Top = 34
  end
  object oqReadData: TOraQuery
    Session = dmMain.orases
    SQL.Strings = (
      'begin ryda.MANUAL_IN_PG.Read_Data_p(:par1,:par2,:par3,:par4,'
      
        '                            :par5 ,:par6 ,:par7 ,:par8,:par9,:pa' +
        'r10,:par11);end;')
    AutoCommit = False
    Left = 472
    Top = 104
    ParamData = <
      item
        DataType = ftFloat
        Name = 'par1'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'par2'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'par3'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'par4'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'par5'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'par6'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'par7'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'par8'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'par9'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'par10'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'par11'
        ParamType = ptOutput
        Table = True
      end>
  end
  object vtData: TVirtualTable
    FieldDefs = <
      item
        Name = 'mid'
        DataType = ftFloat
      end
      item
        Name = 'name'
        DataType = ftString
        Size = 400
      end
      item
        Name = 'type'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'mtrsn'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'kc'
        DataType = ftInteger
      end
      item
        Name = 'lastd'
        DataType = ftDateTime
      end
      item
        Name = 'lastind'
        DataType = ftFloat
      end
      item
        Name = 'em'
        DataType = ftFloat
      end
      item
        Name = 'e'
        DataType = ftFloat
      end
      item
        Name = 'digits'
        DataType = ftFloat
      end
      item
        Name = 'nmeasure'
        DataType = ftInteger
      end
      item
        Name = 'predmin'
        DataType = ftFloat
      end
      item
        Name = 'predmax'
        DataType = ftFloat
      end
      item
        Name = 'avarmin'
        DataType = ftFloat
      end
      item
        Name = 'avarmax'
        DataType = ftFloat
      end
      item
        Name = 'fizmin'
        DataType = ftFloat
      end
      item
        Name = 'fizmax'
        DataType = ftFloat
      end
      item
        Name = 'nextd'
        DataType = ftDateTime
      end
      item
        Name = 'nextind'
        DataType = ftFloat
      end>
    Left = 476
    Top = 176
    Data = {
      0200130003006D69640600000004006E616D6501009001040074797065010014
      0005006D7472736E0100640002006B630300000005006C617374640B00000007
      006C617374696E64060000000200656D06000000010065060000000600646967
      6974730600000008006E6D656173757265030000000700707265646D696E0600
      00000700707265646D6178060000000700617661726D696E0600000007006176
      61726D617806000000060066697A6D696E06000000060066697A6D6178060000
      0005006E657874640B00000007006E657874696E6406000000000000000000}
    object vtDatamid: TFloatField
      FieldName = 'mid'
    end
    object vtDataname: TStringField
      FieldName = 'name'
      Size = 400
    end
    object vtDatatype: TStringField
      FieldName = 'type'
    end
    object vtDatamtrsn: TStringField
      FieldName = 'mtrsn'
      Size = 100
    end
    object vtDatakc: TIntegerField
      Alignment = taLeftJustify
      FieldName = 'kc'
    end
    object vtDatalastind: TFloatField
      FieldName = 'lastind'
    end
    object vtDataem: TFloatField
      FieldName = 'em'
      OnValidate = vtDataemValidate
    end
    object vtDatae: TFloatField
      FieldName = 'e'
    end
    object vtDatadigits: TFloatField
      FieldName = 'digits'
    end
    object vtDatanmeasure: TIntegerField
      FieldName = 'nmeasure'
    end
    object vtDatapredmin: TFloatField
      FieldName = 'predmin'
    end
    object vtDatapredmax: TFloatField
      FieldName = 'predmax'
    end
    object vtDataavarmin: TFloatField
      FieldName = 'avarmin'
    end
    object vtDataavarmax: TFloatField
      FieldName = 'avarmax'
    end
    object vtDatafizmin: TFloatField
      FieldName = 'fizmin'
    end
    object vtDatafizmax: TFloatField
      FieldName = 'fizmax'
    end
    object vtDatalastd: TDateTimeField
      FieldName = 'lastd'
    end
    object vtDatanextd: TDateTimeField
      FieldName = 'nextd'
    end
    object vtDatanextind: TFloatField
      FieldName = 'nextind'
    end
  end
  object oqSave: TOraQuery
    Session = dmMain.orases
    AutoCommit = False
    Left = 384
    Top = 112
  end
  object oqMaxValue: TOraQuery
    Session = dmMain.orases
    SQL.Strings = (
      
        'begin ryda.MANUAL_METER_IN.read_minmaxvalue_p(:par1,:par2,:par3)' +
        ';end;'
      '')
    AutoCommit = False
    Left = 380
    Top = 186
    ParamData = <
      item
        DataType = ftFloat
        Name = 'par1'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'par2'
        ParamType = ptInput
      end
      item
        DataType = ftCursor
        Name = 'par3'
        Value = 'Object'
      end>
  end
  object PrintGrid: TPrintDBGridEh
    DBGridEh = dbManInput
    Options = []
    Page.BottomMargin = 2
    Page.LeftMargin = 2
    Page.RightMargin = 2
    Page.TopMargin = 2
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
    Units = MM
    Left = 574
    Top = 176
  end
  object setTimeShift: TOraQuery
    Session = dmMain.orases
    AutoCommit = False
    Left = 168
    Top = 140
  end
end
