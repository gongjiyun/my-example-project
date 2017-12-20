package com.example.springboot.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.springboot.service.UserService;
import com.example.springboot.vo.User;

@Controller
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
	
	@ResponseBody
	@RequestMapping(value="/api/listAllUsers", method={RequestMethod.GET, RequestMethod.POST})
	public List<User> listAllUsers(HttpServletRequest request, HttpServletResponse response) throws Exception{
        List<com.example.springboot.entity.User> users = userService.findAll();
        if(users==null){
        	return null;
        }
        List<User> userlist = new ArrayList<User>();
        users.forEach(user->{
        	
        	User u = new User();
        	u.setUid(user.getUid());
        	u.setName(user.getUsername());
        	u.setEmail(user.getEmail());
        	userlist.add(u);
        });
        
        return userlist;
	}
	
	
	@ResponseBody
	@RequestMapping(value="/api/check/username", method={RequestMethod.GET, RequestMethod.POST})
	public String unique(@RequestBody String param,  HttpServletRequest request, HttpServletResponse response) throws Exception{
        System.out.println("param : " + param);
		return "{\"isUnique\":true}";
	}

}
