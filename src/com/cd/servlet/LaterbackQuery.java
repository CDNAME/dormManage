package com.cd.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

@WebServlet("/laterback")
public class LaterbackQuery extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        out.print("        <!DOCTYPE html>");
        out.print("<html lang=en'>");
        out.print("                <head>");
        out.print("    <meta charset='UTF-8'>");
        out.print("    <title>宿舍晚归信息查询</title>");
        out.print("</head>");
        out.print("<body>");
        out.print("<h3 align='center'>宿舍晚归查询结果</h3>");
        out.print("<hr width='60%'>");
        out.print("<table border='1' align='center' width='50%'>");
        out.print("    <tr align='center'>");
        out.print("        <th>宿舍号</th>");
        out.print("        <th>姓名</th>");
        out.print("        <th>晚归时间</th>");
        out.print("        <th>晚归原因</th>");
        out.print("    </tr>");

        Connection conn = null;
        CallableStatement cstmt = null; //定义存储过程的statement
        ResultSet rs = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            conn = DriverManager.getConnection("jdbc:sqlserver://localhost:1433;DatabaseName=DormManage", "sa", "12345");
            cstmt = conn.prepareCall("{call laterback_query(?)}");  //加载存储过程
            cstmt.setString(1, request.getParameter("input_dormnum"));
            rs = cstmt.executeQuery();
            while (rs.next()) {
                out.print("        <th>" + rs.getString("DormNum") + "</th>");
                out.print("        <th>" + rs.getString("Sname") + "</th>");
                out.print("        <th>" + rs.getString("LateTime") + "</th>");
                out.print("        <th>" + rs.getString("LateReason") + "</th>");
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
