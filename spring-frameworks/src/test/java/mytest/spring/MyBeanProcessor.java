package mytest.spring;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.config.BeanPostProcessor;

public class MyBeanProcessor implements BeanPostProcessor {

	public Object postProcessAfterInitialization(Object arg0, String arg1)
			throws BeansException {
		System.out.println("After process of " + arg1 + "-" + arg0.getClass());
		return arg0;
	}
	public Object postProcessBeforeInitialization(Object arg0, String arg1)
			throws BeansException {
		System.out.println("Begin process of " + arg1 + "-" + arg0.getClass());
		return arg0;
	}

}
