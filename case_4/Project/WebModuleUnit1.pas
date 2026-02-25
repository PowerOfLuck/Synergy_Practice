unit WebModuleUnit1;

interface

uses System.SysUtils, System.Classes, DataModuleUnit, DataSnap.DBClient, Web.HTTPApp;

type
  TWebModule1 = class(TWebModule)
    procedure WebModuleCreate(Sender: TObject);
    procedure WebModule1actRootAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1actListAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1actFormAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1actAddAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
  private
    Fdm: TDataModule1;
    function GetHTMLHeader(const Title: string): string;
    function GetHTMLFooter: string;
  public
    { Public declarations }
  end;

var
  WebModuleClass: TComponentClass = TWebModule1;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

procedure TWebModule1.WebModuleCreate(Sender: TObject);
begin
  Fdm := TDataModule1.Create(Self);
end;

function TWebModule1.GetHTMLHeader(const Title: string): string;
begin
  Result :=
    '<!DOCTYPE html>' +
    '<html>' +
    '<head>' +
    '<title>' + Title + '</title>' +
    '<meta charset="utf-8">' +
    '<style>' +
    'body { font-family: Arial; margin: 20px; } ' +
    'table { border-collapse: collapse; width: 100%; } ' +
    'th, td { border: 1px solid #ddd; padding: 8px; text-align: left; } ' +
    'th { background-color: #f2f2f2; } ' +
    'input[type=text], input[type=number] { width: 100%; padding: 8px; margin: 4px 0; } ' +
    'input[type=submit] { background-color: #4CAF50; color: white; padding: 10px; border: none; cursor: pointer; }' +
    'a { color: blue; text-decoration: none; }' +
    '</style>' +
    '</head>' +
    '<body>' +
    '<h1>Библиотека</h1>' +
    '<hr>';
end;

function TWebModule1.GetHTMLFooter: string;
begin
  Result := '<hr><a href="/weblibrary.dll/list">Список книг</a> | <a href="/weblibrary.dll/form">Добавить книгу</a></body></html>';
end;

procedure TWebModule1.WebModule1actRootAction(Sender: TObject; Request: TWebRequest;
  Response: TWebResponse; var Handled: Boolean);
begin
  Response.StatusCode := 302;  // Редирект
  Response.SetCustomHeader('Location', '/weblibrary.dll/list');
  Handled := True;
end;

procedure TWebModule1.WebModule1actListAction(Sender: TObject; Request: TWebRequest;
  Response: TWebResponse; var Handled: Boolean);
var
  ClientDS: TClientDataSet;
  HTML: TStringBuilder;
begin
  HTML := TStringBuilder.Create;
  try
    HTML.Append(GetHTMLHeader('Список книг'));
    HTML.Append('<h2>Каталог книг</h2>');
    HTML.Append('<table border="1"><tr><th>ID</th><th>Название</th><th>Автор</th><th>Год</th><th>ISBN</th></tr>');

    ClientDS := TClientDataSet.Create(nil);
    try
      ClientDS.SetProvider(Fdm.DataSetProvider1);
      ClientDS.Open;
      ClientDS.First;

      while not ClientDS.Eof do
      begin
        HTML.Append('<tr>');
        HTML.Append('<td>').Append(ClientDS.FieldByName('ID').AsString).Append('</td>');
        HTML.Append('<td>').Append(ClientDS.FieldByName('Title').AsString).Append('</td>');
        HTML.Append('<td>').Append(ClientDS.FieldByName('Author').AsString).Append('</td>');
        HTML.Append('<td>').Append(ClientDS.FieldByName('Year').AsString).Append('</td>');
        HTML.Append('<td>').Append(ClientDS.FieldByName('ISBN').AsString).Append('</td>');
        HTML.Append('</tr>');
        ClientDS.Next;
      end;
    finally
      ClientDS.Free;
    end;

    HTML.Append('</table>');
    HTML.Append(GetHTMLFooter);

    Response.ContentType := 'text/html; charset=utf-8';
    Response.Content := HTML.ToString;
  finally
    HTML.Free;
  end;
  Handled := True;
end;

procedure TWebModule1.WebModule1actFormAction(Sender: TObject; Request: TWebRequest;
  Response: TWebResponse; var Handled: Boolean);
var
  HTML: TStringBuilder;
begin
  HTML := TStringBuilder.Create;
  try
    HTML.Append(GetHTMLHeader('Добавление книги'));
    HTML.Append('<h2>Добавить новую книгу</h2>');
    HTML.Append('<form method="post" action="/weblibrary.dll/add">');
    HTML.Append('Название: <br><input type="text" name="title" required><br>');
    HTML.Append('Автор: <br><input type="text" name="author" required><br>');
    HTML.Append('Год: <br><input type="number" name="year"><br>');
    HTML.Append('ISBN: <br><input type="text" name="isbn"><br><br>');
    HTML.Append('<input type="submit" value="Сохранить">');
    HTML.Append('</form>');
    HTML.Append(GetHTMLFooter);

    Response.ContentType := 'text/html; charset=utf-8';
    Response.Content := HTML.ToString;
  finally
    HTML.Free;
  end;
  Handled := True;
end;

procedure TWebModule1.WebModule1actAddAction(Sender: TObject; Request: TWebRequest;
  Response: TWebResponse; var Handled: Boolean);
var
  SQL: string;
begin
  if Request.MethodType = mtPost then
  begin
    SQL := Format('INSERT INTO Books (Title, Author, Year, ISBN) VALUES ("%s", "%s", %s, "%s")',
      [StringReplace(Request.ContentFields.Values['title'], '"', '""', [rfReplaceAll]),
       StringReplace(Request.ContentFields.Values['author'], '"', '""', [rfReplaceAll]),
       Request.ContentFields.Values['year'],
       StringReplace(Request.ContentFields.Values['isbn'], '"', '""', [rfReplaceAll])]);

    Fdm.ADOConnection1.Execute(SQL);

    Response.StatusCode := 302;
    Response.SetCustomHeader('Location', '/weblibrary.dll/list');
  end
  else
  begin
    Response.Content := 'Метод не поддерживается.';
  end;
  Handled := True;
end;

end.
