#include <math.h>

double cos(double x);

double integrate(double a, double b, int n)
{
    
    double result = 0;
    
    double h = (b-a)/n;
    int i;    
    for(i=1; i<=n; i++)    
    {
       result += cos(a+i*h)*h;
    }
    // Cos checker
    //result = cos(a);
    return result;
}

