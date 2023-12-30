unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TIxSample = class(TObject)
  public
    x, y, z: integer;
    Caption: string;
  end;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private �錾 }
    obj1: TIxSample;
    obj2: TIxSample;
    procedure ex0_original_source;
    procedure ex1_init;
    procedure ex2_create_and_init;
    procedure ex3_create_and_init_1line;
    function create_and_init: TIxSample;
    function create_and_init_1line(prm_z: integer; prm_text: string): TIxSample;
  public
    { Public �錾 }
    procedure init(obj: TIxSample);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
  {
    �I�u�W�F�N�g�𐶐����ď���������ꍇ�̂���������
  }
  // �ׂ�����
  ex0_original_source;
  obj1.Free;
  obj2.Free;

  // �֐��ŏ�����
  ex1_init;
  obj1.Free;
  obj2.Free;

  // �֐��Ő������ď�����
  ex2_create_and_init;
  obj1.Free;
  obj2.Free;

  // �֐��Ő������ď������A�p�����[�^���n��
  ex3_create_and_init_1line;
  obj1.Free;
  obj2.Free;
end;

{
  �ׂ�����
}
procedure TForm1.ex0_original_source;
begin
  obj1 := TIxSample.Create;
  obj1.x := 0;
  obj1.y := 0;
  obj1.z := 1;
  obj1.Caption := 'ball';

  obj2 := TIxSample.Create;
  obj2.x := 0;
  obj2.y := 0;
  obj2.z := 2;
  obj2.Caption := 'box';
end;

{
  �֐��ŋ��ʂ̏����������āA�Ⴄ�������ύX����
}
procedure TForm1.ex1_init;
begin
  obj1 := TIxSample.Create;
  init(obj1);
  obj1.z := 1;
  obj1.Caption := 'ball';

  obj2 := TIxSample.Create;
  init(obj2);
  obj2.z := 2;
  obj2.Caption := 'box';
end;

procedure TForm1.init(obj: TIxSample);
begin
  obj.x := 0;
  obj.y := 0;
  obj.z := 0;
  obj.Caption := '';
end;

{
  �֐��Ő������āA���ʂ̏����������āA�Ⴄ�������ύX����
}
procedure TForm1.ex2_create_and_init;
begin
  obj1 := create_and_init;
  obj1.z := 1;
  obj1.Caption := 'ball';

  obj2 := create_and_init;
  obj2.z := 2;
  obj2.Caption := 'box';
end;

function TForm1.create_and_init: TIxSample;
begin
  Result := TIxSample.Create;
  Result.x := 0;
  Result.y := 0;
  Result.z := 0;
  Result.Caption := '';
end;

{
  �֐��Ő������āA���ʂ̏����������āA�Ⴄ���������œn���Đݒ肷��
}
procedure TForm1.ex3_create_and_init_1line;
begin
  obj1 := create_and_init_1line(1, 'ball');
  obj2 := create_and_init_1line(2, 'box');
end;

function TForm1.create_and_init_1line(prm_z: integer; prm_text: string): TIxSample;
begin
  Result := TIxSample.Create;
  Result.x := 0;
  Result.y := 0;
  Result.z := prm_z;
  Result.Caption := prm_text;
end;

end.
