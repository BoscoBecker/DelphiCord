unit Discord.Settings;

interface

uses System.SysUtils, System.IOUtils, System.Classes, System.IniFiles;

type
    TENVKey = (ApplicationID, EnabledDiscord);
type
  TDiscordSettings = class
    public class function GetKeyString(const aKey: TENVKey): string;
    public class function GetENVFilePath: string;
    public class function LoadENV(const aKey: TENVKey): string;
    public class procedure SaveENV(const aKey: TENVKey; const aValue: string);
  end;

implementation

uses Discord.Consts ;

class function TDiscordSettings.GetENVFilePath: string;
begin
   result:= DISCORD_LIBRABRY_RPC + '\Discord.Conf.ini';
end;

class function TDiscordSettings.GetKeyString(const aKey: TENVKey): string;
begin
  case aKey of
    ApplicationID: Result := 'APPLICATIONID';
    EnabledDiscord: Result := 'DISCORDENABLED';
  else
    Result := '';
  end;
end;

class function TDiscordSettings.LoadENV(const aKey: TENVKey): string;
var
  IniFile: TIniFile;
  KeyString: string;
begin
  Result := '';
  KeyString := GetKeyString(aKey);
  if KeyString = '' then Exit;
  IniFile := TIniFile.Create(TDiscordSettings.GetENVFilePath);
  try
    Result := IniFile.ReadString('Settings', KeyString, '');
  finally
    IniFile.Free;
  end;
end;

class procedure TDiscordSettings.SaveENV(const aKey: TENVKey;
  const aValue: string);
var
  IniFile: TIniFile;
  KeyString: string;
begin
  KeyString := GetKeyString(aKey);
  if KeyString = '' then Exit;
  IniFile := TIniFile.Create(TDiscordSettings.GetENVFilePath());
  try
    IniFile.WriteString('Settings', KeyString, aValue);
  finally
    IniFile.Free;
  end;
end;


end.
