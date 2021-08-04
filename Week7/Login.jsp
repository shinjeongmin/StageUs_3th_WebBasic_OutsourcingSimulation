<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String id = request.getParameter("id");
    String pw = request.getParameter("pw");
    boolean isTryLogin = false;
    
    if(id != null && pw != null){
        isTryLogin = true;    
    }
%>

<jsp:include page="./DB_jsp/db_Login.jsp" flush="false">
    <jsp:param name="id" value="<%=id%>"/>
    <jsp:param name="pw" value="<%=pw%>"/>
</jsp:include>
            
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./css/Login.css">
    <title>Document</title>
</head>
<body>
    <div id="window">
        <div id="header">
            Login to Todo Today!!
        </div>
        <form id="content" action="Login.jsp" method="POST">
            <input id="inputId" class="inputBox" type="text" placeholder="id" name="id">
            <input id="inputPw" class="inputBox" type="password" placeholder="password" name="pw">
            <div id="btnBox">
                <a id="signUpBtn" class="signBtn" href="./SignUp.jsp">sign up</a>
                <input id="signInBtn" class="signBtn" type="submit" value="sign in">
            </div>
        </form>
    </div>
</body>
<script>
    window.onload = function(){
        onLoad();
    }

    function onLoad(){
        console.log(<%=isTryLogin%>);
        if(<%=isTryLogin%>){
            Login();
        }
    }
    function Login(){
        var today = new Date();
        if(<%=Boolean.TRUE == request.getAttribute("isLoginSuccess")%>){
            alert("로그인에 성공하였습니다");
            location.href = "./Scheduler.jsp?year=" + today.getFullYear() 
                + "&month=" + parseInt(today.getMonth()+1);
        }
        else{
            alert("로그인에 실패하였습니다\n아이디와 비밀번호를 다시 확인해주세요");
        }
    }
</script>
</html>