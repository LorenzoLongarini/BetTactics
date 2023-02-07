take_scorers(X,Y):-marcatore(X,Y,_,_).
take_assistmen(X,W):-marcatore(X,_,W,_).
take_penalties(X,Z):-marcatore(X,_,_,Z).



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

played_home(Team,Result):-
    findall(Team,matchSA(Team,_,_,_,_),Result).
not_played_home(Team,Result):-
    findall(Team,matchSA(Team,_,null,_,_),Result).
tot_played_home(Team,Play_home):-
    played_home(Team,Result),
    not_played_home(Team,Result1),
    length(Result,X),
    length(Result1,Y),
    Play_home is X - Y.

percent_win_home(Team,Result, Cod):-
    consult('BetTacticsScript.pl'),
    start_matches_SA(Team,Cod),
    atom_string(Team, Team1),
    atom_concat('database_MATCHES-',Team1,Result1),
    atom_concat(Result1,'.pl',Result2),
    consult(Result2),
    num_winner_home(Team,Ris1),
    tot_played_home(Team,Ris2),
    Ris3 is Ris1 / Ris2,
    Result is Ris3 * 100.


played_away(Team,Result):-

    findall(Team,matchSA(_,Team,_,_,_),Result).
not_played_away(Team,Result):-
    findall(Team,matchSA(_,Team,null,_,_),Result).
tot_played_away(Team,Play_away):-
    played_away(Team,Result),
    not_played_away(Team,Result1),
    length(Result,X),
    length(Result1,Y),
    Play_away is X - Y.
    
percent_win_away(Team,Result, Cod):-
    consult('BetTacticsScript.pl'),
    start_matches_SA(Team,Cod),
    atom_string(Team, Team1),
    atom_concat('database_MATCHES-',Team1,Result1),
    atom_concat(Result1,'.pl',Result2),
    consult(Result2),
    num_winner_away(Team,Ris1),
    tot_played_away(Team,Ris2),
    Ris3 is Ris1 / Ris2,
    Result is Ris3 * 100.

next_match(X,Y, TeamName, Cod):-
    consult('BetTacticsScript.pl'),
    start_matches_SA(TeamName,Cod),
    atom_string(TeamName, TeamName1),
    atom_concat('database_MATCHES-',TeamName1,Result1),
    atom_concat(Result1,'.pl',Result2),
    consult(Result2),
    findall([Home,Away],matchSA(Home,Away,null,_,_),Result),
    member([X,Y],Result),!.

cerca(RisPercentuale,TeamName, Cod, Home, Away):-
    next_match(Home,Away,TeamName,Cod),
    start_results,
    consult('database_RESULTS_SA.pl'),
    findall(Casa,classifica(Casa,Home,_,_),Result),
    findall(Trasferta,classifica(Trasferta,Away,_,_),Result2),
    (( Result < Result2 ) -> Ris is Result2-Result; Ris is Result-Result2),
    ((TeamName==Home)-> RisPercentuale is Ris*5;RisPercentuale1 is Ris*5, RisPercentuale is 100 - RisPercentuale1).
    
    

%la differenza tra due squadre va da 1 a 19


count_occurrences([], _, 0).
count_occurrences([H|T], String, Count) :-
    (   H = String
    ->  count_occurrences(T, String, TailCount),
        Count is TailCount + 1
    ;   count_occurrences(T, String, Count)
    ).

forma(Team, NumW):-
    consult('BetTacticsScript.pl'),
    start_results,
    consult('database_RESULTS_SA.pl'),
    classifica(_,Team,_,X),
    split_string(X,',',',',Y),
    count_occurrences(Y,"W",NumW1),
    NumW2 is NumW1 / 5, 
    NumW is NumW2 * 100.

total_win_percent(Team, Cod, Win):-
    forma(Team, NumW),
    cerca(RisPercentuale, Team, Cod, Home, Away),
    percent_win(Team, Result),
    
    ((Team == Home)->percent_win_home(Team, X1, Cod);  percent_win_away(Team, X1, Cod)),
         
    Win2 is NumW + RisPercentuale + Result + X1,
    write(Home), write('-'),write(Away),
    Win is Win2 / 4.



