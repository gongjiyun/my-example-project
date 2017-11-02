package com.xxooframe.web.auth;

import java.io.IOException;

import javax.security.auth.callback.Callback;
import javax.security.auth.callback.CallbackHandler;
import javax.security.auth.callback.NameCallback;
import javax.security.auth.callback.PasswordCallback;
import javax.security.auth.callback.UnsupportedCallbackException;

import org.apache.log4j.Logger;

public class SampleCallbackHandler implements CallbackHandler{
	private static Logger logger=Logger.getLogger(SampleCallbackHandler.class);
	private String username = null;
	private String password = null;
	private String url = null;
	
	public SampleCallbackHandler(String username, String password, String url){
		this.username = username;
		this.password = password;
		this.url = url;
	}
	
	public void handle(Callback[] arg0) throws IOException, UnsupportedCallbackException {
		for(int i=0; i<arg0.length; i++){
			if(arg0[i] instanceof NameCallback){
				NameCallback ncb = (NameCallback)arg0[i];
				ncb.setName(this.username);
			}
			
			if(arg0[i] instanceof PasswordCallback){
				PasswordCallback ncb = (PasswordCallback)arg0[i];
				ncb.setPassword(this.password.toCharArray());
			}
		}
		logger.debug("handle jaas.");
	}

}
