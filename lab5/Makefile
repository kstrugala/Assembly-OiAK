test: prog.c rdtsc.s integral_sse.s
	gcc -m32 prog.c rdtsc.s integral_asm.s integral_sse_float.s  integral_sse_double.s -lm -o prog
	./prog 0.001 1000 100000
