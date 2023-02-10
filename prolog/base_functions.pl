take_scorers(X,Y):-marcatore(X,Y,_,_).
take_assistmen(X,W):-marcatore(X,_,W,_).
take_penalties(X,Z):-marcatore(X,_,_,Z).


winner_home(Team,Result):-
    consult('database_MATCHES-AS Roma.pl'),
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

played_home(Team,Result, Result2):-
    findall(Team,Result2:matchSA(Team,_,_,_,_),Result).
not_played_home(Team,Result, Result2):-
    findall(Team,Result2: matchSA(Team,_,null,_,_),Result).
tot_played_home(Team,Play_home, Result2):-
    played_home(Team,Result, Result2),
    not_played_home(Team,Result1, Result2),
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

total_win_percent(Team, Cod):-
    forma(Team, NumW),
    cerca(RisPercentuale, Team, Cod, Home, Away),
    percent_win(Team, Result),
    
    ((Team == Home)->percent_win_home(Team, X1, Cod);  percent_win_away(Team, X1, Cod)),
         
    Win2 is NumW + RisPercentuale + Result + X1,
    write('La prossima partita di '),
    write(Team),
    write(' : '),
    write(Home),
    write(' - '),
    writeln(Away),
    Win is Win2 / 4,
    write(Team),
    write(' ha una percentuale di vittoria pari al '),
    format(atom(WinStamp), "~2f",[Win]),
    write(WinStamp),
    write(' %').

%over/under
sum_list([], 0).
sum_list([H|T], Sum) :-
   sum_list(T, Rest),
   ((H == null) -> Sum is 0 + Rest;  Sum is H + Rest).
  

goal_team_home_scored(TeamName, ShortName, Final):-
    atom_string(ShortName, TeamName1),
    atom_concat('database_',TeamName1,Result1),
    atom_concat(Result1,'.pl',Result2),
    consult(Result2),
    use_module(Result2),
    findall(Goal, Result2:matchSA(TeamName, _, _, Goal,_), Result),
    tot_played_home(TeamName, PlayedSum, Result2),
    sum_list(Result, Sum),
    Final is Sum / PlayedSum.

goal_team_away_scored(TeamName, Final):-
    atom_string(TeamName, TeamName1),
    atom_concat('database_MATCHES-',TeamName1,Result1),
    atom_concat(Result1,'.pl',Result2),
    consult(Result2),
    findall(Goal, matchSA(_, TeamName, _, _,Goal), Result),
    tot_played_away(TeamName, PlayedSum),
    sum_list(Result, Sum),
    Final is Sum / PlayedSum.

goal_team_home_sub(TeamName, Final):-
    atom_string(TeamName, TeamName1),
    atom_concat('database_MATCHES-',TeamName1,Result1),
    atom_concat(Result1,'.pl',Result2),
    consult(Result2),
    findall(Goal, matchSA(TeamName, _, _, _,Goal), Result),
    tot_played_home(TeamName, PlayedSum),
    sum_list(Result, Sum),
    Final is Sum / PlayedSum.

goal_team_away_sub(TeamName, Final):-
    atom_string(TeamName, TeamName1),
    atom_concat('database_MATCHES-',TeamName1,Result1),
    atom_concat(Result1,'.pl',Result2),
    consult(Result2),
    findall(Goal, matchSA(_, TeamName, _ ,Goal,_), Result),
    tot_played_away(TeamName, PlayedSum),
    sum_list(Result, Sum),
    Final is Sum / PlayedSum.

over_under(TeamName, Cod):-
    next_match(Home10, Away10, TeamName, Cod),
    goal_team_home_scored(Home10, MediaHomeScored),
    goal_team_away_scored(Away10, MediaAwayScored),
    goal_team_home_sub(Home10, MediaHomeSub),
    goal_team_away_sub(Away10, MediaAwaySub),
    HomeGoals is MediaHomeScored + MediaAwaySub,
    MediaHomeGoals is HomeGoals / 2,
    AwayGoals is MediaHomeSub + MediaAwayScored,
    MediaAwayGoals is AwayGoals / 2,
    write('La prossima partita di '),
    write(TeamName),
    write(' : '),
    write(Home10),
    write(' - '),
    writeln(Away10),
    OverUnder is MediaHomeGoals + MediaAwayGoals,
    format(atom(OverUnderStamp), "~2f",[OverUnder]),
    write('La media dei goal: '),
    write(OverUnderStamp),
    write(' %').
    

%odd or even
sum_list_oddeven([], 0, 0).
sum_list_oddeven([H|T], Even, Odd) :-
    sum_list_oddeven(T, Even1, Odd1),
    ((H \== null) -> VAL is H mod 2, ),
    ((H == null) -> Even is Even1 + 0, Odd is Odd1 + 0;  
    (VAL == 1) -> Odd is Odd1 + 1; 
    Even is Even1 + 1).

goal_home_oddeven(TeamName, Even, Odd):-
    atom_string(TeamName, TeamName1),
    atom_concat('database_MATCHES-',TeamName1,Result1),
    atom_concat(Result1,'.pl',Result2),
    consult(Result2),
    findall(Goal, matchSA(TeamName, _, _, Goal,_), Result),
    tot_played_home(TeamName, PlayedSum),
    sum_list_oddeven(Result, Even, Odd).
    %Final is Sum / PlayedSum.


%goal or nogoal
goal_or_not(TeamName, Cod):-
    next_match(Home, Away, TeamName, Cod),
    goal_team_home_scored(Home, MediaHomeScored),
    goal_team_away_scored(Away, MediaAwayScored),
    ((MediaHomeScored >= 1 , MediaAwayScored >= 1) -> 
        write('Entrambe le squadre segneranno un goal');
        write('Una delle due squadre non segnera')).