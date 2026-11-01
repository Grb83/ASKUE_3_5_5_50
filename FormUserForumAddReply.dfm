object UserForumAddReply: TUserForumAddReply
  Left = 503
  Top = 497
  HelpContext = 2402101
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1053#1086#1074#1086#1077' '#1089#1086#1086#1073#1097#1077#1085#1080#1077
  ClientHeight = 306
  ClientWidth = 633
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 6
    Top = 10
    Width = 43
    Height = 16
    Caption = #1058#1077#1084#1072':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 6
    Top = 46
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
  object replyTitle: TLabel
    Left = 110
    Top = 10
    Width = 515
    Height = 16
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object replyMessage: TMemo
    Left = 110
    Top = 48
    Width = 513
    Height = 209
    MaxLength = 4000
    TabOrder = 0
    OnChange = replyMessageChange
  end
  object buttonOK: TBitBtn
    Left = 416
    Top = 272
    Width = 97
    Height = 25
    Caption = #1057#1086#1079#1076#1072#1090#1100
    Enabled = False
    TabOrder = 1
    OnClick = buttonOKClick
    Kind = bkOK
  end
  object buttonCancel: TBitBtn
    Left = 520
    Top = 272
    Width = 97
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    TabOrder = 2
    Kind = bkCancel
  end
  object addReplyQuery: TOraQuery
    Session = dmMain.orases
    SQL.Strings = (
      'begin'
      'ryda.USERFORUM_PG.addReply(:user_name, :topic_id, :message);'
      'end;')
    Left = 64
    Top = 144
    ParamData = <
      item
        DataType = ftString
        Name = 'user_name'
        ParamType = ptInput
      end
      item
        Name = 'topic_id'
        ParamType = ptInput
        Value = ''
        ExtDataType = 107
      end
      item
        DataType = ftString
        Name = 'message'
        ParamType = ptInput
      end>
  end
end
