<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tld/spring-form.tld" prefix="spring-form"%>
<%@ taglib uri="/WEB-INF/tld/spring.tld" prefix="spring"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<div class="content">
	<spring-form:form action="${pageContext.request.contextPath}/user/add" modelAttribute="user" method="POST">
		<p><span class="subtitle">Add User</span></p>
		<table>
			<tr>
				<td>User Name <span class="mandatory">*</span></td>
				<td><spring-form:input path="username"/><spring-form:errors path="username" cssClass="errors"/></td>
			</tr>
			<tr>
				<td>Email <span class="mandatory">*</span></td>
				<td><spring-form:input path="email"/><spring-form:errors path="email" cssClass="errors"/></td>
			</tr>		
			<tr>
				<td>Role <span class="mandatory">*</span></td>
				<td>
					<spring-form:select path="roleIds" multiple="true" cssStyle="height: auto; width: auto;">
						<spring-form:options items="${roles}" itemLabel="name" itemValue="roleId"/>
					</spring-form:select>
				</td>
			</tr>
			<tr>
				<td>Remarks</td>
				<td><spring-form:input path="remarks" cssStyle="width: 650px;"/></td>
			</tr>			
		</table>
		<input name="cancel" type="button" value="Cancel" class="btn_cancel" onclick='back("${pageContext.request.contextPath}/user")'/>
		<input name="submit" type="submit" value="submit" class="btn_add"/>
	</spring-form:form>
</div>