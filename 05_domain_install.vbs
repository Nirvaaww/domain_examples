' Nirvaww
Set objShell = CreateObject("WScript.Shell")

' 1. Instalar AD DS y herramientas de administración
objShell.Run "powershell -Command Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools", 0, True

' 2. Importar módulo y crear dominio
domainName = "pyme18.ga"
commandAD = "powershell -Command Import-Module ADDSDeployment; " & _
    "Install-ADDSForest -DomainName '" & domainName & "' " & _
    "-ForestMode 'Win2016' -DomainMode 'Win2016' " & _
    "-DatabasePath 'C:\Windows\NTDS' -LogPath 'C:\Windows\NTDS' " & _
    "-SysvolPath 'C:\Windows\SYSVOL' -InstallDns " & _
    "-SafeModeAdministratorPassword (ConvertTo-SecureString 'abc123.' -AsPlainText -Force) -Force"

objShell.Run commandAD, 1, True

' 3. Instalar el rol DNS
objShell.Run "powershell -Command Install-WindowsFeature -Name DNS -IncludeManagementTools", 0, True

' 4. Configurar DNS: zonas directa e inversa, reenviadores
reverseZoneFile = "172.in-addr.arpa.dns"
directZoneFile = domainName & ".dns"
dnsServerIP = "172.65.18.10"

dnsConfig = "powershell -Command " & _
    "Add-DnsServerPrimaryZone -Name '" & domainName & "' -ZoneFile '" & directZoneFile & "';" & _
    "Add-DnsServerPrimaryZone -NetworkID '172.65.0.0/16' -ZoneFile '" & reverseZoneFile & "';" & _
    "Add-DnsServerForwarder -IPAddress '" & dnsServerIP & "';" & _
    "Get-DnsServerZone"

objShell.Run dnsConfig, 1, True

MsgBox "Dominio y servidor DNS configurados correctamente.", vbInformation, "Nirvana García"
