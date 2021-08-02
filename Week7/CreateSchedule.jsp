<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String isCreateSuccess = (String)request.getAttribute("isCreateSuccess");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./CreateSchedule.css">
    <title>Document</title>
</head>
<body>
    <div>
        <div id="header">
            <img src="">
            <a>Create Schedule</a>
        </div>
        <hr>
        <div id="body">
            <form action="db_CreateSchedule.jsp" method="POST" id="createScheduleForm">
                <div id="dateAndTime">
                    <input id="date" type="date" placeholder="Date" name="date">
                    <input id="time" type="time" placeholder="Time" name="time">
                </div>
                <input id="description" type="text" placeholder="Description" name="description">
                <div id="btns">
                    <button type="button" onclick="checkScheduleContent()">Ok</button>
                    <button type="button" onclick="locationPageSchedule()">Cancel</button>
                </div>
            </form>
        </div>
    </div>
</body>
<script>
    window.onload = function(){
        if(<%=isCreateSuccess%> != null){
            if("<%=isCreateSuccess%>" == "true"){
                alert("일정을 생성하였습니다\n메인 일정 페이지로 이동합니다");
                locationPageSchedule();
            }
            else{
                alert("일정 추가에 실패하였습니다");
            }
        }
    }

    function checkScheduleContent(){
        if(document.getElementById("date").value == "")
        {
            alert("일정을 생성할 수 없습니다\n날짜를 입력해주세요");
        }
        else if(document.getElementById("time").value == ""){
            alert("일정을 생성할 수 없습니다\n시간을 입력해주세요");
        }
        else if(document.getElementById("description").value == "")
        {
            alert("일정을 생성할 수 없습니다\n내용을 입력해주세요");
        }
        else{
            document.getElementById("createScheduleForm").submit();
        }
    }
    
    function locationPageSchedule(){
        var today = new Date();
        location.href= "./Scheduler.jsp?year=" + today.getFullYear() 
            + "&month=" + parseInt(today.getMonth() + 1) + "";
    }
</script>
</html>