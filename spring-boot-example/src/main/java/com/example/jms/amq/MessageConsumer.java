package com.example.jms.amq;

import org.springframework.jms.annotation.JmsListener;
import org.springframework.stereotype.Component;

@Component
public class MessageConsumer{

	@JmsListener(destination="queue://event", containerFactory="myFactory")
	public void processMessage(String message){
		System.out.println(message);
	}

}
