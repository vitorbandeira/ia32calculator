# ia32calculator
Calculadora básica em Assembly INTEL IA32

## Install NASM mounter
  `sudo apt-get install nasm`
## Runnnig the calculator program
  Run the following command for mount, link e execute de program:
  
  `nasm -f elf -o calculator.o calculator.asm && ld -m elf_i386 -o calculator calculator.o && ./calculator`
