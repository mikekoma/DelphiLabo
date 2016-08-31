unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    PaintBox1: TPaintBox;
    btnUpdateBG: TButton;
    btnInvalidate: TButton;
    btnUpdateBGandInvalidate: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure btnUpdateBGClick(Sender: TObject);
    procedure btnInvalidateClick(Sender: TObject);
    procedure btnUpdateBGandInvalidateClick(Sender: TObject);
  private
    { Private êÈåæ }
    bg_count: integer;
    bg_bmp: TBitmap;
    procedure update_bg;
  public
    { Public êÈåæ }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.update_bg;
begin
  bg_bmp.Canvas.Brush.Color := clWhite;
  bg_bmp.Canvas.FillRect(Rect(0, 0, bg_bmp.Width, bg_bmp.Height));

  bg_bmp.Canvas.TextOut(0, 0, 'hello. I am bg_bmp. ' + IntToStr(bg_count));

  bg_bmp.Canvas.MoveTo(0, 0);
  bg_bmp.Canvas.LineTo(bg_bmp.Width, bg_bmp.Height);

  bg_bmp.Canvas.MoveTo(0, bg_bmp.Height);
  bg_bmp.Canvas.LineTo(bg_bmp.Width, 0);

  inc(bg_count);
end;

procedure TForm1.btnUpdateBGClick(Sender: TObject);
begin
  update_bg;
end;

procedure TForm1.btnUpdateBGandInvalidateClick(Sender: TObject);
begin
  btnUpdateBGClick(Sender);
  btnInvalidateClick(Sender);
end;

procedure TForm1.btnInvalidateClick(Sender: TObject);
begin
  PaintBox1.Invalidate;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  bg_bmp := TBitmap.Create;
  bg_count := 0;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  bg_bmp.Free;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  bg_bmp.SetSize(PaintBox1.Width, PaintBox1.Height);
  update_bg;
end;

procedure TForm1.PaintBox1Paint(Sender: TObject);
var
  rct: TRect;
begin
  rct := Rect(0, 0, PaintBox1.Width, PaintBox1.Height);
  PaintBox1.Canvas.CopyRect(rct, bg_bmp.Canvas, rct);
end;

end.
