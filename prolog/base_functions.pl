% :- multifile 'database_Atalanta.pl':matchSA/5.
% :- multifile 'database_Napoli.pl':matchSA/5.
:- multifile(matchSA/5).
take_scorers(X,Y):-marcatore(X,Y,_,_).
take_assistmen(X,W):-marcatore(X,_,W,_).
take_penalties(X,Z):-marcatore(X,_,_,Z).

start(TeamName, Cod, Result2):-
    consult('BetTacticsScript.pl'),
    start_matches_SA(TeamName, Cod),
    atom_string(TeamName, TeamName1),
    atom_concat('database_', TeamName1, Result1),
    atom_concat(Result1, '.pl', Result2),
    consult(Result2),
    use_module(Result2).


winner_home(Team,Result, Cod, Result2):-   
    findall(Team,Result2:matchSA(Team,_,"HOME_TEAM",_,_),Result).
num_winner_home(Team,WinHome, Cod, Result2):-
    winner_home(Team,Result, Cod, Result2),
    length(Result,WinHome).

winner_away(Team,Result, Cod, Result2):-
    findall(Team,Result2:matchSA(_,Team,"AWAY_TEAM",_,_),Result).
num_winner_away(Team,WinAway, Cod, Result2):-
    winner_away(Team,Result, Cod, Result2),
    length(Result,WinAway).

total_win(Team, Result, Cod, Result2):-
    num_winner_home(Team,WinHome, Cod, Result2),
    num_winner_away(Team,WinAway, Cod, Result2),
    Result is WinHome + WinAway.

lose_home(Team,Result, Cod, Result2):-
    findall(Team,Result2:matchSA(Team,_,"AWAY_TEAM",_,_),Result).
num_lose_home(Team,LoseHome, Cod, Result2):-
    lose_home(Team,Result, Cod, Result2),
    length(Result,LoseHome).

lose_away(Team,Result, Cod, Result2):-
    findall(Team,Result2:matchSA(_,Team,"HOME_TEAM",_,_),Result).
num_lose_away(Team,LoseAway, Cod, Result2):-
    lose_away(Team,Result, Cod, Result2),
    length(Result,LoseAway).

total_lose(Team, Result, Cod, Result2):-
    num_lose_home(Team,LoseHome, Cod, Result2),
    num_lose_away(Team,LoseAway, Cod, Result2),
    Result is LoseHome + LoseAway.

draw_home(Team,Result, Cod, Result2):-
    findall(Team,Result2:matchSA(Team,_,"DRAW",_,_),Result).
num_draw_home(Team,DrawHome, Cod, Result2):-
    draw_home(Team,Result, Cod, Result2),
    length(Result,DrawHome).

draw_away(Team,Result, Cod, Result2):-
    findall(Team,Result2:matchSA(_,Team,"DRAW",_,_),Result).
num_draw_away(Team,DrawAway, Cod, Result2):-
    draw_away(Team,Result, Cod, Result2),
    length(Result,DrawAway).

total_draws(Team, Result, Cod, Result2):-
    num_draw_home(Team,DrawHome, Cod, Result2),
    num_draw_away(Team,DrawAway, Cod, Result2),
    Result is DrawHome + DrawAway.

total_matches_played(Team, Result, Cod, Result4):-
    total_win(Team, Result1, Cod, Result4),
    total_lose(Team, Result2, Cod, Result4),
    total_draws(Team, Result3, Cod, Result4),
    Result is  Result1 + Result2 + Result3.

percent_win(Team, Result, Cod):-
    start(Team, Cod, Result4),
    total_win(Team, Result1, Cod, Result4),
    total_matches_played(Team, Result2, Cod, Result4),
    Result3 is Result1 / Result2,
    Result is Result3 * 100.

percent_lose(Team, Result, Cod):-
    start(Team, Cod, Result4),
    total_lose(Team, Result1, Cod, Result4),
    total_matches_played(Team, Result2, Cod, Result4),
    Result3 is Result1 / Result2,
    Result is Result3 * 100.

percent_draws(Team, Result, Cod):-
    start(Team, Cod, Result4),
    total_draws(Team, Result1, Cod, Result4),
    total_matches_played(Team, Result2, Cod, Result4),
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
    atom_concat('database_',Team1,Result1),
    atom_concat(Result1,'.pl',Result2),
    consult(Result2),
    use_module(Result2),
    num_winner_home(Team,Ris1, Cod, Result2),
    tot_played_home(Team,Ris2, Result2),
    Ris3 is Ris1 / Ris2,
    Result is Ris3 * 100.


played_away(Team, Result, Result2):-
    findall(Team, Result2:matchSA(_,Team,_,_,_), Result).
not_played_away(Team,Result, Result2):-
    findall(Team, Result2:matchSA(_,Team,null,_,_), Result).
tot_played_away(Team,Play_away, Result2):-
    played_away(Team,Result, Result2),
    not_played_away(Team,Result1, Result2),
    length(Result,X),
    length(Result1,Y),
    Play_away is X - Y.
    
percent_win_away(Team,Result, Cod):-
    consult('BetTacticsScript.pl'),
    start_matches_SA(Team,Cod),
    atom_string(Team, Team1),
    atom_concat('database_',Team1,Result1),
    atom_concat(Result1,'.pl',Result2),
    consult(Result2),
    num_winner_away(Team,Ris1, Cod, Result2),
    tot_played_away(Team,Ris2, Result2),
    Ris3 is Ris1 / Ris2,
    Result is Ris3 * 100.

next_match(X,Y, TeamName, Cod):-
    consult('BetTacticsScript.pl'),
    start_matches_SA(TeamName,Cod),
    atom_string(TeamName, TeamName1),
    atom_concat('database_',TeamName1,Result1),
    atom_concat(Result1,'.pl',Result2),
    consult(Result2),
    use_module(Result2),
    findall([Home,Away],Result2:matchSA(Home,Away,null,_,_),Result),
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
    %start_results,
    consult('database_RESULTS_SA.pl'),
    classifica(_,Team,_,X),
    split_string(X,',',',',Y),
    count_occurrences(Y,"W",NumW1),
    NumW2 is NumW1 / 5, 
    NumW is NumW2 * 100.

total_win_percent(Team, Cod):-
    forma(Team, NumW),
    cerca(RisPercentuale, Team, Cod, Home, Away),
    percent_win(Team, Result, Cod),
    
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
  

goal_team_home_scored(TeamName, Final):-
    atom_string(TeamName, TeamName1),
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
    atom_concat('database_',TeamName1,Result1),
    atom_concat(Result1,'.pl',Result2),
    consult(Result2),
    use_module(Result2),
    findall(Goal, Result2:matchSA(_, TeamName, _, _,Goal), Result),
    tot_played_away(TeamName, PlayedSum, Result2),
    sum_list(Result, Sum),
    Final is Sum / PlayedSum.

goal_team_home_sub(TeamName, Final):-
    atom_string(TeamName, TeamName1),
    atom_concat('database_',TeamName1,Result1),
    atom_concat(Result1,'.pl',Result2),
    consult(Result2),
    use_module(Result2),
    findall(Goal, Result2:matchSA(TeamName, _, _, _,Goal), Result),
    tot_played_home(TeamName, PlayedSum, Result2),
    sum_list(Result, Sum),
    Final is Sum / PlayedSum.

goal_team_away_sub(TeamName, Final):-
    atom_string(TeamName, TeamName1),
    atom_concat('database_',TeamName1,Result1),
    atom_concat(Result1,'.pl',Result2),
    consult(Result2),
    use_module(Result2),
    findall(Goal, Result2:matchSA(_, TeamName, _ ,Goal,_), Result),
    tot_played_away(TeamName, PlayedSum, Result2),
    sum_list(Result, Sum),
    Final is Sum / PlayedSum.

over_under(TeamName, Cod):-
    next_match(Home, Away, TeamName, Cod),
    goal_team_home_scored(Home, MediaHomeScored),
    goal_team_away_scored(Away, MediaAwayScored),
    goal_team_home_sub(Home, MediaHomeSub),
    goal_team_away_sub(Away, MediaAwaySub),
    HomeGoals is MediaHomeScored + MediaAwaySub,
    MediaHomeGoals is HomeGoals / 2,
    AwayGoals is MediaHomeSub + MediaAwayScored,
    MediaAwayGoals is AwayGoals / 2,
    write('La prossima partita di '),
    write(TeamName),
    write(' : '),
    write(Home),
    write(' - '),
    writeln(Away),
    OverUnder is MediaHomeGoals + MediaAwayGoals,
    format(atom(OverUnderStamp), "~2f",[OverUnder]),
    write('La media dei goal: '),
    write(OverUnderStamp).
    

%odd or even

pari(0).
pari(X):- X>0, X1 is X-1, dispari(X1).
dispari(X):- X>0, X1 is X-1, pari(X1).



sum_list_oddeven([], 0, 0).
sum_list_oddeven([H|T], Even, Odd) :-
    sum_list_oddeven(T, Even1, Odd1),
    ((H == 'null') ->  Even = 0, Odd = 0, Even1 = 0, Odd1 = 0;  
    (dispari(H)) -> Even is Even1 + 1, Odd = Odd1;
    Odd is Odd1 + 1, Even = Even1). 

goal_home_oddeven(TeamName, Cod):-
    next_match(Home, Away, TeamName, Cod),
    atom_string(Home, TeamName1),
    atom_concat('database_',TeamName1,Result1),
    atom_concat(Result1,'.pl',Result2),
    consult(Result2),
    use_module(Result2),
    atom_string(Away, TeamName2),
    atom_concat('database_',TeamName2,Result3),
    atom_concat(Result3,'.pl',Result4),
    consult(Result4),
    use_module(Result4),
    findall(Goal, Result2:matchSA(Home, _, _, Goal,_), GoalHH),
    findall(Goal, Result2:matchSA(_, Home, _, _,Goal), GoalHA),
    findall(Goal, Result4:matchSA(Away, _, _, Goal,_), GoalAH),
    findall(Goal, Result4:matchSA(_, Away, _, _,Goal), GoalAA),
    sum_list_oddeven(GoalHH, EvenHH, OddHH),
    sum_list_oddeven(GoalHA, EvenHA, OddHA),
    sum_list_oddeven(GoalAH, EvenAH, OddAH),
    sum_list_oddeven(GoalAA, EvenAA, OddAA),
    EvenH is EvenHH + EvenHA,
    OddH is OddHH + OddHA,
    EvenA is EvenAH + EvenAA,
    OddA is OddAH + OddAA,
    TotH is EvenH + OddH,
    PercentEvenH is EvenH / TotH,
    PercentOddH is OddH / TotH,
    TotA is EvenA + OddA,
    PercentEvenA is EvenA / TotA,
    PercentOddA is OddA / TotA,
    TotEven is PercentEvenH + PercentEvenA,
    TotOdd is PercentOddH + PercentOddA,
    ((TotEven > TotOdd)-> write('La somma totale dei goal e\' PARI');
     write('La somma totale dei goal e\' DISPARI')).
    %Final is Sum / PlayedSum.


%goal or nogoal
goal_or_not(TeamName, Cod):-
    next_match(Home, Away, TeamName, Cod),
    goal_team_home_scored(Home, MediaHomeScored),
    goal_team_away_scored(Away, MediaAwayScored),
    ((MediaHomeScored >= 1 , MediaAwayScored >= 1) -> 
        write('La prossima partita di '),
        write(TeamName),
        write(' : '),
        write(Home),
        write(' - '),
        writeln(Away),
        write('Entrambe le squadre segneranno un goal');
        write('La prossima partita di '),
        write(TeamName),
        write(' : '),
        write(Home),
        write(' - '),
        writeln(Away),
        write('Una delle due squadre non segnera')).