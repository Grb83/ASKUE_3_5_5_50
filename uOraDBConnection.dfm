object fmConnect: TfmConnect
  Left = 375
  Top = 225
  HelpContext = 460
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1057#1086#1077#1076#1080#1085#1077#1085#1080#1077
  ClientHeight = 176
  ClientWidth = 275
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object MainPanel: TPanel
    Left = 0
    Top = 0
    Width = 275
    Height = 135
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    DesignSize = (
      275
      135)
    object Label1: TLabel
      Left = 10
      Top = 65
      Width = 25
      Height = 13
      Caption = #1041#1072#1079#1072
    end
    object Label2: TLabel
      Left = 10
      Top = 91
      Width = 73
      Height = 13
      Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
    end
    object Label3: TLabel
      Left = 10
      Top = 117
      Width = 38
      Height = 13
      Caption = #1055#1072#1088#1086#1083#1100
    end
    object dbNameEdit: TEdit
      Left = 91
      Top = 61
      Width = 178
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
    end
    object dbUserEdit: TEdit
      Left = 91
      Top = 87
      Width = 178
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 2
    end
    object dbPasswdEdit: TEdit
      Left = 91
      Top = 113
      Width = 178
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      PasswordChar = '*'
      TabOrder = 3
    end
    object ProfileGBox: TGroupBox
      Left = 2
      Top = 2
      Width = 271
      Height = 52
      Align = alTop
      Caption = ' '#1055#1088#1086#1092#1080#1083#1100' '#1089#1086#1077#1076#1080#1085#1077#1085#1080#1103': '
      TabOrder = 0
      DesignSize = (
        271
        52)
      object ProfileCBox: TComboBox
        Left = 8
        Top = 20
        Width = 178
        Height = 21
        Style = csDropDownList
        Anchors = [akLeft, akTop, akRight]
        ItemHeight = 13
        TabOrder = 0
        OnChange = ProfileCBoxChange
      end
      object ProfileDeleteBtn: TButton
        Left = 191
        Top = 18
        Width = 73
        Height = 25
        Anchors = [akLeft, akTop, akRight]
        Caption = #1059#1076#1072#1083#1080#1090#1100
        TabOrder = 1
        OnClick = ProfileDeleteBtnClick
      end
    end
  end
  object BottonPanel: TPanel
    Left = 0
    Top = 135
    Width = 275
    Height = 41
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object ConnectBtn: TButton
      Left = 21
      Top = 8
      Width = 100
      Height = 25
      Caption = #1057#1086#1077#1076#1080#1085#1080#1090#1100
      Default = True
      TabOrder = 0
      OnClick = ConnectBtnClick
    end
    object Button2: TButton
      Left = 157
      Top = 8
      Width = 100
      Height = 25
      Cancel = True
      Caption = #1054#1090#1084#1077#1085#1072
      ModalResult = 2
      TabOrder = 1
    end
  end
  object qwVersion: TOraQuery
    ReadOnly = True
    Left = 48
    Top = 64
  end
end
