# ia32calculator
Calculadora básica em Assembly INTEL IA32

## Instalando montador NASM
  `sudo apt-get install nasm`
## Executando o programa
  Execute o seguinte comando para montar, ligar e executar o programa:
  
  `nasm -f elf -o calculator.o calculator.asm && ld -m elf_i386 -o calculator calculator.o && ./calculator`
