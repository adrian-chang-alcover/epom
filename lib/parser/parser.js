$(function(){
	$('div#content').load('doc/advertiser.html', function(){
		var methods = {};

		$('h4[align!="center"]').each(function(index, method){
			var method_name = method.innerHTML.toLowerCase();
			methods[method_name] = {};
			methods[method_name]['description'] = $(method).next('p[style="white-space: pre-wrap;"]').html()
		})
		console.log(JSON.stringify(methods));
	})
})