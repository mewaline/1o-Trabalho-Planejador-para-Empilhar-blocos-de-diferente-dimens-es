%   A means-ends planner with goal regression (adaptado para manipulação de variáveis)
%   plan( State, Goals, Plan)
plan(State, Goals, []):-
    satisfied(State, Goals).                    % Verifica se todas as metas já são satisfeitas no estado

plan(State, Goals, Plan):-
    append(PrePlan, [Action], Plan),            % O plano é dividido em subplano + uma ação final
    select(State, Goals, Goal),                 % Seleciona uma meta da lista de metas
    achieves(Action, Goal),                     % Verifica se a ação escolhida alcança a meta
    can(Action, Condition),                     % Verifica se a ação pode ser executada
    preserves(Action, Goals),                   % Garante que a ação não destrua outras metas
    regress(Goals, Action, RegressedGoals),     % Faz a regressão das metas por meio da ação
    plan(State, RegressedGoals, PrePlan).       % Planeja para atingir as metas restantes

% Verifica se todas as metas são satisfeitas no estado
satisfied(State, [Goal | Goals]):-
    holds(Goal),  % Verifica se a meta é verdadeira no estado atual
    satisfied(State, Goals).  % Chama recursivamente para as outras metas
satisfied(_, []).

% Predicado holds/1 para verificar se uma meta está satisfeita (adapta variáveis)
holds(different(X, Y)):-
    \+ X = Y, !.  % Se X e Y são diferentes, a meta está satisfeita
holds(different(X, Y)):-
    X == Y,
    false.

% Seleciona uma meta da lista de metas
select(State, Goals, Goal)  :-
    member(Goal, Goals).  % Escolhe uma meta da lista de metas

% Verifica se uma ação pode satisfazer uma meta
achieves(Action, Goal)  :-
    adds(Action, Goals),  % A ação deve adicionar a meta desejada
    member(Goal, Goals).

% Verifica se a ação não destrói outras metas
preserves(Action, Goals)  :-
    deletes(Action, Relations),  % Verifica se a ação remove alguma meta da lista
    \+ (member(Goal, Relations),
        member(Goal, Goals)).

% Regressão de metas por meio da ação
regress(Goals, Action, RegressedGoals)  :-
    adds(Action, NewRelations),  % Verifica os efeitos da ação
    delete_all(Goals, NewRelations, RestGoals),  % Remove as metas já alcançadas
    can(Action, Condition),  % Verifica as condições da ação
    addnew(Condition, RestGoals, RegressedGoals).  % Adiciona as novas metas

% Verifica se a ação pode ser realizada com base nas condições
can(Action, Condition):-
    valid_conditions(Condition).  % Verifica se as condições são válidas

% Adiciona novas metas à lista existente (evita duplicatas)
addnew([], L, L).

addnew([Goal | _], Goals, _)  :-
    impossible(Goal, Goals),  % Se a meta for impossível, falha
    !,
    fail.

addnew([X | L1], L2, L3)  :-
    member(X, L2), !,  % Ignora duplicatas
    addnew(L1, L2, L3).

addnew([X | L1], L2, [X | L3])  :-
    addnew(L1, L2, L3).

% Diferença de conjuntos (remove metas já alcançadas)
delete_all([], _, []).

delete_all([X | L1], L2, Diff)  :-
    member(X, L2), !,
    delete_all(L1, L2, Diff).

delete_all([X | L1], L2, [X | Diff])  :-
    delete_all(L1, L2, Diff).

% Operações auxiliares para manipulação de listas
member(X, [X|_]).
member(X, [_|T]):-
     member(X, T).

delete(X, [X|Tail], Tail).
delete(X, [Y|Tail], [Y|Tail1]):-
   delete(X, Tail, Tail1).

