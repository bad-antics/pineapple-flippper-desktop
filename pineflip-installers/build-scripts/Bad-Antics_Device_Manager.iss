; Bad-Antics Device Manager - Windows Installer Script
; Hacker-Themed Professional Installer
; Built with Inno Setup

#define MyAppName "Bad-Antics Device Manager"
#define MyAppVersion "1.0.0"
#define MyAppPublisher "Bad-Antics"
#define MyAppExeName "Bad-Antics_Device_Manager.exe"
#define MyAppAssociation ".badc"

[Setup]
; Installer settings
AppId={{FC5C2346-8D91-4A8B-9E5D-1A2B3C4D5E6F}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL=https://github.com/bad-antics/pineflip
AppSupportURL=https://github.com/bad-antics/pineflip/issues
AppUpdatesURL=https://github.com/bad-antics/pineflip/releases
DefaultDirName={autopf}\Bad-Antics\Device Manager
DefaultGroupName=Bad-Antics
DisableProgramGroupPage=yes
LicenseFile=LICENSE
OutputDir=dist
OutputBaseFilename=Bad-Antics_Device_Manager_Setup
Compression=lzma
SolidCompression=yes
WizardStyle=modern

; Visual customization - Hacker theme
WizardImageFile=installer_banner.bmp
WizardSmallImageFile=installer_icon.bmp
BackColor=$000000
BackColor2=$0a0a0a
WindowShowCaption=yes
SetupWindowTitle=Bad-Antics Device Manager Setup
SetupLogging=yes
SetupLogFileName={userappdata}\Bad-Antics\DeviceManager_Setup.log

; Security and permissions
PrivilegesRequired=lowest
AllowNetworkDrive=no
DisableDirPage=no
UninstallDisplayName={#MyAppName}
UninstallDisplayIcon={app}\{#MyAppExeName}

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked and skipifdoesntexist
Name: "startmenu"; Description: "Add to Start Menu"; GroupDescription: "Windows Integration"
Name: "fileassoc"; Description: "Associate .badc files with Bad-Antics"; GroupDescription: "File Associations"

[Files]
; Main executable
Source: "dist\{#MyAppExeName}"; DestDir: "{app}"; Flags: ignoreversion

; Documentation
Source: "README.md"; DestDir: "{app}"; Flags: ignoreversion isreadme
Source: "LICENSE"; DestDir: "{app}"; Flags: ignoreversion
Source: "requirements.txt"; DestDir: "{app}"; Flags: ignoreversion

; Source files (for developers)
Source: "device_manager.py"; DestDir: "{app}"; Flags: ignoreversion
Source: "desktop_app.py"; DestDir: "{app}"; Flags: ignoreversion

; Documentation folder
Source: "docs\*"; DestDir: "{app}\docs"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
; Desktop shortcut
Name: "{userdesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; IconFileName: "{app}\{#MyAppExeName}"; Comment: "Flipper Zero & WiFi Pineapple Management"

; Start menu shortcuts
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; IconFileName: "{app}\{#MyAppExeName}"; Comment: "Device Management Application"
Name: "{group}\Documentation"; Filename: "{app}\README.md"
Name: "{group}\License"; Filename: "{app}\LICENSE"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"

; Quick launch (if supported)
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; IconFileName: "{app}\{#MyAppExeName}"; Tasks: quicklaunchicon

[Run]
; Run application after install (optional)
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

[UninstallDelete]
; Clean up log files
Type: files; Name: "{userappdata}\Bad-Antics\DeviceManager_Setup.log"
Type: dirifempty; Name: "{userappdata}\Bad-Antics"

[Code]
// Pre-install checks
function NextButtonClick(CurPageID: Integer): Boolean;
var
  Python: Boolean;
  PyQt6: Boolean;
  ResultCode: Integer;
begin
  Result := True;
  
  if CurPageID = wpSelectDir then
  begin
    // Warn if system drive is full
    if DiskSpaceFree(WizardForm.DirEdit.Text) < 500000000 then
    begin
      if MsgBox('Warning: Less than 500MB free space detected. Continue anyway?', mbConfirmation, MB_YESNO) = IDNO then
        Result := False;
    end;
  end;
end;

// Post-install - Create shortcuts and associations
procedure CurStepChanged(CurStep: TSetupStep);
var
  ResultCode: Integer;
begin
  if CurStep = ssPostInstall then
  begin
    // Log installation details
    Log('Installation completed for ' + ExpandConstant('{#MyAppName}'));
    Log('Installed to: ' + ExpandConstant('{app}'));
    
    // Optional: Register file association
    if IsTaskSelected('fileassoc') then
    begin
      RegWriteStringValue(HKCU, 'Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.badc\UserChoice', '', ExpandConstant('{#MyAppExeName}'));
    end;
  end;
end;

// Display welcome message with hacker style
procedure CurPageChanged(CurPageID: Integer);
begin
  if CurPageID = wpWelcome then
  begin
    WizardForm.WelcomeLabel1.Caption := 'Welcome to Bad-Antics Device Manager';
    WizardForm.WelcomeLabel2.Caption := 
      'This installer will guide you through the installation of Bad-Antics Device Manager - ' +
      'a professional tool for managing Flipper Zero and WiFi Pineapple devices.' + #13 + #13 +
      'System Requirements:' + #13 +
      '• Windows 10 or later' + #13 +
      '• 500MB free disk space' + #13 +
      '• USB connection for Flipper Zero (optional)' + #13 +
      '• Network connection for WiFi Pineapple (optional)';
  end;
end;

// Uninstall hook
procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
begin
  if CurUninstallStep = usPostUninstall then
  begin
    Log('Uninstall completed');
  end;
end;
