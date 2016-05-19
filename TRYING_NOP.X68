*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $1000
    
START:                  ; first instruction of program
 

    MOVE.W  #$4E75, D2          * hardcodiing nop

   * CMP.L       #$4E71, D2      * has to be NOP
    *
   * BEQ         NOP_OPCODE
    
   * CMP.L       #$4E75, D2      * has to be RTS
    
  *  BEQ         RTS_OPCODE
   BRA CLR_OPCODE  

NOP_OPCODE
    LEA         NOP_MESSAGE, A1     * print out message for 'NOP'
    
    MOVE.B      #14, D0
    
    TRAP #15
    
    BRA DONE
RTS_OPCODE 
    LEA         RTS_MESSAGE, A1     * print out message for 'RTS'
    
    MOVE.B      #14, D0
    
    TRAP #15
    
    BRA DONE
    
JSR_OPCODE 
    LEA         JSR_MESSAGE, A1     * print out message for 'JSR'
    
    MOVE.B      #14, D0
    
    TRAP #15
    
    BRA DONE
    
MOVEM_OPCODE 
    LEA         MOVEM_MESSAGE, A1     * print out message for 'MOVEM'
    
    MOVE.B      #14, D0
    
    TRAP #15
    
    CLR.L       D0

    CLR.L       D1
               
    MOVE.W      D2, D0
             
    MOVE.B      #6, D1
               
    LSR.W       D1, D0  *shift right 6 
               
    MOVE.B      #15, D1
               
    LSL.W       D1, D0  *shift left 15, only size is left
    
    MOVE.B      #15, D1
               
    LSR.W       D1, D0  *shift right 15, size is left   
               
    CMP.W       #0, D0
               
    LEA         SIZE_W_PRINT, A1 
    
    CMP.W       #1, D0
               
    LEA         SIZE_L_PRINT, A1 

    MOVE.B      #14, D0
    
    TRAP #15

    BRA DONE
   
CLR_OPCODE 
    LEA         CLR_MESSAGE, A1     * print out message for 'CLR'
    
    MOVE.B      #14, D0
    
    TRAP #15
    
    MOVE.W      D2, D0
             
    MOVE.B      #6, D1
               
    LSR.W       D1, D0  *shift right 6 
               
    MOVE.B      #14, D1
               
    LSL.W       D1, D0  *shift left 15, only size is left
    
    MOVE.B      #14, D1
               
    LSR.W       D1, D0  *shift right 15, size is left   
               
    CMP.W       #00, D0
               
    LEA         SIZE_B_PRINT, A1 
    
    CMP.W       #01, D0
               
    LEA         SIZE_W_PRINT, A1 
    
    CMP.W       #11, D0
               
    LEA         SIZE_L_PRINT, A1 

    MOVE.B      #14, D0
    
    TRAP #15

    BRA DONE
    
 INCLUDE 'MESSAGE_Data.X68'
    SIMHALT             ; halt simulator
DONE
* Put variables and constants here

    END    START        ; last line of source




*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
