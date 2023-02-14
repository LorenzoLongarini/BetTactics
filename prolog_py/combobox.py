import tkinter as tk
from tkinter import ttk
from pyswip import Prolog
from time import sleep
import codecs


prolog = Prolog()
prolog.consult("base_functions.pl")

window = tk.Tk()
window.title('La nostra UI')
window.geometry('600x300')

# dbs_info = {}


class MyCombobox(ttk.Combobox):

    # lista contenente tuple con id, nome squadra
    file = codecs.open("database_RESULTS_SA.pl", 'r', encoding='UTF-8')
    # estrazione id e nome da file database_RESULTS_SA
    # for s in file.read().split("\n"):
    #     if "classifica" in s:
    #         s = s[s.index("(")+1:s.index(")")+1].split(",")
    #         id = s[2].lstrip()
    #         name = s[1].lstrip().replace("\"", "")
    #         dbs_info[name] = id  # .append((id, name))

    def total_win(self, event):
        key = self.get_key()
        query = f'total_win("{key}",X, \'{key}\').'
        results = list(prolog.query(query))
        for res in results:
            result_label = ttk.Label(
                window, text="Il numero di vittorie di " +
                key + " è: " + str(res["X"]))
            result_label.grid(column=1, row=6)

    def total_lose(self, event):
        key = self.get_key()
        query = f'total_lose("{key}",X, \'{key}\').'
        results = list(prolog.query(query))
        for res in results:
            result_label = ttk.Label(
                window, text="Il numero di sconfitte di " +
                key + " è: " + str(res["X"]))
            result_label.grid(column=1, row=6)

    def total_draws(self, event):
        key = self.get_key()
        query = f'total_draws("{key}",X, \'{key}\').'
        results = list(prolog.query(query))
        for res in results:
            result_label = ttk.Label(
                window, text="Il numero di pareggi di " +
                key + " è: " + str(res["X"]))
            result_label.grid(column=1, row=6)

    def total_goal_do_team(self, event):
        key = self.get_key()
        query = f'total_goal_do_team("{key}",X).'
        results = list(prolog.query(query))
        for res in results:
            result_label = ttk.Label(
                window, text="Il numero di goal fatti da " +
                key + " è: " + str(res["X"]))
            result_label.grid(column=1, row=6)

    def total_goal_sub_team(self, event):
        key = self.get_key()
        query = f'total_goal_sub_team("{key}",X).'
        results = list(prolog.query(query))
        for res in results:
            result_label = ttk.Label(
                window, text="Il numero di goal subiti da " +
                key + " è: " + str(res["X"]))
            result_label.grid(column=1, row=6)

    def points(self, event):
        key = self.get_key()
        query = f'points("{key}",X).'
        results = list(prolog.query(query))
        for res in results:
            result_label = ttk.Label(
                window, text="Il numero di punti fatti da " +
                key + " è: " + str(res["X"]))
            result_label.grid(column=1, row=6)

    def goal_difference_team(self, event):
        key = self.get_key()
        query = f'goal_difference_team("{key}",X).'
        results = list(prolog.query(query))
        for res in results:
            result_label = ttk.Label(
                window, text="La differenza reti di " +
                key + " è: " + str(res["X"]))
            result_label.grid(column=1, row=6)

    def next_match(self, event):
        key = self.get_key()
        query = f'next_match(X,Y, "{key}").'
        results = list(prolog.query(query))
        for res in results:
            result_label = ttk.Label(
                window, text="La prossima partita di " +
                key + " è: " + str(res["X"].decode(encoding="UTF-8")) + " - "
                + str(res["Y"].decode(encoding="UTF-8")))
            result_label.grid(column=1, row=6)

    def position_difference_percent(self, event):
        key = self.get_key()
        query = f'position_difference_percent(X, "{key}", W, Y, Z).'
        results = list(prolog.query(query))
        for res in results:
            result_label = ttk.Label(
                window, text="La prossima partita di " +
                key + " è: " + str(res["W"].decode(encoding="UTF-8")) + " - "
                + str(res["Y"].decode(encoding="UTF-8")) + "\n la differenza tra le posizioni in classifica è: " +
                str(res["Z"]))
            result_label.grid(column=1, row=6)

    def forma(self, event):
        key = self.get_key()
        query = f'forma("{key}", Y, Z).'
        results = list(prolog.query(query))
        for res in results:
            result_label = ttk.Label(
                window, text="La forma di " +
                key + " è: " + str(res["Z"]) +
                "\n" + key + " ha vinto " + str(res["Z"]) + " delle ultime 5 partite")
            result_label.grid(column=1, row=6)

    def over_under(self, event):
        key = self.get_key()
        query = 'over_under("{}", X, Y, Z).'.format(key)
        results = list(prolog.query(query))
        for res in results:
            XObject = res["X"]
            YObject = res["Y"].decode(encoding="UTF-8")
            ZObject = res["Z"].decode(encoding="UTF-8")
            result_label = ttk.Label(
                window, text="La prossima partita di " +
                key + " è: " + str(YObject) + " - "
                + str(ZObject) + "\nLa media dei goal è: " + str(XObject))
            result_label.grid(column=1, row=6)

    def total_win_percent(self, event):
        key = self.get_key()
        value = self.get_value()
        query = 'total_win_percent("{}", X, Y, Z).'.format(key)
        results = list(prolog.query(query))
        for res in results:
            result_label = ttk.Label(
                window, text="La prossima partita di "
                + key + " è: " + str(res["Y"]) + " - " + str(res["Z"])
                + "\nLa percentuale di vittoria di " + key + " è: " + str(res["X"]) + " %")
            result_label.grid(column=1, row=6)

    def goal_or_not(self, event):
        key = self.get_key()
        value = self.get_value()
        query = 'goal_or_not("{}", X, Y, W, Z).'.format(key)
        results = list(prolog.query(query))
        for res in results:
            if res["W"] > res["Z"]:
                result_label = ttk.Label(
                    window, text="La prossima partita di "
                    + key + " è: " + str(res["X"]) + " - " + str(res["Y"])
                    + "\nEntrambe le squadre segneranno almeno un goal")
                result_label.grid(column=1, row=6)
            else:
                result_label = ttk.Label(
                    window, text="La prossima partita di "
                    + key + " è: " + str(res["X"]) + " - " + str(res["Y"])
                    + "\nUna delle due squadre non segnerà")
                result_label.grid(column=1, row=6)
        # sleep(20)

    def goal_odd_even(self, event):
        key = self.get_key()
        value = self.get_value()
        query = 'goal_odd_even("{}", X, Y, W, Z).'.format(key)
        results = list(prolog.query(query))
        for res in results:
            if res["W"] > res["Z"]:
                result_label = ttk.Label(
                    window, text="La prossima partita di "
                    + key + " è: " + str(res["X"]) + " - " + str(res["Y"])
                    + "\nLa somma totale dei goal è PARI")
                result_label.grid(column=1, row=6)
            else:
                result_label = ttk.Label(
                    window, text="La prossima partita di "
                    + key + " è: " + str(res["X"]) + " - " + str(res["Y"])
                    + "\nLa somma totale dei goal è DISPARI")
                result_label.grid(column=1, row=6)

    def __init__(self, master=None, cnf={}, **options):

        self.dict = None

        # get dictionary from options and put list of keys
        if 'values' in options:
            if isinstance(options.get('values'), dict):
                self.dict = options.get('values')
                options['values'] = sorted(self.dict.keys())

        # combobox constructor with list of keys
        ttk.Combobox.__init__(self, **options)

        # assign some function
        self.bind('<<ComboboxSelected>>', self.on_select)

    def on_select(self, event):
        print(self.get(), self.get_key(), self.get_value())

    # overwrite `get()` to return `value` instead of `key`
    def get(self):
        if self.dict:
            return self.dict[ttk.Combobox.get(self)]
        else:
            return ttk.Combobox.get(self)

    def get_key(self):
        return ttk.Combobox.get(self)

    def get_value(self):
        return self.get()


# tk.Label(window, text="List").pack()

# # combobox working in old way with list
# cb = MyCombobox(window, state='readonly', values=list(items))
# cb.pack()
# cb.set('Seleziona squadra')

function_selector = ttk.Combobox(
    window, values=['over_under', 'total_win_percent', 'goal_or_not', 'goal_odd_even',
                    'total_win', 'total_draws', 'total_lose', 'total_goal_do_team', 'total_goal_sub_team',
                    'points', 'goal_difference_team', 'next_match', 'position_difference_percent', 'forma'])
function_selector.grid(column=0, row=1)

launch_button = tk.Button(window, text='Launch Function')
launch_button.grid(column=0, row=2)


def launch_function(event):
    # get the selected function name
    function_name = function_selector.get()
    # get the selected function
    selected_function = getattr(cb, function_name)
    # call the selected function
    selected_function(event)
    # sleep(10)


dbs = {'Napoli': '113', 'Inter': '108', 'Atalanta': '102', 'Roma': '100', 'Milan': '98', 'Lazio': '110', 'Torino': '586', 'Udinese': '115', 'Juventus': '109', 'Monza': '5911', 'Bologna': '103',
       'Empoli': '445', 'Lecce': '5890', 'Fiorentina': '99', 'Sassuolo': '471', 'Salernitana': '455', 'Spezia Calcio': '488', 'Verona': '450', 'Sampdoria': '584', 'Cremonese': '457'}


# bind the launch button to the launch_function
launch_button.bind('<Button-1>', launch_function)

tk.Label(window, text="BetTactics").grid(column=0, row=5)

# combobox working in new way with dictionary
cb = MyCombobox(window, state='readonly', values=dbs)
cb.grid(column=0, row=0)
cb.set('Seleziona squadra')
# cb.bind('<<ComboboxSelected>>', cb.goal_odd_even)

print(dbs)

window.mainloop()
