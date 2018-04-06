package com.learning.webapp.web.controller;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.learning.common.entities.Role;
import com.learning.common.entities.User;
import com.learning.common.model.AuthUserDetails;
import com.learning.common.model.WebMessage;
import com.learning.common.model.WebMessages;
import com.learning.utils.constants.ErrorCodeConstants;
import com.learning.utils.constants.PortalConstants;
import com.learning.utils.constants.RoleConstants;
import com.learning.utils.exception.SystemException;
import com.learning.webapp.web.util.ServiceGateUtil;

/**
 **Digital Banking Trends �C Banks�� Goal and NCS Presence
 **/
public abstract class AbstractPortalController {
	private final static Logger logger = LoggerFactory.getLogger(AbstractPortalController.class);
	
	protected User getCurrentUser(HttpServletRequest request){
		try {
			User user = (User) request.getSession().getAttribute(PortalConstants.WEB_KEY_USER);
			if(user!=null){
				return user;
			}
			
			Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			String username = "";
			if (principal instanceof AuthUserDetails) {
				username = ((UserDetails)principal).getUsername();
			} else if(principal instanceof UserDetails) {
				username = ((UserDetails)principal).getUsername();
			}else {
				username = principal.toString();
			}
			return ServiceGateUtil.getUserService().findUserByName(username);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	protected long getCurrentUID(HttpServletRequest request){
		try {
			User user = (User) request.getSession().getAttribute(PortalConstants.WEB_KEY_USER);
			if(user!=null){
				return user.getUid();
			}
			
			Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			String username = "";
			if (principal instanceof AuthUserDetails) {
				username = ((UserDetails)principal).getUsername();
			} else if(principal instanceof UserDetails) {
				username = ((UserDetails)principal).getUsername();
			}else {
				username = principal.toString();
			}
			return ServiceGateUtil.getUserService().findUserByName(username).getUid();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	protected UserDetails getCurrentUserDetails(HttpServletRequest request){
		try {			
			Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			if (principal instanceof AuthUserDetails) {
				return (UserDetails) principal;
			} else if(principal instanceof UserDetails) {
				return (UserDetails) principal;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	@SuppressWarnings("unchecked")
	protected List<String> getCurrentUserRoles(HttpServletRequest request){
		List<String> roles = new ArrayList<String>();
		try {
			List<String> rolestrs = (List<String>) request.getSession().getAttribute(PortalConstants.WEB_KEY_USER_ROLES);
			if(rolestrs!=null && rolestrs.size()>0){
				return rolestrs;
			}
			
			long uid = getCurrentUID(request);
			List<Role> rolelist = ServiceGateUtil.getUserService().findRolesByUID(uid);
			if(rolelist!=null && rolelist.size()>0){
				for(Role r : rolelist){
					roles.add(r.getName());
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return roles;
	}
	
	protected boolean isAdmin(HttpServletRequest request) throws Exception {
		try {
			List<String> roles = getCurrentUserRoles(request);
			if(roles!=null && roles.contains(RoleConstants.ROLE_SYS_ADMIN)){
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	protected ApplicationContext getApplicationContext(HttpServletRequest request) throws Exception {
		return WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());	
	}
	
	protected void renderJson(JSONObject result, HttpServletRequest request, HttpServletResponse response) throws Exception {
		try {
			response.setContentType("text/plain;charset=utf-8");
			response.getWriter().write(result.toString());
			response.getWriter().flush();
			response.getWriter().close();
		} catch (Exception e) {
			logger.error("Error on write json string", e);
		}
	}
	
	protected void renderSuccess(HttpServletRequest request, HttpServletResponse response) throws Exception {
		try {
			response.setContentType("text/plain;charset=utf-8");
			
			JSONObject result = new JSONObject();
			result.put("code", "200");
			result.put("message", "OK");
			response.getWriter().write(result.toString());
			response.getWriter().flush();
			response.getWriter().close();
		} catch (Exception e) {
			logger.error("Error on write json string", e);
		}
	}
	
	protected void renderFailure(HttpServletRequest request, HttpServletResponse response) throws Exception {
		try {
			response.setContentType("text/plain;charset=utf-8");
			
			JSONObject result = new JSONObject();
			result.put("code", "500");
			result.put("message", "Fail");
			response.getWriter().write(result.toString());
			response.getWriter().flush();
			response.getWriter().close();
		} catch (Exception e) {
			logger.error("Error on write json string", e);
		}
	}
	
	protected void renderJson(JSONArray result, HttpServletRequest request, HttpServletResponse response) throws Exception {
		try {
			response.setContentType("text/plain;charset=utf-8");
			response.getWriter().write(result.toString());
			response.getWriter().flush();
			response.getWriter().close();
		} catch (Exception e) {
			logger.error("Error on write json string", e);
		}

	}
	
	protected void addError(HttpServletRequest request, String errorKey, String[] args, String defaultMessage){
		try {
			WebMessages webErrors = (WebMessages)request.getAttribute(PortalConstants.WEB_ERROR_KEY);
			if(webErrors==null){
				request.setAttribute(PortalConstants.WEB_ERROR_KEY, new WebMessages());
			}
			webErrors = (WebMessages)request.getAttribute(PortalConstants.WEB_ERROR_KEY);
			
			WebMessage error = new WebMessage();
			error.setMsgKey(errorKey);
			error.setError(true);
			error.setArgs(args);
			error.setMessage(defaultMessage);
			webErrors.addError(error);
		} catch (Exception e) {
			logger.error("Error in add error message");
		}
	}
	
	protected void addMessage(HttpServletRequest request, String errorKey, String[] args, String defaultMessage){
		try {
			WebMessages webErrors = (WebMessages)request.getAttribute(PortalConstants.WEB_ERROR_KEY);
			if(webErrors==null){
				request.setAttribute(PortalConstants.WEB_ERROR_KEY, new WebMessages());
			}
			webErrors = (WebMessages)request.getAttribute(PortalConstants.WEB_ERROR_KEY);
			
			WebMessage error = new WebMessage();
			error.setMsgKey(errorKey);
			error.setError(false);
			error.setArgs(args);
			error.setMessage(defaultMessage);
			webErrors.addError(error);
		} catch (Exception e) {
			logger.error("Error in add message");
		}
	}

	
	@ExceptionHandler(value={Exception.class, SystemException.class})  
	protected String exceptionHandler(Exception ex, HttpServletRequest request, HttpServletResponse response) {  
		try {
			String errCode = ErrorCodeConstants.ERR_CODE_SERVER;
			String message = ex.getMessage();
			if(ex instanceof SystemException){
				SystemException sysec = (SystemException)ex;
				if(sysec.getErrorCode()!=null){
					errCode = sysec.getErrorCode();
				}
				if(sysec.getMessage()!=null){
					message = sysec.getMessage();
				}
				logger.error("code : " + sysec.getErrorCode() + ", error : " + sysec.getMessage());
			}else{
				logger.error("Handler error " + ex.getMessage());
			}

			StringWriter sw = new StringWriter();
			ex.printStackTrace(new PrintWriter(sw, true));
			String trace = sw.toString();
			request.setAttribute("error", trace);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "error";
    }
	
}
