inherited fmMaketArmR: TfmMaketArmR
  Left = 344
  Top = 106
  Width = 975
  Height = 638
  HelpContext = 18031
  Caption = ''
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter [0]
    Left = 211
    Top = 0
    Width = 3
    Height = 531
    Cursor = crHSplit
    MinSize = 120
  end
  inherited iplBottom: TPanel
    Top = 554
    Width = 959
    inherited iplClose: TPanel
      Left = 878
    end
  end
  object Panel2: TPanel [2]
    Left = 0
    Top = 0
    Width = 211
    Height = 531
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 1
    object DeportsTree: TTreeView
      Left = 0
      Top = 0
      Width = 211
      Height = 531
      Align = alClient
      HideSelection = False
      Images = ImageList1
      Indent = 19
      ReadOnly = True
      TabOrder = 0
      OnChange = DeportsTreeChange
      OnChanging = DeportsTreeChanging
      OnEnter = DeportsTreeEnter
      OnExpanding = DeportsTreeExpanding
    end
  end
  object Panel1: TPanel [3]
    Left = 214
    Top = 0
    Width = 745
    Height = 531
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object MaketInfa: TPageControl
      Left = 0
      Top = 47
      Width = 745
      Height = 437
      ActivePage = Journal
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnChange = MaketInfaChange
      object OperWork: TTabSheet
        Caption = #1054#1087#1077#1088#1072#1090#1080#1074#1085#1072#1103' '#1088#1072#1073#1086#1090#1072
        ImageIndex = 2
        TabVisible = False
        object Panel4: TPanel
          Left = 0
          Top = 0
          Width = 745
          Height = 37
          Align = alTop
          BevelOuter = bvLowered
          TabOrder = 0
          object lbMaketName: TLabel
            Left = 41
            Top = 2
            Width = 69
            Height = 13
            Caption = '                 '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lbMaketState: TLabel
            Left = 62
            Top = 19
            Width = 57
            Height = 13
            Caption = '              '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object imMaketState: TImage
            Left = 40
            Top = 16
            Width = 20
            Height = 20
          end
          object Panel8: TPanel
            Left = 1
            Top = 1
            Width = 39
            Height = 35
            Align = alLeft
            BevelOuter = bvNone
            TabOrder = 0
            object SpeedButton1: TSpeedButton
              Left = 0
              Top = 0
              Width = 37
              Height = 35
              Hint = #1054#1090#1086#1073#1088#1072#1079#1080#1090#1100' '#1086#1082#1085#1086' '#1078#1091#1088#1085#1072#1083#1072
              Glyph.Data = {
                36030000424D3603000000000000360000002800000010000000100000000100
                1800000000000003000000000000000000000000000000000000FF00FFFF00FF
                FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
                FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
                00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF840000FF00FF
                FF00FF000000000000000000000000FF00FF000000000000000000FF00FF0000
                00000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
                00FFFF00FFFF00FFFF00FFFF0000FF00FFFF00FFFF00FFFF00FF840000FF00FF
                FF00FF000000000000000000000000FF00FF000000000000FF0000FF00000000
                00000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
                00FFFF00FFFF0000FF0000FF0000FF00FFFF00FFFF00FFFF00FF840000FF00FF
                FF00FF000000000000000000000000FF00FFFF0000FF0000FF0000FF0000FF00
                00FF0000FF0000FF0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
                0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000840000FF00FF
                FF00FF000000000000000000FF0000FF0000FF0000FF0000FF0000FF0000FF00
                00FF0000FF0000FF0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
                0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000840000FF00FF
                FF00FF000000000000000000000000FF00FFFF0000FF0000FF0000FF0000FF00
                00FF0000FF0000FF0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
                00FFFF00FFFF0000FF0000FF0000FF00FFFF00FFFF00FFFF00FF840000840000
                840000840000840000840000840000840000840000840000FF0000FF00008400
                00840000840000840000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
                00FFFF00FFFF00FFFF00FFFF0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
                FF00FF000000000000000000000000FF00FF000000000000000000FF00FF0000
                00000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
                00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
              OnClick = tbJournalClick
            end
          end
        end
      end
      object Journal: TTabSheet
        Caption = #1046#1091#1088#1085#1072#1083
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabVisible = False
        object Panel5: TPanel
          Left = 0
          Top = 0
          Width = 737
          Height = 47
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object TLabel
            Left = 182
            Top = 21
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object TimeStart: TLabel
            Left = 318
            Top = 44
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Panel6: TPanel
            Left = 0
            Top = 29
            Width = 737
            Height = 18
            Align = alBottom
            BevelInner = bvRaised
            BevelOuter = bvNone
            TabOrder = 0
            object lbDeportation: TLabel
              Left = 3
              Top = 2
              Width = 71
              Height = 13
              Caption = #1042#1089#1077' '#1082#1072#1085#1072#1083#1099
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
          end
          object Panel7: TPanel
            Left = 0
            Top = 0
            Width = 737
            Height = 29
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 1
            object Label2: TLabel
              Left = 3
              Top = 7
              Width = 70
              Height = 13
              Caption = #1047#1072' '#1087#1077#1088#1080#1086#1076' '#1089':  '
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Label4: TLabel
              Left = 218
              Top = 7
              Width = 15
              Height = 13
              Caption = #1087#1086':'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object dtFrom: TDateTimePicker
              Left = 72
              Top = 4
              Width = 90
              Height = 21
              CalAlignment = dtaLeft
              Date = 38818.6883014815
              Time = 38818.6883014815
              DateFormat = dfShort
              DateMode = dmComboBox
              Kind = dtkDate
              ParseInput = False
              TabOrder = 0
              OnChange = dtChange
            end
            object edFrom: TMaskEdit
              Left = 165
              Top = 4
              Width = 36
              Height = 21
              EditMask = '!99:99;1; '
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              MaxLength = 5
              ParentFont = False
              TabOrder = 1
              Text = '00:00'
            end
            object dtTill: TDateTimePicker
              Left = 236
              Top = 4
              Width = 90
              Height = 21
              CalAlignment = dtaLeft
              Date = 38818.6885512268
              Time = 38818.6885512268
              DateFormat = dfShort
              DateMode = dmComboBox
              Kind = dtkDate
              ParseInput = False
              TabOrder = 2
              OnChange = dtChange
            end
            object edTill: TMaskEdit
              Left = 330
              Top = 4
              Width = 36
              Height = 21
              EditMask = '!99:99;1; '
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              MaxLength = 5
              ParentFont = False
              TabOrder = 3
              Text = '00:00'
            end
            object tbFilter: TToolBar
              Left = 627
              Top = 0
              Width = 110
              Height = 29
              Align = alRight
              ButtonHeight = 23
              Caption = 'tbFilter'
              EdgeBorders = []
              EdgeInner = esNone
              EdgeOuter = esNone
              Images = ImageList1
              TabOrder = 4
              object tbTimer: TToolButton
                Left = 0
                Top = 2
                Hint = #1040#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1086#1077' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1077' '#1101#1082#1088#1072#1085#1072
                Caption = 'tbTimer'
                ImageIndex = 193
                Style = tbsCheck
                OnClick = tbTimerClick
              end
              object ToolButton7: TToolButton
                Left = 23
                Top = 2
                Width = 16
                Caption = 'ToolButton7'
                ImageIndex = 111
                Style = tbsSeparator
              end
              object tbState0: TToolButton
                Tag = 1
                Left = 39
                Top = 2
                Hint = #1054#1090#1086#1073#1088#1072#1078#1072#1090#1100' '#1087#1086#1083#1091#1095#1077#1085#1085#1099#1077', '#1085#1086' '#1085#1077' '#1079#1072#1075#1088#1091#1078#1077#1085#1085#1099#1077' '#1084#1072#1082#1077#1090#1099
                Caption = 'tbState0'
                Down = True
                ImageIndex = 108
                Style = tbsCheck
                OnClick = tbStateClick
              end
              object tbState1: TToolButton
                Tag = 2
                Left = 62
                Top = 2
                Hint = #1054#1090#1086#1073#1088#1072#1078#1072#1090#1100' '#1079#1072#1075#1088#1091#1078#1077#1085#1085#1099#1077' '#1084#1072#1082#1077#1090#1099
                Caption = 'tbState1'
                Down = True
                ImageIndex = 109
                Style = tbsCheck
                OnClick = tbStateClick
              end
              object tbState2: TToolButton
                Tag = 3
                Left = 85
                Top = 2
                Hint = 
                  #1054#1090#1086#1073#1088#1072#1078#1072#1090#1100' '#1084#1072#1082#1077#1090#1099' '#1089' '#1086#1096#1080#1073#1082#1072#1084#1080' '#1080#1076#1077#1085#1090#1080#1092#1080#1082#1072#1094#1080#1080', '#1088#1072#1079#1073#1086#1088#1072', '#1074#1077#1088#1080#1092#1080#1082#1072#1094#1080#1080 +
                  ' '#1080#1083#1080' '#1079#1072#1075#1088#1091#1079#1082#1080
                Caption = 'tbState2'
                Down = True
                ImageIndex = 110
                Style = tbsCheck
                OnClick = tbStateClick
              end
            end
          end
        end
        object MessageGrid: TDBGridEh
          Left = 0
          Top = 47
          Width = 737
          Height = 380
          Align = alClient
          DataSource = dsDeportInfo
          FooterColor = clWindow
          FooterFont.Charset = DEFAULT_CHARSET
          FooterFont.Color = clWindowText
          FooterFont.Height = -11
          FooterFont.Name = 'MS Sans Serif'
          FooterFont.Style = []
          Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
          ReadOnly = True
          TabOrder = 1
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          OnColumnMoved = MessageGridColumnMoved
          OnDblClick = MessageGridDblClick
          OnEnter = MessageGridEnter
          OnTitleClick = MessageGridTitleClick
          Columns = <
            item
              EditButtons = <>
              FieldName = 'nstate'
              Footers = <>
              MaxWidth = 20
              MinWidth = 20
              Title.Caption = '  '
              Width = 20
            end
            item
              EditButtons = <>
              FieldName = 'channel'
              Footers = <>
              Title.Caption = #1050#1072#1085#1072#1083
              Width = 140
            end
            item
              EditButtons = <>
              FieldName = 'c_dcreate'
              Footers = <>
              Title.Caption = #1044#1072#1090#1072' '#1087#1088#1080#1077#1084#1072
              Width = 124
            end
            item
              EditButtons = <>
              FieldName = 'c_ddate'
              Footers = <>
              Title.Caption = #1044#1072#1090#1072' '#1074' '#1084#1072#1082#1077#1090#1077
              Width = 89
            end
            item
              EditButtons = <>
              FieldName = 'c_dload'
              Footers = <>
              Title.Caption = #1044#1072#1090#1072' '#1079#1072#1075#1088#1091#1079#1082#1080
              Width = 123
            end
            item
              EditButtons = <>
              FieldName = 'vstate'
              Footers = <>
              Title.Caption = #1057#1086#1089#1090#1086#1103#1085#1080#1077
              Width = 140
            end
            item
              EditButtons = <>
              FieldName = 'ntypem'
              Footers = <>
              Title.Caption = #1058#1080#1087
              Width = 40
            end
            item
              Alignment = taRightJustify
              EditButtons = <>
              FieldName = 'noperation'
              Footers = <>
              Title.Caption = #1048#1076' '#1086#1087#1077#1088'.'
              Width = 50
            end
            item
              EditButtons = <>
              FieldName = 'recipient'
              Footers = <>
              Title.Caption = #1060'.'#1048'.'#1054
              Width = 70
            end
            item
              EditButtons = <>
              FieldName = 'verror'
              Footers = <>
              Title.Caption = #1054#1096#1080#1073#1082#1072
              Width = 600
            end>
        end
      end
      object Maket: TTabSheet
        Caption = #1052#1072#1082#1077#1090
        ImageIndex = 1
        TabVisible = False
        object reMaket: TRichEdit
          Left = 0
          Top = 37
          Width = 737
          Height = 391
          Align = alClient
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          ScrollBars = ssBoth
          TabOrder = 0
          WordWrap = False
        end
        object Panel3: TPanel
          Left = 0
          Top = 0
          Width = 737
          Height = 37
          Align = alTop
          BevelOuter = bvLowered
          TabOrder = 1
          object lbRepName: TLabel
            Left = 41
            Top = 2
            Width = 69
            Height = 13
            Caption = '                 '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lbState: TLabel
            Left = 61
            Top = 21
            Width = 57
            Height = 13
            Caption = '              '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object imState: TImage
            Left = 40
            Top = 18
            Width = 20
            Height = 18
          end
          object Panel9: TPanel
            Left = 1
            Top = 1
            Width = 39
            Height = 35
            Align = alLeft
            BevelOuter = bvNone
            TabOrder = 0
            object SpeedButton2: TSpeedButton
              Left = 0
              Top = 0
              Width = 37
              Height = 35
              Hint = #1054#1090#1086#1073#1088#1072#1079#1080#1090#1100' '#1086#1082#1085#1086' '#1078#1091#1088#1085#1072#1083#1072
              Glyph.Data = {
                36030000424D3603000000000000360000002800000010000000100000000100
                1800000000000003000000000000000000000000000000000000FF00FFFF00FF
                FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
                FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
                00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF840000FF00FF
                FF00FF000000000000000000000000FF00FF000000000000000000FF00FF0000
                00000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
                00FFFF00FFFF00FFFF00FFFF0000FF00FFFF00FFFF00FFFF00FF840000FF00FF
                FF00FF000000000000000000000000FF00FF000000000000FF0000FF00000000
                00000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
                00FFFF00FFFF0000FF0000FF0000FF00FFFF00FFFF00FFFF00FF840000FF00FF
                FF00FF000000000000000000000000FF00FFFF0000FF0000FF0000FF0000FF00
                00FF0000FF0000FF0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
                0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000840000FF00FF
                FF00FF000000000000000000FF0000FF0000FF0000FF0000FF0000FF0000FF00
                00FF0000FF0000FF0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
                0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000840000FF00FF
                FF00FF000000000000000000000000FF00FFFF0000FF0000FF0000FF0000FF00
                00FF0000FF0000FF0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
                00FFFF00FFFF0000FF0000FF0000FF00FFFF00FFFF00FFFF00FF840000840000
                840000840000840000840000840000840000840000840000FF0000FF00008400
                00840000840000840000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
                00FFFF00FFFF00FFFF00FFFF0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
                FF00FF000000000000000000000000FF00FF000000000000000000FF00FF0000
                00000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
                00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
              OnClick = tbJournalClick
            end
          end
        end
      end
    end
    object meError: TMemo
      Left = 0
      Top = 0
      Width = 745
      Height = 47
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 1
      Visible = False
    end
    object meErrorLoad: TMemo
      Left = 0
      Top = 484
      Width = 745
      Height = 47
      Align = alBottom
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 2
      Visible = False
    end
  end
  object tbTools: TToolBar [4]
    Left = 0
    Top = 531
    Width = 959
    Height = 23
    Align = alBottom
    ButtonHeight = 23
    ButtonWidth = 25
    Caption = 'tbTools'
    EdgeBorders = []
    Flat = True
    Images = ImageList1
    TabOrder = 3
    object tbTree: TToolButton
      Left = 0
      Top = 0
      Hint = #1057#1087#1088#1103#1090#1072#1090#1100'/'#1087#1086#1082#1072#1079#1072#1090#1100' '#1076#1077#1088#1077#1074#1086' '#1082#1072#1085#1072#1083#1086#1074
      Caption = #1057#1087#1088#1103#1090#1072#1090#1100'/'#1087#1086#1082#1072#1079#1072#1090#1100' '#1076#1077#1088#1077#1074#1086' '#1082#1072#1085#1072#1083#1086#1074
      Down = True
      Grouped = True
      ImageIndex = 57
      Style = tbsCheck
      OnClick = tbTreeClick
    end
    object ToolButton5: TToolButton
      Left = 25
      Top = 0
      Width = 8
      Caption = 'ToolButton5'
      ImageIndex = 58
      Style = tbsSeparator
    end
    object ToolButton3: TToolButton
      Left = 33
      Top = 0
      Action = acRefresh
    end
    object ToolButton2: TToolButton
      Left = 58
      Top = 0
      Width = 8
      Caption = 'ToolButton2'
      ImageIndex = 57
      Style = tbsSeparator
    end
    object tbReload: TToolButton
      Left = 66
      Top = 0
      Hint = #1042#1099#1087#1086#1083#1085#1080#1090#1100' '#1088#1072#1079#1073#1086#1088' '#1080' '#1074#1077#1088#1080#1092#1080#1082#1072#1094#1080#1102' '#1084#1072#1082#1077#1090#1072' '#1080#1079' '#1092#1072#1081#1083#1072' '#1087#1077#1088#1074#1080#1095#1085#1099#1093' '#1076#1072#1085#1085#1099#1093
      Caption = #1056#1072#1079#1073#1086#1088' '#1084#1072#1082#1077#1090#1072
      Enabled = False
      ImageIndex = 168
      Visible = False
      OnClick = tbReloadClick
    end
    object tbVerify: TToolButton
      Left = 91
      Top = 0
      Hint = #1042#1099#1087#1086#1083#1085#1080#1090#1100' '#1074#1077#1088#1080#1092#1080#1082#1072#1094#1080#1102' '#1084#1072#1082#1077#1090#1072
      Caption = #1042#1077#1088#1080#1092#1080#1094#1080#1088#1086#1074#1072#1090#1100' '#1084#1072#1082#1077#1090
      Enabled = False
      ImageIndex = 106
      Visible = False
      OnClick = tbVerifyClick
    end
    object tbLoad: TToolButton
      Left = 116
      Top = 0
      Hint = #1042#1099#1087#1086#1083#1085#1080#1090#1100' '#1079#1072#1075#1088#1091#1079#1082#1091' '#1084#1072#1082#1077#1090#1072
      Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1084#1072#1082#1077#1090
      ImageIndex = 169
      OnClick = tbLoadClick
    end
    object tbPreview: TToolButton
      Tag = 2
      Left = 141
      Top = 0
      Hint = #1055#1088#1086#1089#1084#1086#1090#1088#1077#1090#1100' '#1080#1089#1093#1086#1076#1085#1099#1081' '#1092#1072#1081#1083' '#1084#1072#1082#1077#1090#1072' '#1085#1072' '#1101#1082#1088#1072#1085#1077
      Caption = #1055#1088#1086#1089#1084#1086#1090#1088#1077#1090#1100' '#1080#1089#1093#1086#1076#1085#1099#1081' '#1092#1072#1081#1083' '#1084#1072#1082#1077#1090#1072
      ImageIndex = 76
      OnClick = tbPreviewClick
    end
    object tbOperWork: TToolButton
      Tag = 1
      Left = 166
      Top = 0
      Hint = #1054#1087#1077#1088#1072#1090#1080#1074#1085#1072#1103' '#1088#1072#1073#1086#1090#1072' '#1089' '#1084#1072#1082#1077#1090#1086#1084
      Caption = #1054#1087#1077#1088#1072#1090#1080#1074#1085#1072#1103' '#1088#1072#1073#1086#1090#1072' '#1089' '#1084#1072#1082#1077#1090#1086#1084
      ImageIndex = 141
      OnClick = tbOperWorkClick
    end
    object tbJournal: TToolButton
      Left = 191
      Top = 0
      Hint = #1054#1090#1086#1073#1088#1072#1079#1080#1090#1100' '#1086#1082#1085#1086' '#1078#1091#1088#1085#1072#1083#1072
      Caption = 'tbJournal'
      ImageIndex = 38
      OnClick = tbJournalClick
    end
    object ToolButton6: TToolButton
      Left = 216
      Top = 0
      Width = 8
      Caption = 'ToolButton6'
      ImageIndex = 76
      Style = tbsSeparator
    end
    object tbLoadFromFile: TToolButton
      Left = 224
      Top = 0
      Hint = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1085#1086#1074#1099#1081' '#1084#1072#1082#1077#1090' '#1080#1079' '#1092#1072#1081#1083#1072' '#1087#1086' '#1082#1072#1085#1072#1083#1091
      Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1085#1086#1074#1099#1081' '#1084#1072#1082#1077#1090' '#1080#1079' '#1092#1072#1081#1083#1072' '#1087#1086' '#1082#1072#1085#1072#1083#1091
      ImageIndex = 120
      OnClick = tbLoadFromFileClick
    end
    object tbDelete: TToolButton
      Left = 249
      Top = 0
      Action = iaDelete
      ImageIndex = 75
    end
    object ToolButton4: TToolButton
      Left = 274
      Top = 0
      Width = 8
      Caption = 'ToolButton4'
      ImageIndex = 57
      Style = tbsSeparator
    end
    object tbSave: TToolButton
      Left = 282
      Top = 0
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1074' '#1092#1072#1081#1083'...'
      Caption = 'tbSave'
      ImageIndex = 81
      OnClick = tbSaveClick
    end
    object tbPrint: TToolButton
      Left = 307
      Top = 0
      Hint = #1055#1077#1095#1072#1090#1100' ...'
      Caption = 'tbPrint'
      ImageIndex = 56
      OnClick = tbPrintClick
    end
    object ToolButton1: TToolButton
      Left = 332
      Top = 0
      Width = 8
      Caption = 'ToolButton1'
      ImageIndex = 57
      Style = tbsSeparator
    end
    object tbNotepad: TToolButton
      Left = 340
      Top = 0
      Caption = #1041#1083#1086#1082#1085#1086#1090
      ImageIndex = 192
      OnClick = tbNotepadClick
    end
  end
  object ImageList1: TImageList
    Left = 136
    Top = 8
    Bitmap = {
      494C0101C200C700040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002003000001002000000000000020
      0300000000000000000000000000000000000000000000000000000000000000
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
      0000848484000000000000000000000000000000000000000000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C6008484840000000000000000000000000000000000848484000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C60000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      000000000000C6C6C6000000000000000000000000008484840000000000FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00000000008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C6000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C60000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF00008484000000000000C6C6C600C6C6
      C60000000000C6C6C60000000000000000000000000000000000FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000000000C6C6C600C6C6
      C600C6C6C600C6C6C60000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084840000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00008484000000000000C6C6
      C600C6C6C600C6C6C6000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000000000C6C6
      C600C6C6C600C6C6C6000000000000000000000000008484840000000000FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00000000008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084840000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000848400000000
      0000C6C6C600C6C6C60000000000000000008484840000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF008484
      8400000000000000000084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFF0000FFFF
      00008484000084840000848400008484000084840000FFFF0000FFFF00000000
      0000C6C6C600C6C6C600000000000000000000000000FFFFFF00000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084840000FFFF
      0000848400008484000084840000848400008484000084840000FFFF00008484
      000000000000C6C6C60000000000000000000000000000000000000000000000
      0000848484000000000000000000000000000000000000000000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      000000000000C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848484008484000084840000848484008484000084840000848484008484
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000840000008400
      0000840000008400000084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008484000000000000000000000000008400000084000000840000008400
      0000840000008400000084000000840000008400000084000000840000008400
      0000840000008400000084000000000000000000000000000000000000000000
      0000000000000000000000008400000084000000840000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000084
      840000FFFF0000000000000000000000000084000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600848484008484
      8400848484008400000084848400000000000000000000000000000000000000
      0000000000000000FF0000008400000084000000840000008400000084000000
      8400000084000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF000000000000000000FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000084840000FF
      FF000000000000000000000000000000000084000000C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00C6C6C6008400000084848400000000000000000000000000000000000000
      0000000084000000FF000000FF000000FF000000FF000000FF00000084000000
      840000008400000000000000000000000000C6C6C60000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      000000000000000000000000000000000000000000000084840000FFFF000000
      00000000000000000000000000000000000084000000C6C6C600FFFFFF00FFFF
      FF000000000000000000FFFFFF00FFFFFF000000000000000000000000000000
      0000C6C6C6008400000084848400000000000000000000000000000000000000
      0000000084000000FF000000FF000000FF000000FF0000008400000084000000
      840000008400000000000000000000000000FFFFFF00C6C6C600000000000000
      00000000000000000000C6C6C600000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      00000000000000000000000000000000000000848400FFFFFF00000000000000
      00000000000000000000000000000000000084000000C6C6C600FFFFFF00FFFF
      FF000000000000000000FFFFFF00FFFFFF000000000000000000000000000000
      0000C6C6C6008400000084848400000000000000000000000000000000000000
      00000000FF000000FF00FFFFFF000000FF000000FF000000FF00000084000000
      840000008400000000000000000000000000FFFFFF00FFFFFF00C6C6C6000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF000000000000000000000000000000
      00000000000000000000000000000084840000FFFF0000000000000000000000
      00000000000000000000000000000000000084000000C6C6C600FFFFFF00FFFF
      FF000000000000000000FFFFFF00FFFFFF000000000000000000FFFFFF00FFFF
      FF00C6C6C6008400000084848400000000000000000000000000000000000000
      84000000FF000000FF00FFFFFF000000FF000000FF000000FF00000084000000
      840000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      00000000000000000000000084000000000000FFFF0000000000000000000000
      00000000000000000000000000000000000084000000C6C6C600FFFFFF00FFFF
      FF000000000000000000FFFFFF00FFFFFF000000000000000000FFFFFF00FFFF
      FF00C6C6C6008400000084848400000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF0000008400000084000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600000000000000000000000000FFFFFF000000000000000000000000000000
      000000FFFF00000000000000FF00FFFFFF0000FFFF0000FFFF00000000000000
      00000000000000000000000000000000000084000000C6C6C600FFFFFF00FFFF
      FF000000000000000000FFFFFF00FFFFFF000000000000000000FFFFFF00FFFF
      FF00C6C6C6008400000084848400000000000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      000000FFFF0000FFFF00000000000000000000FFFF0000FFFF00000000000000
      00000000000000000000000000000000000084000000C6C6C600FFFFFF000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      0000C6C6C6008400000084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000000000000000000000
      00000000000000000000000000000000000084000000C6C6C600FFFFFF000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      0000C6C6C6008400000084848400000000008484840000000000000000000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00C6C6C6000000000000000000000000000000
      00000000000000FFFF0000FFFF0000FFFF0000FFFF0000000000000000000000
      00000000000000000000000000000000000084000000C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00C6C6C6008400000084848400000000008484840000000000848484000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00C6C6C600000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000FFFF0000FFFF0000FFFF0000000000000000000000
      00000000000000000000000000000000000084000000C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00C6C6C6008400000084848400000000000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C600840000000000000000000000000000000000000084000000840000008400
      0000840000008400000084000000840000000000000000000000000000000000
      0000000000000000000000FFFF000000000000FFFF0000000000000000000000
      00000000000000000000000000000000000084000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600848484008484
      8400848484008400000084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C600FFFFFF00FFFFFF00C6C6
      C6008400000084000000C6C6C600000000000000000000000000840000008400
      0000840000008400000084000000840000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000008400000084000000840000008400
      0000840000008400000084000000840000008400000084000000840000008400
      0000840000008400000084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C60084000000840000008400000084000000C6C6C600C6C6C600000000008400
      0000840000008400000084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000840000008400
      000084000000840000008400000000000000000000000000000000FFFF0000FF
      FF0000000000000000000000FF000000FF000000FF000000FF000000FF000000
      000000000000000000000000000000000000000000000000000000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF00000000000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF0000FFFF0000FF
      FF0000FFFF00FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      00000000FF000000FF0000000000000000000000000000FFFF0000FFFF0000FF
      FF0000FFFF00FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      00000000000000000000000000000000000000FFFF0000000000000000000000
      000000FFFF0000FFFF0000FFFF0000FFFF00000000000000000000FFFF0000FF
      FF0000000000000000000000000000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000000000000000000000000000000000000000000000
      0000000000000000FF000000FF00000000000000000000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000FFFF0000FFFF00000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF000000FF00FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      000000000000000000000000FF00000000000000000000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF00FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      000000000000000000000000000000000000000000000000000000FFFF000000
      00000000000000FFFF0000FFFF0000FFFF00000000000000000000FFFF000000
      00000000000000FFFF0000000000000000000000000000000000000000008484
      84000000000000FFFF0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000FFFF0000FFFF000000
      000000FFFF0000FFFF0000FFFF000000FF008484840000000000000000000000
      000000000000000000000000FF000000FF0000FFFF0000FFFF0000FFFF000000
      000000FFFF0000FFFF0000FFFF00848484008484840000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF000000
      00000000000000FFFF0000FFFF0000FFFF00000000000000000000FFFF0000FF
      FF0000FFFF0000FFFF0000000000000000000000000000000000000000000000
      000000FFFF0000FFFF0000848400000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000FFFF0000FFFF000000
      00000000000000FFFF0000FFFF0000FFFF000000FF00FFFF0000FFFF0000FFFF
      000000000000000000000000FF000000FF0000FFFF0000FFFF0000FFFF000000
      00000000000000FFFF0000FFFF0000FFFF00FFFF0000FFFF0000FFFF0000FFFF
      000000000000000000000000000000000000000000000000000000FFFF000000
      00000000000000FFFF0000FFFF0000FFFF00000000000000000000FFFF0000FF
      FF0000FFFF0000FFFF0000000000000000000000000084848400848484008484
      84000000000000FFFF0000FFFF00008484000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000FFFF000000FF000000
      0000000000000000000000FFFF0000FFFF0000FFFF000000FF00848484000000
      000000000000000000000000FF000000FF0000FFFF0000FFFF00000000000000
      0000000000000000000000FFFF0000FFFF0000FFFF0084848400848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000FFFF0000FFFF00000000000000000000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000FFFF00008484000084840000000000000000000000
      00000000000000000000000000000000000000FFFF0000FFFF000000FF000000
      000000000000FFFF000000FFFF0000FFFF0000FFFF0000FFFF000000FF00FFFF
      000000000000000000000000FF000000FF0000FFFF0000FFFF00000000000000
      000000000000FFFF000000FFFF0000FFFF0000FFFF0000FFFF00FFFF0000FFFF
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000FFFF0000FFFF00000000000000000000FFFF000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF0000FFFF000084840000848400008484000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      000000000000000000008484840000FFFF0000FFFF0000FFFF0000FFFF000000
      FF0000000000000000000000FF000000FF000000000000000000000000000000
      000000000000000000008484840000FFFF0000FFFF0000FFFF0000FFFF000000
      000000000000000000000000000000000000000000000000000000FFFF000000
      00000000000000FFFF0000FFFF0000FFFF00000000000000000000FFFF000000
      00000000000000FFFF0000000000000000000000000000000000000000000000
      0000008484000084840084848400000000000000000084848400848484008484
      84000000000000000000000000000000000000000000000000000000FF000000
      000000000000FFFF0000FFFF0000FFFF000000FFFF0000FFFF0000FFFF0000FF
      FF000000FF00000000000000FF00000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF000000FFFF0000FFFF0000FFFF0000FF
      FF0000000000000000000000000000000000000000000000000000FFFF000000
      00000000000000FFFF000000000000000000000000000000000000FFFF000000
      00000000000000FFFF0000000000000000000000000000000000000000000000
      0000848484000000000000000000000000008484840084848400848484008484
      84008484840084848400000000000000000000000000000000000000FF000000
      FF00000000000000000000000000000000000000000000FFFF0000FFFF0000FF
      FF0000FFFF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF0000FFFF0000FF
      FF0000FFFF00000000000000000000000000000000000000000000FFFF000000
      00000000000000FFFF0000FFFF0000000000000000000000000000FFFF000000
      00000000000000FFFF00000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C6008484840084848400848484008484840000000000FFFFFF000000
      0000848484008484840000000000000000000000000000000000000000000000
      FF000000FF00000000000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF000000FF0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000FFFF0000FFFF00000000000000000000FFFF000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00C6C6C60000000000C6C6C600C6C6C60084848400FFFFFF00FFFF
      FF00C6C6C6000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000FF
      FF000000FF000000000000000000000000000000000000000000000000000000
      00000000000084848400000000008484840000000000848484000000000000FF
      FF000000000000000000000000000000000000FFFF0000000000000000000000
      000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000000000FFFF0000FF
      FF0000000000000000000000000000FFFF000000000000000000000000000000
      0000FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF0084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000848484000000FF000000FF000000FF000000FF000000FF008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000008484840000000000848484000000000084848400000000008484
      84000000000000000000000000000000000000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF000000FF00
      000000000000000000000000FF000000FF000000FF000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF000000FF00
      0000FF0000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF000000FF00
      0000FF0000000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF000000FF000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000FF000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000FF000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      00000000FF000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF000000FF000000FF000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000FF000000FF00000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000FF000000FF00000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000FF000000FF000000FF000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000FF000000FF000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000FF000000FF0000000000FF00FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      000000000000000000000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF000000FF00
      0000FF000000FF000000FF000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF000000FF000000FF0000000000
      0000FF000000FF000000FF000000848484008484840000000000000000000000
      000000000000000000000000000000000000FF000000FF000000FF0000000000
      0000FF000000FF000000FF0000000000FF008484840000000000000000000000
      000000000000000000000000FF000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000840000008400000000000000
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF00000000000000FF000000FF000000FF0000000000
      000000000000FF000000FF000000FF000000FFFF0000FFFF0000FFFF0000FFFF
      000000000000000000000000000000000000FF000000FF000000FF0000000000
      000000000000FF000000FF000000FF0000000000FF00FFFF0000FFFF0000FFFF
      000000000000000000000000FF000000FF000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00000084000000
      000000000000000000000000000000000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF00000000000000FF000000FF000000000000000000
      00000000000000000000FF000000FF000000FF00000084848400848484000000
      000000000000000000000000000000000000FF000000FF0000000000FF000000
      00000000000000000000FF000000FF000000FF0000000000FF00848484000000
      000000000000000000000000FF000000FF000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF000000FF000000
      840000000000000000000000000000000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF00000000000000FF000000FF000000000000000000
      000000000000FFFF0000FF000000FF000000FF000000FF000000FFFF0000FFFF
      000000000000000000000000000000000000FF000000FF0000000000FF000000
      000000000000FFFF0000FF000000FF000000FF000000FF0000000000FF00FFFF
      000000000000000000000000FF000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      00000084840000000000000000000000000000000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000000000000000000000000000000000000000
      0000000000000000000084848400FF000000FF000000FF000000FF0000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      0000000000000000000084848400FF000000FF000000FF000000FF0000000000
      FF0000000000000000000000FF000000FF000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000000000FF
      FF00000000000084840000000000000000000000000000000000FF000000FF00
      0000FF000000FF000000FF000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FF000000FF000000FF000000FF00
      00000000000000000000000000000000000000000000000000000000FF000000
      000000000000FFFF0000FFFF0000FFFF0000FF000000FF000000FF000000FF00
      00000000FF00000000000000FF00000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF000000
      000000FFFF00000000000084840000000000000000000000000000000000FF00
      0000FF000000FF000000FF000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000FF00000000000000000000000000000000000000000000000000FF000000
      FF000000000000000000000000000000000000000000FF000000FF000000FF00
      0000FF0000000000FF000000FF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF000000000000FFFF0000848400008484000000000000000000000000000000
      0000FF000000FF000000FF000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF000000FF00
      0000FF0000000000000000000000000000000000000000000000000000000000
      FF000000FF000000000000000000000000000000000000000000FF000000FF00
      0000FF0000000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF0000FFFF0000FFFF00008484000000000000000000000000000000
      000000000000FF000000FF000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000848484000000000084848400000000008484840000000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF00FF00
      00000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000FFFF0000FFFF000000000000000000000000000000
      00000000000000000000FF000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840000000000848484000000000084848400000000008484
      8400000000000000000000000000000000000000000000000000000000000000
      000000000000848484000000FF000000FF000000FF000000FF000000FF008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF0000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084000000FF000000FF000000FF0000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      0000000000000000000000000000FFFF000000000000FFFF000000000000FFFF
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000FF0000000000
      0000000000000000000000000000000000008484840000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FF0000008400000084000000FF000000FF0000008400000084000000FF00
      000084000000000000000000000000000000000000000000000000000000FFFF
      0000000000000000000000000000FFFF000000000000FFFF0000C6C6C600FFFF
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF0000000000000000000000FF000000FF000000
      84000000FF00000000000000000000000000000000000000000000000000FF00
      0000FF00000084000000FF000000000000000000000000000000FF000000FF00
      000084000000840000000000000000000000000000000000000000000000FFFF
      000000000000FFFF000000000000FFFF000000000000FFFF0000C6C6C600FFFF
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000FF00000000000000000000000000000000000000000000000000FF000000
      84000000FF000000FF000000FF0000000000000000000000FF000000FF000000
      FF00000084000000FF000000000000000000000000000000000000000000FF00
      0000FF000000FF0000000000000000000000000000000000000000000000FF00
      0000FF000000840000000000000000000000000000000000000000000000FFFF
      000000000000FFFF000000000000FFFF000000000000FFFF000000000000FFFF
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000FF000000FF00000000000000000000000000000000000000000084000000
      FF000000FF000000FF000000FF0000000000000000000000FF000000FF000000
      FF000000FF00000084000000000000000000000000000000000084000000FF00
      0000FF000000FF0000000000000000000000FF0000000000000000000000FF00
      0000FF000000FF000000FF00000000000000000000000000000000000000FFFF
      000000000000FFFF000000000000FFFF000000000000FFFF000000000000FFFF
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF0000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF0000000000000000000000FF000000
      FF000000FF000000FF000000000000000000000000000000000084000000FF00
      0000FF000000FF0000000000000000000000000000000000000000000000FF00
      0000FF00000084000000FF00000000000000000000000000000000000000FFFF
      000000000000FFFF000000000000FFFF000000000000FFFF000000000000FFFF
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF00000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF0000000000000000000000FF000000
      FF000000FF000000FF000000000000000000000000000000000084000000FF00
      0000FF000000FF000000FF000000000000000000000000000000FF000000FF00
      0000FF00000084000000FF00000000000000000000000000000000000000FFFF
      000000000000FFFF000000000000FFFF000000000000FFFF000000000000FFFF
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF0000000000000000000000000084000000
      FF000000FF000000FF000000FF000000FF000000FF00000000000000FF000000
      FF000000FF000000840000000000000000000000000000000000FF000000FF00
      0000FF000000FF0000000000000000000000FF0000000000000000000000FF00
      0000FF000000FF000000FF00000000000000000000000000000000000000FFFF
      000000000000FFFF000000000000FFFF000000000000FFFF000000000000FFFF
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF0000000000000000000000000000000000FF000000
      84000000FF000000FF0000000000000000000000000000000000000000000000
      FF00000084000000FF0000000000000000000000000000000000FF000000FF00
      0000FF000000FF0000000000000000000000000000000000000000000000FF00
      0000FF000000840000008400000000000000000000000000000000000000FFFF
      000000000000FFFF000000000000FFFF000000000000FFFF000000000000FFFF
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000FF000000FF00000000000000000000000000000000000000000000000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      FF000000FF00000000000000000000000000000000000000000000000000FF00
      0000FF000000FF000000FF000000000000000000000000000000FF000000FF00
      0000FF000000FF0000000000000000000000000000000000000000000000FFFF
      000000000000FFFF000000000000FFFF000000000000FFFF000000000000FFFF
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000FF0000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000008400
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF0000000000000000000000000000000000000000000000FFFF
      000000000000000000000000000000000000000000000000000000000000FFFF
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084000000FF000000FF00000084000000FF000000FF000000FF0000008400
      0000FF000000000000000000000000000000000000000000000000000000FFFF
      00000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00FFFF
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF000000FF00000084000000840000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      000000000000000000000000000000000000000000000000000000000000FFFF
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840084848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000848484000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF000000FF000000
      0000000000000000000000000000000000000084840000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000000000848484000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF000000FF000000
      000000000000000000000000000000000000000000000084840000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF00000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000084840000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000000000848484000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF0000000000000000000000000000000000000000000084840000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF00000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000000000000000000000000000FF000000
      84000000FF000000000000000000000000000084840000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF00000000000000000000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000000000000000000000000000FF000000
      84000000FF00000000000000000000000000000000000084840000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000000000000000000000000000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF000000000000000000000000000000FF000000
      84000000FF000000FF0000000000000000000000000000000000000000000000
      FF00000084000000FF000000000000000000000000000084840000FFFF0000FF
      FF0000000000000000000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF0000000000848484000000000000000000000000000000FF000000
      84000000FF000000FF0000000000000000000000000000000000000000000000
      FF00000084000000FF00000000000000000000000000000000000084840000FF
      FF0000FFFF0000FFFF00000000000000000000000000000000000000000000FF
      FF0000FFFF0000FFFF0000000000848484000000000000000000000084000000
      FF000000FF000000FF0000000000000000000000FF0000000000000000000000
      FF000000FF00000084000000000000000000000000000084840000FFFF0000FF
      FF0000000000000000000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000000000000084000000
      FF000000FF000000FF000000FF000000FF000000FF0000000000000000000000
      FF000000FF0000008400000000000000000000000000000000000084840000FF
      FF0000FFFF0000FFFF00000000000000000000FFFF00000000000000000000FF
      FF0000FFFF0000FFFF00000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF0000000000000000000000
      FF000000FF000000FF00000000000000000000000000000000000084840000FF
      FF00000000000000000000FFFF00000000000000000000FFFF0000FFFF0000FF
      FF000000000084848400000000000000000000000000000000000000FF000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      FF000000FF000000FF0000000000000000000000000000000000000000000084
      840000FFFF0000FFFF00000000000000000000000000000000000000000000FF
      FF0000FFFF0000000000848484000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF0000000000000000000000FF000000
      FF000000FF000000FF00000000000000000000000000000000000084840000FF
      FF0000FFFF000000000000000000000000000000000000FFFF0000FFFF0000FF
      FF000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF00000000000000000000000000000000000000FF000000
      FF000000FF000000FF0000000000000000000000000000000000000000000084
      840000FFFF0000FFFF000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000000000000084000000
      FF000000FF000000FF000000FF000000FF000000FF0000000000000000000000
      FF000000FF000000840000000000000000000000000000000000000000000084
      840000FFFF0000FFFF0000000000000000000000000000FFFF0000FFFF000000
      0000848484000000000000000000000000000000000000000000000084000000
      FF000000FF000000FF0000000000000000000000FF000000FF000000FF000000
      FF000000FF000000840000000000000000000000000000000000000000000000
      00000084840000FFFF00000000000000000000FFFF0000FFFF0000FFFF0000FF
      FF000000000084848400000000000000000000000000000000000000FF000000
      84000000FF000000FF0000000000000000000000000000000000000000000000
      FF00000084000000FF0000000000000000000000000000000000000000000084
      840000FFFF0000FFFF0000000000000000000000000000FFFF0000FFFF000000
      00000000000000000000000000000000000000000000000000000000FF000000
      84000000FF000000FF000000FF00000000000000000000000000000000000000
      FF00000084000000FF0000000000000000000000000000000000000000000000
      00000084840000FFFF00000000000000000000000000000000000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000000000000000000000000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      00000084840000FFFF0000FFFF00000000000000000000FFFF00000000008484
      8400000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000084840000FFFF0000000000000000000000000000FFFF000000
      0000848484000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      00000084840000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000084840000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000084840000FFFF0000FFFF0000FFFF0000000000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000084840000FFFF0000FFFF0000FFFF00000000008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000084840000FFFF0000FFFF0000FFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000084840000FFFF0000FFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000848400008484000084840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000008484000084840000848400000000000000
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
      00000000000000000000000000000000000000000000000000000000FF000000
      0000000000000000000000000000000000000000000000848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF00000000000000000000000000000000000084840000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000000000848484000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000000000000000000000000084840000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000000000848484000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000FFFFFF000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0000000000000000000084840000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF00000000000000000000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000000000000000000000000000000000000000000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      84000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF0000000000000000000084840000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF00000000000000000000FFFF0000FFFF0000FF
      FF0000FFFF0000000000848484000000000000000000000000000000FF000000
      84000000FF000000FF0000000000000000000000000000000000000000000000
      FF00000084000000FF0000000000000000000000000000000000000000000000
      FF00000000000000000000000000FFFFFF0000000000C6C6C600000000000000
      0000FFFFFF0000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000FFFFFF00000000000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000000000000000000000000084840000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF00000000000000000000FFFF0000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000000000000084000000
      FF000000FF000000FF000000FF0000000000000000000000FF000000FF000000
      FF000000FF000000840000000000000000000000000000000000000000000000
      FF000000FF000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF0000000000000000000000000000000000000000000084840000FF
      FF0000FFFF0000FFFF0000FFFF00000000000000000000FFFF0000FFFF0000FF
      FF000000000084848400000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF0000000000000000000000FF000000
      FF000000FF000000FF000000000000000000000000000000FF000000FF000000
      FF000000FF000000FF0000000000FFFFFF000000000000000000FFFFFF000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000FF000000
      FF000000000000000000000000000000000000000000000000000084840000FF
      FF0000FFFF000000000000FFFF00000000000000000000FFFF0000FFFF0000FF
      FF000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF0000000000000000000000
      FF000000FF000000FF000000000000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF0000000000FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000FF000000
      0000000000000000000000000000000000000000000000000000000000000084
      840000FFFF000000000000000000000000000000000000FFFF0000FFFF000000
      0000848484000000000000000000000000000000000000000000000084000000
      FF000000FF000000FF0000000000000000000000FF0000000000000000000000
      FF000000FF00000084000000000000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF0000000000C6C6C600FFFFFF000000
      0000FFFFFF0000000000000000000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000084
      840000FFFF0000FFFF0000000000000000000000000000FFFF0000FFFF000000
      00000000000000000000000000000000000000000000000000000000FF000000
      84000000FF000000FF0000000000000000000000000000000000000000000000
      FF00000084000000FF000000000000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF0000000000FFFFFF00FFFFFF00FFFFFF000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000084840000FFFF0000FFFF00000000000000000000FFFF00000000008484
      8400000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000000000000000000000000000FF000000
      FF000000FF00000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF0000000000C6C6
      C600FFFFFF0000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000084840000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000084840000FFFF0000FFFF0000FFFF0000000000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000084840000FFFF0000FFFF0000FFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000848400008484000084840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF000000FF00000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840000000000000000000000000000000000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF000000FF000000FF000000FF000000FF000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084848400FFFFFF00000084000000840000008400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000000000000000000000000000000000000000000084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000000000000000
      0000FFFFFF00C6C6C60084848400848484000000000000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF000000FF000000FF000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF00000000000000000000000000000000000000FFFFFF00848484008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF008484840084848400FFFFFF00000000000000000000000000000000008484
      8400C6C6C60084848400C6C6C600C6C6C600FFFFFF0000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF008484840084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF00848484008484
      8400FFFFFF00FFFFFF00FFFFFF0000000000000000000000000000000000FFFF
      FF0084848400C6C6C60000000000C6C6C60084848400000000000000FF000000
      8400000084000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF000000FF000000FF000000000000000000
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF0000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000000000000000FFFF
      FF0084848400C6C6C600C6C6C600C6C6C60084848400000000000000FF000000
      FF00000084000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF000000FF000000FF000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF008484840000000000FFFF0000FFFF0000FFFF0000FFFF0000000000008484
      8400FFFFFF00FFFFFF00FFFFFF0000000000000000000000000000000000FFFF
      FF008484840084848400C6C6C600C6C6C60084848400000000000000FF000000
      FF00000084000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF000000FF000000FF000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00848484000000
      000084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008484
      84000000000084848400FFFFFF00000000000000000000000000000000008484
      8400C6C6C60084848400C6C6C60084848400FFFFFF000000FF000000FF000000
      84000000000000000000000000000000000000000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000000000000000000000000000000000000000
      00000000000000000000FF000000FF000000FF000000FF000000000000000000
      000000000000000000000000000000000000000000000000000084848400FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF00008484840000000000000000000000000000000000000000000000
      000084848400FFFFFF00C6C6C600FFFFFF00000000000000FF000000FF000000
      8400000000000000000000000000000000000000000000000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF00000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840084848400000000000000000000000000000000000000
      84000000840000000000000000000000FF000000FF000000FF00000000000000
      000000008400000000000000000000000000000000000000000000000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF0000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF000000FF000000FF000000000000000000
      000000000000000000000000000000000000000000000000000084848400FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000848484000000000000000000000000000000000000000000FFFF
      FF000000FF000000000000000000000000000000000000000000000000000000
      8400000084000000000000000000000000000000000000000000000000000000
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000848484000000
      000084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008484
      8400000000008484840000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      000000000000FF000000FF000000FF000000FF000000FF000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848484000000000084848400FFFF0000FFFF000084848400000000008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400000000000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF000000FF00000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000000000008484
      84008484840084848400000000000000000000000000000000000000FF000000
      0000FFFF0000FF000000FF000000000000000000000000000000000000000000
      000084848400848484000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000008400000084000000000000000000000000000000
      00000000000084848400000000000000000000000000C6C6C6000000FF000000
      0000FFFF0000FF000000FF000000000000000000000000000000000000000000
      000084848400848484000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      FF000000FF000000FF0000008400000084000000840000008400000000000000
      00000000000084848400000000000000000000000000C6C6C6000000FF000000
      0000FFFF0000FF000000FF000000000000000000000000000000000000000000
      000084848400848484000000FF00000000008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      FF000000FF000000FF000000FF000000FF000000FF0000008400000000000000
      00000000000000000000000000000000000000000000C6C6C6000000FF000000
      0000FFFF0000FF000000FF000000000000000000000000000000000000000000
      000084848400848484000000FF000000000000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0084848400000000000000000000000000000000000000
      84000000FF000000FF000000FF000000FF000000840000008400000000000000
      84000000000000000000000000000000000000000000000000000000FF00FFFF
      FF000000FF000000FF000000FF000000FF000000FF0000000000000000000000
      00000000000000000000000000000000000000000000C6C6C6000000FF000000
      0000FFFF0000FF000000FF000000000000000000000000000000000000000000
      000084848400848484000000FF000000000000FFFF0000FFFF0000FFFF000000
      000000000000000000000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF0000FFFF0084848400000000000000000000000000000000000000
      00000000FF00FFFFFF000000FF000000FF000000FF0000008400000084000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF00FFFFFF000000FF000000FF000000FF000000000000000000000084000000
      00000000000000000000000000000000000000000000C6C6C6000000FF000000
      0000FFFF0000FF000000FF000000000000000000000000000000000000000000
      000084848400848484000000FF000000000000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0084848400000000000000000000000000000000000000
      000000008400FFFFFF000000FF000000FF000000FF0000008400000084000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF000000840000008400000084000000
      00000000000000000000000000000000000000000000C6C6C6000000FF000000
      0000FFFF0000FF000000FF000000000000000000000000000000000000000000
      000084848400848484000000FF000000000000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0084848400000000000000000000000000000000000000
      0000000084000000FF000000FF000000FF000000FF0000008400000084000000
      0000000000000000000000000000000000000000000000000000000084000000
      8400000000000000FF00000084000000840000008400000000000000FF000000
      FF000000840000000000000000000000000000000000C6C6C6000000FF000000
      0000FFFF0000FF000000FF000000000000000000000000000000000000000000
      000084848400848484000000FF000000000000FFFF0000FFFF0000FFFF000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF0000FFFF0000FFFF0084848400000000000000000000000000000000000000
      0000000084000000FF000000FF000000FF000000FF0000008400000084000000
      0000000000000000000000000000000000000000000000000000000000000000
      8400000084000000840000000000000000000000840000008400008400000000
      00000000000084008400000000000000000000000000C6C6C6000000FF000000
      0000FFFF0000FF000000FF000000000000000000000000000000000000000000
      000084848400848484000000FF000000000000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0084848400000000000000000000000000000000000000
      000000008400FFFFFF000000FF000000FF000000FF0000008400000084000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000840000008400000084
      00000000000000000000000000000000000000000000C6C6C6000000FF000000
      0000FFFF0000FF000000FF000000000000000000000000000000000000000000
      00008484840084848400000000000000000000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF008400
      84008400840000FFFF0084848400000000000000000000000000000000000000
      000000008400FFFFFF000000FF000000FF000000840000008400000084000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF0000000000FFFFFF0000FF00000084
      00000000000000000000000000000000000000000000C6C6C6000000FF000000
      0000FFFF00000000000000000000000000000000000000000000000000000000
      00008484840084848400000000000000000000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF008400
      84008400840000FFFF0084848400000000000000000000000000000000000000
      0000000000000000FF00FFFFFF00000084000000840000008400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF0000000000FFFF00000000000000000000000000000000
      0000FFFFFF0000000000000000000000000000000000000000000000FF000000
      0000FFFF00000000000000000000000000000000000000000000000000000000
      00008484840084848400000000000000000000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0084848400000000000000000000000000000000000000
      000000000000000000000000FF00000084000000840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000008484000084840000000000FF000000FF000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      0000FFFF00000000000000000000000000000000000000000000000000000000
      0000848484008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000FFFF0000000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF000000000000000000000000000000
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
      0000000000000000000000000000000000000000000084000000000000000000
      0000000000000000000000000000000000000000000084000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF00FF00FF00FF00FF00FF0000000000000000000000
      0000000000000000000000000000FF00FF000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000FFFF0000FFFF000000000000000000000000000000
      0000000000000000000000000000000000008484840084840000848400008484
      0000848400008484000084840000840000008484840084840000848484008484
      0000848400008484000084840000000000000000000000000000000000000000
      00000000000000000000FF00FF00FF00FF00FF00FF0000000000000000000000
      0000000000000000000000000000FF00FF000000000084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000FFFF0000FFFF000084840000000000000000000000
      0000000000000000000000000000000000008484840084848400C6C6C600C6C6
      C600C6C6C60084848400848400008484000084848400C6C6C600C6C6C600C6C6
      C600C6C6C6008484840084840000840000000000000000000000000000000000
      00000000000000000000FF00FF00FF000000FF00FF0000000000000000000000
      0000000000000000000000000000FF00FF000000000084848400FFFFFF00FFFF
      FF0000000000000000000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400848484008484
      8400848484008484000084000000000000000000000084848400848484008484
      840084848400848400008400000000000000FF00FF0000000000000000000000
      000000000000FF00FF00FF00FF00FF000000FF00FF00FF00FF00000000000000
      00000000000000000000FF00FF00FF00FF000000000084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000FFFF0000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400C6C6C60000FF
      FF0000FFFF008484840084000000000000000000000084848400C6C6C60000FF
      FF0000FFFF00848484008400000000000000FF00FF0000000000FFFFFF00FFFF
      FF0000000000FF00FF00FF00FF00FF000000FF00FF00FF00FF0000000000FFFF
      FF00FFFFFF0000000000FF00FF00FF00FF000000000084848400FFFFFF00FFFF
      FF0000000000000000000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000FFFF0000FFFF000084840000000000000000000000
      0000000000000000000000000000000000000000000084848400C6C6C60000FF
      FF0000FFFF008484840084000000000000000000000084848400C6C6C60000FF
      FF0000FFFF00848484008400000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000848484008484
      840084848400848484000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000FFFF0000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400C6C6C600C6C6
      C600C6C6C6008484000084000000000000000000000084848400C6C6C600C6C6
      C600C6C6C6008484000084000000000000008484840084848400848484008484
      84008484840084848400FF00FF00FF000000FF00FF0084848400848484008484
      8400848484008484840084848400FF00FF000000000000000000000000000000
      0000000000000000000000000000848484008484840084848400FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF0000FFFF0000FFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000848484008484
      8400848484008484000000000000000000000000000000000000848484008484
      00008484840084848400000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FF000000FF000000FF00000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FF00FF000000000084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FFFF0000FFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008400000084000000840000008484840084000000840000008400
      000000000000000000000000000000000000FF00FF0000000000FFFFFF00FFFF
      FF0000000000FF00FF00FF00FF00FF000000FF00FF00FF00FF0000000000FFFF
      FF00FFFFFF0000000000FF00FF00FF00FF000000000084848400FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000008484
      8400848484000000000000000000000000000000000000FFFF0000FFFF0000FF
      FF0000000000000000000000000000FFFF0000FFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848484008484000084848400848484008484840084848400848400008400
      000000000000000000000000000000000000FF00FF0000000000000000000000
      000000000000FF00FF00FF00FF00FF000000FF00FF00FF00FF00000000000000
      00000000000000000000FF00FF00FF00FF000000000084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000FFFF0000FFFF0000FF
      FF0000000000000000000000000000FFFF0000FFFF0000FFFF00000000000084
      8400000000000000000000000000000000000000000000000000000000000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600848400008484
      000000000000000000000000000000000000FF00FF00FF00FF00000000000000
      0000FF00FF00FF00FF00FF00FF00FF000000FF00FF00FF00FF00FF00FF000000
      000000000000FF00FF00FF00FF00FF00FF000000000084848400FFFFFF00FFFF
      FF0000000000000000000000000000000000000000000000000000000000FFFF
      FF0000000000000000000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000008484840084848400848484008484840084848400848400000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF0000000000000000000000000000000000000000000000000000000000FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF000000000084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000000000000000000000000000000000000FFFF
      FF0000000000000000000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C600C6C6C600C6C6C600C6C6C60084848400848484000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF000000000000000000000000000000000000000000FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF000000000084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000000000000000000000000000000000000000000000000000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C600C6DEC600F7FFFF00FFFFFF00C6C6C600848484000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF000000000000000000000000000000000000000000FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF000000000084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C600C6DEC600F7FFFF00FFFFFF00C6C6C600848484000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FFFFFF0000000000FFFFFF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400848484008484840084848400000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FFFFFF00FFFFFF00FFFFFF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
      0000000000000000000084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084840000848400000000
      0000848484008484000084840000C6DEC6000000000084840000000000008484
      0000848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000848484008400840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600848400000000
      000084840000C6C6C60084840000848400008484840084840000C6C6C600C6C6
      C600F7FFFF0084840000C6C6C600000000000000000000000000000000000000
      0000000000008484840000000000FFFFFF000000000084008400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084840000000000008484
      8400000000000000000084848400848400008484000084840000848400008484
      0000848400008484000084840000000000000000000000000000000000008484
      840000000000FFFFFF00FFFFFF00848484000000000000000000840084000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484000084840000848400008484
      0000848400008484000084840000848400008484000084840000C6C6C600C6C6
      C600C6DEC600848400008484000000000000000000008484840000000000FFFF
      FF00FFFFFF008484840084848400000000008484840000000000000000008400
      8400000000000000000000000000000000000000000000000000000000000084
      8400008484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C60084840000848400008484
      0000848400008484000084840000848400000000000000000000000000000000
      0000000000000000000000000000000000008400840084848400FFFFFF008484
      8400848484000000000000000000840084000000000084848400000000000000
      0000840084000000000000000000000000000000000000000000008484000084
      8400008484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084840000848400008484
      0000848400008484000000000000000000008484000084840000848400008484
      0000848400008484000000000000000000008400840084848400848484000000
      0000000000008400840084008400840084008400840000000000848484000000
      0000000000008400840000000000000000000000000000000000008484000084
      8400008484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084840000848400008484
      0000848484000000000084840000848400008484000084840000848400008484
      0000848400008484000084840000000000008400840000000000000000008400
      8400840084008400840084008400840084008400840084008400000000008484
      8400000000000000000084008400000000000000000000000000008484000084
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084840000848400008484
      00000000000084840000C6DEC600000000008484000084840000848400000000
      0000000000008484000084840000000000008400840084848400840084008400
      8400840084008400840000FFFF00008484008400840084008400840084000000
      0000848484000000000000000000000000000000000000000000008484000084
      8400008484000000000000000000000000000000000000000000000000000000
      0000840000008400000000000000000000000000000000000000000000000000
      0000000000000000000084000000840000008400000084000000840000008400
      000084000000000000000000000000000000000000008484000084840000C6C6
      C600848400008484000084840000000000000000000084840000000000000000
      00008484000084840000C6C6C600C6C6C6000000000084008400848484008400
      84008400840084008400840084000000000000FFFF0000FFFF00840084008400
      8400000000008484840000000000000000000000000000000000008484000084
      8400008484000000000000000000000000000000000000000000000000008400
      0000840000008400000084000000840000000000000000000000000000000000
      0000000000000000000084000000840000008400000084000000840000008400
      0000840000000000000000000000000000000000000084840000848400008484
      0000848400008484000084840000848400000000000000000000000000008484
      0000848400008484000084840000848400000000000000000000840084008484
      8400840084008400840000848400008484008400840000FFFF0000FFFF008400
      8400840084000000000000000000000000000000000000000000008484000084
      8400008484000000000000000000000000000000000000000000840000008400
      0000840000008400000084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084840000848400008484
      0000848400008484000084840000848400008484000000000000000000008484
      0000848400008484000084840000848400000000000000000000000000008400
      840084848400840084008400840000FFFF0000FFFF0000FFFF00008484008400
      8400840084008400840000000000000000000000000000000000008484000084
      8400008484000000000000000000000000000000000000000000000000008400
      0000840000008400000084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084840000848400008484
      0000848400008484000084840000848400000000000000000000000000008484
      0000848400008484000084840000848400000000000000000000000000000000
      0000840084008484840084008400840084008400840084008400840084008400
      8400840084000000000000000000000000000000000000000000008484000084
      8400000000000000000000000000000000000000000000000000000000000000
      0000840000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084840000848400008484
      0000848400008484000084840000000000000000000084840000848400008484
      0000848400008484000084840000848400000000000000000000000000000000
      0000000000008400840084848400840084008400840084008400840084000000
      0000000000000000000000000000000000000000000000000000008484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484008484
      0000848400008484000084840000848400008484000084840000848400008484
      0000848400008484000084840000848400000000000000000000000000000000
      0000000000000000000084008400848484008400840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008400000084000000840000008400000084000000840000000000
      0000000000000000000000000000000000000000000000000000848400008484
      0000848400008484000084848400C6DEC6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000840084000000000000000000000000000000
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
      0000000084000000000000000000000000008484000000000000FFFF00000084
      8400FFFF0000FFFF000000848400FFFF0000FFFF000000848400FFFF00000000
      0000000000000000000084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000848400848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF0000FFFF000000840000000000000000008484000000000000FFFF00000084
      8400FFFF0000FFFF000000848400FFFF0000FFFF000000848400FFFF00000000
      0000000000000000000084848400000000008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840084848400000000000000000084848400FFFFFF00C6C6
      C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C60000000000000000000000000000FFFF00008484008484
      84000000000000000000000000000000000000000000000000000000FF0000FF
      FF000000FF000000FF0000000000000000008484000000000000008484000084
      8400008484000084840000848400008484000084840000848400008484000000
      000084848400848484008484840000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000084848400FFFFFF00C6C6
      C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C6000000000000000000000000000000000000FFFF000084
      840084848400000000000000000000000000000000000000FF0000FFFF000000
      FF000000FF000000000000000000000000008484000000000000FFFF00000084
      8400FFFF0000FFFF000000848400FFFF0000FFFF000000848400FFFF00000000
      000000000000000000008484840000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600FFFFFF00848484008484840084848400848484008484
      84008484840084848400FFFFFF00000000000000000084848400FFFFFF00C6C6
      C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6
      C600FFFFFF00C6C6C600000000000000000000000000000000000000000000FF
      FF00008484008484840000000000000000000000840000FFFF000000FF000000
      FF00000000000000000000000000000000008484000000000000FFFF00000084
      8400FFFF0000FFFF000000848400FFFF0000FFFF000000848400FFFF00000000
      000000000000848400008484000000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600FFFFFF00848484008484840084848400848484008484
      84008484840084848400FFFFFF00000000000000000084848400FFFFFF00C6C6
      C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6
      C600FFFFFF00C6C6C60000000000000000000000000000000000000000000000
      000000FFFF000084840000000000000084000000FF0000FFFF000000FF000000
      0000000000000000000000000000000000008484000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000848400008484000000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600FFFFFF00848484008484840084848400848484008484
      84008484840084848400FFFFFF00000000000000000084848400FFFFFF00C6C6
      C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6
      C600FFFFFF00C6C6C60000000000000000000000000000000000000000000000
      00000000000000FFFF000084840000FFFF000000840000FFFF00000000000000
      0000000000000000000000000000000000008484000084848400FFFFFF008484
      840084848400FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000848400008484000000000000C6C6C60000000000848400000000
      000000000000C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000084848400FFFFFF00C6C6
      C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6
      C600FFFFFF00C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000084848400FFFFFF0000FFFF0000000000000000000000
      0000000000000000000000000000000000008484000084848400FFFFFF008484
      840084848400FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000848400008484000000000000C6C6C60084848400FFFFFF000000
      000084848400C6C6C600FFFFFF00840000008400000084000000840000008400
      00008400000084000000FFFFFF00000000000000000084848400FFFFFF00C6C6
      C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF0000008400FFFFFF000000
      8400FFFFFF00C6C6C60000000000000000000000000000000000000000000000
      00000000000084848400FFFFFF0000FFFF000084840084848400000000000000
      00000000000084848400000000000000000084840000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000848400008484000000000000C6C6C600C6C6C600FFFFFF00FFFF
      FF0000000000C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000084848400FFFFFF00C6C6
      C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF0000008400FFFFFF000000
      8400FFFFFF00C6C6C60000000000000000000000000000000000000000000000
      000084848400FFFFFF00000000000000000000FFFF0000848400848484000000
      000084848400C6C6C60000000000000000008484000084848400FFFFFF008484
      840084848400FFFFFF0000000000848400008484000084840000848400008484
      000084840000848400008484000000000000C6C6C600C6C6C60000000000FFFF
      FF0000000000C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000084848400C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6
      C600FFFFFF00C6C6C60000000000000000000000000000000000000000008484
      8400FFFFFF000000000000000000000000000000000000FFFF00848484008484
      8400848484000000000000000000000000008484000084848400FFFFFF008484
      840084848400FFFFFF000000000084840000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000C6C6C60000000000C6C6C600C6C6
      C60000000000C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000084848400C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6
      C600FFFFFF00C6C6C60000000000000000000000000000000000C6C6C600FFFF
      FF00000000000000000000000000000000000000000000000000848484008484
      8400848484000000000000000000000000008484000084848400FFFFFF008484
      840084848400FFFFFF0000000000848400008484000084840000FFFFFF00FFFF
      FF0084840000848400008484000000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000084848400840000008400
      0000840000008400000084000000840000008484840084848400848484008484
      8400848484008484840000000000000000000000000084848400C6C6C600FFFF
      FF00000000000000000000000000000000000000000084848400C6C6C600C6C6
      C600000000000000000000000000000000008484000084848400FFFFFF008484
      840084848400FFFFFF0000000000848400008484000084840000848400008484
      0000848400008484000084840000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      84008484840084848400000000000000000000000000FFFFFF00000000000000
      00000000000000000000000000000000000000000000C6C6C600000000000000
      00000000000000000000000000000000000084840000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000848400008484000084840000848400008484
      000084840000FFFFFF00FFFFFF00000000000000000000000000000000000000
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
      0000C6C6C600FFFFFF0084848400000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C600C6C6C600FFFFFF00FFFFFF00848484000000000000000000848400000000
      0000848400008484000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      000000000000C6C6C600FFFFFF00848484000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400000000000000
      0000FFFFFF0000000000FFFFFF00FFFFFF008484840084848400848400008484
      0000848400008484000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF008484840084848400848484008484840084848400848484008484
      8400FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000C6C6C600FFFFFF008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00848400008484
      0000848400008484000000000000000000000000000000000000000000000000
      84000000FF000000FF000000FF000000FF000000840000008400000000000000
      8400000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600FFFFFF008484840084848400848484008484840084848400848484008484
      8400FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C6C6C600FFFFFF0084848400848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848400008484000000000000000000000000000000000000000000000000
      00000000FF00FFFFFF000000FF000000FF000000840000008400000084000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C60084848400848484008484
      8400848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000008400FFFFFF000000FF000000FF000000FF0000008400000084000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF008484840084848400848484008484
      840000000000000000000000000000000000000000000000000084848400C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000FF000000FF000000FF000000FF0000008400000084000000
      0000000000000000000000000000000000000000000084848400C6C6C600C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C60000000000000000000000
      000000000000000000000000000000000000000000000000000084848400C6C6
      C600000000000000000000000000008484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000FF000000FF00000084000000FF0000008400000084000000
      0000000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000008484840084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF0000FFFF000000
      0000C6C6C600000000000000000000000000000000000000000084848400C6C6
      C600000000000000000084848400008484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000008400FFFFFF000000FF000000FF000000840000008400000084000000
      0000000000000000000000000000000000000000000000000000C6C6C6008484
      84008484840084848400848484008484840084848400C6C6C600000000000000
      0000848484008484840084848400000000000000000000000000000000000000
      000000000000000000000000000000FFFF0000FFFF0000FFFF00000000000000
      000000FFFF00000000000000000000000000000000000000000084848400C6C6
      C600000000008484840000848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000008400FFFFFF000000FF000000FF000000840000008400000084000000
      0000000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      00000000000084848400848484000000000000000000000000000000000000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000000000
      000000FFFF000000000000000000000000000000000084848400C6C6C60000FF
      FF0000FFFF000084840084008400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF00FFFFFF000000FF000000840000008400000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C60000000000000000008484840000000000000000000000000000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000000000
      000000FFFF000000000000000000000000000000000084848400848484008484
      8400000000000084840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C6000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000FFFF000000000000FF
      FF00000000000000000000000000000000000000000000000000000000008484
      8400848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000008400
      8400840084000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C60000000000000000000000000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000C6C6C6000000
      0000000000008484840084848400848484008484840084848400000000000000
      000000000000C6C6C60000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000084000000840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C6008484840084848400848484008484840084848400C6C6C600C6C6
      C600C6C6C600C6C6C60000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000008400FFFFFF00FFFFFF00000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      00000000000000000000000000000000000084848400C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C60084848400848484008484840084848400C6C6C600C6C6
      C600C6C6C600C6C6C6008484840000000000FF00FF00FF00FF00FF00FF000000
      000000000000FFFFFF00FFFFFF000084840000848400FFFFFF00000000000000
      0000FF00FF00FF00FF00FF00FF0000FFFF000000000000000000848400008484
      0000000000008484000000000000848400008484000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      0000000000000000000000000000000000008484840084848400FFFFFF008484
      8400C6C6C600C6C6C600C6C6C6000000000000000000C6C6C600C6C6C6008484
      840084848400848484008484840000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF000084840000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00FF00
      FF00FF00FF00FF00FF00FF00FF0000FFFF000000000000000000848400000000
      000084840000FFFFFF0084840000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000008484840084848400C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C6000000000000000000C6C6C600FFFFFF008484
      840084848400848484008484840000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF0000FFFF0000FFFF00008484000084840000FFFF0000FFFF00FF00
      FF00FF00FF00FF00FF00FF00FF0000FFFF000000000000000000000000000000
      0000FFFFFF00C6C6C60000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF000084840000FFFF0000FFFF00848484000084840000FFFF0000FFFF000084
      8400FF00FF00FF00FF00FF00FF0000FFFF000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000840084000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600000000000000000000000000FF00FF00FF00FF00FF00FF000000
      000000FFFF00FFFFFF0000FFFF0000FFFF00C6C6C60000FFFF0000FFFF0000FF
      FF00FF00FF00FF00FF00FF00FF0000FFFF00000000000000000000000000C6C6
      C600FFFFFF00FFFFFF008484840000000000C6C6C60000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF000000
      000000000000000000000000000000000000000000000000000084848400C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C60084848400848484000000000000000000FF00FF00FF00FF00FF00FF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000000000FF00FF00FF00FF0000FFFF000000000000000000C6C6C600C6C6
      C60000000000FFFFFF00FFFFFF00FFFFFF00C6C6C60000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000FFFFFF00FFFFFF00FFFFFF0000000000C6C6C60000000000FFFFFF000000
      000000000000000000000000000000000000000000000000000084848400C6C6
      C600C6C6C600FFFFFF00C6C6C600C6C6C600C6C6C600FFFFFF00FFFFFF00C6C6
      C60084848400848484000000000000000000FF00FF00FF00FF00FF00FF000000
      000000FFFF0000FFFF000084840000FFFF0000FFFF00008484000084840000FF
      FF0000000000FF00FF00FF00FF0000FFFF000000000000000000C6C6C600C6C6
      C600FFFFFF00FFFFFF00FFFFFF00C6C6C600C6C6C600C6C6C600000000000000
      00000000000000000000000000000000000000000000FFFFFF0000000000C6C6
      C60000000000FFFFFF0000000000C6C6C60000000000C6C6C600000000000000
      0000000000000000000084000000840000000000000000000000848484008484
      8400C6C6C600FFFFFF00C6C6C600C6C6C600C6C6C600FFFFFF00FFFFFF00C6C6
      C60084848400848484000000000000000000FF00FF00FF00FF00FF00FF000000
      000000FFFF0000FFFF00FFFFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000000000FF00FF00FF00FF0000FFFF000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00C6C6C600C6C6C600C6C6C600000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF000000
      0000C6C6C60000000000C6C6C60000000000C6C6C60000000000C6C6C600C6C6
      C600C6C6C6000000000084000000840000000000000000000000000000000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF000000
      00000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000
      0000FF00FF00FF00FF00FF00FF0000FFFF00000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000C6C6C600C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C60000000000C6C6C60000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C60084000000840000000000000000000000000000000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF000000
      00000000000000FFFF0000FFFF00000000000000000000000000000000000000
      0000FF00FF00FF00FF00FF00FF0000FFFF000000000000000000000000000000
      00000000000000000000C6C6C60084848400C6C6C600C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C6C6C60000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C60084000000840000000000000000000000000000000000
      000000000000C6C6C60084848400C6C6C600C6C6C600C6C6C600C6C6C6000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF000000000000000000FFFFFF0000000000000000000000000000000000FF00
      FF00FF00FF00FF00FF00FF00FF0000FFFF000000000000000000000000000000
      000000000000FFFFFF00C6C6C600C6C6C6008484840084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C6000000000084000000840000000000000000000000000000000000
      0000000000000000000084848400848484008484840000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF0000000000000000000000000000000000FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF0000FFFF000000000000000000000000000000
      00000000000084848400FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF0000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF0000FFFF000000000000000000000000000000
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
      00000000000000000000000000000000000000008400C6C6C600848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000084840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000848484008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400848484008484840084848400848484000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0084848400848484008484
      8400FFFFFF000000000000000000000000000000000000000000000000000084
      8400000000000084840000000000008484000000000000848400000000000084
      8400000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084848400848484000000000000000000000000000000FF0000000000C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000848400000000000000000000848400008484000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF000000FF000000C6C6C600C6C6C600C6C6C600C6C6C600FFFF
      FF00000000000000000000000000000000000000000000000000000000000084
      8400008484000084840000848400000000000000000000000000000000000000
      000000000000000000000000000000000000848484000000FF000000FF000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600FFFF
      FF00FFFFFF00000000000000000000000000C6C6C60000848400008484000084
      8400008484000084840000848400008484000084840000000000008400000084
      8400008484000000000000000000000000000000000000000000000000000000
      0000FF000000FF000000FF000000C6C6C600C6C6C600C6C6C600FFFFFF00FFFF
      FF000000000000000000000000000000000000000000000000000000000000FF
      000000FFFF000000000000FF000000FF000000FF00000000000000FF000000FF
      000000000000000000008484840000000000000000000000FF000000FF000000
      FF00C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600FFFF
      FF00FFFFFF00000000000000000000000000FFFFFF0000848400008484000084
      840000848400008484000084840000848400008484000084840000FFFF000000
      00000084840000FFFF000000000000000000000000000000000000000000FF00
      0000FF000000FF000000FF000000C6C6C600C6C6C600FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000008400000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000840000000000008484840000000000000000000000FF000000FF000000
      FF00C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600FFFF
      FF00FFFFFF00000000000000000000000000FFFFFF0000848400008484000084
      840000848400008484000084840000FFFF0000FFFF00000000000084840000FF
      FF0000FFFF000000000000000000000000000000000000000000FF000000FF00
      0000FF000000FF000000FF000000C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000848484000000000000000000000000000000FF000000FF000000
      FF00000084000000000000000000000000000000840000000000000000000000
      840000008400000084000000000000000000848484000000FF000000FF000000
      FF00C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600FFFF
      FF00000000000000FF000000FF0000000000FFFFFF00FFFFFF00008484000084
      8400008484000084840000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF000000000000848400FFFFFF000000000000000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000000000000000FF000000840000FF
      FF0000FF000000FF000000FF000000FF00000000000000FF000000FF000000FF
      000000000000000084000000840000000000000000000000FF000000FF000000
      FF00C6C6C600000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
      0000C6C6C600000000000000FF000000000084000000FFFFFF00C6C6C60000FF
      FF0000000000000000000084840000FFFF0000FFFF0000848400000000000084
      84000084840000000000FFFFFF008400000000000000FF000000FF000000FF00
      0000FF000000FF00000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000000000000000000000FF00000000
      0000000000000084840000848400000000000000000000000000000000000000
      000000FF000000FF00000000000000000000000000000000FF000000FF000000
      FF00C6C6C600C6C6C600000000000000000000000000C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000FF000000000084000000FFFFFF00C6C6C60000FF
      FF0000FFFF0000FFFF0000000000000000000000000000848400008484000084
      840000848400FFFFFF00FFFFFF008400000000000000FF000000FF000000C6C6
      C600FF00000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000000000000000000000000000000000008400000084840000FF
      FF0000FFFF000084840000FFFF0000FFFF000084840000848400008484000000
      0000000000000000000000FF000000000000848484000000FF000000FF000000
      FF00C6C6C600C6C6C600000000000000000000000000C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000FF00000000008400000084000000FFFFFF000000
      000000FFFF0000FFFF0000848400008484000084840000FFFF0000FFFF0000FF
      FF0000848400FFFFFF00840000008400000000000000FF000000FF000000FF00
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000000000000000000000FFFF0000FF
      FF00FFFFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000000084
      84000000000000000000000000000000000000000000000000000000FF000000
      FF00000000000000000000000000FFFFFF000000000000000000FFFFFF00FFFF
      FF00000000000000000000000000000000008400000084000000000000000000
      000000000000008484000084840000FFFF000084840000000000000000000000
      0000FFFFFF0084000000840000008400000000000000FF000000FF0000000000
      0000FFFFFF00FFFFFF00FFFFFF00C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C6000000000000000000000000000000000000000000000000000084840000FF
      FF00FFFFFF00FFFFFF0000FFFF000000000000FFFF0000FFFF00FFFFFF000084
      8400008484000000000000000000000000000000000000000000000000000000
      FF0000000000000000000000000000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084000000840000008400000000000000FF000000000000000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000084
      840000FFFF0000FFFF00FFFFFF0000FFFF0000FFFF0000848400008484000084
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000840000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
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
      00000000000000000000000000000000000000000000C6C6C600848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000848400008484000084
      8400008484000084840000848400008484000084840000848400008484000084
      840000848400008484000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000C6C6C60000000000C6C6C6008484
      8400FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484000000
      0000000000000000000000000000000000008484840000000000000000000000
      0000000000000000000000000000000000008484840000848400008484000084
      8400008484000084840000848400008484000084840000848400008484000084
      840000848400008484000084840000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000C6C6C600C6C6C60000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000848400008484000084
      8400008484000084840000848400008484000084840000848400008484000084
      840000848400008484000084840000000000000000000000000084848400FFFF
      FF00FFFFFF00C6C6C60000008400C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C6000000000000000000C6C6C600FFFFFF00C6C6C60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484000000000000000000000000
      0000000000000000000000000000000000008484840000848400008484000084
      8400008484000084840000848400008484000084840000848400008484000084
      840000848400008484000084840000000000000000000000000084848400FFFF
      FF00C6C6C600000084000000840000008400FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000C6C6C60000000000000000000000
      0000000000000000000000000000000000000000000000000000848400008484
      0000848400008484000084840000000000008484000000000000848484000000
      0000000000000000000000000000000000008484840000848400008484000084
      8400008484000084840000848400008484000084840000848400008484000084
      840000848400008484000084840000000000000000000000000084848400FFFF
      FF0000008400000084008484840000008400C6C6C600FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000C6C6C6000000000000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF00C6C6C6000000000000000000FFFFFF00FFFF0000FFFF
      0000FFFFFF00FFFF0000FFFF0000FFFF00008484000000000000848400008484
      8400848484000000000000000000000000008484840000848400008484000084
      8400008484000084840000848400008484000084840000848400008484000084
      840000848400008484000084840000000000000000000000000084848400FFFF
      FF0000008400FFFFFF00FFFFFF00C6C6C60000008400C6C6C600FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF0000FFFF0000FFFF0000FFFF00000000000000
      000000FFFF0000FFFF0000FFFF00000000000000000000000000FFFFFF00FFFF
      0000FFFF0000FFFFFF00FFFF0000FFFF0000FFFF000084840000848400008484
      0000000000000000000000000000000000008484840000848400008484000084
      8400008484000084840000848400008484000084840000848400008484000084
      840000848400008484000084840000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000008400C6C6C600FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF000000000000FFFF00C6C6C600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848400008484
      0000848400000000000000000000000000008484840000848400008484000084
      8400008484000084840000848400008484000084840000848400008484000084
      840000848400008484000084840000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000008400C6C6
      C600FFFFFF0000000000000000000000000000000000000000000000000000FF
      FF0000FFFF0000FFFF00000000000000000000000000000000000000000000FF
      FF000000000000FFFF00FFFFFF00000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000C6C6C6008484
      00008484000000000000848484000000000084848400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00008484000084840000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      8400FFFFFF000000000000000000000000000000000000FFFF0000FFFF000000
      0000C6C6C600C6C6C60000FFFF0000FFFF0000FFFF00000000000000000000FF
      FF0000FFFF0000000000FFFFFF00000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000C6C6C600C6C6
      C600848400000000000000000000000000000000000084848400FFFFFF00C6C6
      C60000000000848484000000000000FFFF008484840000000000FFFFFF00C6C6
      C60000000000008484000084840000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000FFFF00C6C6C60000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF008484840000FFFF000000
      000000FFFF000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000000000C6C6
      C600000000008484000000000000000000000000000000000000848484008484
      8400848484008484840000000000848484008484840000000000848484008484
      840084848400000000008484840000000000000000000000000084848400FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF00000000000000000000FFFF0000FF
      FF00848484000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840000FFFF0000FFFF0000FFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400848484008484840084848400848484008484840084848400000000008484
      84008484840000000000000000000000000000000000000000000000000000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF008484840000FFFF000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF0084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C6C6C600C6C6C600C6C6C6008484840000FFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF0000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000840000008400000084000000840000008400
      0000840000008400000084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C6C6C600000084000084840000008400000000008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00840000000000000084000000840000008400
      0000840000008400000084000000840000008400000084000000840000008400
      000084000000840000000000000000000000000000000000000000000000C6C6
      C60084848400C6C6C6000084840000FFFF0000FFFF0000848400000084000000
      000084848400C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00840000000000000084000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0084000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF008400000000000000000000000000000000000000848484008400
      000084008400840000000084840000FFFF0000FFFF0000848400840084000000
      84000000000084848400848484000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C600C6C6C600C6C6C600C6C6C60084848400848484008484
      8400FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00840000000000000084000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0084000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF008400000000000000000000000000000000000000848400008484
      000084840000848400000084840000FFFF0000FFFF0000848400840084000000
      FF0000008400C6C6C600000000000000000000000000FFFFFF00FFFFFF00C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000008400
      0000840000008400000084000000840000008400000084000000840000008400
      0000840000008400000084000000840000000000000084000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0084000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF008400000000000000000000000000000000000000848484008484
      000084840000848400008484840000FFFF0000FFFF0000848400840084000000
      FF008484840000000000000000000000000000000000FFFFFF00FFFFFF00C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600FFFFFF000000000000000000000000000000000000000000000000008400
      0000FFFFFF00FFFFFF0084000000840000008400000084000000840000008400
      00008400000084000000FFFFFF00840000000000000084000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0084000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF008400000000000000000000000000000000000000848484008484
      840084848400848484008484840000FFFF0000FFFF0000848400840084000000
      FF008484840000000000000000000000000000000000FFFFFF00FFFFFF00C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C6000000000000000000000000000000000000000000000000008400
      0000FFFFFF00FFFFFF0084000000840000008400000084000000840000008400
      0000840000008400000084000000840000000000000084000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0084000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF008400000000000000000000000000000000000000848484008484
      84008484840084848400C6DEC60000FFFF0000FFFF0000FFFF00008484008484
      84008484840000000000000000000000000000000000FFFFFF00C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600FFFFFF000000000000000000000000000000000000000000000000008400
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00840000000000000000000000000000000000000084000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0084000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0084000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C60084848400C6DEC600C6DEC600C6DEC60000FFFF00848484008484
      84000000840000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600FFFF
      FF00000000000000FF000000FF00000000000000000084000000840000008400
      0000840000008400000084000000840000008400000084000000840000008400
      0000840000000000000000000000000000000000000084000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0084000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0084000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C60084848400C6DEC600C6DEC600C6DEC600C6DEC600848484008484
      84000000840000008400000000000000000000000000FFFFFF00C6C6C600C6C6
      C600C6C6C600000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
      0000C6C6C600000000000000FF00000000000000000084000000FFFFFF008400
      000084000000840000008400000084000000840000008400000084000000FFFF
      FF00840000000000000000000000000000000000000084000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0084000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0084000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6DEC600C6DEC6008484840000FFFF0084848400C6C6
      C6008484840000008400000000000000000000000000FFFFFF00C6C6C600C6C6
      C600C6C6C600C6C6C600000000000000000000000000C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000FF00000000000000000084000000FFFFFF008400
      0000840000008400000084000000840000008400000084000000840000008400
      0000840000000000000000000000000000000000000084000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0084000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0084000000000000000000000000000000C6C6C600C6DEC600F7FF
      FF00F7FFFF00C6DEC600C6C6C600008484000000000084848400C6C6C600C6DE
      C6008484840084848400000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600000000000000000000000000C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000FF00000000000000000084000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00840000000000
      0000000000000000000000000000000000000000000084000000840000008400
      0000840000008400000084000000840000008400000084000000840000008400
      00008400000084000000000000000000000000000000C6DEC600C6C6C6008484
      840084848400840084008400840084848400C6C6C60000000000840084008484
      8400848484008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000FFFFFF00FFFF
      FF00000000000000000000000000000000000000000084000000840000008400
      0000840000008400000084000000840000008400000084000000840000000000
      0000000000000000000000000000000000000000000084000000840000008400
      00008400000084000000FFFFFF00840000008400000084000000840000008400
      0000FFFFFF008400000000000000000000000000000000000000848484008484
      8400848484008484840084848400F7FFFF00C6DEC60000000000848484008484
      84000000000000000000000000000000000000000000C6C6C600FF000000FF00
      0000FF000000FF000000FF000000FF000000FFFFFF0000000000000000000000
      0000FF0000000000000000000000000000000000000084000000840000008400
      00008400000084000000840000008400000084000000FFFFFF00840000000000
      0000000000000000000000000000000000000000000084000000840000008400
      0000840000008400000084000000840000008400000084000000840000008400
      000084000000840000000000000000000000000000000000000084848400C6DE
      C600FFFFFF008484840084848400C6C6C60084848400C6C6C600C6DEC6000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084000000840000008400
      0000840000008400000084000000840000008400000084000000840000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6DEC600C6C6
      C600C6C6C60084848400C6C6C6000000000084848400C6DEC600848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C60084848400C6DEC60000000000000000000000000084848400848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008400
      0000C6C6C6008400000084000000000000000000000000000000000000000000
      0000000000000000000000000000000000008400000084000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084000000840000008400
      0000840000008400000084000000840000008400000084000000840000008400
      0000840000008400000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084000000C6C6
      C600840000008400000084000000000000000000000000000000000000000000
      0000000000000000000000000000840000008400000084000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      0000C6C6C6000000000000000000000000000000000084000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084000000C6C6C6008400
      0000840000008400000000000000000000000000000000000000000000000000
      0000000000000000000084000000840000008400000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C60000000000000000000000000084000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF008400000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084000000C6C6C600840000008400
      000084000000000000000000000000000000000000000000000084848400C6C6
      C600FFFFFF008484840000000000840000000000000000000000000000000000
      00000000840000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C60000FFFF0000FFFF0000FFFF00C6C6C600C6C6
      C600000000000000000000000000000000000000000084000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF008400000000000000000000000000000000000000000000000000
      0000C6C6C600C6C6C600C6C6C600FFFFFF008484840084000000840000008400
      0000000000000000000000000000000000000000000084848400C6C6C600C6C6
      C600C6C6C600FFFFFF0084848400000000000000000000000000000000000000
      84000000840000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600848484008484840084848400C6C6C600C6C6
      C60000000000C6C6C60000000000000000000000000084000000840000008400
      0000840000008400000084000000840000008400000084000000840000008400
      000084000000840000000000000000000000000000000000000084848400C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600FFFFFF0084848400000000000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600FFFFFF00000000000000000000000000000084000000
      8400000084000000840000008400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C600C6C6C600000000000000000084000000840000008400
      0000840000008400000084000000840000008400000084000000840000008400
      0000FFFFFF008400000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600FFFFFF00000000000000
      00000000000000000000000000000000000000000000C6C6C600FFFFFF00FFFF
      0000C6C6C600C6C6C600C6C6C600000000000000000000000000000000000000
      84000000840000000000000000000000840000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      0000C6C6C60000000000C6C6C600000000000000000084000000840000008400
      0000840000008400000084000000840000008400000084000000840000008400
      00008400000084000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      0000000000000000000000000000000000000000000084848400FFFFFF00FFFF
      FF00C6C6C600C6C6C60084848400000000000000000000000000000000000000
      0000000084000000000000000000000084000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C60000000000C6C6C60000000000000000000000000084000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0084000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      000000000000000000000000000000000000000000000000000084848400C6C6
      C600C6C6C6008484840000000000000000000000000000000000000000000000
      000000000000000000000000000000008400000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000C6C6C60000000000C6C6C600000000000000000084000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0084000000000000000000000000000000C6C6C600FFFFFF00FFFF
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000008400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      0000000000000000000000000000000000000000000084000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0084000000000000000000000000000000C6C6C600FFFFFF00FFFF
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000008400000000000000
      0000000084000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000084000000840000008400
      0000840000008400000084000000840000008400000084000000840000008400
      0000840000008400000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFF0000FFFF0000C6C6C600C6C6C600C6C6C600C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000008400000000000000
      0000000084000000840000000000000000000000000000000000000000000000
      000000000000FFFFFF000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000000000000000000084000000840000008400
      0000840000008400000084000000840000008400000084000000840000008400
      0000FFFFFF00840000000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00C6C6C600C6C6C600C6C6C60084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      8400000084000000840000008400000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000084000000840000008400
      0000840000008400000084000000840000008400000084000000840000008400
      0000840000008400000000000000000000000000000000000000000000000000
      0000C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000000000000000000000000000000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000008484000084
      8400000000000000000000000000000000000000000000000000C6C6C600C6C6
      C6000000000000848400000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008484000084
      8400008484000084840000848400008484000084840000848400008484000000
      0000000000000000000000000000000000000000000000000000008484000084
      8400000000000000000000000000000000000000000000000000C6C6C600C6C6
      C6000000000000848400000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000840000008400
      0000840000000000000000000000000000000000000000FFFF00000000000084
      8400008484000084840000848400008484000084840000848400008484000084
      8400000000000000000000000000000000000000000000000000008484000084
      8400000000000000000000000000000000000000000000000000C6C6C600C6C6
      C6000000000000848400000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000084848400C6C6C600C6C6C6008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000840000008400
      00008400000000000000000000000000000000000000FFFFFF0000FFFF000000
      0000008484000084840000848400008484000084840000848400008484000084
      8400008484000000000000000000000000000000000000000000008484000084
      8400000000000000000000000000000000000000000000000000000000000000
      00000000000000848400000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000084848400C6C6C600C6C6C600FFFF00008484
      8400848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00FFFFFF0000FF
      FF00000000000084840000848400008484000084840000848400008484000084
      8400008484000084840000000000000000000000000000000000008484000084
      8400008484000084840000848400008484000084840000848400008484000084
      84000084840000848400000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000C6C6C600C6C6C600C6C6C600C6C6C6008484
      8400C6C6C6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000840000008400
      00008400000000000000000000000000000000000000FFFFFF0000FFFF00FFFF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008484000084
      8400000000000000000000000000000000000000000000000000000000000000
      00000084840000848400000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000C6C6C600FFFF0000C6C6C600C6C6C6008484
      8400C6C6C6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000840000008400
      0000840000000000000000000000000000000000000000FFFF00FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000008484000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C6000000000000848400000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000084848400FFFF0000FFFF0000C6C6C6008484
      8400848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008400
      00008400000084000000000000000000000000000000FFFFFF0000FFFF00FFFF
      FF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000008484000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C6000000000000848400000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000084848400C6C6C600C6C6C6008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000084000000000000000000000000FFFF00FFFFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008484000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C6000000000000848400000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000840000008400000084000000000000000000
      0000000000008400000084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008484000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C6000000000000848400000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000840000008400000084000000000000000000
      0000000000008400000084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008484000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C6000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000840000008400000084000000000000000000
      0000000000008400000084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008484000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C60000000000C6C6C600000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008400000084000000840000008400
      0000840000008400000084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084000000840000008400
      0000840000008400000000000000000000000000000000000000000000000000
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
      0000848484008400000084000000840000008400000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400840000000000000000000000000000000000000084000000840000000000
      0000000000000000000084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008400
      0000000000000000000000000000000000000000000000000000000000008400
      0000000000008400000084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000008400
      0000000000000000000000000000000000000000000000000000000000008400
      0000840000008400000084000000000000000000000000000000000000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000008484
      8400840000000000000000000000000000000000000000000000840000008400
      0000840000008400000084000000000000000000000000000000000000008400
      0000000000000000000000000000000000000000000084000000840000008400
      0000840000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000840000008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000840000000000
      0000000000000000000000000000000000000000000000000000840000008400
      0000840000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000840000000000
      0000000000000000000000000000000000000000000000000000000000008400
      0000840000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000840000008400
      0000840000008400000084000000000000000000000000000000000000000000
      0000840000008484840000000000000000000000000000000000840000000000
      0000000000000000000000000000000000000000000000000000840000000000
      0000840000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000840000008400
      0000840000008400000000000000000000000000000000000000000000000000
      0000000000008400000000000000000000000000000000000000000000008400
      0000000000000000000000000000000000008400000084000000000000000000
      0000000000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000840000008400
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000008400000000000000000000000000000000000000000000000000
      0000840000008400000084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000840000008400
      0000000000008400000000000000000000000000000000000000000000000000
      0000000000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000840000000000
      0000000000000000000084000000840000000000000000000000000000000000
      0000840000008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008400000084000000840000008400
      0000848484000000000000000000000000000000000000000000000000000000
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
      0000000000000000000000000000000000000000000000840000008400000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008400000084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000840000008400000084000000840000008400
      0000840000008400000084000000840000000000000000840000008400000084
      0000008400000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000000000000000000000840000000000000000000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000840000008400000084000000840000008400
      0000840000008400000084000000840000000000000000000000000000000000
      0000000000000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00840000000000000000840000008400000084
      0000008400000084000000840000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000000000000000000000840000000000000084000000000000000000
      0000840000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00840000000000000084848400008484008484
      8400008484008484840084000000FFFFFF000000000000000000000000000000
      00000000000000000000FFFFFF00840000000000000000840000008400000084
      0000008400000084000000840000008400000084000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000000000000000000000840000000000000084000000000000000000
      0000840000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084000000FFFFFF0000000000000000000000
      00000000000000000000FFFFFF00840000000000000000848400848484000084
      8400848484000084840084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00840000000000000000840000008400000084
      0000008400000084000000840000008400000084000000840000008400000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008400000084000000840000000000000084000000000000000000
      0000840000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00840000000000000084848400008484008484
      8400008484008484840084000000FFFFFF00000000000000000000000000FFFF
      FF00840000008400000084000000840000000000000000840000008400000084
      0000008400000084000000840000008400000084000000840000008400000084
      0000008400000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000840000000000000084000000840000008400
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0084000000FFFFFF0000000000000000000000
      00000000000000000000FFFFFF00840000000000000000848400848484000084
      8400848484000084840084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0084000000FFFFFF0084000000000000000000000000840000008400000084
      0000008400000084000000840000008400000084000000840000008400000084
      0000008400000084000000840000000000000000000000000000000000000000
      0000000000000000000000000000840000000000000084000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      000000000000000000000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00840000000000000084848400008484008484
      8400008484008484840084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00840000008400000000000000000000000000000000840000008400000084
      0000008400000084000000840000008400000084000000840000008400000084
      0000008400000084000000840000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0084000000FFFFFF000000000000000000FFFF
      FF00840000008400000084000000840000000000000000848400848484000084
      8400848484000084840084000000840000008400000084000000840000008400
      0000840000000000000000000000000000000000000000840000008400000084
      0000008400000084000000840000008400000084000000840000008400000084
      0000008400000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      000000000000000000000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0084000000FFFFFF0084000000000000000000000084848400008484008484
      8400008484008484840000848400848484000084840084848400008484008484
      8400008484000000000000000000000000000000000000840000008400000084
      0000008400000084000000840000008400000084000000840000008400000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0084000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00840000008400000000000000000000000000000000848400848484000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400848484000000000000000000000000000000000000840000008400000084
      0000008400000084000000840000008400000084000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      000000000000FFFFFF0000000000840000008400000084000000840000008400
      0000840000000000000000000000000000000000000084848400848484000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600000000008484
      8400008484000000000000000000000000000000000000840000008400000084
      0000008400000084000000840000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000848400848484000084
      84000000000000FFFF00000000000000000000FFFF0000000000848484000084
      8400848484000000000000000000000000000000000000840000008400000084
      0000008400000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF0000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000840000008400000000
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
      8400848484000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00000000000000000000000000FFFFFF0000000000FFFF
      FF000000000000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C60000000000000000000000000000000000000000008484840000000000FFFF
      FF00FFFFFF00FFFFFF00000000000000000084848400F7FFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000C6DEC600000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C60000000000000000000000000000000000000000008484840000000000FFFF
      FF00FFFFFF0000000000C6DEC6000000840000FFFF0084848400F7FFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF000000000000000000FFFFFF000000000000000000FFFF
      FF000000000000000000FFFFFF0000000000000000000000000000000000C6C6
      C60000000000000000000000000000000000000000000000000000000000C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008484840000000000FFFF
      FF000000000000FFFF00000084000000FF008400840000FFFF0084848400FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000008484840000000000000000000000000084848400000000000000
      00000000000000000000000000000000000000000000C6C6C600848484000000
      00000000000000000000000000000000000000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000084848400000000000000
      000000FFFF0084008400000000000000FF000000FF000000840000FFFF008484
      8400FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000FFFFFF0000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600848484000000
      00000000000000000000C6C6C6000000000000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000084848400000000008484
      8400000084000000FF000000FF00000000000000FF0000000000000084000000
      0000848484000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000FFFF000000000000000000FFFFFF0000000000FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF0000000000000000000000000000000000C6C6
      C60000000000000000000000000000000000C6C6C60000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600848484000000
      00000000000000000000C6C6C6000000000000000000C6C6C600000000000000
      000000000000000000000000000000000000000000008484840000000000FFFF
      FF00848484000000000084848400FFFFFF00000000000000FF00000000000000
      840000000000000000000000000000000000000000000000000000000000FFFF
      FF0000FFFF000000000000FFFF00FFFFFF0000000000FFFFFF0000FFFF000000
      0000FFFFFF0000000000FFFFFF0000000000000000000000000000000000C6C6
      C60000000000000000000000000000000000C6C6C60000000000000000000000
      0000000000000000000000000000000000000000000000000000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008484840000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000FF000000
      0000000084000000000000000000000000000000000000000000FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF0000000000FFFFFF0000FFFF0000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C6008484840000000000000000000000000000000000C6C6C600848484000000
      000000000000000000000000000000000000000000008484840000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      FF0000000000000084000000000000000000000000000000000000FFFF00FFFF
      FF0000FFFF00FFFFFF0000000000FFFFFF0000FFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008484840000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      00000000FF000000000000008400000000000000000000000000FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400000000000000000000000000000000000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000840000000000FFFF00000000000000FFFF00FFFF
      FF0000FFFF00FFFFFF0000FFFF00000000000000000000000000FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400000000000000000000000000000000000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFF0000FFFF00000000000000FF
      FF00FFFFFF0000FFFF000000000000FFFF00FFFFFF0000FFFF0000000000FFFF
      FF0000000000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C6C6C6008484840084848400848484008484
      840084848400C6C6C60000000000000000000000000000000000000000008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400000000000000000000000000000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400000000000000
      0000000000000000000000000000000000000000000000848400C6DEC600C6DE
      C600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600008484000000000000000000000000000000000000000000000000000000
      00000000000000000000C6C6C600C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000C6DEC600C6DEC600FFFF
      FF00FFFFFF00C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC6000000000000000000000000000000000000000000000000000000
      00000000000000000000C6C6C60000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000000000000000000008484840000000000C6DE
      C600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600000000000000000000000000000000008484840000000000008484000084
      840000848400008484000084840000848400008484000084840000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000C6DEC600FFFFFF00C6DE
      C600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC6000000000000000000000000000000000000000000000000000000
      00000000000000000000C6C6C60000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000000000000000000008484840000000000C6DE
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00C6C6C6000000000000000000000000008484840000000000008484000084
      840000848400008484000084840000848400008484000084840000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000C6DEC600FFFFFF00C6DE
      C600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC6000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C6000000000084848400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000000000000000000008484840000000000C6DE
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6DE
      C60000000000FFFFFF00FFFFFF00000000008484840000000000008484000084
      840000848400008484000084840000848400008484000084840000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000000000000000C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC60000000000000000000000000000000000C6C6C600C6C6C6000000
      0000000000000000000000000000000000000000000084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000008484
      8400C6DEC600C6DEC600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008484
      840000000000FFFFFF00FFFFFF0000000000848484000000000000FFFF000084
      840000848400008484000084840000848400008484000084840000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000084848400848484008484
      84008484840000000000C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC60000000000000000000000000000000000C6C6C60000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000084848400FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000084848400000000008484
      84000000000084848400C6DEC600C6DEC600FFFFFF00FFFFFF00C6DEC6000000
      000000000000000000000000000000000000848484000000000000FFFF000084
      8400008484000084840000848400008484000084840000848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6DE
      C600C6DEC60000000000000000000000000000000000C6C6C60000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000084848400FFFF
      FF00FFFFFF00FFFFFF000000000000000000000000008484840000000000C6DE
      C600F7FFFF00848484000000000084848400C6DEC600C6DEC600848484000000
      0000F7FFFF00000000000000000000000000848484000000000000FFFF000084
      8400008484000084840000848400008484000084840000848400008484000084
      84000084840000848400000000000000000000000000C6DEC600C6DEC6000000
      000084848400848484008484840084848400848484008484840000000000C6DE
      C6000084840000000000000000000000000000000000C6C6C60000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000084848400FFFF
      FF0000000000000000000000000000000000000000008484840000000000C6DE
      C600FFFFFF00FFFFFF00F7FFFF0000000000000000000000000000000000F7FF
      FF00FFFFFF00000000000000000000000000848484000000000000FFFF000084
      8400008484000084840000848400008484000084840000848400008484000084
      84000084840000848400000000000000000000000000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C60000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000084848400FFFF
      FF0000000000000000000000000000000000000000008484840000000000C6DE
      C600F7FFFF00848484000000000084848400F7FFFF00F7FFFF00848484000000
      000000000000000000000000000000000000848484000000000000FFFF000084
      8400008484000084840000848400008484000084840000848400008484000084
      84000084840000848400000000000000000000000000FFFFFF00FFFFFF000000
      0000C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600000000000000
      00000000000000000000000000000000000000000000C6C6C60000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000084848400000000008484
      84000000000084848400C6DEC600F7FFFF00FFFFFF00FFFFFF00F7FFFF008484
      840000000000FFFFFF00FFFFFF00000000008484840000000000008484000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000848400000000000000000000000000FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      00000000000000000000000000000000000000000000C6C6C60000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C6DEC600F7FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6DE
      C60000000000FFFFFF00FFFFFF00000000008484840000000000008484000000
      0000F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FF
      FF000000000000848400000000000000000000000000FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      00000000000000000000000000000000000000000000C6C6C60000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      000000000000000000000000000000000000000000008484840000000000C6DE
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6DEC600C6DE
      C600C6C6C6000000000000000000000000000000000084848400000000000000
      0000F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00C6DE
      C6000000000000000000000000000000000000000000FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C60000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      000000000000000000000000000000000000000000008484840000000000C6DE
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6DEC6000000
      0000000000000000000000000000000000000000000000000000848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00000000000000
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400C6DEC600C6DE
      C600C6DEC600C6C6C600C6C6C600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC600C6DEC600C6DEC600000000000000000000000000000000000000
      0000F7FFFF00C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000848400C6DEC600C6DE
      C600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600008484000000000000000000000000000000000084848400C6DEC600C6DE
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600000000000000000000000000000000000000
      0000C6C6C600C6C6C600C6DEC600C6DEC600C6DEC600C6C6C600848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6DEC600C6DEC600FFFF
      FF00FFFFFF00C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400848484008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C6000000
      00000000000000000000000000000000000000000000C6DEC600FFFFFF00C6DE
      C600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC6000000000000000000000000000000000084848400FFFFFF00C6DE
      C600000000000000000000000000000000000000000000000000000000000000
      00008484840084848400C6C6C6000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C6008484840000000000000000000000000000000000000000000000
      00000000000000000000C6C6C6008484840000000000FFFFFF00FFFFFF000000
      00000000000000000000000000000000000000000000C6DEC600FFFFFF00C6DE
      C600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC6000000000000000000000000000000000084848400C6DEC6000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084848400C6C6C6000000000000000000C6DEC600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C6DEC6008484840000000000000000000000000000000000000000000000
      000000000000C6C6C600C6DEC6000000000000000000FFFFFF00FFFFFF000000
      00000000000000000000000000000000000000000000C6DEC600FFFFFF00C6DE
      C600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC6000000000000000000000000000000000000000000000000000000
      0000000000008484840084848400848484008484840084848400848484000000
      00000000000000000000000000000000000000000000C6DEC60000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000C6DEC600848484000000000000000000000000000000000000000000C6C6
      C600C6DEC600C6DEC60000FFFF00000000000000000000000000FFFFFF000000
      00000000000000000000000000000000000000000000C6DEC600FFFFFF00C6DE
      C600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC6000000000000000000000000000000000084848400000000000000
      000000000000F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF000000
      00000000000000000000848484000000000000000000C6DEC60000000000FFFF
      FF00FFFFFF0084000000840000008400000084000000FFFFFF00FFFFFF000000
      0000C6DEC600848484000000000000000000000000000000000000000000F7FF
      FF0000FFFF0000FFFF0000FFFF00000000000000000084848400FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC6000000000000000000000000000000000000000000000000000000
      000000000000C6DEC6008484000084840000FFFFFF0084840000848400000000
      00000000000000000000000000000000000000000000C6DEC60000000000FFFF
      FF00FFFFFF0084000000FF000000FF00000084000000FFFFFF00FFFFFF000000
      0000C6DEC600848484000000000000000000000000000000000000000000F7FF
      FF00FFFFFF0000FFFF0000FFFF00000000000000000084848400FFFFFF000000
      0000000000000000000000000000000000000000000084848400848484008484
      840084848400848484008484840000000000C6DEC600C6DEC600C6DEC600C6DE
      C600008484000000000000000000000000000000000000000000000000000000
      000000000000C6DEC6008484000084840000FFFFFF0084840000848400000000
      00000000000000000000000000000000000000000000C6DEC60000000000FFFF
      FF00FFFFFF00FF000000F7FFFF00FF00000084000000FFFFFF00FFFFFF000000
      0000C6DEC600848484000000000000000000000000000000000000000000C6C6
      C600F7FFFF00FFFFFF0000FFFF00000000000000000000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      00000000000000000000000000000000000000000000C6DEC60000000000FFFF
      FF00FFFFFF00FF000000FF0000008400000084000000FFFFFF00FFFFFF000000
      0000C6DEC6008484840000000000000000000000000000000000000000000000
      000000000000C6C6C600F7FFFF000000000000000000FFFFFF00FFFFFF000000
      00000000000000000000000000000000000000000000C6DEC600C6DEC600C6DE
      C600C6DEC600C6DEC600C6DEC600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6DEC6008484000084840000FFFFFF0084840000848400000000
      00000000000000000000000000000000000000000000C6DEC60000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000C6DEC6008484840000000000000000000000000000000000000000000000
      00000000000000000000C6C6C6008484840000000000FFFFFF00FFFFFF000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6DEC6008484000084840000FFFFFF0084840000848400000000
      00000000000000000000000000000000000000000000C6DEC600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C6DEC6008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C6000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C6DEC600FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      00000000000000000000000000000000000000000000C6DEC600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6DEC6008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6DEC600C6DE
      C600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC600C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00000000000000000000000000000000000000
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
      000000000000000000000000000000000000000000000000000000008400C6DE
      C6000000FF000000FF000000FF00000000008484840084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8400C6DEC6000000FF000000FF000000FF000000000084848400848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000008400C6DEC600C6DEC6000000FF000000FF0000000000848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000008400C6DEC600848484000000000000000000000000008484
      8400848484000000000000000000000000000000000000000000000000000000
      0000C6C6C6000000000000000000C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C6C6C6000000000000000000C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C6C6C6000000000000000000C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF000000FF00000000840000000000F7FFFF0000000000000000000000
      0000848484000000000000000000000000000000000000000000C6C6C6000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000C6C6C6000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000C6C6C6000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF0000FFFFFF00FFFFFF00000084000000000000000000000000000000
      000000000000848484000000000000000000000000000000000000000000FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF0000000000000000000000000000000000FFFFFF0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF0000FFFFFF00008400000084000000000000F7FFFF00F7FFFF000000
      00000000000084848400000000000000000000000000C6C6C600FFFFFF00FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00C6C6C6000000
      00000000000000000000000000000000000000000000C6C6C600FFFFFF000000
      00000000000000000000000000000000000000000000FFFFFF00C6C6C6000000
      00000000000000000000000000000000000000000000C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C6000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF0000FFFFFF000084000000FF00000000000000000000848484008484
      8400000000000000000000000000000000000000000000000000FFFFFF000000
      0000FFFFFF0000000000FFFFFF0000000000FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF0000FFFFFF000084000000FF00000084000000000000000000000000
      0000000000000000000084848400000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF00FFFF
      FF0000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF0000FFFFFF000084000000FF000000FF000000840000000000000000
      00000000000000000000848484000000000000000000C6C6C600FFFFFF000000
      0000FFFFFF0000000000FFFFFF0000000000FFFFFF00FFFFFF00C6C6C6000000
      00000000000000000000000000000000000000000000C6C6C600FFFFFF00FFFF
      FF0000000000FFFFFF000000000000000000FFFFFF00FFFFFF00C6C6C6000000
      00000000000000000000000000000000000000000000C6C6C60000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C6000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF0000FFFFFF000084000000FF000000FF000000FF000000FF00000084
      000084848400000000008484840000000000000000000000000000000000FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF0000000000FFFFFF000000000000000000FFFFFF0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF0000FFFFFF000084000000FF000000FF000000FF000000FF000000FF
      00000084000000000000FFFFFF00000000000000000000000000C6C6C6000000
      0000FFFFFF0000000000FFFFFF00FFFFFF0000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000C6C6C6000000
      0000FFFFFF000000000000000000FFFFFF0000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000C6C6C6000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF0000FFFFFF0000840000008400000084000000840000008400000084
      00000084000000840000FFFFFF00000000000000000000000000000000000000
      0000848484000000000000000000848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084848400F7FFFF00F7FFFF00848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848484000000000000000000848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
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
      0000C6C6C6000000000000000000C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C6C6C6000000000000000000C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C6C6C6000000000000000000C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C6C6C6000000000000000000C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C6000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000C6C6C6000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C6000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000C6C6C6000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000084848400000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000084848400000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF0000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C6000000
      00000000000000000000000000000000000000000000C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00000000000000000084848400FFFFFF00C6C6C6000000
      00000000000000000000000000000000000000000000C6C6C600FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00C6C6C6000000
      00000000000000000000000000000000000000000000C6C6C600FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00C6C6C6000000
      0000000000000000000000000000000000000000000084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF00FFFF
      FF00FFFFFF00000000000000000084848400FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF000000
      000000000000FFFFFF00FFFFFF000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF00FFFF
      FF000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF00FFFF
      FF00000000000000000084848400FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000084848400000000000000
      000000000000FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      00000000000000000000000000000000000000000000C6C6C60000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C6000000
      00000000000000000000000000000000000000000000C6C6C600000000000000
      00000000000084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C6000000
      00000000000000000000000000000000000000000000C6C6C600000000000000
      000000000000FFFFFF00FFFFFF000000000000000000FFFFFF00C6C6C6000000
      00000000000000000000000000000000000000000000C6C6C60000000000FFFF
      FF000000000000000000000000000000000000000000FFFFFF00C6C6C6000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF0000000000FFFFFF00FFFFFF0000000000FFFFFF0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00000000000000000000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C6000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000C6C6C6000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000C6C6C6000000
      0000FFFFFF00FFFFFF0000000000FFFFFF0000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848484000000000000000000848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848484000000000000000000848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848484000000000000000000848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848484000000000000000000000000000000000000000000000000000000
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
      0000000000000000000000000000000000000000000084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008484840000000000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000F7FFFF00FFFF0000FFFF0000FFFF
      0000FFFF00000000000000000000000000000000000000000000000000000000
      0000848484008484840084848400848484008484840084848400848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C6C6C6000000000000000000C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C6C6C6000000000000000000C6C6C6000000000000000000000000000000
      000000000000000000000000000000000000000000008484840000000000FFFF
      0000FFFF0000FFFF0000FFFF0000F7FFFF0000000000F7FFFF00FFFF0000FFFF
      0000FFFF00000000000000000000000000000000000000000000000000000000
      0000848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C6000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000C6C6C6000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000084848400000000000000
      000000000000000000000000000000000000000000008484840000000000FFFF
      0000F7FFFF00F7FFFF00F7FFFF00F7FFFF000000000000000000F7FFFF00FFFF
      0000FFFF00000000000000000000000000000000000000000000000000000000
      00008484840000000000FFFFFF00FFFFFF00FFFF0000C6C6C600FFFFFF000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF000000000000000000FFFFFF00FFFFFF0000000000000000000000
      000000000000000000000000000000000000000000008484840000000000F7FF
      FF00000000000000000000000000000000000084840000FFFF0000000000F7FF
      FF00FFFF00000000000000000000000000000000000000000000000000000000
      00008484840000000000FFFFFF00F7FFFF0084840000C6C6C600F7FFFF000000
      00000000000000000000000000000000000000000000C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C6000000
      00000000000000000000000000000000000000000000C6C6C600FFFFFF00FFFF
      FF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFFFF00C6C6C6000000
      000000000000000000000000000000000000000000008484840000000000F7FF
      FF000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000
      0000F7FFFF000000000000000000000000000000000000000000000000000000
      00008484840000000000FFFFFF00FFFFFF0084840000C6C6C600FFFFFF000000
      0000000000000000000000000000000000000000000084848400FFFFFF000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      000000000000000000000000000000000000000000008484840000000000F7FF
      FF00000000000000000000000000000000000084840000FFFF0000000000F7FF
      FF00FFFF00000000000000000000000000000000000000000000000000000000
      00008484840000000000FFFF0000FFFF0000FFFF0000FFFF0000848400000000
      0000000000000000000000000000000000000000000084848400FFFFFF000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      000000000000000000000000000000000000000000008484840000000000FFFF
      0000F7FFFF00F7FFFF00F7FFFF00F7FFFF000000000000000000F7FFFF00FFFF
      0000FFFF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C60000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C6000000
      00000000000000000000000000000000000000000000C6C6C60000000000FFFF
      FF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFFFF00C6C6C6000000
      000000000000000000000000000000000000000000008484840000000000FFFF
      0000FFFF0000FFFF0000FFFF0000F7FFFF0000000000F7FFFF00FFFF0000FFFF
      0000FFFF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF000000000000000000FFFFFF00FFFFFF0000000000000000000000
      000000000000000000000000000000000000000000008484840000000000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000F7FFFF00FFFF0000FFFF0000FFFF
      0000FFFF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C6000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000C6C6C6000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848484000000000000000000848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848484000000000000000000848484000000000000000000000000000000
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
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000C6DEC600F7FF
      FF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FF
      FF00000000000000000000000000000000000000000000000000008484000084
      8400000000000000000000000000000000000000000000000000FFFFFF00C6DE
      C600000000000084840000000000000000000000000000000000000000000000
      00000000000000000000FFFF0000FFFF0000FFFF000000000000000000000000
      0000FFFF0000FFFF000000000000000000000000000000000000000000008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840084848400000000008484840000000000F7FFFF008484
      8400000000008484840000FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FF
      FF00000000000000000000000000000000000000000000000000008484000084
      8400000000000000000000000000000000000000000000000000FFFFFF00C6DE
      C600000000000084840000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FF00000084
      000000000000FFFF000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400000000008484840000000000C6DEC60000FF
      FF0084848400000000008484840000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000008484000084
      8400000000000000000000000000000000000000000000000000FFFFFF00C6DE
      C600000000000084840000000000000000000000000000000000000000000000
      000000000000000000000000000000FF000000FF000000FF000000FF000000FF
      000000840000000000000000000000000000000000000000000000000000FFFF
      0000FFFF0000FFFF0000FFFF0000F7FFFF00FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF00000000000084848400000000008484840000000000C6DEC600C6DE
      C60000FFFF008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008484000084
      8400000000000000000000000000000000000000000000000000000000000000
      000000000000008484000000000000000000000000000000000000000000C6C6
      C600C6C6C600000000000000000000FF000000FF000000FF000000FF000000FF
      000000840000000000000000000000000000000000000000000000000000FFFF
      0000FFFF0000FFFF0000F7FFFF0000000000F7FFFF00FFFF0000FFFF0000FFFF
      0000FFFF00000000000084848400000000008484840000000000C6DEC600C6DE
      C600C6DEC60000FFFF000000000084848400FFFFFF00FFFFFF00848484000000
      0000C6DEC600FFFFFF00FFFFFF00000000000000000000000000008484000084
      8400008484000084840000848400008484000084840000848400008484000084
      8400008484000084840000000000000000000000000000000000000000008484
      000084840000000000000000000000000000000000000000000000FF00000084
      000000000000FFFF00000000000000000000000000000000000000000000FFFF
      0000FFFF0000F7FFFF000000000000000000F7FFFF00F7FFFF00F7FFFF00F7FF
      FF00FFFF0000000000008484840000000000848484000000000000FFFF0000FF
      FF0000FFFF0000FFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000C6DEC600FFFFFF00FFFFFF00000000000000000000000000008484000084
      8400000000000000000000000000000000000000000000000000000000000000
      0000008484000084840000000000000000000000000000000000000000008484
      00008484000000000000FFFFFF00FFFFFF00C6DEC60000000000000000000000
      0000FFFF0000FFFF00000000000000000000000000000000000000000000FFFF
      0000F7FFFF000000000000FFFF00008484000000000000000000000000000000
      0000F7FFFF00000000008484840000000000848484000000000000FFFF00C6DE
      C60000FFFF0000FFFF0000000000FFFFFF00F7FFFF00F7FFFF00FFFFFF000000
      0000C6DEC600FFFFFF00FFFFFF00000000000000000000000000008484000000
      0000C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C6000000000000848400000000000000000000000000FF000000000000008484
      0000848400000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F7FF
      FF000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000
      0000F7FFFF000000000084848400000000000000000000000000C6C6C60000FF
      FF00C6DEC600C6DEC6000000000084848400FFFFFF00FFFFFF00848484000000
      0000C6DEC600FFFFFF00FFFFFF00000000000000000000000000008484000000
      0000C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C6000000000000848400000000000000000000000000FF00000000000000C6C6
      C600848400008484000084840000848400008484000084840000848400000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      0000F7FFFF000000000000FFFF00008484000000000000000000000000000000
      0000F7FFFF000000000084848400000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6DE
      C600FFFFFF00C6DEC600C6DEC600000000000000000000000000008484000000
      0000C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C6000000000000848400000000000000000000000000FF00000000000000FFFF
      0000C6C6C6008484000084840000848400008484000084840000848400000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      0000FFFF0000F7FFFF000000000000000000F7FFFF00F7FFFF00F7FFFF00F7FF
      FF00FFFF00000000000084848400000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6DE
      C600FFFFFF00C6DEC60000000000000000000000000000000000008484000000
      0000C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C6000000000000848400000000000000000000000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      0000FFFF0000FFFF0000F7FFFF0000000000F7FFFF00FFFF0000FFFF0000FFFF
      0000FFFF00000000000084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008484000000
      0000C6DEC600FFFFFF00C6DEC600FFFFFF00C6DEC600FFFFFF00C6DEC600FFFF
      FF000000000000000000000000000000000000000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF00000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      0000FFFF0000FFFF0000FFFF0000F7FFFF00FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF00000000000084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008484000000
      0000FFFFFF00C6DEC600FFFFFF00C6DEC600FFFFFF00C6DEC600FFFFFF00C6DE
      C60000000000FFFFFF0000000000000000000000000084840000840000008400
      0000840000008400000084000000840000008400000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000840000008400
      0000840000008400000084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848484000000000000FFFF00008484000084840000848400000000008484
      8400000000000000000000000000000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400000000000000000000000000000000008400000084000000840000008400
      0000840000008400000084000000840000008400000084000000840000008400
      000084000000840000008400000000000000000000000000000084848400C6DE
      C600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC600C6DEC60000000000000000000000000000000000000000000000
      000084848400000000000084840000FFFF000084840000848400000000008484
      8400000000000000000000000000000000000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008484840000000000000000000000000084000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600848484008484
      840084848400840000008484840000000000000000000000000084848400C6DE
      C60000000000C6DEC60000000000C6DEC60000000000C6DEC600C6DEC600C6DE
      C600C6DEC600C6DEC60000000000000000000000000000000000000000000000
      0000000000008484840000000000F7FFFF000084840000000000848484000000
      000000000000000000000000000000000000848484000000000000FFFF00F7FF
      FF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FF
      FF000000000084848400000000000000000084000000C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00C6C6C600840000008484840000000000000000000000000084848400FFFF
      FF00C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC600C6DEC60000000000000000000000000000000000000000000000
      0000000000008484840000000000F7FFFF000084840000000000848484000000
      000000000000000000000000000000000000848484000000000084848400F7FF
      FF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FF
      FF00F7FFFF0000000000848484000000000084000000C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00C6C6C600840000008484840000000000000000000000000084848400FFFF
      FF0000000000F7FFFF0000000000C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC600C6DEC60000000000000000000000000000000000000000000000
      0000000000008484840000000000F7FFFF000084840000000000848484000000
      000000000000000000000000000000000000848484000000000000008400F7FF
      FF00C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC600C6DEC600000000000000000084000000C6C6C600FFFFFF000000
      00000000000000000000FFFFFF00FFFFFF00000000000000000000000000FFFF
      FF00C6C6C600840000008484840000000000000000000000000084848400FFFF
      FF00FFFFFF00F7FFFF00F7FFFF00C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC600C6DEC60000000000000000000000000000000000000000000000
      0000000000008484840000000000F7FFFF000084840000000000848484000000
      000000000000000000000000000000000000848484000000000000FFFF008484
      8400F7FFFF00C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC600C6DEC600000000000000000084000000C6C6C60000000000FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF000000
      0000C6C6C600840000008484840000000000000000000000000084848400FFFF
      FF0000000000FFFFFF0000000000C6DEC60000000000C6DEC60000000000C6DE
      C60000000000C6DEC60000000000000000000000000000000000000000000000
      0000000000008484840000000000008484000084840000000000848484000000
      0000000000000000000000000000000000008484840000000000C6DEC6000000
      8400F7FFFF00C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC600C6DEC600000000000000000084000000C6C6C600FFFFFF000000
      00000000000000000000FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF000000
      0000C6C6C600840000008484840000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00F7FFFF00F7FFFF00C6DEC600C6DEC600C6DE
      C600C6DEC600C6DEC60000000000000000008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      840000000000000000000000000000000000848484000000000000FFFF0000FF
      FF00000084000000840000008400000084000084840000848400008484000084
      84000084840000848400000000000000000084000000C6C6C600FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF00000000000000000000000000FFFF
      FF00C6C6C600840000008484840000000000000000000000000084848400FFFF
      FF0000000000FFFFFF0000000000FFFFFF0000000000F7FFFF00C6DEC600C6DE
      C600C6DEC600C6DEC60000000000000000000000000084848400000000000000
      00008484840000000000C6C6C600C6DEC600C6DEC600C6DEC600C6DEC6000000
      000000000000C6C6C6008484840084848400848484000000000000FFFF00C6DE
      C600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC600C6C6C600000000000000000084000000C6C6C600FFFFFF000000
      000000000000FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00C6C6C600840000008484840000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7FFFF00C6DE
      C600C6DEC600C6DEC60000000000000000000000000000000000848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      000000000000C6DEC60084848400848484000000000000000000C6C6C60000FF
      FF0000FFFF00C6DEC600C6C6C600000000000000000000000000000000000000
      00000000000000000000000000000000000084000000C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00C6C6C600840000008484840000000000000000000000000084848400FFFF
      FF0000000000FFFFFF0000000000FFFFFF0000000000FFFFFF0000000000C6DE
      C600C6DEC600C6DEC600000000000000000000000000C6DEC600C6C6C6000000
      000000000000848484000000000000000000C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC600C6DEC60084848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084000000C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00C6C6C600840000008484840000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7FFFF00F7FF
      FF00C6DEC600C6DEC60000000000000000000000000084848400F7FFFF000000
      0000F7FFFF0000000000FFFFFF00C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C60084848400848484000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FF00000000
      00000000000000000000000000000000000084000000C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00C6C6C600840000008484840000000000000000000000000084848400FFFF
      FF0000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00F7FFFF000000
      0000000000000000000000000000000000000000000000000000848484008484
      840000000000C6DEC600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      000000000000C6C6C60084848400848484000000000000000000000000000000
      000000000000000000000000000000000000000000000084000000FF00000084
      00000000000000000000000000000000000084000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600848484008484
      840084848400840000008484840000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7FFFF008484
      8400FFFFFF00C6DEC60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FF000000FF00008484
      8400000000000000000000000000000000008400000084000000840000008400
      0000840000008400000084000000840000008400000084000000840000008400
      000084000000840000008484840000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7FFFF008484
      8400C6DEC6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6DEC6000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000840000008400
      0000840000008400000084000000000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400000000000000000000000000000000000000000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000000000008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400000000000000000000000000000000000000000000000000000000008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000848484000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000000000000000FF000000FF000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C6C6C60000000000C6C6C60000000000C6C6
      C600C6C6C600C6C6C600C6C6C600000000000000000000000000848484000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000848484000000
      0000FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000000000000000FF000000FF000000
      FF00000084000000000000000000000000000000000000000000000000000000
      00000000FF000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000C6C6C6000000
      0000000000000000000000000000000000000000000000000000848484000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000848484000000
      0000FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      FF000000000000000000000000000000000000000000C6C6C600000000000000
      00000000000000000000000000000000000000FF000000840000000000008484
      8400FFFFFF00FFFFFF0000000000000000000000000000000000848484000000
      0000FFFFFF00FFFFFF00FFFFFF000000000000FF000000000000FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000848484000000
      0000FFFFFF00FFFFFF000000000000FF000000000000FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF00000000000000000000000000000000000000FF000000
      FF00000000000000000000000000000000000000000000000000008400000084
      00000084000000840000008400000084000000FF000000FF0000008400000000
      000084848400FFFFFF00FFFFFF00000000000000000000000000848484000000
      0000FFFFFF00FFFFFF000000000000FF000000FF000000000000FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000848484000000
      0000FFFFFF00FFFFFF000000000000FF000000FF000000000000FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF0000000000000000000000FF000000FF000000
      000000000000000000000000000000000000000000000000000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF00000084
      00000000000084848400FFFFFF00000000000000000000000000848484000000
      0000FFFFFF00FFFFFF00FFFFFF000000000000FF000000000000FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000848484000000
      0000FFFFFF00FFFFFF000000000000FF000000000000FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF00000000000000
      000000000000000000000000000000000000000000000000000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF0000008400000000
      000084848400FFFFFF00FFFFFF00000000000000000000000000848484000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000848484000000
      0000FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF0000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600000000000000
      00000000000000000000000000000000000000FF000000840000000000008484
      8400FFFFFF00FFFFFF0000000000000000000000000000000000848484000000
      0000C6DEC600C6DEC600C6DEC600FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000848484000000
      0000FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00C6DEC600C6DEC600C6DE
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF000000000000000000000000000000000000000000848484000000
      00000000000000000000C6DEC600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000848484000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6DEC600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF0000000000000000000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C6000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C6DEC600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000848484000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6DEC600000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF00000000000000000000000000000000000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084848400C6DEC600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000848484000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6DEC600848484000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF0000000000000000000000000000000000000000000000
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
      00000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C6000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C6000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000C6C6C6000000000000000000C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C6000000000000000000C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF008484
      0000FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00848400008484
      0000FFFFFF00FFFFFF00FFFFFF0000000000C6C6C600C6C6C600000000000000
      0000C6C6C600C6C6C600C6C6C6000000000000000000C6C6C600C6C6C600C6C6
      C6000000000000000000C6C6C600C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000008400000000000000000000FFFFFF008484
      0000FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF0084840000848400008484
      000084840000FFFFFF00FFFFFF0000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C6000000000000000000FFFFFF00000000000000000000000000C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008400000084000000840000008400000084000000000000FFFFFF008484
      0000FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF0084840000848400008484
      000084840000FFFFFF00FFFFFF0000000000C6C6C600C6C6C600C6C6C600C6C6
      C60000000000FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484000000
      0000000000000000000000000000000000000000000000000000000000000084
      0000008400000000000000000000008400000000000000000000FFFFFF008484
      000084840000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00848400008484
      0000FFFFFF00FFFFFF00FFFFFF0000000000C6C6C600C6C6C600C6C6C600C6C6
      C60000000000FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000000000000000
      0000000000000000000084848400000000000000000000000000848484000000
      0000848484000000000000000000000000000000000000000000000000000084
      0000000000000000000000000000000000000000000000000000FFFFFF008484
      000084840000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000C6C6C6000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      000000000000C6C6C60000000000000000000000000000000000848484000000
      0000000000008484840000000000848484000000000000000000000000008484
      8400000000000000000000000000000000000000000000000000008400000084
      0000008400000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C6000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      000000000000C6C6C60000000000000000000000000000000000000000008484
      8400848484000000000000000000848484000000000000000000000000000000
      0000848484008484840000000000000000000000000000000000000000000084
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000084
      000000000000000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C60000000000FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000000000000000
      0000000000000000000084848400000000000000000000000000848484000000
      0000000000008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008400000084
      000000840000000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C60000000000FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000848484000000
      0000000000008484840000000000000000000000000000000000848484008484
      84008484840084848400000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000084
      000000000000000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C6000000000000000000FFFFFF00000000000000000000000000C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000848484008484
      8400000000000000000084848400000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF008484000084840000FFFFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00848400008484
      0000FFFFFF000000000000000000008400000000000000000000008400000084
      000000000000000000000000000000000000C6C6C600C6C6C600000000000000
      0000C6C6C600C6C6C600C6C6C600000000000000000000000000C6C6C600C6C6
      C6000000000000000000C6C6C600C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00848400008484
      00008484000084840000FFFFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00848400008484
      0000FFFFFF000000000000840000008400000084000000840000008400000000
      000000000000000000000000000000000000C6C6C6000000000000000000C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C6000000000000000000C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000008400000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C6000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C6000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600000000000000000000000000000000000000
      0000000000000000000084848400848484008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6DE
      C60000000000000000000000000000000000000000000000000000000000C6DE
      C6000000000000000000000000000000000000000000F7FFFF00008484000000
      840000848400F7FFFF00C6C6C600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848484008484840000000000000000000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00F7FFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      84008484840000000000000000000000000000000000F7FFFF000000000000FF
      FF00000000000000000000FFFF00F7FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484008484
      84000000000000000000C6DEC600000000008484840000000000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00848484008484
      8400FFFFFF000000000000000000000000000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F7FFFF000000840000FF
      FF0000FFFF00000084000000000000FFFF00F7FFFF0000000000000000000000
      0000000000000000000000000000000000000000000084848400000000000000
      0000C6DEC6000000000000000000000000000000000084848400000000008484
      8400000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00848484000000
      0000FFFFFF00000000000000000000000000000000008484840000000000FFFF
      FF00FFFFFF00FFFFFF00000000000000000084848400F7FFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000C6DEC6000000000000000000F7FFFF0000FFFF000000
      840000FFFF0000FFFF00848484000000000000FFFF00F7FFFF00000000000000
      0000000000000000000000000000000000008484840000000000C6DEC6000000
      00000000000000000000848484008484840000000000C6DEC600848484000000
      0000848484000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000008484840000000000FFFF
      FF00FFFFFF0000000000C6DEC6000000840000FFFF0084848400F7FFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000FFFF000000
      000000FFFF00C6DEC60000FFFF00000084000000000000FFFF00F7FFFF000000
      0000000000000000000000000000000000000000000084848400FFFFFF00FFFF
      FF00C6DEC6008484840084008400000084008484840000000000C6DEC6008484
      8400000000008484840000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00848484000000
      0000FFFFFF00000000000000000000000000000000008484840000000000FFFF
      FF000000000000FFFF00000084000000FF008400840000FFFF0084848400FFFF
      FF00FFFFFF000000000000000000000000000000000000000000F7FFFF0000FF
      FF000000840000FFFF00C6DEC60000FFFF00000000000000000000FFFF00F7FF
      FF00000000000000000000000000000000000000000084848400848484008484
      8400848484000000840084008400000084008400840084848400000000000000
      0000848484000000000084848400000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00848484000000
      0000FFFFFF00FFFFFF0000000000000000000000000084848400000000000000
      000000FFFF0084008400000000000000FF000000FF000000840000FFFF008484
      8400FFFFFF0000000000000000000000000000000000000000000000000000FF
      FF000000000000FFFF00C6DEC600C6DEC60000FFFF00000084000000000000FF
      FF00F7FFFF000000000000000000000000000000000084848400848484008400
      84000000FF0000FFFF000084840084008400000084008400840084848400C6C6
      C600000000008484840000000000848484000000000000000000000000000000
      00000000000000000000848484000000000000000000FFFFFF00848484000000
      000084848400FFFFFF00FFFFFF00000000000000000084848400000000008484
      8400000084000000FF000000FF00000000000000FF0000000000000084000000
      00008484840000000000000000000000000000000000000000000000000000FF
      FF0000FFFF000000000000FFFF00F7FFFF00C6DEC60000FFFF00000084000000
      000000FFFF00F7FFFF000000000000000000000000008400840000FFFF000000
      00000000FF008484840000008400840084008400840084008400840084008484
      8400000000000000000000000000848484000000000000000000848484000000
      00000000000084848400000000008484840000000000FFFFFF00FFFFFF008484
      84000000000000000000FFFFFF00FFFFFF00000000008484840000000000FFFF
      FF00848484000000000084848400FFFFFF00000000000000FF00000000000000
      8400000000000000000000000000000000000000000000000000F7FFFF000000
      000000000000000000000000000000FFFF00C6DEC600C6DEC60000FFFF000000
      84000000000000FFFF00F7FFFF00000000008484840000000000840084000000
      FF00840084000000FF008400840000FFFF0000FFFF0000848400840084008400
      8400848484000000000000000000848484000000000000000000000000008484
      840084848400000000000000000084848400FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00848484008484840000000000FFFFFF00000000008484840000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000FF000000
      0000000084000000000000000000000000000000000000000000F7FFFF000000
      840000FFFF0000FFFF00C6DEC600C6DEC600C6DEC60000FFFF0000FFFF0000FF
      FF000000840084848400F7FFFF00C6C6C6000000000084848400000000008484
      84000000000000008400000000000000FF0000FFFF0000FFFF0000FFFF008400
      8400840084008484840000000000848484000000000000000000000000000000
      000000000000000000008484840000000000FFFFFF000000000084848400FFFF
      FF00FFFFFF008484840000000000FFFFFF00000000008484840000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      FF00000000000000840000000000000000000000000000000000F7FFFF000000
      000000FFFF0000FFFF00C6DEC600C6DEC60000FFFF0000000000000000000000
      00000000000000FFFF0000000000000000000000000000000000848484000000
      0000848484000000FF0084008400840084008400840000FFFF0000FFFF000000
      8400840084000000000084848400000000000000000000000000848484000000
      000000000000848484000000000000000000FFFFFF0000000000848484008484
      8400848484008484840000000000FFFFFF00000000008484840000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      00000000FF0000000000000084000000000000000000000000000000000000FF
      FF000000000000FFFF0000FFFF00C6DEC600C6DEC600848484000000000000FF
      FF0000FFFF000000000000000000000000000000000000000000000000008484
      84000000000084848400848484000084840000FFFF0000FFFF00000084008400
      8400000000008484840000000000000000000000000000000000848484008484
      840000000000000000008484840000000000FFFFFF00FFFFFF00000000000000
      00000000000000000000FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000840000000000000000000000000000000000F7FF
      FF0000FFFF000000000000FFFF00C6DEC600C6DEC60000FFFF00848484000000
      000000FFFF0000FFFF0000000000000000000000000000000000000000000000
      00008484840000000000848484000000FF008400840000008400000000000000
      0000848484000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F7FFFF0000FFFF000000840000FFFF00C6DEC600C6DEC60000FFFF008484
      84000000000000FFFF00F7FFFF00000000000000000000000000000000000000
      0000000000008484840000000000000000000000000000000000848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000F7FFFF0000FFFF000000840000FFFF00C6DEC600F7FFFF0000FF
      FF008484840000008400F7FFFF00000000000000000000000000000000000000
      0000000000000000000084848400848484008484840084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000F7FFFF0000FFFF000000840000000000000000000000
      00000000840000FFFF0000000000000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840000000000000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840000000000000000000000000000000000000000008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840000000000000000000000000000000000000000000000
      0000000000008484840084848400848484008484840084848400848484000000
      0000000000000000000000000000000000000000000084848400848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400000000000000000084848400848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400000000000000000000000000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400000000000000000000000000000000008484
      8400848484008400000084840000848400008484000084000000840000008484
      840084848400000000000000000000000000000000008484840000000000C6DE
      C600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC600C6DEC6000000000000000000000000008484840000000000C6DE
      C600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC600C6DEC6000000000000000000000000008484840000000000C6C6
      C600C6C6C600C6C6C600C6C6C600840000000000000084000000C6C6C600C6C6
      C600C6C6C600C6C6C60000000000848484000000000000000000848484008400
      0000848400008484000084840000848400008484000084840000848400008484
      00008400000084848400C6DEC60000000000000000008484840000000000FF00
      0000FF000000FF000000FF000000FF0000008484840084848400848484008484
      8400848484008484840000000000000000000000000084848400000000008484
      840084848400848484008484840084848400FF0000008484000084840000FF00
      0000FF000000FF0000000000000000000000000000008484840000000000C6C6
      C6008484000084840000840000000000000000FFFF0000000000840000008484
      000084840000C6C6C60000000000848484000000000084848400848484000000
      0000848400008484000084840000848400008484000084840000848400008484
      000084840000000000008484840000000000000000008484840000000000FF00
      0000F7FFFF00C6C6C600F7FFFF00FF00000084848400C6DEC600C6DEC600C6DE
      C600000000008484840000000000000000000000000084848400000000008484
      8400C6DEC600C6DEC600848484008484840084840000F7FFFF00C6DEC600F7FF
      FF00F7FFFF008484000000000000000000000000000084848400000000008484
      000084840000840000000000000000FFFF0000FFFF0000FFFF00000000008400
      00008484000084840000000000008484840000000000848484000084000000FF
      0000000000008484000084840000848400008484000084840000848400008484
      0000848400008484000084848400C6DEC6000000000084848400000000008484
      000084840000FF000000FF000000FF000000848484000000000084848400C6DE
      C600848484008484840000000000000000000000000084848400000000008484
      840084848400848484008484840084848400FF000000F7FFFF00FF000000C6DE
      C600848400008484000000000000000000000000000084848400000000008484
      0000840000000000000000000000000000000000000000000000000000000000
      0000840000008484000000000000848484008484840000840000008400000084
      0000008400000000000084840000848400008484000084840000848400008484
      000084840000000000000084000084848400000000008484840000000000FF00
      0000F7FFFF00F7FFFF00F7FFFF00FF00000084848400C6DEC600C6C6C600C6DE
      C600C6C6C6008484840000000000000000000000000084848400000000008484
      84000000000000000000C6C6C6008484840084840000F7FFFF00F7FFFF00F7FF
      FF00C6C6C6008484000000000000000000000000000084848400000000008400
      00000000000000FFFF0000000000C6C6C600C6C6C600848400000000000000FF
      FF00000000008400000000000000848484008484840000840000008400000084
      0000008400000084000084848400848400008484000084840000848400008484
      0000848400000000000000840000848484000000000084848400000000008484
      0000F7FFFF00F7FFFF00C6C6C600FF000000848484000000000084848400C6DE
      C600848484008484840000000000000000000000000084848400000000008484
      840000000000C6DEC600C6C6C60084848400FF000000C6DEC600FF000000C6DE
      C600848400008484000000000000000000000000000084848400000000000000
      000000FFFF0000FFFF0000000000C6C6C60084840000848400000000000000FF
      FF0000FFFF000000000000000000848484008484840000FF0000008400000000
      0000848400000000000084840000000000000084000084000000848400008484
      0000848400008484000000840000848484000000000084848400000000008484
      0000F7FFFF00F7FFFF00F7FFFF00FF00000084848400C6DEC60000000000C6DE
      C600C6C6C6008484840000000000000000000000000084848400000000008484
      8400C6DEC600C6DEC600C6C6C6008484840084840000F7FFFF00F7FFFF00C6C6
      C600F7FFFF008484000000000000000000000000000084848400000000008400
      00000000000000FFFF00000000008484000084840000848400000000000000FF
      FF00000000008400000000000000848484008484840000FF0000008400000084
      000084848400C6DEC60084848400008400000084000000840000008400000000
      0000840000000000000000840000848484000000000084848400000000008484
      0000C6C6C600F7FFFF00C6C6C600FF00000084848400C6DEC60084848400C6DE
      C600848484008484840000000000000000000000000084848400000000008484
      84000000000000000000C6C6C60084848400FF000000F7FFFF0084840000F7FF
      FF0084840000FF00000000000000000000000000000084848400000000008484
      0000840000000000000000000000000000000000000000000000000000000000
      0000840000008484000000000000848484008484840000FF0000008400000084
      000000840000C6DEC60084848400008400000084000000840000008400000084
      0000008400000084000000FF0000848484000000000084848400000000008484
      0000F7FFFF00F7FFFF00F7FFFF00FF00000084848400C6DEC600C6DEC600C6DE
      C600C6DEC6008484840000000000000000000000000084848400000000008484
      8400C6DEC600F7FFFF00C6C6C6008484840084840000C6DEC600F7FFFF00C6C6
      C600F7FFFF008484000000000000000000000000000084848400000000008484
      000084840000840000000000000000FFFF0000FFFF0000FFFF00000000008400
      0000848400008484000000000000848484008484840000840000008400000084
      000000840000C6DEC600C6DEC600840000000084000000840000008400000084
      000000840000008400000084000084848400000000008484840000000000FF00
      0000FF000000FF000000FF000000FF0000008484840084848400848484008484
      8400848484008484840000000000000000000000000084848400000000008484
      840084848400848484008484840084848400FF000000FF000000FF0000008484
      0000848400008484000000000000000000000000000084848400000000008484
      00008484000084840000840000000000000000FFFF0000000000840000008484
      000084840000848400000000000084848400C6C6C6008484840000FF00000084
      000000000000C6DEC600C6DEC600000000000084000000840000008400000084
      00000084000000FF00008484840000000000000000008484840000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000000000000000000008484840000000000FFFF
      FF00FFFFFF00FFFFFF00F7FFFF00F7FFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000084848400000000008484
      0000848400008484000084840000840000000000000084000000848400008484
      0000848400008484000000000000848484000000000084848400848484008484
      8400C6DEC600C6DEC60084840000008400000084000000840000008400000084
      0000008400000084000084848400000000000000000084848400000000008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840000000000000000000000000084848400000000008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840000000000000000000000000000000000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400000000000000000000000000848484008484
      840084840000C6DEC600000000000084000000840000008400000084000000FF
      0000008400008484840000000000000000000000000000000000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840000000000000000000000000000000000000000008484
      84008484840084840000848400000000000000FF000000FF0000008400008484
      8400848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000008484840084848400848484008484840084848400848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000848484008484840000FF
      FF00C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C60000FF
      FF0000FFFF00C6C6C600C6C6C600C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840000000000000000000000000084848400C6DEC600C6DE
      C600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC600C6DEC600C6DEC600000000000000000000000000848484008484
      840000FFFF0000FFFF00C6C6C600C6C6C600C6C6C60000FFFF0000FFFF000000
      00000000000000FFFF00C6C6C600C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008484000000000000000000000000000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400000000000000000084848400C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600000000008484840000000000000000008484
      84008484840000FFFF0000FFFF00C6C6C60000FFFF0000FFFF00000000000084
      84000000000000FFFF00C6C6C600C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000084
      840000FFFF000000000084840000848400000000000000000000000084000000
      8400000084000000840000008400000084000000840000008400000084000000
      8400000084000000840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0084848400000000000000
      0000848484000000000000FFFF0000FFFF0000FFFF000000000000FFFF0000FF
      FF000000000000FFFF00C6C6C600C6C6C6008484000084840000848400008484
      00008484000000000000000000000000000000000000000000000084840000FF
      FF0000FFFF000000000000000000000000000000000000000000000084000000
      FF00000084000000840000008400000084000000840000008400000084000000
      8400000084000000840000000000000000000000000084848400FFFFFF00C6DE
      C600000000000000000000000000000000000000000000000000000000000000
      00008484840084848400C6C6C60000000000C6C6C60000FFFF00848484000000
      0000000000008484840000000000000000000000000000FFFF0000FFFF000084
      84000000000000FFFF00C6C6C600C6C6C60084840000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000084840000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF00000000000000000000000000000084000000
      FF00000084000000840000008400000084000000840000008400000084000000
      8400000084000000FF0000000000000000000000000084848400C6DEC6000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084848400C6C6C60000000000C6C6C600C6C6C60000FFFF008484
      840000000000000000000000000000000000FFFFFF00FFFFFF0000FFFF000084
      84000000000000FFFF00C6C6C600C6C6C60084840000FFFFFF00000000000000
      0000FFFFFF0000000000000000000000000000848400FFFFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF00000000000000000000000000000084000000
      84000000FF0000008400000084000000FF000000000000008400000084000000
      84000000FF000000FF0000000000000000000000000000000000000000000000
      0000000000008484840084848400848484008484840084848400848484000000
      000000000000000000000000000000000000C6C6C600C6C6C60000FFFF0000FF
      FF00000000000000000000000000C6C6C60000000000FFFFFF0000FFFF000000
      84000000000000FFFF0000FFFF00C6C6C60084840000FFFFFF00000000000084
      8400000000000000000000000000000000000000000000848400FFFFFF0000FF
      FF0000FFFF0000FFFF0000FFFF00000000000000000000000000000084000084
      84000000FF000000FF000000FF0000000000000000000000FF000000FF000000
      FF000000FF000084840000000000000000000000000084848400000000000000
      000000000000F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF000000
      000000000000000000008484840000000000C6C6C60000FFFF0000FFFF000000
      0000FFFFFF0000000000C6C6C600C6C6C60000000000FFFFFF0000FFFF0000FF
      FF00000084000000000000FFFF0000FFFF0084840000848400000000000000FF
      FF000084840000000000000000000000000000000000000000000084840000FF
      FF0000FFFF0000FFFF0000FFFF00000000000000000000000000000084000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000840000000000000000000000000000000000000000000000
      000000000000C6DEC6008484000084840000FFFFFF0084840000848400000000
      000000000000000000000000000000000000C6C6C60000FFFF000000000000FF
      FF0000FFFF00FFFFFF000000000000000000FFFFFF00FFFFFF0000FFFF0000FF
      FF0000FFFF00008484000000000000FFFF0000000000000000000000000000FF
      FF0000FFFF000084840000000000000000000000000000000000000000000084
      840000FFFF00000000000000000000000000000000000000000000FFFF000084
      840000FFFF00FFFFFF0000FFFF0000FFFF0000FFFF0000FFFF000084840000FF
      FF0000FFFF000084840000000000000000000000000000000000000000000000
      000000000000C6DEC6008484000084840000FFFFFF0084840000848400000000
      000000000000000000000000000000000000C6C6C60000FFFF0000FFFF000000
      00000084840000FFFF00FFFFFF00FFFFFF00FFFFFF0000FFFF0000FFFF0000FF
      FF00008484000000000000FFFF0000FFFF000000000000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000848400000000000000000000000000000000000000
      00000084840000000000FFFFFF00FFFFFF0000000000000000000000840000FF
      FF0000FFFF0000FFFF000084840000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF00FFFFFF0000FFFF0000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      000000000000000000000000000000000000C6C6C600C6C6C60000FFFF0000FF
      FF0000FFFF00008484000084840000FFFF0000FFFF0000FFFF00000000000000
      000000FFFF0000FFFF0000FFFF00C6C6C6000000000000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF00FFFFFF00008484000000000000000000000000008484
      00000000000000000000FFFFFF00FFFFFF000000000000000000000084000000
      8400000084000084840000FFFF00FFFFFF000084840000FFFF0000FFFF000084
      8400000084000000840000000000000000000000000000000000000000000000
      000000000000C6DEC6008484000084840000FFFFFF0084840000848400000000
      000000000000000000000000000000000000C6C6C600C6C6C600C6C6C60000FF
      FF0000FFFF0000FFFF00000000000084840000FFFF00000084000000000000FF
      FF0000FFFF0000FFFF00C6C6C600C6C6C6000000000000FFFF0000FFFF0000FF
      FF0000FFFF00FFFFFF0000848400000000000000000000000000000000008484
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000084000000
      8400000084000000840000008400000084000000840000008400000084000000
      8400000084000000840000000000000000000000000000000000000000000000
      000000000000C6DEC6008484000084840000FFFFFF0084840000848400000000
      000000000000000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C60000FFFF0000FFFF0000000000008484000000000000FFFF0000FF
      FF00C6C6C600C6C6C600C6C6C600C6C6C6000000000000FFFF0000FFFF0000FF
      FF0000FFFF000084840000000000000000000000000000000000000000008484
      0000848400008484000084840000848400000000000084848400000000000000
      8400000084000000840000008400000084000000840000008400000084000000
      8400000084000000000084848400000000000000000000000000000000000000
      00000000000000000000C6DEC600FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      000000000000000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C60000FFFF0000FFFF000000000000FFFF0000FFFF00C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C60000000000000000000000000000FF
      FF00008484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000848484008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C60000FFFF0000FFFF0000FFFF00C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000000000000084
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848484008484840084848400848484008484840084848400848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C60000FFFF00C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C6C6C6008484840084848400848484008484
      840084848400C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000084000000FF000000
      FF000000FF000000FF0000000000848484008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C6C6C600C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840000000000000000000000000000000000000084000000
      FF000000FF000000FF000000FF00000000008484840084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C6C6C60000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840000000000000000000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400000000000000000000000000000000000000
      8400C6DEC6000000FF000000FF000000FF000000000084848400848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C6C6C60000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008484840000000000000000000000000000848400C6DE
      C600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC6000084840000000000000000000000000000000000000000000000
      000000008400C6DEC6000000FF000000FF000000FF0000000000848484008484
      8400000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C6000000000084848400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      00008484840000000000F7FFFF0000000000000000000000000000000000C6DE
      C600000000000000000000000000000000000000000000000000C6DEC600C6DE
      C600FFFFFF00FFFFFF00C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC600C6DEC60000000000000000000000000000000000000000000000
      00000000000000008400C6DEC600C6DEC6000000FF000000FF00000000008484
      84008484840000000000000000000000000000000000C6C6C600C6C6C6000000
      0000000000000000000000000000000000000000000084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      00008484840000000000C6DEC600000000008484840084848400848484000000
      0000000000000000000000000000000000000000000000000000C6DEC600FFFF
      FF00C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC600C6DEC60000000000000000000000000000000000000000000000
      0000000000000000000000008400C6DEC6008484840000000000000000000000
      00008484840084848400000000000000000000000000C6C6C60000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000084848400FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000848484000000000000000000848484000000000000000000000000008484
      8400000000000000000000000000000000000000000000000000C6DEC600FFFF
      FF00C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC600C6DEC60000000000000000000000000000000000000000000000
      00000000000000FF000000FF00000000840000000000F7FFFF00000000000000
      00000000000084848400000000000000000000000000C6C6C60000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000084848400FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      000084848400F7FFFF000000000084848400FFFFFF0084848400000000008484
      8400000000000000000000000000000000000000000000000000C6DEC600FFFF
      FF00C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC600C6DEC60000000000000000000000000000000000000000000000
      00000000000000FF0000FFFFFF00FFFFFF000000840000000000000000000000
      00000000000000000000848484000000000000000000C6C6C60000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000084848400FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000084848400F7FFFF0000000000848484008484840084848400000000008484
      8400000000000000000000000000000000000000000000000000C6DEC600FFFF
      FF00C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC600C6DEC60000000000000000000000000000000000000000000000
      00000000000000FF0000FFFFFF00008400000084000000000000F7FFFF00F7FF
      FF000000000000000000848484000000000000000000C6C6C60000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000084848400FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000C6C6C600C6DEC60084848400000000008484840084848400848484000000
      0000848484008484840000000000000000000000000000000000C6DEC600FFFF
      FF00C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC600C6DEC60000000000000000000000000000000000000000000000
      00000000000000FF0000FFFFFF000084000000FF000000000000000000008484
      84008484840000000000000000000000000000000000C6C6C60000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      840000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF008484840000000000000000000000000000000000C6DEC600FFFF
      FF00C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC6000084840000000000000000000000000000000000000000000000
      00000000000000FF0000FFFFFF000084000000FF000000840000000000000000
      00000000000000000000000000008484840000000000C6C6C60000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      000000000000000000000000000000000000000000000000000084848400FFFF
      FF00848484000000000000000000000000000000000000000000000000008484
      8400848484008484840000000000000000000000000000000000C6DEC600C6DE
      C600C6DEC600C6DEC600C6DEC600C6DEC6000084840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FF0000FFFFFF000084000000FF000000FF0000008400000000
      00000000000000000000000000008484840000000000C6C6C60000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6DE
      C600C6DEC600C6DEC600C6DEC600C6DEC6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FF0000FFFFFF000084000000FF000000FF000000FF000000FF
      00000084000084848400000000008484840000000000C6C6C60000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FF0000FFFFFF000084000000FF000000FF000000FF000000FF
      000000FF00000084000000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FF0000FFFFFF00008400000084000000840000008400000084
      0000008400000084000000840000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FF0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6DEC600C6DE
      C600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC6000000000000000000000000000000000000848400C6DEC600C6DE
      C600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600008484000000000000000000000000000000000000848400C6DEC600C6DE
      C600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600008484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6DEC6000000
      0000C6DEC60000000000C6DEC60000000000C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC60000000000000000000000000000000000C6DEC600C6DEC600FFFF
      FF00FFFFFF00C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC60000000000000000000000000000000000C6DEC600C6DEC600FFFF
      FF00FFFFFF00C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C6000000
      0000000000000000000000000000000000000000000000000000FFFFFF00C6DE
      C600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC60000000000000000000000000000000000C6DEC600FFFFFF00C6DE
      C600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC60000000000000000000000000000000000C6DEC600FFFFFF00C6DE
      C600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC6000000000000000000000000000000000000000000000000000000
      00000000000000000000C6C6C6008484840000000000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      0000F7FFFF0000000000C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC60000000000000000000000000000000000C6DEC600FFFFFF00C6DE
      C600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC60000000000000000000000000000000000C6DEC600FFFFFF00C6DE
      C600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC6000000000000000000000000000000000000000000000000000000
      000000000000C6C6C600C6DEC6000000000000000000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00F7FFFF00F7FFFF00C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC60000000000000000000000000000000000C6DEC600FFFFFF00C6DE
      C600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC6000000000000000000000000000000000000000000000000000000
      00000000000000000000C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC600000000000000000000000000000000000000000000000000C6C6
      C600C6DEC600C6DEC60000FFFF00000000000000000000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      0000FFFFFF0000000000C6DEC60000000000C6DEC60000000000C6DEC6000000
      0000C6DEC60000000000000000000000000000000000C6DEC600FFFFFF00C6DE
      C600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC6000000000000000000000000000000000084848400848484008484
      84008484840000000000C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC600000000000000000000000000000000000000000000000000F7FF
      FF0000FFFF0000FFFF0000FFFF00000000000000000084848400FFFFFF000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00F7FFFF00F7FFFF00C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC6000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC6000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6DE
      C600C6DEC600000000000000000000000000000000000000000000000000F7FF
      FF00FFFFFF0000FFFF0000FFFF00000000000000000084848400FFFFFF000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      0000FFFFFF0000000000FFFFFF0000000000F7FFFF00C6DEC600C6DEC600C6DE
      C600C6DEC6000000000000000000000000000000000084848400848484008484
      840084848400848484008484840000000000C6DEC600C6DEC600C6DEC600C6DE
      C6000084840000000000000000000000000000000000C6DEC600C6DEC6000000
      000084848400848484008484840084848400848484008484840000000000C6DE
      C60000848400000000000000000000000000000000000000000000000000C6C6
      C600F7FFFF00FFFFFF0000FFFF00000000000000000000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7FFFF00C6DEC600C6DE
      C600C6DEC6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C600F7FFFF000000000000000000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      0000FFFFFF0000000000FFFFFF0000000000FFFFFF0000000000C6DEC6000000
      0000C6DEC60000000000000000000000000000000000C6DEC600C6DEC600C6DE
      C600C6DEC600C6DEC600C6DEC600000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF000000
      0000C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C6C6C6008484840000000000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7FFFF00F7FFFF000000
      0000C6DEC60000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C6000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      0000FFFFFF0000000000FFFFFF0000000000FFFFFF00F7FFFF00000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7FFFF00000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7FFFF00000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00000000000000
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
      0000848484008484840084848400848484008484840084848400848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000848484008484840084848400848484008484840084848400848484008484
      8400000000000000000000000000000000000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000848484000000000000000000000000008484
      8400000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484000000000000000000000000008484840000000000C6DEC600C6DE
      C600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC600C6DEC600C6DEC600000000000000000000000000000000008484
      840000000000F7FFFF00C6DEC600C6DEC60000000000C6C6C600C6C6C600C6C6
      C60000000000000000000000000000000000000000000000000000000000C6C6
      C60000000000F7FFFF00C6DEC600C6DEC60000000000C6C6C600C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400848484000000000000000000000000000000000000000000000000000000
      0000848484000000000000000000000000008484840000000000C6DEC6000000
      0000000000000000000000000000C6DEC60000000000C6DEC600C6DEC600C6DE
      C6000000000000000000C6DEC600000000000000000000000000000000008484
      840000000000FFFFFF00C6DEC600C6DEC600C6DEC60000000000C6C6C600C6C6
      C60000000000000000000000000000000000000000000000000000000000C6C6
      C60000000000FFFFFF00F7FFFF00C6DEC600C6DEC60000000000C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      84008484840000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000848484000000000000000000000000008484840000000000C6DEC6000000
      0000C6DEC600C6DEC60000000000C6DEC60000000000C6DEC600C6DEC6000000
      0000C6DEC600C6DEC600C6DEC600000000000000000000000000000000008484
      840000000000FFFFFF00C6DEC6000000000000000000C6DEC60000000000C6C6
      C60000000000000000000000000000000000000000000000000000000000C6C6
      C60000000000FFFFFF00FFFFFF00F7FFFF00C6DEC600C6DEC60000000000C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      84008484840000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000848484000000000000000000000000008484840000000000C6DEC600C6DE
      C600000000000000000000000000C6DEC60000000000C6DEC600C6DEC6000000
      0000C6DEC600C6DEC600C6DEC600000000000000000000000000000000008484
      840000000000FFFFFF00C6DEC6000000000000000000F7FFFF00C6DEC6000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C60000000000FFFFFF00FFFFFF00FFFFFF00F7FFFF00F7FFFF00C6DEC6000000
      0000000000000000000000000000000000000000000000000000000000008484
      84008484840000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000848484000000000000000000000000008484840000000000C6DEC600C6DE
      C600C6DEC600C6DEC60000000000C6DEC60000000000C6DEC600C6DEC6000000
      0000C6DEC600C6DEC600C6DEC600000000000000000000000000000000008484
      840000000000FFFFFF00FFFFFF00C6DEC60000000000F7FFFF00F7FFFF00F7FF
      FF0000000000000000000000000000000000000000000000000000000000C6C6
      C60000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7FFFF00F7FFFF00F7FF
      FF00000000000000000000000000000000000000000000000000000000008484
      84008484840000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000848484000000000000000000000000008484840000000000C6DEC600C6DE
      C6000000000000000000C6DEC600C6DEC600C6DEC6000000000000000000C6DE
      C6000000000000000000C6DEC600000000000000000000000000000000008484
      840000000000FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00F7FFFF00C6DE
      C60000000000000000000000000000000000000000000000000000000000C6C6
      C60000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7FFFF00C6DE
      C600000000000000000000000000000000000000000000000000000000008484
      84008484840000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000848484000000000000000000000000008484840000000000C6DEC600C6DE
      C600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC600C6DEC600C6DEC600000000000000000000000000000000008484
      840000000000FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00C6DE
      C60000000000000000000000000000000000000000000000000000000000C6C6
      C60000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6DE
      C600000000000000000000000000000000000000000000000000000000008484
      84008484840000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000848484000000000000000000000000008484840000000000C6DEC600C6DE
      C600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC600C6DEC60000848400000000000000000000000000000000008484
      840000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6DEC600C6DEC600C6DE
      C60000000000000000000000000000000000000000000000000000000000C6C6
      C60000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6DEC600C6DEC600C6DE
      C600000000000000000000000000000000000000000000000000000000008484
      84008484840000000000FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000848484000000000000000000000000000000000000000000C6C6C600C6DE
      C600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      840000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6DEC600000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C60000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6DEC600000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      84008484840000000000FFFFFF00FFFFFF00FFFFFF0000000000848484008484
      840084848400000000000000000000000000000000000000000000000000C6C6
      C600C6DEC600C6DEC600C6DEC600C6DEC600C6C6C60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      840000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6DEC60000000000FFFF
      FF0000000000000000000000000000000000000000000000000000000000C6C6
      C60000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6DEC600000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      84008484840000000000FFFFFF00FFFFFF00FFFFFF0000000000848484000000
      0000848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      840000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6DEC600000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C60000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6DEC600000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400848484000000000000000000000000000000000000000000848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848484008484840084848400848484008484840084848400848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484000000
      00000084000000FF000000FF0000848484008484840084848400848484008484
      8400C6DEC600C6DEC60000000000000000000000000000000000000000000000
      00000000000000000000848484000000000000840000C6DEC600000000000000
      0000000000000000000000000000000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840000000000000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840000000000000000000000000000000000848484008484
      84000000000000FF000000FF000000FF0000848484008484840084848400C6DE
      C600C6DEC6000000000000000000000000000000000000000000000000000000
      00000000000084848400848484000000000000FF0000C6DEC600000000000000
      0000000000000000000000000000000000000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400000000000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400000000000000000000000000000000008484
      8400000000000000000000FF000084848400848484008484840084848400C6DE
      C600C6DEC6000000000000000000000000000000000000000000000000000000
      00000000000084848400000000000084000084848400C6DEC600C6DEC6000000
      000000000000000000000000000000000000848484000000000000848400C6DE
      C600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC600008484000000000000000000000000000000000000000000C6C6
      C6008484840084848400C6C6C600848484008484840084848400848484008484
      8400848484008484840000000000000000000000000000000000000000008484
      8400848484000000000000FF000000FF00008484840084848400C6DEC600C6DE
      C600000000000000000000000000000000000000000000000000000000000000
      000084848400848484000000000000FF000084848400C6DEC600C6DEC6000000
      0000000000000000000000000000000000008484840000000000C6DEC600C6DE
      C600FFFFFF00FFFFFF00C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC600C6DEC6000000000000000000000000000000000000000000C6DE
      C600F7FFFF00F7FFFF00C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC600C6DEC60000000000000000000000000000000000000000000000
      000084848400000000000000000000FF00008484840084848400C6DEC600C6DE
      C600000000000000000000000000000000000000000000000000000000000000
      000084848400000000000000000000FF00008484840084848400C6DEC600C6DE
      C600000000000000000000000000000000008484840000000000C6DEC600FFFF
      FF00C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC600C6DEC6000000000000000000000000000000000000000000C6C6
      C600F7FFFF000000000000000000000000000000000000000000000000000000
      0000C6DEC600C6DEC60000000000000000000000000000000000000000000000
      000084848400848484000000000000FF000084848400C6DEC600C6DEC6000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400848484000000000000FF000000FF00008484840084848400C6DEC600C6DE
      C600000000000000000000000000000000008484840000000000C6DEC600FFFF
      FF00C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC600C6DEC6000000000000000000000000000000000000000000C6C6
      C600F7FFFF0000000000F7FFFF00F7FFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000C6DEC600C6DEC60000000000000000000000000000000000000000000000
      00000000000084848400000000000084000084848400C6DEC600C6DEC6000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400000000000000000000FF000084848400848484008484840084848400C6DE
      C600C6DEC6000000000000000000000000008484840000000000C6DEC600FFFF
      FF00C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC600C6DEC6000000000000000000000000000000000000000000C6C6
      C600F7FFFF000000000000000000C6C6C600C6DEC600F7FFFF00FFFFFF000000
      0000C6DEC600C6DEC60000000000000000000000000000000000000000000000
      00000000000084848400848484000000000000FF0000C6DEC600000000000000
      0000000000000000000000000000000000000000000000000000848484008484
      84000000000000FF000000FF000000FF0000848484008484840084848400C6DE
      C600C6DEC6000000000000000000000000008484840000000000C6DEC600FFFF
      FF00C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC600C6DEC600000000000000000000000000C6C6C60000000000C6DE
      C600F7FFFF0000000000C6C6C600C6C6C600C6C6C600C6C6C600F7FFFF000000
      0000C6DEC600C6DEC60000000000000000000000000000000000000000000000
      00000000000000000000848484000000000000840000C6DEC600000000000000
      0000000000000000000000000000000000000000000000000000848484000000
      00000084000000FF000000FF0000848484008484840084848400848484008484
      8400C6DEC600C6DEC60000000000000000008484840000000000C6DEC600FFFF
      FF00C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC600C6DEC60000000000000000000000000000000000000000008484
      8400F7FFFF000000000084840000C6C6C600C6C6C60000000000F7FFFF000000
      0000C6DEC600C6DEC60000000000000000000000000000000000000000000000
      0000000000000000000084848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000C6DEC600FFFF
      FF00C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC60000848400000000000000000000000000C6C6C60000000000C6DE
      C600F7FFFF000000000000000000000000000000000000000000000000000000
      0000C6DEC600C6DEC60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6DEC600C6DE
      C600C6DEC600C6DEC600C6DEC600C6DEC6000084840000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C600F7FFFF00F7FFFF00C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC600C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6DE
      C600C6DEC600C6DEC600C6DEC600C6C6C6000000000000000000000000000000
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
      0000000000000000000000000000000000000000000084000000840000008400
      0000000000000000000000000000000000000000000084000000840000008400
      0000000000000000000000000000000000000000000000000000000000008400
      0000840000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008400000084000000840000000000
      0000000000000000000000000000000000008400000084000000840000000000
      0000000000000000000000000000000000008400000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084000000FFFFFF008400
      0000000000000000000000000000000000000000000084000000FFFFFF008400
      0000000000000000000000000000000000000000000000000000000000008400
      0000FFFFFF008400000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084000000FFFFFF00840000000000
      00000000000000000000000000000000000084000000FFFFFF00840000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084000000FFFFFF008400
      0000000000000000000000000000000000000000000084000000FFFFFF008400
      0000000000000000000000000000000000000000000000000000000000008400
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008400000084000000000000000000
      0000000000000000000000000000000000008400000084000000000000000000
      0000000000000000000000000000000000008400000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084000000840000000000
      0000000000000000000000000000000000000000000084000000840000000000
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
      0000000000000000000000000000000000008400000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084000000840000008400
      0000000000000000000000000000000000000000000084000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008400000084000000840000000000
      0000000000000000000000000000000000008400000084000000840000000000
      0000000000000000000000000000000000008400000084000000840000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084000000FFFFFF008400
      0000000000000000000000000000000000000000000084000000FFFFFF008400
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084000000FFFFFF00840000000000
      00000000000000000000000000000000000084000000FFFFFF00840000000000
      00000000000000000000000000000000000084000000FFFFFF00840000000000
      0000000000000000000000000000000000008400000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084000000FFFFFF008400
      0000000000000000000000000000000000000000000084000000FFFFFF008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008400000084000000000000000000
      0000000000000000000000000000000000008400000084000000000000000000
      0000000000000000000000000000000000008400000084000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084000000840000000000
      0000000000000000000000000000000000000000000084000000840000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008400000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084000000840000008400
      0000000000000000000000000000000000000000000084000000840000008400
      0000000000000000000000000000000000000000000084000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008400000084000000840000000000
      0000000000000000000000000000000000008400000084000000840000000000
      0000000000000000000000000000000000008400000084000000840000008400
      0000840000008400000084000000840000008400000084000000840000008400
      0000840000008400000084000000840000000000000084000000FFFFFF008400
      0000000000000000000000000000000000000000000084000000FFFFFF008400
      0000000000000000000000000000000000000000000084000000FFFFFF008400
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084000000FFFFFF00840000000000
      00000000000000000000000000000000000084000000FFFFFF00840000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084000000FFFFFF008400
      0000000000000000000000000000000000000000000084000000FFFFFF008400
      0000000000000000000000000000000000000000000084000000840000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008400000084000000000000000000
      0000000000000000000000000000000000008400000084000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084000000840000000000
      0000000000000000000000000000000000000000000084000000840000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840000000000000000000000000000000000000000000000
      00000000000000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000840000008400000084
      00000084000000000000C6C6C60000000000000000000000000000000000C6C6
      C600000000000000000000000000C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008484840000000000FFFF
      FF00000000000000000000000000FFFFFF00C6DEC600FFFFFF00000000000000
      000000000000FFFFFF0000000000000000000000000084848400848484008484
      84008484840000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008484840000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00000000000000000000000000C6DEC600C6DEC600C6DE
      C600C6DEC60000000000C6C6C60000000000000000000000000000000000C6C6
      C600000000000000000000000000C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008484840000000000FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00000000000000
      000000000000FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484000000
      0000000000000000000000000000848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000840000008400
      000084000000840000000000000000000000000000008484840000000000FFFF
      FF000000000000FFFF0000000000FFFFFF00C6DEC600FFFFFF000000000000FF
      FF0000000000FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000C6C6C60000000000000000000000000000000000C6C6
      C600000000000000000000000000C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000084
      0000008400000084000000840000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084000000FFFF
      FF00FFFFFF00840000000000000000000000000000008484840000000000FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00000000000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      00000000000000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400848484008484840084848400000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084000000FFFF
      FF00FFFFFF00840000000000000000000000000000008484840000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6DE
      C600C6DEC600C6DEC600C6DEC600000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084000000FFFF
      FF0084000000840000000000000000000000000000008484840000000000FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00000000000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      00000000000000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6008484840000000000000000000000
      000000000000848484000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000840000008400
      000084000000000000000000000000000000000000008484840000000000FFFF
      FF000000000000FFFF0000000000FFFFFF00C6DEC600FFFFFF000000000000FF
      FF0000000000FFFFFF0000000000000000000000000000840000008400000084
      00000084000000000000C6C6C60000000000000000000000000000000000C6C6
      C600000000000000000000000000C6C6C6000000000000840000008400000084
      000000840000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008484840000000000FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00000000000000
      000000000000FFFFFF0000000000000000000000000084848400848484008484
      84008484840000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6000000000084848400848484008484
      8400848484000000000000000000000000000000000000000000848484000000
      0000000000000000000000000000848484000000000000000000840000008400
      0000840000008400000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008484840000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00000000000000000000000000C6DEC600C6DEC600C6DE
      C600C6DEC60000000000C6C6C60000000000000000000000000000000000C6C6
      C600000000000000000000000000C6C6C60000000000C6DEC600C6DEC600C6DE
      C600C6DEC6000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084000000FFFF
      FF00FFFFFF008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400000000000000
      00000000000000000000C6C6C600C6C6C600C6C6C600C6C6C600000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C60000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084000000FFFF
      FF00FFFFFF008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400000000000000
      0000848484000000000084848400000000008484840084848400000000008484
      84000000000084848400000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000C6C6C60000000000000000000000000000000000C6C6
      C600000000000000000000000000C6C6C60000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084000000FFFF
      FF00840000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400000000000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6008484840000000000000000000000
      0000000000008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000840000008400
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FF0000C6C6C600C6C6C600C6C6C6000000
      000000FF0000C6C6C600C6C6C600C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840000000000000000000000000000000000848484000000
      00000000000000000000000000000000000000000000C6DEC600848484008484
      840084848400848484008484840000FF0000C6C6C600C6C6C600000000008484
      8400C6DEC60000FF0000C6C6C600C6C6C600C6C6C600FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840000000000000000000000000000000000848484000000
      000000000000000000000000000000000000C6C6C60000000000C6DEC6008484
      8400848484008484840000FF0000C6C6C600C6C6C600C6C6C600000000008484
      8400C6DEC60000FF0000C6C6C600C6C6C600C6C6C600FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840000000000000000000000000000000000848484000000
      000000000000000000000000000000000000C6C6C60000000000C6DEC6008484
      8400848484008484840000FF0000C6C6C600C6C6C60000000000848484008484
      840084848400C6DEC60000FF0000C6C6C600C6C6C600FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840000000000000000000000000000000000848484000000
      000000000000000000000000000000000000C6C6C600C6C6C60000000000C6DE
      C6008484840000FF0000C6C6C600C6C6C600C6C6C60000000000848484008484
      840084848400C6DEC60000FF0000C6C6C600C6C6C600FFFFFF00FFFFFF000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000008484
      8400000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000848484000000000000000000000000000000000000000000000000008484
      840000000000000000000000000000000000C6C6C600C6C6C60000000000C6DE
      C6008484840000FF0000C6C6C600C6C6C6000000000084848400848484008484
      84008484840084848400C6DEC60000FF0000C6C6C600FFFFFF00FFFFFF000000
      00000000000000000000FFFFFF0000000000FFFFFF00FFFFFF00000000008484
      84000000000000000000000000000000000000000000FFFFFF00C6C6C6000000
      0000C6C6C600FFFFFF0000000000000000000000000000000000FFFFFF00C6C6
      C60000000000C6C6C600FFFFFF00000000000000000000000000000000008484
      8400000000000000000000000000000000000000000000000000000000000000
      000084848400000000000000000000000000C6C6C600C6C6C600C6C6C6000000
      000000FF0000C6C6C600C6C6C600C6C6C6000000000000000000000000000000
      000000000000000000000000000000FF0000C6C6C600FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000FFFFFF00FFFFFF00000000008484
      84000000000000000000000000000000000000000000FFFFFF00000000008484
      840000000000FFFFFF0000000000000000000000000000000000FFFFFF000000
      00008484840000000000FFFFFF00000000000000000000000000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000848484000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00000000008484
      84000000000000000000000000000000000000000000FFFFFF00C6C6C6000000
      0000C6C6C600FFFFFF0000000000000000000000000000000000FFFFFF00C6C6
      C60000000000C6C6C600FFFFFF00000000000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008484840000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000FFFFFF00FFFFFF00000000008484
      84000000000000000000000000000000000000FF000000000000FFFFFF00FFFF
      FF00FFFFFF000000000000FF0000000000000000000000FF000000000000FFFF
      FF00FFFFFF00FFFFFF000000000000FF00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C60000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      0000000000000000000000000000C6C6C600C6C6C600FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000FF0000000000000000
      00000000000000FF00000000000000000000000000000000000000FF00000000
      0000000000000000000000FF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C60000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      0000C6DEC600C6DEC600C6DEC600C6DEC600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600000000000000000000000000FFFFFF000000
      000000000000000000000000000000000000000000000000000000FF000000FF
      000000FF000000000000000000000000000000000000000000000000000000FF
      000000FF000000FF00000000000000000000000000008484840000000000C6DE
      C600C6DEC60000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000C6DE
      C600C6DEC6000000000084848400000000000000000000000000000000000000
      000000000000C6C6C600C6C6C600C6C6C600C6C6C60000000000C6C6C600C6C6
      C60000000000C6DEC600C6DEC600C6DEC6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484000000
      00000000000000000000848484008484840084848400FFFFFF00000000000000
      00000000000084848400000000000000000000000000C6DEC600C6DEC600C6DE
      C60000000000C6C6C6000000000000000000000000000000000000000000C6C6
      C600C6C6C60000000000C6DEC600C6DEC6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008484840000000000FFFFFF00FFFFFF00FFFFFF0084848400000000008484
      84000000000000000000000000000000000000000000C6DEC600C6DEC600C6DE
      C60000000000C6C6C600C6C6C600C6C6C600C6C6C60000000000C6C6C600C6C6
      C600C6C6C600C6C6C60000000000C6DEC6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF008484840084848400000000000000
      000000000000000000000000000000000000C6C6C60000000000C6DEC6000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C600C6C6C60000000000C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C6008484840084848400C6C6C600848484008484840084848400848484008484
      8400848484008484840000000000000000008484840084848400848484008484
      8400848484008484840084848400848484000000000000000000000000000000
      00000000000000000000000000000000000084848400848484000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0000000000000000000000000000848400C6DEC600C6DE
      C600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C60000848400000000000000000000000000000000000000000000000000C6DE
      C600F7FFFF00F7FFFF00C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC600C6DEC60000000000000000008484840000000000000000000000
      000000000000000000000000000084848400000000000000FF000000FF000000
      00000000000000000000000000000000000084848400000000000000FF000000
      FF000000FF00000000000000000084848400000000000000FF000000FF000000
      FF000000FF000000FF00000000000000000000000000C6DEC600C6DEC600FFFF
      FF00FFFFFF00C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC600000000000000000000000000000000000000000000000000C6C6
      C600F7FFFF000000000000000000000000000000000000000000000000000000
      0000C6DEC600C6DEC60000000000000000008484840000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF000000FF000000
      FF000000FF00000000000000000000000000848484000000FF000000FF000000
      FF000000000000000000000000000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000000000000000C6DEC600FFFFFF00C6DE
      C600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC600000000000000000000000000000000000000000000000000C6C6
      C600F7FFFF0000000000F7FFFF00F7FFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000C6DEC600C6DEC60000000000000000008484840000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0000000000000000000000FF000000FF000000FF000000
      000000000000000000000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF0000000000C6DEC600FFFFFF00C6DE
      C600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC600000000000000000000000000000000000000000000000000C6C6
      C600F7FFFF000000000000000000C6C6C600C6DEC600F7FFFF00FFFFFF000000
      0000C6DEC600C6DEC60000000000000000008484840000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0000000000000000000000FF000000FF000000FF000000
      000000000000000000000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF0000000000C6DEC600FFFFFF00C6DE
      C600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC60000000000000000000000000000000000C6C6C60000000000C6DE
      C600F7FFFF0000000000C6C6C600C6C6C600C6C6C600C6C6C600F7FFFF000000
      0000C6DEC600C6DEC60000000000000000008484840000000000000000000000
      0000000000000000FF000000FF00C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C6000000FF000000FF00000000000000FF000000FF000000FF000000
      0000000000000000FF000000FF000000FF000000FF00C6C6C600C6C6C600C6C6
      C600C6C6C6000000FF000000FF000000FF0000000000C6DEC600FFFFFF00C6DE
      C600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC6000000000000000000000000000000000000000000000000008484
      8400F7FFFF000000000084840000C6C6C600C6C6C60000000000F7FFFF000000
      0000C6DEC600C6DEC60000000000000000008484840000000000000000000000
      0000000000000000FF000000FF00000000000000000000000000000000000000
      0000000000000000FF000000FF00000000000000FF000000FF000000FF000000
      0000000000000000FF000000FF000000FF000000000000000000000000000000
      0000000000000000FF000000FF000000FF0000000000C6DEC600FFFFFF00C6DE
      C600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC60000000000000000000000000000000000C6C6C60000000000C6DE
      C600F7FFFF000000000000000000000000000000000000000000000000000000
      0000C6DEC600C6DEC60000000000000000008484840000000000000000000000
      0000000000000000FF000000FF00000000000000000000000000000000000000
      0000000000000000FF000000FF00000000000000FF000000FF000000FF000000
      0000000000000000FF000000FF000000FF000000000000000000000000000000
      0000000000000000FF000000FF000000FF0000000000C6DEC600C6DEC600C6DE
      C600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C60000848400000000000000000000000000000000000000000000000000C6C6
      C600F7FFFF00F7FFFF00C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC600C6C6C60000000000000000008484840000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0000000000000000000000FF000000FF000000FF000000
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF0000000000C6DEC600C6DEC600C6DE
      C600C6DEC600C6DEC600C6DEC600C6DEC6000000000000000000000000000000
      0000000000008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000000000000000848484000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000C6DEC600C6DE
      C600C6DEC600C6DEC600C6DEC600000000000000000084848400000000000000
      0000000000008484840000000000848484000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      0000848484000000000000000000000000008484840000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF000000FF000000
      FF000000FF0000000000000000000000000084848400000000000000FF000000
      FF000000FF000000FF00000000000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484008484
      8400848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400848484008484
      8400000000000000000000000000000000008484840000000000000000000000
      000000000000000000000000000084848400000000000000FF000000FF000000
      00000000000000000000000000000000000084848400000000000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      0000848484000000000000000000000000008484840000000000000000000000
      0000000000000000000000000000848484000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000008484
      8400000000000000000084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484000000
      0000000000000000000000000000000000008484840084848400848484008484
      8400848484008484840084848400848484000000000000000000000000000000
      0000000000000000000000000000000000008484840084848400848484008484
      8400848484000000FF000000FF000000FF000000FF000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000848484000000000000000000000000000000
      0000000000000000000084848400000000000000000000000000848484000000
      0000000000000000000084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF000000FF000000
      000000000000000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000000000000000000000008484840084848400848484008484
      84008484840084848400848484008484840084848400C6C6C600C6C6C6000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484000000
      FF000000FF008484840084848400848484008484840084848400848484008484
      84000000FF000000FF0000000000000000000000000084848400848484000000
      FF000000FF008484840084848400848484008484840084848400848484008484
      84000000FF000000FF0084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400C6C6C6000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF0000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF000000FF000000FF000000000000000000848484000000FF000000
      FF000000FF000000FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C6000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000848400FFFF
      FF00008484000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000848484000000FF0000FF
      FF000000FF000000FF000000FF0000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C600000000000000FF000000000000000000848484000000FF00C6C6
      C6000000FF000000FF000000FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C6000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000008484840084848400848484008484
      8400000000000000000000000000000000008484840084848400008484000084
      8400008484000000000084848400848484000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF00C6C6
      C60000FFFF000000FF000000FF000000FF0000FFFF00C6C6C60000FFFF00C6C6
      C60084848400000000000000FF000000FF00000000000000FF000000FF0000FF
      FF00C6C6C6000000FF000000FF000000FF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF000000FF000000FF000000000000000000000000000000
      0000000000000000000084848400C6C6C600C6C6C600C6C6C600848484008484
      8400848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000848484000000000000000000000000000000
      000000000000000000000000000000000000848484000000FF000000FF0000FF
      FF00C6C6C60000FFFF000000FF000000FF000000FF0000FFFF00C6C6C60000FF
      FF0000000000848484000000FF000000FF00000000000000FF000000FF00C6C6
      C60000FFFF00C6C6C6000000FF000000FF000000FF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C6000000FF000000FF000000000000000000000000000000
      0000000000000000000084848400C6C6C600C6C6C60084848400C6C6C6008484
      8400848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000848484000000000000000000000000000000
      000000000000000000000000000000000000848484000000FF000000FF000000
      00000000000000000000000000000000FF000000FF000000FF00000000008484
      840000000000C6C6C6000000FF000000FF00000000000000FF000000FF0000FF
      FF00C6C6C60000FFFF00C6C6C6000000FF000000FF000000FF00C6C6C60000FF
      FF00C6C6C60000FFFF000000FF000000FF000000000000000000000000000000
      0000000000000000000084848400C6C6C60084848400C6C6C60084848400C6C6
      C600848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000848484000000000000000000000000000000
      000000000000000000000000000000000000848484000000FF000000FF008484
      8400848484008484840084848400848484000000FF000000FF000000FF008484
      84008484840000FFFF000000FF000000FF00000000000000FF000000FF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C6000000FF000000FF000000FF00C6C6
      C60000FFFF00C6C6C6000000FF000000FF000000000000000000000000000000
      0000000000008484840084848400848484008484840084848400848484008484
      8400848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000848484000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF000000FF000000FF000000
      FF0000FFFF00C6C6C6000000FF000000FF00000000000000FF000000FF0000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C6000000FF000000FF000000
      FF00C6C6C60000FFFF000000FF000000FF000000000000000000000000000000
      000084848400FFFFFF00C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C6008484840084848400000000000000000000000000000000000000
      00000000000000000000000000008484840000000000000000000000000000FF
      FF0000FFFF0000848400000000000000000000000000848484000000FF000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF00000000000000FF000000000000000000848484000000FF000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF00000000000000FF00000000000000000000000000000000000000
      000084848400FFFFFF00C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C60084848400000000000000000000000000000000000000
      0000000000000000000000000000000000008484840084848400848484000084
      84000084840000848400848484008484840000000000848484000000FF000000
      FF0000FFFF00C6C6C60000FFFF00C6C6C6008484840084848400848484000000
      FF000000FF000000FF000000FF000000000000000000848484000000FF000000
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60084848400848484000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      00000000000084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF000000000000000000000000000000000000000000848484000000
      FF000000FF0000FFFF00C6C6C600848484000000000000000000000000000000
      00000000FF000000FF0000000000000000000000000000000000848484000000
      FF000000FF00C6C6C60000FFFF00C6C6C6008484840000000000000000000000
      00000000FF000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00008484000000000000FFFF00008484000000
      000000FFFF000084840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF000000000000000000000000000000000000000000000000008484
      84000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000008484
      84000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000008484000000000000000000008484000000
      0000000000000084840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
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
      0000000000000000000000000000000000008484840084848400848484008484
      8400848484008484840084848400848484000000000000000000000000000000
      0000000000000000000000000000000000008484840084848400848484008484
      8400848484008484840084000000848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      000000000000000000000000000084848400000000000000FF000000FF000000
      0000000000000000000000000000000000008484840000000000000000000000
      0000000000008400000000FF0000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF000000FF000000
      FF000000FF000000000000000000000000008484840000000000000000000000
      00008400000000FF000000FF000000FF00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0000000000000000008484840000000000000000000000
      000000FF000000FF000000FF000000FF00008400000000000000000000000084
      8400008484000084840000848400000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF0000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0000000000000000008484840000000000000000008400
      000000FF000000FF000000FF000000FF00008400000084848400848484000084
      840000FFFF0000FFFF0000848400000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      0000000000000000FF000000FF00C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C6000000FF000000FF000000000084848400000000008400000000FF
      000000FF0000000000000000000000FF000000FF000084000000000000000000
      0000848484000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF000000FF000000FF000000FF000000FF00
      0000000000000000000000000000000000008484840000000000000000000000
      0000000000000000FF000000FF00000000000000000000000000000000000000
      0000000000000000FF000000FF0000000000848484000000000000FF000000FF
      00000000000000000000000000008484840000FF000000FF0000000000000000
      000084848400000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF00000000000000000000000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF00000000000000000000008484840000000000000000000000
      0000000000000000FF000000FF00000000000000000000000000000000000000
      0000000000000000FF000000FF000000000084848400000000000000000000FF
      00000000000000000000000000008484840000FF000000FF0000840000000000
      0000FF000000FF00000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF000000FF000000FF000000FF000000FF00
      0000000000000000000000000000000000008484840000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0000000000000000008484840000000000000000000000
      0000000000000000000000000000848484000000000000FF000000FF00008400
      0000FF000000FF000000FF000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0000000000000000008484840000000000000000000000
      000000000000000000000000000084848400000000000000000000FF000000FF
      000000000000FF000000FF000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF0000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF000000FF000000
      FF000000FF000000000000000000000000008484840000000000000000000000
      000000000000000000000000000084848400000000000000000000FF000000FF
      000084000000FF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      000000000000000000000000000084848400000000000000FF000000FF000000
      0000000000000000000000000000000000008484840000000000000000000000
      00000000000000000000000000008484840000000000000000000000000000FF
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      0000000000000000000000000000848484000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      0000000000000000000000000000848484000000000000000000000000000000
      000000FF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840084848400848484008484
      8400848484008484840084848400848484000000000000000000000000000000
      0000000000000000000000000000000000008484840084848400848484008484
      8400848484008484840084848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF000000FF0000000000C6C6
      C6000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000000000000000000000000000000000000000C6C6
      C6000000FF000000000000000000000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840000000000000000008484840084848400848484008484
      8400848484008484840084848400848484000000000000000000000000000000
      0000000000000000000000000000000000008484840084848400848484008484
      8400848484008484840084848400848484000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF00000000000000000000000000848484000000
      000000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF008484840000000000000000008484840000000000000000000000
      0000000000000000000000000000848484000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      0000000000000000000000000000848484000000000000FFFF0000FFFF000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000000000000000000000000000000000000000000000000000FF008484
      840000000000000000000000FF000000000000000000848484000000000000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C6000000000084848400000000008484840000000000000000000000
      0000000000000000000000000000848484000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      000000000000000000000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF008484
      840000000000000000000000FF000000FF00000000008484840000000000C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C600848484000000000084848400000000008484840000000000000000000000
      0000000000000000000000000000848484000000000000000000000000000084
      8400008484000084840000848400000000008484840000000000000000000000
      0000000000000000000000FFFF0000FFFF0000FFFF00000000000000000000FF
      FF0000FFFF0000FFFF0000000000000000008484840084848400848484008484
      8400848484008484840084848400000000000000FF000000FF000000FF008484
      840000000000000000000000FF000000FF008484840000000000C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00000000008484840084848400000000008484840000000000000000000000
      0000000000000000000000000000848484008484840084848400848484000084
      840000FFFF0000FFFF0000848400000000008484840000000000000000000000
      0000000000000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF000000000000000000000000000000FF000000FF000000
      00000000000000000000848484000000FF000000FF000000FF00000000000000
      0000848484000000000000000000000000008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      840000000000C6C6C60084848400000000008484840000000000000000000000
      0000000000000000000000000000848484000000000000000000000000000000
      0000848484000000000000000000000000008484840000000000000000000000
      00000000000000FFFF0000FFFF0000FFFF0000FFFF00000000000000000000FF
      FF0000FFFF0000FFFF0000FFFF0000000000000000000000FF000000FF000000
      000000000000000000000000FF000000FF000000FF0000000000848484008484
      8400000000000000000084848400848484008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      84008484840000FFFF0084848400000000008484840000000000000000000000
      0000000000000000000000000000848484000000000000000000000000000000
      0000848484000000000000000000000000008484840000000000000000000000
      00000000000000FFFF0000FFFF0000FFFF0000FFFF00000000000000000000FF
      FF0000FFFF0000FFFF0000FFFF0000000000000000000000FF000000FF000000
      0000000000000000FF000000FF000000FF008484840000000000000000000000
      000000000000000000000000FF000000FF00000000008484840000000000C6C6
      C60000FFFF008484840000000000000000000000000000000000000000000000
      000084848400C6C6C60084848400000000008484840000000000000000000000
      0000000000000000000000000000848484000000000000000000000000000000
      0000FF000000FF00000000000000000000008484840000000000000000000000
      00000000000000FFFF0000FFFF0000FFFF0000FFFF00000000000000000000FF
      FF0000FFFF0000FFFF0000FFFF00000000000000000000000000000000000000
      00000000FF000000FF000000FF00000000008484840000000000000000000000
      0000000000000000FF000000FF000000000000000000848484000000000000FF
      FF00C6C6C6008484840000000000000000000000000000000000000000000000
      0000848484000000000084848400000000008484840000000000000000000000
      000000000000000000000000000084848400000000000000000000000000FF00
      0000FF000000FF000000FF000000000000008484840000000000000000000000
      0000000000000000000000FFFF0000FFFF0000FFFF00000000000000000000FF
      FF0000FFFF0000FFFF00000000000000000000000000C6C6C6000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF0000000000000000008484840000000000C6C6
      C60000FFFF008484840000000000000000000000000000000000000000000000
      0000848484008484840084848400000000008484840000000000000000000000
      000000000000000000000000000084848400000000000000000000000000FF00
      000000000000FF000000FF000000000000008484840000000000000000000000
      0000000000000000000000FFFF0000FFFF0000FFFF00000000000000000000FF
      FF0000FFFF0000FFFF00000000000000000000000000C6C6C600000000000000
      0000848484008484840084848400848484008484840000000000000000000000
      FF000000FF000000FF0000000000000000000000000000000000848484000000
      0000000000008484840000000000000000000000000000000000000000000000
      0000848484000000000000000000000000008484840000000000000000000000
      0000000000000000000000000000848484000000000000000000000000000000
      0000FF000000FF00000000000000000000008484840000000000000000000000
      000000000000000000000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000000000000000000000000000000000C6C6C600C6C6C6000000
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000008484
      8400848484008484840000000000000000000000000000000000000000000000
      0000848484000000000000000000000000008484840000000000000000000000
      0000000000000000000000000000848484000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      0000000000000000000000000000848484000000000000FFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840000000000000000000000000000000000000000000000
      0000848484000000000000000000000000008484840000000000000000000000
      0000000000000000000000000000848484000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      0000000000000000000000000000848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840084848400848484008484840084848400848484008484
      8400848484000000000000000000000000008484840084848400848484008484
      8400848484008484840084848400848484000000000000000000000000000000
      0000000000000000000000000000000000008484840084848400848484008484
      8400848484008484840084848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF00000000000000000000000000000000000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF0000000000FF000000FF000000FF000000000000000000
      00000000FF000000FF00000000000000000000000000000000000000FF000000
      FF000000000000000000000000000000FF000000FF0000000000000000000000
      00000000FF000000FF0000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF0000000000FF000000FF000000FF000000FF000000000000000000
      FF000000FF000000FF000000FF0000000000000000000000FF000000FF000000
      FF000000FF00000000000000FF000000FF000000FF000000FF00000000000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      000000000000FF000000FF000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      84000000000000000000000000000000000000000000000000000000FF000000
      FF0000000000FF000000FF000000FF000000FF000000FF0000000000FF000000
      FF000000FF00000000000000FF0000000000000000000000FF00000000000000
      FF000000FF00000000000000FF00000000000000FF000000FF00000000000000
      FF00000000000000FF000000FF00000000000000000000000000000000000000
      000000000000FF000000FF000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      840000000000000000000000000000000000000000000000FF000000FF000000
      000000000000FF000000FF000000FF000000FF0000000000FF000000FF000000
      FF0000000000000000000000FF000000FF0000000000000000000000FF000000
      FF000000000000000000000000000000FF000000FF0000000000000000000000
      00000000FF000000FF0000000000000000000000000000000000000000000000
      000000000000FF000000FF000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000008484840084848400848484008484
      8400848484008484840084848400000000000000000000000000000000008484
      840000000000000000000000000000000000000000000000FF000000FF000000
      000000000000FF000000FF000000FF0000000000FF000000FF000000FF000000
      000000000000000000000000FF000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF000000FF000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000848484000000000000FFFF0000848400000000000000
      0000008484000000000000000000000000000000000000000000000000000000
      000000000000FF000000FF0000000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840084848400000000000000000000000000000000000000
      000000000000FF000000FF000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484000084
      840000000000000000008484840084848400000000000000FF000000FF000000
      000000000000FF0000000000FF000000FF000000FF00FF000000000000000000
      000000000000000000000000FF000000FF008484840084848400C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C60084848400848484000000000000000000000000000000
      000000000000FF000000FF000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      0000000000000000FF000000FF000000FF00FF000000FF000000000000000000
      000000000000000000000000FF000000FF0084848400C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C6000000000000000000C6C6C600848484000000000000000000000000000000
      000000000000FF000000FF000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      00000000FF000000FF000000FF00FF000000FF000000FF000000000000000000
      0000000000000000FF000000FF00000000008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C600C6C6C600848484000000000000000000000000000000
      000000000000FF000000FF000000FF000000FF000000FF000000000000000000
      00000000000000000000000000000000000000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF00FF000000FF000000FF000000FF000000000000000000
      00000000FF000000FF000000FF00000000008484840084848400C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C60084848400848484000000000000000000000000000000
      00000000000000000000FF000000FF000000FF000000FF000000000000000000
      00000000000000000000000000000000000000000000C6C6C600000000000000
      0000848484008484840084848400848484008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000000000000000FF000000FF000000FF000000000000000000
      FF000000FF000000FF0000000000000000000000000084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840084848400000000000000000000000000000000000000
      0000000000000000000000000000FF000000FF000000FF000000000000000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C6000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF00000000000000000000000000000000000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF000000FF000000
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
      000000000000000000000000FF000000FF000000FF000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000000000000000000000000000840000008400000084000000
      8400000084000000840000008400000084000000840000008400000084000000
      0000000000000000000000000000000000000000000084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840084848400000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840000000000000000000000000000000000000000000000
      FF000000FF00FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      00000000FF000000FF0000000000000000000000840000008400000084000000
      8400000084000000840000008400000084000000840000008400000084000000
      00000000000000000000000000000000000000000000848484000000000000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF0084848400000000000000000000000000848484000000
      000000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF0084848400000000000000000000000000000000000000FF000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      0000000000000000FF000000FF00000000000000000000008400000084000000
      8400000000000000000000000000FF000000FF00000000000000000084000000
      8400FF000000FF0000000000000000000000000000008484840000000000C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C600848484000000000000000000848484000000000000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000000000848484000000000000000000000000000000FF000000
      00000000FF000000FF000000FF00FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      000000000000000000000000FF000000000000000000FF000000FF0000000000
      84000000840000000000FF000000FF000000FF000000FF000000000084000000
      8400FF000000FF000000FF0000000000000000000000848484000000000000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF008484840000000000000000008484840000000000C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60084848400000000008484840000000000000000000000FF000000FF000000
      0000000000000000FF000000FF000000FF008484840000000000000000000000
      000000000000000000000000FF000000FF0000000000FF00000000000000FF00
      00000000840000008400FF00000000000000FF000000FF00000000000000FF00
      000000000000FF000000FF00000000000000000000008484840000000000C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60084848400000000008484840000000000C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF0000000000848484008484840000000000000000000000FF000000FF000000
      000000000000FFFF00000000FF000000FF000000FF00FFFF0000FFFF0000FFFF
      000000000000000000000000FF000000FF000000000000000000FF000000FF00
      0000000000000000840000008400FF000000FF00000000000000000000000000
      0000FF000000FF000000000000000000000000000000848484000000000000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF0084848400000000008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      840000000000C6C6C6008484840000000000000000000000FF000000FF000000
      00000000000000000000848484000000FF000000FF000000FF00848484000000
      000000000000000000000000FF000000FF000000000000000000000000000000
      0000000000000000000000008400000084000000000000000000000000000000
      000000000000000000000000000000000000000000008484840000000000C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60084848400000000008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      84008484840000FFFF008484840000000000000000000000FF000000FF000000
      000000000000FFFF0000FFFF0000FFFF00000000FF000000FF000000FF00FFFF
      000000000000000000000000FF000000FF000000000084848400848484008484
      8400848484008484840084848400000084000000840000008400848484008484
      84008484840084848400848484000000000000000000848484000000000000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF008484840000000000000000008484840000000000C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C6008484840000000000000000000000FF000000FF000000
      000000000000000000008484840084848400000000000000FF000000FF000000
      FF0000000000000000000000FF000000FF008484840084848400C6C6C600C6C6
      C600C6C6C600C6C6C600000084000000840000008400C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C60084848400848484000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400000000000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000848484000000000000000000000000000000FF000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000FF000000
      FF000000FF00000000000000FF000000000084848400C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600000084000000840000008400C6C6C600C6C6C600C6C6
      C6000000000000000000C6C6C600848484000000000084848400C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60084848400848484008484
      840084848400848484008484840000000000000000008484840000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C6008484840084848400848484008484
      84008484840084848400848484000000000000000000000000000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000000084848400C6C6C600000000000000
      0000000000000000840000008400000084000000000000000000000000000000
      000000000000C6C6C600C6C6C60084848400000000000000000084848400C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C6008484840000000000000000000000
      00000000000000000000000000000000000000000000000000008484840000FF
      FF00C6C6C60000FFFF00C6C6C600848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      00000000FF000000FF0000000000000000008484840084848400C6C6C600C6C6
      C600C6C6C600000084000000840000008400C6C6C600C6C6C600C6C6C600C6C6
      C600000084000000840084848400848484000000000000000000000000008484
      8400848484008484840084848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400848484008484840084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000000000000000000000000000000084848400848484008484
      8400000084000000840000008400848484008484840084848400848484008484
      8400848484000000840000008400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000848484000000FF000000FF000000FF000000FF000000FF008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000008400000084000000840000008400000084000000
      8400000084000000840000008400000000000000000000000000000000000000
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
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF000000FF00
      0000000000000000000000000000FF000000FF00000000000000000000000000
      0000FF000000FF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400848484008484840084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400848484008484840084848400000000000000
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000FF00000000000000FF000000FF000000FF000000FF00000000000000FF00
      0000FF000000FF000000FF000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C600FF000000FF000000FF000000FF000000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C6000000FF000000FF000000FF000000FF00848484000000
      00000000000000000000000000000000000000000000FF00000000000000FF00
      0000FF00000000000000FF00000000000000FF000000FF00000000000000FF00
      000000000000FF000000FF000000000000000000000000000000000000000000
      0000000000000000000084848400848484008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C6C6C600FF000000FF000000FF000000FF000000FF000000FF0000008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000C6C6C6000000FF000000FF000000FF000000FF000000FF000000FF008484
      8400000000000000000000000000000000000000000000000000FF000000FF00
      0000000000000000000000000000FF000000FF00000000000000000000000000
      0000FF000000FF00000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000000000000000000000000000000000000000000000000000000000000000
      0000C6C6C600FF000000FF000000FF000000FF000000FF000000FF0000008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000C6C6C6000000FF000000FF000000FF000000FF000000FF000000FF008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400000000008484840084848400848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C6C6C600FF00000000000000FF000000FF000000FF000000FF0000008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000C6C6C6000000FF00000000000000FF000000FF000000FF000000FF008484
      8400000000000000000000000000000000000000000084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840084848400000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000000000000000000000000000000000000000000000000000000000000000
      0000C6C6C600FF0000000000000000000000FF000000FF000000FF0000008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000C6C6C6000000FF0000000000000000000000FF000000FF000000FF008484
      8400000000000000000000000000000000008484840084848400C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C60084848400848484000000000000000000000000000000
      0000000000000000000084848400848484000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C600FF000000FF000000FF000000FF000000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C6000000FF000000FF000000FF000000FF00848484000000
      00000000000000000000000000000000000084848400C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C6000000000000000000C6C6C600848484000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C6C6C600C6C6C600C6C6C600C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C6C6C600C6C6C600C6C6C600C6C6C600000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C600C6C6C600848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840084848400C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C60084848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840084848400000000000000000000000000000000000000
      0000000000008484840000000000848484000000000084848400000000008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840000000000848484000000000084848400000000008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000200300000100010000000000001900000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFFFFFF00000000F003F01F00000000
      E001C44700000000E001C00700000000E019800300000000E001A00B00000000
      0001800300000000000980830000000000018043000000000001A02B00000000
      000180030000000080010001000000008001044100000000C001901300000000
      C001FEFF00000000E003FC7F00000000FFFFF000FFFFFFC1FE1FF800FFF70001
      F80F7C00FFE70001F007BE00FFCF0001F0035F00FF9F0001E0032DE0FF3F0001
      E00313F8FC7F0001E0030FFCF87F0001E40B0F8EF03F00019F3B0F06F03F0001
      FE330E03F07F000173E70E00F87F0001180F0600FC7F0001BFFF0700FD7F0001
      FFFF0180FDFF0001FFFF0000FFFFFFC1C007C0070000FFFFC003C7FB0000FFFF
      8003800B0000C7FF83F983FB0000E3FF8009800B0000E1FF0078007B0000E0FF
      0808080B0000807F0C182C1B0000803F0808280B0000C0FF8C08AC1B0000E107
      8801A80B0000C2038F81AF8300008001A543A5430000C003B007B0070000F01F
      D007D0070000FF3FEAAFEAAF0000FFFFFFFFC007C007847FFDFFC7FBC00300EF
      F9FF800B800331BFF1FF83FB83F939FFE1FF800B8009993FC1FF007B0078CA1F
      8001080B0808F40F00012C1B0C189C070001280B080896038001AC1B8C08CB01
      C1FFA80B8801FF80E1FFAF838F81F7C0F1FFA543A543FFE0F9FFB007B007EFF0
      FDFFD007D007FFF8FFFFEAAFEAAFFFFCFFFFFFFFE007FFFF781FFE1FC007FFBF
      700FF007C007FF9F6007E003C007FF8FC003C1C1C007FF878001C3E1C007FF83
      80018360C0078001800183E0C0078000800181C0C007800080018360C0078001
      800183E0C007FF83C003C1C1C007FF87E007C001C007FF8FF00FE003C007FF9F
      F81FF007C007FFBFFFFFFE1FC007FFFFFFFFC001FFFFE000F81F8000F81FC000
      F00F0000F00F8000E0070000E0078000C0030001C0038000800180018001C000
      800180038001C0018001C0038001E0018001C0078001E0038001E0078001F003
      8001E00F8001F007C003F00FC003F807E007F01FE007F80FF00FF81FF00FFC0F
      F81FF83FF81FFC1FFFFFFC7FFFFFFE3FFFFFFFDFC001FFFFFC00FFCF8000F81F
      FC00FFC70000F00FFC0000030000E007FC0000010001C003EC00000080018001
      E400000180038001E0000003C003800100000007C00780010001000FE0078001
      0003001FE00F80010007007FF00FC003000F00FFF01FE007E3FF01FFF81FF00F
      E7FF03FFF83FF81FEFFFFFFFFC7FFFFFFFFFFFFFFE7FFFFFF7DFFC3FFC3FFFFF
      F39FFC3FF81F0000F01FFC3FF00F0000E00FFC3FE0070000E007FC3FC0030000
      C007FC3F80010000C007FC3FFC3F0000C007FC3FFC3F0000E0078001FC3F0000
      C007C003FC3F0000C013E007FC3F8001E1C3F00FFC3FC003F387F81FFC3FF00F
      F3CFFC3FFC3FFC3FFC3FFE7FFFFFFFFFFFFFFFFFFFFFFFFFF00300C0FFFFFFFF
      E00300D0FFFFFCFFC00300900001F01FC00700900001C007800700B00001E00F
      800700300001F01FC00700700001F01FC00300700001F01FE00100F00001F01F
      F80D00F30001F01FF00D00F30001F01FF00707F30001F83FF817C7F3FFFFFC7F
      F81FE7F3FFFFFEFFF83FE7FFFFFFFFFFFFFFF8AF8080FC7E8007F0570000FC7E
      8007F02B0000FC7E8FE7F8178181783C8007F02F818148248FE7F03F81810000
      C3E7F03F81810000CE07F83FC3C3844281C78C1FF80F48248E27060FF00F783C
      801F0007F00F30188FE78007F81F0FE083E78007F81F07C08007C00FF81F07C0
      8007E01FF81F0100FFFFF03FFC3F0000FDFFFE7FFFFFFFFF90A7F83FFBFFFFFF
      9001E29FF3FFF803AC0188CFE3FFFBFB00012067C3FFFA0B00FF00330007FBFB
      83030019837FFA1B8401000C837BFBFB891900048373F80381B081018360F803
      80E0C0018340FBFB8060E0018360FA0B80E0F0018773FBFB8180F8078F7B0000
      C000FC1F9F7F781EC0FFFE7F807F0000FFFFFFFFFFFFFFFFFFFFFFFFFFE70001
      FFFF80039FC30001000080038F81000100008003C703000100008003E3070001
      00008003F00F000100008003F81F000100008003FC3B000100008003F8390001
      00008003F301000100008003C7870001000080038F870001000080038F8F0001
      FFFF80039F3F0001FFFFFFFFFF7FFFFFFFFFFFFFFFFFFFFFF3FFF1FFFF9FF013
      E1FFC083FD9FF003F07F8003F00FC003F81FF003C0078003FC07FFC3A00B8003
      FE07FFFBF01F0003FE03CFFFF01F8001FE03CE7FF01FC001FE07CCFFD01FC001
      E807C1FFB01FC001C01781FFD01FE001801782FFF83FF001FE07E5FFFC7FF801
      FF9FE3FFFEFFFC03FFFFFFFFFFFFFFFFFFFFFFFFD83BFC7FFFFF000F8003FC3E
      FFFF000F00011830807F000F00010000C0FF000F00010000E1FF000F80050000
      E04F000F20011000C03F000F80010008C03F000FC0031008C03F0004C0031008
      C01F0000D0171810C01F0000C01319F0F03FF800F81F0DE0F81FFC00FC7F03C0
      F83FFE04FEFF0000FFFFFFFFFE7F0000FFFFFFFFFFFFFFFFFF7FFE7FFFFF0007
      E00FFC3FFC1F0003C00FF81FF00300030007F007C00300030003E00780010003
      0003C00380010003000080010001000100000003000100000000000780010000
      00000007800100000000000780018007080000078003CF0F7FF01007C007EFCF
      FFFC38FFF81FFFE7FFFE7DFFFFFFFFF3FFFFFFFF8FFFFFFFFFFFE00703FFFFFF
      0003C00300FFDF7F0001C003007F803F0001C003001F003F0001C003C001001F
      0001C003F80080070001C003F800C0030001C003E001E0030001C003C000E001
      0001C0038000F0018001C0038003F001C001C003C007F803F83FE007C00FFFFF
      FFFFFC3FF01FFFFFFFFFFFFFF87FFFFFFC00FFFFFC0FFFFFFC008003E003FFFF
      FC008003C0018003FC008003C0038003E0008003C0078003E0008003C0078003
      E0008003C0078003E00780038007800180078003800380008007800380038000
      8007800380038000801F800380038003801F8003C00F8003801F8003C00FFFCF
      801FFFFFC10FFFE7FFFFFFFFE39FFFF3FFF3FFFFFFFFFFFFFFE1FF3FC0078003
      FFC1FE3F80038003FF83C07F00018003F00780F700018003C00F00E700018003
      801F00C100008003801F00E600008003000F00F680008003000F81FEC0008003
      000FC3BFE0018003000FFFB7E0078003801FFFB3F0078003801FFFC1F0038003
      C03FFFF3F803FFFFF0FFFFF7FFFFFFFFFFFFFFFFFFFFFFFFFFFFC001000CF9FF
      001F80010008F9FF000F80010001F3C700078001000373C700038001000327FF
      00018001000307C700008001000300C7001F8001000301E3001F8001000703F1
      001F8001000F06388FF18001000F0E38FFF98001000F1E38FF758001001F3F01
      FF8F8001003F7F83FFFFFFFF007FFFFFFFFFFFFFFFFFFFFFF07FFFFFFFFFFFFF
      E79DFFFFEFFDC007EFE9FFFFC7FFC007EFF1FFFFC3FBC007EFE1EFFFE3F7C007
      E7C1EF83F1E7C007F3FFDFC3F8CFC007FFFFDFE3FC1FC007C1F3DFD3FE3FC007
      C3FBEF3BFC1FC007C7FBF0FFF8CFC007CBFBFFFFE1E7C00FDCF3FFFFC3F3C01F
      FF07FFFFC7FDC03FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FFFF9FFFFFFFC00
      87FFF6CFFE00800081FFF6B7FE000000807FF6B7FE000000801FF8B780000000
      8007FE8F800000018001FE3F800000038001FF7F800000038007FE3F80010003
      801FFEBF80030003807FFC9F8007000381FFFDDF807F000387FFFDDF80FF8007
      9FFFFDDF81FFF87FFFFFFFFFFFFFFFFFC001FFFFFFFFFFFF8000FC3FF81FFFFF
      0000E00FF00FF9FF0000C007E007F0FF000183C3C003E0FF800181838001C007
      8003018180018003C003018180010001C007018180018001E00703818001C001
      E00F00018001E001F00F8183C003F0FFF01F8183E007F8FFF81FC007F00FFCFF
      F83FE00FF81FFEFFFC7FFC3FFFFFFFFFFE49FFFFEFEFF000FE49FFFF8007F000
      FFFF07C18003F000FFFF07C18001F000C7C707C18003F000C7C701018003F000
      C38700018203F000C00700018043E000C00700018023C000C007800380138000
      C007C10780098000C007C10780040000F39FE38FC0000000F39FE38FFFF90001
      F39FFFFFFFFF0003FFFFFFFFFFFF00078007FE03E00FC0000003FC01C0078000
      0003FC01800B00000003FC01800100000003C001800000000003800100000000
      0003800180010000600380018003000100038001800300010FC7800580010001
      001F800380000001001D803F000000010018803F80018003001D80BF8003C5AF
      0003C07F800BE3DFE03FFFFFC007F03F8001C007FFFF80070000D007FFFF0003
      0000E00FFF1F000300008003FC4F000300000001F80F000300000001E0970003
      00000001C057000380010001C0170003F00F0001C0170003F00F0001C0577E07
      F00F0001E09700FFF00F0001F80F00F7F00F0001FC4F00E3F00F0001FF1F00F7
      FC1F8001FFFF008FFFFFC003FFFF01FFFFF9FFF9FFF9C03FFFF1FFF1FFF1E01F
      FFE3FFE3FFE3F00FF0C7F0C7F0C7F807C60FC60FC60FF047909F909F909FF083
      A05FA05FA05FF003000F000F000FF003402F442F002FF001402F402F002FF001
      000F020F200FF001A05FA25FA05FF001909F909F909FF001C63FC03FC63FF001
      E07FE07FE07FFFFFFFFFFFFFFFFFFFFFFFF9FFF9FFF9FFF9FFF1FFF1FFF1FFF1
      FFE3FFE3FFE3FFE3F0C7F0C7F0C7F0C7C60FC60FC60FC60F909F901F909F909F
      A05FA01FA05FA05F000F000F000F000F002F002F002F002F002F002F002F002F
      200F200F200F200FA05F805FA05FA05F909F809F909F909FC63FC63FC63FC73F
      E07FE07FE07FE07FFFFFFFFFFFFFFFFFFFFFFFFFFFF9FFF9FFFFFFFFFFF1FFF1
      8007FFFFFFE3FFE38003CFFFF0C7F0C78003901FC60FC60F8003B00F909F909F
      8003B00FA05FA05F8003100D000F000F8003B008002F002F8003F00D002F002F
      8003F80D200F200F8003FFF9A05FA05F8003FFF3909F909FC003FFFFC63FC63F
      FFFFFFFFE07FE07FFFFFFFFFFFFFFFFFC00FFFFFFFFFFFFF8007C003F801FFFF
      00078001F801E00100078001F801C00100078001C001C00100018001C001C001
      00008001C001C001000080010001C001000080010001C00180008001000FC001
      C2008001000FC001FFC08001000FC001FFE18001003FC001FFFF8001003FC003
      FFFF8001003FFFFFFFFFFFFFFFFFFFFFFFC18001F00FC00F00018001F00F8007
      00018001F81F000300018001F81F000100018001F81F000100018001F81F0001
      00018001F81F0001000180017801000100018001300000010001800103F88003
      000180010300C18F000180019400FF8F00018001C000FE0300018001F819FF07
      00018001FFFFFF8FFFC18003FFFFFFDFFFFFFFFFFFFFFFFFFFFFE00FE00FDFFB
      FFFFC007C0078FFBFFFFC007C00787F7FE21C007C00787E7C001C007C007C3CF
      8002C007C007E18F8000C007C007F01F8000C007C007F83F8000C007C007F83F
      8002C007C007F01FFF04C007C007C18FFF01E807C01783C7FFFFF007C00F87E3
      FFFFF807E01F8FFBFFFFFFFFFFFFFFFFFFFFFFFFFFFF8181FFFFFF81FC00C183
      FFCFFF81FC006006FFCFFF81FC00318CFFFFFE81FC0006E0FFCFF001FC0008F0
      FFCFE681FC0008F0FDC7EF81FC00D0FB98E3C781FC00D0FB80F1EF81FFEF08F0
      819900FF03C708F0838100FF03EF06E081C300FF02CF31CC81FF00FF001F6006
      FFFF00FF02FFC183FFFF00FF03FF8181FC7FFFFFEFEF81FFF03FFF87800780FF
      C11FFF878003807F878FFF878001803F1C87FF878003C01F0043FF878003C00F
      0031FF838203E0070008FD818043E003100C98808023C001000480008013C000
      8A0081008009C003C00183008004E007E0038100C000E003F0078181FFF9F001
      F80FFFFFFFFFF801FC3FFFFFFFFFFC03C003C003E003F81F80018001C001E007
      800180018000C001800180018000800180098001800080008041800180000000
      80018C01800000008041880180000000802180018000000080018C0180000000
      80018001800000008001800180000001800180018000800180018001C001C003
      C003C003E003E007FFFFFFFFFFEFF81F80018000FFF3C0030000C018FFE38001
      0000602807C08001000034480380800100001B880300800100000F0802008001
      00000E88030080018001148403808001F00F230201C08001F00F100400C08001
      F00F003000408001F00F022000C08001F00F014001C08001F00F008003E0C003
      FC1F0000C7FFF00FFFFF0000CFFFFFFFFE03FFFFFFFF807FFC01FFFFC003C03F
      FC0180038001E01FFC0100018001F00FC001050D8001F8078001040D8001FC03
      800104058001F823800100058001F841800100058001F801800500018001F801
      80036E018001F800803F47E18003F800803FA803C07FF80080BFC7FFE0FFF800
      C07FFFFFFFFFF800FFFFFFFFFFFFF800FFFF800380078007FFFF800300030003
      FF1F800300030003FC4F800300030003F80F800300030003E097800300030003
      C057800300030003C017800300036003C017800300030003C05780037E070FC7
      E097801300FF001FF80F801300F7001DFC4F800300E30018FF1F801700F7001D
      FFFF800F008F0003FFFF801F01FFE03FFFFFFFFFFFFFFFFFC001F00FF00FF00F
      8000E007E007E0070000E087E087E7F70000E047E047E4170000E027E027E417
      0000E017E017E4170000E007E007E4170000E007E007E4170000E007E007E417
      0000E007E007E4778001E007E007E447C03FE007E017E457E07FE00FE00FE7CF
      FFFFF01FF01FF01FFFFFFFFFFFFFFFFFC001FC3FFFFFFFFFC001FC1FC003C003
      C003F81F80018001E003F80F00018001E007F00F0001C001F007F00700018001
      F00FE0070001C001F80FE00300018201F81FC00300018001FC1FC00100018041
      FC3FC00100018001FFFFFFFF80038001EDF0C3EDC07FC003E11BEE21E0FFFFFF
      EDFDF7EDFFFFFFFFF3F0C3F3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8888
      E3FF1F1F61118F8FE23F1111FFFF8888E7FF3F3F61119F9FFFFFFFFFFFFFFFFF
      FFFFFFFF61118888FF1F1F1FFFFF8F8FFF11111161118888FF3F3F3FFFFF9F9F
      FFFFFFFF6111FFFFFFFFFFFFFFFF88888FFF1F1F00008F8F88FF1111FFFF8888
      9FFF3F3FE1119F9FFFFFFFFFFFFFFFFF80038400FFFFFFFF80010000FFFFFFFF
      80010000FFC0FF8180010000FFFFFFFF80010000FFC0FFC380010000FFC0FFC3
      8001840003C0FFC380010000FFC0FFC38001840003C081C78001000003C0FFFF
      8001000003C0C3FF8001000003FFC3FF9C3D000003FFC3FF8001000003FFC3FF
      901D840003FFC7FFC0010000FFFFFFFF800FFFFFFFFFFE10000FFFFFF81F8020
      000FFFFFF81F4020000FFFFFF81F4040000FC7E3F81F2040000F83C1F00F2080
      000F0180E00710FE000F0180C0030000000B0180800100000007018080010000
      000F83C1800100000014C7E380010000FFAFFFFFC0030000FF57FFFFF00F0000
      FEFBFFFFF81F0000FFDFFFFFF81F0000FFFFF81FFFFF8001FFFFF00F80078001
      00FF00030003C0017E8F4683000380017E030E010003C0017C011C0000038201
      4001000000038001780018000003804141F800F80003800179F818F800038001
      400100000003C0037C01000180BAFF7742034203C1C7FF8F7E8F4003FFFFFF77
      7EFF600FFF6DFFDF00FF001FFFFEFDDD003FE7FFFC1FFC1F001FE7FFF007F007
      000FE7FFC0038001FF8FE7FFC0018001FF0F00FF80018001FE07007F80008000
      FC03FE7F00008000FC03FE7F1E208000FC03FE7F00008000F801FE7F80008000
      F000FE009FC59FC5F000FF0080018001F801FFF7C0F3C073FC93FFF7E007E007
      FEDBFFF7FC1FFC1FFFFFFFF7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      00FF00FFFFFFFFFF7E8F78FFFFFFFFFF7E0340FFFCFFFCFF7C017001FC3FFC3F
      40014001FC0FFC0F780046330003000341F842330000000079F86E1300030003
      40014281FC0FFC0F7C017EC9FC3FFC3F420342C3FCFFFCFF7E8F7EE7FFFFFFFF
      7EFF7EF7FFFFFFFF00FF00FFFFFFFFFFFC03FFFFFFFFFFFFF003E000FFFFFFFF
      E3C3C00000FF00FFC7C1D0007EFF7E8FCFC5A0007EFF7E030084A0007E017C01
      00044000420140019C007FE07EF378009C00000042F34000983CA3F07EF37800
      8139A21442E140010031A3F17EE97C012023DA1742F342030007E3F77EFF7E8F
      9C1FFBF77EFF7EFFFFFFF80700FF00FFFFFFFFFFFFC3FC1FFFFFFE1FFFCBF007
      FFFFFC1FFFCBE013CE73F81FFFC3C0018421F01FFFE7C005A529F01F00E7900C
      CE73F01F00E7901CFFFF0001FC0000008001F01FFE00901C0000F01FFF3F901C
      000CF01F8F3FD0197FF8F01F203FC0110000F81F203FE4038001FC1F0FFFF007
      FFFFFE1F9FFFFC1FFFFFFFFFFFFFFFFFFFFFFFFFF007FFFFC000E000C003001F
      8000C000A003001FA000D00083F98E43A000A00080098401A000A0008878A129
      A00040008808C873A0007FE08C18FCFFA000000088088001A000A0008C880000
      BFFCBFFC8801000C800180018FE138F8C07FC0FFA5530000E0FFE1FFB0078001
      FFFFFFFFD007F001FFFFFFFFEAAFFFFFFFFFFFFFFFFFF007FFFFFFFFFFFFCFFB
      FFFFFFFFFFFFA80BFFFFFFFFCE73AFFBFC3FFC3F8421A80BF81FF81FA529AC7B
      F00FF00FCE73A80BF00FF00FFFFFAD1BF20FF20F8001A80BF30FF30F0000ACBB
      F81FF81F000CA80BFC3FFC3F7FF8AFFBFFFFFFFF0000A553FFFFFFFF8001B007
      FFFFFFFFFFFFD007FFFFFFFFFFFFEAAF00000000000000000000000000000000
      000000000000}
  end
  object acBase: TActionList
    Images = ImageList1
    Left = 106
    Top = 8
    object acFileClose: TAction
      Tag = 21
      Category = 'File'
      Caption = '&'#1047#1072#1082#1088#1099#1090#1100' '#1086#1082#1085#1086
      Hint = #1047#1072#1082#1088#1099#1090#1100'|'#1047#1072#1082#1088#1099#1074#1072#1077#1090' '#1090#1077#1082#1091#1097#1091#1102' '#1079#1072#1076#1072#1095#1091
      ImageIndex = 156
    end
    object acFileExit: TAction
      Tag = 22
      Category = 'File'
      Caption = #1042#1099'&'#1093#1086#1076
      Hint = #1042#1099#1093#1086#1076'|'#1042#1099#1093#1086#1076' '#1080#1079' '#1087#1088#1080#1083#1086#1078#1077#1085#1080#1103
      ImageIndex = 154
      ShortCut = 32883
    end
    object acRefresh: TAction
      Tag = 23
      Category = 'File'
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1076#1072#1085#1085#1099#1077
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1076#1072#1085#1085#1099#1077'|'#1054#1073#1085#1086#1074#1083#1103#1077#1090' '#1076#1072#1085#1085#1099#1077' '#1072#1082#1090#1080#1074#1085#1086#1075#1086' '#1086#1082#1085#1072
      ImageIndex = 116
      ShortCut = 116
      OnExecute = iaRefreshExecute
    end
    object aMUpCtr: TAction
      Category = 'Navigation'
      Caption = #1055#1077#1088#1077#1084#1077#1089#1090#1080#1090#1100' '#1074#1074#1077#1088#1093
      Hint = #1055#1077#1088#1077#1084#1077#1089#1090#1080#1090#1100' '#1074#1074#1077#1088#1093'|'#1055#1077#1088#1077#1084#1077#1097#1072#1077#1090' '#1074#1099#1073#1088#1072#1085#1085#1099#1081' '#1101#1083#1077#1084#1077#1085#1090' '#1074#1074#1077#1088#1093
      ImageIndex = 165
      ShortCut = 16422
    end
    object aMDownCtr: TAction
      Category = 'Navigation'
      Caption = #1055#1077#1088#1077#1084#1077#1089#1090#1080#1090#1100' '#1074#1085#1080#1079
      Hint = #1055#1077#1088#1077#1084#1077#1089#1090#1080#1090#1100' '#1074#1085#1080#1079'|'#1055#1077#1088#1077#1084#1077#1097#1072#1077#1090' '#1074#1099#1073#1088#1072#1085#1085#1099#1081' '#1101#1083#1077#1084#1077#1085#1090' '#1074#1085#1080#1079
      ImageIndex = 166
      ShortCut = 16424
    end
    object iaChannel: TAction
      Category = 'Operation'
      Caption = #1050#1072#1085#1072#1083#1099
      Enabled = False
      Hint = #1054#1090#1086#1073#1088#1072#1079#1080#1090#1100' '#1082#1072#1085#1072#1083#1099' '#1087#1088#1080#1077#1084#1072'/'#1086#1090#1089#1099#1083#1082#1080' '#1084#1072#1082#1077#1090#1086#1074
      ImageIndex = 9
      Visible = False
    end
    object iaMakets: TAction
      Category = 'Operation'
      Caption = #1052#1072#1082#1077#1090#1099
      Enabled = False
      Hint = #1054#1090#1086#1073#1088#1072#1079#1080#1090#1100' '#1087#1088#1080#1085#1080#1084#1072#1077#1084#1099#1077'/'#1086#1090#1089#1099#1083#1072#1077#1084#1099#1077' '#1084#1072#1082#1077#1090#1099
      ImageIndex = 3
      Visible = False
    end
    object iaClear: TAction
      Category = 'Operation'
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100
      Enabled = False
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1087#1088#1080#1074#1103#1079#1082#1091
      ImageIndex = 183
      ShortCut = 16503
      Visible = False
    end
    object alDelete: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 75
      ShortCut = 119
    end
  end
  object mnMain: TMainMenu
    Images = ImageList1
    Left = 72
    Top = 8
    object mnFile: TMenuItem
      Caption = '&'#1060#1072#1081#1083
      GroupIndex = 10
      Hint = #1054#1073#1097#1080#1077' '#1082#1086#1084#1072#1085#1076#1099' '#1087#1088#1080#1083#1086#1078#1077#1085#1080#1103
      object MenuItem1: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
        Enabled = False
        GroupIndex = 40
        Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1089#1076#1077#1083#1072#1085#1085#1099#1077' '#1080#1079#1084#1077#1085#1077#1085#1080#1103
        ImageIndex = 81
        ShortCut = 113
      end
      object mnRefresh: TMenuItem
        Tag = 23
        Action = acRefresh
        GroupIndex = 40
      end
      object MenuItem2: TMenuItem
        Caption = '-'
        GroupIndex = 40
      end
      object mnFileClose: TMenuItem
        Tag = 21
        Action = acFileClose
        GroupIndex = 40
      end
      object MenuItem3: TMenuItem
        Caption = '-'
        GroupIndex = 40
      end
      object mnFileExit: TMenuItem
        Tag = 22
        Action = acFileExit
        GroupIndex = 40
      end
    end
  end
  object oqDeports: TOraQuery
    Session = dmMain.orases
    Left = 34
    Top = 104
  end
  object oqDeportInfo: TOraQuery
    Session = dmMain.orases
    AutoCommit = False
    AfterScroll = oqDeportInfoAfterScroll
    Left = 98
    Top = 160
  end
  object dsDeportInfo: TOraDataSource
    DataSet = oqDeportInfo
    Left = 164
    Top = 166
  end
  object oqVspom: TOraQuery
    Session = dmMain.orases
    Options.ReturnParams = True
    Left = 22
    Top = 160
  end
  object SaveDialog1: TSaveDialog
    Left = 117
    Top = 438
  end
  object PrintMessageGrid: TPrintDBGridEh
    DBGridEh = MessageGrid
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
    Left = 46
    Top = 298
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'txt'
    Filter = #1058#1077#1082#1089#1090#1086#1074#1099#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1099' (*.txt)|*.txt|'#1042#1089#1077' '#1092#1072#1081#1083#1099' (*.*)|*.*'
    Title = #1047#1072#1075#1088#1091#1079#1082#1072' '#1092#1072#1081#1083#1072' '#1084#1072#1082#1077#1090#1072
    Left = 48
    Top = 440
  end
  object oqExistsMaket: TOraQuery
    Session = dmMain.orases
    Left = 82
    Top = 218
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 10000
    OnTimer = Timer1Timer
    Left = 162
    Top = 226
  end
  object oqIsLoad: TOraQuery
    Session = dmMain.orases
    AutoCommit = False
    Left = 108
    Top = 86
  end
end
