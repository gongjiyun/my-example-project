package com.example.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HomeController {

	@RequestMapping(path="/welcome", method={RequestMethod.GET, RequestMethod.POST})
	public String welcome(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception{
		return "welcome";
	}
	
}
