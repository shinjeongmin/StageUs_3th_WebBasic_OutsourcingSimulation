<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("UTF-8"); // JSP request 한글 인코딩 처리
    int index = Integer.parseInt(request.getParameter("index"));
    String date = request.getParameter("date");
    String time = request.getParameter("time");
    String description = request.getParameter("description");

    String isModifySuccess = (String)request.getAttribute("isModifySuccess");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./css/ModifySchedule.css">
    <title>Document</title>
</head>
<body>
    <div id="main">
        <div id="header">
            <img id="headerImg" src="./img/schedule/modifyScheduleImg.png">
            <a id="headerText">Modify Schedule</a>
        </div>
        <hr>
        <form id="modifyScheduleForm" action="./DB_jsp/db_ModifySchedule.jsp" method="POST">
            <div id="dateAndTime">
                <input id="index" type="number" name="index" value="<%=index%>"
                    style="display: none;">
                <input id="date" type="date" placeholder="Date" name="date" value="<%=date%>">
                <input id="time" type="time" placeholder="Time" name="time" value="<%=time%>">
            </div>
            <textarea id="description" type="text" placeholder="Description" name="description"><%=description%></textarea>
            <div id="btns">
                <button class="btn" type="button" onclick="checkScheduleContent()">Ok</button>
                <button class="btn" type="button" onclick="backToSchedule()">Cancel</button>
            </div>
        </form>
    </div>
</body>
<script>
    window.onload = function(){
        if(<%=isModifySuccess%> != null){
            if("<%=isModifySuccess%>" == "true"){
                alert("일정을 수정하였습니다\n메인 일정 페이지로 이동합니다");
                locationPageSchedule();
            }
            else{
                alert("일정 수정에 실패하였습니다");
            }
        }
    }

    function checkScheduleContent(){
        if(document.getElementById("date").value == "")
        {
            alert("일정을 수정할 수 없습니다\n날짜를 입력해주세요");
        }
        else if(document.getElementById("time").value == ""){
            alert("일정을 수정할 수 없습니다\n시간을 입력해주세요");
        }
        else if(document.getElementById("description").value == "")
        {
            alert("일정을 수정할 수 없습니다\n내용을 입력해주세요");
        }
        else{
            document.getElementById("modifyScheduleForm").submit();
        }
    }

    function locationPageSchedule(){
        var today = new Date();
        location.href= "../Scheduler.jsp?year=" + today.getFullYear() 
            + "&month=" + parseInt(today.getMonth() + 1) + "";
    }

    function backToSchedule(){
        var today = new Date();
        location.href= "./Scheduler.jsp?year=" + today.getFullYear() 
            + "&month=" + parseInt(today.getMonth() + 1) + "";
    }
</script>
</html>