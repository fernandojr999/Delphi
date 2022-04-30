unit uListaDiretorio;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, FMX.StdCtrls, FMX.Controls.Presentation,

  // Adicionar a Unit 'System.IOUtils'
  System.IOUtils, System.ImageList, FMX.ImgList;

type
  TForm1 = class(TForm)
    ToolBar1: TToolBar;
    Label1: TLabel;
    lvLista: TListView;
    lblDiretorio: TLabel;
    imlImagens: TImageList;
    procedure FormShow(Sender: TObject);
    procedure lvListaItemClickEx(const Sender: TObject; ItemIndex: Integer;
      const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ListarDiretorio(pDiretorio: String);
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

{ TForm1 }

procedure TForm1.FormShow(Sender: TObject);
begin
  ListarDiretorio(TPath.GetSharedDocumentsPath);
end;

procedure TForm1.ListarDiretorio(pDiretorio: String);
var
  pastas, arquivos: TStringDynArray;
  pasta, arquivo: string;
  lstItem: TListViewItem;
begin

    lvLista.Items.Clear;
    lblDiretorio.Text := pDiretorio;
    pastas := TDirectory.GetDirectories(pDiretorio);
    arquivos := TDirectory.GetFiles(pDiretorio);
    lvLista.BeginUpdate;

    lstItem := lvLista.Items.Add;
    lstItem.Detail := 'voltar';
    lstItem.Text := '..<< Voltar';

    for pasta in pastas do
    begin
      //Carrega as Pastas
      lstItem := lvLista.Items.Add;
      lstItem.Detail := 'pasta';
      lstItem.Text := Copy(pasta, Length(ExtractFilePath(pasta))+1, Length(pasta));
      lstItem.ImageIndex := 1;
    end;

    for arquivo in arquivos do
    begin
      //Carrega os Arquivos
      lstItem := lvLista.Items.Add;
      lstItem.Detail := 'arquivo';
      lstItem.Text := ExtractFileName(arquivo);
      lstItem.ImageIndex := 0;
    end;

    lvLista.EndUpdate;

end;

procedure TForm1.lvListaItemClickEx(const Sender: TObject; ItemIndex: Integer;
  const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
begin
  if lvLista.Items[lvLista.ItemIndex].Detail = 'pasta' then
    ListarDiretorio(lblDiretorio.Text+PathDelim+lvLista.Items[lvLista.ItemIndex].Text)
  else
  if lvLista.Items[lvLista.ItemIndex].Detail='voltar' then
    ListarDiretorio(copy(ExtractFilePath(lblDiretorio.text), 0,Length(ExtractFilePath(lblDiretorio.text))-1));
end;

end.
