

import sys

def factorial(n):
    if n==0:
        return 1
    else: 
        return n*factorial(n-1)

def main(argumentos):
    print(argumentos)
    print(f"Voy a hacer la suma de los números siguientes: {', '.join(argumentos[1:])}")
    
    try:
        print( f"La suma es: {sum( [int(x) for x in argumentos[1:] ] )}" )
    except Exception as error:
        print(f"Hubo un error: {error}")


print("******")

if __name__=='__main__':
    main(sys.argv)