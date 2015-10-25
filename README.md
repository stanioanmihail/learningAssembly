learningAssembly

#math.asm:
nasm -f elf32 math.asm
gcc -lc -m32 math.o -o compute
./compute
