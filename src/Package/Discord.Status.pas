unit Discord.Status;

interface

uses
  Winapi.ShellAPI, Winapi.Windows,
  System.SysUtils, System.Classes,
  Vcl.Menus, Vcl.Dialogs, Vcl.ActnList, Vcl.ComCtrls,
  ToolsAPI, View.Discord.Settings;

implementation

type
  TMethodContainer = class(TObject)
    procedure Click(Sender: TObject);
  end;

var
  NTAServices: INTAServices;
  FinderMenuItem: TMenuItem;
  aMethodContainer: TMethodContainer;

procedure TMethodContainer.Click(Sender: TObject);
begin
  FrmDiscordSettings := TFrmDiscordSettings.Create(nil);
  FrmDiscordSettings.ShowModal;
  FreeAndNil(FrmDiscordSettings);
end;

procedure Initialize(Sender: TObject);
begin
  if Supports(BorlandIDEServices, INTAServices, NTAServices) then
  begin
    aMethodContainer := TMethodContainer.Create;

    FinderMenuItem := TMenuItem.Create(nil);
    FinderMenuItem.Name := 'ProjectDiscordStatusMenuItem';
    FinderMenuItem.Caption := 'Delphi Discord Presence';
    FinderMenuItem.ImageIndex := 2;
    FinderMenuItem.OnClick := aMethodContainer.Click;
    FinderMenuItem.ShortCut := Ord('G') or scCtrl or scAlt;  // Ctrl+Alt+G for hotkey

    NTAServices.AddActionMenu('ToolsMenu', nil, FinderMenuItem, False, True);
  end;
end;

procedure Finalize(Sender: TObject);
begin
  FinderMenuItem.Free;
  aMethodContainer.Free;
end;

initialization
  Initialize(nil);

finalization
  Finalize(nil);

end.

