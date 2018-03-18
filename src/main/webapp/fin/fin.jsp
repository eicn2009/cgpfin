<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>fin</title>
<link href="/common/css/bootstrap.css" rel="stylesheet">

<script src="/common/js/jquery-3.2.1.js"></script>
<script src="/common/js/jquery-3.2.1.js"></script>
<script src="/common/js/jquery-migrate-3.0.0.js"></script>
<script src="/common/js/datetime.js"></script>
<script src="/common/js/bootstrap.js"></script>
<script src="/common/js/vue.js"></script>

<script type="text/javascript">
$(function(){
	var finIndexHome = new Vue({
		  el: '#finIndexHome',
		  data: {
		    date: (new Date()).pattern("yyyy-MM-dd"),
		    time: (new Date()).pattern("HH:mm:ss"),
		    returnStr:'',
		    accountTypeList:null,
		    userList:null,
		    orgList:null,
		    accountList:null,
		    acBalanceSum:0,
		    log:"this is log!",
		    searchForm:{
		    	acCanused:1,
		    	orgId:-1,
		    	actypeId:-1,
		    	acName:null,
		    	userId:-1
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
	
	
// 	获取机构列表
	jQuery.cgp.fin.getOrgList = function(){
		$.ajax({
			type:"get",
			url:"/fin/orglist",
			dataType: "json",
			success:function(data){
				finIndexHome.orgList = data;
			}
		});
	};
// 	获取用户列表
	jQuery.cgp.fin.getUserList = function(){
		$.ajax({
			type:"get",
			url:"/fin/userlist",
			dataType: "json",
			success:function(data){
				finIndexHome.userList = data;
			}
		});
	};
// 	获取账户类型列表
	jQuery.cgp.fin.getAccountTypeList = function(){
		$.ajax({
			type:"get",
			url:"/fin/accounttypelist",
			dataType: "json",
			success:function(data){
				finIndexHome.accountTypeList = data;
			}
		});
	};
	

	jQuery.cgp.fin.searchAccountList = function(){
		finIndexHome.time = (new Date()).pattern("HH:mm:ss");
		
		$.ajax({
			type:"post",
			url:"/fin/accountlist",
			data: JSON.stringify(finIndexHome.searchForm),
			dataType: "json",
			contentType:"application/json;charset=utf-8",
			success:function(data){
				console.log(data);
				finIndexHome.accountList = data.accountList;
				finIndexHome.acBalanceSum = data.acBalanceSum;
			}
		});
	};

	jQuery.cgp.fin.getOrgList();
	jQuery.cgp.fin.getUserList();
	jQuery.cgp.fin.getAccountTypeList();
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
<div  id="finIndexHome">
<!-- 页头导航开始 -->
		<nav class="navbar navbar-default" role="navigation">
			<div class="container-fluid">
				<div class="navbar-header">
					<a class="navbar-brand" href="#">账户管理系统</a>
				</div>
				<div>
					<ul class="nav navbar-nav">
						<li class="active"><a href="/fin">账户列表</a></li>
						<li><a href="/fin/accountinout">收支明细</a></li>
						<li><a href="/fin/accounttransfer">转账明细</a></li>
						<li><a href="/fin/fintradeaccount">理财交易管理</a></li>
					</ul>
				</div>
			</div>
			<div class="navdiv">
				<div>今天:{{ date }} 现在时间:{{time}}</div>
			</div>
		</nav>
		<!-- 页头导航结束 -->

	
<!-- 	正文开始 -->
	<div class="table-responsive">
		<table class="table table-hover table-striped table-bordered ">
			<tbody>
				<tr>
					<td colspan="1">资金是否可用： 
						<input type="radio" value="1" v-model="searchForm.acCanused" id="acCanused1"/>  <label for="acCanused1">可用</label>
						<input type="radio" value="0" v-model="searchForm.acCanused" id="acCanused0"/>  <label for="acCanused0">不可用</label>
						<input type="radio" value="-1" v-model="searchForm.acCanused" id="acCanused-1"/>  <label for="acCanused-1">不限</label>
					</td>
					<td colspan="1">用户： 
						<select v-model="searchForm.userId" >
							<option value="-1">不限</option>
							<option  v-for="option in userList" :value="option.userId">{{option.userName}}</option>
						</select>
					</td>
					<td colspan="1">账户类别： 
						<select v-model="searchForm.actypeId">
							<option value="-1">不限</option>
							<option  v-for="option in accountTypeList" :value="option.actypeId">{{option.actypeName}}</option>
						</select>
					</td>
					<td colspan="1">归属机构： 
						<select v-model="searchForm.orgId">
							<option value="-1">不限</option>
							<option  v-for="option in orgList" :value="option.orgId">{{option.orgName}}</option>
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
			<thead>
				<tr>
					<th >id</th>
					<th >账户名</th>
					<th >归属金融机构（银行）id</th>
					<th >余额(总和：{{acBalanceSum}})</th>
					<th >账户归属用户id</th>
					<th >资金是否可用</th>
					<th >账户类别</th>
					<th >记录时间</th>
				</tr>
			</thead>	
			<tbody>
				<tr v-for="account in accountList">
					<td >{{ account.acId }}</td>
					<td >{{ account.acName }}</td>
					<td >{{ account.orgName }}</td>
					<td >{{ account.acBalance }}</td>
					<td >{{ account.userName }}</td>
					<td >{{ account.acCanused==1?'是':'否' }}</td>
					<td >{{ account.actypeName }}</td>
					<td >{{ account.acUpdateTime }}</td>
				</tr>
			</tbody>
		</table>
	</div>
<!-- 	正文结束 -->
</div>
</body>
</html>