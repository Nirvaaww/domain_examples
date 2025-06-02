# Nirvaww
# Instalación del rol DNS
Install-WindowsFeature -Name DNS -IncludeManagementTools

# Configuración de variables
$domainName = "dominio18.ga"
$reverseZoneId = "172.in-addr.arpa"
$dnsServerIP = "172.22.18.10"

# Crear zona de búsqueda directa
Add-DnsServerPrimaryZone -Name $domainName -ZoneFile "$domainName.dns"

# Crear zona de búsqueda inversa
Add-DnsServerPrimaryZone -NetworkID "172.22.0.0/24" -ZoneFile "$reverseZoneId.dns"

# Configurar reenviadores
Add-DnsServerForwarder -IPAddress $dnsServerIP

# Confirmar que las zonas se han creado correctamente
Get-DnsServerZone
