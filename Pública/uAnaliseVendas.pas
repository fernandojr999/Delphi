unit uAnaliseVendas;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  System.Generics.Collections,

  uLocalizacao,
  uRepresentante, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo,
  FMX.StdCtrls;

type
  TfrmVendas = class(TForm)
    mmVendas: TMemo;
    lblVendas: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FListaLocalizacoes: TList<TLocalizacao>;
    FListaRepresentantes: TList<TRepresentante>;
    procedure CarregaLocalizacao(pCodigo, pDescricao: String);
    procedure CarregaRepresentante(pCodigo: Integer; pNome: String;
                                   pValorVendas: Double; pLocalizacaoStr: String);
    function RetornaLocalizacaoPorCodigo(pCodigo: String): TLocalizacao;
    function RetornaSaldoLocalizacao(pLocalizacao: TLocalizacao): Double;

    procedure CarregaMemo;
  public
    { Public declarations }
  end;

var
  frmVendas: TfrmVendas;

implementation

{$R *.fmx}

procedure TfrmVendas.CarregaLocalizacao(pCodigo, pDescricao: String);
var
  LocalizacaoObj: TLocalizacao;
begin
  LocalizacaoObj := TLocalizacao.Create;
  LocalizacaoObj.Codigo    := pCodigo;
  LocalizacaoObj.Descricao := pDescricao;
  FListaLocalizacoes.Add(LocalizacaoObj);
end;

procedure TfrmVendas.CarregaMemo;
var
  I: Integer;
  Linha: String;
begin
  for I := 0 to FListaLocalizacoes.Count - 1 do
  begin
    Linha := FListaLocalizacoes.Items[I].Codigo+ '   '+
             FListaLocalizacoes.Items[I].Descricao+ '   '+
             'R$'+FormatFloat('###,###,##0.00',RetornaSaldoLocalizacao(FListaLocalizacoes.Items[I]));
    if not FListaLocalizacoes.Items[I].NivelSuperior then
      Linha := '          '+Linha;
    mmVendas.Lines.Add(Linha);
  end;
end;

procedure TfrmVendas.CarregaRepresentante(pCodigo: Integer; pNome: String;
  pValorVendas: Double; pLocalizacaoStr: String);
var
  RepresentanteObj: TRepresentante;
begin
  RepresentanteObj := TRepresentante.Create;
  RepresentanteObj.Codigo      := pCodigo;
  RepresentanteObj.Nome        := pNome;
  RepresentanteObj.ValorVendas := pValorVendas;
  RepresentanteObj.Localizacao := RetornaLocalizacaoPorCodigo(pLocalizacaoStr);

  FListaRepresentantes.Add(RepresentanteObj);
end;

procedure TfrmVendas.FormCreate(Sender: TObject);
begin
  FListaLocalizacoes := TList<TLocalizacao>.Create;
  CarregaLocalizacao('1.0', 'Santa Catarina');
  CarregaLocalizacao('1.1', 'Florianópolis');
  CarregaLocalizacao('1.2', 'Blumenau');
  CarregaLocalizacao('1.3', 'Balneário Camboriú');
  CarregaLocalizacao('2.0', 'Rio Grande do Sul');
  CarregaLocalizacao('2.1', 'Porto Alegre');
  CarregaLocalizacao('2.2', 'Canoas');
  CarregaLocalizacao('2.3', 'Esteio');

  FListaRepresentantes := TList<TRepresentante>.Create;
  CarregaRepresentante(1,  'Representante1', 10000.00, '1.3');
  CarregaRepresentante(2,  'Representante1', 5000.00, '1.2');
  CarregaRepresentante(3,  'Representante1', 5000.00, '1.2');
  CarregaRepresentante(4,  'Representante1', 20000.00, '1.1');
  CarregaRepresentante(5,  'Representante1', 7000.00, '1.3');
  CarregaRepresentante(6,  'Representante1', 3000.00, '2.2');
  CarregaRepresentante(7,  'Representante1', 15000.00, '1.3');
  CarregaRepresentante(8,  'Representante1', 25000.00, '2.1');
  CarregaRepresentante(9,  'Representante1', 1500.00, '2.2');
  CarregaRepresentante(10, 'Representante1', 5000.00, '2.3');

  CarregaMemo;

   mmVendas.Lines.Add('  ');
  mmVendas.Lines.Add('*****');
  mmVendas.Lines.Add('Os valores não batem com a imagem que estava no documento, '+
                     'pois, havia um valor vendido de 15.000,00 para a localização 1.3.');
end;

function TfrmVendas.RetornaLocalizacaoPorCodigo(pCodigo: String): TLocalizacao;
var
  I: Integer;
begin
  for I := 0 to FListaLocalizacoes.Count - 1 do
  begin
    if FListaLocalizacoes.Items[I].Codigo = pCodigo then
      Result := FListaLocalizacoes.Items[I];
  end;
end;

function TfrmVendas.RetornaSaldoLocalizacao(pLocalizacao: TLocalizacao): Double;
var
  I: Integer;
  CodigoLoc: String;
begin
  Result := 0;

  if pLocalizacao.NivelSuperior then
    CodigoLoc := Copy(pLocalizacao.Codigo, 0, Length(pLocalizacao.Codigo) - 1)
  else
    CodigoLoc := pLocalizacao.Codigo;

  for I := 0 to FListaRepresentantes.Count - 1 do
  begin
    if Pos(CodigoLoc, FListaRepresentantes.Items[I].Localizacao.Codigo) <> 0 then
    begin
      Result := Result + FListaRepresentantes.Items[I].ValorVendas;
    end;
  end;
end;

end.
