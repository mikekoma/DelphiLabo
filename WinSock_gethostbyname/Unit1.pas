unit Unit1;
{
  元ソース
  Delphi2007　＋　Indy10.5.8.0
  http://komatumoto.blog55.fc2.com/blog-entry-141.html

  元ソースから、GetIpAddressの関数のみ抜き出して実装。
  なのでIndyは不要(WinSockのみ)

  このソース
  Delphi 11.3
}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, WinSock;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private 宣言 }
    procedure memo(str: String);
  public
    { Public 宣言 }
  end;

var
  Form1: TForm1;

function GetIpAddress(HostName: String): String;

implementation

{$R *.dfm}
{ TForm1 }

function GetIpAddress(HostName: String): String;
var
  PH: PHostEnt;
  InAddr: TInAddr;
  WSADATA: TWSADATA;
begin
  Result := '';

  if HostName = '' then
    exit;

  WSAStartup(MakeWord(1, 1), WSADATA);
  try
    PH := gethostbyname(PAnsiChar(AnsiString(HostName)));

    if PH = nil then
      exit;

    InAddr := PInAddr(PH^.h_addr_list^)^;
    Result := string(inet_ntoa(InAddr));

  finally
    WSACleanup;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  memo(GetIpAddress('www.s-m-l.org'));
end;

procedure TForm1.memo(str: String);
begin
  Memo1.Lines.Add(str);
end;

end.
