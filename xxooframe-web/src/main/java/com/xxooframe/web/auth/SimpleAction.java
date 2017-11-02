/**
This class add by Administrator
*/
package com.xxooframe.web.auth;

import java.security.PrivilegedAction;

import javax.naming.Context;
import javax.sql.DataSource;
import javax.transaction.UserTransaction;
import com.xxooframe.business.util.EJBFactory;

public class SimpleAction implements PrivilegedAction{

	public Object run() {
		Context ctx = null;
		try{
			ctx = EJBFactory.getInstance().getCtx();
			
			UserTransaction trans = (UserTransaction) ctx.lookup("javax.transaction.UserTransaction");
			System.out.println("get transaction." + trans);
			DataSource ds = (DataSource) ctx.lookup("jdbc/xxooframe");
			System.out.println("get DataSource." + ds);
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}

}