/**
This class add by jiyun
*/
package com.poc.web.interceptor;

import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;

@Aspect
public class AnnotationAspectTest {
	
	@Pointcut("execution(* com.poc.service.*.*(..))")
	public void aspectPoint(){
		System.out.println("MyAspect0.aspectPoint");
	}
	
	@Before("aspectPoint()")
	public void aspectOperator(){
		System.out.println("MyAspect0.doBefore");
	}
}
