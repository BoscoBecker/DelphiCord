unit Discord;


interface

uses
  System.Classes,
  Vcl.Controls,
  Vcl.ComCtrls,
  Vcl.StdCtrls,
  ToolsAPI,
  System.SysUtils,
  Vcl.Dialogs,
  DiscordRPC;


type
  TDiscord = class(TNotifierObject, IOTAIDENotifier)
  private
    FINTAServices: INTAServices;
    FToolBar: TToolBar;
    FLabel: TLabel;
    FCheckBox : TCheckBox;
    FNotifierIndex: Integer;

    Discord: TDiscordRPC;
    procedure UpdatePresence;
    procedure Disconnect;
    procedure Connect;
    function UseApplicationID: string;

    procedure CreateToolbar;
    procedure UpdateLabelCaption;
    function GetCurrentProjectPath: string;
    procedure OnClickLabel(sender: TObject);
    procedure OnClickCheckBox(sender: TObject);
  public
    constructor Create;
    destructor Destroy; override;
    // IOTAIDENotifier methods
    procedure AfterCompile(Succeeded: Boolean); overload;
    procedure BeforeCompile(const Project: IOTAProject; var Cancel: Boolean); overload;
    procedure FileNotification(NotifyCode: TOTAFileNotification; const FileName: string; var Cancel: Boolean); overload;

  end;

procedure Register;

implementation

uses
  Vcl.Graphics;

procedure Register;
begin
  TDiscord.Create;
end;

{ TDiscord }

procedure TDiscord.AfterCompile(Succeeded: Boolean);
begin

end;

procedure TDiscord.BeforeCompile(const Project: IOTAProject; var Cancel: Boolean);
begin

end;

procedure TDiscord.Connect;
begin
  Discord := TDiscordRPC.Create;
  Discord.Initialize('1242970939033911407');
  UpdatePresence;
end;

constructor TDiscord.Create;
begin
  inherited Create;
  FINTAServices := BorlandIDEServices as INTAServices;
  if Assigned(FINTAServices) then
    CreateToolbar;

  FNotifierIndex := (BorlandIDEServices as IOTAServices).AddNotifier(Self);
end;

destructor TDiscord.Destroy;
var
  Services: IOTAServices;
begin
  Services := BorlandIDEServices as IOTAServices;
  if Assigned(Services) then
    Services.RemoveNotifier(FNotifierIndex);

  if Assigned(FToolBar) then
    FToolBar.Free;
  inherited;
end;


procedure TDiscord.Disconnect;
begin
  if Assigned(Discord)  then
    Discord.Shutdown;
end;

procedure TDiscord.FileNotification(NotifyCode: TOTAFileNotification; const FileName: string; var Cancel: Boolean);
begin
  if NotifyCode in [ofnFileOpening] then
  begin
    //UpdateLabelCaption;
    UpdatePresence;
  end;
end;

function TDiscord.GetCurrentProjectPath: string;
var
  IOTAProjectCurrent: IOTAProject;
  ProjectGroup: IOTAProjectGroup;
begin
  Result := '';
  ProjectGroup := (BorlandIDEServices as IOTAModuleServices).MainProjectGroup;
  if Assigned(ProjectGroup) and (ProjectGroup.ProjectCount > 0) then
  begin
    IOTAProjectCurrent := ProjectGroup.Projects[0];
    if Assigned(IOTAProjectCurrent) then
      Result := ExtractFileDir(IOTAProjectCurrent.FileName);
  end;
end;


procedure TDiscord.OnClickCheckBox(sender: TObject);
begin
  case FCheckBox.State of
    cbChecked: Connect;
    cbUnchecked: Disconnect;
  end;
end;

procedure TDiscord.OnClickLabel(sender: TObject);
begin
  //ShowMessage('GetCurrentProjectPath:'+GetCurrentProjectPath + ' ExtractVersionFromPath: ' + ExtractVersionFromPath(GetCurrentProjectPath));
end;

procedure TDiscord.UpdateLabelCaption;
begin
  //FLabel.Caption := GetCurrentProjectPath;
end;

procedure TDiscord.UpdatePresence;
begin
  Discord.UpdatePresence('Editing Delphi'+ self.UnitName+'.pas', '...','__embarcadero_delphi','');
end;

function TDiscord.UseApplicationID: string;
begin

end;

procedure TDiscord.CreateToolbar;
begin
  if not Assigned(FToolBar) then
  begin
    FToolBar := FINTAServices.NewToolbar('DiscordStatus', 'Discord status with a rich presence');
    FToolBar.Visible := True;
    FToolBar.Align := alTop;
    FToolBar.Width:= 500;
    FToolBar.Repaint;
//
//    FLabel := TLabel.Create(FToolBar);
//    FLabel.Parent := FToolBar;
//    FLabel.Caption := 'Loading...';
//    FLabel.Left := 10;
//    FLabel.Top := 10;
//    FLabel.Width:= 200;
//    FLabel.Align:= alLeft;
//    FLabel.Font.Color:= clgreen;
//    FLabel.Font.Style:= [TFontStyle.fsBold];

    FCheckBox:= TCheckBox.Create(FToolBar);
    FCheckBox.Parent:= FToolBar;
    FCheckBox.Caption:= 'Enabled Status Discord';
    FCheckBox.Checked:= False;
    FCheckBox.Align:= alLeft;
    FCheckBox.OnClick:= OnClickCheckBox;

    //FLabel.OnClick:= OnClickLabel;
    //UpdateLabelCaption;
    FLabel.Repaint;
  end;

end;

end.

