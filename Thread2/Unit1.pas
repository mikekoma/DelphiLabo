unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.Edit, FMX.EditBox, FMX.SpinBox, FMX.StdCtrls, FMX.Controls.Presentation,
  FMX.ScrollBox, FMX.Memo, FMX.Platform, IxSampleThread;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    SpinBox1: TSpinBox;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { private �錾 }
    [volatile] thread_live: boolean;
    thread: TIxSampleThread;
    procedure onterminate_thread(Sender: TObject);
  public
    { public �錾 }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.Button1Click(Sender: TObject);
var
  num: integer;
begin
  // �X���b�h���N�����Ă�������s���Ȃ�
  if thread_live then
    Exit;

  Button1.Enabled := false;
  try
    Memo1.Lines.Add('�����J�n');
    // ------------------------------------
    // �X���b�h����
    // ------------------------------------
    thread := TIxSampleThread.Create(True); // ��~��ԂŐ���
    thread.FreeOnTerminate := True; // �I�������
    thread.OnTerminate := onterminate_thread; // �I�����C�x���g����
    thread_live := True;

    // ------------------------------------
    // �X���b�h�ɓn���f�[�^����
    // ------------------------------------
    num := Round(SpinBox1.Value);
    for var i := 0 to Round(num) - 1 do
    begin
      thread.Queue.Enqueue(i.ToString);
    end;

    // ------------------------------------
    // �X���b�h�N��
    // ------------------------------------
    thread.Resume;

    // ------------------------------------
    // �X���b�h�I���܂�
    // ------------------------------------
    while thread_live do
      Application.ProcessMessages;

  finally
    Button1.Enabled := True;
  end;

  Memo1.Lines.Add('�����I��');
end;

{
  ����
  FormDestroy�ŃX���b�h���~��������OnTerminate�������Ȃ�
}
procedure TForm1.onterminate_thread(Sender: TObject);
begin
  thread_live := false;
  Memo1.Lines.Add('OnTerminate�C�x���g�F�X���b�h�I��');
end;

end.
