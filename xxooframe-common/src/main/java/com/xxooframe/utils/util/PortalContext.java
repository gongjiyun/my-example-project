package com.xxooframe.utils.util;

import javax.servlet.http.HttpServletRequest;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;


/**
 **Digital Banking Trends ¨C Banks¡¯ Goal and NCS Presence
 **/
public class PortalContext {
	
	private ApplicationContext context = null;
	private HttpServletRequest request = null;
	
	public PortalContext(HttpServletRequest request){
		this.request = request;
		this.context = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
	}
	
	public PortalContext(ApplicationContext context){
		this.context = context;
	}
	
	public PortalContext(){
		
	}
	
}
