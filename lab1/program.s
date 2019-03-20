SYS_EXIT	= 1
SYS_WRITE 	= 4
SYS_READ	= 3
STDIN		= 0
STDOUT		= 1
EXIT_SUCCESS	= 0

buffSize	= 2048 

.data
   yes: .ascii "TAK\n"
   yes_len: .long .-yes

   no:  .ascii "NIE\n"
   no_len:  .long .-no


.bss
   .comm input , buffSize
   .comm reversed , buffSize
.text
   .global _start

_start:
   # Read from STDIN to inpuy
   movl $SYS_READ, %eax
   movl $STDIN, %ebx
   movl $input, %ecx
   movl $buffSize, %edx
   int $0x80

   # Prepare for reverse

/*
  %ecx contain lenght of input
  %ebx index for reversed
  %edi index
*/

   decl %eax
   movl %eax, %ebx
   movl %eax, %ecx
   movl $0, %edi

   decl %ebx

loop:
   movb input(, %edi, 1), %al
   movb %al, reversed(, %ebx, 1)

   cmp %edi, %ecx

   incl %edi
   decl %ebx
   jge loop


   # Compare input and reversed

   movl $0, %edi

  # Compare loop
loop_c:
   cmp %edi, %ecx
   je loop_c_e

   movb input(,%edi, 1), %al
   movb reversed(,%edi, 1), %ah

   cmp %ah, %al
   jne w_no

   inc %edi

   jmp loop_c

loop_c_e:
   jmp w_yes

   # Answers

w_no:
   movl $SYS_WRITE, %eax
   movl $STDOUT, %ebx
   movl $no, %ecx
   movl no_len, %edx
   int $0x80

   jmp close

w_yes:
   movl $SYS_WRITE, %eax
   movl $STDOUT, %ebx
   movl $yes, %ecx
   movl yes_len, %edx
   int $0x80


   # Close program
close:
   mov $SYS_EXIT, %eax
   mov $EXIT_SUCCESS, %ebx
   int $0x80

