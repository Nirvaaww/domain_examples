# Nirvaww
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

# Importar el módulo de AD DS
Import-Module ADDSDeployment

# Configurar un nuevo dominio
Install-ADDSForest `
    -DomainName "dominio18.ga" `
    -ForestMode "Win2012R2" `
    -DomainMode "Win2012R2" `
    -DatabasePath "C:\Windows\NTDS" `
    -LogPath "C:\Windows\NTDS" `
    -SysvolPath "C:\Windows\SYSVOL" `
    -InstallDns `
    -SafeModeAdministratorPassword (ConvertTo-SecureString "abc123." -AsPlainText -Force) `
    -Force

Write-Host "El dominio dominio18.ga se ha creado con éxito." -ForegroundColor Green