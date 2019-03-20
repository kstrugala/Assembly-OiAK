#include <iostream>
#include <vector>
#include <x86intrin.h>

using namespace std;

void measure_memory(unsigned size);

const int RowMajor = 1;
const int ColumnMajor = 2;

template <class T>
class Matrix
{
  private:
    vector<T> data; 
    unsigned N = 100;

  public:
    Matrix(const unsigned n)
    {
      N = n;
      data.resize(N*N);
    }

    unsigned sizeT()
    {
      return data.size();
    }

    unsigned size()
    {
      return sizeof(T) * data.capacity();
    }

    T item(unsigned i, unsigned j)
    {
      return data.at(i*N + j);
    }

    unsigned countZeroElements(int order)
    {
      unsigned i, j; 
      unsigned count = 0;

      if (order == RowMajor)
      {
        for(i=0; i<N; i++)
          for(j=0; j<N; j++)
            if (data.at(i*N + j) == 0)
              count++;
      }
      else
      {
        for(i=0; i<N; i++)
          for(j=0; j<N; j++)
            if (data.at(j*N + i) == 0)
              count++;
      }
      return count;
    }

    unsigned inc(int order, int jump)
    {
      unsigned i, j; 
      unsigned count = 0;

      if (order == RowMajor)
      {
        for(i=0; i<N; i++)
          for(j=0; j<N; j++)
            if (i*N+jump*j <N*N && data.at(i*N*jump + j) == 0)
              count++;
      }
      else
      {
        for(i=0; i<N; i++)
          for(j=0; j<N; j++)
            if (j*N*jump + i < N*N && data.at(j*N*jump + i) == 0)
              count++;
      }
      return count;
    }


};

/*
 * compile: g++ -m32 prog.c -o prog
 * run: ./prog 
 */
int main(int argc, char * argv[])
{

  unsigned side = 1;

  try {
    for (side = 1; side < 10000; side=side*2)
    {
      measure_memory(side);
    }
  }
  catch (exception const &ex) {
    cerr << "Exception: " << ex.what() << endl;
    return -1;
  }
  return 0;
}

void measure_memory(unsigned side)
{
  unsigned zero_count;
  unsigned dummy;
  unsigned long long int start, time;

  Matrix<int> intMatrix(side);


  cout << "Measuring read time of Matrix of size (of bytes)" << intMatrix.size() << endl;
  start = __rdtscp(&dummy);
//  zero_count = intMatrix.countZeroElements(ColumnMajor);
  zero_count = intMatrix.inc(ColumnMajor, 1);  
  time = __rdtscp(&dummy) - start;
  cout << "ColumnMajor: time elapsed: " << time << endl;
  cout << "Czas/element (kolumny): " << time/intMatrix.sizeT() << endl; 

  start = __rdtscp(&dummy);
//  zero_count = intMatrix.countZeroElements(RowMajor);
  zero_count = intMatrix.inc(ColumnMajor, 1);    
  time = __rdtscp(&dummy) - start;
  cout << "RowMajor: time elapsed: " <<  time << endl; 
  cout << "Czas/element (wiersze): " << time/intMatrix.sizeT() << endl; 

  cout << endl;

}
