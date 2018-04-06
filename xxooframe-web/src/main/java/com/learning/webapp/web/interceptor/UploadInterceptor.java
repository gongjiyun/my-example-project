/**
This class add by jiyun
*/
package com.learning.webapp.web.interceptor;

import org.aopalliance.intercept.MethodInterceptor;
import org.aopalliance.intercept.MethodInvocation;
import org.springframework.aop.BeforeAdvice;


public class UploadInterceptor implements MethodInterceptor, BeforeAdvice {

	public Object invoke(MethodInvocation arg0) throws Throwable {
		System.out.println("UploadInterceptor.MethodInterceptor");
		Object result = arg0.proceed();
		System.out.println("UploadInterceptor.BeforeAdvice");
		return  result;
	}

}
