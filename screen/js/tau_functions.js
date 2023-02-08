function queryRG1() {
    var session = pl.create(1000);
    session.consult('./js/base_functions.pl');
    //session.consult('./js/database_MATCHES-AS Roma.pl');
    console.log(session);
    //session.query('num_winner_home("AS Roma",WinHome)');
    session.query('matchSA("FC Internazionale Milano", "AS Roma", "AWAY_TEAM", 1, 2).');


    function inform(msg) {
        if (msg !== false && msg !== null) {
            show_result1.innerHTML += '<div>' + msg + '</div>'
        } else {
            //msg === 'porco il tuo dio ';
            show_result1.innerHTML += '<div>' + 'dio cane' + '</div>'
        }
    }

    var count_answers = 0
    var callback = function (answer) {
        //console.log(session)
        if (answer === false) {
            console.log('false');
            inform('DONE, #answers=' + count_answers)
            return
        } else
            if (answer === null) {
                console.log('null');
                inform('TIMEOUT, #answers=' + count_answers)
                return
            } else {
                console.log(answer);
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
