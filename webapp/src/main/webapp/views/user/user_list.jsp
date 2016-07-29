<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tld/spring-form.tld" prefix="spring-form"%>
<%@ taglib uri="/WEB-INF/tld/spring.tld" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tld/displaytag.tld" prefix="display"%>
<%@ taglib uri="/WEB-INF/tld/c.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/fmt.tld" prefix="fmt"%>
<%@ taglib uri="/WEB-INF/tld/customer.tld" prefix="custom"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<div class="content">
	<div class="form_block">
		<spring-form:form action="${pageContext.request.contextPath}/user/search" method="post">
			<p>
				<label>User Name:</label>
				<input type="text" name="username" value='<c:out value="${searchCriteria.username}"/>' style="width: 20%"/>
			</p>
			<p>
				<label>Email:</label>
				<input type="text" name="email" value='<c:out value="${searchCriteria.email}"/>' style="width: 50%"/>
			</p>
			<div class="btn_block">
				<input name="submit" type="submit" value="Search" class="btn_add" />
				<input name="submit" type="button" value="Add" class="btn_add" onclick="gotoAdd()"/>
			</div>		
		</spring-form:form>
	</div>
	<table>
		<display:table class="datatable" list="${requestScope.userlist}" id="uservo" requestURI="${pageContext.request.contextPath}/user/search" pagesize="10">
			<display:column titleKey="page.user.title.sn">
				<c:out value="${uservo_rowNum}" />
			</display:column>
			<display:column property="username" titleKey="page.user.title.loginid"/>
			<display:column titleKey="page.user.title.username">
				<c:out value="${uservo.user.screenName}" />
			</display:column>
			<display:column property="roleDescriptions" titleKey="page.user.title.role"/>
			<display:column property="userProfile.email" titleKey="page.user.title.email"/>
			<display:column titleKey="page.user.title.action">
				<a href='javascript:deleteUser("<c:out value="${uservo.uid}" />")' title="delete" class="td_ic ico_delete"></a>
				<a href='${pageContext.request.contextPath}/user/edit/<c:out value="${uservo.uid}" />' title="edit" class="td_ic ico_edit"></a>
				<c:if test="${uservo.user.status == 0}">
					<a id='status_row_<c:out value="${uservo.uid}" />' class="st_red" href='javascript:void()' onclick='activeUser("<c:out value="${uservo.uid}" />")' title="Active"></a>
				</c:if>
				<c:if test="${uservo.user.status == 1}">
					<a id='status_row_<c:out value="${uservo.uid}" />' class="st_green" href='javascript:void()' onclick='inactiveUser("<c:out value="${uservo.uid}" />")' title="Inactive"></a>
				</c:if>
			</display:column>
		</display:table>
	</table>
</div>

<div id="dialog-confirm" title="Delete user?" style="display: none;">
  <p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0; "></span>These items will be permanently deleted and cannot be recovered. Are you sure?</p>
</div>
<script>
	function deleteUser(uid){
	    $( "#dialog-confirm" ).dialog({
		      resizable: false,
		      height:140,
		      width:500,
		      modal: true,
		      buttons: {
		        "Delete all items": function() {
			        var url = '${pageContext.request.contextPath}/user/delete/' + uid;
			        document.location.href = url;
			        $( this ).dialog( "close" );
		        },
		        Cancel: function() {
			        $( this ).dialog( "close" );
		        }
		      }
		});
	}

	function gotoAdd(){
		document.location.href = '${pageContext.request.contextPath}/user/add';
	}

	function activeUser(uid){
		$(".content").mask("Waiting...");
		var aj = $.ajax( 
			{  
			 	url:'${pageContext.request.contextPath}/user/active/'+uid,
			    type:'get',  
			    cache:false,  
			    dataType:'json',  
			    success:function(data) {  
			        if(data.code == "200"){   
			            $("#status_row_"+uid).removeClass("st_red");
			            $("#status_row_"+uid).addClass("st_green");
			            $("#status_row_"+uid).attr('onclick','inactiveUser("' + uid + '")');
			            $("#status_row_"+uid).attr('title','Inactive');
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

	function inactiveUser(uid){
		$(".content").mask("Waiting...");
		var aj = $.ajax( 
			{  
			 	url:'${pageContext.request.contextPath}/user/inactive/'+uid,
			    type:'get',  
			    cache:false,  
			    dataType:'json',  
			    success:function(data) {  
			        if(data.code == "200"){   
			           	$("#status_row_"+uid).removeClass("st_green");
			            $("#status_row_"+uid).addClass("st_red");
			            $("#status_row_"+uid).attr('onclick','activeUser("' + uid + '")');
			            $("#status_row_"+uid).attr('title','Active');
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