; tp2real.asm
;
; MI01 - TP Assembleur 2
;
; Affiche un nombre de 32 bits sous forme lisible

.686
.MODEL	FLAT,C

EXTRN	getchar:NEAR
EXTRN	putchar:NEAR

.DATA
		nombre		dd	4321Ah		; nombre a convertir
		chaine		db	10 dup(?)	; chaine pour stocker le nombre
		base		dd	Ah			; base dans laquelle on converti
									; digit de la nouvelle base
		
.CODE

main	PROC

	PUSH EAX						; sauvegarde des registres
	PUSH EBX
	
	MOV EAX,[nombre]				; on stocke le nombre dans EAX
    LEA EBX,[chaine]				; et l'adresse de la chaine dans EBX
    MOV ECX,[base]					; on se sert de ECX pour les divisions par la base
    
boucle:
	XOR EDX,EDX						; EDX = 0
	DIV ECX							; EAX = EAX / ECX et EDX = EAX % ECX
	ADD EDX, '0'					; on recupere le nombre du caractere
	MOV [EBX],EDX					; on le place dans la chaine
	INC EBX							; on se deplace dans la chaine
	CMP EAX,0						; test si EAX = 0
	JNE boucle						; si oui, on sort de la boucle
	
	LEA ESI, [chaine]				; on recupere l'adresse de chaine
	DEC EBX							; on decremente EBX pour neutraliser le dernier INC EBX
	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	; Procedure d'affichage codee dans le TP4                        ;
	; Le fonctionnement est le meme mais la chaine est lue a l'envers;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
suivant:
	MOV EAX, [EBX]			; on parcours la chaine grace a l'adresse dans EBX	
	PUSH EAX				;
	CALL putchar			;
	ADD ESP, 4				;
	DEC EBX					; on prend le digit d'avant
	CMP ESI,EBX				; on compare l'adresse de EBX et celle de chaine
	JBE suivant				; si elle est superieur ou egale on affiche les digits restants
	
	call getchar
	
	POP EBX					; on restaure les parametres
	POP EAX					; 
	
	ret
main	ENDP

end
