package com.poc.web.taglibs;

import java.util.List;

import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.poc.common.model.WebMessage;
import com.poc.common.model.WebMessages;
import com.poc.utils.constants.PortalConstants;

/**
 ** Digital Banking Trends ¨C Banks¡¯ Goal and NCS Presence
 **/
public class CustomErrorsTag extends TagSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String message = null;

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public int doStartTag() throws JspTagException {
		return SKIP_BODY;
	}

	public int doEndTag() throws JspTagException {
		try {
			WebMessages webErrors = (WebMessages)pageContext.getRequest().getAttribute(PortalConstants.WEB_ERROR_KEY);
			if(webErrors!=null && webErrors.getErrors()!=null && webErrors.getErrors().size()>0){
				ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(pageContext.getSession().getServletContext());				
				List<WebMessage> errors = webErrors.getErrors();
				
				JspWriter out = pageContext.getOut();
				for(WebMessage err : errors){
					String message = context.getMessage(err.getMsgKey(), err.getArgs(), err.getMessage(), pageContext.getRequest().getLocale());
					if(message==null){
						message = err.getMessage();
					}
					
					boolean isError = err.isError();
					if(!isError){
						out.append("<div class=\"messages pagebanner\">");
						out.append("<font color=\"green\">" + message + "</font>");
						out.append("</div>");
					}else if (isError){
						out.append("<div class=\"errors pagebanner\">");
						out.append("<font color=\"red\">" + message + "</font>");
						out.append("</div>");
					}
				}

			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return EVAL_PAGE;

	}

	public void release() {
		super.release();
	}
}
