object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 351
  ClientWidth = 361
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  DesignSize = (
    361
    351)
  PixelsPerInch = 96
  TextHeight = 13
  object PaintBox1: TPaintBox
    Left = 24
    Top = 24
    Width = 313
    Height = 289
    Anchors = [akLeft, akTop, akRight, akBottom]
    OnPaint = PaintBox1Paint
  end
  object btnUpdateBG: TButton
    Left = 24
    Top = 319
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'UpdateBG'
    TabOrder = 0
    OnClick = btnUpdateBGClick
  end
  object btnInvalidate: TButton
    Left = 105
    Top = 319
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Invalidate'
    TabOrder = 1
    OnClick = btnInvalidateClick
  end
  object btnUpdateBGandInvalidate: TButton
    Left = 186
    Top = 319
    Width = 151
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'UpdateBG + Invalidate'
    TabOrder = 2
    OnClick = btnUpdateBGandInvalidateClick
  end
end
