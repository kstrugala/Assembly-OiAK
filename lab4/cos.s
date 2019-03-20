.data
   result:	
      .double 0.0
.type cos, @function
.global cos
cos:
  pushl %ebp # save old base pointer
  movl %esp, %ebp  # make stack pointer the base pointer
  
  fldl 8(%ebp) # Load to ST(0) (double x) 
  fcos # Compute cos(ST(0)) -> ST(0)
  fstl result # Store result
   
  movl result, %eax
 
  movl %ebp, %esp  # restore the stack pointer
  popl %ebp #restore the base pointer
  ret

