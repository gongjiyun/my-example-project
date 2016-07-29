package com.poc.web.auth;

import java.io.IOException;
import java.security.Principal;
import java.util.Map;

import javax.security.auth.Subject;
import javax.security.auth.callback.Callback;
import javax.security.auth.callback.CallbackHandler;
import javax.security.auth.callback.NameCallback;
import javax.security.auth.callback.PasswordCallback;
import javax.security.auth.callback.UnsupportedCallbackException;
import javax.security.auth.login.LoginException;
import javax.security.auth.spi.LoginModule;

import org.apache.log4j.Logger;

public class SampleLoginModule implements LoginModule {
	private static Logger logger=Logger.getLogger(SampleLoginModule.class);
	private boolean isAuthenticated = false;
	private CallbackHandler callbackHandler;
	private Subject subject;
	private Principal principal;

	public boolean abort() throws LoginException {
		return false;
	}

	public boolean commit() throws LoginException {
		if (isAuthenticated) {
			this.subject.getPrincipals().add(principal);
		} else {
			throw new LoginException("Authentication failure");
		}
		return isAuthenticated;
	}

	public void initialize(Subject arg0, CallbackHandler arg1,
			Map<String, ?> arg2, Map<String, ?> arg3) {
		this.subject = arg0;
		this.callbackHandler = arg1;
	}

	public boolean login() throws LoginException {
		try {
			logger.debug("jaas login.");
			NameCallback nameCallback = new NameCallback("username");
			PasswordCallback passwordCallback = new PasswordCallback("password", false);
			final Callback[] calls = new Callback[] {nameCallback, passwordCallback };

			callbackHandler.handle(calls);
			String username = nameCallback.getName();
			String password = String.valueOf(passwordCallback.getPassword());
			
			if (true) {
				principal = new SamplePrincipal(username);
				isAuthenticated = true;
			} else {
				throw new LoginException("user or password is wrong");
			}

		} catch (IOException e) {
			throw new LoginException("no such user");
		} catch (UnsupportedCallbackException e) {
			throw new LoginException("login failure");
		}
		return isAuthenticated;
	}

	public boolean logout() throws LoginException {
		this.subject.getPrincipals().remove(principal);
		this.principal = null;
		return true;
	}

}
