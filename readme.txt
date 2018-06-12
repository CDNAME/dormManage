src文件是java代码，里面包含四个个Servlet程序。其中
	- LaterbackQuery.java是晚归情况查询 
	- RepairQueryServlet.java是报修情况查询
	- AddaRepair.java是新增报修记录
	- DeleteStudent.java是删除学生学籍，该servlet关联触发器，删除学生学号后，学生的晚归记录会一并删除。
	
web文件是JSP代码，里面包含8个简单的jsp程序。