<%%><%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.ResultSet"%>

<%
    Connection conn=null; 
    PreparedStatement pstmt = null;
    int rs = 0;
    request.setCharacterEncoding("utf-8");

    boolean isUpdate = false;
    String id = (String) session.getAttribute("sessionId");
    String email = request.getParameter("email");
    String name = request.getParameter("name");
    String phoneNumber = request.getParameter("phoneNumber");

    String sessionId = null;
    if(session.getAttribute("sessionId") != null){
        sessionId = "\""+(String)session.getAttribute("sessionId")+"\"";
    }

    try{
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db","stageus", "1234");
        String sql = "update week6 set email=?, name=?, phoneNumber=? where id=?;";
        pstmt = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
        pstmt.setString(1, email);
        pstmt.setString(2, name);
        pstmt.setString(3, phoneNumber);
        pstmt.setString(4, id);
        rs = pstmt.executeUpdate();
        int count = rs;

        if(count == 0){
            isUpdate = false;
        }
        else if(count == 1){
            isUpdate = true;
        }
    }
    finally{
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
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>main</title>
</head>
<body>
    <form action="week6_main.jsp" method="POST">
        <input type="text" name="id"> <br>
        <input type="password" name="pw"><br>
        <input type="submit" value="로그인">
    </form>
</body>
<script>
    if(<%=sessionId%> != null){
        if(<%=isUpdate%>){
            alert("정보 수정 완료\n다시 로그인하세요");
        }else{
            alert("정보 수정 실패");
            location.href="week6_login.jsp";
        }
    }
</script>
</html>