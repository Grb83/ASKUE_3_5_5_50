object Form1: TForm1
  Left = 193
  Top = 148
  Width = 770
  Height = 612
  Caption = #1054#1082#1085#1086' '#1087#1088#1077#1076#1074#1072#1088#1080#1090#1077#1083#1100#1085#1086#1075#1086' '#1087#1088#1086#1089#1084#1086#1090#1088#1072
  Color = clBtnFace
  TransparentColorValue = clWhite
  Constraints.MinHeight = 612
  Constraints.MinWidth = 770
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnMouseWheelDown = FormMouseWheelDown
  OnMouseWheelUp = FormMouseWheelUp
  DesignSize = (
    762
    578)
  PixelsPerInch = 96
  TextHeight = 13
  object LabelScale: TLabel
    Left = 599
    Top = 244
    Width = 46
    Height = 13
    Anchors = [akTop, akRight]
    Caption = #1052#1072#1089#1096#1090#1072#1073
  end
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 3
    Height = 13
  end
  object Label2: TLabel
    Left = 528
    Top = 216
    Width = 121
    Height = 13
    Anchors = [akTop, akRight]
    Caption = #1052#1077#1078#1089#1090#1088#1086#1095#1085#1099#1081' '#1080#1085#1090#1077#1088#1074#1072#1083
  end
  object ButtonLoad: TButton
    Left = 592
    Top = 25
    Width = 137
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1092#1072#1081#1083'...'
    TabOrder = 0
    OnClick = ButtonLoadClick
  end
  object ButtonFont: TButton
    Left = 592
    Top = 59
    Width = 137
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1096#1088#1080#1092#1090'...'
    TabOrder = 1
    OnClick = ButtonFontClick
  end
  object Button3: TButton
    Left = 653
    Top = 520
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Button3'
    TabOrder = 2
    Visible = False
    OnClick = Button3Click
  end
  object ButtonRefresh: TButton
    Left = 589
    Top = 165
    Width = 140
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1054#1073#1085#1086#1074#1080#1090#1100
    Default = True
    TabOrder = 4
    OnClick = ButtonRefreshClick
  end
  object ButtonAll: TButton
    Left = 592
    Top = 128
    Width = 137
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1089#1077
    TabOrder = 3
    OnClick = ButtonAllClick
  end
  object GBSizes: TGroupBox
    Left = 528
    Top = 294
    Width = 217
    Height = 75
    Anchors = [akTop, akRight]
    Caption = #1056#1072#1079#1084#1077#1088' '#1089#1090#1088#1072#1085#1080#1094#1099
    TabOrder = 6
    object Label3: TLabel
      Left = 88
      Top = 48
      Width = 38
      Height = 13
      Caption = #1042#1099#1089#1086#1090#1072
    end
    object Label4: TLabel
      Left = 88
      Top = 24
      Width = 39
      Height = 13
      Caption = #1064#1080#1088#1080#1085#1072
    end
    object EditWidth: TEdit
      Left = 133
      Top = 20
      Width = 73
      Height = 21
      TabOrder = 0
      Text = '21'
    end
    object EditHeight: TEdit
      Left = 136
      Top = 44
      Width = 73
      Height = 21
      TabOrder = 1
      Text = '29,7'
    end
  end
  object MEScale: TMaskEdit
    Left = 656
    Top = 236
    Width = 60
    Height = 21
    Anchors = [akTop, akRight]
    EditMask = '!099 %;0; '
    MaxLength = 5
    TabOrder = 5
    Text = '100'
  end
  object ScrollBox1: TScrollBox
    Left = 16
    Top = 8
    Width = 497
    Height = 553
    HorzScrollBar.Tracking = True
    VertScrollBar.Position = 20
    VertScrollBar.Tracking = True
    Anchors = [akLeft, akTop, akRight, akBottom]
    Color = clBtnFace
    ParentColor = False
    TabOrder = 7
    object Image1: TImage
      Left = 33
      Top = 18
      Width = 425
      Height = 530
      AutoSize = True
      OnDblClick = Image1DblClick
    end
    object TBBottomIndent: TTrackBar
      Left = 16
      Top = 339
      Width = 17
      Height = 210
      Max = 0
      Min = -50
      Orientation = trVertical
      Frequency = 10
      Position = 0
      SelEnd = 0
      SelStart = 0
      TabOrder = 3
      ThumbLength = 10
      TickMarks = tmBottomRight
      TickStyle = tsAuto
      OnChange = TBIndentsChange
    end
    object TBTopIndent: TTrackBar
      Left = 16
      Top = 12
      Width = 17
      Height = 210
      Max = 50
      Orientation = trVertical
      Frequency = 10
      Position = 0
      SelEnd = 0
      SelStart = 0
      TabOrder = 2
      ThumbLength = 10
      TickMarks = tmBottomRight
      TickStyle = tsAuto
      OnChange = TBIndentsChange
    end
    object TBRightIndent: TTrackBar
      Left = 254
      Top = 1
      Width = 210
      Height = 17
      Max = 0
      Min = -50
      Orientation = trHorizontal
      Frequency = 10
      Position = 0
      SelEnd = 0
      SelStart = 0
      TabOrder = 1
      ThumbLength = 10
      TickMarks = tmBottomRight
      TickStyle = tsAuto
      OnChange = TBIndentsChange
    end
    object TBLeftIndent: TTrackBar
      Left = 27
      Top = 1
      Width = 210
      Height = 17
      Max = 50
      Orientation = trHorizontal
      Frequency = 10
      Position = 0
      SelEnd = 0
      SelStart = 0
      TabOrder = 0
      ThumbLength = 10
      TickMarks = tmBottomRight
      TickStyle = tsAuto
      OnChange = TBIndentsChange
    end
  end
  object BitBtnUp: TBitBtn
    Left = 519
    Top = 25
    Width = 26
    Height = 40
    Hint = #1055#1088#1077#1076#1099#1076#1091#1097#1072#1103' '#1089#1090#1088#1072#1085#1080#1094#1072
    Anchors = [akTop, akRight]
    ParentShowHint = False
    ShowHint = True
    TabOrder = 8
    OnClick = BitBtnUpClick
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
    Layout = blGlyphTop
    NumGlyphs = 2
  end
  object BitBtnDown: TBitBtn
    Left = 519
    Top = 65
    Width = 26
    Height = 40
    Hint = #1057#1083#1077#1076#1091#1102#1097#1072#1103' '#1089#1090#1088#1072#1085#1080#1094#1072
    Anchors = [akTop, akRight]
    ParentShowHint = False
    ShowHint = True
    TabOrder = 9
    OnClick = BitBtnDownClick
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
    Layout = blGlyphBottom
    NumGlyphs = 2
  end
  object ButtonPrint: TButton
    Left = 589
    Top = 93
    Width = 140
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1056#1072#1089#1087#1077#1095#1072#1090#1072#1090#1100
    TabOrder = 10
    OnClick = ButtonPrintClick
  end
  object MESpacing: TMaskEdit
    Tag = 100
    Left = 655
    Top = 212
    Width = 55
    Height = 21
    Anchors = [akTop, akRight]
    EditMask = '!099 %;0; '
    MaxLength = 5
    TabOrder = 11
    Text = '100'
  end
  object GroupBox1: TGroupBox
    Left = 528
    Top = 376
    Width = 217
    Height = 129
    Caption = #1054#1090#1089#1090#1091#1087#1099' '#1090#1077#1082#1089#1090#1072' '#1085#1072' '#1083#1080#1089#1090#1077
    TabOrder = 12
    object Label5: TLabel
      Left = 54
      Top = 24
      Width = 69
      Height = 13
      Caption = #1042#1077#1088#1093#1085#1077#1077' '#1087#1086#1083#1077
    end
    object Label6: TLabel
      Left = 56
      Top = 52
      Width = 67
      Height = 13
      Caption = #1053#1080#1078#1085#1077#1077' '#1087#1086#1083#1077
    end
    object Label7: TLabel
      Left = 56
      Top = 76
      Width = 59
      Height = 13
      Caption = #1051#1077#1074#1086#1077' '#1087#1086#1083#1077
    end
    object Label8: TLabel
      Left = 56
      Top = 100
      Width = 65
      Height = 13
      Caption = #1055#1088#1072#1074#1086#1077' '#1087#1086#1083#1077
    end
    object LETop: TEdit
      Left = 128
      Top = 24
      Width = 49
      Height = 21
      TabOrder = 0
      Text = '3'
    end
    object LEBottom: TEdit
      Left = 128
      Top = 48
      Width = 49
      Height = 21
      TabOrder = 1
      Text = '3'
    end
    object LELeft: TEdit
      Left = 128
      Top = 72
      Width = 49
      Height = 21
      TabOrder = 2
      Text = '3'
    end
    object LERight: TEdit
      Left = 128
      Top = 96
      Width = 49
      Height = 21
      TabOrder = 3
      Text = '3'
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'All files (*.*)|*.*'
    Title = 'Open file for preview...'
    Left = 544
    Top = 120
  end
  object FontDialog1: TFontDialog
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    MinFontSize = 0
    MaxFontSize = 0
    Left = 544
    Top = 152
  end
  object PrintDialog1: TPrintDialog
    Copies = 1
    Left = 544
    Top = 184
  end
end
