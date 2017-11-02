package com.xxooframe.web.http;

import org.apache.log4j.Logger;
import org.codehaus.xfire.MessageContext;
import org.codehaus.xfire.handler.AbstractHandler;

public class xxooframeWSInvokeHandler extends AbstractHandler
{
	private static Logger logger=Logger.getLogger(xxooframeWSInvokeHandler.class);
	public void invoke(MessageContext arg0) throws Exception {
		logger.debug("this is xfire handler");
	}

}
