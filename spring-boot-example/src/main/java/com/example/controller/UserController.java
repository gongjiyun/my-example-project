package com.example.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.module.User;
import com.example.service.PersonService;

@Controller
public class ExampleController {
	
	@Autowired
	private PersonService personService;

	@RequestMapping(path="/person/list", method={RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public User hello(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception{
		return personService.findUserByUid("");
	}
	
}
