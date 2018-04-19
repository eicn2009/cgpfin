/**
 * 依赖jquery 用于cgp fin 共用业务
 */

if (typeof $.cgp == "undefined") {
	$.cgp = {};
};
if (typeof $.cgp.fin == "undefined") {
	$.cgp.fin = {};
};

function getTradeAccount() {
	return {
		"tradeacId" : -1,
		"tradeacName" : "",
		"tradeacCode" : "",
		"tradeacCount" : 0,
		"tradeacType" : 1,
		"tradeacPriceNow" : 0,
		"tradeacMoneyCost" : 0,
		"tradeacRemark" : "",
		"tradeacCreateTime" : "",
		"tradeacUpdateTime" : "",
		"acId" : 0,
		"account" : null
	}
}
function getTradeAccountInout() {
	return {
		"tradeacioId" : -1,
		"tradeacioType" : 1,
		"tradeacioCount" : 0,
		"tradeacioPrice" : 0,
		"tradeacioTax" : 0,
		"tradeacioFee" : 0,
		"tradeacioRemark" : "",
		"tradeacioCreateTime" : "",
		"tradeacioUpdateTime" : "",
		"tradeacId" : 0,
		"tradeAccount" : null
	}
}
function getTradeAccountSearchForm() {
	return {
		"tradeacId" : -1,
		"tradeacName" : "",
		"tradeacCode" : "",
		"tradeacCount" : 0,
		"tradeacPriceNow" : 0,
		"tradeacMoneyCost" : 0,
		"tradeacCreateTime" : "",
		"tradeacUpdateTime" : "",
		"acId" : 0,
		"account" : null
	}
}

// 获取用户列表
$.cgp.fin.getUserlist = function(fnsuccess) {
	$.ajax({
		type : "get",
		url : "/fin/userlist",
		dataType : "json",
		success : function(data) {
			fnsuccess(data);
		}
	});
};
// 获取账户列表
$.cgp.fin.getAccountList = function(fnsuccess) {
	$.ajax({
		type : "post",
		url : "/fin/accountlist",
		data : null,
		dataType : "json",
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			fnsuccess(data.accountList);
		}
	});
};
//通过交易账户id获取交易信息列表
$.cgp.fin.getTradeAccountInoutList = function(tradeacId,fnsuccess){
	$.ajax({
		type:"get",
		url:"/fin/fintradeaccountinout/fintradeaccountinoutlist/"+tradeacId,
		dataType: "json",
		success:function(data){
			fnsuccess(data);
		}
	});
}

jQuery.cgp.fin.getTradeAccount = function(tradeacId,fnsuccess){
	$.ajax({
		type:"get",
		url:"/fin/fintradeaccount/fintradeaccount"+tradeacId,
		dataType: "json",
		success:function(data){
			fnsuccess(data);
		}
	});
}


