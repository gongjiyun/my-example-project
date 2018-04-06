package com.learning.webapp.web.util;

import javax.jms.Connection;
import javax.jms.ConnectionFactory;
import javax.jms.DeliveryMode;
import javax.jms.Destination;
import javax.jms.JMSException;
import javax.jms.MessageProducer;
import javax.jms.Session;
import javax.jms.TextMessage;

import org.apache.activemq.ActiveMQConnectionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.learning.utils.util.ResConfigUtil;

public class PublishExtUtil {
	private final static Logger logger = LoggerFactory.getLogger(PublishExtUtil.class);
	private static PublishExtUtil instance = new PublishExtUtil();

	private PublishExtUtil(){
		
	}
	
	public static PublishExtUtil instance(){
		return instance;
	}
	
	public void publishQueue(String ...message) throws Exception{
		
	    Connection connection =null;
		try{
			logger.info("send message start");
		    connection = getConnection();
		    connection.start();
		    
		    Session session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);
		    Destination destination = session.createQueue("queue://digitalQueue");
		    MessageProducer producer = session.createProducer(destination);
		    producer.setDeliveryMode(DeliveryMode.PERSISTENT);
		    
		    if(message!=null && message.length>0){
		    	for(int i=0; i<message.length; i++){
		    		TextMessage tmsg = session.createTextMessage();
		    		tmsg.setText(message[i]);
		    		producer.send(tmsg);
		    	}
		    }
		    
		    session.close();
		    logger.info("send message end");
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(connection!=null){
				connection.close();
			}			
		}

	}
	
	public void publishTopic(String ...message) throws Exception{
		
	    Connection connection =null;
		try{
			logger.info("send message start");
		    connection = getConnection();
		    connection.start();
		    
		    Session session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);
		    Destination destination = session.createQueue("topic://digitalQueue");
		    MessageProducer producer = session.createProducer(destination);
		    producer.setDeliveryMode(DeliveryMode.NON_PERSISTENT);
		    
		    if(message!=null && message.length>0){
		    	for(int i=0; i<message.length; i++){
		    		TextMessage tmsg = session.createTextMessage();
		    		tmsg.setText(message[i]);
		    		producer.send(tmsg);
		    	}
		    }
		    
		    session.close();
		    logger.info("send message end");
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(connection!=null){
				connection.close();
			}			
		}

	}
	
	private Connection getConnection() throws JMSException{
		String user = env("ACTIVEMQ_USER", ResConfigUtil.getInstance().getString("activemq.connection.username"));
	    String password = env("ACTIVEMQ_PASSWORD", ResConfigUtil.getInstance().getString("activemq.connection.password"));
	    String host = env("ACTIVEMQ_HOST", ResConfigUtil.getInstance().getString("activemq.connection.url"));
	    int port = Integer.parseInt(env("ACTIVEMQ_PORT", ResConfigUtil.getInstance().getString("activemq.connection.port")));
	    
	    ConnectionFactory factory = new ActiveMQConnectionFactory(host + ":" + port);
	    Connection connection = factory.createConnection(user, password);
	    return connection;
	}
	
    private static String env(String key, String defaultValue) {
        String rc = System.getenv(key);
        if (rc == null)
            return defaultValue;
        return rc;
    }
}
