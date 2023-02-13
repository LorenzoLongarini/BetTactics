from pyswip import Prolog
from tkinter import *

prolog = Prolog()

root = Tk()

prolog.consult("base_functions.pl")


def change_result():
    res = prolog.query('goal_do_home("Verona", X).')
    print(list(res))


turn_off = Button(root, text="PREMIMI", command=change_result)
turn_off.pack()

root.mainloop()
