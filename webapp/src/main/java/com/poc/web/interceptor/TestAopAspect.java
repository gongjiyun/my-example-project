/**
This class add by jiyun
*/
package com.poc.web.interceptor;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;

@Aspect
public class TestAopAspect {
	@Before("execution(* com.poc.web.service.imp.*.*(..))")
	public void doBefore(JoinPoint point){
		System.out.println("TestAopAspect.doBefore");
		System.out.println("class>"+point.getClass().getName());
		System.out.println("target>"+point.getTarget());
		System.out.println("args>"+point.getArgs());
		System.out.println("sourceLocation>"+point.getSourceLocation());
	}
	
	@Pointcut("within(* com.poc.business.dao.imp..*")
	public void testPointcut(JoinPoint point){
		System.out.println("TestAopAspect.inteceptAll");
		System.out.println("class>"+point.getClass().getName());
		System.out.println("target>"+point.getTarget());
		System.out.println("args>"+point.getArgs());
		System.out.println("sourceLocation>"+point.getSourceLocation());
	}
	
	@AfterReturning("execution(* com.poc.web.service.imp..*(..))")
	public void afterAll(JoinPoint point){
		System.out.println("afterAll.inteceptAll");
		System.out.println("class>"+point.getClass().getName());
		System.out.println("target>"+point.getTarget());
		System.out.println("args>"+point.getArgs());
		System.out.println("sourceLocation>"+point.getSourceLocation());
	}	
	
	@Around("execution(* com.poc.web.service.imp..*(..))")
	public Object aroundAll(ProceedingJoinPoint point) throws Throwable{
		System.out.println("TestAopAspect.aroundAll");
		System.out.println("class>"+point.getClass().getName());
		System.out.println("target>"+point.getTarget());
		System.out.println("args>"+point.getArgs());
		System.out.println("sourceLocation>"+point.getSourceLocation());
		return point.proceed();
	}
}
