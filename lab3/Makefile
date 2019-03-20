main: main.o
	gcc -m32  -g main.c sort.c compare.s -o main

profiler: main.o
	gcc -m32  -g main.c sort.c compare.s -o main -pg

o0: main.o
	gcc -m32 -o0 -g main.c sort.c compare.s -o main
o1: main.o
	 gcc -m32 -o1  -g main.c sort.c compare.s -o main
o2: main.o
	gcc  -m32 -o2 -g main.c sort.c compare.s -o main
o3: main.o 
	gcc  -m32 -o3 -g main.c sort.c compare.s -o main
o4: main.o 
	gcc -m32  -o4 -g main.c sort.c compare.s -o main
os: main.o
	gcc -m32  -oS -g main.c sort.c compare.s -o main


clean:
	rm main.o main
test10:
	cat 10.bin | ./main | hexdump -e '4/1 "%02x " "\n" '
test10_time:
	cat 10.bin | ./main -t
test1000_time:
	cat 1000.bin | ./main -t
