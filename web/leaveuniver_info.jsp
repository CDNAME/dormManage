<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.sql.*" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>学生离校信息</title>
    <style type="text/css">
        *{
            padding:0px;
            margn:0px;
        }
        table#stuRecordTable{width:600px;margin:40px auto;text-align: center;}
        table#stuRecordTable tr{height:30px;}
    </style>
</head>
<body>
<h3 align='center'>学生离校列表</h3>
<table id="stuRecordTable" border="1" cellpadding="0" cellspacing="0">
    <tr align='center'>
        <th>学号</th>
        <th>宿舍号</th>
        <th>离校时间</th>
        <th>返校时间</th>
    </tr>
    <% //JDBC
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            conn = DriverManager.getConnection("jdbc:sqlserver://localhost:1433;DatabaseName=DormManage", "sa", "12345");
            String sql = "SELECT * FROM LeaveUniver";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                out.print("<tr align='center'>");
                out.print("<th>" + rs.getString("Snum") + "</th>");
                out.print("<th>" + rs.getString("DormNum") + "</th>");
                out.print("<th>" + rs.getString("LeaveTime") + "</th>");
                out.print("<th>" + rs.getString("ReturnTime") + "</th>");
                out.print("</tr>");
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        rs.close();
        pstmt.close();
        conn.close();
    %>
</table>
</body>
</html>
