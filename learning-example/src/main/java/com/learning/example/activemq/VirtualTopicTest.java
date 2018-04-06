package com.learning.example.activemq;

import javax.jms.Connection;
import javax.jms.ConnectionFactory;
import javax.jms.DeliveryMode;
import javax.jms.Destination;
import javax.jms.Message;
import javax.jms.MessageConsumer;
import javax.jms.MessageListener;
import javax.jms.MessageProducer;
import javax.jms.Session;
import javax.jms.TextMessage;

import com.learning.example.AMQConstants;
import org.apache.activemq.ActiveMQConnectionFactory;

public class VirtualTopicTest implements MessageListener{
	private String FLAG = "";
	public VirtualTopicTest(String flag){
		this.FLAG = flag;
	}

	public static void main(String[] args) throws Exception {

		ConnectionFactory factory = new ActiveMQConnectionFactory(AMQConstants.CONNECTION_USER,
				AMQConstants.CONNECTION_PASSWORD, AMQConstants.CONNECTION_TCP_URL);
		
		Connection connection = factory.createConnection();
		connection.start();
		
		String queueNameA = "Consumer.test.VirtualTopic.order";
		Session sessionA = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);
		Destination queueA = sessionA.createQueue(queueNameA);
		MessageConsumer consumerA = sessionA.createConsumer(queueA);
		consumerA.setMessageListener(new VirtualTopicTest("listener A"));
				
		
		String queueNameB = "Consumer.test.VirtualTopic.order";
		Session sessionB = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);
		Destination queueB = sessionB.createQueue(queueNameB);
		MessageConsumer consumerB = sessionB.createConsumer(queueB);
		consumerB.setMessageListener(new VirtualTopicTest("listener B"));
		
		
		
		//send message
		Connection sendConnection = factory.createConnection();
		sendConnection.start();
		
		String virtualTopic = "VirtualTopic.order";
		Session session = sendConnection.createSession(false, Session.AUTO_ACKNOWLEDGE);
		Destination topic = session.createTopic(virtualTopic);
		MessageProducer producter = session.createProducer(topic);		
		producter.setDeliveryMode(DeliveryMode.PERSISTENT);
		
		for (int i = 0; i < 50; i++) {
			TextMessage mesage = session.createTextMessage();
			mesage.setText("VirtualTopic - " + i);
			producter.send(mesage);		
		}

		sendConnection.close();
	}

	@Override
	public void onMessage(Message arg0) {
		System.out.println(FLAG + " -> " + arg0);
	}
	
	

}
