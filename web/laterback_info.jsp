<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.sql.*" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>学生晚归信息</title>
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
<h3 align='center'>学生晚归列表</h3>
<form action="/DormManage/laterback" method="post" style="display:block;text-align:center;">
    请输入宿舍号查询相应的宿舍晚归情况：
    <input type="text" size="8" name="input_dormnum">
    <input type="submit" value="查询">
</form>
<table id="stuRecordTable" border="1" cellpadding="0" cellspacing="0">
    <tr align='center'>
        <th>学号</th>
        <th>宿舍号</th>
        <th>姓名</th>
        <th>晚归时间</th>
        <th>晚归原因</th>
    </tr>
    <% //JDBC
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            conn = DriverManager.getConnection("jdbc:sqlserver://localhost:1433;DatabaseName=DormManage", "sa", "12345");
            String sql = "SELECT * FROM LateReback";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                out.print("<tr align='center'>");
                out.print("<th>" + rs.getString("Snum") + "</th>");
                out.print("<th>" + rs.getString("DormNum") + "</th>");
                out.print("<th>" + rs.getString("Sname") + "</th>");
                out.print("<th>" + rs.getString("LateTime") + "</th>");
                out.print("<th>" + rs.getString("LateReason") + "</th>");
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