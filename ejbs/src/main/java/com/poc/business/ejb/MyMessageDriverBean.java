/**
This class add by Administrator
 */
package com.poc.business.ejb;

import javax.ejb.EJBException;
import javax.ejb.MessageDrivenBean;
import javax.ejb.MessageDrivenContext;
import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.MessageListener;
import javax.jms.TextMessage;

public class MyMessageDriverBean implements MessageDrivenBean, MessageListener {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private MessageDrivenContext ctx = null;

	public void ejbCreate() throws EJBException {
		System.out.println("MyMessageDriverBean ejbCreate()");
	}

	public void ejbRemove() throws EJBException {
		System.out.println("MyMessageDriverBean ejbRemove()");
	}

	public void setMessageDrivenContext(MessageDrivenContext arg0)
			throws EJBException {
		this.ctx = arg0;
		System.out.println("MyMessageDriverBean setMessageDrivenContext()");
	}

	public void onMessage(Message message) {
		try {
			if (message instanceof TextMessage) {
				TextMessage msg = (TextMessage) message;
				System.out.println("get message > " + msg.getText());
			}
		} catch (JMSException e) {
			e.printStackTrace();
		}
		System.out.println("MyMessageDriverBean onMessage()");
	}

}
