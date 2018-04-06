package mytest.spring;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class StandloneSpringFactory {
	private static ApplicationContext context = null;
	
	static{
		context = new ClassPathXmlApplicationContext("applicationContext-standlone.xml");
	}
	
	public static ApplicationContext getContext() throws Exception{
		if(context!=null){
			return context;
		}else{
			throw new Exception("Please check spring xml path");
		}
	}
}
