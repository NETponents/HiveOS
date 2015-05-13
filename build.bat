echo Setting up dependencies
set PATH=C:\Users\Joshua\Documents\GitHub\HiveOS\tools\DJGPP\bin;%PATH%
set PATH=C:\Users\Joshua\Documents\GitHub\HiveOS\tools\NASM;%PATH%
set DJGPP=C:\Users\Joshua\Documents\GitHub\HiveOS\tools\DJGPP\djgpp.env
set COMPILER_PATH=C:\Users\Joshua\Documents\GitHub\HiveOS\tools\DJGPP\bin
echo Now assembling, compiling, and linking your kernel:
nasm -f aout -o start.o start.asm
echo Building OS

gcc -Wall -O -fstrength-reduce -fomit-frame-pointer -finline-functions -nostdinc -fno-builtin -I include -c -o main.o main.c

gcc -Wall -O -fstrength-reduce -fomit-frame-pointer -finline-functions -nostdinc -fno-builtin -I include -c -o scrn.o scrn.c

gcc -Wall -O -fstrength-reduce -fomit-frame-pointer -finline-functions -nostdinc -fno-builtin -I include -c -o gdt.o gdt.c

gcc -Wall -O -fstrength-reduce -fomit-frame-pointer -finline-functions -nostdinc -fno-builtin -I include -c -o idt.o idt.c

gcc -Wall -O -fstrength-reduce -fomit-frame-pointer -finline-functions -nostdinc -fno-builtin -I include -c -o isrs.o isrs.c

gcc -Wall -O -fstrength-reduce -fomit-frame-pointer -finline-functions -nostdinc -fno-builtin -I include -c -o irq.o irq.c

gcc -Wall -O -fstrength-reduce -fomit-frame-pointer -finline-functions -nostdinc -fno-builtin -I include -c -o timer.o timer.c

gcc -Wall -O -fstrength-reduce -fomit-frame-pointer -finline-functions -nostdinc -fno-builtin -I include -c -o kb.o kb.c

echo Linking files
ld -T link.ld -o kernel.bin start.o main.o scrn.o gdt.o idt.o isrs.o irq.o timer.o kb.o
echo Moving finished files
xcopy kernel.bin bin\kernel.bin /E /I
echo Cleaning up object files...
del *.o
del kernel.bin
echo Done!
pause