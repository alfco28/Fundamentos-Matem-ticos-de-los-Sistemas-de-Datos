

import json
import sys

def main(argumentos):
    try:
        nf1=argumentos[1]
        nf2=argumentos[2]
    except Exception as e:
        print(f"Has de decir el fichero fuente y el fichero destino.")
    with open(nf1,"r") as f1:
        lista=json.load(f1)
        #print(f"lista -> {lista};\ntipo de sus elementos -> {type(lista[0])}")
        
    lista.sort()
    #print(lista)

    with open(nf2,"w") as f2:
        json.dump(lista,f2)
    
if __name__=='__main__':
    main(sys.argv)