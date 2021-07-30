<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.ResultSet"%>

<%
    Connection conn=null; 
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    request.setCharacterEncoding("utf-8");

    // 로그인 페이지를 처음 들어왔을 때부터 DB를 체크하는 구조가 이상.
    // html코드만 있도록 하는게 깔끔함.
    // jsp모듈을 만들어 action으로 return값만 받는 방법(로그인 시도)를 JS에서 성공여부 체크.
    // 그 이후 동작은 JS로 처리
    String id = request.getParameter("id");
    String pw = request.getParameter("pw");

    // 스파게티 코드 JSP쓰지 않고 데이터만 가져와서 JS에서 파싱처리 
    // DOM 생성은 웬만하면 JS로
    // JS에서 JSP의 데이터를 불러오고 보내는 과정으로 수정
    // +a 로그인 모듈 따로 분리
    // jsp보다 js의 window.onload가 먼저 실행되는가?
    if(id != null && pw != null){
        try{
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db","stageus", "1234");
            String sql = "select * from user where id=? and pw=?";
            pstmt = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            pstmt.setString(1, id);
            pstmt.setString(2, pw);
            rs = pstmt.executeQuery();
            rs.last();
            int count = rs.getRow();

            if(count == 0){
                out.println("<script> alert(\"로그인에 실패하였습니다\\n아이디와 비밀번호를 다시 확인해주세요\"); </script>");
            }
            else{
                // session
                session.setAttribute("sessionId", id);
                session.setAttribute("sessionPw", pw);
                
                // 현재 date 세션에 저장
                Date time = new Date();
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                session.setAttribute("curDate", formatter.format(session.getCreationTime()));
                
                // get method로 현재 날짜 보내기 (month는 데이터 형식 때문에 앞의 0을 제거한[07 → 7] 형태로 보냄)
                String[] curDateArr = session.getAttribute("curDate").toString().split("-");
                out.println("<script> alert(\"로그인에 성공하였습니다\\n일정 페이지로 이동합니다\"); </script>");
                out.println("<script> location.href = \"./Scheduler.jsp?year=" + curDateArr[0]
                    + "&month=" + curDateArr[1].replaceFirst("^0+(?!$)", "") +"\" </script>");
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
        session.removeAttribute("sessionId");
        session.removeAttribute("sessionPw");
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
        <div>
            Login to Todo Today!
        </div> 
        <form action="Login.jsp" method="POST">
            <input id="inputId" type="text" placeholder="id" name="id"> <br>
            <input id="inputPw" type="password" placeholder="password" name="pw">
            <div>
                <a id="signUpBtn" href="./SignUp.jsp">sign up</a>
                <input id="signInBtn" type="submit" value="sign in">
            </div>
        </form>
    </div>
</body>
<script>

</script>
</html>