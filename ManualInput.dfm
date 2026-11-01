inherited fmManualInput: TfmManualInput
  Left = 319
  Top = 209
  HelpContext = 512
  VertScrollBar.Range = 0
  BorderStyle = bsNone
  Caption = #1058#1072#1073#1083#1080#1094#1072' '#1088#1091#1095#1085#1086#1075#1086' '#1074#1074#1086#1076#1072' '#1087#1086#1082#1072#1079#1072#1085#1080#1081
  ClientHeight = 335
  ClientWidth = 832
  Font.Height = -10
  PopupMenu = PopupMenu1
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited iplBottom: TPanel
    Top = 310
    Width = 832
    TabOrder = 1
    inherited btnRefresh: TBitBtn
      Left = 58
      Action = nil
      Enabled = False
      Visible = False
      OnClick = nil
    end
    inherited iplClose: TPanel
      Left = 608
      Width = 224
      AutoSize = False
      TabOrder = 2
      inherited btnClose: TBitBtn
        Tag = 5
        Left = 122
        Width = 100
        Caption = '&'#1047#1072#1082#1088#1099#1090#1100
        TabOrder = 2
      end
      object btCheck: TBitBtn
        Tag = 4
        Left = -50
        Top = -1
        Width = 81
        Height = 25
        Action = iaCheck
        Caption = #1055#1088#1086#1074#1077#1088#1080#1090#1100
        Enabled = False
        TabOrder = 1
        Visible = False
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00CCCCCC00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00CCCCCC00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008686
          8600868686008686860086868600868686008686860086868600868686008686
          8600868686008686860086868600FF00FF00FF00FF00FF00FF00FF00FF008686
          8600040404000404040004040400040404000C0C0C0004040400040404000404
          04000404040004040400040404000C0C0C00FF00FF00FF00FF00FF00FF008686
          86000C0C0C00FFFFFF00FFFFFF00FFFFFF00000033000000330099669900FFEC
          CC00FFFFFF00FFFFFF00FFFFFF0004040400CCCCCC00FF00FF00FF00FF008686
          860004040400FFFFFF00FFFFFF0000003300CC99FF002100A5003399FF009966
          9900FFECCC00FFFFFF00FFFFFF0004040400FF00FF00FF00FF00FF00FF008686
          860004040400FFFFFF00000033003399FF002100A5000000FF00800080003399
          FF0099669900FFFFFF00FFFFFF0004040400FF00FF00FF00FF00FF00FF008686
          86000C0C0C00000033003399FF0080008000FF00FF000000FF000000FF002100
          A5003399FF0077777700FFFFFF0004040400FF00FF00FF00FF00FF00FF008686
          860004040400868686002100A5000000FF000000FF00161616000000FF00FF00
          FF0000009900000033008686860004040400FF00FF00FF00FF00FF00FF008686
          860016161600FFFFFF00868686000404040086868600FFFFFF00040404000000
          FF00FF00FF00000099000000330004040400FF00FF00FF00FF00FF00FF008686
          860004040400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000404
          04000000FF00FF00FF00000099000C0C0C00FF00FF00FF00FF00FF00FF008686
          86000C0C0C00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00040404000000FF00FF00FF000000990004040400FF00FF00FF00FF008686
          860004040400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00040404000000FF00FF00FF000000990004040400FF00FF00FF00
          FF00040404000404040004040400040404000404040004040400040404000404
          04000404040004040400040404000000FF002100A50016161600FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF000404040004040400FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      end
      object btInput: TBitBtn
        Tag = 3
        Left = 30
        Top = 0
        Width = 92
        Height = 25
        Hint = #1042#1099#1079#1074#1072#1090#1100' '#1086#1082#1085#1086' '#1085#1072#1089#1090#1088#1086#1081#1082#1080' '#1082#1088#1080#1090#1077#1088#1080#1103' '#1087#1086#1080#1089#1082#1072
        Caption = #1042#1074#1086#1076' '#1087#1086#1087#1088#1072#1074#1086#1082
        TabOrder = 0
        OnClick = btInputClick
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
      Width = 305
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
        Hint = #1055#1077#1095#1072#1090#1100'...'
        Caption = #1055#1077#1095#1072#1090#1100
        ImageIndex = 30
        ParentShowHint = False
        ShowHint = True
        OnClick = tbPrintClick
      end
      object ToolButton1: TToolButton
        Left = 116
        Top = 0
        Width = 8
        Caption = 'ToolButton1'
        ImageIndex = 31
        Style = tbsSeparator
      end
      object tbCopyData: TToolButton
        Left = 124
        Top = 0
        Hint = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1076#1072#1085#1085#1099#1077' '#1089' '#1090#1086#1095#1082#1080'...'
        Caption = 'tbCopyData'
        ImageIndex = 8
        OnClick = tbCopyDataClick
      end
      object tbCopyDataYest: TToolButton
        Left = 149
        Top = 0
        Hint = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1076#1072#1085#1085#1099#1077' '#1089' '#1090#1086#1095#1082#1080' '#1087#1088#1077#1076#1099#1076#1091#1097#1080#1077' '#1089#1091#1090#1082#1080
        Caption = 'tbCopyDataYest'
        ImageIndex = 9
        OnClick = tbCopyDataYestClick
      end
      object ToolButton2: TToolButton
        Left = 174
        Top = 0
        Width = 8
        Caption = 'ToolButton2'
        ImageIndex = 10
        Style = tbsSeparator
      end
      object tbDown: TToolButton
        Left = 182
        Top = 0
        Hint = #1055#1088#1077#1076#1099#1076#1091#1097#1080#1077' '#1089#1091#1090#1082#1080
        Caption = 'tbDown'
        ImageIndex = 57
        OnClick = tbDownClick
      end
      object tbUp: TToolButton
        Left = 207
        Top = 0
        Hint = #1057#1083#1077#1076#1091#1102#1097#1080#1077' '#1089#1091#1090#1082#1080
        Caption = 'tbUp'
        ImageIndex = 58
        OnClick = tbDownClick
      end
      object ToolButton7: TToolButton
        Left = 232
        Top = 0
        Width = 8
        Caption = 'ToolButton7'
        ImageIndex = 12
        Style = tbsSeparator
      end
      object ToolButton4: TToolButton
        Left = 240
        Top = 0
        Hint = 
          #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1076#1072#1085#1085#1099#1077' '#1087#1086' '#1074#1089#1077#1084' '#1090#1086#1095#1082#1072#1084' '#1086#1076#1085#1086#1074#1088#1077#1084#1077#1085#1085#1086' '#1079#1072' '#1087#1088#1077#1076#1099#1076#1091#1097#1080#1077' '#1089#1091#1090#1082 +
          #1080
        Caption = 'ToolButton4'
        ImageIndex = 11
        OnClick = ToolButton4Click
      end
      object ToolButton6: TToolButton
        Left = 265
        Top = 0
        Hint = 
          #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1076#1072#1085#1085#1099#1077' '#1087#1086' '#1074#1089#1077#1084' '#1090#1086#1095#1082#1072#1084' '#1086#1076#1085#1086#1074#1088#1077#1084#1077#1085#1085#1086' '#1079#1072' '#1087#1088#1086#1080#1079#1074#1086#1083#1100#1085#1091#1102' '#1076#1072 +
          #1090#1091
        Caption = 'ToolButton6'
        ImageIndex = 34
        OnClick = ToolButton6Click
      end
    end
  end
  object dbManInput: TDBGridEh [1]
    Left = 0
    Top = 41
    Width = 832
    Height = 269
    Align = alClient
    AllowedOperations = [alopUpdateEh]
    DataSource = dsReadRow
    FooterColor = 8454143
    FooterFont.Charset = DEFAULT_CHARSET
    FooterFont.Color = clWindowText
    FooterFont.Height = -10
    FooterFont.Name = 'MS Sans Serif'
    FooterFont.Style = []
    OptionsEh = [dghFixed3D, dghFooter3D, dghHighlightFocus, dghClearSelection]
    SumList.Active = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -10
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    UseMultiTitle = True
    OnColEnter = dbManInputColEnter
    OnColExit = dbManInputColExit
    OnDrawColumnCell = dbManInputDrawColumnCell
    OnKeyDown = dbManInputKeyDown
    OnMouseUp = dbManInputMouseUp
  end
  object Panel2: TPanel [2]
    Left = 0
    Top = 0
    Width = 832
    Height = 41
    Align = alTop
    TabOrder = 2
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 288
      Height = 39
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      object cbConst: TCheckBox
        Tag = 2
        Left = 12
        Top = 22
        Width = 231
        Height = 17
        Caption = #1057#1091#1090#1086#1095#1085#1086#1077' '#1079#1085#1072#1095#1077#1085#1080#1077' '#1103#1074#1083#1103#1077#1090#1089#1103' '#1082#1086#1085#1089#1090#1072#1085#1090#1086#1081
        TabOrder = 0
      end
      object cbInv: TCheckBox
        Tag = 2
        Left = 12
        Top = 4
        Width = 91
        Height = 13
        Caption = #1048#1085#1074#1077#1088#1089#1080#1103
        TabOrder = 1
        OnClick = cbInvClick
      end
    end
    object Panel3: TPanel
      Left = 463
      Top = 1
      Width = 368
      Height = 39
      Align = alRight
      BevelOuter = bvNone
      Enabled = False
      TabOrder = 1
      Visible = False
      object Label1: TLabel
        Left = 52
        Top = 14
        Width = 43
        Height = 13
        Caption = #1042#1074#1086#1076' '#1087#1086':'
      end
      object ComboBox1: TComboBox
        Left = 101
        Top = 10
        Width = 235
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 0
        Text = #1059#1082#1088#1072#1080#1085#1089#1082#1086#1077' '#1074#1088#1077#1084#1103
        OnChange = ComboBox1Change
        Items.Strings = (
          #1059#1082#1088#1072#1080#1085#1089#1082#1086#1077' '#1074#1088#1077#1084#1103
          #1057#1088#1077#1076#1085#1077#1077#1074#1088#1086#1087#1077#1081#1089#1082#1086#1077' '#1074#1088#1077#1084#1103)
      end
    end
    object Panel4: TPanel
      Left = 289
      Top = 1
      Width = 182
      Height = 39
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 2
      object RadioGroup1: TRadioGroup
        Left = 0
        Top = 0
        Width = 182
        Height = 39
        Align = alClient
        Caption = #1060#1086#1088#1084#1072#1090' '#1087#1088#1077#1076#1089#1090#1072#1074#1083#1077#1085#1080#1103' '#1076#1072#1085#1085#1099#1093
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          #1082#1042#1090#1095
          #1090#1099#1089'.'#1082#1042#1090#1095)
        TabOrder = 0
        OnClick = RadioGroup1Click
      end
    end
  end
  inherited alDefault: TActionList
    inherited iaSave: TAction
      Enabled = True
      OnExecute = btSaveClick
    end
    inherited iaRefresh: TAction
      OnExecute = tbRefreshClick
    end
    inherited iaCheck: TAction
      Enabled = True
      Visible = True
      OnExecute = btCheckClick
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
  object oqReadRow: TOraQuery
    Session = dmMain.orases
    SQL.Strings = (
      'begin ryda.MANUAL_IN_PG.Read_Row_p(:par1,:par2,:par3,:par4,'
      
        '                            :par5 ,:par6 ,:par7 ,:par8,:par9);en' +
        'd;')
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
        'r10,:par11,:par12,:par13,:par14);end;')
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
        DataType = ftInteger
        Name = 'par11'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'par12'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'par13'
        ParamType = ptOutput
        Table = True
      end
      item
        DataType = ftInteger
        Name = 'par14'
        ParamType = ptInput
      end>
  end
  object vtData: TVirtualTable
    AfterPost = vtDataAfterPost
    Left = 478
    Top = 176
    Data = {02000000000000000000}
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
      '/*begin ryda.MANUAL_IN_PG.Read_MaxValue_p(:par1,:par2);end;*/'
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
  object oqMaxValue1: TOraQuery
    Session = dmMain.orases
    SQL.Strings = (
      'begin ryda.MANUAL_IN_PG.Read_MaxValue_p(:par1,:par2);end;'
      '')
    AutoCommit = False
    Left = 236
    Top = 176
    ParamData = <
      item
        DataType = ftFloat
        Name = 'par1'
        ParamType = ptInput
      end
      item
        DataType = ftCursor
        Name = 'par2'
        Value = 'Object'
      end>
  end
  object setTimeShift: TOraQuery
    Session = dmMain.orases
    AutoCommit = False
    Left = 84
    Top = 114
  end
  object PrintMessageGrid: TPrintDBGridEh
    DBGridEh = dbManInput
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
    Left = 38
    Top = 206
  end
end
