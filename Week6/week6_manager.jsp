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

    String id = (String) session.getAttribute("sessionId");
    String pw = (String) session.getAttribute("sessionPw");
    String email = null;
    String username = null;
    String phoneNumber = null;

    String sessionId = null;
    if(session.getAttribute("sessionId") != null){
        sessionId = "\""+(String)session.getAttribute("sessionId")+"\"";
    }
    else{

    }

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

        if(count == 0){
        }
        else if(count == 1){
            // 로그인 성공 시 정보 로드
            email = rs.getString("email");
            username = rs.getString("name");
            phoneNumber = rs.getString("phoneNumber");
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
    1. 세션 ID : <%= session.getId() %> <BR>
    2. 세션 유지시간 : <%= session.getMaxInactiveInterval() %> <BR>
    3. 세션의 설정 id : <%= session.getAttribute("sessionId") %> <BR>


    <div>
        <h1>정보 수정하기</h1>
        <form action="week6_login.jsp" method="POST">
            <%-- <a>아이디 : </a> <input id="editId" value=""> <br> --%>
            <%-- <a>비밀번호 : </a> <input id="editPw" value=""> <br> --%>
            <a>이메일 : </a> <input id="editEmail" value="" name="email"> <br>
            <a>이름 : </a> <input id="editName" value="" name="name"> <br>
            <a>연락처 : </a> <input id="editPhoneNum" value="" name="phoneNumber"></a> <br>
            <input type="submit" value="변경하기">
        </form>
    </div>
</body>
<script>
    let time = <%=session.getMaxInactiveInterval()%>;
    console.log("<%=session.getId()%>");

    if(<%=sessionId%> != null)
        Login();
    else{
        alert("세션 만료");
        location.href="week6_login.jsp";
    }

    function Login(){
        // document.getElementById("editId").value = "<%=id%>";
        // document.getElementById("editPw").value = "<%=pw%>";
        document.getElementById("editEmail").value = "<%=email%>";
        document.getElementById("editName").value = "<%=username%>";
        document.getElementById("editPhoneNum").value = "<%=phoneNumber%>";
    }

    setInterval(() => {
        if(time>=0){
            console.log("세션 : " + time);
            time -= 1;
        }
    }, 1000);
</script>
</html>