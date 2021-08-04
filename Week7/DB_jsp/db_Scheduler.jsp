<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>

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
    
    int index = 0;
    String curDate = null;
    String time = null;
    String day = null;
    String ordinalChar = null;
    JSONArray scheduleJSONArr = new JSONArray();

    if(rs == null) return;
    while(rs.next()){
        JSONObject jsonObj = new JSONObject();
        for(int i = 1; i <= 5; i++){
            jsonObj.put(rs.getMetaData().getColumnName(i), rs.getString(i));
        }
        scheduleJSONArr.add(jsonObj);
    }
    request.setAttribute("scheduleJsonArr", scheduleJSONArr);

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

<%-- 
        if(curDate != rs.getString("date")){
            index = rs.getInt("idx");
            curDate = rs.getString("date");
            // check correnpond year & month
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
--%>
