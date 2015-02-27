###################################
# Setup                           #
###################################
export PREFIX="$HOME/opt/cross"
export TARGET=i686-elf
export PATH="$PREFIX/bin:$PATH"

###################################
# Build                          #
###################################
i686-elf-as boot.s -o boot.o
i686-elf-g++ -c kernel.cpp -o kernel.o -ffreestanding -O2 -Wall -Wextra -fno-exceptions -fno-rtti
i686-elf-gcc -T linker.ld -o myos.bin -ffreestanding -O2 -nostdlib boot.o kernel.o -lgcc

###################################
# GRUB                            #
###################################
touch grub.cfg
echo "menuentry \"HiveOS\" {" > grub.cfg
echo "multiboot /boot/hiveos.bin" > grub.cfg
echo "}" > grub.cfg
mkdir -p isodir
mkdir -p isodir/boot
cp hiveos.bin isodir/boot/hiveos.bin
mkdir -p isodir/boot/grub
cp grub.cfg isodir/boot/grub/grub.cfg
grub-mkrescue -o hiveos.iso isodir
