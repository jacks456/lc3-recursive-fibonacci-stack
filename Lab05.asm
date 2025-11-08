.ORIG x3000

; #~#~#~#~#~#~#~#~#
; =-=-=-=-=-=-=-=-=
; INITIALIZER CODE
; # DO NOT TOUCH #
; - - - - - - - - -
LD R6, STACK_PTR ; load stack pointer
LEA R4, STATIC_STORAGE ; load global vars pointer
ADD R5, R6, #0 ; set frame pointer
; current stack pointer is sitting on main's return slot
; there are no arguments to our main function
JSR MAIN
HALT
; SETUP VARS
STACK_PTR .FILL x6000
STATIC_STORAGE
; - - - - - - - - -
; PUT .FILL GLOBALS HERE
; - - - - - - - - -
; INITIALIZER OVER
; =-=-=-=-=-=-=-=-=
; #~#~#~#~#~#~#~#~#



; #~#~#~#~#~#~#~#~#
; =-=-=-=-=-=-=-=-=
MAIN;(void)

; push return address
ADD R6, R6, #-1
STR R7, R6, #0

; push previous frame pointer
ADD R6, R6, #-1
STR R5, R6, #0

; set current frame pointer
ADD R5, R6, #0

; allocate local variables
; - - - - - - - - -
; #-1: n
; #-2: result
; - - - - - - - - -
ADD R6, R6, #-2
; =-=-=-=-=-=-=-=-=

; CODE GOES HERE
LEA R0, PROMPT
PUTS
GETC
OUT
ADD R0, R0, #-16
ADD R0, R0, #-16
ADD R0, R0, #-16
STR R0, R5, #-1

LDR R0, R5, #-1
ADD R6, R6, #-1
STR R0, R6, #0

JSR FIBONACCI

ADD R6, R6, #1
STR R0, R5, #-2  

LEA R0, FIRST_HALF_RESULT_PROMPT
PUTS

LDR R0, R5, #-1
LD  R1, ASCII_ZERO
ADD R0, R0, R1
OUT

LEA R0, SECOND_HALF_RESULT_PROMPT
PUTS

LDR R2, R5, #-2
ADD R3, R2, #-10
BRn ONE_DIGIT

; two-digit path
AND R1, R1, #0
TEN_LOOP
ADD R3, R2, #-10
BRn TEN_DONE
ADD R2, R2, #-10
ADD R1, R1, #1
BRnzp TEN_LOOP
TEN_DONE
LD  R0, ASCII_ZERO
ADD R0, R0, R1
OUT
LD  R0, ASCII_ZERO
ADD R0, R0, R2
OUT
BRnzp END_PRINT

ONE_DIGIT
LD  R0, ASCII_ZERO
ADD R0, R0, R2
OUT

END_PRINT


; =-=-=-=-=-=-=-=-=
; deallocate local variables
ADD R6, R6, #2

; restore and pop previous frame pointer
LDR R5, R6, #0
ADD R6, R6, #1

; restore and pop return address
LDR R7, R6, #0
ADD R6, R6, #1

; return to caller
RET
PROMPT .STRINGZ "Please enter a number n: "
FIRST_HALF_RESULT_PROMPT .STRINGZ "\nF("
SECOND_HALF_RESULT_PROMPT .STRINGZ ") = "
ASCII_ZERO .FILL x30

FIBONACCI;(int n: #2 )
; =-=-=-=-=-=-=-=-=
; push return address
ADD R6, R6, #-1
STR R7, R6, #0

; push previous frame pointer
ADD R6, R6, #-1
STR R5, R6, #0

; set current frame pointer
ADD R5, R6, #0

; allocate local variables
; - - - - - - - - -
; local variables here
; - - - - - - - - -
ADD R6, R6, #-1
; =-=-=-=-=-=-=-=-=

; CODE GOES HERE


LDR R0, R5, #2
BRnp SKIP_0_BASE_CASE
LD R0, ZERO
BRnzp RETURN
SKIP_0_BASE_CASE

LDR R0, R5, #2
ADD R0, R0, #-1
BRnp SKIP_1_BASE_CASE
LD R0, ONE
BRnzp RETURN
SKIP_1_BASE_CASE

LDR R0, R5, #2
ADD R0, R0, #-1
ADD R6, R6, #-1
STR R0, R6, #0
JSR FIBONACCI
ADD R6, R6, #1

STR R0, R5, #-1

LDR R0, R5, #2
ADD R0, R0, #-2
ADD R6, R6, #-1
STR R0, R6, #0
JSR FIBONACCI
ADD R6, R6, #1

LDR R1, R5, #-1
ADD R0, R0, R1
STR R0, R5, #-1

RETURN
; =-=-=-=-=-=-=-=-=
; deallocate local variables
ADD R6, R6, #1

; restore and pop previous frame pointer
LDR R5, R6, #0
ADD R6, R6, #1

; restore and pop return address
LDR R7, R6, #0
ADD R6, R6, #1

; return to caller
RET
ZERO .FILL #0
ONE  .FILL #1

.END