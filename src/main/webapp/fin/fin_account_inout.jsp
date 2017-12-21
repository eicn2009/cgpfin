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
		   		acioHappenedTime:(new Date()).pattern("yyyy-MM-dd")
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
		    date: (new Date()).pattern("yyyy-MM-dd"),
		    time: (new Date()).pattern("HH:mm:ss"),
		    accountList:null,
		    userList:null,
		    searchForm:null,
		    user:{
		    	userId:-1,
		    	userName:''
		    },
		    acId:4,
// 		    account:accountInfo,
		   	aciotypeList:null,
		   	acioList:null,
		   	accountInoutForm:accountInout
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
		  methods: {
			    methodtest: function () {
			      console.log("this is method test!!!")
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
			if(finAccountInout.accountInoutForm.aciotypeId<0){
				alert("请选择收支详细类别");
				return false;
			}
			if(finAccountInout.accountInoutForm.userId<0){
				alert("请选择经办人");
				return false;
			}
			if(!checknum(finAccountInout.accountInoutForm.acioMoney)||finAccountInout.accountInoutForm.acioMoney<=0){
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
		
//	 	获取用户列表
		jQuery.cgp.fin.getInoutList = function(){
			$.ajax({
				type:"get",
				url:"/fin/accountinoutlist",
				data: JSON.stringify(finAccountInout.searchForm),
				dataType: "json",
				contentType:"application/json;charset=utf-8",
				success:function(data){
					finAccountInout.acioList = data;
				}
			});
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
					<a class="navbar-brand" href="#">账户管理系统</a>
				</div>
				<div>
					<ul class="nav navbar-nav">
						<li><a href="/fin">账户列表</a></li>
						<li class="active"><a href="/fin/accountinout">收支明细</a></li>
						<li><a href="/fin/accounttransfer">转账明细</a></li>
					</ul>
				</div>
			</div>
			<div class="navdiv">
				<div>今天:{{ date }} 现在时间:{{time}}</div>
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
		<table class="table table-hover table-striped table-bordered ">
			<tbody>
				<tr>
					<td width="15%">
						<select v-model="acId"  >
								<option value="-1">不限</option>
								<option v-for="option in accountList" :value="option.acId">{{option.acName}}</option>
						</select>
						
					</td>
					<td colspan="5" ><input type="button" id="searchList" 
						value="添加" onclick="jQuery.cgp.fin.accountInoutAdd()">
					</td>

				</tr>
		</table>
		<table class="table table-hover table-striped table-bordered ">
			<thead>
				<tr>
					<th >id</th>
					<th >账户名</th>
					<th >发生时间</th>
					<th >收支金额</th>
					<th >余额</th>
					<th >收支描述</th>
					<th >经办人</th>
					<th >收支分类</th>
					<th >收支具体类别</th>
					<th >记录时间</th>
					<th >操作 </th>
				</tr>
			</thead>
			<tbody>
				<tr v-for="inout in acioList">
					<td>{{inout.acioId}}</td>
					<td>{{inout.acName}}</td>
					<td>{{inout.acioHappenedTime}}</td>
					<td>{{inout.aciotypeInorout == 2?-inout.acioMoney:inout.acioMoney}}</td>
					<td>{{inout.acioBalance}}</td>
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
						<td colspan="1">经办人：
						</td>
						<td colspan="1">
							<select v-model="accountInoutForm.userId" >
								<option value="-1">未知</option>
								<option v-for="option in userList" :value="option.userId">{{option.userName}}</option>
							</select>
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