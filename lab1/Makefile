program: program.o
	ld -melf_i386 program.o -o program
program.o: program.s
	as --32 -o program.o program.s
clean:
	rm program.o program
