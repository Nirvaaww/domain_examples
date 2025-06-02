' Nirvaww
Option Explicit

Dim objWMIService, colItems, objItem
Dim strComputer, archivoSalida
Dim objFSO, objFile

' Establece el archivo donde se guardará la información
archivoSalida = "C:\ruta\del\archivo\escenario_red.txt" ' Cambia esta ruta a la que desees

' Crear objeto FileSystemObject para escribir el archivo
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objFile = objFSO.CreateTextFile(archivoSalida, True)

' Escribir encabezado en el archivo
objFile.WriteLine("Escenario de Red - Detalles de las Computadoras en la Red")
objFile.WriteLine("Fecha: " & Now)
objFile.WriteLine("===================================")

' Consultar las máquinas conectadas mediante WMI
Set objWMIService = GetObject("winmgmts:\\.\root\cimv2")

' Obtener detalles de las máquinas (nombre, IP, etc.)
Set colItems = objWMIService.ExecQuery("SELECT * FROM Win32_ComputerSystem")

' Recorremos los elementos obtenidos
For Each objItem In colItems
    objFile.WriteLine("Nombre de la Computadora: " & objItem.Name)
    objFile.WriteLine("Fabricante: " & objItem.Manufacturer)
    objFile.WriteLine("Modelo: " & objItem.Model)

    ' Obtener dirección IP de la computadora
    Dim colIP, objIP
    Set colIP = objWMIService.ExecQuery("SELECT * FROM Win32_NetworkAdapterConfiguration WHERE IPEnabled = True")
    For Each objIP In colIP
        If Not IsEmpty(objIP.IPAddress) Then
            objFile.WriteLine("Dirección IP: " & objIP.IPAddress(0)) ' IP principal
        End If
    Next

    objFile.WriteLine("===================================")
Next

' También se puede agregar información de conexiones de red activas
objFile.WriteLine("Conexiones Activas:")
Dim objShell, objExec, strOutput
Set objShell = CreateObject("WScript.Shell")
Set objExec = objShell.Exec("netstat -an")

' Captura la salida del comando netstat
strOutput = objExec.StdOut.ReadAll

' Escribe la salida del comando netstat
objFile.WriteLine(strOutput)

' Cerrar el archivo
objFile.Close

WScript.Echo "El escenario de red ha sido guardado en: " & archivoSalida
