@echo off

if NOT exist obj (mkdir obj)

if NOT exist exe (mkdir exe)

wsl.exe -d Debian bash -i -c "nasm -f elf32 -o obj/primeNumber.o primeNumber.asm && ld -m elf_i386 -o exe/primeNumber obj/primeNumber.o && ./exe/primeNumber"

echo:
pause