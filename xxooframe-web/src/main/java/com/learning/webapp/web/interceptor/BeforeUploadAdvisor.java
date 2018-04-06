/**
This class add by jiyun
 */
package com.learning.webapp.web.interceptor;

import java.lang.reflect.Method;

import org.springframework.aop.MethodBeforeAdvice;

public class BeforeUploadAdvisor implements MethodBeforeAdvice {

	public void before(Method arg0, Object[] arg1, Object arg2)
			throws Throwable {
		System.out.println("BeforeUploadAdvisor.before");
	}

}
