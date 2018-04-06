package com.learning.example.activemq;

import javax.jms.Connection;
import javax.jms.ConnectionFactory;
import javax.jms.MessageConsumer;
import javax.jms.Session;
import javax.jms.Topic;

import org.apache.activemq.ActiveMQConnectionFactory;
import org.apache.activemq.advisory.AdvisorySupport;
import org.apache.activemq.command.ActiveMQMessage;
import org.apache.activemq.command.ConnectionInfo;
import org.apache.activemq.command.DataStructure;
import org.apache.activemq.command.RemoveInfo;

public class AdvisoryMessageTest {

	public static void main(String[] args) throws Exception {
		String user = "admin";
		String password = "password";
		String host = "localhost";
		int port = Integer.parseInt("61616");

		String connectionURI = "tcp://" + host + ":" + port;

		ConnectionFactory factory = new ActiveMQConnectionFactory(connectionURI);

		Connection connection = factory.createConnection(user, password);
		connection.start();
		Session session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);

		Topic topic = AdvisorySupport.CONNECTION_ADVISORY_TOPIC;
		MessageConsumer cusumer = session.createConsumer(topic);

		ActiveMQMessage message = (ActiveMQMessage) cusumer.receive();

		DataStructure data = message.getDataStructure();
		
		if (data.getDataStructureType() == ConnectionInfo.DATA_STRUCTURE_TYPE) {
			ConnectionInfo connectionInfo = (ConnectionInfo) data;
			System.out.println("Connection started: " + connectionInfo);
		} else if (data.getDataStructureType() == RemoveInfo.DATA_STRUCTURE_TYPE) {
			RemoveInfo removeInfo = (RemoveInfo) data;
			System.out.println("Connection stopped: " + removeInfo.getObjectId());
		} else {
			System.err.println("Unknown message " + data);
		}

	}

}
