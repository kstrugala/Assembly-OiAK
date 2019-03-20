#!/usr/bin/env python

from struct import pack
from random import randint

def genrand(name, n):
    with open(name, 'wb') as f:
        f.write(pack('I', n))
        for i in xrange(n):
            f.write(pack('I', randint(0,2**32-1)))


genrand('10.bin', 10)
genrand('100.bin', 100)
genrand('1000.bin', 1000)
genrand('1000000.bin', 1000000)
