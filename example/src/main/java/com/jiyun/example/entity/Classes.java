package com.jiyun.example.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.GenericGenerator;

@Entity(name="classes")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
@Table(name="PB_Classes_",catalog="",schema="")
public class Classes{

	@Id
	@GeneratedValue(generator = "classesidgenerate") 
	@GenericGenerator(name="classesidgenerate",strategy="uuid")
	@Column(name="classNameId")
	private String classNameId;	
	
	@Column(name="className", unique=true)
	private String className;	

	@Column(name="currentId")
	private Long currentId;


	public String getClassNameId() {
		return classNameId;
	}

	public void setClassNameId(String classNameId) {
		this.classNameId = classNameId;
	}

	public String getClassName() {
		return className;
	}

	public void setClassName(String className) {
		this.className = className;
	}

	public Long getCurrentId() {
		return currentId;
	}

	public void setCurrentId(Long currentId) {
		this.currentId = currentId;
	}
}
