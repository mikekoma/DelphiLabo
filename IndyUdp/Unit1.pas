unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  IdUDPServer, IdBaseComponent, IdComponent, IdUDPBase, IdUDPClient, IdGlobal,
  IdSocketHandle;

type
  TForm1 = class(TForm)
    btnStart: TButton;
    IdUDPClient1: TIdUDPClient;
    IdUDPServer1: TIdUDPServer;
    Memo1: TMemo;
    btnStop: TButton;
    btnSend: TButton;
    procedure btnStartClick(Sender: TObject);
    procedure IdUDPServer1UDPRead(AThread: TIdUDPListenerThread; const AData: TIdBytes; ABinding: TIdSocketHandle);
    procedure btnSendClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
  private
    { Private 宣言 }
  public
    { Public 宣言 }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnStartClick(Sender: TObject);
var
  portno: UInt16;
begin
  Memo1.Lines.Add('Start UDP server');
  portno := 55555;

  // Client
  IdUDPClient1.Host := '127.0.0.1';
  IdUDPClient1.Port := portno;
  IdUDPClient1.Active := true;

  // Server
  IdUDPServer1.DefaultPort := portno;
  IdUDPServer1.Active := true;

  Memo1.Lines.Add('wait port = ' + IntToStr(IdUDPServer1.DefaultPort));
end;

procedure TForm1.btnStopClick(Sender: TObject);
begin
  Memo1.Lines.Add('Stop UDP server');
  IdUDPClient1.Active := false;
  IdUDPServer1.Active := false;
end;

procedure TForm1.btnSendClick(Sender: TObject);
var
  data: TIdBytes;
begin
  SetLength(data, 4);
  for var i := Low(data) to High(data) do
    data[i] := i;

  IdUDPClient1.SendBuffer(data);
end;

procedure TForm1.IdUDPServer1UDPRead(AThread: TIdUDPListenerThread; const AData: TIdBytes; ABinding: TIdSocketHandle);
var
  str: string;
begin
  Memo1.Lines.Add('Length(AData)=' + Length(AData).ToString);
  str := '';
  for var i := Low(AData) to High(AData) do
  begin
    str := str + IntToHex(AData[i], 2) + ' ';
  end;
  Memo1.Lines.Add('AData = ' + str);
end;

end.
