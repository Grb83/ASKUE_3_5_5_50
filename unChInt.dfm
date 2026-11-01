object fmChInter: TfmChInter
  Left = 256
  Top = 175
  BorderStyle = bsDialog
  Caption = #1053#1086#1088#1084#1072#1090#1080#1074#1085#1099#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1099
  ClientHeight = 418
  ClientWidth = 639
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 388
    Width = 639
    Height = 30
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object Panel2: TPanel
      Left = 454
      Top = 0
      Width = 185
      Height = 30
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object btOk: TBitBtn
        Left = 16
        Top = 4
        Width = 75
        Height = 25
        Caption = 'OK'
        TabOrder = 0
        OnClick = btOkClick
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
      object btCancel: TBitBtn
        Left = 98
        Top = 4
        Width = 75
        Height = 25
        Caption = #1054#1090#1084#1077#1085#1072
        ModalResult = 2
        TabOrder = 1
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          333333333333333333333333000033338833333333333333333F333333333333
          0000333911833333983333333388F333333F3333000033391118333911833333
          38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
          911118111118333338F3338F833338F3000033333911111111833333338F3338
          3333F8330000333333911111183333333338F333333F83330000333333311111
          8333333333338F3333383333000033333339111183333333333338F333833333
          00003333339111118333333333333833338F3333000033333911181118333333
          33338333338F333300003333911183911183333333383338F338F33300003333
          9118333911183333338F33838F338F33000033333913333391113333338FF833
          38F338F300003333333333333919333333388333338FFF830000333333333333
          3333333333333333333888330000333333333333333333333333333333333333
          0000}
        NumGlyphs = 2
      end
    end
    object DBNavigator1: TDBNavigator
      Left = 0
      Top = 0
      Width = 233
      Height = 30
      DataSource = dsMain
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbDelete]
      Align = alLeft
      ConfirmDelete = False
      TabOrder = 1
    end
  end
  object grMain: TDBGridEh
    Left = 0
    Top = 0
    Width = 639
    Height = 388
    Align = alClient
    AutoFitColWidths = True
    DataSource = dsMain
    FooterColor = clWindow
    FooterFont.Charset = DEFAULT_CHARSET
    FooterFont.Color = clWindowText
    FooterFont.Height = -11
    FooterFont.Name = 'MS Sans Serif'
    FooterFont.Style = []
    Options = [dgEditing, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        EditButtons = <>
        FieldName = 'VT_SPeriod'
        Footers = <>
        Title.Caption = #1053#1072#1095#1072#1083#1086' '#1086#1087#1088#1086#1089#1072
        Width = 126
      end
      item
        EditButtons = <>
        FieldName = 'VT_FPeriod'
        Footers = <>
        Title.Caption = #1054#1082#1086#1085#1095#1072#1085#1080#1077' '#1086#1087#1088#1086#1089#1072
        Width = 142
      end
      item
        Checkboxes = True
        EditButtons = <>
        FieldName = 'VT_NNETPARAM'
        Footers = <>
        Title.Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1089#1077#1090#1080
        Width = 107
      end
      item
        Checkboxes = True
        EditButtons = <>
        FieldName = 'VT_NJOURNAL'
        Footers = <>
        Title.Caption = #1046#1091#1088#1085#1072#1083' '#1089#1086#1073#1099#1090#1080#1081
        Width = 105
      end
      item
        Checkboxes = True
        EditButtons = <>
        FieldName = 'VT_NNOTREADCURR'
        Footers = <>
        Title.Caption = #1053#1077' '#1095#1080#1090#1072#1090#1100' '#1090#1077#1082#1091#1097#1080#1077' '#1089#1091#1090#1082#1080
        Width = 138
      end>
  end
  object dsMain: TDataSource
    DataSet = VT_Data
    Left = 46
    Top = 45
  end
  object VT_Data: TVirtualTable
    OnNewRecord = VT_DataNewRecord
    FieldDefs = <
      item
        Name = 'VT_SPeriod'
        DataType = ftTime
      end
      item
        Name = 'VT_FPeriod'
        DataType = ftTime
      end
      item
        Name = 'VT_NNETPARAM'
        DataType = ftBoolean
      end
      item
        Name = 'VT_NJOURNAL'
        DataType = ftBoolean
      end
      item
        Name = 'VT_NNOTREADCURR'
        DataType = ftBoolean
      end>
    Left = 50
    Top = 160
    Data = {
      020005000A0056545F53506572696F640A0000000A0056545F46506572696F64
      0A0000000C0056545F4E4E4554504152414D050000000B0056545F4E4A4F5552
      4E414C050000000F0056545F4E4E4F5452454144435552520500000000000000
      0000}
    object VT_DataVT_SPeriod: TTimeField
      FieldName = 'VT_SPeriod'
      DisplayFormat = 'hh:mm'
      EditMask = '00:00;1; '
    end
    object VT_DataVT_FPeriod: TTimeField
      FieldName = 'VT_FPeriod'
      DisplayFormat = 'hh:mm'
      EditMask = '00:00;1; '
    end
    object VT_DataVT_NNETPARAM: TBooleanField
      FieldName = 'VT_NNETPARAM'
    end
    object VT_DataVT_NJOURNAL: TBooleanField
      FieldName = 'VT_NJOURNAL'
    end
    object VT_DataVT_NNOTREADCURR: TBooleanField
      FieldName = 'VT_NNOTREADCURR'
    end
  end
end
