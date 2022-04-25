object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Delphi 11 MySQL 8 Test'
  ClientHeight = 504
  ClientWidth = 559
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  TextHeight = 15
  object Label1: TLabel
    Left = 84
    Top = 19
    Width = 32
    Height = 15
    Alignment = taRightJustify
    Caption = 'Server'
  end
  object Label2: TLabel
    Left = 68
    Top = 59
    Width = 48
    Height = 15
    Alignment = taRightJustify
    Caption = 'Database'
  end
  object Label3: TLabel
    Left = 94
    Top = 107
    Width = 22
    Height = 15
    Alignment = taRightJustify
    Caption = 'Port'
  end
  object Label4: TLabel
    Left = 93
    Top = 162
    Width = 23
    Height = 15
    Alignment = taRightJustify
    Caption = 'User'
  end
  object Label5: TLabel
    Left = 66
    Top = 198
    Width = 50
    Height = 15
    Alignment = taRightJustify
    Caption = 'Password'
  end
  object edServer: TEdit
    Left = 132
    Top = 16
    Width = 369
    Height = 23
    TabOrder = 0
  end
  object edDB: TEdit
    Left = 132
    Top = 56
    Width = 369
    Height = 23
    TabOrder = 1
  end
  object edPort: TEdit
    Left = 132
    Top = 104
    Width = 109
    Height = 23
    NumbersOnly = True
    TabOrder = 2
    Text = '3306'
  end
  object edUser: TEdit
    Left = 132
    Top = 159
    Width = 369
    Height = 23
    TabOrder = 3
  end
  object Memo1: TMemo
    Left = 58
    Top = 288
    Width = 443
    Height = 201
    TabOrder = 6
  end
  object btnConnect: TButton
    Left = 219
    Top = 248
    Width = 121
    Height = 25
    Caption = 'Test connection'
    TabOrder = 5
    OnClick = btnConnectClick
  end
  object edPassword: TEdit
    Left = 132
    Top = 195
    Width = 369
    Height = 23
    TabOrder = 4
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'DriverID=MySQL')
    Left = 496
    Top = 240
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = '.\libmariadb.dll'
    Left = 440
    Top = 240
  end
end
