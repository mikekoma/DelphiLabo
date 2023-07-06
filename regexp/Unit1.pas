unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    edSource: TEdit;
    edRegexp: TEdit;
    Memo1: TMemo;
    edSource2: TEdit;
    Memo2: TMemo;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private 宣言 }
  public
    { Public 宣言 }
    procedure memo(str: string);
    procedure memob(str: string);
  end;

var
  Form1: TForm1;

implementation

uses System.RegularExpressions;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  match: TMatch;
begin
  Memo1.Clear;
  match := TRegEx.match(edSource.Text, edRegexp.Text);
  if match.Success then
  begin
    memo('match.Value=' + match.Value);
    memo('match.Groups.Count=' + match.Groups.Count.ToString);
    for var i := 0 to match.Groups.Count - 1 do
    begin
      memo('match.Groups.Item[' + IntToStr(i) + '].Value■' + match.Groups.Item[i].Value);
    end;
  end
  else
  begin
    memo('not match');
  end;

  Memo2.Clear;
  match := TRegEx.match(edSource2.Text, edRegexp.Text);
  if match.Success then
  begin
    memob('match.Value=' + match.Value);
    memob('match.Groups.Count=' + match.Groups.Count.ToString);
    for var i := 0 to match.Groups.Count - 1 do
    begin
      memob('match.Groups.Item[' + IntToStr(i) + '].Value■' + match.Groups.Item[i].Value);
    end;
  end
  else
  begin
    memob('not match');
  end;
end;

procedure TForm1.memo(str: string);
begin
  Memo1.Lines.Add(str);
end;

procedure TForm1.memob(str: string);
begin
  Memo2.Lines.Add(str);
end;

end.
