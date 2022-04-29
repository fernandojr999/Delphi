unit uPessoa;

interface

type
  TPessoa = class
  private
    FCodigo: Integer;
    FNome: String;

  public
    property Codigo: Integer read FCodigo write FCodigo;
    property Nome:   String  read FNome   write FNome;
  end;

implementation

end.
