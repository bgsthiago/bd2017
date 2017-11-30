import random
import string
from random import randint
import psycopg2

conn = psycopg2.connect("dbname=projetoRodoviario user=postgres")

def geradorDestino(local, cnpj):
    j = x = 0
    query = ' '

    for each in local:
        for i in range(1,len(each)):
            if(j < (len(local) - 1)):
                query += ('(\'' + each[0] + '\', ' + '\'' + each[i] + '\', ' + '\'' + str(random.uniform(15, 180)) + '\', ' + '\'' + random.choice(cnpj) + '\'),\n')
            else:
                x+=1
                if(x >= (len(each) - 1)):
                    query += ('(\'' + each[0] + '\', ' + '\'' + each[i] + '\', ' + '\'' + str(random.uniform(15, 180)) + '\', ' + '\'' + random.choice(cnpj) + '\');\n')
                else:
                    query += ('(\'' + each[0] + '\', ' + '\'' + each[i] + '\', ' + '\'' + str(random.uniform(15, 180)) + '\', ' + '\'' + random.choice(cnpj) + '\'),\n')

        j+=1
    return query

local = [['AC','Rio Branco', 'Cruzeiro do Sul', 'Sena Madureira']
,['AL', 'Maceio', 'Arapiraca', 'Rio Largo', 'Palmeiras dos Indios']
,['AP', 'Macapa', 'Santana', 'Laranjal do Jari', 'Oiapoque']
,['AM', 'Manaus', 'Parintins', 'Itacoatiara', 'Manacapuru', 'Coari']
,['BA', 'Salvador', 'Feira de Santana', 'Vitoria da Conquista', 'Camacari', 'Juazeiro']
,['CE', 'Fortaleza', 'Caucaia', 'Juazeiro do Norte', 'Maracanau', 'Sobral']
,['DF', 'Ceilandia', 'Taguatinga', 'Samambaia']
,['ES', 'Serra', 'Vila Velha', 'Cariacica', 'Vitoria', 'Linhares']
,['GO', 'Goiania', 'Aparecida de Goiania', 'Anapolis', 'Rio Verde', 'Luziania']
,['MA', 'Sao Luis', 'Imperatriz', 'Sao Jose de Ribamar', 'Timon', 'Caxias']
,['MT', 'Cuiaba', 'Varzea Grande', 'Rondonopolis', 'Sinop', 'Sorriso']
,['MS', 'Campo Grande', 'Dourados', 'Tres Lagoas', 'Corumba', 'Ponta Pora']
,['MG', 'Belo Horizonte', 'Uberlandia', 'Contagem', 'Juiz de Fora']
,['PA', 'Belem', 'Ananindeua', 'Santarem', 'Maraba', 'Parauapebas']
,['PB', 'Joao Pessoa', 'Campina Grande', 'Santa Rita', 'Patos', 'Bayeux']
,['PR', 'Curitiba', 'Londrina', 'Maringa', 'Ponta Grossa', 'Cascavel']
,['PE', 'Recife', 'Jaboatao dos Guararapes', 'Olinda', 'Caruaru', 'Petrolina']
,['PI', 'Teresina', 'Parnaiba', 'Picos', 'Piripiri', 'Floriano']
,['RJ', 'Rio de Janeiro', 'Sao Goncalo', 'Duque de Caxias', 'Nova Iguacu', 'Niteroi']
,['RN', 'Natal', 'Mossoro', 'Parnamirim', 'Sao Goncalo do Amarante', 'Macaiba']
,['RS', 'Porto Alegre', 'Caxias do Sul', 'Pelotas', 'Canoas', 'Santa Maria']
,['RO', 'Porto Velho', 'Ji-Parana', 'Ariquemes']
,['RR', 'Boa Vista']
,['SC', 'Joinville', 'Florianopolis', 'Blumenau', 'Sao Jose', 'Chapeco']
,['SP', 'Sao Paulo', 'Guarulhos', 'Campinas', 'Sao Bernardo do Campo', 'Santo Andre']
,['SE', 'Aracaju', 'Nossa Senhora do Socorro', 'Lagarto', 'Itabaiana', 'Sao Cristovao']
,['TO', 'Palmas', 'Araguaina', 'Gurupi', 'Porto Nacional']]

cur = conn.cursor()
arquivo = open('popDestino.sql', 'w')

cur.execute("SELECT cnpj from empresa")
rows = cur.fetchall()
aux = []
for each in rows:
    aux.append(each[0])

query = 'INSERT INTO destino(estado, cidade, valor, cnpj) VALUES\n'
query += (geradorDestino(local, aux))
arquivo.writelines(query)
