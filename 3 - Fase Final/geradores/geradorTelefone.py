import random
import string
from random import randint
import psycopg2

conn = psycopg2.connect("dbname=projetoRodoviario user=postgres")


def geraTel(cpf):
    celular = random.choice([0,1])
    num = ''
    if celular:
        for i in range(0,8):
            if(i == 4):
                num = num + '-'
            num = num + str(randint(1,9))
    else:
        num = '9'
        for i in range(0,8):
            if(i == 4):
                num = num + '-'
            num = num + str(randint(1,9))
    ddd = random.choice(['11','21','31','41','51','61','71','81','91'])
    return [cpf, '(' + ddd + ')' + num]


par = []
texto = []
cur = conn.cursor()
i = 0

cur.execute("SELECT cpf from funcionario")
rows = cur.fetchall()

for each in rows:
    par.append(geraTel(each[0]))

arquivo = open('popTelefone.sql','w')

texto.append('INSERT INTO telefone(cpf, telefone) VALUES')

for each in par:
    if(i < len(par) - 1):
        texto.append('(\'' + each[0] + '\', \'' + each[1] + '\'),\n')
    else:
        texto.append('(\'' + each[0] + '\', \'' + each[1] + '\');\n')
    i+=1

arquivo.writelines(texto)
