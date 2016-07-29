package com.poc.utils.util;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 **Digital Banking Trends ¨C Banks¡¯ Goal and NCS Presence
 **/
public class PortalUtil {
	private final static Logger logger = LoggerFactory.getLogger(PortalUtil.class);
	
	public static String getSiteURL(HttpServletRequest request){
		try {
			if(request==null){
				return ResConfigUtil.getInstance().getString("digital.default.server.url");
			}
			
			String url = request.getRequestURL().toString();
			String uri = request.getRequestURI();
			int contextIndex = url.indexOf(uri);
			return url.substring(0, contextIndex) + "" + request.getContextPath() ;			
		} catch (Exception e) {
			logger.error("Error on get getPortalURL");
		}
		return "";
	}

}
