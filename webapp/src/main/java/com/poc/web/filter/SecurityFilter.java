package com.poc.web.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.poc.web.constant.IConstant;

public class SecurityFilter implements Filter {
	private static Logger logger = Logger.getLogger(SecurityFilter.class);

	public void destroy() {
	}

	@Override
	public void doFilter(ServletRequest arg0, ServletResponse arg1,
			FilterChain arg2) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) arg0;
		HttpServletResponse response = (HttpServletResponse) arg1;

		HttpSession session = request.getSession();
		boolean login = false;
		if (session != null) {
			if (session.getAttribute(IConstant.SESSION_KEY_USER) != null) {
				arg2.doFilter(arg0, arg1);
			} else if (request.getRequestURL().toString().endsWith("/login")) {
				arg2.doFilter(arg0, arg1);
			} else {
				login = true;
			}
		} else {
			login = true;
		}

		String loginPage = request.getContextPath() + "/login";
		if (login) {
			logger.debug("session time out, forward to login.");
			response.sendRedirect(loginPage);
		}
	}

	public void init(FilterConfig arg0) throws ServletException {
		logger.debug("SecurityFilter.init");
	}

}
