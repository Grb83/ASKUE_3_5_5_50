inherited TransformersForm: TTransformersForm
  Left = 563
  Top = 36
  Width = 635
  Height = 679
  HelpContext = 529
  Caption = 'TransformersForm'
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  inherited iplBottom: TPanel
    Top = 595
    Width = 619
    TabOrder = 2
    inherited iplClose: TPanel
      Left = 538
    end
  end
  object plParams: TPanel [1]
    Left = 365
    Top = 0
    Width = 254
    Height = 595
    Align = alRight
    BevelOuter = bvLowered
    Constraints.MinHeight = 200
    Constraints.MinWidth = 250
    TabOrder = 1
    object tbTools: TToolBar
      Left = 1
      Top = 565
      Width = 252
      Height = 29
      Align = alBottom
      Caption = 'tbTools'
      Images = ilMenu
      TabOrder = 0
      object NewPowerTransTBtn: TToolButton
        Left = 0
        Top = 2
        Action = NewPowerTransAction
      end
      object NewReactorTBtn: TToolButton
        Left = 23
        Top = 2
        Action = NewReactorAction
      end
      object NewMeteringTransTBtn: TToolButton
        Left = 46
        Top = 2
        Action = NewMeteringTransAction
      end
      object NewLineTBtn: TToolButton
        Left = 69
        Top = 2
        Action = NewLineAction
      end
      object ChangeTransLineTBtn: TToolButton
        Left = 92
        Top = 2
        Action = iaMon
      end
      object tbDelete: TToolButton
        Left = 115
        Top = 2
        Action = iaDelete
      end
      object ToolButton1: TToolButton
        Left = 138
        Top = 2
        Width = 8
        Caption = 'ToolButton1'
        ImageIndex = 50
        Style = tbsSeparator
      end
      object SetWorkTimeTBtn: TToolButton
        Left = 146
        Top = 2
        Action = SetWorkTimeAction
      end
      object CalcLossParamTBtn: TToolButton
        Left = 169
        Top = 2
        Action = CalcLossParamAction
        Visible = False
      end
      object tbSpezParam: TToolButton
        Left = 192
        Top = 2
        Hint = #1057#1087#1077#1094#1080#1072#1083#1100#1085#1099#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1099
        Action = aSpezPar
        Caption = #1057#1087#1077#1094#1080#1072#1083#1100#1085#1099#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1099
        ImageIndex = 89
      end
      object tbLimit: TToolButton
        Left = 215
        Top = 2
        Hint = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1075#1088#1072#1085#1080#1094
        Action = aBorderPar
        Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1075#1088#1072#1085#1080#1094
        ImageIndex = 90
      end
    end
    object HeaderPanel: TPanel
      Left = 1
      Top = 1
      Width = 252
      Height = 50
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvNone
      TabOrder = 1
      object lName: TLabel
        Left = 8
        Top = 5
        Width = 56
        Height = 13
        Caption = #1053#1072#1079#1074#1072#1085#1080#1077' :'
      end
      object lId: TLabel
        Left = 99
        Top = 5
        Width = 65
        Height = 13
        Caption = #1048#1076' '#1086#1073#1098#1077#1082#1090#1072' :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsUnderline]
        ParentFont = False
      end
      object NameEdit: TEdit
        Left = 8
        Top = 23
        Width = 233
        Height = 21
        TabOrder = 0
      end
      object eId: TEdit
        Left = 167
        Top = 5
        Width = 73
        Height = 16
        TabStop = False
        BorderStyle = bsNone
        Color = clMenu
        ReadOnly = True
        TabOrder = 1
      end
    end
    object paramPanel: TPanel
      Left = 1
      Top = 51
      Width = 252
      Height = 514
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 2
      object TransformerPControl: TPageControl
        Left = 0
        Top = 32
        Width = 252
        Height = 482
        ActivePage = TransmissionLinePage
        Align = alClient
        TabIndex = 3
        TabOrder = 0
        object MeteringTransformerPage: TTabSheet
          Caption = 'MeteringTransformerPage'
          object lValueSecond: TLabel
            Left = 3
            Top = 34
            Width = 109
            Height = 13
            Alignment = taRightJustify
            Caption = #1042#1090#1086#1088#1080#1095#1085#1086#1077' '#1079#1085#1072#1095#1077#1085#1080#1077' :'
          end
          object lValueFirst: TLabel
            Left = 3
            Top = 10
            Width = 111
            Height = 13
            Alignment = taRightJustify
            Caption = #1055#1077#1088#1074#1080#1095#1085#1086#1077' '#1079#1085#1072#1095#1077#1085#1080#1077' :'
          end
          object mVal2Edit: TEdit
            Left = 137
            Top = 31
            Width = 105
            Height = 21
            TabOrder = 1
          end
          object mVal1Edit: TEdit
            Left = 137
            Top = 7
            Width = 105
            Height = 21
            TabOrder = 0
          end
        end
        object TwoPowerTransformerPage: TTabSheet
          Caption = 'TwoPowerTransformerPage'
          ImageIndex = 1
          object p2SnLabel: TLabel
            Left = 3
            Top = 11
            Width = 118
            Height = 13
            Caption = #1053#1086#1084'-'#1103' '#1084#1086#1097#1085#1086#1089#1090#1100' ['#1082#1042#1040']:'
          end
          object p2dPxxLabel: TLabel
            Left = 3
            Top = 35
            Width = 127
            Height = 13
            Caption = #1055#1086#1090#1077#1088#1080' '#1093#1086#1083'-'#1075#1086' '#1093#1086#1076#1072' ['#1082#1042#1090']:'
          end
          object p2dPkzLabel: TLabel
            Left = 3
            Top = 59
            Width = 84
            Height = 13
            Caption = #1055#1086#1090#1077#1088#1080' '#1050#1047' ['#1082#1042#1090']:'
          end
          object p2IxxLabel: TLabel
            Left = 3
            Top = 83
            Width = 119
            Height = 13
            Caption = #1058#1086#1082' '#1093#1086#1083#1086#1089#1090#1086#1075#1086' '#1093#1086#1076#1072' [%]:'
          end
          object p2UkzLabel: TLabel
            Left = 3
            Top = 107
            Width = 101
            Height = 13
            Caption = #1053#1072#1087#1088#1103#1078#1077#1085#1080#1077' '#1050#1047' [%]:'
          end
          object p2WorkHoursLabel: TLabel
            Left = 3
            Top = 141
            Width = 111
            Height = 13
            Caption = #1058' '#1088#1072#1073#1086#1090#1099' ('#1085#1086#1088#1084') ['#1095#1072#1089']:'
          end
          object p2FullHoursLabel: TLabel
            Left = 3
            Top = 165
            Width = 110
            Height = 13
            Caption = #1058' '#1087#1086#1083#1085#1086#1077' ('#1085#1086#1088#1084') ['#1095#1072#1089']:'
          end
          object p2TimeBevel: TBevel
            Left = 7
            Top = 127
            Width = 230
            Height = 5
            Shape = bsBottomLine
          end
          object Bevel1: TBevel
            Left = 7
            Top = 185
            Width = 230
            Height = 5
            Shape = bsBottomLine
          end
          object p2SnEdit: TEdit
            Left = 137
            Top = 7
            Width = 105
            Height = 21
            TabOrder = 0
          end
          object p2dPxxEdit: TEdit
            Left = 137
            Top = 31
            Width = 105
            Height = 21
            TabOrder = 1
          end
          object p2dPkzEdit: TEdit
            Left = 137
            Top = 55
            Width = 105
            Height = 21
            TabOrder = 2
          end
          object p2IxxEdit: TEdit
            Left = 137
            Top = 79
            Width = 105
            Height = 21
            TabOrder = 3
          end
          object p2UkzEdit: TEdit
            Left = 137
            Top = 103
            Width = 105
            Height = 21
            TabOrder = 4
          end
          object p2WorkHoursEdit: TEdit
            Left = 137
            Top = 137
            Width = 105
            Height = 21
            TabOrder = 5
          end
          object p2FullHoursEdit: TEdit
            Left = 137
            Top = 161
            Width = 105
            Height = 21
            TabOrder = 6
          end
        end
        object ThreePowerTransformerPage: TTabSheet
          Caption = 'ThreePowerTransformerPage'
          ImageIndex = 2
          object p3SnLabel: TLabel
            Left = 3
            Top = 11
            Width = 118
            Height = 13
            Caption = #1053#1086#1084'-'#1103' '#1084#1086#1097#1085#1086#1089#1090#1100' ['#1082#1042#1040']:'
          end
          object p3SuLabel: TLabel
            Left = 3
            Top = 35
            Width = 129
            Height = 13
            Caption = #1052#1086#1097'-'#1090#1100' '#1086#1073#1084#1086#1090#1082#1080' '#1042'. ['#1082#1042#1040']:'
          end
          object p3SmLabel: TLabel
            Left = 3
            Top = 59
            Width = 129
            Height = 13
            Caption = #1052#1086#1097'-'#1090#1100' '#1086#1073#1084#1086#1090#1082#1080' '#1057'. ['#1082#1042#1040']:'
          end
          object p3SdLabel: TLabel
            Left = 3
            Top = 83
            Width = 130
            Height = 13
            Caption = #1052#1086#1097'-'#1090#1100' '#1086#1073#1084#1086#1090#1082#1080' '#1053'. ['#1082#1042#1040']:'
          end
          object p3PxxLabel: TLabel
            Left = 3
            Top = 107
            Width = 127
            Height = 13
            Caption = #1055#1086#1090#1077#1088#1080' '#1093#1086#1083'-'#1075#1086' '#1093#1086#1076#1072' ['#1082#1042#1090']:'
          end
          object p3PkzuLabel: TLabel
            Left = 3
            Top = 131
            Width = 97
            Height = 13
            Caption = #1055#1086#1090#1077#1088#1080' '#1050#1047' '#1042'. ['#1082#1042#1090']:'
          end
          object p3PkzmLabel: TLabel
            Left = 3
            Top = 155
            Width = 97
            Height = 13
            Caption = #1055#1086#1090#1077#1088#1080' '#1050#1047' '#1057'. ['#1082#1042#1090']:'
          end
          object p3PkzdLabel: TLabel
            Left = 3
            Top = 179
            Width = 98
            Height = 13
            Caption = #1055#1086#1090#1077#1088#1080' '#1050#1047' '#1053'. ['#1082#1042#1090']:'
          end
          object p3IxxLabel: TLabel
            Left = 3
            Top = 203
            Width = 119
            Height = 13
            Caption = #1058#1086#1082' '#1093#1086#1083#1086#1089#1090#1086#1075#1086' '#1093#1086#1076#1072' [%]:'
          end
          object p3UkzuLabel: TLabel
            Left = 3
            Top = 227
            Width = 114
            Height = 13
            Caption = #1053#1072#1087#1088#1103#1078#1077#1085#1080#1077' '#1050#1047' '#1042'. [%]:'
          end
          object p3UkzmLabel: TLabel
            Left = 3
            Top = 251
            Width = 114
            Height = 13
            Caption = #1053#1072#1087#1088#1103#1078#1077#1085#1080#1077' '#1050#1047' '#1057'. [%]:'
          end
          object p3UkzdLabel: TLabel
            Left = 3
            Top = 275
            Width = 115
            Height = 13
            Caption = #1053#1072#1087#1088#1103#1078#1077#1085#1080#1077' '#1050#1047' '#1053'. [%]:'
          end
          object p3WorkHoursLabel: TLabel
            Left = 3
            Top = 309
            Width = 111
            Height = 13
            Caption = #1058' '#1088#1072#1073#1086#1090#1099' ('#1085#1086#1088#1084') ['#1095#1072#1089']:'
          end
          object p3FullHoursLabel: TLabel
            Left = 3
            Top = 333
            Width = 110
            Height = 13
            Caption = #1058' '#1087#1086#1083#1085#1086#1077' ('#1085#1086#1088#1084') ['#1095#1072#1089']:'
          end
          object p3TimeBevel: TBevel
            Left = 7
            Top = 295
            Width = 230
            Height = 5
            Shape = bsBottomLine
          end
          object Bevel2: TBevel
            Left = 7
            Top = 353
            Width = 230
            Height = 5
            Shape = bsBottomLine
          end
          object p3SnEdit: TEdit
            Left = 137
            Top = 7
            Width = 105
            Height = 21
            TabOrder = 0
          end
          object p3SuEdit: TEdit
            Left = 137
            Top = 31
            Width = 105
            Height = 21
            TabOrder = 1
          end
          object p3SmEdit: TEdit
            Left = 137
            Top = 55
            Width = 105
            Height = 21
            TabOrder = 2
          end
          object p3SdEdit: TEdit
            Left = 137
            Top = 79
            Width = 105
            Height = 21
            TabOrder = 3
          end
          object p3dPxxEdit: TEdit
            Left = 137
            Top = 103
            Width = 105
            Height = 21
            TabOrder = 4
          end
          object p3dPkzuEdit: TEdit
            Left = 137
            Top = 127
            Width = 105
            Height = 21
            TabOrder = 5
          end
          object p3dPkzmEdit: TEdit
            Left = 137
            Top = 151
            Width = 105
            Height = 21
            TabOrder = 6
          end
          object p3dPkzdEdit: TEdit
            Left = 137
            Top = 175
            Width = 105
            Height = 21
            TabOrder = 7
          end
          object p3IxxEdit: TEdit
            Left = 137
            Top = 199
            Width = 105
            Height = 21
            TabOrder = 8
          end
          object p3UkzuEdit: TEdit
            Left = 137
            Top = 223
            Width = 105
            Height = 21
            TabOrder = 9
          end
          object p3UkzmEdit: TEdit
            Left = 137
            Top = 247
            Width = 105
            Height = 21
            TabOrder = 10
          end
          object p3UkzdEdit: TEdit
            Left = 137
            Top = 271
            Width = 105
            Height = 21
            TabOrder = 11
          end
          object p3FullHoursEdit: TEdit
            Left = 137
            Top = 329
            Width = 105
            Height = 21
            TabOrder = 13
          end
          object p3WorkHoursEdit: TEdit
            Left = 137
            Top = 305
            Width = 105
            Height = 21
            TabOrder = 12
          end
        end
        object TransmissionLinePage: TTabSheet
          Caption = 'TransmissionLinePage'
          ImageIndex = 3
          object tlNRoLabel: TLabel
            Left = 3
            Top = 11
            Width = 116
            Height = 13
            Caption = #1040#1082#1090'. '#1089#1086#1087#1088'-'#1085#1080#1077' ['#1054#1084'/'#1082#1084']:'
          end
          object tlXoLabel: TLabel
            Left = 3
            Top = 35
            Width = 134
            Height = 13
            Caption = #1056#1077#1072#1082#1090'-'#1077' '#1089#1086#1087#1088'-'#1085#1080#1077' ['#1054#1084'/'#1082#1084']:'
          end
          object tlLLabel: TLabel
            Left = 3
            Top = 59
            Width = 92
            Height = 13
            Caption = #1044#1083#1080#1085#1072' '#1083#1080#1085#1080#1080' ['#1082#1084']:'
          end
          object tlUnLabel: TLabel
            Left = 3
            Top = 83
            Width = 131
            Height = 13
            Caption = #1053#1086#1084#1080#1085#1072#1083#1100#1085#1086#1077' '#1085#1072#1087#1088'-'#1077' ['#1082#1042']:'
          end
          object tlRoEdit: TEdit
            Left = 137
            Top = 7
            Width = 105
            Height = 21
            TabOrder = 0
          end
          object tlXoEdit: TEdit
            Left = 137
            Top = 31
            Width = 105
            Height = 21
            TabOrder = 1
          end
          object tlLEdit: TEdit
            Left = 137
            Top = 55
            Width = 105
            Height = 21
            TabOrder = 2
          end
          object tlUnEdit: TEdit
            Left = 137
            Top = 79
            Width = 105
            Height = 21
            TabOrder = 3
          end
        end
        object ReactorPage: TTabSheet
          Caption = 'ReactorPage'
          ImageIndex = 4
          object Bevel3: TBevel
            Left = 7
            Top = 145
            Width = 230
            Height = 5
            Shape = bsBottomLine
          end
          object Label2: TLabel
            Left = 3
            Top = 125
            Width = 110
            Height = 13
            Caption = #1058' '#1087#1086#1083#1085#1086#1077' ('#1085#1086#1088#1084') ['#1095#1072#1089']:'
          end
          object Label3: TLabel
            Left = 3
            Top = 101
            Width = 111
            Height = 13
            Caption = #1058' '#1088#1072#1073#1086#1090#1099' ('#1085#1086#1088#1084') ['#1095#1072#1089']:'
          end
          object Bevel4: TBevel
            Left = 7
            Top = 87
            Width = 230
            Height = 5
            Shape = bsBottomLine
          end
          object RctUnLbl: TLabel
            Left = 3
            Top = 11
            Width = 95
            Height = 13
            Caption = #1053#1086#1084'-'#1086#1077' '#1085#1072#1087#1088'-'#1077' ['#1082#1042']'
          end
          object RctrSnLbl: TLabel
            Left = 3
            Top = 35
            Width = 124
            Height = 13
            Caption = #1053#1086#1084'-'#1072#1103' '#1084#1086#1097#1085#1086#1089#1090#1100' ['#1082#1042#1040']:'
          end
          object RctrDPLbl: TLabel
            Left = 3
            Top = 59
            Width = 107
            Height = 13
            Caption = #1055#1086#1090#1077#1088#1080' '#1084#1086#1097'-'#1090#1080' ['#1082#1042#1090']:'
          end
          object RctrCHoursEdit: TEdit
            Left = 137
            Top = 121
            Width = 105
            Height = 21
            TabOrder = 4
          end
          object RctrFHoursEdit: TEdit
            Left = 137
            Top = 97
            Width = 105
            Height = 21
            TabOrder = 3
          end
          object RctrUnEdit: TEdit
            Left = 137
            Top = 7
            Width = 105
            Height = 21
            TabOrder = 0
          end
          object RctrSnEdit: TEdit
            Left = 137
            Top = 31
            Width = 105
            Height = 21
            TabOrder = 1
          end
          object RctrDPEdit: TEdit
            Left = 137
            Top = 55
            Width = 105
            Height = 21
            TabOrder = 2
          end
        end
      end
      object TPanel
        Left = 0
        Top = 0
        Width = 252
        Height = 32
        Align = alTop
        TabOrder = 1
        Visible = False
        object Label1: TLabel
          Left = 4
          Top = 9
          Width = 87
          Height = 13
          Caption = #1044#1072#1090#1072' '#1091#1089#1090#1072#1085#1086#1074#1082#1080' :'
        end
        object DateMEdit: TMaskEdit
          Left = 104
          Top = 5
          Width = 137
          Height = 21
          EditMask = '!99/99/0000 90:00:00;1;_'
          MaxLength = 19
          TabOrder = 0
          Text = '  .  .       :  :  '
        end
      end
    end
  end
  object plTransfms: TPanel [2]
    Left = 0
    Top = 0
    Width = 365
    Height = 595
    Align = alClient
    BevelOuter = bvLowered
    Caption = 'plTransfms'
    TabOrder = 0
    object tvTransfms: TTreeView
      Left = 1
      Top = 22
      Width = 363
      Height = 572
      Align = alClient
      BorderStyle = bsNone
      DragMode = dmAutomatic
      HideSelection = False
      Images = iImageList
      Indent = 19
      PopupMenu = PopupMenu1
      ReadOnly = True
      TabOrder = 0
      OnChange = tvTransfmsChange
      OnChanging = tvTransfmsChanging
      OnCollapsing = tvTransfmsCollapsing
      OnDeletion = tvTransfmsDeletion
      OnDragDrop = tvTransfmsDragDrop
      OnDragOver = tvTransfmsDragOver
      OnExpanding = tvTransfmsExpanding
    end
    object plTransfmsTitle: TPanel
      Left = 1
      Top = 1
      Width = 363
      Height = 21
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvNone
      Caption = #1055#1086#1076#1089#1090#1072#1085#1094#1080#1080
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
  end
  inherited MenuSAA: TMainMenu
    Left = 56
    Top = 48
  end
  inherited PopupMenu1: TPopupMenu
    Left = 88
    Top = 48
    object N3: TMenuItem [9]
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100'  ...'
      object N22: TMenuItem
        Action = New2PowerTransAction
      end
      object N32: TMenuItem
        Action = New3PowerTransAction
      end
      object N10: TMenuItem
        Caption = '-'
      end
      object N9: TMenuItem
        Action = NewIMeteringTransAction
      end
      object N8: TMenuItem
        Action = NewUMeteringTransAction
      end
      object N11: TMenuItem
        Caption = '-'
      end
      object N12: TMenuItem
        Action = NewTransmissionLineAction
      end
    end
    object N15: TMenuItem [10]
      Action = SetWorkTimeAction
    end
    object N14: TMenuItem [11]
      Action = CalcLossParamAction
    end
  end
  inherited alDefault: TActionList
    Left = 120
    Top = 48
    inherited iaMon: TAction
      ImageIndex = 36
      OnExecute = iaMonExecute
    end
    object NewPowerTransAction: TAction
      Category = 'TransformerMenu'
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1089#1080#1083#1086#1074#1086#1081' '#1090#1088#1072#1085'c'#1092#1086#1088#1084#1072#1090#1086#1088
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1085#1086#1074#1099#1081' '#1089#1080#1083#1086#1074#1086#1081' '#1090#1088#1072#1085'c'#1092#1086#1088#1084#1072#1090#1086#1088
      ImageIndex = 83
      OnExecute = NewPowerTransActionExecute
    end
    object New2PowerTransAction: TAction
      Category = 'TransformerMenu'
      Caption = '2-'#1093' '#1086#1073#1084#1086#1090#1086#1095#1085#1099#1081' '#1090#1088#1072#1089#1092#1086#1088#1084#1072#1090#1086#1088
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1085#1086#1074#1099#1081' 2-'#1093' '#1086#1073#1084#1086#1090#1086#1095#1085#1099#1081' '#1090#1088#1072#1089#1092#1086#1088#1084#1072#1090#1086#1088
      ImageIndex = 84
    end
    object New3PowerTransAction: TAction
      Category = 'TransformerMenu'
      Caption = '3-'#1093' '#1086#1073#1084#1086#1090#1086#1095#1085#1099#1081' '#1090#1088#1072#1089#1092#1086#1088#1084#1072#1090#1086#1088
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1085#1086#1074#1099#1081' 3-'#1093' '#1086#1073#1084#1086#1090#1086#1095#1085#1099#1081' '#1090#1088#1072#1089#1092#1086#1088#1084#1072#1090#1086#1088
      ImageIndex = 85
    end
    object NewMeteringTransAction: TAction
      Category = 'TransformerMenu'
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1080#1079#1084#1077#1088#1080#1090#1077#1083#1100#1085#1099#1081' '#1090#1088#1072#1085#1089#1092#1086#1088#1084#1072#1090#1086#1088
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1085#1086#1074#1099#1081' '#1080#1079#1084#1077#1088#1080#1090#1077#1083#1100#1085#1099#1081' '#1090#1088#1072#1085#1089#1092#1086#1088#1084#1072#1090#1086#1088
      ImageIndex = 80
      OnExecute = NewMeteringTransActionExecute
    end
    object NewIMeteringTransAction: TAction
      Category = 'TransformerMenu'
      Caption = #1048#1079#1084#1077#1088#1080#1090#1077#1083#1100#1085#1099#1081' '#1090#1088#1072#1085#1089#1092#1086#1088#1084#1072#1090#1086#1088' '#1090#1086#1082#1072
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1085#1086#1074#1099#1081' '#1080#1079#1084#1077#1088#1080#1090#1077#1083#1100#1085#1099#1081' '#1090#1088#1072#1085#1089#1092#1086#1088#1084#1072#1090#1086#1088' '#1090#1086#1082#1072
      ImageIndex = 81
    end
    object NewUMeteringTransAction: TAction
      Category = 'TransformerMenu'
      Caption = #1048#1079#1084#1077#1088#1080#1090#1077#1083#1100#1085#1099#1081' '#1090#1088#1072#1085#1089#1092#1086#1088#1084#1072#1090#1086#1088' '#1085#1072#1087#1088#1103#1078#1077#1085#1080#1103
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1085#1086#1074#1099#1081' '#1080#1079#1084#1077#1088#1080#1090#1077#1083#1100#1085#1099#1081' '#1090#1088#1072#1085#1089#1092#1086#1088#1084#1072#1090#1086#1088' '#1085#1072#1087#1088#1103#1078#1077#1085#1080#1103
      ImageIndex = 82
    end
    object NewLineAction: TAction
      Category = 'TransformerMenu'
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1083#1080#1085#1080#1102
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1085#1086#1074#1091#1102' '#1083#1080#1085#1080#1102
      ImageIndex = 86
      OnExecute = NewLineActionExecute
    end
    object NewTransmissionLineAction: TAction
      Category = 'TransformerMenu'
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1083#1080#1085#1080#1102' '#1087#1077#1088#1077#1076#1072#1095#1080
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1085#1086#1074#1091#1102' '#1083#1080#1085#1080#1102' '#1087#1077#1088#1077#1076#1077#1072#1095#1080
      ImageIndex = 86
    end
    object CalcLossParamAction: TAction
      Category = 'TransformerMenu'
      Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1088#1072#1089#1095#1105#1090#1072' '#1087#1086#1090#1077#1088#1100
      Enabled = False
      Hint = #1054#1087#1088#1077#1076#1077#1083#1080#1090#1100' '#1089#1087#1086#1089#1086#1073' '#1085#1072#1095#1080#1089#1083#1077#1085#1080#1103' '#1088#1072#1089#1093#1086#1076#1072' '#1076#1083#1103' '#1088#1072#1089#1095#1077#1090#1072' '#1087#1086#1090#1077#1088#1100
      ImageIndex = 88
      OnExecute = CalcLossParamActionExecute
    end
    object SetWorkTimeAction: TAction
      Category = 'TransformerMenu'
      Caption = #1047#1072#1076#1072#1090#1100' '#1074#1088#1077#1084#1103' '#1088#1072#1073#1086#1090#1099
      Hint = #1047#1072#1076#1072#1090#1100' '#1074#1088#1077#1084#1103' '#1088#1072#1073#1086#1090#1099' '#1090#1088#1072#1085#1089#1092#1086#1088#1084#1072#1090#1086#1088#1072
      ImageIndex = 87
      OnExecute = SetWorkTimeActionExecute
    end
    object aSpezPar: TAction
      Caption = 'aSpezPar'
      OnExecute = aSpezParExecute
    end
    object aBorderPar: TAction
      Caption = 'aBorderPar'
      OnExecute = aBorderParExecute
    end
    object NewReactorAction: TAction
      Category = 'TransformerMenu'
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1088#1077#1072#1082#1090#1086#1088
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1085#1086#1074#1099#1081' '#1088#1077#1072#1082#1090#1086#1088
      ImageIndex = 91
      OnExecute = NewReactorActionExecute
    end
    object NewReactorMenuAction: TAction
      Category = 'TransformerMenu'
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1088#1077#1072#1082#1090#1086#1088
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1088#1077#1072#1082#1090#1086#1088
      ImageIndex = 91
    end
  end
  inherited iImageList: TImageList
    Left = 152
    Top = 48
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
      0000000000000000000000000000000000000000000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF000000FF000000FF0000000000000000000000FF000000FF000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF0000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF0000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF0000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF00000000000000000000000000
      000000000000FF000000FF000000FF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      000000000000000000000000000000000000FF00000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      000000000000000000000000000000000000FF00000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      000000000000000000000000000000000000FF00000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF000000FF000000FF00000000000000FF00000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      84000000000000000000000000000000000000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008400
      00008400000084000000000000000000000000000000C6C6C600000000000000
      0000C6C6C6000000000000000000000000000000000000000000840000008400
      00008400000084000000000000000000000000000000C6C6C600000000000000
      0000C6C6C6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008400000000000000000000000000000000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000084000000840000000000
      00000000000084000000840000000000000000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000000000000000FF000000FF000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008400000000000000000000000000000000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000084000000000000000000
      00000000000000000000840000000000000000000000C6C6C600000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF00000000000000000000000000FF000000FF00000000000000000000000000
      0000FF000000FF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008400000000000000000000000000000000000000C6C6C600000000000000
      000000000000C6C6C60000000000000000000000000084000000000000000000
      00000000000000000000840000000000000000000000C6C6C600000000000000
      000000000000C6C6C600000000000000000000000000000000000000FF000000
      0000000000000000000000000000FF0000000000FF0000000000000000000000
      000000000000FF00000000000000000000000000000000000000000000000000
      00000000FF00000000000000FF000000000000000000FF00000000000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000000000000000000000000000000000000084848400848484000000
      0000C6C6C6000000000000000000000000000000000084000000000000000000
      0000000000000000000084000000000000000000000084848400848484000000
      0000C6C6C600000000000000000000000000000000000000FF00000000000000
      00000000000000000000FF00000000000000000000000000FF00000000000000
      00000000000000000000FF0000000000000000000000000000000000FF000000
      FF00000000000000000000000000FF000000FF00000000000000000000000000
      0000FF000000FF00000000000000000000000000000000000000000000000000
      00008400000000000000000000000000000000000000C6C6C600000000000000
      000000000000C6C6C60000000000000000000000000084000000000000000000
      00000000000000000000840000000000000000000000C6C6C600000000000000
      000000000000C6C6C6000000000000000000000000000000FF00000000000000
      00000000000000000000FF00000000000000000000000000FF00000000000000
      00000000000000000000FF0000000000000000000000000000000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF00000000000000000000000000000000000000000000000000
      00008400000000000000000000000000000000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000084000000000000000000
      00000000000000000000840000000000000000000000C6C6C600000000000000
      000000000000000000000000000000000000000000000000FF00000000000000
      00000000000000000000FF00000000000000000000000000FF00000000000000
      00000000000000000000FF00000000000000000000000000FF00000000000000
      00000000000000000000FF00000000000000000000000000FF00000000000000
      00000000000000000000FF000000000000000000000000000000000000000000
      00008400000000000000000000000000000000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000084000000000000000000
      00000000000000000000840000000000000000000000C6C6C600000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      0000000000000000000000000000FF0000000000FF0000000000000000000000
      000000000000FF0000000000000000000000000000000000FF00000000000000
      00000000000000000000FF00000000000000000000000000FF00000000000000
      00000000000000000000FF000000000000000000000000000000000000008400
      00008400000084000000000000000000000000000000C6C6C600000000000000
      0000000000000000000000000000000000008400000084000000840000000000
      00000000000084000000840000008400000000000000C6C6C600000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF00000000000000000000000000FF000000FF00000000000000000000000000
      0000FF000000FF0000000000000000000000000000000000FF00000000000000
      00000000000000000000FF00000000000000000000000000FF00000000000000
      00000000000000000000FF000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600000000000000
      000000000000C6C6C60000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600000000000000
      000000000000C6C6C60000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000000000000000FF000000FF000000FF00
      00000000000000000000000000000000000000000000000000000000FF000000
      0000000000000000000000000000FF0000000000FF0000000000000000000000
      000000000000FF000000000000000000000000000000C6C6C600000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C6000000000000000000000000000000000000000000C6C6C600000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF00000000000000000000000000FF000000FF00000000000000000000000000
      0000FF000000FF00000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000000000000000FF000000FF000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
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
      FFFF000000000000FE7F000000000000F18F000000000000EFF7000000000000
      EFF7000000000000EFF7000000000000DFFB0000000000000078000000000000
      EF7F000000000000EF7F000000000000EF7F000000000000F17F000000000000
      FE7F000000000000FFFF000000000000FFFFFFFFFFFFFFFF800F800FFFFFFE7F
      FF27FF27FFFFF99FE333C333FFFFFBDFF73B993BF18FF7EFF73BBD3BCE73F7EF
      F733BD33DE7BF18FF707BD07BDBDC813F733BD33BDBDDE7BF73BBD3BBDBDBDBD
      F73BBD3BDE7BBDBDE33B183BCE73BDBDFF23FF23F18FDE7B800F800FFFFFCE73
      FF7FFF7FFFFFF18FFFFFFFFFFFFFFFFF003FE7FFFC1FFC1F001FE7FFF007F007
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
    Left = 26
    Top = 48
    Bitmap = {
      494C01015C005E00040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000008001000001002000000000000080
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
      00000000000000000000FFFFFF00FFFFFF000000000000000000000000000000
      FF00000084000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00008080000080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00008080000080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B7B7B00000000000000
      000000000000FFFFFF00FFFFFF00000000000000000000000000000000000000
      FF00000084000000FF0000000000008484000000000000000000000000000000
      0000000000000000000000000000000000008080800000000000008080000000
      0000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800000000000008080000000
      0000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007B7B7B0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      FF00000084000000FF0000848400008484000000000000000000000000000000
      0000000000000000000000000000000000008080800000000000008080000000
      0000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800000000000008080000000
      0000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      FF00000084000000FF0000848400008484000000000000000000000000000000
      0000000000000000000000000000000000008080800000000000008080000000
      0000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800000000000008080000000
      0000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF000000FF00000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      FF00000084000000FF0000848400000000000000000000000000000000000000
      0000000000000000000000000000000000008080800000000000008080000000
      0000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800000000000008080000000
      0000808080000000000000000000000000000000000000000000000000000000
      0000FF000000FF000000FF0000000000000000000000FF000000FF000000FF00
      000000000000000000000000000000000000000000007B7B7B00000000000000
      000000000000FFFFFF00000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008080800000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF00000000000000000000000000000000000000000000007B7B7B000000
      0000FFFFFF00000000007B7B7B00000000000000000000000000000084000000
      8400000084000000840000008400000000000000000000000000000000000000
      0000000000000000000080808000808080000000000000000000000000000000
      00000000000000000000C0DCC000808080000000000000000000000000000000
      0000000000000000000080808000808080000000000000000000000000000000
      00000000000000000000C0DCC00080808000000000000000000000000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF0000000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B0000000000000000000000000000848400008484000084
      8400000000000000000000000000000000000000000080000000800000008000
      00008000000000000000C0C0C000000000008080800000000000C0DCC000C0DC
      C000C0DCC000C0DCC000C0DCC000808080008000000080000000800000008000
      00008000000080000000C0C0C000000000008080800000000000C0DCC000C0DC
      C000C0DCC000C0DCC000C0DCC00080808000000000000000000000000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF0000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000084840000848400008484000000
      0000000000000000000000000000000000008000000080000000000000000000
      000000000000800000008000000080808000C0DCC000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000C0C0C000808080008000000080000000000000000000
      000000000000800000008000000080808000C0DCC000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000C0C0C000808080000000000000000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000008484000084840000848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008000000080000000000000000000000000000000000000000000
      0000000000000000000000000000000000008000000080000000000000000000
      0000000000008000000080000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF00000000000000000000000000
      000000000000FF000000FF000000FF0000000000000000000000000000000000
      0000000000000000000000848400008484000084840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      0000800000008000000080000000000000000000000000000000000000000000
      0000000000000000000000000000000000008000000080000000000000000000
      0000000000008000000080000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      000000000000000000000000000000000000FF00000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000084840000848400008484000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000800000008000
      0000800000008000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008000000080000000800000008000
      0000800000008000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      000000000000000000000000000000000000FF00000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000848400000000000000000000000000000000007B7B
      7B00000000007B7B7B0000000000000000008000000080000000800000008000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008000000080000000000000000000
      0000000000008000000080000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      000000000000000000000000000000000000FF00000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B00000000007B7B7B0000000000000000008000000080000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008000000080000000000000000000
      0000000000008000000080000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF000000FF000000FF00000000000000FF00000000000000000000000000
      0000000000000000000000000000000000000000000000000000008484000000
      00000000000000000000000000007B7B7B000000000000000000000000007B7B
      7B00000000007B7B7B0000000000000000008000000080000000000000000000
      0000000000008000000080000000000000000000000000000000000000000000
      0000000000000000000000000000000000008000000080000000000000000000
      0000000000008000000080000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF000000FF00000000000000000000000000
      0000000000000000000000000000000000000000000000000000008484000084
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000800000008000
      0000800000008000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008000000080000000800000008000
      0000800000008000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B0000000000000000000000000000000000000000007B7B
      7B00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      000000000000000000007B7B7B00FFFFFF0000000000FFFFFF007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF007B7B7B00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000000000000000FF000000FF000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF0000000000000000000000000000000000000000000000FF000000
      FF00000000000000000000000000FF000000FF00000000000000000000000000
      0000FF000000FF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      840000000000000000000000000000000000000000007B7B7B00000000007B7B
      7B00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF007B7B7B00000000007B7B7B0000000000000000000000FF000000
      0000000000000000000000000000FF0000000000FF0000000000000000000000
      000000000000FF00000000000000000000000000000000000000000000000000
      00000000FF00000000000000FF000000000000000000FF00000000000000FF00
      0000000000000000000000000000000000008484840084848400848484008484
      8400848484008484840084848400000000000000000000000000000000008484
      840000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000000000000000000000000FF00000000000000
      00000000000000000000FF00000000000000000000000000FF00000000000000
      00000000000000000000FF0000000000000000000000000000000000FF000000
      FF00000000000000000000000000FF000000FF00000000000000000000000000
      0000FF000000FF00000000000000000000000000000000000000000000000000
      00000000000000000000848484000000000000FFFF0000848400000000000000
      00000084840000000000000000000000000000000000000000007B7B7B000000
      00007B7B7B00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF007B7B7B00000000007B7B7B0000000000000000000000FF00000000000000
      00000000000000000000FF00000000000000000000000000FF00000000000000
      00000000000000000000FF0000000000000000000000000000000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484000084
      840000000000000000008484840084848400000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000FF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000000000000000000000000FF00000000000000
      00000000000000000000FF00000000000000000000000000FF00000000000000
      00000000000000000000FF00000000000000000000000000FF00000000000000
      00000000000000000000FF00000000000000000000000000FF00000000000000
      00000000000000000000FF000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      000000000000000000000000000000000000000000007B7B7B00000000007B7B
      7B00FFFFFF00FFFFFF0000000000FFFFFF000000FF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF007B7B7B00000000007B7B7B0000000000000000000000FF000000
      0000000000000000000000000000FF0000000000FF0000000000000000000000
      000000000000FF0000000000000000000000000000000000FF00000000000000
      00000000000000000000FF00000000000000000000000000FF00000000000000
      00000000000000000000FF000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000FFFFFF00FFFFFF000000FF00FFFFFF00FFFFFF000000
      0000FFFFFF0000000000000000000000000000000000000000000000FF000000
      FF00000000000000000000000000FF000000FF00000000000000000000000000
      0000FF000000FF0000000000000000000000000000000000FF00000000000000
      00000000000000000000FF00000000000000000000000000FF00000000000000
      00000000000000000000FF0000000000000000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF000000FF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000000000000000FF000000FF000000FF00
      00000000000000000000000000000000000000000000000000000000FF000000
      0000000000000000000000000000FF0000000000FF0000000000000000000000
      000000000000FF000000000000000000000000000000C6C6C600000000000000
      0000848484008484840084848400848484008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007B7B7B00FFFFFF000000FF00FFFFFF007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF00000000000000000000000000FF000000FF00000000000000000000000000
      0000FF000000FF000000000000000000000000000000C6C6C600C6C6C6000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B7B000000
      000000000000000000007B7B7B000000000000000000000000007B7B7B000000
      000000000000000000007B7B7B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000000000000000FF000000FF000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF00000000000000
      0000FF000000FF000000000000000000000000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      84000000000000000000000000000000000000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      84000000000000000000000000000000000000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF0000000000000000000000FF00FF00
      00000000000000000000FF000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF00000000000000000000000000FF0000000000
      FF00000000000000000000000000FF0000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600000000000000
      0000C6C6C6000000000000000000000000000000000000000000000000008400
      00008400000084000000000000000000000000000000C6C6C600000000000000
      0000C6C6C6000000000000000000000000000000000000000000840000008400
      00008400000084000000000000000000000000000000C6C6C600000000000000
      0000C6C6C6000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF00000000000000000000000000FF0000000000
      FF00000000000000000000000000FF0000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008400000000000000000000000000000000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000084000000840000000000
      00000000000084000000840000000000000000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF0000000000000000000000FF00FF00
      00000000000000000000FF000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008400000000000000000000000000000000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000084000000000000000000
      00000000000000000000840000000000000000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF00000000000000
      0000FF000000FF00000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600000000000000
      000000000000C6C6C60000000000000000000000000000000000000000000000
      00008400000000000000000000000000000000000000C6C6C600000000000000
      000000000000C6C6C60000000000000000000000000084000000000000000000
      00000000000000000000840000000000000000000000C6C6C600000000000000
      000000000000C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400848484000000
      0000C6C6C6000000000000000000000000000000000000000000000000000000
      0000840000000000000000000000000000000000000084848400848484000000
      0000C6C6C6000000000000000000000000000000000084000000000000000000
      0000000000000000000084000000000000000000000084848400848484000000
      0000C6C6C6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600000000000000
      000000000000C6C6C60000000000000000000000000000000000000000000000
      00008400000000000000000000000000000000000000C6C6C600000000000000
      000000000000C6C6C60000000000000000000000000084000000000000000000
      00000000000000000000840000000000000000000000C6C6C600000000000000
      000000000000C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008400000000000000000000000000000000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000084000000000000000000
      00000000000000000000840000000000000000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008400000000000000000000000000000000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000084000000000000000000
      00000000000000000000840000000000000000000000C6C6C600000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      0000000000000000000000000000FF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000008400
      00008400000084000000000000000000000000000000C6C6C600000000000000
      0000000000000000000000000000000000008400000084000000840000000000
      00000000000084000000840000008400000000000000C6C6C600000000000000
      000000000000000000000000000000000000000000000000FF00000000000000
      000000000000000000000000000000000000FF00000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600000000000000
      000000000000C6C6C60000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600000000000000
      000000000000C6C6C60000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600000000000000
      000000000000C6C6C60000000000000000000000FF0000000000000000000000
      0000FF0000000000FF00000000000000000000000000FF000000000000000000
      00000000000000000000000000000000000000000000C6C6C600000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C6000000000000000000000000000000000000000000C6C6C600000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C6000000000000000000000000000000000000000000C6C6C600000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C600000000000000000000000000000000000000FF0000000000000000000000
      0000FF0000000000FF00000000000000000000000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C60000000000000000000000
      000000000000000000000000000000000000000000000000FF00000000000000
      00000000FF00FF0000000000000000000000FF00000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000000000000000FF000000FF0000000000000000000000000000000000
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
      000000000000000000000000000000000000000000008484840000000000CECE
      CE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECE
      CE000000000000000000000000000000000084848400000000000063CE000063
      CE000063CE000063CE000063CE000063CE000063CE000063CE0000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008484840000000000CECE
      CE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00A5A5A5000000000000000000000000008484840000000000009CCE00009C
      CE00009CCE00009CCE00009CCE00009CCE00009CCE000063CE0000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C60000000000000000000000000000000000000000008484840000000000CECE
      CE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CECE
      CE0000000000FFFFFF00FFFFFF00000000008484840000000000009CCE00009C
      CE00009CCE00009CCE00009CCE00009CCE00009CCE000063CE0000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C600000000000000000000000000000000000000000000000000000000004242
      4200CECECE00CECECE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008484
      840000000000FFFFFF00FFFFFF00000000008484840000000000009CFF00009C
      CE00009CCE00009CCE00009CCE00009CCE00009CCE000063CE0000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000000000000000C6C6
      C60000000000000000000000000000000000000000000000000000000000C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400000000004242
      42000000000042424200CECECE00CECECE00FFFFFF00FFFFFF00CECECE000000
      0000000000000000000000000000000000008484840000000000009CFF00009C
      CE00009CCE00009CCE00009CCE00009CCE00009CCE000063CE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840000000000000000000000000084848400000000000000
      00000000000000000000000000000000000000000000C6C6C600848484000000
      00000000000000000000000000000000000000000000C6C6C600000000000000
      000000000000000000000000000000000000000000008484840000000000CECE
      CE00E7E7E700424242000000000042424200CECECE00CECECE00424242000000
      0000E7E7E7000000000000000000000000008484840000000000009CFF00009C
      CE00009CCE00009CCE00009CCE00009CCE00009CCE00009CCE000063CE000063
      CE000063CE000063CE0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600848484000000
      00000000000000000000C6C6C6000000000000000000C6C6C600000000000000
      000000000000000000000000000000000000000000008484840000000000CECE
      CE00FFFFFF00FFFFFF00E7E7E70000000000000000000000000000000000E7E7
      E700FFFFFF000000000000000000000000008484840000000000009CFF00009C
      CE000063CE000063CE000063CE000063CE000063CE000063CE000063CE000063
      CE00009CCE00009CCE000000000000000000000000000000000000000000C6C6
      C60000000000000000000000000000000000C6C6C60000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600848484000000
      00000000000000000000C6C6C6000000000000000000C6C6C600000000000000
      000000000000000000000000000000000000000000008484840000000000CECE
      CE00E7E7E700424242000000000042424200E7E7E700E7E7E700424242000000
      0000000000000000000000000000000000008484840000000000009CFF000063
      CE0000639C0000639C0000639C0000639C0000639C0000639C0000639C000063
      9C000063CE00009CCE000000000000000000000000000000000000000000C6C6
      C60000000000000000000000000000000000C6C6C60000000000000000000000
      0000000000000000000000000000000000000000000000000000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400000000004242
      42000000000042424200CECECE00E7E7E700FFFFFF00FFFFFF00E7E7E7008484
      840000000000FFFFFF00FFFFFF000000000084848400000000000063CE000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000063CE0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C6008484840000000000000000000000000000000000C6C6C600848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000CECECE00E7E7E700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CECE
      CE0000000000FFFFFF00FFFFFF0000000000848484000000000000639C000000
      0000F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7
      F7000000000000639C0000000000000000000000000000000000000000000000
      0000000000000000000000000000848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008484840000000000CECE
      CE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CECECE00CECE
      CE00A5A5A5000000000000000000000000000000000084848400000000000000
      0000E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700CECE
      CE00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400000000000000000000000000000000000000000084848400000000000000
      000000000000000000000000000000000000000000008484840000000000CECE
      CE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CECECE000000
      0000000000000000000000000000000000000000000000000000848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400000000000000000000000000000000000000000084848400000000000000
      000000000000000000000000000000000000000000008484840000000000CECE
      CE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE000000
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
      0000000000000000000000000000A5A5A5008484840084848400848484008484
      840084848400A5A5A50000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000009CCE009CCEFF009CCE
      FF009CCEFF009CCEFF009CCEFF009CCEFF009CCEFF009CCEFF009CCEFF009CCE
      FF00009CCE0000000000000000000000000000000000009CCE009CCEFF009CCE
      FF009CCEFF009CCEFF009CCEFF009CCEFF009CCEFF009CCEFF009CCEFF009CCE
      FF00009CCE000000000000000000000000000000000000000000000000000000
      00000000000000000000A5A5A500A5A5A5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009CCEFF009CCEFF00FFFF
      FF00FFFFFF009CCEFF009CCEFF009CCEFF009CCEFF009CCEFF009CCEFF009CCE
      FF009CCEFF00000000000000000000000000000000009CCEFF009CCEFF00FFFF
      FF00FFFFFF009CCEFF009CCEFF009CCEFF009CCEFF009CCEFF009CCEFF009CCE
      FF009CCEFF000000000000000000000000000000000000000000000000000000
      00000000000000000000A5A5A50000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A5A5A5000000
      000000000000000000000000000000000000000000009CCEFF00FFFFFF0063CE
      FF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF009CCE
      FF009CCEFF00000000000000000000000000000000009CCEFF00FFFFFF0063CE
      FF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF009CCE
      FF009CCEFF000000000000000000000000000000000000000000000000000000
      00000000000000000000A5A5A50000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      00000000000000000000A5A5A5008484840000000000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000063CEFF00FFFFFF0063CE
      FF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CE
      FF0063CEFF000000000000000000000000000000000063CEFF00FFFFFF0063CE
      FF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CE
      FF0063CEFF000000000000000000000000000000000000000000A5A5A500A5A5
      A500A5A5A500A5A5A500A5A5A5000000000084848400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      000000000000A5A5A50063CEFF000000000000000000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000063CEFF00FFFFFF0063CE
      FF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CE
      FF0063CEFF000000000000000000000000000000000000000000000000000000
      0000000000000000000063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CE
      FF0063CEFF0000000000000000000000000000000000A5A5A500A5A5A5000000
      0000000000000000000000000000000000000000000084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000000000000000000000000000000000000A5A5
      A50063CEFF0063CEFF0000FFFF00000000000000000000000000FFFFFF000000
      0000000000000000000000000000000000000000000063CEFF00FFFFFF0063CE
      FF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CE
      FF0063CEFF00000000000000000000000000000000009C9C9C009C9C9C009C9C
      9C009C9C9C000000000063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CE
      FF0063CEFF0000000000000000000000000000000000A5A5A50000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000084848400FFFF
      FF00FFFFFF00FFFFFF000000000000000000000000000000000000000000CEFF
      FF0000FFFF0000FFFF0000FFFF00000000000000000084848400FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000063CEFF0063CEFF0063CEFF0063CE
      FF0063CEFF000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000063CE
      FF0063CEFF0000000000000000000000000000000000A5A5A50000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000084848400FFFF
      FF00FFFFFF00FFFFFF000000000000000000000000000000000000000000CEFF
      FF00FFFFFF0000FFFF0000FFFF00000000000000000084848400FFFFFF000000
      000000000000000000000000000000000000000000009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C000000000063CEFF0063CEFF0063CEFF0063CE
      FF00009CCE0000000000000000000000000000000000DEDEDE00DEDEDE000000
      00009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C000000000063CE
      FF00009CCE0000000000000000000000000000000000A5A5A50000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000084848400FFFF
      FF0000000000000000000000000000000000000000000000000000000000A5A5
      A500CEFFFF00FFFFFF0000FFFF00000000000000000000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A5A5A50000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000084848400FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000A5A5A500CEFFFF000000000000000000FFFFFF00FFFFFF000000
      00000000000000000000000000000000000000000000DEDEDE00DEDEDE00DEDE
      DE00DEDEDE00DEDEDE00DEDEDE00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF000000
      0000DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00000000000000
      00000000000000000000000000000000000000000000A5A5A50000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000A5A5A5008484840000000000FFFFFF00FFFFFF000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      00000000000000000000000000000000000000000000A5A5A50000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A5A5A5000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      00000000000000000000000000000000000000000000A5A5A50000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      00000000000000000000000000000000000000000000A5A5A50000000000FFFF
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
      000000000000000000000000000000000000000000000000000000009C00CE9C
      FF000000CE000000CE000000CE00000000007373730084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      9C00CE9CFF000000CE000000CE000000CE000000000073737300848484000000
      000000000000000000000000000000000000000000005A5A5A00D6D6D600D6D6
      D600D6D6D600A5A5A500A5A5A500D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D600000000000000000000000000000000000000
      0000F7F7F700CECECE00CECECE00CECECE00CECECE00CECECE00949494009494
      9400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000009C00CE9CFF00CE9CFF000000CE000000CE0010101000737373008484
      840000000000000000000000000000000000000000005A5A5A00D6D6D600D6D6
      D600A5A5A500A5A5A500B5B5B500B5B5B500B5B5B500B5B5B500B5B5B500B5B5
      B500B5B5B500B5B5B500B5B5B500000000000000000000000000000000000000
      0000A5A5A500B5B5B500CECECE00CECECE00CECECE00B5B5B500424242000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000009C00CE9CFF00737373001010100000000000000000007373
      7300848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000002121210063636300636363006363630021212100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000A5A5A5000000000000000000A5A5A5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF000000FF000000009C0010101000F7F7F70000000000000000000000
      000073737300000000000000000000000000000000005A5A5A00FFFFFF00D6D6
      D600000000000000000000000000000000000000000000000000000000000000
      00008484840084848400B5B5B5000000000000000000B5B5B500A5A5A500A5A5
      A500A5A5A500A5A5A500A5A5A500A5A5A500A5A5A500A5A5A500A5A5A500A5A5
      A500A5A5A5007373730000000000000000000000000000000000A5A5A5000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF0000FFFFFF00FFFFFF0000009C000000000000000000000000000000
      0000101010009C639C000000000000000000000000005A5A5A00D6D6D6000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084848400B5B5B5000000000000000000DEDEDE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000DEDEDE00848484000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF0000FFFFFF00008400000084000000000000F7F7F700F7F7F7000000
      0000101010007373730000000000000000000000000000000000000000000000
      0000000000006363630063636300636363006363630063636300636363000000
      00000000000000000000000000000000000000000000DEDEDE0000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000DEDEDE0084848400000000000000000000000000A5A5A500FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A5A5A5000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF0000FFFFFF000084000000FF000000000000000000009C639C009C63
      9C00000000001010100000000000000000000000000063636300000000000000
      000000000000E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E7000000
      00000000000000000000636363000000000000000000DEDEDE0000000000FFFF
      FF00FFFFFF0084000000840000008400000084000000FFFFFF00FFFFFF000000
      0000DEDEDE008484840000000000000000000000000084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF0000FFFFFF000084000000FF00000084000000000000000000000000
      000000000000101010009C639C00000000000000000000000000000000000000
      000000000000FFCECE00FF633100FF9C6300FFFFFF00FF633100FF9C63000000
      00000000000000000000000000000000000000000000DEDEDE0000000000FFFF
      FF00FFFFFF0084000000FF000000FF00000084000000FFFFFF00FFFFFF000000
      0000DEDEDE008484840000000000000000000000000084848400FFFFFF00FFFF
      FF0000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF0000FFFFFF000084000000FF000000FF000000840000000000000000
      0000000000001010100073737300000000000000000000000000000000000000
      000000000000FFCECE00FF633100FF9C6300FFFFFF00FF633100FF9C63000000
      00000000000000000000000000000000000000000000DEDEDE0000000000FFFF
      FF00FFFFFF00FF313100FFEFCE00FF00000084000000FFFFFF00FFFFFF000000
      0000DEDEDE0084848400000000000000000000000000A5A5A50000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A5A5A5000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF0000FFFFFF000084000000FF000000FF000000FF000000FF00000084
      0000737373001010100073737300000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      00000000000000000000000000000000000000000000DEDEDE0000000000FFFF
      FF00FFFFFF00FF313100FF3131008400000084000000FFFFFF00FFFFFF000000
      0000DEDEDE00848484000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF0000FFFFFF000084000000FF000000FF000000FF000000FF000000FF
      00000084000000000000FFFFFF00000000000000000000000000000000000000
      000000000000FFCECE00FF633100FF9C6300FFFFFF00FF633100FF9C63000000
      00000000000000000000000000000000000000000000DEDEDE0000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000DEDEDE008484840000000000000000000000000000000000A5A5A5000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000A5A5A500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF0000FFFFFF0000840000008400000084000000840000008400000084
      00000084000000840000FFFFFF00000000000000000000000000000000000000
      000000000000D6D6D600FF633100FF9C6300FFFFFF00FF633100FF9C63000000
      00000000000000000000000000000000000000000000DEDEDE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000DEDEDE008484840000000000000000000000000000000000000000000000
      0000848484000000000000000000848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000000000000000D6D6D600FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      00000000000000000000000000000000000000000000DEDEDE00A5A5A500A5A5
      A500A5A5A500A5A5A500A5A5A500A5A5A500A5A5A500A5A5A500A5A5A500A5A5
      A500CECECE008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000DEDEDE00DEDE
      DE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDE
      DE00DEDEDE00A5A5A50000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000A5A5A5000000000000000000A5A5A5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000A5A5A5000000000000000000A5A5A5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000A5A5A5000000000000000000A5A5A5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000A5A5A5000000000000000000A5A5A5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A5A5A5000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000A5A5A5000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000A5A5A5000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000A5A5A5000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000084848400000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF0000000000000000000000000000000000FFFFFF0000000000000000000000
      00000000000000000000000000000000000000000000A5A5A500FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00A5A5A5000000
      00000000000000000000000000000000000000000000A5A5A500FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00A5A5A5000000
      00000000000000000000000000000000000000000000A5A5A500FFFFFF00FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00A5A5A5000000
      00000000000000000000000000000000000000000000A5A5A500FFFFFF000000
      00000000000000000000000000000000000000000000FFFFFF00A5A5A5000000
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
      00000000000000000000000000000000000000000000A5A5A500000000000000
      000000000000FFFFFF00FFFFFF000000000000000000FFFFFF00A5A5A5000000
      00000000000000000000000000000000000000000000A5A5A50000000000FFFF
      FF000000000000000000000000000000000000000000FFFFFF00A5A5A5000000
      00000000000000000000000000000000000000000000A5A5A500FFFFFF000000
      0000FFFFFF0000000000FFFFFF0000000000FFFFFF00FFFFFF00A5A5A5000000
      00000000000000000000000000000000000000000000A5A5A500FFFFFF00FFFF
      FF0000000000FFFFFF000000000000000000FFFFFF00FFFFFF00A5A5A5000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF0000000000FFFFFF00FFFFFF0000000000FFFFFF0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00000000000000000000000000FFFFFF0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF0000000000FFFFFF000000000000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000A5A5A5000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000A5A5A500000000000000
      0000000000000000000000000000000000000000000000000000A5A5A5000000
      0000FFFFFF00FFFFFF0000000000FFFFFF0000000000A5A5A500000000000000
      0000000000000000000000000000000000000000000000000000A5A5A5000000
      0000FFFFFF0000000000FFFFFF00FFFFFF0000000000A5A5A500000000000000
      0000000000000000000000000000000000000000000000000000A5A5A5000000
      0000FFFFFF000000000000000000FFFFFF0000000000A5A5A500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848484000000000000000000848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848484000000000000000000848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084848400EFEFEF00EFEFEF00848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000A5A5A5000000000000000000A5A5A5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000A5A5A5000000000000000000A5A5A5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000A5A5A5000000000000000000A5A5A5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000A5A5A5000000000000000000A5A5A5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A5A5A5000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000A5A5A5000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000A5A5A5000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000A5A5A5000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF000000000000000000FFFFFF00FFFFFF0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000084848400000000000000
      00000000000000000000000000000000000000000000A5A5A500FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A5A5A5000000
      00000000000000000000000000000000000000000000A5A5A500FFFFFF00FFFF
      FF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFFFF00A5A5A5000000
      00000000000000000000000000000000000000000000A5A5A500FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A5A5A5000000
      00000000000000000000000000000000000000000000A5A5A500FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00000000000000000084848400FFFFFF00A5A5A5000000
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
      00000000000000000000000000000000000000000000A5A5A50000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A5A5A5000000
      00000000000000000000000000000000000000000000A5A5A50000000000FFFF
      FF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFFFF00A5A5A5000000
      00000000000000000000000000000000000000000000A5A5A50000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A5A5A5000000
      00000000000000000000000000000000000000000000A5A5A500000000000000
      00000000000084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF00A5A5A5000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF000000000000000000FFFFFF00FFFFFF0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000A5A5A5000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000A5A5A500000000000000
      0000000000000000000000000000000000000000000000000000A5A5A5000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000A5A5A500000000000000
      0000000000000000000000000000000000000000000000000000A5A5A5000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000A5A5A500000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000A5A5A500000000000000
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
      00000000000000000000FFFF0000FFFF3100FFFF310000000000000000000000
      0000FFFF0000FFFF310000000000000000000000000000000000000000007373
      7300737373007373730073737300737373007373730073737300737373007373
      7300737373007373730073737300000000000000000073737300737373007373
      7300737373007373730073737300737373007373730073737300737373007373
      7300737373000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FF00003163
      000000000000FFFF000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000073737300000000000000000073737300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FF000000FF000000FF000000FF000000FF
      000031630000000000000000000000000000000000000000000000000000FFFF
      0000FFFF0000FFFF0000FFFF0000FFEFCE00FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000000000007373730000000000000000007373730000000000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFEFCE00FFFF0000FFFF0000FFFF
      0000FFFF00000000000000000000000000000000000000000000000000000000
      0000848484008484840084848400848484008484840084848400848484000000
      000000000000000000000000000000000000000000000000000000000000FFCE
      6300FFCE9C00000000000000000000FF000000FF000000FF000000FF000000FF
      000031630000000000000000000000000000000000000000000000000000FFFF
      0000FFFF3100FFFF0000FFEFCE0000000000FFEFCE00FFFF3100FFFF3100FFFF
      0000FFFF0000000000007373730000000000000000007373730000000000FFFF
      0000FFFF0000FFFF3100FFFF3100FFEFCE0000000000FFEFCE00FFFF0000FFFF
      3100FFFF00000000000000000000000000000000000000000000000000000000
      0000848484000000000000000000000000000808080000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF9C
      6300FF9C6300000000000000000000000000000000000000000000FF00003163
      000000000000FFFF00000000000000000000000000000000000000000000FFFF
      0000FFFF0000FFEFCE000000000000000000FFEFCE00FFEFCE00FFEFCE00FFEF
      CE00FFFF0000000000007373730000000000000000007373730000000000FFFF
      0000FFEFCE00FFEFCE00FFEFCE00FFEFCE000000000000000000FFEFCE00FFFF
      0000FFFF00000000000000000000000000000000000000000000000000000000
      00008484840000000000FFFFFF00FFFFFF00FF9C0000FFCE9C00FFFFFF000000
      000000000000000000000000000000000000000000000000000000000000FF9C
      6300FF9C630000000000FFFFCE00FFFFCE00FFFF9C0000000000000000000000
      0000FFFF0000FFFF31000000000000000000000000000000000000000000FFFF
      0000FFEFCE000000000031CEFF00009CCE000000000000000000000000000000
      0000FFEFCE00000000007373730000000000000000007373730000000000FFEF
      CE0000000000000000000000000000000000009CCE0031CEFF0000000000FFEF
      CE00FFFF00000000000000000000000000000000000000000000000000000000
      00008484840000000000FFFFFF00F7F7F700CE9C0000FFCE9C00F7FFFF000000
      00000000000000000000000000000000000000000000FF00000000000000FF9C
      6300FF9C63000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFEF
      CE000000000031CEFF0031CEFF0031CEFF0031CEFF0031CEFF0031CEFF000000
      0000FFEFCE00000000007373730000000000000000007373730000000000FFEF
      CE000000000031CEFF0031CEFF0031CEFF0031CEFF0031CEFF0031CEFF000000
      0000FFEFCE000000000000000000000000000000000000000000000000000000
      00008484840000000000FFFFFF00FFFFFF00CE9C0000FFCE9C00FFFFFF000000
      00000000000000000000000000000000000000000000FF00000000000000FFCE
      6300FF9C6300FF9C6300FF9C6300FF9C6300FF9C6300FF9C6300FF9C63000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      0000FFEFCE000000000031CEFF00009CCE000000000000000000000000000000
      0000FFEFCE00000000007373730000000000000000007373730000000000FFEF
      CE0000000000000000000000000000000000009CCE0031CEFF0000000000FFEF
      CE00FFFF00000000000000000000000000000000000000000000000000000000
      00008484840000000000FFCE3100FFCE3100FF9C0000FF9C0000CE9C00000000
      00000000000000000000000000000000000000000000FF00000000000000FFFF
      3100FFCE6300FF9C6300FF9C6300FF9C6300FF9C6300FF9C6300FF9C63000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      0000FFFF0000FFEFCE000000000000000000FFEFCE00FFEFCE00FFEFCE00FFEF
      CE00FFFF3100000000007373730000000000000000007373730000000000FFFF
      3100FFEFCE00FFEFCE00FFEFCE00FFEFCE000000000000000000FFEFCE00FFFF
      0000FFFF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      0000FFFF0000FFFF0000FFEFCE0000000000FFEFCE00FFFF3100FFFF3100FFFF
      3100FFFF3100000000007373730000000000000000007373730000000000FFFF
      3100FFFF3100FFFF3100FFFF3100FFEFCE0000000000FFEFCE00FFFF0000FFFF
      0000FFFF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF00000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      0000FFFF0000FFFF0000FFFF0000FFEFCE00FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000000000007373730000000000000000007373730000000000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFEFCE00FFFF0000FFFF0000FFFF
      0000FFFF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009C3131009C3100008400
      0000840000008400000084000000840000009C00000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000949494000808080000FFFF00009CCE00009CCE0000639C00080808009494
      9400000000000000000000000000000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400000000000000000000000000000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009494940039393900009CCE0000FFFF00009CCE00009CCE00080808009494
      9400000000000000000000000000000000000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848484000000000000000000000000000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009494940008080800CEFFFF00009CCE0008080800949494000000
      000000000000000000000000000000000000848484000000000063FFFF00CEFF
      FF00CEFFFF00CEFFFF00CEFFFF00CEFFFF00CEFFFF00CEFFFF00CEFFFF00CEFF
      FF0000000000848484000000000000000000848484000000000063CEFF00CEFF
      FF00CEFFFF00CEFFFF00CEFFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FF
      FF0000000000000000000000000000000000000000000000000031639C000063
      9C00000000003939390000000000000000000000000000000000FFFFFF00CECE
      CE000000000031639C0000000000000000000000000000000000000000000000
      0000000000009494940008080800CEFFFF00009CCE0008080800949494000000
      000000000000000000000000000000000000848484000000000063636300F7FF
      FF00CEFFFF00CEFFFF00CEFFFF00CEFFFF00CEFFFF00CEFFFF00CEFFFF00CEFF
      FF00CEFFFF000000000084848400000000008484840000000000CEFFFF009C9C
      9C00000000004A4A4A0031CEFF00CEFFFF00CEFFFF00CEFFFF00CEFFFF00CEFF
      FF00000000000000000000000000000000000000000000000000009CCE00009C
      CE00000000003939390000000000000000000000000000000000FFFFFF00CECE
      CE0000000000009CCE0000000000000000000000000000000000000000000000
      0000000000009494940008080800CEFFFF00009CCE0008080800949494000000
      000000000000000000000000000000000000848484000000000000316300F7FF
      FF009CCEFF009CCEFF009CCEFF009CCEFF009CCEFF009CCEFF009CCEFF009CCE
      FF009CCEFF009CCEFF00000000000000000084848400000000009CCEFF00009C
      FF004A4A4A00000000004A4A4A00009CFF00009CFF00009CFF00009CFF00009C
      FF00000000000000000000000000000000000000000000000000009CCE00009C
      CE00000000003939390000000000000000000000000000000000FFFFFF00CECE
      CE0000000000009CCE0000000000000000000000000000000000000000000000
      0000000000009494940008080800CEFFFF0000639C0008080800949494000000
      000000000000000000000000000000000000848484000000000031CEFF006363
      6300CEFFFF0063CEFF009CCEFF009CCEFF009CCEFF009CCEFF009CCEFF009CCE
      FF009CCEFF009CCEFF00000000000000000084848400000000009CCEFF009CCE
      FF00009CFF004A4A4A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000009CCE00009C
      CE00000000000000000000000000000000000000000000000000000000000000
      000000000000009CCE0000000000000000000000000000000000000000000000
      000000000000949494000808080000639C0000639C0008080800949494000000
      000000000000000000000000000000000000848484000000000063CEFF000031
      6300CEFFFF009CCEFF0063CEFF0063CEFF009CCEFF009CCEFF009CCEFF009CCE
      FF009CCEFF009CCEFF00000000000000000084848400000000009CCEFF0063CE
      FF0063CEFF00009CFF000000000063636300FFFFFF00FFFFFF00636363000000
      0000D6D6D600FFFFFF00FFFFFF00000000000000000000000000009CCE00009C
      CE00009CCE00009CCE00009CCE00009CCE00009CCE00009CCE00009CCE00009C
      CE00009CCE00009CCE0000000000000000009494940000000000000000000000
      0000000000003939390018181800212121002121210021212100212121009494
      940021212100212121002121210000000000848484000000000063FFFF0031CE
      FF00003163000031630000316300003163000063630000636300006363000063
      630000636300006363000000000000000000848484000000000063FFFF0031CE
      FF0031CEFF00009CFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000D6D6D600FFFFFF00FFFFFF00000000000000000000000000009CCE00009C
      CE00000000000000000000000000000000000000000000000000000000000000
      0000009CCE00009CCE0000000000000000000808080094949400000000000000
      00009494940039393900B5B5B500D6D6D600D6D6D600D6D6D600CECECE002121
      210008080800A5A5A5004A4A4A0094949400848484000000000063FFFF0063CE
      FF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CE
      FF0063CEFF009CCECE000000000000000000848484000000000063FFFF0063CE
      FF00319CFF00009CFF0000000000FFFFFF00EFEFEF00F7F7F700FFFFFF000000
      0000D6D6D600FFFFFF00FFFFFF00000000000000000000000000009CCE000000
      0000CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECE
      CE0000000000009CCE0000000000000000002121210021212100949494009494
      9400393939000808080000000000000000000000000000000000000000000000
      000000000000D6D6D6004A4A4A009494940000000000000000009CCECE0063FF
      FF0063FFFF0063CEFF009CCECE00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009CCECE0063FF
      FF009CCEFF00CECECE000000000084848400FFFFFF00FFFFFF00636363000000
      0000D6D6D600FFFFFF00FFFFFF00000000000000000000000000009CCE000000
      0000CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECE
      CE0000000000009CCE00000000000000000021212100D6D6D600B5B5B5003939
      3900212121004A4A4A000000000000000000D6D6D600D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D6004A4A4A00949494000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000D6D6
      D600FFFFFF00D6D6D600D6D6D600000000000000000000000000009CCE000000
      0000CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECE
      CE0000000000009CCE000000000000000000000000004A4A4A00F7F7F7000000
      0000F7F7F70000000000FFFFFF00B5B5B500B5B5B500B5B5B500B5B5B500B5B5
      B500B5B5B500B5B5B5004A4A4A00949494000000000000000000000000000000
      000000000000000000000000000000000000000000000000000063FF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000CECE
      CE00FFFFFF00D6D6D60000000000000000000000000000000000009CCE000000
      0000CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECE
      CE000000000000639C00000000000000000000000000000000004A4A4A004A4A
      4A0021212100CECECE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003131
      310008080800B5B5B5004A4A4A00949494000000000000000000000000000000
      00000000000000000000000000000000000000000000009C310031CE3100009C
      3100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000009CCE000000
      0000CECECE00FFFFFF00CECECE00FFFFFF00CECECE00FFFFFF00CECECE00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000002121210021212100212121002121210021212100212121000000
      0000000000002121210021212100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000063FF310031CE310063CE
      6300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000639C000000
      0000FFFFFF00CECECE00FFFFFF00CECECE00FFFFFF00CECECE00FFFFFF00CECE
      CE0000000000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009CFF63000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000630000006300
      0000630000006300000063000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006300000063000000630000006300
      0000630000006300000063000000630000006300000063000000630000006300
      000063000000630000006300000000000000000000000000000084848400CECE
      CE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECE
      CE00CECECE00CECECE00000000000000000000000000000000009C9C9C000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF00000000000000000063000000B5B5B500B5B5B500B5B5
      B500B5B5B500B5B5B500B5B5B500B5B5B500B5B5B500B5B5B500636363006363
      630063636300630000008484840000000000000000000000000084848400DEDE
      DE0000000000DEDEDE0000000000DEDEDE0000000000DEDEDE00DEDEDE00DEDE
      DE00DEDEDE00CECECE00000000000000000000000000000000009C9C9C000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000000000000000FF000000FF000000
      8400000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000063000000B5B5B500FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00B5B5B500630000008484840000000000000000000000000084848400FFFF
      FF00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDE
      DE00DEDEDE00CECECE00000000000000000000000000000000009C9C9C000000
      0000FFFFFF00FFFFFF0010101000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000000000003100CE000000FF000000
      FF00000084000000000000000000000000000000000000000000000000000000
      00000000FF0000000000000000000000000063000000B5B5B500FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00B5B5B500630000008484840000000000000000000000000084848400FFFF
      FF0000000000E7E7E70000000000DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDE
      DE00DEDEDE00CECECE00000000000000000000000000000000009C9C9C000000
      0000FFFFFF00FFFFFF001010100010101000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000000000000000000000000000000000000000003100CE000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      FF000000000000000000000000000000000063000000B5B5B500FFFFFF000000
      00000000000000000000FFFFFF00FFFFFF00000000000000000000000000FFFF
      FF00B5B5B500630000008484840000000000000000000000000084848400FFFF
      FF00FFFFFF00EFEFEF00E7E7E700DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDE
      DE00DEDEDE00CECECE00000000000000000000000000000000009C9C9C000000
      0000FFFFFF00FFFFFF001010100000FF000010101000FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000003100
      CE000000FF000000FF00000000000000000000000000000000000000FF000000
      FF000000000000000000000000000000000063000000B5B5B50000000000FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF000000
      0000B5B5B500630000008484840000000000000000000000000084848400FFFF
      FF0000000000FFFFFF0000000000DEDEDE0000000000DEDEDE0000000000DEDE
      DE0000000000CECECE00000000000000000000000000000000009C9C9C000000
      0000FFFFFF00FFFFFF001010100000FF000000FF000010101000FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      00003100CE000000FF000000FF0000000000000000000000FF000000FF000000
      00000000000000000000000000000000000063000000B5B5B500FFFFFF000000
      00000000000000000000FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF000000
      0000B5B5B500630000008484840000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00EFEFEF00E7E7E700DEDEDE00DEDEDE00DEDE
      DE00DEDEDE00CECECE00000000000000000000000000000000009C9C9C000000
      0000FFFFFF00FFFFFF001010100000FF000010101000FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000003100CE000000FF000000FF000000FF000000FF00000000000000
      00000000000000000000000000000000000063000000B5B5B500FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF00000000000000000000000000FFFF
      FF00B5B5B500630000008484840000000000000000000000000084848400FFFF
      FF0000000000FFFFFF0000000000FFFFFF0000000000E7E7E700DEDEDE00DEDE
      DE00DEDEDE00CECECE00000000000000000000000000000000009C9C9C000000
      0000FFFFFF00FFFFFF001010100010101000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF0000000000000000000000
      00000000000000000000000000000000000063000000B5B5B500FFFFFF000000
      000000000000FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00B5B5B500630000008484840000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E7E7E700DEDE
      DE00DEDEDE00CECECE00000000000000000000000000000000009C9C9C000000
      0000FFFFFF00FFFFFF0010101000FFFFFF00FFFFFF00DEDEDE00DEDEDE00DEDE
      DE00000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF00000000000000
      00000000000000000000000000000000000063000000B5B5B500FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00B5B5B500630000008484840000000000000000000000000084848400FFFF
      FF0000000000FFFFFF0000000000FFFFFF0000000000FFFFFF0000000000DEDE
      DE00DEDEDE00CECECE00000000000000000000000000000000009C9C9C000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DEDEDE00393939003939
      3900000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF0000000000000000000000FF000000FF000000
      00000000000000000000000000000000000063000000B5B5B500FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00B5B5B500630000008484840000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00EFEFEF00E7E7
      E700CECECE00CECECE00000000000000000000000000000000009C9C9C000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DEDEDE00393939000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF00000000000000000000000000000000000000FF000000
      FF000000000000000000000000000000000063000000B5B5B500FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00B5B5B500630000008484840000000000000000000000000084848400FFFF
      FF0000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00EFEFEF000000
      00000000000000000000000000000000000000000000000000009C9C9C000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DEDEDE00848484000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      FF000000FF0000000000000000000000000063000000B5B5B500B5B5B500B5B5
      B500B5B5B500B5B5B500B5B5B500B5B5B500B5B5B500B5B5B500636363006363
      630063636300630000008484840000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00EFEFEF008484
      8400FFFFFF00CECECE0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF0000000000000000006300000063000000630000006300
      0000630000006300000063000000630000006300000063000000630000006300
      000063000000630000008484840000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00EFEFEF008484
      8400CECECE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000630000006300
      0000630000006300000063000000000000000000000000000000848484008484
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
      0000000000000000000000000000000000000000000000000000000000009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000C6C6C6000000000000000000C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C6000000000000000000C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009C9C9C000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00848400008484
      0000FFFFFF00FFFFFF00FFFFFF0000000000C6C6C600C6C6C600000000000000
      0000C6C6C600C6C6C600C6C6C6000000000000000000C6C6C600C6C6C600C6C6
      C6000000000000000000C6C6C600C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009C9C9C000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF0084840000848400008484
      000084840000FFFFFF00FFFFFF0000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C6000000000000000000FFFFFF00000000000000000000000000C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000000000000000
      0000000000000000000000000000A5A5A50000000000A5A5A50000000000A5A5
      A500A5A5A500A5A5A500A5A5A5000000000000000000000000009C9C9C000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0010101000FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF0084840000848400008484
      000084840000FFFFFF00FFFFFF0000000000C6C6C600C6C6C600C6C6C600C6C6
      C60000000000FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000A5A5A500A5A5
      A500A5A5A500A5A5A500A5A5A500A5A5A5000000000000000000A5A5A5000000
      00000000000000000000000000000000000000000000000000009C9C9C000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF001010100010101000FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00848400008484
      0000FFFFFF00FFFFFF00FFFFFF0000000000C6C6C600C6C6C600C6C6C600C6C6
      C60000000000FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000C6C6C600C6C6C600C6C6C600C6C6C60000000000A5A5A500000000000000
      00000000000000000000000000000000000000CE0000319C0000000000008484
      8400FFFFFF00FFFFFF00000000000000000000000000000000009C9C9C000000
      0000FFFFFF00FFFFFF00FFFFFF001010100000FF000010101000FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000C6C6C6000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      000000000000C6C6C60000000000000000000000000000000000319C0000319C
      0000319C0000319C0000319C0000319C000000CE000000CE0000319C00000000
      000084848400FFFFFF00FFFFFF000000000000000000000000009C9C9C000000
      0000FFFFFF00FFFFFF001010100000FF000000FF000010101000FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C6000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      000000000000C6C6C6000000000000000000000000000000000000CE000000CE
      000000CE000000CE000000CE000000CE000000CE000000CE000031FF6300319C
      00000000000084848400FFFFFF000000000000000000000000009C9C9C000000
      0000FFFFFF00FFFFFF00FFFFFF001010100000FF000010101000FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000084
      000000000000000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C60000000000FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600000000000000000000CE000000CE
      000031FF630031FF630031FF630031FF630031FF630031FF6300319C00000000
      000084848400FFFFFF00FFFFFF000000000000000000000000009C9C9C000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF001010100010101000FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008400000084
      000000840000000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C60000000000FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000C6C6C600C6C6C600C6C6C600C6C6C60000000000A5A5A500000000000000
      00000000000000000000000000000000000000CE0000319C0000000000008484
      8400FFFFFF00FFFFFF00000000000000000000000000000000009C9C9C000000
      0000DEDEDE00DEDEDE00DEDEDE00FFFFFF00FFFFFF0010101000FFFFFF00FFFF
      FF000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000084
      000000000000000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C6000000000000000000FFFFFF00000000000000000000000000C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF0000000000000000000000000000000000000000009C9C9C000000
      00003939390039393900DEDEDE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000000000000000000000000000000000FFFFFF00848400008484
      0000FFFFFF000000000000000000008400000000000000000000008400000084
      000000000000000000000000000000000000C6C6C600C6C6C600000000000000
      0000C6C6C600C6C6C600C6C6C600000000000000000000000000C6C6C600C6C6
      C6000000000000000000C6C6C600C6C6C6000000000000000000000000000000
      00000000000000000000000000000000000000000000A5A5A500A5A5A5000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000039393900DEDEDE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000000000000000000000000000000000FFFFFF00848400008484
      0000FFFFFF000000000000840000008400000084000000840000008400000000
      000000000000000000000000000000000000C6C6C6000000000000000000C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C6000000000000000000C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084848400DEDEDE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
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
      000000000000000000000000000000000000000000000000000000000000CECE
      CE0000000000000000000000000000000000000000000000000000000000CECE
      CE000000000000000000000000000000000000000000CEFFFF0000639C000000
      840000848400CEFFFF00B5B5B500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      84008484840000000000000000000000000000000000CEFFFF0029292900319C
      FF00292929001010100000FFFF00CEFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400000000000000
      0000000000000000000008080800000000000000000000000000000000000000
      00000000000008080800000000000000000000000000CEFFFF000000840031CE
      FF00319CFF00000084000031000000FFFF00CEFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000737373006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000000000000000000008484840008080800FFFF
      FF00FFFFFF00FFFFFF0000003100000031009C639C00FFEFCE00FFFFFF00FFFF
      FF00FFFFFF0000000000CECECE000000000000000000CEFFFF0000FFFF000000
      840063FFFF00319CFF00424242001010100000FFFF00CEFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000737373000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF008484
      0000FFFFFF00FFFFFF000000000000000000000000008484840000000000FFFF
      FF00FFFFFF0000003100CE9CFF002100A500319CFF009C639C00FFEFCE00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000FFFF000000
      0000319CFF0063CEFF00319CFF00000084000031000000FFFF00CEFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000008400000000000000000000FFFFFF008484
      0000FFFFFF00FFFFFF000000000000000000000000008484840000000000FFFF
      FF0000003100319CFF002100A5000000FF0084008400319CFF009C639C00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000CEFFFF0000FF
      FF0000008400319CFF0063CEFF00319CFF00292929001010100000FFFF00CEFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000737373001010
      1000000000000000000000000000000000000000000000000000000000000000
      0000008400000084000000840000008400000084000000000000FFFFFF008484
      0000FFFFFF00FFFFFF0000000000000000000000000084848400080808000000
      3100319CFF0084008400FF00FF000000FF000000FF002100A500319CFF007373
      7300FFFFFF0000000000000000000000000000000000000000000000000000FF
      FF0000000000319CFF0063CEFF0063CEFF00319CFF00000084000031000000FF
      FF00CEFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000737373000000
      0000000000000000000000000000000000000000000000000000000000000084
      0000008400000000000000000000008400000000000000000000FFFFFF008484
      000084840000FFFFFF0000000000000000000000000084848400000000008484
      84002100A5000000FF000000FF00101010000000FF00FF00FF0000009C000000
      31008484840000000000000000000000000000000000000000000000000000FF
      FF0000FFFF0000000000319CFF00E7E7E70063CEFF00319CFF00000084000031
      000000FFFF00CEFFFF0000000000000000000000000000000000000000000000
      0000000000000000000084848400000000000000000000000000737373000000
      0000525252000000000000000000000000000000000000000000000000000084
      0000000000000000000000000000000000000000000000000000FFFFFF008484
      000084840000FFFFFF000000000000000000000000008484840010101000FFFF
      FF00848484000000000084848400FFFFFF00000000000000FF00FF00FF000000
      9C00000031000000000000000000000000000000000000000000CEFFFF000000
      000008080800000000000000000031CEFF0063CEFF0063CEFF00319CFF000000
      84000031000000FFFF00CEFFFF000000000000000000080808005A5A5A000000
      0000000000005252520008080800525252000000000000000000000000007373
      7300000000000808080000000000000000000000000000000000008400000084
      0000008400000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000000000000000000008484840000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000FF00FF00
      FF0000009C000808080000000000000000000000000000000000CEFFFF000000
      840031CEFF0031CEFF00DEDEDE00D6D6D60063CEFF00319CFF00319CFF00319C
      FF000000840042424200CEFFFF00B5B5B5000000000008080800080808005252
      5200525252000808080008080800525252000000000000000000000000000000
      0000737373006363630018181800000000000000000000000000000000000084
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008484840008080800FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      FF00FF00FF0000009C0000000000000000000000000000000000CEFFFF000000
      0000319CFF0031CEFF0063CEFF0063CEFF00319CFF0008080800000000000000
      00000000000000FFFF0000000000000000000000000008080800292929000808
      0800080808000808080052525200000000000000000008080800737373000000
      0000000000007373730000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008484840000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      00000000FF00FF00FF0000009C000000000000000000000000000000000000FF
      FF0000000000319CFF0031CEFF0063CEFF0063CEFF00424242000000310000FF
      FF0000FFFF0000000000000000000000000000000000080808005A5A5A000000
      0000080808005252520000000000000000000000000008080800737373007373
      73006363630073737300000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF002100A50010101000000000000000000000000000CEFF
      FF0000FFFF0000000000319CFF00DEDEDE0063CEFF0031CEFF00424242000000
      310000FFFF0000FFFF0000000000000000000000000008080800525252005A5A
      5A00292929000808080052525200000000000000000000000000101010000000
      00001010100000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF008484000084840000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000CEFFFF0000FFFF000000840031CEFF00C6DEC60063CEFF0031CEFF004242
      42001010100000FFFF00CEFFFF00000000000000000008080800080808000808
      0800080808000808080008080800000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00848400008484
      00008484000084840000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000CEFFFF0000FFFF000000840031CEFF00CECECE00CEFFFF0031CE
      FF004242420000008400CEFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000CEFFFF0000FFFF000000840010101000000000000000
      00000000840000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007373
      7300848484007373730084848400737373008484840073737300737373008484
      8400737373008484840000000000000000000000000000000000000000000000
      0000000000008484840084848400848484008484840084848400848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400737373008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000737373000000
      0000000000000000000000000000000000000000000008080800000000000000
      0000000000000000000084848400000000000000000000000000000000008484
      84008484840063310000CE9C0000CE9C0000CE9C00009C310000633100008484
      8400848484000000000000000000000000000000000000000000000000000000
      0000848484007373730000000000000000000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00F7FFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000007373730000000000FFCE
      9C00FFCE9C00FFCE9C00FFCE9C00840000000808080084000000FFCE9C00FFCE
      9C00FFCE9C00FFCE9C0000000000848484000000000000000000848484006331
      0000CE633100FF633100CE633100CE633100CE9C0000CE9C0000CE9C0000CE63
      31006331000084848400CECECE00000000000000000000000000848484007373
      73000000000000000000CECECE00000000008484840000000000737373000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00737373006363
      6300FFFFFF00000000000000000000000000000000008484840000000000FFCE
      9C00FF9C3100FF9C3100840000001010100000FFFF001010100084000000FF9C
      3100FF9C3100FFCE9C0000000000737373000000000084848400848484003131
      0000CE633100CE9C3100CE633100CE633100CE633100CE633100CE9C0000CE9C
      0000FF6331001010100084848400000000000000000073737300000000000000
      0000CECECE000000000000000000000000000000000073737300080808007373
      7300000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00737373000000
      0000FFFFFF00000000000000000000000000000000007373730008080800FF9C
      3100FF9C3100840000002121210063FFFF0063FFFF0031CEFF00101010008400
      0000FF9C3100FF9C310000000000848484000000000084848400009C000000CE
      000000310000CE9C3100CE9C3100CE9C3100CE633100CE633100CE633100CE9C
      0000CE9C0000FF63310084848400CECECE007373730000000000CECECE000000
      00000000000000000000525252004A4A4A0000000000DEDEDE00737373000000
      0000848484000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000007373730000000000FF9C
      3100840000000000000000000000000000000000000000000000101010000000
      000084000000FF9C310000000000848484008484840000630000009C0000009C
      0000009C000031310000FF9C6300CE9C3100CE9C3100CE633100CE633100CE63
      3100CE9C00003131000000630000848484000808080063636300FFFFFF00FFFF
      FF00DEDEDE0052525200840084002100A5006363630000000000D6D6D6006363
      6300000000008484840000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00737373001010
      1000FFFFFF000000000000000000000000000000000063636300101010008400
      00001010100000FFFF0000000000FFCE9C00FFCE9C00FF9C310000000000009C
      FF00101010008400000000000000737373008484840000840000009C0000009C
      0000009C0000008400009C639C00FF9C6300FF9C6300CE9C3100CE9C3100CE63
      3100CE63310031310000009C000084848400000000005A5A5A00636363005252
      52004A4A4A002100A500840084002100A5008400840063636300000000000000
      0000737373000000000084848400000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00636363000808
      0800FFFFFF00FFFFFF0000000000000000000000000073737300000000000000
      0000009CFF0063FFFF0000000000FFCE9C00FF9C3100FF9C31000000000063FF
      FF0031CEFF000000000010101000636363008484840000CE0000009C00002929
      29006363310031310000CE9C3100292929000063000063310000CE633100CE9C
      3100CE633100CE9C000000840000848484000808080042424200424242008400
      84000000FF0000FFFF0031639C00840084002100A50084008400525252009CCE
      CE00000000008484840000000000737373000000000000000000000000000000
      00000000000000000000848484000000000000000000FFFFFF00737373000000
      000052525200FFFFFF00FFFFFF00000000000000000084848400000000008400
      00001010100063FFFF0000000000FF9C3100FF9C3100FF9C31000000000063FF
      FF00000000008400000000000000737373008484840000CE0000009C00000063
      000073737300FFCECE0073737300009C0000009C0000009C0000006300003131
      00006331000031310000009C0000848484000000000084008400319CFF00FF00
      FF000000FF009C639C002100A500840084008400840084008400840084005252
      5200000000000000000000000000848484000000000000000000636363000000
      00000000000052525200080808005252520000000000FFFFFF00FFFFFF006363
      63000000000008080800FFFFFF00FFFFFF00000000007373730000000000FF9C
      3100840000000000000008080800000000000000000010101000000000000000
      000084000000FF9C310000000000848484008484840000CE0000009C0000009C
      000000630000FFCECE0073737300009C0000009C000000840000009C0000009C
      0000009C00000084000000CE0000848484008484840000000000840084000000
      FF00840084000000FF008400840000FFFF0000FFFF0031639C00840084008400
      8400424242000000000000000000848484000000000008080800000000005252
      520052525200101010000808080052525200FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00737373006363630021212100FFFFFF00000000006363630000000000FF9C
      3100FF9C3100840000000000000063FFFF0063FFFF00009CFF00080808008400
      0000FF9C3100FF9C310000000000848484008484840000630000009C0000009C
      000000630000FFCECE00FFCECE0063310000009C0000009C0000009C0000009C
      0000009C0000009C000000630000848484000000000073737300080808009C63
      9C00FF00FF002100A500FF00FF000000FF00319CFF0031CEFF0000FFFF008400
      8400840084004A4A4A0000000000636363000000000000000000212121001010
      100000000000080808005252520000000000FFFFFF000000000073737300FFFF
      FF00FFFFFF007373730000000000FFFFFF00000000007373730010101000FF9C
      3100FF9C3100FF9C3100840000000000000000FFFF000000000084000000FF9C
      3100FF9C3100FF9C31000000000073737300B5B5B5008484840000CE0000009C
      000029292900FFCECE00FFCECE0031310000009C0000009C0000009C0000009C
      0000009C000000CE000084848400000000000000000000000000737373000000
      0000525252000000FF00840084008400840084008400319CFF0000FFFF002100
      A500840084000000000084848400000000000000000008080800636363000000
      000008080800525252000000000000000000FFFFFF0000000000848484006363
      6300636363007373730000000000FFFFFF00000000007373730000000000FF9C
      3100FF9C3100FF9C3100FF9C3100840000000000000084000000FF9C3100FF9C
      3100FF9C3100FF9C310000000000848484000000000084848400848484008484
      8400FFCECE00FFCECE0063633100009C0000009C0000009C0000009C0000009C
      0000009C0000009C000084848400000000000000000000000000000000006363
      630010101000636363009C639C000063CE0000FFFF0000FFFF002100A5008400
      8400101010007373730000000000000000000000000000000000525252006363
      630021212100000000005252520000000000FFFFFF00FFFFFF00080808000000
      00001010100000000000FFFFFF00FFFFFF000000000000000000737373001010
      1000000000000000000000000000080808000000000000000000000000001010
      1000000000000000000073737300000000000000000000000000848484007373
      7300FF9C3100FFCECE0031310000009C0000009C0000009C0000009C000000CE
      0000006300008484840000000000000000000000000000000000000000000000
      00007373730008080800737373000000FF00840084002100A500212121000000
      0000737373000000000000000000000000000000000008080800000000000808
      08000000000008080800000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000007373
      7300737373008484840073737300737373007373730073737300737373007373
      7300737373008484840000000000000000000000000000000000000000008484
      84008484840063633100FF9C31003131000000CE000000CE0000006300008484
      8400848484000000000000000000000000000000000000000000000000000000
      0000000000007373730008080800000000000000000000000000737373007373
      7300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000B5B5
      B500000000000000000000000000000000000000000000000000000000000000
      0000000000008484840084848400848484008484840084848400848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000073737300737373008484840063636300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000737373007373
      7300737373007373730073737300737373007373730073737300737373007373
      7300737373007373730000000000000000000000000000000000848484008484
      8400949494009494940084848400848484009494940094949400848484008484
      8400949494009494940000000000000000000000000000000000848484008484
      8400949494009494940084848400848484009494940094949400848484008484
      8400949494009494940000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000319CCE000000000000000000000000000000000073737300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000073737300000000000000000084848400949494002929
      2900212121002121210021212100292929002121210021212100212121002929
      2900212121002121210084848400000000000000000084848400949494002929
      2900212121002121210021212100292929002121210021212100212121002929
      2900212121002121210084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000003163
      9C0000FFFF00000000006363000063630000000000000000000000319C000031
      6300003163000031630000316300003163000031630000316300003163000031
      63000031630000319C000000000000000000000000009494940018181800CECE
      CE00D6D6D600CECECE00CECECE00CECECE00CECECE00D6D6D600CECECE00CECE
      CE00CECECE00D6D6D6002121210000000000000000009494940018181800CECE
      CE00CECECE00D6D6D600CECECE00CECECE00CECECE00CECECE00CECECE00CECE
      CE00CECECE00CECECE0021212100000000009C9C00009C9C00009C9C00009C9C
      00009C9C0000000000000000000000000000000000000000000031639C0000FF
      FF0000CEFF00000000000000000000000000000000000000000000319C000031
      CE00003163000031630000316300003163000031630000316300003163000031
      630000319C0000319C000000000000000000000000008484840018181800FF31
      3100FF313100FF313100FF313100FF3131005A5A5A005A5A5A00525252005A5A
      5A005A5A5A005252520021212100000000000000000084848400212121005252
      52005252520052525200525252005A5A5A00FF313100FF316300FF633100FF31
      3100FF313100FF31310021212100000000009C9C0000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000031639C0000FFFF0000CE
      FF0000CEFF0000CEFF0000CEFF0000000000000000000000000000319C000031
      CE00003163000031630000316300003163000031630000316300003163000031
      630000319C000031CE000000000000000000000000009494940021212100FF31
      3100FFEFCE00F7CEA500FFEFCE00FF31310052525200CECECE00CECECE00CECE
      CE00000000004A4A4A0021212100000000000000000094949400212121005252
      5200DEDEDE00DEDEDE009C9C9C0052525200CE633100FFEFCE00FFCECE00FFEF
      CE00FFEFCE00FF63310021212100000000009C9C0000FFFFFF00000000000000
      0000FFFFFF0000000000000000000000000031639C00FFFFFF0000CEFF0000CE
      FF0000CEFF0000CEFF0000CEFF0000000000000000000000000000319C000031
      9C000031CE0000316300003163000031CE000000000000316300003163000031
      9C000031CE000031CE000000000000000000000000008484840021212100CE31
      6300FF633100FF313100FF313100FF313100636363000000000094949400CECE
      CE004A4A4A004A4A4A0021212100000000000000000084848400212121005252
      52005252520052525200525252005A5A5A00FF313100FFEFCE00FF313100DEDE
      DE00FF633100CE31630021212100000000009C9C0000FFFFFF00000000003163
      9C00000000000000000000000000000000000000000031639C00FFFFFF0000CE
      FF0000CEFF0000CEFF0000CEFF0000000000000000000000000000319C00009C
      CE000031CE000031CE000031CE0000000000000000000031CE000031CE000031
      CE000031CE00009CCE000000000000000000000000009494940021212100FF31
      3100FFEFCE00FFEFCE00FFEFCE00FF31310052525200CECECE00B5B5B500CECE
      CE00B5B5B5004A4A4A0021212100000000000000000094949400212121005252
      52000000000000000000B5B5B50052525200FF316300FFEFCE00FFEFCE00FFEF
      CE00F7CEA500FF633100212121000000000063630000636300000000000000FF
      FF0031639C00000000000000000000000000000000000000000031639C0000FF
      FF0000CEFF0000CEFF0000CEFF00000000000000000000000000003163000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000003163000000000000000000000000008484840021212100CE63
      3100FFEFCE00FFEFCE00F7CEA500FF3131005A5A5A000000000073737300CECE
      CE004A4A4A004A4A4A0021212100000000000000000084848400212121005252
      520000000000DEDEDE00B5B5B50052525200FF313100CEFFCE00FF313100D6D6
      D600FF633100FF316300212121000000000000000000000000000000000000CE
      FF0000FFFF0031639C0000000000000000000000000000000000000000003163
      9C0000FFFF00000000000000000000000000000000000000000000CEFF00009C
      CE0000CEFF00FFFFFF0000CEFF0000CEFF0000CEFF0063FFFF00319CCE0063FF
      FF0000CEFF00319CCE000000000000000000000000009494940021212100FF31
      6300FFEFCE00FFEFCE00FFEFCE00FF31310052525200CECECE0000000000CECE
      CE00B5B5B5004A4A4A0021212100000000000000000094949400212121005252
      5200DEDEDE00DEDEDE00B5B5B50052525200FF633100FFEFCE00FFEFCE00F7CE
      A500FFEFCE00CE31310029292900000000000000000000CEFF0000CEFF0000CE
      FF0000CEFF0000FFFF0031639C00000000000000000000000000000000000000
      000031639C0000000000FFFFFF00FFFFFF0000000000000000000031630063FF
      FF0000CEFF0063FFFF00319CCE0063FFFF0063FFFF0000CEFF0000CEFF0000CE
      FF00FFFFFF0063FFFF000000000000000000000000008484840018181800FF63
      3100F7CEA500FFEFCE00F7CEA500FF3131005A5A5A00CECECE0063636300CECE
      CE00525252004A4A4A0021212100000000000000000084848400212121005252
      52000000000000000000B5B5B50052525200FF313100FFEFCE00CE313100FFEF
      CE00FF636300FF31310029292900000000000000000000CEFF0000CEFF0000CE
      FF0000CEFF0000CEFF00FFFFFF0031639C000000000000000000000000009C9C
      00000000000000000000FFFFFF00FFFFFF000000000000000000003163000031
      630000316300319CCE0000CEFF00FFFFFF00319CCE0063FFFF0063FFFF00009C
      CE0000316300003163000000000000000000000000009494940021212100FF31
      6300FFEFCE00FFEFCE00FFEFCE00FF31310042424200D6D6D600CECECE00CECE
      CE00CECECE004242420021212100000000000000000094949400212121005252
      5200CECECE00F7F7F700B5B5B50052525200CE636300FFCECE00FFEFCE00F7CE
      A500FFEFCE00CE31310029292900000000000000000000CEFF0000CEFF0000CE
      FF0000CEFF00FFFFFF0031639C00000000000000000000000000000000009C9C
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000003163000031
      9C0000319C0000319C000031630000316300003163000031630000319C000031
      9C0000319C00003163000000000000000000000000008484840018181800FF31
      3100FF313100FF313100CE310000FF3131008484840042424200424242004A4A
      4A00424242008484840021212100000000000000000084848400212121005252
      52005252520052525200525252005A5A5A00FF313100FF313100FF313100CE63
      3100FF316300FF63310029292900000000000000000000CEFF0000CEFF0000CE
      FF0000FFFF0031639C0000000000000000000000000000000000000000009C9C
      00009C9C00009C9C00009C9C00009C9C00000000000073737300000000000031
      6300003163000031630000316300003163000031630000316300003163000031
      630000316300000000007373730000000000000000009494940018181800FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF002121210000000000000000009494940021212100FFFF
      FF00FFFFFF00FFFFFF00F7FFFF00F7FFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00212121000000000000000000000000000000000000FF
      FF0031639C000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000737373007373
      7300000000000000000000000000000000000000000000000000000000000000
      0000737373007373730000000000000000000000000094949400212121005A5A
      5A005A5A5A005A5A5A005A5A5A0063636300636363005A5A5A00636363006363
      6300636363006363630021212100000000000000000094949400212121005A5A
      5A005A5A5A005A5A5A005A5A5A0063636300636363005A5A5A00636363006363
      6300636363007373730021212100000000000000000000000000000000003163
      9C00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000737373007373730073737300737373007373730073737300737373007373
      7300000000000000000000000000000000000000000000000000949494002121
      2100212121002121210021212100212121002121210021212100212121002121
      2100212121002929290000000000000000000000000000000000949494002121
      2100212121002121210021212100212121002121210021212100212121002121
      2100212121002121210000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000009C000000CE000000
      CE000000CE000000CE0000000000737373008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000004A4A4A007373730063FF
      FF00C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C60063FF
      FF0063FFFF00C6C6C600C6C6C600C6C6C6000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      840084848400848484000000000000000000000000000000000000009C000000
      CE000000CE000000CE000000CE00000000007373730084848400000000000000
      000000000000000000000000000000000000000000005A5A5A00D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D6000000000000000000000000004A4A4A007373
      730063FFFF0063FFFF00C6C6C600C6C6C600C6C6C60063FFFF0063FFFF000000
      00000000000063FFFF00C6C6C600C6C6C6000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400000000000000000000000000000000000000
      9C00CE9CFF000000CE000000CE000000CE000000000073737300848484000000
      000000000000000000000000000000000000000000005A5A5A00B5B5B500B5B5
      B500B5B5B500B5B5B500B5B5B500B5B5B500B5B5B500B5B5B500B5B5B500B5B5
      B500B5B5B500B5B5B500B5B5B500000000007373730000000000000000004A4A
      4A007373730063FFFF0063FFFF00C6C6C60063FFFF0063FFFF0000000000009C
      CE000000000063FFFF00C6C6C600C6C6C6000000000000000000316363009CFF
      FF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFF
      FF009CFFFF003163630000000000000000000000000000000000000000000000
      000000009C00CE9CFF000000CE000000CE000000CE0000000000737373008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000063FFFF0073737300000000000000
      00004A4A4A000000000063FFFF0063FFFF0063FFFF000000000031CEFF0031CE
      FF000000000063FFFF00C6C6C600C6C6C60000000000000000009CFFFF009CFF
      FF00FFFFFF00FFFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFF
      FF009CFFFF009CFFFF0000000000000000000000000000000000000000000000
      00000000000000009C00CE9CFF00CE9CFF000000CE000000CE00101010007373
      730084848400000000000000000000000000000000005A5A5A00FFFFFF00D6D6
      D600000000000000000000000000000000000000000000000000000000000000
      00008484840084848400B5B5B50000000000C6C6C60063FFFF00737373000000
      0000000000004A4A4A0000000000000000000000000031CEFF0031FFFF00009C
      CE000000000063FFFF00C6C6C600C6C6C60000000000000000009CFFFF00FFFF
      FF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CE
      FF009CFFFF009CFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000009C00CE9CFF007373730010101000000000000000
      000073737300848484000000000000000000000000005A5A5A00D6D6D6000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084848400B5B5B50000000000C6C6C600C6C6C60063FFFF007373
      730000000000000000000000000000000000FFFFFF00FFFFFF0000FFFF003163
      9C000000000063FFFF00C6C6C600C6C6C600000000000000000063CEFF00FFFF
      FF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CE
      FF0063CEFF0063CEFF0000000000000000000000000000000000000000000000
      00000000000000FF000000FF000000009C0010101000F7F7F700000000000000
      0000000000007373730000000000000000000000000000000000000000000000
      0000000000006363630063636300636363006363630063636300636363000000
      000000000000000000000000000000000000C6C6C600C6C6C60063FFFF0063FF
      FF00000000000000000000000000C6C6C60000000000FFFFFF0000FFFF000031
      63000000000063FFFF0063FFFF00C6C6C600000000000000000063CEFF00FFFF
      FF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CE
      FF0063CEFF0063CEFF0000000000000000000000000000000000000000000000
      00000000000000FF0000FFFFFF00FFFFFF0000009C0000000000000000000000
      000000000000101010009C639C00000000000000000063636300000000000000
      000000000000E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E7000000
      000000000000000000006363630000000000C6C6C60063FFFF0063FFFF000000
      0000FFFFFF0000000000C6C6C600C6C6C60000000000FFFFFF0000FFFF0063FF
      FF00003163000000000063FFFF0063FFFF00000000000000000063CEFF00FFFF
      FF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CE
      FF0063CEFF0063CEFF0000000000000000000000000000000000000000000000
      00000000000000FF0000FFFFFF00008400000084000000000000F7F7F700F7F7
      F700000000001010100073737300000000000000000000000000000000000000
      000000000000FFCECE00FF633100FF9C6300FFFFFF00FF633100FF9C63000000
      000000000000000000000000000000000000C6C6C60063FFFF000000000031CE
      FF0000FFFF00FFFFFF000000000000000000FFFFFF00FFFFFF0000FFFF0031FF
      FF0031CEFF00009CCE000000000063FFFF00000000000000000063CEFF00FFFF
      FF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CE
      FF0063CEFF0063CEFF0000000000000000000000000000000000000000000000
      00000000000000FF0000FFFFFF000084000000FF000000000000000000009C63
      9C009C639C000000000010101000000000000000000000000000000000000000
      000000000000FFCECE00FF633100FF9C6300FFFFFF00FF633100FF9C63000000
      000000000000000000000000000000000000C6C6C60063FFFF0031CEFF000000
      0000009CCE0000FFFF00FFFFFF00FFFFFF00FFFFFF0031FFFF0031FFFF0031CE
      FF00009CCE000000000031CEFF0063FFFF00000000000000000063CEFF00FFFF
      FF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CE
      FF0063CEFF003163630000000000000000000000000000000000000000000000
      00000000000000FF0000FFFFFF000084000000FF000000840000000000000000
      00000000000000000000101010009C639C000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      000000000000000000000000000000000000C6C6C600C6C6C60063FFFF0063FF
      FF0031CEFF00009CCE00009CCE0000FFFF0063FFFF0031CEFF00000000000000
      000031CEFF0063FFFF0063FFFF00C6C6C60000000000000000009CFFFF009CFF
      FF0063CEFF0063CEFF0063CEFF0063CEFF00319CCE0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FF0000FFFFFF000084000000FF000000FF0000008400000000
      0000000000000000000010101000737373000000000000000000000000000000
      000000000000FFCECE00FF633100FF9C6300FFFFFF00FF633100FF9C63000000
      000000000000000000000000000000000000C6C6C600C6C6C600C6C6C60063FF
      FF0063FFFF0063FFFF0000000000009CCE0031CEFF00003163000000000063FF
      FF0063FFFF0063FFFF00C6C6C600C6C6C6000000000000000000000000009CFF
      FF009CFFFF0063CEFF0063CEFF0063CEFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FF0000FFFFFF000084000000FF000000FF000000FF000000FF
      0000008400007373730010101000737373000000000000000000000000000000
      000000000000D6D6D600FF633100FF9C6300FFFFFF00FF633100FF9C63000000
      000000000000000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C60063FFFF0063FFFF0000000000009CCE000000000063FFFF0063FF
      FF00C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FF0000FFFFFF000084000000FF000000FF000000FF000000FF
      000000FF00000084000000000000FFFFFF000000000000000000000000000000
      00000000000000000000D6D6D600FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      000000000000000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C60063FFFF0063FFFF000000000063FFFF0063FFFF00C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FF0000FFFFFF00008400000084000000840000008400000084
      0000008400000084000000840000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C60063FFFF0063FFFF0063FFFF00C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FF0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C60063FFFF00C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000A5A5A5008484840084848400848484008484
      840084848400A5A5A50000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000009CCE009CCEFF009CCE
      FF009CCEFF009CCEFF009CCEFF009CCEFF009CCEFF009CCEFF009CCEFF009CCE
      FF00009CCE0000000000000000000000000000000000009CCE009CCEFF009CCE
      FF009CCEFF009CCEFF009CCEFF009CCEFF009CCEFF009CCEFF009CCEFF009CCE
      FF00009CCE000000000000000000000000000000000000000000000000000000
      00000000000000000000A5A5A500A5A5A5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009CCEFF009CCEFF00FFFF
      FF00FFFFFF009CCEFF009CCEFF009CCEFF009CCEFF009CCEFF009CCEFF009CCE
      FF009CCEFF00000000000000000000000000000000009CCEFF009CCEFF00FFFF
      FF00FFFFFF009CCEFF009CCEFF009CCEFF009CCEFF009CCEFF009CCEFF009CCE
      FF009CCEFF000000000000000000000000000000000000000000000000000000
      00000000000000000000A5A5A50000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      840084848400848484000000000000000000000000009CCEFF00FFFFFF0063CE
      FF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF009CCE
      FF009CCEFF00000000000000000000000000000000009CCEFF00FFFFFF0063CE
      FF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF009CCE
      FF009CCEFF000000000000000000000000000000000000000000000000000000
      00000000000000000000A5A5A50000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400000000000000000063CEFF00FFFFFF0063CE
      FF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CE
      FF0063CEFF000000000000000000000000000000000063CEFF00FFFFFF0063CE
      FF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CE
      FF0063CEFF000000000000000000000000000000000000000000A5A5A500A5A5
      A500A5A5A500A5A5A500A5A5A5000000000084848400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      00006363630000000000F7F7F70000000000000000000000000000000000D6D6
      D600000000000000000000000000000000000000000063CEFF00FFFFFF0063CE
      FF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CE
      FF0063CEFF000000000000000000000000000000000000000000000000000000
      0000000000000000000063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CE
      FF0063CEFF0000000000000000000000000000000000A5A5A500A5A5A5000000
      0000000000000000000000000000000000000000000084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      00006363630000000000D6D6D600000000008484840042424200848484000000
      0000000000000000000000000000000000000000000063CEFF00FFFFFF0063CE
      FF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CE
      FF0063CEFF000000000000000000000000000000000094949400949494009494
      9400949494000000000063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CE
      FF0063CEFF0000000000000000000000000000000000A5A5A50000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000084848400FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000636363000000000000000000848484002121210018181800000000008484
      8400000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000063CEFF0063CEFF0063CEFF0063CE
      FF0063CEFF000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000063CE
      FF0063CEFF0000000000000000000000000000000000A5A5A50000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000084848400FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      00005A5A5A00F7F7F7000000000052525200FFFFFF0052525200292929006363
      6300000000000000000000000000000000000000000094949400949494009494
      94009494940094949400949494000000000063CEFF0063CEFF0063CEFF0063CE
      FF00009CCE0000000000000000000000000000000000DEDEDE00DEDEDE000000
      00009494940094949400949494009494940094949400949494000000000063CE
      FF00009CCE0000000000000000000000000000000000A5A5A50000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000084848400FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000052525200EFEFEF0000000000848484005252520063636300212121006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A5A5A50000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000084848400FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000A5A5A500D6D6D6005A5A5A00000000006363630063636300525252000000
      00008484840084848400000000000000000000000000DEDEDE00DEDEDE00DEDE
      DE00DEDEDE00DEDEDE00DEDEDE00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF000000
      0000DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00000000000000
      00000000000000000000000000000000000000000000A5A5A50000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      840000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF0084848400000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      00000000000000000000000000000000000000000000A5A5A50000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      000000000000000000000000000000000000000000000000000084848400FFFF
      FF00848484000000000000000000000000000000000000000000000000008484
      84008484840084848400000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      00000000000000000000000000000000000000000000A5A5A50000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000008080800000000008484
      8400000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      00000000000000000000000000000000000000000000A5A5A50000000000FFFF
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
      0000A5A5A500A5A5A500A5A5A500A5A5A500A5A5A500A5A5A500A5A5A500A5A5
      A500000000000000000000000000000000000000000000000000000000000000
      00009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CECECE00CECE
      CE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECE
      CE00CECECE00000000000000000000000000000000000000000000000000A5A5
      A500000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009C9C
      9C009C9C9C008484840084848400848484008484840084848400848484009C9C
      9C009C9C9C000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000DEDEDE000000
      0000DEDEDE0000000000DEDEDE0000000000DEDEDE00DEDEDE00DEDEDE00DEDE
      DE00CECECE00000000000000000000000000000000000000000000000000A5A5
      A50000000000F7F7F700DEDEDE00DEDEDE0000000000A5A5A500A5A5A500A5A5
      A500000000000000000000000000000000000000000000000000000000009C9C
      9C00848484000000000000000000000000000000000000000000000000000000
      00009C9C9C000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A5A5A5000000
      0000000000000000000000000000000000000000000000000000FFFFFF00DEDE
      DE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDE
      DE00CECECE00000000000000000000000000000000000000000000000000A5A5
      A50000000000FFFFFF00F7F7F700DEDEDE00DEDEDE0000000000A5A5A500A5A5
      A500000000000000000000000000000000000000000000000000000000009C9C
      9C008484840000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      00009C9C9C000000000000000000000000000000000000000000000000000000
      00000000000000000000A5A5A5008484840000000000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      0000E7E7E70000000000DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDE
      DE00CECECE00000000000000000000000000000000000000000000000000A5A5
      A50000000000FFFFFF00FFFFFF00F7F7F700DEDEDE00DEDEDE0000000000A5A5
      A500000000000000000000000000000000000000000000000000000000009C9C
      9C008484840000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      00009C9C9C000000000000000000000000000000000000000000000000000000
      000000000000A5A5A50063CEFF000000000000000000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00E7E7E700E7E7E700DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDE
      DE00CECECE00000000000000000000000000000000000000000000000000A5A5
      A50000000000FFFFFF00FFFFFF00FFFFFF00F7F7F700EFEFEF00DEDEDE000000
      0000000000000000000000000000000000000000000000000000000000009C9C
      9C008484840000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      00009C9C9C00000000000000000000000000000000000000000000000000A5A5
      A50063CEFF0063CEFF0000FFFF00000000000000000000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      0000FFFFFF0000000000DEDEDE0000000000DEDEDE0000000000DEDEDE000000
      0000CECECE00000000000000000000000000000000000000000000000000A5A5
      A50000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7F7F700EFEFEF00E7E7
      E700000000000000000000000000000000000000000000000000000000009C9C
      9C008484840000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      00009C9C9C00000000000000000000000000000000000000000000000000CEFF
      FF0000FFFF0000FFFF0000FFFF00000000000000000084848400FFFFFF000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00E7E7E700E7E7E700DEDEDE00DEDEDE00DEDEDE00DEDE
      DE00CECECE00000000000000000000000000000000000000000000000000A5A5
      A50000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7F7F700DEDE
      DE00000000000000000000000000000000000000000000000000000000009C9C
      9C008484840000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      00009C9C9C00000000000000000000000000000000000000000000000000CEFF
      FF00FFFFFF0000FFFF0000FFFF00000000000000000084848400FFFFFF000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      0000FFFFFF0000000000FFFFFF0000000000E7E7E700DEDEDE00DEDEDE00DEDE
      DE00CECECE00000000000000000000000000000000000000000000000000A5A5
      A50000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DEDE
      DE00000000000000000000000000000000000000000000000000000000009C9C
      9C008484840000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      00009C9C9C00000000000000000000000000000000000000000000000000A5A5
      A500CEFFFF00FFFFFF0000FFFF00000000000000000000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E7E7E700DEDEDE00DEDE
      DE00CECECE00000000000000000000000000000000000000000000000000A5A5
      A50000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00DEDEDE00DEDEDE00DEDE
      DE00000000000000000000000000000000000000000000000000000000009C9C
      9C008484840000000000FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      00009C9C9C000000000000000000000000000000000000000000000000000000
      000000000000A5A5A500CEFFFF000000000000000000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      0000FFFFFF0000000000FFFFFF0000000000FFFFFF0000000000DEDEDE000000
      0000CECECE00000000000000000000000000000000000000000000000000A5A5
      A50000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00DEDEDE00000000000000
      0000000000000000000000000000000000000000000000000000000000009C9C
      9C008484840000000000FFFFFF00FFFFFF00FFFFFF0000000000848484008484
      84009C9C9C000000000000000000000000000000000000000000000000000000
      00000000000000000000A5A5A5008484840000000000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E7E7E700E7E7E7000000
      0000CECECE00000000000000000000000000000000000000000000000000A5A5
      A50000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00DEDEDE00000000000000
      0000000000000000000000000000000000000000000000000000000000009C9C
      9C008484840000000000FFFFFF00FFFFFF00FFFFFF0000000000848484000000
      00009C9C9C000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A5A5A5000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      0000FFFFFF0000000000FFFFFF0000000000FFFFFF00EFEFEF00000000000000
      000000000000000000000000000000000000000000000000000000000000A5A5
      A50000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00DEDEDE00000000000000
      0000000000000000000000000000000000000000000000000000000000009C9C
      9C009C9C9C0000000000000000000000000000000000000000009C9C9C009C9C
      9C00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E7E7E700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00EFEFEF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
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
      8400848484008484840000000000000000000000000000000000636363006363
      6300636363006363630063636300636363006363630063636300636363006363
      6300636363006363630000000000000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840084848400000000000000000000000000000000000000
      0000848484008484840084848400848484008484840084848400848484008484
      8400000000000000000000000000000000000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400000000000000000063636300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000063636300000000000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000848484000000000000000000000000008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000008484009CCE
      FF009CCEFF009CCEFF009CCEFF009CCEFF009CCEFF009CCEFF009CCEFF009CCE
      FF009CCEFF0000848400000000000000000000000000000000000000000094AD
      AD00639C9C00639C9C0094ADAD00639C9C00639C9C00639C9C00639C9C00639C
      9C00639C9C00639CCE000000000000000000848484000000000063CEFF009CCE
      FF009CCEFF009CCEFF009CCEFF009CCEFF009CCEFF009CCEFF009CCEFF009CCE
      FF009CCEFF009CCEFF009CCEFF00000000000000000000000000000000008484
      840000000000F7F7F700DEDEDE00DEDEDE0000000000A5A5A500A5A5A500A5A5
      A5000000000000000000000000000000000084848400000000009CCEFF009CCE
      FF00FFFFFF00FFFFFF009CCEFF009CCEFF009CCEFF009CCEFF009CCEFF009CCE
      FF009CCEFF009CCEFF000000000000000000000000000000000000000000CECE
      CE00CEFFFF00CEFFFF009CCEFF009CCEFF009CCEFF0063CEFF0063CEFF0063CE
      FF0063CEFF0063CEFF000000000000000000848484000000000063CEFF000000
      00000000000000000000000000009CCEFF00000000009CCEFF009CCEFF009CCE
      FF0000000000000000009CCEFF00000000000000000000000000000000008484
      840000000000FFFFFF00DEDEDE00DEDEDE00DEDEDE0000000000A5A5A500A5A5
      A5000000000000000000000000000000000084848400000000009CCEFF00FFFF
      FF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CE
      FF009CCEFF009CCEFF00000000000000000000000000000000000000000094AD
      AD00CEFFFF003131310031313100313131003131310031313100313131003131
      310063CEFF0063CEFF000000000000000000848484000000000063CEFF000000
      00009CFFFF0063CEFF000000000063CEFF000000000063CEFF0063CEFF000000
      000063CEFF009CCEFF009CCEFF00000000000000000000000000000000008484
      840000000000FFFFFF00DEDEDE003939390000000000DEDEDE0000000000A5A5
      A50000000000000000000000000000000000848484000000000063CEFF00FFFF
      FF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CE
      FF0063CEFF0063CEFF0000000000000000000000000000000000000000009CCE
      CE00CEFFFF0031313100FFEFCE00F7F7F700FFFFFF00FFFFFF00FFFFFF003131
      310063CEFF0063CEFF000000000000000000848484000000000063CEFF0063CE
      FF0000000000000000000000000063CEFF000000000063CEFF0063CEFF000000
      000063CEFF0063CEFF0063CEFF00000000000000000000000000000000008484
      840000000000FFFFFF00DEDEDE000000000000000000EFEFEF00DEDEDE000000
      000000000000000000000000000000000000848484000000000063CEFF00FFFF
      FF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CE
      FF0063CEFF0063CEFF00000000000000000000000000000000000000000094AD
      AD00CEFFFF003131310000000000F7CEA500DEDEDE00EFEFEF00FFFFFF003131
      310063CEFF0063CEFF000000000000000000848484000000000063CEFF0063CE
      FF0063CEFF0063CEFF000000000063CEFF000000000063CEFF0063CEFF000000
      000063CEFF0063CEFF0063CEFF00000000000000000000000000000000008484
      840000000000FFFFFF00FFFFFF00DEDEDE0000000000F7F7F700EFEFEF00E7E7
      E70000000000000000000000000000000000848484000000000063CEFF00FFFF
      FF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CE
      FF0063CEFF0063CEFF00000000000000000000000000B5B5B50000000000C6D6
      EF00F7FFFF0031313100B5B5B500B5B5B500F7CEA500F7CEA500EFEFEF003131
      310063CEFF0063CEFF000000000000000000848484000000000063CEFF0063CE
      FF00000000000000000063CEFF0063CEFF0063CEFF00000000000000000063CE
      FF00000000000000000063CEFF00000000000000000000000000000000008484
      840000000000FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00F7F7F700DEDE
      DE0000000000000000000000000000000000848484000000000063CEFF00FFFF
      FF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CE
      FF0063CEFF0063CEFF0000000000000000000000000000000000000000009C9C
      9C00F7FFFF0031313100CE9C0000B5B5B500B5B5B50000000000FFEFCE003131
      310063CEFF0063CEFF000000000000000000848484000000000063CEFF0063CE
      FF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CE
      FF0063CEFF0063CEFF0063CEFF00000000000000000000000000000000008484
      840000000000FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00DEDE
      DE0000000000000000000000000000000000848484000000000063CEFF00FFFF
      FF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CE
      FF0063CEFF0000848400000000000000000000000000B5B5B50000000000C6D6
      EF00F7FFFF003131310031313100313131003131310031313100313131003131
      310063CEFF0063CEFF000000000000000000848484000000000063CEFF009CFF
      FF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CE
      FF0063CEFF0063CEFF00319CCE00000000000000000000000000000000008484
      840000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00DEDEDE00DEDEDE00DEDE
      DE00000000000000000000000000000000000000000000000000C6D6EF009CFF
      FF0063CEFF0063CEFF0063CEFF0063CEFF00319C9C0000000000000000000000
      00000000000000000000000000000000000000000000000000000000000094AD
      AD00F7FFFF00F7FFFF00C6D6EF00C6D6EF00C6D6EF00C6D6EF0063CEFF0063CE
      FF0063CEFF009CCECE00000000000000000000000000000000009CCECE009CFF
      FF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF009CCECE00000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      840000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00DEDEDE00000000000000
      000000000000000000000000000000000000000000000000000000000000C6D6
      EF009CFFFF0063CEFF0063CEFF009CCECE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009CCE
      CE009CFFFF009CFFFF009CFFFF009CFFFF009CCECE0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      840000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00DEDEDE0000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      840000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00DEDEDE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000949494000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000094949400525252000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009C0000009C0000009C00
      000000000000000000000000000000000000000000009C0000009C0000009C00
      0000000000000000000000000000000000000000000000000000949494000000
      00000063310000CE310031FF310063FF630063FF630063FF630063FF630063FF
      63009CFFCE00C6DEC60000000000000000000000000000000000000000000000
      00000000000000000000949494000000000000630000C6DEC600000000000000
      0000000000000000000000000000000000009C00000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009C000000FFFFFF009C00
      000000000000000000000000000000000000000000009C000000FFFFFF009C00
      0000000000000000000000000000000000000000000000000000949494007373
      73000000000000CE310031FF310031FF310063FF630063FF630063FF63009CFF
      CE009CFFCE000000000000000000000000000000000000000000000000000000
      00000000000094949400737373000000000000CE0000CEFFCE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009C000000FFFFFF009C00
      000000000000000000000000000000000000000000009C000000FFFFFF009C00
      0000000000000000000000000000000000000000000000000000000000009494
      9400000000000031310000CE310063FF630063FF630063FF630063FF63009CFF
      CE00C6DEC6000000000000000000000000000000000000000000000000000000
      00000000000094949400000000000063310063FF63009CFFCE00C6DEC6000000
      0000000000000000000000000000000000009C00000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009C0000009C0000000000
      000000000000000000000000000000000000000000009C0000009C0000000000
      0000000000000000000000000000000000000000000000000000000000009494
      9400737373000000000000CE310031FF310063FF630063FF63009CFFCE00CEFF
      CE00000000000000000000000000000000000000000000000000000000000000
      000094949400737373000000000000CE000063FF63009CFFCE009CFFCE000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000094949400000000000031310031FF310063FF630063FF63009CFFCE00C6DE
      C600000000000000000000000000000000000000000000000000000000000000
      000094949400000000000031310031FF310063FF630063FF63009CFFCE00C6DE
      C600000000000000000000000000000000009C00000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009C0000009C0000009C00
      000000000000000000000000000000000000000000009C0000009C0000009C00
      0000000000000000000000000000000000000000000000000000000000000000
      000094949400737373000000000000CE000063FF63009CFFCE009CFFCE000000
      0000000000000000000000000000000000000000000000000000000000009494
      9400737373000000000000CE310031FF310063FF630063FF63009CFFCE00CEFF
      CE00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009C000000FFFFFF009C00
      000000000000000000000000000000000000000000009C000000FFFFFF009C00
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000094949400000000000063310063FF63009CFFCE00C6DEC6000000
      0000000000000000000000000000000000000000000000000000000000009494
      9400000000000031310000CE310063FF630063FF630063FF630063FF63009CFF
      CE00C6DEC6000000000000000000000000009C00000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009C000000FFFFFF009C00
      000000000000000000000000000000000000000000009C000000FFFFFF009C00
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000094949400737373000000000000CE0000CEFFCE00000000000000
      0000000000000000000000000000000000000000000000000000949494007373
      73000000000000CE310031FF310031FF310063FF630063FF630063FF63009CFF
      CE009CFFCE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009C0000009C0000000000
      000000000000000000000000000000000000000000009C0000009C0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000949494000000000000630000C6DEC600000000000000
      0000000000000000000000000000000000000000000000000000949494000000
      00000063310000CE310031FF310063FF630063FF630063FF630063FF630063FF
      63009CFFCE00C6DEC60000000000000000009C00000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000094949400737373000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000949494000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009C0000009C0000009C00
      000000000000000000000000000000000000000000009C0000009C0000009C00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009C0000009C0000009C0000009C00
      00009C0000009C0000009C0000009C0000009C0000009C0000009C0000009C00
      00009C0000009C0000009C0000009C000000000000009C000000FFFFFF009C00
      000000000000000000000000000000000000000000009C000000FFFFFF009C00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009C000000FFFFFF009C00
      000000000000000000000000000000000000000000009C000000FFFFFF009C00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009C0000009C0000000000
      000000000000000000000000000000000000000000009C0000009C0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009C00
      00009C0000009C00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009C0000009C0000009C0000000000
      0000000000000000000000000000000000009C0000009C0000009C0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009C00
      0000FFFFFF009C00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009C000000FFFFFF009C0000000000
      0000000000000000000000000000000000009C000000FFFFFF009C0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009C9C9C000000
      00000000000000000000000000009C9C9C000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009C0000009C00
      00009C0000009C00000000000000000000000000000000000000000000009C00
      00009C0000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009C0000009C000000000000000000
      0000000000000000000000000000000000009C0000009C000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000009C
      0000009C0000009C0000009C0000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009C000000FFFF
      FF00FFFFFF009C00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000063FF
      630063FF630063FF630063FF6300000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009C000000FFFF
      FF00FFFFFF009C00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000CEFF
      CE00CEFFCE00CEFFCE00CEFFCE00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009C000000FFFF
      FF009C0000009C00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009C0000009C0000009C0000000000
      0000000000000000000000000000000000009C0000009C0000009C0000000000
      0000000000000000000000000000000000009C0000009C0000009C0000000000
      0000000000000000000000000000000000009C9C9C0000000000000000000000
      0000000000009C9C9C000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009C0000009C00
      00009C0000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009C000000FFFFFF009C0000000000
      0000000000000000000000000000000000009C000000FFFFFF009C0000000000
      0000000000000000000000000000000000009C000000FFFFFF009C0000000000
      00000000000000000000000000000000000000000000009C0000009C0000009C
      0000009C0000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009C0000009C000000000000000000
      0000000000000000000000000000000000009C0000009C000000000000000000
      0000000000000000000000000000000000009C0000009C000000000000000000
      0000000000000000000000000000000000000000000063FF630063FF630063FF
      630063FF630000000000000000000000000000000000000000009C9C9C000000
      00000000000000000000000000009C9C9C0000000000000000009C0000009C00
      00009C0000009C00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CEFFCE00CEFFCE00CEFF
      CE00CEFFCE000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009C000000FFFF
      FF00FFFFFF009C00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009C000000FFFF
      FF00FFFFFF009C00000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009C0000009C0000009C00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009C0000009C0000009C0000000000
      0000000000000000000000000000000000009C0000009C0000009C0000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009C000000FFFF
      FF009C0000009C00000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009C000000FFFFFF009C00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009C000000FFFFFF009C0000000000
      0000000000000000000000000000000000009C000000FFFFFF009C0000000000
      0000000000000000000000000000000000009C9C9C0000000000000000000000
      0000000000009C9C9C0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009C0000009C00
      00009C0000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009C0000009C0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009C0000009C000000000000000000
      0000000000000000000000000000000000009C0000009C000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
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
      000000FF0000C6C6C600C6C6C600C6C6C6000000000052525200525252005252
      5200525252005252520052525200525252005252520052525200525252005252
      5200525252005252520000000000000000000000000000000000000000000000
      00000000000000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000000000000000
      0000000000009494940000000000000000000000000000000000949494000000
      00000000000000000000000000000000000000000000CEFFCE0063FF630063FF
      630063FF630063FF630063FF630000FF0000C6C6C600C6C6C6000000000063FF
      6300CEFFCE0000FF0000C6C6C600C6C6C6000000000052525200101010001010
      1000101010001010100010101000101010001010100010101000101010001010
      10001010100010101000101010000000000000000000009C0000009C0000009C
      0000009C000000000000C6C6C60000000000000000000000000000000000C6C6
      C600000000000000000000000000C6C6C6000000000000000000000000000000
      0000000000009494940000000000000000000000000000000000949494000000
      000000000000000000000000000000000000C6C6C60000000000CEFFCE0063FF
      630063FF630063FF630000FF0000C6C6C600C6C6C600C6C6C6000000000063FF
      6300CEFFCE0000FF0000C6C6C600C6C6C600000000005252520010101000FFFF
      FF00000000000000000000000000FFFFFF00CECECE00FFFFFF00000000000000
      000000000000FFFFFF0010101000000000000000000063FF630063FF630063FF
      630063FF630000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000000000000000
      0000000000009494940000000000000000000000000000000000949494000000
      000000000000000000000000000000000000C6C6C60000000000CEFFCE0063FF
      630063FF630063FF630000FF0000C6C6C600C6C6C6000000000063FF630063FF
      630063FF6300CEFFCE0000FF0000C6C6C600000000005252520010101000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00101010000000000000000000CEFFCE00CEFFCE00CEFF
      CE00CEFFCE0000000000C6C6C60000000000000000000000000000000000C6C6
      C600000000000000000000000000C6C6C6000000000000000000000000000000
      0000000000009494940000000000000000000000000000000000949494000000
      000000000000000000000000000000000000C6C6C600C6C6C60000000000CEFF
      CE0063FF630000FF0000C6C6C600C6C6C600C6C6C6000000000063FF630063FF
      630063FF6300CEFFCE0000FF0000C6C6C600000000005252520010101000FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00000000000000
      000000000000FFFFFF00101010000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000000000000000
      0000949494000000000000000000000000000000000000000000000000009494
      940000000000000000000000000000000000C6C6C600C6C6C60000000000CEFF
      CE0063FF630000FF0000C6C6C600C6C6C6000000000063FF630063FF630063FF
      630063FF630063FF6300CEFFCE0000FF0000000000005252520010101000FFFF
      FF000000000000FFCE0000000000FFFFFF00CECECE00FFFFFF000000000000FF
      CE0000000000FFFFFF00101010000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000C6C6C60000000000000000000000000000000000C6C6
      C600000000000000000000000000C6C6C6000000000000000000000000009494
      9400000000000000000000000000000000000000000000000000000000000000
      000094949400000000000000000000000000C6C6C600C6C6C600C6C6C6000000
      000000FF0000C6C6C600C6C6C600C6C6C6000000000000000000000000000000
      000000000000000000000000000000FF0000000000005252520010101000FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00000000000000
      000000000000FFFFFF0010101000000000000000000000000000000000000000
      00000000000000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000949494000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000949494000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600000000005252520010101000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF001010100000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6000000000094949400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000009494940000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600000000005252520010101000FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00000000000000
      000000000000FFFFFF0010101000000000000000000000000000000000000000
      00000000000000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C60000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      0000000000000000000000000000C6C6C600000000005252520010101000FFFF
      FF000000000000FFCE0000000000FFFFFF00CECECE00FFFFFF000000000000FF
      CE0000000000FFFFFF00101010000000000000000000009C0000009C0000009C
      0000009C000000000000C6C6C60000000000000000000000000000000000C6C6
      C600000000000000000000000000C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C60000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      0000CECECE00CECECE00CECECE00CECECE00000000005252520010101000FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00000000000000
      000000000000FFFFFF0010101000000000000000000063FF630063FF630063FF
      630063FF630000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600000000009494940000000000CECE
      CE00CECECE0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000CECE
      CE00CECECE000000000094949400000000000000000000000000000000000000
      000000000000C6C6C600C6C6C600C6C6C600C6C6C60000000000C6C6C600C6C6
      C60000000000CECECE00CECECE00CECECE00000000005252520010101000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00101010000000000000000000CEFFCE00CEFFCE00CEFF
      CE00CEFFCE0000000000C6C6C60000000000000000000000000000000000C6C6
      C600000000000000000000000000C6C6C6000000000000000000949494000000
      000000000000000000009C9C9C009C9C9C009C9C9C00FFFFFF00000000000000
      00000000000094949400000000000000000000000000CECECE00CECECE00CECE
      CE0000000000C6C6C6000000000000000000000000000000000000000000C6C6
      C600C6C6C60000000000CECECE00CECECE000000000052525200101010000000
      00000000000000000000B5B5B500B5B5B500B5B5B500B5B5B500000000000000
      00000000000000000000101010000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000000000000000
      00009494940000000000FFFFFF00FFFFFF00FFFFFF009C9C9C00000000009494
      94000000000000000000000000000000000000000000CECECE00CECECE00CECE
      CE0000000000C6C6C600C6C6C600C6C6C600C6C6C60000000000C6C6C600C6C6
      C600C6C6C600C6C6C60000000000CECECE000000000052525200101010003131
      31004A4A4A00292929004A4A4A00212121004A4A4A004A4A4A00292929004A4A
      4A002121210073737300101010000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000C6C6C60000000000000000000000000000000000C6C6
      C600000000000000000000000000C6C6C6000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF009C9C9C009C9C9C00000000000000
      000000000000000000000000000000000000C6C6C60000000000CECECE000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600000000000000000052525200101010000000
      0000B5B5B500B5B5B500B5B5B500B5B5B500B5B5B500B5B5B500B5B5B5000000
      0000000000000000000010101000000000000000000000000000000000000000
      00000000000000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C600C6C6C60000000000C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      0000000000000000000000000000000000000000000000000000101010001010
      1000101010001010100010101000101010001010100010101000101010001010
      100010101000101010001010100000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000073737300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000073737300000000000000000084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000094AD
      AD00639C9C00639C9C0094ADAD00639C9C00639C9C00639C9C00639C9C00639C
      9C00639C9C00639CCE0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000009CCE009CCEFF009CCE
      FF009CCEFF009CCEFF009CCEFF009CCEFF009CCEFF009CCEFF009CCEFF009CCE
      FF00009CCE00000000000000000000000000000000000000000000000000CECE
      CE00CEFFFF00CEFFFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CE
      FF0063CEFF0063CEFF000000000000000000A5A5A500FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009CCEFF009CCEFF00FFFF
      FF00FFFFFF009CCEFF009CCEFF009CCEFF009CCEFF009CCEFF009CCEFF009CCE
      FF009CCEFF0000000000000000000000000000000000000000000000000094AD
      AD00CEFFFF003131310000000000000000000000000000000000000000003131
      310063CEFF0063CEFF000000000000000000A5A5A500FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009CCEFF00FFFFFF0063CE
      FF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF009CCE
      FF009CCEFF000000000000000000000000000000000000000000000000009CCE
      CE00CEFFFF0000000000FFEFCE00EFEFEF00FFFFFF00FFFFFF00FFFFFF000000
      000063CEFF0063CEFF000000000000000000A5A5A500FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000063CEFF00FFFFFF0063CE
      FF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CE
      FF0063CEFF0000000000000000000000000000000000000000000000000094AD
      AD00CEFFFF000000000000000000F7CEA500DEDEDE00EFEFEF00FFFFFF000000
      000063CEFF0063CEFF000000000000000000A5A5A500FFFFFF00FFFFFF000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000008484
      8400000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000063CEFF00FFFFFF0063CE
      FF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CE
      FF0063CEFF0000000000000000000000000000000000B5B5B50000000000C6D6
      EF00F7FFFF0000000000B5B5B500B5B5B500F7CEA500F7CEA500EFEFEF000000
      000063CEFF0063CEFF000000000000000000A5A5A500FFFFFF00FFFFFF000000
      00000000000000000000FFFFFF0000000000FFFFFF00FFFFFF00000000008484
      84000000000000000000000000000000000000000000FFFFFF00B5B5B5000000
      0000B5B5B500FFFFFF0000000000000000000000000000000000FFFFFF00B5B5
      B50000000000B5B5B500FFFFFF00000000000000000063CEFF00FFFFFF0063CE
      FF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CE
      FF0063CEFF000000000000000000000000000000000000000000000000009C9C
      9C00F7FFFF0000000000CE9C0000B5B5B500B5B5B50000000000FFEFCE000000
      000063CEFF0063CEFF000000000000000000A5A5A500FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000FFFFFF00FFFFFF00000000008484
      84000000000000000000000000000000000000000000FFFFFF00000000007373
      730000000000FFFFFF0000000000000000000000000000000000FFFFFF000000
      00007373730000000000FFFFFF00000000000000000063CEFF00FFFFFF0063CE
      FF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CE
      FF0063CEFF0000000000000000000000000000000000B5B5B50000000000C6D6
      EF00F7FFFF003131310000000000000000000000000000000000000000003131
      310063CEFF0063CEFF000000000000000000A5A5A500FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00000000008484
      84000000000000000000000000000000000000000000FFFFFF00B5B5B5000000
      0000B5B5B500FFFFFF0000000000000000000000000000000000FFFFFF00B5B5
      B50000000000B5B5B500FFFFFF00000000000000000063CEFF009CFFFF0063CE
      FF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CE
      FF00009CCE0000000000000000000000000000000000000000000000000094AD
      AD00F7FFFF00F7FFFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CE
      FF0063CEFF009CCECE000000000000000000A5A5A500FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000FFFFFF00FFFFFF00000000008484
      84000000000000000000000000000000000000CE310000000000FFFFFF00FFFF
      FF00FFFFFF000000000031CE3100000000000000000031CE310000000000FFFF
      FF00FFFFFF00FFFFFF000000000000CE31000000000063CEFF009CFFFF0063CE
      FF0063CEFF0063CEFF0063CEFF0063CEFF000000000000000000000000000000
      0000000000004A4A4A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A5A5A500FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000031CE3100000000000000
      00000000000031CE31000000000000000000000000000000000031CE31000000
      0000000000000000000031CE310000000000000000000000000063CEFF0063CE
      FF0063CEFF0063CEFF0063CEFF0000000000000000004A4A4A00000000000000
      0000000000004A4A4A00000000004A4A4A000000000000000000000000000000
      0000000000000000000000000000000000007373730000000000000000000000
      000073737300000000000000000000000000A5A5A500A5A5A500A5A5A500A5A5
      A500A5A5A500A5A5A500A5A5A500000000000000000000000000FFFFFF000000
      000000000000000000000000000000000000000000000000000000CE310000CE
      310031CE310000000000000000000000000000000000000000000000000031CE
      310000CE310031CE310000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000004A4A4A004A4A
      4A004A4A4A000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000073737300737373007373
      7300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007373730000000000000000000000
      0000737373000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004A4A4A0000000000000000004A4A
      4A0000000000000000004A4A4A00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000737373000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000004A4A4A000000000000000000000000000000
      0000000000000000000073737300000000000000000000000000737373000000
      0000000000000000000073737300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000800100000100010000000000000C00000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000F862FF07FF07FFFF80E0FF07FF07FFFF
      01E0FF07FF07FFFF01E0FF07FF07FE7F31E1FF07FF07F18F31C1FB01FB01EFF7
      C181F87CF87CEFF7C30780400040EFF7FE1738003800DFFBCC37F90539050078
      A877E1FF39FFEF7F40F783FF03FFEF7F01E30FFF39FFEF7FC1E33FFF39FFF17F
      C0E339FF39FFFE7FC83F83FF03FFFFFFFFFFFFFFFFC3FFFFFFFFFE7FFFCBF80F
      FFFFF99FFFCBF007FFFFFBDFFFC3E003F18FF7EFFFE7C001CE73F7EF00E78000
      DE7BF18F00E78000BDBDC813FC008000BDBDDE7BFE008000BDBDBDBDFF3F8000
      DE7BBDBD8F3FC001CE73BDBD203FE003F18FDE7B203FC001FFFFCE730FFFC809
      FFFFF18F9FFFFF7FFFFFFFFFFFFFFE3FFFFFFFFFFFFFFF33800F800F800FFECD
      FF27FF27FF27FDCEFF33E333C333FDCEFF3BF73B993BFECDFF3BF73BBD3BFF33
      FF33F733BD33F3FFFF07F707BD07EDFFFF33F733BD33DEFFFF3BF73BBD3BDEFF
      FF3BF73BBD3BCCFFFF3BE33B183BB37FFF23FF23FF2373BF800F800F800F73BF
      FF7FFF7FFF7FB37FFFFFFFFFFFFFCCFFE00FC000FE49FFFFC0078000FE49FFFF
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
  object NewMeteringTransformMenu: TPopupMenu
    Images = ilMenu
    Left = 216
    Top = 344
    object N6: TMenuItem
      Action = NewIMeteringTransAction
    end
    object N7: TMenuItem
      Action = NewUMeteringTransAction
    end
  end
  object NewPowerTransformMenu: TPopupMenu
    Images = ilMenu
    Left = 64
    Top = 344
    object N21: TMenuItem
      Action = New2PowerTransAction
    end
    object N31: TMenuItem
      Action = New3PowerTransAction
    end
  end
  object NewLineMenu: TPopupMenu
    Images = ilMenu
    Left = 64
    Top = 408
    object N13: TMenuItem
      Action = NewTransmissionLineAction
    end
  end
  object oqSetWorkTimeActionExecute: TOraQuery
    Session = dmMain.orases
    SQL.Strings = (
      'begin ryda.loss_pg.settimep_p(:par1,:par2,:par3,:par4); end;')
    AutoCommit = False
    Options.ReturnParams = True
    Left = 240
    Top = 54
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
  object NewReactorMenu: TPopupMenu
    Images = ilMenu
    Left = 200
    Top = 420
    object N16: TMenuItem
      Action = NewReactorMenuAction
    end
  end
end
