' Nirvaww
' UsersLocal18.vbs
Option Explicit

Dim objFSO, objFile, objWMIService, colUsers, objUser
Dim strComputer, outputPath

strComputer = "." ' Localhost
outputPath = "Ulocal.txt"

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objFile = objFSO.CreateTextFile(outputPath, True)

Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\cimv2")
Set colUsers = objWMIService.ExecQuery("Select * from Win32_UserAccount Where LocalAccount=True")

objFile.WriteLine "Usuarios locales en " & strComputer & ":"
For Each objUser In colUsers
    objFile.WriteLine "- " & objUser.Name
Next

objFile.Close
WScript.Echo "Archivo Ulocal.txt generado con los usuarios locales."
