
import os
from pathlib import Path
from time import sleep
from pyswip import Prolog

prolog = Prolog()


def download_databases():
    prolog.consult("BetTacticsScript.pl")
    dbs_info = []  # lista contenente tuple con id, nome squadra
    file = open("database_RESULTS_SA.pl", "r")
    # estrazione id e nome da file database_RESULTS_SA
    for s in file.read().split("\n"):
        if "classifica" in s:
            s = s[s.index("(")+1:s.index(")")+1].split(",")
            id = s[2].lstrip()
            name = s[1].lstrip().replace("\"", "")
            dbs_info.append((id, name))
    # rimozione di tutti i file corrispondenti a dbs_info
    for id, name in dbs_info:
        fn = f"database_{name}.pl"
        if Path(fn).exists():
            os.remove(fn)
    # download files corrispondenti a dbs_info
    for id, name in dbs_info:
        query = f'start_matches_SA("{name}", {id}).'
        res = prolog.query(query)
        list(res)
        print(query)
        sleep(15)


download_databases()


prolog.consult("base_functions.pl")
res = prolog.query('goal_do_home("Verona", X).')
print(list(res))

label = "Roma"
res = prolog.query(f'over_under("{label}", 100).')
print(list(res))
