' Nirvaww
Option Explicit

' Establecer ruta de salida para el archivo de auditoría
Dim archivoSalida
archivoSalida = "C:\ruta\del\archivo\auditoria_hardware.txt" ' Cambia la ruta según tus necesidades

' Crear el objeto FileSystemObject para escribir el archivo
Dim fso, archivo
Set fso = CreateObject("Scripting.FileSystemObject")
Set archivo = fso.CreateTextFile(archivoSalida, True)

' Escribir el encabezado en el archivo
archivo.WriteLine("Auditoría de Hardware del Servidor")
archivo.WriteLine("Fecha de ejecución: " & Now)
archivo.WriteLine("=====================================")

' Obtener información sobre la CPU
Dim objWMIService, colItems, objItem
Set objWMIService = GetObject("winmgmts:\\.\root\cimv2")
Set colItems = objWMIService.ExecQuery("SELECT * FROM Win32_Processor")

archivo.WriteLine("Procesador:")
For Each objItem In colItems
    archivo.WriteLine("  Nombre: " & objItem.Name)
    archivo.WriteLine("  Número de núcleos: " & objItem.NumberOfCores)
    archivo.WriteLine("  Número de hilos: " & objItem.NumberOfLogicalProcessors)
    archivo.WriteLine("  Velocidad: " & objItem.MaxClockSpeed & " MHz")
Next

archivo.WriteLine("=====================================")

' Obtener información sobre la memoria física
Set colItems = objWMIService.ExecQuery("SELECT * FROM Win32_PhysicalMemory")

archivo.WriteLine("Memoria Física:")
For Each objItem In colItems
    archivo.WriteLine("  Capacidad: " & objItem.Capacity / 1024 / 1024 / 1024 & " GB")
    archivo.WriteLine("  Fabricante: " & objItem.Manufacturer)
    archivo.WriteLine("  Velocidad: " & objItem.Speed & " MHz")
Next

archivo.WriteLine("=====================================")

' Obtener información sobre los discos duros
Set colItems = objWMIService.ExecQuery("SELECT * FROM Win32_DiskDrive")

archivo.WriteLine("Discos Duros:")
For Each objItem In colItems
    archivo.WriteLine("  Modelo: " & objItem.Model)
    archivo.WriteLine("  Capacidad: " & objItem.Size / 1024 / 1024 / 1024 & " GB")
    archivo.WriteLine("  Tipo de interfaz: " & objItem.MediaType)
Next

archivo.WriteLine("=====================================")

' Obtener información sobre los adaptadores de red
Set colItems = objWMIService.ExecQuery("SELECT * FROM Win32_NetworkAdapter")

archivo.WriteLine("Adaptadores de Red:")
For Each objItem In colItems
    archivo.WriteLine("  Nombre: " & objItem.Name)
    archivo.WriteLine("  Descripción: " & objItem.Description)
    archivo.WriteLine("  Estado: " & objItem.NetConnectionStatus)
Next

' Cerrar el archivo
archivo.Close

WScript.Echo "Auditoría de hardware completada. Los detalles se guardaron en: " & archivoSalida
