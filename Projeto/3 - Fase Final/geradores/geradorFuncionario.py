import string
from random import randint
import random

def geradorDeCpf( formatar ):
    '''
    retirado de https://www.vivaolinux.com.br/script/Gerador-de-CPF-em-Python
    '''

    # 9 números aleatórios
    arNumeros = []
    for i in range(9):
        arNumeros.append( randint(0,9) )

   # Calculado o primeiro DV
    somaJ = ( arNumeros[0] * 10 ) + ( arNumeros[1] * 9 ) + ( arNumeros[2] * 8 ) + ( arNumeros[3] * 7 )  + ( arNumeros[4] * 6 ) + ( arNumeros[5] * 5 ) + ( arNumeros[6] * 4 )  + ( arNumeros[7] * 3 ) + ( arNumeros[8] * 2 )

    restoJ = somaJ % 11

    if ( restoJ == 0 or restoJ == 1 ):
        j = 0
    else:
        j = 11 - restoJ

    arNumeros.append( j )

   # Calculado o segundo DV
    somaK = ( arNumeros[0] * 11 ) + ( arNumeros[1] * 10 ) + ( arNumeros[2] * 9 ) + ( arNumeros[3] * 8 )  + ( arNumeros[4] * 7 )  + ( arNumeros[5] * 6 ) + ( arNumeros[6] * 5 )  + ( arNumeros[7] * 4 )  + ( arNumeros[8] * 3 ) + ( j * 2 )

    restoK = somaK % 11

    if ( restoK == 0 or restoK == 1 ):
        k = 0
    else:
        k = 11 - restoK

    arNumeros.append( k )

    cpf = ''.join(str(x) for x in arNumeros)

    if formatar:
        return cpf[ :3 ] + '.' + cpf[ 3:6 ] + '.' + cpf[ 6:9 ] + '-' + cpf[ 9: ]
    else:
        return cpf

def geradorSexo():
    return random.choice(['F', 'M'])

def geradorData():
    dia = randint(1, 30)
    mes = randint(1, 12)
    ano = randint(1930, 2001)
    return (str(ano) + '-' + str(mes) + '-' + str(dia))

cnpj = ['57.564.373/0001-02',
'14.208.060/0001-09',
'80.703.848/0001-16',
'28.668.014/0001-05',
'76.390.568/0001-28',
'63.675.367/0001-25',
'18.900.311/0001-72',
'54.705.902/0001-52',
'59.014.907/0001-52',
'06.803.465/0001-67',
'76.444.563/0001-30']

nomes = ['Cassie Corlew',
'Alline Gratton',
'Jacki Haverland',
'Verona Moscato',
'Joey Schiffman',
'Shandi Rising',
'Arlena Jelks',
'Milissa Mervis',
'Sunni Munguia',
'Tanesha Rumbaugh',
'Ashleigh Litman',
'Ghislaine Whitenack',
'Mahalia Eddie',
'Marylee Fifer',
'Meghan Lafave',
'Kay Salisbury',
'Chassidy Lipp',
'Willis Landgaf',
'Bernarda Marte',
'Toney Vanalstyn',
'Richie Heng',
'Eryn Hose',
'Dorthea Shanley',
'Emilee Heiser',
'Camille Nordstrom',
'Kiesha Basquez',
'Julee Tinkham',
'Gayla Danos',
'Chong Sober',
'Winona Bickett',
'Pa Anthony ',
'Lavenia Janelle',
'Gregoria Mccallis',
'Debbie Izzard',
'Mariam Mcgough',
'Laila Goines',
'Vashti Buhr',
'Modesta Larmon',
'Many Morgenstern',
'Trang Rodman',
'Ricki Jeter',
'Efrain Oullette',
'Valentin Osborn',
'Carrie Jeanes',
'Carol Bonn',
'Elmo Scherrer',
'Luciano Studebaker',
'Spencer Najarro',
'Deb Welton',
'Vonda Mcgahan']

listafinal = []

for nome in nomes:
    listafinal.append([geradorDeCpf(True), nome, geradorSexo(), geradorData(), random.choice(cnpj)])
print ('INSERT INTO funcionario(cpf, nome, sexo, data_nasc, cnpj) VALUES')
for each in (listafinal):
    print('(\'' + each[0] + '\', \'' + each[1]  + '\', \'' + each[2]  + '\', \'' + each[3] + '\', \'' + each[4] + '\')')
