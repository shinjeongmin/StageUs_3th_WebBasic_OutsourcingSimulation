// start game
var startBtn = document.getElementById("startBtn");
// number cards
var numCardArr = [];
var clickCard;
numCardArr = document.getElementsByClassName("numCard");
var placeCard;
placeCardArr = document.getElementsByClassName("placeCard");
// timer
var timeObj = {'minute': 0, 'second': 0};
timeObj['tag'] = document.getElementById("timer");
var timerFunc;
var asyncTimerFunc;


startBtn.onclick = gameStartFunc;
function gameStartFunc(e){
    // create Timer
    timeObj['minute'] = 0;
    timeObj['second'] = 0;
    // game start button
    e.target.style.color = "darkgray";
    e.target.onclick = null;

    [].forEach.call(numCardArr, element => {
        element.draggable = "true";
        element.onmousedown = function(e){ 
            // element == e.target
            clickCard = e.target;
        }
        element.ondragstart = function(e){}
        element.ondragover = function(e){
            e.preventDefault();
        }
        element.ondragend = function(e){}
        element.ondrop = function(e){
            if(e.target.innerHTML == ""){
                e.target.innerHTML = clickCard.innerHTML;
                clickCard.innerHTML = "";
            }
            else{
                var swapValue = e.target.innerHTML;
                e.target.innerHTML = clickCard.innerHTML;
                clickCard.innerHTML = swapValue;
                // e.target.innerHTML = "";
            }
            gameEnd(e);
        }
    });
    
    [].forEach.call(placeCardArr, element => {
        element.draggable = "true";
        element.onmousedown = function(e){
            clickCard = e.target;
        }
        element.ondragstart = function(e){}
        element.ondragover = function(e){
            e.preventDefault();
        }
        element.ondragend = function(e){}
        element.ondrop = function(e){
            if(e.target.innerHTML == ""){
                e.target.innerHTML = clickCard.innerHTML;
                clickCard.innerHTML = "";
            }
            else{
                var swapValue = e.target.innerHTML;
                e.target.innerHTML = clickCard.innerHTML;
                clickCard.innerHTML = swapValue;
                // e.target.innerHTML = "";
            }
    
            gameEnd(e);
        }
    });

    clearInterval(asyncTimerFunc);
    asyncTimerFunc = setInterval(timerFunc,1000);
}

timerFunc = function(){
    timeObj['second']++;
    if(timeObj['second'] >= 60){
        timeObj['minute']++;
        timeObj['second'] = 0;
    }
    timeObj['tag'].innerHTML = timeObj['minute'].toString().padStart(2,"0")
        + " : "+ timeObj['second'].toString().padStart(2,'0');
}

function gameEnd(e){
    var result = checkGameClear()
    if(result){
        document.getElementById("gameEndSign").style.visibility = "unset"
        clearInterval(asyncTimerFunc);
        timeObj['tag'].style.color = "red";
        e.target.onclick = gameStartFunc;
    }
    else{
        document.getElementById("gameEndSign").style.visibility = "hidden";
    }
}

var correctColort = "green";
var wrongColor = window.getComputedStyle(placeCardArr[0]).color;
function checkGameClear(){
    var correctAscend = true;
    for(var i = 0; i < placeCardArr.length; ++i){
        if(placeCardArr[i].innerHTML != i+1){
            placeCardArr[i].style.color = wrongColor;
            correctAscend = false;
        }
        else{
            placeCardArr[i].style.color = correctColort;
        }
    }
    return correctAscend;
}