package com.example.jms.amq;

import javax.jms.ConnectionFactory;
import javax.jms.JMSException;

import org.springframework.boot.autoconfigure.jms.DefaultJmsListenerContainerFactoryConfigurer;
import org.springframework.context.annotation.Bean;
import org.springframework.jms.config.DefaultJmsListenerContainerFactory;

//@Configuration
//@EnableJms
//@EnableAutoConfiguration
public class JmsConfiguration {

	@Bean
	public DefaultJmsListenerContainerFactory myFactory(ConnectionFactory connectionFactory, DefaultJmsListenerContainerFactoryConfigurer configurer) throws JMSException {
		//ConnectionFactory connectionFactory = new ActiveMQConnectionFactory("tcp://localhost:61616", "admin", "password");
		//connectionFactory.createConnection("admin", "password");
		
		DefaultJmsListenerContainerFactory factory = new DefaultJmsListenerContainerFactory();
		
		configurer.configure(factory, connectionFactory);
		
		System.out.println("myFactory connection...");
		return factory;
	}
}
