unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TIxItem = class(TObject)
  public
    Value: Integer;
  end;

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

uses System.Generics.Collections;

procedure TForm1.Button1Click(Sender: TObject);
var
  objlst: TObjectList<TIxItem>;
  item: TIxItem;
begin
  // 生成
  objlst := TObjectList<TIxItem>.Create;
  try
    for var i := 0 to 5 do
    begin
      item := TIxItem.Create;
      item.Value := Round(Random(100));
      objlst.Add(item);
    end;

    // ソート前
    Memo1.Lines.Add('before sort.');
    for item in objlst do
    begin
      Memo1.Lines.Add(item.Value.ToString);
    end;

    // ソート
    objlst.Sort(System.Generics.Defaults.TComparer<TIxItem>.Construct(
      function(const L, R: TIxItem): Integer
      begin
        if L.Value = R.Value then
          Result := 0
        else if L.Value < R.Value then
          Result := -1
        else
          Result := 1;
      end));

    // ソート後
    Memo1.Lines.Add('after sort.');
    for item in objlst do
    begin
      Memo1.Lines.Add(item.Value.ToString);
    end;

  finally
    objlst.Free;
  end;
end;

end.
