/**
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.jiyun.example.activemq;

import javax.jms.Connection;
import javax.jms.ConnectionFactory;
import javax.jms.Destination;
import javax.jms.Message;
import javax.jms.MessageConsumer;
import javax.jms.MessageListener;
import javax.jms.Session;
import javax.jms.StreamMessage;

import org.apache.activemq.ActiveMQConnectionFactory;

import com.jiyun.example.AMQConstants;

public class Listener3 {

	public static void main(String[] args) throws Exception {

    	ConnectionFactory factory = new ActiveMQConnectionFactory(AMQConstants.CONNECTION_USER,
				AMQConstants.CONNECTION_PASSWORD, AMQConstants.CONNECTION_TCP_URL);
		
		Connection connection = factory.createConnection();
		connection.start();

        Session session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);

        Destination destination = session.createQueue("file.test?consumer.exclusive=true");

		MessageConsumer consumer = session.createConsumer(destination);

		System.out.println("Waiting for messages...");

		consumer.setMessageListener(new MyMessageListener(session));
	}
	
	private static class MyMessageListener implements MessageListener{

		private Session session;
		
		public MyMessageListener(Session session){
			this.session = session;
		}
		@Override
		public void onMessage(Message msg) {
			try {
				System.out.println(msg);
				if (msg instanceof StreamMessage) {
					StreamMessage message = (StreamMessage)msg;
					byte[] bte = new byte[1024];
					while(message.readBytes(bte)!=-1){
						System.out.println(new String(bte));
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
	}

}