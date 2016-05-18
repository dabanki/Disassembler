*-----------------------------------------------------------
* Title      : ADDI
* Written by : Ko Fukushima
* Date       : 5/15/2016
* Description:
*-----------------------------------------------------------
  
ADDI           * first check the first 4 bits after the op-code
               CLR.L       D0

               CLR.L       D1
               
               MOVE.W      #example, D0
               
               MOVE.B      #8, D1 * for shifting to the right by 8 bits
               
               LSR.W       D1, D0
               
               CMP.W       #6, D0 * checking the first 4 bits 
               
               BNE         ERROR  * go to error 
               
               * second check the size
               CLR.L       D0

               CLR.L       D1
               
               MOVE.W      #example, D0
               
               MOVE.B      #6, D1 * for shifting to the right by 8 bits
               
               LSR.W       D1, D0
               
               CMP.W       #27, D0 * checking the first 4 bits 
               
               BEQ         ERROR  * go to error 
               
               * third check the mode
               CLR.L       D0

               CLR.L       D1
               
               MOVE.W      #example, D0
               
               MOVE.B      #10, D1
               
               LSL.W       D1, D0
               
               MOVE.B      #13, D1
               
               LSR.W       D1, D0
               
               CMP.W       #mode_an, D0
               
               BEQ         ERROR 
               
               CMP.B       #mode_id, D0
               
               BEQ         ADDI_CHECK_ID
               
               BRA         ADDI_PRINTOUT
ADDI_CHECK_ID               
               * check to make sure that the register is not using immediate data
               CLR.L       D0

               CLR.L       D1
               
               MOVE.W      #example, D0
               
               MOVE.B      #10, D1
               
               LSL.W       D1, D0
               
               MOVE.B      #10, D1
               
               LSR.W       D1, D0
               
               CMP.W       #%0000000000111000, D0
               
               BEQ         ADDI_PRINTOUT
               
               CMP.W       #%0000000000111001, D0
               
               BEQ         ADDI_PRINTOUT
               
               BRA         ERROR
               
ADDI_PRINTOUT  * for printing out the ADDI
               CLR.L       D0

               CLR.L       D1
               
               MOVE.W      #example, D1
        
               LEA         SIZE_B_PRINT, A1
               
               MOVE.B      #14, D0
               
               TRAP #15
               
               ROR.W       #6, D1

               CMP.B       #8, D1
               
               * JSR         PRINTOUT_SIZE

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
