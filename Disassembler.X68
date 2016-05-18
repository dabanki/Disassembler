*-----------------------------------------------------------
* Title      : Disassembler
* Written by : Ko Fukushima, Daminan Banki, , Samuel Williams
* Date       : 5/12/2016
* Description: It's not your fault
*-----------------------------------------------------------

        ORG    $1000
START:      	* ORG and END address

* ORG the program so that it straddles the address boundary $00007FFF to $00008000

        INCLUDE 'test.X68'
        INCLUDE 'INPUT.X68'
        INCLUDE 'GROUP_OP_CODE.X68'
        INCLUDE 'ADDI.X68'
    
* Put program code here
        INCLUDE 'EQU_Data.X68'
        INCLUDE 'MESSAGE_Data.X68' 
    
        SIMHALT             ; halt simulator
    
        INCLUDE 'DS_Data.X68'

* Put variables and constants here

        END    START        ; last line of source











*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
