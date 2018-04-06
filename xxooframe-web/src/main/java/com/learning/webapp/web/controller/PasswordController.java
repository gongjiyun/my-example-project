package com.learning.webapp.web.controller;

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

import com.learning.webapp.web.util.ServiceGateUtil;

@Controller
public class PasswordController {
	private final static Logger logger = LoggerFactory.getLogger(PasswordController.class);
	private final static  String PATH_HOME = "home";
	private final static  String PATH_UPDATE_PASSWORD = "changepassword";
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@InitBinder
	public void initBinder(DataBinder binder) {
		
	}
	
	@RequestMapping(path = "/changePassword", method = RequestMethod.GET)
	public String init(HttpServletRequest request, HttpServletResponse response, Model model) {
		return PATH_UPDATE_PASSWORD;
	}	

	@RequestMapping(path = "/changePassword", method = RequestMethod.POST)
	public String login(HttpServletRequest request, HttpServletResponse response, Model model) {
		try {
			String password1 = request.getParameter("password1");
			String password2 = request.getParameter("password2");
			if(password1==null || password2==null || !password1.equals(password2)){
				return PATH_UPDATE_PASSWORD;
			}
			
			Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			String username = "";
			if (principal instanceof UserDetails) {
				username = ((UserDetails)principal).getUsername();
			} else {
				username = principal.toString();
			}

			ServiceGateUtil.getUserService().changePassword(username, passwordEncoder.encode(password1));
			return PATH_HOME;
		} catch (Exception e) {
			logger.error("Error on login", e);
		}
		return PATH_UPDATE_PASSWORD;
	}
}
