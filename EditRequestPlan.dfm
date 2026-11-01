inherited fmEditRequestPlan: TfmEditRequestPlan
  Left = 455
  Top = 55
  HelpContext = 533
  VertScrollBar.Range = 0
  BorderStyle = bsNone
  Caption = 'fmEditRequestPlan'
  ClientHeight = 602
  ClientWidth = 634
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited iplBottom: TPanel
    Top = 577
    Width = 634
    TabOrder = 2
    inherited iplClose: TPanel
      Left = 553
    end
  end
  object Panel6: TPanel [1]
    Left = 0
    Top = 0
    Width = 213
    Height = 577
    Align = alClient
    BevelOuter = bvNone
    Color = clWindow
    TabOrder = 0
    object tvChannelsList: TTreeView
      Left = 0
      Top = 23
      Width = 213
      Height = 554
      Align = alClient
      Ctl3D = True
      DragMode = dmAutomatic
      HideSelection = False
      Images = iImageList
      Indent = 19
      ParentCtl3D = False
      PopupMenu = PopupMenu1
      ReadOnly = True
      RowSelect = True
      TabOrder = 0
      OnCollapsed = tvChannelsListExpColl
      OnDragDrop = tvChannelsListDragDrop
      OnDragOver = tvChannelsListDragOver
      OnExpanding = tvChannelsListExpanding
      OnExpanded = tvChannelsListExpColl
      OnMouseDown = tvChannelsListMouseDown
    end
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 213
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
        Width = 89
        Height = 21
        Align = alClient
        BevelOuter = bvNone
        Caption = #1057#1087#1080#1089#1086#1082' '#1082#1072#1085#1072#1083#1086#1074
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
  object Panel23: TPanel [2]
    Left = 213
    Top = 0
    Width = 421
    Height = 577
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 1
    object Panel8: TPanel
      Left = 0
      Top = 0
      Width = 421
      Height = 23
      Align = alTop
      Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
    object ScrollBox1: TScrollBox
      Left = 0
      Top = 23
      Width = 421
      Height = 521
      HorzScrollBar.Range = 400
      VertScrollBar.Range = 400
      Align = alClient
      AutoScroll = False
      BorderStyle = bsNone
      TabOrder = 0
      object paEdit: TPanel
        Left = 8
        Top = 8
        Width = 401
        Height = 465
        BevelOuter = bvNone
        BevelWidth = 5
        Enabled = False
        TabOrder = 0
        object Panel22: TPanel
          Left = 0
          Top = 434
          Width = 401
          Height = 18
          Align = alTop
          BevelInner = bvLowered
          BevelOuter = bvNone
          TabOrder = 4
          object chbBlocking: TCheckBox
            Left = 6
            Top = 1
            Width = 167
            Height = 15
            Caption = '&'#1041#1083#1086#1082#1080#1088#1086#1074#1082#1072
            TabOrder = 0
            OnClick = ControlChange
          end
        end
        object Panel10: TPanel
          Left = 0
          Top = 0
          Width = 401
          Height = 64
          Align = alTop
          BevelInner = bvLowered
          BevelOuter = bvNone
          TabOrder = 0
          object Label1: TLabel
            Left = 7
            Top = 5
            Width = 25
            Height = 13
            Caption = '&'#1048#1084#1103':'
            FocusControl = eName
          end
          object Label2: TLabel
            Left = 7
            Top = 26
            Width = 66
            Height = 13
            Caption = '&'#1055#1088#1080#1084#1077#1095#1072#1085#1080#1077':'
            FocusControl = mNote
          end
          object Label7: TLabel
            Left = 7
            Top = 44
            Width = 17
            Height = 13
            Caption = #1048#1076':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsUnderline]
            ParentFont = False
          end
          object eName: TEdit
            Left = 49
            Top = 3
            Width = 346
            Height = 21
            MaxLength = 147
            TabOrder = 0
            OnChange = ControlChange
          end
          object mNote: TMemo
            Left = 92
            Top = 27
            Width = 303
            Height = 33
            TabOrder = 1
            OnChange = ControlChange
          end
          object lbId: TEdit
            Tag = 9
            Left = 25
            Top = 44
            Width = 64
            Height = 16
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
            TabOrder = 2
          end
        end
        object Panel11: TPanel
          Left = 0
          Top = 64
          Width = 401
          Height = 129
          Align = alTop
          BevelInner = bvLowered
          BevelOuter = bvNone
          TabOrder = 1
          object Panel12: TPanel
            Left = 1
            Top = 1
            Width = 399
            Height = 26
            Align = alTop
            Alignment = taLeftJustify
            BevelOuter = bvNone
            Caption = '  '#1055#1088#1086#1090#1086#1082#1086#1083':'
            TabOrder = 1
            object cbProtocol_id: TComboBox
              Left = 60
              Top = 4
              Width = 161
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
              OnChange = ControlChange
            end
            object Panel13: TPanel
              Left = 224
              Top = 0
              Width = 175
              Height = 26
              Align = alRight
              Alignment = taLeftJustify
              BevelOuter = bvNone
              Caption = ' '#1055#1086#1088#1090':'
              TabOrder = 1
              object cbCom_id: TComboBox
                Tag = 1
                Left = 32
                Top = 3
                Width = 137
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
                OnChange = ControlChange
              end
            end
          end
          object Panel15: TPanel
            Left = 1
            Top = 52
            Width = 399
            Height = 25
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 3
            object Label6: TLabel
              Left = 6
              Top = 6
              Width = 61
              Height = 13
              Caption = 'A'#1076#1088#1077#1089' '#1059#1057#1044':'
            end
            object lUser: TLabel
              Left = 110
              Top = 6
              Width = 79
              Height = 13
              Caption = #1055#1086'&'#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100' :'
              FocusControl = eUsdName
            end
            object lPassword: TLabel
              Left = 268
              Top = 7
              Width = 44
              Height = 13
              Caption = #1055#1072'&'#1088#1086#1083#1100' :'
              FocusControl = eUsdPassword
            end
            object eAddr: TEdit
              Left = 70
              Top = 2
              Width = 35
              Height = 21
              MaxLength = 99
              TabOrder = 0
              OnChange = ControlChange
            end
            object eUsdPassword: TEdit
              Left = 314
              Top = 2
              Width = 81
              Height = 21
              PasswordChar = '*'
              TabOrder = 2
              OnChange = ControlChange
            end
            object eUsdName: TEdit
              Left = 190
              Top = 2
              Width = 75
              Height = 21
              TabOrder = 1
              OnChange = ControlChange
            end
          end
          object Panel17: TPanel
            Left = 1
            Top = 27
            Width = 399
            Height = 25
            Align = alTop
            Alignment = taLeftJustify
            BevelOuter = bvNone
            Caption = '  '#1057#1090#1088'. '#1080#1085#1080#1094'. '#1084#1086#1076#1077#1084#1072':'
            TabOrder = 2
            object eInit_str: TEdit
              Left = 106
              Top = 2
              Width = 289
              Height = 21
              MaxLength = 63
              TabOrder = 0
              OnChange = ControlChange
            end
          end
          object Panel5: TPanel
            Left = 1
            Top = 128
            Width = 399
            Height = 26
            Align = alTop
            Alignment = taLeftJustify
            BevelOuter = bvNone
            Caption = '  '#1054#1087#1088#1086#1089#1095#1080#1082':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            Visible = False
            object eCaller_Name: TEdit
              Left = 79
              Top = 2
              Width = 267
              Height = 21
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              Text = 'Srv'
              OnChange = ControlChange
            end
          end
          object Panel28: TPanel
            Left = 1
            Top = 102
            Width = 399
            Height = 26
            Align = alTop
            Alignment = taLeftJustify
            BevelOuter = bvNone
            Caption = '  '#1054#1089#1085#1086#1074#1085#1086#1081' '#1082#1072#1085#1072#1083':'
            TabOrder = 5
            object cbMainChannel: TComboBox
              Tag = 1
              Left = 106
              Top = 2
              Width = 289
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
              OnChange = ControlChange
            end
          end
          object Panel4: TPanel
            Left = 1
            Top = 77
            Width = 399
            Height = 25
            Align = alTop
            Alignment = taLeftJustify
            BevelOuter = bvNone
            Caption = '  '#1044#1086#1087'. '#1087#1072#1088#1072#1084#1077#1090#1088#1099':'
            TabOrder = 4
            object eDopParam: TEdit
              Left = 106
              Top = 2
              Width = 289
              Height = 21
              MaxLength = 63
              TabOrder = 0
              OnChange = ControlChange
            end
          end
        end
        object Panel18: TPanel
          Left = 0
          Top = 193
          Width = 401
          Height = 144
          Align = alTop
          BevelInner = bvLowered
          BevelOuter = bvNone
          TabOrder = 2
          object Panel19: TPanel
            Left = 1
            Top = 1
            Width = 399
            Height = 20
            Align = alTop
            Alignment = taLeftJustify
            BevelOuter = bvNone
            Caption = '  '#1055#1072#1091#1079#1072' '#1084#1077#1078#1076#1091' '#1094#1080#1082#1083#1072#1084#1080' '#1086#1087#1088#1086#1089#1072' ('#1089#1077#1082'):'
            TabOrder = 0
            object eCycle_Tout: TEdit
              Left = 244
              Top = 2
              Width = 151
              Height = 21
              Font.Charset = RUSSIAN_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              MaxLength = 8
              ParentFont = False
              TabOrder = 0
              OnChange = ControlChange
              OnKeyPress = edLongPress
            end
          end
          object Panel20: TPanel
            Left = 1
            Top = 21
            Width = 399
            Height = 20
            Align = alTop
            Alignment = taLeftJustify
            BevelOuter = bvNone
            Caption = '  '#1050#1086#1083#1080#1095#1077#1089#1090#1074#1086'   '#1087#1086#1087#1099#1090#1086#1082'   '#1089#1086#1077#1076#1080#1085#1077#1085#1080#1103':'
            TabOrder = 1
            object eRetries: TEdit
              Left = 244
              Top = 2
              Width = 151
              Height = 21
              Font.Charset = RUSSIAN_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              MaxLength = 8
              ParentFont = False
              TabOrder = 0
              OnChange = ControlChange
              OnKeyPress = edLongPress
            end
          end
          object Panel21: TPanel
            Left = 1
            Top = 62
            Width = 399
            Height = 24
            Align = alTop
            Alignment = taLeftJustify
            BevelOuter = bvNone
            Caption = '  '#1042#1088#1077#1084#1103' '#1086#1078#1080#1076#1072#1085#1080#1103' '#1091#1089#1090#1072#1085#1086#1074#1082#1080' '#1089#1086#1077#1076#1080#1085#1077#1085#1080#1103' ('#1089#1077#1082'):'
            TabOrder = 3
            object eConnTimeWait: TEdit
              Left = 244
              Top = 2
              Width = 151
              Height = 21
              Font.Charset = RUSSIAN_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              MaxLength = 8
              ParentFont = False
              TabOrder = 0
              OnChange = ControlChange
              OnKeyPress = edLongPress
            end
          end
          object Panel29: TPanel
            Left = 1
            Top = 86
            Width = 399
            Height = 23
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 4
            object Label3: TLabel
              Left = 5
              Top = 6
              Width = 79
              Height = 13
              Caption = #1053#1072#1095#1072#1083#1086' '#1086#1087#1088#1086#1089#1072':'
            end
            object Label4: TLabel
              Left = 133
              Top = 6
              Width = 58
              Height = 13
              Caption = #1054#1082#1086#1085#1095#1072#1085#1080#1077':'
            end
            object Label5: TLabel
              Left = 260
              Top = 6
              Width = 72
              Height = 13
              Caption = #1044#1077#1085#1100' '#1086#1087#1088#1086#1089#1072' :'
            end
            object eDay: TEdit
              Left = 342
              Top = 2
              Width = 53
              Height = 21
              TabOrder = 2
              OnChange = ControlChange
              OnKeyPress = edLongPress
            end
            object meStart: TMaskEdit
              Left = 88
              Top = 2
              Width = 33
              Height = 21
              EditMask = '!99:99;1; '
              MaxLength = 5
              TabOrder = 0
              Text = '  :  '
              OnChange = ControlChange
            end
            object meEnd: TMaskEdit
              Left = 202
              Top = 2
              Width = 33
              Height = 21
              EditMask = '!99:99;1; '
              MaxLength = 5
              TabOrder = 1
              Text = '  :  '
              OnChange = ControlChange
            end
          end
          object Panel1: TPanel
            Left = 1
            Top = 41
            Width = 399
            Height = 21
            Align = alTop
            Alignment = taLeftJustify
            BevelOuter = bvNone
            Caption = '  '#1055#1072#1091#1079#1072' '#1084#1077#1078#1076#1091' '#1087#1086#1087#1099#1090#1082#1072#1084#1080', '#1087#1072#1082#1077#1090#1072#1084#1080' ('#1089#1077#1082'):'
            TabOrder = 2
            object eRetries_Tout: TEdit
              Left = 244
              Top = 2
              Width = 151
              Height = 21
              Font.Charset = RUSSIAN_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              MaxLength = 8
              ParentFont = False
              TabOrder = 0
              OnChange = ControlChange
              OnKeyPress = edLongPress
            end
          end
          object btAddParam: TButton
            Left = 5
            Top = 112
            Width = 392
            Height = 25
            Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1076#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1093' '#1086#1087#1088#1086#1089#1086#1074
            TabOrder = 5
            OnClick = btAddParamClick
          end
        end
        object Panel24: TPanel
          Left = 0
          Top = 337
          Width = 401
          Height = 97
          Align = alTop
          BevelInner = bvLowered
          BevelOuter = bvNone
          TabOrder = 3
          object Panel25: TPanel
            Left = 1
            Top = 49
            Width = 399
            Height = 22
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 2
            object chbNet_Param: TCheckBox
              Left = 5
              Top = 2
              Width = 136
              Height = 17
              Caption = '&'#1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1089#1077#1090#1080
              TabOrder = 0
              OnClick = ControlChange
            end
            object chbJournal: TCheckBox
              Left = 193
              Top = 0
              Width = 134
              Height = 20
              Caption = '&'#1046#1091#1088#1085#1072#1083' '#1089#1086#1073#1099#1090#1080#1081
              TabOrder = 1
              OnClick = ControlChange
            end
          end
          object Panel26: TPanel
            Left = 1
            Top = 25
            Width = 399
            Height = 24
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 1
            object chbCurr_Data: TCheckBox
              Left = 5
              Top = 4
              Width = 243
              Height = 17
              Caption = '&'#1058#1077#1093#1085#1080#1095#1077#1089#1082#1080#1077' '#1076#1072#1085#1085#1099#1077'        '#1043#1083#1091#1073#1080#1085#1072':'
              TabOrder = 0
              OnClick = ControlChange
            end
            object eCurr_Data_Dept: TEdit
              Left = 245
              Top = 2
              Width = 150
              Height = 21
              MaxLength = 8
              TabOrder = 1
              OnChange = ControlChange
              OnKeyPress = edLongPress
            end
          end
          object Panel27: TPanel
            Left = 1
            Top = 1
            Width = 399
            Height = 24
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 0
            object chbBill_Data: TCheckBox
              Left = 5
              Top = 4
              Width = 238
              Height = 17
              Caption = '&'#1050#1086#1084#1084#1077#1088#1095#1077#1089#1082#1080#1077' '#1076#1072#1085#1085#1099#1077'    '#1043#1083#1091#1073#1080#1085#1072':'
              TabOrder = 0
              OnClick = ControlChange
            end
            object eBill_Data_Dept: TEdit
              Left = 245
              Top = 3
              Width = 150
              Height = 21
              MaxLength = 8
              TabOrder = 1
              OnChange = ControlChange
              OnKeyPress = edLongPress
            end
          end
          object chbNReadCurr: TCheckBox
            Left = 6
            Top = 73
            Width = 159
            Height = 17
            Caption = '&'#1053#1077' '#1095#1080#1090#1072#1090#1100' '#1090#1077#1082#1091#1097#1080#1077' '#1089#1091#1090#1082#1080
            TabOrder = 3
            OnClick = ControlChange
          end
          object cbBlockingTime: TCheckBox
            Left = 193
            Top = 73
            Width = 191
            Height = 17
            Caption = #1041#1083#1086#1082#1080#1088#1086#1074#1082#1072' '#1082#1086#1088#1088#1077#1082#1094#1080#1080' &'#1074#1088#1077#1084#1077#1085#1080
            TabOrder = 4
            OnClick = ControlChange
          end
        end
      end
    end
    object ToolBar1: TToolBar
      Left = 0
      Top = 544
      Width = 421
      Height = 33
      Align = alBottom
      Caption = 'ToolBar1'
      Images = ilMenu
      TabOrder = 2
      object ToolButton1: TToolButton
        Left = 0
        Top = 2
        Action = iaNew
      end
      object ToolButton2: TToolButton
        Left = 23
        Top = 2
        Action = aNewGroup
      end
      object ToolButton3: TToolButton
        Left = 46
        Top = 2
        Action = iaDelete
      end
      object ToolButton4: TToolButton
        Left = 69
        Top = 2
        Action = iaClone
      end
      object ToolButton5: TToolButton
        Left = 92
        Top = 2
        Action = aState
      end
      object ToolButton6: TToolButton
        Left = 115
        Top = 2
        Action = iaPoints
      end
      object ToolButton7: TToolButton
        Left = 138
        Top = 2
        Action = aQuick
      end
      object tbFind: TToolButton
        Left = 161
        Top = 2
        Action = iaFind
      end
      object ToolButton10: TToolButton
        Left = 184
        Top = 2
        Width = 14
        Caption = 'ToolButton10'
        ImageIndex = 0
        Style = tbsSeparator
      end
      object ToolButton8: TToolButton
        Left = 198
        Top = 2
        Action = iaMTX
      end
      object tbNP: TToolButton
        Left = 221
        Top = 2
        Action = iaRTR56
        ImageIndex = 83
      end
      object ToolButton11: TToolButton
        Left = 244
        Top = 2
        Width = 14
        Caption = 'ToolButton11'
        ImageIndex = 84
        Style = tbsSeparator
      end
      object ToolButton9: TToolButton
        Left = 258
        Top = 2
        Action = iaRTR
      end
    end
  end
  inherited MenuSAA: TMainMenu
    Left = 72
    Top = 40
  end
  inherited PopupMenu1: TPopupMenu
    Left = 104
    Top = 40
    inherited mMon: TMenuItem
      Enabled = True
      Visible = True
      OnClick = mMonClick
    end
  end
  inherited alDefault: TActionList
    Left = 136
    Top = 40
    inherited iaPoints: TAction
      ShortCut = 32848
    end
    inherited iaNew: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1082#1072#1085#1072#1083
    end
    inherited iaClone: TAction
      ShortCut = 32843
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
    inherited iaMTX: TAction
      ImageIndex = 82
      OnExecute = iaMTXExecute
    end
    object aBlocking: TAction
      Caption = '&'#1041#1083#1086#1082#1080#1088#1086#1074#1072#1090#1100
      ShortCut = 32956
      OnExecute = aExecute
    end
    object aBillData: TAction
      Caption = '&'#1050#1086#1084#1084#1077#1088#1095#1077#1089#1082#1080#1077' '#1076#1072#1085#1085#1099#1077
      ShortCut = 32850
      OnExecute = aExecute
    end
    object aCurrData: TAction
      Caption = '&'#1058#1077#1093#1085#1080#1095#1077#1089#1082#1080#1077' '#1076#1072#1085#1085#1099#1077
      ShortCut = 32846
      OnExecute = aExecute
    end
    object aNetParam: TAction
      Caption = '&'#1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1089#1077#1090#1080
      ShortCut = 32839
      OnExecute = aExecute
    end
    object aJournal: TAction
      Caption = '&'#1046#1091#1088#1085#1072#1083' '#1089#1086#1073#1099#1090#1080#1081
      ShortCut = 32954
      OnExecute = aExecute
    end
    object aNReadCurr: TAction
      Caption = #1041#1083#1086#1082#1080#1088#1086#1074#1082#1072' '#1082#1086#1088#1088#1077#1082#1094#1080#1080' &'#1074#1088#1077#1084#1077#1085#1080
      ShortCut = 32857
      OnExecute = aExecute
    end
    object aNewGroup: TAction
      Category = 'PopupMenu'
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1075#1088#1091#1087#1087#1091
      Enabled = False
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1075#1088#1091#1087#1087#1091
      ImageIndex = 0
      ShortCut = 118
      OnExecute = aNewGroupExecute
    end
    object aState: TAction
      Category = 'PopupMenu'
      Caption = '&'#1057#1086#1089#1090#1086#1103#1085#1080#1077' '#1086#1087#1088#1086#1089#1072
      Enabled = False
      Hint = #1057#1086#1089#1090#1086#1103#1085#1080#1077' '#1086#1087#1088#1086#1089#1072
      ImageIndex = 37
      ShortCut = 32847
      OnExecute = aStateExecute
    end
    object aQuick: TAction
      Category = 'PopupMenu'
      Caption = #1054#1087#1077#1088#1072#1090#1080#1074#1085#1099#1081' '#1086#1087#1088#1086#1089
      Enabled = False
      Hint = #1054#1087#1077#1088#1072#1090#1080#1074#1085#1099#1081' '#1086#1087#1088#1086#1089
      ImageIndex = 81
      ShortCut = 32841
      OnExecute = aQuickExecute
    end
    object aNLockCorrectTime: TAction
      Caption = #1041#1083#1086#1082#1080#1088#1086#1074#1082#1072' '#1082#1086#1088#1088#1077#1082#1094#1080#1080' &'#1074#1088#1077#1084#1077#1085#1080
      ShortCut = 32836
      OnExecute = aExecute
    end
    object iaRTR56: TAction
      Category = 'MenuSAA'
      Caption = #1057#1086#1089#1090#1086#1103#1085#1080#1077' RTR56 '#1084#1072#1088#1096#1088#1091#1090#1080#1079#1072#1090#1086#1088#1086#1074'...'
      Hint = #1057#1086#1089#1090#1086#1103#1085#1080#1077' RTR56 '#1084#1072#1088#1096#1088#1091#1090#1080#1079#1072#1090#1086#1088#1086#1074'...'
      ImageIndex = 82
      OnExecute = iaRTR56Execute
    end
    object iaRTR: TAction
      Category = 'MenuSAA'
      Caption = #1057#1086#1089#1090#1086#1103#1085#1080#1077' '#1084#1072#1088#1096#1088#1091#1090#1080#1079#1072#1090#1086#1088#1072'...'
      Enabled = False
      Hint = #1057#1086#1089#1090#1086#1103#1085#1080#1077' '#1084#1072#1088#1096#1088#1091#1090#1080#1079#1072#1090#1086#1088#1072'...'
      ImageIndex = 7
      Visible = False
      OnExecute = iaRTRExecute
    end
  end
  inherited iImageList: TImageList
    Left = 168
    Top = 40
  end
  inherited ilMenu: TImageList
    Left = 40
    Top = 40
    Bitmap = {
      494C010154005900040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000007001000001002000000000000070
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      840084848400FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000008400000084000000FF00000084000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      84008484840084848400FFFFFF00000000000000000000000000000000008400
      0000FF000000840000008400000084000000FF00000084000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840084848400848484000000
      0000FFFFFF008484840084848400848484008484840084848400848484008484
      84008484840084848400FFFFFF0000000000000000000000000084000000FF00
      0000840000000084840000848400840000008400000084000000840000008400
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840084848400FFFFFF008484
      8400848484008484840084848400848484008484840084848400848484008484
      84008484840084848400FFFFFF00000000000000000084000000FF0000008400
      0000FF000000008484000084840084000000FF00000084000000FF0000008400
      0000008484000084840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F7CEA500C6006300000000000000
      00000000000000000000C6842100C600630000000000F7CEA500C60063000000
      0000000000000000000000000000000000008484840084848400FFFFFF008484
      8400848484008484840084848400848484008484840084848400848484008484
      84008484840084848400FFFFFF00000000000000000084000000FF000000FF00
      0000FF0000000084840000848400008484008400000084000000840000008400
      0000008484000084840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F7CEA500C6006300000000000000
      000000000000F7CEA500FF000000C600630000000000F7CEA500C60063000000
      0000000000000000000000000000000000008484840084848400FFFFFF008484
      8400848484008484840084848400848484008484840084848400848484008484
      84008484840084848400FFFFFF0000000000FF000000FF000000FF000000FF00
      0000FF000000008484000084840000848400FF000000FF000000FF0000008400
      0000FF000000840000008400000000000000C6A56300C684E700F7CEA500C600
      630000000000C6A56300C6A5E7000000000000000000C6638400000000000000
      0000FF000000F7FFFF0000000000F7CEA500F7CEA500C6006300000000000000
      000000000000C6630000C6848400C600630000000000F7CEA500C60063000000
      0000000000000000000000000000000000008484840084848400FFFFFF008484
      8400848484008484840084848400848484008484840084848400848484008484
      84008484840084848400FFFFFF000000000084000000FF000000FF0000000084
      840000848400008484000084840000848400FF000000FF000000FF0000008400
      00008400000084000000FF00000000000000C6A56300C684E700C6A56300C684
      8400C6A5E700C6A56300C6A5E7000000000000000000C6638400000000000000
      0000F7CEA500C621840000000000C6216300F7CEA500C6006300000000000000
      0000F7CEA500C663A500F7CEA500C600630000000000F7CEA500C60063000000
      0000000000000000000000000000000000008484840084848400FFFFFF008484
      8400848484008484840084848400848484008484840084848400848484008484
      84008484840084848400FFFFFF0000000000FF00000084000000008484000084
      840000848400008484000084840000848400FF00000000848400FF0000008400
      0000FF000000FF000000FF00000000000000C6A56300C684E700C66363000000
      0000C684A500C6A56300C6A5E7000000000000000000C6638400000000000000
      000000000000C6A56300FF000000C6A5E700F7CEA500C6006300000000000000
      0000FF000000F7FFFF00F7CEA500C600630000000000F7CEA500FF000000FF00
      0000FF000000FF000000FF000000F7FFFF008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      84008484840084848400FFFFFF000000000084000000FF000000FF0000000084
      840000848400008484000084840000848400008484000084840000848400FF00
      000084000000FF0000008400000000000000C6A56300C6848400C663A5000000
      0000C6846300C6846300C6A5E7000000000000000000C6638400000000000000
      000000000000F7CEA500FF000000F7FFFF00F7CEA500C600630000000000C6A5
      6300C663A50000000000F7CEA500C600630000000000F7CEA500C60063000000
      00000000000000000000C6A56300C60063008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      84008484840084848400FFFFFF0000000000FF000000FF000000FF0000000084
      840000848400FF000000FF00000084000000008484000084840000848400FF00
      0000FF00000084000000FF00000000000000C6A56300FF000000C6A5E7000000
      0000F7CEA500FF000000C6A5E7000000000000000000C6638400000000000000
      000000000000C6216300F7CEA500C6218400F7CEA500C600630000000000C621
      63000000000000000000F7CEA500C600630000000000F7CEA500C60063000000
      0000000000000000000000000000FF0000000000000084848400848484008484
      840084848400848484008484840084848400000000008484840000000000FFFF
      FF00FFFFFF0084848400000000008484840000000000FF000000FF000000FF00
      0000FF000000FF00000000848400008484000084840000848400008484000084
      840084000000FF0000000000000000000000C6A56300C6006300000000000000
      000000000000FF000000C6A56300FF000000FF000000FF000000FF000000C663
      A500C6842100C684E70000000000C6A56300F7CEA500C6006300C6842100C684
      E7000000000000000000F7CEA500C600630000000000F7CEA500C60063000000
      0000000000000000000000000000FF0000000000000000000000848484008484
      8400848484008484840084848400000000000000000000000000848484008484
      8400848484000000000000000000000000000000000084000000FF0000000084
      8400008484000084840000848400008484000084840000848400008484000084
      8400FF000000FF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F7CEA500FF000000C60063000000
      00000000000000000000F7CEA500C600630000000000F7CEA500C60063000000
      00000000000000000000C6A56300FF0000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000FFFFFF000000000000000000008484000084
      84000084840000848400FF000000FF00000000848400FF000000008484000084
      8400FF0000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F7CEA500FF000000C684E7000000
      00000000000000000000F7CEA500C600630000000000F7CEA500FF000000FF00
      0000FF000000FF000000FF000000F7FFFF000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000008484
      8400000000000000000084848400000000000000000000000000000000000084
      840000848400FF000000FF00000084000000FF00000084000000FF000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000848484000000000000000000000000000000
      000000000000FF00000084000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
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
      2800000040000000700100000100010000000000800B00000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000C003FFFFFFFFFFFF8001F83FFFFFFFFF
      0001E00FFFFFFFFF1001C007FFFFFFFF00018003FFFF3C9F00018003FFFF389F
      0001000109B2389F0001000101B2309F0001000111B830800001000111B8249C
      0001000111B82C9E80A2800338020C9EC1C78003FFFF1C9CFFB6C007FFFF1C80
      FF6DE00FFFFFFFFFFFFEF83FFFFFFFFFE00FC000FE49FFFFC0078000FE49FFFF
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
  object oqEditReqPlan: TOraQuery
    Session = dmMain.orases
    Left = 110
    Top = 130
  end
  object oqSaveP: TOraQuery
    Session = dmMain.orases
    AutoCommit = False
    Left = 56
    Top = 256
  end
end
