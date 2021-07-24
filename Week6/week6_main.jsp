<%%><%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.ResultSet"%>

<%
    Connection conn=null; 
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    request.setCharacterEncoding("utf-8");

    boolean isLoginFail = false;
    String id = request.getParameter("id");
    String pw = request.getParameter("pw");
    String email = null;
    String username = null;
    String phoneNumber = null;

    String sessionId = null;

    try{
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db","stageus", "1234");
        String sql = "select * from week6 where id=? and pw=?";
        pstmt = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
        pstmt.setString(1, id);
        pstmt.setString(2, pw);
        rs = pstmt.executeQuery();
        rs.last();
        int count = rs.getRow();

        if(count == 0 && id != null){
            isLoginFail = true;
        }
        else if(count == 1){
            // 세션
            if(session.isNew()) {
                session.setMaxInactiveInterval(10);
                out.println("<script> alert('세션이 해제되어 다시설정합니다.') </script>");
            }
            else{
                session.invalidate();
                out.println("<script> alert('세션을 삭제하고 다시설정합니다.') </script>");
                session = request.getSession(true);
                session.setMaxInactiveInterval(10);
            }
            session.setAttribute("sessionId", id);
            session.setAttribute("sessionPw", pw);
            // 로그인 성공 시 정보 로드
            email = rs.getString("email");
            username = rs.getString("name");
            phoneNumber = rs.getString("phoneNumber");
            if(session.getAttribute("sessionId") != null){
                sessionId = "\""+(String)session.getAttribute("sessionId")+"\"";
            }
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
    <a href="week6_login.jsp" id="loginBtn">로그인</a>
    <a href="week6_signup.jsp" id="signUpBtn">회원가입</a>
    <a href="week6_manager.jsp" id="modifyInfoBtn">정보수정</a>
    
    <div id="userInfo">
        <h1>로그인 정보</h1>
        <a>아이디 : </a> <a id="viewId"></a> 
        <br>
        <a>이메일 : </a> <a id="viewEmail"></a><br>
        <a>이름 : </a> <a id="viewName"></a><br>
        <a>연락처 : </a> <a id="viewPhoneNum"></a>
    </div>
</body>
<script>
    var time = <%=session.getMaxInactiveInterval()%>;
    console.log("<%=session.getId()%>");
    if(<%=sessionId%> != null)
        login();
    else if(<%=isLoginFail%>){
        alert("로그인 실패");
        location.href="week6_login.jsp";
    }
    else{
        alert("로그인 하세요");
        loginFail();
    }

    function login(){
        alert("로그인 성공");
        document.getElementById("viewId").innerHTML = "<%=id%>";
        document.getElementById("viewEmail").innerHTML = "<%=email%>";
        document.getElementById("viewName").innerHTML = "<%=username%>";
        document.getElementById("viewPhoneNum").innerHTML = "<%=phoneNumber%>";

        document.getElementById("loginBtn").style.visibility = "hidden";
        document.getElementById("signUpBtn").style.visibility = "hidden";
    }

    function loginFail(){
        document.getElementById("modifyInfoBtn").style.visibility = "hidden";
        document.getElementById("userInfo").style.visibility = "hidden";
    }

    setInterval(() => {
        if(time>=0){
            console.log("세션 : " + time);
            time -= 1;
        }
    }, 1000);
</script>
</html>