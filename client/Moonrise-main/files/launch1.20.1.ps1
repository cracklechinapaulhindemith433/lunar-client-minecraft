$host.UI.RawUI.WindowTitle = "Lc Cracked+"

$ConfigFilePath = "$env:userprofile\.lunarclient\config.txt"
$RamAllocationFilePath = "$env:userprofile\.lunarclient\ramallocation.txt"

Write-Host ""
Write-Host ".____            _________                       __              .___            "
Write-Host "|    |    ____   \_   ___ \____________    ____ |  | __ ____   __| _/    .__     "
Write-Host "|    |  _/ ___\  /    \  \/\_  __ \__  \ _/ ___\|  |/ // __ \ / __ |   __|  |___ "
Write-Host "|    |__\  \___  \     \____|  | \// __ \\  \___|    <\  ___// /_/ |  /__    __/ "
Write-Host "|_______ \___  >  \______  /|__|  (____  /\___  >__|_ \\___  >____ |     |__|    "
Write-Host "        \/   \/          \/            \/     \/     \/    \/     \/             "

Write-Host ""


Write-Host -ForegroundColor Red "Lunar Client Cracked - Agent by Nilsen84" -NoNewline
Write-Host -ForegroundColor Green " - 1.20.1" -NoNewline
Write-Host -ForegroundColor Cyan " - Modified by Mrn1"


$playerName = Get-Content $ConfigFilePath


$weaveModsFolderPath = "$env:userprofile\.weave\mods"
$jarFiles = Get-ChildItem -Path $weaveModsFolderPath -Filter "*.jar"
$modCount = $jarFiles.Count

if ($modCount -eq 1) {
    Write-Host "$modCount mod found - Version Supported Not by Weave" -ForegroundColor Green
}
else {
    Write-Host "$modCount mods found - Version Supported Not by Weave" -ForegroundColor Green
}

$weaveLoaderReleaseUrl = "https://api.github.com/repos/Weave-MC/Weave-Loader/releases/latest"
$weaveLoaderReleaseInfo = Invoke-RestMethod -Uri $weaveLoaderReleaseUrl
$weaveLoaderDownloadUrl = $weaveLoaderReleaseInfo.assets[0].browser_download_url

$weaveLoaderPath = "C:\Users\$($env:UserName)\.lunarclient\" + $weaveLoaderReleaseInfo.tag_name + ".jar"

$weaveModsFolderPath = "$env:userprofile\.weave\mods"
$jarFiles = Get-ChildItem -Path $weaveModsFolderPath -Filter "*.jar"

if (-Not (Test-Path "$env:userprofile\.lunarclient\CrackedAccount.jar")) {
    Write-Host "Downloading Agent"
    Invoke-WebRequest -Uri "https://github.com/Nilsen84/lunar-client-agents/releases/download/v1.2.0/CrackedAccount.jar" -OutFile "$env:userprofile\.lunarclient\CrackedAccount.jar"
}

if (-Not (Test-Path $weaveLoaderPath)) {
    Write-Host "Downloading Weave Loader Agent"
    Invoke-WebRequest -Uri $weaveLoaderDownloadUrl -OutFile $weaveLoaderPath
}

if (Test-Path $RamAllocationFilePath) {
    $ramAllocationValues = Get-Content $RamAllocationFilePath
    $Xms = "-Xms$ramAllocationValues`m"
    $Xmx = "-Xmx$ramAllocationValues`m"
    $Xmn = "-Xmn$ramAllocationValues`m"
} else {
    $Xms = "-Xms1G"
    $Xmx = "-Xmx4000m"
    $Xmn = "-Xmn768m"
}

$javaJre = (Resolve-Path "$env:userprofile\.lunarclient\jre\*\zulu17*\bin")[0]
cd "$env:userprofile\.lunarclient\offline\multiver"

# Arguments
$launchArgs = "--add-modules",
    "jdk.naming.dns",
    "--add-exports",
    "jdk.naming.dns/com.sun.jndi.dns=java.naming",
    "-Djna.boot.library.path=$env:userprofile\.lunarclient\offline\multiver\natives",
    "-Dlog4j2.formatMsgNoLookups=true",
    "--add-opens",
    "java.base/java.io=ALL-UNNAMED",
    "-javaagent:$env:userprofile\.lunarclient\CrackedAccount.jar=$playerName",
    $Xms, $Xmx, $Xmn,
    "-Djava.library.path=$env:userprofile\.lunarclient\offline\multiver\natives",
    "-Dsolar.launchType=launcher",
    "-cp",
    "sodium-0.1.0-SNAPSHOT-all.jar;modern-0.1.0-SNAPSHOT-all.jar;genesis-0.1.0-SNAPSHOT-all.jar;lunar-lang.jar;lunar-emote.jar;lunar.jar;fabric-0.1.0-SNAPSHOT-all.jar;fabric-0.1.0-SNAPSHOT-v1_20_1.jar;common-0.1.0-SNAPSHOT-all.jar",
    "com.moonsworth.lunar.genesis.Genesis",
    "--version",
    "1.20.1",
    "--accessToken",
    "0",
    "--assetIndex",
    "5",
    "--userProperties",
    "{}",
    "--gameDir",
    "$env:userprofile\AppData\Roaming\.minecraft",
    "--assetsDir",
    "$env:userprofile\AppData\Roaming\.minecraft\assets",
    "--texturesDir",
    "$env:userprofile\.lunarclient\textures",
    "--width",
    "854",
    "--height",
    "480",
    "--ichorClassPath",
    "sodium-0.1.0-SNAPSHOT-all.jar,modern-0.1.0-SNAPSHOT-all.jar,genesis-0.1.0-SNAPSHOT-all.jar,lunar-lang.jar,lunar-emote.jar,lunar.jar,fabric-0.1.0-SNAPSHOT-all.jar,fabric-0.1.0-SNAPSHOT-v1_20_1.jar,common-0.1.0-SNAPSHOT-all.jar",
    "--ichorExternalFiles",
    "Sodium-v1_20_1-0.4.10+build.27.jar,Indium-v1_20_1-1.0.15-notactuallyupdated.jar,Iris-v1_20_1-1.6.4.jar",
    "--workingDirectory",
    ".",
    "--classpathDir",
    "$env:userprofile\.lunarclient\offline\multiver",
    "--installationId",
    "542250c2-e7d6-4803-9390-084e707a82fd",
    "--hwid",
    "f8a91817f0ef6fcd9c4c48607ce9235bdae521654d8234b83d8156e839795499"

& "$javaJre\java.exe" $launchArgs
