.type compare, @function
.global compare
compare:
  pushl %ebp # save old base pointer
  movl %esp, %ebp  # make stack pointer the base pointer
  
  movl 8(%ebp), %eax # first argument in EAX
  movl 12(%ebp), %ebx # second argument in EBX
  
  cmp %eax, %ebx
  jl r1
  jmp r0
  r1:
    movl $1, %eax
    jmp after
  r0:
    movl $0, %eax

  after:

  movl %ebp, %esp  # restore the stack pointer
  popl %ebp #restore the base pointer
  ret

