[org 0x0100]
jmp start
signal: dw 0
blue: dw 0
orig_int8: dd 0
int8hooked: dw 0
tick_counter: dd 0
orig_int9_offset: dw 0
orig_int9_segment: dw 0
entername: dw 'Enter Your name:'
developedBy: dw 'Developed By '
r1: dw 'Aina Aroob 22L-8221'
r2: dw 'Hafsa Feroze 22L-6636'
name:       db 80
            db 0
            times 80 db 0
enddd:      dw 0
welcome: db 'Welcome '
instructions:db 'To move bunny, press up key'
pointsInfo: db 'Collect the fruitto get 10 points'
bluepoint: db 'Jump before blue brick breaks'
enterr:db 'Press Enter to Continue and Esc to exit'
pressExit: db 'press esc again to exit'
pressUp: db 'press up key to resume'
quit: dw ' Are you sure you want to quit? '
yes:dw ' YES (y) '
no:dw ' NO (n) '
textover: db 'GAME OVER !!!!'
try:  db 'Start the program to play again'

overr: dw 0


printy:pusha

mov ax,0x0cb7
mov cx,60
mov dx,20
y1:int 0x10
inc dx
inc cx
cmp dx,40
jne y1

inc cx
dec dx
y2: int 0x10
inc cx
dec dx
cmp dx,20
jne y2

mov cx, 80
mov dx, 40
y3:int 0x10
inc dx
cmp dx,80
jne y3

popa
ret

printi:
pusha

mov ax,0x0cb7
mov cx,110
mov dx,55

i1:int 0x10
inc dx
cmp dx,78
jne i1

mov dx,45
mov cx,110
i2:int 0x10
inc cx
cmp cx,112
jne i2

popa
ret

printp:
pusha

mov ax,0x0cb7
mov dx,55
mov cx,132

inc dx
p1:int 0x10
inc dx
cmp dx,90
jne p1

mov dx,67

inc dx
inc cx
p2:int 0x10
add cx,2
inc dx
cmp dx, 73
jne p2

int 0x10

dec dx
add cx,2

p3:int 0x10
dec dx
add cx,2
cmp dx, 67
jne p3

dec cx
dec dx
p4:int 0x10
dec dx
cmp dx,55
jne p4

sub cx,1
dec dx
p5:int 0x10
sub cx,2
dec dx
cmp dx,48
jne p5

;dec cx
;dec dx
add cx, 3
add dx, 1
p6:int 0x10
sub cx,2
inc dx
cmp dx,55
jne p6

int 0x10

popa
ret

printp2:
pusha

mov ax,0x0cb7
mov dx,55
mov cx,170

inc dx
p21:int 0x10
inc dx
cmp dx,90
jne p21

mov dx,67

inc dx
inc cx
p22:int 0x10
add cx,2
inc dx
cmp dx, 73
jne p22

int 0x10

dec dx
add cx,2

p23:int 0x10
dec dx
add cx,2
cmp dx, 67
jne p23

dec cx
dec dx
p24:int 0x10
dec dx
cmp dx,55
jne p24

sub cx,1
dec dx
p25:int 0x10
sub cx,2
dec dx
cmp dx,48
jne p25

;dec cx
;dec dx
add cx, 3
add dx, 1
p26:int 0x10
sub cx,2
inc dx
cmp dx,55
jne p26

int 0x10

popa
ret


printi2:
pusha

mov ax,0x0cb7
mov cx,212
mov dx,55

i21:int 0x10
inc dx
cmp dx,78
jne i21

mov dx,45
mov cx,212
i22:int 0x10
inc cx
cmp cx,214
jne i22

popa
ret


printe1:
pusha
mov ax,0x0cb7

mov cx,230
mov dx,55

e1:int 0x10
inc dx
cmp dx,78
jne e1

e2:int 0x10
inc cx
cmp cx,247
jne e2

mov dx,55
dec dx
mov cx,230
inc cx
e3:int 0x10
inc cx
cmp cx,247
jne e3

inc dx
e4:int 0x10
inc dx
cmp dx,67
jne e4

dec cx
e5:int 0x10
dec cx
cmp cx,229
jne e5

popa
ret


start:
mov ax,0x000d
int 0x10
mov ax,0x0cf6   ;backgound color of intro screen
;xor bx,bx
mov cx,320     ;number of columns
mov dx,0
l22:int 0x10
loop l22
mov cx,320
inc dx
cmp dx,200    ;rows
jne l22

call printy
; call printo1
; call printo2

; call prints
call printi
call printp
call printp2
call printi2
call printe1
; call printe2
; call printfishi

mov ax,0xb800
mov es,ax

; for showing enter name
mov ah,0x13
mov al,1
mov bh,0
mov bl,0xb6           ;prev bd

mov cx,13
mov dx,0x0c00

push ds
pop es
mov bp,developedBy
int 0x10

mov cx,19
mov dx,0x0e00

push ds
pop es
mov bp,r1
int 0x10

mov cx,21
mov dx,0x1000

push ds
pop es
mov bp,r2
int 0x10

mov bl, 0xb7
mov cx,27
mov dx,0x1400

push ds
pop es
mov bp,instructions
int 0x10

mov cx,27
mov dx,0x1500

push ds
pop es
mov bp,pointsInfo
int 0x10

mov cx,29
mov dx,0x1600

push ds
pop es
mov bp,bluepoint
int 0x10

mov bl, 0xb6
mov cx,16
mov dx,0x1800

push ds
pop es
mov bp,entername
int 0x10

mov dx,name                        
mov ah, 0x0A                            
int 0x21
mov ax, 0x0003 ; 80x25 text mode
int 0x10 ; bios video services
call clrscr
mov ax,0xb800
mov es,ax



jmp main

kbisr:
    push ax
    push es
    mov ax, 0xb800
    mov es, ax
    in al, 0x60

    cmp al, 0x48
    jne nextmatch
    mov word[signal], 1
    jmp nomatch
nextmatch:
    cmp al, 0x01    ;or 0x76
    jne nomatch
    cmp word[enddd], 1
    je over2
    call saveScreen
ask:
            call confirm
ii:
; mov ah,0
            ; int 0x16
            ; cmp ah,0x48
            ; je goRestore
            ; cmp al,0x01
            ; je over
            ; jmp ii
            cmp word[enddd], 1
            je over2
            cmp word[gameOver], 1
            je over2
            in al, 0x60
            cmp al, 0x01
            je over2

            cmp al,0x48
            je goRestore

            jmp ii
           
over2:
mov word[gameOver], 1
mov al, 0x20
    out 0x20, al
    pop es
    pop ax
iret

goRestore:
mov word[enddd], 0
    call restoreScreen
    nomatch:
    mov al, 0x20
    out 0x20, al
    pop es
    pop ax
iret


my_isr:
    pusha
    inc dword [tick_counter]
   ; jmp far [orig_int8]

    popa
    iret


confirm:

pusha
push es
push di
push bp
push ds
mov ax,0x000d
    int 0x10
    mov ax,0x0c16   ;backgound color of intro screen
    mov cx,320     ;number of columns
    mov dx,0
line23:
    int 0x10
    loop line23
    mov cx,320
    inc dx
    cmp dx,200    ;rows
    jne line23
   
   
    mov ax,0xb800
    mov es,ax

;for showing enter name
    mov ah, 0x13    ; Function to write text with attributes
    mov al, 1       ; Number of characters to write
    mov bh, 0       ; Display page
    mov bl, 0xb7    ; Display attribute (text color and background)

    mov cx, 24     ; Text length
    mov dx, 0x0b00  ; Display position (row and column)

;Display "textover" string at the specified position
push ds
pop es
mov bp, pressExit
int 0x10
    mov cx, 22     ; Text length
    mov dx, 0x0d00  ; Display position (row and column)

;Display "developedBy" string at the specified position
push ds
pop es
mov bp, pressUp
int 0x10
pop ds
pop bp
pop di
pop es
popa
ret


saveScreen:
    push ax
    push cx
    push es
    push ds
    push di
    push si
   
   
    ;destination
    mov ax,buffer3
    mov es,ax
    mov di,0
   
    ;source
    mov ax,0xb800
    mov ds,ax
    mov si,0
   
    mov cx,5676
    cld
    rep movsw

   
    pop si
    pop di
    pop ds
    pop es
    pop cx
    pop ax
    ret
   
restoreScreen:
    push ax
    push cx
    push es
    push ds
    push si
    push di
      mov AH,0x00
      mov al, 0x54
      int 0x10
   
    ;source
    mov ax,buffer3
    mov ds,ax
    mov si,0
   
    ;destination
    mov ax,0xb800
    mov es,ax
    mov di,0
   
   
    mov cx,5676
   
    cld
    rep movsw
   
    pop di
    pop si
    pop ds
    pop es
    pop cx
    pop ax
    ret
;--------------------------------------------------------------------
;subroutine for moving car towards right
;--------------------------------------------------------------------

rotationn:
    pusha
    push es
    push ds
    push si
    push di

    mov ax,0xb800
    mov es,ax
    mov ds,ax

    mov si,4220      
    mov di,4222           ;starting from the last index of the row
    mov dx,si           ;saving it to put into the first index
    std             ;auto decrement mode

    mov bx,9            ;ships on 8 lines
forr:
    mov ax,[es:di]        ;saving last index
    mov cx,131
    rep movsw
    mov word[es:di],ax      ;restoring last index in first index
    mov si,dx
    add si,264          ;pointing to next line
    mov di,dx
    add di,266
    mov dx,si
    dec bx
    jnz forr

;call delayBunny


pop di
pop si
pop ds
pop es
popa
ret







;--------------------------------------------------------------------
;subroutine for moving building towards left
;--------------------------------------------------------------------

rotation:
pusha
push es
push ds
push si
push di

mov ax,0xb800
mov es,ax
mov ds,ax

mov si,1586
mov di,1584
mov bx,9            ;first 9 rows of sky
cld             ;auto increment mode

for:
  mov cx,131        
  lodsw           ;saving the first word of the row        
  sub si,2          ;pointing si back
  rep movsw         ;repeating cx times
  mov word[es:di],ax        ;placing the first word to the last word of the row
  add si,2
  add di,2
  dec bx
  jnz for

;call delayBunny

pop di
pop si
pop ds
pop es
popa
ret

; ::::::::::::::::::  subroutine to clear the screen  ::::::::::::::::::::::::::::::


clrscr:   push es
      push ax
      push di

      mov ax, 0xb800
      mov es, ax          ; point es to video base
      mov di, 0         ; point di to top left column

nextloc:  mov word [es:di], 0x0720      ; clear next char on screen
      add di, 2         ; move to next screen location
      cmp di, 4000        ; has the whole screen cleared
      jne nextloc         ; if no clear next position
     
      pop di
      pop ax
      pop es
      ret

     
; ::::::::::::::::::  subroutine to print the stars ::::::::::::::::::::::::::::::
stars:    push es
      push ax
      push di

      mov ax, 0xb800
      mov es, ax          ; point es to video base
      mov di, 0       ; point di to top left column

nextloc1:  
            mov word [es:di], 0x8E2a      ; clear next char on screen
           
      add di, 150     ; move to next screen location
      cmp di, 1650        ; has the whole screen cleared
      ;call delay
      jne nextloc1        ; if no clear next position
     
      pop di
      pop ax
      pop es
      ret
     
;::::::::::::::::::  subroutine to draw the road ::::::::::::::::::::::::::::::
road:     push es
      push ax
      push di

      mov ax, 0xb800
      mov es, ax          ; point es to video base
      mov di, 3960          ; point di to top left column  ;132* 2*15 ;;15th row

nextloc2:  
            mov word [es:di], 0x7720      ; print grey space on screen ;
     
      add di, 2         ; move to next screen location
      cmp di, 7920        ; 132*2*30 ;;30th row
      jne nextloc2        ; if no clear next position
     
roadmid:    
            mov ax, 0xb800
      mov es, ax          ; point es to video base
      mov di, 4752          ; 132*2*18 ;; 18th row
 
nextloc3:  
            mov word [es:di], 0x0020      ; clear black char on screen
           
      add di, 2         ; move to next screen location
      cmp di, 7128        ; has the whole screen cleared
      jne nextloc3        ; if no clear next position
     
roadmidlines:  
            mov ax, 0xb800
      mov es, ax          ; point es to video base
      mov di, 5544          ; 132*2*21
 
nextloc4:  
            mov word [es:di], 0x0f2d      
           
      add di, 2         ; move to next screen location
      cmp di, 6336        ; 132*2*24
      jne nextloc4        ; if no clear next position
   
      pop di
      pop ax
      pop es
      ret
     
;;;;;;;;;;;;;;;;;;;;;;;;;;  C A R   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
carlayer1:  push es
      push ax
      push di
            push dx
      mov ax, 0xb800
      mov es, ax          ; point es to video base
      mov di, 4678          ;17th row
      mov dx, di
      add dx, 40
      mov cx, 0
nextloc5:  
            mov word [es:di], 0x4020      ; red part next char on screen
           
      add di, 2       ; move to next screen location
      cmp di, dx        ; has the whole screen cleared
      ;call delay
      jne nextloc5      ; if no clear next position
      add cx, 1
      cmp cx, 3                 ; first layer in 3 rows
      je carlayer2
      add dx, 264      ;.................
      mov di, dx
      sub di, 40

      jmp nextloc5
     
     
carlayer2:  mov di, 5464
      mov dx, di
      add dx, 50
      mov cx, 0         ; count rows

nextloc6:  
            mov word [es:di], 0x4020      ; clear next char on screen
           
      add di, 2       ; move to next screen location
      cmp di, dx        ; has the whole screen cleared
      ;call delay
      jne nextloc6      ; if no clear next position
      inc cx
      cmp cx, 2
      je carwheel1
      add dx, 264
      mov di, dx
      sub di, 50
      jmp nextloc6
       
     
carwheel1:  mov ax, 0xb800
      mov es, ax              ; point es to video base
            mov di, 5734
      mov dx, di
      add dx, 8
      mov cx, 0     ; point di to top left column

nextloc7:  
            mov word [es:di], 0x7720      ; clear next char on screen
           
      add di, 2       ; move to next screen location
      cmp di, dx        ; has the whole screen cleared
      ;call delay
      jne nextloc7      ; if no clear next position
      add cx, 1
      cmp cx, 3
      je centrewheel1
      add dx, 264
      mov di, dx
      sub di, 8
      jmp nextloc7      ; if no clear next position
     
centrewheel1:
      mov di, 6000
     
printcentre1:
      mov word [es:di], 0x0020      ; clear next char on screen
           
      add di, 2
      cmp di, 6004
      jne printcentre1
       
       
       
       
       
       
carwheel2:  mov ax, 0xb800
      mov es, ax              ; point es to video base
            mov di, 5764
      mov dx, di
      add dx, 8
      mov cx, 0     ; point di to top left column

nextloc8:  
            mov word [es:di], 0x7720      ; clear next char on screen
           
      add di, 2       ; move to next screen location
      cmp di, dx        ; has the whole screen cleared
      ;call delay
      jne nextloc8      ; if no clear next position
      add cx, 1
      cmp cx, 3
      je centrewheel2
      add di, 264
      sub di, 8
      mov dx, di
      add dx, 8
      jmp nextloc8      ; if no clear next position
     
centrewheel2:
      mov di, 6030
     
      mov dx, di
      add dx, 4
printcentre2:
      mov word [es:di], 0x0020      ; clear next char on screen
           
      add di, 2
      cmp di, dx
      jne printcentre2
     
      pop di
      pop ax
      pop es
      pop dx
      ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  B U I L D I N G  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

     
thinbuilding: push es
        push ax
        push di
        mov si, -2  ;;--------------------------------------------------------
        iterate1:   add si, 2                    
        cmp si, 16
        ;jne nextloc9
        je end
        mov ax, 0xb800
        mov es, ax        ; point es to video base
        mov ax, 132     ; load al with columns per row
        mul word [buildingI+si]   ; 80 x r
        add ax, [buildingJ+si]      ; word number (80xr) + c
        shl ax, 1  ;------------------------starting point found
       
        mov di, ax        ;4th row & 7th col;;264*4+14
        mov ax, [colour+si]
        mov dx, di
        add dx, [thickness+si]
        mov cx, 0
        mov bx, 15
        sub bx, [buildingI+si]   ;;;-----------------storing height of building
       
       
nextloc9:  
            mov word [es:di], ax      ; clear next char on screen
           
      add di, 2       ; move to next screen location
      cmp di, dx        ; has the whole screen cleared
      ;call delay
      jne nextloc9      ; if no clear next position
      add cx, 1
      cmp cx, bx              ;
      je iterate1             ;if equal then builing is complete
      add di, 264
      sub di, [thickness+si]
      mov dx, di
      add dx, [thickness+si]
      jmp nextloc9    
     
     
      end:pop di
      pop ax
      pop es
      ret
     
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;   G R A S S  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

     
grass:    
           push ax
       push es
       push di
       
            mov ax, 0xb800
      mov es, ax          ; point es to video base
      mov di, 7920          ; 132*2*18 ;; 18th row
 
nextloc12:  
            mov word [es:di], 0x2020      ; clear next char on screen
           
      add di, 2         ; move to next screen location
      cmp di, 11352       ; has the whole screen cleared
      jne nextloc12
      je end    
     
      ; end:pop di
      ; pop ax
      ; pop es
      ; ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    
delayjump:
      xor cx,cx
      xor dx,dx
      mov cx,500
      next:
      mov dx,80
      next2:
      dec dx
      jnz next2
      loop next
      ret
     
delayBunny:
      xor cx,cx
      xor dx,dx
      mov cx,1300
      next3:
      mov dx,80
      next4:
      dec dx
      jnz next4
      loop next3
      ret  

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;   RABBIT  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


Rabbit:
            push ax
      push es
      push ds
      push si
      push di
     
      mov  ax, 0xb800
      mov  es, ax
      mov ax, 132    
      mul word [bunnyY]  
      add ax, [bunnyX]      
      shl ax, 1  
     
      mov di, ax
      mov  si, di
      mov  al, '('
      mov  ah,  0x20
     
     
      mov  word[es:di], ax
      add  di , 2
      mov  al, '\'
      mov  word[es:di], ax
      add  di, 2
      mov  al, '_'
      mov  word[es:di], ax
      add  di , 2
      mov  al, '/'
      mov  word[es:di], ax
      add  di , 2
      mov  al, ')'
      mov  word[es:di], ax
     
secondline:
         
            add  si, 264
            mov  di, si
      sub  di, 2
      mov  al, '('
      mov  word[es:di], ax
      add  di , 2
      mov  al, '='
      mov  word[es:di], ax
      add  di , 2
      mov  al, '^'
      mov  word[es:di], ax
      add  di , 2
      mov  al, 'o'
      mov  word[es:di], ax
         
      add  di , 2
      mov  al, '^'
      mov  word[es:di], ax
      add  di , 2
      mov  al, '='
      mov  word[es:di], ax
      add  di , 2
      mov  al, ')'
      mov  word[es:di], ax
     
     
thirdLine :  
            add  si, 264
            mov  di, si
      sub  di, 2
      mov  al, '('
        mov  word[es:di], ax
      add  di , 2
      mov  al, '*'
        mov  word[es:di], ax
      add  di , 2
      mov  al, ')'  
        mov  word[es:di], ax
      add  di , 2
      mov  al, '_'
        mov  word[es:di], ax
      add  di , 2
      mov  al, '('
       mov  word[es:di], ax
      add  di , 2
      mov  al, '*'
      mov  word[es:di], ax
      add  di , 2
      mov  al, ')'
      mov  word[es:di], ax
     
      pop ax
      pop es
      pop ds
      pop si
      pop di
      ret
     
;::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
;                 C L E A R   B U N N Y
;::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

ClrRabbit:
            push ax
      push es
      push ds
      push si
      push di
     
     
 

      mov ax, 0xb800
      mov es, ax          ; point es to video base
      mov ax, 132    
      mul word [bunnyY] ;bunny ear row  
      add ax, [bunnyX]      
      shl ax, 1  
     
      mov di, ax
      sub di, 2
      mov si, di
      add si, 14
      mov cx, 3

nextloc19:  mov word [es:di], 0x2020      ; clear next char on screen
      add di, 2         ; move to next screen location
      cmp di, si        ; has the whole screen cleared
      jne nextloc19         ; if no clear next position
      add si, 264
      mov di, si
      sub di, 14
      sub cx, 1
      jnz nextloc19
     
      pop ax
      pop es
      pop ds
      pop si
      pop di
      ret
     
     
     
     
;::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
;                           B A R
;::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

bar:
            push ax
      push es
      push ds
      push si
      push di
     
      mov  ax, 0xb800
      mov  es, ax
      mov  di, 10398                        ;(132*38  + 60)*2
      mov  si, di
      mov  al, 'x'
      mov  ah,  0x68
     
     
nextloc13:  mov  word[es:di], ax
      add  di , 2
      cmp di,10442
      jne nextloc13
     
      pop ax
      pop es
      pop ds
      pop si
      pop di
      ret
     
;::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
; B A R  F R O M  C O O R D I N A T E
;::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
barNew:
            push ax
      push es
      push ds
      push si
      push di
     
      mov  ax, 0xb800
      mov  es, ax
      mov  di, 10296         ;neeche wali              ;(132*38  + 60)*2
      mov  si, di
      mov  al, 'x'
      mov  ah,  0x68     ; 0x68=orange
loop1:
cmp word[es:di], 0x6878      ;if orange down,make red above
je wholebarorange
cmp word[es:di], 0x4078      ;if red down, make blue above
je wholebarRed
cmp word[es:di], 0x1878      ;if blue down, make orange above
je wholebarBlue
add di, 2
jmp loop1
     
     
wholebarorange:
mov si, di
add si, 44
mov ax, 0x6878
nextloc15:
      mov  word[es:di], ax
      add  di , 2
      cmp di,si
      jne nextloc15
     
      mov ax, 0x4078
      mov di, 8814       ;bar1
nextloc16:
      mov  word[es:di], ax
      add  di , 2
      cmp di, 8858
      jne nextloc16
      jmp end1
     
wholebarRed:  
mov si, di
add si, 44
mov ax, 0x4078
nextloc17:
      mov  word[es:di], ax
      add  di , 2
      cmp di,si
      jne nextloc17
     
      mov ax, 0x1878   ;x on blue
      mov di, 8814
nextloc18:
      mov  word[es:di], ax
      add  di , 2
      cmp di, 8858
      jne nextloc18
      jmp end1
     
wholebarBlue:
mov si, di
add si, 44
mov ax, 0x9878
nextloc20:
      mov  word[es:di], ax
      add  di , 2
      cmp di,si
      jne nextloc20
     
      mov ax, 0x6878
      mov di, 8814
nextloc21:
      mov  word[es:di], ax
      add  di , 2
      cmp di, 8858
      jne nextloc21
      jmp end1
     
     
     
end1:  
       
     
      pop di
      pop si
      pop ds
      pop es
      pop ax
      ret    
     
     
;::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
;                           B A R 2
;::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

waitingbar:
            push ax
      push es
      push ds
      push si
      push di
     
      mov  ax, 0xb800
      mov  es, ax
      mov  di, 8814                       ;(132*38  + 60)*2
      mov  si, di
      mov  al, 'x'
      mov  ah,  0x40
     
     
nextloc14:  mov  word[es:di], ax
      add  di , 2
      cmp di,8858
      jne nextloc14
     
      pop ax
      pop es
      pop ds
      pop si
      pop di
      ret
     
;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
; rotate rabbit and bar right
;::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
rotateBunnyright:
    pusha
    push es
    push ds
    push si
    push di

    mov ax,0xb800
    mov es,ax
    mov ds,ax
    ;mov bp, 10

hello:  mov si,9762
    mov di,9764         ;starting from the last index of the row
    mov dx,si           ;saving it to put into the first index
    std             ;auto decrement mode

    mov bx,4            ;ships on 8 lines
forr1:
    mov ax,[es:di]        ;saving last index
    mov cx,131
    rep movsw
    mov word[es:di],ax      ;restoring last index in first index
    mov si,dx
    add si,264          ;pointing to next line
    mov di,dx
    add di,266
    mov dx,si
    dec bx
    jnz forr1
    ;call delayBunny
    ; dec bp
    ; jnz hello



;cld

pop di
pop si
pop ds
pop es
popa
ret


;--------------------------------------------------------------------
;subroutine for moving bunny towards left
;--------------------------------------------------------------------

rotateBunnyleft:
      pusha
      push es
      push ds
      push si
      push di

      mov ax,0xb800
      mov es,ax
      mov ds,ax
      ;mov bp, 10

hello1:   mov si,9506
      mov di, 9504
      mov bx,4          
      cld          

for2:
      mov cx,131        
      lodsw                    
      sub si,2          
      rep movsw        
      mov word[es:di],ax        
      add si,2
      add di,2
      dec bx
      jnz for2
      ;call delayBunny
      ; dec bp
      ; jnz hello1

     

      pop di
      pop si
      pop ds
      pop es
      popa
      ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;    ROTATE WAITING BAR RIGHT
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

rotateWaitingright:
    pusha
    push es
    push ds
    push si
    push di

    mov ax,0xb800
    mov es,ax
    mov ds,ax
    ;mov bp, 10

hello3: mov si,8972  
    mov di,8974         ;starting from the last index of the row
    mov dx,si           ;saving it to put into the first index
    std             ;auto decrement mode

    mov bx,1            ;ships on 8 lines
for3:
    mov ax,[es:di]        ;saving last index
    mov cx,131
    rep movsw
    mov word[es:di],ax      ;restoring last index in first index
    mov si,dx
    add si,264          ;pointing to next line
    mov di,dx
    add di,266
    mov dx,si
    dec bx
    jnz for3
    ;call delayBunny
    ; dec bp
    ; jnz hello



;cld

pop di
pop si
pop ds
pop es
popa
ret


;--------------------------------------------------------------------
;subroutine for moving waiting bar towards left
;--------------------------------------------------------------------

rotateWaitingleft:
      pusha
      push es
      push ds
      push si
      push di

      mov ax,0xb800
      mov es,ax
      mov ds,ax
      ;mov bp, 10

hello4:   mov si, 8714
      mov di, 8712
      mov bx,1          
      cld          

for4:
      mov cx,131        
      lodsw                    
      sub si,2          
      rep movsw        
      mov word[es:di],ax        
      add si,2
      add di,2
      dec bx
      jnz for4
      ;call delayBunny
      ; dec bp
      ; jnz hello1

     

      pop di
      pop si
      pop ds
      pop es
      popa
      ret

;::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
;           S C R O L L    D O W N
;::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

move_lines:

    push bp
    mov bp, sp
    push ax
    push cx
    push si
    push di
    push es
    push ds
  push dx

  mov di,[bp+4]
  mov si,di
  sub si,264  ;because we want the si to be one line ahead of the di
  mov ax,0xb800
  mov es,ax
  mov ds,ax
  mov dx,8448
 
outerScrollDown:

  mov cx,132  ;count of how many times to do shifting
    cld
  rep movsw
    sub di,528
  sub si,528
  cmp di,dx
    jg outerScrollDown

    pop dx
    pop ds
    pop es
    pop di
    pop si
    pop cx
    pop ax
    pop bp
    ret 2
 
;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
;  P R I N T  F R U I T
;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
fruit:
    pusha
    push es
    push ds
    push si
    push di

    mov ax,0xb800
    mov es,ax
    mov di, [fruitPos]
    mov ah, 0x20
    mov al, 'o'
    mov [es:di], ax

pop di
pop si
pop ds
pop es
popa
ret

;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
;   R A N D O M I Z E   F R U I T   C O L U M N  (row stays fixed)
;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
randomizeFruit:
    push ax
    push bx
    push cx
    push dx
    push es

    mov ax, 0x0040
    mov es, ax
    mov ax, [es:0x006C]     ; BIOS timer tick count, changes ~18.2 times/sec - random seed

    xor dx, dx
    mov bx, 20
    div bx                   ; dx = tick mod 20  -> 0..19
    mov cx, dx
    add cx, 60                ; cx = random column, range 60..79

    mov ax, 34                ; fixed row (same row the fruit always used)
    mov bx, 132
    mul bx                    ; dx:ax = 34*132
    add ax, cx                ; + random column
    shl ax, 1                 ; word-per-cell -> byte offset into video memory
    mov [fruitPos], ax

    pop es
    pop dx
    pop cx
    pop bx
    pop ax
    ret

;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
;        P R I N T   P O I N T S
;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
printnum:
push es
push ax
push bx
push cx
push dx
push di
mov ax, 0xb800
mov es, ax ; point es to video base
mov ax, [points] ; load number in ax
mov bx, 10 ; use base 10 for division
mov cx, 0 ; initialize count of digits
nextdigit: mov dx, 0 ; zero upper half of dividend
div bx ; divide by 10
add dl, 0x30 ; convert digit into ascii value
push dx ; save ascii value on stack
inc cx ; increment count of values
cmp ax, 0 ; is the quotient zero
jnz nextdigit ; if no divide it again
mov di, 240 ; point di to 70th column
nextpos: pop dx ; remove a digit from the stack
mov dh, 0x07 ; use normal attribute
mov [es:di], dx ; print char on screen
add di, 2 ; move to next screen location
loop nextpos ; repeat for all digits on stack
pop di
pop dx
pop cx
pop bx
pop ax
pop es
ret

;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
;   C O N V E R T   S C O R E   T O   A S C I I  (for game-over screen)
;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
convertScore:
push ax
push bx
push cx
push dx
push di

mov ax, [points]
mov bx, 10
xor cx, cx
digitloop:
xor dx, dx
div bx
add dl, 0x30
push dx
inc cx
cmp ax, 0
jnz digitloop

mov [scoreLen], cx
mov di, scoreStr
popdigits:
pop dx
mov [di], dl
inc di
loop popdigits

pop di
pop dx
pop cx
pop bx
pop ax
ret

;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
;   D E T E C T  C O L L I S I O N  W I T H  F R U I T
;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

detectCollision:
    push ax
    push cx
    push si
    push di
    push es
    push ds
  push dx

mov ax, 132    
mul word [bunnyY]  
add ax, [bunnyX]      
shl ax, 1  
mov di, ax
mov si, di
add si, 10

StartCheck:
cmp di, [fruitPos]
je incPoints
add di, 2
cmp di, si
jne StartCheck
je end2

incPoints:
add word[points], 10
;mov word[fruitPos], 0

end2:   pop dx
    pop ds
    pop es
    pop di
    pop si
    pop cx
    pop ax
  ret
 
;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
;   D E T E C T   G A M E   O V E R
;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
detectGameOver:
    push ax
    push cx
    push si
    push di
    push es
    push ds
  push dx

mov ax, 0xb800
mov es, ax
mov ax, 132    
mul word [bunnyY]  
add ax, [bunnyX]      
shl ax, 1  
mov di, ax
add di, 528
sub di, 2
add di, 264

firstfoot:
mov ax, [es:di]
;cmp ax, 0x2020
cmp ah, 0x20
je secondfoot
jne end3

secondfoot:
add di, 14
mov ax, [es:di]
;cmp ax, 0x2020
cmp ah, 0x20
je update
jne end3

update:
mov word[gameOver], 1

end3:  
  pop dx
    pop ds
    pop es
    pop di
    pop si
    pop cx
    pop ax
  ret
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;     C H E C K   I F   B L U E
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
checkBlue:
            push ax
      push es
      push ds
      push si
      push di
     
      mov  ax, 0xb800
      mov  es, ax
      mov  di, 10296         ;neeche wali              ;(132*38  + 60)*2
      mov  si, di
      mov  al, 'x'
      mov  ah,  0x68
loop2:
cmp word[es:di], 0x6878      ;if orange down,make red above
je notBlue
cmp word[es:di], 0x4078      ;if red down, make blue above
je notBlue
cmp word[es:di], 0x9878      ;if blue down, make orange above
je yesblue
add di, 2
jmp loop2

notBlue:
mov word[isblue], 0
jmp end4

yesblue:
mov word[isblue], 1
jmp end4

end4:  
      pop di
      pop si
      pop ds
      pop es
      pop ax
      ret    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;     B R E A K   E F F E C T
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
breakEffect:
            push ax
      push es
      push ds
      push si
      push di
     
      mov  ax, 0xb800
      mov  es, ax
      mov  di, 10296         ;neeche wali              ;(132*38  + 60)*2
      mov  si, di
      mov  al, 'x'
      mov  ah,  0x68
loop3:
cmp word[es:di], 0x9878      ;if blue down, show breaking effect
je break
add di, 2
jmp loop3
     
     
break:  
mov si, di
add si, 44
mov ax, 0x9878
nextloc22:
      mov  word[es:di], 0x9878
      add  di , 2
      mov  word[es:di], 0x2020
      add di, 2
      cmp di,si
      jne nextloc22
      ; call delayBunny
      ; add di, 264
      ; sub di, 2
     
; mov si, di
; sub si, 44
; nextloc23:
      ; mov  word[es:di], 0x9878
      ; sub  di , 2
      ; mov  word[es:di], 0x2020
      ; sub di, 2
      ; cmp di, si
      ; jne nextloc23
      ; mov word[gameOver], 1
     
end5:  
       
     
      pop di
      pop si
      pop ds
      pop es
      pop ax
      ret    
     
;:::::::::::::::::::::::::::::::::::::::::::::::::::::;
;     C L E A R   B R I C K
;:::::::::::::::::::::::::::::::::::::::::::::::::::::

clearbrick:
            push ax
      push es
      push ds
      push si
      push di
     
      mov  ax, 0xb800
      mov  es, ax
      mov  di, 10296         ;neeche wali              ;(132*38  + 60)*2
      mov  si, di
      mov  al, 'x'
      mov  ah,  0x68
loop4:
cmp word[es:di], 0x9878      ;if blue down, show breaking effect
je GoClear
add di, 2
jmp loop4
     
     
GoClear:  
mov si, di
add si, 44
mov ax, 0x9878
nextloc24:
      mov  word[es:di], 0x2020
      add  di , 2
     
      cmp di,si
      jne nextloc24
     
      ; call delayBunny
      ; add di, 264
      ; sub di, 2
     
; mov si, di
; sub si, 44
; nextloc23:
      ; mov  word[es:di], 0x9878
      ; sub  di , 2
      ; mov  word[es:di], 0x2020
      ; sub di, 2
      ; cmp di, si
      ; jne nextloc23
       mov word[gameOver], 1    
       
     
      pop di
      pop si
      pop ds
      pop es
      pop ax
      ret    
;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


main:
   
    cmp word[gameOver], 1
    je over
    cli
    xor ax, ax
    mov es, ax
    mov ax, [es:9*4]
    mov [orig_int9_offset], ax
    mov ax, [es:9*4+2]
    mov [orig_int9_segment], ax

   
    mov word [es:9*4],  kbisr
    mov [es:9*4+2], cs
   
    sti

      ; following code just changes your screen resolution to 43x132 Mode
      mov AH,0x00
      mov al, 0x54
      int 0x10
            call clrscr  
      call stars
      call road
      call carlayer1
      call thinbuilding
      call grass
      call Rabbit
      call bar
      call waitingbar
      call randomizeFruit
      call fruit
      ; call delayBunny
      ; call delayBunny
      ; call delayBunny
      ; call ClrRabbit
      call printnum
      jmp movement
      ; ; call thickbuilding
      ; ; call normalbuilding
     
      ;cmp word[overr], 1
      ;je over
       ; call detectGameOver
      ; cmp word[gameOver], 1
      ; je over
     
getkeywhenRight:
      mov si, 0
      mov ah, 1
     
      cmp word[signal], 1
      je hopup
      jmp next5
     
     
hopup:    
      mov word[signal], 0

      call checkBlue
      cmp word[isblue], 1
      je update2
      jne else2
update2:
      mov word[isblue], 0
      mov word[places], 0
else2:
      call ClrRabbit
      call delayjump
      mov ax,11088 ;startiing cell of the 42nd row
            push ax
            call move_lines
      sub word[bunnyY], 1
      call Rabbit
      call detectCollision
      call printnum
      call delayjump
      add si, 1
      cmp si, 3
      jnz hopup
     
      mov si, 0
hopdown:
      call ClrRabbit
      call delayjump
      mov ax,11088 ;startiing cell of the 42nd row
            push ax
            call move_lines
      add word[bunnyY], 1
      call Rabbit
      ; call detectCollision
      ; call printnum
      call delayjump
      add si, 1
      cmp si, 3
      jnz hopdown
      call barNew
      call randomizeFruit
      call fruit
      jmp next5
     
     
getkeywhenLeft:
      mov si, 0
      mov ah, 1

      cmp word[signal], 1
      je hopup2
      jmp next6


hopup2:
      mov word[signal], 0

      call checkBlue
      cmp word[isblue], 1
      je update3
      jne else3
update3:
      mov word[isblue], 0
      mov word[places], 0
else3:
      call ClrRabbit
      call delayjump
      mov ax,11088 ;startiing cell of the 42nd row
            push ax
            call move_lines
      sub word[bunnyY], 1
     
      call Rabbit
      call detectCollision
      call printnum
      call delayjump
      add si, 1
      cmp si, 3
      jnz hopup2
     
      mov si, 0
hopdown2:
      call ClrRabbit
      call delayjump
     
           
            mov ax,11088 ;startiing cell of the 42nd row
            push ax
            call move_lines

      add word[bunnyY], 1
      call Rabbit
      call delayjump
      add si, 1
      cmp si, 3
      jnz hopdown2
      call barNew
      call randomizeFruit
      call fruit
      jmp next6
     
     
     
movement:
      mov bp, 20
moveeBR:  call rotationn
      call rotation
      call rotateBunnyright
      ;add word[bunnyX],1
      call rotateWaitingleft
      call delayBunny
      add word[bunnyX],1
      jmp getkeywhenRight
     
      ;mov bx, ax
     
      ; mov ah, 1
      ; int 0x16
      ; jz next5
next5:    ;call barNew
      ; call detectGameOver
      ; cmp word[gameOver], 1
      ; je over
     
      call checkBlue
      cmp word[isblue], 1
      je updatePlace
      jne else1
updatePlace:
      inc word[places]       ;kitni ho gyi hain
      cmp word[places], 30
      je firstbreak
      mov bx, [tick]         ;kitni honi chahiye
      cmp word[places], bx
      je BlueOver
      jne else5
     
firstbreak:
      call breakEffect
      jmp else5
     
BlueOver:
    mov ax, 0x3508
    int 0x21
    mov [orig_int8], bx
    mov [orig_int8+2], es
    mov word[int8hooked], 1

    ; Set new int 8 vector
    mov dx, my_isr
    mov ax, 0x2508
    int 0x21
    sti

   
wait_loop:
    cmp dword [tick_counter], 800
    jl wait_loop
      call clearbrick
      cmp word[gameOver], 1
      je over
else1:
      call detectGameOver
      cmp word[gameOver], 1
      je over
     
else5:
        call detectGameOver
        cmp word[gameOver], 1
        je over
        dec bp
        jnz moveeBR
        ;call move_lines
     
     
      mov bp, 20
moveeBL:  call rotationn
      call rotation
      call rotateBunnyleft
      ;sub word[bunnyX], 1
      call rotateWaitingright
      call delayBunny
      sub word[bunnyX], 1
      jmp getkeywhenLeft
     
      ;mov bx, ax
     
      ; mov ah, 1
      ; int 0x16
next6:    ;call barNew
     
     
      call checkBlue
      cmp word[isblue], 1
      je updateplaces2
      jne else4
updateplaces2:
      inc word[places]
      mov bx, [tick]
      cmp word[places], 30
      je firstbreak2
      cmp word[places], bx
      je BlueOver2
      jne else6
     
firstbreak2:
      call breakEffect
      jmp else6
     
BlueOver2:
      ;call detectGameOver
      ;cmp word[gameOver], 1
      call clearbrick
      cmp word[gameOver], 1
      je over
     
else4:
      call detectGameOver
      cmp word[gameOver], 1
      je over
     
else6:    dec bp
      jnz moveeBL
     
      ;call move_lines
      call fruit
            jmp movement

;::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
;----------------------------------------------------------------
;::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
exit:
 
      ;---------------------------------------------
  pusha
    mov ax,0x000d
    int 0x10
    mov ax,0x0c16   ;backgound color of intro screen
    mov cx,320     ;number of columns
    mov dx,0
line22:
    int 0x10
    loop line22
    mov cx,320
    inc dx
    cmp dx,200    ;rows
    jne line22
   
   
    mov ax,0xb800
    mov es,ax

;for showing enter name
    mov ah, 0x13    ; Function to write text with attributes
    mov al, 1       ; Number of characters to write
    mov bh, 0       ; Display page
    mov bl, 0xb7    ; Display attribute (text color and background)

    mov cx, 14      ; Text length
    mov dx, 0x0b0c  ; Display position (row and column)

;Display "textover" string at the specified position
push ds
pop es
mov bp, textover
int 0x10

call convertScore
    mov cx, [scoreLen]      ; Text length
    mov dx, 0x1800  ; Display position (row and column)

;Display the numeric score at the specified position
push ds
pop es
mov bp, scoreStr
int 0x10
popa
    ; mov dx, 0x1400  ; Display position (row and column)
   ret  

     
over:
call exit
cli
    cmp word[int8hooked], 1
    jne skipint8restore
    mov dx, [orig_int8]
    mov ax, [orig_int8+2]
    mov ds, ax
    mov ax, 0x2508
    int 0x21
    push cs
    pop ds
skipint8restore:

    mov dx, [orig_int9_offset]
    mov ds, [orig_int9_segment]
    mov ax, 0x2509
    int 0x21
    sti

mov ax,0x4c00 ;terminate the program
      int 0x21

   
   
;;;;;building rows 7-15
;;;;;sky 1-15
buildingI: dw 8, 8, 8, 7, 9, 11, 8, 10
buildingJ: dw 1, 28, 42, 51, 70, 94, 105, 116
thickness: dw 40, 20, 10, 30, 40, 20, 16, 20  
colour: dw 0x507c, 0x607c, 0x307c, 0x107c, 0x507c, 0x607c, 0x307c, 0x107c
bunnyX: dw 60
bunnyY:dw 36
fruitPos: dw 9366
carW1: dw 5734
carW2: dw 6000
points: dw 0
isblue: dw 0
tick: dw 56
places: dw 0
gameOver: dw 0
carl2end: dw 5764
scoreStr: times 6 db '0'
scoreLen: dw 1

buffer: times 132 dw 0
buffer1: times 1584 dw 0
buffer3: times 5676 dw 0