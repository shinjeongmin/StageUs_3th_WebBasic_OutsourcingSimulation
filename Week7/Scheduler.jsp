<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.ResultSet"%>

<%
    Connection conn=null; 
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    request.setCharacterEncoding("utf-8");

    String id = (String) session.getAttribute("sessionId");
    int count = 0;
    String year = request.getParameter("year");
    String month = request.getParameter("month");

    if(id != null){
        try{
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db","stageus", "1234");
            String sql = "select * from schedule where id=? order by date, time, description";
            pstmt = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();
        }finally{}
    }
    else{
        out.println("<script> alert(\"세션이 만료되었습니다 다시 로그인 해주세요\"); </script>");
        out.println("<script> location.href = \"./Login.jsp\"; </script>");
    }
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
            <a id="welcomeText"> <span id="userId"><%=id%></span>'s Todo Lists </a>
        </div>
        <div id="navigation">
            <button onclick="pastMonth()">화살표</button>
            <div>
                <span><%=year%></span>
                <span><%=String.format("%02d", Integer.parseInt(month))%></span>
                <span>Schedules</span>
            </div>
            <button onclick="nextMonth()">화살표</button>
        </div>
        <div>
            <a href="./CreateSchedule.jsp">Create Schedule</a>
            <img src="" alt="">
        </div>
        <div id="body">
            <%
                int index = 0;
                String curDate = null;
                String time = null;
                String day = null;
                String ordinalChar = null;
                if(rs == null) return;
                while(rs.next()){
                    if(curDate != rs.getString("date")){
                        index = rs.getInt("idx");
                        curDate = rs.getString("date");
                        // check correnpond year & month
                        // --- test code
                        //out.println("<script> alert(\""+curDate.split("-")[0] + " " + year + " " + (curDate.split("-")[0].equals(year))+"\")</script>");
                        //out.println("<script> alert(\""+curDate.split("-")[1].replaceFirst("^0+(?!$)", "") + " " + month + " " + (curDate.split("-")[1].replaceFirst("^0+(?!$)", "").equals(month))+"\")</script>");
                        // ---
                        if(!curDate.split("-")[0].equals(year) ||
                             !curDate.split("-")[1].replaceFirst("^0+(?!$)", "").equals(month))
                            continue;
                        // set day format
                        if(!curDate.split("-")[2].replaceFirst("^0+(?!$)", "").equals(day))
                        {
                            day = curDate.split("-")[2].replaceFirst("^0+(?!$)", "");
                            if(day == "1") ordinalChar = "st";
                            else if(day == "2") ordinalChar = "nd";
                            else ordinalChar = "th";
                            %>
                                <hr>
                                <a class="date"><%=day%><%=ordinalChar%></a>
                            <%
                        }
                        // set time format
                        String[] timeArr = rs.getString("time").split(":");
                        time = timeArr[0] + ":" + timeArr[1];
                    }
            %>
                <div class="scheduleBox">
                    <div class="scheduleContent">
                        <div class="scheduleDateTime">
                            <span class="date"><%=rs.getString("date")%></span>
                            <span class="time"><%=time%></span>
                        </div>
                        <a class="scheduleDescription"><%=rs.getString("description")%></a>
                        <img class="pastScheduleSign" src="">
                    </div>
                    <button class="modifyBtn" onclick="modifySchedule(<%=index%>, '<%=curDate%>', '<%=time%>', '<%=rs.getString("description")%>')">
                        편집
                    </button>
                    <button class="deleteBtn" onclick="deleteSchedule(<%=index%>)">X</button>
                </div>
            <%
                }
            %>
        </div>
    </div>
</body>
<%
    if(pstmt != null){
        try{
            pstmt.close();
        }
        catch(Exception e){}
    }
    if(conn != null){
        try{
            conn.close();
        }
        catch(Exception e){}
    }    
%>
<script>
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
            var form = document.createElement('form');
            form.setAttribute('method','post');
            form.setAttribute('action', './DeleteSchedule.jsp');

            var indexField = document.createElement('input');
            indexField.setAttribute('type', 'number');
            indexField.setAttribute('name', 'index');
            indexField.setAttribute('value', _index);
            form.appendChild(indexField);
            
            document.body.appendChild(form);
            form.submit();
        }
    }
</script>
</html>