*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

SHIFTS           CLR.L D0

                 CLR.L D1
                 
                 MOVE.W #example,D0
                 
                 LSL.W #4,D0            *shift out the opcode
                 
                 MOVE.B #13,D1          
                 
                 LSR.W D1,D0            *shift out everything, so only three bits after opcode are there
                 
                 CMP.B #1,D0            
                 
                 BEQ LSD                *if the bits are 1, it is a logical shift
                 
                 CMP.B #3,D0
                 
                 BEQ ROD                *if the bits are 3, it is a rotation
                 
                 BRA ASD                *if it is not equal to 1 or 3, it is arithmetic shift
                 

LSD              CLR.L D0               *still need to do checks, since an asd shift could still be a possibility
                 
                 CLR.L D1
                 
                 MOVE.W #example,D0
                 
                 LSL.W #8,D0
                 
                 MOVE.B #14,D1
                 
                 LSR.W D1,D0
                 
                 CMP.B #3,D0            *need to check the two bits after the direction 
                 
                 BNE ASD                *if the two bits are not 3, it is an arithmetic shift
                 
                 BRA DONE


ROD              CLR.L D0               *same check as logical shift, since an arithmetic shift could still be possible
                 
                 CLR.L D1
                 
                 MOVE.W #example,D0
                 
                 LSL.W #8,D0
                 
                 MOVE.B #14,D1
                 
                 LSR.W D1,D0
                 
                 CMP.B #3,D0
                 
                 BNE ASD
                 
                 BRA DONE       
                 
ASD              BRA DONE               *add error handling


    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
