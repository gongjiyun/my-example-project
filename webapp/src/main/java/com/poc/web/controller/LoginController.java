package com.poc.web.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.DataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.poc.common.entities.Role;
import com.poc.common.entities.User;
import com.poc.common.model.AuthUserDetails;
import com.poc.utils.constants.PortalConstants;
import com.poc.utils.util.ParamUtil;
import com.poc.web.util.PublishExtUtil;
import com.poc.web.util.ServiceGateUtil;

@Controller
public class LoginController extends AbstractPortalController{
	private final static Logger logger = LoggerFactory.getLogger(LoginController.class);
	private final static  String PATH_ADMIN_LOGIN = "login";
	private final static  String PATH_ADMIN_HOME = "admin";
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@InitBinder
	public void initBinder(DataBinder binder) {
		
	}
	
	@RequestMapping(path = "/login", method = RequestMethod.GET)
	public String init(HttpServletRequest request, HttpServletResponse response, Model model) {
		try {
			if("true".equals(ParamUtil.getString(request, "error", ""))){
				addError(request, "page.error.invalid.user.password", null, "username or password not correct");
			}
		} catch (Exception e) {
			logger.error("Error on login", e);
		}
		return PATH_ADMIN_LOGIN;
	}
	
	@RequestMapping(path = "/admin", method = {RequestMethod.GET, RequestMethod.POST})
	public String admin(HttpServletRequest request, HttpServletResponse response, Model model) {
		try {
			Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			String username;
			if (principal instanceof AuthUserDetails) {
				username = ((UserDetails)principal).getUsername();
			} else if(principal instanceof UserDetails) {
				username = ((UserDetails)principal).getUsername();
			}else {
				username = principal.toString();
			}
			User user = ServiceGateUtil.getUserService().findUserByName(username);
			List<Role> rolelist = ServiceGateUtil.getUserService().findRolesByUID(user.getUid());
			List<String> rolestrings = new ArrayList<String>();
			if(rolelist!=null && rolelist.size()>0){
				for(Role r : rolelist){
					rolestrings.add(r.getName());
				}
			}
			
			request.getSession().setAttribute(PortalConstants.WEB_KEY_UID, user.getUid());
			request.getSession().setAttribute(PortalConstants.WEB_KEY_USERNAME, user.getUsername());
			request.getSession().setAttribute(PortalConstants.WEB_KEY_USER, user);
			request.getSession().setAttribute(PortalConstants.WEB_KEY_USER_ROLES, rolestrings);
			
			PublishExtUtil.instance().publishQueue("{type:login, userid:1}");
			return PATH_ADMIN_HOME;
		} catch (Exception e) {
			logger.error("Error on redirect to home", e);
		}
		
		return null;
	}

}
