<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>fininout</title>
<link href="/common/css/bootstrap.css" rel="stylesheet">

<script src="/common/js/jquery-3.2.1.js"></script>
<script src="/common/js/jquery-migrate-3.0.0.js"></script>
<script src="/common/js/datetime.js"></script>
<script src="/common/js/cgputils.js"></script>
<script src="/common/js/bootstrap.js"></script>
<script src="/common/js/vue.js"></script>

<script type="text/javascript">


$(function(){
	if(typeof jQuery.cgp == "undefined"){jQuery.cgp = {};};
	if(typeof jQuery.cgp.fin == "undefined"){jQuery.cgp.fin = {};};
	
	
	
	
	
	jQuery.cgp.fin.initAccountInout = function(){
		return  {
				acioId:-1,
				acId:-1,
		   		aciotypeInorout:2,
		   		aciotypeId:-1,
		   		acioDesc:'',
		   		userId:-1,
		   		userName:'',
		   		acioMoney:0,
		   		acioHappenedTime:(new Date()).pattern("yyyy-MM-dd"),
		   		acioMoneyBalance:0
		};
	}
	
	jQuery.cgp.fin.initAccountInfo = function(){
		return  {
				acId:-1,
		   		acName:'',
		   		orgName:'',
		   		orgId:-1,
		   		acBalance:0.0,
		   		userName:'',
		   		userId:-1,
		   		acCanused:-1,
		   		actypeName:'',
		   		actypeId:-1,
		   		acUpdateTime:(new Date()).pattern("yyyy-MM-dd HH:mm:ss")
		};
		 
	}
	var accountInout = jQuery.cgp.fin.initAccountInout();
	var accountInfo = jQuery.cgp.fin.initAccountInfo();
	
	var finAccountInout = new Vue({
		  el: '#finAccountInout',
		  data: {
		    resultType:1,//1为明细列表结果 2为统计结果
			date: (new Date()).pattern("yyyy-MM-dd"),
		    time: (new Date()).pattern("HH:mm:ss"),
		    yearList:[2017,2018,2019,2020],
		    monthList:["01","02","03","04","05","06","07","08","09","10","11","12"],
		    accountList:null,
		    userList:null,
		    searchForm:{
		    	acId:-1,
		    	acioHappenedTime:(new Date()).pattern("yyyy-MM"),
		    	acioHappenedYear:(new Date()).pattern("yyyy"),
		    	acioHappenedMonth:(new Date()).pattern("MM"),
		    	aciotypeInorout:-1,
		    	aciotypeId:-1,
		    	acUserId:-1,
		    	acCanused:1,
		    	acioUserId:-1,
		    	acioStatisticsKeyList:[],
		    	searchType:1
		    },
		    user:{
		    	userId:-1,
		    	userName:''
		    },
		    acId:-1,
// 		    account:accountInfo,
		   	aciotypeList:null,
		   	acioList:null,
		   	acioListMoneySum:0,
		   	accountInoutForm:accountInout,
		   	acioStatisticsForm:{
		   		acId:0,//账号
		   		aciotypeInorout:0,//收入或支出
		   		aciotypeId:0,//收支细分类
		   		acioYear:0,//年
		   		acioMonth:0,//月
		   		acUserId:0,//账户归属人
		   		acioUserId:0,//经办人
		   		useOrgId:0,//归属机构
		   		actypeId:0//账户类别
		   	},
		   	acioStatisticsList:null
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
		  computed:{
			  account:function(){
				  for(item in this.accountList){
						if(this.acId == this.accountList[item].acId){
							return this.accountList[item];
						}
					}
// 				  此处若不返回，控制台会有报错信息，提示account对应的id未定义，可能与加载顺序有关
				  return accountInfo;
			  }
		  },
		  mounted:function(){
			  if(this.acioList!=null){
				  if(this.acioList[0]!=null){
					  this.acId = this.acioList[0].acId;
				  }
			  }
		  },
		  methods: {
			    methodtest: function () {
			      console.log("this is method test!!!")
			    },
			    changeBalanceToIoMoney(){
			    	this.accountInoutForm.acioMoney = Math.round((this.accountInoutForm.acioMoneyBalance -  this.account.acBalance)*100)/100;
			    	if(this.accountInoutForm.aciotypeInorout==2){//针对支出和收入的不同数字处理；
			    		this.accountInoutForm.acioMoney = -this.accountInoutForm.acioMoney;
			    	}
			    },
			    getStatisticsName:function(key){
			    	var name = "";
			    	if(key=="acId"){
			    		name = "账号";
			    	}else if(key=="aciotypeInorout"){
			    		name = "收入或支出";
			    	}else if(key=="aciotypeId"){
			    		name = "收支细分类";
			    	}else if(key=="acioHappenedTime"){
			    		name = "发生时间";
			    	}else if(key=="acUserId"){
			    		name = "账户归属人";
			    	}else if(key=="acCanused"){
			    		name = "是否可用";
			    	}else if(key=="acioUserId"){
			    		name = "经办人";
			    	}else if(key=="orgId"){
			    		name = "归属机构";
			    	}else if(key=="actypeId"){
			    		name = "账户类别";
			    	}else if(key=="sum"){
			    		name = "总和";
			    	}else{
			    		name = key;
			    	}
					return name;			    	
			    },
			    getAciotypeList:function(event){
			    	
// 			    	jQuery.cgp.fin.getAciotypeList(this.accountInoutForm.aciotypeInorout);
			    }
			  }
		});
	
	
	
// 	打开收支信息弹窗
	jQuery.cgp.fin.accountInoutAdd = function(){
		$("#popdiv").css("display","block");
		$("#cover").css("display","block");
		$("body").css("overflow","hidden");
		
	}
// 	关闭收支信息弹窗
	 jQuery.cgp.fin.accountInoutAddCancel = function(){
			finAccountInout.accountInoutForm = jQuery.cgp.fin.initAccountInout();
	    	$("#popdiv").css("display","none");
			$("#cover").css("display","none");
			$("body").css("overflow","visible");
			
	 }
	 
//	 	获取收支类型列表
		jQuery.cgp.fin.getAciotypeList = function(aciotypeInorout){
			$.ajax({
				type:"get",
				url:"/fin/accountinouttypelist/"+aciotypeInorout,
				dataType: "json",
				success:function(data){
					finAccountInout.aciotypeList = data;
				}
			});
		};

//	 	获取账户列表
		jQuery.cgp.fin.getAccountList = function(){
			this.time = (new Date()).pattern("HH:mm:ss");
			
			$.ajax({
				type:"post",
				url:"/fin/accountlist",
				data: null,
				dataType: "json",
				contentType:"application/json;charset=utf-8",
				success:function(data){
					finAccountInout.accountList = data.accountList;
// 					获取账号列表后，通过账号id刷新账号信息
// 					jQuery.cgp.fin.refreshAccount(finAccountInout.acId);
				}
			});
		};
		
// 		根据账号id同步账号其他信息
		jQuery.cgp.fin.refreshAccount = function(acId){
			for(item in finAccountInout.accountList){
				if(acId == finAccountInout.accountList[item].acId){
					finAccountInout.account = finAccountInout.accountList[item];
				}
			}
		}
// 		保存和更新收支信息 1保存 2保存并继续
		jQuery.cgp.fin.accountInoutAddSave = function(saveType){
	
			
			if(finAccountInout.acId<0){
				alert("请选择账号");
				return false;
			}
			if(finAccountInout.accountInoutForm.aciotypeId<0){
				alert("请选择收支详细类别");
				return false;
			}
			if(finAccountInout.accountInoutForm.userId<0){
				alert("请选择经办人");
				return false;
			}
			if(checknum(finAccountInout.accountInoutForm.acioMoney)){
				if(finAccountInout.accountInoutForm.acioMoney<=0){
					if(finAccountInout.accountInoutForm.aciotypeInorout==2 && finAccountInout.accountInoutForm.aciotypeId!=0){//余额调整时可能出现负值
						alert("请输入正确金额");
						return false;
					}
				}
			}else{
				alert("请输入正确金额");
				return false;
			}
			if(!checkDateStr(finAccountInout.accountInoutForm.acioHappenedTime)){
				alert("请输入正确日期！！");
				return false;
			}
			finAccountInout.accountInoutForm.acioMoney = parseFloat(finAccountInout.accountInoutForm.acioMoney);
			finAccountInout.accountInoutForm.acId = finAccountInout.acId;
			
			$.ajax({
				type:"post",
				url:"/fin/accountinout",
				data: JSON.stringify(finAccountInout.accountInoutForm),
				dataType: "json",
				contentType:"application/json;charset=utf-8",
				success:function(data){
					if(data>0){
						jQuery.cgp.fin.getAccountList();
						finAccountInout.searchForm.acioHappenedYear = finAccountInout.accountInoutForm.acioHappenedTime.substr(0,4);
						finAccountInout.searchForm.acioHappenedMonth = finAccountInout.accountInoutForm.acioHappenedTime.substr(5,2);
						jQuery.cgp.fin.getInoutList();
// 						保存不继续添加
						if(saveType == 1)	{
							jQuery.cgp.fin.accountInoutAddCancel();
						}	
						finAccountInout.accountInoutForm = jQuery.cgp.fin.initAccountInout();
					}
				}
			});
		}


		jQuery.cgp.fin.accountInoutUpdate = function(str){
			var inoutInfo = JSON.parse(str);
			if(inoutInfo.aciotypeInorout == 2){
				inoutInfo.acioMoney = -inoutInfo.acioMoney;
			}
			finAccountInout.acId = inoutInfo.acId;
			
			finAccountInout.accountInoutForm = inoutInfo;
// 			jQuery.cgp.fin.getAciotypeList(inoutInfo.aciotypeInorout);
			jQuery.cgp.fin.accountInoutAdd();
		}
		
		jQuery.cgp.fin.accountInoutDelete = function(str){
			if(!confirm("确认删除吗？"))return false;
			var inoutInfo = JSON.parse(str);
			var acioId = inoutInfo.acioId;
			finAccountInout.acId = inoutInfo.acId;
			
			$.ajax({
				type:"delete",
				url:"/fin/accountinout/"+acioId,
				data: JSON.stringify(finAccountInout.searchForm),
				dataType: "json",
				contentType:"application/json;charset=utf-8",
				success:function(data){
					jQuery.cgp.fin.getInoutList();
					jQuery.cgp.fin.getAccountList();
					
					if(data>0){
						alert("删除成功!");
					}
					
				}
			});
		}
		 
// 		获取统计信息 finAccountInout.searchForm.searchType = 2;
		jQuery.cgp.fin.accountInoutStatistics = function(){
			finAccountInout.searchForm.searchType = 2;
			jQuery.cgp.fin.getInoutListCommon();
		}
// 		获取收支详细信息列表 finAccountInout.searchForm.searchType = 1;
		jQuery.cgp.fin.getInoutList  = function(){
			finAccountInout.searchForm.searchType = 1;
			jQuery.cgp.fin.getInoutListCommon();
		}
		
//	 	获取收支明细列表
		jQuery.cgp.fin.getInoutListCommon = function(){
			finAccountInout.searchForm.acId = finAccountInout.acId;
			if(parseInt(finAccountInout.searchForm.acioHappenedYear)>-1){
				if(parseInt(finAccountInout.searchForm.acioHappenedMonth)>-1){
					finAccountInout.searchForm.acioHappenedTime = finAccountInout.searchForm.acioHappenedYear + "-" + finAccountInout.searchForm.acioHappenedMonth;;	
				}else{
					finAccountInout.searchForm.acioHappenedTime = finAccountInout.searchForm.acioHappenedYear;
				}
			}else{
				if(parseInt(finAccountInout.searchForm.acioHappenedMonth)>-1){
					finAccountInout.searchForm.acioHappenedTime = (new Date()).pattern("yyyy") + "-" + finAccountInout.searchForm.acioHappenedMonth;;	
				}else{
					finAccountInout.searchForm.acioHappenedTime = null;
				}
			}
// 			finAccountInout.searchForm.aciotypeInorout = finAccountInout.accountInoutForm.aciotypeInorout;
// 收支明细
			if(finAccountInout.searchForm.searchType == 1){
				$.ajax({
					type:"post",
					url:"/fin/accountinoutlist",
					data: JSON.stringify(finAccountInout.searchForm),
					dataType: "json",
					contentType:"application/json;charset=utf-8",
					success:function(data){
						finAccountInout.resultType = 1;
						finAccountInout.acioList = data;
						
// 						页面上计算总和
						finAccountInout.acioListMoneySum = 0;
						for(index in finAccountInout.acioList){
							finAccountInout.acioListMoneySum += finAccountInout.acioList[index].acioMoney;
						}
//			 			总和保留两位小数 注意异步方法
						finAccountInout.acioListMoneySum  = Math.round(finAccountInout.acioListMoneySum*100)/100;
					}
				});
			}else if(finAccountInout.searchForm.searchType == 2){//按选择类型分类统计
				$.ajax({
					type:"post",
					url:"/fin/accountinoutstatistics",
					data: JSON.stringify(finAccountInout.searchForm),
					dataType: "json",
					contentType:"application/json;charset=utf-8",
					success:function(data){
						finAccountInout.resultType = 2;
						finAccountInout.acioStatisticsList = data;
// 						页面上计算总和
						finAccountInout.acioListMoneySum = 0;
						for(index in finAccountInout.acioStatisticsList){
							finAccountInout.acioListMoneySum += finAccountInout.acioStatisticsList[index].sum;
						}
//			 			总和保留两位小数 注意异步方法
						finAccountInout.acioListMoneySum  = Math.round(finAccountInout.acioListMoneySum*100)/100;
					}
				});
			}

			
		};
			
		
		
//	 	获取用户列表
		jQuery.cgp.fin.getUserList = function(){
			$.ajax({
				type:"get",
				url:"/fin/userlist",
				dataType: "json",
				success:function(data){
					finAccountInout.userList = data;
				}
			});
		};
		
		window.setInterval(function(){
			finAccountInout.time = (new Date()).pattern("HH:mm:ss");
		},10*1000);
		
		jQuery.cgp.fin.getUserList();
		jQuery.cgp.fin.getAccountList();
		jQuery.cgp.fin.getInoutList();
// 		获取支出类型列表
		jQuery.cgp.fin.getAciotypeList(-1);
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
<div  id="finAccountInout">
		<!-- 页头导航开始 -->
		<nav class="navbar navbar-default" role="navigation">
			<div class="container-fluid">
				<div class="navbar-header">
					<a class="navbar-brand" href="#">账户管理系统 </a>
				</div>
				<div>
					<ul class="nav navbar-nav">
						<li><a href="/fin">账户列表</a></li>
						<li class="active"><a href="/fin/accountinout">收支明细</a></li>
						<li><a href="/fin/accounttransfer">转账明细</a></li>
						<li><a>今天:{{ date }} 现在时间:{{time}}</a></li>
					</ul>
				</div>
			</div>
		</nav>
		<!-- 页头导航结束 -->
		<!-- 账户信息开始 -->
	<div  class="" >
	<table class="table table-hover table-striped table-bordered ">
			<thead>
				<tr>
					<th >id</th>
					<th >账户名</th>
					<th >归属金融机构（银行）id</th>
					<th >余额</th>
					<th >账户归属用户id</th>
					<th >资金是否可用</th>
					<th >账户类别</th>
					<th >记录时间</th>
				</tr>
			</thead>
			<tbody>
				<tr>
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
<!-- 账户信息结束 -->

	
<!-- 	正文开始 -->
		<table  class="table table-hover table-striped table-bordered ">
			<tbody>
				<tr>
					<td width="12%">
						是否可用:<select v-model="searchForm.acCanused"  >
								<option value="-1">不限</option>
								<option value="1">可用</option>
								<option value="0">不可用</option>
						</select>
					</td>
					<td width="12%">
						收支分类:<select v-model="searchForm.aciotypeInorout"  >
								<option value="-1">不限</option>
								<option value="1">收入</option>
								<option value="2">支出</option>
						</select>
					</td>
					<td width="20%">
						账户:<select v-model="acId"  >
								<option value="-1">不限</option>
								<option v-for="option in accountList" :value="option.acId">{{option.acName}}</option>
						</select>
					</td>
					<td width="20%">
						收支时间:<select v-model="searchForm.acioHappenedYear"  >
								<option value="-1">不限</option>
								<option v-for="option in yearList" :value="option">{{option}}</option>
						</select>年 
						<select v-model="searchForm.acioHappenedMonth"  >
								<option value="-1">不限</option>
								<option v-for="option in monthList" :value="option">{{option}}</option>
						</select>月
						
					</td>
					<td colspan="10" >
						<input type="button" id="searchListBtn"  value="查询" onclick="jQuery.cgp.fin.getInoutList()">
						<input type="button" id="addBtn"  value="添加" onclick="jQuery.cgp.fin.accountInoutAdd()">
					</td>
				</tr>
				<tr>
					<td colspan="4">
					<input type="checkbox" v-model="searchForm.acioStatisticsKeyList" value="acCanused" id="acCanused"><label for="acCanused">是否可用</label>
					<input type="checkbox" v-model="searchForm.acioStatisticsKeyList" value="acId" id="acId"><label for="acId">账号</label>
					<input type="checkbox" v-model="searchForm.acioStatisticsKeyList" value="acUserId" id="acUserId"><label for="acUserId">归属人</label>
					<input type="checkbox" v-model="searchForm.acioStatisticsKeyList" value="actypeId" id="actypeId"><label for="actypeId">账户类别</label>
					<input type="checkbox" v-model="searchForm.acioStatisticsKeyList" value="orgId" id="orgId"><label for="orgId">归属机构</label>
					<input type="checkbox" v-model="searchForm.acioStatisticsKeyList" value="aciotypeInorout" id="aciotypeInorout"><label for="aciotypeInorout">收支</label>
					<input type="checkbox" v-model="searchForm.acioStatisticsKeyList" value="aciotypeId" id="aciotypeId"><label for="aciotypeId">收支分类</label>
					<input type="checkbox" v-model="searchForm.acioStatisticsKeyList" value="acioUserId" id="acioUserId"><label for="acioUserId">经办人</label>
					<input type="checkbox" v-model="searchForm.acioStatisticsKeyList" value="acioYear" id="acioYear"><label for="acioYear">年</label>
					<input type="checkbox" v-model="searchForm.acioStatisticsKeyList" value="acioMonth" id="acioMonth"><label for="acioMonth">月</label>
					</td>
					<td colspan="9" >
						<input type="button" id="statisticsBtn"  value="统计" onclick="jQuery.cgp.fin.accountInoutStatistics()">
					</td>
				</tr>
		</table>
		
<!-- 		收支明细开始 -->
		<table v-if="resultType==1" class="table table-hover table-striped table-bordered ">
			<thead>
				<tr>
					<th style="width:40px;">id</th>
					<th style="width:150px;">账户名</th>
					<th style="width:100px;">发生时间</th>
					<th style="width:100px;">收支金额(总和{{acioListMoneySum}})</th>
					<th >收支描述</th>
					<th style="width:80px;">经办人</th>
					<th style="width:60px;">收支分类</th>
					<th style="width:150px;">收支具体类别</th>
					<th style="width:160px;">记录时间</th>
					<th style="width:120px;">操作 </th>
				</tr>
			</thead>
			<tbody>
				<tr v-for="inout in acioList">
					<td>{{inout.acioId}}</td>
					<td>{{inout.acName}}</td>
					<td>{{inout.acioHappenedTime}}</td>
					<td>{{inout.acioMoney}}</td>
					<td>{{inout.acioDesc}}</td>
					<td>{{inout.userName}}</td>
					<td>{{inout.aciotypeInorout == 1?"收入":"支出"}}</td>
					<td>{{inout.aciotypeName}}</td>
					<td>{{inout.acioCreateTime}}</td>
					<td>
						<input type="button" :id="inout.acioId" :name="JSON.stringify(inout)"
						value="修改" onclick="jQuery.cgp.fin.accountInoutUpdate(this.name)">
						<input type="button"  :id="inout.acioId" :name="JSON.stringify(inout)"
						value="删除" onclick="jQuery.cgp.fin.accountInoutDelete(this.name)">
					</td>
				</tr>
			</tbody>
		</table>
<!-- 		收支明细结束 -->	


<!-- 		收支明细统计开始 -->
		<table v-if="resultType==2" class="table table-hover table-striped table-bordered ">
			<thead>
				<tr>
					<th width="8%" v-for="(value,key) in acioStatisticsList[0]">{{ getStatisticsName(key)}}<span v-if="key=='sum'">(总和{{acioListMoneySum}})</span></th>
				</tr>
			</thead>
			<tbody>
				<tr v-for="item in acioStatisticsList">
					<td width="8%" v-for="(value,key) in item">{{value}} </td>
				</tr>
			</tbody>
		</table>
<!-- 		收支明细统计结束 -->


<!-- 	正文结束 -->


<!-- 添加弹出框开始 -->
<div id="cover" style=" display:none; width:100%;height:100%;position:fixed;overflow:hidden; left:0;top:0;background-color:#000; opacity:0.5;filter:alpha(opacity=50);z-index: 1;">

</div>
	<div id="popdiv" style="display:none; width:560px;height:280px; position: fixed; left: 50%; top: 50%;  transform: translate(-50%, -50%); z-index: 2;background-color: white;">
			<table class="table table-hover table-striped table-bordered ">
				<tbody>
				<tr>
					<td colspan="4">账号： 
						<select v-model="acId"  >
								<option value="-1">不限</option>
								<option v-for="option in accountList" :value="option.acId">{{option.acName}}</option>
						</select>
					</td>
				</tr>
				<tr>
						<td colspan="1">收支分类：
						</td>
						<td colspan="1"> <input type="radio" value="1" v-model="accountInoutForm.aciotypeInorout"  id="aciotypeInorout1" @change="getAciotypeList"/> <label
							for="aciotypeInorout1">收入</label> <input type="radio" value="2" v-model="accountInoutForm.aciotypeInorout" 
							  id="aciotypeInorout2" @change="getAciotypeList"/> <label
							for="aciotypeInorout2">支出</label>
						</td>
						<td colspan="1">收支详细类别：
						</td>
						<td colspan="1"> 
						<select v-model="accountInoutForm.aciotypeId" >
								<option value="-1">未知</option>
								<option v-for="option in aciotypeList" v-if="option.aciotypeInorout == accountInoutForm.aciotypeInorout"  :value="option.aciotypeId">{{option.aciotypeName}}</option>
						</select>
						</td>
					</tr>
					<tr>
						<td colspan="1">收支额度：
						</td>
						<td colspan="1"> 
							<input type="text" v-model="accountInoutForm.acioMoney" />
						</td>
						
						<td colspan="2"> 通过余额设置:
							<input type="text" v-model="accountInoutForm.acioMoneyBalance" @change="changeBalanceToIoMoney" />
						</td>
					</tr>
					<tr>
						<td colspan="1">经办人：
						</td>
						<td colspan="1">
							<select v-model="accountInoutForm.userId" >
								<option value="-1">未知</option>
								<option v-for="option in userList" :value="option.userId">{{option.userName}}</option>
							</select>
						</td>
						<td colspan="1">发生时间：
						</td>
						<td colspan="1"> 
							<input type="text" v-model="accountInoutForm.acioHappenedTime" />
						</td>
					</tr>
					<tr>
						<td colspan="1">描述：
						</td>
						<td colspan="1">
							<textarea v-model="accountInoutForm.acioDesc"  row="3" col="10"></textarea>
						</td>
						
					</tr>
					<tr>
						<td colspan="4"><input type="button" id="add" value="保存"
							onclick='jQuery.cgp.fin.accountInoutAddSave(1)'>
							<input type="button" id="add" value="保存并继续"
							onclick='jQuery.cgp.fin.accountInoutAddSave(2)'>
						<input type="button" id="reset" value="取消"
							onclick="jQuery.cgp.fin.accountInoutAddCancel()"></td>
					</tr>
			</table>
		</div>
<!-- 添加弹出框结束 -->

</div>
</body>
</html>