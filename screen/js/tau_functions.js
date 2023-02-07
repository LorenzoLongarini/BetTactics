function queryRG1() {
    var session = pl.create();
    var consult = session.consult(":- consult('./BetTactics/prolog/base_functions.pl').");
    var query = session.query("total_win_percent(\"SSC Napoli\", 113, X).");
    function inform(msg) {
        show_result1.innerHTML += '<div>' + msg + '</div>'
    }

    var count_answers = 0
    var callback = function (answer) {
        if (answer === false) {
            inform('DONE, #answers=' + count_answers)
            return
        }
        if (answer === null) {
            inform('TIMEOUT, #answers=' + count_answers)
            return
        }
        // loop
        ++count_answers
        inform(pl.format_answer(answer))
        session.answer(callback)
    }
    // start the query loop
    session.answer(callback)
};
(
    window.onload = () => {
        document.querySelector("button").onclick = () => {
            queryRG1();

        }
    }

)();

function queryRG() {
    var session = pl.create(1000)

    var code_pl = `
        :- use_module(library(lists)).
        fruit(apple).
        fruit(pear).
        fruit(banana).
        fruits_in(Xs, X) :- member(X, Xs), fruit(X).
      `
    var parsed = session.consult(code_pl)
    var query = session.query('fruits_in([banana,lemon,apple],X).')

    function inform(msg) {
        show_result1.innerHTML += '<div>' + msg + '</div>'
    }

    var count_answers = 0
    var callback = function (answer) {
        if (answer === false) {
            inform('DONE, #answers=' + count_answers)
            return
        }
        if (answer === null) {
            inform('TIMEOUT, #answers=' + count_answers)
            return
        }
        // loop
        ++count_answers
        inform(pl.format_answer(answer))
        session.answer(callback)
    }
    // start the query loop
    session.answer(callback)
};
