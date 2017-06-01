package com.example.boot.server;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.boot.web.servlet.ServletComponentScan;

@ServletComponentScan
@WebFilter
public class BootFilter implements Filter {
	private static final Logger _logger = Logger.getLogger(BootFilter.class);
	
	@Override
	public void destroy() {
		System.out.println("destroy...");
	}

	@Override
	public void doFilter(ServletRequest arg0, ServletResponse arg1, FilterChain arg2)
			throws IOException, ServletException {
		try {
			HttpServletRequest request = (HttpServletRequest) arg1;
			HttpServletResponse response = (HttpServletResponse) arg2;
			_logger.debug("IP = " + request.getRemoteAddr());
			_logger.debug("URL = " + request.getRequestURL());
		}catch (Exception e) {
			e.printStackTrace();
		}
		arg2.doFilter(arg0, arg1);
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		System.out.println("init...");
	}

}
