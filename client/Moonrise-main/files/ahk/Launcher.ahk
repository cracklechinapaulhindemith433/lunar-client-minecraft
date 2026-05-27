#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%

AutoClose := 1
SelectedVersion := "1.8.9" 

Gui, Color, FFFFFF
Gui, Font, s10, Verdana

Gui, Add, Picture, x0 y0 w400 h600 BackgroundImage, %A_ScriptDir%\files\background.png
Gui, Add, Text, x0 y10 w400 center c000000, Welcome!
Gui, Add, Text, x0 y35 w400 center c000000, Please make sure you have typed your username and RAM allocation in settings.
Gui, Add, DropDownList, x50 y70 w300 h200 vLaunchVersion, 1.8.9|1.12.2|1.19.2|1.20.1
GuiControl, Choose, LaunchVersion, %SelectedVersion% 
Gui, Add, Button, x100 y425 w200 h50 gLaunchButton, Launch 
Gui, Add, Button, x300 y500 w80 h30 gShowSettingsTab, Settings

Gui, Show, w400 h600, Moonrise
Return

ShowSettingsTab:
Gui, Destroy
Gui, Color, FFFFFF
Gui, Font, s10, Verdana

Gui, Add, Picture, x0 y0 w400 h600 BackgroundImage, %A_ScriptDir%\files\background.png
Gui, Add, Text, x0 y10 w400 center c000000, Settings
Gui, Add, Text, x100 y50 w200 h30 center c000000, Username
Gui, Add, Edit, x100 y80 w200 h30 vUsername


ConfigFile := "C:\Users\" . A_UserName . "\.lunarclient\config.txt"
FileReadLine, UsernameValue, %ConfigFile%, 1
GuiControl,, Username, %UsernameValue%

Gui, Add, Text, x100 y120 w200 h30 center c000000, RAM Allocation (MB) numbers only!
Gui, Add, Edit, x100 y150 w200 h30 vRAMAllocation


RAMConfigFile := "C:\Users\" . A_UserName . "\.lunarclient\ramallocation.txt"
FileReadLine, RAMAllocationValue, %RAMConfigFile%, 1
GuiControl,, RAMAllocation, %RAMAllocationValue%

Gui, Add, Button, x140 y190 w120 h40 gSaveSettings, Save
Gui, Add, Button, x15 y30 w80 h35 gShowCreditsPopup, Credits

if (AutoClose)
    Gui, Add, Button, x100 y240 w200 h40 gToggleAutoClose, After Launch: Close
else
    Gui, Add, Button, x100 y240 w200 h40 gToggleAutoClose, After Launch: Keep Launcher Open

Gui, Add, Button, x300 y500 w80 h30 gShowMainTab, Back
Gui, Add, Button, x310 y30 w80 h35 gOpenMyChannel, My Channel
Gui, Show, w400 h600, Moonrise
Return

LaunchButton:
GuiControlGet, LaunchVersion
GuiControl,, Text,, Launching %LaunchVersion%...
GuiControl,, LaunchVersion

SelectedVersion := LaunchVersion

if (AutoClose)
    SetTimer, CloseGUI, 3000

Run, %A_ScriptDir%\files\launch%LaunchVersion%.vbs
Return

SaveSettings:
GuiControlGet, UsernameValue,, Username
ConfigFile := "C:\Users\" . A_UserName . "\.lunarclient\config.txt"
FileDelete, %ConfigFile%
FileAppend, %UsernameValue%, %ConfigFile%

GuiControlGet, RAMAllocationValue,, RAMAllocation
RAMConfigFile := "C:\Users\" . A_UserName . "\.lunarclient\ramallocation.txt"
FileDelete, %RAMConfigFile%
FileAppend, %RAMAllocationValue%, %RAMConfigFile%

MsgBox, Settings saved successfully!
Return

ShowMainTab:
Gui, Destroy
Gui, Color, FFFFFF
Gui, Font, s10, Verdana

Gui, Add, Picture, x0 y0 w400 h600 BackgroundImage, %A_ScriptDir%\files\background.png
Gui, Add, Text, x0 y10 w400 center c000000, Moonrise
Gui, Add, Text, x0 y35 w400 center c000000, Please make sure you have typed your username in settings.
Gui, Add, DropDownList, x50 y70 w300 h200 vLaunchVersion, 1.8.9|1.12.2|1.19.2|1.20.1
GuiControl, Choose, LaunchVersion, %SelectedVersion% 
Gui, Add, Button, x100 y425 w200 h50 gLaunchButton, Launch 
Gui, Add, Button, x300 y500 w80 h30 gShowSettingsTab, Settings

Gui, Show, w400 h600, Moonrise
Return

ToggleAutoClose:
AutoClose := !AutoClose

if (AutoClose) {
    GuiControl, Text, gToggleAutoClose, After Launch: Close
    MsgBox, Settings saved successfully!
}
else {
    GuiControl, Text, gToggleAutoClose, After Launch: Keep Launcher Open
    MsgBox, Settings saved successfully!
}

Return

CloseGUI:
GuiClose:
ExitApp

OpenMyChannel:
Run, https://www.youtube.com/
Return

ShowCreditsPopup:
MsgBox, Launcher by Mrn1`nAgent by Nilsen84`nWeave Loader by Weave-MC
Return
