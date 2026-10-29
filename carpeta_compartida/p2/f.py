# coding: utf-8
#import sys
#sys.setrecursionlimit(1000)
def factorial(n):
    if n==0:
        return 1
    else:
        return factorial(n-1)*n
print( factorial(100) )
