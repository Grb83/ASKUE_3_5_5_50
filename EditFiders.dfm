inherited FormEditFiders: TFormEditFiders
  Left = 162
  Top = 18
  HelpContext = 521
  VertScrollBar.Range = 0
  BorderStyle = bsNone
  Caption = 'FormEditFiders'
  ClientHeight = 729
  ClientWidth = 850
  OnDestroy = FormDestroy
  OnShow = FormShow
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  inherited iplBottom: TPanel
    Top = 704
    Width = 850
    TabOrder = 2
    object sbUp: TSpeedButton [0]
      Left = 194
      Top = 1
      Width = 23
      Height = 25
      Action = aNodeUp
      Enabled = False
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000333
        3333333333777F33333333333309033333333333337F7F333333333333090333
        33333333337F7F33333333333309033333333333337F7F333333333333090333
        33333333337F7F33333333333309033333333333FF7F7FFFF333333000090000
        3333333777737777F333333099999990333333373F3333373333333309999903
        333333337F33337F33333333099999033333333373F333733333333330999033
        3333333337F337F3333333333099903333333333373F37333333333333090333
        33333333337F7F33333333333309033333333333337373333333333333303333
        333333333337F333333333333330333333333333333733333333}
      NumGlyphs = 2
    end
    object sbDown: TSpeedButton [1]
      Left = 216
      Top = 1
      Width = 23
      Height = 25
      Hint = #1055#1077#1088#1077#1084#1077#1089#1090#1080#1090#1100' '#1074#1085#1080#1079
      Action = aNodeDown
      Enabled = False
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333303333
        333333333337F33333333333333033333333333333373F333333333333090333
        33333333337F7F33333333333309033333333333337373F33333333330999033
        3333333337F337F33333333330999033333333333733373F3333333309999903
        333333337F33337F33333333099999033333333373333373F333333099999990
        33333337FFFF3FF7F33333300009000033333337777F77773333333333090333
        33333333337F7F33333333333309033333333333337F7F333333333333090333
        33333333337F7F33333333333309033333333333337F7F333333333333090333
        33333333337F7F33333333333300033333333333337773333333}
      NumGlyphs = 2
    end
    inherited iplClose: TPanel
      Left = 769
    end
  end
  object Panel7: TPanel [1]
    Left = 0
    Top = 0
    Width = 335
    Height = 704
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object Panel8: TPanel
      Left = 0
      Top = 0
      Width = 335
      Height = 20
      Align = alTop
      Caption = #1044#1077#1088#1077#1074#1086' '#1086#1073#1098#1077#1082#1090#1086#1074
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
    object TreeView1: TTreeView
      Left = 0
      Top = 20
      Width = 335
      Height = 684
      Align = alClient
      DragMode = dmAutomatic
      HideSelection = False
      Images = iImageList
      Indent = 19
      PopupMenu = PopupMenu1
      ReadOnly = True
      TabOrder = 0
      OnChange = TreeView1Change
      OnChanging = TreeView1Changing
      OnCollapsed = tvMainExpCol
      OnDeletion = TreeView1Deletion
      OnDragDrop = TreeView1DragDrop
      OnDragOver = TreeView1DragOver
      OnExpanding = TreeView1Expanding
      OnExpanded = tvMainExpCol
    end
  end
  object Panel3: TPanel [2]
    Left = 335
    Top = 0
    Width = 515
    Height = 704
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 1
    object Panel4: TPanel
      Left = 0
      Top = 0
      Width = 515
      Height = 677
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      object pcMain: TPageControl
        Left = 0
        Top = 0
        Width = 515
        Height = 677
        ActivePage = tsParam
        Align = alClient
        TabIndex = 0
        TabOrder = 0
        object tsParam: TTabSheet
          Caption = #1054#1089#1085#1086#1074#1085#1099#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1099
          object paOldEdit: TPanel
            Left = 17
            Top = 0
            Width = 490
            Height = 649
            Align = alRight
            BevelInner = bvLowered
            BevelOuter = bvNone
            TabOrder = 0
            object ScrollBox1: TScrollBox
              Left = 1
              Top = 1
              Width = 488
              Height = 647
              HelpContext = 5215
              VertScrollBar.Position = 54
              Align = alClient
              BorderStyle = bsNone
              TabOrder = 0
              object paEdit: TPanel
                Left = 5
                Top = -4
                Width = 463
                Height = 651
                BevelOuter = bvNone
                TabOrder = 1
                object Panel10: TPanel
                  Left = 0
                  Top = 0
                  Width = 463
                  Height = 24
                  Align = alTop
                  BevelOuter = bvNone
                  TabOrder = 0
                  object Label3: TLabel
                    Left = 300
                    Top = 6
                    Width = 54
                    Height = 13
                    Caption = #1058#1101#1075' '#1089#1074#1103#1079#1080':'
                    Font.Charset = RUSSIAN_CHARSET
                    Font.Color = clBlack
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                  end
                  object lCode: TLabel
                    Left = 1
                    Top = 6
                    Width = 53
                    Height = 13
                    Caption = #1050#1086#1076' '#1090#1086#1095#1082#1080':'
                  end
                  object Edit12: TEdit
                    Left = 368
                    Top = 2
                    Width = 94
                    Height = 21
                    MaxLength = 8
                    TabOrder = 0
                    OnChange = EditChange
                    OnKeyPress = edLongKeyPress
                  end
                  object eCode: TEdit
                    Left = 71
                    Top = 2
                    Width = 221
                    Height = 21
                    TabOrder = 1
                  end
                end
                object Panel11: TPanel
                  Left = 0
                  Top = 87
                  Width = 463
                  Height = 57
                  Align = alTop
                  BevelOuter = bvNone
                  TabOrder = 3
                  object Panel9: TPanel
                    Left = 0
                    Top = 0
                    Width = 463
                    Height = 16
                    Align = alTop
                    Alignment = taLeftJustify
                    Caption = ' '#1055#1086#1079#1080#1094#1080#1080' '#1085#1072' '#1084#1072#1090#1088#1080#1094#1077' '#1059#1057#1044' :'
                    Font.Charset = RUSSIAN_CHARSET
                    Font.Color = clBlack
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = [fsBold]
                    ParentFont = False
                    TabOrder = 0
                  end
                  object Panel43: TPanel
                    Left = 0
                    Top = 16
                    Width = 463
                    Height = 39
                    Align = alTop
                    Caption = 'Panel43'
                    TabOrder = 1
                    DesignSize = (
                      463
                      39)
                    object Edit3: TEdit
                      Left = 1
                      Top = 17
                      Width = 116
                      Height = 21
                      HelpContext = 5211
                      Anchors = [akLeft, akBottom]
                      Ctl3D = True
                      MaxLength = 8
                      ParentCtl3D = False
                      TabOrder = 0
                      OnChange = EditChange
                      OnExit = Edit3Exit
                      OnKeyPress = edLongKeyPress
                    end
                    object Edit4: TEdit
                      Left = 117
                      Top = 17
                      Width = 115
                      Height = 21
                      HelpContext = 5211
                      Anchors = [akLeft, akBottom]
                      Ctl3D = True
                      MaxLength = 8
                      ParentCtl3D = False
                      TabOrder = 1
                      OnChange = EditChange
                      OnExit = Edit4Exit
                      OnKeyPress = edLongKeyPress
                    end
                    object Edit5: TEdit
                      Left = 231
                      Top = 17
                      Width = 115
                      Height = 21
                      HelpContext = 5211
                      Anchors = [akLeft, akBottom]
                      Ctl3D = True
                      MaxLength = 8
                      ParentCtl3D = False
                      TabOrder = 2
                      OnChange = EditChange
                      OnExit = Edit5Exit
                      OnKeyPress = edLongKeyPress
                    end
                    object Edit6: TEdit
                      Left = 345
                      Top = 17
                      Width = 115
                      Height = 21
                      HelpContext = 5211
                      Anchors = [akLeft, akBottom]
                      Ctl3D = True
                      MaxLength = 8
                      ParentCtl3D = False
                      TabOrder = 3
                      OnChange = EditChange
                      OnExit = Edit6Exit
                      OnKeyPress = edLongKeyPress
                    end
                    object HeaderControl1: THeaderControl
                      Left = 1
                      Top = 1
                      Width = 460
                      Height = 17
                      Align = alNone
                      DragReorder = False
                      Sections = <
                        item
                          Alignment = taCenter
                          AllowClick = False
                          ImageIndex = -1
                          Text = #1040#1082#1090#1080#1074'. '#1087#1088#1080#1085#1103#1090#1072#1103
                          Width = 116
                        end
                        item
                          Alignment = taCenter
                          AllowClick = False
                          ImageIndex = -1
                          Text = #1056#1077#1072#1082#1090#1080#1074'. '#1087#1088#1080#1085#1103#1090#1072#1103
                          Width = 115
                        end
                        item
                          Alignment = taCenter
                          AllowClick = False
                          ImageIndex = -1
                          Text = #1040#1082#1090#1080#1074'. '#1074#1099#1076#1072#1085#1085#1072#1103
                          Width = 115
                        end
                        item
                          Alignment = taCenter
                          AllowClick = False
                          ImageIndex = -1
                          Text = #1056#1077#1072#1082#1090#1080#1074'. '#1074#1099#1076#1072#1085#1085#1072#1103
                          Width = 116
                        end>
                      Style = hsFlat
                    end
                  end
                end
                object Panel12: TPanel
                  Left = 0
                  Top = 144
                  Width = 463
                  Height = 153
                  Align = alTop
                  BevelOuter = bvNone
                  TabOrder = 4
                  object Panel18: TPanel
                    Left = 0
                    Top = 0
                    Width = 463
                    Height = 16
                    Align = alTop
                    Alignment = taLeftJustify
                    Caption = ' '#1059#1082#1072#1079#1072#1090#1077#1083#1100' '#1080#1085#1090#1077#1083#1083#1077#1082#1090#1091#1072#1083#1100#1085#1086#1075#1086' '#1089#1095#1077#1090#1095#1080#1082#1072' :'
                    Font.Charset = RUSSIAN_CHARSET
                    Font.Color = clBlack
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = [fsBold]
                    ParentFont = False
                    TabOrder = 0
                  end
                  object Panel15: TPanel
                    Left = 0
                    Top = 16
                    Width = 463
                    Height = 135
                    Align = alTop
                    TabOrder = 1
                    object Panel16: TPanel
                      Left = 1
                      Top = 1
                      Width = 461
                      Height = 78
                      HelpContext = 5212
                      Align = alTop
                      BevelInner = bvLowered
                      BevelOuter = bvNone
                      TabOrder = 0
                      object Label32: TLabel
                        Left = 4
                        Top = 33
                        Width = 60
                        Height = 13
                        Caption = #1057#1074#1103#1079#1085#1086#1081' '#8470':'
                      end
                      object lbIntegr: TLabel
                        Left = 181
                        Top = 33
                        Width = 134
                        Height = 13
                        Caption = #1055#1077#1088#1080#1086#1076' '#1080#1085#1090#1077#1075#1088#1072#1094#1080#1080', '#1084#1080#1085'. :'
                      end
                      object lbDopNum: TLabel
                        Left = 4
                        Top = 57
                        Width = 86
                        Height = 13
                        Caption = #1044#1086#1087'. '#1089#1074#1103#1079#1085#1086#1081' '#8470':'
                      end
                      object lbCapStateOFF: TLabel
                        Left = 181
                        Top = 57
                        Width = 77
                        Height = 13
                        Caption = #1056#1077#1083#1077' '#1085#1072#1075#1088#1091#1079#1082#1080':'
                      end
                      object lbStateOFF: TLabel
                        Left = 293
                        Top = 57
                        Width = 3
                        Height = 13
                      end
                      object CheckBox1: TCheckBox
                        Left = 4
                        Top = 7
                        Width = 86
                        Height = 18
                        Caption = '&'#1048#1085#1090'. '#1089#1095#1077#1090#1095#1080#1082
                        TabOrder = 0
                        OnClick = CheckBoxClick
                      end
                      object CheckBox2: TCheckBox
                        Left = 93
                        Top = 7
                        Width = 83
                        Height = 17
                        Caption = '&'#1050#1074#1072#1076#1088#1072#1085#1090#1099
                        TabOrder = 1
                        OnClick = CheckBoxClick
                      end
                      object Edit7: TEdit
                        Left = 96
                        Top = 27
                        Width = 68
                        Height = 21
                        MaxLength = 10
                        TabOrder = 4
                        OnChange = EditChange
                        OnKeyPress = edLongKeyPress
                      end
                      object cbBlockAutomaticPoll: TCheckBox
                        Left = 179
                        Top = 7
                        Width = 88
                        Height = 16
                        Caption = #1041#1083#1086#1082'. '#1086#1087#1088#1086#1089#1072
                        TabOrder = 2
                      end
                      object CheckBox5: TCheckBox
                        Left = 276
                        Top = 7
                        Width = 163
                        Height = 16
                        Caption = #1041#1083#1086#1082'. '#1082#1086#1088#1088#1077#1082#1094#1080#1080' '#1074#1088#1077#1084#1077#1085#1080
                        TabOrder = 3
                      end
                      object cbIntgr: TComboBox
                        Left = 324
                        Top = 27
                        Width = 55
                        Height = 21
                        Style = csDropDownList
                        ItemHeight = 13
                        TabOrder = 5
                        OnChange = cbIntgrChange
                      end
                      object eDopNum: TEdit
                        Left = 96
                        Top = 53
                        Width = 68
                        Height = 21
                        MaxLength = 10
                        TabOrder = 6
                        OnChange = EditChange
                        OnKeyPress = edLongKeyPress
                      end
                    end
                    object plUSDPoints: TPanel
                      Left = 1
                      Top = 79
                      Width = 461
                      Height = 27
                      Align = alTop
                      Alignment = taLeftJustify
                      BevelInner = bvLowered
                      BevelOuter = bvNone
                      Caption = ' '#1059#1057#1044' :'
                      Font.Charset = DEFAULT_CHARSET
                      Font.Color = clWindowText
                      Font.Height = -11
                      Font.Name = 'MS Sans Serif'
                      Font.Style = []
                      ParentFont = False
                      TabOrder = 1
                      object btnUSDDrop: TSpeedButton
                        Left = 376
                        Top = 3
                        Width = 21
                        Height = 21
                        Hint = #1059#1076#1072#1083#1080#1090#1100' '#1090#1086#1095#1082#1091' '#1059#1057#1044' '#1076#1083#1103' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1081' '#1090#1086#1095#1082#1080'.'
                        Flat = True
                        Glyph.Data = {
                          1E070000424D1E07000000000000360000002800000022000000110000000100
                          180000000000E806000000000000000000000000000000000000C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8
                          D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
                          0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4C8D0D4C8D0D4C8D0
                          D4FFFFFFC8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8
                          D0D4FFFFFFC8D0D40000C0C0C0C0C0C0C0C0C0040404C0C0C0C0C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0040404C0C0C0C0C0C0C8D0D4
                          C8D0D4C8D0D4808080FFFFFFFFFFFFC8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0
                          D4C8D0D4C8D0D4808080FFFFFFC8D0D40000C0C0C0C0C0C00404040000800404
                          04C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C00000FFC0
                          C0C0C0C0C0C8D0D4C8D0D4808080808080808080FFFFFFFFFFFFC8D0D4C8D0D4
                          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4808080C8D0D4C8D0D40000C0C0C0C0C0C0
                          0000FF0000FF000080040404C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                          C0040404C0C0C0C0C0C0C0C0C0C8D0D4C8D0D4808080808080808080808080FF
                          FFFFC8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4808080FFFFFFC8D0D4C8D0D4
                          0000C0C0C0C0C0C03300CC0000FF0000FF000080C0C0C0C0C0C0C0C0C0C0C0C0
                          C0C0C0C0C0C00404040000FFC0C0C0C0C0C0C0C0C0C8D0D4C8D0D48080808080
                          80808080808080FFFFFFFFFFFFC8D0D4C8D0D4C8D0D4C8D0D4808080808080C8
                          D0D4C8D0D4C8D0D40000C0C0C0C0C0C0C0C0C03300CC0000FF0000FF040404C0
                          C0C0C0C0C0C0C0C0C0C0C00404040000FFC0C0C0C0C0C0C0C0C0C0C0C0C8D0D4
                          C8D0D4C8D0D4808080808080808080808080FFFFFFFFFFFFC8D0D4C8D0D48080
                          80808080FFFFFFC8D0D4C8D0D4C8D0D40000C0C0C0C0C0C0C0C0C0C0C0C03300
                          CC0000FF0000FF040404C0C0C0C0C0C00404040000FF0000FFC0C0C0C0C0C0C0
                          C0C0C0C0C0C8D0D4C8D0D4C8D0D4C8D0D4808080808080808080808080FFFFFF
                          FFFFFF808080808080808080C8D0D4C8D0D4C8D0D4C8D0D40000C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C03300CC0000FF0000FF0404040404040000FF0000FFC0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4C8D0D4C8D0D4C8D0D4C8D0D480808080
                          8080808080808080808080808080808080C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
                          0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C03300CC0000FF0000FF0000FF
                          0000FFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4C8D0D4C8D0D4C8D0
                          D4C8D0D4C8D0D4808080808080808080808080808080FFFFFFC8D0D4C8D0D4C8
                          D0D4C8D0D4C8D0D40000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C004040400
                          00FF0000FF0000FF040404C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4
                          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4808080808080808080808080808080FFFF
                          FFFFFFFFC8D0D4C8D0D4C8D0D4C8D0D40000C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                          C00404040000FF0000FF0000FF0000FF0000FF040404C0C0C0C0C0C0C0C0C0C0
                          C0C0C0C0C0C8D0D4C8D0D4C8D0D4C8D0D4FFFFFF808080808080808080808080
                          808080808080808080FFFFFFFFFFFFC8D0D4C8D0D4C8D0D40000C0C0C0C0C0C0
                          C0C0C00404040404040000FF0000FF0000FFC0C0C0C0C0C00000FF0000FF0404
                          04C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4C8D0D4C8D0D480808080808080808080
                          8080808080C8D0D4C8D0D4808080808080808080FFFFFFFFFFFFC8D0D4C8D0D4
                          0000C0C0C0C0C0C00404040000FF0000FF0000FF0000FFC0C0C0C0C0C0C0C0C0
                          C0C0C00000FF0000FF040404C0C0C0C0C0C0C0C0C0C8D0D4C8D0D48080808080
                          80808080808080808080C8D0D4C8D0D4C8D0D4C8D0D4808080808080808080FF
                          FFFFFFFFFFC8D0D40000C0C0C0C0C0C00000FF0000FF0000FF0000FFC0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C00000FF0000FF040404C0C0C0C0C0C0C8D0D4
                          C8D0D4808080808080808080808080C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0
                          D4808080808080808080FFFFFFC8D0D40000C0C0C0C0C0C00000FF0000FF0000
                          FFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C00000FFC0
                          C0C0C0C0C0C8D0D4C8D0D4808080808080808080C8D0D4C8D0D4C8D0D4C8D0D4
                          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4808080C8D0D4C8D0D40000C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8
                          D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
                          0000}
                        NumGlyphs = 2
                        ParentShowHint = False
                        ShowHint = True
                        OnClick = btnUSDDropClick
                      end
                      object btnUSDSelect: TSpeedButton
                        Left = 355
                        Top = 3
                        Width = 21
                        Height = 21
                        Hint = #1054#1087#1088#1077#1076#1077#1083#1080#1090#1100' '#1090#1086#1095#1082#1091' '#1059#1057#1044' '#1080#1079' '#1087#1077#1088#1077#1095#1085#1103' '#1074#1089#1077#1093' '#1090#1086#1095#1077#1082'.'
                        Flat = True
                        Glyph.Data = {
                          1E070000424D1E07000000000000360000002800000022000000110000000100
                          180000000000E806000000000000000000000000000000000000C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8
                          D0D4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                          0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0040404040404040404
                          040404040404040404040404040404040404040404C8D0D4C8D0D4C8D0D4C8D0
                          D4C8D0D4C8D0D480808080808080808080808080808080808080808080808080
                          8080808080FFFFFF0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C004
                          0404FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF040404C8D0D4
                          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4808080FFFFFFC8D0D4C8D0D4C8D0D4FFFF
                          FFFFFFFFC8D0D4C8D0D4808080FFFFFF0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                          C0C0C0C0C0C0C0040404FFFFFFFFFFFFFFFFFF808000808000FFFFFFFFFFFFFF
                          FFFF040404C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4808080FFFFFFC8D0D4
                          C8D0D4808080808080FFFFFFFFFFFFC8D0D4808080FFFFFF0000C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0040404FFFFFFFFFFFF8080008080008080
                          00808000FFFFFFFFFFFF040404C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D480
                          8080FFFFFFC8D0D4808080808080808080808080FFFFFFC8D0D4808080FFFFFF
                          0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0040404FFFFFFFFFFFF
                          808000808000808000808000FFFFFFFFFFFF040404C8D0D4C8D0D4C8D0D4C8D0
                          D4C8D0D4C8D0D4808080FFFFFFC8D0D4808080808080808080808080C8D0D4C8
                          D0D4808080FFFFFF0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C004
                          0404FFFFFFFFFFFFFFFFFF808000808000FFFFFFFFFFFFFFFFFF040404C8D0D4
                          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4808080FFFFFFC8D0D4C8D0D48080808080
                          80C8D0D4C8D0D4C8D0D4808080FFFFFF0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                          C0C0C0C0C0C0C0040404FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                          FFFF040404C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4808080FFFFFFFFFFFF
                          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF808080FFFFFF0000C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C00404040404040404040404040404040404
                          04040404040404040404040404C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D480
                          8080808080808080808080808080808080808080808080808080808080C8D0D4
                          0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                          C0C0C0C0C0C0008000C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4FFFFFFFFFFFFFFFF
                          FFFFFFFFFFFFFFFFFFFFC8D0D4C8D0D4C8D0D4C8D0D4808080FFFFFFFFFFFFC8
                          D0D4C8D0D4C8D0D40000C0C0C0040404040404040404040404040404040404C0
                          C0C0C0C0C0C0C0C0C0C0C0008000008000008000C0C0C0C0C0C0C0C0C0808080
                          808080808080808080808080808080FFFFFFC8D0D4C8D0D4C8D0D48080808080
                          80808080C8D0D4C8D0D4C8D0D4C8D0D40000C0C0C0040404FFFFFFFFFFFFFFFF
                          FFFFFFFF040404C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0008000C0C0C0C0C0C0C0
                          C0C0C0C0C0808080FFFFFFC8D0D4FFFFFFFFFFFF808080FFFFFFC8D0D4FFFFFF
                          C8D0D4C8D0D4808080FFFFFFC8D0D4C8D0D4C8D0D4C8D0D40000C0C0C0040404
                          FFFFFF808000808000FFFFFF040404C0C0C0008000C0C0C0C0C0C00080000080
                          00C0C0C0C0C0C0C0C0C0C0C0C0808080FFFFFF808080808080FFFFFF808080FF
                          FFFF808080FFFFFFFFFFFF808080808080C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
                          0000C0C0C0040404FFFFFF808000808000FFFFFF040404008000008000008000
                          008000008000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0808080FFFFFF8080808080
                          80C8D0D4808080808080808080808080808080808080C8D0D4C8D0D4C8D0D4C8
                          D0D4C8D0D4C8D0D40000C0C0C0040404FFFFFFFFFFFFFFFFFFFFFFFF040404C0
                          C0C0008000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0808080
                          FFFFFFFFFFFFFFFFFFFFFFFF808080FFFFFF808080C8D0D4C8D0D4C8D0D4C8D0
                          D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D40000C0C0C00404040404040404040404
                          04040404040404C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                          C0C0C0C0C0808080808080808080808080808080808080C8D0D4C8D0D4C8D0D4
                          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D40000C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8
                          D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
                          0000}
                        NumGlyphs = 2
                        ParentShowHint = False
                        ShowHint = True
                        OnClick = btnUSDSelectClick
                      end
                      object sbUSDList: TSpeedButton
                        Left = 397
                        Top = 3
                        Width = 41
                        Height = 21
                        Hint = #1054#1090#1082#1088#1099#1090#1100' '#1087#1077#1088#1077#1095#1077#1085#1100' '#1090#1086#1095#1077#1082', '#1076#1083#1103' '#1082#1086#1090#1086#1088#1099#1093' '#1090#1077#1082#1091#1097#1072#1103' '#1103#1074#1083#1103#1077#1090#1089#1103' '#1059#1057#1044
                        Flat = True
                        Glyph.Data = {
                          F6060000424DF60600000000000036000000280000001F000000120000000100
                          180000000000C0060000C40E0000C40E00000000000000000000800080800080
                          8000808000808000808000808000808000808000808000808000808000808000
                          80800080800080800080800080800080800080808080FFFFFF80008080008080
                          0080800080800080800080800080800080800080800080000000000000000000
                          0000000000000000000000000000000000000000000000000000000000000000
                          00000000000000000000800080800080800080808080FFFFFF80008080008080
                          0080800080800080800080800080800080800080800080000000000000800080
                          8000808000808000808000808000808000808000808000808000808000808000
                          80800080800080000000800080800080800080808080FFFFFF80008080008080
                          0080800080800080800080800080800080800080800080000000000000800080
                          8000808000808000808000808000808000808000808000808000808000808000
                          80800080800080000000800080800080800080808080FFFFFF80008080008080
                          0080800080800080800080800080800080800080800080000000000000800080
                          8000808080808080808080808080808000808000808080808080808080808080
                          80800080800080000000800080800080800080808080FFFFFF80008080008080
                          0080800080800080800080800080800080800080800080000000000000800080
                          0000000000000000000000008000808000800000000000000000000000008000
                          80800080800080000000800080800080800080808080FFFFFF80008080008080
                          0080800080800080800080800080800080800080800080000000000000800080
                          8000808000808000808000808000808000808000808000808000808000808000
                          80800080800080000000800080800080800080808080FFFFFF80008080008080
                          0080800080800080800080800080800080800080800080000000000000800080
                          8000808080808080808080808080808000808080808080808080808080808080
                          80800080800080000000800080800080800080808080FFFFFF80008080008080
                          0080800080800080800080800080800080800080800080000000000000800080
                          0000000000000000000000008000808000800000000000000000000000008000
                          80800080800080000000800080800080800080808080FFFFFF80008080008080
                          0080800080800080000000800080800080800080800080000000000000800080
                          8000808000808000808000808000808000808000808000808000808000808000
                          80800080800080000000800080800080800080808080FFFFFF80008080008080
                          0080800080000000000000000000800080800080800080000000000000800080
                          8000808080808080808080808080808000808000808080808080808080808080
                          80800080800080000000800080800080800080808080FFFFFF80008080008080
                          0080000000000000000000000000000000800080800080000000000000800080
                          0000000000000000000000008000808000800000000000000000000000008000
                          80800080800080000000800080800080800080808080FFFFFF80008080008000
                          0000000000000000000000000000000000000000800080000000000000800080
                          8000808000808000808000808000808000808000808000808000808000808000
                          80800080800080000000800080800080800080808080FFFFFF80008080008080
                          0080800080800080800080800080800080800080800080000000000000800080
                          8000808080808080808080808080808000808000808080808080808080808080
                          80800080800080000000800080800080800080808080FFFFFF80008080008080
                          0080800080800080800080800080800080800080800080000000000000800080
                          0000000000000000000000008000808000800000000000000000000000008000
                          80800080800080000000800080800080800080808080FFFFFF80008080008080
                          0080800080800080800080800080800080800080800080000000000000800080
                          8000808000808000808000808000808000808000808000808000808000808000
                          80800080800080000000800080800080800080808080FFFFFF80008080008080
                          0080800080800080800080800080800080800080800080000000000000000000
                          0000000000000000000000000000000000000000000000000000000000000000
                          00000000000000000000800080800080800080808080FFFFFF80008080008080
                          0080800080800080800080800080800080800080800080000000800080800080
                          8000808000808000808000808000808000808000808000808000808000808000
                          80800080800080800080800080800080800080808080FFFFFF80008080008080
                          0080800080800080800080800080800080800080800080000000}
                        ParentShowHint = False
                        ShowHint = True
                        OnClick = sbUSDListClick
                      end
                      object eUSDPoint: TEdit
                        Tag = 9
                        Left = 70
                        Top = 3
                        Width = 283
                        Height = 21
                        Color = clMenu
                        ReadOnly = True
                        TabOrder = 0
                      end
                    end
                    object plDuplPoints: TPanel
                      Left = 1
                      Top = 106
                      Width = 461
                      Height = 27
                      Align = alTop
                      Alignment = taLeftJustify
                      BevelInner = bvLowered
                      BevelOuter = bvNone
                      Caption = ' '#1054#1089#1085#1086#1074#1085#1086#1081' :'
                      Font.Charset = DEFAULT_CHARSET
                      Font.Color = clWindowText
                      Font.Height = -11
                      Font.Name = 'MS Sans Serif'
                      Font.Style = []
                      ParentFont = False
                      TabOrder = 2
                      object btnMainDrop: TSpeedButton
                        Left = 376
                        Top = 3
                        Width = 21
                        Height = 21
                        Hint = #1059#1076#1072#1083#1080#1090#1100' '#1087#1088#1080#1079#1085#1072#1082' '#1076#1091#1073#1083#1080#1088#1091#1102#1097#1077#1075#1086' '#1076#1083#1103' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1081' '#1090#1086#1095#1082#1080'.'
                        Flat = True
                        Glyph.Data = {
                          1E070000424D1E07000000000000360000002800000022000000110000000100
                          180000000000E806000000000000000000000000000000000000C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8
                          D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
                          0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4C8D0D4C8D0D4C8D0
                          D4FFFFFFC8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8
                          D0D4FFFFFFC8D0D40000C0C0C0C0C0C0C0C0C0040404C0C0C0C0C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0040404C0C0C0C0C0C0C8D0D4
                          C8D0D4C8D0D4808080FFFFFFFFFFFFC8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0
                          D4C8D0D4C8D0D4808080FFFFFFC8D0D40000C0C0C0C0C0C00404040000800404
                          04C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C00000FFC0
                          C0C0C0C0C0C8D0D4C8D0D4808080808080808080FFFFFFFFFFFFC8D0D4C8D0D4
                          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4808080C8D0D4C8D0D40000C0C0C0C0C0C0
                          0000FF0000FF000080040404C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                          C0040404C0C0C0C0C0C0C0C0C0C8D0D4C8D0D4808080808080808080808080FF
                          FFFFC8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4808080FFFFFFC8D0D4C8D0D4
                          0000C0C0C0C0C0C03300CC0000FF0000FF000080C0C0C0C0C0C0C0C0C0C0C0C0
                          C0C0C0C0C0C00404040000FFC0C0C0C0C0C0C0C0C0C8D0D4C8D0D48080808080
                          80808080808080FFFFFFFFFFFFC8D0D4C8D0D4C8D0D4C8D0D4808080808080C8
                          D0D4C8D0D4C8D0D40000C0C0C0C0C0C0C0C0C03300CC0000FF0000FF040404C0
                          C0C0C0C0C0C0C0C0C0C0C00404040000FFC0C0C0C0C0C0C0C0C0C0C0C0C8D0D4
                          C8D0D4C8D0D4808080808080808080808080FFFFFFFFFFFFC8D0D4C8D0D48080
                          80808080FFFFFFC8D0D4C8D0D4C8D0D40000C0C0C0C0C0C0C0C0C0C0C0C03300
                          CC0000FF0000FF040404C0C0C0C0C0C00404040000FF0000FFC0C0C0C0C0C0C0
                          C0C0C0C0C0C8D0D4C8D0D4C8D0D4C8D0D4808080808080808080808080FFFFFF
                          FFFFFF808080808080808080C8D0D4C8D0D4C8D0D4C8D0D40000C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C03300CC0000FF0000FF0404040404040000FF0000FFC0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4C8D0D4C8D0D4C8D0D4C8D0D480808080
                          8080808080808080808080808080808080C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
                          0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C03300CC0000FF0000FF0000FF
                          0000FFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4C8D0D4C8D0D4C8D0
                          D4C8D0D4C8D0D4808080808080808080808080808080FFFFFFC8D0D4C8D0D4C8
                          D0D4C8D0D4C8D0D40000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C004040400
                          00FF0000FF0000FF040404C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4
                          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4808080808080808080808080808080FFFF
                          FFFFFFFFC8D0D4C8D0D4C8D0D4C8D0D40000C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                          C00404040000FF0000FF0000FF0000FF0000FF040404C0C0C0C0C0C0C0C0C0C0
                          C0C0C0C0C0C8D0D4C8D0D4C8D0D4C8D0D4FFFFFF808080808080808080808080
                          808080808080808080FFFFFFFFFFFFC8D0D4C8D0D4C8D0D40000C0C0C0C0C0C0
                          C0C0C00404040404040000FF0000FF0000FFC0C0C0C0C0C00000FF0000FF0404
                          04C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4C8D0D4C8D0D480808080808080808080
                          8080808080C8D0D4C8D0D4808080808080808080FFFFFFFFFFFFC8D0D4C8D0D4
                          0000C0C0C0C0C0C00404040000FF0000FF0000FF0000FFC0C0C0C0C0C0C0C0C0
                          C0C0C00000FF0000FF040404C0C0C0C0C0C0C0C0C0C8D0D4C8D0D48080808080
                          80808080808080808080C8D0D4C8D0D4C8D0D4C8D0D4808080808080808080FF
                          FFFFFFFFFFC8D0D40000C0C0C0C0C0C00000FF0000FF0000FF0000FFC0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C00000FF0000FF040404C0C0C0C0C0C0C8D0D4
                          C8D0D4808080808080808080808080C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0
                          D4808080808080808080FFFFFFC8D0D40000C0C0C0C0C0C00000FF0000FF0000
                          FFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C00000FFC0
                          C0C0C0C0C0C8D0D4C8D0D4808080808080808080C8D0D4C8D0D4C8D0D4C8D0D4
                          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4808080C8D0D4C8D0D40000C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8
                          D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
                          0000}
                        NumGlyphs = 2
                        ParentShowHint = False
                        ShowHint = True
                        OnClick = btnMainDropClick
                      end
                      object btnMainSelect: TSpeedButton
                        Left = 355
                        Top = 3
                        Width = 21
                        Height = 21
                        Hint = #1054#1087#1088#1077#1076#1077#1083#1080#1090#1100' '#1086#1089#1085#1086#1074#1085#1091#1102' '#1090#1086#1095#1082#1091' '#1080#1079' '#1087#1077#1088#1077#1095#1085#1103' '#1074#1089#1077#1093' '#1090#1086#1095#1077#1082'.'
                        Flat = True
                        Glyph.Data = {
                          1E070000424D1E07000000000000360000002800000022000000110000000100
                          180000000000E806000000000000000000000000000000000000C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8
                          D0D4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                          0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0040404040404040404
                          040404040404040404040404040404040404040404C8D0D4C8D0D4C8D0D4C8D0
                          D4C8D0D4C8D0D480808080808080808080808080808080808080808080808080
                          8080808080FFFFFF0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C004
                          0404FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF040404C8D0D4
                          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4808080FFFFFFC8D0D4C8D0D4C8D0D4FFFF
                          FFFFFFFFC8D0D4C8D0D4808080FFFFFF0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                          C0C0C0C0C0C0C0040404FFFFFFFFFFFFFFFFFF808000808000FFFFFFFFFFFFFF
                          FFFF040404C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4808080FFFFFFC8D0D4
                          C8D0D4808080808080FFFFFFFFFFFFC8D0D4808080FFFFFF0000C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0040404FFFFFFFFFFFF8080008080008080
                          00808000FFFFFFFFFFFF040404C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D480
                          8080FFFFFFC8D0D4808080808080808080808080FFFFFFC8D0D4808080FFFFFF
                          0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0040404FFFFFFFFFFFF
                          808000808000808000808000FFFFFFFFFFFF040404C8D0D4C8D0D4C8D0D4C8D0
                          D4C8D0D4C8D0D4808080FFFFFFC8D0D4808080808080808080808080C8D0D4C8
                          D0D4808080FFFFFF0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C004
                          0404FFFFFFFFFFFFFFFFFF808000808000FFFFFFFFFFFFFFFFFF040404C8D0D4
                          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4808080FFFFFFC8D0D4C8D0D48080808080
                          80C8D0D4C8D0D4C8D0D4808080FFFFFF0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                          C0C0C0C0C0C0C0040404FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                          FFFF040404C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4808080FFFFFFFFFFFF
                          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF808080FFFFFF0000C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C00404040404040404040404040404040404
                          04040404040404040404040404C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D480
                          8080808080808080808080808080808080808080808080808080808080C8D0D4
                          0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                          C0C0C0C0C0C0008000C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4FFFFFFFFFFFFFFFF
                          FFFFFFFFFFFFFFFFFFFFC8D0D4C8D0D4C8D0D4C8D0D4808080FFFFFFFFFFFFC8
                          D0D4C8D0D4C8D0D40000C0C0C0040404040404040404040404040404040404C0
                          C0C0C0C0C0C0C0C0C0C0C0008000008000008000C0C0C0C0C0C0C0C0C0808080
                          808080808080808080808080808080FFFFFFC8D0D4C8D0D4C8D0D48080808080
                          80808080C8D0D4C8D0D4C8D0D4C8D0D40000C0C0C0040404FFFFFFFFFFFFFFFF
                          FFFFFFFF040404C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0008000C0C0C0C0C0C0C0
                          C0C0C0C0C0808080FFFFFFC8D0D4FFFFFFFFFFFF808080FFFFFFC8D0D4FFFFFF
                          C8D0D4C8D0D4808080FFFFFFC8D0D4C8D0D4C8D0D4C8D0D40000C0C0C0040404
                          FFFFFF808000808000FFFFFF040404C0C0C0008000C0C0C0C0C0C00080000080
                          00C0C0C0C0C0C0C0C0C0C0C0C0808080FFFFFF808080808080FFFFFF808080FF
                          FFFF808080FFFFFFFFFFFF808080808080C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
                          0000C0C0C0040404FFFFFF808000808000FFFFFF040404008000008000008000
                          008000008000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0808080FFFFFF8080808080
                          80C8D0D4808080808080808080808080808080808080C8D0D4C8D0D4C8D0D4C8
                          D0D4C8D0D4C8D0D40000C0C0C0040404FFFFFFFFFFFFFFFFFFFFFFFF040404C0
                          C0C0008000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0808080
                          FFFFFFFFFFFFFFFFFFFFFFFF808080FFFFFF808080C8D0D4C8D0D4C8D0D4C8D0
                          D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D40000C0C0C00404040404040404040404
                          04040404040404C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                          C0C0C0C0C0808080808080808080808080808080808080C8D0D4C8D0D4C8D0D4
                          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D40000C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8
                          D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
                          0000}
                        NumGlyphs = 2
                        ParentShowHint = False
                        ShowHint = True
                        OnClick = btnMainSelectClick
                      end
                      object sbMainList: TSpeedButton
                        Left = 397
                        Top = 3
                        Width = 41
                        Height = 21
                        Hint = #1054#1090#1082#1088#1099#1090#1100' '#1087#1077#1088#1077#1095#1077#1085#1100' '#1076#1091#1073#1083#1080#1088#1091#1102#1097#1080#1093' '#1090#1086#1095#1077#1082' '#1076#1083#1103' '#1090#1077#1082#1091#1097#1077#1081'.'
                        Flat = True
                        Glyph.Data = {
                          F6060000424DF60600000000000036000000280000001F000000120000000100
                          180000000000C0060000C40E0000C40E00000000000000000000800080800080
                          8000808000808000808000808000808000808000808000808000808000808000
                          80800080800080800080800080800080800080808080FFFFFF80008080008080
                          0080800080800080800080800080800080800080800080000000000000000000
                          0000000000000000000000000000000000000000000000000000000000000000
                          00000000000000000000800080800080800080808080FFFFFF80008080008080
                          0080800080800080800080800080800080800080800080000000000000800080
                          8000808000808000808000808000808000808000808000808000808000808000
                          80800080800080000000800080800080800080808080FFFFFF80008080008080
                          0080800080800080800080800080800080800080800080000000000000800080
                          8000808000808000808000808000808000808000808000808000808000808000
                          80800080800080000000800080800080800080808080FFFFFF80008080008080
                          0080800080800080800080800080800080800080800080000000000000800080
                          8000808080808080808080808080808000808000808080808080808080808080
                          80800080800080000000800080800080800080808080FFFFFF80008080008080
                          0080800080800080800080800080800080800080800080000000000000800080
                          0000000000000000000000008000808000800000000000000000000000008000
                          80800080800080000000800080800080800080808080FFFFFF80008080008080
                          0080800080800080800080800080800080800080800080000000000000800080
                          8000808000808000808000808000808000808000808000808000808000808000
                          80800080800080000000800080800080800080808080FFFFFF80008080008080
                          0080800080800080800080800080800080800080800080000000000000800080
                          8000808080808080808080808080808000808080808080808080808080808080
                          80800080800080000000800080800080800080808080FFFFFF80008080008080
                          0080800080800080800080800080800080800080800080000000000000800080
                          0000000000000000000000008000808000800000000000000000000000008000
                          80800080800080000000800080800080800080808080FFFFFF80008080008080
                          0080800080800080000000800080800080800080800080000000000000800080
                          8000808000808000808000808000808000808000808000808000808000808000
                          80800080800080000000800080800080800080808080FFFFFF80008080008080
                          0080800080000000000000000000800080800080800080000000000000800080
                          8000808080808080808080808080808000808000808080808080808080808080
                          80800080800080000000800080800080800080808080FFFFFF80008080008080
                          0080000000000000000000000000000000800080800080000000000000800080
                          0000000000000000000000008000808000800000000000000000000000008000
                          80800080800080000000800080800080800080808080FFFFFF80008080008000
                          0000000000000000000000000000000000000000800080000000000000800080
                          8000808000808000808000808000808000808000808000808000808000808000
                          80800080800080000000800080800080800080808080FFFFFF80008080008080
                          0080800080800080800080800080800080800080800080000000000000800080
                          8000808080808080808080808080808000808000808080808080808080808080
                          80800080800080000000800080800080800080808080FFFFFF80008080008080
                          0080800080800080800080800080800080800080800080000000000000800080
                          0000000000000000000000008000808000800000000000000000000000008000
                          80800080800080000000800080800080800080808080FFFFFF80008080008080
                          0080800080800080800080800080800080800080800080000000000000800080
                          8000808000808000808000808000808000808000808000808000808000808000
                          80800080800080000000800080800080800080808080FFFFFF80008080008080
                          0080800080800080800080800080800080800080800080000000000000000000
                          0000000000000000000000000000000000000000000000000000000000000000
                          00000000000000000000800080800080800080808080FFFFFF80008080008080
                          0080800080800080800080800080800080800080800080000000800080800080
                          8000808000808000808000808000808000808000808000808000808000808000
                          80800080800080800080800080800080800080808080FFFFFF80008080008080
                          0080800080800080800080800080800080800080800080000000}
                        ParentShowHint = False
                        ShowHint = True
                        OnClick = sbMainListClick
                      end
                      object eDuplPoint: TEdit
                        Tag = 9
                        Left = 70
                        Top = 3
                        Width = 283
                        Height = 21
                        Color = clMenu
                        ReadOnly = True
                        TabOrder = 0
                      end
                    end
                  end
                end
                object Panel17: TPanel
                  Left = 0
                  Top = 343
                  Width = 463
                  Height = 216
                  Align = alTop
                  BevelOuter = bvNone
                  TabOrder = 6
                  object Panel20: TPanel
                    Left = 0
                    Top = 16
                    Width = 463
                    Height = 199
                    HelpContext = 5213
                    Align = alTop
                    BevelInner = bvRaised
                    BevelOuter = bvNone
                    Caption = 'Panel20'
                    TabOrder = 1
                    object plUFirst: TPanel
                      Left = 1
                      Top = 26
                      Width = 230
                      Height = 26
                      Alignment = taLeftJustify
                      BevelInner = bvLowered
                      BevelOuter = bvNone
                      Caption = ' '#1048#1058#1053': U '#1087#1077#1088#1074#1080#1095#1085'., '#1082#1042' :'
                      TabOrder = 2
                      object Edit9: TEdit
                        Left = 124
                        Top = 2
                        Width = 90
                        Height = 21
                        MaxLength = 16
                        TabOrder = 0
                        OnChange = EditChange
                        OnKeyPress = edDoubleKeyPress
                      end
                    end
                    object plIFirst: TPanel
                      Left = 1
                      Top = 52
                      Width = 230
                      Height = 26
                      Alignment = taLeftJustify
                      BevelInner = bvLowered
                      BevelOuter = bvNone
                      Caption = ' '#1048#1058#1058':  I '#1087#1077#1088#1074#1080#1095#1085'., A :'
                      TabOrder = 4
                      object Edit10: TEdit
                        Left = 124
                        Top = 2
                        Width = 90
                        Height = 21
                        MaxLength = 16
                        TabOrder = 0
                        OnChange = EditChange
                        OnKeyPress = edDoubleKeyPress
                      end
                    end
                    object plKMeter: TPanel
                      Left = 1
                      Top = 78
                      Width = 230
                      Height = 26
                      Alignment = taLeftJustify
                      BevelOuter = bvLowered
                      Caption = ' '#1050#1086#1101#1092'. '#1090#1088#1072#1085#1089#1092#1086#1088#1084'. :'
                      TabOrder = 6
                      object sbKMeter: TSpeedButton
                        Left = 193
                        Top = 2
                        Width = 21
                        Height = 21
                        Hint = #1042#1099#1095#1080#1089#1083#1080#1090#1100' '#1082#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090' '#1090#1088#1072#1085#1089#1092#1086#1088#1080#1072#1094#1080#1080
                        Flat = True
                        Glyph.Data = {
                          42020000424D4202000000000000420000002800000010000000100000000100
                          1000030000000002000000000000000000000000000000000000007C0000E003
                          00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
                          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1042B41D1042104210421042104210421863
                          1F7C1F7C1F7C1F7C1F7C1F7C1863596BB41DB41D1863B41DB41D104210421042
                          18631F7C1F7C1F7C1F7C1F7C1863596B186318631863B41D1863B41DB41D1042
                          18631F7C1F7C1F7C1F7C1F7C1863596BB41DB41D7863B41D7863186318631042
                          18631F7C1F7C1F7C1F7C1F7C1863596B1863596B104218631863B41D18631042
                          18631F7C1F7C1F7C1F7C1F7C1863596B186318631863FF7F1863186318631042
                          18631F7C1F7C1F7C1F7C1F7C1863596BB41DB41D596BB41D596B186378631042
                          18631F7C1F7C1F7C1F7C1F7C1863596B1863FE7F1042596B1863004210421042
                          18631F7C1F7C1F7C1F7C1F7C1863596B596B1863596B18631863186318631042
                          18631F7C1F7C1F7C1F7C1F7C1863596B186318631863596B596B596B596B1042
                          18631F7C1F7C1F7C1F7C1F7C1863186318631863186318631863186318631042
                          18631F7C1F7C1F7C1F7C1F7C1863596B1863B41DB41DB41DB41DB41DB41D1042
                          18631F7C1F7C1F7C1F7C1F7C1863FF7FFF7FFF7FFF7FFF7FFF7F7863596B1042
                          18631F7C1F7C1F7C1F7C1F7C1F7C1863186318631863186378637863FF7F1863
                          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
                          1F7C1F7C1F7C}
                        ParentShowHint = False
                        ShowHint = True
                        OnClick = sbKMeterClick
                      end
                      object Edit16: TEdit
                        Left = 124
                        Top = 2
                        Width = 70
                        Height = 21
                        MaxLength = 16
                        TabOrder = 0
                        OnChange = EditChange
                        OnKeyPress = edDoubleKeyPress
                      end
                    end
                    object plCellNum: TPanel
                      Left = 1
                      Top = 1
                      Width = 460
                      Height = 25
                      Alignment = taLeftJustify
                      BevelInner = bvLowered
                      BevelOuter = bvNone
                      Caption = ' '#1053#1086#1084#1077#1088' '#1103#1095#1077#1081#1082#1080' :'
                      TabOrder = 0
                      object Edit8: TEdit
                        Left = 124
                        Top = 2
                        Width = 321
                        Height = 21
                        MaxLength = 8
                        TabOrder = 0
                        OnChange = EditChange
                      end
                    end
                    object plKC: TPanel
                      Left = 231
                      Top = 79
                      Width = 230
                      Height = 25
                      Alignment = taLeftJustify
                      BevelInner = bvLowered
                      BevelOuter = bvNone
                      Caption = ' '#1056#1072#1089#1095#1077#1090#1085#1099#1081' '#1082#1086#1101#1092'. :'
                      TabOrder = 1
                      object sbKC: TSpeedButton
                        Left = 193
                        Top = 2
                        Width = 21
                        Height = 21
                        Hint = #1042#1099#1095#1080#1089#1083#1080#1090#1100' '#1088#1072#1089#1095#1077#1090#1085#1099#1081' '#1082#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090
                        Flat = True
                        Glyph.Data = {
                          42020000424D4202000000000000420000002800000010000000100000000100
                          1000030000000002000000000000000000000000000000000000007C0000E003
                          00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
                          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1042B41D1042104210421042104210421863
                          1F7C1F7C1F7C1F7C1F7C1F7C1863596BB41DB41D1863B41DB41D104210421042
                          18631F7C1F7C1F7C1F7C1F7C1863596B186318631863B41D1863B41DB41D1042
                          18631F7C1F7C1F7C1F7C1F7C1863596BB41DB41D7863B41D7863186318631042
                          18631F7C1F7C1F7C1F7C1F7C1863596B1863596B104218631863B41D18631042
                          18631F7C1F7C1F7C1F7C1F7C1863596B186318631863FF7F1863186318631042
                          18631F7C1F7C1F7C1F7C1F7C1863596BB41DB41D596BB41D596B186378631042
                          18631F7C1F7C1F7C1F7C1F7C1863596B1863FE7F1042596B1863004210421042
                          18631F7C1F7C1F7C1F7C1F7C1863596B596B1863596B18631863186318631042
                          18631F7C1F7C1F7C1F7C1F7C1863596B186318631863596B596B596B596B1042
                          18631F7C1F7C1F7C1F7C1F7C1863186318631863186318631863186318631042
                          18631F7C1F7C1F7C1F7C1F7C1863596B1863B41DB41DB41DB41DB41DB41D1042
                          18631F7C1F7C1F7C1F7C1F7C1863FF7FFF7FFF7FFF7FFF7FFF7F7863596B1042
                          18631F7C1F7C1F7C1F7C1F7C1F7C1863186318631863186378637863FF7F1863
                          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
                          1F7C1F7C1F7C}
                        ParentShowHint = False
                        ShowHint = True
                        OnClick = sbKMeterClick
                      end
                      object Edit15: TEdit
                        Left = 124
                        Top = 2
                        Width = 70
                        Height = 21
                        TabOrder = 0
                        OnChange = EditChange
                        OnKeyPress = edDoubleKeyPress
                      end
                    end
                    object plUSecond: TPanel
                      Left = 231
                      Top = 26
                      Width = 230
                      Height = 26
                      Alignment = taLeftJustify
                      BevelInner = bvLowered
                      BevelOuter = bvNone
                      Caption = ' '#1048#1058#1053': U '#1074#1090#1086#1088#1080#1095#1085'., '#1082#1042' :'
                      TabOrder = 3
                      object Edit14: TEdit
                        Left = 124
                        Top = 2
                        Width = 90
                        Height = 21
                        MaxLength = 16
                        TabOrder = 0
                        OnChange = EditChange
                        OnKeyPress = edDoubleKeyPress
                      end
                    end
                    object plISecond: TPanel
                      Left = 231
                      Top = 52
                      Width = 230
                      Height = 26
                      Alignment = taLeftJustify
                      BevelInner = bvLowered
                      BevelOuter = bvNone
                      Caption = ' '#1048#1058#1058':  I '#1074#1090#1086#1088#1080#1095#1085'., A :'
                      TabOrder = 5
                      object Edit11: TEdit
                        Left = 124
                        Top = 2
                        Width = 90
                        Height = 21
                        MaxLength = 16
                        TabOrder = 0
                        OnChange = EditChange
                        OnKeyPress = edDoubleKeyPress
                      end
                    end
                    object plAddInfo: TPanel
                      Left = 1
                      Top = 130
                      Width = 460
                      Height = 26
                      Alignment = taLeftJustify
                      BevelOuter = bvLowered
                      Caption = ' '#1044#1086#1087'. '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1103' (c'#1095#1077#1090#1095#1080#1082') :'
                      TabOrder = 7
                      object Edit13: TEdit
                        Left = 152
                        Top = 2
                        Width = 293
                        Height = 21
                        MaxLength = 256
                        TabOrder = 0
                        OnChange = EditChange
                      end
                    end
                    object plOV: TPanel
                      Left = 1
                      Top = 156
                      Width = 460
                      Height = 41
                      BevelOuter = bvLowered
                      TabOrder = 10
                      object CheckBox3: TCheckBox
                        Left = 4
                        Top = 2
                        Width = 141
                        Height = 17
                        Caption = '&'#1047#1072#1079#1077#1084#1083#1077#1085#1085#1072#1103' '#1085#1077#1081#1090#1088#1072#1083#1100
                        TabOrder = 0
                      end
                      object CheckBox4: TCheckBox
                        Left = 4
                        Top = 22
                        Width = 147
                        Height = 17
                        Caption = '&'#1054#1073#1093#1086#1076#1085#1086#1081' '#1074#1099#1082#1083#1102#1095#1072#1090#1077#1083#1100
                        TabOrder = 1
                      end
                      object InvertedCB: TCheckBox
                        Left = 153
                        Top = 2
                        Width = 141
                        Height = 17
                        Caption = #1048#1085#1074#1077#1088#1089#1080#1103' &'#1085#1072#1087#1088#1072#1074#1083#1077#1085#1080#1103
                        TabOrder = 2
                      end
                      object cbNLockSwitch: TCheckBox
                        Left = 153
                        Top = 22
                        Width = 140
                        Height = 17
                        Caption = #1053#1077' '#1087#1077#1088#1077#1093#1086#1076#1080#1090' '#1085#1072' '#1054#1042
                        TabOrder = 3
                      end
                      object cbDataWithOB: TCheckBox
                        Left = 303
                        Top = 2
                        Width = 129
                        Height = 17
                        Caption = #1044#1072#1085#1085#1099#1077' '#1089' '#1091'&'#1095#1077#1090#1086#1084' '#1054#1042
                        TabOrder = 4
                      end
                    end
                    object plTimeZoneW: TPanel
                      Left = 1
                      Top = 104
                      Width = 230
                      Height = 26
                      Alignment = taLeftJustify
                      BevelOuter = bvLowered
                      Caption = #1042#1088#1077#1084#1077#1085#1085#1086#1081' '#1087#1086#1103#1089' (UTC-'#1079#1080#1084#1072') :'
                      TabOrder = 8
                      object cbTimeZoneW: TComboBox
                        Left = 156
                        Top = 2
                        Width = 60
                        Height = 21
                        Style = csDropDownList
                        ItemHeight = 13
                        TabOrder = 0
                        OnChange = cbTimeZoneChange
                        Items.Strings = (
                          '-14'
                          '-13'
                          '-12'
                          '-11'
                          '-10'
                          '-9'
                          '-8'
                          '-7'
                          '-6'
                          '-5'
                          '-4'
                          '-3'
                          '-2'
                          '-1'
                          '+0'
                          '+1'
                          '+2'
                          '+3'
                          '+4'
                          '+5'
                          '+6'
                          '+7'
                          '+8'
                          '+9'
                          '+10'
                          '+11'
                          '+12'
                          '+13'
                          '+14')
                      end
                    end
                    object plTimeZoneS: TPanel
                      Left = 231
                      Top = 104
                      Width = 230
                      Height = 26
                      Alignment = taLeftJustify
                      BevelOuter = bvLowered
                      Caption = #1042#1088#1077#1084#1077#1085#1085#1086#1081' '#1087#1086#1103#1089' (UTC-'#1083#1077#1090#1086') :'
                      TabOrder = 9
                      object cbTimeZoneS: TComboBox
                        Left = 152
                        Top = 2
                        Width = 64
                        Height = 21
                        Style = csDropDownList
                        ItemHeight = 13
                        TabOrder = 0
                        OnChange = cbTimeZoneChange
                        Items.Strings = (
                          '-14'
                          '-13'
                          '-12'
                          '-11'
                          '-10'
                          '-9'
                          '-8'
                          '-7'
                          '-6'
                          '-5'
                          '-4'
                          '-3'
                          '-2'
                          '-1'
                          '+0'
                          '+1'
                          '+2'
                          '+3'
                          '+4'
                          '+5'
                          '+6'
                          '+7'
                          '+8'
                          '+9'
                          '+10'
                          '+11'
                          '+12'
                          '+13'
                          '+14')
                      end
                    end
                  end
                  object Panel19: TPanel
                    Left = 0
                    Top = 0
                    Width = 463
                    Height = 16
                    Align = alTop
                    Alignment = taLeftJustify
                    Caption = ' '#1059#1095#1077#1090#1085#1099#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1099' :'
                    Font.Charset = RUSSIAN_CHARSET
                    Font.Color = clBlack
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = [fsBold]
                    ParentFont = False
                    TabOrder = 0
                  end
                end
                object Panel21: TPanel
                  Left = 0
                  Top = 559
                  Width = 463
                  Height = 92
                  Align = alTop
                  BevelOuter = bvNone
                  TabOrder = 7
                  object Panel32: TPanel
                    Left = 0
                    Top = 0
                    Width = 463
                    Height = 17
                    Align = alTop
                    Alignment = taLeftJustify
                    Caption = ' '#1057#1095#1105#1090#1095#1080#1082#1080' :'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = [fsBold]
                    ParentFont = False
                    TabOrder = 0
                  end
                  object Panel33: TPanel
                    Left = 0
                    Top = 17
                    Width = 463
                    Height = 27
                    Align = alTop
                    BevelInner = bvLowered
                    TabOrder = 1
                    object Label1: TLabel
                      Left = 6
                      Top = 6
                      Width = 22
                      Height = 13
                      Caption = 'A(+):'
                    end
                    object Label2: TLabel
                      Left = 116
                      Top = 6
                      Width = 22
                      Height = 13
                      Caption = 'P(+):'
                    end
                    object Label6: TLabel
                      Left = 229
                      Top = 6
                      Width = 19
                      Height = 13
                      Caption = 'A(-):'
                    end
                    object Label7: TLabel
                      Left = 339
                      Top = 6
                      Width = 19
                      Height = 13
                      Caption = 'P(-):'
                    end
                    object Edit18: TEdit
                      Tag = 9
                      Left = 139
                      Top = 3
                      Width = 75
                      Height = 21
                      TabStop = False
                      Color = clBtnFace
                      ReadOnly = True
                      TabOrder = 1
                    end
                    object Edit17: TEdit
                      Tag = 9
                      Left = 28
                      Top = 3
                      Width = 75
                      Height = 21
                      TabStop = False
                      Color = clBtnFace
                      ReadOnly = True
                      TabOrder = 0
                    end
                    object Edit19: TEdit
                      Tag = 9
                      Left = 248
                      Top = 3
                      Width = 75
                      Height = 21
                      TabStop = False
                      Color = clBtnFace
                      ReadOnly = True
                      TabOrder = 2
                    end
                    object Edit20: TEdit
                      Tag = 9
                      Left = 359
                      Top = 3
                      Width = 75
                      Height = 21
                      TabStop = False
                      Color = clBtnFace
                      ReadOnly = True
                      TabOrder = 3
                    end
                    object Panel34: TPanel
                      Left = 2
                      Top = 2
                      Width = 459
                      Height = 23
                      Align = alClient
                      Alignment = taLeftJustify
                      BevelOuter = bvNone
                      Caption = ' '#1047#1072#1074#1086#1076#1089#1082#1086#1081' '#8470' :'
                      TabOrder = 4
                      object Edit21: TEdit
                        Tag = 9
                        Left = 82
                        Top = 1
                        Width = 106
                        Height = 21
                        TabStop = False
                        Color = clBtnFace
                        ReadOnly = True
                        TabOrder = 0
                      end
                    end
                  end
                  object Panel22: TPanel
                    Left = 0
                    Top = 44
                    Width = 463
                    Height = 17
                    Align = alTop
                    Alignment = taLeftJustify
                    Caption = #1048#1079#1084#1077#1088#1080#1090#1077#1083#1100#1085#1099#1077' '#1090#1088#1072#1085#1089#1092#1086#1088#1084#1072#1090#1086#1088#1099':'
                    Font.Charset = RUSSIAN_CHARSET
                    Font.Color = clBlack
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = [fsBold]
                    ParentFont = False
                    TabOrder = 2
                  end
                  object plIClassTN: TPanel
                    Left = 0
                    Top = 62
                    Width = 239
                    Height = 28
                    Alignment = taLeftJustify
                    BevelInner = bvLowered
                    Caption = '  '#1050#1083#1072#1089#1089' '#1090#1086#1095#1085#1086#1089#1090#1080' '#1058#1053':'
                    TabOrder = 3
                    object edClassTN: TEdit
                      Left = 124
                      Top = 4
                      Width = 90
                      Height = 21
                      MaxLength = 16
                      TabOrder = 0
                      OnChange = EditChange
                      OnKeyPress = edDoubleKeyPress
                    end
                  end
                  object plIClassTT: TPanel
                    Left = 240
                    Top = 62
                    Width = 223
                    Height = 28
                    Alignment = taLeftJustify
                    BevelInner = bvLowered
                    Caption = '  '#1050#1083#1072#1089#1089' '#1090#1086#1095#1085#1086#1089#1090#1080' '#1058#1058':'
                    TabOrder = 4
                    object edClassTT: TEdit
                      Left = 124
                      Top = 4
                      Width = 90
                      Height = 21
                      MaxLength = 16
                      TabOrder = 0
                      OnChange = EditChange
                      OnKeyPress = edDoubleKeyPress
                    end
                  end
                end
                object Panel51: TPanel
                  Left = 0
                  Top = 297
                  Width = 463
                  Height = 46
                  Align = alTop
                  BevelOuter = bvNone
                  TabOrder = 5
                  object Panel53: TPanel
                    Left = 0
                    Top = 16
                    Width = 463
                    Height = 27
                    Align = alTop
                    Alignment = taLeftJustify
                    BevelInner = bvLowered
                    Caption = ' '#1058#1086#1095#1082#1072' '#1091#1095#1077#1090#1072':'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                    TabOrder = 0
                    object SpeedButton1: TSpeedButton
                      Left = 376
                      Top = 3
                      Width = 21
                      Height = 21
                      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1087#1088#1086#1090#1080#1074#1086#1087#1086#1083#1086#1078#1085#1091#1102' '#1090#1086#1095#1082#1091' '#1076#1083#1103' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1081' '#1090#1086#1095#1082#1080'.'
                      Flat = True
                      Glyph.Data = {
                        1E070000424D1E07000000000000360000002800000022000000110000000100
                        180000000000E806000000000000000000000000000000000000C0C0C0C0C0C0
                        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                        C0C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8
                        D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
                        0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4C8D0D4C8D0D4C8D0
                        D4FFFFFFC8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8
                        D0D4FFFFFFC8D0D40000C0C0C0C0C0C0C0C0C0040404C0C0C0C0C0C0C0C0C0C0
                        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0040404C0C0C0C0C0C0C8D0D4
                        C8D0D4C8D0D4808080FFFFFFFFFFFFC8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0
                        D4C8D0D4C8D0D4808080FFFFFFC8D0D40000C0C0C0C0C0C00404040000800404
                        04C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C00000FFC0
                        C0C0C0C0C0C8D0D4C8D0D4808080808080808080FFFFFFFFFFFFC8D0D4C8D0D4
                        C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4808080C8D0D4C8D0D40000C0C0C0C0C0C0
                        0000FF0000FF000080040404C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                        C0040404C0C0C0C0C0C0C0C0C0C8D0D4C8D0D4808080808080808080808080FF
                        FFFFC8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4808080FFFFFFC8D0D4C8D0D4
                        0000C0C0C0C0C0C03300CC0000FF0000FF000080C0C0C0C0C0C0C0C0C0C0C0C0
                        C0C0C0C0C0C00404040000FFC0C0C0C0C0C0C0C0C0C8D0D4C8D0D48080808080
                        80808080808080FFFFFFFFFFFFC8D0D4C8D0D4C8D0D4C8D0D4808080808080C8
                        D0D4C8D0D4C8D0D40000C0C0C0C0C0C0C0C0C03300CC0000FF0000FF040404C0
                        C0C0C0C0C0C0C0C0C0C0C00404040000FFC0C0C0C0C0C0C0C0C0C0C0C0C8D0D4
                        C8D0D4C8D0D4808080808080808080808080FFFFFFFFFFFFC8D0D4C8D0D48080
                        80808080FFFFFFC8D0D4C8D0D4C8D0D40000C0C0C0C0C0C0C0C0C0C0C0C03300
                        CC0000FF0000FF040404C0C0C0C0C0C00404040000FF0000FFC0C0C0C0C0C0C0
                        C0C0C0C0C0C8D0D4C8D0D4C8D0D4C8D0D4808080808080808080808080FFFFFF
                        FFFFFF808080808080808080C8D0D4C8D0D4C8D0D4C8D0D40000C0C0C0C0C0C0
                        C0C0C0C0C0C0C0C0C03300CC0000FF0000FF0404040404040000FF0000FFC0C0
                        C0C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4C8D0D4C8D0D4C8D0D4C8D0D480808080
                        8080808080808080808080808080808080C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
                        0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C03300CC0000FF0000FF0000FF
                        0000FFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4C8D0D4C8D0D4C8D0
                        D4C8D0D4C8D0D4808080808080808080808080808080FFFFFFC8D0D4C8D0D4C8
                        D0D4C8D0D4C8D0D40000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C004040400
                        00FF0000FF0000FF040404C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4
                        C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4808080808080808080808080808080FFFF
                        FFFFFFFFC8D0D4C8D0D4C8D0D4C8D0D40000C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                        C00404040000FF0000FF0000FF0000FF0000FF040404C0C0C0C0C0C0C0C0C0C0
                        C0C0C0C0C0C8D0D4C8D0D4C8D0D4C8D0D4FFFFFF808080808080808080808080
                        808080808080808080FFFFFFFFFFFFC8D0D4C8D0D4C8D0D40000C0C0C0C0C0C0
                        C0C0C00404040404040000FF0000FF0000FFC0C0C0C0C0C00000FF0000FF0404
                        04C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4C8D0D4C8D0D480808080808080808080
                        8080808080C8D0D4C8D0D4808080808080808080FFFFFFFFFFFFC8D0D4C8D0D4
                        0000C0C0C0C0C0C00404040000FF0000FF0000FF0000FFC0C0C0C0C0C0C0C0C0
                        C0C0C00000FF0000FF040404C0C0C0C0C0C0C0C0C0C8D0D4C8D0D48080808080
                        80808080808080808080C8D0D4C8D0D4C8D0D4C8D0D4808080808080808080FF
                        FFFFFFFFFFC8D0D40000C0C0C0C0C0C00000FF0000FF0000FF0000FFC0C0C0C0
                        C0C0C0C0C0C0C0C0C0C0C0C0C0C00000FF0000FF040404C0C0C0C0C0C0C8D0D4
                        C8D0D4808080808080808080808080C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0
                        D4808080808080808080FFFFFFC8D0D40000C0C0C0C0C0C00000FF0000FF0000
                        FFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C00000FFC0
                        C0C0C0C0C0C8D0D4C8D0D4808080808080808080C8D0D4C8D0D4C8D0D4C8D0D4
                        C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4808080C8D0D4C8D0D40000C0C0C0C0C0C0
                        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                        C0C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8
                        D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
                        0000}
                      NumGlyphs = 2
                      ParentShowHint = False
                      ShowHint = True
                      OnClick = sbDelOppositeClick
                    end
                    object sbOpposit: TSpeedButton
                      Left = 355
                      Top = 3
                      Width = 21
                      Height = 21
                      Hint = #1054#1087#1088#1077#1076#1077#1083#1080#1090#1100' '#1087#1088#1086#1090#1080#1074#1086#1087#1086#1083#1086#1078#1085#1091#1102' '#1090#1086#1095#1082#1091' '#1080#1079' '#1087#1077#1088#1077#1095#1085#1103' '#1074#1089#1077#1093' '#1090#1086#1095#1077#1082'.'
                      Flat = True
                      Glyph.Data = {
                        1E070000424D1E07000000000000360000002800000022000000110000000100
                        180000000000E806000000000000000000000000000000000000C0C0C0C0C0C0
                        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                        C0C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8
                        D0D4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                        0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0040404040404040404
                        040404040404040404040404040404040404040404C8D0D4C8D0D4C8D0D4C8D0
                        D4C8D0D4C8D0D480808080808080808080808080808080808080808080808080
                        8080808080FFFFFF0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C004
                        0404FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF040404C8D0D4
                        C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4808080FFFFFFC8D0D4C8D0D4C8D0D4FFFF
                        FFFFFFFFC8D0D4C8D0D4808080FFFFFF0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                        C0C0C0C0C0C0C0040404FFFFFFFFFFFFFFFFFF808000808000FFFFFFFFFFFFFF
                        FFFF040404C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4808080FFFFFFC8D0D4
                        C8D0D4808080808080FFFFFFFFFFFFC8D0D4808080FFFFFF0000C0C0C0C0C0C0
                        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0040404FFFFFFFFFFFF8080008080008080
                        00808000FFFFFFFFFFFF040404C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D480
                        8080FFFFFFC8D0D4808080808080808080808080FFFFFFC8D0D4808080FFFFFF
                        0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0040404FFFFFFFFFFFF
                        808000808000808000808000FFFFFFFFFFFF040404C8D0D4C8D0D4C8D0D4C8D0
                        D4C8D0D4C8D0D4808080FFFFFFC8D0D4808080808080808080808080C8D0D4C8
                        D0D4808080FFFFFF0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C004
                        0404FFFFFFFFFFFFFFFFFF808000808000FFFFFFFFFFFFFFFFFF040404C8D0D4
                        C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4808080FFFFFFC8D0D4C8D0D48080808080
                        80C8D0D4C8D0D4C8D0D4808080FFFFFF0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                        C0C0C0C0C0C0C0040404FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                        FFFF040404C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4808080FFFFFFFFFFFF
                        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF808080FFFFFF0000C0C0C0C0C0C0
                        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C00404040404040404040404040404040404
                        04040404040404040404040404C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D480
                        8080808080808080808080808080808080808080808080808080808080C8D0D4
                        0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                        C0C0C0C0C0C0008000C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4FFFFFFFFFFFFFFFF
                        FFFFFFFFFFFFFFFFFFFFC8D0D4C8D0D4C8D0D4C8D0D4808080FFFFFFFFFFFFC8
                        D0D4C8D0D4C8D0D40000C0C0C0040404040404040404040404040404040404C0
                        C0C0C0C0C0C0C0C0C0C0C0008000008000008000C0C0C0C0C0C0C0C0C0808080
                        808080808080808080808080808080FFFFFFC8D0D4C8D0D4C8D0D48080808080
                        80808080C8D0D4C8D0D4C8D0D4C8D0D40000C0C0C0040404FFFFFFFFFFFFFFFF
                        FFFFFFFF040404C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0008000C0C0C0C0C0C0C0
                        C0C0C0C0C0808080FFFFFFC8D0D4FFFFFFFFFFFF808080FFFFFFC8D0D4FFFFFF
                        C8D0D4C8D0D4808080FFFFFFC8D0D4C8D0D4C8D0D4C8D0D40000C0C0C0040404
                        FFFFFF808000808000FFFFFF040404C0C0C0008000C0C0C0C0C0C00080000080
                        00C0C0C0C0C0C0C0C0C0C0C0C0808080FFFFFF808080808080FFFFFF808080FF
                        FFFF808080FFFFFFFFFFFF808080808080C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
                        0000C0C0C0040404FFFFFF808000808000FFFFFF040404008000008000008000
                        008000008000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0808080FFFFFF8080808080
                        80C8D0D4808080808080808080808080808080808080C8D0D4C8D0D4C8D0D4C8
                        D0D4C8D0D4C8D0D40000C0C0C0040404FFFFFFFFFFFFFFFFFFFFFFFF040404C0
                        C0C0008000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0808080
                        FFFFFFFFFFFFFFFFFFFFFFFF808080FFFFFF808080C8D0D4C8D0D4C8D0D4C8D0
                        D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D40000C0C0C00404040404040404040404
                        04040404040404C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                        C0C0C0C0C0808080808080808080808080808080808080C8D0D4C8D0D4C8D0D4
                        C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D40000C0C0C0C0C0C0
                        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                        C0C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8
                        D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
                        0000}
                      NumGlyphs = 2
                      ParentShowHint = False
                      ShowHint = True
                      OnClick = sbOppositClick
                    end
                    object sbOppList: TSpeedButton
                      Left = 397
                      Top = 3
                      Width = 41
                      Height = 21
                      Hint = #1054#1090#1082#1088#1099#1090#1100' '#1087#1077#1088#1077#1095#1077#1085#1100' '#1087#1088#1086#1090#1080#1074#1086#1087#1086#1083#1086#1078#1085#1099#1093' '#1090#1086#1095#1077#1082' '#1076#1083#1103' '#1090#1077#1082#1091#1097#1077#1081'.'
                      Flat = True
                      Glyph.Data = {
                        F6060000424DF60600000000000036000000280000001F000000120000000100
                        180000000000C0060000C40E0000C40E00000000000000000000800080800080
                        8000808000808000808000808000808000808000808000808000808000808000
                        80800080800080800080800080800080800080808080FFFFFF80008080008080
                        0080800080800080800080800080800080800080800080000000000000000000
                        0000000000000000000000000000000000000000000000000000000000000000
                        00000000000000000000800080800080800080808080FFFFFF80008080008080
                        0080800080800080800080800080800080800080800080000000000000800080
                        8000808000808000808000808000808000808000808000808000808000808000
                        80800080800080000000800080800080800080808080FFFFFF80008080008080
                        0080800080800080800080800080800080800080800080000000000000800080
                        8000808000808000808000808000808000808000808000808000808000808000
                        80800080800080000000800080800080800080808080FFFFFF80008080008080
                        0080800080800080800080800080800080800080800080000000000000800080
                        8000808080808080808080808080808000808000808080808080808080808080
                        80800080800080000000800080800080800080808080FFFFFF80008080008080
                        0080800080800080800080800080800080800080800080000000000000800080
                        0000000000000000000000008000808000800000000000000000000000008000
                        80800080800080000000800080800080800080808080FFFFFF80008080008080
                        0080800080800080800080800080800080800080800080000000000000800080
                        8000808000808000808000808000808000808000808000808000808000808000
                        80800080800080000000800080800080800080808080FFFFFF80008080008080
                        0080800080800080800080800080800080800080800080000000000000800080
                        8000808080808080808080808080808000808080808080808080808080808080
                        80800080800080000000800080800080800080808080FFFFFF80008080008080
                        0080800080800080800080800080800080800080800080000000000000800080
                        0000000000000000000000008000808000800000000000000000000000008000
                        80800080800080000000800080800080800080808080FFFFFF80008080008080
                        0080800080800080000000800080800080800080800080000000000000800080
                        8000808000808000808000808000808000808000808000808000808000808000
                        80800080800080000000800080800080800080808080FFFFFF80008080008080
                        0080800080000000000000000000800080800080800080000000000000800080
                        8000808080808080808080808080808000808000808080808080808080808080
                        80800080800080000000800080800080800080808080FFFFFF80008080008080
                        0080000000000000000000000000000000800080800080000000000000800080
                        0000000000000000000000008000808000800000000000000000000000008000
                        80800080800080000000800080800080800080808080FFFFFF80008080008000
                        0000000000000000000000000000000000000000800080000000000000800080
                        8000808000808000808000808000808000808000808000808000808000808000
                        80800080800080000000800080800080800080808080FFFFFF80008080008080
                        0080800080800080800080800080800080800080800080000000000000800080
                        8000808080808080808080808080808000808000808080808080808080808080
                        80800080800080000000800080800080800080808080FFFFFF80008080008080
                        0080800080800080800080800080800080800080800080000000000000800080
                        0000000000000000000000008000808000800000000000000000000000008000
                        80800080800080000000800080800080800080808080FFFFFF80008080008080
                        0080800080800080800080800080800080800080800080000000000000800080
                        8000808000808000808000808000808000808000808000808000808000808000
                        80800080800080000000800080800080800080808080FFFFFF80008080008080
                        0080800080800080800080800080800080800080800080000000000000000000
                        0000000000000000000000000000000000000000000000000000000000000000
                        00000000000000000000800080800080800080808080FFFFFF80008080008080
                        0080800080800080800080800080800080800080800080000000800080800080
                        8000808000808000808000808000808000808000808000808000808000808000
                        80800080800080800080800080800080800080808080FFFFFF80008080008080
                        0080800080800080800080800080800080800080800080000000}
                      ParentShowHint = False
                      ShowHint = True
                      OnClick = sbListOppositeClick
                    end
                    object eOpp: TEdit
                      Tag = 9
                      Left = 70
                      Top = 3
                      Width = 283
                      Height = 21
                      Color = clMenu
                      ReadOnly = True
                      TabOrder = 0
                    end
                  end
                  object Panel54: TPanel
                    Left = 0
                    Top = 0
                    Width = 463
                    Height = 16
                    Align = alTop
                    Alignment = taLeftJustify
                    Caption = ' '#1055#1088#1086#1090#1080#1074#1086#1087#1086#1083#1086#1078#1085#1072#1103' '#1090#1086#1095#1082#1072' '#1091#1095#1077#1090#1072':'
                    Font.Charset = RUSSIAN_CHARSET
                    Font.Color = clBlack
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = [fsBold]
                    ParentFont = False
                    TabOrder = 1
                  end
                end
                object Panel55: TPanel
                  Left = 0
                  Top = 24
                  Width = 463
                  Height = 25
                  Align = alTop
                  BevelOuter = bvNone
                  TabOrder = 1
                  object lSource: TLabel
                    Left = 84
                    Top = 4
                    Width = 3
                    Height = 13
                  end
                  object Label40: TLabel
                    Left = 1
                    Top = 5
                    Width = 50
                    Height = 13
                    Caption = #1051#1080#1094'/'#1089#1095#1077#1090':'
                    Font.Charset = RUSSIAN_CHARSET
                    Font.Color = clBlack
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                  end
                  object Edit25: TEdit
                    Left = 71
                    Top = 1
                    Width = 221
                    Height = 21
                    MaxLength = 31
                    TabOrder = 0
                    OnChange = EditChange
                  end
                end
                object Panel46: TPanel
                  Left = 0
                  Top = 49
                  Width = 463
                  Height = 38
                  Align = alTop
                  BevelOuter = bvNone
                  TabOrder = 2
                  object lbNote: TLabel
                    Left = 0
                    Top = 8
                    Width = 66
                    Height = 13
                    Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077':'
                  end
                  object mNote: TMemo
                    Left = 71
                    Top = 0
                    Width = 392
                    Height = 33
                    Lines.Strings = (
                      '')
                    MaxLength = 256
                    TabOrder = 0
                    OnChange = EditChange
                  end
                end
              end
              object Panel31: TPanel
                Left = 0
                Top = -54
                Width = 471
                Height = 49
                Align = alTop
                BevelOuter = bvNone
                TabOrder = 0
                object Label4: TLabel
                  Left = 5
                  Top = 10
                  Width = 25
                  Height = 13
                  Caption = #1048#1084#1103':'
                  Font.Charset = RUSSIAN_CHARSET
                  Font.Color = clBlack
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                end
                object Label5: TLabel
                  Left = 5
                  Top = 33
                  Width = 68
                  Height = 13
                  Caption = #1050#1088#1072#1090#1082#1086#1077' '#1080#1084#1103':'
                  Font.Charset = RUSSIAN_CHARSET
                  Font.Color = clBlack
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                end
                object Label9: TLabel
                  Left = 305
                  Top = 33
                  Width = 62
                  Height = 13
                  Caption = #1048#1076' '#1086#1073#1098#1077#1082#1090#1072':'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = [fsUnderline]
                  ParentFont = False
                end
                object Label41: TLabel
                  Left = 8
                  Top = 218
                  Width = 51
                  Height = 16
                  Caption = #1050#1086#1076' EIC:'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -13
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                end
                object Label44: TLabel
                  Left = 8
                  Top = 252
                  Width = 100
                  Height = 16
                  Caption = #1058#1086#1088#1075#1086#1074#1072#1103' '#1079#1086#1085#1072':'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -13
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                  Visible = False
                end
                object Edit1: TEdit
                  Left = 76
                  Top = 4
                  Width = 392
                  Height = 21
                  MaxLength = 148
                  TabOrder = 0
                  OnChange = EditChange
                end
                object Edit2: TEdit
                  Left = 76
                  Top = 28
                  Width = 221
                  Height = 21
                  MaxLength = 48
                  TabOrder = 1
                  OnChange = EditChange
                end
                object lbId: TEdit
                  Tag = 9
                  Left = 396
                  Top = 33
                  Width = 73
                  Height = 17
                  BorderStyle = bsNone
                  Color = clBtnFace
                  Ctl3D = False
                  ParentCtl3D = False
                  ReadOnly = True
                  TabOrder = 2
                end
                object RadioGroup1: TRadioGroup
                  Left = 16
                  Top = 96
                  Width = 185
                  Height = 105
                  Caption = #1058#1080#1087' '
                  ItemIndex = 0
                  Items.Strings = (
                    #1058#1086#1088#1075#1086#1074#1072#1103' '#1079#1086#1085#1072
                    #1054#1073#1083#1072#1089#1090#1100' '#1091#1095#1105#1090#1072
                    #1055#1086#1089#1090#1072#1074#1097#1080#1082)
                  TabOrder = 3
                  OnClick = RadioGroup1Click
                end
                object Edit26: TEdit
                  Left = 127
                  Top = 216
                  Width = 337
                  Height = 21
                  MaxLength = 16
                  TabOrder = 4
                end
                object ComboBox1: TComboBox
                  Left = 127
                  Top = 247
                  Width = 337
                  Height = 21
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ItemHeight = 13
                  ParentFont = False
                  TabOrder = 5
                  Visible = False
                  OnChange = ComboBox1Change
                end
              end
            end
          end
        end
        object tsMainSpec: TTabSheet
          Caption = #1054#1089#1085#1086#1074#1085#1099#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1099
          ImageIndex = 3
          object plParamSpec: TPanel
            Left = 0
            Top = 0
            Width = 507
            Height = 649
            Align = alClient
            BevelOuter = bvLowered
            TabOrder = 0
            object Panel47: TPanel
              Left = 1
              Top = 1
              Width = 505
              Height = 152
              Align = alTop
              BevelOuter = bvNone
              TabOrder = 0
              object Label33: TLabel
                Left = 10
                Top = 10
                Width = 25
                Height = 13
                Caption = #1048#1084#1103':'
                Font.Charset = RUSSIAN_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
              end
              object Label35: TLabel
                Left = 10
                Top = 33
                Width = 68
                Height = 13
                Caption = #1050#1088#1072#1090#1082#1086#1077' '#1080#1084#1103':'
                Font.Charset = RUSSIAN_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
              end
              object Label36: TLabel
                Left = 324
                Top = 31
                Width = 62
                Height = 13
                Caption = #1048#1076' '#1086#1073#1098#1077#1082#1090#1072':'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsUnderline]
                ParentFont = False
              end
              object Label37: TLabel
                Left = 10
                Top = 54
                Width = 22
                Height = 13
                Caption = #1050#1086#1076':'
              end
              object Edit22: TEdit
                Left = 90
                Top = 4
                Width = 363
                Height = 21
                MaxLength = 148
                TabOrder = 0
                OnChange = EditChange
              end
              object Edit23: TEdit
                Left = 90
                Top = 28
                Width = 231
                Height = 21
                MaxLength = 48
                TabOrder = 1
                OnChange = EditChange
              end
              object Edit24: TEdit
                Tag = 9
                Left = 388
                Top = 30
                Width = 64
                Height = 19
                BorderStyle = bsNone
                Color = clBtnFace
                Ctl3D = False
                ParentCtl3D = False
                ReadOnly = True
                TabOrder = 2
              end
              object CheckBox7: TCheckBox
                Left = 10
                Top = 78
                Width = 147
                Height = 17
                Caption = '&'#1054#1073#1093#1086#1076#1085#1086#1081' '#1074#1099#1082#1083#1102#1095#1072#1090#1077#1083#1100
                TabOrder = 4
              end
              object eCode4: TEdit
                Left = 90
                Top = 52
                Width = 231
                Height = 21
                TabOrder = 3
              end
              object cbNLockSwitch1: TCheckBox
                Left = 159
                Top = 78
                Width = 140
                Height = 17
                Caption = #1053#1077' '#1087#1077#1088#1077#1093#1086#1076#1080#1090' '#1085#1072' '#1054#1042
                TabOrder = 5
              end
              object RadioGroup2: TRadioGroup
                Left = 288
                Top = 75
                Width = 217
                Height = 57
                Caption = 'EIC'
                ItemIndex = 0
                Items.Strings = (
                  #1053#1077' '#1074#1093#1086#1076#1080#1090' '#1074' '#1082#1086#1084#1084#1077#1088#1095#1077#1089#1082#1080#1081' '#1091#1095#1105#1090
                  #1042#1093#1086#1076#1080#1090' '#1074' '#1082#1086#1084#1084#1077#1088#1095#1077#1089#1082#1080#1081' '#1091#1095#1105#1090)
                TabOrder = 6
                OnClick = RadioGroup2Click
              end
            end
            object Panel48: TPanel
              Left = 1
              Top = 214
              Width = 505
              Height = 103
              Align = alTop
              BevelOuter = bvNone
              TabOrder = 1
              object Panel27: TPanel
                Left = 0
                Top = 0
                Width = 505
                Height = 101
                Align = alTop
                BevelOuter = bvNone
                TabOrder = 0
                object Panel28: TPanel
                  Left = 0
                  Top = 46
                  Width = 505
                  Height = 53
                  Align = alTop
                  BevelOuter = bvNone
                  TabOrder = 1
                  object Panel29: TPanel
                    Left = 0
                    Top = 0
                    Width = 505
                    Height = 17
                    Align = alTop
                    Alignment = taLeftJustify
                    Caption = ' '#1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1075#1088#1072#1085#1080#1094' :'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = [fsBold]
                    ParentFont = False
                    TabOrder = 0
                  end
                  object Panel30: TPanel
                    Left = 0
                    Top = 17
                    Width = 505
                    Height = 32
                    Align = alTop
                    Alignment = taLeftJustify
                    BevelInner = bvLowered
                    TabOrder = 1
                    object btLimit: TButton
                      Left = 5
                      Top = 4
                      Width = 130
                      Height = 25
                      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1087#1072#1088#1072#1084#1077#1090#1088#1099
                      TabOrder = 0
                      OnClick = btLimitClick
                    end
                  end
                end
                object Panel49: TPanel
                  Left = 0
                  Top = 0
                  Width = 505
                  Height = 46
                  Align = alTop
                  BevelOuter = bvNone
                  TabOrder = 0
                  object Panel52: TPanel
                    Left = 0
                    Top = 0
                    Width = 505
                    Height = 16
                    Align = alTop
                    Alignment = taLeftJustify
                    Caption = ' '#1055#1088#1086#1090#1080#1074#1086#1087#1086#1083#1086#1078#1085#1072#1103' '#1090#1086#1095#1082#1072' '#1091#1095#1077#1090#1072':'
                    Font.Charset = RUSSIAN_CHARSET
                    Font.Color = clBlack
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = [fsBold]
                    ParentFont = False
                    TabOrder = 0
                  end
                  object Panel50: TPanel
                    Left = 0
                    Top = 16
                    Width = 505
                    Height = 27
                    Align = alTop
                    Alignment = taLeftJustify
                    BevelInner = bvLowered
                    Caption = '  '#1058#1086#1095#1082#1072' '#1091#1095#1077#1090#1072':'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                    TabOrder = 1
                    object eOpposite: TEdit
                      Tag = 9
                      Left = 85
                      Top = 3
                      Width = 294
                      Height = 21
                      Color = clMenu
                      ReadOnly = True
                      TabOrder = 0
                    end
                    object Panel58: TPanel
                      Left = 412
                      Top = 2
                      Width = 91
                      Height = 23
                      Align = alRight
                      BevelOuter = bvNone
                      TabOrder = 1
                      object sbOpposite: TSpeedButton
                        Left = 0
                        Top = 1
                        Width = 21
                        Height = 21
                        Hint = #1054#1087#1088#1077#1076#1077#1083#1080#1090#1100' '#1087#1088#1086#1090#1080#1074#1086#1087#1086#1083#1086#1078#1085#1091#1102' '#1090#1086#1095#1082#1091' '#1080#1079' '#1087#1077#1088#1077#1095#1085#1103' '#1074#1089#1077#1093' '#1090#1086#1095#1077#1082'.'
                        Flat = True
                        Glyph.Data = {
                          1E070000424D1E07000000000000360000002800000022000000110000000100
                          180000000000E806000000000000000000000000000000000000C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8
                          D0D4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                          0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0040404040404040404
                          040404040404040404040404040404040404040404C8D0D4C8D0D4C8D0D4C8D0
                          D4C8D0D4C8D0D480808080808080808080808080808080808080808080808080
                          8080808080FFFFFF0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C004
                          0404FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF040404C8D0D4
                          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4808080FFFFFFC8D0D4C8D0D4C8D0D4FFFF
                          FFFFFFFFC8D0D4C8D0D4808080FFFFFF0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                          C0C0C0C0C0C0C0040404FFFFFFFFFFFFFFFFFF808000808000FFFFFFFFFFFFFF
                          FFFF040404C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4808080FFFFFFC8D0D4
                          C8D0D4808080808080FFFFFFFFFFFFC8D0D4808080FFFFFF0000C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0040404FFFFFFFFFFFF8080008080008080
                          00808000FFFFFFFFFFFF040404C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D480
                          8080FFFFFFC8D0D4808080808080808080808080FFFFFFC8D0D4808080FFFFFF
                          0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0040404FFFFFFFFFFFF
                          808000808000808000808000FFFFFFFFFFFF040404C8D0D4C8D0D4C8D0D4C8D0
                          D4C8D0D4C8D0D4808080FFFFFFC8D0D4808080808080808080808080C8D0D4C8
                          D0D4808080FFFFFF0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C004
                          0404FFFFFFFFFFFFFFFFFF808000808000FFFFFFFFFFFFFFFFFF040404C8D0D4
                          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4808080FFFFFFC8D0D4C8D0D48080808080
                          80C8D0D4C8D0D4C8D0D4808080FFFFFF0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                          C0C0C0C0C0C0C0040404FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                          FFFF040404C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4808080FFFFFFFFFFFF
                          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF808080FFFFFF0000C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C00404040404040404040404040404040404
                          04040404040404040404040404C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D480
                          8080808080808080808080808080808080808080808080808080808080C8D0D4
                          0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                          C0C0C0C0C0C0008000C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4FFFFFFFFFFFFFFFF
                          FFFFFFFFFFFFFFFFFFFFC8D0D4C8D0D4C8D0D4C8D0D4808080FFFFFFFFFFFFC8
                          D0D4C8D0D4C8D0D40000C0C0C0040404040404040404040404040404040404C0
                          C0C0C0C0C0C0C0C0C0C0C0008000008000008000C0C0C0C0C0C0C0C0C0808080
                          808080808080808080808080808080FFFFFFC8D0D4C8D0D4C8D0D48080808080
                          80808080C8D0D4C8D0D4C8D0D4C8D0D40000C0C0C0040404FFFFFFFFFFFFFFFF
                          FFFFFFFF040404C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0008000C0C0C0C0C0C0C0
                          C0C0C0C0C0808080FFFFFFC8D0D4FFFFFFFFFFFF808080FFFFFFC8D0D4FFFFFF
                          C8D0D4C8D0D4808080FFFFFFC8D0D4C8D0D4C8D0D4C8D0D40000C0C0C0040404
                          FFFFFF808000808000FFFFFF040404C0C0C0008000C0C0C0C0C0C00080000080
                          00C0C0C0C0C0C0C0C0C0C0C0C0808080FFFFFF808080808080FFFFFF808080FF
                          FFFF808080FFFFFFFFFFFF808080808080C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
                          0000C0C0C0040404FFFFFF808000808000FFFFFF040404008000008000008000
                          008000008000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0808080FFFFFF8080808080
                          80C8D0D4808080808080808080808080808080808080C8D0D4C8D0D4C8D0D4C8
                          D0D4C8D0D4C8D0D40000C0C0C0040404FFFFFFFFFFFFFFFFFFFFFFFF040404C0
                          C0C0008000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0808080
                          FFFFFFFFFFFFFFFFFFFFFFFF808080FFFFFF808080C8D0D4C8D0D4C8D0D4C8D0
                          D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D40000C0C0C00404040404040404040404
                          04040404040404C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                          C0C0C0C0C0808080808080808080808080808080808080C8D0D4C8D0D4C8D0D4
                          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D40000C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8
                          D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
                          0000}
                        NumGlyphs = 2
                        ParentShowHint = False
                        ShowHint = True
                        OnClick = sbOppositClick
                      end
                      object sbDelOpposite: TSpeedButton
                        Left = 22
                        Top = 1
                        Width = 21
                        Height = 21
                        Hint = #1059#1076#1072#1083#1080#1090#1100' '#1087#1088#1086#1090#1080#1074#1086#1087#1086#1083#1086#1078#1085#1091#1102' '#1090#1086#1095#1082#1091' '#1076#1083#1103' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1081' '#1090#1086#1095#1082#1080'.'
                        Flat = True
                        Glyph.Data = {
                          1E070000424D1E07000000000000360000002800000022000000110000000100
                          180000000000E806000000000000000000000000000000000000C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8
                          D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
                          0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4C8D0D4C8D0D4C8D0
                          D4FFFFFFC8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8
                          D0D4FFFFFFC8D0D40000C0C0C0C0C0C0C0C0C0040404C0C0C0C0C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0040404C0C0C0C0C0C0C8D0D4
                          C8D0D4C8D0D4808080FFFFFFFFFFFFC8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0
                          D4C8D0D4C8D0D4808080FFFFFFC8D0D40000C0C0C0C0C0C00404040000800404
                          04C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C00000FFC0
                          C0C0C0C0C0C8D0D4C8D0D4808080808080808080FFFFFFFFFFFFC8D0D4C8D0D4
                          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4808080C8D0D4C8D0D40000C0C0C0C0C0C0
                          0000FF0000FF000080040404C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                          C0040404C0C0C0C0C0C0C0C0C0C8D0D4C8D0D4808080808080808080808080FF
                          FFFFC8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4808080FFFFFFC8D0D4C8D0D4
                          0000C0C0C0C0C0C03300CC0000FF0000FF000080C0C0C0C0C0C0C0C0C0C0C0C0
                          C0C0C0C0C0C00404040000FFC0C0C0C0C0C0C0C0C0C8D0D4C8D0D48080808080
                          80808080808080FFFFFFFFFFFFC8D0D4C8D0D4C8D0D4C8D0D4808080808080C8
                          D0D4C8D0D4C8D0D40000C0C0C0C0C0C0C0C0C03300CC0000FF0000FF040404C0
                          C0C0C0C0C0C0C0C0C0C0C00404040000FFC0C0C0C0C0C0C0C0C0C0C0C0C8D0D4
                          C8D0D4C8D0D4808080808080808080808080FFFFFFFFFFFFC8D0D4C8D0D48080
                          80808080FFFFFFC8D0D4C8D0D4C8D0D40000C0C0C0C0C0C0C0C0C0C0C0C03300
                          CC0000FF0000FF040404C0C0C0C0C0C00404040000FF0000FFC0C0C0C0C0C0C0
                          C0C0C0C0C0C8D0D4C8D0D4C8D0D4C8D0D4808080808080808080808080FFFFFF
                          FFFFFF808080808080808080C8D0D4C8D0D4C8D0D4C8D0D40000C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C03300CC0000FF0000FF0404040404040000FF0000FFC0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4C8D0D4C8D0D4C8D0D4C8D0D480808080
                          8080808080808080808080808080808080C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
                          0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C03300CC0000FF0000FF0000FF
                          0000FFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4C8D0D4C8D0D4C8D0
                          D4C8D0D4C8D0D4808080808080808080808080808080FFFFFFC8D0D4C8D0D4C8
                          D0D4C8D0D4C8D0D40000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C004040400
                          00FF0000FF0000FF040404C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4
                          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4808080808080808080808080808080FFFF
                          FFFFFFFFC8D0D4C8D0D4C8D0D4C8D0D40000C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                          C00404040000FF0000FF0000FF0000FF0000FF040404C0C0C0C0C0C0C0C0C0C0
                          C0C0C0C0C0C8D0D4C8D0D4C8D0D4C8D0D4FFFFFF808080808080808080808080
                          808080808080808080FFFFFFFFFFFFC8D0D4C8D0D4C8D0D40000C0C0C0C0C0C0
                          C0C0C00404040404040000FF0000FF0000FFC0C0C0C0C0C00000FF0000FF0404
                          04C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4C8D0D4C8D0D480808080808080808080
                          8080808080C8D0D4C8D0D4808080808080808080FFFFFFFFFFFFC8D0D4C8D0D4
                          0000C0C0C0C0C0C00404040000FF0000FF0000FF0000FFC0C0C0C0C0C0C0C0C0
                          C0C0C00000FF0000FF040404C0C0C0C0C0C0C0C0C0C8D0D4C8D0D48080808080
                          80808080808080808080C8D0D4C8D0D4C8D0D4C8D0D4808080808080808080FF
                          FFFFFFFFFFC8D0D40000C0C0C0C0C0C00000FF0000FF0000FF0000FFC0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C00000FF0000FF040404C0C0C0C0C0C0C8D0D4
                          C8D0D4808080808080808080808080C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0
                          D4808080808080808080FFFFFFC8D0D40000C0C0C0C0C0C00000FF0000FF0000
                          FFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C00000FFC0
                          C0C0C0C0C0C8D0D4C8D0D4808080808080808080C8D0D4C8D0D4C8D0D4C8D0D4
                          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4808080C8D0D4C8D0D40000C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8
                          D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
                          0000}
                        NumGlyphs = 2
                        ParentShowHint = False
                        ShowHint = True
                        OnClick = sbDelOppositeClick
                      end
                      object sbListOpposite: TSpeedButton
                        Left = 44
                        Top = 1
                        Width = 41
                        Height = 21
                        Hint = #1054#1090#1082#1088#1099#1090#1100' '#1087#1077#1088#1077#1095#1077#1085#1100' '#1087#1088#1086#1090#1080#1074#1086#1087#1086#1083#1086#1078#1085#1099#1093' '#1090#1086#1095#1077#1082' '#1076#1083#1103' '#1090#1077#1082#1091#1097#1077#1081'.'
                        Flat = True
                        Glyph.Data = {
                          F6060000424DF60600000000000036000000280000001F000000120000000100
                          180000000000C0060000C40E0000C40E00000000000000000000800080800080
                          8000808000808000808000808000808000808000808000808000808000808000
                          80800080800080800080800080800080800080808080FFFFFF80008080008080
                          0080800080800080800080800080800080800080800080000000000000000000
                          0000000000000000000000000000000000000000000000000000000000000000
                          00000000000000000000800080800080800080808080FFFFFF80008080008080
                          0080800080800080800080800080800080800080800080000000000000800080
                          8000808000808000808000808000808000808000808000808000808000808000
                          80800080800080000000800080800080800080808080FFFFFF80008080008080
                          0080800080800080800080800080800080800080800080000000000000800080
                          8000808000808000808000808000808000808000808000808000808000808000
                          80800080800080000000800080800080800080808080FFFFFF80008080008080
                          0080800080800080800080800080800080800080800080000000000000800080
                          8000808080808080808080808080808000808000808080808080808080808080
                          80800080800080000000800080800080800080808080FFFFFF80008080008080
                          0080800080800080800080800080800080800080800080000000000000800080
                          0000000000000000000000008000808000800000000000000000000000008000
                          80800080800080000000800080800080800080808080FFFFFF80008080008080
                          0080800080800080800080800080800080800080800080000000000000800080
                          8000808000808000808000808000808000808000808000808000808000808000
                          80800080800080000000800080800080800080808080FFFFFF80008080008080
                          0080800080800080800080800080800080800080800080000000000000800080
                          8000808080808080808080808080808000808080808080808080808080808080
                          80800080800080000000800080800080800080808080FFFFFF80008080008080
                          0080800080800080800080800080800080800080800080000000000000800080
                          0000000000000000000000008000808000800000000000000000000000008000
                          80800080800080000000800080800080800080808080FFFFFF80008080008080
                          0080800080800080000000800080800080800080800080000000000000800080
                          8000808000808000808000808000808000808000808000808000808000808000
                          80800080800080000000800080800080800080808080FFFFFF80008080008080
                          0080800080000000000000000000800080800080800080000000000000800080
                          8000808080808080808080808080808000808000808080808080808080808080
                          80800080800080000000800080800080800080808080FFFFFF80008080008080
                          0080000000000000000000000000000000800080800080000000000000800080
                          0000000000000000000000008000808000800000000000000000000000008000
                          80800080800080000000800080800080800080808080FFFFFF80008080008000
                          0000000000000000000000000000000000000000800080000000000000800080
                          8000808000808000808000808000808000808000808000808000808000808000
                          80800080800080000000800080800080800080808080FFFFFF80008080008080
                          0080800080800080800080800080800080800080800080000000000000800080
                          8000808080808080808080808080808000808000808080808080808080808080
                          80800080800080000000800080800080800080808080FFFFFF80008080008080
                          0080800080800080800080800080800080800080800080000000000000800080
                          0000000000000000000000008000808000800000000000000000000000008000
                          80800080800080000000800080800080800080808080FFFFFF80008080008080
                          0080800080800080800080800080800080800080800080000000000000800080
                          8000808000808000808000808000808000808000808000808000808000808000
                          80800080800080000000800080800080800080808080FFFFFF80008080008080
                          0080800080800080800080800080800080800080800080000000000000000000
                          0000000000000000000000000000000000000000000000000000000000000000
                          00000000000000000000800080800080800080808080FFFFFF80008080008080
                          0080800080800080800080800080800080800080800080000000800080800080
                          8000808000808000808000808000808000808000808000808000808000808000
                          80800080800080800080800080800080800080808080FFFFFF80008080008080
                          0080800080800080800080800080800080800080800080000000}
                        ParentShowHint = False
                        ShowHint = True
                        OnClick = sbListOppositeClick
                      end
                    end
                  end
                end
              end
            end
            object paCalcPoint2: TPanel
              Left = 1
              Top = 317
              Width = 505
              Height = 130
              Align = alTop
              BevelOuter = bvNone
              TabOrder = 2
            end
            object Panel24: TPanel
              Left = 1
              Top = 153
              Width = 505
              Height = 23
              Align = alTop
              BevelOuter = bvNone
              TabOrder = 3
              object Label38: TLabel
                Left = 11
                Top = 4
                Width = 51
                Height = 13
                Caption = #1048#1089#1090#1086#1095#1085#1080#1082':'
              end
              object lSource2: TLabel
                Left = 92
                Top = 4
                Width = 3
                Height = 13
              end
            end
            object Panel25: TPanel
              Left = 1
              Top = 447
              Width = 505
              Height = 79
              Align = alTop
              BevelOuter = bvNone
              TabOrder = 5
              object Panel45: TPanel
                Left = 0
                Top = 16
                Width = 505
                Height = 57
                HelpContext = 5213
                Align = alTop
                BevelInner = bvRaised
                BevelOuter = bvNone
                TabOrder = 1
                object Label46: TLabel
                  Left = 11
                  Top = 36
                  Width = 41
                  Height = 13
                  Caption = 'EIC-'#1082#1086#1076':'
                  Visible = False
                end
                object Panel65: TPanel
                  Left = 1
                  Top = 1
                  Width = 223
                  Height = 26
                  Alignment = taLeftJustify
                  BevelOuter = bvLowered
                  Caption = '  '#1042#1088#1077#1084#1077#1085#1085#1086#1081' '#1087#1086#1103#1089' (UTC-'#1079#1080#1084#1072') :'
                  TabOrder = 0
                  object cbTimeZoneW_1: TComboBox
                    Left = 159
                    Top = 2
                    Width = 61
                    Height = 21
                    Style = csDropDownList
                    ItemHeight = 13
                    TabOrder = 0
                    OnChange = cbTimeZoneChange
                    Items.Strings = (
                      '-14'
                      '-13'
                      '-12'
                      '-11'
                      '-10'
                      '-9'
                      '-8'
                      '-7'
                      '-6'
                      '-5'
                      '-4'
                      '-3'
                      '-2'
                      '-1'
                      '+0'
                      '+1'
                      '+2'
                      '+3'
                      '+4'
                      '+5'
                      '+6'
                      '+7'
                      '+8'
                      '+9'
                      '+10'
                      '+11'
                      '+12'
                      '+13'
                      '+14')
                  end
                end
                object Panel66: TPanel
                  Left = 224
                  Top = 1
                  Width = 224
                  Height = 26
                  Alignment = taLeftJustify
                  BevelOuter = bvLowered
                  Caption = '  '#1042#1088#1077#1084#1077#1085#1085#1086#1081' '#1087#1086#1103#1089' (UTC-'#1083#1077#1090#1086') :'
                  TabOrder = 1
                  object cbTimeZoneS_1: TComboBox
                    Left = 158
                    Top = 2
                    Width = 64
                    Height = 21
                    Style = csDropDownList
                    ItemHeight = 13
                    TabOrder = 0
                    OnChange = cbTimeZoneChange
                    Items.Strings = (
                      '-14'
                      '-13'
                      '-12'
                      '-11'
                      '-10'
                      '-9'
                      '-8'
                      '-7'
                      '-6'
                      '-5'
                      '-4'
                      '-3'
                      '-2'
                      '-1'
                      '+0'
                      '+1'
                      '+2'
                      '+3'
                      '+4'
                      '+5'
                      '+6'
                      '+7'
                      '+8'
                      '+9'
                      '+10'
                      '+11'
                      '+12'
                      '+13'
                      '+14')
                  end
                end
                object Edit28: TEdit
                  Left = 56
                  Top = 32
                  Width = 329
                  Height = 21
                  MaxLength = 16
                  TabOrder = 2
                  Visible = False
                end
              end
              object Panel67: TPanel
                Left = 0
                Top = 0
                Width = 505
                Height = 16
                Align = alTop
                Alignment = taLeftJustify
                Caption = ' '#1059#1095#1077#1090#1085#1099#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1099' :'
                Font.Charset = RUSSIAN_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 0
              end
            end
            object Panel56: TPanel
              Left = 1
              Top = 176
              Width = 505
              Height = 38
              Align = alTop
              BevelOuter = bvNone
              TabOrder = 4
              object Label39: TLabel
                Left = 10
                Top = 8
                Width = 66
                Height = 13
                Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077':'
              end
              object mNote2: TMemo
                Left = 90
                Top = 0
                Width = 363
                Height = 33
                Lines.Strings = (
                  '')
                MaxLength = 256
                TabOrder = 0
                OnChange = EditChange
              end
            end
          end
        end
        object tsAddParam: TTabSheet
          Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1099
          ImageIndex = 2
          object Panel1: TScrollBox
            Left = 0
            Top = 0
            Width = 507
            Height = 649
            HelpContext = 5216
            Align = alClient
            TabOrder = 0
            object paAddParam: TPanel
              Left = 8
              Top = 4
              Width = 480
              Height = 693
              BevelOuter = bvNone
              TabOrder = 0
              object paCalcType: TPanel
                Left = 0
                Top = 278
                Width = 480
                Height = 67
                Align = alTop
                BevelOuter = bvNone
                Enabled = False
                TabOrder = 0
                Visible = False
                object Panel35: TPanel
                  Left = 0
                  Top = 0
                  Width = 480
                  Height = 16
                  Align = alTop
                  Alignment = taLeftJustify
                  BevelInner = bvRaised
                  BevelOuter = bvNone
                  Caption = ' '#1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1088#1072#1089#1095#1105#1090#1072':'
                  Font.Charset = RUSSIAN_CHARSET
                  Font.Color = clBlack
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = [fsBold]
                  ParentFont = False
                  TabOrder = 0
                end
                object Panel36: TPanel
                  Left = 0
                  Top = 16
                  Width = 480
                  Height = 47
                  Align = alTop
                  BevelInner = bvLowered
                  TabOrder = 1
                  object CalcBillCB: TCheckBox
                    Left = 4
                    Top = 4
                    Width = 161
                    Height = 17
                    Caption = #1042#1077#1088#1080#1092#1080#1094#1080#1088#1086#1074#1072#1090#1100' &'#1089#1091#1090#1086#1095#1085#1099#1077
                    TabOrder = 0
                  end
                  object CalcMonthCB: TCheckBox
                    Left = 4
                    Top = 24
                    Width = 161
                    Height = 17
                    Caption = #1042#1077#1088#1080#1092#1080#1094#1080#1088#1086#1074#1072#1090#1100' &'#1084#1077#1089#1103#1095#1085#1099#1077
                    TabOrder = 1
                  end
                end
              end
              object paTime: TPanel
                Left = 0
                Top = 0
                Width = 480
                Height = 50
                Align = alTop
                BevelOuter = bvNone
                TabOrder = 1
                object Panel37: TPanel
                  Left = 0
                  Top = 0
                  Width = 480
                  Height = 16
                  Align = alTop
                  Alignment = taLeftJustify
                  Caption = ' '#1042#1088#1077#1084#1103' '#1088#1072#1073#1086#1090#1099':'
                  Font.Charset = RUSSIAN_CHARSET
                  Font.Color = clBlack
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = [fsBold]
                  ParentFont = False
                  TabOrder = 0
                end
                object Panel38: TPanel
                  Left = 0
                  Top = 16
                  Width = 480
                  Height = 31
                  HelpContext = 5218
                  Align = alTop
                  BevelInner = bvLowered
                  TabOrder = 1
                  object Label26: TLabel
                    Left = 4
                    Top = 7
                    Width = 108
                    Height = 13
                    Caption = 'T '#1088#1072#1073#1086#1090#1099' ('#1085#1086#1088#1084'), '#1095#1072#1089':'
                  end
                  object Label27: TLabel
                    Left = 180
                    Top = 7
                    Width = 107
                    Height = 13
                    Caption = #1058' '#1087#1086#1083#1085#1086#1077' ('#1085#1086#1088#1084'), '#1095#1072#1089':'
                  end
                  object edTw: TEdit
                    Left = 114
                    Top = 5
                    Width = 61
                    Height = 21
                    MaxLength = 3
                    TabOrder = 0
                    OnChange = EditChange
                    OnKeyPress = edDoubleKeyPress
                  end
                  object edTf: TEdit
                    Left = 289
                    Top = 5
                    Width = 61
                    Height = 21
                    MaxLength = 3
                    TabOrder = 1
                    OnChange = EditChange
                    OnKeyPress = edDoubleKeyPress
                  end
                  object btSetTime: TBitBtn
                    Left = 360
                    Top = 3
                    Width = 75
                    Height = 25
                    Hint = #1047#1072#1076#1072#1090#1100' '#1074#1088#1077#1084#1103' '#1088#1072#1073#1086#1090#1099' '#1090#1086#1095#1082#1080' '#1086#1090#1083#1080#1095#1085#1086#1077' '#1086#1090' '#1085#1086#1088#1084#1072#1083#1100#1085#1086#1075#1086' '#1088#1077#1078#1080#1084#1072
                    Caption = #1047#1072#1076#1072#1090#1100
                    TabOrder = 2
                    OnClick = btSetTimeClick
                  end
                end
              end
              object paCalcPoint1: TPanel
                Left = 0
                Top = 50
                Width = 480
                Height = 130
                Align = alTop
                BevelOuter = bvNone
                TabOrder = 2
                object paCalcPoint: TPanel
                  Left = 0
                  Top = 0
                  Width = 480
                  Height = 130
                  Align = alClient
                  BevelOuter = bvNone
                  TabOrder = 0
                  object Panel40: TPanel
                    Left = 0
                    Top = 0
                    Width = 480
                    Height = 16
                    Align = alTop
                    Alignment = taLeftJustify
                    BevelInner = bvRaised
                    BevelOuter = bvNone
                    Caption = ' '#1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1088#1072#1089#1095#1105#1090#1085#1086#1081' '#1090#1086#1095#1082#1080' ('#1072#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1086#1077' '#1085#1072#1095#1080#1089#1083#1077#1085#1080#1077' '#1088#1072#1089#1093#1086#1076#1072'):'
                    Font.Charset = RUSSIAN_CHARSET
                    Font.Color = clBlack
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = [fsBold]
                    ParentFont = False
                    TabOrder = 0
                  end
                  object Panel41: TPanel
                    Left = 0
                    Top = 16
                    Width = 480
                    Height = 113
                    HelpContext = 5214
                    Align = alTop
                    BevelInner = bvLowered
                    TabOrder = 1
                    object paCalcGroup: TPanel
                      Left = 2
                      Top = 110
                      Width = 476
                      Height = 27
                      Align = alTop
                      Alignment = taLeftJustify
                      BevelInner = bvLowered
                      Caption = ' '#1056#1072#1089#1095#1077#1090#1085#1072#1103' '#1075#1088#1091#1087#1087#1072' :'
                      Font.Charset = DEFAULT_CHARSET
                      Font.Color = clWindowText
                      Font.Height = -11
                      Font.Name = 'MS Sans Serif'
                      Font.Style = []
                      ParentFont = False
                      TabOrder = 2
                      object sbGroupDrop: TSpeedButton
                        Left = 412
                        Top = 3
                        Width = 21
                        Height = 21
                        Hint = #1059#1076#1072#1083#1080#1090#1100' '#1088#1072#1089#1095#1077#1090#1085#1091#1102' '#1075#1088#1091#1087#1087#1091'  '#1076#1083#1103' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1081' '#1090#1086#1095#1082#1080'.'
                        Flat = True
                        Glyph.Data = {
                          1E070000424D1E07000000000000360000002800000022000000110000000100
                          180000000000E806000000000000000000000000000000000000C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8
                          D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
                          0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4C8D0D4C8D0D4C8D0
                          D4FFFFFFC8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8
                          D0D4FFFFFFC8D0D40000C0C0C0C0C0C0C0C0C0040404C0C0C0C0C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0040404C0C0C0C0C0C0C8D0D4
                          C8D0D4C8D0D4808080FFFFFFFFFFFFC8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0
                          D4C8D0D4C8D0D4808080FFFFFFC8D0D40000C0C0C0C0C0C00404040000800404
                          04C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C00000FFC0
                          C0C0C0C0C0C8D0D4C8D0D4808080808080808080FFFFFFFFFFFFC8D0D4C8D0D4
                          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4808080C8D0D4C8D0D40000C0C0C0C0C0C0
                          0000FF0000FF000080040404C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                          C0040404C0C0C0C0C0C0C0C0C0C8D0D4C8D0D4808080808080808080808080FF
                          FFFFC8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4808080FFFFFFC8D0D4C8D0D4
                          0000C0C0C0C0C0C03300CC0000FF0000FF000080C0C0C0C0C0C0C0C0C0C0C0C0
                          C0C0C0C0C0C00404040000FFC0C0C0C0C0C0C0C0C0C8D0D4C8D0D48080808080
                          80808080808080FFFFFFFFFFFFC8D0D4C8D0D4C8D0D4C8D0D4808080808080C8
                          D0D4C8D0D4C8D0D40000C0C0C0C0C0C0C0C0C03300CC0000FF0000FF040404C0
                          C0C0C0C0C0C0C0C0C0C0C00404040000FFC0C0C0C0C0C0C0C0C0C0C0C0C8D0D4
                          C8D0D4C8D0D4808080808080808080808080FFFFFFFFFFFFC8D0D4C8D0D48080
                          80808080FFFFFFC8D0D4C8D0D4C8D0D40000C0C0C0C0C0C0C0C0C0C0C0C03300
                          CC0000FF0000FF040404C0C0C0C0C0C00404040000FF0000FFC0C0C0C0C0C0C0
                          C0C0C0C0C0C8D0D4C8D0D4C8D0D4C8D0D4808080808080808080808080FFFFFF
                          FFFFFF808080808080808080C8D0D4C8D0D4C8D0D4C8D0D40000C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C03300CC0000FF0000FF0404040404040000FF0000FFC0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4C8D0D4C8D0D4C8D0D4C8D0D480808080
                          8080808080808080808080808080808080C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
                          0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C03300CC0000FF0000FF0000FF
                          0000FFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4C8D0D4C8D0D4C8D0
                          D4C8D0D4C8D0D4808080808080808080808080808080FFFFFFC8D0D4C8D0D4C8
                          D0D4C8D0D4C8D0D40000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C004040400
                          00FF0000FF0000FF040404C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4
                          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4808080808080808080808080808080FFFF
                          FFFFFFFFC8D0D4C8D0D4C8D0D4C8D0D40000C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                          C00404040000FF0000FF0000FF0000FF0000FF040404C0C0C0C0C0C0C0C0C0C0
                          C0C0C0C0C0C8D0D4C8D0D4C8D0D4C8D0D4FFFFFF808080808080808080808080
                          808080808080808080FFFFFFFFFFFFC8D0D4C8D0D4C8D0D40000C0C0C0C0C0C0
                          C0C0C00404040404040000FF0000FF0000FFC0C0C0C0C0C00000FF0000FF0404
                          04C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4C8D0D4C8D0D480808080808080808080
                          8080808080C8D0D4C8D0D4808080808080808080FFFFFFFFFFFFC8D0D4C8D0D4
                          0000C0C0C0C0C0C00404040000FF0000FF0000FF0000FFC0C0C0C0C0C0C0C0C0
                          C0C0C00000FF0000FF040404C0C0C0C0C0C0C0C0C0C8D0D4C8D0D48080808080
                          80808080808080808080C8D0D4C8D0D4C8D0D4C8D0D4808080808080808080FF
                          FFFFFFFFFFC8D0D40000C0C0C0C0C0C00000FF0000FF0000FF0000FFC0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C00000FF0000FF040404C0C0C0C0C0C0C8D0D4
                          C8D0D4808080808080808080808080C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0
                          D4808080808080808080FFFFFFC8D0D40000C0C0C0C0C0C00000FF0000FF0000
                          FFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C00000FFC0
                          C0C0C0C0C0C8D0D4C8D0D4808080808080808080C8D0D4C8D0D4C8D0D4C8D0D4
                          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4808080C8D0D4C8D0D40000C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8
                          D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
                          0000}
                        NumGlyphs = 2
                        ParentShowHint = False
                        ShowHint = True
                        OnClick = sbGroupDropClick
                      end
                      object sbGroupSel: TSpeedButton
                        Left = 390
                        Top = 3
                        Width = 21
                        Height = 21
                        Hint = #1042#1099#1073#1088#1072#1090#1100' '#1088#1072#1089#1095#1077#1090#1085#1091#1102' '#1075#1088#1091#1087#1087#1091' '#1080#1079' '#1087#1077#1088#1077#1095#1085#1103'  '#1075#1088#1091#1087#1087' '#1091#1095#1077#1090#1072
                        Flat = True
                        Glyph.Data = {
                          1E070000424D1E07000000000000360000002800000022000000110000000100
                          180000000000E806000000000000000000000000000000000000C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8
                          D0D4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                          0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0040404040404040404
                          040404040404040404040404040404040404040404C8D0D4C8D0D4C8D0D4C8D0
                          D4C8D0D4C8D0D480808080808080808080808080808080808080808080808080
                          8080808080FFFFFF0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C004
                          0404FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF040404C8D0D4
                          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4808080FFFFFFC8D0D4C8D0D4C8D0D4FFFF
                          FFFFFFFFC8D0D4C8D0D4808080FFFFFF0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                          C0C0C0C0C0C0C0040404FFFFFFFFFFFFFFFFFF808000808000FFFFFFFFFFFFFF
                          FFFF040404C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4808080FFFFFFC8D0D4
                          C8D0D4808080808080FFFFFFFFFFFFC8D0D4808080FFFFFF0000C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0040404FFFFFFFFFFFF8080008080008080
                          00808000FFFFFFFFFFFF040404C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D480
                          8080FFFFFFC8D0D4808080808080808080808080FFFFFFC8D0D4808080FFFFFF
                          0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0040404FFFFFFFFFFFF
                          808000808000808000808000FFFFFFFFFFFF040404C8D0D4C8D0D4C8D0D4C8D0
                          D4C8D0D4C8D0D4808080FFFFFFC8D0D4808080808080808080808080C8D0D4C8
                          D0D4808080FFFFFF0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C004
                          0404FFFFFFFFFFFFFFFFFF808000808000FFFFFFFFFFFFFFFFFF040404C8D0D4
                          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4808080FFFFFFC8D0D4C8D0D48080808080
                          80C8D0D4C8D0D4C8D0D4808080FFFFFF0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                          C0C0C0C0C0C0C0040404FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                          FFFF040404C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4808080FFFFFFFFFFFF
                          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF808080FFFFFF0000C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C00404040404040404040404040404040404
                          04040404040404040404040404C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D480
                          8080808080808080808080808080808080808080808080808080808080C8D0D4
                          0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                          C0C0C0C0C0C0008000C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4FFFFFFFFFFFFFFFF
                          FFFFFFFFFFFFFFFFFFFFC8D0D4C8D0D4C8D0D4C8D0D4808080FFFFFFFFFFFFC8
                          D0D4C8D0D4C8D0D40000C0C0C0040404040404040404040404040404040404C0
                          C0C0C0C0C0C0C0C0C0C0C0008000008000008000C0C0C0C0C0C0C0C0C0808080
                          808080808080808080808080808080FFFFFFC8D0D4C8D0D4C8D0D48080808080
                          80808080C8D0D4C8D0D4C8D0D4C8D0D40000C0C0C0040404FFFFFFFFFFFFFFFF
                          FFFFFFFF040404C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0008000C0C0C0C0C0C0C0
                          C0C0C0C0C0808080FFFFFFC8D0D4FFFFFFFFFFFF808080FFFFFFC8D0D4FFFFFF
                          C8D0D4C8D0D4808080FFFFFFC8D0D4C8D0D4C8D0D4C8D0D40000C0C0C0040404
                          FFFFFF808000808000FFFFFF040404C0C0C0008000C0C0C0C0C0C00080000080
                          00C0C0C0C0C0C0C0C0C0C0C0C0808080FFFFFF808080808080FFFFFF808080FF
                          FFFF808080FFFFFFFFFFFF808080808080C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
                          0000C0C0C0040404FFFFFF808000808000FFFFFF040404008000008000008000
                          008000008000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0808080FFFFFF8080808080
                          80C8D0D4808080808080808080808080808080808080C8D0D4C8D0D4C8D0D4C8
                          D0D4C8D0D4C8D0D40000C0C0C0040404FFFFFFFFFFFFFFFFFFFFFFFF040404C0
                          C0C0008000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0808080
                          FFFFFFFFFFFFFFFFFFFFFFFF808080FFFFFF808080C8D0D4C8D0D4C8D0D4C8D0
                          D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D40000C0C0C00404040404040404040404
                          04040404040404C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                          C0C0C0C0C0808080808080808080808080808080808080C8D0D4C8D0D4C8D0D4
                          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D40000C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8
                          D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
                          0000}
                        NumGlyphs = 2
                        ParentShowHint = False
                        ShowHint = True
                        OnClick = sbGroupSelClick
                      end
                      object eGroup: TEdit
                        Tag = 9
                        Left = 114
                        Top = 3
                        Width = 273
                        Height = 21
                        Color = clMenu
                        ReadOnly = True
                        TabOrder = 0
                      end
                    end
                    object paCalcFormula: TPanel
                      Left = 2
                      Top = 83
                      Width = 476
                      Height = 27
                      Align = alTop
                      Alignment = taLeftJustify
                      BevelInner = bvLowered
                      Caption = ' '#1056#1072#1089#1095#1077#1090#1085#1072#1103' '#1092#1086#1088#1084#1091#1083#1072' '#1076#1083#1103':'
                      Font.Charset = DEFAULT_CHARSET
                      Font.Color = clWindowText
                      Font.Height = -11
                      Font.Name = 'MS Sans Serif'
                      Font.Style = []
                      ParentFont = False
                      TabOrder = 1
                      object sbDeleteFormula: TSpeedButton
                        Left = 412
                        Top = 3
                        Width = 21
                        Height = 21
                        Hint = #1054#1090#1084#1077#1085#1080#1090#1100' '#1088#1072#1089#1095#1077#1090' '#1087#1086' '#1092#1086#1088#1084#1091#1083#1077
                        Flat = True
                        Glyph.Data = {
                          1E070000424D1E07000000000000360000002800000022000000110000000100
                          180000000000E806000000000000000000000000000000000000C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8
                          D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
                          0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4C8D0D4C8D0D4C8D0
                          D4FFFFFFC8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8
                          D0D4FFFFFFC8D0D40000C0C0C0C0C0C0C0C0C0040404C0C0C0C0C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0040404C0C0C0C0C0C0C8D0D4
                          C8D0D4C8D0D4808080FFFFFFFFFFFFC8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0
                          D4C8D0D4C8D0D4808080FFFFFFC8D0D40000C0C0C0C0C0C00404040000800404
                          04C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C00000FFC0
                          C0C0C0C0C0C8D0D4C8D0D4808080808080808080FFFFFFFFFFFFC8D0D4C8D0D4
                          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4808080C8D0D4C8D0D40000C0C0C0C0C0C0
                          0000FF0000FF000080040404C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                          C0040404C0C0C0C0C0C0C0C0C0C8D0D4C8D0D4808080808080808080808080FF
                          FFFFC8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4808080FFFFFFC8D0D4C8D0D4
                          0000C0C0C0C0C0C03300CC0000FF0000FF000080C0C0C0C0C0C0C0C0C0C0C0C0
                          C0C0C0C0C0C00404040000FFC0C0C0C0C0C0C0C0C0C8D0D4C8D0D48080808080
                          80808080808080FFFFFFFFFFFFC8D0D4C8D0D4C8D0D4C8D0D4808080808080C8
                          D0D4C8D0D4C8D0D40000C0C0C0C0C0C0C0C0C03300CC0000FF0000FF040404C0
                          C0C0C0C0C0C0C0C0C0C0C00404040000FFC0C0C0C0C0C0C0C0C0C0C0C0C8D0D4
                          C8D0D4C8D0D4808080808080808080808080FFFFFFFFFFFFC8D0D4C8D0D48080
                          80808080FFFFFFC8D0D4C8D0D4C8D0D40000C0C0C0C0C0C0C0C0C0C0C0C03300
                          CC0000FF0000FF040404C0C0C0C0C0C00404040000FF0000FFC0C0C0C0C0C0C0
                          C0C0C0C0C0C8D0D4C8D0D4C8D0D4C8D0D4808080808080808080808080FFFFFF
                          FFFFFF808080808080808080C8D0D4C8D0D4C8D0D4C8D0D40000C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C03300CC0000FF0000FF0404040404040000FF0000FFC0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4C8D0D4C8D0D4C8D0D4C8D0D480808080
                          8080808080808080808080808080808080C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
                          0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C03300CC0000FF0000FF0000FF
                          0000FFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4C8D0D4C8D0D4C8D0
                          D4C8D0D4C8D0D4808080808080808080808080808080FFFFFFC8D0D4C8D0D4C8
                          D0D4C8D0D4C8D0D40000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C004040400
                          00FF0000FF0000FF040404C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4
                          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4808080808080808080808080808080FFFF
                          FFFFFFFFC8D0D4C8D0D4C8D0D4C8D0D40000C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                          C00404040000FF0000FF0000FF0000FF0000FF040404C0C0C0C0C0C0C0C0C0C0
                          C0C0C0C0C0C8D0D4C8D0D4C8D0D4C8D0D4FFFFFF808080808080808080808080
                          808080808080808080FFFFFFFFFFFFC8D0D4C8D0D4C8D0D40000C0C0C0C0C0C0
                          C0C0C00404040404040000FF0000FF0000FFC0C0C0C0C0C00000FF0000FF0404
                          04C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4C8D0D4C8D0D480808080808080808080
                          8080808080C8D0D4C8D0D4808080808080808080FFFFFFFFFFFFC8D0D4C8D0D4
                          0000C0C0C0C0C0C00404040000FF0000FF0000FF0000FFC0C0C0C0C0C0C0C0C0
                          C0C0C00000FF0000FF040404C0C0C0C0C0C0C0C0C0C8D0D4C8D0D48080808080
                          80808080808080808080C8D0D4C8D0D4C8D0D4C8D0D4808080808080808080FF
                          FFFFFFFFFFC8D0D40000C0C0C0C0C0C00000FF0000FF0000FF0000FFC0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C00000FF0000FF040404C0C0C0C0C0C0C8D0D4
                          C8D0D4808080808080808080808080C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0
                          D4808080808080808080FFFFFFC8D0D40000C0C0C0C0C0C00000FF0000FF0000
                          FFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C00000FFC0
                          C0C0C0C0C0C8D0D4C8D0D4808080808080808080C8D0D4C8D0D4C8D0D4C8D0D4
                          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4808080C8D0D4C8D0D40000C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8
                          D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
                          0000}
                        NumGlyphs = 2
                        ParentShowHint = False
                        ShowHint = True
                        OnClick = sbDeleteFormulaClick
                      end
                      object sbFormula: TSpeedButton
                        Left = 390
                        Top = 3
                        Width = 21
                        Height = 21
                        Hint = #1047#1072#1076#1072#1090#1100' '#1092#1086#1088#1084#1091#1083#1091' '#1076#1083#1103' '#1088#1072#1089#1095#1077#1090#1072' '#1087#1072#1088#1072#1084#1077#1090#1088#1072
                        Flat = True
                        Glyph.Data = {
                          1E070000424D1E07000000000000360000002800000022000000110000000100
                          180000000000E806000000000000000000000000000000000000C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8
                          D0D4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                          0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0040404040404040404
                          040404040404040404040404040404040404040404C8D0D4C8D0D4C8D0D4C8D0
                          D4C8D0D4C8D0D480808080808080808080808080808080808080808080808080
                          8080808080FFFFFF0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C004
                          0404FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF040404C8D0D4
                          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4808080FFFFFFC8D0D4C8D0D4C8D0D4FFFF
                          FFFFFFFFC8D0D4C8D0D4808080FFFFFF0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                          C0C0C0C0C0C0C0040404FFFFFFFFFFFFFFFFFF808000808000FFFFFFFFFFFFFF
                          FFFF040404C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4808080FFFFFFC8D0D4
                          C8D0D4808080808080FFFFFFFFFFFFC8D0D4808080FFFFFF0000C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0040404FFFFFFFFFFFF8080008080008080
                          00808000FFFFFFFFFFFF040404C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D480
                          8080FFFFFFC8D0D4808080808080808080808080FFFFFFC8D0D4808080FFFFFF
                          0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0040404FFFFFFFFFFFF
                          808000808000808000808000FFFFFFFFFFFF040404C8D0D4C8D0D4C8D0D4C8D0
                          D4C8D0D4C8D0D4808080FFFFFFC8D0D4808080808080808080808080C8D0D4C8
                          D0D4808080FFFFFF0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C004
                          0404FFFFFFFFFFFFFFFFFF808000808000FFFFFFFFFFFFFFFFFF040404C8D0D4
                          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4808080FFFFFFC8D0D4C8D0D48080808080
                          80C8D0D4C8D0D4C8D0D4808080FFFFFF0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                          C0C0C0C0C0C0C0040404FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                          FFFF040404C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4808080FFFFFFFFFFFF
                          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF808080FFFFFF0000C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C00404040404040404040404040404040404
                          04040404040404040404040404C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D480
                          8080808080808080808080808080808080808080808080808080808080C8D0D4
                          0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                          C0C0C0C0C0C0008000C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4FFFFFFFFFFFFFFFF
                          FFFFFFFFFFFFFFFFFFFFC8D0D4C8D0D4C8D0D4C8D0D4808080FFFFFFFFFFFFC8
                          D0D4C8D0D4C8D0D40000C0C0C0040404040404040404040404040404040404C0
                          C0C0C0C0C0C0C0C0C0C0C0008000008000008000C0C0C0C0C0C0C0C0C0808080
                          808080808080808080808080808080FFFFFFC8D0D4C8D0D4C8D0D48080808080
                          80808080C8D0D4C8D0D4C8D0D4C8D0D40000C0C0C0040404FFFFFFFFFFFFFFFF
                          FFFFFFFF040404C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0008000C0C0C0C0C0C0C0
                          C0C0C0C0C0808080FFFFFFC8D0D4FFFFFFFFFFFF808080FFFFFFC8D0D4FFFFFF
                          C8D0D4C8D0D4808080FFFFFFC8D0D4C8D0D4C8D0D4C8D0D40000C0C0C0040404
                          FFFFFF808000808000FFFFFF040404C0C0C0008000C0C0C0C0C0C00080000080
                          00C0C0C0C0C0C0C0C0C0C0C0C0808080FFFFFF808080808080FFFFFF808080FF
                          FFFF808080FFFFFFFFFFFF808080808080C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
                          0000C0C0C0040404FFFFFF808000808000FFFFFF040404008000008000008000
                          008000008000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0808080FFFFFF8080808080
                          80C8D0D4808080808080808080808080808080808080C8D0D4C8D0D4C8D0D4C8
                          D0D4C8D0D4C8D0D40000C0C0C0040404FFFFFFFFFFFFFFFFFFFFFFFF040404C0
                          C0C0008000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0808080
                          FFFFFFFFFFFFFFFFFFFFFFFF808080FFFFFF808080C8D0D4C8D0D4C8D0D4C8D0
                          D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D40000C0C0C00404040404040404040404
                          04040404040404C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                          C0C0C0C0C0808080808080808080808080808080808080C8D0D4C8D0D4C8D0D4
                          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D40000C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                          C0C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8
                          D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
                          0000}
                        NumGlyphs = 2
                        ParentShowHint = False
                        ShowHint = True
                        OnClick = sbFormulaClick
                      end
                      object edFormula: TEdit
                        Tag = 9
                        Left = 134
                        Top = 3
                        Width = 253
                        Height = 21
                        Color = clMenu
                        ReadOnly = True
                        TabOrder = 0
                      end
                    end
                    object Panel23: TPanel
                      Left = 2
                      Top = 2
                      Width = 476
                      Height = 81
                      Align = alTop
                      BevelOuter = bvNone
                      TabOrder = 0
                      object Label49: TLabel
                        Left = 4
                        Top = 8
                        Width = 84
                        Height = 13
                        Caption = #1058#1080#1087' '#1085#1072#1095#1080#1089#1083#1077#1085#1080#1103':'
                      end
                      object Label50: TLabel
                        Left = 4
                        Top = 35
                        Width = 206
                        Height = 13
                        Caption = #1058#1077#1082#1091#1097#1072#1103' '#1091#1089#1090#1072#1085#1086#1074#1083#1077#1085#1085#1072#1103' '#1084#1086#1097#1085#1086#1089#1090#1100', '#1082#1042#1090':'
                      end
                      object Label51: TLabel
                        Left = 4
                        Top = 61
                        Width = 237
                        Height = 13
                        Caption = #1058#1077#1082#1091#1097#1077#1077' '#1089#1088#1077#1076#1085#1077#1084#1077#1089#1103#1095#1085#1086#1077' '#1087#1086#1090#1088#1077#1073#1083#1077#1085#1080#1077', '#1082#1042#1090'*'#1095':'
                      end
                      object cbCalcType: TComboBox
                        Left = 92
                        Top = 5
                        Width = 344
                        Height = 21
                        Style = csDropDownList
                        ItemHeight = 13
                        TabOrder = 0
                        OnChange = cbChange
                      end
                      object edCurrPower: TEdit
                        Tag = 9
                        Left = 245
                        Top = 31
                        Width = 61
                        Height = 21
                        TabStop = False
                        Color = clBtnFace
                        MaxLength = 3
                        ReadOnly = True
                        TabOrder = 1
                        OnKeyPress = edDoubleKeyPress
                      end
                      object edMonthConsumpt: TEdit
                        Tag = 9
                        Left = 245
                        Top = 57
                        Width = 61
                        Height = 21
                        TabStop = False
                        Color = clBtnFace
                        MaxLength = 3
                        ReadOnly = True
                        TabOrder = 2
                        OnKeyPress = edDoubleKeyPress
                      end
                      object btCalcParam: TBitBtn
                        Left = 312
                        Top = 41
                        Width = 124
                        Height = 25
                        Hint = #1048#1079#1084#1077#1085#1080#1090#1100' '#1085#1086#1088#1072#1090#1080#1074#1085#1099#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1099
                        Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1087#1072#1088#1072#1084#1077#1090#1088#1099
                        TabOrder = 3
                        OnClick = btCalcParamClick
                      end
                    end
                  end
                end
              end
              object Panel5: TPanel
                Left = 0
                Top = 180
                Width = 480
                Height = 98
                Align = alTop
                BevelOuter = bvNone
                TabOrder = 3
                object Panel39: TPanel
                  Left = 0
                  Top = 0
                  Width = 480
                  Height = 16
                  Align = alTop
                  Alignment = taLeftJustify
                  BevelInner = bvRaised
                  BevelOuter = bvNone
                  Caption = ' '#1050#1086#1085#1090#1088#1086#1083#1100' '#1085#1072#1083#1080#1095#1080#1103' '#1076#1072#1085#1085#1099#1093' :'
                  Font.Charset = RUSSIAN_CHARSET
                  Font.Color = clBlack
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = [fsBold]
                  ParentFont = False
                  TabOrder = 0
                end
                object Panel42: TPanel
                  Left = 0
                  Top = 16
                  Width = 480
                  Height = 79
                  HelpContext = 5219
                  Align = alTop
                  BevelInner = bvLowered
                  TabOrder = 1
                  object lTech: TLabel
                    Left = 4
                    Top = 35
                    Width = 156
                    Height = 13
                    Caption = #1058#1077#1093#1085#1080#1095#1077#1089#1082#1080#1081' '#1082#1086#1085#1090#1088#1086#1083#1100',    '#1084#1080#1085' :'
                  end
                  object lComm: TLabel
                    Left = 4
                    Top = 11
                    Width = 158
                    Height = 13
                    Caption = #1050#1086#1084#1084#1077#1088#1095#1077#1089#1082#1080#1081' '#1082#1086#1085#1090#1088#1086#1083#1100', '#1084#1080#1085' :'
                  end
                  object eComm: TEdit
                    Left = 168
                    Top = 8
                    Width = 73
                    Height = 21
                    MaxLength = 4
                    TabOrder = 0
                    OnChange = EditChange
                    OnKeyPress = edLongKeyPress
                  end
                  object eTech: TEdit
                    Left = 168
                    Top = 32
                    Width = 73
                    Height = 21
                    MaxLength = 4
                    TabOrder = 1
                    OnChange = EditChange
                    OnKeyPress = edLongKeyPress
                  end
                  object cbDataAbsence: TCheckBox
                    Left = 4
                    Top = 58
                    Width = 233
                    Height = 17
                    Caption = #1057#1080'&'#1075#1085#1072#1083#1080#1079#1080#1088#1086#1074#1072#1090#1100' '#1086#1073' '#1086#1090#1089#1091#1090#1089#1090#1074#1080#1080' '#1076#1072#1085#1085#1099#1093
                    TabOrder = 2
                    OnClick = CheckBoxClick
                  end
                end
              end
              object plVerifyBase: TPanel
                Left = 0
                Top = 447
                Width = 480
                Height = 51
                HelpContext = 5210
                Align = alTop
                BevelOuter = bvNone
                TabOrder = 6
                object plVerifyParam: TPanel
                  Left = 0
                  Top = 17
                  Width = 480
                  Height = 31
                  Align = alTop
                  BevelInner = bvLowered
                  TabOrder = 0
                  object eVerifyParam: TEdit
                    Left = 4
                    Top = 5
                    Width = 433
                    Height = 21
                    MaxLength = 255
                    TabOrder = 0
                  end
                end
                object plVerifyTitle: TPanel
                  Left = 0
                  Top = 0
                  Width = 480
                  Height = 17
                  Align = alTop
                  Alignment = taLeftJustify
                  Caption = ' '#1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1074#1077#1088#1080#1092#1080#1082#1072#1094#1080#1080' '#1087#1086' '#1076#1091#1073#1083#1103#1084':'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = [fsBold]
                  ParentFont = False
                  TabOrder = 1
                end
              end
              object pAddParamBase: TPanel
                Left = 0
                Top = 498
                Width = 480
                Height = 52
                HelpContext = 5210
                Align = alTop
                BevelOuter = bvNone
                TabOrder = 7
                object pAddParam: TPanel
                  Left = 0
                  Top = 17
                  Width = 480
                  Height = 31
                  HelpContext = 5216
                  Align = alTop
                  BevelInner = bvLowered
                  TabOrder = 0
                  object eAddParams: TEdit
                    Left = 4
                    Top = 5
                    Width = 433
                    Height = 21
                    TabOrder = 0
                  end
                end
                object pAddParamTitle: TPanel
                  Left = 0
                  Top = 0
                  Width = 480
                  Height = 17
                  Align = alTop
                  Alignment = taLeftJustify
                  Caption = ' '#1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1099' :'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = [fsBold]
                  ParentFont = False
                  TabOrder = 1
                end
              end
              object pImportCodeBase: TPanel
                Left = 0
                Top = 345
                Width = 480
                Height = 51
                HelpContext = 5210
                Align = alTop
                BevelOuter = bvNone
                TabOrder = 4
                object pImportCode: TPanel
                  Left = 0
                  Top = 17
                  Width = 480
                  Height = 31
                  HelpContext = 16011
                  Align = alTop
                  BevelInner = bvLowered
                  TabOrder = 0
                  object eImportCode: TEdit
                    Left = 4
                    Top = 5
                    Width = 433
                    Height = 21
                    TabOrder = 0
                  end
                end
                object pImportCodeTitle: TPanel
                  Left = 0
                  Top = 0
                  Width = 480
                  Height = 17
                  Align = alTop
                  Alignment = taLeftJustify
                  Caption = ' '#1057#1074#1103#1079#1085#1086#1081' '#1082#1086#1076' '#1080#1084#1087#1086#1088#1090#1072' :'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = [fsBold]
                  ParentFont = False
                  TabOrder = 1
                end
              end
              object plVerifyBaseDay: TPanel
                Left = 0
                Top = 396
                Width = 480
                Height = 51
                HelpContext = 5210
                Align = alTop
                BevelOuter = bvNone
                TabOrder = 5
                object plVerifyDay: TPanel
                  Left = 0
                  Top = 17
                  Width = 480
                  Height = 31
                  Align = alTop
                  BevelInner = bvLowered
                  TabOrder = 0
                  object eVerifyDay: TEdit
                    Left = 4
                    Top = 5
                    Width = 433
                    Height = 21
                    MaxLength = 31
                    TabOrder = 0
                  end
                end
                object plVerifyTitleDay: TPanel
                  Left = 0
                  Top = 0
                  Width = 480
                  Height = 17
                  Align = alTop
                  Alignment = taLeftJustify
                  Caption = ' '#1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1074#1077#1088#1080#1092#1080#1082#1072#1094#1080#1080' '#1089#1091#1090#1086#1095#1085#1099#1093' '#1087#1086' '#1043#1053':'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = [fsBold]
                  ParentFont = False
                  TabOrder = 1
                end
              end
              object Panel26: TPanel
                Left = 0
                Top = 550
                Width = 480
                Height = 52
                Align = alTop
                BevelOuter = bvNone
                TabOrder = 8
                DesignSize = (
                  480
                  52)
                object Panel14: TPanel
                  Left = 0
                  Top = 18
                  Width = 480
                  Height = 32
                  Alignment = taLeftJustify
                  Anchors = [akLeft, akTop, akRight]
                  BevelInner = bvLowered
                  TabOrder = 0
                  object btTU: TButton
                    Left = 5
                    Top = 4
                    Width = 130
                    Height = 25
                    Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1087#1072#1088#1072#1084#1077#1090#1088#1099
                    TabOrder = 0
                    OnClick = btTUClick
                  end
                end
                object Panel6: TPanel
                  Left = 0
                  Top = 1
                  Width = 480
                  Height = 17
                  Alignment = taLeftJustify
                  Anchors = [akLeft, akTop, akRight]
                  Caption = ' '#1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1090#1077#1083#1077#1091#1087#1088#1072#1074#1083#1077#1085#1080#1103' :'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = [fsBold]
                  ParentFont = False
                  TabOrder = 1
                end
              end
              object Panel44: TPanel
                Left = 0
                Top = 602
                Width = 480
                Height = 50
                Align = alTop
                BevelOuter = bvNone
                TabOrder = 9
              end
            end
          end
        end
        object tsLoss: TTabSheet
          Caption = #1055#1086#1090#1077#1088#1080
          ImageIndex = 1
          object sbLoss: TScrollBox
            Left = 0
            Top = 0
            Width = 507
            Height = 649
            Align = alClient
            TabOrder = 0
            object paLoss: TPanel
              Left = 0
              Top = 0
              Width = 503
              Height = 645
              HelpContext = 5217
              Align = alClient
              BevelOuter = bvNone
              Constraints.MinHeight = 360
              TabOrder = 0
              object paSimpleLoss: TPanel
                Left = 0
                Top = 54
                Width = 442
                Height = 29
                BevelOuter = bvNone
                TabOrder = 1
                object Label23: TLabel
                  Left = 6
                  Top = 6
                  Width = 46
                  Height = 13
                  Caption = #1042' '#1083#1080#1085#1080#1080' :'
                end
                object Label24: TLabel
                  Left = 130
                  Top = 6
                  Width = 76
                  Height = 13
                  Caption = #1040#1082#1090' '#1074' '#1090#1088#1072#1085#1089#1092'. :'
                end
                object Label25: TLabel
                  Left = 280
                  Top = 6
                  Width = 88
                  Height = 13
                  Caption = #1056#1077#1072#1082#1090' '#1074' '#1090#1088#1072#1085#1089#1092'. :'
                end
                object edLineLoss: TEdit
                  Left = 56
                  Top = 2
                  Width = 61
                  Height = 21
                  TabOrder = 0
                  OnChange = EditChange
                  OnKeyPress = edDoubleKeyPress
                end
                object edATrLoss: TEdit
                  Left = 211
                  Top = 2
                  Width = 61
                  Height = 21
                  TabOrder = 1
                  OnChange = EditChange
                  OnKeyPress = edDoubleKeyPress
                end
                object edRTrLoss: TEdit
                  Left = 372
                  Top = 2
                  Width = 61
                  Height = 21
                  TabOrder = 2
                  OnChange = EditChange
                  OnKeyPress = edDoubleKeyPress
                end
              end
              object Panel13: TPanel
                Left = 0
                Top = 0
                Width = 503
                Height = 54
                Align = alTop
                BevelOuter = bvNone
                TabOrder = 0
                object Label22: TLabel
                  Left = 4
                  Top = 8
                  Width = 104
                  Height = 13
                  Caption = #1057#1087#1086#1089#1086#1073' '#1074#1099#1095#1080#1089#1083#1077#1085#1080#1103':'
                end
                object Label29: TLabel
                  Left = 4
                  Top = 34
                  Width = 101
                  Height = 13
                  Caption = #1056#1072#1089#1093#1086#1076' '#1088#1077#1072#1082#1090#1080#1074#1085#1086#1081':'
                end
                object cbLossType: TComboBox
                  Left = 114
                  Top = 4
                  Width = 325
                  Height = 21
                  Style = csDropDownList
                  ItemHeight = 13
                  TabOrder = 0
                  OnChange = cbChange
                  Items.Strings = (
                    #1041#1077#1079' '#1087#1086#1090#1077#1088#1100
                    #1055#1088#1086#1094#1077#1085#1090' '#1086#1090' '#1088#1072#1089#1093#1086#1076#1072
                    #1060#1080#1082#1089#1080#1088#1086#1074#1072#1085#1099#1077' '#1087#1086#1090#1077#1088#1080
                    #1055#1088#1086#1094#1077#1085#1090' '#1086#1090' '#1088#1072#1089#1093#1086#1076#1072' '#1074' 2'
                    #1055#1086' '#1092#1086#1088#1084#1091#1083#1077)
                end
                object cbCalcR: TComboBox
                  Left = 114
                  Top = 30
                  Width = 325
                  Height = 21
                  Style = csDropDownList
                  ItemHeight = 13
                  TabOrder = 1
                  OnChange = cbChange
                end
              end
              object paFormulaLoss: TPanel
                Left = 0
                Top = 54
                Width = 503
                Height = 591
                Align = alClient
                BevelOuter = bvNone
                TabOrder = 2
                object DBCtrlGrid1: TDBCtrlGrid
                  Left = 0
                  Top = 0
                  Width = 503
                  Height = 560
                  Align = alClient
                  AllowDelete = False
                  AllowInsert = False
                  ColCount = 2
                  Constraints.MinHeight = 266
                  DataSource = dsMain
                  Orientation = goHorizontal
                  PanelHeight = 543
                  PanelWidth = 251
                  TabOrder = 0
                  RowCount = 1
                  object Label28: TLabel
                    Left = 4
                    Top = 4
                    Width = 75
                    Height = 13
                    Caption = #1048#1076' '#1087#1072#1088#1072#1084#1077#1090#1088#1072':'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = [fsUnderline]
                    ParentFont = False
                  end
                  object Label10: TLabel
                    Left = 4
                    Top = 96
                    Width = 22
                    Height = 13
                    Caption = 'S'#1085' ='
                  end
                  object Label11: TLabel
                    Left = 4
                    Top = 122
                    Width = 31
                    Height = 13
                    Caption = 'P'#1082#1079' = '
                  end
                  object Label18: TLabel
                    Left = 116
                    Top = 122
                    Width = 29
                    Height = 13
                    Caption = 'Pxx = '
                  end
                  object Label12: TLabel
                    Left = 4
                    Top = 148
                    Width = 25
                    Height = 13
                    Caption = 'Ixx = '
                  end
                  object Label13: TLabel
                    Left = 116
                    Top = 148
                    Width = 32
                    Height = 13
                    Caption = 'U'#1082#1079' = '
                  end
                  object Label14: TLabel
                    Left = 4
                    Top = 174
                    Width = 26
                    Height = 13
                    Caption = 'Ro = '
                  end
                  object Label15: TLabel
                    Left = 116
                    Top = 174
                    Width = 25
                    Height = 13
                    Caption = 'Xo = '
                  end
                  object Label16: TLabel
                    Left = 4
                    Top = 200
                    Width = 18
                    Height = 13
                    Caption = 'L = '
                  end
                  object Label17: TLabel
                    Left = 116
                    Top = 198
                    Width = 26
                    Height = 13
                    Caption = 'Un = '
                  end
                  object Label19: TLabel
                    Left = 4
                    Top = 226
                    Width = 48
                    Height = 13
                    Caption = 'T'#1088#1072#1073', '#1095#1072#1089
                    Visible = False
                  end
                  object Label20: TLabel
                    Left = 114
                    Top = 226
                    Width = 48
                    Height = 13
                    Caption = #1058#1087#1086#1083', '#1095#1072#1089
                    Visible = False
                  end
                  object Label21: TLabel
                    Left = 4
                    Top = 68
                    Width = 44
                    Height = 13
                    Caption = '% '#1040#1082#1090#1080#1074'.'
                  end
                  object Label30: TLabel
                    Left = 114
                    Top = 68
                    Width = 56
                    Height = 13
                    Caption = '% '#1056#1077#1072#1082#1090#1080#1074'.'
                  end
                  object Label31: TLabel
                    Left = 4
                    Top = 24
                    Width = 53
                    Height = 13
                    Caption = #1053#1072#1079#1074#1072#1085#1080#1077':'
                  end
                  object DBText2: TDBText
                    Left = 160
                    Top = 4
                    Width = 59
                    Height = 13
                    DataSource = dsMain
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clBlue
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = [fsBold]
                    ParentFont = False
                  end
                  object Bevel1: TBevel
                    Left = 156
                    Top = 2
                    Width = 69
                    Height = 17
                  end
                  object Label8: TLabel
                    Left = 117
                    Top = 96
                    Width = 40
                    Height = 13
                    Caption = 'S'#1085' '#1086#1073'. ='
                  end
                  object DBEdit13: TDBEdit
                    Left = 60
                    Top = 22
                    Width = 163
                    Height = 21
                    DataSource = dsMain
                    TabOrder = 0
                  end
                  object DBEdit1: TDBEdit
                    Left = 60
                    Top = 92
                    Width = 49
                    Height = 21
                    Color = clBtnFace
                    DataSource = dsMain
                    ReadOnly = True
                    TabOrder = 4
                  end
                  object DBEdit7: TDBEdit
                    Left = 60
                    Top = 118
                    Width = 49
                    Height = 21
                    Color = clBtnFace
                    DataSource = dsMain
                    ReadOnly = True
                    TabOrder = 5
                  end
                  object DBEdit5: TDBEdit
                    Left = 172
                    Top = 118
                    Width = 49
                    Height = 21
                    Color = clBtnFace
                    DataSource = dsMain
                    ReadOnly = True
                    TabOrder = 6
                  end
                  object DBEdit8: TDBEdit
                    Left = 60
                    Top = 144
                    Width = 49
                    Height = 21
                    Color = clBtnFace
                    DataSource = dsMain
                    ReadOnly = True
                    TabOrder = 7
                  end
                  object DBEdit9: TDBEdit
                    Left = 172
                    Top = 144
                    Width = 49
                    Height = 21
                    Color = clBtnFace
                    DataSource = dsMain
                    ReadOnly = True
                    TabOrder = 8
                  end
                  object DBEdit2: TDBEdit
                    Left = 60
                    Top = 170
                    Width = 49
                    Height = 21
                    Color = clBtnFace
                    DataSource = dsMain
                    ReadOnly = True
                    TabOrder = 9
                  end
                  object DBEdit3: TDBEdit
                    Left = 172
                    Top = 170
                    Width = 49
                    Height = 21
                    Color = clBtnFace
                    DataSource = dsMain
                    ReadOnly = True
                    TabOrder = 10
                  end
                  object DBEdit4: TDBEdit
                    Left = 60
                    Top = 196
                    Width = 49
                    Height = 21
                    Color = clBtnFace
                    DataSource = dsMain
                    ReadOnly = True
                    TabOrder = 11
                  end
                  object DBEdit6: TDBEdit
                    Left = 172
                    Top = 196
                    Width = 49
                    Height = 21
                    Color = clBtnFace
                    DataSource = dsMain
                    ReadOnly = True
                    TabOrder = 12
                  end
                  object DBEdit10: TDBEdit
                    Left = 60
                    Top = 222
                    Width = 49
                    Height = 21
                    DataSource = dsMain
                    MaxLength = 3
                    TabOrder = 13
                    Visible = False
                  end
                  object DBEdit11: TDBEdit
                    Left = 172
                    Top = 222
                    Width = 49
                    Height = 21
                    DataSource = dsMain
                    MaxLength = 3
                    TabOrder = 14
                    Visible = False
                  end
                  object DBEdit12: TDBEdit
                    Left = 60
                    Top = 66
                    Width = 49
                    Height = 21
                    DataSource = dsMain
                    TabOrder = 2
                  end
                  object DBCheckBox1: TDBCheckBox
                    Left = 4
                    Top = 223
                    Width = 129
                    Height = 18
                    BiDiMode = bdLeftToRight
                    Caption = #1056#1072#1089#1093#1086#1076' '#1085#1077' '#1091#1095#1080#1090#1099#1074#1072#1090#1100
                    DataSource = dsMain
                    ParentBiDiMode = False
                    TabOrder = 15
                    ValueChecked = '1'
                    ValueUnchecked = '0'
                    Visible = False
                  end
                  object DBEdit14: TDBEdit
                    Left = 172
                    Top = 66
                    Width = 49
                    Height = 21
                    DataSource = dsMain
                    TabOrder = 3
                  end
                  object DBCheckBox2: TDBCheckBox
                    Left = 4
                    Top = 45
                    Width = 227
                    Height = 18
                    BiDiMode = bdLeftToRight
                    Caption = #1057#1095#1080#1090#1072#1090#1100' '#1087#1086#1090#1077#1088#1080' '#1082#1072#1082' '#1087#1088#1086#1094#1077#1085#1090' '#1086#1090' '#1088#1072#1089#1093#1086#1076#1072
                    DataSource = dsMain
                    ParentBiDiMode = False
                    TabOrder = 1
                    ValueChecked = '1'
                    ValueUnchecked = '0'
                  end
                  object DBText1: TDBEdit
                    Left = 83
                    Top = 4
                    Width = 70
                    Height = 16
                    BorderStyle = bsNone
                    Color = clMenu
                    DataSource = dsMain
                    ReadOnly = True
                    TabOrder = 16
                  end
                  object DBEdit15: TDBEdit
                    Left = 172
                    Top = 92
                    Width = 49
                    Height = 21
                    Color = clBtnFace
                    DataSource = dsMain
                    ReadOnly = True
                    TabOrder = 17
                  end
                end
                object Panel2: TPanel
                  Left = 0
                  Top = 560
                  Width = 503
                  Height = 31
                  Align = alBottom
                  BevelOuter = bvNone
                  Caption = 'Panel2'
                  TabOrder = 1
                  DesignSize = (
                    503
                    31)
                  object btAddParam: TBitBtn
                    Left = 5
                    Top = 4
                    Width = 71
                    Height = 25
                    Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1087#1072#1088#1072#1084#1077#1090#1088' '#1076#1083#1103' '#1088#1072#1089#1095#1077#1090#1072' '#1087#1086#1090#1077#1088#1100
                    Anchors = [akLeft, akBottom]
                    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
                    Font.Charset = RUSSIAN_CHARSET
                    Font.Color = clBlack
                    Font.Height = -12
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                    TabOrder = 0
                    OnClick = btAddParamClick
                  end
                  object btDelParam: TBitBtn
                    Left = 78
                    Top = 4
                    Width = 78
                    Height = 25
                    Hint = #1059#1076#1072#1083#1080#1090#1100' '#1087#1072#1088#1072#1084#1077#1090#1088' '#1076#1083#1103' '#1088#1072#1089#1095#1077#1090#1072' '#1087#1086#1090#1077#1088#1100
                    Anchors = [akLeft, akBottom]
                    Caption = #1059#1076#1072#1083#1080#1090#1100
                    Enabled = False
                    Font.Charset = RUSSIAN_CHARSET
                    Font.Color = clBlack
                    Font.Height = -12
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                    TabOrder = 1
                    OnClick = btDelParamClick
                  end
                  object btSetFormula: TBitBtn
                    Left = 157
                    Top = 4
                    Width = 153
                    Height = 25
                    Hint = #1054#1087#1088#1077#1076#1077#1083#1080#1090#1100' '#1089#1087#1086#1089#1086#1073' '#1085#1072#1095#1080#1089#1083#1077#1085#1080#1103' '#1088#1072#1089#1093#1086#1076#1072' '#1076#1083#1103' '#1088#1072#1089#1095#1077#1090#1072' '#1087#1086#1090#1077#1088#1100
                    Anchors = [akLeft, akBottom]
                    Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1088#1072#1089#1095#1105#1090#1072' '#1087#1086#1090#1077#1088#1100
                    Enabled = False
                    Font.Charset = RUSSIAN_CHARSET
                    Font.Color = clBlack
                    Font.Height = -12
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                    TabOrder = 2
                    OnClick = btSetFormulaClick
                  end
                  object btSetTimeP: TBitBtn
                    Left = 313
                    Top = 4
                    Width = 87
                    Height = 25
                    Hint = #1047#1072#1076#1072#1090#1100' '#1074#1088#1077#1084#1103
                    Anchors = [akLeft, akBottom]
                    Caption = #1047#1072#1076#1072#1090#1100' '#1074#1088#1077#1084#1103
                    Enabled = False
                    Font.Charset = RUSSIAN_CHARSET
                    Font.Color = clBlack
                    Font.Height = -12
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                    TabOrder = 3
                    OnClick = btSetTimePClick
                  end
                end
              end
            end
          end
        end
      end
    end
    object tbTools: TToolBar
      Left = 0
      Top = 677
      Width = 515
      Height = 27
      Align = alBottom
      ButtonHeight = 23
      Caption = 'tbTools'
      Flat = True
      Images = ilMenu
      TabOrder = 1
      object tbNew: TToolButton
        Left = 0
        Top = 0
        Hint = #1057#1086#1079#1076#1072#1090#1100' '#1085#1086#1074#1091#1102' '#1090#1086#1095#1082#1091' ('#1089#1095#1077#1090#1095#1080#1082')'
        Caption = #1057#1086#1079#1076#1072#1090#1100' '#1090#1086#1095#1082#1091
        ImageIndex = 20
        OnClick = tbNewClick
      end
      object tbNewGroup: TToolButton
        Left = 23
        Top = 0
        Action = aInsGroup
      end
      object tbDel: TToolButton
        Left = 46
        Top = 0
        Action = iaDelete
      end
      object ToolButton5: TToolButton
        Left = 69
        Top = 0
        Width = 7
        Caption = 'ToolButton5'
        ImageIndex = 80
        Style = tbsSeparator
      end
      object tbMetEdit: TToolButton
        Left = 76
        Top = 0
        Action = aEdit
      end
      object ToolButton3: TToolButton
        Left = 99
        Top = 0
        Action = acSampleHours
      end
      object ToolButton4: TToolButton
        Left = 122
        Top = 0
        Hint = #1044#1086#1082#1091#1084#1077#1085#1090#1072#1094#1080#1103' '#1087#1086' '#1090#1086#1095#1082#1077' '#1091#1095#1105#1090#1072
        Action = acMeterParameter
        Caption = #1044#1086#1082#1091#1084#1077#1085#1090#1072#1094#1080#1103' '#1087#1086' '#1090#1086#1095#1082#1077' '#1091#1095#1105#1090#1072
      end
      object tbGuid: TToolButton
        Left = 145
        Top = 0
        Hint = 'mRID'#1099'  '#1086#1073#1098#1077#1082#1090#1072
        Action = aGuid
        ImageIndex = 86
      end
      object tbSpezParam: TToolButton
        Left = 168
        Top = 0
        Hint = #1057#1087#1077#1094#1080#1072#1083#1100#1085#1099#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1099
        Action = aSpezPar
        Caption = #1057#1087#1077#1094#1080#1072#1083#1100#1085#1099#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1099
        ImageIndex = 87
      end
      object tbLimit2: TToolButton
        Left = 191
        Top = 0
        Hint = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1075#1088#1072#1085#1080#1094
        Action = aBorder2Par
        Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1075#1088#1072#1085#1080#1094
        ImageIndex = 88
      end
      object tbURD: TToolButton
        Left = 214
        Top = 0
        Hint = #1050#1086#1076#1099' '#1086#1073#1098#1077#1082#1090#1086#1074' '#1080' '#1082#1086#1076#1099' '#1082#1072#1085#1072#1083#1086#1074
        Action = aURD
        ImageIndex = 91
      end
      object tbKoeff: TToolButton
        Left = 237
        Top = 0
        Hint = #1047#1072#1076#1072#1085#1080#1077' '#1088#1072#1089#1095#1077#1090#1085#1086#1075#1086' '#1082#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090#1072
        Caption = 'tbKoeff'
        Enabled = False
        ImageIndex = 89
        OnClick = tbKoeffClick
      end
      object tbPrior: TToolButton
        Left = 260
        Top = 0
        Hint = #1047#1072#1076#1072#1085#1080#1077' '#1087#1088#1080#1086#1088#1080#1090#1077#1088#1072' '#1090#1086#1095#1082#1080
        Caption = 'tbPrior'
        Enabled = False
        ImageIndex = 90
        OnClick = tbPriorClick
      end
      object ToolButton2: TToolButton
        Left = 283
        Top = 0
        Width = 7
        Caption = 'ToolButton2'
        ImageIndex = 80
        Style = tbsSeparator
      end
      object btChannels: TToolButton
        Left = 290
        Top = 0
        Action = aChannelList
      end
      object tbGroups: TToolButton
        Left = 313
        Top = 0
        Action = aGroupList
      end
      object tbMaket: TToolButton
        Left = 336
        Top = 0
        Action = aMaketList
      end
      object tbOccurr: TToolButton
        Left = 359
        Top = 0
        Action = aOccurr
        ImageIndex = 92
      end
      object tbclonFormul: TToolButton
        Left = 382
        Top = 0
        Hint = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1092#1086#1088#1084#1091#1083#1099
        Caption = 'tbclonFormul'
        ImageIndex = 94
        OnClick = tbclonFormulClick
      end
      object tbLastSave: TToolButton
        Left = 405
        Top = 0
        Action = aLastSave
      end
      object ToolButton8: TToolButton
        Left = 428
        Top = 0
        Width = 7
        Caption = 'ToolButton8'
        ImageIndex = 7
        Style = tbsSeparator
      end
      object tbRclcData: TToolButton
        Left = 435
        Top = 0
        Action = aRclcData
      end
      object tbDelData: TToolButton
        Left = 458
        Top = 0
        Action = aDelData
      end
      object ToolButton1: TToolButton
        Left = 481
        Top = 0
        Width = 5
        Caption = 'ToolButton1'
        ImageIndex = 84
        Style = tbsSeparator
      end
      object tbFind: TToolButton
        Left = 486
        Top = 0
        Action = iaFind
      end
    end
  end
  inherited MenuSAA: TMainMenu
    Left = 50
    Top = 52
  end
  inherited PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 83
    Top = 52
    inherited miManualInp: TMenuItem
      Enabled = True
      Visible = True
      OnClick = miManualInpClick
    end
    inherited mMon: TMenuItem
      Enabled = True
      Visible = True
      OnClick = MonSelectClick
    end
    inherited mnOFF: TMenuItem
      OnClick = mnONOFFClick
    end
    inherited mnON: TMenuItem
      OnClick = mnONOFFClick
    end
    inherited mnONCancel: TMenuItem
      OnClick = mnONOFFClick
    end
    inherited mAdd: TMenuItem
      Action = nil
      Caption = #1057#1086#1079#1076#1072#1090#1100' '#1090#1086#1095#1082#1091
      Enabled = True
      Hint = #1057#1086#1079#1076#1072#1090#1100' '#1085#1086#1074#1091#1102' '#1090#1086#1095#1082#1091
      ShortCut = 0
      Visible = True
      object N7: TMenuItem
        Action = iaNew
        Caption = #1057#1086#1079#1076#1072#1090#1100' '#1090#1086#1095#1082#1091'('#1089#1095#1077#1090#1095#1080#1082')'
      end
      object N8: TMenuItem
        Action = iaNewCalcNode
        Caption = #1057#1086#1079#1076#1072#1090#1100' '#1086#1073#1086#1073#1097#1077#1085#1085#1091#1102' '#1090#1086#1095#1082#1091' '#1091#1095#1077#1090#1072
      end
    end
  end
  inherited alDefault: TActionList
    Left = 114
    Top = 52
    inherited iaNew: TAction
      Caption = #1057#1086#1079#1076#1072#1090#1100' '#1090#1086#1095#1082#1091
      Enabled = True
      Hint = #1057#1086#1079#1076#1072#1090#1100' '#1085#1086#1074#1091#1102' '#1090#1086#1095#1082#1091
      Visible = True
    end
    inherited iaDelete: TAction
      Enabled = True
      Visible = True
    end
    object aIntellect: TAction [18]
      Caption = '&'#1048#1085#1090#1077#1083#1077#1082#1090#1091#1072#1083#1100#1085#1099#1081
      ShortCut = 32834
      OnExecute = aCbExecute
    end
    object aQuadr: TAction [19]
      Caption = '&'#1050#1074#1072#1076#1088#1072#1085#1090#1099
      ShortCut = 32850
      OnExecute = aCbExecute
    end
    object aEarthing: TAction [20]
      Caption = '&'#1047#1072#1079#1077#1084#1083#1077#1085#1085#1072#1103' '#1085#1077#1081#1090#1088#1072#1083#1100
      ShortCut = 32848
      OnExecute = aCbExecute
    end
    object aBypasser: TAction [21]
      Caption = '&'#1054#1073#1074#1086#1076#1085#1080#1082
      ShortCut = 32842
      OnExecute = aCbExecute
    end
    object aCheckBill: TAction [22]
      Caption = #1042#1077#1088#1080#1092#1080#1082#1072#1094#1080#1103' &'#1089#1091#1090#1086#1095#1085#1099#1093
      ShortCut = 32835
      OnExecute = aCbExecute
    end
    object aCheckMonth: TAction [23]
      Caption = #1042#1077#1088#1080#1092#1080#1082#1072#1094#1080#1103' &'#1084#1077#1089#1103#1095#1085#1099#1093
      ShortCut = 32854
      OnExecute = aCbExecute
    end
    object aInverted: TAction [24]
      Caption = #1048#1085#1074#1077#1088#1089#1080#1103' &'#1085#1072#1087#1088#1072#1074#1083#1077#1085#1080#1103
      ShortCut = 32857
      OnExecute = aCbExecute
    end
    inherited aMLeft: TAction
      Tag = 1
      OnExecute = aMExecute
    end
    inherited aMRigth: TAction
      Tag = 2
      OnExecute = aMExecute
    end
    inherited aMUp: TAction
      Tag = 3
      OnExecute = aMExecute
    end
    inherited aMDown: TAction
      Tag = 4
      OnExecute = aMExecute
    end
    inherited iaMon: TAction
      Enabled = True
      Hint = #1055#1088#1086#1089#1084#1086#1090#1088' '#1084#1086#1085#1080#1090#1086#1088#1072' '#1087#1086' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1081' '#1090#1086#1095#1082#1077
      OnExecute = iaMonExecute
    end
    object aDataAbsence: TAction
      Caption = #1057#1080'&'#1075#1085#1072#1083#1080#1079#1080#1088#1086#1074#1072#1090#1100' '#1086#1073' '#1086#1090#1089#1091#1090#1089#1090#1074#1080#1080' '#1076#1072#1085#1085#1099#1093
      ShortCut = 32853
      OnExecute = aCbExecute
    end
    object iaNewCalcNode: TAction
      Category = 'PopupMenu'
      Caption = #1057#1086#1079#1076#1072#1090#1100' '#1088#1072#1089#1095#1077#1090#1085#1091#1102' '#1090#1086#1095#1082#1091
      Hint = #1057#1086#1079#1076#1072#1090#1100' '#1085#1086#1074#1091#1102' '#1086#1073#1086#1073#1097#1077#1085#1085#1091#1102' '#1090#1086#1095#1082#1091' '#1091#1095#1077#1090#1072
      ImageIndex = 20
      ShortCut = 32883
      OnExecute = iaNewCalcNodeExecute
    end
  end
  object ActionList1: TActionList [6]
    Images = ilMenu
    Left = 18
    Top = 86
    object aInsGroup: TAction
      Enabled = False
      Hint = #1042#1089#1090#1072#1074#1080#1090#1100' '#1075#1088#1091#1087#1087#1091
      ImageIndex = 0
      ShortCut = 8307
      OnExecute = btInsGroupClick
    end
    object aEdit: TAction
      Caption = 'C'#1095#1077#1090#1095#1080#1082#1080
      Enabled = False
      Hint = 'C'#1095#1077#1090#1095#1080#1082#1080
      ImageIndex = 80
      ShortCut = 16504
      OnExecute = btEditClick
    end
    object aChannelList: TAction
      Hint = #1055#1077#1088#1077#1095#1077#1085#1100' '#1082#1072#1085#1072#1083#1086#1074', '#1074#1077#1076#1091#1097#1080#1093' '#1086#1087#1088#1086#1089' '#1090#1086#1095#1082#1080
      ImageIndex = 82
      ShortCut = 16459
      OnExecute = btnAddListClick
    end
    object aGroupList: TAction
      Hint = #1055#1077#1088#1077#1095#1077#1085#1100' '#1075#1088#1091#1087#1087', '#1089#1086#1076#1077#1088#1078#1072#1097#1080#1093' '#1090#1086#1095#1082#1091
      ImageIndex = 81
      ShortCut = 16455
      OnExecute = btnAddListClick
    end
    object aLastSave: TAction
      Enabled = False
      Hint = #1057#1086#1089#1090#1086#1103#1085#1080#1077' '#1086#1087#1088#1086#1089#1072
      ImageIndex = 37
      ShortCut = 16463
      OnExecute = btnLastSaveClick
    end
    object aRclcData: TAction
      Hint = #1055#1077#1088#1077#1089#1095#1080#1090#1072#1090#1100' '#1076#1072#1085#1085#1099#1077
      ImageIndex = 84
      ShortCut = 8309
      OnExecute = aRclcDataExecute
    end
    object aDelData: TAction
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1076#1072#1085#1085#1099#1077
      ImageIndex = 83
      ShortCut = 8238
      OnExecute = aDelDataExecute
    end
    object acSampleHours: TAction
      Caption = #1054#1073#1088#1072#1079#1077#1094' '#1088#1072#1079#1085#1086#1089#1082#1080' '#1085#1072' '#1043#1053
      Enabled = False
      Hint = #1054#1073#1088#1072#1079#1077#1094' '#1088#1072#1079#1085#1086#1089#1082#1080' '#1085#1072' '#1043#1053
      ImageIndex = 52
      ShortCut = 16456
      OnExecute = acSampleHoursExecute
    end
    object aMaketList: TAction
      Hint = #1055#1077#1088#1077#1095#1077#1085#1100' '#1084#1072#1082#1077#1090#1086#1074', '#1089#1086#1076#1077#1088#1078#1072#1097#1080#1093' '#1090#1086#1095#1082#1091
      ImageIndex = 85
      ShortCut = 16461
      OnExecute = btnAddListClick
    end
    object acMeterParameter: TAction
      Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1080#1079#1072#1094#1080#1103' '#1089#1095#1077#1090#1095#1080#1082#1072
      Enabled = False
      Hint = #1055#1072#1088#1072#1084#1077#1090#1088#1080#1079#1072#1094#1080#1103' '#1089#1095#1077#1090#1095#1080#1082#1072
      ImageIndex = 72
      ShortCut = 16466
      OnExecute = acMeterParameterExecute
    end
    object aNodeUp: TAction
      Hint = #1055#1077#1088#1077#1084#1077#1089#1090#1080#1090#1100' '#1074#1074#1077#1088#1093
      ShortCut = 16422
      OnExecute = aNodeUpExecute
    end
    object aNodeDown: TAction
      ShortCut = 16424
      OnExecute = aNodeDownExecute
    end
    object aGuid: TAction
      Caption = 'aGuid'
      ShortCut = 16452
      OnExecute = aGuidExecute
    end
    object aSpezPar: TAction
      Caption = 'aSpezPar'
      OnExecute = aSpezParExecute
    end
    object aBorder2Par: TAction
      Caption = 'aBorder2Par'
      OnExecute = aBorder2ParExecute
    end
    object aURD: TAction
      Caption = 'aURD'
      OnExecute = aURDExecute
    end
    object aOccurr: TAction
      Caption = 'aOccurr'
      Enabled = False
      Hint = #1042#1093#1086#1078#1076#1077#1085#1080#1077' '#1090#1086#1095#1082#1080' '#1074' '#1092#1086#1088#1084#1091#1083#1099
      OnExecute = btnAddListClick
    end
  end
  object dsMain: TDataSource [7]
    Left = 5
    Top = 4
  end
  object pmUSDList: TPopupMenu [8]
    OwnerDraw = True
    Left = 50
    Top = 84
    object miCapUSDList: TMenuItem
      Caption = ' A+ |  A- |  R+ |  R- |    '#1058#1086#1095#1082#1072' '#1091#1095#1105#1090#1072' '
      Enabled = False
      OnDrawItem = miCapUSDListDrawItem
    end
    object miSepUSDList: TMenuItem
      Caption = '-'
    end
  end
  object pmDuplList: TPopupMenu [9]
    OwnerDraw = True
    Left = 83
    Top = 83
    object miCapDuplList: TMenuItem
      Caption = '   '#1055#1077#1088#1077#1095#1077#1085#1100' '#1076#1091#1073#1083#1080#1088#1091#1102#1097#1080#1093' '#1090#1086#1095#1077#1082
      Enabled = False
      OnDrawItem = miCapUSDListDrawItem
    end
    object miSepDuplList: TMenuItem
      Caption = '-'
    end
  end
  object pmAddNode: TPopupMenu [10]
    AutoPopup = False
    Left = 32
    Top = 160
    object N3: TMenuItem
      Action = iaNew
      Caption = #1057#1086#1079#1076#1072#1090#1100' '#1090#1086#1095#1082#1091' ('#1089#1095#1077#1090#1095#1080#1082')'
    end
    object N6: TMenuItem
      Action = iaNewCalcNode
      Caption = #1057#1086#1079#1076#1072#1090#1100' '#1086#1073#1086#1073#1097#1077#1085#1085#1091#1102' '#1090#1086#1095#1082#1091' '#1091#1095#1077#1090#1072
    end
  end
  object oqSaveLoss: TOraQuery [11]
    Session = dmMain.orases
    AutoCommit = False
    Options.ReturnParams = True
    Left = 122
    Top = 150
  end
  object oqSavePointTimeInfo: TOraQuery [12]
    Session = dmMain.orases
    SQL.Strings = (
      'begin ryda.loss_pg.settimep_p(:par1,:par2,:par3,:par4); end;')
    AutoCommit = False
    Options.ReturnParams = True
    Left = 194
    Top = 162
    ParamData = <
      item
        DataType = ftInteger
        Name = 'par1'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'par2'
        ParamType = ptInput
        Table = True
      end
      item
        DataType = ftFloat
        Name = 'par3'
        ParamType = ptInput
        Table = True
      end
      item
        DataType = ftFloat
        Name = 'par4'
        ParamType = ptInput
        Table = True
      end>
  end
  object oqSavePointCalcParam: TOraQuery [13]
    Session = dmMain.orases
    SQL.Strings = (
      
        'begin ryda.editfeeders_pg.setcalcparam_p(:par1,:par2,:par3,:par4' +
        ',:par5); end;')
    AutoCommit = False
    Options.ReturnParams = True
    Left = 130
    Top = 216
    ParamData = <
      item
        DataType = ftInteger
        Name = 'par1'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'par2'
        ParamType = ptInput
        Table = True
      end
      item
        DataType = ftFloat
        Name = 'par3'
        ParamType = ptInput
        Table = True
      end
      item
        DataType = ftFloat
        Name = 'par4'
        ParamType = ptInput
        Table = True
      end
      item
        DataType = ftFloat
        Name = 'par5'
        ParamType = ptInput
        Table = True
      end>
  end
  object pmOppositeList: TPopupMenu [14]
    OwnerDraw = True
    Left = 114
    Top = 82
    object N9: TMenuItem
      Caption = '  '#1055#1077#1088#1077#1095#1077#1085#1100' '#1087#1088#1086#1090#1080#1074#1086#1087#1086#1083#1086#1078#1085#1099#1093' '#1090#1086#1095#1077#1082
      OnDrawItem = miCapUSDListDrawItem
    end
    object N10: TMenuItem
      Caption = '-'
    end
  end
  inherited iImageList: TImageList
    Bitmap = {
      494C01011D002200040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000009000000001002000000000000090
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF000000FF00
      0000FF0000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF0000000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000000000000000000000000000000000000000FF000000FF0000000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      00000000000000000000000000000000FF00000000000000FF0000000000FF00
      0000FF000000FF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      000000000000000000000000FF0000000000000000000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF000000FF00
      0000FF0000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000FF000000FF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840084848400848484008484
      8400848484008484840084848400848484000000000000000000000000000000
      00000000000000000000000000000000000084848400848484000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF008400FF00840000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      000000000000000000000000000084848400000000000000FF000000FF000000
      00000000000000000000000000000000000084848400000000000000FF000000
      FF000000FF00000000000000000084848400000000000000FF000000FF000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF008400FF00840000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF000000FF000000
      FF000000FF00000000000000000000000000848484000000FF000000FF000000
      FF000000000000000000000000000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000084848400848484008484840084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF008400FF00840000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0000000000000000000000FF000000FF000000FF000000
      000000000000000000000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      000000000000C6C6C60000FF000000FF000000FF000000FF0000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FF008400FF008400FFFFFF00000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0000000000000000000000FF000000FF000000FF000000
      000000000000000000000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      0000C6C6C60000FF000000FF000000FF000000FF000000FF000000FF00008484
      8400000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FF008400FF008400FFFFFF00FFFFFF000000
      0000000000000000000000000000000000008484840000000000000000000000
      0000000000000000FF000000FF00C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C6000000FF000000FF00000000000000FF000000FF000000FF000000
      0000000000000000FF000000FF000000FF000000FF00C6C6C600C6C6C600C6C6
      C600C6C6C6000000FF000000FF000000FF000000000000000000000000000000
      0000C6C6C60000FF000000FF000000FF000000FF000000FF000000FF00008484
      8400000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FF008400FF008400FF008400FF008400FFFFFF000000
      0000000000000000000000000000000000008484840000000000000000000000
      0000000000000000FF000000FF00000000000000000000000000000000000000
      0000000000000000FF000000FF00000000000000FF000000FF000000FF000000
      0000000000000000FF000000FF000000FF000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000000000000000000000000000
      0000C6C6C60000FF00000000000000FF000000FF000000FF000000FF00008484
      8400000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FF008400FF008400FF008400FF008400FFFFFF000000
      0000000000000000000000000000000000008484840000000000000000000000
      0000000000000000FF000000FF00000000000000000000000000000000000000
      0000000000000000FF000000FF00000000000000FF000000FF000000FF000000
      0000000000000000FF000000FF000000FF000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000000000000000000000000000
      0000C6C6C60000FF0000000000000000000000FF000000FF000000FF00008484
      8400000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000FF008400FF008400FFFFFF00FFFFFF000000
      0000000000000000000000000000000000008484840000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0000000000000000000000FF000000FF000000FF000000
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      000000000000C6C6C60000FF000000FF000000FF000000FF0000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FF008400FF008400FFFFFF00000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000000000000000848484000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      00000000000000000000C6C6C600C6C6C600C6C6C600C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF008400FF00840000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF000000FF000000
      FF000000FF0000000000000000000000000084848400000000000000FF000000
      FF000000FF000000FF00000000000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF008400FF00840000000000FF008400FF00
      8400000000000000000000000000000000008484840000000000000000000000
      000000000000000000000000000084848400000000000000FF000000FF000000
      00000000000000000000000000000000000084848400000000000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF000000FF008400FF008400FF008400FF00
      8400000000000000000000000000000000008484840000000000000000000000
      0000000000000000000000000000848484000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF000000FF000000FF0000000000
      0000000000000000000000000000000000008484840084848400848484008484
      8400848484008484840084848400848484000000000000000000000000000000
      0000000000000000000000000000000000008484840084848400848484008484
      8400848484000000FF000000FF000000FF000000FF000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
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
      840084848400848484007B000000848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      000000000000000000000000000084848400000000000000FF000000FF000000
      0000000000000000000000000000000000008484840000000000000000000000
      0000000000007B00000000FF00007B0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF000000FF000000
      FF000000FF000000000000000000000000008484840000000000000000000000
      00007B00000000FF000000FF000000FF00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0000000000000000008484840000000000000000000000
      000000FF000000FF000000FF000000FF00007B00000000000000000000000084
      8400008484000084840000848400000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF0000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0000000000000000008484840000000000000000007B00
      000000FF000000FF000000FF000000FF00007B00000084848400848484000084
      840000FFFF0000FFFF0000848400000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      0000000000000000FF000000FF00C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C6000000FF000000FF000000000084848400000000007B00000000FF
      000000FF0000000000000000000000FF000000FF00007B000000000000000000
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
      00000000000000000000000000008484840000FF000000FF00007B0000000000
      0000FF000000FF00000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF000000FF000000FF000000FF000000FF00
      0000000000000000000000000000000000008484840000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0000000000000000008484840000000000000000000000
      0000000000000000000000000000848484000000000000FF000000FF00007B00
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
      00007B000000FF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      000000000000000000000000000084848400000000000000FF000000FF000000
      0000000000000000000000000000000000008484840000000000000000000000
      00000000000000000000000000008484840000000000000000000000000000FF
      00007B0000000000000000000000000000000000000000000000000000000000
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
      0000000000000000FF000000FF000000FF007B7B7B0000000000000000000000
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
      000000000000000000007B7B7B000000FF000000FF000000FF007B7B7B000000
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
      000000000000000000007B7B7B007B7B7B00000000000000FF000000FF000000
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
      0000000000007B7B7B000000FF000000FF000000FF000000FF000000FF007B7B
      7B00000000000000000000000000000000000000000000000000000000000000
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
      000000000000000000007B7B7B007B7B7B007B7B7B0000000000000000000000
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
      000000000000000000007B7B7B00000000007B7B7B007B7B7B007B7B7B000000
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
      000000000000000000007B7B7B007B7B7B00000000007B7B7B00000000000000
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
      0000000000007B7B7B00000000007B7B7B00000000007B7B7B00000000007B7B
      7B00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B00000000007B7B7B00000000007B7B7B00000000007B7B
      7B00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000900000000100010000000000800400000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFF000000000000FFFF000000000000
      FFEF000000000000FFEF000000000000FFEF000000000000FFC7000000000000
      FC2F000000000000EF2F000000000000EEA3000000000000EDBF000000000000
      C7FF000000000000EFFF000000000000EFFF000000000000E3FF000000000000
      FFFF000000000000FFFF000000000000FFFFF81FFFFFFFFFFFFFF00FFFFFFFFF
      00FF0003FFFFFE7F7E8F4683FFFFFE7F7E030E01FC3FFC3F7C011C00F81FF81F
      40010000F00FF00F78001800F00FF00F41F800F8F20FF00F79F818F8F30FF20F
      40010000F81FF81F7C010001FC3FFC3F42034203FFFFFE4F7E8F4003FFFFFE0F
      7EFF600FFFFFFF1F00FF001FFFFFFFFF003FE7FFFC1FFC1F001FE7FFF007F007
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
  inherited ilMenu: TImageList
    Left = 18
    Top = 52
    Bitmap = {
      494C01015F006300040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000009001000001002000000000000090
      0100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF008400FF00
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF008400FF00840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF008400FF00
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF008400FF00840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF008400FF00
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF008400FF00840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF008400FF008400FF00
      8400FF0084000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FF008400FF008400FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF000000FF00
      0000FF0000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF008400FF008400FF00
      8400FF0084000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FF008400FF008400FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF0000000000FF00
      00000000000000000000000000000000000000000000FF008400FF0084000000
      0000000000000000000000000000000000000000000000000000FF008400FF00
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FF008400FF008400FF008400FF008400FFFFFF000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000000000000000000000000000000000000000FF000000FF0000000000FF00
      00000000000000000000000000000000000000000000FF008400FF0084000000
      000000000000FF008400FF008400FF008400FF00840000000000FF008400FF00
      840000000000FF008400FF008400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FF008400FF008400FF008400FF008400FFFFFF000000
      000000000000000000000000000000000000000000000000000000000000FF00
      00000000000000000000000000000000FF00000000000000FF0000000000FF00
      0000FF000000FF000000000000000000000000000000FF008400FF0084000000
      00000000000000000000FF008400FF008400FF00840000000000FF008400FF00
      8400FF008400FF008400FF008400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000FF008400FF008400FFFFFF00FFFFFF000000
      000000000000000000000000000000000000000000000000000000000000FF00
      000000000000000000000000FF0000000000000000000000FF00000000000000
      000000000000000000000000000000000000FF008400FF008400FF008400FF00
      840000000000FF008400FF008400FF008400FF0084000000000000000000FF00
      8400FF008400FF00840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FF008400FF008400FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000FF000000FF00
      0000FF0000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF008400FF008400FF008400FF00
      840000000000FF008400FF00840000000000FF00840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF008400FF00840000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF008400FF0084000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF008400FF00840000000000FF008400FF00
      840000000000000000000000000000000000000000000000000000000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF008400FF0084000000
      0000FF008400FF00840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF000000FF008400FF008400FF008400FF00
      840000000000000000000000000000000000000000000000000000000000FF00
      0000FF000000FF00000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF008400FF008400FF00
      8400FF008400FF00840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF000000FF000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF008400FF00
      8400FF0084000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00008484000084
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6218400C6218400C621
      8400C6218400C6218400C6218400C6218400C6C6C6000000000000000000C621
      8400C6C6C6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000008484000000
      0000848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6218400C6218400C621
      8400C6218400C6C6C600C6C6C600C6218400C6C6C60000000000C6218400C621
      8400C6218400C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000008484000000
      0000848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084000000840000000000
      0000000000008400000084000000000000000000000000000000C6218400C621
      8400C6218400C6C6C600C6218400C6C6C60000000000C6218400C6218400C621
      8400C6218400C6218400C6C6C6000000000000000000FF000000FF0000000000
      000000000000FF000000000000000000000000000000FF000000000000000000
      00000000000000000000FF000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000008484000000
      0000848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084000000840000000000
      0000000000008400000084000000000000000000000000000000C6218400C621
      8400C6218400C6218400C6218400C6C6C60000000000C6218400C6218400C621
      8400C6C6C600C6218400C6C6C60000000000FF0000000000000000000000FF00
      000000000000FF000000000000000000000000000000FF000000FF000000FF00
      0000FF000000FF000000FF000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000008484000000
      0000848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084000000840000000000
      000084000000840000000000000000000000000000000000000000000000C621
      8400C6218400C6218400C6C6C60000000000C6218400C6218400C6218400C621
      8400C6C6C600C6C6C600C6218400C6C6C600000000000000000000000000FF00
      000000000000FF00000000000000000000000000000000000000FF0000000000
      000000000000FF00000000000000000000000000000000000000000000000000
      0000000000008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084000000840000008400
      0000840000008400000000000000000000000000000000000000000000000000
      0000C6218400C6C6C6000000000000000000C6218400C6218400C6218400C621
      8400C6218400C6218400C6218400C6C6C60000000000FF000000FF000000FF00
      000000000000FF000000FF000000FF0000000000000084848400FF0000008484
      840084848400FF00000084848400000000000000000000000000000000000000
      0000000000000000000084848400848484000000000000000000000000000000
      00000000000000000000C6DEC600848484000000000000000000000000000000
      0000000000000000000000000000000000000000000084000000840000008400
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF0000000000000000000000FF00
      000000000000FF0000000000000000000000FF00000000000000FF0000000000
      000000000000FF00000000000000000000008400000084000000840000008400
      00008400000084000000C6C6C600000000008484840000000000C6DEC600C6DE
      C600C6DEC600C6DEC600C6DEC600848484000000000000000000000000000000
      0000000000000000000000000000000000000000000084000000840000008400
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF0000000000000000000000FF00
      000000000000FF0000000000000000000000FF00000000000000FF0000000000
      000000000000FF00000000000000000000008400000084000000000000000000
      000000000000840000008400000084848400C6DEC600FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000C6C6C600848484000000000000000000000000000000
      0000000000000000000000000000000000000000000084000000840000000000
      0000840000008400000000000000000000008400000084000000840000008400
      0000000000000000000000000000000000000000000000000000000000008400
      0000840000008400000084000000C6DEC600FF0000008484840084848400FF00
      000000000000FF0000000000000000000000FF0000000000000000000000FF00
      000000000000FF00000000000000000000008400000084000000000000000000
      0000000000008400000084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000840000008400
      0000000000008400000084000000000000000000000084000000840000000000
      000000000000840000008400000000000000000000000000000084000000C6DE
      C600000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084000000FF0000008484840000000000FF00
      000000000000FF000000FF000000FF000000000000008484840084848400FF00
      0000FF000000FF00000084848400000000008400000084000000000000000000
      0000000000008400000084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000000000000000000000000000000000000084000000840000000000
      000000000000000000000000000000000000000000000000000084000000C6DE
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000840000000000000084848400848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008400000084000000840000008400
      0000840000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000840000008400
      0000840000008400000084000000000000000000000084000000840000000000
      000000000000000000000000000000000000000000000000000084000000C6DE
      C600000000000000000000000000000000000000000084000000C6DEC6000000
      00000000000000000000C6DEC600840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008400000084000000000000000000
      0000000000008400000084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000000000000000000000000000000000000084000000840000000000
      000000000000000000000000000000000000000000000000000084000000C6DE
      C60000000000840000008400000084000000840000008400000084000000C6DE
      C600840000008400000084000000C6DEC6000000000084848400848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008400000084000000000000000000
      0000000000008400000084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000840000000000000084000000C6DE
      C600000000000000000000000000000000000000000084000000C6DEC6000000
      00000000000084000000C6DEC600C6DEC6000000000084848400000000008484
      8400000000008484840084848400848484008484840084848400848484008484
      8400848484008484840084848400000000008400000084000000000000000000
      0000000000008400000084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008400000084000000C6DE
      C600000000000000000000000000000000000000000000000000000000000000
      000000000000C6DEC60084000000C6DEC6000000000084848400848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008400000084000000840000008400
      0000840000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084000000C6DE
      C600000000000000000000000000000000000000000000000000000000008400
      0000840000008400000084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00008484000084
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008400000000FF0000840000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000008484000000
      0000848484000000000000000000000000008484840084848400848484008484
      84008484840084848400848484008400000000FF000000FF000000FF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000008484000000
      0000848484000000000000000000000000008484840000000000000000000000
      000000000000000000000000000000FF000000FF000000FF000000FF00008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000008484000000
      0000848484000000000000000000000000008484840000000000000000000000
      000000000000000000008400000000FF000000FF000000FF000000FF00008400
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      000000000000000000000000000000000000FF00000000000000FF0000000000
      0000FF00000000000000FF000000FF00000000000000FF00000000000000FF00
      000000000000FF000000FF000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000008484000000
      0000848484000000000000000000000000008484840000000000000000000000
      0000000000008400000000FF000000FF0000000000000000000000FF000000FF
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400848484008484840000000000000000000000
      000000000000000000000000000000000000FF00000000000000FF0000000000
      0000FF00000000000000FF000000FF00000000000000FF00000000000000FF00
      000000000000FF000000FF000000FF0000000000000000000000000000000000
      0000000000008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      00000000000000FF000000FF00008484840000000000000000000000000000FF
      000000FF00000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      000000000000000000000000000000000000FF00000000000000FF0000000000
      0000FF00000000000000FF000000FF00000000000000FF00000000000000FF00
      000000000000FF00000000000000FF0000000000000000000000000000000000
      0000000000000000000084848400848484000000000000000000000000000000
      00000000000000000000C6DEC600848484008484840000000000000000000000
      0000000000000000000000FF00008484840000000000000000000000000000FF
      000000FF00008400000000000000000000000000000000000000000000000000
      0000000000000000000084848400000000008484840084848400848484000000
      000000000000000000000000000000000000FF00000000000000FF0000000000
      0000FF00000000000000FF000000FF000000FF0000000000000000000000FF00
      000000000000FF00000000000000FF0000000000000084000000840000008400
      00008400000000000000C6C6C600000000008484840000000000C6DEC600C6DE
      C600C6DEC600C6DEC600C6DEC600848484008484840000000000000000000000
      0000000000000000000000000000848484000000000000000000000000000000
      000000FF000000FF000084000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      000000000000000000000000000000000000FF00000000000000FF0000000000
      0000FF00000000000000FF000000FF00000000000000FF00000000000000FF00
      000000000000FF00000000000000FF0000008400000084000000000000000000
      000000000000840000008400000084848400C6DEC600FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000C6C6C600848484008484840000000000000000000000
      0000000000000000000000000000848484000000000000000000000000000000
      00000000000000FF000000FF0000000000000000000000000000000000000000
      0000000000000000000084848400848484000000000084848400000000000000
      000000000000000000000000000000000000FF000000FF00000000000000FF00
      00000000000000000000FF000000FF00000000000000FF00000000000000FF00
      000000000000FF00000000000000FF0000000000000000000000000000000000
      0000000000008400000084000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      0000000000000000000000000000848484000000000000000000000000000000
      00000000000000FF000000FF0000840000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF00000000000000FF00000000000000FF00
      000000000000FF00000000000000FF0000000000000000000000000000008400
      0000840000008400000084000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      0000000000000000000000000000848484000000000000000000000000000000
      0000000000000000000000FF0000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF00000000000000FF000000000000000000
      000000000000FF000000FF000000FF0000000000000084000000840000008400
      0000840000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      0000000000000000000000000000848484000000000000000000000000000000
      000000000000000000000000000000FF00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF000000FF0000000000000000000000FF00
      000000000000FF000000FF000000000000008400000084000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      0000000000000000000000000000848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840000000000848484000000000084848400000000008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008400000084000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      0000000000000000000000000000848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840000000000848484000000000084848400000000008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008400000084000000000000000000
      0000000000008400000084000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840084848400848484008484
      8400848484008484840084848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
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
      0000000000000000000000000000848484000000000000000000000000000000
      00000000000000000000C6C6C600848484000000000000000000000000000000
      000084848400A56B390084848400848484008484840084848400848484008484
      8400C6C6C6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C6000000FF00000084008484840000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C600CED6D600A56B3900A56B3900C6C6C600A56B3900A56B3900848484008484
      840084848400C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000084848400848484008484
      840084848400848484000000FF000000FF000000840000000000000000000000
      000000000000000000000000FF0000000000000000000000000000000000C6C6
      C600CED6D600C6C6C600C6C6C600C6C6C600A56B3900C6C6C600A56B3900A56B
      390084848400C6C6C60000000000000000000000000000000000FF000000FF00
      0000000000000000000000000000FF000000FF00000000000000000000000000
      0000FF000000FF00000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000084848400000000000000
      00000000000000000000000000000000FF000000FF0000008400000000000000
      0000000084000000FF000000000000000000000000000000000000000000C6C6
      C600CED6D600A56B3900A56B3900C6DEC600A56B3900C6DEC600C6C6C600C6C6
      C60084848400C6C6C600000000000000000000000000FF000000FF000000FF00
      0000FF00000000000000FF000000FF000000FF000000FF00000000000000FF00
      0000FF000000FF000000FF000000000000000000000000000000000000000000
      000000000000FF000000FF000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000084848400000000000000
      0000000000000000000000000000000000000000FF000000FF00000000000000
      00000000FF00C6C6C6000000000000000000000000000000000000000000C6C6
      C600CED6D600C6C6C600CED6D60084848400C6C6C600C6C6C600A56B3900C6C6
      C60084848400C6C6C600000000000000000000000000FF00000000000000FF00
      0000FF00000000000000FF00000000000000FF000000FF00000000000000FF00
      000000000000FF000000FF000000000000000000000000000000000000000000
      000000000000FF000000FF000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000084848400000000000000
      000000000000000000000000000000000000848484000000FF000000FF000000
      FF00C6C6C600000000000000000000000000000000000000000000000000C6C6
      C600CED6D600C6C6C600C6C6C600C6C6C600FFFFFF00C6C6C600C6C6C600C6C6
      C60084848400C6C6C60000000000000000000000000000000000FF000000FF00
      0000000000000000000000000000FF000000FF00000000000000000000000000
      0000FF000000FF00000000000000000000000000000000000000000000000000
      000000000000FF000000FF000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000084848400000000000000
      00000000000000000000000000000000000084848400000084000000FF000000
      FF0000008400000000000000000000000000000000000000000000000000C6C6
      C600CED6D600A56B3900A56B3900CED6D600A56B3900CED6D600C6C6C600C6DE
      C60084848400C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF000000FF000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000084848400000000000000
      00000000000000000000C6C6C600000000000000FF000000FF00C6C6C600C6C6
      C6000000FF00000000000000000000000000000000000000000000000000C6C6
      C600CED6D600C6C6C600F7FFFF0084848400CED6D600C6C6C600008484008484
      840084848400C6C6C60000000000000000000000000084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840084848400000000000000000000000000000000000000
      000000000000FF000000FF000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000084848400000000000000
      000000000000C6C6C600000084000000FF000000FF00C6C6C600000000000000
      0000C6C6C6000000FF000000000000000000000000000000000000000000C6C6
      C600CED6D600CED6D600C6C6C600CED6D600C6C6C600C6C6C600C6C6C600C6C6
      C60084848400C6C6C60000000000000000008484840084848400C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C60084848400848484000000000000000000000000000000
      000000000000FF000000FF000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000084848400000000000000
      000000000000000000000000FF000000FF00C6C6C60000000000000000000000
      000000000000C6C6C6000000FF0084848400000000000000000000000000C6C6
      C600CED6D600C6C6C600C6C6C600C6C6C600CED6D600CED6D600CED6D600CED6
      D60084848400C6C6C600000000000000000084848400C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C6000000000000000000C6C6C600848484000000000000000000000000000000
      000000000000FF000000FF000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000084848400000000000000
      0000000000000000000000000000C6C6C6008484840000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C60084848400C6C6C60000000000000000008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C600C6C6C600848484000000000000000000000000000000
      000000000000FF000000FF000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000084848400000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C600CED6D600C6C6C600A56B3900A56B3900A56B3900A56B3900A56B3900A56B
      390084848400C6C6C60000000000000000008484840084848400C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C60084848400848484000000000000000000000000000000
      00000000000000000000FF000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000084848400000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6DEC600CED6
      D60084848400C6C6C60000000000000000000000000084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840084848400000000000000000000000000000000000000
      0000000000000000000000000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000084848400000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6DEC600C6DEC600FFFF
      FF00C6C6C6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400848484008484
      8400848484008484840084848400848484008484840000000000000000000000
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
      000000000000000000000000000000000000000000008484840000000000CED6
      D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600000000000000000000000000000000008484840000000000008484000084
      840000848400008484000084840000848400008484000084840000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008484840000000000CED6
      D600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00C6C6C6000000000000000000000000008484840000000000008484000084
      840000848400008484000084840000848400008484000084840000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C60000000000000000000000000000000000000000008484840000000000CED6
      D600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CED6
      D60000000000FFFFFF00FFFFFF00000000008484840000000000008484000084
      840000848400008484000084840000848400008484000084840000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400CED6D600CED6D600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008484
      840000000000FFFFFF00FFFFFF0000000000848484000000000000FFFF000084
      840000848400008484000084840000848400008484000084840000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000000000000000C6C6
      C60000000000000000000000000000000000000000000000000000000000C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400000000008484
      84000000000084848400CED6D600CED6D600FFFFFF00FFFFFF00CED6D6000000
      000000000000000000000000000000000000848484000000000000FFFF000084
      8400008484000084840000848400008484000084840000848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840000000000000000000000000084848400000000000000
      00000000000000000000000000000000000000000000C6C6C600848484000000
      00000000000000000000000000000000000000000000C6C6C600000000000000
      000000000000000000000000000000000000000000008484840000000000CED6
      D600F7FFFF00848484000000000084848400CED6D600CED6D600848484000000
      0000F7FFFF00000000000000000000000000848484000000000000FFFF000084
      8400008484000084840000848400008484000084840000848400008484000084
      8400008484000084840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600848484000000
      00000000000000000000C6C6C6000000000000000000C6C6C600000000000000
      000000000000000000000000000000000000000000008484840000000000CED6
      D600FFFFFF00FFFFFF00F7FFFF0000000000000000000000000000000000F7FF
      FF00FFFFFF00000000000000000000000000848484000000000000FFFF000084
      8400008484000084840000848400008484000084840000848400008484000084
      840000848400008484000000000000000000000000000000000000000000C6C6
      C60000000000000000000000000000000000C6C6C60000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600848484000000
      00000000000000000000C6C6C6000000000000000000C6C6C600000000000000
      000000000000000000000000000000000000000000008484840000000000CED6
      D600F7FFFF00848484000000000084848400F7FFFF00F7FFFF00848484000000
      000000000000000000000000000000000000848484000000000000FFFF000084
      8400008484000084840000848400008484000084840000848400008484000084
      840000848400008484000000000000000000000000000000000000000000C6C6
      C60000000000000000000000000000000000C6C6C60000000000000000000000
      0000000000000000000000000000000000000000000000000000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400000000008484
      84000000000084848400CED6D600F7FFFF00FFFFFF00FFFFFF00F7FFFF008484
      840000000000FFFFFF00FFFFFF00000000008484840000000000008484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000084840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C6008484840000000000000000000000000000000000C6C6C600848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000CED6D600F7FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CED6
      D60000000000FFFFFF00FFFFFF00000000008484840000000000008484000000
      0000F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FF
      FF00000000000084840000000000000000000000000000000000000000000000
      0000000000000000000000000000848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008484840000000000CED6
      D600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CED6D600CED6
      D600C6C6C6000000000000000000000000000000000084848400000000000000
      0000F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00CED6
      D600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400000000000000000000000000000000000000000084848400000000000000
      000000000000000000000000000000000000000000008484840000000000CED6
      D600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CED6D6000000
      0000000000000000000000000000000000000000000000000000848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400000000000000000000000000000000000000000084848400000000000000
      000000000000000000000000000000000000000000008484840000000000CED6
      D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D6000000
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C6C6C6008484840084848400848484008484
      840084848400C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000848400CED6D600CED6
      D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600008484000000000000000000000000000000000000848400CED6D600CED6
      D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600008484000000000000000000000000000000000000000000000000000000
      00000000000000000000C6C6C600C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CED6D600CED6D600FFFF
      FF00FFFFFF00CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D60000000000000000000000000000000000CED6D600CED6D600FFFF
      FF00FFFFFF00CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D6000000000000000000000000000000000000000000000000000000
      00000000000000000000C6C6C60000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C6000000
      00000000000000000000000000000000000000000000CED6D600FFFFFF00CED6
      D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D60000000000000000000000000000000000CED6D600FFFFFF00CED6
      D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D6000000000000000000000000000000000000000000000000000000
      00000000000000000000C6C6C60000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      00000000000000000000C6C6C6008484840000000000FFFFFF00FFFFFF000000
      00000000000000000000000000000000000000000000CED6D600FFFFFF00CED6
      D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D60000000000000000000000000000000000CED6D600FFFFFF00CED6
      D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D6000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C6000000000084848400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      000000000000C6C6C600CED6D6000000000000000000FFFFFF00FFFFFF000000
      00000000000000000000000000000000000000000000CED6D600FFFFFF00CED6
      D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D6000000000000000000000000000000000000000000000000000000
      00000000000000000000CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D60000000000000000000000000000000000C6C6C600C6C6C6000000
      0000000000000000000000000000000000000000000084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000000000000000000000000000000000000C6C6
      C600CED6D600CED6D60000FFFF00000000000000000000000000FFFFFF000000
      00000000000000000000000000000000000000000000CED6D600FFFFFF00CED6
      D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D6000000000000000000000000000000000084848400848484008484
      84008484840000000000CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D60000000000000000000000000000000000C6C6C60000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000084848400FFFF
      FF00FFFFFF00FFFFFF000000000000000000000000000000000000000000F7FF
      FF0000FFFF0000FFFF0000FFFF00000000000000000084848400FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CED6D600CED6D600CED6D600CED6
      D600CED6D6000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000CED6
      D600CED6D60000000000000000000000000000000000C6C6C60000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000084848400FFFF
      FF00FFFFFF00FFFFFF000000000000000000000000000000000000000000F7FF
      FF00FFFFFF0000FFFF0000FFFF00000000000000000084848400FFFFFF000000
      0000000000000000000000000000000000000000000084848400848484008484
      840084848400848484008484840000000000CED6D600CED6D600CED6D600CED6
      D6000084840000000000000000000000000000000000CED6D600CED6D6000000
      000084848400848484008484840084848400848484008484840000000000CED6
      D6000084840000000000000000000000000000000000C6C6C60000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000084848400FFFF
      FF0000000000000000000000000000000000000000000000000000000000C6C6
      C600F7FFFF00FFFFFF0000FFFF00000000000000000000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C60000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000084848400FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C600F7FFFF000000000000000000FFFFFF00FFFFFF000000
      00000000000000000000000000000000000000000000CED6D600CED6D600CED6
      D600CED6D600CED6D600CED6D600000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF000000
      0000CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600000000000000
      00000000000000000000000000000000000000000000C6C6C60000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C6C6C6008484840000000000FFFFFF00FFFFFF000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      00000000000000000000000000000000000000000000C6C6C60000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C6000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      00000000000000000000000000000000000000000000C6C6C60000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C60000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
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
      000000000000000000000000000000000000000000000000000000008400CED6
      D6000000FF000000FF000000FF00000000008484840084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8400CED6D6000000FF000000FF000000FF000000000084848400848484000000
      0000000000000000000000000000000000000000000084848400CED6D600CED6
      D600CED6D600C6C6C600C6C6C600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D600CED6D600CED6D600000000000000000000000000000000000000
      0000F7FFFF00CED6D600CED6D600CED6D600CED6D600CED6D600848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000008400CED6D600CED6D6000000FF000000FF0000000000848484008484
      8400000000000000000000000000000000000000000084848400CED6D600CED6
      D600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600000000000000000000000000000000000000
      0000C6C6C600C6C6C600CED6D600CED6D600CED6D600C6C6C600848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000008400CED6D600848484000000000000000000000000008484
      8400848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400848484008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C6C6C6000000000000000000C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF000000FF00000000840000000000F7FFFF0000000000000000000000
      0000848484000000000000000000000000000000000084848400FFFFFF00CED6
      D600000000000000000000000000000000000000000000000000000000000000
      00008484840084848400C6C6C6000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C6008484840000000000000000000000000000000000C6C6C6000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF0000FFFFFF00FFFFFF00000084000000000000000000000000000000
      0000000000008484840000000000000000000000000084848400CED6D6000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084848400C6C6C6000000000000000000CED6D600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000CED6D600848484000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF0000FFFFFF00008400000084000000000000F7FFFF00F7FFFF000000
      0000000000008484840000000000000000000000000000000000000000000000
      0000000000008484840084848400848484008484840084848400848484000000
      00000000000000000000000000000000000000000000CED6D60000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000CED6D60084848400000000000000000000000000C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C6000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF0000FFFFFF000084000000FF00000000000000000000848484008484
      8400000000000000000000000000000000000000000084848400000000000000
      000000000000F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF000000
      00000000000000000000848484000000000000000000CED6D60000000000FFFF
      FF00FFFFFF0084000000840000008400000084000000FFFFFF00FFFFFF000000
      0000CED6D6008484840000000000000000000000000084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF0000FFFFFF000084000000FF00000084000000000000000000000000
      0000000000000000000084848400000000000000000000000000000000000000
      000000000000CED6D600A56B3900A56B3900FFFFFF00A56B3900A56B39000000
      00000000000000000000000000000000000000000000CED6D60000000000FFFF
      FF00FFFFFF0084000000FF000000FF00000084000000FFFFFF00FFFFFF000000
      0000CED6D6008484840000000000000000000000000084848400FFFFFF00FFFF
      FF0000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF0000FFFFFF000084000000FF000000FF000000840000000000000000
      0000000000000000000084848400000000000000000000000000000000000000
      000000000000CED6D600A56B3900A56B3900FFFFFF00A56B3900A56B39000000
      00000000000000000000000000000000000000000000CED6D60000000000FFFF
      FF00FFFFFF00FF000000F7FFFF00FF00000084000000FFFFFF00FFFFFF000000
      0000CED6D60084848400000000000000000000000000C6C6C60000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C6000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF0000FFFFFF000084000000FF000000FF000000FF000000FF00000084
      0000848484000000000084848400000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      00000000000000000000000000000000000000000000CED6D60000000000FFFF
      FF00FFFFFF00FF000000FF0000008400000084000000FFFFFF00FFFFFF000000
      0000CED6D600848484000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF0000FFFFFF000084000000FF000000FF000000FF000000FF000000FF
      00000084000000000000FFFFFF00000000000000000000000000000000000000
      000000000000CED6D600A56B3900A56B3900FFFFFF00A56B3900A56B39000000
      00000000000000000000000000000000000000000000CED6D60000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000CED6D6008484840000000000000000000000000000000000C6C6C6000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF0000FFFFFF0000840000008400000084000000840000008400000084
      00000084000000840000FFFFFF00000000000000000000000000000000000000
      000000000000CED6D600A56B3900A56B3900FFFFFF00A56B3900A56B39000000
      00000000000000000000000000000000000000000000CED6D600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000CED6D6008484840000000000000000000000000000000000000000000000
      0000848484000000000000000000848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000000000000000CED6D600FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      00000000000000000000000000000000000000000000CED6D600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600CED6D6008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CED6D600CED6
      D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D600C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
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
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000C6C6C6000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000C6C6C6000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000084848400000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF0000000000000000000000000000000000FFFFFF0000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00C6C6C6000000
      00000000000000000000000000000000000000000000C6C6C600FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00C6C6C6000000
      00000000000000000000000000000000000000000000C6C6C600FFFFFF00FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00C6C6C6000000
      00000000000000000000000000000000000000000000C6C6C600FFFFFF000000
      00000000000000000000000000000000000000000000FFFFFF00C6C6C6000000
      0000000000000000000000000000000000000000000084848400FFFFFF000000
      000000000000FFFFFF00FFFFFF000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF00FFFF
      FF000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      0000FFFFFF0000000000FFFFFF0000000000FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000084848400000000000000
      000000000000FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      00000000000000000000000000000000000000000000C6C6C600000000000000
      000000000000FFFFFF00FFFFFF000000000000000000FFFFFF00C6C6C6000000
      00000000000000000000000000000000000000000000C6C6C60000000000FFFF
      FF000000000000000000000000000000000000000000FFFFFF00C6C6C6000000
      00000000000000000000000000000000000000000000C6C6C600FFFFFF000000
      0000FFFFFF0000000000FFFFFF0000000000FFFFFF00FFFFFF00C6C6C6000000
      00000000000000000000000000000000000000000000C6C6C600FFFFFF00FFFF
      FF0000000000FFFFFF000000000000000000FFFFFF00FFFFFF00C6C6C6000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF0000000000FFFFFF00FFFFFF0000000000FFFFFF0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00000000000000000000000000FFFFFF0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF0000000000FFFFFF000000000000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C6000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000C6C6C6000000
      0000FFFFFF00FFFFFF0000000000FFFFFF0000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000C6C6C6000000
      0000FFFFFF0000000000FFFFFF00FFFFFF0000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000C6C6C6000000
      0000FFFFFF000000000000000000FFFFFF0000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848484000000000000000000848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848484000000000000000000848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084848400F7FFFF00F7FFFF00848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
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
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000C6C6C6000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000C6C6C6000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF000000000000000000FFFFFF00FFFFFF0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000084848400000000000000
      00000000000000000000000000000000000000000000C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C6000000
      00000000000000000000000000000000000000000000C6C6C600FFFFFF00FFFF
      FF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFFFF00C6C6C6000000
      00000000000000000000000000000000000000000000C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C6000000
      00000000000000000000000000000000000000000000C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00000000000000000084848400FFFFFF00C6C6C6000000
      0000000000000000000000000000000000000000000084848400FFFFFF000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF00FFFF
      FF00FFFFFF00000000000000000084848400FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF00FFFF
      FF00000000000000000084848400FFFFFF00FFFFFF00FFFFFF00000000000000
      00000000000000000000000000000000000000000000C6C6C60000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C6000000
      00000000000000000000000000000000000000000000C6C6C60000000000FFFF
      FF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFFFF00C6C6C6000000
      00000000000000000000000000000000000000000000C6C6C60000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C6000000
      00000000000000000000000000000000000000000000C6C6C600000000000000
      00000000000084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C6000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF000000000000000000FFFFFF00FFFFFF0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C6000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000C6C6C6000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000C6C6C6000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848484000000000000000000848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848484000000000000000000848484000000000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFF0000FFFF0000FFFF000000000000000000000000
      0000FFFF0000FFFF000000000000000000000000000000000000000000008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840084848400000000000000000084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FF00000084
      000000000000FFFF000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400000000000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FF000000FF000000FF000000FF000000FF
      000000840000000000000000000000000000000000000000000000000000FFFF
      0000FFFF0000FFFF0000FFFF0000F7FFFF00FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000000000008484840000000000000000008484840000000000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000F7FFFF00FFFF0000FFFF0000FFFF
      0000FFFF00000000000000000000000000000000000000000000000000000000
      0000848484008484840084848400848484008484840084848400848484000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C600C6C6C600000000000000000000FF000000FF000000FF000000FF000000FF
      000000840000000000000000000000000000000000000000000000000000FFFF
      0000FFFF0000FFFF0000F7FFFF0000000000F7FFFF00FFFF0000FFFF0000FFFF
      0000FFFF0000000000008484840000000000000000008484840000000000FFFF
      0000FFFF0000FFFF0000FFFF0000F7FFFF0000000000F7FFFF00FFFF0000FFFF
      0000FFFF00000000000000000000000000000000000000000000000000000000
      0000848484000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000A56B
      3900A56B3900000000000000000000000000000000000000000000FF00000084
      000000000000FFFF00000000000000000000000000000000000000000000FFFF
      0000FFFF0000F7FFFF000000000000000000F7FFFF00F7FFFF00F7FFFF00F7FF
      FF00FFFF0000000000008484840000000000000000008484840000000000FFFF
      0000F7FFFF00F7FFFF00F7FFFF00F7FFFF000000000000000000F7FFFF00FFFF
      0000FFFF00000000000000000000000000000000000000000000000000000000
      00008484840000000000FFFFFF00FFFFFF00FFFF0000C6C6C600FFFFFF000000
      000000000000000000000000000000000000000000000000000000000000A56B
      3900A56B390000000000FFFFFF00FFFFFF00C6DEC60000000000000000000000
      0000FFFF0000FFFF00000000000000000000000000000000000000000000FFFF
      0000F7FFFF000000000000FFFF00008484000000000000000000000000000000
      0000F7FFFF00000000008484840000000000000000008484840000000000F7FF
      FF00000000000000000000000000000000000084840000FFFF0000000000F7FF
      FF00FFFF00000000000000000000000000000000000000000000000000000000
      00008484840000000000FFFFFF00F7FFFF00A56B3900C6C6C600F7FFFF000000
      00000000000000000000000000000000000000000000FF00000000000000A56B
      3900A56B39000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F7FF
      FF000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000
      0000F7FFFF00000000008484840000000000000000008484840000000000F7FF
      FF000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000
      0000F7FFFF000000000000000000000000000000000000000000000000000000
      00008484840000000000FFFFFF00FFFFFF00A56B3900C6C6C600FFFFFF000000
      00000000000000000000000000000000000000000000FF00000000000000C6C6
      C600A56B3900A56B3900A56B3900A56B3900A56B3900A56B3900A56B39000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      0000F7FFFF000000000000FFFF00008484000000000000000000000000000000
      0000F7FFFF00000000008484840000000000000000008484840000000000F7FF
      FF00000000000000000000000000000000000084840000FFFF0000000000F7FF
      FF00FFFF00000000000000000000000000000000000000000000000000000000
      00008484840000000000FFFF0000FFFF0000FFFF0000FFFF0000A56B39000000
      00000000000000000000000000000000000000000000FF00000000000000FFFF
      0000C6C6C600A56B3900A56B3900A56B3900A56B3900A56B3900A56B39000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      0000FFFF0000F7FFFF000000000000000000F7FFFF00F7FFFF00F7FFFF00F7FF
      FF00FFFF0000000000008484840000000000000000008484840000000000FFFF
      0000F7FFFF00F7FFFF00F7FFFF00F7FFFF000000000000000000F7FFFF00FFFF
      0000FFFF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      0000FFFF0000FFFF0000F7FFFF0000000000F7FFFF00FFFF0000FFFF0000FFFF
      0000FFFF0000000000008484840000000000000000008484840000000000FFFF
      0000FFFF0000FFFF0000FFFF0000F7FFFF0000000000F7FFFF00FFFF0000FFFF
      0000FFFF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF00000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      0000FFFF0000FFFF0000FFFF0000F7FFFF00FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000000000008484840000000000000000008484840000000000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000F7FFFF00FFFF0000FFFF0000FFFF
      0000FFFF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A56B3900840000008400
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848484000000000000FFFF00008484000084840000848400000000008484
      8400000000000000000000000000000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400000000000000000000000000000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084848400000000000084840000FFFF000084840000848400000000008484
      8400000000000000000000000000000000000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848484000000000000000000000000000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840000000000F7FFFF000084840000000000848484000000
      000000000000000000000000000000000000848484000000000000FFFF00F7FF
      FF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FF
      FF00000000008484840000000000000000008484840000000000CED6D600F7FF
      FF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FF
      FF00000000000000000000000000000000000000000000000000008484000084
      8400000000000000000000000000000000000000000000000000FFFFFF00CED6
      D600000000000084840000000000000000000000000000000000000000000000
      0000000000008484840000000000F7FFFF000084840000000000848484000000
      000000000000000000000000000000000000848484000000000084848400F7FF
      FF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FF
      FF00F7FFFF000000000084848400000000008484840000000000F7FFFF008484
      8400000000008484840000FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FF
      FF00000000000000000000000000000000000000000000000000008484000084
      8400000000000000000000000000000000000000000000000000FFFFFF00CED6
      D600000000000084840000000000000000000000000000000000000000000000
      0000000000008484840000000000F7FFFF000084840000000000848484000000
      000000000000000000000000000000000000848484000000000000008400F7FF
      FF00CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D600CED6D60000000000000000008484840000000000CED6D60000FF
      FF0084848400000000008484840000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000008484000084
      8400000000000000000000000000000000000000000000000000FFFFFF00CED6
      D600000000000084840000000000000000000000000000000000000000000000
      0000000000008484840000000000F7FFFF000084840000000000848484000000
      000000000000000000000000000000000000848484000000000000FFFF008484
      8400F7FFFF00CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D600CED6D60000000000000000008484840000000000CED6D600CED6
      D60000FFFF008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008484000084
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000084840000000000000000000000000000000000000000000000
      0000000000008484840000000000008484000084840000000000848484000000
      0000000000000000000000000000000000008484840000000000CED6D6000000
      8400F7FFFF00CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D600CED6D60000000000000000008484840000000000CED6D600CED6
      D600CED6D60000FFFF000000000084848400FFFFFF00FFFFFF00848484000000
      0000CED6D600FFFFFF00FFFFFF00000000000000000000000000008484000084
      8400008484000084840000848400008484000084840000848400008484000084
      8400008484000084840000000000000000008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      840000000000000000000000000000000000848484000000000000FFFF0000FF
      FF00000084000000840000008400000084000084840000848400008484000084
      840000848400008484000000000000000000848484000000000000FFFF0000FF
      FF0000FFFF0000FFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000CED6D600FFFFFF00FFFFFF00000000000000000000000000008484000084
      8400000000000000000000000000000000000000000000000000000000000000
      0000008484000084840000000000000000000000000084848400000000000000
      00008484840000000000C6C6C600CED6D600CED6D600CED6D600CED6D6000000
      000000000000C6C6C6008484840084848400848484000000000000FFFF00CED6
      D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D600C6C6C6000000000000000000848484000000000000FFFF00CED6
      D60000FFFF0000FFFF0000000000FFFFFF00F7FFFF00F7FFFF00FFFFFF000000
      0000CED6D600FFFFFF00FFFFFF00000000000000000000000000008484000000
      0000CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600000000000084840000000000000000000000000000000000848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      000000000000CED6D60084848400848484000000000000000000C6C6C60000FF
      FF0000FFFF00CED6D600C6C6C600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C60000FF
      FF00CED6D600CED6D6000000000084848400FFFFFF00FFFFFF00848484000000
      0000CED6D600FFFFFF00FFFFFF00000000000000000000000000008484000000
      0000CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D6000000000000848400000000000000000000000000CED6D600C6C6C6000000
      000000000000848484000000000000000000CED6D600CED6D600CED6D600CED6
      D600CED6D600CED6D60084848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000CED6
      D600FFFFFF00CED6D600CED6D600000000000000000000000000008484000000
      0000CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600000000000084840000000000000000000000000084848400F7FFFF000000
      0000F7FFFF0000000000FFFFFF00C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C60084848400848484000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000CED6
      D600FFFFFF00CED6D60000000000000000000000000000000000008484000000
      0000CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600000000000084840000000000000000000000000000000000848484008484
      840000000000CED6D600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      000000000000C6C6C60084848400848484000000000000000000000000000000
      000000000000000000000000000000000000000000000084000000FF00000084
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008484000000
      0000CED6D600FFFFFF00CED6D600FFFFFF00CED6D600FFFFFF00CED6D600FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FF000000FF00008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008484000000
      0000FFFFFF00CED6D600FFFFFF00CED6D600FFFFFF00CED6D600FFFFFF00CED6
      D60000000000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6DEC6000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000000000008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008400000084000000840000008400
      0000840000008400000084000000840000008400000084000000840000008400
      000084000000840000008400000000000000000000000000000084848400CED6
      D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D600CED6D60000000000000000000000000000000000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF00000000000000000084000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600848484008484
      840084848400840000008484840000000000000000000000000084848400CED6
      D60000000000CED6D60000000000CED6D60000000000CED6D600CED6D600CED6
      D600CED6D600CED6D60000000000000000000000000000000000848484000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000000000000000FF000000FF000000
      8400000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084000000C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00C6C6C600840000008484840000000000000000000000000084848400FFFF
      FF00CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D600CED6D60000000000000000000000000000000000848484000000
      0000FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000000000000000FF000000FF000000
      FF00000084000000000000000000000000000000000000000000000000000000
      00000000FF0000000000000000000000000084000000C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00C6C6C600840000008484840000000000000000000000000084848400FFFF
      FF0000000000F7FFFF0000000000CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D600CED6D60000000000000000000000000000000000848484000000
      0000FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      FF000000000000000000000000000000000084000000C6C6C600FFFFFF000000
      00000000000000000000FFFFFF00FFFFFF00000000000000000000000000FFFF
      FF00C6C6C600840000008484840000000000000000000000000084848400FFFF
      FF00FFFFFF00F7FFFF00F7FFFF00CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D600CED6D60000000000000000000000000000000000848484000000
      0000FFFFFF00FFFFFF000000000000FF000000000000FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF00000000000000000000000000000000000000FF000000
      FF000000000000000000000000000000000084000000C6C6C60000000000FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF000000
      0000C6C6C600840000008484840000000000000000000000000084848400FFFF
      FF0000000000FFFFFF0000000000CED6D60000000000CED6D60000000000CED6
      D60000000000CED6D60000000000000000000000000000000000848484000000
      0000FFFFFF00FFFFFF000000000000FF000000FF000000000000FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF0000000000000000000000FF000000FF000000
      00000000000000000000000000000000000084000000C6C6C600FFFFFF000000
      00000000000000000000FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF000000
      0000C6C6C600840000008484840000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00F7FFFF00F7FFFF00CED6D600CED6D600CED6
      D600CED6D600CED6D60000000000000000000000000000000000848484000000
      0000FFFFFF00FFFFFF000000000000FF000000000000FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF00000000000000
      00000000000000000000000000000000000084000000C6C6C600FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF00000000000000000000000000FFFF
      FF00C6C6C600840000008484840000000000000000000000000084848400FFFF
      FF0000000000FFFFFF0000000000FFFFFF0000000000F7FFFF00CED6D600CED6
      D600CED6D600CED6D60000000000000000000000000000000000848484000000
      0000FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF0000000000000000000000
      00000000000000000000000000000000000084000000C6C6C600FFFFFF000000
      000000000000FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00C6C6C600840000008484840000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7FFFF00CED6
      D600CED6D600CED6D60000000000000000000000000000000000848484000000
      0000FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00CED6D600CED6D600CED6
      D600000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF00000000000000
      00000000000000000000000000000000000084000000C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00C6C6C600840000008484840000000000000000000000000084848400FFFF
      FF0000000000FFFFFF0000000000FFFFFF0000000000FFFFFF0000000000CED6
      D600CED6D600CED6D60000000000000000000000000000000000848484000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CED6D600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF0000000000000000000000FF000000FF000000
      00000000000000000000000000000000000084000000C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00C6C6C600840000008484840000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7FFFF00F7FF
      FF00CED6D600CED6D60000000000000000000000000000000000848484000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CED6D600000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF00000000000000000000000000000000000000FF000000
      FF000000000000000000000000000000000084000000C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00C6C6C600840000008484840000000000000000000000000084848400FFFF
      FF0000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00F7FFFF000000
      0000000000000000000000000000000000000000000000000000848484000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CED6D600848484000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      FF000000FF0000000000000000000000000084000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600848484008484
      840084848400840000008484840000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7FFFF008484
      8400FFFFFF00CED6D60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF0000000000000000008400000084000000840000008400
      0000840000008400000084000000840000008400000084000000840000008400
      000084000000840000008484840000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7FFFF008484
      8400CED6D6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000840000008400
      0000840000008400000084000000000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400000000000000000000000000000000000000000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000C6C6C6000000000000000000C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C6000000000000000000C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00848400008484
      0000FFFFFF00FFFFFF00FFFFFF0000000000C6C6C600C6C6C600000000000000
      0000C6C6C600C6C6C600C6C6C6000000000000000000C6C6C600C6C6C600C6C6
      C6000000000000000000C6C6C600C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF0084840000848400008484
      000084840000FFFFFF00FFFFFF0000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C6000000000000000000FFFFFF00000000000000000000000000C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000000000000000
      0000000000000000000000000000C6C6C60000000000C6C6C60000000000C6C6
      C600C6C6C600C6C6C600C6C6C600000000000000000000000000848484000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF0084840000848400008484
      000084840000FFFFFF00FFFFFF0000000000C6C6C600C6C6C600C6C6C600C6C6
      C60000000000FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000C6C6C6000000
      0000000000000000000000000000000000000000000000000000848484000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00848400008484
      0000FFFFFF00FFFFFF00FFFFFF0000000000C6C6C600C6C6C600C6C6C600C6C6
      C60000000000FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000C6C6C600C6C6C600C6C6C600C6C6C60000000000C6C6C600000000000000
      00000000000000000000000000000000000000FF000000840000000000008484
      8400FFFFFF00FFFFFF0000000000000000000000000000000000848484000000
      0000FFFFFF00FFFFFF00FFFFFF000000000000FF000000000000FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000C6C6C6000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      000000000000C6C6C60000000000000000000000000000000000008400000084
      00000084000000840000008400000084000000FF000000FF0000008400000000
      000084848400FFFFFF00FFFFFF00000000000000000000000000848484000000
      0000FFFFFF00FFFFFF000000000000FF000000FF000000000000FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C6000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      000000000000C6C6C6000000000000000000000000000000000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF00000084
      00000000000084848400FFFFFF00000000000000000000000000848484000000
      0000FFFFFF00FFFFFF00FFFFFF000000000000FF000000000000FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000084
      000000000000000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C60000000000FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600000000000000000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF0000008400000000
      000084848400FFFFFF00FFFFFF00000000000000000000000000848484000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008400000084
      000000840000000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C60000000000FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000C6C6C600C6C6C600C6C6C600C6C6C60000000000C6C6C600000000000000
      00000000000000000000000000000000000000FF000000840000000000008484
      8400FFFFFF00FFFFFF0000000000000000000000000000000000848484000000
      0000CED6D600CED6D600CED6D600FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000084
      000000000000000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C6000000000000000000FFFFFF00000000000000000000000000C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF000000000000000000000000000000000000000000848484000000
      00000000000000000000CED6D600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000000000000000000000000000000000FFFFFF00848400008484
      0000FFFFFF000000000000000000008400000000000000000000008400000084
      000000000000000000000000000000000000C6C6C600C6C6C600000000000000
      0000C6C6C600C6C6C600C6C6C600000000000000000000000000C6C6C600C6C6
      C6000000000000000000C6C6C600C6C6C6000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C6000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000CED6D600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000000000000000000000000000000000FFFFFF00848400008484
      0000FFFFFF000000000000840000008400000084000000840000008400000000
      000000000000000000000000000000000000C6C6C6000000000000000000C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C6000000000000000000C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084848400CED6D600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000CED6
      D60000000000000000000000000000000000000000000000000000000000CED6
      D6000000000000000000000000000000000000000000F7FFFF00008484000000
      840000848400F7FFFF00C6C6C600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      84008484840000000000000000000000000000000000F7FFFF000000000000FF
      FF00000000000000000000FFFF00F7FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F7FFFF000000840000FF
      FF0000FFFF00000084000000000000FFFF00F7FFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000000000000000000008484840000000000FFFF
      FF00FFFFFF00FFFFFF00000000000000000084848400F7FFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000CED6D6000000000000000000F7FFFF0000FFFF000000
      840000FFFF0000FFFF00848484000000000000FFFF00F7FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF008484
      0000FFFFFF00FFFFFF000000000000000000000000008484840000000000FFFF
      FF00FFFFFF0000000000CED6D6000000840000FFFF0084848400F7FFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000FFFF000000
      000000FFFF00CED6D60000FFFF00000084000000000000FFFF00F7FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000008400000000000000000000FFFFFF008484
      0000FFFFFF00FFFFFF000000000000000000000000008484840000000000FFFF
      FF000000000000FFFF00000084000000FF008400840000FFFF0084848400FFFF
      FF00FFFFFF000000000000000000000000000000000000000000F7FFFF0000FF
      FF000000840000FFFF00CED6D60000FFFF00000000000000000000FFFF00F7FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008400000084000000840000008400000084000000000000FFFFFF008484
      0000FFFFFF00FFFFFF0000000000000000000000000084848400000000000000
      000000FFFF0084008400FF00FF000000FF000000FF000000840000FFFF008484
      8400FFFFFF0000000000000000000000000000000000000000000000000000FF
      FF000000000000FFFF00CED6D600CED6D60000FFFF00000084000000000000FF
      FF00F7FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484000000
      0000000000000000000000000000000000000000000000000000000000000084
      0000008400000000000000000000008400000000000000000000FFFFFF008484
      000084840000FFFFFF0000000000000000000000000084848400000000008484
      8400000084000000FF000000FF00000000000000FF00FF00FF00000084000000
      00008484840000000000000000000000000000000000000000000000000000FF
      FF0000FFFF000000000000FFFF00F7FFFF00CED6D60000FFFF00000084000000
      000000FFFF00F7FFFF0000000000000000000000000000000000000000000000
      0000000000000000000084848400000000000000000000000000848484000000
      0000848484000000000000000000000000000000000000000000000000000084
      0000000000000000000000000000000000000000000000000000FFFFFF008484
      000084840000FFFFFF000000000000000000000000008484840000000000FFFF
      FF00848484000000000084848400FFFFFF00000000000000FF00FF00FF000000
      8400000000000000000000000000000000000000000000000000F7FFFF000000
      000000000000000000000000000000FFFF00CED6D600CED6D60000FFFF000000
      84000000000000FFFF00F7FFFF00000000000000000000000000848484000000
      0000000000008484840000000000848484000000000000000000000000008484
      8400000000000000000000000000000000000000000000000000008400000084
      0000008400000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000000000000000000008484840000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000FF00FF00
      FF00000084000000000000000000000000000000000000000000F7FFFF000000
      840000FFFF0000FFFF00CED6D600CED6D600CED6D60000FFFF0000FFFF0000FF
      FF000000840084848400F7FFFF00C6C6C6000000000000000000000000008484
      8400848484000000000000000000848484000000000000000000000000000000
      0000848484008484840000000000000000000000000000000000000000000084
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008484840000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      FF00FF00FF000000840000000000000000000000000000000000F7FFFF000000
      000000FFFF0000FFFF00CED6D600CED6D60000FFFF0000000000000000000000
      00000000000000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000084848400000000000000000000000000848484000000
      0000000000008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008484840000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      00000000FF00FF00FF00000084000000000000000000000000000000000000FF
      FF000000000000FFFF0000FFFF00CED6D600CED6D600848484000000000000FF
      FF0000FFFF000000000000000000000000000000000000000000848484000000
      0000000000008484840000000000000000000000000000000000848484008484
      84008484840084848400000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000840000000000000000000000000000000000F7FF
      FF0000FFFF000000000000FFFF00CED6D600CED6D60000FFFF00848484000000
      000000FFFF0000FFFF0000000000000000000000000000000000848484008484
      8400000000000000000084848400000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF008484000084840000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F7FFFF0000FFFF000000840000FFFF00C6DEC600CED6D60000FFFF008484
      84000000000000FFFF00F7FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00848400008484
      00008484000084840000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000F7FFFF0000FFFF000000840000FFFF00CED6D600F7FFFF0000FF
      FF008484840000008400F7FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000F7FFFF0000FFFF000000840000000000000000000000
      00000000840000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840000000000000000000000000000000000000000000000
      0000000000008484840084848400848484008484840084848400848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400848484008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400000000000000000000000000000000008484
      84008484840084000000A56B3900A56B3900A56B390084000000840000008484
      8400848484000000000000000000000000000000000000000000000000000000
      0000848484008484840000000000000000000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00F7FFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000008484840000000000C6C6
      C600C6C6C600C6C6C600C6C6C600840000000000000084000000C6C6C600C6C6
      C600C6C6C600C6C6C60000000000848484000000000000000000848484008400
      0000A56B3900A56B3900A56B3900A56B3900A56B3900A56B3900A56B3900A56B
      39008400000084848400CED6D600000000000000000000000000848484008484
      84000000000000000000CED6D600000000008484840000000000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00848484008484
      8400FFFFFF00000000000000000000000000000000008484840000000000C6C6
      C600A56B3900A56B3900840000000000000000FFFF000000000084000000A56B
      3900A56B3900C6C6C60000000000848484000000000084848400848484000000
      0000A56B3900A56B3900A56B3900A56B3900A56B3900A56B3900A56B3900A56B
      3900A56B39000000000084848400000000000000000084848400000000000000
      0000CED6D6000000000000000000000000000000000084848400000000008484
      8400000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00848484000000
      0000FFFFFF00000000000000000000000000000000008484840000000000A56B
      3900A56B3900840000000000000000FFFF0000FFFF0000FFFF00000000008400
      0000A56B3900A56B3900000000008484840000000000848484000084000000FF
      000000000000A56B3900A56B3900A56B3900A56B3900A56B3900A56B3900A56B
      3900A56B3900A56B390084848400CED6D6008484840000000000CED6D6000000
      00000000000000000000848484008484840000000000CED6D600848484000000
      0000848484000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000008484840000000000A56B
      3900840000000000000000000000000000000000000000000000000000000000
      000084000000A56B390000000000848484008484840000840000008400000084
      00000084000000000000A56B3900A56B3900A56B3900A56B3900A56B3900A56B
      3900A56B39000000000000840000848484000000000084848400FFFFFF00FFFF
      FF00CED6D6008484840084008400000084008484840000000000CED6D6008484
      8400000000008484840000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00848484000000
      0000FFFFFF000000000000000000000000000000000084848400000000008400
      00000000000000FFFF0000000000C6C6C600C6C6C600A56B39000000000000FF
      FF00000000008400000000000000848484008484840000840000008400000084
      0000008400000084000084848400A56B3900A56B3900A56B3900A56B3900A56B
      3900A56B39000000000000840000848484000000000084848400848484008484
      8400848484000000840084008400000084008400840084848400000000000000
      0000848484000000000084848400000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00848484000000
      0000FFFFFF00FFFFFF0000000000000000000000000084848400000000000000
      000000FFFF0000FFFF0000000000C6C6C600A56B3900A56B39000000000000FF
      FF0000FFFF000000000000000000848484008484840000FF0000008400000000
      00008484000000000000A56B3900000000000084000084000000A56B3900A56B
      3900A56B3900A56B390000840000848484000000000084848400848484008400
      84000000FF0000FFFF000084840084008400000084008400840084848400C6C6
      C600000000008484840000000000848484000000000000000000000000000000
      00000000000000000000848484000000000000000000FFFFFF00848484000000
      000084848400FFFFFF00FFFFFF00000000000000000084848400000000008400
      00000000000000FFFF0000000000A56B3900A56B3900A56B39000000000000FF
      FF00000000008400000000000000848484008484840000FF0000008400000084
      000084848400CED6D60084848400008400000084000000840000008400000000
      000084000000000000000084000084848400000000008400840000FFFF00FF00
      FF000000FF008484840000008400840084008400840084008400840084008484
      8400000000000000000000000000848484000000000000000000848484000000
      00000000000084848400000000008484840000000000FFFFFF00FFFFFF008484
      84000000000000000000FFFFFF00FFFFFF00000000008484840000000000A56B
      3900840000000000000000000000000000000000000000000000000000000000
      000084000000A56B390000000000848484008484840000FF0000008400000084
      000000840000CED6D60084848400008400000084000000840000008400000084
      0000008400000084000000FF0000848484008484840000000000840084000000
      FF00840084000000FF008400840000FFFF0000FFFF0000848400840084008400
      8400848484000000000000000000848484000000000000000000000000008484
      840084848400000000000000000084848400FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00848484008484840000000000FFFFFF00000000008484840000000000A56B
      3900A56B3900840000000000000000FFFF0000FFFF0000FFFF00000000008400
      0000A56B3900A56B390000000000848484008484840000840000008400000084
      000000840000CED6D600CED6D600840000000084000000840000008400000084
      0000008400000084000000840000848484000000000084848400000000008484
      8400FF00FF0000008400FF00FF000000FF0000FFFF0000FFFF0000FFFF008400
      8400840084008484840000000000848484000000000000000000000000000000
      000000000000000000008484840000000000FFFFFF000000000084848400FFFF
      FF00FFFFFF008484840000000000FFFFFF00000000008484840000000000A56B
      3900A56B3900A56B3900840000000000000000FFFF000000000084000000A56B
      3900A56B3900A56B39000000000084848400C6C6C6008484840000FF00000084
      000000000000CED6D600CED6D600000000000084000000840000008400000084
      00000084000000FF000084848400000000000000000000000000848484000000
      0000848484000000FF0084008400840084008400840000FFFF0000FFFF000000
      8400840084000000000084848400000000000000000000000000848484000000
      000000000000848484000000000000000000FFFFFF0000000000848484008484
      8400848484008484840000000000FFFFFF00000000008484840000000000A56B
      3900A56B3900A56B3900A56B3900840000000000000084000000A56B3900A56B
      3900A56B3900A56B390000000000848484000000000084848400848484008484
      8400CED6D600CED6D60084840000008400000084000000840000008400000084
      0000008400000084000084848400000000000000000000000000000000008484
      84000000000084848400848484000084840000FFFF0000FFFF00000084008400
      8400000000008484840000000000000000000000000000000000848484008484
      840000000000000000008484840000000000FFFFFF00FFFFFF00000000000000
      00000000000000000000FFFFFF00FFFFFF000000000000000000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400000000000000000000000000848484008484
      8400A56B3900CED6D600000000000084000000840000008400000084000000FF
      0000008400008484840000000000000000000000000000000000000000000000
      00008484840000000000848484000000FF008400840000008400000000000000
      0000848484000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840000000000000000000000000000000000000000008484
      84008484840084840000A56B39000000000000FF000000FF0000008400008484
      8400848484000000000000000000000000000000000000000000000000000000
      0000000000008484840000000000000000000000000000000000848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000008484840084848400848484008484840084848400848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400848484008484840084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840000000000000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840000000000000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008484000000000000000000000000000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400000000000000000084848400848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400000000000000000084848400848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000084
      840000FFFF000000000084840000848400000000000000000000000084000000
      8400000084000000840000008400000084000000840000008400000084000000
      840000008400000084000000000000000000000000008484840000000000CED6
      D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D600CED6D6000000000000000000000000008484840000000000CED6
      D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D600CED6D60000000000000000008484000084840000848400008484
      00008484000000000000000000000000000000000000000000000084840000FF
      FF0000FFFF000000000000000000000000000000000000000000000084000000
      FF00000084000000840000008400000084000000840000008400000084000000
      840000008400000084000000000000000000000000008484840000000000FF00
      0000FF000000FF000000FF000000FF0000008484840084848400848484008484
      8400848484008484840000000000000000000000000084848400000000008484
      840084848400848484008484840084848400FF000000A56B3900A56B3900FF00
      0000FF000000FF000000000000000000000084840000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000084840000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF00000000000000000000000000000084000000
      FF00000084000000840000008400000084000000840000008400000084000000
      8400000084000000FF000000000000000000000000008484840000000000FF00
      0000F7FFFF00C6C6C600F7FFFF00FF00000084848400CED6D600CED6D600CED6
      D600000000008484840000000000000000000000000084848400000000008484
      8400CED6D600CED6D6008484840084848400A56B3900F7FFFF00CED6D600F7FF
      FF00F7FFFF00A56B3900000000000000000084840000FFFFFF00000000000000
      0000FFFFFF0000000000000000000000000000848400FFFFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF00000000000000000000000000000084000000
      84000000FF0000008400000084000000FF000000000000008400000084000000
      84000000FF000000FF000000000000000000000000008484840000000000A56B
      3900A56B3900FF000000FF000000FF000000848484000000000084848400CED6
      D600848484008484840000000000000000000000000084848400000000008484
      840084848400848484008484840084848400FF000000F7FFFF00FF000000CED6
      D600A56B3900A56B3900000000000000000084840000FFFFFF00000000000084
      8400000000000000000000000000000000000000000000848400FFFFFF0000FF
      FF0000FFFF0000FFFF0000FFFF00000000000000000000000000000084000084
      84000000FF000000FF000000FF0000000000000000000000FF000000FF000000
      FF000000FF00008484000000000000000000000000008484840000000000FF00
      0000F7FFFF00F7FFFF00F7FFFF00FF00000084848400CED6D600C6C6C600CED6
      D600C6C6C6008484840000000000000000000000000084848400000000008484
      84000000000000000000C6C6C60084848400A56B3900F7FFFF00F7FFFF00F7FF
      FF00C6C6C600A56B3900000000000000000084840000848400000000000000FF
      FF000084840000000000000000000000000000000000000000000084840000FF
      FF0000FFFF0000FFFF0000FFFF00000000000000000000000000000084000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000084000000000000000000000000008484840000000000A56B
      3900F7FFFF00F7FFFF00C6C6C600FF000000848484000000000084848400CED6
      D600848484008484840000000000000000000000000084848400000000008484
      840000000000CED6D600C6C6C60084848400FF000000C6DEC600FF000000CED6
      D600A56B3900A56B3900000000000000000000000000000000000000000000FF
      FF0000FFFF000084840000000000000000000000000000000000000000000084
      840000FFFF00000000000000000000000000000000000000000000FFFF000084
      840000FFFF00FFFFFF0000FFFF0000FFFF0000FFFF0000FFFF000084840000FF
      FF0000FFFF00008484000000000000000000000000008484840000000000A56B
      3900F7FFFF00F7FFFF00F7FFFF00FF00000084848400CED6D60000000000CED6
      D600C6C6C6008484840000000000000000000000000084848400000000008484
      8400CED6D600CED6D600C6C6C60084848400A56B3900F7FFFF00F7FFFF00C6C6
      C600F7FFFF00A56B390000000000000000000000000000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000848400000000000000000000000000000000000000
      00000084840000000000FFFFFF00FFFFFF0000000000000000000000840000FF
      FF0000FFFF0000FFFF000084840000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF00FFFFFF0000FFFF000000000000000000000000008484840000000000A56B
      3900C6C6C600F7FFFF00C6C6C600FF00000084848400CED6D60084848400CED6
      D600848484008484840000000000000000000000000084848400000000008484
      84000000000000000000C6C6C60084848400FF000000F7FFFF00A56B3900F7FF
      FF00A56B3900FF00000000000000000000000000000000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF00FFFFFF00008484000000000000000000000000008484
      00000000000000000000FFFFFF00FFFFFF000000000000000000000084000000
      8400000084000084840000FFFF00FFFFFF000084840000FFFF0000FFFF000084
      840000008400000084000000000000000000000000008484840000000000A56B
      3900F7FFFF00F7FFFF00F7FFFF00FF00000084848400CED6D600CED6D600CED6
      D600CED6D6008484840000000000000000000000000084848400000000008484
      8400CED6D600F7FFFF00C6C6C60084848400A56B3900CED6D600F7FFFF00C6C6
      C600F7FFFF00A56B390000000000000000000000000000FFFF0000FFFF0000FF
      FF0000FFFF00FFFFFF0000848400000000000000000000000000000000008484
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000084000000
      8400000084000000840000008400000084000000840000008400000084000000
      840000008400000084000000000000000000000000008484840000000000FF00
      0000FF000000FF000000FF000000FF0000008484840084848400848484008484
      8400848484008484840000000000000000000000000084848400000000008484
      840084848400848484008484840084848400FF000000FF000000FF000000A56B
      3900A56B3900A56B390000000000000000000000000000FFFF0000FFFF0000FF
      FF0000FFFF000084840000000000000000000000000000000000000000008484
      0000848400008484000084840000848400000000000084848400000000000000
      8400000084000000840000008400000084000000840000008400000084000000
      840000008400000000008484840000000000000000008484840000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000000000000000000008484840000000000FFFF
      FF00FFFFFF00FFFFFF00F7FFFF00F7FFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00000000000000000000000000000000000000000000FF
      FF00008484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000848484008484840000000000000000000000000084848400000000008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840000000000000000000000000084848400000000008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840000000000000000000000000000000000000000000084
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848484008484840084848400848484008484840084848400848484008484
      8400000000000000000000000000000000000000000000000000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000084000000FF000000
      FF000000FF000000FF0000000000848484008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000848484008484840000FF
      FF00C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C60000FF
      FF0000FFFF00C6C6C600C6C6C600C6C6C6000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840000000000000000000000000000000000000084000000
      FF000000FF000000FF000000FF00000000008484840084848400000000000000
      0000000000000000000000000000000000000000000084848400CED6D600CED6
      D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D600CED6D600CED6D600000000000000000000000000848484008484
      840000FFFF0000FFFF00C6C6C600C6C6C600C6C6C60000FFFF0000FFFF000000
      00000000000000FFFF00C6C6C600C6C6C6000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400000000000000000000000000000000000000
      8400CED6D6000000FF000000FF000000FF000000000084848400848484000000
      0000000000000000000000000000000000000000000084848400C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600000000008484840000000000000000008484
      84008484840000FFFF0000FFFF00C6C6C60000FFFF0000FFFF00000000000084
      84000000000000FFFF00C6C6C600C6C6C600000000000000000000848400CED6
      D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D6000084840000000000000000000000000000000000000000000000
      000000008400CED6D6000000FF000000FF000000FF0000000000848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0084848400000000000000
      0000848484000000000000FFFF0000FFFF0000FFFF000000000000FFFF0000FF
      FF000000000000FFFF00C6C6C600C6C6C6000000000000000000CED6D600CED6
      D600FFFFFF00FFFFFF00CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D600CED6D60000000000000000000000000000000000000000000000
      00000000000000008400CED6D600CED6D6000000FF000000FF00000000008484
      8400848484000000000000000000000000000000000084848400FFFFFF00CED6
      D600000000000000000000000000000000000000000000000000000000000000
      00008484840084848400C6C6C60000000000C6C6C60000FFFF00848484000000
      0000000000008484840000000000000000000000000000FFFF0000FFFF000084
      84000000000000FFFF00C6C6C600C6C6C6000000000000000000CED6D600FFFF
      FF00CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D600CED6D60000000000000000000000000000000000000000000000
      0000000000000000000000008400CED6D6008484840000000000000000000000
      0000848484008484840000000000000000000000000084848400CED6D6000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084848400C6C6C60000000000C6C6C600C6C6C60000FFFF008484
      840000000000000000000000000000000000FFFFFF00FFFFFF0000FFFF000084
      84000000000000FFFF00C6C6C600C6C6C6000000000000000000CED6D600FFFF
      FF00CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D600CED6D60000000000000000000000000000000000000000000000
      00000000000000FF000000FF00000000840000000000F7FFFF00000000000000
      0000000000008484840000000000000000000000000000000000000000000000
      0000000000008484840084848400848484008484840084848400848484000000
      000000000000000000000000000000000000C6C6C600C6C6C60000FFFF0000FF
      FF00000000000000000000000000C6C6C60000000000FFFFFF0000FFFF000000
      84000000000000FFFF0000FFFF00C6C6C6000000000000000000CED6D600FFFF
      FF00CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D600CED6D60000000000000000000000000000000000000000000000
      00000000000000FF0000FFFFFF00FFFFFF000000840000000000000000000000
      0000000000000000000084848400000000000000000084848400000000000000
      000000000000F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF000000
      000000000000000000008484840000000000C6C6C60000FFFF0000FFFF000000
      0000FFFFFF0000000000C6C6C600C6C6C60000000000FFFFFF0000FFFF0000FF
      FF00000084000000000000FFFF0000FFFF000000000000000000CED6D600FFFF
      FF00CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D600CED6D60000000000000000000000000000000000000000000000
      00000000000000FF0000FFFFFF00008400000084000000000000F7FFFF00F7FF
      FF00000000000000000084848400000000000000000000000000000000000000
      000000000000CED6D600A56B3900A56B3900FFFFFF00A56B3900A56B39000000
      000000000000000000000000000000000000C6C6C60000FFFF000000000000FF
      FF0000FFFF00FFFFFF000000000000000000FFFFFF00FFFFFF0000FFFF0000FF
      FF0000FFFF00008484000000000000FFFF000000000000000000CED6D600FFFF
      FF00CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D600CED6D60000000000000000000000000000000000000000000000
      00000000000000FF0000FFFFFF000084000000FF000000000000000000008484
      8400848484000000000000000000000000000000000000000000000000000000
      000000000000CED6D600A56B3900A56B3900FFFFFF00A56B3900A56B39000000
      000000000000000000000000000000000000C6C6C60000FFFF0000FFFF000000
      00000084840000FFFF00FFFFFF00FFFFFF00FFFFFF0000FFFF0000FFFF0000FF
      FF00008484000000000000FFFF0000FFFF000000000000000000CED6D600FFFF
      FF00CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D6000084840000000000000000000000000000000000000000000000
      00000000000000FF0000FFFFFF000084000000FF000000840000000000000000
      0000000000000000000000000000848484000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      000000000000000000000000000000000000C6C6C600C6C6C60000FFFF0000FF
      FF0000FFFF00008484000084840000FFFF0000FFFF0000FFFF00000000000000
      000000FFFF0000FFFF0000FFFF00C6C6C6000000000000000000CED6D600CED6
      D600CED6D600CED6D600CED6D600CED6D6000084840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FF0000FFFFFF000084000000FF000000FF0000008400000000
      0000000000000000000000000000848484000000000000000000000000000000
      000000000000CED6D600A56B3900A56B3900FFFFFF00A56B3900A56B39000000
      000000000000000000000000000000000000C6C6C600C6C6C600C6C6C60000FF
      FF0000FFFF0000FFFF00000000000084840000FFFF00000084000000000000FF
      FF0000FFFF0000FFFF00C6C6C600C6C6C600000000000000000000000000CED6
      D600CED6D600CED6D600CED6D600CED6D6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FF0000FFFFFF000084000000FF000000FF000000FF000000FF
      0000008400008484840000000000848484000000000000000000000000000000
      000000000000CED6D600A56B3900A56B3900FFFFFF00A56B3900A56B39000000
      000000000000000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C60000FFFF0000FFFF0000000000008484000000000000FFFF0000FF
      FF00C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FF0000FFFFFF000084000000FF000000FF000000FF000000FF
      000000FF00000084000000000000FFFFFF000000000000000000000000000000
      00000000000000000000CED6D600FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      000000000000000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C60000FFFF0000FFFF000000000000FFFF0000FFFF00C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FF0000FFFFFF00008400000084000000840000008400000084
      0000008400000084000000840000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C60000FFFF0000FFFF0000FFFF00C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FF0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
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
      0000000000000000000000000000000000000000000000848400CED6D600CED6
      D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600008484000000000000000000000000000000000000848400CED6D600CED6
      D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600008484000000000000000000000000000000000000000000000000000000
      00000000000000000000C6C6C600C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CED6D600CED6D600FFFF
      FF00FFFFFF00CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D60000000000000000000000000000000000CED6D600CED6D600FFFF
      FF00FFFFFF00CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D6000000000000000000000000000000000000000000000000000000
      00000000000000000000C6C6C60000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      84008484840084848400000000000000000000000000CED6D600FFFFFF00CED6
      D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D60000000000000000000000000000000000CED6D600FFFFFF00CED6
      D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D6000000000000000000000000000000000000000000000000000000
      00000000000000000000C6C6C60000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000848484000000000000000000CED6D600FFFFFF00CED6
      D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D60000000000000000000000000000000000CED6D600FFFFFF00CED6
      D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D6000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C6000000000084848400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      00008484840000000000F7FFFF0000000000000000000000000000000000CED6
      D6000000000000000000000000000000000000000000CED6D600FFFFFF00CED6
      D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D6000000000000000000000000000000000000000000000000000000
      00000000000000000000CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D60000000000000000000000000000000000C6C6C600C6C6C6000000
      0000000000000000000000000000000000000000000084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      00008484840000000000CED6D600000000008484840084848400848484000000
      00000000000000000000000000000000000000000000CED6D600FFFFFF00CED6
      D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D6000000000000000000000000000000000084848400848484008484
      84008484840000000000CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D60000000000000000000000000000000000C6C6C60000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000084848400FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000848484000000000000000000848484000000000000000000000000008484
      8400000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CED6D600CED6D600CED6D600CED6
      D600CED6D6000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000CED6
      D600CED6D60000000000000000000000000000000000C6C6C60000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000084848400FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      000084848400F7FFFF000000000084848400FFFFFF0084848400000000008484
      8400000000000000000000000000000000000000000084848400848484008484
      840084848400848484008484840000000000CED6D600CED6D600CED6D600CED6
      D6000084840000000000000000000000000000000000CED6D600CED6D6000000
      000084848400848484008484840084848400848484008484840000000000CED6
      D6000084840000000000000000000000000000000000C6C6C60000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000084848400FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000084848400F7FFFF0000000000848484008484840084848400000000008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C60000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000084848400FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000C6C6C600CED6D60084848400000000008484840084848400848484000000
      00008484840084848400000000000000000000000000CED6D600CED6D600CED6
      D600CED6D600CED6D600CED6D600000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF000000
      0000CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600000000000000
      00000000000000000000000000000000000000000000C6C6C60000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      840000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF0084848400000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      00000000000000000000000000000000000000000000C6C6C60000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      000000000000000000000000000000000000000000000000000084848400FFFF
      FF00848484000000000000000000000000000000000000000000000000008484
      84008484840084848400000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      00000000000000000000000000000000000000000000C6C6C60000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C60000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000848484008484840084848400848484008484840084848400848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CED6D600CED6
      D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D600000000000000000000000000000000000000000000000000C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CED6D6000000
      0000CED6D60000000000CED6D60000000000CED6D600CED6D600CED6D600CED6
      D600CED6D600000000000000000000000000000000000000000000000000C6C6
      C60000000000F7FFFF00CED6D600CED6D60000000000C6C6C600C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400848484000000000000000000000000000000000000000000000000000000
      0000848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C6000000
      0000000000000000000000000000000000000000000000000000FFFFFF00CED6
      D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D600000000000000000000000000000000000000000000000000C6C6
      C60000000000FFFFFF00F7FFFF00CED6D600CED6D60000000000C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      84008484840000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000848484000000000000000000000000000000000000000000000000000000
      00000000000000000000C6C6C6008484840000000000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      0000F7FFFF0000000000CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D600000000000000000000000000000000000000000000000000C6C6
      C60000000000FFFFFF00FFFFFF00F7FFFF00CED6D600CED6D60000000000C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      84008484840000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000848484000000000000000000000000000000000000000000000000000000
      000000000000C6C6C600CED6D6000000000000000000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00F7FFFF00F7FFFF00CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D600000000000000000000000000000000000000000000000000C6C6
      C60000000000FFFFFF00FFFFFF00FFFFFF00F7FFFF00F7FFFF00CED6D6000000
      0000000000000000000000000000000000000000000000000000000000008484
      84008484840000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      000084848400000000000000000000000000000000000000000000000000C6C6
      C600CED6D600CED6D60000FFFF00000000000000000000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      0000FFFFFF0000000000CED6D60000000000CED6D60000000000CED6D6000000
      0000CED6D600000000000000000000000000000000000000000000000000C6C6
      C60000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7FFFF00F7FFFF00F7FF
      FF00000000000000000000000000000000000000000000000000000000008484
      84008484840000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      000084848400000000000000000000000000000000000000000000000000F7FF
      FF0000FFFF0000FFFF0000FFFF00000000000000000084848400FFFFFF000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00F7FFFF00F7FFFF00CED6D600CED6D600CED6D600CED6
      D600CED6D600000000000000000000000000000000000000000000000000C6C6
      C60000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7FFFF00CED6
      D600000000000000000000000000000000000000000000000000000000008484
      84008484840000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      000084848400000000000000000000000000000000000000000000000000F7FF
      FF00FFFFFF0000FFFF0000FFFF00000000000000000084848400FFFFFF000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      0000FFFFFF0000000000FFFFFF0000000000F7FFFF00CED6D600CED6D600CED6
      D600CED6D600000000000000000000000000000000000000000000000000C6C6
      C60000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CED6
      D600000000000000000000000000000000000000000000000000000000008484
      84008484840000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      000084848400000000000000000000000000000000000000000000000000C6C6
      C600F7FFFF00FFFFFF0000FFFF00000000000000000000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7FFFF00CED6D600CED6
      D600CED6D600000000000000000000000000000000000000000000000000C6C6
      C60000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00CED6D600CED6D600CED6
      D600000000000000000000000000000000000000000000000000000000008484
      84008484840000000000FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000848484000000000000000000000000000000000000000000000000000000
      000000000000C6C6C600F7FFFF000000000000000000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      0000FFFFFF0000000000FFFFFF0000000000FFFFFF0000000000CED6D6000000
      0000CED6D600000000000000000000000000000000000000000000000000C6C6
      C60000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00CED6D600000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      84008484840000000000FFFFFF00FFFFFF00FFFFFF0000000000848484008484
      8400848484000000000000000000000000000000000000000000000000000000
      00000000000000000000C6C6C6008484840000000000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7FFFF00F7FFFF000000
      0000CED6D600000000000000000000000000000000000000000000000000C6C6
      C60000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00CED6D600000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      84008484840000000000FFFFFF00FFFFFF00FFFFFF0000000000848484000000
      0000848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C6000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      0000FFFFFF0000000000FFFFFF0000000000FFFFFF00F7FFFF00000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C60000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00CED6D600000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400848484000000000000000000000000000000000000000000848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848484008484840084848400848484008484840084848400848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
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
      8400848484008484840000000000000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840000000000000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840084848400000000000000000000000000000000000000
      0000848484008484840084848400848484008484840084848400848484008484
      8400000000000000000000000000000000000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400000000000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400000000000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000848484000000000000000000000000008484
      8400000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000848484000000000000848400CED6
      D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D600008484000000000000000000000000000000000000000000C6C6
      C6008484840084848400C6C6C600848484008484840084848400848484008484
      8400848484008484840000000000000000008484840000000000CED6D600CED6
      D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D600CED6D600CED6D600000000000000000000000000000000008484
      840000000000F7FFFF00CED6D600CED6D60000000000C6C6C600C6C6C600C6C6
      C600000000000000000000000000000000008484840000000000CED6D600CED6
      D600FFFFFF00FFFFFF00CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D600CED6D6000000000000000000000000000000000000000000CED6
      D600F7FFFF00F7FFFF00CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D600CED6D60000000000000000008484840000000000CED6D6000000
      0000000000000000000000000000CED6D60000000000CED6D600CED6D600CED6
      D6000000000000000000CED6D600000000000000000000000000000000008484
      840000000000FFFFFF00CED6D600CED6D600CED6D60000000000C6C6C600C6C6
      C600000000000000000000000000000000008484840000000000CED6D600FFFF
      FF00CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D600CED6D6000000000000000000000000000000000000000000C6C6
      C600F7FFFF000000000000000000000000000000000000000000000000000000
      0000CED6D600CED6D60000000000000000008484840000000000CED6D6000000
      0000CED6D600CED6D60000000000CED6D60000000000CED6D600CED6D6000000
      0000CED6D600CED6D600CED6D600000000000000000000000000000000008484
      840000000000FFFFFF00CED6D6000000000000000000CED6D60000000000C6C6
      C600000000000000000000000000000000008484840000000000CED6D600FFFF
      FF00CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D600CED6D6000000000000000000000000000000000000000000C6C6
      C600F7FFFF0000000000F7FFFF00F7FFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000CED6D600CED6D60000000000000000008484840000000000CED6D600CED6
      D600000000000000000000000000CED6D60000000000CED6D600CED6D6000000
      0000CED6D600CED6D600CED6D600000000000000000000000000000000008484
      840000000000FFFFFF00CED6D6000000000000000000F7FFFF00CED6D6000000
      0000000000000000000000000000000000008484840000000000CED6D600FFFF
      FF00CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D600CED6D6000000000000000000000000000000000000000000C6C6
      C600F7FFFF000000000000000000C6C6C600CED6D600F7FFFF00FFFFFF000000
      0000CED6D600CED6D60000000000000000008484840000000000CED6D600CED6
      D600CED6D600CED6D60000000000CED6D60000000000CED6D600CED6D6000000
      0000CED6D600CED6D600CED6D600000000000000000000000000000000008484
      840000000000FFFFFF00FFFFFF00CED6D60000000000F7FFFF00F7FFFF00F7FF
      FF00000000000000000000000000000000008484840000000000CED6D600FFFF
      FF00CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D600CED6D600000000000000000000000000C6C6C60000000000CED6
      D600F7FFFF0000000000C6C6C600C6C6C600C6C6C600C6C6C600F7FFFF000000
      0000CED6D600CED6D60000000000000000008484840000000000CED6D600CED6
      D6000000000000000000CED6D600CED6D600CED6D6000000000000000000CED6
      D6000000000000000000CED6D600000000000000000000000000000000008484
      840000000000FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00F7FFFF00CED6
      D600000000000000000000000000000000008484840000000000CED6D600FFFF
      FF00CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D600CED6D60000000000000000000000000000000000000000008484
      8400F7FFFF0000000000A56B3900C6C6C600C6C6C60000000000F7FFFF000000
      0000CED6D600CED6D60000000000000000008484840000000000CED6D600CED6
      D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D600CED6D600CED6D600000000000000000000000000000000008484
      840000000000FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00CED6
      D600000000000000000000000000000000008484840000000000CED6D600FFFF
      FF00CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D60000848400000000000000000000000000C6C6C60000000000CED6
      D600F7FFFF000000000000000000000000000000000000000000000000000000
      0000CED6D600CED6D60000000000000000008484840000000000CED6D600CED6
      D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D600CED6D60000848400000000000000000000000000000000008484
      840000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00CED6D600CED6D600CED6
      D600000000000000000000000000000000000000000000000000CED6D600CED6
      D600CED6D600CED6D600CED6D600CED6D6000084840000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C600F7FFFF00F7FFFF00CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D600C6C6C60000000000000000000000000000000000C6C6C600CED6
      D600CED6D600CED6D600CED6D600CED6D600CED6D600C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      840000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00CED6D600000000000000
      000000000000000000000000000000000000000000000000000000000000CED6
      D600CED6D600CED6D600CED6D600C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C600CED6D600CED6D600CED6D600CED6D600C6C6C60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      840000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00CED6D60000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      840000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00CED6D600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
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
      0000000000000000000000000000000000000000000084000000840000008400
      0000000000000000000000000000000000000000000084000000840000008400
      0000000000000000000000000000000000000000000000000000848484000000
      00000084000000FF000000FF0000848484008484840084848400848484008484
      8400C6DEC600C6DEC60000000000000000000000000000000000000000000000
      00000000000000000000848484000000000000840000C6DEC600000000000000
      0000000000000000000000000000000000008400000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084000000FFFFFF008400
      0000000000000000000000000000000000000000000084000000FFFFFF008400
      0000000000000000000000000000000000000000000000000000848484008484
      84000000000000FF000000FF000000FF0000848484008484840084848400C6DE
      C600C6DEC6000000000000000000000000000000000000000000000000000000
      00000000000084848400848484000000000000FF0000C6DEC600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084000000FFFFFF008400
      0000000000000000000000000000000000000000000084000000FFFFFF008400
      0000000000000000000000000000000000000000000000000000000000008484
      8400000000000000000000FF000084848400848484008484840084848400C6DE
      C600C6DEC6000000000000000000000000000000000000000000000000000000
      00000000000084848400000000000084000084848400C6DEC600C6DEC6000000
      0000000000000000000000000000000000008400000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084000000840000000000
      0000000000000000000000000000000000000000000084000000840000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400848484000000000000FF000000FF00008484840084848400C6DEC600C6DE
      C600000000000000000000000000000000000000000000000000000000000000
      000084848400848484000000000000FF000084848400C6DEC600C6DEC6000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084848400000000000000000000FF00008484840084848400C6DEC600C6DE
      C600000000000000000000000000000000000000000000000000000000000000
      000084848400000000000000000000FF00008484840084848400C6DEC600C6DE
      C600000000000000000000000000000000008400000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084000000840000008400
      0000000000000000000000000000000000000000000084000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      000084848400848484000000000000FF000084848400C6DEC600C6DEC6000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400848484000000000000FF000000FF00008484840084848400C6DEC600C6DE
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084000000FFFFFF008400
      0000000000000000000000000000000000000000000084000000FFFFFF008400
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084848400000000000084000084848400C6DEC600C6DEC6000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400000000000000000000FF000084848400848484008484840084848400C6DE
      C600C6DEC6000000000000000000000000008400000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084000000FFFFFF008400
      0000000000000000000000000000000000000000000084000000FFFFFF008400
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084848400848484000000000000FF0000C6DEC600000000000000
      0000000000000000000000000000000000000000000000000000848484008484
      84000000000000FF000000FF000000FF0000848484008484840084848400C6DE
      C600C6DEC6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084000000840000000000
      0000000000000000000000000000000000000000000084000000840000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000848484000000000000840000C6DEC600000000000000
      0000000000000000000000000000000000000000000000000000848484000000
      00000084000000FF000000FF0000848484008484840084848400848484008484
      8400C6DEC600C6DEC60000000000000000008400000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084000000840000008400
      0000000000000000000000000000000000000000000084000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008400000084000000840000008400
      0000840000008400000084000000840000008400000084000000840000008400
      0000840000008400000084000000840000000000000084000000FFFFFF008400
      0000000000000000000000000000000000000000000084000000FFFFFF008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084000000FFFFFF008400
      0000000000000000000000000000000000000000000084000000FFFFFF008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008400
      0000840000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008400000084000000840000000000
      0000000000000000000000000000000000008400000084000000840000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008400
      0000FFFFFF008400000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084000000FFFFFF00840000000000
      00000000000000000000000000000000000084000000FFFFFF00840000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484000000
      0000000000000000000000000000848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000840000008400
      0000840000008400000000000000000000000000000000000000000000008400
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008400000084000000000000000000
      0000000000000000000000000000000000008400000084000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000084
      0000008400000084000000840000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084000000FFFF
      FF00FFFFFF008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400848484008484840084848400000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084000000FFFF
      FF00FFFFFF008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6DE
      C600C6DEC600C6DEC600C6DEC600000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084000000FFFF
      FF00840000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008400000084000000840000000000
      0000000000000000000000000000000000008400000084000000840000000000
      0000000000000000000000000000000000008400000084000000840000000000
      0000000000000000000000000000000000008484840000000000000000000000
      000000000000848484000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000840000008400
      0000840000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084000000FFFFFF00840000000000
      00000000000000000000000000000000000084000000FFFFFF00840000000000
      00000000000000000000000000000000000084000000FFFFFF00840000000000
      0000000000000000000000000000000000000000000000840000008400000084
      000000840000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008400000084000000000000000000
      0000000000000000000000000000000000008400000084000000000000000000
      0000000000000000000000000000000000008400000084000000000000000000
      0000000000000000000000000000000000000000000084848400848484008484
      8400848484000000000000000000000000000000000000000000848484000000
      0000000000000000000000000000848484000000000000000000840000008400
      0000840000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6DEC600C6DEC600C6DE
      C600C6DEC6000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084000000FFFF
      FF00FFFFFF008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084000000FFFF
      FF00FFFFFF008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008400000084000000840000000000
      0000000000000000000000000000000000008400000084000000840000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084000000FFFF
      FF00840000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084000000FFFFFF008400
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084000000FFFFFF00840000000000
      00000000000000000000000000000000000084000000FFFFFF00840000000000
      0000000000000000000000000000000000008484840000000000000000000000
      0000000000008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000840000008400
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084000000840000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008400000084000000000000000000
      0000000000000000000000000000000000008400000084000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FF0000C6C6C600C6C6C600C6C6C6000000
      000000FF0000C6C6C600C6C6C600C6C6C6000000000084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840000000000000000000000000000000000000000000000
      00000000000000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000000000000000
      0000000000008484840000000000000000000000000000000000848484000000
      00000000000000000000000000000000000000000000C6DEC600848484008484
      840084848400848484008484840000FF0000C6C6C600C6C6C600000000008484
      8400C6DEC60000FF0000C6C6C600C6C6C6000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000840000008400000084
      00000084000000000000C6C6C60000000000000000000000000000000000C6C6
      C600000000000000000000000000C6C6C6000000000000000000000000000000
      0000000000008484840000000000000000000000000000000000848484000000
      000000000000000000000000000000000000C6C6C60000000000C6DEC6008484
      8400848484008484840000FF0000C6C6C600C6C6C600C6C6C600000000008484
      8400C6DEC60000FF0000C6C6C600C6C6C600000000008484840000000000FFFF
      FF00000000000000000000000000FFFFFF00CED6D600FFFFFF00000000000000
      000000000000FFFFFF0000000000000000000000000084848400848484008484
      84008484840000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000000000000000
      0000000000008484840000000000000000000000000000000000848484000000
      000000000000000000000000000000000000C6C6C60000000000C6DEC6008484
      8400848484008484840000FF0000C6C6C600C6C6C60000000000848484008484
      840084848400C6DEC60000FF0000C6C6C600000000008484840000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00000000000000000000000000C6DEC600C6DEC600C6DE
      C600C6DEC60000000000C6C6C60000000000000000000000000000000000C6C6
      C600000000000000000000000000C6C6C6000000000000000000000000000000
      0000000000008484840000000000000000000000000000000000848484000000
      000000000000000000000000000000000000C6C6C600C6C6C60000000000C6DE
      C6008484840000FF0000C6C6C600C6C6C600C6C6C60000000000848484008484
      840084848400C6DEC60000FF0000C6C6C600000000008484840000000000FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00000000000000
      000000000000FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000000000000000
      0000848484000000000000000000000000000000000000000000000000008484
      840000000000000000000000000000000000C6C6C600C6C6C60000000000C6DE
      C6008484840000FF0000C6C6C600C6C6C6000000000084848400848484008484
      84008484840084848400C6DEC60000FF0000000000008484840000000000FFFF
      FF000000000000FFFF0000000000FFFFFF00CED6D600FFFFFF000000000000FF
      FF0000000000FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000C6C6C60000000000000000000000000000000000C6C6
      C600000000000000000000000000C6C6C6000000000000000000000000008484
      8400000000000000000000000000000000000000000000000000000000000000
      000084848400000000000000000000000000C6C6C600C6C6C600C6C6C6000000
      000000FF0000C6C6C600C6C6C600C6C6C6000000000000000000000000000000
      000000000000000000000000000000FF0000000000008484840000000000FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00000000000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      00000000000000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000848484000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600000000008484840000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008484840000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600000000008484840000000000FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00000000000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      00000000000000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C60000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      0000000000000000000000000000C6C6C600000000008484840000000000FFFF
      FF000000000000FFFF0000000000FFFFFF00CED6D600FFFFFF000000000000FF
      FF0000000000FFFFFF0000000000000000000000000000840000008400000084
      00000084000000000000C6C6C60000000000000000000000000000000000C6C6
      C600000000000000000000000000C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C60000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      0000CED6D600CED6D600CED6D600CED6D600000000008484840000000000FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00000000000000
      000000000000FFFFFF0000000000000000000000000084848400848484008484
      84008484840000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600000000008484840000000000CED6
      D600CED6D60000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000CED6
      D600CED6D6000000000084848400000000000000000000000000000000000000
      000000000000C6C6C600C6C6C600C6C6C600C6C6C60000000000C6C6C600C6C6
      C60000000000CED6D600CED6D600CED6D600000000008484840000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00000000000000000000000000C6DEC600C6DEC600C6DE
      C600C6DEC60000000000C6C6C60000000000000000000000000000000000C6C6
      C600000000000000000000000000C6C6C6000000000000000000848484000000
      00000000000000000000848484008484840084848400FFFFFF00000000000000
      00000000000084848400000000000000000000000000CED6D600CED6D600CED6
      D60000000000C6C6C6000000000000000000000000000000000000000000C6C6
      C600C6C6C60000000000CED6D600CED6D6000000000084848400000000000000
      00000000000000000000C6C6C600C6C6C600C6C6C600C6C6C600000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000000000000000
      00008484840000000000FFFFFF00FFFFFF00FFFFFF0084848400000000008484
      84000000000000000000000000000000000000000000CED6D600CED6D600CED6
      D60000000000C6C6C600C6C6C600C6C6C600C6C6C60000000000C6C6C600C6C6
      C600C6C6C600C6C6C60000000000CED6D6000000000084848400000000000000
      0000848484000000000084848400000000008484840084848400000000008484
      84000000000084848400000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000C6C6C60000000000000000000000000000000000C6C6
      C600000000000000000000000000C6C6C6000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF008484840084848400000000000000
      000000000000000000000000000000000000C6C6C60000000000CED6D6000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600000000000000000084848400000000000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C600C6C6C60000000000C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400000000000000000084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C6008484840084848400C6C6C600848484008484840084848400848484008484
      8400848484008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000848400CED6D600CED6
      D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D60000848400000000000000000000000000000000000000000000000000CED6
      D600F7FFFF00F7FFFF00CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D600CED6D6000000000000000000C6C6C600FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CED6D600CED6D600FFFF
      FF00FFFFFF00CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D600000000000000000000000000000000000000000000000000C6C6
      C600F7FFFF000000000000000000000000000000000000000000000000000000
      0000CED6D600CED6D6000000000000000000C6C6C600FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CED6D600FFFFFF00CED6
      D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D600000000000000000000000000000000000000000000000000C6C6
      C600F7FFFF0000000000F7FFFF00F7FFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000CED6D600CED6D6000000000000000000C6C6C600FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CED6D600FFFFFF00CED6
      D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D600000000000000000000000000000000000000000000000000C6C6
      C600F7FFFF000000000000000000C6C6C600CED6D600F7FFFF00FFFFFF000000
      0000CED6D600CED6D6000000000000000000C6C6C600FFFFFF00FFFFFF000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000008484
      8400000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00000000000000000000000000CED6D600FFFFFF00CED6
      D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D60000000000000000000000000000000000C6C6C60000000000CED6
      D600F7FFFF0000000000C6C6C600C6C6C600C6C6C600C6C6C600F7FFFF000000
      0000CED6D600CED6D6000000000000000000C6C6C600FFFFFF00FFFFFF000000
      00000000000000000000FFFFFF0000000000FFFFFF00FFFFFF00000000008484
      84000000000000000000000000000000000000000000FFFFFF00C6C6C6000000
      0000C6C6C600FFFFFF0000000000000000000000000000000000FFFFFF00C6C6
      C60000000000C6C6C600FFFFFF000000000000000000CED6D600FFFFFF00CED6
      D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D6000000000000000000000000000000000000000000000000008484
      8400F7FFFF0000000000A56B3900C6C6C600C6C6C60000000000F7FFFF000000
      0000CED6D600CED6D6000000000000000000C6C6C600FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000FFFFFF00FFFFFF00000000008484
      84000000000000000000000000000000000000000000FFFFFF00000000008484
      840000000000FFFFFF0000000000000000000000000000000000FFFFFF000000
      00008484840000000000FFFFFF000000000000000000CED6D600FFFFFF00CED6
      D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D60000000000000000000000000000000000C6C6C60000000000CED6
      D600F7FFFF000000000000000000000000000000000000000000000000000000
      0000CED6D600CED6D6000000000000000000C6C6C600FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00000000008484
      84000000000000000000000000000000000000000000FFFFFF00C6C6C6000000
      0000C6C6C600FFFFFF0000000000000000000000000000000000FFFFFF00C6C6
      C60000000000C6C6C600FFFFFF000000000000000000CED6D600CED6D600CED6
      D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D60000848400000000000000000000000000000000000000000000000000C6C6
      C600F7FFFF00F7FFFF00CED6D600CED6D600CED6D600CED6D600CED6D600CED6
      D600CED6D600C6C6C6000000000000000000C6C6C600FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000FFFFFF00FFFFFF00000000008484
      84000000000000000000000000000000000000FF000000000000FFFFFF00FFFF
      FF00FFFFFF000000000000FF0000000000000000000000FF000000000000FFFF
      FF00FFFFFF00FFFFFF000000000000FF000000000000CED6D600CED6D600CED6
      D600CED6D600CED6D600CED6D600CED6D6000000000000000000000000000000
      0000000000008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C600FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000FF0000000000000000
      00000000000000FF00000000000000000000000000000000000000FF00000000
      0000000000000000000000FF0000000000000000000000000000CED6D600CED6
      D600CED6D600CED6D600CED6D600000000000000000084848400000000000000
      0000000000008484840000000000848484000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      000084848400000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600000000000000000000000000FFFFFF000000
      000000000000000000000000000000000000000000000000000000FF000000FF
      000000FF000000000000000000000000000000000000000000000000000000FF
      000000FF000000FF000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484008484
      8400848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      0000848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000008484
      8400000000000000000084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000848484000000000000000000000000000000
      0000000000000000000084848400000000000000000000000000848484000000
      0000000000000000000084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000900100000100010000000000800C00000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFFFFFFFFFF0000FFFFFFFFFFCF0000
      FE7FFFEFFFCF0000FE7FFFEFFFCF0000FC3FFFEFFF870000F81FFFC7FF870000
      F00FFC2F9FCF0000F00FEF2F98490000F00FEEA39C410000F20FEDBF08630000
      F81FC7FF097F0000FC3FEFFF9FFF0000FE4FEFFF93FF0000FE0FE3FF83FF0000
      FF1FFFFFC7FF0000FFFFFFFFFFFF0000FF07FFFF8067FFFFFF07FFFF8043FFFF
      FF07FF99C0819BBDFF07FF99C0816B81FF07FF93E100EBDBFB01FF83F3008881
      F87CFF87FFFF6B5B0040FF87FFFF6B5B3800FF930FE00B6B3905C999CFFE2881
      39FFF79FCFFE8FFF03FFC19FCF9CFFFF39FFF79FC8008FFF39FFFFFF4F98A801
      39FFFFFF8FF88FFF03FFFFFFCFE0FFFFFFBFF007FFFFFF07FF1FCFFBFFFFFF07
      001FA80BFFFFFF077E0FAFFBFFFFFF077C0FA80B54A9FF0778C7AC7B54A8FB01
      40E7A80B54AAF87C7CE3AD1B546A804042F1A80B54AA38007EF9ACBB2CAAF905
      42F8A80BFCAAE1FF7EFCAFFBFCB883FF42FEA553FC690FFF7EFFB007FFFF3FFF
      7EFFD007FFFF39FF00FFEAAFFFFF83FFFFFFFFFFFFFFFCFCF007FFFFFE1FF87D
      E003FFFFFC1F8079E003CE73F81FBE33E0038421F01FA103E003A529F01FBF07
      E003CE73F01FA107E003FFFF0001BC03E0038001F01FA031E0030000F01FBC78
      E003000CF01FA07FE0037FF8F01FBF7FE0030000F81FA17FE0038001FC1FBF7F
      F007FFFFFE1FBF7FFFFFFFFFFFFF807FE00FC000FE49FFFFC0078000FE49FFFF
      800B0000FFFF07C180010000FFFF07C180000000C7C707C100000000C7C70101
      80010000C387000180030001C007000180030001C007000180010001C0078003
      80000001C007C10700000001C007C10780018003F39FE38F8003C5AFF39FE38F
      800BE3DFF39FFFFFC007F03FFFFFFFFFFFFF80078007FE03FFFF00030003FC01
      FF1F00030003FC01FC4F00030003FC01F80F00030003C001E097000300038001
      C057000300038001C017000360038001C017000300038001C0577E070FC78005
      E09700FF001F8003F80F00F7001D803FFC4F00E30018803FFF1F00F7001D80BF
      FFFF008F0003C07FFFFF01FFE03FFFFFFFF9C03F8001C007FFF1E01F0000D007
      FFE3F00F0000E00FF0C7F80700008003C60FF04700000001909FF08300000001
      A05FF00300000001000FF00380010001002FF001F00F0001002FF001F00F0001
      200FF001F00F0001A05FF001F00F0001909FF001F00F0001C63FF001F00F0001
      E07FFFFFFC1F8001FFFFFFFFFFFFC003FFF9FFF9FFF9FFF9FFF1FFF1FFF1FFF1
      FFE3FFE3FFE3FFE3F0C7F0C7F0C7F0C7C60FC60FC60FC60F909F909F909F909F
      A05FA05FA05FA05F000F000F000F000F002F002F402F442F002F002F402F402F
      200F200F000F020FA05FA05FA05FA25F909F909F909F909FC63FC73FC63FC03F
      E07FE07FE07FE07FFFFFFFFFFFFFFFFFFFF9FFF9FFF9FFF9FFF1FFF1FFF1FFF1
      FFE3FFE3FFE3FFE3F0C7F0C7F0C7F0C7C60FC60FC60FC60F909F909F909F901F
      A05FA05FA05FA01F000F000F000F000F002F002F002F002F002F002F002F002F
      200F200F200F200FA05FA05FA05F805F909F909F909F809FC63FC63FC63FC63F
      E07FE07FE07FE07FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF801FFFFFFFFFFFF
      F801E0018007FFFFF801C0018003CFFFC001C0018003901FC001C0018003B00F
      C001C0018003B00F0001C0018003100D0001C0018003B008000FC0018003F00D
      000FC0018003F80D000FC0018003FFF9003FC0018003FFF3003FC003C003FFFF
      003FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FC00FC00FFFFFF00F80078007C003
      F81F000300078001F81F000100078001F81F000100078001F81F000100018001
      F81F0001000080017801000100008001300000010000800103F8800380008001
      0300C18FC20080019400FF8FFFC08001C000FE03FFE18001F819FF07FFFF8001
      FFFFFF8FFFFF8001FFFFFFDFFFFFFFFFFFFFFFFFFFC18001E00FDFFB00018001
      C0078FFB00018001C00787F700018001C00787E700018001C007C3CF00018001
      C007E18F00018001C007F01F00018001C007F83F00018001C007F83F00018001
      C007F01F00018001C007C18F00018001C01783C700018001C00F87E300018001
      E01F8FFB00018001FFFFFFFFFFC18003FFFF8181FFFFFFFFFC00C183FFFFE00F
      FC006006FFFFC007FC00318CFFFFC007FC0006E0FE21C007FC0008F0C001C007
      FC0008F08002C007FC00D0FB8000C007FC00D0FB8000C007FFEF08F08000C007
      03C708F08002C00703EF06E0FF04C00702CF31CCFF01E807001F6006FFFFF007
      02FFC183FFFFF80703FF8181FFFFFFFFEFEF81FFFFFFFFFF800780FFFFFFFF81
      8003807FFFCFFF818001803FFFCFFF818003C01FFFFFFE818003C00FFFCFF001
      8003E007FFCFE6818003E003FDC7EF818003C00198E3C7818003C00080F1EF81
      8001C003819900FF8000E007838100FFC000E00381C300FFFFF9F00181FF00FF
      FFFFF801FFFF00FFFFFFFC03FFFF00FFE003F81FFC7FFFFFC001E007F03FFF87
      8000C001C11FFF8780008001878FFF87800080001C87FF87800000000043FF87
      800000000031FF83800000000008FD8180000000000C98808000000000048000
      800000008000810080000001C001830080008001E0038100C001C003F0078181
      E003E007F80FFFFFFFEFF81FFC3FFFFFFFF3C003C003C003FFE3800180018001
      07C0800180018001038080018001800103008001800980010200800180418001
      0300800180018C01038080018041880101C080018021800100C0800180018C01
      004080018001800100C080018001800101C080018001800103E0C00380018001
      C7FFF00FC003C003CFFFFFFFFFFFFFFFFFFF807F80018000C003C03F0000C018
      8001E01F000060288001F00F000034488001F80700001B888001FC0300000F08
      8001F82300000E888001F841800114848001F801F00F23028001F801F00F1004
      8001F800F00F00308003F800F00F0220C07FF800F00F0140E0FFF800F00F0080
      FFFFF800FC1F0000FFFFF800FFFF000080078007FE03FFFF00030003FC01FFFF
      00030003FC01800300030003FC01000100030003C001050D000300038001040D
      0003000380010405000360038001000500030003800100057E070FC780050001
      00FF001F80036E0100F7001D803F47E100E30018803FA80300F7001D80BFC7FF
      008F0003C07FFFFF01FFE03FFFFFFFFFFFFFFFFFFFFF8003F00FF00FFFFF8003
      E007E007FF1F8003E087E7F7FC4F8003E047E417F80F8003E027E417E0978003
      E017E417C0578003E007E417C0178003E007E417C0178003E007E417C0578003
      E007E477E0978013E007E447F80F8013E017E457FC4F8003E00FE7CFFF1F8017
      F01FF01FFFFF800FFFFFFFFFFFFF801FFFFFFFFFFFFFFFFFC003C003C001F00F
      800180018000E007000180010000E0870001C0010000E047000180010000E027
      0001C0010000E017000182010000E007000180010000E007000180410000E007
      000180010000E007800380018001E007C07FC003C03FE007E0FFFFFFE07FE00F
      FFFFFFFFFFFFF01FFFFFFFFFFFFFFFFFFFFFFFFFC001FC3FFFFF8888C001FC1F
      61118F8FC003F81FFFFF8888E003F80F61119F9FE007F00FFFFFFFFFF007F007
      61118888F00FE007FFFF8F8FF80FE00361118888F81FC003FFFF9F9FFC1FC001
      6111FFFFFC3FC001FFFF8888FFFFFFFF00008F8FEDF0C3EDFFFF8888E11BEE21
      E1119F9FEDFDF7EDFFFFFFFFF3F0C3F3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFC0FF81E3FF1F1FFFFFFFFFE23F1111FFC0FFC3E7FF3F3FFFC0FFC3FFFFFFFF
      03C0FFC3FFFFFFFFFFC0FFC3FF1F1F1F03C081C7FF11111103C0FFFFFF3F3F3F
      03C0C3FFFFFFFFFF03FFC3FFFFFFFFFF03FFC3FF8FFF1F1F03FFC3FF88FF1111
      03FFC7FF9FFF3F3FFFFFFFFFFFFFFFFFFFFFFE1080038400F81F802080010000
      F81F402080010000F81F404080010000F81F204080010000F00F208080010000
      E00710FE80018400C00300008001000080010000800184008001000080010000
      80010000800100008001000080010000C00300009C3D0000F00F000080010000
      F81F0000901D8400F81F0000C0010000FFFF8001800FFFFF80078001000FFFFF
      0003C001000FFFFF00038001000FFFFF0003C001000FC7E300038201000F83C1
      00038001000F018000038041000F018000038001000B01800003800100070180
      0003C003000F83C180BAFF770014C7E3C1C7FF8FFFAFFFFFFFFFFF77FF57FFFF
      FF6DFFDFFEFBFFFFFFFEFDDDFFDFFFFF00000000000000000000000000000000
      000000000000}
  end
  object oqCursor2: TOraQuery
    Session = dmMain.orases
    AutoCommit = False
    Left = 94
    Top = 324
  end
  object oqGetAcc: TOraQuery
    Session = dmMain.orases
    SQL.Strings = (
      'begin ryda.editfeeders_pg.get_acc(:par1,:par2);end;')
    AutoCommit = False
    Left = 110
    Top = 494
    ParamData = <
      item
        DataType = ftInteger
        Name = 'par1'
        ParamType = ptInput
      end
      item
        DataType = ftCursor
        Name = 'par2'
        Value = 'Object'
      end>
  end
  object oqClonF: TOraQuery
    Session = dmMain.orases
    AutoCommit = False
    Left = 194
    Top = 414
  end
  object oqGetCompanyInfo: TOraQuery
    SQL.Strings = (
      
        'begin ryda.editfeedergroup_pg.read_enterprise_data(:par1,:par2,:' +
        'par3,:par4,:par5,:par6,:par7,:par8,:par9,:par10,:par11); end;')
    Left = 200
    Top = 512
    ParamData = <
      item
        Name = 'par1'
        ParamType = ptOutput
        Value = ''
        ExtDataType = 107
      end
      item
        DataType = ftString
        Name = 'par2'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'par3'
        ParamType = ptOutput
      end
      item
        Name = 'par4'
        ParamType = ptOutput
        Value = ''
        ExtDataType = 107
      end
      item
        DataType = ftString
        Name = 'par5'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'par6'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'par7'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'par8'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'par9'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'par10'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'par11'
        ParamType = ptOutput
      end>
  end
end
