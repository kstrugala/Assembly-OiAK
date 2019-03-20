.data
zeros:
   .double 0.0, 0.0
twos:
   .double 2.0, 2.0
i:
   .double 1.0, 2.0

fh:
   .double 0.0
fl:
   .double 0.0


.global integral_sse_double
.type integral_sse_double, @function

# double integral_sse_double(double from, double to, unsigned n)


integral_sse_double:
  pushl %ebp
  movl  %esp, %ebp
  subl  $8, %esp
  
  movupd zeros, %xmm6
  movsd 8(%ebp), %xmm0    # double from
  movsd 16(%ebp), %xmm1   # double to
  movl  24(%ebp), %eax    # unsigned n
  cvtsi2sdl %eax, %xmm2   
  
  # h = (tofrom)/steps;
  
  subsd %xmm0, %xmm1  # (to-from) 
  divsd %xmm2, %xmm1  # / steps
 
  unpcklpd %xmm1, %xmm1 # xmm1: | h | h |
  movupd i, %xmm3       # xmm3: | 2 | 1 | 
  unpcklpd %xmm0, %xmm0 # xmm0: | from | from |
  movupd twos, %xmm4
 
  # result - xmm6
  # iresult - xmm5
loop:
  movupd %xmm3, %xmm5 # iresult = i
  mulpd %xmm1, %xmm5  # iresult = i*h
  addpd %xmm0, %xmm5  # iresult = from+i*h
  
  # Cos

  movupd %xmm5, fh
  fldl fh
  fcos
  fstpl fh
  fldl fl
  fcos
  fstpl fl
  movupd fh, %xmm5

  mulpd %xmm1, %xmm5 # iresult = cos * h
  addpd %xmm5, %xmm6 # result += iresult
  
  addpd %xmm4, %xmm3 # iterators ++
  subl $2, %eax
  cmp $0, %eax
  jnz loop

  # Add results from xmm6
  
  haddpd %xmm6, %xmm6    

  movlpd %xmm6, -8(%ebp)
  fldl  -8(%ebp)
   
  leave
  ret
