package com.learning.springboot.example.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.learning.springboot.example.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TestAngularController extends BaseController{
	
	@Autowired
	private UserService userService;
	
	public UserService getUserService() {
		return userService;
	}

	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	
	@RequestMapping(value="/angular-test", method={RequestMethod.GET})
	public String testAngular(HttpServletRequest request, HttpServletResponse response){
        return "angular-test";
	}
	

}
