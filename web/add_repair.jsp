<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>新增报修信息</title>
    <!--css样式-->
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
<h3 align='center'>新增宿舍报修信息</h3>
<form action="/DormManage/addrepair" method="post" style="display:block;text-align:center;">
    <table id="stuRecordTable" border="1" cellpadding="0" cellspacing="0">
        <tr align='center'>
            <th>宿舍号</th>
            <th>财产号</th>
            <th>状态</th>
        </tr>
        <tr align='center'>
            <td><input type="text" name="dorm_num"/></td>
            <td><input type="text" name="property_num"/></td>
            <td><input type="text" name="status"/></td>
        </tr>
    </table>
    <p align="center">
        <input type="submit" value="提交">
    </p>
</form>
</body>
</html>
