*-----------------------------------------------------------
* Title      : Bcc
* Written by : Ko Fukushima
* Date       : 5/20/2016
* Description:
*-----------------------------------------------------------
    ORG    $1000

example          EQU     %0110001111111111 * %0110001100000000 * %0110001101000110
eightbitaddr     EQU     $3445
sixteenbitaddr   EQU     $12345678

START:                  ; first instruction of program 

               MOVE.L      #sixteenbitaddr , (A5)

               LEA         jmp_table_bcc,A0    *Index into the table

               CLR.L       D0              *Zero it

               MOVE.W      #example,D0     *We'll play with it here
               
               MOVE.B      #4, D1
               
               LSL.W       D1, D0

               MOVE.B      #12,D1       *Shift 12 bits to the right  

               LSR.W       D1,D0           *Move the bits
           
               MULU        #6,D0       *Form offset     

               JMP         0(A0,D0)   *Jump indirect with index

                    
jmp_table_bcc  JMP         code0000

               JMP         code0001

               JMP         HI

               JMP         LS

               JMP         CC

               JMP         CS

               JMP         NE

               JMP         EQ

               JMP         VC

               JMP         VS

               JMP         PL
               
               JMP         MI

               JMP         GE

               JMP         LT

               JMP         GT

               JMP         LE

        
code0000       STOP        #$2700

code0001       STOP        #$2700 

HI             BRA         PRINT_BHI 

LS             BRA         PRINT_BLS  

CC             BRA         PRINT_BCC

CS             BRA         PRINT_BCS 

NE             BRA         PRINT_BNE 

EQ             BRA         PRINT_BEQ

VC             BRA         PRINT_BVC

VS             BRA         PRINT_BVS

PL             BRA         PRINT_BPL

MI             BRA         PRINT_BMI 

GE             BRA         PRINT_BGE 

LT             BRA         PRINT_BLT

GT             BRA         PRINT_BGT      

LE             BRA         PRINT_BLE 


* Put program code here
PRINT_BHI      
               LEA BHI_MESSAGE, A1
          
               MOVE.B #14, D0
                 
               TRAP #15    
               
               BRA DISPLACEMENT
               
PRINT_BLS
               LEA BLS_MESSAGE, A1
                 
               MOVE.B #14, D0
                 
               TRAP #15
               
               BRA DISPLACEMENT
PRINT_BCC
               LEA BCC_MESSAGE, A1
                 
               MOVE.B #14, D0
                 
               TRAP #15
               
               BRA DISPLACEMENT
PRINT_BCS
               LEA BCS_MESSAGE, A1
                 
               MOVE.B #14, D0
                 
               TRAP #15
               
               BRA DISPLACEMENT
PRINT_BNE
               LEA BNE_MESSAGE, A1
                 
               MOVE.B #14, D0
                 
               TRAP #15
               
               BRA DISPLACEMENT
PRINT_BEQ
               LEA BEQ_MESSAGE, A1
                 
               MOVE.B #14, D0
                 
               TRAP #15
               
               BRA DISPLACEMENT
PRINT_BVC
               LEA BVC_MESSAGE, A1
                 
               MOVE.B #14, D0
                 
               TRAP #15     
               
               BRA DISPLACEMENT
PRINT_BVS
               LEA BVS_MESSAGE, A1
                 
               MOVE.B #14, D0
                 
               TRAP #15
               
               BRA DISPLACEMENT
PRINT_BPL
               LEA BPL_MESSAGE, A1
                 
               MOVE.B #14, D0
                 
               TRAP #15
               
               BRA DISPLACEMENT
PRINT_BMI
               LEA BMI_MESSAGE, A1
                 
               MOVE.B #14, D0
                 
               TRAP #15
               
               BRA DISPLACEMENT
PRINT_BGE
               LEA BGE_MESSAGE, A1
                 
               MOVE.B #14, D0
                 
               TRAP #15
               
               BRA DISPLACEMENT
PRINT_BLT
               LEA BLT_MESSAGE, A1
                 
               MOVE.B #14, D0
                 
               TRAP #15
               
               BRA DISPLACEMENT
PRINT_BGT
               LEA BGT_MESSAGE, A1
                 
               MOVE.B #14, D0
                 
               TRAP #15
               
               BRA DISPLACEMENT
PRINT_BLE
               LEA BLE_MESSAGE, A1
                 
               MOVE.B #14, D0
                 
               TRAP #15
               
DISPLACEMENT   LEA     POUND_SIGN, A1
            
               MOVE.B  #14, D0
            
               TRAP #15
            
               LEA     HEX_SIGN, A1
            
               TRAP #15

               CLR.L       D0              *Zero it

               MOVE.W      #example,D0     *We'll play with it here
               
               MOVE.B      #8, D1
               
               LSL.W       D1, D0

               MOVE.B      #8,D1       *Shift 12 bits to the right  

               LSR.W       D1,D0           *Move the bits
               
               *chk the D0 for 8, 16, or 32 but displacement
                
               CMP.B  #$00, D0

               BEQ  a_16_BIT 

               CMP.B #$FF, D0   

               BEQ  a_32_BIT
                
                *else 
                
               CLR.L D5
               
               MOVE.W D0, D5      
        
               JSR         HEX_TO_ASCII
               
               JMP DONE
                          
a_16_BIT
        CLR.L  D5
        
        MOVE.W (A5)+, D5
        
        JSR         HEX_TO_ASCII
        
        JMP DONE  
a_32_BIT

        CLR.L  D5
        
        MOVE.L (A5)+, D5
        
        JSR         HEX_TO_ASCII

        JMP DONE
               
               *if D0 == $FF print 16 more bits
                INCLUDE 'HEX_TO_ASCII_V1.X68'
    
DONE

* Put variables and constants here
                INCLUDE 'MESSAGE_Data.X68'

    END    START        ; last line of source








*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
