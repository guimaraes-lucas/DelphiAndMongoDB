object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'frmMain'
  ClientHeight = 417
  ClientWidth = 780
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -19
  Font.Name = 'Segoe UI'
  Font.Style = []
  Padding.Left = 10
  Padding.Top = 10
  Padding.Right = 10
  Padding.Bottom = 10
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 25
  object pnlTop: TPanel
    Left = 10
    Top = 10
    Width = 760
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 100
    object btnInsert: TButton
      Left = 8
      Top = 6
      Width = 100
      Height = 32
      Caption = 'Insert'
      TabOrder = 0
      OnClick = btnInsertClick
    end
    object btnUpdate: TButton
      Left = 114
      Top = 6
      Width = 100
      Height = 32
      Caption = 'Update'
      TabOrder = 1
      OnClick = btnUpdateClick
    end
    object btnRemove: TButton
      Left = 220
      Top = 6
      Width = 100
      Height = 32
      Caption = 'Remove'
      TabOrder = 2
      OnClick = btnRemoveClick
    end
    object btnFind: TButton
      Left = 326
      Top = 6
      Width = 100
      Height = 32
      Caption = 'Find'
      TabOrder = 3
      OnClick = btnFindClick
    end
    object btnQuery: TButton
      Left = 538
      Top = 6
      Width = 100
      Height = 32
      Caption = 'Query'
      TabOrder = 5
    end
    object btnFindSort: TButton
      Left = 432
      Top = 6
      Width = 100
      Height = 32
      Caption = 'Find Sort'
      TabOrder = 4
      OnClick = btnFindSortClick
    end
  end
  object pnlBottom: TPanel
    Left = 10
    Top = 366
    Width = 760
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = -51
    ExplicitWidth = 100
    object lblTotDocs: TLabel
      Left = 0
      Top = 0
      Width = 156
      Height = 41
      Align = alLeft
      Caption = 'lblTotalDocuments'
      Layout = tlCenter
      ExplicitLeft = 1
      ExplicitTop = 1
      ExplicitHeight = 25
    end
  end
  object mmoResult: TMemo
    Left = 10
    Top = 51
    Width = 760
    Height = 315
    Align = alClient
    Lines.Strings = (
      'mmoResult')
    TabOrder = 2
    ExplicitLeft = 392
    ExplicitTop = 160
    ExplicitWidth = 185
    ExplicitHeight = 89
  end
  object conMongoDB: TFDConnection
    Params.Strings = (
      'Database=test'
      'DriverID=Mongo')
    LoginPrompt = False
    Left = 32
    Top = 80
  end
  object linkMongoDB: TFDPhysMongoDriverLink
    Left = 32
    Top = 128
  end
  object crsMain: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 104
    Top = 128
  end
  object errorDlgMain: TFDGUIxErrorDialog
    Provider = 'Forms'
    Left = 104
    Top = 184
  end
  object flatFileMain: TFDMoniFlatFileClientLink
    Left = 32
    Top = 184
  end
end
