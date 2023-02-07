:- use_module(library(http/http_open)).
:- use_module(library(http/json)).
%restituisce i testa a testa di una gara specifica
list_json_array_h2h(List_h2h):-
  setup_call_cleanup(
    http_open('http://api.football-data.org/v4/matches/418777/head2head?limit=5', In, [request_header('X-Auth-Token'='8ca899dc4862498d90e40bd53563f247'),request_header('Accept'='application/json')]),
      %prende lo stream che viene salvato in In e lo salva in List
      json_read_dict(In,List_h2h),
    close(In)
).

take_h2h([]).
take_h2h([H|T]) :-
  write('partita('),
  write(H.homeTeam.name), write(', '),
  write(H.awayTeam.name), write(', '),
  write(H.score.winner), write(', '),
  write(H.score.fullTime.home),writeln(').'),

  take_h2h(T).

start_h2h :-
      tell('database_H2H.pl'),
      list_json_array_h2h(List_h2h),
      take_h2h(List_h2h.matches),
    fail.
start_h2h:-told.

%restituisce la lista marcatori della serie A
list_json_array_scorer(ListScorers):-
  setup_call_cleanup(
    http_open('http://api.football-data.org/v4/competitions/SA/scorers', In, [request_header('X-Auth-Token'='8ca899dc4862498d90e40bd53563f247'),request_header('Accept'='application/json')]),
      %prende lo stream che viene salvato in In e lo salva in List
      json_read_dict(In,ListScorers),
    close(In)
).

take_scorers_list([]).
take_scorers_list([H|T]) :-
  write('marcatore('),
  write('"'),
  write(H.player.name),write('"'),  write(', '),
  write(H.goals), write(', '),
  write(H.assists), write(', '),
  write(H.penalties),writeln(').'),

  take_scorers_list(T).

start_scorer :-
      tell('database_SCORERS.pl'),
      list_json_array_scorer(ListScorers),
     take_scorers_list(ListScorers.scorers),
    fail.
start_scorer:-told.

%restituisce le ultime 10 gare di una squadra
list_json_array_matches_SA(ListMatchesSA,X):-
  atom_concat('http://api.football-data.org/v4/teams/',X,Y),
  atom_concat(Y,'/matches?competitions=2019',Z),

  setup_call_cleanup(
      http_open(Z, In, [request_header('X-Auth-Token'='8ca899dc4862498d90e40bd53563f247'),request_header('Accept'='application/json')]),
      %prende lo stream che viene salvato in In e lo salva in List
      json_read_dict(In,ListMatchesSA),
    close(In)
).

take_matches_SA_list([]).
take_matches_SA_list([H|T]) :-
  write('matchSA('),
  
  writeq(H.homeTeam.name),  write(', '),
 
  writeq(H.awayTeam.name), write(', '),
  writeq(H.score.winner), write(', '),
  writeq(H.score.fullTime.home),write(', '),
  writeq(H.score.fullTime.away),writeln(').'),


  take_matches_SA_list(T).


start_matches_SA(X,W) :-
 atom_concat('database_MATCHES-',X,Y),
 atom_concat(Y,'.pl',Z),
      tell(Z),
      list_json_array_matches_SA(ListMatchesSA,W),
     take_matches_SA_list(ListMatchesSA.matches),
    fail.
start_matches_SA(_,_):-told.






%restituisce la classifica del campionato
list_json_array_results(List_res):-
  setup_call_cleanup(
    http_open('http://api.football-data.org/v4/competitions/SA/standings', In, [request_header('X-Auth-Token'='8ca899dc4862498d90e40bd53563f247'),request_header('Accept'='application/json')]),
      %prende lo stream che viene salvato in In e lo salva in List
     json_read_dict(In,List_res),
    close(In)
  ).

%seleziona solo la prima table(quella TOTAL)
select_first(X,R):-
  member(X,R),!.

start_results :-
      tell('database_RESULTS_SA.pl'),
      list_json_array_results(List_res),
      maplist(get_dict(table), List_res.get(standings), R),
      
      select_first(X,R),
      member(Y,X),
      
      write('classifica('),
      write(Y.position), write(',"'),
      write(Y.team.name),write('", '),
      write(Y.team.id),write(', "'),
      write(Y.form),writeln('").'),

    fail.
start_results :- told.

