<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.sql.*" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>宿舍报修信息</title>
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
<h3 align='center'>宿舍报修列表</h3>
<form action="/DormManage/repair" method="post" style="display:block;text-align:center;">
    请选择你要查询的宿舍楼报修情况：
    <select name="build">
        <option value="07">7栋</option>
        <option value="08">8栋</option>
        <option value="09">9栋</option>
        <option value="10" selected="selected">10栋</option>
    </select>
    <input type="submit" value="查询">
</form>
<p align="center">
    <a href="add_repair.jsp">新增宿舍报修信息</a>
</p>
<table id="stuRecordTable" border="1" cellpadding="0" cellspacing="0">
    <tr align='center'>
        <th>宿舍号</th>
        <th>财产号</th>
        <th>状态</th>
    </tr>
    <% //JDBC
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            conn = DriverManager.getConnection("jdbc:sqlserver://localhost:1433;DatabaseName=DormManage", "sa", "12345");
            String sql = "SELECT * FROM Repairs";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                out.print("<tr align='center'>");
                out.print("<th>" + rs.getString("DormNum") + "</th>");
                out.print("<th>" + rs.getString("Property") + "</th>");
                out.print("<th>" + rs.getString("Status") + "</th>");
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
