package com.poc.web.auth;

import javax.security.auth.Subject;
import javax.security.auth.login.LoginContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LoginManager {
	public static boolean login(HttpServletRequest request, HttpServletResponse response){
		try{
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			String url = "";
			LoginContext ctx = new LoginContext("Sample",new com.poc.web.auth.SampleCallbackHandler(username,password,url));
			ctx.login();
			
			Subject sub = ctx.getSubject();
			if(sub!=null){
				SimpleAction action = new SimpleAction();
				Subject.doAs(sub, action);				
			}
			return true;
		}catch(Exception e){
			e.printStackTrace();
			return false;
		}
	}
}
