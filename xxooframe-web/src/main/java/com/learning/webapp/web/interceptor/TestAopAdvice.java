/**
This class add by jiyun
*/
package com.learning.webapp.web.interceptor;

import java.lang.reflect.Method;

import org.aspectj.lang.annotation.Aspect;
import org.springframework.aop.MethodBeforeAdvice;
import org.springframework.stereotype.Component;

@Aspect
public class TestAopAdvice implements MethodBeforeAdvice{

	public void before(Method arg0, Object[] arg1, Object arg2)
			throws Throwable {
		System.out.println("TestAopAdvice.method>"+arg0.getName());
		arg0.invoke(arg2, arg1);
	}
}
