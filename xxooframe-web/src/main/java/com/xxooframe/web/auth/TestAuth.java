/**
This class add by jiyun
*/
package com.xxooframe.web.auth;

import javax.security.auth.Subject;
import javax.security.auth.login.LoginContext;

import com.xxooframe.business.util.EJBFactory;
public class TestAuth {
	
	public static void main(String[] args) {
		try{
			String username = EJBFactory.user;
			String password = EJBFactory.password;
			String url = EJBFactory.url;
			LoginContext loginctx = new LoginContext("Sample",new SampleCallbackHandler(username,password,url));
			loginctx.login();
			
			Subject sub = loginctx.getSubject();
			if(sub!=null){
				SimpleAction action = new SimpleAction();
				Subject.doAs(sub, action);			
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}

}
