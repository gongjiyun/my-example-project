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
</head>
<body>
	<div class="login_block">
		<form action="${pageContext.request.contextPath}/j_spring_security_check" method="POST" id="login_form">
			<h3>Admin Panel Login</h3>
			<fieldset>
				<p><input type="text" name='j_username' placeholder="Usename" class="ic_un"></p>
				<p><input type="password" name='j_password' placeholder="Password" class="ic_pw"></p>
				<p><a href="javascript:void(0);" class="btn_login" onclick="javascript:login();">Login</a></p>
			</fieldset>
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		</form>
	</div>
	<script>
	function login() {
		$("#login_form").submit();
	}
	</script>
</body>
</html>