;Programa repeticao

segment .data ;declarar dados

mens1 db "Insira uma frase:",10  ;declarar variavel
tam1 equ $-mens1 ;tamanho da mensagem

mens2 db "A frase inserida foi:",10  ;declarar variavel
tam2 equ $-mens2 ;tamanho da mensagem 2



segment .bss ;dados nao inicializados

buf1 resb 100 ;reserva 100 espacos para buf1
qrec1 resd 1 ;bytes recebidos

buf2 resb 100 ;reserva 100 espacos para buf2
qrec2 resd 1 ;bytes recebidos



segment .text; linhas de codigos
global _start
_start:


;print mens1
mov eax,4 ;print
mov ebx,1 ;fd tela
mov ecx,mens1 ;ponteiro string
mov edx,tam1 ;quantidade caracteres
int 80h


;read buf1
mov eax,3 ;read
mov ebx,0 ;fd do teclado
mov ecx,buf1 ;destino(pont)
mov edx,100 ;quantidade maxima
int 80h
mov [qrec1],eax ;recebida >=1


mov esi,0 ;inicializar indice 


inicio:

mov al,[buf1+esi] ;caracter atual
mov [buf2+esi],al ;copiar
cmp al,10 ;compara com enter
je sair
inc esi; esi++
jmp inicio


sair:

;print mens2
mov eax,4 ;print
mov ebx,1 ;fd tela
mov ecx,mens2 ;ponteiro string
mov edx,tam2 ;quantidade caracteres
int 80h


;copiar a quebra de linha e depois o tamanho o tamanho de buf2
inc esi; esi++
mov [buf2+esi],byte 10 ;copiar queba de linha 
mov [qrec2],esi ;tamanho do buf2

;print buf2
mov eax,4 ;print
mov ebx,1 ;fd tela
mov ecx,buf2 ;ponteiro string
mov edx,[qrec2] ;quantidade caracteres
int 80h


mov eax,1 ;finalizar
int 80h ;syscall
