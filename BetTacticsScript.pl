:- use_module(library(http/http_open)).
:- use_module(library(http/json)).

list_json_array(List):-
  setup_call_cleanup(
    http_open('http://api.football-data.org/v4/matches/418777/head2head?limit=5', In, [request_header('X-Auth-Token'='8ca899dc4862498d90e40bd53563f247'),request_header('Accept'='application/json')]),
      %prende lo stream che viene salvato in In e lo salva in List
      json_read_dict(In,List),
    close(In)
  ).

take_element([]).
take_element([H|T]) :-
  write('partita('),
  write(H.homeTeam.name), write(', '),
  write(H.awayTeam.name), write(', '),
  write(H.score.winner), write(', '),
  write(H.score.fullTime.home),writeln(').'),

  take_element(T).

start :-
      tell('database_CALCIO6.pl'),
      list_json_array(List),
      take_element(List.matches),
    fail.
start :- told.
