<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>fintransfer</title>
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
	
	jQuery.cgp.fin.initAccountTransfer = function(){
		return  {
				actrId:-1,
				acIdTo:-1,
				acIdFrom:-1,
				actrDesc:'',
		   		userId:-1,
		   		actrMoney:0,
		   		actrHappenedTime:(new Date()).pattern("yyyy-MM-dd"),
		   		actrCreateTime:(new Date()).pattern("yyyy-MM-dd HH:mm:ss")
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
	var accountInfo = jQuery.cgp.fin.initAccountInfo();
	var accountTransfer = jQuery.cgp.fin.initAccountTransfer();
	
	var finAccountTransfer = new Vue({
		  el: '#finAccountTransfer',
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
		   	actrList:null,
		   	accountTransferForm:accountTransfer,
		   	acIdFrom:-1,
		   	acIdTo:-1
		  },
		  watch:{
			  actrList:function(newid){
				  this.init();
			  }
		  },
		  computed:{
			  finAccountFrom:function(){
				  for(item in this.accountList){
						if(this.acIdFrom == this.accountList[item].acId){
							return this.accountList[item];
						}
					}
// 				  此处若不返回，控制台会有报错信息，提示account对应的id未定义，可能与加载顺序有关
				  return accountInfo;
			  },
			  finAccountTo:function(){
				  for(item in this.accountList){
						if(this.acIdTo == this.accountList[item].acId){
							return this.accountList[item];
						}
					}
// 				  此处若不返回，控制台会有报错信息，提示account对应的id未定义，可能与加载顺序有关
				  return accountInfo;
			  }
			  
		  },
		  methods: {
			    init: function () {
			    	if(this.actrList!=null){
				    	this.acIdFrom = this.actrList[0].acIdFrom;
				    	this.acIdTo = this.actrList[0].acIdTo;
				    	this.accountTransferForm.acIdFrom = this.acIdFrom;
				    	this.accountTransferForm.acIdTo = this.acIdTo;
			    	}
			    },
			    changeFromAccount:function(){
			    	this.acIdFrom = this.accountTransferForm.acIdFrom;
			    },
			    changeToAccount:function(){
			    	this.acIdTo = this.accountTransferForm.acIdTo;
			    }
			  }
		});
	
		jQuery.cgp.fin.getActrList = function(){
			$.ajax({
				type:"get",
				url:"/fin/accounttransferlist",
				data: JSON.stringify(finAccountTransfer.searchForm),
				dataType: "json",
				contentType:"application/json;charset=utf-8",
				success:function(data){
					finAccountTransfer.actrList = data;
				}
			});	
		}

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
					finAccountTransfer.accountList = data.accountList;
// 					获取账号列表后，通过账号id刷新账号信息
// 					jQuery.cgp.fin.refreshAccount(finAccountTransfer.acId);
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
					finAccountTransfer.userList = data;
				}
			});
		};
		
		
//	 	打开收支信息弹窗
		jQuery.cgp.fin.accountTransferAdd = function(){
			$("#popdiv").css("display","block");
			$("#cover").css("display","block");
			$("body").css("overflow","hidden");
			
		}
//	 	关闭收支信息弹窗
		 jQuery.cgp.fin.accountTransferAddCancel = function(){
				finAccountTransfer.accountTransferForm = jQuery.cgp.fin.initAccountTransfer();
		    	$("#popdiv").css("display","none");
				$("#cover").css("display","none");
				$("body").css("overflow","visible");
				
		 }
		

		jQuery.cgp.fin.accountTransferUpdate = function(str){
			var transferInfo = JSON.parse(str);
			finAccountTransfer.accountTransferForm = transferInfo;
			jQuery.cgp.fin.accountTransferAdd();
		} 
		jQuery.cgp.fin.accountTransferDelete = function(str){
			if(!confirm("确认删除吗？"))return false;
			var transferInfo = JSON.parse(str);
			var actrId = transferInfo.actrId;
			
			$.ajax({
				type:"delete",
				url:"/fin/accounttransfer/"+actrId,
				data: JSON.stringify(finAccountTransfer.searchForm),
				dataType: "json",
				contentType:"application/json;charset=utf-8",
				success:function(data){
					jQuery.cgp.fin.getAccountList();
					jQuery.cgp.fin.getActrList();
					
					if(data>0){
						alert("删除成功!");
					}
					
				}
			});
		}
		
		jQuery.cgp.fin.accountTransferAddSave = function(saveType) {
			if(finAccountTransfer.accountTransferForm.acIdFrom<0){
				alert("请选择转出账户");
				return false;
			}
			if(finAccountTransfer.accountTransferForm.acIdTo<0){
				alert("请选择转出账户");
				return false;
			}
			
			if(finAccountTransfer.accountTransferForm.userId<0){
				alert("请选择经办人");
				return false;
			}
			if(!checknum(finAccountTransfer.accountTransferForm.actrMoney)||finAccountTransfer.accountTransferForm.actrMoney<=0){
				alert("请输入正确金额");
				return false;
			}
			if(!checkDateStr(finAccountTransfer.accountTransferForm.actrHappenedTime)){
				alert("请输入正确日期！！");
				return false;
			}
			finAccountTransfer.accountTransferForm.actrMoney = parseFloat(finAccountTransfer.accountTransferForm.actrMoney);
			
			$.ajax({
				type:"post",
				url:"/fin/accounttransfer",
				data: JSON.stringify(finAccountTransfer.accountTransferForm),
				dataType: "json",
				contentType:"application/json;charset=utf-8",
				success:function(data){
					if(data>0){
						jQuery.cgp.fin.getAccountList();
						jQuery.cgp.fin.getActrList();
// 						保存不继续添加
						if(saveType == 1)	{
							jQuery.cgp.fin.accountTransferAddCancel();
						}	
						finAccountTransfer.accountTransferForm = jQuery.cgp.fin.initAccountTransfer();
					}
				}
			});
			
		}
		
		window.setInterval(function(){
			finAccountTransfer.time = (new Date()).pattern("HH:mm:ss");
		},10*1000);
		
		jQuery.cgp.fin.getUserList();
		jQuery.cgp.fin.getAccountList();
		jQuery.cgp.fin.getActrList();
		finAccountTransfer.init();
		
	})
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
<div  id="finAccountTransfer">
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
						<li class="active"><a href="/fin/accounttransfer">转账明细</a></li>
					</ul>
				</div>
			</div>
			<div class="navdiv">
				<div>今天:{{ date }} 现在时间:{{time}}</div>
			</div>
		</nav>
		<!-- 页头导航结束 -->
	
<!-- 	正文开始 -->
		<table class="table table-hover table-striped table-bordered ">
			<tbody>
				<tr>
					<td width="15%">
					转出账户：{{finAccountFrom.acName}}
					</td>
					<td width="15%">
					余额：{{finAccountFrom.acBalance}}
					</td>
					<td width="15%">
					转入账户:{{finAccountTo.acName}} 余额：
					</td>
					<td width="15%">
					余额：{{finAccountTo.acBalance}}
					</td>
				</tr>
				<tr>
					<td colspan="5" ><input type="button" id="searchList" 
						value="添加" onclick="jQuery.cgp.fin.accountTransferAdd()">
					</td>

				</tr>
		</table>
		<table class="table table-hover table-striped table-bordered ">
			<thead>
				<tr>
					<th >id</th>
					<th >转出账户名</th>
					<th >转入账户名</th>
					<th >转账金额</th>
					<th >转账描述</th>
					<th >经办人</th>
					<th >转账发生时间</th>
					<th >记录时间</th>
					<th >操作 </th>
				</tr>
			</thead>
			<tbody>
				<tr v-for="actrInfo in actrList">
					<td>{{actrInfo.actrId}}</td>
					<td>{{actrInfo.acNameFrom}}</td>
					<td>{{actrInfo.acNameTo}}</td>
					<td>{{actrInfo.actrMoney}}</td>
					<td>{{actrInfo.actrDesc}}</td>
					<td>{{actrInfo.userName}}</td>
					<td>{{actrInfo.actrHappenedTime}}</td>
					<td>{{actrInfo.actrCreateTime}}</td>
					<td>
						<input type="button" :id="actrInfo.actrId" :name="JSON.stringify(actrInfo)"
						value="修改" onclick="jQuery.cgp.fin.accountTransferUpdate(this.name)">
						<input type="button"  :id="actrInfo.actrId" :name="JSON.stringify(actrInfo)"
						value="删除" onclick="jQuery.cgp.fin.accountTransferDelete(this.name)">
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
					<td colspan="2">转出账号： 
						<select v-model="accountTransferForm.acIdFrom"  @change="changeFromAccount">
								<option value="-1">不限</option>
								<option v-for="option in accountList" :value="option.acId">{{option.acName}}</option>
						</select> 当前余额：{{finAccountFrom.acBalance}}
					</td>
					<td colspan="2">转入账号： 
						<select v-model="accountTransferForm.acIdTo"  @change="changeToAccount">
								<option value="-1">不限</option>
								<option v-for="option in accountList" :value="option.acId">{{option.acName}}</option>
						</select>当前余额：{{finAccountTo.acBalance}}
					</td>
				</tr>
				
					<tr>
						<td colspan="1">转账额度：
						</td>
						<td colspan="1"> 
							<input type="text" v-model="accountTransferForm.actrMoney" />
						</td>
						<td colspan="1">发生时间：
						</td>
						<td colspan="1"> 
							<input type="text" v-model="accountTransferForm.actrHappenedTime" />
						</td>
					</tr>
					<tr>
						<td colspan="1">描述：
						</td>
						<td colspan="1">
							<textarea v-model="accountTransferForm.actrDesc"  row="3" col="10"></textarea>
						</td>
						<td colspan="1">经办人：
						</td>
						<td colspan="1">
							<select v-model="accountTransferForm.userId" >
								<option value="-1">未知</option>
								<option v-for="option in userList" :value="option.userId">{{option.userName}}</option>
							</select>
						</td>
					</tr>
					<tr>
						<td colspan="4"><input type="button" id="add" value="保存"
							onclick='jQuery.cgp.fin.accountTransferAddSave(1)'>
							<input type="button" id="add" value="保存并继续"
							onclick='jQuery.cgp.fin.accountTransferAddSave(2)'>
						<input type="button" id="reset" value="取消"
							onclick="jQuery.cgp.fin.accountTransferAddCancel()"></td>
					</tr>
			</table>
		</div>
<!-- 添加弹出框结束 -->



</div>
</body>
</html>