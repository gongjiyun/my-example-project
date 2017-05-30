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

import java.util.UUID;

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

import org.apache.activemq.ActiveMQConnectionFactory;

public class Publisher2 {
	
	private static boolean exit = false;

    public static void main(String[] args) throws Exception {

        final String TOPIC_PREFIX = "topic://";

        String user = env("ACTIVEMQ_USER", "admin");
        String password = env("ACTIVEMQ_PASSWORD", "password");
        String host = env("ACTIVEMQ_HOST", "localhost");
        int port = Integer.parseInt(env("ACTIVEMQ_PORT", "61616"));

        String connectionURI = "tcp://" + host + ":" + port;
        String destinationName = arg(args, 0, "queue://event");

        ConnectionFactory factory = new ActiveMQConnectionFactory(connectionURI);

        Connection connection = factory.createConnection(user, password);
        connection.start();

        Session session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);

        Destination destination = null;
        if (destinationName.startsWith(TOPIC_PREFIX)) {
            destination = session.createTopic(destinationName.substring(TOPIC_PREFIX.length()));
        } else {
            destination = session.createQueue(destinationName);
        }
        
        Destination tempDes = session.createTemporaryTopic();
        MessageConsumer tempCus = session.createConsumer(tempDes);
        tempCus.setMessageListener(new MessageListener() {
			@Override
			public void onMessage(Message arg0) {
				System.out.println("get reply message " + arg0);
				exit = true;
			}
		});

        MessageProducer producer = session.createProducer(destination);
        producer.setDeliveryMode(DeliveryMode.PERSISTENT);
        
        TextMessage replyTestMsg = session.createTextMessage();
        replyTestMsg.setJMSCorrelationID(UUID.randomUUID().toString());
        replyTestMsg.setJMSReplyTo(tempDes);
        replyTestMsg.setText("Reply me!");
        replyTestMsg.setIntProperty("flag", 1);
        producer.send(replyTestMsg);

        TextMessage shutdownCommand = session.createTextMessage("SHUTDOWN");
        shutdownCommand.setIntProperty("flag", 0);        
        producer.send(shutdownCommand);
        
        Thread.sleep(1000 * 3); //important for reply message from destination.
        
        connection.close();
    }

    private static String env(String key, String defaultValue) {
        String rc = System.getenv(key);
        if (rc == null)
            return defaultValue;
        return rc;
    }

    private static String arg(String[] args, int index, String defaultValue) {
        if (index < args.length)
            return args[index];
        else
            return defaultValue;
    }

}