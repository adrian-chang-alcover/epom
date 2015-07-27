var methods = [];

for( var method in document.getElementsByTagName('h4')){
	var method_name = method.innerHTML.toLowerCase().replace(' ','_')
	methods[method_name] = {};
}
console.log(methods)