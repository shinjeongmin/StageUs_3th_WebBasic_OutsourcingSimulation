// start game
var startBtn = document.getElementById("startBtn");
// number cards
var clickCard;
var numCardArr = document.getElementsByClassName("numCard");
var placeCardArr= document.getElementsByClassName("placeCard");
// timer
var timeObj
var asyncTimerFunc;
// gameEndSign
const wrongColor = window.getComputedStyle(placeCardArr[0]).color;

// 순수함수의 법칙에 어긋남

// create Timer
var initTimeObj = function(obj){
    obj = {'minute': 0, 'second': 0};
    obj['tag'] = document.getElementById("timer");
    obj['minute'] = 0;
    obj['second'] = 0;
    return obj;
}

startBtn.onclick = gameStartFunc;
function gameStartFunc(e){ // 함수의 역할별로 세부 함수들로 구분할 것
    timeObj = initTimeObj(timeObj);
    // game start button
    e.target.style.color = "darkgray";
    e.target.onclick = null;
    
    numCardArr = initNumberCards(numCardArr);
    
    // card drag & drop
    numCardArr = setCardEvent(numCardArr, timeObj);
    placeCardArr = setCardEvent(placeCardArr, timeObj);
    
    clearInterval(asyncTimerFunc);
    asyncTimerFunc = setInterval(
        // 함수 표현식 (최근은 표현식으로만 주로 사용 (호이스팅 문제))
        function () {
            timeObj['second']++;
            if (timeObj['second'] >= 60) {
                timeObj['minute']++;
                timeObj['second'] = 0;
            }
            timeObj['tag'].innerHTML = timeObj['minute'].toString().padStart(2, "0")
            + " : " + timeObj['second'].toString().padStart(2, '0');
        },1000);
    }

// 함수 선언식
// 같은 의미의 다른 방법이 있는 경우 한 가지로 통일 할 것으로 생각
function initNumberCards(array){
    var cardNumbers = [1,2,3,4,5,6,7,8,9];
    shuffle(cardNumbers);
    return Array.prototype.map.call(array, (element, index) =>{
        element.innerHTML = cardNumbers[index].toString();
        return element;
    });
}

function setCardEvent(array, paramTimeObj){
    return Array.prototype.map.call(array,(element) => {
        element.draggable = "true";
        element.onmousedown = function(e){ 
            clickCard = e.target;
        }
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
            e = gameEnd(e, paramTimeObj);
        }
        return element;
    });
}

function gameEnd(event, paramTimeObj){
    var result = checkGameClear();
    if(result){
        document.getElementById("gameEndSign").style.visibility = "unset";
        clearInterval(asyncTimerFunc);
        paramTimeObj['tag'].style.color = "red";
        event.target.onclick = gameStartFunc;
    }
    else{
        document.getElementById("gameEndSign").style.visibility = "hidden";
    }
    return event;
}

function checkGameClear(){
    var correctAscend = true;
    for(var i = 0; i < placeCardArr.length; ++i){
        if(placeCardArr[i].innerHTML != i+1){
            placeCardArr[i].style.color = wrongColor;
            correctAscend = false;
        }
        else{
            placeCardArr[i].style.color = "green";
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