package com.poc.common.entities;

import java.lang.Long;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import java.io.Serializable;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.GenerationType;
import javax.persistence.TableGenerator;


@Entity(name="userRole")
@Cache(usage = CacheConcurrencyStrategy.NONE)
@Inheritance(strategy=InheritanceType.JOINED)
@Table(name="UserRole",catalog="",schema="")
public class UserRole implements Serializable{

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.TABLE,generator="userroleid_gen")
	@TableGenerator(name="userroleid_gen",table="Classes_",pkColumnName="className",initialValue=1, valueColumnName="currentId",pkColumnValue="com.poc.common.entities.UserRole",allocationSize=1)
	@Column(name="userRoleId", length=32)
	private Long userRoleId;

	@Column(name="uid")
	private Long uid;

	@Column(name="roleId")
	private Long roleId;


	public void setUserRoleId(Long userRoleId){
		this.userRoleId = userRoleId;
	}
	public Long getUserRoleId(){
		return this.userRoleId;
	}
	public void setUid(Long uid){
		this.uid = uid;
	}
	public Long getUid(){
		return this.uid;
	}
	public void setRoleId(Long roleId){
		this.roleId = roleId;
	}
	public Long getRoleId(){
		return this.roleId;
	}
}