object fmDeportProcRun: TfmDeportProcRun
  Left = 427
  Top = 270
  HelpContext = 350
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1047#1072#1087#1091#1089#1082' '#1087#1088#1086#1094#1077#1089#1089#1072
  ClientHeight = 116
  ClientWidth = 281
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel4: TPanel
    Left = 0
    Top = 0
    Width = 281
    Height = 75
    Align = alClient
    BevelOuter = bvNone
    Enabled = False
    TabOrder = 2
    Visible = False
    object Label3: TLabel
      Left = 13
      Top = 30
      Width = 45
      Height = 16
      Caption = #1044#1072#1090#1072' '#1089':'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label4: TLabel
      Left = 161
      Top = 30
      Width = 19
      Height = 16
      Caption = #1087#1086':'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object dtStart: TDateTimePicker
      Left = 64
      Top = 25
      Width = 89
      Height = 24
      CalAlignment = dtaLeft
      Date = 37308.6130123727
      Time = 37308.6130123727
      DateFormat = dfShort
      DateMode = dmComboBox
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Kind = dtkDate
      ParseInput = False
      ParentFont = False
      TabOrder = 0
    end
    object dtFinish: TDateTimePicker
      Left = 186
      Top = 25
      Width = 89
      Height = 24
      CalAlignment = dtaLeft
      Date = 37308.6130123727
      Time = 37308.6130123727
      DateFormat = dfShort
      DateMode = dmComboBox
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Kind = dtkDate
      ParseInput = False
      ParentFont = False
      TabOrder = 1
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 75
    Width = 281
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    OnClick = NewBtOKClick
    object Panel1: TPanel
      Left = 104
      Top = 0
      Width = 177
      Height = 41
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object BitBtn1: TBitBtn
        Left = 6
        Top = 8
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
        OnClick = BitBtn1Click
        Glyph.Data = {
          BE060000424DBE06000000000000360400002800000024000000120000000100
          0800000000008802000000000000000000000001000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
          A600F0FBFF00A4A0A000808080000000FF0000FF000000FFFF00FF000000FF00
          FF00FFFF0000FFFFFF0000000000000080000080000000808000800000008000
          800080800000C0C0C000C0DCC000F0CAA600F0FBFF00A4A0A000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
          80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
          A600F0FBFF00A4A0A000808080000000FF0000FF000000FFFF00FF000000FF00
          FF00FFFF0000FFFFFF0000000000000080000080000000808000800000008000
          800080800000C0C0C000C0DCC000F0CAA600F0FBFF00A4A0A000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
          80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
          A600F0FBFF00A4A0A000808080000000FF0000FF000000FFFF00FF000000FF00
          FF00FFFF0000FFFFFF0000000000000080000080000000808000800000008000
          800080800000C0C0C000C0DCC000F0CAA600F0FBFF00A4A0A000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
          80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
          A600F0FBFF00A4A0A000808080000000FF0000FF000000FFFF00FF000000FF00
          FF00FFFF0000FFFFFF0000000000000080000080000000808000800000008000
          800080800000C0C0C000C0DCC000F0CAA600F0FBFF00A4A0A000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
          80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
          A600F0FBFF00A4A0A000808080000000FF0000FF000000FFFF00FF000000FF00
          FF00FFFF0000FFFFFF0000000000000080000080000000808000800000008000
          800080800000C0C0C000C0DCC000F0CAA600F0FBFF00A4A0A000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
          80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
          A600F0FBFF00A4A0A000808080000000FF0000FF000000FFFF00FF000000FF00
          FF00FFFF0000FFFFFF0000000000000080000080000000808000800000008000
          800080800000C0C0C000C0DCC000F0CAA600F0FBFF00A4A0A000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
          800000800000008080008000000080008000F0FBFF00A4A0A000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00030303030303
          0303030303030303030303030303030303030303030303030303030303030303
          0303030303030303030303030303030303030303030313030303030303030303
          030303030303030404030303030303030303030303030303030C0C1303030303
          030303030303030303030402020403030303030303030303030303030C03030C
          130303030303030303030303030402020202040303030303030303030303030C
          030303030C130303030303030303030304020202020202040303030303030303
          03030C0303030303030C130303030303030303040202020E0202020204030303
          03030303030C1303030C130303030C13030303030303030202020E030E020202
          0403030303030303030C13030C030C1303030C13030303030303030E020E0303
          030E02020204030303030303030C130C0303030C1303030C1303030303030303
          0E03030303030E02020204030303030303030C03030303030C1303030C130303
          03030303030303030303030E02020204030303030303030303030303030C1303
          030C13030303030303030303030303030E020202040303030303030303030303
          03030C1303030C13030303030303030303030303030E02020204030303030303
          030303030303030C1303030C13030303030303030303030303030E0202020403
          0303030303030303030303030C1303030C13030303030303030303030303030E
          02020403030303030303030303030303030C13030C1303030303030303030303
          030303030E02020303030303030303030303030303030C130C03030303030303
          0303030303030303030E03030303030303030303030303030303030C03030303
          0303030303030303030303030303030303030303030303030303030303030303
          0303}
        NumGlyphs = 2
      end
      object BitBtn2: TBitBtn
        Left = 96
        Top = 8
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
        OnClick = BitBtn2Click
        Kind = bkCancel
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 281
    Height = 75
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object Label2: TLabel
      Left = 13
      Top = 16
      Width = 35
      Height = 16
      Caption = #1044#1072#1090#1072':'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object MEdTime: TMaskEdit
      Left = 200
      Top = 9
      Width = 41
      Height = 24
      EditMask = '!99:99;1; '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 1
      Text = '  :  '
    end
    object DTPPar: TDateTimePicker
      Left = 96
      Top = 9
      Width = 89
      Height = 24
      CalAlignment = dtaLeft
      Date = 37308.6130123727
      Time = 37308.6130123727
      DateFormat = dfShort
      DateMode = dmComboBox
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Kind = dtkDate
      ParseInput = False
      ParentFont = False
      TabOrder = 0
    end
    object Panel5: TPanel
      Left = 0
      Top = 40
      Width = 281
      Height = 35
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 2
      object Label1: TLabel
        Left = 13
        Top = 11
        Width = 69
        Height = 16
        Caption = #1055#1072#1088#1072#1084#1077#1090#1088':'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object EdParam: TEdit
        Left = 96
        Top = 3
        Width = 145
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
    end
  end
end
