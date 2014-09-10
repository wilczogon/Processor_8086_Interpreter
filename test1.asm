start:

mov ax, 0D625h
mov es, ax       ; wprowadź do rejestru segmentowego ES wartość z AX wynoszącą D625 szesnastkowo (54821 dziesiętnie)
mov al, 24
mov ah, 0        ; załaduj do rejestru AX wartość 24 (wyzeruj AH – starszą połówkę rejestru AX i zapisz wartość 24 w młodszej AL)
int 21h          ; wywołaj przerwanie nr 33 (21 szesnastkowo)

call dodawanie

call mnozenie

end start

dodawanie:

pusha
mov al, 5   ; al = 5
add al, -3  ; al = 2
popa

ret


mnozenie:

pusha
mov al, 200   ; al = 0C8h
mov bl, 4
mul bl        ; ax = 0320h (800)
popa

ret
