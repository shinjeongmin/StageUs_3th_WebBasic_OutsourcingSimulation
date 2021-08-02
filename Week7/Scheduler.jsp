<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.sql.ResultSet"%>
<jsp:include page="./db_Scheduler.jsp" flush="false"/>

<%
    String year = request.getParameter("year");
    String month = request.getParameter("month");
    ArrayList<ArrayList> scheduleJsonArr = (ArrayList<ArrayList>)request.getAttribute("scheduleJsonArr");
    
    String isPushDeleteBtn = request.getParameter("isPushDeleteBtn") == null 
        ? "false" : request.getParameter("isPushDeleteBtn");
    int deleteIdx = request.getParameter("index") == null 
        ? -1 : Integer.parseInt(request.getParameter("index"));
%>

<jsp:include page="db_DeleteSchedule.jsp" flush="false">
    <jsp:param name="deleteIdx" value="<%=deleteIdx%>"/>
    <jsp:param name="isPushDeleteBtn" value="<%=isPushDeleteBtn%>"/>
</jsp:include>

<%
    String isDeleteSuccess = (String) request.getAttribute("isDeleteSuccess");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./Scheduler.css">
    <title>Scheduler</title>
</head>
<body>
    <div id="main">
        <div id="header">
            <a id="welcomeText"> <span id="userId"><%=session.getAttribute("sessionId")%></span>'s Todo Lists </a>
        </div>
        <div id="navigation">
            <button class="navigationArrowMonthBtn arrowBtnLeft" onclick="pastMonth()">
                <img class="navigationArrowMonthBtnImg" src="./img/schedule/navigationArrowMonthBtn_Left.png"/>
            </button>
            <div id="navigationCenter">
                <span id="navigationCenterYear"><%=request.getParameter("year")%></span>
                <span id="navigationCenterMonth"><%=String.format("%02d", Integer.parseInt(request.getParameter("month")))%></span>
                <span id="navigationCenterTextSchedules">Schedules</span>
            </div>
            <button class="navigationArrowMonthBtn arrowBtnRight" onclick="nextMonth()">
                <img class="navigationArrowMonthBtnImg" src="./img/schedule/navigationArrowMonthBtn_Right.png"/>
            </button>
        </div>
        <div id="createScheduleBox" onclick="pageCreateSchedule()">
            <a id="createScheduleText">Create Schedule</a>
            <img id="createScheduleImg" src="./img/schedule/createScheduleImg.png" alt="">
        </div>
        <div id="content"></div>
    </div>
</body>
<script>
    window.onload = function(){
        if("<%=isPushDeleteBtn%>" == "true") checkDeleteSuccess();
    }

    var scheduleDataArr = getParseJsonData();
    createSchedules();

    function pageCreateSchedule(){
        location.href="./CreateSchedule.jsp";
    }

    function createSchedules(){
        if(scheduleDataArr.length == 0){
            return;
        }
        for(var i = 0; i < Object.keys(scheduleDataArr[0]).length; i++){
            var tempArr = scheduleDataArr[i];
            if("<%=year%>" === scheduleDataArr[i]["date"].split('-')[0] 
                && <%=month%> === parseInt(scheduleDataArr[i]["date"].split('-')[1]))
            {
                if(i == 0 || scheduleDataArr[i-1]["date"] != scheduleDataArr[i]["date"])
                {
                    document.getElementById("content").appendChild(getSeparaterHr());
                    document.getElementById("content").appendChild(getSeparatorDate(scheduleDataArr[i]));
                }
                document.getElementById("content").appendChild(getOneSchedule(scheduleDataArr[i]));
            }
        }
    }

    function getSeparaterHr(){
        var hr = document.createElement("hr");
        hr.className = "separatorHr";

        return hr;
    }

    function getSeparatorDate(scheduleDataJson){
        var date = document.createElement("a");
        date.className = "separatorDate";
        date.innerHTML = parseInt(scheduleDataJson["date"].split("-")[2]);
        switch (date.innerHTML) {
            case "1":
            date.innerHTML += "st";
                break;
            case "2":
            date.innerHTML += "nd";
                break;
            default:
            date.innerHTML += "th";
                break;
        }
        return date;
    }

    function getOneSchedule(scheduleDataJson){
        var scheduleBox = document.createElement("div");
        scheduleBox.className = "scheduleBox";
        var scheduleContent = document.createElement("div");
        scheduleContent.className = "scheduleContent";
        scheduleBox.appendChild(scheduleContent);
        if(Date.parse(scheduleDataJson["date"] + " " + scheduleDataJson["time"]) > Date.now())
            scheduleContent.style.backgroundImage = "none";
        var scheduleDateTime = document.createElement("div");
        scheduleDateTime.className = "scheduleDateTime";
        scheduleContent.appendChild(scheduleDateTime);

        // schedule content
        var date = document.createElement("span");
        date.className = "scheduleDateTime_date";
        date.innerHTML = scheduleDataJson['date'];
        var time = document.createElement("span");
        time.className = "scheduleDateTime_time";
        time.innerHTML = scheduleDataJson["time"];
        scheduleDateTime.appendChild(date);
        scheduleDateTime.appendChild(time);
        var scheduleDescription = document.createElement("a");
        scheduleDescription.className = "scheduleDescription";
        scheduleDescription.innerHTML = scheduleDataJson["description"];
        var pastScheduleSign = document.createElement("div");
        pastScheduleSign.className = "pastScheduleSign";
        // yet
        checkSchedulePassed(scheduleDataJson["time"]);
        scheduleContent.appendChild(scheduleDescription);
        scheduleContent.appendChild(pastScheduleSign);

        // buttons
        var scheduleBtnBox = document.createElement("div");
        scheduleBtnBox.className = "scheduleBtnBox";
        var modifyBtn = document.createElement("button");
        modifyBtn.className = "modifyBtn scheduleBtn";
        modifyBtn.onclick = () => {
            modifySchedule(scheduleDataJson['idx'],scheduleDataJson['date'], scheduleDataJson['time'], scheduleDataJson['description']);
        };
        scheduleBtnBox.appendChild(modifyBtn);
        var deleteBtn = document.createElement("button");
        deleteBtn.className = "deleteBtn scheduleBtn";
        deleteBtn.onclick = "deleteSchedule(" + scheduleDataJson['idx'] + ");";
        deleteBtn.onclick = () => {
            deleteSchedule(scheduleDataJson['idx']);
        }
        scheduleBtnBox.appendChild(deleteBtn);
        scheduleBox.appendChild(scheduleBtnBox);

        return scheduleBox;
    }

    function checkSchedulePassed(time){

    }

    function getParseJsonData(){
        var rowData = '<%=scheduleJsonArr%>';
        console.log(JSON.parse(rowData));
        return JSON.parse(rowData);
    }

    function nextMonth(){
        var year = parseInt(<%=year%>);
        var month = (parseInt(<%=month%>) + parseInt(1));
        if(month > 12) {
            year += 1;
            month = 1;
        }
        location.href = "Scheduler.jsp?year=" + year + "&month=" + month;
    }
    
    function pastMonth(){
        var year = parseInt(<%=year%>);
        var month = (parseInt(<%=month%>) - parseInt(1));
        if(month < 1) {
            year -= 1;
            month = 12;
        }
        location.href = "Scheduler.jsp?year=" + year + "&month=" + month;
    }

    function modifySchedule(_index, _date, _time, _description){
        var form = document.createElement('form');
        form.setAttribute('method','post');
        form.setAttribute('action', './ModifySchedule.jsp');
        form.style.display = "none";

        var indexField = document.createElement('input');
        indexField.setAttribute('type', 'number');
        indexField.setAttribute('name', 'index');
        indexField.setAttribute('value', _index);
        form.appendChild(indexField);

        var dateField = document.createElement('input');
        dateField.setAttribute('type', 'date');
        dateField.setAttribute('name', 'date');
        dateField.setAttribute('value', _date);
        form.appendChild(dateField);

        var timeField = document.createElement('input');
        timeField.setAttribute('type', 'time');
        timeField.setAttribute('name', 'time');
        timeField.setAttribute('value', _time);
        form.appendChild(timeField);

        var descField = document.createElement('input');
        descField.setAttribute('type', 'text');
        descField.setAttribute('name', 'description');
        descField.setAttribute('value', _description);
        form.appendChild(descField);
        
        document.body.appendChild(form);
        form.submit();
    }

    function deleteSchedule(_index){
        if(confirm("일정을 삭제 하시겠습니까?")){
            setInputDeleteForm(_index, true);
        }
    }

    function checkDeleteSuccess(){
        if("<%=isDeleteSuccess%>" == "true"){
            alert("일정을 삭제하였습니다");
            setInputDeleteForm(-1, false);
        }
        else{
            alert("일정 삭제에 실패하였습니다");
        }
    }

    function setInputDeleteForm(_index, _bool){
            var form = document.createElement('form');
            form.setAttribute('method','post');
            form.setAttribute('action', "./Scheduler.jsp?year=" + <%=year%> 
                + "&month=" + <%=month%>);
            form.style.display = "none";

            var indexField = document.createElement('input');
            indexField.setAttribute('type', 'number');
            indexField.setAttribute('name', "index");
            indexField.setAttribute('value', _index);
            form.appendChild(indexField);
            var boolField = document.createElement('input');
            boolField.setAttribute('type', 'text');
            boolField.setAttribute('name', 'isPushDeleteBtn');
            boolField.setAttribute('value', _bool);
            form.appendChild(boolField);
            
            document.body.appendChild(form);
            form.submit();
    }
</script>
</html>