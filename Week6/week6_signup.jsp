<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.ResultSet"%>

<%
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
    <form action="week6_signUpComfirm.jsp" method="POST">
        아이디 : <input type="text" name="id"> <br>
        비밀번호 : <input type="password" name="pw"><br>
        이메일 : <input type="email" name="email"><br>
        이름 : <input type="text" name="name"><br>
        연락처 : <input type="tel" name="phoneNumber"><br>
        <input type="submit" value="회원가입">
    </form>
</body>
<script>
</script>
</html>