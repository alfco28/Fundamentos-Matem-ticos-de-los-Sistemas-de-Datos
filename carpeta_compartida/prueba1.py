
import sys

def main(argumentos):
    print(argumentos)    
    lnumeros=argumentos[1:]
    try:
        lnumeros=[int(x) for x in lnumeros]
        print(sum(lnumeros))
    except Exception as error:
        print(error)

if __name__=='__main__':
    main(sys.argv)
