<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tld/security.tld" prefix="security"%>
<%@ taglib uri="/WEB-INF/tld/spring-form.tld" prefix="spring-form"%>
<%@ taglib uri="/WEB-INF/tld/spring.tld" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tld/c.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/functions.tld" prefix="fn"%>

<security:authorize access="isAuthenticated()">
	<spring:url var="logoutURL" value="/logout" htmlEscape="true" />
	<spring:url var="homeURL" value="/home" htmlEscape="true" />
	<spring:url var="changePasswordURL" value="/changePassword" htmlEscape="true" />
	<spring:url var="userUrl" value="/user" htmlEscape="true" />

	<%
		String activeClass = "active";
		String path = request.getContextPath();
		String uri = request.getAttribute("javax.servlet.forward.request_uri").toString();
		String actionuri = uri.substring(path.length());
		request.setAttribute("actionuri", actionuri);
	%>
	
	<div id="nav">
		<a href="javascript:;" class="logo" title="Logo"></a>
		<ul>
			<li><a href="${homeURL}">Home</a></li>
		</ul>
		<security:authorize access="hasAnyRole('SYSTEM','ADMIN')">
			<ul>
				<li><a id="menu_id_admin" href="${userUrl}">User Management</a></li>
			</ul>
		</security:authorize>
		<ul>
			<li><a href="${changePasswordURL}">Change password</a></li>
		</ul>
		<security:authorize access="hasAnyRole('SYSTEM')">
			<ul>
				<li><a href="${settingsURL}">Settings</a></li>
			</ul>
		</security:authorize>
		<ul>
			<li><a href="${logoutURL}">Logout</a></li>
		</ul>
		
		<%
			if(actionuri.contains("admin")){
		%>
			<dl class="sub_nav">
				<dd>
					<c:choose>
						<c:when test="${fn:containsIgnoreCase(actionuri, 'event')}"><a href="${eventUrl}" class="active"><span class="ico ic_event"></span>Event</a></c:when>
						<c:otherwise><a href="${eventUrl}"><span class="ico ic_event"></span>Event</a></c:otherwise>
					</c:choose>
				</dd>
			</dl>
			<script type="text/javascript">
				$( document ).ready(function() {
				    $('#menu_id_admin').addClass("active")
				});
			</script>
		<%
			}
		%>
	</div>
	<script type="text/javascript">
		$( document ).ready(function() {
		    $('#nav a[href*="${actionuri}"]').addClass("active")
		});
	</script>
</security:authorize>



