/**
This class add by Administrator
*/
package com.poc.business.util;

import java.lang.reflect.Method;
import java.util.Hashtable;

import javax.ejb.EJBHome;
import javax.naming.Context;
import javax.naming.InitialContext;

public class EJBFactory {
	public static final String context_fac = "weblogic.jndi.WLInitialContextFactory";
	public static final String url = "t3://localhost:7102";
	public static final String user = "weblogic";
	public static final String password = "weblogic";
	
	private static EJBFactory factory = null;
	private static Context ctx = null;
	private EJBFactory() throws Exception{
		Hashtable<String, String> env = new Hashtable<String, String>();
		env.put(Context.INITIAL_CONTEXT_FACTORY, context_fac);
	    env.put(Context.PROVIDER_URL, url);
		
		//env.put(Context.SECURITY_PRINCIPAL, user);
		//env.put(Context.SECURITY_CREDENTIALS, password);
	
		ctx = new InitialContext(env);
	}
	
	public static EJBFactory getInstance() throws Exception{
		if(factory == null){
			factory = new EJBFactory();
		}
		return factory;
	}
	
	public Context getCtx() throws Exception{
		if(ctx == null){
			ctx = new InitialContext();
		}
		return ctx;
	}
	
	/**
	 * Get remote by EJB home.
	 * @param home
	 * @return
	 * @throws Exception
	 */
	public Object getObject(Class clazz, Object[] arguments, String jndi) throws Exception{
		Object ejbObj = null;
		Object ejbHome = null;
		Method ejbCeate = null;
		
		ejbHome = this.lookupHome(clazz, jndi);
		
		if(ejbHome instanceof EJBHome){
			Method methods[] = ejbHome.getClass().getMethods();
			for(Method m: methods){
				if(m.getName().equalsIgnoreCase("create")){
					ejbCeate = m;
				}
			}
			System.out.println("create method > " + ejbCeate.getName());
			ejbObj = ejbCeate.invoke(ejbHome, arguments);
		}else{
			throw new Exception("Can not find EJB object, need EJB home.");
		}

		return ejbObj;
	}
	
	public Object lookupHome(Class home, String jndi) throws Exception{
		System.out.println("getRemoteHome : " + home.getClass() + " | JNDI : " + jndi);
		//ctx = (Context) ctx.lookup("java:comp/env/");
		Object o = ctx.lookup(jndi);
		Object ejbHome = javax.rmi.PortableRemoteObject.narrow(o, home);
		return ejbHome;
	}
}
