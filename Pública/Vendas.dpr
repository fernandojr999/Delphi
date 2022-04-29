program Vendas;

uses
  System.StartUpCopy,
  FMX.Forms,
  uAnaliseVendas in 'uAnaliseVendas.pas' {frmVendas},
  uLocalizacao in 'uLocalizacao.pas',
  uRepresentante in 'uRepresentante.pas',
  uPessoa in 'uPessoa.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmVendas, frmVendas);
  Application.Run;
end.
