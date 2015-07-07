#!/bin/bash
echo "Building..."
nasm -f aout start.asm -o start.o
gcc -O -fstrength-reduce -fomit-frame-pointer -finline-functions -nostdinc -fno-builtin -I ./include -c -o main.o main.c
gcc -O -fstrength-reduce -fomit-frame-pointer -finline-functions -nostdinc -fno-builtin -I ./include -c -o scrn.o scrn.c
gcc -O -fstrength-reduce -fomit-frame-pointer -finline-functions -nostdinc -fno-builtin -I ./include -c -o gdt.o gdt.c
gcc -O -fstrength-reduce -fomit-frame-pointer -finline-functions -nostdinc -fno-builtin -I ./include -c -o idt.o idt.c
gcc -O -fstrength-reduce -fomit-frame-pointer -finline-functions -nostdinc -fno-builtin -I ./include -c -o isrs.o isrs.c
gcc -O -fstrength-reduce -fomit-frame-pointer -finline-functions -nostdinc -fno-builtin -I ./include -c -o irq.o irq.c
gcc -O -fstrength-reduce -fomit-frame-pointer -finline-functions -nostdinc -fno-builtin -I ./include -c -o timer.o timer.c
gcc -O -fstrength-reduce -fomit-frame-pointer -finline-functions -nostdinc -fno-builtin -I ./include -c -o kb.o kb.c
echo "Linking..."
ld -T link.ld -o kernel.bin start.o main.o scrn.o gdt.o idt.o isrs.o irq.o timer.o kb.o
echo "Moving..."
mkdir ./bin
cp ./kernel.bin ./bin/kernel.bin
echo "Cleaning up..."
rm *.bin
rm *.o
echo "Preparing boot medium..."
cd ./bin
genisoimage -R -b boot/grub/stage2_eltorito -no-emul-boot -boot-load-size 4 -boot-info-table -o hive.iso isofiles -V "HIVEOS installer"
