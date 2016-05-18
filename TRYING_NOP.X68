*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $1000
    
START:                  ; first instruction of program
 

    MOVE.W  #$4E75, D2          * hardcodiing nop

    CMP.L       #$4E71, D2      * has to be NOP
    
    BEQ         NOP_OPCODE
    
    CMP.L       #$4E75, D2      * has to be RTS
    
    BEQ         RTS_OPCODE
     

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
 INCLUDE 'MESSAGE_Data.X68'
    SIMHALT             ; halt simulator
DONE
* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
