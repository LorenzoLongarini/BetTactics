:- module('database_Sampdoria.pl', [matchSA/5]).
:- multifile(matchSA/5).
matchSA('"Sampdoria"', '"Sampdoria"', '"Atalanta"', '"AWAY_TEAM"', 0, 2).
matchSA('"Sampdoria"', '"Sampdoria"', '"Juventus"', '"DRAW"', 0, 0).
matchSA('"Sampdoria"', '"Salernitana"', '"Sampdoria"', '"HOME_TEAM"', 4, 0).
matchSA('"Sampdoria"', '"Sampdoria"', '"Lazio"', '"DRAW"', 1, 1).
matchSA('"Sampdoria"', '"Verona"', '"Sampdoria"', '"HOME_TEAM"', 2, 1).
matchSA('"Sampdoria"', '"Sampdoria"', '"Milan"', '"AWAY_TEAM"', 1, 2).
matchSA('"Sampdoria"', '"Spezia Calcio"', '"Sampdoria"', '"HOME_TEAM"', 2, 1).
matchSA('"Sampdoria"', '"Sampdoria"', '"Monza"', '"AWAY_TEAM"', 0, 3).
matchSA('"Sampdoria"', '"Bologna"', '"Sampdoria"', '"DRAW"', 1, 1).
matchSA('"Sampdoria"', '"Sampdoria"', '"Roma"', '"AWAY_TEAM"', 0, 1).
matchSA('"Sampdoria"', '"Cremonese"', '"Sampdoria"', '"AWAY_TEAM"', 0, 1).
matchSA('"Sampdoria"', '"Inter"', '"Sampdoria"', '"HOME_TEAM"', 3, 0).
matchSA('"Sampdoria"', '"Sampdoria"', '"Fiorentina"', '"AWAY_TEAM"', 0, 2).
matchSA('"Sampdoria"', '"Torino"', '"Sampdoria"', '"HOME_TEAM"', 2, 0).
matchSA('"Sampdoria"', '"Sampdoria"', '"Lecce"', '"AWAY_TEAM"', 0, 2).
matchSA('"Sampdoria"', '"Sassuolo"', '"Sampdoria"', '"AWAY_TEAM"', 1, 2).
matchSA('"Sampdoria"', '"Sampdoria"', '"Napoli"', '"AWAY_TEAM"', 0, 2).
matchSA('"Sampdoria"', '"Empoli"', '"Sampdoria"', '"HOME_TEAM"', 1, 0).
matchSA('"Sampdoria"', '"Sampdoria"', '"Udinese"', '"AWAY_TEAM"', 0, 1).
matchSA('"Sampdoria"', '"Atalanta"', '"Sampdoria"', '"HOME_TEAM"', 2, 0).
matchSA('"Sampdoria"', '"Monza"', '"Sampdoria"', '"DRAW"', 2, 2).
matchSA('"Sampdoria"', '"Sampdoria"', '"Inter"', 'null', null, null).
matchSA('"Sampdoria"', '"Sampdoria"', '"Bologna"', 'null', null, null).
matchSA('"Sampdoria"', '"Lazio"', '"Sampdoria"', 'null', null, null).
matchSA('"Sampdoria"', '"Sampdoria"', '"Salernitana"', 'null', null, null).
matchSA('"Sampdoria"', '"Juventus"', '"Sampdoria"', 'null', null, null).
matchSA('"Sampdoria"', '"Sampdoria"', '"Verona"', 'null', null, null).
matchSA('"Sampdoria"', '"Roma"', '"Sampdoria"', 'null', null, null).
matchSA('"Sampdoria"', '"Sampdoria"', '"Cremonese"', 'null', null, null).
matchSA('"Sampdoria"', '"Lecce"', '"Sampdoria"', 'null', null, null).
matchSA('"Sampdoria"', '"Sampdoria"', '"Spezia Calcio"', 'null', null, null).
matchSA('"Sampdoria"', '"Fiorentina"', '"Sampdoria"', 'null', null, null).
matchSA('"Sampdoria"', '"Sampdoria"', '"Torino"', 'null', null, null).
matchSA('"Sampdoria"', '"Udinese"', '"Sampdoria"', 'null', null, null).
matchSA('"Sampdoria"', '"Sampdoria"', '"Empoli"', 'null', null, null).
matchSA('"Sampdoria"', '"Milan"', '"Sampdoria"', 'null', null, null).
matchSA('"Sampdoria"', '"Sampdoria"', '"Sassuolo"', 'null', null, null).
matchSA('"Sampdoria"', '"Napoli"', '"Sampdoria"', 'null', null, null).
