program DelphiCord;

uses
  Vcl.Forms,
  Umain in 'Umain.pas' {FrmMain},
  DiscordRPC in '..\Source\DiscordRPC.pas',
  Vcl.Themes,
  Vcl.Styles,
  Discord.Consts in '..\Package\Discord.Consts.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Windows10');
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
