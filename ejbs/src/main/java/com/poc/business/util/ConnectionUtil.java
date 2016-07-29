/**
This class add by Administrator
*/
package com.poc.business.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ConnectionUtil {
	private static ConnectionUtil util = null;
	private static String url = null;
	private static String driver = null;
	private static String user = null;
	private static String passwd = null;
	static{
		url = "jdbc:mysql://192.168.245.131:3306/test";
		driver = "com.mysql.jdbc.Driver";
		user = "test";
		passwd = "test";
	}
	public static ConnectionUtil getInstance(){
		if(util==null){
			util = new ConnectionUtil();
		}
		return util;
	}
	
	public Connection connection(String jndi){
		Context weblogicCtx = null;
		Connection connection = null;
		try{
			weblogicCtx = new InitialContext();
			DataSource ds = (DataSource)weblogicCtx.lookup("java:comp/env/" + jndi);
			connection = ds.getConnection();
		}catch(Exception e1){
			try{
				DataSource ds = (DataSource)weblogicCtx.lookup(jndi);
				connection = ds.getConnection();
			}catch (Exception e2){
				e2.printStackTrace();
			}
		}
		return connection;

	}
	
	public Connection connection(){
		Connection con = null;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,user,passwd);
			return con;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public void release(Connection con){
		try{
			con.close();
			con = null;
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static void main(String[] args) {
		for(int i=0;i<10;i++){
			Connection con = null;
			PreparedStatement ps = null;
			try{
				long key= 0;
				con = ConnectionUtil.getInstance().connection();
				ps = con.prepareStatement("select max(id)+1 as id from tb_persons");
				ps.execute();
				ResultSet rs = ps.getResultSet();
				if(rs!=null && rs.next()){
					key = rs.getLong("id");
				}
				rs.close();
				ps.close();
				
				ps = con.prepareStatement("insert into tb_persons(id, nric, name) values(?, ?, ?)");
				ps.setLong(1, key);
				ps.setString(2, "S12345678F");
				ps.setString(3, "test");
				System.out.println("insert into tb_persons(id, nric, name) values(?, ?, ?)");
				ps.execute();
				ps.close();
			}catch(Exception e){
				e.printStackTrace();
			}finally{
				ConnectionUtil.getInstance().release(con);
			}
		}

	}
}
