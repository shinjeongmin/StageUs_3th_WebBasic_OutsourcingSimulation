var IsSideMenuBtn = false;
// var closedMenuTags = document.getElementById("closedMenu").innerHTML;
// var openedMenuTags = document.getElementById("openedMenu").innerHTML;
var sideBarOpened = document.getElementById("sideBarOpened");
var videoBody = document.getElementById("videoBody");
// 보통 DOM에서 태그를 가져와 변수에 저장할 때 네이밍 규칙?

CloseSideMenuAction();

function SideMenuBtn() {
    IsSideMenuBtn = !IsSideMenuBtn;
    if (IsSideMenuBtn) {
        OpenSideMenuAction();
    }
    else {
        CloseSideMenuAction();
    }
}

function OpenSideMenuAction() {
    videoBody.style.marginLeft = "250px";
    sideBarOpened.style.left = "0px";
}
function CloseSideMenuAction() {
    videoBody.style.marginLeft = "100px";
    sideBarOpened.style.left = "-300px";
}

// function OpenSideMenuAction() {
//     document.getElementById("openedMenu").style.left = "0px";
// }

// function CloseSideMenuAction() {
//     document.getElementById("openedMenu").style.left = "-200px";
// }