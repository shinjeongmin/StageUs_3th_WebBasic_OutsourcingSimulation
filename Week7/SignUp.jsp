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
    <link rel="stylesheet" href="./SignUp.css">
    <title>Document</title>
</head>
<body>  
    <div id="window">
        <div id="header">
            sign up your account!
        </div> 
        <form id="content" action="SignUpConfirm.jsp" method="POST">
            <input id="inputId" class="inputBox" type="text" placeholder="id" name="id">
            <input id="inputPw" class="inputBox" type="password" placeholder="password" name="pw">
            <input class="signBtn" type="submit" value="create account">
            <a id="cancelBtn" class="signBtn" href="./Login.jsp">cancel</a>
        </form>
    </div>
</body>
</html>