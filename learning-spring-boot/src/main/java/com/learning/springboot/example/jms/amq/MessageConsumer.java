package com.learning.springboot.example.jms.amq;

import org.springframework.jms.annotation.JmsListener;

public class MessageConsumer{

	@JmsListener(destination="queue://event", containerFactory="myFactory")
	public void processMessage(String message){
		System.out.println(message);
	}

}
