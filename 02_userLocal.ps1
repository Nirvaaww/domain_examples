# Nirvaww
# Nombre de los usuarios a crear
$users = @("peter", "rai", "noe")
$groupName = "Usuarios locales"

# Verificar si el grupo existe, si no, crearlo
if (-Not (Get-LocalGroup -Name $groupName -ErrorAction SilentlyContinue)) {
    New-LocalGroup -Name $groupName -Description "Grupo de usuarios locales"
}

# Crear usuarios y agregar al grupo
foreach ($user in $users) {
    # Verificar si el usuario ya existe
    if (-Not (Get-LocalUser -Name $user -ErrorAction SilentlyContinue)) {
        # Crear el usuario
        New-LocalUser -Name $user -Password (ConvertTo-SecureString "ContraseñaSegura123" -AsPlainText -Force) -FullName $user -Description "Usuario creado por script"
        
        # Agregar el usuario al grupo
        Add-LocalGroupMember -Group $groupName -Member $user
    }
}

# Confirmar la creación de los usuarios
Get-LocalUser | Where-Object { $_.Name -in $users }