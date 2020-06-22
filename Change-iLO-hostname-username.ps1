# ------------------ Parameters
Param (                    
        [string]$hostName                  = "", 
        [string]$userName                  = "", 
        [string]$password                  = "",
        [string]$authLoginDomain           = "local"
      )


$CR             = "`n"
$COMMA          = ","

# ################################################
# Attributes to be modified

$server         = 'F3-Bay21986'
$loginName      = 'login_admin'
$newloginName   = 'administrator'
$dnsName        = 'cicccu001'
$domainName     = 'host.local'

# ###############################################



### Connect to OneView
$securePassword = $password | ConvertTo-SecureString -AsPlainText -Force
$cred           = New-Object System.Management.Automation.PSCredential  -ArgumentList $userName, $securePassword


write-host -ForegroundColor Cyan "---- Connecting to OneView --> $hostName"
$OVconnection   = Connect-HPOVMgmt -Hostname $hostName -loginAcknowledge:$true -AuthLoginDomain $authLoginDomain -Credential $cred

$s              = Get-HPOVServer -Name $server -ApplianceConnection $OVconnection
$iloIP          = $s.mpHostInfo.mpIpAddresses[0].address
$iloSession     = $s | Get-HPOVIloSso -ApplianceConnection  $OVconnection -IloRestSession
$authToken      = $iloSession.'X-Auth-Token'

#### Connect to iLO
# Using AuthToken works ONLY for iLO5

$iLOonnection  = Connect-HPEiLO -Address $iloIP -XAuthToken $authToken -DisableCertificateAuthentication


## 1. Change host name and domain Name
## Domain name changed is only possible if DHCP is NOT used
Set-HPEiLOIPv4NetworkSetting -Connection $iLOconnection -DomainName $domainName -DNSName $dnsName -InterfaceType Dedicated


## 2. Change login name 
set-HPEiLOUser -Connection $iLOconnection -LoginName $loginName -newloginame $newloginame










Disconnect-HPOVMgmt