unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client;

type
  TForm1 = class(TForm)
    edServer: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    edDB: TEdit;
    edPort: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    edUser: TEdit;
    Memo1: TMemo;
    btnConnect: TButton;
    Label5: TLabel;
    edPassword: TEdit;
    FDConnection1: TFDConnection;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnConnectClick(Sender: TObject);
  private
    procedure LogMess(const TheMessage: string);
    function GetIniFileName: string;
    procedure GetSettings;
    procedure SaveSettings;
  end;

var
  Form1: TForm1;

implementation
uses System.IniFiles;

const IniSect = 'memory';

{$R *.dfm}

{ TForm1 }

procedure TForm1.btnConnectClick(Sender: TObject);
begin
  Memo1.Clear;
  try
    FDConnection1.Close;
    FDConnection1.Open(Format('DriverID=MySQL;Server=%s;Database=%s;Port=%d', [
                               edServer.Text,
                               edDB.Text,
                               StrToIntDef(edPort.Text, 3306)]),
                               edUser.Text,
                               edPassword.Text);
    if FDConnection1.Connected then
        LogMess('Db reports it connected ok. Success!')
    else
      LogMess('Db reports it is NOT connected. Failed');
 except
    on E: Exception do LogMess('Error while testing connectivity to db.  "' + E.Message + '"');
  end;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  SaveSettings;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  try
    // Explicitly look in same foolder as the exe to find the MariaDB dll
    FDPhysMySQLDriverLink1.VendorLib := ExtractFilePath(ParamStr(0)) + 'libmariadb.dll';
  except
    on E: Exception do
     LogMess('Unable to load librariadb.dll - "' + E.Message + '"');
  end;
  GetSettings;
end;

function TForm1.GetIniFileName: string;
begin
  Result := ChangeFileExt(ParamStr(0), '.ini');
end;

procedure TForm1.GetSettings;
var
  tmpINI: TIniFile;

  procedure GetIt(TheEdit: TEdit);
  begin
    TheEdit.Text := tmpINI.ReadString(IniSect, TheEdit.Name, TheEdit.Text);
  end;

begin
  // dirty persist the DB settings (don't do this in a production app!)
  tmpINI := TIniFile.Create(GetIniFileName);
  try
    GetIt(edServer);
    GetIt(edDB);
    GetIt(edPort);
    GetIt(edUser);
    GetIt(edPassword);
  finally
    tmpINI.Free;
  end;
end;

procedure TForm1.LogMess(const TheMessage: string);
begin
  Memo1.Lines.Add(TheMessage);
end;

procedure TForm1.SaveSettings;
var
  tmpINI: TIniFile;

  procedure SaveIt(TheEdit: TEdit);
  begin
    tmpINI.WriteString(IniSect, TheEdit.Name, TheEdit.Text);
  end;

begin
  // dirty persist the DB settings (don't do this in a production app!)
  tmpINI := TIniFile.Create(GetIniFileName);
  try
    SaveIt(edServer);
    SaveIt(edDB);
    SaveIt(edPort);
    SaveIt(edUser);
    SaveIt(edPassword);
  finally
    tmpINI.Free;
  end;
end;

end.
