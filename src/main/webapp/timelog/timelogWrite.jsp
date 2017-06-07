<%@ page language="java" contentType="text/html;charset=UTF-8"
	language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">

<link href="/common/css/bootstrap.css" rel="stylesheet">

<script src="/common/js/jquery-3.2.1.js"></script>
<script src="/common/js/jquery-migrate-3.0.0.js"></script>
<script src="/common/js/datetime.js"></script>
<script src="/common/js/bootstrap.js"></script>



<script type="text/javascript">
	$(function() {

		console.log("timelog start");

		// 计算耗时
		var setTimeCosted = function() {
			var defaultDate = $("#defaultDate").val();
			var startTimeStr = $("#startTime").val();
			var endTimeStr = $("#endTime").val();
			var startTime = new Date(startTimeStr);
			var endTime = new Date(endTimeStr);
			var timeCosted = Math.round((endTime.getTime() - startTime.getTime())/1000/60);
			$("#timeCosted").val(timeCosted);
		}
		// 获取当前时间设置开始时间后重新计算耗时
		$("#getStartTime").click(function() {
			$("#startTime").val((new Date()).pattern("yyyy-MM-dd HH:mm:ss"));
			setTimeCosted();
		});
		// 获取当前时间设置结束时间后重新计算耗时
		$("#getEndTime").click(function() {
			$("#endTime").val((new Date()).pattern("yyyy-MM-dd HH:mm:ss"));
			setTimeCosted();
		});
		// 手动设置开始时间后重新计算耗时
		$("#startTime").keyup(function() {
			setTimeCosted();
		});
		// 手动设置结束时间后重新计算耗时
		$("#endTime").keyup(function() {
			setTimeCosted();
		});
		// 修改默认日期后，同步修改开始时间和结束时间，并计算耗时
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
	<div class="container">
		<!-- 		增加timelog记录 开始-->
		<div class="table-responsive">
			<table class="table table-striped table-bordered ">
				<form action="/timelog/add" method="post">
					<caption>timelog</caption>
					<tbody>
						<tr>
							<td colspan="5">设置当前默认日期：<input id="defaultDate"
								name="defaultDate" value="${timelog.defaultDate}" />
							</td>

						</tr>
						<tr>
							<td>开始时间：<input id="startTime" name="startTime"
								value="${timelog.startTime}" /><br /> <input type="button"
								id="getStartTime" value="使用当前时间" />
							</td>
							<td>结束时间：<input id="endTime" name="endTime"
								value="${timelog.endTime}" /><br /> <input type="button"
								id="getEndTime" value="使用当前时间" />
							</td>
							<td>耗时：<input id="timeCosted" name="timeCosted"
								value="${timelog.timeCosted}" readonly />分钟
							</td>
							<td>内容： <textarea id="content" name="content">${timelog.content}</textarea>
						</tr>
						<tr>
							<td colspan="5">
								<button type="submit">保存</button>

							</td>
						</tr>
					</tbody>
				</form>
			</table>
		</div>
		<!-- 		增加timelog记录 结束-->

		<!-- 		展示默认时间当天的timelog历史记录 开始-->
		<div class="table-responsive">
			<table class="table table-hover table-striped table-bordered ">
				<tbody>
					<c:forEach var="datamap" items="${list}">
						<tr>
							<td>${datamap.id}</td>
							<td>${datamap.starttime}</td>
							<td>${datamap.endtime}</td>
							<td>${datamap.timecosted}</td>
							<td>${datamap.content}</td>
							<td>${datamap.createtime}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<!-- 		展示默认时间当天的timelog历史记录 结束-->
	</div>
</body>
</html>
