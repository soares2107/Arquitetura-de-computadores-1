;Programa exibe string

segment .data ;declarar dados

mens db "Hello world!",10 ;declarar variavel
tam equ $-mens ;tamanho da mens

segment .text
global _start
_start:

mov eax,4 ;print/write
mov ebx,1 ;fd tela
mov ecx,mens ;ponteiro string
mov edx,tam ;quantidade caracteres
int 80h


mov eax,1 ;finalizar
int 80h ;syscall
