<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String id = (String) session.getAttribute("sessionId");
    String[] curDateArr = session.getAttribute("curDate").toString().split("-");

    if(id == null)
    {
        out.println("<script> alert(\"세션이 만료되었습니다 다시 로그인 해주세요\"); </script>");
        out.println("<script> location.href = \"./Login.jsp\"; </script>");
    }
    String year = curDateArr[0];
    String month = curDateArr[1].replaceFirst("^0+(?!$)", "");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
            <form action="CreateScheduleConfirm.jsp" method="POST" id="createScheduleForm">
                <div id="dateAndTime">
                    <input id="date" type="date" placeholder="Date" name="date">
                    <input id="time" type="time" placeholder="Time" name="time">
                </div>
                <input id="description" type="text" placeholder="Description" name="description">
                <div id="btns">
                    <button type="button" onclick="checkScheduleContent()">Ok</button>
                    <button type="button" onclick="pageSchedule()">Cancel</button>
                </div>
            </form>
        </div>
    </div>
</body>
<script>
    function pageSchedule(){
        location.href= "./Scheduler.jsp?year=" + <%=year%> + "&month=" + <%=month%>+ "";
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
</script>
</html>