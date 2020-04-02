/*
    THIS IS JUST AN EXAMPLE TO USE AS A "HELLO WORLD", DELETE THIS FILE WHEN 
    YOU ARE SATISFIED THAT EVERYTHING WORKS!
*/

/*
--|----------------------------------------------------------------------------|
--| PUBLIC DEFINES
--|----------------------------------------------------------------------------|
*/

.equ        STD_OUT,        1   /* symbolic constant for stdout */
.equ        SYSCALL_WRITE,  4   /* symbolic constant for syscall to write */
.equ        DO_INTERRUPT,   0   /* symbolic constant for software interrupt */
       
.text

/*
--|----------------------------------------------------------------------------|
--| PUBLIC SUBROUTINES
--|----------------------------------------------------------------------------|
*/

/*------------------------------------------------------------------------------
Subroutine Name:
    printj

Function Description:
    prints a given string of a given length to the terminal.

Parameters:
    r0: the string to print.
    r1: the length of the string.

Returns:
    None

Assumptions/Limitations:
    Assumes that the given string is at least as long as the given length.
    

Equivalent c-function signature:
    void printj(char * str, int str_len);
------------------------------------------------------------------------------*/
.global printj
printj:
            push        {lr}

            /* create symbolic names for the registers used */
            ostream     .req        r0
            buff_addr   .req        r1
            msg_size    .req        r2
            sys_call    .req        r7

            mov         msg_size,   r1 /* len was passed in r1*/
            mov         buff_addr,  r0 /* buffer was passed in r0*/

            mov         ostream,    #STD_OUT
            mov         sys_call,   #SYSCALL_WRITE

            swi         DO_INTERRUPT

            /* forget symbolic names */
            .unreq      ostream
            .unreq      buff_addr
            .unreq      msg_size
            .unreq      sys_call

            pop         {pc}
