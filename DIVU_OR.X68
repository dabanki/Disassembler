*-----------------------------------------------------------
* Title      : DIVU_OR
* Written by : Ko Fukushima
* Date       : 5/18/2016
* Description:
*-----------------------------------------------------------
    
DIVU_OR          JSR      GET_OPMODE  
                                          
                 CMP.B    #$3, D0        *if D0 holds 3, the opcode is DIVU
                 
                 BEQ      DIVU_CODE
                 
                 JMP      OR_CODE
                 
DIVU_CODE  
                 * OP_CODE message
                 LEA      DIVU_MESSAGE, A1
                 MOVE.B   #14, D0
                 TRAP #15

OR_CODE    
                 * OP_CODE message
                 LEA      OR_MESSAGE, A1
                 MOVE.B   #14, D0
                 TRAP #15



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
