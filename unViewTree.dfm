object fmViewTree: TfmViewTree
  Left = 657
  Top = 454
  Width = 400
  Height = 500
  Caption = 'fmViewTree'
  Color = clBtnFace
  Constraints.MinHeight = 500
  Constraints.MinWidth = 400
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 438
    Width = 392
    Height = 35
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 11
      Width = 62
      Height = 13
      Caption = #1048#1076' '#1086#1073#1098#1077#1082#1090#1072':'
    end
    object Panel2: TPanel
      Left = 222
      Top = 0
      Width = 170
      Height = 35
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object BtnOK: TBitBtn
        Left = 5
        Top = 5
        Width = 80
        Height = 25
        TabOrder = 0
        Kind = bkOK
      end
      object BtnCancel: TBitBtn
        Left = 90
        Top = 5
        Width = 80
        Height = 25
        Caption = #1047#1072#1082#1088#1099#1090#1100
        TabOrder = 1
        Kind = bkCancel
      end
    end
    object IDObj: TEdit
      Left = 72
      Top = 11
      Width = 64
      Height = 13
      BorderStyle = bsNone
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 1
    end
  end
  object TreeView1: TTreeView
    Left = 0
    Top = 0
    Width = 392
    Height = 438
    Align = alClient
    Images = MainForm.iImageList
    Indent = 19
    TabOrder = 0
    OnChanging = TreeView1Changing
    OnExpanding = TreeView1Expanding
  end
end
