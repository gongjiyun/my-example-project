package mytest.activemq;

import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.Session;

import org.springframework.jms.support.converter.MessageConversionException;

public class TestMessageConverter implements
		org.springframework.jms.support.converter.MessageConverter {

	public Object fromMessage(Message arg0) throws JMSException,
			MessageConversionException {
		System.out.println(arg0.getClass());
		return null;
	}

	public Message toMessage(Object arg0, Session arg1) throws JMSException,
			MessageConversionException {
		System.out.println(arg0.getClass());
		return null;
	}

}
