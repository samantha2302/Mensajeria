import pywhatkit
from datetime import datetime
from os import remove
import time

def checkFileExistance(filePath):
    try:
        with open(filePath, 'r') as f:
            return True
    except FileNotFoundError as e:
        return False
    except IOError as e:
        return False

def mensajeria():
    def ObtenerNumero():
        file = open("C:/emu8086/MyBuild/numero.txt", "r")
        fila = file.read()
        file.close()
        return fila

    def ObtenerMensaje():
        file = open("C:/emu8086/MyBuild/mensaje.txt", "r")
        filas = file.read()
        file.close()
        return filas

    now = datetime.now()
    hora = now.hour
    minutos = now.minute + 1

    print(hora, minutos)
    numero=ObtenerNumero()
    mensaje=ObtenerMensaje()
    mensaje2=""
    for i in mensaje:
        if ord(i)==0:
            break
        else:
            mensaje2+=i
    print(mensaje2, numero)

    try:
        pywhatkit.sendwhatmsg("+506"+str(numero),mensaje2,hora,minutos)
        print("Mensaje Enviado")
        remove("C:/emu8086/MyBuild/numero.txt")
        remove("C:/emu8086/MyBuild/mensaje.txt")
    except:
        print("Ocurrio Un Error")


while True:
    while (checkFileExistance("C:/emu8086/MyBuild/mensaje.txt") == False): #mientras no exista se duerme
        time.sleep(1)
    time.sleep(2)

    mensajeria()