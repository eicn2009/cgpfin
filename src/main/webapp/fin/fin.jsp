<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>fin</title>
<link href="/common/css/bootstrap.css" rel="stylesheet">

<script src="/common/js/jquery-3.2.1.js"></script>
<script src="/common/js/jquery-migrate-3.0.0.js"></script>
<script src="/common/js/datetime.js"></script>
<script src="/common/js/bootstrap.js"></script>
<script src="/common/js/vue.js"></script>

<script type="text/javascript">
$(function(){
	var finindexhome = new Vue({
		  el: '#finindexhome',
		  data: {
		    date: (new Date()).pattern("yyyy-MM-dd"),
		    time: (new Date()).pattern("HH:mm:ss"),
		    returnstr:'',
		    accounttypelist:null,
		    userlist:null,
		    orglist:null,
		    accountlist:null,
		    balancesum:0,
		    log:"this is log!",
		    searchform:{
		    	canused:1,
		    	orgid:-1,
		    	type:-1,
		    	accountname:null,
		    	userid:-1
		    }
		  },
		  methods: {
			    methodtest: function () {
			      console.log("this is method test!!!")
			    }
			  }
		});
	if(typeof jQuery.cgp == "undefined"){jQuery.cgp = {};};
	if(typeof jQuery.cgp.fin == "undefined"){jQuery.cgp.fin = {};};
	
	jQuery.cgp.fin.teststr = function(id){
		console.log("finindexhome.welcomemessage:"+finindexhome.welcomemessage);
		finindexhome.time = (new Date()).pattern("HH:mm:ss");
		
		$.ajax({
			type:"post",
			url:"/fin/teststr",
			data: {"id":id},
			dataType: "text",
			success:function(data){
				console.log(data);
				finindexhome.returnstr = data;
			}
		});
	}
	
	jQuery.cgp.fin.testjson = function(id){
		console.log("finindexhome.welcomemessage:"+finindexhome.welcomemessage);
		finindexhome.time = (new Date()).pattern("HH:mm:ss");
		
		$.ajax({
			type:"post",
			url:"/fin/testjson",
			data: {"id":id},
			dataType: "json",
			success:function(data){
				console.log(data);
				finindexhome.returnstr = data.id;
				
			}
		});
	};
// 	获取机构列表
	jQuery.cgp.fin.getOrglist = function(){
		$.ajax({
			type:"get",
			url:"/fin/orglist",
			dataType: "json",
			success:function(data){
				console.log(data);
				finindexhome.orglist = data;
			}
		});
	};
// 	获取用户列表
	jQuery.cgp.fin.getUserlist = function(){
		$.ajax({
			type:"get",
			url:"/fin/userlist",
			dataType: "json",
			success:function(data){
				console.log(data);
				finindexhome.userlist = data;
			}
		});
	};
// 	获取账户类型列表
	jQuery.cgp.fin.getAccounttypelist = function(){
		$.ajax({
			type:"get",
			url:"/fin/accounttypelist",
			dataType: "json",
			success:function(data){
				console.log(data);
				finindexhome.accounttypelist = data;
			}
		});
	};
	
// 	获取账户列表
	jQuery.cgp.fin.getAccountList = function(){
		console.log("finindexhome.welcomemessage:"+finindexhome.welcomemessage);
		finindexhome.time = (new Date()).pattern("HH:mm:ss");
		
		$.ajax({
			type:"post",
			url:"/fin/accountlist",
			data: null,
			dataType: "json",
			success:function(data){
				console.log(data);
				finindexhome.accountlist = data.list;
				finindexhome.balancesum = data.balancesum;
			}
		});
	};
	jQuery.cgp.fin.searchAccountList = function(){
		console.log("finindexhome.welcomemessage:"+finindexhome.welcomemessage);
		finindexhome.time = (new Date()).pattern("HH:mm:ss");
		
		$.ajax({
			type:"post",
			url:"/fin/accountlist",
			data: JSON.stringify(finindexhome.searchform),
			dataType: "json",
			contentType:"application/json;charset=utf-8",
			success:function(data){
				console.log(data);
				finindexhome.accountlist = data.list;
				finindexhome.balancesum = data.balancesum;
			}
		});
	};
	
	jQuery.cgp.fin.getOrglist();
	jQuery.cgp.fin.getUserlist();
	jQuery.cgp.fin.getAccounttypelist();
	jQuery.cgp.fin.searchAccountList();
}
)

</script>
<style>
.navdiv {
	background-color: #EEE;
	height: 20px;
	line-height: 20px;
	margin-top: 20px;
}

.navdiv div {
	float: left;
	font-size: 13px;
	color: black;
	margin-left: 50px;
}
</style>
</head>
<body>
<div  id="finindexhome">
<!-- 页头导航开始 -->
	<div  class="navdiv" >
		<div>今天:{{ date }} 现在时间:{{time}}</div>
		<div onclick="window.location='/fin'">账户首页</div>
		<div onclick="alert('it is building....')">账户收支页</div>
	</div>
<!-- 页头导航结束 -->

	
<!-- 	正文开始 -->
	<div class="table-responsive">
		<table class="table table-hover table-striped table-bordered ">
			<tbody>
				<tr>
					<td colspan="5">返回值： {{returnstr}}
					</td>
				</tr>
				<tr>
					<td colspan="1">资金是否可用： 
						<input type="radio" value="1" v-model="searchform.canused" id="canused1"/>  <label for="canused1">可用</label>
						<input type="radio" value="0" v-model="searchform.canused" id="canused0"/>  <label for="canused0">不可用</label>
						<input type="radio" value="-1" v-model="searchform.canused" id="canused-1"/>  <label for="canused-1">不限</label>
					</td>
					<td colspan="1">用户： 
						<select v-model="searchform.userid" >
							<option value="-1">不限</option>
							<option  v-for="option in userlist" :value="option.id">{{option.name}}</option>
						</select>
					</td>
					<td colspan="1">账户类别： 
						<select v-model="searchform.type">
							<option value="-1">不限</option>
							<option  v-for="option in accounttypelist" :value="option.id">{{option.name}}</option>
						</select>
					</td>
					<td colspan="1">归属机构： 
						<select v-model="searchform.orgid">
							<option value="-1">不限</option>
							<option  v-for="option in orglist" :value="option.id">{{option.name}}</option>
						</select>
					</td>
				</tr>
				<tr>
					<td colspan="2"><input type="button" id="searchList" 
						value="查询" onclick="jQuery.cgp.fin.searchAccountList()">
					</td>

				</tr>
		</table>
		<table class="table table-hover table-striped table-bordered ">
			<tbody>
				<tr>
<!-- 				账户名、归属金融机构（银行）id、余额、初始余额、 记录时间、开户时间、是否有效标识、账户归属用户id、账户类别(现金，银行理财，活期，定期等），资金是否可用 -->
					<td >id</td>
					<td >账户名</td>
					<td >归属金融机构（银行）id</td>
					<td >余额(总和：{{balancesum}})</td>
					<td >账户归属用户id</td>
					<td >资金是否可用</td>
					<td >账户类别</td>
					<td >记录时间</td>
					
				</tr>
				

				<tr v-for="account in accountlist">
					<td >{{ account.id }}</td>
					<td >{{ account.name }}</td>
					<td >{{ account.orgname }}</td>
					<td >{{ account.balance }}</td>
					<td >{{ account.username }}</td>
					<td >{{ account.canused }}</td>
					<td >{{ account.typename }}</td>
					<td >{{ account.updatetime }}</td>
				</tr>
		</table>
	</div>
<!-- 	正文结束 -->
</div>
</body>
</html>