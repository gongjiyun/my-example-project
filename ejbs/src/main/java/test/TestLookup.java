/**
This class add by Administrator
*/
package test;

import javax.sql.DataSource;
import com.poc.business.util.EJBFactory;

public class TestLookup {

	/**
	 * @param args
	 */
	public static void main(String[] args) throws Exception{
		DataSource ds = (DataSource) EJBFactory.getInstance().getCtx().lookup("jdbc/poc");
		System.out.println(ds);
	}

}
