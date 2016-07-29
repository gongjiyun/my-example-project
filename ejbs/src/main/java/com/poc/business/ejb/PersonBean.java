/**
This class add by Administrator
*/
package com.poc.business.ejb;

import java.rmi.RemoteException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.ejb.EJBException;
import javax.ejb.EntityBean;
import javax.ejb.EntityContext;
import javax.ejb.RemoveException;

import com.poc.business.util.ConnectionUtil;
import com.poc.utils.constants.IConstants;

public class PersonBean implements EntityBean{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private EntityContext ctx = null;
	
	private String nric;
	private String name;
	private String email;
	
	public PersonPK ejbCreate(String id, String name){
		System.out.println("PersonBean ejbCreate()");
		this.nric = id;
		this.name = name;
		return new PersonPK(nric);
	}
	
	public void ejbPostCreate(String id, String name){
		Connection con = null;
		PreparedStatement ps = null;
		try{
			long key= 0;
			con = ConnectionUtil.getInstance().connection(IConstants.DATASOURCE_JNDI);
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
			ps.setString(2, id);
			ps.setString(3, name);
			ps.execute();
			ps.close();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			ConnectionUtil.getInstance().release(con);
		}
		System.out.println("PersonBean ejbPostCreate()");
	}
	
	public void ejbActivate() throws EJBException, RemoteException {
		System.out.println("PersonBean ejbActivate()");
	}

	public void ejbLoad() throws EJBException, RemoteException {
		PersonPK pk = (PersonPK) ctx.getPrimaryKey();
		Connection con = null;
		PreparedStatement ps = null;
		try{
			con = ConnectionUtil.getInstance().connection(IConstants.DATASOURCE_JNDI);
			ps = con.prepareStatement("select id, nric, name, gender, birth_dt, email from tb_persons where nric = ?");
			ps.setString(1, pk.getId());
			ps.execute();
			ResultSet rs = ps.getResultSet();
			if(rs!=null && rs.next()){
				this.nric = rs.getString("nric");
				this.name = rs.getString("name");
				this.email = rs.getString("email");
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			ConnectionUtil.getInstance().release(con);
		}
		System.out.println("PersonBean ejbLoad()");
	}

	public void ejbPassivate() throws EJBException, RemoteException {
		System.out.println("PersonBean ejbPassivate()");
	}

	public void ejbRemove() throws RemoveException, EJBException,
			RemoteException {
		System.out.println("PersonBean ejbRemove()");
	}

	public void ejbStore() throws EJBException, RemoteException {
		PersonPK pk = (PersonPK) ctx.getPrimaryKey();
		
		System.out.println("PersonBean ejbStore()" + pk.getId());
	}

	public void setEntityContext(EntityContext ctx) throws EJBException,
			RemoteException {
		this.ctx = ctx;
		System.out.println("PersonBean setEntityContext()");
	}

	public void unsetEntityContext() throws EJBException, RemoteException {
		this.ctx = null;
		System.out.println("PersonBean unsetEntityContext()");
	}

	public Collection ejbFindPersons() throws RemoteException{
		return null;
	}

	public Collection ejbFindPersonById(String id) throws RemoteException {
		System.out.println("PersonBean ejbFindPersonById()");
		List persons = new ArrayList();
		Connection con = null;
		PreparedStatement ps = null;
		try{
			con = ConnectionUtil.getInstance().connection(IConstants.DATASOURCE_JNDI);
			ps = con.prepareStatement("select id, nric, name, gender, birth_dt, email from tb_persons where nric = ?");
			ps.setString(1, id);
			ps.executeQuery();
			ResultSet rs = ps.getResultSet();
			while(rs.next()){
				PersonPK pk = new PersonPK(rs.getString("nric")); 
				persons.add(pk);
			}
			return persons;
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			ConnectionUtil.getInstance().release(con);
		}
		return null;
	}
	public PersonPK ejbFindByPrimaryKey(PersonPK id) throws RemoteException {
		System.out.println("PersonBean ejbFindByPrimaryKey()");
		return id;
	}
	
	public void updatePerson(String nric, String email, String birth, String gender) throws RemoteException{
		Connection con = null;
		PreparedStatement ps = null;
		try{
			//ctx.getUserTransaction().begin();
			//Entity bean transaction control by container, can not use ctx.getUserTransaction();
			
			long key= 0;
			con = ConnectionUtil.getInstance().connection(IConstants.DATASOURCE_JNDI);
			ps = con.prepareStatement("update tb_persons set email = ?, birth_dt = ?, gender = ? where nric = ?");
			ps.setString(1, email);
			ps.setString(2, birth);
			ps.setString(3, gender);			
			ps.setString(4, nric);
			ps.execute();
			System.out.println("PersonBean updated nric = " + nric);
			
			
			System.out.println("Copy nric = " + key);
			
			ps = con.prepareStatement("select max(id)+1 as id from tb_persons");
			ps.execute();
			ResultSet rs = ps.getResultSet();
			if(rs!=null && rs.next()){
				key = rs.getLong("id");
			}
			rs.close();
			
			ps = con.prepareStatement("insert into tb_persons(id, nric, name) values(?, ?, ?)");
			ps.setLong(1, key);
			ps.setString(2, this.getNric() + "_old");
			ps.setString(3, this.getName() + "_backup");
			ps.execute();			
			ps.close();

			//ctx.getUserTransaction().commit();
		}catch(Exception e){
			e.printStackTrace();			
			ctx.setRollbackOnly();
			System.out.println("PersonBean RollbackOnly");
			throw new RemoteException(e.getMessage());
		}finally{
			ConnectionUtil.getInstance().release(con);
		}
		System.out.println("PersonBean updatePerson()");
	}
	
	public String getNric(){
		return this.nric;
	}
	public void setNric(String nric){
		this.nric = nric;
	}
	public String getName(){
		return this.name;
	}
	public void setName(String name){
		this.name = name;
	}
	public String getEmail(){
		return this.email;
	}
	public void setEmail(String email){
		this.email = email;
	}
}
