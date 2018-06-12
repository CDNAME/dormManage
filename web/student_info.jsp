<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.sql.*" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>学生信息</title>
    <style type="text/css">
        * {
            padding: 0px;
            margn: 0px;
        }

        table#stuRecordTable {
            width: 600px;
            margin: 40px auto;
            text-align: center;
        }

        table#stuRecordTable tr {
            height: 30px;
        }
    </style>
    <!--javascript脚本代码，定义了删除和修改方法，负责动态更新页面和提交表单-->
    <script type="text/javascript">
        function $(eleStr) {
            switch (eleStr.substr(0, 1)) {
                case "#":
                    return document.getElementById(eleStr.substr(1));
                    break;
                case ".":
                    return document.getElementsByClassName(eleStr.substr(1));
                    break;
                case "_":
                    return document.getElementsByName(eleStr.substr(1));
                    break;
                default:
                    return document.getElementsByTagName(eleStr);
                    break;
            }
        }

        onload = function () {

            doOperator();
        }

        function doOperator() {

            var updates = $(".update");
            var dels = $(".del");
            for (var i = 0; i < dels.length; i++) {
                dels[i].onclick = function () {
                    if (confirm("删除后该学生的所有信息将被删除，是否确定删除？")) {  //提示是否删除
                        document.getElementById('aform'+this.parentNode.parentNode.rowIndex).submit();  //提交表单信息
                        $("#stuRecordTable").deleteRow(this.parentNode.parentNode.rowIndex);    //删除页面上该行数据
                    }
                }
                updates[i].onclick = function () {
                    var operatorCell = this.parentNode.parentNode.getElementsByTagName("td")[2]; //取到要操作的td对象
                    //1.修改按钮上有两个功能：修改，确定修改
                    if (this.value == "修改") {
                        //做修改操作
                        this.value = "确定";
                        operatorCell.innerHTML = "<input value='" + operatorCell.innerHTML + "'/>";//把内容变成文本框
                    } else {
                        //做确定修改
                        operatorCell.innerHTML = operatorCell.getElementsByTagName("input")[0].value;//把文本框变成内容
                        //document.getElementById('bform'+this.parentNode.parentNode.rowIndex).submit();  //提交表单信息。另外，这个功能就不写了
                        this.value = "修改";
                    }
                }
            }
        }
    </script>
</head>
<body>
<h3 align='center'>学生列表</h3>
<table id="stuRecordTable" border="1" cellpadding="0" cellspacing="0">
    <tr align='center'>
        <th>学号</th>
        <th>姓名</th>
        <th>宿舍号</th>
        <th>入学时间</th>
        <th>操作</th>
    </tr>
    <% //JDBC
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int i = 0;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            conn = DriverManager.getConnection("jdbc:sqlserver://localhost:1433;DatabaseName=DormManage", "sa", "12345");
            String sql = "SELECT * FROM Student";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                i++;
    %>
    <form id="<%out.print("aform"+i);%>" action="/DormManage/delete_student" method="post">
        <input type="hidden" name="snum" value="<%out.print(rs.getString("Snum"));%>">
    </form>
    <form id="<%out.print("bform"+i);%>" action="/DormManage/delete_student" method="post">
        <input type="hidden" name="dormnum" value="<%out.print(rs.getString("DormNum"));%>">
    </form>
    <tr>
        <td><%out.print(rs.getString("Snum"));%></td>
        <td><%out.print(rs.getString("Sname"));%></td>
        <td><%out.print(rs.getString("DormNum"));%></td>
        <td><%out.print(rs.getString("EnterTime"));%></td>
        <td><input type="button" value="删除" class="del" >
            <input type="button" value="修改" class="update">
        </td>
    </tr>
    </form>
    <% }
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