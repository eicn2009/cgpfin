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
		"tradeacPriceNow" : 0,
		"tradeacMoneyCost" : 0,
		"tradeacCreateTime" : "",
		"tradeacUpdateTime" : "",
		"acId" : 0,
		"account" : null
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