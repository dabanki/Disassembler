stack            EQU      $A000

example          EQU      %1110111100101000    * I made up bits 0 to 11      

shift            EQU     12                    * Shift 12 bits 

 

* Program starts here

 

                 ORG     $400

start            LEA     stack,SP        *Load the SP

                 LEA     jmp_table,A0    *Index into the table

                 CLR.L   D0              *Zero it

                 MOVE.W  #example,D0     *We'll play with it here

                 MOVE.B  #shift,D1       *Shift 12 bits to the right  

                 LSR.W   D1,D0           *Move the bits

*

* Consider the next instruction. Why do we have to multiply the index 

* by 6? How many bytes does a single jump table entry require? 

 

               MULU        #6,D0       *Form offset     

               JSR          0(A0,D0)   *Jump indirect with index

                    

jmp_table      JMP         code0000

               JMP         code0001

               JMP         code0010

               JMP         code0011

               JMP         code0100

               JMP         code0101

               JMP         code0110

               JMP         code0111

               JMP         code1000

               JMP         code1001

               JMP         code1010

               JMP         code1011

               JMP         code1100

               JMP         code1101

               JMP         code1110

               JMP         code1111

        

 

*The following subroutines will get filled in as you decode the instructions . For *now, just exit gracefully.

 

 

code0000       STOP        #$2700

code0001       BRA         MOVEB

code0010       BRA         MOVEW

code0011       BRA         MOVEL

code0100       STOP        #$2700

code0101       STOP        #$2700

code0110       STOP        #$2700

code0111       STOP        #$2700

code1000       STOP        #$2700

code1001       STOP        #$2700

code1010       STOP        #$2700

 

* Next we put in the next level of decoding. I just stuck this BRA

* instruction here so it would look different. If this was your real

* code, you would decode to the next level. Perhaps this would be

 * another jump table to the 8 possible op-codes at the next level.

 

code1011       BRA        code1011

code1100       STOP        #$2700

code1101       BRA         ADD_ADDA       *#$2700

code1110       BRA         SHIFTS

code1111       STOP        #$2700


ADD_ADDA  *at this point we know the first 4 bits are 1101 -> ADD or ADDA -> compare the destination opmode
              
                 CLR.L D0                *clear D0
                 
                 CLR.L D1                *clear D1
                 
                 MOVE.W  #example,D0     *D0 is the binary value to decode

                 MOVE.B  #8,D1           *8 bits is the number of times to shift to the left to remove opcode & register #

                 LSL.W   D1,D0           *Shift the bits 8 times -> D0 now removes the opcode & reg#
                 
                 MOVE.B  #14,D1          *14 bits is the number of times to shift to hold the mode number

                 LSR.W   D1,D0           *Shift the bits 14 times -> D0 now holds the mode number
                                            
                 CMP.B    #$3, D0        *if D0 holds 3, the opcode is ADDA
                 
                 BEQ      ADDR_CODE
                 
                 JMP      ADD_CODE
                 
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
                 
ADDR_CODE  
     *need to error check 

ADD_CODE 
    *JMP ADD_ADDA
    *need to error check 

LSD              CLR.L D0               *still need to do checks, since an asd shift could still be a possibility
                 
                 CLR.L D1
                 
                 MOVE.W #example,D0
                 
                 LSL.W #8,D0
                 
                 MOVE.B #14,D1
                 
                 LSR.W D1,D0
                 
                 CMP.B #3,D0            *need to check the two bits after the direction 
                 
                 BNE ASD                *if the two bits are not 3, it is an arithmetic shift
                 
                 MOVE.L #example, D0
                 
                 LSL.W  #7, D0
                 
                 MOVE.B #15, D1
                 
                 LSR.W  D1, D0
                 
                 CMP.B  #1, D0
                 
                 BEQ LSL
                 
                 BRA LSR
                 

LSL
                 LEA LSL_MESSAGE, A1    * print message
                 
                 MOVE.B #14, D0
                 
                 TRAP #15
            
                 MOVE.L #example, D0
                 
                 LSL.W #8, D0
                 
                 MOVE.B #14, D1
                 
                 LSR.W D1, D0
                 
                 CMP.B  #%11, D0        * check to see if it is memory and not register shift
                 
                 BEQ LSD_MEMORY
                 
                 BRA PRINTOUT_REGISTER_SHIFTS_EA

LSR              
                 LEA LSR_MESSAGE, A1            * print message
                 
                 MOVE.B #14, D0
                 
                 TRAP #15
        
                 MOVE.L #example, D0
                 
                 LSL.W #8, D0
                 
                 MOVE.B #14, D1
                 
                 LSR.W D1, D0
                 
                 CMP.B  #%11, D0            * check to see if memory shift
                 
                 BEQ LSD_MEMORY
                 
                 BRA PRINTOUT_REGISTER_SHIFTS_EA
                 
LSD_MEMORY
                 JSR    PRINTOUT_MEMORY_SHIFTS_EA
                 
                 BRA DONE
            

ROD              CLR.L D0               *same check as logical shift, since an arithmetic shift could still be possible
                 
                 CLR.L D1
                 
                 MOVE.W #example,D0
                 
                 LSL.W #8,D0
                 
                 MOVE.B #14,D1
                 
                 LSR.W D1,D0
                 
                 CMP.B #3,D0
                 
                 BNE ASD
                 
                 MOVE.L #example, D0
                 
                 LSL.W  #7, D0
                 
                 MOVE.B #15, D1
                 
                 LSR.W  D1, D0
                 
                 CMP.B  #1, D0
                 
                 BEQ ROL
                 
                 BRA ROR

ROL              
                 LEA ROL_MESSAGE, A1
                 
                 MOVE.B #14, D0
                 
                 TRAP #15

                 MOVE.L #example, D0
                 
                 LSL.W #8, D0
                 
                 MOVE.B #14, D1
                 
                 LSR.W D1, D0
                 
                 CMP.B  #%11, D0            * check to see if its memory shift
                 
                 BEQ ROD_MEMORY
                 
                 BRA PRINTOUT_REGISTER_SHIFTS_EA

ROR       
                 LEA ROR_MESSAGE, A1
                 
                 MOVE.B #14, D0
                 
                 TRAP #15
                 
                 MOVE.L #example, D0
                 
                 LSL.W #8, D0
                 
                 MOVE.B #14, D1
                 
                 LSR.W D1, D0
                 
                 CMP.B  #%11, D0            * check to see if its memory shift
                 
                 BEQ ROD_MEMORY
                 
                 BRA PRINTOUT_REGISTER_SHIFTS_EA

ROD_MEMORY       
                 JSR    PRINTOUT_MEMORY_SHIFTS_EA
                 
                 BRA DONE
                 
                 
ASD              MOVE.L #example, D0
                 
                 LSL.W  #7, D0
                 
                 MOVE.B #15, D1
                 
                 LSR.W  D1, D0
                 
                 CMP.B  #1, D0
                 
                 BEQ ASL
                 
                 BRA ASR
                 
ASL
                 LEA ASL_MESSAGE, A1
                 
                 MOVE.B #14, D0
                 
                 TRAP #15
                 
                 MOVE.L #example, D0
                 
                 LSL.W #8, D0
                 
                 MOVE.B #14, D1
                 
                 LSR.W D1, D0
                 
                 CMP.B  #%11, D0            * check to see if its memory shift
                 
                 BEQ ASD_MEMORY
                 
                 BRA PRINTOUT_REGISTER_SHIFTS_EA
                                  

ASR              
                 LEA ASR_MESSAGE, A1
                 
                 MOVE.B #14, D0
                 
                 TRAP #15
                 
                 MOVE.L #example, D0
                 
                 LSL.W #8, D0
                 
                 MOVE.B #14, D1
                 
                 LSR.W D1, D0
                 
                 CMP.B  #%11, D0            * check to see if its memory shift
                 
                 BEQ ASD_MEMORY
                 
                 BRA PRINTOUT_REGISTER_SHIFTS_EA

ASD_MEMORY
                 JSR    PRINTOUT_MEMORY_SHIFTS_EA
                 
                 BRA DONE
                 
PRINTOUT_REGISTER_SHIFTS_EA
                 MOVE.L #example, D0
                 
                 MOVE.B #10, D1
                 
                 LSL.W D1, D0
                 
                 MOVE.B #15, D1
                 
                 LSR.W D1, D0
                 
                 CMP.B #1, D0
                 
                 BEQ PRINTOUT_REGISTER
                 
                 BRA PRINTOUT_COUNT

                 
PRINTOUT_COUNT
                 LEA POUND_SIGN, A1

                 MOVE.B #14, D0

                 TRAP #15     
               
                 MOVE.L #example, D0
                 
                 LSL.W #4, D0
                 
                 MOVE.B #12, D1
                 
                 LSL.W D1, D0
                 
                 MOVE.B D0, D1
                 
                 MOVE.B #3, D0
                 
                 TRAP #15                  * print out the amount that the ea is being shifted by
                 
                 BRA DONE

PRINTOUT_REGISTER
                 MOVE.L #example, D0
                 
                 LSL.W #4, D0
                 
                 MOVE.B #13, D1
                 
                 LSR.W D1, D0
                 
                 MOVE.B D0, D7
                 
                 MOVE.B #%000, D6
                 
                 JSR PRINT_EA                  * to print out the data register
                 
                 JSR PRINTOUT_MEMORY_SHIFTS_EA * to print out the ea that is being shifted
                 
                 BRA DONE
                                 

PRINTOUT_MEMORY_SHIFTS_EA   * gets the mode and register of the memory ea, and prints it out
                 MOVE.L #example, D0
                 
                 MOVE.B #10, D1
                 
                 LSL.W D1, D0
                 
                 MOVE.B #13, D1
                 
                 LSR.W D1, D0
                 
                 MOVE.B D0, D6
                 
                 MOVE.L #example, D0
                 
                 MOVE.B #13, D1
                 
                 LSL.W D1, D0
                 
                 LSR.W D1, D0
                 
                 MOVE.B D0, D7
                 
                 JSR PRINT_EA
                 
                 RTS
                
              
MOVEB            LEA MOVE_MESSAGE, A1   * printing out the opcode and size

                 CLR.L  D0
                 
                 MOVE.B #14, D0
                 
                 TRAP #15
                 
                 LEA SIZE_B_PRINT, A1
                 
                 TRAP #15               * done printing opcode and size
                 
                 BRA DONE

MOVEW            CLR.L D0
                 
                 CLR.L D1
                 
                 MOVE.W #example,D0
                 
                 LSL.W #7,D0
                 
                 MOVE.B #13,D1
                 
                 LSR.W D1,D0
                 
                 CMP.B #1,D0            *check to see if the mode of the destination is an address register
                 
                 BEQ MOVEAW             *if the destination is an address, it is MOVEA
                 
                 LEA MOVE_MESSAGE, A1   * printing out the opcode and size
                 
                 CLR.L D0
                 
                 MOVE.B #14, D0
                 
                 TRAP #15
                 
                 LEA SIZE_W_PRINT, A1
                 
                 TRAP #15               * done printing opcode and size
                    
                 BRA DONE
              

MOVEL            CLR.L D0
                 
                 CLR.L D1
                 
                 MOVE.W #example,D0
                 
                 LSL.W #7,D0
                 
                 MOVE.B #13,D1
                 
                 LSR.W D1,D0
                 
                 CMP.B #1,D0            *check to see if the mode of the destination is equal to 1
                 
                 BEQ MOVEAL             *if the mode is 1, then it is an address register, and the opcode is MOVEA
                 
                 LEA MOVE_MESSAGE, A1   * printing out opcode and size
                 
                 CLR.L D0
                 
                 MOVE.B #14, D0
                 
                 TRAP #15
                 
                 LEA SIZE_L_PRINT, A1
                 
                 TRAP #15               * done printing opcode and size
                 
                 BRA DONE
                 
                 
MOVEAW           LEA MOVEA_MESSAGE, A1  * start printing out opcode and size

                 CLR.L D0
                 
                 MOVE.B #14, D0
                 
                 TRAP #15
                 
                 LEA SIZE_W_PRINT, A1
                 
                 TRAP #15               * done printing out opcode and size
                 
                 BRA DONE

MOVEAL           LEA MOVEA_MESSAGE, A1  * start printing out opcode and size

                 CLR.L D0
                 
                 MOVE.B #14, D0
                 
                 TRAP #15
                 
                 LEA SIZE_L_PRINT, A1
                 
                 TRAP #15               * done printing out opcode and size
                 
                 BRA DONE               
            

            *INCLUDE 'MESSAGE_Data.X68'
            INCLUDE 'JUMPTABLE EA.X68'
               END   $400 







*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
