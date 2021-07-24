<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.ResultSet"%>

<%
    Connection conn=null; 
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    int rsInt = 0;
    request.setCharacterEncoding("utf-8");

    boolean isSignUp = false;
    boolean isDuplate = false;
    String id = request.getParameter("id");
    String pw = request.getParameter("pw");
    String email = request.getParameter("email");
    String name = request.getParameter("name");
    String phoneNumber = request.getParameter("phoneNumber");

    try{
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db","stageus", "1234");
        String sql = "select * from week6 where id = ?;";
        pstmt = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
        pstmt.setString(1, id);
        rs = pstmt.executeQuery();
        rs.last();
        int count = rs.getRow();

        if(count == 0){
            isDuplate = false;
        }
        else if(count == 1){
            isDuplate = true;
        }
    }finally{}

    if(isDuplate == false){
        try{
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db","stageus", "1234");
            String sql = "insert into week6(id, pw, email, name, phoneNumber) values(?,?,?,?,?);";
            pstmt = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            pstmt.setString(1, id);
            pstmt.setString(2, pw);
            pstmt.setString(3, email);
            pstmt.setString(4, name);
            pstmt.setString(5, phoneNumber);
            rsInt = pstmt.executeUpdate();
            int count = rsInt;

            if(count == 0){
                isSignUp = false;
            }
            else if(count == 1){
                isSignUp = true;
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
    }
    else{
        isSignUp = false;
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
    
</body>
<script>
    if(<%=isSignUp%>){
        alert("success : 회원가입 성공");
        location.href="week6_login.jsp";
    }else if(<%=isDuplate%>){
        alert("fail: 중복된 id");
        location.href="week6_signup.jsp";
    }
    else{
        alert("fail: 회원가입 실패");
        location.href="week6_signup.jsp";
    }
</script>
</html>