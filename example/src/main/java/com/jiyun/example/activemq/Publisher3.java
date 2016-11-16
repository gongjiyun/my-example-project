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

import java.io.ByteArrayOutputStream;
import java.io.FileInputStream;
import java.io.InputStream;

import javax.jms.Connection;
import javax.jms.ConnectionFactory;
import javax.jms.DeliveryMode;
import javax.jms.Destination;
import javax.jms.MessageProducer;
import javax.jms.Session;
import javax.jms.StreamMessage;

import org.apache.activemq.ActiveMQConnectionFactory;

import com.jiyun.example.AMQConstants;

public class Publisher3 {

    public static void main(String[] args) throws Exception {

    	ConnectionFactory factory = new ActiveMQConnectionFactory(AMQConstants.CONNECTION_USER,
				AMQConstants.CONNECTION_PASSWORD, AMQConstants.CONNECTION_TCP_URL);
		
		Connection connection = factory.createConnection();
		connection.start();

        Session session = connection.createSession(true, Session.SESSION_TRANSACTED);

        Destination destination = session.createQueue("file.test??consumer.exclusive=true");

        MessageProducer producer = session.createProducer(destination);
        producer.setDeliveryMode(DeliveryMode.PERSISTENT);

       
        InputStream is = new FileInputStream("/Projects/OpenSource/example/src/main/java/com/jiyun/example/activemq/activemq.xml");
        byte[] bte = new byte[1024];
        ByteArrayOutputStream bos = new ByteArrayOutputStream();
        
        while(is.read(bte)!=-1){
        	bos.write(bte, 0, bte.length);
        }
        
        StreamMessage smsg = session.createStreamMessage();
        smsg.writeBytes(bos.toByteArray());
        producer.send(smsg);
        is.close();
        bos.close();
        session.commit();
        connection.close();
    }

}