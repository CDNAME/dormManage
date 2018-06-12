package com.cd.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

@WebServlet("/repair")
public class RepairQueryServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        out.print("        <!DOCTYPE html>");
        out.print("<html lang=en'>");
        out.print("                <head>");
        out.print("    <meta charset='UTF-8'>");
        out.print("    <title>报修信息查询</title>");
        out.print("</head>");
        out.print("<body>");
        out.print("<h3 align='center'>报修信息查询结果</h3>");
        out.print("<hr width='60%'>");
        out.print("<table border='1' align='center' width='50%'>");
        out.print("    <tr align='center'>");
        out.print("        <th>宿舍号</th>");
        out.print("        <th>财产号</th>");
        out.print("        <th>报修状态</th>");
        out.print("    </tr>");

        Connection conn = null;
        CallableStatement cstmt = null; //定义存储过程的statement
        ResultSet rs = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            conn = DriverManager.getConnection("jdbc:sqlserver://localhost:1433;DatabaseName=DormManage", "sa", "12345");
            cstmt = conn.prepareCall("{call repairs_query(?)}");  //加载存储过程
            switch (Integer.parseInt(request.getParameter("build"))) {   //从request中获取用户输入的信息
                case 10:
                    cstmt.setString(1, "10");
                    break;
                case 9:
                    cstmt.setString(1, "09");
                    break;
                case 8:
                    cstmt.setString(1, "08");
                    break;
                case 7:
                    cstmt.setString(1, "07");
                    break;
            }
            rs = cstmt.executeQuery();
            while(rs.next()) {
                out.print("        <th>"+rs.getString("DormNum")+"</th>");
                out.print("        <th>"+rs.getString("Property")+"</th>");
                out.print("        <th>"+rs.getString("Status")+"</th>");
                out.print("    </tr>");
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (cstmt != null) {
                    cstmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        out.print("</table>");
        out.print("</body>");
        out.print("</html>");
    }
}
