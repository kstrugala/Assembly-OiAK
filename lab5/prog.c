#include <stdio.h>
#include <stdlib.h>
#include <math.h>
unsigned long long int rdtsc(void);

double integral_sse_double(double from, double to, unsigned steps);
double integral_sse_float(double from, double to, unsigned steps);
double integral_c(double from, double to, unsigned steps);
double integral_asm(double from, double to, unsigned steps);


void eval_integral_function(double (*fun)(double, double, unsigned), double, double, unsigned);

/*
 * compile: gcc -m32 prog.c rdtsc.s -o prog
 * run: ./prog 0.001 1000 10000
 */
int main(int argc, char * argv[])
{
  if(argc > 3)
  {
    double from, to;
    unsigned int steps;

    from = atof(argv[1]);
    to = atof(argv[2]);
    steps = atof(argv[3]);
    printf("Evaluating functions with params: from: %f to: %f in %u steps\n", from, to, steps);
   
    
    printf("Funkcja C:\n	");
    eval_integral_function(&integral_c, from, to, steps);
    printf("Funkcja ASM:\n	");
    eval_integral_function(&integral_asm, from, to, steps);
    printf("Funkcja SSE2:\n	");
    eval_integral_function(&integral_sse_double, from, to, steps);
    printf("Funkcja SSE4:\n	");
    eval_integral_function(&integral_sse_float, from, to, steps);
   }
   else
     printf("Za mała ilość parametrów wejściowych\n");


    return 0;
}


double integral_c(double from, double to, unsigned steps)
{
    // substitute with real funtion body that calculates the integral
    // return from * to * (double) steps;
    double result=0;
    double h = (to-from)/steps;
    int i;    
    for(i=1; i<=steps; i++)    
    {
       result += cos(from+i*h)*h;
    }
    // Cos checker
    //result = cos(a);
    return result;
}

void eval_integral_function(double (*fun)(double, double, unsigned), double from, double to, unsigned steps)
{

    unsigned long long int start, time;
    double result;

    start = rdtsc();
    result = fun(from, to, steps);
    time = rdtsc() - start;
    printf("Result: %f, time elapsed: %llu \n", result, time);

}
