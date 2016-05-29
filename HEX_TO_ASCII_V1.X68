*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    *ORG    $5000

* put your data that you want printed into D5
*START 

HEX_TO_ASCII      
     CLR.L      D3
    
     *MOVE.L     #$ABCDEF, D5
     
LOOP    
     MOVE.L     D5, D6                  * put the data in a register so we can manipulate it
     
     CLR.L      D2
     
     MOVE.B     #28, D2

     LSR.L      D2, D6                  * shift out everything to the right of the last nibble, we print backwards so it shows up the correct order in the console
     
     CMP.B      #10, D6
     
     BGE        LETTER                  * determine if a letter or a number
     
     BRA        NUMBER
     
LETTER
     ADD.B      #55, D6
     
     MOVE.B     D6, D1                  * add the amount to change to ascii and move to D1 to prepare for printing
     
     BRA        PRINTOUT_NIBBLE

NUMBER     
     ADD.B      #48, D6
     
     MOVE.B     D6, D1                  * add the amount to change to ascii and move to D1 to prepare for printing
     
     BRA        PRINTOUT_NIBBLE


PRINTOUT_NIBBLE
    LSL.L      #4, D5                   * shift out the nibble you just read from the source
    
    CMP.B      #$30, D6

    BEQ        LOOP             
    
    MOVE.B     #6, D0                      * use TRAP task #6 to print a single character from D1  
    
    TRAP #15
    
    ADD.B      #1, D3                   * add to the counter in D3
     
    CMP.B      #8, D3                   * compare to the counter to check if you are done
     
    BEQ        DONE
        
    BRA LOOP                            * continue the loop and print next nibble
     
          
*DONE

* Put program code here

    *SIMHALT             ; halt simulator

* Put variables and constants here

    *END    START       ; last line of source




*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
