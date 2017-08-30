//依赖jquery
(function(){
	if(typeof jQuery.cgp == "undefined"){jQuery.cgp = {};};
	if(typeof jQuery.cgp.utils == "undefined"){jQuery.cgp.utils = {};};
	jQuery.cgp.utils.clear = function(id){
		var e = $("#"+id);
		if(e!=null && e!="undefined"){
			e.val("");
		}
	};
	
})(jQuery);