## Considerações gerais

A escolha da linguagem é deixada para você, utilize **a que você se sente mais confortável**. A entrada deverá ser por `STDIN` (*standard input*) e a saída por `STDOUT` (*standard output*) na linguagem que você escolher. 

Forneça as instruções de instalação e execução do seu sistema, observaremos **principalmente seu *design* de código**. Aspectos como coesão, baixo acoplamento e legibilidade são os principais pontos.

Escolha um dos desafios abaixo para resolver, caso já tenha participado do processo seletivo, por favor escolha um desafio diferente do que foi feito anteriormente.

## 1 - Grade de programação

O sinal da TV Globo é geolocalizado, dependendo de onde você está um programa
diferente está passando. Um exemplo disso são os jornais locais: RJTV, SPTV,
DFTV etc.

Quando não existe um programa regional é utilizado o sinal nacional, logo,
alguns programas passam em todo o território.

Para este desafio você deverá escrever um programa que recebe os dados da grade
de programação e responde a algumas perguntas. O formato de entrada/saída e os
tipos de pergunta são definidos abaixo.

### Entrada de dados, cadastro de grade

- Cada registro é dado em uma única linha
- Formato: `S <região> <nome do programa> <início> <fim>`
- Exemplo, Bom Dia DF passa às 6 da manhã -> `S "DF" "Bom Dia DF" 06:00 07:30`

### Entrada de dados, consulta de grade

- Cada registro é dado em uma única linha
- Formato: `Q <região> <hora>`
- Exemplo: Qual programa passa no DF às 6 da manhã? -> `Q "DF" 06:00`

### Saída de dados, respostas as consultas

- Cada resposta é dada em uma única linha
- Formato: `A <Q_região> <hora> <S_região> <nome do programa>`
- Quando não houver programaçao disponível: `A <Q_região> <hora> noise`
- Exemplo: Bom dia DF é o programa que passa às 6 da manhã no DF -> `A "DF" 06:00 "DF" "Bom Dia DF"`
- Exemplo: Não existe um programa passando às 3 da manhã no DF -> `A "DF" 03:00 noise`

### Exemplos

----
Entrada:
```
S "GO" "Hora Um" 05:00 06:00
S "BR" "Globo Rural" 05:00 06:00
Q "GO" 05:30
Q "SP" 05:28
```
Saída:
```
A "GO" 05:30 "GO" "Hora Um"
A "SP" 05:28 "BR" "Globo Rural"
```
----
Entrada:
```
S "DF" "Bom dia DF" 06:01 07:29
S "RJ" "Bom dia RJ" 06:01 07:29
S "SP" "Bom dia SP" 06:01 07:29
Q "RJ" 07:00
Q "GO" 06:50
```
Saída:
```
A "RJ" 07:00 "RJ" "Bom dia RJ"
A "GO" 06:50 noise
```

## 2 - Algarismos romanos

Você terá que criar um sistema que converta números romanos para decimais ou vice-versa.

O programa pode ser executado recebendo a entrada por STDIN ou como parâmetro "input-file" um arquivo de entrada.

### Por STDIN

Exemplos:

```
$ ./roman2decimals <(echo CLXXVIII)
CLXXVIII => 178
```

```
$ echo CLXXVIII | ./roman2decimals
CLXXVIII => 178
```

```
$ echo 14 | ./roman2decimals
14 => XIV
```


### Por arquivo de entrada

Arquivo de entrada contendo uma lista de algarismos romanos ou decimais (um por linha), retorne o valor em decimal ou algarismo romano equivalente.

### Formato do arquivo de entrada

```
V
4
VI
42
XXVI
26
CLXXVIII
```

Exemplo:

```
$ ./roman2decimals --input-file=input.txt
V => 5
4 => IV
VI => 6
42 => XLII
XXVI => 16
26 => XXVI
CLXXVIII => 178
```

## 2 - Referência

https://pt.wikipedia.org/wiki/Numera%C3%A7%C3%A3o_romana
