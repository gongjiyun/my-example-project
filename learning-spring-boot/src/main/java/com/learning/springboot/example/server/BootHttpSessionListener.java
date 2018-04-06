package com.learning.springboot.example.server;

import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.apache.log4j.Logger;

public class BootHttpSessionListener implements HttpSessionBindingListener, HttpSessionListener {
	private static final Logger _logger = Logger.getLogger(BootHttpSessionListener.class);
	
	@Override
	public void sessionCreated(HttpSessionEvent arg0) {
		_logger.debug(arg0.getSource());
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent arg0) {
		_logger.debug(arg0.getSource());
	}

	@Override
	public void valueBound(HttpSessionBindingEvent arg0) {
		_logger.debug(arg0.getSource());
	}

	@Override
	public void valueUnbound(HttpSessionBindingEvent arg0) {
		_logger.debug(arg0.getSource());
	}

}
