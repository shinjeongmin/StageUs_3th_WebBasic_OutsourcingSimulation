<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.ResultSet"%>

<!DOCTYPE html>
<html lang="kr">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>  
    <div>
        <div>
            sign up your account!
        </div> 
        <form action="SignUpConfirm.jsp" method="POST">
            <input id="inputId" type="text" placeholder="id" name="id"> <br>
            <input id="inputPw" type="password" placeholder="password" name="pw"> <br>
            <input type="submit" value="create account"> <br>
            <a id="cancelBtn" href="./Login.jsp">cancel</a>
        </form>
    </div>
</body>
</html>