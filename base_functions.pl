take_scorers(X,Y):-marcatore(X,Y,_,_).
take_assistmen(X,W):-marcatore(X,_,W,_).
take_penalties(X,Z):-marcatore(X,_,_,Z).

count([],0).
count([1|T],N) :- count(T,N1), N is N1 + 1.

winner_home(X,Result):-findall(X,matchSA(X,_,"HOME_TEAM",_,_),Result),write(Result).
num_winner_home(X,Count):-winner_home(X,Result),length(Result,Count).
