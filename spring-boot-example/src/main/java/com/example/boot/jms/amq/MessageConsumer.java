package com.example.jms.amq;

import org.springframework.jms.annotation.JmsListener;

//@Component
public class MessageConsumer{

	@JmsListener(destination="queue://event", containerFactory="myFactory")
	public void processMessage(String message){
		System.out.println(message);
	}

}
