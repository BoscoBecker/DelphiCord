unit Package.Discord.Status;

interface

uses
  System.Classes,
  System.SysUtils,
  System.StrUtils,
  System.DateUtils,

  Vcl.Controls,
  Vcl.ComCtrls,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.Graphics,
  Vcl.Dialogs,

  ToolsAPI,
  DiscordRPC;

type
  TDiscordStatus = class(TNotifierObject, IOTAIDENotifier)
  private
    FINTAServices: INTAServices;
    FToolBar: TToolBar;
    FLabel: TLabel;
    FCheckBox : TCheckBox;
    FNotifierIndex: Integer;
    FCurrentFile: string;
    FStartTime: TDateTime;
    Discord: TDiscordRPC;
    FFCurrentFile: String;
    procedure UpdatePresence(const aFIle: string='');
    procedure Disconnect;
    procedure Connect;
    procedure CreateToolbar;
    procedure OnClickCheckBox(sender: TObject);
    procedure SetFCurrentFile(const Value: String);
    procedure ClosingFIle;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AfterCompile(Succeeded: Boolean); overload;
    procedure BeforeCompile(const Project: IOTAProject; var Cancel: Boolean); overload;
    procedure FileNotification(NotifyCode: TOTAFileNotification; const FileName: string; var Cancel: Boolean); overload;
    property CurrentFile :String read FFCurrentFile write SetFCurrentFile;
  end;

procedure Register;

implementation

procedure Register;
begin
  TDiscordStatus.Create;
end;

procedure TDiscordStatus.AfterCompile(Succeeded: Boolean);
begin
end;

procedure TDiscordStatus.BeforeCompile(const Project: IOTAProject; var Cancel: Boolean);
begin
end;

procedure TDiscordStatus.Connect;
begin
  Discord := TDiscordRPC.Create;
  Discord.Initialize('1242970939033911407');
  UpdatePresence();
end;

constructor TDiscordStatus.Create;
begin
  inherited Create;
  FINTAServices := BorlandIDEServices as INTAServices;
  if Assigned(FINTAServices) then CreateToolbar;

  FNotifierIndex := (BorlandIDEServices as IOTAServices).AddNotifier(Self);
end;

destructor TDiscordStatus.Destroy;
var
  Services: IOTAServices;
begin
  if Assigned(Discord) then
    Disconnect;

  Services := BorlandIDEServices as IOTAServices;
  if Assigned(Services) then
    Services.RemoveNotifier(FNotifierIndex);

  if Assigned(FToolBar) then
    FToolBar.Free;

  inherited;
end;


procedure TDiscordStatus.Disconnect;
begin
  if Assigned(Discord)  then
    Discord.Shutdown;
end;

procedure TDiscordStatus.ClosingFIle;
begin
  CurrentFile := '';
  UpdatePresence;
end;

procedure TDiscordStatus.FileNotification(NotifyCode: TOTAFileNotification; const FileName: string; var Cancel: Boolean);
begin
  case NotifyCode of
     ofnFileOpening: UpdatePresence(ExtractFileName(FileName));
     ofnActiveProjectChanged: UpdatePresence(ExtractFileName(FileName));
     ofnFileOpened: UpdatePresence(ExtractFileName(FileName));
     ofnFileClosing: UpdatePresence(ExtractFileName(''));
     ofnPackageUninstalled: Destroy;
  end;
end;

procedure TDiscordStatus.OnClickCheckBox(sender: TObject);
begin
  case FCheckBox.State of
    cbChecked: Connect;
    cbUnchecked: Disconnect;
  end;
end;

procedure TDiscordStatus.SetFCurrentFile(const Value: String);
begin
  FFCurrentFile := Value;
end;

procedure TDiscordStatus.UpdatePresence(const aFIle: string);
begin
  SetFCurrentFile(aFIle);
  if aFIle.Trim.Equals('') and FCurrentFile.Trim.Equals('') then
    Discord.UpdatePresence('Editing Delphi : No active file', 'Hora : ' + FormatDateTime('dd/mm/yyyy hh:mm:ss', Now()),'__embarcadero_delphi','')
  else
    Discord.UpdatePresence('Editing Delphi : ' + ifthen(aFIle.Equals(''), FCurrentFile, aFIle), 'Hora : ' + FormatDateTime('dd/mm/yyyy hh:mm:ss', Now()),'__embarcadero_delphi','');
end;

procedure TDiscordStatus.CreateToolbar;
begin
  if not Assigned(FToolBar) then
  begin
    FToolBar := FINTAServices.NewToolbar('DiscordStatus', 'Discord status with a rich presence');
    FToolBar.Visible := True;
    FToolBar.Align := alTop;
    FToolBar.Width:= 500;
    FToolBar.Repaint;

    FCheckBox:= TCheckBox.Create(FToolBar);
    FCheckBox.Parent:= FToolBar;
    FCheckBox.Caption:= 'Enabled Discord Status ';
    FCheckBox.Width:= 200;
    FCheckBox.Align:= alClient;
    FCheckBox.OnClick:= OnClickCheckBox;
    FCheckBox.Checked:= True;
    FToolBar.Repaint;
  end;
end;

end.
