package com.learning.example.activemq.security;

import org.apache.activemq.broker.ConnectionContext;
import org.apache.activemq.command.Message;
import org.apache.activemq.security.MessageAuthorizationPolicy;

public class MyMessageAuthorizationPolicy implements MessageAuthorizationPolicy {

	@Override
	public boolean isAllowedToConsume(ConnectionContext context, Message arg1) {
		System.out.println(context.getConnection().getRemoteAddress());
		return true;
	}

}
