object fmGetSelectDateTime: TfmGetSelectDateTime
  Left = 732
  Top = 379
  BorderIcons = [biMinimize, biMaximize]
  BorderStyle = bsToolWindow
  Caption = #1042#1074#1077#1076#1080#1090#1077' '#1076#1072#1090#1091' '#1080' '#1074#1088#1077#1084#1103' '#1082#1086#1085#1090#1088#1086#1083#1103
  ClientHeight = 130
  ClientWidth = 240
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object plRecMonitor: TPanel
    Left = 0
    Top = 0
    Width = 240
    Height = 89
    Align = alClient
    TabOrder = 0
    DesignSize = (
      240
      89)
    object dtpDate: TDateTimePicker
      Left = 23
      Top = 24
      Width = 98
      Height = 21
      Anchors = [akLeft, akBottom]
      CalAlignment = dtaLeft
      Date = 37308.6130123727
      Time = 37308.6130123727
      DateFormat = dfShort
      DateMode = dmComboBox
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Kind = dtkDate
      ParseInput = False
      ParentFont = False
      TabOrder = 0
    end
    object dtpTime: TDateTimePicker
      Left = 128
      Top = 24
      Width = 71
      Height = 21
      Anchors = [akLeft, akBottom]
      CalAlignment = dtaLeft
      Date = 38068
      Time = 38068
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkTime
      ParseInput = False
      TabOrder = 1
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 89
    Width = 240
    Height = 41
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      240
      41)
    object BitBtn1: TBitBtn
      Left = 24
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akLeft, akBottom]
      TabOrder = 0
      Kind = bkOK
    end
    object BitBtn2: TBitBtn
      Left = 136
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = #1054#1090#1084#1077#1085#1072
      TabOrder = 1
      Kind = bkCancel
    end
  end
  object plSupMain: TPanel
    Left = 0
    Top = 0
    Width = 240
    Height = 89
    Align = alClient
    TabOrder = 2
    Visible = False
    object lbMonth: TLabel
      Left = 18
      Top = 18
      Width = 36
      Height = 13
      Caption = #1052#1077#1089#1103#1094':'
    end
    object Label1: TLabel
      Left = 18
      Top = 58
      Width = 21
      Height = 13
      Caption = #1043#1086#1076':'
    end
    object cbMonth: TComboBox
      Left = 84
      Top = 14
      Width = 141
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 0
      Text = #1071#1085#1074#1072#1088#1100
      Items.Strings = (
        #1071#1085#1074#1072#1088#1100
        #1060#1077#1074#1088#1072#1083#1100
        #1052#1072#1088#1090
        #1040#1087#1088#1077#1083#1100
        #1052#1072#1081
        #1048#1102#1085#1100
        #1048#1102#1083#1100
        #1040#1074#1075#1091#1089#1090
        #1057#1077#1085#1090#1103#1073#1088#1100
        #1054#1082#1090#1103#1073#1088#1100
        #1053#1086#1103#1073#1088#1100
        #1044#1077#1082#1072#1073#1088#1100)
    end
    object edYear: TEdit
      Left = 84
      Top = 52
      Width = 121
      Height = 21
      MaxLength = 4
      TabOrder = 1
      OnExit = edYearExit
      OnKeyPress = edYearKeyPress
    end
  end
end
