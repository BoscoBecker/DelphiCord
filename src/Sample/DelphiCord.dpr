program DelphiCord;

uses
  Vcl.Forms,
  Umain in 'Umain.pas' {FrmMain},
  DiscordRPC in '..\Source\DiscordRPC.pas',
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Windows10');
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
