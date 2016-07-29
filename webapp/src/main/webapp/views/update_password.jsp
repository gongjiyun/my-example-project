<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tld/spring-form.tld" prefix="spring-form"%>
<%@ taglib uri="/WEB-INF/tld/spring.tld" prefix="spring"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<div class="content">
	<spring-form:form action="${pageContext.request.contextPath}/changePassword" method="POST">
		<table>
			<tr>
				<td style="text-align:right;">New password <span class="mandatory">*</span></td>
				<td><input type='password' name='password1' style="width:300px; height:30px;"/></td>
			</tr>
			<tr>
				<td style="text-align:right;">Confirm password <span class="mandatory">*</span></td>
				<td><input type='password' name='password2' style="width:300px; height:30px;"/></td>
			</tr>
		</table>
		<input name="submit" type="submit" value="submit" class="btn_submit" />
	</spring-form:form>
</div>
