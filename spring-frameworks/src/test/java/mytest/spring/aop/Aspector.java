package mytest.spring.aop;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;

@Aspect
@Component
public class Aspector {
	
	@Pointcut("execution(* mytest.service.*.*(..))")
    public void sleeppoint(){
		System.out.println("-----------------sleeppoint");
	}
    
    @Before("sleeppoint()")
    public void beforeProcess(JoinPoint jp){
        System.out.println("beforeProcess " + jp.toShortString());
    }
    
    @AfterReturning("sleeppoint()")
    public void afterProcess(JoinPoint jp){
        System.out.println("afterProcess " + jp.toShortString());
    }
    
    @Around("sleeppoint()")
    public void around(ProceedingJoinPoint pjp) throws Throwable{
        System.out.println("aroundProcess start");
        pjp.proceed();
        System.out.println("aroundProcess end");
    }
}
