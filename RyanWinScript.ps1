"
#######################################
### PEGASUS Middle PS Script        ###
### MIT License                     ###
### Copyright (c) Cadet Ryan Holmes ###
#######################################
"

do {
Write-Host "
Type 'exit' to leave script.
0   Service menu
1   Users and groups menu
2   Policy menu
3   Search unauthorized files
"

$input = Read-host

if ($input -eq "0") {
do {
Write-Host "
Type 'back' to go to previous menu
0   List all services
1   List running services
2   List stopped services
"

$inputservice = Read-Host

if ($inputservice -eq "0") {
Write-host "All services:"
    Get-Service
    }
if ($inputservice -eq "1") {
Write-Host "Running services"
Get-Service | Where Status -EQ "Running" | Out-Default
}
if ($inputservice -eq "2") {
Write-Host "Stopped services"
Get-Service | Where Status -EQ "Stopped" | Out-Default
}} until ($inputservice -eq "back")}

if ($input -eq "1") {
do {
Write-Host "
Type 'back' to go to previous menu
0   Show users
1   Show wether users have a password or not
2   Show administrators
3   Show groups
4   Show non-default groups
"

$inputusers = Read-Host

if ($inputusers -eq "0") {
Write-Host "Gathering users"
Get-LocalUser
}
if ($inputusers -eq "1") {
Write-Host "Gathering information"
Get-WmiObject -Class Win32_UserAccount -Filter  "LocalAccount='True'" |
  Select PSComputername, Name, Status, Disabled, AccountType, Lockout, PasswordRequired, PasswordChangeable, SID
  }
if ($inputusers -eq "2") {
Write-Host "Gathering administrators"
Get-LocalGroupMember "Administrators"
}
if ($inputusers -eq "3") {
Write-Host "Gathering groups"
Get-LocalGroup
}
if ($inputusers -eq "4") {
Write-Host "Gathering non-default groups"
Get-LocalGroup | where {$_.name | select-string -notmatch Administrators,Guests,"Access Control Assistance Operators","Backup Operators","Cryptographic Operators","Device Owners","Distributed COM Users","Event Log Readers",IIS_IUSRS,"Network Configuration Operators","Performance Log Users","Performance Monitor Users","Power Users","remote Desktop Users","Remote Management Users",Replicator,"System Managed Accounts Group",Users}
}} until($inputusers -eq "back")}

if ($input -eq "2") {
do {
Write-Host "
Type 'back' to go to previous menu
0   Show local security policy
1   Show group policy
"

$inputpolicy = Read-Host

if ($inputpolicy -eq "0") {
Write-Host "Window opening"
secpol
}
if ($inputpolicy -eq "1") {
Write-Host "Window opening"
gpedit
}} until ($inputpolicy -eq "back")}



if ($input -eq "3") {
do {
Write-Host "searching for unauthorized files"
Get-Childitem –Path C:\users -Include *.aac,*.ac3,*.avi,*.aiff,*.bat,*.bmp,*.exe,*.flac,*.gif,*.jpeg,*.jpg,*.mov,*.m3u,*.m4p,
	*.mp2,*.mp3,*.mp4,*.mpeg4,*.midi,*.msi,*.ogg,*.png,*.txt,*.sh,*.wav,*.wma,*.vqf -Exclude *.com -File -Recurse -ErrorAction SilentlyContinue
	Write-host "Finished searching by extension"
	Write-host "Checking for $tools"
	Get-Childitem –Path C:\ -Include *Wireshark*, *NpCap*, *Cain*, *nmap*, *keylogger*, *Armitage*, *Wireshark*, *Metasploit*, *netcat*, *crack*, *hack* -File -Recurse -ErrorAction SilentlyContinue
	Write-host "Finished searching for tools"
} until ($input -eq "back")}
until ($input -eq "exit")}
until ($input -eq "exit")