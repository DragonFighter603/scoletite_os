@echo off

cd asm
nasm boot.asm -f elf64 -o boot.o -l boot.hex
cd ..

ld.lld asm/boot.o target/scoletite_os.o --oformat binary -e init -o img.bin -T link.ld

qemu-system-x86_64 -drive format=raw,file=img.bin

rem cargo rustc -Z build-std=core --release -- --emit obj=target/scoletite_os.o --emit asm=target/scoletite_os.asm

rem cargo rustc -Z build-std=core -- --emit obj=target/scoletite_os_raw.o --emit asm=target/scoletite_os_raw.asm
rem objcopy target/scoletite_os_raw.o target/scoletite_os.o --prefix-alloc-sections='.rust'

rem ld.lld asm/boot.o target/scoletite_os.o -T link.ld --oformat binary -o img.bin

rem rem qemu-system-x86_64 -drive format=raw,file=img.bin
rem qemu-system-x86_64 -kernel img.bin