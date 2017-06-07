<%@ page language="java" contentType="text/html;charset=UTF-8"
	language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<script src="/common/js/jquery-3.2.1.js"></script>
<script src="/common/js/jquery-migrate-3.0.0.js"></script>
<script src="/common/js/datetime.js"></script>
<script type="text/javascript">
	$(function() {

		console.log("timelog start");


		var setTimeCosted = function() {
			var defaultDate = $("#defaultDate").val();
			var startTimeStr = $("#startTime").val();
			var endTimeStr = $("#endTime").val();
			var startTime = new Date(startTimeStr);
			var endTime = new Date(endTimeStr);
			var timeCosted = Math.round((endTime.getTime() - startTime.getTime())/1000/60);
			$("#timeCosted").val(timeCosted);
		}

		$("#getStartTime").click(function() {
			$("#startTime").val((new Date()).pattern("yyyy-MM-dd HH:mm:ss"));
			setTimeCosted();
		});

		$("#getEndTime").click(function() {
			$("#endTime").val((new Date()).pattern("yyyy-MM-dd HH:mm:ss"));
			setTimeCosted();
		});
		$("#endTime").keyup(function() {
			setTimeCosted();
		});
// 		修改默认日期后，同步修改开始时间和结束时间
		$("#defaultDate").keyup(function() {
			var defaultDate = $("#defaultDate").val(); 
			var startTimeStr = $("#startTime").val();
			var endTimeStr = $("#endTime").val();
			var startTime = new Date(startTimeStr);
			var endTime = new Date(endTimeStr);
			$("#startTime").val(defaultDate + " " + startTime.pattern("HH:mm:ss"));
			$("#endTime").val(defaultDate + " " + endTime.pattern("HH:mm:ss"));
			setTimeCosted();
		});
		

	});
</script>
</head>

<body>
	<form action="/timelog/add" method="post">
		<div style="width: 500px">
			设置当前默认日期：<input id="defaultDate" name="defaultDate"
				value="${timelog.defaultDate}" />
		</div>
		<div style="width: 500px">
			开始时间：<input id="startTime" name="startTime"
				value="${timelog.startTime}" /><input type="button"
				id="getStartTime" value="获取当前时间" />
		</div>
		<div style="width: 500px">
			结束时间：<input id="endTime" name="endTime" value="${timelog.endTime}" /><input
				type="button" id="getEndTime" value="获取当前时间" />
		</div>
		<div style="width: 500px">
			耗时：<input id="timeCosted" name="timeCosted"
				value="${timelog.timeCosted}" readonly />分钟
		</div>
		<div style="width: 500px">
			内容：
			<textarea id="content" name="content">${timelog.content}</textarea>
		</div>
		<div style="width: 500px; text-align: center;">
			<button type="submit">保存</button>
		</div>
	</form>
	<c:forEach var="datamap" items="${list}">
		<div>${datamap.id},${datamap.content} ,${datamap.starttime}
			,${datamap.endtime} ,${datamap.timecosted} ,${datamap.createtime}</div>
	</c:forEach>

</body>
</html>
