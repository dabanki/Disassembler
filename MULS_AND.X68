*-----------------------------------------------------------
* Title      : MULS_AND
* Written by : Ko Fukushima
* Date       : 5/18/2016
* Description:
*-----------------------------------------------------------
 
MULS_AND         JSR GET_OPMODE
                                            
                 CMP.B    #$3, D0        *if D0 holds 3, the opcode is DIVU
                 
                 BEQ      MULS_CODE
                 
                 JMP      AND_CODE
                 
MULS_CODE
                 * OP_CODE message
                 LEA MULS_MESSAGE, A1
                 MOVE.B #14, D0
                 TRAP #15

AND_CODE
                 * OP_CODE message
                 LEA AND_MESSAGE, A1
                 MOVE.B #14, D0
                 TRAP #15
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
