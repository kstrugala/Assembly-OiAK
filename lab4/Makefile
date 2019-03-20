main: main.o
	gcc -m32 -mfpmath=387  main.c integrate.c set_fpu.s get_fpu.s cos.s -o main

clean:
	rm main.o main

