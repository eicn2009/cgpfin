<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>fintradeaccount</title>
<link href="/common/css/bootstrap.css" rel="stylesheet">

<script src="/common/js/jquery-3.2.1.js"></script>
<script src="/common/js/jquery-migrate-3.0.0.js"></script>
<script src="/common/js/datetime.js"></script>
<script src="/common/js/cgputils.js"></script>
<script src="/common/js/bootstrap.js"></script>
<script src="/common/js/vue.js"></script>

<script type="text/javascript">
function getTradeAccount(){
	return {
		"tradeacId":-1,
		"tradeacName":"",
		"tradeacCode":"",
		"tradeacCount":0,
		"tradeacPriceNow":0,
		"tradeacMoneyCost":0,
		"tradeacCreateTime":"",
		"tradeacUpdateTime":"",
		"acId":0
	}
}
function getTradeAccountSearchForm(){
	return {
		"tradeacId":-1,
		"tradeacName":"",
		"tradeacCode":"",
		"tradeacCount":0,
		"tradeacPriceNow":0,
		"tradeacMoneyCost":0,
		"tradeacCreateTime":"",
		"tradeacUpdateTime":"",
		"acId":0
	}
}







$(function(){
	var finTradeAccount = new Vue({
		  el: '#finTradeAccount',
		  data: {
		    date: (new Date()).pattern("yyyy-MM-dd"),
		    time: (new Date()).pattern("HH:mm:ss"),
		    returnStr:'',
		    tradeAccountList:null,
		    tradeAccount:getTradeAccount(),
		    searchForm:getTradeAccountSearchForm()
		  },
		  methods: {
			    methodtest: function () {
			      console.log("this is method test!!!")
			    }
			  }
		});
	if(typeof jQuery.cgp == "undefined"){jQuery.cgp = {};};
	if(typeof jQuery.cgp.fin == "undefined"){jQuery.cgp.fin = {};};
	jQuery.cgp.fin.getTradeAccountList = function(){
		$.ajax({
			type:"get",
			url:"/fin/fintradeaccount/fintradeaccountlist",
			dataType: "json",
			success:function(data){
				finTradeAccount.tradeAccountList = data;
			}
		});
	}
	
	
	jQuery.cgp.fin.getTradeAccountList();
	
});

</script>

</head>
<body>
<div  id="finTradeAccount">
<!-- 页头导航开始 -->
		<nav class="navbar navbar-default" role="navigation">
			<div class="container-fluid">
				<div class="navbar-header">
					<a class="navbar-brand" href="#">账户管理系统</a>
				</div>
				<div>
					<ul class="nav navbar-nav">
						<li><a href="/fin">账户列表</a></li>
						<li><a href="/fin/accountinout">收支明细</a></li>
						<li><a href="/fin/accounttransfer">转账明细</a></li>
						<li class="active"><a href="/fin/fintradeaccount">理财交易管理</a></li>
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
					<td colspan="2"><input type="button" id="searchList" 
						value="查询" onclick="jQuery.cgp.fin.searchAccountList()">
					</td>

				</tr>
		</table>
		<table class="table table-hover table-striped table-bordered ">
			<thead>
				<tr>
					<th style="width:30px;">id</th>
					<th style="width:240px;">账户名</th>
					<th style="width:80px;">账户代码</th>
					<th style="width:160px;">当前持有数/持有市值</th>
					<th style="width:80px;">当前单价</th>
					<th style="width:160px;">持有总成本/持有成本价</th>
					<th style="width:140px;">更新时间</th>
					<th style="width:240px;">资金账户名</th>
				</tr>
			</thead>	
			<tbody>
				<tr v-for="tradeAccount in tradeAccountList">
					<td >{{ tradeAccount.tradeacId }}</td>
					<td >{{ tradeAccount.tradeacName }}</td>
					<td >{{ tradeAccount.tradeacCode }}</td>
					<td >{{ tradeAccount.tradeacCount }}/{{ tradeAccount.tradeacCount * tradeAccount.tradeacPriceNow }}</td>
					<td >{{ tradeAccount.tradeacPriceNow }}</td>
					<td >{{ tradeAccount.tradeacMoneyCost}}/{{ Math.round(tradeAccount.tradeacMoneyCost/tradeAccount.tradeacCount*100)/100 }}</td>
					<td >{{ tradeAccount.tradeacUpdateTime }}</td>
					<td >{{ tradeAccount.acId }}</td>
				</tr>
			</tbody>
		</table>
	</div>
<!-- 	正文结束 -->
</div>
</body>
</html>