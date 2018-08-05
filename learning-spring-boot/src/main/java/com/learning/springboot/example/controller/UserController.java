package com.learning.springboot.example.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.learning.common.entities.User;
import com.learning.springboot.example.service.UserService;

@Controller
public class UserController extends BaseController {

	@Autowired
	private UserService userService;

	public UserService getUserService() {
		return userService;
	}

	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	@RequestMapping(path = "/user/list", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public List<User> listUsers(HttpServletRequest request, HttpServletResponse response, Model model)
			throws Exception {
		return userService.findAll();
	}

	@RequestMapping(path = "/user/create", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public User createUser(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		User user = new User();
		user.setUid(1l);
		user.setUsername("test");
		user.setEmail("test@cn.cm");

		User exist = userService.create(user);

		return exist;
	}

	@RequestMapping(value = "/api/listAllUsers", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public List<User> listAllUsers(HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<User> users = userService.findAll();
		if (users == null) {
			return null;
		}
		List<User> userlist = new ArrayList<User>();
		users.forEach(user -> {

			User u = new User();
			u.setUid(user.getUid());
			u.setUsername(user.getUsername());
			u.setEmail(user.getEmail());
			userlist.add(u);
			
		});

		return userlist;
	}

	@RequestMapping(value = "/api/check/username", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public String unique(@RequestBody String param, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		System.out.println("param : " + param);
		return "{\"isUnique\":true}";
	}

}
