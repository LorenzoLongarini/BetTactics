:- module('database_Lecce.pl', [matchSA/5]).
:- multifile(matchSA/5).
matchSA('"Lecce"', '"Inter"', '"AWAY_TEAM"', 1, 2).
matchSA('"Sassuolo"', '"Lecce"', '"HOME_TEAM"', 1, 0).
matchSA('"Lecce"', '"Empoli"', '"DRAW"', 1, 1).
matchSA('"Napoli"', '"Lecce"', '"DRAW"', 1, 1).
matchSA('"Torino"', '"Lecce"', '"HOME_TEAM"', 1, 0).
matchSA('"Lecce"', '"Monza"', '"DRAW"', 1, 1).
matchSA('"Salernitana"', '"Lecce"', '"AWAY_TEAM"', 1, 2).
matchSA('"Lecce"', '"Cremonese"', '"DRAW"', 1, 1).
matchSA('"Roma"', '"Lecce"', '"HOME_TEAM"', 2, 1).
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
