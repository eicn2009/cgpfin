/**
 * 依赖jquery 用于cgp fin 共用业务
 */
($(function(){

if(typeof $.cgp == "undefined"){$.cgp = {};};
if(typeof $.cgp.fin == "undefined"){$.cgp.fin = {};};
	
$.cgp.fin.userlist = [];
// 	获取用户列表
	$.cgp.fin.getUserlist = function(){
		var list;
		$.ajax({
			type:"get",
			url:"/fin/userlist",
			dataType: "json",
			success:function(data){
				$.cgp.fin.userlist = data;
			}
		});
	};
}))(jQuery1)