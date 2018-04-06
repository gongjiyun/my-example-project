package com.learning.webapp.web.interceptor;

import org.springframework.ui.ModelMap;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.context.request.WebRequestInterceptor;

public class PortalInterceptor implements WebRequestInterceptor {
	public void afterCompletion(WebRequest arg0, Exception arg1)
			throws Exception {
		System.out.println("afterCompletion");
	}

	public void postHandle(WebRequest arg0, ModelMap arg1) throws Exception {
		System.out.println("postHandle");
	}

	public void preHandle(WebRequest arg0) throws Exception {
		System.out.println("preHandle");
	}

}
