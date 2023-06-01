unit IxSampleThread;

interface

uses
  System.Classes, System.Generics.Collections, System.SyncObjs, System.SysUtils;

type
  TIxSampleThread = class(TThread)
  private
    { Private éŒ¾ }
  protected
    procedure Execute; override;
  public
    [volatile] Count: integer;
    Queue: TThreadedQueue<string>;
    constructor Create(CreateSuspended: Boolean);
  end;

implementation

uses Unit1;

{ TIxCopyThread }

constructor TIxSampleThread.Create(CreateSuspended: Boolean);
begin
  inherited Create(CreateSuspended);
  FreeOnTerminate := true; // I—¹‰ğ•ú
  Queue := TThreadedQueue<string>.Create(1000);
end;

procedure TIxSampleThread.Execute;
var
  value: string;
begin
  while not Terminated do
  begin
    if Queue.PopItem(value) = wrSignaled then
    begin
      sleep(1000); // 1•b
      dec(Count);
    end;
  end;
  Queue.Free;
end;

end.
