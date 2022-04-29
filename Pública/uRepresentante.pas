unit uRepresentante;

interface

uses
  uPessoa,
  uLocalizacao;

type
  TRepresentante = class(TPessoa)
  private
    FValorVendas: Double;
    FLocalizacao: TLocalizacao;
  public
    property ValorVendas: Double read FValorVendas write FValorVendas;
    property Localizacao: TLocalizacao read FLocalizacao write FLocalizacao;
  end;

implementation

end.
