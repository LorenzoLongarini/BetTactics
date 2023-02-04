take_scorers(X,Y):-marcatore(X,Y,_,_).
take_assistmen(X,W):-marcatore(X,_,W,_).
take_penalties(X,Z):-marcatore(X,_,_,Z).

count([],0).
count([1|T],N) :-
    count(T,N1), N is N1 + 1.

winner_home(Team,Result):-
    findall(Team,matchSA(Team,_,"HOME_TEAM",_,_),Result).
num_winner_home(Team,WinHome):-
    winner_home(Team,Result),
    length(Result,WinHome).

winner_away(Team,Result):-
    findall(Team,matchSA(_,Team,"AWAY_TEAM",_,_),Result).
num_winner_away(Team,WinAway):-
    winner_away(Team,Result),
    length(Result,WinAway).

total_win(Team, Result):-
    num_winner_home(Team,WinHome),
    num_winner_away(Team,WinAway),
    Result is WinHome + WinAway.

lose_home(Team,Result):-
    findall(Team,matchSA(Team,_,"AWAY_TEAM",_,_),Result).
num_lose_home(Team,LoseHome):-
    lose_home(Team,Result),
    length(Result,LoseHome).

lose_away(Team,Result):-
    findall(Team,matchSA(_,Team,"HOME_TEAM",_,_),Result).
num_lose_away(Team,LoseAway):-
    lose_away(Team,Result),
    length(Result,LoseAway).

total_lose(Team, Result):-
    num_lose_home(Team,LoseHome),
    num_lose_away(Team,LoseAway),
    Result is LoseHome + LoseAway.

draw_home(Team,Result):-
    findall(Team,matchSA(Team,_,"DRAW",_,_),Result).
num_draw_home(Team,DrawHome):-
    draw_home(Team,Result),
    length(Result,DrawHome).

draw_away(Team,Result):-
    findall(Team,matchSA(_,Team,"DRAW",_,_),Result).
num_draw_away(Team,DrawAway):-
    draw_away(Team,Result),
    length(Result,DrawAway).

total_draws(Team, Result):-
    num_draw_home(Team,DrawHome),
    num_draw_away(Team,DrawAway),
    Result is DrawHome + DrawAway.

total_matches_played(Team, Result):-
    total_win(Team, Result1),
    total_lose(Team, Result2),
    total_draws(Team, Result3),
    Result is  Result1 + Result2 + Result3.

percent_win(Team, Result):-
    total_win(Team, Result1),
    total_matches_played(Team, Result2),
    Result3 is Result1 / Result2,
    Result is Result3 * 100.

percent_lose(Team, Result):-
    total_lose(Team, Result1),
    total_matches_played(Team, Result2),
    Result3 is Result1 / Result2,
    Result is Result3 * 100.

percent_draws(Team, Result):-
    total_draws(Team, Result1),
    total_matches_played(Team, Result2),
    Result3 is Result1 / Result2,
    Result is Result3 * 100.
