package com.example.springboot.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.springboot.entity.User;
import com.example.springboot.service.UserService;


@Controller
public class UserController extends BaseController{
	
	@Autowired
	private UserService userService;
	

	public UserService getUserService() {
		return userService;
	}

	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	@RequestMapping(path="/user/list", method={RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public List<User> listUsers(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception{
		return userService.findAll();
	}
	
	@RequestMapping(path="/user/create", method={RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public String createUser(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception{
		User user = new User();
		user.setUid(1l);
		user.setUsername("test");
		user.setEmail("test@cn.cm");
		
		User exist = userService.create(user);
		
		return exist.getUsername();
	}
	
}
