.global set_fpu
  .type set_fpu, @function
set_fpu:
        pushl   %ebp
        movl    %esp, %ebp
        
        fldcw 8(%ebp)
  
        popl    %ebp
        ret

