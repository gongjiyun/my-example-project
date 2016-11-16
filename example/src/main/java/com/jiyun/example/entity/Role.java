package com.jiyun.example.entity;

import java.lang.Long;
import java.lang.String;
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


@Entity(name="role")
@Cache(usage = CacheConcurrencyStrategy.NONE)
@Inheritance(strategy=InheritanceType.JOINED)
@Table(name="PB_Role",catalog="",schema="")
public class Role implements Serializable{

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.TABLE,generator="roleid_gen")
	@TableGenerator(name="roleid_gen",table="PB_Classes_",pkColumnName="className",initialValue=1, valueColumnName="currentId",pkColumnValue="sg.ncs.digitalbanking.entity.Role",allocationSize=1)
	@Column(name="roleId", length=32)
	private Long roleId;

	@Column(name="name", length=100, columnDefinition="varchar(100)")
	private String name;

	@Column(name="description", length=255, columnDefinition="varchar(255)")
	private String description;

	@Column(name="displayOrder", length=1)
	private Long displayOrder;

	@Column(name="display", length=1)
	private Long display;


	public void setRoleId(Long roleId){
		this.roleId = roleId;
	}
	public Long getRoleId(){
		return this.roleId;
	}
	public void setName(String name){
		this.name = name;
	}
	public String getName(){
		return this.name;
	}
	public void setDescription(String description){
		this.description = description;
	}
	public String getDescription(){
		return this.description;
	}
	public void setDisplayOrder(Long displayOrder){
		this.displayOrder = displayOrder;
	}
	public Long getDisplayOrder(){
		return this.displayOrder;
	}
	public void setDisplay(Long display){
		this.display = display;
	}
	public Long getDisplay(){
		return this.display;
	}
}