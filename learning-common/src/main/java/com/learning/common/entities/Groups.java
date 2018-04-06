package com.learning.common.entities;

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


@Entity(name="groups")
@Cache(usage = CacheConcurrencyStrategy.NONE)
@Inheritance(strategy=InheritanceType.JOINED)
@Table(name="Groups",catalog="",schema="")
public class Groups implements Serializable{

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.TABLE,generator="groupsid_gen")
	@TableGenerator(name="groupsid_gen",table="Classes_",pkColumnName="className",initialValue=1, valueColumnName="currentId",pkColumnValue="com.learning.common.entities.Groups",allocationSize=1)
	@Column(name="groupId", length=32)
	private Long groupId;

	@Column(name="name", length=100, columnDefinition="varchar(100)")
	private String name;

	@Column(name="description", length=255, columnDefinition="varchar(255)")
	private String description;

	@Column(name="display")
	private Long display;


	public void setGroupId(Long groupId){
		this.groupId = groupId;
	}
	public Long getGroupId(){
		return this.groupId;
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
	public void setDisplay(Long display){
		this.display = display;
	}
	public Long getDisplay(){
		return this.display;
	}
}