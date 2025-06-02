# Nirvana García
# Variables de configuración
$InterfaceAlias = "Ethernet"  # Cambia dependiendo del nombre de la interfaz.
$IPv4Address = "172.22.18.10"
$SubnetMask = "255.255.0.0"
$Gateway = "172.22.18.1"
$DNS = "172.22.18.1"

# Configurar la dirección IP y la máscara de subred
New-NetIPAddress -InterfaceAlias $InterfaceAlias -IPAddress $IPv4Address -PrefixLength 16 -DefaultGateway $Gateway

# Configurar el servidor DNS
Set-DnsClientServerAddress -InterfaceAlias $InterfaceAlias -ServerAddresses $DNS
