<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tld/spring-form.tld" prefix="spring-form"%>
<%@ taglib uri="/WEB-INF/tld/spring.tld" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tld/c.tld" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<div class="content">
	<spring-form:form action="${pageContext.request.contextPath}/user/edit" modelAttribute="user" method="POST">
		<p><span class="subtitle">Edit User</span></p>
		<spring-form:hidden path="uid"/>
		<table>
			<tr>
				<td>User Name</td>
				<td><c:out value="${user.username}"/></td>
			</tr>
			<tr>
				<td>Email <span class="mandatory">*</span></td>
				<td><spring-form:input path="email"/><spring-form:errors path="email" cssClass="errors"/></td>
			</tr>
			<c:if test='${user.user.type != "PBC"}'>
				<c:if test='${user.user.type != "PBR"}'>
					<tr>
						<td>Role <span class="mandatory">*</span></td>
						<td>
							<spring-form:select id="id_role" path="roleIds" multiple="true" cssStyle="height: auto; width: auto;">
								<spring-form:options items="${roles}" itemLabel="name" itemValue="roleId"/>
							</spring-form:select>
						</td>
					</tr>
				</c:if>
			</c:if>
			<tr>
				<td>Remarks</td>
				<td><spring-form:input path="remarks" cssStyle="width: 650px;"/></td>
			</tr>				
		</table>
		<input name="cancel" type="button" value="Cancel" class="btn_cancel" onclick='back("${pageContext.request.contextPath}/user")'/>
		<input name="submit" type="submit" value="submit" class="btn_add"/>
	</spring-form:form>
</div>
<script type="text/javascript">
	$( document ).ready(function() {
		var tags="${user.roleIds}";
		var dataarray=tags.split(",");
		for(i=0; i < dataarray.length; i++){
		  $("#id_role option[value='" + dataarray[i] + "']").prop("selected", "selected");
		}
	});
</script>