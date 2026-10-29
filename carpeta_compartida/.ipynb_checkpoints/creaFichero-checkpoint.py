

import json
import sys
from random import randint

def main(argumentos):
    try:
        nnumeros=int(argumentos[1])
        nfichero=argumentos[2]
    except Exception as error:
        print(f"Error --> {error}")
        print("Has de decir cuantos números quieres y el nombre del fichero.")
        return     
    
    listaAleatorios=[randint(0,99) for i in range(nnumeros)]

    with open(nfichero,'w') as f:
        json.dump(listaAleatorios,f)
        
if __name__=='__main__':
    main(sys.argv)

