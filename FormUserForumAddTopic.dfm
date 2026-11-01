object UserForumAddTopic: TUserForumAddTopic
  Left = 231
  Top = 655
  HelpContext = 2402101
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1053#1086#1074#1072#1103' '#1090#1077#1084#1072
  ClientHeight = 306
  ClientWidth = 668
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 6
    Top = 10
    Width = 125
    Height = 16
    Caption = #1047#1072#1075#1086#1083#1086#1074#1086#1082' '#1090#1077#1084#1099':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 6
    Top = 54
    Width = 88
    Height = 16
    Caption = #1057#1086#1086#1073#1097#1077#1085#1080#1077':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object topicTitle: TEdit
    Left = 142
    Top = 8
    Width = 513
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MaxLength = 100
    ParentFont = False
    TabOrder = 0
    OnChange = topicTitleChange
  end
  object topicMessage: TMemo
    Left = 142
    Top = 56
    Width = 513
    Height = 201
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MaxLength = 4000
    ParentFont = False
    TabOrder = 1
  end
  object buttonCancel: TBitBtn
    Left = 552
    Top = 272
    Width = 97
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    TabOrder = 2
    Kind = bkCancel
  end
  object buttonOK: TBitBtn
    Left = 448
    Top = 272
    Width = 97
    Height = 25
    Caption = #1057#1086#1079#1076#1072#1090#1100
    Enabled = False
    TabOrder = 3
    OnClick = buttonOKClick
    Kind = bkOK
  end
  object addTopicQuery: TOraQuery
    Session = dmMain.orases
    SQL.Strings = (
      'begin'
      '  ryda.USERFORUM_PG.addTopic(:user_name, :subject, :message);'
      'end;')
    Options.AutoClose = True
    Left = 80
    Top = 160
    ParamData = <
      item
        DataType = ftString
        Name = 'user_name'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'subject'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'message'
        ParamType = ptInput
      end>
  end
end
