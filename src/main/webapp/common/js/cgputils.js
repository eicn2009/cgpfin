/**
 * 纯js工具
 */

//判断是否为数字，是返回true 否则返回false
function checknum(num) {
	return !isNaN(parseFloat(num)); 
}

function floatRound(fnum,num){
	var pownum = Math.pow(10,num);
	return Math.round(fnum*pownum)/pownum;
}