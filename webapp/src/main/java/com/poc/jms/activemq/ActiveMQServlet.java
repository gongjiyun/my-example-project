package com.poc.jms.activemq;

import java.io.IOException;

import javax.jms.Connection;
import javax.jms.ConnectionFactory;
import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.MessageListener;
import javax.jms.Session;
import javax.jms.TextMessage;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.ApplicationContext;
import org.springframework.jms.core.JmsTemplate;
import org.springframework.jms.core.MessageCreator;
import org.springframework.web.context.support.WebApplicationContextUtils;

public class ActiveMQServlet extends HttpServlet implements MessageListener {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doPost(req, resp);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		HttpSession httpSession = req.getSession();
		ApplicationContext appCtx = WebApplicationContextUtils.getWebApplicationContext(httpSession.getServletContext());
		JmsTemplate jms = (JmsTemplate) appCtx.getBean("jmsTemplate");
		jms.send(new MessageCreator() {
			public Message createMessage(Session session) throws JMSException {
				System.out.println("create message");
				TextMessage message = session
						.createTextMessage("hello jms template");
				return message;
			}
		});
		
		
		req.getRequestDispatcher("index.jsp").forward(req, resp);		
	}
	public void onMessage(Message arg0) {
		System.out.println("MQServlet:MQ test:Start");

		System.out.println("MQServlet:MQ test:End");
	}

	@Override
	public void init(ServletConfig config) throws ServletException {
		try {			
			Context ctx = new InitialContext();
			ctx = (Context) ctx.lookup("java:comp/env");
			ConnectionFactory conFac = (ConnectionFactory) ctx
					.lookup("jms/FailoverConnectionFactory");
			Connection con = conFac.createConnection();
			
			System.out.println("Get JMS connection.");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
