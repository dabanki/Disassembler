*-----------------------------------------------------------
* Title      : Memory parser
* Written by : Ko Fukushima
* Date       : 5/13/2016
* Description: parse the memory address 
*-----------------------------------------------------------

                MOVE.L   STARTING_ADDR, A0
                MOVE.L   ENDING_ADDR, A1
                
PARSE_MEMORY    CMPA.L   ENDING_ADDR, A0
                BEQ      STOP
                MOVE.W   (A0)+, D0
                JMP      NEXT_INSTRUCTION
                    
NEXT_INSTRUCTION
                JMP      PARSE_MEMORY
                
STOP


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
