var numCardArr = [];
var clickCard;
numCardArr = document.getElementsByClassName("numCard");
var placeCard;
placeCardArr = document.getElementsByClassName("placeCard");

[].forEach.call(numCardArr, element => {
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
            console.log("empty");
        }
        else{
            var swapValue = e.target.innerHTML;
            e.target.innerHTML = clickCard.innerHTML;
            clickCard.innerHTML = swapValue;
            // e.target.innerHTML = "";
            console.log("else");
        }
    }
});

[].forEach.call(placeCardArr, element => {
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
            console.log("else");
        }

        var result = checkGameEnd()
        if(result){
            console.log("GAME END!");
        }
    }
});

function checkGameEnd(){
    for(var i = 0; i < placeCardArr.length; ++i){
        if(placeCardArr[i].innerHTML != i+1){
            return false;
        }
    }
    return true;
}