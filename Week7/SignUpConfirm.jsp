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
    String id = request.getParameter("id");
    String pw = request.getParameter("pw");
    if(id != null){
        try{
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db","stageus", "1234");
            String sql = "select * from user where id=?";
            pstmt = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();
            rs.last();
            int count = rs.getRow();
            if(count == 0){
                //
                if(id != null && pw != null){
                    try{
                        sql = "insert into user(id, pw) values(?, ?)";
                        pstmt = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                        pstmt.setString(1, id);
                        pstmt.setString(2, pw);
                        rsInt = pstmt.executeUpdate();
                        count = rsInt;
                        if(count == 0){
                            out.println("<script> alert(\"쿼리 입력 실패\"); </script>");
                        }
                        else{
                            out.println("<script> alert(\"계정 생성에 성공하였습니다\\n로그인 페이지로 이동합니다\"); </script>");
                            out.println("<script> location.href = \"./Login.jsp\"; </script>");
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
                    out.println("<script> alert(\"id, pw 입력 실패\"); </script>");
                }
                //
            }
            else{
                out.println("<script> alert(\"계정 생성에 실패하였습니다\\n이미 해당 아이디의 계정이 존재합니다\"); </script>");
                out.println("<script> location.href = \"./SignUp.jsp\"; </script>");
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
    }
%>