; Trabalho feito por João Gabriel Soares P. da Silva

segment .data ;declaração dos dados

;nome dos arquivos 
nome1 db "PrimeiroARQ.txt",0
 
nome2 db "SegundoARQ.txt",0
 
mens1 db "Problema ao abrir o primeiro arquivo",10  ;declarar variavel
tam1 equ $-mens1 ;tamanho da mens
 
mens2 db "Arquivo Existente ",10  ;declarar variavel
tam2 equ $-mens2 ;tamanho da mens
 
mens3 db " Erro na criacao",10  ;declarar variavel
tam3 equ $-mens3 ;tamanho da mens
 
mens4 db "Erro ao criar o arquivo",10  ;declarar variavel
tam4 equ $-mens4 ;tamanho da mens
 
mens5 db "Cuncluido com sucesso",10  ;declarar variavel
tam5 equ $-mens5 ;tamanho da mens
 
 
 
 
segment .bss ;Dados nao inicializados
 
buf1 resb 100 ;reserva 100 espacos para buf1
qrec1 resd 1 ;bytes recebidos
 
fd1 resb 100
 
fd2 resb 100
 
 
 
segment .text; linhas de codigos
 
;funçoes
abrir:
mov eax,5
mov ecx,2
mov edx,0q777
int 80h
ret
 
ler:
mov eax,3
mov ebx,[fd1]
mov ecx,buf1
mov edx,27
int 80h
ret
 
criar:
mov eax,8
mov ecx,0q777
int 80h
ret
 
fechar:
mov eax,8
int 80h
ret
 
print:
mov eax,4
mov ebx,1
int 80h
ret
 
escrever:
mov eax,4 ; 
mov ebx,[fd2]
mov ecx,buf1
mov edx,[qrec1]
int 80h
ret
 
 
crip:
mov ah,157; valor para ser criptografado
sub ah,al;faz a subtracao para criptografar
mov [buf1+esi],ah ;copiar
ret
 
 
 
global _start
_start:
;main
 
;abrir PrimeiroArq
mov ebx,nome1
call abrir
 
 
;Deu certo ? conseguiu?
mov ebx,0
cmp eax,ebx
jl erro1
 
 
;salvar fd1
mov [fd1],eax
 
 
;abrir SegundoArquivo
mov ebx,nome2
call abrir
 
 
;consegui abrir o segundo arquivo?
mov ebx,0
cmp eax,ebx
jge erro2
 
 
;criar o novo arquivo
mov ebx,nome2
call criar
 
 
;consegui criar o novo arquivo?
mov ebx,0
cmp eax,ebx
jl erro3
 
 
;salvar fd1
mov [fd2],eax
 
cripitografia:
 
;ler
call ler
mov [qrec1],eax
 
;start contador
mov esi,0
 
;cripitografar
cripto:
mov al,[buf1+esi]
 
;verificar se esta no intervalo
cmp al,65
jb SemCrip
cmp al,157
ja SemCrip
call crip
 
;se estava:
SemCrip:
inc esi
cmp esi,[qrec1]
jb cripto
 
;escrever no segundo arquivo
call escrever
cmp esi,[qrec1]
je cripitografia
 
;fechar PrimeiroArquivo
mov ebx,[fd1]
call fechar
 
;fechar SegundoArquivo
mov ebx,[fd2]
call fechar
jmp fim
 
;Imprime a mensagem de sucesso
mov ecx, mens5
mov edx, tam5
call print

; Tratamento de erros 
erro1:
mov ecx,mens1 ;ponteiro string
mov edx,tam1 ;qdde caracteres
call print
jmp fim
 
erro2:
mov ecx,mens2 ;ponteiro string
mov edx,tam2 ;qdde caracteres
call print
jmp fim
 
erro3:
mov ecx,mens3 ;ponteiro string
mov edx,tam3 ;qdde caracteres
call print
jmp fim
 
; Fim do programa
fim:
mov eax,1 ;finalizar
int 80h ;syscall
