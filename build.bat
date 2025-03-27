@echo off

if NOT exist obj (mkdir obj)

if NOT exist exe (mkdir exe)

nasm -f win32 "primeNumber.asm" -o "obj/primeNumber.obj"

gcc "obj/primeNumber.obj" -o "exe/primeNumber.exe"
 
"exe/primeNumber"
echo:
pause