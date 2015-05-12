#! bin/bash
nasm -f aout kernel_start.asm -o ks.o
gcc -c kernel.c -o kernel.o
ld -T link.ld -o kernel.bin ks.o kernel.o