package mytest.spring;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.beans.factory.config.BeanFactoryPostProcessor;
import org.springframework.beans.factory.config.ConfigurableListableBeanFactory;
import org.springframework.stereotype.Component;

@Component
public class MyBeanFactoryPostProcessor implements BeanFactoryPostProcessor {

	@Override
	public void postProcessBeanFactory(ConfigurableListableBeanFactory arg0)
			throws BeansException {
		System.out.println("MyBeanFactoryPostProcessor++++++");
		String names[] = arg0.getBeanDefinitionNames();
		for(String name : names){
			BeanDefinition bdf = arg0.getBeanDefinition(name);
			System.out.println(bdf.getBeanClassName());
		}
	}

}
