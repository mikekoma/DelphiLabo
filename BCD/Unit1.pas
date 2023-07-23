unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

{
  ■実行結果
2023-07-23 12:01:22
yyyy.Fraction[0]=20
yyyy.Fraction[1]=23
mm.Fraction[0]=70 ←1桁なのでMSBによっている
dd.Fraction[0]=23
hh.Fraction[0]=12
nn.Fraction[0]=10
ss.Fraction[0]=22}

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private 宣言 }
  public
    { Public 宣言 }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses Data.FMTBcd;

procedure TForm1.Button1Click(Sender: TObject);
var
  hour, min, sec, msec: Word;
  year, month, day: Word;
  yyyy: TBcd;
  mm: TBcd;
  dd: TBcd;
  hh: TBcd;
  nn: TBcd;
  ss: TBcd;
  dt: TDateTime;
  str: string;
begin
  dt := Now;

  DateTimeToString(str, 'yyyy-mm-dd hh:nn:ss', dt);
  Memo1.Lines.Add(str);

  DecodeDate(dt, year, month, day);
  DecodeTime(dt, hour, min, sec, msec);
  yyyy := CurrencyToBcd(year);
  mm := CurrencyToBcd(month);
  dd := CurrencyToBcd(day);
  hh := CurrencyToBcd(hour);
  nn := CurrencyToBcd(min);
  ss := CurrencyToBcd(sec);
  Memo1.Lines.Add('yyyy.Fraction[0]=' + IntToHex(yyyy.Fraction[0], 2));
  Memo1.Lines.Add('yyyy.Fraction[1]=' + IntToHex(yyyy.Fraction[1], 2));
  Memo1.Lines.Add('mm.Fraction[0]=' + IntToHex(mm.Fraction[0], 2));
  Memo1.Lines.Add('dd.Fraction[0]=' + IntToHex(dd.Fraction[0], 2));
  Memo1.Lines.Add('hh.Fraction[0]=' + IntToHex(hh.Fraction[0], 2));
  Memo1.Lines.Add('nn.Fraction[0]=' + IntToHex(nn.Fraction[0], 2));
  Memo1.Lines.Add('ss.Fraction[0]=' + IntToHex(ss.Fraction[0], 2));
end;

end.
