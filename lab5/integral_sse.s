.file "integral_sse.s"
.text
.globl integral_sse
.type integral_sse, @function

twoones:
  .double 1.0, 1.0

# double integral_sse(double from, double to, unsigned n)
# return 4 * from * to * (double) n
integral_sse:
  pushl %ebp
  movl  %esp, %ebp
  subl  $8, %esp

  movsd twoones, %xmm0
  movsd 8(%ebp), %xmm1
  movsd 16(%ebp), %xmm2
  movl  24(%ebp), %eax
  cvtsi2sdl %eax, %xmm3

  haddpd %xmm0, %xmm0
  haddpd %xmm0, %xmm0
  haddpd %xmm0, %xmm0

  mulsd %xmm1, %xmm0
  mulsd %xmm2, %xmm0
  mulsd %xmm3, %xmm0

  movsd %xmm0, -8(%ebp)
  fldl  -8(%ebp)

  leave
  ret
