%importare multifile ci consente di ridefinire la funzione matchSA presente in tutti i file delle squadre.
:- multifile(matchSA/5).

% REGOLE UTILI

config:-
    set_prolog_flag(warn_override_implicit_import,false).

%questa funzione richiama start_matches_SA e ci consente di aggiornare il database di una squadra
start(TeamName, Cod, Result2):-
    consult('BetTacticsScript.pl'),
    start_matches_SA(TeamName, Cod),
    atom_string(TeamName, TeamName1),
    atom_concat('database_', TeamName1, Result1),
    atom_concat(Result1, '.pl', Result2),
    consult(Result2),
    use_module(Result2).

%questa funzione richiama start_results e ci consente di aggiornare la classifica
start_classifica:-
    consult('BetTacticsScript.pl'),
    start_results,
    consult('database_RESULTS_SA.pl').

%verifica se un numero è pari o dispari
pari(0).
pari(X):- X>0, X1 is X-1, dispari(X1).
dispari(X):- X>0, X1 is X-1, pari(X1).

%data una lista delle partite di una squadra, calcola quante volte il numero dei goal era pari e dispari
sum_list_oddeven([], 0, 0).
sum_list_oddeven([H|T], Even, Odd) :-
    sum_list_oddeven(T, Even1, Odd1),
    ((H == 'null') ->  Even = 0, Odd = 0, Even1 = 0, Odd1 = 0;  
    (dispari(H)) -> Even is Even1 + 1, Odd = Odd1;
    Odd is Odd1 + 1, Even = Even1). 

%permette di consultare il database di una squadra e leggere le sue regole
consult_team(TeamName, Result2):-
    atom_string(TeamName, TeamName1),
    atom_concat('database_',TeamName1,Result1),
    atom_concat(Result1,'.pl',Result2),
    consult(Result2),
    use_module(Result2).

%data una lista in ingresso ne somma gli elementi se non nulli
sum_list([], 0).
sum_list([H|T], Sum) :-
   sum_list(T, Rest),
   ((H == null) -> Sum is 0 + Rest;  Sum is H + Rest).

%funzione che ci permette di calcolare le occorrenze di una lista di una particolare stringa
count_occurrences([], _, 0).
count_occurrences([H|T], String, Count) :-
    (   H = String
    ->  count_occurrences(T, String, TailCount),
        Count is TailCount + 1;
        count_occurrences(T, String, Count)
    ).

%CALCOLO INFORMAZIONI DI BASE

% calcola il totale dei goal fatti da una squadra in casa
goal_do_home(TeamName,Sum):-
    consult_team(TeamName, Result2),
    findall(Goal, Result2:matchSA(TeamName, _, _, Goal,_), Result),
    sum_list(Result, Sum).

% calcola il totale dei goal fatti da una squadra fuori casa
goal_do_away(TeamName,Sum):-
    consult_team(TeamName, Result2),
    findall(Goal, Result2:matchSA(_, TeamName, _, _ ,Goal), Result),
    sum_list(Result, Sum).

% calcola il totale dei goal fatti da una squadra
total_goal_do_team(TeamName,Result):-
    goal_do_home(TeamName,Sum1),
    goal_do_away(TeamName,Sum2),
    Result is Sum1 + Sum2.

% calcola il totale dei goal subiti da una squadra in casa
goal_sub_home(TeamName,Sum):-
    consult_team(TeamName, Result2),
    findall(Goal, Result2:matchSA(TeamName, _, _, _,Goal), Result),
    sum_list(Result, Sum).

% calcola il totale dei goal subiti da una squadra fuori casa
goal_sub_away(TeamName,Sum):-
    consult_team(TeamName, Result2),
    findall(Goal,Result2:matchSA(_, TeamName, _,Goal,_), Result),
    sum_list(Result, Sum).

% calcola il totale dei goal subiti da una squadra
total_goal_sub_team(TeamName, Result):-
    goal_sub_home(TeamName,Sum1),
    goal_sub_away(TeamName,Sum2),
    Result is Sum1 + Sum2.

%calcola la differenza goal di una squadra
goal_difference_team(TeamName,Result):-
    total_goal_do_team(TeamName,Result1),
    total_goal_sub_team(TeamName, Result2),
    Result is Result1 - Result2.

%trova i punti in classifica di una squadra
points(TeamName):-
    start_classifica,
    classifica(_,TeamName,_,_,Points),
    write(TeamName),
    write(' ha: '),
    write(Points),
    write(' punti').

%winner_home trova tutte le partite in cui la squadra ha vinto in casa
winner_home(Team,Result, Result2):-   
    findall(Team,Result2:matchSA(Team,_,"HOME_TEAM",_,_),Result).

%sfrutta la lista creata precedentemente e ne conta le occorrenze
num_winner_home(Team,WinHome, Result2):-
    winner_home(Team,Result, Result2),
    length(Result,WinHome).

%winner_home trova tutte le partite in cui la squadra ha vinto fuori casa
winner_away(Team,Result,  Result2):-
    findall(Team,Result2:matchSA(_,Team,"AWAY_TEAM",_,_),Result).

%sfrutta la lista creata precedentemente e ne conta le occorrenze
num_winner_away(Team,WinAway, Result2):-
    winner_away(Team,Result,  Result2),
    length(Result,WinAway).

%somma tutte le vittorie di una squadra
total_win(Team, Result, Result2):-
    num_winner_home(Team,WinHome, Result2),
    num_winner_away(Team,WinAway, Result2),
    Result is WinHome + WinAway.

%lose_home trova tutte le partite in cui la squadra ha perso in casa
lose_home(Team,Result, Result2):-
    findall(Team,Result2:matchSA(Team,_,"AWAY_TEAM",_,_),Result).

%sfrutta la lista creata precedentemente e ne conta le occorrenze.
num_lose_home(Team,LoseHome,  Result2):-
    lose_home(Team,Result, Result2),
    length(Result,LoseHome).

%lose_home trova tutte le partite in cui la squadra ha perso fuori casa
lose_away(Team,Result, Result2):-
    findall(Team,Result2:matchSA(_,Team,"HOME_TEAM",_,_),Result).

%sfrutta la lista creata precedentemente e ne conta le occorrenze
num_lose_away(Team,LoseAway, Result2):-
    lose_away(Team,Result,  Result2),
    length(Result,LoseAway).

%somma tutte le sconfitte di una squadra
total_lose(Team, Result,Result2):-
    num_lose_home(Team,LoseHome, Result2),
    num_lose_away(Team,LoseAway, Result2),
    Result is LoseHome + LoseAway.

%draw_home trova tutte le partite in cui la squadra ha pareggiato in casa
draw_home(Team,Result, Result2):-
    findall(Team,Result2:matchSA(Team,_,"DRAW",_,_),Result).

%sfrutta la lista creata precedentemente e ne conta le occorrenze
num_draw_home(Team,DrawHome, Result2):-
    draw_home(Team,Result, Result2),
    length(Result,DrawHome).

%draw_home trova tutte le partite in cui la squadra ha pareggiato fuori casa
draw_away(Team,Result,  Result2):-
    findall(Team,Result2:matchSA(_,Team,"DRAW",_,_),Result).

%sfrutta la lista creata precedentemente e ne conta le occorrenze
num_draw_away(Team,DrawAway, Result2):-
    draw_away(Team,Result, Result2),
    length(Result,DrawAway).

%somma tutti i pareggi di una squadra
total_draws(Team, Result, Result2):-
    num_draw_home(Team,DrawHome, Result2),
    num_draw_away(Team,DrawAway, Result2),
    Result is DrawHome + DrawAway.

%trova il numero delle partite giocate da una squadra grazie alla somma di vittorie, pareggi e sconfitte
total_matches_played(Team, Result, Result4):-
    total_win(Team, Result1, Result4),
    total_lose(Team, Result2, Result4),
    total_draws(Team, Result3, Result4),
    Result is  Result1 + Result2 + Result3.

%trova la percentuale di vittoria di una squadra
percent_win(Team, Result, Cod):-
    start(Team, Cod, Result4),
    total_win(Team, Result1, Result4),
    total_matches_played(Team, Result2, Result4),
    Result3 is Result1 / Result2,
    Result is Result3 * 100.

%trova la percentuale di sconfitta di una squadra
percent_lose(Team, Result, Cod):-
    start(Team, Cod, Result4),
    total_lose(Team, Result1, Cod, Result4),
    total_matches_played(Team, Result2, Result4),
    Result3 is Result1 / Result2,
    Result is Result3 * 100.

%trova la percentuale di pareggio di una squadra
percent_draws(Team, Result, Cod):-
    start(Team, Cod, Result4),
    total_draws(Team, Result1, Cod, Result4),
    total_matches_played(Team, Result2,Result4),
    Result3 is Result1 / Result2,
    Result is Result3 * 100.

%trova le partite giocate in casa di una squadra
played_home(Team,Result, Result2):-
    findall(Team,Result2:matchSA(Team,_,_,_,_),Result).

%trova le partite che ancora non sono state giocate
not_played_home(Team,Result, Result2):-
    findall(Team,Result2: matchSA(Team,_,null,_,_),Result).

%trova il totale delle partite effettivamente giocate in casa
tot_played_home(Team,Play_home, Result2):-
    played_home(Team,Result, Result2),
    not_played_home(Team,Result1, Result2),
    length(Result,X),
    length(Result1,Y),
    Play_home is X - Y.

%trova la percentuale di vittorie sulle partite giocate in casa
percent_win_home(Team,Result, Cod):-
    start(Team, Cod, Result2),
    num_winner_home(Team,Ris1, Result2),
    tot_played_home(Team,Ris2, Result2),
    Ris3 is Ris1 / Ris2,
    Result is Ris3 * 100.

%trova le partite giocate fuori casa di una squadra
played_away(Team, Result, Result2):-
    findall(Team, Result2:matchSA(_,Team,_,_,_), Result).

%trova le partite che ancora non sono state giocate
not_played_away(Team,Result, Result2):-
    findall(Team, Result2:matchSA(_,Team,null,_,_), Result).

%trova il totale delle partite effettivamente giocate fuori casa
tot_played_away(Team,Play_away, Result2):-
    played_away(Team,Result, Result2),
    not_played_away(Team,Result1, Result2),
    length(Result,X),
    length(Result1,Y),
    Play_away is X - Y.

%trova la percentuale di vittorie sulle partite giocate fuori casa   
percent_win_away(Team,Result, Cod):- 
    start(Team, Cod, Result2),
    num_winner_away(Team,Ris1, Result2),
    tot_played_away(Team,Ris2, Result2),
    Ris3 is Ris1 / Ris2,
    Result is Ris3 * 100.

%trova la prossima partita di una squadra
next_match(X,Y, TeamName, Cod):-
    start(TeamName, Cod, Result2),
    findall([Home,Away],Result2:matchSA(Home,Away,null,_,_),Result),
    member([X,Y],Result),!.

%trova la differenza tra due posizioni in classifica e ne trova la percentuale
position_difference_percent(RisPercentuale,TeamName, Cod, Home, Away):-
    next_match(Home,Away,TeamName,Cod),
    start_classifica,
    findall(Casa,classifica(Casa,Home,_,_,_),Result),
    findall(Trasferta,classifica(Trasferta,Away,_,_,_),Result2),
    (( Result < Result2 ) -> Ris is Result2-Result;
        Ris is Result-Result2),
    ((TeamName==Home)-> RisPercentuale is Ris*5;
        RisPercentuale1 is Ris*5,
     RisPercentuale is 100 - RisPercentuale1).

%calcola la percentuale della forma di una squadra, grazie al numero di "W" delle ultime cinque partite
forma(Team, NumW):-
    start_classifica
    classifica(_,Team,_,X,_),
    split_string(X,',',',',Y),
    count_occurrences(Y,"W",NumW1),
    NumW2 is NumW1 / 5, 
    NumW is NumW2 * 100.


%PERCENTUALE DI VITTORIA

%calcola la percentuale di vittoria di una squadra sfruttando le funzioni precedenti
total_win_percent(Team, Cod):-
    forma(Team, NumW),
    position_difference_percent(RisPercentuale, Team, Cod, Home, Away),
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

%CALCOLO GOAL

%calcola i goal segnati dalla squadrea di casa
goal_team_home_scored(TeamName, Final):-
    consult_team(TeamName, Result2),
    findall(Goal, Result2:matchSA(TeamName, _, _, Goal,_), Result),
    tot_played_home(TeamName, PlayedSum, Result2),
    sum_list(Result, Sum),
    Final is Sum / PlayedSum.

%calcola i goal segnati dalla squadra fuori casa
goal_team_away_scored(TeamName, Final):-
    consult_team(TeamName, Result2),
    findall(Goal, Result2:matchSA(_, TeamName, _, _,Goal), Result),
    tot_played_away(TeamName, PlayedSum, Result2),
    sum_list(Result, Sum),
    Final is Sum / PlayedSum.

%calcola i goal subiti dalla squadra di casa
goal_team_home_sub(TeamName, Final):-
    consult_team(TeamName, Result2),
    findall(Goal, Result2:matchSA(TeamName, _, _, _,Goal), Result),
    tot_played_home(TeamName, PlayedSum, Result2),
    sum_list(Result, Sum),
    Final is Sum / PlayedSum.

%calcola i goal subiti dalla squadra ospite
goal_team_away_sub(TeamName, Final):-
    consult_team(TeamName, Result2),
    findall(Goal, Result2:matchSA(_, TeamName, _ ,Goal,_), Result),
    tot_played_away(TeamName, PlayedSum, Result2),
    sum_list(Result, Sum),
    Final is Sum / PlayedSum.

%calcola la media goal di una squadra rispetto al suo avversario
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
    

%PARI O DISPARI

%sfrutta le funzioni precedenti per determinare se la somma dei goal di una partita sarà pari oppure dispari
goal_odd_even(TeamName, Cod):-
    next_match(Home, Away, TeamName, Cod),
    consult_team(TeamName, Result2),
    consult_team(TeamName, Result4),
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


%DETERMINARE SE ENTRAMBE LE SQUADRE SEGNANO

%preso in ingresso una squadra, determina se nella sua prossima partita segneranno entrambi un goal oppure no
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

