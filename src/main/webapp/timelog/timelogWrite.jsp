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
			var startTime = datetimefromStr(startTimeStr);
			var endTime = datetimefromStr(endTimeStr);
// 			输入日期不合法退出
			if(startTime==null||endTime==null){
				console.log("输入日期不合法退出！！");
				return;
			}
			var timeCosted = Math.round((endTime.getTime() - startTime.getTime()) / 1000/60);
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

		$("#todoItemContent").keyup(function() {
			var todoItemContent = $("#todoItemContent").val(); 
			
			var ulcontent = $("#ulcontent"); 
			$.ajax({
				type:"get",
				url:"/todoItem/getTodoItemListContent",
				data: {"content":todoItemContent},
				dataType: "json",
				success:function(data){
					var innerhtml = "<li id='selectcancel' onclick='selectcancel()'>取消</li>";
// 						"<li id='selectliId12' onclick='selectli(selectli12)'>内容1</li>"
					for(valitem in data){
						innerhtml += "<li id='selectliId"+data[valitem].id;
						innerhtml += "' onclick='selectli(" + data[valitem].id;
						innerhtml += ")'>" + data[valitem].content ;
						innerhtml += "</li>";
					}
					if(data.length>0){
						ulcontent.html(innerhtml);
						$("#todoItemList").css("display","block");
					}else{
						$("#todoItemList").css("display","none");
					}
					
				}
			});
			
		});
		
		
// 		进入页面后初始化计算耗时
		setTimeCosted();
		
		if(typeof jQuery.timelog == "undefined"){jQuery.timelog = {};};
// 		点击编辑操作
		jQuery.timelog.editTimelog = function(id,startTime,endTime,timeCosted,content,todoItemId,todoItemContent){
			$("#todoItemId").val(todoItemId); 
			$("#todoItemContent").val(todoItemContent); 
			$("input[name='id']").val(id);
			$("input[name='startTime']").val(startTime);
			$("input[name='endTime']").val(endTime);
			$("input[name='timeCosted']").val(timeCosted);
			$("textarea[name='content']").val(content);
			var date = new Date(startTime);
			$("#defaultDate").val(date.pattern("yyyy-MM-dd"));
			
			setTimeCosted();
			
			$('html, body').animate({scrollTop:0}, 'slow'); 
		}
// 		点击删除操作
		jQuery.timelog.deleteTimelog = function(id){
			console.log("deleteTimelog");
			if(!confirm("确定要删除该日志吗?")){
				return;
			}

			$.ajax({
				type:"post",
				url:"/timelog/delete",
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
		jQuery.timelog.searchList = function(){
// 			$("#searchform").attr("action","/todoItem/search")
			$("#searchform").submit();
		}
// 		$("#defaultDate").on('input',function(e){  
// 			console.log('Changed!')  
// 			});  
		
	});

	function selectcancel(){
		$("#todoItemId").val(0); 
		$("#todoItemContent").val("");
		$("#todoItemList").css("display","none");
	}
	
	function selectli(id){
		$("#todoItemId").val(id); 
		$("#todoItemContent").val($("#selectliId"+id).text());
		$("#todoItemList").css("display","none");
	}
</script>
</head>

<body>
	<div class="container">
	
		<!-- 		查询 开始 -->
		<div class="table-responsive">
					<table class="table table-hover table-striped table-bordered ">
						<form id="searchform" action="/timelog/search" method="post">
						<tbody>
						<tr>
							<td colspan="5">当前日期：
							<input id="defaultDateSearch" name="defaultDate" value="${timelogSearch.defaultDate}">
							</td>
						</tr>
						<tr>
							<td colspan="5">
								<input type="button" id="searchList" value="查询" onclick="jQuery.timelog.searchList()">
							</td>

						</tr>
						</form>
					</table>
		</div>				
<!-- 		查询 结束 -->
		
	
		<!-- 		增加timelog记录 开始-->
		<div class="table-responsive">
		<form action="/timelog/add" method="post">
				<input type="hidden" name="id" id="id" value="${timelog.id}">
			<table class="table table-striped table-bordered ">
				
<%-- 					<caption>timelog</caption> --%>
					<tbody>
						<tr>
							<td colspan="1">设置当前默认日期：<input id="defaultDate"
								name="defaultDate" value="${timelog.defaultDate}">
							</td>
							<td colspan="4">
									<div style="display:inline;vertical-align: top;">对应事项：</div>
									<div style="display:inline-block;">
										<div style="width:300px">
											<input id="todoItemId" type="hidden" name="todoItemId" value="${timelog.todoItemId}">
											<input style="width:300px" id="todoItemContent" name="todoItemContent" 	value="${timelog.todoItemContent}" autocomplete="off">
										</div>
										<div style="position:relative;z-index:1">
											<div id="todoItemList" style="display:none;border: 1px solid;position: absolute;width:300px;background-color: white">
												<ul style="list-style-type: none;" id="ulcontent" >
												</ul>
											</div>
										</div>
									</div>
							</td>
						</tr>
						<tr>
							<td>开始时间：<input id="startTime" name="startTime"
								value="${timelog.startTime}" /> <input type="button"
								id="getStartTime" value="使用当前时间">
							</td>
							<td>结束时间：<input id="endTime" name="endTime"
								value="${timelog.endTime}" /><input type="button"
								id="getEndTime" value="使用当前时间">
							</td>
							<td>耗时：<input id="timeCosted" name="timeCosted"
								value="${timelog.timeCosted}" readonly>分钟
							</td>
						</tr>
						<tr>
							<td colspan="5">
								<div class="row" style="position: relative;margin:0">
									<div class="col-xs-1">内容:</div>
									<div class="col-xs-8">
										<textarea id="content" name="content" cols="90" rows="7">${timelog.content}</textarea>
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="5">
								<button type="submit">保存</button>

							</td>
						</tr>
					</tbody>
			</table>
			</form>
		</div>
		<!-- 		增加timelog记录 结束-->

		<!-- 		展示默认时间当天的timelog历史记录 开始-->
		<div class="table-responsive">
			<table class="table table-hover table-striped table-bordered ">
			<thead>
			<tr>
							<th style="width: 5%">id-todoid</th>
							<th style="width: 15%">开始时间</th>
							<th style="width: 15%">结束时间</th>
							<th style="width: 5%">耗时(分钟)</th>
							<th style="width: 35%">内容</th>
							<th style="width: 15%">创建时间</th>
							<th style="width: 10%">操作</th>
						</tr>
			</thead>
				<tbody>
					<c:forEach var="datamap" items="${list}">
						<tr>
							<td style="width: 5%">${datamap.id}-${datamap.todoItemId}</td>
							<td style="width: 15%">${datamap.starttime}</td>
							<td style="width: 15%">${datamap.endtime}</td>
							<td style="width: 5%">${datamap.timecosted}</td>
							<td style="width: 35%">${datamap.content}<span style="color:gray;font-size: 0.8em;">---(${datamap.todoItemContent})</span></td>
							<td style="width: 15%">${datamap.createtime}</td>
							<td style="width: 10%"><button type="button"
									id="editTimelog" onclick="jQuery.timelog.editTimelog('${datamap.id}','${datamap.starttime}','${datamap.endtime}','${datamap.timecosted}','${datamap.content}','${datamap.todoItemId}','${datamap.todoItemContent}')">编辑</button>
								<button type="button" id="deleteTimelog"
									onclick="jQuery.timelog.deleteTimelog('${datamap.id}')">删除</button></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<!-- 		展示默认时间当天的timelog历史记录 结束-->
	</div>
</body>
</html>
