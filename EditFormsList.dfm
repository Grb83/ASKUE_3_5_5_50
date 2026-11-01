inherited FormEditFormList: TFormEditFormList
  Left = 697
  Top = 38
  HelpContext = 523
  VertScrollBar.Range = 0
  BorderStyle = bsNone
  Caption = 'FormEditFormList'
  ClientHeight = 644
  ClientWidth = 593
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited iplBottom: TPanel
    Top = 619
    Width = 593
    TabOrder = 2
    inherited iplClose: TPanel
      Left = 512
    end
  end
  object Panel6: TPanel [1]
    Left = 0
    Top = 0
    Width = 211
    Height = 619
    Align = alClient
    BevelOuter = bvNone
    BiDiMode = bdLeftToRight
    Color = clWindow
    ParentBiDiMode = False
    TabOrder = 0
    object Panel7: TPanel
      Left = 0
      Top = 0
      Width = 211
      Height = 28
      Align = alTop
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object Panel14: TPanel
        Left = 149
        Top = 1
        Width = 61
        Height = 26
        Align = alClient
        BevelOuter = bvNone
        Caption = #1060#1086#1088#1084#1099
        TabOrder = 0
      end
      object Panel17: TPanel
        Left = 1
        Top = 1
        Width = 148
        Height = 26
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 1
        object cbSchema: TComboBox
          Left = 2
          Top = 1
          Width = 141
          Height = 24
          Style = csDropDownList
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemHeight = 16
          ParentFont = False
          TabOrder = 0
        end
      end
    end
    object tvForm: TTreeView
      Left = 0
      Top = 28
      Width = 211
      Height = 591
      Align = alClient
      DragMode = dmAutomatic
      HideSelection = False
      Images = iImageList
      Indent = 19
      PopupMenu = PopupMenu1
      ReadOnly = True
      TabOrder = 1
      OnCollapsed = tvExpColl
      OnDeletion = tvDeletion
      OnDragDrop = tvFormDragDrop
      OnDragOver = tvFormDragOver
      OnExpanding = tvExpanding
      OnExpanded = tvExpColl
    end
  end
  object Panel5: TPanel [2]
    Left = 211
    Top = 0
    Width = 382
    Height = 619
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 1
    object Panel16: TPanel
      Left = 0
      Top = 585
      Width = 382
      Height = 34
      Align = alBottom
      Caption = ' '
      TabOrder = 1
      object btDel: TSpeedButton
        Left = 3
        Top = 5
        Width = 30
        Height = 25
        Action = iaDelete
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
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
        ParentFont = False
      end
      object btClon: TSpeedButton
        Left = 37
        Top = 5
        Width = 28
        Height = 25
        Action = iaClone
        Glyph.Data = {
          1E070000424D1E07000000000000360000002800000022000000110000000100
          180000000000E806000000000000000000000000000000000000C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8
          D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
          0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4C8D0D4C8D0D4C8D0
          D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4
          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D48080808080
          80808080808080808080808080C8D0D40000C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C004040404040404040404040404040404
          0404C0C0C0C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
          C8D0D4C8D0D4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8
          D0D4C8D0D4C8D0D4C8D0D4808080808080808080808080808080808080FFFFFF
          0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          999999040404040404040404040404999999C0C0C0C8D0D4FFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFC8D0D4C8D0D4C8D0D480808080808080808080808080
          8080808080FFFFFF0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0040404009900009900009900009900040404C0C0C0808080
          808080808080808080808080808080C8D0D4C8D0D4C8D0D4C8D0D48080808080
          80808080808080808080808080FFFFFF00000404040404040404040404040404
          04040404C0C0C0C0C0C0C0C0C0C0C0C004040466FF6666FF6666FF6666FF6604
          0404C0C0C0C8D0D4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC8D0D4C8D0D4
          C8D0D4808080808080808080808080808080808080FFFFFF0000C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0040404CCFFCCCCFF
          CCCCFFCCCCFFCC040404C0C0C0808080808080808080808080808080808080FF
          FFFFC8D0D4C8D0D4C8D0D4808080FFFFFFC8D0D4C8D0D4C8D0D4808080FFFFFF
          0000999999040404040404040404040404999999C0C0C0C0C0C0C0C0C0C0C0C0
          040404FFFFFFFFFFFFFFFFFFFFFFFF040404C0C0C08080808080808080808080
          80808080808080FFFFFFC8D0D4C8D0D4C8D0D4808080FFFFFFFFFFFFFFFFFFFF
          FFFF808080FFFFFF0000040404009900009900009900009900040404C0C0C0C0
          C0C0C0C0C0C0C0C0040404FFFFFFFFFFFFFFFFFFFFFFFF040404C0C0C0808080
          808080808080808080808080808080FFFFFFC8D0D4C8D0D4C8D0D48080808080
          80808080808080808080808080C8D0D4000004040466FF6666FF6666FF6666FF
          66040404C0C0C0C0C0C0C0C0C0C0C0C099999904040404040404040404040499
          9999C0C0C0808080808080808080808080808080808080FFFFFFC8D0D4C8D0D4
          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D40000040404CCFFCC
          CCFFCCCCFFCCCCFFCC040404C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0808080FFFFFFC8D0D4C8D0D4C8D0D4808080FF
          FFFFC8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
          0000040404FFFFFFFFFFFFFFFFFFFFFFFF040404C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0808080FFFFFFFFFFFFFFFF
          FFFFFFFF808080FFFFFFC8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8
          D0D4C8D0D4C8D0D40000040404FFFFFFFFFFFFFFFFFFFFFFFF040404C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0808080
          808080808080808080808080808080C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0
          D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D400009999990404040404040404040404
          04999999C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D40000C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8
          D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
          0000}
        NumGlyphs = 2
      end
      object BtnLoadFile: TBitBtn
        Left = 218
        Top = 5
        Width = 99
        Height = 25
        Action = aLoadFile
        Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1092#1072#1081#1083'...'
        TabOrder = 1
      end
      object btRight: TBitBtn
        Left = 82
        Top = 5
        Width = 127
        Height = 25
        Action = aRight
        Caption = #1056#1072#1079#1088#1077#1096#1080#1090#1100' '#1075#1088#1091#1087#1087#1091
        TabOrder = 0
      end
    end
    object pgControl: TPageControl
      Left = 0
      Top = 0
      Width = 382
      Height = 585
      ActivePage = tsParam
      Align = alClient
      ParentShowHint = False
      ShowHint = False
      TabIndex = 1
      TabOrder = 0
      OnChange = pgControlChange
      object tsTemp: TTabSheet
        HelpContext = 5231
        Caption = #1064#1072#1073#1083#1086#1085#1099
        ParentShowHint = False
        ShowHint = False
        object tvTemp: TTreeView
          Left = 0
          Top = 0
          Width = 374
          Height = 557
          Align = alClient
          DragMode = dmAutomatic
          HideSelection = False
          Images = iImageList
          Indent = 19
          ReadOnly = True
          TabOrder = 0
          OnCollapsed = tvExpColl
          OnDeletion = tvDeletion
          OnExpanding = tvExpanding
          OnExpanded = tvExpColl
          OnStartDrag = tvTempStartDrag
        end
      end
      object tsParam: TTabSheet
        HelpContext = 5232
        Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099
        object Panel9: TPanel
          Left = 0
          Top = 0
          Width = 374
          Height = 557
          Align = alClient
          BevelOuter = bvNone
          Caption = 'Panel9'
          TabOrder = 0
          object paAll: TPanel
            Left = 0
            Top = 0
            Width = 374
            Height = 557
            Align = alClient
            BevelInner = bvLowered
            BevelOuter = bvNone
            TabOrder = 0
            object Panel10: TPanel
              Left = 1
              Top = 1
              Width = 372
              Height = 176
              Align = alTop
              BevelOuter = bvNone
              TabOrder = 0
              object PnlTimePnl: TPanel
                Left = 0
                Top = 101
                Width = 372
                Height = 74
                Align = alTop
                BevelOuter = bvNone
                TabOrder = 1
                object btnMainSelect: TSpeedButton
                  Left = 345
                  Top = 47
                  Width = 21
                  Height = 21
                  Hint = #1048#1079#1084#1077#1085#1080#1090#1100' '#1074#1077#1088#1096#1080#1085#1091' '#1076#1086#1089#1090#1091#1087#1085#1086#1089#1090#1080'...'
                  Enabled = False
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
                object cbTimeFields: TCheckBox
                  Tag = 1
                  Left = 14
                  Top = 2
                  Width = 165
                  Height = 17
                  Caption = #1042#1074#1086#1076' '#1087#1086#1083#1103' '#1074#1088#1077#1084#1077#1085#1080
                  TabOrder = 0
                end
                object cbSecondBound: TCheckBox
                  Tag = 2
                  Left = 14
                  Top = 26
                  Width = 169
                  Height = 18
                  Caption = #1042#1090#1086#1088#1072#1103' '#1074#1088#1077#1084#1077#1085#1085#1072#1103' '#1075#1088#1072#1085#1080#1094#1072
                  TabOrder = 1
                end
                object cbCheckPoints: TCheckBox
                  Tag = 6
                  Left = 14
                  Top = 50
                  Width = 143
                  Height = 17
                  Caption = #1042#1099#1073#1086#1088' '#1090#1086#1095#1077#1082' '#1085#1072#1095#1080#1085#1072#1103' '#1089':'
                  TabOrder = 2
                end
                object eDuplPoint: TEdit
                  Tag = 9
                  Left = 156
                  Top = 47
                  Width = 189
                  Height = 21
                  Color = clMenu
                  ReadOnly = True
                  TabOrder = 3
                  OnDblClick = eDuplPointDblClick
                  OnKeyDown = eDuplPointKeyDown
                end
              end
              object PnlNameComment: TPanel
                Left = 0
                Top = 0
                Width = 372
                Height = 101
                Align = alTop
                BevelOuter = bvNone
                TabOrder = 0
                object paComment: TPanel
                  Left = 0
                  Top = 23
                  Width = 372
                  Height = 48
                  Align = alTop
                  BevelOuter = bvNone
                  TabOrder = 1
                  object Label2: TLabel
                    Left = 2
                    Top = 6
                    Width = 73
                    Height = 13
                    Alignment = taCenter
                    Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081':'
                    Font.Charset = RUSSIAN_CHARSET
                    Font.Color = clBlack
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                  end
                  object Label3: TLabel
                    Left = 2
                    Top = 30
                    Width = 42
                    Height = 13
                    Alignment = taCenter
                    Caption = #1064#1072#1073#1083#1086#1085':'
                    Font.Charset = RUSSIAN_CHARSET
                    Font.Color = clBlack
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                  end
                  object edComment: TEdit
                    Tag = 1
                    Left = 78
                    Top = 2
                    Width = 289
                    Height = 21
                    MaxLength = 199
                    TabOrder = 0
                  end
                  object edTemplates: TEdit
                    Tag = 1
                    Left = 78
                    Top = 26
                    Width = 289
                    Height = 21
                    Color = clBtnFace
                    MaxLength = 199
                    ReadOnly = True
                    TabOrder = 1
                  end
                end
                object Panel8: TPanel
                  Left = 0
                  Top = 0
                  Width = 372
                  Height = 23
                  Align = alTop
                  BevelOuter = bvNone
                  TabOrder = 0
                  object Label1: TLabel
                    Left = 2
                    Top = 6
                    Width = 64
                    Height = 13
                    Alignment = taCenter
                    Caption = #1048#1084#1103' '#1092#1086#1088#1084#1099':'
                    Font.Charset = RUSSIAN_CHARSET
                    Font.Color = clBlack
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                  end
                  object Label4: TLabel
                    Left = 309
                    Top = 6
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
                  object edName: TEdit
                    Left = 78
                    Top = 2
                    Width = 229
                    Height = 21
                    MaxLength = 199
                    TabOrder = 0
                  end
                  object lbFormId: TEdit
                    Tag = 9
                    Left = 328
                    Top = 6
                    Width = 39
                    Height = 17
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
                    TabOrder = 1
                  end
                end
                object PnlProcName: TPanel
                  Left = 0
                  Top = 71
                  Width = 372
                  Height = 28
                  Align = alTop
                  BevelOuter = bvNone
                  TabOrder = 2
                  object lbPLProc: TLabel
                    Left = 2
                    Top = 5
                    Width = 58
                    Height = 13
                    Alignment = taCenter
                    Caption = #1055#1088#1086#1094#1077#1076#1091#1088#1072':'
                    Font.Charset = RUSSIAN_CHARSET
                    Font.Color = clBlack
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                  end
                  object edPLProc: TEdit
                    Tag = 2
                    Left = 78
                    Top = 2
                    Width = 289
                    Height = 21
                    MaxLength = 199
                    TabOrder = 0
                  end
                end
              end
            end
            object paControl: TPanel
              Left = 1
              Top = 177
              Width = 372
              Height = 238
              Align = alTop
              BevelOuter = bvNone
              TabOrder = 1
              object Panel12: TPanel
                Left = 0
                Top = 0
                Width = 372
                Height = 137
                Align = alTop
                BevelInner = bvLowered
                BevelOuter = bvNone
                TabOrder = 0
                object Panel13: TPanel
                  Left = 1
                  Top = 1
                  Width = 370
                  Height = 19
                  Align = alTop
                  Caption = #1055#1088#1086#1092#1080#1083#1080
                  TabOrder = 0
                end
                object Panel11: TPanel
                  Left = 1
                  Top = 20
                  Width = 370
                  Height = 116
                  Align = alClient
                  BevelOuter = bvNone
                  TabOrder = 1
                  object Panel15: TPanel
                    Left = 0
                    Top = 0
                    Width = 370
                    Height = 16
                    Align = alTop
                    BevelOuter = bvNone
                    TabOrder = 2
                    object Panel19: TPanel
                      Left = 0
                      Top = 0
                      Width = 45
                      Height = 16
                      Hint = #1058#1080#1087' '#1087#1088#1086#1092#1080#1083#1103
                      Align = alLeft
                      Caption = #1064#1072#1075
                      TabOrder = 0
                    end
                    object Panel20: TPanel
                      Left = 45
                      Top = 0
                      Width = 186
                      Height = 16
                      Align = alLeft
                      Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
                      TabOrder = 1
                    end
                    object Panel21: TPanel
                      Left = 231
                      Top = 0
                      Width = 139
                      Height = 16
                      Hint = #1064#1072#1075' '#1087#1088#1086#1092#1080#1083#1103' '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
                      Align = alClient
                      Caption = #1054#1089#1085#1086#1074#1085#1086#1081
                      TabOrder = 2
                    end
                  end
                  object Panel22: TPanel
                    Left = 237
                    Top = 16
                    Width = 133
                    Height = 100
                    Align = alClient
                    BevelOuter = bvNone
                    TabOrder = 1
                    object rb1: TRadioButton
                      Tag = 1
                      Left = 20
                      Top = 4
                      Width = 25
                      Height = 17
                      Caption = ' '
                      TabOrder = 0
                    end
                    object rb2: TRadioButton
                      Tag = 2
                      Left = 20
                      Top = 28
                      Width = 25
                      Height = 17
                      Caption = ' '
                      TabOrder = 1
                    end
                    object rb3: TRadioButton
                      Tag = 3
                      Left = 20
                      Top = 52
                      Width = 25
                      Height = 17
                      Caption = ' '
                      TabOrder = 2
                    end
                    object rb4: TRadioButton
                      Tag = 4
                      Left = 20
                      Top = 76
                      Width = 25
                      Height = 17
                      Caption = ' '
                      TabOrder = 3
                    end
                  end
                  object Panel23: TPanel
                    Left = 0
                    Top = 16
                    Width = 237
                    Height = 100
                    Align = alLeft
                    BevelOuter = bvNone
                    TabOrder = 0
                    object cb1: TCheckBox
                      Tag = 1
                      Left = 14
                      Top = 4
                      Width = 200
                      Height = 17
                      Caption = '                          '#1052#1077#1089#1103#1095#1085#1099#1081
                      TabOrder = 0
                    end
                    object cb2: TCheckBox
                      Tag = 2
                      Left = 14
                      Top = 28
                      Width = 200
                      Height = 17
                      Caption = '                          '#1057#1091#1090#1086#1095#1085#1099#1081
                      TabOrder = 1
                    end
                    object cb3: TCheckBox
                      Tag = 3
                      Left = 14
                      Top = 52
                      Width = 200
                      Height = 17
                      Caption = '                          '#1063#1072#1089#1086#1074#1086#1081
                      TabOrder = 2
                    end
                    object cb4: TCheckBox
                      Tag = 4
                      Left = 14
                      Top = 76
                      Width = 200
                      Height = 17
                      Caption = '                          '#1052#1080#1085#1091#1090#1085#1099#1081
                      TabOrder = 3
                    end
                  end
                end
              end
              object cbGroup: TCheckBox
                Left = 14
                Top = 145
                Width = 97
                Height = 17
                Caption = #1042#1099#1073#1086#1088' '#1075#1088#1091#1087#1087#1099
                TabOrder = 1
              end
              object cbCalendar: TCheckBox
                Tag = 5
                Left = 14
                Top = 192
                Width = 97
                Height = 17
                Caption = #1050#1072#1083#1077#1085#1076#1072#1088#1100
                TabOrder = 3
              end
              object cbPoint: TCheckBox
                Tag = 6
                Left = 14
                Top = 168
                Width = 97
                Height = 17
                Caption = #1042#1099#1073#1086#1088' '#1090#1086#1095#1077#1082
                TabOrder = 2
              end
              object cbRegime: TCheckBox
                Tag = 7
                Left = 14
                Top = 215
                Width = 194
                Height = 17
                Caption = #1055#1077#1088#1077#1095#1077#1085#1100' '#1086#1090#1086#1073#1088#1072#1078#1072#1077#1084#1099#1093' '#1076#1072#1085#1085#1099#1093
                TabOrder = 4
                Visible = False
              end
            end
            object paParButton: TPanel
              Left = 1
              Top = 415
              Width = 372
              Height = 41
              Align = alTop
              BevelOuter = bvNone
              TabOrder = 2
              object btParam: TButton
                Left = 8
                Top = 2
                Width = 145
                Height = 25
                Caption = #1057#1087#1077#1094#1080#1072#1083#1100#1085#1099#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1099
                TabOrder = 0
                OnClick = btParamClick
              end
            end
          end
        end
      end
      object tsGroup: TTabSheet
        HelpContext = 5233
        Caption = #1044#1086#1089#1090#1091#1087#1085#1099#1077' '#1075#1088#1091#1087#1087#1099
        object tvGroup: TTreeView
          Left = 0
          Top = 0
          Width = 374
          Height = 557
          Align = alClient
          DragMode = dmAutomatic
          HideSelection = False
          Images = iImageList
          Indent = 19
          ReadOnly = True
          TabOrder = 0
          OnAdvancedCustomDrawItem = tvGroupAdvancedCustomDrawItem
          OnDeletion = tvGroupDeletion
          OnKeyPress = tvGroupKeyPress
        end
      end
    end
  end
  inherited alDefault: TActionList
    inherited iaDelete: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1092#1086#1088#1084#1091
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1090#1077#1082#1091#1097#1091#1102' '#1092#1086#1088#1084#1091
    end
    inherited iaClone: TAction
      Caption = #1050#1083#1086#1085#1080#1088#1086#1074#1072#1090#1100' '#1089#1093#1077#1084#1091
      Hint = #1050#1083#1086#1085#1080#1088#1086#1074#1072#1090#1100' '#1090#1077#1082#1091#1097#1091#1102' '#1089#1093#1077#1084#1091
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
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '*.xls'
    Filter = 
      #1060#1072#1081#1083#1099' '#1089' Excel-'#1086#1090#1095#1105#1090#1072#1084#1080' (*.xls)|*.xls|'#1060#1072#1081#1083#1099'-'#1096#1072#1073#1083#1086#1085#1099' '#1089' Excel-'#1086#1090#1095#1105#1090 +
      #1072#1084#1080' (*.xlt)|*.xlt|'#1060#1072#1081#1083#1099' '#1089#1093#1077#1084#1099' '#1089#1077#1090#1080' '#1052#1054#1044#1059#1057' (*.sde)|*.sde|'#1060#1072#1081#1083#1099' '#1089#1093#1077 +
      #1084#1099' '#1089#1077#1090#1080' (*.des)|*.des|'#1042#1089#1077' '#1092#1072#1081#1083#1099' (*.*)|*.*'
    Left = 61
    Top = 40
  end
  object ActionList1: TActionList
    Left = 24
    Top = 40
    object aRight: TAction
      Caption = #1056#1072#1079#1088#1077#1096#1080#1090#1100' '#1075#1088#1091#1087#1087#1091
      Enabled = False
      OnExecute = btRightClick
    end
    object aLoadFile: TAction
      Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1092#1072#1081#1083'...'
      Enabled = False
      ShortCut = 16463
      OnExecute = BtnLoadFileClick
    end
  end
  object oqvSave: TOraQuery
    Session = dmMain.orases
    AutoCommit = False
    Options.ReturnParams = True
    Left = 138
    Top = 58
  end
end
