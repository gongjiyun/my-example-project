/**
This class add by Administrator
*/
package com.poc.business.ejb;

import java.io.Serializable;

public class PersonPK implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	public PersonPK(){
		
	}
	
	public PersonPK(String id){
		this.id = id;
	}
	private String id;

	public String getId() {
		return id;
	}
	public int hashCode(){
		return this.id.hashCode();
	}
	@Override
	public boolean equals(Object obj) {
		return id.equals(obj);
	}
}
