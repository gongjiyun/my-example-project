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


@Entity(name="userGroup")
@Cache(usage = CacheConcurrencyStrategy.NONE)
@Inheritance(strategy=InheritanceType.JOINED)
@Table(name="UserGroup",catalog="",schema="")
public class UserGroup implements Serializable{

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.TABLE,generator="usergroupid_gen")
	@TableGenerator(name="usergroupid_gen",table="Classes_",pkColumnName="className",initialValue=1, valueColumnName="currentId",pkColumnValue="com.poc.common.entities.UserGroup",allocationSize=1)
	@Column(name="userGroupId", length=32)
	private Long userGroupId;

	@Column(name="uid")
	private Long uid;

	@Column(name="groupId")
	private Long groupId;


	public void setUserGroupId(Long userGroupId){
		this.userGroupId = userGroupId;
	}
	public Long getUserGroupId(){
		return this.userGroupId;
	}
	public void setUid(Long uid){
		this.uid = uid;
	}
	public Long getUid(){
		return this.uid;
	}
	public void setGroupId(Long groupId){
		this.groupId = groupId;
	}
	public Long getGroupId(){
		return this.groupId;
	}
}