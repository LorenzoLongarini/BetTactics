:- use_module(library(http/http_open)).
:- use_module(library(http/json)).


%genera un knowledge base con tutte le partite di una determinata squadra

%prende in ingresso il codice di una squadra, 
%genera uno Stream che viene trasformato in un dict che viene restituito dalla funzione
list_json_array_matches_SA(ListMatchesSA,Code):-
  atom_concat('http://api.football-data.org/v4/teams/',Code,X),
  atom_concat(X,'/matches?competitions=2019',Url),
  setup_call_cleanup(
      http_open(Url,
      Stream,
      [request_header('X-Auth-Token'='8ca899dc4862498d90e40bd53563f247'),request_header('Accept'='application/json')]),
      json_read_dict(Stream,ListMatchesSA),
    close(Stream)
).

%prende in ingresso la lista generata dalla funzione precedente e scrive all'interno tutte le gare di serie A di quella squadra
take_matches_SA_list([], Team).
take_matches_SA_list([H|T], Team) :-
 
  write('matchSA(\''),
  writeq(Team),  write('\', \''),
  writeq(H.homeTeam.shortName),  write('\', \''),
  writeq(H.awayTeam.shortName), write('\', \''),
  writeq(H.score.winner), write('\', '),
  writeq(H.score.fullTime.home),write(', '),
  writeq(H.score.fullTime.away),writeln(').'),
  take_matches_SA_list(T, Team).

%prende in ingresso il nome di una squadra e il codice associato ad essa e crea un nuovo file che verrà popolato
%grazie alle due funzioni precedenti
start_matches_SA(Team,Code) :-
 atom_concat('database_',Team,X),
 atom_concat(X,'.pl',FileName),
      tell(FileName),
      write(':- module(\'database_'),
      write(Team),
      writeln('.pl\', [matchSA/5]).'),
      writeln(':- multifile(matchSA/5).'),
      list_json_array_matches_SA(ListMatchesSA,Code),
      take_matches_SA_list(ListMatchesSA.matches, Team),
      fail.
start_matches_SA(_,_):-told.




%genera un knowledge base con la classifica del campionato
 
%genera uno Stream che viene trasformato in un dict che viene restituito dalla funzione
list_json_array_results(List_res):-
  setup_call_cleanup(
      http_open('http://api.football-data.org/v4/competitions/SA/standings',
      Stream,
      [request_header('X-Auth-Token'='8ca899dc4862498d90e40bd53563f247'),request_header('Accept'='application/json')]),
      json_read_dict(Stream,List_res),
      close(Stream)
  ).

%dato che sono presenti tre table, questa funzione effettua la selezione solamente della prima
select_first(X,R):-
  member(X,R),!.

%crea un nuovo file che verrà popolato grazie alle due funzioni precedenti
start_results :-
      tell('database_RESULTS_SA.pl'),
      list_json_array_results(List_res),
      maplist(get_dict(table), List_res.get(standings), R), 
      select_first(X,R),
      member(Y,X),
      write('classifica('),
      write(Y.position), write(',\'"'),
      write(Y.team.shortName),write('"\', '),
      write(Y.team.id),write(', \'"'),
      write(Y.form),write('"\', '),
      write(Y.points),writeln(').'),
      fail.
start_results :- told.

