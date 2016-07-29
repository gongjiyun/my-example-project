package com.poc.utils.util;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;

@Component
public class SpringAppContextHolder implements ApplicationContextAware{

	private static ApplicationContext context = null;
	
	@Override
	public void setApplicationContext(ApplicationContext arg0)
			throws BeansException {
		SpringAppContextHolder.context = arg0;
	}
	
	public static ApplicationContext get(){
		return SpringAppContextHolder.context;
	}
	
	public static ApplicationContext clear(){
		return SpringAppContextHolder.context = null;
	}

}
