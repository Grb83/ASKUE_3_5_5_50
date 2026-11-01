object fmRTRNP: TfmRTRNP
  Left = 491
  Top = 67
  Width = 1429
  Height = 657
  HelpContext = 210502
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #1057#1086#1089#1090#1086#1103#1085#1080#1077' '#1086#1087#1088#1086#1089#1072' RTRNP '#1084#1072#1088#1096#1088#1091#1090#1080#1079#1072#1090#1086#1088#1086#1074
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object PanelAll: TPanel
    Left = 0
    Top = 0
    Width = 1421
    Height = 630
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object Splitter1: TSplitter
      Left = 433
      Top = 0
      Width = 7
      Height = 587
      Cursor = crHSplit
      Beveled = True
    end
    object PanelDet: TPanel
      Left = 440
      Top = 0
      Width = 981
      Height = 587
      Align = alClient
      Caption = 'PanelDet'
      TabOrder = 0
      object grMeters: TDBGridEh
        Left = 1
        Top = 33
        Width = 979
        Height = 338
        Align = alClient
        DataSource = dsSlave
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
        Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        OptionsEh = [dghFixed3D, dghClearSelection]
        ParentFont = False
        PopupMenu = PopupMenu1
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = [fsBold]
        TitleLines = 2
        UseMultiTitle = True
        OnDrawColumnCell = grMetersDrawColumnCell
        OnEnter = grRoutersEnter
        OnTitleClick = grMetersTitleClick
        Columns = <
          item
            EditButtons = <>
            FieldName = 'CMSTATE'
            Footers = <>
            Title.Caption = ' '
            Width = 20
          end
          item
            EditButtons = <>
            FieldName = 'TAG'
            Footers = <>
            Title.Caption = #1058#1080#1087' '#1091#1089#1090#1088#1086#1081#1089#1090#1074#1072
            Width = 123
          end
          item
            EditButtons = <>
            FieldName = 'DCURRPOWER'
            Footers = <>
            Title.Caption = #1058#1077#1082#1091#1097#1080#1077' '#1087#1086#1082#1072#1079#1072#1085#1080#1103' '#1079#1072
            Width = 113
          end
          item
            EditButtons = <>
            FieldName = 'VNAME'
            Footers = <>
            Title.Caption = #1058#1086#1095#1082#1072' '#1091#1095#1105#1090#1072
            Width = 200
          end
          item
            EditButtons = <>
            FieldName = 'CANAL'
            Footers = <>
            Title.Caption = #1053#1086#1084#1077#1088' '#1089#1095#1105#1090#1095#1080#1082#1072
          end
          item
            EditButtons = <>
            FieldName = 'STALL'
            Footers = <>
            Title.Caption = #1057#1086#1089#1090#1086#1103#1085#1080#1077' '#1086#1090#1074#1077#1090#1086#1074'|'#1074#1089#1077#1075#1086
            Width = 41
          end
          item
            EditButtons = <>
            FieldName = 'STNORMA'
            Footers = <>
            Title.Caption = #1057#1086#1089#1090#1086#1103#1085#1080#1077' '#1086#1090#1074#1077#1090#1086#1074'|'#1085#1086#1088#1084'.'
            Width = 41
          end
          item
            EditButtons = <>
            FieldName = 'STWAIT'
            Footers = <>
            Title.Caption = #1057#1086#1089#1090#1086#1103#1085#1080#1077' '#1086#1090#1074#1077#1090#1086#1074'|'#1086#1078#1080#1076#1072#1085#1080#1077
          end
          item
            EditButtons = <>
            FieldName = 'STERR'
            Footers = <>
            Title.Caption = #1057#1086#1089#1090#1086#1103#1085#1080#1077' '#1086#1090#1074#1077#1090#1086#1074'|'#1086#1096#1080#1073#1082#1072
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'VSTATE'
            Footers = <>
            Title.Caption = #1054#1087#1088#1086#1089
            Width = 66
          end
          item
            EditButtons = <>
            FieldName = 'VOFF'
            Footers = <>
            Title.Caption = #1056#1077#1083#1077'|'#1057#1086#1089#1090'.'
            Width = 42
          end
          item
            EditButtons = <>
            FieldName = 'DOFF'
            Footers = <>
            Title.Caption = #1056#1077#1083#1077'|'#1044#1072#1090#1072' '#1080#1079#1084#1077#1085#1077#1085#1080#1103
            Width = 114
          end>
      end
      object PanelDetTop: TPanel
        Left = 1
        Top = 1
        Width = 979
        Height = 32
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object ToolBar1: TToolBar
          Left = 896
          Top = 0
          Width = 83
          Align = alRight
          AutoSize = True
          ButtonHeight = 25
          ButtonWidth = 25
          Caption = 'ToolBar1'
          EdgeInner = esNone
          EdgeOuter = esNone
          Images = ilMenu
          TabOrder = 0
          object btnErrorFilter: TToolButton
            Left = 0
            Top = 2
            Hint = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1089' '#1086#1096#1080#1073#1082#1072#1084#1080
            AllowAllUp = True
            Caption = 'btnErrorFilter'
            Down = True
            ImageIndex = 10
            ParentShowHint = False
            ShowHint = True
            Style = tbsCheck
            OnClick = btnOkFilterClick
          end
          object btnWarningFilter: TToolButton
            Left = 25
            Top = 2
            Hint = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1085#1077#1086#1087#1088#1086#1096#1077#1085#1085#1099#1077
            AllowAllUp = True
            Caption = 'btnWarningFilter'
            Down = True
            ImageIndex = 8
            ParentShowHint = False
            ShowHint = True
            Style = tbsCheck
            OnClick = btnOkFilterClick
          end
          object btnOkFilter: TToolButton
            Left = 50
            Top = 2
            Hint = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1086#1087#1088#1086#1096#1077#1085#1085#1099#1077
            AllowAllUp = True
            Caption = 'btnOkFilter'
            Down = True
            ImageIndex = 9
            ParentShowHint = False
            ShowHint = True
            Style = tbsCheck
            OnClick = btnOkFilterClick
          end
          object ToolButton2: TToolButton
            Left = 75
            Top = 2
            Width = 8
            Caption = 'ToolButton2'
            ImageIndex = 110
            Style = tbsSeparator
          end
        end
        object ToolBar3: TToolBar
          Left = 0
          Top = 0
          Width = 9
          Align = alLeft
          AutoSize = True
          ButtonHeight = 25
          ButtonWidth = 25
          Caption = 'ToolBar1'
          EdgeInner = esNone
          EdgeOuter = esNone
          Images = ilMenu
          TabOrder = 1
          object ToolButton1: TToolButton
            Left = 0
            Top = 2
            Width = 9
            Caption = 'ToolButton1'
            ImageIndex = 76
            Style = tbsSeparator
          end
        end
      end
      object PanelDetDetails: TPanel
        Left = 1
        Top = 371
        Width = 979
        Height = 215
        Align = alBottom
        TabOrder = 2
        object gbCurrent: TGroupBox
          Left = 1
          Top = 144
          Width = 977
          Height = 70
          Align = alBottom
          Caption = #1055#1086#1082#1072#1079#1072#1085#1080#1103':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object dbtQ2M: TDBText
            Left = 40
            Top = 48
            Width = 38
            Height = 13
            AutoSize = True
            DataField = 'Q2M'
            DataSource = dsDetDetails
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object dbtQ1M: TDBText
            Left = 40
            Top = 32
            Width = 38
            Height = 13
            AutoSize = True
            DataField = 'Q1M'
            DataSource = dsDetDetails
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label4: TLabel
            Left = 8
            Top = 48
            Width = 25
            Height = 13
            Caption = 'R L:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label3: TLabel
            Left = 8
            Top = 32
            Width = 26
            Height = 13
            Caption = 'R C:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object dbtERM: TDBText
            Left = 40
            Top = 16
            Width = 39
            Height = 13
            AutoSize = True
            DataField = 'ERM'
            DataSource = dsDetDetails
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label1: TLabel
            Left = 8
            Top = 16
            Width = 13
            Height = 13
            Caption = 'A:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label5: TLabel
            Left = 256
            Top = 16
            Width = 21
            Height = 13
            Caption = 'U1:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object dbtVolt: TDBText
            Left = 280
            Top = 16
            Width = 33
            Height = 13
            AutoSize = True
            DataField = 'VOLT'
            DataSource = dsDetDetails
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label6: TLabel
            Left = 256
            Top = 32
            Width = 21
            Height = 13
            Caption = 'U2:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object dbtVolt2: TDBText
            Left = 280
            Top = 32
            Width = 39
            Height = 13
            AutoSize = True
            DataField = 'VOLT2'
            DataSource = dsDetDetails
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label7: TLabel
            Left = 256
            Top = 48
            Width = 21
            Height = 13
            Caption = 'U3:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object dbtVolt3: TDBText
            Left = 280
            Top = 48
            Width = 39
            Height = 13
            AutoSize = True
            DataField = 'VOLT3'
            DataSource = dsDetDetails
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label8: TLabel
            Left = 376
            Top = 16
            Width = 16
            Height = 13
            Caption = 'I1:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object dbtCurrento: TDBText
            Left = 400
            Top = 16
            Width = 55
            Height = 13
            AutoSize = True
            DataField = 'CURRENTO'
            DataSource = dsDetDetails
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label9: TLabel
            Left = 376
            Top = 32
            Width = 16
            Height = 13
            Caption = 'I2:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object dbtCurr2: TDBText
            Left = 400
            Top = 32
            Width = 40
            Height = 13
            AutoSize = True
            DataField = 'CURR2'
            DataSource = dsDetDetails
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label10: TLabel
            Left = 376
            Top = 48
            Width = 16
            Height = 13
            Caption = 'I3:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object dbtCurr3: TDBText
            Left = 400
            Top = 48
            Width = 40
            Height = 13
            AutoSize = True
            DataField = 'CURR3'
            DataSource = dsDetDetails
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object dbtCOSF: TDBText
            Left = 176
            Top = 48
            Width = 43
            Height = 13
            AutoSize = True
            DataField = 'COSF'
            DataSource = dsDetDetails
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label19: TLabel
            Left = 128
            Top = 48
            Width = 25
            Height = 13
            Caption = 'cos:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object dbtER: TDBText
            Left = 176
            Top = 16
            Width = 30
            Height = 13
            AutoSize = True
            DataField = 'ER'
            DataSource = dsDetDetails
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label17: TLabel
            Left = 128
            Top = 16
            Width = 41
            Height = 13
            Caption = 'A '#1090#1077#1082'.:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object dbtQ1: TDBText
            Left = 176
            Top = 32
            Width = 29
            Height = 13
            AutoSize = True
            DataField = 'Q1'
            DataSource = dsDetDetails
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label26: TLabel
            Left = 128
            Top = 32
            Width = 42
            Height = 13
            Caption = 'R '#1090#1077#1082'.:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label12: TLabel
            Left = 485
            Top = 16
            Width = 13
            Height = 13
            Caption = 'T:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object dbtnTemp: TDBText
            Left = 507
            Top = 16
            Width = 48
            Height = 13
            AutoSize = True
            DataField = 'NTEMP'
            DataSource = dsDetDetails
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
        end
        object GroupBox1: TGroupBox
          Left = 1
          Top = 88
          Width = 977
          Height = 56
          Align = alBottom
          Caption = #1057#1086#1089#1090#1086#1103#1085#1080#1077' '#1086#1090#1074#1077#1090#1086#1074':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object dbtSTErr: TDBText
            Left = 496
            Top = 32
            Width = 42
            Height = 13
            AutoSize = True
            DataField = 'STERR'
            DataSource = dsSlave
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object dbtSTWait: TDBText
            Left = 328
            Top = 32
            Width = 51
            Height = 13
            AutoSize = True
            DataField = 'STWAIT'
            DataSource = dsSlave
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label24: TLabel
            Left = 496
            Top = 16
            Width = 70
            Height = 13
            Caption = #1086#1096#1080#1073#1086#1095#1085#1099#1093':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label27: TLabel
            Left = 328
            Top = 16
            Width = 73
            Height = 13
            Caption = #1086#1078#1080#1076#1072#1077#1084#1099#1093':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object dbtSTNorma: TDBText
            Left = 160
            Top = 32
            Width = 60
            Height = 13
            AutoSize = True
            DataField = 'STNORMA'
            DataSource = dsSlave
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label28: TLabel
            Left = 160
            Top = 16
            Width = 78
            Height = 13
            Caption = #1085#1086#1088#1084#1072#1083#1100#1085#1099#1093':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label29: TLabel
            Left = 8
            Top = 16
            Width = 39
            Height = 13
            Caption = #1074#1089#1077#1075#1086':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object dbtSTAll: TDBText
            Left = 8
            Top = 32
            Width = 40
            Height = 13
            AutoSize = True
            DataField = 'STALL'
            DataSource = dsSlave
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
        end
        object Panel1: TPanel
          Left = 1
          Top = 1
          Width = 520
          Height = 87
          Align = alLeft
          BevelOuter = bvNone
          TabOrder = 2
          object Label20: TLabel
            Left = 8
            Top = 8
            Width = 76
            Height = 13
            Caption = #1058#1086#1095#1082#1072' '#1091#1095#1105#1090#1072':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label22: TLabel
            Left = 8
            Top = 40
            Width = 31
            Height = 13
            Caption = #1058#1080#1087': '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object dbtTAG: TDBText
            Left = 96
            Top = 40
            Width = 37
            Height = 13
            AutoSize = True
            DataField = 'TAG'
            DataSource = dsSlave
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object dbtVNAMEs: TDBText
            Left = 96
            Top = 8
            Width = 58
            Height = 13
            AutoSize = True
            DataField = 'VNAME'
            DataSource = dsSlave
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label21: TLabel
            Left = 8
            Top = 64
            Width = 142
            Height = 13
            Caption = #1058#1077#1082#1091#1097#1080#1077' '#1087#1086#1082#1072#1079#1072#1085#1080#1103' '#1079#1072':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object dbtDCURRPOWER: TDBText
            Left = 160
            Top = 64
            Width = 95
            Height = 13
            AutoSize = True
            DataField = 'DCURRPOWER'
            DataSource = dsSlave
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label2: TLabel
            Left = 304
            Top = 64
            Width = 118
            Height = 13
            Caption = #1057#1086#1089#1090#1086#1103#1085#1080#1077' '#1086#1087#1088#1086#1089#1072': '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object dbtVState1: TDBText
            Left = 432
            Top = 64
            Width = 53
            Height = 13
            AutoSize = True
            DataField = 'VSTATE'
            DataSource = dsSlave
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label25: TLabel
            Left = 304
            Top = 40
            Width = 62
            Height = 13
            Caption = #1048#1076'. '#1090#1086#1095#1082#1080':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object dbtCANAL: TDBText
            Left = 432
            Top = 8
            Width = 50
            Height = 13
            AutoSize = True
            DataField = 'CANAL'
            DataSource = dsSlave
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label23: TLabel
            Left = 304
            Top = 8
            Width = 89
            Height = 13
            Caption = #1047#1072#1074#1086#1076#1089#1082#1086#1081' '#8470': '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object dbtMID: TEdit
            Left = 432
            Top = 40
            Width = 73
            Height = 21
            BorderStyle = bsNone
            Color = clBtnFace
            Ctl3D = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentCtl3D = False
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
          end
        end
        object Panel2: TPanel
          Left = 521
          Top = 1
          Width = 360
          Height = 87
          Align = alLeft
          BevelOuter = bvNone
          TabOrder = 3
          object lbCapState: TLabel
            Left = 16
            Top = 8
            Width = 92
            Height = 13
            Caption = #1056#1077#1083#1077' '#1085#1072#1075#1088#1091#1079#1082#1080':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object dbtVOFF: TDBText
            Left = 114
            Top = 8
            Width = 42
            Height = 13
            AutoSize = True
            DataField = 'VOFF'
            DataSource = dsDetDetails
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object dbtVCMDOFF: TDBText
            Left = 16
            Top = 40
            Width = 66
            Height = 13
            AutoSize = True
            DataField = 'VCMDOFF'
            DataSource = dsDetDetails
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object dbtVEXECMDOFF: TDBText
            Left = 16
            Top = 64
            Width = 87
            Height = 13
            AutoSize = True
            DataField = 'VEXECMDOFF'
            DataSource = dsDetDetails
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
        end
      end
    end
    object PanelRouter: TPanel
      Left = 0
      Top = 0
      Width = 433
      Height = 587
      Align = alLeft
      Caption = 'PanelRouter'
      TabOrder = 1
      object grRouters: TDBGridEh
        Left = 1
        Top = 33
        Width = 431
        Height = 450
        Align = alClient
        DataSource = dsMain
        FooterColor = clWindow
        FooterFont.Charset = DEFAULT_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -11
        FooterFont.Name = 'MS Sans Serif'
        FooterFont.Style = []
        Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        OptionsEh = [dghFixed3D, dghClearSelection, dghFitRowHeightToText, dghAutoSortMarking]
        ReadOnly = True
        RowHeight = 4
        RowLines = 2
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        TitleLines = 3
        OnEnter = grRoutersEnter
        OnTitleClick = grRoutersTitleClick
        Columns = <
          item
            EditButtons = <>
            FieldName = 'CID'
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = #1048#1076'. '#1082#1072#1085#1072#1083#1072
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
          end
          item
            EditButtons = <>
            FieldName = 'VNAME'
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1082#1072#1085#1072#1083#1072
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 150
          end
          item
            EditButtons = <>
            FieldName = 'IMPLEMENT_DATE'
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = #1044#1072#1090#1072' '#1074#1074#1086#1076#1072
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
          end
          item
            EditButtons = <>
            FieldName = 'NREPEATICCP'
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = #1048#1076'. '#1087#1086#1089#1083#1077#1076#1085#1077#1075#1086' '#1087#1072#1082#1077#1090#1072
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 82
          end>
      end
      object PanelRouterDetails: TPanel
        Left = 1
        Top = 483
        Width = 431
        Height = 103
        Align = alBottom
        TabOrder = 1
        object dbtVNAME: TDBText
          Left = 160
          Top = 32
          Width = 53
          Height = 13
          AutoSize = True
          DataField = 'VNAME'
          DataSource = dsMain
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label11: TLabel
          Left = 8
          Top = 32
          Width = 139
          Height = 13
          Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1082#1072#1085#1072#1083#1072':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label13: TLabel
          Left = 8
          Top = 8
          Width = 71
          Height = 13
          Caption = #1048#1076'. '#1082#1072#1085#1072#1083#1072':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object dbtVSTATE: TDBText
          Left = 160
          Top = 80
          Width = 57
          Height = 13
          AutoSize = True
          DataField = 'NREPEATICCP'
          DataSource = dsMain
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label15: TLabel
          Left = 8
          Top = 80
          Width = 143
          Height = 13
          Caption = #1048#1076'. '#1087#1086#1089#1083#1077#1076#1085#1077#1075#1086' '#1087#1072#1082#1077#1090#1072':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object dbtDENTER: TDBText
          Left = 160
          Top = 56
          Width = 60
          Height = 13
          AutoSize = True
          DataField = 'IMPLEMENT_DATE'
          DataSource = dsMain
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label16: TLabel
          Left = 8
          Top = 56
          Width = 74
          Height = 13
          Caption = #1044#1072#1090#1072' '#1074#1074#1086#1076#1072':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object dbtCID: TEdit
          Left = 160
          Top = 8
          Width = 121
          Height = 19
          BorderStyle = bsNone
          Color = clBtnFace
          Ctl3D = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
        end
      end
      object PanelRouterButtons: TPanel
        Left = 1
        Top = 1
        Width = 431
        Height = 32
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 2
        object ToolBar2: TToolBar
          Left = 0
          Top = 0
          Width = 33
          Align = alLeft
          AutoSize = True
          ButtonHeight = 25
          ButtonWidth = 25
          Caption = 'ToolBar1'
          EdgeInner = esNone
          EdgeOuter = esNone
          Images = ilMenu
          TabOrder = 0
          object ToolButton3: TToolButton
            Left = 0
            Top = 2
            Width = 8
            Caption = 'ToolButton3'
            ImageIndex = 76
            Style = tbsSeparator
          end
          object btnResetPacketId: TToolButton
            Left = 8
            Top = 2
            Hint = #1057#1073#1088#1086#1089' '#1085#1091#1084#1077#1088#1072#1094#1080#1080' '#1087#1072#1082#1077#1090#1086#1074
            Caption = 'btnDelete'
            ImageIndex = 2
            ParentShowHint = False
            ShowHint = True
            OnClick = btnResetPacketIdClick
          end
        end
      end
    end
    object PanelBottom: TPanel
      Left = 0
      Top = 587
      Width = 1421
      Height = 43
      Align = alBottom
      TabOrder = 2
      DesignSize = (
        1421
        43)
      object btnRefresh: TBitBtn
        Left = 1230
        Top = 10
        Width = 81
        Height = 25
        Anchors = [akTop, akRight]
        Caption = #1054#1073#1085#1086#1074#1080#1090#1100
        TabOrder = 0
        OnClick = btnRefreshClick
        Glyph.Data = {
          1E070000424D1E07000000000000360000002800000022000000110000000100
          180000000000E8060000120B0000120B00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          0000FFFFFF60A5C3FDFEFEFFFFFFFFFFFFF8FBFCA7CDDE3F93BB177CAB0471A1
          1C7EAC5CA2C3E3EFF4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA5A5A5FEFEFEFFFF
          FFFFFFFFFBFBFBCDCDCD9393937C7C7C7070707F7F7FA3A3A3EFEFEFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFF0B75A365A9C7FFFFFFA9CEDF0F78A73C8AC35E
          C2EA68DBF45FDCF73FC4EE2595D20D76A5BEDAE7FFFFFFFFFFFFFFFFFFFFFFFF
          747474A9A9A9FFFFFFCECECE7777778C8C8CA5A5A5B1B1B1ADADAD9B9B9B8888
          88767676DADADAFFFFFFFFFFFFFFFFFF0000FFFFFF0A75A54C8AC22A87B03181
          B871EEF89DF7FC70F3FB6CEEFA6AE2F753CDF033B9EA38BBEB147AA9E9F3F7FF
          FFFFFFFFFFFFFFFF757575919191878787858585D3D3D3E3E3E3D5D5D5C6C6C6
          B5B5B5A3A3A39595959797977A7A7AF2F2F2FFFFFFFFFFFF0000FFFFFF0B75A5
          B0F7FB6FC8E8CFFBFDE7FCFEA9F8FC6CC4E8347FB50471A20370A30471A30974
          AC0D76AF8ABDD3FFFFFFFFFFFFFFFFFF757575E7E7E7B3B3B3EEEEEEF4F4F4E6
          E6E6AEAEAE868686717171717171727272757575777777BCBCBCFFFFFFFFFFFF
          0000FFFFFF0C76A5D5FBFDE5FCFEE5FCFE72EBF72D7FB84093B9D2E6EEFFFFFF
          7CB5CE328EBA44A1CF0571A41D7EADFFFFFFFFFFFFFFFFFF767676EFEFEFF3F3
          F3F3F3F3D3D3D3848484939393E5E5E5FFFFFFB5B5B58E8E8E9C9C9C7272727F
          7F7FFFFFFFFFFFFF0000FFFFFF0C76A5CFFAFD76F4FB81F2F9006F9F9FC9DBFF
          FFFFFFFFFFFFFFFFD5E7EF2B87AFD8F4FC5BA6CA0772A3FFFFFFFFFFFFFFFFFF
          767676EEEEEED8D8D8DBDBDB6E6E6EC8C8C8FFFFFFFFFFFFFFFFFFE7E7E78686
          86EDEDEDA4A4A4727272FFFFFFFFFFFF0000FFFFFF0D76A6CAFAFDE0FBFEDCFB
          FE6FC8EA2484B0F2F8FAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD8E9F01A7EA9FF
          FFFFFFFFFFFFFFFF767676EDEDEDF2F2F2F1F1F1B4B4B4848484F8F8F8FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFE9E9E97D7D7DFFFFFFFFFFFF0000FFFFFF1279A6
          006F9F006F9F006F9F006F9F006F9F4797BAECF4F8EFF6F9EFF6F9EFF6F9EFF6
          F9EEF5F9EBF4F7FFFFFFFFFFFFFFFFFF7979796E6E6E6E6E6E6E6E6E6E6E6E6E
          6E6E969696F4F4F4F6F6F6F6F6F6F6F6F6F6F6F6F5F5F5F4F4F4FFFFFFFFFFFF
          0000FFFFFFF4F9FBFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFDFEFE4B99BB006F9F
          2478AB287AAE2C7BAF2C7BAF187DAAFFFFFFFFFFFFFFFFFFF9F9F9FEFEFEFFFF
          FFFFFFFFFFFFFFFFFFFFFEFEFE9999996E6E6E7E7E7E8080808181818181817D
          7D7DFFFFFFFFFFFF0000FFFFFF0671A12886AE71AFCA1D7FAAD2E6EEFFFFFFFF
          FFFFF4F9FB2986B16ED4EDE5FBFEC0F9FDBBF7FB137BA8FFFFFFFFFFFFFFFFFF
          717171858585AEAEAE7E7E7EE5E5E5FFFFFFFFFFFFF9F9F9868686BEBEBEF3F3
          F3EBEBEBE9E9E97A7A7AFFFFFFFFFFFF0000FFFFFF0973A30571A44A99BB1B7E
          A9D5E7EFFFFFFFFFFFFFFFFFFF8FC0D50C71A1A9F6FB70F2FAB9F7FB127AA8FF
          FFFFFFFFFFFFFFFF7373737171719898987D7D7DE7E7E7FFFFFFFFFFFFFFFFFF
          BFBFBF737373E5E5E5D4D4D4E8E8E8797979FFFFFFFFFFFF0000FFFFFF1B7CAB
          0B74AC0471A10974A290C0D5EDF5F8BDDAE6318AB45490C6A1F5FBBDF9FDD9FB
          FDBBF8FB117AA7FFFFFFFFFFFFFFFFFF7D7D7D757575717171737373C0C0C0F5
          F5F5D9D9D98A8A8A959595E3E3E3EAEAEAF0F0F0E9E9E9797979FFFFFFFFFFFF
          0000FFFFFF71AECB2D96D2309FDB0571A5026FA10B72A24087BE6FCFED81F5FB
          A1F7FCB9F8FC69B9E081F0F81079A7FFFFFFFFFFFFFFFFFFAEAEAE8A8A8A8E8E
          8E7272726F6F6F7373738C8C8CB5B5B5DCDCDCE4E4E4E9E9E9A8A8A8DADADA78
          7878FFFFFFFFFFFF0000FFFFFFD9EAF11177A745C6EF4BDCF753D3F56BE7F96C
          EDFA6CF2FB75F4FB6BE8F7227BB1398FB6277BB20F78A7FFFFFFFFFFFFFFFFFF
          E9E9E97878789D9D9DA5A5A5A6A6A6B7B7B7C5C5C5D1D1D1D8D8D8CCCCCC7F7F
          7F8F8F8F808080777777FFFFFFFFFFFF0000FFFFFFFFFFFFAFD2E10C75A62E9D
          D84ACDF265E0F86BDCF564C4EB418EC5137AA7B1D3E2FFFFFF6CADC91279A6FF
          FFFFFFFFFFFFFFFFFFFFFFD2D2D27575758D8D8DA0A0A0B1B1B1B4B4B4A9A9A9
          8F8F8F7A7A7AD3D3D3FFFFFFACACAC797979FFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFDEECF35CA2C31E7FAC0471A1177BAA3F93BBA9CEDFFAFCFDFFFFFFFFFF
          FFFEFEFF71AFCAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFECECECA3A3A37F7F7F70
          70707B7B7B939393CECECEFCFCFCFFFFFFFFFFFFFEFEFEAEAEAEFFFFFFFFFFFF
          0000}
        NumGlyphs = 2
      end
      object btnClose: TBitBtn
        Left = 1327
        Top = 10
        Width = 81
        Height = 25
        Anchors = [akTop, akRight]
        Cancel = True
        Caption = #1047#1072#1082#1088#1099#1090#1100
        ModalResult = 2
        TabOrder = 1
        Glyph.Data = {
          AA030000424DAA03000000000000360000002800000011000000110000000100
          18000000000074030000120B0000120B00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF2424731C1C71A9A9CBFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFA4A4CC1D1D731F1F7200FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF121275
          000067303088C8C8E4FFFFFFFFFFFFFFFFFFFFFFFFC4C4E32E2E8B00006B0B0B
          7400C29F57C19130BF8F2DBF8F2DBF8F2D543F6103028800008A251C7C9B7341
          BF8F2DBF8F2D967046231A7C00008904038A52447900BD9238E3CDA1E2CC9FE2
          CC9FE2CC9FD5C09E695EA30606AA0000A72D29A1BEABA4BCAAA42B26A50000A6
          0606A96F64A6B38A3D00C89E48FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5F5FC76
          76DA0606C20000BE3A3AD03636CD0000BD0505C07979E1F8F8FDC89E4800C69B
          45FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5F5FC8080E50909CD0000CA00
          00CA0C0CCD8686E7F8F8FEFFFFFFC69B4500C79B45FFFFFFFBFBFCFBFBFBFBFB
          FBFBFBFBFBFBFBFBFBFBC0C0EF2D2DD41414D11212D13030D6C8C8F2FBFBFCFF
          FFFFC79B4500C79B44FFFFFFF4F5F5F5F6F4F5F6F4F5F6F4F5F6F4D0D1EE6161
          DE3535D63737D63535D73333D65858DCD0D1EFFFFFFFC89B4500C59941FDFFFF
          EDEEEDF0F0EFF0F0EFF0F0EFCDCDEB6060DC3E3ED84141D98D8DE28989E24040
          D93D3DD96162DCDADBF8C89D4700C39541FBFFFFE8E7E6EBEAE9EBEAE9C6C6E6
          6969DE4B4BDB4F4FDC9291E1E6E5E8E4E3E88C8CE15656DD5656DD7676E4AB8C
          6C00C39542F9FCFFE0E0E0E5E4E3E5E4E38181E16B6BE16D6DE19796E1DEDDE3
          E5E4E3E5E4E3DBDAE39B9AE27C7CE57E7EE5867EC600C49643F4F8FFD6D5D3DC
          DBD9DCDBD98686E58080E69595DFD5D4D9DCDBD9DCDBD9DCDBD9DCDBD9D4D3DA
          9C9CDF8A8AE78E8DE600C59643F5FCFFDCE2E8E1E6ECE1E6ECA5A7E99EA0E8C1
          C5E9E1E6ECE1E6ECE1E6ECE1E6ECE1E6ECE1E6ECC0C4E7A7A9EEA093B700C395
          3DFBEEDAF7DFBBF7E2C1F7E2C1F7E2C1F7E2C1F7E2C1F7E2C1F7E2C1F7E2C1F7
          E2C1F7E2C1F7E2C1F7DFBBFBEEDAC79B4700C49438EABF7AD08508D4901ED490
          1DD4901DD4901DD4901DD4901DD4901DD4901DD4901DD4901DD4901ED08508EB
          BF7BC89B4600C28F2CEFCF99E5BC75E6C07BE6BF7BE6BF7BE6BF7BE6BF7BE6BF
          7BE6BF7BE6BF7BE6BF7BE6BF7BE7C07CE5BD75F0D19BC7993F00C69D4DBC871F
          BD8A23BD8A23BD8A23BD8A23BD8A23BD8A23BD8A23BD8A23BD8A23BD8A23BD8B
          24C0902EC29335C29233CBA45900}
      end
      object m_btnSave: TBitBtn
        Left = 0
        Top = 10
        Width = 131
        Height = 25
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1074' '#1092#1072#1081#1083'...'
        TabOrder = 2
        OnClick = m_btnSaveClick
      end
    end
  end
  object oqMain: TOraQuery
    Session = dmMain.orases
    SQL.Strings = (
      'begin'
      '  RYDA.COMSRVRTR_PG.get_rtrstate(:sort, :result);'
      'end;')
    BeforeOpen = oqMainBeforeOpen
    AfterScroll = oqMainAfterScroll
    Left = 32
    Top = 32
    ParamData = <
      item
        DataType = ftInteger
        Name = 'sort'
        ParamType = ptInput
      end
      item
        DataType = ftCursor
        Name = 'result'
        Value = 'Object'
      end>
  end
  object dsMain: TDataSource
    DataSet = oqMain
    Left = 32
    Top = 72
  end
  object oqSlave: TOraQuery
    Session = dmMain.orases
    SQL.Strings = (
      'begin'
      
        '  RYDA.COMSRVRTR_PG.get_rtrstatedet(:cid, :sort, :filter, :resul' +
        't);'
      'end;')
    BeforeOpen = oqSlaveBeforeOpen
    AfterScroll = oqSlaveAfterScroll
    Left = 608
    Top = 24
    ParamData = <
      item
        DataType = ftInteger
        Name = 'cid'
        Value = 0
      end
      item
        DataType = ftInteger
        Name = 'sort'
        ParamType = ptInput
        Value = 0
      end
      item
        DataType = ftInteger
        Name = 'filter'
        ParamType = ptInput
        Value = 0
      end
      item
        DataType = ftCursor
        Name = 'result'
        Value = 'Object'
      end>
  end
  object dsSlave: TDataSource
    DataSet = oqSlave
    Left = 608
    Top = 64
  end
  object ilMenu: TImageList
    Left = 136
    Top = 8
    Bitmap = {
      494C01010C000E00040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000004000000001002000000000000040
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000084840000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000000000848484000000000000000000000000000000
      0000000000000000000084000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008400000084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000084840000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0084848400000000008484840000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF000000000084848400000000000000000000000000FF00
      00008400000084000000FF000000FF0000008400000084000000FF0000008400
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF00000084000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000840000008400000084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000084840000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0084848400000000008484840000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000000000000000000000000000000000FF000000FF00
      0000840000008400000000000000000000000000000000000000FF0000008400
      0000840000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      84000000FF000000000000000000000000000000000000000000000000008400
      0000840000008400000084000000840000000000000000000000000000000000
      000000000000000000000000000000000000000000000084840000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF000000000084848400000000000000000000000000FF000000FF00
      0000FF000000FF000000FF000000000000000000000084000000FF000000FF00
      00008400000000000000000000000000000000000000000000000000FF000000
      84000000FF000000FF000000FF000000FF00000084000000840000008400C6C6
      C600000084000000FF0000000000000000000000000000000000840000008400
      00008400000084000000FFFFFF00840000008400000084000000840000008400
      000084000000000000000000000000000000000000000084840000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF000000000000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000084000000FF000000FF00
      0000FF000000FF000000840000000000000000000000FF000000FF000000FF00
      0000FF000000FF0000000000000000000000000000000000000000008400C6C6
      C600000084000000FF00848484000000FF00C6C6C6000000FF000000FF00C6C6
      C6000000FF000000840000000000000000000000000084000000840000008400
      000084000000FFFFFF00FFFFFF00840000008400000084000000840000008400
      00008400000084000000000000000000000000000000000000000084840000FF
      FF0000FFFF0000FFFF0000848400000000000084840000FFFF0000FFFF0000FF
      FF00000000008484840000000000000000000000000084000000FF000000FF00
      0000FF000000FF000000FF0000000000000000000000FF000000FF000000FF00
      000084000000FF000000000000000000000000000000000000000000FF008484
      84008484840000008400C6C6C600C6C6C6000000FF00C6C6C600C6C6C6008484
      8400C6C6C6000000FF0000000000000000008400000084000000840000008400
      0000FFFFFF00FFFFFF00FFFFFF00840000008400000084000000840000008400
      00008400000084000000840000000000000000000000000000000084840000FF
      FF0000FFFF0000FFFF0000000000000000000000000000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000084000000FF000000FF00
      0000FF000000FF000000FF0000000000000000000000FF000000FF000000FF00
      000084000000FF000000000000000000000000000000000000000000FF008484
      84008484840000008400C6C6C600C6C6C6000000FF00C6C6C600C6C6C6008484
      8400C6C6C6000000FF000000000000000000000000008400000084000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000084
      840000FFFF0000FFFF0000000000000000000000000000FFFF0000FFFF000000
      00008484840000000000000000000000000000000000FF000000FF000000FF00
      0000FF000000FF000000000000000000000000000000FF000000FF000000FF00
      0000FF000000FF00000000000000000000000000000000000000000084008484
      8400848484000000FF00C6C6C6000000FF00C6C6C6000000FF000000FF00C6C6
      C6000000FF00000084000000000000000000000000000000000084000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000084
      840000FFFF0000FFFF0000000000000000000000000000FFFF0000FFFF000000
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000FF000000FF000000FF00000084000000FF000000FF000000FF000000FF00
      00008400000084000000000000000000000000000000000000000000FF000000
      8400C6C6C600000084000000FF000000FF000000FF000000FF000000FF000000
      FF00000084000000FF0000000000000000000000000000000000000000008400
      0000FFFFFF00FFFFFF00FFFFFF00840000008400000084000000840000008400
      0000840000008400000084000000000000000000000000000000000000000000
      00000084840000FFFF0000FFFF000000000000FFFF0000FFFF00000000008484
      8400000000000000000000000000000000000000000000000000FF000000FF00
      0000FF000000FF000000FF0000000000000000000000FF000000FF000000FF00
      0000FF0000000000000000000000000000000000000000000000000000000000
      FF00000084000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      000084000000FFFFFF00FFFFFF00840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000084840000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000000000
      000000000000000000000000000000000000000000000000000084000000FF00
      0000FF000000FF000000FF0000000000000000000000FF000000FF000000FF00
      0000FF0000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000084000000FFFFFF00840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000084840000FFFF0000FFFF0000FFFF0000000000848484000000
      0000000000000000000000000000000000000000000000000000000000008400
      0000FF000000FF00000084000000FF000000FF000000FF00000084000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000084840000FFFF0000FFFF0000FFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF0000008400000084000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000848400008484000084840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6DE
      C60000000000000000000000000000000000000000000000000000000000C6DE
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484000000000000000000000000000000000000840000008400000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000840000008400000084
      0000008400000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00000000000000000000000000FFFFFF0000000000FFFF
      FF000000000000000000FFFFFF000000000000000000C6C6C600000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C60000000000000000000000000000000000000000008484840000000000FFFF
      FF00FFFFFF00FFFFFF00000000000000000084848400F7FFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000C6DEC600000000000000000000840000008400000084
      0000008400000084000000840000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000C6C6C600000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C60000000000000000000000000000000000000000008484840000000000FFFF
      FF00FFFFFF0000000000C6DEC6000000840000FFFF0084848400F7FFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000840000008400000084
      0000008400000084000000840000008400000084000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF000000000000000000FFFFFF000000000000000000FFFF
      FF000000000000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008484840000000000FFFF
      FF000000000000FFFF00000084000000FF008400840000FFFF0084848400FFFF
      FF00FFFFFF000000000000000000000000000000000000840000008400000084
      0000008400000084000000840000008400000084000000840000008400000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000C6C6C600848484000000
      00000000000000000000000000000000000000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000084848400000000000000
      000000FFFF0084008400000000000000FF000000FF000000840000FFFF008484
      8400FFFFFF000000000000000000000000000000000000840000008400000084
      0000008400000084000000840000008400000084000000840000008400000084
      0000008400000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000FFFFFF0000000000FFFFFF000000000000000000C6C6C600848484000000
      00000000000000000000C6C6C6000000000000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000084848400000000008484
      8400000084000000FF000000FF00000000000000FF0000000000000084000000
      0000848484000000000000000000000000000000000000840000008400000084
      0000008400000084000000840000008400000084000000840000008400000084
      0000008400000084000000840000000000000000000000000000000000000000
      0000FFFFFF0000FFFF000000000000000000FFFFFF0000000000FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF000000000000000000C6C6C600848484000000
      00000000000000000000C6C6C6000000000000000000C6C6C600000000000000
      000000000000000000000000000000000000000000008484840000000000FFFF
      FF00848484000000000084848400FFFFFF00000000000000FF00000000000000
      8400000000000000000000000000000000000000000000840000008400000084
      0000008400000084000000840000008400000084000000840000008400000084
      000000840000008400000084000000000000000000000000000000000000FFFF
      FF0000FFFF000000000000FFFF00FFFFFF0000000000FFFFFF0000FFFF000000
      0000FFFFFF0000000000FFFFFF00000000000000000000000000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008484840000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000FF000000
      0000000084000000000000000000000000000000000000840000008400000084
      0000008400000084000000840000008400000084000000840000008400000084
      0000008400000000000000000000000000000000000000000000FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF0000000000FFFFFF0000FFFF0000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000000000000000C6C6
      C6008484840000000000000000000000000000000000C6C6C600848484000000
      000000000000000000000000000000000000000000008484840000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      FF00000000000000840000000000000000000000000000840000008400000084
      0000008400000084000000840000008400000084000000840000008400000000
      000000000000000000000000000000000000000000000000000000FFFF00FFFF
      FF0000FFFF00FFFFFF0000000000FFFFFF0000FFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008484840000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      00000000FF000000000000008400000000000000000000840000008400000084
      0000008400000084000000840000008400000084000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000008484
      8400000000000000000000000000000000000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF0000008400000000000000000000840000008400000084
      0000008400000084000000840000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFF00000000000000FFFF00FFFF
      FF0000FFFF00FFFFFF0000FFFF00000000000000000000000000FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF00000000000000000000000000000000008484
      8400000000000000000000000000000000000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000840000008400000084
      0000008400000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFF0000FFFF00000000000000FF
      FF00FFFFFF0000FFFF000000000000FFFF00FFFFFF0000FFFF0000000000FFFF
      FF0000000000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000840000008400000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFF0000FFFF0000FFFF00000000
      000000FFFF00FFFFFF0000FFFF00FFFFFF000000000000000000FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFF0000FFFF0000FFFF0000FFFF
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400000000000000000000000000000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008484840000000000C6DE
      C600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600000000000000000000000000000000008484840000000000008484000084
      840000848400008484000084840000848400008484000084840000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008484840000000000C6DE
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00C6C6C6000000000000000000000000008484840000000000008484000084
      840000848400008484000084840000848400008484000084840000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008484840000000000C6DE
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6DE
      C60000000000FFFFFF00FFFFFF00000000008484840000000000008484000084
      840000848400008484000084840000848400008484000084840000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000C6C6C60000000000C6C6C60000000000C6C6
      C600C6C6C600C6C6C600C6C6C600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400C6DEC600C6DEC600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008484
      840000000000FFFFFF00FFFFFF0000000000848484000000000000FFFF000084
      840000848400008484000084840000848400008484000084840000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000C6C6C6000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C60000000000000000000000000000000000000000000000000000000000C6C6
      C600000000000000000000000000000000000000000084848400000000008484
      84000000000084848400C6DEC600C6DEC600FFFFFF00FFFFFF00C6DEC6000000
      000000000000000000000000000000000000848484000000000000FFFF000084
      8400008484000084840000848400008484000084840000848400000000000000
      00000000000000000000000000000000000000000000C6C6C600000000000000
      00000000000000000000000000000000000000FF000000840000000000008484
      8400FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000008484840000000000000000000000000084848400000000000000
      000000000000000000000000000000000000000000008484840000000000C6DE
      C600F7FFFF00848484000000000084848400C6DEC600C6DEC600848484000000
      0000F7FFFF00000000000000000000000000848484000000000000FFFF000084
      8400008484000084840000848400008484000084840000848400008484000084
      8400008484000084840000000000000000000000000000000000008400000084
      00000084000000840000008400000084000000FF000000FF0000008400000000
      000084848400FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008484840000000000C6DE
      C600FFFFFF00FFFFFF00F7FFFF0000000000000000000000000000000000F7FF
      FF00FFFFFF00000000000000000000000000848484000000000000FFFF000084
      8400008484000084840000848400008484000084840000848400008484000084
      840000848400008484000000000000000000000000000000000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF00000084
      00000000000084848400FFFFFF0000000000000000000000000000000000C6C6
      C60000000000000000000000000000000000C6C6C60000000000000000000000
      000000000000000000000000000000000000000000008484840000000000C6DE
      C600F7FFFF00848484000000000084848400F7FFFF00F7FFFF00848484000000
      000000000000000000000000000000000000848484000000000000FFFF000084
      8400008484000084840000848400008484000084840000848400008484000084
      840000848400008484000000000000000000000000000000000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF0000008400000000
      000084848400FFFFFF00FFFFFF0000000000000000000000000000000000C6C6
      C60000000000000000000000000000000000C6C6C60000000000000000000000
      0000000000000000000000000000000000000000000084848400000000008484
      84000000000084848400C6DEC600F7FFFF00FFFFFF00FFFFFF00F7FFFF008484
      840000000000FFFFFF00FFFFFF00000000008484840000000000008484000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000848400000000000000000000000000C6C6C600000000000000
      00000000000000000000000000000000000000FF000000840000000000008484
      8400FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C6DEC600F7FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6DE
      C60000000000FFFFFF00FFFFFF00000000008484840000000000008484000000
      0000F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FF
      FF00000000000084840000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000848484000000000000000000000000000000
      000000000000000000000000000000000000000000008484840000000000C6DE
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6DEC600C6DE
      C600C6C6C6000000000000000000000000000000000084848400000000000000
      0000F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00C6DE
      C600000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C6000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008484840000000000C6DE
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6DEC6000000
      0000000000000000000000000000000000000000000000000000848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008484840000000000C6DE
      C600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC6000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848484008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000400000000100010000000000000200000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000C001FFFFFFFFFFFF8000FC3FF81FFFFF
      0000E00FF00FF9FF0000C007E007F0FF000183C3C003E0FF800181838001C007
      8003018180018003C003018180010001C007018180018001E00703818001C001
      E00F00018001E001F00F8183C003F0FFF01F8183E007F8FFF81FC007F00FFCFF
      F83FE00FF81FFEFFFC7FFC3FFFFFFFFFFFFFEFEFFFFFF000FFFF80079FFFF000
      07C1800387FFF00007C1800181FFF00007C18003807FF00001018003801FF000
      000182038007F000000180438001E000000180238001C0008003801380078000
      C1078009801F8000C1078004807F0000E38FC00081FF0000E38FFFF987FF0001
      FFFFFFFF9FFF0003FFFFFFFFFFFF0007E00FC000FFFFFE49C0078000FFFFFE49
      800B0000FFFFFFFF80010000FFFFFFFF80000000FE21C7C700000000C001C7C7
      800100008002C387800300018000C007800300018000C007800100018000C007
      800000018002C00700000001FF04C00780018003FF01F39F8003C5AFFFFFF39F
      800BE3DFFFFFF39FC007F03FFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object oqDetDetails: TOraQuery
    Session = dmMain.orases
    SQL.Strings = (
      'begin'
      '  RYDA.COMSRVRTR_PG.get_rtrdetcurpower(:mid, :result);'
      'end;')
    Left = 636
    Top = 122
    ParamData = <
      item
        DataType = ftInteger
        Name = 'mid'
        ParamType = ptInput
      end
      item
        DataType = ftCursor
        Name = 'result'
        Value = 'Object'
      end>
  end
  object dsDetDetails: TDataSource
    DataSet = oqDetDetails
    Left = 704
    Top = 128
  end
  object oqQuery: TOraQuery
    Session = dmMain.orases
    SQL.Strings = (
      'begin'
      '  RYDA.COMSRVRTR_PG.reset_packetid(:cid);'
      'end;')
    Left = 32
    Top = 120
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'cid'
      end>
  end
  object PopupMenu1: TPopupMenu
    Images = ilMenu
    Left = 585
    Top = 230
    object mnOFF: TMenuItem
      Tag = 1
      Caption = #1054#1090#1082#1083#1102#1095#1080#1090#1100' '#1087#1080#1090#1072#1085#1080#1077' '#1087#1086#1090#1088#1077#1073#1080#1090#1077#1083#1103
      Enabled = False
      Visible = False
      OnClick = mnONCancelClick
    end
    object mnON: TMenuItem
      Tag = 2
      Caption = #1042#1082#1083#1102#1095#1080#1090#1100' '#1087#1080#1090#1072#1085#1080#1077' '#1087#1086#1090#1088#1077#1073#1080#1090#1077#1083#1103
      Enabled = False
      Visible = False
      OnClick = mnONCancelClick
    end
    object mnONCancel: TMenuItem
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100' '#1082#1086#1084#1072#1085#1076#1091' '#1054#1090#1082#1083#1102#1095#1077#1085#1080#1103'/'#1042#1082#1083#1102#1095#1077#1085#1080#1103
      Enabled = False
      Visible = False
      OnClick = mnONCancelClick
    end
  end
end
