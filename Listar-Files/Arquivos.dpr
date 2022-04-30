program Arquivos;

uses
  System.StartUpCopy,
  FMX.Forms,
  uListaDiretorio in 'uListaDiretorio.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
