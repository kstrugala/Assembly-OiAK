#include <stdio.h>
#include <unistd.h>
#include <string.h>

void asc_sort(unsigned int , unsigned int *);
void test_asc_sort();

int tab[100000000];
int num[100000000];
unsigned int n;
int i=1;


// Time measurement
unsigned long long start;
unsigned long long end;

unsigned long long  tm()
{
   unsigned hi, lo;
   asm volatile ("rdtsc" : "=a" (lo), "=d" (hi));

   return (((unsigned long long) hi) << 32) | ((unsigned long long) lo) ;
}

int main(int argc, char *argv[])
{   
   // Read from file
   read(0, tab, 100000001*4);
   n=tab[0];

  
   // Before sort
   for(; i <= n; i++)
   {
	num[i-1] = tab[i];
   }
/*
   for(i=0; i < n; i++)
      printf("%d\n", num[i]);

*/
   // Sort
   start=tm(); 
   asc_sort(n, num);
   end=tm();
   if(argc==1)
   {
     	 write(1, &n, 4); // Number count
         write(1, num, n*4); // Sorted numbers

   }
/*
   // After sort
   printf("\n\nPo posortowaniu:\n\n");
   
   for(i=0; i < n; i++)
      printf("%d\n", num[i]);
*/

   if(argc==2)
   {
      if(strcmp(argv[1], "-t") == 0 || strcmp(argv[1], "--time") == 0)
      {
   	printf("POMIAR CZASU:\n\n");
   	printf("   START: %llu\n", start);
   	printf("   KONIEC: %llu\n", end);
   	printf("   CZAS (KONIEC -  START): %llu\n\n", end-start);
      }
   }
   return 0;
}
