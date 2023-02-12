:- module('database_Roma.pl', [matchSA/5]).
:- multifile(matchSA/5).
matchSA('"Roma"', '"Salernitana"', '"Roma"', '"AWAY_TEAM"', 0, 1).
matchSA('"Roma"', '"Roma"', '"Cremonese"', '"HOME_TEAM"', 1, 0).
matchSA('"Roma"', '"Juventus"', '"Roma"', '"DRAW"', 1, 1).
matchSA('"Roma"', '"Roma"', '"Monza"', '"HOME_TEAM"', 3, 0).
matchSA('"Roma"', '"Udinese"', '"Roma"', '"HOME_TEAM"', 4, 0).
matchSA('"Roma"', '"Empoli"', '"Roma"', '"AWAY_TEAM"', 1, 2).
matchSA('"Roma"', '"Roma"', '"Atalanta"', '"AWAY_TEAM"', 0, 1).
matchSA('"Roma"', '"Inter"', '"Roma"', '"AWAY_TEAM"', 1, 2).
matchSA('"Roma"', '"Roma"', '"Lecce"', '"HOME_TEAM"', 2, 1).
matchSA('"Roma"', '"Sampdoria"', '"Roma"', '"AWAY_TEAM"', 0, 1).
matchSA('"Roma"', '"Roma"', '"Napoli"', '"AWAY_TEAM"', 0, 1).
matchSA('"Roma"', '"Verona"', '"Roma"', '"AWAY_TEAM"', 1, 3).
matchSA('"Roma"', '"Roma"', '"Lazio"', '"AWAY_TEAM"', 0, 1).
matchSA('"Roma"', '"Sassuolo"', '"Roma"', '"DRAW"', 1, 1).
matchSA('"Roma"', '"Roma"', '"Torino"', '"DRAW"', 1, 1).
matchSA('"Roma"', '"Roma"', '"Bologna"', '"HOME_TEAM"', 1, 0).
matchSA('"Roma"', '"Milan"', '"Roma"', '"DRAW"', 2, 2).
matchSA('"Roma"', '"Roma"', '"Fiorentina"', '"HOME_TEAM"', 2, 0).
matchSA('"Roma"', '"Spezia Calcio"', '"Roma"', '"AWAY_TEAM"', 0, 2).
matchSA('"Roma"', '"Napoli"', '"Roma"', '"HOME_TEAM"', 2, 1).
matchSA('"Roma"', '"Roma"', '"Empoli"', '"HOME_TEAM"', 2, 0).
matchSA('"Roma"', '"Lecce"', '"Roma"', '"DRAW"', 1, 1).
matchSA('"Roma"', '"Roma"', '"Verona"', 'null', null, null).
matchSA('"Roma"', '"Cremonese"', '"Roma"', 'null', null, null).
matchSA('"Roma"', '"Roma"', '"Juventus"', 'null', null, null).
matchSA('"Roma"', '"Roma"', '"Sassuolo"', 'null', null, null).
matchSA('"Roma"', '"Lazio"', '"Roma"', 'null', null, null).
matchSA('"Roma"', '"Roma"', '"Sampdoria"', 'null', null, null).
matchSA('"Roma"', '"Torino"', '"Roma"', 'null', null, null).
matchSA('"Roma"', '"Roma"', '"Udinese"', 'null', null, null).
matchSA('"Roma"', '"Atalanta"', '"Roma"', 'null', null, null).
matchSA('"Roma"', '"Roma"', '"Milan"', 'null', null, null).
matchSA('"Roma"', '"Monza"', '"Roma"', 'null', null, null).
matchSA('"Roma"', '"Roma"', '"Inter"', 'null', null, null).
matchSA('"Roma"', '"Bologna"', '"Roma"', 'null', null, null).
matchSA('"Roma"', '"Roma"', '"Salernitana"', 'null', null, null).
matchSA('"Roma"', '"Fiorentina"', '"Roma"', 'null', null, null).
matchSA('"Roma"', '"Roma"', '"Spezia Calcio"', 'null', null, null).
