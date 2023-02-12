:- module('database_Inter.pl', [matchSA/5]).
:- multifile(matchSA/5).
matchSA("Lecce", "Inter", "AWAY_TEAM", 1, 2).
matchSA("Inter", "Spezia Calcio", "HOME_TEAM", 3, 0).
matchSA("Lazio", "Inter", "HOME_TEAM", 3, 1).
matchSA("Inter", "Cremonese", "HOME_TEAM", 3, 1).
matchSA("Milan", "Inter", "HOME_TEAM", 3, 2).
matchSA("Inter", "Torino", "HOME_TEAM", 1, 0).
matchSA("Udinese", "Inter", "HOME_TEAM", 3, 1).
matchSA("Inter", "Roma", "AWAY_TEAM", 1, 2).
matchSA("Sassuolo", "Inter", "AWAY_TEAM", 1, 2).
matchSA("Inter", "Salernitana", "HOME_TEAM", 2, 0).
matchSA("Fiorentina", "Inter", "AWAY_TEAM", 3, 4).
matchSA("Inter", "Sampdoria", "HOME_TEAM", 3, 0).
matchSA("Juventus", "Inter", "HOME_TEAM", 2, 0).
matchSA("Inter", "Bologna", "HOME_TEAM", 6, 1).
matchSA("Atalanta", "Inter", "AWAY_TEAM", 2, 3).
matchSA("Inter", "Napoli", "HOME_TEAM", 1, 0).
matchSA("Monza", "Inter", "DRAW", 2, 2).
matchSA("Inter", "Verona", "HOME_TEAM", 1, 0).
matchSA("Inter", "Empoli", "AWAY_TEAM", 0, 1).
matchSA("Cremonese", "Inter", "AWAY_TEAM", 1, 2).
matchSA("Inter", "Milan", "HOME_TEAM", 1, 0).
matchSA("Sampdoria", "Inter", null, null, null).
matchSA("Inter", "Udinese", null, null, null).
matchSA("Bologna", "Inter", null, null, null).
matchSA("Inter", "Lecce", null, null, null).
matchSA("Spezia Calcio", "Inter", null, null, null).
matchSA("Inter", "Juventus", null, null, null).
matchSA("Inter", "Fiorentina", null, null, null).
matchSA("Salernitana", "Inter", null, null, null).
matchSA("Inter", "Monza", null, null, null).
matchSA("Empoli", "Inter", null, null, null).
matchSA("Inter", "Lazio", null, null, null).
matchSA("Verona", "Inter", null, null, null).
matchSA("Roma", "Inter", null, null, null).
matchSA("Inter", "Sassuolo", null, null, null).
matchSA("Napoli", "Inter", null, null, null).
matchSA("Inter", "Atalanta", null, null, null).
matchSA("Torino", "Inter", null, null, null).
goal_do_home(TeamName,Sum):-
    findall(Goal, matchSA(TeamName, _, _, Goal,_), Result),
    sum_list(Result, Sum).

winner_home(Team,Result):-   
    % atom_string(TeamName, TeamName1),
    % atom_concat('database_',TeamName1,Result1),
    % atom_concat(Result1,'.pl',Result2),
    % consult(Result2),
    % use_module(Result2).    
findall(Team,Result2:matchSA(Team,_,"HOME_TEAM",_,_),Result).

num_winner_home(Team,WinHome):-
winner_home(Team,Result),
length(Result,WinHome).