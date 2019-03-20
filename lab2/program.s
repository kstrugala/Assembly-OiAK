SYS_EXIT	= 1
SYS_WRITE 	= 4
SYS_READ	= 3
STDIN		= 0
STDOUT		= 1
EXIT_SUCCESS	= 0

buffSize	= 65538

.data


.bss
   .comm input , buffSize
   .comm input_size, buffSize
   .comm number, buffSize
   .comm result, buffSize
.text
   .global _start

_start:
   # Read from STDIN to input
   movl $SYS_READ, %eax
   movl $STDIN, %ebx
   movl $input, %ecx
   movl $buffSize, %edx
   int $0x80

   # Save input size
   movl %eax, input_size

ret_dim:
   # %edi - index
   movl $0,  %edi
   # Get n, m from input
   # n - %al

   #Move 0 to eax
   movl $0, %eax

   movb input(,%edi,1), %al # Move n to al

   incl %edi # <- edi=1

   # m - %ah
   movb input(,%edi,1), %ah # Move m to ah

   incl %edi # <- edi=2 # Begin of first number


# First number
   movb %ah, %bl # move size of number to bl
   movl $0, %ecx # clear ecx
   movl $0, %esi # clear esi
# Insert first number into result variable
first_num_loop:
   movb input(, %edi, 1), %cl
   movb %cl, result(, %esi,1)
   incl %edi
   incl %esi
   decb %bl
   cmp $0, %bl
   jnz first_num_loop


   movl $0, %edx
   movb $0, %dl # iterator (current number)


all_num_loop:
   incb %dl
   movb %ah, %bl # move size of number to bl
  
   movl $0, %ecx # clear ecx
   movl $0, %esi # clear esi
    
 
   # Insert number into number variable
   loop:
      movb input(, %edi, 1), %cl
      movb %cl, number(, %esi,1) 
      incl %edi
      incl %esi
      decb %bl
      cmp $0, %bl 
      jnz loop

   # Addition
   # Prepare for addition
   prep_for_add:
   clc # clear carry flag 

   /*
	cl - byte from number
	ch - byte from result
   */
   movl $0, %ecx # Clear ecx
   movb %ah, %bl # move size of number to bl
  
   movl $0, %esi # Clear iterator
# Addition loop 
   
   movb result(, %esi, 1), %ch
   movb number(, %esi, 1), %cl   
   
   add %cl, %ch
   pushf
   movb %ch, result(, %esi, 1)
   movl $0, %ecx
   incl %esi
   decb %bl
  
   add_loop:
      movb result(, %esi, 1), %ch
      movb number(, %esi, 1), %cl 
      popf
      adc %cl, %ch
      pushf
      movb %ch, result(, %esi, 1)
      movl $0, %ecx
      incl %esi
      decb %bl
      cmp $0, %bl
      jnz add_loop


# End of all_num_loop (check condition (current number < n) )
all_num_loop_e:
   cmp %al, %dl
   jl all_num_loop


write_n:
# Write result
   movl $0, %edx
   movb %ah, %dl 
   movl $SYS_WRITE, %eax
   movl $STDOUT, %ebx
   movl $result, %ecx
   int $0x80

/*
write:
   # Write data
   movl input_size, %edx
   movl $SYS_WRITE, %eax
   movl $STDOUT, %ebx
   movl $input, %ecx
   int $0x80
*/
   # Close program
close:
   mov $SYS_EXIT, %eax
   mov $EXIT_SUCCESS, %ebx
   int $0x80

