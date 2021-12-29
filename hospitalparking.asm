;PARKING MANAGEMENT SYSTEM FOR HOSPITALS
.model small
.stack 100h
.data
menu db '*****************MENU*********************$'
menu1 db 'Enter 1 to park an ambulance$'
menu2 db 'Enter 2 to park a staff vehicle$'
menu3 db 'Enter 3 to park a patient vehicle$'
menu4 db 'Enter 4 to show the parked vehicles$'

menudelete1  db 'Enter 5 to remove ambulance$'
menudelete2  db 'Enter 6 to remove staff vehicle$'
menudelete3  db 'Enter 7 to remove patient vehicle$'
menudelete4  db 'Enter 8 to remove all vehicles$'

menu6 db 'Enter 9 to exit the program$'  

msg db 'Enter your choice: $'

msg1 db 'Parking is full$'
msg2 db 'Wrong input$'
msg3 db 'Staff Vehicle$'
msg4 db 'Patient Vehicle$'
msg5 db 'Records$'
msg6 db 'There is more space$'
msg7 db 'Total amount is = $'
msg8 db 'Total numbers of vehicles parked = $'
msg9 db 'Total number of ambulances parked = $'
msg10 db 'Total number of staff vehicles parked = $'
msg11 db 'Total number of patient vehicles parked = $'
msg12 db '***Records deleted successfully***$'
msg13 db '***Vehicle removed successfully***$'  
fee db 'Parking Fee: Rs. $'

amount dw 0
count dw  '0'

a dw '0'   ;ambulances
s db '0'   ;staff vehicles
p db '0'   ;patient vehicles

.code
main proc
    mov ax,@data
    mov ds,ax   
    
    while_:   
    
    ;Menu to be displayed
    
    mov dx,10
    mov ah,2
    int 21h
    mov dx,13
    mov ah,2
    int 21h
    
    mov dx,offset menu   ;MENU 
    mov ah,9             ;Display a character string
    int 21h              ;Call DOS Function
    mov dx,10
    mov ah,2             ;Write to a standard output device
    int 21h 
    mov dx,13
    mov ah,2             
    int 21h
        
    mov dx,offset menu1     ;OPTION1
    mov ah,9
    int 21h 
    mov dx,10
    mov ah,2
    int 21h
    mov dx,13
    mov ah,2
    int 21h
    
    
    mov dx,offset menu2     ;OPTION2
    mov ah,9
    int 21h
    mov dx,10
    mov ah,2
    int 21h
    mov dx,13
    mov ah,2
    int 21h
    
    
    mov dx,offset menu3     ;OPTION3
    mov ah,9
    int 21h
    mov dx,10
    mov ah,2
    int 21h
    mov dx,13
    mov ah,2
    int 21h
    
    
    mov dx,offset menu4     ;OPTION4
    mov ah,9
    int 21h
    mov dx,10
    mov ah,2
    int 21h
    mov dx,13
    mov ah,2
    int 21h
    
    
    mov dx,offset menudelete1    ;OPTION5
    mov ah,9
    int 21h
    mov dx,10
    mov ah,2
    int 21h
    mov dx,13
    mov ah,2
    int 21h
    
    mov dx,offset menudelete2    ;OPTION6
    mov ah,9
    int 21h
    mov dx,10
    mov ah,2
    int 21h
    mov dx,13
    mov ah,2
    int 21h    
    
    mov dx,offset menudelete3    ;OPTION7
    mov ah,9
    int 21h
    mov dx,10
    mov ah,2
    int 21h
    mov dx,13
    mov ah,2
    int 21h        
    
    mov dx,offset menudelete4    ;OPTION8
    mov ah,9
    int 21h
    mov dx,10
    mov ah,2
    int 21h
    mov dx,13
    mov ah,2
    int 21h
    
    mov dx,offset menu6          ;OPTION9
    mov ah,9
    int 21h
    mov dx,10
    mov ah,2
    int 21h
    mov dx,13
    mov ah,2
    int 21h
    
    mov dx,offset msg      ;ENTER CHOICE MESSAGE
    mov ah,9
    int 21h
    mov dx,10
    mov ah,2
    int 21h
    mov dx,13
    mov ah,2
    int 21h
    
    
    ;Taking input from user
    mov ah,1            ;Read input from keyboard
    int 21h             ;Call DOS Function
    mov bl,al
    mov dx,10
    mov ah,2
    int 21h
    mov dx,13
    mov ah,2
    int 21h
    
    ;Now comparing the option entered to the cases
    mov al,bl
    cmp al,'1'
    je amb              ;Jump if equal to 1
    cmp al,'2'
    je sv
    cmp al,'3'
    je pv
    cmp al,'4'
    je rec 
    cmp al,'5'
    je del1  
    cmp al, '6'
    je del2
    cmp al, '7'
    je del3
    cmp al, '8'
    je del 
    cmp al, '9' 
    je del 
    je end_
    
    
    mov dx,offset msg2
    mov ah,9
    int 21h
    
    mov dx,10
    mov ah,2
    int 21h
    mov dx,13
    mov ah,2
    int 21h
    
    jmp while_
    
    amb:
    call ambulance
    
    sv:
    call staffvehicle
    
    pv:
    call patientvehicle
    
    rec:
    call recrd  
    
    del1:
    call dela
    
    del2:
    call dels
    
    del3:
    call delp 
    
    del:
    call delt
    
    end_:
    mov ah,4ch          ;Exit the program
    int 21h             ;Call DOS Function

main endp


ambulance proc
    cmp count,'4'       ;upto 4 ambulances can be parked
    jl amb1             ;Jump if lesser than 
    mov dx,offset msg1
    mov ah,9
    int 21h
    jmp while_
    jmp end_
    
    amb1:
        mov ax,0        ;Parking Fee for Ambulance is 0
        add amount, ax 
        mov dx,0        
        mov bx,10 
        mov cx,0    
    
    l2:                 ;To push the amount into the stack
        div bx
        push dx
        mov dx,0
        mov ah,0
        inc cx
        cmp ax,0
        jne l2          ;jump if not equal to   
    
    mov dx,offset fee
    mov ah,9
    int 21h
       
    l3:                 ;To print the amount from the stack digit by digit
        pop dx
        add dx,48
        mov ah,2
        int 21h 
    loop l3 
    
    inc count
    inc a

    jmp while_
    jmp end_


staffvehicle proc
    cmp count,'25'
    jl staffvehicle1
    mov dx,offset msg1
    mov ah,9
    int 21h
    jmp while_
    jmp end_
    
    staffvehicle1:
        mov ax,100
        add amount, ax
        mov dx,0
        mov bx,10
        mov cx,0
    l22:
        div bx
        push dx
        mov dx,0
        mov ah,0
        inc cx
        cmp ax,0
        jne l22    
    
    mov dx,offset fee
    mov ah,9
    int 21h
       
    l33:
        pop dx
        add dx,48
        mov ah,2
        int 21h
    loop l33
    
    
    inc count
    inc s
    jmp while_
    jmp end_


patientvehicle proc
    cmp count,'50'
    jl patientvehicle1
    mov dx,offset msg1
    mov ah,9
    int 21h
    jmp while_
    jmp end_
    
    patientvehicle1:
    mov ax, 100
    add amount, ax
    mov dx,0
    mov bx,10
    mov cx,0
    l222:
        div bx
        push dx
        mov dx,0
        mov ah,0
        inc cx
        cmp ax,0
        jne l222
    
    mov dx,offset fee
    mov ah,9
    int 21h
       
    l333:
        pop dx
        add dx,48
        mov ah,2
        int 21h
    loop l333
    
    inc count
    inc p
    jmp while_
    jmp end_


recrd proc
    mov dx,offset msg7
    mov ah,9
    int 21h

    ;Print the total amount
    mov ax, amount
    
    mov dx,0
    mov bx,10
    mov cx,0
    totalpush:
           div bx
           push dx
           mov dx,0
           inc cx
           cmp ax,0
           jne totalpush
       
    totalprint:
            pop dx
            add dx,48
            mov ah,2
            int 21h
    loop totalprint

    mov dx,10
    mov ah,2
    int 21h
    mov dx,13
    mov ah,2
    int 21h
    
    mov dx,offset msg8
    mov ah,9
    int 21h
    
    mov dx,count
    mov ah,2
    int 21h
    
    mov dx,10
    mov ah,2
    int 21h
    mov dx,13
    mov ah,2
    int 21h
       
    mov dx,offset msg9
    mov ah,9
    int 21h
    
    mov dx,a
    mov ah,2
    int 21h
    
    mov dx,10
    mov ah,2
    int 21h
    mov dx,13
    mov ah,2
    int 21h

    mov dx,offset msg10
    mov ah,9
    int 21h
    
    
    mov dl,s
    mov ah,2
    int 21h
    
    mov dx,10
    mov ah,2
    int 21h
    mov dx,13
    mov ah,2
    int 21h
    
    
    mov dx,offset msg11
    mov ah,9
    int 21h
    
    mov dl,p
    mov ah,2
    int 21h
    
    jmp while_
    jmp end_

dela proc 
    dec a
    dec count
    mov dx,offset msg13
    mov ah,9
    int 21h
    mov dx,10
    mov ah,2
    int 21h
    mov dx,13
    mov ah,2
    int 21h   
    jmp while_
    jmp end_
    
    
dels proc  
    dec s
    dec count
    mov dx,offset msg13
    mov ah,9
    int 21h
    mov dx,10
    mov ah,2
    int 21h
    mov dx,13
    mov ah,2
    int 21h    
    jmp while_
    jmp end_
    
delp proc  
    dec p
    dec count
    mov dx,offset msg13
    mov ah,9
    int 21h
    mov dx,10
    mov ah,2
    int 21h
    mov dx,13
    mov ah,2
    int 21h   
    jmp while_
    jmp end_
    
delt proc
    mov a,'0'
    mov s,'0'
    mov p,'0'
    mov amount,0
    mov count,'0'

    mov dx,offset msg12
    mov ah,9
    int 21h
    mov dx,10
    mov ah,2
    int 21h
    mov dx,13
    mov ah,2
    int 21h
    
    jmp while_
    jmp end_

end main
