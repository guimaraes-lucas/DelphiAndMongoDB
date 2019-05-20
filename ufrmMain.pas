unit ufrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MongoDB,
  FireDAC.Phys.MongoDBDef, System.Rtti, System.JSON.Types, System.JSON.Readers,
  System.JSON.BSON, System.JSON.Builders, FireDAC.Phys.MongoDBWrapper,
  FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, FireDAC.VCLUI.Error,
  FireDAC.Moni.Base, FireDAC.Moni.FlatFile, FireDAC.Comp.UI, Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TfrmMain = class(TForm)
    conMongoDB: TFDConnection;
    linkMongoDB: TFDPhysMongoDriverLink;
    crsMain: TFDGUIxWaitCursor;
    errorDlgMain: TFDGUIxErrorDialog;
    flatFileMain: TFDMoniFlatFileClientLink;
    pnlTop: TPanel;
    pnlBottom: TPanel;
    lblTotDocs: TLabel;
    btnInsert: TButton;
    btnUpdate: TButton;
    btnRemove: TButton;
    btnFind: TButton;
    btnQuery: TButton;
    btnFindSort: TButton;
    mmoResult: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure btnInsertClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure btnFindClick(Sender: TObject);
    procedure btnFindSortClick(Sender: TObject);
  private
    FCon: TMongoConnection;
    FEnv: TMongoEnv;
    procedure insertDocument();
    procedure updateDocument();
    procedure removeDocument();
    procedure searchDocument();
    procedure searchAndSortDocument();
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.btnFindClick(Sender: TObject);
begin
  searchDocument;
end;

procedure TfrmMain.btnFindSortClick(Sender: TObject);
begin
  searchAndSortDocument;
end;

procedure TfrmMain.btnInsertClick(Sender: TObject);
begin
  insertDocument;
end;

procedure TfrmMain.btnRemoveClick(Sender: TObject);
begin
  removeDocument;
end;

procedure TfrmMain.btnUpdateClick(Sender: TObject);
begin
  updateDocument;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  conMongoDB.Connected := True;
  FCon := TMongoConnection(conMongoDB.CliObj);
  FEnv := FCon.Env;
  mmoResult.Clear;
end;

procedure TfrmMain.insertDocument;
var
  oDoc: TMongoDocument;
begin
  oDoc := FEnv.NewDoc;
  try
    // construindo um novo documento
    oDoc
      .Add('nome','Gerrard')
      .Add('sobrenome','Lennon')
      .BeginObject('endereco')
        .Add('rua', '3 Avenue')
        .Add('numero', '1840')
        .Add('cep', '90084')
      .EndObject
      .Add('cidade', 'Liverpool')
      .Add('pais', 'Inglaterra');
    // Inserindo-o na colecao
    FCon['test']['cadastro'].Insert(oDoc);
    mmoResult.Lines.Add('Insert: ' + oDoc.AsJSON);
  finally
    FreeAndNil(oDoc);
  end;
end;

procedure TfrmMain.removeDocument;
begin
  FCon['test']['cadastro'].Remove()
    .Match()
      .Add('cidade', 'Glasgow')
    .&End
  .Exec;
  mmoResult.Lines.Add('Remove: ''cidade'' = ''Glasgow''');
end;

procedure TfrmMain.searchAndSortDocument;
var
  oCrs: IMongoCursor;
begin
  // encontrar os documentos e ordenar
  oCrs := FCon['test']['cadastro'].Find()
    .Match
      .Add('pais', 'Brasil')
    .&End
    .Sort
      .Ascending(['idade'])
    .&End;

  // percorrer o cursor
  while oCrs.Next do
    mmoResult.Lines.Add(oCrs.Doc.AsJSON);

  // conta total de documentos
  lblTotDocs.Caption :=
    FCon['test']['cadastro'].Count().Value().ToString()+
      ' documentos encontrados.';
end;

procedure TfrmMain.searchDocument;
var
  oCrs: IMongoCursor;
begin
  // encontrar os documentos
  oCrs := FCon['test']['cadastro'].Find();

  // percorrer o cursor
  while oCrs.Next do
    mmoResult.Lines.Add(oCrs.Doc.AsJSON);

  // conta total de documentos
  lblTotDocs.Caption :=
    FCon['test']['cadastro'].Count().Value().ToString()+
      ' documentos encontrados.';
end;

procedure TfrmMain.updateDocument;
begin
  // conexão
  FCon['test']['cadastro'].Update()
    // critérios
    .Match
      .Add('nome', 'José')
    .&End
    // alterações
    .Modify
      .&Set
        .Field('sobrenome', 'Silva')
        .Field('cidade', 'Rio de Janeiro')
        .Field('idade', 50)
      .&End
    .&End
    .Exec;
  mmoResult.Lines.Add('Update: ''nome'' = ''José'' set ''sobrenome'' = ''Silva'''
    + '''cidade'' = ''Rio de Janeiro'',''idade'' = 50''');

end;

end.
