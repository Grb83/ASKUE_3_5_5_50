object fmInputMeterage: TfmInputMeterage
  Left = 419
  Top = 219
  BorderStyle = bsDialog
  Caption = #1042#1074#1086#1076' '#1087#1086#1082#1072#1079#1072#1085#1080#1081' '#1054#1042
  ClientHeight = 460
  ClientWidth = 332
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 332
    Height = 430
    Align = alClient
    TabOrder = 0
    object Panel4: TPanel
      Left = 1
      Top = 1
      Width = 330
      Height = 46
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object Label3: TLabel
        Left = 10
        Top = 10
        Width = 91
        Height = 13
        Caption = #1055#1086#1082#1072#1079#1072#1085#1080#1103' OB:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label4: TLabel
        Left = 127
        Top = 10
        Width = 197
        Height = 13
        Caption = #1056#1072#1089#1089#1095#1080#1090#1072#1085#1085#1099#1077' '#1087#1086#1082#1072#1079#1072#1085#1080#1103' '#1087#1086' '#1041#1044':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lTime1: TLabel
        Left = 170
        Top = 29
        Width = 33
        Height = 13
        Caption = '           '
      end
      object lTime2: TLabel
        Left = 254
        Top = 29
        Width = 36
        Height = 13
        Caption = '            '
      end
    end
    object StartGroupBox: TGroupBox
      Left = 1
      Top = 47
      Width = 330
      Height = 180
      Caption = #1055#1086#1082#1072#1079#1072#1085#1080#1103' '#1087#1088#1080' '#1074#1074#1086#1076#1077' '#1054#1042
      TabOrder = 1
      object Label5: TLabel
        Left = 6
        Top = 27
        Width = 33
        Height = 13
        Caption = #1040' '#1087#1088#1084':'
      end
      object Label6: TLabel
        Left = 6
        Top = 52
        Width = 30
        Height = 13
        Caption = #1040' '#1086#1090#1076':'
      end
      object Label7: TLabel
        Left = 6
        Top = 76
        Width = 30
        Height = 13
        Caption = #1056' '#1087#1090#1088':'
      end
      object meERM: TMaskEdit
        Tag = -1
        Left = 58
        Top = 23
        Width = 81
        Height = 21
        Enabled = False
        MaxLength = 13
        TabOrder = 0
        OnChange = EditChange
        OnKeyPress = EditKeyPress
      end
      object meCalcERM1: TMaskEdit
        Tag = 1
        Left = 147
        Top = 23
        Width = 84
        Height = 21
        TabStop = False
        MaxLength = 12
        ReadOnly = True
        TabOrder = 6
      end
      object meCalcERM2: TMaskEdit
        Tag = 1
        Left = 236
        Top = 23
        Width = 84
        Height = 21
        TabStop = False
        MaxLength = 12
        ReadOnly = True
        TabOrder = 7
      end
      object meEDM: TMaskEdit
        Tag = -2
        Left = 58
        Top = 48
        Width = 81
        Height = 21
        Enabled = False
        MaxLength = 13
        TabOrder = 1
        OnChange = EditChange
        OnKeyPress = EditKeyPress
      end
      object meCalcEDM1: TMaskEdit
        Tag = 2
        Left = 147
        Top = 48
        Width = 84
        Height = 21
        TabStop = False
        MaxLength = 12
        ReadOnly = True
        TabOrder = 8
      end
      object meCalcEDM2: TMaskEdit
        Tag = 2
        Left = 236
        Top = 48
        Width = 84
        Height = 21
        TabStop = False
        MaxLength = 12
        ReadOnly = True
        TabOrder = 9
      end
      object meQ1M: TMaskEdit
        Tag = -3
        Left = 58
        Top = 72
        Width = 81
        Height = 21
        Enabled = False
        MaxLength = 13
        TabOrder = 2
        OnChange = EditChange
        OnKeyPress = EditKeyPress
      end
      object meCalcQ1M1: TMaskEdit
        Tag = 3
        Left = 147
        Top = 72
        Width = 84
        Height = 21
        TabStop = False
        MaxLength = 12
        ReadOnly = True
        TabOrder = 10
      end
      object meCalcQ1M2: TMaskEdit
        Tag = 3
        Left = 236
        Top = 72
        Width = 84
        Height = 21
        TabStop = False
        MaxLength = 12
        ReadOnly = True
        TabOrder = 11
      end
      object Q4Panel: TPanel
        Left = 4
        Top = 144
        Width = 319
        Height = 27
        BevelOuter = bvNone
        TabOrder = 5
        object Label10: TLabel
          Left = 4
          Top = 8
          Width = 17
          Height = 13
          Caption = 'Q4:'
        end
        object meCalcQ4M1: TMaskEdit
          Tag = 6
          Left = 143
          Top = 2
          Width = 84
          Height = 21
          TabStop = False
          MaxLength = 12
          ReadOnly = True
          TabOrder = 1
        end
        object meQ4M: TMaskEdit
          Tag = -6
          Left = 54
          Top = 2
          Width = 81
          Height = 21
          MaxLength = 13
          TabOrder = 0
          OnChange = EditChange
          OnKeyPress = EditKeyPress
        end
        object meCalcQ4M2: TMaskEdit
          Tag = 6
          Left = 232
          Top = 2
          Width = 84
          Height = 21
          TabStop = False
          MaxLength = 12
          ReadOnly = True
          TabOrder = 2
        end
      end
      object Q2Panel: TPanel
        Left = 4
        Top = 96
        Width = 319
        Height = 23
        BevelOuter = bvNone
        TabOrder = 3
        object Label8: TLabel
          Left = 2
          Top = 4
          Width = 17
          Height = 13
          Caption = 'Q2:'
        end
        object meCalcQ2M1: TMaskEdit
          Tag = 4
          Left = 143
          Top = 0
          Width = 84
          Height = 21
          TabStop = False
          MaxLength = 12
          ReadOnly = True
          TabOrder = 1
        end
        object meQ2M: TMaskEdit
          Tag = -4
          Left = 54
          Top = 0
          Width = 81
          Height = 21
          MaxLength = 13
          TabOrder = 0
          OnChange = EditChange
          OnKeyPress = EditKeyPress
        end
        object meCalcQ2M2: TMaskEdit
          Tag = 4
          Left = 232
          Top = 0
          Width = 84
          Height = 21
          TabStop = False
          MaxLength = 12
          ReadOnly = True
          TabOrder = 2
        end
      end
      object PgenPanel: TPanel
        Left = 4
        Top = 118
        Width = 319
        Height = 25
        BevelOuter = bvNone
        TabOrder = 4
        object Label9: TLabel
          Left = 4
          Top = 8
          Width = 30
          Height = 13
          Caption = #1056' '#1075#1077#1085':'
        end
        object meCalcQ3M1: TMaskEdit
          Tag = 5
          Left = 143
          Top = 2
          Width = 84
          Height = 21
          TabStop = False
          MaxLength = 12
          ReadOnly = True
          TabOrder = 1
        end
        object meQ3M: TMaskEdit
          Tag = -5
          Left = 54
          Top = 2
          Width = 81
          Height = 21
          Enabled = False
          MaxLength = 13
          TabOrder = 0
          OnChange = EditChange
          OnKeyPress = EditKeyPress
        end
        object meCalcQ3M2: TMaskEdit
          Tag = 5
          Left = 232
          Top = 2
          Width = 84
          Height = 21
          TabStop = False
          MaxLength = 12
          ReadOnly = True
          TabOrder = 2
        end
      end
    end
    object FinishGroupBox: TGroupBox
      Left = 1
      Top = 226
      Width = 330
      Height = 197
      Caption = #1055#1086#1082#1072#1079#1072#1085#1080#1103' '#1087#1088#1080' '#1086#1090#1082#1083#1102#1095#1077#1085#1080#1080' '#1054#1042
      TabOrder = 2
      object Label1: TLabel
        Left = 6
        Top = 45
        Width = 33
        Height = 13
        Caption = #1040' '#1087#1088#1084':'
      end
      object Label2: TLabel
        Left = 6
        Top = 70
        Width = 30
        Height = 13
        Caption = #1040' '#1086#1090#1076':'
      end
      object Label11: TLabel
        Left = 6
        Top = 96
        Width = 30
        Height = 13
        Caption = #1056' '#1087#1090#1088':'
      end
      object LastTime1: TLabel
        Left = 170
        Top = 22
        Width = 3
        Height = 13
      end
      object LastTime2: TLabel
        Left = 254
        Top = 20
        Width = 3
        Height = 13
      end
      object meERMLast: TMaskEdit
        Tag = -7
        Left = 58
        Top = 40
        Width = 79
        Height = 21
        MaxLength = 13
        TabOrder = 0
        OnChange = EditChange
        OnKeyPress = EditKeyPress
      end
      object meCalcERM1Last: TMaskEdit
        Tag = 7
        Left = 147
        Top = 40
        Width = 83
        Height = 21
        TabStop = False
        ReadOnly = True
        TabOrder = 6
      end
      object meCalcERM2Last: TMaskEdit
        Tag = 7
        Left = 236
        Top = 40
        Width = 85
        Height = 21
        TabStop = False
        ReadOnly = True
        TabOrder = 7
      end
      object meEDMLast: TMaskEdit
        Tag = -8
        Left = 58
        Top = 66
        Width = 80
        Height = 21
        MaxLength = 13
        TabOrder = 1
        OnChange = EditChange
        OnKeyPress = EditKeyPress
      end
      object meEDMCalc1Last: TMaskEdit
        Tag = 8
        Left = 147
        Top = 66
        Width = 83
        Height = 21
        TabStop = False
        ReadOnly = True
        TabOrder = 8
      end
      object meEDMCalc2Last: TMaskEdit
        Tag = 8
        Left = 236
        Top = 66
        Width = 85
        Height = 21
        TabStop = False
        ReadOnly = True
        TabOrder = 9
      end
      object meQ1Last: TMaskEdit
        Tag = -9
        Left = 58
        Top = 92
        Width = 79
        Height = 21
        MaxLength = 13
        TabOrder = 2
        OnChange = EditChange
        OnKeyPress = EditKeyPress
      end
      object meQ1CalcLast1: TMaskEdit
        Tag = 9
        Left = 147
        Top = 92
        Width = 83
        Height = 21
        TabStop = False
        ReadOnly = True
        TabOrder = 10
      end
      object meQ1CalcLast2: TMaskEdit
        Tag = 9
        Left = 236
        Top = 92
        Width = 85
        Height = 21
        TabStop = False
        ReadOnly = True
        TabOrder = 11
      end
      object Q4FinishPanel: TPanel
        Left = 7
        Top = 166
        Width = 317
        Height = 26
        BevelOuter = bvNone
        TabOrder = 5
        object labelQ4: TLabel
          Left = 0
          Top = 4
          Width = 17
          Height = 13
          Caption = 'Q4:'
        end
        object meQ4LastCalc1: TMaskEdit
          Tag = 12
          Left = 140
          Top = 2
          Width = 83
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 1
        end
        object meQ4Last: TMaskEdit
          Tag = -12
          Left = 51
          Top = 2
          Width = 80
          Height = 21
          MaxLength = 13
          TabOrder = 0
          OnChange = EditChange
          OnKeyPress = EditKeyPress
        end
        object meQ4LastCalc2: TMaskEdit
          Tag = 12
          Left = 229
          Top = 2
          Width = 85
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 2
        end
      end
      object PgenFinishPanel: TPanel
        Left = 4
        Top = 140
        Width = 319
        Height = 27
        BevelOuter = bvNone
        TabOrder = 4
        object Label13: TLabel
          Left = 2
          Top = 8
          Width = 30
          Height = 13
          Caption = #1056' '#1075#1077#1085':'
        end
        object meQ3Last: TMaskEdit
          Tag = -11
          Left = 54
          Top = 4
          Width = 80
          Height = 21
          MaxLength = 13
          TabOrder = 0
          OnChange = EditChange
          OnKeyPress = EditKeyPress
        end
        object meQ3mLastCalc1: TMaskEdit
          Tag = 11
          Left = 143
          Top = 4
          Width = 83
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 1
        end
        object meQ3mLastCalc2: TMaskEdit
          Tag = 11
          Left = 232
          Top = 4
          Width = 85
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 2
        end
      end
      object Q2FinishPanel: TPanel
        Left = 3
        Top = 116
        Width = 321
        Height = 27
        BevelOuter = bvNone
        TabOrder = 3
        object Label12: TLabel
          Left = 6
          Top = 6
          Width = 17
          Height = 13
          Caption = 'Q2:'
        end
        object meQ2LastCalc1: TMaskEdit
          Tag = 10
          Left = 144
          Top = 2
          Width = 83
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 1
        end
        object meQ2Last: TMaskEdit
          Tag = -10
          Left = 55
          Top = 2
          Width = 79
          Height = 21
          MaxLength = 13
          TabOrder = 0
          OnChange = EditChange
          OnKeyPress = EditKeyPress
        end
        object meQ2LastCalc2: TMaskEdit
          Tag = 10
          Left = 233
          Top = 2
          Width = 85
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 2
        end
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 430
    Width = 332
    Height = 30
    Align = alBottom
    TabOrder = 1
    object Panel3: TPanel
      Left = 126
      Top = 1
      Width = 205
      Height = 28
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object bbOK: TBitBtn
        Left = 47
        Top = 2
        Width = 75
        Height = 25
        Caption = 'OK'
        Default = True
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = bbOKClick
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333330000333333333333333333333333F33333333333
          00003333344333333333333333388F3333333333000033334224333333333333
          338338F3333333330000333422224333333333333833338F3333333300003342
          222224333333333383333338F3333333000034222A22224333333338F338F333
          8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
          33333338F83338F338F33333000033A33333A222433333338333338F338F3333
          0000333333333A222433333333333338F338F33300003333333333A222433333
          333333338F338F33000033333333333A222433333333333338F338F300003333
          33333333A222433333333333338F338F00003333333333333A22433333333333
          3338F38F000033333333333333A223333333333333338F830000333333333333
          333A333333333333333338330000333333333333333333333333333333333333
          0000}
        NumGlyphs = 2
      end
      object bbCancel: TBitBtn
        Left = 127
        Top = 2
        Width = 75
        Height = 25
        Caption = #1054#1090#1084#1077#1085#1072
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        Kind = bkCancel
      end
    end
  end
end
