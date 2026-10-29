# coding: utf-8
import sys
sys.setrecursionlimit(1000)
def factorial(n):
    if n==0:
        return 1
    else:
        return factorial(n-1)*n
x=factorial(500)
print( str(type( x )) + "\n" + str(x))
