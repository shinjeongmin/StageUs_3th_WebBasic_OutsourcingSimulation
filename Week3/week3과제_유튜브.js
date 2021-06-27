var IsSideMenuBtn = false;
var closedMenuTags = document.getElementById("closedMenu").innerHTML;
var openedMenuTags = document.getElementById("openedMenu").innerHTML;
var sideBar = document.getElementById("sideBar");
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
    sideBar.innerHTML = openedMenuTags;
    sideBar.style.width = "225px";
    videoBody.style.marginLeft = "225px";
}
function CloseSideMenuAction() {
    sideBar.innerHTML = closedMenuTags;
    sideBar.style.width = "fit-content";
    videoBody.style.marginLeft = "100px";
}