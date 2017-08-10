<%@ page language="java" contentType="text/html;charset=UTF-8"
	language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<title>todoItem.jsp</title>
<link href="/common/css/bootstrap.css" rel="stylesheet">

<script src="/common/js/jquery-3.2.1.js"></script>
<script src="/common/js/jquery-migrate-3.0.0.js"></script>
<script src="/common/js/datetime.js"></script>
<script src="/common/js/bootstrap.js"></script>



<script type="text/javascript">
	$(function() {

		console.log("todoItem start");

		// 计算耗时
		var setTimeCosted = function() {
			var defaultDate = $("#defaultDate").val();
			var startTimeStr = $("#startTime").val();
			var endTimeStr = $("#endTime").val();
			var startTime = datetimefromStr(startTimeStr);
			var endTime = datetimefromStr(endTimeStr);
// 			输入日期不合法退出
			if(startTime==null||endTime==null){
				console.log("输入日期不合法退出！！");
				return;
			}
			
			var timeCosted = Math.round((endTime.getTime() - startTime.getTime()) /1000 /60/60);
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
// 			输入日期不合法退出
			if(!checkDateStr(defaultDate)){
				console.log("输入日期不合法退出！！");
				return;
			}
			
			
			var startTimeStr = $("#startTime").val();
			var endTimeStr = $("#endTime").val();
			var startTime = datetimefromStr(startTimeStr);
			var endTime = datetimefromStr(endTimeStr);

			$("#startTime").val(defaultDate + " " + startTime.pattern("HH:mm:ss"));
			$("#endTime").val(defaultDate + " " + endTime.pattern("HH:mm:ss"));
			setTimeCosted();
		});
		
// 		进入页面后初始化计算耗时
		setTimeCosted();
		
		if(typeof jQuery.todoItem == "undefined"){jQuery.todoItem = {};};
// 		点击编辑操作
		jQuery.todoItem.editTodoItem = function(id,startTime,endTime,timeCosted,content,remark,type,status,istoday){
			$("input[name='id']").val(id);
			$("input[name='startTime']").val(startTime);
			$("input[name='endTime']").val(endTime);
			$("input[name='timeCosted']").val(timeCosted);
			$("#content").val(content);
			$("textarea[name='remark']").val(remark);
			var date = datetimefromStr(startTime);
			$("#defaultDate").val(date.pattern("yyyy-MM-dd"));
			setTimeCosted();
			$("#type").val(type);
			$("#status").val(status);
			if(istoday=="1"){
				$("#istoday").attr("checked",true);
			}else{
// 				$("#istoday").removeAttr("checked");
				$("#istoday").attr("checked",false);
			}
			$('html, body').animate({scrollTop:200}, 'slow'); 
		}
// 		点击删除操作
		jQuery.todoItem.deleteTodoItem = function(id){
			console.log("deletetodoItem");
			if(!confirm("确定要删除该日志吗?")){
				return;
			}
			$.ajax({
				type:"post",
				url:"/todoItem/delete",
				data: {"id":id},
				dataType: "text",
				success:function(data){
					if(data == "success"){
						window.location.reload();
					}else{
						alert("删除出错！");
					}
				}
			});
		}
		
		jQuery.todoItem.searchList = function(){
// 			$("#searchform").attr("action","/todoItem/search")
			$("#searchform").submit();
		}
		jQuery.todoItem.save = function(){
// 			$("#searchform").attr("action","/todoItem/search")
			var content = $("#content").val();
			if(content==""){
				alert("输入内容不能为空");
				return false;
			}
			$("#editform").submit();
		}
		
		
// 		$("#defaultDate").on('input',function(e){  
// 			console.log('Changed!')  
// 			});  
		
	});
	
	
</script>
</head>

<body>
	<div class="container">
	
	<!-- 		查询 开始 -->
		<div class="table-responsive">
					<table class="table table-hover table-striped table-bordered ">
						<form id="searchform" action="/todoItem/search" method="post">
						<tbody>
						<tr>
							<td colspan="1">当前日期：
							<input id="defaultDateSearch" name="defaultDate" value="${todoItemSearch.defaultDate}">
							</td>
							<td colspan="1">类型：
									<select id="typeSearch" name="type" value="${todoItemSearch.type}">
										<c:forEach var="map" items="${todoItem.typeList}">
											<option value="${map.keyid}" ${todoItemSearch.type==map.keyid?'selected':''}  >${map.content}</option>
										</c:forEach>
									</select>
							</td>
							
							<td  colspan="1">
							<input id="istodaySearch" name="istoday" type="radio" value="-1" ${todoItemSearch.istoday=="-1"?"checked='checked'":"" }>不限
							<input id="istodaySearch" name="istoday" type="radio" value="0" ${todoItemSearch.istoday=="0"?"checked='checked'":"" }>非今日事项
							<input id="istodaySearch" name="istoday" type="radio" value="1" ${todoItemSearch.istoday=="1"?"checked='checked'":"" }>今日事项
							<input id="istodaySearch" name="istoday" type="radio" value="2" ${todoItemSearch.istoday=="2"?"checked='checked'":"" }>日常事项
							<input id="istodaySearch" name="istoday" type="radio" value="3" ${todoItemSearch.istoday=="3"?"checked='checked'":"" }>非日常事项
							</td>
							
						</tr>
						<tr>
							<td colspan="5">
								内容：<input id="contentSearch" name="content" class="form-control" value="${todoItemSearch.content}" />
							</td>
							
						</tr>
						<tr>
							<td colspan="5">状态:
									
										<c:forEach var="map" items="${todoItem.statusList}">
											<input type="checkbox" id="statusSearch${map.keyid}" name="statusChecked" value="${map.keyid}"  ${fn:containsIgnoreCase(todoItemSearch.statusChecked,map.keyid)?"checked='checked'":""}>${map.content}
										</c:forEach>
							</td>
						</tr>
						<tr>
							<td colspan="5">
								<input type="button" id="searchList" value="查询" onclick="jQuery.todoItem.searchList()">
							</td>

						</tr>
						</form>
					</table>
		</div>				
<!-- 		查询 结束 -->

	
	
		<!-- 		增加todoItem记录 开始-->
		<div class="table-responsive">
			<table class="table table-hover table-striped table-bordered ">
				<form id="editform" action="/todoItem/add" method="post">
				<input type="hidden" name="id" id="id" value="${todoItem.id}">
					<caption>todoItem</caption>
					<tbody>
						<tr>
							<td colspan="3">设置当前默认日期：<input id="defaultDate"
								name="defaultDate" value="${todoItem.defaultDate}">
							</td>
						</tr>
						<tr>
							<td>开始时间：<input id="startTime" name="startTime"
								value="${todoItem.startTime}" /> <input type="button"
								id="getStartTime" value="使用当前时间">
							</td>
							<td>结束时间：<input id="endTime" name="endTime"
								value="${todoItem.endTime}" /> <input type="button"
								id="getEndTime" value="使用当前时间">
							</td>
							<td>耗时：<input id="timeCosted" name="timeCosted" 
								value="${todoItem.timeCosted}" readonly>小时
							</td>
						</tr>
						<tr>
							<td  >
								<div class="row">
									<div class="col-xs-2">内容:</div>
									<div class="col-xs-10">
										<input id="content" name="content" class="form-control" value="${todoItem.content}" />
									</div>
									
								</div>
							</td>
							
							<td colspan="2">
							<div class="col-xs-3">类型:
									<select id="type" name="type" value="${todoItem.type}">
									<c:forEach var="map" items="${todoItem.typeList}">
										<option value="${map.keyid}" ${todoItem.type==map.keyid?'selected':''}  >${map.content}</option>
									</c:forEach>
										
									</select>
							</div>
							<div class="col-xs-4">状态:
									<select id="status" name="status" value="${todoItem.status}">
										<c:forEach var="map" items="${todoItem.statusList}">
											<option value="${map.keyid}" ${todoItem.status==map.keyid?'selected':''}  >${map.content}</option>
										</c:forEach>
									</select>
							</div>	
							<div class="col-xs-5">
									<input id="istoday0" name="istoday" type="radio" value="0" ${todoItem.istoday=="0"?"checked='checked'":"" }>非今日事项
									<input id="istoday0" name="istoday" type="radio" value="1" ${todoItem.istoday=="1"?"checked='checked'":"" }>今日事项
									<input id="istoday0" name="istoday" type="radio" value="2" ${todoItem.istoday=="2"?"checked='checked'":"" }>日常事项
							</div>	
							</td>
							
						</tr>
						<tr>
							<td colspan="3">
								<div class="row">
									<div class="col-xs-1">详细描述:</div>
									<div class="col-xs-8">
										<textarea id="remark" name="remark" cols="90" rows="7">${todoItem.remark}</textarea>
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="4">
								<input type="button" id="searchList" value="保存" onclick="jQuery.todoItem.save()">
							</td>
						</tr>
						
					</tbody>
				</form>
			</table>
		</div>
		<!-- 		增加todoItem记录 结束-->



		<!-- 		展示默认时间当天的todoItem历史记录 开始-->
		<div class="table-responsive">
			<table class="table table-hover table-striped table-bordered ">
			<thead>
			<tr>
							<th style="width: 5%">id</th>
							<th style="width: 14%">结束时间<br>开始时间</th>
							<th style="width: 5%">是否今日事项</th>
							<th style="width: 5%">事项类型</th>
							<th style="width: 10%">事项进度</th>
							<th style="width: 5%">耗时(小时)</th>
							<th style="width: 15%">内容</th>
							<th style="width: 20%">描述</th>
							<th style="width: 14%">创建时间</th>
							<th style="width: 13%">操作</th>
						</tr>
			</thead>
				<tbody>
					<c:forEach var="datamap" items="${list}">
						<tr>
							<td style="width: 5%">${datamap.id}</td>
							<td style="width: 14%">${datamap.endtime}<br>${datamap.starttime}</td>
							<td style="width: 5%">${datamap.istoday=="1"?'今天':'否' }</td>
							<td style="width: 5%">${datamap.strtype}</td>
							<td style="width: 10%">${datamap.strstatus}</td>
							<td style="width: 5%">${datamap.timecosted}</td>
							<td style="width: 15%">${datamap.content}</td>
							<td style="width: 20%" id="tdremark${datamap.id}">${datamap.remark}</td>
							<td style="width: 14%">${datamap.createtime}</td>
							<td style="width: 13%"><button type="button"
									id="editTodoItem" onclick="var tdremark = $('#tdremark${datamap.id}').html();jQuery.todoItem.editTodoItem('${datamap.id}','${datamap.starttime}','${datamap.endtime}','${datamap.timecosted}','${datamap.content}',tdremark,'${datamap.type}','${datamap.status}','${datamap.istoday}')">编辑</button>
								<button type="button" id="deleteTodoItem"
									onclick="jQuery.todoItem.deleteTodoItem('${datamap.id}')">删除</button></td>
						</tr>
						
					</c:forEach>
				</tbody>
			</table>
		</div>
		<!-- 		展示默认时间当天的todoItem历史记录 结束-->
	</div>
</body>
</html>
