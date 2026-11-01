inherited FormEditCOMportList: TFormEditCOMportList
  Left = 293
  Top = 234
  HelpContext = 531
  VertScrollBar.Range = 0
  BorderStyle = bsNone
  Caption = 'FormEditCOMportList'
  ClientHeight = 454
  ClientWidth = 641
  Constraints.MinWidth = 550
  Menu = nil
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited iplBottom: TPanel
    Top = 429
    Width = 641
    TabOrder = 2
    inherited iplClose: TPanel
      Left = 560
    end
    object btJournal: TBitBtn
      Left = 191
      Top = 0
      Width = 92
      Height = 25
      Hint = #1055#1086#1082#1072#1079#1072#1090#1100' '#1087#1088#1086#1090#1086#1082#1086#1083' '#1088#1072#1073#1086#1090#1099' '#1087#1086' '#1087#1086#1088#1090#1091'...'
      Caption = #1046#1091#1088#1085#1072#1083
      TabOrder = 3
      OnClick = btJournalClick
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF009C000000FF00
        FF00FF00FF0000000000000000000000000000000000FF00FF00000000000000
        000000000000FF00FF00000000000000000000000000FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF009C000000FF00
        FF00FF00FF0000000000000000000000000000000000FF00FF00000000000000
        000000000000FF00FF00000000000000000000000000FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF009C000000FF00
        FF00FF00FF0000000000000000000000000000000000FF00FF00000000000000
        000000000000FF00FF00000000000000000000000000FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF009C000000FF00
        FF00FF00FF0000000000000000000000000000000000FF00FF00000000000000
        000000000000FF00FF00000000000000000000000000FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF009C000000FF00
        FF00FF00FF0000000000000000000000000000000000FF00FF00000000000000
        000000000000FF00FF00000000000000000000000000FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF009C0000009C00
        00009C0000009C0000009C0000009C0000009C0000009C0000009C0000009C00
        00009C0000009C0000009C0000009C0000009C0000009C000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0000000000000000000000000000000000FF00FF00000000000000
        000000000000FF00FF00000000000000000000000000FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
    end
  end
  object Panel5: TPanel [1]
    Left = 251
    Top = 0
    Width = 390
    Height = 429
    Align = alRight
    BevelOuter = bvNone
    Constraints.MinHeight = 390
    Constraints.MinWidth = 350
    TabOrder = 1
    object Panel8: TPanel
      Left = 0
      Top = 0
      Width = 390
      Height = 23
      Align = alTop
      Caption = #1040#1090#1088#1080#1073#1091#1090#1099' '#1087#1086#1088#1090#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object Panel9: TPanel
      Left = 0
      Top = 23
      Width = 390
      Height = 100
      Align = alTop
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      DesignSize = (
        390
        100)
      object Label1: TLabel
        Left = 4
        Top = 15
        Width = 51
        Height = 13
        Caption = #1057#1082#1086#1088#1086#1089#1090#1100':'
      end
      object Label2: TLabel
        Left = 4
        Top = 45
        Width = 88
        Height = 13
        Caption = #1058#1080#1087' '#1089#1086#1077#1076#1080#1085#1077#1085#1080#1103' :'
      end
      object lTariffType: TLabel
        Left = 4
        Top = 75
        Width = 62
        Height = 13
        Caption = #1058#1080#1087' '#1090#1072#1088#1080#1092#1072':'
      end
      object ComboBox1: TComboBox
        Left = 96
        Top = 10
        Width = 286
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 13
        ParentFont = False
        TabOrder = 0
        OnChange = ComboBoxChange
        Items.Strings = (
          '110'
          '150'
          '200'
          '300'
          '600'
          '1200'
          '2400'
          '4800'
          '9600'
          '19200'
          '38400'
          '57600'
          '115200')
      end
      object cbTypeList: TComboBox
        Left = 96
        Top = 40
        Width = 287
        Height = 21
        Style = csDropDownList
        Anchors = [akLeft, akTop, akRight]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 13
        ParentFont = False
        TabOrder = 1
        OnChange = ComboBoxChange
      end
      object cbTariffType: TComboBox
        Left = 96
        Top = 70
        Width = 287
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 2
        OnChange = ComboBoxChange
      end
    end
    object Panel10: TPanel
      Left = 0
      Top = 123
      Width = 390
      Height = 170
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
      object Panel11: TPanel
        Left = 0
        Top = 0
        Width = 390
        Height = 21
        Align = alTop
        Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1091#1087#1088#1072#1074#1083#1103#1102#1097#1077#1075#1086' '#1088#1077#1075#1080#1089#1090#1088#1072
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
      object RadioGroup1: TRadioGroup
        Left = 0
        Top = 21
        Width = 390
        Height = 48
        Align = alTop
        Caption = #1056#1072#1079#1088#1103#1076#1085#1086#1089#1090#1100
        Columns = 5
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          '4 '#1073#1080#1090#1072
          '5 '#1073#1080#1090
          '6 '#1073#1080#1090
          '7 '#1073#1080#1090' '
          '8 '#1073#1080#1090)
        ParentFont = False
        TabOrder = 1
        OnClick = RadioGroupClick
      end
      object RadioGroup2: TRadioGroup
        Left = 0
        Top = 69
        Width = 390
        Height = 48
        Align = alTop
        Caption = #1050#1086#1083#1095#1080#1095#1077#1089#1090#1074#1086' '#1089#1090#1086#1087'. '#1073#1080#1090
        Columns = 3
        Items.Strings = (
          '0 - '#1073#1080#1090
          '1 - '#1073#1080#1090
          '2 - '#1073#1080#1090#1072)
        TabOrder = 2
        OnClick = RadioGroupClick
      end
      object RadioGroup3: TRadioGroup
        Left = 0
        Top = 117
        Width = 390
        Height = 53
        Align = alClient
        Caption = #1050#1086#1085#1090#1088#1086#1083#1100' '#1095#1077#1090#1085#1086#1089#1090#1080
        Columns = 3
        Items.Strings = (
          #1085#1077#1090
          #1095#1077#1090#1085#1086#1089#1090#1100' '
          #1085#1077#1095#1077#1090#1085#1086#1089#1090#1100)
        TabOrder = 3
        OnClick = RadioGroupClick
      end
    end
    object plParamBottom: TPanel
      Left = 0
      Top = 395
      Width = 390
      Height = 34
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 3
      object btnChanList: TBitBtn
        Left = 4
        Top = 4
        Width = 77
        Height = 25
        Caption = #1050#1072#1085#1072#1083#1099
        TabOrder = 0
        OnClick = btnChanListClick
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
          000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FF000000FF000000FF00
          000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF0000000000FF000000FF000000FF000000FF00
          000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF0000000000FF000000FF000000FF000000FF000000FF00
          000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF0000000000FF000000FF000000FF000000FF000000FF00
          000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF0000000000FF000000FF000000FF000000FF000000FF00
          000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
          0000000000000000000000000000FF000000FF000000FF000000FF000000FF00
          00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF0000000000FF000000FF000000FF000000FF000000FF00
          000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF0000000000FF000000FF000000FF000000FF000000FF00
          000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF0000000000FF000000FF000000FF000000FF000000FF00
          000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF0000000000FF000000FF000000FF000000FF000000FF00
          000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF0000000000FF000000FF000000FF000000FF00
          000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FF000000FF000000FF00
          000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
          000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
      end
    end
  end
  object Panel6: TPanel [2]
    Left = 0
    Top = 0
    Width = 251
    Height = 429
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel6'
    TabOrder = 0
    object TreeView1: TTreeView
      Left = 0
      Top = 23
      Width = 251
      Height = 406
      Align = alClient
      HideSelection = False
      Images = iImageList
      Indent = 19
      ParentShowHint = False
      PopupMenu = PopupMenu1
      ReadOnly = True
      RightClickSelect = True
      RowSelect = True
      ShowButtons = False
      ShowHint = False
      ShowLines = False
      TabOrder = 0
      OnChange = TreeView1Change
      OnDeletion = TreeView1Deletion
    end
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 251
      Height = 23
      Align = alTop
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object Panel14: TPanel
        Left = 123
        Top = 1
        Width = 127
        Height = 21
        Align = alClient
        BevelOuter = bvNone
        Caption = #1057#1087#1080#1089#1086#1082' '#1057#1054#1052'-'#1087#1086#1088#1090#1086#1074
        TabOrder = 0
      end
      object Panel3: TPanel
        Left = 1
        Top = 1
        Width = 122
        Height = 21
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 1
        object cbScan: TComboBox
          Left = 1
          Top = 0
          Width = 120
          Height = 21
          Style = csDropDownList
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemHeight = 13
          ParentFont = False
          TabOrder = 0
          OnChange = cbScanChange
        end
      end
    end
  end
  inherited MenuSAA: TMainMenu
    Top = 38
  end
  inherited PopupMenu1: TPopupMenu
    Left = 74
    Top = 38
  end
  inherited alDefault: TActionList
    Top = 38
    object aOneCannPol: TAction
      Caption = '&'#1054#1087#1088#1086#1089' '#1085#1077' '#1073#1086#1083#1077#1077' '#1086#1076#1085#1086#1075#1086' '#1082#1072#1085#1072#1083#1072
      ShortCut = 32842
    end
  end
  inherited iImageList: TImageList
    Left = 140
    Top = 40
  end
  inherited ilMenu: TImageList
    Top = 36
  end
end
