package com.cd.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/addrepair")
public class AddaRepair extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //解决中文乱码
        request.setCharacterEncoding("UTF-8");
        //获取表单数据
        String dormnum = request.getParameter("dorm_num");
        String propertynum = request.getParameter("property_num");
        String status = request.getParameter("status");

        //判断如果提交的表单数据如果不为空，则将数据注入到数据库中，否则不注入
        if(propertynum != null && propertynum != "") {
            //JDBC
            Connection conn = null;
            PreparedStatement ps = null;
            int count = 0;
            try{
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                conn = DriverManager.getConnection("jdbc:sqlserver://localhost:1433;DatabaseName=DormManage","sa","12345");
                conn.setAutoCommit(false);
                String sql = "insert into Repairs values(?,?,?)";
                ps = conn.prepareStatement(sql);
                ps.setString(1,dormnum);
                ps.setString(2,propertynum);
                ps.setString(3,status);
                count = ps.executeUpdate();
                conn.commit();
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            } catch(SQLException e) {
                if(conn != null){
                    try {
                        conn.rollback();
                    } catch (SQLException e1) {
                        e1.printStackTrace();
                    }
                }
                e.printStackTrace();
            } finally {
                if(ps != null){
                    try {
                        ps.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
                if(conn != null) {
                    try {
                        conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
            if(count == 1) {
                //保存成功，“跳转”到保存成功页面
                //重定向，可以解决刷新重复提交数据的问题
                response.sendRedirect(request.getContextPath() + "/repair_info.jsp");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/repair_info.jsp");
        }
    }
}
