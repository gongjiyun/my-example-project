package com.example;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.ImportResource;

@SpringBootApplication // 可以代替@EnableAutoConfiguration@Configuration@ComponentScan
@EnableAutoConfiguration
@Configuration
@ComponentScan
@ImportResource(value="classpath:applicationContext.xml")
public class Application {
	
	public static void main(String[] args) {
		System.setProperty("spring.devtools.restart.enabled", "true");
		ConfigurableApplicationContext ctx = SpringApplication.run(Application.class, args);
	}

}
