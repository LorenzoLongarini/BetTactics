import tkinter as tk
from tkinter import ttk
from pyswip import Prolog
from time import sleep
import codecs


prolog = Prolog()
prolog.consult("base_functions.pl")

window = tk.Tk()
window.title('BetTactics')
window.geometry('650x500')

result_label = ttk.Label()


class MyCombobox(ttk.Combobox):

    # le seguenti funzioni sfruttano la dipendenza di Prolog per effettuare
    # delle query che sono presenti nel file base_functions

    def total_win(self, event):
        key = self.get_key()
        query = f'total_win("{key}",X, \'{key}\').'
        results = list(prolog.query(query))
        for res in results:
            result_label = ttk.Label(
                window, text="Il numero di vittorie di " +
                key + " è: " + str(res["X"]))
            result_label.grid(column=0, row=6, columnspan=3)
            window.after(5000, lambda: result_label.destroy())

    def total_lose(self, event):
        key = self.get_key()
        query = f'total_lose("{key}",X, \'{key}\').'
        results = list(prolog.query(query))
        for res in results:
            result_label = ttk.Label(
                window, text="Il numero di sconfitte di " +
                key + " è: " + str(res["X"]))
            result_label.grid(column=0, row=6, columnspan=3)
            window.after(5000, lambda: result_label.destroy())

    def total_draws(self, event):
        key = self.get_key()
        query = f'total_draws("{key}",X, \'{key}\').'
        results = list(prolog.query(query))
        for res in results:
            result_label = ttk.Label(
                window, text="Il numero di pareggi di " +
                key + " è: " + str(res["X"]))
            result_label.grid(column=0, row=6, columnspan=3)
            window.after(5000, lambda: result_label.destroy())

    def total_goals_done(self, event):
        key = self.get_key()
        query = f'total_goal_do_team("{key}",X).'
        results = list(prolog.query(query))
        for res in results:
            result_label = ttk.Label(
                window, text="Il numero di goal fatti da " +
                key + " è: " + str(res["X"]))
            result_label.grid(column=0, row=6, columnspan=3)
            window.after(5000, lambda: result_label.destroy())

    def total_goals_conceded(self, event):
        key = self.get_key()
        query = f'total_goal_sub_team("{key}",X).'
        results = list(prolog.query(query))
        for res in results:
            result_label = ttk.Label(
                window, text="Il numero di goal subiti da " +
                key + " è: " + str(res["X"]))
            result_label.grid(column=0, row=6, columnspan=3)
            window.after(5000, lambda: result_label.destroy())

    def points(self, event):
        key = self.get_key()
        query = f'points("{key}",X).'
        results = list(prolog.query(query))
        for res in results:
            result_label = ttk.Label(
                window, text="Il numero di punti fatti da " +
                key + " è: " + str(res["X"]))
            result_label.grid(column=0, row=6, columnspan=3)
            window.after(5000, lambda: result_label.destroy())

    def goal_difference_team(self, event):
        key = self.get_key()
        query = f'goal_difference_team("{key}",X).'
        results = list(prolog.query(query))
        for res in results:
            result_label = ttk.Label(
                window, text="La differenza reti di " +
                key + " è: " + str(res["X"]))
            result_label.grid(column=0, row=6, columnspan=3)
            window.after(5000, lambda: result_label.destroy())

    def next_match(self, event):
        key = self.get_key()
        query = f'next_match(X,Y, "{key}").'
        results = list(prolog.query(query))
        for res in results:
            result_label = ttk.Label(
                window, text="La prossima partita di " +
                key + " è: " + str(res["X"].decode(encoding="UTF-8")) + " - "
                + str(res["Y"].decode(encoding="UTF-8")))
            result_label.grid(column=0, row=6, columnspan=3)
            window.after(5000, lambda: result_label.destroy())

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
            result_label.grid(column=0, row=6, columnspan=3)
            window.after(5000, lambda: result_label.destroy())

    def forma(self, event):
        key = self.get_key()
        query = f'forma("{key}",X, Z).'
        results = list(prolog.query(query))
        for res in results:
            result_label = ttk.Label(
                window, text="La forma di " +
                key + " è: " + str(res["X"]) + " %"
                "\n" + key + " ha vinto " + str(res["Z"]) + " delle ultime 5 partite")
            result_label.grid(column=0, row=6, columnspan=3)
            window.after(5000, lambda: result_label.destroy())

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
            result_label.grid(column=0, row=6, columnspan=3)
            window.after(5000, lambda: result_label.destroy())

    def total_win_percent(self, event):
        key = self.get_key()
        query = f'total_win_percent("{key}", X, Y, Z, \'{key}\').'
        results = list(prolog.query(query))
        for res in results:
            YObject = res["Y"].decode(encoding="UTF-8")
            ZObject = res["Z"].decode(encoding="UTF-8")
            result_label = ttk.Label(
                window, text="La prossima partita di "
                + key + " è: " + str(YObject) + " - " + str(ZObject)
                + "\nLa percentuale di vittoria di " + key + " è: " + str(res["X"]) + " %")
            result_label.grid(column=0, row=6, columnspan=3)
            window.after(5000, lambda: result_label.destroy())

    def goal_nogoal(self, event):
        key = self.get_key()
        query = 'goal_or_not("{}", X, Y, W, Z).'.format(key)
        results = list(prolog.query(query))
        for res in results:
            XObject = res["X"].decode(encoding="UTF-8")
            YObject = res["Y"].decode(encoding="UTF-8")
            if res["W"] > res["Z"]:
                result_label = ttk.Label(
                    window, text="La prossima partita di "
                    + key + " è: " + str(XObject) + " - " + str(YObject)
                    + "\nEntrambe le squadre segneranno almeno un goal")
                result_label.grid(column=0, row=6, columnspan=3)
                window.after(5000, lambda: result_label.destroy())
            else:
                result_label = ttk.Label(
                    window, text="La prossima partita di "
                    + key + " è: " + str(XObject) + " - " + str(YObject)
                    + "\nUna delle due squadre non segnerà")
                result_label.grid(column=0, row=6, columnspan=3)
                window.after(5000, lambda: result_label.destroy())

    def goal_odd_even(self, event):
        key = self.get_key()
        value = self.get_value()
        query = 'goal_odd_even("{}", X, Y, W, Z).'.format(key)
        results = list(prolog.query(query))
        for res in results:
            XObject = res["X"].decode(encoding="UTF-8")
            YObject = res["Y"].decode(encoding="UTF-8")
            if res["W"] > res["Z"]:
                result_label = ttk.Label(
                    window, text="La prossima partita di "
                    + key + " è: " + str(XObject) + " - " + str(YObject)
                    + "\nLa somma totale dei goal è PARI")
                result_label.grid(column=0, row=6, columnspan=3)
                window.after(5000, lambda: result_label.destroy())
            else:
                result_label = ttk.Label(
                    window, text="La prossima partita di "
                    + key + " è: " + str(XObject) + " - " + str(YObject)
                    + "\nLa somma totale dei goal è DISPARI")
                result_label.grid(column=0, row=6, columnspan=3)
                window.after(5000, lambda: result_label.destroy())

    def __init__(self, master=None, cnf={}, **options):

        self.dict = None

        # prende il dictionary dalle options e fa una lista di key
        if 'values' in options:
            if isinstance(options.get('values'), dict):
                self.dict = options.get('values')
                options['values'] = sorted(self.dict.keys())

        # costruttore
        ttk.Combobox.__init__(self, **options)

        # assegna le funzioni
        self.bind('<<ComboboxSelected>>', self.on_select)

    def on_select(self, event):
        print(self.get(), self.get_key(), self.get_value())

    # sovrascrive `get()` per permetterci di ritornare `value` invece di `key`
    def get(self):
        if self.dict:
            return self.dict[ttk.Combobox.get(self)]
        else:
            return ttk.Combobox.get(self)

    def get_key(self):
        return ttk.Combobox.get(self)

    def get_value(self):
        return self.get()


# select relativo alle funzioni
function_selector = ttk.Combobox(
    window, values=['over_under', 'total_win_percent', 'goal_nogoal', 'goal_odd_even',
                    'total_win', 'total_draws', 'total_lose', 'total_goals_done', 'total_goals_conceded',
                    'points', 'goal_difference_team', 'next_match', 'position_difference_percent', 'forma'])
function_selector.grid(column=1, row=1, ipadx=25, padx=50)
function_selector.set('Seleziona risultato')


def launch_function(event):
    # prende il nome della funzione selezionata
    function_name = function_selector.get()
    # prende la funzione selezionata
    selected_function = getattr(cb, function_name)
    # chiama la funzione selezionata
    selected_function(event)


# bottone che lancia le funzioni che vengono selezionate
launch_button = tk.Button(window, text='Genera Risultato')
launch_button.grid(column=0, row=3, columnspan=3, pady=20)
launch_button.bind('<Button-1>', launch_function)


# logo dell'applicazione
logo = tk.PhotoImage(file='logo.png')
labelLogo = tk.Label(window, image=logo)
labelLogo.grid(column=0, columnspan=4, row=0, padx=20)


# db utile alla creazione della select nell'interfaccia
dbs = {'Napoli': '113', 'Inter': '108', 'Atalanta': '102', 'Roma': '100', 'Milan': '98',
       'Lazio': '110', 'Torino': '586', 'Udinese': '115', 'Juventus': '109', 'Monza': '5911', 'Bologna': '103',
       'Empoli': '445', 'Lecce': '5890', 'Fiorentina': '99', 'Sassuolo': '471', 'Salernitana': '455',
       'Spezia Calcio': '488', 'Verona': '450', 'Sampdoria': '584', 'Cremonese': '457'}
# select delle squadre
cb = MyCombobox(window, state='readonly', values=dbs)
cb.grid(column=0, row=1, ipadx=10, padx=50)
cb.set('Seleziona squadra')


window.mainloop()
