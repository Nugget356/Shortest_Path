object frmShortestPath: TfrmShortestPath
  Left = 0
  Top = 0
  Caption = 'Shortest Path Program'
  ClientHeight = 680
  ClientWidth = 1000
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblGridSize: TLabel
    Left = 829
    Top = 8
    Width = 163
    Height = 13
    Caption = 'What size would you like the Grid?'
  end
  object lblx: TLabel
    Left = 931
    Top = 30
    Width = 6
    Height = 13
    Caption = 'x'
  end
  object lblValidation: TLabel
    Left = 777
    Top = 208
    Width = 215
    Height = 13
    Caption = 'You must place at least 1 Target and seeker.'
  end
  object edtwidth: TEdit
    Left = 876
    Top = 27
    Width = 49
    Height = 21
    TabOrder = 0
    TextHint = '0'
  end
  object edtheight: TEdit
    Left = 943
    Top = 27
    Width = 49
    Height = 21
    TabOrder = 1
    TextHint = '0'
  end
  object btnGrid: TButton
    Left = 896
    Top = 54
    Width = 75
    Height = 25
    Caption = 'Create'
    TabOrder = 2
    OnClick = btnGridClick
  end
  object rgrpObject: TRadioGroup
    Left = 807
    Top = 85
    Width = 185
    Height = 105
    Caption = 'Object Selecter'
    Enabled = False
    ItemIndex = 0
    Items.Strings = (
      'Open'
      'Target'
      'Seeker'
      'Closed')
    TabOrder = 3
  end
  object rgrpSearchType: TRadioGroup
    Left = 807
    Top = 304
    Width = 185
    Height = 105
    Caption = 'Select Search Method'
    Enabled = False
    ItemIndex = 0
    Items.Strings = (
      'Breadth First Search'
      'Depth First Search'
      'A* Search')
    TabOrder = 4
  end
  object btnSearch: TButton
    Left = 896
    Top = 432
    Width = 75
    Height = 25
    Caption = 'Search'
    Enabled = False
    TabOrder = 5
    OnClick = btnSearchClick
  end
  object btnReset: TButton
    Left = 896
    Top = 480
    Width = 75
    Height = 25
    Caption = 'Reset'
    TabOrder = 6
    OnClick = btnResetClick
  end
  object pnlGrid: TPanel
    Left = 0
    Top = 2
    Width = 670
    Height = 670
    TabOrder = 7
  end
  object btnSaveLocations: TButton
    Left = 848
    Top = 248
    Width = 89
    Height = 25
    Caption = 'Save Locations'
    Enabled = False
    TabOrder = 8
    OnClick = btnSaveLocationsClick
  end
end
