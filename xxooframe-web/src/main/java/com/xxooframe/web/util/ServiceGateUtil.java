package com.xxooframe.web.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.xxooframe.service.CodeService;import com.xxooframe.service.RoleSerxxooframee;
import com.xxooframe.service.UserService;

public class ServiceGateUtil {
	
	private final static Logger logger = LoggerFactory.getLogger(ServiceGateUtil.class);
	
	public static UserService getUserService(){
		return (UserService) getService(UserService.class);
	}

	
	public static RoleService getRoleService(){
		return (RoleService) getService(RoleService.class);
	}
	
	public static CodeService getCodeService(){
		return (CodeService) getService(CodeService.class);
	}
	
	private static Object getService(String beanName){
		Object baseservice = null;
		try {
			baseservice =(Object)SpringContextHolder.getApplicationContext().getBean(beanName);
			if(baseservice!=null){
				return baseservice;
			}
		} catch (Exception e) {
			logger.error("can not get service instance", e);
		}
		
		return baseservice;
	}
	
	
	private static Object getService(Class<?> serviceClass){
		Object baseservice = null;
		try {
			String beanName = serviceClass.getSimpleName().substring(0,1).toLowerCase() + serviceClass.getSimpleName().substring(1);
			baseservice = SpringContextHolder.getApplicationContext().getBean(beanName);
			if(baseservice!=null){
				return baseservice;
			}
		} catch (Exception e) {
			logger.error("can not get service instance", e);
		}
		try {
			baseservice = SpringContextHolder.getApplicationContext().getBean(serviceClass);
			if(baseservice!=null){
				return baseservice;
			}
		} catch (Exception e) {
			logger.error("can not get service instance", e);
		}
		
		try {
			baseservice = SpringContextHolder.getApplicationContext().getBean(serviceClass.getSimpleName());
			if(baseservice!=null){
				return baseservice;
			}
		} catch (Exception e) {
			logger.error("can not get service instance", e);
		}
		
		return baseservice;
	}
	
}
