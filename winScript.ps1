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
0   List all services
1   Search unauthorized files
2   Show users
3   Show wether users have a password or not
4   Show administrators
5   Show groups
6   Show non-default groups
7   Open local security policy
8   Open local group policy
9   List running services
10   List stopped services
"

$input = Read-host

if ($input -eq "0") {
    Write-host "All services:"
    Get-Service

}

# search unauthorized files
elseif ($input -eq "1") {
	Get-Childitem –Path C:\users -Include *.aac,*.ac3,*.avi,*.aiff,*.bat,*.bmp,*.exe,*.flac,*.gif,*.jpeg,*.jpg,*.mov,*.m3u,*.m4p,
	*.mp2,*.mp3,*.mp4,*.mpeg4,*.midi,*.msi,*.ogg,*.png,*.txt,*.sh,*.wav,*.wma,*.vqf -Exclude *.com -File -Recurse -ErrorAction SilentlyContinue
	Write-host "Finished searching by extension"
	Write-host "Checking for $tools"
	Get-Childitem –Path C:\ -Include *Wireshark*, *NpCap*, *Cain*, *nmap*, *keylogger*, *Armitage*, *Wireshark*, *Metasploit*, *netcat*, *crack*, *hack* -File -Recurse -ErrorAction SilentlyContinue
	Write-host "Finished searching for tools"
}

# users and groups
elseif ($input -eq "2") {
    Write-host "Show users"
    get-localuser
    
}
elseif ($input -eq "3") {
Get-WmiObject -Class Win32_UserAccount -Filter  "LocalAccount='True'" |
  Select PSComputername, Name, Status, Disabled, AccountType, Lockout, PasswordRequired, PasswordChangeable, SID}
  elseif ($input -eq "4") {
  Get-LocalGroupMember -Group "Administrators"}
  elseif ($input -eq "5") {
  Get-LocalGroup -ErrorAction SilentlyContinue}
elseif ($input -eq "6") {
Get-LocalGroup | where {$_.name | select-string -notmatch Administrators,Guests,"Access Control Assistance Operators","Backup Operators","Cryptographic Operators","Device Owners","Distributed COM Users","Event Log Readers",IIS_IUSRS,"Network Configuration Operators","Performance Log Users","Performance Monitor Users","Power Users","remote Desktop Users","Remote Management Users",Replicator,"System Managed Accounts Group",Users}}
elseif ($input -eq "7") {
secpol}
elseif ($input -eq "8") {
gpedit}
elseif ($input -eq "9") {
Write-Host "Running services"
Get-Service | Where Status -EQ "Running" | Out-Default
}
elseif ($input -eq "10") {
Write-Host "Stopped services"
Get-Service | Where Status -EQ "Stopped" | Out-Default
}
} until ($input -eq "exit")


