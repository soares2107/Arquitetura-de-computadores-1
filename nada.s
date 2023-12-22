;Programa nada faz

segment .data ;declarar dados

segment .text
global _start
_start:

mov eax,1 ;finalizar
int 80h ;syscall
