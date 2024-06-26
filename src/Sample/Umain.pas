unit Umain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,DiscordRPC,
  Vcl.WinXCtrls, Vcl.Imaging.pngimage, Discord.Settings;

type
  TFrmMain = class(TForm)
    Timer1: TTimer;
    Panel1: TPanel;
    Image1: TImage;
    PnlID: TPanel;
    Label1: TLabel;
    EdtID: TEdit;
    ToggleSwitch1: TToggleSwitch;
    cbAddClienteID: TCheckBox;
    Image2: TImage;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ToggleSwitch1Click(Sender: TObject);
    procedure cbAddClienteIDClick(Sender: TObject);
  private
    Discord: TDiscordRPC;
    procedure UpdatePresence;
    procedure Disconnect;
    procedure Connect;
    function UseApplicationID: string;
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

procedure TFrmMain.Button1Click(Sender: TObject);
begin
  UpdatePresence;
end;

procedure TFrmMain.cbAddClienteIDClick(Sender: TObject);
begin
  PnlID.Visible:= cbAddClienteID.Checked;
end;

procedure TFrmMain.Connect;
begin
  Discord := TDiscordRPC.Create;
  Discord.Initialize(UseApplicationID);
end;

procedure TFrmMain.Disconnect;
begin
  if Assigned(Discord)  then
    Discord.Shutdown;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
   Connect;
end;

procedure TFrmMain.Timer1Timer(Sender: TObject);
begin
  UpdatePresence
end;

procedure TFrmMain.ToggleSwitch1Click(Sender: TObject);
begin
  if cbAddClienteID.Checked and  (EdtID.Text = '') then
    raise Exception.Create('Informe o CLiente ID ou use o Default');

  case ToggleSwitch1.State of
    tssOff:
    begin
      Timer1.Enabled := False;
      Disconnect;
    end;
    tssOn:
    begin
      Timer1.Enabled := True;
      Connect;
      UpdatePresence;
    end;
  end;
end;

procedure TFrmMain.UpdatePresence;
begin
  Discord.UpdatePresence('Editing Delphi'+ self.UnitName+'.pas', '...','__embarcadero_delphi','');
end;

function TFrmMain.UseApplicationID: string;
begin
  EdtID.Text:= TDiscordSettings.LoadENV(ApplicationID);
  result:= EdtID.Text;
  if  (cbAddClienteID.Checked) and  (((EdtID.Text = '') or (Length(EdtID.Text) < 5)))then
    result:= EdtID.Text;
end;

end.
