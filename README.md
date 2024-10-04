# 1o-Trabalho-Planejador-para-Empilhar-blocos-de-diferente-dimens-es





## Aluno(a): Aline Silva da Cunha                                              Matrícula: 22250558
## Aluno(a): Lorena Pantoja dos Anjos                                          Matrícula: 22252592

### Para usar esse código no SWI-Prolog, siga estes passos:

### Rodar o Planejador:

Depois de carregar o arquivo, chame o predicado principal plan/3 passando o estado inicial, as metas e uma variável para o plano gerado.

?- plan([on(a, b), on(b, table)], [on(a, table)], Plan).
    

Isso executa o planejador e gera a sequência de ações necessária para satisfazer as metas.

### Verificar as Ações:
O SWI-Prolog tentará resolver as metas, e o plano de ações será impresso como resultado da consulta. O predicado Plan retornará a sequência de ações necessárias.

### Mover Blocos:

#### Estado Inicial:

State = [on(a, b), on(b, table), at(b, 2, 3), at(a, 2, 4)].


#### Meta:

Goal = [on(a, table), at(a, 3, 4)].


#### Chamada:

?- plan([on(a, b), on(b, table), at(b, 2, 3), at(a, 2, 4)], [on(a, table), at(a, 3, 4)], Plan).


#### Resultado:
Prolog gera um plano que move o bloco "a" da posição sobre "b" para a mesa na posição (3, 4).

### Empilhamento de Blocos

#### Estado Inicial:

State = [on(b, table), on(c, table), on(a, b), at(b, 2, 3), at(c, 3, 3), at(a, 2, 4)].


#### Meta:

Goal = [on(a, c), at(a, 3, 3)].


#### Chamada:

?- plan([on(b, table), on(c, table), on(a, b), at(b, 2, 3), at(c, 3, 3), at(a, 2, 4)], [on(a, c), at(a, 3, 3)], Plan).


#### Resultado:
O Prolog gera um plano para mover o bloco "a" de cima de "b" para ser empilhado sobre "c" na posição correta.

### Exemplo 3: Regressão de Metas com Mais Blocos

#### Estado Inicial:

State = [on(a, b), on(b, c), on(c, table), at(c, 2, 5)].


#### Meta:

Goal = [on(a, table), on(b, table), at(a, 3, 4), at(b, 2, 3)].


#### Chamada:

?- plan([on(a, b), on(b, c), on(c, table), at(c, 2, 5)], [on(a, table), on(b, table), at(a, 3, 4), at(b, 2, 3)], Plan).


#### Resultado:
O Prolog gera um plano para mover os blocos "a" e "b" para a mesa nas posições especificadas.
