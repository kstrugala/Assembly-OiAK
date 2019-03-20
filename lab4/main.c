#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>


uint16_t get_fpu();
void set_fpu(uint16_t ctrWrd);

double integrate(double a, double b, int n);

void set_PC(int PC)
{
   printf("\n************** SET PC *****************\n");
   uint16_t ctrlWrd = get_fpu();
   printf(" OLD CONTROL WORD: 0x%04X \n", ctrlWrd);
   
   if(PC ==0 ||PC == 2 || PC == 3)
   {
       // Clear  8-9
      ctrlWrd = ctrlWrd & 64767; // AND $0xFCFF, ctrlWrd (0xFCFF - 1111 1100 1111 1111) - SINGLE PRECISION
   }
   if(PC == 0)
   {
      printf(" MODE: SINGLE PRECISION\n");
   }
   else if(PC == 2)
   {
      printf(" MODE: DOUBLE PRECISION\n");
      ctrlWrd = ctrlWrd | 512; // AND $0x200, ctrlWrd (0x200 - 0000 0010 0000 0000) - DOUBLE PRECISION
   }
   else if(PC == 3)
   {
      printf(" MODE: EXTENDED DOUBLE PRECISION\n");
      ctrlWrd = ctrlWrd | 768; // AND $0x300 , ctrlWrd (0x300 - 0000 0011 0000 0000) - EXTENDED DOUBLE PRECISION
  }
   // Set   
   set_fpu(ctrlWrd);
   // Check
   ctrlWrd = get_fpu();
   printf(" NEW CONTROL WORD: 0x%04X \n", ctrlWrd);

   printf("\n***************************************\n");

}
void set_RC(int RC)
{
   printf("\n************** SET RC *****************\n");
   uint16_t ctrlWrd = get_fpu();
   printf(" OLD CONTROL WORD: 0x%04X \n", ctrlWrd);
   if(RC == 0 || RC== 1 || RC == 2 || RC == 3)
   {
      // Clear  10-11
      ctrlWrd = ctrlWrd & 62463; // AND $0xF3FF, ctrlWrd (0xF3FF - 1111 0011 1111 1111) - ROUND TO NEAREST
   }
   if(RC == 0)
   {
      printf(" MODE: ROUND TO NEAREST (EVEN)\n");
   }
   if(RC == 1)
   {
      printf(" MODE: ROUND DOWN (-INF)\n");
      ctrlWrd = ctrlWrd | 1024; // AND $0x400, ctrlWrd (0x400 - 0000 0100 0000 0000)
   }
   else if(RC == 2)
   {
      printf(" MODE: ROUND UP (+INF)\n");
      ctrlWrd = ctrlWrd | 2048; // AND $0x800, ctrlWrd (0x200 - 0000 1000 0000 0000)
   }
   else if(RC == 3)
   {
      printf(" MODE: ROUND TOWARD ZERO (TRUNCATE)\n");
      ctrlWrd = ctrlWrd | 3072; // AND $0xC00 , ctrlWrd (0x300 - 0000 1100 0000 0000)
  }
   // Set   
   set_fpu(ctrlWrd);
   // Check
   ctrlWrd = get_fpu();
   printf(" NEW CONTROL WORD: 0x%04X \n", ctrlWrd);

   printf("\n***************************************\n");
}

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
   double a, b, result;
   int n, i, j;
   if(argc > 3)
   {
      a = atof(argv[1]);
      b = atof(argv[2]);
      n = atoi(argv[3]);
   }
   else
   {  
      printf("Za mała ilość parametrów wejściowych\n  Program wywołujemy z parametrami: \n    ./main a b n\n");
      return 0;  
   }
   
   
   for(i=0; i <= 3; i++)
     if(i!=1)
     {
        set_PC(i);
        for(j=0; j <= 3; j++)
        {
           set_RC(j);
           start = tm();
           result = integrate(a, b, n);
           end = tm();     
           printf("\n result = %.54F\n time=%llu\n", result, end-start);
        }
      }
   return 0;
}
