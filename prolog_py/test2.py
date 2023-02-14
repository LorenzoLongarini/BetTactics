from pyswip import Prolog
from tkinter import *
import tkinter as tk
from tkinter import ttk

prolog = Prolog()
prolog.consult("base_functions.pl")

window = tk.Tk()
window.title('La nostra UI')
window.geometry('600x300')


def callbackFunc(event):
    country = event.widget.get()
    #ttk.Label(window, text=country).grid(column=0, row=10)

    for res in prolog.query('goal_do_home("' + country + '", X).'):
        print(res)
    ttk.Label(window, text="La squadra " + country + " ha fatto in casa " +
              str(res["X"]) + " goal").grid(column=1, row=11)
    print(country)


# label text for title
ttk.Label(window, text="Bet for win",
          background='cyan', foreground="black",
          font=("Times New Roman", 15)).grid(row=0, column=1)

# Set label
ttk.Label(window, text="Seleziona la squadra:",
          font=("Times New Roman", 12)).grid(column=0,
                                             row=5, padx=5, pady=25)

ttk.Label(window, text="Seleziona la funzione:",
          font=("Times New Roman", 12)).grid(column=0,
                                             row=6, padx=5, pady=25)

# ttk.Checkbutton(window, text='Python',
#                variable=1, onvalue=1,
#                offvalue=0, command=callbackFunc).grid(column=0,row=6)


n = tk.StringVar()
n1 = tk.StringVar()
country = ttk.Combobox(window, width=27, textvariable=n)
country1 = ttk.Combobox(window, width=27, textvariable=n1)

country['values'] = ('Napoli',
                     'Juventus',
                     'Inter',
                     'Atalanta',
                     'Roma',
                     'Milan',
                     'Lazio',
                     'Udinese',
                     'Torino',
                     'Monza',
                     'Bologna',
                     'Empoli',
                     'Lecce',
                     'Fiorentina',
                     'Sassuolo',
                     'Salernitana',
                     'Spezia Calcio',
                     'Verona',
                     'Sampdoria',
                     'Cremonese')


country.grid(column=1, row=5)
country.current()
country.bind("<<ComboboxSelected>>", callbackFunc)


window.mainloop()
