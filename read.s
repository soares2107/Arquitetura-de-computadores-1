;Programa recebe string

segment .data ;declarar dados

mens db "Insira uma frase:",10  ;declarar variavel
tam equ $-mens ;tamanho da mensagem

mens2 db "A mensagem inserida foi:",10
tam2 equ $-mens2 ;tamanho da mensagem 2



segment .bss ;dados nao inicializados

buff resb 100 ;reserva 100 espacos para buff
qrec resd 1 ;bytes recebidos


segment .text; linhas de codigos
global _start
_start:


;print mens
mov eax,4 ;print
mov ebx,1 ;fd tela
mov ecx,mens ;ponteiro string
mov edx,tam ;quantidade caracteres
int 80h


;read
mov eax,3 ;read
mov ebx,0 ;fd do teclado
mov ecx,buff ;destino(pont)
mov edx,100 ;quantidade maxima
int 80h
mov [qrec],eax ;recebida >=1


;print mens2
mov eax,4 ;print
mov ebx,1 ;fd tela
mov ecx,mens2 ;ponteiro string
mov edx,tam2 ;quantidade caracteres
int 80h


;print buff
mov eax,4 ;print
mov ebx,1 ;fd tela
mov ecx,buff ;ponteiro string
mov edx,[qrec] ;qdde caracteres
int 80h


mov eax,1 ;finalizar
int 80h ;syscall
