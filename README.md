
# Discord Rich Presence extension for Delphi

![image](https://github.com/BoscoBecker/DelphiCord/assets/6303278/6a4998b1-d59f-4451-a064-59882a3381e3)

## Description
Shows what you're editing in Delphi with advanced Dicord Rich Presence.

## Features
* Shows currenty edited file name
* Detects file extension and shows language icon (see extensions.pas for supported extensions)


The most up to date documentation for Rich Presence can always be found on our [developer site](https://discordapp.com/developers/docs/rich-presence/how-to)! 
If you're interested in rolling your own native implementation of Rich Presence via IPC sockets instead of using our SDK—hey, you've got free time, right?—check out the ["Hard Mode" documentation](https://github.com/discordapp/discord-rpc/blob/master/documentation/hard-mode.md).

## Basic Usage
First, head on over to the [Discord developers site](https://discordapp.com/developers/applications/me) and make yourself an app. Keep track of `Client ID` -- you'll need it here to pass to the init function.

![image](https://github.com/BoscoBecker/DelphiCord/assets/6303278/48b1ea27-ad6e-4539-8ccb-46cbebba5045)

### Installation:
Download e extract in "C:\DelphiCord"

### Folder's

/Discordrpc  - Discord RPC Dll's

/Package  - Plugin for IDE  

/Sample  -  VCL aplication

/Source - Abstraction to Call Dll in DiscordRPC.pas

/Win32/Debug - output for DelphiCord.exe, discord-rpc.dll, DiscordStatus.bpl,send-presence.exe 

External source 




Discord RPC  https://github.com/discord/discord-rpc

