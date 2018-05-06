<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<script src="/common/js/cgpfincommon.js"></script>

<script type="text/javascript">


$(function(){
	var finTradeAccount = new Vue({
		  el: '#finTradeAccount',
		  data: {
		    date: (new Date()).pattern("yyyy-MM-dd"),
		    time: (new Date()).pattern("HH:mm:ss"),
		    returnStr:'',
		    tradeAccountList:null,
		    tradeAccountListsum:0,
		    tradeAccount:getTradeAccount(),
		    searchForm:getTradeAccountSearchForm(),
		    accountList:null,
		    tradeAccountInoutList:null,
		    tradeAccountInoutShow:false,
		    tradeAccountInout:getTradeAccountInout(),
		    staticInfo:{},
		    tradeAccountMoney:null
		  },
		  watch:{
// 			  acId:function(newid){
// 				  for(item in this.accountList){
// 						if(newid == this.accountList[item].id){
// 							this.account = this.accountList[item];
// 						}
// 					}
// 			  },
// 			  this:function(newdata){
// 				  console.log(newdata);
// 			  }
		  },
		  methods: {
			    methodtest: function () {
			      console.log("this is method test!!!")
			    }
			  }
		});
	
	jQuery.cgp.fin.getTradeAccountList = function(){
		$.ajax({
			type:"get",
			url:"/fin/fintradeaccount/fintradeaccountlist",
			dataType: "json",
			success:function(data){
				finTradeAccount.tradeAccountList = data;
				finTradeAccount.staticInfo =  getStaticInfo(data);
			}
		});
	}
	
	//通过理财产品列表获取统计信息
	function getStaticInfo(list){
		//当前市值  当前资金 当前盈利   
		var staticInfo = {};
		//当前市值
		staticInfo.marketCapitalization = 0;
		//当前资金
		staticInfo.money = 0;
		//当前盈亏
		staticInfo.profit = 0;
		//总资产
		staticInfo.capitalizationSum = 0;
		
		
// 		var moneyAccount = null;
		
		for(var i = 0;i<list.length;i++){
			var tradeAccountItem = list[i];
			if(tradeAccountItem.tradeacType == 0){
				staticInfo.money = tradeAccountItem.tradeacCount;
				finTradeAccount.tradeAccountMoney = tradeAccountItem;
			}else if(tradeAccountItem.tradeacType == 1){
				staticInfo.profit += tradeAccountItem.tradeacCount * tradeAccountItem.tradeacPriceNow-tradeAccountItem.tradeacMoneyCost;
				staticInfo.marketCapitalization +=  tradeAccountItem.tradeacCount * tradeAccountItem.tradeacPriceNow;
			}
		}
		staticInfo.capitalizationSum = staticInfo.marketCapitalization + staticInfo.money;
		
		staticInfo.capitalizationSum = floatRound(staticInfo.capitalizationSum,2);
		staticInfo.money = floatRound(staticInfo.money,2);
		staticInfo.marketCapitalization = floatRound(staticInfo.marketCapitalization,2);
		staticInfo.profit = floatRound(staticInfo.profit,2);
		
		return staticInfo;
	}
	
	jQuery.cgp.fin.updateAccount = function(){
		var inputdata = {};
		inputdata.acId = finTradeAccount.tradeAccountMoney.acId;
		inputdata.acBalance = finTradeAccount.staticInfo.capitalizationSum;
		$.ajax({
			type:"post",
			url:"/fin/fintradeaccount/updateaccount",
			data: inputdata,
			dataType: "json",
// 			contentType:"application/json;charset=utf-8",
			success:function(data){
				if(data>0){
					alert("更新成功");
				}
			}
		});
	}
	
	jQuery.cgp.fin.addOrUpdateTradeAccount = function(){
		if(finTradeAccount.tradeAccount.acId<0){
			alert("请选择资金账号");
			return false;
		}
		if(!finTradeAccount.tradeAccount.tradeacName){
			alert("请输入账号");
			return false;
		}
		if(!finTradeAccount.tradeAccount.tradeacCode){
			alert("请输入账号代码");
			return false;
		}
		
		$.ajax({
			type:"post",
			url:"/fin/fintradeaccount/fintradeaccount",
			data: JSON.stringify(finTradeAccount.tradeAccount),
			dataType: "json",
			contentType:"application/json;charset=utf-8",
			success:function(data){
				if(data>0){
					finTradeAccount.tradeAccount = getTradeAccount();
					jQuery.cgp.fin.getTradeAccountList();
				}
			}
		});
	}
	
	jQuery.cgp.fin.getTradeAccount = function(tradeAcId){
		
	}
	jQuery.cgp.fin.tradeAccountInoutEdit = function(str){
		finTradeAccount.tradeAccountInout = JSON.parse(str);
	}
	jQuery.cgp.fin.tradeAccountInoutDelete = function(str){
		if(!confirm("确认删除吗？"))return false;
		var info = JSON.parse(str);
		var tradeacioId = info.tradeacioId;
		
		$.ajax({
			type:"delete",
			url:"/fin/fintradeaccountinout/fintradeaccountinout/"+tradeacioId,
			dataType: "json",
			contentType:"application/json;charset=utf-8",
			success:function(data){
				if(data>0){
					alert("删除成功!");
					_doAfterAddOrUpdateTradeAccountInout();
				}
			}
		});
	}
	
	jQuery.cgp.fin.addOrUpdateTradeAccountInout = function(){
// 		如果是股票账户交易明细保存
		if(finTradeAccount.tradeAccount.tradeacType == 1){
			if(!(finTradeAccount.tradeAccountInout.tradeacioType==1 || finTradeAccount.tradeAccountInout.tradeacioType==-1)){
				alert("请选择交易类型");
				return false;
			}
			if(!finTradeAccount.tradeAccountInout.tradeacioCount){
				alert("请输入交易数量");
				return false;
			}
			if(!finTradeAccount.tradeAccountInout.tradeacioPrice ){
				alert("请输入交易价格");
				return false;
			}
// 			if(!finTradeAccount.tradeAccountInout.tradeacioFee){
// 				alert("请输入交易费用");
// 				return false;
// 			}
// 			if(!finTradeAccount.tradeAccountInout.tradeacioTax){
// 				alert("请输入交易税费");
// 				return false;
// 			}
		}else{
			if(!finTradeAccount.tradeAccountInout.tradeacioCount){
				alert("请输入交易数量");
				return false;
			}
		}
		
		finTradeAccount.tradeAccountInout.tradeacId = finTradeAccount.tradeAccount.tradeacId;
		
		$.ajax({
			type:"post",
			url:"/fin/fintradeaccountinout/fintradeaccountinout",
			data: JSON.stringify(finTradeAccount.tradeAccountInout),
			dataType: "json",
			contentType:"application/json;charset=utf-8",
			success:function(data){
				if(data>0){
					_doAfterAddOrUpdateTradeAccountInout();
				}
			}
		});
	}
	
	function _doAfterAddOrUpdateTradeAccountInout(){
//			获取整个理财产品列表，刷新理财产品数据
		jQuery.cgp.fin.getTradeAccountList();
//			获取当前操作的理财产品，刷新理财产品信息
		jQuery.cgp.fin.getTradeAccount(finTradeAccount.tradeAccount.tradeAcId,data=>finTradeAccount.tradeAccount=data);
//			获取当前理财产品所有操作列表，刷新列表信息
		jQuery.cgp.fin.getTradeAccountInoutList(finTradeAccount.tradeAccount.tradeacId,data=>{
			finTradeAccount.tradeAccountInoutList = data;
			finTradeAccount.tradeAccountInoutShow = true;
		})
		finTradeAccount.tradeAccountInout = getTradeAccountInout();
	}
	
	jQuery.cgp.fin.tradeAccountDelete = function(str){
		if(!confirm("确认删除吗？"))return false;
		var info = JSON.parse(str);
		var tradeacId = info.tradeacId;
		
		$.ajax({
			type:"delete",
			url:"/fin/fintradeaccount/fintradeaccount/"+tradeacId,
			dataType: "json",
			contentType:"application/json;charset=utf-8",
			success:function(data){
				jQuery.cgp.fin.getTradeAccountList();
				if(data>0){
					alert("删除成功!");
					
				}
			}
		});
	}
	
	jQuery.cgp.fin.tradeAccountEdit = function(str){
		finTradeAccount.tradeAccount = JSON.parse(str);
		finTradeAccount.tradeAccountInoutList = null;
		finTradeAccount.tradeAccountInoutShow = false;
	}
	jQuery.cgp.fin.resetTradeAccount = function(str){
		finTradeAccount.tradeAccount = getTradeAccount();
		finTradeAccount.tradeAccountInoutList = null;
		finTradeAccount.tradeAccountInoutShow = false;
	}
	
	
// 	获取账户列表成功回调函数
	var getAccountListFnSuccess = function(data){
		finTradeAccount.accountList = data;
	}
	$.cgp.fin.getAccountList(getAccountListFnSuccess);
	
	
	jQuery.cgp.fin.getTradeAccountList();
	
	//打开买卖详细页面
	jQuery.cgp.fin.tradeAccountInoutInfo = function(str){
		finTradeAccount.tradeAccount = JSON.parse(str);
		finTradeAccount.tradeAccountInout = getTradeAccountInout();
		jQuery.cgp.fin.getTradeAccountInoutList(finTradeAccount.tradeAccount.tradeacId,data=>{
			finTradeAccount.tradeAccountInoutList = data;
			finTradeAccount.tradeAccountInoutShow = true;
		})
	}
	
});

</script>

</head>
<body>
	<div id="finTradeAccount">
		<!-- 页头导航开始 -->
		<nav class="navbar navbar-default" role="navigation">
			<div class="container-fluid">
				<div class="navbar-header">
					<a class="navbar-brand" href="#">账户管理系统</a>
				</div>
				<div>
					<ul class="nav navbar-nav">
						<li>
							<a href="/fin">账户列表</a>
						</li>
						<li>
							<a href="/fin/accountinout">收支明细</a>
						</li>
						<li>
							<a href="/fin/accounttransfer">转账明细</a>
						</li>
						<li class="active">
							<a href="/fin/fintradeaccount">理财交易管理</a>
						</li>
					</ul>
				</div>
			</div>
			<div class="navdiv">
				<div>今天:{{ date }} 现在时间:{{time}}</div>
			</div>
		</nav>
		<!-- 页头导航结束 -->
		<table class="table table-hover table-striped table-bordered ">
			<tr>
				<td>总资产: {{staticInfo.capitalizationSum}} <input type="button" id="updateMoney" value="更新到主账户" onclick="jQuery.cgp.fin.updateAccount()"></td>
				<td>当前市值: {{staticInfo.marketCapitalization}}</td>
				<td>当前资金: {{staticInfo.money}}</td>
				<td>盈亏: {{staticInfo.profit}}</td>
			</tr>
		</table>
		<!-- 	账户列表开始 -->
		<div class="table-responsive">
			<table class="table table-hover table-striped table-bordered ">
				<tbody>
					<tr>
						<td>
							资金账户:
							<select v-model="tradeAccount.acId">
								<option value="-1">不限</option>
								<option v-for="option in accountList" :value="option.acId">{{option.acName}}</option>
							</select>
						</td>
						<td>
							资金账户:
							<select v-model="tradeAccount.tradeacType">
								<option value="1" selected>股票</option>
								<option value="0">证券资金账号</option>
							</select>
						</td>
						<td colspan="1">
							交易账户:
							<input type="text" v-model="tradeAccount.tradeacName" />
						</td>
						<td colspan="1">
							交易账户代码:
							<input type="text" v-model="tradeAccount.tradeacCode" />
							<input type="hidden" v-model="tradeAccount.tradeacId" />
						</td>
						<td colspan="1">
							当前单价:
							<input type="text" v-model="tradeAccount.tradeacPriceNow" />
						</td>
						<td colspan="1">
							备注:
							<input type="text" v-model="tradeAccount.tradeacRemark" />
						</td>

						<td colspan="2">
							<input type="button" id="searchList" value="保存" onclick="jQuery.cgp.fin.addOrUpdateTradeAccount()">
							<input type="button" id="searchList" value="取消" onclick="jQuery.cgp.fin.resetTradeAccount()">
						</td>
					</tr>
			</table>
			<table class="table table-hover table-striped table-bordered ">
				<thead>
					<tr>
						<th style="width: 20px;">id</th>
						<th style="width: 220px;">账户名</th>
						<th style="width: 40px;">代码</th>
						<th style="width: 220px;">备注</th>
						<th style="width: 110px;">账号类型</th>
						<th style="width: 100px;">当前持有数</th>
						<th style="width: 100px;">持有市值</th>
						<th style="width: 100px;">持有总成本</th>
						<th style="width: 100px;">当前单价</th>
						<th style="width: 100px;">成本价</th>
						<th style="width: 100px;">浮盈</th>
						<th style="width: 200px;">更新时间</th>
						<th style="width: 200px;">资金账户名</th>
						<th style="width: 260px;">操作</th>
					</tr>
				</thead>
				<tbody>
					<template v-for="tradeAccountItem in tradeAccountList">
					<tr>
						<td>{{ tradeAccountItem.tradeacId }}</td>
						<td>{{ tradeAccountItem.tradeacName }}</td>
						<td>{{ tradeAccountItem.tradeacCode }}</td>
						<td>{{ tradeAccountItem.tradeacRemark }}</td>
						<td>{{ tradeAccountItem.tradeacType==0?"资金账户":"股票" }}</td>
						<td>{{ Math.round(tradeAccountItem.tradeacCount*100)/100 }}</td>
						<td>{{ tradeAccountItem.tradeacCount * tradeAccountItem.tradeacPriceNow }}</td>
						<td>{{ Math.round(tradeAccountItem.tradeacMoneyCost*100)/100}}</td>
						<td>{{ Math.round(tradeAccountItem.tradeacPriceNow*1000)/1000 }}</td>
						<td >{{Math.round(tradeAccountItem.tradeacMoneyCost/tradeAccountItem.tradeacCount*1000)/1000 }}</td>
						<td v-if="tradeAccountItem.tradeacType==1">{{Math.round((tradeAccountItem.tradeacCount * tradeAccountItem.tradeacPriceNow-tradeAccountItem.tradeacMoneyCost)*100)/100}}</td>
						<td v-if="tradeAccountItem.tradeacType==0"></td>
						<td>{{ tradeAccountItem.tradeacUpdateTime }}</td>
						<td>{{ tradeAccountItem.finAccount.acName }}</td>
						<td>
							<input type="button" :id="tradeAccountItem.tradeacId" :name="JSON.stringify(tradeAccountItem)" value="买卖详情" onclick="jQuery.cgp.fin.tradeAccountInoutInfo(this.name)"></input>
							<input type="button" :id="tradeAccountItem.tradeacId" :name="JSON.stringify(tradeAccountItem)" value="编辑" onclick="jQuery.cgp.fin.tradeAccountEdit(this.name)" />
							<input type="button" :id="tradeAccountItem.tradeacId" :name="JSON.stringify(tradeAccountItem)" value="删除" onclick="jQuery.cgp.fin.tradeAccountDelete(this.name)" />
						</td>
					</tr>
					<tr v-if="tradeAccount.tradeacId == tradeAccountItem.tradeacId && tradeAccountInoutShow">
						<td colspan="13">
							<table style="font-size: 12px;" class="table table-hover table-striped table-bordered ">
								<tr>
									<th>序号</th>
									<th>操作类型</th>
									<th>交易数量</th>
									<th v-if="tradeAccountItem.tradeacType==1">交易价格</th>
									<th v-if="tradeAccountItem.tradeacType==1">交易手续费</th>
									<th v-if="tradeAccountItem.tradeacType==1">交易税费</th>
									<th>备注</th>
									<th>操作时间</th>
									<th>操作</th>
								</tr>
								<tr>
									<td>{{tradeAccountInout.tradeacioId}}</td>
									<td>
										<select v-model="tradeAccountInout.tradeacioType">

											<option v-if="tradeAccountItem.tradeacType==0" value="1">转入证券</option>
											<option v-if="tradeAccountItem.tradeacType==0" value="-1">证券转出</option>
											<option v-if="tradeAccountItem.tradeacType==1" value="1">买入</option>
											<option v-if="tradeAccountItem.tradeacType==1" value="-1">卖出</option>

										</select>
									</td>
									<td>
										<input type="text" v-model="tradeAccountInout.tradeacioCount">
									</td>
									<td v-if="tradeAccountItem.tradeacType==1">
										<input type="text" v-model="tradeAccountInout.tradeacioPrice">
									</td>
									<td v-if="tradeAccountItem.tradeacType==1">
										<input type="text" v-model="tradeAccountInout.tradeacioFee">
									</td>
									<td v-if="tradeAccountItem.tradeacType==1">
										<input type="text" v-model="tradeAccountInout.tradeacioTax">
									</td>
									<td>
										<input type="text" v-model="tradeAccountInout.tradeacioRemark">
									</td>
									<td></td>
									<td>
										<input type="button" id="tradeAccountInoutId0" :name="JSON.stringify(tradeAccountInout)" value="保存" onclick="jQuery.cgp.fin.addOrUpdateTradeAccountInout(this.name)">
									</td>
								</tr>
								<tr v-for="tradeAccountInoutItem in tradeAccountInoutList" :style='{color:tradeAccountInoutItem.tradeacioType==-1?"green":"red"}'>
									<td>{{tradeAccountInoutItem.tradeacioId}}</td>
									<td>{{tradeAccountInoutItem.tradeacioType==-1?"出":"入"}}</td>
									<td>{{tradeAccountInoutItem.tradeacioCount}}</td>
									<td v-if="tradeAccountItem.tradeacType==1">{{tradeAccountInoutItem.tradeacioPrice}}</td>
									<td v-if="tradeAccountItem.tradeacType==1">{{tradeAccountInoutItem.tradeacioFee}}</td>
									<td v-if="tradeAccountItem.tradeacType==1">{{tradeAccountInoutItem.tradeacioTax}}</td>
									<td>{{tradeAccountInoutItem.tradeacioRemark}}</td>
									<td>{{tradeAccountInoutItem.tradeacioUpdateTime}}</td>
									<td>
										<input type="button" :id="tradeAccountItem.tradeacId" :name="JSON.stringify(tradeAccountInoutItem)" value="编辑" onclick="jQuery.cgp.fin.tradeAccountInoutEdit(this.name)" />
										<input type="button" :id="tradeAccountItem.tradeacId" :name="JSON.stringify(tradeAccountInoutItem)" value="删除" onclick="jQuery.cgp.fin.tradeAccountInoutDelete(this.name)" />
									</td>
								</tr>

							</table>
						</td>
					</tr>
					</template>
				</tbody>
			</table>
		</div>
		<!-- 	账户列表结束 -->
	</div>

	<!-- 买卖列表开始 -->
	<div style="display: none; position: fixed"></div>
	<!-- 买卖列表结束 -->
</body>
</html>