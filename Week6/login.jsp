<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.ResultSet"%>
<% 
    Connection conn=null; 
    PreparedStatement pstmt = null;
    // 일꾼 : statement
    ResultSet rs = null;
    request.setCharacterEncoding("utf-8");
    boolean isLogin = false;

    String id = request.getParameter("id");
    String pw = request.getParameter("pw");

    try{
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db","stageus", "1234");
        String sql = "select * from user where id=? and pw=?";
        pstmt = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
        pstmt.setString(1, id);
        pstmt.setString(2, pw);
        rs = pstmt.executeQuery();
        // executeUpdate : 값을 업데이트 할 때 (바꿀 때 사용) 사용. 반환 값이 없음
        rs.last();
        int count = rs.getRow();

        if(count == 0){
            isLogin = false;
        }
        else if(count == 1){
            isLogin = true;
        }
    }
    // finally 부분 안해주면 메모리 누수 현상 발생
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

<script>
    if(<%=isLogin%> == true){
        console.log("success : 로그인 성공");
    } else{
        console.log("fail : 로그인 실패");
    }
</script>