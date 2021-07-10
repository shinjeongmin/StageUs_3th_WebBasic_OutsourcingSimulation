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

// 순수함수의 법칙에 어긋남

startBtn.onclick = gameStartFunc;
function gameStartFunc(e){ // 함수의 역할별로 세부 함수들로 구분할 것
    // create Timer
    timeObj['minute'] = 0;
    timeObj['second'] = 0;
    // game start button
    e.target.style.color = "darkgray";
    e.target.onclick = null;

    initNumberCards();

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

// 함수 표현식 (최근은 표현식으로만 주로 사용 (호이스팅 문제))
// setInterval에 timerFunc란에 익명함수만 넣어주는 방식으로 통일 할 것
timerFunc = function(){
    timeObj['second']++;
    if(timeObj['second'] >= 60){
        timeObj['minute']++;
        timeObj['second'] = 0;
    }
    timeObj['tag'].innerHTML = timeObj['minute'].toString().padStart(2,"0")
        + " : "+ timeObj['second'].toString().padStart(2,'0');
}

// 함수 선언식
// 같은 의미의 다른 방법이 있는 경우 한 가지로 통일 할 것으로 생각
function initNumberCards(){
    var cardNumbers = [1,2,3,4,5,6,7,8,9];
    shuffle(cardNumbers);
    [].forEach.call(numCardArr, (element, index) =>{
        element.innerHTML = cardNumbers[index].toString();
    });
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

function shuffle(array) {
    var currentIndex = array.length, randomIndex;

    // While there remain elements to shuffle...
    while (0 !== currentIndex) {

        // Pick a remaining element...
        randomIndex = Math.floor(Math.random() * currentIndex);
        currentIndex--;

        // And swap it with the current element.
        [array[currentIndex], array[randomIndex]]
         = [array[randomIndex], array[currentIndex]];
    }

    return array;
}