function queryRG1() {
    var session = pl.create(1000);
    // session.consult('./js/base_functions.pl');
    session.consult(`
    :- multifile(matchSA/5).

    matchSA('"US Salernitana 1919"', '"AS Roma"', '"AWAY_TEAM"', 0, 1).
    matchSA('"AS Roma"', '"US Cremonese"', '"HOME_TEAM"', 1, 0).
    matchSA("Juventus FC", "AS Roma", "DRAW", 1, 1).
   
    classifica(1,'"SSC Napoli"', 113, '"W,W,W,W,W"').
    classifica(2,'"FC Internazionale Milano"', 108, '"W,W,L,W,D"').
    classifica(3,'"AS Roma"', 100, '"W,L,W,W,D"').
    classifica(4,'"SS Lazio"', 110, '"D,D,W,W,D"').
    classifica(5,'"Atalanta BC"', 102, '"L,W,D,W,W"').
    classifica(6,'"Juventus FC"', 109, '"L,D,L,W,W"').
    classifica(7,'"AC Milan",' 98, '"L,L,L,D,D"').
    classifica(8,'"Torino FC"', 586, '"W,D,W,L,D"').
    classifica(9,'"Udinese Calcio"', 115,'"L,D,W,L,L"').
    classifica(10,'"Bologna FC 1909"', 103, '"W,W,D,W,L"').
    classifica(11,'"AC Monza"', 5911, '"D,W,D,W,D"').
    classifica(12,'"Empoli FC"', 445, '"L,D,W,W,D"').
    classifica(13,'"ACF Fiorentina"', 99, '"L,D,L,L,W"').
    classifica(14,'"US Lecce"', 5890, '"W,L,L,D,D"').
    classifica(15,'"US Sassuolo Calcio"', 471, '"W,W,D,L,L"').
    classifica(16,'"US Salernitana 1919"', 455, '"W,L,L,D,L"').
    classifica(17,'"Spezia Calcio"', 488, '"L,L,L,W,D"').
    classifica(18,'"Hellas Verona FC"', 450, '"D,D,W,L,W"').
    classifica(19,'"UC Sampdoria"', 584, '"D,L,L,L,L"').
    classifica(20,'"US Cremonese"', 457, '"L,L,D,L,L"').
    

    
    
    
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
        atom_string(Team, Team1),
        atom_concat('database_MATCHES-',Team1,Result1),
        atom_concat(Result1,'.pl',Result2),
      
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
        atom_string(Team, Team1),
        atom_concat('database_MATCHES-',Team1,Result1),
        atom_concat(Result1,'.pl',Result2),
        num_winner_away(Team,Ris1),
        tot_played_away(Team,Ris2),
        Ris3 is Ris1 / Ris2,
        Result is Ris3 * 100.
    
    next_match(X,Y, TeamName, Cod):-
        atom_string(TeamName, TeamName1),
        atom_concat('database_MATCHES-',TeamName1,Result1),
        atom_concat(Result1,'.pl',Result2),
        findall([Home,Away],matchSA(Home,Away,null,_,_),Result),
        member([X,Y],Result),!.
    
    cerca(RisPercentuale,TeamName, Cod, Home, Away):-
        next_match(Home,Away,TeamName,Cod),
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
        write(Home), write(' - '),write(Away),
        Win is Win2 / 4.    
    
    
    `);
    //session.consult('./js/database_MATCHES-AS Roma.pl');
    console.log(session);
    //var query = `forma('"AS Roma"',  X).`;
    var query = 'matchSA("AS Roma",Y,Z,W,P).';
    session.query(query, {
        success: (goal) => console.log("goal: " + goal),
        error: (err) => console.log("err: " + err),
    });
    session.answer((a) => console.log(a));
    //session.query('matchSA("FC Internazionale Milano", "AS Roma", "AWAY_TEAM", 1, 2).');


    function inform(msg) {
        if (msg !== false && msg !== null) {
            show_result1.innerHTML += '<div>' + msg + '</div>'
        } else {

            show_result1.innerHTML += '<div>' + 'error' + '</div>'
        }
    }

    var count_answers = 0
    var callback = function (answer) {
        //console.log(session)
        if (answer === false) {
            console.log(answer);
            inform('DONE, #answers=' + count_answers)
            return
        } else
            if (answer === null) {
                console.log('null');
                inform('TIMEOUT, #answers=' + count_answers)
                return
            } else {
                console.log(answer);
            }
        // loop
        ++count_answers
        inform(pl.format_answer(answer))
        //  session.answer(callback)
    }
    // start the query loop
    session.answer(callback)
};
(
    window.onload = () => {
        document.querySelector("button").onclick = () => {
            queryRG1();

        }
    }

)();

function queryRG() {
    var session = pl.create(1000)

    var code_pl = `
        :- use_module(library(lists)).
        fruit("apple").
        fruit("pear").
        fruit("banana").
        fruits_in(Xs, X) :- member(X, Xs), fruit(X).
      `
    var parsed = session.consult(code_pl)
    var query = session.query('fruits_in(["apple", "pear", "banana"], X).')

    function inform(msg) {
        show_result1.innerHTML += '<div>' + msg + '</div>'
    }

    var count_answers = 0
    var callback = function (answer) {
        if (answer === false) {
            inform('DONE, #answers=' + count_answers)
            return
        }
        if (answer === null) {
            inform('TIMEOUT, #answers=' + count_answers)
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
