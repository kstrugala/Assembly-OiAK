.data
zeros:
   .float 0.0, 0.0, 0.0,  0.0
fours:
   .float 4.0, 4.0, 4.0, 4.0
i:
   .float 1.0, 2.0, 3.0, 4.0

fhh:
   .float 0.0
fhl:
   .float 0.0
flh:
   .float 0.0
fll:
   .float 0.0

.global integral_sse_float
.type integral_sse_float, @function

# double integral_sse_float(double from, double to, unsigned n)


integral_sse_float:
  pushl %ebp
  movl  %esp, %ebp
  subl  $8, %esp 

  movups zeros, %xmm6
 
  movsd 8(%ebp), %xmm0    # double from
  movsd 16(%ebp), %xmm1   # double to
  movl  24(%ebp), %eax    # unsigned n
  cvtsi2sdl %eax, %xmm2   
  
  # h = (tofrom)/steps;
  subsd %xmm0, %xmm1  # (to-from) 
  divsd %xmm2, %xmm1  # / steps
 
  # From
  unpcklpd   %xmm0, %xmm0 # xmm0: | from | from |
  cvtpd2ps   %xmm0, %xmm0 # xmm0: | from | from | 0 | 0 | (convert packed double-precision floating-point values
                          #                         to packed single-precision floating-point values) 
  punpcklqdq %xmm0, %xmm0 # xmm0: | from | from | from | from | (Unpack low quadwords)
  
  # h
  unpcklpd   %xmm1, %xmm1 # xmm1: | h | h |
  cvtpd2ps   %xmm1, %xmm1 # xmm1: | h | h | 0 | 0 | (convert packed double-precision floating-point values
                          #                         to packed single-precision floating-point values) 
  punpcklqdq %xmm1, %xmm1 # xmm1: | h | h | h | h | (Unpack low quadwords)

  # i
  movups i, %xmm3
  # fours
  movups fours, %xmm4
  
  # result - xmm6
  # iresult - xmm5
   
loop:
  movups %xmm3, %xmm5 # iresult = i
  mulps %xmm1, %xmm5  # iresult = i*h
  addps %xmm0, %xmm5  # iresult = from+i*h
  # Cos
 
  movups %xmm5, fhh

  flds fhh
  fcos
  fstps fhh
  flds fhl
  fcos
  fstps fhl
  flds flh
  fcos
  fstps flh
  fld fll
  fcos
  fstps fll

  movups fhh, %xmm5

  mulps %xmm1, %xmm5 # iresult = cos * h
  addps %xmm5, %xmm6 # result += iresult

  addps %xmm4, %xmm3 # iterators ++
  subl $4, %eax
  cmp $0, %eax
  jg loop

p:
  haddps %xmm6, %xmm6
  haddps %xmm6, %xmm6
   
  cvtps2pd %xmm6, %xmm6  # convert packed single-precision floating-point values 
                         # to packed double-precision floating-point values
  movhpd %xmm6, -8(%ebp)
  fldl  -8(%ebp)
   
  leave
  ret
