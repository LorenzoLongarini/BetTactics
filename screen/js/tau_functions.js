function queryRG1() {
    var session = pl.create();
    //session.consult('./js/base_functions.pl');
    var knowledge = `
   % :- use_module(library(char)).
   :- use_module(library(lists)).
    matchSA(Roma, Cremonese, HOME_TEAM, 1, 0).
    lol(ciao).
    sum_list([], 0).
    sum_list([H|T], Sum) :-
       sum_list(T, Rest),
       ((H == null) -> Sum is 0 + Rest;  Sum is H + Rest).

    goal_do_home(TeamName,Sum):-
    findall(Goal, matchSA(TeamName, _, _, Goal,_), Result),
    sum_list(Result, Sum).

    winner_home(Team,Result):-   
    findall(Team,matchSA(Team,_,HOME_TEAM,_,_),Result).

    num_winner_home(Team,WinHome):-
    winner_home(Team,Result),
    length(Result,WinHome).
    `
    session.consult(knowledge)
    //session.consult('./js/database_MATCHES-AS Roma.pl');
    console.log(session)
    var selectElement = document.getElementById("mySelect");
    const selectedOption = selectElement.options[selectElement.selectedIndex].label;
    var query = 'lol(X).';
    //var query = `forma('"AS Roma"',  X).`;
    //var query = 'num_winner_home(Roma,P).';
    //var query = 'lol(\'"ciao"\').'
    //var query = 'matchSA(\'"' + selectedOption + '"\',\'"Cremonese"\',X,1,0).';
    session.query(query, {
        success: (goal) => console.log("goal: " + goal),
        error: (err) => console.log("err: " + err),
    });
    session.answer((a) => console.log(a));
    //session.query('matchSA("FC Internazionale Milano", "AS Roma", "AWAY_TEAM", 1, 2).');


    function inform(msg) {
        // if (msg !== false && msg !== null) {
        show_result1.innerHTML += '<div>' + msg + '</div>'
        // } else {

        //     show_result1.innerHTML += '<div>' + 'error' + '</div>'
        // }
    }

    // var count_answers = 0
    var callback = function (answer) {
        // //console.log(session)
        // if (answer === false) {
        //     console.log(answer);
        //     inform('DONE, #answers=' + count_answers)
        //     return
        // } else
        //     if (answer === null) {
        //         console.log('null');
        //         inform('TIMEOUT, #answers=' + count_answers)
        //         return
        //     } else {
        //         console.log(answer);
        //     }
        // // loop
        // ++count_answers
        inform(pl.format_answer(answer))
        //  session.answer(callback)
    }
    // start the query loop
    session.answer(callback)
};
//(
window.onload = () => {
    document.querySelector("#button").onclick = () => {
        // event.preventDefault();
        queryRG();
    }
}

//) ();

function queryRG() {
    var session = pl.create(1000)

    let functionCall = ` matchSA("Salernitana", "Roma", "AWAY_TEAM", 0, 1).
    matchSA("Roma", "Cremonese", "HOME_TEAM", 1, 0).
    matchSA("Juventus", "Roma", "DRAW", 1, 1).
    matchSA("Roma", "Monza", "HOME_TEAM", 3, 0).
    matchSA("Udinese", "Roma", "HOME_TEAM", 4, 0).
    matchSA("Empoli", "Roma", "AWAY_TEAM", 1, 2).
    matchSA("Roma", "Atalanta", "AWAY_TEAM", 0, 1).
    matchSA("Inter", "Roma", "AWAY_TEAM", 1, 2).
    matchSA("Roma", "Lecce", "HOME_TEAM", 2, 1).
    matchSA("Sampdoria", "Roma", "AWAY_TEAM", 0, 1).
    matchSA("Roma", "Napoli", "AWAY_TEAM", 0, 1).
    matchSA("Verona", "Roma", "AWAY_TEAM", 1, 3).
    matchSA("Roma", "Lazio", "AWAY_TEAM", 0, 1).
    matchSA("Sassuolo", "Roma", "DRAW", 1, 1).
    matchSA("Roma", "Torino", "DRAW", 1, 1).
    matchSA("Roma", "Bologna", "HOME_TEAM", 1, 0).
    matchSA("Milan", "Roma", "DRAW", 2, 2).
    matchSA("Roma", "Fiorentina", "HOME_TEAM", 2, 0).
    matchSA("Spezia Calcio", "Roma", "AWAY_TEAM", 0, 2).
    matchSA("Napoli", "Roma", "HOME_TEAM", 2, 1).
    matchSA("Roma", "Empoli", "HOME_TEAM", 2, 0).
    matchSA("Lecce", "Roma", null, null, null).
    matchSA("Roma", "Verona", null, null, null).
    matchSA("Cremonese", "Roma", null, null, null).
    matchSA("Roma", "Juventus", null, null, null).
    matchSA("Roma", "Sassuolo", null, null, null).
    matchSA("Lazio", "Roma", null, null, null).
    matchSA("Roma", "Sampdoria", null, null, null).
    matchSA("Torino", "Roma", null, null, null).
    matchSA("Roma", "Udinese", null, null, null).
    matchSA("Atalanta", "Roma", null, null, null).
    matchSA("Roma", "Milan", null, null, null).
    matchSA("Monza", "Roma", null, null, null).
    matchSA("Roma", "Inter", null, null, null).
    matchSA("Bologna", "Roma", null, null, null).
    matchSA("Roma", "Salernitana", null, null, null).
    matchSA("Fiorentina", "Roma", null, null, null).
    matchSA("Roma", "Spezia Calcio", null, null, null).
    `;

    let regex = /'([^']*)'/g;
    let result = functionCall.replace(regex, '"$1"');
    //`+ result + `

    var code_pl = `
    :- use_module(library(lists)).
    matchSA('"Salernitana"', '"Roma"', '"AWAY_TEAM"', 0, 1).
    matchSA('"Roma"', '"Cremonese"', '"HOME_TEAM"', 1, 0).
    matchSA('"Juventus"', '"Roma"', '"DRAW"', 1, 1).
    matchSA('"Roma"', '"Monza"', '"HOME_TEAM"', 3, 0).
    matchSA('"Udinese"',' "Roma"', '"HOME_TEAM"', 4, 0).
    matchSA('"Empoli"', '"Roma"', '"AWAY_TEAM"', 1, 2).
    matchSA('"Roma"', '"Atalanta"', '"AWAY_TEAM"', 0, 1).
    matchSA('"Inter"', '"Roma"', '"AWAY_TEAM"', 1, 2).
    matchSA('"Roma"', '"Lecce"', '"HOME_TEAM"', 2, 1).
    matchSA('"Sampdoria"', '"Roma"', '"AWAY_TEAM"', 0, 1).
    matchSA('"Roma"', '"Napoli"', '"AWAY_TEAM"', 0, 1).
    matchSA('"Verona"', '"Roma"', '"AWAY_TEAM"', 1, 3).
    matchSA('"Roma"', '"Lazio"', '"AWAY_TEAM"', 0, 1).
    matchSA('"Sassuolo"', '"Roma"','"DRAW"', 1, 1).
    matchSA('"Roma"', '"Torino"', '"DRAW"', 1, 1).
    matchSA('"Roma"', '"Bologna"', '"HOME_TEAM"', 1, 0).
    matchSA('"Milan"', '"Roma"', '"DRAW"', 2, 2).
    matchSA('"Roma"', '"Fiorentina"', '"HOME_TEAM"', 2, 0).
    matchSA('"Spezia Calcio"', '"Roma"', '"AWAY_TEAM"', 0, 2).
    matchSA('"Napoli"', '"Roma"', '"HOME_TEAM"', 2, 1).
    matchSA('"Roma"', '"Empoli"', '"HOME_TEAM"', 2, 0).
    matchSA('"Lecce"', '"Roma"', null, null, null).
    matchSA('"Roma"', '"Verona"', null, null, null).
    matchSA('"Cremonese"', '"Roma"', null, null, null).
    matchSA('"Roma"', '"Juventus"', null, null, null).
    matchSA('"Roma"', '"Sassuolo"', null, null, null).
    matchSA('"Lazio"', '"Roma"', null, null, null).
    matchSA('"Roma"', '"Sampdoria"', null, null, null).
    matchSA('"Torino"', '"Roma"', null, null, null).
    matchSA('"Roma"', '"Udinese"', null, null, null).
    matchSA('"Atalanta"', '"Roma"', null, null, null).
    matchSA('"Roma"', '"Milan"', null, null, null).
    matchSA('"Monza"', '"Roma"', null, null, null).
    matchSA('"Roma"', '"Inter"', null, null, null).
    matchSA('"Bologna"', '"Roma"', null, null, null).
    matchSA('"Roma"', '"Salernitana"', null, null, null).
    matchSA('"Fiorentina"', '"Roma"', null, null, null).
    matchSA('"Roma"', '"Spezia Calcio"', null, null, null).
    matchSA('"Lecce"', '"Inter"', '"AWAY_TEAM"', 1, 2).
    matchSA('"Sassuolo"', '"Lecce"', '"HOME_TEAM"', 1, 0).
    matchSA('"Lecce"', '"Empoli"', '"DRAW"', 1, 1).
    matchSA('"Napoli"', '"Lecce"', '"DRAW"', 1, 1).
    matchSA('"Torino"', '"Lecce"', '"HOME_TEAM"', 1, 0).
    matchSA('"Lecce"', '"Monza"', '"DRAW"', 1, 1).
    matchSA('"Salernitana"', '"Lecce"', '"AWAY_TEAM"', 1, 2).
    matchSA('"Lecce"', '"Cremonese"', '"DRAW"', 1, 1).
    matchSA('"Lecce"', '"Fiorentina"', '"DRAW"', 1, 1).
    matchSA('"Bologna"', '"Lecce"', '"HOME_TEAM"', 2, 0).
    matchSA('"Lecce"', '"Juventus"', '"AWAY_TEAM"', 0, 1).
    matchSA('"Udinese"', '"Lecce"', '"DRAW"', 1, 1).
    matchSA('"Lecce"', '"Atalanta"', '"HOME_TEAM"', 2, 1).
    matchSA('"Sampdoria"', '"Lecce"', '"AWAY_TEAM"', 0, 2).
    matchSA('"Lecce"', '"Lazio"', '"HOME_TEAM"', 2, 1).
    matchSA('"Spezia Calcio"', '"Lecce"', '"DRAW"', 0, 0).
    matchSA('"Lecce"', '"Milan"', '"DRAW"', 2, 2).
    matchSA('"Verona"', '"Lecce"', '"HOME_TEAM"', 2, 0).
    matchSA('"Lecce"', '"Salernitana"', '"AWAY_TEAM"', 1, 2).
    matchSA('"Cremonese"', '"Lecce"', '"AWAY_TEAM"', 0, 2).
    matchSA('"Lecce"', '"Roma"', '"DRAW"', 1, 1).
    matchSA('"Atalanta"', '"Lecce"', 'null', null, null).
    matchSA('"Lecce"', '"Sassuolo"', 'null', null, null).
    matchSA('"Inter"', '"Lecce"', 'null', null, null).
    matchSA('"Lecce"', '"Torino"', 'null', null, null).
    matchSA('"Fiorentina"', '"Lecce"', 'null', null, null).
    matchSA('"Empoli"', '"Lecce"', 'null', null, null).
    matchSA('"Lecce"', '"Napoli"', 'null', null, null).
    matchSA('"Lecce"', '"Sampdoria"', 'null', null, null).
    matchSA('"Milan"', '"Lecce"', 'null', null, null).
    matchSA('"Lecce"', '"Udinese"', 'null', null, null).
    matchSA('"Juventus"', '"Lecce"', 'null', null, null).
    matchSA('"Lecce"', '"Verona"', 'null', null, null).
    matchSA('"Lazio"', '"Lecce"', 'null', null, null).
    matchSA('"Lecce"', '"Spezia Calcio"', 'null', null, null).
    matchSA('"Monza"', '"Lecce"', 'null', null, null).
    matchSA('"Lecce"', '"Bologna"', 'null', null, null).
    classifica(1,'"Napoli"', 113, '"W,W,W,W,W"', 56).
    classifica(2,'"Inter"', 108, '"W,W,L,W,D"', 43).
    classifica(3,'"Atalanta"', 102, '"W,L,W,D,W"', 41).
    classifica(4,'"Juventus"', 109, '"W,L,D,L,W"', 41).
    classifica(5,'"Roma"', 100, '"D,W,L,W,W"', 41).
    classifica(6,'"Milan"', 98, '"W,L,L,L,D"', 41).
    classifica(7,'"Lazio"', 110, '"L,D,D,W,W"', 39).
    classifica(8,'"Torino"', 586, '"L,W,D,W,L"', 30).
    classifica(9,'"Udinese"', 115, '"L,D,W,L,L"', 29).
    classifica(10,'"Bologna"', 103, '"W,W,D,W,L"', 29).
    classifica(11,'"Empoli"', 445, '"D,L,D,W,W"', 27).
    classifica(12,'"Monza"', 5911, '"D,W,D,W,D"', 26).
    classifica(13,'"Lecce"', 5890, '"D,W,L,L,D"', 24).
    classifica(14,'"Fiorentina"', 99, '"L,D,L,L,W"', 24).
    classifica(15,'"Sassuolo"', 471, '"W,W,D,L,L"', 23).
    classifica(16,'"Salernitana"', 455, '"L,W,L,L,D"', 21).
    classifica(17,'"Spezia Calcio"', 488, '"D,L,L,L,W"', 19).
    classifica(18,'"Verona"', 450, '"D,D,W,L,W"', 14).
    classifica(19,'"Sampdoria"', 584, '"D,L,L,L,L"', 10).
    classifica(20,'"Cremonese"', 457, '"L,L,D,L,L"', 8).
       
    sum_list([], 0).
    sum_list([H|T], Sum) :-
    sum_list(T, Rest),
    ((H == null) -> Sum is 0 + Rest;  Sum is H + Rest).

    goal_do_home(TeamName,Sum):-
    findall(Goal, matchSA(TeamName, _, _, Goal,_), Result),
    sum_list(Result, Sum).

    winner_home(Team,Result):-   
    findall(Team,matchSA(Team,_,'"HOME_TEAM"',_,_),Result).

    num_winner_home(Team,WinHome):-
    winner_home(Team,Result),
    length(Result,WinHome).

    winner_away(Team,Result):-
    findall(Team,matchSA(_,Team,'"AWAY_TEAM"',_,_),Result).

%sfrutta la lista creata precedentemente e ne conta le occorrenze
num_winner_away(Team,WinAway):-
    winner_away(Team,Result),
    length(Result,WinAway).

%somma tutte le vittorie di una squadra
total_win(Team, Result):-
    num_winner_home(Team,WinHome),
    num_winner_away(Team,WinAway),
    Result is WinHome + WinAway.

%lose_home trova tutte le partite in cui la squadra ha perso in casa
lose_home(Team,Result):-
    findall(Team,matchSA(Team,_,'"AWAY_TEAM"',_,_),Result).

%sfrutta la lista creata precedentemente e ne conta le occorrenze.
num_lose_home(Team,LoseHome):-
    lose_home(Team,Result),
    length(Result,LoseHome).

%lose_home trova tutte le partite in cui la squadra ha perso fuori casa
lose_away(Team,Result):-
    findall(Team,matchSA(_,Team,'"HOME_TEAM"',_,_),Result).

%sfrutta la lista creata precedentemente e ne conta le occorrenze
num_lose_away(Team,LoseAway):-
    lose_away(Team,Result),
    length(Result,LoseAway).

%somma tutte le sconfitte di una squadra
total_lose(Team, Result):-
    num_lose_home(Team,LoseHome),
    num_lose_away(Team,LoseAway),
    Result is LoseHome + LoseAway.

%draw_home trova tutte le partite in cui la squadra ha pareggiato in casa
draw_home(Team,Result):-
    findall(Team,matchSA(Team,_,'"DRAW"',_,_),Result).

%sfrutta la lista creata precedentemente e ne conta le occorrenze
num_draw_home(Team,DrawHome):-
    draw_home(Team,Result),
    length(Result,DrawHome).

%draw_home trova tutte le partite in cui la squadra ha pareggiato fuori casa
draw_away(Team,Result):-
    findall(Team,matchSA(_,Team,'"DRAW"',_,_),Result).

%sfrutta la lista creata precedentemente e ne conta le occorrenze
num_draw_away(Team,DrawAway):-
    draw_away(Team,Result),
    length(Result,DrawAway).

%somma tutti i pareggi di una squadra
total_draws(Team, Result):-
    num_draw_home(Team,DrawHome),
    num_draw_away(Team,DrawAway),
    Result is DrawHome + DrawAway.

%trova il numero delle partite giocate da una squadra grazie alla somma di vittorie, pareggi e sconfitte
total_matches_played(Team, Result):-
    total_win(Team, Result1),
    total_lose(Team, Result2),
    total_draws(Team, Result3),
    Result is  Result1 + Result2 + Result3.

%trova la percentuale di vittoria di una squadra
percent_win(Team, Result):-
    total_win(Team, Result1),
    total_matches_played(Team, Result2),
    Result3 is Result1 / Result2,
    Result is Result3 * 100.

%trova la percentuale di sconfitta di una squadra
percent_lose(Team, Result):-
    total_lose(Team, Result1),
    total_matches_played(Team, Result2),
    Result3 is Result1 / Result2,
    Result is Result3 * 100.

%trova la percentuale di pareggio di una squadra
percent_draws(Team, Result):-
    total_draws(Team, Result1),
    total_matches_played(Team, Result2),
    Result3 is Result1 / Result2,
    Result is Result3 * 100.

%trova le partite giocate in casa di una squadra
played_home(Team,Result):-
    findall(Team,matchSA(Team,_,_,_,_),Result).

%trova le partite che ancora non sono state giocate
not_played_home(Team,Result):-
    findall(Team, matchSA(Team,_,null,_,_),Result).

%trova il totale delle partite effettivamente giocate in casa
tot_played_home(Team,Play_home):-
    played_home(Team,Result),
    not_played_home(Team,Result1),
    length(Result,X),
    length(Result1,Y),
    Play_home is X - Y.

%trova la percentuale di vittorie sulle partite giocate in casa
percent_win_home(Team,Result):-
    num_winner_home(Team,Ris1),
    tot_played_home(Team,Ris2),
    Ris3 is Ris1 / Ris2,
    Result is Ris3 * 100.

%trova le partite giocate fuori casa di una squadra
played_away(Team, Result):-
    findall(Team, matchSA(_,Team,_,_,_), Result).

%trova le partite che ancora non sono state giocate
not_played_away(Team,Result):-
    findall(Team, matchSA(_,Team,null,_,_), Result).

%trova il totale delle partite effettivamente giocate fuori casa
tot_played_away(Team,Play_away):-
    played_away(Team,Result),
    not_played_away(Team,Result1),
    length(Result,X),
    length(Result1,Y),
    Play_away is X - Y.

%trova la percentuale di vittorie sulle partite giocate fuori casa   
percent_win_away(Team, Result):- 
    num_winner_away(Team,Ris1),
    tot_played_away(Team,Ris2),
    Ris3 is Ris1 / Ris2,
    Result is Ris3 * 100.

%trova la prossima partita di una squadra
next_match(X,Y, TeamName):-
    findall([Home,Away],matchSA(Home,Away,null,_,_),Result),
    member([X,Y],Result),!.

%trova la differenza tra due posizioni in classifica e ne trova la percentuale
position_difference_percent(RisPercentuale,TeamName, Home, Away):-
    next_match(Home,Away,TeamName),
    findall(Casa,classifica(Casa,Home,_,_,_),Result),
    findall(Trasferta,classifica(Trasferta,Away,_,_,_),Result2),
    (( Result < Result2 ) -> Ris is Result2-Result;
        Ris is Result-Result2),
    ((TeamName==Home)-> RisPercentuale is Ris*5;
        RisPercentuale1 is Ris*5,
     RisPercentuale is 100 - RisPercentuale1).

%calcola la percentuale della forma di una squadra, grazie al numero di "W" delle ultime cinque partite
%forma(Team, NumW):-
   % classifica(_,Team,_,X,_),
    %split_string(X,',',',',Y),
    %count_occurrences(Y,"W",NumW1),percent_win
   % NumW2 is NumW1 / 5, 
    %NumW is NumW2 * 100.


%PERCENTUALE DI VITTORIA

%calcola la percentuale di vittoria di una squadra sfruttando le funzioni precedenti
total_win_percent(Team, Win2, Home, Away):-
    %forma(Team, NumW),
    position_difference_percent(RisPercentuale, Team, Home, Away),
    percent_win(Team, Result),
    ((Team == Home)->percent_win_home(Team, X1);
      percent_win_away(Team, X1)),
    Win2 is RisPercentuale + Result + X1.
    %WinStamp is Win2.
    %write('La prossima partita di '),
    %write(Team),
    %write(' : '),
    %write(Home),
    %write(' - '),
    %writeln(Away),
    %Win is Win2 / 4,
    %write(Team),
    %write(' ha una percentuale di vittoria pari al '),
    %format(atom(WinStamp), "~2f",[Win]),
    %write(WinStamp),
    %write(' %').
      `
    var selectElement = document.getElementById("mySelect")
    const selectedOption = selectElement.options[selectElement.selectedIndex].label
    var parsed = session.consult(code_pl)
    // var query = session.query('total_matches_played(\'"' + selectedOption + '"\', X).')
    //var query = session.query('total_lose(\'"' + selectedOption + '"\', X).')
    //var query = session.query('tot_played_home(\'"' + selectedOption + '"\', X).')
    var query = session.query('total_win_percent(\'"' + selectedOption + '"\',X, Y, Z).')
    //var query = session.query('percent_win_home(\'"' + selectedOption + '"\', Y).')

    //var query = session.query('position_difference_percent(X,\'"' + selectedOption + '"\', Y, Z).')
    //var query = session.query('percent_win(\'"' + selectedOption + '"\', Y).')
    //var query = session.query('num_winner_home(\'"' + selectedOption + '"\',P).')
    //var query = session.query('matchSA(Roma, Cremonese, HOME_TEAM, 1, 0).')
    //= session.query('fruits_in([apple, pear, banana], X).')

    function inform(msg) {
        show_result1.innerHTML += '<div>' + msg + '</div>'
    }

    var count_answers = 0
    var callback = function (answer) {
        if (answer === false) {
            // inform('DONE, #answers=' + count_answers)
            return
        }
        if (answer === null) {
            //inform('TIMEOUT, #answers=' + count_answers)
            return
        }
        // loop
        ++count_answers
        inform(pl.format_answer(answer))
        session.answer(callback)
    }
    // start the query loop
    session.answer(callback)
};
