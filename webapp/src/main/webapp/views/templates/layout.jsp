<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tld/tiles-jsp.tld" prefix="tiles"%> 
<%@ taglib uri="/WEB-INF/tld/c.tld" prefix="c"%> 
<%@ taglib uri="/WEB-INF/tld/errors.tld" prefix="errors"%> 

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/jquery-ui.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/jquery.datepick.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/jquery.multiselect.filter.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/jquery.multiselect.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/jquery.loadmask.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/global.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/override.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.10.2.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-ui.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.datepick.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.dropkick-min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.multiselect.filter.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.multiselect.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.loadmask.min.js"></script>
<script type="text/javascript">
	$(function(){
		$.datepicker.setDefaults($.datepicker.regional['']);
		$(".datepicker").datepicker({
			  dateFormat: "yy-mm-dd",
			  changeMonth: true,
              changeYear: true
		});
  	});

  	function back(url){
  	  	document.location.href = url;
  	}

	function activeItem(actionuid, itemId, msg){
		$(".content").mask("Waiting...");
		var aj = $.ajax( 
			{  
			 	url:'${pageContext.request.contextPath}/'+actionuid+'/active/'+itemId,
			    type:'get',  
			    cache:false,  
			    dataType:'json',  
			    success:function(data) {  
			        if(data.code == "200"){   
			            $("#status_row_"+itemId).removeClass("st_red");
			            $("#status_row_"+itemId).addClass("st_green");
			            $("#status_row_"+itemId).attr('onclick','inactiveItem("' + actionuid + '","' + itemId + '","' + msg +'")');
			            $("#status_row_"+itemId).attr('title','Inactive');
			            $(".content").unmask();
			        }else if(data.code == "500"){ 
			        	$(".content").unmask();
			        }
			     },  
			     error:function() {  
			    	 $(".content").unmask();
			     }  
			});
	}
	
	function inactiveItem(actionuid, itemId, msg){
		$(".content").mask("Waiting...");
		var aj = $.ajax( 
			{  
			 	url:'${pageContext.request.contextPath}/'+actionuid+'/inactive/'+itemId,
			    type:'get',  
			    cache:false,  
			    dataType:'json',  
			    success:function(data) {  
			        if(data.code == "200"){   
			           	$("#status_row_"+itemId).removeClass("st_green");
			            $("#status_row_"+itemId).addClass("st_red");
			            $("#status_row_"+itemId).attr('onclick','activeItem("' + actionuid + '","' + itemId + '","' + msg +'")');
			            $("#status_row_"+itemId).attr('title','Active');
			            $(".content").unmask();
			        }else if(data.code == "500"){   
			        	$(".content").unmask();
			        }
			    },  
			    error:function() {  
			    	$(".content").unmask();
			    }  
			});
	}  	
</script>

<title><tiles:getAsString name="title"></tiles:getAsString></title>
</head>
<body>
		<tiles:insertAttribute name="header" />
		<tiles:insertAttribute name="menu" />
		<errors:errors/>
		<tiles:insertAttribute name="body" />	
		<tiles:insertAttribute name="footer" />
</body>
</html>