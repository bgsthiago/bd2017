import random
import string
from random import randint
import psycopg2

conn = psycopg2.connect("dbname=projetoRodoviario user=postgres")

def geradorData():
    dia = randint(1, 30)
    mes = randint(1, 12)
    ano = randint(2015, 2020)
    return (str(ano) + '-' + str(mes) + '-' + str(dia))

def geradorHora():
    h = randint(0,23)
    m = randint(0,59)
    return str(h) + ':' + str(m) + ':00'

def geradorViagem(placa, cidade):
    return '(\'' + geradorData() + '\', \'' + geradorHora() + '\',' + '\'' + placa + '\',' + '\'' + cidade + '\', ' + str(randint(0,48)) + '),\n'

cur = conn.cursor()

cur.execute("SELECT placa from carro")
rows = cur.fetchall()

placas = []

for each in rows:
    placas.append(each[0])

##########

cidades = []

cur.execute("SELECT cidade from destino")
rows = cur.fetchall()

for each in rows:
    cidades.append(each[0])

query = 'INSERT INTO viagem(data, hora, placa, cidade, nro_passageiros) VALUES\n'
for i in range(0,60):
    query += geradorViagem(random.choice(placas),random.choice(cidades))

arquivo = open('popViagem.sql', 'w')
arquivo.writelines(query)
