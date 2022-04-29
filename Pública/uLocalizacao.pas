unit uLocalizacao;

interface

type
  TLocalizacao = class
  private
    FCodigo:        String;
    FDescricao:     String;
    FNivelSuperior: Boolean;
    procedure SetCodigo(const Value: String);
  public
    property Codigo:        String  read FCodigo        write SetCodigo;
    property Descricao:     String  read FDescricao     write FDescricao;
    property NivelSuperior: Boolean read FNivelSuperior write FNivelSuperior;
  end;

implementation

{ TLocalizacao }

procedure TLocalizacao.SetCodigo(const Value: String);
begin
  FCodigo := Value;

  NivelSuperior := Copy(Value, Length(Value), 1) = '0';
end;

end.
