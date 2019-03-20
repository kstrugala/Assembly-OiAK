/* sortowanie liczb naturalnych 4 bajtowych
 */

#include <assert.h>
#include <stdio.h>

int C_compare(int, int);
int compare(int, int);

void asc_sort(unsigned int n, unsigned int * numbers)
{
    unsigned int i = 0;
    unsigned int j = 0;
    unsigned int temp = 0;
    for (i = n-1; i > 0; i--)
    {
        for (j = 0; j < i; j++)
        {
           // if (numbers[j] > numbers[j+1])
            if(compare(numbers[j],  numbers[j+1]))
	    {
                temp = numbers[j];
                numbers[j] = numbers[j+1];
                numbers[j+1] = temp;
            }
        }
    }
}

void test_asc_sort()
{
   int i, j;
   unsigned int n1 = 10;
   unsigned int t1[10] = {10, 11, 0, 4, 5, 3, 12, 12, 99, 1};
   unsigned int r1[10] = {0, 1, 3, 4, 5, 10, 11, 12, 12, 99};
   unsigned int n2 = 5;
   unsigned int t2[10] = {10, 12, 100, 99, 1};
   unsigned int r2[10] = {1, 10, 12, 99, 100};


   asc_sort(n1, t1);
   asc_sort(n2, t2);

   for(i = 0; i < n1; i++)
       if (t1[i] != r1[i])
           printf("%d != %d \n", t1[i], r1[i]);

   for(j = 0; j < n2; j++)
       if (t2[j] != r2[j])
           printf("%d != %d \n", t1[j], r1[j]);

}
