*-----------------------------------------------------------
* Title      : ADD_ADDA
* Written by : Ko Fukushima
* Date       : 5/18/2016
* Description:
*-----------------------------------------------------------
  
ADD_ADDA  *at this point we know the first 4 bits are 1101 -> ADD or ADDA -> compare the destination opmode
                 
                 JSR GET_OPMODE
                                            
                 CMP.B    #$3, D0        *if D0 holds 3, the opcode is ADDA
                 
                 BEQ      ADDA_CODE
                 
                 JMP      ADD_CODE
                 
ADDA_CODE
                 * Welcome message
                 LEA ADDA_MESSAGE, A1
                 MOVE.B #14, D0
                 TRAP #15

ADD_CODE
                 * Welcome message
                 LEA ADD_MESSAGE, A1
                 MOVE.B #14, D0
                 TRAP #15
                 
GET_OPMODE * get the op-code 

                 CLR.L D0                *clear D0
                 
                 CLR.L D1                *clear D1
                 
                 MOVE.W  #example,D0     *D0 is the binary value to decode

                 MOVE.B  #8,D1           *8 bits is the number of times to shift to the left to remove opcode & register #

                 LSL.W   D1,D0           *Shift the bits 8 times -> D0 now removes the opcode & reg#
                 
                 MOVE.B  #14,D1          *14 bits is the number of times to shift to hold the mode number

                 LSR.W   D1,D0           *Shift the bits 14 times -> D0 now holds the mode number
                 
                 RTS 

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
