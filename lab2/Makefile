program: program.o
	ld -melf_i386 program.o -o program
program.o: program.s
	as --32 -o program.o program.s
clean:
	rm program.o program

test-small:
	cat nmdane.small.bin | ./program | hexdump -e '16/1 "%02x " "\n" '
test:
	cat nmdane.bin | ./program | hexdump -e '16/1 "%02x " "\n" '	
test-big:
	cat nmdane.big.bin | ./program | hexdump -e '16/1 "%02x " "\n" '    

showData-small:
	cat nmdane.small.bin | hexdump -e '16/1 "%02x " "\n" '
showData:
	 cat nmdane.bin | hexdump -e '16/1 "%02x " "\n" '
showData-big:
	cat nmdane.big.bin | hexdump -e '16/1 "%02x " "\n" '

