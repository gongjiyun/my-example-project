package mytest.activemq;

import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.MessageListener;
import javax.jms.TextMessage;

public class TestMessageListener implements MessageListener{

	public void onMessage(Message arg0) {
		try {
			System.out.println("MQListener : " + ((TextMessage)arg0).getText());
		} catch (JMSException e) {
			e.printStackTrace();
		}
	}

}
