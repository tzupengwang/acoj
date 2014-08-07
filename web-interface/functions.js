/*
 * ACOJ Web Interface
 * Version: 2014-05-14
 * Author: An-Li Alt Ting
 * Email: anlialtting@gmail.com
 */
function loadXMLDoc(filename){
	if(window.XMLHttpRequest){
		xhttp=new XMLHttpRequest();
	}else{
		// code for IE5 and IE6
		xhttp=new ActiveXObject("Microsoft.XMLHTTP");
	}
	xhttp.open("GET",filename,false);
	xhttp.send();
	return xhttp.responseXML;
}
function build_tab(id){
	var t=document.getElementById(id);
	t.onkeydown=function(e){
		if(e.keyCode===9){
			var f=t.selectionStart,l=t.selectionEnd;
			t.value=t.value.substring(0,f)+'\t'+t.value.substring(l,t.value.length);
			t.selectionStart=t.selectionEnd=f+1;
			return false;
		}
	};
}
function html_stars(id,rating){
	var output='';
	for(var i=0;i<5;i++){
		partial_rating=rating-0.2*i;
		img=partial_rating<0.06666?"star-empty":partial_rating<0.1333?"star-half":"star-full";
		output+="<img src=\"./images/"+img+".png\" style=\"width:18px;\">";
	}
	document.getElementById(id).innerHTML=output;
}
