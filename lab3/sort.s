	.file	"sort.c"
	.text
.globl asc_sort
	.type	asc_sort, @function
asc_sort:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	movq	%rsp, %rbp
	.cfi_offset 6, -16
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movl	%edi, -20(%rbp)
	movq	%rsi, -32(%rbp)
	movl	$0, -4(%rbp)
	movl	$0, -8(%rbp)
	movl	$0, -12(%rbp)
	movl	-20(%rbp), %eax
	subl	$1, %eax
	movl	%eax, -4(%rbp)
	jmp	.L2
.L6:
	movl	$0, -8(%rbp)
	jmp	.L3
.L5:
	movl	-8(%rbp), %eax
	addl	$1, %eax
	mov	%eax, %eax
	salq	$2, %rax
	addq	-32(%rbp), %rax
	movl	(%rax), %eax
	movl	%eax, %edx
	mov	-8(%rbp), %eax
	salq	$2, %rax
	addq	-32(%rbp), %rax
	movl	(%rax), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	compare
	testl	%eax, %eax
	je	.L4
	mov	-8(%rbp), %eax
	salq	$2, %rax
	addq	-32(%rbp), %rax
	movl	(%rax), %eax
	movl	%eax, -12(%rbp)
	mov	-8(%rbp), %eax
	salq	$2, %rax
	addq	-32(%rbp), %rax
	movl	-8(%rbp), %edx
	addl	$1, %edx
	mov	%edx, %edx
	salq	$2, %rdx
	addq	-32(%rbp), %rdx
	movl	(%rdx), %edx
	movl	%edx, (%rax)
	movl	-8(%rbp), %eax
	addl	$1, %eax
	mov	%eax, %eax
	salq	$2, %rax
	addq	-32(%rbp), %rax
	movl	-12(%rbp), %edx
	movl	%edx, (%rax)
.L4:
	addl	$1, -8(%rbp)
.L3:
	movl	-8(%rbp), %eax
	cmpl	-4(%rbp), %eax
	jb	.L5
	subl	$1, -4(%rbp)
.L2:
	cmpl	$0, -4(%rbp)
	jne	.L6
	leave
	ret
	.cfi_endproc
.LFE0:
	.size	asc_sort, .-asc_sort
	.section	.rodata
.LC0:
	.string	"%d != %d \n"
	.text
.globl test_asc_sort
	.type	test_asc_sort, @function
test_asc_sort:
.LFB1:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	movq	%rsp, %rbp
	.cfi_offset 6, -16
	.cfi_def_cfa_register 6
	subq	$208, %rsp
	movl	$10, -12(%rbp)
	movl	$10, -64(%rbp)
	movl	$11, -60(%rbp)
	movl	$0, -56(%rbp)
	movl	$4, -52(%rbp)
	movl	$5, -48(%rbp)
	movl	$3, -44(%rbp)
	movl	$12, -40(%rbp)
	movl	$12, -36(%rbp)
	movl	$99, -32(%rbp)
	movl	$1, -28(%rbp)
	movl	$0, -112(%rbp)
	movl	$1, -108(%rbp)
	movl	$3, -104(%rbp)
	movl	$4, -100(%rbp)
	movl	$5, -96(%rbp)
	movl	$10, -92(%rbp)
	movl	$11, -88(%rbp)
	movl	$12, -84(%rbp)
	movl	$12, -80(%rbp)
	movl	$99, -76(%rbp)
	movl	$5, -16(%rbp)
	movq	$0, -160(%rbp)
	movq	$0, -152(%rbp)
	movq	$0, -144(%rbp)
	movq	$0, -136(%rbp)
	movq	$0, -128(%rbp)
	movl	$10, -160(%rbp)
	movl	$12, -156(%rbp)
	movl	$100, -152(%rbp)
	movl	$99, -148(%rbp)
	movl	$1, -144(%rbp)
	movq	$0, -208(%rbp)
	movq	$0, -200(%rbp)
	movq	$0, -192(%rbp)
	movq	$0, -184(%rbp)
	movq	$0, -176(%rbp)
	movl	$1, -208(%rbp)
	movl	$10, -204(%rbp)
	movl	$12, -200(%rbp)
	movl	$99, -196(%rbp)
	movl	$100, -192(%rbp)
	leaq	-64(%rbp), %rdx
	movl	-12(%rbp), %eax
	movq	%rdx, %rsi
	movl	%eax, %edi
	call	asc_sort
	leaq	-160(%rbp), %rdx
	movl	-16(%rbp), %eax
	movq	%rdx, %rsi
	movl	%eax, %edi
	call	asc_sort
	movl	$0, -4(%rbp)
	jmp	.L9
.L11:
	movl	-4(%rbp), %eax
	cltq
	movl	-64(%rbp,%rax,4), %edx
	movl	-4(%rbp), %eax
	cltq
	movl	-112(%rbp,%rax,4), %eax
	cmpl	%eax, %edx
	je	.L10
	movl	-4(%rbp), %eax
	cltq
	movl	-112(%rbp,%rax,4), %edx
	movl	-4(%rbp), %eax
	cltq
	movl	-64(%rbp,%rax,4), %ecx
	movl	$.LC0, %eax
	movl	%ecx, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf
.L10:
	addl	$1, -4(%rbp)
.L9:
	movl	-4(%rbp), %eax
	cmpl	-12(%rbp), %eax
	jb	.L11
	movl	$0, -8(%rbp)
	jmp	.L12
.L14:
	movl	-8(%rbp), %eax
	cltq
	movl	-160(%rbp,%rax,4), %edx
	movl	-8(%rbp), %eax
	cltq
	movl	-208(%rbp,%rax,4), %eax
	cmpl	%eax, %edx
	je	.L13
	movl	-8(%rbp), %eax
	cltq
	movl	-112(%rbp,%rax,4), %edx
	movl	-8(%rbp), %eax
	cltq
	movl	-64(%rbp,%rax,4), %ecx
	movl	$.LC0, %eax
	movl	%ecx, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf
.L13:
	addl	$1, -8(%rbp)
.L12:
	movl	-8(%rbp), %eax
	cmpl	-16(%rbp), %eax
	jb	.L14
	leave
	ret
	.cfi_endproc
.LFE1:
	.size	test_asc_sort, .-test_asc_sort
	.ident	"GCC: (Ubuntu 4.4.3-4ubuntu5.1) 4.4.3"
	.section	.note.GNU-stack,"",@progbits
