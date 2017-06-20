package com.example.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class ErrorController {
	
	@RequestMapping(path="/error", method={RequestMethod.GET, RequestMethod.POST})
	public String error(HttpServletRequest request, HttpServletResponse response, Model model){
		return "error";
	}

}
