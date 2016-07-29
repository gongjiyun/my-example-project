package com.poc.web.http;

import org.apache.log4j.Logger;
import org.codehaus.xfire.MessageContext;
import org.codehaus.xfire.handler.AbstractHandler;

public class PocWSInvokeHandler extends AbstractHandler
{
	private static Logger logger=Logger.getLogger(PocWSInvokeHandler.class);
	public void invoke(MessageContext arg0) throws Exception {
		logger.debug("this is xfire handler");
	}

}
