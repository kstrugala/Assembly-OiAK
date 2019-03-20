.global	get_fpu
  .type	get_fpu, @function
get_fpu:
	pushl   %ebp
	movl	%esp, %ebp
	fstcw	-8(%ebp)
        movw    -8(%ebp), %ax
	popl	%ebp
	ret

