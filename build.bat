@echo off

if NOT exist obj (mkdir obj)

if NOT exist exe (mkdir exe)

wsl.exe -d Debian bash -i -c "nasm -f elf32 -o obj/prime.o prime.asm && ld -m elf_i386 -o exe/prime obj/prime.o && ./exe/prime"

echo:
pause