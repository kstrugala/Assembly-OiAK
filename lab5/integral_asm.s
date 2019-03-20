.data
   h:
      .double 0.0
   from:   
      .double 0.0
   to:   
      .double 0.0
   steps:
      .double 0.0
   i:
      .double 1.0	
   result:
      .double 0.0
   clean:
      .double 0.0

.globl integral_asm
.type integral_asm, @function


# double integral_asm(double from, double to, unsigned n)
integral_asm:
  pushl %ebp # save old base pointer
  movl %esp, %ebp  # make stack pointer the base pointer
  subl  $8, %esp
 
  fildl 24(%ebp) # Load to ST(0) n 
  fldl 16(%ebp) # Load to ST(0) (double to), ST(1) -> steps 
  fldl 8(%ebp) # Load to ST(0) (double from), double to -> ST(1), ST(2) -> steps 
  # h=(to-from)/steps;     
p:
  fsubr %st(1), %st(0) #(to - from)
  fdiv %st(2), %st(0) # / steps; ST(0) <-h  ST(1) <- to ST(2) <-steps
  fldl 8(%ebp) # Load to ST(0)-> from ST(1) <-h  ST(2) <- to ST(3) <-steps

  fstpl from
  fstpl h
  fstpl to
  fstpl steps

  mov $1, %edi # i=0
  movl 24(%ebp), %eax # steps
   
 
loop:
   fldl i # ST(0) <- i
   fldl h # ST(0) <- h , ST(1) <- i
   fmulp %st(0), %st(1) # i*h
   fldl from  # ST(0) <- from , ST(1) <- i*h
   faddp %st(0), %st(1)  # ST(0) <- from+i*h
   fcos   # ST(0) <- cos(from+i*h)
   fldl h #  ST(0) <- h   ST(1) <- cos(from+i*h)
   fmulp %st(0), %st(1) # ST(0) <- cos(from+i*h)*h
   fldl result  
   faddp %st(0), %st(1)
   fstpl result

   fldl i # ST(0) <- i (from memory)
   fld1 # Load 1 to ST(0)
   faddp # i+=1
   fstpl i
   incl %edi

   cmp %eax, %edi
   jle loop
   
   fldl result  # Load result to ST(0)

 # movl %ebp, %esp  # restore the stack pointer
 # popl %ebp #restore the base pointer
  leave
  ret

