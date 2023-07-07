$inactive = Read-Host -Prompt "Enter Days Inactive: "
$time = (Get-Date).AddDays(-($Inactive))

$users = Get-ADUser -Filter {LastLogonTimeStamp -lt $time} -Properties Name, LastLogonDate, UserPrincipleName | Select Name, LastLogonDate, UserPrincipleName

if ($users -eq $null)
{
  Write-Host "`nNo Inactive Users."
}
else 
{
  Write-Host "`nUsers Inactive for $Inactive Days: "
  $users | Format-Table -GroupBy BasePriority
}

$comps = Get-ADComputer -Filter {LastLogonTimeStamp -lt $time} -Properties Name, LastLogonDate, UserPrincipleName | Select Name, LastLogonDate, UserPrincipleName

if ($comps -eq $null)
{
  Write-Host "`nNo Inactive Computers."
}
else 
{
  Write-Host "`nComputers Inactive for $Inactive Days: "
  $comps
}
