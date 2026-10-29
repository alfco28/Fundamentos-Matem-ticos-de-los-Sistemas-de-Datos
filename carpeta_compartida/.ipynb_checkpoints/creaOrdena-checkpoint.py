

import sys
import creaFichero
from ordenaFichero import main as mainOrdenaFichero

def main(argumentos):
    try:
        accion=argumentos[1]
        args=["_"]+argumentos[2:]
    except Exception as error:
        print(f"Error --> {error}")
        print("Ayuda:\n$> python creaOrdena.py --crear 5 a.txt\n$> python creaOrdena.py --ordena a.txt b.txt")
        return
    if accion=='--crear':
        creaFichero.main( args )
    elif accion=='--ordena':
        mainOrdenaFichero( args )
    else:
        print("Ayuda:\n$> python creaOrdena.py --crear 5 a.txt\n$> python creaOrdena.py --ordena a.txt b.txt")
    

if __name__=='__main__':
    main(sys.argv)