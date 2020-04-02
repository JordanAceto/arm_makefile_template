/*
    THIS IS JUST AN EXAMPLE TO USE AS A "HELLO WORLD", DELETE THIS FILE WHEN 
    YOU ARE SATISFIED THAT EVERYTHING WORKS!
*/

/*
--|----------------------------------------------------------------------------|
--| PUBLIC DEFINES
--|----------------------------------------------------------------------------|
*/

.equ        GREETING_LEN,   13  /* greeting is 13 chars long */
.equ        SYSCALL_EXIT,   1   /* symbolic constant for syscall to exit */
.equ        DO_INTERRUPT,   0   /* symbolic constant for software interrupt */

/*
--|----------------------------------------------------------------------------|
--| MAIN PROGRAM
--|----------------------------------------------------------------------------|
*/
           
.text

.global _start 
_start:     
            /* create symbolic names for the registers used */
            str_param       .req        r0
            str_len         .req        r1

            /* set up the registers and call the subroutine */
            ldr     str_param, =greeting
            mov     str_len, #GREETING_LEN
            bl      printj

            /* forget the symbolic register names */
            .unreq      str_param
            .unreq      str_len

exit:       
            /* return value goes in r0, syscall code goes in r7 */
            retval      .req        r0
            sys_call    .req        r7

            mov         retval,     #0            
            mov         sys_call,   #SYSCALL_EXIT

            /* forget symbolic names for r0 and r7 */
            .unreq      retval
            .unreq      sys_call

            /* end of main program */
            swi         DO_INTERRUPT

/*
--|----------------------------------------------------------------------------|
--| PRIVATE DATA
--|----------------------------------------------------------------------------|
*/

.data

greeting:   .ascii      "Howdee there\n"          
