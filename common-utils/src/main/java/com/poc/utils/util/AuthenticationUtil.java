package com.poc.utils.util;

import javax.servlet.http.HttpServletRequest;

import com.poc.utils.constants.PortalConstants;

/**
 **Digital Banking Trends ¨C Banks¡¯ Goal and NCS Presence
 **/
public class AuthenticationUtil {

	public static String getUsername(HttpServletRequest request) throws Exception{
		String xToken = request.getHeader(PortalConstants.SECR_KEY_TOKEN);
		if(xToken==null || "".equals(xToken)){
			throw new Exception("xToken is null");
		}
		
		String originalString = PasswordEncoder.decrypt(xToken);
		String [] originalParams= originalString.split(";");
		String username = originalParams[0];
		String token = originalParams[1];
		String timestamp = originalParams[2];
		return username;
	}
	
	public static String getToken(HttpServletRequest request) throws Exception{
		String xToken = request.getHeader(PortalConstants.SECR_KEY_TOKEN);
		if(xToken==null || "".equals(xToken)){
			throw new Exception("xToken is null");
		}
		
		String originalString = PasswordEncoder.decrypt(xToken);
		String [] originalParams= originalString.split(";");
		String username = originalParams[0];
		String token = originalParams[1];
		String timestamp = originalParams[2];
		return token;
	}
	
}
