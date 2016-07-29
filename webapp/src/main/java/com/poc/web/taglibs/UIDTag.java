package com.poc.web.taglibs;

import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import com.poc.common.entities.User;
import com.poc.web.util.ServiceGateUtil;

/**
 ** Digital Banking Trends ¨C Banks¡¯ Goal and NCS Presence
 **/
public class UIDTag extends TagSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String uid = null;

	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

	public int doStartTag() throws JspTagException {
		return SKIP_BODY;
	}

	public int doEndTag() throws JspTagException {
		try {
			JspWriter out = pageContext.getOut();
			
			long uidc = Long.valueOf(this.uid);
			User user = ServiceGateUtil.getUserService().findUserById(uidc);
			if(user!=null){
				out.append(user.getUsername());
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
