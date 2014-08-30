
start:
  mov ax, 0D625h
  mov es, ax       ; wprowadź do rejestru segmentowego ES wartość z AX wynoszącą D625 szesnastkowo (54821 dziesiętnie)
  mov al, 24
  mov ah, 0        ; załaduj do rejestru AX wartość 24 (wyzeruj AH – starszą połówkę rejestru AX i zapisz wartość 24 w młodszej AL)
  int 21h 
end start